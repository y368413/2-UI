if select(2, UnitClass("player")) ~= "PRIEST" then return end

local Priest = MaxDps:NewModule('Priest');

-- Priest spells
local PR = {
	PowerWordFortitude = 21562
};

-- Shadow Spells
local SH = {
	Shadowform = 232698,
	MindBlast = 8092,
	ShadowWordVoid = 205351,
	ShadowWordPain = 589,
	VampiricTouch = 34914,
	Misery = 238558,
	VoidEruption = 228260,
	DarkAscension = 280711,
	Voidform = 194249,
	VoidBolt = 205448,
	DarkThought = 341207,
	DarkVoid = 263346,
	SurrenderToMadness = 319952,
	Mindbender = 200174,
	Shadowfiend = 132603,
	ShadowCrash = 205385,
	MindSear = 48045,
	ShadowWordDeath = 32379,
	VoidTorrent = 263165,
	LegacyOfTheVoid = 193225,
	MindFlay = 15407,
	Damnation = 341374,
	DevouringPlague = 335467,
	UnfurlingDarkness = 341282,
	Voidling = 254232,
	SearingNightmare = 341385
};

-- Disc Spells
local DI = {
	Penance = 47540,
	PurgeTheWicked = 204197,
	PurgeTheWickedAura = 204213,
	Penance = 47540,
	Smite = 585,
	SmiteAura = 208772,
	PowerWordSolace = 129250,
	ShadowWordPain = 589,
	Schism = 214621,
	DivineStar = 110744,
	Shadowfiend = 34433,
	Mindbender = 123040
};

local spellMeta = {
	__index = function(t, k)
		--print('Spell Key ' .. k .. ' not found!');
	end
}

setmetatable(SH, spellMeta);

function Priest:Enable()
	MaxDps:Print(MaxDps.Colors.Info .. 'Priest [Shadow, Discipline]');

	if MaxDps.Spec == 1 then
		MaxDps.NextSpell = Priest.Discipline;
	elseif MaxDps.Spec == 2 then
		MaxDps.NextSpell = Priest.Holy;
	elseif MaxDps.Spec == 3 then
		MaxDps.NextSpell = Priest.Shadow;
	end

	return true;
end

function Priest:Discipline()
	local fd = MaxDps.FrameData;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local currentSpell = fd.currentSpell;
	local buff = fd.buff;
	local cooldown = fd.cooldown;

	MaxDps:GlowEssences();

	if not buff[PR.PowerWordFortitude].up then
		return PR.PowerWordFortitude;
	end

	if talents[DI.Mindbender] then
		MaxDps:GlowCooldown(DI.Mindbender, cooldown[DI.Mindbender].ready);
	else
		MaxDps:GlowCooldown(DI.Shadowfiend, cooldown[DI.Shadowfiend].ready);
	end

	if talents[DI.PurgeTheWicked] then
		if debuff[DI.PurgeTheWickedAura].refreshable then
			return DI.PurgeTheWicked;
		end
	else
		if debuff[DI.ShadowWordPain].refreshable then
			return DI.ShadowWordPain;
		end
	end

	if talents[DI.Schism] and cooldown[DI.Schism].ready and currentSpell ~= DI.Schism then
		return DI.Schism;
	end

	if talents[DI.PowerWordSolace] and cooldown[DI.PowerWordSolace].ready then
		return DI.PowerWordSolace;
	end

	if cooldown[DI.Penance].ready then
		return DI.Penance;
	end

	return DI.Smite;
end

function Priest:Holy()
	return nil;
end

function Priest:Shadow()
	local fd = MaxDps.FrameData;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local buff = fd.buff;
	local cooldown = fd.cooldown;
	local targets = MaxDps:SmartAoe();
	fd.targets = targets;
	fd.targetHp = MaxDps:TargetPercentHealth();

	MaxDps:GlowEssences();

	return Priest:ShadowSingle();
end

