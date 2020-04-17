if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, MaxDps_ShamanTable = ...;

--- @type MaxDps
if not MaxDps then return end
local MaxDps = MaxDps;
local UnitExists = UnitExists;
local UnitPower = UnitPower;
local GetUnitSpeed = GetUnitSpeed;
local Maelstrom = Enum.PowerType.Maelstrom;

local Shaman = MaxDps_ShamanTable.Shaman;

local EL = {
	TotemMastery            = 210643,
	FireElemental           = 198067,
	ElementalBlast          = 117014,
	Bloodlust               = 2825,
	WindShear               = 57994,
	StormElemental          = 192249,
	EarthElemental          = 198103,
	Stormkeeper             = 191634,
	Ascendance              = 114050,
	LiquidMagmaTotem        = 192222,
	FlameShock              = 188389,
	Earthquake              = 61882,
	LavaBurst               = 51505,
	LavaSurge               = 77756,
	LavaSurge2              = 77762,
	ChainLightning          = 188443,
	FrostShock              = 196840,
	MasterOfTheElements     = 16166,
	MasterOfTheElementsAura = 260734,
	PrimalElementalist      = 117013,
	CallTheThunder          = 260897,
	SurgeOfPower            = 262303,
	SurgeOfPowerAura        = 285514,
	ExposedElements         = 260694,
	EchoOfTheElements       = 108283,
	LightningBolt           = 188196,
	EarthShock              = 8042,
	Icefury                 = 210714,

	ResonanceTotem          = 202192,
	LavaBeam                = 114074,
	WindGust                = 263806,

	IgneousPotential        = 279829,
};

setmetatable(EL, Shaman.spellMeta);

function Shaman:Elemental()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local talents = fd.talents;
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
		maelstrom = maelstrom + 15;
		buffMasterOfElements = false;
	elseif currentSpell == EL.ChainLightning or currentSpell == EL.LavaBeam then
		maelstrom = maelstrom + 4 * (targets - 1);
		buffMasterOfElements = false;
	end

	fd.buffMasterOfElements = buffMasterOfElements;
	fd.maelstrom = maelstrom;

	local tmRemains = Shaman:TotemMastery(EL.TotemMastery);
	local hasTotemMastery = tmRemains > 5 and buff[EL.ResonanceTotem].up;
	local pet = UnitExists('pet');

	local canLavaBurst = buff[EL.LavaSurge].up or (currentSpell ~= EL.LavaBurst and cooldown[EL.LavaBurst].ready)
		or (currentSpell == EL.LavaBurst and cooldown[EL.LavaBurst].charges >= 2);

	fd.canLavaBurst = canLavaBurst;
	fd.moving = moving;
	fd.targets = targets;
	fd.tmRemains = tmRemains;
	fd.hasTotemMastery = hasTotemMastery;

	MaxDps:GlowEssences();

	if talents[EL.Ascendance] then
		MaxDps:GlowCooldown(EL.Ascendance, cooldown[EL.Ascendance].ready);
	end

	if talents[EL.StormElemental] then
		MaxDps:GlowCooldown(
			EL.StormElemental,
			not pet and cooldown[EL.StormElemental].ready and
			(not talents[EL.Icefury] or not buff[EL.Icefury].up and not cooldown[EL.Icefury].up) and
			(not talents[EL.Ascendance] or not cooldown[EL.Ascendance].up and not buff[EL.Ascendance].up)
		);
	else
		MaxDps:GlowCooldown(EL.FireElemental, not pet and cooldown[EL.FireElemental].ready);
	end

	-- earth_elemental,if=!talent.primal_elementalist.enabled|talent.primal_elementalist.enabled&(cooldown.fire_elemental.remains<120&!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120&talent.storm_elemental.enabled);
	MaxDps:GlowCooldown(
		EL.EarthElemental,
		not pet and cooldown[EL.EarthElemental].ready and
			(not talents[EL.PrimalElementalist] or talents[EL.PrimalElementalist] and (
				cooldown[EL.FireElemental].remains < 120 and not talents[EL.StormElemental] or cooldown[EL.StormElemental].remains < 120 and talents[EL.StormElemental]
			)
		)
	);

	-- totem_mastery,if=talent.totem_mastery.enabled&buff.resonance_totem.remains<2;
	if talents[EL.TotemMastery] and not hasTotemMastery then
		return EL.TotemMastery;
	end

	-- run_action_list,name=aoe,if=active_enemies>2&(spell_targets.chain_lightning>2|spell_targets.lava_beam>2);
	if targets > 2 then
		return Shaman:ElementalAoe();
	end

	-- run_action_list,name=single_target;
	return Shaman:ElementalSingleTarget();
