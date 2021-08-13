if select(2, UnitClass("player")) ~= "ROGUE" then return end

local _, MaxDps_RogueTable = ...;

--- @type MaxDps
if not MaxDps then return end

local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local GetPowerRegen = GetPowerRegen;
local ComboPoints = Enum.PowerType.ComboPoints;
local Energy = Enum.PowerType.Energy;
local Rogue = MaxDps_RogueTable.Rogue;


-- Assassination
local AS = {
	Vanish			 = 1856,
	MarkedForDeath   = 137619,
	Vendetta         = 79140,
	Subterfuge       = 108208,
	Garrote          = 703,
	Rupture          = 1943,
	Nightstalker     = 14062,
	Exsanguinate     = 200806,
	DeeperStratagem  = 193531,
	
	MasterAssassin   = 255989,
	ToxicBlade       = 245388,
	PoisonedKnife    = 185565,
	FanOfKnives      = 51723,
	HiddenBlades     = 270061,
	Blindside        = 111240,
	BlindsideAura    = 121153,
	VenomRush        = 152152,
	CrimsonTempest   = 121411,
	Mutilate         = 1329,
	Envenom          = 32645,
	Shiv			 = 5938,
	Ambush           = 8676,

	SharpenedBlades  = 272916,
	InternalBleeding = 154904,
	SliceAndDice	 = 315496,
	
	--Covenant
	Sepsis               = 328305,
	SepsisAura           = 347037,
	Flagellation		 = 323654,
	SerratedBoneSpear	 = 328547,
	SerratedBoneSpearAura = 324073,
	EchoingReprimand 	 = 323547,

	-- Auras
	Stealth         	 = 1784,
	StealthSub			 = 115191,
	VanishAura           = 11327,
	InstantPoison        = 315584,
	DeadlyPoison     	 = 2823,
	DeadlyPoisonAura 	 = 2818,
	ShivAura			 = 319504,
	SubterfugeAura		 = 115192,
	HiddenBladesAura	 = 270070,
	MasterAssassinAura   = 256735,
	
	--Lego
	MarkOfTheMasterAssassin	= 7111,
};

local CN = {
	None      = 0,
	Kyrian    = 1,
	Venthyr   = 2,
	NightFae  = 3,
	Necrolord = 4
};

setmetatable(AS, Rogue.spellMeta);


local auraMetaTable = {
	__index = function()
		return {
			up          = false,
			count       = 0,
			remains     = 0,
			refreshable = true,
		};
	end
};

function Rogue:PoisonedBleeds(timeShift)
	local poisoned = 0;
	for i, frame in pairs(C_NamePlate.GetNamePlates()) do
		local unit = frame.UnitFrame.unit;

		if frame:IsVisible() then
			local debuff = setmetatable({}, auraMetaTable);

			MaxDps:CollectAura(unit, timeShift, debuff, 'PLAYER|HARMFUL');

			if debuff[AS.DeadlyPoisonAura].up then
				poisoned = poisoned +
					debuff[AS.Rupture].count +
					debuff[AS.Garrote].count +
					debuff[AS.InternalBleeding].count;
			end

		end
	end

	return poisoned;
end

