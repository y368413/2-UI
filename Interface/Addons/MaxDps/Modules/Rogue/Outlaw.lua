if select(2, UnitClass("player")) ~= "ROGUE" then return end

local _, MaxDps_RogueTable = ...;

--- @type MaxDps
if not MaxDps then return end

local MaxDps = MaxDps;
local Rogue = MaxDps_RogueTable.Rogue;

local OL = {
	Stealth              = 1784,
	MarkedForDeath       = 137619,
	LoadedDice           = 256170,
	SnakeEyes            = 275863,
	GhostlyStrike        = 196937,
	DeeperStratagem      = 193531,

	SkullAndCrossbones   = 199603,
	TrueBearing          = 193359,
	RuthlessPrecision    = 193357,
	GrandMelee           = 193358,
	BuriedTreasure       = 199600,
	Broadside            = 193356,

	BladeFlurry          = 13877,
	Opportunity          = 195627,
	QuickDraw            = 196938,
	PistolShot           = 185763,
	KeepYourWitsAboutYou = 288988,
	Deadshot             = 272940,
	SinisterStrike       = 193315,
	KillingSpree         = 51690,
	BladeRush            = 271877,
	Vanish               = 1856,
	Ambush               = 8676,
	AdrenalineRush       = 13750,
	RollTheBones         = 315508,
	SliceAndDice         = 315496,
	BetweenTheEyes       = 315341,
	Dispatch             = 2098,

	StealthAura          = 1784,
	VanishAura           = 11327,
	InstantPoison        = 315584
};

local A = {
	Deadshot        = 272935,
	AceUpYourSleeve = 278676,
	SnakeEyes       = 275846,

};

setmetatable(OL, Rogue.spellMeta);
setmetatable(A, Rogue.spellMeta);

local Rtb = { 'Broadside', 'GrandMelee', 'RuthlessPrecision', 'TrueBearing', 'SkullAndCrossbones', 'BuriedTreasure' };

function Rogue:Outlaw()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local talents = fd.talents;
	local timeToDie = fd.timeToDie;
	local targets = MaxDps:SmartAoe();
	local comboPoints = UnitPower('player', 4);
	local comboPointsMax = UnitPowerMax('player', 4);
	local comboPointsDeficit = comboPointsMax - comboPoints;
	local energy = UnitPower('player', 3);
	local energyMax = UnitPowerMax('player', 3);

	local comboGain;
	if buff[OL.Broadside].up then
		comboGain = 2;
	else
		comboGain = 1;
	end

	MaxDps:GlowEssences();
	MaxDps:GlowCooldown(OL.AdrenalineRush, cooldown[OL.AdrenalineRush].ready);
	--ADRENALINE RUSH KILLING SPREE BLADE RUSH MARKED FOR DEATH
	-- adrenaline_rush,if=!buff.adrenaline_rush.up&energy.time_to_max>1;
	--if cooldown[OL.AdrenalineRush].ready and not buff[OL.AdrenalineRush].up and energyTimeToMax > 1 then
	--	MaxDps:GlowCooldown(OL.AdrenalineRush);
	--end

	if cooldown[OL.RollTheBones].ready and energy >= 25 and not (buff[OL.Broadside].up or buff[OL.RuthlessPrecision].up) then
		return OL.RollTheBones;
	end

	if targets >= 2 and cooldown[OL.BladeFlurry].ready and buff[OL.BladeFlurry].refreshable then
		return OL.BladeFlurry;
	end

	if talents[OL.KillingSpree] and cooldown[OL.KillingSpree].ready and not buff[OL.AdrenalineRush].up then
		return OL.KillingSpree;
	end
	if talents[OL.BladeRush] and cooldown[OL.BladeRush].ready then
		return OL.BladeRush;
	end
	if comboPointsDeficit >= comboGain and buff[OL.Opportunity].up then
		return OL.PistolShot;
	else
		if comboPointsDeficit >= comboGain then
			return OL.SinisterStrike;
		end
	end
	if comboPointsDeficit <= 1 and cooldown[OL.SliceAndDice].ready and buff[OL.SliceAndDice].refreshable and energy >= 25 then
		return OL.SliceAndDice;
	end
	if talents[OL.GhostlyStrike] and comboPointsDeficit >= comboGain and cooldown[OL.GhostlyStrike].ready and energy >= 30 then
		return OL.GhostlyStrike;
	end
	if cooldown[OL.BetweenTheEyes].ready and comboPointsDeficit <= 1 and energy >= 25 then
		return OL.BetweenTheEyes;
	end
	if comboPointsDeficit <= 1 and cooldown[OL.Dispatch].ready and energy >= 35 then
		return OL.Dispatch;
	end
	if energy >= (energyMax - 45) then
		return OL.SinisterStrike;
	end
	if energy <= (energyMax - 45) and buff[OL.Opportunity].up then
		return OL.PistolShot;
	end
end