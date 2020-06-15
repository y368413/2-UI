local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")

--[[
	一个工具条用来替代系统的经验条、声望条、神器经验等等
]]
local format, pairs, select = string.format, pairs, select
local min, mod, floor = math.min, mod, math.floor
local MAX_PLAYER_LEVEL = MAX_PLAYER_LEVEL
local MAX_REPUTATION_REACTION = MAX_REPUTATION_REACTION
local FACTION_BAR_COLORS = FACTION_BAR_COLORS
local NUM_FACTIONS_DISPLAYED = NUM_FACTIONS_DISPLAYED
local REPUTATION_PROGRESS_FORMAT = REPUTATION_PROGRESS_FORMAT
local HONOR, LEVEL, TUTORIAL_TITLE26, SPELLBOOK_AVAILABLE_AT = HONOR, LEVEL, TUTORIAL_TITLE26, SPELLBOOK_AVAILABLE_AT
local ARTIFACT_POWER, ARTIFACT_RETIRED = ARTIFACT_POWER, ARTIFACT_RETIRED

local UnitLevel, UnitXP, UnitXPMax, GetXPExhaustion, IsXPUserDisabled = UnitLevel, UnitXP, UnitXPMax, GetXPExhaustion, IsXPUserDisabled
local GetText, UnitSex, BreakUpLargeNumbers, GetNumFactions, GetFactionInfo = GetText, UnitSex, BreakUpLargeNumbers, GetNumFactions, GetFactionInfo
local GetWatchedFactionInfo, GetFriendshipReputation, GetFriendshipReputationRanks = GetWatchedFactionInfo, GetFriendshipReputation, GetFriendshipReputationRanks
local HasArtifactEquipped, ArtifactBarGetNumArtifactTraitsPurchasableFromXP = HasArtifactEquipped, ArtifactBarGetNumArtifactTraitsPurchasableFromXP
local IsWatchingHonorAsXP, UnitHonor, UnitHonorMax, UnitHonorLevel = IsWatchingHonorAsXP, UnitHonor, UnitHonorMax, UnitHonorLevel
local C_Reputation_IsFactionParagon = C_Reputation.IsFactionParagon
local C_Reputation_GetFactionParagonInfo = C_Reputation.GetFactionParagonInfo
local C_AzeriteItem_HasActiveAzeriteItem = C_AzeriteItem.HasActiveAzeriteItem
local C_AzeriteItem_IsAzeriteItemAtMaxLevel = C_AzeriteItem.IsAzeriteItemAtMaxLevel
local C_AzeriteItem_FindActiveAzeriteItem = C_AzeriteItem.FindActiveAzeriteItem
local C_AzeriteItem_GetAzeriteItemXPInfo = C_AzeriteItem.GetAzeriteItemXPInfo
local C_AzeriteItem_GetPowerLevel = C_AzeriteItem.GetPowerLevel
local C_ArtifactUI_IsEquippedArtifactDisabled = C_ArtifactUI.IsEquippedArtifactDisabled
local C_ArtifactUI_GetEquippedArtifactInfo = C_ArtifactUI.GetEquippedArtifactInfo

