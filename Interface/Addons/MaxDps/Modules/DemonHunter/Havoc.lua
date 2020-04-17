if select(2, UnitClass("player")) ~= "DEMONHUNTER" then return end
local _, MaxDps_DemonHunterTable = ...;

--- @type MaxDps
if not MaxDps then return end

local DemonHunter = MaxDps_DemonHunterTable.DemonHunter;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;

--[[
local HV = {
	DemonsBite        = 162243,
	DemonBlades       = 203555,
	ChaosStrike       = 162794,
	VengefulRetreat   = 198793,
	Momentum          = 208628,
	MomentumTalent    = 206476,
	FelRush           = 195072,
	FelBarrage        = 258925,
	DarkSlash         = 258860,
	EyeBeam           = 198013,
	Nemesis           = 206491,
	Metamorphosis     = 191427,
	MetamorphosisAura = 162264,
	BladeDance        = 188499,
	DeathSweep        = 210152,
	ImmolationAura    = 258920,
	Felblade          = 232893,
	Annihilation      = 201427,
	ThrowGlaive       = 185123,
	FirstBlood        = 206416,
	Demonic           = 213410,
	BlindFury         = 203550,
	FelMastery        = 192939,
	TrailOfRuin       = 258881,
	RevolvingBlades   = 279581,
};
]]--

local HV = {
	Metamorphosis   = 191427,
	FirstBlood      = 206416,
	TrailOfRuin     = 258881,
	Nemesis         = 206491,
	Demonic         = 213410,
	BlindFury       = 203550,
	EyeBeam         = 198013,
	DarkSlash       = 258860,
	Momentum        = 206476,
	MomentumTalent  = 206476,
	Disrupt         = 183752,
	BladeDance      = 188499,
	Annihilation    = 201427,
	ChaosStrike     = 162794,
	DeathSweep      = 210152,
	FelBarrage      = 258925,
	ImmolationAura  = 258920,
	Felblade        = 232893,
	FelRush         = 195072,
	DemonBlades     = 203555,
	DemonsBite      = 162243,
	ThrowGlaive     = 185123,
	VengefulRetreat = 198793,
	FelMastery      = 192939,
	Prepared	= 203650,
};

local A = {
	ChaoticTransformation = 288754,
	RevolvingBlades       = 279581,
};

setmetatable(HV, DemonHunter.spellMeta);
setmetatable(A, DemonHunter.spellMeta);

function DemonHunter:Havoc()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local gcd = fd.gcd;

	local fury = UnitPower('player', Enum.PowerType.Fury);
	local furyMax = UnitPowerMax('player', Enum.PowerType.Fury);
	local furyDeficit = furyMax - fury;
	fd.fury = fury;
	fd.furyMax = furyMax;
	fd.furyDeficit = furyDeficit;

	local ChaosStrike = MaxDps:FindSpell(HV.Annihilation) and HV.Annihilation or HV.ChaosStrike;
	local BladeDance = MaxDps:FindSpell(HV.DeathSweep) and HV.DeathSweep or HV.BladeDance;
	local bladeDanceCost = 35 - (talents[HV.FirstBlood] and 20 or 0);

	fd.ChaosStrike = ChaosStrike;
	fd.BladeDance = BladeDance;
	fd.bladeDanceCost = bladeDanceCost;
	fd.targets = targets;

	-- variable,name=blade_dance,value=talent.first_blood.enabled|spell_targets.blade_dance1>=(3-talent.trail_of_ruin.enabled);
	local bladeDance = talents[HV.FirstBlood] or targets >= (3 - (talents[HV.TrailOfRuin] and 1 or 0));

	-- variable,name=waiting_for_nemesis,value=!(!talent.nemesis.enabled|cooldown.nemesis.ready|cooldown.nemesis.remains>target.time_to_die|cooldown.nemesis.remains>60);
	--local waitingForNemesis = not (
	--	not talents[HV.Nemesis] or
	--	cooldown[HV.Nemesis].ready or
	--	cooldown[HV.Nemesis].remains > timeToDie or
	--	cooldown[HV.Nemesis].remains > 60
	--);

	-- variable,name=pooling_for_blade_dance,value=variable.blade_dance&(fury<75-talent.first_blood.enabled*20);
	local poolingForBladeDance = bladeDance and (fury < 75 - (talents[HV.FirstBlood] and 20 or 0));

	-- variable,name=pooling_for_eye_beam,value=talent.demonic.enabled&!talent.blind_fury.enabled&cooldown.eye_beam.remains<(gcd.max*2)&fury.deficit>20;
	local poolingForEyeBeam = talents[HV.Demonic] and not talents[HV.BlindFury] and cooldown[HV.EyeBeam].remains < (gcd * 2) and furyDeficit > 20;

	-- variable,name=waiting_for_dark_slash,value=talent.dark_slash.enabled&!variable.pooling_for_blade_dance&!variable.pooling_for_meta&cooldown.dark_slash.up;
	local waitingForDarkSlash = talents[HV.DarkSlash] and not poolingForBladeDance and cooldown[HV.DarkSlash].ready;

	fd.bladeDance = bladeDance;
	fd.poolingForBladeDance = poolingForBladeDance;
	fd.poolingForEyeBeam = poolingForEyeBeam;
	fd.waitingForDarkSlash = waitingForDarkSlash;

	-- call_action_list,name=cooldown,if=gcd.remains=0;
	DemonHunter:HavocCooldown();

	-- call_action_list,name=dark_slash,if=talent.dark_slash.enabled&(variable.waiting_for_dark_slash|debuff.dark_slash.up);
	if talents[HV.DarkSlash] and (waitingForDarkSlash or debuff[HV.DarkSlash].up) then
		local result = DemonHunter:HavocDarkSlash();
		if result then return result; end
	end

	-- run_action_list,name=demonic,if=talent.demonic.enabled;
	if talents[HV.Demonic] then
		return DemonHunter:HavocDemonic();
	end

	-- run_action_list,name=normal;
	return DemonHunter:HavocNormal();
