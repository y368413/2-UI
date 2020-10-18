if select(2, UnitClass("player")) ~= "MAGE" then return end

local _, MaxDps_MageTable = ...;
local Mage = MaxDps_MageTable.Mage;
local MaxDps = MaxDps;
local UnitExists = UnitExists;
local GetTime = GetTime;
local GetSpellCooldown = GetSpellCooldown;

local FT = {
	ArcaneIntellect      = 1459,
	SummonWaterElemental = 31687,
	LonelyWinter         = 205024,
	MirrorImage          = 55342,
	Frostbolt            = 116,
	Counterspell         = 2139,
	IceLance             = 30455,
	Flurry               = 44614,
	FingersOfFrost       = 44544,
	FreezingRain         = 270233,
	FrozenOrb            = 84714,
	Blizzard             = 190356,
	CometStorm           = 153595,
	IceNova              = 157997,
	Ebonbolt             = 257537,
	BrainFreeze          = 190446,
	Icicles              = 205473,
	GlacialSpike         = 199786,
	RayOfFrost           = 205021,
	ConeOfCold           = 120,
	IcyVeins             = 12472,
	RuneOfPower          = 116011,
	RuneOfPowerAura      = 116014,
	Blink                = 1953,
	IceFloes             = 108839,
	WintersChill         = 228358,
	SplittingIce         = 56377,
};

setmetatable(FT, Mage.spellMeta);

Mage.lastFrozenOrb = 0;
function Mage:UNIT_SPELLCAST_SUCCEEDED(event, unitID, spell, spellId)
	if unitID == 'player' and spellId == FT.FrozenOrb then
		Mage.lastFrozenOrb = GetTime();
	end
end

function Mage:FrozenOrbRemains()
	local remains = 16 - (GetTime() - Mage.lastFrozenOrb);

	if remains < 0 then
		return 0;
	else
		return remains;
	end
end

function Mage:Frost()
	local fd = MaxDps.FrameData;
	local buff = fd.buff;
	local spellHistory = fd.spellHistory;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local cooldown = fd.cooldown;
	local currentSpell  = fd.currentSpell;
	local canRop = talents[FT.RuneOfPower] and currentSpell ~= FT.RuneOfPower and
		Mage:CanRuneOfPower(FT.RuneOfPower, fd.timeShift) <= 0;

	local icicles = buff[FT.Icicles].count;
	if currentSpell == FT.Frostbolt then
		icicles = icicles + 1;
		if icicles > 5 then
			icicles = 5;
		end
	elseif currentSpell == FT.GlacialSpike then
		icicles = 0;
	end

	local FrozenOrb = MaxDps:FindSpell(198149) and 198149 or FT.FrozenOrb;

	fd.icicles = icicles;
	fd.FrozenOrb = FrozenOrb;
	fd.targets = targets;
	fd.canRop = canRop;

	MaxDps:GlowEssences();
	MaxDps:GlowCooldown(FT.MirrorImage, talents[FT.MirrorImage] and cooldown[FT.MirrorImage].ready);
	MaxDps:GlowCooldown(FT.IcyVeins, cooldown[FT.IcyVeins].ready);

	if not talents[FT.LonelyWinter] and not UnitExists('pet')
		and cooldown[FT.SummonWaterElemental].ready
		and currentSpell ~= FT.SummonWaterElemental
	then
		return FT.SummonWaterElemental;
	end

	-- ice_lance,if=prev_gcd.1.flurry&!buff.fingers_of_frost.react;
	if (spellHistory[1] == FT.Flurry or currentSpell == FT.Flurry) and not buff[FT.FingersOfFrost].up then
		return FT.IceLance;
	end

	-- call_action_list,name=cooldowns;
	local result = Mage:FrostCooldowns();
	if result then return result; end

	-- call_action_list,name=aoe,if=active_enemies>3&talent.freezing_rain.enabled|active_enemies>4;
	if targets > 3 and talents[FT.FreezingRain] or targets > 4 then
		result = Mage:FrostAoe();
		if result then return result; end
	end

	-- call_action_list,name=single;
	return Mage:FrostSingle();
end

