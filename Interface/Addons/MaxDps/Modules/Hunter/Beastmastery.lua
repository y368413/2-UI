if select(2, UnitClass("player")) ~= "HUNTER" then return end

local _, MaxDps_HunterTable = ...;

local MaxDps = MaxDps;
local Hunter = MaxDps_HunterTable.Hunter;

-- BM
local BM = {
	SpittingCobra    = 194407,
	MultiShot        = 2643,
	CounterShot      = 147362,
	AspectOfTheWild  = 193530,
	DireBeast        = 120679,
	AutoShot         = 75,
	Stampede         = 201430,
	ChimaeraShot     = 53209,
	AMurderOfCrows   = 131894,
	BestialWrath     = 19574,
	CobraShot        = 193455,
	KillCommand      = 34026,
	BarbedShot       = 217200,
	Barrage          = 120360,
	PrimalInstincts  = 279810,
	OneWithThePack   = 199528,

	-- Player Auras
	DanceOfDeath     = 274443,
	--BestialWrath   = 19574,
	--BarbedShot     = 246152,
	--DireBeast      = 281036,
	--BarbedShot     = 246852,

	-- Pet Auras
	BeastCleave      = 268877,
	Frenzy           = 272790,

	-- Target Auras
	BarbedShotAura   = 217200,
}

local A = {
	PrimalInstincts    = 279806,
	RapidReload        = 278530,
	DanceOfDeath       = 274441,
}


setmetatable(BM, Hunter.spellMeta);
setmetatable(A, Hunter.spellMeta);

local auraMetaTable = {
	__index = function()
		return {
			up          = false,
			count       = 0,
			remains     = 0,
			duration    = 0,
			refreshable = true,
		};
	end
};

function Hunter:BeastMastery()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local focusTimeToMax = Hunter:FocusTimeToMax();
	fd.focusTimeToMax = focusTimeToMax;

	local targets;
	if Hunter.db.advancedAoeBM then
		targets = Hunter:TargetsInPetRange();
	else
		targets = MaxDps:SmartAoe();
	end

	if not fd.pet then
		fd.pet = {};
		setmetatable(fd.pet, auraMetaTable);
	end
	MaxDps:CollectAura('pet', timeShift, fd.pet);

	fd.targets = targets;
	local focus, focusMax, focusRegen = Hunter:Focus(0, timeShift);
	fd.focus = focus;
	fd.focusRegen = focusRegen;

	MaxDps:GlowEssences();
	MaxDps:GlowCooldown(BM.AspectOfTheWild, cooldown[BM.AspectOfTheWild].ready);

	-- stampede,if=buff.aspect_of_the_wild.up&buff.bestial_wrath.up|target.time_to_die<15;
	if talents[BM.Stampede] then
		MaxDps:GlowCooldown(BM.Stampede, cooldown[BM.Stampede].ready and (buff[BM.AspectOfTheWild].up and buff[BM.BestialWrath].up));
	end

	-- call_action_list,name=st,if=active_enemies<2;
	-- call_action_list,name=cleave,if=active_enemies>1;
	if targets < 2 then
		return Hunter:BeastMasterySt();
	else
		return Hunter:BeastMasteryCleave();--BeastMasteryCleave();
	end
end

