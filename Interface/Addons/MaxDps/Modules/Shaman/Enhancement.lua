if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, MaxDps_ShamanTable = ...;

--- @type MaxDps
if not MaxDps then
	return
end
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local Maelstrom = Enum.PowerType.Maelstrom;

local Shaman = MaxDps_ShamanTable.Shaman;

local EH = {
	LightningShield      = 192106,
	Boulderfist          = 246035,
	Landslide            = 197992,
	Hailstorm            = 210853,
	Frostbrand           = 196834,
	CrashLightning       = 187874,
	Flametongue          = 193796,
	Stormstrike          = 17364,
	Stormbringer         = 201845,
	FeralSpirit          = 51533,
	CrashingStorm        = 192246,
	LavaLash             = 60103,
	LightningBolt        = 187837,
	Rockbiter            = 193786,
	FuryOfAir            = 197211,
	Overcharge           = 210727,
	Windsong             = 201898,
	HotHand              = 201900,
	Windfury             = 33757,
	FeralLunge           = 196884,
	WindRushTotem        = 192077,
	EarthenSpike         = 188089,
	Windstrike           = 115356,
	GatheringStorms      = 198300,
	SearingAssault       = 192087,
	Sundering            = 197214,
	Ascendance           = 114051,
	EarthElemental       = 198103,
	ForcefulWinds        = 262647,

	TotemMastery         = 262395,
	ResonanceTotem       = 262417,

	PrimalPrimer         = 272992,
	PrimalPrimerAura     = 273006,

	NaturalHarmony       = 278697,
	NaturalHarmonyFrost  = 279029,
	NaturalHarmonyFire   = 279028,
	NaturalHarmonyNature = 279033,

	StrengthOfEarth      = 273461,
	StrengthOfEarthAura  = 273465,

	LightningConduit     = 275388,
	LightningConduitAura = 275391,
};

setmetatable(EH, Shaman.spellMeta);
--local EH = {
--	LightningShield = 192106,
--	WindShear       = 57994,
--	Ascendance      = 114051,
--	FeralSpirit     = 51533,
--	FuryOfAir       = 197211,
--	Stormstrike     = 17364,
--	LavaLash        = 60103,
--	CrashLightning  = 187874,
--	Frostbrand      = 196834,
--	EarthenSpike    = 188089,
--	LightningBolt   = 187837,
--	Overcharge      = 210727,
--	HotHand         = 201900,
--	Hailstorm       = 210853,
--	Boulderfist     = 246035,
--	Landslide       = 197992,
--	Rockbiter       = 193786,
--	Bloodlust       = 2825,
--	EarthElemental  = 198103,
--	Stormbringer    = 201845,
--	Sundering       = 197214,
--
--	Flametongue     = 193796,
--	SearingAssault  = 192087,
--	CrashingStorm   = 192246,
--	TotemMastery    = 262395,
--};

