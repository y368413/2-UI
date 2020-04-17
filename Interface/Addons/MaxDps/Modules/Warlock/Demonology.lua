if select(2, UnitClass("player")) ~= "WARLOCK" then return end

local _, MaxDps_WarlockTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Warlock = MaxDps_WarlockTable.Warlock;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local GetTime = GetTime;
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo;
local UnitGUID = UnitGUID;
local strsplit = strsplit;

local DE = {
	InnerDemons         = 267216,
	Demonbolt           = 264178,
	Doom                = 265412,
	DemonicStrength     = 267171,
	NetherPortal        = 267217,
	GrimoireFelguard    = 111898,
	SummonDemonicTyrant = 265187,
	SummonVilefiend     = 264119,
	CallDreadstalkers   = 104316,
	DemonicCalling      = 205145,
	DemonicConsumption  = 267215,
	DemonicPower        = 265273,
	HandOfGuldan        = 105174,
	PowerSiphon         = 264130,
	DemonicCore         = 267102,
	DemonicCoreAura     = 264173,
	SoulStrike          = 264057,
	BilescourgeBombers  = 267211,
	ShadowBolt          = 686,
	Implosion           = 196277,
	SummonFelguard      = 30146,
	SummonWrathguard    = 112870,
	ExplosivePotential  = 275398
};

local A = {
	BalefulInvocation  = 287059,
	ExplosivePotential = 275395
};

setmetatable(DE, Warlock.spellMeta);
setmetatable(A, Warlock.spellMeta);

