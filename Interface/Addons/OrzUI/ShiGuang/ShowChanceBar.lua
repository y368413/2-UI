--## Author: JANY  ## Version: 8.2.5
J_PAPERDOLL_STATINFO = {
	-- General
	["HEALTH"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetHealth(statFrame, unit); end
	},
	["POWER"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetPower(statFrame, unit); end
	},
	["ALTERNATEMANA"] = {
		-- Only appears for Druids when in shapeshift form
		updateFunc = function(statFrame, unit) J_BarFrame_SetAlternateMana(statFrame, unit); end
	},
	["ITEMLEVEL"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetItemLevel(statFrame, unit); end
	},
	["MOVESPEED"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetMovementSpeed(statFrame, unit); end
	},

	-- Base stats
	["STRENGTH"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetStat(statFrame, unit, LE_UNIT_STAT_STRENGTH); end
	},
	["AGILITY"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetStat(statFrame, unit, LE_UNIT_STAT_AGILITY); end
	},
	["INTELLECT"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetStat(statFrame, unit, LE_UNIT_STAT_INTELLECT); end
	},
	["STAMINA"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetStat(statFrame, unit, LE_UNIT_STAT_STAMINA); end
	},

	-- Enhancements
	["CRITCHANCE"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetCritChance(statFrame, unit); end
	},
	["HASTE"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetHaste(statFrame, unit); end
	},
	["MASTERY"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetMastery(statFrame, unit); end
	},
	["VERSATILITY"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetVersatility(statFrame, unit); end
	},
	["LIFESTEAL"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetLifesteal(statFrame, unit); end
	},
	["AVOIDANCE"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetAvoidance(statFrame, unit); end
	},
	["SPEED"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetSpeed(statFrame, unit); end
	},

	-- Attack
	["ATTACK_DAMAGE"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetDamage(statFrame, unit); end
	},
	["ATTACK_AP"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetAttackPower(statFrame, unit); end
	},
	["ATTACK_ATTACKSPEED"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetAttackSpeed(statFrame, unit); end
	},
	["ENERGY_REGEN"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetEnergyRegen(statFrame, unit); end
	},
	["RUNE_REGEN"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetRuneRegen(statFrame, unit); end
	},
	["FOCUS_REGEN"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetFocusRegen(statFrame, unit); end
	},

	-- Spell
	["SPELLPOWER"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetSpellPower(statFrame, unit); end
	},
	["MANAREGEN"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetManaRegen(statFrame, unit); end
	},

	-- Defense
	["ARMOR"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetArmor(statFrame, unit); end
	},
	["DODGE"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetDodge(statFrame, unit); end
	},
	["PARRY"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetParry(statFrame, unit); end
	},
	["BLOCK"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetBlock(statFrame, unit); end
	},
	["STAGGER"] = {
		updateFunc = function(statFrame, unit) J_BarFrame_SetStagger(statFrame, unit); end
	},
};
J_PAPERDOLL_STATCATEGORIES= {
	[1] = {
		categoryFrame = "AttributesCategory",
		stats = {
			[1] = { stat = "STRENGTH", primary = LE_UNIT_STAT_STRENGTH },
			[2] = { stat = "AGILITY", primary = LE_UNIT_STAT_AGILITY },
			[3] = { stat = "INTELLECT", primary = LE_UNIT_STAT_INTELLECT },
			[4] = { stat = "STAMINA"},
			[5] = { stat = "ARMOR" },
			[6] = { stat = "STAGGER", hideAt = 0, roles = { "TANK" }},
			[7] = { stat = "MANAREGEN", roles =  { "HEALER" } },
			[8] = { stat = "HEALTH"},
			[9] = { stat = "POWER"},
			[10] = { stat = "ALTERNATEMANA"},
			[11] = { stat = "ITEMLEVEL"},
			[12] = { stat = "MOVESPEED"},


		},
	},
	[2] = {
		categoryFrame = "EnhancementsCategory",
		stats = {
			{ stat = "CRITCHANCE", hideAt = 0 },
			{ stat = "HASTE", hideAt = 0 },
			{ stat = "MASTERY", hideAt = 0 },
			{ stat = "VERSATILITY", hideAt = 0 },
			{ stat = "LIFESTEAL", hideAt = 0 },
			{ stat = "AVOIDANCE", hideAt = 0 },
			{ stat = "SPEED", hideAt = 0 },
			{ stat = "DODGE", roles =  { "TANK" } },
			{ stat = "PARRY", hideAt = 0, roles =  { "TANK" } },
			{ stat = "BLOCK", hideAt = 0, showFunc = C_PaperDollInfo.OffhandHasShield },
		},
	},
};
local J_BarFrame = CreateFrame("Frame",nil,UIParent)
J_BarFrame:RegisterEvent("ADDON_LOADED")

