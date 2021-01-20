if select(2, UnitClass("player")) ~= "WARLOCK" then return end

local _, MaxDps_WarlockTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Warlock = MaxDps_WarlockTable.Warlock;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local GetTime = GetTime;
local GetTotemInfo = GetTotemInfo;
local Necrolord = Enum.CovenantType.Necrolord;
local Venthyr = Enum.CovenantType.Venthyr;
local NightFae = Enum.CovenantType.NightFae;
local Kyrian = Enum.CovenantType.Kyrian;

local DE = {
	InnerDemons          = 267216,
	Demonbolt            = 264178,
	SummonDemonicTyrant  = 265187,
	SummonVilefiend      = 264119,
	CallDreadstalkers    = 104316,
	Doom                 = 603,
	DemonicStrength      = 267171,
	BilescourgeBombers   = 267211,
	Implosion            = 196277,
	SacrificedSouls      = 267214,
	HandOfGuldan         = 105174,
	NetherPortal         = 267217,
	DemonicCore          = 267102,
	DemonicCoreAura      = 264173,
	GrimoireFelguard     = 111898,
	PowerSiphon          = 264130,
	SoulStrike           = 264057,
	ShadowBolt           = 686,
	ImpendingCatastrophe = 321792,
	ScouringTithe        = 312321,
	SoulRot              = 325640,
	DecimatingBolt       = 325289,
	DemonicConsumption   = 267215,
	DemonicPower         = 265273,

	Felstorm = 89751
};

local TotemIcons = {
	[1616211] = 'Vilefiend',
	[136216]  = 'Felguard',
	[1378282] = 'Dreadstalker'
};

setmetatable(DE, Warlock.spellMeta);
local tyrantReady = false;
local tyrantTimeLimit = 0;
local forceTyrant = false;

