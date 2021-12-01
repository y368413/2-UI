if select(2, UnitClass("player")) ~= "PALADIN" then return end

local _, MaxDps_PaladinTable = ...;
local Paladin = MaxDps_PaladinTable.Paladin;
local MaxDps = MaxDps;
local GetTotemInfo = GetTotemInfo;

local PR = {
	AvengingWrath            = 31884,
	Seraphim                 = 152262,
	ShieldOfTheRighteous     = 53600,
	ShieldOfTheRighteousAura = 132403,
	Consecration             = 26573,
	Judgment                 = 275779,
	CrusadersJudgment        = 204023,
	AvengersShield           = 31935,
	AvengersValor            = 197561,
	BlessedHammer            = 204019,
	BastionOfLight           = 204035,
	HammerOfTheRighteous     = 53595,
	HammerOfWrath            = 24275,
	WordOfGlory              = 85673,
	--Kyrian
	DivineToll = 304971,
	--Venthyr
	AshenHallow = 316958,
	--NightFae
	BlessingoftheSeasons = 328278,
	BlessingofSpring = 328282,
	BlessingofSummer = 328620,
	BlessingofAutumn = 328622,
	BlessingofWinter = 328281,
	--Necrolord
	VanquishersHammer = 328204,
};
local CN = {
	None      = 0,
	Kyrian    = 1,
	Venthyr   = 2,
	NightFae  = 3,
	Necrolord = 4
};

setmetatable(PR, Paladin.spellMeta);

function Paladin:Protection()
	local fd = MaxDps.FrameData;
    local covenantId = fd.covenant.covenantId;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local gcd = fd.gcd;
	local targetHp = MaxDps:TargetPercentHealth() * 100;
	local consecrationUp = GetTotemInfo(1);
	local holyPower = UnitPower('player', 9);

	Paladin:ProtectionCooldowns();

	if cooldown[PR.Consecration].ready and (not consecrationUp) then
		return PR.Consecration;
	end

    --kyrian
	if covenantId == CN.Kyrian and cooldown[PR.DivineToll].ready then
		return PR.DivineToll;
	end

    --necro
	if covenantId == CN.Necrolord and cooldown[PR.VanquishersHammer].ready then
		return PR.VanquishersHammer;
	end

	if cooldown[PR.Judgment].ready then
		return PR.Judgment;
	end

	if cooldown[PR.HammerOfWrath].ready and buff[PR.AvengingWrath].up then
		return PR.HammerOfWrath;
	end

	if cooldown[PR.HammerOfWrath].ready and targetHp <= 20 then
		return PR.HammerOfWrath;
	end

	if holyPower >= 3 and not buff[PR.ShieldOfTheRighteousAura].up then
		return PR.ShieldOfTheRighteous;
	end

	if holyPower == 5 then
		return PR.ShieldOfTheRighteous;
	end

	if cooldown[PR.AvengersShield].ready then
		return PR.AvengersShield;
	end

	if talents[PR.BlessedHammer] and cooldown[PR.BlessedHammer].ready then
		return PR.BlessedHammer;
	end

	if cooldown[PR.HammerOfTheRighteous].ready then
		return PR.HammerOfTheRighteous;
	end

	if cooldown[PR.Consecration].ready then
		return PR.Consecration;
	end
end

function Paladin:ProtectionCooldowns()
	local fd = MaxDps.FrameData;
	local covenantId = fd.covenant.covenantId;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local health = UnitHealth('player');
	local healthMax = UnitHealthMax('player');
	local healthPercent = (health / healthMax) * 100;
	local holyPower = UnitPower('player', 9);
	MaxDps:GlowEssences();

	if not buff[PR.ShieldOfTheRighteousAura].up and holyPower >= 3 then
		MaxDps:GlowCooldown(PR.ShieldOfTheRighteous);
	end

	if healthPercent <= 70 and holyPower > 2 then
		MaxDps:GlowCooldown(PR.WordOfGlory);
	end

	MaxDps:GlowCooldown(PR.AvengingWrath, cooldown[PR.AvengingWrath].ready);

	if talents[PR.Seraphim] then
		MaxDps:GlowCooldown(PR.Seraphim, cooldown[PR.Seraphim].ready);
	end

	if talents[PR.BastionOfLight] then
		MaxDps:GlowCooldown(PR.BastionOfLight, cooldown[PR.BastionOfLight].ready and (cooldown[PR.ShieldOfTheRighteous].charges <= 0.5));
	end

	--Venthyr
	if covenantId == CN.Venthyr and cooldown[PR.AshenHallow].ready then
		MaxDps:GlowCooldown(PR.AshenHallow, cooldown[PR.AshenHallow].ready);
	end

	--NightFae
	if covenantId == CN.NightFae and cooldown[PR.BlessingofSpring].ready then
		MaxDps:GlowCooldown(PR.BlessingofSpring, cooldown[PR.BlessingofSpring].ready);
	end

	if covenantId == CN.NightFae and cooldown[PR.BlessingofSummer].ready then
		MaxDps:GlowCooldown(PR.BlessingofSummer, cooldown[PR.BlessingofSummer].ready);
	end

	if covenantId == CN.NightFae and cooldown[PR.BlessingofAutumn].ready then
		MaxDps:GlowCooldown(PR.BlessingofAutumn, cooldown[PR.BlessingofAutumn].ready);
	end

	if covenantId == CN.NightFae and cooldown[PR.BlessingofWinter].ready then
		MaxDps:GlowCooldown(PR.BlessingofWinter, cooldown[PR.BlessingofWinter].ready);
	end
	
end
