local _, ns = ...
local B, C, L, DB = unpack(ns)
local r, g, b = DB.r, DB.g, DB.b

local function ReskinChatScroll(self)
	B.ReskinTrimScroll(self.ScrollBar)

	B.StripTextures(self.ScrollToBottomButton)
	local flash = self.ScrollToBottomButton.Flash
	B.SetupArrow(flash, "down")
	flash:SetVertexColor(1, .8, 0)
end

tinsert(C.defaultThemes, function()
	TimeAlertFrame:SetBackdrop(nil)
	B.SetBD(TimeAlertFrame)

	-- ChatFrame
	B.Reskin(ChatFrameChannelButton)
	ChatFrameChannelButton:SetSize(20, 20)
	B.Reskin(ChatFrameToggleVoiceDeafenButton)
	ChatFrameToggleVoiceDeafenButton:SetSize(20, 20)
	B.Reskin(ChatFrameToggleVoiceMuteButton)
	ChatFrameToggleVoiceMuteButton:SetSize(20, 20)
	--ChatFrameMenuButton:SetSize(20, 20)
	--ChatFrameMenuButton:SetNormalTexture(homeTex)
	--ChatFrameMenuButton:SetPushedTexture(homeTex)

	for i = 1, NUM_CHAT_WINDOWS do
		ReskinChatScroll(_G["ChatFrame"..i])
	end

	B.SetBD(VoiceChatPromptActivateChannel)
	B.Reskin(VoiceChatPromptActivateChannel.AcceptButton)
	VoiceChatChannelActivatedNotification:SetBackdrop(nil)
	B.SetBD(VoiceChatChannelActivatedNotification)

	-- VoiceActivityManager
	hooksecurefunc(VoiceActivityManager, "LinkFrameNotificationAndGuid", function(_, _, notification, guid)
		local class = select(2, GetPlayerInfoByGUID(guid))
		if class then
			local color = DB.ClassColors[class]
			if notification.Name then
				notification.Name:SetTextColor(color.r, color.g, color.b)
			end
		end
	end)
end)