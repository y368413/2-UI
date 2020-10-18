if select(2, UnitClass("player")) ~= "DEATHKNIGHT" then return end

local MaxDps_DeathKnight, MaxDps_DeathKnightTable = ...;
_G[MaxDps_DeathKnight] = MaxDps_DeathKnightTable;

--- @type MaxDps
if not MaxDps then return end

local MaxDps = MaxDps;
local GetTime = GetTime;
local GetRuneCooldown = GetRuneCooldown;
local DeathKnight = MaxDps:NewModule('DeathKnight');
MaxDps_DeathKnightTable.DeathKnight = DeathKnight;

function DeathKnight:Enable()
	DeathKnight:InitializeDatabase();
	--DeathKnight:CreateConfig();

	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = DeathKnight.Blood;
		--MaxDps:Print(MaxDps.Colors.Info .. 'Death Knight Blood');
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = DeathKnight.Frost;
		--MaxDps:Print(MaxDps.Colors.Info .. 'Death Knight Frost');
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = DeathKnight.Unholy;
		--MaxDps:Print(MaxDps.Colors.Info .. 'Death Knight Unholy');
	end

	return true;
end

function DeathKnight:Runes(timeShift)
	local count = 0;
	local time = GetTime();

	for i = 1, 10 do
		local start, duration, runeReady = GetRuneCooldown(i);
		if start and start > 0 then
			local rcd = duration + start - time;
			if rcd < timeShift then
				count = count + 1;
			end
		elseif runeReady then
			count = count + 1;
		end
	end

	return count;
end