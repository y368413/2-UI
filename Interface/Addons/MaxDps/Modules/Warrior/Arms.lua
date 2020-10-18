if select(2, UnitClass("player")) ~= "WARRIOR" then return end

local _, MaxDps_WarriorTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Warrior = MaxDps_WarriorTable.Warrior;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local PowerTypeRage = Enum.PowerType.Rage;

-- Arms
local AR = {
	Charge            = 100,
	Avatar            = 107574,
	ColossusSmash     = 167105,
	ColossusSmashAura = 208086,
	Warbreaker        = 262161,
	SweepingStrikes   = 260708,
	Bladestorm        = 227847,
	Massacre          = 281001,
	Skullsplitter     = 260643,
	DeadlyCalm        = 262228,
	Ravager           = 152277,
	Cleave            = 845,
	Slam              = 1464,
	MortalStrike      = 12294,
	Overpower         = 7384,
	Dreadnaught       = 262150,
	Execute           = 163201,
	ExecuteMassacre   = 281000,
	DeepWounds        = 262304,
	SuddenDeath       = 29725,
	SuddenDeathAura   = 52437,
	Whirlwind         = 1680,
	FervorOfBattle    = 202316,
	Rend              = 772,
	AngerManagement   = 152278,
	CrushingAssault   = 278826,
};

local A = {
	ExecutionersPrecision = 272866,
	TestOfMight           = 275529,
	SeismicWave           = 277639,
	CrushingAssault       = 278751,
}

setmetatable(AR, Warrior.spellMeta);
setmetatable(A, Warrior.spellMeta);