function Rogue:Assassination()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, talents, azerite, currentSpell, timeShift, timeToDie =
	fd.cooldown, fd.buff, fd.debuff, fd.talents, fd.azerite, fd.currentSpell, fd.timeShift, fd.timeToDie;

	local energy = UnitPower('player', Energy);
	local energyMax = UnitPowerMax('player', Energy);
	local energyRegen = GetPowerRegen();
	local energyTimeToMax = (energyMax - energy) / energyRegen;

	local combo = UnitPower('player', ComboPoints);
	local comboMax = UnitPowerMax('player', ComboPoints);
	local comboDeficit = comboMax - combo;

	local spellHaste = MaxDps:AttackHaste();
	local targets = MaxDps:SmartAoe();
	local cpMaxSpend = 5 + (talents[AS.DeeperStratagem] and 1 or 0);

	local stealthed = buff[AS.Stealth].up or buff[AS.StealthSub].up or buff[AS.VanishAura].up;
	local poisonedBleeds = Rogue:PoisonedBleeds(timeShift);
	local energyRegenCombined = energyRegen + poisonedBleeds * 7 % (2 * spellHaste);
	local vendettaNightstalkerCondition = not talents[AS.Nightstalker] or not talents[AS.Exsanguinate] or cooldown[AS.Exsanguinate].remains < 5 - 2 * (talents[AS.DeeperStratagem] and 1 or 0);

	fd.energy, fd.energyMax, fd.energyRegen, fd.energyTimeToMax, fd.combo, fd.comboMax, fd.comboDeficit, fd.stealthed, fd.targets, fd.energyRegenCombined, fd.cpMaxSpend =
	energy, energyMax, energyRegen, energyTimeToMax, combo, comboMax, comboDeficit, stealthed, targets, energyRegenCombined, cpMaxSpend;
	local effectiveEnergy = energy + energyRegen * timeShift;

	local stealth = IsStealthed();
	local inCombat = UnitAffectingCombat("player");
	local covenantId = fd.covenant.covenantId;
	local runeforge = fd.runeforge;
	
	-- vendetta,if=!stealthed.rogue&dot.rupture.ticking&(!talent.subterfuge.enabled|!azerite.shrouded_suffocation.enabled|dot.garrote.pmultiplier>1)&(!talent.nightstalker.enabled|!talent.exsanguinate.enabled|cooldown.exsanguinate.remains<5-2*talent.deeper_stratagem.enabled);
	MaxDps:GlowCooldown(
		AS.Vendetta,
		not stealthed and debuff[AS.Rupture].remains > 7 and debuff[AS.Vendetta].remains < 0.1 and vendettaNightstalkerCondition
	);

	MaxDps:GlowCooldown(AS.Vanish, cooldown[AS.Vanish].ready and not stealthed);

	if not buff[AS.DeadlyPoison].up then
		return AS.DeadlyPoison;
	end

	if not inCombat and buff[AS.DeadlyPoison].remains < 5 * 60 then
		return AS.DeadlyPoison;
	end
	
	if talents[AS.Subterfuge] and not stealth and not inCombat and not buff[AS.VanishAura].up then
		return AS.StealthSub;
	end
	
	if not talents[AS.Subterfuge] and not stealth and not inCombat and not buff[AS.VanishAura].up then
		return AS.Stealth;
	end
	
	if stealthed or buff[AS.SubterfugeAura].up then
		if talents[AS.Nightstalker] and talents[AS.CrimsonTempest] and targets >= 3 and combo >= 4 then
			return AS.CrimsonTempest;
		end
		
		if talents[AS.Nightstalker] and combo >= 4 and timeToDie > 6 then
			return AS.Rupture;
		end
		
		if cooldown[AS.Garrote].ready and talents[AS.Subterfuge] and debuff[AS.Garrote].remains < 12 and timeToDie > debuff[AS.Garrote].remains - 2 then
			return AS.Garrote;
		end

		if cooldown[AS.Garrote].ready and talents[AS.Subterfuge] and talents[AS.Exsanguinate] and targets == 1 and buff[AS.Subterfuge].remains < 1.3 then
			return AS.Garrote;
		end
		
		if talents[AS.Subterfuge] and combo <= 3 then
			return AS.Mutilate;
		end
	end

	--cds
	if (not talents[AS.MasterAssassin] or debuff[AS.Garrote].remains > 6) then
		if cooldown[AS.MarkedForDeath].ready and talents[AS.MarkedForDeath] and (combo <= 1 or timeToDie <= 2) then
			return AS.MarkedForDeath;
		end
		
		if covenantId == CN.Venthyr and cooldown[AS.Flagellation].ready and not stealthed and (cooldown[AS.Vendetta].remains > 90 and combo >= 4 and timeToDie > 10 or debuff[AS.Vendetta].up) then
			return AS.Flagellation;
		end
		
		if covenantId == CN.NightFae and cooldown[AS.Sepsis].ready and not stealthed and (timeToDie > 10 or debuff[Vendetta].up) then
			return AS.Sepsis;
		end
		
		if talents[AS.Exsanguinate] and cooldown[AS.Exsanguinate].ready and not stealthed and (debuff[AS.Garrote].remains > 6 and debuff[AS.Rupture].remains > 2 + 4 * comboMax or timeToDie < debuff[AS.Rupture].remains * 0.5) and timeToDie > 4 then
			return AS.Exsanguinate;
		end
		
		if cooldown[AS.Shiv].ready and debuff[AS.Rupture].remains > 7 then
			return AS.Shiv;
		end
		
		if cooldown[AS.Vanish].ready then
			if talents[AS.Exsanguinate] and talents[AS.Nightstalker] and combo >= 4 and cooldown[AS.Exsanguinate].remains < 1 then
				return AS.Vanish; end
			if talents[AS.Exsanguinate] and not talents[AS.Nightstalker] and combo >= 4 and debuff[AS.Vendetta].up then
				return AS.Vanish; end
			if talents[AS.Subterfuge] and cooldown[AS.Garrote].ready and (debuff[AS.Garrote].refreshable or debuff[AS.Vendetta].up) and comboDeficit >= 1 then
				return AS.Vanish; end
			if (talents[AS.MasterAssassin] or runeforge[AS.MarkOfTheMasterAssassin]) and debuff[AS.Rupture].remains > 7 and debuff[AS.Garrote].remains > 3 and debuff[AS.Vendetta].up and (debuff[AS.ShivAura].up or debuff[AS.Vendetta].remains < 4 or debuff[AS.SepsisAura].remains > 0.1) and debuff[AS.Sepsis].remains < 3 then
				return AS.Vanish; end
		end
	end
	
	if not buff[AS.SliceAndDice].up and combo >= 3 then
		return AS.SliceAndDice;
	end
	
	if buff[AS.SliceAndDice].up and buff[AS.SliceAndDice].remains < 5 and combo >= 4 then
		return AS.Envenom;
	end
	
	if cooldown[AS.Garrote].ready and talents[AS.Exsanguinate] and debuff[AS.Exsanguinate].remains < 0.1 and cooldown[AS.Exsanguinate].remains < 2 and targets == 1 and timeToDie > debuff[AS.Garrote].remains * 0.5 then
		return AS.Garrote;
	end
	
	if talents[AS.Exsanguinate] and (combo >= comboMax and cooldown[AS.Exsanguinate].remains < 1 and timeToDie > debuff[AS.Rupture].remains * 0.5) then
		return AS.Rupture;
	end
	
	if cooldown[AS.Garrote].ready and debuff[AS.Garrote].refreshable and comboDeficit >= 1 and timeToDie > 4 and not buff[AS.MasterAssassinAura].up then
		return AS.Garrote;
	end
	
	if talents[AS.CrimsonTempest] and targets >= 2 and debuff[AS.CrimsonTempest].remains < 2 + targets and combo >= 4 and energyRegenCombined > 20 and (debuff[AS.Rupture].remains > 0.5 or not cooldown[AS.Vendette].ready) then
		return AS.CrimsonTempest;
	end
	
	if combo >= 4 and debuff[AS.Rupture].refreshable and timeToDie > 4 then
		return AS.Rupture;
	end
	
	if talents[AS.CrimsonTempest] and targets >= 2 and debuff[AS.CrimsonTempest].remains < 2 + targets and combo >= 4 then
		return AS.CrimsonTempest;
	end

	return Rogue:AssassinationDirect();