local function J_Initializationframe()
	J_BarFrame:ClearAllPoints()
	J_BarFrame:SetFrameStrata("BACKGROUND")
	J_BarFrame:SetScale(ShiGuangDB["ShowChanceBarScale"])
	J_BarFrame:SetWidth(160) -- Set these to whatever height/width is needed 
	J_BarFrame:SetHeight(100) -- for your Texture
	J_BarFrame:EnableMouse(true)
	J_BarFrame:SetMovable(true)
	--J_BarFrame:SetPropagateKeyboardInput(true)
	J_BarFrame:SetPoint(ShiGuangDB["ShowChanceBarPoint"],UIParent,ShiGuangDB["ShowChanceBarRelay"],ShiGuangDB["ShowChanceBarX"],ShiGuangDB["ShowChanceBarY"])
	J_BarFrame:Show()

	J_BarFrame:SetScript("OnMouseDown", J_BarFrame.StartMoving)
	J_BarFrame:SetScript("OnMouseUp", J_BarFrame.StopMovingOrSizing)
	J_BarFrame:SetScript("OnLeave", function(self)
		local p1,_,r1,x1,y1 = J_BarFrame:GetPoint()
		ShiGuangDB["ShowChanceBarPoint"]=p1
		ShiGuangDB["ShowChanceBarRelay"]=r1
		ShiGuangDB["ShowChanceBarX"]=x1
		ShiGuangDB["ShowChanceBarY"] =y1  
	end);

	J_BarFrame:SetScript("OnMouseWheel", function(self, direction)
	    if(direction > 0) then
	        ShiGuangDB["ShowChanceBarScale"]=ShiGuangDB["ShowChanceBarScale"]+0.05
	        J_BarFrame:SetScale(ShiGuangDB["ShowChanceBarScale"])
	    else
	        ShiGuangDB["ShowChanceBarScale"]=ShiGuangDB["ShowChanceBarScale"]-0.05
	        J_BarFrame:SetScale(ShiGuangDB["ShowChanceBarScale"])
	    end
	end);
end

function J_Mastery_OnEnter(statFrame)
	statFrame:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(statFrame, "ANCHOR_RIGHT")
		GameTooltip:AddLine(self.tooltip)
		GameTooltip:AddLine(self.tooltip2)
		GameTooltip:Show()
	end)
	statFrame:SetScript("OnLeave", function(self)
		if GameTooltip:IsOwned(statFrame) then
			GameTooltip:Hide()
		end
	end)
	statFrame.UpdateTooltip = statFrame.onEnterFunc;
end

function J_BarFrame:J_CreateNewbar(index)
	local barName = "J_BarFrame_Bar"..index;
	local bar = _G[barName];
	if bar then return end
	bar = CreateFrame("StatusBar", barName, self)
	bar:SetScale(self:GetScale())
	bar:SetSize(190, 6)
	bar:SetPoint("CENTER", self,"CENTER", 0, -23*(index-1))

	bar:SetStatusBarTexture([[Interface\AddOns\OrzUI\Media\normTex]])
	bar:Hide()
	--J_Mastery_OnEnter(bar)
	

    bar.RightValue = bar:CreateFontString(nil, "ARTWORK")
    bar.RightValue:SetFont("Interface\\AddOns\\OrzUI\\Media\\Fonts\\Pixel.ttf", 16, "THINOUTLINE")
    bar.RightValue:SetShadowOffset(0, 0)
    bar.RightValue:SetPoint("RIGHT", bar, 0, 12)
    bar.RightValue:SetVertexColor(1, 1, 1)

    bar.LeftName = bar:CreateFontString(nil, "ARTWORK")
    bar.LeftName:SetFont(STANDARD_TEXT_FONT, 12, "THINOUTLINE")
    bar.LeftName:SetShadowOffset(0, 0)
    bar.LeftName:SetPoint("LEFT", bar, "LEFT", 0, 12)

	bar.Background = bar:CreateTexture(nil, "BACKGROUND")
	bar.Background:SetAllPoints(bar)
	bar.Background:SetTexture([[Interface\AddOns\OrzUI\Media\normTex]])
	bar.Background:SetVertexColor(0.25, 0.25, 0.25, 1)

	bar.BackgroundShadow = CreateFrame("Frame", nil, bar, "BackdropTemplate")
	bar.BackgroundShadow:SetFrameStrata("BACKGROUND")
	bar.BackgroundShadow:SetPoint("TOPLEFT", -4, 4)
	bar.BackgroundShadow:SetPoint("BOTTOMRIGHT", 4, -4)
	bar.BackgroundShadow:SetBackdrop({
	        BgFile = [[Interface\ChatFrame\ChatFrameBackground]],
	        edgeFile = [[Interface\Addons\OrzUI\media\glowTex]], edgeSize = 4,
	        insets = {left = 2, right = 2, top = 2, bottom = 2}
	    })
	bar.BackgroundShadow:SetBackdropColor(0.15, 0.15, 0.15, 1)
	bar.BackgroundShadow:SetBackdropBorderColor(0, 0, 0)	


end
function blend_color(f)
	local r, g, b = 0, 255, 0
	if f >255 then 
		r = 255
		g = 255 - (f -255)
	else
		r = f 
	end
    return r, g, b
