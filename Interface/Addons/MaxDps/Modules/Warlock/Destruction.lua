if select(2, UnitClass("player")) ~= "WARLOCK" then return end

local _, MaxDps_WarlockTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Warlock = MaxDps_WarlockTable.Warlock;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local EnumPowerType = Enum.PowerType;
local GetTotemInfo = GetTotemInfo;
local GetTime = GetTime;
local Necrolord = Enum.CovenantType.Necrolord;
local Venthyr = Enum.CovenantType.Venthyr;
local NightFae = Enum.CovenantType.NightFae;
local Kyrian = Enum.CovenantType.Kyrian;


local DS = {
	GrimoireOfSacrifice  = 108503,
	SoulFire             = 6353,
	Incinerate           = 29722,
	Inferno              = 270545,
	InternalCombustion   = 266134,
	Conflagrate          = 17962,
	RoaringBlaze         = 205184,
	Cataclysm            = 152108,
	Immolate             = 348,
	ImmolateAura         = 157736,
	ChannelDemonfire     = 196447,
	ScouringTithe        = 312321,
	DecimatingBolt       = 325289,
	Havoc                = 80240,
	ImpendingCatastrophe = 321792,
	SoulRot              = 325640,
	SummonInfernal       = 1122,
	DarkSoulInstability  = 113858,
	Backdraft            = 117828,
	Flashover            = 267115,
	ChaosBolt            = 116858,
	Eradication          = 196412,
	EradicationAura      = 196414,
	Shadowburn           = 17877,
	RainOfFire           = 5740,
	FireAndBrimstone     = 196408,
	LeadByExample        = 342156
};