function Warlock:Demonology()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local targets = MaxDps:SmartAoe();
	local spellHistory = fd.spellHistory;
	local gcd = fd.gcd;
	local timeToDie = fd.timeToDie;
	local wildImps = GetSpellCount(DE.Implosion); --Warlock:ImpsCount();

	local covenantId = fd.covenant.covenantId;
	local soulShards = UnitPower('player', Enum.PowerType.SoulShards);
	local tyrantUp = buff[DE.DemonicPower].up;
	local petAura = MaxDps:IntUnitAura('pet', DE.Felstorm, nil, timeShift);
	local canDS = not petAura.up;

	if currentSpell == DE.CallDreadstalkers then
		soulShards = soulShards - 2;
	elseif currentSpell == DE.HandOfGuldan then
		soulShards = soulShards - 3;
	elseif currentSpell == DE.SummonVilefiend then
		soulShards = soulShards - 1;
	elseif currentSpell == DE.NetherPortal then
		soulShards = soulShards - 1;
	elseif currentSpell == DE.ShadowBolt then
		soulShards = soulShards + 1;
	elseif currentSpell == DE.Demonbolt then
		soulShards = soulShards + 2;
	elseif currentSpell == DE.SummonDemonicTyrant then
		soulShards = 5;
	end

	if soulShards < 0 then
		soulShards = 0;
	end

	fd.wildImps = wildImps;
	fd.soulShards = soulShards;
	fd.targets = targets;
	fd.canDS = canDS;

	if talents[DE.GrimoireFelguard] then
		MaxDps:GlowCooldown(DE.GrimoireFelguard,
			soulShards >= 1 and cooldown[DE.GrimoireFelguard].ready and cooldown[DE.SummonDemonicTyrant].remains < 13
		);
	end

	if forceTyrant then
		if tyrantTimeLimit < GetTime() then
			forceTyrant = false;
		end

		if not cooldown[DE.SummonDemonicTyrant].ready then
			forceTyrant = false;
		else
			if currentSpell ~= DE.SummonDemonicTyrant then
				return DE.SummonDemonicTyrant;
			end
		end
	end

	-- run_action_list,name=tyrant_prep,if=cooldown.summon_demonic_tyrant.remains<4&!variable.tyrant_ready;
	if cooldown[DE.SummonDemonicTyrant].remains < 4 and not tyrantReady then
		return Warlock:DemonologyTyrantPrep();
	end

	-- run_action_list,name=summon_tyrant,if=variable.tyrant_ready;
	if tyrantReady then
		return Warlock:DemonologySummonTyrant();
	end

	-- summon_vilefiend,if=cooldown.summon_demonic_tyrant.remains>40|time_to_die<cooldown.summon_demonic_tyrant.remains+25;
	if talents[DE.SummonVilefiend] and
		cooldown[DE.SummonVilefiend].ready and
		soulShards >= 1 and
		currentSpell ~= DE.SummonVilefiend and
		(cooldown[DE.SummonDemonicTyrant].remains > 40 or timeToDie < cooldown[DE.SummonDemonicTyrant].remains + 25)
	then
		return DE.SummonVilefiend;
	end

	-- call_dreadstalkers;
	if cooldown[DE.CallDreadstalkers].ready and soulShards >= 2 and currentSpell ~= DE.CallDreadstalkers then
		return DE.CallDreadstalkers;
	end

	-- doom,if=refreshable;
	if talents[DE.Doom] and debuff[DE.Doom].refreshable then
		return DE.Doom;
	end

	-- demonic_strength;
	if talents[DE.DemonicStrength] and canDS and cooldown[DE.DemonicStrength].ready then
		return DE.DemonicStrength;
	end

	-- bilescourge_bombers;
	if talents[DE.BilescourgeBombers] and cooldown[DE.BilescourgeBombers].ready and soulShards >= 2 then
		return DE.BilescourgeBombers;
	end

	-- implosion,if=active_enemies>1&!talent.sacrificed_souls.enabled&buff.wild_imps.stack>=8&buff.tyrant.down&cooldown.summon_demonic_tyrant.remains>5;
	if targets > 1 and
		not talents[DE.SacrificedSouls] and
		wildImps >= 8 and
		not tyrantUp and
		cooldown[DE.SummonDemonicTyrant].remains > 5
	then
		return DE.Implosion;
	end

	-- implosion,if=active_enemies>2&buff.wild_imps.stack>=8&buff.tyrant.down;
	if targets > 2 and wildImps >= 8 and not tyrantUp then
		return DE.Implosion;
	end

	-- hand_of_guldan,if=soul_shard=5|buff.nether_portal.up;
	if soulShards >= 5 or (buff[DE.NetherPortal].up and soulShards >= 1) then
		-- soulShards >= 1 and currentSpell ~= DE.HandOfGuldan and ()
		-- probably doesnt need this check
		return DE.HandOfGuldan;
	end

	-- hand_of_guldan,if=soul_shard>=3&cooldown.summon_demonic_tyrant.remains>20&(cooldown.summon_vilefiend.remains>5|!talent.summon_vilefiend.enabled)&cooldown.call_dreadstalkers.remains>2;
	if currentSpell ~= DE.HandOfGuldan and
		soulShards >= 3 and
		cooldown[DE.SummonDemonicTyrant].remains > 20 and
		(cooldown[DE.SummonVilefiend].remains > 5 or not talents[DE.SummonVilefiend]) and
		cooldown[DE.CallDreadstalkers].remains > 2
	then
		return DE.HandOfGuldan;
	end

	-- call_action_list,name=covenant,if=(covenant.necrolord|covenant.night_fae)&!talent.nether_portal.enabled;
	if (covenantId == Necrolord or covenantId == NightFae) and
		not talents[DE.NetherPortal]
	then
		local result = Warlock:DemonologyCovenant();
		if result then
			return result;
		end
	end

	-- demonbolt,if=buff.demonic_core.react&soul_shard<4;
	if (
		buff[DE.DemonicCoreAura].count > 2 and soulShards < 4 or
		buff[DE.DemonicCoreAura].up and buff[DE.DemonicCoreAura].remains < 4
	) then
		return DE.Demonbolt;
	end

	-- grimoire_felguard,if=cooldown.summon_demonic_tyrant.remains+cooldown.summon_demonic_tyrant.duration>time_to_die|time_to_die<cooldown.summon_demonic_tyrant.remains+15;
	--if cooldown[DE.GrimoireFelguard].ready and
	--	soulShards >= 1 and (
	--	cooldown[DE.SummonDemonicTyrant].remains + cooldown[DE.SummonDemonicTyrant].duration > timeToDie or
	--	timeToDie < cooldown[DE.SummonDemonicTyrant].remains + 15
	--) then
	--	return DE.GrimoireFelguard;
	--end

	-- power_siphon,if=buff.wild_imps.stack>1&buff.demonic_core.stack<3;
	if talents[DE.PowerSiphon] and cooldown[DE.PowerSiphon].ready and (wildImps > 1 and buff[DE.DemonicCoreAura].count < 3) then
		return DE.PowerSiphon;
	end

	-- soul_strike;
	if talents[DE.SoulStrike] and cooldown[DE.SoulStrike].ready then
		return DE.SoulStrike;
	end

	-- call_action_list,name=covenant;
	local result = Warlock:DemonologyCovenant();
	if result then
		return result;
	end

	-- shadow_bolt;
	return DE.ShadowBolt;
