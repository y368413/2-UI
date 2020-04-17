if select(2, UnitClass("player")) ~= "ROGUE" then return end

local MaxDps_Rogue, MaxDps_RogueTable = ...;
_G[MaxDps_Rogue] = MaxDps_RogueTable;

--- @type MaxDps
if not MaxDps then return end
local MaxDps = MaxDps;
local Rogue = MaxDps:NewModule('Rogue');
MaxDps_RogueTable.Rogue = Rogue;

Rogue.spellMeta = {
	__index = function(t, k)
		--print('Spell Key ' .. k .. ' not found!');
	end
}

function Rogue:Enable()
	Rogue:InitializeDatabase();
	--Rogue:CreateConfig();

	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = Rogue.Assassination;
		MaxDps:Print(MaxDps.Colors.Info .. 'Rogue Assassination');
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = Rogue.Outlaw;
		MaxDps:Print(MaxDps.Colors.Info .. 'Rogue Outlaw');
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = Rogue.Subtlety;
		MaxDps:Print(MaxDps.Colors.Info .. 'Rogue Subtlety');
	end

	return true;
end