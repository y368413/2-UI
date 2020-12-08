--## Version: 9.0.28 ## Author: lteke
local InProgressMissions = {}

InProgressMissions.frame = InProgressMissions.frame or CreateFrame("Frame", nil, _G.WorldFrame)
InProgressMissions.events = InProgressMissions.events or {}

local MISSION_BUTTON_HEIGHT = 37
local MISSION_ICON_SIZE = MISSION_BUTTON_HEIGHT - 4
local MISSION_REWARD_SIZE = MISSION_BUTTON_HEIGHT * 0.78

local FORMAT_DURATION_DAYS = _G.GARRISON_DURATION_DAYS:gsub("([^|]*)|4[^:]+:([^;]+);(.*)", "%1%2%3"):gsub("%%d", "%%.1f")
local FORMAT_DURATION_HOURS = _G.GARRISON_DURATION_HOURS:gsub("([^|]*)|4[^:]+:([^;]+);(.*)", "%1%2%3"):gsub("%%d", "%%.1f")
local FORMAT_DURATION_MINUTES = _G.GARRISON_DURATION_MINUTES
local FORMAT_DURATION_SECONDS = _G.GARRISON_DURATION_SECONDS
local FORMAT_TOOLTIP_LEVEL = _G.GARRISON_MISSION_LEVEL_TOOLTIP or _G.GARRISON_BUILDING_LEVEL_LABEL_TOOLTIP
local FORMAT_TOOLTIP_ITEMLEVEL = _G.GARRISON_MISSION_LEVEL_ITEMLEVEL_TOOLTIP

local FORMAT_ICONINTEXT = "|T%s:0:0:0:0:64:64:5:59:5:59|t"
local FORMAT_LEVEL = "[%d]"
local FORMAT_REWARDNUMS = "%.1f"
local FORMAT_REWARD_DIFFICULTY = ITEM_QUALITY_COLORS[2].hex.." (%s)"..FONT_COLOR_CODE_CLOSE

local FOLLOWER_XP_THRESHOLD = 5000

local TIME_COLORS

local TITLE_COLOR_NORMAL = {0.93, 0.93, 0.9}
local TITLE_COLOR_ALT = {0.65, 0.65, 0.55}

local ORDERHALL_ADDONS = {
	["GarrisonMissionManager"] = false,
	["OrderHallCommander"] = false,
	["RENovate"] = false,
}

local GFT = Enum.GarrisonFollowerType

local TEXT_LEGION_MISSIONS = _G.EXPANSION_NAME6.." ".._G.GARRISON_MISSIONS
local TEXT_BFA_MISSIONS = _G.EXPANSION_NAME7.." ".._G.GARRISON_MISSIONS

local itemDifficulty do
	local tooltip
	local function GetItemDifficulty(id)
		if not tooltip then
			tooltip = CreateFrame("GameTooltip")
			tooltip.leftLines = {}
			for i = 1, 2 do
				local L,R = tooltip:CreateFontString(), tooltip:CreateFontString()
				L:SetFontObject(GameFontNormal)
				R:SetFontObject(GameFontNormal)
				tooltip:AddFontStrings(L,R)
				tooltip.leftLines[i] = L
			end
		end
		tooltip:SetOwner(_G.WorldFrame, "ANCHOR_NONE")
		tooltip:ClearLines()
		tooltip:SetItemByID(id)
		local text = tooltip.leftLines[2]:GetText()
		tooltip:Hide()
		return text and text:match("([^%p]+)", 11)
	end

	itemDifficulty = setmetatable({}, {__index =
		function(self, key)
			if type(key) ~= "number" then return end
			local text = GetItemDifficulty(key)
			if text then
				for i = 1, 10 do
					if text == _G["PLAYER_DIFFICULTY"..i] then
						self[key] = text
						return text
					end
				end
			end
			self[key] = false
			return false
		end
	})
end

local events = InProgressMissions.events

function InProgressMissions:InitDB()
	if type(IPMDB) ~= "table" then
		IPMDB = {}
	end
	if IPMDB.enableGarrisonMissions == nil then
		IPMDB.enableGarrisonMissions = true
	end
	if IPMDB.enableLegionMissions == nil then
		IPMDB.enableLegionMissions = IPMDB.enableGarrisonMissions
	end
	if IPMDB.enableBfaMissions == nil then
		IPMDB.enableBfaMissions = IPMDB.enableLegionMissions
	end
	if type(IPMDB.profiles) ~= "table" then
		IPMDB.profiles = {}
	end
	if type(IPMDB.ignores) ~= "table" then
		IPMDB.ignores = {}
	end
	if type(IPMDB.profiles[self.profileName]) ~= "table" then
		IPMDB.profiles[self.profileName] = {}
	end
	-- for name, missions in pairs(IPMDB.profiles) do -- back compatibility
	-- 	for i, mission in ipairs(missions) do
	-- 		if type(mission) == "table" and not mission.missionEndTime then
	-- 			mission.missionEndTime = mission.timeComplete
	-- 		end
	-- 	end
	-- end
end

function InProgressMissions:SaveInProgressMissions()
	self.saved = true
	self:InitDB()
	if C_Garrison.GetLandingPageGarrisonType() == 0 then
		IPMDB.profiles[self.profileName] = nil
		return
	end
	local profile = wipe(IPMDB.profiles[self.profileName])
	self:GetMissions(GFT.FollowerType_9_0, profile)
	self:GetMissions(GFT.FollowerType_8_0, profile)
	self:GetMissions(GFT.FollowerType_7_0, profile)
	self:GetMissions(GFT.FollowerType_6_2, profile)
	self:GetMissions(GFT.FollowerType_6_0, profile)
	if not next(profile) then
		IPMDB.profiles[self.profileName] = nil
	end
end

do
	local function GetCharName(charText)
		local name, realm = charText:match("([^%p]+)|?r?-?(.*)", 11)
		return name or _G.UNKNOWN, realm or _G.FRIENDS_LIST_REALM
	end

	local function CompareMissionName(m1, m2)
		local name1, realm1 = GetCharName(m1.charText)
		local name2, realm2 = GetCharName(m2.charText)
			if name1 == name2 then
				if realm1 == realm2 then
					if m1.missionEndTime == m2.missionEndTime then
						return m1.name < m2.name
					else
						return (m1.missionEndTime or 0) < (m2.missionEndTime or 0)
					end
				else
					return realm1 < realm2
				end
			else
				return name1 < name2
			end
	end

	local function CompareMissionTime(m1, m2)
		if (m1.followerTypeID == GFT.FollowerType_8_0) == (m2.followerTypeID == GFT.FollowerType_8_0) then
			if (m1.missionEndTime or 0) == (m2.missionEndTime or 0) then
				return CompareMissionName(m1, m2)
			else
				return (m1.missionEndTime or 0) < (m2.missionEndTime or 0)
			end
		elseif (m1.followerTypeID == GFT.FollowerType_7_0) == (m2.followerTypeID == GFT.FollowerType_7_0) then
			if (m1.missionEndTime or 0) == (m2.missionEndTime or 0) then
				return CompareMissionName(m1, m2)
			else
				return (m1.missionEndTime or 0) < (m2.missionEndTime or 0)
			end
		else
			return m1.followerTypeID > m2.followerTypeID
		end
	end

	function InProgressMissions:UpdateMissions()
		local garrisonType = C_Garrison.GetLandingPageGarrisonType()
		wipe(self.missions)
		if garrisonType == Enum.GarrisonType.Type_9_0 then
			self:GetMissions(GFT.FollowerType_9_0, self.missions, true)
		end
		if garrisonType == Enum.GarrisonType.Type_8_0 or IPMDB.enableBfaMissions or C_Garrison.IsPlayerInGarrison(Enum.GarrisonType.Type_8_0) then
			self:GetMissions(GFT.FollowerType_8_0, self.missions, true)
		end
		if garrisonType == Enum.GarrisonType.Type_7_0 or IPMDB.enableLegionMissions or C_Garrison.IsPlayerInGarrison(Enum.GarrisonType.Type_7_0) then
			self:GetMissions(GFT.FollowerType_7_0, self.missions, true)
		end
		if garrisonType == Enum.GarrisonType.Type_6_0 or IPMDB.enableGarrisonMissions or C_Garrison.IsPlayerInGarrison(Enum.GarrisonType.Type_6_0) then
			self:GetMissions(GFT.FollowerType_6_2, self.missions, true)
			self:GetMissions(GFT.FollowerType_6_0, self.missions, true)
		end
		self:UpdateInProgressTabText()
	end

	function InProgressMissions:UpdateAltMissions()
		self.altMissions = wipe(self.altMissions or {})
		for name, missions in pairs(IPMDB.profiles) do
			if name ~= self.profileName and not IPMDB.ignores[name] then
				for i, mission in ipairs(missions) do
					mission.followerTypeID = mission.followerTypeID or 0
					if mission.followerTypeID >= GFT.FollowerType_9_0 or (mission.followerTypeID == GFT.FollowerType_8_0 and IPMDB.enableBfaMissions) or (mission.followerTypeID == GFT.FollowerType_7_0 and IPMDB.enableLegionMissions) or (mission.followerTypeID < GFT.FollowerType_7_0 and IPMDB.enableGarrisonMissions) then
						if type(mission) == "table" and type(mission.charText) == "string" then
							tinsert(self.altMissions, mission)
						end
					end
				end
			end
		end
		table.sort(self.altMissions, IPMDB.sortMethod == "time" and CompareMissionTime or CompareMissionName)
		self:UpdateInProgressTabText()
	end

	local temp = {}
	function InProgressMissions:GetMissions(followerType, dest, sort)
		C_Garrison.GetInProgressMissions(temp, followerType)
		for k, mission in pairs(temp) do
			if type(mission) == "table" then
				mission.description = ""
				mission.charText = self.playerNameText.."-"..GetRealmName()
				mission.followerInfo = {}
				for i, id in ipairs(mission.followers) do
					local info = C_Garrison.GetFollowerInfo(id)
					if info then
						info.abilities = {}
						for k, ability in ipairs(C_Garrison.GetFollowerAbilities(info.followerID)) do
							tinsert(info.abilities, ability.id)
						end
						mission.followerInfo[id] = info
					end
				end
				mission.successChance = C_Garrison.GetMissionSuccessChance(mission.missionID)
			end
		end
		if sort then
			table.sort(temp, type(sort) == "function" and sort or CompareMissionTime)
		end
		for k, mission in ipairs(temp) do
			tinsert(dest, mission)
		end
	end
