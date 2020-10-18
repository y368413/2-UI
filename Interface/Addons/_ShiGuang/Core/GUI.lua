local _, ns = ...
local M, R, U, I = unpack(ns)
local G = M:RegisterModule("GUI")

local tonumber, tostring, pairs, ipairs, next, select, type = tonumber, tostring, pairs, ipairs, next, select, type
local tinsert, strsplit, strfind = table.insert, string.split, string.find
local cr, cg, cb = I.r, I.g, I.b
local guiTab, guiPage, f, dataFrame = {}, {}

-- Default Settings
G.DefaultSettings = {
	BFA = false,
	Mover = {},
	InternalCD = {},
	AuraWatchMover = {},
	RaidClickSets = {},
	TempAnchor = {},
	AuraWatchList = {
		Switcher = {},
	},
	Actionbar = {
		Enable = true,
		Hotkeys = true,
		Macro = true,
		Count = true,
		Classcolor = false,
		Cooldown = true,
		DecimalCD = true,
		Style = 8,
		Bar4Fade = false,
		Bar5Fade = false,
		Scale = 1,
		BindType = 1,
		OverrideWA = false,
		MicroMenu = true,
		CustomBar = false,
		CustomBarFader = false,
		CustomBarButtonSize = 34,
		CustomBarNumButtons = 12,
		CustomBarNumPerRow = 12,
		ShowStance = true,
	},
	Auras = {
		Reminder = true,
		Totems = true,
		VerticleTotems = true,
		TotemSize = 32,
		ClassAuras = false,
		ReverseBuffs = false,
		BuffSize = 30,
		BuffsPerRow = 16,
		ReverseDebuffs = false,
		DebuffSize = 34,
		DebuffsPerRow = 16,
	},
	AuraWatch = {
		Enable = true,
		ClickThrough = false,
		IconScale = 1,
		DeprecatedAuras = false,
		QuakeRing = false,
	},
	UFs = {
		Arena = true,
		Castbars = false,
		SwingBar = false,
		SwingTimer = false,
		RaidFrame = true,
		AutoRes = true,
		NumGroups = 8,
		SimpleMode = true,
		SMUnitsPerColumn = 25,
		SMGroupByIndex = 3,
		InstanceAuras = true,
		RaidDebuffScale = 1,
		SpecRaidPos = false,
		RaidHealthColor = 2,
		HorizonRaid = false,
		HorizonParty = false,
		ReverseRaid = false,
		ShowSolo = false,
		SimpleRaidScale = 12,
		RaidWidth = 88,
		RaidHeight = 16,
		RaidPowerHeight = 2,
		RaidHPMode = 1,
		AurasClickThrough = false,
		AutoAttack = true,
		RaidClickSets = true,
		ShowTeamIndex = false,
		ClassPower = true,
		QuakeTimer = true,
		LagString = false,
		RuneTimer = true,
		RaidBuffIndicator = true,
		PartyFrame = true,
		PartyWatcher = true,
		PWOnRight = true,
		PartyWidth = 120,
		PartyHeight = 26,
		PartyPowerHeight = 6,
		PartyPetFrame = false,
		PartyPetWidth = 120,
		PartyPetHeight = 16,
		PartyPetPowerHeight = 2,
		HealthColor = 2,
		BuffIndicatorType = 2,
		BuffIndicatorScale = 1,
		UFTextScale = 1,
		PartyAltPower = true,
		PartyWatcherSync = true,
		SmoothAmount = .3,
		RaidTextScale = 0.85, 
		FrequentHealth = false,
		HealthFrequency = .25,

		PlayerWidth = 245,
		PlayerHeight = 24,
		PlayerPowerHeight = 6,
		PlayerPowerOffset = 2,
		FocusWidth = 160,
		FocusHeight = 21,
		FocusPowerHeight = 3,
		FocusPowerOffset = 2,
		PetWidth = 100,
		PetHeight = 16,
		PetPowerHeight = 2,
		BossWidth = 120,
		BossHeight = 21,
		BossPowerHeight = 3,
		CastingColor = {r=.8, g=.6, b=.1},  --r=.3, g=.7, b=1
		NotInterruptColor = {r=.6, g=.6, b=.6},  --r=1, g=.5, b=.5
		PlayerCBWidth = 240,
		PlayerCBHeight = 16,
		TargetCBWidth = 280,
		TargetCBHeight = 21,
		FocusCBWidth = 245,
		FocusCBHeight = 18,
		PlayerFrameScale = 0.9,
		UFPctText = true,
		UFClassIcon = false,
		UFFade = true,
	},
	Chat = {
		Sticky = false,
		Lock = true,
		Invite = true,
		Freedom = true,
		Keyword = "2",
		Oldname = false,
		GuildInvite = false,
		EnableFilter = true,
		Matches = 1,
		BlockAddonAlert = true,
		ChatMenu = false,
		WhisperColor = true,
		ChatItemLevel = true,
		Chatbar = true,
		ChatWidth = 360,
		ChatHeight = 121,
		BlockStranger = false,
		AllowFriends = true,
		Outline = false,
		ChatBGType = 1,
	},
	Map = {
		Coord = true,
		Clock = false,
		CombatPulse = false,
		MapScale = 1,
		MinimapScale = 1,
		ShowRecycleBin = false,
		WhoPings = true,
		MapReveal = false,
		Calendar = false,
		zrMMbordersize = 2,
		zrMMbuttonsize = 18,
		zrMMbuttonpos = "Bottom",
		zrMMcustombuttons = {},
	},
	Nameplate = {
		Enable = true,
		maxAuras = 6,
		AuraSize = 26,
		AuraFilter = 3,
		FriendlyCC = false,
		HostileCC = true,
		TankMode = false,
		TargetIndicator = 3,
		InsideView = true,
		--Distance = 42,
		PlateWidth = 168,
		PlateHeight = 9,
		CustomUnitColor = true,
		CustomColor = {r=0, g=.8, b=.3},
		UnitList = "",
		ShowPowerList = "",
		VerticalSpacing = .6,
		ShowPlayerPlate = true,
		PPWidth = 175,
		PPBarHeight = 6,
		PPHealthHeight = 0.1,
		PPPowerHeight = 6,
		PPPowerText = true,
		FullHealth = false,
		SecureColor = {r=1, g=0, b=1},
		TransColor = {r=1, g=.8, b=0},
		InsecureColor = {r=1, g=0, b=0},
		OffTankColor = {r=.2, g=.7, b=.5},
		DPSRevertThreat = false,
		ExplosivesScale = true,
		AKSProgress = true,
		PPFadeout = true,
		PPFadeoutAlpha = 0,
		NameplateClassPower = false,
		NameTextSize = 14,
		HealthTextSize = 16,
		MinScale = 1,
		MinAlpha = 0.8,
		ColorBorder = true,
		QuestIndicator = true,
		NameOnlyMode = false,
		PPGCDTicker = true,
	},
	Skins = {
		DBM = true,
		--Skada = false,
		Bigwigs = true,
		TMW = true,
		PetBattle = true,
		WeakAuras = true,
		InfobarLine = true,
		ChatLine = false,
		MenuLine = true,
		ClassLine = true,
		PGFSkin = true,
		Rematch = true,
		ToggleDirection = 1,
		BlizzardSkins = true,
		SkinAlpha = .5,
		DefaultBags = false,
		FlatMode = false,
		AlertFrames = true,
		FontOutline = true,
		Loot = true,
		Shadow = true,
		FontScale = 1,
		CastBarstyle = true,
		QuestTrackerSkinTitle = true,
	},
	Tooltip = {
		CombatHide = true,
		Cursor = true,
		ClassColor = true,
		HideRank = false,
		FactionIcon = true,
		LFDRole = false,
		TargetBy = true,
		Scale = 1,
		SpecLevelByShift = false,
		HideRealm = false,
		HideTitle = false,
		HideJunkGuild = true,
		AzeriteArmor = true,
		OnlyArmorIcons = true,
		QuestCompleteAnnoce = false,
	},
	Misc = {
		Mail = true,
		ItemLevel = true,
		GemNEnchant = true,
		AzeriteTraits = true,
		MissingStats = true,
		SoloInfo = true,
		RareAlerter = true,
		AlertinChat = false,
		Focuser = true,
		ExpRep = true,
		Screenshot = true,
		TradeTabs = true,
		Interrupt = true,
		OwnInterrupt = true,
		InterruptSound = true,
		AlertInInstance = false,
		BrokenSpell = false,
		FasterLoot = true,
		AutoQuest = true,
		HideTalking = true,
		HideBanner = false,
		HideBossEmote = false,
		PetFilter = true,
		QuestNotification = false,
		QuestProgress = false,
		OnlyCompleteRing = false,
		ExplosiveCount = false,
		ExplosiveCache = {},
		PlacedItemAlert = false,
		RareAlertInWild = false,
		ParagonRep = true,
		InstantDelete = true,
		RaidTool = true,
		RMRune = false,
		DBMCount = "10",
		EasyMarking = true,
		ShowMarkerBar = 4,
		BlockInvite = false,
		NzothVision = true,
		QuickQueue = true,
		--AltTabLfgNotification = false,
		--CrazyCatLady = true,
		WallpaperKit = true,
		AutoReagentInBank = false,
		kAutoOpen = true,
		AutoConfirmRoll = false,
		AutoMark = true,
		xMerchant = true,
		FreeMountCD = true,
		WorldQusetRewardIcons = true,
		WorldQusetRewardIconsSize = 36,
		RaidCD = false,
		PulseCD = true,
		EnemyCD = false,
		SorasThreat = true,
		HunterPetHelp = true,
		CtrlIndicator = true,
		BlinkRogueHelper = false,
	},
	Tutorial = {
		Complete = false,
	},
}