function Shaman:Enhancement()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local gcd = fd.gcd;
	local maelstrom = UnitPower('player', Maelstrom);
	local feralSpiritRemains = Clamp(cooldown[EH.FeralSpirit].remains - 90 + 15, 0, 16);

	fd.targets = targets;

	-- variable,name=cooldown_sync,value=(talent.ascendance.enabled&(buff.ascendance.up|cooldown.ascendance.remains>50))|(!talent.ascendance.enabled&(feral_spirit.remains>5|cooldown.feral_spirit.remains>50));
	fd.cooldownSync = (
		talents[EH.Ascendance] and (buff[EH.Ascendance].up or
			cooldown[EH.Ascendance].remains > 50)
	) or (
		not talents[EH.Ascendance] and (feralSpiritRemains > 5 or cooldown[EH.FeralSpirit].remains > 50)
	);

	-- variable,name=furyCheck_SS,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.stormstrike.cost));
	fd.furyCheckSS = maelstrom >= ((talents[EH.FuryOfAir] and 1 or 0) * (6 + 30));

	-- variable,name=furyCheck_LL,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.lava_lash.cost));
	fd.furyCheckLL = maelstrom >= ((talents[EH.FuryOfAir] and 1 or 0) * (6 + 40));

	-- variable,name=furyCheck_CL,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.crash_lightning.cost));
	fd.furyCheckCL = maelstrom >= ((talents[EH.FuryOfAir] and 1 or 0) * (6 + 20));

	-- variable,name=furyCheck_FB,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.frostbrand.cost));
	fd.furyCheckFB = maelstrom >= ((talents[EH.FuryOfAir] and 1 or 0) * (6 + 20));

	-- variable,name=furyCheck_ES,value=maelstrom>=(talent.fury_of_air.enabled*(6+action.earthen_spike.cost));
	fd.furyCheckES = maelstrom >= ((talents[EH.FuryOfAir] and 1 or 0) * (6 + 20));

	-- variable,name=furyCheck_LB,value=maelstrom>=(talent.fury_of_air.enabled*(6+40));
	fd.furyCheckLB = maelstrom >= ((talents[EH.FuryOfAir] and 1 or 0) * (6 + 40));

	-- variable,name=OCPool,value=(active_enemies>1|(cooldown.lightning_bolt.remains>=2*gcd));
	fd.oCPool = (targets > 1 or (cooldown[EH.LightningBolt].remains >= 2 * gcd));

	-- variable,name=OCPool_SS,value=(variable.OCPool|maelstrom>=(talent.overcharge.enabled*(40+action.stormstrike.cost)));
	fd.oCPoolSS = (fd.oCPool or maelstrom >= ((talents[EH.Overcharge] and 1 or 0) * (40 + 30)));

	-- variable,name=OCPool_LL,value=(variable.OCPool|maelstrom>=(talent.overcharge.enabled*(40+action.lava_lash.cost)));
	fd.oCPoolLL = (fd.oCPool or maelstrom >= ((talents[EH.Overcharge] and 1 or 0) * (40 + 40)));

	-- variable,name=OCPool_CL,value=(variable.OCPool|maelstrom>=(talent.overcharge.enabled*(40+action.crash_lightning.cost)));
	fd.oCPoolCL = (fd.oCPool or maelstrom >= ((talents[EH.Overcharge] and 1 or 0) * (40 + 20)));

	-- variable,name=OCPool_FB,value=(variable.OCPool|maelstrom>=(talent.overcharge.enabled*(40+action.frostbrand.cost)));
	fd.oCPoolFB = (fd.oCPool or maelstrom >= ((talents[EH.Overcharge] and 1 or 0) * (40 + 20)));

	-- variable,name=CLPool_LL,value=active_enemies=1|maelstrom>=(action.crash_lightning.cost+action.lava_lash.cost);
	fd.cLPoolLL = targets == 1 or maelstrom >= (20 + 40);

	-- variable,name=CLPool_SS,value=active_enemies=1|maelstrom>=(action.crash_lightning.cost+action.stormstrike.cost);
	fd.cLPoolSS = targets == 1 or maelstrom >= (20 + 30);

	-- variable,name=freezerburn_enabled,value=(talent.hot_hand.enabled&talent.hailstorm.enabled&azerite.primal_primer.enabled);
	fd.freezerburnEnabled = (talents[EH.HotHand] and talents[EH.Hailstorm] and azerite[EH.PrimalPrimer] > 0);

	-- variable,name=rockslide_enabled,value=(!variable.freezerburn_enabled&(talent.boulderfist.enabled&talent.landslide.enabled&azerite.strength_of_earth.enabled));
	fd.rockslideEnabled = (not fd.freezerburnEnabled and (talents[EH.Boulderfist] and talents[EH.Landslide] and azerite[EH.StrengthOfEarth] > 0));

	fd.maelstrom = maelstrom;

	local result;

	-- call_action_list,name=cds;
	Shaman:EnhancementCds();

	-- call_action_list,name=asc,if=buff.ascendance.up;
	if buff[EH.Ascendance].up then
		result = Shaman:EnhancementAsc();
		if result then return result; end
	end

	-- call_action_list,name=priority;
	result = Shaman:EnhancementPriority();
	if result then return result; end

	-- call_action_list,name=maintenance,if=active_enemies<3;
	if targets < 3 then
		result = Shaman:EnhancementMaintenance();
		if result then return result; end
	end

	-- call_action_list,name=freezerburn_core,if=variable.freezerburn_enabled;
	-- call_action_list,name=default_core,if=!variable.freezerburn_enabled;
	if fd.freezerburnEnabled then
		result = Shaman:EnhancementFreezerburnCore();
		if result then return result; end
	else
		result = Shaman:EnhancementDefaultCore();
		if result then return result; end
	end

	-- call_action_list,name=maintenance,if=active_enemies>=3;
	if targets >= 3 then
		result = Shaman:EnhancementMaintenance();
		if result then return result; end
	end

	-- call_action_list,name=filler;
	return Shaman:EnhancementFiller();
