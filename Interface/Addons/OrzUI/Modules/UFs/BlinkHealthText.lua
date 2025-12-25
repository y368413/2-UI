local _, ns = ...
local M, R, U, I = unpack(ns)
-------------------------------------------------------------------------------
-- 文件: SimpleInfo.lua ver 1.0  日期: 2010-12-11  作者: dugu@wowbox
-- 描述: 在屏幕中下方显示玩家(宠物)和目标(ToT)的基本信息  版权所有@多玩游戏网
-- Author: Kill & dugu from duowan  Thanks warbaby
-------------------------------------------------------------------------------
local BlinkHealth = LibStub("AceAddon-3.0"):NewAddon("SimpleInfo",  "AceEvent-3.0", "AceTimer-3.0");

local SPEC_MAGE_ARCANE = 1
local SPEC_MONK_WINDWALKER = 3
local SPEC_PALADIN_RETRIBUTION = 3
local SPEC_WARLOCK_DESTRUCTION = 3
local SPELL_POWER_ENERGY = 3
local SPELL_POWER_COMBO_POINTS = 4
local SPELL_POWER_SOUL_SHARDS = 7
local SPELL_POWER_HOLY_POWER = 9
local SPELL_POWER_CHI = 12
local SPELL_POWER_ARCANE_CHARGES = 16

local fntBig = CreateFont("SIFontBig");
fntBig:SetFont(STANDARD_TEXT_FONT, 22, "THICKOUTLINE");

local fntMedium = CreateFont("SIFontMedium");  -- Power, absolute health
fntMedium:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE");
fntMedium:SetTextColor(1, 0.65, 0.16);
fntMedium:SetShadowColor(0.25, 0.25, 0.25, 0.5);
fntMedium:SetShadowOffset(1, -1);

local fntSmall = CreateFont("SIFontSmall");  -- ToT, pet
fntSmall:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE");
fntSmall:SetTextColor(1, 0.65, 0.16);
fntSmall:SetShadowColor(0.25, 0.25, 0.25, 0.5);
fntSmall:SetShadowOffset(1, -1);

BlinkHealth.digitTexCoords = {
	["1"] = {1, 20},
	["2"] = {21, 31},
	["3"] = {53, 30},
	["4"] = {84, 33},
	["5"] = {118, 30},
	["6"] = {149, 31},
	["7"] = {181, 30},
	["8"] = {212, 31},
	["9"] = {244, 31},
	["0"] = {276, 31},
	["%"] = {308, 17},
	["X"] = {326, 31},	-- Dead
	["G"] = {358, 36},	-- Ghost
	["Off"] = {395, 23},	-- Offline
	["height"] = 43,
	["texWidth"] = 512,
	["texHeight"] = 128
};

BlinkHealth.powerColor = {
	AMMOSLOT = {0.8, 0.6, 0},
	ENERGY = {1, 1, 0},
	FOCUS = {1, 0.5, 0.25},
	FUEL = {0, 0.55, 0.5},
	HAPPINESS = {0, 1, 1},
	MANA = {0.31, 0.45, 0.63},
	RAGE = {0.69, 0.31, 0.31},
	RUNES = {0.55, 0.57, 0.61},
	RUNIC_POWER = {0, 0.82, 1},
  FURY = {0.788, 0.259, 0.992},
	PAIN = {0, 0.82, 1},
  INSANITY = {0.40, 0, 0.80}, -- PowerBarColor
};

BlinkHealth.runeColors = {
	{1, 0, 0};
	{0, .5, 0};
	{0, 1, 1};
	{.9, .1, 1};
}

BlinkHealth['classMaxResourceBar'] = {
	['DEATHKNIGHT'] = 6,
	['PALADIN'] = 5,
	['WARLOCK'] = 5,
	['MONK'] = 6,
	['MAGE'] = 4,
	['ROGUE'] = 8,
	["DRUID"] = 5
}

BlinkHealth.classColor = {};
do
    for k, v in pairs(RAID_CLASS_COLORS) do
        BlinkHealth.classColor[k] = {v.r, v.g, v.b};
    end
end


function BlinkHealth:OnEnable()
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
	self:RegisterEvent("PLAYER_REGEN_DISABLED");
	self:RegisterEvent("PLAYER_REGEN_ENABLED");		
	self:RegisterEvent("UNIT_HEALTH");	
	self:RegisterEvent("UNIT_POWER_UPDATE");	
	self.frame["player"]:Show();
	self.handle = self:ScheduleRepeatingTimer("UpdateUnitValues", 0.05);
end

function BlinkHealth:OnDisable()
	self:UnregisterAllEvents();
	self:CancelTimer(self.handle, true);
	self.frame["player"]:Hide();
	self.frame["target"]:Hide();
end

function BlinkHealth:PLAYER_TARGET_CHANGED()
	self:UpdateUnitFrame();
	if (self.class == "ROGUE" or self.class == "DRUID") then
		self:UpdateComboPoints();
	end
end

function BlinkHealth:PLAYER_REGEN_DISABLED()
	self:UpdateUnitFrame();
end

function BlinkHealth:PLAYER_REGEN_ENABLED()
	self:UpdateUnitFrame();
end

function BlinkHealth:UNIT_POWER_UPDATE(event, unit)
	local pType, powertype = UnitPowerType("player");
	if (unit == "player") then	
		if(powertype=="MANA")then
			self:UpdateUnitFrame();
		elseif (self.class == "ROGUE" or self.class == "DRUID") then
			self:UpdateComboPoints();
		end
	end
end

function BlinkHealth:UNIT_HEALTH(event, unit)
	if (unit == "player") then	
		self:UpdateUnitFrame();
	end
end

