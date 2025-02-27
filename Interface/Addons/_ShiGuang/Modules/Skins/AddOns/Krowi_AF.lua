local _, ns = ...
local M, R, U, I = unpack(ns)
local S = M:GetModule("Skins")

local _G = _G
local strfind = strfind
local cr, cg, cb = I.r, I.g, I.b

local function SetupButtonHighlight(button, bg)
	if button.Highlight then
		M.StripTextures(button.Highlight)
	end
	button:SetHighlightTexture(I.bdTex)
	local hl = button:GetHighlightTexture()
	hl:SetVertexColor(cr, cg, cb, .25)
	hl:SetInside(bg)
end

local function SetupStatusbar(bar)
	M.StripTextures(bar)
	bar:SetStatusBarTexture(I.bdTex)
	bar:GetStatusBarTexture():SetGradient("VERTICAL", CreateColor(0, .4, 0, 1), CreateColor(0, .6, 0, 1))
	M.CreateBDFrame(bar, .25)
end

local function updateAchievementLabel(frame)
	local button = frame.__owner
	if button.DateCompleted:IsShown() then
		if button.Achievement.IsAccountWide then
			button.Header:SetTextColor(0, .6, 1)
		else
			button.Header:SetTextColor(.9, .9, .9)
		end
	else
		if button.Achievement.IsAccountWide then
			button.Header:SetTextColor(0, .3, .5)
		else
			button.Header:SetTextColor(.65, .65, .65)
		end
	end
end

local function replaceBlackText(self, r, g, b)
	if r == 0 and g == 0 and b == 0 then
		self:SetTextColor(.65, .65, .65)
	end
end

local function SetupAchivementButton(button)
	if button.styled then return end
	M.StripTextures(button, true)
	button.Icon.Border:Hide()
	M.ReskinIcon(button.Icon.Texture)
	if button.Tracked then
		M.ReskinCheck(button.Tracked)
		button.Tracked:SetSize(20, 20)
		button.Check:SetAlpha(0)
	end
	local plusMinus = button.PlusMinus
	if plusMinus then
		plusMinus.__owner = button
		updateAchievementLabel(plusMinus)
		hooksecurefunc(plusMinus, "SetTexCoord", updateAchievementLabel)
	end
	local bg = M.CreateBDFrame(button, .25)
	bg:SetInside()
	SetupButtonHighlight(button, bg)

	if button.Description then
		button.Description:SetTextColor(.65, .65, .65)
		hooksecurefunc(button.Description, "SetTextColor", replaceBlackText)
	end

	if button.HiddenDescription then
		button.HiddenDescription:SetTextColor(1, 1, 1)
	end

	button.styled = true
end

local function SetupCategory(button)
	if not button.styled then
		M.StripTextures(button)
		local bg = M.CreateBDFrame(button, .25)
		bg:SetPoint("TOPLEFT", 0, -1)
		bg:SetPoint("BOTTOMRIGHT")
		SetupButtonHighlight(button, bg)
		button.styled = true
	end
end

local function ReskinCalendarAchievement(self)
	for _, bu in pairs(self.AchievementButtons) do
		if not bu.styled then
			M.ReskinIcon(bu.Texture)
			bu.styled = true
		end
	end
end

