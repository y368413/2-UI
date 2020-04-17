--## Author: Velhari-LosErrantes EU  ## Version: 0.1
local AlterCurrencies = {}
local unitName, realmName, unitClass, classColor

local AlterCurrencies_Frame = CreateFrame("Frame")
AlterCurrencies_Frame:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
AlterCurrencies_Frame:RegisterEvent("PLAYER_ENTERING_WORLD")

--------------------------------------------------------------------------
-- Create a JSON dictionary in the shared variable with all necesary data:
-- - currency
--      - realm
--          - character
--              - amount
--------------------------------------------------------------------------
function AlterCurrencies.UpdateTable(currencyId, currencyAmount)
  if ShiGuangDB[currencyId] == nil then ShiGuangDB[currencyId] = {} end
	if ShiGuangDB[currencyId][realmName] == nil then ShiGuangDB[currencyId][realmName] = {} end
	if ShiGuangDB[currencyId][realmName][unitName] == nil then ShiGuangDB[currencyId][realmName][unitName] = {} end
	ShiGuangDB[currencyId][realmName][unitName].colorStr = classColor
	ShiGuangDB[currencyId][realmName][unitName].currencyAmount = currencyAmount
end

-----------------------------------------------------------------------------------
-- Dinamically obtain the list of discovered currencies of the character and 
-- get the amount. Store this amount in the dictionary saved in the shared variable
-----------------------------------------------------------------------------------
function AlterCurrencies.GetCurrencyAmounts()
    local currencyName, currencyAmount, isDiscovered = nil,nil,nil;
    for i = 1,GetCurrencyListSize(),1 do
        local currencyLink = GetCurrencyListLink(i);
        if currencyLink ~= nil then -- Ignore headers
            local currencyId = tonumber(string.match(GetCurrencyListLink(i),"currency:(%d+)")) -- Get only the ID
            local currencyName, currencyAmount, isDiscovered = GetCurrencyInfo(currencyLink); 
            if currencyId ~= nil and currencyName ~= nil and isDiscovered and currencyAmount > 0 then
                AlterCurrencies.UpdateTable(currencyId, currencyAmount) -- Store
            end
        end
    end
end

--------------------------
-- Get class color
--------------------------
function AlterCurrencies.ClassColor()
	_, unitCLass = UnitClass("player")
	if unitCLass then classColor = RAID_CLASS_COLORS[unitCLass]["colorStr"] end
end

-------------------------------------------------
-- If any of the registered events triggers, get 
-- currency info and store it
------------------------------------------------
function AlterCurrencies.OnEvent(self, event, arg1, arg2)
    if event == "PLAYER_ENTERING_WORLD" then -- Fill global variables
		unitName = UnitName("player")
		realmName = GetRealmName()
    AlterCurrencies.ClassColor() -- Get amounts and store them
    AlterCurrencies.GetCurrencyAmounts()
	end
    if event == "CURRENCY_DISPLAY_UPDATE" and arg2 ~= 0 then -- Fill global variables
    unitName = UnitName("player")
		realmName = GetRealmName()
    AlterCurrencies.ClassColor() -- Get amounts and store them
		AlterCurrencies.GetCurrencyAmounts()
	end
end

----------------------
-- Hook text on tooltip
----------------------
function AlterCurrencies.AddLine(tooltip, leftText, rightText)
	tooltip:AddDoubleLine(leftText, rightText)
	tooltip:Show() 
end

---------------------------------------------------
-- Append to tooltip text all currency information
---------------------------------------------------
function AlterCurrencies.AddToTooltip(tooltip, index)
    local id = tonumber(string.match(GetCurrencyListLink(index),"currency:(%d+)"))
    if type(ShiGuangDB) == "table" and ShiGuangDB ~= nil then -- If shared variable have data
        for currencyId, value_DB in pairs(ShiGuangDB) do -- For each stored currency
            if id == currencyId then -- If the hover is on this currency 
                if type(value_DB) == "table" and value_DB ~= nil then
                    AlterCurrencies.AddLine(tooltip, " ", " ") -- Space 
                    for realm, unit in pairs(value_DB) do
                        AlterCurrencies.AddLine(tooltip, "|cffffffff-"..realm.."-|r", nil)
                        local keys = {}
                        for k in pairs(unit) do 
                            table.insert(keys, k) 
                        end
                        table.sort(keys, function(a, b) -- Sort by amount
                            return unit[a]["currencyAmount"] > unit[b]["currencyAmount"]
                        end)
                        for _, k in ipairs(keys) do -- Paint two columns: character --- amount
                            AlterCurrencies.AddLine(tooltip, "|c"..unit[k]["colorStr"]..k.."|r", unit[k]["currencyAmount"]) 
                        end
                    end
                end
            end
        end
    end
end

-- Add amounts below Blizzard tooltip
hooksecurefunc(GameTooltip, "SetCurrencyToken", AlterCurrencies.AddToTooltip)
AlterCurrencies_Frame:SetScript("OnEvent", AlterCurrencies.OnEvent)