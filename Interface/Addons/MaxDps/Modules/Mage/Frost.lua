if select(2, UnitClass("player")) ~= "MAGE" then return end

local _, MaxDps_MageTable = ...;
local Mage = MaxDps_MageTable.Mage;
local MaxDps = MaxDps;
local UnitExists = UnitExists;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local GetTime = GetTime;
local GetSpellCooldown = GetSpellCooldown;

local Necrolord = Enum.CovenantType.Necrolord;
local Venthyr = Enum.CovenantType.Venthyr;
local NightFae = Enum.CovenantType.NightFae;
local Kyrian = Enum.CovenantType.Kyrian;

local FT = {
	ArcaneIntellect            = 1459,
	SummonWaterElemental       = 31687,
	Frostbolt                  = 116,
	Counterspell               = 2139,
	FrozenOrb                  = 84714,
	Blizzard                   = 190356,
	Flurry                     = 44614,
	WintersChill               = 228358,
	Ebonbolt                   = 257537,
	BrainFreeze                = 190446,
	FingersOfFrost             = 44544,
	IceNova                    = 157997,
	CometStorm                 = 153595,
	IceLance                   = 30455,
	RadiantSpark               = 307443,
	MirrorsOfTorment           = 314793,
	ShiftingPower              = 314791,
	FireBlast                  = 108853,
	BuffDisciplinaryCommand    = 327371, -- wtf?
	ArcaneExplosion            = 1449,
	SplittingIce               = 56377,
	Deathborne                 = 324220,
	RuneOfPower                = 116011,
	RuneOfPowerAura            = 116014,
	IcyVeins                   = 12472,
	TimeWarp                   = 80353,
	IceFloes                   = 108839,
	GlacialSpike               = 199786,
	Icicles                    = 205473,
	FreezingRain               = 270233,
	RayOfFrost                 = 205021,
	Frozen                     = 205708, -- is this chilled?

	-- Leggo buffs
	FreezingWinds              = 327478, -- from logs
	ExpandedPotential          = 327495, -- from wowhead
	DisciplinaryCommand        = 327371,

	-- Leggo bonus Ids
	GlacialFragmentsBonusId    = 6830,
	FreezingWindsBonusId       = 6829,
	DisciplinaryCommandBonusId = 6832,

	-- conduits
	IreOfTheAscended           = 40 -- is it working?
};

setmetatable(FT, Mage.spellMeta);

Mage.lastFrozenOrb = 0;
function Mage:UNIT_SPELLCAST_SUCCEEDED(event, unitID, spell, spellId)
	if unitID == 'player' and spellId == FT.FrozenOrb then
		Mage.lastFrozenOrb = GetTime();
	end
end

function Mage:FrozenOrbRemains()
	local remains = 16 - (GetTime() - Mage.lastFrozenOrb);

	if remains < 0 then
		return 0;
	else
		return remains;
	end
end

function Mage:Frost()
	local fd = MaxDps.FrameData;
	local targets = MaxDps:SmartAoe();
	local mana = UnitPower('player', Enum.PowerType.Mana);
	local manaMax = UnitPowerMax('player', Enum.PowerType.Mana);
	local manaPct = 100 * (mana / manaMax);

	fd.targets = targets;
	fd.manaPct = manaPct;

	-- call_action_list,name=cds;
	Mage:FrostCds();

	if targets >= 3 then
		-- call_action_list,name=aoe,if=active_enemies>=3;
		return Mage:FrostAoe();
	else
		-- call_action_list,name=st,if=active_enemies<3;
		return Mage:FrostSt();
	end

	-- call_action_list,name=movement;
	return Mage:FrostMovement();
end

