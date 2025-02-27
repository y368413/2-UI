local _, ns = ...
local M, R, U, I = unpack(ns)
local S = M:GetModule("Skins")
local TT = M:GetModule("Tooltip")

local cr, cg, cb = I.r, I.g, I.b
local select, pairs, ipairs, next, unpack = select, pairs, ipairs, next, unpack

function S:RematchFilter()
	M.StripTextures(self)
	M.Reskin(self)
	M.SetupArrow(self.Arrow, "right")
	self.Arrow:ClearAllPoints()
	self.Arrow:SetPoint("RIGHT")
	self.Arrow.SetPoint = M.Dummy
	self.Arrow:SetSize(14, 14)
end

function S:RematchButton()
	if self.styled then return end

	M.Reskin(self)
	self:DisableDrawLayer("BACKGROUND")
	self:DisableDrawLayer("BORDER")

	self.styled = true
end

function S:RematchIcon()
	if self.styled then return end

	if self.Border then self.Border:SetAlpha(0) end
	if self.Icon then
		self.Icon:SetTexCoord(unpack(I.TexCoord))
		self.Icon.bg = M.CreateBDFrame(self.Icon)
	end
	if self.Level then
		if self.Level.BG then self.Level.BG:Hide() end
		if self.Level.Text then self.Level.Text:SetTextColor(1, 1, 1) end
	end
	if self.GetCheckedTexture then
		self:SetCheckedTexture(I.pushedTex)
	end

	self.styled = true
end

function S:RematchInput()
	self:DisableDrawLayer("BACKGROUND")
	self:HideBackdrop()
	local bg = M.CreateBDFrame(self, 0, true)
	bg:SetPoint("TOPLEFT", 2, 0)
	bg:SetPoint("BOTTOMRIGHT", -2, 0)
end

local function scrollEndOnLeave(self)
	self.__texture:SetVertexColor(1, .8, 0)
end

function S:ReskinScrollEnd(direction)
	M.ReskinArrow(self, direction)
	if self.Texture then self.Texture:SetAlpha(0) end
	self:SetSize(16, 12)
	self.__texture:SetVertexColor(1, .8, 0)
	self:HookScript("OnLeave", scrollEndOnLeave)
end

function S:RematchScroll()
	M.StripTextures(self)
	M.ReskinTrimScroll(self.ScrollBar)
	S.ReskinScrollEnd(self.ScrollToTopButton, "up")
	S.ReskinScrollEnd(self.ScrollToBottomButton, "down")
end

function S:RematchDropdown()
	self:HideBackdrop()
	M.StripTextures(self, 0)
	M.CreateBDFrame(self, 0, true)
	if self.Icon then
		self.Icon:SetAlpha(1)
		M.CreateBDFrame(self.Icon)
	end
	local arrow = select(2, self:GetChildren())
	M.ReskinArrow(arrow, "down")
end

function S:RematchXP()
	M.StripTextures(self)
	self:SetTexture(I.bdTex)
	M.CreateBDFrame(self, .25)
end

function S:RematchCard()
	self:HideBackdrop()
	if self.Source then M.StripTextures(self.Source) end
	M.StripTextures(self.Middle)
	M.CreateBDFrame(self.Middle, .25)
	if self.Middle.XP then S.RematchXP(self.Middle.XP) end
	if self.Bottom.AbilitiesBG then self.Bottom.AbilitiesBG:Hide() end
	if self.Bottom.BottomBG then self.Bottom.BottomBG:Hide() end
	local bg = M.CreateBDFrame(self.Bottom, .25)
	bg:SetPoint("TOPLEFT", -R.mult, -3)
end

function S:RematchInset()
	M.StripTextures(self)
	local bg = M.CreateBDFrame(self, .25)
	bg:SetPoint("TOPLEFT", 3, 0)
	bg:SetPoint("BOTTOMRIGHT", -3, 0)
end

local function buttonOnEnter(self)
	self.bg:SetBackdropColor(cr, cg, cb, .25)
end

local function buttonOnLeave(self)
	self.bg:SetBackdropColor(0, 0, 0, .25)
end

function S:RematchLockButton(button)
	M.StripTextures(button, 1)
	local bg = M.CreateBDFrame(button, .25, true)
	bg:SetInside(nil, 7, 7)
end

local function updateCollapseTexture(button, isExpanded)
	local atlas = isExpanded and "Soulbinds_Collection_CategoryHeader_Collapse" or "Soulbinds_Collection_CategoryHeader_Expand"
	button.__texture:SetAtlas(atlas, true)
end

local function headerEnter(header)
	header.bg:SetBackdropColor(cr, cg, cb, .25)
end

local function headerLeave(header)
	header.bg:SetBackdropColor(0, 0, 0, .25)