end

function Warlock:DemonologyCovenant()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local targets = fd.targets;
	local covenantId = fd.covenant.covenantId;

	if covenantId == Venthyr then
		-- impending_catastrophe,if=!talent.sacrificed_souls.enabled|active_enemies>1;
		if cooldown[DE.ImpendingCatastrophe].ready and currentSpell ~= DE.ImpendingCatastrophe and
			(not talents[DE.SacrificedSouls] or targets > 1)
		then
			return DE.ImpendingCatastrophe;
		end
	end

	if covenantId == Kyrian then
		-- scouring_tithe,if=talent.sacrificed_souls.enabled&active_enemies=1;
		if cooldown[DE.ScouringTithe].ready and currentSpell ~= DE.ScouringTithe and
			(talents[DE.SacrificedSouls] and targets <= 1)
		then
			return DE.ScouringTithe;
		end

		-- scouring_tithe,if=!talent.sacrificed_souls.enabled&active_enemies<4;
		if cooldown[DE.ScouringTithe].ready and currentSpell ~= DE.ScouringTithe and
			(not talents[DE.SacrificedSouls] and targets < 4)
		then
			return DE.ScouringTithe;
		end
	end

	if covenantId == NightFae then
		-- soul_rot;
		if cooldown[DE.SoulRot].ready and currentSpell ~= DE.SoulRot then
			return DE.SoulRot;
		end
	end

	if covenantId == Necrolord then
		-- decimating_bolt;
		if cooldown[DE.DecimatingBolt].ready and currentSpell ~= DE.DecimatingBolt then
			return DE.DecimatingBolt;
		end
	end
end

function Warlock:DemonologySummonTyrant()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local soulShards = fd.soulShards;
	local wildImps = fd.wildImps;
	local pets = Warlock:Pets();

	-- hand_of_guldan,if=soul_shard=5,line_cd=20;
	if soulShards == 5 then -- currentSpell ~= DE.HandOfGuldan and
		return DE.HandOfGuldan;
	end

	-- demonbolt,if=buff.demonic_core.up&(talent.demonic_consumption.enabled|buff.nether_portal.down),line_cd=20;
	if buff[DE.DemonicCoreAura].up and
		soulShards < 4 and
		(talents[DE.DemonicConsumption] or not buff[DE.NetherPortal].up)
	then
		return DE.Demonbolt;
	end

	-- shadow_bolt,if=buff.wild_imps.stack+incoming_imps<4&(talent.demonic_consumption.enabled|buff.nether_portal.down),line_cd=20;
	--if --currentSpell ~= DE.ShadowBolt and
	--	soulShards < 5 and
	--	wildImps < 4 and
	--	(talents[DE.DemonicConsumption] or not buff[DE.NetherPortal].up)
	--then
	--	return DE.ShadowBolt;
	--end

	-- call_dreadstalkers;
	if cooldown[DE.CallDreadstalkers].ready and soulShards >= 2 and currentSpell ~= DE.CallDreadstalkers then
		return DE.CallDreadstalkers;
	end

	-- hand_of_guldan;
	if soulShards >= 3 and currentSpell ~= DE.HandOfGuldan then
		return DE.HandOfGuldan;
	end

	local vilefiendRemains = pets.Vilefiend;
	local felguardRemains = pets.Felguard;
	-- demonbolt,if=buff.demonic_core.up&buff.nether_portal.up&((buff.vilefiend.remains>5|!talent.summon_vilefiend.enabled)&(buff.grimoire_felguard.remains>5|buff.grimoire_felguard.down));
	if buff[DE.DemonicCoreAura].up and
		buff[DE.NetherPortal].up and
		(
			(vilefiendRemains > 5 or not talents[DE.SummonVilefiend]) and
			(felguardRemains > 5 or felguardRemains <= 0)
		)
	then
		return DE.Demonbolt;
	end

	-- shadow_bolt,if=buff.nether_portal.up&((buff.vilefiend.remains>5|!talent.summon_vilefiend.enabled)&(buff.grimoire_felguard.remains>5|buff.grimoire_felguard.down));
	if --currentSpell ~= DE.ShadowBolt and
		buff[DE.NetherPortal].up and
		(
			(vilefiendRemains > 5 or not talents[DE.SummonVilefiend]) and
			(felguardRemains > 5 or felguardRemains <= 0)
		)
	then
		return DE.ShadowBolt;
	end

	-- variable,name=tyrant_ready,value=!cooldown.summon_demonic_tyrant.ready;
	tyrantReady = not cooldown[DE.SummonDemonicTyrant].ready;

	-- summon_demonic_tyrant;
	if cooldown[DE.SummonDemonicTyrant].ready and currentSpell ~= DE.SummonDemonicTyrant then
		forceTyrant = true;
		tyrantTimeLimit = GetTime() + 2;
		return DE.SummonDemonicTyrant;
	end

	-- shadow_bolt;
	--if currentSpell ~= DE.ShadowBolt then
		return DE.ShadowBolt;
	--end
