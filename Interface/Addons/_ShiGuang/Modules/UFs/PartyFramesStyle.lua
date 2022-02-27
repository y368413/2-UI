SetCVar("showCastableBuffs", 1)			-- GetCVarDefault : 0
SetCVar("showDispelDebuffs", 1)			-- GetCVarDefault : 1
local iMAX_PARTY_BUFFS, iMAX_PARTY_DEBUFFS = 12, 8
local PLAYER_UNITS = {player = true, vehicle = true, pet = true,}
for i = 1, 4 do
	local str = "PartyMemberFrame"..i
	for j = 1, iMAX_PARTY_BUFFS do
		PartyBuff = CreateFrame("Button", str.."Buff"..j, _G[str], "PartyBuffFrameTemplate")
		PartyBuff:SetID(j)
		if j == 1 then
			PartyBuff:SetPoint("TOPLEFT", str, "TOPLEFT", 48, -32)
		else
			PartyBuff:SetPoint("LEFT", str.."Buff"..j-1, "RIGHT", 2, 0)
		end
	end
	_G["PartyMemberFrame"..i.."Debuff1"]:ClearAllPoints()
	_G["PartyMemberFrame"..i.."Debuff1"]:SetPoint("TOPLEFT", "PartyMemberFrame"..i, "TOPLEFT", 48, -32)
	for j = 5, iMAX_PARTY_DEBUFFS do
		PartyDebuff = CreateFrame("Button", str.."Debuff"..j, _G[str], "PartyDebuffFrameTemplate")
		PartyDebuff:SetID(j)
		if j == 6 then
			PartyDebuff:SetPoint("TOP", str.."Debuff"..1, "BOTTOM", 0, -2)
		else
			PartyDebuff:SetPoint("LEFT", str.."Debuff"..j-1, "RIGHT", 2, 0)
		end
	end
end
PartyMemberBuffTooltip_Update = function(self) return end
hooksecurefunc("RefreshBuffs", function(frame, unit, numBuffs, suffix, checkCVar)
	numBuffs = numBuffs or MAX_PARTY_BUFFS
	suffix = suffix or "Buff"
	if checkCVar and SHOW_CASTABLE_BUFFS == "1" and UnitCanAssist("player", unit) then filter = "RAID" end
	for i = 1, numBuffs do
		buffName = frame:GetName()..suffix..i
		if _G[buffName]:IsShown() then
			caster = select(7, UnitBuff(unit, i, filter))
				if UnitCanAssist("player", unit) and not PLAYER_UNITS[caster] then
					_G[buffName.."Icon"]:SetDesaturated(true)
				else
					_G[buffName.."Icon"]:SetDesaturated(false)
				end
		end
	end
end)

hooksecurefunc("RefreshDebuffs", function(frame, unit, numDebuffs, suffix, checkCVar)
	local numBuffs = nil
	if string.find(unit, "party") and string.len(unit) == 6 then
		numBuffs, numDebuffs = iMAX_PARTY_BUFFS, iMAX_PARTY_DEBUFFS
	else
		numDebuffs = numDebuffs or MAX_PARTY_DEBUFFS
	end
	suffix = suffix or "Debuff"
	if numBuffs then RefreshBuffs(frame, unit, numBuffs, nil, true) end
	if checkCVar and SHOW_DISPELLABLE_DEBUFFS == "1" and UnitCanAssist("player", unit) then filter = "RAID" end
	for i = 1, numDebuffs do
		debuffName = frame:GetName()..suffix..i
		if _G[debuffName]:IsShown() then
			caster = select(7, UnitDebuff(unit, i, filter))
				if not UnitCanAssist("player", unit) and not PLAYER_UNITS[caster] then
					_G[debuffName.."Icon"]:SetDesaturated(true)
					_G[debuffName.."Border"]:Hide()
				else
					_G[debuffName.."Icon"]:SetDesaturated(false)
					_G[debuffName.."Border"]:Show()
				end
		end
	end
end)

