local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	-- Cinematic

	CinematicFrameCloseDialog:HookScript("OnShow", function(self)
		self:SetScale(UIParent:GetScale())
	end)

	M.StripTextures(CinematicFrameCloseDialog)
	local bg = M.SetBD(CinematicFrameCloseDialog)
	bg:SetFrameLevel(1)
	M.Reskin(CinematicFrameCloseDialogConfirmButton)
	M.Reskin(CinematicFrameCloseDialogResumeButton)

	-- Movie

	local closeDialog = MovieFrame.CloseDialog

	closeDialog:HookScript("OnShow", function(self)
		self:SetScale(UIParent:GetScale())
	end)

	M.StripTextures(closeDialog)
	local bg = M.SetBD(closeDialog)
	bg:SetFrameLevel(1)
	M.Reskin(closeDialog.ConfirmButton)
	M.Reskin(closeDialog.ResumeButton)
end)