function Hunter:BeastMasteryCleave()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local gcd = fd.gcd;
	local timeToDie = fd.timeToDie;
	local focus = fd.focus;
	local pet = fd.pet;
	local focusTimeToMax = fd.focusTimeToMax;

	-- barbed_shot,target_if=min:dot.barbed_shot.remains,if=pet.turtle.buff.frenzy.up&pet.turtle.buff.frenzy.remains<=gcd.max;
	if cooldown[BM.BarbedShot].ready and pet[BM.Frenzy].up and pet[BM.Frenzy].remains <= gcd then
		return BM.BarbedShot;
	end

	-- multishot,if=gcd.max-pet.turtle.buff.beast_cleave.remains>0.25;
	if buff[BM.BeastCleave].remains < gcd then
		return BM.MultiShot;
	end

	-- barbed_shot,target_if=min:dot.barbed_shot.remains,if=full_recharge_time<gcd.max&cooldown.bestial_wrath.remains;
	if cooldown[BM.BarbedShot].fullRecharge < gcd and not cooldown[BM.BestialWrath].ready then
		return BM.BarbedShot;
	end

	-- bestial_wrath,if=cooldown.aspect_of_the_wild.remains_guess>20|talent.one_with_the_pack.enabled|target.time_to_die<15;
	if cooldown[BM.BestialWrath].ready and (cooldown[BM.AspectOfTheWild].remains > 20 or talents[BM.OneWithThePack] or timeToDie < 15) then
		return BM.BestialWrath;
	end

	-- chimaera_shot;
	if talents[BM.ChimaeraShot] and cooldown[BM.ChimaeraShot].ready then
		return BM.ChimaeraShot;
	end

	-- a_murder_of_crows;
	if talents[BM.AMurderOfCrows] and cooldown[BM.AMurderOfCrows].ready then
		return BM.AMurderOfCrows;
	end

	-- barrage;
	if talents[BM.Barrage] and cooldown[BM.Barrage].ready and focus >= 60 then
		return BM.Barrage;
	end

	-- kill_command,if=active_enemies<4|!azerite.rapid_reload.enabled;
	if cooldown[BM.KillCommand].remains < 0.5 and (targets < 4 or azerite[A.RapidReload] == 0) then
		return BM.KillCommand;
	end

	-- dire_beast;
	if talents[BM.DireBeast] and cooldown[BM.DireBeast].ready and focus >= 25 then
		return BM.DireBeast;
	end

	-- barbed_shot,target_if=min:dot.barbed_shot.remains,if=pet.turtle.buff.frenzy.down&(charges_fractional>1.8|buff.bestial_wrath.up)|cooldown.aspect_of_the_wild.remains<pet.turtle.buff.frenzy.duration-gcd&azerite.primal_instincts.enabled|charges_fractional>1.4|target.time_to_die<9;
	if cooldown[BM.BarbedShot].ready and (
		not pet[BM.Frenzy].up and (cooldown[BM.BarbedShot].charges > 1.8 or buff[BM.BestialWrath].up) or
		(cooldown[BM.AspectOfTheWild].remains < pet[BM.Frenzy].duration - gcd and azerite[A.PrimalInstincts] > 0) or
		(cooldown[BM.BarbedShot].charges > 1.4 or timeToDie < 9)
	) then
		return BM.BarbedShot;
	end

	-- multishot,if=azerite.rapid_reload.enabled&active_enemies>2;
	if azerite[A.RapidReload] > 0 and targets > 2 then
		return BM.MultiShot;
	end

	-- cobra_shot,if=cooldown.kill_command.remains>focus.time_to_max&(active_enemies<3|!azerite.rapid_reload.enabled);
	if focus >= 35 and (
			cooldown[BM.KillCommand].remains > focusTimeToMax and (targets < 3 or azerite[A.RapidReload] == 0)
	) then
		return BM.CobraShot;
	end

	-- spitting_cobra;
	if talents[BM.SpittingCobra] and cooldown[BM.SpittingCobra].ready then
		return BM.SpittingCobra;
	end
end

