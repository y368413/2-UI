if select(2, UnitClass("player")) ~= "MAGE" then return end

local _, MaxDps_MageTable = ...;
local Mage = MaxDps_MageTable.Mage;
local MaxDps = MaxDps;
local UnitHealth = UnitHealth;
local UnitHealthMax = UnitHealthMax;

local FR = {
	ArcaneIntellect   = 1459,
	MirrorImage       = 55342,
	Pyroblast         = 11366,
	Combustion        = 190319,
	RuneOfPower       = 116011,
	RuneOfPowerAura   = 116014,
	Firestarter       = 205026,
	FireBlast         = 108853,
	PhoenixFlames     = 257541,
	LivingBomb        = 44457,
	Meteor            = 153561,
	Scorch            = 2948,
	HotStreak         = 48108,
	HeatingUp         = 48107,
	Pyroclasm         = 269650,
	DragonsBreath     = 31661,
	FlameOn           = 205029,
	Flamestrike       = 2120,
	FlamePatch        = 205037,
	SearingTouch      = 269644,
	AlexstraszasFury  = 235870,
	Fireball          = 133,
	Kindling          = 155148,
	BlasterMasterAura = 274598,
	TimeWarp          = 80353,
};

local CN = {
	None      = 0,
	Kyrian    = 1,
	Venthyr   = 2,
	NightFae  = 3,
	Necrolord = 4
};

-- Covenant abilities	
local C = {
	-- Buttons
	ClassAbility = 313347,
	SignatureAbility = 326526,
	-- Kyrian
	RadiantSpark = 307443,
	-- Necrolord
	Deathborne = 324220,
	-- Night Fae
	ShiftingPower = 314791,
	-- Venthyr
    MirrorsOfTorment = 314793,
}

local A = {
	BlasterMaster = 274596,
}

setmetatable(FR, Mage.spellMeta);
setmetatable(A, Mage.spellMeta);

function Mage:Fire()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local covenant = fd.covenant.covenantId;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local timeToDie = fd.timeToDie;
	local spellHistory = fd.spellHistory;
	local targetHp = MaxDps:TargetPercentHealth() * 100;
	local targets = MaxDps:SmartAoe();
	local combustionRopCutoff = 60;
	local firestarterActive = talents[FR.Firestarter] and targetHp > 90;
    local health = UnitHealth('player')
	local healthMax = UnitHealthMax('player');
	local healthPercent = ( health / healthMax ) * 100

	fd.targets = targets;
	fd.targetHp = targetHp;
	fd.combustionRopCutoff = combustionRopCutoff;

	MaxDps:GlowEssences();

	-- If NightFae covenant, use ShiftingPower as a cooldown
	MaxDps:GlowCooldown(
		C.ShiftingPower, 
		covenant == CN.NightFae and 
			cooldown[C.ShiftingPower].ready and
				not buff[FR.HeatingUp].up and 
					not buff[FR.HotStreak].up and
						not buff[FR.Combustion].up and 
							not buff[FR.RuneOfPowerAura].up
	);
	MaxDps:GlowCooldown(
		C.Deathborne, 
		covenant == CN.Necrolord and 
			cooldown[C.Deathborne].ready and
				not buff[FR.HeatingUp].up and 
					not buff[FR.HotStreak].up and
						not buff[FR.Combustion].up and 
							not buff[FR.RuneOfPowerAura].up
	);
	MaxDps:GlowCooldown(
		C.RadiantSpark, 
		covenant == CN.Kyrian and 
			cooldown[C.RadiantSpark].ready and
				not buff[FR.HeatingUp].up and 
					not buff[FR.HotStreak].up and
						not buff[FR.Combustion].up and 
							not buff[FR.RuneOfPowerAura].up
	);
	MaxDps:GlowCooldown(
		C.MirrorsOfTorment, 
		covenant == CN.Venthyr and 
			cooldown[C.MirrorsOfTorment].ready and
				not buff[FR.HeatingUp].up and 
					not buff[FR.HotStreak].up and
						not buff[FR.Combustion].up and 
							not buff[FR.RuneOfPowerAura].up
	);
	-- mirror_image,if=buff.combustion.down; isnt a dps CD so only use on lower then 50% life
	MaxDps:GlowCooldown(FR.MirrorImage, cooldown[FR.MirrorImage].ready and not buff[FR.Combustion].up and healthPercent < 50);

	-- rune_of_power,if=talent.firestarter.enabled&firestarter.remains>full_recharge_time|cooldown.combustion.remains>variable.combustion_rop_cutoff&buff.combustion.down|target.time_to_die<cooldown.combustion.remains&buff.combustion.down;
	if talents[FR.RuneOfPower] then
		MaxDps:GlowCooldown(FR.RuneOfPower,
			cooldown[FR.RuneOfPower].ready and
				currentSpell ~= FR.RuneOfPower and
				(
					firestarterActive or
						(cooldown[FR.Combustion].remains > combustionRopCutoff and not buff[FR.Combustion].up) or
						timeToDie < cooldown[FR.Combustion].remains and not buff[FR.Combustion].up
				)
		);
	end

	-- only use combustion if you have enough charges to support it
	MaxDps:GlowCooldown(FR.Combustion,
		cooldown[FR.Combustion].ready and
			cooldown[FR.FireBlast].charges > 2.5 and
			cooldown[FR.PhoenixFlames].charges > 2.75
	);


	-- call_action_list,name=combustion_phase,if=(talent.rune_of_power.enabled&cooldown.combustion.remains<=action.rune_of_power.cast_time|cooldown.combustion.ready)&!firestarter.active|buff.combustion.up;
	if buff[FR.Combustion].up then
		local result = Mage:FireCombustionPhase();
		if result then return result; end
	end

	-- call_action_list,name=rop_phase,if=buff.rune_of_power.up&buff.combustion.down;
	if buff[FR.RuneOfPowerAura].up and not buff[FR.Combustion].up then
		local result = Mage:FireRopPhase();
		if result then return result; end
	end

	-- call_action_list,name=standard_rotation;
	return Mage:FireStandardRotation();
