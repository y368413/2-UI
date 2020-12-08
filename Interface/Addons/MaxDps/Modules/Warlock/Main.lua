if select(2, UnitClass("player")) ~= "WARLOCK" then return end

local MaxDps_Warlock, MaxDps_WarlockTable = ...;
_G[MaxDps_Warlock] = MaxDps_WarlockTable;

--- @type MaxDps
if not MaxDps then return end

local Warlock = MaxDps:NewModule('Warlock', 'AceEvent-3.0');
MaxDps_WarlockTable.Warlock = Warlock;

local MaxDps = MaxDps;

Warlock.spellMeta = {
	__index = function(t, k)
		--print('Spell Key ' .. k .. ' not found!');
	end
}

function Warlock:Enable()
	MaxDps:Print(MaxDps.Colors.Info .. 'Warlock [Affliction, Demonology, Destruction]');

	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = Warlock.Affliction;
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = Warlock.Demonology;
		--self:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED', 'CLEU');
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = Warlock.Destruction;
	end

	return true;
end

function Warlock:Disable()
	self:UnregisterAllEvents();
end