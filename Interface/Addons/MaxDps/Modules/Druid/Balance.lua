if select(2, UnitClass("player")) ~= "DRUID" then return end

local _, MaxDps_DruidTable = ...;

--- @type MaxDps
if not MaxDps then
	return
end

local MaxDps = MaxDps;
local UnitPower = UnitPower;
local LunarPower = Enum.PowerType.LunarPower;
local Druid = MaxDps_DruidTable.Druid;

--local BL = {
--	Moonfire                 = 8921,
--	Sunfire                  = 93402,
--	Starsurge                = 78674,
--	LunarEmpowerment         = 164547,
--	SolarEmpowerment         = 164545,
--	LunarStrike              = 194153,
--	SolarWrath               = 190984,
--	NewMoon                  = 202767,
--	CelestialAlignment       = 194223,
--	IncarnationChosenOfElune = 102560,
--	HalfMoon                 = 202768,
--	FullMoon                 = 202771,
--	StellarFlare             = 202347,
--	Starfall                 = 191034,
--	MasteryStarlight         = 77492,
--	StellarEmpowerment       = 197637,
--	Heroism                  = 32182,
--	Bloodlust                = 2825,
--	Berserking               = 26297,
--	ForceOfNature            = 205636,
--	WarriorOfElune           = 202425,
--	AstralCommunion          = 202359,
--	BlessingoftheAncients    = 202360,
--	BlessingofElune          = 202737,
--	FuryofElune              = 202770,
--	MoonfireAura             = 164812,
--	SunfireAura              = 164815,
--	WarriorOfEluneAura       = 202425,
--};

local BL = {
	TwinMoons          = 279620,
	Starlord           = 202345,
	StellarDrift       = 202354,
	MoonkinForm        = 24858,
	SolarWrath         = 190984,
	WarriorOfElune     = 202425,
	Innervate          = 29166,
	Incarnation        = 102560,
	CelestialAlignment = 194223,
	Sunfire            = 93402,
	Moonfire           = 8921,
	MoonfireAura       = 164812,
	SunfireAura        = 164815,
	StellarFlare       = 202347,
	FuryOfElune        = 202770,
	ForceOfNature      = 205636,
	Starfall           = 191034,
	Starsurge          = 78674,
	NewMoon            = 274281,
	HalfMoon           = 274282,
	FullMoon           = 274283,
	LunarStrike        = 194153,
	LunarEmpowerment   = 164547,
	SolarEmpowerment   = 164545,
	ArcanicPulsar      = 287790,
	LivelySpirit       = 279648,
};

local A = {
	StreakingStars = 272871,
	ArcanicPulsar  = 287773,
	LivelySpirit   = 279642,
};


setmetatable(A, Druid.spellMeta);
setmetatable(BL, Druid.spellMeta);

