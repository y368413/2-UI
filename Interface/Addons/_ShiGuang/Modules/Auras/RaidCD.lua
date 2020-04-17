local _, ns = ...
local M, R, U, I = unpack(ns)
local CDS = M:RegisterModule("Cooldowns")

function CDS:OnLogin()
	self:RaidCD()
	self:PulseCD()
	self:EnemyCD()
	self:SorasThreat()
end
------------------------------------------------------------ --	Raid cooldowns --  alRaidCD by Allez, msylgj0@NGACN
local show = {
	raid = true,
	party = true,
	arena = true,
}
local bars = {}
local filter = COMBATLOG_OBJECT_AFFILIATION_RAID + COMBATLOG_OBJECT_AFFILIATION_PARTY + COMBATLOG_OBJECT_AFFILIATION_MINE
local tremove, select, tostring, floor, sformat, band = tremove, select, tostring, math.floor, string.format, bit.band
local currentNumResses, raidcd_width, raidcd_height = 0, 172, 8
local raidcd_upwards, raidcd_expiration = false,  true

function CDS:RaidCD()
  if not MaoRUIPerDB["Misc"]["RaidCD"] then return end
  
local RaidCDAnchor = CreateFrame("Frame", "RaidCDAnchor", UIParent)
RaidCDAnchor:SetSize(210, 21)
M.Mover(RaidCDAnchor, U["Raid CD"], "RaidCDs", {"RIGHT", UIParent, "RIGHT", -210, 120})

local FormatTime = function(time)
	if time >= 60 then
		return sformat("%.2d:%.2d", floor(time / 60), time % 60)
	else
		return sformat("%.2d", time)
	end
end

local function sortByExpiration(a, b)
	return a.endTime > b.endTime
end

local CreateFS = function(frame)
	local fstring = frame:CreateFontString(nil, "OVERLAY")
	fstring:SetFont(STANDARD_TEXT_FONT,11,"OUTLINE")
	fstring:SetShadowOffset(1, -1)
	return fstring
end

local UpdatePositions = function()
		for i = 1, #bars do
			bars[i]:ClearAllPoints()
			if i == 1 then
				bars[i]:SetPoint("TOPRIGHT", RaidCDAnchor, "TOPRIGHT", 0, 0)
			else
				if raidcd_upwards == true then
					bars[i]:SetPoint("BOTTOMRIGHT", bars[i-1], "TOPRIGHT", 0, 12)
				else
					bars[i]:SetPoint("TOPRIGHT", bars[i-1], "BOTTOMRIGHT", 0, -12)
				end
			end
			bars[i].id = i
		end
end

local StopTimer = function(bar)
	bar:SetScript("OnUpdate", nil)
	bar:Hide()
	tremove(bars, bar.id)
	UpdatePositions()
end

local UpdateCharges = function(bar)
	local curCharges, maxCharges, start, duration = GetSpellCharges(20484)
	if curCharges == maxCharges then
		bar.startTime = 0
		bar.endTime = GetTime()
	else
		bar.startTime = start
		bar.endTime = start + duration
	end
	if curCharges ~= currentNumResses then
		currentNumResses = curCharges
		bar.left:SetText(bar.name.." : "..currentNumResses)
	end
end

local BarUpdate = function(self)
	local curTime = GetTime()
	if self.endTime < curTime then
			StopTimer(self)
	end
	self:SetValue(100 - (curTime - self.startTime) / (self.endTime - self.startTime) * 100)
	self.right:SetText(FormatTime(self.endTime - curTime))
end

local OnEnter = function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetSpellByID(self.spellId)
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine(self.left:GetText(), self.right:GetText())
	GameTooltip:SetClampedToScreen(true)
	GameTooltip:Show()
end

local OnLeave = function()
	GameTooltip:Hide()
end

local CheckChat = function(warning)
	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
		return "INSTANCE_CHAT"
	elseif IsInRaid(LE_PARTY_CATEGORY_HOME) then
		if warning and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") or IsEveryoneAssistant()) then
			return "RAID_WARNING"
		else
			return "RAID"
		end
	elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
		return "PARTY"
	end
	return "SAY"
end

local OnMouseDown = function(self, button)
	if button == "LeftButton" then
			SendChatMessage(sformat("%s - %s: %s", self.name, GetSpellLink(self.spellId), self.right:GetText()), "YELL")
	elseif button == "RightButton" then
		StopTimer(self)
	end
end

