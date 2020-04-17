if select(2, UnitClass("player")) ~= "ROGUE" then return end

local _, MaxDps_RogueTable = ...;

--- @type MaxDps
if not MaxDps then return end

local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local GetPowerRegen = GetPowerRegen;
local InCombatLockdown = InCombatLockdown;
local ComboPoints = Enum.PowerType.ComboPoints;
local Energy = Enum.PowerType.Energy;
local Rogue = MaxDps_RogueTable.Rogue;

local SB = {
	Stealth           = 1784,
	StealthSubterfuge = 115191,
	SubterfugeAura    = 115192,
	MarkedForDeath    = 137619,
	ShadowBlades      = 121471,
	Nightblade        = 195452,
	Vigor             = 14983,
	MasterOfShadows   = 196976,
	ShadowFocus       = 108209,
	Alacrity          = 193539,
	DarkShadow        = 245687,
	SecretTechnique   = 280719,
	ShurikenTornado   = 277925,
	ShurikenToss      = 114014,
	Nightstalker      = 14062,
	SymbolsOfDeath    = 212283,
	ShurikenStorm     = 197835,
	Gloomblade        = 200758,
	Backstab          = 53,
	ShadowDance       = 185313,
	ShadowDanceAura   = 185422,
	Subterfuge        = 108208,
	Eviscerate        = 196819,
	Vanish            = 1856,
	VanishAura        = 11327,
	FindWeakness      = 91023,
	Shadowstrike      = 185438,
	DeeperStratagem   = 193531,
};

local A = {
	NightsVengeance = 273418,
	SharpenedBlades = 272911,
	BladeInTheShadows = 275896
};

setmetatable(SB, Rogue.spellMeta);
setmetatable(A, Rogue.spellMeta);

function Rogue:Subtlety()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, talents, azerite, currentSpell, gcd =
	fd.cooldown, fd.buff, fd.debuff, fd.talents, fd.azerite, fd.currentSpell, fd.gcd;

	local energy = UnitPower('player', Energy);
	local energyMax = UnitPowerMax('player', Energy);
	local energyDeficit = energyMax - energy;
	local energyRegen = GetPowerRegen();
	local energyTimeToMax = (energyMax - energy) / energyRegen;

	local combo = UnitPower('player', ComboPoints);
	local comboMax = UnitPowerMax('player', ComboPoints);
	local comboDeficit = comboMax - combo;
	local targets = MaxDps:SmartAoe();
	local cpMaxSpend = 5 + (talents[SB.DeeperStratagem] and 1 or 0);
	local priorityRotation = false;

	local stealthed = buff[SB.Stealth].up or buff[SB.StealthSubterfuge].up or buff[SB.ShadowDanceAura].up or
		buff[SB.VanishAura].up or buff[SB.SubterfugeAura].up;

	local Stealth = talents[SB.Subterfuge] and SB.StealthSubterfuge or SB.Stealth;

	fd.energy, fd.targets, fd.combo, fd.comboDeficit, fd.cpMaxSpend, fd.stealthed =
	energy, targets, combo, comboDeficit, cpMaxSpend, stealthed;

	MaxDps:GlowEssences();
	MaxDps:GlowCooldown(SB.ShadowBlades, cooldown[SB.ShadowBlades].ready);

	-- stealth;
	if not InCombatLockdown() and not stealthed then
		return Stealth;
	end

	local cd = Rogue:SubtletyCds();
	if cd then return cd; end

	if stealthed then
		return Rogue:SubtletyStealthed();
	end

	-- nightblade,if=target.time_to_die>6&remains<gcd.max&combo_points>=4-(time<10)*2;
	if debuff[SB.Nightblade].remains < gcd and combo >= 4 then
		return SB.Nightblade;
	end
	-- variable,name=use_priority_rotation,value=priority_rotation&spell_targets.shuriken_storm>=2;
	local usePriorityRotation = priorityRotation and targets >= 2;

	local r;
	if usePriorityRotation then
		r = Rogue:SubtletyStealthCds();
		if r then return r; end
	end

	-- variable,name=stealth_threshold,value=25+talent.vigor.enabled*35+talent.master_of_shadows.enabled*25+talent.shadow_focus.enabled*20+talent.alacrity.enabled*10+15*(spell_targets.shuriken_storm>=3);
	local stealthThreshold = 25 + (talents[SB.Vigor] and 35 or 0) +
		(talents[SB.MasterOfShadows] and 25 or 0) +
		(talents[SB.ShadowFocus] and 20 or 0) +
		(talents[SB.Alacrity] and 10 or 0) +
		(targets >= 3 and 15 or 0);

	if energyDeficit <= stealthThreshold and comboDeficit >= 4 then
		r = Rogue:SubtletyStealthCds();
		if r then return r; end
	end

	if energyDeficit <= stealthThreshold and talents[SB.DarkShadow] and talents[SB.SecretTechnique] and cooldown[SB.SecretTechnique].ready then
		r = Rogue:SubtletyStealthCds();
		if r then return r; end
	end

	if energyDeficit <= stealthThreshold and talents[SB.DarkShadow] and targets >= 2 and (
		not talents[SB.ShurikenTornado] or not cooldown[SB.ShurikenTornado].ready
	) then
		r = Rogue:SubtletyStealthCds();
		if r then return r; end
	end

	if comboDeficit <= 1 and combo >= 3 then
		return Rogue:SubtletyFinish();
	end

	if targets == 4 and combo >= 4 then
		return Rogue:SubtletyFinish();
	end

	if energyDeficit <= stealthThreshold then
		return Rogue:SubtletyBuild();
	end
