local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	local toggleButton = CompactRaidFrameManagerToggleButton
	if not toggleButton then return end

	toggleButton:SetSize(16, 16)

	local nt = toggleButton:GetNormalTexture()

	local function updateArrow()
		if CompactRaidFrameManager.collapsed then
			M.SetupArrow(nt, "right")
		else
			M.SetupArrow(nt, "left")
		end
		nt:SetTexCoord(0, 1, 0, 1)
	end

	updateArrow()
	hooksecurefunc("CompactRaidFrameManager_Collapse", updateArrow)
	hooksecurefunc("CompactRaidFrameManager_Expand", updateArrow)

	M.ReskinDropDown(CompactRaidFrameManagerDisplayFrameModeControlDropdown)
	M.ReskinDropDown(CompactRaidFrameManagerDisplayFrameRestrictPingsDropdown)

	for _, button in pairs({CompactRaidFrameManager.displayFrame.BottomButtons:GetChildren()}) do
		if button:IsObjectType("Button") then
			M.Reskin(button)
		end
	end

	M.StripTextures(CompactRaidFrameManager, 0)
	select(1, CompactRaidFrameManagerDisplayFrame:GetRegions()):SetAlpha(0)

	local bd = M.SetBD(CompactRaidFrameManager)
	bd:SetPoint("TOPLEFT")
	bd:SetPoint("BOTTOMRIGHT", -9, 9)
	M.ReskinCheck(CompactRaidFrameManagerDisplayFrameEveryoneIsAssistButton)
end)