function Warlock:Destruction()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local timeToDie = fd.timeToDie;
	local covenantId = fd.covenant.covenantId;
	local soulShards = UnitPower('player', Enum.PowerType.SoulShards, true) / 10;

	local havocRemains = 10 + (cooldown[DS.Havoc].remains - 30);
	local havocActive = cooldown[DS.Havoc].remains > 20;
	local petInfernal, _, petInfernalStart, petInfernalDuration = GetTotemInfo(1);
	local petInfernalRemains = petInfernal and (petInfernalDuration - (GetTime() - petInfernalStart)) or 0;

	if petInfernalRemains < 0 then petInfernalRemains = 0; end
	if havocRemains < 0 then havocRemains = 0; end

	local targetHp = MaxDps:TargetPercentHealth();

	if currentSpell == DS.ChaosBolt then
		soulShards = soulShards - 2;
	elseif currentSpell == DS.Incinerate then
		soulShards = soulShards + 0.2;
	end

	local canChaosBolt = (soulShards >= 2 and currentSpell ~= DS.ChaosBolt) or soulShards >= 4;

	fd.soulShards = soulShards;
	fd.havocRemains = havocRemains;
	fd.petInfernal = petInfernal;
	fd.targetHp = targetHp;
	fd.canChaosBolt = canChaosBolt;
	fd.targets = targets;

	-- summon_infernal;
	MaxDps:GlowCooldown(DS.SummonInfernal, cooldown[DS.SummonInfernal].ready);
	MaxDps:GlowCooldown(DS.Havoc, cooldown[DS.Havoc].ready);

	-- dark_soul_instability;
	if talents[DS.DarkSoulInstability] then
		MaxDps:GlowCooldown(DS.DarkSoulInstability, cooldown[DS.DarkSoulInstability].ready);
	end

	local result;
	-- call_action_list,name=havoc,if=havoc_active&active_enemies>1&active_enemies<5-talent.inferno.enabled+(talent.inferno.enabled&talent.internal_combustion.enabled);
	local infernoCalc = (talents[DS.Inferno] and talents[DS.InternalCombustion]) and 1 or 0;
	if havocActive and
		targets > 1 and
		targets < 5 - (talents[DS.Inferno] and 1 or 0) + infernoCalc
	then
		result = Warlock:DestructionHavoc();
		if result then
			return result;
		end
	end

	-- conflagrate,if=talent.roaring_blaze.enabled&debuff.roaring_blaze.remains<1.5;
	if cooldown[DS.Conflagrate].ready and talents[DS.RoaringBlaze] and debuff[DS.RoaringBlaze].remains < 1.5 then
		return DS.Conflagrate;
	end

	-- cataclysm,if=!(pet.infernal.active&dot.immolate.remains+1>pet.infernal.remains)|spell_targets.cataclysm>1;
	if talents[DS.Cataclysm] and cooldown[DS.Cataclysm].ready and currentSpell ~= DS.Cataclysm and
		(not (petInfernal and debuff[DS.ImmolateAura].remains + 1 > petInfernalRemains) or targets > 1)
	then
		return DS.Cataclysm;
	end

	-- call_action_list,name=aoe,if=active_enemies>2;
	if targets > 2 then
		result = Warlock:DestructionAoe();
		if result then
			return result;
		end
	end

	-- soul_fire,cycle_targets=1,if=refreshable&soul_shard<=4&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>remains);
	if talents[DS.SoulFire] and
		cooldown[DS.SoulFire].ready and
		currentSpell ~= DS.SoulFire and
		debuff[DS.SoulFire].refreshable and
		soulShards <= 4 and
		(not talents[DS.Cataclysm] or cooldown[DS.Cataclysm].remains > debuff[DS.SoulFire].remains)
	then
		return DS.SoulFire;
	end

	-- immolate,cycle_targets=1,if=refreshable&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>remains);
	if currentSpell ~= DS.Immolate and
		debuff[DS.ImmolateAura].refreshable and
		(not talents[DS.Cataclysm] or cooldown[DS.Cataclysm].remains > debuff[DS.ImmolateAura].remains)
	then
		return DS.Immolate;
	end

	-- immolate,if=talent.internal_combustion.enabled&action.chaos_bolt.in_flight&remains<duration*0.5;
	--if currentSpell ~= DS.Immolate and
	--	talents[DS.InternalCombustion] and
	--	--inFlight and
	--	debuff[DS.ImmolateAura].remains < cooldown[DS.Immolate].duration * 0.5
	--then
	--	return DS.Immolate;
	--end

	-- channel_demonfire;
	if talents[DS.ChannelDemonfire] and cooldown[DS.ChannelDemonfire].ready and currentSpell ~= DS.ChannelDemonfire then
		return DS.ChannelDemonfire;
	end

	-- scouring_tithe;
	if covenantId == Kyrian and cooldown[DS.ScouringTithe].ready and currentSpell ~= DS.ScouringTithe then
		return DS.ScouringTithe;
	end

	-- decimating_bolt;
	if covenantId == Necrolord and cooldown[DS.DecimatingBolt].ready and currentSpell ~= DS.DecimatingBolt then
		return DS.DecimatingBolt;
	end

	-- havoc,cycle_targets=1,if=!(target=self.target)&(dot.immolate.remains>dot.immolate.duration*0.5|!talent.internal_combustion.enabled);
	--if cooldown[DS.Havoc].ready and (not ( target == ) and ( debuff[DS.ImmolateAura].remains > debuff[DS.ImmolateAura].duration * 0.5 or not talents[DS.InternalCombustion] )) then
	--return DS.Havoc;
	--end

	-- impending_catastrophe;
	if covenantId == Venthyr and
		cooldown[DS.ImpendingCatastrophe].ready and
		currentSpell ~= DS.ImpendingCatastrophe
	then
		return DS.ImpendingCatastrophe;
	end

	-- soul_rot;
	if covenantId == NightFae and cooldown[DS.SoulRot].ready and currentSpell ~= DS.SoulRot then
		return DS.SoulRot;
	end

	-- TODO: leggo support
	-- havoc,if=runeforge.odr_shawl_of_the_ymirjar.equipped;
	--if cooldown[DS.Havoc].ready and (runeforge[DS.OdrShawlOfTheYmirjar]) then
	--	return DS.Havoc;
	--end

	-- variable,name=pool_soul_shards,value=active_enemies>1&cooldown.havoc.remains<=10|cooldown.summon_infernal.remains<=15&talent.dark_soul_instability.enabled&cooldown.dark_soul_instability.remains<=15|talent.dark_soul_instability.enabled&cooldown.dark_soul_instability.remains<=15&(cooldown.summon_infernal.remains>target.time_to_die|cooldown.summon_infernal.remains+cooldown.summon_infernal.duration>target.time_to_die);
	local poolSoulShards = targets > 1 and cooldown[DS.Havoc].remains <= 10 or
		cooldown[DS.SummonInfernal].remains <= 15 and talents[DS.DarkSoulInstability] and cooldown[DS.DarkSoulInstability].remains <= 15 or
		talents[DS.DarkSoulInstability] and cooldown[DS.DarkSoulInstability].remains <= 15 and
			(cooldown[DS.SummonInfernal].remains > timeToDie or cooldown[DS.SummonInfernal].remains + cooldown[DS.SummonInfernal].duration > timeToDie);

	-- conflagrate,if=buff.backdraft.down&soul_shard>=1.5-0.3*talent.flashover.enabled&!variable.pool_soul_shards;
	if cooldown[DS.Conflagrate].ready and
		not buff[DS.Backdraft].up and soulShards >= 1.5 - 0.3 * (talents[DS.Flashover] and 1 or 0) and
		not poolSoulShards
	then
		return DS.Conflagrate;
	end

	-- chaos_bolt,if=buff.dark_soul_instability.up;
	if canChaosBolt and buff[DS.DarkSoulInstability].up then
		return DS.ChaosBolt;
	end

	-- chaos_bolt,if=buff.backdraft.up&!variable.pool_soul_shards&!talent.eradication.enabled;
	if canChaosBolt and
		buff[DS.Backdraft].up and
		not poolSoulShards and
		not talents[DS.Eradication]
	then
		return DS.ChaosBolt;
	end

	-- chaos_bolt,if=!variable.pool_soul_shards&talent.eradication.enabled&(debuff.eradication.remains<cast_time|buff.backdraft.up);
	if canChaosBolt and
		not poolSoulShards and
		talents[DS.Eradication] and
		(debuff[DS.EradicationAura].remains < 3 or buff[DS.Backdraft].up)
	then
		return DS.ChaosBolt;
	end

	-- shadowburn,if=!variable.pool_soul_shards|soul_shard>=4.5;
	if talents[DS.Shadowburn] and cooldown[DS.Shadowburn].ready and soulShards >= 1 and
		(not poolSoulShards or soulShards >= 4.5)
	then
		return DS.Shadowburn;
	end

	-- chaos_bolt,if=(soul_shard>=4.5-0.2*active_enemies);
	if canChaosBolt and (soulShards >= 4.5 - 0.2 * targets) then
		return DS.ChaosBolt;
	end

	-- conflagrate,if=charges>1;
	if cooldown[DS.Conflagrate].ready and cooldown[DS.Conflagrate].charges > 1 then
		return DS.Conflagrate;
	end

	-- incinerate;
	return DS.Incinerate;
