if select(2, UnitClass("player")) ~= "ROGUE" then return end

local _, MaxDps_RogueTable = ...;

--- @type MaxDps
if not MaxDps then return end

local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local GetPowerRegen = GetPowerRegen;
local InCombatLockdown = InCombatLockdown;
local ComboPoints = Enum.PowerType.ComboPoints;
local Energy = Enum.PowerType.Energy;
local Rogue = MaxDps_RogueTable.Rogue;

local SB = {
	Shadowstrike		= 185438,
	Stealth				= 1784,
	SliceAndDice		= 315496,
	Rupture				= 1943,
	Eviscerate			= 196819,
	Backstab			= 53,
	ShadowDance			= 185313,
	ShadowDanceBuff		= 185422,
	Gloomblade			= 200758,
	SymbolsOfDeath		= 212283,
	ShurikenStorm		= 197835,
	MarkedForDeath		= 137619,
};

setmetatable(SB, Rogue.spellMeta);

function Rogue:Subtlety()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, talents, azerite, currentSpell, gcd =
	fd.cooldown, fd.buff, fd.debuff, fd.talents, fd.azerite, fd.currentSpell, fd.gcd;

	local energy = UnitPower('player', 3);
	local energyMax = UnitPowerMax('player', 3);
	local energyDeficit = energyMax - energy;
	local energyRegen = GetPowerRegen();
	local energyTimeToMax = (energyMax - energy) / energyRegen;
	local combo = UnitPower('player', 4);
	local comboMax = UnitPowerMax('player', 4);
	local comboDeficit = comboMax - combo;
	local targets = MaxDps:SmartAoe();


	MaxDps:GlowEssences();

	if targets >= 2 then
		return Rogue:SubtletyAOE();
	end
	return Rogue:SubtletySingle();
end

function Rogue:SubtletySingle()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local energy = UnitPower('player', 3);
	local energyRegen = GetPowerRegen();
	local combo = UnitPower('player', 4);
	local comboMax = UnitPowerMax('player', 4);
	local comboDeficit = comboMax - combo;

	--if cooldown[SB.MarkedForDeath].up and comboDeficit >= 4 and talents[SB.MarkedForDeath] then
	if talents[SB.MarkedForDeath] and cooldown[SB.MarkedForDeath].ready then
		return SB.MarkedForDeath;
	end
	if buff[SB.Stealth].up and energy >= 40 then
		return SB.Shadowstrike;
	end
	if cooldown[SB.ShadowDance].ready and not buff[SB.ShadowDanceBuff].up then
		return SB.ShadowDance;
	end
	if buff[SB.SliceAndDice].refreshable and comboDeficit == 0 and energy >= 25 then
		return SB.SliceAndDice;
	end
	if debuff[SB.Rupture].refreshable and comboDeficit == 0 and energy >= 25 then
		return SB.Rupture;
	end
	--SYMBOLS OF DEATH AND SECRET TECHNIQUE SYNERGY
	if comboDeficit == 0 and energy >= 35 then
		return SB.Eviscerate;
	end
	if buff[SB.ShadowDanceBuff].up and cooldown[SB.SymbolsOfDeath].ready then
		return SB.SymbolsOfDeath;
	end
	if buff[SB.ShadowDanceBuff].up and energy >= 65 then
		return SB.Shadowstrike;
	end
	if comboDeficit > 0 and energy >= 65 and not talents[SB.Gloomblade] then
		return SB.Backstab;
	end
	if comboDeficit > 0 and energy >= 65 and talents[SB.Gloomblade] then
		return SB.Gloomblade;
	end
end

function Rogue:SubtletyAOE()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local energy = UnitPower('player', 3);
	local energyRegen = GetPowerRegen();
	local combo = UnitPower('player', 4);
	local comboMax = UnitPowerMax('player', 4);
	local comboDeficit = comboMax - combo;
	if buff[SB.SliceAndDice].refreshable and comboDeficit == 0 and energy >= 25 and targets < 6 then
		return SB.SliceAndDice;
	end
	if debuff[SB.Rupture].refreshable and comboDeficit == 0 and energy >= 25 and targets < 6 then
		return SB.Rupture;
	end
	if targets >=4 and cooldown[SB.SymbolsOfDeath].ready then
		return SB.SymbolsOfDeath;
	end
	if energy > 35 then
		return SB.ShurikenStorm;
	end
end