end

function Rogue:SubtletyBuild()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, talents, azerite, currentSpell, energy, targets =
	fd.cooldown, fd.buff, fd.debuff, fd.talents, fd.azerite, fd.currentSpell, fd.energy, fd.targets;

	-- shuriken_toss,if=!talent.nightstalker.enabled&(!talent.dark_shadow.enabled|cooldown.symbols_of_death.remains>10)&buff.sharpened_blades.stack>=29&spell_targets.shuriken_storm<=(3*azerite.sharpened_blades.rank);
	if energy >= 40 and (
		not talents[SB.Nightstalker] and
			(not talents[SB.DarkShadow] or cooldown[SB.SymbolsOfDeath].remains > 10) and
			buff[A.SharpenedBlades].count >= 29 and
			targets <= (3 * azerite[A.SharpenedBlades])
	) then
		return SB.ShurikenToss;
	end

	-- shuriken_storm,if=spell_targets>=2;
	if energy >= 35 and targets >= 2 then
		return SB.ShurikenStorm;
	end

	-- gloomblade;
	if talents[SB.Gloomblade] and energy >= 35 then
		return SB.Gloomblade;
	end

	-- backstab;
	return SB.Backstab;
end

function Rogue:SubtletyCds()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, talents, azerite, currentSpell, targets, stealthed, comboDeficit, cpMaxSpend, energy =
	fd.cooldown, fd.buff, fd.debuff, fd.talents, fd.azerite, fd.currentSpell, fd.targets, fd.stealthed, fd.comboDeficit, fd.cpMaxSpend, fd.energy;

	-- shadow_dance,use_off_gcd=1,if=!buff.shadow_dance.up&buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5;
	if cooldown[SB.ShadowDance].ready and (not buff[SB.ShadowDanceAura].up and buff[SB.ShurikenTornado].up and buff[SB.ShurikenTornado].remains <= 3.5) then
		return SB.ShadowDance;
	end

	-- symbols_of_death,use_off_gcd=1,if=buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5;
	if cooldown[SB.SymbolsOfDeath].ready and
		buff[SB.ShurikenTornado].up and
		buff[SB.ShurikenTornado].remains <= 3.5
	then
		return SB.SymbolsOfDeath;
	end

	-- symbols_of_death,if=dot.nightblade.ticking&(!talent.shuriken_tornado.enabled|talent.shadow_focus.enabled|spell_targets.shuriken_storm<3|!cooldown.shuriken_tornado.up);
	if cooldown[SB.SymbolsOfDeath].ready and debuff[SB.Nightblade].up and (
		not talents[SB.ShurikenTornado] or talents[SB.ShadowFocus] or targets < 3 or not cooldown[SB.ShurikenTornado].ready
	) then
		return SB.SymbolsOfDeath;
	end

	-- marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit|!stealthed.all&combo_points.deficit>=cp_max_spend);
	if talents[SB.MarkedForDeath] and cooldown[SB.MarkedForDeath].ready and (
		(not stealthed and comboDeficit >= cpMaxSpend)
	) then
		return SB.MarkedForDeath;
	end

	-- shadow_blades,if=combo_points.deficit>=2+stealthed.all;

	-- shuriken_tornado,if=spell_targets>=3&!talent.shadow_focus.enabled&dot.nightblade.ticking&!stealthed.all&cooldown.symbols_of_death.up&cooldown.shadow_dance.charges>=1;
	if talents[SB.ShurikenTornado] and cooldown[SB.ShurikenTornado].ready and energy >= 60 and (
		targets >= 3 and
			not talents[SB.ShadowFocus] and
			debuff[SB.Nightblade].up and
			not stealthed and
			cooldown[SB.SymbolsOfDeath].ready and
			cooldown[SB.ShadowDance].charges >= 1
	) then
		return SB.ShurikenTornado;
	end

	-- shuriken_tornado,if=spell_targets>=3&talent.shadow_focus.enabled&dot.nightblade.ticking&buff.symbols_of_death.up;
	if talents[SB.ShurikenTornado] and cooldown[SB.ShurikenTornado].ready and
		(targets >= 3 and talents[SB.ShadowFocus] and debuff[SB.Nightblade].up and buff[SB.SymbolsOfDeath].up)
	then
		return SB.ShurikenTornado;
	end

	-- shadow_dance,if=!buff.shadow_dance.up&target.time_to_die<=5+talent.subterfuge.enabled&!raid_event.adds.up;
	--if cooldown[SB.ShadowDance].ready and (not buff[SB.ShadowDanceAura].up) then
	--	return SB.ShadowDance;
	--end
