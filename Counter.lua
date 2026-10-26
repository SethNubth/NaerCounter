-- NaerCounter – Counter.lua
-- WotLK 3.3.5a 30300 Naerzone Edition - FIXED FINAL

local _, NS = ...

local Counter = {}
NS.Counter = Counter

local function EnsureDB()
    NS.db = NS.db or {}
    NS.db.herbs = NS.db.herbs or {}
    NS.db.ores = NS.db.ores or {}
    NS.db.session = NS.db.session or { herbs = {}, ores = {} }
    NS.db.objectives = NS.db.objectives or {}
    NS.db.settings = NS.db.settings or {
        trackingMode = "auto",
        timerInterval = 10,
        skillCapWarning = true,
        minimapPos = 220,
    }
end

local HERB_SPELL_IDS = { [2366]=true, [2368]=true, [35717]=true }
local MINING_SPELL_IDS = { [2575]=true, [2576]=true, [3569]=true }
local pendingGather = nil

local function GetBagNumSlots(bag) return GetContainerNumSlots(bag) end
local function GetBagItemInfo(bag, slot)
    local link = GetContainerItemLink(bag, slot)
    if not link then return nil end
    local _, count = GetContainerItemInfo(bag, slot)
    local itemID = tonumber(link:match("item:(%d+)"))
    return itemID, count
end

