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
local debug = false

function debugPrint(message, data)
	if (debug) then
		if data ~= nil then
			print(message, data)
		else
			print(message)
		end
	end
end

local AR = {
	AncientAftershock = 325886,
	Avatar            = 107574,
	BloodFury         = 20572,
	Bladestorm        = 227847,
	Charge            = 100,
	Cleave            = 845,
	ColossusSmash     = 167105,
	ColossusSmashAura = 208086,
	ConquerorsBanner  = 324143,
	Condemn           = 330334,
	DeadlyCalm        = 262228,
	DeepWoundsAura    = 262115,
	Dreadnaught       = 262150,
	FervorOfBattle    = 202316,
	Massacre          = 281001,
	MortalStrike      = 12294,
	Overpower         = 7384,
	Ravager           = 152277,
	Rend              = 772,
	Skullsplitter     = 260643,
	Slam              = 1464,
	SpearOfBastion    = 307865,
	SuddenDeath       = 29725,
	SuddenDeathAura   = 52437,
	SweepingStrikes   = 260708,
	Warbreaker        = 262161,
	Whirlwind         = 1680,
};

setmetatable(AR, Warrior.spellMeta);

function Warrior:SingleTarget()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local talents = fd.talents;
	local debuff = fd.debuff;
	local spellChosen = false
	local chosenSpell = nil
	local secondsRemainingOnDeepWoundsForRefreshPriority = 4
	local secondsRemainingOnRendForRefreshPriority = 4
	local colossusSmashReadyInTheNextEightSeconds = false
	local colossusSmashReadyNow = false
	local deepWoundsNeedsRefresh = false
	local rendNeedsRefresh = false

	if talents[AR.Warbreaker] then
		colossusSmashReadyNow = cooldown[AR.Warbreaker].remains == 0
		colossusSmashReadyInTheNextEightSeconds = cooldown[AR.Warbreaker].remains < 8
	else
		colossusSmashReadyNow = cooldown[AR.ColossusSmash].remains == 0
		colossusSmashReadyInTheNextEightSeconds = cooldown[AR.ColossusSmash].remains < 8
	end
	
	if debuff[AR.DeepWoundsAura].remains < secondsRemainingOnDeepWoundsForRefreshPriority then
		deepWoundsNeedsRefresh = true
	end

	if talents[AR.Rend] and debuff[AR.Rend].remains < secondsRemainingOnRendForRefreshPriority then
		rendNeedsRefresh = true
	end

	debugPrint(" ")
	debugPrint("--- Running single target arms rotation ---");

	-- Priority #-1: Casting Conqueror's Banner if you're a necrolord
	if covenantId == Necrolord then
		if cooldown[AR.ConquerorsBanner].ready then
			debugPrint("* CHOOSING PRIORITY #-1 (CONQUERORS BANNER)")
			MaxDps:GlowCooldown(
				AR.ConquerorsBanner,
				cooldown[AR.ConquerorsBanner].ready
			);
		else
			debugPrint("SKIPPING PRIORITY #-1 (CONQUERORS BANNER)")
		end
	end

	-- Priority #0: Casting avatar (if talented) in conjunction with colossus smash debuff
	if talents[AR.Avatar] == 1 and
	   cooldown[AR.Avatar].ready and
	   colossusSmashReadyInTheNextEightSeconds then
		MaxDps:GlowCooldown(
			AR.Avatar,
			cooldown[AR.Avatar].ready and
			colossusSmashReadyInTheNextEightSeconds
		);
		debugPrint("* CHOOSING PRIORITY #0 (AVATAR)")
	else
		debugPrint("SKIPPING PRIORITY #0 (AVATAR)")
	end

	-- Priority 0a: Casting Ravager (if talented)
	if talents[AR.Ravager] == 1 then
		if cooldown[AR.Ravager].ready then
		   chosenSpell = AR.Ravager
		   spellChosen = true
			debugPrint("* CHOOSING PRIORITY #0a (RAVAGAR)")
		else
			debugPrint("SKIPPING PRIORITY #0a (RAVAGAR)")
		end
	end

	-- Priority #1: Casting colossus smash or warbreaker (if talented)
	if colossusSmashReadyNow and spellChosen == false then
		debugPrint("* CHOOSING PRIORITY #1 (WARBREAKER/COLOSSUS SMASH)")
		spellChosen = true
		if talents[AR.Warbreaker] then
			chosenSpell = AR.Warbreaker
		else
			chosenSpell = AR.ColossusSmash
		end
	else
		debugPrint("SKIPPING PRIORITY #1 (WARBREAKER/COLOSSUS SMASH)")
	end

	-- Priority #1a (optional depends on if talented): Rend refresh
	if talents[AR.Rend] then
		if spellChosen == false and rendNeedsRefresh and fd.executePhase == false then
			debugPrint("* CHOOSING PRIORITY #1a (REND REFRESH)")
			spellChosen = true
			chosenSpell = AR.Rend
		else
			debugPrint("SKIPPING PRIORITY #1a (REND REFRESH)")
		end
	end

	-- Priority #1b (optional depends on if talented): cast Skullsplitter when <60 rage, and bladestorm isn't gonna be used soon
	if talents[AR.Skullsplitter] then
		if spellChosen == false and cooldown[AR.Skullsplitter].ready and fd.rage < 60 and cooldown[AR.Bladestorm].ready == false then
			debugPrint("* CHOOSING PRIORITY #1b (skullsplitter if talented, and low rage and not using bladestorm soon)")
			spellChosen = true
			chosenSpell = AR.Skullsplitter
		else
			debugPrint("SKIPPING PRIORITY #1b (skullsplitter if talented, and low rage and not using bladestorm soon)")
		end
	end

	-- Priority #2: Mortal Strike for Deep Wounds Refresh
	if spellChosen == false and deepWoundsNeedsRefresh and cooldown[AR.MortalStrike].ready then
		debugPrint("* CHOOSING PRIORITY #2 (MORTAL STRIKE FOR DEEP WOUNDS REFRESH)")
		spellChosen = true
		chosenSpell = AR.MortalStrike
	else
		debugPrint("SKIPPING PRIORITY #2 (MORTAL STRIKE FOR DEEP WOUNDS REFRESH)")
	end

	-- Priority #2a: Deadly Calm if it's up
	if talents[AR.DeadlyCalm] then
		if spellChosen == false and cooldown[AR.DeadlyCalm].ready then
			debugPrint("* CHOOSING PRIORITY #2a (DEADLY CALM)")
			spellChosen = true
			chosenSpell = AR.DeadlyCalm
		else
			debugPrint("SKIPPING PRIORITY #2a (DEADLY CALM)")
		end
	end

	-- Priority #3: Overpower
	if spellChosen == false and cooldown[AR.Overpower].ready then
		debugPrint("* CHOOSING PRIORITY #3 (OVERPOWER)")
		spellChosen = true
		chosenSpell = AR.Overpower
	else
		debugPrint("SKIPPING PRIORITY #3 (OVERPOWER)")
	end

	-- Priority #4: Execute/Condemn
	if spellChosen == false and fd.canExecute then
		debugPrint("* CHOOSING PRIORITY #4 (CONDEMN/EXECUTE)")
		spellChosen = true
		if fd.covenantId == Venthyr then
			chosenSpell = AR.Condemn
		else
			chosenSpell = AR.Execute
		end
	else
		debugPrint("SKIPPING PRIORITY #4 (CONDEMN/EXECUTE)")
	end

	-- Priority #4a: Casting Spear of Bastion if you're a kyrian
	if covenantId == Kyrian and fd.executePhase == false then
		if cooldown[AR.SpearOfBastion].ready then
			debugPrint("* CHOOSING PRIORITY #4a (SPEAR OF BASTION)")
			chosenSpell = AR.SpearOfBastion
			spellChosen = true
		else
			debugPrint("SKIPPING PRIORITY #4a (SPEAR OF BASTION)")
		end
	end

	-- Priority #4b: Casting Ancient Aftershock if you're a night fae
	if covenantId == NightFae and fd.executePhase == false then
		if cooldown[AR.AncientAftershock].ready then
			debugPrint("* CHOOSING PRIORITY #4b (ANCIENT AFTERSHOCK)")
			chosenSpell = AR.AncientAftershock
			spellChosen = true
		else
			debugPrint("SKIPPING PRIORITY #4b (ANCIENT AFTERSHOCK)")
		end
	end

	-- Priority #5: Mortal Strike Generic
	if spellChosen == false and cooldown[AR.MortalStrike].ready and fd.rage > 30 and fd.executePhase == false then
		debugPrint("* CHOOSING PRIORITY #5 (MORTAL STRIKE GENERIC)")
		spellChosen = true
		chosenSpell = AR.MortalStrike
	else
		debugPrint("SKIPPING PRIORITY #5 (MORTAL STRIKE GENERIC)")
	end

	-- Priority #6: Bladestorm during colossus smash
	if spellChosen == false and debuff[AR.ColossusSmashAura].remains > 5 and cooldown[AR.Bladestorm].ready then
		debugPrint("* CHOOSING PRIORITY #6 (BLADESTORM DURING COLOSSUS SMASH)")
		spellChosen = true
		chosenSpell = AR.Bladestorm
	else
		debugPrint("SKIPPING PRIORITY #6 (BLADESTORM DURING COLOSSUS SMASH)")
	end


	-- Priority #7: Slam Or Whirlwind (depending on fervor talent)
	if talents[AR.FervorOfBattle] then
		if spellChosen == false and fd.rage > 30 and fd.executePhase == false then
			debugPrint("* CHOOSING PRIORITY #7 (WHIRLWIND)")
			spellChosen = true
			chosenSpell = AR.Whirlwind
		else 
			debugPrint("SKIPPING PRIORITY #7 (WHIRLWIND)")
		end
	else
		if spellChosen == false and fd.rage > 20 and fd.executePhase == false then
			debugPrint("* CHOOSING PRIORITY #7 (SLAM)")
			spellChosen = true
			chosenSpell = AR.Slam
		else
			debugPrint("SKIPPING PRIORITY #7 (SLAM)")
		end
	end

	if chosenSpell then
		return chosenSpell
	else
		debugPrint(" -- NO ACTIONS DETERMINED THIS FRAME -- LITERALLY STAND THERE AND AUTO ATTACK --")
	end
