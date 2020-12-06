if select(2, UnitClass("player")) ~= "WARLOCK" then return end

local _, MaxDps_WarlockTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Warlock = MaxDps_WarlockTable.Warlock;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local Necrolord = Enum.CovenantType.Necrolord;
local Venthyr = Enum.CovenantType.Venthyr;
local NightFae = Enum.CovenantType.NightFae;
local Kyrian = Enum.CovenantType.Kyrian;

local darkglareAsCooldown = true;

local AF = {
	GrimoireOfSacrifice  = 108503,
	SeedOfCorruption     = 27243,
	Haunt                = 48181,
	ShadowBolt           = 686,
	PhantomSingularity   = 205179,
	SummonDarkglare      = 205180,
	SoulRot              = 325640,
	Agony                = 980,
	ImpendingCatastrophe = 321792,
	SowTheSeeds          = 196226,
	SiphonLife           = 63106,
	Corruption           = 172,
	CorruptionAura       = 146739,
	VileTaint            = 278350,
	UnstableAffliction   = 316099,
	MaleficRapture       = 324536,
	ShadowEmbrace        = 32388,
	DarkSoulMisery       = 113860,
	DrainLife            = 234153,
	InevitableDemise     = 334319,
	DrainSoul            = 198590,
	DecimatingBolt       = 325289,
	ScouringTithe        = 312321,
	CorruptingLeer       = 339455
};
setmetatable(AF, Warlock.spellMeta);

