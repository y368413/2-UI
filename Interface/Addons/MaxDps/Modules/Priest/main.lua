if select(2, UnitClass("player")) ~= "PRIEST" then return end

local MaxDps_Priest, MaxDps_PriestTable = ...;
_G[MaxDps_Priest] = MaxDps_PriestTable;
local Priest = MaxDps:NewModule('Priest');
MaxDps_PriestTable.Priest = Priest;

Priest.spellMeta = {
	__index = function(t, k)
		--print('Spell Key ' .. k .. ' not found!');
	end
};

function Priest:Enable()
	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = Priest.Discipline;
		--MaxDps:Print(MaxDps.Colors.Info .. 'Priest - Discipline');
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = Priest.Holy;
		--MaxDps:Print(MaxDps.Colors.Info .. 'Priest - Holy');
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = Priest.Shadow;
		--MaxDps:Print(MaxDps.Colors.Info .. 'Priest - Shadow');
	end

	return true;
end
