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

function S:RematchPetList()
	local buttons = self.ScrollFrame.Buttons
	if not buttons then return end

	for i = 1, #buttons do
		local button = buttons[i]
		if not button.styled then
			local parent
			if button.Pet then
				M.CreateBDFrame(button.Pet)
				if button.Rarity then button.Rarity:SetTexture(nil) end
				if button.LevelBack then button.LevelBack:SetTexture(nil) end
				button.LevelText:SetTextColor(1, 1, 1)
				parent = button.Pet
			end

			if button.Pets then
				for j = 1, 3 do
					local bu = button.Pets[j]
					bu:SetWidth(25)
					M.CreateBDFrame(bu)
				end
				if button.Border then button.Border:SetTexture(nil) end
				parent = button.Pets[3]
			end

			if button.Back then
				button.Back:SetTexture(nil)
				local bg = M.CreateBDFrame(button.Back, .25)
				bg:SetPoint("TOPLEFT", parent, "TOPRIGHT", 3, R.mult)
				bg:SetPoint("BOTTOMRIGHT", 0, R.mult)
				button.bg = bg
				button:HookScript("OnEnter", buttonOnEnter)
				button:HookScript("OnLeave", buttonOnLeave)
			end

			button.styled = true
		end
	end
end

function S:RematchSelectedOverlay()
	M.StripTextures(self.SelectedOverlay)
	local bg = M.CreateBDFrame(self.SelectedOverlay)
	bg:SetBackdropColor(1, .8, 0, .5)
	self.SelectedOverlay.bg = bg
end

function S:RematchLockButton(button)
	M.StripTextures(button, 1)
	local bg = M.CreateBDFrame(button, .25, true)
	bg:SetInside(nil, 7, 7)
end

function S:RematchTeamGroup(panel)
	if panel.styled then return end

	for i = 1, 3 do
		local button = panel.Pets[i]
		S.RematchIcon(button)
		button.bg = button.Icon.bg
		M.ReskinIconBorder(button.IconBorder, true)

		for j = 1, 3 do
			S.RematchIcon(button.Abilities[j])
		end
	end

	panel.styled = true
end

function S:RematchFlyoutButton(flyout)
	flyout:HideBackdrop()
	for i = 1, 2 do
		S.RematchIcon(flyout.Abilities[i])
	end
end

local function hookRematchPetButton(texture, _, _, _, y)
	if y == .5 then
		texture:SetTexCoord(.5625, 1, 0, .4375)
	elseif y == 1 then
		texture:SetTexCoord(0, .4375, 0, .4375)
	end
end

local styled
function S:ReskinRematchElements()
	if styled then return end

	TT.ReskinTooltip(RematchTooltip)
	--TT.ReskinTooltip(RematchTableTooltip)
	--[=[for i = 1, 3 do
		local menu = Rematch:GetMenuFrame(i, UIParent)
		M.StripTextures(menu.Title)
		local bg = M.CreateBDFrame(menu.Title)
		bg:SetBackdropColor(1, .8, .0, .25)
		M.StripTextures(menu)
		M.SetBD(menu, .7)
	end]=]

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

	if ALPTRematchOptionButton then
		ALPTRematchOptionButton:SetPushedTexture(0)
		ALPTRematchOptionButton:SetHighlightTexture(I.bdTex)
		ALPTRematchOptionButton:GetHighlightTexture():SetVertexColor(1, 1, 1, .25)
		local tex = ALPTRematchOptionButton:GetNormalTexture()
		tex:SetTexCoord(unpack(I.TexCoord))
		M.CreateBDFrame(tex)
	end

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

	--S.RematchSelectedOverlay(petsPanel)
	S.RematchInset(petsPanel.ResultsBar)
	S.RematchInput(petsPanel.Top.SearchBox)
	S.RematchFilter(petsPanel.Top.FilterButton)
	S.RematchScroll(petsPanel.List)

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

	if true then return end
	local targetPanel = loadoutPanel.TargetPanel
	if targetPanel then -- compatible
		M.StripTextures(targetPanel.Top)
		S.RematchInput(targetPanel.Top.SearchBox)
		S.RematchFilter(targetPanel.Top.BackButton)
		S.RematchScroll(targetPanel.List)

		hooksecurefunc(targetPanel, "FillHeader", function(_, button)
			if not button.styled then
				button.Border:SetTexture(nil)
				button.Back:SetTexture(nil)
				button.bg = M.CreateBDFrame(button.Back, .25)
				button.bg:SetInside()
				button:HookScript("OnEnter", buttonOnEnter)
				button:HookScript("OnLeave", buttonOnLeave)
				button.Expand:SetSize(8, 8)
				button.Expand:SetPoint("LEFT", 5, 0)
				button.Expand:SetTexture("Interface\\Buttons\\UI-PlusMinus-Buttons")
				hooksecurefunc(button.Expand, "SetTexCoord", hookRematchPetButton)

				button.styled = true
			end
		end)
	end

	-- RematchTeamPanel
	M.StripTextures(RematchTeamPanel.Top)
	S.RematchInput(RematchTeamPanel.Top.SearchBox)
	S.RematchFilter(RematchTeamPanel.Top.Teams)
	S.RematchScroll(RematchTeamPanel.List)
	S.RematchSelectedOverlay(RematchTeamPanel)

	M.StripTextures(RematchQueuePanel.Top)
	S.RematchFilter(RematchQueuePanel.Top.QueueButton)
	S.RematchScroll(RematchQueuePanel.List)
	S.RematchInset(RematchQueuePanel.Status)

	-- RematchOptionPanel
	S.RematchScroll(RematchOptionPanel.List)
	for i = 1, 4 do
		S.RematchIcon(RematchOptionPanel.Growth.Corners[i])
	end
	M.StripTextures(RematchOptionPanel.Top)
	S.RematchInput(RematchOptionPanel.Top.SearchBox)

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
		S:ReskinRematchElements()

		frame.styled = true
	end)

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