end
function J_BarFrame:J_SetBarData(statFrame,j_name,j_value,j_MinValues,j_MaxValues)
	statFrame.LeftName:SetText(j_name)
	statFrame.RightValue:SetText(j_value > 0 and format("%d", j_value + 0.5) or "")
	while(j_value > j_MaxValues) do
	   j_MaxValues = j_MaxValues * 1.1
	end

	--500
	--100
	--statFrame:SetStatusBarColor(0, 255, 0) 绿
	--statFrame:SetStatusBarColor(255, 0, 0)
	--statFrame:SetStatusBarColor(255, 255, 0) 黄
	local r,g,b  = blend_color(math.ceil(j_value / j_MaxValues*500))
	

		statFrame:SetStatusBarColor(r/255,g/255,b/255)

	
	
	statFrame:SetMinMaxValues(j_MinValues,j_MaxValues)
	statFrame:SetValue(j_value)
	statFrame:Show()
end




function J_BarFrame:J_ADDON_LOADED()
	if ShiGuangDB["ShowChanceBarPoint"] == nil then ShiGuangDB["ShowChanceBarPoint"] = "LEFT" end
	if ShiGuangDB["ShowChanceBarRelay"] == nil then ShiGuangDB["ShowChanceBarRelay"] = "LEFT" end
	if ShiGuangDB["ShowChanceBarX"] == nil then ShiGuangDB["ShowChanceBarX"] = 21 end
	if ShiGuangDB["ShowChanceBarY"] == nil then ShiGuangDB["ShowChanceBarY"] = -120 end
	if ShiGuangDB["ShowChanceBarScale"] == nil then ShiGuangDB["ShowChanceBarScale"] = 1 end
	--if ShiGuangDB.ShowChanceBarConfig ~= nil then 
		ShiGuangDB.ShowChanceBarConfig = {
			["ITEMLEVEL"] = { name = "物品等级" , FRAMEINDEX = 1, isEnable = true},
			["STAMINA"] = { name = "耐力" , FRAMEINDEX = 2, isEnable = false},
			["HEALTH"] = { name = "生命" , FRAMEINDEX = 3, isEnable = false},
			["POWER"] = { name = "怒气值" , FRAMEINDEX = 4, isEnable = false},
			["STRENGTH"] = { name = "力量" , FRAMEINDEX = 2, isEnable = false},
			["AGILITY"] = { name = "敏捷" , FRAMEINDEX = 3,isEnable = false},
			["INTELLECT"] = { name = "智力" , FRAMEINDEX = 4, isEnable = false},
			["CRITCHANCE"] = { name = "暴击" , FRAMEINDEX = 2, isEnable = true},
			["HASTE"] = { name = "急速" , FRAMEINDEX = 3, isEnable = true},
			["VERSATILITY"] = { name = "全能" , FRAMEINDEX = 4, isEnable = true},
			["MASTERY"] = { name = "精通" , FRAMEINDEX = 5, isEnable = true},
			["LIFESTEAL"] = { name = "吸血" , FRAMEINDEX = 6, isEnable = true},
			["MOVESPEED"] = { name = "移动速度" , FRAMEINDEX = 7, isEnable = true},
			["SPEED"] = { name = "加速" , FRAMEINDEX = 8, isEnable = false},
			["ALTERNATEMANA"] = { name = "法力值" , FRAMEINDEX = 12, isEnable = false},
		} 
	--end
	for k,v in pairs(ShiGuangDB.ShowChanceBarConfig) do
		if v.isEnable then
			J_BarFrame:J_CreateNewbar(ShiGuangDB.ShowChanceBarConfig[k].FRAMEINDEX)
		end
	end
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("CHARACTER_POINTS_CHANGED");
	self:RegisterEvent("UNIT_MODEL_CHANGED");
	self:RegisterEvent("UNIT_LEVEL");
	self:RegisterEvent("UNIT_STATS");
	self:RegisterEvent("UNIT_RANGEDDAMAGE");
	self:RegisterEvent("UNIT_ATTACK_POWER");
	self:RegisterEvent("UNIT_RANGED_ATTACK_POWER");
	self:RegisterEvent("UNIT_ATTACK");
	self:RegisterEvent("UNIT_SPELL_HASTE");
	self:RegisterEvent("UNIT_RESISTANCES");
	self:RegisterEvent("PLAYER_GUILD_UPDATE");
	self:RegisterEvent("SKILL_LINES_CHANGED");
	self:RegisterEvent("COMBAT_RATING_UPDATE");
	self:RegisterEvent("MASTERY_UPDATE");
	self:RegisterEvent("SPEED_UPDATE");
	self:RegisterEvent("LIFESTEAL_UPDATE");
	self:RegisterEvent("AVOIDANCE_UPDATE");
	self:RegisterEvent("KNOWN_TITLES_UPDATE");
	self:RegisterEvent("UNIT_NAME_UPDATE");
	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self:RegisterEvent("BAG_UPDATE");
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	self:RegisterEvent("PLAYER_AVG_ITEM_LEVEL_UPDATE");
	self:RegisterEvent("PLAYER_DAMAGE_DONE_MODS");
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
	self:RegisterUnitEvent("UNIT_DAMAGE", "player");
	self:RegisterUnitEvent("UNIT_ATTACK_SPEED", "player");
	self:RegisterUnitEvent("UNIT_MAXHEALTH", "player");
	self:RegisterUnitEvent("UNIT_AURA", "player");
	self:RegisterEvent("SPELL_POWER_CHANGED");
	self:RegisterEvent("CHARACTER_ITEM_FIXUP_NOTIFICATION");
	self:RegisterEvent("TRIAL_STATUS_UPDATE");
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
end


