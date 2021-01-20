if select(2, UnitClass("player")) ~= "DEATHKNIGHT" then return end

local _, MaxDps_DeathKnightTable = ...;
local DeathKnight = MaxDps_DeathKnightTable.DeathKnight;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local UnitExists = UnitExists;
local RunicPower = Enum.PowerType.RunicPower;
local GetTotemInfo = GetTotemInfo;
local Runes = Enum.PowerType.Runes;

local Necrolord = Enum.CovenantType.Necrolord;
local Venthyr = Enum.CovenantType.Venthyr;
local NightFae = Enum.CovenantType.NightFae;
local Kyrian = Enum.CovenantType.Kyrian;

local UH = {
	RaiseDead 			 = 46584,
	SummonGargoyle 		 = 49206,
	Outbreak 			 = 77575,
	VirulentPlague 		 = 191587,
	UnholyBlight 		 = 115989,
	FrostFever 			 = 55095,
	BloodPlague 		 = 55078,
	DeathAndDecay 		 = 43265,
	DeathAndDecayBuff 	 = 188290,
	Defile 				 = 152280,
	DeathCoil		 	 = 47541,
	DarkTransformation 	 = 63560,
	Epidemic 			 = 207317,
	SwarmingMist 		 = 311648,
	FesteringStrike 	 = 85948,
	FesteringWound 		 = 194310,
	Apocalypse 			 = 275699,
	ArmyOfTheDead        = 42650,
	ArmyOfTheDamned      = 276837,
	UnholyBlightDot 	 = 115994,
	UnholyAssault 		 = 207289,
	SoulReaper 			 = 343294,
	SacrificialPact 	 = 327574,
	AbominationLimb 	 = 315443,
	LeadByExample	 	 = 342156,
	RunicCorruption 	 = 51462,
	ShackleTheUnworthy 	 = 312202,
	SuddenDoom 			 = 81340,
	ScourgeStrike 		 = 55090,
	DeathsDue 			 = 324128,
	ControlUndead		 = 111673,
	ClawingShadows 		 = 207311,

	-- Conduit Ids
	ConvocationOfTheDead = 124,

	-- Legendary ids
	DeadliestCoil 		 = 6952,
	SuperstrainBonusId 	 = 6953,
	PhearomonesBonusId 	 = 6954,
};

setmetatable(UH, DeathKnight.spellMeta);

