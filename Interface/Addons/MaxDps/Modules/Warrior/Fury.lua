if select(2, UnitClass("player")) ~= "WARRIOR" then return end

local _, MaxDps_WarriorTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Warrior = MaxDps_WarriorTable.Warrior;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local PowerTypeRage = Enum.PowerType.Rage;

local FR = {
	Recklessness      = 1719,
	FuriousSlash      = 100130,
	FuriousSlashAura  = 202539,
	RecklessAbandon   = 202751,
	Charge            = 100,
	HeroicLeap        = 6544,
	Rampage           = 184367,
	Whirlwind         = 190411,
	WhirlwindAura     = 85739,
	MeatCleaver       = 280392,
	Siegebreaker      = 280772,
	SiegebreakerAura  = 280773,
	FrothingBerserker = 215571,
	Carnage           = 202922,
	Enrage            = 184362,
	Massacre          = 206315,
	Execute           = 5308,
	ExecuteMassacre   = 280735,
	Bloodthirst       = 23881,
	RagingBlow        = 85288,
	Bladestorm        = 46924,
	DragonRoar        = 118000,
	SuddenDeathAura   = 280776,
};

local A = {
	ColdSteelHotBlood = 288080,
};

setmetatable(FR, Warrior.spellMeta);
setmetatable(A, Warrior.spellMeta);


function Warrior:Fury()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local debuff = fd.debuff;
	local spellHistory = fd.spellHistory;
	local rage = UnitPower('player', PowerTypeRage);

	local rampageCost = 85;
	if talents[FR.Carnage] then
		rampageCost = 75;
	elseif talents[FR.FrothingBerserker] then
		rampageCost = 95;
	end

	fd.rage = rage;
	fd.rampageCost = rampageCost;

	MaxDps:GlowEssences();

	-- recklessness;
	MaxDps:GlowCooldown(FR.Recklessness, cooldown[FR.Recklessness].ready);

	if talents[FR.Bladestorm] then
		-- bladestorm,if=prev_gcd.1.rampage&(debuff.siegebreaker.up|!talent.siegebreaker.enabled);
		MaxDps:GlowCooldown(
			FR.Bladestorm,
			cooldown[FR.Bladestorm].ready and (
				spellHistory[1] == FR.Rampage and (debuff[FR.SiegebreakerAura].up or not talents[FR.Siegebreaker])
			)
		);
	end

	-- furious_slash,if=talent.furious_slash.enabled&(buff.furious_slash.stack<3|buff.furious_slash.remains<3|(cooldown.recklessness.remains<3&buff.furious_slash.remains<9));
	if talents[FR.FuriousSlash] and (
		buff[FR.FuriousSlashAura].count < 3 or
		buff[FR.FuriousSlashAura].remains < 3 or
		(cooldown[FR.Recklessness].remains < 3 and buff[FR.FuriousSlashAura].remains < 9)
	) then
		return FR.FuriousSlash;
	end

	-- rampage,if=cooldown.recklessness.remains<3;
	if rage >= rampageCost and cooldown[FR.Recklessness].remains < 3 and not (talents[FR.Siegebreaker] and cooldown[FR.Siegebreaker].ready) then
		return FR.Rampage;
	end

	-- whirlwind,if=spell_targets.whirlwind>1&!buff.meat_cleaver.up;
	if targets > 1 and not buff[FR.WhirlwindAura].up then
		return FR.Whirlwind;
	end

	-- run_action_list,name=single_target;
	return Warrior:FurySingleTarget();
end

function Warrior:FurySingleTarget()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local gcd = fd.gcd;
	local rage = fd.rage;
	local rampageCost = fd.rampageCost;

	local tgtPctHp = MaxDps:TargetPercentHealth();
	local canExecute = tgtPctHp < (talents[FR.Massacre] and 0.35 or 0.2);
	local Execute = talents[FR.Massacre] and FR.ExecuteMassacre or FR.Execute;

	-- siegebreaker;
	if talents[FR.Siegebreaker] and cooldown[FR.Siegebreaker].ready then
		return FR.Siegebreaker;
	end

	-- rampage,if=buff.recklessness.up|(talent.frothing_berserker.enabled|talent.carnage.enabled&(buff.enrage.remains<gcd|rage>90)|talent.massacre.enabled&(buff.enrage.remains<gcd|rage>90));
	if rage >= rampageCost and (
		buff[FR.Recklessness].up or (
			talents[FR.FrothingBerserker] or
			talents[FR.Carnage] and (buff[FR.Enrage].remains < gcd or rage > 90) or
			talents[FR.Massacre] and (buff[FR.Enrage].remains < gcd or rage > 90)
		)
	) and not (talents[FR.Siegebreaker] and cooldown[FR.Siegebreaker].ready) then
		return FR.Rampage;
	end

	-- execute;
	if buff[FR.SuddenDeathAura].up or cooldown[FR.Execute].ready and canExecute then
		return Execute;
	end

	-- bloodthirst,if=buff.enrage.down|azerite.cold_steel_hot_blood.rank>1;
	if cooldown[FR.Bloodthirst].ready and (not buff[FR.Enrage].up or azerite[A.ColdSteelHotBlood] > 1) then
		return FR.Bloodthirst;
	end

	-- raging_blow,if=charges=2;
	if cooldown[FR.RagingBlow].charges >= 2 then
		return FR.RagingBlow;
	end

	-- bloodthirst;
	if cooldown[FR.Bloodthirst].ready then
		return FR.Bloodthirst;
	end

	-- dragon_roar,if=buff.enrage.up;
	if talents[FR.DragonRoar] and cooldown[FR.DragonRoar].ready and buff[FR.Enrage].up then
		return FR.DragonRoar;
	end

	-- raging_blow,if=talent.carnage.enabled|(talent.massacre.enabled&rage<80)|(talent.frothing_berserker.enabled&rage<90);
	if cooldown[FR.RagingBlow].ready and (
		talents[FR.Carnage] or (talents[FR.Massacre] and rage < 80) or (talents[FR.FrothingBerserker] and rage < 90)
	) then
		return FR.RagingBlow;
	end

	-- furious_slash,if=talent.furious_slash.enabled;
	if talents[FR.FuriousSlash] then
		return FR.FuriousSlash;
	end

	-- whirlwind;
	return FR.Whirlwind;
end