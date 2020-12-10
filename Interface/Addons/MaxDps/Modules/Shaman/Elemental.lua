if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, MaxDps_ShamanTable = ...;

--- @type MaxDps
if not MaxDps then return end
local MaxDps = MaxDps;
local UnitExists = UnitExists;
local UnitPower = UnitPower;
local GetUnitSpeed = GetUnitSpeed;
local Maelstrom = Enum.PowerType.Maelstrom;
local Necrolord = Enum.CovenantType.Necrolord;
local Venthyr = Enum.CovenantType.Venthyr;
local NightFae = Enum.CovenantType.NightFae;
local Kyrian = Enum.CovenantType.Kyrian;

local Shaman = MaxDps_ShamanTable.Shaman;

local EL = {
	EarthElemental                = 198103,
	PrimalElementalist            = 117013,
	Stormkeeper                   = 191634,
	ElementalBlast                = 117014,
	LavaBurst                     = 51505,
	WindShear                     = 57994,
	FlameShock                    = 188389,
	FireElemental                 = 198067,
	StormElemental                = 192249,
	PrimordialWave                = 326059,
	VesperTotem                   = 324386,
	FaeTransfusion                = 328923,
	Earthquake                    = 61882,
	EchoingShock                  = 320125,
	ChainHarvest                  = 320674,
	Ascendance                    = 114050,
	Icefury                       = 210714,
	LiquidMagmaTotem              = 192222,
	EarthShock                    = 8042,
	LavaSurge                     = 77756,
	MasterOfTheElements           = 16166,
	MasterOfTheElementsAura       = 260734,
	ChainLightning                = 188443,
	FrostShock                    = 196840,
	Bloodlust                     = 2825,
	WindGust                      = 157331,
	WindGustAura                  = 263806,
	LightningBolt                 = 188196,
	EchoOfTheElements             = 108283,
	StaticDischarge               = 342243,
	LavaBeam                      = 114074,

	-- leggos
	EchoesOfGreatSunderingBonusId = 6991,
	EchoesOfGreatSundering        = 336217,

	ElementalEquilibriumBonusId   = 6990,
	ElementalEquilibriumDebuff    = 347349

};

setmetatable(EL, Shaman.spellMeta);

