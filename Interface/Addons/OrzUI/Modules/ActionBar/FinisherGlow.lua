local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")

local LAB = LibStub("LibActionButton-1.0-OrzUI")
local ActionButtons = LAB.actionButtons

-- https://www.wowhead.com/cn/resource/4
local FinisherSpells = {
	["ROGUE"] = {
		[408] = true,		-- 肾击
		[1943] = true,		-- 割裂
		[2098] = true,		-- 斩击
		[32645] = true,		-- 毒伤
		[51690] = true,		-- 影舞步
		[121411] = true,	-- 猩红风暴
		[196819] = true,	-- 刺骨
		[269513] = true,	-- 天降杀机
		[280719] = true,	-- 影分身
		[315341] = true,	-- 正中眉心
		[315496] = true,	-- 切割
		[319175] = true,	-- 黑火药
	},
	["DRUID"] = {
		[1079] = true,		-- 割裂
		[22568] = true,		-- 凶猛撕咬
		[22570] = true,		-- 割碎
		[52610] = true,		-- 野蛮咆哮
		[285381] = true,	-- 原始之怒
	}
}

function Bar:UpdateMaxPoints(...)
	local unit, powerType = ...
	if not unit or (unit == "player" and powerType == "COMBO_POINTS") then
		Bar.MaxComboPoints = UnitPowerMax("player", Enum.PowerType.ComboPoints)
	end
end

function Bar:FinisherGlow_Update()
	local spellId = self:GetSpellId()
	if spellId and Bar.Finishers[spellId] then
		if UnitPower("player", Enum.PowerType.ComboPoints) == Bar.MaxComboPoints then
			M.ShowOverlayGlow(self)
		else
			M.HideOverlayGlow(self)
		end
	end
end

function Bar:FinisherGlow_OnEvent(...)
	local unit, powerType = ...
	if unit == "player" and powerType == "COMBO_POINTS" then
		for button in next, ActionButtons do
			if button:IsVisible() then
				Bar.FinisherGlow_Update(button)
			end
		end
	end
end

function Bar:FinisherGlow_OnButtonUpdate(button)
	Bar.FinisherGlow_Update(button)
end

function Bar:FinisherGlow()
	--if not Bar.db["FinisherGlow"] then return end

	Bar.Finishers = FinisherSpells[I.MyClass]
	if not Bar.Finishers then return end

	Bar:UpdateMaxPoints()
	M:RegisterEvent("UNIT_MAXPOWER", Bar.UpdateMaxPoints)
	M:RegisterEvent("UNIT_POWER_UPDATE", Bar.FinisherGlow_OnEvent)
	LAB:RegisterCallback("OnButtonUpdate", Bar.FinisherGlow_OnButtonUpdate)
end