function Priest:ShadowSingle()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local timeToDie = fd.timeToDie;
	local targets = fd.targets;
	local targetHp = MaxDps:TargetPercentHealth() * 100;
	local VoidBolt = fd.VoidBolt;
	local gcd = fd.gcd;
	local insanity = UnitPower('player', 13);

	-- Voidform
	if insanity >= 88 and buff[SH.Voidform].up then
		return SH.DevouringPlague;
	end

	if insanity < 88 and buff[SH.Voidform].up and cooldown[SH.VoidBolt].ready then
		return SH.VoidBolt;
	end

	if cooldown[SH.MindBlast].charges >= 1 and buff[SH.Voidform].up then
		return SH.MindBlast;
	end

	-- buff
	if not buff[PR.PowerWordFortitude].up then
		return PR.PowerWordFortitude;
	end

	-- Rotation
	if talents[SH.Damnation] and cooldown[SH.Damnation].ready then
		return SH.Damnation;
	end

	if talents[SH.Misery] and not debuff[SH.ShadowWordPain].up and currentSpell ~= SH.VampiricTouch and timeToDie >= 7 then
		return SH.VampiricTouch;
	else
		if not talents[SH.Misery] and not debuff[SH.VampiricTouch].up and timeToDie >= 7 then
			return SH.VampiricTouch;
		end
	end

	if not talents[SH.Misery] and not debuff[SH.ShadowWordPain].up and timeToDie >= 5 then
		return SH.ShadowWordPain;
	end

	if insanity >= 40 and cooldown[SH.VoidEruption].remains <= 3 and cooldown[SH.Voidling].ready and
		not talents[SH.Mindbender] then
		return SH.Voidling;
	else
		if insanity >= 40 and cooldown[SH.VoidEruption].remains <= 3 and cooldown[SH.Shadowfiend].ready and
			not talents[SH.Mindbender] then
			return SH.Shadowfiend;
		end
	end

	if talents[SH.Mindbender] and insanity > 40 and cooldown[SH.VoidEruption].remains <= 3 and
		cooldown[SH.Mindbender].ready then
		return SH.Mindbender;
	end

	if insanity > 40 and cooldown[SH.VoidEruption].ready and not buff[SH.Voidform].up then
		return SH.VoidEruption;
	end

	if talents[SH.Damnation] and cooldown[SH.Damnation].ready then
		return SH.Damnation;
	end

	if talents[SH.Misery] and not debuff[SH.ShadowWordPain].up and currentSpell ~= SH.VampiricTouch then
		return SH.VampiricTouch;
	end

	if not talents[SH.Misery] and not debuff[SH.ShadowWordPain].up then
		return SH.ShadowWordPain;
	end

	if talents[SH.SearingNightmare] and targets >= 3 and insanity >= 35 and debuff[SH.MindSear].up then
		return SH.SearingNightmare;
	else
		if insanity > 50 and not debuff[SH.DevouringPlague].up then
			return SH.DevouringPlague;
		end
	end

	if talents[SH.UnfurlingDarkness] and buff[SH.UnfurlingDarkness].up then
		return SH.VampiricTouch;
	end

	if targetHp <= 20 and cooldown[SH.ShadowWordDeath].ready then
		return SH.ShadowWordDeath;
	end

	if talents[SH.SurrenderToMadness] and not buff[SH.Voidform].up and timeToDie < 25 then
		return SH.SurrenderToMadness;
	end

	if debuff[SH.ShadowWordPain].up and debuff[SH.VampiricTouch].up and talents[SH.VoidTorrent] and
		cooldown[SH.VoidTorrent].ready and not buff[SH.Voidform].up then
		return SH.VoidTorrent;
	end

	if buff[SH.DarkThought].up and currentSpell ~= SH.MindFlay then
		return SH.MindFlay;
	end
	if buff[SH.DarkThought].up and currentSpell == SH.MindFlay then
		return SH.MindBlast;
	end

	if targets <= 1 then
		return SH.MindFlay;
	else
		if targets >= 2 then
			return SH.MindSear;
		end
	end
end
