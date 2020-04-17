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
local _RuneOfPower = 116011

function Mage:Arcane()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local currentSpell = fd.currentSpell;

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

	MaxDps:GlowEssences();

	-- image
	MaxDps:GlowCooldown(_MirrorImage, talents[_MirrorImage] and cooldown[_MirrorImage].ready);

	local burnCond = cooldown[_ArcanePower].ready and arcaneCharge >= 4 and
		(ropCharges >= 1 or not talents[_RuneOfPower]) and
		((talents[_Overpowered] and manaPct > 0.3) or manaPct > 0.5);

	MaxDps:GlowCooldown(_ArcanePower, burnCond);

	-- burn
	if cooldown[_Evocation].ready then

		if manaPct < 0.05 then
			return _Evocation;
		end

		if talents[_ChargedUp] and cooldown[_ChargedUp].ready and arcaneCharge <= 1 then
			return _ChargedUp;
		end

		if talents[_ArcaneOrb] and cooldown[_ArcaneOrb].ready and arcaneCharge < 4 then
			return _ArcaneOrb;
		end

		if talents[_NetherTempest] and not buff[_ArcanePower].up and not rop and debuff[_NetherTempest].refreshable
			and arcaneCharge >= 4 then
			return _NetherTempest;
		end

		if talents[_RuleofThrees] and talents[_Overpowered] and buff[_RuleofThrees].up and
			currentSpell ~= _ArcaneBlast then
			return _ArcaneBlast;
		end

		if talents[_RuneOfPower] and ropCharges > 1.6 and currentSpell ~= _RuneOfPower then
			return _RuneOfPower;
		end

		if cooldown[_PresenceofMind].ready and buff[_ArcanePower].remains < 2 and not buff[_PresenceofMind].up then
			return _PresenceofMind;
		end

		local cc = buff[_Clearcasting].up;
		local am = cooldown[_ArcaneMissiles].ready;

		if talents[_Amplification] and cc and am and currentSpell ~= _ArcaneMissiles then
			return _ArcaneMissiles;
		end

		if am and cc and not buff[_ArcanePower].up and manaPct < 0.95 and currentSpell ~= _ArcaneMissiles then
			return _ArcaneMissiles;
		end

		return _ArcaneBlast;
	end

	if talents[_ChargedUp] and cooldown[_ChargedUp].ready and arcaneCharge == 0 then
		return _ChargedUp;
	end

	if talents[_NetherTempest] and debuff[_NetherTempest].refreshable and arcaneCharge >= 4 then
		return _NetherTempest;
	end

	if talents[_ArcaneOrb] and cooldown[_ArcaneOrb].ready and arcaneCharge < 4 then
		return _ArcaneOrb;
	end

	if talents[_RuneOfPower] and ropCharges > 1.8 and currentSpell ~= _RuneOfPower then
		return _RuneOfPower;
	end

	if talents[_RuleofThrees] and buff[_RuleofThrees].up then
		return _ArcaneBlast;
	end

	if buff[_Clearcasting].up and cooldown[_ArcaneMissiles].ready and
		currentSpell ~= _ArcaneMissiles
	then
		return _ArcaneMissiles;
	end

	if manaPct < 0.6 and arcaneCharge >= 4 then
		return _ArcaneBarrage;
	end

	if talents[_Supernova] and cooldown[_Supernova].ready then
		return _Supernova;
	end

	return _ArcaneBlast;
end