function BlinkHealth:CreateAnchorFrame()
	if (self.anchor) then return end

	self.anchor = CreateFrame("Button", "SimpleInfoAnchorFrame", UIParent, "BackdropTemplate");
	self.anchor:SetWidth(280);
	self.anchor:SetHeight(80);
	self.anchor:EnableMouse(true);
	self.anchor:SetMovable(true);
	self.anchor:SetPoint("CENTER", UIParent, "CENTER", 0, -210);
	local backdrop = {
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tileSize = 16, edgeSize = 16, tile = true,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	};		
	self.anchor:SetBackdrop(backdrop);
	self.anchor:SetBackdropColor(0.1, 0.1, 0.1, 0.65)
	self.anchor:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
	
	self.anchor.close = CreateFrame("Button", nil, self.anchor, "UIPanelCloseButton");
	self.anchor.close:SetPoint("TOPRIGHT", self.anchor, "TOPRIGHT", -5, -5);

	self.anchor.text = self.anchor:CreateFontString(nil, "OVERLAY");
	self.anchor.text:SetFontObject("SIFontSmall");
	self.anchor.text:SetJustifyH("CENTER");
	self.anchor.text:SetPoint("CENTER");
	self.anchor.text:SetText(UFRAMESTYLE_BLINKHEALTHTEXT_ANCHOR);
	self.anchor.text:SetTextColor(1, 1, 1);

	self.anchor:RegisterForClicks("LeftButtonDown", "RightButtonDown");
	self.anchor:SetScript("OnMouseDown", function(self, button)
		if (button == "LeftButton") then
			self:StartMoving();
			self.isMoving = true;
		else
			self:Hide();
		end
		
	end);
	self.anchor:SetScript("OnMouseUp", function(self)
		if (self.isMoving) then
			self:StopMovingOrSizing();
		end		
	end);

	--self.anchor.originalStopMovingOrSizing = self.anchor.StopMovingOrSizing;
	--self.anchor.duration = 1;  	--RegisterForSaveFrame(self.anchor);
	self.anchor:Hide();
end

function BlinkHealth:ToHexColor(r, g, b)
	return format("%02x%02x%02x", r*255, g*255, b*255);
end

function BlinkHealth:UpdateUnitFrame()
	local heal, maxheal = UnitHealth("player"), UnitHealthMax("player");
	local pType, powertype = UnitPowerType("player");
	local power, maxpower = UnitPower("player", pType), UnitPowerMax("player", pType);
	--print(powertype,":",poewer,"/",maxpower,"; HP:",heal,"/",maxheal);
	if (UnitExists("target")) then
		self.frame["player"]:SetAlpha(1);
		self.frame["target"]:SetAlpha(1);
		self.frame["target"]:Show();
	elseif(heal<maxheal) then
		self.frame["player"]:SetAlpha(1);
		self.frame["target"]:SetAlpha(0.2);
		self.frame["target"]:Hide();
	elseif(powertype=="MANA" and power<maxpower)then
		self.frame["player"]:SetAlpha(1);
		self.frame["target"]:SetAlpha(0.2);
		self.frame["target"]:Hide();
	else
		self.frame["player"]:SetAlpha(0.2);
		self.frame["target"]:SetAlpha(0.2);
		self.frame["target"]:Hide();
	end
end

function BlinkHealth:UpdateComboPoints()
	if self.class == "MONK" then
		local cur = UnitPower("player", SPELL_POWER_CHI)
		local max = BlinkHealth['classMaxResourceBar'][BlinkHealth.class]

		if cur and cur > 0 then
			self.Combo:Show();
			for i = 1, max do
				self.Combo[i]:Hide();
			end
			
			for i = 1, cur do
				self.Combo[i]:Show();
			end
		else
			self.Combo[i]:Hide();
		end
	else
		local comboPoints = GetComboPoints('player', 'target')	--UnitPower("player", SPELL_POWER_COMBO_POINTS)
		if (comboPoints and comboPoints > 0) then
			self.Combo:Show();
			for i=1, MAX_COMBO_POINTS do
				self.Combo[i]:Hide();
			end

			for i=1, comboPoints do
				self.Combo[i]:Show();
			end
		else
			self.Combo:Hide();
		end

		--if (self.castBar and self.castBar:IsShown()) then
			--self:CastingBarAdjustPosition();
		--end
	end
end

function BlinkHealth:UpdateUnitValues()
	local heal, maxheal, perh, petheal, petmax, name;
	local power, maxpower, powertype, _;
	-- player
--	if (UnitHasVehicleUI("player")) then
--		heal, maxheal = UnitHealth("pet"), UnitHealthMax("pet");
--		local pType, powertype = UnitPowerType("pet")
--		power, maxpower = UnitPower("pet", pType), UnitPowerMax("pet", pType);
--		petheal, petmax = UnitHealth("player"), UnitHealthMax("player");
--		name = UnitName("player");	-- petName
--	else
		heal, maxheal = UnitHealth("player"), UnitHealthMax("player");
		local pType, powertype = UnitPowerType("player")
		power, maxpower = UnitPower("player", pType), UnitPowerMax("player", pType);
		petheal, petmax = UnitHealth("pet"), UnitHealthMax("pet");
		name = UnitName("pet");
