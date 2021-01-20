if select(2, UnitClass("player")) ~= "DRUID" then return end

local _, MaxDps_DruidTable = ...;

--- @type MaxDps
if not MaxDps then
	return
end

local MaxDps = MaxDps;
local UnitPower = UnitPower;
local GetSpellCount = GetSpellCount;
local LunarPower = Enum.PowerType.LunarPower;
local GetHaste = GetHaste;
local Druid = MaxDps_DruidTable.Druid;

local Necrolord = Enum.CovenantType.Necrolord;
local Venthyr = Enum.CovenantType.Venthyr;
local NightFae = Enum.CovenantType.NightFae;
local Kyrian = Enum.CovenantType.Kyrian;

local BL = {
	MoonkinForm                = 24858,
	Wrath                      = 190984, -- ok
	Starfire                   = 194153, -- ok
	BalanceOfAllThings         = 339942,
	NaturesBalance             = 202430,
	Starsurge                  = 78674,  -- ok
	Starlord                   = 202345, -- ok
	StellarDrift               = 202354, -- ok
	ConvokeTheSpirits          = 323764,
	Incarnation                = 102560, -- ok
	PreciseAlignmentConduitId  = 262, -- ok
	TimewornDreambinder        = 340049, -- ok
	Starfall                   = 191034, -- ok
	EmpowerBond                = 338142,
	LycarasFleetingGlimpse     = 340059,
	FuryOfElune                = 202770,
	Sunfire                    = 93402,
	SunfireAura                = 164815,
	AdaptiveSwarm              = 325727,
	AdaptiveSwarmAura          = 325733,
	RavenousFrenzy             = 323546,
	Moonfire                   = 8921,
	MoonfireAura               = 164812,
	TwinMoons                  = 279620,
	SoulOfTheForest            = 114107,
	PrimordialArcanicPulsar    = 338825,
	ForceOfNature              = 205636,
	CelestialAlignment         = 194223,
	KindredSpirits             = 326446,
	StellarFlare               = 202347,
	NewMoon                    = 274281,
	HalfMoon                   = 274282,
	FullMoon                   = 274283,
	WarriorOfElune             = 202425,
	OnethsPerception           = 339800,
	OnethsClearVision          = 339797,
	KindredEmpowermentEnergize = 327022,
	BalanceOfAllThingsArcane   = 339946, -- ok
	BalanceOfAllThingsNature   = 339943, -- ok

	EclipseLunar               = 48518,
	EclipseSolar               = 48517,

	-- leggos
	TimewornDreambinderBonusId = 7108,
	PrimordialArcanicPulsarBonusId = 7088,
	BalanceOfAllThingsBonusId  = 7107,
	LycarasFleetingGlimpseBonusId  = 7110
};

setmetatable(BL, Druid.spellMeta);

function Druid:Balance()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local runeforge = fd.runeforge;
	local currentSpell = fd.currentSpell;
	local buff = fd.buff;
	local covenantId = fd.covenant.covenantId;
	local conduit = fd.covenant.soulbindConduits;
	local lunarPower = UnitPower('player', LunarPower);

	local wrathCount = GetSpellCount(BL.Wrath);
	local starfireCount = GetSpellCount(BL.Starfire);
	local origWrathCount = wrathCount;
	local origStarfireCount = starfireCount;

	local castingMoonSpell = false;
	if currentSpell == BL.Wrath then
		lunarPower = lunarPower + 6;
		wrathCount = wrathCount - 1;
	elseif currentSpell == BL.Starfire then
		lunarPower = lunarPower + 8;
		starfireCount = starfireCount - 1;
	elseif currentSpell == BL.FuryOfElune then
		lunarPower = lunarPower + 40;
	elseif currentSpell == BL.ForceOfNature then
		lunarPower = lunarPower + 20;
	elseif currentSpell == BL.StellarFlare then
		lunarPower = lunarPower + 8;
	elseif currentSpell == BL.NewMoon then
		lunarPower = lunarPower + 10;
		castingMoonSpell = true;
	elseif currentSpell == BL.HalfMoon then
		lunarPower = lunarPower + 20;
		castingMoonSpell = true;
	elseif currentSpell == BL.FullMoon then
		lunarPower = lunarPower + 40;
		castingMoonSpell = true;
	end

	local MoonPhase = MaxDps:FindSpell(BL.NewMoon) and BL.NewMoon or
		(MaxDps:FindSpell(BL.HalfMoon) and BL.HalfMoon or BL.FullMoon);
	local CaInc = talents[BL.Incarnation] and BL.Incarnation or BL.CelestialAlignment;

	-- variable,name=is_aoe,value=spell_targets.starfall>1&(!talent.starlord.enabled|talent.stellar_drift.enabled)|spell_targets.starfall>2;
	local isAoe = targets > 1 and (not talents[BL.Starlord] or talents[BL.StellarDrift]) or targets > 2;

	-- variable,name=is_cleave,value=spell_targets.starfire>1;
	local isCleave = targets > 1;

	-- variable,name=convoke_desync,value=floor((interpolated_fight_remains-20-cooldown.convoke_the_spirits.remains)%120)>floor((interpolated_fight_remains-25-(10*talent.incarnation.enabled)-(conduit.precise_alignment.time_value)-cooldown.ca_inc.remains)%180)|cooldown.ca_inc.remains>interpolated_fight_remains|cooldown.convoke_the_spirits.remains>interpolated_fight_remains|!covenant.night_fae;
	local convokeDesync =
		math.floor((20 - cooldown[BL.ConvokeTheSpirits].remains) / 120)
			>
		math.floor(
			(
				25
				- (10 * (talents[BL.Incarnation] and 1 or 0))
				- (conduit[BL.PreciseAlignmentConduitId] and 1 or 0)
				- cooldown[CaInc].remains
			) / 180
		) or
		cooldown[CaInc].remains or
		cooldown[BL.ConvokeTheSpirits].remains or
		not covenantId == NightFae;

	fd.eclipseInLunar = buff[BL.EclipseLunar].up or (origStarfireCount == 1 and currentSpell == BL.Starfire);
	fd.eclipseInSolar = buff[BL.EclipseSolar].up or (origWrathCount == 1 and currentSpell == BL.Wrath);
	fd.eclipseInAny = fd.eclipseInSolar or fd.eclipseInLunar;
	fd.eclipseInBoth = fd.eclipseInSolar and fd.eclipseInLunar;

	fd.eclipseSolarNext = wrathCount > 0 and starfireCount <= 0;
	fd.eclipseLunarNext = wrathCount <= 0 and starfireCount > 0;
	fd.eclipseAnyNext = wrathCount > 0 and starfireCount > 0;

	fd.lunarPower = lunarPower;
	fd.wrathCount = wrathCount;
	fd.starfireCount = starfireCount;
	fd.convokeDesync = convokeDesync;
	fd.CaInc = CaInc;
	fd.targets = targets;
	fd.isAoe = isAoe;
	fd.isCleave = isCleave;
	fd.castingMoonSpell = castingMoonSpell;
	fd.MoonPhase = MoonPhase;

	MaxDps:GlowCooldown(CaInc, cooldown[CaInc].ready);
	if talents[BL.ForceOfNature] then
		MaxDps:GlowCooldown(BL.ForceOfNature, cooldown[BL.ForceOfNature].ready);
	end

	if covenantId == Venthyr then
		MaxDps:GlowCooldown(BL.RavenousFrenzy, cooldown[BL.RavenousFrenzy].ready);
	elseif covenantId == NightFae then
		MaxDps:GlowCooldown(BL.ConvokeTheSpirits, cooldown[BL.ConvokeTheSpirits].ready);
	elseif covenantId == Kyrian then
		MaxDps:GlowCooldown(BL.KindredSpirits, cooldown[BL.KindredSpirits].ready);
	end

	-- run_action_list,name=aoe,if=variable.is_aoe;
	if isAoe then
		return Druid:BalanceAoe();
	end

	-- run_action_list,name=dreambinder,if=runeforge.timeworn_dreambinder.equipped;
	if runeforge[BL.TimewornDreambinderBonusId] then
		return Druid:BalanceDreambinder();
	end

	-- run_action_list,name=boat,if=runeforge.balance_of_all_things.equipped;
	if runeforge[BL.BalanceOfAllThingsBonusId] then
		return Druid:BalanceBoat();
	end

	-- run_action_list,name=st;
	return Druid:BalanceSt();
end

