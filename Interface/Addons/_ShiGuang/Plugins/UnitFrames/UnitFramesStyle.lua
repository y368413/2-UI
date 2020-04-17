hooksecurefunc("UnitFrame_Update", function(self)
	if self.name and self.unit then
		local color = RAID_CLASS_COLORS[select(2, UnitClass(self.unit))] or NORMAL_FONT_COLOR
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
		--if string.len(self:GetName()) == 16 and string.find(self:GetName(), "PartyMemberFrame") then
			--self.name:SetText(GetUnitName(self.unit))							-- 不显示队友姓名中的服务器名
		--end
	end
end)
------------------------------------------Class icon---------------------------------------
hooksecurefunc("UnitFramePortrait_Update",function(self) 
   if not MaoRUIPerDB["UFs"]["UFClassIcon"] then return end
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
local p=PlayerHitIndicator;p.Show=p.Hide;p:Hide() 
local p=PetHitIndicator;p.Show=p.Hide;p:Hide() 

--[[-----------------------------	  目标种族、职业和其它信息   ----------------------------------------
TargetFrame:CreateFontString("TargetFrameType", "OVERLAY", "GameFontNormalSmall")
TargetFrameType:SetPoint("BOTTOMRIGHT", TargetFrame, "BOTTOMRIGHT", -43, -8)
TargetFrameType:SetTextColor(1, 0.75, 0)
TargetFrame:CreateFontString("TargetFrameRace", "OVERLAY", "GameFontNormalSmall")
TargetFrameRace:SetPoint("BOTTOMRIGHT", TargetFrame, "BOTTOMRIGHT", -43, 3)
TargetFrameRace:SetTextColor(1, 0.75, 0)
hooksecurefunc("TargetFrame_Update", function(self)
  if not UnitExists(self.unit) then return end
	local typeText = ""
	local raceText = ""
    --self.nameBackground:SetAlpha(UnitIsPlayer(unit) and 0.2 or 1.0)
		if UnitIsPlayer("target") then
			raceText = UnitRace("target")
			TargetFrameRace:SetTextColor(NORMAL_FONT_COLOR.r,NORMAL_FONT_COLOR.g,NORMAL_FONT_COLOR.b)
		else
			typeText = UnitCreatureType("target") or ""
			if typeText == "非战斗宠物" or typeText == "未指定" or typeText == "小动物" then
				typeText = ""
			elseif typeText ~= "" then
				typeText = string.sub(typeText, 1, 16)
			end
		end
	TargetFrameType:SetText(typeText)
	TargetFrameRace:SetText(raceText)
end)]]
	
------------------------------------------------------------------------------- TargetClassButton by 狂飙@cwdg(networm@qq.com) 20120119 DIY by y368413 
-- Binding Variables
BINDING_NAME_TARGETCLASSBUTTON_INSPECT = "    "..INSPECT
BINDING_NAME_TARGETCLASSBUTTON_TRADE = "    "..TRADE
BINDING_NAME_TARGETCLASSBUTTON_WHISPER = "    "..WHISPER
BINDING_NAME_TARGETCLASSBUTTON_FOLLOW = "    "..FOLLOW
BINDING_NAME_TARGETCLASSBUTTON_COMPARE_ACHIEVEMENTS = "    "..COMPARE_ACHIEVEMENTS

local targeticon = CreateFrame("Button", "TargetClass", TargetFrame)
targeticon:Hide()
targeticon:SetWidth(28)
targeticon:SetHeight(28)
targeticon:SetPoint("TOP", TargetFrame, "TOPRIGHT", -100, -8)
targeticon:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
local bg = targeticon:CreateTexture("TargetClassBackground", "BACKGROUND")
bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
bg:SetWidth(28)
bg:SetHeight(28)
bg:SetPoint("CENTER")
bg:SetVertexColor(0, 0, 0, 0.7)
local icon = targeticon:CreateTexture("TargetClassIcon", "ARTWORK")
icon:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
icon:SetWidth(21)
icon:SetHeight(21)
icon:SetPoint("CENTER")
RaiseFrameLevel(targeticon)
targeticon:SetScript("OnUpdate", function(self)
	if (not UnitCanAttack("player","target") and UnitIsPlayer("target")) then
		targeticon:Enable()
		SetDesaturation(TargetClassIcon, false)
	else
		targeticon:Disable()
		SetDesaturation(TargetClassIcon, true)
	end
end)
targeticon:SetScript("OnMouseDown", function(self, button)
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
hooksecurefunc("TargetFrame_Update", function()
	if UnitIsPlayer("target") then
		TargetClassIcon:SetTexCoord(unpack(CLASS_ICON_TCOORDS[select(2, UnitClass("target"))]))
		targeticon:Show()
	else
		targeticon:Hide()
	end
end)

--[[宠物目标
local ToPetFrame = CreateFrame("Button", "UFP_ToPetFrame", PetFrame, "SecureUnitButtonTemplate, SecureHandlerAttributeTemplate");
ToPetFrame:SetFrameLevel(8);
ToPetFrame:SetWidth(96);
ToPetFrame:SetHeight(48);
ToPetFrame:ClearAllPoints();
ToPetFrame:SetPoint("TOP", PetFrame, "BOTTOM", 12, 21);

ToPetFrame:SetAttribute("unit", "pettarget");
RegisterUnitWatch(ToPetFrame);
ToPetFrame:SetAttribute("*type1", "target");
ToPetFrame:RegisterForClicks("AnyUp");

ToPetFrame.Portrait = ToPetFrame:CreateTexture("UFP_ToPetFramePortrait", "BORDER");
ToPetFrame.Portrait:SetWidth(27);
ToPetFrame.Portrait:SetHeight(27);
ToPetFrame.Portrait:ClearAllPoints();
ToPetFrame.Portrait:SetPoint("TOPLEFT", ToPetFrame, "TOPLEFT", 6, -5);

ToPetFrame.Texture = ToPetFrame:CreateTexture("UFP_ToPetFrameTexture", "ARTWORK");
ToPetFrame.Texture:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame");
ToPetFrame.Texture:SetWidth(96);
ToPetFrame.Texture:SetHeight(48);
ToPetFrame.Texture:ClearAllPoints();
ToPetFrame.Texture:SetPoint("TOPLEFT", ToPetFrame, "TOPLEFT", 0, -2);

ToPetFrame.Name = ToPetFrame:CreateFontString(nil, "OVERLAY");
ToPetFrame.Name:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
ToPetFrame.Name:ClearAllPoints();
ToPetFrame.Name:SetPoint("BOTTOMLEFT", ToPetFrame, "BOTTOMLEFT", 32, 12);

ToPetFrame.HealthBar = CreateFrame("StatusBar", "UFP_ToPetFrameHealthBar", ToPetFrame);
ToPetFrame.HealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
ToPetFrame.HealthBar:SetFrameLevel(2);
ToPetFrame.HealthBar:SetMinMaxValues(0, 100);
ToPetFrame.HealthBar:SetValue(0);
ToPetFrame.HealthBar:SetWidth(53);
ToPetFrame.HealthBar:SetHeight(6);
ToPetFrame.HealthBar:ClearAllPoints();
ToPetFrame.HealthBar:SetPoint("TOPLEFT", ToPetFrame, "TOPLEFT", 35, -9);
ToPetFrame.HealthBar:SetStatusBarColor(0, 1, 0);

ToPetFrame.HPPct = ToPetFrame:CreateFontString("UFP_ToPetFrameHPPct", "ARTWORK", "TextStatusBarText");
ToPetFrame.HPPct:SetFont(GameFontNormal:GetFont(), 10, "OUTLINE");
ToPetFrame.HPPct:SetTextColor(1, 0.75, 0);
ToPetFrame.HPPct:SetJustifyH("LEFT");
ToPetFrame.HPPct:ClearAllPoints();
ToPetFrame.HPPct:SetPoint("LEFT", ToPetFrame.HealthBar, "RIGHT", 2, -4);

ToPetFrame.PowerBar = CreateFrame("StatusBar", "UFP_ToPetFramePowerBar", ToPetFrame);
ToPetFrame.PowerBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
ToPetFrame.PowerBar:SetFrameLevel(2);
ToPetFrame.PowerBar:SetMinMaxValues(0, 100);
ToPetFrame.PowerBar:SetValue(0);
ToPetFrame.PowerBar:SetWidth(53);
ToPetFrame.PowerBar:SetHeight(6);
ToPetFrame.PowerBar:ClearAllPoints();
ToPetFrame.PowerBar:SetPoint("TOPLEFT", ToPetFrame, "TOPLEFT", 35, -16);
ToPetFrame.PowerBar:SetStatusBarColor(0, 0, 1);

local pettarget = CreateFrame("Frame");
    ToPetFrame:SetAttribute("unit", "pettarget");
        pettarget:SetScript("OnUpdate", function(self, elapsed)
            self.timer = (self.timer or 0) + elapsed;
            if self.timer >= 0.2 then
                if UnitExists("pettarget") then
                    ToPetFrame.Name:SetText(UnitName("pettarget"));

                    local ToPetNameColor = PowerBarColor[UnitPowerType("pettarget")] or PowerBarColor["MANA"];
                    ToPetFrame.PowerBar:SetStatusBarColor(ToPetNameColor.r, ToPetNameColor.g, ToPetNameColor.b);

                    SetPortraitTexture(ToPetFrame.Portrait, "pettarget");

                    if UnitHealthMax("pettarget") > 0 then
                        ToPetFrame.HealthBar:SetValue(UnitHealth("pettarget") / UnitHealthMax("pettarget") * 100);
                        local ToPetPctText = "";
                            ToPetPctText = math.floor(UnitHealth("pettarget") / UnitHealthMax("pettarget") * 100);
                        ToPetFrame.HPPct:SetText(ToPetPctText);
                    else
                        ToPetFrame.HealthBar:SetValue(0);
                        ToPetFrame.HPPct:SetText("");
                    end

                    if UnitPowerMax("pettarget") > 0 then
                        ToPetFrame.PowerBar:SetValue(UnitPower("pettarget") / UnitPowerMax("pettarget") * 100);
                    else
                        ToPetFrame.PowerBar:SetValue(0);
                    end
                else
                    ToPetFrame.HPPct:SetText("");
                end
                self.timer = 0;
            end
        end);]]