--[[hooksecurefunc("TargetFrame_UpdateAuras", function(self)
	for i = 1, MAX_TARGET_BUFFS do
		frameName = self:GetName().."Buff"..(i)
		caster = select(7, UnitBuff(self.unit, i, nil))
		if _G[frameName] and _G[frameName]:IsShown() then
			if UnitCanAssist("player", self.unit) and not PLAYER_UNITS[caster] then
				_G[frameName.."Icon"]:SetDesaturated(true)
			else
				_G[frameName.."Icon"]:SetDesaturated(false)
			end
		end
	end
	for i = 1, MAX_TARGET_DEBUFFS do
		frameName = self:GetName().."Debuff"..i
		caster = select(7, UnitDebuff(self.unit, i, "INCLUDE_NAME_PLATE_ONLY"))
		if _G[frameName] and _G[frameName]:IsShown() then
			if not UnitCanAssist("player", self.unit) and not PLAYER_UNITS[caster] then
				_G[frameName.."Icon"]:SetDesaturated(true)
				_G[frameName.."Border"]:Hide()
			else
				_G[frameName.."Icon"]:SetDesaturated(false)
				_G[frameName.."Border"]:Show()
			end
		end
	end
end)]]

------------------------------------------------------------------- 隊友目標框架 ---------
local function PartyTarget_UpdateName(self, unit)
    local color = RAID_CLASS_COLORS[select(2,UnitClass(unit))] or NORMAL_FONT_COLOR
    local fontFile, fontSize, fontFlags = self.Name:GetFont()
    self.Name:SetFont(fontFile, 9, "OUTLINE")
    self.Name:SetText(UnitName(unit))
    self.Name:SetTextColor(color.r, color.g, color.b)
end
--更新HP
local function PartyTarget_UpdateHealth(self, unit)
    if (UnitIsGhost(unit)) then
        self.HealthBar:SetValue(0)
        self.HealthBar.Text:SetText("|cffeed200 *** |r")
        return 
    end
    if (UnitIsDead(unit)) then
        self.HealthBar:SetValue(0)
        self.HealthBar.Text:SetText("|cffeed200  X  |r")
        return 
    end
    local hp = UnitHealth(unit)
    local perc = floor(hp / max((UnitHealthMax(unit) or 1),1) * 100)
    self.HealthBar:SetValue(perc)
    self.HealthBar.Text:SetText(perc .. "%")
end
--更新颜色
local function PartyTarget_UpdateColor(self, unit)
    if UnitIsEnemy("player", unit) then
        self.Border:SetVertexColor(1, 0.2, 0.2, 0.6)
        self.HealthBar:SetStatusBarColor(0.9, 0.55, 0.72)
    elseif UnitIsFriend("player", unit) then
        self.Border:SetVertexColor(0, 1, 0, 0.6)
        self.HealthBar:SetStatusBarColor(0, 0.9, 0)
    else
        self.Border:SetVertexColor(0.9, 0.82, 0, 0.6)
        self.HealthBar:SetStatusBarColor(0.65, 0.9, 0.85)
    end
end

--更新透明度
local function PartyTarget_UpdateAlpha(self, unit)
    if (UnitInRange(unit)) then
        self:SetAlpha(1)
    else
        self:SetAlpha(0.8)
    end
end

--創建隊友目標框架
local function PartyTarget_CreateButton(index)
    local parent = _G["PartyMemberFrame"..index]
    local button = CreateFrame("Button", "PartyTargetFrame"..index, parent, "SecureUnitButtonTemplate")
    button.unit = "party"..index.."target"
    button:SetID(index)
    button:SetFrameStrata("LOW")
    button:SetWidth(43)
    button:SetHeight(21)
    button:SetHitRectInsets(0, 0, -8, -6)
	button:SetAttribute("unit", "party"..index.."target")
	button:SetAttribute("type1", "target")
    button:SetAttribute("type2", "focus")
    button:SetPoint("TOPRIGHT", parent, "TOPLEFT", -8, -8)   --"TOPLEFT", parent, "TOPRIGHT", 21, -6
    button.Name = button:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	button.Name:SetPoint("TOPRIGHT", button, "TOPRIGHT", 8, 3)
	button.Name:SetTextColor(1, 0.82, 0)
	button.Border = button:CreateTexture(nil, "BORDER")
	button.Border:SetTexture("Interface\\Tooltips\\UI-StatusBar-Border")
	button.Border:SetWidth(46)
	button.Border:SetHeight(24)
	button.Border:SetPoint("TOPLEFT", button, "TOPLEFT", 0, -6)
	button.HealthBar = CreateFrame("STATUSBAR", nil, button)
	button.HealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	button.HealthBar:SetFrameStrata("HIGH")
	button.HealthBar:SetMinMaxValues(0, 100)
	button.HealthBar:SetValue(100)
	button.HealthBar:SetWidth(43)
	button.HealthBar:SetHeight(18)
	button.HealthBar:SetPoint("TOP", button, "TOP", 1, -9)
	button.HealthBar.Text = button.HealthBar:CreateFontString(nil, "ARTWORK", "SystemFont_Outline_Small")
	button.HealthBar.Text:SetPoint("CENTER", button.HealthBar, "CENTER", 3, 1)
	button.HealthBar.Text:SetTextColor(1, 1, 1)
    button.HealthBar.Text:SetFont(SystemFont_Outline_Small:GetFont(), 11, "OUTLINE")
    button:SetAlpha(0)    
    return button
