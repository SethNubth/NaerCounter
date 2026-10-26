-- NaerCounter – Tracking.lua FINAL FIX
-- WotLK 3.3.5a 30300 Naerzone - Anti-fragil idioma

local _, NS = ...
local Tracking = {}
NS.Tracking = Tracking

local herbIndex, mineralIndex
local tickerFrame = nil
local tickerElapsed = 0

local GetNumTracking = (C_Minimap and C_Minimap.GetNumTrackingTypes) or GetNumTrackingTypes
local SetTrackingFn  = (C_Minimap and C_Minimap.SetTracking) or SetTracking
local useCMinimap    = C_Minimap and C_Minimap.GetTrackingInfo and true or false

local function GetTrackingInfoCompat(index)
    if useCMinimap then
        local info = C_Minimap.GetTrackingInfo(index)
        if info then return info.name, info.texture, info.active end
        return nil
    else
        return GetTrackingInfo(index)
    end
end

local function NewTickerCompat(interval, callback)
    if C_Timer and C_Timer.NewTicker then return C_Timer.NewTicker(interval, callback) end
    if tickerFrame then tickerFrame:SetScript("OnUpdate", nil) end
    tickerFrame = tickerFrame or CreateFrame("Frame")
    tickerElapsed = 0
    tickerFrame:SetScript("OnUpdate", function(self, elapsed)
        tickerElapsed = tickerElapsed + elapsed
        if tickerElapsed >= interval then tickerElapsed=0 callback() end
    end)
    return { Cancel = function() if tickerFrame then tickerFrame:SetScript("OnUpdate", nil) end tickerElapsed=0 end }
end

local function AfterCompat(delay, callback)
    if C_Timer and C_Timer.After then C_Timer.After(delay, callback)
    else
        local f=CreateFrame("Frame") local elapsed=0
        f:SetScript("OnUpdate", function(self, e) elapsed=elapsed+e if elapsed>=delay then self:SetScript("OnUpdate",nil) callback() end end)
    end
end

-- FIX Copilot punto 5: Lowercase + contains, no exact match
local function IsHerb(name)
    if not name then return false end
    local l=name:lower()
    return l:find("herb") or l:find("hierba") or l:find("kräuter") or l:find("herbe")
end
local function IsMineral(name)
    if not name then return false end
    local l=name:lower()
    return l:find("mineral") or l:find("mena") or l:find("gisement") or l:find("erz")
end

function Tracking:ScanTrackingTypes()
    herbIndex, mineralIndex = nil, nil
    if not GetNumTracking then return end
    local num = GetNumTracking()
    if not num then return end
    for i=1,num do
        local name = GetTrackingInfoCompat(i)
        if name then
            if IsHerb(name) then herbIndex=i
            elseif IsMineral(name) then mineralIndex=i end
        end
    end
end

function Tracking:EnableHerbTracking()
    self:ScanTrackingTypes()
    if SetTrackingFn then
        if mineralIndex then pcall(SetTrackingFn, mineralIndex, false) end
        if herbIndex then pcall(SetTrackingFn, herbIndex, true) end
    end
end

function Tracking:EnableMineralTracking()
    self:ScanTrackingTypes()
    if SetTrackingFn then
        if herbIndex then pcall(SetTrackingFn, herbIndex, false) end
        if mineralIndex then pcall(SetTrackingFn, mineralIndex, true) end
    end
end

function Tracking:GetActiveTracking()
    local herbOn,minOn=false,false
    if herbIndex then local _,_,active=GetTrackingInfoCompat(herbIndex) herbOn=active end
    if mineralIndex then local _,_,active=GetTrackingInfoCompat(mineralIndex) minOn=active end
    if herbOn and minOn then return "both" end
    if herbOn then return "herbs" end
    if minOn then return "minerals" end
    return "none"
end

local autoState="herbs"
local ticker=nil

function Tracking:ApplyMode(mode)
    mode=mode or (NS.db and NS.db.settings.trackingMode) or "auto"
    if ticker then ticker:Cancel() ticker=nil end
    if mode=="herbs" then self:EnableHerbTracking()
    elseif mode=="minerals" then self:EnableMineralTracking()
    elseif mode=="auto" then
        self:ScanTrackingTypes()
        if herbIndex and mineralIndex then
            autoState="herbs" self:EnableHerbTracking()
            local interval=(NS.db and NS.db.settings.timerInterval) or 10
            ticker=NewTickerCompat(interval, function()
                if autoState=="herbs" then autoState="minerals" Tracking:EnableMineralTracking()
                else autoState="herbs" Tracking:EnableHerbTracking() end
                if NS.FireCallback then NS:FireCallback("TRACKING_SWITCHED", autoState) end
            end)
        elseif herbIndex then autoState="herbs" self:EnableHerbTracking()
        elseif mineralIndex then autoState="minerals" self:EnableMineralTracking() end
    end
    if NS.FireCallback then NS:FireCallback("TRACKING_APPLIED", mode, autoState) end
end

function Tracking:CycleMode()
    if not NS.db then return end
    local cur=NS.db.settings.trackingMode
    local nextMode=cur=="herbs" and "minerals" or cur=="minerals" and "auto" or "herbs"
    NS.db.settings.trackingMode=nextMode
    if NS.FireCallback then NS:FireCallback("TRACKING_MODE_CHANGED", nextMode) end
    local labels={herbs="Solo Hierbas", minerals="Solo Mena", auto="Auto-Cambio"}
    print("|cff00ccffNaerCounter:|r Modo: |cffffcc00"..(labels[nextMode] or nextMode).."|r")
end

function Tracking:UpdateInterval(newInterval)
    if NS.db then NS.db.settings.timerInterval=newInterval end
    if NS.db and NS.db.settings.trackingMode=="auto" then self:ApplyMode("auto") end
end

function Tracking:GetAutoState() return autoState end
function Tracking:HasTrackingTypes() self:ScanTrackingTypes() return herbIndex~=nil, mineralIndex~=nil end

local initFrame=CreateFrame("Frame")
local pausedByCombat=false
initFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
initFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
initFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
initFrame:SetScript("OnEvent", function(self, event)
    if event=="PLAYER_ENTERING_WORLD" then AfterCompat(1, function() Tracking:ScanTrackingTypes() Tracking:ApplyMode() end)
    elseif event=="PLAYER_REGEN_DISABLED" then if ticker then ticker:Cancel() ticker=nil pausedByCombat=true end
    elseif event=="PLAYER_REGEN_ENABLED" then if pausedByCombat then pausedByCombat=false AfterCompat(1, function() if not InCombatLockdown() then Tracking:ApplyMode() end end) end end
end)

if NS.RegisterCallback then
    NS:RegisterCallback("ADDON_LOADED", function() Tracking:ScanTrackingTypes() AfterCompat(1, function() Tracking:ScanTrackingTypes() Tracking:ApplyMode() end) end)
    NS:RegisterCallback("TRACKING_MODE_CHANGED", function(mode) Tracking:ApplyMode(mode) end)
end