function Warlock:Demonology()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local azerite = fd.azerite;
	local timeShift = fd.timeShift;
	local targets = MaxDps:SmartAoe();
	local spellHistory = fd.spellHistory;
	local gcd = fd.gcd;
	local timeToDie = fd.timeToDie;
	local wildImps = Warlock:ImpsCount();
	local soulShards = UnitPower('player', Enum.PowerType.SoulShards);

	if currentSpell == DE.CallDreadstalkers then
		soulShards = soulShards - 2;
	elseif currentSpell == DE.HandOfGuldan then
		soulShards = soulShards - 3;
	elseif currentSpell == DE.SummonVilefiend then
		soulShards = soulShards - 1;
	elseif currentSpell == DE.ShadowBolt then
		soulShards = soulShards + 1;
	elseif currentSpell == DE.Demonbolt then
		soulShards = soulShards + 2;
	elseif currentSpell == DE.SummonDemonicTyrant then
		if azerite[A.BalefulInvocation] > 0 then
			soulShards = 5;
		end
		if talents[DE.DemonicConsumption] then
			wildImps = 0;
		end
	end

	if soulShards < 0 then
		soulShards = 0;
	end

	fd.wildImps = wildImps;
	fd.soulShards = soulShards;
	fd.targets = targets;

	-- grimoire_felguard,if=cooldown.summon_demonic_tyrant.remains<13;
	--if cooldown[DE.GrimoireFelguard].ready and soulShards >= 1 and (cooldown[DE.SummonDemonicTyrant].remains < 13) then
	--	return DE.GrimoireFelguard;
	--end

	-- summon_demonic_tyrant,if=soul_shard<3&(!talent.demonic_consumption.enabled|buff.wild_imps.stack>0);
	--if cooldown[DE.SummonDemonicTyrant].ready and currentSpell ~= DE.SummonDemonicTyrant and (soulShards < 3 and ( not talents[DE.DemonicConsumption] or wildImps > 0 )) then
	--	return DE.SummonDemonicTyrant;
	--end

	MaxDps:GlowEssences();

	--Cooldowns
	if talents[DE.DemonicConsumption] then
		local hogCount = 0;
		for i = 1, 5 do
			if spellHistory[i] == DE.HandOfGuldan then
				hogCount = hogCount + 1;
			end
		end
		MaxDps:GlowCooldown(
			DE.SummonDemonicTyrant,
			cooldown[DE.SummonDemonicTyrant].ready and currentSpell ~= DE.SummonDemonicTyrant and (
				wildImps >= 6 and currentSpell == DE.HandOfGuldan
			)
		);
	else
		MaxDps:GlowCooldown(
			DE.SummonDemonicTyrant,
			cooldown[DE.SummonDemonicTyrant].ready and currentSpell ~= DE.SummonDemonicTyrant and (
				soulShards < 3 and (not talents[DE.DemonicConsumption] or wildImps > 0) and
					cooldown[DE.CallDreadstalkers].remains > 10
			)
		);
	end


	if talents[DE.GrimoireFelguard] then
		MaxDps:GlowCooldown(DE.GrimoireFelguard,
			soulShards >= 1 and cooldown[DE.GrimoireFelguard].ready and cooldown[DE.SummonDemonicTyrant].remains < 13
		);
	end

	if azerite[A.ExplosivePotential] > 0 then
		MaxDps:GlowCooldown(DE.Implosion, wildImps > 2 and buff[DE.ExplosivePotential].remains < 1.4);
	end

	-- nether_portal,if=soul_shard>=5&(!talent.power_siphon.enabled|buff.demonic_core.up);
	--if talents[DE.NetherPortal] and cooldown[DE.NetherPortal].ready and soulShards >= 1 and currentSpell ~= DE.NetherPortal and (soulShards >= 5 and ( not talents[DE.PowerSiphon] or buff[DE.DemonicCoreAura].up )) then
	--	return DE.NetherPortal;
	--end

	if talents[DE.NetherPortal] then
		-- nether_portal,if=soul_shard>=5&(!talent.power_siphon.enabled|buff.demonic_core.up);
		MaxDps:GlowCooldown(DE.NetherPortal, cooldown[DE.NetherPortal].ready and currentSpell ~= DE.NetherPortal and
			soulShards >= 5 and (not talents[DE.PowerSiphon] or buff[DE.DemonicCoreAura].up)
		);
	end

	if not UnitExists('pet') then
		return MaxDps:FindSpell(DE.SummonWrathguard) and DE.SummonWrathguard or DE.SummonFelguard;
	end

	-- call_action_list,name=dcon_ep_opener,if=azerite.explosive_potential.rank&talent.demonic_consumption.enabled&time<30&!cooldown.summon_demonic_tyrant.remains;
	-- can't really implement opener
	--if azerite[A.ExplosivePotential] and talents[DE.DemonicConsumption] and 30 and not cooldown[DE.SummonDemonicTyrant].ready then
	--	local result = Warlock:DemonologyDconEpOpener();
	--	if result then
	--		return result;
	--	end
	--end

	-- hand_of_guldan,if=azerite.explosive_potential.rank&time<5&soul_shard>2&buff.explosive_potential.down&buff.wild_imps.stack<3&!prev_gcd.1.hand_of_guldan&&!prev_gcd.2.hand_of_guldan;
	if currentSpell ~= DE.HandOfGuldan and azerite[A.ExplosivePotential] > 0 and
		soulShards > 2 and
		not buff[DE.ExplosivePotential].up and
		wildImps < 3 and
		spellHistory[1] ~= DE.HandOfGuldan and
		spellHistory[2] ~= DE.HandOfGuldan
	then
		return DE.HandOfGuldan;
	end

	-- demonbolt,if=soul_shard<=3&buff.demonic_core.up&buff.demonic_core.stack=4;
	if currentSpell ~= DE.Demonbolt and soulShards <= 3 and buff[DE.DemonicCoreAura].count == 4 then
		return DE.Demonbolt;
	end

	-- implosion,if=azerite.explosive_potential.rank&buff.wild_imps.stack>2&buff.explosive_potential.remains<action.shadow_bolt.execute_time&(!talent.demonic_consumption.enabled|cooldown.summon_demonic_tyrant.remains>12);
	if azerite[A.ExplosivePotential] > 0 and wildImps > 2 and buff[DE.ExplosivePotential].remains < 1.4 and (
		not talents[DE.DemonicConsumption] or cooldown[DE.SummonDemonicTyrant].remains > 12
	) then
		return DE.Implosion;
	end

	-- doom,if=!ticking&time_to_die>30&spell_targets.implosion<2;
	if talents[DE.Doom] and not debuff[DE.Doom].up and timeToDie > 30 and targets < 2 then
		return DE.Doom;
	end

	-- bilescourge_bombers,if=azerite.explosive_potential.rank>0&time<10&spell_targets.implosion<2&buff.dreadstalkers.remains&talent.nether_portal.enabled;
	--if cooldown[DE.BilescourgeBombers].ready and soulShards >= 2 and (
	--	azerite[DE.ExplosivePotential] > 0 and time < 10 and
	--		targets < 2 and not buff[DE.Dreadstalkers].ready and
	--		talents[DE.NetherPortal]
	--) then
	--	return DE.BilescourgeBombers;
	--end

	-- demonic_strength,if=(buff.wild_imps.stack<6|buff.demonic_power.up)|spell_targets.implosion<2;
	if talents[DE.DemonicStrength] and cooldown[DE.DemonicStrength].ready and (
		(wildImps < 6 or buff[DE.DemonicPower].up) or targets < 2
	) then
		return DE.DemonicStrength;
	end

	-- call_action_list,name=nether_portal,if=talent.nether_portal.enabled&spell_targets.implosion<=2;
	if talents[DE.NetherPortal] and targets <= 2 then
		local result = Warlock:DemonologyNetherPortal();
		if result then
			return result;
		end
	end

	-- call_action_list,name=implosion,if=spell_targets.implosion>1;
	if targets > 1 then
		local result = Warlock:DemonologyImplosion();
		if result then
			return result;
		end
	end

	-- summon_vilefiend,if=cooldown.summon_demonic_tyrant.remains>40|cooldown.summon_demonic_tyrant.remains<12;
	if talents[DE.SummonVilefiend] and cooldown[DE.SummonVilefiend].ready and soulShards >= 1 and
		currentSpell ~= DE.SummonVilefiend and (
		cooldown[DE.SummonDemonicTyrant].remains > 40 or cooldown[DE.SummonDemonicTyrant].remains < 12
	) then
		return DE.SummonVilefiend;
	end

	-- call_dreadstalkers,if=(cooldown.summon_demonic_tyrant.remains<9&buff.demonic_calling.remains)|(cooldown.summon_demonic_tyrant.remains<11&!buff.demonic_calling.remains)|cooldown.summon_demonic_tyrant.remains>14;
	if cooldown[DE.CallDreadstalkers].ready and (soulShards >= 2 or soulShards >= 1 and buff[DE.DemonicCalling].up) and
		currentSpell ~= DE.CallDreadstalkers and (
		(cooldown[DE.SummonDemonicTyrant].remains < 9 and buff[DE.DemonicCalling].up) or
			(cooldown[DE.SummonDemonicTyrant].remains < 11 and not buff[DE.DemonicCalling].up) or
			cooldown[DE.SummonDemonicTyrant].remains > 14
	) then
		return DE.CallDreadstalkers;
	end

	-- bilescourge_bombers;
	if talents[DE.BilescourgeBombers] and cooldown[DE.BilescourgeBombers].ready and soulShards >= 2 then
		return DE.BilescourgeBombers;
	end

	-- power_siphon,if=buff.wild_imps.stack>=2&buff.demonic_core.stack<=2&buff.demonic_power.down&spell_targets.implosion<2;
	if talents[DE.PowerSiphon] and cooldown[DE.PowerSiphon].ready and
		wildImps >= 2 and buff[DE.DemonicCoreAura].count <= 2 and not buff[DE.DemonicPower].up and targets < 2
	then
		return DE.PowerSiphon;
	end

	-- doom,if=talent.doom.enabled&refreshable&time_to_die>(dot.doom.remains+30);
	if talents[DE.Doom] and debuff[DE.Doom].refreshable and timeToDie > (debuff[DE.Doom].remains + 30) then
		return DE.Doom;
	end

	-- hand_of_guldan,if=soul_shard>=5|(soul_shard>=3&cooldown.call_dreadstalkers.remains>4&(cooldown.summon_demonic_tyrant.remains>20|(cooldown.summon_demonic_tyrant.remains<gcd*2&talent.demonic_consumption.enabled|cooldown.summon_demonic_tyrant.remains<gcd*4&!talent.demonic_consumption.enabled))&(!talent.summon_vilefiend.enabled|cooldown.summon_vilefiend.remains>3));
	if soulShards >= 1 and currentSpell ~= DE.HandOfGuldan and (
		soulShards >= 5 or (
			soulShards >= 3 and cooldown[DE.CallDreadstalkers].remains > 4 and (
				cooldown[DE.SummonDemonicTyrant].remains > 20 or (
					cooldown[DE.SummonDemonicTyrant].remains < gcd * 2 and talents[DE.DemonicConsumption] or
					cooldown[DE.SummonDemonicTyrant].remains < gcd * 4 and not talents[DE.DemonicConsumption]
				)
			) and (not talents[DE.SummonVilefiend] or cooldown[DE.SummonVilefiend].remains > 3)
		)
	) then
		return DE.HandOfGuldan;
	end

	-- soul_strike,if=soul_shard<5&buff.demonic_core.stack<=2;
	if talents[DE.SoulStrike] and cooldown[DE.SoulStrike].ready and
		soulShards < 5 and buff[DE.DemonicCoreAura].count <= 2
	then
		return DE.SoulStrike;
	end

	-- demonbolt,if=soul_shard<=3&buff.demonic_core.up&((cooldown.summon_demonic_tyrant.remains<6|cooldown.summon_demonic_tyrant.remains>22)|buff.demonic_core.stack>=3|buff.demonic_core.remains<5|time_to_die<25);
	if currentSpell ~= DE.Demonbolt and (
		soulShards <= 3 and buff[DE.DemonicCoreAura].up and (
			cooldown[DE.SummonDemonicTyrant].remains < 6 or
				cooldown[DE.SummonDemonicTyrant].remains > 22 and buff[DE.DemonicCoreAura].count > 2 or
				buff[DE.DemonicCoreAura].count >= 3 or
				buff[DE.DemonicCoreAura].remains < buff[DE.DemonicCoreAura].count * 4
		)
	) then
		return DE.Demonbolt;
	end

	-- call_action_list,name=build_a_shard;
	return Warlock:DemonologyBuildAShard();
