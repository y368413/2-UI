local _, ns = ...
local M, R, U, I = unpack(ns)
local S = M:GetModule("Skins")

local function ReskinTMW()
	if not R.db["Skins"]["TMW"] then return end

	TMW.Classes.Icon:PostHookMethod("OnNewInstance", function(self)
		if not self.bg then
			self.bg = M.SetBD(self)
		end
	end)

	TMW.Classes.IconModule_Texture:PostHookMethod("OnNewInstance", function(self)
		self.texture:SetTexCoord(unpack(I.TexCoord))
	end)
end

S:RegisterSkin("TellMeWhen", ReskinTMW)