end

function Mage:FireActiveTalents()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local targets = fd.targets;
	local timeToDie = fd.timeToDie;
	local targetHp = fd.targetHp;
	local firestarterActive = fd.firestarterActive;

	-- living_bomb,if=active_enemies>1&buff.combustion.down&(cooldown.combustion.remains>cooldown.living_bomb.duration|cooldown.combustion.ready);
	if talents[FR.LivingBomb] and cooldown[FR.LivingBomb].ready and
		targets > 1 and
		not buff[FR.Combustion].up and
		(cooldown[FR.Combustion].remains > cooldown[FR.LivingBomb].duration or cooldown[FR.Combustion].ready)
	then
		return FR.LivingBomb;
	end

	-- meteor,if=buff.rune_of_power.up&(firestarter.remains>cooldown.meteor.duration|!firestarter.active)|cooldown.rune_of_power.remains>target.time_to_die&action.rune_of_power.charges<1|(cooldown.meteor.duration<cooldown.combustion.remains|cooldown.combustion.ready)&!talent.rune_of_power.enabled&(cooldown.meteor.duration<firestarter.remains|!talent.firestarter.enabled|!firestarter.active);
	if talents[FR.Meteor] and cooldown[FR.Meteor].ready and (
		buff[FR.RuneOfPowerAura].up and not firestarterActive or
			cooldown[FR.RuneOfPower].remains > timeToDie and cooldown[FR.RuneOfPower].charges < 1 or
			(cooldown[FR.Meteor].duration < cooldown[FR.Combustion].remains or cooldown[FR.Combustion].ready) and
				not talents[FR.RuneOfPower] and
				(not talents[FR.Firestarter] or not firestarterActive)
	) then
		return FR.Meteor;
	end
end

