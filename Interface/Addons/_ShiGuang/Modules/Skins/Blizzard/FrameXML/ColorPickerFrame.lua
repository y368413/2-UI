local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	M.StripTextures(ColorPickerFrame.Header)
	ColorPickerFrame.Header:ClearAllPoints()
	ColorPickerFrame.Header:SetPoint("TOP", ColorPickerFrame, 0, 10)
	ColorPickerFrame.Border:Hide()

	M.SetBD(ColorPickerFrame)
	M.Reskin(ColorPickerFrame.Footer.OkayButton)
	M.Reskin(ColorPickerFrame.Footer.CancelButton)
end)