end

function Warlock:DestructionAoe()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local targetHp = fd.targetHp;
	local targets = fd.targets;
	local covenant = fd.covenant;
	local covenantId = fd.covenant.covenantId;
	local soulShards = fd.soulShards;
	local petInfernal = fd.petInfernal;

	-- rain_of_fire,if=pet.infernal.active&(!cooldown.havoc.ready|active_enemies>3);
	if soulShards >= 3 and petInfernal and (not cooldown[DS.Havoc].ready or targets > 3) then
		return DS.RainOfFire;
	end

	-- soul_rot;
	if covenantId == NightFae and cooldown[DS.SoulRot].ready and currentSpell ~= DS.SoulRot then
		return DS.SoulRot;
	end

	-- channel_demonfire,if=dot.immolate.remains>cast_time;
	if talents[DS.ChannelDemonfire] and
		cooldown[DS.ChannelDemonfire].ready and
		currentSpell ~= DS.ChannelDemonfire and
		debuff[DS.ImmolateAura].remains > 2.5
	then
		return DS.ChannelDemonfire;
	end

	-- immolate,cycle_targets=1,if=remains<5&(!talent.cataclysm.enabled|cooldown.cataclysm.remains>remains);
	if currentSpell ~= DS.Immolate and
		debuff[DS.ImmolateAura].remains < 5 and
		(not talents[DS.Cataclysm] or cooldown[DS.Cataclysm].remains > debuff[DS.ImmolateAura].remains)
	then
		return DS.Immolate;
	end

	-- havoc,cycle_targets=1,if=!(target=self.target)&active_enemies<4;
	--if cooldown[DS.Havoc].ready and (not ( target == ) and targets < 4) then
	--	return DS.Havoc;
	--end

	-- rain_of_fire;
	if soulShards >= 3 then
		return DS.RainOfFire;
	end

	-- havoc,cycle_targets=1,if=!(self.target=target);
	--if cooldown[DS.Havoc].ready and (not ( == target )) then
	--return DS.Havoc;
	--end

	-- decimating_bolt,if=(soulbind.lead_by_example.enabled|!talent.fire_and_brimstone.enabled);
	if covenantId == Necrolord and
		cooldown[DS.DecimatingBolt].ready and
		currentSpell ~= DS.DecimatingBolt and
		((covenant.soulbindAbilities[DS.LeadByExample] or not talents[DS.FireAndBrimstone]))
	then
		return DS.DecimatingBolt;
	end

	-- incinerate,if=talent.fire_and_brimstone.enabled&buff.backdraft.up&soul_shard<5-0.2*active_enemies;
	if --currentSpell ~= DS.Incinerate and
		talents[DS.FireAndBrimstone] and
		buff[DS.Backdraft].up and
		soulShards < 5 - 0.2 * targets
	then
		return DS.Incinerate;
	end

	-- soul_fire;
	if talents[DS.SoulFire] and cooldown[DS.SoulFire].ready and currentSpell ~= DS.SoulFire then
		return DS.SoulFire;
	end

	-- conflagrate,if=buff.backdraft.down;
	if cooldown[DS.Conflagrate].ready and not buff[DS.Backdraft].up then
		return DS.Conflagrate;
	end

	-- shadowburn,if=target.health.pct<20;
	if talents[DS.Shadowburn] and
		cooldown[DS.Shadowburn].ready and
		soulShards >= 1 and
		targetHp < 0.2
	then
		return DS.Shadowburn;
	end

	-- scouring_tithe,if=!(talent.fire_and_brimstone.enabled|talent.inferno.enabled);
	if covenantId == Kyrian and
		cooldown[DS.ScouringTithe].ready and
		currentSpell ~= DS.ScouringTithe and
		(not (talents[DS.FireAndBrimstone] or talents[DS.Inferno]))
	then
		return DS.ScouringTithe;
	end

	-- impending_catastrophe,if=!(talent.fire_and_brimstone.enabled|talent.inferno.enabled);
	if covenantId == Venthyr and
		cooldown[DS.ImpendingCatastrophe].ready and
		currentSpell ~= DS.ImpendingCatastrophe and
		(not (talents[DS.FireAndBrimstone] or talents[DS.Inferno]))
	then
		return DS.ImpendingCatastrophe;
	end

	-- incinerate;
	return DS.Incinerate;
