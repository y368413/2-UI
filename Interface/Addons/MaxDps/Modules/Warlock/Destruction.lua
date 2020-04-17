if select(2, UnitClass("player")) ~= "WARLOCK" then return end

local _, MaxDps_WarlockTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Warlock = MaxDps_WarlockTable.Warlock;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local EnumPowerType = Enum.PowerType;

local WD = {
	Immolate            = 348,
	ImmolateAura        = 157736,
	ChaosBolt           = 116858,
	Conflagrate         = 17962,
	ChannelDemonfire    = 196447,
	Eradication         = 196412,
	Cataclysm           = 152108,
	Incinerate          = 29722,
	SummonInfernal      = 1122,
	DarkSoulInstability = 113858,
	RainOfFire          = 5740,
	Havoc               = 80240,
	Shadowburn          = 17877,
	Backdraft           = 117828,
	FireAndBrimstone    = 196408,
	SummonImp           = 688,
	SummonVoidwalker    = 697,
	SummonSuccubus      = 712,
	SummonFelhunter     = 691,
	Soulfire            = 6353,
};

function Warlock:Destruction()
	local fd = MaxDps.FrameData;
	local cooldown, buff, debuff, timeShift, talents, azerite, currentSpell = fd.cooldown, fd.buff, fd.debuff, fd.timeShift, fd.talents, fd.azerite, fd.currentSpell;

	local SoulShards = UnitPower('player', EnumPowerType.SoulShards, true) / 10;

	if currentSpell == WD.ChaosBolt then
		SoulShards = SoulShards - 2;
	end

	--Cooldowns
	MaxDps:GlowEssences();
	MaxDps:GlowCooldown(WD.Havoc, cooldown[WD.Havoc].ready);
	MaxDps:GlowCooldown(WD.SummonInfernal, cooldown[WD.SummonInfernal].ready);
	MaxDps:GlowCooldown(WD.Cataclysm, talents[WD.Cataclysm] and cooldown[WD.Cataclysm].ready and currentSpell ~= WD.Cataclysm);

	if talents[WD.DarkSoulInstability] then
		MaxDps:GlowCooldown(WD.DarkSoulInstability, cooldown[WD.DarkSoulInstability].ready);
	end

	--Rotation Start

	--if talents[WD.Cataclysm] and cooldown[WD.Cataclysm].ready and currentSpell ~= WD.Cataclysm then
	--	return WD.Cataclysm;
	--end

	--1. Cast ChaosBolt if Backdraft is active and at least 2 seconds left
	if buff[WD.Backdraft].remains >= 2 and SoulShards >= 2 and currentSpell ~= WD.ChaosBolt then
		return WD.ChaosBolt;
	end

	--2. Cast Soulfire on cd if Talented
	if talents[WD.Soulfire] and cooldown[WD.Soulfire].ready and currentSpell ~= WD.Soulfire then
		return WD.Soulfire;
	end

	--3. Apply or Reapply Immolate
	if debuff[WD.ImmolateAura].refreshable and currentSpell ~= WD.Immolate and currentSpell ~= WD.Cataclysm then
		return WD.Immolate;
	end

	--4. Cast ChaosBolt if Capped
	if SoulShards >= 4 then
		return WD.ChaosBolt;
	end

	--5. Cast Conflagrate on CD but keep almost 1 Charge for Burst
	if cooldown[WD.Conflagrate].charges > 1.5 then
		return WD.Conflagrate;
	end

	--6. Cast Demonfire Whenever Possible and Target has Immolate applied for at least 3 seconds
	if talents[WD.ChannelDemonfire] and cooldown[WD.ChannelDemonfire].ready and
		debuff[WD.ImmolateAura].remains >= 3 and currentSpell ~= WD.ChannelDemonfire then
		return WD.ChannelDemonfire;
	end

	--7. Cast Shadowburn dont know why cause Talent seems to bee quiet shit...
	if talents[WD.Shadowburn] and cooldown[WD.Shadowburn].ready then
		return WD.Shadowburn;
	end

	return WD.Incinerate;
end