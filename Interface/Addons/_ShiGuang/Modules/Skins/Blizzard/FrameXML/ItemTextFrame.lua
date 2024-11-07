local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	InboxFrameBg:Hide()
	ItemTextPrevPageButton:GetRegions():Hide()
	ItemTextNextPageButton:GetRegions():Hide()
	ItemTextMaterialTopLeft:SetAlpha(0)
	ItemTextMaterialTopRight:SetAlpha(0)
	ItemTextMaterialBotLeft:SetAlpha(0)
	ItemTextMaterialBotRight:SetAlpha(0)

	M.ReskinPortraitFrame(ItemTextFrame)
	M.ReskinTrimScroll(ItemTextScrollFrame.ScrollBar)
	M.ReskinArrow(ItemTextPrevPageButton, "left")
	M.ReskinArrow(ItemTextNextPageButton, "right")
	ItemTextFramePageBg:SetAlpha(0)
	ItemTextPageText:SetTextColor("P", 1, 1, 1)
	ItemTextPageText.SetTextColor = M.Dummy
end)