function Shaman:Elemental()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local covenantId = fd.covenant.covenantId;
	local targets = MaxDps:SmartAoe();
	local currentSpell = fd.currentSpell;
	local moving = GetUnitSpeed('player') > 0;
	local maelstrom = UnitPower('player', Maelstrom);

	local buffMasterOfElements = buff[EL.MasterOfTheElementsAura].up;

	if currentSpell == EL.LavaBurst then
		maelstrom = maelstrom + 10;
		buffMasterOfElements = true;
	elseif currentSpell == EL.LightningBolt then
		maelstrom = maelstrom + 8;
		buffMasterOfElements = false;
	elseif currentSpell == EL.Icefury then
		maelstrom = maelstrom + 25;
		buffMasterOfElements = false;
	elseif currentSpell == EL.ChainLightning or currentSpell == EL.LavaBeam then
		maelstrom = maelstrom + 4 * (targets - 1);
		buffMasterOfElements = false;
	end

	local petActive = UnitExists('pet');
	local canLavaBurst = buff[EL.LavaSurge].up or (currentSpell ~= EL.LavaBurst and cooldown[EL.LavaBurst].ready)
		or (currentSpell == EL.LavaBurst and cooldown[EL.LavaBurst].charges >= 2);

	fd.buffMasterOfElements = buffMasterOfElements;
	fd.maelstrom = maelstrom;
	fd.canLavaBurst = canLavaBurst;
	fd.moving = moving;
	fd.targets = targets;

	if talents[EL.Ascendance] then
		MaxDps:GlowCooldown(EL.Ascendance, cooldown[EL.Ascendance].ready);
	end

	if talents[EL.StormElemental] then
		MaxDps:GlowCooldown(
			EL.StormElemental,
			not petActive and cooldown[EL.StormElemental].ready and
			(not talents[EL.Icefury] or not buff[EL.Icefury].up and not cooldown[EL.Icefury].up) and
			(not talents[EL.Ascendance] or not cooldown[EL.Ascendance].up and not buff[EL.Ascendance].up)
		);
	else
		MaxDps:GlowCooldown(EL.FireElemental, not petActive and cooldown[EL.FireElemental].ready);
	end

	MaxDps:GlowCooldown(
		EL.EarthElemental,
		not petActive and cooldown[EL.EarthElemental].ready and
		(
			not talents[EL.PrimalElementalist] or
			talents[EL.PrimalElementalist] and (
				cooldown[EL.FireElemental].remains < 120 and not talents[EL.StormElemental] or
				cooldown[EL.StormElemental].remains < 120 and talents[EL.StormElemental]
			)
		)
	);

	-- flame_shock,if=!ticking;
	if cooldown[EL.FlameShock].ready and not debuff[EL.FlameShock].up then
		return EL.FlameShock;
	end

	-- fire_elemental;
	--if cooldown[EL.FireElemental].ready then
	--	return EL.FireElemental;
	--end

	-- storm_elemental;
	--if talents[EL.StormElemental] and cooldown[EL.StormElemental].ready then
	--	return EL.StormElemental;
	--end

	-- primordial_wave,target_if=min:dot.flame_shock.remains,cycle_targets=1,if=!buff.primordial_wave.up;
	if covenantId == Necrolord and cooldown[EL.PrimordialWave].ready and not buff[EL.PrimordialWave].up then
		return EL.PrimordialWave;
	end

	-- vesper_totem,if=covenant.kyrian;
	if  covenantId == Kyrian and cooldown[EL.VesperTotem].ready then
		return EL.VesperTotem;
	end

	-- fae_transfusion,if=covenant.night_fae;
	if covenantId == NightFae and cooldown[EL.FaeTransfusion].ready and currentSpell ~= EL.FaeTransfusion then
		return EL.FaeTransfusion;
	end

	-- run_action_list,name=aoe,if=active_enemies>2&(spell_targets.chain_lightning>2|spell_targets.lava_beam>2);
	if targets > 2 then
		return Shaman:ElementalAoe();
	end

	-- run_action_list,name=single_target,if=!talent.storm_elemental.enabled&active_enemies<=2;
	if not talents[EL.StormElemental] and targets <= 2 then
		return Shaman:ElementalSingleTarget();
	end

	-- run_action_list,name=se_single_target,if=talent.storm_elemental.enabled&active_enemies<=2;
	if talents[EL.StormElemental] and targets <= 2 then
		return Shaman:ElementalSeSingleTarget();
	end
end