-- This makes sure the update only happens once at the end of the frame
function J_BarFrame_QueuedUpdate(self)
	self:SetScript("OnUpdate", nil);
	J_BarFrame_UpdateStats();
end

function J_BarFrame_UpdateStats()
	local level = UnitLevel("player");
	local categoryYOffset = 0;
	local statYOffset = 0;



	local spec = GetSpecialization();
	local role = GetSpecializationRole(spec);

	

	-- CharacterStatsPane.statsFramePool:ReleaseAll();
	-- we need a stat frame to first do the math to know if we need to show the stat frame
	-- so effectively we'll always pre-allocate
	--local statFrame = _G["J_BarFrame_Bar"..1];-- CharacterStatsPane.statsFramePool:Acquire();


	local lastAnchor;

	for catIndex = 1, #J_PAPERDOLL_STATCATEGORIES do
		local catFrame = CharacterStatsPane[J_PAPERDOLL_STATCATEGORIES[catIndex].categoryFrame];
		local numStatInCat = 0;
		for statIndex = 1, #J_PAPERDOLL_STATCATEGORIES[catIndex].stats do
			local stat = J_PAPERDOLL_STATCATEGORIES[catIndex].stats[statIndex];
			local showStat = true;
			if ( showStat and stat.primary ) then
				local primaryStat = select(6, GetSpecializationInfo(spec, nil, nil, nil, UnitSex("player")));
				if ( stat.primary ~= primaryStat ) then
					showStat = false;
				end
			end
			if ( showStat and stat.roles ) then
				local foundRole = false;
				for _, statRole in pairs(stat.roles) do
					if ( role == statRole ) then
						foundRole = true;
						break;
					end
				end
				showStat = foundRole;
			end
			if ( showStat and stat.showFunc ) then
				showStat = stat.showFunc();
			end
			if ( showStat ) then
				-- statFrame.onEnterFunc = nil;
				-- statFrame.UpdateTooltip = nil;
				if ShiGuangDB.ShowChanceBarConfig[stat.stat] and ShiGuangDB.ShowChanceBarConfig[stat.stat].isEnable then
					local statFrame = _G["J_BarFrame_Bar"..ShiGuangDB.ShowChanceBarConfig[stat.stat].FRAMEINDEX]
					J_PAPERDOLL_STATINFO[stat.stat].updateFunc(statFrame, "player");
					if ( not stat.hideAt or stat.hideAt ~= statFrame.numericValue ) then
						if ( numStatInCat == 0 ) then
							if ( lastAnchor ) then
								-- catFrame:SetPoint("TOP", lastAnchor, "BOTTOM", 0, categoryYOffset);
							end
							lastAnchor = catFrame;
							-- statFrame:SetPoint("TOP", catFrame, "BOTTOM", 0, -2);
						else
							-- statFrame:SetPoint("TOP", lastAnchor, "BOTTOM", 0, statYOffset);
						end
						numStatInCat = numStatInCat + 1;
						-- statFrame.Background:SetShown((numStatInCat % 2) == 0);
						lastAnchor = statFrame;
						-- done with this stat frame, get the next one
						-- statFrame = CharacterStatsPane.statsFramePool:Acquire();
					end
				end
			end
		end
		-- catFrame:SetShown(numStatInCat > 0);
	end
	-- release the current stat frame
	-- CharacterStatsPane.statsFramePool:Release(statFrame);
end

function J_BarFrame_SetLabelAndText(statFrame, label, text, isPercentage, numericValue)
	--[[if ( statFrame.Label ) then
		statFrame.Label:SetText(format(STAT_FORMAT, label));
	end
	statFrame.Value:SetText(text);
	statFrame.numericValue = numericValue;
	]]
	if ( isPercentage ) then
		text = format("%d%%", numericValue + 0.5);
	end
	return text
end

function J_BarFrame_SetLevel()
	return
end

function GetEnemyDodgeChance(levelOffset)
	return
end

function GetEnemyParryChance(levelOffset)
	return
end

function J_BarFrame_SetHealth(statFrame, unit)

	if (not unit) then
		unit = "player";
	end
	local nhealth = UnitHealth(unit);
	local health = UnitHealthMax(unit);
	local healthText = BreakUpLargeNumbers(health);

	
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, HEALTH).." "..healthText..FONT_COLOR_CODE_CLOSE;
	if (unit == "player") then
		statFrame.tooltip2 = STAT_HEALTH_TOOLTIP;
	elseif (unit == "pet") then
		statFrame.tooltip2 = STAT_HEALTH_PET_TOOLTIP;
	end
	J_BarFrame:J_SetBarData(statFrame,"生命",nhealth,0,health)
