local _, ns = ...
local M, R, U, I = unpack(ns)

hooksecurefunc("TextStatusBar_UpdateTextString", function(bar)   ----	  血量百分比数字 
	local value = bar:GetValue()
	local min, max = bar:GetMinMaxValues()
	if bar.pctText then
		bar.pctText:SetText(value==0 and "" or tostring(math.ceil((value / max) * 100)))  --(value==0 and "" or tostring(math.ceil((value / max) * 100)) .. "%")
		if not R.db["UFs"]["UFPctText"] or value == max then bar.pctText:Hide()
		elseif GetCVarBool("statusTextPercentage") and ( bar.unit == PlayerFrame.unit or bar.unit == "target" or bar.unit == "focus" ) then bar.pctText:Hide()
		else bar.pctText:Show()
		end
		if max > min then value = (value - min) / (max - min) else value = 0 end
		if value > 0.5 then r, g, b = 2*(1-value), 1, 0 else r, g, b = 1, 2*value, 0 end
		bar.pctText:SetTextColor(r, g, b)
	end
end)

function CreateBarPctText(frame, ap, rp, x, y, font, fontsize)
	local bar = frame.healthbar 
	if bar then
		if bar.pctText then
			bar.pctText:ClearAllPoints()
			bar.pctText:SetPoint(ap, bar, rp, x, y)
		else
			bar.pctText = frame:CreateFontString(nil, "OVERLAY", font)
			bar.pctText:SetPoint(ap, bar, rp, x, y)
			bar.pctText:SetFont("Interface\\addons\\_ShiGuang\\Media\\Fonts\\Pixel.TTF", fontsize, "OUTLINE")
			bar.pctText:SetShadowColor(0, 0, 0)
		end
	end
end
CreateBarPctText(PlayerFrame, "RIGHT", "LEFT", -80, -8, "NumberFontNormalLarge", 36)
CreateBarPctText(PetFrame, "LEFT", "RIGHT", 8, -3, "NumberFontNormalLarge", 16)
--CreateBarPctText(TargetFrame, "LEFT", "RIGHT", 80, -8, "NumberFontNormalLarge", 36)
--CreateBarPctText(TargetFrameToT, "BOTTOMLEFT", "TOPRIGHT", 0, 5)
CreateBarPctText(FocusFrame, "RIGHT", "LEFT", -3, -8, "NumberFontNormalLarge", 36)
--CreateBarPctText(FocusFrameToT, "BOTTOMLEFT", "TOP", 24, 10)
--for i = 1, 4 do CreateBarPctText(_G["PartyMemberFrame"..i], "LEFT", "RIGHT", 6, 0, "NumberFontNormal", 16) end
--for i = 1, MAX_BOSS_FRAMES do CreateBarPctText(_G["Boss"..i.."TargetFrame"], "LEFT", "RIGHT", 8, 30, "NumberFontNormal", 36) end	

--	Player class colors.
function whoaUnitClass(healthbar, unit)
	if healthbar and not healthbar.lockValues and unit == healthbar.unit then
		local min, max = healthbar:GetMinMaxValues()
		local value = healthbar:GetValue()
		if max > min then value = (value - min) / (max - min) else value = 0 end
		if value > 0.5 then r, g, b = 2*(1-value), 1, 0 else r, g, b = 1, 2*value, 0 end
			--if UnitIsPlayer(unit) and UnitClass(unit) then  --按职业着色
				--local color = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
				--healthbar:SetStatusBarColor(color.r, color.g, color.b)
			--else
				--healthbar:SetStatusBarColor(r, g, b)
			--end
		if healthbar.pctText then	healthbar.pctText:SetTextColor(r, g, b) end
	end
	if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitClass(unit) then
		_, class = UnitClass(unit);
		local c = RAID_CLASS_COLORS[class];
		healthbar:SetStatusBarColor(c.r, c.g, c.b);
	elseif UnitIsPlayer(unit) and (not UnitIsConnected(unit)) then
		healthbar:SetStatusBarColor(0.5,0.5,0.5);
	else
		healthbar:SetStatusBarColor(0,0.9,0);
	end
end
hooksecurefunc("UnitFrameHealthBar_Update", whoaUnitClass)
hooksecurefunc("HealthBar_OnValueChanged", function(self)
	whoaUnitClass(self, self.unit)
end)

-- palyer frame class color selector.
function whoaUnitColor(unit)
	--if (reactColor) then
		if UnitIsTapDenied(unit) then
			r, g, b = 0.5, 0.5, 0.5;
		else
			r, g, b = UnitSelectionColor(unit);
			if (b >= 0.9) then g, b = 0.9, 0; end
			if not (blizzColors) then
				if (r >= 0.9) and (g >= 0.5) and (g <= 0.6) and (b == 0) then
					r, g, b = r, g, b; -- orange.
				elseif (r >= 0.9) and (g >= 0.9) and (b == 0) then
					r, g, b = 0.9, 0.75, 0; -- yellow.
				elseif (r >= 0.9) and (g == 0) and (b == 0) then
					r, g, b = 0.8, 0.1, 0; -- red.
				else
					r, g, b = 0, 0.6, 0.1; -- green.
				end
			end
		end
	--else
		--r, g, b = 0, 0.9, 0;
	--end
	if UnitIsPlayer(unit) then
		if not UnitIsConnected(unit) then
			r, g, b = 0.5, 0.5, 0.5;
		elseif UnitClass(unit) then
			_, class = UnitClass(unit);
			local c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
				r, g, b = c.r, c.g, c.b;
			else
		end
	end
	return r, g, b;
end
-- fix.
hooksecurefunc("HealthBar_OnValueChanged", function(self)
	PlayerFrameHealthBar:SetStatusBarColor(whoaUnitColor("player"));
end)

-- hooksecurefunc("UnitFramePortrait_Update",function(self)
	-- if self.portrait then
		-- if UnitIsPlayer(self.unit) then			
			-- local t = CLASS_ICON_TCOORDS[select(2,UnitClass(self.unit))]
			-- if t then
				-- self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
				-- self.portrait:SetTexCoord(unpack(t))
			-- end
		-- else
			-- self.portrait:SetTexCoord(0,1,0,1)
		-- end
	-- end
-- end);

function WhoaGroupIndicator()
	local name, rank, subgroup;
	if ( not IsInRaid() ) then
		return;
	end
	local numGroupMembers = GetNumGroupMembers();
	for i=1, MAX_RAID_MEMBERS do
		if ( i <= numGroupMembers ) then
			name, rank, subgroup = GetRaidRosterInfo(i);
			if ( name == UnitName("player") ) then
				PlayerFrameGroupIndicatorText:SetText("G"..subgroup);
				PlayerFrameGroupIndicator:SetWidth(PlayerFrameGroupIndicatorText:GetWidth());-- +40);
				PlayerFrameGroupIndicator:Show();
			end
		end
	end
