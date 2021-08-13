local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	--if not R.db["Skins"]["BlizzardSkins"] then return end

	local styled
	hooksecurefunc("LossOfControlFrame_SetUpDisplay", function(self)
		if not styled then
			M.ReskinIcon(self.Icon, true)

			styled = true
		end
	end)
end)