--	end
	if maxheal <= 0 then
		perh = 100;
	else
		perh = heal/maxheal * 100 + 0.5;
	end
	self:SetPercentText("player", perh);
	local hexColor = self:ToHexColor(1, 0.65, 0.16);
	heal, maxheal = self:FormatDigit(heal), self:FormatDigit(maxheal);
	self.frame["player"].heal:SetFormattedText("|cff%s%s/%s|r", hexColor, heal, maxheal);	
	
	
	--[[by hrf
	if(powertype=="MANA") then
		perh = power/maxpower * 100 + 0.5;
		self:SetPowerPercentText("player", perh);
	end
	--]]
	
	if (type(maxpower) == "number" and maxpower > 0 and self.powerColor[powertype]) then		
		heaxColor = self:ToHexColor(unpack(self.powerColor[powertype]));
		power, maxpower = self:FormatDigit(power), self:FormatDigit(maxpower);
		self.frame["player"].power:SetFormattedText("|cff%s%s/%s|r", heaxColor, power, maxpower);
		self.frame["player"].power:Show();
	else
		self.frame["player"].power:Hide();
	end
	-- pet
	hexColor = self:ToHexColor(1, 0.65, 0.16);   --0.49,0.99,0
	if (type(petmax) == "number" and petmax > 0 and name) then
		self.frame["player"].pet:SetFormattedText("|cff%s%s^-^%d%%|r<", hexColor, name, petheal/petmax*100+0.5);
		self.frame["player"].pet:Show();
	else
		self.frame["player"].pet:Hide();
	end
		
		if (UnitExists("player")) then
			local _, class = UnitClass("player");
			hexColor = self:ToHexColor(unpack(self.classColor[class]));
		else
			hexColor = self:ToHexColor(UnitSelectionColor("player"));
		end
		self.frame["player"].name:SetFormattedText("|cff%s%s|r", hexColor, UnitName("player"));
		
	-- target
	local hexH, hexP;
	if (UnitExists("target")) then
		
		--heal, maxheal = UnitHealth("target"), UnitHealthMax("target");
		if RealMobHealth and RealMobHealth.GetUnitHealth then 
			heal, maxheal = RealMobHealth.GetUnitHealth("target")
		else
			heal = UnitHealth("target") or 0
			maxheal = UnitHealthMax("target") or 1
		end
		
		local pType, powertype = UnitPowerType("target")
		power, maxpower = UnitPower("target", pType), UnitPowerMax("target", pType);
		name = UnitName("target");
		if maxheal <= 0 then
			perh = 100;
		else
			perh = heal/maxheal * 100 + 0.5;
		end
		self:SetPercentText("target", perh);		
		heal, maxheal = self:FormatDigit(heal), self:FormatDigit(maxheal);
		local hexH = self:ToHexColor(1, 0.65, 0.16);
		if (powertype and self.powerColor[powertype] and type(maxpower) == "number" and maxpower > 0) then
			hexP = self:ToHexColor(unpack(self.powerColor[powertype]));
			power, maxpower = self:FormatDigit(power), self:FormatDigit(maxpower);
			--self.frame["target"].heal:SetFormattedText("|cff%s%s/%s|r | |cff%s%s/%s|r", hexH, heal, maxheal, hexP, power, maxpower);
			self.frame["target"].heal:SetFormattedText("|cff%s%s/%s|r", hexH, heal, maxheal);
			self.frame["target"].power:SetFormattedText("|cff%s%s/%s|r", hexP, power, maxpower);
			self.frame["target"].power:Show();
		else
			self.frame["target"].heal:SetFormattedText("|cff%s%s/%s|r", hexH, heal, maxheal);
			self.frame["target"].power:Hide();
		end

		if (UnitIsPlayer("target")) then
			local _, class = UnitClass("target");
			hexColor = self:ToHexColor(unpack(self.classColor[class]));
		else
			hexColor = self:ToHexColor(UnitSelectionColor("target"));
		end
		--精英、银英、世界boss加前缀
		if(UnitClassification("target")=="elite") then name="[精英]"..name; end
		if(UnitClassification("target")=="rare") then name="[稀有]"..name; end
		if(UnitClassification("target")=="rareelite") then name="[稀有精英]"..name; end
		if(UnitClassification("target")=="worldboss") then name="[世界BOSS]"..name; end
		
		self.frame["target"].name:SetFormattedText("|cff%s%s|r", hexColor, name);
	
		if (UnitExists("targettarget")) then
			heal, maxheal = UnitHealth("targettarget"), UnitHealthMax("targettarget");
			--if maxheal < 1 then maxheal =1 end
			hexColor = self:ToHexColor(1, 0.65, 0.16);
			name = UnitName("targettarget");
			if (UnitIsUnit("targettarget", "player")) then
				name = " "..YOU.." <";
			end
			self.frame["target"].tot:SetFormattedText("|cff%s>%s ★%d%%|r", hexColor, name, heal/maxheal*100+0.5);
			self.frame["target"].tot:Show();
		else
			self.frame["target"].tot:Hide();
		end
	end
end

function BlinkHealth:SetDigit(texObj, digit)
	texObj:SetWidth(self.digitTexCoords[digit][2]);
	texObj:SetHeight(self.digitTexCoords["height"]);
	texObj:SetTexCoord(self.digitTexCoords[digit][1] / self.digitTexCoords["texWidth"], (self.digitTexCoords[digit][1] + self.digitTexCoords[digit][2]) / self.digitTexCoords["texWidth"], 0.0078125, 0.3359375);
	texObj:Show();
	texObj.fill:SetWidth(self.digitTexCoords[digit][2]);
	texObj.fill:SetHeight(self.digitTexCoords["height"]);
	texObj.fill:SetTexCoord(self.digitTexCoords[digit][1] / self.digitTexCoords["texWidth"], (self.digitTexCoords[digit][1] + self.digitTexCoords[digit][2]) / self.digitTexCoords["texWidth"], 0.34375, 0.671875);
	texObj.fill:Show();
end

function BlinkHealth:SetPowerDigit(texObj, digit)
	texObj:SetWidth(self.digitTexCoords[digit][2]);
	texObj:SetHeight(self.digitTexCoords["height"]);
	texObj:SetTexCoord(self.digitTexCoords[digit][1] / self.digitTexCoords["texWidth"], (self.digitTexCoords[digit][1] + self.digitTexCoords[digit][2]) / self.digitTexCoords["texWidth"], 0.0078125, 0.3359375);
	texObj:Show();
	texObj.fill:SetWidth(self.digitTexCoords[digit][2]);
	texObj.fill:SetHeight(self.digitTexCoords["height"]);
	texObj.fill:SetTexCoord(self.digitTexCoords[digit][1] / self.digitTexCoords["texWidth"], (self.digitTexCoords[digit][1] + self.digitTexCoords[digit][2]) / self.digitTexCoords["texWidth"], 0.34375, 0.671875);
	texObj.fill:Show();
end

function BlinkHealth:SetPercentText(unit, percent)	
	local health = self.frame[unit].health;	
	local hPerc = ("%d"):format(percent); --%d%%

	for i = 1, 4 do
		if i > string.len(hPerc) then
			health[5 - i]:Hide();
			health[5 - i].fill:Hide();
		else
			local digit;
			if unit == "player" then
				digit = string.sub(hPerc , -i, -i);
			else
				digit = string.sub(hPerc , i, i);
			end

			self:SetDigit(health[5 - i], digit);
		end
	end
	
	if (percent == 0.5) then
		for i = 1, 4 do			
			health[5 - i].fill:Hide();
		end
	end
end

function BlinkHealth:SetPowerPercentText(unit, percent)	
	local powerth = self.frame[unit].powerth;	
	local hPerc = ("%d"):format(percent); --%d%%

	for i = 1, 4 do
		if i > string.len(hPerc) then
			powerth[5 - i]:Hide();
			powerth[5 - i].fill:Hide();
		else
			local digit;
				digit = string.sub(hPerc , i, i);
			self:SetPowerDigit(powerth[5 - i], digit);
		end
	end
	
	if (percent == 0.5) then
		for i = 1, 4 do			
			powerth[5 - i].fill:Hide();
		end
	end
end

