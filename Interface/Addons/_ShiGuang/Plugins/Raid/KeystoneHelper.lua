--## Author: Semlar ## Version: 8.3.0.1
C_MythicPlus.RequestRewards()
local function GetModifiers(linkType, ...)
	if type(linkType) ~= 'string' then return end
	local modifierOffset = 4
	local itemID, instanceID, mythicLevel, notDepleted, _ = ... -- "keystone" links
	if linkType:find('item') then -- only used for ItemRefTooltip currently
		_, _, _, _, _, _, _, _, _, _, _, _, _, instanceID, mythicLevel = ...
		if ... == '138019' or ... == '158923' then -- mythic keystone
			modifierOffset = 16
		else
			return
		end
	elseif not linkType:find('keystone') then
		return
	end

	local modifiers = {}
	for i = modifierOffset, select('#', ...) do
		local num = strmatch(select(i, ...) or '', '^(%d+)')
		if num then
			local modifierID = tonumber(num)
			--if not modifierID then break end
			tinsert(modifiers, modifierID)
		end
	end
	local numModifiers = #modifiers
	if modifiers[numModifiers] and modifiers[numModifiers] < 2 then
		tremove(modifiers, numModifiers)
	end
	return modifiers, instanceID, mythicLevel
end

function MythicLootItemLevel(mlvl)
 if (mlvl == "2" or mlvl == "3") then
  return "435"
 elseif (mlvl == "4") then
  return "440"
 elseif (mlvl == "5" or mlvl == "6") then
  return "445"
 elseif (mlvl == "7") then
  return "450"
 elseif (mlvl == "8" or mlvl == "9" or mlvl == "10") then
  return "455"
 elseif (mlvl == "11" or mlvl == "12" or mlvl == "13") then
  return "460"
 elseif (mlvl >= "14") then
  return "465"
 else
  return ""
 end
end

function MythicWeeklyLootItemLevel(mlvl)
 if (mlvl == "2") then
  return "440"
 elseif (mlvl == "3") then
  return "445"
 elseif (mlvl == "4" or mlvl == "5") then
  return "450"
 elseif (mlvl == "6") then
  return "455"
 elseif (mlvl == "7" or mlvl == "8" or mlvl == "9") then
  return "460"
 elseif (mlvl == "10" or mlvl == "11") then
  return "465"
 elseif (mlvl == "12" or mlvl == "13" or mlvl == "14") then
  return "470"
 elseif (mlvl >= "15") then
  return "475"
 else
  return ""
 end
end

function MythicWeeklyResiduumAmount(mlvl)
 if (mlvl == "2") then
  return "？"
 elseif (mlvl == "3") then
  return "？"
 elseif (mlvl == "4") then
  return "？"
 elseif (mlvl == "5") then
  return "68"
 elseif (mlvl == "6") then
  return "75"
 elseif (mlvl == "7") then
  return "？"
 elseif (mlvl == "8") then
  return "？"
 elseif (mlvl == "9") then
  return "？"
 elseif (mlvl == "10") then
  return "1700"
 elseif (mlvl == "11") then
  return "1790" 
 elseif (mlvl == "12") then
  return "1880"  
 elseif (mlvl == "13") then
  return "1970"
 elseif (mlvl == "14") then
  return "2060"
 elseif (mlvl == "15") then
  return "2150"
 elseif (mlvl == "16") then
  return "2240"
 elseif (mlvl == "17") then
  return "2330"
 elseif (mlvl == "18") then
  return "2420"
 elseif (mlvl == "19") then
  return "2510"
 elseif (mlvl == "20") then
  return "2600"
 elseif (mlvl == "21") then
  return "2665"
 elseif (mlvl == "22") then
  return "2730"
 elseif (mlvl == "23") then
  return "2795"
 elseif (mlvl == "24") then
  return "2860"
 elseif (mlvl == "25") then
  return "2915"
 else
  return ""
 end
end

local function DecorateTooltip(self, link, _)
	if not link then
		_, link = self:GetItem()
	end
	if type(link) == 'string' then
		local modifiers, instanceID, mythicLevel = GetModifiers(strsplit(':', link))
		if modifiers then
			--for _, modifierID in ipairs(modifiers) do
				--local modifierName, modifierDescription = C_ChallengeMode.GetAffixInfo(modifierID)
				--if modifierName and modifierDescription then
					--self:AddLine(modifierName.. " - |cffff00ff" .. modifierDescription.."|r" , 0, 1, 0, true)
				--end
			--end
			--if instanceID then
				--local name, id, timeLimit, texture, backgroundTexture = C_ChallengeMode.GetMapUIInfo(instanceID)
				--if timeLimit then
					--self:AddLine('Time Limit: ' .. SecondsToTime(timeLimit, false, true), 1, 1, 1)
				--end
			--end
			if mythicLevel then
				local weeklyRewardLevel, endOfRunRewardLevel = C_MythicPlus.GetRewardLevelForDifficultyLevel(mythicLevel)
				if weeklyRewardLevel ~= 0 then
								self:AddDoubleLine("|cffff00ff"..WEEKLY..REWARD.."|r", weeklyRewardLevel, 1, 1, 1,true)
								self:AddDoubleLine("|cffff00ff"..INSTANCE..LOOT.."|r", MythicLootItemLevel(mythicLevel) .. "+", 1,1,1,true)
								self:AddDoubleLine("|cffff00ff"..WEEKLY..REWARD.."|r", MythicWeeklyResiduumAmount(mythicLevel), 1, 1, 1,true)
				end
			end
			-- C_MythicPlus.GetRewardLevelForDifficultyLevel(9)
			-- -> 375, 365 (weeklyRewardLevel, endOfRunRewardLevel)
			self:Show()
		end
	end