function Mage:FireCombustionPhase()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local targets = fd.targets;
	local spellHistory = fd.spellHistory;
	local targetHp = fd.targetHp;
	local gcd = fd.gcd;

	-- call_action_list,name=active_talents;
	local result = Mage:FireActiveTalents();
	if result then return result; end

	-- flamestrike,if=((talent.flame_patch.enabled&active_enemies>2)|active_enemies>6)&buff.hot_streak.react;
	if currentSpell ~= FR.Flamestrike and
		((talents[FR.FlamePatch] and targets > 2) or targets > 6) and
		buff[FR.HotStreak].up
	then
		return FR.Flamestrike;
	end

	-- pyroblast,if=buff.pyroclasm.react&buff.combustion.remains>cast_time;
	if currentSpell ~= FR.Pyroblast and buff[FR.Pyroclasm].up and buff[FR.Combustion].remains > 4.5 then -- 100 OK
		return FR.Pyroblast;
	end

	-- pyroblast,if=buff.hot_streak.react;
	if currentSpell ~= FR.Pyroblast and buff[FR.HotStreak].up then -- 100 OK
		return FR.Pyroblast;
	end

	-- fire_blast,use_off_gcd=1,use_while_casting=1,if=(!azerite.blaster_master.enabled|!talent.flame_on.enabled)&((buff.combustion.up&(buff.heating_up.react&!action.pyroblast.in_flight&!action.scorch.executing)|(action.scorch.execute_remains&buff.heating_up.down&buff.hot_streak.down&!action.pyroblast.in_flight)));
	if cooldown[FR.FireBlast].ready and (
		(azerite[A.BlasterMaster] == 0 or not talents[FR.FlameOn]) and
			(
				buff[FR.Combustion].up and (buff[FR.HeatingUp].up and currentSpell ~= FR.Scorch) or
					(currentSpell == FR.Scorch and not buff[FR.HeatingUp].up and not buff[FR.HotStreak].up)
			)
	) then
		return FR.FireBlast;
	end

	-- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up;
	if currentSpell ~= FR.Pyroblast and currentSpell == FR.Scorch and buff[FR.HeatingUp].up then -- 100 OK
		return FR.Pyroblast;
	end

	-- phoenix_flames;
	if cooldown[FR.PhoenixFlames].ready then -- 100 OK
		return FR.PhoenixFlames;
	end

	-- scorch,if=buff.combustion.remains>cast_time&buff.combustion.up|buff.combustion.down;
	if currentSpell ~= FR.Scorch and (
		buff[FR.Combustion].remains > 1.5 and buff[FR.Combustion].up or
			not buff[FR.Combustion].up ) then -- 100 OK
		return FR.Scorch;
	end

	-- living_bomb,if=buff.combustion.remains<gcd.max&active_enemies>1;
	if talents[FR.LivingBomb] and cooldown[FR.LivingBomb].ready and buff[FR.Combustion].remains < gcd and targets > 1 then -- 100 OK
		return FR.LivingBomb;
	end

	-- dragons_breath,if=buff.combustion.remains<gcd.max&buff.combustion.up;
	if cooldown[FR.DragonsBreath].ready and buff[FR.Combustion].remains < gcd and buff[FR.Combustion].up then -- 100 OK
		return FR.DragonsBreath;
	end

	-- scorch,if=target.health.pct<=30&talent.searing_touch.enabled;
	if targetHp <= 30 and talents[FR.SearingTouch] then -- 100 OK
		return FR.Scorch;
	end
end

