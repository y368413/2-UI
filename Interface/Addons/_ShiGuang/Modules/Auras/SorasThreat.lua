local _, ns = ...
local M, R, U, I = unpack(ns)
local CDS = M:GetModule("Cooldowns")

local SorasThreat_Statusbar = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\Raid\\SorasThreatbar"
local SorasThreat_GlowTex = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\Raid\\Solid"
local SorasThreat_Solid = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\Raid\\ColorBar"
local SorasThreat_ArrowLarge = "Interface\\BUTTONS\\UI-MicroStream-Red"
local SorasThreat_ArrowSmall = "Interface\\PETBATTLES\\BattleBar-AbilityBadge-Strong-Small"
local SorasThreat_NameTextL = 5									-- 名字长度 单位:字
local SorasThreat_ThreatLimited = 3
local ipairs, select, tinsert, tsort, wipe = ipairs, select, table.insert, table.sort, wipe
local ThreatList, ThreatFlag, ThreatGuid, ThreatUnit = {}, {}, "", "target"

local function GetThreat(unit, pet)   	-- 构建仇恨列表
	if UnitName(pet or unit) == UNKNOWN or not UnitIsVisible(pet or unit) then
		return
	end
	local isTanking, _, _, rawPercent, _  = UnitDetailedThreatSituation(pet or unit, ThreatUnit)
	local name = pet and UnitName(pet) or UnitName(unit)
	for index, value in ipairs(ThreatList) do
		if value.name == name then
			tremove(ThreatList, index)
			break
		end
	end
	tinsert(ThreatList, {
		name = name,
		class = select(2, UnitClass(unit)),
		rawPercent = rawPercent or 0,
		isTanking = isTanking or nil,
	})
end

local function AddThreat(unit, pet)
	if UnitExists(pet) then
		GetThreat(unit)
		GetThreat(unit, pet)
	else
		if GetNumSubgroupMembers() > 1 or GetNumGroupMembers() > 1 then
			GetThreat(unit)
		end
	end
end
	
local function SortThreat(a,b)  -- 仇恨排序
	return a.rawPercent > b.rawPercent
end

local function FormatNameText(nametext)  	-- 文字格式
	local t
	if strupper(nametext) ~= nametext then
	t = 'English'
	else
		t = 'Chinese'
	end
	local strbox = {}
	if t == 'English' then
	for i = 1, SorasThreat_NameTextL do
			tinsert(strbox, strsub(nametext, i, i))
		end
	elseif t == 'Chinese' then
		for i = 1, SorasThreat_NameTextL * 3, 3 do
			tinsert(strbox, strsub(nametext, i, i+2))
		end
	end
	return table.concat(strbox,'')
end
	