function Warrior:Arms()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local talents = fd.talents;
	local buff = fd.buff;
	local targets = MaxDps:SmartAoe();
	local targetHp = MaxDps:TargetPercentHealth() * 100;
	local canExecute = targetHp < (talents[AR.Massacre] and 35 or 20);
	local rage = UnitPower('player', PowerTypeRage);

	fd.targets, fd.canExecute, fd.rage = targets, canExecute, rage;

	MaxDps:GlowEssences();

	if talents[AR.DeadlyCalm] then
		MaxDps:GlowCooldown(AR.DeadlyCalm, cooldown[AR.DeadlyCalm].ready);
	end

	if talents[AR.Ravager] then
		-- ravager,if=!buff.deadly_calm.up&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2));
		-- ravager,if=(!talent.warbreaker.enabled|cooldown.warbreaker.remains<2);
		MaxDps:GlowCooldown(
			AR.Ravager,
			cooldown[AR.Ravager].ready and (
				not buff[AR.DeadlyCalm].up and
				(
					cooldown[AR.ColossusSmash].remains < 2 or
					(talents[AR.Warbreaker] and cooldown[AR.Warbreaker].remains < 2)
				)
			)
		);
	else
		MaxDps:GlowCooldown(AR.Bladestorm, cooldown[AR.Bladestorm].ready and not buff[AR.DeadlyCalm].up);
	end

	if talents[AR.Avatar] then
		--avatar,if=cooldown.colossus_smash.remains<8|(talent.warbreaker.enabled&cooldown.warbreaker.remains<8);
		MaxDps:GlowCooldown(
			AR.Avatar,
			cooldown[AR.Avatar].ready and
			(cooldown[AR.ColossusSmash].remains < 8 or (talents[AR.Warbreaker] and cooldown[AR.Warbreaker].remains < 8))
		);
	end

	-- sweeping_strikes,if=spell_targets.whirlwind>1&(cooldown.bladestorm.remains>10|cooldown.colossus_smash.remains>8|azerite.test_of_might.enabled);
	if cooldown[AR.SweepingStrikes].ready and (targets > 1 and (
		cooldown[AR.Bladestorm].remains > 10 or cooldown[AR.ColossusSmash].remains > 8 or azerite[A.TestOfMight] > 0
	)) then
		return AR.SweepingStrikes;
	end

	-- run_action_list,name=hac,if=raid_event.adds.exists;
	--if targets > 1 then
	--	return Warrior:ArmsHac();
	--end

	-- run_action_list,name=five_target,if=spell_targets.whirlwind>4;
	if targets > 4 then
		return Warrior:ArmsFiveTarget();
	end

	-- run_action_list,name=execute,if=(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20;
	if canExecute then
		return Warrior:ArmsExecute();
	end

	-- run_action_list,name=single_target;
	return Warrior:ArmsSingleTarget();
end

function Warrior:ArmsExecute()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local rage = fd.rage;

	local execute = talents[AR.Massacre] and AR.ExecuteMassacre or AR.Execute;

	-- skullsplitter,if=rage<60&(!talent.deadly_calm.enabled|buff.deadly_calm.down);
	if talents[AR.Skullsplitter] and cooldown[AR.Skullsplitter].ready and (
		rage < 60 and (not talents[AR.DeadlyCalm] or not buff[AR.DeadlyCalm].up)
	) then
		return AR.Skullsplitter;
	end

	-- colossus_smash,if=debuff.colossus_smash.down;
	if not talents[AR.Warbreaker] and cooldown[AR.ColossusSmash].ready and not debuff[AR.ColossusSmashAura].up then
		return AR.ColossusSmash;
	end

	-- warbreaker,if=debuff.colossus_smash.down;
	if talents[AR.Warbreaker] and cooldown[AR.Warbreaker].ready and not debuff[AR.ColossusSmashAura].up then
		return AR.Warbreaker;
	end

	-- deadly_calm;
	if talents[AR.DeadlyCalm] and cooldown[AR.DeadlyCalm].ready then
		return AR.DeadlyCalm;
	end

	-- cleave,if=spell_targets.whirlwind>2;
	if talents[AR.Cleave] and cooldown[AR.Cleave].ready and rage >= 20 and targets > 2 then
		return AR.Cleave;
	end

	-- slam,if=buff.crushing_assault.up;
	if rage >= 20 and buff[AR.CrushingAssault].up then
		return AR.Slam;
	end

	-- mortal_strike,if=buff.overpower.stack=2&talent.dreadnaught.enabled|buff.executioners_precision.stack=2;
	if cooldown[AR.MortalStrike].ready and rage >= 30 and (
		buff[AR.Overpower].count == 2 and talents[AR.Dreadnaught] or buff[A.ExecutionersPrecision].count == 2
	) then
		return AR.MortalStrike;
	end

	-- execute,if=buff.deadly_calm.up;
	if rage >= 20 and buff[AR.DeadlyCalm].up then
		return execute;
	end

	-- overpower;
	if cooldown[AR.Overpower].ready then
		return AR.Overpower;
	end

	-- execute;
	if rage >= 20 then
		return execute;
	end
end

function Warrior:ArmsFiveTarget()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local canExecute = fd.canExecute;
	local rage = fd.rage;
	local execute = talents[AR.Massacre] and AR.ExecuteMassacre or AR.Execute;

	-- skullsplitter,if=rage<60&(!talent.deadly_calm.enabled|buff.deadly_calm.down);
	if talents[AR.Skullsplitter] and cooldown[AR.Skullsplitter].ready and (
		rage < 60 and (not talents[AR.DeadlyCalm] or not buff[AR.DeadlyCalm].up)
	) then
		return AR.Skullsplitter;
	end

	-- colossus_smash,if=debuff.colossus_smash.down;
	if not talents[AR.Warbreaker] and cooldown[AR.ColossusSmash].ready and not debuff[AR.ColossusSmashAura].up then
		return AR.ColossusSmash;
	end

	-- warbreaker,if=debuff.colossus_smash.down;
	if talents[AR.Warbreaker] and cooldown[AR.Warbreaker].ready and not debuff[AR.ColossusSmashAura].up then
		return AR.Warbreaker;
	end

	-- deadly_calm;
	if talents[AR.DeadlyCalm] and cooldown[AR.DeadlyCalm].ready then
		return AR.DeadlyCalm;
	end

	-- cleave;
	if talents[AR.Cleave] and cooldown[AR.Cleave].ready and rage >= 20 then
		return AR.Cleave;
	end

	-- execute,if=(!talent.cleave.enabled&dot.deep_wounds.remains<2)|(buff.sudden_death.react|buff.stone_heart.react)&(buff.sweeping_strikes.up|cooldown.sweeping_strikes.remains>8);
	if (not talents[AR.Cleave] and debuff[AR.DeepWounds].remains < 2 and canExecute) or
		(buff[AR.SuddenDeathAura].up) and
		(buff[AR.SweepingStrikes].up or cooldown[AR.SweepingStrikes].remains > 8)
	then
		return execute;
	end

	-- mortal_strike,if=(!talent.cleave.enabled&dot.deep_wounds.remains<2)|buff.sweeping_strikes.up&buff.overpower.stack=2&(talent.dreadnaught.enabled|buff.executioners_precision.stack=2);
	if cooldown[AR.MortalStrike].ready and rage >= 30 and (
		(not talents[AR.Cleave] and debuff[AR.DeepWounds].remains < 2) or
		buff[AR.SweepingStrikes].up and buff[AR.Overpower].count == 2 and
		(talents[AR.Dreadnaught] or buff[AR.ExecutionersPrecision].count == 2)
	) then
		return AR.MortalStrike;
	end

	-- whirlwind,if=debuff.colossus_smash.up|(buff.crushing_assault.up&talent.fervor_of_battle.enabled);
	if rage >= 30 and (
		debuff[AR.ColossusSmashAura].up or (buff[AR.CrushingAssault].up and talents[AR.FervorOfBattle])
	) then
		return AR.Whirlwind;
	end

	-- whirlwind,if=buff.deadly_calm.up|rage>60;
	if rage >= 30 and (
		buff[AR.DeadlyCalm].up or rage > 60
	) then
		return AR.Whirlwind;
	end

	-- overpower;
	if cooldown[AR.Overpower].ready then
		return AR.Overpower;
	end

	-- whirlwind;
	if rage >= 30 then
		return AR.Whirlwind;
	end
end
--[[
function Warrior:ArmsHac()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local rage = UnitPower('player', Enum.PowerType.Rage);

	-- rend,if=remains<=duration*0.3&(!raid_event.adds.up|buff.sweeping_strikes.up);
	if talents[AR.Rend] and rage >= 30 and (debuff[AR.AR.Rend].remains <= cooldown[AR.AR.Rend].duration * 0.3 and ( not buff[AR.SweepingStrikes].up )) then
		return AR.Rend;
	end

	-- skullsplitter,if=rage<60&(cooldown.deadly_calm.remains>3|!talent.deadly_calm.enabled);
	if cooldown[AR.Skullsplitter].ready and (rage < 60 and ( cooldown[AR.DeadlyCalm].remains > 3 or not talents[AR.DeadlyCalm] )) then
		return AR.Skullsplitter;
	end

	-- deadly_calm,if=(cooldown.bladestorm.remains>6|talent.ravager.enabled&cooldown.ravager.remains>6)&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2));
	if talents[AR.DeadlyCalm] and cooldown[AR.DeadlyCalm].ready and (( cooldown[AR.Bladestorm].remains > 6 or talents[AR.Ravager] and cooldown[AR.Ravager].remains > 6 ) and ( cooldown[AR.ColossusSmash].remains < 2 or ( talents[AR.Warbreaker] and cooldown[AR.Warbreaker].remains < 2 ) )) then
		return AR.DeadlyCalm;
	end

	-- ravager,if=(raid_event.adds.up|raid_event.adds.in>target.time_to_die)&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2));
	if talents[AR.Ravager] and cooldown[AR.Ravager].ready and (( timeToDie ) and ( cooldown[AR.ColossusSmash].remains < 2 or ( talents[AR.Warbreaker] and cooldown[AR.Warbreaker].remains < 2 ) )) then
		return AR.Ravager;
	end

	-- colossus_smash,if=raid_event.adds.up|raid_event.adds.in>40|(raid_event.adds.in>20&talent.anger_management.enabled);
	if cooldown[AR.ColossusSmash].ready and (40 or ( 20 and talents[AR.AngerManagement] )) then
		return AR.ColossusSmash;
	end

	-- warbreaker,if=raid_event.adds.up|raid_event.adds.in>40|(raid_event.adds.in>20&talent.anger_management.enabled);
	if talents[AR.Warbreaker] and cooldown[AR.Warbreaker].ready and (40 or ( 20 and talents[AR.AngerManagement] )) then
		return AR.Warbreaker;
	end

	-- bladestorm,if=(debuff.colossus_smash.up&raid_event.adds.in>target.time_to_die)|raid_event.adds.up&((debuff.colossus_smash.remains>4.5&!azerite.test_of_might.enabled)|buff.test_of_might.up);
	if cooldown[AR.Bladestorm].ready and (( debuff[AR.ColossusSmashAura].up and timeToDie ) or ( ( debuff[AR.ColossusSmashAura].remains > 4.5 and not azerite[AR.TestOfMight] > 0 ) or buff[AR.TestOfMight].up )) then
		return AR.Bladestorm;
	end

	-- overpower,if=!raid_event.adds.up|(raid_event.adds.up&azerite.seismic_wave.enabled);
	if cooldown[AR.Overpower].ready and (not ( azerite[AR.SeismicWave] > 0 )) then
		return AR.Overpower;
	end

	-- cleave,if=spell_targets.whirlwind>2;
	if talents[AR.Cleave] and cooldown[AR.Cleave].ready and rage >= 20 and (targets > 2) then
		return AR.Cleave;
	end

	-- execute,if=!raid_event.adds.up|(!talent.cleave.enabled&dot.deep_wounds.remains<2)|buff.sudden_death.react;
	if rage >= 20 and (not ( not talents[AR.Cleave] and debuff[AR.DeepWounds].remains < 2 ) or buff[AR.SuddenDeath].count) then
		return AR.Execute;
	end

	-- mortal_strike,if=!raid_event.adds.up|(!talent.cleave.enabled&dot.deep_wounds.remains<2);
	if cooldown[AR.MortalStrike].ready and rage >= 30 and (not ( not talents[AR.Cleave] and debuff[AR.DeepWounds].remains < 2 )) then
		return AR.MortalStrike;
	end

	-- whirlwind,if=raid_event.adds.up;
	if rage >= 30 and () then
		return AR.Whirlwind;
	end

	-- overpower;
	if cooldown[AR.Overpower].ready then
		return AR.Overpower;
	end

	-- whirlwind,if=talent.fervor_of_battle.enabled;
	if rage >= 30 and (talents[AR.FervorOfBattle]) then
		return AR.Whirlwind;
	end

	-- slam,if=!talent.fervor_of_battle.enabled&!raid_event.adds.up;
	if rage >= 20 and (not talents[AR.FervorOfBattle] and not) then
		return AR.Slam;
	end
