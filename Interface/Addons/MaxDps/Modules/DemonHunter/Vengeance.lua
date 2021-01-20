if select(2, UnitClass("player")) ~= "DEMONHUNTER" then return end
local _, MaxDps_DemonHunterTable = ...;

--- @type MaxDps
if not MaxDps then return end

local DemonHunter = MaxDps_DemonHunterTable.DemonHunter;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local GetSpellCount = GetSpellCount;

local Necrolord = Enum.CovenantType.Necrolord;
local Venthyr = Enum.CovenantType.Venthyr;
local NightFae = Enum.CovenantType.NightFae;
local Kyrian = Enum.CovenantType.Kyrian;

local VG = {
	AgonizingFlames    = 207548,
	BurningAlive       = 207739,
	CharredFlesh       = 264002,
	Disrupt            = 183752,
	ConsumeMagic       = 278326,
	ThrowGlaive        = 204157,
	ImmolationAura     = 258920,
	Metamorphosis      = 187827,
	FieryBrand         = 204021,
	SinfulBrand        = 317009,
	TheHunt            = 323639,
	FodderToTheFlame   = 329554,
	ElysianDecree      = 306830,
	ElysianDecreeConc  = 327839,
	DemonSpikes        = 203720,
	DemonSpikesAura    = 203819,
	InfernalStrike     = 189110,
	BulkExtraction     = 320341,
	SpiritBomb         = 247454,
	Fracture           = 263642,
	FelDevastation     = 212084,
	SoulCleave         = 228477,
	Felblade           = 232893,
	SigilOfFlame       = 204596,
	SigilOfFlameConc   = 204513,
	Shear              = 203782,
	ConcentratedSigils = 207666,

	-- Leggo buffs
	FelBombardment     = 337849,

	-- Leggo bonus Id
	RazelikhsDefilementBonusId = 7046
};

setmetatable(VG, DemonHunter.spellMeta);

function DemonHunter:Vengeance()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;

	-- variable,name=brand_build,value=talent.agonizing_flames.enabled&talent.burning_alive.enabled&talent.charred_flesh.enabled;
	local brandBuild = talents[VG.AgonizingFlames] and talents[VG.BurningAlive] and talents[VG.CharredFlesh];

	fd.brandBuild = brandBuild;

	MaxDps:GlowCooldown(VG.Metamorphosis, cooldown[VG.Metamorphosis].ready);
	-- demon_spikes;
	MaxDps:GlowCooldown(VG.DemonSpikes, cooldown[VG.DemonSpikes].ready and buff[VG.DemonSpikesAura].remains < 1);

	-- throw_glaive,if=buff.fel_bombardment.stack=5&(buff.immolation_aura.up|!buff.metamorphosis.up);
	if buff[VG.FelBombardment].count == 5 and (buff[VG.ImmolationAura].up or not buff[VG.Metamorphosis].up) then
		return VG.ThrowGlaive;
	end

	local result;
	-- call_action_list,name=brand,if=variable.brand_build;
	if brandBuild then
		result = DemonHunter:VengeanceBrand();
		if result then
			return result;
		end
	end

	-- call_action_list,name=defensives;
	result = DemonHunter:VengeanceDefensives();
	if result then
		return result;
	end

	-- call_action_list,name=cooldowns;
	result = DemonHunter:VengeanceCooldowns();
	if result then
		return result;
	end

	-- call_action_list,name=normal;
	result = DemonHunter:VengeanceNormal();
	if result then
		return result;
	end
end

function DemonHunter:VengeanceBrand()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local debuff = fd.debuff;

	-- fiery_brand;
	if cooldown[VG.FieryBrand].ready then
		return VG.FieryBrand;
	end

	-- immolation_aura,if=dot.fiery_brand.ticking;
	if cooldown[VG.ImmolationAura].ready and debuff[VG.FieryBrand].up then
		return VG.ImmolationAura;
	end
end

function DemonHunter:VengeanceCooldowns()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local covenantId = fd.covenant.covenantId;

	-- sinful_brand,if=!dot.sinful_brand.ticking;
	if covenantId == Venthyr and cooldown[VG.SinfulBrand].ready and not debuff[VG.SinfulBrand].up then
		return VG.SinfulBrand;
	end

	-- the_hunt;
	if covenantId == NightFae and cooldown[VG.TheHunt].ready and currentSpell ~= VG.TheHunt then
		return VG.TheHunt;
	end

	-- fodder_to_the_flame;
	if covenantId == Necrolord and cooldown[VG.FodderToTheFlame].ready then
		return VG.FodderToTheFlame;
	end

	-- elysian_decree;
	local ElysianDecree = talents[VG.ConcentratedSigils] and VG.ElysianDecreeConc or VG.ElysianDecree;
	if covenantId == Kyrian and cooldown[ElysianDecree].ready then
		return ElysianDecree;
	end