end
hooksecurefunc("PlayerFrame_UpdateGroupIndicator", WhoaGroupIndicator)

-- Unit frames Status text reformat.
local function customStatusTex(statusFrame, textString, value, valueMin, valueMax)
	local xpValue = UnitXP("player");
	local xpMaxValue = UnitXPMax("player");

	if (statusFrame.LeftText and statusFrame.RightText) then
		statusFrame.LeftText:SetText("");
		statusFrame.RightText:SetText("");
		statusFrame.LeftText:Hide();
		statusFrame.RightText:Hide();
	end
	
	valueDisplay	=	M.Numb(value)
	valueMaxDisplay	=	M.Numb(valueMax)			
	
	if ((tonumber(valueMax) ~= valueMax or valueMax > 0) and not (statusFrame.pauseUpdates)) then
		statusFrame:Show();
		if ((statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable) or statusFrame.forceShow) then
			textString:Show();
		elseif (statusFrame.lockShow > 0 and (not statusFrame.forceHideText)) then
			textString:Show();
		else
			textString:SetText("");
			textString:Hide();
			return;
		end
		local textDisplay = GetCVar("statusTextDisplay");
		if (value and valueMax > 0 and ((textDisplay ~= "NUMERIC" and textDisplay ~= "NONE") or statusFrame.showPercentage) and not statusFrame.showNumeric) then
			if (value == 0 and statusFrame.zeroText) then
				textString:SetText(statusFrame.zeroText);
				statusFrame.isZero = 1;
				textString:Show();
			elseif (textDisplay == "BOTH" and not statusFrame.showPercentage) then
				if (statusFrame.LeftText and statusFrame.RightText) then
					if (not statusFrame.powerToken or statusFrame.powerToken == "MANA") then
						statusFrame.LeftText:SetText(math.ceil((value / valueMax) * 100) .. "%");
						if value == 0 then statusFrame.LeftText:SetText(""); end
						statusFrame.LeftText:Show();
					end
					statusFrame.RightText:SetText(valueDisplay);
					if value == 0 then statusFrame.RightText:SetText(""); end
					statusFrame.RightText:Show();
					textString:Hide();
				else
					valueDisplay = "(" .. math.ceil((value / valueMax) * 100) .. "%) " .. valueDisplay .. " / " .. valueMaxDisplay;
					if value == 0 then textString:SetText(""); end
				end
				textString:SetText(valueDisplay);
			else
				valueDisplay = math.ceil((value / valueMax) * 100) .. "%";
				if ( statusFrame.prefix and (statusFrame.alwaysPrefix or not (statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable) ) ) then
					textString:SetText(statusFrame.prefix .. " " .. valueDisplay);
				else
					textString:SetText(valueDisplay);
				end
				if value == 0 then textString:SetText(""); end
			end
		elseif (value == 0 and statusFrame.zeroText) then
			textString:SetText(statusFrame.zeroText);
			statusFrame.isZero = 1;
			textString:Show();
			return;
		else
			statusFrame.isZero = nil;
			if ( statusFrame.prefix and (statusFrame.alwaysPrefix or not (statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable) ) ) then
				textString:SetText(statusFrame.prefix.." "..valueDisplay.." / "..valueMaxDisplay)
			elseif valueMax == value then
			  textString:SetText(valueMaxDisplay)
			else
				textString:SetText(valueDisplay .. " / " .. valueMaxDisplay);
			end
			if value == 0 then textString:SetText("") end
		end
	else
		textString:Hide();
		textString:SetText("");
		if (not statusFrame.alwaysShow) then
			statusFrame:Hide();
		else
			statusFrame:SetValue(0);
		end
	end
end
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", customStatusTex)

-- Text builder factory.
local function CreateText(name, parentName, parent, point, x, y)
	local fontString = parent:CreateFontString(parentName .. name, nil, "GameFontNormalSmall")
	fontString:SetPoint(point, parent, point, x, y)
	return fontString
end

-- Create dead/ghost/offline text.
function createDeadTextFrames(self)
	deadText = CreateText("DeadText", "PlayerFrame", PlayerFrameHealthBar, "CENTER", 0, 0);
	deadText:SetText(DEAD);
	deadText = CreateText("GhostText", "PlayerFrame", PlayerFrameHealthBar, "CENTER", 0, 0);
	deadText:SetText("Ghost");

	deadText = CreateText("GhostText", "TargetFrame", TargetFrameHealthBar, "CENTER", 0, 0);
	deadText:SetText("Ghost");
	deadText = CreateText("OfflineText", "TargetFrame", TargetFrameHealthBar, "CENTER", 0, 0);
	deadText:SetText("Offline");

	deadText = CreateText("GhostText", "FocusFrame", FocusFrameHealthBar, "CENTER", 0, 0);
	deadText:SetText("Ghost");
	deadText = CreateText("OfflineText", "FocusFrame", FocusFrameHealthBar, "CENTER", 0, 0);
	deadText:SetText("Offline");
end

--	Player dead text switch.
function playerDeadCheck()
	if UnitIsDead("player") then
		PlayerFrameDeadText:Show();
		PlayerFrameGhostText:Hide();
		PlayerFrameAlternateManaBar:Hide();
	elseif UnitIsGhost("player") then
		PlayerFrameDeadText:Hide();
		PlayerFrameGhostText:Show();
		PlayerFrameAlternateManaBar:Hide();
	else
		PlayerFrameDeadText:Hide();
		PlayerFrameGhostText:Hide();
		PlayerFrameAlternateManaBar:Show();
	end
	if UnitExists("player") and UnitIsDead("player") or UnitIsGhost("player") then
		for i, v in pairs({	PlayerFrameHealthBarText, PlayerFrameManaBarText, PlayerFrameHealthBar.LeftText, PlayerFrameHealthBar.RightText, PlayerFrameManaBar.LeftText, PlayerFrameManaBar.RightText, PlayerFrameTextureFrameManaBarText, PlayerFrameManaBar }) do v:SetAlpha(0); end
	else
		for i, v in pairs({	PlayerFrameHealthBarText, PlayerFrameManaBarText, PlayerFrameHealthBar.LeftText, PlayerFrameHealthBar.RightText, PlayerFrameManaBar.LeftText, PlayerFrameManaBar.RightText, PlayerFrameTextureFrameManaBarText, PlayerFrameManaBar }) do v:SetAlpha(1); end
	end
end