function MISC:ExpBar_Update()
	local rest = self.restBar
	if rest then rest:Hide() end

	if UnitLevel("player") < MAX_PLAYER_LEVEL then
		local xp, mxp, rxp = UnitXP("player"), UnitXPMax("player"), GetXPExhaustion()
		self:SetStatusBarColor(0, .7, 1)
		self:SetMinMaxValues(0, mxp)
		self:SetValue(xp)
		self:Show()
		if rxp then
			rest:SetMinMaxValues(0, mxp)
			rest:SetValue(min(xp + rxp, mxp))
			rest:Show()
		end
		if IsXPUserDisabled() then self:SetStatusBarColor(.7, 0, 0) end
	elseif GetWatchedFactionInfo() then
		local _, standing, barMin, barMax, value, factionID = GetWatchedFactionInfo()
		local friendID, friendRep, _, _, _, _, _, friendThreshold, nextFriendThreshold = GetFriendshipReputation(factionID)
		if friendID then
			if nextFriendThreshold then
				barMin, barMax, value = friendThreshold, nextFriendThreshold, friendRep
			else
				barMin, barMax, value = 0, 1, 1
			end
			standing = 5
		elseif C_Reputation_IsFactionParagon(factionID) then
			local currentValue, threshold = C_Reputation_GetFactionParagonInfo(factionID)
			currentValue = mod(currentValue, threshold)
			barMin, barMax, value = 0, threshold, currentValue
		else
			if standing == MAX_REPUTATION_REACTION then barMin, barMax, value = 0, 1, 1 end
		end
		self:SetStatusBarColor(FACTION_BAR_COLORS[standing].r, FACTION_BAR_COLORS[standing].g, FACTION_BAR_COLORS[standing].b, .85)
		self:SetMinMaxValues(barMin, barMax)
		self:SetValue(value)
		self:Show()
	elseif IsWatchingHonorAsXP() then
		local current, barMax = UnitHonor("player"), UnitHonorMax("player")
		self:SetStatusBarColor(1, .24, 0)
		self:SetMinMaxValues(0, barMax)
		self:SetValue(current)
		self:Show()
	elseif C_AzeriteItem_HasActiveAzeriteItem() then
		local isMaxLevel = C_AzeriteItem_IsAzeriteItemAtMaxLevel()
		if isMaxLevel then
			self:Hide()
		else
			local azeriteItemLocation = C_AzeriteItem_FindActiveAzeriteItem()
			if azeriteItemLocation then
				local xp, totalLevelXP = C_AzeriteItem_GetAzeriteItemXPInfo(azeriteItemLocation)
				self:SetStatusBarColor(.9, .8, .6)
				self:SetMinMaxValues(0, totalLevelXP)
				self:SetValue(xp)
				self:Show()
			end
		end
	elseif HasArtifactEquipped() then
		if C_ArtifactUI_IsEquippedArtifactDisabled() then
			self:SetStatusBarColor(.6, .6, .6)
			self:SetMinMaxValues(0, 1)
			self:SetValue(1)
		else
			local _, _, _, _, totalXP, pointsSpent, _, _, _, _, _, _, artifactTier = C_ArtifactUI_GetEquippedArtifactInfo()
			local _, xp, xpForNextPoint = ArtifactBarGetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalXP, artifactTier)
			xp = xpForNextPoint == 0 and 0 or xp
			self:SetStatusBarColor(.9, .8, .6)
			self:SetMinMaxValues(0, xpForNextPoint)
			self:SetValue(xp)
		end
		self:Show()
	else
		self:Hide()
	end
    if C_AzeriteItem.HasActiveAzeriteItem() and UnitLevel("player") == MAX_PLAYER_LEVEL then
		local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
		local azeriteItem = Item:CreateFromItemLocation(azeriteItemLocation)
		local azeriteItemName = azeriteItem:GetItemName()
		local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(C_AzeriteItem.FindActiveAzeriteItem())
		local currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
		self.ArtifactText:SetText("|c00FF68CC"..currentLevel.."|r  "..string.format('|c00FF68CC%d%%|r',(xp)/(totalLevelXP)*100)) --.."  "..xp.."/"..totalLevelXP
	elseif C_AzeriteItem.HasActiveAzeriteItem() and UnitLevel("player") < MAX_PLAYER_LEVEL then
	    local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
		local azeriteItem = Item:CreateFromItemLocation(azeriteItemLocation)
		local azeriteItemName = azeriteItem:GetItemName()
		local xp, totalLevelXP = C_AzeriteItem.GetAzeriteItemXPInfo(C_AzeriteItem.FindActiveAzeriteItem())
		local currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
		local function showIfResting() if (IsResting("player") or FALSE) then return "+" end return "" end
        local function showRestAmount() if (GetXPExhaustion("player") or FALSE) then return math.ceil(100*(GetXPExhaustion("player")/UnitXPMax("player"))) end return "0" end
		self.ArtifactText:SetText(UnitLevel("player").."  "..math.floor(100*(UnitXP("player")/UnitXPMax("player"))) .. "%".."  |c00FF68CC"..showRestAmount().."%"..showIfResting().."|r".."    ".."|c00FF68CC"..currentLevel.."|r  "..string.format('|c00FF68CC%d%%|r',(xp)/(totalLevelXP)*100))  --.."  "..xp.."/"..totalLevelXP
	else
	    local function showIfResting() if (IsResting("player") or FALSE) then return "+" end return "" end
        local function showRestAmount() if (GetXPExhaustion("player") or FALSE) then return math.ceil(100*(GetXPExhaustion("player")/UnitXPMax("player"))) end return "0" end
		self.ArtifactText:SetText(UnitLevel("player").."  "..math.floor(100*(UnitXP("player")/UnitXPMax("player"))) .. "%".."  |c00FF68CC"..showRestAmount().."%"..showIfResting().."|r")
	end