local function UpdateThreatFlag()
	local Flag, FlagT
	for key, value in ipairs(ThreatFlag) do
		value:Hide()
	end
	if _G["ThreatFlagTank"] then
	   _G["ThreatFlagTank"]:Hide()
	end
	for key, value in ipairs(ThreatList) do
		if ThreatList[key].isTanking then
			FlagT = _G["ThreatFlagTank"]
			if not FlagT then
				FlagT = CreateFrame("Frame","ThreatFlagTank",ThreatFrame, "BackdropTemplate")
				FlagT:SetWidth(2)
				FlagT:SetHeight(ThreatFrame:GetHeight())
				FlagT:SetBackdrop({ bgFile = SorasThreat_Solid })
				FlagT:SetBackdropColor(0,0,0)
				FlagT:SetFrameLevel(2)
				FlagT.Name = FlagT:CreateTexture(nil,"OVERLAY")
				FlagT.Name:SetHeight(12)
				FlagT.Name:SetWidth(12)
				FlagT.Name:SetTexture(SorasThreat_ArrowLarge)
				FlagT.Name:SetPoint("BOTTOM", FlagT, "TOP", 0, 2)
				FlagT.Text = FlagT:CreateFontString(nil,"OVERLAY")
				FlagT.Text:SetFont(STANDARD_TEXT_FONT,12,"OUTLINE")
				FlagT.Text:SetPoint("BOTTOM", FlagT.Name, "TOP", 1, -5)
				
			end
		if not value.class then value.class = 'PRIEST' end
			local Color = (CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[value.class] or RAID_CLASS_COLORS[value.class])
			FlagT.Name:SetVertexColor(Color.r, Color.g, Color.b)		
			FlagT.Text:SetText(FormatNameText(value.name))
			FlagT.Text:SetTextColor(Color.r, Color.g, Color.b)
			FlagT:SetPoint("LEFT", ThreatFrame, "LEFT", 120*100/130+3, 0)    -- 坦标签位置建议  (主框体宽度+20)*100/130+3
			FlagT:Show()
			tremove(ThreatList, key)
		end
	end
	tsort(ThreatList, SortThreat)
	for key, value in ipairs(ThreatList) do
		if key > SorasThreat_ThreatLimited then return end
		Flag = ThreatFlag[key]
		if not Flag then
			Flag = CreateFrame("Frame","ThreatFlag"..key,ThreatFrame, "BackdropTemplate")
			Flag:SetWidth(2)
			Flag:SetHeight(ThreatFrame:GetHeight())
			Flag:SetBackdrop({ bgFile = SorasThreat_Solid })
			Flag:SetBackdropColor(0,0,0)
			Flag:SetFrameLevel(2)
			Flag.Name = Flag:CreateTexture(nil,"OVERLAY")
			Flag.Name:SetHeight(8)
			Flag.Name:SetWidth(8)
			Flag.Name:SetTexture(SorasThreat_ArrowSmall)
			Flag.Name:SetPoint("TOP", Flag, "BOTTOM", 0, -2)	
			Flag.Text = Flag:CreateFontString(nil,"OVERLAY")
			Flag.Text:SetFont(STANDARD_TEXT_FONT,9,"OUTLINE")
			Flag.Text:SetPoint("TOP", Flag.Name, "BOTTOM", 1, 0)
			tinsert(ThreatFlag, Flag)
		end
		if not value.class then value.class = 'PRIEST' end
		local Color = (CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[value.class] or RAID_CLASS_COLORS[value.class])
		local rawPercent = value.rawPercent
		Flag.Name:SetVertexColor( Color.r, Color.g, Color.b)
		Flag.Text:SetText(FormatNameText(value.name))
		Flag.Text:SetTextColor(Color.r, Color.g, Color.b)
		Flag:SetPoint("LEFT", ThreatFrame, "LEFT", 120*rawPercent/130+3, 0)
		Flag:Show()
	end
end

local function CreateThreatFrame()
	local ThreatFrame = CreateFrame("Frame", "SorasThreat", UIParent)
	ThreatFrame:SetSize(143, 6)  --主框体宽度
	M.Mover(ThreatFrame, "ThreatFrame", "ThreatFrame", {"RIGHT", UIParent, "RIGHT", -210, 210})
	ThreatFrame:SetAlpha(0)
	ThreatFrame.threatUnit = ThreatFrame:CreateFontString(nil, 'OVERLAY')
	ThreatFrame.threatUnit:SetFont(STANDARD_TEXT_FONT,9,"OUTLINE")
	ThreatFrame.threatUnit:SetPoint("LEFT", ThreatFrame, "RIGHT", 4, 0)
	ThreatFrame.threatUnit:SetTextColor(0.6, 0.6, 0.6)
	ThreatFrame.threatUnit:SetText("target")
	ThreatFrame.threatUnit:SetAlpha(0)
	ThreatFrame:SetScript("OnEnter", function(self)
		self.threatUnit:SetAlpha(1)
	end)
	ThreatFrame:SetScript("OnLeave", function(self)
		self.threatUnit:SetAlpha(0)
	end)
	ThreatFrame.Overlay = CreateFrame("Frame", nil, ThreatFrame, "BackdropTemplate")
	ThreatFrame.Overlay:SetPoint("TOPLEFT",-1,1)
	ThreatFrame.Overlay:SetPoint("BOTTOMRIGHT",1,-1)
	ThreatFrame.Overlay:SetBackdrop({ 
		edgeFile = SorasThreat_GlowTex , edgeSize = 1,
		})
	ThreatFrame.Overlay:SetBackdropBorderColor(0,0,0,0.7)
	-- 仇恨条背景
	local Texture = ThreatFrame:CreateTexture(nil, "BACKGROUND",ThreatFrame)
	Texture:SetHeight(ThreatFrame:GetHeight())
	Texture:SetWidth(ThreatFrame:GetWidth())	
	Texture:SetTexture(SorasThreat_Statusbar)
	Texture:SetPoint("LEFT", 0, 0)
	Texture:SetGradient("HORIZONTAL", 0.4, 0.4, 0.4, 1, 1, 1)
	return ThreatFrame