-- Target frame dead text switch.
function targetDeadCheck()
	if UnitIsDead("target") then
		TargetFrameGhostText:Hide();
		TargetFrameOfflineText:Hide();
	elseif UnitIsGhost("target") then
		TargetFrameGhostText:Show();
		TargetFrameOfflineText:Hide();
	elseif UnitIsPlayer("target") and not UnitIsConnected("target") then
		TargetFrameGhostText:Hide();
		TargetFrameOfflineText:Show();
	else
		TargetFrameGhostText:Hide();
		TargetFrameOfflineText:Hide();
	end
	if UnitExists("target") and UnitIsDead("target") or UnitIsGhost("target") or not UnitIsConnected("target") then
		for i, v in pairs({	TargetFrameTextureFrameHealthBarText, TargetFrameTextureFrameManaBarText, TargetFrameHealthBar.LeftText, TargetFrameHealthBar.RightText, TargetFrameManaBar.LeftText, TargetFrameManaBar.RightText, TargetFrameTextureFrameManaBarText, TargetFrameManaBar }) do v:SetAlpha(0); end
	else
		for i, v in pairs({	TargetFrameTextureFrameHealthBarText, TargetFrameTextureFrameManaBarText, TargetFrameHealthBar.LeftText, TargetFrameHealthBar.RightText, TargetFrameManaBar.LeftText, TargetFrameManaBar.RightText, TargetFrameTextureFrameManaBarText, TargetFrameManaBar }) do v:SetAlpha(1); end
	end
end

-- Focus frame dead text switch.
function focusDeadCheck()
	if UnitIsDead("focus") then
		FocusFrameGhostText:Hide();
		FocusFrameOfflineText:Hide();
	elseif UnitIsGhost("focus") then
		FocusFrameGhostText:Show();
		FocusFrameOfflineText:Hide();
	elseif UnitIsPlayer("focus") and not UnitIsConnected("focus") then
		FocusFrameGhostText:Hide();
		FocusFrameOfflineText:Show();
	else
		FocusFrameGhostText:Hide();
		FocusFrameOfflineText:Hide();
	end
	if UnitExists("focus") and UnitIsDead("focus") or UnitIsGhost("focus") or not UnitIsConnected("focus") then
		for i, v in pairs({	FocusFrameTextureFrameHealthBarText, FocusFrameTextureFrameManaBarText, FocusFrameHealthBar.LeftText, FocusFrameHealthBar.RightText, FocusFrameManaBar.LeftText, FocusFrameManaBar.RightText, FocusFrameTextureFrameManaBarText, FocusFrameManaBar }) do v:SetAlpha(0); end
	else
		for i, v in pairs({	FocusFrameTextureFrameHealthBarText, FocusFrameTextureFrameManaBarText, FocusFrameHealthBar.LeftText, FocusFrameHealthBar.RightText, FocusFrameManaBar.LeftText, FocusFrameManaBar.RightText, FocusFrameTextureFrameManaBarText, FocusFrameManaBar }) do v:SetAlpha(1); end
	end
end

--	Check dead events.
local whoaFrameUpdate = CreateFrame("Frame")
whoaFrameUpdate:RegisterEvent("PLAYER_ENTERING_WORLD");
whoaFrameUpdate:RegisterEvent("PLAYER_TARGET_CHANGED");
whoaFrameUpdate:RegisterEvent("PLAYER_FOCUS_CHANGED");
whoaFrameUpdate:RegisterEvent("PLAYER_DEAD")
whoaFrameUpdate:RegisterEvent("PLAYER_UNGHOST")
whoaFrameUpdate:RegisterEvent("PLAYER_ALIVE")
whoaFrameUpdate:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
whoaFrameUpdate:RegisterEvent("PLAYER_ENTER_COMBAT")
whoaFrameUpdate:RegisterEvent("ADDON_LOADED")
whoaFrameUpdate:RegisterEvent("PLAYER_LOGIN")
whoaFrameUpdate:RegisterEvent("PARTY_MEMBER_DISABLE")
whoaFrameUpdate:SetScript('OnEvent', function(self, event, ...)
	if (event == "PLAYER_LOGIN") then
		createDeadTextFrames()
	elseif (event == "PLAYER_ENTERING_WORLD") then
		playerDeadCheck()
		--for i, v in pairs({	PlayerFrame, PetFrame, TargetFrame, FocusFrame }) do v:SetMouseClickEnabled(false); end
		--for i, v in pairs({	PlayerFrame, PetFrame, TargetFrame, FocusFrame }) do v:SetMouseClickEnabled(true); end
	elseif (event == "PLAYER_TARGET_CHANGED") then
		whoaUnitTarget()
		targetDeadCheck()
		focusDeadCheck()
	elseif (event == "PLAYER_FOCUS_CHANGED") then
		whoaUnitTarget()
		targetDeadCheck()
		focusDeadCheck()
	elseif (event == "PLAYER_DEAD") then
		playerDeadCheck()
		targetDeadCheck()
		focusDeadCheck()
	elseif (event == "PLAYER_UNGHOST") then
		playerDeadCheck()
		targetDeadCheck()
		focusDeadCheck()
	elseif (event == "PLAYER_ALIVE") then
		playerDeadCheck()
		targetDeadCheck()
		focusDeadCheck()
	elseif (event == "PARTY_MEMBER_DISABLE") then
		targetDeadCheck()
		focusDeadCheck()
	end
end)


---------------------------------------------------------------------------------	Aura positioning constants.
local LARGE_AURA_SIZE, SMALL_AURA_SIZE, AURA_START_X, AURA_START_Y, AURA_OFFSET_Y, AURA_ROW_WIDTH, NUM_TOT_AURA_ROWS = 26, 21, 3, 26, 1, 121, 3   -- Set aura size.
function whoaUpdateAuraPositions(self, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX, mirrorAurasVertically)
	local offsetY = AURA_OFFSET_Y;
	local rowWidth = 0;
	local firstBuffOnRow = 1;
	for i=1, numAuras do
		if ( largeAuraList[i] ) then
			size = LARGE_AURA_SIZE;
			offsetY = AURA_OFFSET_Y + AURA_OFFSET_Y;
		else
			size = SMALL_AURA_SIZE;
		end
		if ( i == 1 ) then
			rowWidth = size;
			self.auraRows = self.auraRows + 1;
		else
			rowWidth = rowWidth + size + offsetX;
		end
		if ( rowWidth > maxRowWidth ) then
			updateFunc(self, auraName, i, numOppositeAuras, firstBuffOnRow, size, offsetX, offsetY, mirrorAurasVertically);
			rowWidth = size;
			self.auraRows = self.auraRows + 1;
			firstBuffOnRow = i;
			offsetY = AURA_OFFSET_Y;
			if ( self.auraRows > NUM_TOT_AURA_ROWS ) then
				maxRowWidth = AURA_ROW_WIDTH;
			end
		else
			updateFunc(self, auraName, i, numOppositeAuras, i - 1, size, offsetX, offsetY, mirrorAurasVertically);
		end
	end