function BlinkHealth:FormatDigit(digit)
	if (digit >= 1e8) then
		return ("%0.1f"..DANWEI_YI):format(digit / 1e8);
	elseif (digit >= 1e4) then
		return ("%0.1f"..DANWEI_WAN):format(digit / 1e4);
	end
	return digit;
end

function BlinkHealth:ConstructHealth(unit)
	local this = self.frame[unit];
	local health = {}
	local healthFill = {}
	for i = 1, 4 do
		health[i] = this:CreateTexture(nil, "ARTWORK")
		health[i]:SetTexture("Interface\\AddOns\\OrzUI\\Media\\Modules\\BlinkHealthText\\digits")
		health[i]:Hide()
		healthFill[i] = this:CreateTexture(nil, "OVERLAY")
		healthFill[i]:SetTexture("Interface\\AddOns\\OrzUI\\Media\\Modules\\BlinkHealthText\\digits")
		healthFill[i]:SetVertexColor(1, 0.65, 0.16);  --0.49,0.99,0
		healthFill[i]:Hide()
		health[i].fill = healthFill[i];
	end

	if unit == "player" then
		health[4]:SetPoint("RIGHT");
		health[3]:SetPoint("RIGHT", health[4], "LEFT");
		health[2]:SetPoint("RIGHT", health[3], "LEFT");
		health[1]:SetPoint("RIGHT", health[2], "LEFT");
	else
		health[4]:SetPoint("LEFT");
		health[3]:SetPoint("LEFT", health[4], "RIGHT");
		health[2]:SetPoint("LEFT", health[3], "RIGHT");
		health[1]:SetPoint("LEFT", health[2], "RIGHT");
	end
		
	healthFill[4]:SetPoint("BOTTOM", health[4]);
	healthFill[3]:SetPoint("BOTTOM", health[3]);
	healthFill[2]:SetPoint("BOTTOM", health[2]);
	healthFill[1]:SetPoint("BOTTOM", health[1]);

	this.health = health;
	this.healthFill = healthFill;

	--add Powerth by hrf 2019-09-12
	local powerth = {}
	local powerthFill = {}
	for i = 1, 4 do
		powerth[i] = this:CreateTexture(nil, "ARTWORK")
		powerth[i]:SetTexture("Interface\\AddOns\\OrzUI\\Media\\Modules\\BlinkHealthText\\digits")
		powerth[i]:Hide()
		powerthFill[i] = this:CreateTexture(nil, "OVERLAY")
		powerthFill[i]:SetTexture("Interface\\AddOns\\OrzUI\\Media\\Modules\\BlinkHealthText\\digits")
		powerthFill[i]:SetVertexColor(0.31, 0.45, 0.63);
		powerthFill[i]:Hide()
		powerth[i].fill = powerthFill[i];
	end

	if unit == "player" then
		powerth[4]:SetPoint("LEFT");
		powerth[3]:SetPoint("LEFT", powerth[4], "RIGHT");
		powerth[2]:SetPoint("LEFT", powerth[3], "RIGHT");
		powerth[1]:SetPoint("LEFT", powerth[2], "RIGHT");
	end
		
	powerthFill[4]:SetPoint("BOTTOM", powerth[4]);
	powerthFill[3]:SetPoint("BOTTOM", powerth[3]);
	powerthFill[2]:SetPoint("BOTTOM", powerth[2]);
	powerthFill[1]:SetPoint("BOTTOM", powerth[1]);

	this.powerth = powerth;
	this.powerthFill = powerthFill;
	--


	-- Power, heal
	local heal, power;
	heal = this:CreateFontString(nil, "OVERLAY");
	power = this:CreateFontString(nil, "OVERLAY");
	heal:SetFontObject("SIFontMedium");
	power:SetFontObject("SIFontMedium");
	if unit == "player" then 
		heal:SetPoint("TOPRIGHT", health[4], "BOTTOMRIGHT", 0, -2);
		power:SetPoint("BOTTOMRIGHT", this, "BOTTOMRIGHT", -80, 6);
	else
		--heal:SetPoint("BOTTOMLEFT", health[1], "BOTTOMRIGHT", 5, 0);
		heal:SetPoint("TOPLEFT", health[4], "BOTTOMLEFT", 6, -2);
		power:SetPoint("BOTTOMLEFT", this, "BOTTOMLEFT", 85, 6);
	end

	this.power = power;
	this.heal = heal;

	-- Name
	local name, pet, tot;
	if (unit == "player") then
		name = this:CreateFontString(nil, "OVERLAY");
		name:SetFontObject("SIFontMedium");
		name:SetPoint("BOTTOMRIGHT", power, "BOTTOMRIGHT", 0, 18);

		pet = this:CreateFontString(nil, "OVERLAY");
		pet:SetFontObject("SIFontSmall");
		pet:SetPoint("BOTTOMRIGHT", health[4], "TOPRIGHT", 0, 6);
		this.pet = pet;
	else
		name = this:CreateFontString(nil, "OVERLAY");
		name:SetFontObject("SIFontMedium");
		name:SetPoint("BOTTOMLEFT", power, "BOTTOMLEFT", 0, 18);
			
		tot = this:CreateFontString(nil, "OVERLAY");
		tot:SetFontObject("SIFontSmall");
		tot:SetPoint("BOTTOMLEFT", health[4], "TOPLEFT", 0, 6);
		this.tot = tot;		
	end

	this.name = name;
end
--------------
-- 连击点
function BlinkHealth:ConstructCombo()
	local this
	if BlinkHealth.class == "MONK" then
		this = self.frame["player"]
	else
		this = self.frame["target"]
	end

	self.Combo = CreateFrame("Frame", nil, this);
	self.Combo:SetWidth(80)
	self.Combo:SetHeight(16)
	self.Combo:SetPoint("TOPLEFT", this.heal, "BOTTOMLEFT", 0, 0);
	local bg, fill = {}, {};
	for i = 1, BlinkHealth['classMaxResourceBar'][BlinkHealth.class] do
		self.Combo[i] = CreateFrame("Frame", nil, self.Combo)
		self.Combo[i]:SetWidth(16)
		self.Combo[i]:SetHeight(16)
		if i == 1 then 
			self.Combo[i]:SetPoint("LEFT", self.Combo, "LEFT")
		else
			self.Combo[i]:SetPoint("LEFT", self.Combo[i - 1], "RIGHT") 
		end
		bg[i] = self.Combo[i]:CreateTexture(nil, "ARTWORK")
		bg[i]:SetTexture("Interface\\AddOns\\OrzUI\\Media\\Modules\\BlinkHealthText\\combo.blp")
		bg[i]:SetTexCoord(0, 16 / 64, 0, 1)
		bg[i]:SetAllPoints(self.Combo[i])
		fill[i] = self.Combo[i]:CreateTexture(nil, "OVERLAY")
		fill[i]:SetTexture("Interface\\AddOns\\OrzUI\\Media\\Modules\\BlinkHealthText\\combo.blp")
		fill[i]:SetTexCoord(0.5, 0.75, 0, 1)
		fill[i]:SetVertexColor(1, 1, 0)
		fill[i]:SetAllPoints(self.Combo[i])
	end
	self.Combo:Hide();
	self.Combo.bg = bg;
	self.Combo.fill = fill;	