function Druid:BalanceAoe()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local targets = fd.targets;
	local gcd = fd.gcd;
	local spellHaste = GetHaste();
	local covenantId = fd.covenant.covenantId;
	local lunarPower = fd.lunarPower;
	local runeforge = fd.runeforge;
	local CaInc = fd.CaInc;
	local isCleave = fd.isCleave;
	local eclipseInAny = fd.eclipseInAny;
	local eclipseInLunar = fd.eclipseInLunar;
	local eclipseInSolar = fd.eclipseInSolar;
	local eclipseInBoth = fd.eclipseInBoth;
	local eclipseSolarNext = fd.eclipseSolarNext;
	local eclipseLunarNext = fd.eclipseLunarNext;
	local eclipseAnyNext = fd.eclipseAnyNext;
	local convokeDesync = fd.convokeDesync;
	local castingMoonSpell = fd.castingMoonSpell;
	local MoonPhase = fd.MoonPhase;

	local canStarfall = lunarPower >= 50 or buff[BL.OnethsPerception].up;
	local canStarsurge = lunarPower >= 30 or buff[BL.OnethsClearVision].up;

	-- variable,name=dream_will_fall_off,value=(buff.timeworn_dreambinder.remains<gcd.max+0.1|buff.timeworn_dreambinder.remains<action.starfire.execute_time+0.1&(eclipse.in_lunar|eclipse.solar_next|eclipse.any_next))&buff.timeworn_dreambinder.up&runeforge.timeworn_dreambinder.equipped;
	local dreamWillFallOff =
		runeforge[BL.TimewornDreambinderBonusId] and buff[BL.TimewornDreambinder].up and
		(
			buff[BL.TimewornDreambinder].remains < gcd + 0.1 or
			buff[BL.TimewornDreambinder].remains < 2 + 0.1 and (eclipseInLunar or eclipseSolarNext or eclipseAnyNext)
		)
	;

	-- convoke_the_spirits,if=(variable.convoke_desync&!cooldown.ca_inc.ready|buff.ca_inc.up)&astral_power<50&(buff.eclipse_lunar.remains>6|buff.eclipse_solar.remains>6)&(!runeforge.balance_of_all_things|buff.balance_of_all_things_nature.stack>3|buff.balance_of_all_things_arcane.stack>3)|fight_remains<10;
	--if cooldown[BL.ConvokeTheSpirits].ready and currentSpell ~= BL.ConvokeTheSpirits and
	--	(
	--		(convokeDesync and not cooldown[CaInc].ready or buff[CaInc].up) and
	--			lunarPower < 50 and
	--			(buff[BL.EclipseLunar].remains > 6 or buff[BL.EclipseSolar].remains > 6) and
	--			(not runeforge[BL.BalanceOfAllThingsBonusId] or
	--				buff[BL.BalanceOfAllThingsNature].count > 3 or
	--				buff[BL.BalanceOfAllThingsArcane].count > 3)
	--	)
	--then
	--	return BL.ConvokeTheSpirits;
	--end

	-- starfall,if=buff.starfall.refreshable&(spell_targets.starfall<3|!runeforge.timeworn_dreambinder.equipped)&(!runeforge.lycaras_fleeting_glimpse.equipped|time%%45>buff.starfall.remains+2);
	if canStarfall and
		buff[BL.Starfall].refreshable and
		(targets < 3 or not runeforge[BL.TimewornDreambinderBonusId]) and
		(not runeforge[BL.LycarasFleetingGlimpseBonusId])
	then
		return BL.Starfall;
	end

	-- starfall,if=runeforge.timeworn_dreambinder.equipped&spell_targets.starfall>=3&(!buff.timeworn_dreambinder.up&buff.starfall.refreshable|(variable.dream_will_fall_off&(buff.starfall.remains<3|spell_targets.starfall>2&talent.stellar_drift.enabled&buff.starfall.remains<5)));
	if canStarfall and
		runeforge[BL.TimewornDreambinderBonusId] and
		targets >= 3 and
		(
			not buff[BL.TimewornDreambinder].up and buff[BL.Starfall].refreshable or
			(
				dreamWillFallOff and
				(
					buff[BL.Starfall].remains < 3 or
					targets > 2 and talents[BL.StellarDrift] and buff[BL.Starfall].remains < 5
				)
			)
		)
	then
		return BL.Starfall;
	end

	local furyOfEluneRemains = talents[BL.FuryOfElune] and cooldown[BL.FuryOfElune].remains - 52 or 0;
	if furyOfEluneRemains < 0 then furyOfEluneRemains = 0 end

	-- variable,name=starfall_wont_fall_off,value=astral_power>80-(10*buff.timeworn_dreambinder.stack)-(buff.starfall.remains*3%spell_haste)-(dot.fury_of_elune.remains*5)&buff.starfall.up;
	local starfallWontFallOff = lunarPower >
		80 -
			(10 * buff[BL.TimewornDreambinder].count) -
			(buff[BL.Starfall].remains * 3 / spellHaste) -
			(furyOfEluneRemains * 5)
		and buff[BL.Starfall].up;

	-- starsurge,if=variable.dream_will_fall_off&variable.starfall_wont_fall_off|(buff.balance_of_all_things_nature.stack>3|buff.balance_of_all_things_arcane.stack>3)&spell_targets.starfall<4;
	if lunarPower >= 40 and
		(
			dreamWillFallOff and starfallWontFallOff or
			(buff[BL.BalanceOfAllThingsNature].count > 3 or buff[BL.BalanceOfAllThingsArcane].count > 3)
			and targets < 4
		)
	then
		return BL.Starsurge;
	end

	-- sunfire,target_if=refreshable&target.time_to_die>14-spell_targets+remains,if=ap_check&eclipse.in_any;
	if debuff[BL.SunfireAura].refreshable and eclipseInAny then
		return BL.Sunfire;
	end

	-- adaptive_swarm,target_if=!ticking&!action.adaptive_swarm_damage.in_flight|dot.adaptive_swarm_damage.stack<3&dot.adaptive_swarm_damage.remains<3;
	if covenantId == Necrolord and
		cooldown[BL.AdaptiveSwarm].ready and
		not debuff[BL.AdaptiveSwarmAura].up
	then
		return BL.AdaptiveSwarm;
	end

	local primordialArcanicPulsarValue = Druid:PrimordialArcanicPulsarValue();
	-- moonfire,target_if=refreshable&target.time_to_die>(14+(spell_targets.starfire*1.5))%spell_targets+remains,if=(cooldown.ca_inc.ready&(variable.convoke_desync|cooldown.convoke_the_spirits.ready|!covenant.night_fae)|spell_targets.starfire<(4*(1+talent.twin_moons.enabled))|(eclipse.in_solar|(eclipse.in_both|eclipse.in_lunar)&!talent.soul_of_the_forest.enabled|buff.primordial_arcanic_pulsar.value>=250)&(spell_targets.starfire<10*(1+talent.twin_moons.enabled))&astral_power>50-buff.starfall.remains*6)&(!buff.kindred_empowerment_energize.up|eclipse.in_solar|!covenant.kyrian)&ap_check;
	if debuff[BL.MoonfireAura].refreshable and (
		--cooldown[CaInc].ready and
		(
			convokeDesync or
			cooldown[BL.ConvokeTheSpirits].ready or
			not covenantId == NightFae
		) or
			targets < (4 * (1 + (talents[BL.TwinMoons] and 1 or 0))) or
			(
				eclipseInSolar or
				(eclipseInBoth or eclipseInLunar) and not talents[BL.SoulOfTheForest] or
				primordialArcanicPulsarValue >= 250
			) and
				(targets < 10 * (1 + (talents[BL.TwinMoons] and 1 or 0))) and
				lunarPower > 50 - buff[BL.Starfall].remains * 6
	) and
		(not buff[BL.KindredEmpowermentEnergize].up or eclipseInSolar or not covenantId == Kyrian)
	then
		return BL.Moonfire;
	end

	-- force_of_nature,if=ap_check;
	--if cooldown[BL.ForceOfNature].ready then
	--	return BL.ForceOfNature;
	--end

	-- ravenous_frenzy,if=buff.ca_inc.up;
	--if buff[CaInc].up then
	--	return BL.RavenousFrenzy;
	--end

	-- celestial_alignment,if=variable.cd_condition&(buff.starfall.up|astral_power>50)&!buff.solstice.up&!buff.ca_inc.up&(!covenant.night_fae|variable.convoke_desync|cooldown.convoke_the_spirits.up|interpolated_fight_remains<20+(conduit.precise_alignment.time_value));
	--if cooldown[BL.CelestialAlignment].ready and (
	--	(buff[BL.Starfall].up or lunarPower > 50) and
	--	not buff[BL.Solstice].up and
	--	not buff[CaInc].up and
	--	(not covenantId == NightFae or convokeDesync or cooldown[BL.ConvokeTheSpirits].up)
	--) then
	--	return BL.CelestialAlignment;
	--end

	-- incarnation,if=variable.cd_condition&(buff.starfall.up|astral_power>50)&!buff.solstice.up&!buff.ca_inc.up&(!covenant.night_fae|variable.convoke_desync|cooldown.convoke_the_spirits.up|interpolated_fight_remains<cooldown.convoke_the_spirits.remains+6|interpolated_fight_remains%%180<30+(conduit.precise_alignment.time_value));
	--if talents[BL.Incarnation] and
	--	cooldown[BL.Incarnation].ready and
	--	(cdCondition and
	--		(buff[BL.Starfall].up or lunarPower > 50) and
	--		not buff[BL.Solstice].up and
	--		not buff[CaInc].up and
	--		(not covenantId == NightFae or convokeDesync or cooldown[BL.ConvokeTheSpirits].up)
	--	)
	--then
	--	return BL.Incarnation;
	--end

	-- kindred_spirits,if=interpolated_fight_remains<15|(buff.primordial_arcanic_pulsar.value<250|buff.primordial_arcanic_pulsar.value>=250)&buff.starfall.up&cooldown.ca_inc.remains>50;
	--if currentSpell ~= BL.KindredSpirits and (
	--	(primordialArcanicPulsarValue < 250 or primordialArcanicPulsarValue >= 250) and
	--		buff[BL.Starfall].up and
	--		cooldown[CaInc].remains > 50
	--) then
	--	return BL.KindredSpirits;
	--end

	-- stellar_flare,target_if=refreshable&time_to_die>15,if=spell_targets.starfire<4&ap_check&(buff.ca_inc.remains>10|!buff.ca_inc.up);
	if talents[BL.StellarFlare] and
		debuff[BL.StellarFlare].refreshable and
		currentSpell ~= BL.StellarFlare and
		targets < 4 and
		(buff[CaInc].remains > 10 or not buff[CaInc].up)
	then
		return BL.StellarFlare;
	end

	-- fury_of_elune,if=eclipse.in_any&ap_check&buff.primordial_arcanic_pulsar.value<250&(dot.adaptive_swarm_damage.ticking|!covenant.necrolord|spell_targets>2);
	if talents[BL.FuryOfElune] and
		cooldown[BL.FuryOfElune].ready and
		eclipseInAny and
		primordialArcanicPulsarValue < 250 --and
		--(debuff[BL.AdaptiveSwarmAura].up or not covenantId == Necrolord or targets > 2)
	then
		return BL.FuryOfElune;
	end

	-- starfall,if=buff.oneths_perception.up&(buff.starfall.refreshable|astral_power>90);
	if canStarfall and (buff[BL.Starfall].refreshable or lunarPower > 90) then
		return BL.Starfall;
	end

	-- starfall,if=covenant.night_fae&(variable.convoke_desync|cooldown.ca_inc.up|buff.ca_inc.up)&cooldown.convoke_the_spirits.remains<gcd.max*ceil(astral_power%50)&buff.starfall.remains<4;
	if canStarfall and
		covenantId == NightFae and
		(convokeDesync or cooldown[CaInc].up or buff[CaInc].up) and
		cooldown[BL.ConvokeTheSpirits].remains < gcd * math.ceil(lunarPower / 50) and
		buff[BL.Starfall].remains < 4
	then
		return BL.Starfall;
	end

	-- starsurge,if=covenant.night_fae&(variable.convoke_desync|cooldown.ca_inc.up|buff.ca_inc.up)&cooldown.convoke_the_spirits.remains<6&buff.starfall.up&eclipse.in_any;
	if canStarsurge and
		covenantId == NightFae and
		(convokeDesync or cooldown[CaInc].up or buff[CaInc].up) and
		cooldown[BL.ConvokeTheSpirits].remains < 6 and
		buff[BL.Starfall].up and
		eclipseInAny
	then
		return BL.Starsurge;
	end

	-- starsurge,if=buff.oneths_clear_vision.up|(!starfire.ap_check|(buff.ca_inc.remains<5&buff.ca_inc.up|(buff.ravenous_frenzy.remains<gcd.max*ceil(astral_power%30)&buff.ravenous_frenzy.up))&variable.starfall_wont_fall_off&spell_targets.starfall<3)&(!runeforge.timeworn_dreambinder.equipped|spell_targets.starfall<3);
	if canStarsurge and
		(
			(
				buff[CaInc].remains < 5 and buff[CaInc].up or
				(buff[BL.RavenousFrenzy].remains < gcd * math.ceil(lunarPower / 30) and buff[BL.RavenousFrenzy].up)
			) and
				starfallWontFallOff and targets < 3
		) and (not runeforge[BL.TimewornDreambinderBonusId] or targets < 3)
	then
		return BL.Starsurge;
	end

	-- new_moon,if=(eclipse.in_any&cooldown.ca_inc.remains>50|(charges=2&recharge_time<5)|charges=3)&ap_check;
	-- half_moon,if=(eclipse.in_any&cooldown.ca_inc.remains>50|(charges=2&recharge_time<5)|charges=3)&ap_check;
	-- full_moon,if=(eclipse.in_any&cooldown.ca_inc.remains>50|(charges=2&recharge_time<5)|charges=3)&ap_check;
	if talents[BL.NewMoon] then
		local newMoonCharges = cooldown[BL.NewMoon].charges;
		if castingMoonSpell then newMoonCharges = newMoonCharges - 1; end

		if newMoonCharges >= 1 and eclipseInAny or
			(newMoonCharges >= 2 and cooldown[BL.NewMoon].partialRecharge < 5) or
			newMoonCharges >= 3
		then
			return MoonPhase;
		end
	end

	-- warrior_of_elune;
	if talents[BL.WarriorOfElune] and cooldown[BL.WarriorOfElune].ready then
		return BL.WarriorOfElune;
	end

	local masteryValue = GetMasteryEffect();
	-- variable,name=starfire_in_solar,value=spell_targets.starfire>4+floor(mastery_value%20)+floor(buff.starsurge_empowerment_solar.stack%4);
	local starfireInSolar = targets >
		4
			+ math.floor(masteryValue / 20)
			--+ math.floor(buff[BL.StarsurgeEmpowermentSolar].count / 4)
	;

	-- wrath,if=eclipse.lunar_next|eclipse.any_next&variable.is_cleave|buff.eclipse_solar.remains<action.starfire.execute_time&buff.eclipse_solar.up|eclipse.in_solar&!variable.starfire_in_solar|buff.ca_inc.remains<action.starfire.execute_time&!variable.is_cleave&buff.ca_inc.remains<execute_time&buff.ca_inc.up|buff.ravenous_frenzy.up&spell_haste>0.6&(spell_targets<=3|!talent.soul_of_the_forest.enabled)|!variable.is_cleave&buff.ca_inc.remains>execute_time;
	if ( -- currentSpell ~= BL.Wrath and
		--eclipseLunarNext or
			eclipseInSolar or
			eclipseSolarNext or
			eclipseAnyNext and isCleave or
			buff[BL.EclipseSolar].remains < 2 and buff[BL.EclipseSolar].up or
			--eclipseInSolar and not starfireInSolar or
			--buff[CaInc].remains < 2 and not isCleave and buff[CaInc].remains < 2 and buff[CaInc].up or
			buff[BL.RavenousFrenzy].up and spellHaste > 0.6 and (targets <= 3 or not talents[BL.SoulOfTheForest]) --or
			--not isCleave and buff[CaInc].remains > 2
	) then
		return BL.Wrath;
	end

	-- starfire;
	return BL.Starfire;
	--if currentSpell ~= BL.Starfire then
	--	return BL.Starfire;
	--end
	--
	---- run_action_list,name=fallthru;
	--return Druid:BalanceFallthru();