end

function S:RematchCollapse()
	if self.Icon then
		self.Icon.isIgnored = true
		self.IconMask.isIgnored = true
	end
	M.StripTextures(self)
	self.bg = B.CreateBDFrame(self, .25)
	self.bg:SetInside()

	self.__texture = self:CreateTexture(nil, "OVERLAY")
	self.__texture:SetPoint("LEFT", 2, 0)
	self.__texture:SetSize(12, 12)
	self:HookScript("OnEnter", headerEnter)
	self:HookScript("OnLeave", headerLeave)

	updateCollapseTexture(self, self.isExpanded or self:GetParent().IsHeaderExpanded)
	hooksecurefunc(self, "SetExpanded", updateCollapseTexture)
end

local function handleHeaders(box)
	box:ForEachFrame(function(button)
		if button.ExpandIcon and not button.styled then
			S.RematchCollapse(button)
			button.styled = true
		end
	end)
end

function S:RematchHeaders()
	hooksecurefunc(self.ScrollBox, "Update", handleHeaders)
end

local function handleList(self)
	self:ForEachFrame(function(button)
		if not button.styled then
			button.Border:SetAlpha(0) -- too blur to use quality color
			button.bg = B.ReskinIcon(button.Icon)
			button.styled = true
		end
	end)
end

function S:RematchPetList()
	hooksecurefunc(self.ScrollBox, "Update", handleList)
end

