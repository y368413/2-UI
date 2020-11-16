if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, MaxDps_ShamanTable = ...;

--- @type MaxDps
if not MaxDps then
	return
end
local MaxDps = MaxDps;
local UnitPower = UnitPower;

local Shaman = MaxDps_ShamanTable.Shaman;

local EH = {
	MaelstromWeaponBuff		= 344179,
	LashingFlames			= 334168,
	LashingFlamesTalent		= 334046,
	FlameShock				= 188389,
	LightningBolt			= 188196,
	Stormstrike				= 17364,
	FrostShock				= 196840,
	LavaLash				= 60103,
	CrashLightning			= 187874,
	HailstormBuff			= 334196,
	Stormkeeper				= 320137,
	Sundering				= 197214,
	ChainLightning			= 188443,
};

setmetatable(EH, Shaman.spellMeta);

function Shaman:Enhancement()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local gcd = fd.gcd;

	fd.targets = targets;
	if targets > 2 then
		return Shaman:EnhanceAoe();
	end
	return Shaman:EnhanceSingle();

end

function Shaman:EnhanceAoe()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local gcd = fd.gcd;

	if cooldown[EH.FrostShock].ready and buff[EH.HailstormBuff].count >= 4 then
		return EH.FrostShock;
	end

	if talents[EH.Sundering] and cooldown[EH.Sundering].ready then
		return EH.Sundering;
	end

	if buff[EH.MaelstromWeaponBuff].count >=5 then
		return EH.ChainLightning;
	end

	if cooldown[EH.CrashLightning].ready then
		return EH.CrashLightning;
	end

	if cooldown[EH.Stormstrike].ready then
		return EH.Stormstrike;
	end

	if cooldown[EH.LavaLash].ready then
		return EH.LavaLash;
	end
end

function Shaman:EnhanceSingle()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local gcd = fd.gcd;

	--NEED TO ADD WINDFURY TOTEM HERE
	if cooldown[EH.FrostShock].ready and buff[EH.HailstormBuff].count >= 4 then
		return EH.FrostShock;
	end

	--EARTHEN SPIKE AND ASCENDANCE HERE
	--WINDSTRIKE IF IN ASCENDANT FORM HERE
	--STORMKEEPER LIGHTNING BOLT
	--STORMKEEPER CAST
	if talents[EH.Stormkeeper] and cooldown[EH.Stormkeeper].ready and buff[EH.MaelstromWeaponBuff].count >=5 and not buff[EH.Stormkeeper].up then
		return EH.Stormkeeper;
	end

	if buff[EH.MaelstromWeaponBuff].count >=5 and buff[EH.Stormkeeper].up then
		return EH.LightningBolt;
	end

	if buff[EH.MaelstromWeaponBuff].count >=8 then
		return EH.LightningBolt;
	end

	if talents[EH.LashingFlamesTalent] and debuff[EH.LashingFlames].refreshable and cooldown[EH.LavaLash].ready then
		return EH.LavaLash;
	end

	if debuff[EH.FlameShock].refreshable and cooldown[EH.FlameShock].ready then
		return EH.FlameShock;
	end

	if cooldown[EH.Stormstrike].ready then
		return EH.Stormstrike;
	end

	if talents[EH.Sundering] and cooldown[EH.Sundering].ready then
		return EH.Sundering;
	end

	if cooldown[EH.FrostShock].ready and debuff[EH.FlameShock].remains > 5 then
		return EH.FrostShock;
	end

	if cooldown[EH.LavaLash].ready then
		return EH.LavaLash;
	end

	if cooldown[EH.CrashLightning].ready then
		return EH.CrashLightning;
	end

	if buff[EH.MaelstromWeaponBuff].count >=5 then
		return EH.LightningBolt;
	end
end