G.AccountSettings = {
	ChatFilterList = "%*",
	ChatFilterWhiteList = "",
	TimestampFormat = 1,
	NameplateFilter = {[1]={}, [2]={}},
	RaidDebuffs = {},
	Changelog = {},
	totalGold = {},
	RepairType = 1,
	AutoSell = true,
	GuildSortBy = 1,
	GuildSortOrder = true,
	DetectVersion = I.Version,
	LockUIScale = false,
	UIScale = .71,
	NumberFormat = 2,
	VersionCheck = true,
	DBMRequest = false,
	SkadaRequest = false,
	BWRequest = false,
	RaidAuraWatch = {},
	CornerBuffs = {},
	TexStyle = 3,
	KeystoneInfo = {},
	AutoBubbles = false,
	DisableInfobars = false,
	PartyWatcherSpells = {},
	ContactList = {},
	CustomJunkList = {},
}

-- Initial settings
G.TextureList = {
	[1] = {texture = I.normTex, name = U["Highlight"]},
	[2] = {texture = I.gradTex, name = U["Gradient"]},
	[3] = {texture = I.flatTex, name = U["Flat"]},
}

local function InitialSettings(source, target, fullClean)
	for i, j in pairs(source) do
		if type(j) == "table" then
			if target[i] == nil then target[i] = {} end
			for k, v in pairs(j) do
				if target[i][k] == nil then
					target[i][k] = v
				end
			end
		else
			if target[i] == nil then target[i] = j end
		end
	end

	for i, j in pairs(target) do
		if source[i] == nil then target[i] = nil end
		if fullClean and type(j) == "table" then
			for k, v in pairs(j) do
				if type(v) ~= "table" and source[i] and source[i][k] == nil then
					target[i][k] = nil
				end
			end
		end
	end
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(self, _, addon)
	if addon ~= "_ShiGuang" then return end
	if not MaoRUIPerDB["BFA"] then
		MaoRUIPerDB = {}
		MaoRUIPerDB["BFA"] = true
	end

	InitialSettings(G.DefaultSettings, MaoRUIPerDB, true)
	InitialSettings(G.AccountSettings, MaoRUIDB)
	M:SetupUIScale(true)
	if not G.TextureList[MaoRUIDB["TexStyle"]] then
		MaoRUIDB["TexStyle"] = 2 -- reset value if not exists
	end
	I.normTex = G.TextureList[MaoRUIDB["TexStyle"]].texture

	self:UnregisterAllEvents()
end)

-- Callbacks
local function setupCastbar()
	G:SetupCastbar(guiPage[4])
end

local function setupRaidFrame()
	G:SetupRaidFrame(guiPage[3])
end

local function setupRaidDebuffs()
	G:SetupRaidDebuffs(guiPage[3])
end

local function setupClickCast()
	G:SetupClickCast(guiPage[3])
end

local function setupBuffIndicator()
	G:SetupBuffIndicator(guiPage[3])
end

local function setupPartyWatcher()
	G:SetupPartyWatcher(guiPage[3])
end

local function setupNameplateFilter()
	G:SetupNameplateFilter(guiPage[2])
end

local function setupAuraWatch()
	f:Hide()
	SlashCmdList["NDUI_AWCONFIG"]()
end


local function updateActionbarScale()
	M:GetModule("Actionbar"):UpdateAllScale()
end

local function updateCustomBar()
	M:GetModule("Actionbar"):UpdateCustomBar()
end

local function updateBuffFrame()
	local A = M:GetModule("Auras")
	A:UpdateOptions()
	A:UpdateHeader(A.BuffFrame)
	A.BuffFrame.mover:SetSize(A.BuffFrame:GetSize())
end

local function updateDebuffFrame()
	local A = M:GetModule("Auras")
	A:UpdateOptions()
	A:UpdateHeader(A.DebuffFrame)
	A.DebuffFrame.mover:SetSize(A.DebuffFrame:GetSize())
end

local function updateReminder()
	M:GetModule("Auras"):InitReminder()
end

local function refreshTotemBar()
	if not MaoRUIPerDB["Auras"]["Totems"] then return end
	M:GetModule("Auras"):TotemBar_Init()
end

local function updateChatSticky()
	M:GetModule("Chat"):ChatWhisperSticky()
end

local function updateWhisperList()
	M:GetModule("Chat"):UpdateWhisperList()
end

local function updateFilterList()
	M:GetModule("Chat"):UpdateFilterList()
end

local function updateFilterWhiteList()
	M:GetModule("Chat"):UpdateFilterWhiteList()
end

local function updateChatSize()
	M:GetModule("Chat"):UpdateChatSize()
end

local function toggleChatBackground()
	M:GetModule("Chat"):ToggleChatBackground()
end

local function updateToggleDirection()
	M:GetModule("Skins"):RefreshToggleDirection()
end

local function updatePlateInsideView()
	M:GetModule("UnitFrames"):PlateInsideView()
end

local function updatePlateSpacing()
	M:GetModule("UnitFrames"):UpdatePlateSpacing()
end

local function updatePlateRange()
	M:GetModule("UnitFrames"):UpdatePlateRange()
end

local function updateCustomUnitList()
	M:GetModule("UnitFrames"):CreateUnitTable()
end

local function updatePowerUnitList()
	M:GetModule("UnitFrames"):CreatePowerUnitTable()
end

local function refreshNameplates()
	M:GetModule("UnitFrames"):RefreshAllPlates()
end

local function togglePlatePower()
	M:GetModule("UnitFrames"):TogglePlatePower()
end

local function togglePlateVisibility()
	M:GetModule("UnitFrames"):TogglePlateVisibility()
end

local function toggleGCDTicker()
	M:GetModule("UnitFrames"):ToggleGCDTicker()
end

local function updatePlateScale()
	M:GetModule("UnitFrames"):UpdatePlateScale()
end

local function updatePlateAlpha()
	M:GetModule("UnitFrames"):UpdatePlateAlpha()
end

local function updateRaidNameText()
	M:GetModule("UnitFrames"):UpdateRaidNameText()
end

local function updateUFTextScale()
	M:GetModule("UnitFrames"):UpdateTextScale()
end

local function updateRaidTextScale()
	M:GetModule("UnitFrames"):UpdateRaidTextScale()
end

local function refreshRaidFrameIcons()
	M:GetModule("UnitFrames"):RefreshRaidFrameIcons()
end

local function updateSimpleModeGroupBy()
	local UF = M:GetModule("UnitFrames")
	if UF.UpdateSimpleModeHeader then
		UF:UpdateSimpleModeHeader()
	end
end

local function updateRaidHealthMethod()
	M:GetModule("UnitFrames"):UpdateRaidHealthMethod()
end

local function updateSmoothingAmount()
	M:SetSmoothingAmount(MaoRUIPerDB["UFs"]["SmoothAmount"])
end

local function updateMinimapScale()
	M:GetModule("Maps"):UpdateMinimapScale()
end

local function showMinimapClock()
	M:GetModule("Maps"):ShowMinimapClock()
end

local function showCalendar()
	M:GetModule("Maps"):ShowCalendar()
end

local function updateInterruptAlert()
	M:GetModule("Misc"):InterruptAlert()
end

local function updateExplosiveAlert()
	M:GetModule("Misc"):ExplosiveAlert()
end

local function updateRareAlert()
	M:GetModule("Misc"):RareAlert()
end

local function updateSoloInfo()
	M:GetModule("Misc"):SoloInfo()
end

local function updateQuestNotification()
	M:GetModule("Misc"):QuestNotification()
end

local function updateScreenShot()
	M:GetModule("Misc"):UpdateScreenShot()
end

local function updateFasterLoot()
	M:GetModule("Misc"):UpdateFasterLoot()
end

local function toggleBossBanner()
	M:GetModule("Misc"):ToggleBossBanner()
end

local function toggleBossEmote()
	M:GetModule("Misc"):ToggleBossEmote()
end

local function updateMarkerGrid()
	M:GetModule("Misc"):RaidTool_UpdateGrid()
end

local function updateSkinAlpha()
	for _, frame in pairs(R.frames) do
		frame:SetBackdropColor(0, 0, 0, MaoRUIPerDB["Skins"]["SkinAlpha"])
	end
end

local function AddTextureToOption(parent, index)
	local tex = parent[index]:CreateTexture()
	tex:SetInside(nil, 4, 4)
	tex:SetTexture(G.TextureList[index].texture)
	tex:SetVertexColor(cr, cg, cb)
end

-- Config
G.TabList = {
	U["Actionbar"],
	U["Nameplate"],
	U["RaidFrame"],
	U["Auras"],
	U["ChatFrame"],
	U["Skins"],
	U["Misc"],
	U["UI Settings"],
}

