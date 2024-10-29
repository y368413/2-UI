local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	GuildRegistrarFrameEditBox:SetHeight(20)
	AvailableServicesText:SetTextColor(1, 1, 1)
	AvailableServicesText:SetShadowColor(0, 0, 0)

	M.ReskinPortraitFrame(GuildRegistrarFrame)
	GuildRegistrarFrameEditBox:DisableDrawLayer("BACKGROUND")
	M.CreateBDFrame(GuildRegistrarFrameEditBox, .25)
	M.Reskin(GuildRegistrarFrameGoodbyeButton)
	M.Reskin(GuildRegistrarFramePurchaseButton)
	M.Reskin(GuildRegistrarFrameCancelButton)
end)