end

function Druid:BalanceBoat()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local gcd = fd.gcd;
	local spellHaste = GetHaste();
	local covenantId = fd.covenant.covenantId;
	local lunarPower = fd.lunarPower;
	local CaInc = fd.CaInc;
	local isAoe = fd.isAoe;
	local castingMoonSpell = fd.castingMoonSpell;
	local MoonPhase = fd.MoonPhase;

	local eclipseInAny = fd.eclipseInAny;
	local eclipseInLunar = fd.eclipseInLunar;
	local eclipseLunarNext = fd.eclipseLunarNext;
	local eclipseSolarNext = fd.eclipseSolarNext;
	local eclipseAnyNext = fd.eclipseAnyNext;
	local convokeDesync = fd.convokeDesync;
	local starfireCount = fd.starfireCount;

	-- ravenous_frenzy,if=buff.ca_inc.up;
	--if buff[CaInc].up then
	--	return BL.RavenousFrenzy;
	--end

	local canStarfall = lunarPower >= 50 or buff[BL.OnethsPerception].up;
	local canStarsurge = lunarPower >= 30 or buff[BL.OnethsClearVision].up;

	-- variable,name=critnotup,value=!buff.balance_of_all_things_nature.up&!buff.balance_of_all_things_arcane.up;
	local critnotup = not buff[BL.BalanceOfAllThingsNature].up and not buff[BL.BalanceOfAllThingsArcane].up;

	-- adaptive_swarm,target_if=buff.balance_of_all_things_nature.stack<4&buff.balance_of_all_things_arcane.stack<4&(!dot.adaptive_swarm_damage.ticking&!action.adaptive_swarm_damage.in_flight&(!dot.adaptive_swarm_heal.ticking|dot.adaptive_swarm_heal.remains>3)|dot.adaptive_swarm_damage.stack<3&dot.adaptive_swarm_damage.remains<5&dot.adaptive_swarm_damage.ticking);
	if covenantId == Necrolord and
		cooldown[BL.AdaptiveSwarm].ready and
		not debuff[BL.AdaptiveSwarmAura].up
	then
		return BL.AdaptiveSwarm;
	end

	-- convoke_the_spirits,if=(variable.convoke_desync&!cooldown.ca_inc.ready|buff.ca_inc.up)&(buff.balance_of_all_things_nature.stack=5|buff.balance_of_all_things_arcane.stack=5)|fight_remains<10;
	--if cooldown[BL.ConvokeTheSpirits].ready and
	--	currentSpell ~= BL.ConvokeTheSpirits and
	--	(convokeDesync and not cooldown[CaInc].ready or buff[CaInc].up) and
	--	(buff[BL.BalanceOfAllThingsNature].count == 5 or buff[BL.BalanceOfAllThingsArcane].count == 5)
	--then
	--	return BL.ConvokeTheSpirits;
	--end

	-- cancel_buff,name=starlord,if=(buff.balance_of_all_things_nature.remains>4.5|buff.balance_of_all_things_arcane.remains>4.5)&astral_power>=90&(cooldown.ca_inc.remains>7|(cooldown.empower_bond.remains>7&!buff.kindred_empowerment_energize.up&covenant.kyrian));
	--if (buff[BL.BalanceOfAllThingsNature].remains > 4.5 or buff[BL.BalanceOfAllThingsArcane].remains > 4.5) and lunarPower >= 90 and (cooldown[CaInc].remains > 7 or (cooldown[BL.EmpowerBond].remains > 7 and not buff[BL.KindredEmpowermentEnergize].up and covenantId == Kyrian)) then
	--	return starlord;
	--end

	-- starsurge,if=!variable.critnotup&(covenant.night_fae|cooldown.ca_inc.remains>7|!variable.cd_condition&!covenant.kyrian|(cooldown.empower_bond.remains>7&!buff.kindred_empowerment_energize.up&covenant.kyrian));
	if canStarsurge and
		not critnotup --and
		--(
		--	covenantId == NightFae or
		--	cooldown[CaInc].remains > 7 or
		--	not covenantId == Kyrian or
		--	(cooldown[BL.EmpowerBond].remains > 7 and not buff[BL.KindredEmpowermentEnergize].up and covenantId == Kyrian)
		--)
	then
		return BL.Starsurge;
	end

	-- starsurge,if=(cooldown.convoke_the_spirits.remains<5&(variable.convoke_desync|cooldown.ca_inc.remains<5))&astral_power>40&covenant.night_fae;
	if canStarsurge and
		(cooldown[BL.ConvokeTheSpirits].remains < 5 and (convokeDesync or cooldown[CaInc].remains < 5)) and
		covenantId == NightFae
	then
		return BL.Starsurge;
	end

	-- sunfire,target_if=refreshable&target.time_to_die>16,if=ap_check&(variable.critnotup|(astral_power<30&!buff.ca_inc.up)|cooldown.ca_inc.ready);
	if debuff[BL.SunfireAura].refreshable and
		(critnotup or (lunarPower < 30 and not buff[CaInc].up) or cooldown[CaInc].ready)
	then
		return BL.Sunfire;
	end

	-- moonfire,target_if=refreshable&target.time_to_die>13.5,if=ap_check&(variable.critnotup|(astral_power<30&!buff.ca_inc.up)|cooldown.ca_inc.ready)&!buff.kindred_empowerment_energize.up;
	if debuff[BL.MoonfireAura].refreshable and
		(critnotup or (lunarPower < 30 and not buff[CaInc].up) or cooldown[CaInc].ready) and
		not buff[BL.KindredEmpowermentEnergize].up
	then
		return BL.Moonfire;
	end

	-- stellar_flare,target_if=refreshable&target.time_to_die>16+remains,if=ap_check&(variable.critnotup|astral_power<30|cooldown.ca_inc.ready);
	if talents[BL.StellarFlare] and
		debuff[BL.StellarFlare].refreshable and
		currentSpell ~= BL.StellarFlare and
		(critnotup or lunarPower < 30 or cooldown[CaInc].ready)
	then
		return BL.StellarFlare;
	end

	-- force_of_nature,if=ap_check;
	--if cooldown[BL.ForceOfNature].ready then
	--	return BL.ForceOfNature;
	--end

	-- fury_of_elune,if=(eclipse.in_any|eclipse.solar_in_1|eclipse.lunar_in_1)&(!covenant.night_fae|(astral_power<95&(variable.critnotup|astral_power<30|variable.is_aoe)&(variable.convoke_desync&!cooldown.convoke_the_spirits.up|!variable.convoke_desync&!cooldown.ca_inc.up)))&(cooldown.ca_inc.remains>30|astral_power>90&cooldown.ca_inc.up&(cooldown.empower_bond.remains<action.starfire.execute_time|!covenant.kyrian)|interpolated_fight_remains<10)&(dot.adaptive_swarm_damage.remains>4|!covenant.necrolord);
	if talents[BL.FuryOfElune] and
		cooldown[BL.FuryOfElune].ready and
		(eclipseInAny) --and --  or eclipseSolarIn1 or eclipseLunarIn1
		--(
		--	not covenantId == NightFae or
		--	(
		--		lunarPower < 95 and
		--		(critnotup or lunarPower < 30 or isAoe) and
		--		(convokeDesync and not cooldown[BL.ConvokeTheSpirits].up or not convokeDesync and not cooldown[CaInc].up)
		--	)
		--) and
		--(
		--	cooldown[CaInc].remains > 30 or
		--	lunarPower > 90 and cooldown[CaInc].up and (cooldown[BL.EmpowerBond].remains < timeShift or not covenantId == Kyrian)
		--) and
		--(debuff[BL.AdaptiveSwarmAura].remains > 4 or not covenantId == Necrolord)
	then
		return BL.FuryOfElune;
	end

	-- kindred_spirits,if=(eclipse.lunar_next|eclipse.solar_next|eclipse.any_next|buff.balance_of_all_things_nature.remains>4.5|buff.balance_of_all_things_arcane.remains>4.5|astral_power>90&cooldown.ca_inc.ready)&(cooldown.ca_inc.remains>30|cooldown.ca_inc.ready)|interpolated_fight_remains<10;
	--if currentSpell ~= BL.KindredSpirits and (
	--	(
	--		eclipseLunarNext or
	--			eclipseSolarNext or
	--			eclipseAnyNext or
	--			buff[BL.BalanceOfAllThingsNature].remains > 4.5 or
	--			buff[BL.BalanceOfAllThingsArcane].remains > 4.5 or
	--			lunarPower > 90 and cooldown[CaInc].ready
	--	) and (
	--		cooldown[CaInc].remains > 30 or
	--			cooldown[CaInc].ready
	--	)
	--) then
	--	return BL.KindredSpirits;
	--end

	-- celestial_alignment,if=variable.cd_condition&(astral_power>90&(buff.kindred_empowerment_energize.up|!covenant.kyrian)|covenant.night_fae|buff.bloodlust.up&buff.bloodlust.remains<20+(conduit.precise_alignment.time_value))&(variable.convoke_desync|cooldown.convoke_the_spirits.ready)|interpolated_fight_remains<20+(conduit.precise_alignment.time_value);
	--if cooldown[BL.CelestialAlignment].ready and (
	--	cdCondition and
	--		(
	--			lunarPower > 90 and
	--				(buff[BL.KindredEmpowermentEnergize].up or not covenantId == Kyrian) or
	--				covenantId == NightFae
	--		) and (
	--		convokeDesync or
	--			cooldown[BL.ConvokeTheSpirits].ready
	--	)
	--) then
	--	return BL.CelestialAlignment;
	--end

	-- incarnation,if=variable.cd_condition&(astral_power>90&(buff.kindred_empowerment_energize.up|!covenant.kyrian)|covenant.night_fae|buff.bloodlust.up&buff.bloodlust.remains<30+(conduit.precise_alignment.time_value))&(variable.convoke_desync|cooldown.convoke_the_spirits.ready)|interpolated_fight_remains<30+(conduit.precise_alignment.time_value);
	--if talents[BL.Incarnation] and
	--	cooldown[BL.Incarnation].ready and
	--	(
	--		cdCondition and (
	--			lunarPower > 90 and (buff[BL.KindredEmpowermentEnergize].up or not covenantId == Kyrian) or
	--				covenantId == NightFae or
	--				buff[BL.Bloodlust].up and buff[BL.Bloodlust].remains <
	--					30 + (conduit[BL.PreciseAlignment])
	--		) and (
	--			convokeDesync or cooldown[BL.ConvokeTheSpirits].ready
	--		)
	--	) then
	--	return BL.Incarnation;
	--end

	-- variable,name=aspPerSec,value=eclipse.in_lunar*8%action.starfire.execute_time+!eclipse.in_lunar*6%action.wrath.execute_time+0.2%spell_haste;
	local aspPerSec = (eclipseInLunar and 1 or 0) * 8 / 2 +
		(eclipseInLunar and 0 or 1) * 6 / 1.3 +
		0.2 / spellHaste;

	-- starsurge,if=(interpolated_fight_remains<4|(buff.ravenous_frenzy.remains<gcd.max*ceil(astral_power%30)&buff.ravenous_frenzy.up))|(astral_power+variable.aspPerSec*buff.eclipse_solar.remains+dot.fury_of_elune.ticks_remain*2.5>120|astral_power+variable.aspPerSec*buff.eclipse_lunar.remains+dot.fury_of_elune.ticks_remain*2.5>120)&eclipse.in_any&((!cooldown.ca_inc.up|covenant.kyrian&!cooldown.empower_bond.up)|covenant.night_fae)&(!covenant.venthyr|!buff.ca_inc.up|astral_power>90)|buff.ca_inc.remains>8&!buff.ravenous_frenzy.up;
	if lunarPower >= 40 and (
		--(
		--	buff[BL.RavenousFrenzy].remains < gcd * math.ceil(lunarPower / 30) and
		--	buff[BL.RavenousFrenzy].up
		--) or
		--	(lunarPower + aspPerSec * buff[BL.EclipseSolar].remains + debuff[BL.FuryOfElune].ticksRemain * 2.5 > 120 or
		--	lunarPower + aspPerSec * buff[BL.EclipseLunar].remains + debuff[BL.FuryOfElune].ticksRemain * 2.5 > 120)
		--		and
			eclipseInAny --and
			--(
			--	(not cooldown[CaInc].up or covenantId == Kyrian and not cooldown[BL.EmpowerBond].ready) or
			--		covenantId == NightFae
			--) and (
			--	not covenantId == Venthyr or
			--	not buff[CaInc].up or
			--	lunarPower > 90
			--) or
			--buff[CaInc].remains > 8 and
			--not buff[BL.RavenousFrenzy].up
	) then
		return BL.Starsurge;
	end

	-- new_moon,if=(buff.eclipse_lunar.up|(charges=2&recharge_time<5)|charges=3)&ap_check;
	-- half_moon,if=(buff.eclipse_lunar.up|(charges=2&recharge_time<5)|charges=3)&ap_check;
	-- full_moon,if=(buff.eclipse_lunar.up|(charges=2&recharge_time<5)|charges=3)&ap_check;
	if talents[BL.NewMoon] then
		local newMoonCharges = cooldown[BL.NewMoon].charges;
		if castingMoonSpell then newMoonCharges = newMoonCharges - 1; end

		if newMoonCharges >= 1 and buff[BL.EclipseLunar].up or
			(newMoonCharges >= 2 and cooldown[BL.NewMoon].partialRecharge < 5) or
			newMoonCharges >= 3
		then
			return MoonPhase;
		end
	end

	-- warrior_of_elune;
	if talents[BL.WarriorOfElune] and cooldown[BL.WarriorOfElune].ready then
		return BL.WarriorOfElune;
	end

	-- starfire,if=eclipse.in_lunar|eclipse.solar_next|eclipse.any_next|buff.warrior_of_elune.up&buff.eclipse_lunar.up|(buff.ca_inc.remains<action.wrath.execute_time&buff.ca_inc.up);
	if --currentSpell ~= BL.Starfire and
	(
			eclipseInLunar or
			--eclipseSolarNext or
			--eclipseAnyNext or
			starfireCount > 0 or
			buff[BL.WarriorOfElune].up and buff[BL.EclipseLunar].up or
			(buff[CaInc].remains < timeShift and buff[CaInc].up)
	)
	then
		return BL.Starfire;
	end

	-- wrath;
	return BL.Wrath;
	--if currentSpell ~= BL.Wrath then
	--	return BL.Wrath;
	--end
	--
	---- run_action_list,name=fallthru;
	--return Druid:BalanceFallthru();
