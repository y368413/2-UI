local _, ns = ...
local M, R, U, I = unpack(ns)

local function ReskinQuestHeader(header, isCalling)
	if header.styled then return end

	if header.Background then header.Background:SetAlpha(.7) end
	if header.Divider then header.Divider:Hide() end
	if header.TopFiligree then header.TopFiligree:Hide() end

	header.styled = true
end

local function ReskinSessionDialog(_, dialog)
	if not dialog.styled then
		M.StripTextures(dialog)
		M.SetBD(dialog)
		M.Reskin(dialog.ButtonContainer.Confirm)
		M.Reskin(dialog.ButtonContainer.Decline)
		if dialog.MinimizeButton then
			M.ReskinArrow(dialog.MinimizeButton, "down")
		end

		dialog.styled = true
	end
end

local function ReskinAWQHeader()
	--if C_AddOns.IsAddOnLoaded("AngrierWorldQuests") then
		local button = _G["AngrierWorldQuestsHeader"]
		if button and not button.styled then
			M.StripTextures(button)
			M.CreateBDFrame(button, .25)
			button:GetHighlightTexture():SetColorTexture(1, 1, 1, .25)

			button.styled = true
		end
	--end
end

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	-- Quest frame

	local QuestMapFrame = QuestMapFrame
	QuestMapFrame.VerticalSeparator:SetAlpha(0)

	local QuestScrollFrame = QuestScrollFrame
	QuestScrollFrame.Contents.Separator:SetAlpha(0)
	ReskinQuestHeader(QuestScrollFrame.Contents.StoryHeader)

	QuestScrollFrame.Background:SetAlpha(0)
	M.StripTextures(QuestScrollFrame.BorderFrame)
	M.StripTextures(QuestMapFrame.DetailsFrame.BackFrame)

	local campaignOverview = QuestMapFrame.CampaignOverview
	campaignOverview.BG:SetAlpha(0)
	ReskinQuestHeader(campaignOverview.Header)

	QuestScrollFrame.Edge:Hide()
	M.ReskinTrimScroll(QuestScrollFrame.ScrollBar)
	M.ReskinTrimScroll(campaignOverview.ScrollFrame.ScrollBar)
	M.ReskinEditBox(QuestScrollFrame.SearchBox)

	-- Quest details

	local DetailsFrame = QuestMapFrame.DetailsFrame
	local CompleteQuestFrame = DetailsFrame.CompleteQuestFrame

	M.StripTextures(DetailsFrame)
	M.StripTextures(DetailsFrame.ShareButton)
	DetailsFrame.Bg:SetAlpha(0)
	DetailsFrame.SealMaterialBG:SetAlpha(0)

	M.Reskin(DetailsFrame.AbandonButton)
	M.Reskin(DetailsFrame.ShareButton)
	M.Reskin(DetailsFrame.TrackButton)
	M.ReskinTrimScroll(QuestMapDetailsScrollFrame.ScrollBar)

	M.Reskin(DetailsFrame.BackFrame.BackButton)
	M.StripTextures(DetailsFrame.RewardsFrameContainer.RewardsFrame)

	DetailsFrame.AbandonButton:ClearAllPoints()
	DetailsFrame.AbandonButton:SetPoint("BOTTOMLEFT", DetailsFrame, -1, 0)
	DetailsFrame.AbandonButton:SetWidth(95)

	DetailsFrame.ShareButton:ClearAllPoints()
	DetailsFrame.ShareButton:SetPoint("LEFT", DetailsFrame.AbandonButton, "RIGHT", 1, 0)
	DetailsFrame.ShareButton:SetWidth(94)

	DetailsFrame.TrackButton:ClearAllPoints()
	DetailsFrame.TrackButton:SetPoint("LEFT", DetailsFrame.ShareButton, "RIGHT", 1, 0)
	DetailsFrame.TrackButton:SetWidth(96)

	-- Scroll frame

	hooksecurefunc("QuestLogQuests_Update", function()
		for button in QuestScrollFrame.headerFramePool:EnumerateActive() do
			if button.ButtonText then
				if not button.styled then
					M.StripTextures(button)
					M.CreateBDFrame(button, .25)
					button:GetHighlightTexture():SetColorTexture(1, 1, 1, .25)

					button.styled = true
				end
			end
		end

		for button in QuestScrollFrame.titleFramePool:EnumerateActive() do
			if not button.styled then
				if button.Checkbox then
					M.StripTextures(button.Checkbox, 2)
					M.CreateBDFrame(button.Checkbox, 0, true)
				end
				button.styled = true
			end
		end

		for header in QuestScrollFrame.campaignHeaderFramePool:EnumerateActive() do
			ReskinQuestHeader(header)
		end

		for header in QuestScrollFrame.campaignHeaderMinimalFramePool:EnumerateActive() do
			if header.CollapseButton and not header.styled then
				M.StripTextures(header)
				M.CreateBDFrame(header.Background, .25)
				header.Highlight:SetColorTexture(1, 1, 1, .25)
				header.styled = true
			end
		end

		for header in QuestScrollFrame.covenantCallingsHeaderFramePool:EnumerateActive() do
			ReskinQuestHeader(header, true)
		end

		ReskinAWQHeader()
	end)

	-- Map legend
	local mapLegend = QuestMapFrame.MapLegend
	if mapLegend then
		M.StripTextures(mapLegend.BorderFrame)
		M.Reskin(mapLegend.BackButton)
		M.ReskinTrimScroll(mapLegend.ScrollFrame.ScrollBar)
		M.StripTextures(mapLegend.ScrollFrame)
		M.CreateBDFrame(mapLegend.ScrollFrame, .25)
	end

	-- [[ Quest log popup detail frame ]]

	local QuestLogPopupDetailFrame = QuestLogPopupDetailFrame

	M.ReskinPortraitFrame(QuestLogPopupDetailFrame)
	M.Reskin(QuestLogPopupDetailFrame.AbandonButton)
	M.Reskin(QuestLogPopupDetailFrame.TrackButton)
	M.Reskin(QuestLogPopupDetailFrame.ShareButton)
	QuestLogPopupDetailFrame.SealMaterialBG:SetAlpha(0)
	M.ReskinTrimScroll(QuestLogPopupDetailFrameScrollFrame.ScrollBar)

	-- Show map button

	local ShowMapButton = QuestLogPopupDetailFrame.ShowMapButton

	ShowMapButton.Texture:SetAlpha(0)
	ShowMapButton.Highlight:SetTexture("")
	ShowMapButton.Highlight:SetTexture("")

	ShowMapButton:SetSize(ShowMapButton.Text:GetStringWidth() + 14, 22)
	ShowMapButton.Text:ClearAllPoints()
	ShowMapButton.Text:SetPoint("CENTER", 1, 0)

	ShowMapButton:ClearAllPoints()
	ShowMapButton:SetPoint("TOPRIGHT", QuestLogPopupDetailFrame, -30, -25)

	M.Reskin(ShowMapButton)

	ShowMapButton:HookScript("OnEnter", function(self)
		self.Text:SetTextColor(1, 1, 1)
	end)

	ShowMapButton:HookScript("OnLeave", function(self)
		self.Text:SetTextColor(1, .8, 0)
	end)

	-- Bottom buttons

	QuestLogPopupDetailFrame.ShareButton:ClearAllPoints()
	QuestLogPopupDetailFrame.ShareButton:SetPoint("LEFT", QuestLogPopupDetailFrame.AbandonButton, "RIGHT", 1, 0)
	QuestLogPopupDetailFrame.ShareButton:SetPoint("RIGHT", QuestLogPopupDetailFrame.TrackButton, "LEFT", -1, 0)

	-- Party Sync button

	local sessionManagement = QuestMapFrame.QuestSessionManagement
	sessionManagement.BG:Hide()
	M.CreateBDFrame(sessionManagement, .25)

	hooksecurefunc(QuestSessionManager, "NotifyDialogShow", ReskinSessionDialog)

	local executeSessionCommand = sessionManagement.ExecuteSessionCommand
	M.Reskin(executeSessionCommand)

	local icon = executeSessionCommand:CreateTexture(nil, "ARTWORK")
	icon:SetInside()
	executeSessionCommand.normalIcon = icon

	local sessionCommandToButtonAtlas = {
		[_G.Enum.QuestSessionCommand.Start] = "QuestSharing-DialogIcon",
		[_G.Enum.QuestSessionCommand.Stop] = "QuestSharing-Stop-DialogIcon"
	}

	hooksecurefunc(QuestMapFrame.QuestSessionManagement, "UpdateExecuteCommandAtlases", function(self, command)
		self.ExecuteSessionCommand:SetNormalTexture(0)
		self.ExecuteSessionCommand:SetPushedTexture(0)
		self.ExecuteSessionCommand:SetDisabledTexture(0)

		local atlas = sessionCommandToButtonAtlas[command]
		if atlas then
			self.ExecuteSessionCommand.normalIcon:SetAtlas(atlas)
		end
	end)
end)