end

function J_BarFrame_SetPower(statFrame, unit)
	if (not unit) then
		unit = "player";
	end
	local powerType, powerToken = UnitPowerType(unit);
	local power = UnitPowerMax(unit) or 0;
	local npower = UnitPower(unit) or 0;
	local powerText = BreakUpLargeNumbers(power);
	if (powerToken and _G[powerToken]) then
		
		statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, _G[powerToken]).." "..powerText..FONT_COLOR_CODE_CLOSE;
		statFrame.tooltip2 = _G["STAT_"..powerToken.."_TOOLTIP"];

	end

	J_BarFrame:J_SetBarData(statFrame,format(PAPERDOLLFRAME_TOOLTIP_FORMAT, _G[powerToken]),npower,0,power)
end

function J_BarFrame_SetAlternateMana(statFrame, unit)
	if (not unit) then
		unit = "player";
	end
	local _, class = UnitClass(unit);
	if (class ~= "DRUID" and (class ~= "MONK" or GetSpecialization() ~= SPEC_MONK_MISTWEAVER)) then
		statFrame:Hide();
		return;
	end
	local powerType, powerToken = UnitPowerType(unit);
	if (powerToken == "MANA") then
		statFrame:Hide();
		return;
	end

	local power = UnitPowerMax(unit, 0);
	local npower = UnitPower(unit, 0);
	local powerText = BreakUpLargeNumbers(power);
	
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, MANA).." "..powerText..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = _G["STAT_MANA_TOOLTIP"];

	J_BarFrame:J_SetBarData(statFrame,format(PAPERDOLLFRAME_TOOLTIP_FORMAT, MANA),npower,0,power)
end

function J_BarFrame_SetStat(statFrame, unit, statIndex)

	local stat;
	local effectiveStat;
	local posBuff;
	local negBuff;
	stat, effectiveStat, posBuff, negBuff = UnitStat(unit, statIndex);
	
	local effectiveStatDisplay = BreakUpLargeNumbers(effectiveStat);
	-- Set the tooltip text
	local statName = _G["SPELL_STAT"..statIndex.."_NAME"];
	local tooltipText = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, statName).." ";

	if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
		statFrame.tooltip = tooltipText..effectiveStatDisplay..FONT_COLOR_CODE_CLOSE;
		J_BarFrame:J_SetBarData(statFrame,tooltipText..effectiveStatDisplay..FONT_COLOR_CODE_CLOSE,stat,0,20000)
	else
		--[[tooltipText = tooltipText..effectiveStatDisplay;
		if ( posBuff > 0 or negBuff < 0 ) then
			tooltipText = tooltipText.." ("..BreakUpLargeNumbers(stat - posBuff - negBuff)..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 ) then
			tooltipText = tooltipText..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..BreakUpLargeNumbers(posBuff)..FONT_COLOR_CODE_CLOSE;
		end
		if ( negBuff < 0 ) then
			tooltipText = tooltipText..RED_FONT_COLOR_CODE.." "..BreakUpLargeNumbers(negBuff)..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 or negBuff < 0 ) then
			tooltipText = tooltipText..HIGHLIGHT_FONT_COLOR_CODE..")"..FONT_COLOR_CODE_CLOSE;
		end]]
		statFrame.tooltip = tooltipText;
		J_BarFrame:J_SetBarData(statFrame,tooltipText,stat,0,20000)
		-- If there are any negative buffs then show the main number in red even if there are
		-- positive buffs. Otherwise show in green.
		if ( negBuff < 0 and not GetPVPGearStatRules() ) then
			effectiveStatDisplay = RED_FONT_COLOR_CODE..effectiveStatDisplay..FONT_COLOR_CODE_CLOSE;
		end

	end
	
	statFrame.tooltip2 = _G["DEFAULT_STAT"..statIndex.."_TOOLTIP"];

	if (unit == "player") then
		local _, unitClass = UnitClass("player");
		unitClass = strupper(unitClass);

		local primaryStat, spec;
		spec = GetSpecialization();
		local role = GetSpecializationRole(spec);
		if (spec) then
			primaryStat = select(6, GetSpecializationInfo(spec, nil, nil, nil, UnitSex("player")));
		end
		-- Strength
		if ( statIndex == LE_UNIT_STAT_STRENGTH ) then
			local attackPower = GetAttackPowerForStat(statIndex,effectiveStat);
			if (HasAPEffectsSpellPower()) then
				statFrame.tooltip2 = STAT_TOOLTIP_BONUS_AP_SP;

			end
			if (not primaryStat or primaryStat == LE_UNIT_STAT_STRENGTH) then
				statFrame.tooltip2 = format(statFrame.tooltip2, BreakUpLargeNumbers(attackPower));
				if ( role == "TANK" ) then
					local increasedParryChance = GetParryChanceFromAttribute();
					if ( increasedParryChance > 0 ) then
						statFrame.tooltip2 = statFrame.tooltip2.."|n|n"..format(CR_PARRY_BASE_STAT_TOOLTIP, increasedParryChance);
					end
				end
			else
				statFrame.tooltip2 = STAT_NO_BENEFIT_TOOLTIP;

			end
		-- Agility
		elseif ( statIndex == LE_UNIT_STAT_AGILITY ) then
			local attackPower = GetAttackPowerForStat(statIndex,effectiveStat);
			local tooltip = STAT_TOOLTIP_BONUS_AP;
			if (HasAPEffectsSpellPower()) then
				tooltip = STAT_TOOLTIP_BONUS_AP_SP;
			end
			if (not primaryStat or primaryStat == LE_UNIT_STAT_AGILITY) then
				statFrame.tooltip2 = format(tooltip, BreakUpLargeNumbers(attackPower));
				if ( role == "TANK" ) then
					local increasedDodgeChance = GetDodgeChanceFromAttribute();
					if ( increasedDodgeChance > 0 ) then
						statFrame.tooltip2 = statFrame.tooltip2.."|n|n"..format(CR_DODGE_BASE_STAT_TOOLTIP, increasedDodgeChance);
					end
				end
			else
				statFrame.tooltip2 = STAT_NO_BENEFIT_TOOLTIP;
			end
		-- Stamina
		elseif ( statIndex == LE_UNIT_STAT_STAMINA ) then
			statFrame.tooltip2 = format(statFrame.tooltip2, BreakUpLargeNumbers(((effectiveStat*UnitHPPerStamina("player")))*GetUnitMaxHealthModifier("player")));
		-- Intellect
		elseif ( statIndex == LE_UNIT_STAT_INTELLECT ) then
			if ( UnitHasMana("player") ) then
				if (HasAPEffectsSpellPower()) then
					statFrame.tooltip2 = STAT_NO_BENEFIT_TOOLTIP;
				else
					local result, druid = HasSPEffectsAttackPower();
					if (result and druid) then
						statFrame.tooltip2 = format(STAT_TOOLTIP_SP_AP_DRUID, max(0, effectiveStat), max(0, effectiveStat));
					elseif (result) then
						statFrame.tooltip2 = format(STAT_TOOLTIP_BONUS_AP_SP, max(0, effectiveStat));
					elseif (not primaryStat or primaryStat == LE_UNIT_STAT_INTELLECT) then
						statFrame.tooltip2 = format(statFrame.tooltip2, max(0, effectiveStat));
					else
						statFrame.tooltip2 = STAT_NO_BENEFIT_TOOLTIP;
					end
				end
			else
				statFrame.tooltip2 = STAT_NO_BENEFIT_TOOLTIP;
			end
		end
	end