function Mage:FrostCds()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local spellHistory = fd.spellHistory;
	local talents = fd.talents;
	local targets = fd.targets;
	local covenantId = fd.covenant.covenantId;

	MaxDps:GlowCooldown(FT.IcyVeins, cooldown[FT.IcyVeins].ready);

	-- deathborne;
	if covenantId == Necrolord then
		MaxDps:GlowCooldown(FT.Deathborne, cooldown[FT.Deathborne].ready);
	end

	if covenantId == NightFae then
		MaxDps:GlowCooldown(FT.ShiftingPower, cooldown[FT.ShiftingPower].ready);
	end

	-- mirrors_of_torment,if=active_enemies<3&(conduit.siphoned_malice|soulbind.wasteland_propriety);
	if covenantId == Venthyr then
		MaxDps:GlowCooldown(FT.MirrorsOfTorment, cooldown[FT.MirrorsOfTorment].ready);
	end

	-- rune_of_power,if=cooldown.icy_veins.remains>12&buff.rune_of_power.down;
	if talents[FT.RuneOfPower] then
		MaxDps:GlowCooldown(
			FT.RuneOfPower,
			cooldown[FT.RuneOfPower].ready and
			currentSpell ~= FT.RuneOfPower and
			--cooldown[FT.IcyVeins].remains > 12 and
			not buff[FT.RuneOfPowerAura].up
		);
	end
	--if talents[FT.RuneOfPower] and
	--	cooldown[FT.RuneOfPower].ready and
	--	currentSpell ~= FT.RuneOfPower and
	--	(cooldown[FT.IcyVeins].remains > 12 and not buff[FT.RuneOfPower].up)
	--then
	--	return FT.RuneOfPower;
	--end

	-- icy_veins,if=buff.rune_of_power.down&(buff.slick_ice.down|active_enemies>=2);
	--if cooldown[FT.IcyVeins].ready and (not buff[FT.RuneOfPower].up and (not buff[FT.SlickIce].up or targets >= 2)) then
	--	return FT.IcyVeins;
	--end

	-- time_warp,if=runeforge.temporal_warp&buff.exhaustion.up&(prev_off_gcd.icy_veins|fight_remains<30);
	--if cooldown[FT.TimeWarp].ready and (runeforge[FT.TemporalWarp] and buff[FT.Exhaustion].up and (spellHistory[1] == FT.IcyVeins or fightRemains < 30)) then
	--	return FT.TimeWarp;
	--end
end

