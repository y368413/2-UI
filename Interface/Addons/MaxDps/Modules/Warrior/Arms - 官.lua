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

local AR = {
	AncientAftershock = 325886,
	ConquerorsBanner  = 324143,
	SpearOfBastion    = 307865,
	Charge            = 100,
	SweepingStrikes   = 260708,
	Bladestorm        = 227847,
	Ravager           = 152277,
	Massacre          = 281001,
	DeadlyCalm        = 262228,
	Rend              = 772,
	Skullsplitter     = 260643,
	Avatar            = 107574,
	ColossusSmash     = 167105,
	ColossusSmashAura = 208086,
	Cleave            = 845,
	DeepWoundsAura    = 262115,
	Warbreaker        = 262161,
	Condemn           = 330334,
	SuddenDeath       = 29725,
	SuddenDeathAura   = 52437,
	Overpower         = 7384,
	MortalStrike      = 12294,
	Dreadnaught       = 262150,
	Whirlwind         = 1680,
	FervorOfBattle    = 202316,
	Slam              = 1464,
	BloodFury         = 20572,
	Execute           = 163201,
	ExecuteMassacre   = 281000
};

setmetatable(AR, Warrior.spellMeta);

function Warrior:Arms()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local talents = fd.talents;
	local buff = fd.buff;
	local targets = MaxDps:SmartAoe();
	local targetHp = MaxDps:TargetPercentHealth() * 100;
	local covenantId = fd.covenant.covenantId;
	local rage = UnitPower('player', PowerTypeRage);
	local inExecutePhase = (talents[AR.Massacre] and targetHp < 35) or
		targetHp < 20 or
		(targetHp > 80 and covenantId == Venthyr);

	fd.Execute = covenantId == Venthyr and AR.Condemn or
		(talents[AR.Massacre] and AR.ExecuteMassacre or AR.Execute);

	local canExecute = cooldown[fd.Execute].ready and rage >= 20 and inExecutePhase or
		buff[AR.SuddenDeathAura].up;

	fd.rage = rage;
	fd.targetHp = targetHp;
	fd.targets = targets;
	fd.canExecute = canExecute;

	if talents[AR.Avatar] then
		-- avatar,if=cooldown.colossus_smash.remains<8&gcd.remains=0;
		MaxDps:GlowCooldown(
			AR.Avatar,
			cooldown[AR.Avatar].ready and cooldown[AR.ColossusSmash].remains < 8
		);
	end

	if covenantId == NightFae then
		MaxDps:GlowCooldown(AR.AncientAftershock, cooldown[AR.AncientAftershock].ready);
	elseif covenantId == Necrolord then
		MaxDps:GlowCooldown(AR.ConquerorsBanner, cooldown[AR.ConquerorsBanner].ready);
	elseif covenantId == Kyrian then
		MaxDps:GlowCooldown(AR.SpearOfBastion, cooldown[AR.SpearOfBastion].ready);
	end

	-- sweeping_strikes,if=spell_targets.whirlwind>1&(cooldown.bladestorm.remains>15|talent.ravager.enabled);
	if cooldown[AR.SweepingStrikes].ready and
		targets > 1 and
		(cooldown[AR.Bladestorm].remains > 15 or talents[AR.Ravager])
	then
		return AR.SweepingStrikes;
	end

	-- run_action_list,name=hac,if=raid_event.adds.exists;
	if targets > 1 then
		return Warrior:ArmsHac();
	end

	-- run_action_list,name=execute,if=(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20|(target.health.pct>80&covenant.venthyr);
	if inExecutePhase then
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
	local canExecute = fd.canExecute;
	local rage = fd.rage;
	local covenantId = fd.covenant.covenantId;
	local Execute = fd.Execute;

	-- deadly_calm;
	if talents[AR.DeadlyCalm] and cooldown[AR.DeadlyCalm].ready then
		return AR.DeadlyCalm;
	end

	-- rend,if=remains<=duration*0.3;
	if talents[AR.Rend] and rage >= 30 and debuff[AR.Rend].refreshable then
		return AR.Rend;
	end

	-- skullsplitter,if=rage<60&(!talent.deadly_calm.enabled|buff.deadly_calm.down);
	if talents[AR.Skullsplitter] and
		cooldown[AR.Skullsplitter].ready and
		rage < 60 and
		(not talents[AR.DeadlyCalm] or not buff[AR.DeadlyCalm].up)
	then
		return AR.Skullsplitter;
	end

	-- avatar,if=cooldown.colossus_smash.remains<8&gcd.remains=0;
	--if talents[AR.Avatar] and cooldown[AR.Avatar].ready and cooldown[AR.ColossusSmash].remains < 8 then
	--	return AR.Avatar;
	--end

	-- ravager,if=buff.avatar.remains<18&!dot.ravager.remains;
	if talents[AR.Ravager] and
		cooldown[AR.Ravager].ready and
		buff[AR.Avatar].remains < 18
		--and
		--not debuff[AR.Ravager].up
	then
		return AR.Ravager;
	end

	-- cleave,if=spell_targets.whirlwind>1&dot.deep_wounds.remains<gcd;
	if talents[AR.Cleave] and
		cooldown[AR.Cleave].ready and
		rage >= 20 and
		targets > 1 and
		debuff[AR.DeepWoundsAura].remains < 2
	then
		return AR.Cleave;
	end

	-- warbreaker;
	if talents[AR.Warbreaker] then
		if cooldown[AR.Warbreaker].ready then
			return AR.Warbreaker;
		end
	else
		-- colossus_smash;
		if cooldown[AR.ColossusSmash].ready then
			return AR.ColossusSmash;
		end
	end

	-- condemn,if=debuff.colossus_smash.up|buff.sudden_death.react|rage>65;
	if canExecute and (debuff[AR.ColossusSmashAura].up or rage > 65) then
		return Execute;
	end

	-- overpower,if=charges=2;
	if cooldown[AR.Overpower].ready and cooldown[AR.Overpower].charges >= 2 then
		return AR.Overpower;
	end

	-- bladestorm,if=buff.deadly_calm.down&rage<50;
	if not talents[AR.Ravager] and cooldown[AR.Bladestorm].ready and not buff[AR.DeadlyCalm].up and rage < 50 then
		return AR.Bladestorm;
	end

	-- mortal_strike,if=dot.deep_wounds.remains<=gcd;
	if cooldown[AR.MortalStrike].ready and
		rage >= 30 and
		debuff[AR.DeepWoundsAura].remains <= 2
	then
		return AR.MortalStrike;
	end

	-- skullsplitter,if=rage<40;
	if talents[AR.Skullsplitter] and cooldown[AR.Skullsplitter].ready and rage < 40 then
		return AR.Skullsplitter;
	end

	-- overpower;
	if cooldown[AR.Overpower].ready then
		return AR.Overpower;
	end

	-- condemn;
	if canExecute then
		return Execute;
	end
end

function Warrior:ArmsHac()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local rage = fd.rage;
	local covenantId = fd.covenant.covenantId;
	local canExecute = fd.canExecute;
	local Execute = fd.Execute;

	-- skullsplitter,if=rage<60&buff.deadly_calm.down;
	if talents[AR.Skullsplitter] and
		cooldown[AR.Skullsplitter].ready and
		rage < 60 and
		not buff[AR.DeadlyCalm].up
	then
		return AR.Skullsplitter;
	end

	-- avatar,if=cooldown.colossus_smash.remains<1;
	--if talents[AR.Avatar] and cooldown[AR.Avatar].ready and (cooldown[AR.ColossusSmash].remains < 1) then
	--	return AR.Avatar;
	--end

	-- cleave,if=dot.deep_wounds.remains<=gcd;
	if talents[AR.Cleave] and
		cooldown[AR.Cleave].ready and
		rage >= 20 and
		debuff[AR.DeepWoundsAura].remains <= 2
	then
		return AR.Cleave;
	end

	-- warbreaker;
	if talents[AR.Warbreaker] and cooldown[AR.Warbreaker].ready then
		return AR.Warbreaker;
	end

	if talents[AR.Ravager] then
		-- ravager;
		if cooldown[AR.Ravager].ready then
			return AR.Ravager;
		end
	else
		-- bladestorm;
		if cooldown[AR.Bladestorm].ready then
			return AR.Bladestorm;
		end
	end

	-- colossus_smash;
	if not talents[AR.Warbreaker] and cooldown[AR.ColossusSmash].ready then
		return AR.ColossusSmash;
	end

	-- rend,if=remains<=duration*0.3&buff.sweeping_strikes.up;
	if talents[AR.Rend] and
		rage >= 30 and
		debuff[AR.Rend].refreshable and
		buff[AR.SweepingStrikes].up
	then
		return AR.Rend;
	end

	-- cleave;
	if talents[AR.Cleave] and cooldown[AR.Cleave].ready and rage >= 20 then
		return AR.Cleave;
	end

	-- mortal_strike,if=buff.sweeping_strikes.up|dot.deep_wounds.remains<gcd&!talent.cleave.enabled;
	if cooldown[AR.MortalStrike].ready and
		rage >= 30 and
		(
			buff[AR.SweepingStrikes].up or
			debuff[AR.DeepWoundsAura].remains < 2 and not talents[AR.Cleave]
		)
	then
		return AR.MortalStrike;
	end

	-- overpower,if=talent.dreadnaught.enabled;
	if cooldown[AR.Overpower].ready and talents[AR.Dreadnaught] then
		return AR.Overpower;
	end

	if covenantId == Venthyr then
		-- condemn;
		if canExecute then
			return AR.Condemn;
		end
	else
		-- execute,if=buff.sweeping_strikes.up;
		if canExecute then -- and buff[AR.SweepingStrikes].up
			return Execute;
		end
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

function Warrior:ArmsSingleTarget()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local gcd = fd.gcd;
	local canExecute = fd.canExecute;
	local Execute = fd.Execute;
	local covenantId = fd.covenant.covenantId;
	local rage = fd.rage;

	-- avatar,if=cooldown.colossus_smash.remains<8&gcd.remains=0;
	--if talents[AR.Avatar] and cooldown[AR.Avatar].ready and (cooldown[AR.ColossusSmash].remains < 8 and gcdRemains == 0) then
	--	return AR.Avatar;
	--end

	-- rend,if=remains<=duration*0.3;
	if talents[AR.Rend] and
		rage >= 30 and
		debuff[AR.Rend].refreshable
	then
		return AR.Rend;
	end

	-- cleave,if=spell_targets.whirlwind>1&dot.deep_wounds.remains<gcd;
	if talents[AR.Cleave] and
		cooldown[AR.Cleave].ready and
		rage >= 20 and
		targets > 1 and
		debuff[AR.DeepWoundsAura].remains < 2
	then
		return AR.Cleave;
	end

	-- warbreaker;
	if talents[AR.Warbreaker] then
		if cooldown[AR.Warbreaker].ready then
			return AR.Warbreaker;
		end
	else
		-- colossus_smash;
		if cooldown[AR.ColossusSmash].ready then
			return AR.ColossusSmash;
		end
	end

	-- ravager,if=buff.avatar.remains<18&!dot.ravager.remains;
	if talents[AR.Ravager] and cooldown[AR.Ravager].ready and buff[AR.Avatar].remains < 18 then
		return AR.Ravager;
	end

	-- overpower,if=charges=2;
	if cooldown[AR.Overpower].charges >= 2 then
		return AR.Overpower;
	end

	-- bladestorm,if=buff.deadly_calm.down&(debuff.colossus_smash.up&rage<30|rage<70);
	if not talents[AR.Ravager] and
		cooldown[AR.Bladestorm].ready and
		not buff[AR.DeadlyCalm].up and
		(debuff[AR.ColossusSmashAura].up and rage < 30 or rage < 70)
	then
		return AR.Bladestorm;
	end

	-- mortal_strike,if=buff.overpower.stack>=2&buff.deadly_calm.down|(dot.deep_wounds.remains<=gcd&cooldown.colossus_smash.remains>gcd);
	if cooldown[AR.MortalStrike].ready and
		rage >= 30 and
		(
			buff[AR.Overpower].count >= 2 and not buff[AR.DeadlyCalm].up or
			(debuff[AR.DeepWoundsAura].remains <= 2 and cooldown[AR.ColossusSmash].remains > gcd)
		)
	then
		return AR.MortalStrike;
	end

	-- deadly_calm;
	if talents[AR.DeadlyCalm] and cooldown[AR.DeadlyCalm].ready then
		return AR.DeadlyCalm;
	end

	-- skullsplitter,if=rage<60&buff.deadly_calm.down;
	if talents[AR.Skullsplitter] and
		cooldown[AR.Skullsplitter].ready and
		rage < 60 and
		not buff[AR.DeadlyCalm].up
	then
		return AR.Skullsplitter;
	end

	-- overpower;
	if cooldown[AR.Overpower].ready then
		return AR.Overpower;
	end


	if buff[AR.SuddenDeathAura].up then
		-- condemn,if=buff.sudden_death.react;
		-- execute,if=buff.sudden_death.react;
		return Execute;
	end

	-- mortal_strike;
	if cooldown[AR.MortalStrike].ready and rage >= 30 then
		return AR.MortalStrike;
	end

	-- whirlwind,if=talent.fervor_of_battle.enabled&rage>60;
	if rage >= 30 and talents[AR.FervorOfBattle] and rage > 60 then
		return AR.Whirlwind;
	end

	-- slam;
	if rage >= 20 then
		return AR.Slam;
	end
end