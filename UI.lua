
-- NaerCounter  –  UI.lua
-- Main window, minimap button, settings panel - WotLK 3.3.5a 30300
-- ElvUI-compatible dark modern design - Naerzone Edition

local _, NS = ...

local UI = {}
NS.UI = UI

-- WotLK 3.3.5a Compat Layer (no BackdropTemplate in 30300)

local function CreateFrameCompat(frameType, name, parent, template)
    if template and template:find("BackdropTemplate") then
        if BackdropTemplateMixin then
            return CreateFrame(frameType, name, parent, template)
        else
            return CreateFrame(frameType, name, parent)
        end
    end
    return CreateFrame(frameType, name, parent, template)
end

-- Colour / style constants

local COLOURS = {
    bg         = { 0.1,  0.1,  0.1,  0.92 },
    border     = { 0.3,  0.3,  0.3,  1    },
    accent     = { 0.0,  0.8,  1.0,  1    },
    herbGreen  = { 0.27, 1.0,  0.27, 1    },
    oreYellow  = { 1.0,  0.8,  0.27, 1    },
    gold       = { 1.0,  0.84, 0.0,  1    },
    barBg      = { 0.15, 0.15, 0.15, 1    },
    rowHover   = { 0.2,  0.2,  0.2,  0.6  },
    white      = { 1, 1, 1, 1 },
    dimWhite   = { 0.7, 0.7, 0.7, 1 },
    routeCyan  = { 0.0,  0.86, 1.0,  1    },
    gasPurple  = { 0.7,  0.4,  1.0,  1    },
}

-- ElvUI helpers

local function IsElvUI()
    return ElvUI and ElvUI[1] and true or false
end

local function SkinFrame(f)
    if IsElvUI() and f.SetTemplate then
        f:SetTemplate("Transparent")
    else
        if f.SetBackdrop then
            f:SetBackdrop({
                bgFile   = "Interface\\Buttons\\WHITE8x8",
                edgeFile = "Interface\\Buttons\\WHITE8x8",
                edgeSize = 1,
                insets = { left=1, right=1, top=1, bottom=1 },
            })
            f:SetBackdropColor(unpack(COLOURS.bg))
            f:SetBackdropBorderColor(unpack(COLOURS.border))
        end
    end
end

local function GetFont()
    if IsElvUI() then
        local E = ElvUI[1]
        if E and E.Libs and E.Libs.LSM then
            local LSM = E.Libs.LSM
            local font = LSM:Fetch("font", E.db and E.db.general and E.db.general.font)
            if font then return font end
        end
    end
    return "Fonts\\FRIZQT__.TTF"
end

-- Skill rank names by max skill value

local SKILL_RANK_NAMES = {
    enUS = { [75]="Apprentice", [150]="Journeyman", [225]="Expert", [300]="Artisan", [375]="Master", [450]="Grand Master" },
    enGB = { [75]="Apprentice", [150]="Journeyman", [225]="Expert", [300]="Artisan", [375]="Master", [450]="Grand Master" },
    frFR = { [75]="Apprenti", [150]="Compagnon", [225]="Expert", [300]="Artisan", [375]="Maître", [450]="Grand Maître" },
    deDE = { [75]="Lehrling", [150]="Geselle", [225]="Experte", [300]="Fachmann", [375]="Meister", [450]="Großmeister" },
    esES = { [75]="Aprendiz", [150]="Oficial", [225]="Experto", [300]="Artesano", [375]="Maestro", [450]="Gran Maestro" },
    esMX = { [75]="Aprendiz", [150]="Oficial", [225]="Experto", [300]="Artesano", [375]="Maestro", [450]="Gran Maestro" },
}

local function GetSkillRankName(maxSkill)
    local locale = GetLocale()
    local names = SKILL_RANK_NAMES[locale] or SKILL_RANK_NAMES["enUS"]
    return names[maxSkill] or ""
end

-- Forward declarations

local mainFrame, settingsFrame, minimapButton
local herbRows, oreRows = {}, {}
local activeTab = "herbs"

