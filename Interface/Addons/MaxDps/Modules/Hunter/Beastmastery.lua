if select(2, UnitClass("player")) ~= "HUNTER" then return end

local _, MaxDps_HunterTable = ...;

--- @type MaxDps
if not MaxDps then return end
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

	-- Player Auras
	BestialWrathAura = 186254,
	BeastCleave      = 268877,
	Frenzy           = 272790,
	--BestialWrath   = 19574,
	--BarbedShot     = 246152,
	--DireBeast      = 281036,
	--BarbedShot     = 246852,

	-- Pet Auras

	-- Target Auras
	BarbedShotAura   = 217200,
}

local A = {
	PrimalInstincts    = 279806,
}


setmetatable(BM, Hunter.spellMeta);

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
	local targets;
	if Hunter.db.advancedAoeBM then
		targets = Hunter:TargetsInPetRange();
	else
		targets = MaxDps:SmartAoe();
	end

	local timeShift = fd.timeShift;
	local cooldown = fd.cooldown;
	local talents = fd.talents;
	local buff = fd.buff;
	local bw, bwCd = cooldown[BM.BestialWrath].ready, cooldown[BM.BestialWrath].remains;

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

	-- call_action_list,name=cleave,if=active_enemies>1;
	if targets > 1 then
		return Hunter:BeastMasteryCleave();
	else
		return Hunter:BeastMasterySt();
	end
end

function Hunter:BeastMasteryCleave()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local talents = fd.talents;
	local timeShift = fd.timeShift;
	local gcd = fd.gcd;
	local pet = fd.pet;
	local focus = fd.focus;
	local focusTimeToMax = Hunter:FocusTimeToMax();

	local realFrenzyRemains = pet[BM.Frenzy].remains + timeShift;

	-- just in case we know its going to be in time
	if realFrenzyRemains < 2 and cooldown[BM.BarbedShot].remains <= pet[BM.Frenzy].remains then
		return BM.BarbedShot;
	end

	-- barbed_shot,if=pet.cat.buff.frenzy.up&pet.cat.buff.frenzy.remains<=gcd.max;
	--print(pet[BM.Frenzy].remains);
	if pet[BM.Frenzy].up and pet[BM.Frenzy].remains <= gcd
			and cooldown[BM.BarbedShot].remains <= gcd
	then
		return BM.BarbedShot;
	end

	-- multishot,if=gcd.max-pet.cat.buff.beast_cleave.remains>0.25;
	if gcd - buff[BM.BeastCleave].remains > 0.25 then
		return BM.MultiShot;
	end

	-- barbed_shot,if=full_recharge_time<gcd.max&cooldown.bestial_wrath.remains;
	if cooldown[BM.BarbedShot].fullRecharge < gcd and not cooldown[BM.BestialWrath].ready then
		return BM.BarbedShot;
	end

	-- bestial_wrath,if=cooldown.aspect_of_the_wild.remains>20|target.time_to_die<15;
	if cooldown[BM.BestialWrath].ready and (cooldown[BM.AspectOfTheWild].remains > 20 or cooldown[BM.AspectOfTheWild].ready) then
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

	-- kill_command;
	if cooldown[BM.KillCommand].ready and focus >= 30 then
		return BM.KillCommand;
	end

	-- dire_beast;
	if talents[BM.DireBeast] and cooldown[BM.DireBeast].ready and focus >= 25 then
		return BM.DireBeast;
	end

	if cooldown[BM.BarbedShot].fullRecharge < gcd then
		return BM.BarbedShot;
	end

	-- barbed_shot,if=pet.cat.buff.frenzy.down&(charges_fractional>1.8|buff.bestial_wrath.up)|cooldown.aspect_of_the_wild.remains<pet.cat.buff.frenzy.duration-gcd&azerite.primal_instincts.enabled|target.time_to_die<9;
	if not pet[BM.Frenzy].up and (cooldown[BM.BarbedShot].charges > 1.8 or buff[BM.BestialWrath].up) --or
	--cooldown[BM.AspectOfTheWild].remains < pet[BM.Frenzy].duration - gcd and azerite[A.PrimalInstincts] > 0
	then
		return BM.BarbedShot;
	end

	-- cobra_shot,if=cooldown.kill_command.remains>focus.time_to_max;
	if focus >= 35 and (cooldown[BM.KillCommand].remains > focusTimeToMax) then
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

	local realFrenzyRemains = pet[BM.Frenzy].remains + timeShift;

	-- just in case we know its going to be in time
	if realFrenzyRemains < 2 and cooldown[BM.BarbedShot].remains < pet[BM.Frenzy].remains then
		return BM.BarbedShot;
	end

	-- barbed_shot,if=pet.cat.buff.frenzy.up&pet.cat.buff.frenzy.remains<=gcd.max|full_recharge_time<gcd.max&cooldown.bestial_wrath.remains|azerite.primal_instincts.enabled&cooldown.aspect_of_the_wild.remains<gcd;

	if pet[BM.Frenzy].up and pet[BM.Frenzy].remains <= gcd or
			cooldown[BM.BarbedShot].fullRecharge < gcd and not cooldown[BM.BestialWrath].ready --or
	--azerite[A.PrimalInstincts] > 0 and cooldown[BM.AspectOfTheWild].remains < gcd
	then
		return BM.BarbedShot;
	end

	-- a_murder_of_crows;
	if talents[BM.AMurderOfCrows] and cooldown[BM.AMurderOfCrows].ready then
		return BM.AMurderOfCrows;
	end


	-- bestial_wrath,if=cooldown.aspect_of_the_wild.remains>20|target.time_to_die<15;
	if cooldown[BM.BestialWrath].ready and (cooldown[BM.AspectOfTheWild].remains > 20 or cooldown[BM.AspectOfTheWild].ready) then
		return BM.BestialWrath;
	end

	-- kill_command;
	if cooldown[BM.KillCommand].ready and focus >= 30 then
		return BM.KillCommand;
	end

	-- chimaera_shot;
	if talents[BM.ChimaeraShot] and cooldown[BM.ChimaeraShot].ready then
		return BM.ChimaeraShot;
	end

	-- dire_beast;
	if talents[BM.DireBeast] and cooldown[BM.DireBeast].ready and focus >= 25 then
		return BM.DireBeast;
	end

	-- barbed_shot,if=pet.cat.buff.frenzy.down&(charges_fractional>1.8|buff.bestial_wrath.up)|cooldown.aspect_of_the_wild.remains<pet.cat.buff.frenzy.duration-gcd&azerite.primal_instincts.enabled|target.time_to_die<9;
	if not pet[BM.Frenzy].up and (cooldown[BM.BarbedShot].charges > 1.8 or buff[BM.BestialWrath].up) -- or
	--cooldown[BM.AspectOfTheWild].remains < pet[BM.Frenzy].duration - gcd and azerite[A.PrimalInstincts] > 0
	then
		return BM.BarbedShot;
	end

	-- barrage;
	if talents[BM.Barrage] and cooldown[BM.Barrage].ready and focus >= 60 then
		return BM.Barrage;
	end

	local CobraShotCost = 35;
	local KillCommandCost = 30;
	-- cobra_shot,if=(focus-cost+focus.regen*(cooldown.kill_command.remains-1)>action.kill_command.cost|cooldown.kill_command.remains>1+gcd)&cooldown.kill_command.remains>1;
	if (
			focus - CobraShotCost + focusRegen * ( cooldown[BM.KillCommand].remains - 1 ) > KillCommandCost or
					cooldown[BM.KillCommand].remains > 1 + gcd
	) and cooldown[BM.KillCommand].remains > 1
	then
		return BM.CobraShot;
	end

	-- spitting_cobra;
	if talents[BM.SpittingCobra] and cooldown[BM.SpittingCobra].ready then
		return BM.SpittingCobra;
	end
