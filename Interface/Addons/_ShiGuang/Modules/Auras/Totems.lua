local _, ns = ...
local M, R, U, I = unpack(ns)
local A = M:GetModule("Auras")

-- Style
local totem = {}
local icons = {
	[1] = GetSpellTexture(120217), -- Fire
	[2] = GetSpellTexture(120218), -- Earth
	[3] = GetSpellTexture(120214), -- Water
	[4] = GetSpellTexture(120219), -- Air
}

local function TotemsGo()
	local Totembar = CreateFrame("Frame", nil, A.PetBattleFrameHider)
	Totembar:SetSize(R.Auras.IconSize, R.Auras.IconSize)
	for i = 1, 4 do
		totem[i] = CreateFrame("Button", nil, Totembar)
		totem[i]:SetSize(R.Auras.IconSize, R.Auras.IconSize)
		if i == 1 then
			totem[i]:SetPoint("CENTER", Totembar)
		else
			totem[i]:SetPoint("LEFT", totem[i-1], "RIGHT", 5, 0)
		end
		M.AuraIcon(totem[i])
		totem[i].Icon:SetTexture(icons[i])
		totem[i]:SetAlpha(.2)

		local defaultTotem = _G["TotemFrameTotem"..i]
		defaultTotem:SetParent(totem[i])
		defaultTotem:SetAllPoints()
		defaultTotem:SetAlpha(0)
		totem[i].parent = defaultTotem
	end
	M.Mover(Totembar, U["Totembar"], "Totems", R.Auras.TotemsPos, 140, 32)
end

function A:UpdateTotems()
	for i = 1, 4 do
		local totem = totem[i]
		local defaultTotem = totem.parent
		local slot = defaultTotem.slot

		local haveTotem, _, start, dur, icon = GetTotemInfo(slot)
		if haveTotem and dur > 0 then
			totem.Icon:SetTexture(icon)
			totem.CD:SetCooldown(start, dur)
			totem.CD:Show()
			totem:SetAlpha(1)
		else
			totem:SetAlpha(.2)
			totem.Icon:SetTexture(icons[i])
			totem.CD:Hide()
		end
	end
end

function A:Totems()
	if not MaoRUIPerDB["Auras"]["Totems"] then return end
	TotemsGo()
	M:RegisterEvent("PLAYER_ENTERING_WORLD", self.UpdateTotems)
	M:RegisterEvent("PLAYER_TOTEM_UPDATE", self.UpdateTotems)
end