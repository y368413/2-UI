local _, ns = ...
local M, R, U, I = unpack(ns)
--------------Thanks  nj55top`s iFrame
local colorbyclass = true									-- 血条按职业着色
local showPlayerSpeed = true								-- 显示玩家移动速度
local showTargetSpeed = true								-- 显示目标移动速度
local barMult = 1
local FONT_STRING = "Interface\\addons\\_ShiGuang\\Media\\Fonts\\Pixel.TTF"
local barTexture = "Interface\\Addons\\_ShiGuang\\Media\\Modules\\UFs\\UI-StatusBar" -- 状态条材质
local updateElapsed, lastPlayerSpeed, lastTargetSpeed
local function textUpdate(bar)
	if bar then													-- Party Pet frames don't have a mana bar.
		local textType = GetCVar("statusTextDisplay")
		local frame = bar.unitFrame
		if not frame or not frame.addPctText then return end
		local value = bar:GetValue()
		local min, max = bar:GetMinMaxValues()
		if bar.pctText then
			if textType ~= "NUMERIC" then
				bar.pctText:SetText("")
			elseif value == 0 then
				bar.pctText:SetText((bar.DeadText or bar.TextString) and "" or DEAD)
			else
				bar.pctText:SetText(tostring(math.ceil((value / max) * 100)))
				if not R.db["UFs"]["UFPctText"] or value == max then bar.pctText:Hide()
		elseif GetCVarBool("statusTextPercentage") and ( bar.unit == PlayerFrame.unit or bar.unit == "target" or bar.unit == "focus" ) then bar.pctText:Hide()
		else bar.pctText:Show()
		end
		--if max > min then value = (value - min) / (max - min) else value = 0 end
		if value > 0.5 then r, g, b = 2*(1-value), 1, 0 else r, g, b = 1, 2*value, 0 end
		bar.pctText:SetTextColor(r, g, b)
			end
		end
		if bar.TextString and textType == "NUMERIC" and value > 0 then
			if bar.capNumericDisplay then
				value = AbbreviateLargeNumbers(value)
			else
				value = BreakUpLargeNumbers(value)
			end
			bar.TextString:SetText(value)
		end
	end
end

local function getHealthbarColor(unit)
	local color = {r=0.17, g=1.0, b=0.5}
	if (not unit) then return color end
	if ((UnitIsPlayer(unit) or unit == "pet")) and UnitClass(unit) then
		color = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
	else
		color.r, color.g, color.b = UnitSelectionColor(unit)
	end

	if UnitCanAttack(unit, "player") then
		if ( not UnitPlayerControlled(unit) and UnitIsTapDenied(unit) ) then
			color.r, color.g, color.b = 0.5 * barMult, 0.5 * barMult, 0.5 * barMult
		end
	end
	return color
end

local function colorHPBar(bar, unit)
	if bar and not bar.lockValues and unit == bar.unit then
		local r, g, b
		local min, max = bar:GetMinMaxValues()
		local value = bar:GetValue()
		if max > min then
			value = (value - min) / (max - min)
		else
			value = 0
		end
		if value > 0.5 then
			r, g, b = 2*(1-value), 1, 0
		else
			r, g, b = 1, 2*value, 0
		end
		if bar.pctText then bar.pctText:SetTextColor(r, g, b) end
		if colorbyclass then
			local color = getHealthbarColor(unit)
			bar:SetStatusBarColor(color.r * barMult, color.g * barMult, color.b * barMult)
			bar:SetStatusBarDesaturated(true)
		end
	end
end
hooksecurefunc("UnitFrameHealthBar_OnUpdate", textUpdate)
hooksecurefunc("UnitFrameManaBar_OnUpdate", textUpdate)
hooksecurefunc("UnitFrameManaBar_Update", textUpdate)
hooksecurefunc("UnitFrameHealthBar_Update", colorHPBar)
hooksecurefunc("HealthBar_OnValueChanged", function(self) colorHPBar(self, self.unit) end)
hooksecurefunc("UnitFrame_Update", function(self)
	if self.name and self.unit then
		local color = UnitIsPlayer(self.unit) and RAID_CLASS_COLORS[select(2, UnitClass(self.unit))] or NORMAL_FONT_COLOR
		--self.name:SetTextColor(color.r, color.g, color.b)
	if self.name then
	    if UnitIsPlayer(self.unit) then 
		   self.name:SetTextColor(color.r, color.g, color.b)
		elseif UnitIsEnemy("player", "target") then 
		   self.name:SetTextColor(1,0,0) 
		elseif UnitIsFriend("player", "target") then 
		   self.name:SetTextColor(0,1,0)  
		else
		   self.name:SetTextColor(1,1,0) 
	end
	end
	end
end)

function CreateBarPctText(frame, ap, rp, x, y, fontsize)
	local bar = frame.healthbar 
	if bar then
		if bar.pctText then
			bar.pctText:ClearAllPoints()
			bar.pctText:SetPoint(ap, bar, rp, x, y)
		else
			bar.pctText = frame:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
			bar.pctText:SetPoint(ap, bar, rp, x, y)
			bar.pctText:SetTextHeight(21) --height or 21
		bar.pctText:SetFont(FONT_STRING, fontsize, "OUTLINE")
			--bar.pctText:SetShadowColor(0, 0, 0)
			frame.addPctText = true
		end
	end
end

--## Version: 1.0.110005 ## Author: Fusselchen
TargetFrame:HookScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_TARGET_CHANGED" and UnitExists("target") then
        -- Boss frame pieces (dragon frame, icons)
        local bossPortraitFrameTexture = self.TargetFrameContainer.BossPortraitFrameTexture;
        -- https://github.com/tomrus88/BlizzardInterfaceCode/blob/master/Interface/FrameXML/TargetFrame.lua
        if UnitClassification(self.unit) == "rare" then
            bossPortraitFrameTexture:SetAtlas("ui-hud-unitframe-target-portraiton-boss-rare-silver", TextureKitConstants.UseAtlasSize);
            bossPortraitFrameTexture:SetPoint("TOPRIGHT", -11, -8);
            bossPortraitFrameTexture:Show();
        end
    end
end)

--------------------------- Frames ----------------------------
CreateBarPctText(PlayerFrame, "RIGHT", "LEFT", -66, -3, 36)  --"LEFT", "RIGHT", 4, 0, 14
PlayerName:SetTextHeight(12)  --:Hide()
--PlayerName:SetFont(FONT_STRING, 14, "OUTLINE")	--玩家及目标名字字体，大小
CreateBarPctText(PetFrame, "RIGHT", "LEFT", -36, 0, 26)
PetName:SetTextHeight(12)
PetName:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE") ----宠物名字文字大小
PetFrameHealthBarText:SetTextHeight(9)
PetFrameManaBarText:SetTextHeight(9)
CreateBarPctText(TargetFrame, "LEFT", "RIGHT", 66, -3, 36)  --"RIGHT", "LEFT", -4, 0, 14
TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetTextHeight(13)
TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
TargetFrame.TargetFrameContent.TargetFrameContentContextual.NumericalThreat.text:SetTextHeight(10)
CreateBarPctText(TargetFrameToT, "BOTTOMRIGHT", "TOPRIGHT", 0, 16, 26)
TargetFrameToT.Name:SetTextHeight(12)
CreateBarPctText(FocusFrame, "LEFT", "RIGHT", 60, 0, 26)
CreateBarPctText(FocusFrameToT, "BOTTOMRIGHT", "TOPRIGHT", 0, 15, 16)

--[[for i = 1, MAX_BOSS_FRAMES do
	local bossFrame = _G["Boss"..i.."TargetFrame"]
	CreateBarPctText(bossFrame, "BOTTOMLEFT", "TOPRIGHT", 17, 17, 14)
	bossFrame.TargetFrameContent.TargetFrameContentContextual.NumericalThreat.text:SetTextHeight(10)
end]]

-- Binding Variables
BINDING_NAME_TARGETCLASSBUTTON_INSPECT = INSPECT
BINDING_NAME_TARGETCLASSBUTTON_TRADE = TRADE
BINDING_NAME_TARGETCLASSBUTTON_WHISPER = WHISPER
BINDING_NAME_TARGETCLASSBUTTON_FOLLOW = FOLLOW
BINDING_NAME_TARGETCLASSBUTTON_COMPARE_ACHIEVEMENTS = COMPARE_ACHIEVEMENTS

function CreateClassIcon(parent, scale, ap, rp, x, y)
	local icon = CreateFrame("Button", nil, parent)
	icon:Hide()
	icon:SetWidth(26*scale)
	icon:SetHeight(26*scale)
	icon:SetFrameLevel(parent:GetFrameLevel()+3)
	icon:SetPoint(ap, parent, rp, x, y)
	icon.tex = icon:CreateTexture(nil, "BACKGROUND")
	icon.tex:SetWidth(20*scale)
	icon.tex:SetHeight(20*scale)
	icon.tex:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
	icon.tex:SetPoint("CENTER")
	icon.lay = icon:CreateTexture(nil, "OVERLAY")
	icon.lay:SetWidth(36*scale)
	icon.lay:SetHeight(36*scale)
	icon.lay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	icon.lay:SetPoint("TOPLEFT")
	return icon
end
TargetFrame.icon = CreateClassIcon(TargetFrame, 1, "TOPRIGHT", "TOPRIGHT", -72, -16)
TargetFrame.icon:SetScript("OnMouseDown", function(self, button)
	--if InCombatLockdown() then return end
	--if IsAltKeyDown() then InitiateTrade("target") else InspectUnit("target") end 
	if (not UnitCanAttack("player","target") and UnitIsPlayer("target")) then
		if button == "LeftButton" then
			InspectUnit("target")
		elseif button == "RightButton" then
			if CheckInteractDistance("target",2) then InitiateTrade("target") end
		elseif button == "MiddleButton" then  --	StartDuel("target")
				local server = nil;
				local name, server = UnitName("target");
				local fullname = name;			
				if ( server and (not "target" or UnitRealmRelationship("target") ~= LE_REALM_RELATION_SAME) ) then
					fullname = name.."-"..server;
				end
				ChatFrame_SendTell(fullname)
		elseif button == "Button4" then
			if CheckInteractDistance("target",4) then FollowUnit("target", 1); end
		else
			if CheckInteractDistance("target",1) then InspectAchievements("target") end
		end
	end
end)
--TargetFrame.type = TargetFrame:CreateFontString(nil, "OVERLAY", "ReputationDetailFont")
--TargetFrame.type:SetPoint("BOTTOM", TargetFrame.icon, "TOP")
--TargetFrame.type:SetFont(FONT_STRING, 12, "OUTLINE") ----目标类型名字文字大小
hooksecurefunc(TargetFrame, "Update", function(self)
	if not UnitExists(self.unit) then return end
	--local type, color
	if UnitIsPlayer(self.unit) then
		if self.icon then
			local coord = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
			self.icon.tex:SetTexCoord(unpack(coord))
			self.icon:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
			self.icon:Show()
		end
		--type = UnitRace(self.unit)
		--if UnitFactionGroup(self.unit) == UnitFactionGroup("player") then
			--color = GREEN_FONT_COLOR
		--else
			--color = RED_FONT_COLOR
		--end
	else
		if self.icon then self.icon:Hide() end
		--type = UnitCreatureType(self.unit) or ""
		--if UnitCanAttack(self.unit, "player") then
			--color = UnitPlayerControlled(self.unit) and ORANGE_FONT_COLOR or YELLOW_FONT_COLOR
		--else
			--color = HIGHLIGHT_FONT_COLOR
		--end
	end
	--if self.type then
		--self.type:SetText(type)
		--self.type:SetTextColor(color.r, color.g, color.b)
	--end
	TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar:SetStatusBarTexture(barTexture)
end)

-- 目标的目标
--CreateBarPctText(TargetFrameToT, "BOTTOMRIGHT", "TOPRIGHT", 0, 16)
--TargetFrameToT.Name:SetTextHeight(12)
--TargetFrameToT.Name:SetFont(FONT_STRING, 10, "OUTLINE")

-- 焦点
--CreateBarPctText(FocusFrame, "RIGHT", "LEFT", 0, 0, 13)
--CreateBarPctText(FocusFrameToT, "BOTTOMRIGHT", "TOPRIGHT", 0, 15)
--FocusFrame.TargetFrameContent.TargetFrameContentMain.Name:SetFont(FONT_STRING, 12, "OUTLINE")

	-- 能量条改变背景
    hooksecurefunc("UnitFrameManaBar_UpdateType", function(self, manaBar)
        if self.unit then
            self:SetStatusBarTexture("Interface\\Addons\\_ShiGuang\\Media\\EnergyTex") 
            local powerType, powerToken, altR, altG, altB = UnitPowerType(self.unit);
            if (powerToken) then
                local color = PowerBarColor[powerToken];
				if (color) then
                	self:SetStatusBarColor(color.r * barMult, color.g * barMult, color.b * barMult)
				end
            end
        end
    end)

local function GetSpeedText(speed)
	local text = ""
	if speed and speed > 0 then
		text = format("|cffffff00%d%%|r", speed * 100 / 7 + 0.5)
	end
	return text
end

local iFrame = CreateFrame("Frame")
iFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
iFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
iFrame:SetScript("OnEvent", function(self, event, ...)
	--if event == "PLAYER_TARGET_CHANGED" then
		--hasTarget = UnitExists("target") and not UnitIsUnit("vehicle", "target")
	--end
	if event == "PLAYER_ENTERING_WORLD" then
		PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarsContainer.HealthBar:SetStatusBarTexture(barTexture)
		--PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.ManaBar:SetStatusBarTexture(barTexture) 
		TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar:SetStatusBarTexture(barTexture)
		-- TargetFrame.TargetFrameContent.TargetFrameContentMain.ManaBarsContainer.ManaBar:SetStatusBarTexture(barTexture)
		FocusFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar:SetStatusBarTexture(barTexture)
		--FocusFrame.TargetFrameContent.TargetFrameContentMain.ManaBar:SetStatusBarTexture(barTexture) 
		TargetFrameToT.HealthBar:SetStatusBarTexture(barTexture) 
		--TargetFrameToT.ManaBar:SetStatusBarTexture(barTexture) 
		PetFrameHealthBar:SetStatusBarTexture(barTexture)
		FocusFrameToT.HealthBar:SetStatusBarTexture(barTexture) 
	end
end)

PlayerFrame.speed = PlayerFrame:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
PlayerFrame.speed:SetPoint("LEFT", PlayerFrame, "BOTTOMLEFT", 40, 14)
TargetFrame.speed = TargetFrame:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
TargetFrame.speed:SetPoint("RIGHT", TargetFrame, "BOTTOMRIGHT", -34, 14)

iFrame:SetScript("OnUpdate", function(self, elapsed)
	updateElapsed = (updateElapsed or 0) + elapsed
	if updateElapsed > TOOLTIP_UPDATE_TIME then
		updateElapsed = 0
		if showPlayerSpeed then
			local isGliding, canGlide, forwardSpeed = C_PlayerInfo.GetGlidingInfo()
			local playerSpeed = isGliding and forwardSpeed or GetUnitSpeed(PlayerFrame.unit)
			if lastPlayerSpeed ~= playerSpeed then
				lastPlayerSpeed = playerSpeed
				PlayerFrame.speed:SetText(GetSpeedText(playerSpeed))
			end
		end
		if showTargetSpeed then
			local targetSpeed = (UnitExists("target") and not UnitIsUnit("vehicle", "target")) and GetUnitSpeed("target") or nil
			if lastTargetSpeed ~= targetSpeed then
				lastTargetSpeed = targetSpeed
				TargetFrame.speed:SetText(GetSpeedText(targetSpeed))
			end
		end
	end
end)

------------------------------------------Class icon---------------------------------------
hooksecurefunc("UnitFramePortrait_Update",function(self) 
   if not R.db["UFs"]["UFClassIcon"] then return end
        if self.portrait then 
                if UnitIsPlayer(self.unit) then                 
                        if CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))] then 
                                self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles") 
                                self.portrait:SetTexCoord(unpack(CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))])) 
                        end 
                else 
                        self.portrait:SetTexCoord(0,1,0,1) 
                end 
        end 
end)

-----------------------------------------	     隐藏头像动态伤害      -----------------------------------------
--PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HitIndicator:Hide()
--PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HitIndicator:Hide()
PlayerFrame:UnregisterEvent("UNIT_COMBAT") PetFrame:UnregisterEvent("UNIT_COMBAT")