end

function J_BarFrame_SetArmor(statFrame, unit)
	return
end

function J_BarFrame_SetStagger(statFrame, unit)
	return
end

function J_BarFrame_SetDodge(statFrame, unit)
	return
end

function J_BarFrame_SetBlock(statFrame, unit)
	return
end

function J_BarFrame_SetParry(statFrame, unit)
	return
end

function J_BarFrame_SetResilience(statFrame, unit)
	return
end

local function GetAppropriateDamage(unit)
	return
end

function J_BarFrame_SetDamage(statFrame, unit)
	return
end

function J_BarFrame_SetAttackSpeed(statFrame, unit)
	return
end

function J_BarFrame_SetAttackPower(statFrame, unit)
	return
end

function J_BarFrame_SetSpellPower(statFrame, unit)
	return
end

function J_BarFrame_SetCritChance(statFrame, unit)


	local spellCrit, rangedCrit
	local holySchool = 2;
	local minCrit = GetSpellCritChance(holySchool);

	local spellCrit;
	for i=(holySchool+1), MAX_SPELL_SCHOOLS do
		spellCrit = GetSpellCritChance(i);
		minCrit = min(minCrit, spellCrit);

	end
	spellCrit = minCrit
	rangedCrit = GetRangedCritChance();
	meleeCrit = GetCritChance();

	if (spellCrit >= rangedCrit and spellCrit >= meleeCrit) then
		critChance = spellCrit;
		rating = CR_CRIT_SPELL;
	elseif (rangedCrit >= meleeCrit) then
		critChance = rangedCrit;
		rating = CR_CRIT_RANGED;
	else
		critChance = meleeCrit;
		rating = CR_CRIT_MELEE;
	end
	

	--print(J_BarFrame_SetLabelAndText(statFrame, STAT_CRITICAL_STRIKE, critChance, true, critChance));
	--critChance = format("%d", critChance + 0.5)

	

	
	

	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_CRITICAL_STRIKE)..FONT_COLOR_CODE_CLOSE;
	local extraCritChance = GetCombatRatingBonus(rating);
	local extraCritRating = GetCombatRating(rating);
	if (GetCritChanceProvidesParryEffect()) then
		statFrame.tooltip2 = format(CR_CRIT_PARRY_RATING_TOOLTIP, BreakUpLargeNumbers(extraCritRating), extraCritChance, GetCombatRatingBonusForCombatRatingValue(CR_PARRY, extraCritRating));
	else
		statFrame.tooltip2 = format(CR_CRIT_TOOLTIP, BreakUpLargeNumbers(extraCritRating), extraCritChance);
	end

	J_BarFrame:J_SetBarData(statFrame,format("暴击 :  %d [+%0.2f%%]",extraCritRating,extraCritChance),critChance,0,100)
	
