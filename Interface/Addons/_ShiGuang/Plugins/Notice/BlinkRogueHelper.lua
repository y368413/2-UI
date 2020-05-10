local _, class = UnitClass("player")
if class ~= "ROGUE" and class ~= "DRUID" and class ~= "PALADIN" and class ~= "MONK" then return end
-------------------------------------------------------------------------------
--
--  Mod Name : BlinkRogueHelper 3.0a
--  Author   : Blink
--  Date     : 2004/10/11
--  LastUpdate : 2008/10/16
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--
--  Version : BlinkRogueHelper 8.15
--  Continued by : Jovan
--  Date     : 2019/04/28
--
-------------------------------------------------------------------------------
local BRH = {
	["x"] 					= 0,   	-- position
	["y"] 					= 88,
	["FontSize"]		= 88,
	["Shake"]				= 3,
	["Font"] 				= "Interface\\Addons\\_ShiGuang\\Media\\Fonts\\Edo.ttf",  --RedCircl
}

BRHDB = BRHDB or {}
local BRHPowerType = {
	["ROGUE"] = {"COMBO_POINTS", 4},
	["DRUID"] = {"COMBO_POINTS", 4},
	["PALADIN"] = {"HOLY_POWER", 9},
	["MONK"] = {"CHI", 12},
}
local BRHSpec = {
	-- ["ROGUE"] = true,
	["DRUID"] = 2,
	["PALADIN"] = 3,
	["MONK"] = 3,
}

local CPSkills = {
	[1833] = true,
	[137619] = true,
	--Subtlety
	[185438] = true,
	[53] = true,
	[200758] = true,
	[197835] = true,
	[114014] = true,
	-- 196912 = true,
	--Outlaw
	[8676] = true,
	[1776] = true,
	[193315] = true,
	[185763] = true,
	[196937] = true,
	-- 14161 = true,
	--Assassination
	[51723] = true,
	[185565] = true,
	[1329] = true,
	[703] = true,
	-- 14190 = true,
	[111240] = true,
	[245388] = true,
}

local UnitPower = UnitPower
local lastCPUpdate, r, g, b
local combo, maxcp = UnitPower("player", BRHPowerType[class][2]), UnitPowerMax("player", BRHPowerType[class][2])

local function BlinkRogueHelper_Show()
	BlinkRogueHelperFrame.startTime = GetTime();
	BlinkRogueHelperFrame:Show();
end

local function SetBubbleTextColor()
	if ( combo == maxcp ) then
		r = 0.15;
		g = 0.59;
		b = 0.88; -- blue
	elseif( combo == maxcp-1 )then
		r = 0.8;
		g = 0.4;
		b = 0.1; -- orange
	else
		r = 0.2;
		g = 1.0;
		b = 0.2; -- green
	end
	BlinkRogueHelperFrame.TextString:SetTextColor(r, g, b);
end

local function BRHUpdateComboPoints(combo, updatecolor)
	if ( combo > 0 )then
		BlinkRogueHelperFrame.TextString:SetText(combo);
		SetBubbleTextColor();
		BlinkRogueHelper_Show();
	else
		BlinkRogueHelperFrame:Hide();
	end
	lastCPUpdate = combo
end

local maxcpFresher = CreateFrame("Frame")
maxcpFresher:SetScript("OnEvent", function(self)
		maxcp = UnitPowerMax("player", BRHPowerType[class][2])
		self:UnregisterEvent("PLAYER_REGEN_DISABLED")
end)
maxcpFresher:RegisterEvent("PLAYER_REGEN_DISABLED")

local Anchor = CreateFrame("Frame", "BRHAnchor", UIParent)
Anchor:SetSize(BRH.FontSize, BRH.FontSize)
Anchor:SetPoint("CENTER", UIParent, BRHDB.x and "BOTTOMLEFT" or "CENTER", BRHDB.x or BRH.x, BRHDB.y or BRH.y)
Anchor.bg = Anchor:CreateTexture(nil, "OVERLAY")
Anchor.bg:SetAllPoints(Anchor)
Anchor.bg:SetColorTexture(.2, 1, .2, .4)
Anchor.text = Anchor:CreateFontString(nil, "OVERLAY")
Anchor.text:SetFont(BRH.Font, BRH.FontSize/4, "OUTLINE")
Anchor.text:SetAllPoints(Anchor)
Anchor.text:SetText("Dragme")
Anchor:SetMovable(true)
Anchor:EnableMouse(true)
Anchor:RegisterForDrag("LeftButton")
Anchor:Hide()
Anchor:SetScript("OnEvent", function(self) self:Hide() end)
Anchor:RegisterEvent("PLAYER_REGEN_DISABLED")
Anchor:SetScript("OnDragStart", function(self) self:StartMoving() end)
Anchor:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	BRHDB.x, BRHDB.y = self:GetCenter()
end)

local BlinkRogueHelperFrame = CreateFrame("Frame","BlinkRogueHelperFrame",UIParent)
BlinkRogueHelperFrame:SetSize(BRH.FontSize,BRH.FontSize)
BlinkRogueHelperFrame:SetPoint("TOP", Anchor, "CENTER")
-- BlinkRogueHelperFrame:SetPoint("CENTER",UIParent,"CENTER",BRH.x,BRH.y+BRH.FontSize)
BlinkRogueHelperFrame.TextString = BlinkRogueHelperFrame:CreateFontString(nil,"OVERLAY")
BlinkRogueHelperFrame.TextString:SetFont(BRH.Font, BRH.FontSize, "OUTLINE");
BlinkRogueHelperFrame.TextString:SetAllPoints(BlinkRogueHelperFrame)
BlinkRogueHelperFrame.TextString:SetShadowOffset(1.5,-1.5)