end

function Warlock:DemonologyBuildAShard()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local talents = fd.talents;

	-- soul_strike;
	if talents[DE.SoulStrike] and cooldown[DE.SoulStrike].ready then
		return DE.SoulStrike;
	end

	-- shadow_bolt;
	return DE.ShadowBolt;
end

function Warlock:DemonologyDconEpOpener()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local soulShards = fd.soulShards;
	local wildImps = fd.wildImps;

	-- hand_of_guldan,line_cd=30;
	if soulShards >= 1 and currentSpell ~= DE.HandOfGuldan then
		return DE.HandOfGuldan;
	end

	-- implosion,if=buff.wild_imps.stack>2&buff.explosive_potential.down;
	if wildImps > 2 and not buff[DE.ExplosivePotential].up then
		return DE.Implosion;
	end

	-- doom,line_cd=30;
	if talents[DE.Doom] then
		return DE.Doom;
	end

	-- demonic_strength;
	if talents[DE.DemonicStrength] and cooldown[DE.DemonicStrength].ready then
		return DE.DemonicStrength;
	end

	-- bilescourge_bombers;
	if cooldown[DE.BilescourgeBombers].ready and soulShards >= 2 then
		return DE.BilescourgeBombers;
	end

	-- summon_vilefiend;
	if talents[DE.SummonVilefiend] and cooldown[DE.SummonVilefiend].ready and soulShards >= 1 and currentSpell ~= DE.SummonVilefiend then
		return DE.SummonVilefiend;
	end

	-- grimoire_felguard;
	if cooldown[DE.GrimoireFelguard].ready and soulShards >= 1 then
		return DE.GrimoireFelguard;
	end

	-- hand_of_guldan,if=soul_shard=5|soul_shard=4&buff.demonic_calling.remains;
	if soulShards >= 1 and currentSpell ~= DE.HandOfGuldan and (soulShards == 5 or soulShards == 4 and buff[DE.DemonicCalling].remains) then
		return DE.HandOfGuldan;
	end

	-- call_dreadstalkers,if=prev_gcd.1.hand_of_guldan;
	if cooldown[DE.CallDreadstalkers].ready and soulShards >= 2 and currentSpell ~= DE.CallDreadstalkers and (spellHistory[1] == DE.HandOfGuldan) then
		return DE.CallDreadstalkers;
	end

	-- summon_demonic_tyrant,if=prev_gcd.1.call_dreadstalkers;
	if cooldown[DE.SummonDemonicTyrant].ready and currentSpell ~= DE.SummonDemonicTyrant and (spellHistory[1] == DE.CallDreadstalkers) then
		return DE.SummonDemonicTyrant;
	end

	-- soul_strike,if=(soul_shard<3|soul_shard=4&buff.demonic_core.stack<=3)|buff.demonic_core.down&soul_shard<5;
	if talents[DE.SoulStrike] and cooldown[DE.SoulStrike].ready and (( soulShards < 3 or soulShards == 4 and buff[DE.DemonicCoreAura].count <= 3 ) or not buff[DE.DemonicCoreAura].up and soulShards < 5) then
		return DE.SoulStrike;
	end

	-- demonbolt,if=soul_shard<=3&buff.demonic_core.remains;
	if currentSpell ~= DE.Demonbolt and (soulShards <= 3 and buff[DE.DemonicCoreAura].remains > 0) then
		return DE.Demonbolt;
	end

	-- call_action_list,name=build_a_shard;
	local result = Warlock:DemonologyBuildAShard();
	if result then
		return result;
	end
