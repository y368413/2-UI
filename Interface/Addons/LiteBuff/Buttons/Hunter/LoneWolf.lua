------------------------------------------------------------
-- LoneWolf.lua
--
-- Abin
-- 2015/7/18
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "HUNTER" then return end

local _, addon = ...
local L = addon.L

local spellList = {}

local function RegisterLoneWolfSpell(id, group)
	local data = addon:BuildSpellList(spellList, id, group)
	if data then
		data.auraLabel = LibBuffGroups:GetGroupLocalName(group)
	end
	return data
end

RegisterLoneWolfSpell(160198, "MASTERY")
RegisterLoneWolfSpell(160199, "STAMINA")
RegisterLoneWolfSpell(160200, "CRITICAL_STRIKE")
RegisterLoneWolfSpell(160203, "HASTE")
RegisterLoneWolfSpell(160205, "SPELL_POWER")
RegisterLoneWolfSpell(160206, "STATS")
RegisterLoneWolfSpell(172967, "VERSATILITY")
RegisterLoneWolfSpell(172968, "MULTISTRIKE")

local SPELL_NAME = GetSpellInfo(155228)

local button = addon:CreateActionButton("HunterLoneWolf", SPELL_NAME, nil, 0, "GROUP_AURA")
button:Hide()
button:SetFlyProtect()
button:SetScrollable(spellList)
--button:RequireSpell(155228)

function button:OnTooltipText(tooltip)
	local data = self.spellList[self.index]
	if data then
		tooltip:AddLine(data.auraLabel, 0, 1, 0, 1)
	end
end

local spellKnown

function button:OnSpellUpdate()
	if InCombatLockdown() then
		return
	end

	local known = IsSpellKnown(155228)
	if spellKnown == known then
		return
	end

	spellKnown = known
	if spellKnown then
		RegisterStateDriver(self, "visibility", "[@pet, exists] hide; show")
	else
		UnregisterStateDriver(self, "visibility")
		self:Hide()
	end
end