end
--------------------
-- 符文条
do
function BlinkHealth:ConstructRunes()
	local this = self.frame["player"];
	self.Runes = CreateFrame("Frame", nil, this)	
	self.Runes:SetWidth(96)
	self.Runes:SetHeight(16)
	self.Runes:SetPoint("TOPRIGHT", this.heal, "BOTTOMRIGHT", 0, -1);
	self.Runes:Hide();

	for i = 1, 6 do
		self.Runes[i] = CreateFrame("StatusBar", nil, self.Runes)
		self.Runes[i]:SetStatusBarTexture("Interface\\AddOns\\OrzUI\\Media\\Modules\\BlinkHealthText\\blank.blp")
		self.Runes[i]:SetWidth(16)
		self.Runes[i]:SetHeight(16)

		if i == 1 then
			self.Runes[i]:SetPoint("TOPLEFT", self.Runes, "TOPLEFT")
		else
			self.Runes[i]:SetPoint("LEFT", self.Runes[i - 1], "RIGHT")
		end

		local backdrop = self.Runes[i]:CreateTexture(nil, "ARTWORK")
		backdrop:SetWidth(16)
		backdrop:SetHeight(16)
		backdrop:SetAllPoints()
		backdrop:SetTexture("Interface\\AddOns\\OrzUI\\Media\\Modules\\BlinkHealthText\\combo.blp")
		backdrop:SetTexCoord(0, 16 / 64, 0, 1)
				
		-- This is actually the fill layer, but "bg" gets automatically vertex-colored by the runebar module. So let's make use of that!
		self.Runes[i].bg = self.Runes[i]:CreateTexture(nil, "OVERLAY")
		self.Runes[i].bg:SetWidth(16)
		self.Runes[i].bg:SetHeight(16)
		self.Runes[i].bg:SetPoint("BOTTOM")
		self.Runes[i].bg:SetTexture("Interface\\AddOns\\OrzUI\\Media\\Modules\\BlinkHealthText\\combo.blp")
		self.Runes[i].bg:SetTexCoord(0.5, 0.75, 0, 1)
				
		-- Shine effect
		local shinywheee = CreateFrame("Frame", nil, self.Runes[i])
		shinywheee:SetAllPoints()
		shinywheee:SetAlpha(0)
		shinywheee:Hide()
				
		local shine = shinywheee:CreateTexture(nil, "OVERLAY")
		shine:SetAllPoints()
		shine:SetPoint("CENTER")
		shine:SetTexture("Interface\\Cooldown\\star4.blp")
		shine:SetBlendMode("ADD")

		local anim = shinywheee:CreateAnimationGroup()
		local alphaIn = anim:CreateAnimation("Alpha")
	--	alphaIn:SetChange(0.3)
		alphaIn:SetFromAlpha(0)
		alphaIn:SetToAlpha(0.3)		
		alphaIn:SetDuration(0.4)
		alphaIn:SetOrder(1)
		local rotateIn = anim:CreateAnimation("Rotation")
		rotateIn:SetDegrees(-90)
		rotateIn:SetDuration(0.4)
		rotateIn:SetOrder(1)
		local scaleIn = anim:CreateAnimation("Scale")
		scaleIn:SetScale(2, 2)
		scaleIn:SetOrigin("CENTER", 0, 0)
		scaleIn:SetDuration(0.4)
		scaleIn:SetOrder(1)
		local alphaOut = anim:CreateAnimation("Alpha")
	--	alphaOut:SetChange(-0.5)
		alphaOut:SetFromAlpha(0.5)
		alphaOut:SetToAlpha(0)			
		alphaOut:SetDuration(0.4)
		alphaOut:SetOrder(2)
		local rotateOut = anim:CreateAnimation("Rotation")
		rotateOut:SetDegrees(-90)
		rotateOut:SetDuration(0.3)
		rotateOut:SetOrder(2)
		local scaleOut = anim:CreateAnimation("Scale")
		scaleOut:SetScale(-2, -2)
		scaleOut:SetOrigin("CENTER", 0, 0)
		scaleOut:SetDuration(0.4)
		scaleOut:SetOrder(2)
				
		anim:SetScript("OnFinished", function() shinywheee:Hide() end)
		shinywheee:SetScript("OnShow", function() anim:Play() end)
				
		-- Fill the dots
		self.Runes[i]:SetScript("OnValueChanged", function(self, val)
			-- Resize round overlay texture when hidden statusbar changes
			if (({GetRuneCooldown(self:GetID())})[3]) then
				-- Rune ready: show all 16x16px, play animation
				self.bg:SetWidth(16)
				self.bg:SetHeight(16)
				self.bg:SetTexCoord(0.5, 0.75, 0, 1)
				shinywheee:Show()
			else
				-- Dot distance from top & bottom of texture: 4px
				self.bg:SetWidth(16)
				self.bg:SetHeight(4 + 8 * val / 10)
				self.bg:SetTexCoord(0.25, 0.5, 12 / 16 - 8 * val / 10 / 16, 1)
			end
		end)
	end
end

local OnUpdate = function(self, elapsed)
	local duration = self.duration + elapsed
	if(duration >= self.max) then
		return self:SetScript("OnUpdate", nil)
	else
		self.duration = duration
		return self:SetValue(duration)
	end
end

function BlinkHealth:UpdateRuneType(event, rid)	
	local runeType = GetRuneType(rid);  --3
	local colors = self.runeColors[runeType]
	local rune = self.Runes[rid];
	local r, g, b = colors[1], colors[2], colors[3];
	rune:SetStatusBarColor(r, g, b);
	if(rune.bg) then
		rune.bg:SetVertexColor(r, g, b);
	end