end

function Shaman:EnhancementAsc()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local targets = fd.targets;
	local maelstrom = fd.maelstrom;
	local furyCheckCL = fd.furyCheckCL;

	-- crash_lightning,if=!buff.crash_lightning.up&active_enemies>1&variable.furyCheck_CL;
	if cooldown[EH.CrashLightning].ready and maelstrom >= 20 and not buff[EH.CrashLightning].up and targets > 1 and furyCheckCL then
		return EH.CrashLightning;
	end

	-- rockbiter,if=talent.landslide.enabled&!buff.landslide.up&charges_fractional>1.7;
	if cooldown[EH.Rockbiter].ready and talents[EH.Landslide] and not buff[EH.Landslide].up and cooldown[EH.Rockbiter].charges > 1.7 then
		return EH.Rockbiter;
	end

	-- windstrike;
	return EH.Windstrike;
end

function Shaman:EnhancementCds()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local talents = fd.talents;

	MaxDps:GlowEssences();

	-- feral_spirit;
	MaxDps:GlowCooldown(EH.FeralSpirit, cooldown[EH.FeralSpirit].ready);

	-- ascendance,if=cooldown.strike.remains>0;
	-- @TODO: wtf is strike?
	if talents[EH.Ascendance] then
		MaxDps:GlowCooldown(EH.Ascendance, cooldown[EH.Ascendance].ready);
	end

	-- earth_elemental;
	MaxDps:GlowCooldown(EH.EarthElemental, cooldown[EH.EarthElemental].ready);
end

function Shaman:EnhancementDefaultCore()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local maelstrom = fd.maelstrom;
	local furyCheckES = fd.furyCheckES;
	local furyCheckSS = fd.furyCheckSS;
	local furyCheckCL = fd.furyCheckCL;
	local furyCheckLB = fd.furyCheckLB;
	local oCPoolSS = fd.oCPoolSS;

	-- earthen_spike,if=variable.furyCheck_ES;
	if talents[EH.EarthenSpike] and cooldown[EH.EarthenSpike].ready and maelstrom >= 20 and furyCheckES then
		return EH.EarthenSpike;
	end

	-- stormstrike,cycle_targets=1,if=active_enemies>1&azerite.lightning_conduit.enabled&!debuff.lightning_conduit.up&variable.furyCheck_SS;
	if cooldown[EH.Stormstrike].ready and maelstrom >= 30 and (
		targets > 1 and azerite[EH.LightningConduit] > 0 and not debuff[EH.LightningConduitAura].up and furyCheckSS
	) then
		return EH.Stormstrike;
	end

	-- stormstrike,if=buff.stormbringer.up|(active_enemies>1&buff.gathering_storms.up&variable.furyCheck_SS);
	if cooldown[EH.Stormstrike].ready and maelstrom >= 30 and (
		buff[EH.Stormbringer].up or
		(targets > 1 and buff[EH.GatheringStorms].up and furyCheckSS)
	) then
		return EH.Stormstrike;
	end

	-- crash_lightning,if=active_enemies>=3&variable.furyCheck_CL;
	if cooldown[EH.CrashLightning].ready and maelstrom >= 20 and (targets >= 3 and furyCheckCL) then
		return EH.CrashLightning;
	end

	-- lightning_bolt,if=talent.overcharge.enabled&active_enemies=1&variable.furyCheck_LB&maelstrom>=40;
	if talents[EH.Overcharge] and targets <= 1 and furyCheckLB and maelstrom >= 40 then
		return EH.LightningBolt;
	end

	-- stormstrike,if=variable.OCPool_SS&variable.furyCheck_SS;
	if cooldown[EH.Stormstrike].ready and maelstrom >= 30 and oCPoolSS and furyCheckSS then
		return EH.Stormstrike;
	end