function DeathKnight:Unholy()
	local fd = MaxDps.FrameData;
	local gcd = fd.gcd;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local runes = DeathKnight:Runes(fd.timeShift);
	local runeforge = fd.runeforge;
	local deathKnightFwoundedTargets = DeathKnight:WoundedTargets();
	local deathKnightDisableAotd = DeathKnight.db.unholyArmyOfTheDeadAsCooldown;
	local petExists = UnitExists('pet');
	local controlUndeadAura = MaxDps:IntUnitAura('pet', UH.ControlUndead, 'PLAYER', fd.timeShift);
	local darkTransformationAura = MaxDps:IntUnitAura('pet', UH.DarkTransformation, nil, fd.timeShift);
	local covenantId = fd.covenant.covenantId
	local runicPower = UnitPower('player', RunicPower);
	local runicPowerMax = UnitPowerMax('player', RunicPower);

	if talents[UH.ClawingShadows] then
		UH.WoundSpender = UH.ClawingShadows;
	else
		UH.WoundSpender = UH.ScourgeStrike;
	end

	if talents[UH.Defile] then
		UH.AnyDnd = UH.Defile;
	elseif covenantId == NightFae then
		UH.AnyDnd = UH.DeathsDue;
	else
		UH.AnyDnd = UH.DeathAndDecay;
	end

	-- variable,name=pooling_for_gargoyle,value=cooldown.summon_gargoyle.remains<5&talent.summon_gargoyle;
	local poolingForGargoyle = talents[UH.SummonGargoyle] and
		(cooldown[UH.SummonGargoyle].remains < 5) and
		not DeathKnight.db.unholySummonGargoyleAsCooldown;

	-- variable,name=st_planning,value=active_enemies=1&(!raid_event.adds.exists|raid_event.adds.in>15);
	local stPlanning = targets <= 1;

	fd.targets = targets;
	fd.runes = runes;
	fd.runicPower = runicPower;
	fd.runicPowerMax = runicPowerMax;
	fd.deathKnightFwoundedTargets = deathKnightFwoundedTargets;
	fd.deathKnightDisableAotd = deathKnightDisableAotd;
	fd.petExists = petExists;
	fd.controlUndeadAura = controlUndeadAura;
	fd.darkTransformationAura = darkTransformationAura;
	fd.poolingForGargoyle = poolingForGargoyle;
	fd.stPlanning = stPlanning;

	DeathKnight:UholyGlowCooldowns();

	-- outbreak,if=dot.virulent_plague.refreshable&!talent.unholy_blight&!raid_event.adds.exists;
	if runes >= 1 and (debuff[UH.VirulentPlague].refreshable and not talents[UH.UnholyBlight] and targets <= 1) then
		return UH.Outbreak;
	end

	-- outbreak,if=dot.virulent_plague.refreshable&active_enemies>=2&(!talent.unholy_blight|talent.unholy_blight&cooldown.unholy_blight.remains);
	if runes >= 1 and
		debuff[UH.VirulentPlague].refreshable and
		targets >= 2 and
		(not talents[UH.UnholyBlight] or (talents[UH.UnholyBlight] and not cooldown[UH.UnholyBlight].ready))
	then
		return UH.Outbreak;
	end

	-- outbreak,if=runeforge.superstrain&(dot.frost_fever.refreshable|dot.blood_plague.refreshable);
	if runes >= 1 and
		runeforge[UH.SuperstrainBonusId] and
		(debuff[UH.FrostFever].refreshable or debuff[UH.BloodPlague].refreshable)
	then
		return UH.Outbreak;
	end

	-- NOTE: This isn't in the simc priority list, but several people noted that Outbreak was never used if they had Unholy Blight as a talent, even when UB was on a long cooldown.
	if runes >= 1 and
		debuff[UH.VirulentPlague].remains < gcd and
		talents[UH.UnholyBlight] and
		(cooldown[UH.UnholyBlight].remains > 10 or (talents[UH.VirulentPlague] and cooldown[UH.UnholyBlight].remains > 8))
	then
		return UH.Outbreak;
	end

	-- call_action_list,name=covenants;
	local result = DeathKnight:UnholyCovenants();
	if result then
		return result;
	end

	-- call_action_list,name=cooldowns;
	result = DeathKnight:UnholyCooldowns();
	if result then
		return result;
	end

	-- run_action_list,name=aoe_setup,if=active_enemies>=2&(cooldown.death_and_decay.remains<10&!talent.defile|cooldown.defile.remains<10&talent.defile)&!death_and_decay.ticking;
	if targets >= 2 and
		(
			(cooldown[UH.DeathAndDecay].remains < 10 and not talents[UH.Defile]) or
			(talents[UH.Defile] and cooldown[UH.Defile].remains < 10)
		) and
		not debuff[UH.DeathAndDecay].up
	then
		return DeathKnight:UnholyAoeSetup();
	end

	-- run_action_list,name=aoe_burst,if=active_enemies>=2&death_and_decay.ticking;
	if targets >= 2 and buff[UH.DeathAndDecayBuff].up then
		return DeathKnight:UnholyAoeBurst();
	end

	-- run_action_list,name=generic_aoe,if=active_enemies>=2&(!death_and_decay.ticking&(cooldown.death_and_decay.remains>10&!talent.defile|cooldown.defile.remains>10&talent.defile));
	if targets >= 2 and
		not buff[UH.DeathAndDecayBuff].up and
		(
			(cooldown[UH.DeathAndDecay].remains > 10 and not talents[UH.Defile]) or
			(talents[UH.Defile] and cooldown[UH.Defile].remains > 10)
		)
	then
		return DeathKnight:UnholyGenericAoe();
	end

	-- call_action_list,name=generic,if=active_enemies=1;
	if targets <= 1 then
		result = DeathKnight:UnholyGeneric();
		if result then
			return result;
		end
	end
end

function DeathKnight:UholyGlowCooldowns()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local buff = fd.buff;
	local runes = fd.runes;
	local runicPowerDeficit = fd.runicPowerDeficit;
	local targets = fd.targets;
	local covenant = fd.covenant;
	local covenantId = fd.covenant.covenantId;
	local stPlanning = fd.stPlanning;

	local armyOfTheDeadReady = DeathKnight.db.unholyArmyOfTheDeadAsCooldown and
		cooldown[UH.ArmyOfTheDead].ready and
		runes >= 1;
	local summonGargoyleReady = DeathKnight.db.unholySummonGargoyleAsCooldown and
		talents[UH.SummonGargoyle] and
		cooldown[UH.SummonGargoyle].ready;
	local abominationLimbReady = DeathKnight.db.abominationLimbAsCooldown and
		covenantId == Necrolord and
		cooldown[UH.AbominationLimb].ready;

	if DeathKnight.db.alwaysGlowCooldowns then
		MaxDps:GlowCooldown(UH.ArmyOfTheDead, armyOfTheDeadReady);
		MaxDps:GlowCooldown(UH.SummonGargoyle, summonGargoyleReady);
		MaxDps:GlowCooldown(UH.AbominationLimb, abominationLimbReady);
	else
		local timeTo4Runes = DeathKnight:TimeToRunes(4);
		-- Gather up all of the triggers from the main rotation.
		local armyOfTheDeadCooldownTrigger =
		armyOfTheDeadReady and
			runes >= 1 and
			(
				(
					(
						talents[UH.UnholyBlight] and
						cooldown[UH.UnholyBlight].remains < 3 and
						cooldown[UH.DarkTransformation].remains < 3 and
						not covenant.soulbindAbilities[UH.LeadByExample]
					) or
					not talents[UH.UnholyBlight]
				) or
				(
					talents[UH.UnholyBlight] and
					cooldown[UH.UnholyBlight].remains < 3 and
					covenantId == Necrolord and
					(cooldown[UH.AbominationLimb].ready or DeathKnight.db.abominationLimbAsCooldown) and
					covenant.soulbindAbilities[UH.LeadByExample]
				)
			);

		local summonGargoyleCooldownTrigger =
			summonGargoyleReady and
			talents[UH.UnholyBlight] and
			runicPowerDeficit < 14 and
			(cooldown[UH.UnholyBlight].remains < 10 or debuff[UH.UnholyBlightDot].remains);

		local abominationLimbCooldownTrigger =
		abominationLimbReady and
			(
				(
					stPlanning and
					not covenant.soulbindAbilities[UH.LeadByExample] and
					not cooldown[UH.Apocalypse].ready and
					timeTo4Runes > ( 3 + buff[UH.RunicCorruption].remains )
				) or
				(
					stPlanning and
					covenant.soulbindAbilities[UH.LeadByExample] and
					(
						(talents[UH.UnholyBlight] and not cooldown[UH.UnholyBlight].ready) or
							(not talents[UH.UnholyBlight] and not cooldown[UH.DarkTransformation].ready )
					)
				) or
				(
					targets >= 2 and
					timeTo4Runes > ( 3 + buff[UH.RunicCorruption].remains )
				)
			);

		MaxDps:GlowCooldown(UH.ArmyOfTheDead, armyOfTheDeadCooldownTrigger);
		MaxDps:GlowCooldown(UH.SummonGargoyle, summonGargoyleCooldownTrigger);
		MaxDps:GlowCooldown(UH.AbominationLimb, abominationLimbCooldownTrigger);
	end