function Mage:FrostSt()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local spellHistory = fd.spellHistory;
	local talents = fd.talents;
	local covenantId = fd.covenant.covenantId;
	local targets = fd.targets;
	local runeforge = fd.runeforge;
	local conduit = fd.covenant.soulbindConduits;

	local remainingWintersChill = debuff[FT.WintersChill].count;

	-- flurry,if=(remaining_winters_chill=0|debuff.winters_chill.down)&(prev_gcd.1.ebonbolt|buff.brain_freeze.react&(prev_gcd.1.glacial_spike|prev_gcd.1.frostbolt&(!conduit.ire_of_the_ascended|cooldown.radiant_spark.remains|runeforge.freezing_winds)|prev_gcd.1.radiant_spark|buff.fingers_of_frost.react=0&(debuff.mirrors_of_torment.up|buff.freezing_winds.up|buff.expanded_potential.react)));
	if currentSpell ~= FT.Flurry and (
		(remainingWintersChill == 0 or not debuff[FT.WintersChill].up) and
		(
			currentSpell == FT.Ebonbolt or
			buff[FT.BrainFreeze].up and (
				currentSpell == FT.GlacialSpike or
				currentSpell == FT.Frostbolt and (
					not conduit[FT.IreOfTheAscended] or
					not cooldown[FT.RadiantSpark].ready or
					runeforge[FT.FreezingWindsBonusId]
				) or
				currentSpell == FT.RadiantSpark or
				buff[FT.FingersOfFrost].count == 0 and (
					debuff[FT.MirrorsOfTorment].up or
					buff[FT.FreezingWinds].up or
					buff[FT.ExpandedPotential].up
				)
			)
		)
	) then
		return FT.Flurry;
	end

	-- frozen_orb;
	if cooldown[FT.FrozenOrb].ready then
		return FT.FrozenOrb;
	end

	-- blizzard,if=buff.freezing_rain.up|active_enemies>=2|runeforge.glacial_fragments&remaining_winters_chill=2;
	if cooldown[FT.Blizzard].ready and
		currentSpell ~= FT.Blizzard and
		(
			buff[FT.FreezingRain].up or
			targets >= 2 or
			runeforge[FT.GlacialFragmentsBonusId] and remainingWintersChill == 2
		)
	then
		return FT.Blizzard;
	end

	-- ray_of_frost,if=remaining_winters_chill=1&debuff.winters_chill.remains;
	if talents[FT.RayOfFrost] and
		cooldown[FT.RayOfFrost].ready and
		remainingWintersChill == 1 and
		not debuff[FT.WintersChill].up
	then
		return FT.RayOfFrost;
	end

	-- glacial_spike,if=remaining_winters_chill&debuff.winters_chill.remains>cast_time+travel_time;
	if talents[FT.GlacialSpike] and
		buff[FT.Icicles].count >= 5 and
		currentSpell ~= FT.GlacialSpike and
		remainingWintersChill > 0 and
		debuff[FT.WintersChill].remains > 4
	then
		return FT.GlacialSpike;
	end

	-- ice_lance,if=remaining_winters_chill&remaining_winters_chill>buff.fingers_of_frost.react&debuff.winters_chill.remains>travel_time;
	if remainingWintersChill > 0 --and
		--remainingWintersChill > buff[FT.FingersOfFrost].count and
		--not debuff[FT.WintersChill].up TODO: probably not needed?
	then
		return FT.IceLance;
	end

	-- comet_storm;
	if talents[FT.CometStorm] and cooldown[FT.CometStorm].ready then
		return FT.CometStorm;
	end

	-- ice_nova;
	if talents[FT.IceNova] and cooldown[FT.IceNova].ready then
		return FT.IceNova;
	end

	-- radiant_spark,if=buff.freezing_winds.up&active_enemies=1;
	if covenantId == Kyrian and
		cooldown[FT.RadiantSpark].ready and
		currentSpell ~= FT.RadiantSpark and
		buff[FT.FreezingWinds].up and
		targets <= 1
	then
		return FT.RadiantSpark;
	end

	-- ice_lance,if=buff.fingers_of_frost.react|debuff.frozen.remains>travel_time;
	if buff[FT.FingersOfFrost].up
		--or debuff[FT.Frozen].remains > 1.5 -- TODO: WTF?
	then
		return FT.IceLance;
	end

	-- ebonbolt;
	if talents[FT.Ebonbolt] and
		cooldown[FT.Ebonbolt].ready and
		currentSpell ~= FT.Ebonbolt
	then
		return FT.Ebonbolt;
	end

	-- radiant_spark,if=(!runeforge.freezing_winds|active_enemies>=2)&buff.brain_freeze.react;
	if covenantId == Kyrian and
		cooldown[FT.RadiantSpark].ready and
		currentSpell ~= FT.RadiantSpark and
		(not runeforge[FT.FreezingWindsBonusId] or targets >= 2) and
		buff[FT.BrainFreeze].up
	then
		return FT.RadiantSpark;
	end

	---- mirrors_of_torment;
	--if cooldown[FT.MirrorsOfTorment].ready and currentSpell ~= FT.MirrorsOfTorment then
	--	return FT.MirrorsOfTorment;
	--end
	--
	---- shifting_power,if=buff.rune_of_power.down&(soulbind.grove_invigoration|soulbind.field_of_blossoms|active_enemies>=2);
	--if cooldown[FT.ShiftingPower].ready and currentSpell ~= FT.ShiftingPower and (not buff[FT.RuneOfPower].up and (covenant.soulbindAbilities[FT.GroveInvigoration] or covenant.soulbindAbilities[FT.FieldOfBlossoms] or targets >= 2)) then
	--	return FT.ShiftingPower;
	--end

	-- TODO: this doesn't seem possible?
	-- arcane_explosion,if=runeforge.disciplinary_command&cooldown.buff_disciplinary_command.ready&buff.disciplinary_command_arcane.down;
	--if runeforge[FT.DisciplinaryCommandBonusId] and
	--	cooldown[FT.BuffDisciplinaryCommand].ready and
	--	not buff[FT.DisciplinaryCommandArcane].up
	--then
	--	return FT.ArcaneExplosion;
	--end

	-- fire_blast,if=runeforge.disciplinary_command&cooldown.buff_disciplinary_command.ready&buff.disciplinary_command_fire.down;
	--if cooldown[FT.FireBlast].ready and
	--	runeforge[FT.DisciplinaryCommandBonusId] and
	--	cooldown[FT.BuffDisciplinaryCommand].ready and
	--	not buff[FT.DisciplinaryCommandFire].up
	--then
	--	return FT.FireBlast;
	--end

	-- glacial_spike,if=buff.brain_freeze.react;
	if talents[FT.GlacialSpike] and
		buff[FT.Icicles].count >= 5 and
		currentSpell ~= FT.GlacialSpike and
		buff[FT.BrainFreeze].up
	then
		return FT.GlacialSpike;
	end

	-- frostbolt;
	return FT.Frostbolt;