end

function MISC:ExpBar_UpdateTooltip()
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:ClearLines()
	GameTooltip:AddLine(LEVEL.." "..UnitLevel("player"), 0,.6,1)

	if UnitLevel("player") < MAX_PLAYER_LEVEL then
		local xp, mxp, rxp = UnitXP("player"), UnitXPMax("player"), GetXPExhaustion()
		GameTooltip:AddDoubleLine(XP..":", xp.." / "..mxp.." ("..floor(xp/mxp*100).."%)", .6,.8,1, 1,1,1)
		if rxp then
			GameTooltip:AddDoubleLine(TUTORIAL_TITLE26..":", "+"..rxp.." ("..floor(rxp/mxp*100).."%)", .6,.8,1, 1,1,1)
		end
		if IsXPUserDisabled() then GameTooltip:AddLine("|cffff0000"..XP..LOCKED) end
	end

	if GetWatchedFactionInfo() then
		local name, standing, barMin, barMax, value, factionID = GetWatchedFactionInfo()
		local friendID, _, _, _, _, _, friendTextLevel, _, nextFriendThreshold = GetFriendshipReputation(factionID)
		local currentRank, maxRank = GetFriendshipReputationRanks(friendID)
		local standingtext
		if friendID then
			if maxRank > 0 then
				name = name.." ("..currentRank.." / "..maxRank..")"
			end
			if not nextFriendThreshold then
				value = barMax - 1
			end
			standingtext = friendTextLevel
		else
			if standing == MAX_REPUTATION_REACTION then
				barMax = barMin + 1e3
				value = barMax - 1
			end
			standingtext = GetText("FACTION_STANDING_LABEL"..standing, UnitSex("player"))
		end
		--GameTooltip:AddLine(" ")
		GameTooltip:AddLine(name, 0,.6,1)
		GameTooltip:AddDoubleLine(standingtext, value - barMin.." / "..barMax - barMin.." ("..floor((value - barMin)/(barMax - barMin)*100).."%)", .6,.8,1, 1,1,1)

		if C_Reputation_IsFactionParagon(factionID) then
			local currentValue, threshold = C_Reputation_GetFactionParagonInfo(factionID)
			local paraCount = floor(currentValue/threshold)
			currentValue = mod(currentValue, threshold)
			GameTooltip:AddDoubleLine("★"..paraCount, currentValue.."/"..threshold.." ("..floor(currentValue/threshold*100).."%)", .6,.8,1, 1,1,1)
		end
	end

	if IsWatchingHonorAsXP() then
		local current, barMax, level = UnitHonor("player"), UnitHonorMax("player"), UnitHonorLevel("player")
		--GameTooltip:AddLine(" ")
		GameTooltip:AddLine(HONOR, 0,.6,1)
		GameTooltip:AddDoubleLine(LEVEL.." "..level, current.." / "..barMax, .6,.8,1, 1,1,1)
	end

	if C_AzeriteItem_HasActiveAzeriteItem() then
		local azeriteItemLocation = C_AzeriteItem_FindActiveAzeriteItem()
		local azeriteItem = Item:CreateFromItemLocation(azeriteItemLocation)
		local xp, totalLevelXP = C_AzeriteItem_GetAzeriteItemXPInfo(azeriteItemLocation)
		local currentLevel = C_AzeriteItem_GetPowerLevel(azeriteItemLocation)
		local isMaxLevel = C_AzeriteItem_IsAzeriteItemAtMaxLevel()
		if not isMaxLevel then
			azeriteItem:ContinueWithCancelOnItemLoad(function()
				local azeriteItemName = azeriteItem:GetItemName()
				--GameTooltip:AddLine(" ")
				GameTooltip:AddLine(azeriteItemName.." ("..format(SPELLBOOK_AVAILABLE_AT, currentLevel)..")", 0,.6,1)
				GameTooltip:AddDoubleLine(ARTIFACT_POWER, BreakUpLargeNumbers(xp).." / "..BreakUpLargeNumbers(totalLevelXP).." ("..floor(xp/totalLevelXP*100).."%)", .6,.8,1, 1,1,1)
			end)
		end
	end

	if HasArtifactEquipped() then
		local _, _, name, _, totalXP, pointsSpent, _, _, _, _, _, _, artifactTier = C_ArtifactUI_GetEquippedArtifactInfo()
		local num, xp, xpForNextPoint = ArtifactBarGetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalXP, artifactTier)
		--GameTooltip:AddLine(" ")
		if C_ArtifactUI_IsEquippedArtifactDisabled() then
			GameTooltip:AddLine(name, 0,.6,1)
			GameTooltip:AddLine(ARTIFACT_RETIRED, .6,.8,1, 1)
		else
			GameTooltip:AddLine(name.." ("..format(SPELLBOOK_AVAILABLE_AT, pointsSpent)..")", 0,.6,1)
			local numText = num > 0 and " ("..num..")" or ""
			GameTooltip:AddDoubleLine(ARTIFACT_POWER, BreakUpLargeNumbers(totalXP)..numText, .6,.8,1, 1,1,1)
			if xpForNextPoint ~= 0 then
				local perc = " ("..floor(xp/xpForNextPoint*100).."%)"
				GameTooltip:AddDoubleLine(BreakUpLargeNumbers(xp).."/"..BreakUpLargeNumbers(xpForNextPoint)..perc, .6,.8,1, 1,1,1)
			end
		end
	end
	GameTooltip:Show()
