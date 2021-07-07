---------------------------------------------------- MAIN ADDON FRAME
local MAF=CreateFrame("Frame","MyParent",UIParent, "BackdropTemplate")
	MAF:SetSize(21,21)
	MAF:SetPoint("RIGHT", UIParent, "RIGHT", -66, 88)
	MAF:SetBackdrop({bgFile = "Interface\\AddOns\\_ShiGuang\\Media\\Hexagon"})
	MAF:SetBackdropColor(RAID_CLASS_COLORS[select(2, UnitClass("player"))].r, RAID_CLASS_COLORS[select(2, UnitClass("player"))].g, RAID_CLASS_COLORS[select(2, UnitClass("player"))].b)
	MAF:SetMovable(true)
	MAF:EnableMouse(true)
	MAF:RegisterForDrag("LeftButton")
	MAF:SetScript("OnDragStart", MAF.StartMoving)
	MAF:SetScript("OnDragStop", MAF.StopMovingOrSizing)
	MAF:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(MAF, "ANCHOR_TOP")
	GameTooltip:AddLine("点我拖动", 1,2,0)
	GameTooltip:AddLine("左击-标记.右击-光柱", 0,6,6)
	GameTooltip:Show()
	end)
  MAF:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	
---------------------------------------------------- MARKS & FLARES
local function CreatMarkerButton(id, parent, Texture, w, h, ap, frame, rp, x, y, alpha)
		local Markerbutton = CreateFrame("Button", id, parent, "secureActionButtonTemplate")
		Markerbutton:SetWidth(w)
		Markerbutton:SetHeight(h)
		Markerbutton:SetPoint(ap, frame, rp, x, y)
		Markerbutton:SetNormalTexture(Texture)
		Markerbutton:SetAlpha(alpha)
		return Markerbutton
end
	
--Skull Marks Raid Marker 8 NO World Marker
  WMSkull = CreatMarkerButton("RaidMarker8Skull", MAF, "Interface\\TargetingFrame\\UI-RaidTargetingIcon_8.png", 21, 21, "TOP", MAF, "BOTTOM", 0, 0, 0.5)
	WMSkull:RegisterForClicks("AnyUp")
	WMSkull:SetAttribute("type","macro")
	WMSkull:SetAttribute("macrotext",'/run if SecureCmdOptionParse("[btn:1]") then SetRaidTargetIcon("target",8) end\n/wm [btn:2] 8')
	
--Cross Marks Raid Marker 7 World Marker 4
	WMCross = CreatMarkerButton("RaidMarker7Cross", MAF, "Interface\\TargetingFrame\\UI-RaidTargetingIcon_7.png", 21, 21, "TOP", WMSkull, "BOTTOM", 0, -5, 0.5)
	WMCross:RegisterForClicks("AnyUp")
	WMCross:SetAttribute("type","macro")
	WMCross:SetAttribute("macrotext",'/run if SecureCmdOptionParse("[btn:1]") then SetRaidTargetIcon("target",7) end\n/wm [btn:2] 4')
	
--Square Marks Raid Marker 6 World Marker 1
  WMSquare = CreatMarkerButton("RaidMarker6Square", MAF, "Interface\\TargetingFrame\\UI-RaidTargetingIcon_6.png", 21, 21, "TOP", WMCross, "BOTTOM", 0, -5, 0.5)
	WMSquare:RegisterForClicks("AnyUp")
	WMSquare:SetAttribute("type","macro")
	WMSquare:SetAttribute("macrotext",'/run if SecureCmdOptionParse("[btn:1]") then SetRaidTargetIcon("target",6) end\n/wm [btn:2] 1')
	
--Moon Marks Raid Marker 5 World Marker 7
  WMMoon = CreatMarkerButton("RaidMarker5Moon", MAF, "Interface\\TargetingFrame\\UI-RaidTargetingIcon_5.png", 21, 21, "TOP", WMSquare, "BOTTOM", 0, -5, 0.5)
	WMMoon:RegisterForClicks("AnyUp")
	WMMoon:SetAttribute("type","macro")
	WMMoon:SetAttribute("macrotext",'/run if SecureCmdOptionParse("[btn:1]") then SetRaidTargetIcon("target",5) end\n/wm [btn:2] 7')
	
