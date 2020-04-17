if select(2, UnitClass("player")) ~= "MONK" then return end

local MaxDps_Monk, MaxDps_MonkTable = ...;
_G[MaxDps_Monk] = MaxDps_MonkTable;

--- @type MaxDps
if not MaxDps then return end

local MaxDps = MaxDps;
local Monk = MaxDps:NewModule('Monk');
MaxDps_MonkTable.Monk = Monk;

-- Auras
local _HitComboAura = 196741;
local _BlackoutKickAura = 116768;
local _RushingJadeWindAura = 148187;

Monk.spellMeta = {
	__index = function(t, k)
		--print('Spell Key ' .. k .. ' not found!');
	end
}

function Monk:Enable()
	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = Monk.Brewmaster;
		MaxDps:Print(MaxDps.Colors.Info .. 'Monk Brewmaster');
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = Monk.Mistweaver;
		MaxDps:Print(MaxDps.Colors.Info .. 'Monk Mistweaver');
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = Monk.Windwalker;
		MaxDps:Print(MaxDps.Colors.Info .. 'Monk Windwalker');
	end

	return true;
end