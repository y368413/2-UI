if select(2, UnitClass("player")) ~= "DEATHKNIGHT" then return end

local _, MaxDps_DeathKnightTable = ...;
local DeathKnight = MaxDps_DeathKnightTable.DeathKnight;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local RunicPower = Enum.PowerType.RunicPower;

local FR = {
	RemorselessWinter  = 196770,
	GatheringStorm     = 194912,
	HowlingBlast       = 49184,
	Rime               = 59052,
	FrostFever         = 55095,
	Obliterate         = 49020,
	KillingMachine     = 51124,
	EmpowerRuneWeapon  = 47568,
	HornOfWinter       = 57330,
	ChainsOfIce        = 45524,
	PillarOfFrost      = 51271,
	FrostStrike        = 49143,
	BreathOfSindragosa = 152279,
	Frostscythe        = 207230,
	FrostwyrmsFury     = 279302,
	MasteryFrozenHeart = 77514,
	Obliteration       = 281238,
	ColdHeart          = 281209,
	ColdHeartTalent    = 281208,
};


function DeathKnight:Frost()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, timeShift, talents, azerite, currentSpell =
	fd.cooldown, fd.buff, fd.debuff, fd.timeShift, fd.talents, fd.azerite, fd.currentSpell;

	local runic = UnitPower('player', RunicPower);
	local runicMax = UnitPowerMax('player', RunicPower);
	local runes, runeCd = DeathKnight:Runes(timeShift);
	local targets = MaxDps:SmartAoe();

	local fever = debuff[FR.FrostFever].remains > 6;
	local FSCost = 25;

	fd.targets = targets;

	MaxDps:GlowEssences();
	MaxDps:GlowCooldown(FR.BreathOfSindragosa, talents[FR.BreathOfSindragosa] and cooldown[FR.BreathOfSindragosa].ready);

	MaxDps:GlowCooldown(FR.FrostwyrmsFury, cooldown[FR.FrostwyrmsFury].ready);
	MaxDps:GlowCooldown(FR.PillarOfFrost, cooldown[FR.PillarOfFrost].ready);
	MaxDps:GlowCooldown(FR.EmpowerRuneWeapon, cooldown[FR.EmpowerRuneWeapon].ready and runes <= 1 and runic <= (runicMax - FSCost));

	if talents[FR.BreathOfSindragosa] then
		if buff[FR.BreathOfSindragosa].up then
			if talents[FR.GatheringStorm] and cooldown[FR.RemorselessWinter].ready and runes >= 1 then
				return FR.RemorselessWinter;
			end

			if runes >= 1 and (buff[FR.Rime].up or not fever) then
				return FR.HowlingBlast;
			end

			if talents[FR.Frostscythe] and runes >= 2 and targets >= 2 then
				return FR.Frostscythe;
			end

			if runes >= 2 then
				return FR.Obliterate;
			end

			if cooldown[FR.EmpowerRuneWeapon].ready and runic < 50 then
				return FR.EmpowerRuneWeapon;
			end

			if talents[FR.HornOfWinter] and cooldown[FR.HornOfWinter].ready
				and runes <= 3 and runic < 60
			then
				return FR.HornOfWinter;
			end
		else
			if talents[FR.ColdHeartTalent] and buff[FR.ColdHeart].count >= 20 and runes >= 1 then
				return FR.ChainsOfIce;
			end

			if talents[FR.GatheringStorm] and cooldown[FR.RemorselessWinter].ready and runes >= 1 then
				return FR.RemorselessWinter;
			end

			if buff[FR.Rime].up or (runes >= 1 and not fever) then
				return FR.HowlingBlast;
			end

			if talents[FR.Frostscythe] and runes >= 4 and targets >= 2 then
				return FR.Frostscythe;
			end

			if runes >= 4 then
				return FR.Obliterate;
			end

			if runic >= 90 then
				return FR.FrostStrike;
			end

			if talents[FR.Frostscythe] and buff[FR.KillingMachine].up and runes >= 2 and targets >= 2 then
				return FR.Frostscythe;
			end

			if buff[FR.KillingMachine].up and runes >= 2 then
				return FR.Obliterate;
			end

			if runic >= 80 then
				return FR.FrostStrike;
			end

			if talents[FR.Frostscythe] and runes >= 2 and targets >= 2 then
				return FR.Frostscythe;
			end

			if runes >= 2 then
				return FR.Obliterate;
			end

			if runic >= 25 then
				return FR.FrostStrike;
			end
		end

		return nil;
	else
		if buff[FR.PillarOfFrost].up then
			if cooldown[FR.RemorselessWinter].ready and runes >= 1 then
				return FR.RemorselessWinter;
			end

			if talents[FR.Frostscythe] and buff[FR.KillingMachine].up and runes >= 2 and targets >= 2 then
				return FR.Frostscythe;
			end

			if buff[FR.KillingMachine].up and runes >= 2 then
				return FR.Obliterate;
			end

			if (not buff[FR.Rime].up and runic >= 25) or runic > 90 then
				return FR.FrostStrike;
			end

			if runes >= 1 and (buff[FR.Rime].up or not fever) then
				return FR.HowlingBlast;
			end

			if not buff[FR.KillingMachine].up and runic >= 25 then
				return FR.FrostStrike;
			end

			if talents[FR.Frostscythe] and not buff[FR.KillingMachine].up and runes >= 2 and targets >= 2 then
				return FR.Frostscythe;
			end

			if not buff[FR.KillingMachine].up and runes >= 2 then
				return FR.Obliterate;
			end
		else
			if talents[FR.ColdHeartTalent] and buff[FR.ColdHeart].count >= 20 and runes >= 1 then
				return FR.ChainsOfIce;
			end

			if cooldown[FR.RemorselessWinter].ready and runes >= 1 then
				return FR.RemorselessWinter;
			end

			if runes >= 1 and buff[FR.Rime].up then
				return FR.HowlingBlast;
			end

			if talents[FR.Frostscythe] and  runes >= 4  and targets >= 2 then
				return FR.Frostscythe;
			end

			if runes >= 4 then
				return FR.Obliterate;
			end

			if runic >= 90 then
				return FR.FrostStrike;
			end

			if talents[FR.Frostscythe] and  buff[FR.KillingMachine].up and runes >= 2 and targets >= 2 then
				return FR.Frostscythe;
			end

			if buff[FR.KillingMachine].up and runes >= 2 then
				return FR.Obliterate;
			end

			if runic >= 75 then
				return FR.FrostStrike;
			end

			if talents[FR.Frostscythe] and runes >= 2 and targets >= 2 then
				return FR.Frostscythe;
			end

			if runes >= 2 then
				return FR.Obliterate;
			end

			if runic >= 25 then
				return FR.FrostStrike;
			end
		end

		return nil;
	end
end