end

function Warlock:DemonologyImplosion()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local targets = fd.targets;
	local gcd = fd.gcd;
	local timeToDie = fd.timeToDie;
	local soulShards = fd.soulShards;
	local wildImps = fd.wildImps;
	local spellHistory = fd.spellHistory;

	-- implosion,if=(buff.wild_imps.stack>=6&(soul_shard<3|prev_gcd.1.call_dreadstalkers|buff.wild_imps.stack>=9|prev_gcd.1.bilescourge_bombers|(!prev_gcd.1.hand_of_guldan&!prev_gcd.2.hand_of_guldan))&!prev_gcd.1.hand_of_guldan&!prev_gcd.2.hand_of_guldan&buff.demonic_power.down)|(time_to_die<3&buff.wild_imps.stack>0)|(prev_gcd.2.call_dreadstalkers&buff.wild_imps.stack>2&!talent.demonic_calling.enabled);
	if (wildImps >= 6 and (
			soulShards < 3 or spellHistory[1] == DE.CallDreadstalkers or wildImps >= 9 or spellHistory[1] == DE.BilescourgeBombers or (
			not spellHistory[1] == DE.HandOfGuldan and not spellHistory[2] == DE.HandOfGuldan
		)
	) and not spellHistory[1] == DE.HandOfGuldan and not spellHistory[2] == DE.HandOfGuldan and not buff[DE.DemonicPower].up
	) or (timeToDie < 3 and wildImps > 0) or
		(spellHistory[2] == DE.CallDreadstalkers and wildImps > 2 and not talents[DE.DemonicCalling])
	then
		return DE.Implosion;
	end

	-- call_dreadstalkers,if=(cooldown.summon_demonic_tyrant.remains<9&buff.demonic_calling.remains)|(cooldown.summon_demonic_tyrant.remains<11&!buff.demonic_calling.remains)|cooldown.summon_demonic_tyrant.remains>14;
	if cooldown[DE.CallDreadstalkers].ready and soulShards >= 2 and currentSpell ~= DE.CallDreadstalkers and (
		(cooldown[DE.SummonDemonicTyrant].remains < 9 and buff[DE.DemonicCalling].remains) or
		(cooldown[DE.SummonDemonicTyrant].remains < 11 and not buff[DE.DemonicCalling].remains) or
		cooldown[DE.SummonDemonicTyrant].remains > 14
	) then
		return DE.CallDreadstalkers;
	end

	-- hand_of_guldan,if=soul_shard>=5;
	if currentSpell ~= DE.HandOfGuldan and soulShards >= 5 then
		return DE.HandOfGuldan;
	end

	-- hand_of_guldan,if=soul_shard>=3&(((prev_gcd.2.hand_of_guldan|buff.wild_imps.stack>=3)&buff.wild_imps.stack<9)|cooldown.summon_demonic_tyrant.remains<=gcd*2|buff.demonic_power.remains>gcd*2);
	if currentSpell ~= DE.HandOfGuldan and (
		soulShards >= 3 and (
			(
				(spellHistory[2] == DE.HandOfGuldan or wildImps >= 3) and wildImps < 9
			) or
				cooldown[DE.SummonDemonicTyrant].remains <= gcd * 2 or
				buff[DE.DemonicPower].remains > gcd * 2
		)
	) then
		return DE.HandOfGuldan;
	end

	-- demonbolt,if=prev_gcd.1.hand_of_guldan&soul_shard>=1&(buff.wild_imps.stack<=3|prev_gcd.3.hand_of_guldan)&soul_shard<4&buff.demonic_core.up;
	if currentSpell ~= DE.Demonbolt and
		spellHistory[1] == DE.HandOfGuldan and
		soulShards >= 1 and
		(wildImps <= 3 or spellHistory[3] == DE.HandOfGuldan) and
		soulShards < 4 and
		buff[DE.DemonicCoreAura].up
	then
		return DE.Demonbolt;
	end

	-- summon_vilefiend,if=(cooldown.summon_demonic_tyrant.remains>40&spell_targets.implosion<=2)|cooldown.summon_demonic_tyrant.remains<12;
	if talents[DE.SummonVilefiend] and cooldown[DE.SummonVilefiend].ready and soulShards >= 1 and
		currentSpell ~= DE.SummonVilefiend and (
		(cooldown[DE.SummonDemonicTyrant].remains > 40 and targets <= 2) or cooldown[DE.SummonDemonicTyrant].remains < 12
	) then
		return DE.SummonVilefiend;
	end

	-- bilescourge_bombers,if=cooldown.summon_demonic_tyrant.remains>9;
	if talents[DE.BilescourgeBombers] and cooldown[DE.BilescourgeBombers].ready and soulShards >= 2 and
		cooldown[DE.SummonDemonicTyrant].remains > 9 then
		return DE.BilescourgeBombers;
	end

	-- soul_strike,if=soul_shard<5&buff.demonic_core.stack<=2;
	if talents[DE.SoulStrike] and cooldown[DE.SoulStrike].ready and soulShards < 5 and buff[DE.DemonicCoreAura].count <= 2 then
		return DE.SoulStrike;
	end

	-- demonbolt,if=soul_shard<=3&buff.demonic_core.up&(buff.demonic_core.stack>=3|buff.demonic_core.remains<=gcd*5.7);
	if currentSpell ~= DE.Demonbolt and
		soulShards <= 3 and
		buff[DE.DemonicCoreAura].up and
		(buff[DE.DemonicCoreAura].count >= 3 or buff[DE.DemonicCoreAura].remains <= gcd * 5.7)
	then
		return DE.Demonbolt;
	end

	-- doom,cycle_targets=1,max_cycle_targets=7,if=refreshable;
	if talents[DE.Doom] and debuff[DE.Doom].refreshable then
		return DE.Doom;
	end

	-- call_action_list,name=build_a_shard;
	local result = Warlock:DemonologyBuildAShard();
	if result then
		return result;
	end
