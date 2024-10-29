local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	-- ready dialog
	local PVPReadyDialog = PVPReadyDialog

	M.StripTextures(PVPReadyDialog)
	PVPReadyDialogBackground:Hide()
	M.SetBD(PVPReadyDialog)

	M.Reskin(PVPReadyDialog.enterButton)
	M.Reskin(PVPReadyDialog.leaveButton)
	M.ReskinClose(PVPReadyDialogCloseButton)

	local function stripBorders(self)
		M.StripTextures(self)
	end

	ReadyStatus.Border:SetAlpha(0)
	M.SetBD(ReadyStatus)
	M.ReskinClose(ReadyStatus.CloseButton)

	-- match score
	M.SetBD(PVPMatchScoreboard)
	PVPMatchScoreboard:HookScript("OnShow", stripBorders)
	M.ReskinClose(PVPMatchScoreboard.CloseButton)

	local content = PVPMatchScoreboard.Content
	local tabContainer = content.TabContainer

	M.StripTextures(content)
	local bg = M.CreateBDFrame(content, .25)
	bg:SetPoint("BOTTOMRIGHT", tabContainer.InsetBorderTop, 4, -1)
	M.ReskinTrimScroll(content.ScrollBar)

	M.StripTextures(tabContainer)
	for i = 1, 3 do
		M.ReskinTab(tabContainer.TabGroup["Tab"..i])
	end

	-- match results
	M.SetBD(PVPMatchResults)
	PVPMatchResults:HookScript("OnShow", stripBorders)
	M.ReskinClose(PVPMatchResults.CloseButton)
	M.StripTextures(PVPMatchResults.overlay)

	local content = PVPMatchResults.content
	local tabContainer = content.tabContainer

	M.StripTextures(content)
	local bg = M.CreateBDFrame(content, .25)
	bg:SetPoint("BOTTOMRIGHT", tabContainer.InsetBorderTop, 4, -1)
	M.StripTextures(content.earningsArt)
	M.ReskinTrimScroll(content.scrollBar)

	M.StripTextures(tabContainer)
	for i = 1, 3 do
		M.ReskinTab(tabContainer.tabGroup["tab"..i])
	end

	local buttonContainer = PVPMatchResults.buttonContainer
	M.Reskin(buttonContainer.leaveButton)
	M.Reskin(buttonContainer.requeueButton)
end)