-- ====================================================================
--  MINIMAP BUTTON
-- ====================================================================
local function CreateMinimapButton()
    local btn = CreateFrame("Button", "NaerCounterMinimapButton", Minimap)
    btn:SetSize(32, 32)
    btn:SetFrameStrata("MEDIUM")
    btn:SetFrameLevel(8)
    btn:SetMovable(true)
    btn:SetClampedToScreen(true)

    local overlay = btn:CreateTexture(nil, "OVERLAY")
    overlay:SetSize(53, 53)
    overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    overlay:SetPoint("TOPLEFT")

    local icon = btn:CreateTexture(nil, "BACKGROUND")
    icon:SetSize(20, 20)
    icon:SetPoint("CENTER", 0, 0)
    icon:SetTexture("Interface\\Icons\\INV_Misc_Flower_02")
    btn.icon = icon

    local highlight = btn:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetSize(24, 24)
    highlight:SetPoint("CENTER")
    highlight:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    highlight:SetBlendMode("ADD")

    local dot = btn:CreateTexture(nil, "OVERLAY")
    dot:SetSize(8, 8)
    dot:SetPoint("BOTTOMRIGHT", -2, 2)
    dot:SetTexture("Interface\\Buttons\\WHITE8x8")
    dot:SetVertexColor(unpack(COLOURS.accent))
    btn.dot = dot

    local function UpdatePosition()
        local angle = math.rad(NS.db and NS.db.settings.minimapPos or 220)
        btn:ClearAllPoints()
        btn:SetPoint("CENTER", Minimap, "CENTER", math.cos(angle) * 80, math.sin(angle) * 80)
    end

    btn:RegisterForDrag("LeftButton")
    btn:SetScript("OnDragStart", function(self)
        self:SetScript("OnUpdate", function(self)
            local mx, my = Minimap:GetCenter()
            local cx, cy = GetCursorPosition()
            local scale = Minimap:GetEffectiveScale()
            cx, cy = cx / scale, cy / scale
            local angle = math.deg(math.atan2(cy - my, cx - mx))
            if NS.db then NS.db.settings.minimapPos = angle end
            local rad = math.rad(angle)
            self:ClearAllPoints()
            self:SetPoint("CENTER", Minimap, "CENTER", math.cos(rad) * 80, math.sin(rad) * 80)
        end)
    end)
    btn:SetScript("OnDragStop", function(self)
        self:SetScript("OnUpdate", nil)
    end)

    local dropdownFrame = CreateFrame("Frame", "NaerCounterMinimapDropdown", UIParent, "UIDropDownMenuTemplate")

    local MENU_LABELS = {
        herbs    = { frFR="Herboristerie", deDE="Kräuterkunde", esES="Herbalismo", esMX="Herbalismo", enUS="Herbalism" },
        minerals = { frFR="Minage", deDE="Bergbau", esES="Minería", esMX="Minería", enUS="Mining" },
        auto     = { frFR="Auto-Switch", deDE="Auto-Wechsel", esES="Auto-Cambio", esMX="Auto-Cambio", enUS="Auto-Switch" },
    }
    local loc = GetLocale()
    local function MenuLabel(key)
        local t = MENU_LABELS[key]
        return t and (t[loc] or t.enUS) or key
    end

    local function InitMinimapDropdown(frame, level)
        local currentMode = NS.db and NS.db.settings.trackingMode or "auto"
        local hasHerbs, hasMinerals = NS.Tracking:HasTrackingTypes()
        if hasHerbs then
            local info = UIDropDownMenu_CreateInfo()
            info.text = MenuLabel("herbs")
            info.icon = "Interface\\Icons\\INV_Misc_Flower_02"
            info.checked = (currentMode == "herbs")
            info.func = function()
                NS.db.settings.trackingMode = "herbs"
                NS:FireCallback("TRACKING_MODE_CHANGED", "herbs")
                print("|cff00ccffNaerCounter:|r Tracking -> |cff44ff44" .. MenuLabel("herbs") .. "|r")
            end
            UIDropDownMenu_AddButton(info)
        end
        if hasMinerals then
            local info = UIDropDownMenu_CreateInfo()
            info.text = MenuLabel("minerals")
            info.icon = "Interface\\Icons\\INV_Pick_02"
            info.checked = (currentMode == "minerals")
            info.func = function()
                NS.db.settings.trackingMode = "minerals"
                NS:FireCallback("TRACKING_MODE_CHANGED", "minerals")
                print("|cff00ccffNaerCounter:|r Tracking -> |cffffcc00" .. MenuLabel("minerals") .. "|r")
            end
            UIDropDownMenu_AddButton(info)
        end
        if hasHerbs and hasMinerals then
            local info = UIDropDownMenu_CreateInfo()
            info.text = MenuLabel("auto")
            info.icon = "Interface\\Icons\\Spell_Nature_WispSplode"
            info.checked = (currentMode == "auto")
            info.func = function()
                NS.db.settings.trackingMode = "auto"
                NS:FireCallback("TRACKING_MODE_CHANGED", "auto")
                print("|cff00ccffNaerCounter:|r Tracking -> |cff00ccff" .. MenuLabel("auto") .. "|r")
            end
            UIDropDownMenu_AddButton(info)
        end
    end
    UIDropDownMenu_Initialize(dropdownFrame, InitMinimapDropdown, "MENU")

    btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    btn:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            NS:FireCallback("TOGGLE_WINDOW")
        elseif button == "RightButton" then
            GameTooltip:Hide()
            ToggleDropDownMenu(1, nil, dropdownFrame, self, 0, 0)
        end
    end)

    local NO_PROFESSION_MSG = {
        frFR = "Vous n'avez pas de metier de recolte",
        deDE = "Ihr habt keinen Sammelberuf",
        esES = "No tienes una profesion de recoleccion",
        esMX = "No tienes una profesion de recoleccion",
    }
    local noGatherMsg = NO_PROFESSION_MSG[GetLocale()] or "You have no gathering profession"

    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine("NaerCounter [Naerzone]", 0.0, 0.8, 1.0)
        local hasHerbs, hasMinerals = NS.Tracking:HasTrackingTypes()
        if not hasHerbs and not hasMinerals then
            GameTooltip:AddLine(noGatherMsg, 0.7, 0.3, 0.3)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("Left-click: Toggle window", 0.7, 0.7, 0.7)
            GameTooltip:AddLine("Drag: Move button", 0.7, 0.7, 0.7)
            GameTooltip:Show()
            return
        end
        local mode = NS.db and NS.db.settings.trackingMode or "auto"
        local labels = { herbs="Herbs Only", minerals="Minerals Only", auto="Auto-Switch" }
        GameTooltip:AddLine("Mode: " .. (labels[mode] or mode), 1, 1, 1)
        GameTooltip:AddLine(" ")
        local sh = NS.Counter and NS.Counter:GetTotalBag("herbs") or 0
        local so = NS.Counter and NS.Counter:GetTotalBag("ores") or 0
        GameTooltip:AddDoubleLine("Hierbas (bolsas):", tostring(sh), 0.27, 1.0, 0.27, 1, 1, 1)
        GameTooltip:AddDoubleLine("Menas (bolsas):", tostring(so), 1.0, 0.8, 0.27, 1, 1, 1)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Left-click: Toggle window", 0.7, 0.7, 0.7)
        GameTooltip:AddLine("Right-click: Tracking menu", 0.7, 0.7, 0.7)
        GameTooltip:AddLine("Drag: Move button", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    function btn:UpdateIcon()
        local hasHerbs, hasMinerals = NS.Tracking:HasTrackingTypes()
        local hasAny = hasHerbs or hasMinerals
        if not hasAny then
            self.icon:SetTexture("Interface\\Icons\\INV_Misc_Flower_02")
            self.icon:SetDesaturated(true)
            self.icon:SetVertexColor(0.5, 0.5, 0.5)
            self.dot:SetVertexColor(0.4, 0.4, 0.4, 1)
            return
        end
        self.icon:SetDesaturated(false)
        self.icon:SetVertexColor(1, 1, 1)
        local mode = NS.db and NS.db.settings.trackingMode or "auto"
        if mode == "herbs" then
            self.icon:SetTexture("Interface\\Icons\\INV_Misc_Flower_02")
            self.dot:SetVertexColor(unpack(COLOURS.herbGreen))
        elseif mode == "minerals" then
            self.icon:SetTexture("Interface\\Icons\\INV_Pick_02")
            self.dot:SetVertexColor(unpack(COLOURS.oreYellow))
        else
            local st = NS.Tracking and NS.Tracking:GetAutoState() or "herbs"
            if st == "minerals" then
                self.icon:SetTexture("Interface\\Icons\\INV_Pick_02")
            else
                self.icon:SetTexture("Interface\\Icons\\INV_Misc_Flower_02")
            end
            self.dot:SetVertexColor(unpack(COLOURS.accent))
        end
    end

    UpdatePosition()
    minimapButton = btn
    return btn
end

-- ====================================================================
--  MAIN WINDOW
-- ====================================================================
local function CreateTabButton(parent, label, anchorTo)
    local tab = CreateFrameCompat("Button", nil, parent, "BackdropTemplate")
    tab:SetSize(100, 26)
    if anchorTo then
        tab:SetPoint("LEFT", anchorTo, "RIGHT", 4, 0)
    else
        tab:SetPoint("BOTTOMLEFT", parent.headerBar, "BOTTOMLEFT", 8, -28)
    end
    SkinFrame(tab)
    tab.label = tab:CreateFontString(nil, "OVERLAY")
    tab.label:SetFont(GetFont(), 12, "OUTLINE")
    tab.label:SetPoint("CENTER")
    tab.label:SetText(label)
    tab:SetScript("OnEnter", function(self)
        if not self.selected then self:SetBackdropColor(0.25, 0.25, 0.25, 1) end
    end)
    tab:SetScript("OnLeave", function(self)
        if not self.selected then self:SetBackdropColor(unpack(COLOURS.bg)) end
    end)
    function tab:SetSelected(sel)
        self.selected = sel
        if sel then
            self:SetBackdropBorderColor(unpack(COLOURS.accent))
            self.label:SetTextColor(unpack(COLOURS.accent))
        else
            self:SetBackdropBorderColor(unpack(COLOURS.border))
            self.label:SetTextColor(unpack(COLOURS.dimWhite))
            self:SetBackdropColor(unpack(COLOURS.bg))
        end
    end
    return tab
end

local function CreateNodeRow(parent, index)
    local row = CreateFrame("Button", nil, parent)
    row:SetSize(parent:GetWidth() - 4, 28)
    row:SetPoint("TOPLEFT", 2, -(index - 1) * 30)
    local hl = row:CreateTexture(nil, "BACKGROUND")
    hl:SetAllPoints()
    hl:SetTexture("Interface\\Buttons\\WHITE8x8")
    hl:SetVertexColor(unpack(COLOURS.rowHover))
    hl:Hide()
    row.hl = hl
    row.nameText = row:CreateFontString(nil, "OVERLAY")
    row.nameText:SetFont(GetFont(), 11, "")
    row.nameText:SetPoint("LEFT", 6, 0)
    row.nameText:SetWidth(150)
    row.nameText:SetJustifyH("LEFT")
    row.nameText:SetTextColor(1, 1, 1)
    row.countText = row:CreateFontString(nil, "OVERLAY")
    row.countText:SetFont(GetFont(), 11, "")
    row.countText:SetPoint("LEFT", row.nameText, "RIGHT", 8, 0)
    row.countText:SetWidth(60)
    row.countText:SetJustifyH("CENTER")
    row.barBg = row:CreateTexture(nil, "ARTWORK")
    row.barBg:SetSize(110, 14)
    row.barBg:SetPoint("LEFT", row.countText, "RIGHT", 8, 0)
    row.barBg:SetTexture("Interface\\Buttons\\WHITE8x8")
    row.barBg:SetVertexColor(unpack(COLOURS.barBg))
    row.barFill = row:CreateTexture(nil, "ARTWORK", nil, 1)
    row.barFill:SetSize(1, 14)
    row.barFill:SetPoint("LEFT", row.barBg, "LEFT", 0, 0)
    row.barFill:SetTexture("Interface\\Buttons\\WHITE8x8")
    row.barFill:SetVertexColor(unpack(COLOURS.herbGreen))
    row.progressText = row:CreateFontString(nil, "OVERLAY")
    row.progressText:SetFont(GetFont(), 9, "OUTLINE")
    row.progressText:SetPoint("CENTER", row.barBg, "CENTER")
    row.progressText:SetTextColor(1, 1, 1)
    row:SetScript("OnEnter", function(self)
        self.hl:Show()
        if self.nodeData then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:AddLine(self.nodeName or "", 1, 1, 1)
            GameTooltip:AddDoubleLine("En bolsas:", tostring(self.nodeData.count or 0), 0.7, 0.7, 0.7, 1, 1, 1)
            local obj = NS.db and NS.db.objectives and NS.db.objectives[self.nodeName]
            if obj and obj > 0 then GameTooltip:AddDoubleLine("Objetivo:", tostring(obj), 0.7, 0.7, 0.7, 1, 0.84, 0) end
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("Click: definir objetivo", 0.5, 0.5, 0.5)
            GameTooltip:Show()
        end
    end)
    row:SetScript("OnLeave", function(self) self.hl:Hide() GameTooltip:Hide() end)
    row:RegisterForClicks("LeftButtonUp")
    row:SetScript("OnClick", function(self)
        if not self.nodeName then return end
        UI:ShowObjectiveDialog(self.nodeName, self.nodeCategory)
    end)
    return row
end

local function CreateMainFrame()
    local f = CreateFrameCompat("Frame", "NaerCounterMainFrame", UIParent, "BackdropTemplate")
    f:SetSize(520, 560)
    f:SetPoint("CENTER")
    f:SetFrameStrata("HIGH")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:SetClampedToScreen(true)
    SkinFrame(f)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    tinsert(UISpecialFrames, "NaerCounterMainFrame")

    local header = CreateFrameCompat("Frame", nil, f, "BackdropTemplate")
    header:SetSize(f:GetWidth(), 30)
    header:SetPoint("TOP")
    SkinFrame(header)
    f.headerBar = header

    local title = header:CreateFontString(nil, "OVERLAY")
    title:SetFont(GetFont(), 13, "OUTLINE")
    title:SetPoint("LEFT", 10, 0)
    title:SetText("NaerCounter [Naerzone]")
    title:SetTextColor(unpack(COLOURS.accent))

    f.headerStats = header:CreateFontString(nil, "OVERLAY")
    f.headerStats:SetFont(GetFont(), 10, "")
    f.headerStats:SetPoint("CENTER", header, "CENTER", 20, 0)
    f.headerStats:SetTextColor(unpack(COLOURS.dimWhite))

    local closeBtn = CreateFrame("Button", nil, header)
    closeBtn:SetSize(18, 18)
    closeBtn:SetPoint("RIGHT", -6, 0)
    closeBtn:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
    closeBtn:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
    closeBtn:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight", "ADD")
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    local settingsBtn = CreateFrame("Button", nil, header)
    settingsBtn:SetSize(18, 18)
    settingsBtn:SetPoint("RIGHT", closeBtn, "LEFT", -4, 0)
    settingsBtn:SetNormalTexture("Interface\\Buttons\\UI-OptionsButton")
    settingsBtn:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight", "ADD")
    settingsBtn:SetScript("OnClick", function() NS:FireCallback("SHOW_SETTINGS") end)

    -- Tabs
    local herbTab = CreateTabButton(f, "Hierbas", nil)
    local oreTab = CreateTabButton(f, "Menas", herbTab)
    herbTab:SetSelected(true)
    f.herbTab = herbTab
    f.oreTab = oreTab

    herbTab:SetScript("OnClick", function()
        activeTab = "herbs"
        herbTab:SetSelected(true)
        oreTab:SetSelected(false)
        UI:Refresh()
    end)
    oreTab:SetScript("OnClick", function()
        activeTab = "minerals"
        oreTab:SetSelected(true)
        herbTab:SetSelected(false)
        UI:Refresh()
    end)

    -- Scroll frame
    local scroll = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", f, "TOPLEFT", 8, -70)
    scroll:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -28, 10)
    local content = CreateFrame("Frame", nil, scroll)
    content:SetSize(480, 500)
    scroll:SetScrollChild(content)
    f.scroll = scroll
    f.content = content

    f:Hide()
    mainFrame = f
    return f
