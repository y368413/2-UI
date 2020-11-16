if select(2, UnitClass("player")) ~= "WARLOCK" then return end

local _, MaxDps_WarlockTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Warlock = MaxDps_WarlockTable.Warlock;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitAura = UnitAura;
local GetTime = GetTime;

local DE = {
	CallDreadstalkers   = 104316,
	Demonbolt			= 264178,
	HandOfGuldan		= 105174,
	Implosion			= 196277,
	DemonicCalling		= 205146,
	DemonicCore			= 264173,
	Shadowbolt			= 686,
	SoulStrike			= 264057,
	BSBomber			= 267211,
};

setmetatable(DE, Warlock.spellMeta);

function Warlock:Demonology()
	local fd = MaxDps.FrameData;
	local wildImps = fd.wildImps;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local timeToDie = fd.timeToDie;
	local targets = MaxDps:SmartAoe();
	fd.targets = targets;
	local gcd = fd.gcd;
	local soulShards = UnitPower('player', Enum.PowerType.SoulShards);

	if currentSpell == DE.CallDreadstalkers and not buff[DE.DemonicCalling].up then
		soulShards = soulShards - 2;
	elseif currentSpell == DE.Demonbolt then
		soulShards = soulShards + 2;
	elseif currentSpell == DE.Shadowbolt then
		soulShards = soulShards + 1;
	elseif currentSpell == DE.HandOfGuldan then
		if soulShards > 3 then
			soulShards = soulShards - 3;
		else
			soulShards = 0;
		end
	end

	--if wildImps >= 3 and cooldown[DE.Implosion].ready then
	--	return DE.Implosion
	--end
	if cooldown[DE.BSBomber].ready and soulShards >= 2 then
		return DE.BSBomber;
	end

	if cooldown[DE.CallDreadstalkers].ready and soulShards >= 2 and currentSpell ~= DE.CallDreadstalkers then
		return DE.CallDreadstalkers;
	end

	if cooldown[DE.SoulStrike].ready and soulShards < 5 then
		return DE.SoulStrike;
	end

	if cooldown[DE.HandOfGuldan].ready and soulShards >= 4 and currentSpell ~= DE.HandOfGuldan then
		return DE.HandOfGuldan;
	end

	if buff[DE.DemonicCore].up then
		return DE.Demonbolt;
	end

	if cooldown[DE.HandOfGuldan].ready and soulShards >= 3 and currentSpell ~= DE.HandOfGuldan then
		return DE.HandOfGuldan;
	end

	return DE.Shadowbolt;
end
--/run currentCharges, maxCharges, cooldownStart, cooldownDuration, chargeModRate = GetSpellCharges("Implosion");print(currentCharges);
--/run name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo("player");print(spellId);
--/run name, rank, icon, castTime, minRange, maxRange, spellID = GetSpellInfo("Bilescourge Bombers");print(spellID);
--/run for i=1,40 do local name, icon, count, _, _, etime,_ ,_ ,_, spellID = UnitDebuff("target",i);if name then print(("%d=%s, %s, %.2f minutes left."):format(i,name,icon,(etime-GetTime())/60),spellID,count);end end
--/run for i=1,40 do local name, icon, count, _, _, etime,_ ,_ ,_, spellID = UnitBuff("player",i);if name then print(("%d=%s, %s, %.2f minutes left."):format(i,name,icon,(etime-GetTime())/60),spellID,count);end end