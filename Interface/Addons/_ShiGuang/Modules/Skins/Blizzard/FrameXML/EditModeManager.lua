local _, ns = ...
local M, R, U, I = unpack(ns)

local function reskinOptionCheck(button)
	M.ReskinCheck(button)
	button.bg:SetInside(button, 6, 6)
end

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	local frame = EditModeManagerFrame

	M.StripTextures(frame)
	M.SetBD(frame)
	M.ReskinClose(frame.CloseButton)
	M.Reskin(frame.RevertAllChangesButton)
	M.Reskin(frame.SaveChangesButton)
	M.ReskinDropDown(frame.LayoutDropdown)
	reskinOptionCheck(frame.ShowGridCheckButton.Button)
	reskinOptionCheck(frame.EnableSnapCheckButton.Button)
	reskinOptionCheck(frame.EnableAdvancedOptionsCheckButton.Button)
	M.ReskinStepperSlider(frame.GridSpacingSlider.Slider, true)
	if frame.Tutorial then
		frame.Tutorial.Ring:Hide()
	end

	local dialog = EditModeSystemSettingsDialog
	M.StripTextures(dialog)
	M.SetBD(dialog)
	M.ReskinClose(dialog.CloseButton)
	frame.AccountSettings.SettingsContainer.BorderArt:Hide()
	M.CreateBDFrame(frame.AccountSettings.SettingsContainer, .25)
	M.ReskinTrimScroll(frame.AccountSettings.SettingsContainer.ScrollBar)

	local function reskinOptionChecks(settings)
		for i = 1, settings:GetNumChildren() do
			local option = select(i, settings:GetChildren())
			if option.Button and not option.styled then
				reskinOptionCheck(option.Button)
				option.styled = true
			end
		end
	end

	hooksecurefunc(frame.AccountSettings, "OnEditModeEnter", function(self)
		local basicOptions = self.SettingsContainer.ScrollChild.BasicOptionsContainer
		if basicOptions then
			reskinOptionChecks(basicOptions)
		end

		local advancedOptions = self.SettingsContainer.ScrollChild.AdvancedOptionsContainer
		if advancedOptions.FramesContainer then
			reskinOptionChecks(advancedOptions.FramesContainer)
		end
		if advancedOptions.CombatContainer then
			reskinOptionChecks(advancedOptions.CombatContainer)
		end
		if advancedOptions.MiscContainer then
			reskinOptionChecks(advancedOptions.MiscContainer)
		end
	end)

	hooksecurefunc(dialog, "UpdateExtraButtons", function(self)
		local revertButton = self.Buttons and self.Buttons.RevertChangesButton
		if revertButton and not revertButton.styled then
			M.Reskin(revertButton)
			revertButton.styled = true
		end

		for button in self.pools:EnumerateActiveByTemplate("EditModeSystemSettingsDialogExtraButtonTemplate") do
			if not button.styled then
				M.Reskin(button)
				button.styled = true
			end
		end

		for check in self.pools:EnumerateActiveByTemplate("EditModeSettingCheckboxTemplate") do
			if not check.styled then
				M.ReskinCheck(check.Button)
				check.Button.bg:SetInside(nil, 6, 6)
				check.styled = true
			end
		end

		for dropdown in self.pools:EnumerateActiveByTemplate("EditModeSettingDropdownTemplate") do
			if not dropdown.styled then
				M.ReskinDropDown(dropdown.Dropdown)
				dropdown.styled = true
			end
		end

		for slider in self.pools:EnumerateActiveByTemplate("EditModeSettingSliderTemplate") do
			if not slider.styled then
				M.ReskinStepperSlider(slider.Slider, true)
				slider.styled = true
			end
		end
	end)

	local dialog = EditModeUnsavedChangesDialog
	M.StripTextures(dialog)
	M.SetBD(dialog)
	M.Reskin(dialog.SaveAndProceedButton)
	M.Reskin(dialog.ProceedButton)
	M.Reskin(dialog.CancelButton)

	local function ReskinLayoutDialog(dialog)
		M.StripTextures(dialog)
		M.SetBD(dialog)
		M.Reskin(dialog.AcceptButton)
		M.Reskin(dialog.CancelButton)

		local check = dialog.CharacterSpecificLayoutCheckButton
		if check then
			M.ReskinCheck(check.Button)
			check.Button.bg:SetInside(nil, 6, 6)
		end

		local editbox = dialog.LayoutNameEditBox
		if editbox then
			M.ReskinEditBox(editbox)
			editbox.__bg:SetPoint("TOPLEFT", -5, -5)
			editbox.__bg:SetPoint("BOTTOMRIGHT", 5, 5)
		end

		local importBox = dialog.ImportBox
		if importBox then
			M.StripTextures(importBox)
			M.CreateBDFrame(importBox, .25)
		end
	end

	ReskinLayoutDialog(EditModeNewLayoutDialog)
	ReskinLayoutDialog(EditModeImportLayoutDialog)
end)