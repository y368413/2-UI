local _, ns = ...
local M, R, U, I = unpack(ns)
local r, g, b = I.r, I.g, I.b

local function scrollOnEnter(self)
	self.thumbBG:SetBackdropColor(r, g, b, .25)
	self.thumbBG:SetBackdropBorderColor(r, g, b)
end

local function scrollOnLeave(self)
	self.thumbBG:SetBackdropColor(0, 0, 0, 0)
	self.thumbBG:SetBackdropBorderColor(0, 0, 0)
end

local function ReskinChatScroll(self)
	local bu = _G[self:GetName().."ThumbTexture"]
	bu:SetAlpha(0)
	bu:SetWidth(16)
	local bg = M.CreateBDFrame(bu, 0, true)
	local down = self.ScrollToBottomButton
	M.ReskinArrow(down, "down")
	down:SetPoint("BOTTOMRIGHT", _G[self:GetName().."ResizeButton"], "TOPRIGHT", -4, -2)

	self.ScrollBar.thumbBG = bg
	self.ScrollBar:HookScript("OnEnter", scrollOnEnter)
	self.ScrollBar:HookScript("OnLeave", scrollOnLeave)
end

tinsert(R.defaultThemes, function()

	-- Battlenet toast frame
	BNToastFrame:SetBackdrop(nil)
	M.SetBD(BNToastFrame)
	BNToastFrame.TooltipFrame:HideBackdrop()
	M.SetBD(BNToastFrame.TooltipFrame)

	TimeAlertFrame:SetBackdrop(nil)
	M.SetBD(TimeAlertFrame)

	-- Battletag invite frame
	local border, send, cancel = BattleTagInviteFrame:GetChildren()
	border:Hide()
	M.Reskin(send)
	M.Reskin(cancel)
	M.SetBD(BattleTagInviteFrame)

	local friendTex = "Interface\\HELPFRAME\\ReportLagIcon-Chat"
	local queueTex = "Interface\\HELPFRAME\\HelpIcon-ItemRestoration"
	local homeTex = "Interface\\Buttons\\UI-HomeButton"

	QuickJoinToastButton.FriendsButton:SetTexture(friendTex)
	QuickJoinToastButton.QueueButton:SetTexture(queueTex)
	QuickJoinToastButton:SetHighlightTexture("")
	hooksecurefunc(QuickJoinToastButton, "ToastToFriendFinished", function(self)
		self.FriendsButton:SetShown(not self.displayedToast)
	end)
	hooksecurefunc(QuickJoinToastButton, "UpdateQueueIcon", function(self)
		if not self.displayedToast then return end
		self.QueueButton:SetTexture(queueTex)
		self.FlashingLayer:SetTexture(queueTex)
		self.FriendsButton:SetShown(false)
	end)
	QuickJoinToastButton:HookScript("OnMouseDown", function(self)
		self.FriendsButton:SetTexture(friendTex)
	end)
	QuickJoinToastButton:HookScript("OnMouseUp", function(self)
		self.FriendsButton:SetTexture(friendTex)
	end)
	QuickJoinToastButton.Toast.Background:SetTexture("")
	local bg = M.SetBD(QuickJoinToastButton.Toast)
	bg:SetPoint("TOPLEFT", 10, -1)
	bg:SetPoint("BOTTOMRIGHT", 0, 3)
	bg:Hide()
	hooksecurefunc(QuickJoinToastButton, "ShowToast", function() bg:Show() end)
	hooksecurefunc(QuickJoinToastButton, "HideToast", function() bg:Hide() end)

	-- ChatFrame
	M.Reskin(ChatFrameChannelButton)
	ChatFrameChannelButton:SetSize(20, 20)
	M.Reskin(ChatFrameToggleVoiceDeafenButton)
	ChatFrameToggleVoiceDeafenButton:SetSize(20, 20)
	M.Reskin(ChatFrameToggleVoiceMuteButton)
	ChatFrameToggleVoiceMuteButton:SetSize(20, 20)
	--ChatFrameMenuButton:SetSize(20, 20)
	--ChatFrameMenuButton:SetNormalTexture(homeTex)
	--ChatFrameMenuButton:SetPushedTexture(homeTex)

	for i = 1, NUM_CHAT_WINDOWS do
		ReskinChatScroll(_G["ChatFrame"..i])
	end

	--[[ ChannelFrame
	M.ReskinPortraitFrame(ChannelFrame)
	M.Reskin(ChannelFrame.NewButton)
	M.Reskin(ChannelFrame.SettingsButton)
	M.ReskinScroll(ChannelFrame.ChannelList.ScrollBar)
	M.ReskinScroll(ChannelFrame.ChannelRoster.ScrollFrame.scrollBar)

	hooksecurefunc(ChannelFrame.ChannelList, "Update", function(self)
		for i = 1, self.Child:GetNumChildren() do
			local tab = select(i, self.Child:GetChildren())
			if not tab.styled and tab:IsHeader() then
				tab:SetNormalTexture("")
				tab.bg = M.CreateBDFrame(tab, .25)
				tab.bg:SetAllPoints()

				tab.styled = true
			end
		end
	end)]]

	M.StripTextures(CreateChannelPopup)
	M.SetBD(CreateChannelPopup)
	M.Reskin(CreateChannelPopup.OKButton)
	M.Reskin(CreateChannelPopup.CancelButton)
	--M.ReskinClose(CreateChannelPopup.CloseButton)
	M.ReskinInput(CreateChannelPopup.Name)
	M.ReskinInput(CreateChannelPopup.Password)

	M.SetBD(VoiceChatPromptActivateChannel)
	M.Reskin(VoiceChatPromptActivateChannel.AcceptButton)
	VoiceChatChannelActivatedNotification:SetBackdrop(nil)
	M.SetBD(VoiceChatChannelActivatedNotification)

	M.ReskinSlider(UnitPopupVoiceMicrophoneVolume.Slider)
	M.ReskinSlider(UnitPopupVoiceSpeakerVolume.Slider)

	-- VoiceActivityManager
	hooksecurefunc(VoiceActivityManager, "LinkFrameNotificationAndGuid", function(_, _, notification, guid)
		local class = select(2, GetPlayerInfoByGUID(guid))
		if class then
			local color = I.ClassColors[class]
			if notification.Name then
				notification.Name:SetTextColor(color.r, color.g, color.b)
			end
		end
	end)
end)