function Mage:FireRopPhase()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local spellHistory = fd.spellHistory;
	local targets = fd.targets;
	local targetHp = fd.targetHp;
	local firestarterActive = fd.firestarterActive;

	-- flamestrike,if=((talent.flame_patch.enabled&active_enemies>1)|active_enemies>4)&buff.hot_streak.react;
	if currentSpell ~= FR.Flamestrike and
		((talents[FR.FlamePatch] and targets > 1) or targets > 4) and
		buff[FR.HotStreak].up
	then
		return FR.Flamestrike;
	end

	-- pyroblast,if=buff.hot_streak.react;
	if currentSpell ~= FR.Pyroblast and buff[FR.HotStreak].up then
		return FR.Pyroblast;
	end

	-- fire_blast,use_off_gcd=1,use_while_casting=1,if=(cooldown.combustion.remains>25|firestarter.active)&(!buff.heating_up.react&!buff.hot_streak.react&!prev_off_gcd.fire_blast&
    -- (action.fire_blast.charges>=2.5|(talent.alexstraszas_fury.enabled&cooldown.dragons_breath.ready)|(talent.searing_touch.enabled&target.health.pct<=30)|(firestarter.active)));
	if cooldown[FR.FireBlast].ready and (
		(cooldown[FR.Combustion].remains > 25 or firestarterActive) and
			(
				not buff[FR.HeatingUp].up and
					not buff[FR.HotStreak].up and
					(
						cooldown[FR.FireBlast].charges >= 2.5 or
                        (talents[FR.AlexstraszasFury] and cooldown[FR.DragonsBreath].ready) or
                        (talents[FR.SearingTouch] and targetHp <= 30) or
                        firestarterActive
					)
			)
	) then
		return FR.FireBlast;
	end

	-- call_action_list,name=active_talents;
	local result = Mage:FireActiveTalents();
	if result then return result; end

	-- pyroblast,if=buff.pyroclasm.react&cast_time<buff.pyroclasm.remains&buff.rune_of_power.remains>cast_time;
	if currentSpell ~= FR.Pyroblast and
		buff[FR.Pyroclasm].up and
		timeShift < buff[FR.Pyroclasm].remains and
		buff[FR.RuneOfPowerAura].remains > timeShift
	then
		return FR.Pyroblast;
	end

	-- fire_blast,use_off_gcd=1,use_while_casting=1,if=(cooldown.combustion.remains>0|firestarter.active&buff.rune_of_power.up)&(buff.heating_up.react&(target.health.pct>=30|!talent.searing_touch.enabled));
	if cooldown[FR.FireBlast].ready and buff[FR.HeatingUp].up and
		(cooldown[FR.Combustion].remains > 25 or firestarterActive )
	then
		return FR.FireBlast;
	end

	-- fire_blast,use_off_gcd=1,use_while_casting=1,if=(cooldown.combustion.remains>0|firestarter.active&buff.rune_of_power.up)&talent.searing_touch.enabled&target.health.pct<=30&(buff.heating_up.react&!action.scorch.executing|!buff.heating_up.react&!buff.hot_streak.react);
	if cooldown[FR.FireBlast].ready and
		(cooldown[FR.Combustion].remains > 25 or firestarterActive ) and
		talents[FR.SearingTouch] and targetHp <= 30 and
		(buff[FR.HeatingUp].up and not currentSpell == FR.Scorch)
	then
		return FR.FireBlast;
	end

	-- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up&talent.searing_touch.enabled&target.health.pct<=30&(!talent.flame_patch.enabled|active_enemies=1);
	if currentSpell ~= FR.Pyroblast and
		spellHistory[1] == FR.Scorch and
		buff[FR.HeatingUp].up and
		talents[FR.SearingTouch] and
		targetHp <= 30 and
		(not talents[FR.FlamePatch] or targets <= 1)
	then
		return FR.Pyroblast;
	end

	-- phoenix_flames, only if we have 3 charges and Combust not ready in less then 25 sec, to prevent cap!
	if cooldown[FR.PhoenixFlames].ready and not buff[FR.HotStreak].up and
		( cooldown[FR.PhoenixFlames].charges == 3 and cooldown[FR.Combustion].remains > 25) then
		return FR.PhoenixFlames;
	end

	-- scorch,if=target.health.pct<=30&talent.searing_touch.enabled;
	if targetHp <= 30 and talents[FR.SearingTouch] then
		return FR.Scorch;
	end

	-- dragons_breath,if=active_enemies>2;
	if cooldown[FR.DragonsBreath].ready and targets > 2 then
		return FR.DragonsBreath;
	end

	-- flamestrike,if=(talent.flame_patch.enabled&active_enemies>2)|active_enemies>5;
	if currentSpell ~= FR.Flamestrike and (
		(talents[FR.FlamePatch] and targets > 2) or targets > 5
	) then
		return FR.Flamestrike;
	end

	-- fireball;
	return FR.Fireball;
end