--Triangle Marks Raid Marker 4 World Marker 2
  WMTriangle = CreatMarkerButton("RaidMarker4Triangle", MAF, "Interface\\TargetingFrame\\UI-RaidTargetingIcon_4.png", 21, 21, "TOP", WMMoon, "BOTTOM", 0, -5, 0.5)
	WMTriangle:RegisterForClicks("AnyUp")
	WMTriangle:SetAttribute("type","macro")
	WMTriangle:SetAttribute("macrotext",'/run if SecureCmdOptionParse("[btn:1]") then SetRaidTargetIcon("target",4) end\n/wm [btn:2] 2')
	
--Diamond Marks Raid Marker 3 World Marker 3
  WMDiamond = CreatMarkerButton("RaidMarker3Diamond", MAF, "Interface\\TargetingFrame\\UI-RaidTargetingIcon_3.png", 21, 21, "TOP", WMTriangle, "BOTTOM", 0, -5, 0.5)
	WMDiamond:RegisterForClicks("AnyUp")
	WMDiamond:SetAttribute("type","macro")
	WMDiamond:SetAttribute("macrotext",'/run if SecureCmdOptionParse("[btn:1]") then SetRaidTargetIcon("target",3) end\n/wm [btn:2] 3')
	
--Circle Marks Raid Marker 2 World Marker 6
  WMCircle = CreatMarkerButton("RaidMarker2Circle", MAF, "Interface\\TargetingFrame\\UI-RaidTargetingIcon_2.png", 21, 21, "TOP", WMDiamond, "BOTTOM", 0, -5, 0.5)
	WMCircle:RegisterForClicks("AnyUp")
	WMCircle:SetAttribute("type","macro")
	WMCircle:SetAttribute("macrotext",'/run if SecureCmdOptionParse("[btn:1]") then SetRaidTargetIcon("target",2) end\n/wm [btn:2] 6')

--Star Marks Raid Marker 1 World Marker 5
    WMStar = CreatMarkerButton("RaidMarker1Star", MAF, "Interface\\TargetingFrame\\UI-RaidTargetingIcon_1.png", 21, 21, "TOP", WMCircle, "BOTTOM", 0, -5, 0.5)
	WMStar:RegisterForClicks("AnyUp")
	WMStar:SetAttribute("type","macro")
	WMStar:SetAttribute("macrotext",'/run if SecureCmdOptionParse("[btn:1]") then SetRaidTargetIcon("target",1) end\n/wm [btn:2] 5')
	
--Clear Marks Raid Marker 0 World Marker 6
	WMClear = CreatMarkerButton("WorldMarker6Clear", MAF, "Interface\\BUTTONS\\UI-GroupLoot-Pass-Up", 21, 21, "TOP", WMStar, "BOTTOM", 0, -5, 0.5)
	WMClear:RegisterForClicks("AnyUp")
	WMClear:SetAttribute("type","macro")
	WMClear:SetAttribute("macrotext","/tm [btn:1] 0\n/cwm [btn:2] 0")
	
---------------------------------------------------- READY CHECK
	RC = CreatMarkerButton("READYCHECK", MAF, "Interface\\Addons\\_ShiGuang\\Media\\Emotes\\okay", 21, 21, "TOP", WMClear, "BOTTOM", 0, -11, 0.43)
	RC:RegisterForClicks("LeftButtonUp")
	RC:SetAttribute("type","macro")
	RC:SetAttribute("macrotext",'/script DoReadyCheck()')
	RC:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(RC, "ANCHOR_TOP")
	GameTooltip:AddLine("就位确认", 1,2,0)
	GameTooltip:Show()
	end)
    RC:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	
---------------------------------------------------- ROLE POLL
    RP = CreatMarkerButton("ROLEPOLL", MAF, "Interface\\Addons\\_ShiGuang\\Media\\Modules\\Role\\DAMAGER", 21, 21, "TOP", RC, "BOTTOM", 0, -3, 0.43)
	RP:RegisterForClicks("LeftButtonUp")
	RP:SetAttribute("type","macro")
	RP:SetAttribute("macrotext",'/script InitiateRolePoll()')
	RP:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(RP, "ANCHOR_TOP")
	GameTooltip:AddLine("职责确认", 1,2,0)
	GameTooltip:Show()
	end)
    RP:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	
