if select(2, UnitClass("player")) ~= "PRIEST" then return end

local _, MaxDps_PriestTable = ...;

if not MaxDps then
	return;
end

local Priest = MaxDps_PriestTable.Priest;

local DI = {
	Smite = 585,
	Penance = 47540,
	MindBlast = 8092,
	MindSear = 48045,
	ShadowWordDeath = 32379,
	Shadowfiend = 34433,
	PowerInfusion = 10060,
	PurgetheWickedDebuff = 204213,

	--Talents
	Schism = 214621,
	Mindbender = 123040,
	PowerWordSolace = 129250,
	ShadowCovenant = 314867,
	PurgetheWicked = 204197,
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

setmetatable(DI, Priest.spellMeta);

function Priest:Discipline()
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
    MaxDps:GlowCooldown(DI.PowerInfusion, cooldown[DI.PowerInfusion].ready);
	if not talents[DI.Mindbender] and cooldown[DI.Shadowfiend].ready then
        MaxDps:GlowCooldown(DI.Shadowfiend, cooldown[DI.Shadowfiend].ready);
    end


	--talents
	if talents[DI.Mindbender] and cooldown[DI.Mindbender].ready then
        MaxDps:GlowCooldown(DI.Mindbender, cooldown[DI.Mindbender].ready);
    end

	--Covenant
    --Kyrian
    if covenantId == CN.Kyrian and cooldown[DI.BoonoftheAscended].ready then
        MaxDps:GlowCooldown(DI.BoonoftheAscended, cooldown[DI.BoonoftheAscended].ready);
    end

	--Venthyr
    if covenantId == CN.Venthyr and cooldown[DI.Mindgames].ready then
        MaxDps:GlowCooldown(DI.Mindgames, cooldown[DI.Mindgames].ready);
    end

	--NightFae
    if covenantId == CN.NightFae and cooldown[DI.FaeGuardians].ready then
        MaxDps:GlowCooldown(DI.FaeGuardians, cooldown[DI.FaeGuardians].ready);
    end

	--Necrolord
	if covenantId == CN.Necrolord and cooldown[DI.Necrolord].ready then
        MaxDps:GlowCooldown(DI.Necrolord, cooldown[DI.Necrolord].ready);
    end

	if talents[DI.ShadowCovenant] and cooldown[DI.ShadowCovenant].ready then
        return DI.ShadowCovenant;
    end

	if talents[DI.Schism] and cooldown[DI.Schism].ready then
        return DI.Schism;
    end

	if targetHp <= 20 and cooldown[DI.ShadowWordDeath].ready then
        return DI.ShadowWordDeath;
    end

	if talents[DI.PurgetheWicked] and debuff[DI.PurgetheWickedDebuff].refreshable and cooldown[DI.PurgetheWicked].ready then
        return DI.PurgetheWicked;
    end

	if talents[DI.DivineStar] and cooldown[DI.DivineStar].ready then
        return DI.DivineStar;
    end

	if talents[DI.Halo] and cooldown[DI.Halo].ready then
        return DI.Halo;
    end

	if talents[DI.PowerWordSolace] and cooldown[DI.PowerWordSolace].ready then
        return DI.PowerWordSolace;
    end

	if cooldown[DI.Penance].ready then
        return DI.Penance;
    end

	if cooldown[DI.MindBlast].ready then
        return DI.MindBlast;
    end

	if targets >= 2 and cooldown[DI.MindSear].ready then
		return DI.MindSear;
	end

	if cooldown[DI.Smite].ready then
        return DI.Smite;
    end

end
