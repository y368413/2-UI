local _, ns = ...
local M, R, U, I = unpack(ns)
local G = M:RegisterModule("GUI")

local unpack, strfind, gsub = unpack, strfind, gsub
local tonumber, pairs, ipairs, next, type, tinsert = tonumber, pairs, ipairs, next, type, tinsert
local cr, cg, cb = I.r, I.g, I.b
local guiTab, guiPage, f = {}, {}

-- Default Settings
G.DefaultSettings = {
	SL = false,
	Mover = {},
	InternalCD = {},
	AuraWatchMover = {},
	TempAnchor = {},
	AuraWatchList = {
		Switcher = {},
		IgnoreSpells = {},
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
		Bar4Fader = false,
		Bar5Fader = false,
		Scale = 1,
		BindType = 1,
		OverrideWA = false,
		MicroMenu = true,
		CustomBar = false,
		BarXFader = false,
		CustomBarButtonSize = 34,
		CustomBarNumButtons = 12,
		CustomBarNumPerRow = 12,
		ShowStance = true,
		EquipColor = false,
		VehButtonSize = 34,

		Bar1Size = 34,
		Bar1Font = 12,
		Bar1Num = 12,
		Bar1PerRow = 12,
		Bar2Size = 34,
		Bar2Font = 12,
		Bar2Num = 12,
		Bar2PerRow = 12,
		Bar3Size = 32,
		Bar3Font = 12,
		Bar3Num = 0,
		Bar3PerRow = 12,
		Bar4Size = 32,
		Bar4Font = 12,
		Bar4Num = 12,
		Bar4PerRow = 1,
		Bar5Size = 32,
		Bar5Font = 12,
		Bar5Num = 12,
		Bar5PerRow = 1,
		BarPetSize = 26,
		BarPetFont = 12,
		BarPetNum = 10,
		BarPetPerRow = 10,
		BarStanceSize = 30,
		BarStanceFont = 12,
		BarStancePerRow = 10,
	},
	Auras = {
		Reminder = true,
		Totems = true,
		VerticalTotems = true,
		TotemSize = 32,
		ClassAuras = true,
		MMT29X4 = false,
		BuffFrame = true,
		HideBlizBuff = false,
		ReverseBuff = false,
		BuffSize = 30,
		BuffsPerRow = 16,
		ReverseDebuff = false,
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
		ShowAuras = true,
		Arena = true,
		Castbars = false,
		SwingBar = false,
		SwingWidth = 275,
		SwingHeight = 3,
		SwingTimer = false,
		OffOnTop = false,
		RaidFrame = true,
		AutoRes = true,
		NumGroups = 8,
		RaidDirec = 1,
		RaidRows = 1,
		SimpleMode = true,
		SMRScale = 12,
		SMRPerCol = 20,
		SMRGroupBy = 1,
		SMRGroups = 6,
		SMRDirec = 1,
		InstanceAuras = true,
		DispellOnly = false,
		RaidDebuffScale = 1,
		SpecRaidPos = false,
		RaidHealthColor = 2,
		HorizonRaid = false,
		HorizonParty = false,
		ReverseRaid = false,
		ShowSolo = false,
		RaidWidth = 88,
		RaidHeight = 16,
		RaidPowerHeight = 2,
		RaidHPMode = 1,
		AurasClickThrough = false,
		HotsDots = true,
		AutoAttack = true,
		FCTOverHealing = false,
		PetCombatText = true,
		RaidClickSets = true,
		TeamIndex = false,
		ClassPower = true,
		CPWidth = 150,
		CPHeight = 5,
		CPxOffset = 12,
		CPyOffset = -2,
		QuakeTimer = true,
		LagString = false,
		RuneTimer = true,
		RaidBuffIndicator = true,
		PartyFrame = true,
		PartyDirec = 2,
		PartyWatcher = true,
		PWOnRight = true,
		PartyWidth = 120,
		PartyHeight = 26,
		PartyPowerHeight = 6,
		PartyPetFrame = false,
		PartyPetWidth = 120,
		PartyPetHeight = 16,
		PartyPetPowerHeight = 2,
		PartyPetPerCol = 5,
		PartyPetMaxCol = 1,
		PartyPetVsby = 1,
		PetDirec = 1,
		HealthColor = 2,
		BuffIndicatorType = 2,
		BuffIndicatorScale = 1,
		UFTextScale = 1,
		PartyAltPower = true,
		PartyWatcherSync = true,
		RaidTextScale = 0.85, 
		FrequentHealth = false,
		HealthFrequency = .25,
		ShowRaidBuff = false,
		RaidBuffSize = 12,
		ShowRaidDebuff = true,
		RaidDebuffSize = 12,
		SmartRaid = false,
		Desaturate = true,
		DebuffColor = true,
		CCName = true,
		RCCName = true,
		HideTip = false,
		DescRole = true,

		PlayerWidth = 245,
		PlayerHeight = 24,
		PlayerPowerHeight = 6,
		PlayerPowerOffset = 2,
		PlayerHPTag = 2,
		PlayerMPTag = 4,
		FocusWidth = 160,
		FocusHeight = 21,
		FocusPowerHeight = 3,
		FocusPowerOffset = 2,
		FocusHPTag = 2,
		FocusMPTag = 4,
		PetWidth = 100,
		PetHeight = 16,
		PetPowerHeight = 2,
		PetHPTag = 4,
		BossWidth = 120,
		BossHeight = 21,
		BossPowerHeight = 3,
		BossHPTag = 5,
		BossMPTag = 5,
		OwnCastColor = {r=.3, g=.7, b=1},
		CastingColor = {r=.8, g=.6, b=.1},  --r=.3, g=.7, b=1
		NotInterruptColor = {r=.6, g=.6, b=.6},  --r=1, g=.5, b=.5
		PlayerCB = false,
		PlayerCBWidth = 240,
		PlayerCBHeight = 16,
		TargetCB = false,
		TargetCBWidth = 280,
		TargetCBHeight = 21,
		FocusCB = false,
		FocusCBWidth = 245,
		FocusCBHeight = 18,

		PlayerNumBuff = 20,
		PlayerNumDebuff = 20,
		PlayerBuffType = 1,
		PlayerDebuffType = 1,
		PlayerAurasPerRow = 9,
		TargetNumBuff = 20,
		TargetNumDebuff = 20,
		TargetBuffType = 2,
		TargetDebuffType = 2,
		TargetAurasPerRow = 9,
		FocusNumBuff = 20,
		FocusNumDebuff = 20,
		FocusBuffType = 3,
		FocusDebuffType = 2,
		FocusAurasPerRow = 8,
		ToTNumBuff = 6,
		ToTNumDebuff = 6,
		ToTBuffType = 1,
		ToTDebuffType = 1,
		ToTAurasPerRow = 5,
		PetNumBuff = 6,
		PetNumDebuff = 6,
		PetBuffType = 1,
		PetDebuffType = 1,
		PetAurasPerRow = 5,
		BossNumBuff = 6,
		BossNumDebuff = 6,
		BossBuffType = 2,
		BossDebuffType = 3,
		BossBuffPerRow = 6,
		BossDebuffPerRow = 6,
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
		BlockSpammer = false,
		ChatBGType = 1,
		WhisperSound = true,
		BottomBox = false,
		Outline = false,
	},
	Map = {
		DisableMap = false,
		Clock = false,
		CombatPulse = false,
		MapScale = 1,
		MaxMapScale = 0.85,
		MinimapScale = 1,
		MinimapSize = 186,
		ShowRecycleBin = false,
		WhoPings = true,
		MapReveal = false,
		MapRevealGlow = true,
		Calendar = false,
		zrMMbordersize = 2,
		zrMMbuttonsize = 18,
		zrMMbuttonpos = "Bottom",
		zrMMcustombuttons = {},
	},
	Nameplate = {
		Enable = true,
		maxAuras = 6,
		PlateAuras = true,
		AuraSize = 26,
		AuraFilter = 3,
		FriendlyCC = false,
		HostileCC = true,
		TankMode = false,
		TargetIndicator = 3,
		InsideView = true,
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
		NameType = 5,
		HealthType = 5,
		SecureColor = {r=1, g=0, b=1},
		TransColor = {r=1, g=.8, b=0},
		InsecureColor = {r=1, g=0, b=0},
		OffTankColor = {r=.2, g=.7, b=.5},
		DPSRevertThreat = false,
		ExplosivesScale = true,
		AKSProgress = true,
		PPFadeout = true,
		PPFadeoutAlpha = 0,
		PPOnFire = false,
		TargetPower = false,
		MinScale = 1,
		MinAlpha = 1,
		Desaturate = true,
		DebuffColor = true,
		QuestIndicator = true,
		NameOnlyMode = false,
		PPGCDTicker = true,
		ExecuteRatio = 0,
		ColoredTarget = false,
		TargetColor = {r=0, g=.6, b=1},
		ColoredFocus = false,
		FocusColor = {r=1, g=.8, b=0},
		CastbarGlow = true,
		CastTarget = false,
		FriendPlate = false,
		EnemyThru = false,
		FriendlyThru = false,
		BlockDBM = true,

		PlateWidth = 160,
		PlateHeight = 8,
		PlateCBHeight = 6,
		PlateCBOffset = 0,
		CBTextSize = 14,
		NameTextSize = 15,
		HealthTextSize = 16,
		HealthTextOffset = 5,
		FriendPlateWidth = 150,
		FriendPlateHeight = 8,
		FriendPlateCBHeight = 6,
		FriendPlateCBOffset = 0,
		FriendCBTextSize = 14,
		FriendNameSize = 14,
		FriendHealthSize = 16,
		FriendHealthOffset = 5,
		HarmWidth = 190,
		HarmHeight = 60,
		HelpWidth = 190,
		HelpHeight = 60,
		NameOnlyTextSize = 14,
		NameOnlyTitleSize = 12,
		NameOnlyTitle = true,
		NameOnlyGuild = false,
		CVarOnlyNames = false,
		CVarShowNPCs = false,
	},
	Skins = {
		DBM = true,
		Skada = false,
		Bigwigs = true,
		TMW = true,
		PetBattle = true,
		WeakAuras = true,
		InfobarLine = true,
		ChatbarLine = false,
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
		BgTex = true,
		GreyBD = false,
		FontScale = 1,
		CastBarstyle = true,
		QuestTrackerSkinTitle = true,
	},
	Tooltip = {
		CombatHide = true,
		CursorMode = 4,
		ItemQuality = false,
		TipAnchor = 4,
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
		ConduitInfo = true,
		HideAllID = false,
		MythicScore = true,
		DomiRank = true,
		QuestCompleteAnnoce = false,
	},
	Misc = {
		Mail = true,
		MailSaver = false,
		MailTarget = "",
		ItemLevel = true,
		GemNEnchant = true,
		AzeriteTraits = true,
		MissingStats = true,
		SoloInfo = true,
		RareAlerter = true,
		RarePrint = true,
		Focuser = true,
		ExpRep = true,
		Screenshot = true,
		TradeTabs = true,
		InterruptAlert = true,
		OwnInterrupt = true,
		InterruptSound = true,
		DispellAlert = false,
		OwnDispell = true,
		InstAlertOnly = false,
		BrokenAlert = false,
		FasterLoot = true,
		AutoQuest = true,
		IgnoreQuestNPC = {},
		HideTalking = true,
		HideBossBanner = false,
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
		EasyMarkKey = 1,
		ShowMarkerBar = 4,
		MarkerSize = 28,
		BlockInvite = false,
		NzothVision = true,
		SendActionCD = false,
		MawThreatBar = true,
		MDGuildBest = true,
		FasterSkip = false,
		EnhanceDressup = true,
		QuestTool = true,
		InfoStrLeft = "[spec][time][guild][friend][ping][fps][gold][dura][bag]",
		InfoStrRight = "[zone]",
		InfoSize = 13,
		MaxAddOns = 21,
		MenuButton = false,
		QuickJoin = true,
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
	ShowSlots = false,
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
	RaidClickSets = {},
	TexStyle = 3,
	KeystoneInfo = {},
	AutoBubbles = false,
	DisableInfobars = false,
	ContactList = {},
	CustomJunkList = {},
	ProfileIndex = {},
	ProfileNames = {},
	Help = {},
	PartySpells = {},
	CornerSpells = {},
	CustomTex = "",
	MajorSpells = {},
	SmoothAmount = .25,
	AutoRecycle = true,
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

	InitialSettings(G.AccountSettings, MaoRUIDB)
	if not next(MaoRUISetDB) then
		for i = 1, 5 do MaoRUISetDB[i] = {} end
	end

	if not MaoRUIDB["ProfileIndex"][I.MyFullName] then
		MaoRUIDB["ProfileIndex"][I.MyFullName] = 1
	end

	if MaoRUIDB["ProfileIndex"][I.MyFullName] == 1 then
		R.db = MaoRUIPerDB
		if not R.db["SL"] then
			wipe(R.db)
			R.db["SL"] = true
		end
	else
		R.db = MaoRUISetDB[MaoRUIDB["ProfileIndex"][I.MyFullName] - 1]
	end
	InitialSettings(G.DefaultSettings, R.db, true)

	M:SetupUIScale(true)
	if MaoRUIDB["CustomTex"] ~= "" then
		I.normTex = "Interface\\"..MaoRUIDB["CustomTex"]
	else
		if not G.TextureList[MaoRUIDB["TexStyle"]] then
			MaoRUIDB["TexStyle"] = 2 -- reset value if not exists
		end
		I.normTex = G.TextureList[MaoRUIDB["TexStyle"]].texture
	end

	self:UnregisterAllEvents()
end)

-- Callbacks
local function setupCastbar()
	G:SetupCastbar(guiPage[4])
end

local function setupClassPower()
	G:SetupUFClassPower(guiPage[3])
end

local function setupUFAuras()
	G:SetupUFAuras(guiPage[3])
end

local function setupSwingBars()
	G:SetupSwingBars(guiPage[1])
end

local function setupRaidFrame()
	G:SetupRaidFrame(guiPage[2])
end

local function setupSimpleRaidFrame()
	G:SetupSimpleRaidFrame(guiPage[2])
end

local function setupPartyFrame()
	G:SetupPartyFrame(guiPage[2])
end

local function setupPartyPetFrame()
	G:SetupPartyPetFrame(guiPage[2])
end

local function setupRaidDebuffs()
	G:SetupRaidDebuffs(guiPage[2])
end

local function setupClickCast()
	G:SetupClickCast(guiPage[2])
end

local function setupBuffIndicator()
	G:SetupBuffIndicator(guiPage[2])
end

local function setupPartyWatcher()
	G:SetupPartyWatcher(guiPage[2])
end

local function setupNameplateFilter()
	G:SetupNameplateFilter(guiPage[3])
end

local function setupNameplateSize()
	G:SetupNameplateSize(guiPage[3])
end

local function setupNameOnlySize()
	G:SetupNameOnlySize(guiPage[3])
end
local function setupPlateCastbarGlow()
	G:PlateCastbarGlow(guiPage[3])
end

local function setupBuffFrame()
	G:SetupBuffFrame(guiPage[7])
end

local function setupAuraWatch()
	f:Hide()
	SlashCmdList["NDUI_AWCONFIG"]()
end

local function setupActionBar()
	G:SetupActionBar(guiPage[1])
end

local function setupStanceBar()
	G:SetupStanceBar(guiPage[1])
end

local function updateCustomBar()
	M:GetModule("Actionbar"):UpdateCustomBar()
end

local function updateHotkeys()
	local Bar = M:GetModule("Actionbar")
	for _, button in pairs(Bar.buttons) do
		if button.UpdateHotkeys then
			button:UpdateHotkeys(button.buttonType)
		end
	end
end

local function updateEquipColor()
	local Bar = M:GetModule("Actionbar")
	for _, button in pairs(Bar.buttons) do
		if button.Border and button.Update then
			Bar.UpdateEquipItemColor(button)
		end
	end
end

local function toggleBarFader(self)
	local name = gsub(self.__value, "Fader", "")
	M:GetModule("Actionbar"):ToggleBarFader(name)
end

local function updateReminder()
	M:GetModule("Auras"):InitReminder()
end

local function refreshTotemBar()
	if not R.db["Auras"]["Totems"] then return end
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

local function toggleLanguageFilter()
	M:GetModule("Chat"):ToggleLanguageFilter()
end

local function toggleEditBoxAnchor()
	M:GetModule("Chat"):ToggleEditBoxAnchor()
end

local function updateToggleDirection()
	M:GetModule("Skins"):RefreshToggleDirection()
end

local function updatePlateCVars()
	M:GetModule("UnitFrames"):UpdatePlateCVars()
end

local function updateClickableSize()
	M:GetModule("UnitFrames"):UpdateClickableSize()
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

local function updateClickThru()
	M:GetModule("UnitFrames"):UpdatePlateClickThru()
end

local function togglePlatePower()
	M:GetModule("UnitFrames"):TogglePlatePower()
end

local function togglePlateVisibility()
	M:GetModule("UnitFrames"):TogglePlateVisibility()
end

local function togglePlayerPlate()
	refreshNameplates()
	M:GetModule("UnitFrames"):TogglePlayerPlate()
end

local function toggleTargetClassPower()
	refreshNameplates()
	M:GetModule("UnitFrames"):ToggleTargetClassPower()
end

local function toggleGCDTicker()
	M:GetModule("UnitFrames"):ToggleGCDTicker()
end

local function toggleFocusCalculation()
	local A = M:GetModule("Auras")
	if A.ToggleFocusCalculation then
		A:ToggleFocusCalculation()
	end
end

local function updateUFTextScale()
	M:GetModule("UnitFrames"):UpdateTextScale()
end

local function toggleUFClassPower()
	M:GetModule("UnitFrames"):ToggleUFClassPower()
end

local function toggleAllAuras()
	M:GetModule("UnitFrames"):ToggleAllAuras()
end

local function updateRaidTextScale()
	M:GetModule("UnitFrames"):UpdateRaidTextScale()
end

local function refreshRaidFrameIcons()
	M:GetModule("UnitFrames"):RefreshRaidFrameIcons()
end

local function updateRaidAuras()
	M:GetModule("UnitFrames"):UpdateRaidAuras()
end

local function updateRaidHealthMethod()
	M:GetModule("UnitFrames"):UpdateRaidHealthMethod()
end

local function toggleCastBarLatency()
	M:GetModule("UnitFrames"):ToggleCastBarLatency()
end

local function toggleSwingBars()
	M:GetModule("UnitFrames"):ToggleSwingBars()
end

local function updateSmoothingAmount()
	M:SetSmoothingAmount(MaoRUIDB["SmoothAmount"])
end

local function updateAllHeaders()
	M:GetModule("UnitFrames"):UpdateAllHeaders()
end

local function updateTeamIndex()
	local UF = M:GetModule("UnitFrames")
	if UF.CreateAndUpdateRaidHeader then
		UF:CreateAndUpdateRaidHeader()
		UF:UpdateRaidTeamIndex()
	end
	updateRaidTextScale()
end

local function updatePartyElements()
	M:GetModule("UnitFrames"):UpdatePartyElements()
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

local function updateInfobarAnchor(self)
	if self:GetText() == "" then
		self:SetText(self.__default)
		R.db[self.__key][self.__value] = self:GetText()
	end

	if not MaoRUIDB["DisableInfobars"] then
		M:GetModule("Infobar"):Infobar_UpdateAnchor()
	end
end

local function updateInfobarSize()
	M:GetModule("Infobar"):UpdateInfobarSize()
end

local function updateSkinAlpha()
	for _, frame in pairs(R.frames) do
		frame:SetBackdropColor(0, 0, 0, R.db["Skins"]["SkinAlpha"])
	end
end

local function AddTextureToOption(parent, index)
	local tex = parent[index]:CreateTexture()
	tex:SetInside(nil, 4, 4)
	tex:SetTexture(G.TextureList[index].texture)
	tex:SetVertexColor(cr, cg, cb)
end

-- Config
local HeaderTag = "|cff00cc4c"
local NewTag = "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0|t"
G.HealthValues = {DISABLE, U["ShowHealthDefault"], U["ShowHealthCurMax"], U["ShowHealthCurrent"], U["ShowHealthPercent"], U["ShowHealthLoss"], U["ShowHealthLossPercent"]}

G.TabList = {
	U["Actionbar"],
	U["RaidFrame"],
	U["Nameplate"],
	U["ChatFrame"],
	U["Profile"],
	U["Skins"],
	NewTag..U["Misc"],
	U["UI Settings"],
	U["Auras"],
}

G.OptionList = {		-- type, key, value, name, horizon, horizon2, doubleline
	[1] = {
		{1, "Actionbar", "Enable", HeaderTag..U["Enable Actionbar"]}, --, nil, nil, setupActionBar
		{1, "Actionbar", "MicroMenu", U["Micromenu"], true},
		{1, "Actionbar", "ShowStance", U["ShowStanceBar"], true, true, setupStanceBar},
		{1, "Actionbar", "Bar4Fader", U["Bar4 Fade"].."*", nil, nil, nil, toggleBarFader},
		{1, "Actionbar", "Bar5Fader", U["Bar5 Fade"].."*", true, nil, nil, toggleBarFader},
		--{},--blank
		{1, "Actionbar", "CustomBar", HeaderTag..U["Enable CustomBar"], nil, nil, nil, nil, U["CustomBarTip"]},
		{1, "Actionbar", "BarXFader", U["CustomBarFader"].."*", true, nil, nil, toggleBarFader},
		{4, "Actionbar", "Style", U["Actionbar Style"], true, true, {"-- 2*(3+12+3) --", "-- 2*(6+12+6) --", "-- 2*6+3*12+2*6 --", "-- 3*12 --", "-- 2*(12+6) --", "-- 3*(4+12+4) --", "-- What --", "-- MR --", "-- PVP2 --", "-- Cool --", "-- JK --"}},  --nop
		{3, "Actionbar", "CustomBarButtonSize", U["ButtonSize"].."*", false, false, {24, 60, 1}, updateCustomBar},
		{3, "Actionbar", "CustomBarNumButtons", U["MaxButtons"].."*", true, false, {1, 12, 1}, updateCustomBar},
		{3, "Actionbar", "CustomBarNumPerRow", U["ButtonsPerRow"].."*", true, true, {1, 12, 1}, updateCustomBar},
		{},--blank
		{1, "Actionbar", "Cooldown", HeaderTag..U["Show Cooldown"]},
		{1, "Actionbar", "OverrideWA", U["HideCooldownOnWA"].."*", true},
		{1, "Actionbar", "DecimalCD", U["Decimal Cooldown"].."*"},
		--{1, "Misc", "SendActionCD", HeaderTag..U["SendActionCD"].."*", true, nil, nil, U["SendActionCDTip"]},
		{1, "Actionbar", "Hotkeys", U["Actionbar Hotkey"].."*", true, nil, nil, updateHotkeys},
		{},--blank
		{1, "Actionbar", "Macro", U["Actionbar Macro"]},
		{1, "Actionbar", "Count", U["Actionbar Item Counts"], true},
		{1, "Actionbar", "Classcolor", U["ClassColor BG"], true, true},
		--{1, "Actionbar", "EquipColor", U["EquipColor"].."*", true, nil, updateEquipColor},
		--{1, "Actionbar", "Bar4Fade", U["Bar4 Fade"]},
		--{1, "Actionbar", "Bar5Fade", U["Bar5 Fade"], true},
		--{1, "UFs", "LagString", U["Castbar LagString"].."*", true, nil, nil, toggleCastBarLatency},
		{1, "UFs", "SwingBar", U["UFs SwingBar"].."*", nil, nil, setupSwingBars, toggleSwingBars},
		{1, "UFs", "QuakeTimer", U["UFs QuakeTimer"], true},
		--{1, "UFs", "ClassPower", U["UFs ClassPower"], true, true},		
		{3, "Tooltip", "Scale", U["Tooltip Scale"].."*", false, false, {.5, 1.5, .1}},
		{3, "Misc", "WorldQusetRewardIconsSize", "WorldQusetRewardIconsSize", true, false, {21, 66, 1}},
		{3, "UFs", "PlayerFrameScale", U["PlayerFrame Scale"], true, true, {0.6, 1.2, .1}},	
		{3, "Map", "MapScale", U["Map Scale"].."*", false, nil, {.8, 2, .1}},
		{3, "Map", "MaxMapScale", U["Maximize Map Scale"].."*", true, nil, {.5, 1, .1}},
		{3, "Map", "MinimapScale", U["Minimap Scale"].."*", true, true, {1, 2, .1}, updateMinimapScale},
	},
	[2] = {
		{1, "UFs", "RaidFrame", HeaderTag..U["UFs RaidFrame"], nil, nil, setupRaidFrame, nil, U["RaidFrameTip"]},
		{1, "UFs", "SimpleMode", U["SimpleRaidFrame"], true, nil, setupSimpleRaidFrame, nil, U["SimpleRaidFrameTip"]},
		{1, "UFs", "PartyFrame", NewTag..HeaderTag..U["PartyFrame"], true, true, setupPartyFrame, nil, U["PartyFrameTip"]},
		{1, "UFs", "PartyPetFrame", HeaderTag..U["PartyPetFrame"], nil, nil, setupPartyPetFrame, nil, U["PartyPetTip"]},
		{1, "UFs", "PartyWatcher", HeaderTag..U["UFs PartyWatcher"], true, nil, setupPartyWatcher, nil, U["PartyWatcherTip"]},
		{1, "UFs", "PWOnRight", U["PartyWatcherOnRight"].."*", true, true, nil, updatePartyElements},
		{1, "UFs", "PartyWatcherSync", U["PartyWatcherSync"], nil, nil, nil, nil, U["PartyWatcherSyncTip"]},
		{1, "UFs", "ShowRaidDebuff", U["ShowRaidDebuff"].."*", true, nil, nil, updateRaidAuras, U["ShowRaidDebuffTip"]},
		{1, "UFs", "ShowRaidBuff", U["ShowRaidBuff"].."*", true, true, nil, updateRaidAuras, U["ShowRaidBuffTip"]},
		{3, "UFs", "RaidDebuffSize", U["RaidDebuffSize"].."*", nil, nil, {5, 30, 1}, updateRaidAuras},
		{3, "UFs", "RaidBuffSize", U["RaidBuffSize"].."*", true, nil, {5, 30, 1}, updateRaidAuras},
		{3, "UFs", "RaidDebuffScale", U["RaidDebuffScale"].."*", true, true, {.8, 2, .1}, refreshRaidFrameIcons},
		{4, "UFs", "BuffIndicatorType", U["BuffIndicatorType"].."*", nil, nil, {U["BI_Blocks"], U["BI_Icons"], U["BI_Numbers"]}, refreshRaidFrameIcons},
		{4, "UFs", "RaidHealthColor", U["HealthColor"].."*", true, nil, {U["Default Dark"], U["ClassColorHP"], U["GradientHP"]}, updateRaidTextScale},
		{4, "UFs", "RaidHPMode", U["HealthValueType"].."*", true, true, {DISABLE, U["ShowHealthPercent"], U["ShowHealthCurrent"], U["ShowHealthLoss"], U["ShowHealthLossPercent"]}, updateRaidTextScale, U["100PercentTip"]},
		{3, "UFs", "BuffIndicatorScale", U["BuffIndicatorScale"].."*", nil, nil, {.8, 2, .1}, refreshRaidFrameIcons},
		{3, "UFs", "RaidTextScale", U["UFTextScale"].."*", true, nil, {.8, 1.5, .05}, updateRaidTextScale},
		{3, "UFs", "HealthFrequency", U["HealthFrequency"].."*", true, true, {.1, .5, .05}, updateRaidHealthMethod, U["HealthFrequencyTip"]},
		{},--blank		
		{1, "UFs", "InstanceAuras", HeaderTag..U["Instance Auras"], nil, nil, setupRaidDebuffs, nil, U["InstanceAurasTip"]},
		{1, "UFs", "DispellOnly", U["DispellableOnly"].."*", true, nil, nil, nil, U["DispellableOnlyTip"]},
		{1, "UFs", "AurasClickThrough", U["RaidAuras ClickThrough"], true, true, nil, nil, U["ClickThroughTip"]},
		{1, "UFs", "RaidClickSets", HeaderTag..U["Enable ClickSets"], nil, nil, setupClickCast},
		{1, "UFs", "AutoRes", HeaderTag..U["UFs AutoRes"], true},
		{1, "UFs", "RaidBuffIndicator", HeaderTag..U["RaidBuffIndicator"], true, true, setupBuffIndicator, nil, U["RaidBuffIndicatorTip"]},
		{1, "UFs", "ShowSolo", U["ShowSolo"].."*", nil, nil, nil, updateAllHeaders, U["ShowSoloTip"]},
		{1, "UFs", "SmartRaid", HeaderTag..U["SmartRaid"].."*", true, nil, nil, updateAllHeaders, U["SmartRaidTip"]},
		{1, "UFs", "TeamIndex", U["RaidFrame TeamIndex"].."*", true, true, nil, updateTeamIndex},
		--{1, "UFs", "RCCName", U["ClassColor Name"].."*", nil, nil, nil, updateRaidTextScale},
		{1, "UFs", "FrequentHealth", HeaderTag..U["FrequentHealth"].."*", true, nil, nil, updateRaidHealthMethod, U["FrequentHealthTip"]},
		--{1, "UFs", "HideTip", U["HideTooltip"].."*", true, true, nil, updateRaidTextScale, U["HideTooltipTip"]},
		{1, "UFs", "SpecRaidPos", U["Spec RaidPos"], nil, nil, nil, nil, U["SpecRaidPosTip"]},
	},
	[3] = {
		{1, "Nameplate", "Enable", HeaderTag..U["Enable Nameplate"], nil, nil, nil, setupNameplateSize, refreshNameplates},
		{1, "Nameplate", "FriendPlate", U["FriendPlate"].."*", true, nil, nil, refreshNameplates, U["FriendPlateTip"]},
		{1, "Nameplate", "NameOnlyMode", U["NameOnlyMode"].."*", true, true, nil, nil, U["NameOnlyModeTip"]},
		{4, "Nameplate", "NameType", U["NameTextType"].."*", nil, nil, {DISABLE, U["Tag:name"], U["Tag:levelname"], U["Tag:rarename"], U["Tag:rarelevelname"]}, refreshNameplates, U["PlateLevelTagTip"]},
		{4, "Nameplate", "HealthType", U["HealthValueType"].."*", true, nil, G.HealthValues, refreshNameplates, U["100PercentTip"]},
		{4, "Nameplate", "AuraFilter", U["NameplateAuraFilter"].."*", true, true, {U["BlackNWhite"], U["PlayerOnly"], U["IncludeCrowdControl"]}, refreshNameplates},
		--{1, "Nameplate", "PlateAuras", HeaderTag..U["PlateAuras"].."*", nil, nil, nil, setupNameplateFilter, refreshNameplates},
		--{1, "Nameplate", "Desaturate", U["DesaturateIcon"].."*", true, nil, nil, refreshNameplates, U["DesaturateIconTip"]},
		--{1, "Nameplate", "DebuffColor", U["DebuffColor"].."*", true, true, nil, refreshNameplates, U["DebuffColorTip"]},
		{3, "Nameplate", "maxAuras", U["Max Auras"].."*", nil, nil, {1, 20, 1}, refreshNameplates},
		{3, "Nameplate", "AuraSize", U["Auras Size"].."*", true, nil, {18, 40, 1}, refreshNameplates},
		--{4, "Nameplate", "TargetIndicator", U["TargetIndicator"].."*", nil, nil, {DISABLE, U["TopArrow"], U["RightArrow"], U["TargetGlow"], U["TopNGlow"], U["RightNGlow"]}, refreshNameplates},
		{3, "Nameplate", "ExecuteRatio", "|cffff0000"..U["ExecuteRatio"].."*", true, true, {0, 90, 1}, nil, U["ExecuteRatioTip"]},
		{1, "Nameplate", "FriendlyCC", U["Friendly CC"].."*"},
		{1, "Nameplate", "HostileCC", U["Hostile CC"].."*", true},
		{1, "Nameplate", "FriendlyThru", U["Friendly ClickThru"].."*", nil, nil, nil, updateClickThru},
		{1, "Nameplate", "EnemyThru", U["Enemy ClickThru"].."*", true, nil, nil, updateClickThru},
		{1, "Nameplate", "CastbarGlow", U["PlateCastbarGlow"].."*", true, true, setupPlateCastbarGlow, nil, U["PlateCastbarGlowTip"]},
		{1, "Nameplate", "CastTarget", U["PlateCastTarget"].."*", nil, nil, nil, nil, U["PlateCastTargetTip"]},
		{1, "Nameplate", "InsideView", U["Nameplate InsideView"].."*", true, nil, nil, updatePlateInsideView},
		--{1, "Nameplate", "ExplosivesScale", U["ExplosivesScale"], true, true, nil, nil, U["ExplosivesScaleTip"]},
		--{1, "Nameplate", "QuestIndicator", U["QuestIndicator"]},
		--{1, "Nameplate", "AKSProgress", U["AngryKeystones Progress"], true},
		{1, "Nameplate", "BlockDBM", U["BlockDBM"], true, true, nil, nil, U["BlockDBMTip"]},
		{1, "Nameplate", "CustomUnitColor", HeaderTag..U["CustomUnitColor"].."*", nil, nil, nil, updateCustomUnitList, U["CustomUnitColorTip"]},
		{1, "Nameplate", "TankMode", HeaderTag..U["Tank Mode"].."*", true, nil, nil, nil, U["TankModeTip"]},
		{1, "Nameplate", "DPSRevertThreat", U["DPS Revert Threat"].."*", true, true, nil, nil, U["RevertThreatTip"]},	
		--{2, "Nameplate", "UnitList", U["UnitColor List"].."*", nil, nil, nil, updateCustomUnitList, U["CustomUnitTips"]},
		--{2, "Nameplate", "ShowPowerList", U["ShowPowerList"].."*", true, nil, nil, updatePowerUnitList, U["CustomUnitTips"]},
		{3, "Nameplate", "MinScale", U["Nameplate MinScale"].."*", false, nil, {.5, 1, .1}, updatePlateCVars},
		{3, "Nameplate", "MinAlpha", U["Nameplate MinAlpha"].."*", true, nil, {.3, 1, .1}, updatePlateCVars},
		{3, "Nameplate", "VerticalSpacing", U["NP VerticalSpacing"].."*", true, true, {.5, 1.5, .1}, updatePlateCVars},
		{3, "Nameplate", "HarmWidth", NewTag..U["PlateHarmWidth"].."*", nil, nil, {1, 500, 1}, updateClickableSize},
		{3, "Nameplate", "HarmHeight", NewTag..U["PlateHarmHeight"].."*", true, nil, {1, 500, 1}, updateClickableSize},
		{3, "Nameplate", "HelpWidth", NewTag..U["PlateHelpWidth"].."*", true, true, {1, 500, 1}, updateClickableSize},
		{3, "Nameplate", "HelpHeight", NewTag..U["PlateHelpHeight"].."*", nil, nil, {1, 500, 1}, updateClickableSize},
		{1, "Nameplate", "CVarOnlyNames", NewTag..U["CVarOnlyNames"], true, nil, nil, updatePlateCVars, U["CVarOnlyNamesTip"]},
		{1, "Nameplate", "CVarShowNPCs", NewTag..U["CVarShowNPCs"].."*", true, true, nil, updatePlateCVars, U["CVarShowNPCsTip"]},
	},
	[4] = {
		{1, "Chat", "Lock", HeaderTag..U["Lock Chat"]},
		{1, "Chat", "Outline", U["Font Outline"], true},
		{1, "Chat", "Sticky", U["Chat Sticky"].."*", true, true, nil, updateChatSticky},
		{3, "Chat", "ChatWidth", U["LockChatWidth"].."*", nil, nil, {200, 600, 1}, updateChatSize},
		{3, "Chat", "ChatHeight", U["LockChatHeight"].."*", true, nil, {100, 500, 1}, updateChatSize},
		{3, "Chat", "Matches", U["Keyword Match"].."*", true, true, {1, 3, 1}},
		{},--blank
		--{1, "Chat", "Chatbar", U["ShowChatbar"]},
		--{1, "Chat", "WhisperColor", U["Differ WhipserColor"].."*"},
		{1, "Chat", "ChatItemLevel", U["ShowChatItemLevel"]},
		--{1, "Chat", "Freedom", U["Language Filter"]},
		{1, "Chat", "WhisperSound", U["WhisperSound"].."*", true, nil, nil, nil, U["WhisperSoundTip"]},
		--{1, "Chat", "BottomBox", U["BottomBox"].."*", true, true, nil, toggleEditBoxAnchor},
		{4, "ACCOUNT", "TimestampFormat", U["TimestampFormat"].."*", nil, nil, {DISABLE, "03:27 PM", "03:27:32 PM", "15:27", "15:27:32"}},
		{4, "Chat", "ChatBGType", U["ChatBGType"].."*", true, nil, {DISABLE, U["Default Dark"], U["Gradient"]}, toggleChatBackground},
		{},--blank
		{1, "Chat", "EnableFilter", HeaderTag..U["Enable Chatfilter"]},
		{1, "Chat", "BlockAddonAlert", U["Block Addon Alert"], true},
		{1, "Chat", "BlockSpammer", U["BlockSpammer"].."*", true, true, nil, nil, U["BlockSpammerTip"]},
		{1, "Chat", "Invite", HeaderTag..U["Whisper Invite"]},
		{1, "Chat", "GuildInvite", U["Guild Invite Only"].."*", true},
		{1, "Chat", "BlockStranger", "|cffff0000"..U["BlockStranger"].."*", true, true, nil, nil, U["BlockStrangerTip"]},
		{2, "ACCOUNT", "ChatFilterWhiteList", HeaderTag..U["ChatFilterWhiteList"].."*", nil, nil, nil, updateFilterWhiteList, U["ChatFilterWhiteListTip"]},
		{2, "ACCOUNT", "ChatFilterList", U["Filter List"].."*", true, nil, nil, updateFilterList, U["FilterListTip"]},
		{2, "Chat", "Keyword", U["Whisper Keyword"].."*", true, true, nil, updateWhisperList, U["WhisperKeywordTip"]},
	},
	[5] = {
		--{1, "ACCOUNT", "VersionCheck", U["Version Check"]},
		{1, "ACCOUNT", "LockUIScale", U["Lock UIScale"]},
		{3, "ACCOUNT", "UIScale", U["Setup UIScale"], true, nil, {.4, 1.15, .01}},
		{3, "ACCOUNT", "SmoothAmount", U["SmoothAmount"].."*", true, true, {.1, 1, .05}, updateSmoothingAmount, U["SmoothAmountTip"]},
		--{},--blank
		--{1, "ACCOUNT", "DisableInfobars", "|cffff0000"..U["DisableInfobars"]},
		--{3, "Misc", "MaxAddOns", U["SysMaxAddOns"].."*", nil, nil,  {1, 50, 1}, nil, U["SysMaxAddOnsTip"]},
		--{3, "Misc", "InfoSize", U["InfobarFontSize"].."*", true, nil,  {10, 50, 1}, updateInfobarSize},
		--{2, "Misc", "InfoStrLeft", U["LeftInfobar"].."*", nil, nil, nil, updateInfobarAnchor, U["InfobarStrTip"]},
		--{2, "Misc", "InfoStrRight", U["RightInfobar"].."*", true, nil, nil, updateInfobarAnchor, U["InfobarStrTip"]},
		{4, "ACCOUNT", "TexStyle", U["Texture Style"], false, nil, {}},
		{4, "ACCOUNT", "NumberFormat", U["Numberize"], true, nil, {U["Number Type1"], U["Number Type2"], U["Number Type3"]}},
		{2, "ACCOUNT", "CustomTex", U["CustomTex"], true, true, nil, nil, U["CustomTexTip"]},
	},
	[6] = {
		{1, "UFs", "UFFade", U["UFFade"]},
		{1, "UFs", "UFClassIcon", U["UFClassIcon"], true},
		{1, "UFs", "UFPctText", U["UFPctText"], true, true},
		{1, "Misc", "xMerchant", U["xMerchant"]},
		{1, "Misc", "WallpaperKit", U["WallpaperKit"], true},
		{1, "Skins", "FlatMode", U["FlatMode"], true, true},
		{},--blank
		{1, "Map", "DisableMap", "|cffff0000"..U["DisableMap"], nil, nil, nil, nil, U["DisableMapTip"]},
		{1, "Map", "MapRevealGlow", U["MapRevealGlow"].."*", true, nil, nil, nil, U["MapRevealGlowTip"]},
		{1, "Map", "Calendar", U["MinimapCalendar"].."*", true, true, nil, showCalendar, U["MinimapCalendarTip"]},
		{1, "Map", "Clock", U["Minimap Clock"].."*", nil, nil, nil, showMinimapClock},
		{1, "Map", "CombatPulse", U["Minimap Pulse"], true},
		{1, "Map", "WhoPings", U["Show WhoPings"], true, true},
		{1, "Map", "ShowRecycleBin", U["Show RecycleBin"]},
		{1, "Misc", "ExpRep", U["Show Expbar"], true},
		{1, "Misc", "WorldQusetRewardIcons", U["WorldQusetRewardIcons"], true, true},
		--{1, "Skins", "BlizzardSkins", HeaderTag..U["BlizzardSkins"], nil, nil, nil, nil, U["BlizzardSkinsTips"]},
		--{1, "Skins", "AlertFrames", U["ReskinAlertFrames"]},
		--{1, "Skins", "DefaultBags", U["DefaultBags"], true, nil, nil, nil, U["DefaultBagsTips"]},
		--{1, "Skins", "Loot", U["Loot"], true},
		--{1, "Skins", "PetBattle", U["PetBattle Skin"]},
		--{1, "Skins", "FlatMode", U["FlatMode"], true},
		--{1, "Skins", "Shadow", U["Shadow"]},
		--{1, "Skins", "FontOutline", U["FontOutline"], true},
		--{1, "Skins", "BgTex", U["BgTex"]},
		--{1, "Skins", "GreyBD", U["GreyBackdrop"], true, nil, nil, nil, U["GreyBackdropTip"]},
		--{3, "Skins", "SkinAlpha", U["SkinAlpha"].."*", nil, nil, {0, 1, .05}, updateSkinAlpha},
		--{3, "Skins", "FontScale", U["GlobalFontScale"], true, nil, {.5, 1.5, .05}},
		--{},--blank
		--{1, "Skins", "ClassLine", U["ClassColor Line"]},
		--{1, "Skins", "InfobarLine", U["Infobar Line"], true},
		--{1, "Skins", "ChatbarLine", U["Chat Line"]},
		--{1, "Skins", "MenuLine", U["Menu Line"], true},
		--{},--blank
		--{1, "Skins", "Skada", U["Skada Skin"]},
		--{1, "Skins", "Details", U["Details Skin"], nil, nil, resetDetails},
		{},--blank
		--{1, "Skins", "DBM", U["DBM Skin"]},
		{1, "Skins", "Bigwigs", U["Bigwigs Skin"]},
		{1, "Skins", "TMW", U["TMW Skin"], true},
		{1, "Skins", "WeakAuras", U["WeakAuras Skin"], true, true},
		{},--blank
		{1, "Nameplate", "ColoredTarget", HeaderTag..U["ColoredTarget"].."*", nil, nil, nil, nil, U["ColoredTargetTip"]},
		{1, "Nameplate", "ColoredFocus", HeaderTag..U["ColoredFocus"].."*", true, nil, nil, nil, U["ColoredFocusTip"]},
		{5, "Nameplate", "TargetColor", U["TargetNP Color"].."*", 3},
		{5, "Nameplate", "FocusColor", U["FocusNP Color"].."*", 4},
		{5, "Nameplate", "CustomColor", U["Custom Color"].."*", 5},
		{5, "Nameplate", "SecureColor", U["Secure Color"].."*"},
		{5, "Nameplate", "TransColor", U["Trans Color"].."*", 1},
		{5, "Nameplate", "InsecureColor", U["Insecure Color"].."*", 2},
		{5, "Nameplate", "OffTankColor", U["OffTank Color"].."*", 3},
		--{1, "Skins", "PGFSkin", U["PGF Skin"], true},
		--{1, "Skins", "Rematch", U["Rematch Skin"], true, true},
		--{4, "Skins", "ToggleDirection", U["ToggleDirection"].."*", true, true, {U["LEFT"], U["RIGHT"], U["TOP"], U["BOTTOM"], DISABLE}, updateToggleDirection},
	},
	[7] = {
	  --{1, "Misc", "RaidTool", "|cff00cc4c"..U["Raid Manger"]},
		--{1, "Misc", "RMRune", U["Runes Check"].."*"},
		--{1, "Misc", "EasyMarking", U["Easy Mark"].."*"},
		{2, "Misc", "DBMCount", U["DBMCount"].."*"},
		{4, "Misc", "ShowMarkerBar", U["ShowMarkerBar"].."*", true, nil, {U["Grids"], U["Horizontal"], U["Vertical"], DISABLE}, updateMarkerGrid, U["ShowMarkerBarTip"]},
		{3, "Misc", "MarkerSize", U["MarkerSize"].."*", true, true, {20, 50, 1}, updateMarkerGrid},
		{1, "Misc", "QuestNotification", "|cff00cc4c"..U["QuestNotification"].."*", false, false, nil, nil, updateQuestNotifier},
		{1, "Misc", "QuestProgress", U["QuestProgress"].."*", true},
		{1, "Misc", "OnlyCompleteRing", U["OnlyCompleteRing"].."*", true, true},
		--{1, "Misc", "InterruptAlert", HeaderTag..U["InterruptAlert"].."*", nil, nil, nil, updateInterruptAlert},
		--{1, "Misc", "OwnInterrupt", U["OwnInterrupt"].."*", true},
		{1, "Misc", "DispellAlert", HeaderTag..U["DispellAlert"].."*", nil, nil, nil, updateInterruptAlert},
		{1, "Misc", "OwnDispell", U["OwnDispell"].."*", true},
		{1, "Misc", "BrokenAlert", HeaderTag..U["BrokenAlert"].."*", nil, nil, nil, updateInterruptAlert, U["BrokenAlertTip"]},
		{1, "Misc", "InstAlertOnly", U["InstAlertOnly"].."*", true, nil, nil, updateInterruptAlert, U["InstAlertOnlyTip"]},
		{},--blank
		{1, "Misc", "ExplosiveCount", U["Explosive Alert"].."*", nil, nil, nil, updateExplosiveAlert, U["ExplosiveAlertTip"]},
		{1, "Misc", "PlacedItemAlert", U["Placed Item Alert"].."*", true},
		{1, "Misc", "SoloInfo", U["SoloInfo"].."*", true, true, nil, nil, updateSoloInfo},
		{1, "Misc", "NzothVision", U["NzothVision"]},
		{1, "Misc", "RareAlerter", "|cff00cc4c"..U["Rare Alert"].."*", true, false, nil, nil, updateRareAlert},
		{1, "Misc", "RarePrint", U["Alert In Chat"].."*", true, true},
		{1, "Misc", "RareAlertInWild", U["RareAlertInWild"].."*"},
	  {1, "Misc", "PlacedItemAlert", U["Placed Item Alert"], true},
	  {1, "Misc", "InterruptSound", U["Interrupt Alarm"], true, true},
	  --{1, "Misc", "CrazyCatLady", U["Death Alarm"]},
	  {1, "Misc", "AutoMark", U["Auto Mark"]},
	  {1, "Misc", "kAutoOpen", U["kAutoOpen"], true},
		{1, "Misc", "AutoConfirmRoll", U["AutoConfirmRoll"], true, true},
		{1, "Misc", "QuickQueue", U["QuickQueue"]},
	  {1, "Misc", "AutoReagentInBank", U["Auto Reagent Bank"], true},
		{1, "Misc", "HunterPetHelp", U["HunterPetHelp"], true, true},
		{1, "Misc", "CtrlIndicator", U["Shiftfreeze"]},
		{1, "Misc", "BlinkRogueHelper", U["BlinkRogueHelper"], true},
	},
	[8] = {
		--{3, "Tooltip", "Scale", U["Tooltip Scale"].."*", nil, nil, {.5, 1.5, .1}},
		{4, "Tooltip", "TipAnchor", U["TipAnchor"].."*", nil, nil, {U["TOPLEFT"], U["TOPRIGHT"], U["BOTTOMLEFT"], U["BOTTOMRIGHT"]}, nil, U["TipAnchorTip"]},
		{4, "Tooltip", "CursorMode", U["Follow Cursor"].."*", true, nil, {DISABLE, U["LEFT"], U["TOP"], U["RIGHT"]}},
		{1, "Tooltip", "CombatHide", U["Hide Tooltip"].."*"},
		{1, "Tooltip", "ItemQuality", U["ShowItemQuality"].."*", true},
		{1, "Tooltip", "HideTitle", U["Hide Title"].."*", true, true},
		{1, "Tooltip", "HideRank", U["Hide Rank"].."*"},
		{1, "Tooltip", "FactionIcon", U["FactionIcon"].."*", true},
		{1, "Tooltip", "HideJunkGuild", U["HideJunkGuild"].."*", true, true},
		{1, "Tooltip", "HideRealm", U["Hide Realm"].."*"},
		{1, "Tooltip", "SpecLevelByShift", U["Show SpecLevelByShift"].."*", true},
		{1, "Tooltip", "LFDRole", U["Group Roles"].."*", true, true},
		{1, "Tooltip", "TargetBy", U["Show TargetedBy"].."*"},
		{1, "Tooltip", "MythicScore", U["MDScore"].."*", true, nil, nil, nil, U["MDScoreTip"]},
		{1, "Tooltip", "HideAllID", "|cffff0000"..U["HideAllID"], true, true},
		{1, "Tooltip", "DomiRank", U["DomiRank"], nil, nil, nil, nil, U["DomiRankTip"]},
		{1, "Tooltip", "ConduitInfo", U["Show ConduitInfo"], true},
		{1, "Tooltip", "AzeriteArmor", HeaderTag..U["Show AzeriteArmor"]},
		{1, "Tooltip", "OnlyArmorIcons", U["Armor icons only"].."*", true},
		{1, "Misc", "ItemLevel", HeaderTag..U["Show ItemLevel"], true, true, nil, nil, U["ItemLevelTip"]},
		{1, "Misc", "GemNEnchant", U["Show GemNEnchant"].."*"},
		{1, "Misc", "AzeriteTraits", U["Show AzeriteTraits"].."*", true},
		{1, "Misc", "HideTalking", U["No Talking"]},
		{1, "ACCOUNT", "AutoBubbles", U["AutoBubbles"], true},
		{1, "Misc", "HideBossEmote", U["HideBossEmote"].."*", true, true, nil, toggleBossEmote},
		{1, "Misc", "HideBossBanner", U["Hide Bossbanner"].."*", nil, nil, nil, toggleBossBanner},
		{1, "Misc", "InstantDelete", U["InstantDelete"].."*", true},
		{1, "Misc", "FasterLoot", U["Faster Loot"].."*", true, true, nil, updateFasterLoot},
		{1, "Misc", "BlockInvite", "|cffff0000"..U["BlockInvite"].."*", nil, nil, nil, nil, U["BlockInviteTip"]},
		{1, "Misc", "FasterSkip", U["FasterMovieSkip"], true, nil, nil, nil, U["FasterMovieSkipTip"]},
		{1, "Misc", "MissingStats", U["Show MissingStats"], true, true},
		{1, "Misc", "ParagonRep", U["ParagonRep"]},
		{1, "Misc", "Mail", U["Mail Tool"], true},
		{1, "Misc", "TradeTabs", U["TradeTabs"], true, true},
		{1, "Misc", "PetFilter", U["Show PetFilter"]},
		{1, "Misc", "Screenshot", U["Auto ScreenShot"].."*", true, nil, nil, updateScreenShot},
		{1, "Misc", "Focuser", U["Easy Focus"], true, true},
		{1, "Misc", "MDGuildBest", U["MDGuildBest"], nil, nil, nil, nil, U["MDGuildBestTip"]},
		{1, "Misc", "MenuButton", U["MenuButton"], true, nil, nil, nil, U["MenuButtonTip"]},
		{1, "Misc", "EnhanceDressup", U["EnhanceDressup"], true, true, nil, nil, U["EnhanceDressupTip"]},
		{1, "Misc", "QuestTool", U["QuestTool"], nil, nil, nil, nil, U["QuestToolTip"]},
		{1, "Misc", "QuickJoin", NewTag..HeaderTag..U["EnhancedPremade"], true, nil, nil, nil, U["EnhancedPremadeTip"]},
	},
	[9] = {
		--{1, "Auras", "BuffFrame", HeaderTag..U["BuffFrame"], nil, setupBuffFrame, nil, nil, U["BuffFrameTip"]},
		--{1, "Auras", "HideBlizBuff", U["HideBlizUI"], true, nil, nil, nil, U["HideBlizBuffTip"]},
		{1, "AuraWatch", "Enable", "|cff00cc4c"..U["Enable AuraWatch"], false, false, setupAuraWatch},
		{1, "AuraWatch", "DeprecatedAuras", U["DeprecatedAuras"], true},
		--{1, "AuraWatch", "QuakeRing", U["QuakeRing"].."*"},
		{1, "AuraWatch", "ClickThrough", U["AuraWatch ClickThrough"], true, true, nil, nil, nil, U["ClickThroughTip"]},
		{1, "Auras", "Totems", HeaderTag..U["Enable Totembar"]},
		{1, "Auras", "VerticalTotems", U["VerticalTotems"].."*", true, nil, nil, refreshTotemBar},
		{1, "Auras", "Reminder", U["Enable Reminder"].."*", true, true, nil, updateReminder, U["ReminderTip"]},
		{3, "AuraWatch", "IconScale", U["AuraWatch IconScale"], nil, nil, {.8, 2, .1}},
		{3, "Auras", "TotemSize", U["TotemSize"].."*", true, nil, {24, 60, 1}, refreshTotemBar},
		{3, "Nameplate", "PPFadeoutAlpha", U["PlayerPlate FadeoutAlpha"].."*", true, true, {0, .5, .05}, togglePlateVisibility},
		{},--blank
		{1, "Misc", "RaidCD", U["Raid CD"]},
		{1, "Misc", "PulseCD", U["Pulse CD"], true},
		{1, "Misc", "EnemyCD", U["Enemy CD"], true, true},
		--{1, "UFs", "Castbars", "|cff00cc4c"..U["UFs Castbar"], false, false, setupCastbar},
		{1, "UFs", "RuneTimer", U["UFs RuneTimer"]},
		{1, "Nameplate", "ShowPlayerPlate", HeaderTag..U["Enable PlayerPlate"].."*", true, nil, nil, togglePlayerPlate},
		{1, "Nameplate", "TargetPower", HeaderTag..U["TargetClassPower"].."*", true, true, nil, toggleTargetClassPower},
		{},--blank
		{1, "Auras", "ClassAuras", U["Enable ClassAuras"]},
		{1, "Nameplate", "PPFadeout", U["PlayerPlate Fadeout"].."*", true, nil, nil, togglePlateVisibility},
		{1, "Nameplate", "PPOnFire", U["PlayerPlate OnFire"], true, true, nil, nil, U["PPOnFireTip"]},
		{1, "Nameplate", "PPPowerText", U["PlayerPlate PowerText"].."*", nil, nil, nil, togglePlatePower},
		{1, "Nameplate", "PPGCDTicker", U["PlayerPlate GCDTicker"].."*", true, nil, nil, toggleGCDTicker},
		--{1, "Auras", "MMT29X4", NewTag..U["MMT29X4"].."*", true, true, nil, toggleFocusCalculation, U["MMT29X4Tip"]},
		{},--blank
		{3, "Nameplate", "PPWidth", U["Width"].."*", false, nil, {150, 300, 1}, refreshNameplates},
		{3, "Nameplate", "PPBarHeight", U["PlayerPlate CPHeight"].."*", true, nil, {2, 15, 1}, refreshNameplates},
		{3, "Nameplate", "PPHealthHeight", U["PlayerPlate HPHeight"].."*", true, true, {2, 15, 1}, refreshNameplates},
		{3, "Nameplate", "PPPowerHeight", U["PlayerPlate MPHeight"].."*", false, nil, {2, 15, 1}, refreshNameplates},
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
	tab:SetPoint("TOP", -320 + 80*(i-1) + R.mult, -121)
	tab:SetSize(80, 30)
	M.CreateBD(tab, .3)
	M.CreateFS(tab, 15, name, "system", "CENTER", 0, 0)
	tab.index = i

	tab:SetScript("OnClick", tabOnClick)
	tab:SetScript("OnEnter", tabOnEnter)
	tab:SetScript("OnLeave", tabOnLeave)

	return tab
end

local function CheckUIOption(key, value, newValue)
	if key == "ACCOUNT" then
		if newValue ~= nil then
			MaoRUIDB[value] = newValue
		else
			return MaoRUIDB[value]
		end
	else
		if newValue ~= nil then
			R.db[key][value] = newValue
		else
			return R.db[key][value]
		end
	end
end

G.needUIReload = nil

local function CheckUIReload(name)
	if not strfind(name, "%*") then
		G.needUIReload = true
	end
end

local function onCheckboxClick(self)
	CheckUIOption(self.__key, self.__value, self:GetChecked())
	CheckUIReload(self.__name)
	if self.__callback then self:__callback() end
end

local function restoreEditbox(self)
	self:SetText(CheckUIOption(self.__key, self.__value))
end
local function acceptEditbox(self)
	CheckUIOption(self.__key, self.__value, self:GetText())
	CheckUIReload(self.__name)
	if self.__callback then self:__callback() end
end

local function onSliderChanged(self, v)
	local current = M:Round(tonumber(v), 2)
	CheckUIOption(self.__key, self.__value, current)
	CheckUIReload(self.__name)
	self.value:SetText(current)
	if self.__callback then self:__callback() end
end

local function updateDropdownSelection(self)
	local dd = self.__owner
	for i = 1, #dd.__options do
		local option = dd.options[i]
		if i == CheckUIOption(dd.__key, dd.__value) then
			option:SetBackdropColor(1, .8, 0, .3)
			option.selected = true
		else
			option:SetBackdropColor(0, 0, 0, .3)
			option.selected = false
		end
	end
end
local function updateDropdownClick(self)
	local dd = self.__owner
	CheckUIOption(dd.__key, dd.__value, self.index)
	CheckUIReload(dd.__name)
	if dd.__callback then dd:__callback() end
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
				cb:SetPoint("TOPLEFT", 550, -offset + 28)
			elseif horizon then
				cb:SetPoint("TOPLEFT", 300, -offset + 28)
			else
				cb:SetPoint("TOPLEFT", 60, -offset)
				offset = offset + 28
			end
			cb.__key = key
			cb.__value = value
			cb.__name = name
			cb.__callback = callback
			cb.name = M.CreateFS(cb, 14, name, false, "LEFT", 30, 0)
			cb:SetChecked(CheckUIOption(key, value))
			cb:SetScript("OnClick", onCheckboxClick)
			if data and type(data) == "function" then
				local bu = M.CreateGear(parent)
				bu:SetPoint("LEFT", cb.name, "RIGHT", -2, 1)
				bu:SetScript("OnClick", data)
			end
			if tooltip then
				M.AddTooltip(cb, "ANCHOR_RIGHT", tooltip, "info", true)
			end
		-- Editbox
		elseif optType == 2 then
			local eb = M.CreateEditBox(parent, 210, 23)
			eb:SetMaxLetters(999)
			eb.__key = key
			eb.__value = value
			eb.__name = name
			eb.__callback = callback
			eb.__default = (key == "ACCOUNT" and G.AccountSettings[value]) or G.DefaultSettings[key][value]
			if horizon2 then
				eb:SetPoint("TOPLEFT", 550, -offset + 28)
			elseif horizon then
				eb:SetPoint("TOPLEFT", 300, -offset + 28)
			else
				eb:SetPoint("TOPLEFT", 60, -offset - 26)
				offset = offset + 58
			end
			eb:SetText(CheckUIOption(key, value))
			eb:HookScript("OnEscapePressed", restoreEditbox)
			eb:HookScript("OnEnterPressed", acceptEditbox)

			M.CreateFS(eb, 14, name, "system", "CENTER", 0, 25)
			local tip = U["EditBox Tip"]
			if tooltip then tip = tooltip.."|n"..tip end
			M.AddTooltip(eb, "ANCHOR_RIGHT", tip, "info", true)
		-- Slider
		elseif optType == 3 then
			local min, max, step = unpack(data)
			local x, y
			if horizon2 then
				x, y = 540, -offset + 28
			elseif horizon then
				x, y = 300, -offset + 28
			else
				x, y = 55, -offset - 26
				offset = offset + 58
			end
			local s = M.CreateSlider(parent, name, min, max, step, x, y)
			s.__key = key
			s.__value = value
			s.__name = name
			s.__callback = callback
			s.__default = (key == "ACCOUNT" and G.AccountSettings[value]) or G.DefaultSettings[key][value]
			s:SetValue(CheckUIOption(key, value))
			s:SetScript("OnValueChanged", onSliderChanged)
			s.value:SetText(M:Round(CheckUIOption(key, value), 2))
			if tooltip then
				M.AddTooltip(s, "ANCHOR_RIGHT", tooltip, "info", true)
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
				dd:SetPoint("TOPLEFT", 560, -offset + 28)
			elseif horizon then
				dd:SetPoint("TOPLEFT", 310, -offset + 28)
			else
				dd:SetPoint("TOPLEFT", 70, -offset - 26)
				offset = offset + 58
			end
			dd.Text:SetText(data[CheckUIOption(key, value)])
			dd.__key = key
			dd.__value = value
			dd.__name = name
			dd.__options = data
			dd.__callback = callback
			dd.button.__owner = dd
			dd.button:HookScript("OnClick", updateDropdownSelection)

			for i = 1, #data do
				dd.options[i]:HookScript("OnClick", updateDropdownClick)
				if value == "TexStyle" then
					AddTextureToOption(dd.options, i) -- texture preview
				end
			end

			M.CreateFS(dd, 14, name, "system", "CENTER", 0, 25)
			if tooltip then
				M.AddTooltip(dd, "ANCHOR_RIGHT", tooltip, "info", true)
			end
		-- Colorswatch
		elseif optType == 5 then
			local swatch = M.CreateColorSwatch(parent, name, CheckUIOption(key, value))
			local width = 80 + (horizon or 0)*120
			if horizon2 then
				swatch:SetPoint("TOPLEFT", width, -offset + 26)
			elseif horizon then
				swatch:SetPoint("TOPLEFT", width, -offset + 26)
			else
				swatch:SetPoint("TOPLEFT", width, -offset - 3)
				offset = offset + 26
			end
			swatch.__default = (key == "ACCOUNT" and G.AccountSettings[value]) or G.DefaultSettings[key][value]
		-- Blank, no optType
		else
			if not key then
				local line = M.SetGradient(parent, "H", 1, 1, 1, .25, .25, 770, R.mult)
				line:SetPoint("TOPLEFT", 26, -offset - 8)
			end
			offset = offset + 16
		end
	end
end


StaticPopupDialogs["RELOAD_NDUI"] = {
	text = U["ReloadUI Required"],
	button1 = APPLY,
	button2 = CLASS_TRIAL_THANKS_DIALOG_CLOSE_BUTTON,
	OnAccept = function()
		ReloadUI()
	end,
}

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
	f:SetSize(1440, 720)
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
		if G.needUIReload then
			StaticPopup_Show("RELOAD_NDUI")
			G.needUIReload = nil
		end
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
	G:CreateProfileGUI(guiPage[5]) -- profile GUI
	--G:SetupActionbarStyle(guiPage[1])

	local helpInfo = M.CreateHelpInfo(f, U["Option* Tips"])
	helpInfo:SetPoint("TOP", 21, -21)
	local guiHelpInfo = {
		text = U["GUIPanelHelp"],
		buttonStyle = HelpTip.ButtonStyle.GotIt,
		targetPoint = HelpTip.Point.LeftEdgeCenter,
		onAcknowledgeCallback = M.HelpInfoAcknowledge,
		callbackArg = "GUIPanel",
	}
	if not MaoRUIDB["Help"]["GUIPanel"] then
		HelpTip:Show(helpInfo, guiHelpInfo)
	end

	local credit = CreateFrame("Button", nil, f)
	credit:SetPoint("BOTTOM", 0, 66)
	credit:SetSize(360, 21)
	M.CreateFS(credit, 18, "This GUI learn form Siweia·s NDui，Sincere Gratitude!", true)
	

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
	local gui = CreateFrame("Button", "GameMenuFrameUI", GameMenuFrame, "GameMenuButtonTemplate, BackdropTemplate")
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
