if select(2, UnitClass("player")) ~= "DEATHKNIGHT" then return end

local _, MaxDps_DeathKnightTable = ...;
local DeathKnight = MaxDps_DeathKnightTable.DeathKnight;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local RunicPower = Enum.PowerType.RunicPower;

local FR = {
	RemorselessWinter  = 196770,
	DeathAndDecay	   = 43265,
	SacrificialPact    = 327574,
	RaiseDead          = 46585,
	GatheringStorm     = 194912,
	HowlingBlast       = 49184,
	Rime               = 59052,
	FrostFever         = 55095,
	Obliterate         = 49020,
	KillingMachine     = 51128,
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
	IcyTalons          = 194879,
	IcyTalonsTalent    = 22017,
	FrozenPulse        = 22523,
	GlacialAdvance     = 194913
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
	--BoS only glows when it is at its most efficient point of being used...above 60 runic power
	MaxDps:GlowCooldown(FR.BreathOfSindragosa, talents[FR.BreathOfSindragosa] and cooldown[FR.BreathOfSindragosa].ready and runic >= 60 and runes <= 1);

	MaxDps:GlowCooldown(FR.FrostwyrmsFury, cooldown[FR.FrostwyrmsFury].ready);

	--Pillar of Frost glows when off cooldown unless Obliteration talent is taken and it glows when you have 2 runes and a runic using ability for efficiency of CD
	MaxDps:GlowCooldown(FR.PillarOfFrost, cooldown[FR.PillarOfFrost].ready and not talents[FR.Obliteration]);
	MaxDps:GlowCooldown(FR.PillarOfFrost, talents[FR.Obliteration] and runes >= 2 and (runic >= 25 or buff[FR.Rime].up));
	MaxDps:GlowCooldown(FR.EmpowerRuneWeapon, cooldown[FR.EmpowerRuneWeapon].ready and runes <= 1 and runic <= (runicMax - FSCost));


	-- Basic On CD Abilities to cast throughout all talent specs

	if cooldown[FR.RaiseDead].ready then
		return FR.RaiseDead
	end

	--if targets >= 6 and cooldown[FR.SacrificialPact].ready and not cooldown[FR.RaiseDead] then
	--	return FR.SacrificialPact
	--end

	if (targets >= 2 or (talents[FR.GatheringStorm])) and cooldown[FR.RemorselessWinter].ready then
		return FR.RemorselessWinter
	end

	if talents[FR.ColdHeartTalent] and buff[FR.ColdHeart].count >= 20 and runes >= 1 and not buff[FR.BreathOfSindragosa].up then
		return FR.ChainsOfIce;
	end

	-- If Breath of Sindragosa is chosen
	if talents[FR.BreathOfSindragosa] then
		-- If Breath of Sindragosa is up
		if buff[FR.BreathOfSindragosa].up then
			--Single Target
			if targets < 2 then

				if runic < 30 then
					return FR.Obliterate
				end

				if (targets >= 2 or (talents[FR.GatheringStorm])) and cooldown[FR.RemorselessWinter].ready then
					return FR.RemorselessWinter
				end

				if runes >= 1 and (buff[FR.Rime].up or not fever) then
					return FR.HowlingBlast;
				end

				if runes >= 5 or runic < 45 then
					return FR.Obliterate
				end

				if cooldown[FR.RemorselessWinter].ready then
					return FR.RemorselessWinter
				end

				if runic < 73 then
					return FR.Obliterate
				end

				--AoE / Cleave
			else

				if runic < 30 then
					return FR.Frostscythe
				end

				if (targets >= 2 or (talents[FR.GatheringStorm])) and cooldown[FR.RemorselessWinter].ready then
					return FR.RemorselessWinter
				end

				if runes >= 1 and (buff[FR.Rime].up or not fever) then
					return FR.HowlingBlast;
				end

				if runes >= 5 or runic < 45 then
					return FR.Frostscythe
				end

				if cooldown[FR.RemorselessWinter].ready then
					return FR.RemorselessWinter
				end

				if runic < 73 then
					return FR.Frostscythe
				end
			end
			return nil

			-- If Breath of Sindragosa is not active
		else
			--Single Target
			if targets < 2 then


				if talents[FR.IcyTalonsTalent] and buff[FR.IcyTalons].remains < 2 and runic >= 25 then
					return FR.FrostStrike
				end

				if runes >= 1 and (buff[FR.Rime].up or not fever) then
					return FR.HowlingBlast;
				end

				if talents[FR.FrozenPulse] and runes >= 2 then
					return FR.Obliterate
				end

				if runic >= 73 then
					return FR.FrostStrike
				end

				if talents[FR.Frostscythe] and buff[FR.KillingMachine].up and runes >= 1 then
					return FR.Frostscythe
				elseif buff[FR.KillingMachine] and runes >= 4 then
					return FR.Obliterate
				end

				if runes >= 2 then
					return FR.Obliterate
				end

				if runic >= 25 then
					return FR.FrostStrike
				end

				--AoE / Cleave
			else
				if talents[FR.IcyTalonsTalent] and buff[FR.IcyTalons].remains < 2 then
					if talents[FR.GlacialAdvance] and cooldown[FR.GlacialAdvance].ready and runic > 30 then
						return FR.GlacialAdvance
					elseif runic >= 25 then
						return FR.FrostStrike
					end

				end

				if runes >= 1 and (buff[FR.Rime].up or not fever) then
					return FR.HowlingBlast;
				end

				if talents[FR.Frostscythe] and buff[FR.KillingMachine].up then
					return FR.Frostscythe
				end

				if cooldown[FR.DeathAndDecay].ready and runes >= 1 then
					return FR.DeathAndDecay
				end

				if talents[FR.Frostscythe] and runic < 73 then
					return FR.Frostscythe
				end

				if runes >= 2 and runic < 73 then
					return FR.Obliterate
				end

				if talents[FR.GlacialAdvance] and cooldown[FR.GlacialAdvance].ready and runic >= 90 then
					return FR.GlacialAdvance
				end

				if runic >= 73 then
					return FR.FrostStrike
				end
			end


			return nil

		end

		-- If Obliteration is chosen
	elseif talents[FR.Obliteration] then
		--If Pillar of Frost CD is up
		if buff[FR.PillarOfFrost].up then
			if talents[FR.GatheringStorm] and cooldown[FR.RemorselessWinter].ready then
				return FR.RemorselessWinter
			end

			if targets >= 2 and cooldown[FR.DeathAndDecay].ready then
				return FR.DeathAndDecay
			end

			if buff[FR.KillingMachine].up then
				if runes >= 2 and targets < 2 then
					return FR.Obliterate
				elseif targets >= 2 and talents[FR.Frostscythe] and runes >= 1 then
					return FR.Frostscythe
				elseif runes >=2 then
					return FR.Obliterate
				end
			end

			if targets >= 2 and talents[FR.GlacialAdvance] and cooldown[FR.GlacialAdvance].ready and runic >= 30 then
				return FR.GlacialAdvance
			end

			if not buff[FR.KillingMachine].up or runic >= 73 then
				return FR.FrostStrike
			end

			if runes >= 1 and (buff[FR.Rime].up) then
				return FR.HowlingBlast
			end



			if runes >= 2 then
				return FR.Obliterate
			end

			--If Pillar of Frost CD is down
		else
			-- Single Target
			if targets < 2 then
				if talents[FR.IcyTalonsTalent] and buff[FR.IcyTalons].remains < 2 and runic >= 25 then
					return FR.FrostStrike
				end

				if runes >= 1 and (buff[FR.Rime].up or not fever) then
					return FR.HowlingBlast;
				end

				if talents[FR.FrozenPulse] and runes >= 2 then
					return FR.Obliterate
				end

				if runic >= 73 then
					return FR.FrostStrike
				end

				if talents[FR.Frostscythe] and buff[FR.KillingMachine].up and runes >= 1 then
					return FR.Frostscythe
				elseif buff[FR.KillingMachine] and runes >= 4 then
					return FR.Obliterate
				end

				if runes >= 2 then
					return FR.Obliterate
				end

				if runic >= 25 then
					return FR.FrostStrike
				end
				-- AoE / Cleave
			else
				if talents[FR.IcyTalonsTalent] and buff[FR.IcyTalons].remains < 2 then
					if talents[FR.GlacialAdvance] and runic > 30 then
						return FR.GlacialAdvance
					elseif runic >= 25 then
						return FR.FrostStrike
					end

				end

				if runes >= 1 and (buff[FR.Rime].up or not fever) then
					return FR.HowlingBlast;
				end

				if talents[FR.Frostscythe] and buff[FR.KillingMachine].up then
					return FR.Frostscythe
				end

				if cooldown[FR.DeathAndDecay].ready and runes >= 1 then
					return FR.DeathAndDecay
				end

				if talents[FR.Frostscythe] and runic < 73 then
					return FR.Frostscythe
				end

				if runes >= 2 and runic < 73 then
					return FR.Obliterate
				end

				if talents[FR.GlacialAdvance] and runic >= 90 then
					return FR.GlacialAdvance
				end

				if runic >= 73 then
					return FR.FrostStrike
				end
			end
		end
		return nil
		-- If Ice Cap or no level 50 talent is chosen
	else
		--Single Target
		if targets < 2 then
			if targets < 2 then
				if talents[FR.IcyTalonsTalent] and buff[FR.IcyTalons].remains < 2 and runic >= 25 then
					return FR.FrostStrike
				end

				if runes >= 1 and (buff[FR.Rime].up or not fever) then
					return FR.HowlingBlast;
				end

				if talents[FR.FrozenPulse] and runes >= 2 then
					return FR.Obliterate
				end

				if runic >= 73 then
					return FR.FrostStrike
				end

				if talents[FR.Frostscythe] and buff[FR.KillingMachine].up and runes >= 1 then
					return FR.Frostscythe
				elseif buff[FR.KillingMachine] and runes >= 4 then
					return FR.Obliterate
				end

				if runes >= 2 then
					return FR.Obliterate
				end

				if runic >= 25 then
					return FR.FrostStrike
				end
				--AoE Cleave
			else
				if talents[FR.IcyTalonsTalent] and buff[FR.IcyTalons].remains < 2 then
					if talents[FR.GlacialAdvance] and runic > 30 then
						return FR.GlacialAdvance
					elseif runic >= 25 then
						return FR.FrostStrike
					end

				end

				if runes >= 1 and (buff[FR.Rime].up or not fever) then
					return FR.HowlingBlast;
				end

				if talents[FR.Frostscythe] and buff[FR.KillingMachine].up then
					return FR.Frostscythe
				end

				if cooldown[FR.DeathAndDecay].ready and runes >= 1 then
					return FR.DeathAndDecay
				end

				if talents[FR.Frostscythe] and runic < 73 then
					return FR.Frostscythe
				end

				if runes >= 2 and runic < 73 then
					return FR.Obliterate
				end

				if talents[FR.GlacialAdvance] and runic >= 90 then
					return FR.GlacialAdvance
				end

				if runic >= 73 then
					return FR.FrostStrike
				end
			end
			return nil
		end
	end
end