end
hooksecurefunc("TargetFrame_UpdateAuraPositions", whoaUpdateAuraPositions)
function UpdateBuffAnchor(self, buffName, index, numDebuffs, anchorIndex, size, offsetX, offsetY, mirrorVertically)
	local point, relativePoint;
	local startY, auraOffsetY;
	if ( mirrorVertically ) then
		point = "BOTTOM";
		relativePoint = "TOP";
		startY = -5;
		if ( self.threatNumericIndicator:IsShown() ) then
			startY = startY + self.threatNumericIndicator:GetHeight();
		end
		offsetY = - offsetY;
		auraOffsetY = -AURA_OFFSET_Y;
	else
		point = "TOP";
		relativePoint="BOTTOM";
		startY = AURA_START_Y - 3;
		auraOffsetY = AURA_OFFSET_Y;
	end
	local buff = _G[buffName..index];
	if ( index == 1 ) then
		if ( UnitIsFriend("player", self.unit) or numDebuffs == 0 ) then
			buff:SetPoint(point.."LEFT", self, relativePoint.."LEFT", AURA_START_X, startY);
		else
			buff:SetPoint(point.."LEFT", self.debuffs, relativePoint.."LEFT", 0, -offsetY);
		end
		self.buffs:SetPoint(point.."LEFT", buff, point.."LEFT", 0, 0);
		self.buffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY);
		self.spellbarAnchor = buff;
	elseif ( anchorIndex ~= (index-1) ) then
		buff:SetPoint(point.."LEFT", _G[buffName..anchorIndex], relativePoint.."LEFT", 0, -offsetY);
		self.buffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY);
		self.spellbarAnchor = buff;
	else
		buff:SetPoint(point.."LEFT", _G[buffName..anchorIndex], point.."RIGHT", offsetX, 0);
	end
	buff:SetWidth(size);
	buff:SetHeight(size);
end
hooksecurefunc("TargetFrame_UpdateBuffAnchor", UpdateBuffAnchor)

function UpdateDebuffAnchor(self, debuffName, index, numBuffs, anchorIndex, size, offsetX, offsetY, mirrorVertically)
	local buff = _G[debuffName..index];
	local isFriend = UnitIsFriend("player", self.unit);
	local point, relativePoint;
	local startY, auraOffsetY;
	if ( mirrorVertically ) then
		point = "BOTTOM";
		relativePoint = "TOP";
		startY = -5;
		if ( self.threatNumericIndicator:IsShown() ) then
			startY = startY + self.threatNumericIndicator:GetHeight();
		end
		offsetY = - offsetY;
		auraOffsetY = -AURA_OFFSET_Y;
	else
		point = "TOP";
		relativePoint="BOTTOM";
		startY = AURA_START_Y - 3;
		auraOffsetY = AURA_OFFSET_Y;
	end
	if ( index == 1 ) then
		if ( isFriend and numBuffs > 0 ) then
			buff:SetPoint(point.."LEFT", self.buffs, relativePoint.."LEFT", 0, -offsetY);
		else
			buff:SetPoint(point.."LEFT", self, relativePoint.."LEFT", AURA_START_X, startY);
		end
		self.debuffs:SetPoint(point.."LEFT", buff, point.."LEFT", 0, 0);
		self.debuffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY);
		if ( ( isFriend ) or ( not isFriend and numBuffs == 0) ) then
			self.spellbarAnchor = buff;
		end
	elseif ( anchorIndex ~= (index-1) ) then
		buff:SetPoint(point.."LEFT", _G[debuffName..anchorIndex], relativePoint.."LEFT", 0, -offsetY);
		self.debuffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY);
		if ( ( isFriend ) or ( not isFriend and numBuffs == 0) ) then
			self.spellbarAnchor = buff;
		end
	else
		buff:SetPoint(point.."LEFT", _G[debuffName..(index-1)], point.."RIGHT", offsetX, 0);
	end
	buff:SetWidth(size);
	buff:SetHeight(size);
	local debuffFrame =_G[debuffName..index.."Border"];
	debuffFrame:SetWidth(size+2);
	debuffFrame:SetHeight(size+2);
end
hooksecurefunc("TargetFrame_UpdateDebuffAnchor", UpdateDebuffAnchor)

-- Target_Spellbar_AdjustPosition = function(self)
function whoaSpellbarAdjustPosition(self)
		local parentFrame = self:GetParent();
		if ( self.boss ) then
			self:SetPoint("TOPLEFT", parentFrame, "BOTTOMLEFT", 25, 10 );
		elseif ( parentFrame.haveToT ) then	-- if have tot.
			if ( parentFrame.buffsOnTop or parentFrame.auraRows <= 1 ) then
				self:SetPoint("TOPLEFT", parentFrame, "BOTTOMLEFT", 25, -21 );
			else
				self:SetPoint("TOPLEFT", parentFrame.spellbarAnchor, "BOTTOMLEFT", 20, -28);
			end
		elseif ( parentFrame.haveElite ) then
			if ( parentFrame.buffsOnTop or parentFrame.auraRows <= 1 ) then
				self:SetPoint("TOPLEFT", parentFrame, "BOTTOMLEFT", 25, -21 );
			else
				self:SetPoint("TOPLEFT", parentFrame.spellbarAnchor, "BOTTOMLEFT", 20, -28);
			end
		else
			if ( (not parentFrame.buffsOnTop) and parentFrame.auraRows > 0 ) then
				self:SetPoint("TOPLEFT", parentFrame.spellbarAnchor, "BOTTOMLEFT", 20, -20);
			else
				self:SetPoint("TOPLEFT", parentFrame, "BOTTOMLEFT", 25, 3 );	-- target no tot
			end
		end
end
hooksecurefunc("Target_Spellbar_AdjustPosition", whoaSpellbarAdjustPosition)
TargetFrameSpellBar:SetScript("OnShow", nil)
FocusFrameSpellBar:SetScript("OnShow", nil)