end

function DeathKnight:UnholyAoeBurst()
	local fd = MaxDps.FrameData;
	local buff = fd.buff;
	local talents = fd.talents;
	local targets = fd.targets;
	local runes = fd.runes;
	local runicPower = fd.runicPower;
	local runicPowerMax = fd.runicPowerMax;
	local runicPowerDeficit = runicPowerMax - runicPower;
	local runeforge = fd.runeforge
	local deathKnightFwoundedTargets = fd.deathKnightFwoundedTargets;
	local poolingForGargoyle = fd.poolingForGargoyle;
	local covenantId = fd.covenant.covenantId
	local darkTransformationAura = fd.darkTransformationAura;

	-- death_coil,if=buff.dark_transformation.up&runeforge.deadliest_coil&active_enemies<=3;
	if runicPower >= 30 and darkTransformationAura.up and runeforge[UH.DeadliestCoil] and targets <= 3 then
		return UH.DeathCoil;
	end

	-- epidemic,if=runic_power.deficit<(10+death_knight.fwounded_targets*3)&death_knight.fwounded_targets<6&!variable.pooling_for_gargoyle|buff.swarming_mist.up;
	if runicPower >= 30 and (
		(runicPowerDeficit < ( 10 + deathKnightFwoundedTargets * 3 ) and
			deathKnightFwoundedTargets < 6 and
			not poolingForGargoyle
		) or (
			covenantId == Venthyr and buff[UH.SwarmingMist].up
		)
	) then
		return UH.Epidemic;
	end

	-- epidemic,if=runic_power.deficit<25&death_knight.fwounded_targets>5&!variable.pooling_for_gargoyle;
	if runicPower >= 30 and runicPowerDeficit < 25 and deathKnightFwoundedTargets > 5 and not poolingForGargoyle then
		return UH.Epidemic;
	end

	-- epidemic,if=!death_knight.fwounded_targets&!variable.pooling_for_gargoyle|fight_remains<5|raid_event.adds.exists&raid_event.adds.remains<5;
	if runicPower >= 30 and deathKnightFwoundedTargets == 0 and not poolingForGargoyle then
		return UH.Epidemic;
	end

	-- wound_spender;
	if runes >= 1 then
		return UH.WoundSpender;
	end;

	-- epidemic,if=!variable.pooling_for_gargoyle;
	if runicPower >= 30 and not poolingForGargoyle then
		return UH.Epidemic;
	end
end

function DeathKnight:UnholyAoeSetup()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local targets = fd.targets;
	local runicPower = fd.runicPower;
	local runes = fd.runes;
	local poolingForGargoyle = fd.poolingForGargoyle;
	local runeforge = fd.runeforge;
	local darkTransformationAura = fd.darkTransformationAura;

	--[[
		NOTE: The SIMC priority list includes selectively applying Festering Wounds to multiple targets, and casting Death and Decay when 5+ targets are wounded,
	 		  or all active targets are wounded if there are fewer than five.  The priority appears to be to get one target up to 4+ wounds before moving on to the next target.
			  Since MaxDps can't do target-switching for us, we'll approximate this behavior by casting Death and Decay when the current target has 5+ wounds.
	  ]]

	-- any_dnd,if=death_knight.fwounded_targets=active_enemies|raid_event.adds.exists&raid_event.adds.remains<=11;
	-- any_dnd,if=death_knight.fwounded_targets>=5;
	if cooldown[UH.AnyDnd].ready and debuff[UH.FesteringWound].count >= 5 and runes >= 1 then
		return UH.AnyDnd;
	end

	-- death_coil,if=buff.dark_transformation.up&runeforge.deadliest_coil&active_enemies<=3;
	if runicPower >= 30 and darkTransformationAura.up and runeforge[UH.DeadliestCoil] and targets <= 3 then
		return UH.DeathCoil;
	end

	-- epidemic,if=!variable.pooling_for_gargoyle;
	if runicPower >= 30 and not poolingForGargoyle then
		return UH.Epidemic;
	end

	-- festering_strike,target_if=max:debuff.festering_wound.stack,if=debuff.festering_wound.stack<=3&cooldown.apocalypse.remains<3;
	-- festering_strike,target_if=debuff.festering_wound.stack<1;
	-- festering_strike,target_if=min:debuff.festering_wound.stack,if=rune.time_to_4<(cooldown.death_and_decay.remains&!talent.defile|cooldown.defile.remains&talent.defile);
	if runes >= 2 and debuff[UH.FesteringWound].count < 5 then
		return UH.FesteringStrike;
	end
