if select(2, UnitClass("player")) ~= "PALADIN" then return end

local _, MaxDps_PaladinTable = ...;


local Paladin = MaxDps_PaladinTable.Paladin;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local HolyPower = Enum.PowerType.HolyPower;
local HL = {
    AvengingWrath = 31884,
    HammerOfWrath = 24275,
    Judgment = 20271,
    Consecration = 26573,
    CrusaderStrike = 35395,
    ShieldoftheRighteous = 53600,
    HolyShock = 20473,
    --Talents
    LightsHammer = 114158,
    HolyAvenger = 105809,
    Seraphim = 152262,
    AvengingCrusader  = 216331,
    DivinePurpose = 223817,
    GlimmerofLight = 325966,
    --
    --Kyrian
    DivineToll = 304971,
    --
    --Venthyr
    AshenHallow = 316958,
    --
    --NightFae
    BlessingoftheSeasons = 328278,
    BlessingofSpring = 328282,
    BlessingofSummer = 328620,
    BlessingofAutumn = 328622,
    BlessingofWinter = 328281,
    --
    --Necrolord
    VanquishersHammer = 328204,
    --
};

local CN = {
	None      = 0,
	Kyrian    = 1,
	Venthyr   = 2,
	NightFae  = 3,
	Necrolord = 4
};

setmetatable(HL, Paladin.spellMeta);

function Paladin:Holy()
    local fd = MaxDps.FrameData;
    local covenantId = fd.covenant.covenantId;
    fd.targets = MaxDps:SmartAoe();
    local holyPower = UnitPower('player', HolyPower);
    fd.holyPower = holyPower;
    local cooldown = fd.cooldown;
    local buff = fd.buff;
    local debuff = fd.debuff;
    local talents = fd.talents;
    local targets = fd.targets;
    local gcd = fd.gcd;
    local targetHp = MaxDps:TargetPercentHealth() * 100;
    local health = UnitHealth('player');
    local healthMax = UnitHealthMax('player');
    local healthPercent = ( health / healthMax ) * 100;

    -- Essences
    MaxDps:GlowEssences();

    -- Cooldowns
    MaxDps:GlowCooldown(HL.AvengingWrath, cooldown[HL.AvengingWrath].ready);

    --talents

    if talents[HL.LightsHammer] then
        MaxDps:GlowCooldown(HL.LightsHammer, cooldown[HL.LightsHammer].ready);
    end

    if talents[HL.HolyAvenger] then
        MaxDps:GlowCooldown(HL.HolyAvenger, cooldown[HL.HolyAvenger].ready);
    end

    if talents[HL.AvengingCrusader] then
        MaxDps:GlowCooldown(HL.AvengingCrusader, cooldown[HL.AvengingCrusader].ready);
    end

    --Covenant
    --Kyrian
    if covenantId == CN.Kyrian and cooldown[HL.DivineToll].ready then
        MaxDps:GlowCooldown(HL.DivineToll, cooldown[HL.DivineToll].ready);
    end
    --
    --Venthyr
    if covenantId == CN.Venthyr and cooldown[HL.AshenHallow].ready then
        MaxDps:GlowCooldown(HL.AshenHallow, cooldown[HL.AshenHallow].ready);
    end
    --
    --NightFae
    --Gives Healing
    --if covenantId == CN.NightFae and cooldown[HL.BlessingofSpring].ready then
    --    MaxDps:GlowCooldown(HL.BlessingofSpring, cooldown[HL.BlessingofSpring].ready)
    --end

    if covenantId == CN.NightFae and cooldown[HL.BlessingofSummer].ready then
        MaxDps:GlowCooldown(HL.BlessingofSummer, cooldown[HL.BlessingofSummer].ready);
    end

    if covenantId == CN.NightFae and cooldown[HL.BlessingofAutumn].ready then
        MaxDps:GlowCooldown(HL.BlessingofAutumn, cooldown[HL.BlessingofAutumn].ready);
    end

    if covenantId == CN.NightFae and cooldown[HL.BlessingofWinter].ready then
        MaxDps:GlowCooldown(HL.BlessingofWinter, cooldown[HL.BlessingofWinter].ready);
    end
    --
    --Necrolord
    if covenantId == CN.Necrolord and cooldown[HL.VanquishersHammer].ready then
        MaxDps:GlowCooldown(HL.VanquishersHammer, cooldown[HL.VanquishersHammer].ready);
    end

    --- Spenders
    if talents[HL.Seraphim] and cooldown[HL.Seraphim].ready and holyPower >=3 then
        return HL.Seraphim;
    end

    if holyPower >= 3 then
        return HL.ShieldoftheRighteous;
    end

    -- Generators

    if (targetHp <= 20 or buff[HL.AvengingWrath].up) and cooldown[HL.HammerOfWrath].ready then
        return HL.HammerOfWrath;
    end

    if cooldown[HL.Judgment].ready then
        return HL.Judgment;
    end

    --if cooldown[HL.HolyShock].ready and debuff[HL.GlimmerofLight].remains < 2 or buff[HL.GlimmerofLight].remains < 2 then
	--	return HL.HolyShock
	--end

    if cooldown[HL.HolyShock].ready then
        return HL.HolyShock;
    end

    if cooldown[HL.CrusaderStrike].ready then
        return HL.CrusaderStrike;
    end

    if cooldown[HL.Consecration].ready then
        return HL.Consecration;
    end
end