function Mage:FireStandardRotation()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local azerite = fd.azerite;
	local timeShift = fd.timeShift;
	local targets = fd.targets;
	local spellHistory = fd.spellHistory;
	local targetHp = fd.targetHp;
	local timeToDie = fd.timeToDie;
	local firestarterActive = fd.firestarterActive;
	local combustionRopCutoff = fd.combustionRopCutoff;

	local playerMoving = GetUnitSpeed('player') > 0;

	-- flamestrike,if=((talent.flame_patch.enabled&active_enemies>1&!firestarter.active)|active_enemies>4)&buff.hot_streak.react;
	if currentSpell ~= FR.Flamestrike and
		((talents[FR.FlamePatch] and targets > 1 and not firestarterActive) or targets > 4) and
		buff[FR.HotStreak].up
	then
		return FR.Flamestrike;
	end

	-- pyroblast,if=buff.hot_streak.react&buff.hot_streak.remains<action.fireball.execute_time;
	if buff[FR.HotStreak].up and buff[FR.HotStreak].remains < 2 then
		return FR.Pyroblast;
	end

	-- pyroblast,if=buff.hot_streak.react&(prev_gcd.1.fireball|firestarter.active|action.pyroblast.in_flight);
	if currentSpell ~= FR.Pyroblast and
		buff[FR.HotStreak].up and
		(currentSpell == FR.Fireball or firestarterActive or not currentSpell)
	then
		return FR.Pyroblast;
	end

	-- pyroblast,if=buff.hot_streak.react&target.health.pct<=30&talent.searing_touch.enabled;
	if buff[FR.HotStreak].up and targetHp <= 30 and talents[FR.SearingTouch] then
		return FR.Pyroblast;
	end

	-- pyroblast,if=buff.pyroclasm.react&cast_time<buff.pyroclasm.remains;
	if currentSpell ~= FR.Pyroblast and buff[FR.Pyroclasm].up and buff[FR.Pyroclasm].remains >= 5 then
		return FR.Pyroblast;
	end

	-- fire_blast,use_off_gcd=1,use_while_casting=1,if=(cooldown.combustion.remains>0&buff.rune_of_power.down|firestarter.active)&!talent.kindling.enabled&!variable.fire_blast_pooling&(((action.fireball.executing|action.pyroblast.executing)&(buff.heating_up.react|firestarter.active&!buff.hot_streak.react&!buff.heating_up.react))|(talent.searing_touch.enabled&target.health.pct<=30&(buff.heating_up.react&!action.scorch.executing|!buff.hot_streak.react&!buff.heating_up.react&action.scorch.executing&!action.pyroblast.in_flight&!action.fireball.in_flight))|(firestarter.active&(action.pyroblast.in_flight|action.fireball.in_flight)&!buff.heating_up.react&!buff.hot_streak.react));
	if (cooldown[FR.Combustion].remains > 25 and (cooldown[FR.FireBlast].ready and buff[FR.HeatingUp].up or cooldown[FR.FireBlast].charges >= 2.8)) or
		((cooldown[FR.Combustion].remains > 16.5 and cooldown[FR.Combustion].remains < 25) and cooldown[FR.FireBlast].charges >= 1.8 and buff[FR.HeatingUp].up) or
		((cooldown[FR.Combustion].remains > 8.6 and cooldown[FR.Combustion].remains < 16.5) and cooldown[FR.FireBlast].charges >= 2.8 and buff[FR.HeatingUp].up)
	then
		return FR.FireBlast;
	end

	-- pyroblast,if=prev_gcd.1.scorch&buff.heating_up.up&talent.searing_touch.enabled&target.health.pct<=30&((talent.flame_patch.enabled&active_enemies=1&!firestarter.active)|(active_enemies<4&!talent.flame_patch.enabled));
	if currentSpell == FR.Scorch and
		buff[FR.HeatingUp].up and
		talents[FR.SearingTouch] and
		targetHp <= 30 and
		((talents[FR.FlamePatch] and targets == 1 and not firestarterActive) or (targets < 4 and not talents[FR.FlamePatch]))
	then
		return FR.Pyroblast;
	end

	-- phoenix_flames, only if we have 3 charges and Combust not ready in less then 25 sec, to prevent cap!
	if cooldown[FR.PhoenixFlames].ready and not buff[FR.HotStreak].up and
		( cooldown[FR.PhoenixFlames].charges == 3 and cooldown[FR.Combustion].remains > 25) then
		return FR.PhoenixFlames;
	end

	-- call_action_list,name=active_talents;
	local result = Mage:FireActiveTalents();
	if result then return result; end

	-- dragons_breath,if=active_enemies>1;
	if cooldown[FR.DragonsBreath].ready and targets > 1 then
		return FR.DragonsBreath;
	end

	-- scorch,if=target.health.pct<=30&talent.searing_touch.enabled;
	if targetHp <= 30 and talents[FR.SearingTouch] then
		return FR.Scorch;
	end

	-- fireball;
	if not playerMoving then
		return FR.Fireball;
	end

	-- scorch;
	return FR.Scorch;
end