end

function Shaman:EnhancementFiller()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local talents = fd.talents;
	local targets = fd.targets;
	local gcd = fd.gcd;
	local maelstrom = fd.maelstrom;
	local furyCheckCL = fd.furyCheckCL;
	local furyCheckLL = fd.furyCheckLL;
	local furyCheckFB = fd.furyCheckFB;
	local oCPoolLL = fd.oCPoolLL;
	local oCPoolCL = fd.oCPoolCL;

	-- sundering;
	if talents[EH.Sundering] and cooldown[EH.Sundering].ready and maelstrom >= 20 then
		return EH.Sundering;
	end

	-- crash_lightning,if=talent.forceful_winds.enabled&active_enemies>1&variable.furyCheck_CL;
	if cooldown[EH.CrashLightning].ready and maelstrom >= 20 and (
		talents[EH.ForcefulWinds] and targets > 1 and furyCheckCL
	) then
		return EH.CrashLightning;
	end

	-- flametongue,if=talent.searing_assault.enabled;
	if cooldown[EH.Flametongue].ready and talents[EH.SearingAssault] then
		return EH.Flametongue;
	end

	-- lava_lash,if=!azerite.primal_primer.enabled&talent.hot_hand.enabled&buff.hot_hand.react;
	if maelstrom >= 40 and (
		azerite[EH.PrimalPrimer] == 0 and talents[EH.HotHand] and buff[EH.HotHand].up
	) then
		return EH.LavaLash;
	end

	-- crash_lightning,if=active_enemies>1&variable.furyCheck_CL;
	if cooldown[EH.CrashLightning].ready and maelstrom >= 20 and targets > 1 and furyCheckCL then
		return EH.CrashLightning;
	end

	-- rockbiter,if=maelstrom<70&!buff.strength_of_earth.up;
	if cooldown[EH.Rockbiter].ready and maelstrom < 70 and not buff[EH.StrengthOfEarthAura].up then
		return EH.Rockbiter;
	end

	-- crash_lightning,if=talent.crashing_storm.enabled&variable.OCPool_CL;
	if cooldown[EH.CrashLightning].ready and maelstrom >= 20 and talents[EH.CrashingStorm] and oCPoolCL then
		return EH.CrashLightning;
	end

	-- lava_lash,if=variable.OCPool_LL&variable.furyCheck_LL;
	if maelstrom >= 40 and oCPoolLL and furyCheckLL then
		return EH.LavaLash;
	end

	-- rockbiter;
	if cooldown[EH.Rockbiter].ready then
		return EH.Rockbiter;
	end

	-- frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<4.8+gcd&variable.furyCheck_FB;
	if maelstrom >= 20 and talents[EH.Hailstorm] and buff[EH.Frostbrand].remains < 4.8 + gcd and furyCheckFB then
		return EH.Frostbrand;
	end

	-- flametongue;
	if cooldown[EH.Flametongue].ready then
		return EH.Flametongue;
	end
end

