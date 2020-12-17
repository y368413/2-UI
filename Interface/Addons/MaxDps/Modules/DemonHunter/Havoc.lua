if select(2, UnitClass("player")) ~= "DEMONHUNTER" then return end
local _, MaxDps_DemonHunterTable = ...;

--- @type MaxDps
if not MaxDps then return end

local DemonHunter = MaxDps_DemonHunterTable.DemonHunter;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;

local Necrolord = Enum.CovenantType.Necrolord;
local Venthyr = Enum.CovenantType.Venthyr;
local NightFae = Enum.CovenantType.NightFae;
local Kyrian = Enum.CovenantType.Kyrian;

local HV = {
	FirstBlood       = 206416,
	TrailOfRuin      = 258881,
	Metamorphosis    = 191427,
	Demonic          = 213410,
	BlindFury        = 203550,
	EyeBeam          = 198013,
	EssenceBreak     = 258860,
	Momentum         = 206476,
	MomentumAura     = 208628,
	Disrupt          = 183752,
	ThrowGlaive      = 185123,
	ImmolationAura   = 258920,
	SinfulBrand      = 317009,
	BladeDance       = 188499,
	TheHunt          = 323639,
	FodderToTheFlame = 329554,
	ElysianDecree    = 306830,
	FelRush          = 195072,
	UnboundChaos     = 347461,
	DeathSweep       = 210152,
	GlaiveTempest    = 342817,
	SerratedGlaive   = 339230,
	ExposedWound     = 339229,
	Annihilation     = 201427,
	Felblade         = 232893,
	ChaosStrike      = 162794,
	DemonBlades      = 203555,
	DemonsBite       = 162243,
	VengefulRetreat  = 198793,
	Prepared         = 203650,
	FelBarrage       = 258925,
	FuriousGaze      = 343312,

	-- Leggo buffs
	FelBombardment   = 337849,
	BurningWound     = 346279,

	-- Leggo ids
	ChaosTheoryBonusId  = 7050,
	BurningWoundBonusId = 7052
};

setmetatable(HV, DemonHunter.spellMeta);

local function m(x) return x and 1 or 0 end