function Warlock:Affliction()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local timeToDie = fd.timeToDie;
	local covenantId = fd.covenant.covenantId;
	local soulShards = UnitPower('player', Enum.PowerType.SoulShards);

	if currentSpell == AF.SeedOfCorruption or
		currentSpell == AF.MaleficRapture or
		currentSpell == AF.VileTaint
	then
		soulShards = soulShards - 1;
	end
	if soulShards < 0 then soulShards = 0; end

	fd.targets = targets;
	fd.soulShards = soulShards;

	MaxDps:GlowCooldown(
		AF.SummonDarkglare,
		cooldown[AF.SummonDarkglare].ready and
		debuff[AF.Agony].up and
		debuff[AF.CorruptionAura].up and
		debuff[AF.UnstableAffliction].up and
		(not talents[AF.PhantomSingularity] or cooldown[AF.PhantomSingularity].remains > 0)
	);

	if talents[AF.DarkSoulMisery] then
		MaxDps:GlowCooldown(AF.DarkSoulMisery, cooldown[AF.DarkSoulMisery].ready);
	end

	-- call_action_list,name=aoe,if=active_enemies>3;
	if targets > 3 then
		local result = Warlock:AfflictionAoe();
		if result then
			return result;
		end
	end

	-- phantom_singularity,if=time>30;
	if talents[AF.PhantomSingularity] and cooldown[AF.PhantomSingularity].ready then
		return AF.PhantomSingularity;
	end

	--- as cooldown
	if not darkglareAsCooldown then
		-- call_action_list,name=darkglare_prep,if=covenant.venthyr&dot.impending_catastrophe_dot.ticking&cooldown.summon_darkglare.remains<2&(dot.phantom_singularity.remains>2|!talent.phantom_singularity.enabled);
		if covenantId == Venthyr and
			debuff[AF.ImpendingCatastropheDot].up and
			cooldown[AF.SummonDarkglare].remains < 2 and
			(debuff[AF.PhantomSingularity].remains > 2 or not talents[AF.PhantomSingularity])
		then
			local result = Warlock:AfflictionDarkglarePrep();
			if result then
				return result;
			end
		end

		-- call_action_list,name=darkglare_prep,if=covenant.night_fae&dot.soul_rot.ticking&cooldown.summon_darkglare.remains<2&(dot.phantom_singularity.remains>2|!talent.phantom_singularity.enabled);
		if covenantId == NightFae and
			debuff[AF.SoulRot].up and
			cooldown[AF.SummonDarkglare].remains < 2 and
			(debuff[AF.PhantomSingularity].remains > 2 or not talents[AF.PhantomSingularity])
		then
			local result = Warlock:AfflictionDarkglarePrep();
			if result then
				return result;
			end
		end

		-- call_action_list,name=darkglare_prep,if=(covenant.necrolord|covenant.kyrian|covenant.none)&dot.phantom_singularity.ticking&dot.phantom_singularity.remains<2;
		if (covenantId == Necrolord or covenantId == Kyrian or covenantId == 0) and
			debuff[AF.PhantomSingularity].up and
			debuff[AF.PhantomSingularity].remains < 2
		then
			local result = Warlock:AfflictionDarkglarePrep();
			if result then
				return result;
			end
		end
	end

	-- agony,if=dot.agony.remains<4;
	if debuff[AF.Agony].remains < 4 then
		return AF.Agony;
	end

	--- multidot impossible
	-- agony,cycle_targets=1,if=active_enemies>1,target_if=dot.agony.remains<4;
	--if targets > 1 then
	--	return AF.Agony;
	--end

	-- haunt;
	if talents[AF.Haunt] and cooldown[AF.Haunt].ready and currentSpell ~= AF.Haunt then
		return AF.Haunt;
	end

	-- call_action_list,name=darkglare_prep,if=active_enemies>2&covenant.venthyr&(cooldown.impending_catastrophe.ready|dot.impending_catastrophe_dot.ticking)&(dot.phantom_singularity.ticking|!talent.phantom_singularity.enabled);
	if targets > 2 and
		covenantId == Venthyr and
		(cooldown[AF.ImpendingCatastrophe].ready or debuff[AF.ImpendingCatastropheDot].up) and
		(debuff[AF.PhantomSingularity].up or not talents[AF.PhantomSingularity])
	then
		local result = Warlock:AfflictionDarkglarePrep();
		if result then
			return result;
		end
	end

	-- call_action_list,name=darkglare_prep,if=active_enemies>2&(covenant.necrolord|covenant.kyrian|covenant.none)&(dot.phantom_singularity.ticking|!talent.phantom_singularity.enabled);
	if targets > 2 and
		(covenantId == Necrolord or covenantId == Kyrian or covenantId == 0) and
		(debuff[AF.PhantomSingularity].up or not talents[AF.PhantomSingularity])
	then
		local result = Warlock:AfflictionDarkglarePrep();
		if result then
			return result;
		end
	end

	-- call_action_list,name=darkglare_prep,if=active_enemies>2&covenant.night_fae&(cooldown.soul_rot.ready|dot.soul_rot.ticking)&(dot.phantom_singularity.ticking|!talent.phantom_singularity.enabled);
	if targets > 2 and
		covenantId == NightFae and
		(cooldown[AF.SoulRot].ready or debuff[AF.SoulRot].up) and
		(debuff[AF.PhantomSingularity].up or not talents[AF.PhantomSingularity])
	then
		local result = Warlock:AfflictionDarkglarePrep();
		if result then
			return result;
		end
	end

	-- seed_of_corruption,if=active_enemies>2&talent.sow_the_seeds.enabled&!dot.seed_of_corruption.ticking&!in_flight;
	if soulShards >= 1 and
		currentSpell ~= AF.SeedOfCorruption and
		targets > 2 and
		talents[AF.SowTheSeeds] and
		not debuff[AF.SeedOfCorruption].up
	then
		return AF.SeedOfCorruption;
	end

	-- seed_of_corruption,if=active_enemies>2&talent.siphon_life.enabled&!dot.seed_of_corruption.ticking&!in_flight&dot.corruption.remains<4;
	if soulShards >= 1 and
		currentSpell ~= AF.SeedOfCorruption and
		targets > 2 and
		talents[AF.SiphonLife] and
		not debuff[AF.SeedOfCorruption].up and
		not (debuff[AF.CorruptionAura].remains < 4)
	then
		return AF.SeedOfCorruption;
	end

	-- vile_taint,if=(soul_shard>1|active_enemies>2)&cooldown.summon_darkglare.remains>12;
	if talents[AF.VileTaint] and
		cooldown[AF.VileTaint].ready and
		soulShards >= 1 and
		currentSpell ~= AF.VileTaint and
		(soulShards > 1 or targets > 2) --and
		--cooldown[AF.SummonDarkglare].remains > 12 -- probably not
	then
		return AF.VileTaint;
	end

	-- unstable_affliction,if=dot.unstable_affliction.remains<4;
	if currentSpell ~= AF.UnstableAffliction and
		debuff[AF.UnstableAffliction].remains < 4
	then
		return AF.UnstableAffliction;
	end

	-- siphon_life,if=dot.siphon_life.remains<4;
	if talents[AF.SiphonLife] and debuff[AF.SiphonLife].remains < 4 then
		return AF.SiphonLife;
	end

	--- multidot not possible
	-- siphon_life,cycle_targets=1,if=active_enemies>1,target_if=dot.siphon_life.remains<4;
	--if talents[AF.SiphonLife] and targets > 1 then
	--	return AF.SiphonLife;
	--end

	-- call_action_list,name=covenant,if=!covenant.necrolord;
	if covenantId ~= Necrolord then
		local result = Warlock:AfflictionCovenant();
		if result then
			return result;
		end
	end

	-- corruption,if=active_enemies<4-(talent.sow_the_seeds.enabled|talent.siphon_life.enabled)&dot.corruption.remains<2;
	local talentCalc = (talents[AF.SowTheSeeds] or talents[AF.SiphonLife]) and 1 or 0;
	if targets < 4 - talentCalc and debuff[AF.CorruptionAura].remains < 2 then
		return AF.Corruption;
	end

	--- multidot not possible
	-- corruption,cycle_targets=1,if=active_enemies<4-(talent.sow_the_seeds.enabled|talent.siphon_life.enabled),target_if=dot.corruption.remains<2;
	--if targets < 4 - talentCalc then
	--	return AF.Corruption;
	--end

	-- phantom_singularity,if=covenant.necrolord|covenant.night_fae|covenant.kyrian|covenant.none;
	if talents[AF.PhantomSingularity] and cooldown[AF.PhantomSingularity].ready and (covenantId == Necrolord or covenantId == NightFae or covenantId == Kyrian or covenantId == 0) then
		return AF.PhantomSingularity;
	end

	-- malefic_rapture,if=soul_shard>4;
	if soulShards > 4 then -- TODO: currentSpell ~= AF.MaleficRapture and (
		return AF.MaleficRapture;
	end

	--- as cooldown
	if not darkglareAsCooldown then
		-- call_action_list,name=darkglare_prep,if=covenant.venthyr&(cooldown.impending_catastrophe.ready|dot.impending_catastrophe_dot.ticking)&cooldown.summon_darkglare.remains<2&(dot.phantom_singularity.remains>2|!talent.phantom_singularity.enabled);
		if covenantId == Venthyr and
			(cooldown[AF.ImpendingCatastrophe].ready or debuff[AF.ImpendingCatastropheDot].up) and
			cooldown[AF.SummonDarkglare].remains < 2 and
			(debuff[AF.PhantomSingularity].remains > 2 or not talents[AF.PhantomSingularity])
		then
			local result = Warlock:AfflictionDarkglarePrep();
			if result then
				return result;
			end
		end

		-- call_action_list,name=darkglare_prep,if=(covenant.necrolord|covenant.kyrian|covenant.none)&cooldown.summon_darkglare.remains<2&(dot.phantom_singularity.remains>2|!talent.phantom_singularity.enabled);
		if (covenantId == Necrolord or covenantId == Kyrian or covenantId == 0) and
			cooldown[AF.SummonDarkglare].remains < 2 and
			(debuff[AF.PhantomSingularity].remains > 2 or not talents[AF.PhantomSingularity])
		then
			local result = Warlock:AfflictionDarkglarePrep();
			if result then
				return result;
			end
		end

		-- call_action_list,name=darkglare_prep,if=covenant.night_fae&(cooldown.soul_rot.ready|dot.soul_rot.ticking)&cooldown.summon_darkglare.remains<2&(dot.phantom_singularity.remains>2|!talent.phantom_singularity.enabled);
		if covenantId == NightFae and
			(cooldown[AF.SoulRot].ready or debuff[AF.SoulRot].up) and
			cooldown[AF.SummonDarkglare].remains < 2 and
			(debuff[AF.PhantomSingularity].remains > 2 or not talents[AF.PhantomSingularity])
		then
			local result = Warlock:AfflictionDarkglarePrep();
			if result then
				return result;
			end
		end

		-- dark_soul,if=cooldown.summon_darkglare.remains>time_to_die;
		--if cooldown[AF.SummonDarkglare].remains > timeToDie then
		--	return AF.DarkSoulMisery;
		--end
	end

	-- call_action_list,name=se,if=debuff.shadow_embrace.stack<(2-action.shadow_bolt.in_flight)|debuff.shadow_embrace.remains<3;
	if debuff[AF.ShadowEmbrace].count < 2 or debuff[AF.ShadowEmbrace].remains < 3 then
		local result = Warlock:AfflictionSe();
		if result then
			return result;
		end
	end

	-- malefic_rapture,if=dot.vile_taint.ticking;
	if soulShards >= 1 and currentSpell ~= AF.MaleficRapture and debuff[AF.VileTaint].up then
		return AF.MaleficRapture;
	end

	-- malefic_rapture,if=dot.impending_catastrophe_dot.ticking;
	if soulShards >= 1 and currentSpell ~= AF.MaleficRapture and debuff[AF.ImpendingCatastropheDot].up then
		return AF.MaleficRapture;
	end

	-- malefic_rapture,if=dot.soul_rot.ticking;
	if soulShards >= 1 and currentSpell ~= AF.MaleficRapture and debuff[AF.SoulRot].up then
		return AF.MaleficRapture;
	end

	-- malefic_rapture,if=talent.phantom_singularity.enabled&(dot.phantom_singularity.ticking|soul_shard>3|time_to_die<cooldown.phantom_singularity.remains);
	if soulShards >= 1 and currentSpell ~= AF.MaleficRapture and
		talents[AF.PhantomSingularity] and
		(debuff[AF.PhantomSingularity].up or soulShards > 3 or timeToDie < cooldown[AF.PhantomSingularity].remains)
	then
		return AF.MaleficRapture;
	end

	-- malefic_rapture,if=talent.sow_the_seeds.enabled;
	if soulShards >= 1 and currentSpell ~= AF.MaleficRapture and talents[AF.SowTheSeeds] then
		return AF.MaleficRapture;
	end

	-- drain_life,if=buff.inevitable_demise.stack>40|buff.inevitable_demise.up&time_to_die<4;
	if buff[AF.InevitableDemise].count > 40 or buff[AF.InevitableDemise].up and timeToDie < 4 then
		return AF.DrainLife;
	end

	-- call_action_list,name=covenant;
	local result = Warlock:AfflictionCovenant();
	if result then
		return result;
	end

	-- agony,if=refreshable;
	if debuff[AF.Agony].refreshable then
		return AF.Agony;
	end

	--- multidot not possible
	-- agony,cycle_targets=1,if=active_enemies>1,target_if=refreshable;
	--if mana >= 1000 and (targets > 1) then
	--	return AF.Agony;
	--end

	-- corruption,if=refreshable&active_enemies<4-(talent.sow_the_seeds.enabled|talent.siphon_life.enabled);
	if debuff[AF.CorruptionAura].refreshable and targets < 4 - talentCalc then
		return AF.Corruption;
	end

	-- unstable_affliction,if=refreshable;
	if currentSpell ~= AF.UnstableAffliction and debuff[AF.UnstableAffliction].refreshable then
		return AF.UnstableAffliction;
	end

	-- siphon_life,if=refreshable;
	if talents[AF.SiphonLife] and debuff[AF.SiphonLife].refreshable then
		return AF.SiphonLife;
	end

	--- multidot not possible
	-- siphon_life,cycle_targets=1,if=active_enemies>1,target_if=refreshable;
	--if talents[AF.SiphonLife] and (targets > 1) then
	--	return AF.SiphonLife;
	--end

	--- multidot not possible
	-- corruption,cycle_targets=1,if=active_enemies<4-(talent.sow_the_seeds.enabled|talent.siphon_life.enabled),target_if=refreshable;
	--if targets < 4 - talentCalc then
	--	return AF.Corruption;
	--end

	-- drain_soul,interrupt=1;
	if talents[AF.DrainSoul] then
		return AF.DrainSoul;
	end

	-- shadow_bolt;
	return AF.ShadowBolt;
end

function Warlock:AfflictionAoe()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeToDie = fd.timeToDie;
	local soulShards = fd.soulShards;
	local covenantId = fd.covenant.covenantId;

	-- phantom_singularity;
	if talents[AF.PhantomSingularity] and cooldown[AF.PhantomSingularity].ready then
		return AF.PhantomSingularity;
	end

	-- haunt;
	if talents[AF.Haunt] and cooldown[AF.Haunt].ready and currentSpell ~= AF.Haunt then
		return AF.Haunt;
	end

	--- as cooldown
	if not darkglareAsCooldown then
		-- call_action_list,name=darkglare_prep,if=covenant.venthyr&dot.impending_catastrophe_dot.ticking&cooldown.summon_darkglare.remains<2&(dot.phantom_singularity.remains>2|!talent.phantom_singularity.enabled);
		if covenantId == Venthyr and
			debuff[AF.ImpendingCatastropheDot].up and
			cooldown[AF.SummonDarkglare].remains < 2 and
			(debuff[AF.PhantomSingularity].remains > 2 or not talents[AF.PhantomSingularity])
		then
			local result = Warlock:AfflictionDarkglarePrep();
			if result then
				return result;
			end
		end

		-- call_action_list,name=darkglare_prep,if=covenant.night_fae&dot.soul_rot.ticking&cooldown.summon_darkglare.remains<2&(dot.phantom_singularity.remains>2|!talent.phantom_singularity.enabled);
		if covenantId == NightFae and
			debuff[AF.SoulRot].up and
			cooldown[AF.SummonDarkglare].remains < 2 and
			(debuff[AF.PhantomSingularity].remains > 2 or not talents[AF.PhantomSingularity])
		then
			local result = Warlock:AfflictionDarkglarePrep();
			if result then
				return result;
			end
		end

		-- call_action_list,name=darkglare_prep,if=(covenant.necrolord|covenant.kyrian|covenant.none)&dot.phantom_singularity.ticking&dot.phantom_singularity.remains<2;
		if (covenantId == Necrolord or covenantId == Kyrian or covenantId == 0) and
			debuff[AF.PhantomSingularity].up and
			debuff[AF.PhantomSingularity].remains < 2
		then
			local result = Warlock:AfflictionDarkglarePrep();
			if result then
				return result;
			end
		end
	end

	-- seed_of_corruption,if=talent.sow_the_seeds.enabled&can_seed;
	local canSeed = true;
	if soulShards >= 1 and currentSpell ~= AF.SeedOfCorruption and talents[AF.SowTheSeeds] and canSeed then
		return AF.SeedOfCorruption;
	end

	-- seed_of_corruption,if=!talent.sow_the_seeds.enabled&!dot.seed_of_corruption.ticking&!in_flight&dot.corruption.refreshable;
	if soulShards >= 1 and
		currentSpell ~= AF.SeedOfCorruption and
		not talents[AF.SowTheSeeds] and
		not debuff[AF.SeedOfCorruption].up and
		debuff[AF.CorruptionAura].refreshable
	then
		return AF.SeedOfCorruption;
	end

	-- fix for non cycling rotation
	if debuff[AF.Agony].refreshable then
		return AF.Agony;
	end

	--- multidot not possible
	-- agony,cycle_targets=1,if=active_dot.agony<4,target_if=!dot.agony.ticking;
	--if activeDot[AF.Agony] < 4 then
	--	return AF.Agony;
	--end

	--- multidot not possible
	-- agony,cycle_targets=1,if=active_dot.agony>=4,target_if=refreshable&dot.agony.ticking;
	--if activeDot[AF.Agony] >= 4 then
	--	return AF.Agony;
	--end

	-- unstable_affliction,if=dot.unstable_affliction.refreshable;
	if currentSpell ~= AF.UnstableAffliction and debuff[AF.UnstableAffliction].refreshable then
		return AF.UnstableAffliction;
	end

	-- vile_taint,if=soul_shard>1;
	if talents[AF.VileTaint] and cooldown[AF.VileTaint].ready and currentSpell ~= AF.VileTaint and soulShards > 1 then
		return AF.VileTaint;
	end

	-- call_action_list,name=covenant,if=!covenant.necrolord;
	if not covenantId == Necrolord then
		local result = Warlock:AfflictionCovenant();
		if result then
			return result;
		end
	end

	--- as cooldown
	if not darkglareAsCooldown then
		-- call_action_list,name=darkglare_prep,if=covenant.venthyr&(cooldown.impending_catastrophe.ready|dot.impending_catastrophe_dot.ticking)&cooldown.summon_darkglare.remains<2&(dot.phantom_singularity.remains>2|!talent.phantom_singularity.enabled);
		if covenantId == Venthyr and
			(cooldown[AF.ImpendingCatastrophe].ready or debuff[AF.ImpendingCatastropheDot].up) and
			cooldown[AF.SummonDarkglare].remains < 2 and
			(debuff[AF.PhantomSingularity].remains > 2 or not talents[AF.PhantomSingularity])
		then
			local result = Warlock:AfflictionDarkglarePrep();
			if result then
				return result;
			end
		end

		-- call_action_list,name=darkglare_prep,if=(covenant.necrolord|covenant.kyrian|covenant.none)&cooldown.summon_darkglare.remains<2&(dot.phantom_singularity.remains>2|!talent.phantom_singularity.enabled);
		if (covenantId == Necrolord or covenantId == Kyrian or covenantId == 0) and
			cooldown[AF.SummonDarkglare].remains < 2 and
			(debuff[AF.PhantomSingularity].remains > 2 or not talents[AF.PhantomSingularity])
		then
			local result = Warlock:AfflictionDarkglarePrep();
			if result then
				return result;
			end
		end

		-- call_action_list,name=darkglare_prep,if=covenant.night_fae&(cooldown.soul_rot.ready|dot.soul_rot.ticking)&cooldown.summon_darkglare.remains<2&(dot.phantom_singularity.remains>2|!talent.phantom_singularity.enabled);
		if covenantId == NightFae and
			(cooldown[AF.SoulRot].ready or debuff[AF.SoulRot].up) and
			cooldown[AF.SummonDarkglare].remains < 2 and
			(debuff[AF.PhantomSingularity].remains > 2 or not talents[AF.PhantomSingularity])
		then
			local result = Warlock:AfflictionDarkglarePrep();
			if result then
				return result;
			end
		end

		-- dark_soul,if=cooldown.summon_darkglare.remains>time_to_die;
		--if cooldown[AF.SummonDarkglare].remains > timeToDie then
		--	return AF.DarkSoulMisery;
		--end
	end

	-- malefic_rapture,if=dot.vile_taint.ticking;
	if soulShards >= 1 and currentSpell ~= AF.MaleficRapture and debuff[AF.VileTaint].up then
		return AF.MaleficRapture;
	end

	-- malefic_rapture,if=dot.soul_rot.ticking&!talent.sow_the_seeds.enabled;
	if soulShards >= 1 and currentSpell ~= AF.MaleficRapture and debuff[AF.SoulRot].up and not talents[AF.SowTheSeeds] then
		return AF.MaleficRapture;
	end

	-- malefic_rapture,if=!talent.vile_taint.enabled;
	if soulShards >= 1 and currentSpell ~= AF.MaleficRapture and not talents[AF.VileTaint] then
		return AF.MaleficRapture;
	end

	-- malefic_rapture,if=soul_shard>4;
	if currentSpell ~= AF.MaleficRapture and soulShards > 4 then
		return AF.MaleficRapture;
	end

	--- multidot not possible
	-- siphon_life,cycle_targets=1,if=active_dot.siphon_life<=3,target_if=!dot.siphon_life.ticking;
	--if talents[AF.SiphonLife] and (activeDot[AF.SiphonLife] <= 3) then
	--	return AF.SiphonLife;
	--end

	-- call_action_list,name=covenant;
	local result = Warlock:AfflictionCovenant();
	if result then
		return result;
	end

	-- drain_life,if=buff.inevitable_demise.stack>=50|buff.inevitable_demise.up&time_to_die<5|buff.inevitable_demise.stack>=35&dot.soul_rot.ticking;
	if buff[AF.InevitableDemise].count >= 50 or
		buff[AF.InevitableDemise].up and timeToDie < 5 or
		buff[AF.InevitableDemise].count >= 35 and debuff[AF.SoulRot].up
	then
		return AF.DrainLife;
	end

	-- drain_soul,interrupt=1;
	if talents[AF.DrainSoul] then
		return AF.DrainSoul;
	end

	-- shadow_bolt;
	return AF.ShadowBolt;
end

function Warlock:AfflictionCovenant()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local covenantId = fd.covenant.covenantId;

	-- impending_catastrophe,if=cooldown.summon_darkglare.remains<10|cooldown.summon_darkglare.remains>50;
	if covenantId == Venthyr and
		cooldown[AF.ImpendingCatastrophe].ready and
		currentSpell ~= AF.ImpendingCatastrophe --and
		--(cooldown[AF.SummonDarkglare].remains < 10 or cooldown[AF.SummonDarkglare].remains > 50)
	then
		return AF.ImpendingCatastrophe;
	end

	-- decimating_bolt,if=cooldown.summon_darkglare.remains>5&(debuff.haunt.remains>4|!talent.haunt.enabled);
	if covenantId == Necrolord and
		cooldown[AF.DecimatingBolt].ready and
		currentSpell ~= AF.DecimatingBolt and
		--cooldown[AF.SummonDarkglare].remains > 5 and
		(debuff[AF.Haunt].remains > 4 or not talents[AF.Haunt])
	then
		return AF.DecimatingBolt;
	end

	-- soul_rot,if=cooldown.summon_darkglare.remains<5|cooldown.summon_darkglare.remains>50|cooldown.summon_darkglare.remains>25&conduit.corrupting_leer.enabled;
	if covenantId == NightFae and
		cooldown[AF.SoulRot].ready and
		currentSpell ~= AF.SoulRot --and
		--(
		--	cooldown[AF.SummonDarkglare].remains < 5 or
		--	cooldown[AF.SummonDarkglare].remains > 50 --or
		--	--cooldown[AF.SummonDarkglare].remains > 25 and conduit[AF.CorruptingLeer] TODO
		--)
	then
		return AF.SoulRot;
	end

	-- scouring_tithe;
	if covenantId == Kyrian and
		cooldown[AF.ScouringTithe].ready and
		currentSpell ~= AF.ScouringTithe
	then
		return AF.ScouringTithe;
	end
end

function Warlock:AfflictionDarkglarePrep()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local soulShards = fd.soulShards;
	local covenantId = fd.covenant.covenantId;

	-- vile_taint,if=cooldown.summon_darkglare.remains<2;
	if talents[AF.VileTaint] and
		cooldown[AF.VileTaint].ready and 
		soulShards >= 1 and 
		currentSpell ~= AF.VileTaint and
		cooldown[AF.SummonDarkglare].remains < 2
	then
		return AF.VileTaint;
	end

	-- dark_soul;
	--if talents[AF.DarkSoulMisery] and cooldown[AF.DarkSoulMisery].ready then
	--	return AF.DarkSoulMisery;
	--end

	-- call_action_list,name=covenant,if=!covenant.necrolord&cooldown.summon_darkglare.remains<2;
	if covenantId ~= Necrolord and cooldown[AF.SummonDarkglare].remains < 2 then
		local result = Warlock:AfflictionCovenant();
		if result then
			return result;
		end
	end

	-- summon_darkglare;
	if cooldown[AF.SummonDarkglare].ready then
		return AF.SummonDarkglare;
	end
end

function Warlock:AfflictionSe()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;

	-- haunt;
	if talents[AF.Haunt] and cooldown[AF.Haunt].ready and currentSpell ~= AF.Haunt then
		return AF.Haunt;
	end

	-- drain_soul,interrupt_global=1,interrupt_if=debuff.shadow_embrace.stack>=3;
	if talents[AF.DrainSoul] then
		return AF.DrainSoul;
	end

	-- shadow_bolt;
	return AF.ShadowBolt;
end