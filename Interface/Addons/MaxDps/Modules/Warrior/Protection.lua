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

	MaxDps:GlowEssences();

	-- avatar;
	MaxDps:GlowCooldown(PR.Avatar, cooldown[PR.Avatar].ready);

	-- thunder_clap,if=(talent.unstoppable_force.enabled&buff.avatar.up);
	if cooldown[PR.ThunderClap].ready and talents[PR.UnstoppableForce] and buff[PR.Avatar].up then
		return PR.ThunderClap;
	end

	-- shield_block,if=cooldown.shield_slam.ready&buff.shield_block.down&buff.last_stand.down&talent.bolster.enabled;
	if cooldown[PR.ShieldBlock].ready and rage >= 30 and (
		cooldown[PR.ShieldSlam].ready and not buff[PR.ShieldBlockAura].up and not buff[PR.LastStand].up and talents[PR.Bolster]
	) then
		return PR.ShieldBlock;
	end

	-- last_stand,if=cooldown.shield_slam.ready&cooldown.shield_block.charges_fractional<1&buff.shield_block.down&talent.bolster.enabled;
	if cooldown[PR.LastStand].ready and (
		cooldown[PR.ShieldSlam].ready and cooldown[PR.ShieldBlock].charges < 1 and not buff[PR.ShieldBlockAura].up and talents[PR.Bolster]
	) then
		return PR.LastStand;
	end

	-- ignore_pain,if=rage.deficit<25+20*talent.booming_voice.enabled*cooldown.demoralizing_shout.ready;
	if cooldown[PR.IgnorePain].ready and rage >= 40 and (
		rageDeficit < 25 + (talents[PR.BoomingVoice] and 20 or 0) * (cooldown[PR.DemoralizingShout].ready and 1 or 0)
	) then
		return PR.IgnorePain;
	end

	-- shield_slam;
	if cooldown[PR.ShieldSlam].ready then
		return PR.ShieldSlam;
	end

	-- thunder_clap;
	if cooldown[PR.ThunderClap].ready then
		return PR.ThunderClap;
	end

	-- demoralizing_shout,if=talent.booming_voice.enabled;
	if cooldown[PR.DemoralizingShout].ready and talents[PR.BoomingVoice] then
		return PR.DemoralizingShout;
	end

	-- ravager;
	if talents[PR.Ravager] and cooldown[PR.Ravager].ready then
		return PR.Ravager;
	end

	-- dragon_roar;
	if talents[PR.DragonRoar] and cooldown[PR.DragonRoar].ready then
		return PR.DragonRoar;
	end

	-- revenge;
	if cooldown[PR.Revenge].ready and (rage >= 30 or buff[PR.RevengeAura].up) then
		return PR.Revenge;
	end

	-- devastate;
	return PR.Devastate;
end