end
]]--
function Warrior:ArmsSingleTarget()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local gcd = fd.gcd;
	local talents = fd.talents;
	local targets = fd.targets;
	local canExecute = fd.canExecute;
	local rage = fd.rage;
	local execute = talents[AR.Massacre] and AR.ExecuteMassacre or AR.Execute;

	-- rend,if=remains<=duration*0.3&debuff.colossus_smash.down;
	if talents[AR.Rend] and rage >= 30 and (
		debuff[AR.Rend].remains <= 12 * 0.3 and not debuff[AR.ColossusSmashAura].up
	) then
		return AR.Rend;
	end

	-- skullsplitter,if=rage<60&(!talent.deadly_calm.enabled|buff.deadly_calm.down);
	if talents[AR.Skullsplitter] and cooldown[AR.Skullsplitter].ready and (
		rage < 60 and
		(not talents[AR.DeadlyCalm] or not buff[AR.DeadlyCalm].up)
	) then
		return AR.Skullsplitter;
	end

	-- colossus_smash,if=debuff.colossus_smash.down;
	if not talents[AR.Warbreaker] and cooldown[AR.ColossusSmash].remains < 0.3 and not debuff[AR.ColossusSmashAura].up
	then
		return AR.ColossusSmash;
	end

	-- warbreaker,if=debuff.colossus_smash.down;
	if talents[AR.Warbreaker] and cooldown[AR.Warbreaker].remains < 0.3 and not debuff[AR.ColossusSmashAura].up then
		return AR.Warbreaker;
	end

	-- deadly_calm;
	if talents[AR.DeadlyCalm] and cooldown[AR.DeadlyCalm].ready then
		return AR.DeadlyCalm;
	end

	-- execute,if=buff.sudden_death.react;
	if buff[AR.SuddenDeathAura].up then
		return execute;
	end

	-- cleave,if=spell_targets.whirlwind>2;
	if talents[AR.Cleave] and cooldown[AR.Cleave].ready and rage >= 20 and targets > 2 then
		return AR.Cleave;
	end

	-- overpower,if=azerite.seismic_wave.rank=3;
	if cooldown[AR.Overpower].ready and azerite[A.SeismicWave] == 3 then
		return AR.Overpower;
	end

	-- mortal_strike;
	if cooldown[AR.MortalStrike].remains < 0.2 then
		return AR.MortalStrike;
	end

	-- whirlwind,if=talent.fervor_of_battle.enabled&(buff.deadly_calm.up|rage>=60);
	if rage >= 60 and (talents[AR.FervorOfBattle] and (buff[AR.DeadlyCalm].up or rage >= 60)) then
		return AR.Whirlwind;
	end

	-- overpower;
	if cooldown[AR.Overpower].ready then
		return AR.Overpower;
	end

	-- whirlwind,if=talent.fervor_of_battle.enabled&(!azerite.test_of_might.enabled|debuff.colossus_smash.up);
	if rage >= 60 and cooldown[AR.MortalStrike].remains > gcd and (
		talents[AR.FervorOfBattle] and
		(not azerite[A.TestOfMight] > 0 or debuff[AR.ColossusSmashAura].up)
	) then
		return AR.Whirlwind;
	end

	-- slam,if=!talent.fervor_of_battle.enabled&(!azerite.test_of_might.enabled|debuff.colossus_smash.up|buff.deadly_calm.up|rage>=60);
	if rage >= 50 and cooldown[AR.MortalStrike].remains > gcd and (
		not talents[AR.FervorOfBattle] and
		(azerite[A.TestOfMight] < 1 or debuff[AR.ColossusSmashAura].up or buff[AR.DeadlyCalm].up or rage >= 60)
	) then
		return AR.Slam;
	end
end