local BlinkRogueHelper_Type = 5;
BlinkRogueHelperFrame.TextString:SetTextHeight(BRH.FontSize);
BlinkRogueHelperFrame.fadeInTime = 0.2;		-- fade in time(sec)
BlinkRogueHelperFrame.holdTime = 1.0;		-- hold time(sec)
BlinkRogueHelperFrame.fadeOutTime = 0.8;		-- fade out time(sec)
BlinkRogueHelperFrame.flowTime = BlinkRogueHelperFrame.fadeInTime + BlinkRogueHelperFrame.holdTime +BlinkRogueHelperFrame.fadeOutTime;
BlinkRogueHelperFrame.PI = 3.141592;

BlinkRogueHelperFrame:Hide();

BlinkRogueHelperFrame:SetScript("OnEvent", function(self, event, unit, powerType, spellId)
	if ( event == "PLAYER_SPECIALIZATION_CHANGED" or event == "PLAYER_ENTERING_WORLD") then
		if ( class == "ROGUE" ) then
			BlinkRogueHelperFrame:RegisterEvent("UNIT_POWER_UPDATE")
		else
			if ( BRHSpec[class] == GetSpecialization() ) then
				BlinkRogueHelperFrame:RegisterEvent("UNIT_POWER_UPDATE")
			else
				BlinkRogueHelperFrame:UnregisterEvent("UNIT_POWER_UPDATE")
			end
		end
	elseif ( event == "PLAYER_TARGET_CHANGED" ) then
    	local alive = UnitHealth("target")
    	if (alive and alive > 0)  then BRHUpdateComboPoints(combo) end
	elseif ( not unit == "player" ) then return
	else
		combo = UnitPower("player", BRHPowerType[class][2])
		if ( event == "UNIT_POWER_UPDATE" and powerType == BRHPowerType[class][1]) then
		if ( combo ~= lastCPUpdate ) then
			BRHUpdateComboPoints(combo)
		end
		elseif ( event == "UNIT_SPELLCAST_SUCCEEDED" and combo == maxcp) then
			if CPSkills[spellId] then BRHUpdateComboPoints(combo) end
		end
	end
end)
BlinkRogueHelperFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
BlinkRogueHelperFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
BlinkRogueHelperFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED");
BlinkRogueHelperFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
BlinkRogueHelperFrame:RegisterEvent("PLAYER_ENTERING_WORLD");

BlinkRogueHelperFrame:SetScript("OnUpdate", function()
	local elapsed = 1.75 * (GetTime() - BlinkRogueHelperFrame.startTime);
	local flowTime = elapsed / BlinkRogueHelperFrame.flowTime;
	local fadeInTime = BlinkRogueHelperFrame.fadeInTime;
	-- local combo = UnitPower("player", BRHPowerType[class][2])
	local scale = combo==maxcp and 1 or .7;
	local cos, sin, rand = math.cos, math.sin, math.random;
	local xshake, yshake, zshake = rand(-BRH.Shake,BRH.Shake), rand(-(BRH.Shake-3),(BRH.Shake-3)), rand(-BRH.Shake,BRH.Shake);
	local xpos = xshake * sin(BlinkRogueHelperFrame.PI*2*8*flowTime);
	local ypos = yshake * sin(BlinkRogueHelperFrame.PI*2*5*flowTime+1.5);
	local zpos = zshake * sin(BlinkRogueHelperFrame.PI*2*flowTime);

	if ( elapsed < fadeInTime ) then
		local alpha = (elapsed / fadeInTime);
		BlinkRogueHelperFrame:SetAlpha(alpha);
		BlinkRogueHelperFrame.TextString:SetTextHeight(BRH.FontSize * alpha * scale + 1);
		BlinkRogueHelperFrame:SetPoint("TOP", Anchor, "CENTER", 0, BRH.FontSize*alpha );
		return;
	end

	local holdTime = BlinkRogueHelperFrame.holdTime;
	if ( elapsed < (fadeInTime + holdTime) ) then
		BlinkRogueHelperFrame:SetAlpha(1.0);
		BlinkRogueHelperFrame.TextString:SetTextHeight( zpos + BRH.FontSize * scale  + 1);
		BlinkRogueHelperFrame:SetPoint("TOP", Anchor, "CENTER", xpos, ypos + BRH.FontSize );
		return;
	end

	local fadeOutTime = 0.8 * BlinkRogueHelperFrame.fadeOutTime;
	if ( elapsed < (fadeInTime + holdTime + fadeOutTime) ) then
		local alpha = 1.0 - ((elapsed - holdTime - fadeInTime) / fadeOutTime);
		BlinkRogueHelperFrame:SetAlpha(alpha);
		BlinkRogueHelperFrame.TextString:SetTextHeight(BRH.FontSize * alpha * scale + 1);
		BlinkRogueHelperFrame:SetPoint("TOP", Anchor, "CENTER", 0, BRH.FontSize * alpha );
		return;
	end
	BlinkRogueHelperFrame:Hide();
end)


SlashCmdList["BRH"] = function()
	if Anchor:IsVisible() then
		Anchor:Hide()
	elseif ( not InCombatLockdown() ) then
		Anchor:Show()
	end
end
SLASH_BRH1 = "/brh"
SlashCmdList["BRHReset"] = function()
	BRHDB.x, BRHDB.y = BRH.x, BRH.y
	Anchor:ClearAllPoints()
	Anchor:SetPoint("CENTER", UIParent, "CENTER", BRH.x, BRH.y)
	BlinkRogueHelperFrame:SetPoint("CENTER", Anchor)
	Anchor:Hide()
end
SLASH_BRHReset1 = "/brhreset"
