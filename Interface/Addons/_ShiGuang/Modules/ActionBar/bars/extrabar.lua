local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")

local _G = _G
local tinsert = tinsert
local cfg = R.Bars.extrabar
local padding = R.Bars.padding

function Bar:CreateExtrabar()
	local buttonList = {}
	local size = cfg.size

	-- ExtraActionButton
	local frame = CreateFrame("Frame", "UI_ActionBarExtra", UIParent, "SecureHandlerStateTemplate")
	frame:SetWidth(size + 2*padding)
	frame:SetHeight(size + 2*padding)
	frame.mover = M.Mover(frame, U["Extrabar"], "Extrabar", {"BOTTOM", UIParent, "BOTTOM", 0, 210})

	ExtraActionBarFrame:EnableMouse(false)
	ExtraAbilityContainer:SetParent(frame)
	ExtraAbilityContainer:ClearAllPoints()
	ExtraAbilityContainer:SetPoint("CENTER", frame, 0, 2*padding)
	ExtraAbilityContainer.ignoreFramePositionManager = true

	local button = ExtraActionButton1
	tinsert(buttonList, button)
	tinsert(Bar.buttons, button)
	button:SetSize(size, size)

	frame.frameVisibility = "[extrabar] show; hide"
	RegisterStateDriver(frame, "visibility", frame.frameVisibility)

	if cfg.fader then
		Bar.CreateButtonFrameFader(frame, buttonList, cfg.fader)
	end

	-- ZoneAbility
	local zoneFrame = CreateFrame("Frame", "UI_ActionBarZone", UIParent)
	zoneFrame:SetWidth(size + 2*padding)
	zoneFrame:SetHeight(size + 2*padding)
	zoneFrame.mover = M.Mover(zoneFrame, U["Zone Ability"], "ZoneAbility", {"BOTTOM", UIParent, "BOTTOM", -360, 100})

	ZoneAbilityFrame:SetParent(zoneFrame)
	ZoneAbilityFrame:ClearAllPoints()
	ZoneAbilityFrame:SetPoint("CENTER", zoneFrame)
	ZoneAbilityFrame.ignoreFramePositionManager = true
	ZoneAbilityFrame.Style:SetAlpha(0)

	hooksecurefunc(ZoneAbilityFrame, "UpdateDisplayedZoneAbilities", function(self)
		for spellButton in self.SpellButtonContainer:EnumerateActive() do
			if spellButton and not spellButton.styled then
				spellButton.NormalTexture:SetAlpha(0)
				spellButton:SetPushedTexture(I.textures.pushed) --force it to gain a texture
				spellButton:GetHighlightTexture():SetColorTexture(1, 1, 1, .25)
				spellButton:GetHighlightTexture():SetInside()
				spellButton.Icon:SetInside()
				M.ReskinIcon(spellButton.Icon, true)
				spellButton.styled = true
			end
		end
	end)

	-- Fix button visibility
	hooksecurefunc(ZoneAbilityFrame, "SetParent", function(self, parent)
		if parent == ExtraAbilityContainer then
			self:SetParent(zoneFrame)
		end
	end)
end