--	Player frame.
function wPlayerFrame(self)
		for i, v in pairs ({ self.healthbar, self.healthbar.AnimatedLossBar, PlayerFrameAlternateManaBar, }) do
			v:SetStatusBarTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\UFs\\UI-StatusBar");
		end

		for i, v in pairs ({ PlayerFrameMyHealPredictionBar, PlayerFrameManaBar.FeedbackFrame.BarTexture,
			PlayerFrameManaBar.FeedbackFrame.LossGlowTexture, PlayerFrameManaBar.FeedbackFrame.GainGlowTexture }) do
			v:SetTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\UFs\\UI-StatusBar");
		end
	PlayerStatusTexture:ClearAllPoints();
	PlayerStatusTexture:SetPoint("CENTER", PlayerFrame, "CENTER",16, 8);
		PlayerFrameTexture:SetTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\UFs\\UI-TargetingFrame");
		PlayerStatusTexture:SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\Modules\\UFs\\UI-Player-Status");
	PlayerLevelText:ClearAllPoints();
	PlayerLevelText:SetPoint("CENTER", PlayerFrameTexture, "CENTER", 200,0);
	self.name:ClearAllPoints();
	self.name:SetPoint("CENTER", PlayerFrame, "CENTER",50, 36);
	self.healthbar:SetPoint("TOPLEFT",108,-24);
	self.healthbar:SetSize(118,28);
	self.healthbar.LeftText:ClearAllPoints();
	self.healthbar.LeftText:SetPoint("LEFT",self.healthbar,"LEFT",5,0);
	self.healthbar.RightText:ClearAllPoints();
	self.healthbar.RightText:SetPoint("RIGHT",self.healthbar,"RIGHT",0,0);
	self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, 0);
	self.manabar:SetSize(118,8);
	self.manabar:ClearAllPoints();
	self.manabar:SetPoint("TOPLEFT",108,-54);
	self.manabar.LeftText:ClearAllPoints();
	self.manabar.LeftText:SetPoint("LEFT",self.manabar,"LEFT",5,0);
	self.manabar.RightText:ClearAllPoints();
	self.manabar.RightText:SetPoint("RIGHT",self.manabar,"RIGHT",0,0);
	self.manabar.TextString:SetPoint("CENTER",self.manabar,"CENTER",0,0);
	PlayerFrameGroupIndicatorText:ClearAllPoints();
	PlayerFrameGroupIndicatorText:SetPoint("BOTTOMLEFT", PlayerFrame,"TOP",0,-20);
	PlayerFrameGroupIndicatorLeft:Hide();
	PlayerFrameGroupIndicatorMiddle:Hide();
	PlayerFrameGroupIndicatorRight:Hide();
end
hooksecurefunc("PlayerFrame_ToPlayerArt", wPlayerFrame)

function WhoaGroupIndicator()
	local name, rank, subgroup;
	if ( not IsInRaid() ) then
		return;
	end
	local numGroupMembers = GetNumGroupMembers();
	for i=1, MAX_RAID_MEMBERS do
		if ( i <= numGroupMembers ) then
			name, rank, subgroup = GetRaidRosterInfo(i);
			if ( name == UnitName("player") ) then
				PlayerFrameGroupIndicatorText:SetText("G"..subgroup);
				PlayerFrameGroupIndicator:SetWidth(PlayerFrameGroupIndicatorText:GetWidth());-- +40);
				PlayerFrameGroupIndicator:Show();
			end
		end
	end
end
hooksecurefunc("PlayerFrame_UpdateGroupIndicator", WhoaGroupIndicator)

--[[ pet frame.
function whoaPetFrame(self, override)
	self.healthbar.LeftText:ClearAllPoints();
	self.healthbar.LeftText:SetPoint("LEFT",self.healthbar,"BOTTOM",35,5);
	self.healthbar.RightText:ClearAllPoints();
	self.healthbar.RightText:SetPoint("CENTER",self.healthbar,"BOTTOM",0,5);
	self.manabar.LeftText:SetAlpha(0);
	self.manabar.LeftText:ClearAllPoints();
	self.manabar.LeftText:SetPoint("LEFT",self.manabar,"TOP",0,-7);
	self.manabar.RightText:ClearAllPoints();
	self.manabar.RightText:SetPoint("CENTER",self.manabar,"TOP",0,-7);
end
hooksecurefunc("PetFrame_Update", whoaPetFrame)]]

hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function()
		for i = 1, 4 do
		  PetFrameHealthBarText:SetText(" ");
		  PetFrameHealthBarTextLeft:SetText(" ");
		  PetFrameHealthBarTextRight:SetText(" ");
		end
end)

--	Player vehicle frame.
function whoaVehicleFrame(self, vehicleType)
		if ( vehicleType == "Natural" ) then
		PlayerFrameVehicleTexture:SetTexture("Interface\\Vehicles\\UI-Vehicle-Frame-Organic");
		PlayerFrameFlash:SetTexture("Interface\\Vehicles\\UI-Vehicle-Frame-Organic-Flash");
		PlayerFrameFlash:SetTexCoord(-0.02, 1, 0.07, 0.86);
		self.healthbar:SetSize(103,12);
		self.healthbar:SetPoint("TOPLEFT",116,-41);
		self.manabar:SetSize(103,12);
		self.manabar:SetPoint("TOPLEFT",116,-52);
	else
		PlayerFrameVehicleTexture:SetTexture("Interface\\Vehicles\\UI-Vehicle-Frame");
		PlayerFrameFlash:SetTexture("Interface\\Vehicles\\UI-Vehicle-Frame-Flash");
		PlayerFrameFlash:SetTexCoord(-0.02, 1, 0.07, 0.86);
		self.healthbar:SetSize(100,12);
		self.healthbar:SetPoint("TOPLEFT",119,-41);
		self.manabar:SetSize(100,12);
		self.manabar:SetPoint("TOPLEFT",119,-52);
	end
	PlayerName:SetPoint("CENTER",50,23);
	PlayerFrameBackground:SetWidth(114);
end
hooksecurefunc("PlayerFrame_ToVehicleArt", whoaVehicleFrame)

	-- vehicle switch
local whoaStatusFrame = CreateFrame("Frame")
whoaStatusFrame:SetScript('OnEvent', function(self, event, ...)
	local arg1, arg2 = ...;
	if ( event == "UNIT_ENTERED_VEHICLE" ) then
		if ( arg1 == "player" ) then
			if ( arg2 ) then
				doVehicleFrame = true;
			end
		end
	elseif ( event == "UNIT_EXITED_VEHICLE" ) then
		doVehicleFrame = false;
	end
	return doVehicleFrame;
end)

	-- Vehicle color.
whoaStatusFrame:RegisterUnitEvent("PLAYER_ENTERING_WORLD");
whoaStatusFrame:RegisterUnitEvent("UNIT_ENTERED_VEHICLE");
whoaStatusFrame:RegisterUnitEvent("UNIT_EXITED_VEHICLE");
whoaStatusFrame:SetScript('OnUpdate', function(self)
	if (TargetFrameNumericalThreat:IsVisible() or FocusFrameNumericalThreat:IsVisible()) then
		PlayerName:Hide();
	elseif not (TargetFrameNumericalThreat:IsVisible() or FocusFrameNumericalThreat:IsVisible()) then
		PlayerName:Show();
	end
	if ( doVehicleFrame ) then
		PlayerFrameHealthBar:SetStatusBarColor(whoaUnitColor("pet"));
		PetFrameHealthBar:SetStatusBarColor(whoaUnitColor("player"));
	else
		PlayerFrameHealthBar:SetStatusBarColor(whoaUnitColor("player"));
		if UnitExists("pet") then
			PetFrameHealthBar:SetStatusBarColor(whoaUnitColor("pet"));
		end
	end
	TargetFrameHealthBar:SetStatusBarColor(whoaUnitColor("target"));
	FocusFrameHealthBar:SetStatusBarColor(whoaUnitColor("focus"));
	TargetFrameToTHealthBar:SetStatusBarColor(whoaUnitColor("targettarget"));
	FocusFrameToTHealthBar:SetStatusBarColor(whoaUnitColor("focustarget"));
	--	party statusbar
	for i = 1, 4 do
		if i then
			_G["PartyMemberFrame"..i.."HealthBar"]:SetStatusBarColor(whoaUnitColor("party"..i));
		end
	end
	--	boss statusbar
	for i = 1, MAX_BOSS_FRAMES do
		if i then
			_G["Boss"..i.."TargetFrameHealthBar"]:SetStatusBarColor(whoaUnitColor("boss"..i));
		end
	end
end)