end

function Warrior:TwoOrThreeTargets()
	-- TODO
end

function Warrior:FourOrMoreTargets()
	-- TODO
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
		if rage >= 20 and canExecute then
			return AR.Condemn;
		end
	else
		-- execute,if=buff.sweeping_strikes.up;
		if rage >= 20 and buff[AR.SweepingStrikes].up and cooldown[AR.Execute].ready then
			return AR.Execute;
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

function Warrior:Arms()
	local fd = MaxDps.FrameData;
	local talents = fd.talents;
	local targets = 1 --MaxDps:SmartAoe();
	local targetHp = MaxDps:TargetPercentHealth() * 100;
	local covenantId = fd.covenant.covenantId;
	local rage = UnitPower('player', PowerTypeRage);
	local executePhase = ((targetHp < 20) or                                           -- target is <20% hp
						  (talents[AR.Massacre] and targetHp < 35) or                  -- massacre is talented, and the target is <35% hp
						  (targetHp > 80 and covenantId == Venthyr))                   -- player is venthyr, and target is >80% hp
	local canExecute = rage > 20 and                                                   -- player has enough rage to execute
					   (executePhase or                                                -- its execute phase
		                (talents[AR.SuddenDeath] and fd.buff[AR.SuddenDeathAura].up)); -- sudden death is talented, and the sudden death aura is active on the player

	fd.rage = rage;
	fd.targetHp = targetHp;
	fd.targets = targets;
	fd.covenantId = covenantId;
	fd.canExecute = canExecute;
	fd.executePhase = executePhase

	-- if targets >= 4 then
	-- 	return Warrior:FourOrMoreTargets();
	-- end

	if (targets >= 2) then
		if cooldown[AR.SweepingStrikes].ready and
			targets > 1 and
			(cooldown[AR.Bladestorm].remains > 15 or talents[AR.Ravager])
		then
			return AR.SweepingStrikes;
		end

		return Warrior:ArmsHac();
		-- return Warrior:TwoOrThreeTargets();
	end

	return Warrior:SingleTarget();
end