end

local function FormatRewardNumbers(value)
	if GetLocale() == "zhCN" or GetLocale() == "zhTW"  then
	if value > 9999 then
		value = FORMAT_REWARDNUMS:format(value / 10000)
		if string.sub(value, -3) == ".0" then
			value = string.sub(value, 1, -4)
		end
		value = value.."万"
	end
	return value
	else
		if value > 999 then
		value = FORMAT_REWARDNUMS:format(value / 1000)
		if string.sub(value, -2) == ".0" then
			value = string.sub(value, 1, -3)
		end
		value = value.."k"
	end
	return value
	end
	--return BreakUpLargeNumbers(value)
end

local function Reward_Update(Reward, info)
	Reward.bonusAbilityID = info.bonusAbilityID
	Reward.Quantity:Hide()
	Reward.IconBorder:Hide()
	Reward.Success:Hide()
	if (info.itemID) then
		Reward.itemID = info.itemID
		local itemTexture = select(10, GetItemInfo(info.itemID))
		Reward.Icon:SetTexture(itemTexture)
		if ( info.quantity > 1 ) then
			Reward.Quantity:SetText(info.quantity)
			Reward.Quantity:Show()
		else
			local quality, itemLevel = select(3, GetItemInfo(info.itemID))
			if ( itemLevel and itemLevel > 500 ) then
				--local text = itemLevel > 500 and itemLevel or itemDifficulty[info.itemID]
				--if text then
				--	Reward.Quantity:SetText(ITEM_QUALITY_COLORS[quality].hex..text..FONT_COLOR_CODE_CLOSE)
				--	Reward.Quantity:Show()
				--end
				Reward.Quantity:SetText(ITEM_QUALITY_COLORS[quality].hex..itemLevel..FONT_COLOR_CODE_CLOSE)
				Reward.Quantity:Show()
			end
		end
		--Reward.tooltip = nil
		local quality = select(3, GetItemInfo(info.itemID))
		if quality and quality > 1 then
			local c = ITEM_QUALITY_COLORS[quality]
			Reward.IconBorder:SetVertexColor(c.r, c.g, c.b)
			Reward.IconBorder:Show()
		end
	else
		Reward.itemID = nil
		Reward.Icon:SetTexture(info.icon)
		Reward.title = info.title
		if (info.currencyID and info.quantity) then
			if (info.currencyID == 0) then
				Reward.tooltip = GetMoneyString(info.quantity)
				Reward.Quantity:SetText(BreakUpLargeNumbers(math.floor(info.quantity / COPPER_PER_GOLD)))
				Reward.Quantity:Show()
			else
				local currencyTexture = C_CurrencyInfo.GetBasicCurrencyInfo(info.currencyID).icon
				Reward.tooltip = BreakUpLargeNumbers(info.quantity).." |T"..currencyTexture..":0:0:0:-1|t "
				Reward.Quantity:SetText(info.quantity)
				Reward.Quantity:Show()
			end
		elseif (info.bonusAbilityID) then
			Reward.bonusAbilityID = info.bonusAbilityID
			Reward.bonusAbilityDuration = info.duration
			Reward.bonusAbilityIcon = info.icon
			Reward.bonusAbilityName = info.name
			Reward.bonusAbilityDescription = info.description
		else
			Reward.tooltip = info.tooltip
			if ( info.followerXP ) then
				Reward.Quantity:SetText(ITEM_QUALITY_COLORS[info.followerXP >= FOLLOWER_XP_THRESHOLD and 2 or 1].hex..FormatRewardNumbers(info.followerXP)..FONT_COLOR_CODE_CLOSE)
				Reward.Quantity:Show()
			end
		end
	end
end

local function Rewards_Update(button, item)
	local rewardIndex = 0
	if item.overmaxRewards and item.hasBonusEffect then
		if item.successChance and item.successChance > 100 then
			for rewardId, reward in pairs(item.overmaxRewards) do
				rewardIndex = rewardIndex + 1
				local Reward = button.Rewards[rewardIndex]
				Reward_Update(Reward, reward)
				Reward.Success:SetFormattedText("%d%%", item.successChance - 100)
				Reward.Success:Show()
				Reward:Show()
				-- Reward:SetAlpha((item.successChance - 100) / 100)
			end
		end
	end
	if item.rewards then
		for rewardId, reward in pairs(item.rewards) do
			rewardIndex = rewardIndex + 1
			local Reward = button.Rewards[rewardIndex]
			Reward_Update(Reward, reward)
			Reward:Show()
			-- Reward:SetAlpha(1)
		end
	end
	for i = (rewardIndex + 1), #button.Rewards do
		button.Rewards[i]:Hide()
	end
	return rewardIndex
end

local function GetFollowerIndicator(item)
	if not item.numFollowers then return end
	local result = ""
	local id, info
	for i = 1, item.numFollowers do
		id = item.followers[i]
		info = nil
		if id and type(item.followerInfo) == "table" then
			info = item.followerInfo[id]
		elseif id then
			info = C_Garrison.GetFollowerInfo(id)
		end
		if info and info.quality ~= 4 and not info.isTroop then
			result = result..ITEM_QUALITY_COLORS[info.quality or 1].hex.._G.RANGE_INDICATOR..FONT_COLOR_CODE_CLOSE
		else
			result = result.._G.RANGE_INDICATOR
		end
	end
	return result
end

