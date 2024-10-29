local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	TimeManagerGlobe:Hide()
	TimeManagerStopwatchCheck:GetNormalTexture():SetTexCoord(unpack(I.TexCoord))
	TimeManagerStopwatchCheck:GetHighlightTexture():SetColorTexture(1, 1, 1, .25)
	TimeManagerStopwatchCheck:SetCheckedTexture(I.pushedTex)
	M.CreateBDFrame(TimeManagerStopwatchCheck)

	M.ReskinDropDown(TimeManagerAlarmTimeFrame.HourDropdown)
	M.ReskinDropDown(TimeManagerAlarmTimeFrame.MinuteDropdown)
	M.ReskinDropDown(TimeManagerAlarmTimeFrame.AMPMDropdown)

	M.ReskinPortraitFrame(TimeManagerFrame)
	M.ReskinInput(TimeManagerAlarmMessageEditBox)
	M.ReskinCheck(TimeManagerAlarmEnabledButton)
	M.ReskinCheck(TimeManagerMilitaryTimeCheck)
	M.ReskinCheck(TimeManagerLocalTimeCheck)

	M.StripTextures(StopwatchFrame)
	M.StripTextures(StopwatchTabFrame)
	M.SetBD(StopwatchFrame)
	M.ReskinClose(StopwatchCloseButton, StopwatchFrame, -2, -2)

	local reset = StopwatchResetButton
	reset:GetNormalTexture():SetTexCoord(.25, .75, .27, .75)
	reset:SetSize(18, 18)
	reset:GetHighlightTexture():SetColorTexture(1, 1, 1, .25)
	reset:SetPoint("BOTTOMRIGHT", -5, 7)
	local play = StopwatchPlayPauseButton
	play:GetNormalTexture():SetTexCoord(.25, .75, .27, .75)
	play:SetSize(18, 18)
	play:GetHighlightTexture():SetColorTexture(1, 1, 1, .25)
	play:SetPoint("RIGHT", reset, "LEFT", -2, 0)
end)