end

function DeathKnight:UnholyCooldowns()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local gcd = fd.gcd;
	local timeToDie = fd.timeToDie;
	local runes = fd.runes;
	local runicPower = fd.runicPower;
	local runicPowerMax = fd.runicPowerMax;
	local runicPowerDeficit = runicPowerMax - runicPower;
	local stPlanning = fd.stPlanning;
	local deathKnightDisableAotd = fd.deathKnightDisableAotd;
	local runeforge = fd.runeforge;
	local conduit = fd.covenant.soulbindConduits;
	local covenant = fd.covenant;
	local covenantId = fd.covenant.covenantId;
	local apocGhoulActive = cooldown[UH.Apocalypse].duration - cooldown[UH.Apocalypse].remains <= 15;
	local armyGhoulActive = cooldown[UH.ArmyOfTheDead].duration - cooldown[UH.ArmyOfTheDead].remains <= 30;
	local ghoulActive = fd.petExists;
	local controlUndeadAura = fd.controlUndeadAura;
	local darkTransformationAura = fd.darkTransformationAura;
	local targetHpPercent = MaxDps:TargetPercentHealth() * 100;

	-- soul_reaper,target_if=target.time_to_pct_35<5&target.time_to_die>5;
	-- TODO: Implement "timeToPct" functionality.  Restrict to bosses/elites?
	-- Note: Removed timeToDie functionality as it seems inconsistent.  Boosted priority (was below Unholy Assault)
	if talents[UH.SoulReaper] and cooldown[UH.SoulReaper].ready and runes >= 1 and targetHpPercent <= 35 then
		return UH.SoulReaper;
	end

	-- army_of_the_dead,if=cooldown.unholy_blight.remains<3&cooldown.dark_transformation.remains<3&talent.unholy_blight&!soulbind.lead_by_example|!talent.unholy_blight|fight_remains<35
	if cooldown[UH.ArmyOfTheDead].ready and
		not DeathKnight.db.unholyArmyOfTheDeadAsCooldown and
		runes >= 1 and
		(
			(
				talents[UH.UnholyBlight] and
				cooldown[UH.UnholyBlight].remains < 3 and
				cooldown[UH.DarkTransformation].remains < 3 and
				not covenant.soulbindAbilities[UH.LeadByExample]
			) or
			not talents[UH.UnholyBlight]
		)
	then
		return UH.ArmyOfTheDead;
	end

	-- army_of_the_dead,if=cooldown.unholy_blight.remains<3&cooldown.abomination_limb.ready&soulbind.lead_by_example
	if cooldown[UH.ArmyOfTheDead].ready and
		not DeathKnight.db.unholyArmyOfTheDeadAsCooldown and
		runes >= 1 and
		talents[UH.UnholyBlight] and
		cooldown[UH.UnholyBlight].remains < 3 and
		covenantId == Necrolord and
		(cooldown[UH.AbominationLimb].ready or DeathKnight.db.abominationLimbAsCooldown) and
		covenant.soulbindAbilities[UH.LeadByExample]
	then
		return UH.ArmyOfTheDead;
	end

	--# Sync Blight with Dark Transformation if utilizing other Dark Transformation buffs, those being Deadliest Coil, Frenzied Monstrosity or Eternal Hunger. Also checks if conditions are met to instead hold for Apocalypse.
	-- unholy_blight,if=variable.st_planning&(cooldown.dark_transformation.remains<gcd|buff.dark_transformation.up)&(!runeforge.deadliest_coil|!talent.army_of_the_damned|conduit.convocation_of_the_dead.rank<5)
	if talents[UH.UnholyBlight] and
		cooldown[UH.UnholyBlight].ready and
		runes >= 1 and
		stPlanning and
		( cooldown[UH.DarkTransformation].remains < gcd or darkTransformationAura.up ) and
		(
			not runeforge[UH.DeadliestCoil] or
			not talents[UH.ArmyOfTheDamned] or
			(not conduit[UH.ConvocationOfTheDead] or conduit[UH.ConvocationOfTheDead] < 5)
		)
	then
		return UH.UnholyBlight;
	end

	--# Sync Blight with Apocalypse if the cooldown of Apocalypse is low enough. Requires Deadliest Coil, Convocation of the Dead and Army of the Damned together.
	-- unholy_blight,if=variable.st_planning&runeforge.deadliest_coil&talent.army_of_the_damned&conduit.convocation_of_the_dead.rank>=5&cooldown.apocalypse.remains<3&(cooldown.dark_transformation.remains<gcd|buff.dark_transformation.up)
	if talents[UH.UnholyBlight] and
		cooldown[UH.UnholyBlight].ready and
		runes >= 1 and
		stPlanning and
		runeforge[UH.DeadliestCoil] and
		talents[UH.ArmyOfTheDamned] and
		(conduit[UH.ConvocationOfTheDead] and conduit[UH.ConvocationOfTheDead] >= 5) and
		cooldown[UH.Apocalypse].remains < 3 and
		(cooldown[UH.DarkTransformation].remains < gcd or darkTransformationAura.up)
	then
		return UH.UnholyBlight;
	end

	-- unholy_blight,if=active_enemies>=2|fight_remains<21;
	if talents[UH.UnholyBlight] and
		cooldown[UH.UnholyBlight].ready and
		runes >= 1 and
		targets >= 2
	then
		return UH.UnholyBlight;
	end

	-- dark_transformation,if=variable.st_planning&(dot.unholy_blight_dot.remains|!talent.unholy_blight);
	if ghoulActive and
		(not controlUndeadAura.up) and
		cooldown[UH.DarkTransformation].ready and
		stPlanning and
		(not talents[UH.UnholyBlight] or debuff[UH.UnholyBlightDot].up)
	then
		return UH.DarkTransformation;
	end

	-- dark_transformation,if=active_enemies>=2;
	if ghoulActive and
		not controlUndeadAura.up and
		cooldown[UH.DarkTransformation].ready and
		targets >= 2
	then
		return UH.DarkTransformation;
	end

	-- apocalypse,if=active_enemies=1&debuff.festering_wound.stack>=4&talent.unholy_blight&talent.army_of_the_damned&runeforge.deadliest_coil&conduit.convocation_of_the_dead.rank>=5&dot.unholy_blight_dot.remains;
	if cooldown[UH.Apocalypse].ready and
		targets <= 1 and
		debuff[UH.FesteringWound].count >= 4 and
		talents[UH.UnholyBlight] and
		talents[UH.ArmyOfTheDamned] and
		runeforge[UH.DeadliestCoil] and
		(conduit[UH.ConvocationOfTheDead] and conduit[UH.ConvocationOfTheDead] >= 5) and
		debuff[UH.UnholyBlightDot].up
	then
		return UH.Apocalypse;
	end

	-- apocalypse,if=active_enemies=1&debuff.festering_wound.stack>=4&talent.unholy_blight&dot.unholy_blight_dot.remains>10&!talent.army_of_the_damned&conduit.convocation_of_the_dead.rank<5;
	if cooldown[UH.Apocalypse].ready and
		targets <= 1 and
		debuff[UH.FesteringWound].count >= 4 and
		talents[UH.UnholyBlight] and
		debuff[UH.UnholyBlightDot].remains > 10 and
		not talents[UH.ArmyOfTheDamned] and
		(not conduit[UH.ConvocationOfTheDead] or conduit[UH.ConvocationOfTheDead] < 5)
	then
		return UH.Apocalypse;
	end

	-- apocalypse,if=active_enemies=1&debuff.festering_wound.stack>=4&(!talent.unholy_blight|talent.army_of_the_damned&(!runeforge.deadliest_coil|conduit.convocation_of_the_dead.rank<5)|!talent.army_of_the_damned&conduit.convocation_of_the_dead.rank>=5|fight_remains<16);
	if cooldown[UH.Apocalypse].ready and
		targets <= 1 and
		debuff[UH.FesteringWound].count >= 4 and
		(
			not talents[UH.UnholyBlight] or
			talents[UH.ArmyOfTheDamned] and
				(
					not runeforge[UH.DeadliestCoil] or
					(not conduit[UH.ConvocationOfTheDead] or conduit[UH.ConvocationOfTheDead] < 5)
				) or (
					not talents[UH.ArmyOfTheDamned] and
					(conduit[UH.ConvocationOfTheDead] and conduit[UH.ConvocationOfTheDead] >= 5)
				)

		)
	then
		return UH.Apocalypse;
	end

	-- apocalypse,target_if=max:debuff.festering_wound.stack,if=active_enemies>=2&debuff.festering_wound.stack>=4&!death_and_decay.ticking;
	if cooldown[UH.Apocalypse].ready and
		targets >= 2 and
		debuff[UH.FesteringWound].count >= 4 and
		not buff[UH.DeathAndDecayBuff].up
	then
		return UH.Apocalypse;
	end

	-- summon_gargoyle,if=runic_power.deficit<14&(cooldown.unholy_blight.remains<10|dot.unholy_blight_dot.remains);
	if talents[UH.SummonGargoyle] and
		cooldown[UH.SummonGargoyle].ready and
		not DeathKnight.db.unholySummonGargoyleAsCooldown and
		talents[UH.UnholyBlight] and
		runicPowerDeficit < 14 and
		(cooldown[UH.UnholyBlight].remains < 10 or debuff[UH.UnholyBlightDot].remains)
	then
		return UH.SummonGargoyle;
	end

	-- unholy_assault,if=variable.st_planning&debuff.festering_wound.stack<2&(pet.apoc_ghoul.active|conduit.convocation_of_the_dead&buff.dark_transformation.up&!pet.army_ghoul.active);
	if talents[UH.UnholyAssault] and
		cooldown[UH.UnholyAssault].ready and
		stPlanning and
		debuff[UH.FesteringWound].count < 2 and
		(
			apocGhoulActive or
			(conduit[UH.ConvocationOfTheDead] and darkTransformationAura.up and not armyGhoulActive)
		)
	then
		return UH.UnholyAssault;
	end

	-- unholy_assault,target_if=min:debuff.festering_wound.stack,if=active_enemies>=2&debuff.festering_wound.stack<2;
	if talents[UH.UnholyAssault] and
		cooldown[UH.UnholyAssault].ready and
		targets >= 2 and
		debuff[UH.FesteringWound].count < 2
	then
		return UH.UnholyAssault;
	end

	-- raise_dead,if=!pet.ghoul.active;
	if cooldown[UH.RaiseDead].ready and not ghoulActive then
		return UH.RaiseDead;
	end

	-- sacrificial_pact,if=active_enemies>=2&!buff.dark_transformation.up&!cooldown.dark_transformation.ready|fight_remains<gcd;
	if ghoulActive and
		not controlUndeadAura.up and
		cooldown[UH.SacrificialPact].ready and
		cooldown[UH.RaiseDead].ready and
		runicPower >= 20 and
		targets >= 2 and
		not darkTransformationAura.up and
		not cooldown[UH.DarkTransformation].ready
	then
		return UH.SacrificialPact;
	end
