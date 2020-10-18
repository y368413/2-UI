if select(2, UnitClass("player")) ~= "MONK" then return end

local _, MaxDps_MonkTable = ...;

--- @type MaxDps
if not MaxDps then
	return
end

local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitHealth = UnitHealth;
local UnitHealthMax = UnitHealthMax;
local GetPowerRegen = GetPowerRegen;
local Energy = Enum.PowerType.Energy;
local Monk = MaxDps_MonkTable.Monk;

local BR = {
	ChiBurst               = 123986,
	ChiWave                = 115098,
	GiftOfTheOx            = 124502,
	DampenHarm             = 122278,
	FortifyingBrew         = 115203,
	InvokeNiuzaoTheBlackOx = 132578,
	IronskinBrew           = 115308,
	BlackoutCombo          = 196736,
	BlackoutComboAura      = 228563,
	ElusiveBrawler         = 195630,
	BlackOxBrew            = 115399,
	PurifyingBrew          = 119582,
	KegSmash               = 121253,
	TigerPalm              = 100780,
	RushingJadeWind        = 116847,
	SpecialDelivery        = 196730,
	BlackoutStrike         = 205523,
	BreathOfFire           = 115181,
	BreathOfFireDot        = 123725,
};

function Monk:Brewmaster()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local gcd = fd.gcd;
	local timeToDie = fd.timeToDie;
	local energy = UnitPower('player', Energy);
	local energyRegen = GetPowerRegen();
	local health = UnitHealth('player');
	local healthMax = UnitHealthMax('player');

	MaxDps:GlowEssences();

	-- gift_of_the_ox,if=health<health.max*0.65;
	--if health < healthMax * 0.65 then
	--	return BR.GiftOfTheOx;
	--end

	-- dampen_harm,if=incoming_damage_1500ms&buff.fortifying_brew.down;
	--if talents[BR.DampenHarm] and cooldown[BR.DampenHarm].ready and (incomingDamage1500ms and not buff[BR.FortifyingBrew].up) then
	--	return BR.DampenHarm;
	--end

	-- fortifying_brew,if=incoming_damage_1500ms&(buff.dampen_harm.down|buff.diffuse_magic.down);
	--if cooldown[BR.FortifyingBrew].ready and (incomingDamage1500ms and (not buff[BR.DampenHarm].up or not buff[BR.DiffuseMagic].up)) then
	--	return BR.FortifyingBrew;
	--end

	-- invoke_niuzao_the_black_ox,if=target.time_to_die>25;
	if talents[BR.InvokeNiuzaoTheBlackOx] and cooldown[BR.InvokeNiuzaoTheBlackOx].ready and timeToDie > 25 then
		return BR.InvokeNiuzaoTheBlackOx;
	end

	-- ironskin_brew,if=buff.blackout_combo.down&incoming_damage_1999ms>(health.max*0.1+stagger.last_tick_damage_4)&buff.elusive_brawler.stack<2&!buff.ironskin_brew.up;
	--if cooldown[BR.IronskinBrew].ready and (not buff[BR.BlackoutCombo].up and incomingDamage1999ms > (healthMax * 0.1 + staggerLastTickDamage4) and buff[BR.ElusiveBrawler].count < 2 and not buff[BR.IronskinBrew].up) then
	--	return BR.IronskinBrew;
	--end

	-- ironskin_brew,if=cooldown.brews.charges_fractional>1&cooldown.black_ox_brew.remains<3;
	--if cooldown[BR.IronskinBrew].ready and (cooldown[BR.Brews].charges > 1 and cooldown[BR.BlackOxBrew].remains < 3) then
	--	return BR.IronskinBrew;
	--end

	-- purifying_brew,if=stagger.pct>(6*(3-(cooldown.brews.charges_fractional)))&(stagger.last_tick_damage_1>((0.02+0.001*(3-cooldown.brews.charges_fractional))*stagger.last_tick_damage_30));
	--if cooldown[BR.PurifyingBrew].ready and (staggerPct > (6 * (3 - (cooldown[BR.Brews].charges))) and (staggerLastTickDamage1 > ((0.02 + 0.001 * (3 - cooldown[BR.Brews].charges)) * staggerLastTickDamage30))) then
	--	return BR.PurifyingBrew;
	--end

	-- black_ox_brew,if=cooldown.brews.charges_fractional<0.5;
	if talents[BR.BlackOxBrew] and cooldown[BR.BlackOxBrew].ready and cooldown[BR.IronskinBrew].charges < 0.5 then
		return BR.BlackOxBrew;
	end

	-- black_ox_brew,if=(energy+(energy.regen*cooldown.keg_smash.remains))<40&buff.blackout_combo.down&cooldown.keg_smash.up;
	if talents[BR.BlackOxBrew] and cooldown[BR.BlackOxBrew].ready and (
		(energy + (energyRegen * cooldown[BR.KegSmash].remains)) < 40 and
			not buff[BR.BlackoutComboAura].up and cooldown[BR.KegSmash].up
	) then
		return BR.BlackOxBrew;
	end

	-- keg_smash,if=spell_targets>=2;
	if cooldown[BR.KegSmash].ready and energy >= 40 and targets >= 2 then
		return BR.KegSmash;
	end

	-- tiger_palm,if=talent.rushing_jade_wind.enabled&buff.blackout_combo.up&buff.rushing_jade_wind.up;
	if talents[BR.RushingJadeWind] and buff[BR.BlackoutComboAura].up and buff[BR.RushingJadeWind].up then
		return BR.TigerPalm;
	end

	-- tiger_palm,if=(talent.invoke_niuzao_the_black_ox.enabled|talent.special_delivery.enabled)&buff.blackout_combo.up;
	if (talents[BR.InvokeNiuzaoTheBlackOx] or talents[BR.SpecialDelivery]) and buff[BR.BlackoutComboAura].up then
		return BR.TigerPalm;
	end

	-- blackout_strike;
	if cooldown[BR.BlackoutStrike].ready then
		return BR.BlackoutStrike;
	end

	-- keg_smash;
	if cooldown[BR.KegSmash].ready and energy >= 40 then
		return BR.KegSmash;
	end

	-- rushing_jade_wind,if=buff.rushing_jade_wind.down;
	if talents[BR.RushingJadeWind] and cooldown[BR.RushingJadeWind].ready and not buff[BR.RushingJadeWind].up then
		return BR.RushingJadeWind;
	end

	-- breath_of_fire,if=buff.blackout_combo.down&(buff.bloodlust.down|(buff.bloodlust.up&&dot.breath_of_fire_dot.refreshable));
	if cooldown[BR.BreathOfFire].ready and
		not buff[BR.BlackoutComboAura].up and debuff[BR.BreathOfFireDot].refreshable
	then
		return BR.BreathOfFire;
	end

	-- chi_burst;
	if talents[BR.ChiBurst] and cooldown[BR.ChiBurst].ready and currentSpell ~= BR.ChiBurst then
		return BR.ChiBurst;
	end

	-- chi_wave;
	if talents[BR.ChiWave] and cooldown[BR.ChiWave].ready then
		return BR.ChiWave;
	end

	-- tiger_palm,if=!talent.blackout_combo.enabled&cooldown.keg_smash.remains>gcd&(energy+(energy.regen*(cooldown.keg_smash.remains+gcd)))>=65;
	if energy >= 25 and
		not talents[BR.BlackoutCombo] and
		cooldown[BR.KegSmash].remains > gcd and
		(energy + (energyRegen * (cooldown[BR.KegSmash].remains + gcd))) >= 65
	then
		return BR.TigerPalm;
	end

	-- rushing_jade_wind;
	if talents[BR.RushingJadeWind] and cooldown[BR.RushingJadeWind].ready then
		return BR.RushingJadeWind;
	end
end