local function GarrisonLandingPageReportList_Update(...)

	local items = InProgressMissions.missions
	local numItems = #items
	local scrollFrame = InProgressMissions.listScroll
	local offset = HybridScrollFrame_GetOffset(scrollFrame)
	local buttons = scrollFrame.buttons
	local numButtons = #buttons

	local stopUpdate = true

	if (numItems == 0 and #InProgressMissions.altMissions == 0) then
		GarrisonLandingPageReport.List.EmptyMissionText:SetText(GARRISON_EMPTY_IN_PROGRESS_LIST)
	else
		GarrisonLandingPageReport.List.EmptyMissionText:SetText(nil)
	end

	local baseTime = GetServerTime()
	local button, index, item, altMissionIndex, t
	for i = 1, numButtons do
		button = buttons[i]
		index = offset + i
		item = items[index]

		if item then
			altMissionIndex = nil
			if item.missionEndTime then
				item.isComplete = (item.missionEndTime - baseTime) < 0
			end
		else
			altMissionIndex = index - numItems
			item = InProgressMissions.altMissions[altMissionIndex]
			if item and item.missionEndTime then
				item.isComplete = (item.missionEndTime - baseTime) < 0
			end
		end

		if ( item ) then
			button.id = altMissionIndex and -altMissionIndex or index
			local bgName
			if (item.isBuilding) then
				bgName = "GarrLanding-Building-"
				button.Status:SetText(GARRISON_LANDING_STATUS_BUILDING)
			elseif (item.followerTypeID == GFT.FollowerType_6_2) then
				bgName = "GarrLanding-ShipMission-"
			else
				bgName = "GarrLanding-Mission-"
				button.Status:SetText(nil)
			end
			button.Title:SetText(item.name)

			if (item.isComplete) then
				bgName = bgName.."Complete"
				--button.MissionType:SetText(GARRISON_LANDING_BUILDING_COMPLEATE)
				--button.MissionType:SetTextColor(YELLOW_FONT_COLOR.r, YELLOW_FONT_COLOR.g, YELLOW_FONT_COLOR.b)
				if item.isBuilding then
					button.MissionType:SetText(GARRISON_LANDING_BUILDING_COMPLEATE)
				else
					button.MissionType:SetText(altMissionIndex and (item.charText or _G.UNKNOWN) or InProgressMissions.playerNameText)
				end
				button.Title:SetWidth(290)
			else
				bgName = bgName.."InProgress"
				--button.MissionType:SetTextColor(GARRISON_MISSION_TYPE_FONT_COLOR.r, GARRISON_MISSION_TYPE_FONT_COLOR.g, GARRISON_MISSION_TYPE_FONT_COLOR.b)
				if (item.isBuilding) then
					button.MissionType:SetText(GARRISON_BUILDING_IN_PROGRESS.." - "..GARRISON_BUILDING_LEVEL_LABEL_TOOLTIP:format(item.buildingLevel))
					button.TimeLeft:SetText(item.timeLeft)
					button.TimeLeft:SetTextColor(unpack(TIME_COLORS[4]))
				else
					button.MissionType:SetText(altMissionIndex and (item.charText or _G.UNKNOWN) or InProgressMissions.playerNameText)
					t = item.missionEndTime - baseTime
					if t > 107999 then -- 30hr
						button.TimeLeft:SetFormattedText(FORMAT_DURATION_DAYS, t / 86400)
					elseif t > 5459 then
						button.TimeLeft:SetFormattedText(FORMAT_DURATION_HOURS, t / 3600)
					elseif t > 59 then
						button.TimeLeft:SetFormattedText(FORMAT_DURATION_MINUTES, t / 60)
					else
						button.TimeLeft:SetFormattedText(FORMAT_DURATION_SECONDS, t)
					end
					button.TimeLeft:SetTextColor(unpack(TIME_COLORS[not t and 1 or t > 18000 and 2 or t > 5459 and 3 or t > 599 and 4 or t > 59 and 5 or 6]))
				end
				button.Title:SetWidth(322 - button.TimeLeft:GetWidth())
				stopUpdate = false
			end
			if item.followerTypeID == GFT.FollowerType_8_0 then
				button.Level:SetText(item.level)
			elseif item.followerTypeID == GFT.FollowerType_9_0 then
				button.Level:SetText(nil)
			else
				button.Level:SetText(item.iLevel and item.iLevel > 0 and item.iLevel or item.followerTypeID ~= GFT.FollowerType_6_2 and item.level or nil)
			end
			if item.typeAtlas then
				button.MissionTypeIcon:SetAtlas(item.typeAtlas)
			elseif item.typeIcon then
				button.MissionTypeIcon:SetTexture(item.typeIcon)
			else
				button.MissionTypeIcon:SetTexture(nil)
			end
			button.MissionTypeIcon:SetShown(not item.isBuilding and item.followerTypeID < GFT.FollowerType_9_0)
			--button.NumFollowers:SetText(item.numFollowers and string.rep(RANGE_INDICATOR, item.numFollowers) or nil)
			if item.followerTypeID == GFT.FollowerType_9_0 then
				button.NumFollowers:Hide()
			else
				button.NumFollowers:SetText(GetFollowerIndicator(item))
				button.NumFollowers:Show()
			end
			button.EncounterIcon:SetShown(item.followerTypeID == GFT.FollowerType_9_0)
			if item.followerTypeID == GFT.FollowerType_9_0 then
				button.EncounterIcon:SetEncounterInfo(C_Garrison.GetMissionEncounterIconInfo(item.missionID))
			end
			button.Status:SetShown(item.isBuilding and not item.isComplete)
			button.TimeLeft:SetShown(not item.isComplete)

			button.BG:SetAtlas(bgName, true)
			if altMissionIndex then
				button.Title:SetTextColor(unpack(TITLE_COLOR_ALT))
				button.Level:SetTextColor(unpack(TITLE_COLOR_ALT))
			else
				button.Title:SetTextColor(unpack(TITLE_COLOR_NORMAL))
				button.Level:SetTextColor(unpack(TITLE_COLOR_NORMAL))
			end
			if item.followerTypeID == GFT.FollowerType_6_2 then
				button.BG:SetVertexColor(0.9, 0.9, 1)
			else
				button.BG:SetVertexColor(1, 1, 1)
			end
			Rewards_Update(button, item)

			button:Show()
		else
			button:Hide()
		end
	end

	local totalHeight = (numItems + #InProgressMissions.altMissions) * scrollFrame.buttonHeight
	local displayedHeight = numButtons * scrollFrame.buttonHeight
	HybridScrollFrame_Update(scrollFrame, totalHeight, displayedHeight)

	return stopUpdate
end

local function ScrollFrame_UpdateAvailable(...)
	local items = GarrisonLandingPageReport.List.AvailableItems or {}
	local item
	local rewardIndex
	for i, button in ipairs(InProgressMissions.listScroll.buttons) do
		if items[button.id] and button:IsShown() then
			item = items[button.id]
			button.Title:SetTextColor(unpack(TITLE_COLOR_NORMAL))
			button.Level:SetTextColor(unpack(TITLE_COLOR_NORMAL))
			button.MissionTypeIcon:ClearAllPoints()
			button.MissionTypeIcon:SetPoint("LEFT", button, 2, 0)
			button.MissionTypeIcon:SetSize(MISSION_ICON_SIZE, MISSION_ICON_SIZE)
			button.BG:SetVertexColor(1, 1, 1)
			if item.followerTypeID == GFT.FollowerType_8_0 then
				button.Level:SetText(item.level)
			elseif item.followerTypeID == GFT.FollowerType_9_0 then
				button.Level:SetText(nil)
			else
				button.Level:SetText(item.followerTypeID ~= GFT.FollowerType_9_0 and item.iLevel and item.iLevel > 0 and item.iLevel or item.followerTypeID ~= GFT.FollowerType_6_2 and item.level or nil)
			end
			if item.followerTypeID == GFT.FollowerType_9_0 then
				button.NumFollowers:SetText(nil)
			else
				button.NumFollowers:SetText(item.numFollowers and string.rep(RANGE_INDICATOR, item.numFollowers) or nil)
			end
			rewardIndex = Rewards_Update(button, item) or 1
			if rewardIndex < 0 then
				rewardIndex = 1
			end
			button.Status:SetPoint("BOTTOMRIGHT", button.Rewards[rewardIndex], "BOTTOMLEFT", -4, 0)
			if _G.MasterPlan then
				button.Status:Hide()
			else
				button.Status:SetText(item.offerEndTime and RAID_INSTANCE_EXPIRES:format(item.offerTimeRemaining) or nil)
				button.Status:Show()
			end
		end
	end
end

local function ScrollFrame_UpdateItems()
	InProgressMissions:UpdateMissions()
	local isTabProgress = GarrisonLandingPageReport.selectedTab == GarrisonLandingPageReport.InProgress
	for k, button in pairs(InProgressMissions.listScroll.buttons) do
		button.MissionTypeIcon:ClearAllPoints()
		button.MissionTypeIcon:SetPoint("LEFT", button, 2, 0)
		button.MissionTypeIcon:SetSize(MISSION_ICON_SIZE, MISSION_ICON_SIZE)
		for i = 1, #button.Rewards do
			button.Rewards[i]:ClearAllPoints()
			if i == 1 then
				button.Rewards[i]:SetPoint("RIGHT", isTabProgress and -68 or -5, -0)
			else
				button.Rewards[i]:SetPoint("RIGHT", button.Rewards[i - 1], "LEFT", - MISSION_REWARD_SIZE / 11, 0)
			end
		end
		if isTabProgress then
			button.Status:SetPoint("BOTTOMRIGHT", -8, 3)
		end
	end
	if isTabProgress then
		GarrisonLandingPageReportList_Update()
	else
		InProgressMissions:HideMenu()
	end
end

local function MakeIcon(icon, rightText)
	local result = FORMAT_ICONINTEXT:format(icon or 134400)
	if rightText then
		return result.." "..rightText
	else
		return result
	end
end

local function AddIcon(text1, icon, text2)
	if text1 then
		return text1.." "..MakeIcon(icon, text2)
	else
		return MakeIcon(icon, text2)
	end
end

local function QualityColorText(text, quality)
	if quality then
		return ITEM_QUALITY_COLORS[quality].hex..text..FONT_COLOR_CODE_CLOSE
	else
		return text
	end
end

local function AddRewardText(item, rewardType)
		for id, reward in pairs(item[rewardType]) do
			if (reward.quality) then
				GameTooltip:AddLine(QualityColorText(reward.title or _G.UNKNOWN, reward.quality + 1))
			elseif (reward.itemID) then
				local itemName, _, itemQuality, _, _, _, _, _, _, itemTexture = GetItemInfo(reward.itemID)
				if itemName then
					itemName = MakeIcon(itemTexture, QualityColorText(itemName, itemQuality))
					local difficulty = itemDifficulty[reward.itemID]
					if difficulty then
						itemName = itemName..FORMAT_REWARD_DIFFICULTY:format(difficulty)
					end
					local quantity = reward.quantity and reward.quantity > 1 and FLAG_COUNT_TEMPLATE:format(reward.quantity) or ""
					if quantity then
						itemName = itemName.." "..quantity
					end
					GameTooltip:AddLine(itemName, 1, 1, 1)
				end
			elseif (reward.followerXP) then
				GameTooltip:AddLine(QualityColorText(GARRISON_REWARD_XP_FORMAT:format(BreakUpLargeNumbers(reward.followerXP)), reward.followerXP >= FOLLOWER_XP_THRESHOLD and 2 or 1))
			elseif (reward.currencyID and reward.quantity) then
				if (reward.currencyID == 0) then
					GameTooltip:AddLine(GetMoneyString(reward.quantity), 1, 1, 1)
				else
					local currencyTexture = C_CurrencyInfo.GetBasicCurrencyInfo(reward.currencyID).icon
					GameTooltip:AddLine(AddIcon(BreakUpLargeNumbers(reward.quantity), currencyTexture), 1, 1, 1)
				end
			else
				GameTooltip:AddLine(reward.title, 1, 1, 1)
			end
		end
end

local function SetupMissionInfoTooltip(item, isAltMission, anchorFrame)

	if anchorFrame then
		GameTooltip:SetOwner(anchorFrame, "ANCHOR_BOTTOMRIGHT", 2, anchorFrame:GetHeight() * 2)
	else
		GameTooltip:ClearLines()
	end

	if ( item.isBuilding ) then
		GameTooltip:SetText(item.name)
		GameTooltip:AddLine(GARRISON_BUILDING_LEVEL_LABEL_TOOLTIP:format(item.buildingLevel), 1, 1, 1)
		if(item.isComplete) then
			GameTooltip:AddLine(COMPLETE, 1, 1, 1)
		else
			GameTooltip:AddLine(tostring(item.timeLeft), 1, 1, 1)
		end
		GameTooltip:Show()
		return
	end

	local isAutoCombatant = item.followerTypeID == GFT.FollowerType_9_0 -- Shadowlands

	GameTooltip:SetText(item.isComplete and ERR_QUEST_OBJECTIVE_COMPLETE_S:format(item.name) or item.name)
	-- level
	local color = item.isRare and ITEM_QUALITY_COLORS[3] or ITEM_QUALITY_COLORS[1]
	if isAutoCombatant then
		GameTooltip:AddLine(format(FORMAT_TOOLTIP_LEVEL, item.missionScalar), color.r, color.g, color.b)
	elseif item.followerTypeID == GFT.FollowerType_6_2 then

	else
		if item.iLevel and item.iLevel > 0 then
			GameTooltip:AddLine(format(FORMAT_TOOLTIP_ITEMLEVEL, item.level, item.iLevel), color.r, color.g, color.b)
		elseif item.level then
			GameTooltip:AddLine(format(FORMAT_TOOLTIP_LEVEL, item.level), color.r, color.g, color.b)
		end
	end
	-- time
	if item.isComplete then
		if item.missionEndTime then
			GameTooltip:AddLine(DATE_COMPLETED:format(date("%a,%H:%M", item.missionEndTime)), 1, 1, 1)
		end
	else
		if item.missionEndTime then
			GameTooltip:AddLine(COMPLETE..": "..date("%a,%H:%M", item.missionEndTime), 1, 1, 1)
		end
	end

	local successChance = item.successChance or item.missionID and C_Garrison.GetMissionSuccessChance(item.missionID)

	GameTooltip:AddLine(" ")
	local caption = REWARDS
	if not isAutoCombatant and successChance then
		caption = caption..(" (%d%%)"):format(math.min(successChance, 100))
	end
	GameTooltip:AddLine(caption)
	AddRewardText(item, "rewards")

	if item.overmaxRewards and item.hasBonusEffect then
		local caption = BONUS_REWARDS
		if successChance and successChance > 100 then
			caption = caption..(" (%d%%)"):format(successChance - 100)
		end
		GameTooltip:AddLine(caption)
		AddRewardText(item, "overmaxRewards")
	end

	if (item.followers ~= nil) then
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine(isAutoCombatant and _G.COVENANT_MISSIONS_FOLLOWERS or item.followerTypeID == GFT.FollowerType_6_2 and _G.GARRISON_SHIPYARD_FOLLOWERS or _G.GARRISON_FOLLOWERS)
		local id, info
		local leftText, rightText
		local icon
		for i = 1, #(item.followers) do
			id = item.followers[i]
			if isAltMission then
				info = type(item.followerInfo) == "table" and item.followerInfo[id]
			else
				info = C_Garrison.GetFollowerInfo(id)
				if info then
					info.abilities = {}
					if isAutoCombatant then
						info.abilities = C_Garrison.GetFollowerAutoCombatSpells(info.followerID, info.level or 1)
					else
						for k, ability in ipairs(C_Garrison.GetFollowerAbilities(info.followerID)) do
							tinsert(info.abilities, ability.id)
						end
					end
				end
			end
			if type(info) == "table" then
				leftText = nil
				rightText = nil
				if isAutoCombatant then
					leftText = MakeIcon(info.portraitIconID)..QualityColorText(FORMAT_LEVEL:format(info.level), info.quality or 2).." "..info.name
					for i, autoSpell in ipairs(info.abilities) do
						if autoSpell.icon then
							rightText = AddIcon(rightText, autoSpell.icon)
						end
					end
				elseif (info.followerTypeID >= GFT.FollowerType_7_0) and info.abilities then
					leftText = MakeIcon(info.portraitIconID)
					if info.isTroop then
						leftText = leftText.." "..QualityColorText(info.name, info.quality)
					else
						if info.iLevel then
							leftText = leftText..QualityColorText(FORMAT_LEVEL:format(info.iLevel), info.quality or 2)
						end
						leftText = AddIcon(leftText, C_Garrison.GetFollowerAbilityIcon(info.abilities[1]), info.name)
					end
					for i = 2, 6 do
						if info.abilities[i] then
							icon = C_Garrison.GetFollowerAbilityIcon(info.abilities[i])
							if icon then
								rightText = AddIcon(rightText, icon)
							end
						end
					end
				elseif info.followerTypeID == GFT.FollowerType_6_2 then
					leftText = ""
					if type(info.abilities) == "table" then
						for k, abilityID in ipairs(info.abilities) do
							if C_Garrison.GetFollowerAbilityIsTrait(abilityID) then
								leftText = leftText..MakeIcon(C_Garrison.GetFollowerAbilityIcon(abilityID))
							else
								rightText = AddIcon(rightText, C_Garrison.GetFollowerAbilityIcon(abilityID))
							end
						end
					end
					leftText = leftText.." "..QualityColorText(info.name, info.quality or 2)
				else
					leftText = MakeIcon(info.portraitIconID)..QualityColorText(FORMAT_LEVEL:format(info.iLevel or info.level or 0), info.quality or 2).." "..info.name
					if type(info.abilities) == "table" then
						for k, abilityID in ipairs(info.abilities) do
							if type(abilityID) == "number" and not C_Garrison.GetFollowerAbilityIsTrait(abilityID) then
								rightText = MakeIcon(select(3, C_Garrison.GetFollowerAbilityCounterMechanicInfo(abilityID)), rightText)
							end
						end
					end
				end
				GameTooltip:AddDoubleLine(leftText or _G.UNKNOWN, rightText or "", 1, 1, 1, 1, 1, 1)
			else
				GameTooltip:AddLine(_G.UNKNOWN.."."..id, 1, 1, 1)
			end
		end
	end
	GameTooltip:Show();
end

local function GarrisonLandingPageReportMission_OnEnter(self, button)
	if GarrisonLandingPageReport.selectedTab ~= GarrisonLandingPageReport.InProgress then
		return InProgressMissions.GarrisonLandingPageReportMission_OnEnter(self, button)
	end

	if not self.id then return end

	local missionInfo
	local isAltMission = self.id < 0
	if isAltMission then
		missionInfo = InProgressMissions.altMissions[-self.id]
	else
		missionInfo = InProgressMissions.missions[self.id]
	end

	if missionInfo then
		SetupMissionInfoTooltip(missionInfo, isAltMission, self)
	end
end

local function GarrisonMissionButton_SetInProgressTooltip(missionInfo, showRewards)
	SetupMissionInfoTooltip(missionInfo)
end

local function GarrisonLandingPageReportMission_OnClick(self, button)
	if GarrisonLandingPageReport.selectedTab ~= GarrisonLandingPageReport.InProgress then
		-- return InProgressMissions.GarrisonLandingPageReportMission_OnClick(self, button)
		return
	end

	if button ~= "RightButton" then
		--return self.id > 0 and InProgressMissions.GarrisonLandingPageReportMission_OnClick(self, button)
		local item = InProgressMissions.missions[self.id]
		if item and item.missionID then
			if IsModifiedClick("CHATLINK") then
				local missionLink = C_Garrison.GetMissionLink(item.missionID)
				if missionLink then
					ChatEdit_InsertLink(missionLink)
					return
				end
			else
				C_Garrison.CastSpellOnMission(item.missionID)
			end
		end
	else
		InProgressMissions:CreateMenu()
		local anchor = InProgressMissions.listScroll
		local uiScale, x, y = _G.UIParent:GetEffectiveScale(), GetCursorPosition()
		x, y = x / uiScale - anchor:GetLeft() - 35, y / uiScale - anchor:GetBottom() - 5
		ToggleDropDownMenu(1, nil, InProgressMissions.menu, anchor:GetName(), x, y)
	end
end

local function FlipTexture(texture, horizontal)
    local ULx,ULy,LLx,LLy,URx,URy,LRx,LRy = texture:GetTexCoord()
    if horizontal then
        texture:SetTexCoord(URx, URy, LRx, LRy, ULx, ULy, LLx, LLy)
    else
        texture:SetTexCoord(LLx, LLy,ULx, ULy, LRx, LRy, URx, URy)
    end
end

--local function ListScroll_OnScroll(self)
--	if GameTooltip:IsVisible() then
--		GameTooltip:Hide()
--		for k, button in pairs(InProgressMissions.listScroll.buttons) do
--			if button:IsVisible() and button:IsMouseOver() then
--				GarrisonLandingPageReportMission_OnEnter(button)
--				break
--			end
--		end
--	end
--end

local function CreateQuantityFont()
	if not _G.GarrisonReportFontRewardQuantity then
		local font = CreateFont("GarrisonReportFontRewardQuantity")
		local name, height, flags = _G.NumberFontNormalSmall:GetFont()
		if flags then
			local t = {}
			for w in string.gmatch(flags, "%s*(%a+),?") do
				if w ~= "MONOCHROME" then tinsert(t, w) end
			end
			flags = table.concat(t, ", ")
		end
		font:SetFont(name, 11.5, flags)
	end
end

local function UpdateItemInfoHandler(self)
	if InProgressMissions.listScroll:IsVisible() then
		InProgressMissions:RegisterEvent("GET_ITEM_INFO_RECEIVED")
	else
		InProgressMissions:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
	end
end

function InProgressMissions:UpdateInProgressTabText()
	if _G.GarrisonLandingPageReport then
		local text = GarrisonLandingPageReport.InProgress.Text
		text:SetText((_G.GARRISON_LANDING_IN_PROGRESS.." (%d)"):format(#self.missions, #self.altMissions))
	end
end

function InProgressMissions:Refresh()
	if _G.GarrisonLandingPageReport then
		ScrollFrame_UpdateItems()
	end
end

function InProgressMissions:MissionButton_SetStyle()
	CreateQuantityFont()
	for k, button in pairs(self.listScroll.buttons) do
		if type(button) == "table" and button:GetObjectType() == "Button" then
			button:SetHeight(MISSION_BUTTON_HEIGHT)
		end
	end
	HybridScrollFrame_CreateButtons(self.listScroll, "GarrisonLandingPageReportMissionTemplate", 0, 0)
	for k, button in pairs(self.listScroll.buttons) do
		if type(button) == "table" and button:GetObjectType() == "Button" then
			button:SetHeight(MISSION_BUTTON_HEIGHT)
			button.Title:SetFontObject("GameFontHighlightMed2")
			button.Title:SetPoint("TOPLEFT", 42, -3.5)
			button.MissionType:ClearAllPoints()
			button.MissionType:SetPoint("BOTTOMLEFT", 61, 4)
			button.MissionType:SetTextColor(GARRISON_MISSION_TYPE_FONT_COLOR.r, GARRISON_MISSION_TYPE_FONT_COLOR.g, GARRISON_MISSION_TYPE_FONT_COLOR.b)
			button.MissionTypeIcon:ClearAllPoints()
			button.MissionTypeIcon:SetPoint("LEFT", button, 2, 0)
			button.MissionTypeIcon:SetSize(MISSION_ICON_SIZE, MISSION_ICON_SIZE)
			button.MissionTypeIcon:SetAlpha(0.7)
			button.MissionTypeBG = button:CreateTexture(nil, "BACKGROUND", "Spellbook-TextBackground", 1)
			button.MissionTypeBG:ClearAllPoints()
			button.MissionTypeBG:SetPoint("TOPLEFT", button.MissionType, -5, 4)
			button.MissionTypeBG:SetPoint("BOTTOMLEFT", button.MissionType, -5, -2)
			button.MissionTypeBG:SetWidth(130)
			button.MissionTypeBG:SetBlendMode("BLEND")
			button.MissionTypeBG:SetVertexColor(0, 0, 0, 0.6)
			FlipTexture(button.MissionTypeBG)
			button.EncounterIcon:ClearAllPoints()
			button.EncounterIcon:SetPoint("LEFT", button, 5, 0)
			button.EncounterIcon:SetScale(0.9)
			button.TimeLeft:SetFontObject("GameFontNormalMed2")
			button.TimeLeft:SetPoint("TOPRIGHT", -3, -4)
			button.BG:ClearAllPoints()
			button.BG:SetPoint("TOPLEFT", button, 0, 0)
			button.BG:SetPoint("BOTTOMRIGHT", button, 0, 0.725)
			for i = 1, #button.Rewards do
				button.Rewards[i]:SetSize(MISSION_REWARD_SIZE, MISSION_REWARD_SIZE)
				button.Rewards[i].Icon:SetSize(MISSION_REWARD_SIZE * 0.92, MISSION_REWARD_SIZE * 0.92)
				for j, r in pairs({button.Rewards[i]:GetRegions()}) do
					if r:GetObjectType() == "Texture" and r:GetAtlas() then
						r:SetSize(MISSION_REWARD_SIZE * 1.1, MISSION_REWARD_SIZE * 1.1)
					end
				end
				button.Rewards[i].Quantity:SetFontObject("GarrisonReportFontRewardQuantity")
				button.Rewards[i].Quantity:ClearAllPoints()
				button.Rewards[i].Quantity:SetPoint("BOTTOMRIGHT", button.Rewards[i].Icon, 2, -1)
				button.Rewards[i].Quantity:SetJustifyH("RIGHT")
				button.Rewards[i].IconBorder:ClearAllPoints()
				button.Rewards[i].IconBorder:SetPoint("TOPLEFT", 1, -1)
				button.Rewards[i].IconBorder:SetPoint("BOTTOMRIGHT", -1, 1)
				button.Rewards[i].Success = button.Rewards[i]:CreateFontString(nil, "ARTWORK", "GarrisonReportFontRewardQuantity")
				button.Rewards[i].Success:SetPoint("TOPLEFT", -2, 2)
				button.Rewards[i].Success:SetTextColor(0.9, 0.9, 0.9)
			end
			if not button.Level then
				button.Level = button:CreateFontString(nil, "ARTWORK", "GameFontHighlightMed2")
				-- button.Level:SetPoint("TOP", button.MissionTypeIcon, 0, -4)
				button.Level:SetPoint("CENTER", button.MissionTypeIcon, 0, 2)
				button.Level:SetTextColor(unpack(TITLE_COLOR_NORMAL))
			end
			if not button.NumFollowers then
				button.NumFollowers = button:CreateFontString(nil, "ARTWORK", "FriendsFont_UserText")
				button.NumFollowers:SetPoint("BOTTOM", button.MissionTypeIcon, 0, 3)
				button.NumFollowers:SetTextColor(button.Title:GetTextColor())
				button.NumFollowers:SetAlpha(0.7)
			end
			button.Status:SetPoint("BOTTOMRIGHT", -8, 3)
			button:SetScript("OnEnter", GarrisonLandingPageReportMission_OnEnter)
			button:SetScript("OnClick", GarrisonLandingPageReportMission_OnClick)
			button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		end
	end
end

do
	function InProgressMissions:HideMenu()
		if _G.UIDROPDOWNMENU_OPEN_MENU == InProgressMissions.menu then
			--GameTooltip:Hide()
			CloseDropDownMenus()
		end
	end

	local function IgnoreProfile_OnClick(self, name, arg2, checked)
		InProgressMissions:HideMenu()

		if name then
			IPMDB.ignores[name] = not checked or nil
			InProgressMissions:UpdateAltMissions()
		end
	end

	local function SortMethod_OnClick(self, name)
		InProgressMissions:HideMenu()

		if name then
			IPMDB.sortMethod = name
			InProgressMissions:UpdateAltMissions()
		end
	end

	local function ResetProfiles()
		IPMDB.sortMethod = nil
		wipe(IPMDB.ignores)
		wipe(IPMDB.profiles)
		InProgressMissions:UpdateAltMissions()
	end

	local function Reset_OnClick(self)
		if not _G.StaticPopupDialogs["InProgressMissions_CONFIRM_RESET"] then
			_G.StaticPopupDialogs["InProgressMissions_CONFIRM_RESET"] = {
				text = CONFIRM_CONTINUE,
				button1 = _G.YES,
				button2 = _G.CANCEL,
				OnAccept = ResetProfiles,
				hideOnEscape = true,
				timeout = 30,
				whileDead = true,
			}
		end
		StaticPopup_Show("InProgressMissions_CONFIRM_RESET")
	end

	local function ToggleGarrisonMissions(self)
		IPMDB.enableGarrisonMissions = not IPMDB.enableGarrisonMissions
		InProgressMissions:UpdateAltMissions()
		InProgressMissions:Refresh()
	end

	local function ToggleLegionMissions(self)
		IPMDB.enableLegionMissions = not IPMDB.enableLegionMissions
		InProgressMissions:UpdateAltMissions()
		InProgressMissions:Refresh()
	end

	local function ToggleBfaMissions(self)
		IPMDB.enableBfaMissions = not IPMDB.enableBfaMissions
		InProgressMissions:UpdateAltMissions()
		InProgressMissions:Refresh()
	end

	function InProgressMissions:CreateMenu()
		if self.menu then return end
		self.menu = CreateFrame("Frame", "InProgressMissionsDropDownList")
		self.menu.displayMode = "MENU"
		local info = {}

		self.menu.initialize = function(self, level)
			if not level then return end
			GameTooltip:Hide()
			wipe(info)
			if level == 1 then
				info.isTitle = true
				info.text = "In Progress Missions"
				info.notCheckable = true
				UIDropDownMenu_AddButton(info, level)

				info.disabled = nil
				info.isTitle = nil
				info.checked = nil
				info.notCheckable = true

				info.text = _G.RAID_FRAME_SORT_LABEL
				info.hasArrow = true
				info.value = "submenuSort"
				info.keepShownOnClick = true
				UIDropDownMenu_AddButton(info, level)
				info.hasArrow = nil

				info.text = _G.IGNORE
				info.hasArrow = true
				info.value = "submenuIgnore"
				info.keepShownOnClick = true
				UIDropDownMenu_AddButton(info, level)
				info.hasArrow = nil

				info.keepShownOnClick = nil

				info.isTitle = true
				info.text = _G.UNIT_FRAME_DROPDOWN_SUBSECTION_TITLE_OTHER
				info.func = nil
				UIDropDownMenu_AddButton(info, level)

				info.isTitle = nil
				info.disabled = nil
				info.notClickable = nil

				info.notCheckable = nil
				info.isNotRadio = true
				info.text = TEXT_BFA_MISSIONS
				info.func = ToggleBfaMissions
				info.checked = IPMDB.enableBfaMissions and true or nil
				UIDropDownMenu_AddButton(info, level)

				info.notCheckable = nil
				info.isNotRadio = true
				info.text = TEXT_LEGION_MISSIONS
				info.func = ToggleLegionMissions
				info.checked = IPMDB.enableLegionMissions and true or nil
				UIDropDownMenu_AddButton(info, level)

				info.notCheckable = nil
				info.isNotRadio = true
				info.text = _G.GARRISON_MISSIONS_TITLE
				info.func = ToggleGarrisonMissions
				info.checked = IPMDB.enableGarrisonMissions and true or nil
				UIDropDownMenu_AddButton(info, level)

				info.notCheckable = true
				info.text = _G.RESET
				info.func = Reset_OnClick
				UIDropDownMenu_AddButton(info, level)

				info.text = _G.CLOSE
				info.func = InProgressMissions.HideMenu
				UIDropDownMenu_AddButton(info, level)

			elseif level == 2 then
				info.disabled = nil
				info.isTitle = nil
				info.notCheckable = nil
				if UIDROPDOWNMENU_MENU_VALUE == "submenuSort" then
					info.isNotRadio = nil

					info.text = _G.CHARACTER_NAME_PROMPT
					info.func = SortMethod_OnClick
					info.checked = (IPMDB.sortMethod == "name" or IPMDB.sortMethod == nil) and true or nil
					info.arg1 = "name"
					UIDropDownMenu_AddButton(info, level)

					info.text = _G.CLOSES_IN
					info.func = SortMethod_OnClick
					info.checked = IPMDB.sortMethod == "time" and true or nil
					info.arg1 = "time"
					UIDropDownMenu_AddButton(info, level)
				elseif UIDROPDOWNMENU_MENU_VALUE == "submenuIgnore" then
					info.isNotRadio = true

					for name, profile in pairs(IPMDB.profiles) do
						if profile[1] then
							info.text = profile[1].charText or name
							info.func = IgnoreProfile_OnClick
							info.checked = IPMDB.ignores[name] and true or nil
							info.arg1 = name
							UIDropDownMenu_AddButton(info, level)
						end
					end
				end
			end
		end
	end
end

function InProgressMissions:Init()
	self.missions = {}
	self:InitDB()
	TIME_COLORS = {
		{RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b}, -- ERROR
		{0.55, 0.55, 0.55}, -- DARK(VERY LONG)
		{0.8, 0.8, 0.76}, -- NORMAL
		{GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b}, -- GREEN(MEDIUM)
		{YELLOW_FONT_COLOR.r, YELLOW_FONT_COLOR.g, YELLOW_FONT_COLOR.b}, -- YELLOW(SHORT)
		{ORANGE_FONT_COLOR.r, ORANGE_FONT_COLOR.g, ORANGE_FONT_COLOR.b}, -- ORANGE(VERY SHORT)
	}
	self:UpdateAltMissions()

	self:CreateMenu()
	_G.GarrisonLandingPageReport:HookScript("OnHide", function()
		InProgressMissions:HideMenu()
		wipe(InProgressMissions.missions)
		StaticPopup_Hide("InProgressMissions_CONFIRM_RESET")
	end)
	-- self.listScroll.scrollBar:HookScript("OnValueChanged", ListScroll_OnScroll)
	_G.GarrisonLandingPageReportList_Update = GarrisonLandingPageReportList_Update
	self.GarrisonLandingPageReportMission_OnEnter = _G.GarrisonLandingPageReportMission_OnEnter
	hooksecurefunc("GarrisonLandingPageReportMission_OnEnter", function(...)
		GarrisonLandingPageReportMission_OnEnter(...)
	end)
	hooksecurefunc("GarrisonLandingPageReportList_UpdateItems", ScrollFrame_UpdateItems)
	hooksecurefunc("GarrisonLandingPageReportList_UpdateAvailable", ScrollFrame_UpdateAvailable)
	hooksecurefunc(GarrisonLandingPageReport.InProgress.Text, "SetFormattedText", function(self)
			InProgressMissions:UpdateInProgressTabText()
	end)
	self.listScroll = GarrisonLandingPageReport.List.listScroll
	hooksecurefunc("GarrisonMissionButton_SetInProgressTooltip", GarrisonMissionButton_SetInProgressTooltip)

	self.listScroll:HookScript("OnShow", UpdateItemInfoHandler)
	self.listScroll:HookScript("OnHide", UpdateItemInfoHandler)
	UpdateItemInfoHandler()

	GarrisonLandingPageReportListListScrollFrame:HookScript("OnMouseUp", function(frame, button)
		if button == "RightButton" then
			GarrisonLandingPageReportMission_OnClick(frame, button)
		end
	end)

	self:HookOrderHallMissionFrame()
	self:HookBFAMissionFrame()
	self:HookCovenantMissionFrame()

	self:MissionButton_SetStyle()
	self.Init = function() end
end

local buttonText = {}

local function CreateButtonText(button)
	local text = button:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	text:SetPoint("BOTTOMLEFT", 165, 6)
	text:SetJustifyH("LEFT")
	buttonText[button] = text
	return text
end

local function MissionsScrollFrame_SetExpiresText(ScrollFrame)
	if ScrollFrame:IsVisible() and not InProgressMissions:OrderHallAddonExists() then
		local info, text
		for i, button in ipairs(ScrollFrame.buttons) do
			info = button.info
			text = buttonText[button] or CreateButtonText(button)
			if info and not info.inProgress then
				text:SetText(info.offerEndTime and RAID_INSTANCE_EXPIRES:format(info.offerTimeRemaining) or nil)
				text:Show()
			else
				text:Hide()
			end
		end
	end
end

function InProgressMissions:HookOrderHallMissionFrame()
	if _G.OrderHallMissionFrameMissionsListScrollFrame and not self.OrderHallMissionsScrollFrame then
		self.OrderHallMissionsScrollFrame = _G.OrderHallMissionFrameMissionsListScrollFrame
		hooksecurefunc(_G.OrderHallMissionFrame.MissionTab.MissionList, "Update", function()
			MissionsScrollFrame_SetExpiresText(self.OrderHallMissionsScrollFrame)
		end)
	end
end

function InProgressMissions:HookBFAMissionFrame()
	if _G.BFAMissionFrameMissionsListScrollFrame and not self.BFAMissionsScrollFrame then
		self.BFAMissionsScrollFrame = _G.BFAMissionFrameMissionsListScrollFrame
		hooksecurefunc(_G.BFAMissionFrame.MissionTab.MissionList, "Update", function()
			MissionsScrollFrame_SetExpiresText(self.BFAMissionsScrollFrame)
		end)
	end
end

function InProgressMissions:HookCovenantMissionFrame()
	if _G.CovenantMissionFrameMissionsListScrollFrame and not self.CovenantMissionsScrollFrame then
		self.CovenantMissionsScrollFrame = _G.CovenantMissionFrameMissionsListScrollFrame
		hooksecurefunc(_G.CovenantMissionFrame.MissionTab.MissionList, "Update", function()
			MissionsScrollFrame_SetExpiresText(self.CovenantMissionsScrollFrame)
		end)
	end
end

function InProgressMissions:OrderHallAddonExists()
	for k, v in pairs(ORDERHALL_ADDONS) do
		if v then
			return true
		end
	end
end

function events:ADDON_LOADED(event, name, ...)
	if name == "Blizzard_GarrisonUI" then
		self:Init()
	elseif name == "GarrisonMaster" then
		if _G.GarrisonLandingPageReportList then
			self:Init()
		end
	elseif name == "Blizzard_OrderHallUI" then
		self:HookOrderHallMissionFrame()
	elseif name and ORDERHALL_ADDONS[name] ~= nil then
		ORDERHALL_ADDONS[name] = true
	end
end

local function OnMissionUpdate()
	InProgressMissions.missionUpdated = false
	InProgressMissions:Refresh()
	InProgressMissions:SaveInProgressMissions()
end

function InProgressMissions:QueueSaveInProgressMissions()
	if not self.missionUpdated then
		self.missionUpdated = true
		C_Timer.After(0.5, OnMissionUpdate)
	end
end

function events:GARRISON_MISSION_STARTED(event, ...)
	self:QueueSaveInProgressMissions()
end

function events:GARRISON_MISSION_COMPLETE_RESPONSE(event, ...)
	self:QueueSaveInProgressMissions()
end

function events:PLAYER_LOGIN(event, ...)
	self:UnregisterEvent(event)
	C_Timer.After(5, function()
		if not self.saved then
			self:SaveInProgressMissions()
		end
	end)
end

local function OnShipmentCrafterClosed()
	if InProgressMissions.shipmentUpdated then
		InProgressMissions.shipmentUpdated = false
		C_Garrison.RequestLandingPageShipmentInfo()
	end
end

function events:SHIPMENT_CRAFTER_CLOSED(event, ...)
	self.shipmentUpdated = true
	C_Timer.After(0.01, OnShipmentCrafterClosed)
end

function events:GARRISON_LANDINGPAGE_SHIPMENTS(event, ...)
	self:Refresh()
	if not self.saved then
		self:SaveInProgressMissions()
	end
end

function events:PLAYER_ENTERING_WORLD(event, ...)
	for k, v in pairs(ORDERHALL_ADDONS) do
		ORDERHALL_ADDONS[k] = IsAddOnLoaded(k)
	end
end

function InProgressMissions:GET_ITEM_INFO_RECEIVED(event, ...)
	if not GarrisonLandingPageReport:IsShown() then return end
	local items
	local selectedTab = GarrisonLandingPageReport.selectedTab
	if selectedTab == GarrisonLandingPageReport.InProgress then
		--items = GarrisonLandingPageReport.List.items or {}
		items = self.missions
	elseif selectedTab == GarrisonLandingPageReport.Available then
		items = GarrisonLandingPageReport.List.AvailableItems or {}
	end
	if not items then return end

	local item
	for k, button in pairs(self.listScroll.buttons) do
		if type(button.id) == "number" then
			if button.id < 0 then
				item = InProgressMissions.altMissions[-button.id]
			else
				item = items[button.id]
			end
			if item then
				Rewards_Update(button, item)
			end
		end
	end
end

InProgressMissions.frame:SetScript("OnEvent", function(self, event, ...) events[event](InProgressMissions, event, ...) end)
for event, func in pairs(events) do
	if type(func) == "function" then
		InProgressMissions.frame:RegisterEvent(event)
	end
end

function InProgressMissions:RegisterEvent(event, handler)
	handler = handler or events[event] or InProgressMissions[event]
	if handler then
		events[event] = handler
		InProgressMissions.frame:RegisterEvent(event)
	end
end

function InProgressMissions:UnregisterEvent(event)
	InProgressMissions.frame:UnregisterEvent(event)
end

local function SlashCommandHandler(msg)
	if not msg or msg:len() == 0 then
		if C_Garrison.GetLandingPageGarrisonType() >= Enum.GarrisonType.Type_6_0 then
			return _G.GarrisonLandingPageMinimapButton:Click()
		end
	end

	for char, missions in pairs(IPMDB.profiles) do
		print("=====", (missions[1] and missions[1].charText) or char, "=====")
		for k, m in pairs(missions) do
			if type(m) == "table" then
				print(("[%03d] %s"):format(m.level, m.name), "-", date("%a,%H:%M", m.missionEndTime), (time() - m.missionEndTime) > 0 and "(".._G.COMPLETE..")" or "")
			end
		end
	end
end

do
	InProgressMissions.profileName = UnitName("player").."-"..GetRealmName()
	local colorStr = RAID_CLASS_COLORS[select(2, UnitClass("player")) or "WARRIOR"].colorStr
	InProgressMissions.playerNameText = "|c"..colorStr..UnitName("player").."|r"
	InProgressMissions.alertMissions = {}

	SlashCmdList["InProgressMissions"] = SlashCommandHandler
	_G["SLASH_InProgressMissions1"] = "/ipm"
	_G["SLASH_InProgressMissions2"] = "/inprogressmissions"
end

do
	alertFrames = {}

	local function AlertFrameReward_OnEnter(frame, ...)
		if InCombatLockdown() then return end
		-- AlertFrame_StopOutAnimation(frame:GetParent())
		if frame.info then
			GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
			if frame.info.itemID then
				GameTooltip:SetItemByID(frame.info.itemID)
			elseif frame.info.currencyID and frame.info.quantity then
				GameTooltip:SetText(frame.info.title or _G.UNKNOWN)
				if frame.info.currencyID == 0 then
					GameTooltip:AddLine(GetMoneyString(frame.info.quantity), 1, 1, 1)
				else
					local currencyTexture = C_CurrencyInfo.GetBasicCurrencyInfo(frame.info.currencyID).icon
					GameTooltip:AddLine(BreakUpLargeNumbers(frame.info.quantity).." |T"..currencyTexture..":0:0:0:-1:64:64:2:62:2:62|t ", 1, 1, 1)
				end
				-- GameTooltip:Show()
			elseif frame.info.tooltip then
				GameTooltip:AddLine(frame.info.tooltip, 1, 1, 1, true)
				-- GameTooltip:Show()
			elseif frame.info.title then
				GameTooltip:SetText(frame.info.title)
				-- GameTooltip:Show()
			end
			if frame.info.successChance then
				local color = BAG_ITEM_QUALITY_COLORS[Enum.ItemQuality.WoWToken]
				GameTooltip:AddLine((_G.SUCCESS..": %d%%"):format(frame.info.successChance), color.r, color.g, color.b)
			end
			GameTooltip:Show()
		end
	end

	local function AlertFrameReward_OnLeave(frame, ...)
		if not frame:GetParent():IsMouseOver() then
			AlertFrame_ResumeOutAnimation(frame:GetParent())
		end
		GameTooltip:Hide()
	end

	local function AlertFrame_OnHide(frame)
		local ex = alertFrames[frame]
		if ex then
			ex.level:Hide()
			frame.Name:SetTextColor(ITEM_QUALITY_COLORS[1].r, ITEM_QUALITY_COLORS[1].g, ITEM_QUALITY_COLORS[1].b)
			ex.reward1:SetPoint("RIGHT", -28, 0)
			ex.reward1:Hide()
			ex.reward2:Hide()
			for i = 1, 3 do
				ex.followers[i].icon:Hide()
				ex.followers[i].ring:Hide()
			end
		end
	end

	local function AlertFrame_OnEvent(frame, event, arg1, arg2)
		if event == "GET_ITEM_INFO_RECEIVED" then
			local ex = alertFrames[frame]
			if ex then
				if ex.reward1.info and ex.reward1.info.itemID == arg1 then
					local texture = select(10, GetItemInfo(ex.reward1.info.itemID))
					ex.reward1.icon:SetTexture(texture)
					ex.reward1:SetShown(texture)
				end
				if ex.reward2.info and ex.reward2.info.itemID == arg1 then
					local texture = select(10, GetItemInfo(ex.reward2.info.itemID))
					ex.reward2.icon:SetTexture(texture)
					ex.reward2:SetShown(texture)
				end
			end
		end
	end

	local function MissionAlert_SetReward(info, frame, successChance)
		local texture = info.icon
		-- frame.itemID = info.itemID
		frame.info = info
		frame.info.successChance = successChance
		if info.itemID then
			texture = select(10, GetItemInfo(info.itemID))
		end
		frame.icon:SetTexture(texture)
		frame:SetShown(texture)
	end

	local function AlertFrame_Init(frame)
		if not alertFrames[frame] then
			local ex = {}
			ex.level = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge2")
			ex.level:SetPoint("CENTER", frame.MissionType, 0, 0)
			ex.level:SetTextColor(unpack(TITLE_COLOR_NORMAL))
			ex.reward1 = CreateFrame("Frame", nil, frame)
			ex.reward1:SetPoint("BOTTOM", frame.Title, "BOTTOM", 0, 1)
			ex.reward1:SetPoint("RIGHT", -28, 0)
			ex.reward1:SetSize(24, 24)
			ex.reward1.icon = ex.reward1:CreateTexture(nil, nil, nil, 7)
			ex.reward1.icon:SetAllPoints()
			ex.reward1.bg = ex.reward1:CreateTexture(nil, nil, nil, 6)
			ex.reward1.bg:SetAtlas("GarrLanding_RewardsShadow")
			ex.reward1.bg:SetPoint("CENTER", ex.reward1, 0, 0)
			ex.reward1.bg:SetSize(30, 30)
			ex.reward2 = CreateFrame("Frame", nil, frame)
			ex.reward2:SetPoint("LEFT", ex.reward1, "RIGHT", 4, 0)
			ex.reward2:SetSize(ex.reward1:GetSize())
			ex.reward2.icon = ex.reward2:CreateTexture(nil, nil, nil, 7)
			ex.reward2.icon:SetAllPoints()
			ex.reward2.bg = ex.reward2:CreateTexture(nil, nil, nil, 6)
			ex.reward2.bg:SetAtlas("GarrLanding_RewardsShadow")
			ex.reward2.bg:SetPoint("CENTER", ex.reward2, 0, 0)
			ex.reward2.bg:SetSize(30, 30)
			ex.followers = {}
			local follower
			for i = 1, 3 do
				follower = {}
				follower.icon = frame:CreateTexture(nil, nil, nil, 6)
				follower.icon:SetPoint("BOTTOMRIGHT", -120 + (i * 30), - 2)
				follower.icon:SetSize(24, 24)
				follower.ring = frame:CreateTexture(nil, nil, nil, 7)
				follower.ring:SetPoint("CENTER", follower.icon, 0, 0)
				follower.ring:SetSize(40, 40)
				follower.ring:SetTexture(522972)
				follower.ring:SetTexCoord(0.72656250, 0.81445313, 0.02246094, 0.06542969)
				ex.followers[i] = follower
			end
			if frame:GetScript("OnEvent") then
				frame:HookScript("OnEvent", AlertFrame_OnEvent)
			else
				frame:SetScript("OnEvent", AlertFrame_OnEvent)
			end
			if frame:GetScript("OnHide") then
				frame:HookScript("OnHide", AlertFrame_OnHide)
			else
				frame:SetScript("OnHide", AlertFrame_OnHide)
			end
			frame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
			ex.reward1:SetScript("OnEnter", AlertFrameReward_OnEnter)
			ex.reward1:SetScript("OnLeave", AlertFrameReward_OnLeave)
			ex.reward2:SetScript("OnEnter", AlertFrameReward_OnEnter)
			ex.reward2:SetScript("OnLeave", AlertFrameReward_OnLeave)
			alertFrames[frame] = ex
		end
		return alertFrames[frame]
	end

	local function MissionAlert_OnSetup(frame, info)
		if type(info) == "number" then -- 7.0.3
			info = C_Garrison.GetBasicMissionInfo(info)
		end
		local ex = AlertFrame_Init(frame)
		AlertFrame_OnHide(frame)
		if not ex then return end
		if info then
			if info.followerTypeID == GFT.FollowerType_9_0 then
				return
			end
			info.successChance = info.missionID and C_Garrison.GetMissionSuccessChance(info.missionID) or 100
			frame.Title:SetText(GARRISON_MISSION_COMPLETE)
			if info.isArtifact then
				frame.Title:SetText(GARRISON_TALENT_RESEARCH_COMPLETE)
				frame.MissionType:SetTexture(info.typeIcon)
				frame.Name:SetTextColor(ITEM_QUALITY_COLORS[6].r, ITEM_QUALITY_COLORS[6].g, ITEM_QUALITY_COLORS[6].b)
			elseif info.isRare then
				frame.Name:SetTextColor(ITEM_QUALITY_COLORS[3].r, ITEM_QUALITY_COLORS[3].g, ITEM_QUALITY_COLORS[3].b)
			end
			if info.isMaxLevel and info.iLevel and info.iLevel > 0 then
				ex.level:SetText(info.iLevel)
				ex.level:Show()
			end
			if info.rewards and info.rewards[1] then
				MissionAlert_SetReward(info.rewards[1], ex.reward1, math.min(info.successChance, 100))
			end
			if info.overmaxRewards and info.hasBonusEffect and info.missionID and info.overmaxRewards[1] then
				if info.successChance and info.successChance > 100 then
					MissionAlert_SetReward(info.overmaxRewards[1], ex.reward2, info.successChance - 100)
					ex.reward1:SetPoint("RIGHT", -48, 0)
				end
			elseif info.rewards and info.rewards[2] then
				MissionAlert_SetReward(info.rewards[2], ex.reward2, math.min(info.successChance, 100))
				ex.reward1:SetPoint("RIGHT", -48, 0)
			end
			if info.level and info.level > 50 and info.followers and #info.followers > 0 then
				local followerInfo, index
				for i = 1, #info.followers do
					index = i + (3 - #info.followers)
  				followerInfo = info.followers[i] and C_Garrison.GetFollowerInfo(info.followers[i])
					if followerInfo and followerInfo.portraitIconID then
						ex.followers[index].icon:SetTexture(followerInfo.portraitIconID)
						ex.followers[index].icon:Show()
						ex.followers[index].ring:SetDesaturated(followerInfo.isTroop)
						if followerInfo.isTroop then
							ex.followers[index].ring:SetVertexColor(0.6, 0.6, 0.6)
						else
							ex.followers[index].ring:SetVertexColor(1, 1, 1)
						end
						ex.followers[index].ring:Show()
					else

					end
				end
			end
		else

		end
	end
	hooksecurefunc(GarrisonMissionAlertSystem, "setUpFunction", MissionAlert_OnSetup)
end