end

function Warlock:DemonologyNetherPortal()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;

	-- call_action_list,name=nether_portal_building,if=cooldown.nether_portal.remains<20;
	if cooldown[DE.NetherPortal].remains < 20 then
		local result = Warlock:DemonologyNetherPortalBuilding();
		if result then
			return result;
		end
	end

	-- call_action_list,name=nether_portal_active,if=cooldown.nether_portal.remains>165;
	if cooldown[DE.NetherPortal].remains > 165 then
		local result = Warlock:DemonologyNetherPortalActive();
		if result then
			return result;
		end
	end
end

function Warlock:DemonologyNetherPortalActive()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local soulShards = fd.soulShards;

	-- bilescourge_bombers;
	if talents[DE.BilescourgeBombers] and cooldown[DE.BilescourgeBombers].ready and soulShards >= 2 then
		return DE.BilescourgeBombers;
	end

	-- summon_vilefiend,if=cooldown.summon_demonic_tyrant.remains>40|cooldown.summon_demonic_tyrant.remains<12;
	if talents[DE.SummonVilefiend] and cooldown[DE.SummonVilefiend].ready and soulShards >= 1 and
		currentSpell ~= DE.SummonVilefiend and (
		cooldown[DE.SummonDemonicTyrant].remains > 40 or cooldown[DE.SummonDemonicTyrant].remains < 12
	) then
		return DE.SummonVilefiend;
	end

	-- call_dreadstalkers,if=(cooldown.summon_demonic_tyrant.remains<9&buff.demonic_calling.remains)|(cooldown.summon_demonic_tyrant.remains<11&!buff.demonic_calling.remains)|cooldown.summon_demonic_tyrant.remains>14;
	if cooldown[DE.CallDreadstalkers].ready and soulShards >= 2 and currentSpell ~= DE.CallDreadstalkers and (
		(cooldown[DE.SummonDemonicTyrant].remains < 9 and buff[DE.DemonicCalling].remains) or
			(cooldown[DE.SummonDemonicTyrant].remains < 11 and not buff[DE.DemonicCalling].remains) or
			cooldown[DE.SummonDemonicTyrant].remains > 14
	) then
		return DE.CallDreadstalkers;
	end

	-- call_action_list,name=build_a_shard,if=soul_shard=1&(cooldown.call_dreadstalkers.remains<action.shadow_bolt.cast_time|(talent.bilescourge_bombers.enabled&cooldown.bilescourge_bombers.remains<action.shadow_bolt.cast_time));
	if soulShards == 1 and (
		cooldown[DE.CallDreadstalkers].remains < timeShift or (
			talents[DE.BilescourgeBombers] and cooldown[DE.BilescourgeBombers].remains < timeShift
		)
	) then
		local result = Warlock:DemonologyBuildAShard();
		if result then
			return result;
		end
	end

	-- hand_of_guldan,if=((cooldown.call_dreadstalkers.remains>action.demonbolt.cast_time)&(cooldown.call_dreadstalkers.remains>action.shadow_bolt.cast_time))&cooldown.nether_portal.remains>(165+action.hand_of_guldan.cast_time);
	if soulShards >= 1 and currentSpell ~= DE.HandOfGuldan and (
		(
			(cooldown[DE.CallDreadstalkers].remains > timeShift) and
				(cooldown[DE.CallDreadstalkers].remains > timeShift)
		) and cooldown[DE.NetherPortal].remains > (165 + timeShift)) then
		return DE.HandOfGuldan;
	end

	-- demonbolt,if=buff.demonic_core.up&soul_shard<=3;
	if currentSpell ~= DE.Demonbolt and buff[DE.DemonicCoreAura].up and soulShards <= 3 then
		return DE.Demonbolt;
	end

	-- call_action_list,name=build_a_shard;
	return Warlock:DemonologyBuildAShard();
