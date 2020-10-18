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

function S:RematchIcon()
	if self.styled then return end

	if self.IconBorder then self.IconBorder:Hide() end
	if self.Background then self.Background:Hide() end
	if self.Icon then
		self.Icon:SetTexCoord(unpack(I.TexCoord))
		self.Icon.bg = M.CreateBDFrame(self.Icon)
		local hl = self.GetHighlightTexture and self:GetHighlightTexture() or select(3, self:GetRegions())
		if hl then
			hl:SetColorTexture(1, 1, 1, .25)
			hl:SetAllPoints(self.Icon)
		end
	end
	if self.Level then
		if self.Level.BG then self.Level.BG:Hide() end
		if self.Level.Text then self.Level.Text:SetTextColor(1, 1, 1) end
	end
	if self.GetCheckedTexture then
		self:SetCheckedTexture(I.textures.pushed)
	end

	self.styled = true
end

function S:RematchInput()
	self:DisableDrawLayer("BACKGROUND")
	self:SetBackdrop(nil)
	local bg = M.CreateBDFrame(self, 0, true)
	bg:SetPoint("TOPLEFT", 2, 0)
	bg:SetPoint("BOTTOMRIGHT", -2, 0)
end

local function scrollEndOnLeave(self)
	self.__texture:SetVertexColor(1, .8, 0)
end

local function reskinScrollEnd(self, direction)
	M.ReskinArrow(self, direction)
	self:SetSize(17, 12)
	self.__texture:SetVertexColor(1, .8, 0)
	self:HookScript("OnLeave", scrollEndOnLeave)
end

function S:RematchScroll()
	self.Background:Hide()
	local scrollBar = self.ScrollFrame.ScrollBar
	M.StripTextures(scrollBar)
	scrollBar.thumbTexture = scrollBar.ScrollThumb
	M.ReskinScroll(scrollBar)
	scrollBar.thumbTexture:SetPoint("TOPRIGHT")
	reskinScrollEnd(scrollBar.TopButton, "up")
	reskinScrollEnd(scrollBar.BottomButton, "down")
end

function S:RematchDropdown()
	self:SetBackdrop(nil)
	M.StripTextures(self, 0)
	M.CreateBDFrame(self, 0, true)
	if self.Icon then
		self.Icon:SetAlpha(1)
		M.CreateBDFrame(self.Icon)
	end
	local arrow = self:GetChildren()
	M.ReskinArrow(arrow, "down")
end

function S:RematchXP()
	M.StripTextures(self)
	self:SetStatusBarTexture(I.bdTex)
	M.CreateBDFrame(self, .25)
end

function S:RematchCard()
	self:SetBackdrop(nil)
	if self.Source then M.StripTextures(self.Source) end
	M.StripTextures(self.Middle)
	M.CreateBDFrame(self.Middle, .25)
	if self.Middle.XP then S.RematchXP(self.Middle.XP) end
	M.StripTextures(self.Bottom)
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

function S:ResizeJournal()
	local parent = RematchJournal:IsShown() and RematchJournal or CollectionsJournal
	CollectionsJournal.bg:SetPoint("BOTTOMRIGHT", parent, R.mult, -R.mult)
end