function Counter:GetData(categoryFilter)
    EnsureDB()
    local function BuildList(kind)
        local source = NS.db[kind] or {}
        local list = {}
        for nodeName, entry in pairs(source) do
            list[#list+1] = { name=nodeName, count=tonumber(entry.count) or 0, zones=entry.zones or {} }
        end
        table.sort(list, function(a,b) return a.count > b.count end)
        return list
    end
    local data = { herbs=BuildList("herbs"), minerals=BuildList("ores") }
    if categoryFilter=="herbs" then return data.herbs end
    if categoryFilter=="minerals" then return data.minerals end
    return data
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_SPELLCAST_SENT")
frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
frame:RegisterEvent("UNIT_SPELLCAST_FAILED")
frame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
frame:RegisterEvent("CHAT_MSG_SKILL")
frame:RegisterEvent("SKILL_LINES_CHANGED")
frame:RegisterEvent("BAG_UPDATE")

local bagScanPending = false
local function OnEvent(self, event, ...)
    if event=="UNIT_SPELLCAST_SENT" then Counter:OnSpellcastSent(...)
    elseif event=="UNIT_SPELLCAST_SUCCEEDED" then Counter:OnSpellcastSucceeded(...)
    elseif event=="UNIT_SPELLCAST_FAILED" or event=="UNIT_SPELLCAST_INTERRUPTED" then Counter:OnSpellcastFailed(...)
    elseif event=="CHAT_MSG_SKILL" or event=="SKILL_LINES_CHANGED" then Counter:CheckSkillCap() Counter:UpdateSkillData()
    elseif event=="BAG_UPDATE" then
        if not bagScanPending then
            bagScanPending = true
            local f = CreateFrame("Frame")
            local t=0
            f:SetScript("OnUpdate", function(self, elapsed)
                t=t+elapsed
                if t>=0.3 then self:SetScript("OnUpdate",nil) bagScanPending=false Counter:ScanBags() end
            end)
        end
    end
end
frame:SetScript("OnEvent", OnEvent)

function Counter:OnSpellcastSent(unit, target, castGUID, spellID)
    if unit~="player" then return end
    if HERB_SPELL_IDS[spellID] then pendingGather={category="herbs", nodeName=target or "Unknown", spellID=spellID}
    elseif MINING_SPELL_IDS[spellID] then pendingGather={category="ores", nodeName=target or "Unknown", spellID=spellID} end
end

function Counter:OnSpellcastSucceeded(unit, castGUID, spellID)
    if unit~="player" or not pendingGather then return end
    local isMatch=false
    if pendingGather.category=="herbs" and HERB_SPELL_IDS[spellID] then isMatch=true
    elseif pendingGather.category=="ores" and MINING_SPELL_IDS[spellID] then isMatch=true end
    if not isMatch then return end
    self:RecordGather(pendingGather.category, pendingGather.nodeName)
    pendingGather=nil
end

function Counter:OnSpellcastFailed(unit) if unit=="player" then pendingGather=nil end end

function Counter:RecordGather(category, nodeName)
    EnsureDB()
    local zone = GetRealZoneText() or "Unknown"
    local store = NS.db[category]
    if not store then store={} NS.db[category]=store end
    if not store[nodeName] then store[nodeName]={count=0, zones={}} end
    local entry=store[nodeName]
    entry.count=entry.count+1
    entry.zones[zone]=(entry.zones[zone] or 0)+1
    local session=NS.db.session[category]
    if not session then session={} NS.db.session[category]=session end
    if not session[nodeName] then session[nodeName]={count=0, zones={}} end
    local sEntry=session[nodeName]
    sEntry.count=sEntry.count+1
    sEntry.zones[zone]=(sEntry.zones[zone] or 0)+1
    NS:FireCallback("DATA_UPDATED")
    self:CheckObjective(category, nodeName, entry.count)
end

function Counter:CheckObjective(category, nodeName, currentCount)
    if not NS.db or not NS.db.objectives then return end
    local target=NS.db.objectives[nodeName]
    if not target or target<=0 then return end
    if currentCount==target then
        PlaySound("RaidWarning")
        local msg="|cFF00CCFFNaerCounter:|r "..nodeName.." |cFF00FF00objetivo alcanzado!|r ("..currentCount.."/"..target..")"
        UIErrorsFrame:AddMessage(msg,0,1,0,1,3)
        print(msg)
    end
end

local WOTLK_MAX=450
local SKILL_TIERS={75,150,225,300,375,450}

function Counter:CheckSkillCap()
    if not NS.db or not NS.db.settings.skillCapWarning then return end
    local f=CreateFrame("Frame") local t=0
    f:SetScript("OnUpdate", function(self, elapsed) t=t+elapsed if t>=0.5 then self:SetScript("OnUpdate",nil) Counter:ScanSkills() end end)
end

local GATHERING_SKILL_NAMES={
    ["Herbalism"]="herb", ["Mining"]="mining",
    ["Herboristerie"]="herb", ["Minage"]="mining",
    ["Kräuterkunde"]="herb", ["Bergbau"]="mining",
    ["Herboristería"]="herb", ["Minería"]="mining",
    ["Herboristeria"]="herb", ["Mineria"]="mining",
}
NS.skillData={}

function Counter:UpdateSkillData()
    local numSkills=GetNumSkillLines()
    local found={}
    for i=1,numSkills do
        local name,isHeader,_,skillRank,_,_,skillMaxRank=GetSkillLineInfo(i)
        if not isHeader and name then
            local key=GATHERING_SKILL_NAMES[name]
            if key then found[key]={name=name, rank=skillRank, max=skillMaxRank} end
        end
    end
    NS.skillData=found
    NS:FireCallback("SKILLS_UPDATED")
end

function Counter:ScanSkills()
    if not NS.db or not NS.db.settings.skillCapWarning then return end
    local numSkills=GetNumSkillLines()
    for i=1,numSkills do
        local name,isHeader,_,skillRank,_,_,skillMaxRank=GetSkillLineInfo(i)
        if not isHeader and name and GATHERING_SKILL_NAMES[name]~=nil then
            if skillRank>=skillMaxRank and skillMaxRank<WOTLK_MAX then
                local nextTier=nil
                for _,tier in ipairs(SKILL_TIERS) do if tier>skillMaxRank then nextTier=tier break end end
                local tierMsg=nextTier and (" — max "..nextTier.."!") or ""
                local msg=name.." "..skillRank.."/"..skillMaxRank..tierMsg
                UIErrorsFrame:AddMessage("|cFF00CCFFNaerCounter:|r "..msg,1,0.3,0.3,1,5)
                print("|cFFFF4444NaerCounter:|r "..msg.." |cFF00FF00¡Ve a entrenar!|r")
                PlaySound("RaidWarning")
            end
        end
    end
end

NS.bagItems={herbs={}, ores={}}

function Counter:ScanBags()
    local herbs={} local ores={}
    local numBags=NUM_BAG_SLOTS or 4
    for bag=0,numBags do
        local numSlots=GetBagNumSlots(bag)
        for slot=1,numSlots do
            local itemID,itemCount=GetBagItemInfo(bag, slot)
            if itemID and itemCount and itemCount>0 then
                local itemName,_,_,_,_,_,_,_,_,itemTexture,_,classID,subclassID=GetItemInfo(itemID)
                if itemName and classID==7 then
                    if subclassID==9 then
                        if not herbs[itemName] then herbs[itemName]={count=0, texture=itemTexture} end
                        herbs[itemName].count=herbs[itemName].count+itemCount
                    elseif subclassID==7 then
                        if not ores[itemName] then ores[itemName]={count=0, texture=itemTexture} end
                        ores[itemName].count=ores[itemName].count+itemCount
                    end
                end
            end
        end
    end
    NS.bagItems={herbs=herbs, ores=ores}
    NS:FireCallback("DATA_UPDATED")
end

function Counter:GetTotalBag(category)
    if not NS.bagItems or not NS.bagItems[category] then return 0 end
    local total=0
    for _,entry in pairs(NS.bagItems[category]) do total=total+(entry.count or 0) end
    return total
end

function Counter:GetTotalSession(category)
    EnsureDB()
    if not NS.db.session[category] then return 0 end
    local total=0
    for _,entry in pairs(NS.db.session[category]) do total=total+(entry.count or 0) end
    return total
end

function Counter:GetTotalLifetime(category)
    EnsureDB()
    if not NS.db[category] then return 0 end
    local total=0
    for _,entry in pairs(NS.db[category]) do total=total+(entry.count or 0) end
    return total
end

NS:RegisterCallback("ADDON_LOADED", function()
    EnsureDB()
    local f=CreateFrame("Frame") local t=0
    f:SetScript("OnUpdate", function(self, elapsed) t=t+elapsed if t>=3 then self:SetScript("OnUpdate",nil) Counter:UpdateSkillData() Counter:ScanSkills() Counter:ScanBags() end end)
end)