G.OptionList = {		-- type, key, value, name, horizon, horizon2, doubleline
	[1] = {
		{1, "Actionbar", "Enable", "|cff00cc4c"..U["Enable Actionbar"]},
		--{3, "Actionbar", "Scale", U["Actionbar Scale"].."*", true, false, {.8, 1.5, .01}, updateActionbarScale},
		{1, "Actionbar", "CustomBar", "|cff00cc4c"..U["Enable CustomBar"], true, false, nil, nil, U["CustomBarTip"]},
		{4, "Actionbar", "Style", U["Actionbar Style"], true, true, {"-- 2*(3+12+3) --", "-- 2*(6+12+6) --", "-- 2*6+3*12+2*6 --", "-- 3*12 --", "-- 2*(12+6) --", "-- 3*(4+12+4) --", "-- What --", "-- MR --", "-- PVP2 --", "-- Cool --", "-- JK --"}},
		{3, "Actionbar", "CustomBarButtonSize", U["CustomBarButtonSize"].."*", false, false, {24, 60, 1}, updateCustomBar},
		{3, "Actionbar", "CustomBarNumButtons", U["CustomBarNumButtons"].."*", true, false, {1, 12, 1}, updateCustomBar},
		{3, "Actionbar", "CustomBarNumPerRow", U["CustomBarNumPerRow"].."*", true, true, {1, 12, 1}, updateCustomBar},
		{1, "Actionbar", "CustomBarFader", U["CustomBarFader"]},
		{1, "Actionbar", "MicroMenu", U["Micromenu"], true},
		{1, "Actionbar", "Classcolor", U["ClassColor BG"], true, true},
		{1, "Actionbar", "Cooldown", "|cff00cc4c"..U["Show Cooldown"]},
		{1, "Actionbar", "DecimalCD", U["Decimal Cooldown"].."*", true},
		{1, "Actionbar", "OverrideWA", U["HideCooldownOnWA"].."*", true, true},
		{1, "Actionbar", "Hotkeys", U["Actionbar Hotkey"]},
		{1, "Actionbar", "Macro", U["Actionbar Macro"], true},
		{1, "Actionbar", "Count", U["Actionbar Item Counts"], true, true},
		--{1, "Actionbar", "Bar4Fade", U["Bar4 Fade"]},
		--{1, "Actionbar", "Bar5Fade", U["Bar5 Fade"], true},
		--{1, "UFs", "LagString", U["Castbar LagString"]},
		{1, "UFs", "QuakeTimer", U["UFs QuakeTimer"]},
		--{1, "UFs", "ClassPower", U["UFs ClassPower"], true, true},
		{1, "UFs", "SwingBar", U["UFs SwingBar"], true},
		{1, "UFs", "SwingTimer", U["UFs SwingTimer"], true, true, nil, nil, U["SwingTimer Tip"]},
		{},--blank	
		{3, "ACCOUNT", "UIScale", U["Setup UIScale"], false, false, {.4, 1.15, .01}},
		{3, "Misc", "WorldQusetRewardIconsSize", "WorldQusetRewardIconsSize", true, false, {21, 66, 1}},
		{3, "UFs", "PlayerFrameScale", U["PlayerFrame Scale"], true, true, {0.6, 1.2, .1}},
		{3, "Tooltip", "Scale", U["Tooltip Scale"].."*", false, false, {.5, 1.5, .1}},
		{3, "Map", "MapScale", U["Map Scale"], true, false, {1, 2, .1}},
		{3, "Map", "MinimapScale", U["Minimap Scale"].."*", true, true, {1, 2, .1}, updateMinimapScale},
	},
	[2] = {
		{1, "Nameplate", "Enable", "|cff00cc4c"..U["Enable Nameplate"], nil, nil, setupNameplateFilter},
		{1, "Nameplate", "FullHealth", U["Show FullHealth"].."*", true, nil, nil, refreshNameplates},
		{4, "Nameplate", "TargetIndicator", U["TargetIndicator"].."*", true, true, {DISABLE, U["TopArrow"], U["RightArrow"], U["TargetGlow"], U["TopNGlow"], U["RightNGlow"]}, refreshNameplates},
		{1, "Nameplate", "FriendlyCC", U["Friendly CC"].."*"},
		{1, "Nameplate", "HostileCC", U["Hostile CC"].."*", true},
		{4, "Nameplate", "AuraFilter", "*", true, true, {U["BlackNWhite"], U["PlayerOnly"], U["IncludeCrowdControl"]}, refreshNameplates},  --U["NameplateAuraFilter"]..
		--{1, "Nameplate", "InsideView", U["Nameplate InsideView"].."*", nil, nil, nil, updatePlateInsideView},
		--{1, "Nameplate", "QuestIndicator", U["QuestIndicator"], true, true},
		{1, "Nameplate", "CustomUnitColor", "|cff00cc4c"..U["CustomUnitColor"].."*", nil, nil, nil, updateCustomUnitList},
		{1, "Nameplate", "TankMode", "|cff00cc4c"..U["Tank Mode"].."*", true},
		{1, "Nameplate", "DPSRevertThreat", U["DPS Revert Threat"].."*", true, true},
		--{3, "Nameplate", "VerticalSpacing", U["NP VerticalSpacing"].."*", false, nil, {.5, 1.5, .1}, updatePlateSpacing},
		{1, "Nameplate", "ColorBorder", U["ColorBorder"].."*", false, false, nil, refreshNameplates},
		{1, "Nameplate", "ExplosivesScale", U["ExplosivesScale"], true},
		{1, "Nameplate", "AKSProgress", U["AngryKeystones Progress"], true, true},
		--{3, "Nameplate", "Distance", U["Nameplate Distance"].."*", false, false, {20, 100, .1}, updatePlateRange},
		{3, "Nameplate", "MinScale", U["Nameplate MinScale"].."*", false, false, {.5, 1, .1}, updatePlateScale},
		{3, "Nameplate", "MinAlpha", U["Nameplate MinAlpha"].."*", true, false, {.5, 1, .1}, updatePlateAlpha},
		{3, "Nameplate", "PlateWidth", U["NP Width"].."*", false, false, {50, 250, 1}, refreshNameplates},
		{3, "Nameplate", "PlateHeight", U["NP Height"].."*", true, false, {5, 30, 1}, refreshNameplates},
		{3, "Nameplate", "NameTextSize", U["NameTextSize"].."*", true, true, {10, 30, 1}, refreshNameplates},
		{3, "Nameplate", "HealthTextSize", U["HealthTextSize"].."*", false, false, {10, 30, 1}, refreshNameplates},
		{3, "Nameplate", "maxAuras", U["Max Auras"].."*", true, false, {0, 10, 1}, refreshNameplates},
		{3, "Nameplate", "AuraSize", U["Auras Size"].."*", true, true, {18, 40, 1}, refreshNameplates},
		{2, "Nameplate", "UnitList", U["UnitColor List"].."*", nil, nil, nil, updateCustomUnitList, U["CustomUnitTips"]},
		{2, "Nameplate", "ShowPowerList", U["ShowPowerList"].."*", true, nil, nil, updatePowerUnitList, U["CustomUnitTips"]},
		{5, "Nameplate", "SecureColor", U["Secure Color"].."*"},
		{5, "Nameplate", "TransColor", U["Trans Color"].."*", 1},
		{5, "Nameplate", "InsecureColor", U["Insecure Color"].."*", 2},
		{5, "Nameplate", "OffTankColor", U["OffTank Color"].."*", 3},
		{5, "Nameplate", "CustomColor", U["Custom Color"].."*", 4},
		--{1, "Nameplate", "Numberstyle", "数字模式", true},
		--{1, "Nameplate", "nameonly", "友方仅显示名字", true, true},
		--{1, "Nameplate", "TankMode", "|cff00cc4c"..U["Tank Mode"].."*"},
		--{1, "Nameplate", "HostileCC", U["Hostile CC"].."*", true, true},
		--{1, "Nameplate", "BommIcon", "|cff00cc4c"..U["BommIcon"]},
		--{1, "Nameplate", "HighlightTarget", "血条高亮鼠标指向", true},
		--{1, "Nameplate", "HighlightFocus", "血条高亮焦点指向", true, true},
		--{1, "Nameplate", "FullHealth", U["Show FullHealth"]},
		--{1, "Nameplate", "InsideView", U["Nameplate InsideView"], true},
		--{},--blank
		--{2, "Nameplate", "ShowPowerList", U["ShowPowerList"].."*", true, true, nil, nil, U["CustomUnitTips"]},
		--{3, "Nameplate", "MinAlpha", U["Nameplate MinAlpha"], false, false, {0, 1, 1}},
		--{3, "Nameplate", "maxAuras", U["Max Auras"], true, false, {0, 10, 0}},
		--{3, "Nameplate", "AuraSize", U["Auras Size"], true, true, {12, 36, 0}},
		--{3, "Nameplate", "Distance", U["Nameplate Distance"], false, false, {20, 100, 0}},
		--{3, "Nameplate", "Width", U["NP Width"], true, false, {60, 160, 0}},
		--{3, "Nameplate", "Height", U["NP Height"], true, true, {3, 16, 0}},
	},
	[3] = {
		{1, "UFs", "SimpleMode", "|cff00cc4c"..U["SimpleRaidFrame"], false, false, nil, nil, U["SimpleRaidFrameTip"]},
		{3, "UFs", "SMUnitsPerColumn", U["SimpleMode Column"], true, false, {10, 40, 1}},
		{4, "UFs", "SMGroupByIndex", U["SimpleMode GroupBy"].."*", true, true, {GROUP, CLASS, ROLE}, updateSimpleModeGroupBy},
		--{1, "UFs", "SMSortByRole", U["SimpleMode SortByRole"], true},
		{1, "UFs", "RaidFrame", "|cff00cc4c"..U["UFs RaidFrame"], false, false, setupRaidFrame, nil, U["RaidFrameTip"]},
		{1, "UFs", "PartyFrame", "|cff00cc4c"..U["UFs PartyFrame"], true},
		{1, "UFs", "Arena", U["Arena Frame"], true, true},
		{1, "UFs", "PartyPetFrame", "|cff00cc4c"..U["UFs PartyPetFrame"]},
		--{1, "UFs", "RaidClassColor", U["ClassColor RaidFrame"]},
		{1, "UFs", "PartyWatcher", "|cff00cc4c"..U["UFs PartyWatcher"], true, nil, setupPartyWatcher, nil, U["PartyWatcherTip"]},
		--{1, "UFs", "PartyWatcherSync", U["PartyWatcherSync"], nil, nil, nil, nil, U["PartyWatcherSyncTip"]},
		{1, "UFs", "PWOnRight", U["PartyWatcherOnRight"], true, true},
		{1, "UFs", "HorizonParty", U["Horizon PartyFrame"]},
		{1, "UFs", "HorizonRaid", U["Horizon RaidFrame"], true},		
		{1, "UFs", "ReverseRaid", U["Reverse RaidFrame"], true, true},
		{1, "UFs", "PartyAltPower", U["UFs PartyAltPower"], false, false, nil, nil, U["PartyAltPowerTip"]},
		{1, "UFs", "SpecRaidPos", U["Spec RaidPos"], true},
		{1, "UFs", "AutoRes", U["UFs AutoRes"], true, true},
		{1, "UFs", "RaidClickSets", "|cff00cc4c"..U["Enable ClickSets"], nil, nil, setupClickCast},
		{1, "UFs", "InstanceAuras", "|cff00cc4c"..U["Instance Auras"], true, nil, setupRaidDebuffs},
		{1, "UFs", "RaidBuffIndicator", "|cff00cc4c"..U["RaidBuffIndicator"], true, true, setupBuffIndicator, nil, U["RaidBuffIndicatorTip"]},
		{1, "UFs", "AurasClickThrough", U["RaidAuras ClickThrough"], nil, nil, nil, nil, U["ClickThroughTip"]},
		{1, "UFs", "ShowTeamIndex", U["RaidFrame TeamIndex"], true},
		{4, "UFs", "BuffIndicatorType", "*", true, true, {U["BI_Blocks"], U["BI_Icons"], U["BI_Numbers"]}, refreshRaidFrameIcons}, --U["BuffIndicatorType"].."*"
		{4, "UFs", "RaidHPMode", U["RaidHPMode"].."*", false, false, {U["DisableRaidHP"], U["RaidHPPercent"], U["RaidHPCurrent"], U["RaidHPLost"]}, updateRaidNameText},
		{4, "UFs", "RaidHealthColor", U["HealthColor"], true, false, {U["Default Dark"], U["ClassColorHP"], U["GradientHP"]}},
		{3, "UFs", "NumGroups", U["Num Groups"], true, true, {4, 8, 1}},
		{3, "UFs", "BuffIndicatorScale", U["BuffIndicatorScale"].."*", false, false, {0.6, 2, .1}, refreshRaidFrameIcons},
		{3, "UFs", "RaidDebuffScale", U["RaidDebuffScale"].."*", true, false, {0.6, 2, .1}, refreshRaidFrameIcons},
		{3, "UFs", "RaidTextScale", U["UFTextScale"], true, true, {.8, 1.5, .05}, updateRaidTextScale},
		--{3, "UFs", "SmoothAmount", "|cff00cc4c"..U["SmoothAmount"], true, true, {.15, .6, .05}, updateSmoothingAmount, U["SmoothAmountTip"]},
		--{1, "UFs", "FrequentHealth", "|cff00cc4c"..U["FrequentHealth"].."*" false, true, nil, updateRaidHealthMethod, U["FrequentHealthTip"]},
		--{3, "UFs", "HealthFrequency", U["HealthFrequency"].."*" true, true, {.1, .5, .05}, updateRaidHealthMethod, U["HealthFrequencyTip"]},
	},
	[4] = {
		{1, "AuraWatch", "Enable", "|cff00cc4c"..U["Enable AuraWatch"], false, false, setupAuraWatch},
		{1, "AuraWatch", "DeprecatedAuras", U["DeprecatedAuras"], true},
		--{1, "AuraWatch", "QuakeRing", U["QuakeRing"].."*"},
		{1, "AuraWatch", "ClickThrough", U["AuraWatch ClickThrough"], true, true, nil, nil, U["ClickThroughTip"]},
		--{1, "Auras", "Stagger", U["Enable Stagger"]},
		--{1, "Auras", "BloodyHell", U["Enable BloodyHell"], true},
		--{1, "Auras", "HunterTool", U["Enable Marksman"], true, true},
		--{1, "Auras", "BlinkComboHelper", U["Enable BlinkComboHelper"]},
		--{1, "Auras", "EnergyBar", U["Class EnergyBar"]},
		--{1, "Auras", "ClassRecourePlace", U["Class Recoure Center"], true},
		{1, "Misc", "RaidCD", U["Raid CD"]},
		{1, "Misc", "PulseCD", U["Pulse CD"], true},
		{1, "Misc", "EnemyCD", U["Enemy CD"], true, true},
		{1, "Auras", "Totems", U["Enable Totems"]},
		{1, "Auras", "ReverseBuffs", U["ReverseBuffs"], true},
		{1, "Auras", "ReverseDebuffs", U["ReverseDebuffs"], true, true},	
		--{1, "UFs", "Castbars", "|cff00cc4c"..U["UFs Castbar"], false, false, setupCastbar},
		{3, "Auras", "BuffSize", U["BuffSize"], false, false, {24, 40, 1}},
		{3, "Auras", "DebuffSize", U["DebuffSize"], true, false, {24, 40, 1}},
		{1, "UFs", "RuneTimer", U["UFs RuneTimer"], true, true},
		{3, "Auras", "BuffsPerRow", U["BuffsPerRow"], false, false, {10, 20, 1}},
		{3, "Auras", "DebuffsPerRow", U["DebuffsPerRow"], true, false, {10, 16, 1}},
		{3, "AuraWatch", "IconScale", U["AuraWatch IconScale"], true, true, {.8, 2, .1}},
		{},--blank		
		{1, "Nameplate", "ShowPlayerPlate", "|cff00cc4c"..U["Enable PlayerPlate"]},
		{1, "Auras", "ClassAuras", U["Enable ClassAuras"], true},
		--{1, "Nameplate", "MaxPowerGlow", U["MaxPowerGlow"], true, true},
		{1, "Nameplate", "NameplateClassPower", U["Nameplate ClassPower"]},
		{1, "Nameplate", "PPPowerText", U["PlayerPlate PowerText"].."*", true, false, nil, togglePlatePower},
		{1, "Nameplate", "PPFadeout", U["PlayerPlate Fadeout"].."*", true, true, nil, togglePlateVisibility},
		--{1, "Nameplate", "PPGCDTicker", U["PlayerPlate GCDTicker"].."*", nil, nil, nil, toggleGCDTicker},
		{3, "Nameplate", "PPWidth", U["PlayerPlate HPWidth"].."*", false, nil, {120, 310, 1}, refreshNameplates}, -- FIX ME: need to refactor classpower
		--{3, "Nameplate", "PPBarHeight", U["PlayerPlate CPHeight"].."*", true, false, {0, 16, 1}, refreshNameplates},
		{3, "Nameplate", "PPHealthHeight", U["PlayerPlate HPHeight"].."*", true, false, {0, 16, .1}, refreshNameplates},
		{3, "Nameplate", "PPPowerHeight", U["PlayerPlate MPHeight"].."*", true, true, {1, 16, 1}, refreshNameplates},
	},
	[5] = {
		{1, "Chat", "Outline", U["Font Outline"]},
		{1, "Chat", "Sticky", U["Chat Sticky"].."*", true, false, nil, updateChatSticky},
	{4, "ACCOUNT", "TimestampFormat", U["TimestampFormat"].."*", true, true, {DISABLE, "03:27 PM", "03:27:32 PM", "15:27", "15:27:32"}},
		--{1, "ACCOUNT", "Timestamp", U["Timestamp"], true, true, nil, updateTimestamp},
		--{1, "Chat", "WhisperColor", U["Differ WhipserColor"].."*"},
		--{1, "Chat", "Freedom", U["Language Filter"]},
		{1, "Chat", "EnableFilter", "|cff00cc4c"..U["Enable Chatfilter"]},
		{1, "Chat", "BlockStranger", "|cffff0000"..U["BlockStranger"].."*", true, false, nil, nil, U["BlockStrangerTip"]},
		{1, "Chat", "BlockAddonAlert", U["Block Addon Alert"], true, true},
		{1, "Chat", "Invite", "|cff00cc4c"..U["Whisper Invite"]},
		{1, "Chat", "GuildInvite", U["Guild Invite Only"].."*", true},
		{1, "ACCOUNT", "AutoBubbles", U["AutoBubbles"], true, true},
		{},--blank
		{1, "Misc", "HideTalking", U["No Talking"]},
		{1, "Misc", "HideBanner", U["Hide Bossbanner"].."*", true, false, nil, toggleBossBanner},
		--{1, "Misc", "HideBossEmote", U["HideBossEmote"].."*", nil, nil, toggleBossEmote},
		--{1, "Misc", "HideErrors", U["Hide Error"].."*", true, true, nil, updateErrorBlocker},
		{1, "Chat", "AllowFriends", U["AllowFriendsSpam"].."*", false, false, nil, nil, U["AllowFriendsSpamTip"]},
		{1, "Chat", "Lock", "|cff00cc4c"..U["Lock Chat"], true, false},
		{},--blank
		{3, "Chat", "Matches", U["Keyword Match"].."*", false, false, {1, 3, 1}},
		{3, "Chat", "ChatWidth", U["LockChatWidth"].."*", true, false, {200, 600, 1}, updateChatSize},
		{3, "Chat", "ChatHeight", U["LockChatHeight"].."*", true, true, {100, 500, 1}, updateChatSize},			
		--{1, "Chat", "Chatbar", U["ShowChatbar"], true},
		--{1, "Chat", "ChatItemLevel", U["ShowChatItemLevel"]},
		{2, "ACCOUNT", "ChatFilterList", U["Filter List"].."*", false, false, nil, updateFilterList},
		{2, "Chat", "Keyword", U["Whisper Keyword"].."*", true, false, nil, updateWhisperList},
		{2, "ACCOUNT", "ChatFilterWhiteList", "|cff00cc4c"..U["ChatFilterWhiteList"].."*", true, true, nil, updateFilterWhiteList, U["ChatFilterWhiteListTip"]},
	},
	[6] = {
		{1, "UFs", "UFFade", U["UFFade"]},
		{1, "UFs", "UFClassIcon", U["UFClassIcon"], true},
	  {1, "UFs", "UFPctText", U["UFPctText"], true, true},
	  {1, "Misc", "xMerchant", U["xMerchant"]},
	  {1, "Misc", "WallpaperKit", U["WallpaperKit"], true},
	  {1, "Skins", "FlatMode", U["FlatMode"], true, true},
		{},--blank
		{1, "Map", "Coord", U["Map Coords"]},
		{1, "Map", "Clock", U["Minimap Clock"].."*", true, false, nil, showMinimapClock},
		{1, "Skins", "QuestTrackerSkinTitle", U["QuestTrackerSkinTitle"], true, true},
		--{1, "Map", "Calendar", U["MinimapCalendar"].."*", true, true, nil, showCalendar, U["MinimapCalendarTip"]},
		--{1, "Map", "CombatPulse", U["Minimap Pulse"]},
		--{1, "Map", "ShowRecycleBin", U["Show RecycleBin"], true},
		{1, "Map", "WhoPings", U["Show WhoPings"]},
		{1, "Misc", "ExpRep", U["Show Expbar"], true},
		{1, "Misc", "WorldQusetRewardIcons", U["WorldQusetRewardIcons"], true, true},
		{},--blank
		{1, "Skins", "TMW", U["TMW Skin"]},
		{1, "Skins", "WeakAuras", U["WeakAuras Skin"], true},
		--{1, "Skins", "PGFSkin", U["PGF Skin"], true},
		--{1, "Skins", "Rematch", U["Rematch Skin"], true, true},
		{1, "Skins", "Bigwigs", U["Bigwigs Skin"]},
		--{3, "Skins", "SkinAlpha", U["SkinAlpha"].."*", true, {0, 1, .05}, updateSkinAlpha},
		--{1, "Skins", "Loot", U["Loot"]},
		--{1, "Skins", "BlizzardSkins", "|cff00cc4c"..U["BlizzardSkins"], true, nil, nil, U["BlizzardSkinsTips"]},
		{1, "Skins", "InfobarLine", U["ClassColor Line"], true},	
		--{1, "Skins", "PetBattle", U["PetBattle Skin"], true},
		{1, "Skins", "DBM", U["DBM Skin"], true, true},
		--{1, "Skins", "Skada", U["Skada Skin"], true},
	  --{1, "Skins", "Shadow", U["Shadow"]},
		--{1, "Skins", "ChatLine", U["Chat Line"]},
		--{1, "Skins", "MenuLine", U["Menu Line"], true},
		--{1, "Skins", "ClassLine", U["ClassColor Line"], true, true},
		--{4, "Skins", "ToggleDirection", U["ToggleDirection"].."*", true, true, {U["LEFT"], U["RIGHT"], U["TOP"], U["BOTTOM"]}, updateToggleDirection},
		{4, "ACCOUNT", "TexStyle", U["Texture Style"], false, false, {}},
		{4, "ACCOUNT", "NumberFormat", U["Numberize"], true, false, {U["Number Type1"], U["Number Type2"], U["Number Type3"]}},
		{2, "Misc", "DBMCount", U["Countdown Sec"].."*", true, true},
	},
	[7] = {
	  --{1, "Misc", "RaidTool", "|cff00cc4c"..U["Raid Manger"]},
		--{1, "Misc", "RMRune", U["Runes Check"].."*"},
		--{1, "Misc", "EasyMarking", U["Easy Mark"].."*"},
		{1, "Misc", "QuestNotification", "|cff00cc4c"..U["QuestNotification"].."*", false, false, nil, updateQuestNotifier},
		{1, "Misc", "QuestProgress", U["QuestProgress"].."*", true},
		{1, "Misc", "OnlyCompleteRing", U["OnlyCompleteRing"].."*", true, true},
		{1, "Misc", "Interrupt", "|cff00cc4c"..U["Interrupt Alert"].."*", false, false, nil, updateInterruptAlert}, 
		{1, "Misc", "AlertInInstance", U["Alert In Instance"].."*", true},
		{1, "Misc", "OwnInterrupt", U["Own Interrupt"].."*", true, true},
		{1, "Misc", "BrokenSpell", U["Broken Spell"].."*", false, false, nil, nil, U["BrokenSpellTip"]},
		--{1, "Misc", "UunatAlert", U["Uunat Alert"].."*", false, false, nil, updateUunatAlert},	
		{1, "Misc", "InterruptSound", U["Interrupt Alarm"], true},
		{1, "Misc", "SoloInfo", U["SoloInfo"].."*", true, true, nil, updateSoloInfo},
		{1, "Misc", "RareAlerter", "|cff00cc4c"..U["Rare Alert"].."*", false, false, nil, updateRareAlert},
		--{1, "Misc", "AlertinChat", U["Alert In Chat"].."*", true},
	  {1, "Misc", "PlacedItemAlert", U["Placed Item Alert"], true, false},
		--{1, "Misc", "RareAlertInWild", U["RareAlertInWild"].."*", true},
	  --{1, "Misc", "CrazyCatLady", U["Death Alarm"]},
	  {1, "Auras", "Reminder", U["Enable Reminder"].."*", true, true, nil, updateReminder},	
		{},--blank
	  {1, "Misc", "AutoMark", U["Auto Mark"]},
	  {1, "Misc", "kAutoOpen", U["kAutoOpen"], true},
		{1, "Misc", "AutoConfirmRoll", U["AutoConfirmRoll"], true, true},
		{1, "Misc", "QuickQueue", U["QuickQueue"]},
	  {1, "Misc", "AutoReagentInBank", U["Auto Reagent Bank"], true},
		--{1, "Bags", "Enable", "|cff00cc4c"..U["Enable Bags"], true, true},
		--{1, "Bags", "ItemFilter", U["Bags ItemFilter"].."*", true, nil, setupBagFilter, updateBagStatus},
		--{1, "Bags", "ItemSetFilter", U["Use ItemSetFilter"].."*", true, true, nil, updateBagStatus, U["ItemSetFilterTips"]},
		--{1, "Bags", "GatherEmpty", U["Bags GatherEmpty"].."*", true, true, nil, updateBagStatus},
		--{1, "Bags", "ReverseSort", U["Bags ReverseSort"].."*", true, true, nil, updateBagSortOrder},
		--{1, "Bags", "SpecialBagsColor", U["SpecialBagsColor"].."*", true, true, nil, updateBagStatus, U["SpecialBagsColorTip"]},
		--{1, "Bags", "BagsiLvl", U["Bags Itemlevel"].."*", true, true, nil, updateBagStatus},
		--{1, "Bags", "ShowNewItem", U["Bags ShowNewItem"]},
		--{1, "Bags", "DeleteButton", U["Bags DeleteButton"]},
		--{3, "Bags", "iLvlToShow", U["iLvlToShow"].."*", true, true, {1, 500, 0}, updateBagStatus, U["iLvlToShowTip"]},
		--{3, "Bags", "BagsScale", U["Bags Scale"], true, true, {.5, 1.5, 1}},
		--{3, "Bags", "IconSize", U["Bags IconSize"], true, true, {30, 42, 0}},
		--{3, "Bags", "BagsWidth", U["Bags Width"], true, true, {10, 20, 0}},
		--{3, "Bags", "BankWidth", U["Bank Width"], true, true, {10, 20, 0}},
		{1, "Misc", "HunterPetHelp", U["HunterPetHelp"], true, true},
		{1, "Misc", "CtrlIndicator", U["Shiftfreeze"]},
		{1, "Misc", "BlinkRogueHelper", U["BlinkRogueHelper"], true},
	},
	[8] = {
		{1, "Misc", "ParagonRep", U["ParagonRep"]},
		{1, "Misc", "TradeTabs", U["TradeTabs"], true},
		{1, "Misc", "PetFilter", U["Show PetFilter"], true, true},
		{1, "Misc", "MissingStats", U["Show MissingStats"]},
		{1, "Misc", "Screenshot", U["Auto ScreenShot"].."*", true, false, nil, updateScreenShot},
	  {1, "Misc", "ExplosiveCount", U["Explosive Alert"], true, true, nil, updateExplosiveAlert},
		--{1, "Misc", "GemNEnchant", U["Show GemNEnchant"].."*"},
		--{1, "Misc", "AzeriteTraits", U["Show AzeriteTraits"].."*", true},
		--{1, "Misc", "ItemLevel", "|cff00cc4c"..U["Show ItemLevel"]},
		{1, "Misc", "Mail", U["Mail Tool"]},
		{1, "Misc", "Focuser", U["Easy Focus"], true},
		{1, "Misc", "FasterLoot", U["Faster Loot"].."*", true, true, nil, updateFasterLoot},
		{1, "ACCOUNT", "LockUIScale", "|cff00cc4c"..U["Lock UIScale"]},
	  {1, "Misc", "FreeMountCD", "CD君(CN only)", true},
		{},--blank
		{1, "Tooltip", "CombatHide", U["Hide Tooltip"].."*"},
		{1, "Tooltip", "Cursor", U["Follow Cursor"].."*", true},
		{1, "Tooltip", "ClassColor", U["Classcolor Border"].."*", true, true},
		{1, "Tooltip", "HideTitle", U["Hide Title"].."*"},
		{1, "Tooltip", "HideRank", U["Hide Rank"].."*", true},
		--{1, "Tooltip", "FactionIcon", U["FactionIcon"].."*"},
		{1, "Tooltip", "HideJunkGuild", U["HideJunkGuild"].."*", true, true},
		{1, "Tooltip", "HideRealm", U["Hide Realm"].."*"},
		{1, "Tooltip", "SpecLevelByShift", U["Show SpecLevelByShift"].."*", true},
		{1, "Tooltip", "LFDRole", U["Group Roles"].."*", true, true},
		{1, "Tooltip", "AzeriteArmor", "|cff00cc4c"..U["Show AzeriteArmor"]},
		{1, "Tooltip", "OnlyArmorIcons", U["Armor icons only"].."*", true},
		{1, "Tooltip", "TargetBy", U["Show TargetedBy"].."*", true, true},
	},
}