function Warrior:ProtectionDefensive()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local rage = UnitPower('player', PowerTypeRage);
	local rageMax = UnitPowerMax('player', PowerTypeRage);
	local rageDeficit = rageMax - rage;
	local willCapIgnorePain = Warrior:IgnorePain();
	-- avatar;
	MaxDps:GlowCooldown(PR.Avatar, cooldown[PR.Avatar].ready and not buff[PR.ShieldBlockAura].up);
	MaxDps:GlowCooldown(PR.IgnorePain, willCapIgnorePain <= 1 and rage >= 40);

	-- thunder_clap,if=(talent.unstoppable_force.enabled&buff.avatar.up);
	if cooldown[PR.ThunderClap].ready and talents[PR.UnstoppableForce] and buff[PR.Avatar].up then
		return PR.ThunderClap;
	end

	-- shield_block,if=cooldown.shield_slam.ready&buff.shield_block.down&buff.last_stand.down&talent.bolster.enabled;
	if cooldown[PR.ShieldBlock].ready and rage >= 30 and (
		buff[PR.ShieldBlockAura].refreshable and not buff[PR.LastStand].up and not buff[PR.Avatar].up
	) then
		return PR.ShieldBlock;
	end

	-- last_stand,if=cooldown.shield_slam.ready&cooldown.shield_block.charges_fractional<1&buff.shield_block.down&talent.bolster.enabled;
	if cooldown[PR.LastStand].ready and (
		cooldown[PR.ShieldSlam].ready and cooldown[PR.ShieldBlock].charges < 1 and not buff[PR.ShieldBlockAura].up and talents[PR.Bolster]
	) then
		return PR.LastStand;
	end

	-- ignore_pain,if=rage.deficit<25+20*talent.booming_voice.enabled*cooldown.demoralizing_shout.ready;
	if cooldown[PR.IgnorePain].ready and rage >= 40 and (
		rageDeficit < 25 + (talents[PR.BoomingVoice] and 20 or 0) * (cooldown[PR.DemoralizingShout].ready and 1 or 0)
	) then
		return PR.IgnorePain;
	end

	-- shield_slam;
	if cooldown[PR.ShieldSlam].ready then
		return PR.ShieldSlam;
	end

	-- thunder_clap;
	if cooldown[PR.ThunderClap].ready then
		return PR.ThunderClap;
	end

	-- demoralizing_shout,if=talent.booming_voice.enabled;
	if cooldown[PR.DemoralizingShout].ready and talents[PR.BoomingVoice] then
		return PR.DemoralizingShout;
	end

	-- ravager;
	if talents[PR.Ravager] and cooldown[PR.Ravager].ready then
		return PR.Ravager;
	end

	-- dragon_roar;
	if talents[PR.DragonRoar] and cooldown[PR.DragonRoar].ready then
		return PR.DragonRoar;
	end

	-- revenge;
	if cooldown[PR.Revenge].ready and (rage >= 80 or buff[PR.RevengeAura].up) then
		return PR.Revenge;
	end

	-- devastate;
	return PR.Devastate;
end

function Warrior:IgnorePain()
	local fd = MaxDps.FrameData;
	local azerite = fd.azerite;
	local talents = fd.talents;

	-- Never Surrender
	local curentHP = UnitHealth('player');
	local maxHP = UnitHealthMax('player');
	local HPMissing = (maxHP - curentHP) / maxHP;

	local NSPercentage = talents[PR.NeverSurrender] and (1 + HPMissing) or 1;

	local currentIP, IPRemains = Warrior:IgnorePainAmount();
	local castIP = tonumber((GetSpellDescription(PR.IgnorePain):match('%%.+%d'):gsub('%D', ''))) * NSPercentage;

	local IPCap = math.floor(castIP * 1.3);
	if azerite[279172] >= 1 then
		IPCap = math.floor(castIP * 1.295);
	end

	if IPCap - currentIP == -1 or IPCap - currentIP == -2 then
		IPCap = currentIP;
	end
	--
	--local percentOfCap = currentIP / IPCap * 100;
	--local additionalAbsorb = IPCap - currentIP
	--
	--local percentOfMaxHP = currentIP / maxHP * 100;

	local willCap = 0; -- 0 - full, 1 - clip, 2 - cap
	if currentIP + castIP <= IPCap then
		willCap = 0;
	elseif IPCap - currentIP > 0 then
		willCap = 1;
	elseif IPCap - currentIP <= 0 then
		willCap = 2;
	end

	if WeakAuras then
		WeakAuras.ScanEvents('MAXDPS_IGNORE_PAIN', willCap, currentIP, IPRemains);
	end
	return willCap, currentIP;
end

function Warrior:IgnorePainAmount()
	local i = 1;
	local t = GetTime();

	while true do
		local name, _, count, _, duration, expirationTime, _, _, _, id, _, _, _, _, _, amount = UnitAura('player', i);
		if not name then
			break;
		end

		if id == PR.IgnorePain then
			local remains = 0;

			if expirationTime == nil then
				remains = 0;
			elseif (expirationTime - t) > 0 then
				remains = expirationTime - t;
			elseif expirationTime == 0 then
				remains = 99999;
			end

			if count == 0 then
				count = 1;
			end

			return amount or 0, remains;
		end

		i = i + 1;
	end

	return 0, 0;
end