end

function Rogue:AssassinationDirect()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, talents, azerite =
	fd.cooldown, fd.buff, fd.debuff, fd.talents, fd.azerite;
	local targets = MaxDps:SmartAoe();

	local energy, energyMax, energyRegen, combo, targets, timeShift, cpMaxSpend, spellHistory, timeToDie, comboDeficit, energyRegenCombined, stealthed =
	fd.energy, fd.energyMax, fd.energyRegen, fd.combo, fd.targets, fd.timeShift, fd.cpMaxSpend, fd.spellHistory, fd.timeToDie, fd.comboDeficit, fd.energyRegenCombined, fd.stealthed;

	local bleedEnergy = energy + energyRegenCombined * timeShift;
	local energyDeficit = energyMax - energy;
	local effectiveEnergy = energy + energyRegen * timeShift;
	local covenantId = fd.covenant.covenantId;

	-- envenom,if=combo_points>=4+talent.deeper_stratagem.enabled&(debuff.vendetta.up|debuff.toxic_blade.up|energy.deficit<=25+variable.energy_regen_combined|!variable.single_target)&(!talent.exsanguinate.enabled|cooldown.exsanguinate.remains>2);
	if combo >= 4 + (talents[AS.DeeperStratagem] and 1 or 0) and
		(debuff[AS.Vendetta].up or debuff[AS.ToxicBlade].up or energyDeficit <= 25 + energyRegenCombined or targets >= 2 or timeToDie < 5) and
		(not talents[AS.Exsanguinate] or cooldown[AS.Exsanguinate].remains > 2)
	then
		return AS.Envenom;
	end

	-- variable,name=use_filler,value=combo_points.deficit>1|energy.deficit<=25+variable.energy_regen_combined|!variable.single_target;
	local useFiller = comboDeficit > 1 or energyDeficit <= 25 + energyRegenCombined or targets >= 2;
	
	if covenantId == CN.Necrolord and energy >= 15 and cooldown[AS.SerratedBoneSpear].charges >= 1 and (not debuff[AS.SerratedBoneSpearAura].up or cooldown[AS.SerratedBoneSpear].charges > 2.75) then
		return AS.SerratedBoneSpear;
	end

	-- fan_of_knives,if=variable.use_filler&(buff.hidden_blades.stack>=19|spell_targets.fan_of_knives>=4+(azerite.double_dose.rank>2)+stealthed.rogue);
	if useFiller and (
		buff[AS.HiddenBladesAura].count >= 19 or
			targets >= 4 + (stealthed and 1 or 0)
	) then
		return AS.FanOfKnives;
	end

	-- fan_of_knives,target_if=!dot.deadly_poison_dot.ticking,if=variable.use_filler&spell_targets.fan_of_knives>=3;
	if useFiller and targets >= 3 then
		return AS.FanOfKnives;
	end

	if covenantId == CN.Kyrian and useFiller and cooldown[AS.Vendetta].remains > 10 then
		return AS.EchoingReprimand;
	end
	
	if useFiller and buff[AS.BlindsideAura].up then
		return AS.Ambush;
	end

	-- mutilate,if=variable.use_filler;
	if useFiller then
		return AS.Mutilate;
	end
end
