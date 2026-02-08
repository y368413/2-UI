local _, ns = ...
local B, C, L, DB = unpack(ns)
local TT = B:GetModule("Tooltip")
-----------------------
-- MountsSource
-- Author：HopeAsd
-----------------------
TT.MountTable = {}

function TT:IsCollected(spell)
	local index = TT.MountTable[spell].index
	local isCollected = select(11, C_MountJournal.GetMountInfoByID(index))

	return isCollected
end

function TT:GetOrCreateMountTable(spell)
	if issecretvalue(spell) then
		return
	end

	if not self.MountTable[spell] then
		local index = C_MountJournal.GetMountFromSpell(spell)
		if index then
			local _, mSpell = C_MountJournal.GetMountInfoByID(index)
			if spell == mSpell then
				local _, _, source = C_MountJournal.GetMountInfoExtraByID(index)
				self.MountTable[spell] = {source = source, index = index}
			end
			return self.MountTable[spell]
		end
		return nil
	end
	return self.MountTable[spell]
end

local function AddLine(self, source, isCollectedText, type, noadd)
	for i = 1, self:NumLines() do
		local line = _G[self:GetName() .. "TextLeft" .. i]
		if not line then break end
		local text = line:GetText()
		if text and text == type then return end
	end
	if not noadd then self:AddLine(" ") end
	self:AddDoubleLine(type, isCollectedText)
	self:AddLine(source, 1, 1, 1)
	self:Show()
end

function TT:MountsSource()
	if C_AddOns.IsAddOnLoaded("MountsSource") then return end

	hooksecurefunc(GameTooltip, "SetUnitAura", function(self, ...)
		--if not TT.db["MountsSource"] then return end

		local data = C_UnitAuras.GetAuraDataByIndex(...)
		if not data then return end

		local table = data.spellId and TT:GetOrCreateMountTable(data.spellId)
		if table then
			AddLine(self, table.source, TT:IsCollected(data.spellId) and COLLECTED or NOT_COLLECTED, SOURCE)
		end
	end)

	hooksecurefunc(GameTooltip, "SetUnitBuffByAuraInstanceID", function(self, unit, auraInstanceID)
		--if not TT.db["MountsSource"] then return end

		local data = C_UnitAuras.GetAuraDataByAuraInstanceID(unit, auraInstanceID)
		if not data then return end

		local table = data.spellId and TT:GetOrCreateMountTable(data.spellId)
		if table then
			AddLine(self, table.source, TT:IsCollected(data.spellId) and COLLECTED or NOT_COLLECTED, SOURCE)
		end
	end)

	B:UnregisterEvent("PLAYER_ENTERING_WORLD", TT.MountsSource)
end

B:RegisterEvent("PLAYER_ENTERING_WORLD", TT.MountsSource)