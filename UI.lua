-- NaerCounter – UI.lua
-- Naerzone Edition 3.3.5a 30300 FIXED - Copiar y Pegar completo

local _, NS = ...

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

local UI = {}
NS.UI = UI

local COLOURS = {
    darkBg = {0.05, 0.05, 0.05, 0.92},
    panelBg = {0.12, 0.12, 0.12, 0.95},
    border = {0.25, 0.25, 0.25, 1},
    highlight = {0.2, 0.6, 1, 0.3},
    herbGreen = {0.2, 0.8, 0.2, 1},
    oreYellow = {0.9, 0.7, 0.1, 1},
    white = {1, 1, 1, 1},
    grey = {0.7, 0.7, 0.7, 1},
}

local mainFrame = nil
local minimapButton = nil
local activeTab = "herbs"

local function CreateNodeRow(parent, index)
    local row = CreateFrame("Frame", nil, parent)
    row:SetSize(320, 22)
    row:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -(index-1)*24)
    
    row.bg = row:CreateTexture(nil, "BACKGROUND")
    row.bg:SetAllPoints()
    row.bg:SetTexture(0.15, 0.15, 0.15, 0.8)
    
    row.nameText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    row.nameText:SetPoint("LEFT", row, "LEFT", 5, 0)
    row.nameText:SetWidth(140)
    row.nameText:SetJustifyH("LEFT")
    
    row.countText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    row.countText:SetPoint("LEFT", row.nameText, "RIGHT", 5, 0)
    row.countText:SetWidth(30)
    
    row.barBg = row:CreateTexture(nil, "ARTWORK")
    row.barBg:SetPoint("LEFT", row.countText, "RIGHT", 5, 0)
    row.barBg:SetSize(110, 10)
    row.barBg:SetTexture(0.2, 0.2, 0.2, 1)
    
    row.barFill = row:CreateTexture(nil, "OVERLAY")
    row.barFill:SetPoint("LEFT", row.barBg, "LEFT", 0, 0)
    row.barFill:SetSize(1, 10)
    row.barFill:SetTexture(0.2, 0.8, 0.2, 1)
    
    row.progressText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    row.progressText:SetPoint("LEFT", row.barBg, "RIGHT", 5, 0)
    
    row:SetScript("OnMouseUp", function(self, button)
        if button == "RightButton" then
            UI:ShowObjectiveDialog(self.nodeName, self.nodeCategory)
        end
    end)
    row:EnableMouse(true)
    
    return row
end

function UI:Refresh()
    if not mainFrame or not mainFrame:IsShown() then return end
    if not NS.Counter then return end
    EnsureDB()
    local category = (activeTab == "herbs") and "herbs" or "minerals"
    local data = NS.Counter:GetData(category)
    local rows = mainFrame.rows or {}
    for i = 1, #rows do rows[i]:Hide() end
    for i = 1, math.min(#data, 20) do
        local entry = data[i]
        local row = rows[i]
        if not row then row = CreateNodeRow(mainFrame.content, i) rows[i] = row end
        row:Show()
        row.nodeData = entry
        row.nodeName = entry.name
        row.nodeCategory = category
        row.nameText:SetText(entry.name)
        row.countText:SetText(tostring(entry.count))
        local objective = NS.db.objectives[entry.name] or 0
        if objective and objective > 0 then
            local pct = math.min((entry.count / objective) * 100, 100)
            row.barFill:SetWidth((pct / 100) * 110)
            row.progressText:SetText(entry.count .. "/" .. objective)
        else
            row.barFill:SetWidth(1)
            row.progressText:SetText("")
        end
        row.barFill:SetVertexColor(unpack(category == "herbs" and COLOURS.herbGreen or COLOURS.oreYellow))
    end
    mainFrame.rows = rows
    if minimapButton then minimapButton:UpdateIcon() end
end

function UI:ShowObjectiveDialog(nodeName, category)
    StaticPopupDialogs["NAERCOUNTER_OBJECTIVE"] = StaticPopupDialogs["NAERCOUNTER_OBJECTIVE"] or {}
    StaticPopupDialogs["NAERCOUNTER_OBJECTIVE"].text = "Objetivo para %s:"
    StaticPopupDialogs["NAERCOUNTER_OBJECTIVE"].button1 = "Guardar"
    StaticPopupDialogs["NAERCOUNTER_OBJECTIVE"].button2 = "Cancelar"
    StaticPopupDialogs["NAERCOUNTER_OBJECTIVE"].hasEditBox = 1
    StaticPopupDialogs["NAERCOUNTER_OBJECTIVE"].timeout = 0
    StaticPopupDialogs["NAERCOUNTER_OBJECTIVE"].whileDead = true
    StaticPopupDialogs["NAERCOUNTER_OBJECTIVE"].hideOnEscape = true
    StaticPopupDialogs["NAERCOUNTER_OBJECTIVE"].OnShow = function(self) self.editBox:SetText("") self.editBox:SetFocus() end
    StaticPopupDialogs["NAERCOUNTER_OBJECTIVE"].OnAccept = function(self)
        local num = tonumber(self.editBox:GetText())
        if num and NS.db then
            NS.db.objectives = NS.db.objectives or {}
            NS.db.objectives[nodeName] = num
            if UI and UI.Refresh then UI:Refresh() end
        end
    end
    StaticPopup_Show("NAERCOUNTER_OBJECTIVE", nodeName)
end

local function CreateMainFrame()
    if mainFrame then return mainFrame end
    mainFrame = CreateFrame("Frame", "NaerCounterMainFrame", UIParent)
    mainFrame:SetSize(360, 500)
    mainFrame:SetPoint("CENTER")
    mainFrame:SetMovable(true)
    mainFrame:EnableMouse(true)
    mainFrame:RegisterForDrag("LeftButton")
    mainFrame:SetScript("OnDragStart", mainFrame.StartMoving)
    mainFrame:SetScript("OnDragStop", mainFrame.StopMovingOrSizing)
    mainFrame:SetFrameStrata("DIALOG")
    
    mainFrame.bg = mainFrame:CreateTexture(nil, "BACKGROUND")
    mainFrame.bg:SetAllPoints()
    mainFrame.bg:SetTexture(unpack(COLOURS.darkBg))
    
    mainFrame.title = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    mainFrame.title:SetPoint("TOP", mainFrame, "TOP", 0, -10)
    mainFrame.title:SetText("|cff00ccffNaerCounter|r")
    
    mainFrame.close = CreateFrame("Button", nil, mainFrame, "UIPanelCloseButton")
    mainFrame.close:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -5, -5)
    
    mainFrame.content = CreateFrame("Frame", nil, mainFrame)
    mainFrame.content:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 10, -50)
    mainFrame.content:SetSize(340, 440)
    mainFrame.rows = {}
    
    mainFrame:Hide()
    return mainFrame