end

function Druid:BalanceDreambinder()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local gcd = fd.gcd;
	local timeToDie = fd.timeToDie;
	local covenantId = fd.covenant.covenantId;
	local lunarPower = fd.lunarPower;
	local CaInc = fd.CaInc;
	local castingMoonSpell = fd.castingMoonSpell;
	local MoonPhase = fd.MoonPhase;

	local eclipseInAny = fd.eclipseInAny;
	local eclipseInLunar = fd.eclipseInLunar;
	local eclipseInSolar = fd.eclipseInSolar;
	local eclipseInBoth = fd.eclipseInBoth;
	local eclipseSolarNext = fd.eclipseSolarNext;
	local eclipseLunarNext = fd.eclipseLunarNext;
	local eclipseAnyNext = fd.eclipseAnyNext;
	local convokeDesync = fd.convokeDesync;
	local starfireCount = fd.starfireCount;


	local canStarfall = lunarPower >= 50 or buff[BL.OnethsPerception].up;
	local canStarsurge = lunarPower >= 30 or buff[BL.OnethsClearVision].up;

	-- variable,name=safe_to_use_spell,value=(buff.timeworn_dreambinder.remains>gcd.max+0.1&(eclipse.in_both|eclipse.in_solar|eclipse.lunar_next)|buff.timeworn_dreambinder.remains>action.starfire.execute_time+0.1&(eclipse.in_lunar|eclipse.solar_next|eclipse.any_next))|!buff.timeworn_dreambinder.up;
	local safeToUseSpell = (
		buff[BL.TimewornDreambinder].remains > gcd + 0.1 and (eclipseInBoth or eclipseInSolar or eclipseLunarNext) or
			buff[BL.TimewornDreambinder].remains > timeShift + 0.1 and (eclipseInLunar or eclipseSolarNext or eclipseAnyNext)) or
		not buff[BL.TimewornDreambinder].up
	;

	-- starsurge,if=(!variable.safe_to_use_spell|(buff.ravenous_frenzy.remains<gcd.max*ceil(astral_power%30)&buff.ravenous_frenzy.up))|astral_power>90;
	if canStarsurge and (
		(
			not safeToUseSpell or
			(buff[BL.RavenousFrenzy].remains < gcd * math.ceil(lunarPower / 30) and buff[BL.RavenousFrenzy].up)
		) or
			lunarPower > 80
	) then
		return BL.Starsurge;
	end

	-- convoke_the_spirits,if=(variable.convoke_desync&interpolated_fight_remains>130&!cooldown.ca_inc.ready|buff.ca_inc.up)&astral_power<40&(buff.eclipse_lunar.remains>10|buff.eclipse_solar.remains>10)|fight_remains<10;
	--if cooldown[BL.ConvokeTheSpirits].ready and
	--	currentSpell ~= BL.ConvokeTheSpirits and
	--	(
	--		(convokeDesync and 130 and not cooldown[CaInc].ready or buff[CaInc].up) and
	--			lunarPower < 40 and
	--			(buff[BL.EclipseLunar].remains > 10 or buff[BL.EclipseSolar].remains > 10)
	--	)
	--then
	--	return BL.ConvokeTheSpirits;
	--end

	-- adaptive_swarm,target_if=!dot.adaptive_swarm_damage.ticking&!action.adaptive_swarm_damage.in_flight&(!dot.adaptive_swarm_heal.ticking|dot.adaptive_swarm_heal.remains>5)|dot.adaptive_swarm_damage.stack<3&dot.adaptive_swarm_damage.remains<3&dot.adaptive_swarm_damage.ticking;
	if covenantId == Necrolord and cooldown[BL.AdaptiveSwarm].ready and not debuff[BL.AdaptiveSwarmAura].up then
		return BL.AdaptiveSwarm;
	end

	-- moonfire,target_if=refreshable&target.time_to_die>12,if=(buff.ca_inc.remains>5&(buff.ravenous_frenzy.remains>5|!buff.ravenous_frenzy.up)|!buff.ca_inc.up|astral_power<30)&(!buff.kindred_empowerment_energize.up|astral_power<30)&ap_check;
	if debuff[BL.MoonfireAura].refreshable and
		(
			buff[CaInc].remains > 5 and (buff[BL.RavenousFrenzy].remains > 5 or not buff[BL.RavenousFrenzy].up) or
			not buff[CaInc].up or
			lunarPower < 30
		) and (
			not buff[BL.KindredEmpowermentEnergize].up or lunarPower < 30
		)
	then
		return BL.Moonfire;
	end

	-- sunfire,target_if=refreshable&target.time_to_die>12,if=(buff.ca_inc.remains>5&(buff.ravenous_frenzy.remains>5|!buff.ravenous_frenzy.up)|!buff.ca_inc.up|astral_power<30)&(!buff.kindred_empowerment_energize.up|astral_power<30)&ap_check;
	if debuff[BL.SunfireAura].refreshable and
		(
			buff[CaInc].remains > 5 and (buff[BL.RavenousFrenzy].remains > 5 or not buff[BL.RavenousFrenzy].up) or
			not buff[CaInc].up or
			lunarPower < 30
		) and (
			not buff[BL.KindredEmpowermentEnergize].up or lunarPower < 30
		)
	then
		return BL.Sunfire;
	end

	-- stellar_flare,target_if=refreshable&target.time_to_die>16,if=(buff.ca_inc.remains>5&(buff.ravenous_frenzy.remains>5|!buff.ravenous_frenzy.up)|!buff.ca_inc.up|astral_power<30)&(!buff.kindred_empowerment_energize.up|astral_power<30)&ap_check;
	if talents[BL.StellarFlare] and
		debuff[BL.StellarFlare].refreshable and
		currentSpell ~= BL.StellarFlare and
		(
			buff[CaInc].remains > 5 and (buff[BL.RavenousFrenzy].remains > 5 or not buff[BL.RavenousFrenzy].up) or
			not buff[CaInc].up or
			lunarPower < 30
		) and (
			not buff[BL.KindredEmpowermentEnergize].up or lunarPower < 30
		)
	then
		return BL.StellarFlare;
	end

	-- force_of_nature,if=ap_check;
	--if cooldown[BL.ForceOfNature].ready then
	--	return BL.ForceOfNature;
	--end

	-- ravenous_frenzy,if=buff.ca_inc.up;
	--if buff[CaInc].up then
	--	return BL.RavenousFrenzy;
	--end

	-- kindred_spirits,if=((buff.eclipse_solar.remains>10|buff.eclipse_lunar.remains>10)&cooldown.ca_inc.remains>30)|cooldown.ca_inc.ready;
	--if currentSpell ~= BL.KindredSpirits and (
	--	(
	--		(buff[BL.EclipseSolar].remains > 10 or buff[BL.EclipseLunar].remains > 10) and
	--		cooldown[CaInc].remains > 30
	--	) or cooldown[CaInc].ready
	--) then
	--	return BL.KindredSpirits;
	--end

	-- celestial_alignment,if=variable.cd_condition&((buff.kindred_empowerment_energize.up|!covenant.kyrian)|covenant.night_fae|variable.is_aoe|buff.bloodlust.up&buff.bloodlust.remains<20+(conduit.precise_alignment.time_value))&!buff.ca_inc.up&(!covenant.night_fae|cooldown.convoke_the_spirits.up|interpolated_fight_remains<cooldown.convoke_the_spirits.remains+6|interpolated_fight_remains%%180<20+(conduit.precise_alignment.time_value));
	--if cooldown[BL.CelestialAlignment].ready and (
	--	(
	--		(buff[BL.KindredEmpowermentEnergize].up or not covenantId == Kyrian) or
	--			covenantId == NightFae or
	--			isAoe or
	--			buff[BL.Bloodlust].up and buff[BL.Bloodlust].remains < 20 + (conduit[BL.PreciseAlignment])
	--	) and
	--		not buff[CaInc].up and
	--		(not covenantId == NightFae or cooldown[BL.ConvokeTheSpirits].up or cooldown[BL.ConvokeTheSpirits].remains + 6)
	--) then
	--	return BL.CelestialAlignment;
	--end

	-- incarnation,if=variable.cd_condition&((buff.kindred_empowerment_energize.up|!covenant.kyrian)|covenant.night_fae|variable.is_aoe|buff.bloodlust.up&buff.bloodlust.remains<30+(conduit.precise_alignment.time_value))&!buff.ca_inc.up&(!covenant.night_fae|cooldown.convoke_the_spirits.up|interpolated_fight_remains<cooldown.convoke_the_spirits.remains+6|interpolated_fight_remains%%180<30+(conduit.precise_alignment.time_value));
	--if talents[BL.Incarnation] and
	--	cooldown[BL.Incarnation].ready and
	--	(
	--		((buff[BL.KindredEmpowermentEnergize].up or not covenantId == Kyrian) or
	--			covenantId == NightFae or
	--			isAoe or
	--				buff[BL.Bloodlust].up and
	--				buff[BL.Bloodlust].remains < 30 + (conduit[BL.PreciseAlignment])) and
	--				not buff[CaInc].up and
	--				(not covenantId == NightFae or cooldown[BL.ConvokeTheSpirits].up or cooldown[BL.ConvokeTheSpirits].remains + 6)
	--	)
	--then
	--	return BL.Incarnation;
	--end

	-- variable,name=save_for_ca_inc,value=(!cooldown.ca_inc.ready|!variable.convoke_desync&covenant.night_fae);
	local saveForCaInc = (not cooldown[CaInc].ready or not convokeDesync and covenantId == NightFae);

	-- fury_of_elune,if=eclipse.in_any&ap_check&(dot.adaptive_swarm_damage.ticking|!covenant.necrolord)&variable.save_for_ca_inc;
	if talents[BL.FuryOfElune] and cooldown[BL.FuryOfElune].ready and (
		eclipseInAny --and
		--(debuff[BL.AdaptiveSwarmAura].up or not covenantId == Necrolord) and
		--saveForCaInc
	) then
		return BL.FuryOfElune;
	end

	-- starsurge,if=covenant.night_fae&variable.convoke_desync&astral_power>=40&cooldown.convoke_the_spirits.remains<gcd.max*ceil(astral_power%30);
	if canStarsurge and (
		covenantId == NightFae and
		convokeDesync and
		lunarPower >= 40 and
		cooldown[BL.ConvokeTheSpirits].remains < gcd * math.ceil(lunarPower / 30)
	) then
		return BL.Starsurge;
	end

	-- new_moon,if=(buff.eclipse_lunar.up|(charges=2&recharge_time<5)|charges=3)&ap_check&variable.save_for_ca_inc;
	-- half_moon,if=(buff.eclipse_lunar.up&!covenant.kyrian|(buff.kindred_empowerment_energize.up&covenant.kyrian)|(charges=2&recharge_time<5)|charges=3|buff.ca_inc.up)&ap_check&variable.save_for_ca_inc;
	-- full_moon,if=(buff.eclipse_lunar.up&!covenant.kyrian|(buff.kindred_empowerment_energize.up&covenant.kyrian)|(charges=2&recharge_time<5)|charges=3|buff.ca_inc.up)&ap_check&variable.save_for_ca_inc;
	if talents[BL.NewMoon] then
		local newMoonCharges = cooldown[BL.NewMoon].charges;
		if castingMoonSpell then newMoonCharges = newMoonCharges - 1; end

		if newMoonCharges >= 1 and buff[BL.EclipseLunar].up or
			(newMoonCharges >= 2 and cooldown[BL.NewMoon].partialRecharge < 5) or
			newMoonCharges >= 3
		then
			return MoonPhase;
		end
	end

	-- warrior_of_elune;
	if talents[BL.WarriorOfElune] and cooldown[BL.WarriorOfElune].ready then
		return BL.WarriorOfElune;
	end

	-- starfire,if=eclipse.in_lunar|eclipse.solar_next|eclipse.any_next|buff.warrior_of_elune.up&buff.eclipse_lunar.up|(buff.ca_inc.remains<action.wrath.execute_time&buff.ca_inc.up);
	if --currentSpell ~= BL.Starfire and
	(
		eclipseInLunar or
		--eclipseSolarNext or
		--eclipseAnyNext or
		starfireCount > 0 or
		buff[BL.WarriorOfElune].up and buff[BL.EclipseLunar].up or
		(buff[CaInc].remains < timeShift and buff[CaInc].up)
	)
	then
		return BL.Starfire;
	end

	-- wrath;
	return BL.Wrath;