end

function Rogue:SubtletyFinish()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, talents, azerite, currentSpell, combo, energy, targets =
	fd.cooldown, fd.buff, fd.debuff, fd.talents, fd.azerite, fd.currentSpell, fd.combo, fd.energy, fd.targets;

	local usePriorityRotation = false;

	-- eviscerate,if=talent.shadow_focus.enabled&buff.nights_vengeance.up&spell_targets.shuriken_storm>=2+3*talent.secret_technique.enabled;
	if combo >= 1 and energy >= 35 and (
		talents[SB.ShadowFocus] and
			buff[A.NightsVengeance].up and
			targets >= 2 + (talents[SB.SecretTechnique] and 3 or 0)
	) then
		return SB.Eviscerate;
	end

	local tickTime = 2;
	-- nightblade,if=(!talent.dark_shadow.enabled|!buff.shadow_dance.up)&target.time_to_die-remains>6&remains<tick_time*2&(spell_targets.shuriken_storm<4|!buff.symbols_of_death.up);
	if combo >= 1 and (
		(not talents[SB.DarkShadow] or not buff[SB.ShadowDanceAura].up) and
			debuff[SB.Nightblade].remains < tickTime * 2 and
			(targets < 4 or not buff[SB.SymbolsOfDeath].up)
	) then
		return SB.Nightblade;
	end

	-- nightblade,cycle_targets=1,if=!variable.use_priority_rotation&spell_targets.shuriken_storm>=2&(talent.secret_technique.enabled|azerite.nights_vengeance.enabled|spell_targets.shuriken_storm<=5)&!buff.shadow_dance.up&target.time_to_die>=(5+(2*combo_points))&refreshable;
	if combo >= 1 and (
		not usePriorityRotation and
			targets >= 2 and
			(talents[SB.SecretTechnique] or azerite[A.NightsVengeance] > 0 or targets <= 5) and
			not buff[SB.ShadowDanceAura].up and
			debuff[SB.Nightblade].refreshable)
	then
		return SB.Nightblade;
	end

	-- nightblade,if=remains<cooldown.symbols_of_death.remains+10&cooldown.symbols_of_death.remains<=5&target.time_to_die-remains>cooldown.symbols_of_death.remains+5;
	if combo >= 1 and (
		debuff[SB.Nightblade].remains < cooldown[SB.SymbolsOfDeath].remains + 10 and
			cooldown[SB.SymbolsOfDeath].remains <= 5
	) then
		return SB.Nightblade;
	end

	-- secret_technique,if=buff.symbols_of_death.up&(!talent.dark_shadow.enabled|buff.shadow_dance.up);
	if talents[SB.SecretTechnique] and cooldown[SB.SecretTechnique].ready and combo >= 1 and (
		buff[SB.SymbolsOfDeath].up and
			(not talents[SB.DarkShadow] or buff[SB.ShadowDanceAura].up)
	) then
		return SB.SecretTechnique;
	end

	-- secret_technique,if=spell_targets.shuriken_storm>=2+talent.dark_shadow.enabled+talent.nightstalker.enabled;
	if talents[SB.SecretTechnique] and cooldown[SB.SecretTechnique].ready and combo >= 1 and (
		targets >= 2 + (talents[SB.DarkShadow] and 1 or 0) + (talents[SB.Nightstalker] and 1 or 0))
	then
		return SB.SecretTechnique;
	end

	-- eviscerate;
	return SB.Eviscerate;
