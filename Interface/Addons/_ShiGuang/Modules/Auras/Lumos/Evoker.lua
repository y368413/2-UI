local _, ns = ...
local M, R, U, I = unpack(ns)
local A = M:GetModule("Auras")

if I.MyClass ~= "EVOKER" then return end
local GetSpellTexture = C_Spell.GetSpellTexture

local function GetUnitAura(unit, spell, filter)
	return A:GetUnitAura(unit, spell, filter)
end

local function UpdateCooldown(button, spellID, texture)
	return A:UpdateCooldown(button, spellID, texture)
end

local function UpdateBuff(button, spellID, auraID, cooldown, glow)
	return A:UpdateAura(button, "player", auraID, "HELPFUL", spellID, cooldown, glow)
end

local function UpdateDebuff(button, spellID, auraID, cooldown, glow)
	return A:UpdateAura(button, "target", auraID, "HARMFUL", spellID, cooldown, glow)
end

local function UpdateSpellStatus(button, spellID)
	button.Icon:SetTexture(GetSpellTexture(spellID))
	if C_Spell.IsSpellUsable(spellID) then
		button.Icon:SetDesaturated(false)
	else
		button.Icon:SetDesaturated(true)
	end
end

function A:ChantLumos(self)
	local spec = GetSpecialization()
	if spec == 1 then --湮灭
		UpdateCooldown(self.lumos[1], 370553, true)--扭转天平
		do
			local button = self.lumos[2]
			local spellID = IsPlayerSpell(375783) and 382266 or 357208
			UpdateSpellStatus(button, spellID)
			UpdateCooldown(button, spellID, true)
			local name = GetUnitAura("player", 370553, "HELPFUL") --扭转天平高亮
			if name then
				M.ShowOverlayGlow(button)
			else
				M.HideOverlayGlow(button)
			end
		end

		do
			local button3 = self.lumos[3]
			local button4 = self.lumos[4]
			UpdateSpellStatus(button3, 356995)
			UpdateCooldown(button3, 356995, true)
			UpdateSpellStatus(button4, 357211)
			UpdateCooldown(button4, 357211, true)

			local hasBurst = GetUnitAura("player", 359618, "HELPFUL") --高亮精华迸发
			if hasBurst then
				M.ShowOverlayGlow(button3)
				M.ShowOverlayGlow(button4)
			else
				M.HideOverlayGlow(button3)
				M.HideOverlayGlow(button4)
			end
		end

		UpdateCooldown(self.lumos[5], 357210, true)--深呼吸

	elseif spec == 2 then --恩护
		local spellID = IsPlayerSpell(375783) and 382614 or 355936
		UpdateCooldown(self.lumos[1], spellID, true)--梦境吐息

		do
			local button2 = self.lumos[2]--翡翠之花
			UpdateSpellStatus(button2, 355913)
			UpdateCooldown(button2, 355913, true)
			local button3 = self.lumos[3] --回响
			UpdateSpellStatus(button3, 364343)
			UpdateCooldown(button3, 364343, true)

			local hasBurst = GetUnitAura("player", 369299, "HELPFUL") --高亮精华迸发
			if hasBurst then
				M.ShowOverlayGlow(button2)
				M.ShowOverlayGlow(button3)
			else
				M.HideOverlayGlow(button2)
				M.HideOverlayGlow(button3)
			end
		end

		UpdateCooldown(self.lumos[4], 366155, true)--逆转
		UpdateCooldown(self.lumos[5], 360995, true)--清脆之拥

	elseif spec == 3 then --增辉
		local spellID = IsPlayerSpell(408083) and 382266 or 357208
		UpdateCooldown(self.lumos[1], spellID, true)
		UpdateCooldown(self.lumos[2], 409311, true)
		UpdateCooldown(self.lumos[3], 395152, true)
		UpdateCooldown(self.lumos[4], 408092, true)
		UpdateCooldown(self.lumos[5], 403631, true)
	end
end