end
-- hack to handle ItemRefTooltip:GetItem() not returning a proper keystone link
hooksecurefunc(ItemRefTooltip, 'SetHyperlink', DecorateTooltip) 
--ItemRefTooltip:HookScript('OnTooltipSetItem', DecorateTooltip)
GameTooltip:HookScript('OnTooltipSetItem', DecorateTooltip)

--[[do
	-- Auto-slot keystone when interacting with the pedastal 
	local f = CreateFrame('frame')
	f:SetScript('OnEvent', function(self, event, addon)
		if addon == 'Blizzard_ChallengesUI' then
			ChallengesKeystoneFrame:HookScript('OnShow', function()
				-- todo: see if PickupItem(158923) works for this
				if not C_ChallengeMode.GetSlottedKeystoneInfo() then
					for bag = 0, NUM_BAG_SLOTS do
						for slot = 1, GetContainerNumSlots(bag) do
							if GetContainerItemID == 158923 then
								PickupContainerItem(bag, slot)
								if CursorHasItem() then
									C_ChallengeMode.SlotKeystone()
								end
							end
						end
					end
				end
			end)
			self:UnregisterEvent(event)
		end
	end)
	f:RegisterEvent('ADDON_LOADED')
end]]

--------------------
    local KeyReword = CreateFrame("Frame"); 
    KeyReword:RegisterEvent("ADDON_LOADED") 
    KeyReword:SetScript("OnEvent", function(self, event, addon) 
        if addon ~= "Blizzard_ChallengesUI" then return end 
    --levels           1    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20
        local drops  = { nil, 435, 435, 440, 445, 445, 450, 455, 455, 455, 460, 460, 460, 465, 465, 465, 465, 465, 465, 465, 465, 465, 465, 465, 465 }
        local levels = { nil, 440, 445, 450, 450, 455, 460, 460, 460, 465, 465, 470, 470, 470, 475, 475, 475, 475, 475, 475, 475, 475, 475, 475, 475 }
        local titans = { nil, nil, nil, nil, nil,  75, 330, 365, 400, 1700, 1790, 1880, 1970, 2060, 2150, 2240, 2330, 2420, 2510, 2600, 2665,2730,2795,2860,2915}
        ChallengesFrame.WeeklyInfo.Child.WeeklyChest:HookScript("OnEnter", function(self) 
            if GameTooltip:IsVisible() then 
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine("|cff00ff00".." 钥石层数  掉落  周箱  奖励精华".."|r") 
                local start = 2 
                if self.level and self.level > 0 then 
                    start = self.level - 8 
                elseif self.ownedKeystoneLevel and self.ownedKeystoneLevel > 0 then 
                    --start = self.ownedKeystoneLevel - 5 
                end 
                for i = start, start + 12 do 
                    if levels[i] or titans[i] then 
                        local line = "    %2d层 |T130758:10:15:0:0:32:32:10:22:10:22|t %s |T130758:10:10:0:0:32:32:10:22:10:22|t %s |T130758:10:15:0:0:32:32:10:22:10:22|t %s"
                        local drop = drops[i] and format("%d", drops[i]) or " ? "
                        local level = levels[i] and format("%d", levels[i]) or " ? " 
                        local titan = titans[i] and format("%4d", titans[i]) or "  ? " 
                    if i == self.level then line = "|cff00ff00"..line.."|r" end
                        GameTooltip:AddLine(format(line, i, drop, level, titan)) 
                    else 
                        break 
                    end 
                end  
            GameTooltip:AddLine("")
            GameTooltip:AddLine("445随机 需要175  分解返40")
            GameTooltip:AddLine("460随机 需要900  分解返200")
            GameTooltip:AddLine("475随机 需要4750 分解返1000 指定需要2万")
            GameTooltip:AddLine("仅分解8.3版本|cffff0000同甲|r特质装才返")
            GameTooltip:Show() 
            end 
        end) 
    end) 
    
--------------------
    local PVPReword = CreateFrame("Frame"); 
    PVPReword:RegisterEvent("ADDON_LOADED") 
    PVPReword:SetScript("OnEvent", function(self, event, addon) 
        if addon ~= "Blizzard_PVPUI" then return end 
    local ratings  = { "0000~1399", "1400~1599", "1600~1799", "1800~2099", "2100~2399", "2400~9999" }
    local match =    { 430,       440,        450,         455,         460,         465 }
    local weekly =   { 445,       455,        460,         465,         470,         475 }
    local weekly2 =  { 445,       460,        460,         475,         475,         475 }
    PVPQueueFrame.HonorInset.RatedPanel.WeeklyChest:HookScript("OnEnter", function(self)
        if GameTooltip:IsVisible() then
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("PVP等级  比赛结束  低保散件  低保特质")
            for i, v in ipairs(ratings) do
            local line = " %9s |T130758:10:20:0:0:32:32:10:22:10:22|t %d |T130758:10:28:0:0:32:32:10:22:10:22|t %d |T130758:10:35:0:0:32:32:10:22:10:22|t %d"
                GameTooltip:AddLine(format(line, ratings[i], match[i], weekly[i], weekly2[i]))
            end

            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("500征服 首周440，2~9周445，10~25周460")
            GameTooltip:Show()
        end
    end)
    end) 