end

function Rogue:SubtletyStealthCds()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, talents, azerite, currentSpell, targets, comboDeficit =
	fd.cooldown, fd.buff, fd.debuff, fd.talents, fd.azerite, fd.currentSpell, fd.targets, fd.comboDeficit;
	-- variable,name=shd_threshold,value=cooldown.shadow_dance.charges_fractional>=1.75;

	local shdThreshold = cooldown[SB.ShadowDance].charges >= 1.75;
	local usePriorityRotation = false;

	-- vanish,if=!variable.shd_threshold&debuff.find_weakness.remains<1&combo_points.deficit>1;
	--if cooldown[SB.Vanish].ready and (not shdThreshold and debuff[SB.FindWeakness].remains < 1 and comboDeficit > 1) then
	--	return SB.Vanish;
	--end

	-- shadow_dance,if=(!talent.dark_shadow.enabled|dot.nightblade.remains>=5+talent.subterfuge.enabled)&(!talent.nightstalker.enabled&!talent.dark_shadow.enabled|!variable.use_priority_rotation|combo_points.deficit<=1)&(variable.shd_threshold|buff.symbols_of_death.remains>=1.2|spell_targets.shuriken_storm>=4&cooldown.symbols_of_death.remains>10);
	if cooldown[SB.ShadowDance].ready and (
		(not talents[SB.DarkShadow] or debuff[SB.Nightblade].remains >= 5 + (talents[SB.Subterfuge] and 1 or 0)) and
			(not talents[SB.Nightstalker] and not talents[SB.DarkShadow] or not usePriorityRotation or comboDeficit <= 1) and
			(shdThreshold or buff[SB.SymbolsOfDeath].remains >= 1.2 or targets >= 4 and cooldown[SB.SymbolsOfDeath].remains > 10)
	) then
		return SB.ShadowDance;
	end

	-- shadow_dance,if=target.time_to_die<cooldown.symbols_of_death.remains&!raid_event.adds.up;
	if cooldown[SB.ShadowDance].ready then
		return SB.ShadowDance;
	end
end

function Rogue:SubtletyStealthed()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, talents, azerite, currentSpell, energy, comboDeficit, targets =
	fd.cooldown, fd.buff, fd.debuff, fd.talents, fd.azerite, fd.currentSpell, fd.energy, fd.comboDeficit, fd.targets;

	local shadowStrike = MaxDps:FindSpell(SB.Shadowstrike) and SB.Shadowstrike or SB.Backstab;
	-- shadowstrike,if=buff.stealth.up;
	if energy >= 40 and (buff[SB.Stealth].up) then
		return shadowStrike;
	end

	if comboDeficit <= 1 - (talents[SB.DeeperStratagem] and buff[SB.Vanish].up and 1 or 0) then
		return Rogue:SubtletyFinish();
	end

	-- shuriken_toss,if=buff.sharpened_blades.stack>=29&(!talent.find_weakness.enabled|debuff.find_weakness.up);
	if energy >= 40 and (
		buff[A.SharpenedBlades].count >= 29 and
			(not talents[SB.FindWeakness] or debuff[SB.FindWeakness].up)
	) then
		return SB.ShurikenToss;
	end

	-- shadowstrike,cycle_targets=1,if=talent.secret_technique.enabled&talent.find_weakness.enabled&debuff.find_weakness.remains<1&spell_targets.shuriken_storm=2&target.time_to_die-remains>6;
	if energy >= 40 and (
		talents[SB.SecretTechnique] and
			talents[SB.FindWeakness] and
			debuff[SB.FindWeakness].remains < 1 and
			targets == 2
	) then
		return shadowStrike;
	end

	-- shadowstrike,if=!talent.deeper_stratagem.enabled&azerite.blade_in_the_shadows.rank=3&spell_targets.shuriken_storm=3;
	if energy >= 40 and (
		not talents[SB.DeeperStratagem] and
			azerite[A.BladeInTheShadows] == 3 and
			targets == 3
	) then
		return shadowStrike;
	end

	-- shuriken_storm,if=spell_targets>=3;
	if targets >= 3 then
		return SB.ShurikenStorm;
	end

	-- shadowstrike;
	return shadowStrike;
end