function Shaman:ElementalAoe()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local targets = fd.targets;
	local gcd = fd.gcd;
	local maelstrom = fd.maelstrom;
	local runeforge = fd.runeforge;
	local canLavaBurst = fd.canLavaBurst;
	local moving = fd.moving;
	local buffMasterOfElements = fd.buffMasterOfElements;
	local covenantId = fd.covenant.covenantId;

	-- earthquake,if=buff.echoing_shock.up;
	if maelstrom >= 60 and buff[EL.EchoingShock].up then
		return EL.Earthquake;
	end

	-- chain_harvest;
	if covenantId == Venthyr and cooldown[EL.ChainHarvest].ready and currentSpell ~= EL.ChainHarvest then
		return EL.ChainHarvest;
	end

	-- stormkeeper,if=talent.stormkeeper.enabled;
	if talents[EL.Stormkeeper] and cooldown[EL.Stormkeeper].ready and currentSpell ~= EL.Stormkeeper then
		return EL.Stormkeeper;
	end

	-- flame_shock,if=active_dot.flame_shock<3&active_enemies<=5|runeforge.skybreakers_fiery_demise.equipped,target_if=refreshable;
	--if cooldown[EL.FlameShock].ready and (activeDot[EL.FlameShock] < 3 and targets <= 5 or runeforge[EL.SkybreakersFieryDemise]) then
	--	return EL.FlameShock;
	--end

	-- flame_shock,if=!active_dot.flame_shock;
	if cooldown[EL.FlameShock].ready and not debuff[EL.FlameShock].up then
		return EL.FlameShock;
	end

	-- echoing_shock,if=talent.echoing_shock.enabled&maelstrom>=60;
	if talents[EL.EchoingShock] and cooldown[EL.EchoingShock].ready and maelstrom >= 60 then
		return EL.EchoingShock;
	end

	-- ascendance,if=talent.ascendance.enabled&(!pet.storm_elemental.active)&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up);
	--if talents[EL.Ascendance] and cooldown[EL.Ascendance].ready and (talents[EL.Ascendance] and (not stormElementalActive) and (not talents[EL.Icefury] or not buff[EL.Icefury].up and not cooldown[EL.Icefury].up)) then
	--	return EL.Ascendance;
	--end

	-- liquid_magma_totem,if=talent.liquid_magma_totem.enabled;
	if talents[EL.LiquidMagmaTotem] and cooldown[EL.LiquidMagmaTotem].ready then
		return EL.LiquidMagmaTotem;
	end

	-- earth_shock,if=runeforge.echoes_of_great_sundering.equipped&!buff.echoes_of_great_sundering.up;
	if maelstrom >= 60 and runeforge[EL.EchoesOfGreatSunderingBonusId] and not buff[EL.EchoesOfGreatSundering].up then
		return EL.EarthShock;
	end

	-- earth_elemental,if=runeforge.deeptremor_stone.equipped&(!talent.primal_elementalist.enabled|(!pet.storm_elemental.active&!pet.fire_elemental.active));
	--if cooldown[EL.EarthElemental].ready and (runeforge[EL.DeeptremorStone] and (not talents[EL.PrimalElementalist] or (not stormElementalActive and not fireElementalActive))) then
	--	return EL.EarthElemental;
	--end

	-- lava_burst,target_if=dot.flame_shock.remains,if=spell_targets.chain_lightning<4|buff.lava_surge.up|(talent.master_of_the_elements.enabled&!buff.master_of_the_elements.up&maelstrom>=60);
	if canLavaBurst and (
		targets < 4 or
		buff[EL.LavaSurge].up or
		(talents[EL.MasterOfTheElements] and not buffMasterOfElements and maelstrom >= 60)
	) then
		return EL.LavaBurst;
	end

	-- earthquake,if=!talent.master_of_the_elements.enabled|buff.stormkeeper.up|maelstrom>=(100-4*spell_targets.chain_lightning)|buff.master_of_the_elements.up|spell_targets.chain_lightning>3;
	if maelstrom >= 60 and (
		not talents[EL.MasterOfTheElements] or
		buff[EL.Stormkeeper].up or
		maelstrom >= (100 - 4 * targets) or
		buffMasterOfElements or
		targets > 3
	) then
		return EL.Earthquake;
	end

	-- chain_lightning,if=buff.stormkeeper.remains<3*gcd*buff.stormkeeper.stack;
	if currentSpell ~= EL.ChainLightning and buff[EL.Stormkeeper].remains < 3 * gcd * buff[EL.Stormkeeper].count then
		return EL.ChainLightning;
	end

	-- lava_burst,if=buff.lava_surge.up&spell_targets.chain_lightning<4&(!pet.storm_elemental.active)&dot.flame_shock.ticking;
	if canLavaBurst and
		buff[EL.LavaSurge].up and
		targets < 4 and
		(not stormElementalActive)
		and debuff[EL.FlameShock].up
	then
		return EL.LavaBurst;
	end

	-- elemental_blast,if=talent.elemental_blast.enabled&spell_targets.chain_lightning<5&(!pet.storm_elemental.active);
	if talents[EL.ElementalBlast] and
		cooldown[EL.ElementalBlast].ready and
		currentSpell ~= EL.ElementalBlast and
		talents[EL.ElementalBlast] and
		targets < 5 and
		(not stormElementalActive)
	then
		return EL.ElementalBlast;
	end

	if moving then
		-- lava_burst,moving=1,if=buff.lava_surge.up&cooldown_react;
		if currentSpell ~= EL.LavaBurst and buff[EL.LavaSurge].up then
			return EL.LavaBurst;
		end

		-- flame_shock,moving=1,target_if=refreshable;
		if cooldown[EL.FlameShock].ready and debuff[EL.FlameShock].refreshable then
			return EL.FlameShock;
		end

		-- frost_shock,moving=1;
		return EL.FrostShock;
	end

	local chainLightning = MaxDps:FindSpell(EL.ChainLightning) and EL.ChainLightning or EL.LavaBeam;
	-- lava_beam,if=talent.ascendance.enabled;
	-- chain_lightning;
	return chainLightning;