local function SelectTab(i)
	for num = 1, #G.TabList do
		if num == i then
			guiTab[num]:SetBackdropColor(cr, cg, cb, .3)
			guiTab[num].checked = true
			guiPage[num]:Show()
		else
			guiTab[num]:SetBackdropColor(0, 0, 0, .3)
			guiTab[num].checked = false
			guiPage[num]:Hide()
		end
	end
end

local function tabOnClick(self)
	PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
	SelectTab(self.index)
end
local function tabOnEnter(self)
	if self.checked then return end
	self:SetBackdropColor(cr, cg, cb, .3)
end
local function tabOnLeave(self)
	if self.checked then return end
	self:SetBackdropColor(0, 0, 0, .3)
end

local function CreateTab(parent, i, name)
	local tab = CreateFrame("Button", nil, parent, "BackdropTemplate")
	tab:SetPoint("TOP", -310 + 88*(i-1) + R.mult, -121)
	tab:SetSize(90, 30)
	M.CreateBD(tab, .3)
	M.CreateFS(tab, 15, name, "system", "CENTER", 0, 0)
	tab.index = i

	tab:SetScript("OnClick", tabOnClick)
	tab:SetScript("OnEnter", tabOnEnter)
	tab:SetScript("OnLeave", tabOnLeave)

	return tab
