local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	local r, g, b = I.r, I.g, I.b

	local function moveNavButtons(self)
		local width = 0
		local collapsedWidth
		local maxWidth = self:GetWidth() - self.widthBuffer

		local lastShown
		local collapsed = false

		for i = #self.navList, 1, -1 do
			local currentWidth = width
			width = width + self.navList[i]:GetWidth()

			if width > maxWidth then
				collapsed = true
				if not collapsedWidth then
					collapsedWidth = currentWidth
				end
			else
				if lastShown then
					self.navList[lastShown]:SetPoint("LEFT", self.navList[i], "RIGHT", 1, 0)
				end
				lastShown = i
			end
		end

		if collapsed then
			if collapsedWidth + self.overflowButton:GetWidth() > maxWidth then
				lastShown = lastShown + 1
			end

			if lastShown then
				local lastButton = self.navList[lastShown]

				if lastButton then
					lastButton:SetPoint("LEFT", self.overflowButton, "RIGHT", 1, 0)
				end
			end
		end
	end

	hooksecurefunc("NavBar_Initialize", M.ReskinNavBar)

	hooksecurefunc("NavBar_AddButton", function(self)
		M.ReskinNavBar(self)

		local navButton = self.navList[#self.navList]
		if not navButton.restyled then
			M.Reskin(navButton)
			navButton.arrowUp:SetAlpha(0)
			navButton.arrowDown:SetAlpha(0)
			navButton.selected:SetDrawLayer("BACKGROUND", 1)
			navButton.selected:SetColorTexture(r, g, b, .25)
			navButton.selected:SetInside(navButton.__bg)

			navButton:HookScript("OnClick", function()
				moveNavButtons(self)
			end)

			-- arrow button
			local arrowButton = navButton.MenuArrowButton
			arrowButton.Art:Hide()
			arrowButton:SetHighlightTexture(0)

			local tex = arrowButton:CreateTexture(nil, "ARTWORK")
			M.SetupArrow(tex, "down")
			tex:SetSize(14, 14)
			tex:SetPoint("CENTER")
			arrowButton.__texture = tex

			arrowButton:SetScript("OnEnter", M.Texture_OnEnter)
			arrowButton:SetScript("OnLeave", M.Texture_OnLeave)

			navButton.restyled = true
		end

		moveNavButtons(self)
	end)
end)