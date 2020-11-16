if select(2, UnitClass("player")) ~= "DEATHKNIGHT" then return end

local _, MaxDps_DeathKnightTable = ...;

local MaxDps = MaxDps;
local DeathKnight = MaxDps_DeathKnightTable.DeathKnight;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local RunicPower = Enum.PowerType.RunicPower;

local BL = {
	DancingRuneWeapon  = 49028,
	DarkCommand        = 56222,
	BloodDrinker       = 206931,
	Marrowrend         = 195182,
	BloodBoil          = 50842,
	BoneShield         = 195181,
	DeathStrike        = 49998,
	BloodShield        = 77535,
	BloodPlague        = 55078,
	BonesOfTheDamned   = 279503,
	Ossuary            = 219786,
	RuneStrike         = 210764,
	DeathAndDecay      = 43265,
	HeartStrike        = 206930,
	CrimsonScourge     = 81141,
	DeathGrip          = 49576,
	AntiMagicShell     = 48707,
	VampiricBlood      = 55233,
	IceboundFortitude  = 48792,
	AntiMagicBarrier   = 205727,
	Hemostasis         = 273946,
	RedThirst          = 205723,
	DeathsAdvance      = 48265,
	RuneTap            = 194679,
	MasteryBloodShield = 77513,
	Bonestorm          = 194844,
};

function DeathKnight:Blood()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, timeShift, talents, azerite, currentSpell =
	fd.cooldown, fd.buff, fd.debuff, fd.timeShift, fd.talents, fd.azerite, fd.currentSpell;
	local runic = UnitPower('player', 6);
	local runicMax = UnitPowerMax('player', 6);
	local runes, runeCd = DeathKnight:Runes(timeShift);
	local playerHp = MaxDps:TargetPercentHealth('player');
	local targets = MaxDps:TargetsInRange(49998);

	MaxDps:GlowEssences();
	MaxDps:GlowCooldown(BL.DancingRuneWeapon, cooldown[BL.DancingRuneWeapon].ready);

	--MARROWREND FOR GETTING 7+ BONE SHIELDS OR IF TIMER IS RUNNING LOW
	local shouldUseMarrowrend = buff[BL.BoneShield].count <= 7 or buff[BL.BoneShield].remains < 3;
	if shouldUseMarrowrend and runes >= 2 then
		return BL.Marrowrend;
	end
	--IF TARGETS > 4 and BONESTORM READY USE BORNSTORM
	--ELSE USE DEATHSTRIKE IF ON CD

	if runic >= 45 and  playerHp < 0.30 then
		return BL.DeathStrike;
	end
	--BLOODBOIL IF CAPPED OR IF NO DEBUFF
	if not debuff[BL.BloodPlague].up or cooldown[BL.BloodBoil].charges >= 2 then
		return BL.BloodBoil;
	end
	--DEATH AND DECAY IF 3+ RUNES AND MULTIPLE TARGETS
	if runes >= 3 and cooldown[BL.DeathAndDecay].ready and targets >= 3 then
		return BL.DeathAndDecay;
	end

	if runes >=3 and targets >= 3 then
		return BL.HeartStrike;
	end

	if buff[BL.CrimsonScourge].up or (cooldown[BL.DeathAndDecay].ready and targets > 5 and runes >= 1) then
		return BL.DeathAndDecay;
	end
	if runic >= 95 then
		return BL.DeathStrike;
	end

	if runes > 4 then
		return BL.HeartStrike;
	end

	if cooldown[BL.BloodBoil].charges >= 1 then
		return BL.BloodBoil;
	end

	return nil;
end