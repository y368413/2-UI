local _, ns = ...
local M, R, U, I = unpack(ns)
local oUF = ns.oUF or oUF
local MISC = M:GetModule("Misc")

local _G = getfenv(0)
local next, strmatch = next, string.match
local InCombatLockdown = InCombatLockdown

local modifier = "shift" -- shift, alt or ctrl
local mouseButton = "1" -- 1 = left, 2 = right, 3 = middle, 4 and 5 = thumb buttons if there are any
local pending = {}

function MISC:Focuser_Setup()
	if not self or self.focuser then return end
	if self:GetName() and strmatch(self:GetName(), "oUF_NPs") then return end

	if not InCombatLockdown() then
		self:SetAttribute(modifier.."-type"..mouseButton, "focus")
		self.focuser = true
		pending[self] = nil
	else
		pending[self] = true
	end
end

function MISC:Focuser_CreateFrameHook(name, _, template)
	if name and template == "SecureUnitButtonTemplate" then
		MISC.Focuser_Setup(_G[name])
	end
end

function MISC.Focuser_OnEvent(event)
  -- Set the keybindings on the default unit frames since we won't get any CreateFrame notification about them
  local duf = {
	PlayerFrame,
	PetFrame,
	PartyMemberFrame1,
	PartyMemberFrame2,
	PartyMemberFrame3,
	PartyMemberFrame4,
	PartyMemberFrame1PetFrame,
	PartyMemberFrame2PetFrame,
	PartyMemberFrame3PetFrame,
	PartyMemberFrame4PetFrame,
	TargetFrame,
	TargetofTargetFrame,
  }
	if event == "PLAYER_REGEN_ENABLED" then
		if next(pending) then
			for frame in next, pending do
				MISC.Focuser_Setup(frame)
			end
		end
	else
		for _, object in next, oUF.objects do
			if not object.focuser then
				MISC.Focuser_Setup(object)
			end
		end
		for _, object in next, duf do
			if not object.focuser then
				MISC.Focuser_Setup(object)
			end
		end
	end
end

function MISC:Focuser()
	if not MaoRUIPerDB["Misc"]["Focuser"] then return end

	-- Keybinding override so that models can be shift/alt/ctrl+clicked
	local f = CreateFrame("CheckButton", "FocuserButton", UIParent, "SecureActionButtonTemplate")
	f:SetAttribute("type1", "macro")
	f:SetAttribute("macrotext", "/focus mouseover")
	SetOverrideBindingClick(FocuserButton, true, modifier.."-BUTTON"..mouseButton, "FocuserButton")

	hooksecurefunc("CreateFrame", MISC.Focuser_CreateFrameHook)
	self:Focuser_OnEvent()
	M:RegisterEvent("PLAYER_REGEN_ENABLED", self.Focuser_OnEvent)
	M:RegisterEvent("GROUP_ROSTER_UPDATE", self.Focuser_OnEvent)
end