local CreateBar = function()
	local bar = CreateFrame("Statusbar", nil, UIParent)
	bar:SetFrameStrata("MEDIUM")
	bar:SetSize(raidcd_width, raidcd_height)
	bar:SetStatusBarTexture(I.normTex)
	bar:SetMinMaxValues(0, 100)
	
	bar.backdrop = CreateFrame("Frame", nil, bar)
	bar.backdrop:SetPoint("TOPLEFT", -2, 2)
	bar.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
	M.CreateBD(bar.backdrop, 0.3)
	bar.backdrop:SetFrameStrata("BACKGROUND")

	bar.bg = bar:CreateTexture(nil, "BACKGROUND")
	bar.bg:SetAllPoints(bar)
	bar.bg:SetTexture(I.normTex)

	bar.left = CreateFS(bar)
	bar.left:SetPoint("LEFT", 2, 8)
	bar.left:SetJustifyH("LEFT")
	bar.left:SetSize(raidcd_width - 38, raidcd_height)

	bar.right = CreateFS(bar)
	bar.right:SetPoint("RIGHT", 1, 8)
	bar.right:SetJustifyH("RIGHT")
	
	bar.icon = CreateFrame("Button", nil, bar)
	bar.icon:SetWidth(bar:GetHeight() + 10)
	bar.icon:SetHeight(bar.icon:GetWidth())
	bar.icon:SetPoint("BOTTOMRIGHT", bar, "BOTTOMLEFT", -3, 0)
	bar.icon.backdrop = CreateFrame("Frame", nil, bar.icon)
	bar.icon.backdrop:SetPoint("TOPLEFT", -2, 2)
	bar.icon.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
	M.CreateBD(bar.icon.backdrop, 0.6)
	bar.icon.backdrop:SetFrameStrata("BACKGROUND")
	return bar
end

local StartTimer = function(name, spellId)
	local spell, _, icon = GetSpellInfo(spellId)
	for _, v in pairs(bars) do
		if v.name == name and v.spell == spell then
			StopTimer(v)
		end
	end
	local bar = CreateBar()
	local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass(name))]
		bar.startTime = GetTime()
		bar.endTime = GetTime() + R.RaidSpells[spellId]
		bar.left:SetText(format("%s-%s", name:gsub("%-[^|]+", ""), spell))
		bar.right:SetText(FormatTime(R.RaidSpells[spellId]))
		bar.name = name
		bar.spell = spell
		bar.spellId = spellId
		bar.icon:SetNormalTexture(icon)
		bar.icon:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
		bar:Show()
		if color then
			bar:SetStatusBarColor(color.r, color.g, color.b)
			bar.bg:SetVertexColor(color.r, color.g, color.b, 0.2)
		else
			bar:SetStatusBarColor(0.3, 0.7, 0.3)
			bar.bg:SetVertexColor(0.3, 0.7, 0.3, 0.2)
		end

		bar:SetScript("OnUpdate", BarUpdate)
		bar:EnableMouse(true)
		bar:SetScript("OnEnter", OnEnter)
		bar:SetScript("OnLeave", OnLeave)
		bar:SetScript("OnMouseDown", OnMouseDown)
		tinsert(bars, bar)
		if raidcd_expiration == true then
			table.sort(bars, sortByExpiration)
		end
	UpdatePositions()
end

local OnEvent = function(self, event)
	if event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
		if select(2, IsInInstance()) == "raid" and IsInGroup() then
			self:RegisterEvent("SPELL_UPDATE_CHARGES")
		else
			self:UnregisterEvent("SPELL_UPDATE_CHARGES")
			currentNumResses = 0
		end
	end
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, eventType, _, _, sourceName, sourceFlags = CombatLogGetCurrentEventInfo()
		if band(sourceFlags, filter) == 0 then return end
		if eventType == "SPELL_RESURRECT" or eventType == "SPELL_CAST_SUCCESS" or eventType == "SPELL_AURA_APPLIED" then
			local spellId = select(12, CombatLogGetCurrentEventInfo())
			if sourceName then
				sourceName = sourceName:gsub("-.+", "")
			else
				return
			end
			if R.RaidSpells[spellId] and show[select(2, IsInInstance())] and IsInGroup() then
				if (sourceName == UnitName("player") and raidcd_show_self == true) or sourceName ~= UnitName("player") then
					StartTimer(sourceName, spellId)
				end
			end
		end
	elseif event == "ZONE_CHANGED_NEW_AREA" and select(2, IsInInstance()) == "arena" or not IsInGroup() then
		for _, v in pairs(bars) do
			v.endTime = 0
		end
	elseif event == "ENCOUNTER_END" and select(2, IsInInstance()) == "raid" then
		for _, v in pairs(bars) do
			v.endTime = 0
		end
	end
end

for spell in pairs(R.RaidSpells) do
	if not GetSpellInfo(spell) then print("|cffff0000XXX → ["..tostring(spell).."]|r") end
end

local RaidCD = CreateFrame("Frame")
RaidCD:SetScript("OnEvent", OnEvent)
RaidCD:RegisterEvent("PLAYER_ENTERING_WORLD")
RaidCD:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
RaidCD:RegisterEvent("ZONE_CHANGED_NEW_AREA")
RaidCD:RegisterEvent("ENCOUNTER_END")

SlashCmdList.RaidCD = function()
	StartTimer(UnitName("player"), 20484)	-- Rebirth
	StartTimer(UnitName("player"), 20707)	-- Soulstone
	StartTimer(UnitName("player"), 108280)	-- Healing Tide Totem
end
SLASH_RaidCD1 = "/raidcd"
end