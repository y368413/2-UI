if select(2, UnitClass("player")) ~= "DEATHKNIGHT" then return end

local _, MaxDps_DeathKnightTable = ...;
local DeathKnight = MaxDps_DeathKnightTable.DeathKnight;
local MaxDps = MaxDps;
local IsEquippedItem = IsEquippedItem;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local RunicPower = Enum.PowerType.RunicPower;
local Runes = Enum.PowerType.Runes;

local RampingAmplitudeGigavoltEngine = 165580;

--[[
local UH = {
	VirulentPlague     = 191587,
	Outbreak           = 77575,
	SoulReaper         = 130736,
	DarkTransformation = 63560,
	Apocalypse         = 275699,
	FesteringWound     = 194310,
	DeathCoil          = 47541,
	SuddenDoom         = 49530,
	DeathAndDecay      = 43265,
	Pestilence         = 277234,
	Defile             = 152280,
	ScourgeStrike      = 55090,
	ClawingShadows     = 207311,
	FesteringStrike    = 85948,
	UnholyFrenzy       = 207289,
	BurstingSores      = 207264,
	InfectedClaws      = 207272,
	ArmyOfTheDead      = 42650,
	Epidemic           = 207317,
	SummonGargoyle     = 49206,
	RaiseDead          = 46584,
}
]]--

local UH = {
	RaiseDead          = 46584,
	ArmyOfTheDead      = 42650,
	SummonGargoyle     = 49206,
	Outbreak           = 77575,
	VirulentPlague     = 191587,
	DeathAndDecay      = 43265,
	Apocalypse         = 275699,
	Defile             = 152280,
	Epidemic           = 207317,
	DeathCoil          = 47541,
	ScourgeStrike      = 55090,
	ClawingShadows     = 207311,
	FesteringStrike    = 85948,
	FesteringWound     = 194310,
	BurstingSores      = 207264,
	SuddenDoom         = 81340,
	UnholyFrenzy       = 207289,
	DarkTransformation = 63560,
	SoulReaper         = 130736,
	UnholyBlight       = 115989,
	Pestilence         = 277234,
};

local A = {
	MagusOfTheDead = 288417,
};

function DeathKnight:Unholy()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local gcd = fd.gcd;
	local buff = fd.buff;
	local azerite = fd.azerite;
	local runes = DeathKnight:Runes(fd.timeShift);
	local runesMax = UnitPowerMax('player', Runes);
	local runesDeficit = runesMax - runes;
	local runicPower = UnitPower('player', RunicPower);
	local runicPowerMax = UnitPowerMax('player', RunicPower);
	local runicPowerDeficit = runicPowerMax - runicPower;
	local petGargoyle = cooldown[UH.SummonGargoyle].remains - 180 + 30 > 0;
	local canDeathCoil = runicPower >= 40 or buff[UH.SuddenDoom].up;

	-- variable,name=pooling_for_gargoyle,value=cooldown.summon_gargoyle.remains<5&talent.summon_gargoyle.enabled;
	local poolingForGargoyle = talents[UH.SummonGargoyle] and cooldown[UH.SummonGargoyle].remains < 5;

	fd.targets = targets;
	fd.runes = runes;
	fd.runesDeficit = runesDeficit;
	fd.runicPower = runicPower;
	fd.runicPowerDeficit = runicPowerDeficit;
	fd.petGargoyle = petGargoyle;
	fd.poolingForGargoyle = poolingForGargoyle;
	fd.canDeathCoil = canDeathCoil;

	MaxDps:GlowEssences();
	-- army_of_the_dead;
	MaxDps:GlowCooldown(UH.ArmyOfTheDead, cooldown[UH.ArmyOfTheDead].ready and runes >= 3);

	-- summon_gargoyle,if=runic_power.deficit<14;
	if talents[UH.SummonGargoyle] then
		MaxDps:GlowCooldown(UH.SummonGargoyle, cooldown[UH.SummonGargoyle].ready and runicPowerDeficit < 14);
	end

	if DeathKnight.db.unholyApocalypseAsCooldown then
		MaxDps:GlowCooldown(UH.Apocalypse, cooldown[UH.Apocalypse].ready and debuff[UH.FesteringWound].count >= 4);
	end

	if DeathKnight.db.unholyDarkTransformationAsCooldown then
		MaxDps:GlowCooldown(UH.DarkTransformation, cooldown[UH.DarkTransformation].ready);
	end

	if talents[UH.UnholyFrenzy] and DeathKnight.db.unholyUnholyFrenzyAsCooldown then
		MaxDps:GlowCooldown(
			UH.UnholyFrenzy,
			cooldown[UH.UnholyFrenzy].ready and (
				debuff[UH.FesteringWound].count < 4 and not (IsEquippedItem(RampingAmplitudeGigavoltEngine) or azerite[A.MagusOfTheDead] > 0) or
				cooldown[UH.Apocalypse].remains < 2 and (IsEquippedItem(RampingAmplitudeGigavoltEngine) or azerite[A.MagusOfTheDead] > 0) or
				targets >= 2 and (
					(cooldown[UH.DeathAndDecay].remains <= gcd and not talents[UH.Defile]) or
					(cooldown[UH.Defile].remains <= gcd and talents[UH.Defile])
				)
			)
		);
	end

	-- outbreak,target_if=dot.virulent_plague.remains<=gcd;
	if runes >= 1 and debuff[UH.VirulentPlague].remains <= gcd then
		return UH.Outbreak;
	end

	-- call_action_list,name=cooldowns;
	local result = DeathKnight:UnholyCooldowns();
	if result then return result; end

	-- run_action_list,name=aoe,if=active_enemies>=2;
	if targets >= 2 then
		return DeathKnight:UnholyAoe();
	end

	-- call_action_list,name=generic;
	return DeathKnight:UnholyGeneric();