end

function DeathKnight:UnholyCovenants()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local runicPower = fd.runicPower;
	local runicPowerMax = fd.runicPowerMax;
	local runicPowerDeficit = runicPowerMax - runicPower;
	local runes = fd.runes;
	local stPlanning = fd.stPlanning
	local covenant = fd.covenant;
	local covenantId = fd.covenant.covenantId
	local timeTo4Runes = DeathKnight:TimeToRunes(4);

	-- swarming_mist,if=variable.st_planning&runic_power.deficit>16|fight_remains<11;
	if covenantId == Venthyr and
		cooldown[UH.SwarmingMist].ready and
		runes >= 1 and
		stPlanning and
		runicPowerDeficit > 16
	then
		return UH.SwarmingMist;
	end

	-- swarming_mist,if=cooldown.apocalypse.remains&(active_enemies>=2&active_enemies<=5&runic_power.deficit>10+(active_enemies*6)|active_enemies>5&runic_power.deficit>40);
	if covenantId == Venthyr and
		cooldown[UH.SwarmingMist].ready and
		runes >= 1 and
		not cooldown[UH.Apocalypse].ready and
		(
			(targets >= 2 and targets <= 5 and runicPowerDeficit > 10 + ( targets * 6 )) or
				(targets > 5 and runicPowerDeficit > 40 )
		)
	then
		return UH.SwarmingMist;
	end

	-- abomination_limb,if=variable.st_planning&!soulbind.lead_by_example&cooldown.apocalypse.remains&rune.time_to_4>(3+buff.runic_corruption.remains)|fight_remains<21;
	if covenantId == Necrolord and
		cooldown[UH.AbominationLimb].ready and
		not DeathKnight.db.abominationLimbAsCooldown and
		stPlanning and
		not covenant.soulbindAbilities[UH.LeadByExample] and
		not cooldown[UH.Apocalypse].ready and
		timeTo4Runes > ( 3 + buff[UH.RunicCorruption].remains )
	then
		return UH.AbominationLimb;
	end

	-- abomination_limb,if=variable.st_planning&soulbind.lead_by_example&(dot.unholy_blight_dot.remains>11|!talent.unholy_blight&cooldown.dark_transformation.remains)
	if covenantId == Necrolord and
		cooldown[UH.AbominationLimb].ready and
		not DeathKnight.db.abominationLimbAsCooldown and
		stPlanning and
		covenant.soulbindAbilities[UH.LeadByExample] and
		(
			(talents[UH.UnholyBlight] and debuff[UH.UnholyBlightDot].remains > 11) or
			(not talents[UH.UnholyBlight] and not cooldown[UH.DarkTransformation].ready)
		)
	then
		return UH.AbominationLimb;
	end

	-- abomination_limb,if=active_enemies>=2&rune.time_to_4>(3+buff.runic_corruption.remains);
	if covenantId == Necrolord and
		cooldown[UH.AbominationLimb].ready and
		not DeathKnight.db.abominationLimbAsCooldown and
		targets >= 2 and
		timeTo4Runes > (3 + buff[UH.RunicCorruption].remains)
	then
		return UH.AbominationLimb;
	end

	-- shackle_the_unworthy,if=variable.st_planning&cooldown.apocalypse.remains|fight_remains<15;
	if covenantId == Kyrian and
		cooldown[UH.ShackleTheUnworthy].ready and
		stPlanning and
		not cooldown[UH.Apocalypse].ready
	then
		return UH.ShackleTheUnworthy;
	end

	-- shackle_the_unworthy,if=active_enemies>=2&(death_and_decay.ticking|raid_event.adds.remains<=14);
	if covenantId == Kyrian and
		cooldown[UH.ShackleTheUnworthy].ready and
		targets >= 2 and
		debuff[UH.DeathAndDecay].up
	then
		return UH.ShackleTheUnworthy;
	end