end

function sendReport(target) 
   if GetXPExhaustion() then perRest = floor(GetXPExhaustion()/UnitXPMax("player")*100) end
   SendChatMessage("当前等级："..UnitLevel("player").."，当前经验值: "..UnitXP("player").."/"..UnitXPMax("player").." ("..floor(UnitXP("player")/UnitXPMax("player")*100).."%)"..(GetXPExhaustion() and (", 双倍经验"..perRest.."%.") or ", 无双倍经验."), target, nil, target == "whisper" and UnitName("target") or nil)
end
function sendReports() 
   if GetNumGroupMembers() > 0 or GetNumSubgroupMembers() > 0 then sendReport("PARTY")
   elseif IsInGuild() then sendReport("guild")
   else sendReport("say") end
   if UnitIsPlayer("target") and not UnitIsEnemy("player", "target") then sendReport("whisper") end
end

function MISC:SetupScript(bar)
	bar.eventList = {
		"PLAYER_XP_UPDATE",
		"PLAYER_LEVEL_UP",
		"UPDATE_EXHAUSTION",
		"PLAYER_ENTERING_WORLD",
		"UPDATE_FACTION",
		"ARTIFACT_XP_UPDATE",
		"UNIT_INVENTORY_CHANGED",
		"ENABLE_XP_GAIN",
		"DISABLE_XP_GAIN",
		"AZERITE_ITEM_EXPERIENCE_CHANGED",
		"HONOR_XP_UPDATE",
	}
	for _, event in pairs(bar.eventList) do
		bar:RegisterEvent(event)
	end
	bar:SetScript("OnEvent", MISC.ExpBar_Update)
	bar:SetScript("OnEnter", MISC.ExpBar_UpdateTooltip)
	bar:SetScript("OnLeave", M.HideTooltip)
	bar:SetScript("OnMouseUp", function(_, btn)
	  if btn == "LeftButton" then
		if not HasArtifactEquipped() then return end
		if not ArtifactFrame or not ArtifactFrame:IsShown() then SocketInventoryItem(16) else M:TogglePanel(ArtifactFrame) end
	  elseif btn == "RightButton" then
        if (UnitLevel("player") ~= MAX_PLAYER_LEVEL) then sendReports() else return end
      end
	end)
	hooksecurefunc(StatusTrackingBarManager, "UpdateBarsShown", function()
		MISC.ExpBar_Update(bar)
	end)
