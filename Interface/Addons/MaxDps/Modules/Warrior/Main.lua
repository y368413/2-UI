if select(2, UnitClass("player")) ~= "WARRIOR" then return end

local MaxDps_Warrior, MaxDps_WarriorTable = ...;
_G[MaxDps_Warrior] = MaxDps_WarriorTable;

--- @type MaxDps
if not MaxDps then return end

local MaxDps = MaxDps;

local Warrior = MaxDps:NewModule('Warrior');
MaxDps_WarriorTable.Warrior = Warrior;

Warrior.spellMeta = {
	__index = function(t, k)
		--print('Spell Key ' .. k .. ' not found!');
	end
}

function Warrior:Enable()
	MaxDps:Print(MaxDps.Colors.Info .. 'Warrior [Arms, Fury, Protection]');

	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = Warrior.Arms;
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = Warrior.Fury;
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = Warrior.Protection;
	end

	return true;
end