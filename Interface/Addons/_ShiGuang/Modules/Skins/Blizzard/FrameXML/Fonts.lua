local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	--if not R.db["Skins"]["FontOutline"] then return end
	-- Refont RaidFrame Health
	hooksecurefunc("CompactUnitFrame_UpdateStatusText", function(frame)
		if frame:IsForbidden() then return end
		if not frame.statusText then return end

		local options = DefaultCompactUnitFrameSetupOptions
		frame.statusText:ClearAllPoints()
		frame.statusText:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 3, options.height/3 - 5)
		frame.statusText:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, options.height/3 - 5)

		if not frame.fontStyled then
			local fontName, fontSize = frame.statusText:GetFont()
			frame.statusText:SetFont(fontName, fontSize, "OUTLINE")
			frame.statusText:SetTextColor(.7, .7, .7)
			frame.statusText:SetShadowColor(0, 0, 0, 0)
			frame.fontStyled = true
		end
	end)

	-- WhoFrame LevelText
	hooksecurefunc("WhoList_Update", function()
		local buttons = WhoListScrollFrame.buttons
		for i = 1, #buttons do
			local button = buttons[i]
			local level = button.Level
			if level and not level.fontStyled then
				level:SetWidth(32)
				level:SetJustifyH("LEFT")
				level.fontStyled = true
			end
		end
	end)
end)