--	Target frame
function whoaTargetFrames (self, forceNormalTexture)
	local classification = UnitClassification(self.unit);
	self.highLevelTexture:SetPoint("CENTER", self.levelText, "CENTER", 0,0);
	self.deadText:SetPoint("CENTER", self.healthbar, "CENTER",0,0);
	self.unconsciousText:SetPoint("CENTER", self.healthbar, "CENTER",0,0);
	self.nameBackground:Hide();
	self.threatIndicator:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash");
	self.name:SetPoint("LEFT", self, 15, 36);
	self.healthbar:SetHeight(28);
	self.healthbar:ClearAllPoints();
	self.healthbar:SetPoint("TOPLEFT", 5, -24);
	self.healthbar.LeftText:SetPoint("LEFT", self.healthbar, "LEFT", 5, 0);
	self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, 0);
	self.manabar.LeftText:SetPoint("LEFT", self.manabar, "LEFT", 3, 0);
	self.manabar.RightText:SetPoint("RIGHT", self.manabar, "RIGHT", -3, 0);
	self.manabar.TextString:SetPoint("CENTER", self.manabar, "CENTER", 0, 0);
	TargetFrame.threatNumericIndicator:SetPoint("BOTTOM", PlayerFrame, "TOP", 72, -21);
	FocusFrame.threatNumericIndicator:SetAlpha(0);
	if ( forceNormalTexture ) then
		self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame");
		CreateBarPctText(TargetFrame, "LEFT", "RIGHT", 88, -8, "NumberFontNormalLarge", 36)
	elseif ( classification == "minus" ) then
		self.borderTexture:SetTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\UFs\\UI-TargetingFrame-Minus");
		forceNormalTexture = true;
		CreateBarPctText(TargetFrame, "LEFT", "RIGHT", 66, 0, "NumberFontNormalLarge", 36)
	elseif ( classification == "worldboss" or classification == "elite" ) then
		self.borderTexture:SetTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\UFs\\UI-TargetingFrame-Elite");
		CreateBarPctText(TargetFrame, "LEFT", "RIGHT", 102, -8, "NumberFontNormalLarge", 36)
	elseif ( classification == "rareelite" ) then
		self.borderTexture:SetTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\UFs\\UI-TargetingFrame-Rare-Elite");
		CreateBarPctText(TargetFrame, "LEFT", "RIGHT", 102, -8, "NumberFontNormalLarge", 36)
	elseif ( classification == "rare" ) then
		self.borderTexture:SetTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\UFs\\UI-TargetingFrame-Rare");
		CreateBarPctText(TargetFrame, "LEFT", "RIGHT", 102, -8, "NumberFontNormalLarge", 36)
	else
		self.borderTexture:SetTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\UFs\\UI-TargetingFrame");
		forceNormalTexture = true;
		CreateBarPctText(TargetFrame, "LEFT", "RIGHT", 88, -8, "NumberFontNormalLarge", 36)
	end
		--[[local factionGroup = UnitFactionGroup(self.unit);
		if ( UnitIsPVPFreeForAll(self.unit) ) then
				--self.pvpIcon:SetTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\UFs\\UI-PVP-FFA");
				self.pvpIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
		elseif ( factionGroup and factionGroup ~= "Neutral" and UnitIsPVP(self.unit) ) then
				self.pvpIcon:SetTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\UFs\\UI-PVP-"..factionGroup);
				--self.pvpIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup);
		end]]
	if ( forceNormalTexture ) then
		self.haveElite = nil;
		if ( classification == "minus" ) then
			self.Background:SetSize(119,12);
			self.Background:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 7, 47);
			self.name:SetPoint("LEFT", self, 16, 19);
			self.healthbar:ClearAllPoints();
			self.healthbar:SetPoint("LEFT", 5, 3);
			self.healthbar:SetHeight(12);
			self.healthbar.LeftText:SetPoint("LEFT", self.healthbar, "LEFT", 3, 0);
			self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, "RIGHT", -2, 0);
		else
			self.Background:SetSize(119,42);
			self.Background:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 7, 35);
		end
		if ( self.threatIndicator ) then
			if ( classification == "minus" ) then
				self.threatIndicator:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus-Flash");
				self.threatIndicator:SetTexCoord(0, 1, 0, 1);
				self.threatIndicator:SetWidth(256);
				self.threatIndicator:SetHeight(128);
				self.threatIndicator:SetPoint("TOPLEFT", self, "TOPLEFT", -24, 0);
			else
				self.threatIndicator:SetTexCoord(0, 0.9453125, 0, 0.181640625);
				self.threatIndicator:SetWidth(242);
				self.threatIndicator:SetHeight(93);
				self.threatIndicator:SetPoint("TOPLEFT", self, "TOPLEFT", -24, 0);
			end
		end
	else
		self.haveElite = true;
		self.Background:SetSize(119,42);
		if ( self.threatIndicator ) then
			self.threatIndicator:SetTexCoord(0, 0.9453125, 0.181640625, 0.400390625);
			self.threatIndicator:SetWidth(242);
			self.threatIndicator:SetHeight(112);
		end
	end
	if (self.questIcon) then
		if (UnitIsQuestBoss(self.unit)) then
			self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, "RIGHT", -9, 0);
		else
			self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, "RIGHT", -3, 0);
		end
	end
		self.healthbar:SetStatusBarTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\UFs\\UI-StatusBar");
end
hooksecurefunc("TargetFrame_CheckClassification", whoaTargetFrames)

-- Mana texture
function whoaManaBar (manaBar)
	local powerType, powerToken, altR, altG, altB = UnitPowerType(manaBar.unit);
	local info = PowerBarColor[powerToken];
	if ( info ) then
		if ( not manaBar.lockColor ) then
			if not ( info.atlas ) then
				manaBar:SetStatusBarTexture("Interface\\Addons\\_ShiGuang\\Media\\EnergyTex");
			end
		end
	end
