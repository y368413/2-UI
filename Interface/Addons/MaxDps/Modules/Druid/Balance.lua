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
local Druid = MaxDps_DruidTable.Druid;

local BL = {
	TwinMoons          = 279620,
	Starlord           = 202345,
	StellarDrift       = 202354,
	MoonkinForm        = 24858,
	Wrath              = 190984,
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
	Starfire           = 194153,
	LunarEmpowerment   = 48518,
	SolarEmpowerment   = 48517,
	OwlkinFrenzy       = 157228,
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
	local WrathApCheck = true;

	local solarCharges = GetSpellCount(BL.Wrath);
	local lunarCharges = GetSpellCount(BL.Starfire);
	local StarfallCost = 50;

	local canCastStarSurge = 0;

	if currentSpell == BL.Wrath then
		lunarPower = lunarPower + 6;
		solarCharges = solarCharges - 1;
	elseif currentSpell == BL.Starfire then
		lunarPower = lunarPower + 8;
		lunarCharges = lunarCharges - 1;
	elseif currentSpell == BL.FuryOfElune then
		lunarPower = lunarPower + 40;
	elseif currentSpell == BL.ForceOfNature then
		lunarPower = lunarPower + 20;
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

	if lunarPower >= 50 and
		talents[BL.StellarDrift] and
		targets >= sfTargets and
		(timeToDie + 1) * targets > StarfallCost % 2.5
	then
		return BL.Starfall;
	end

	if lunarPower >= 50 and
		(buff[BL.Starlord].count < 3 or buff[BL.Starlord].remains >= 8) and
		targets >= sfTargets and
		(timeToDie + 1) * targets > StarfallCost % 2.5
	then
		return BL.Starfall;
	end

	if buff[BL.OwlkinFrenzy].up then
		return BL.Starfire;
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

	if lunarPower >= 30 and buff[BL.Starlord].count < 3 and (
		buff[BL.LunarEmpowerment].up or
			buff[BL.SolarEmpowerment].up
	) and (
		buff[BL.LunarEmpowerment].remains > 3 or
			buff[BL.SolarEmpowerment].remains > 3
	) and (
		timeToDie > 2
	) and (
		targets < sfTargets
	) then
		return BL.Starsurge;
	end

	if talents[BL.FuryOfElune] then
		if cooldown[BL.FuryOfElune].ready and timeToDie > 3 then
			return BL.FuryOfElune;
		end
	end

	if (lunarCharges >= 1 and not buff[BL.SolarEmpowerment].up) or buff[BL.LunarEmpowerment].up and (
		timeToDie > 2
	) then
		return BL.Starfire;
	end

	if (solarCharges >= 1 and not buff[BL.LunarEmpowerment].up) or buff[BL.SolarEmpowerment].up and (
		timeToDie > 2
	) then
		return BL.Wrath;
	end

	if timeToDie <= 2 then
		return BL.Sunfire;
	end
end