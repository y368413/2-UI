if select(2, UnitClass("player")) ~= "DRUID" then return end

local _, MaxDps_DruidTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Druid = MaxDps_DruidTable.Druid;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;
local Energy = Enum.PowerType.Energy;
local ComboPoints = Enum.PowerType.ComboPoints;

local FR = {
	Regrowth           = 8936,
	Bloodtalons        = 155672,
	CatForm            = 768,
	Prowl              = 5215,
	Berserk            = 106951,
	Rake               = 1822,
	RakeDot            = 155722,
	FerociousBite      = 22568,
	Rip                = 1079,
	Sabertooth         = 202031,
	PredatorySwiftness = 69369,
	TigersFury         = 5217,
	FeralFrenzy        = 274837,
	Incarnation        = 102543,
	SavageRoar         = 52610,
	PrimalWrath        = 285381,
	Maim               = 22570,
	IronJaws           = 276026,
	LunarInspiration   = 155580,
	BrutalSlash        = 202028,
	Thrash             = 106830,
	ScentOfBlood       = 285564,
	Swipe2             = 106785,
	Swipe              = 213764,
	Moonfire           = 155625,
	Clearcasting       = 135700,
	Shred              = 5221,
};

local A = {
	WildFleshrending = 279527,
};

setmetatable(A, Druid.spellMeta);
setmetatable(FR, Druid.spellMeta);

function Druid:Feral()
	local fd = MaxDps.FrameData;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local targets = MaxDps:SmartAoe();
	local timeToDie = fd.timeToDie;
	local energy = UnitPower('player', Energy);
	local energyMax = UnitPowerMax('player', Energy);
	local energyDeficit = energyMax - energy;

	fd.targets = targets;
	fd.energy = energy;
	fd.energyMax = energyMax;
	fd.energyDeficit = energyDeficit;

	local comboPoints = UnitPower('player', ComboPoints);
	fd.comboPoints = comboPoints;

	local Incarnation = talents[FR.Incarnation] and FR.Incarnation or FR.Berserk;
	fd.Incarnation = Incarnation;

	MaxDps:GlowEssences();
	-- cat_form,if=!buff.cat_form.up;
	if not buff[FR.CatForm].up then
		return FR.CatForm;
	end

	-- rake,if=buff.prowl.up|buff.shadowmeld.up;
	if buff[FR.Prowl].up then
		return FR.Rake;
	end

	-- call_action_list,name=cooldowns;
	local result = Druid:FeralCooldowns();
	if result then return result; end

	-- ferocious_bite,target_if=dot.rip.ticking&dot.rip.remains<3&target.time_to_die>10&(talent.sabertooth.enabled);
	if comboPoints >= 1 and
		debuff[FR.Rip].up and debuff[FR.Rip].remains < 3 and talents[FR.Sabertooth]
	then
		return FR.FerociousBite;
	end

	-- regrowth,if=combo_points=5&buff.predatory_swiftness.up&talent.bloodtalons.enabled&buff.bloodtalons.down;
	if currentSpell ~= FR.Regrowth and
		comboPoints >= 5 and buff[FR.PredatorySwiftness].up and talents[FR.Bloodtalons] and not buff[FR.Bloodtalons].up
	then
		return FR.Regrowth;
	end

	-- run_action_list,name=finishers,if=combo_points>4;
	if comboPoints > 4 then
		return Druid:FeralFinishers();
	end

	-- run_action_list,name=generators;
	return Druid:FeralGenerators();
end

