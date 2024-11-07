local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	M.StripTextures(HelpFrame)
	M.SetBD(HelpFrame)
	M.ReskinClose(HelpFrame.CloseButton)
	M.StripTextures(HelpBrowser.BrowserInset)

	M.StripTextures(BrowserSettingsTooltip)
	M.SetBD(BrowserSettingsTooltip)
	M.Reskin(BrowserSettingsTooltip.CookiesButton)

	M.StripTextures(TicketStatusFrameButton)
	M.SetBD(TicketStatusFrameButton)

	M.SetBD(ReportCheatingDialog)
	ReportCheatingDialog.Border:Hide()
	M.Reskin(ReportCheatingDialogReportButton)
	M.Reskin(ReportCheatingDialogCancelButton)
	M.StripTextures(ReportCheatingDialogCommentFrame)
	M.CreateBDFrame(ReportCheatingDialogCommentFrame, .25)
end)