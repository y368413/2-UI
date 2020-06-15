local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	--if not MaoRUIPerDB["Skins"]["FontOutline"] then return end
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