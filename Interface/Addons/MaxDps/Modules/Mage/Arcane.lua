if select(2, UnitClass("player")) ~= "MAGE" then return end

local _, MaxDps_MageTable = ...;
local Mage = MaxDps_MageTable.Mage;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local Mana = Enum.PowerType.Mana;
local ArcaneCharges = Enum.PowerType.ArcaneCharges;

local Arc = {
	RuneofPower = 116011,
	RuneofPowerAura = 116014,
	ArcaneOrb = 153626,
	Evocation = 12051,
	ArcanePower = 12042,
	TouchoftheMagi = 321507,
	ArcaneBarrage = 44425,
	NetherTempest = 114923,
	PresenceofMind = 205025,
	ArcaneBlast = 30451,
	ArcaneMissiles = 5143,
	Clearcasting = 263725,
	ArcaneExplosion = 1449,
	AlterTime = 342245,
	Enlightened = 321387,
	Resonance = 205028,
	ArcaneFamiliar = 205022,
	ArcaneEcho = 342231,
	ArcaneFamiliarAura = 210126,
	TouchoftheMagiDebuff = 210824
};

function Mage:Arcane()
	local fd = MaxDps.FrameData;

	local cooldowns = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local playerTargetString = 'player';
	local mana = UnitPower(playerTargetString, Mana)
	local maxMana = UnitPowerMax(playerTargetString, Mana);
	local currentArcaneCharges = UnitPower(playerTargetString, ArcaneCharges);
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();

	fd.targets = targets;

	MaxDps:GlowEssences();

	-- talents
	local arcaneEchoTalent = talents[Arc.ArcaneEcho];
	local arcaneOrbTalent = talents[Arc.ArcaneOrb];
	local runeOfPowerTalent = talents[Arc.RuneofPower];

	-- resources
	local manaPercentage = mana / maxMana;

	--procs
	local clearCasting = buff[Arc.Clearcasting].up;

	--status
	local arcaneMissilesReady = cooldowns[Arc.ArcaneMissiles].ready;
	local touchOfMagiDebuff = debuff[Arc.TouchoftheMagiDebuff].up;
	local arcanePowerBurn = buff[Arc.ArcanePower].up;
	local runeOfPowerReady = cooldowns[Arc.RuneofPower].ready;
	local runeOfPowerBuff = buff[Arc.RuneofPowerAura].up
	local arcaneOrbReady = cooldowns[Arc.ArcaneOrb].ready;

	if touchOfMagiDebuff then
		-- todo: arcane orb function
		if arcaneOrbTalent and arcaneOrbReady and currentArcaneCharges < 4 then
			return Arc.ArcaneOrb;
		end

		if runeOfPowerTalent and runeOfPowerReady and not runeOfPowerBuff then
			return Arc.RuneofPower;
		end

		if targets >= 3 then
			if currentArcaneCharges == 4 then
				return Arc.ArcaneBarrage;
			else
				return Arc.ArcaneExplosion;
			end
		end

		if arcanePowerBurn and cooldowns[Arc.PresenceofMind].ready and buff[Arc.ArcanePower].remains <= 2 then
			return Arc.PresenceofMind;
		end

		if arcaneEchoTalent and arcaneMissilesReady then
			return Arc.ArcaneMissiles;
		end

	end

	if targets >= 3 then
		if currentArcaneCharges == 4 then
			return Arc.ArcaneBarrage;
		else
			return Arc.ArcaneExplosion;
		end
	end

	if clearCasting and arcaneMissilesReady and currentSpell ~= Arc.ArcaneMissiles then
		return Arc.ArcaneMissiles;
	end

	-- arcane orb function
	if arcaneOrbTalent and arcaneOrbReady and currentArcaneCharges < 4 then
		return Arc.ArcaneOrb;
	end

	if cooldowns[Arc.Evocation].ready and manaPercentage < 0.1 then
		return Arc.Evocation;
	end

	if currentArcaneCharges == 4 and not arcanePowerBurn and not touchOfMagiDebuff and not runeOfPowerBuff then
		return Arc.ArcaneBarrage;
	end

	if manaPercentage < 0.1 then
		return Arc.ArcaneBarrage;
	end

	return Arc.ArcaneBlast;
end