end

function Shaman:ElementalSeSingleTarget()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local targets = fd.targets;
	local gcd = fd.gcd;
	local buffMasterOfElements = fd.buffMasterOfElements;
	local maelstrom = fd.maelstrom;
	local canLavaBurst = fd.canLavaBurst;
	local covenantId = fd.covenant.covenantId;
	local moving = fd.moving;

	-- flame_shock,target_if=(remains<=gcd)&(buff.lava_surge.up|!buff.bloodlust.up);
	if cooldown[EL.FlameShock].ready and debuff[EL.FlameShock].remains < gcd then
		return EL.FlameShock;
	end

	-- elemental_blast,if=talent.elemental_blast.enabled;
	if talents[EL.ElementalBlast] and cooldown[EL.ElementalBlast].ready and currentSpell ~= EL.ElementalBlast then
		return EL.ElementalBlast;
	end

	-- stormkeeper,if=talent.stormkeeper.enabled&(maelstrom<44);
	if talents[EL.Stormkeeper] and
		cooldown[EL.Stormkeeper].ready and
		currentSpell ~= EL.Stormkeeper and
		maelstrom < 44
	then
		return EL.Stormkeeper;
	end

	-- echoing_shock,if=talent.echoing_shock.enabled;
	if talents[EL.EchoingShock] and cooldown[EL.EchoingShock].ready then
		return EL.EchoingShock;
	end

	-- lava_burst,if=buff.wind_gust.stack<18|buff.lava_surge.up;
	if canLavaBurst and (buff[EL.WindGustAura].count < 18 or buff[EL.LavaSurge].up) then
		return EL.LavaBurst;
	end

	-- lightning_bolt,if=buff.stormkeeper.up;
	if buff[EL.Stormkeeper].up then
		return EL.LightningBolt;
	end

	-- earthquake,if=buff.echoes_of_great_sundering.up;
	if maelstrom >= 60 and buff[EL.EchoesOfGreatSundering].up then
		return EL.Earthquake;
	end

	-- earthquake,if=(spell_targets.chain_lightning>1)&(!dot.flame_shock.refreshable);
	if maelstrom >= 60 and targets > 1 and not debuff[EL.FlameShock].refreshable then
		return EL.Earthquake;
	end

	-- earth_shock,if=spell_targets.chain_lightning<2&maelstrom>=60&(buff.wind_gust.stack<20|maelstrom>90);
	if maelstrom >= 60 and targets < 2 and (buff[EL.WindGustAura].count < 20 or maelstrom > 90) then
		return EL.EarthShock;
	end

	-- lightning_bolt,if=(buff.stormkeeper.remains<1.1*gcd*buff.stormkeeper.stack|buff.stormkeeper.up&buff.master_of_the_elements.up);
	if currentSpell ~= EL.LightningBolt and (
		(buff[EL.Stormkeeper].remains < 1.1 * gcd * buff[EL.Stormkeeper].count or buff[EL.Stormkeeper].up and buffMasterOfElements)
	) then
		return EL.LightningBolt;
	end

	-- frost_shock,if=talent.icefury.enabled&talent.master_of_the_elements.enabled&buff.icefury.up&buff.master_of_the_elements.up;
	if talents[EL.Icefury] and talents[EL.MasterOfTheElements] and buff[EL.Icefury].up and buffMasterOfElements then
		return EL.FrostShock;
	end

	-- lava_burst,if=buff.ascendance.up;
	if canLavaBurst and buff[EL.Ascendance].up then
		return EL.LavaBurst;
	end

	-- lava_burst,if=cooldown_react&!talent.master_of_the_elements.enabled;
	if canLavaBurst and not talents[EL.MasterOfTheElements] then
		return EL.LavaBurst;
	end

	-- icefury,if=talent.icefury.enabled&!(maelstrom>75&cooldown.lava_burst.remains<=0);
	if talents[EL.Icefury] and cooldown[EL.Icefury].ready and currentSpell ~= EL.Icefury and
		not (maelstrom > 75 and cooldown[EL.LavaBurst].remains <= 0)
	then
		return EL.Icefury;
	end

	-- lava_burst,if=cooldown_react&charges>talent.echo_of_the_elements.enabled;
	-- TODO this prolly needs to be just canLavaBurst
	if canLavaBurst and cooldown[EL.LavaBurst].charges > (talents[EL.EchoOfTheElements] and 1 or 0) then
		return EL.LavaBurst;
	end

	-- frost_shock,if=talent.icefury.enabled&buff.icefury.up;
	if talents[EL.Icefury] and buff[EL.Icefury].up then
		return EL.FrostShock;
	end

	-- chain_harvest;
	if covenantId == Venthyr and cooldown[EL.ChainHarvest].ready and currentSpell ~= EL.ChainHarvest then
		return EL.ChainHarvest;
	end

	-- static_discharge,if=talent.static_discharge.enabled;
	if talents[EL.StaticDischarge] and cooldown[EL.StaticDischarge].ready then
		return EL.StaticDischarge;
	end

	-- earth_elemental,if=!talent.primal_elementalist.enabled|talent.primal_elementalist.enabled&(!pet.storm_elemental.active);
	--if cooldown[EL.EarthElemental].ready and (not talents[EL.PrimalElementalist] or talents[EL.PrimalElementalist] and (not stormElementalActive)) then
	--	return EL.EarthElemental;
	--end

	if moving then
		-- flame_shock,moving=1,target_if=refreshable;
		if cooldown[EL.FlameShock].refreshable then
			return EL.FlameShock;
		end

		-- flame_shock,moving=1,if=movement.distance>6;
		--if cooldown[EL.FlameShock].ready then
		--	return EL.FlameShock;
		--end

		-- frost_shock,moving=1;
		return EL.FrostShock;
	end

	-- lightning_bolt;
	return EL.LightningBolt;
