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
};

setmetatable(PR, Paladin.spellMeta);

function Paladin:Protection()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local gcd = fd.gcd;

	local consecrationUp = GetTotemInfo(1);
	-- call_action_list,name=cooldowns;

	Paladin:ProtectionCooldowns();

	-- consecration,if=!consecration.up;
	if cooldown[PR.Consecration].ready and (not consecrationUp) then
		return PR.Consecration;
	end

	-- judgment,if=(cooldown.judgment.remains<gcd&cooldown.judgment.charges_fractional>1&cooldown_react)|!talent.crusaders_judgment.enabled;
	if (cooldown[PR.Judgment].remains < gcd and cooldown[PR.Judgment].charges > 1) or
		not talents[PR.CrusadersJudgment] and cooldown[PR.Judgment].ready
	then
		return PR.Judgment;
	end

	-- avengers_shield,if=cooldown_react;
	if cooldown[PR.AvengersShield].ready then
		return PR.AvengersShield;
	end

	-- judgment,if=cooldown_react|!talent.crusaders_judgment.enabled;
	if not talents[PR.CrusadersJudgment] and cooldown[PR.Judgment].ready then
		return PR.Judgment;
	end

	-- blessed_hammer,strikes=2;
	if talents[PR.BlessedHammer] and cooldown[PR.BlessedHammer].ready then
		return PR.BlessedHammer;
	end

	-- hammer_of_the_righteous;
	if cooldown[PR.HammerOfTheRighteous].ready then
		return PR.HammerOfTheRighteous;
	end

	-- consecration;
	if cooldown[PR.Consecration].ready then
		return PR.Consecration;
	end
end

function Paladin:ProtectionCooldowns()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;

	MaxDps:GlowEssences();

	-- avenging_wrath;
	MaxDps:GlowCooldown(PR.AvengingWrath, cooldown[PR.AvengingWrath].ready);
	MaxDps:GlowCooldown(PR.ShieldOfTheRighteous, cooldown[PR.ShieldOfTheRighteous].ready and not buff[PR.ShieldOfTheRighteousAura].up);

	-- seraphim;
	if talents[PR.Seraphim] then
		MaxDps:GlowCooldown(PR.Seraphim, cooldown[PR.Seraphim].ready);
	end

	if talents[PR.BastionOfLight] then
		MaxDps:GlowCooldown(PR.BastionOfLight, cooldown[PR.BastionOfLight].ready and (cooldown[PR.ShieldOfTheRighteous].charges <= 0.5));
	end
end
