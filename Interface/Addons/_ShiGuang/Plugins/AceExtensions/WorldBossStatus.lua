--## Version: v7.0  ## Author: Ludius of Caelestrasz-US
WorldBossStatus = LibStub("AceAddon-3.0"):NewAddon("WorldBossStatus", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceComm-3.0", "AceSerializer-3.0");

local textures = {}
WorldBossStatus.data = nil

textures.worldBossStatus = "Interface\\Icons\\Spell_arcane_portalshattrath"
textures.alliance = "|TInterface\\FriendsFrame\\PlusManz-Alliance:18|t"
textures.horde = "|TInterface\\FriendsFrame\\PlusManz-Horde:18|t"
textures.bossDefeated = "|TInterface\\WorldMap\\Skull_64Red:18|t"
textures.bossStatus = "|TInterface\\WorldMap\\Skull_64Red:18|t"
textures.bossAvailable = "|TInterface\\WorldMap\\Skull_64Grey:18|t"
textures.bossInactive = "|TInterface\\WorldMap\\Skull_64Grey:18|t"
textures.quest = "|TInterface\\Minimap\\OBJECTICONS:20:20:0:0:256:192:32:64:20:48|t"
textures.toy = "|TInterface\\Icons\\INV_Misc_Toy_03:18|t"
textures.mount = "|TInterface\\Icons\\Ability_mount_ridinghorse:18|t"
textures.pet = "|TInterface\\Icons\\INV_Box_PetCarrier_01:18|t"
textures.gear = "|TInterface\\WorldMap\\Gear_64Grey:18|t"
textures.tick = "|TInterface\\RAIDFRAME\\ReadyCheck-Ready:16|t"
--textures.bonusRoll = "|TInterface\\Icons\\INV_Misc_CuriousCoin:18|t"
--textures.bonusRoll = "|TInterface\\Icons\\Ability_TitanKeeper_CleansingOrb:16:16|t"
textures.bonusRoll = "|TInterface\\BUTTONS\\UI-GroupLoot-Dice-Up:16:16|t"

local LDB = LibStub("LibDataBroker-1.1", true)
local LDBIcon = LDB and LibStub("LibDBIcon-1.0", true)
local LibQTip = LibStub('LibQTip-1.0')

local colors = {
	rare = { r = 0, g = 0.44, b = 0.87},
	epic = { r = 0.63921568627451, g = 0.2078431372549, b = 0.93333333333333 },
	white = { r = 1.0, g = 1.0, b = 1.0 },
	yellow = { r = 1.0, g = 1.0, b = 0.2 }
}

local red = { r = 1.0, g = 0.2, b = 0.2 }
local blue = { r = 0.4, g = 0.4, b = 1.0 }
local green = { r = 0.2, g = 1.0, b = 0.2 }
local yellow = { r = 1.0, g = 1.0, b = 0.2 }
local gray = { r = 0.5, g = 0.5, b = 0.5 }
local black = { r = 0.0, g = 0.0, b = 0.0 }
local white = { r = 1.0, g = 1.0, b = 1.0 }
local epic = { r = 0.63921568627451, g = 0.2078431372549, b = 0.93333333333333 }
local frame

local CURRENCIES = {	{currencyId = 1580,														  -- Seal of Wartorn Fate
						 weeklyMax = 2,
						 quests = {	{questId = 52834, level = 1, cost = 2000},					  -- Sealing Fate: Gold
							 		{questId = 52838, level = 2, cost = 5000},					  -- Sealing Fate: Piles of Gold
									{questId = 52837, level = 1, cost = 250, currencyId = 1560}, -- Sealing Fate: War Resources
									{questId = 52840, level = 2, cost = 500, currencyId = 1560}, -- Sealing Fate: Stashed War Resources
									{questId = 52835, level = 1, cost = 10, currencyId = 52839}, -- Sealing Fate: War Resources
									{questId = 52839, level = 2, cost = 25, currencyId = 52839}  -- Sealing Fate: Stashed War Resources

								  }
						},
						--{currencyId = 1813}													  -- Reservoir Anima
}

local trackedCurrencies = {
	{currencyId = 1813}				-- Reservoir Anima	
}


local MAPID_BROKENISLES = 1007
local isInitialized = false

local defaults = {
	realm = {
		characters = {
			},
	},
	global = {
		realms = {
			},
		MinimapButton = {
			hide = false,
		},
		displayOptions = {
			showHintLine = true,
			showLegend = true,
			showMinimapButton = true,
		},
		characterOptions = {
			levelRestriction = true,
			minimumLevel = 50,
			removeInactive = true,
			inactivityThreshold = 28,
			include = 3,
		},
		bossOptions = {
			hideBoss = {
			},
			trackLegacyBosses = false,
			disableHoldidayBossTracking = false,
		},
		bonusRollOptions = {
			trackWeeklyQuests = true,
			trackedCurrencies = {
				[1129] = true,
			},
			trackLegacyCurrencies = false,
		},
	},
}


for key, currency in pairs(CURRENCIES) do
	if not currency.name and currency.currencyId then
		--currency.name, _, currency.texture = C_CurrencyInfo.GetCurrencyInfo(currency.currencyId)
		apiCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo(currency.currencyId)
		currency.name = apiCurrencyInfo.Name
		currency.texture = apiCurrencyInfo.iconFileID
	end
end

for key, currency in pairs(trackedCurrencies) do
	if not currency.name and currency.currencyId then
		--currency.name, _, currency.texture = C_CurrencyInfo.GetCurrencyInfo(currency.currencyId)
		info = C_CurrencyInfo.GetCurrencyInfo(currency.currencyId)
		currency.name = info.Name
		currency.texture = info.iconFileID
	end
end

local function colorise(s, color)
	if color and s then
		return format("|cff%02x%02x%02x%s|r", (color.r or 1) * 255, (color.g or 1) * 255, (color.b or 1) * 255, s)
	else
		return s
	end
end

local WorldBossStatusLauncher = LDB:NewDataObject("WorldBossStatus", {
		type = "data source",
		text = "World Boss Status",
		label = "WorldBossStatus",
		tocname = "WorldBossStatus",
			--"launcher",
		icon = textures.worldBossStatus,
		OnClick = function(clickedframe, button)
			--WorldBossStatus:ShowOptions()
			SenduiCmd("/tomeofteleport")
		end,
		OnEnter = function(self)
			frame = self
			WorldBossStatus:ShowToolTip()
		end,
	})





local MyScanningTooltip = CreateFrame("GameTooltip", "MyScanningTooltip", UIParent, "GameTooltipTemplate")

local QuestTitleFromID = setmetatable({}, { __index = function(t, id)
	MyScanningTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	MyScanningTooltip:SetHyperlink("quest:"..id)
	local title = MyScanningTooltipTextLeft1:GetText()
	MyScanningTooltip:Hide()
	if title and title ~= RETRIEVING_DATA then
		t[id] = title
		return title
	end
end })

local function CleanupCharacters()
	local options = WorldBossStatus:GetGlobalOptions()
	local threshold = options.characterOptions.inactivityThreshold * (24 * 60 * 60)

	if options.characterOptions.removeInactive or threshold == 0 then
		return
	 end


	for realm in pairs(options.realms) do
		local realmInfo = options.realms[realm]
		local characters = nil

		if realmInfo then
			local characters = realmInfo.characters

			for key,value in pairs(characters) do
				if value.lastUpdate and value.lastUpdate < time() - threshold then
					value = nil
				end
			end

		end
	end

end

local function GetCurrentKillStatus(boss, bossStatus)
	local nextReset, interval = WorldBossStatus:GetBossResetInfo(boss)
	local killed = false
	local bonusRollUsed = false
	local eligible = false

	if bossStatus then
		eligible = bossStatus.eligible
		if bossStatus.lastUpdated and nextReset then
			killed = bossStatus.killed and bossStatus.lastUpdated > nextReset - interval
			bonusRollUsed = bossStatus.bonusRollUsed and bossStatus.lastUpdated > nextReset - interval
		elseif bossStatus.lastUpdated then
			killed = bossStatus.killed
			bonusRollUsed = bossStatus.bonusRollUsed
		end
	end

	return killed, bonusRollUsed, eligible
end

local function ShowKill(boss, bossStatus)
	local subTooltip = WorldBossStatus.subTooltip
	local line = subTooltip:AddLine()
	local color = gray
	local bossTexture = textures.bossInactive
	local rollTexture = ""
	local killed, bonusRollUsed, eligible = GetCurrentKillStatus(boss, bossStatus)

	if killed then
		bossTexture = textures.bossDefeated
		color = red

		if bonusRollUsed then
			rollTexture = textures.bonusRoll
		end
	elseif boss.active and eligible then
		color = white
		bossTexture = textures.bossAvailable
	end

	subTooltip:SetCell(line, 1, boss.displayName or boss.name, nil, "LEFT")
	subTooltip:SetCell(line, 2, boss.location or '', nil, "LEFT")
	subTooltip:SetCell(line, 4, bossTexture, nil, "CENTER", nil, nil, nil, nil, 20, 0)
	subTooltip:SetCell(line, 5, rollTexture, nil, "CENTER", nil, nil, nil, nil, 20, 0)
	subTooltip:SetCellTextColor(line, 1, color.r, color.g, color.b)
	subTooltip:SetCellTextColor(line, 2, color.r, color.g, color.b)
	subTooltip:SetCellTextColor(line, 3, color.r, color.g, color.b)
end

local function ShowBossKills(character, region)
	local subTooltip = WorldBossStatus.subTooltip
	local nextReset = WorldBossStatus:GetNextReset()
	local status = character.status or {}
	local texture = ""
	local footer = ""

	if LibQTip:IsAcquired("WBSsubTooltip") and subTooltip then
		subTooltip:Clear()
	else
		subTooltip = LibQTip:Acquire("WBSsubTooltip", 5, "LEFT", "LEFT", "LEFT", "RIGHT", "CENTER", "CENTER")
		WorldBossStatus.subTooltip = subTooltip
	end

	subTooltip:ClearAllPoints()
	subTooltip:SetClampedToScreen(true)
	subTooltip:SetPoint("TOP", WorldBossStatus.tooltip, "TOP", 30, 0)
	subTooltip:SetPoint("RIGHT", WorldBossStatus.tooltip, "LEFT", -20, 0)

	line = subTooltip:AddHeader(colorise(region.title, colors.yellow))
	subTooltip:AddSeparator(6,0,0,0,0)

	line = subTooltip:AddLine(colorise('NPC', colors.yellow), colorise('Location', colors.yellow), nil, colorise('Status',colors.yellow))
	subTooltip:AddSeparator(1, 1, 1, 1, 1.0)
	subTooltip:AddSeparator(3,0,0,0,0)

	for _, boss in pairs(region.bosses) do
		local bossStatus = status[boss.index]

		if not bossStatus and boss.worldQuestID then
			bossStatus = status[tostring(boss.worldQuestID)]
		end

		if not boss.faction or character.faction == boss.faction then
			ShowKill(boss, bossStatus)
		end
	end

	subTooltip:AddSeparator(6,0,0,0,0)
	line = subTooltip:AddLine()

	footer = format("Legend: %sDefeated  %sBonus roll used", textures.bossDefeated, textures.bonusRoll)

	subTooltip:SetCell(line, 1, footer , nil, LEFT, 3)

	subTooltip:Show()
end

local function HideSubTooltip()
	local subTooltip = WorldBossStatus.subTooltip
	if subTooltip then
		LibQTip:Release(subTooltip)
		subTooltip = nil
	end
	GameTooltip:Hide()
	WorldBossStatus.subTooltip = subTooltip
end

function WorldBossStatus:ShowSubTooltip(cell, info)
	local character = info.character
	local category = info.region

	ShowBossKills(character, category)
end

function WorldBossStatus:DisplayCharacterInTooltip(characterName, characterInfo)
	local bossData = WorldBossStatus:GetBossData()
	local nextReset = WorldBossStatus:GetNextReset()
	local tooltip = WorldBossStatus.tooltip
	local line = tooltip:AddLine()
	local factionIcon = ""
	local coins = 0
	local seals = 0
	local status = characterInfo.status or {}

	if characterInfo.faction and characterInfo.faction == "Alliance" then
		factionIcon = textures.alliance
	elseif characterInfo.faction and characterInfo.faction == "Horde" then
		factionIcon = textures.horde
	end

	tooltip:SetCell(line, 2, factionIcon.." "..characterName)

	column = 2

	for _, currency in pairs(trackedCurrencies) do
		local currencyInfo = nil

		if characterInfo.currencies then
			currencyInfo = characterInfo.currencies[currency.currencyId]
		end

		column = column + 1

		if currencyInfo then
			if currency.weeklyMax then
				--if currencyInfo.collectedThisWeek == currency.weeklyMax then
				--	tooltip:SetCell(line, column, textures.tick, nil, "RIGHT")
				--else
					tooltip:SetCell(line, column, currencyInfo.balance .. "  " .. currencyInfo.collectedThisWeek.."/"..currency.weeklyMax, nil, "RIGHT")
				--end
			else
				tooltip:SetCell(line, column, BreakUpLargeNumbers(currencyInfo.quantity), nil, "RIGHT")
			end

		else
			tooltip:SetCell(line, column, "?", nil, "RIGHT")
		end

	end

	column = column + 1

	for _, category in pairs(bossData) do
		local eligibleBosses = 0
		local kills = 0

		for _, boss in pairs(category.bosses) do
			local bossStatus = status[boss.index]

			if not bossStatus and boss.worldQuestID then
				bossStatus = status[tostring(boss.worldQuestID)]
			end

			local killed, bonusRollUsed, eligible = GetCurrentKillStatus(boss, bossStatus)

			if boss.active and eligible then
				eligibleBosses = eligibleBosses + 1

				
			end
			if killed then
				kills = kills + 1
			end
		end

		if kills > eligibleBosses  then
			tooltip:SetCell(line, column, textures.bossDefeated)
		
		elseif eligibleBosses == 0 then
			tooltip:SetCell(line, column, textures.bossInactive)
		elseif kills == eligibleBosses  then
			tooltip:SetCell(line, column, textures.bossDefeated)
			--tooltip:SetCell(line, column, kills.."/"..eligibleBosses)
		else
			tooltip:SetCell(line, column, kills.."/"..eligibleBosses)
		end

		--tooltip:SetCell(line, column, kills.."/"..eligibleBosses)

		tooltip:SetCellScript(line, column, "OnEnter", function(self)
			local info = { character=characterInfo, region=category}
			WorldBossStatus:ShowSubTooltip(self, info)
		end)

		tooltip:SetCellScript(line, column, "OnLeave", HideSubTooltip)
		column = column+1
	end

	if characterInfo.class then
		local color = RAID_CLASS_COLORS[characterInfo.class]
		tooltip:SetCellTextColor(line, 2, color.r, color.g, color.b)
	end

end


function WorldBossStatus:IsShowMinimapButton(info)
	return not self.db.global.MinimapButton.hide
end

function WorldBossStatus:ToggleMinimapButton(info, value)
	self.db.global.MinimapButton.hide = not value

	if self.db.global.MinimapButton.hide then
		LDBIcon:Hide("WorldBossStatus")
	else
		LDBIcon:Show("WorldBossStatus")
	end

	LDBIcon:Refresh("WorldBossStatus")
	LDBIcon:Refresh("WorldBossStatus")
end

--function WorldBossStatus:ShowOptions()
--	InterfaceOptionsFrame_OpenToCategory(WorldBossStatus.optionsFrame)
--	InterfaceOptionsFrame_OpenToCategory(WorldBossStatus.OptionsFrame)
--end

function WorldBossStatus:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("WorldBossStatusDB", defaults, true)
	self.debug = self.db.global.debug

	LDBIcon:Register("WorldBossStatus", WorldBossStatusLauncher, self.db.global.MinimapButton)

	--self:InitializeOptions()
  --self:RegisterChatCommand("wbs", "ChatCommand")
	--self:RegisterChatCommand("WorldBossStatus", "ChatCommand")

	--CheckUpgradeStatus()

	RequestRaidInfo()
end

local function ShowHeader(tooltip, marker, headerName)
	local bossData = WorldBossStatus:GetBossData()

	line = tooltip:AddHeader()

	if (marker) then
		tooltip:SetCell(line, 1, marker)
	end

	tooltip:SetCell(line, 2, headerName, nil, nil, nil, nil, nil, 50)
	tooltip:SetCellTextColor(line, 2, yellow.r, yellow.g, yellow.b)

	column = 2

	for _, currency in pairs(trackedCurrencies) do
		column = column + 1
		tooltip:SetCell(line, column, "|T"..currency.texture..":0|t", nil, "RIGHT")
	end

	column = column + 1

	for _, category in pairs(bossData) do
		tooltip:SetCell(line, column, category.name, "CENTER")
		tooltip:SetCellTextColor(line, column, yellow.r, yellow.g, yellow.b)
		column = column+1
	end

	return line
end

function WorldBossStatus:DisplayRealmInToolip(realmName)
	local realmInfo = self.db.global.realms[realmName]
	local characters = nil
	local collapsed = false
	local epoch = time() - (WorldBossStatus.db.global.characterOptions.inactivityThreshold * 24 * 60 * 60)

	if realmInfo then
		characters = realmInfo.characters
		collapsed = realmInfo.collapsed
	end

	local characterNames = {}
	local currentCharacterName = UnitName("player")
	local currentRealmName = GetRealmName()
	local tooltip = WorldBossStatus.tooltip
	local levelRestriction = WorldBossStatus.db.global.characterOptions.levelRestruction or false;
	local minimumLevel = 1

	if WorldBossStatus.db.global.characterOptions.levelRestriction then
		minimumLevel = WorldBossStatus.db.global.characterOptions.minimumLevel
		if not minimumLevel then minimumLevel = 35 end
	end

	if not characters then
		return
	end

	for k,v in pairs(characters) do
		local inlcude = true
		if (realmName ~= currentRealmName or k ~= currentCharacterName) and
		   (not WorldBossStatus.db.global.characterOptions.removeInactive or v.lastUpdate > epoch)  and
   		   (v.level >= minimumLevel) then
				table.insert(characterNames, k);
		end
	end

	if (table.getn(characterNames) == 0) then
		return
	end

	table.sort(characterNames)

	tooltip:AddSeparator(2,0,0,0,0)

	if not collapsed then
		line = ShowHeader(tooltip, "|TInterface\\Buttons\\UI-MinusButton-Up:16|t", realmName)

		tooltip:AddSeparator(3,0,0,0,0)

		for k,v in pairs(characterNames) do
			WorldBossStatus:DisplayCharacterInTooltip(v, characters[v])
		end

		tooltip:AddSeparator(1, 1, 1, 1, 1.0)
	else
		line = ShowHeader(tooltip, "|TInterface\\Buttons\\UI-PlusButton-Up:16|t", realmName)
	end

	tooltip:SetCellTextColor(line, 2, yellow.r, yellow.g, yellow.b)
	tooltip:SetCellScript(line, 1, "OnMouseUp", RealmOnClick, realmName)
end

function RealmOnClick(cell, realmName)
	WorldBossStatus.db.global.realms[realmName].collapsed = not WorldBossStatus.db.global.realms[realmName].collapsed
	WorldBossStatus:ShowToolTip()
end

function WorldBossStatus:ShowToolTip()
	local bossData = WorldBossStatus:GetBossData()
	local tooltip = WorldBossStatus.tooltip
	local characterName = UnitName("player")
	local characters = WorldBossStatus.db.realm.characters
	local includeCharacters = WorldBossStatus.db.global.characterOptions.include or 3
	local showHint = WorldBossStatus.db.global.displayOptions.showHintLine

	if LibQTip:IsAcquired("WorldBossStatusTooltip") and tooltip then
		tooltip:Clear()
	else
		local columnCount = #bossData

		RequestLFDPlayerLockInfo()
		WorldBossStatus:UpdateWorldBossKills();

		columnCount = columnCount + 3

		for _, currency in pairs(trackedCurrencies) do
			columnCount = columnCount + 1
		end
		tooltip = LibQTip:Acquire("WorldBossStatusTooltip", columnCount, "CENTER", "LEFT", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER")
		WorldBossStatus.tooltip = tooltip
	end

	line = tooltip:AddHeader(" ")
	tooltip:SetCell(1, 1, "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_8:16|t ".."World Boss Status", nil, "LEFT", tooltip:GetColumnCount())
	tooltip:AddSeparator(6,0,0,0,0)
	ShowHeader(tooltip, nil, "Character")
	tooltip:AddSeparator(6,0,0,0,0)

	local info = WorldBossStatus:GetCharacterInfo()
	WorldBossStatus:DisplayCharacterInTooltip(characterName, info)
	tooltip:AddSeparator(6,0,0,0,0)
	tooltip:AddSeparator(1, 1, 1, 1, 1.0)

	if includeCharacters > 1 then
		WorldBossStatus:DisplayRealmInToolip(GetRealmName())
	end

	if includeCharacters == 3 then
		realmNames = {}

		for k,v in pairs(WorldBossStatus.db.global.realms) do
			if (k ~= GetRealmName()) then
				table.insert(realmNames, k);
			end
		end

		for k,v in pairs(realmNames) do
			WorldBossStatus:DisplayRealmInToolip(v)
		end
	end

	tooltip:AddSeparator(3,0,0,0,0)
	local reset = WorldBossStatus:GetNextReset()[2] - time()
	line = tooltip:AddLine(" ")
	tooltip:SetCell(tooltip:GetLineCount(), 1, "World bosses will reset in" .. " "..SecondsToTime(reset, true, true, 2), nil, "LEFT", tooltip:GetColumnCount()-2)
	--tooltip:SetCell(tooltip:GetLineCount(), tooltip:GetColumnCount()-1, textures.gear, nil, "RIGHT",2)
	--tooltip:SetCellScript(tooltip:GetLineCount(), tooltip:GetColumnCount()-1, "OnMouseUp", "ShowOptions")
	if (frame) then
		tooltip:SetAutoHideDelay(0.01, frame)
		tooltip:SmartAnchorTo(frame)
	end

	tooltip:UpdateScrolling()
	tooltip:Show()
end

function WorldBossStatus:GetRealmInfo(realmName)
	if not self.db.global.realms then
		self.db.global.realms = {}
	end

	local realmInfo = self.db.global.realms[realmName]

	if not realmInfo then
		realmInfo = {}
		realmInfo.characters = {}
	end

	return realmInfo
end


function WorldBossStatus:PlayerIsEligibleForBoss(boss)
	local playerFaction = UnitFactionGroup("player")
	local playerLevel = UnitLevel("player")
	local eligible = true

	if boss.faction and boss.faction ~= playerFaction then
		eligible = false
	elseif boss.prerequisite then
		local criteria = boss.prerequisite
		if criteria.level and playerLevel < criteria.level then
			eligible = false
		end
		if criteria[playerFaction] and not C_QuestLog.IsQuestFlaggedCompleted(tostring(criteria[playerFaction])) then
			eligible = false
		end
	end

	return eligible
 end

local function UpdateStatusForCharacter(currentStatus)
	local status = currentStatus or {}
	local bossData = WorldBossStatus:GetBossData()
	local now = time()

	for _, category in pairs(bossData) do
		for _, boss in pairs(category.bosses) do
			local bossStatus = status[boss.index] or {}
			local prerequisite = boss.prerequisite or {}

			bossStatus.killed = (boss.trackingID and C_QuestLog.IsQuestFlaggedCompleted(boss.trackingID)) or
				(boss.dungeonID and GetLFGDungeonRewards(boss.dungeonID))
			bossStatus.eligible = WorldBossStatus:PlayerIsEligibleForBoss(boss)
			bossStatus.bonusRollUsed = boss.bonusRollID and C_QuestLog.IsQuestFlaggedCompleted(boss.bonusRollID)
			bossStatus.lastUpdated = now

			status[boss.index] = bossStatus
		end
	end

	return status
end

local function UpdateCurrenciesForCharracter(currentCurrencies)
	local currencies = currentCurrencies or {}

	for _, trackedCurrency in pairs(trackedCurrencies) do
		local currency = {}
		local info = C_CurrencyInfo.GetCurrencyInfo(trackedCurrency.currencyId)

		currency.quantityEarnedThisWeek = info.quantityEarnedThisWeek
		currency.quantity = info.quantity
		currencies[trackedCurrency.currencyId] = currency
	end

	return currencies
end

function WorldBossStatus:SaveCharacterInfo(info)
	local characterName = UnitName("player")
	local realmName = GetRealmName()
	local realmInfo = self:GetRealmInfo(realmName)
	local characterInfo = info or self:GetCharacterInfo()

	realmInfo.characters[characterName]  = characterInfo

	self.db.global.realms[realmName] = realmInfo
end

function WorldBossStatus:GetCharacterInfo()
	local realmInfo = WorldBossStatus:GetRealmInfo(GetRealmName())
	local characterInfo = realmInfo.characters[UnitName("player")] or {}
	local _, className = UnitClass("player")

	characterInfo.lastUpdate = time()
	characterInfo.class = className
	characterInfo.level = UnitLevel("player")
	characterInfo.faction = UnitFactionGroup("player")
	characterInfo.status = UpdateStatusForCharacter(characterInfo.status)
	characterInfo.currencies = UpdateCurrenciesForCharracter(characterInfo.currencies)

	return characterInfo
end

function WorldBossStatus:GetBonusRollsStatus()
	currencies = {}

	for _, currency in pairs(CURRENCIES) do
		local currencyInfo = {}
		local apiCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo(currency.currencyId)
		local collectedFromQuests = 0

		if currency.quests then
			for _, quest in pairs(currency.quests) do
				if C_QuestLog.IsQuestFlaggedCompleted(quest.questId) then
					collectedFromQuests = collectedFromQuests + 1
				end
			end

		end

		currencyInfo.collectedThisWeek = apiCurrencyInfo.quantityEarnedThisWeek + collectedFromQuests
		currencyInfo.balance = apiCurrencyInfo.quantity --balance
		currencyInfo.weeklyMax = apiCurrencyInfo.maxWeeklyQuantity --weeklyMax
		currencyInfo.totalMax = apiCurrencyInfo.maxQuantity --totalMax
		currencyInfo.questReset = WorldBossStatus:GetNextReset()[2]
		currencies[currency.currencyId] = currencyInfo
	end

	return currencies
end

function WorldBossStatus:GetRegion()


end

function WorldBossStatus:ChatCommand(input)
	if not input or input:trim() == "" then
		return
	end

	local command = input:lower() or nil

	if command == "debug on" then
		self.debug = true
		self:Print("Debug turned on")
	elseif command == "debug off" then
		self.debug = false
		self:Print("Debug turned off")
	else
		self:Print("Unknown command: " .. command)
	end

	self.db.global.debug = self.debug
end

function WorldBossStatus:UPDATE_INSTANCE_INFO()
	WorldBossStatus:SaveCharacterInfo()
	if LibQTip:IsAcquired("WorldBossStatusTooltip") and WorldBossStatus.tooltip then
		WorldBossStatus:ShowToolTip()
	end
end

function WorldBossStatus:LFG_UPDATE_RANDOM_INFO()
	WorldBossStatus:SaveCharacterInfo()
	if LibQTip:IsAcquired("WorldBossStatusTooltip") and WorldBossStatus.tooltip then
		WorldBossStatus:ShowToolTip()
	end
end

function WorldBossStatus:GetBossInfo(instance, name, questID)
	local bossData = WorldBossStatus:GetBossData()
	local bossInfo = nil

	for _, category in pairs(bossData) do
		if category.name == instance or instance == nil then
			for _, boss in pairs(category.bosses) do
				if (name and boss.name == name) or (questID and questID == boss.trackingID) then
					bossInfo = boss
					break
				end
			end
		end
	end

	return bossInfo
end

function WorldBossStatus:BOSS_KILL(event, id, name)
	if WorldBossStatus.debug then
		WorldBossStatus:Print("BOSS_KILL event received for ID: " .. id or "" .. " and Name: " .. name or "")
	end

	local boss = WorldBossStatus:GetBossInfo(nil, name, nil)

	if boss then
		WorldBossStatus:SaveCharacterInfo()
		if WorldBossStatus.debug then
			WorldBossStatus:Print(" World boss killed: "..boss.name)
		end
	end
end

function WorldBossStatus:BONUS_ROLL_RESULT(event, rewardType, rewardLink, rewardQuantity, rewardSpecID)
	if WorldBossStatus.debug then
		WorldBossStatus:Print("BONUS_ROLL_RESULT event received!")
	end


end

function WorldBossStatus:LFG_COMPLETION_REWARD()
	RequestLFDPlayerLockInfo()
end

function WorldBossStatus:QUEST_TURNED_IN(event, questID)
	if WorldBossStatus.debug then
		WorldBossStatus:Print("QUEST_TURNED_IN event received for quest ID: " ..  questID or "")
	end

	WorldBossStatus:SaveCharacterInfo()
end

function WorldBossStatus:UpdateWorldBossKills()
	RequestRaidInfo();
end

function WorldBossStatus:PLAYER_LOGOUT()
	if WorldBossStatus.debug then
		WorldBossStatus:Print("PLAYER_LOGOUT event received for quest ID: " ..  questID or "")
	end

	WorldBossStatus:UpdateWorldBossKills()
end

local function CheckWorldBosses()
	local bossData = WorldBossStatus:GetBossData()

	for _, category in pairs(bossData) do
		if not category.legacy then
			for _, boss in pairs(category.bosses) do
				if boss.worldQuestID and boss.active and not C_QuestLog.IsQuestFlaggedCompleted(boss.trackingID) and WorldBossStatus:PlayerIsEligibleForBoss(boss) then
					local timeLeft = C_TaskQuest.GetQuestTimeLeftMinutes(boss.worldQuestID)
					local bossname = colorise(boss.name, epic)
					local text = ""
					if timeLeft then
						text = format(" %s! [ %s ]", bossname, SecondsToTime(timeLeft * 60, true, true, 2))
					else
						text = format(" %s! ", bossname)
					end
					--WorldBossStatus:Print(text)
					DEFAULT_CHAT_FRAME:AddMessage(text, 0, 1, 1)
				end
			end
		end
	end
end

local function SendComms(aChannel)
	local bossData = WorldBossStatus:GetBossData()
	local message = {}
	local version = GetAddOnMetadata("WorldBossStatus", "Version")

	message.version = version
	message.lastSeen =WorldBossStatus:GetLastSeenData(true)

	message = WorldBossStatus:Serialize(message)

	WorldBossStatus:SendCommMessage("WorldBossStatus", message, aChannel)

	if WorldBossStatus.debug then
		WorldBossStatus:Print("Sent comms to "..aChannel.." channel. ["..version.."]")
	end
end

local function DelayedSendComms(aChannel)
	if WorldBossStatus:TimeLeft(WorldBossStatus.sendCommsTimer) == 0 then
		WorldBossStatus.sendCommsTimer = WorldBossStatus:ScheduleTimer(SendComms, 5, aChannel)
	end
end

function WorldBossStatus:ReceiveComms(aPrefix, aMessage, aChannel, aSender)
	if aSender ~= UnitName("player") then
		local success, message = self:Deserialize(aMessage)

		if self.debug then
			if success then

				self:Print("Received comms from "..aSender.." [" ..message.version.."] on the "..aChannel.." channel and deserialized succesully!")
			else
				self:Print("Received comms from "..aSender.." on the "..aChannel.." channel but did not deserialize!")
			end
		end

		if success then
			self:UpdateLastSeenData(message.lastSeen)
		end
	end
end

function WorldBossStatus:RAID_ROSTER_UPDATE(event, ...)
	if self.debug then
		self:Print("Received event RAID_ROSTER_UPDATE")
	end
	DelayedSendComms("RAID")

end

function WorldBossStatus:GROUP_ROSTER_UPDATE(event, arg1, ...)
	if self.debug then
		self:Print("Received event GROUP_ROSTER_UPDATE.")
	end
	if IsInRaid() then
		DelayedSendComms("RAID")
	else
		DelayedSendComms("PARTY")
	end
end

function WorldBossStatus:GUILD_ROSTER_UPDATE(event, arg1, ...)
	if self.debug then
		self:Print("Received event GUILD_ROSTER_UPDATE.")
	end
	DelayedSendComms("GUILD")
end

function WorldBossStatus:OnEnable()
	self:RegisterEvent("UPDATE_INSTANCE_INFO")
	self:RegisterEvent("LFG_UPDATE_RANDOM_INFO")
	self:RegisterEvent("LFG_COMPLETION_REWARD")
	self:RegisterEvent("BONUS_ROLL_RESULT")
	self:RegisterEvent("BOSS_KILL")
	self:RegisterEvent("QUEST_TURNED_IN")
	self:RegisterEvent("PLAYER_LOGOUT")
	self:RegisterEvent("RAID_ROSTER_UPDATE")
	self:RegisterEvent("GROUP_ROSTER_UPDATE")
	self:RegisterEvent("GUILD_ROSTER_UPDATE")

	self:RegisterComm("WorldBossStatus", "ReceiveComms")

	--self:GetSinkAce3OptionsDataTable()
	self:ScheduleTimer(CheckWorldBosses, 10)
end

function WorldBossStatus:OnDisable()
	self:UnregisterEvent("UPDATE_INSTANCE_INFO")
	self:UnregisterEvent("LFG_UPDATE_RANDOM_INFO")
	self:UnregisterEvent("LFG_COMPLETION_REWARD")
	self:UnregisterEvent("BONUS_ROLL_RESULT")
	self:UnregisterEvent("BOSS_KILL")
	self:UnregisterEvent("QUEST_TURNED_IN")
	self:UnregisterEvent("PLAYER_LOGOUT")
	self:UnregisterEvent("RAID_ROSTER_UPDATE")
	self:UnregisterEvent("GROUP_ROSTER_UPDATE")
	self:UnregisterEvent("GUILD_ROSTER_UPDATE")
end

local resetIntervals = { daily = 1, weekly = 2, unknown = 3 }

function GetWeeklyQuestResetTime()
	local now = time()
	local region = GetCurrentRegion()
	local dayOffset = { 2, 1, 0, 6, 5, 4, 3 }
	local regionDayOffset = {{ 2, 1, 0, 6, 5, 4, 3 }, { 4, 3, 2, 1, 0, 6, 5 }, { 3, 2, 1, 0, 6, 5, 4 }, { 4, 3, 2, 1, 0, 6, 5 }, { 4, 3, 2, 1, 0, 6, 5 } }
	local nextDailyReset = GetQuestResetTime()
	local utc = date("!*t", now + nextDailyReset)
	local reset = regionDayOffset[region][utc.wday] * 86400 + now + nextDailyReset

	return reset
 end

 function WorldBossStatus:GetLastSeenData(crowdTrackingOnly)
	local lastSeenData = WorldBossStatus.db.global.lastSeen or {}
	local result = {}
	local bossData = self:GetBossData()

	for _, category in pairs(bossData) do
		for _, boss in pairs(category.bosses) do
			if lastSeenData[boss.index] and (boss.crowdTracking or not crowdTrackingOnly) then
				result[boss.index] = lastSeenData[boss.index]
			end
		end
	end

	return result
 end

 function WorldBossStatus:UpdateLastSeenData(newLastSeenData)
	local lastSeenData = WorldBossStatus.db.global.lastSeen or {}
	local bossData = WorldBossStatus:GetBossData()
	local updateCount = 0

	for _, category in pairs(bossData) do
		for _, boss in pairs(category.bosses) do
			if newLastSeenData[boss.index] then
				if not lastSeenData[boss.index] or newLastSeenData[boss.index] > lastSeenData[boss.index] then
					lastSeenData[boss.index] = newLastSeenData[boss.index]
					updateCount = updateCount + 1
				end
			end
		end
	end

	if self.debug then
		self:Print(updateCount.." change applied to last seen data.")
	end

	WorldBossStatus.db.global.lastSeen = lastSeenData
 end


function FlagActiveBosses()
	local bossData = WorldBossStatus:GetBossData()
	local lastSeenData = WorldBossStatus.db.global.lastSeen or {}

	for _, category in pairs(bossData) do
		for _, boss in pairs(category.bosses) do
			if boss.worldQuestID then
				boss.active = false
				if WorldBossStatus.debug then
					local name = C_TaskQuest.GetQuestInfoByQuestID(boss.worldQuestID) or "?"
					local mins = C_TaskQuest.GetQuestTimeLeftMinutes(boss.worldQuestID) or "?"
					local active = C_TaskQuest.IsActive(boss.worldQuestID) or "false"
					WorldBossStatus:Print("World Quest ID: [ID="..boss.worldQuestID.. ", Name="..name.. ", Time Left="..mins..", Active=",active)
				end

				if WorldBossStatus:PlayerIsEligibleForBoss(boss) then
					if C_TaskQuest.IsActive(boss.worldQuestID) or
						(C_QuestLog.IsQuestFlaggedCompleted(boss.trackingID) and boss.resetInterval == resetIntervals.weekly) then
						lastSeenData[boss.index]  = time()
						boss.active = true
					elseif boss.factionCounterpartID then
						if not C_TaskQuest.IsActive(boss.worldQuestID) and not C_QuestLog.IsQuestFlaggedCompleted(boss.trackingID) then
							lastSeenData[tostring(boss.factionCounterpartID)] = time()
						end
					end
				else
					if boss.resetInterval == resetIntervals.weekly then
						if lastSeenData[boss.index] and lastSeenData[boss.index] > GetWeeklyQuestResetTime() - 604800 then
							boss.active = true
						end
					elseif boss.factionCounterpartID then
						if lastSeenData[boss.index] and lastSeenData[tostring(boss.factionCounterpartID)] then
							boss.active = lastSeenData[boss.index] > lastSeenData[tostring(boss.factionCounterpartID)]
						end
					end
				end
			else
				boss.active = true
			end

		end
	end

	WorldBossStatus.db.global.lastSeen = lastSeenData
end

local function GetWorldBoss(args)
	local boss = {}

	if not args.name then
		if args.encounterID then
			args.name = EJ_GetEncounterInfo(args.encounterID)
		elseif args.worldQuestID then
			args.name = C_TaskQuest.GetQuestInfoByQuestID(args.worldQuestID) or "?"
		else
			args.name = "Unkown"
		end
	end

	if not args.location then
		if not args.zoneID and args.worldQuestID then
			args.zoneID = C_TaskQuest.GetQuestZoneID(args.worldQuestID)
		end

		if args.zoneID then
			local mapInfo = C_Map.GetMapInfo(args.zoneID)
			args.location = mapInfo.name
		end
	end

	if not args.trackingID and args.worldQuestID then
		args.trackingID = args.worldQuestID
	end

	if not args.resetInterval then
		args.resetInterval = resetIntervals.weekly
	end

	boss.index = tostring(args.trackingID or args.dungeonID)
	boss.name = args.name
	boss.location = args.location
	boss.trackingID = args.trackingID
	boss.questId = args.trackingID
	boss.bonusRollID = args.bonusRollID

	boss.worldQuestID = args.worldQuestID
	boss.dungeonID = args.dungeonID
	boss.resetInterval = args.resetInterval
	boss.faction = args.faction
	boss.factionCounterpartID = args.factionCounterpartID
	boss.crowdWatch = args.crowdWatch
	boss.prerequisite = args.prerequisite

	return boss
end

function AddHoliday()
	local holidayBosses = nil
	local bosses = {}

	for index = 1, GetNumRandomDungeons() do
		local dungeonID, name = GetLFGRandomDungeonInfo(index);
		local _, _, _, _, _, _, _, _, _, _, _, _, _, description, isHoliday = GetLFGDungeonInfo(dungeonID)

		if isHoliday and dungeonID ~= 828  and description ~= "" then
			boss = {}

			boss.index = dungeonID
			boss.name = name
			boss.displayName = name
			boss.dungeonID = dungeonID
			boss.active = true
			boss.resetInterval = resetIntervals.daily
			table.insert(bosses, boss)
		end
	end

	if #bosses > 0 then
		holidayBosses = {}
		holidayBosses.name = 'Holiday'
		holidayBosses.maxKills = #bosses
		holidayBosses.bosses = bosses
		holidayBosses.bonusRollCurrencies = {1580}
		table.insert(WorldBossStatus.data, holidayBosses)
	end
end

function AddShadowlands()
	local category = {}
	local criteria = {
		level = 60
	}

	category.name = _G["EXPANSION_NAME8"]
	category.title = category.name.." ".."Bosses"
	category.expansion = 8
	category.bosses = {
		GetWorldBoss({worldQuestID = 61813, encounterID = 2430, prerequisite = criteria }),		-- Valinor, the Light of Eons
		GetWorldBoss({worldQuestID = 61816, encounterID = 2431, prerequisite = criteria }),		-- Mortanis
		GetWorldBoss({worldQuestID = 61815, encounterID = 2432, prerequisite = criteria }),		-- Oranonomos, the Everbreaching
		GetWorldBoss({worldQuestID = 61814, encounterID = 2433, prerequisite = criteria }),		-- Nurgash Muckformed
	}
	if GetAccountExpansionLevel() >= category.expansion and
		(not WorldBossStatus.db.global.bossOptions.ignoredExpansions or
		not WorldBossStatus.db.global.bossOptions.ignoredExpansions[category.expansion]) then
		--WorldBossStatus.data[#WorldBossStatus.data +1] = category
		table.insert(WorldBossStatus.data, category)
	end
end

function AddZandalarAndKulTiras()
	local category = {}
	local criteria = {
		['Alliance'] = 51918,
		['Horde'] = 51916
	}

	category.name = _G["EXPANSION_NAME7"]
	category.title = category.name.." ".."Bosses"
	category.expansion = 7
	category.bosses = {
		GetWorldBoss({worldQuestID = 52196, trackingID = 53000, bonusRollID = 52265, encounterID = 2210, prerequisite = criteria }),		-- Dunegorger Kraulok
		GetWorldBoss({worldQuestID = 52169, trackingID = 52998, bonusRollID = 52264, encounterID = 2141, prerequisite = criteria }), 		-- Ji'arak
		GetWorldBoss({worldQuestID = 52181, trackingID = 52996, bonusRollID = 52263, encounterID = 2139, prerequisite = criteria }),		-- T'zane
		GetWorldBoss({worldQuestID = 52166, trackingID = 52995, bonusRollID = 52266, encounterID = 2198, prerequisite = criteria }), 		-- Warbringer Yenajz 52995, 52266
		GetWorldBoss({worldQuestID = 52163, trackingID = 52997, bonusRollID = 52267, encounterID = 2199, prerequisite = criteria }), 		-- Azurethos, The Winged Typhoon
		GetWorldBoss({worldQuestID = 52157, trackingID = 52999, bonusRollID = 52268, encounterID = 2197, prerequisite = criteria }), 		-- Hailstone Construct
		GetWorldBoss({worldQuestID = 52847, trackingID = 53002, bonusRollID = 52273, encounterID = 2213, prerequisite = criteria, 
			faction = 'Alliance', factionCounterpartID = 52848, crowdWatch = true }), 														-- Doom's Howl
		GetWorldBoss({worldQuestID = 52848, encounterID = 2212, prerequisite = criteria, faction = 'Horde', factionCounterpartID = 52847, crowdWatch = true}),	-- The Lion's Roar
		GetWorldBoss({worldQuestID = 54895, encounterID = 2345, trackingID = 54862, bonusRollID = 54864, prerequisite = criteria, faction = 'Alliance',
			factionCounterpartID = 54861, resetInterval = resetIntervals.unknown, crowdWatch = true }),										-- Ivus the Decayed
		GetWorldBoss({worldQuestID = 54896, encounterID = 2329, trackingID = 54861, bonusRollID = 54865, prerequisite = criteria, faction = 'Horde', factionCounterpartID = 54862,
			resetInterval = resetIntervals.unknown, crowdWatch = true, zoneID = 62 }),														-- Ivus the Forest Lord
		GetWorldBoss({worldQuestID = 58705, trackingID = 58508, bonusRollID = 58512, encounterID = 2378, prerequisite = criteria }),		-- Grand Empress Shek'zara
		GetWorldBoss({worldQuestID = 55466, trackingID = 58510, bonusRollID = 58514, encounterID = 2381, prerequisite = criteria }),		-- Vuk'laz the Earthbreaker
		GetWorldBoss({worldQuestID = 56057, trackingID = 56058, bonusRollID = 56900, encounterID = 2362, prerequisite = criteria }),		-- Ulmath, the Soulbinder
		GetWorldBoss({worldQuestID = 56056, trackingID = 56055, bonusRollID = 56899, encounterID = 2363, prerequisite = criteria }),		-- Wekemara
	}
	if GetAccountExpansionLevel() >= category.expansion and
		(not WorldBossStatus.db.global.bossOptions.ignoredExpansions or
		not WorldBossStatus.db.global.bossOptions.ignoredExpansions[category.expansion]) then
		--WorldBossStatus.data[#WorldBossStatus.data +1] = category
		table.insert(WorldBossStatus.data, category)
	end
end

function AddBrokenIsles()
	local category = {}
	local criteria = {
		['Alliance'] = 43341,
		['Horde'] = 43341
	}
	local kosumothCriteria = {
		['Alliance'] = 43761,
		['Horde'] = 43761
	}

	--category.name = EJ_GetInstanceInfo(822) -- Broken Isles
	category.name = _G["EXPANSION_NAME6"]
	category.title = category.name.." ".."Bosses"
	category.expansion = 6
	category.legacy = true
	category.bosses = {
		GetWorldBoss({encounterID = 1790, worldQuestID = 43512, trackingID = 44501, bonusRollID = 44896, prerequisite = criteria}), 	-- Ana-Mouz
		GetWorldBoss({encounterID = 1774, worldQuestID = 43193, trackingID = 44502, bonusRollID = 44897, prerequisite = criteria}), 	-- Calamir
		GetWorldBoss({encounterID = 1789, worldQuestID = 43448, prerequisite = criteria}), 	-- Drugon the Frostblood
		GetWorldBoss({encounterID = 1795, worldQuestID = 43985, prerequisite = criteria}), 	-- Flotsam
		GetWorldBoss({encounterID = 1770, worldQuestID = 42819, prerequisite = criteria}), 	-- Humongris
		GetWorldBoss({encounterID = 1769, worldQuestID = 43192, prerequisite = criteria}), 	-- Levantus
		GetWorldBoss({encounterID = 1783, worldQuestID = 43513, trackingID = 44507, bonusRollID = 44902, prerequisite = criteria}), 	-- Na'zak the Fiend
		GetWorldBoss({encounterID = 1749, worldQuestID = 42270, prerequisite = criteria}), 	-- Nithogg
		GetWorldBoss({encounterID = 1763, worldQuestID = 42779, prerequisite = criteria}), 	-- Shar'thos
		GetWorldBoss({encounterID = 1756, worldQuestID = 42269, prerequisite = criteria}), 	-- The Soultakers
		GetWorldBoss({encounterID = 1796, worldQuestID = 44287, trackingID = 44511, bonusRollID = 44906, prerequisite = criteria}),		-- Withered'Jim
		GetWorldBoss({encounterID = 1956, worldQuestID = 47061, prerequisite = criteria}), 	-- Apocron
		GetWorldBoss({encounterID = 1883, worldQuestID = 46947, prerequisite = criteria}), 	-- Brutallus
		GetWorldBoss({encounterID = 1884, worldQuestID = 46948, prerequisite = criteria}), 	-- Malificus
		GetWorldBoss({encounterID = 1885, worldQuestID = 46945, prerequisite = criteria}), 	-- Si'vash
		GetWorldBoss({name = 'Kosumoth', worldQuestID = 43798, trackingID = 45479, prerequisite = kosumothCriteria})		-- Kosumoth
	}

	if GetAccountExpansionLevel() >= category.expansion and
		(not WorldBossStatus.db.global.bossOptions.ignoredExpansions or
		not WorldBossStatus.db.global.bossOptions.ignoredExpansions[category.expansion]) then
		--WorldBossStatus.data[#WorldBossStatus.data +1] = category
		table.insert(WorldBossStatus.data, category)
	end
end

function AddDraenor()
	local category = {}
	local criteria = {
		level = 35
	}

	category.name = EJ_GetInstanceInfo(557)	-- Draenor
	category.title = category.name.." ".."Bosses"
	category.expansion = 5
	category.legacy = true
	category.bosses = {
		GetWorldBoss({encounterID = 1452, trackingID = 39380, bonusRollID = 33069, zoneID = 534, prerequisite = criteria}),	-- Supreme Lord Kazzak
		GetWorldBoss({encounterID = 1262, trackingID = 37464, bonusRollID = 37672, zoneID = 542, prerequisite = criteria}),	-- Rukhmar
		GetWorldBoss({encounterID = 1211, trackingID = 37462, bonusRollID = 37675, zoneID = 543, prerequisite = criteria}),	-- Tarlna the Ageless
		GetWorldBoss({encounterID = 1291, trackingID = 37460, bonusRollID = 37673, zoneID = 543, prerequisite = criteria})	-- Drov the Ruiner
	}

	if GetAccountExpansionLevel() >= category.expansion and
		(not WorldBossStatus.db.global.bossOptions.ignoredExpansions or
		not WorldBossStatus.db.global.bossOptions.ignoredExpansions[category.expansion]) then
		--WorldBossStatus.data[#WorldBossStatus.data +1] = category
		table.insert(WorldBossStatus.data, category)
	end
end

function AddPanderia()
	local category = {}
	local criteria = {
		level = 35
	}

	category.name = EJ_GetInstanceInfo(322)	-- Panderia
	category.title = category.name.." ".."Bosses"
	category.expansion = 4
	category.legacy = true
	category.bosses = {
		GetWorldBoss({encounterID = 861, trackingID = 33118, bonusRollID = 33225, zoneID = 554, prerequisite = criteria }),				-- Ordos
		GetWorldBoss({ name = "The Celestials", trackingID = 33117, bonusRollID = 33226, zoneID = 554, prerequisite = criteria }),	-- The Celestials
		GetWorldBoss({encounterID = 826, trackingID = 32519, bonusRollID = 32922, zoneID = 507, prerequisite = criteria}),				-- Oondasta
		GetWorldBoss({encounterID = 814, trackingID = 33109, bonusRollID = 32919, zoneID = 504, prerequisite = criteria}),				-- Nalak
		GetWorldBoss({encounterID = 725, trackingID = 32098, bonusRollID = 32923, zoneID = 376, prerequisite = criteria}),				-- Salyisis's Warband
		GetWorldBoss({encounterID = 691, trackingID = 32099, bonusRollID = 32924, zoneID = 379, prerequisite = criteria})				-- Sha of Anger
	}

	if GetAccountExpansionLevel() >= category.expansion and
		(not WorldBossStatus.db.global.bossOptions.ignoredExpansions or
		not WorldBossStatus.db.global.bossOptions.ignoredExpansions[category.expansion]) then
		table.insert(WorldBossStatus.data, category)
	end
end

function WorldBossStatus:GetNextReset()
	local reset = {}

	reset[resetIntervals.daily] = time() + GetQuestResetTime()
	reset[resetIntervals.weekly] = GetWeeklyQuestResetTime()
	reset[resetIntervals.unknown] = -1

	return reset
end

function WorldBossStatus:GetLastReset()
	local reset = {}

	reset[resetIntervals.daily] = time() + GetQuestResetTime() - 86400
	reset[resetIntervals.weekly] = GetWeeklyQuestResetTime() - 604800
	reset[resetIntervals.unknown] = -1

	return reset
end

function WorldBossStatus:GetBossResetInfo(boss)
	local nextReset, interval

	if boss.resetInterval == resetIntervals.daily then
		nextReset = time() + GetQuestResetTime()
		interval = 86400
	elseif boss.resetInterval == resetIntervals.weekly then
		nextReset = GetWeeklyQuestResetTime()
		interval = 604800
	else
		nextReset = nil
		interval = nil
	end

	return nextReset, interval
end

function WorldBossStatus:GetBossData(update)
	if update or WorldBossStatus.data == nil then
		WorldBossStatus.data = {}

		AddHoliday()
		AddShadowlands()
		AddZandalarAndKulTiras()
		AddBrokenIsles()
		AddDraenor()
		AddPanderia()

		FlagActiveBosses()
	end

	return WorldBossStatus.data
end