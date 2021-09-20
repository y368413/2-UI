if select(2, UnitClass("player")) ~= "MONK" then return end

local _, MaxDps_MonkTable = ...;

--- @type MaxDps
if not MaxDps then return end

local MaxDps = MaxDps;
local Monk = MaxDps_MonkTable.Monk;
local MaxDps = MaxDps;
local UnitPower = UnitPower;

local MR = {
    TigerPalm = 100780,
    BlackoutKick = 100784,
    RisingSunKick = 107428,
    SpinningCraneKick = 101546,
	TouchofDeath = 322109,
    --Talents
    ChiWave = 115098,
    ChiBurst = 123986,
    --
    --Kyrian
    WeaponsofOrder = 310454,
    --
    --Venthyr
    FallenOrder = 326860,
    --
    --NightFae
    FaelineStomp = 327104,
    --
    --Necrolord
    BonedustBrew = 325216,
    --
};

local CN = {
    None      = 0,
    Kyrian    = 1,
    Venthyr   = 2,
    NightFae  = 3,
    Necrolord = 4
};

setmetatable(MR, Monk.spellMeta);

function Monk:Mistweaver()
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

    -- Essences
    MaxDps:GlowEssences();

    -- Cooldowns

    --talents

    if talents[MR.ChiWave] then
        MaxDps:GlowCooldown(MR.ChiWave, cooldown[MR.ChiWave].ready);
    end

    if talents[MR.ChiBurst] then
        MaxDps:GlowCooldown(MR.ChiBurst, cooldown[MR.ChiBurst].ready);
    end

    --Covenant
    --Kyrian
    --Heal
    --if covenantId == CN.Kyrian and cooldown[MR.WeaponsofOrder].ready then
    --    MaxDps:GlowCooldown(MR.WeaponsofOrder, cooldown[MR.WeaponsofOrder].ready);
    --end
    --
    --Venthyr
    --Heal
    --if covenantId == CN.Venthyr and cooldown[MR.FallenOrder].ready then
    --    MaxDps:GlowCooldown(MR.FallenOrder, cooldown[MR.FallenOrder].ready);
    --end
    --
    --NightFae
    if covenantId == CN.NightFae and cooldown[MR.FaelineStomp].ready then
        MaxDps:GlowCooldown(MR.FaelineStomp, cooldown[MR.FaelineStomp].ready)
    end
    --
    --Necrolord
    --Heal
    --if covenantId == CN.Necrolord and cooldown[MR.BonedustBrew].ready then
    --    MaxDps:GlowCooldown(MR.BonedustBrew, cooldown[MR.BonedustBrew].ready);
    --end

	if targetHp < health  and cooldown[MR.TouchofDeath].ready then
        return MR.TouchofDeath;
    end

    if cooldown[MR.RisingSunKick].ready then
        return MR.RisingSunKick;
    end

    if cooldown[MR.BlackoutKick].ready then
        return MR.BlackoutKick;
    end

    if targets > 1 and cooldown[MR.SpinningCraneKick].ready then
        return MR.SpinningCraneKick;
    end

    if cooldown[MR.TigerPalm].ready then
        return MR.TigerPalm;
    end

end