end

function DeathKnight:UnholyAoe()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local poolingForGargoyle = fd.poolingForGargoyle;
	local runes = fd.runes;
	local runesDeficit = fd.runesDeficit;
	local runicPower = fd.runicPower;
	local runicPowerDeficit = fd.runicPowerDeficit;
	local petGargoyle = fd.petGargoyle;
	local canDeathCoil = fd.canDeathCoil;

	-- death_and_decay,if=cooldown.apocalypse.remains;
	if cooldown[UH.DeathAndDecay].ready and runes >= 1 and not cooldown[UH.Apocalypse].ready then
		return UH.DeathAndDecay;
	end

	-- defile;
	if talents[UH.Defile] and cooldown[UH.Defile].ready and runes >= 1 then
		return UH.Defile;
	end

	-- epidemic,if=death_and_decay.ticking&rune<2&!variable.pooling_for_gargoyle;
	if talents[UH.Epidemic] and runicPower >= 30 and debuff[UH.DeathAndDecay].up and runes < 2 and not poolingForGargoyle then
		return UH.Epidemic;
	end

	-- death_coil,if=death_and_decay.ticking&rune<2&!variable.pooling_for_gargoyle;
	if canDeathCoil and debuff[UH.DeathAndDecay].up and runes < 2 and not poolingForGargoyle then
		return UH.DeathCoil;
	end

	-- scourge_strike,if=death_and_decay.ticking&cooldown.apocalypse.remains;
	if runes >= 1 and debuff[UH.DeathAndDecay].up and not cooldown[UH.Apocalypse].ready then
		return UH.ScourgeStrike;
	end

	-- clawing_shadows,if=death_and_decay.ticking&cooldown.apocalypse.remains;
	if talents[UH.ClawingShadows] and runes >= 1 and debuff[UH.DeathAndDecay].up and not cooldown[UH.Apocalypse].ready then
		return UH.ClawingShadows;
	end

	-- epidemic,if=!variable.pooling_for_gargoyle;
	if talents[UH.Epidemic] and runicPower >= 30 and not poolingForGargoyle then
		return UH.Epidemic;
	end

	-- festering_strike,target_if=debuff.festering_wound.stack<=1&cooldown.death_and_decay.remains;
	if runes >= 2 and debuff[UH.FesteringWound].count <= 1 and not cooldown[UH.DeathAndDecay].ready then
		return UH.FesteringStrike;
	end

	-- festering_strike,if=talent.bursting_sores.enabled&spell_targets.bursting_sores>=2&debuff.festering_wound.stack<=1;
	if runes >= 2 and talents[UH.BurstingSores] and targets >= 2 and debuff[UH.FesteringWound].count <= 1 then
		return UH.FesteringStrike;
	end

	-- death_coil,if=buff.sudden_doom.react&rune.deficit>=4;
	if buff[UH.SuddenDoom].up and runesDeficit >= 4 then
		return UH.DeathCoil;
	end

	-- death_coil,if=buff.sudden_doom.react&!variable.pooling_for_gargoyle|pet.gargoyle.active;
	if buff[UH.SuddenDoom].up and not poolingForGargoyle or canDeathCoil and petGargoyle then
		return UH.DeathCoil;
	end

	-- death_coil,if=runic_power.deficit<14&(cooldown.apocalypse.remains>5|debuff.festering_wound.stack>4)&!variable.pooling_for_gargoyle;
	if canDeathCoil and
		runicPowerDeficit < 14 and
		(cooldown[UH.Apocalypse].remains > 5 or debuff[UH.FesteringWound].count > 4) and
		not poolingForGargoyle
	then
		return UH.DeathCoil;
	end

	-- scourge_strike,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&cooldown.army_of_the_dead.remains>5;
	-- clawing_shadows,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&cooldown.army_of_the_dead.remains>5;
	if runes >= 1 and (
		(
			(debuff[UH.FesteringWound].up and cooldown[UH.Apocalypse].remains > 5) or
			debuff[UH.FesteringWound].count > 4
		) --and cooldown[UH.ArmyOfTheDead].remains > 5
	) then
		if talents[UH.ClawingShadows] then
			return UH.ClawingShadows;
		else
			return UH.ScourgeStrike;
		end
	end

	-- death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle;
	if runicPowerDeficit < 20 and not poolingForGargoyle then
		return UH.DeathCoil;
	end

	-- festering_strike,if=((((debuff.festering_wound.stack<4&!buff.unholy_frenzy.up)|debuff.festering_wound.stack<3)&cooldown.apocalypse.remains<3)|debuff.festering_wound.stack<1)&cooldown.army_of_the_dead.remains>5;
	if runes >= 2 and (
		(
			(
				((debuff[UH.FesteringWound].count < 4 and not buff[UH.UnholyFrenzy].up) or debuff[UH.FesteringWound].count < 3) and
				cooldown[UH.Apocalypse].remains < 3
			) or debuff[UH.FesteringWound].count < 1
		) --and cooldown[UH.ArmyOfTheDead].remains > 5
	) then
		return UH.FesteringStrike;
	end

	-- death_coil,if=!variable.pooling_for_gargoyle;
	if canDeathCoil and not poolingForGargoyle then
		return UH.DeathCoil;
	end