end

function DemonHunter:HavocCooldown()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local debuff = fd.debuff;
	local buff = fd.buff;
	local talents = fd.talents;
	local targets = fd.targets;
	local gcd = fd.gcd;
	local timeToDie = fd.timeToDie;

	MaxDps:GlowEssences();
	if talents[HV.MomentumTalent] then
		MaxDps:GlowCooldown(HV.FelRush, not buff[HV.Momentum].up and cooldown[HV.FelRush].ready);
		MaxDps:GlowCooldown(HV.VengefulRetreat, not buff[HV.Momentum].up and cooldown[HV.VengefulRetreat].ready);
	end

	if talents[HV.Nemesis] then
		MaxDps:GlowCooldown(HV.Nemesis, cooldown[HV.Nemesis].ready);
	end

	MaxDps:GlowCooldown(HV.Metamorphosis, cooldown[HV.Metamorphosis].ready);

	-- metamorphosis,if=!(talent.demonic.enabled|variable.pooling_for_meta|variable.waiting_for_nemesis)|target.time_to_die<25;
	--if cooldown[HV.Metamorphosis].ready and (not (talents[HV.Demonic] or poolingForMeta or waitingForNemesis) or timeToDie < 25) then
	--	return HV.Metamorphosis;
	--end
	--
	---- metamorphosis,if=talent.demonic.enabled&(!azerite.chaotic_transformation.enabled|(cooldown.eye_beam.remains>20&cooldown.blade_dance.remains>gcd.max));
	--if cooldown[HV.Metamorphosis].ready and (talents[HV.Demonic] and (not azerite[A.ChaoticTransformation] > 0 or (cooldown[HV.EyeBeam].remains > 20 and cooldown[HV.BladeDance].remains > gcd))) then
	--	return HV.Metamorphosis;
	--end
	--
	---- nemesis,target_if=min:target.time_to_die,if=raid_event.adds.exists&debuff.nemesis.down&(active_enemies>desired_targets|raid_event.adds.in>60);
	--if talents[HV.Nemesis] and cooldown[HV.Nemesis].ready and (not debuff[HV.Nemesis].up and (targets > desiredTargets or 60)) then
	--	return HV.Nemesis;
	--end
	--
	---- nemesis,if=!raid_event.adds.exists;
	--if talents[HV.Nemesis] and cooldown[HV.Nemesis].ready and (not) then
	--	return HV.Nemesis;
	--end
end