end

function Shaman:ElementalAoe()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local canLavaBurst = fd.canLavaBurst;
	local targets = fd.targets;
	local gcd = fd.gcd;
	local maelstrom = fd.maelstrom;
	local moving = fd.moving;
	local buffMasterOfElements = fd.buffMasterOfElements;
	local chainLightning = MaxDps:FindSpell(EL.ChainLightning) and EL.ChainLightning or EL.LavaBeam;

	-- stormkeeper,if=talent.stormkeeper.enabled;
	if cooldown[EL.Stormkeeper].ready and currentSpell ~= EL.Stormkeeper and talents[EL.Stormkeeper] then
		return EL.Stormkeeper;
	end

	-- flame_shock,target_if=refreshable&(spell_targets.chain_lightning<(5-!talent.totem_mastery.enabled)|!talent.storm_elemental.enabled&(cooldown.fire_elemental.remains>(120+14*spell_haste)|cooldown.fire_elemental.remains<(24-14*spell_haste)))&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120|spell_targets.chain_lightning=3&buff.wind_gust.stack<14);
	if cooldown[EL.FlameShock].ready and debuff[EL.FlameShock].refreshable then
		return EL.FlameShock;
	end

	-- liquid_magma_totem,if=talent.liquid_magma_totem.enabled;
	if talents[EL.LiquidMagmaTotem] and cooldown[EL.LiquidMagmaTotem].ready then
		return EL.LiquidMagmaTotem;
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
	if buff[EL.Stormkeeper].remains < 3 * gcd * buff[EL.Stormkeeper].count then
		return EL.ChainLightning;
	end

	-- lava_burst,if=buff.lava_surge.up&spell_targets.chain_lightning<4&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120)&dot.flame_shock.ticking;
	if canLavaBurst and (
		buff[EL.LavaSurge].up and
		targets < 4 and
		(not talents[EL.StormElemental] or cooldown[EL.StormElemental].remains < 120) and
		debuff[EL.FlameShock].up
	) then
		return EL.LavaBurst;
	end

	-- icefury,if=spell_targets.chain_lightning<4&!buff.ascendance.up;
	if talents[EL.Icefury] and
		cooldown[EL.Icefury].ready and
		currentSpell ~= EL.Icefury and
		targets < 4 and
		not buff[EL.Ascendance].up
	then
		return EL.Icefury;
	end

	-- frost_shock,if=spell_targets.chain_lightning<4&buff.icefury.up&!buff.ascendance.up;
	if targets < 4 and buff[EL.Icefury].up and not buff[EL.Ascendance].up then
		return EL.FrostShock;
	end

	-- elemental_blast,if=talent.elemental_blast.enabled&spell_targets.chain_lightning<4&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120);
	if talents[EL.ElementalBlast] and cooldown[EL.ElementalBlast].ready and currentSpell ~= EL.ElementalBlast and
		targets < 4 and (not talents[EL.StormElemental] or cooldown[EL.StormElemental].remains < 120)
	then
		return EL.ElementalBlast;
	end

	-- lava_beam,if=talent.ascendance.enabled;
	if talents[EL.Ascendance] and buff[EL.Ascendance].up then
		return EL.LavaBeam;
	end

	-- chain_lightning;
	if not moving then
		return EL.ChainLightning;
	end

	-- lava_burst,moving=1,if=talent.ascendance.enabled;
	if moving and canLavaBurst and talents[EL.Ascendance] then
		return EL.LavaBurst;
	end

	-- flame_shock,moving=1,target_if=refreshable;
	if moving and debuff[EL.FlameShock].refreshable and cooldown[EL.FlameShock].ready then
		return EL.FlameShock;
	end

	-- frost_shock,moving=1;
	if moving then
		return EL.FrostShock;
	end

	-- chain_lightning;
	-- Chain Lightning or Lava Beam
	return chainLightning;