end

function UI:Toggle()
    if not mainFrame then CreateMainFrame() end
    if mainFrame:IsShown() then mainFrame:Hide() else mainFrame:Show() self:Refresh() end
end

function UI:Initialize()
    CreateMainFrame()
    EnsureDB()
    if NS.RegisterCallback then
        NS:RegisterCallback("DATA_UPDATED", function() UI:Refresh() end)
        NS:RegisterCallback("TRACKING_APPLIED", function() UI:Refresh() end)
    end
end

-- Minimap Button - FIXED textures lowercase
local minimapButton = CreateFrame("Button", "NaerCounterMinimapButton", Minimap)
minimapButton:SetSize(31, 31)
minimapButton:SetFrameStrata("MEDIUM")
minimapButton:SetMovable(true)
minimapButton:EnableMouse(true)
minimapButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
minimapButton:RegisterForDrag("LeftButton")
minimapButton:SetClampedToScreen(true)
minimapButton:SetFrameLevel(8)

minimapButton.icon = minimapButton:CreateTexture(nil, "BACKGROUND")
minimapButton.icon:SetSize(20, 20)
minimapButton.icon:SetPoint("CENTER", 0, 1)
minimapButton.icon:SetTexture("Interface\\Icons\\INV_Misc_Herb_MountainSilversage")

minimapButton.border = minimapButton:CreateTexture(nil, "OVERLAY")
minimapButton.border:SetSize(53, 53)
minimapButton.border:SetPoint("TOPLEFT", 0, 0)
minimapButton.border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

minimapButton:SetScript("OnDragStart", function(self) self.isDragging = true self:StartMoving() end)
minimapButton:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    self.isDragging = false
    local mx, my = Minimap:GetCenter()
    local px, py = GetCursorPosition()
    local scale = Minimap:GetEffectiveScale()
    px, py = px / scale, py / scale
    local angle = math.deg(math.atan2(py - my, px - mx))
    EnsureDB()
    NS.db.settings.minimapPos = angle
    self:UpdatePosition()
end)

function minimapButton:UpdatePosition()
    EnsureDB()
    local angle = NS.db and NS.db.settings.minimapPos or 220
    local rad = math.rad(angle)
    local x = math.cos(rad) * 80
    local y = math.sin(rad) * 80
    self:ClearAllPoints()
    self:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

function minimapButton:UpdateIcon()
    local tracking = NS.Tracking and NS.Tracking:GetActiveTracking() or "none"
    if tracking == "herbs" then
        self.icon:SetTexture("Interface\\Icons\\INV_Misc_Herb_MountainSilversage")
    elseif tracking == "minerals" then
        self.icon:SetTexture("Interface\\Icons\\INV_Ore_Copper_01")
    else
        self.icon:SetTexture("Interface\\Icons\\INV_Misc_Map_01")
    end
end

minimapButton:SetScript("OnClick", function(self, button)
    if button == "LeftButton" then UI:Toggle()
    elseif button == "RightButton" then
        if NS.Tracking and NS.Tracking.CycleMode then NS.Tracking:CycleMode() end
    end
end)

minimapButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:AddLine("|cff00ccffNaerCounter|r")
    GameTooltip:AddLine("Click Izq: Abrir/Cerrar", 1, 1, 1)
    GameTooltip:AddLine("Click Der: Cambiar tracking", 1, 1, 1)
    GameTooltip:Show()
end)

minimapButton:SetScript("OnLeave", function() GameTooltip:Hide() end)

if NS.RegisterCallback then
    NS:RegisterCallback("ADDON_LOADED", function()
        EnsureDB()
        minimapButton:UpdatePosition()
        minimapButton:UpdateIcon()
        UI:Initialize()
    end)
end
