local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	M.StripTextures(GameMenuFrame.Header)
	GameMenuFrame.Header:ClearAllPoints()
	GameMenuFrame.Header:SetPoint("TOP", GameMenuFrame, 0, 7)
	M.SetBD(GameMenuFrame)
	GameMenuFrame.Border:Hide()
	GameMenuFrame.Header.Text:SetFontObject(Game16Font)
	local line = GameMenuFrame.Header:CreateTexture(nil, "ARTWORK")
	line:SetSize(156, R.mult)
	line:SetPoint("BOTTOM", 0, 5)
	line:SetColorTexture(1, 1, 1, .25)

	local buttons = {
		"GameMenuButtonHelp",
		"GameMenuButtonWhatsNew",
		"GameMenuButtonStore",
		"GameMenuButtonMacros",
		"GameMenuButtonAddons",
		"GameMenuButtonLogout",
		"GameMenuButtonQuit",
		"GameMenuButtonContinue",
		"GameMenuButtonSettings",
		"GameMenuButtonEditMode",
	}
	for _, buttonName in next, buttons do
		local button = _G[buttonName]
		if button then
			M.Reskin(button)
		end
	end

	local cr, cg, cb = I.r, I.g, I.b

	hooksecurefunc(GameMenuFrame, "InitButtons", function(self)
		if not self.buttonPool then return end

		for button in self.buttonPool:EnumerateActive() do
			if not button.styled then
				button:DisableDrawLayer("BACKGROUND")
				button.bg = M.CreateBDFrame(button, 0, true)
				local hl = button:GetHighlightTexture()
				hl:SetColorTexture(cr, cg, cb, .25)
				hl:SetInside(button.bg)
				button.bg:SetInside()

				button.styled = true
			end
		end
	end)
end)