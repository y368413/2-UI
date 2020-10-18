if select(2, UnitClass("player")) ~= "MAGE" then return end

local _, MaxDps_MageTable = ...;
local Mage = MaxDps_MageTable.Mage;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local Mana = Enum.PowerType.Mana;
local ArcaneCharges = Enum.PowerType.ArcaneCharges;

local _Evocation = 12051;
local _ArcanePower = 12042;
local _Overpowered = 155147;
local _ArcaneOrb = 153626;
local _NetherTempest = 114923;
local _ArcaneBlast = 30451;
local _RuleofThrees = 264774;
local _RuleofThreesTalent = 264354;
local _PresenceofMind = 205025;
local _ArcaneBarrage = 44425;
local _ArcaneExplosion = 1449;
local _ArcaneMissiles = 5143;
local _Clearcasting = 263725;
local _Amplification = 236628;
local _ChargedUp = 205032;
local _Supernova = 157980;
local _DrainSoul = 198590;
local _Resonance = 205028;
local _Displacement = 195676;

local _MirrorImage = 55342;
local _RuneOfPower = 116011;
local _RuneOfPowerBuff = 116014;

local _Equipoise = 286027;

function Mage:Arcane()
	local fd = MaxDps.FrameData;
	local azerite = fd.azerite;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local currentSpell = fd.currentSpell;
	local targets = MaxDps:SmartAoe();

	fd.targets = targets;

	-- Ressource
	local arcaneCharge = UnitPower('player', ArcaneCharges);
	local mana = UnitPower('player', Mana);
	local maxMana = UnitPowerMax('player', Mana);
	local manaPct = mana / maxMana;

	if currentSpell == _ArcaneBlast then
		arcaneCharge = arcaneCharge + 1;
	end

	local rop = buff[_RuneOfPower].up;
	local ropCharges = cooldown[_RuneOfPower].charges;

	local cc = buff[_Clearcasting].up;
	local am = cooldown[_ArcaneMissiles].ready;

	MaxDps:GlowEssences();

	-- image
	MaxDps:GlowCooldown(_MirrorImage, talents[_MirrorImage] and cooldown[_MirrorImage].ready);

	local burnCond = (cooldown[_ArcanePower].ready and arcaneCharge >= 4 and
		(ropCharges >= 1 or not talents[_RuneOfPower] or buff[_RuneOfPowerBuff].up or currentSpell == _RuneOfPower) and
		((talents[_Overpowered] and manaPct > 0.3) or manaPct > 0.5) or buff[_ArcanePower].up);

	if buff[_ArcanePower].up or buff[_RuneOfPowerBuff].up then
		return Mage:ArcaneBurn();
	end

	if talents[_RuleofThreesTalent] and buff[_RuleofThrees].up and
		currentSpell ~= _ArcaneBlast then
		return _ArcaneBlast;
	end

	if talents[_ChargedUp] and cooldown[_ChargedUp].ready and arcaneCharge == 0 and targets < 3 then
		return _ChargedUp;
	end

	if talents[_ArcaneOrb] and cooldown[_ArcaneOrb].ready and arcaneCharge < 4 then
		return _ArcaneOrb;
	end

	if buff[_Clearcasting].up and cooldown[_ArcaneMissiles].ready and targets < 3 then
		return _ArcaneMissiles;
	end

	if targets >= 3 and arcaneCharge >= 4 then
		return _ArcaneBarrage;
	end

	if manaPct < 0.05 then
		return _Evocation;
	end

	if targets >= 3 then
		return _ArcaneExplosion;
	end

	if ((manaPct < 0.6 and azerite[_Equipoise] == 0) or (manaPct < 0.8 and azerite[_Equipoise] >= 1)) and arcaneCharge >= 4 then
		return _ArcaneBarrage;
	end

	return _ArcaneBlast;
end

function Mage:ArcaneBurn()
	local fd = MaxDps.FrameData;
	local azerite = fd.azerite;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local currentSpell = fd.currentSpell;
	local targets = MaxDps:SmartAoe();

	fd.targets = targets;

	-- Ressource
	local arcaneCharge = UnitPower('player', ArcaneCharges);
	local mana = UnitPower('player', Mana);
	local maxMana = UnitPowerMax('player', Mana);
	local manaPct = mana / maxMana;

	if currentSpell == _ArcaneBlast then
		arcaneCharge = arcaneCharge + 1;
	end

	local rop = buff[_RuneOfPower].up;
	local ropCharges = cooldown[_RuneOfPower].charges;

	local cc = buff[_Clearcasting].up;
	local am = cooldown[_ArcaneMissiles].ready;

	if talents[_ChargedUp] and cooldown[_ChargedUp].ready and arcaneCharge <= 1 and targets < 3 then
		return _ChargedUp;
	end

	if cooldown[_ArcanePower].ready and not buff[_ArcanePower].up then
		return _ArcanePower;
	end

	if manaPct < 0.05 then
		return _Evocation;
	end

	if talents[_ArcaneOrb] and cooldown[_ArcaneOrb].ready and arcaneCharge < 4 then
		return _ArcaneOrb;
	end

	if talents[_RuleofThreesTalent] and buff[_RuleofThrees].up and talents[_Overpowered] and
		currentSpell ~= _ArcaneBlast then
		return _ArcaneBlast;
	end

	if targets >= 3 and arcaneCharge >= 4 then
		return _ArcaneBarrage;
	end

	if targets >= 3 then
		return _ArcaneExplosion;
	end

	if am and cc and manaPct < 0.95 and targets < 3 and not buff[_ArcanePower].up then
		return _ArcaneMissiles;
	end

	if cooldown[_PresenceofMind].ready and buff[_ArcanePower].remains < 1.5 and not buff[_PresenceofMind].up and
		buff[_ArcanePower].up and currentSpell ~= _ArcaneBlast and targets < 3 then
		return _PresenceofMind;
	end

	return _ArcaneBlast;
end