function DemonHunter:Havoc()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local gcd = fd.gcd;
	local runeforge = fd.runeforge;
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

	-- variable,name=blade_dance,value=talent.first_blood.enabled|spell_targets.blade_dance1>=(3-(talent.trail_of_ruin.enabled+buff.metamorphosis.up))|runeforge.chaos_theory&buff.chaos_theory.down;
	local bladeDance = talents[HV.FirstBlood] or
		targets >= (3 - (m(talents[HV.TrailOfRuin]) + m(buff[HV.Metamorphosis].up))) or
		runeforge[HV.ChaosTheoryBonusId] and not buff[HV.ChaosTheory].up
	;

	-- variable,name=pooling_for_meta,value=!talent.demonic.enabled&cooldown.metamorphosis.remains<6&fury.deficit>30;
	local poolingForMeta = not talents[HV.Demonic] and cooldown[HV.Metamorphosis].remains < 6 and furyDeficit > 30;

	-- variable,name=pooling_for_blade_dance,value=variable.blade_dance&(fury<75-talent.first_blood.enabled*20);
	local poolingForBladeDance = bladeDance and (fury < 75 - m(talents[HV.FirstBlood]) * 20);

	-- variable,name=pooling_for_eye_beam,value=talent.demonic.enabled&!talent.blind_fury.enabled&cooldown.eye_beam.remains<(gcd.max*2)&fury.deficit>20;
	local poolingForEyeBeam = talents[HV.Demonic] and not talents[HV.BlindFury] and cooldown[HV.EyeBeam].remains < (gcd * 2) and furyDeficit > 20;

	-- variable,name=waiting_for_essence_break,value=talent.essence_break.enabled&!variable.pooling_for_blade_dance&!variable.pooling_for_meta&cooldown.essence_break.up;
	local waitingForEssenceBreak = talents[HV.EssenceBreak] and not poolingForBladeDance and not poolingForMeta and cooldown[HV.EssenceBreak].up;

	-- variable,name=waiting_for_momentum,value=talent.momentum.enabled&!buff.momentum.up;
	local waitingForMomentum = talents[HV.Momentum] and not buff[HV.MomentumAura].up;

	fd.bladeDance = bladeDance;
	fd.poolingForBladeDance = poolingForBladeDance;
	fd.poolingForEyeBeam = poolingForEyeBeam;
	fd.poolingForMeta = poolingForMeta;
	fd.waitingForMomentum = waitingForMomentum;
	fd.waitingForEssenceBreak = waitingForEssenceBreak;

	-- call_action_list,name=cooldown,if=gcd.remains=0;
	local result = DemonHunter:HavocCooldown();
	if result then
		return result;
	end

	-- throw_glaive,if=buff.fel_bombardment.stack=5&(buff.immolation_aura.up|!buff.metamorphosis.up);
	if buff[HV.FelBombardment].count >= 5 and (buff[HV.ImmolationAura].up or not buff[HV.Metamorphosis].up) then
		return HV.ThrowGlaive;
	end

	-- call_action_list,name=essence_break,if=talent.essence_break.enabled&(variable.waiting_for_essence_break|debuff.essence_break.up);
	if talents[HV.EssenceBreak] and (waitingForEssenceBreak or debuff[HV.EssenceBreak].up) then
		result = DemonHunter:HavocEssenceBreak();
		if result then
			return result;
		end
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
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local targets = fd.targets;
	local gcd = fd.gcd;
	local poolingForMeta = fd.poolingForMeta;
	local waitingForMomentum = fd.waitingForMomentum;
	local covenantId = fd.covenant.covenantId;

	MaxDps:GlowCooldown(HV.Metamorphosis, cooldown[HV.Metamorphosis].ready);

	if talents[HV.Momentum] then
		MaxDps:GlowCooldown(HV.FelRush, not buff[HV.MomentumAura].up and cooldown[HV.FelRush].ready);
		--MaxDps:GlowCooldown(HV.VengefulRetreat, not buff[HV.MomentumAura].up and cooldown[HV.VengefulRetreat].ready);
	end

	-- metamorphosis,if=!(talent.demonic.enabled|variable.pooling_for_meta)&cooldown.eye_beam.remains>20&(!covenant.venthyr.enabled|!dot.sinful_brand.ticking)|fight_remains<25;
	--if cooldown[HV.Metamorphosis].ready and (not (talents[HV.Demonic] or poolingForMeta) and cooldown[HV.EyeBeam].remains > 20 and (not covenantId == Enum.CovenantType.Venthyr or not debuff[HV.SinfulBrand].up) or fightRemains < 25) then
	--	return HV.Metamorphosis;
	--end

	-- metamorphosis,if=talent.demonic.enabled&(cooldown.eye_beam.remains>20&(!variable.blade_dance|cooldown.blade_dance.remains>gcd.max))&(!covenant.venthyr.enabled|!dot.sinful_brand.ticking);
	--if cooldown[HV.Metamorphosis].ready and (talents[HV.Demonic] and (cooldown[HV.EyeBeam].remains > 20 and (not bladeDance or cooldown[HV.BladeDance].remains > gcd)) and (not covenantId == Enum.CovenantType.Venthyr or not debuff[HV.SinfulBrand].up)) then
	--	return HV.Metamorphosis;
	--end

	-- sinful_brand,if=!dot.sinful_brand.ticking;
	if covenantId == Venthyr and cooldown[HV.SinfulBrand].ready and (not debuff[HV.SinfulBrand].up) then
		return HV.SinfulBrand;
	end

	-- the_hunt,if=!talent.demonic.enabled&!variable.waiting_for_momentum|buff.furious_gaze.up;
	if covenantId == NightFae and
		cooldown[HV.TheHunt].ready and
		currentSpell ~= HV.TheHunt and
		(not talents[HV.Demonic] and not waitingForMomentum or buff[HV.FuriousGaze].up)
	then
		return HV.TheHunt;
	end

	-- fodder_to_the_flame;
	if covenantId == Necrolord and cooldown[HV.FodderToTheFlame].ready then
		return HV.FodderToTheFlame;
	end

	-- elysian_decree,if=(active_enemies>desired_targets|raid_event.adds.in>30);
	if covenantId == Kyrian and cooldown[HV.ElysianDecree].ready then
		return HV.ElysianDecree;
	end
end

