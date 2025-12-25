-- ## Author: cc27
-- Get the name of the big area map
local function GetParentMapName(mapID)
    if not mapID then
        return "No data"
    end
    
    local mapInfo = C_Map.GetMapInfo(mapID)
    if mapInfo and mapInfo.parentMapID then
        local parentMapInfo = C_Map.GetMapInfo(mapInfo.parentMapID)
        return parentMapInfo and parentMapInfo.name or "No data"
    end
    return "No data"
end



-- Setup a framework to listen for events
local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
frame:RegisterEvent("UNIT_SPELLCAST_START")
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "UNIT_SPELLCAST_SUCCEEDED" then
        local unit, castGUID, spellID = ...
        if unit == "player" and spellID == 312370 then -- Make Camp ID
            local mapID = C_Map.GetBestMapForUnit("player")
            if not mapID then
                print("\124cFFFF0000\nNo data\n")
                return
            end
            
            local campZone = GetZoneText() or "No data"
            local campParentZone = GetParentMapName(mapID)
            local playerMapPosition = C_Map.GetPlayerMapPosition(mapID, "player")
            
            if playerMapPosition then
                local campX, campY = playerMapPosition:GetXY()
                if campX and campY then
                    ShiGuangDB[UnitName("player")] = { SimpleFoxCampZone = campZone, SimpleFoxCampParentZone = campParentZone, SimpleFoxCampX = campX, SimpleFoxCampY = campY }
                    print("\124cFFFFD700\n", C_Spell.GetSpellName(312370), ": " .. campParentZone .. " - " .. campZone .. " (" .. string.format("%.1f", campX * 100) .. ", " .. string.format("%.1f", campY * 100) .. ")", "\n\n")
                else
                    print("\124cFFFF0000\nNo data\n")
                end
            else
                print("\124cFFFF0000\nNo data\n")
            end
        end
    elseif event == "UNIT_SPELLCAST_START" then
        local unit, castGUID, spellID = ...
        if unit == "player" and spellID == 312372 then -- Return to Camp ID
            local campData = ShiGuangDB[UnitName("player")]
            if campData then
                print("\124cFFFFD700\n", C_Spell.GetSpellName(312372), ": " .. campData.SimpleFoxCampParentZone .. " - " .. campData.SimpleFoxCampZone .. " (" .. string.format("%.1f", campData.SimpleFoxCampX * 100) .. ", " .. string.format("%.1f", campData.SimpleFoxCampY * 100) .. ")", "\n\n")
            else
                print("\124cFFFF0000\n", C_Spell.GetSpellName(312372), ": ----\n")
            end
        end
    end
end)