end

function Warlock:DestructionHavoc()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local covenantId = fd.covenant.covenantId;
	local soulShards = fd.soulShards;
	local havocRemains = fd.havocRemains;
	local covenant = fd.covenant;
	local canChaosBolt = fd.canChaosBolt;

	-- conflagrate,if=buff.backdraft.down&soul_shard>=1&soul_shard<=4;
	if cooldown[DS.Conflagrate].ready and
		not buff[DS.Backdraft].up and
		soulShards >= 1 and
		soulShards <= 4
	then
		return DS.Conflagrate;
	end

	-- soul_fire,if=cast_time<havoc_remains;
	if talents[DS.SoulFire] and
		cooldown[DS.SoulFire].ready and
		currentSpell ~= DS.SoulFire and
		4 < havocRemains
	then
		return DS.SoulFire;
	end

	-- decimating_bolt,if=cast_time<havoc_remains&soulbind.lead_by_example.enabled;
	if covenantId == Necrolord and
		cooldown[DS.DecimatingBolt].ready and
		currentSpell ~= DS.DecimatingBolt and
		(2.5 < havocRemains and covenant.soulbindAbilities[DS.LeadByExample])
	then
		return DS.DecimatingBolt;
	end

	-- scouring_tithe,if=cast_time<havoc_remains;
	if covenantId == Kyrian and
		cooldown[DS.ScouringTithe].ready and
		currentSpell ~= DS.ScouringTithe and
		(2 < havocRemains) then
		return DS.ScouringTithe;
	end

	-- immolate,if=talent.internal_combustion.enabled&remains<duration*0.5|!talent.internal_combustion.enabled&refreshable;
	if currentSpell ~= DS.Immolate and
		(
			talents[DS.InternalCombustion] and debuff[DS.ImmolateAura].remains < cooldown[DS.Immolate].duration * 0.5 or
			not talents[DS.InternalCombustion] and debuff[DS.ImmolateAura].refreshable
		)
	then
		return DS.Immolate;
	end

	-- chaos_bolt,if=cast_time<havoc_remains;
	if canChaosBolt and 2 < havocRemains then
		return DS.ChaosBolt;
	end

	-- shadowburn;
	if talents[DS.Shadowburn] and cooldown[DS.Shadowburn].ready and soulShards >= 1 then
		return DS.Shadowburn;
	end

	-- incinerate,if=cast_time<havoc_remains;
	if (2 < havocRemains) then -- currentSpell ~= DS.Incinerate and
		return DS.Incinerate;
	end
end