end

function DeathKnight:UnholyGeneric()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local covenantId = fd.covenant.covenantId;
	local runicPower = fd.runicPower;
	local runicPowerMax = fd.runicPowerMax;
	local runicPowerDeficit = runicPowerMax - runicPower;
	local runes = fd.runes;
	local poolingForGargoyle = fd.poolingForGargoyle;
	local petGargoyle = GetTotemInfo(3);
	local runeforge = fd.runeforge;
	local conduit = fd.covenant.soulbindConduits;

	-- death_coil,if=buff.sudden_doom.react&!variable.pooling_for_gargoyle|pet.gargoyle.active;
	if buff[UH.SuddenDoom].up and
		not poolingForGargoyle or
		((runicPower >= 40 or (runeforge[UH.DeadliestCoil] and runicPower >= 30)) and petGargoyle)
	then
		return UH.DeathCoil;
	end

	-- death_coil,if=runic_power.deficit<13&!variable.pooling_for_gargoyle;
	if (runicPower >= 40 or (runeforge[UH.DeadliestCoil] and runicPower >= 30)) and runicPowerDeficit < 13 and not poolingForGargoyle then
		return UH.DeathCoil;
	end

	-- any_dnd,if=cooldown.apocalypse.remains&(talent.defile.enabled|covenant.night_fae|runeforge.phearomones);
	if cooldown[UH.AnyDnd].ready and
		runes >= 1 and
		not cooldown[UH.Apocalypse].ready and
		(talents[UH.Defile] or covenantId == NightFae or runeforge[UH.PhearomonesBonusId])
	then
		return UH.AnyDnd;
	end

	-- wound_spender,if=debuff.festering_wound.stack>4;
	if runes >= 1 and debuff[UH.FesteringWound].count > 4 then
		return UH.WoundSpender;
	end

	-- wound_spender,if=debuff.festering_wound.up&cooldown.apocalypse.remains>5&(!talent.unholy_blight|talent.army_of_the_damned&conduit.convocation_of_the_dead.rank<5|!talent.army_of_the_damned&conduit.convocation_of_the_dead.rank>=5|!conduit.convocation_of_the_dead);
	if runes >= 1 and
		debuff[UH.FesteringWound].up and
		cooldown[UH.Apocalypse].remains > 5 and
		(
			not talents[UH.UnholyBlight] or
			(talents[UH.ArmyOfTheDamned] and (not conduit[UH.ConvocationOfTheDead] or conduit[UH.ConvocationOfTheDead] < 5)) or
			(not talents[UH.ArmyOfTheDamned] and (conduit[UH.ConvocationOfTheDead] and conduit[UH.ConvocationOfTheDead] >= 5)) or
			not conduit[UH.ConvocationOfTheDead]
		)
	then
		return UH.WoundSpender;
	end

	-- wound_spender,if=debuff.festering_wound.up&talent.unholy_blight&(!talent.army_of_the_damned&conduit.convocation_of_the_dead.rank<5|talent.army_of_the_damned&conduit.convocation_of_the_dead.rank>=5)&(cooldown.unholy_blight.remains>10&!dot.unholy_blight_dot.remains|cooldown.apocalypse.remains>10);
	if runes >= 1 and
		debuff[UH.FesteringWound].up and
		talents[UH.UnholyBlight] and
		(
			(not talents[UH.ArmyOfTheDamned] and (not conduit[UH.ConvocationOfTheDead] or conduit[UH.ConvocationOfTheDead] < 5)) or
			(talents[UH.ArmyOfTheDamned] and conduit[UH.ConvocationOfTheDead] and conduit[UH.ConvocationOfTheDead] >= 5)
		) and
		(
			(cooldown[UH.UnholyBlight].remains > 10 and not debuff[UH.UnholyBlightDot].up) or
			cooldown[UH.Apocalypse].remains > 10
		)
	then
		return UH.WoundSpender;
	end

	-- death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle;
	if (runicPower >= 40 or (runeforge[UH.DeadliestCoil] and runicPower >= 30)) and
		runicPowerDeficit < 20 and
		not poolingForGargoyle
	then
		return UH.DeathCoil;
	end

	-- festering_strike,if=debuff.festering_wound.stack<1;
	if runes >= 2 and debuff[UH.FesteringWound].count < 1 then
		return UH.FesteringStrike;
	end

	-- festering_strike,if=debuff.festering_wound.stack<4&cooldown.apocalypse.remains<5&(!talent.unholy_blight|talent.army_of_the_damned&conduit.convocation_of_the_dead.rank<5|!talent.army_of_the_damned&conduit.convocation_of_the_dead.rank>=5|!conduit.convocation_of_the_dead);
	if runes >= 2 and
		debuff[UH.FesteringWound].count < 4 and
		cooldown[UH.Apocalypse].remains < 5 and
		(
			not talents[UH.UnholyBlight] or
			(talents[UH.ArmyOfTheDamned] and (not conduit[UH.ConvocationOfTheDead] or conduit[UH.ConvocationOfTheDead] < 5)) or
			(not talents[UH.ArmyOfTheDamned] and conduit[UH.ConvocationOfTheDead] and conduit[UH.ConvocationOfTheDead] >= 5) or
			not conduit[UH.ConvocationOfTheDead]
		)
	then
		return UH.FesteringStrike;
	end

	-- festering_strike,if=debuff.festering_wound.stack<4&talent.unholy_blight&(!talent.army_of_the_damned&conduit.convocation_of_the_dead.rank<5|talent.army_of_the_damned&conduit.convocation_of_the_dead.rank>=5)&(cooldown.unholy_blight.remains<10|cooldown.apocalypse.remains<10&dot.unholy_blight_dot.remains);
	if runes >= 2 and
		debuff[UH.FesteringWound].count < 4 and
		talents[UH.UnholyBlight] and
		(
			(not talents[UH.ArmyOfTheDamned] and (not conduit[UH.ConvocationOfTheDead] or conduit[UH.ConvocationOfTheDead] < 5)) or
			(talents[UH.ArmyOfTheDamned] and (conduit[UH.ConvocationOfTheDead] and conduit[UH.ConvocationOfTheDead] >= 5 ))
		) and (
			cooldown[UH.UnholyBlight].remains < 10 or
			(cooldown[UH.Apocalypse].remains < 10 and debuff[UH.UnholyBlightDot].remains)
		)
	then
		return UH.FesteringStrike;
	end

	-- death_coil,if=!variable.pooling_for_gargoyle;
	if (runicPower >= 40 or (runeforge[UH.DeadliestCoil] and runicPower >= 30)) and not poolingForGargoyle then
		return UH.DeathCoil;
	end