end

local function NDUI_VARIABLE(key, value, newValue)
	if key == "ACCOUNT" then
		if newValue ~= nil then
			MaoRUIDB[value] = newValue
		else
			return MaoRUIDB[value]
		end
	else
		if newValue ~= nil then
			MaoRUIPerDB[key][value] = newValue
		else
			return MaoRUIPerDB[key][value]
		end
	end
end

local function CreateOption(i)
	local parent, offset = guiPage[i].child, 60

	for _, option in pairs(G.OptionList[i]) do
		local optType, key, value, name, horizon, horizon2, data, callback, tooltip = unpack(option)
		-- Checkboxes
		if optType == 1 then
			local cb = M.CreateCheckBox(parent)
			cb:SetHitRectInsets(-5, -5, -5, -5)
			if horizon2 then
				cb:SetPoint("TOPLEFT", 550, -offset + 32)
			elseif horizon then
				cb:SetPoint("TOPLEFT", 310, -offset + 32)
			else
				cb:SetPoint("TOPLEFT", 60, -offset)
				offset = offset + 32
			end
			cb.name = M.CreateFS(cb, 14, name, false, "LEFT", 30, 0)
			cb:SetChecked(NDUI_VARIABLE(key, value))
			cb:SetScript("OnClick", function()
				NDUI_VARIABLE(key, value, cb:GetChecked())
				if callback then callback() end
			end)
			if data and type(data) == "function" then
				local bu = M.CreateGear(parent)
				bu:SetPoint("LEFT", cb.name, "RIGHT", -2, 1)
				bu:SetScript("OnClick", data)
			end
			if tooltip then
				cb.title = U["Tips"]
				M.AddTooltip(cb, "ANCHOR_RIGHT", tooltip, "info")
			end
		-- Editbox
		elseif optType == 2 then
			local eb = M.CreateEditBox(parent, 210, 23)
			eb:SetMaxLetters(999)
			if horizon2 then
				eb:SetPoint("TOPLEFT", 550, -offset + 32)
			elseif horizon then
				eb:SetPoint("TOPLEFT", 310, -offset + 32)
			else
				eb:SetPoint("TOPLEFT", 60, -offset - 26)
				offset = offset + 58
			end
			eb:SetText(NDUI_VARIABLE(key, value))
			eb:HookScript("OnEscapePressed", function()
				eb:SetText(NDUI_VARIABLE(key, value))
			end)
			eb:HookScript("OnEnterPressed", function()
				NDUI_VARIABLE(key, value, eb:GetText())
				if callback then callback() end
			end)
			eb.title = U["Tips"]
			local tip = U["EditBox Tip"]
			if tooltip then tip = tooltip.."|n"..tip end
			M.AddTooltip(eb, "ANCHOR_RIGHT", tip, "info")
			M.CreateFS(eb, 14, name, "system", "CENTER", 0, 25)
		-- Slider
		elseif optType == 3 then
			local min, max, step = unpack(data)
			local x, y
			if horizon2 then
				x, y = 540, -offset + 32
			elseif horizon then
				x, y = 300, -offset + 32
			else
				x, y = 55, -offset - 26
				offset = offset + 58
			end
			local s = M.CreateSlider(parent, name, min, max, step, x, y)
			s.__default = (key == "ACCOUNT" and G.AccountSettings[value]) or G.DefaultSettings[key][value]
			s:SetValue(NDUI_VARIABLE(key, value))
			s:SetScript("OnValueChanged", function(_, v)
				local current = M:Round(tonumber(v), 2)
				NDUI_VARIABLE(key, value, current)
				s.value:SetText(current)
				if callback then callback() end
			end)
			s.value:SetText(M:Round(NDUI_VARIABLE(key, value), 2))
			if tooltip then
				s.title = U["Tips"]
				M.AddTooltip(s, "ANCHOR_RIGHT", tooltip, "info")
			end
		-- Dropdown
		elseif optType == 4 then
			if value == "TexStyle" then
				for _, v in ipairs(G.TextureList) do
					tinsert(data, v.name)
				end
			end

			local dd = M.CreateDropDown(parent, 160, 26, data)
			if horizon2 then
				dd:SetPoint("TOPLEFT", 560, -offset + 32)
			elseif horizon then
				dd:SetPoint("TOPLEFT", 320, -offset + 32)
			else
				dd:SetPoint("TOPLEFT", 70, -offset - 26)
				offset = offset + 58
			end
			dd.Text:SetText(data[NDUI_VARIABLE(key, value)])

			local opt = dd.options
			dd.button:HookScript("OnClick", function()
				for num = 1, #data do
					if num == NDUI_VARIABLE(key, value) then
						opt[num]:SetBackdropColor(1, .8, 0, .3)
						opt[num].selected = true
					else
						opt[num]:SetBackdropColor(0, 0, 0, .3)
						opt[num].selected = false
					end
				end
			end)
			for i in pairs(data) do
				opt[i]:HookScript("OnClick", function()
					NDUI_VARIABLE(key, value, i)
					if callback then callback() end
				end)
				if value == "TexStyle" then
					AddTextureToOption(opt, i) -- texture preview
				end
			end
			M.CreateFS(dd, 14, name, "system", "CENTER", 0, 25)
		-- Colorswatch
		elseif optType == 5 then
			local f = M.CreateColorSwatch(parent, name, NDUI_VARIABLE(key, value))
			local width = 80 + (horizon or 0)*120
			if horizon2 then
				dd:SetPoint("TOPLEFT", width, -offset + 33)
			elseif horizon then
				f:SetPoint("TOPLEFT", width, -offset + 33)
			else
				f:SetPoint("TOPLEFT", width, -offset - 3)
				offset = offset + 36
			end
		-- Blank, no optType
		else
			if not key then
				local line = M.SetGradient(parent, "H", 1, 1, 1, .25, .25, 560, R.mult)
				line:SetPoint("TOPLEFT", 25, -offset - 12)
			end
			offset = offset + 32
		end
	end