end

function Druid:BalanceFallthru()
	local fd = MaxDps.FrameData;
	local runeforge = fd.runeforge;
	local lunarPower = fd.lunarPower;
	local debuff = fd.debuff;

	-- starsurge,if=!runeforge.balance_of_all_things.equipped;
	if lunarPower >= 40 and not runeforge[BL.BalanceOfAllThingsBonusId] then
		return BL.Starsurge;
	end

	-- sunfire,target_if=dot.moonfire.remains>remains;
	if debuff[BL.SunfireAura].refreshable then
		return BL.Sunfire;
	end

	-- moonfire;
	return BL.Moonfire;
end

function Druid:BalanceSt()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local gcd = fd.gcd;
	local timeToDie = fd.timeToDie;
	local covenantId = fd.covenant.covenantId;
	local lunarPower = fd.lunarPower;
	local CaInc = fd.CaInc;
	local isAoe = fd.isAoe;
	local convokeDesync = fd.convokeDesync;
	local runeforge = fd.runeforge;
	local MoonPhase = fd.MoonPhase;
	local castingMoonSpell = fd.castingMoonSpell;

	local eclipseInLunar = fd.eclipseInLunar;
	local eclipseInSolar = fd.eclipseInSolar;
	local eclipseSolarNext = fd.eclipseSolarNext;
	local eclipseAnyNext = fd.eclipseAnyNext;
	local eclipseInAny = fd.eclipseInAny;
	local starfireCount = fd.starfireCount;

	local canStarfall = lunarPower >= 50 or buff[BL.OnethsPerception].up;
	local canStarsurge = lunarPower >= 30 or buff[BL.OnethsClearVision].up;

	-- adaptive_swarm,target_if=!dot.adaptive_swarm_damage.ticking&!action.adaptive_swarm_damage.in_flight&(!dot.adaptive_swarm_heal.ticking|dot.adaptive_swarm_heal.remains>5)|dot.adaptive_swarm_damage.stack<3&dot.adaptive_swarm_damage.remains<3&dot.adaptive_swarm_damage.ticking;
	if covenantId == Necrolord and cooldown[BL.AdaptiveSwarm].ready and not debuff[BL.AdaptiveSwarmAura].up then
		return BL.AdaptiveSwarm;
	end

	-- convoke_the_spirits,if=(variable.convoke_desync&!cooldown.ca_inc.ready|buff.ca_inc.up)&astral_power<40&(buff.eclipse_lunar.remains>10|buff.eclipse_solar.remains>10)|fight_remains<10;
	--if cooldown[BL.ConvokeTheSpirits].ready and
	--	currentSpell ~= BL.ConvokeTheSpirits and
	--	(
	--		(convokeDesync and not cooldown[CaInc].ready or buff[CaInc].up) and
	--		lunarPower < 40 and
	--		(buff[BL.EclipseLunar].remains > 10 or buff[BL.EclipseSolar].remains > 10)
	--	)
	--then
	--	return BL.ConvokeTheSpirits;
	--end

	-- variable,name=dot_requirements,value=(buff.ca_inc.remains>5&(buff.ravenous_frenzy.remains>5|!buff.ravenous_frenzy.up)|!buff.ca_inc.up|astral_power<30)&(!buff.kindred_empowerment_energize.up|astral_power<30)&(buff.eclipse_solar.remains>gcd.max|buff.eclipse_lunar.remains>gcd.max);
	local dotRequirements =
		--(
		--buff[CaInc].remains > 5 and (buff[BL.RavenousFrenzy].remains > 5 or not buff[BL.RavenousFrenzy].up) or
		--	not buff[CaInc].up or lunarPower < 30) and
		--(not buff[BL.KindredEmpowermentEnergize].up or lunarPower < 30) and
		(buff[BL.EclipseSolar].remains > 2 or buff[BL.EclipseLunar].remains > 2)
	;

	-- moonfire,target_if=refreshable&target.time_to_die>12,if=ap_check&variable.dot_requirements;
	if debuff[BL.MoonfireAura].refreshable and dotRequirements then
		return BL.Moonfire;
	end

	-- sunfire,target_if=refreshable&target.time_to_die>12,if=ap_check&variable.dot_requirements;
	if debuff[BL.SunfireAura].refreshable and dotRequirements then
		return BL.Sunfire;
	end

	-- stellar_flare,target_if=refreshable&target.time_to_die>16,if=ap_check&variable.dot_requirements;
	if talents[BL.StellarFlare] and
		debuff[BL.StellarFlare].refreshable and
		currentSpell ~= BL.StellarFlare and
		dotRequirements
	then
		return BL.StellarFlare;
	end

	-- force_of_nature,if=ap_check;
	--if cooldown[BL.ForceOfNature].ready then
	--	return BL.ForceOfNature;
	--end

	-- ravenous_frenzy,if=buff.ca_inc.up;
	--if buff[CaInc].up then
	--	return BL.RavenousFrenzy;
	--end

	local primordialArcanicPulsarValue = Druid:PrimordialArcanicPulsarValue();
	-- kindred_spirits,if=((buff.eclipse_solar.remains>10|buff.eclipse_lunar.remains>10)&cooldown.ca_inc.remains>30&(buff.primordial_arcanic_pulsar.value<240|!runeforge.primordial_arcanic_pulsar.equipped))|buff.primordial_arcanic_pulsar.value>=270|cooldown.ca_inc.ready&(astral_power>90|variable.is_aoe);
	--if currentSpell ~= BL.KindredSpirits and (
	--	(
	--		(buff[BL.EclipseSolar].remains > 10 or buff[BL.EclipseLunar].remains > 10) and
	--		cooldown[CaInc].remains > 30 and
	--		(primordialArcanicPulsarValue < 240 or not runeforge[BL.PrimordialArcanicPulsarBonusId])
	--	) or primordialArcanicPulsarValue >= 270 or
	--		cooldown[CaInc].ready and (lunarPower > 90 or isAoe)
	--)
	--then
	--	return BL.KindredSpirits;
	--end

	-- celestial_alignment,if=variable.cd_condition&(astral_power>90&(buff.kindred_empowerment_energize.up|!covenant.kyrian)|covenant.night_fae|variable.is_aoe|buff.bloodlust.up&buff.bloodlust.remains<20+((9*runeforge.primordial_arcanic_pulsar.equipped)+(conduit.precise_alignment.time_value)))&!buff.ca_inc.up&(!covenant.night_fae|cooldown.convoke_the_spirits.up|interpolated_fight_remains<cooldown.convoke_the_spirits.remains+6|interpolated_fight_remains%%180<20+(conduit.precise_alignment.time_value));
	--if cooldown[BL.CelestialAlignment].ready and (
	--	(lunarPower > 90 and (buff[BL.KindredEmpowermentEnergize].up or not covenantId == Kyrian) or
	--		covenantId == NightFae or
	--		isAoe or
	--		buff[BL.Bloodlust].up and
	--			buff[BL.Bloodlust].remains < 20 + ((9 * runeforge[BL.PrimordialArcanicPulsar]) + (conduit[BL.PreciseAlignment]))) and
	--		not buff[CaInc].up and
	--		(
	--			not covenantId == NightFae or
	--			cooldown[BL.ConvokeTheSpirits].up or
	--			cooldown[BL.ConvokeTheSpirits].remains + 6
	--		)
	--) then
	--	return BL.CelestialAlignment;
	--end

	-- incarnation,if=variable.cd_condition&(astral_power>90&(buff.kindred_empowerment_energize.up|!covenant.kyrian)|covenant.night_fae|variable.is_aoe|buff.bloodlust.up&buff.bloodlust.remains<30+((9*runeforge.primordial_arcanic_pulsar.equipped)+(conduit.precise_alignment.time_value)))&!buff.ca_inc.up&(!covenant.night_fae|cooldown.convoke_the_spirits.up|interpolated_fight_remains<cooldown.convoke_the_spirits.remains+6|interpolated_fight_remains%%180<30+(conduit.precise_alignment.time_value));
	--if talents[BL.Incarnation] and
	--	cooldown[BL.Incarnation].ready and
	--	(
	--		cdCondition and
	--			(lunarPower > 90 and (buff[BL.KindredEmpowermentEnergize].up or not covenantId == Kyrian) or
	--				covenantId == NightFae or
	--				isAoe or
	--				buff[BL.Bloodlust].up and buff[BL.Bloodlust].remains
	--					<
	--					30 + ((9 * runeforge[BL.PrimordialArcanicPulsar]) + (conduit[BL.PreciseAlignment]))
	--			) and
	--			not buff[CaInc].up and
	--			(not covenantId == NightFae or cooldown[BL.ConvokeTheSpirits].up or cooldown[BL.ConvokeTheSpirits].remains + 6)
	--	)
	--then
	--	return BL.Incarnation;
	--end

	-- variable,name=save_for_ca_inc,value=(!cooldown.ca_inc.ready|!variable.convoke_desync&covenant.night_fae);
	local saveForCaInc = (not cooldown[CaInc].ready or not convokeDesync and covenantId == NightFae);

	-- fury_of_elune,if=eclipse.in_any&ap_check&buff.primordial_arcanic_pulsar.value<240&(dot.adaptive_swarm_damage.ticking|!covenant.necrolord)&variable.save_for_ca_inc;
	if talents[BL.FuryOfElune] and cooldown[BL.FuryOfElune].ready and
		eclipseInAny and
		primordialArcanicPulsarValue < 240 -- and
		--(debuff[BL.AdaptiveSwarmAura].up or not covenantId == Necrolord) and
		--saveForCaInc
	then
		return BL.FuryOfElune;
	end

	-- starfall,if=buff.oneths_perception.up&buff.starfall.refreshable;
	if buff[BL.OnethsPerception].up and buff[BL.Starfall].refreshable then
		return BL.Starfall;
	end

	-- cancel_buff,name=starlord,if=buff.starlord.remains<5&(buff.eclipse_solar.remains>5|buff.eclipse_lunar.remains>5)&astral_power>90;
	--if buff[BL.Starlord].remains < 5 and (buff[BL.EclipseSolar].remains > 5 or buff[BL.EclipseLunar].remains > 5) and lunarPower > 90 then
	--	return starlord;
	--end

	-- starsurge,if=covenant.night_fae&variable.convoke_desync&cooldown.convoke_the_spirits.remains<5;
	if canStarsurge and
		covenantId == NightFae and
		convokeDesync and
		cooldown[BL.ConvokeTheSpirits].remains < 5
	then
		return BL.Starsurge;
	end

	-- starfall,if=talent.stellar_drift.enabled&!talent.starlord.enabled&buff.starfall.refreshable&(buff.eclipse_lunar.remains>6&eclipse.in_lunar&buff.primordial_arcanic_pulsar.value<250|buff.primordial_arcanic_pulsar.value>=250&astral_power>90|dot.adaptive_swarm_damage.remains>8|action.adaptive_swarm_damage.in_flight)&!cooldown.ca_inc.ready;
	if canStarfall and (
		talents[BL.StellarDrift] and
		not talents[BL.Starlord] and
		buff[BL.Starfall].refreshable and
		(
			buff[BL.EclipseLunar].remains > 6 and eclipseInLunar and primordialArcanicPulsarValue < 250 or
			primordialArcanicPulsarValue >= 250 and lunarPower > 90 or
			debuff[BL.AdaptiveSwarmAura].remains > 8
		) --and
		--not cooldown[CaInc].ready
	) then
		return BL.Starfall;
	end

	-- starsurge,if=buff.oneths_clear_vision.up|buff.kindred_empowerment_energize.up|buff.ca_inc.up&(buff.ravenous_frenzy.remains<gcd.max*ceil(astral_power%30)&buff.ravenous_frenzy.up|!buff.ravenous_frenzy.up&!cooldown.ravenous_frenzy.ready|!covenant.venthyr)|astral_power>90&eclipse.in_any;
	if canStarsurge and (
		buff[BL.OnethsClearVision].up or
		buff[BL.KindredEmpowermentEnergize].up or
		buff[CaInc].up and (
			buff[BL.RavenousFrenzy].remains < gcd * math.ceil(lunarPower / 30) and buff[BL.RavenousFrenzy].up or
			not buff[BL.RavenousFrenzy].up and not cooldown[BL.RavenousFrenzy].ready or
			not covenantId == Venthyr
		) or
		lunarPower > 80 and eclipseInAny
	) then
		return BL.Starsurge;
	end

	-- starsurge,if=talent.starlord.enabled&(buff.starlord.up|astral_power>90)&buff.starlord.stack<3&(buff.eclipse_solar.up|buff.eclipse_lunar.up)&buff.primordial_arcanic_pulsar.value<270&(cooldown.ca_inc.remains>10|!variable.convoke_desync&covenant.night_fae);
	if canStarsurge and
		talents[BL.Starlord] and
		(buff[BL.Starlord].up or lunarPower > 80) and
		buff[BL.Starlord].count < 3 and
		(buff[BL.EclipseSolar].up or buff[BL.EclipseLunar].up) and
		primordialArcanicPulsarValue < 270 and
		(cooldown[CaInc].remains > 10 or not convokeDesync and covenantId == NightFae)
	then
		return BL.Starsurge;
	end

	-- starsurge,if=(buff.primordial_arcanic_pulsar.value<270|buff.primordial_arcanic_pulsar.value<250&talent.stellar_drift.enabled)&buff.eclipse_solar.remains>7&eclipse.in_solar&!buff.oneths_perception.up&!talent.starlord.enabled&cooldown.ca_inc.remains>7&(cooldown.kindred_spirits.remains>7|!covenant.kyrian);
	if canStarsurge and
		(
			primordialArcanicPulsarValue < 270 or
			primordialArcanicPulsarValue < 250 and talents[BL.StellarDrift]
		) and
		buff[BL.EclipseSolar].remains > 7 and
		eclipseInSolar and
		not buff[BL.OnethsPerception].up and
		not talents[BL.Starlord] --and
		--cooldown[CaInc].remains > 7 and
		--(cooldown[BL.KindredSpirits].remains > 7 or not covenantId == Kyrian)
	then
		return BL.Starsurge;
	end

	-- new_moon,if=(buff.eclipse_lunar.up|(charges=2&recharge_time<5)|charges=3)&ap_check&variable.save_for_ca_inc;
	-- half_moon,if=(buff.eclipse_lunar.up&!covenant.kyrian|(buff.kindred_empowerment_energize.up&covenant.kyrian)|(charges=2&recharge_time<5)|charges=3|buff.ca_inc.up)&ap_check&variable.save_for_ca_inc;
	-- full_moon,if=(buff.eclipse_lunar.up&!covenant.kyrian|(buff.kindred_empowerment_energize.up&covenant.kyrian)|(charges=2&recharge_time<5)|charges=3|buff.ca_inc.up)&ap_check&variable.save_for_ca_inc;
	if talents[BL.NewMoon] then
		local newMoonCharges = cooldown[BL.NewMoon].charges;
		if castingMoonSpell then newMoonCharges = newMoonCharges - 1; end

		if newMoonCharges >= 1 and buff[BL.EclipseLunar].up or
			(newMoonCharges >= 2 and cooldown[BL.NewMoon].partialRecharge < 5) or
			newMoonCharges >= 3
		then
			return MoonPhase;
		end
	end

	-- warrior_of_elune;
	if talents[BL.WarriorOfElune] and cooldown[BL.WarriorOfElune].ready then
		return BL.WarriorOfElune;
	end

	-- starfire,if=eclipse.in_lunar|eclipse.solar_next|eclipse.any_next|buff.warrior_of_elune.up&buff.eclipse_lunar.up|(buff.ca_inc.remains<action.wrath.execute_time&buff.ca_inc.up);
	if --currentSpell ~= BL.Starfire and
		(
			eclipseInLunar or
			--eclipseSolarNext or
			--eclipseAnyNext or
			starfireCount > 0 or
			buff[BL.WarriorOfElune].up and buff[BL.EclipseLunar].up or
			(buff[CaInc].remains < timeShift and buff[CaInc].up)
		)
	then
		return BL.Starfire;
	end

	-- wrath;
	return BL.Wrath;
	--if currentSpell ~= BL.Wrath then
	--	return BL.Wrath;
	--end
	--
	---- run_action_list,name=fallthru;
	--return Druid:BalanceFallthru();
end

function Druid:PrimordialArcanicPulsarValue()
	local i = 1;
	while true do
		local name, _, _, _, _, _, _, _, _, id, _, _, _, _, _, value =
		UnitAura('player', i, 'HELPFUL');
		if not name then
			break;
		end

		if id == BL.PrimordialArcanicPulsar then
			return value;
		end

		i = i + 1;
	end

	return 0;
end