end

function Warlock:DemonologyNetherPortalBuilding()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local wildImps = fd.wildImps;
	local soulShards = fd.soulShards;

	-- call_dreadstalkers;
	if cooldown[DE.CallDreadstalkers].ready and soulShards >= 2 and currentSpell ~= DE.CallDreadstalkers then
		return DE.CallDreadstalkers;
	end

	-- hand_of_guldan,if=cooldown.call_dreadstalkers.remains>18&soul_shard>=3;
	if currentSpell ~= DE.HandOfGuldan and cooldown[DE.CallDreadstalkers].remains > 18 and soulShards >= 3 then
		return DE.HandOfGuldan;
	end

	-- power_siphon,if=buff.wild_imps.stack>=2&buff.demonic_core.stack<=2&buff.demonic_power.down&soul_shard>=3;
	if talents[DE.PowerSiphon] and cooldown[DE.PowerSiphon].ready and (
		wildImps >= 2 and buff[DE.DemonicCoreAura].count <= 2 and not buff[DE.DemonicPower].up and soulShards >= 3
	) then
		return DE.PowerSiphon;
	end

	-- hand_of_guldan,if=soul_shard>=5;
	if soulShards >= 1 and currentSpell ~= DE.HandOfGuldan and soulShards >= 5 then
		return DE.HandOfGuldan;
	end

	-- call_action_list,name=build_a_shard;
	return Warlock:DemonologyBuildAShard();