function Druid:FeralCooldowns()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local talents = fd.talents;
	local azerite = fd.azerite;
	local energy = fd.energy;
	local energyDeficit = fd.energyDeficit;
	local comboPoints = fd.comboPoints;
	local Incarnation = fd.Incarnation;

	-- berserk,if=energy>=30&(cooldown.tigers_fury.remains>5|buff.tigers_fury.up);
	-- incarnation,if=energy>=30&(cooldown.tigers_fury.remains>15|buff.tigers_fury.up);
	MaxDps:GlowCooldown(
		Incarnation,
		cooldown[Incarnation].ready and
		energy >= 30 and
		(cooldown[FR.TigersFury].remains > 5 or buff[FR.TigersFury].up)
	);


	--if cooldown[FR.Berserk].ready and (energy >= 30 and (cooldown[FR.TigersFury].remains > 5 or buff[FR.TigersFury].up)) then
	--	return FR.Berserk;
	--end

	-- tigers_fury,if=energy.deficit>=60;
	if cooldown[FR.TigersFury].ready and energyDeficit >= 60 then
		return FR.TigersFury;
	end

	-- feral_frenzy,if=combo_points=0;
	if talents[FR.FeralFrenzy] and cooldown[FR.FeralFrenzy].ready and comboPoints <= 0 then
		return FR.FeralFrenzy;
	end


	--if talents[FR.Incarnation] and cooldown[FR.Incarnation].ready and (energy >= 30 and (cooldown[FR.TigersFury].remains > 15 or buff[FR.TigersFury].up)) then
	--	return FR.Incarnation;
	--end
end

function Druid:FeralFinishers()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local timeToDie = fd.timeToDie;
	local energy = fd.energy;
	local comboPoints = fd.comboPoints;

	-- savage_roar,if=buff.savage_roar.down;
	if talents[FR.SavageRoar] and comboPoints >= 1 and not buff[FR.SavageRoar].up then
		return FR.SavageRoar;
	end

	-- primal_wrath,target_if=spell_targets.primal_wrath>1&dot.rip.remains<4;
	if talents[FR.PrimalWrath] and comboPoints >= 1 and targets > 1 and debuff[FR.Rip].remains < 4 then
		return FR.PrimalWrath;
	end

	-- primal_wrath,target_if=spell_targets.primal_wrath>=2;
	if talents[FR.PrimalWrath] and comboPoints >= 1 and targets >= 2 then
		return FR.PrimalWrath;
	end

	-- rip,target_if=!ticking|(remains<=duration*0.3)&(!talent.sabertooth.enabled)|(remains<=duration*0.8&persistent_multiplier>dot.rip.pmultiplier)&target.time_to_die>8;
	if comboPoints >= 1 and (
		debuff[FR.Rip].refreshable
		--or
		--(remains <= duration*0.3) and (not talent[FR.Sabertooth]) or
		--(remains <= duration*0.8 and persistent_multiplier > debuff[FR.Rip].pmultiplier) and timeToDie > 8)
	) then
		return FR.Rip;
	end

	-- savage_roar,if=buff.savage_roar.remains<12;
	if talents[FR.SavageRoar] and comboPoints >= 1 and buff[FR.SavageRoar].remains < 12 then
		return FR.SavageRoar;
	end

	-- maim,if=buff.iron_jaws.up;
	if cooldown[FR.Maim].ready and comboPoints >= 1 and buff[FR.IronJaws].up then
		return FR.Maim;
	end

	-- ferocious_bite,max_energy=1;
	if energy >= 30 and comboPoints >= 5 then
		return FR.FerociousBite;
	end
end