end

local function ThreatEvent(event)
	local unit = "target"
	if event == "PLAYER_REGEN_DISABLED" then
		if not UnitExists("pet") and not IsInGroup() and not IsInRaid() then
			return
		else	
			if UnitExists(unit) and not UnitIsDead(unit) and not UnitIsPlayer(unit) and UnitCanAttack("player", unit) then
				UIFrameFadeIn(ThreatFrame, 0.7, 0, 0.8)
			end
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
		UIFrameFadeOut(ThreatFrame, 0, 0, 0)
	elseif event == "UNIT_THREAT_LIST_UPDATE" then
		if unit and UnitExists(unit) and UnitCanAttack("player", unit) then
			wipe(ThreatList)
			if IsInRaid() then
				for i = 1, GetNumGroupMembers() do
					AddThreat("raid"..i, "raid"..i.."pet")
				end
			elseif IsInGroup() then
				AddThreat("player", "pet")
				for i = 1, GetNumSubgroupMembers() do
					AddThreat("party"..i, "party"..i.."pet")
				end
			else
				AddThreat("player", "pet")
			end
			UpdateThreatFlag()
		end
	elseif event == "PLAYER_TARGET_CHANGED" and unit == 'target' then
			if not UnitExists("pet") and not IsInGroup() and not IsInRaid() then
				return
			else
				if UnitExists("target") and not UnitIsDead("target") and not UnitIsPlayer("target") and UnitCanAttack("player", "target") then
				ThreatGuid = UnitGUID("target")
				local TargetSwitch = function()
					if UnitAffectingCombat("player") then
						UIFrameFadeIn(ThreatFrame, 0.7, 0, 0.8)
					end
				end
				TargetSwitch()
				wipe(ThreatList)
				if IsInRaid() then
					for i = 1, GetNumGroupMembers() do
						AddThreat("raid"..i, "raid"..i.."pet")
					end
				elseif IsInGroup() then
					AddThreat("player", "pet")
					for i = 1, GetNumSubgroupMembers() do
						AddThreat("party"..i, "party"..i.."pet")
					end
				else
					AddThreat("player", "pet")
				end
			else
				ThreatGuid = ""
				wipe(ThreatList)
				UIFrameFadeOut(ThreatFrame, 0, 0, 0)
			end
			UpdateThreatFlag()
		end
	end
end

function CDS:SorasThreat()
    if MaoRUIPerDB["Misc"]["SorasThreat"] then
		ThreatFrame = CreateThreatFrame()
		M:RegisterEvent("UNIT_THREAT_LIST_UPDATE", ThreatEvent)
		M:RegisterEvent("PLAYER_TARGET_CHANGED", ThreatEvent)
		M:RegisterEvent("PLAYER_REGEN_DISABLED", ThreatEvent)
		M:RegisterEvent("PLAYER_REGEN_ENABLED", ThreatEvent)
	else
		M:UnregisterEvent("UNIT_THREAT_LIST_UPDATE", ThreatEvent)
		M:UnregisterEvent("PLAYER_TARGET_CHANGED", ThreatEvent)
		M:UnregisterEvent("PLAYER_REGEN_DISABLED", ThreatEvent)
		M:UnregisterEvent("PLAYER_REGEN_ENABLED", ThreatEvent)
	end
end
