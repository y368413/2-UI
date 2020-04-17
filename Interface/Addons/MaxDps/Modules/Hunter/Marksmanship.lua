if select(2, UnitClass("player")) ~= "HUNTER" then return end

local _, MaxDps_HunterTable = ...;

--- @type MaxDps
if not MaxDps then return end
local MaxDps = MaxDps;
local Hunter = MaxDps_HunterTable.Hunter;

local MM = {
	--PreciseShots   = 260242,
	SteadyFocus      = 193534,
	LoneWolf         = 164273,
	--TrickShots     = 257622,
	LockAndLoad      = 194594,


	HuntersMark      = 257284,
	DoubleTap        = 260402,
	Trueshot         = 288613,
	AimedShot        = 19434,
	RapidFire        = 257044,
	CarefulAim       = 260228,
	ExplosiveShot    = 212431,
	Barrage          = 120360,
	AMurderOfCrows   = 131894,
	SerpentSting     = 271788,
	ArcaneShot       = 185358,
	MasterMarksman   = 269576,
	Streamline       = 260367,
	PreciseShots     = 260240,
	PreciseShotsAura = 260242,
	PiercingShot     = 198670,
	SteadyShot       = 56641,
	TrickShots       = 257622,
	Multishot        = 257620,

	--Azerite
	InTheRhythm      = 272733,
	FocusedFire      = 278531,
	SurgingShots     = 287707,
}

setmetatable(MM, Hunter.spellMeta);

function Hunter:Marksmanship()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local currentSpell = fd.currentSpell;
	local timeShift = fd.timeShift;
	local targets = MaxDps:SmartAoe();
	local targetHp = MaxDps:TargetPercentHealth() * 100;
	local minus = 0;

	if currentSpell == MM.SteadyShot then
		minus = -10;
	elseif currentSpell == MM.AimedShot then
		minus = 30;
	elseif currentSpell == MM.RapidFire then
		minus = -10;
	end

	local focus, focusMax, castRegen = Hunter:Focus(minus);
	castRegen = castRegen * timeShift;

	local canAimed = cooldown[MM.AimedShot].charges >= 2 or (cooldown[MM.AimedShot].ready and currentSpell ~= MM.AimedShot);
	fd.canAimed = canAimed;
	fd.focus = focus;
	fd.focusMax = focusMax;
	fd.castRegen = castRegen;
	fd.targetHp = targetHp;
	fd.targets = targets;

	-- call_action_list,name=cds;
	local result = Hunter:MarksmanshipCds();
	if result then return result; end

	-- call_action_list,name=st,if=active_enemies<3;
	if targets < 3 then
		return Hunter:MarksmanshipSt();
	else
		-- call_action_list,name=trickshots,if=active_enemies>2;
		return Hunter:MarksmanshipTrickshots();
	end
end

function Hunter:MarksmanshipCds()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local gcd = fd.gcd;
	local timeToDie = fd.timeToDie;
	local targetHp = fd.targetHp;

	MaxDps:GlowEssences();

	-- trueshot,if=cooldown.rapid_fire.remains&target.time_to_die>cooldown.trueshot.duration_guess+duration|(target.health.pct<20|!talent.careful_aim.enabled)|target.time_to_die<15;
	MaxDps:GlowCooldown(
		MM.Trueshot,
		cooldown[MM.Trueshot].ready and (
			not cooldown[MM.RapidFire].up and timeToDie > cooldown[MM.Trueshot].duration + cooldown[MM.Trueshot].duration or
			(targetHp < 20 or not talents[MM.CarefulAim]) or
			timeToDie < 15
		)
	);

	if Hunter.db.doubleTapCooldown then
		MaxDps:GlowCooldown(MM.HuntersMark, cooldown[MM.DoubleTap].ready and (cooldown[MM.RapidFire].remains < gcd or timeToDie < 20));
	end

	-- hunters_mark,if=debuff.hunters_mark.down;
	if Hunter.db.huntersMarkCooldown then
		MaxDps:GlowCooldown(MM.HuntersMark, not debuff[MM.HuntersMark].up);
	end

	if not Hunter.db.huntersMarkCooldown then
		if talents[MM.HuntersMark] and not debuff[MM.HuntersMark].up then
			return MM.HuntersMark;
		end
	end

	-- double_tap,if=cooldown.rapid_fire.remains<gcd.max|target.time_to_die<20;
	if not Hunter.db.doubleTapCooldown then
		if talents[MM.DoubleTap] and cooldown[MM.DoubleTap].ready and (cooldown[MM.RapidFire].remains < gcd or timeToDie < 20) then
			return MM.DoubleTap;
		end
	end
end