end

-- Public API

function UI:Initialize()
    CreateMinimapButton()
    CreateMainFrame()
    NS:RegisterCallback("TOGGLE_WINDOW", function() self:Toggle() end)
end

function UI:Toggle()
    if mainFrame:IsShown() then mainFrame:Hide() else mainFrame:Show() self:Refresh() end
end

function UI:Refresh()
    if not mainFrame or not mainFrame:IsShown() then return end
    -- Refresh logic delegates to Counter
    if NS.Counter then
        local data = NS.Counter:GetData()
        -- ... fill rows ...
    end
    if minimapButton then minimapButton:UpdateIcon() end
end

function UI:ShowObjectiveDialog(nodeName, category)
    StaticPopupDialogs["NAERCOUNTER_OBJECTIVE"] = {
        text = "Objetivo para %s:",
        button1 = "Guardar",
        button2 = "Cancelar",
        hasEditBox = 1,
        OnAccept = function(self)
            local num = tonumber(self.editBox:GetText())
            if num and NS.db then
                NS.db.objectives = NS.db.objectives or {}
                NS.db.objectives[nodeName] = num
                UI:Refresh()
            end
        end,
        OnShow = function(self) self.editBox:SetText("") self.editBox:SetFocus() end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
    }
    Stfunction UI:ShowObjectiveDialog(nodeName, category)
    StaticPopupDialogs["NAERCOUNTER_OBJECTIVE"] = {
        text = "Objetivo para %s:",
        button1 = "Guardar",
        button2 = "Cancelar",
        hasEditBox = 1,
        OnAccept = function(self)
            local num = tonumber(self.editBox:GetText())
            if num and NS.db then
                NS.db.objectives = NS.db.objectives or {}
                NS.db.objectives[nodeName] = num
                UI:Refresh()
            end
        end,
        OnShow = function(self) self.editBox:SetText("") self.editBox:SetFocus() end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
    }
    StaticPopup_Show("NAERCOUNTER_OBJECTIVE", nodeName)
end