local styled
function S:ReskinRematchElements()
	if styled then return end

	TT.ReskinTooltip(RematchTooltip)

	local toolbar = Rematch.toolbar

	local buttonName = {
		"HealButton", "BandageButton", "SafariHatButton",
		"LesserPetTreatButton", "PetTreatButton", "LevelingStoneButton", "RarityStoneButton",
		"ImportTeamButton", "ExportTeamButton", "RandomTeamButton", "SummonPetButton"
	}
	for _, name in pairs(buttonName) do
		local button = toolbar[name]
		if button then
			S.RematchIcon(button)
		end
	end

	M.StripTextures(toolbar)
	S.RematchButton(toolbar.TotalsButton)

	for _, name in pairs({"SummonButton", "SaveButton", "SaveAsButton", "FindBattleButton"}) do
		local button = Rematch.bottombar[name]
		if button then
			S.RematchButton(button)
		end
	end

	-- RematchPetPanel
	local petsPanel = Rematch.petsPanel
	M.StripTextures(petsPanel.Top)
	S.RematchButton(petsPanel.Top.ToggleButton)
	petsPanel.Top.ToggleButton.Back:Hide()
	petsPanel.Top.TypeBar.TabbedBorder:SetAlpha(0)
	for i = 1, 10 do
		S.RematchIcon(petsPanel.Top.TypeBar.Buttons[i])
	end

	S.RematchInset(petsPanel.ResultsBar)
	S.RematchInput(petsPanel.Top.SearchBox)
	S.RematchFilter(petsPanel.Top.FilterButton)
	S.RematchScroll(petsPanel.List)
	S.RematchPetList(petsPanel.List)

	-- RematchLoadedTeamPanel
	local loadoutPanel = Rematch.loadoutPanel

	M.StripTextures(loadoutPanel)
	local bg = M.CreateBDFrame(loadoutPanel)
	bg:SetBackdropColor(1, .8, 0, .1)
	bg:SetPoint("TOPLEFT", -R.mult, -R.mult)
	bg:SetPoint("BOTTOMRIGHT", R.mult, R.mult)

	S.RematchButton(Rematch.loadedTeamPanel.TeamButton)
	M.StripTextures(Rematch.loadedTeamPanel.NotesFrame)
	S.RematchButton(Rematch.loadedTeamPanel.NotesFrame.NotesButton)

	-- RematchLoadoutPanel
	local target = Rematch.loadedTargetPanel
	M.StripTextures(target)
	M.CreateBDFrame(target, .25)
	S.RematchButton(target.BigLoadSaveButton)

	-- Teams
	local team = Rematch.teamsPanel
	M.StripTextures(team.Top)
	S.RematchInput(team.Top.SearchBox)
	S.RematchFilter(team.Top.TeamsButton)
	S.RematchScroll(team.List)
	S.RematchCollapse(team.Top.AllButton)
	S.RematchHeaders(team.List)

	-- Targets
	local targets = Rematch.targetsPanel
	M.StripTextures(targets.Top)
	S.RematchInput(targets.Top.SearchBox)
	S.RematchScroll(targets.List)
	S.RematchCollapse(targets.Top.AllButton)
	S.RematchHeaders(targets.List)

	-- Queue
	local queue = Rematch.queuePanel
	M.StripTextures(queue.Top)
	S.RematchFilter(queue.Top.QueueButton)
	S.RematchScroll(queue.List)
	M.StripTextures(queue.PreferencesFrame)
	M.Reskin(queue.PreferencesFrame.PreferencesButton)
	S.RematchPetList(queue.List)

	-- Options
	local options = Rematch.optionsPanel
	M.StripTextures(options.Top)
	S.RematchInput(options.Top.SearchBox)
	S.RematchScroll(options.List)
	S.RematchCollapse(options.Top.AllButton)
	S.RematchHeaders(options.List)

	-- side tabs
	hooksecurefunc(Rematch.teamTabs, "Configure", function(self)
		for i = 1, #self.Tabs do
			local tab = self.Tabs[i]
			if tab and not tab.styled then
				B.StripTextures(tab)
				tab.IconMask:Hide()
				B.ReskinIcon(tab.Icon)
				tab.styled = true
			end
		end
	end)

	if true then return end -- todo: skin remain elements

	-- RematchPetCard
	local petCard = RematchPetCard
	M.StripTextures(petCard)
	M.ReskinClose(petCard.CloseButton)
	M.StripTextures(petCard.Title)
	M.StripTextures(petCard.PinButton)
	M.ReskinArrow(petCard.PinButton, "up")
	petCard.PinButton:SetPoint("TOPLEFT", 5, -5)
	local bg = M.SetBD(petCard.Title, .7)
	bg:SetAllPoints(petCard)
	S.RematchCard(petCard.Front)
	S.RematchCard(petCard.Back)
	for i = 1, 6 do
		local button = RematchPetCard.Front.Bottom.Abilities[i]
		button.IconBorder:Hide()
		select(8, button:GetRegions()):SetTexture(nil)
		M.ReskinIcon(button.Icon)
	end

	-- RematchAbilityCard
	local abilityCard = RematchAbilityCard
	M.StripTextures(abilityCard, 15)
	M.SetBD(abilityCard, .7)
	abilityCard.Hints.HintsBG:Hide()

	-- RematchWinRecordCard
	local card = RematchWinRecordCard
	M.StripTextures(card)
	M.ReskinClose(card.CloseButton)
	M.StripTextures(card.Content)
	local bg = M.CreateBDFrame(card.Content, .25)
	bg:SetPoint("TOPLEFT", 2, -2)
	bg:SetPoint("BOTTOMRIGHT", -2, 2)
	local bg = M.SetBD(card.Content)
	bg:SetAllPoints(card)
	for _, result in pairs({"Wins", "Losses", "Draws"}) do
		S.RematchInput(card.Content[result].EditBox)
		card.Content[result].Add.IconBorder:Hide()
	end
	M.Reskin(card.Controls.ResetButton)
	M.Reskin(card.Controls.SaveButton)
	M.Reskin(card.Controls.CancelButton)

	-- RematchDialog
	local dialog = RematchDialog
	M.StripTextures(dialog)
	M.SetBD(dialog)
	M.ReskinClose(dialog.CloseButton)

	S.RematchIcon(dialog.Slot)
	S.RematchInput(dialog.EditBox)
	M.StripTextures(dialog.Prompt)
	M.Reskin(dialog.Accept)
	M.Reskin(dialog.Cancel)
	M.Reskin(dialog.Other)
	M.ReskinCheck(dialog.CheckButton)
	S.RematchInput(dialog.SaveAs.Name)
	S.RematchInput(dialog.Send.EditBox)
	S.RematchDropdown(dialog.SaveAs.Target)
	S.RematchDropdown(dialog.TabPicker)
	S.RematchIcon(dialog.Pet.Pet)
	M.ReskinRadio(dialog.ConflictRadios.MakeUnique)
	M.ReskinRadio(dialog.ConflictRadios.Overwrite)

	local preferences = dialog.Preferences
	S.RematchInput(preferences.MinHP)
	M.ReskinCheck(preferences.AllowMM)
	S.RematchInput(preferences.MaxHP)
	S.RematchInput(preferences.MinXP)
	S.RematchInput(preferences.MaxXP)

	local iconPicker = dialog.TeamTabIconPicker
	M.ReskinScroll(iconPicker.ScrollFrame.ScrollBar)
	M.StripTextures(iconPicker)
	M.CreateBDFrame(iconPicker, .25)
	S.RematchInput(iconPicker.SearchBox)

	M.ReskinScroll(dialog.MultiLine.ScrollBar)
	select(2, dialog.MultiLine:GetChildren()):HideBackdrop()
	local bg = M.CreateBDFrame(dialog.MultiLine, .25)
	bg:SetPoint("TOPLEFT", -5, 5)
	bg:SetPoint("BOTTOMRIGHT", 5, -5)
	M.ReskinCheck(dialog.ShareIncludes.IncludePreferences)
	M.ReskinCheck(dialog.ShareIncludes.IncludeNotes)

	local report = dialog.CollectionReport
	S.RematchDropdown(report.ChartTypeComboBox)
	M.StripTextures(report.Chart)
	local bg = M.CreateBDFrame(report.Chart, .25)
	bg:SetPoint("TOPLEFT", -R.mult, -3)
	bg:SetPoint("BOTTOMRIGHT", R.mult, 2)
	M.ReskinRadio(report.ChartTypesRadioButton)
	M.ReskinRadio(report.ChartSourcesRadioButton)

	local border = report.RarityBarBorder
	border:Hide()
	local bg = M.CreateBDFrame(border, .25)
	bg:SetPoint("TOPLEFT", border, 6, -5)
	bg:SetPoint("BOTTOMRIGHT", border, -6, 5)

	styled = true