end

function BlinkHealth:UpdateRune(event, rid)
	local rune = self.Runes[rid]
	if(rune) then
		local start, duration, runeReady = GetRuneCooldown(rune:GetID())
		if(runeReady) then
			rune:SetMinMaxValues(0, 1)
			rune:SetValue(1)
			rune:SetScript("OnUpdate", nil)
		else
			rune.duration = GetTime() - start
			rune.max = duration
			rune:SetMinMaxValues(1, duration)
			rune:SetScript("OnUpdate", OnUpdate)
		end
	end
end

function BlinkHealth:EnableRune()
	local runes = self.Runes;
	for i=1, 6 do
		local rune = runes[i];
		rune:SetID(i);
		self:UpdateRuneType(nil, i);
	end
	self:RegisterEvent("RUNE_POWER_UPDATE", "UpdateRune");
	self:RegisterEvent("RUNE_TYPE_UPDATE", "UpdateRuneType");
	runes:Show();
end

function BlinkHealth:DisableRune()
	self.Runes:Hide();
	self:UnregisterEvent("RUNE_POWER_UPDATE");
	self:UnregisterEvent("RUNE_TYPE_UPDATE");
end
end
----------------------
--[[ 施法条
do
local function OnEvent(self, event, ...)
	local arg1 = ...;
	if ( event == "PLAYER_TARGET_CHANGED" ) then
		-- check if the new target is casting a spell
		local nameChannel  = UnitChannelInfo("target");
		local nameSpell  = UnitCastingInfo("target");
		if ( nameChannel ) then
			event = "UNIT_SPELLCAST_CHANNEL_START";
			arg1 = "target";
		elseif ( nameSpell ) then
			event = "UNIT_SPELLCAST_START";
			arg1 = "target";
		else
			self.casting = nil;
			self.channeling = nil;
			self:SetMinMaxValues(0, 0);
			self:SetValue(0);
			self:Hide();
			return;
		end		
	end

	BlinkHealth:CastingBarAdjustPosition();
	CastingBarFrame_OnEvent(self, event, arg1, select(2, ...));
end

function BlinkHealth:CastingBarAdjustPosition()
	if (self.Combo) then
		self.castBar:ClearAllPoints();
		if (self.Combo[1]:IsVisible()) then
			self.castBar:SetPoint("TOPLEFT", self.Combo, "BOTTOMLEFT", 24, -5);
		else
			self.castBar:SetPoint("TOPLEFT", self.frame["target"].heal, "BOTTOMLEFT", 26, -5);
		end
	end
end

function BlinkHealth:ConstructCastingBar()  --do return end
	self.castBar = CreateFrame("StatusBar", "SimpleInfoTargetCastingBar", UIParent, "CastingBarFrameTemplate");
	self.castBar:SetWidth(120);
	self.castBar:SetHeight(15);
	self.castBar:Hide();
	self.castBar:SetPoint("TOPLEFT", self.frame["target"].heal, "BOTTOMLEFT", 26, -5);
	
	local name = self.castBar
	self.castBar:SetStatusBarTexture("Interface\\AddOns\\BlinkHealthText\\textures\\flat");
	name.Border:SetAlpha(0);
	name.BorderShield:SetAlpha(0);
	name.Flash:SetTexture("");
	self.castBar.bg = CreateFrame("Frame", nil, self.castBar, "BackdropTemplate");
	self.castBar.bg:SetFrameStrata("BACKGROUND");
	self.castBar.bg:SetPoint("TOPLEFT", self.castBar, "TOPLEFT", -5, 5);
	self.castBar.bg:SetPoint("BOTTOMRIGHT", self.castBar, "BOTTOMRIGHT", 5, -5);
		
	local backdrop = {
		bgFile = "Interface\\AddOns\\BlinkHealthText\\textures\\flat",
		edgeFile = "Interface\\AddOns\\BlinkHealthText\\textures\\2px_glow",
		tileSize = 16, edgeSize = 16, tile = true,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	};
		
	self.castBar.bg:SetBackdrop(backdrop);
	self.castBar.bg:SetBackdropColor(0.22, 0.22, 0.19);
	self.castBar.bg:SetBackdropBorderColor(0, 0, 0, 1);
	self.castBar.bg:SetAlpha(0.6);

	self.castBar:RegisterEvent("PLAYER_TARGET_CHANGED");
	CastingBarFrame_OnLoad(self.castBar, "target", false, true);
	self.castBar:SetScript("OnEvent", OnEvent);
	
	

	local barIcon = name.Icon
	barIcon:SetWidth(18);
	barIcon:SetHeight(18);
	barIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	barIcon:Show();

	name.Text:SetFontObject(SystemFont_Shadow_Small);	
	name.Text:ClearAllPoints();
	name.Text:SetPoint("LEFT", self.castBar, "LEFT", 4, 1);
	name.Text:SetJustifyH("LEFT");
	name.Text:SetWidth(100);
end
end]]

function BlinkHealth:ConstructFrame(unit)
	self.frame[unit] = CreateFrame("Frame", "SimpleInfoPlayerFrame", UIParent);
	self.frame[unit]:SetWidth(200);
	self.frame[unit]:SetHeight(50);
	if (unit == "player") then
		self.frame[unit]:SetPoint("BOTTOMRIGHT", self.anchor, "BOTTOM", -150, 0);
------------------RightClickMenu-Player-------------------------
    local RightClickPlayer = CreateFrame("Button", nil, self.frame[unit]) 
     RightClickPlayer:SetPoint("TOPLEFT",0,0)
     RightClickPlayer:SetPoint("BOTTOMRIGHT",0,-16)
     RightClickPlayer:SetScript("OnMouseDown", function(self, button)
		    --if button == "LeftButton" then SenduiCmd("/click PlayerFrame LeftButton")
		    if button == "RightButton" then SenduiCmd("/click PlayerFrame RightButton") 
		    end
    end)
-------------------------------------------------------------
	else
		self.frame[unit]:SetPoint("BOTTOMLEFT", self.anchor, "BOTTOM", 150, 0);
