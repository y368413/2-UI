if select(2, UnitClass("player")) ~= "DRUID" then return end

local _, MaxDps_DruidTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Druid = MaxDps_DruidTable.Druid;
local GetComboPoints = GetComboPoints;
local GetSpellCount = GetSpellCount;
local UnitHealth = UnitHealth;
local UnitHealthMax = UnitHealthMax;

local RO = {
    Moonfire = 8921,
    Sunfire = 93402,
    MoonfireDebuff = 164812,
    SunfireDebuff = 164815,
    Wrath = 5176,
    Starfire = 197628,
    Starsurge = 197626,

    EclipseLunar = 48518,
    EclipseSolar = 48517,

    Rip = 1079,
    RipDebuff = 1079,
    Rake = 1822,
    Swipe = 106785,
    RakeDebuff = 155722,
    Shred = 5221,
    FerociousBite = 22568,

    Thrash = 77758,
    ThrashDebuff = 192090,
    Mangle = 33917,

    --Talents
    BalanceAffinity = 197632,
    MoonkinForm = 197625,
    FeralAffinity = 197490,
    CatForm = 768,
    GuardianAffinity = 197491,
    BearForm = 5487,
    HearoftheWild = 319454,
    --
    --Kyrian
    KindredSpirits = 326434,
    --
    --Venthyr
    RavenousFrenzy = 323546,
    --
    --NightFae
    ConvoketheSpirits = 323764,
    --
    --Necrolord
    AdaptiveSwarm = 325727,
    --
};

local CN = {
    None      = 0,
    Kyrian    = 1,
    Venthyr   = 2,
    NightFae  = 3,
    Necrolord = 4
};

setmetatable(RO, Druid.spellMeta);

local lasteclipse;

function Druid:Restoration()
    local fd = MaxDps.FrameData;
    local covenantId = fd.covenant.covenantId;
    fd.targets = MaxDps:SmartAoe();
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
    local currentSpell = fd.currentSpell;

    -- Update Spell Locations
    --MaxDps:Fetch();

    -- Update Talents
    MaxDps:CheckTalents();

    -- Essences
    MaxDps:GlowEssences();

    -- Cooldowns

    --talents

    if talents[RO.HearoftheWild] then
        MaxDps:GlowCooldown(RO.HearoftheWild, cooldown[RO.HearoftheWild].ready);
    end

    --Covenant
    --Kyrian
    if covenantId == CN.Kyrian and cooldown[RO.KindredSpirits].ready then
        MaxDps:GlowCooldown(RO.KindredSpirits, cooldown[RO.KindredSpirits].ready);
    end

    --Venthyr
    if covenantId == CN.Venthyr and cooldown[RO.RavenousFrenzy].ready then
        MaxDps:GlowCooldown(RO.RavenousFrenzy, cooldown[RO.RavenousFrenzy].ready);
    end

    --NightFae
    if covenantId == CN.NightFae and cooldown[RO.ConvoketheSpirits].ready then
        MaxDps:GlowCooldown(RO.ConvoketheSpirits, cooldown[RO.ConvoketheSpirits].ready);
    end

    --Necrolord
    if covenantId == CN.Necrolord and cooldown[RO.AdaptiveSwarm].ready then
        MaxDps:GlowCooldown(RO.AdaptiveSwarm, cooldown[RO.AdaptiveSwarm].ready);
    end

    if talents[RO.BalanceAffinity] then
        if buff[RO.MoonkinForm].up then
            if debuff[RO.SunfireDebuff].remains < 1 and cooldown[RO.Sunfire].ready then
                return RO.Sunfire;
            end

            if debuff[RO.MoonfireDebuff].remains < 1 and cooldown[RO.Moonfire].ready then
                return RO.Moonfire;
            end

            if cooldown[RO.Starsurge].ready then
                return RO.Starsurge;
            end

            if buff[RO.EclipseLunar].up then
                lasteclipse = "lunar"
                return RO.Starfire;
            end

            if buff[RO.EclipseSolar].up then
                lasteclipse = "solar"
                return RO.Wrath;
            end

            if lasteclipse == "solar" then
                return RO.Wrath;
            end

            if lasteclipse == "lunar" then
                return RO.Starfire;
            end

            if targets > 1 then -- We want to aoe
                if GetSpellCount(RO.Wrath) >= 1 then -- We have charges of wrath so we can use it to get to lunar which cleaves
                    return RO.Wrath;
                end
            end

            if GetSpellCount(RO.Wrath) >= 1 then
                return RO.Wrath;
            end

            if GetSpellCount(RO.Starfire) >= 1 then
                return RO.Starfire;
            end

            if lasteclipse ~= "lunar" and lasteclipse ~= "solar" then -- Havn't gone into a ecipse yet
                if targets > 1 then -- We want to aoe so cast wrath till we get to lunar ecplipse
                    return RO.Wrath;
                else
                    return RO.Starfire;
                end
            end

        else
            return RO.MoonkinForm;
        end
    end

    if talents[RO.FeralAffinity] then
        if buff[RO.CatForm].up then
            local comboPoints = GetComboPoints("player", "target");
            if debuff[RO.RakeDebuff].remains < 1 and cooldown[RO.Rake].ready then
                return RO.Rake;
            end

            if comboPoints < 5 then
                if targets > 1 then
                    return RO.Swipe;
                else
                    return RO.Shred;
                end
            end

            if debuff[RO.RipDebuff].remains < 1 and comboPoints == 5 and cooldown[RO.RipDebuff].ready then
                return RO.RipDebuff;
            end

            if comboPoints >= 5 then
                return RO.FerociousBite;
            end
        else
            return RO.CatForm;
        end
    end

    if talents[RO.GuardianAffinity] then
        if buff[RO.BearForm].up then
            if debuff[RO.ThrashDebuff].count <= 3 and cooldown[RO.Thrash].ready then
                return RO.Thrash;
            end
            if cooldown[RO.Mangle].ready then
                return RO.Mangle;
            end
        else
            return RO.BearForm;
        end
    end

end