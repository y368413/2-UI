if select(2, UnitClass("player")) ~= "DEMONHUNTER" then return end
local _, MaxDps_DemonHunterTable = ...;

--- @type MaxDps
if not MaxDps then return end

local DemonHunter = MaxDps_DemonHunterTable.DemonHunter;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;

local VG = {
	FelDevastation     = 212084,
	SpiritBomb         = 247454,
	Fracture           = 263642,
	ImmolationAura     = 258920,
	ThrowGlaive        = 204157,
	SigilOfFlame       = 204596,
	SoulCleave         = 228477,
	--untested
	SoulCleave         = 228477,
	CharredFlesh       = 264002,
	ConcentratedSigils = 207666,
	SoF                = 204513,
	Metamorphosis      = 187827,
	Felblade           = 232893,
	Shear              = 203782,
	SoulFragments      = 203981,
	ImmolationAura     = 258920,
	FieryBrand         = 204021,
	DemonSpikes        = 203720,
	DemonSpikesAura    = 203819,
	SoulBarrier        = 263648,
	InfernalStrike     = 189110,
};

setmetatable(VG, DemonHunter.spellMeta);

function DemonHunter:Vengeance()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local fury = UnitPower('player', Enum.PowerType.Fury);
	local soulFragments = buff[VG.SoulFragments].count;

	MaxDps:GlowEssences();
	MaxDps:GlowCooldown(VG.Metamorphosis, cooldown[VG.Metamorphosis].ready);

	if fury >= 50 and cooldown[VG.FelDevastation].ready then
		return VG.FelDevastation;
	end

	if soulFragments >= 5 and fury >= 30 and talents[VG.SpiritBomb] then
		return VG.SpiritBomb;
	end

	if cooldown[VG.ImmolationAura].ready and fury < 80 then
		return VG.ImmolationAura;
	end

	if talents[VG.Fracture] and soulFragments <= 3 and fury <= 75 and cooldown[VG.Fracture].ready then
		return VG.Fracture;
	end

	if talents[VG.Fracture] and cooldown[VG.Fracture].charges > 1.8 then
		return VG.Fracture;
	end

	if cooldown[VG.SoulCleave].ready and fury >= 30 then
		return VG.SoulCleave;
	end

	if talents[VG.ConcentratedSigils] then
		return VG.SoF;
	else
		if cooldown[VG.SigilOfFlame].ready then
			return VG.SigilOfFlame;
		end
	end

	if not talents[VG.Fracture] and soulFragments <= 4 and fury <= 90 then
		return VG.Shear;
	end

	return VG.ThrowGlaive;
end