end

function Shaman:ElementalSingleTarget()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local targets = fd.targets;
	local moving = fd.moving;
	local tmRemains = fd.tmRemains;
	local hasTotemMastery = fd.hasTotemMastery;
	local canLavaBurst = fd.canLavaBurst;
	local gcd = fd.gcd;
	local maelstrom = fd.maelstrom;
	local buffMasterOfElements = fd.buffMasterOfElements;

	-- flame_shock,if=(!ticking|talent.storm_elemental.enabled&cooldown.storm_elemental.remains<2*gcd|dot.flame_shock.remains<=gcd|talent.ascendance.enabled&dot.flame_shock.remains<(cooldown.ascendance.remains+buff.ascendance.duration)&cooldown.ascendance.remains<4&(!talent.storm_elemental.enabled|talent.storm_elemental.enabled&cooldown.storm_elemental.remains<120))&(buff.wind_gust.stack<14|azerite.igneous_potential.rank>=2|buff.lava_surge.up|!buff.bloodlust.up)&!buff.surge_of_power.up;
	if cooldown[EL.FlameShock].ready and (
		(
			not debuff[EL.FlameShock].up or
			debuff[EL.FlameShock].remains <= 3 or
			talents[EL.Ascendance] and
			debuff[EL.FlameShock].remains < (cooldown[EL.Ascendance].remains + buff[EL.Ascendance].duration) and
			cooldown[EL.Ascendance].remains < 4 and
			(not talents[EL.StormElemental] or talents[EL.StormElemental] and cooldown[EL.StormElemental].remains < 120)
		) and (
			buff[EL.WindGust].count < 14 or
			azerite[EL.IgneousPotential] >= 2 or
			buff[EL.LavaSurge].up or
			not buff[EL.Bloodlust].up) and not buff[EL.SurgeOfPowerAura].up
		)
	then
		return EL.FlameShock;
	end

	-- elemental_blast,if=talent.elemental_blast.enabled&(talent.master_of_the_elements.enabled&buff.master_of_the_elements.up&maelstrom<60|!talent.master_of_the_elements.enabled)&(!(cooldown.storm_elemental.remains>120&talent.storm_elemental.enabled)|azerite.natural_harmony.rank=3&buff.wind_gust.stack<14);
	if talents[EL.ElementalBlast] and cooldown[EL.ElementalBlast].ready and currentSpell ~= EL.ElementalBlast and
		(
			talents[EL.MasterOfTheElements] and buffMasterOfElements and maelstrom < 60 or
			not talents[EL.MasterOfTheElements]
		) and (
			not (cooldown[EL.StormElemental].remains > 120 and talents[EL.StormElemental]) or
			azerite[EL.NaturalHarmony] == 3 and buff[EL.WindGust].count < 14
		)
	then
		return EL.ElementalBlast;
	end

	-- stormkeeper,if=talent.stormkeeper.enabled&(raid_event.adds.count<3|raid_event.adds.in>50)&(!talent.surge_of_power.enabled|buff.surge_of_power.up|maelstrom>=44);
	if talents[EL.Stormkeeper] and cooldown[EL.Stormkeeper].ready and currentSpell ~= EL.Stormkeeper and (
		(not talents[EL.SurgeOfPower] or buff[EL.SurgeOfPowerAura].up or maelstrom >= 44)
	) then
		return EL.Stormkeeper;
	end

	-- liquid_magma_totem,if=talent.liquid_magma_totem.enabled&(raid_event.adds.count<3|raid_event.adds.in>50);
	if talents[EL.LiquidMagmaTotem] and cooldown[EL.LiquidMagmaTotem].ready then
		return EL.LiquidMagmaTotem;
	end

	-- lightning_bolt,if=buff.stormkeeper.up&spell_targets.chain_lightning<2&(buff.master_of_the_elements.up&!talent.surge_of_power.enabled|buff.surge_of_power.up);
	if currentSpell ~= EL.LightningBolt and
		buff[EL.Stormkeeper].up and targets < 2 and
			(buffMasterOfElements and not talents[EL.SurgeOfPower] or buff[EL.SurgeOfPowerAura].up)
	then
		return EL.LightningBolt;
	end

	-- earthquake,if=spell_targets.chain_lightning>1&(!talent.surge_of_power.enabled|!dot.flame_shock.refreshable|cooldown.storm_elemental.remains>120)&(!talent.master_of_the_elements.enabled|buff.master_of_the_elements.up|maelstrom>=92);
	if maelstrom >= 60 and (
		targets > 1 and (
			not talents[EL.SurgeOfPower] or
			not debuff[EL.FlameShock].refreshable or
			cooldown[EL.StormElemental].remains > 120
		) and (
			not talents[EL.MasterOfTheElements] or
				buffMasterOfElements or maelstrom >= 92
		)
	) then
		return EL.Earthquake;
	end

	-- earth_shock,if=!buff.surge_of_power.up&talent.master_of_the_elements.enabled&(buff.master_of_the_elements.up|cooldown.lava_burst.remains>0&maelstrom>=92+30*talent.call_the_thunder.enabled|buff.stormkeeper.up&cooldown.lava_burst.remains<=gcd);
	if maelstrom >= 60 and (
		not buff[EL.SurgeOfPowerAura].up and
		talents[EL.MasterOfTheElements] and (
			buffMasterOfElements or
			cooldown[EL.LavaBurst].remains > 0 and maelstrom >= 92 + 30 * (talents[EL.CallTheThunder] and 1 or 0) or
			buff[EL.Stormkeeper].up and cooldown[EL.LavaBurst].remains <= gcd
		)
	) then
		return EL.EarthShock;
	end

	-- earth_shock,if=!talent.master_of_the_elements.enabled&!(azerite.igneous_potential.rank>2&buff.ascendance.up)&(buff.stormkeeper.up|maelstrom>=90+30*talent.call_the_thunder.enabled|!(cooldown.storm_elemental.remains>120&talent.storm_elemental.enabled)&expected_combat_length-time-cooldown.storm_elemental.remains-150*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%150)>=30*(1+(azerite.echo_of_the_elementals.rank>=2)));
	if maelstrom >= 60 and (
		not talents[EL.MasterOfTheElements] and
		not (azerite[EL.IgneousPotential] > 2 and buff[EL.Ascendance].up) and (
			buff[EL.Stormkeeper].up or
			maelstrom >= 90 + 30 * (talents[EL.CallTheThunder] and 1 or 0)
		)
	) then
		return EL.EarthShock;
	end

	-- earth_shock,if=talent.surge_of_power.enabled&!buff.surge_of_power.up&cooldown.lava_burst.remains<=gcd&(!talent.storm_elemental.enabled&!(cooldown.fire_elemental.remains>120)|talent.storm_elemental.enabled&!(cooldown.storm_elemental.remains>120));
	if maelstrom >= 60 and (
		talents[EL.SurgeOfPower] and
			not buff[EL.SurgeOfPowerAura].up and
			cooldown[EL.LavaBurst].remains <= gcd
	) then
		return EL.EarthShock;
	end

	-- lightning_bolt,if=cooldown.storm_elemental.remains>120&talent.storm_elemental.enabled&(azerite.igneous_potential.rank<2|!buff.lava_surge.up&buff.bloodlust.up);
	if currentSpell ~= EL.LightningBolt and (
		cooldown[EL.StormElemental].remains > 120 and
		talents[EL.StormElemental] and (
			azerite[EL.IgneousPotential] < 2 or
			not buff[EL.LavaSurge].up and buff[EL.Bloodlust].up
		)
	) then
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

	-- flame_shock,target_if=refreshable&active_enemies>1&buff.surge_of_power.up;
	if cooldown[EL.FlameShock].ready and targets > 1 and buff[EL.SurgeOfPowerAura].up then
		return EL.FlameShock;
	end

	-- lava_burst,if=talent.storm_elemental.enabled&cooldown_react&buff.surge_of_power.up&(expected_combat_length-time-cooldown.storm_elemental.remains-150*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%150)<30*(1+(azerite.echo_of_the_elementals.rank>=2))|(1.16*(expected_combat_length-time)-cooldown.storm_elemental.remains-150*floor((1.16*(expected_combat_length-time)-cooldown.storm_elemental.remains)%150))<(expected_combat_length-time-cooldown.storm_elemental.remains-150*floor((expected_combat_length-time-cooldown.storm_elemental.remains)%150)));
	-- lava_burst,if=!talent.storm_elemental.enabled&cooldown_react&buff.surge_of_power.up&(expected_combat_length-time-cooldown.fire_elemental.remains-150*floor((expected_combat_length-time-cooldown.fire_elemental.remains)%150)<30*(1+(azerite.echo_of_the_elementals.rank>=2))|(1.16*(expected_combat_length-time)-cooldown.fire_elemental.remains-150*floor((1.16*(expected_combat_length-time)-cooldown.fire_elemental.remains)%150))<(expected_combat_length-time-cooldown.fire_elemental.remains-150*floor((expected_combat_length-time-cooldown.fire_elemental.remains)%150)));
	if canLavaBurst and buff[EL.SurgeOfPowerAura].up then
		return EL.LavaBurst;
	end

	-- lightning_bolt,if=buff.surge_of_power.up;
	if currentSpell ~= EL.LightningBolt and buff[EL.SurgeOfPowerAura].up then
		return EL.LightningBolt;
	end

	-- lava_burst,if=cooldown_react&!talent.master_of_the_elements.enabled;
	if canLavaBurst and not talents[EL.MasterOfTheElements] then
		return EL.LavaBurst;
	end

	-- icefury,if=talent.icefury.enabled&!(maelstrom>75&cooldown.lava_burst.remains<=0)&(!talent.storm_elemental.enabled|cooldown.storm_elemental.remains<120);
	if talents[EL.Icefury] and cooldown[EL.Icefury].ready and currentSpell ~= EL.Icefury and (talents[EL.Icefury] and not (maelstrom > 75 and cooldown[EL.LavaBurst].remains <= 0) and (not talents[EL.StormElemental] or cooldown[EL.StormElemental].remains < 120)) then
		return EL.Icefury;
	end

	-- lava_burst,if=cooldown_react&charges>talent.echo_of_the_elements.enabled;
	if canLavaBurst and (
		cooldown[EL.LavaBurst].charges > (talents[EL.EchoOfTheElements] and 1 or 0)
	) then
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

	-- flame_shock,target_if=refreshable&!buff.surge_of_power.up;
	if cooldown[EL.FlameShock].ready and debuff[EL.FlameShock].refreshable and buff[EL.SurgeOfPowerAura].up then
		return EL.FlameShock;
	end

	-- totem_mastery,if=talent.totem_mastery.enabled&(buff.resonance_totem.remains<6|(buff.resonance_totem.remains<(buff.ascendance.duration+cooldown.ascendance.remains)&cooldown.ascendance.remains<15));
	if talents[EL.TotemMastery] and (
		tmRemains < 6 or
		not hasTotemMastery or
		(tmRemains < (buff[EL.Ascendance].duration + cooldown[EL.Ascendance].remains) and cooldown[EL.Ascendance].remains < 15)
	) then
		return EL.TotemMastery;
	end

	-- frost_shock,if=talent.icefury.enabled&buff.icefury.up&(buff.icefury.remains<gcd*4*buff.icefury.stack|buff.stormkeeper.up|!talent.master_of_the_elements.enabled);
	if talents[EL.Icefury] and buff[EL.Icefury].up and (
		buff[EL.Icefury].remains < gcd * 4 * buff[EL.Icefury].count or
			buff[EL.Stormkeeper].up or
			not talents[EL.MasterOfTheElements]
	) then
		return EL.FrostShock;
	end


	-- flame_shock,moving=1,if=movement.distance>6;
	if cooldown[EL.FlameShock].ready and moving then
		return EL.FlameShock;
	end

	-- frost_shock,moving=1;
	if moving then
		return EL.FrostShock;
	end

	-- lightning_bolt;
	return EL.LightningBolt;
end