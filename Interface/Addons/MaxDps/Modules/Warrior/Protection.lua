if select(2, UnitClass("player")) ~= "WARRIOR" then return end

local _, MaxDps_WarriorTable = ...;


local Warrior = MaxDps_WarriorTable.Warrior;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitHealth = UnitHealth;
local UnitAura = UnitAura;
local GetSpellDescription = GetSpellDescription;
local UnitHealthMax = UnitHealthMax;
local UnitPowerMax = UnitPowerMax;
local PowerTypeRage = Enum.PowerType.Rage;

local PR = {
	Avatar            = 107574,
	ThunderClap       = 6343,
	UnstoppableForce  = 275336,
	ShieldBlock       = 2565,
	ShieldBlockAura   = 132404,
	ShieldSlam        = 23922,
	LastStand         = 12975,
	Bolster           = 280001,
	IgnorePain        = 190456,
	BoomingVoice      = 202743,
	DemoralizingShout = 1160,
	Ravager           = 228920,
	DragonRoar        = 118000,
	Revenge           = 6572,
	NeverSurrender    = 202561,
	RevengeAura       = 5302,
	Devastate         = 20243,
};

function Warrior:Protection()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local rage = UnitPower('player', PowerTypeRage);
	local rageMax = UnitPowerMax('player', PowerTypeRage);
	local rageDeficit = rageMax - rage;
	local curentHP = UnitHealth('player');
	local maxHP = UnitHealthMax('player');
	local healthPerc = (curentHP / maxHP) * 100;
	MaxDps:GlowEssences();

	MaxDps:GlowCooldown(PR.Avatar, cooldown[PR.Avatar].ready);

	if healthPerc <= 95 then
		return Warrior:ProtectionDefense();
	end

	return Warrior:ProtectionOffense();
end

function Warrior:ProtectionDefense()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local rage = UnitPower('player', PowerTypeRage);
	local rageMax = UnitPowerMax('player', PowerTypeRage);
	local rageDeficit = rageMax - rage;
	if buff[PR.IgnorePain].refreshable and rage >= 40 then
		return PR.IgnorePain;
	end

	if cooldown[PR.DemoralizingShout].ready then
		return PR.DemoralizingShout;
	end

	return Warrior:ProtectionOffense();
end

function Warrior:ProtectionOffense()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local rage = UnitPower('player', PowerTypeRage);
	local rageMax = UnitPowerMax('player', PowerTypeRage);
	local rageDeficit = rageMax - rage;

	-- thunder_clap,if=(talent.unstoppable_force.enabled&buff.avatar.up);
	if cooldown[PR.ThunderClap].ready then
		return PR.ThunderClap;
	end

	if cooldown[PR.Revenge].ready and buff[PR.RevengeAura].up then
		return PR.Revenge;
	end

	if cooldown[PR.ShieldSlam].ready then
		return PR.ShieldSlam;
	end

	if talents[PR.DragonRoar] and cooldown[PR.DragonRoar].ready then
		return PR.DragonRoar;
	end

	if cooldown[PR.Revenge].ready and rage > 75 then
		return PR.Revenge;
	end
end