end

function DeathKnight:UnholyCooldowns()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local gcd = fd.gcd;
	local timeToDie = fd.timeToDie;
	local runes = fd.runes;
	local runicPower = fd.runicPower;
	local runicPowerDeficit = fd.runicPowerDeficit;

	-- apocalypse,if=debuff.festering_wound.stack>=4;
	if not DeathKnight.db.unholyApocalypseAsCooldown and cooldown[UH.Apocalypse].ready and
		debuff[UH.FesteringWound].count >= 4
	then
		return UH.Apocalypse;
	end

	-- dark_transformation,if=!raid_event.adds.exists|raid_event.adds.in>15;
	if not DeathKnight.db.unholyDarkTransformationAsCooldown and cooldown[UH.DarkTransformation].ready then
		return UH.DarkTransformation;
	end

	if talents[UH.UnholyFrenzy] and not DeathKnight.db.unholyUnholyFrenzyAsCooldown and cooldown[UH.UnholyFrenzy].ready then
		-- unholy_frenzy,if=debuff.festering_wound.stack<4&!(equipped.ramping_amplitude_gigavolt_engine|azerite.magus_of_the_dead.enabled);
		if debuff[UH.FesteringWound].count < 4 and
			not (IsEquippedItem(RampingAmplitudeGigavoltEngine) or azerite[A.MagusOfTheDead] > 0)
		then
			return UH.UnholyFrenzy;
		end

		-- unholy_frenzy,if=cooldown.apocalypse.remains<2&(equipped.ramping_amplitude_gigavolt_engine|azerite.magus_of_the_dead.enabled);
		if cooldown[UH.Apocalypse].remains < 2 and
			(IsEquippedItem(RampingAmplitudeGigavoltEngine) or azerite[A.MagusOfTheDead] > 0)
		then
			return UH.UnholyFrenzy;
		end

		-- unholy_frenzy,if=active_enemies>=2&((cooldown.death_and_decay.remains<=gcd&!talent.defile.enabled)|(cooldown.defile.remains<=gcd&talent.defile.enabled));
		if targets >= 2 and (
			(cooldown[UH.DeathAndDecay].remains <= gcd and not talents[UH.Defile]) or
			(cooldown[UH.Defile].remains <= gcd and talents[UH.Defile])
		) then
			return UH.UnholyFrenzy;
		end
	end

	-- soul_reaper,target_if=target.time_to_die<8&target.time_to_die>4;
	if talents[UH.SoulReaper] and cooldown[UH.SoulReaper].ready and timeToDie < 8 and timeToDie > 4 then
		return UH.SoulReaper;
	end

	-- soul_reaper,if=(!raid_event.adds.exists|raid_event.adds.in>20)&rune<=(1-buff.unholy_frenzy.up);
	if talents[UH.SoulReaper] and cooldown[UH.SoulReaper].ready and runes <= (1 - buff[UH.UnholyFrenzy].upMath) then
		return UH.SoulReaper;
	end

	-- unholy_blight;
	if talents[UH.UnholyBlight] and cooldown[UH.UnholyBlight].ready and runes >= 1 then
		return UH.UnholyBlight;
	end