end

local bloodlustFilter = {
	[57723] = true,
	[57724] = true,
	[80354] = true,
	[264689] = true
}

function G:ExportGUIData()
	local text = "UISettings:"..I.Version..":"..I.MyName..":"..I.MyClass
	for KEY, VALUE in pairs(MaoRUIPerDB) do
		if type(VALUE) == "table" then
			for key, value in pairs(VALUE) do
				if type(value) == "table" then
					if value.r then
						for k, v in pairs(value) do
							text = text..";"..KEY..":"..key..":"..k..":"..v
						end
					elseif key == "ExplosiveCache" then
						text = text..";"..KEY..":"..key..":EMPTYTABLE"
					elseif KEY == "AuraWatchList" then
						if key == "Switcher" then
							for k, v in pairs(value) do
								text = text..";"..KEY..":"..key..":"..k..":"..tostring(v)
							end
						else
							for spellID, k in pairs(value) do
								text = text..";"..KEY..":"..key..":"..spellID
								if k[5] == nil then k[5] = false end
								for _, v in ipairs(k) do
									text = text..":"..tostring(v)
								end
							end
						end
					elseif KEY == "Mover" or KEY == "RaidClickSets" or KEY == "InternalCD" or KEY == "AuraWatchMover" then
						text = text..";"..KEY..":"..key
						for _, v in ipairs(value) do
							text = text..":"..tostring(v)
						end
					elseif key == "FavouriteItems" then
						text = text..";"..KEY..":"..key
						for itemID in pairs(value) do
							text = text..":"..tostring(itemID)
						end
					end
				else
					if MaoRUIPerDB[KEY][key] ~= G.DefaultSettings[KEY][key] then -- don't export default settings
						text = text..";"..KEY..":"..key..":"..tostring(value)
					end
				end
			end
		end
	end

	for KEY, VALUE in pairs(MaoRUIDB) do
		if KEY == "RaidAuraWatch" or KEY == "CustomJunkList" then
			text = text..";ACCOUNT:"..KEY
			for spellID in pairs(VALUE) do
				text = text..":"..spellID
			end
		elseif KEY == "RaidDebuffs" then
			for instName, value in pairs(VALUE) do
				for spellID, prio in pairs(value) do
					text = text..";ACCOUNT:"..KEY..":"..instName..":"..spellID..":"..prio
				end
			end
		elseif KEY == "NameplateFilter" then
			for index, value in pairs(VALUE) do
				text = text..";ACCOUNT:"..KEY..":"..index
				for spellID in pairs(value) do
					text = text..":"..spellID
				end
			end
		elseif KEY == "CornerBuffs" then
			for class, value in pairs(VALUE) do
				for spellID, data in pairs(value) do
					if not bloodlustFilter[spellID] and class == I.MyClass then
						local anchor, color, filter = unpack(data)
						text = text..";ACCOUNT:"..KEY..":"..class..":"..spellID..":"..anchor..":"..color[1]..":"..color[2]..":"..color[3]..":"..tostring(filter or false)
					end
				end
			end
		elseif KEY == "PartyWatcherSpells" then
			text = text..";ACCOUNT:"..KEY
			for spellID, duration in pairs(VALUE) do
				local name = GetSpellInfo(spellID)
				if name then
					text = text..":"..spellID..":"..duration
				end
			end
		elseif KEY == "ContactList" then
			for name, color in pairs(VALUE) do
				text = text..";ACCOUNT:"..KEY..":"..name..":"..color
			end
		end
	end

	dataFrame.editBox:SetText(M:Encode(text))
	dataFrame.editBox:HighlightText()