function DemonHunter:HavocDemonic()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local fury = fd.fury;
	local runeforge = fd.runeforge;
	local conduit = fd.covenant.soulbindConduits;
	local furyDeficit = fd.furyDeficit;
	local bladeDance = fd.bladeDance;
	local poolingForBladeDance = fd.poolingForBladeDance;
	local poolingForEyeBeam = fd.poolingForEyeBeam;

	local ChaosStrike = fd.ChaosStrike;
	local BladeDance = fd.BladeDance;
	local bladeDanceCost = fd.bladeDanceCost;
	local desiredTargets = 3;

	-- fel_rush,if=(talent.unbound_chaos.enabled&buff.unbound_chaos.up)&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10));
	--if cooldown[HV.FelRush].ready and
	--	talents[HV.UnboundChaos] and
	--	buff[HV.UnboundChaos].up and
	--	cooldown[HV.FelRush].charges >= 2
	--then
	--	return HV.FelRush;
	--end

	-- death_sweep,if=variable.blade_dance;
	if cooldown[HV.DeathSweep].ready and fury >= bladeDanceCost and bladeDance and buff[HV.Metamorphosis].up then
		return BladeDance;
	end

	-- glaive_tempest,if=active_enemies>desired_targets|raid_event.adds.in>10;
	if talents[HV.GlaiveTempest] and cooldown[HV.GlaiveTempest].ready and fury >= 30 then
		return HV.GlaiveTempest;
	end

	-- throw_glaive,if=conduit.serrated_glaive.enabled&cooldown.eye_beam.remains<6&!buff.metamorphosis.up&!debuff.exposed_wound.up;
	if conduit[HV.SerratedGlaive] and
		cooldown[HV.EyeBeam].remains < 6 and
		not buff[HV.Metamorphosis].up and
		not debuff[HV.ExposedWound].up
	then
		return HV.ThrowGlaive;
	end

	-- eye_beam,if=raid_event.adds.up|raid_event.adds.in>25;
	if cooldown[HV.EyeBeam].ready and fury >= 30 then
		return HV.EyeBeam;
	end

	-- blade_dance,if=variable.blade_dance&!cooldown.metamorphosis.ready&(cooldown.eye_beam.remains>5|(raid_event.adds.in>cooldown&raid_event.adds.in<25));
	if cooldown[HV.BladeDance].ready and fury >= bladeDanceCost and
		bladeDance and
		--not cooldown[HV.Metamorphosis].ready and
		cooldown[HV.EyeBeam].remains > 5
	then
		return BladeDance;
	end

	-- immolation_aura;
	if cooldown[HV.ImmolationAura].ready then
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
	--if cooldown[HV.FelRush].ready and (
	--	talents[HV.DemonBlades] and not cooldown[HV.EyeBeam].ready and cooldown[HV.FelRush].charges >= 2
	--) then
	--	return HV.FelRush;
	--end

	-- demons_bite,target_if=min:debuff.burning_wound.remains,if=runeforge.burning_wound&debuff.burning_wound.remains<4;
	if not talents[HV.DemonBlades] and runeforge[HV.BurningWoundBonusId] and debuff[HV.BurningWound].remains < 4 then
		return HV.DemonsBite;
	end

	-- throw_glaive,if=talent.demon_blades.enabled;
	if talents[HV.DemonBlades] then
		if cooldown[HV.ThrowGlaive].ready then
			return HV.ThrowGlaive;
		else
			return nil;
		end
	end

	-- demons_bite;
	return HV.DemonsBite;
end

function DemonHunter:HavocEssenceBreak()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local fury = fd.fury;
	local bladeDance = fd.bladeDance;
	local BladeDance = fd.BladeDance;
	local ChaosStrike = fd.ChaosStrike;

	-- essence_break,if=fury>=80&(cooldown.blade_dance.ready|!variable.blade_dance);
	if talents[HV.EssenceBreak] and
		cooldown[HV.EssenceBreak].ready and
		fury >= 80 and
		(cooldown[HV.BladeDance].ready or not bladeDance)
	then
		return HV.EssenceBreak;
	end

	-- death_sweep,if=variable.blade_dance&debuff.essence_break.up;
	-- blade_dance,if=variable.blade_dance&debuff.essence_break.up;
	if cooldown[HV.BladeDance].ready and fury >= 35 and bladeDance and debuff[HV.EssenceBreak].up then
		return BladeDance;
	end

	-- annihilation,if=debuff.essence_break.up;
	-- chaos_strike,if=debuff.essence_break.up;
	if fury >= 40 and debuff[HV.EssenceBreak].up then
		return ChaosStrike;
	end
end

