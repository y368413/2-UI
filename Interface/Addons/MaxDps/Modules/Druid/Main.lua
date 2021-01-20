if select(2, UnitClass("player")) ~= "DRUID" then return end

local MaxDps_Druid, MaxDps_DruidTable = ...;
_G[MaxDps_Druid] = MaxDps_DruidTable;

--- @type MaxDps
if not MaxDps then return end
local MaxDps = MaxDps;
local UnitPower = UnitPower;

local Druid = MaxDps:NewModule('Druid', 'AceEvent-3.0');
MaxDps_DruidTable.Druid = Druid;

Druid.spellMeta = {
	__index = function(t, k)
		--print('Spell Key ' .. k .. ' not found!');
	end
}

function Druid:Enable()
	Druid:UnregisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = Druid.Balance;
		MaxDps:Print(MaxDps.Colors.Info .. 'Druid Balance');
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = Druid.Feral;
		MaxDps:Print(MaxDps.Colors.Info .. 'Druid Feral');
		Druid:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = Druid.Guardian;
		MaxDps:Print(MaxDps.Colors.Info .. 'Druid Guardian');
	elseif MaxDps.Spec == 4 then
		MaxDps.NextSpell = Druid.Restoration;
		MaxDps:Print(MaxDps.Colors.Info .. 'Druid Restoration');
	end

	return true;
end