function Druid:Balance()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local targets = MaxDps:SmartAoe();
	local gcd = fd.gcd;
	local timeToDie = fd.timeToDie;
	local spellHistory = fd.spellHistory;
	local lunarPower = UnitPower('player', LunarPower);
	local apCheck = true;
	local solarWrathApCheck = true;

	local solarCharges = buff[BL.SolarEmpowerment].count;
	local lunarCharges = buff[BL.LunarEmpowerment].count;
	local StarfallCost = 50;

	if currentSpell == BL.SolarWrath then
		lunarPower = lunarPower + 8;
		solarCharges = solarCharges - 1;
	elseif currentSpell == BL.LunarStrike then
		lunarPower = lunarPower + 12;
		lunarCharges = lunarCharges - 1;
	elseif currentSpell == BL.StellarFlare then
		lunarPower = lunarPower + 8;
	elseif currentSpell == BL.NewMoon then
		lunarPower = lunarPower + 10;
	elseif currentSpell == BL.HalfMoon then
		lunarPower = lunarPower + 20;
	elseif currentSpell == BL.FullMoon then
		lunarPower = lunarPower + 40;
	end

	local CaInc;

	MaxDps:GlowEssences();

	if talents[BL.Incarnation] then
		CaInc = BL.Incarnation;
		-- incarnation,if=dot.sunfire.remains>8&dot.moonfire.remains>12&(dot.stellar_flare.remains>6|!talent.stellar_flare.enabled);
		--if talents[BL.Incarnation] and cooldown[BL.Incarnation].ready and (
		--	debuff[BL.SunfireAura].remains > 8 and debuff[BL.MoonfireAura].remains > 12 and
		--		(debuff[BL.StellarFlare].remains > 6 or not talents[BL.StellarFlare])
		--) then
		--	return BL.Incarnation;
		--end
		MaxDps:GlowCooldown(
			BL.Incarnation,
			cooldown[BL.Incarnation].ready and
			debuff[BL.SunfireAura].remains > 8 and
			debuff[BL.MoonfireAura].remains > 12 and
			(debuff[BL.StellarFlare].remains > 6 or not talents[BL.StellarFlare])
		);
	else
		CaInc = BL.CelestialAlignment;
		-- celestial_alignment,if=astral_power>=40&ap_check&(!azerite.lively_spirit.enabled|buff.lively_spirit.up)&(dot.sunfire.remains>2&dot.moonfire.ticking&(dot.stellar_flare.ticking|!talent.stellar_flare.enabled));
		--if cooldown[BL.CelestialAlignment].ready and (
		--	lunarPower >= 40 and apCheck and (azerite[A.LivelySpirit] == 0 or buff[BL.LivelySpirit].up) and
		--		(debuff[BL.SunfireAura].remains > 2 and debuff[BL.MoonfireAura].up and (debuff[BL.StellarFlare].up or not talents[BL.StellarFlare]))
		--) then
		--	return BL.CelestialAlignment;
		--end
		MaxDps:GlowCooldown(
			BL.CelestialAlignment,
			cooldown[BL.CelestialAlignment].ready and
			lunarPower >= 40 and
			apCheck and
			(azerite[A.LivelySpirit] == 0 or buff[BL.LivelySpirit].up) and
			(debuff[BL.SunfireAura].remains > 2 and debuff[BL.MoonfireAura].up and (debuff[BL.StellarFlare].up or not talents[BL.StellarFlare]))
		);
	end

	-- warrior_of_elune;
	if talents[BL.WarriorOfElune] then
		MaxDps:GlowCooldown(BL.WarriorOfElune, cooldown[BL.WarriorOfElune].ready and not buff[BL.WarriorOfElune].up);
	end

	-- innervate,if=azerite.lively_spirit.enabled&(cooldown.incarnation.remains<2|cooldown.celestial_alignment.remains<12);
	MaxDps:GlowCooldown(
		BL.Innervate,
		cooldown[BL.Innervate].ready and azerite[A.LivelySpirit] > 0 and
		(cooldown[BL.Incarnation].remains < 2 or cooldown[BL.CelestialAlignment].remains < 12)
	);

	if talents[BL.ForceOfNature] then
		-- force_of_nature,if=(buff.ca_inc.up|cooldown.ca_inc.remains>30)&ap_check;
		--if cooldown[BL.ForceOfNature].ready and ((buff[CaInc].up or cooldown[CaInc].remains > 30) and apCheck) then
		--	return BL.ForceOfNature;
		--end
		MaxDps:GlowCooldown(BL.ForceOfNature, cooldown[BL.ForceOfNature].ready);
	end

	-- variable,name=az_ss,value=azerite.streaking_stars.rank;
	local azSs = azerite[A.StreakingStars] > 0;

	-- variable,name=az_ap,value=azerite.arcanic_pulsar.rank;
	local azAp = azerite[A.ArcanicPulsar];

	-- variable,name=sf_targets,value=4;
	local sfTargets = 4;

	-- variable,name=sf_targets,op=add,value=1,if=talent.twin_moons.enabled&(azerite.arcanic_pulsar.enabled|talent.starlord.enabled);
	if talents[BL.TwinMoons] and (azerite[A.ArcanicPulsar] > 0 or talents[BL.Starlord]) then
		sfTargets = sfTargets + 1;
	end

	-- variable,name=sf_targets,op=sub,value=1,if=!azerite.arcanic_pulsar.enabled&!talent.starlord.enabled&talent.stellar_drift.enabled;
	if azerite[A.ArcanicPulsar] == 0 and not talents[BL.Starlord] and talents[BL.StellarDrift] then
		sfTargets = sfTargets - 1;
	end

	-- fury_of_elune,if=(buff.ca_inc.up|cooldown.ca_inc.remains>30)&solar_wrath.ap_check;
	if talents[BL.FuryOfElune] and cooldown[BL.FuryOfElune].ready and (buff[CaInc].up or cooldown[CaInc].remains > 30) then
		return BL.FuryOfElune;
	end

	-- cancel_buff,name=starlord,if=buff.starlord.remains<8&!solar_wrath.ap_check;
	--if buff[BL.Starlord].remains < 8 and not solarWrathApCheck then
	--	return starlord;
	--end

	-- starfall,if=(buff.starlord.stack<3|buff.starlord.remains>=8)&spell_targets>=variable.sf_targets&(target.time_to_die+1)*spell_targets>cost%2.5;
	if lunarPower >= 50 and
		(buff[BL.Starlord].count < 3 or buff[BL.Starlord].remains >= 8) and
		targets >= sfTargets and
		(timeToDie + 1) * targets > StarfallCost % 2.5
	then
		return BL.Starfall;
	end

	-- starsurge,if=(talent.starlord.enabled&(buff.starlord.stack<3|buff.starlord.remains>=8&buff.arcanic_pulsar.stack<8)|!talent.starlord.enabled&(buff.arcanic_pulsar.stack<8|buff.ca_inc.up))&spell_targets.starfall<variable.sf_targets&buff.lunar_empowerment.stack+buff.solar_empowerment.stack<4&buff.solar_empowerment.stack<3&buff.lunar_empowerment.stack<3&(!variable.az_ss|!buff.ca_inc.up|!prev.starsurge)|target.time_to_die<=execute_time*astral_power%40|!solar_wrath.ap_check;
	if lunarPower >= 50 and (
		(talents[BL.Starlord] and
			(buff[BL.Starlord].count < 3 or buff[BL.Starlord].remains >= 8 and buff[BL.ArcanicPulsar].count < 8) or
			not talents[BL.Starlord] and (buff[BL.ArcanicPulsar].count < 8 or buff[CaInc].up)
		) and
			targets < sfTargets and
			lunarCharges + solarCharges < 4 and
			solarCharges < 3 and lunarCharges < 3 and
			(not azSs or not buff[CaInc].up or spellHistory[1] ~= BL.Starsurge) or
			timeToDie <= timeShift * lunarPower % 40 or not solarWrathApCheck
	) then
		return BL.Starsurge;
	end

	if debuff[BL.MoonfireAura].refreshable then
		return BL.Moonfire;
	end

	if debuff[BL.SunfireAura].refreshable then
		return BL.Sunfire;
	end

	-- sunfire,if=buff.ca_inc.up&buff.ca_inc.remains<gcd.max&variable.az_ss&dot.moonfire.remains>remains;
	if buff[CaInc].up and buff[CaInc].remains < gcd and azSs and debuff[BL.MoonfireAura].remains > debuff[BL.SunfireAura].remains then
		return BL.Sunfire;
	end

	-- moonfire,if=buff.ca_inc.up&buff.ca_inc.remains<gcd.max&variable.az_ss;
	if buff[CaInc].up and buff[CaInc].remains < gcd and azSs then
		return BL.Moonfire;
	end

	-- sunfire,target_if=refreshable,if=ap_check&floor(target.time_to_die%(2*spell_haste))*spell_targets>=ceil(floor(2%spell_targets)*1.5)+2*spell_targets&(spell_targets>1+talent.twin_moons.enabled|dot.moonfire.ticking)&(!variable.az_ss|!buff.ca_inc.up|!prev.sunfire)&(buff.ca_inc.remains>remains|!buff.ca_inc.up);
	--if apCheck and math.floor(timeToDie % (2 * spellHaste)) * targets >= math.ceil(math.floor(2 % targets) * 1.5) + 2 * targets and
	--	(targets > 1 + (talents[BL.TwinMoons] and 1 or 0) or debuff[BL.MoonfireAura].up) and
	--	(not azSs or not buff[CaInc].up or spellHistory[1] ~= BL.Sunfire) and
	--	(buff[CaInc].remains > debuff[BL.SunfireAura].remains or not buff[CaInc].up) then
	--	return BL.Sunfire;
	--end

	-- moonfire,target_if=refreshable,if=ap_check&floor(target.time_to_die%(2*spell_haste))*spell_targets>=6&(!variable.az_ss|!buff.ca_inc.up|!prev.moonfire)&(buff.ca_inc.remains>remains|!buff.ca_inc.up);
	--if apCheck and math.floor(timeToDie % (2 * spellHaste)) * targets >= 6 and
	--	(not azSs or not buff[CaInc].up or spellHistory[1] ~= BL.Moonfire) and
	--	(buff[CaInc].remains > debuff[BL.MoonfireAura].remains or not buff[CaInc].up)
	--then
	--	return BL.Moonfire;
	--end

	-- stellar_flare,target_if=refreshable,if=ap_check&floor(target.time_to_die%(2*spell_haste))>=5&(!variable.az_ss|!buff.ca_inc.up|!prev.stellar_flare);
	if talents[BL.StellarFlare] and currentSpell ~= BL.StellarFlare and
		spellHistory[1] ~= BL.StellarFlare and
		debuff[BL.StellarFlare].refreshable and
		(not azSs or not buff[CaInc].up)
	then
		return BL.StellarFlare;
	end

	-- new_moon,if=ap_check;
	-- half_moon,if=ap_check;
	-- full_moon,if=ap_check;
	if talents[BL.NewMoon] then
		local nmCharges = cooldown[BL.NewMoon].charges;
		if nmCharges >= 2 or nmCharges >= 1 and (
			currentSpell ~= BL.NewMoon and currentSpell ~= BL.HalfMoon and currentSpell ~= BL.FullMoon)
		then
			local MoonPhase = MaxDps:FindSpell(BL.NewMoon) and BL.NewMoon or
				(MaxDps:FindSpell(BL.HalfMoon) and BL.HalfMoon or BL.FullMoon);

			return MoonPhase;
		end
	end

	-- lunar_strike,if=buff.solar_empowerment.stack<3&(ap_check|buff.lunar_empowerment.stack=3)&((buff.warrior_of_elune.up|buff.lunar_empowerment.up|spell_targets>=2&!buff.solar_empowerment.up)&(!variable.az_ss|!buff.ca_inc.up)|variable.az_ss&buff.ca_inc.up&prev.solar_wrath);
	if solarCharges < 3 and (apCheck or lunarCharges == 3) and (
		(buff[BL.WarriorOfElune].up or lunarCharges > 0 or targets >= 2 and solarCharges <= 0) and
		(not azSs or not buff[CaInc].up) or
		azSs and buff[CaInc].up and currentSpell == BL.SolarWrath
	) then
		return BL.LunarStrike;
	end

	-- solar_wrath,if=variable.az_ss<3|!buff.ca_inc.up|!prev.solar_wrath;
	if azerite[A.StreakingStars] < 3 or not buff[CaInc].up or currentSpell ~= BL.SolarWrath then
		return BL.SolarWrath;
	end

	-- sunfire;
	return BL.Sunfire;
end