function DemonHunter:HavocDarkSlash()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local fury = fd.fury;
	local bladeDance = fd.bladeDance;
	local ChaosStrike = fd.ChaosStrike;

	-- dark_slash,if=fury>=80&(!variable.blade_dance|!cooldown.blade_dance.ready);
	if talents[HV.DarkSlash] and cooldown[HV.DarkSlash].ready and
		fury >= 80 and (not bladeDance or not cooldown[HV.BladeDance].ready)
	then
		return HV.DarkSlash;
	end

	-- annihilation,if=debuff.dark_slash.up;
	-- chaos_strike,if=debuff.dark_slash.up;
	if fury >= 40 and debuff[HV.DarkSlash].up then
		return ChaosStrike;
	end
end

function DemonHunter:HavocDemonic()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local talents = fd.talents;
	local targets = fd.targets;
	local fury = fd.fury;
	local furyDeficit = fd.furyDeficit;
	local bladeDance = fd.bladeDance;
	local poolingForBladeDance = fd.poolingForBladeDance;
	local poolingForEyeBeam = fd.poolingForEyeBeam;

	local ChaosStrike = fd.ChaosStrike;
	local BladeDance = fd.BladeDance;
	local bladeDanceCost = fd.bladeDanceCost;
	local desiredTargets = 3; -- dunno bout dat

	-- death_sweep,if=variable.blade_dance;
	if cooldown[HV.DeathSweep].ready and fury >= bladeDanceCost and bladeDance and buff[HV.Metamorphosis].up then
		return BladeDance;
	end

	-- eye_beam,if=raid_event.adds.up|raid_event.adds.in>25;
	if cooldown[HV.EyeBeam].ready and fury >= 30 then
		return HV.EyeBeam;
	end

	-- fel_barrage,if=((!cooldown.eye_beam.up|buff.metamorphosis.up)&raid_event.adds.in>30)|active_enemies>desired_targets;
	if talents[HV.FelBarrage] and cooldown[HV.FelBarrage].ready and (
		((not cooldown[HV.EyeBeam].ready or buff[HV.Metamorphosis].up) and 30) or targets > desiredTargets
	) then
		return HV.FelBarrage;
	end

	-- blade_dance,if=variable.blade_dance&!cooldown.metamorphosis.ready&(cooldown.eye_beam.remains>(5-azerite.revolving_blades.rank*3)|(raid_event.adds.in>cooldown&raid_event.adds.in<25));
	if cooldown[HV.BladeDance].ready and fury >= bladeDanceCost and
		bladeDance and
		(cooldown[HV.EyeBeam].remains > (5 - azerite[A.RevolvingBlades] * 3))
		and not buff[HV.Metamorphosis].up
	then
		return BladeDance;
	end

	-- immolation_aura;
	if talents[HV.ImmolationAura] and cooldown[HV.ImmolationAura].ready then
		return HV.ImmolationAura;
	end

	-- annihilation,if=!variable.pooling_for_blade_dance;
	if fury >= 40 and not poolingForBladeDance and buff[HV.Metamorphosis].up then
		return ChaosStrike;
	end

	-- felblade,if=fury.deficit>=40;
	if talents[HV.Felblade] and cooldown[HV.Felblade].ready and furyDeficit >= 40 then
		return HV.Felblade;
	end

	-- chaos_strike,if=!variable.pooling_for_blade_dance&!variable.pooling_for_eye_beam;
	if fury >= 40 and not poolingForBladeDance and not poolingForEyeBeam and not buff[HV.Metamorphosis].up then
		return ChaosStrike;
	end

	-- fel_rush,if=talent.demon_blades.enabled&!cooldown.eye_beam.ready&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10));
	if cooldown[HV.FelRush].ready and (
		talents[HV.DemonBlades] and not cooldown[HV.EyeBeam].ready and cooldown[HV.FelRush].charges >= 2
	) then
		return HV.FelRush;
	end

	-- demons_bite;
	if talents[HV.DemonBlades] then
		if cooldown[HV.ThrowGlaive].ready then
			return HV.ThrowGlaive;
		else
			return nil;
		end
	end

	return HV.DemonsBite;
end