end

function Mage:FrostAoe()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local spellHistory = fd.spellHistory;
	local talents = fd.talents;
	local targets = fd.targets;
	local runeforge = fd.runeforge;
	local manaPct = fd.manaPct;
	local covenantId = fd.covenant.covenantId;

	local remainingWintersChill = debuff[FT.WintersChill].count;

	-- frozen_orb;
	if cooldown[FT.FrozenOrb].ready then
		return FT.FrozenOrb;
	end

	-- blizzard;
	if cooldown[FT.Blizzard].ready and currentSpell ~= FT.Blizzard then
		return FT.Blizzard;
	end

	-- flurry,if=(remaining_winters_chill=0|debuff.winters_chill.down)&(prev_gcd.1.ebonbolt|buff.brain_freeze.react&buff.fingers_of_frost.react=0);
	if currentSpell ~= FT.Flurry and
		(remainingWintersChill == 0 or not debuff[FT.WintersChill].up) and
		(currentSpell == FT.Ebonbolt or buff[FT.BrainFreeze].up and buff[FT.FingersOfFrost].count <= 0)
	then
		return FT.Flurry;
	end

	-- ice_nova;
	if talents[FT.IceNova] and cooldown[FT.IceNova].ready then
		return FT.IceNova;
	end

	-- comet_storm;
	if talents[FT.CometStorm] and cooldown[FT.CometStorm].ready then
		return FT.CometStorm;
	end

	-- ice_lance,if=buff.fingers_of_frost.react|debuff.frozen.remains>travel_time|remaining_winters_chill&debuff.winters_chill.remains>travel_time;
	if buff[FT.FingersOfFrost].up or
		--debuff[FT.Frozen].remains > 2 or -- TODO: WTF?
		remainingWintersChill > 0 and debuff[FT.WintersChill].remains > 2
	then
		return FT.IceLance;
	end

	-- radiant_spark;
	if covenantId == Kyrian and cooldown[FT.RadiantSpark].ready and currentSpell ~= FT.RadiantSpark then
		return FT.RadiantSpark;
	end

	-- TODO: this doesn't seem possible?
	-- fire_blast,if=runeforge.disciplinary_command&cooldown.buff_disciplinary_command.ready&buff.disciplinary_command_fire.down;
	--if cooldown[FT.FireBlast].ready and
	--	runeforge[FT.DisciplinaryCommandBonusId] and
	--	cooldown[FT.BuffDisciplinaryCommand].ready and
	--	not buff[FT.DisciplinaryCommandFire].up
	--then
	--	return FT.FireBlast;
	--end

	-- arcane_explosion,if=mana.pct>30&active_enemies>=6&!runeforge.glacial_fragments;
	if manaPct > 30 and targets >= 6 and not runeforge[FT.GlacialFragmentsBonusId] then
		return FT.ArcaneExplosion;
	end

	-- ebonbolt;
	if talents[FT.Ebonbolt] and cooldown[FT.Ebonbolt].ready and currentSpell ~= FT.Ebonbolt then
		return FT.Ebonbolt;
	end

	-- ice_lance,if=runeforge.glacial_fragments&talent.splitting_ice&travel_time<ground_aoe.blizzard.remains;
	if runeforge[FT.GlacialFragmentsBonusId] and
		talents[FT.SplittingIce] and
		not cooldown[FT.Blizzard].ready
	then
		return FT.IceLance;
	end

	-- frostbolt;
	return FT.Frostbolt;
end

function Mage:FrostMovement()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local targets = fd.targets;
	local manaPct = fd.manaPct;

	-- ice_floes,if=buff.ice_floes.down;
	if talents[FT.IceFloes] and (not buff[FT.IceFloes].up) then
		return FT.IceFloes;
	end

	-- arcane_explosion,if=mana.pct>30&active_enemies>=2;
	if manaPct > 30 and targets >= 2 then
		return FT.ArcaneExplosion;
	end

	-- fire_blast;
	if cooldown[FT.FireBlast].ready then
		return FT.FireBlast;
	end

	-- ice_lance;
	return FT.IceLance;
end