--[=[
	hooksecurefunc(Rematch, "FillCommonPetListButton", function(self, petID)
		local petInfo = Rematch.petInfo:Fetch(petID)
		local parentPanel = self:GetParent():GetParent():GetParent():GetParent()
		if petInfo.isSummoned and parentPanel == Rematch.PetPanel then
			local bg = parentPanel.SelectedOverlay.bg
			if bg then
				bg:ClearAllPoints()
				bg:SetAllPoints(self.bg)
			end
		end
	end)

	hooksecurefunc(Rematch, "DimQueueListButton", function(_, button)
		button.LevelText:SetTextColor(1, 1, 1)
	end)

	hooksecurefunc(RematchDialog, "FillTeam", function(_, frame)
		S:RematchTeamGroup(frame)
	end)

	local direcButtons = {"UpButton", "DownButton"}
	hooksecurefunc(RematchTeamTabs, "Update", function(self)
		for _, tab in next, self.Tabs do
			S.RematchIcon(tab)
			tab:SetSize(40, 40)
			tab.Icon:SetPoint("CENTER")
		end

		for _, direc in pairs(direcButtons) do
			S.RematchIcon(self[direc])
			self[direc]:SetSize(40, 40)
			self[direc].Icon:SetPoint("CENTER")
		end
	end)

	hooksecurefunc(RematchTeamTabs, "TabButtonUpdate", function(self, index)
		local selected = self:GetSelectedTab()
		local button = self:GetTabButton(index)
		if not button.Icon.bg then return end

		if index == selected then
			button.Icon.bg:SetBackdropBorderColor(1, 1, 1)
		else
			button.Icon.bg:SetBackdropBorderColor(0, 0, 0)
		end
	end)

	hooksecurefunc(RematchTeamTabs, "UpdateTabIconPickerList", function()
		local buttons = RematchDialog.TeamTabIconPicker.ScrollFrame.buttons
		for i = 1, #buttons do
			local button = buttons[i]
			for j = 1, 10 do
				local bu = button.Icons[j]
				if not bu.styled then
					bu:SetSize(26, 26)
					bu.Icon = bu.Texture
					S.RematchIcon(bu)
				end
			end
		end
	end)

	hooksecurefunc(RematchLoadoutPanel, "UpdateLoadouts", function(self)
		if not self then return end

		for i = 1, 3 do
			local loadout = self.Loadouts[i]
			if not loadout.styled then
				M.StripTextures(loadout)
				local bg = M.CreateBDFrame(loadout, .25)
				bg:SetPoint("BOTTOMRIGHT", R.mult, R.mult)
				S.RematchIcon(loadout.Pet.Pet)
				S.RematchXP(loadout.HP)
				S.RematchXP(loadout.XP)
				loadout.XP:SetSize(255, 7)
				loadout.HP.MiniHP:SetText("HP")
				for j = 1, 3 do
					S.RematchIcon(loadout.Abilities[j])
				end

				loadout.styled = true
			end

			local icon = loadout.Pet.Pet.Icon
			local iconBorder = loadout.Pet.Pet.IconBorder
			if icon.bg then
				icon.bg:SetBackdropBorderColor(iconBorder:GetVertexColor())
			end
		end
	end)

	local activeTypeMode = 1
	hooksecurefunc(RematchPetPanel, "SetTypeMode", function(_, typeMode)
		activeTypeMode = typeMode
	end)
	hooksecurefunc(RematchPetPanel, "UpdateTypeBar", function(self)
		local typeBar = self.Top.TypeBar
		if typeBar:IsShown() then
			for i = 1, 4 do
				local tab = typeBar.Tabs[i]
				if not tab then break end
				if not tab.styled then
					M.StripTextures(tab)
					tab.bg = M.CreateBDFrame(tab)
					local r, g, b = tab.Selected.MidSelected:GetVertexColor()
					tab.bg:SetBackdropColor(r, g, b, .5)
					M.StripTextures(tab.Selected)

					tab.styled = true
				end
				tab.bg:SetShown(activeTypeMode == i)
			end
		end
	end)

	hooksecurefunc(RematchPetPanel.List, "Update", S.RematchPetList)
	hooksecurefunc(RematchQueuePanel.List, "Update", S.RematchPetList)
	hooksecurefunc(RematchTeamPanel.List, "Update", S.RematchPetList)

	hooksecurefunc(RematchTeamPanel, "FillTeamListButton", function(self, key)
		local teamInfo = Rematch.teamInfo:Fetch(key)
		if not teamInfo then return end

		local panel = RematchTeamPanel
		if teamInfo.key == RematchSettings.loadedTeam then
			local bg = panel.SelectedOverlay.bg
			if bg then
				bg:ClearAllPoints()
				bg:SetAllPoints(self.bg)
			end
		end
	end)

	hooksecurefunc(RematchOptionPanel, "FillOptionListButton", function(self, index)
		local panel = RematchOptionPanel
		local opt = panel.opts[index]
		if opt then
			self.optType = opt[1]
			local checkButton = self.CheckButton
			if not checkButton.bg then
				checkButton.bg = M.CreateBDFrame(checkButton, 0, true)
				self.HeaderBack:SetTexture(nil)
			end
			checkButton.bg:SetBackdropColor(0, 0, 0, 0)
			checkButton.bg:Show()

			if self.optType == "header" then
				self.headerIndex = opt[3]
				self.Text:SetPoint("LEFT", checkButton, "RIGHT", 5, 0)
				checkButton:SetSize(8, 8)
				checkButton:SetPoint("LEFT", 5, 0)
				checkButton:SetTexture("Interface\\Buttons\\UI-PlusMinus-Buttons")
				checkButton.bg:SetBackdropColor(0, 0, 0, .25)
				checkButton.bg:SetPoint("TOPLEFT", checkButton, -3, 3)
				checkButton.bg:SetPoint("BOTTOMRIGHT", checkButton, 3, -3)

				local isExpanded = RematchSettings.ExpandedOptHeaders[opt[3]]
				if isExpanded then
					checkButton:SetTexCoord(.5625, 1, 0, .4375)
				else
					checkButton:SetTexCoord(0, .4375, 0, .4375)
				end
				if self.headerIndex == 0 and panel.allCollapsed then
					checkButton:SetTexCoord(0, .4375, 0, .4375)
				end
			elseif self.optType == "check" then
				checkButton:SetSize(22, 22)
				checkButton.bg:SetPoint("TOPLEFT", checkButton, 3, -3)
				checkButton.bg:SetPoint("BOTTOMRIGHT", checkButton, -3, 3)
				if self.isChecked and self.isDisabled then
					checkButton:SetTexCoord(.25, .5, .75, 1)
				elseif self.isChecked then
					checkButton:SetTexCoord(.5, .75, 0, .25)
				else
					checkButton:SetTexCoord(0, 0, 0, 0)
				end
			elseif self.optType == "radio" then
				local isChecked = RematchSettings[opt[2]] == opt[5]
				checkButton:SetSize(22, 22)
				checkButton.bg:SetPoint("TOPLEFT", checkButton, 3, -3)
				checkButton.bg:SetPoint("BOTTOMRIGHT", checkButton, -3, 3)
				if isChecked then
					checkButton:SetTexCoord(.5, .75, .25, .5)
				else
					checkButton:SetTexCoord(0, 0, 0, 0)
				end
			else
				checkButton.bg:Hide()
			end
		end
	end)
	

	-- Window mode
	hooksecurefunc(frame, "ConfigureFrame", function(self)
		if self.styled then return end

		M.StripTextures(self)
		M.SetBD(self)
		if self.CloseButton then
			M.ReskinClose(self.CloseButton)
		end
		for _, tab in ipairs(self.PanelTabs.Tabs) do
			M.ReskinTab(tab)
		end

		M.StripTextures(RematchMiniPanel)
		S:RematchTeamGroup(RematchMiniPanel)
		S:RematchFlyoutButton(RematchMiniPanel.Flyout)

		local titleBar = self.TitleBar
		M.StripTextures(titleBar)

		S:RematchLockButton(titleBar.MinimizeButton)
		S:RematchLockButton(titleBar.LockButton)
		S:RematchLockButton(titleBar.SinglePanelButton)
		S:ReskinRematchElements()

		self.styled = true
	end)]=]
end