end
hooksecurefunc("UnitFrameManaBar_UpdateType", whoaManaBar)

--	ToT & ToF
function whoaUnitTarget()
	TargetFrameToTTextureFrameDeadText:ClearAllPoints();
	TargetFrameToTTextureFrameDeadText:SetPoint("CENTER", "TargetFrameToTHealthBar","CENTER",1, 0);
	TargetFrameToTTextureFrameName:SetSize(65,10);
	TargetFrameToTTextureFrameTexture:SetTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\UFs\\UI-TargetofTargetFrame");
	TargetFrameToTHealthBar:ClearAllPoints();
	TargetFrameToTHealthBar:SetPoint("TOPLEFT", 45, -15);
	TargetFrameToTHealthBar:SetHeight(10);
	TargetFrameToTManaBar:ClearAllPoints();
	TargetFrameToTManaBar:SetPoint("TOPLEFT", 45, -25);
	TargetFrameToTManaBar:SetHeight(5);
	FocusFrameToTTextureFrameDeadText:ClearAllPoints();
	FocusFrameToTTextureFrameDeadText:SetPoint("CENTER", "FocusFrameToTHealthBar" ,"CENTER",1, 0);
	FocusFrameToTTextureFrameName:SetSize(65,10);
	FocusFrameToTTextureFrameTexture:SetTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\UFs\\UI-TargetofTargetFrame");
	FocusFrameToTHealthBar:ClearAllPoints();
	FocusFrameToTHealthBar:SetPoint("TOPLEFT", 43, -15);
	FocusFrameToTHealthBar:SetHeight(10);
	FocusFrameToTManaBar:ClearAllPoints();
	FocusFrameToTManaBar:SetPoint("TOPLEFT", 43, -25);
	FocusFrameToTManaBar:SetHeight(5);
end
-- hooksecurefunc("TargetFrame_CheckClassification", whoaFrameToTF)

