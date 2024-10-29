local _, ns = ...
local M, R, U, I = unpack(ns)

local function UpdateProgressItemQuality(self)
	local button = self.__owner
	local index = button:GetID()
	local buttonType = button.type
	local objectType = button.objectType

	local quality
	if objectType == "item" then
		quality = select(4, GetQuestItemInfo(buttonType, index))
	elseif objectType == "currency" then
		local info = C_QuestOffer.GetQuestRequiredCurrencyInfo(index)
		quality = info and info.quality
	end

	local color = I.QualityColors[quality or 1]
	button.bg:SetBackdropBorderColor(color.r, color.g, color.b)
end

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	M.ReskinPortraitFrame(QuestFrame)

	M.StripTextures(QuestFrameDetailPanel, 0)
	M.StripTextures(QuestFrameRewardPanel, 0)
	M.StripTextures(QuestFrameProgressPanel, 0)
	M.StripTextures(QuestFrameGreetingPanel, 0)

	local line = QuestFrameGreetingPanel:CreateTexture()
	line:SetColorTexture(1, 1, 1, .25)
	line:SetSize(256, R.mult)
	line:SetPoint("CENTER", QuestGreetingFrameHorizontalBreak)
	QuestGreetingFrameHorizontalBreak:SetTexture("")
	QuestFrameGreetingPanel:HookScript("OnShow", function()
		line:SetShown(QuestGreetingFrameHorizontalBreak:IsShown())
	end)

	for i = 1, MAX_REQUIRED_ITEMS do
		local button = _G["QuestProgressItem"..i]
		button.NameFrame:Hide()
		button.bg = M.ReskinIcon(button.Icon)
		button.Icon.__owner = button
		hooksecurefunc(button.Icon, "SetTexture", UpdateProgressItemQuality)

		local bg = M.CreateBDFrame(button, .25)
		bg:SetPoint("TOPLEFT", button.bg, "TOPRIGHT", 2, 0)
		bg:SetPoint("BOTTOMRIGHT", button.bg, 100, 0)
	end

	QuestDetailScrollFrame:SetWidth(302) -- else these buttons get cut off

	hooksecurefunc(QuestProgressRequiredMoneyText, "SetTextColor", function(self, r)
		if r == 0 then
			self:SetTextColor(.8, .8, .8)
		elseif r == .2 then
			self:SetTextColor(1, 1, 1)
		end
	end)

	M.Reskin(QuestFrameAcceptButton)
	M.Reskin(QuestFrameDeclineButton)
	M.Reskin(QuestFrameCompleteQuestButton)
	M.Reskin(QuestFrameCompleteButton)
	M.Reskin(QuestFrameGoodbyeButton)
	M.Reskin(QuestFrameGreetingGoodbyeButton)

	M.ReskinTrimScroll(QuestProgressScrollFrame.ScrollBar)
	M.ReskinTrimScroll(QuestRewardScrollFrame.ScrollBar)
	M.ReskinTrimScroll(QuestDetailScrollFrame.ScrollBar)
	M.ReskinTrimScroll(QuestGreetingScrollFrame.ScrollBar)

	-- Text colour stuff

	QuestProgressRequiredItemsText:SetTextColor(1, .8, 0)
	QuestProgressRequiredItemsText:SetShadowColor(0, 0, 0)
	QuestProgressRequiredItemsText.SetTextColor = M.Dummy
	QuestProgressTitleText:SetTextColor(1, .8, 0)
	QuestProgressTitleText:SetShadowColor(0, 0, 0)
	QuestProgressTitleText.SetTextColor = M.Dummy
	QuestProgressText:SetTextColor(1, 1, 1)
	QuestProgressText.SetTextColor = M.Dummy
	GreetingText:SetTextColor(1, 1, 1)
	GreetingText.SetTextColor = M.Dummy
	AvailableQuestsText:SetTextColor(1, .8, 0)
	AvailableQuestsText.SetTextColor = M.Dummy
	AvailableQuestsText:SetShadowColor(0, 0, 0)
	CurrentQuestsText:SetTextColor(1, .8, 0)
	CurrentQuestsText.SetTextColor = M.Dummy
	CurrentQuestsText:SetShadowColor(0, 0, 0)

	-- Quest NPC model

	M.StripTextures(QuestModelScene)
	local bg = M.SetBD(QuestModelScene)
	M.StripTextures(QuestModelScene.ModelTextFrame)
	bg:SetOutside(nil, nil, nil, QuestModelScene.ModelTextFrame)

	if QuestNPCModelTextScrollFrame then
		M.ReskinTrimScroll(QuestNPCModelTextScrollFrame.ScrollBar)
	end

	hooksecurefunc("QuestFrame_ShowQuestPortrait", function(parentFrame, _, _, _, _, _, x, y)
		x = x + 6
		QuestModelScene:SetPoint("TOPLEFT", parentFrame, "TOPRIGHT", x, y)
	end)

	-- Friendship
	for i = 1, 4 do
		local notch = QuestFrame.FriendshipStatusBar["Notch"..i]
		if notch then
			notch:SetColorTexture(0, 0, 0)
			notch:SetSize(R.mult, 16)
		end
	end
	QuestFrame.FriendshipStatusBar.BarBorder:Hide()
end)