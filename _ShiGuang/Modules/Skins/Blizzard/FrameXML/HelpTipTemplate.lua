local _, ns = ...
local M, R, U, I = unpack(ns)

local function reskinHelpTips(self)
	for frame in self.framePool:EnumerateActive() do
		if not frame.styled then
			if frame.OkayButton then M.Reskin(frame.OkayButton) end
			--if frame.CloseButton then M.ReskinClose(frame.CloseButton) end

			frame.styled = true
		end
	end
end

tinsert(R.defaultThemes, function()
	if not R.db["Skins"]["BlizzardSkins"] then return end

	reskinHelpTips(HelpTip)
	hooksecurefunc(HelpTip, "Show", reskinHelpTips)
end)