end

local function toBoolean(value)
	if value == "true" then
		return true
	elseif value == "false" then
		return false
	end
end

local function reloadDefaultSettings()
	for i, j in pairs(G.DefaultSettings) do
		if type(j) == "table" then
			if not MaoRUIPerDB[i] then MaoRUIPerDB[i] = {} end
			for k, v in pairs(j) do
				MaoRUIPerDB[i][k] = v
			end
		else
			MaoRUIPerDB[i] = j
		end
	end
	MaoRUIPerDB["BFA"] = true -- don't empty data on next loading
end

function G:ImportGUIData()
	local profile = dataFrame.editBox:GetText()
	if M:IsBase64(profile) then profile = M:Decode(profile) end
	local options = {strsplit(";", profile)}
	local title, _, _, class = strsplit(":", options[1])
	if title ~= "UISettings" then
		UIErrorsFrame:AddMessage(I.InfoColor..U["Import data error"])
		return
	end

	-- we don't export default settings, so need to reload it
	reloadDefaultSettings()

	for i = 2, #options do
		local option = options[i]
		local key, value, arg1 = strsplit(":", option)
		if arg1 == "true" or arg1 == "false" then
			MaoRUIPerDB[key][value] = toBoolean(arg1)
		elseif arg1 == "EMPTYTABLE" then
			MaoRUIPerDB[key][value] = {}
		elseif strfind(value, "Color") and (arg1 == "r" or arg1 == "g" or arg1 == "b") then
			local color = select(4, strsplit(":", option))
			if MaoRUIPerDB[key][value] then
				MaoRUIPerDB[key][value][arg1] = tonumber(color)
			end
		elseif key == "AuraWatchList" then
			if value == "Switcher" then
				local index, state = select(3, strsplit(":", option))
				MaoRUIPerDB[key][value][tonumber(index)] = toBoolean(state)
			else
				local idType, spellID, unit, caster, stack, amount, timeless, combat, text, flash = select(4, strsplit(":", option))
				value = tonumber(value)
				arg1 = tonumber(arg1)
				spellID = tonumber(spellID)
				stack = tonumber(stack)
				amount = toBoolean(amount)
				timeless = toBoolean(timeless)
				combat = toBoolean(combat)
				flash = toBoolean(flash)
				if not MaoRUIPerDB[key][value] then MaoRUIPerDB[key][value] = {} end
				MaoRUIPerDB[key][value][arg1] = {idType, spellID, unit, caster, stack, amount, timeless, combat, text, flash}
			end
		elseif value == "FavouriteItems" then
			local items = {select(3, strsplit(":", option))}
			for _, itemID in next, items do
				MaoRUIPerDB[key][value][tonumber(itemID)] = true
			end
		elseif key == "Mover" or key == "AuraWatchMover" then
			local relFrom, parent, relTo, x, y = select(3, strsplit(":", option))
			value = tonumber(value) or value
			x = tonumber(x)
			y = tonumber(y)
			MaoRUIPerDB[key][value] = {relFrom, parent, relTo, x, y}
		elseif key == "RaidClickSets" then
			if I.MyClass == class then
				MaoRUIPerDB[key][value] = {select(3, strsplit(":", option))}
			end
		elseif key == "InternalCD" then
			local spellID, duration, indicator, unit, itemID = select(3, strsplit(":", option))
			spellID = tonumber(spellID)
			duration = tonumber(duration)
			itemID = tonumber(itemID)
			MaoRUIPerDB[key][spellID] = {spellID, duration, indicator, unit, itemID}
		elseif key == "ACCOUNT" then
			if value == "RaidAuraWatch" or value == "CustomJunkList" then
				local spells = {select(3, strsplit(":", option))}
				for _, spellID in next, spells do
					MaoRUIDB[value][tonumber(spellID)] = true
				end
			elseif value == "RaidDebuffs" then
				local instName, spellID, priority = select(3, strsplit(":", option))
				if not MaoRUIDB[value][instName] then MaoRUIDB[value][instName] = {} end
				MaoRUIDB[value][instName][tonumber(spellID)] = tonumber(priority)
			elseif value == "NameplateFilter" then
				local spells = {select(4, strsplit(":", option))}
				for _, spellID in next, spells do
					MaoRUIDB[value][tonumber(arg1)][tonumber(spellID)] = true
				end
			elseif value == "CornerBuffs" then
				local class, spellID, anchor, r, g, b, filter = select(3, strsplit(":", option))
				spellID = tonumber(spellID)
				r = tonumber(r)
				g = tonumber(g)
				b = tonumber(b)
				filter = toBoolean(filter)
				if not MaoRUIDB[value][class] then MaoRUIDB[value][class] = {} end
				MaoRUIDB[value][class][spellID] = {anchor, {r, g, b}, filter}
			elseif value == "PartyWatcherSpells" then
				local options = {strsplit(":", option)}
				local index = 3
				local spellID = options[index]
				while spellID do
					local duration = options[index+1]
					MaoRUIDB[value][tonumber(spellID)] = tonumber(duration) or 0
					index = index + 2
					spellID = options[index]
				end
			elseif value == "ContactList" then
				local name, r, g, b = select(3, strsplit(":", option))
				MaoRUIDB["ContactList"][name] = r..":"..g..":"..b
			end
		elseif tonumber(arg1) then
			if value == "DBMCount" then
				MaoRUIPerDB[key][value] = arg1
			else
				MaoRUIPerDB[key][value] = tonumber(arg1)
			end
		end
	end
