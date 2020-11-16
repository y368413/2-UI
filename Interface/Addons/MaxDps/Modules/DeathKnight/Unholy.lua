if select(2, UnitClass("player")) ~= "DEATHKNIGHT" then return end

local _, MaxDps_DeathKnightTable = ...;
local DeathKnight = MaxDps_DeathKnightTable.DeathKnight;
local MaxDps = MaxDps;
local IsEquippedItem = IsEquippedItem;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local RunicPower = Enum.PowerType.RunicPower;
local Runes = Enum.PowerType.Runes;

local UH = {
	VirulentPlague     = 191587,

	RaiseDead          = 46584,
	ArmyOfTheDead      = 42650,
	SummonGargoyle     = 49206,
	Outbreak           = 77575,

	DeathAndDecay      = 43265,
	Apocalypse         = 275699,
	Defile             = 152280,
	Epidemic           = 207317,
	DeathCoil          = 47541,
	ScourgeStrike      = 55090,
	ClawingShadows     = 207311,
	FesteringStrike    = 85948,
	FesteringWound     = 194310,
	BurstingSores      = 207264,
	SuddenDoom         = 81340,
	UnholyFrenzy       = 207289,
	DarkTransformation = 63560,
	SoulReaper         = 130736,
	UnholyBlight       = 115989,
	Pestilence         = 277234,
};

local A = {
	MagusOfTheDead = 288417,
};

function DeathKnight:Unholy()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local gcd = fd.gcd;
	local buff = fd.buff;
	local azerite = fd.azerite;
	local runes = DeathKnight:Runes(fd.timeShift);
	local runesMax = UnitPowerMax('player', Runes);
	local runesDeficit = runesMax - runes;
	local runicPower = UnitPower('player', RunicPower);
	local runicPowerMax = UnitPowerMax('player', RunicPower);
	local runicPowerDeficit = runicPowerMax - runicPower;

	fd.targets = targets;
	fd.runes = runes;
	fd.runesDeficit = runesDeficit;
	fd.runicPower = runicPower;
	fd.runicPowerDeficit = runicPowerDeficit;

	MaxDps:GlowEssences();

	if targets > 2 and talents[UH.UnholyBlight] and cooldown[UH.UnholyBlight].ready then
		return UH.UnholyBlight;
	end
	if runes >= 1 and debuff[UH.VirulentPlague].remains <= gcd then
		return UH.Outbreak;
	end
	if cooldown[UH.DarkTransformation].ready then
		return UH.DarkTransformation;
	end
	if debuff[UH.FesteringWound].count >= 4 and cooldown[UH.Apocalypse].ready then
		return UH.Apocalypse;
	end
	if targets > 2 then
		if buff[UH.SuddenDoom].up or fd.runicPower > 80 then
			return UH.Epidemic;
		end
	else
		if buff[UH.SuddenDoom].up or fd.runicPower > 80 then
			return UH.DeathCoil;
		end
	end
	if targets > 2 and cooldown[UH.DeathAndDecay].ready and fd.runes >= 1 then
		return UH.DeathAndDecay;
	end
	if talents[UH.ClawingShadows] then
		if debuff[UH.FesteringWound].count >= 1 and fd.runes > 2 then
			return UH.ClawingShadows;
		end

	else
		if debuff[UH.FesteringWound].count >= 1 and fd.runes > 2 then
			return UH.ScourgeStrike;
		end
	end

	if fd.runes >= 2 and debuff[UH.FesteringWound].count <= 3 then
		return UH.FesteringStrike
	end
end