end


Warlock.WildImps = {};
local ImpIds = {
	[55659]  = true,
	[143622] = true,
	[99737]  = true,
	[66278]  = true,
	[134468] = true,
};

function Warlock:CLEU()
	local compTime = GetTime();
	local expTime = 20;

	local _, event, _, sourceGuid, sourceName, _, _, destGuid, destName, _, _, spellId, spellName = CombatLogGetCurrentEventInfo();

	local imp = self.WildImps[sourceGuid];
	if imp and event == 'SPELL_CAST_SUCCESS' then
		imp.casts = imp.casts - 1;

		if imp.casts <= 0 then
			self.WildImps[sourceGuid] = nil;
		end
	end

	if sourceGuid == UnitGUID('player') then
		if event == 'SPELL_SUMMON' then
			local unitId = select(6, strsplit('-', destGuid));
			unitId = tonumber(unitId);

			if ImpIds[unitId] then
				self.WildImps[destGuid] = {
					expTime = compTime + expTime,
					casts = 5
				};
			end
		elseif event == 'SPELL_CAST_SUCCESS' and spellId == DE.Implosion then
			wipe(self.WildImps);
		elseif event == 'SPELL_CAST_SUCCESS' and spellId == DE.SummonDemonicTyrant and
			MaxDps.FrameData.talents[DE.DemonicConsumption]
		then
			wipe(self.WildImps);
		end
	end
end

function Warlock:ImpsCount()
	local c = 0;
	local compTime = GetTime();

	for guid, imp in pairs(Warlock.WildImps) do
		if compTime > imp.expTime then
			Warlock.WildImps[guid] = nil;
		else
			c = c + 1;
		end
	end

	if WeakAuras then
		WeakAuras.ScanEvents('MAXDPS_IMP_COUNT', c);
	end
	return c;
end