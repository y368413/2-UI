if select(2, UnitClass("player")) ~= "PALADIN" then return end

local _, MaxDps_PaladinTable = ...;
local Paladin = MaxDps_PaladinTable.Paladin;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local HolyPower = Enum.PowerType.HolyPower;
local RT = {
	Rebuke            = 96231,
	ShieldOfVengeance = 184662,
	AvengingWrath     = 31884,
	Inquisition       = 84963,
	Crusade           = 231895,
	ExecutionSentence = 343527,
	ESTalent 		  = 23467,
	DivineStorm       = 53385,
	DivinePurpose     = 223817,
	TemplarsVerdict   = 85256,
	HammerOfWrath     = 24275,
	WakeOfAshes       = 255937,
	BladeOfJustice    = 184575,
	Judgment          = 20271,
	JudgmentAura      = 197277,
	Consecration      = 26573,
	CrusaderStrike    = 35395,
	DivineRight       = 277678,
	RighteousVerdict  = 267610,
	EmpyreanPower     = 326732,
	HolyAvenger       = 105809,
	Seraphim		  = 152262,
	FinalReckoning	  = 343721,
	SelflessHealer	  = 85804,
	FlashOfLight      = 19750,
};
setmetatable(RT, Paladin.spellMeta);

function Paladin:Retribution()
	local fd = MaxDps.FrameData;
	fd.targets = MaxDps:SmartAoe();
	local holyPower = UnitPower('player', HolyPower);
	fd.holyPower = holyPower;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local gcd = fd.gcd;
	local targetHp = MaxDps:TargetPercentHealth() * 100;
	local health = UnitHealth('player');
	local healthMax = UnitHealthMax('player');
	local healthPercent = ( health / healthMax ) * 100;

	-- Essences
	MaxDps:GlowEssences();

	-- Cooldowns
	MaxDps:GlowCooldown(RT.FlashOfLight, talents[RT.SelflessHealer] and buff[RT.SelflessHealer].count > 3 and healthPercent < 80);

	if talents[RT.Crusade] then
		MaxDps:GlowCooldown(RT.Crusade, cooldown[RT.Crusade].ready);
	else MaxDps:GlowCooldown(RT.AvengingWrath, cooldown[RT.AvengingWrath].ready);
	end

	if talents[RT.FinalReckoning] and holyPower >=3 then
		MaxDps:GlowCooldown(RT.FinalReckoning, cooldown[RT.FinalReckoning].ready);
	end

	if talents[RT.HolyAvenger] then
		MaxDps:GlowCooldown(RT.HolyAvenger, cooldown[RT.HolyAvenger].ready);
	end

	--- Spenders
	if talents[RT.Seraphim] and cooldown[RT.Seraphim].ready and holyPower >=3 then
		return RT.Seraphim;
	end

	if talents[RT.ExecutionSentence] and holyPower >= 3 and cooldown[RT.ExecutionSentence].ready then
		return RT.ExecutionSentence;
	end

	if holyPower >= 3 and targets <= 2 then
		return RT.TemplarsVerdict;
	elseif buff[RT.DivinePurpose].up then
		return RT.TemplarsVerdict;
	end

	if holyPower >= 3 and targets >= 3 then
		return RT.DivineStorm;
	end
	-- Generators
	if cooldown[RT.WakeOfAshes].ready and holyPower <= 2 then
		return RT.WakeOfAshes;
	end

	if cooldown[RT.BladeOfJustice].ready then
		return RT.BladeOfJustice;
	end

	if targetHp <= 20 and cooldown[RT.HammerOfWrath].ready then
		return RT.HammerOfWrath;
	end

	if cooldown[RT.Judgment].ready then
		return RT.Judgment;
	end

	if cooldown[RT.CrusaderStrike].ready then
		return RT.CrusaderStrike;
	end

	if cooldown[RT.Consecration].ready then
		return RT.Consecration;
	end
end