function DemonHunter:HavocNormal()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local targets = fd.targets;
	local fury = fd.fury;
	local furyDeficit = fd.furyDeficit;
	local bladeDance = fd.bladeDance;
	local bladeDanceCost = fd.bladeDanceCost;
	local waitingForDarkSlash = fd.waitingForDarkSlash;
	local poolingForBladeDance = fd.poolingForBladeDance;

	-- variable,name=pooling_for_meta,value=!talent.demonic.enabled&cooldown.metamorphosis.remains<6&fury.deficit>30&(!variable.waiting_for_nemesis|cooldown.nemesis.remains<10);
	local poolingForMeta = not talents[HV.Demonic] and cooldown[HV.Metamorphosis].remains < 6 and furyDeficit > 30;

	local desiredTargets = 3;
	local ChaosStrike = fd.ChaosStrike;
	local BladeDance = fd.BladeDance;

	-- variable,name=waiting_for_momentum,value=talent.momentum.enabled&!buff.momentum.up;
	local waitingForMomentum = talents[HV.MomentumTalent] and not buff[HV.Momentum].up;

	-- vengeful_retreat,if=talent.momentum.enabled&buff.prepared.down&time>1;
	if cooldown[HV.VengefulRetreat].ready and (talents[HV.MomentumTalent] and not buff[HV.Prepared].up) then
		return HV.VengefulRetreat;
	end

	-- fel_rush,if=(variable.waiting_for_momentum|talent.fel_mastery.enabled)&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10));
	if cooldown[HV.FelRush].ready and
		(waitingForMomentum or talents[HV.FelMastery]) and cooldown[HV.FelRush].charges >= 2
	then
		return HV.FelRush;
	end

	-- fel_barrage,if=!variable.waiting_for_momentum&(active_enemies>desired_targets|raid_event.adds.in>30);
	if talents[HV.FelBarrage] and cooldown[HV.FelBarrage].ready and
		not waitingForMomentum and targets > desiredTargets
	then
		return HV.FelBarrage;
	end

	-- death_sweep,if=variable.blade_dance;
	if cooldown[HV.DeathSweep].ready and fury >= bladeDanceCost and bladeDance and buff[HV.Metamorphosis].up then
		return BladeDance; --DeathSweep
	end

	-- immolation_aura;
	if talents[HV.ImmolationAura] and cooldown[HV.ImmolationAura].ready then
		return HV.ImmolationAura;
	end

	-- eye_beam,if=active_enemies>1&(!raid_event.adds.exists|raid_event.adds.up)&!variable.waiting_for_momentum;
	if cooldown[HV.EyeBeam].ready and fury >= 30 and (targets > 1 and not waitingForMomentum) then
		return HV.EyeBeam;
	end

	-- blade_dance,if=variable.blade_dance;
	if cooldown[HV.BladeDance].ready and fury >= bladeDanceCost and bladeDance and not buff[HV.Metamorphosis].up then
		return BladeDance;
	end

	-- felblade,if=fury.deficit>=40;
	if talents[HV.Felblade] and cooldown[HV.Felblade].ready and furyDeficit >= 40 then
		return HV.Felblade;
	end

	-- eye_beam,if=!talent.blind_fury.enabled&!variable.waiting_for_dark_slash&raid_event.adds.in>cooldown;
	if cooldown[HV.EyeBeam].ready and fury >= 30 and (
		not talents[HV.BlindFury] and not waitingForDarkSlash) then
		return HV.EyeBeam;
	end

	-- annihilation,if=(talent.demon_blades.enabled|!variable.waiting_for_momentum|fury.deficit<30|buff.metamorphosis.remains<5)&!variable.pooling_for_blade_dance&!variable.waiting_for_dark_slash;
	if fury >= 40 and
		(talents[HV.DemonBlades] or not waitingForMomentum or furyDeficit < 30 or buff[HV.Metamorphosis].remains < 5) and
		not poolingForBladeDance and
		not waitingForDarkSlash and
		buff[HV.Metamorphosis].up
	then
		return ChaosStrike; --annihilation
	end

	-- chaos_strike,if=(talent.demon_blades.enabled|!variable.waiting_for_momentum|fury.deficit<30)&!variable.pooling_for_meta&!variable.pooling_for_blade_dance&!variable.waiting_for_dark_slash;
	if fury >= 40 and
		(talents[HV.DemonBlades] or not waitingForMomentum or furyDeficit < 30) and
		not poolingForMeta and
		not poolingForBladeDance and
		not waitingForDarkSlash and
		not buff[HV.Metamorphosis].up
	then
		return ChaosStrike;
	end

	-- eye_beam,if=talent.blind_fury.enabled&raid_event.adds.in>cooldown;
	if cooldown[HV.EyeBeam].ready and fury >= 30 and talents[HV.BlindFury] then
		return HV.EyeBeam;
	end

	-- fel_rush,if=!talent.momentum.enabled&raid_event.movement.in>charges*10&talent.demon_blades.enabled;
	if cooldown[HV.FelRush].ready and
		not talents[HV.MomentumTalent] and talents[HV.DemonBlades]
	then
		return HV.FelRush;
	end

	-- felblade,if=movement.distance>15|buff.out_of_range.up;
	if talents[HV.Felblade] and cooldown[HV.Felblade].ready then
		return HV.Felblade;
	end

	-- throw_glaive,if=talent.demon_blades.enabled;
	if talents[HV.DemonBlades] then
		return HV.ThrowGlaive;
	end

	-- demons_bite;
	if talents[HV.DemonBlades] then
		if cooldown[HV.ThrowGlaive].ready then
			return HV.ThrowGlaive;
		else
			return nil;
		end
	end

	return HV.DemonsBite;
