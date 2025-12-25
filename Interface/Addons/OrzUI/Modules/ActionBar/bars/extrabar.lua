local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")

local _G = _G
local tinsert = tinsert
local padding = R.Bars.padding

function Bar:CreateExtrabar()
	local buttonList = {}
	local size = 52

	-- ExtraActionButton
	local frame = CreateFrame("Frame", "OrzUI_ActionBarExtra", UIParent, "SecureHandlerStateTemplate")
	frame:SetWidth(size + 2*padding)
	frame:SetHeight(size + 2*padding)
	frame.mover = M.Mover(frame, U["Extrabar"], "Extrabar", {"BOTTOM", UIParent, "BOTTOM", 0, 210})

	ExtraAbilityContainer:SetScript("OnShow", nil)
	ExtraAbilityContainer:SetScript("OnUpdate", nil)
	ExtraAbilityContainer.OnUpdate = nil -- remove BaseLayoutMixin.OnUpdate
	ExtraAbilityContainer.IsLayoutFrame = nil -- dont let it get readded
	ExtraAbilityContainer:KillEditMode()

	ExtraActionBarFrame:EnableMouse(false)
	ExtraActionBarFrame:ClearAllPoints()
	ExtraActionBarFrame:SetPoint("CENTER", frame)
	ExtraActionBarFrame.ignoreInLayout = true
	ExtraActionBarFrame:SetIgnoreParentScale(true)
	ExtraActionBarFrame:SetScale(UIParent:GetScale())

	local button = ExtraActionButton1
	tinsert(buttonList, button)
	tinsert(Bar.buttons, button)
	button:SetSize(size, size)

	frame.frameVisibility = "[extrabar] show; hide"
	RegisterStateDriver(frame, "visibility", frame.frameVisibility)

	-- ZoneAbility
	local zoneFrame = CreateFrame("Frame", "OrzUI_ActionBarZone", UIParent)
	zoneFrame:SetWidth(size + 2*padding)
	zoneFrame:SetHeight(size + 2*padding)
	zoneFrame.mover = M.Mover(zoneFrame, U["Zone Ability"], "ZoneAbility", {"BOTTOM", UIParent, "BOTTOM", -360, 100})

	ZoneAbilityFrame:SetParent(zoneFrame)
	ZoneAbilityFrame:ClearAllPoints()
	ZoneAbilityFrame:SetPoint("CENTER", zoneFrame)
	ZoneAbilityFrame.ignoreInLayout = true
	ZoneAbilityFrame.Style:SetAlpha(0)

	hooksecurefunc(ZoneAbilityFrame, "UpdateDisplayedZoneAbilities", function(self)
		for spellButton in self.SpellButtonContainer:EnumerateActive() do
			if spellButton and not spellButton.styled then
				spellButton.NormalTexture:SetAlpha(0)
				spellButton:SetPushedTexture(I.pushedTex) --force it to gain a texture
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

	-- Extra button range, needs review
	hooksecurefunc("ActionButton_UpdateRangeIndicator", function(self, checksRange, inRange)
		if not self.action then return end
		if checksRange and not inRange then
			self.icon:SetVertexColor(.8, .1, .1)
		else
			local isUsable, notEnoughMana = IsUsableAction(self.action)
			if isUsable then
				self.icon:SetVertexColor(1, 1, 1)
			elseif notEnoughMana then
				self.icon:SetVertexColor(.5, .5, 1)
			else
				self.icon:SetVertexColor(.4, .4, .4)
			end
		end
	end)
end