end

local function updateTooltip()
	local profile = dataFrame.editBox:GetText()
	if M:IsBase64(profile) then profile = M:Decode(profile) end
	local option = strsplit(";", profile)
	local title, version, name, class = strsplit(":", option)
	if title == "UISettings" then
		dataFrame.version = version
		dataFrame.name = name
		dataFrame.class = class
	else
		dataFrame.version = nil
	end
end

local function createDataFrame()
	if dataFrame then dataFrame:Show() return end

	dataFrame = CreateFrame("Frame", nil, UIParent)
	dataFrame:SetPoint("CENTER")
	dataFrame:SetSize(500, 500)
	dataFrame:SetFrameStrata("DIALOG")
	M.CreateMF(dataFrame)
	M.SetBD(dataFrame)
	dataFrame.Header = M.CreateFS(dataFrame, 16, U["Export Header"], true, "TOP", 0, -5)

	local scrollArea = CreateFrame("ScrollFrame", nil, dataFrame, "UIPanelScrollFrameTemplate")
	scrollArea:SetPoint("TOPLEFT", 10, -30)
	scrollArea:SetPoint("BOTTOMRIGHT", -28, 40)
	M.CreateBDFrame(scrollArea, .25)

	local editBox = CreateFrame("EditBox", nil, dataFrame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(true)
	editBox:SetFont(I.Font[1], 14)
	editBox:SetWidth(scrollArea:GetWidth())
	editBox:SetHeight(scrollArea:GetHeight())
	editBox:SetScript("OnEscapePressed", function() dataFrame:Hide() end)
	scrollArea:SetScrollChild(editBox)
	dataFrame.editBox = editBox

	StaticPopupDialogs["NDUI_IMPORT_DATA"] = {
		text = U["Import data warning"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			G:ImportGUIData()
			ReloadUI()
		end,
		whileDead = 1,
	}
	local accept = M.CreateButton(dataFrame, 100, 20, OKAY)
	accept:SetPoint("BOTTOM", 0, 10)
	accept:SetScript("OnClick", function(self)
		if self.text:GetText() ~= OKAY and dataFrame.editBox:GetText() ~= "" then
			StaticPopup_Show("NDUI_IMPORT_DATA")
		end
		dataFrame:Hide()
	end)
	accept:HookScript("OnEnter", function(self)
		if dataFrame.editBox:GetText() == "" then return end
		updateTooltip()

		GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 10)
		GameTooltip:ClearLines()
		if dataFrame.version then
			GameTooltip:AddLine(U["Data Info"])
			GameTooltip:AddDoubleLine(U["Version"], dataFrame.version, .6,.8,1, 1,1,1)
			GameTooltip:AddDoubleLine(U["Character"], dataFrame.name, .6,.8,1, M.ClassColor(dataFrame.class))
		else
			GameTooltip:AddLine(U["Data Exception"], 1,0,0)
		end
		GameTooltip:Show()
	end)
	accept:HookScript("OnLeave", M.HideTooltip)
	dataFrame.text = accept.text
end

local function OpenGUI()
	if f then f:Show() return end

	-- Main Frame
	f = CreateFrame("Frame", "NDuiGUI", UIParent)
	tinsert(UISpecialFrames, "NDuiGUI")
	 local bgTexture = f:CreateTexture("name", "BACKGROUND")
    bgTexture:SetTexture("Interface\\Destiny\\UI-Destiny");  --FontStyles\\FontStyleGarrisons
    bgTexture:SetTexCoord(0,1,0,600/1024);
    bgTexture:SetAllPoints();
    bgTexture:SetAlpha(1)
	f:SetSize(1440, 660)
	f:SetPoint("CENTER")
	f:SetFrameStrata("HIGH")
	f:SetFrameLevel(10)
	M.CreateMF(f)
	M.CreateFS(f, 43, "2 UI", true, "TOP", 0, -62)
	M.CreateFS(f, 21, "v"..I.Version, false, "TOP", 80, -80)

	--local close = M.CreateButton(f, 36, 36, "X")
	--close:SetPoint("TOP", 310, -60)
	--close:SetScript("OnClick", function() f:Hide() end)

	local ok = M.CreateButton(f, 72, 21, "O K")
	ok:SetPoint("BOTTOM", 335, 66)
	ok:SetScript("OnClick", function()
		M:SetupUIScale()
		f:Hide()
		StaticPopup_Show("RELOAD_NDUI")
	end)

	for i, name in pairs(G.TabList) do
		guiTab[i] = CreateTab(f, i, name)
		guiPage[i] = CreateFrame("ScrollFrame", nil, f)
		guiPage[i]:SetPoint("TOPLEFT", 310, -120)
		guiPage[i]:SetSize(880, 520)
		guiPage[i]:Hide()
		guiPage[i].child = CreateFrame("Frame", nil, guiPage[i])
		guiPage[i].child:SetSize(610, 1)
		guiPage[i]:SetScrollChild(guiPage[i].child)
		CreateOption(i)
	end
	local reset = M.CreateButton(f, 72, 21, "Reset")
	reset:SetPoint("BOTTOM", -330, 66)
	StaticPopupDialogs["RESET_NDUI"] = {
		text = CONFIRM_RESET_SETTINGS,
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			MaoRUIPerDB = {}
			MaoRUIDB = {}
			ReloadUI()
		end,
		whileDead = 1,
	}
	reset:SetScript("OnClick", function()
		StaticPopup_Show("RESET_NDUI")
	end)

	local import = M.CreateButton(f, 66, 21, U["Import"])
	import:SetPoint("TOP", -282, -92)
	import:SetScript("OnClick", function()
		f:Hide()
		createDataFrame()
		dataFrame.Header:SetText(U["Import Header"])
		dataFrame.text:SetText(U["Import"])
		dataFrame.editBox:SetText("")
	end)

	local export = M.CreateButton(f, 66, 21, U["Export"])
	export:SetPoint("TOP", 292, -92)
	export:SetScript("OnClick", function()
		f:Hide()
		createDataFrame()
		dataFrame.Header:SetText(U["Export Header"])
		dataFrame.text:SetText(OKAY)
		G:ExportGUIData()
	end)

	--[[local optTip = CreateFrame("Button", nil, f)
	optTip:SetPoint("TOPLEFT", 20, -5)
	optTip:SetSize(45, 45)
	optTip.Icon = optTip:CreateTexture(nil, "ARTWORK")
	optTip.Icon:SetAllPoints()
	optTip.Icon:SetTexture(616343)
	optTip:SetHighlightTexture(616343)
	optTip:SetScript("OnEnter", function()
		GameTooltip:ClearLines()
		GameTooltip:SetOwner(f, "ANCHOR_NONE")
		GameTooltip:SetPoint("TOPRIGHT", f, "TOPLEFT", -5, -3)
		GameTooltip:AddLine(U["Tips"])
		GameTooltip:AddLine(U["Option* Tips"], .6,.8,1, 1)
		GameTooltip:Show()
	end)
	optTip:SetScript("OnLeave", M.HideTooltip)]]

	local credit = CreateFrame("Button", nil, f)
	credit:SetPoint("BOTTOM", 0, 66)
	credit:SetSize(360, 21)
	M.CreateFS(credit, 18, "This GUI learn form Siweia·s NDui，Sincere Gratitude!", true)
	
	--local optTip = M.CreateFS(f, 12, U["Option* Tips"], "system", "CENTER", 0, 0)
	--optTip:SetPoint("TOP", credit, "BOTTOM", 0, -2)

	local function showLater(event)
		if event == "PLAYER_REGEN_DISABLED" then
			if f:IsShown() then
				f:Hide()
				M:RegisterEvent("PLAYER_REGEN_ENABLED", showLater)
			end
		else
			f:Show()
			M:UnregisterEvent(event, showLater)
		end
	end
	M:RegisterEvent("PLAYER_REGEN_DISABLED", showLater)

	SelectTab(1)
end

function G:OnLogin()
	local gui = CreateFrame("Button", "GameMenuFrameNDui", GameMenuFrame, "GameMenuButtonTemplate, BackdropTemplate")
	gui:SetText("2 UI")
	gui:SetPoint("TOP", GameMenuButtonAddons, "BOTTOM", 0, -2)
	GameMenuFrame:HookScript("OnShow", function(self)
		GameMenuButtonLogout:SetPoint("TOP", gui, "BOTTOM", 0, -12)
		self:SetHeight(self:GetHeight() + gui:GetHeight() + 6)
	end)

	gui:SetScript("OnClick", function()
		if InCombatLockdown() then UIErrorsFrame:AddMessage(I.InfoColor..ERR_NOT_IN_COMBAT) return end
		OpenGUI()
		HideUIPanel(GameMenuFrame)
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)
	end)
end

SlashCmdList["MAORUIGUI"] = OpenGUI
SLASH_MAORUIGUI1 = '/mr'
