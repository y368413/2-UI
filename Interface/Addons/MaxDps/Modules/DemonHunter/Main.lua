if select(2, UnitClass("player")) ~= "DEMONHUNTER" then return end

local MaxDps_DemonHunter, MaxDps_DemonHunterTable = ...;
_G[MaxDps_DemonHunter] = MaxDps_DemonHunterTable;

--- @type MaxDps
if not MaxDps then return end
local MaxDps = MaxDps;

local DemonHunter = MaxDps:NewModule('DemonHunter');
MaxDps_DemonHunterTable.DemonHunter = DemonHunter;

DemonHunter.spellMeta = {
	__index = function(t, k)
		--print('Spell Key ' .. k .. ' not found!');
	end
}

function DemonHunter:Enable()
	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = DemonHunter.Havoc;
		MaxDps:Print(MaxDps.Colors.Info .. 'DemonHunter - Havoc');
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = DemonHunter.Vengeance;
		MaxDps:Print(MaxDps.Colors.Info .. 'DemonHunter - Vengeance');
	end

	return true;
end