end

function DeathKnight:UnholyGeneric()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local runes = fd.runes;
	local runicPower = fd.runicPower;
	local poolingForGargoyle = fd.poolingForGargoyle;
	local runicPowerDeficit = fd.runicPowerDeficit;
	local petGargoyle = fd.petGargoyle;
	local canDeathCoil = fd.canDeathCoil;

	-- death_coil,if=buff.sudden_doom.react&!variable.pooling_for_gargoyle|pet.gargoyle.active;
	if buff[UH.SuddenDoom].up and not poolingForGargoyle or petGargoyle and canDeathCoil then
		return UH.DeathCoil;
	end

	-- death_coil,if=runic_power.deficit<14&(cooldown.apocalypse.remains>5|debuff.festering_wound.stack>4)&!variable.pooling_for_gargoyle;
	if runicPowerDeficit < 14 and (cooldown[UH.Apocalypse].remains > 5 or debuff[UH.FesteringWound].count > 4) and
		not poolingForGargoyle
	then
		return UH.DeathCoil;
	end

	-- death_and_decay,if=talent.pestilence.enabled&cooldown.apocalypse.remains;
	if cooldown[UH.DeathAndDecay].ready and runes >= 1 and talents[UH.Pestilence] and not cooldown[UH.Apocalypse].ready then
		return UH.DeathAndDecay;
	end

	-- defile,if=cooldown.apocalypse.remains;
	if talents[UH.Defile] and cooldown[UH.Defile].ready and runes >= 1 and not cooldown[UH.Apocalypse].ready then
		return UH.Defile;
	end

	-- scourge_strike,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&cooldown.army_of_the_dead.remains>5;
	-- clawing_shadows,if=((debuff.festering_wound.up&cooldown.apocalypse.remains>5)|debuff.festering_wound.stack>4)&cooldown.army_of_the_dead.remains>5;
	if runes >= 1 and (
		((debuff[UH.FesteringWound].up and cooldown[UH.Apocalypse].remains > 5) or debuff[UH.FesteringWound].count > 4)
			--and cooldown[UH.ArmyOfTheDead].remains > 5
	) then
		if talents[UH.ClawingShadows] then
			return UH.ClawingShadows;
		else
			return UH.ScourgeStrike;
		end
	end

	-- death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle;
	if runicPowerDeficit < 20 and not poolingForGargoyle then
		return UH.DeathCoil;
	end

	-- festering_strike,if=((((debuff.festering_wound.stack<4&!buff.unholy_frenzy.up)|debuff.festering_wound.stack<3)&cooldown.apocalypse.remains<3)|debuff.festering_wound.stack<1)&cooldown.army_of_the_dead.remains>5;
	if runes >= 2 and (
		(
			(
				(
					(debuff[UH.FesteringWound].count < 4 and not buff[UH.UnholyFrenzy].up) or
						debuff[UH.FesteringWound].count < 3
				) and cooldown[UH.Apocalypse].remains < 3
			) or
				debuff[UH.FesteringWound].count < 1
		) --and cooldown[UH.ArmyOfTheDead].remains > 5
	) then
		return UH.FesteringStrike;
	end

	-- death_coil,if=!variable.pooling_for_gargoyle;
	if canDeathCoil and not poolingForGargoyle then
		return UH.DeathCoil;
	end
end