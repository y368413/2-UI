if select(2, UnitClass("player")) ~= "PRIEST" then return end

local _, MaxDps_PriestTable = ...;

if not MaxDps then
	return;
end

local Priest = MaxDps_PriestTable.Priest;


local HL = {
	Smite = 585,
	ShadowWordPain = 589,
	HolyFire = 14914,
	ShadowWordDeath = 32379,
	PowerInfusion = 10060,

	--Talents
	DivineStar = 110744,
	Halo = 120517,

	--Kyrian
	BoonoftheAscended = 325013,

	--NightFae
	FaeGuardians = 327661,

	--Venthyr
	Mindgames = 323673,

	--Necrolord
	UnholyNova = 324724,

};

local CN = {
	None      = 0,
	Kyrian    = 1,
	Venthyr   = 2,
	NightFae  = 3,
	Necrolord = 4
};

setmetatable(HL, Priest.spellMeta);

function Priest:Holy()
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
    MaxDps:GlowCooldown(HL.PowerInfusion, cooldown[HL.PowerInfusion].ready);

	--talents

	--Covenant
    --Kyrian
    if covenantId == CN.Kyrian and cooldown[HL.BoonoftheAscended].ready then
        MaxDps:GlowCooldown(HL.BoonoftheAscended, cooldown[HL.BoonoftheAscended].ready);
    end

	--Venthyr
    if covenantId == CN.Venthyr and cooldown[HL.Mindgames].ready then
        MaxDps:GlowCooldown(HL.Mindgames, cooldown[HL.Mindgames].ready);
    end

	--NightFae
    if covenantId == CN.NightFae and cooldown[HL.FaeGuardians].ready then
        MaxDps:GlowCooldown(HL.FaeGuardians, cooldown[HL.FaeGuardians].ready);
    end

	--Necrolord
	if covenantId == CN.Necrolord and cooldown[HL.UnholyNova].ready then
        MaxDps:GlowCooldown(HL.UnholyNova, cooldown[HL.UnholyNova].ready);
    end


	if talents[HL.DivineStar] and cooldown[HL.DivineStar].ready then
        return HL.DivineStar;
    end

	if talents[HL.Halo] and cooldown[HL.Halo].ready then
        return HL.Halo;
    end

	if targetHp <= 20 and cooldown[HL.ShadowWordDeath].ready then
        return HL.ShadowWordDeath;
    end

	if debuff[HL.ShadowWordPain].refreshable and cooldown[HL.ShadowWordPain].ready then
        return HL.ShadowWordPain;
    end

	if cooldown[HL.HolyFire].ready then
        return HL.HolyFire;
    end

	if cooldown[HL.Smite].ready then
        return HL.Smite;
    end

end