------------------RightClickMenu-Target------------------------
    local RightClickTarget = CreateFrame("Button", nil, self.frame[unit]) 
      RightClickTarget:SetPoint("TOPLEFT",0,0)
      RightClickTarget:SetPoint("BOTTOMRIGHT",0,-16)
      RightClickTarget:SetScript("OnMouseDown", function(self, button)
    --if button == "LeftButton" then
		  --if CheckInteractDistance("target",1) then InspectUnit("target") end
		if button == "RightButton" then
        SenduiCmd("/click TargetFrame RightButton")
		--elseif button == "MiddleButton" then
			--if CheckInteractDistance("target",2) then InitiateTrade("target") end
			--if CheckInteractDistance("target",1) then InspectUnit("target") end
		--elseif button == "Button4" then
			--if CheckInteractDistance("target",4) then FollowUnit(fullname, 1); end
		--else
			--if CheckInteractDistance("target",1) then InspectAchievements("target") end
		end
end)
-------------------------------------------------------------
	end
	self:ConstructHealth(unit);	
end

function BlinkHealth:CreateHitAnchor()
	if (self.HitAnchor) then return end

	self.HitAnchor = CreateFrame("Button", "SimpleInfoHitPointAnchorFrameNew", UIParent, "BackdropTemplate");
	self.HitAnchor:SetSize(100, 80);
	self.HitAnchor:EnableMouse(true);
	self.HitAnchor:SetMovable(true);
	self.HitAnchor:SetPoint("CENTER", UIParent, "CENTER", 121, -43);
	local backdrop = {
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tileSize = 16, edgeSize = 10, tile = true,
		insets = {left = 2, right = 2, top = 2, bottom = 2}
	};		
	self.HitAnchor:SetBackdrop(backdrop);
	self.HitAnchor:SetBackdropColor(0.1, 0.1, 0.1, 0.65)
	self.HitAnchor:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
	
	self.HitAnchor.close = CreateFrame("Button", nil, self.HitAnchor, "UIPanelCloseButton");
	self.HitAnchor.close:SetPoint("TOPRIGHT", self.HitAnchor, "TOPRIGHT", 1, 1);

	--self.HitAnchor.text = self.HitAnchor:CreateFontString(nil, "OVERLAY");
	--self.HitAnchor.text:SetFont("Interface\\Addons\\OrzUI\\Media\\Fonts\\REDCIRCL.ttf", 21, "OUTLINE");
	--self.HitAnchor.text:SetPoint("LEFT", self.HitAnchor, "LEFT", 20, -5);
	--self.HitAnchor.text:SetJustifyH("RIGHT");
	--self.HitAnchor.text:SetTextColor(1.0, 0.69, 0.0);
	--self.HitAnchor.text:SetText("hits");

	self.HitAnchor:RegisterForClicks("LeftButtonDown", "RightButtonDown");
	self.HitAnchor:SetScript("OnMouseDown", function(self, button)
		if (button == "LeftButton") then
			self:StartMoving();
			self.isMoving = true;
		else
			self:Hide();
		end
		
	end);
	self.HitAnchor:SetScript("OnMouseUp", function(self)
		if (self.isMoving) then self:StopMovingOrSizing(); end		
	end);
	
	--self.HitAnchor.originalStopMovingOrSizing = self.HitAnchor.StopMovingOrSizing;
	--self.HitAnchor.duration = 1;
	self.HitAnchor:Hide();
end

function BlinkHealth:ConstructHitPoints()
	self:CreateHitAnchor();
	if (not self.hitPoint) then
		self.hitPoint = CreateFrame("Frame", nil, UIParent);
		self.hitPoint:SetWidth(100);
		self.hitPoint:SetHeight(80);
		self.hitPoint:SetPoint("CENTER", self.HitAnchor, "CENTER", 0, 0);
		self.hitPoint.text = self.hitPoint:CreateFontString(nil, "OVERLAY");
		self.hitPoint.text:SetFont("Interface\\Addons\\OrzUI\\Media\\Fonts\\REDCIRCL.ttf", 43, "OUTLINE");
		self.hitPoint.text:SetPoint("LEFT", self.HitAnchor, "LEFT", 20, -5);
		self.hitPoint.text:SetJustifyH("RIGHT");
		self.hitPoint.text:SetTextColor(1.0, 0.69, 0.0);
		self.hitPoint.text:SetText("");
		self.hitPoint.hit = self.hitPoint:CreateFontString(nil, "OVERLAY");
		self.hitPoint.hit:SetFont("Interface\\Addons\\OrzUI\\Media\\Fonts\\REDCIRCL.ttf", 14, "OUTLINE");
		self.hitPoint.hit:SetPoint("BOTTOMLEFT", self.hitPoint.text, "BOTTOMRIGHT", 5, 16);
		self.hitPoint.hit:SetTextColor(1.0, 0.69, 0.0);

		self.hitPoint.class = BlinkHealth.class

		self.hitPoint:SetScript("OnEvent", function(frame, event, unit, ...)
			if ( event == "PLAYER_TARGET_CHANGED" or (event == "UNIT_POWER_UPDATE" and unit == PlayerFrame.unit)) then
				local point
				if self.class == "MONK" then
					point = UnitPower("player", SPELL_POWER_CHI)
				else
					point = GetComboPoints('player', 'target')	--UnitPower("player", SPELL_POWER_COMBO_POINTS)
				end
				if (point > 0) then			
					self.hitPoint.text:SetText(point);
					self.hitPoint.hit:SetText("hit");
				else
					self.hitPoint.text:SetText("");
					self.hitPoint.hit:SetText("");
				end
			end
		end);
	end	
end

--[[function BlinkHealth:ToggleCastingBar(switch)
	if (switch) then
		self.castBar.showCastbar = true;
	else
		self.castBar.showCastbar = false;
		self.castBar:Hide();
	end
end]]

function BlinkHealth:ShowAnchor()
	self.anchor:Show();
end

function BlinkHealth:ToggleNameVisible(switch)
	if (switch) then
		self.frame["target"].name:Show();
	else
		self.frame["target"].name:Hide();
	end
end

function BlinkHealth:ToggleRuneFrameVisible(switch)
	if (switch) then	
		self:EnableRune();
		self:ScheduleTimer("EnableRune", 1);
	else
		self:DisableRune();
	end
end

function BlinkHealth:ToggleHitPoint(switch)
	self:ConstructHitPoints();
	if (switch) then
		self.hitPoint:RegisterEvent("PLAYER_TARGET_CHANGED");
		self.hitPoint:RegisterEvent("UNIT_POWER_UPDATE");
		self.hitPoint:Show();
		self.Combo:SetAlpha(0);
	else
		self.hitPoint:UnregisterEvent("PLAYER_TARGET_CHANGED");
		self.hitPoint:UnregisterEvent("UNIT_POWER_UPDATE");
		self.hitPoint:Hide();
		self.Combo:SetAlpha(1);
	end
