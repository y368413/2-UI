if select(2, UnitClass("player")) ~= "DEMONHUNTER" then return end
local _, MaxDps_DemonHunterTable = ...;

--- @type MaxDps
if not MaxDps then return end

local DemonHunter = MaxDps_DemonHunterTable.DemonHunter;
local MaxDps = MaxDps;

local VG = {
	SoulCleave         = 228477,
	CharredFlesh       = 264002,
	ConcentratedSigils = 207666,
	FelDevastation     = 212084,
	Metamorphosis      = 187827,
	SpiritBomb         = 247454,
	Felblade           = 232893,
	Fracture           = 263642,
	Shear              = 203782,
	ThrowGlaive        = 204157,
	SoulFragments      = 203981,
	ImmolationAura     = 178740,
	SigilOfFlame       = 204596,
	SigilOfFlame2      = 204513,
	FieryBrand         = 204021,
	DemonSpikes        = 203720,
	DemonSpikesAura    = 203819,
	SoulBarrier        = 263648,
	InfernalStrike	   = 189110,
};

setmetatable(VG, DemonHunter.spellMeta);


function DemonHunter:Vengeance()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, timeShift, talents, azerite =
	fd.cooldown, fd.buff, fd.debuff, fd.timeShift, fd.talents, fd.azerite;
	local currentSpell = fd.currentSpell;
	local pain = UnitPower('player', Enum.PowerType.Pain);
	local soulFragments = buff[VG.SoulFragments].count;
	local SigilOfFlame = talents[VG.ConcentratedSigils] and VG.SigilOfFlame2 or VG.SigilOfFlame;

	MaxDps:GlowEssences();
	MaxDps:GlowCooldown(VG.Metamorphosis, cooldown[VG.Metamorphosis].ready);
	MaxDps:GlowCooldown(VG.DemonSpikes, cooldown[VG.DemonSpikes].ready and not buff[VG.DemonSpikesAura].up);
	MaxDps:GlowCooldown(VG.FieryBrand, cooldown[VG.FieryBrand].ready);
	MaxDps:GlowCooldown(VG.InfernalStrike, cooldown[VG.InfernalStrike].ready);

	if talents[VG.SoulBarrier] then
		MaxDps:GlowCooldown(VG.SoulBarrier, cooldown[VG.SoulBarrier].ready);
	end

	if talents[VG.CharredFlesh] then
		local result = DemonHunter:VengeanceBrand();
		if result then return result; end
	end

	--- SIMC
	-- spirit_bomb,if=soul_fragments>=4;
	if talents[VG.SpiritBomb] and pain >= 30 and soulFragments >= 4 then
		return VG.SpiritBomb;
	end

	-- soul_cleave,if=!talent.spirit_bomb.enabled;
	if not talents[VG.SpiritBomb] and pain >= 30 then
		return VG.SoulCleave;
	end

	-- soul_cleave,if=talent.spirit_bomb.enabled&soul_fragments=0;
	if talents[VG.SpiritBomb] and soulFragments == 0 and pain >= 30 then
		return VG.SoulCleave;
	end

	-- immolation_aura,if=pain<=90;
	if pain <= 90 and cooldown[VG.ImmolationAura].ready then
		return VG.ImmolationAura;
	end
	
	-- fel_devastation;
	if talents[VG.FelDevastation] and cooldown[VG.FelDevastation].ready and currentSpell ~= VG.FelDevastation then
		return VG.FelDevastation;
	end

	-- sigil_of_flame;
	if cooldown[SigilOfFlame].ready then
		return SigilOfFlame;
	end

	-- felblade,if=pain<=70;
	if talents[VG.Felblade] and cooldown[VG.Felblade].ready and pain <= 70 then
		return VG.Felblade;
	end

	-- fracture,if=soul_fragments<=3;
	if talents[VG.Fracture] and soulFragments <= 3 and cooldown[VG.Fracture].ready then
		return VG.Fracture;
	end

	-- shear;
	if talents[VG.Fracture] then
		if cooldown[VG.Fracture].ready then
			return VG.Fracture;
		end
	else
		return VG.Shear;
	end

	-- throw_glaive;
	return VG.ThrowGlaive;
end

function DemonHunter:VengeanceBrand()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local currentSpell = fd.currentSpell;
	local SigilOfFlame = talents[VG.ConcentratedSigils] and VG.SigilOfFlame2 or VG.SigilOfFlame;

	-- sigil_of_flame,if=cooldown.fiery_brand.remains<2;
	if cooldown[VG.FieryBrand].remains < 2 and cooldown[SigilOfFlame].ready then
		return SigilOfFlame;
	end

	-- fiery_brand;
	if cooldown[VG.FieryBrand].ready then
		return VG.FieryBrand;
	end

	-- immolation_aura,if=dot.fiery_brand.ticking;
	if debuff[VG.FieryBrand].up and cooldown[VG.ImmolationAura].ready then
		return VG.ImmolationAura;
	end

	-- fel_devastation,if=dot.fiery_brand.ticking;
	if talents[VG.FelDevastation] and cooldown[VG.FelDevastation].ready and debuff[VG.FieryBrand].up and
		currentSpell ~= VG.FelDevastation then
		return VG.FelDevastation;
	end

	-- sigil_of_flame,if=dot.fiery_brand.ticking;
	if debuff[VG.FieryBrand].up and cooldown[SigilOfFlame].ready then
		return SigilOfFlame;
	end
end