end
function J_BarFrame_SetEnergyRegen(statFrame, unit)
	return
end

function J_BarFrame_SetFocusRegen(statFrame, unit)
	return
end

function J_BarFrame_SetRuneRegen(statFrame, unit)
	return
end


function J_BarFrame_SetHaste(statFrame, unit)

	local haste = GetHaste();
	local rating = CR_HASTE_MELEE;

	local hasteFormatString;
	if (haste < 0 and not GetPVPGearStatRules()) then
		hasteFormatString = RED_FONT_COLOR_CODE.."%s"..FONT_COLOR_CODE_CLOSE;
	else
		hasteFormatString = "%s";
	end

	
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HASTE)..FONT_COLOR_CODE_CLOSE;

	local _, class = UnitClass(unit);
	statFrame.tooltip2 = _G["STAT_HASTE_"..class.."_TOOLTIP"];
	if (not statFrame.tooltip2) then
		statFrame.tooltip2 = STAT_HASTE_TOOLTIP;
	end
	statFrame.tooltip2 = statFrame.tooltip2 .. format(STAT_HASTE_BASE_TOOLTIP, BreakUpLargeNumbers(GetCombatRating(rating)), GetCombatRatingBonus(rating));

	J_BarFrame:J_SetBarData(statFrame,format("急速 :  %d [+%0.2f%%]",BreakUpLargeNumbers(GetCombatRating(rating)), GetCombatRatingBonus(rating)),haste,0,100)
end

function J_BarFrame_SetManaRegen(statFrame, unit)
	return
end




function J_BarFrame_SetMastery(statFrame, unit)

	local mastery, bonusCoeff = GetMasteryEffect();
	local masteryBonus = GetCombatRatingBonus(CR_MASTERY) * bonusCoeff;

	statFrame.tooltip2 = format(STAT_MASTERY_TOOLTIP, BreakUpLargeNumbers(GetCombatRating(CR_MASTERY)), masteryBonus), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true;
	J_BarFrame:J_SetBarData(statFrame,format(STAT_MASTERY_TOOLTIP, BreakUpLargeNumbers(GetCombatRating(CR_MASTERY)), masteryBonus),mastery,0,100)
end

-- Task 68016: Speed increases run speed
function J_BarFrame_SetSpeed(statFrame, unit)
	local speed = GetUnitSpeed("player");



	

	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_SPEED) .. " " .. format("%.2F%%", speed) .. FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(CR_SPEED_TOOLTIP, BreakUpLargeNumbers(GetCombatRating(CR_SPEED)), GetCombatRatingBonus(CR_SPEED));

	J_BarFrame:J_SetBarData(statFrame,statFrame.tooltip,speed,0,100)
end

-- Task 68016: Lifesteal returns a portion of all damage done as health
function J_BarFrame_SetLifesteal(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

	local lifesteal = GetLifesteal();
	
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE .. format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_LIFESTEAL) .. " " .. format("%.2F%%", lifesteal) .. FONT_COLOR_CODE_CLOSE;

	statFrame.tooltip2 = format(CR_LIFESTEAL_TOOLTIP, BreakUpLargeNumbers(GetCombatRating(CR_LIFESTEAL)), GetCombatRatingBonus(CR_LIFESTEAL));
	J_BarFrame:J_SetBarData(statFrame,statFrame.tooltip,lifesteal,0,100)
end

-- Task 68016: Avoidance reduces AoE damage taken
function J_BarFrame_SetAvoidance(statFrame, unit)
	return
end

function J_BarFrame_SetVersatility(statFrame, unit)

	local versatility = GetCombatRating(CR_VERSATILITY_DAMAGE_DONE);
	local versatilityDamageBonus = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE);
	local versatilityDamageTakenReduction = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_TAKEN) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_TAKEN);
	
	
	
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_VERSATILITY)..FONT_COLOR_CODE_CLOSE;

	statFrame.tooltip2 = format(CR_VERSATILITY_TOOLTIP, versatilityDamageBonus, versatilityDamageTakenReduction, BreakUpLargeNumbers(versatility), versatilityDamageBonus, versatilityDamageTakenReduction);

	J_BarFrame:J_SetBarData(statFrame,format("全能 :  %d [%0.2f%%/%0.2f%%]", BreakUpLargeNumbers(versatility), versatilityDamageBonus, versatilityDamageTakenReduction),versatilityDamageBonus,0,100)
end


function J_BarFrame_SetItemLevel(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

	local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel();
	local minItemLevel = C_PaperDollInfo.GetMinItemLevel();

	local displayItemLevel = math.max(minItemLevel or 0, avgItemLevelEquipped);

	displayItemLevel = floor(displayItemLevel);
	avgItemLevel = floor(avgItemLevel);

	
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_AVERAGE_ITEM_LEVEL).." "..avgItemLevel;
	--if ( displayItemLevel ~= avgItemLevel ) then
		--statFrame.tooltip = statFrame.tooltip .. "  " .. format(STAT_AVERAGE_ITEM_LEVEL_EQUIPPED, avgItemLevelEquipped);
	--end
	statFrame.tooltip = statFrame.tooltip .. FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = STAT_AVERAGE_ITEM_LEVEL_TOOLTIP;
	
	J_BarFrame:J_SetBarData(statFrame,statFrame.tooltip .. FONT_COLOR_CODE_CLOSE,displayItemLevel,0,avgItemLevel)
