if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local MaxDps_Shaman, MaxDps_ShamanTable = ...;
_G[MaxDps_Shaman] = MaxDps_ShamanTable;

--- @type MaxDps
if not MaxDps then return end
local MaxDps = MaxDps;
local GetSpellInfo = GetSpellInfo;
local GetTotemInfo = GetTotemInfo;
local GetTime = GetTime;

local Shaman = MaxDps:NewModule('Shaman');
MaxDps_ShamanTable.Shaman = Shaman;

Shaman.spellMeta = {
	__index = function(t, k)
		--print('Spell Key ' .. k .. ' not found!');
	end
};

function Shaman:Enable()
	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = Shaman.Elemental;
		MaxDps:Print(MaxDps.Colors.Info .. 'Shaman Elemental');
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = Shaman.Enhancement;
		MaxDps:Print(MaxDps.Colors.Info .. 'Shaman Enhancement');
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = Shaman.Restoration;
		MaxDps:Print(MaxDps.Colors.Info .. 'Shaman Restoration');
	end

	return true;
end

function Shaman:TotemMastery(totem)
	local tmName = GetSpellInfo(totem);

	for i = 1, 4 do
		local haveTotem, totemName, startTime, duration = GetTotemInfo(i);

		if haveTotem and totemName == tmName then
			return startTime + duration - GetTime();
		end
	end

	return 0;
end