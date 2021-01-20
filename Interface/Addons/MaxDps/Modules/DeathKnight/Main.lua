if select(2, UnitClass("player")) ~= "DEATHKNIGHT" then return end

local MaxDps_DeathKnight, MaxDps_DeathKnightTable = ...;
_G[MaxDps_DeathKnight] = MaxDps_DeathKnightTable;

--- @type MaxDps
if not MaxDps then return end

local MaxDps = MaxDps;
local GetTime = GetTime;
local GetRuneCooldown = GetRuneCooldown;
local GetInventoryItemLink = GetInventoryItemLink;
local DeathKnight = MaxDps:NewModule('DeathKnight');
MaxDps_DeathKnightTable.DeathKnight = DeathKnight;

DeathKnight.spellMeta = {
	__index = function(t, k)
		print('Spell Key ' .. k .. ' not found!');
	end
}

DeathKnight.weaponRunes = {
	Hysteria 			 = 6243,
	Razorice 			 = 3370,
	Sanguination 		 = 6241,
	Spellwarding 		 = 6242,
	TheApocalypse 		 = 6245,
	TheFallenCrusader 	 = 3368,
	TheStoneskinGargoyle = 3847,
	UndendingThirst 	 = 6244,
};

DeathKnight.hasEnchant = {};

function DeathKnight:Enable()
	DeathKnight:InitializeDatabase();
	--DeathKnight:CreateConfig();
	DeathKnight:InitializeWeaponRunes();

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

function DeathKnight:InitializeWeaponRunes()
	DeathKnight.hasEnchant = {};

	local mainHand = GetInventoryItemLink('player', 16);
	if mainHand ~= nil then
		local _, _, eid = strsplit(":", string.match(mainHand, "item[%-?%d:]+"));
		eid = tonumber(eid);
		if eid then
			DeathKnight.hasEnchant[tonumber(eid)] = true;
		end
	end

	local offhand = GetInventoryItemLink('player', 17);
	if offhand ~= nil then
		local _, _, eid = strsplit(":", string.match(offhand, "item[%-?%d:]+"));
		eid = tonumber(eid);
		if eid then
			DeathKnight.hasEnchant[tonumber(eid)] = true;
		end
	end
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

function DeathKnight:TimeToRunes(desiredRunes)
	local time = GetTime()

	if desiredRunes == 0 then
		return 0;
	end

	if desiredRunes > 6 then
		return 99999;
	end

	local runes = {};
	local readyRuneCount = 0;
	for i = 1, 6 do
		local start, duration, runeReady = GetRuneCooldown(i);
		runes[i] = {
			start = start,
			duration = duration
		}
		if runeReady then
			readyRuneCount = readyRuneCount + 1;
		end
	end

	if readyRuneCount >= desiredRunes then
		return 0;
	end

	-- Sort the table by remaining cooldown time, ascending
	table.sort(runes, function(l,r)
		if l == nil then
			return true;
		elseif r == nil then
			return false;
		else
			return l.duration + l.start < r.duration + r.start;
		end
	end);

	-- How many additional runes need to come off cooldown before we hit our desired count?
	local neededRunes = desiredRunes - readyRuneCount;

	-- If it's three or fewer (since three runes regenerate at a time), take the remaining regen time of the Nth rune
	if neededRunes <= 3 then
		local rune = runes[desiredRunes];
		return rune.duration + rune.start - time;
	end

	-- Otherwise, we need to wait for the slowest of our three regenerating runes, plus the full regen time needed for the remaining rune(s)
	local rune = runes[readyRuneCount + 3];
	return rune.duration + rune.start - time + rune.duration;
end
