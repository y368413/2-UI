--## Author: Yuyuli  ## Version: 1.1.8
local PremadeSort = CreateFrame('Frame')

local C_LFGList, SecondsToTime = C_LFGList, SecondsToTime
local format = format

--Some Blizzard code
local roleRemainingKeyLookup = {
	["TANK"] = "TANK_REMAINING",
	["HEALER"] = "HEALER_REMAINING",
	["DAMAGER"] = "DAMAGER_REMAINING",
};

local function OnDoubleClick(self)
	local button = self:GetParent():GetParent():GetParent()
	if button.selectedResult then
		LFGListSearchPanel_SignUp(button)
		local dialog = LFGListApplicationDialog
		local override = false
		local tankOK = dialog.TankButton:IsShown() and dialog.TankButton.CheckButton:GetChecked()
		local healerOK = dialog.HealerButton:IsShown() and dialog.HealerButton.CheckButton:GetChecked()
		local damageOK = dialog.DamagerButton:IsShown() and dialog.DamagerButton.CheckButton:GetChecked()
		if not ( tankOK or healerOK or damageOK) then
			override = true
		end
		C_LFGList.ApplyToGroup(dialog.resultID, tankOK, healerOK, damageOK or override);
		StaticPopupSpecial_Hide(LFGListApplicationDialog)
	end
end

local function HasRemainingSlotsForLocalPlayerRole(lfgSearchResultID)
	local roles = C_LFGList.GetSearchResultMemberCounts(lfgSearchResultID);
	local playerRole = GetSpecializationRole(GetSpecialization());
	return roles[roleRemainingKeyLookup[playerRole]] > 0;
end

function LFGListUtil_SortSearchResultsCB(searchResultID1, searchResultID2)
	local searchResultInfo1 = C_LFGList.GetSearchResultInfo(searchResultID1);
	local searchResultInfo2 = C_LFGList.GetSearchResultInfo(searchResultID2);

	local hasRemainingRole1 = HasRemainingSlotsForLocalPlayerRole(searchResultID1);
	local hasRemainingRole2 = HasRemainingSlotsForLocalPlayerRole(searchResultID2);

	-- Groups with your current role available are preferred
	if (hasRemainingRole1 ~= hasRemainingRole2) then
		return hasRemainingRole1;
	end

	--If one has more friends, do that one first
	if ( searchResultInfo1.numBNetFriends ~= searchResultInfo2.numBNetFriends ) then
		return searchResultInfo1.numBNetFriends > searchResultInfo2.numBNetFriends;
	end

	if ( searchResultInfo1.numCharFriends ~= searchResultInfo2.numCharFriends ) then
		return searchResultInfo1.numCharFriends > searchResultInfo2.numCharFriends;
	end

	if ( searchResultInfo1.numGuildMates ~= searchResultInfo2.numGuildMates ) then
		return searchResultInfo1.numGuildMates > searchResultInfo2.numGuildMates;
	end

	if ( searchResultInfo1.age ~= searchResultInfo2.age ) then
		return searchResultInfo1.age < searchResultInfo2.age
	end

	return searchResultID1 < searchResultID2
end

local function hook_LFGListSearchEntry_Update(self)
	local searchResultInfo = C_LFGList.GetSearchResultInfo(self.resultID);
	local activityName, _, _, _, _, _, _, _, displayType = C_LFGList.GetActivityInfo(searchResultInfo.activityID);
	if displayType == LE_LFG_LIST_DISPLAY_TYPE_PLAYER_COUNT or displayType == LE_LFG_LIST_DISPLAY_TYPE_HIDE_ALL then
		self.Name:SetWidth(258);
		self.ActivityName:SetWidth(258);
	elseif displayType == LE_LFG_LIST_DISPLAY_TYPE_ROLE_COUNT then
		self.Name:SetWidth(176);
		self.ActivityName:SetWidth(176);
	else
		self.Name:SetWidth(200);
		self.ActivityName:SetWidth(200);
	end

	if searchResultInfo.age <= 60 then
		self.ActivityName:SetText(format("%s [|cff65DC3D%s|r]", activityName, searchResultInfo.age <= 0 and "Now" or SecondsToTime(searchResultInfo.age, false, false, 1, false)))
	else
		self.ActivityName:SetText(format("%s [|cffF7783C%s|r]", activityName, searchResultInfo.age <= 0 and "Now" or SecondsToTime(searchResultInfo.age, false, false, 1, false)))
	end

	if searchResultInfo.isDelisted then
		self:SetScript('OnDoubleClick', nil)
		return
	end

	self:SetScript('OnDoubleClick', OnDoubleClick)
end

PremadeSort:SetScript("OnEvent", PremadeSort.OnEvent)
hooksecurefunc("LFGListSearchEntry_Update", hook_LFGListSearchEntry_Update);