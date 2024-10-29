local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	M.ReskinPortraitFrame(PetitionFrame)
	M.Reskin(PetitionFrameSignButton)
	M.Reskin(PetitionFrameRequestButton)
	M.Reskin(PetitionFrameRenameButton)
	M.Reskin(PetitionFrameCancelButton)

	PetitionFrameCharterTitle:SetTextColor(1, .8, 0)
	PetitionFrameCharterTitle:SetShadowColor(0, 0, 0)
	PetitionFrameMasterTitle:SetTextColor(1, .8, 0)
	PetitionFrameMasterTitle:SetShadowColor(0, 0, 0)
	PetitionFrameMemberTitle:SetTextColor(1, .8, 0)
	PetitionFrameMemberTitle:SetShadowColor(0, 0, 0)
end)