end
for i = 1, MAX_PARTY_MEMBERS do PartyTarget_CreateButton(i) end

--隊友目標框架更新
hooksecurefunc("PartyMemberFrame_OnUpdate", function(self, elapsed)
	self.timer = (self.timer or 0) + elapsed
	if (self.timer >= 0.2) then
        self.timer = 0
        local unit = "party" .. self:GetID() .."target"
        local frame = _G["PartyTargetFrame"..self:GetID()]
		if UnitExists(unit) then
            PartyTarget_UpdateName(frame, unit)
            PartyTarget_UpdateHealth(frame, unit)
            PartyTarget_UpdateColor(frame, unit)
            PartyTarget_UpdateAlpha(frame, unit)
		else
			frame:SetAlpha(0)
		end
	end
end)

--隊友角色等级显示
local function PartyLevelText_Update(self)
	local level = ""
	if self.unit and UnitLevel(self.unit) and UnitLevel(self.unit) >= 1 then
		level = UnitLevel(self.unit)
	end
	if not self.levelText then
		self.levelText = _G[self:GetName()]:CreateFontString(nil, "OVERLAY", "NumberFontNormalLargeYellow")
		self.levelText:ClearAllPoints();
		self.levelText:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 12, -6)
	end
	self.levelText:SetText(level)
end

hooksecurefunc("PartyMemberFrame_UpdateMember", function(self)
	local unit = "party"..self:GetID()
	if UnitExists(unit) then
		PartyLevelText_Update(self)
		--CastingBarFrame_SetUnit(self.castBar, unit, false, true)
	end
end)

--[[local iFrame = CreateFrame("Frame")
iFrame:RegisterEvent("UNIT_LEVEL")
iFrame:SetScript("OnEvent", function(self, event, ...)
	local arg1 = ...
	if event == "UNIT_LEVEL" then
		for i = 1, 4 do
			if arg1 == "party"..i then
				PartyLevelText_Update(_G["PartyMemberFrame"..i])
			end
		end
	end
end)]]

---------------------------------------- 隊友施法條-- Party casting bar-------------------------------------
--顯示位置
local function PartyCastingBar_OnShow(self)
    local parentFrame = self:GetParent()
    local petFrame = _G[parentFrame:GetName() .. "PetFrame"]
    if (self.PartyId and petFrame:IsShown()) then self:SetPoint("BOTTOM", parentFrame, "BOTTOM", 0, -26)
	  else self:SetPoint("BOTTOM", parentFrame, "BOTTOM", 0, 0) end
end
--事件監聽
local function PartyCastingBar_OnEvent(self, event, ...)
    local arg1 = ...
    if (event == "CVAR_UPDATE") then
		   if (self.casting or self.channeling) then self:Show() else self:Hide() end
		return
	     elseif (event == "GROUP_ROSTER_UPDATE" or event == "PARTY_MEMBER_ENABLE" or event == "PARTY_MEMBER_DISABLE" or event == "PARTY_LEADER_CHANGED") then
        if (GetDisplayedAllyFrames() ~= "party") then return end
		if (UnitChannelInfo(self.unit)) then
			event = "UNIT_SPELLCAST_CHANNEL_START"
			arg1 = self.unit
		elseif (UnitCastingInfo(self.unit)) then
			event = "UNIT_SPELLCAST_START"
			arg1 = self.unit
		else
			self.casting = nil
			self.channeling = nil
			self:SetMinMaxValues(0, 0)
			self:SetValue(0)
			self:Hide()
			return
		end
		PartyCastingBar_OnShow(self)
	end
    CastingBarFrame_OnEvent(self, event, arg1, select(2, ...))