end

function Warlock:DemonologyTyrantPrep()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local soulShards = fd.soulShards;
	local debuff = fd.debuff;
	local canDS = fd.canDS;

	-- doom,line_cd=30;
	if talents[DE.Doom] and debuff[DE.Doom].refreshable then
		return DE.Doom;
	end

	-- demonic_strength,if=!talent.demonic_consumption.enabled;
	if talents[DE.DemonicStrength] and
		canDS and
		cooldown[DE.DemonicStrength].ready and
		not talents[DE.DemonicConsumption]
	then
		return DE.DemonicStrength;
	end

	-- nether_portal;
	if talents[DE.NetherPortal] and cooldown[DE.NetherPortal].ready and soulShards >= 1 and currentSpell ~= DE.NetherPortal then
		return DE.NetherPortal;
	end

	-- grimoire_felguard;
	--if cooldown[DE.GrimoireFelguard].ready and soulShards >= 1 then
	--	return DE.GrimoireFelguard;
	--end

	-- summon_vilefiend;
	if talents[DE.SummonVilefiend] and
		cooldown[DE.SummonVilefiend].ready and
		soulShards >= 1 and
		currentSpell ~= DE.SummonVilefiend
	then
		return DE.SummonVilefiend;
	end

	-- call_dreadstalkers;
	if cooldown[DE.CallDreadstalkers].ready and soulShards >= 2 and currentSpell ~= DE.CallDreadstalkers then
		return DE.CallDreadstalkers;
	end

	-- demonbolt,if=buff.demonic_core.up&soul_shard<4&(talent.demonic_consumption.enabled|buff.nether_portal.down);
	if currentSpell ~= DE.Demonbolt and
		(buff[DE.DemonicCoreAura].count > 2 or buff[DE.DemonicCoreAura].up and buff[DE.DemonicCoreAura].remains < 4) and
		soulShards < 4 and
		(talents[DE.DemonicConsumption] or not buff[DE.NetherPortal].up)
	then
		return DE.Demonbolt;
	end

	-- shadow_bolt,if=soul_shard<5-4*buff.nether_portal.up;
	if soulShards < 5 - 4 * buff[DE.NetherPortal].upMath then --currentSpell ~= DE.ShadowBolt and
		return DE.ShadowBolt;
	end

	-- variable,name=tyrant_ready,value=1;
	tyrantReady = true;

	-- hand_of_guldan;
	--if soulShards >= 1 and currentSpell ~= DE.HandOfGuldan then
		return DE.HandOfGuldan;
	--end
end

function Warlock:Pets()
	local pets = {
		Vilefiend = 0,
		Felguard = 0,
		Dreadstalker = 0
	};

	for index = 1, MAX_TOTEMS do
		local hasTotem, totemName, startTime, duration, icon = GetTotemInfo(index);
		if hasTotem then
			local totemUnifiedName = TotemIcons[icon];
			if totemUnifiedName then
				local remains = startTime + duration - GetTime();
				pets[totemUnifiedName] = remains;
			end
		end
	end

	return pets;
end