end

function MovementSpeed_OnEnter(statFrame)
	return
end

function J_MovementSpeed_OnUpdate(statFrame, elapsedTime)
	local unit = statFrame.unit;
	local _, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed(unit);
	runSpeed = runSpeed/BASE_MOVEMENT_SPEED*100;
	flightSpeed = flightSpeed/BASE_MOVEMENT_SPEED*100;
	swimSpeed = swimSpeed/BASE_MOVEMENT_SPEED*100;

	-- Pets seem to always actually use run speed
	if (unit == "pet") then
		swimSpeed = runSpeed;
	end

	-- Determine whether to display running, flying, or swimming speed
	local speed = runSpeed;
	local swimming = IsSwimming(unit);
	if (swimming) then
		speed = swimSpeed;
	elseif (IsFlying(unit)) then
		speed = flightSpeed;
	end

	-- Hack so that your speed doesn't appear to change when jumping out of the water
	if (IsFalling(unit)) then
		if (statFrame.wasSwimming) then
			speed = swimSpeed;
		end
	else
		statFrame.wasSwimming = swimming;
	end

	local valueText = format("%d%%", speed+0.5);
	
	statFrame.speed = speed;
	statFrame.runSpeed = runSpeed;
	statFrame.flightSpeed = flightSpeed;
	statFrame.swimSpeed = swimSpeed;

	J_BarFrame:J_SetBarData(statFrame,STAT_MOVEMENT_SPEED.." "..valueText,speed,0,420)
	
	
end

function J_BarFrame_SetMovementSpeed(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

	statFrame.wasSwimming = nil;
	statFrame.unit = unit;
	statFrame:Show();
	J_MovementSpeed_OnUpdate(statFrame);

	statFrame.onEnterFunc = MovementSpeed_OnEnter;
end

J_BarFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" then
		J_BarFrame:J_ADDON_LOADED()
		J_Initializationframe()
	end
	local unit = ...;

	if ( unit == "player" ) then
		if ( event == "UNIT_LEVEL" ) then
			J_BarFrame_SetLevel();
		elseif ( event == "UNIT_DAMAGE" or
			event == "UNIT_ATTACK_SPEED" or
			event == "UNIT_RANGEDDAMAGE" or
			event == "UNIT_ATTACK" or
			event == "UNIT_STATS" or
			event == "UNIT_RANGED_ATTACK_POWER" or
			event == "UNIT_SPELL_HASTE" or
			event == "UNIT_MAXHEALTH" or
			event == "UNIT_AURA" or
			event == "UNIT_RESISTANCES") then
			self:SetScript("OnUpdate", J_BarFrame_QueuedUpdate);
		end
	end
	if ( event == "COMBAT_RATING_UPDATE" or
			event == "MASTERY_UPDATE" or
			event == "SPEED_UPDATE" or
			event == "LIFESTEAL_UPDATE" or
			event == "AVOIDANCE_UPDATE" or
			event == "BAG_UPDATE" or
			event == "PLAYER_EQUIPMENT_CHANGED" or
			event == "PLAYER_AVG_ITEM_LEVEL_UPDATE" or
			event == "PLAYER_DAMAGE_DONE_MODS" or
			event == "PLAYER_TARGET_CHANGED") then
		self:SetScript("OnUpdate", J_BarFrame_QueuedUpdate);
	elseif (event == "PLAYER_TALENT_UPDATE") then
		J_BarFrame_SetLevel();
		self:SetScript("OnUpdate", J_BarFrame_QueuedUpdate);
	elseif (event == "ACTIVE_TALENT_GROUP_CHANGED") then
		J_BarFrame_UpdateStats();
	elseif ( event == "SPELL_POWER_CHANGED" ) then
		self:SetScript("OnUpdate", J_BarFrame_QueuedUpdate);
	elseif ( event == "TRIAL_STATUS_UPDATE" ) then
		J_BarFrame_SetLevel();
	end
end)

--[[
J_BarFrame:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", -8, 8)
	GameTooltip:AddLine("Quick tips")
	GameTooltip:AddLine("quickTips", 1, 1, 1, 1)
	GameTooltip:Show()
end)
J_BarFrame:SetScript("OnLeave", function(self)
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide()
	end
end)
]]
--[[
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function(statusFrame, textString, value, valueMin, valueMax)
    
    if statusFrame.powerToken == "RAGE" then
	    local bar = _G["J_BarFrame_Bar"..1];
	    bar.LeftName:SetText("MP")
		bar.RightValue:SetText(value > 0 and value or "")
	    bar:SetMinMaxValues(valueMin, valueMax)
	    bar:SetValue(value)

	end
end)
]]