end
-- 創建施法條
local partycastframe, partycastparent
for i = 1, MAX_PARTY_MEMBERS do
	partycastframe = CreateFrame("STATUSBAR", "PartyCastingBar"..i, _G["PartyMemberFrame"..i], "SmallCastingBarFrameTemplate")
    partycastframe.PartyId = i
    partycastframe.Icon:Hide()
    partycastframe:SetScale(0.75)
    partycastframe:SetScript("OnShow", PartyCastingBar_OnShow)
    partycastframe:SetScript("OnEvent", PartyCastingBar_OnEvent)
    --partycastframe:RegisterEvent("GROUP_ROSTER_UPDATE")
	partycastframe:RegisterEvent("PARTY_MEMBER_ENABLE")
	partycastframe:RegisterEvent("PARTY_MEMBER_DISABLE")
	partycastframe:RegisterEvent("PARTY_LEADER_CHANGED")
    partycastframe:RegisterEvent("CVAR_UPDATE")
    CastingBarFrame_OnLoad(partycastframe, "party"..i, false, false)
    CastingBarFrame_SetNonInterruptibleCastColor(partycastframe, 1.0, 0.7, 0)
    local prev = "PartyMemberFrame"..(i-1) .. "PetFrame"
    if (_G[prev]) then _G["PartyMemberFrame"..i]:SetPoint("TOPLEFT", _G[prev], "BOTTOMLEFT", -21, -30) end
    
            
    --partycastparent = _G["PartyMemberFrame"..i]
    --partycastparent.bufftip = CreateFrame("Frame", nil, partycastparent)
    --partycastparent.bufftip:SetSize(36, 36)
    --partycastparent.bufftip:SetPoint("TOPLEFT", 5, -6)
    --partycastparent.bufftip.atonement = partycastparent.bufftip:CreateTexture(nil, "ARTWORK")
    --partycastparent.bufftip.atonement:SetTexture("Interface\\Minimap\\UI-ArchBlob-MinimapRing")
    --partycastparent.bufftip.atonement:SetVertexColor(0, 1, 0)
    --partycastparent.bufftip.atonement:SetSize(36, 36)
    --partycastparent.bufftip.atonement:SetPoint("CENTER")
    --partycastparent.bufftip:SetFrameLevel(86)
    --partycastparent.bufftip:SetAlpha(0)
end

--IconMarks ## Version: 0.1.3 ## Author: dabussr@hotmail.com
	for i = 1, 5 do
		unit = "Party"..i
		if i == 5 then
			unit = "Player"
		end
		if unit == "Player" then
			local button = CreateFrame("BUTTON", "IconMarksPlayerIcon", GetClickFrame("PlayerFrame"), "secureActionButtonTemplate")
			button:SetPoint("TOPRIGHT", "PlayerFrame", "TOPRIGHT", -150, 0)
			button:SetBackdrop({ bgFile = "Interface/BUTTONS/WHITE8X8" })
			button:SetWidth(17)
			button:SetHeight(17)
			button:SetBackdropColor(0.1, 0.1, 0.1, 0)
			button:SetNormalTexture("")
			button:SetFrameLevel(128)
			button:SetScript("OnEvent", IconMarks_OnEvent)
		else	
			local button = CreateFrame("BUTTON", "IconMarksParty"..i.."Icon", GetClickFrame("PartyMemberFrame"..i), "secureActionButtonTemplate")
			button:SetPoint("TOPRIGHT", "PartyMemberFrame"..i, "TOPRIGHT", -96, 0)
			button:SetBackdrop({ bgFile = "Interface/BUTTONS/WHITE8X8" })
			button:SetWidth(13)
			button:SetHeight(13)
			button:SetBackdropColor(0.1, 0.1, 0.1, 0)
			button:SetNormalTexture("")
			button:SetFrameLevel(128)
		end
	end

local IconMarks_timer = CreateFrame("Frame");
IconMarks_timer:SetScript("OnUpdate", function(self, sinceLastUpdate) IconMarks_timer:onUpdate(sinceLastUpdate); end);
function IconMarks_timer:onUpdate(sinceLastUpdate)
	self.sinceLastUpdate = (self.sinceLastUpdate or 0) + sinceLastUpdate
	if (self.sinceLastUpdate >= 2) then 
	for i = 1, 5 do
		unit = "Party"..i
		if i == 5 then
			unit = "Player"
		end
		if UnitExists(unit) then
			local unit_mark_index = 0
			local unit_mark_texture = ""
			if GetRaidTargetIndex(unit) == nil then unit_mark_index = 0 else unit_mark_index = GetRaidTargetIndex(unit) end
			if unit_mark_index ~= 0 then
				unit_mark_texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_"..unit_mark_index
			else
				unit_mark_texture = ""
			end				
			if unit == "Player" then
				GetClickFrame("IconMarksPlayerIcon"):SetNormalTexture(unit_mark_texture)
			else
				GetClickFrame("IconMarksParty"..i.."Icon"):SetNormalTexture(unit_mark_texture)			
			end				
		end		
	end
		self.sinceLastUpdate = 0;
	end
end