function Mage:FrostAoe()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local icicles = fd.icicles;
	local talents = fd.talents;
	local FrozenOrb = fd.FrozenOrb;

	-- frozen_orb;
	if cooldown[FrozenOrb].ready then
		return FrozenOrb;
	end

	-- blizzard;
	if cooldown[FT.Blizzard].ready and currentSpell ~= FT.Blizzard then
		return FT.Blizzard;
	end

	-- comet_storm;
	if talents[FT.CometStorm] and cooldown[FT.CometStorm].ready then
		return FT.CometStorm;
	end

	-- ice_nova;
	if talents[FT.IceNova] and cooldown[FT.IceNova].ready then
		return FT.IceNova;
	end

	-- flurry,if=prev_gcd.1.ebonbolt|buff.brain_freeze.react&(prev_gcd.1.frostbolt&(buff.icicles.stack<4|!talent.glacial_spike.enabled)|prev_gcd.1.glacial_spike);
	if currentSpell ~= FT.Flurry and (
		currentSpell == FT.Ebonbolt or
		buff[FT.BrainFreeze].up and (
			currentSpell == FT.Frostbolt and (
				icicles < 4 or
				not talents[FT.GlacialSpike]
			) or currentSpell == FT.GlacialSpike
		)
	) then
		return FT.Flurry;
	end

	-- ice_lance,if=buff.fingers_of_frost.react;
	if buff[FT.FingersOfFrost].up then
		return FT.IceLance;
	end

	-- ray_of_frost;
	if talents[FT.RayOfFrost] and cooldown[FT.RayOfFrost].ready then
		return FT.RayOfFrost;
	end

	-- ebonbolt;
	if talents[FT.Ebonbolt] and cooldown[FT.Ebonbolt].ready and currentSpell ~= FT.Ebonbolt then
		return FT.Ebonbolt;
	end

	-- glacial_spike;
	if talents[FT.GlacialSpike] and currentSpell ~= FT.GlacialSpike and icicles >= 5 then
		return FT.GlacialSpike;
	end

	-- cone_of_cold;
	if cooldown[FT.ConeOfCold].ready then
		return FT.ConeOfCold;
	end

	-- frostbolt;
	if currentSpell ~= FT.Frostbolt then
		return FT.Frostbolt;
	end

	-- ice_lance;
	return FT.IceLance;
end

function Mage:FrostCooldowns()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local spellHistory = fd.spellHistory;
	local talents = fd.talents;
	local targets = fd.targets;
	local timeToDie = fd.timeToDie;
	local canRop = fd.canRop;
	local FrozenOrb = fd.FrozenOrb;

	-- rune_of_power,if=prev_gcd.1.frozen_orb|target.time_to_die>10+cast_time&target.time_to_die<20;
	if canRop and spellHistory[1] == FrozenOrb then
		return FT.RuneOfPower;
	end

	-- call_action_list,name=talent_rop,if=talent.rune_of_power.enabled&active_enemies=1&cooldown.rune_of_power.full_recharge_time<cooldown.frozen_orb.remains;
	if talents[FT.RuneOfPower] and targets <= 1 and
		cooldown[FT.RuneOfPower].fullRecharge < cooldown[FrozenOrb].remains
	then
		local result = Mage:FrostTalentRop();
		if result then return result; end
	end
end