function Hunter:BeastMasterySt()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local gcd = fd.gcd;
	local focus = fd.focus;
	local pet = fd.pet;
	local timeToDie = fd.timeToDie;
	local focusRegen = fd.focusRegen;
	local spellHistory = fd.spellHistory;
	local focusTimeToMax = fd.focusTimeToMax;

	-- barbed_shot,if=pet.turtle.buff.frenzy.up&pet.turtle.buff.frenzy.remains<gcd|cooldown.bestial_wrath.remains&(full_recharge_time<gcd|azerite.primal_instincts.enabled&cooldown.aspect_of_the_wild.remains<gcd);
	if cooldown[BM.BarbedShot].ready and (
		pet[BM.Frenzy].up and pet[BM.Frenzy].remains < gcd or
		cooldown[BM.BestialWrath].remains > 0 and (
		cooldown[BM.BarbedShot].fullRecharge < gcd
		-- or azerite[A.PrimalInstincts] > 0 and cooldown[BM.AspectOfTheWild].remains < gcd
	)) then
		return BM.BarbedShot;
	end

	-- a_murder_of_crows;
	if talents[BM.AMurderOfCrows] and cooldown[BM.AMurderOfCrows].ready then
		return BM.AMurderOfCrows;
	end

	-- bestial_wrath,if=talent.one_with_the_pack.enabled&buff.bestial_wrath.remains<gcd|buff.bestial_wrath.down&cooldown.aspect_of_the_wild.remains>15|target.time_to_die<15+gcd;
	if cooldown[BM.BestialWrath].ready and (
		talents[BM.OneWithThePack] and buff[BM.BestialWrath].remains < gcd or
		not buff[BM.BestialWrath].up and cooldown[BM.AspectOfTheWild].remains > 15 or
		timeToDie < 15 + gcd
	) then
		return BM.BestialWrath;
	end

	-- barbed_shot,if=azerite.dance_of_death.rank>1&buff.dance_of_death.remains<gcd;
	if cooldown[BM.BarbedShot].ready and azerite[A.DanceOfDeath] > 1 and buff[BM.DanceOfDeath].remains < gcd and spellHistory[1] ~= BM.BarbedShot then
		return BM.BarbedShot;
	end

	-- kill_command;
	if cooldown[BM.KillCommand].remains < 0.7 then
		return BM.KillCommand;
	end

	-- chimaera_shot;
	if talents[BM.ChimaeraShot] and cooldown[BM.ChimaeraShot].ready then
		return BM.ChimaeraShot;
	end

	-- dire_beast;
	if talents[BM.DireBeast] and cooldown[BM.DireBeast].ready then
		return BM.DireBeast;
	end

	-- barbed_shot,if=talent.one_with_the_pack.enabled&charges_fractional>1.5|charges_fractional>1.8|cooldown.aspect_of_the_wild.remains<pet.turtle.buff.frenzy.duration-gcd&azerite.primal_instincts.enabled|target.time_to_die<9;
	if cooldown[BM.BarbedShot].charges > 1.7 and talents[BM.OneWithThePack] or
		cooldown[BM.BarbedShot].charges > 1.8 --or
		--cooldown[BM.BarbedShot].charges >= 1 and cooldown[BM.AspectOfTheWild].remains < pet[BM.Frenzy].duration - gcd and azerite[A.PrimalInstincts] > 0
			--or
		--cooldown[BM.BarbedShot].charges >= 1 and timeToDie < 9
	then
		return BM.BarbedShot;
	end

	-- barrage;
	if talents[BM.Barrage] and cooldown[BM.Barrage].ready and focus >= 60 then
		return BM.Barrage;
	end

	-- cobra_shot,if=(focus-cost+focus.regen*(cooldown.kill_command.remains-1)>action.kill_command.cost|cooldown.kill_command.remains>1+gcd&cooldown.bestial_wrath.remains_guess>focus.time_to_max|buff.memory_of_lucid_dreams.up)&cooldown.kill_command.remains>1|target.time_to_die<3;
	if focus >= 40 and cooldown[BM.KillCommand].remains > 2 and (
			(
				focus - 35 + focusRegen * (cooldown[BM.KillCommand].remains - 1) > 30 or
				cooldown[BM.KillCommand].remains > 1 + gcd and cooldown[BM.BestialWrath].remains > focusTimeToMax
				--or buff[BM.MemoryOfLucidDreams].up
			) and
		cooldown[BM.KillCommand].remains > 1.2 or
		timeToDie < 3
	) then
		return BM.CobraShot;
	end

	-- spitting_cobra;
	if talents[BM.SpittingCobra] and cooldown[BM.SpittingCobra].ready then
		return BM.SpittingCobra;
	end

	-- barbed_shot,if=pet.turtle.buff.frenzy.duration-gcd>full_recharge_time;
	--if pet[BM.Frenzy].duration - gcd > cooldown[BM.BarbedShot].fullRecharge then
	--	return BM.BarbedShot;
	--end
end
