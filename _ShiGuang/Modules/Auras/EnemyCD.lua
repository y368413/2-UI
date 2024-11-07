local _, ns = ...
local M, R, U, I = unpack(ns)
local CDS = M:GetModule("Cooldowns")
----------------------------------------------------------------------------------------
--	Enemy cooldowns(alEnemyCD by Allez)
----------------------------------------------------------------------------------------

local show = {
	none = false,
	pvp = false,
	arena = true,
}
local direction = "RIGHT"
local icons = {}
local band = bit.band
local esize = 28
local limit = (27 * 12)/esize

function CDS:EnemyCD()
  if not R.db["Misc"]["EnemyCD"] then return end
  
local EnemyCDAnchor = CreateFrame("Frame", "EnemyCDAnchor", UIParent)
if direction == "UP" or direction == "DOWN" then
	EnemyCDAnchor:SetSize(esize, (esize * 5) + 12)
else
	EnemyCDAnchor:SetSize((esize * 5) + 12, esize)
end
--EnemyCDAnchor:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 43, 210)
M.Mover(EnemyCDAnchor, U["Enemy CD"], "EnemyCDs", {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 43, 210})


local OnEnter = function(self)
	if IsShiftKeyDown() then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetSpellByID(self.sID)
		GameTooltip:SetClampedToScreen(true)
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(DONE_BY.." "..self.name)
		GameTooltip:Show()
	end
end

local function sortByExpiration(a, b)
	return a.endTime < b.endTime
end

local UpdatePositions = function()
	for i = 1, #icons do
		icons[i]:ClearAllPoints()
		if i == 1 then
			icons[i]:SetPoint("BOTTOMLEFT", EnemyCDAnchor, "BOTTOMLEFT", 0, 0)
		elseif i < limit then
			if direction == "UP" then
				icons[i]:SetPoint("BOTTOM", icons[i-1], "TOP", 0, 3)
			elseif direction == "DOWN" then
				icons[i]:SetPoint("TOP", icons[i-1], "BOTTOM", 0, -3)
			elseif direction == "RIGHT" then
				icons[i]:SetPoint("LEFT", icons[i-1], "RIGHT", 3, 0)
			elseif direction == "LEFT" then
				icons[i]:SetPoint("RIGHT", icons[i-1], "LEFT", -3, 0)
			else
				icons[i]:SetPoint("LEFT", icons[i-1], "RIGHT", 3, 0)
			end

		end
		if i < limit then
			icons[i]:SetAlpha(1)
		else
			icons[i]:SetAlpha(0)
		end
		icons[i].id = i
	end
end

local StopTimer = function(icon)
	icon:SetScript("OnUpdate", nil)
	icon:Hide()
	tremove(icons, icon.id)
	UpdatePositions()
end

local IconUpdate = function(self)
	if (self.endTime < GetTime()) then
		StopTimer(self)
	end
end

local CreateIcon = function()
	local icon = CreateFrame("Frame", nil, UIParent)
	icon:SetSize(esize, esize)
	icon:SetBackdrop({
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeSize = 0.3,
		insets = {left = -0.3, right = -0.3, top = -0.3, bottom = -0.3}
	})
	icon.Cooldown = CreateFrame("Cooldown", nil, icon, "CooldownFrameTemplate")
	icon.Cooldown:SetPoint("TOPLEFT", 2, -2)
	icon.Cooldown:SetPoint("BOTTOMRIGHT", -2, 2)
	icon.Cooldown:SetReverse(true)
	icon.Texture = icon:CreateTexture(nil, "BORDER")
	icon.Texture:SetPoint("TOPLEFT", 2, -2)
	icon.Texture:SetPoint("BOTTOMRIGHT", -2, 2)
	return icon
end

local StartTimer = function(sGUID, sID, sName)
	local _, _, texture = GetSpellInfo(sID)
	local icon = CreateIcon()
	icon.Texture:SetTexture(texture)
	icon.Texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	icon.endTime = GetTime() + R.enemy_spells[sID]
	local _, class, _, _, _, name = GetPlayerInfoByGUID(sGUID)

	-- false check for pet
	if not class then
		class = select(2, UnitClass(sName))
		name = sName
	end

	local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
	if color then
		name = format("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, name)
	end
	for _, v in pairs(icons) do
		if v.name == name and v.sID == sID then
			StopTimer(v)
		end
	end
	icon.name = name
	icon.sID = sID
	icon:Show()
	icon:SetScript("OnUpdate", IconUpdate)
	icon:SetScript("OnEnter", OnEnter)
	icon:SetScript("OnLeave", GameTooltip_Hide)
	CooldownFrame_Set(icon.Cooldown, GetTime(), R.enemy_spells[sID], 1)
	tinsert(icons, icon)
	table.sort(icons, sortByExpiration)
	UpdatePositions()
end

local OnEvent = function(_, event)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, eventType, _, sourceGUID, sourceName, sourceFlags, _, _, _, _, _, spellID = CombatLogGetCurrentEventInfo()

		if eventType == "SPELL_CAST_SUCCESS" and sourceName ~= name then
			local _, instanceType = IsInInstance()
			if show[instanceType] then
				if band(sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0 then
					if R.EnemySpells[spellID] then
						StartTimer(sourceGUID, spellID, sourceName)
					end
				end
			elseif instanceType == "party" and C.enemycooldown.show_inparty then
				if band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_PARTY) ~= 0 then
					if R.EnemySpells[spellID] then
						StartTimer(sourceGUID, spellID, sourceName)
					end
				end
			end
		end
	elseif event == "ZONE_CHANGED_NEW_AREA" then
		for _, v in pairs(icons) do
			v.endTime = 0
		end
	end
end

for spell in pairs(R.enemy_spells) do
	local name = GetSpellInfo(spell)
	if not name then
		print("|cffff0000WARNING: spell ID ["..tostring(spell).."] no longer exists! Report this to Shestak.|r")
	end
end

local addon = CreateFrame("Frame")
addon:SetScript("OnEvent", OnEvent)
addon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
addon:RegisterEvent("ZONE_CHANGED_NEW_AREA")

SlashCmdList.EnemyCD = function()
	StartTimer(UnitGUID(name), 47528)
	StartTimer(UnitGUID(name), 19647)
	StartTimer(UnitGUID(name), 47476)
	StartTimer(UnitGUID(name), 51514)
end
SLASH_EnemyCD1 = "/enemycd"
end