local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	local WorldMapFrame = WorldMapFrame
	local BorderFrame = WorldMapFrame.BorderFrame

	M.ReskinPortraitFrame(WorldMapFrame)
	BorderFrame.NineSlice:Hide()
	BorderFrame.Tutorial.Ring:Hide()
	M.ReskinMinMax(BorderFrame.MaximizeMinimizeFrame)

	local overlayFrames = WorldMapFrame.overlayFrames
	M.ReskinDropDown(overlayFrames[1])
	M.StripTextures(overlayFrames[2], 3)
	M.StripTextures(overlayFrames[3], 3)
	overlayFrames[3].ActiveTexture:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Toggle")

	local sideToggle = WorldMapFrame.SidePanelToggle
	sideToggle:SetFrameLevel(3)
	sideToggle.OpenButton:GetRegions():Hide()
	M.ReskinArrow(sideToggle.OpenButton, "right")
	sideToggle.CloseButton:GetRegions():Hide()
	M.ReskinArrow(sideToggle.CloseButton, "left")

	M.ReskinNavBar(WorldMapFrame.NavBar)
end)