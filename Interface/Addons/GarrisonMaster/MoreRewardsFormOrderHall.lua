function OrderHallMissionFrame_MissionTab_MissionList_Update_MoreRewardsHook(self)
	if (not OrderHallMissionFrame or not self:IsShown()) or (not BFAMissionFrame or not self:IsShown()) then return; end
	local MoreRewardsmissions = self.showInProgress and self.inProgressMissions or self.availableMissions;
	local MoreRewardsbuttons = self.listScroll.buttons;
		for i = 1, #MoreRewardsbuttons do
			local button = MoreRewardsbuttons[i];
			button:SetWidth(850);
			local index = HybridScrollFrame_GetOffset(self.listScroll) + i;
			if (index <= #MoreRewardsmissions) then
				local MoreRewardsmission = MoreRewardsmissions[index];
				local allMissionRewards = {};
				local allMissionRewardsCount = 0;
				if (MoreRewardsmission.rewards) then
					for j = 1, #MoreRewardsmission.rewards do
						allMissionRewardsCount = allMissionRewardsCount + 1;
						allMissionRewards[allMissionRewardsCount] = MoreRewardsmission.rewards[j];
					end
				end
				if (MoreRewardsmission.overmaxRewards) then
					for j = 1, #MoreRewardsmission.overmaxRewards do
						allMissionRewardsCount = allMissionRewardsCount + 1;
						allMissionRewards[allMissionRewardsCount] = MoreRewardsmission.overmaxRewards[j];
					end
				end
				GarrisonMissionButton_SetRewards(button, allMissionRewards);
				for j = 1, #button.Rewards do
					button.Rewards[j]:SetSize(48, 48);
					if (j <= allMissionRewardsCount) then button.Rewards[j]:Show(); else button.Rewards[j]:Hide(); end
					if (j ~= 1) then button.Rewards[j]:SetPoint("LEFT", button.Rewards[j - 1], "RIGHT", - 48 - 12 - 48, 0); end
					--else button.Rewards[j]:SetPoint("RIGHT", button, "RIGHT", -12 - (12 + 48) * (allMissionRewardsCount - 1), 0);
					--button.Rewards[j].Icon:SetMask("Interface\\ICONS\\INV_Helmet_47");  --Fix for NDui
					if (not button.Rewards[j].bonusIcon) then
						button.Rewards[j].bonusIcon = CreateFrame("Frame", nil, button);
						button.Rewards[j].bonusIcon:SetSize(28, 28);
						button.Rewards[j].bonusIcon:SetPoint("CENTER", button.Rewards[j], "TOPLEFT", 8, -8);
						button.Rewards[j].bonusIcon:SetHitRectInsets(4, 4, 1, 4);
						button.Rewards[j].bonusIcon.texture = button.Rewards[j].bonusIcon:CreateTexture(nil, "ARTWORK", nil, 2);
						button.Rewards[j].bonusIcon.texture:SetAtlas("honorsystem-icon-bonus");
						button.Rewards[j].bonusIcon.texture:SetSize(28, 28);
						button.Rewards[j].bonusIcon.texture:SetPoint("CENTER", button.Rewards[j].bonusIcon, "CENTER", 0, 0);
						button.Rewards[j].bonusIcon:SetScript("OnEnter", function(self, motion)
								GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
								GameTooltip:SetText(BONUS_REWARDS, nil, nil, nil, nil, true);
							end);
						button.Rewards[j].bonusIcon:SetScript("OnLeave", GameTooltip_Hide);
					end
					if (#MoreRewardsmission.rewards < j) and (j <= allMissionRewardsCount) then button.Rewards[j].bonusIcon:Show(); else button.Rewards[j].bonusIcon:Hide(); end
				end
			end
		end
end

local MoreRewardsFormOrderHall = CreateFrame("Frame");
MoreRewardsFormOrderHall:RegisterEvent("ADDON_LOADED");
MoreRewardsFormOrderHall:SetScript("OnEvent", function(self, event)
		if (event == "ADDON_LOADED") then
		  if (not OrderHallMissionFrame or not OrderHallMissionFrame.MissionTab.MissionList:IsShown()) or (not BFAMissionFrame or not BFAMissionFrame.MissionTab.MissionList:IsShown()) then return; end
			local OrderHallMissionFrame_MissionTab_MissionList_Update = OrderHallMissionFrame.MissionTab.MissionList.Update;
			local BFAMissionFrame_MissionTab_MissionList_Update = BFAMissionFrame.MissionTab.MissionList.Update;
			function OrderHallMissionFrame.MissionTab.MissionList:Update()
				OrderHallMissionFrame_MissionTab_MissionList_Update(self);
				OrderHallMissionFrame_MissionTab_MissionList_Update_MoreRewardsHook(self);
			end
			function BFAMissionFrame.MissionTab.MissionList:Update()
				BFAMissionFrame_MissionTab_MissionList_Update(self);
				OrderHallMissionFrame_MissionTab_MissionList_Update_MoreRewardsHook(self);
			end
		end
	end);
