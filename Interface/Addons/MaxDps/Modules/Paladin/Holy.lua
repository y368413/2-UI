if select(2, UnitClass("player")) ~= "PALADIN" then return end

local _, MaxDps_PaladinTable = ...;


local Paladin = MaxDps_PaladinTable.Paladin;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local HolyPower = Enum.PowerType.HolyPower;
local HL = {
    AvengingWrath = 31884,
    HammerOfWrath = 24275,
    Judgment = 275773,
    JudgmentDebuff = 214222,
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
    local gcd = fd.gcd;
    local targetHp = MaxDps:TargetPercentHealth() * 100;

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
    --HL.BlessingofSpring Gives Healing

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

    if cooldown[HL.Consecration].ready then
        return HL.Consecration;
    end

    -- If judgement is coming off cd in less than or same time Holy Shock is coming up sugest judgment to get the debuff up for holy shock
    if cooldown[HL.Judgment].ready or cooldown[HL.Judgment].remains <= gcd and cooldown[HL.Judgment].remains <= cooldown[HL.HolyShock].remains and not debuff[HL.JudgmentDebuff].up then
        return HL.Judgment;
    end

    -- If the Judgement Debuff is up we want to use Holy Shock before crusader strike or if its coming off cooldown in less time then we can apply another
    --local currentCharges, maxCharges, cooldownStart, cooldownDuration, chargeModRate = GetSpellCharges(HL.CrusaderStrike)
    if cooldown[HL.HolyShock].ready or debuff[HL.JudgmentDebuff].up and cooldown[HL.HolyShock].remains <= cooldown[HL.Judgment].remains then
        return HL.HolyShock;
    end

    if cooldown[HL.CrusaderStrike].ready then
        return HL.CrusaderStrike;
    end

end