end

function BlinkHealth:ShowHitAnchor()
	self.HitAnchor:Show();
end
function BlinkHealth_SlashHandler(msg)
	--local BHT_1 = "输入 /bht on 或 /bht off 开关插件\n";
	--local BHT_2 = "输入 /bht m 调整位置\n";
	--local BHT_3 = "输入 /bht hiton 或 /bht hitoff 是否显示数字连击点数\n";
	local cmdtype, para1 = strsplit(" ", string.lower(msg))
	local MyClass = select(2, UnitClass("player"))
	--local listSec = 0;
	--if para1 ~= nil then
		--listSec = tonumber(para1);
	--end
	if (msg == "on") then BlinkHealth:OnEnable();
	elseif (msg == "off") then BlinkHealth:OnDisable();
	--elseif (cmdtype == "rune") then if (MyClass == "DEATHKNIGHT") then BlinkHealth:ToggleRuneFrameVisible(true); end
	elseif (cmdtype == "hiton") then
		if (MyClass == "MONK") or (MyClass == "PALADIN") or (MyClass == "WARLOCK") or (MyClass == "MAGE") or (MyClass == "ROGUE") or (MyClass == "DRUID") then	
			BlinkHealth:ToggleHitPoint(true);
		end			
		ShiGuangPerDB.BHTHit = true;		
	elseif (cmdtype == "hitoff") then
		if (MyClass == "MONK") or (MyClass == "PALADIN") or (MyClass == "WARLOCK") or (MyClass == "MAGE") or (MyClass == "ROGUE") or (MyClass == "DRUID") then
			BlinkHealth:ToggleHitPoint(false);
		end
		ShiGuangPerDB.BHTHit = false;
	--else 
	else--if (cmdtype == "move" or cmdtype == "m") then
			BlinkHealth:ShowAnchor();
		if (MyClass == "MONK") or (MyClass == "PALADIN") or (MyClass == "WARLOCK") or (MyClass == "MAGE") or (MyClass == "ROGUE") or (MyClass == "DRUID") then	
			BlinkHealth:ShowHitAnchor();
		end	
		--DEFAULT_CHAT_FRAME:AddMessage("输入 /bht m 调整位置");
	end
end
function BlinkHealth:OnInitialize()
	self.frame = {};
	self:CreateAnchorFrame()
	self:ConstructFrame("player");
	self:ConstructFrame("target");
	self.class = select(2, UnitClass("player"));
	--if (self.class == "DEATHKNIGHT") then self:ConstructRunes(); end
	if ("MONK,PALADIN,WARLOCK,MAGE,ROGUE,DRUID"):find(select(2, UnitClass("player"))) then self:ConstructCombo(); self:ConstructHitPoints(); end	-- 构建连击点 
	if (self.class == "ROGUE" or self.class == "DRUID" or self.class == "MONK") then		
		self:ConstructCombo();
		self:ConstructHitPoints();	-- 构建连击点
	end	
	--self:ConstructCastingBar();
	self:UpdateUnitFrame();
	SlashCmdList["BLINKHEALTH"] = BlinkHealth_SlashHandler;
	SLASH_BLINKHEALTH1 = "/bht";
	self:Delayclass();
	--if (ShiGuangPerDB.BHTHit == true) then SenduiCmd("/bht hiton") else SenduiCmd("/bht hitoff") end
end
function BlinkHealth:Delayclass()
	if IsLoggedIn()  then
		self:Delaydo();
	else
		self:ScheduleTimer("Delaydo",5);--延时5秒，dk符文在 PLAYER_ENTERING_WORLD事件前似乎不能获取信息
	end
end
function BlinkHealth:Delaydo()
	--if (select(2, UnitClass("player")) == "DEATHKNIGHT") then		
		--self:ToggleRuneFrameVisible(true);
	--end
	if (select(2, UnitClass("player")) == "ROGUE" or select(2, UnitClass("player")) == "DRUID") then		
		self:ToggleHitPoint(true);
	end
end

------------------------------------------------------头像渐隐
local function PowerTypeAscending()
	PowerTypeID, PowerTypeName = UnitPowerType("player")
	for _,p in pairs({ 0, 2, 3}) do if p == PowerTypeID then Return = true end end
	Return = false
end

local function AutoHidePlayerFrame(self,event, ...)
	if (not R.db["UFs"]["UFFade"]) or (ShiGuangPerDB["BHT"] == true) then return end
	--if (event == nil) then event = "TargetFrame or CharacterModelFrame toggled" end
	if UnitHealth("player") < UnitHealthMax("player") * 0.99 or (powerTypeAscending and UnitPower("player") <= UnitPowerMax("player") * 0.99) or TargetFrame:IsShown() or UnitAffectingCombat("player") or CharacterFrame:IsShown() or ContainerFrame1:IsShown() then
		if (not PlayerFrame:IsShown()) then
			if (not InCombatLockdown()) then
				local returnState, returnMessage = pcall(PlayerFrame.Show, PlayerFrame)
				if not (returnState) then
					if not (returnMessage == nil) then else end
				end
			end
		end
	else
		if (PlayerFrame:IsShown()) then
			if (not InCombatLockdown()) then
				local returnState, returnMessage = pcall(PlayerFrame.Hide, PlayerFrame)
				if not (returnState) then
					if not (returnMessage == nil) then else end
				end
			end
		end
	end
end

local iPlayerFrame = CreateFrame("Frame", "iPlayerFrame", UIParent, "SecureHandlerStateTemplate")
iPlayerFrame:RegisterEvent("PLAYER_LOGIN")
iPlayerFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
iPlayerFrame:RegisterEvent("UNIT_HEALTH")
iPlayerFrame:RegisterEvent("UNIT_SPELLCAST_START")
iPlayerFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
iPlayerFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
iPlayerFrame:RegisterEvent("UNIT_MAXPOWER")
--iPlayerFrame:RegisterEvent("UNIT_MODEL_CHANGED")
iPlayerFrame:SetScript("OnEvent", AutoHidePlayerFrame)
TargetFrame:HookScript("OnShow", AutoHidePlayerFrame)
TargetFrame:HookScript("OnHide", AutoHidePlayerFrame)