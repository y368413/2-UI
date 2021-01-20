if select(2, UnitClass("player")) ~= "WARRIOR" then return end

local _, MaxDps_WarriorTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Warrior = MaxDps_WarriorTable.Warrior;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local PowerTypeRage = Enum.PowerType.Rage;

local Necrolord = Enum.CovenantType.Necrolord;
local Venthyr = Enum.CovenantType.Venthyr;
local NightFae = Enum.CovenantType.NightFae;
local Kyrian = Enum.CovenantType.Kyrian;

local FR = {
	Charge          = 100,
	HeroicLeap      = 6544,
	Rampage         = 184367,
	Recklessness    = 1719,
	RecklessAbandon = 202751,
	AngerManagement = 152278,
	Massacre        = 206315,
	MeatCleaver     = 280392,
	Whirlwind       = 190411,
	RagingBlow      = 85288,
	Siegebreaker    = 280772,
	Enrage          = 184361,
	Frenzy          = 335077,
	Condemn         = 330334,
	Execute         = 5308,
	ExecuteMassacre = 280735,
	Bladestorm      = 46924,
	Bloodthirst     = 23881,
	ViciousContempt = 337302,
	Cruelty         = 335070,
	DragonRoar      = 118000,
	Onslaught       = 315720,
	SuddenDeathAura = 280776,

	-- leggo
	WillOfTheBerserkerBonusId = 6966,
	WillOfTheBerserker = 335597
};

setmetatable(FR, Warrior.spellMeta);

function Warrior:Fury()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local rage = UnitPower('player', PowerTypeRage);

	fd.rage = rage;
	fd.targets = targets;

	-- recklessness;
	MaxDps:GlowCooldown(FR.Recklessness, cooldown[FR.Recklessness].ready);

	if talents[FR.Bladestorm] then
		MaxDps:GlowCooldown(FR.Bladestorm, cooldown[FR.Bladestorm].ready);
	end

	-- rampage,if=cooldown.recklessness.remains<3&talent.reckless_abandon.enabled;
	if rage >= 80 and cooldown[FR.Recklessness].remains < 3 and talents[FR.RecklessAbandon] then
		return FR.Rampage;
	end

	-- recklessness,if=gcd.remains=0&((buff.bloodlust.up|talent.anger_management.enabled|raid_event.adds.in>10)|target.time_to_die>100|(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20|target.time_to_die<15&raid_event.adds.in>10)&(spell_targets.whirlwind=1|buff.meat_cleaver.up);
	--if cooldown[FR.Recklessness].ready and
	--	(gcdRemains == 0 and ((buff[FR.Bloodlust].up or talents[FR.AngerManagement] or 10) or timeToDie > 100 or (talents[FR.Massacre] and targetHp < 35) or targetHp < 20 or timeToDie < 15 and 10) and (targets == 1 or buff[FR.MeatCleaver].up)) then
	--	return FR.Recklessness;
	--end

	-- whirlwind,if=spell_targets.whirlwind>1&!buff.meat_cleaver.up|raid_event.adds.in<gcd&!buff.meat_cleaver.up;
	if targets > 1 and not buff[FR.MeatCleaver].up then
		return FR.Whirlwind;
	end

	-- run_action_list,name=single_target;
	return Warrior:FurySingleTarget();
end

function Warrior:FurySingleTarget()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local targets = fd.targets;
	local runeforge = fd.runeforge;
	local gcd = fd.gcd;
	local rage = fd.rage;
	local covenantId = fd.covenant.covenantId;
	local conduit = fd.covenant.soulbindConduits;

	local targetHp = MaxDps:TargetPercentHealth() * 100;
	local canExecute = (talents[FR.Massacre] and targetHp < 35) or
		targetHp < 20 or
		(targetHp > 80 and covenantId == Venthyr);
	local Execute = talents[FR.Massacre] and FR.ExecuteMassacre or FR.Execute;

	-- raging_blow,if=runeforge.will_of_the_berserker.equipped&buff.will_of_the_berserker.remains<gcd;
	if cooldown[FR.RagingBlow].ready and
		runeforge[FR.WillOfTheBerserkerBonusId] and
		buff[FR.WillOfTheBerserker].remains < 2
	then
		return FR.RagingBlow;
	end

	-- siegebreaker,if=spell_targets.whirlwind>1|raid_event.adds.in>15;
	if talents[FR.Siegebreaker] and cooldown[FR.Siegebreaker].ready then
		return FR.Siegebreaker;
	end

	-- rampage,if=buff.recklessness.up|(buff.enrage.remains<gcd|rage>90)|buff.frenzy.remains<1.5;
	if rage >= 80 and
		(
			buff[FR.Recklessness].up or
			(buff[FR.Enrage].remains < 1.5 or rage > 90) or
			buff[FR.Frenzy].remains < 1.5
		)
	then
		return FR.Rampage;
	end

	if covenantId == Venthyr then
		-- condemn;
		if buff[FR.SuddenDeathAura].up or cooldown[FR.Condemn].ready and canExecute and rage >= 20 then
			return FR.Condemn;
		end
	else
		-- execute;
		if buff[FR.SuddenDeathAura].up or cooldown[Execute].ready and canExecute and rage >= 20 then
			return Execute;
		end
	end

	-- bladestorm,if=buff.enrage.up&(spell_targets.whirlwind>1|raid_event.adds.in>45);
	--if cooldown[FR.Bladestorm].ready and (buff[FR.Enrage].up and (targets > 1 or 45)) then
	--	return FR.Bladestorm;
	--end

	-- bloodthirst,if=buff.enrage.down|conduit.vicious_contempt.rank>5&target.health.pct<35&!talent.cruelty.enabled;
	if cooldown[FR.Bloodthirst].ready and
		(
			not buff[FR.Enrage].up or
			conduit[FR.ViciousContempt] > 5 and targetHp < 35 and not talents[FR.Cruelty]
		)
	then
		return FR.Bloodthirst;
	end

	-- dragon_roar,if=buff.enrage.up&(spell_targets.whirlwind>1|raid_event.adds.in>15);
	if talents[FR.DragonRoar] and cooldown[FR.DragonRoar].ready and buff[FR.Enrage].up then
		return FR.DragonRoar;
	end

	-- onslaught;
	if talents[FR.Onslaught] and cooldown[FR.Onslaught].ready then
		return FR.Onslaught;
	end

	-- raging_blow,if=charges=2;
	if cooldown[FR.RagingBlow].charges >= 2 then
		return FR.RagingBlow;
	end

	-- bloodthirst;
	if cooldown[FR.Bloodthirst].ready then
		return FR.Bloodthirst;
	end

	-- raging_blow;
	if cooldown[FR.RagingBlow].ready then
		return FR.RagingBlow;
	end

	-- whirlwind;
	return FR.Whirlwind;
end