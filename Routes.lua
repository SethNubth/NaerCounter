
-- NaerCounter  –  Routes.lua
-- Navigation engine: player position tracking on route maps
-- WotLK 3.3.5a 30300 esMX compatible - Naerzone Edition

local _, NS = ...

local Routes = {}
NS.Routes = Routes

-- State

local activeZoneKey  = nil   -- e.g. "Durotar" or "Fiordo Aquilonal"
local activeType     = nil   -- "herbs" or "mining"
local startPos       = nil   -- {x, y} player position when navigation started
local isNavigating   = false
local lastUpdate     = 0
local UPDATE_THROTTLE = 0.1  -- seconds

-- Update frame

local frame = CreateFrame("Frame")
frame:Hide()

-- WotLK 3.3.5a Compat Layer

local function GetCurrentMapID_WotLK()
    -- Retail / Modern API
    if C_Map and C_Map.GetBestMapForUnit then
        return C_Map.GetBestMapForUnit("player")
    end
    -- WotLK 3.3.5a fallback - no map ID, use zone text
    if GetCurrentMapZone then
        return GetCurrentMapZone() -- returns zone ID 1-100
    end
    return nil
end

-- Player map position (normalised 0-1) - WotLK compatible

function Routes:GetPlayerMapPos()
    -- Retail / Anniversary
    if C_Map and C_Map.GetPlayerMapPosition then
        local mapID = GetCurrentMapID_WotLK()
        if mapID then
            local pos = C_Map.GetPlayerMapPosition(mapID, "player")
            if pos and pos.GetXY then
                return pos:GetXY()
            end
        end
    end
    -- WotLK 3.3.5a 30300 API real
    if GetPlayerMapPosition then
        local x, y = GetPlayerMapPosition("player")
        if x and y and (x ~= 0 or y ~= 0) then
            return x, y
        end
    end
    return nil, nil
end

-- Get current zone key (try to match RoutesData) - esMX included

function Routes:GetCurrentZoneKey()
    local zone = GetRealZoneText()
    if not zone or zone == "" then return nil end

    -- Direct match (EN key or localized)
    if NS.RoutesData[zone] then return zone end

    -- Alias lookup (FR/DE/ES/esMX -> EN key)
    if NS.RouteZoneAliases and NS.RouteZoneAliases[zone] then
        return NS.RouteZoneAliases[zone]
    end

    return nil
end

-- Check if a zone has a route for the given type

function Routes:ZoneHasRoute(zoneKey, routeType)
    if not zoneKey or not routeType then return false end
    local zd = NS.RoutesData[zoneKey]
    if not zd then return false end
    return zd[routeType] and true or false
end

-- Get texture path for a zone + type - NaerCounter path

function Routes:GetTexture(zoneKey, routeType)
    local zd = NS.RoutesData[zoneKey]
    if not zd or not zd[routeType] then return nil end
    return zd[routeType].texture
end

-- Start tracking on a route

function Routes:StartRoute(zoneKey, routeType, skipValidation)
    if not skipValidation and not self:ZoneHasRoute(zoneKey, routeType) then
        return false
    end

    activeZoneKey = zoneKey
    activeType    = routeType
    isNavigating  = true

    local px, py = self:GetPlayerMapPos()
    if px and py then
        startPos = { x = px, y = py }
    else
        startPos = nil
    end

    frame:Show()
    if NS.FireCallback then
        NS:FireCallback("ROUTE_STARTED", zoneKey, routeType)
    end
    return true
end

-- Stop tracking

function Routes:StopRoute()
    isNavigating  = false
    activeZoneKey = nil
    activeType    = nil
    startPos      = nil
    frame:Hide()
    if NS.FireCallback then
        NS:FireCallback("ROUTE_STOPPED")
    end
end

-- Getters

function Routes:IsNavigating()
    return isNavigating
end

function Routes:GetActiveInfo()
    return activeZoneKey, activeType
end

function Routes:GetStartPos()
    return startPos
end

-- OnUpdate: send player position - WotLK safe

frame:SetScript("OnUpdate", function(self, elapsed)
    lastUpdate = lastUpdate + elapsed
    if lastUpdate < UPDATE_THROTTLE then return end
    lastUpdate = 0

    if not isNavigating then return end

    local px, py = Routes:GetPlayerMapPos()
    if NS.FireCallback then
        NS:FireCallback("ROUTE_UPDATE", px, py)
    end
end)