--	Party Frames.
--	Boss target frames taints
--[[local whoaPartyFrames = CreateFrame("Frame")
whoaPartyFrames:RegisterEvent("PLAYER_LOGIN")
whoaPartyFrames:RegisterEvent("PLAYER_ENTERING_WORLD")
whoaPartyFrames:SetScript('OnUpdate', function(self)
	local useCompact = GetCVarBool("useCompactPartyFrames");
	if (cfg.usePartyFrames) and (not useCompact) then
		for i = 1, 4 do
				_G["PartyMemberFrame"..i.."HealthBar"]:SetStatusBarTexture("Interface\\Addons\\_ShiGuang\\Media\\EnergyTex);
				_G["PartyMemberFrame"..i.."HealthBar"]:SetStatusBarTexture("Interface\\Addons\\_ShiGuang\\Media\\EnergyTex);
			_G["PartyMemberFrame"..i.."Name"]:SetSize(80,12);
			_G["PartyMemberFrame"..i.."Name"]:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
			_G["PartyMemberFrame"..i.."Texture"]:SetTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\UFs\\UI-PartyFrame");
			_G["PartyMemberFrame"..i.."Flash"]:SetTexture("Interface\\Addons\\_ShiGuang\\Media\\Modules\\UFs\\UI-PARTYFRAME-FLASH");
			_G["PartyMemberFrame"..i.."HealthBar"]:ClearAllPoints();
			_G["PartyMemberFrame"..i.."HealthBar"]:SetPoint("TOPLEFT", 45, -13);
			_G["PartyMemberFrame"..i.."HealthBar"]:SetHeight(12);
			_G["PartyMemberFrame"..i.."ManaBar"]:ClearAllPoints();
			_G["PartyMemberFrame"..i.."ManaBar"]:SetPoint("TOPLEFT", 45, -26);
			_G["PartyMemberFrame"..i.."ManaBar"]:SetHeight(5);
			_G["PartyMemberFrame"..i.."HealthBarTextLeft"]:ClearAllPoints();
			_G["PartyMemberFrame"..i.."HealthBarTextLeft"]:SetPoint("LEFT", _G["PartyMemberFrame"..i.."HealthBar"], "LEFT", 0, 0);
			_G["PartyMemberFrame"..i.."HealthBarTextRight"]:ClearAllPoints();
			_G["PartyMemberFrame"..i.."HealthBarTextRight"]:SetPoint("RIGHT", _G["PartyMemberFrame"..i.."HealthBar"], "RIGHT", 0, 0);
			_G["PartyMemberFrame"..i.."ManaBarTextLeft"]:ClearAllPoints();
			_G["PartyMemberFrame"..i.."ManaBarTextLeft"]:SetPoint("LEFT", _G["PartyMemberFrame"..i.."ManaBar"], "LEFT", 0, 0);
			_G["PartyMemberFrame"..i.."ManaBarTextRight"]:ClearAllPoints();
			_G["PartyMemberFrame"..i.."ManaBarTextRight"]:SetPoint("RIGHT", _G["PartyMemberFrame"..i.."ManaBar"], "RIGHT", 0, 0);
			_G["PartyMemberFrame"..i.."HealthBarText"]:ClearAllPoints();
			_G["PartyMemberFrame"..i.."HealthBarText"]:SetPoint("LEFT", _G["PartyMemberFrame"..i.."HealthBar"], "RIGHT", 0, 0);
			_G["PartyMemberFrame"..i.."ManaBarText"]:ClearAllPoints();
			_G["PartyMemberFrame"..i.."ManaBarText"]:SetPoint("LEFT", _G["PartyMemberFrame"..i.."ManaBar"], "RIGHT", 0, 0);
			_G["PartyMemberFrame"..i.."ManaBarText"]:Hide();
			_G["PartyMemberFrame"..i.."ManaBarTextLeft"]:Hide();
			_G["PartyMemberFrame"..i.."ManaBarTextRight"]:Hide();
		end
	end
end)

	--	Boss target frames taints
local whoaBossFrame = CreateFrame("Frame")
whoaBossFrame:RegisterEvent("PLAYER_LOGIN")
whoaBossFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
whoaBossFrame:SetScript('OnUpdate', function(self)
		for i = 1, MAX_BOSS_FRAMES do
			if _G["Boss"..i.."TargetFrame"] then
				_G["Boss"..i.."TargetFrameTextureFrameDeadText"]:ClearAllPoints();
				_G["Boss"..i.."TargetFrameTextureFrameDeadText"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrameHealthBar"],"CENTER",0,0);
				_G["Boss"..i.."TargetFrameTextureFrameName"]:ClearAllPoints();
				_G["Boss"..i.."TargetFrameTextureFrameName"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrame"],"CENTER",-57,-23);
				_G["Boss"..i.."TargetFrameTextureFrameTexture"]:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\UI-UNITFRAME-BOSS");
				_G["Boss"..i.."TargetFrameNameBackground"]:Hide();
				_G["Boss"..i.."TargetFrameHealthBar"]:SetStatusBarColor(whoaUnitColor("boss"..i));
				_G["Boss"..i.."TargetFrameHealthBar"]:SetSize(116,30);
				_G["Boss"..i.."TargetFrameHealthBar"]:ClearAllPoints();
				_G["Boss"..i.."TargetFrameHealthBar"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrame"],"CENTER",-51,13);
				_G["Boss"..i.."TargetFrameManaBar"]:SetSize(116,10);
				_G["Boss"..i.."TargetFrameManaBar"]:ClearAllPoints();
				_G["Boss"..i.."TargetFrameManaBar"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrame"],"CENTER",-51,-10);
				_G["Boss"..i.."TargetFrameTextureFrameUnconsciousText"]:ClearAllPoints();
				_G["Boss"..i.."TargetFrameTextureFrameUnconsciousText"]:SetPoint("CENTER", _G["Boss"..i.."TargetFrameHealthBar"], "CENTER",0,0);
				_G["Boss"..i.."TargetFrameTextureFrameHealthBarTextLeft"]:ClearAllPoints();
				_G["Boss"..i.."TargetFrameTextureFrameHealthBarTextLeft"]:SetPoint("LEFT",_G["Boss"..i.."TargetFrameHealthBar"],"LEFT",2,0);
				_G["Boss"..i.."TargetFrameTextureFrameHealthBarTextRight"]:ClearAllPoints();
				_G["Boss"..i.."TargetFrameTextureFrameHealthBarTextRight"]:SetPoint("RIGHT",_G["Boss"..i.."TargetFrameHealthBar"],"RIGHT",0,0);
				_G["Boss"..i.."TargetFrameTextureFrameHealthBarText"]:ClearAllPoints();
				_G["Boss"..i.."TargetFrameTextureFrameHealthBarText"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrameHealthBar"],"CENTER",0,0);
				_G["Boss"..i.."TargetFrameTextureFrameManaBarTextLeft"]:Hide();
				_G["Boss"..i.."TargetFrameTextureFrameManaBarTextLeft"]:SetPoint("LEFT",_G["Boss"..i.."TargetFrameManaBar"],"LEFT",0,0);
				_G["Boss"..i.."TargetFrameTextureFrameManaBarTextRight"]:Hide();
				_G["Boss"..i.."TargetFrameTextureFrameManaBarTextRight"]:SetPoint("RIGHT",_G["Boss"..i.."TargetFrameManaBar"],"RIGHT",0,0);
				_G["Boss"..i.."TargetFrameTextureFrameManaBarText"]:Hide();
				_G["Boss"..i.."TargetFrameTextureFrameManaBarText"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrameManaBar"],"CENTER",0,0);
				_G["Boss"..i.."TargetFrameTextureFrameManaBarTextLeft"]:Hide();
				_G["Boss"..i.."TargetFrameTextureFrameManaBarTextRight"]:Hide();
				_G["Boss"..i.."TargetFrameTextureFrameManaBarText"]:Hide();
			end
		end
end)





	--	Boss target frames
local whoaBossFrame = CreateFrame("Frame")
whoaBossFrame:RegisterEvent("PLAYER_LOGIN")
whoaBossFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
whoaBossFrame:SetScript('OnUpdate', function(self)
		for i = 1, MAX_BOSS_FRAMES do
			if i then
				_G["Boss"..i.."TargetFrameTextureFrameDeadText"]:ClearAllPoints();
				_G["Boss"..i.."TargetFrameTextureFrameDeadText"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrameHealthBar"],"CENTER",0,0);
				_G["Boss"..i.."TargetFrameTextureFrameUnconsciousText"]:ClearAllPoints();
				_G["Boss"..i.."TargetFrameTextureFrameUnconsciousText"]:SetPoint("CENTER", _G["Boss"..i.."TargetFrameHealthBar"], "CENTER",0,0);
				_G["Boss"..i.."TargetFrameTextureFrameName"]:ClearAllPoints();
				_G["Boss"..i.."TargetFrameTextureFrameName"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrame"],"CENTER",-57,-23);
				_G["Boss"..i.."TargetFrameTextureFrameTexture"]:SetTexture("Interface\\Addons\\whoaUnitFrames\\media\\UI-UNITFRAME-BOSS");
				_G["Boss"..i.."TargetFrameNameBackground"]:SetAlpha(0);
				_G["Boss"..i.."TargetFrameHealthBar"]:SetSize(116,20);
				_G["Boss"..i.."TargetFrameHealthBar"]:ClearAllPoints();
				_G["Boss"..i.."TargetFrameHealthBar"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrame"],"CENTER",-51,18);
				_G["Boss"..i.."TargetFrameManaBar"]:SetSize(116,18);
				_G["Boss"..i.."TargetFrameManaBar"]:ClearAllPoints();
				_G["Boss"..i.."TargetFrameManaBar"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrame"],"CENTER",-51,-3);
				_G["Boss"..i.."TargetFrameTextureFrameHealthBarTextLeft"]:ClearAllPoints();
				_G["Boss"..i.."TargetFrameTextureFrameHealthBarTextLeft"]:SetPoint("LEFT",_G["Boss"..i.."TargetFrameHealthBar"],"LEFT",0,0);
				_G["Boss"..i.."TargetFrameTextureFrameHealthBarTextRight"]:ClearAllPoints();
				_G["Boss"..i.."TargetFrameTextureFrameHealthBarTextRight"]:SetPoint("RIGHT",_G["Boss"..i.."TargetFrameHealthBar"],"RIGHT",0,0);
				_G["Boss"..i.."TargetFrameTextureFrameHealthBarText"]:ClearAllPoints();
				_G["Boss"..i.."TargetFrameTextureFrameHealthBarText"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrameHealthBar"],"CENTER",0,0);
				_G["Boss"..i.."TargetFrameTextureFrameManaBarTextLeft"]:Hide();
				_G["Boss"..i.."TargetFrameTextureFrameManaBarTextLeft"]:SetPoint("LEFT",_G["Boss"..i.."TargetFrameManaBar"],"LEFT",0,0);
				_G["Boss"..i.."TargetFrameTextureFrameManaBarTextRight"]:Hide();
				_G["Boss"..i.."TargetFrameTextureFrameManaBarTextRight"]:SetPoint("RIGHT",_G["Boss"..i.."TargetFrameManaBar"],"RIGHT",0,0);
				_G["Boss"..i.."TargetFrameTextureFrameManaBarText"]:Hide();
				_G["Boss"..i.."TargetFrameTextureFrameManaBarText"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrameManaBar"],"CENTER",0,0);
				_G["Boss"..i.."TargetFrameTextureFrameTexture"]:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\UI-UNITFRAME-BOSS");
			end
		end
end)]]