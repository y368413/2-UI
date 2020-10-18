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

	local runic = UnitPower('player', RunicPower);
	local runicMax = UnitPowerMax('player', RunicPower);
	local runes, runeCd = DeathKnight:Runes(timeShift);

	MaxDps:GlowEssences();
	MaxDps:GlowCooldown(BL.DancingRuneWeapon, cooldown[BL.DancingRuneWeapon].ready);

	if talents[BL.Bonestorm] then
		MaxDps:GlowCooldown(BL.Bonestorm, cooldown[BL.Bonestorm].ready and runic >= 60);
	end

	local shouldUseMarrowrend = buff[BL.BoneShield].count <= 6 or buff[BL.BoneShield].remains < 6;
	if shouldUseMarrowrend and runes >= 2 then
		return BL.Marrowrend;
	end

	local playerHp = MaxDps:TargetPercentHealth('player');
	if runic >= 45 and (buff[BL.BoneShield].remains < 3 or playerHp < 0.5) then
		return BL.DeathStrike;
	end

	if talents[BL.BloodDrinker] and cooldown[BL.BloodDrinker].ready then
		return BL.BloodDrinker;
	end

	if not debuff[BL.BloodPlague].up or cooldown[BL.BloodBoil].charges >= 2 then
		return BL.BloodBoil;
	end

	if shouldUseMarrowrend and runes >= 2 then
		return BL.Marrowrend;
	end

	if talents[BL.RuneStrike] and cooldown[BL.RuneStrike].charges >= 1.7 and runes <= 3 then
		return BL.RuneStrike;
	end

	local targets = MaxDps:TargetsInRange(49998);
	if runes >= 3 then
		if cooldown[BL.DeathAndDecay].ready and targets >= 3 then
			return BL.DeathAndDecay;
		end

		return BL.HeartStrike;
	end

	if buff[BL.CrimsonScourge].up or (cooldown[BL.DeathAndDecay].ready and targets > 5 and runes >= 1) then
		return BL.DeathAndDecay;
	end

	if runicMax - runic <= 20 then
		return BL.DeathStrike;
	end

	if runes > 2 then
		return BL.HeartStrike;
	end

	if runic >= 60 then
		return BL.DeathStrike;
	end

	if cooldown[BL.BloodBoil].charges >= 1 then
		return BL.BloodBoil;
	end

	return nil;
end