end

function DeathKnight:UnholyGenericAoe()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local targets = fd.targets;
	local runicPower = fd.runicPower;
	local runes = fd.runes;
	local runeforge = fd.runeforge;
	local poolingForGargoyle = fd.poolingForGargoyle;
	local darkTransformationAura = fd.darkTransformationAura;

	-- death_coil,if=buff.dark_transformation.up&runeforge.deadliest_coil&active_enemies<=3;
	if runicPower >= 30 and darkTransformationAura.up and runeforge[UH.DeadliestCoil] and targets <= 3 then
		return UH.DeathCoil;
	end

	-- epidemic,if=buff.sudden_doom.react;
	if buff[UH.SuddenDoom].up then
		return UH.Epidemic;
	end

	-- epidemic,if=!variable.pooling_for_gargoyle;
	if runicPower >= 30 and not poolingForGargoyle then
		return UH.Epidemic;
	end

	-- wound_spender,target_if=max:debuff.festering_wound.stack,if=(cooldown.apocalypse.remains>5&debuff.festering_wound.up|debuff.festering_wound.stack>4)&(fight_remains<cooldown.death_and_decay.remains+10|fight_remains>cooldown.apocalypse.remains);
	if runes >= 1 and
		(cooldown[UH.Apocalypse].remains > 5 and debuff[UH.FesteringWound].up or debuff[UH.FesteringWound].count > 4)
	-- and ( fightRemains < cooldown[UH.DeathAndDecay].remains + 10 or fightRemains > cooldown[UH.Apocalypse].remains )
	-- TODO: Find a way to get the remaining fight time.
	-- TODO: Consider modifying timeToDie logic to track multiple targets, and base fight time on longest timeToDie
	then
		return UH.WoundSpender;
	end

	-- festering_strike,target_if=max:debuff.festering_wound.stack,if=debuff.festering_wound.stack<=3&cooldown.apocalypse.remains<3|debuff.festering_wound.stack<1;
	if runes >= 2 and
		debuff[UH.FesteringWound].count <= 3 and cooldown[UH.Apocalypse].remains < 3 or
		debuff[UH.FesteringWound].count < 1
	then
		return UH.FesteringStrike;
	end

	-- festering_strike,target_if=min:debuff.festering_wound.stack,if=cooldown.apocalypse.remains>5&debuff.festering_wound.stack<1;
	if runes >= 2 and cooldown[UH.Apocalypse].remains > 5 and debuff[UH.FesteringWound].count < 1 then
		return UH.FesteringStrike;
	end
end

function DeathKnight:WoundedTargets()
	local fd = MaxDps.FrameData;
	local _, units = MaxDps:ThreatCounter();
	local count = 0;

	for i = 1, #units do
		local festeringWound = MaxDps:IntUnitAura(tostring(units[i]), UH.FesteringWound, 'PLAYER', fd.timeShift)
		if festeringWound.remains > fd.gcd then
			count = count + 1;
		end
	end
	return count;
end