end

function Shaman:ElementalSingleTarget()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local targets = fd.targets;
	local gcd = fd.gcd;
	local buffMasterOfElements = fd.buffMasterOfElements;
	local maelstrom = fd.maelstrom;
	local canLavaBurst = fd.canLavaBurst;
	local runeforge = fd.runeforge;
	local moving = fd.moving;
	local covenantId = fd.covenant.covenantId;

	-- flame_shock,target_if=(!ticking|dot.flame_shock.remains<=gcd|talent.ascendance.enabled&dot.flame_shock.remains<(cooldown.ascendance.remains+buff.ascendance.duration)&cooldown.ascendance.remains<4)&(buff.lava_surge.up|!buff.bloodlust.up);
	if cooldown[EL.FlameShock].refreshable then
		return EL.FlameShock;
	end

	-- ascendance,if=talent.ascendance.enabled&(time>=60|buff.bloodlust.up)&(cooldown.lava_burst.remains>0)&(!talent.icefury.enabled|!buff.icefury.up&!cooldown.icefury.up);
	--if talents[EL.Ascendance] and cooldown[EL.Ascendance].ready and (talents[EL.Ascendance] and (60 or buff[EL.Bloodlust].up) and (cooldown[EL.LavaBurst].remains > 0) and (not talents[EL.Icefury] or not buff[EL.Icefury].up and not cooldown[EL.Icefury].up)) then
	--	return EL.Ascendance;
	--end

	-- elemental_blast,if=talent.elemental_blast.enabled&(talent.master_of_the_elements.enabled&(buff.master_of_the_elements.up&maelstrom<60|!buff.master_of_the_elements.up)|!talent.master_of_the_elements.enabled);
	if talents[EL.ElementalBlast] and cooldown[EL.ElementalBlast].ready and currentSpell ~= EL.ElementalBlast and
	(
		talents[EL.MasterOfTheElements] and (buffMasterOfElements and maelstrom < 60 or not buffMasterOfElements) or
		not talents[EL.MasterOfTheElements]
	)
	then
		return EL.ElementalBlast;
	end

	-- stormkeeper,if=talent.stormkeeper.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)&(maelstrom<44);
	if talents[EL.Stormkeeper] and
		cooldown[EL.Stormkeeper].ready and
		currentSpell ~= EL.Stormkeeper and
		maelstrom < 44
	then
		return EL.Stormkeeper;
	end

	-- echoing_shock,if=talent.echoing_shock.enabled&cooldown.lava_burst.remains<=0;
	if talents[EL.EchoingShock] and cooldown[EL.EchoingShock].ready and cooldown[EL.LavaBurst].remains <= 0 then
		return EL.EchoingShock;
	end

	-- lava_burst,if=talent.echoing_shock.enabled&buff.echoing_shock.up;
	if canLavaBurst and talents[EL.EchoingShock] and buff[EL.EchoingShock].up then
		return EL.LavaBurst;
	end

	-- liquid_magma_totem,if=talent.liquid_magma_totem.enabled;
	if talents[EL.LiquidMagmaTotem] and cooldown[EL.LiquidMagmaTotem].ready then
		return EL.LiquidMagmaTotem;
	end

	-- lightning_bolt,if=buff.stormkeeper.up&spell_targets.chain_lightning<2&(buff.master_of_the_elements.up);
	if buff[EL.Stormkeeper].up and targets < 2 and buffMasterOfElements then
		return EL.LightningBolt;
	end

	-- earthquake,if=buff.echoes_of_great_sundering.up&(!talent.master_of_the_elements.enabled|buff.master_of_the_elements.up);
	if maelstrom >= 60 and
		buff[EL.EchoesOfGreatSundering].up and
		(not talents[EL.MasterOfTheElements] or buffMasterOfElements)
	then
		return EL.Earthquake;
	end

	-- earthquake,if=spell_targets.chain_lightning>1&!dot.flame_shock.refreshable&!runeforge.echoes_of_great_sundering.equipped&(!talent.master_of_the_elements.enabled|buff.master_of_the_elements.up|cooldown.lava_burst.remains>0&maelstrom>=92);
	if maelstrom >= 60 and
		targets > 1 and
		not debuff[EL.FlameShock].refreshable and
		not runeforge[EL.EchoesOfGreatSunderingBonusId] and
		(not talents[EL.MasterOfTheElements] or buffMasterOfElements or cooldown[EL.LavaBurst].remains > 0 and maelstrom >= 92)
	then
		return EL.Earthquake;
	end

	-- earth_shock,if=talent.master_of_the_elements.enabled&(buff.master_of_the_elements.up|cooldown.lava_burst.remains>0&maelstrom>=92|spell_targets.chain_lightning<2&buff.stormkeeper.up&cooldown.lava_burst.remains<=gcd)|!talent.master_of_the_elements.enabled;
	if maelstrom >= 60 and (
		talents[EL.MasterOfTheElements] and (
			buffMasterOfElements or
			cooldown[EL.LavaBurst].remains > 0 and maelstrom >= 92 or
			targets < 2 and buff[EL.Stormkeeper].up and cooldown[EL.LavaBurst].remains <= gcd
		) or
		not talents[EL.MasterOfTheElements]
	) then
		return EL.EarthShock;
	end

	-- lightning_bolt,if=(buff.stormkeeper.remains<1.1*gcd*buff.stormkeeper.stack|buff.stormkeeper.up&buff.master_of_the_elements.up);
	if buff[EL.Stormkeeper].remains < 1.1 * gcd * buff[EL.Stormkeeper].count or
		buff[EL.Stormkeeper].up and buffMasterOfElements
	then
		return EL.LightningBolt;
	end

	-- frost_shock,if=talent.icefury.enabled&talent.master_of_the_elements.enabled&buff.icefury.up&buff.master_of_the_elements.up;
	if talents[EL.Icefury] and talents[EL.MasterOfTheElements] and buff[EL.Icefury].up and buffMasterOfElements then
		return EL.FrostShock;
	end

	-- lava_burst,if=buff.ascendance.up;
	if buff[EL.Ascendance].up then
		return EL.LavaBurst;
	end

	-- lava_burst,if=cooldown_react&!talent.master_of_the_elements.enabled;
	if canLavaBurst and not talents[EL.MasterOfTheElements] then
		return EL.LavaBurst;
	end

	-- icefury,if=talent.icefury.enabled&!(maelstrom>75&cooldown.lava_burst.remains<=0);
	if talents[EL.Icefury] and cooldown[EL.Icefury].ready and currentSpell ~= EL.Icefury and
		not (maelstrom > 75 and cooldown[EL.LavaBurst].remains <= 0)
	then
		return EL.Icefury;
	end

	-- lava_burst,if=cooldown_react&charges>talent.echo_of_the_elements.enabled;
	if canLavaBurst and cooldown[EL.LavaBurst].charges > (talents[EL.EchoOfTheElements] and 1 or 0) then
		return EL.LavaBurst;
	end

	-- frost_shock,if=talent.icefury.enabled&buff.icefury.up&buff.icefury.remains<1.1*gcd*buff.icefury.stack;
	if talents[EL.Icefury] and buff[EL.Icefury].up and buff[EL.Icefury].remains < 1.1 * gcd * buff[EL.Icefury].count then
		return EL.FrostShock;
	end

	-- lava_burst,if=cooldown_react;
	if canLavaBurst then
		return EL.LavaBurst;
	end

	-- flame_shock,target_if=refreshable;
	if cooldown[EL.FlameShock].refreshable then
		return EL.FlameShock;
	end

	-- earthquake,if=spell_targets.chain_lightning>1&!runeforge.echoes_of_great_sundering.equipped|buff.echoes_of_great_sundering.up;
	if maelstrom >= 60 and (
		targets > 1 and not runeforge[EL.EchoesOfGreatSunderingBonusId] or
		buff[EL.EchoesOfGreatSundering].up
	) then
		return EL.Earthquake;
	end

	-- frost_shock,if=talent.icefury.enabled&buff.icefury.up&(buff.icefury.remains<gcd*4*buff.icefury.stack|buff.stormkeeper.up|!talent.master_of_the_elements.enabled);
	if talents[EL.Icefury] and buff[EL.Icefury].up and (
		buff[EL.Icefury].remains < gcd * 4 * buff[EL.Icefury].count or
		buff[EL.Stormkeeper].up or
		not talents[EL.MasterOfTheElements]
	) then
		return EL.FrostShock;
	end

	local elementalEquilibriumDebuff = MaxDps:IntUnitAura(
		'player',
		EL.ElementalEquilibriumDebuff,
		'HARMFUL',
		fd.timeShift
	);
	-- frost_shock,if=runeforge.elemental_equilibrium.equipped&!buff.elemental_equilibrium_debuff.up&!talent.elemental_blast.enabled&!talent.echoing_shock.enabled;
	if runeforge[EL.ElementalEquilibriumBonusId] and
		not elementalEquilibriumDebuff.up and
		not talents[EL.ElementalBlast] and
		not talents[EL.EchoingShock]
	then
		return EL.FrostShock;
	end

	-- chain_harvest;
	if covenantId == Venthyr and cooldown[EL.ChainHarvest].ready and currentSpell ~= EL.ChainHarvest then
		return EL.ChainHarvest;
	end

	-- static_discharge,if=talent.static_discharge.enabled;
	if talents[EL.StaticDischarge] and cooldown[EL.StaticDischarge].ready then
		return EL.StaticDischarge;
	end

	-- earth_elemental,if=!talent.primal_elementalist.enabled|!pet.fire_elemental.active;
	--if cooldown[EL.EarthElemental].ready and (not talents[EL.PrimalElementalist] or not fireElementalActive) then
	--	return EL.EarthElemental;
	--end

	if moving then
		-- flame_shock,moving=1,target_if=refreshable;
		if cooldown[EL.FlameShock].refreshable then
			return EL.FlameShock;
		end

		-- flame_shock,moving=1,if=movement.distance>6;
		--if cooldown[EL.FlameShock].ready and (6) then
		--	return EL.FlameShock;
		--end

		-- frost_shock,moving=1;
		return EL.FrostShock;

	end

	-- lightning_bolt;
	return EL.LightningBolt;
end