function S:ReskinRematch()
	if not MaoRUIPerDB["Skins"]["BlizzardSkins"] then return end
	if not MaoRUIPerDB["Skins"]["Rematch"] then return end

	local RematchJournal = RematchJournal
	if not RematchJournal then return end

	if RematchSettings then
		RematchSettings.ColorPetNames = true
		RematchSettings.FixedPetCard = true
	end
	RematchLoreFont:SetTextColor(1, 1, 1)

	local styled
	hooksecurefunc(RematchJournal, "ConfigureJournal", function()
		S.ResizeJournal()

		if styled then return end

		-- Main Elements
		hooksecurefunc("CollectionsJournal_UpdateSelectedTab", S.ResizeJournal)
		TT.ReskinTooltip(RematchTooltip)
		TT.ReskinTooltip(RematchTableTooltip)
		for i = 1, 3 do
			local menu = Rematch:GetMenuFrame(i, UIParent)
			M.StripTextures(menu.Title)
			local bg = M.CreateBDFrame(menu.Title)
			bg:SetBackdropColor(1, .8, .0, .25)
			M.StripTextures(menu)
			M.SetBD(menu, .7)
		end

		M.StripTextures(RematchJournal)
		M.ReskinClose(RematchJournal.CloseButton)
		for _, tab in ipairs(RematchJournal.PanelTabs.Tabs) do
			M.ReskinTab(tab)
		end

		local buttons = {
			RematchHealButton,
			RematchBandageButton,
			RematchToolbar.SafariHat,
			RematchLesserPetTreatButton,
			RematchPetTreatButton,
			RematchToolbar.SummonRandom,
		}
		for _, button in pairs(buttons) do
			S.RematchIcon(button)
		end

		if ALPTRematchOptionButton then
			ALPTRematchOptionButton:SetPushedTexture(nil)
			ALPTRematchOptionButton:SetHighlightTexture(I.bdTex)
			ALPTRematchOptionButton:GetHighlightTexture():SetVertexColor(1, 1, 1, .25)
			local tex = ALPTRematchOptionButton:GetNormalTexture()
			tex:SetTexCoord(unpack(I.TexCoord))
			M.CreateBDFrame(tex)
		end

		local petCount = RematchToolbar.PetCount
		petCount:SetWidth(130)
		M.StripTextures(petCount)
		local bg = M.CreateBDFrame(petCount, .25)
		bg:SetPoint("TOPLEFT", -6, -8)
		bg:SetPoint("BOTTOMRIGHT", -4, 3)

		M.Reskin(RematchBottomPanel.SummonButton)
		M.ReskinCheck(UseRematchButton)
		M.ReskinCheck(RematchBottomPanel.UseDefault)
		M.Reskin(RematchBottomPanel.SaveButton)
		M.Reskin(RematchBottomPanel.SaveAsButton)
		M.Reskin(RematchBottomPanel.FindBattleButton)

		-- RematchPetPanel
		M.StripTextures(RematchPetPanel.Top)
		M.Reskin(RematchPetPanel.Top.Toggle)
		RematchPetPanel.Top.TypeBar:SetBackdrop(nil)
		for i = 1, 10 do
			S.RematchIcon(RematchPetPanel.Top.TypeBar.Buttons[i])
		end

		-- quality bar in the new version
		local qualityBar = RematchPetPanel.Top.TypeBar.QualityBar
		if qualityBar then
			local buttons = {"HealthButton", "PowerButton", "SpeedButton", "Level25Button", "RareButton"}
			for _, name in pairs(buttons) do
				local button = qualityBar[name]
				if button then
					S.RematchIcon(button)
				end
			end
		end

		S.RematchSelectedOverlay(RematchPetPanel)
		S.RematchInset(RematchPetPanel.Results)
		S.RematchInput(RematchPetPanel.Top.SearchBox)
		S.RematchFilter(RematchPetPanel.Top.Filter)
		S.RematchScroll(RematchPetPanel.List)

		-- RematchLoadedTeamPanel
		M.StripTextures(RematchLoadedTeamPanel)
		local bg = M.CreateBDFrame(RematchLoadedTeamPanel)
		bg:SetBackdropColor(1, .8, 0, .1)
		bg:SetPoint("TOPLEFT", -R.mult, -R.mult)
		bg:SetPoint("BOTTOMRIGHT", R.mult, R.mult)
		M.StripTextures(RematchLoadedTeamPanel.Footnotes)

		-- RematchLoadoutPanel
		local target = RematchLoadoutPanel.Target
		M.StripTextures(target)
		M.CreateBDFrame(target, .25)
		S.RematchFilter(target.TargetButton)
		target.ModelBorder:SetBackdrop(nil)
		target.ModelBorder:DisableDrawLayer("BACKGROUND")
		M.CreateBDFrame(target.ModelBorder, .25)
		M.StripTextures(target.LoadSaveButton)
		M.Reskin(target.LoadSaveButton)
		for i = 1, 3 do
			S.RematchIcon(target["Pet"..i])
		end

		local flyout = RematchLoadoutPanel.Flyout
		flyout:SetBackdrop(nil)
		for i = 1, 2 do
			S.RematchIcon(flyout.Abilities[i])
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

		M.ReskinScroll(dialog.MultiLine.ScrollBar)
		select(2, dialog.MultiLine:GetChildren()):SetBackdrop(nil)
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
	end)

	-- RematchNotes
	do
		local note = RematchNotes
		M.StripTextures(note)
		M.ReskinClose(note.CloseButton)
		M.StripTextures(note.LockButton, 2)
		note.LockButton:SetPoint("TOPLEFT")
		local bg = M.CreateBDFrame(note.LockButton, .25)
		bg:SetPoint("TOPLEFT", 7, -7)
		bg:SetPoint("BOTTOMRIGHT", -7, 7)

		local content = note.Content
		M.StripTextures(content)
		M.ReskinScroll(content.ScrollFrame.ScrollBar)
		local bg = M.CreateBDFrame(content.ScrollFrame, .25)
		bg:SetPoint("TOPLEFT", 0, 5)
		bg:SetPoint("BOTTOMRIGHT", 0, -2)
		local bg = M.SetBD(content.ScrollFrame)
		bg:SetAllPoints(note)
		for _, icon in pairs({"Left", "Right"}) do
			local bu = content[icon.."Icon"]
			local mask = content[icon.."CircleMask"]
			if mask then
				mask:Hide()
			else
				bu:SetMask(nil)
			end
			M.ReskinIcon(bu)
		end

		M.Reskin(note.Controls.DeleteButton)
		M.Reskin(note.Controls.UndoButton)
		M.Reskin(note.Controls.SaveButton)
	end

	hooksecurefunc(Rematch, "FillPetTypeIcon", function(_, texture, _, prefix)
		if prefix then
			local button = texture:GetParent()
			S.RematchIcon(button)
		end
	end)

	hooksecurefunc(Rematch, "MenuButtonSetChecked", function(_, button, isChecked, isRadio)
		if isChecked then
			local x = .5
			local y = isRadio and .5 or .25
			button.Check:SetTexCoord(x, x+.25, y-.25, y)
		else
			button.Check:SetTexCoord(0, 0, 0, 0)
		end

		if not button.styled then
			button.Check:SetVertexColor(cr, cg, cb)
			local bg = M.CreateBDFrame(button.Check, 0, true)
			bg:SetPoint("TOPLEFT", button.Check, 4, -4)
			bg:SetPoint("BOTTOMRIGHT", button.Check, -4, 4)

			button.styled = true
		end
	end)

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
		for i = 1, 3 do
			local button = frame.Pets[i]
			S.RematchIcon(button)
			button.Icon.bg:SetBackdropBorderColor(button.IconBorder:GetVertexColor())

			for j = 1, 3 do
				S.RematchIcon(button.Abilities[j])
			end
		end
	end)

	hooksecurefunc(RematchTeamTabs, "Update", function(self)
		for _, tab in next, self.Tabs do
			S.RematchIcon(tab)
			tab:SetSize(40, 40)
			tab.Icon:SetPoint("CENTER")
		end

		for _, direc in pairs({"UpButton", "DownButton"}) do
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

				local isCollapsed = RematchSettings.CollapsedOptHeaders[opt[3]]
				if isCollapsed then
					checkButton:SetTexCoord(0, .4375, 0, .4375)
				else
					checkButton:SetTexCoord(.5625, 1, 0, .4375)
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
	M.StripTextures(RematchFrame)
	M.SetBD(RematchFrame)
	for _, tab in ipairs(RematchFrame.PanelTabs.Tabs) do
		M.ReskinTab(tab)
	end
	M.StripTextures(RematchMiniPanel)

	local titleBar = RematchFrame.TitleBar
	M.StripTextures(titleBar)
	M.ReskinClose(titleBar.CloseButton)

	M.StripTextures(titleBar.MinimizeButton, 2)
	M.ReskinArrow(titleBar.MinimizeButton, "up")
	titleBar.MinimizeButton:SetPoint("TOPRIGHT", -25, -6)

	M.StripTextures(titleBar.LockButton, 2)
	M.ReskinArrow(titleBar.LockButton, "down")
	titleBar.LockButton:SetPoint("TOPLEFT", 25, -5)

	M.StripTextures(titleBar.SinglePanelButton, 2)
	M.ReskinArrow(titleBar.SinglePanelButton, "left")
	titleBar.SinglePanelButton:SetPoint("TOPLEFT", 5, -5)
end