function Hunter:MarksmanshipSt()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local targets = fd.targets;
	local targetHp = fd.targetHp;
	local spellHistory = fd.spellHistory;
	local timeToDie = fd.timeToDie;
	local focus = fd.focus;
	local castRegen = fd.castRegen;
	local focusMax = fd.focusMax;

	local caExecute = targetHp < 20 or targetHp > 80;
	local canAimed = fd.canAimed;

	-- explosive_shot;
	if talents[MM.ExplosiveShot] and cooldown[MM.ExplosiveShot].ready and focus >= 20 then
		return MM.ExplosiveShot;
	end

	-- barrage,if=active_enemies>1;
	if talents[MM.Barrage] and cooldown[MM.Barrage].ready and focus >= 30 and targets > 1 then
		return MM.Barrage;
	end

	-- a_murder_of_crows;
	if talents[MM.AMurderOfCrows] and cooldown[MM.AMurderOfCrows].ready and focus >= 20 then
		return MM.AMurderOfCrows;
	end

	-- serpent_sting,if=refreshable&!action.serpent_sting.in_flight;
	if talents[MM.SerpentSting] and focus >= 10 and debuff[MM.SerpentSting].refreshable and spellHistory[1] ~= MM.SerpentSting then
		return MM.SerpentSting;
	end

	-- rapid_fire,if=focus<50|buff.in_the_rhythm.remains<action.rapid_fire.cast_time;
	local rapidFireCastTime = MaxDps:AttackHaste() * 3 * (talents[MM.Streamline] and 1.2 or 1);
	if cooldown[MM.RapidFire].ready and (focus < 50 or buff[MM.InTheRhythm].remains < rapidFireCastTime) then
		return MM.RapidFire;
	end

	-- arcane_shot,if=buff.master_marksman.up&buff.trueshot.up&focus+cast_regen<focus.max;
	if focus >= 15 and (buff[MM.MasterMarksman].up and buff[MM.Trueshot].up and focus + castRegen < focusMax) then
		return MM.ArcaneShot;
	end

	-- aimed_shot,if=(!buff.double_tap.up|ca_execute|(!azerite.focused_fire.enabled&!azerite.surging_shots.enabled&!talent.streamline.enabled))&buff.precise_shots.down|cooldown.aimed_shot.full_recharge_time<action.aimed_shot.cast_time|buff.trueshot.up;
	if focus >= 30 and canAimed and (
		(
			not buff[MM.DoubleTap].up or
			caExecute or
			(azerite[MM.FocusedFire] == 0 and azerite[MM.SurgingShots] == 0 and not talents[MM.Streamline])
		) and not buff[MM.PreciseShotsAura].up or
		cooldown[MM.AimedShot].fullRecharge < 2 or
		buff[MM.Trueshot].up
	) then
		return MM.AimedShot;
	end

	-- rapid_fire,if=focus+cast_regen<focus.max|azerite.focused_fire.enabled|azerite.in_the_rhythm.rank>1|azerite.surging_shots.enabled|talent.streamline.enabled;
	if cooldown[MM.RapidFire].ready and (
		focus + castRegen < focusMax or
		azerite[MM.FocusedFire] > 0 or
		azerite[MM.InTheRhythm] > 1 or
		azerite[MM.SurgingShots] > 0 or
		talents[MM.Streamline]
	) then
		return MM.RapidFire;
	end

	-- piercing_shot;
	if talents[MM.PiercingShot] and cooldown[MM.PiercingShot].ready and focus >= 35 then
		return MM.PiercingShot;
	end

	-- arcane_shot,if=focus>75|(buff.precise_shots.up|focus>45&cooldown.trueshot.remains&target.time_to_die<25)&buff.trueshot.down|target.time_to_die<5;
	if focus >= 15 and (
		focus > 60 or
		(
			buff[MM.PreciseShotsAura].up or
			focus > 45 and not cooldown[MM.Trueshot].ready and timeToDie < 25
		) and not buff[MM.Trueshot].up or
		timeToDie < 5
	) then
		return MM.ArcaneShot;
	end

	-- steady_shot;
	return MM.SteadyShot;
end

function Hunter:MarksmanshipTrickshots()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local focus = fd.focus;
	local canAimed = fd.canAimed;

	local trickShots = buff[MM.TrickShots].up;
	if currentSpell == MM.RapidFire or currentSpell == MM.AimedShot then
		trickShots = false;
	end

	-- barrage;
	if talents[MM.Barrage] and cooldown[MM.Barrage].ready and focus >= 30 then
		return MM.Barrage;
	end

	-- explosive_shot;
	if talents[MM.ExplosiveShot] and cooldown[MM.ExplosiveShot].ready and focus >= 20 then
		return MM.ExplosiveShot;
	end

	-- rapid_fire,if=buff.trick_shots.up&(azerite.focused_fire.enabled|azerite.in_the_rhythm.rank>1|azerite.surging_shots.enabled|talent.streamline.enabled);
	if cooldown[MM.RapidFire].ready and trickShots and
		(
			azerite[MM.FocusedFire] > 0 or
			azerite[MM.InTheRhythm] > 1 or
			azerite[MM.SurgingShots] > 0 or
			talents[MM.Streamline]
		)
	then
		return MM.RapidFire;
	end

	-- aimed_shot,if=buff.trick_shots.up&(buff.precise_shots.down|cooldown.aimed_shot.full_recharge_time<action.aimed_shot.cast_time);
	if focus >= 30 and canAimed and trickShots and
		(not buff[MM.PreciseShotsAura].up or cooldown[MM.AimedShot].fullRecharge < 2)
	then
		return MM.AimedShot;
	end

	-- rapid_fire,if=buff.trick_shots.up;
	if cooldown[MM.RapidFire].ready and trickShots then
		return MM.RapidFire;
	end

	-- multishot,if=buff.trick_shots.down|buff.precise_shots.up|focus>70;
	if focus >= 15 and (
		not trickShots or
		buff[MM.PreciseShotsAura].up or
		focus > 70
	) then
		return MM.Multishot;
	end

	-- piercing_shot;
	if talents[MM.PiercingShot] and cooldown[MM.PiercingShot].ready and focus >= 35 then
		return MM.PiercingShot;
	end

	-- a_murder_of_crows;
	if talents[MM.AMurderOfCrows] and cooldown[MM.AMurderOfCrows].ready and focus >= 20 then
		return MM.AMurderOfCrows;
	end

	-- serpent_sting,if=refreshable&!action.serpent_sting.in_flight;
	if talents[MM.SerpentSting] and focus >= 10 and debuff[MM.SerpentSting].refreshable then
		return MM.SerpentSting;
	end

	-- steady_shot;
	return MM.SteadyShot;
end