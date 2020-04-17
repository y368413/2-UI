if select(2, UnitClass("player")) ~= "MAGE" then return end

local MaxDps_Mage, MaxDps_MageTable = ...;
_G[MaxDps_Mage] = MaxDps_MageTable;

--- @type MaxDps
if not MaxDps then return end

local MaxDps = MaxDps;
local Mage = MaxDps:NewModule('Mage', 'AceEvent-3.0');
MaxDps_MageTable.Mage = Mage;

Mage.spellMeta = {
	__index = function(t, k)
		--print('Spell Key ' .. k .. ' not found!');
	end
}

function Mage:Enable()
	if MaxDps.Spec == 1 then
		MaxDps:Print(MaxDps.Colors.Info .. 'Mage - Arcane');
		MaxDps.NextSpell = Mage.Arcane;
	elseif MaxDps.Spec == 2 then
		MaxDps:Print(MaxDps.Colors.Info .. 'Mage - Fire');
		MaxDps.NextSpell = Mage.Fire;
	elseif MaxDps.Spec == 3 then
		MaxDps:Print(MaxDps.Colors.Info .. 'Mage - Frost');
		MaxDps.NextSpell = Mage.Frost;
		Mage:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	end

	return true;
end

function Mage:Disable()
	self:UnregisterAllEvents();
end