end

function DemonHunter:VengeanceDefensives()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local timeToDie = fd.timeToDie;
	local covenantId = fd.covenant.covenantId;

	-- metamorphosis,if=!buff.metamorphosis.up&(!covenant.venthyr.enabled|!dot.sinful_brand.ticking)|target.time_to_die<15;
	--if cooldown[VG.Metamorphosis].ready and (not buff[VG.Metamorphosis].up and (not covenantId == Enum.CovenantType.Venthyr or not debuff[VG.SinfulBrand].up) or timeToDie < 15) then
	--	return VG.Metamorphosis;
	--end

	-- fiery_brand;
	if cooldown[VG.FieryBrand].ready then
		return VG.FieryBrand;
	end
end

function DemonHunter:VengeanceNormal()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local timeToDie = fd.timeToDie;
	local runeforge = fd.runeforge;
	local brandBuild = fd.brandBuild;
	local covenantId = fd.covenant.covenantId;
	local fury = UnitPower('player', Enum.PowerType.Fury);
	local soulFragments = GetSpellCount(VG.SpiritBomb);

	-- infernal_strike;
	--if cooldown[VG.InfernalStrike].ready then
	--	return VG.InfernalStrike;
	--end

	-- bulk_extraction;
	if talents[VG.BulkExtraction] and cooldown[VG.BulkExtraction].ready then
		return VG.BulkExtraction;
	end

	-- spirit_bomb,if=((buff.metamorphosis.up&talent.fracture.enabled&soul_fragments>=3)|soul_fragments>=4);
	if talents[VG.SpiritBomb] and
		fury >= 30 and
		((buff[VG.Metamorphosis].up and talents[VG.Fracture] and soulFragments >= 3) or soulFragments >= 4)
	then
		return VG.SpiritBomb;
	end

	-- fel_devastation;
	if fury >= 50 and cooldown[VG.FelDevastation].ready then
		return VG.FelDevastation;
	end

	-- soul_cleave,if=((talent.spirit_bomb.enabled&soul_fragments=0)|!talent.spirit_bomb.enabled)&((talent.fracture.enabled&fury>=55)|(!talent.fracture.enabled&fury>=70)|cooldown.fel_devastation.remains>target.time_to_die|(buff.metamorphosis.up&((talent.fracture.enabled&fury>=35)|(!talent.fracture.enabled&fury>=50))));
	if fury >= 30 and
		(
			((talents[VG.SpiritBomb] and soulFragments == 0) or not talents[VG.SpiritBomb]) and
			(
				(talents[VG.Fracture] and fury >= 55) or
				(not talents[VG.Fracture] and fury >= 70) or
				cooldown[VG.FelDevastation].remains > timeToDie or
				(
					buff[VG.Metamorphosis].up and
					((talents[VG.Fracture] and fury >= 35) or (not talents[VG.Fracture] and fury >= 50))
				)
			)
		)
	then
		return VG.SoulCleave;
	end

	-- immolation_aura,if=((variable.brand_build&cooldown.fiery_brand.remains>10)|!variable.brand_build)&fury<=90;
	if cooldown[VG.ImmolationAura].ready and
		((brandBuild and cooldown[VG.FieryBrand].remains > 10) or not brandBuild) and
		fury <= 90
	then
		return VG.ImmolationAura;
	end

	-- felblade,if=fury<=60;
	if talents[VG.Felblade] and cooldown[VG.Felblade].ready and fury <= 60 then
		return VG.Felblade;
	end

	-- fracture,if=((talent.spirit_bomb.enabled&soul_fragments<=3)|(!talent.spirit_bomb.enabled&((buff.metamorphosis.up&fury<=55)|(buff.metamorphosis.down&fury<=70))));
	if talents[VG.Fracture] and
		cooldown[VG.Fracture].ready and
		(
			(talents[VG.SpiritBomb] and soulFragments <= 3) or
			(
				not talents[VG.SpiritBomb] and
				((buff[VG.Metamorphosis].up and fury <= 55) or (not buff[VG.Metamorphosis].up and fury <= 70))
			)
		)
	then
		return VG.Fracture;
	end

	-- sigil_of_flame,if=!(covenant.kyrian.enabled&runeforge.razelikhs_defilement);
	local SigilOfFlame = talents[VG.ConcentratedSigils] and VG.SigilOfFlameConc or VG.SigilOfFlame;
	if cooldown[SigilOfFlame].ready and
		not (covenantId == Kyrian and runeforge[VG.RazelikhsDefilementBonusId])
	then
		return SigilOfFlame;
	end

	-- shear;
	if not talents[VG.Fracture] then
		return VG.Shear;
	end

	return VG.ThrowGlaive;
end