function Shaman:EnhancementFreezerburnCore()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local maelstrom = fd.maelstrom;
	local furyCheckLL = fd.furyCheckLL;
	local furyCheckES = fd.furyCheckES;
	local furyCheckSS = fd.furyCheckSS;
	local furyCheckCL = fd.furyCheckCL;
	local furyCheckLB = fd.furyCheckLB;
	local cLPoolLL = fd.cLPoolLL;
	local oCPoolSS = fd.oCPoolSS;
	local cLPoolSS = fd.cLPoolSS;

	-- lava_lash,target_if=max:debuff.primal_primer.stack,if=azerite.primal_primer.rank>=2&debuff.primal_primer.stack=10&variable.furyCheck_LL&variable.CLPool_LL;
	if maelstrom >= 40 and azerite[EH.PrimalPrimer] >= 2 and
		debuff[EH.PrimalPrimerAura].count >= 10 and
		furyCheckLL and
		cLPoolLL then
		return EH.LavaLash;
	end

	-- earthen_spike,if=variable.furyCheck_ES;
	if talents[EH.EarthenSpike] and cooldown[EH.EarthenSpike].ready and maelstrom >= 20 and furyCheckES then
		return EH.EarthenSpike;
	end

	-- stormstrike,cycle_targets=1,if=active_enemies>1&azerite.lightning_conduit.enabled&!debuff.lightning_conduit.up&variable.furyCheck_SS;
	if cooldown[EH.Stormstrike].ready and maelstrom >= 30 and (
		targets > 1 and azerite[EH.LightningConduit] > 0 and not debuff[EH.LightningConduitAura].up and furyCheckSS
	) then
		return EH.Stormstrike;
	end

	-- stormstrike,if=buff.stormbringer.up|(active_enemies>1&buff.gathering_storms.up&variable.furyCheck_SS);
	if cooldown[EH.Stormstrike].ready and (
		buff[EH.Stormbringer].up or
		(targets > 1 and buff[EH.GatheringStorms].up and furyCheckSS)
	) then
		return EH.Stormstrike;
	end

	-- crash_lightning,if=active_enemies>=3&variable.furyCheck_CL;
	if cooldown[EH.CrashLightning].ready and maelstrom >= 20 and targets >= 3 and furyCheckCL then
		return EH.CrashLightning;
	end

	-- lightning_bolt,if=talent.overcharge.enabled&active_enemies=1&variable.furyCheck_LB&maelstrom>=40;
	if talents[EH.Overcharge] and targets <= 1 and furyCheckLB and maelstrom >= 40 then
		return EH.LightningBolt;
	end

	-- lava_lash,if=azerite.primal_primer.rank>=2&debuff.primal_primer.stack>7&variable.furyCheck_LL&variable.CLPool_LL;
	if maelstrom >= 40 and azerite[EH.PrimalPrimer] >= 2 and
		debuff[EH.PrimalPrimerAura].count > 7 and furyCheckLL and cLPoolLL
	then
		return EH.LavaLash;
	end

	-- stormstrike,if=variable.OCPool_SS&variable.furyCheck_SS&variable.CLPool_SS;
	if cooldown[EH.Stormstrike].ready and maelstrom >= 30 and oCPoolSS and furyCheckSS and cLPoolSS then
		return EH.Stormstrike;
	end

	-- lava_lash,if=debuff.primal_primer.stack=10&variable.furyCheck_LL;
	if maelstrom >= 40 and debuff[EH.PrimalPrimerAura].count >= 10 and furyCheckLL then
		return EH.LavaLash;
	end
end

function Shaman:EnhancementMaintenance()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local maelstrom = fd.maelstrom;
	local furyCheckFB = fd.furyCheckFB;

	-- flametongue,if=!buff.flametongue.up;
	if cooldown[EH.Flametongue].ready and not buff[EH.Flametongue].up then
		return EH.Flametongue;
	end

	-- frostbrand,if=talent.hailstorm.enabled&!buff.frostbrand.up&variable.furyCheck_FB;
	if maelstrom >= 20 and talents[EH.Hailstorm] and not buff[EH.Frostbrand].up and furyCheckFB then
		return EH.Frostbrand;
	end
end

