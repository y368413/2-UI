if select(2, UnitClass("player")) ~= "WARLOCK" then return end

local _, MaxDps_WarlockTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Warlock = MaxDps_WarlockTable.Warlock;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitAura = UnitAura;
local GetTime = GetTime;
local GetSpellInfo = GetSpellInfo;

local AF = {
	CorruptionDebuff   = 146739,
	DrainSoul          = 198590,
	SiphonLife         = 63106,
	PhantomSingularity = 205179,
	VileTaint          = 278350,
	Haunt              = 48181,
	Agony              = select(7, GetSpellInfo('Agony')),
	UnstableAffliction = select(7, GetSpellInfo('Unstable Affliction')),
	Corruption         = select(7, GetSpellInfo('Corruption')),
	MaleficRapture     = select(7, GetSpellInfo('Malefic Rapture')),
	ShadowBolt         = select(7, GetSpellInfo('Shadow Bolt')),
	SeedOfCorruption   = select(7, GetSpellInfo('Seed of Corruption')),
	SummonDarkglare    = select(7, GetSpellInfo('Summon Darkglare')),
}

setmetatable(AF, Warlock.spellMeta);

function Warlock:Affliction()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local timeToDie = fd.timeToDie;
	local targets = MaxDps:SmartAoe();
	local health = UnitHealth('player');
	local healthMax = UnitHealthMax('player');
	local healthPercent = (health / healthMax) * 100;
	local gcd = fd.gcd;
	local soulShards = UnitPower('player', Enum.PowerType.SoulShards);
	if currentSpell == AF.MaleficRapture then
		soulShards = soulShards - 1;
	elseif currentSpell == AF.SeedOfCorruption then
		soulShards = soulShards - 1;
	end

	MaxDps:GlowEssences();
	MaxDps:GlowCooldown(AF.SummonDarkglare, cooldown[AF.SummonDarkglare].ready);

	if debuff[AF.Agony].refreshable then
		return AF.Agony;
	end
	if debuff[AF.UnstableAffliction].refreshable and currentSpell ~= AF.UnstableAffliction then
		return AF.UnstableAffliction;
	end
	--if targets >= 3 and soulShards >= 1 then
	--	return AF.SeedOfCorruption;
	--end
	if debuff[AF.CorruptionDebuff].refreshable then
		return AF.Corruption;
	end

	if talents[AF.SiphonLife] and not debuff[AF.SiphonLife].up then
		return AF.SiphonLife;
	end

	if cooldown[AF.MaleficRapture].ready and soulShards >= 4 then
		return AF.MaleficRapture;
	end

	if talents[AF.Haunt] and cooldown[AF.Haunt].ready and debuff[AF.Haunt].refreshable and currentSpell ~= AF.Haunt then
		return AF.Haunt;
	end

	if talents[AF.PhantomSingularity]
		and cooldown[AF.PhantomSingularity].ready
		and debuff[AF.PhantomSingularity].refreshable
	then
		return AF.PhantomSingularity;
	end

	if talents[AF.VileTaint]
		and cooldown[AF.VileTaint].ready
		and debuff[AF.VileTaint].refreshable
		and currentSpell ~= AF.VileTaint
		and soulShards >= 1
	then
		return AF.VileTaint;
	end

	if cooldown[AF.MaleficRapture].ready and soulShards >= 1 then
		return AF.MaleficRapture;
	end

	if cooldown[AF.DrainSoul].ready and talents[AF.DrainSoul] then
		return AF.DrainSoul;
	end

	if not talents[AF.DrainSoul] then
		return AF.ShadowBolt;
	end
end