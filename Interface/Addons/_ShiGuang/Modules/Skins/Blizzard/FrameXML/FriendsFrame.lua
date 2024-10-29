local _, ns = ...
local M, R, U, I = unpack(ns)

local atlasToTex = {
	["friendslist-invitebutton-horde-normal"] = "Interface\\FriendsFrame\\PlusManz-Horde",
	["friendslist-invitebutton-alliance-normal"] = "Interface\\FriendsFrame\\PlusManz-Alliance",
	["friendslist-invitebutton-default-normal"] = "Interface\\FriendsFrame\\PlusManz-PlusManz",
}
local function replaceInviteTex(self, atlas)
	local tex = atlasToTex[atlas]
	if tex then
		self.ownerIcon:SetTexture(tex)
	end
end

local function reskinFriendButton(button)
	if not button.styled then
		local gameIcon = button.gameIcon
		gameIcon:SetSize(22, 22)
		button.background:Hide()
		button:SetHighlightTexture(I.bdTex)
		button:GetHighlightTexture():SetVertexColor(.24, .56, 1, .2)

		local travelPass = button.travelPassButton
		travelPass:SetSize(22, 22)
		travelPass:SetPoint("TOPRIGHT", -3, -6)
		M.CreateBDFrame(travelPass, 1)
		travelPass.NormalTexture:SetAlpha(0)
		travelPass.PushedTexture:SetAlpha(0)
		travelPass.DisabledTexture:SetAlpha(0)
		travelPass.HighlightTexture:SetColorTexture(1, 1, 1, .25)
		travelPass.HighlightTexture:SetAllPoints()
		gameIcon:SetPoint("TOPRIGHT", travelPass, "TOPLEFT", -4, 0)

		local icon = travelPass:CreateTexture(nil, "ARTWORK")
		icon:SetTexCoord(.1, .9, .1, .9)
		icon:SetAllPoints()
		button.newIcon = icon
		travelPass.NormalTexture.ownerIcon = icon
		hooksecurefunc(travelPass.NormalTexture, "SetAtlas", replaceInviteTex)

		button.styled = true
	end