function DemonHunter:HavocNormal()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local fury = fd.fury;
	local furyDeficit = fd.furyDeficit;
	local bladeDance = fd.bladeDance;
	local runeforge = fd.runeforge;
	local bladeDanceCost = fd.bladeDanceCost;
	local conduit = fd.covenant.soulbindConduits;
	local poolingForBladeDance = fd.poolingForBladeDance;
	local waitingForEssenceBreak = fd.waitingForEssenceBreak;
	local poolingForMeta = fd.poolingForMeta;

	local desiredTargets = 3;
	local ChaosStrike = fd.ChaosStrike;
	local BladeDance = fd.BladeDance;

	-- variable,name=waiting_for_momentum,value=talent.momentum.enabled&!buff.momentum.up;
	local waitingForMomentum = talents[HV.Momentum] and not buff[HV.MomentumAura].up;

	-- vengeful_retreat,if=talent.momentum.enabled&buff.prepared.down&time>1;
	if cooldown[HV.VengefulRetreat].ready and talents[HV.Momentum] and not buff[HV.Prepared].up then
		return HV.VengefulRetreat;
	end

	-- fel_rush,if=(variable.waiting_for_momentum|talent.unbound_chaos.enabled&buff.unbound_chaos.up)&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10));
	--if cooldown[HV.FelRush].ready and
	--	(waitingForMomentum or talents[HV.UnboundChaos] and buff[HV.UnboundChaos].up) and
	--	cooldown[HV.FelRush].charges >= 2
	--then
	--	return HV.FelRush;
	--end

	-- fel_barrage,if=active_enemies>desired_targets|raid_event.adds.in>30;
	if talents[HV.FelBarrage] and cooldown[HV.FelBarrage].ready and targets > desiredTargets then
		return HV.FelBarrage;
	end

	-- death_sweep,if=variable.blade_dance;
	if cooldown[HV.DeathSweep].ready and fury >= bladeDanceCost and bladeDance and buff[HV.Metamorphosis].up then
		return BladeDance; --DeathSweep
	end

	-- immolation_aura;
	if cooldown[HV.ImmolationAura].ready then
		return HV.ImmolationAura;
	end

	-- glaive_tempest,if=!variable.waiting_for_momentum&(active_enemies>desired_targets|raid_event.adds.in>10);
	if talents[HV.GlaiveTempest] and
		cooldown[HV.GlaiveTempest].ready and
		fury >= 30 and
		not waitingForMomentum
	then
		return HV.GlaiveTempest;
	end

	-- throw_glaive,if=conduit.serrated_glaive.enabled&cooldown.eye_beam.remains<6&!buff.metamorphosis.up&!debuff.exposed_wound.up;
	if conduit[HV.SerratedGlaive] and
		cooldown[HV.EyeBeam].remains < 6 and
		not buff[HV.Metamorphosis].up and
		not debuff[HV.ExposedWound].up
	then
		return HV.ThrowGlaive;
	end

	-- eye_beam,if=!variable.waiting_for_momentum&(active_enemies>desired_targets|raid_event.adds.in>15);
	if cooldown[HV.EyeBeam].ready and
		fury >= 30 and
		not waitingForMomentum and
		targets > desiredTargets
	then
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

	-- annihilation,if=(talent.demon_blades.enabled|!variable.waiting_for_momentum|fury.deficit<30|buff.metamorphosis.remains<5)&!variable.pooling_for_blade_dance&!variable.waiting_for_essence_break;
	if fury >= 40 and
		(talents[HV.DemonBlades] or not waitingForMomentum or furyDeficit < 30 or buff[HV.Metamorphosis].remains < 5) and
		not poolingForBladeDance and
		not waitingForEssenceBreak and
		buff[HV.Metamorphosis].up
	then
		return ChaosStrike; --annihilation
	end

	-- chaos_strike,if=(talent.demon_blades.enabled|!variable.waiting_for_momentum|fury.deficit<30)&!variable.pooling_for_meta&!variable.pooling_for_blade_dance&!variable.waiting_for_essence_break;
	if fury >= 40 and
		(talents[HV.DemonBlades] or not waitingForMomentum or furyDeficit < 30) and
		not poolingForMeta and
		not poolingForBladeDance and
		not waitingForEssenceBreak and
		not buff[HV.Metamorphosis].up
	then
		return ChaosStrike;
	end

	-- eye_beam,if=talent.blind_fury.enabled&raid_event.adds.in>cooldown;
	if cooldown[HV.EyeBeam].ready and fury >= 30 and talents[HV.BlindFury] then
		return HV.EyeBeam;
	end

	-- demons_bite,target_if=min:debuff.burning_wound.remains,if=runeforge.burning_wound&debuff.burning_wound.remains<4;
	if not talents[HV.DemonBlades] and runeforge[HV.BurningWoundBonusId] and debuff[HV.BurningWound].remains < 4 then
		return HV.DemonsBite;
	end

	-- fel_rush,if=!talent.momentum.enabled&raid_event.movement.in>charges*10&talent.demon_blades.enabled;
	if cooldown[HV.FelRush].ready and
		not talents[HV.Momentum] and talents[HV.DemonBlades]
	then
		return HV.FelRush;
	end

	-- felblade,if=movement.distance>15|buff.out_of_range.up;
	--if talents[HV.Felblade] and cooldown[HV.Felblade].ready then
	--	return HV.Felblade;
	--end

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