---------------------------------------------------- FlaskFood  --RP:SetText("※")
	local BuffName, numPlayer = {"合剂", "食物", SPELL_STAT4_NAME, RAID_BUFF_2, RAID_BUFF_3, RUNES}
	local NoBuff, numGroups = {}, 6
	for i = 1, numGroups do NoBuff[i] = {} end
    local FFCBuffList = {
	[1] = {
		307166,	-- 大锅
		307185,	-- 通用合剂
		307187,	-- 耐力合剂
	},		-- 合剂
	[2] = {	104273,	},     -- 进食充分  -- 250敏捷，BUFF名一致
	[3] = {	1459,	264760,	},     -- 10%智力
	[4] = { 21562, 264764, },     -- 10%耐力
	[5] = { 6673, 264761, },     -- 10%攻强
	[6] = { 270058, },     -- 符文
}
	-- Role counts
	local function getRaidMaxGroup()
		local _, instType, difficulty = GetInstanceInfo()
		if (instType == "party" or instType == "scenario") and not IsInRaid() then
			return 1
		elseif instType ~= "raid" then
			return 8
		elseif difficulty == 8 or difficulty == 1 or difficulty == 2 or difficulty == 24 then
			return 1
		elseif difficulty == 14 or difficulty == 15 then
			return 6
		elseif difficulty == 16 then
			return 4
		elseif difficulty == 3 or difficulty == 5 then
			return 2
		elseif difficulty == 9 then
			return 8
		else
			return 5
		end
	end
	local function sendMsg(text)
			SendChatMessage(text, IsPartyLFG() and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY")
	end

	local function sendResult(i)
		local count = #NoBuff[i]
		if count > 0 then
			if count >= numPlayer then
				sendMsg("缺少"..BuffName[i]..": "..ALL..PLAYER)
			elseif count >= 5 and i > 2 then
				sendMsg("缺少"..BuffName[i]..": "..format(U["Player Count"], count))
			else
				local str = "缺少"..BuffName[i]..": "
				for j = 1, count do
					str = str..NoBuff[i][j]..(j < #NoBuff[i] and ", " or "")
					if #str > 230 then
						sendMsg(str)
						str = ""
					end
				end
				sendMsg(str)
			end
		end
	end

	local function scanBuff()
		for i = 1, numGroups do wipe(NoBuff[i]) end
		numPlayer = 0

		local maxgroup = getRaidMaxGroup()
		for i = 1, GetNumGroupMembers() do
			local name, _, subgroup, _, _, _, _, online, isDead = GetRaidRosterInfo(i)
			if name and online and subgroup <= maxgroup and not isDead then
				numPlayer = numPlayer + 1
				for j = 1, numGroups do
					local HasBuff
					local buffTable = FFCBuffList[j]
					for k = 1, #buffTable do
						local buffName = GetSpellInfo(buffTable[k])
						for index = 1, 32 do
							local currentBuff = UnitAura(name, index)
							if currentBuff and currentBuff == buffName then
								HasBuff = true
								break
							end
						end
					end
					if not HasBuff then
						name = strsplit("-", name)	-- remove realm name
						tinsert(NoBuff[j], name)
					end
				end
			end
		end
		NoBuff[numGroups] = {} 

		if #NoBuff[1] == 0 and #NoBuff[2] == 0 and #NoBuff[3] == 0 and #NoBuff[4] == 0 and #NoBuff[5] == 0 and #NoBuff[6] == 0 then
			sendMsg("食物合剂检查: 已齐全。")
		else
			sendMsg("食物合剂检查:")
			for i = 1, 5 do sendResult(i) end
			sendResult(numGroups)
		end
	end

	FF = CreatMarkerButton("FLASKFOOD", MAF, "Interface\\GossipFrame\\TaxiGossipIcon", 21, 21, "TOP", RP, "BOTTOM", 0, -3, 0.43)
    FF:SetScript("OnEnter", function(self) GameTooltip:SetOwner(FF, "ANCHOR_TOP") GameTooltip:AddLine("检查食物", 1,2,0) GameTooltip:Show() end)
    FF:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	FF:SetScript("OnMouseDown", function(self) scanBuff() end)
  
---------------------------------------------------- PullTimer
	PT = CreatMarkerButton("FLASKFOOD", MAF, "Interface\\Addons\\_ShiGuang\\Media\\Modules\\Role\\bubbleTex", 21, 21, "TOP", FF, "BOTTOM", 0, -3, 0.43)
    PT:SetScript("OnEnter", function(self) GameTooltip:SetOwner(PT, "ANCHOR_TOP") GameTooltip:AddLine("DBM倒数", 1,2,0) GameTooltip:Show() end)
    PT:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	PT:RegisterForClicks("LeftButtonUp")
	PT:SetAttribute("type","macro")
	PT:SetAttribute("macrotext",'/dbm pull 8')
 
--[[-------------------------------------------------- Battle resurrect
	RES = CreatMarkerButton("FLASKFOOD", MAF, GetSpellTexture(20484), 18, 18, "TOP", PT, "BOTTOM", 0, -3, 0.43)
	RES.Count = RES:CreateFontString(nil, "OVERLAY")
	RES.Count:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
	RES.Count:SetText("0")
	RES.Count:SetWordWrap(false)
	RES.Count:ClearAllPoints()
	RES.Count:SetPoint("BOTTOMRIGHT", 0, 0)
	RES.Timer = RES:CreateFontString(nil, "OVERLAY")
	RES.Timer:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
	RES.Timer:SetText("")
	RES.Timer:SetWordWrap(false)
	RES.Timer:SetPoint("BOTTOMRIGHT", 6, -12)
	RES:SetScript("OnEnter", function(self) GameTooltip:SetOwner(RES, "ANCHOR_TOP") GameTooltip:AddLine("战复", 1,2,0) GameTooltip:Show() end)
    RES:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	RES:SetScript("OnUpdate", function(self, elapsed)
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed > .1 then
			local charges, _, started, duration = GetSpellCharges(20484)
			if charges then
				local timer = duration - (GetTime() - started)
				if timer < 0 then
					self.Timer:SetText("0:0")
				else
					self.Timer:SetFormattedText("%d:%.2d", timer/60, timer%60)
				end
				self.Count:SetText(charges)
				if charges == 0 then
					self.Count:SetTextColor(1, 0, 0)
				else
					self.Count:SetTextColor(0, 1, 0)
				end
			else
			return
			end
			self.elapsed = 0
		end
	end)
	RES:SetScript("OnMouseDown", function(self)
		SendChatMessage("战复剩: "..self.Count.."次 充能: "..self.Timer:GetText(), "YELL")
end)]]
	 	
---------------------------------------------------- Automatically show/hide the frame if we have RaidLeader or RaidOfficer
local function CheckRaidStatus()
	local inInstance, instanceType = IsInInstance()
	if ((IsInGroup() and not IsInRaid()) or UnitIsGroupLeader('player') or UnitIsGroupAssistant("player")) and not (inInstance and (instanceType == "pvp" or instanceType == "arena")) then return true else return false end
end
MAF:RegisterEvent("GROUP_ROSTER_UPDATE")
MAF:RegisterEvent("PLAYER_ENTERING_WORLD")
MAF:SetScript("OnEvent", function(self, event, ...)
if InCombatLockdown() then MAF:RegisterEvent("PLAYER_REGEN_ENABLED") return end
if CheckRaidStatus() then MAF:Show() else MAF:Hide() end
if event == "PLAYER_REGEN_ENABLED" then MAF:UnregisterEvent("PLAYER_REGEN_ENABLED") end
end);

--------------------------------------------------------------------------------------- DejaAutoMark ## Authors: Dejablue
local TankHealerMarkFrame = CreateFrame("Frame", "TankHealerMarkFrame")
TankHealerMarkFrame:RegisterEvent("PLAYER_LOGIN")
TankHealerMarkFrame:RegisterEvent("GROUP_ROSTER_UPDATE")

TankHealerMarkFrame:SetScript("OnEvent", function(self, event, ...)
  if not MaoRUIPerDB["Misc"]["AutoMark"] then return end
	if (not IsInRaid()) and IsInGroup() then
		local ROLEMARKS={["TANK"]=2,["HEALER"]=5}
		for i=1,5 do 
			local role=UnitGroupRolesAssigned("party"..i)
			if ROLEMARKS[role]then 
				SetRaidTarget("party"..i,ROLEMARKS[role])
			end 
		end
		local currentSpecID, currentSpecName = GetSpecializationInfo(GetSpecialization())
		local roleToken = GetSpecializationRoleByID(currentSpecID)
		if ROLEMARKS[roleToken]then SetRaidTarget("player", ROLEMARKS[roleToken]) end else SetRaidTarget("player", 0) end
end)