function Shaman:EnhancementPriority()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local gcd = fd.gcd;
	local maelstrom = fd.maelstrom;
	local freezerburnEnabled = fd.freezerburnEnabled;
	local furyCheckCL = fd.furyCheckCL;
	local furyCheckLL = fd.furyCheckLL;
	local furyCheckFB = fd.furyCheckFB;

	-- crash_lightning,if=active_enemies>=(8-(talent.forceful_winds.enabled*3))&variable.freezerburn_enabled&variable.furyCheck_CL;
	if cooldown[EH.CrashLightning].ready and maelstrom >= 20 and (
		freezerburnEnabled and furyCheckCL and
		targets >= (8 - (talents[EH.ForcefulWinds] and 3 or 0))
	) then
		return EH.CrashLightning;
	end

	-- lava_lash,if=azerite.primal_primer.rank>=2&debuff.primal_primer.stack=10&active_enemies=1&variable.freezerburn_enabled&variable.furyCheck_LL;
	if maelstrom >= 40 and (
		azerite[EH.PrimalPrimer] >= 2 and
		debuff[EH.PrimalPrimerAura].count >= 10 and
		targets <= 1 and
		freezerburnEnabled and
		furyCheckLL
	) then
		return EH.LavaLash;
	end

	-- crash_lightning,if=!buff.crash_lightning.up&active_enemies>1&variable.furyCheck_CL;
	if cooldown[EH.CrashLightning].ready and maelstrom >= 20 and (
		not buff[EH.CrashLightning].up and
		furyCheckCL and
		targets > 1
	) then
		return EH.CrashLightning;
	end

	-- fury_of_air,if=!buff.fury_of_air.up&maelstrom>=20&spell_targets.fury_of_air_damage>=(1+variable.freezerburn_enabled);
	if talents[EH.FuryOfAir] and maelstrom >= 3 and
		not buff[EH.FuryOfAir].up and maelstrom >= 20 and targets >= (1 + (freezerburnEnabled and 1 or 0))
	then
		return EH.FuryOfAir;
	end

	-- fury_of_air,if=buff.fury_of_air.up&&spell_targets.fury_of_air_damage<(1+variable.freezerburn_enabled);
	if talents[EH.FuryOfAir] and maelstrom >= 3 and
		buff[EH.FuryOfAir].up and targets < (1 + (freezerburnEnabled and 1 or 0))
	then
		return EH.FuryOfAir;
	end

	-- totem_mastery,if=buff.resonance_totem.remains<=2*gcd;
	if talents[EH.TotemMastery] and buff[EH.ResonanceTotem].remains <= 2 * gcd then
		return EH.TotemMastery;
	end

	-- sundering,if=active_enemies>=3;
	if talents[EH.Sundering] and cooldown[EH.Sundering].ready and maelstrom >= 20 and targets >= 3 then
		return EH.Sundering;
	end

	-- rockbiter,if=talent.landslide.enabled&!buff.landslide.up&charges_fractional>1.7;
	if cooldown[EH.Rockbiter].ready and talents[EH.Landslide] and not buff[EH.Landslide].up and cooldown[EH.Rockbiter].charges > 1.7 then
		return EH.Rockbiter;
	end

	-- frostbrand,if=(azerite.natural_harmony.enabled&buff.natural_harmony_frost.remains<=2*gcd)&talent.hailstorm.enabled&variable.furyCheck_FB;
	if maelstrom >= 20 and (azerite[EH.NaturalHarmony] > 0 and buff[EH.NaturalHarmonyFrost].remains <= 2 * gcd) and talents[EH.Hailstorm] and furyCheckFB then
		return EH.Frostbrand;
	end

	-- flametongue,if=(azerite.natural_harmony.enabled&buff.natural_harmony_fire.remains<=2*gcd);
	if cooldown[EH.Flametongue].ready and (azerite[EH.NaturalHarmony] > 0 and buff[EH.NaturalHarmonyFire].remains <= 2 * gcd) then
		return EH.Flametongue;
	end

	-- rockbiter,if=(azerite.natural_harmony.enabled&buff.natural_harmony_nature.remains<=2*gcd)&maelstrom<70;
	if cooldown[EH.Rockbiter].ready and (azerite[EH.NaturalHarmony] > 0 and buff[EH.NaturalHarmonyNature].remains <= 2 * gcd) and maelstrom < 70 then
		return EH.Rockbiter;
	end
end