function Mage:FrostSingle()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local icicles = fd.icicles;
	local talents = fd.talents;
	local targets = fd.targets;
	local FrozenOrb = fd.FrozenOrb;

	-- ice_nova,if=cooldown.ice_nova.ready&debuff.winters_chill.up;
	if talents[FT.IceNova] and cooldown[FT.IceNova].ready and cooldown[FT.IceNova].ready and debuff[FT.WintersChill].up then
		return FT.IceNova;
	end

	-- flurry,if=talent.ebonbolt.enabled&prev_gcd.1.ebonbolt&(!talent.glacial_spike.enabled|buff.icicles.stack<4|buff.brain_freeze.react);
	if currentSpell ~= FT.Flurry and (
		talents[FT.Ebonbolt] and currentSpell == FT.Ebonbolt and (
			not talents[FT.GlacialSpike] or
			icicles < 4 or
			buff[FT.BrainFreeze].up
		)
	) then
		return FT.Flurry;
	end

	-- flurry,if=talent.glacial_spike.enabled&prev_gcd.1.glacial_spike&buff.brain_freeze.react;
	if currentSpell ~= FT.Flurry and talents[FT.GlacialSpike] and currentSpell == FT.GlacialSpike and buff[FT.BrainFreeze].up then
		return FT.Flurry;
	end

	-- flurry,if=prev_gcd.1.frostbolt&buff.brain_freeze.react&(!talent.glacial_spike.enabled|buff.icicles.stack<4);
	if currentSpell ~= FT.Flurry and
		currentSpell == FT.Frostbolt and buff[FT.BrainFreeze].up and (
			not talents[FT.GlacialSpike] or icicles < 4
		)
	then
		return FT.Flurry;
	end

	-- frozen_orb;
	if cooldown[FrozenOrb].ready then
		return FrozenOrb;
	end

	-- blizzard,if=active_enemies>2|active_enemies>1&cast_time=0&buff.fingers_of_frost.react<2;
	if cooldown[FT.Blizzard].ready and currentSpell ~= FT.Blizzard and (
		targets > 2 or targets > 1 and buff[FT.FreezingRain].up and buff[FT.FingersOfFrost].count < 2
	) then
		return FT.Blizzard;
	end

	-- ice_lance,if=buff.fingers_of_frost.react;
	if buff[FT.FingersOfFrost].up then
		return FT.IceLance;
	end

	-- comet_storm;
	if talents[FT.CometStorm] and cooldown[FT.CometStorm].ready then
		return FT.CometStorm;
	end

	-- ebonbolt;
	if talents[FT.Ebonbolt] and cooldown[FT.Ebonbolt].ready and currentSpell ~= FT.Ebonbolt then
		return FT.Ebonbolt;
	end

	-- ray_of_frost,if=!action.frozen_orb.in_flight&ground_aoe.frozen_orb.remains=0;
	if talents[FT.RayOfFrost] and cooldown[FT.RayOfFrost].ready and Mage:FrozenOrbRemains() <= 0 then
		return FT.RayOfFrost;
	end

	-- blizzard,if=cast_time=0|active_enemies>1;
	if cooldown[FT.Blizzard].ready and currentSpell ~= FT.Blizzard and (buff[FT.FreezingRain].up or targets > 1) then
		return FT.Blizzard;
	end

	-- glacial_spike,if=buff.brain_freeze.react|prev_gcd.1.ebonbolt|active_enemies>1&talent.splitting_ice.enabled;
	if talents[FT.GlacialSpike] and currentSpell ~= FT.GlacialSpike and icicles >= 5 and (
		buff[FT.BrainFreeze].up or currentSpell == FT.Ebonbolt or targets > 1 and talents[FT.SplittingIce]
	) then
		return FT.GlacialSpike;
	end

	-- ice_nova;
	if talents[FT.IceNova] and cooldown[FT.IceNova].ready then
		return FT.IceNova;
	end

	-- frostbolt;
	return FT.Frostbolt;

	-- ice_lance;
	--return FT.IceLance;
end

function Mage:FrostTalentRop()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local icicles = fd.icicles;
	local timeShift = fd.timeShift;
	local canRop = fd.canRop;

	-- rune_of_power,if=talent.glacial_spike.enabled&buff.icicles.stack=5&(buff.brain_freeze.react|talent.ebonbolt.enabled&cooldown.ebonbolt.remains<cast_time);
	if canRop and (
		talents[FT.GlacialSpike] and icicles >= 5 and (
			buff[FT.BrainFreeze].up or talents[FT.Ebonbolt] and cooldown[FT.Ebonbolt].remains < 1.5
		)
	) then
		return FT.RuneOfPower;
	end

	-- rune_of_power,if=!talent.glacial_spike.enabled&(talent.ebonbolt.enabled&cooldown.ebonbolt.remains<cast_time|talent.comet_storm.enabled&cooldown.comet_storm.remains<cast_time|talent.ray_of_frost.enabled&cooldown.ray_of_frost.remains<cast_time|charges_fractional>1.9);
	if canRop and (
		not talents[FT.GlacialSpike] and (
			talents[FT.Ebonbolt] and cooldown[FT.Ebonbolt].remains < 1.5 or
			talents[FT.CometStorm] and cooldown[FT.CometStorm].remains < 1.5 or
			talents[FT.RayOfFrost] and cooldown[FT.RayOfFrost].remains < 1.5 or
			cooldown[FT.RuneOfPower].charges > 1.9
		)
	) then
		return FT.RuneOfPower;
	end
end

function Mage:CanRuneOfPower(spellId, timeShift)
	local start, duration, enabled = GetSpellCooldown(spellId);
	local t = GetTime();
	local remains;

	if enabled and duration == 0 and start == 0 then
		remains = 0;
	elseif enabled then
		remains = duration - (t - start) - timeShift;
	end

	return remains
end