end

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	for i = 1, 4 do
		local tab = _G["FriendsFrameTab"..i]
		if tab then
			M.ReskinTab(tab)
			M.ResetTabAnchor(tab)
			if i ~= 1 then
				tab:ClearAllPoints()
				tab:SetPoint("TOPLEFT", _G["FriendsFrameTab"..(i-1)], "TOPRIGHT", -15, 0)
			end
		end
	end
	FriendsFrameIcon:Hide()
	M.StripTextures(IgnoreListFrame)

	local INVITE_RESTRICTION_NONE = 9
	hooksecurefunc("FriendsFrame_UpdateFriendButton", function(button)
		if button.gameIcon then
			reskinFriendButton(button)
		end

		if button.newIcon and button.buttonType == FRIENDS_BUTTON_TYPE_BNET then
			if FriendsFrame_GetInviteRestriction(button.id) == INVITE_RESTRICTION_NONE then
				button.newIcon:SetVertexColor(1, 1, 1)
			else
				button.newIcon:SetVertexColor(.5, .5, .5)
			end
		end
	end)

	hooksecurefunc("FriendsFrame_UpdateFriendInviteButton", function(button)
		if not button.styled then
			M.Reskin(button.AcceptButton)
			M.Reskin(button.DeclineButton)

			button.styled = true
		end
	end)

	hooksecurefunc("FriendsFrame_UpdateFriendInviteHeaderButton", function(button)
		if not button.styled then
			button:DisableDrawLayer("BACKGROUND")
			local bg = M.CreateBDFrame(button, .25)
			bg:SetInside(button, 2, 2)
			local hl = button:GetHighlightTexture()
			hl:SetColorTexture(.24, .56, 1, .2)
			hl:SetInside(bg)

			button.styled = true
		end
	end)

	-- FriendsFrameBattlenetFrame

	FriendsFrameBattlenetFrame:GetRegions():Hide()
	local bg = M.CreateBDFrame(FriendsFrameBattlenetFrame, .25)
	bg:SetPoint("TOPLEFT", 0, -2)
	bg:SetPoint("BOTTOMRIGHT", -2, 2)
	bg:SetBackdropColor(0, .6, 1, .25)

	local broadcastButton = FriendsFrameBattlenetFrame.BroadcastButton
	broadcastButton:SetSize(20, 20)
	broadcastButton:GetNormalTexture():SetAlpha(0)
	broadcastButton:GetPushedTexture():SetAlpha(0)
	M.Reskin(broadcastButton)
	local newIcon = broadcastButton:CreateTexture(nil, "ARTWORK")
	newIcon:SetAllPoints()
	newIcon:SetTexture("Interface\\FriendsFrame\\BroadcastIcon")

	local broadcastFrame = FriendsFrameBattlenetFrame.BroadcastFrame
	M.StripTextures(broadcastFrame)
	M.SetBD(broadcastFrame, nil, 10, -10, -10, 10)
	broadcastFrame.EditBox:DisableDrawLayer("BACKGROUND")
	local bg = M.CreateBDFrame(broadcastFrame.EditBox, 0, true)
	bg:SetPoint("TOPLEFT", -2, -2)
	bg:SetPoint("BOTTOMRIGHT", 2, 2)
	M.Reskin(broadcastFrame.UpdateButton)
	M.Reskin(broadcastFrame.CancelButton)
	broadcastFrame:ClearAllPoints()
	broadcastFrame:SetPoint("TOPLEFT", FriendsFrame, "TOPRIGHT", 3, 0)

	local unavailableFrame = FriendsFrameBattlenetFrame.UnavailableInfoFrame
	M.StripTextures(unavailableFrame)
	M.SetBD(unavailableFrame)
	unavailableFrame:SetPoint("TOPLEFT", FriendsFrame, "TOPRIGHT", 3, -18)

	M.ReskinPortraitFrame(FriendsFrame)
	M.Reskin(FriendsFrameAddFriendButton)
	M.Reskin(FriendsFrameSendMessageButton)
	M.Reskin(FriendsFrameIgnorePlayerButton)
	M.Reskin(FriendsFrameUnsquelchButton)
	M.ReskinTrimScroll(FriendsListFrame.ScrollBar)
	M.ReskinTrimScroll(IgnoreListFrame.ScrollBar)
	M.ReskinTrimScroll(WhoFrame.ScrollBar)
	M.ReskinTrimScroll(FriendsFriendsFrame.ScrollBar)
	M.ReskinDropDown(FriendsFrameStatusDropdown)
	M.ReskinDropDown(WhoFrameDropdown)
	M.ReskinDropDown(FriendsFriendsFrameDropdown)
	FriendsFrameStatusDropdown:SetWidth(58)
	M.Reskin(FriendsListFrameContinueButton)
	M.ReskinInput(AddFriendNameEditBox)
	M.StripTextures(AddFriendFrame)
	M.SetBD(AddFriendFrame)
	M.StripTextures(FriendsFriendsFrame)
	M.SetBD(FriendsFriendsFrame)
	M.Reskin(FriendsFriendsFrame.SendRequestButton)
	M.Reskin(FriendsFriendsFrame.CloseButton)
	M.Reskin(WhoFrameWhoButton)
	M.Reskin(WhoFrameAddFriendButton)
	M.Reskin(WhoFrameGroupInviteButton)
	M.Reskin(AddFriendEntryFrameAcceptButton)
	M.Reskin(AddFriendEntryFrameCancelButton)
	M.Reskin(AddFriendInfoFrameContinueButton)

	for i = 1, 4 do
		M.StripTextures(_G["WhoFrameColumnHeader"..i])
	end

	M.StripTextures(WhoFrameListInset)
	WhoFrameEditBoxInset:Hide()
	local whoBg = M.CreateBDFrame(WhoFrameEditBox, 0, true)
	whoBg:SetPoint("TOPLEFT", WhoFrameEditBoxInset)
	whoBg:SetPoint("BOTTOMRIGHT", WhoFrameEditBoxInset, -1, 1)

	for i = 1, 3 do
		M.StripTextures(_G["FriendsTabHeaderTab"..i])
	end

	WhoFrameWhoButton:SetPoint("RIGHT", WhoFrameAddFriendButton, "LEFT", -1, 0)
	WhoFrameAddFriendButton:SetPoint("RIGHT", WhoFrameGroupInviteButton, "LEFT", -1, 0)
	FriendsFrameTitleText:SetPoint("TOP", FriendsFrame, "TOP", 0, -8)

	-- Recruite frame

	RecruitAFriendFrame.SplashFrame.Description:SetTextColor(1, 1, 1)
	M.Reskin(RecruitAFriendFrame.SplashFrame.OKButton)
	M.StripTextures(RecruitAFriendFrame.RewardClaiming)
	M.Reskin(RecruitAFriendFrame.RewardClaiming.ClaimOrViewRewardButton)
	M.Reskin(RecruitAFriendFrame.RecruitmentButton)

	local recruitList = RecruitAFriendFrame.RecruitList
	M.StripTextures(recruitList.Header)
	M.CreateBDFrame(recruitList.Header, .25)
	recruitList.ScrollFrameInset:Hide()
	M.ReskinTrimScroll(recruitList.ScrollBar)

	local recruitmentFrame = RecruitAFriendRecruitmentFrame
	M.StripTextures(recruitmentFrame)
	M.ReskinClose(recruitmentFrame.CloseButton)
	M.SetBD(recruitmentFrame)
	M.StripTextures(recruitmentFrame.EditBox)
	local bg = M.CreateBDFrame(recruitmentFrame.EditBox, .25)
	bg:SetPoint("TOPLEFT", -3, -3)
	bg:SetPoint("BOTTOMRIGHT", 0, 3)
	M.Reskin(recruitmentFrame.GenerateOrCopyLinkButton)

	local rewardsFrame = RecruitAFriendRewardsFrame
	M.StripTextures(rewardsFrame)
	M.ReskinClose(rewardsFrame.CloseButton)
	M.SetBD(rewardsFrame)

	rewardsFrame:HookScript("OnShow", function(self)
		for i = 1, self:GetNumChildren() do
			local child = select(i, self:GetChildren())
			local button = child and child.Button
			if button and not button.styled then
				M.ReskinIcon(button.Icon)
				button.IconBorder:Hide()
				button:GetHighlightTexture():SetColorTexture(1, 1, 1, .25)

				button.styled = true
			end
		end
	end)
end)