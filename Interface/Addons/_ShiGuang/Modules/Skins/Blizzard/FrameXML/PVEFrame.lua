local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	local r, g, b = I.r, I.g, I.b

	PVEFrameLeftInset:SetAlpha(0)
	PVEFrameBlueBg:SetAlpha(0)
	PVEFrame.shadows:SetAlpha(0)

	PVEFrameTab2:SetPoint("LEFT", PVEFrameTab1, "RIGHT", -15, 0)
	PVEFrameTab3:SetPoint("LEFT", PVEFrameTab2, "RIGHT", -15, 0)

	local iconSize = 60-2*R.mult
	for i = 1, 4 do
		local bu = GroupFinderFrame["groupButton"..i]
		if bu then
			bu.ring:Hide()
			M.Reskin(bu, true)
			bu.bg:SetColorTexture(r, g, b, .25)
			bu.bg:SetInside(bu.__bg)
	
			bu.icon:SetPoint("LEFT", bu, "LEFT")
			bu.icon:SetSize(iconSize, iconSize)
			M.ReskinIcon(bu.icon)
		end
	end

	hooksecurefunc("GroupFinderFrame_SelectGroupButton", function(index)
		for i = 1, 3 do
			local button = GroupFinderFrame["groupButton"..i]
			if i == index then
				button.bg:Show()
			else
				button.bg:Hide()
			end
		end
	end)

	M.ReskinPortraitFrame(PVEFrame)

	for i = 1, 4 do
		local tab = _G["PVEFrameTab"..i]
		if tab then
			M.ReskinTab(tab)
			if i ~= 1 then
				tab:ClearAllPoints()
				tab:SetPoint("TOPLEFT", _G["PVEFrameTab"..(i-1)], "TOPRIGHT", -15, 0)
			end
		end
	end

	if ScenarioQueueFrame then
		M.StripTextures(ScenarioFinderFrame)
		ScenarioQueueFrameBackground:SetAlpha(0)
		M.ReskinDropDown(ScenarioQueueFrameTypeDropdown)
		M.Reskin(ScenarioQueueFrameFindGroupButton)
		M.ReskinTrimScroll(ScenarioQueueFrameRandomScrollFrame.ScrollBar)
		if ScenarioQueueFrameRandomScrollFrameScrollBar then
			ScenarioQueueFrameRandomScrollFrameScrollBar:SetAlpha(0)
		end
	end
end)