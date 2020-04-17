if select(2, UnitClass("player")) ~= "DRUID" then return end

local _, MaxDps_DruidTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Druid = MaxDps_DruidTable.Druid;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;

local GR = {
	Maul                 = 6807,
	Ironfur              = 192081,
	Pulverize            = 80313,
	ThrashBear           = 77758,
	Moonfire             = 8921,
	MoonfireDot          = 164812,
	Mangle               = 33917,
	GalacticGuardian     = 203964,
	GalacticGuardianBuff = 213708,
	Thrash               = 77758,
	ThrashDot            = 192090,
	Swipe                = 213771,
	Barkskin             = 22812,
	LunarBeam            = 204066,
	BristlingFur         = 155835,
	Incarnation          = 102558,
	SharpenedClaws       = 279943,

	GuardiansWrath       = 279541,

	--ConflictAndStrife = 23,
};

local A = {
	LayeredMane = 279552,
};

setmetatable(A, Druid.spellMeta);
setmetatable(GR, Druid.spellMeta);

function Druid:Guardian()
	local fd = MaxDps.FrameData;
	local targets = MaxDps:SmartAoe();
	local rage = UnitPower('player', Enum.PowerType.Rage);
	local rageMax = UnitPowerMax('player', Enum.PowerType.Rage);
	local rageDeficit = rageMax - rage;
	fd.targets = targets;
	fd.rage = rage;
	fd.rageMax = rageMax;
	fd.rageDeficit = rageDeficit;

	-- call_action_list,name=cooldowns;
	Druid:GuardianCooldowns();

	-- call_action_list,name=cleave,if=active_enemies<=2;
	-- call_action_list,name=multi,if=active_enemies>=3;
	if targets <= 2 then
		return Druid:GuardianCleave();
	else
		return Druid:GuardianMulti();
	end
end

function Druid:GuardianCleave()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local rage = fd.rage;
	local rageDeficit = fd.rageDeficit;

	-- maul,if=rage.deficit<=10;
	if rage >= 40 and rageDeficit <= 10 then
		return GR.Maul;
	end

	-- ironfur,if=cost<=0;
	if cooldown[GR.Ironfur].ready and buff[GR.GuardiansWrath].count >= 3 then
		return GR.Ironfur;
	end

	-- pulverize,target_if=dot.thrash_bear.stack=dot.thrash_bear.max_stacks;
	if talents[GR.Pulverize] and debuff[GR.ThrashDot].count >= 3 then
		return GR.Pulverize;
	end

	-- moonfire,target_if=!dot.moonfire.ticking;
	if not debuff[GR.MoonfireDot].up then
		return GR.Moonfire;
	end

	-- fix for dropping trash debuff
	if cooldown[GR.Thrash].ready and debuff[GR.ThrashDot].remains < 4 then
		return GR.Thrash;
	end

	-- mangle,if=dot.thrash_bear.ticking;
	if cooldown[GR.Mangle].ready and debuff[GR.ThrashDot].remains > 5 then
		return GR.Mangle;
	end

	-- moonfire,target_if=buff.galactic_guardian.up&active_enemies=1|dot.moonfire.refreshable;
	if buff[GR.GalacticGuardianBuff].up and targets <= 1 or debuff[GR.MoonfireDot].refreshable then
		return GR.Moonfire;
	end

	-- maul;
	if rage >= 40 then
		return GR.Maul;
	end

	-- thrash;
	if cooldown[GR.Thrash].ready then
		return GR.Thrash;
	end

	-- swipe;
	return GR.Swipe;
end

function Druid:GuardianCooldowns()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local rage = fd.rage;

	-- barkskin,if=buff.bear_form.up;
	MaxDps:GlowCooldown(GR.Barkskin, cooldown[GR.Barkskin].ready);
	MaxDps:GlowCooldown(GR.Ironfur, cooldown[GR.Ironfur].ready and rage >= 40);

	-- lunar_beam,if=buff.bear_form.up;
	if talents[GR.LunarBeam] then
		MaxDps:GlowCooldown(GR.LunarBeam, cooldown[GR.LunarBeam].ready);
	end

	-- bristling_fur,if=buff.bear_form.up;
	if talents[GR.BristlingFur] then
		MaxDps:GlowCooldown(GR.BristlingFur, cooldown[GR.BristlingFur].ready);
	end

	-- incarnation,if=(dot.moonfire.ticking|active_enemies>1)&dot.thrash_bear.ticking;
	if talents[GR.Incarnation] then
		MaxDps:GlowCooldown(GR.Incarnation, cooldown[GR.Incarnation].ready and (
			(debuff[GR.MoonfireDot].up or targets > 1) and debuff[GR.ThrashDot].up)
		);
	end
end

function Druid:GuardianMulti()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local targets = fd.targets;
	local rage = fd.rage;
	local rageDeficit = fd.rageDeficit;

	-- maul,if=essence.conflict_and_strife.major&!buff.sharpened_claws.up;
	-- cannot detect
	--if rage >= 40 and (MaxDps.AzeriteEssences.major == GR.ConflictAndStrife and not buff[GR.SharpenedClaws].up) then
	--	return GR.Maul;
	--end

	-- ironfur,if=(rage>=cost&azerite.layered_mane.enabled)|rage.deficit<10;
	--if cooldown[GR.Ironfur].ready and rage >= 40 and ((rage >= cooldown[GR.Ironfur].cost and azerite[A.LayeredMane] > 0) or rageDeficit < 10) then
	--	return GR.Ironfur;
	--end

	-- thrash,if=(buff.incarnation.up&active_enemies>=4)|cooldown.thrash_bear.up;
	if (buff[GR.Incarnation].up and targets >= 4) or cooldown[GR.ThrashBear].ready then
		return GR.Thrash;
	end

	-- mangle,if=buff.incarnation.up&active_enemies=3&dot.thrash_bear.ticking;
	if cooldown[GR.Mangle].ready and (buff[GR.Incarnation].up and targets == 3 and debuff[GR.ThrashDot].up) then
		return GR.Mangle;
	end

	-- moonfire,if=dot.moonfire.refreshable&active_enemies<=4;
	if debuff[GR.MoonfireDot].refreshable and targets <= 4 then
		return GR.Moonfire;
	end

	-- swipe,if=buff.incarnation.down;
	if not buff[GR.Incarnation].up then
		return GR.Swipe;
	end
end

