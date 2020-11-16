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
};

setmetatable(PR, Paladin.spellMeta);

function Paladin:Protection()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local gcd = fd.gcd;
	local targetHp = MaxDps:TargetPercentHealth() * 100;
	local consecrationUp = GetTotemInfo(1);

	Paladin:ProtectionCooldowns();

	if cooldown[PR.Consecration].ready and (not consecrationUp) then
		return PR.Consecration;
	end

	if cooldown[PR.Judgment].ready then
		return PR.Judgment;
	end

	if cooldown[PR.HammerOfWrath].ready and targetHp <= 20 then
		return PR.HammerOfWrath;
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
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local health = UnitHealth('player');
	local healthMax = UnitHealthMax('player');
	local healthPercent = (health / healthMax) * 100;
	local holyPower = UnitPower('player', 9);
	MaxDps:GlowEssences();

	if not buff[PR.ShieldOfTheRighteousAura].up and holyPower == 5 then
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
end