end


--[[
function DemonHunter:Havoc()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, talents, azerite, currentSpell = fd.cooldown, fd.buff, fd.debuff, fd.talents, fd.azerite, fd.currentSpell;

	local fury = UnitPower('player', Enum.PowerType.Fury);
	local furyMax = UnitPowerMax('player', Enum.PowerType.Fury);
	local furyDeficit = furyMax - fury;

	local chaosStrike = MaxDps:FindSpell(HV.Annihilation) and HV.Annihilation or HV.ChaosStrike;
	local bladeDance = MaxDps:FindSpell(HV.DeathSweep) and HV.DeathSweep or HV.BladeDance;

	-- Auras
	local canEyeBeam = cooldown[HV.EyeBeam].ready and fury >= 30;

	if talents[HV.Demonic] then
		-- it was extended at some point
		if self.prevMetamorphosisRemains and buff[HV.Metamorphosis].remains > self.prevMetamorphosisRemains then
			self.buffMetamorphosisExtended = true;
		end

		-- once it goes down, flag down
		if not buff[HV.Metamorphosis].up then
			self.buffMetamorphosisExtended = false;
			self.prevMetamorphosisRemains = nil;
		else
			self.prevMetamorphosisRemains = buff[HV.Metamorphosis].remains;
		end
	end

	-- Cooldowns
	if talents[HV.MomentumTalent] then
		MaxDps:GlowCooldown(HV.FelRush, not buff[HV.Momentum].up and cooldown[HV.FelRush].ready);
		MaxDps:GlowCooldown(HV.VengefulRetreat, not buff[HV.Momentum].up and cooldown[HV.VengefulRetreat].ready);
	end

	local nemesis, nemesisCd;
	if talents[HV.Nemesis] then
		MaxDps:GlowCooldown(HV.Nemesis, cooldown[HV.Nemesis].ready);
	end

	MaxDps:GlowCooldown(HV.Metamorphosis, cooldown[HV.Metamorphosis].ready);

	local targets = MaxDps:TargetsInRange(HV.ChaosStrike);

	local varBladeDance = talents[HV.FirstBlood] or targets >= (3 - (talents[HV.TrailOfRuin] and 1 or 0));
	local varWaitingForNemesis = not (not talents[HV.Nemesis] or cooldown[HV.Nemesis].ready or cooldown[HV.Nemesis].remains > 60);
	local varPoolingForMeta = not talents[HV.Demonic] and cooldown[HV.Metamorphosis].remains < 6 and
		furyDeficit > 30 and (not varWaitingForNemesis or cooldown[HV.Nemesis].remains < 10);
	local varPoolingForBladeDance = varBladeDance and (fury < 75 - (talents[HV.FirstBlood] and 1 or 0) * 20);
	local varWaitingForDarkSlash = talents[HV.DarkSlash] and not varPoolingForBladeDance and
		not varPoolingForMeta and cooldown[HV.DarkSlash].ready;
	local varWaitingForMomentum = talents[HV.MomentumTalent] and not buff[HV.Momentum].up;


	-- Dark slash rotation
	if talents[HV.DarkSlash] and (varWaitingForDarkSlash or debuff[HV.DarkSlash].up) then
		if cooldown[HV.DarkSlash].ready and fury >= 80 and (not varBladeDance or not cooldown[HV.BladeDance].ready) then
			return HV.DarkSlash;
		end

		if fury >= 40 and debuff[HV.DarkSlash].up then
			return chaosStrike;
		end
	end

	local canFelBarrage = talents[HV.FelBarrage] and cooldown[HV.FelBarrage].ready;
	local canFelBlade = talents[HV.Felblade] and cooldown[HV.Felblade].ready;
	local canBladeDance = cooldown[HV.BladeDance].ready and
		fury >= (35 - (talents[HV.FirstBlood] and 20 or 0));

	if talents[HV.Demonic] then
		if canFelBarrage then
			return HV.FelBarrage;
		end

		if canBladeDance and buff[HV.Metamorphosis].up and varBladeDance then
			return bladeDance;
		end

		if canEyeBeam and not self.buffMetamorphosisExtended and
			(buff[HV.Metamorphosis].remains > 4 or not buff[HV.Metamorphosis].up)
		then
			return HV.EyeBeam;
		end

		if canBladeDance and varBladeDance and not cooldown[HV.Metamorphosis].ready and
			(cooldown[HV.EyeBeam].remains > (5 - azerite[HV.RevolvingBlades] * 3)) then
			return bladeDance;
		end

		if talents[HV.ImmolationAura] and cooldown[HV.ImmolationAura].ready then
			return HV.ImmolationAura;
		end

		if canFelBlade and (fury < 40 or (not buff[HV.Metamorphosis].up and furyDeficit >= 40)) then
			return HV.Felblade;
		end

		if fury >= 40 and (talents[HV.BlindFury] or furyDeficit < 30 or buff[HV.Metamorphosis].remains < 5) and
			buff[HV.Metamorphosis].up and
			not varPoolingForBladeDance
		then
			return chaosStrike;
		end

		if fury >= 40 and (talents[HV.BlindFury] or furyDeficit < 30) and
			not buff[HV.Metamorphosis].up and
			not varPoolingForMeta and
			not varPoolingForBladeDance
		then
			return chaosStrike;
		end
	else
		if canFelBarrage and not varWaitingForMomentum and (targets > 1) then
			return HV.FelBarrage;
		end

		if canBladeDance and buff[HV.Metamorphosis].up and varBladeDance then
			return bladeDance;
		end

		if talents[HV.ImmolationAura] and cooldown[HV.ImmolationAura].ready then
			return HV.ImmolationAura;
		end

		if canEyeBeam and targets > 1 and not varWaitingForMomentum then
			return HV.EyeBeam;
		end

		if canBladeDance and not buff[HV.Metamorphosis].up and varBladeDance then
			return bladeDance;
		end

		if canFelBlade and furyDeficit >= 40 then
			return HV.Felblade;
		end

		if canEyeBeam and not talents[HV.BlindFury] and not varWaitingForDarkSlash then
			return HV.EyeBeam;
		end

		if (talents[HV.DemonBlades] or not varWaitingForMomentum or furyDeficit < 30 or buff[HV.Metamorphosis].remains < 5) and
			buff[HV.Metamorphosis].up and
			not varPoolingForBladeDance and
			not varWaitingForDarkSlash
		then
			return chaosStrike;
		end

		if fury >= 40 and (talents[HV.DemonBlades] or not varWaitingForMomentum or furyDeficit < 30) and
			not buff[HV.Metamorphosis].up and
			not varPoolingForMeta and
			not varPoolingForBladeDance and
			not varWaitingForDarkSlash
		then
			return chaosStrike;
		end

		if canEyeBeam and talents[HV.BlindFury] then
			return HV.EyeBeam;
		end
	end

	if talents[HV.DemonBlades] then
		if cooldown[HV.ThrowGlaive].ready then
			return HV.ThrowGlaive;
		else
			return nil;
		end
	end

	return HV.DemonsBite;
end
]]--