end

function MISC:Expbar()
	if not MaoRUIPerDB["Misc"]["ExpRep"] then return end

	local bar = CreateFrame("StatusBar", "NDuiMinimapDataBar", MinimapCluster)
	bar:SetPoint("TOP", Minimap, "BOTTOM", 0, 0)
	bar:SetSize(Minimap:GetWidth()-2*MaoRUIPerDB["Map"]["MinimapScale"], 3)
	bar:SetHitRectInsets(0, 0, 0, -10)
	M.CreateSB(bar)
	
    bar.ArtifactText=bar:CreateFontString("ShowArtifactText", "OVERLAY")
    bar.ArtifactText:SetFont("Interface\\AddOns\\_ShiGuang\\Media\\Fonts\\Infinity.ttf", 11, "OUTLINE")  --STANDARD_TEXT_FONT
    bar.ArtifactText:SetPoint("BOTTOMRIGHT", Minimap,"BOTTOMRIGHT",2, -1)  

	local rest = CreateFrame("StatusBar", nil, bar)
	rest:SetAllPoints()
	rest:SetStatusBarTexture(I.normTex)
	rest:SetStatusBarColor(0, .4, 1, .6)
	rest:SetFrameLevel(bar:GetFrameLevel() - 1)
	bar.restBar = rest

	MISC:SetupScript(bar)
end
MISC:RegisterMisc("ExpRep", MISC.Expbar)

-- Paragon reputation info
function MISC:HookParagonRep()
	local numFactions = GetNumFactions()
	local factionOffset = FauxScrollFrame_GetOffset(ReputationListScrollFrame)
	for i = 1, NUM_FACTIONS_DISPLAYED, 1 do
		local factionIndex = factionOffset + i
		local factionRow = _G["ReputationBar"..i]
		local factionBar = _G["ReputationBar"..i.."ReputationBar"]
		local factionStanding = _G["ReputationBar"..i.."ReputationBarFactionStanding"]

		if factionIndex <= numFactions then
			local factionID = select(14, GetFactionInfo(factionIndex))
			if factionID and C_Reputation_IsFactionParagon(factionID) then
				local currentValue, threshold = C_Reputation_GetFactionParagonInfo(factionID)
				if currentValue then
					local barValue = mod(currentValue, threshold)
					local factionStandingtext = "★"..floor(currentValue/threshold)

					factionBar:SetMinMaxValues(0, threshold)
					factionBar:SetValue(barValue)
					factionStanding:SetText(factionStandingtext)
					factionRow.standingText = factionStandingtext
					factionRow.rolloverText = format(REPUTATION_PROGRESS_FORMAT, BreakUpLargeNumbers(barValue), BreakUpLargeNumbers(threshold))
				end
			end
		end
	end
end

function MISC:ParagonReputationSetup()
	if not MaoRUIPerDB["Misc"]["ParagonRep"] then return end
	hooksecurefunc("ReputationFrame_Update", MISC.HookParagonRep)
end
MISC:RegisterMisc("ParagonRep", MISC.ParagonReputationSetup)