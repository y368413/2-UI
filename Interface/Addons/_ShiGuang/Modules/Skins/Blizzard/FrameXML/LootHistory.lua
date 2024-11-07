local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	local r, g, b = I.r, I.g, I.b

	local frame = GroupLootHistoryFrame
	if not frame then return end

	M.StripTextures(frame)
	M.SetBD(frame)
	M.ReskinClose(frame.ClosePanelButton)
	M.ReskinTrimScroll(frame.ScrollBar)
	M.ReskinDropDown(frame.EncounterDropdown)

	local bar = frame.Timer
	if bar then
		M.StripTextures(bar)
		M.CreateBDFrame(bar, .25)
		bar.Fill:SetTexture(I.normTex)
		bar.Fill:SetVertexColor(r, g, b)
	end

	-- Resize button
	M.StripTextures(frame.ResizeButton)
	frame.ResizeButton:SetHeight(8)

	local line1 = frame.ResizeButton:CreateTexture()
	line1:SetTexture(I.bdTex)
	line1:SetVertexColor(.7, .7, .7)
	line1:SetSize(30, R.mult)
	line1:SetPoint("TOP", 0, -2)
	local line2 = frame.ResizeButton:CreateTexture()
	line2:SetTexture(I.bdTex)
	line2:SetVertexColor(.7, .7, .7)
	line2:SetSize(30, R.mult)
	line2:SetPoint("TOP", 0, -5)

	frame.ResizeButton:HookScript("OnEnter", function()
		line1:SetVertexColor(r, g, b)
		line2:SetVertexColor(r, g, b)
	end)
	frame.ResizeButton:HookScript("OnLeave", function()
		line1:SetVertexColor(.7, .7, .7)
		line2:SetVertexColor(.7, .7, .7)
	end)

	-- Item frame
	local function ReskinLootButton(button)
		if not button.styled then
			if button.BackgroundArtFrame then
				button.BackgroundArtFrame.NameFrame:SetAlpha(0)
				button.BackgroundArtFrame.BorderFrame:SetAlpha(0)
				M.CreateBDFrame(button.BackgroundArtFrame.BorderFrame, .25)
			end
			local item = button.Item
			if item then
				M.StripTextures(item, 1)
				item.bg = M.ReskinIcon(item.icon)
				item.bg:SetFrameLevel(item.bg:GetFrameLevel() + 1)
				M.ReskinIconBorder(item.IconBorder, true)
			end

			button.styled = true
		end
	end

	hooksecurefunc(frame.ScrollBox, "Update", function(self)
		self:ForEachFrame(ReskinLootButton)
	end)
end)