end

--[[ Old rotation

function Hunter:BeastMastery()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, timeShift, talents, azerite, currentSpell =
		fd.cooldown, fd.buff, fd.debuff, fd.timeShift, fd.talents, fd.azerite, fd.currentSpell;

	local minus = 0;
	local focus, focusMax, focusRegen = Hunter:Focus(minus, timeShift);

	-- Cooldowns

	local bw, bwCd = cooldown[BM.BestialWrath].ready, cooldown[BM.BestialWrath].remains;

	MaxDps:GlowCooldown(BM.AspectOfTheWild, cooldown[BM.AspectOfTheWild].ready and (bw or bwCd > 82));

	if talents[BM.SpittingCobra] then
		MaxDps:GlowCooldown(BM.SpittingCobra, cooldown[BM.SpittingCobra].ready);
	end

	if talents[BM.Stampede] then
		MaxDps:GlowCooldown(BM.Stampede, cooldown[BM.Stampede].ready);
	end

	if talents[BM.Barrage] then
		MaxDps:GlowCooldown(BM.Barrage, cooldown[BM.Barrage].ready);
	end

	-- Auras

	local bwAura = buff[BM.BestialWrathAura].up;

	local frenzyAura, frenzyCount, frenzyCd = MaxDps:UnitAura(BM.Frenzy, timeShift, 'pet');

	-- Rotation start
	if frenzyAura and cooldown[BM.BarbedShot].charges >= 1 and frenzyCd < 2 then
		return BM.BarbedShot;
	end

	if talents[BM.AMurderOfCrows] and cooldown[BM.AMurderOfCrows].ready then
		return BM.AMurderOfCrows;
	end

	if cooldown[BM.BarbedShot].charges >= 1.8 then
		return BM.BarbedShot;
	end

	if bw then
		return BM.BestialWrath;
	end

	if talents[BM.ChimaeraShot] and cooldown[BM.ChimaeraShot].ready then
		return BM.ChimaeraShot;
	end

	if cooldown[BM.KillCommand].remains < 0.5 then
		return BM.KillCommand;
	end

	if talents[BM.DireBeast] and cooldown[BM.DireBeast].ready then
		return BM.DireBeast;
	end

	if focus > 50 and cooldown[BM.KillCommand].remains > 2 then
		return BM.CobraShot;
	else
		return nil;
	end
end
]]--