end

function S:ReskinRematch()
	if not R.db["Skins"]["BlizzardSkins"] then return end
	if not R.db["Skins"]["Rematch"] then return end

	local frame = Rematch and Rematch.frame
	if not frame then return end

	if RematchSettings then
		RematchSettings.ColorPetNames = true
		RematchSettings.FixedPetCard = true
	end
	--RematchLoreFont:SetTextColor(1, 1, 1)

	local function resizeJournal()
		local isShown = frame:IsShown() and frame
		CollectionsJournal.bg:SetPoint("BOTTOMRIGHT", isShown or CollectionsJournal, R.mult, -R.mult)
		CollectionsJournal.CloseButton:SetAlpha(isShown and 0 or 1)
	end

	hooksecurefunc(frame, "OnShow", function()
		resizeJournal()

		if frame.styled then return end

		hooksecurefunc("PetJournal_UpdatePetLoadOut", resizeJournal)
		hooksecurefunc("CollectionsJournal_UpdateSelectedTab", resizeJournal)

		M.StripTextures(frame)
		frame.TitleBar.Portrait:SetAlpha(0)
		M.ReskinClose(frame.TitleBar.CloseButton)

		local tabs = frame.PanelTabs
		for i = 1, tabs:GetNumChildren() do
			local tab = select(i, tabs:GetChildren())
			M.ReskinTab(tab)
			tab.Highlight:SetAlpha(0)
		end

		M.ReskinCheck(frame.BottomBar.UseRematchCheckButton)

		frame.styled = true
	end)

	S:ReskinRematchElements()

	local journal = Rematch.journal
	hooksecurefunc(journal, "PetJournalOnShow", function()
		if journal.styled then return end
		M.ReskinCheck(journal.UseRematchCheckButton)

		journal.styled = true
	end)

	hooksecurefunc(RematchNotesCard, "Update", function(self)
		if self.styled then return end

		M.StripTextures(self)
		M.ReskinClose(self.CloseButton)
		S:RematchLockButton(self.LockButton)
		self.LockButton:SetPoint("TOPLEFT")

		local content = self.Content
		M.ReskinScroll(content.ScrollFrame.ScrollBar)
		local bg = M.CreateBDFrame(content.ScrollFrame, .25)
		bg:SetPoint("TOPLEFT", 0, 5)
		bg:SetPoint("BOTTOMRIGHT", 0, -2)
		local bg = M.SetBD(content.ScrollFrame)
		bg:SetAllPoints(self)

		S.RematchButton(self.Content.Bottom.DeleteButton)
		S.RematchButton(self.Content.Bottom.UndoButton)
		S.RematchButton(self.Content.Bottom.SaveButton)

		self.styled = true
	end)

	local loadoutBG
	hooksecurefunc(Rematch.loadoutPanel, "Update", function(self)
		if not self then return end

		for i = 1, 3 do
			local loadout = self.Loadouts[i]
			if not loadout.styled then
				for i = 1, 9 do
					select(i, loadout:GetRegions()):Hide()
				end
				loadout.Pet.Border:SetAlpha(0)
				local bg = M.CreateBDFrame(loadout, .25)
				bg:SetPoint("BOTTOMRIGHT", R.mult, R.mult)
				S.RematchIcon(loadout.Pet)
				S.RematchXP(loadout.HpBar)
				S.RematchXP(loadout.XpBar)
			--	for j = 1, 3 do
			--		S.RematchIcon(loadout.Abilities[j])
			--	end

				loadout.styled = true
			end

			local icon = loadout.Pet.Icon
			local iconBorder = loadout.Pet.Border
			if icon.bg then
				local r, g, b = iconBorder:GetVertexColor()
				icon.bg:SetBackdropBorderColor(r, g, b)
			end
		end
	end)
end