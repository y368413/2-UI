local _, ns = ...
local M, R, U, I = unpack(ns)
local r, g, b = I.r, I.g, I.b

local function ReskinChatScroll(self)
	M.ReskinTrimScroll(self.ScrollBar)

	M.StripTextures(self.ScrollToBottomButton)
	local flash = self.ScrollToBottomButton.Flash
	M.SetupArrow(flash, "down")
	flash:SetVertexColor(1, .8, 0)
end

tinsert(R.defaultThemes, function()
	TimeAlertFrame:SetBackdrop(nil)
	M.SetBD(TimeAlertFrame)

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

	M.SetBD(VoiceChatPromptActivateChannel)
	M.Reskin(VoiceChatPromptActivateChannel.AcceptButton)
	VoiceChatChannelActivatedNotification:SetBackdrop(nil)
	M.SetBD(VoiceChatChannelActivatedNotification)

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