function S:KrowiAF()
	if not C_AddOns.IsAddOnLoaded("Krowi_AchievementFilter") then return end

	for i = 4, 8 do
		local tab = _G["AchievementFrameTab"..i]
		if tab and not tab.bg then
			M.ReskinTab(tab)
		end
	end

	M.ReskinFilterButton(KrowiAF_AchievementFrameFilterButton)
	KrowiAF_AchievementFrameFilterButton:SetPoint("TOPLEFT", 24, 0)
	M.ReskinEditBox(KrowiAF_SearchBoxFrame)
	KrowiAF_SearchOptionsMenuButton:DisableDrawLayer("BACKGROUND")

	local frame = KrowiAF_CategoriesFrame
	if frame then
		M.StripTextures(frame)
		M.ReskinTrimScroll(frame.ScrollBar)

		hooksecurefunc(frame.ScrollBox, "Update", function(self)
			self:ForEachFrame(SetupCategory)
		end)
	end

	local frame = KrowiAF_AchievementFrameSummaryFrame or KrowiAF_SummaryFrame
	if frame then
		M.StripTextures(frame)
		frame:GetChildren():Hide()
		frame.AchievementsFrame.Border:Hide()
		M.ReskinTrimScroll(frame.AchievementsFrame.ScrollBar)

		hooksecurefunc(frame.AchievementsFrame.ScrollBox, "Update", function(self)
			self:ForEachFrame(SetupAchivementButton)
		end)

		local function skinProgressBar(bar)
			M.StripTextures(bar)
			if i ~= 1 then
				bar.BorderLeftTop:SetPoint("TOPLEFT", -1, 10)
			end
			local bg = M.CreateBDFrame(bar.Background, .25)
			if bar.Button then
				M.StripTextures(bar.Button)
				SetupButtonHighlight(bar.Button, bg)
			end
			for _, fill in next, bar.Fill do
				fill:SetTexture(I.bdTex)
			end
			bar:SetColors({R = 0, G = .4, M = 0}, {R = 0, G = .6, M = 0})
		end

		local numFrames = 1
		hooksecurefunc(frame, "GetStatusBar", function()
			local bar = _G["Krowi_ProgressBar"..numFrames]
			while bar do
				skinProgressBar(bar)
				numFrames = numFrames + 1
				bar = _G["Krowi_ProgressBar"..numFrames]
			end
		end)
	end

	local frame = KrowiAF_AchievementsFrame
	if frame then
		M.StripTextures(frame)
		M.ReskinTrimScroll(frame.ScrollBar)

		hooksecurefunc(frame.ScrollBox, "Update", function(self)
			self:ForEachFrame(SetupAchivementButton)
		end)
	end

	if AchievementButton_LocalizeProgressBar then
		hooksecurefunc("AchievementButton_LocalizeProgressBar", function(bar)
			if bar.styled then return end
			local barName = bar.GetName and bar:GetName()
			if barName and strfind(barName, "Krowi") then
				SetupStatusbar(bar)
				bar.styled = true
			end
		end)
	end

	hooksecurefunc(KrowiAF_AchievementsObjectives, "DisplayCriteria", function(objectivesFrame, id)
		local numCriteria = GetAchievementNumCriteria(id)
		local textStrings, metas, criteria, object = 0, 0
		for i = 1, numCriteria do
			local _, criteriaType, completed, _, _, _, _, assetID = GetAchievementCriteriaInfo(id, i)
			if assetID and criteriaType == _G.CRITERIA_TYPE_ACHIEVEMENT then
				metas = metas + 1
				criteria, object = objectivesFrame:GetMeta(metas), "Label"
			elseif criteriaType ~= 1 then
				textStrings = textStrings + 1
				criteria, object = objectivesFrame:GetTextCriteria(textStrings), "Name"
			end

			local text = criteria and criteria[object]
			if text and completed and objectivesFrame.Completed then
				text:SetTextColor(1, 1, 1)
			end
		end
	end)

	hooksecurefunc(AchievementFrame, "Show", function(self)
		for i = 1, 15 do
			local button = _G["KrowiAF_AchievementFrameSideButton"..i]
			if not button then break end
			if not button.bg then
				button.Background:SetTexture("")
				button.Icon.Overlay:SetTexture("")
				M.ReskinIcon(button.Icon.Texture)
				button.bg = M.SetBD(button)
				button.bg:SetPoint("TOPLEFT", 6, -9)
				button.bg:SetPoint("BOTTOMRIGHT", 2, 12)
			end
		end
	end)

	local button = KrowiAF_AchievementCalendarButton
	if button then
		M.StripTextures(button)
		local icon = button:CreateTexture()
		icon:SetAllPoints()
		icon:SetTexture(I.garrTex)

		button:ClearAllPoints()
		button:SetPoint("TOPLEFT", AchievementFrame, -12, 12)
	end

	local frame = KrowiAF_AchievementCalendarFrame
	if frame then
		M.StripTextures(frame)
		M.SetBD(frame)
		M.ReskinArrow(frame.PrevMonthButton, "left")
		M.ReskinArrow(frame.NextMonthButton, "right")
		M.ReskinClose(frame.CloseButton)

		for i = 1, 42 do
			local button = frame.DayButtons[i]
			if button then
				button:DisableDrawLayer("BACKGROUND")
				button.DarkFrame:SetAlpha(.5)
				button:SetHighlightTexture(I.bdTex)
				local bg = M.CreateBDFrame(button, .25)
				bg:SetInside()
				local hl = button:GetHighlightTexture()
				hl:SetVertexColor(cr, cg, cb, .25)
				hl:SetInside(bg)

				hooksecurefunc(button, "AddAchievement", ReskinCalendarAchievement)
			end
		end

		frame.TodayFrame:SetSize(90, 90)
		M.StripTextures(frame.TodayFrame)
		local bg = M.CreateBDFrame(frame.TodayFrame, 0)
		bg:SetInside()
		bg:SetBackdropBorderColor(cr, cg, cb)

		local sideFrame = frame.SideFrame
		if sideFrame then
			M.StripTextures(sideFrame)
			M.StripTextures(sideFrame.Header)
			M.SetBD(sideFrame)
			M.ReskinClose(sideFrame.CloseButton)
	
			local achesFrame = sideFrame.AchievementsFrame
			if achesFrame then
				M.StripTextures(achesFrame)
				M.ReskinTrimScroll(achesFrame.ScrollBar)
		
				hooksecurefunc(achesFrame.ScrollBox, "Update", function(self)
					self:ForEachFrame(SetupAchivementButton)
				end)
			end
		end
	end

	local container = KrowiAF_SearchPreviewContainer
	if container then
		M.StripTextures(container)
		for i = 1, 5 do
			local preview = _G["KrowiAF_SearchPreview"..i]
			if preview then
				M.StyleSearchButton(preview)
			end
		end

		local showAllResults = container.ShowFullSearchResultsButton
		local bg = M.SetBD(container)
		bg:SetPoint("TOPLEFT", -3, 3)
		bg:SetPoint("BOTTOMRIGHT", showAllResults, 3, -3)
		M.StyleSearchButton(showAllResults)
	end

	if KrowiAF_AchievementFrameBrowsingHistoryPrevAchievementButton then
		M.ReskinArrow(KrowiAF_AchievementFrameBrowsingHistoryPrevAchievementButton, "left")
	end
	if KrowiAF_AchievementFrameBrowsingHistoryNextAchievementButton then
		M.ReskinArrow(KrowiAF_AchievementFrameBrowsingHistoryNextAchievementButton, "right")
	end

	if KrowiAF_DataManagerFrame then
		M.ReskinPortraitFrame(KrowiAF_DataManagerFrame)
		M.Reskin(KrowiAF_DataManagerFrame.Import)

		local characterList = KrowiAF_DataManagerFrame.CharacterList
		if characterList then
			local columnDisplay = characterList.ColumnDisplay
			if columnDisplay then
				M.StripTextures(columnDisplay)
				for i = 1, columnDisplay:GetNumChildren() do
					local child = select(i, columnDisplay:GetChildren())
					M.StripTextures(child)
		
					local bg = M.CreateBDFrame(child, .25)
					bg:SetPoint("TOPLEFT", 4, -2)
					bg:SetPoint("BOTTOMRIGHT", 0, 2)
		
					child:SetHighlightTexture(I.bdTex)
					local hl = child:GetHighlightTexture()
					hl:SetVertexColor(cr, cg, cb, .25)
					hl:SetInside(bg)
				end
			end
	
			hooksecurefunc(characterList.ScrollBox, "Update", function(self)
				for i = 1, self.ScrollTarget:GetNumChildren() do
					local button = select(i, self.ScrollTarget:GetChildren())
					if not button.styled then
						M.ReskinCheck(button.HeaderTooltip)
						M.ReskinCheck(button.EarnedByAchievementTooltip)
						M.ReskinCheck(button.MostProgressAchievementTooltip)
						M.ReskinCheck(button.IgnoreCharacter)
	
						button.styled = true
					end
				end
			end)
			M.ReskinTrimScroll(characterList.ScrollBar)
		end
	end
end

S:RegisterSkin("Blizzard_AchievementUI", S.KrowiAF)