function Druid:FeralGenerators()
	local fd = MaxDps.FrameData;
	local cooldown = fd.cooldown;
	local azerite = fd.azerite;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local currentSpell = fd.currentSpell;
	local talents = fd.talents;
	local targets = fd.targets;
	local timeToDie = fd.timeToDie;
	local comboPoints = fd.comboPoints;
	local energy = fd.energy;
	local Incarnation = fd.Incarnation;
	local desiredTargets = 2;
	local Swipe = MaxDps:FindSpell(FR.Swipe2) and FR.Swipe2 or FR.Swipe;

	-- regrowth,if=talent.bloodtalons.enabled&buff.predatory_swiftness.up&buff.bloodtalons.down&combo_points=4&dot.rake.remains<4;
	if currentSpell ~= FR.Regrowth and
		talents[FR.Bloodtalons] and
		buff[FR.PredatorySwiftness].up and
		not buff[FR.Bloodtalons].up and
		comboPoints >= 4 and
		debuff[FR.RakeDot].remains < 4
	then
		return FR.Regrowth;
	end

	-- regrowth,if=talent.bloodtalons.enabled&buff.bloodtalons.down&buff.predatory_swiftness.up&talent.lunar_inspiration.enabled&dot.rake.remains<1;
	if currentSpell ~= FR.Regrowth and
		talents[FR.Bloodtalons] and
		not buff[FR.Bloodtalons].up and
		buff[FR.PredatorySwiftness].up and
		talents[FR.LunarInspiration] and
		debuff[FR.RakeDot].remains < 1 then
		return FR.Regrowth;
	end

	-- brutal_slash,if=spell_targets.brutal_slash>desired_targets;
	if talents[FR.BrutalSlash] and cooldown[FR.BrutalSlash].ready and (targets > desiredTargets) then
		return FR.BrutalSlash;
	end

	-- thrash_cat,if=(refreshable)&(spell_targets.thrash_cat>2);
	if debuff[FR.Thrash].refreshable and targets > 2 then
		return FR.Thrash;
	end

	-- thrash_cat,if=(talent.scent_of_blood.enabled&buff.scent_of_blood.down)&spell_targets.thrash_cat>3;
	if (talents[FR.ScentOfBlood] and not buff[FR.ScentOfBlood].up) and targets > 3 then
		return FR.Thrash;
	end

	-- swipe_cat,if=buff.scent_of_blood.up;
	if not talents[FR.BrutalSlash] and buff[FR.ScentOfBlood].up then
		return Swipe;
	end

	-- rake,target_if=!ticking|(!talent.bloodtalons.enabled&remains<duration*0.3)&target.time_to_die>4;
	-- rake,target_if=talent.bloodtalons.enabled&buff.bloodtalons.up&((remains<=7)&persistent_multiplier>dot.rake.pmultiplier*0.85)&target.time_to_die>4;
	-- simplified
	if not debuff[FR.RakeDot].up or
		(not talents[FR.Bloodtalons] and debuff[FR.RakeDot].refreshable)
	then
		return FR.Rake;
	end

	if talents[FR.Bloodtalons] and buff[FR.Bloodtalons].up and debuff[FR.RakeDot].remains < 4 then
		return FR.Rake;
	end

	-- moonfire_cat,if=buff.bloodtalons.up&buff.predatory_swiftness.down&combo_points<5;
	if talents[FR.LunarInspiration] and buff[FR.Bloodtalons].up and not buff[FR.PredatorySwiftness].up and comboPoints < 5 then
		return FR.Moonfire;
	end

	-- brutal_slash,if=(buff.tigers_fury.up&(raid_event.adds.in>(1+max_charges-charges_fractional)*recharge_time));
	if talents[FR.BrutalSlash] and cooldown[FR.BrutalSlash].ready and buff[FR.TigersFury].up then
		return FR.BrutalSlash;
	end


	-- moonfire_cat,target_if=refreshable;
	if talents[FR.LunarInspiration] and debuff[FR.Moonfire].refreshable then
		return FR.Moonfire;
	end

	-- thrash_cat,if=refreshable&((variable.use_thrash=2&(!buff.incarnation.up|azerite.wild_fleshrending.enabled))|spell_targets.thrash_cat>1);
	if debuff[FR.Thrash].refreshable and targets > 1 and
		(not buff[Incarnation].up or azerite[A.WildFleshrending] > 0)
	then
		return FR.Thrash;
	end

	-- thrash_cat,if=refreshable&variable.use_thrash=1&buff.clearcasting.react&(!buff.incarnation.up|azerite.wild_fleshrending.enabled);
	--if debuff[FR.Thrash].refreshable and buff[FR.Clearcasting].up and (
	--	not buff[FR.Incarnation].up or azerite[A.WildFleshrending] > 0
	--) then
	--	return FR.Thrash;
	--end

	-- swipe_cat,if=spell_targets.swipe_cat>1;
	if not talents[FR.BrutalSlash] and targets > 1 then
		return Swipe;
	end

	if talents[FR.BrutalSlash] and cooldown[FR.BrutalSlash].ready and targets > 1 then
		return FR.BrutalSlash;
	end

	-- shred,if=dot.rake.remains>(action.shred.cost+action.rake.cost-energy)%energy.regen|buff.clearcasting.react;
	if (debuff[FR.RakeDot].remains > 6 and energy >= 40) or
		buff[FR.Clearcasting].up
	then
		return FR.Shred;
	end

	if debuff[FR.RakeDot].remains < 3 then
		return FR.Rake;
	end
end
