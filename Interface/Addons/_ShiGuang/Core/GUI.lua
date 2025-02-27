local _, ns = ...
local M, R, U, I = unpack(ns)
local G = M:RegisterModule("GUI")

local unpack, strfind, gsub = unpack, strfind, gsub
local tonumber, pairs, ipairs, next, type, tinsert = tonumber, pairs, ipairs, next, type, tinsert
local cr, cg, cb = I.r, I.g, I.b
local guiTab, guiPage, f = {}, {}

-- Default Settings
G.DefaultSettings = {
	TWW = false,
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
		Grid = false,
		Classcolor = false,
		Cooldown = true,
		MmssTH = 60,
		TenthTH = 3,
		BindType = 1,
		OverrideWA = false,
		MicroMenu = true,
		ShowStance = true,
		EquipColor = true,
		ShowGlow = true,
		KeyDown = true,
		ButtonLock = true,

		Bar1 = true,
		Bar1Flyout = 1,
		Bar1Size = 35,
		Bar1Font = 12,
		Bar1Num = 12,
		Bar1PerRow = 12,
		Bar2 = true,
		Bar2Flyout = 1,
		Bar2Size = 35,
		Bar2Font = 12,
		Bar2Num = 12,
		Bar2PerRow = 12,
		Bar3 = true,
		Bar3Flyout = 1,
		Bar3Size = 35,
		Bar3Font = 12,
		Bar3Num = 12,
		Bar3PerRow = 6,
		Bar4 = true,
		Bar4Flyout = 1,
		Bar4Size = 35,
		Bar4Font = 12,
		Bar4Num = 12,
		Bar4PerRow = 6,
		Bar5 = true,
		Bar5Flyout = 1,
		Bar5Size = 35,
		Bar5Font = 12,
		Bar5Num = 12,
		Bar5PerRow = 1,
		Bar6 = true,
		Bar6Flyout = 1,
		Bar6Size = 35,
		Bar6Font = 12,
		Bar6Num = 12,
		Bar6PerRow = 1,
		Bar7 = false,
		Bar7Flyout = 1,
		Bar7Size = 35,
		Bar7Font = 12,
		Bar7Num = 4,
		Bar7PerRow = 1,
		Bar8 = false,
		Bar8Flyout = 1,
		Bar8Size = 35,
		Bar8Font = 12,
		Bar8Num = 12,
		Bar8PerRow = 4,

		BarPetSize = 26,
		BarPetFont = 12,
		BarPetPerRow = 10,
		BarStanceSize = 30,
		BarStanceFont = 12,
		BarStancePerRow = 10,
		VehButtonSize = 34,
		MBSize = 21,
		MBPerRow = 1,
		MBSpacing = -4,
	},
	Auras = {
		Reminder = true,
		Totems = false,
		VerticalTotems = false,
		TotemSize = 32,
		ClassAuras = true,
		BuffFrame = true,
		HideBlizBuff = false,
		ReverseBuff = false,
		BuffSize = 30,
		BuffsPerRow = 16,
		ReverseDebuff = false,
		DebuffSize = 34,
		DebuffsPerRow = 16,
		PrivateSize = 30,
		ReversePrivate = false,
	},
	AuraWatch = {
		Enable = true,
		ClickThrough = false,
		IconScale = 1,
		DeprecatedAuras = false,
		MinCD = 3,
		QuakeRing = false,
	},
	UFs = {
		Enable = true,
		Portrait = false,
		ShowAuras = true,
		Arena = true,
		Castbars = true,
		AddPower = true,
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
		SMRPerCol = 25,
		SMRGroupBy = 1,
		SMRGroups = 8,
		SMRDirec = 1,
		InstanceAuras = true,
		DispellType = 1,
		RaidDebuffScale = 1,
		SpecRaidPos = false,
		RaidHealthColor = 2,
		ShowSolo = false,
		RaidWidth = 88,
		RaidHeight = 16,
		RaidPowerHeight = 2,
		RaidHPMode = 1,
		AuraClickThru = false,
		CombatText = false,
		HotsDots = false,
		AutoAttack = false,
		FCTOverHealing = false,
		FCTFontSize = 18,
		PetCombatText = false,
		ScrollingCT = false,
		RaidClickSets = true,
		TeamIndex = false,
		ClassPower = false,
		CPWidth = 150,
		CPHeight = 5,
		CPxOffset = 12,
		CPyOffset = -2,
		LagString = false,
		RuneTimer = true,
		RaidBuffIndicator = true,
		PartyFrame = true,
		PartyDirec = 3,
		PartyWidth = 130,
		PartyHeight = 21,
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
		RaidTextScale = 0.85, 
		ShowRaidBuff = false,
		RaidBuffSize = 12,
		BuffClickThru = true,
		ShowRaidDebuff = true,
		RaidDebuffSize = 12,
		DebuffClickThru = true,
		SmartRaid = false,
		Desaturate = true,
		DebuffColor = true,
		CCName = true,
		RCCName = true,
		HideTip = false,
		DescRole = true,
		PlayerAbsorb = false,
		AutoBuffs = false,
		ShowRoleMode = 1,
		OverAbsorb = true,
		PrivateSize = 30,
		ReversePrivate = false,

		PlayerWidth = 245,
		PlayerHeight = 24,
		PlayerNameOffset = 0,
		PlayerPowerHeight = 6,
		PlayerPowerOffset = 2,
		PlayerHPTag = 2,
		PlayerMPTag = 4,
		FocusWidth = 160,
		FocusHeight = 21,
		FocusNameOffset = 0,
		FocusPowerHeight = 3,
		FocusPowerOffset = 2,
		FocusHPTag = 2,
		FocusMPTag = 4,
		PetWidth = 100,
		PetHeight = 16,
		PetNameOffset = 0,
		PetPowerHeight = 2,
		PetHPTag = 4,
		BossWidth = 120,
		BossHeight = 21,
		BossNameOffset = 0,
		BossPowerHeight = 3,
		BossPowerOffset = 2,
		BossHPTag = 5,
		BossMPTag = 5,
		OwnCastColor = {r=.3, g=.7, b=1},
		CastingColor = {r=.8, g=.6, b=.1},  --r=.3, g=.7, b=1
		NotInterruptColor = {r=.6, g=.6, b=.6},  --r=1, g=.5, b=.5
		PlayerCB = true,
		PlayerCBWidth = 230,
		PlayerCBHeight = 16,
		TargetCB = true,
		TargetCBWidth = 310,
		TargetCBHeight = 18,
		FocusCB = true,
		FocusCBWidth = 360,
		FocusCBHeight = 21,
		PetCB = true,

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

		PlayerAuraDirec = 3,
		PlayerAuraOffset = 10,
		TargetAuraDirec = 1,
		TargetAuraOffset = 10,
		ToTAuraDirec = 1,
		ToTAuraOffset = 10,
		PetAuraDirec = 1,
		PetAuraOffset = 10,
		FocusAuraDirec = 1,
		FocusAuraOffset = 10,
		
		--PlayerFrameScale = 1,
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
		SysFont = false,
		EditFont = 14,
		Outline = false,
	},
	Map = {
		DisableMap = false,
		DisableMinimap = false,
		Clock = false,
		CombatPulse = false,
		MapScale = 1.5,
		MaxMapScale = 0.85,
		MinimapScale = 1,
		MinimapSize = 186,
		ShowRecycleBin = false,
		WhoPings = true,
		MapReveal = false,
		MapRevealGlow = true,
		Calendar = false,
		EasyVolume = true,
		MapShrinker = true,
		zrMMbordersize = 1,
		zrMMbuttonsize = 19,
		zrMMbuttonpos = 2,
		zrMMcustombuttons = {},
	},
	Nameplate = {
		Enable = true,
		maxAuras = 6,
		PlateAuras = true,
		AuraSize = 26,
		FontSize = 14,
		SizeRatio = .5,
		AuraFilter = 3,
		FriendlyCC = true,
		HostileCC = true,
		TankMode = false,
		TargetIndicator = 3,
		InsideView = true,
		ShowCustomUnits = true,
		CustomColor = {r=0, g=.8, b=.3},
		CustomUnits = {},
		ShowPowerUnits = true,
		PowerUnits = {},
		VerticalSpacing = 1.1,
		ShowPlayerPlate = false,
		PPWidth = 210,
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
		AKSProgress = true,
		PPFadeout = true,
		PPFadeoutAlpha = 0,
		PPOnFire = false,
		TargetPower = true,
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
		Interruptor = true,
		FriendPlate = false,
		EnemyThru = false,
		FriendlyThru = false,
		BlockDBM = true,
		DispellMode = 1,
		UnitTargeted = false,
		ColorByDot = false,
		DotColor = {r=1, g=.5, b=.2},
		DotSpells = {},
		RaidTargetX = 0,
		RaidTargetY = 3,
		PlateRange = 45,

		PlateWidth = 160,
		PlateHeight = 8,
		PlateCBHeight = 6,
		PlateCBOffset = 0,
		CBTextSize = 14,
		NameTextSize = 15,
		NameTextOffset = 5,
		HealthTextSize = 16,
		HealthTextOffset = 5,
		FriendPlateWidth = 150,
		FriendPlateHeight = 8,
		FriendPlateCBHeight = 6,
		FriendPlateCBOffset = 0,
		FriendCBTextSize = 14,
		FriendNameSize = 14,
		FriendNameOffset = 5,
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
		InfobarLine = false,
		ChatbarLine = false,
		MenuLine = false,
		ClassLine = false,
		Details = true,
		PGFSkin = true,
		Rematch = false,
		ToggleDirection = 1,
		BlizzardSkins = true,
		SkinAlpha = .5,
		FlatMode = false,
		AlertFrames = true,
		FontOutline = true,
		Loot = true,
		Shadow = true,
		BgTex = true,
		GreyBD = false,
		FontScale = 1,
		QuestTracker = true,
	},
	Tooltip = {
		HideInCombat = 1,
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
		HideAllID = false,
		MythicScore = true,
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
		BrokenAlert = true,
		LeaderOnly = true,
		FasterLoot = true,
		AutoQuest = false,
		IgnoreQuestNPC = {},
		HideTalking = true,
		HideBossBanner = false,
		HideBossEmote = false,
		PetFilter = true,
		QuestNotification = true,
		QuestProgress = false,
		OnlyCompleteRing = false,
		SpellItemAlert = true,
		RareAlertInWild = true,
		ParagonRep = true,
		InstantDelete = true,
		RaidTool = true,
		RMRune = false,
		DBMCount = "10",
		EasyMarkKey = 1,
		ShowMarkerBar = 3,
		MarkerSize = 21,
		BlockInvite = false,
		BlockRequest = false,
		NzothVision = true,
		SendActionCD = true,
		MDGuildBest = true,
		FasterSkip = true,
		EnhanceDressup = true,
		QuestTool = true,
		InfoStrLeft = "[spec][time][guild][friend][ping][fps][gold][dura][bag]",
		InfoStrRight = "[zone]",
		InfoSize = 13,
		MaxAddOns = 21,
		MenuButton = true,
		QuickJoin = true,
		MaxZoom = 2.6,
		SingingSocket = false,
		QuickQueue = true,
		--AltTabLfgNotification = false,
		CrazyCatLady = true,
		WallpaperKit = true,
		AutoReagentInBank = true,
		kAutoOpen = true,
		AutoConfirmRoll = false,
		AutoMark = true,
		FreeMountCD = true,
		WorldQusetRewardIcons = true,
		WorldQusetRewardIconsSize = 32,
		RaidCD = false,
		PulseCD = true,
		EnemyCD = false,
		SorasThreat = true,
		HunterPetHelp = true,
		CtrlIndicator = true,
		BlinkRogueHelper = false,
		QuestAutoCollapse = "SCENARIO",
	},
	Tutorial = {
		Complete = false,
	},
}

G.AccountSettings = {
	ChatFilterList = "%*",
	ChatFilterWhiteList = "",
	TimestampFormat = 1,
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
	VersionCheck = false,
	DBMRequest = false,
	SkadaRequest = false,
	BWRequest = false,
	ClickSets = {},
	TexStyle = 3,
	KeystoneInfo = {},
	AutoBubbles = false,
	DisableInfobars = false,
	ContactList = {},
	CustomJunkList = {},
	ProfileIndex = {},
	ProfileNames = {},
	Help = {},
	CornerSpells = {},
	CustomTex = "",
	MajorSpells = {},
	SmoothAmount = .25,
	AutoRecycle = false,
	IgnoredButtons = "",
	RaidBuffsWhite = {},
	RaidDebuffsBlack = {},
	NameplateWhite = {},
	NameplateBlack = {},
	IgnoreNotes = {},
	GlowMode = 3,
	IgnoredRares = "",
}

-- Initial settings
G.TextureList = {
	[1] = {texture = I.normTex, name = U["Highlight"]},
	[2] = {texture = I.gradTex, name = U["Gradient"]},
	[3] = {texture = I.flatTex, name = U["Flat"]},
}

local ignoredTable = {
	["AuraWatchList"] = true,
	["AuraWatchMover"] = true,
	["InternalCD"] = true,
	["Mover"] = true,
	["TempAnchor"] = true,
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
		if fullClean and type(j) == "table" and not ignoredTable[i] then
			for k, v in pairs(j) do
				if source[i] and source[i][k] == nil then
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

	-- Transfer old data START
	if MaoRUISetDB["NameplateFilter"] then
		if MaoRUISetDB["NameplateFilter"][1] then
			if not MaoRUISetDB["NameplateWhite"] then MaoRUISetDB["NameplateWhite"] = {} end
			for spellID, value in pairs(MaoRUISetDB["NameplateFilter"][1]) do
				MaoRUISetDB["NameplateWhite"][spellID] = value
			end
		end
		if MaoRUISetDB["NameplateFilter"][2] then
			if not MaoRUISetDB["NameplateBlack"] then MaoRUISetDB["NameplateBlack"] = {} end
			for spellID, value in pairs(MaoRUISetDB["NameplateFilter"][2]) do
				MaoRUISetDB["NameplateBlack"][spellID] = value
			end
		end
	end
	if MaoRUISetDB["RaidAuraWatch"] then
		if not MaoRUISetDB["RaidBuffsWhite"] then MaoRUISetDB["RaidBuffsWhite"] = {} end
		for spellID in pairs(MaoRUISetDB["RaidAuraWatch"]) do
			MaoRUISetDB["RaidBuffsWhite"][spellID] = true
		end
	end
	-- Transfer old data END

	InitialSettings(G.AccountSettings, MaoRUISetDB)
	if not next(MaoRUIPerDB) then
		for i = 1, 5 do MaoRUIPerDB[i] = {} end
	end

	if not MaoRUISetDB["ProfileIndex"][I.MyFullName] then
		MaoRUISetDB["ProfileIndex"][I.MyFullName] = 1
	end

	if MaoRUISetDB["ProfileIndex"][I.MyFullName] == 1 then
		R.db = MaoRUIDB
	else
		R.db = MaoRUIPerDB[MaoRUISetDB["ProfileIndex"][I.MyFullName] - 1]
	end
	InitialSettings(G.DefaultSettings, R.db, true)

	if not R.db["TWW"] then
		R.db["Actionbar"]["Enable"] = true
		R.db["TWW"] = true
	end

	M:SetupUIScale(true)
	if MaoRUISetDB["CustomTex"] ~= "" then
		I.normTex = "Interface\\"..MaoRUISetDB["CustomTex"]
	else
		if not G.TextureList[MaoRUISetDB["TexStyle"]] then
			MaoRUISetDB["TexStyle"] = 2 -- reset value if not exists
		end
		I.normTex = G.TextureList[MaoRUISetDB["TexStyle"]].texture
	end

	if not R.db["Map"]["DisableMinimap"] then
		GetMinimapShape = M.GetMinimapShape
	end

	self:UnregisterAllEvents()
end)

-- Callbacks
local function setupUnitFrame()
	G:SetupUnitFrame(guiPage[2])
end
local function setupCastbar()
	G:SetupCastbar(guiPage[2])
end

local function setupClassPower()
	G:SetupUFClassPower(guiPage[1])
end

local function setupUFAuras()
	G:SetupUFAuras(guiPage[2])
end

local function setupSwingBars()
	G:SetupSwingBars(guiPage[2])
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

local function setupDebuffsIndicator()
	G:SetupDebuffsIndicator(guiPage[2])
end

local function setupBuffsIndicator()
	G:SetupBuffsIndicator(guiPage[2])
end

local function setupSpellsIndicator()
	G:SetupSpellsIndicator(guiPage[2])
end

local function setupNameplateFilter()
	G:SetupNameplateFilter(guiPage[3])
end

local function setupNameplateColorDots()
	G:NameplateColorDots(guiPage[3])
end

local function setupNameplateUnitFilter()
	G:NameplateUnitFilter(guiPage[3])
end

local function setupNameplatePowerUnits()
	G:NameplatePowerUnits(guiPage[3])
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
	G:SetupBuffFrame(guiPage[4])
end

local function setupAuraWatch()
	f:Hide()
	SlashCmdList["UI_AWCONFIG"]()
end

local function updateBagSortOrder()
	C_Container.SetSortBagsRightToLeft(R.db["Bags"]["BagSortMode"] == 1)
end

local function setupActionBar()
	G:SetupActionBar(guiPage[1])
end

local function setupMicroMenu()
	G:SetupMicroMenu(guiPage[1])
end

local function setupStanceBar()
	G:SetupStanceBar(guiPage[1])
end

local function updateHotkeys()
	M:GetModule("Actionbar"):UpdateBarConfig()
end

local function updateOverlays()
	M:GetModule("Actionbar"):UpdateOverlays()
end

local function updateEquipColor()
	local Bar = M:GetModule("Actionbar")
	for _, button in pairs(Bar.buttons) do
		if button.Border and button.Update then
			Bar.UpdateEquipItemColor(button)
		end
	end
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

local function updateUFTextScale()
	M:GetModule("UnitFrames"):UpdateTextScale()
end

local function togglePlayerAbsorb()
	if _G.oUF_Player then
		M:GetModule("UnitFrames").UpdateFrameHealthTag(_G.oUF_Player)
	end
end

local function toggleAddPower()
	M:GetModule("UnitFrames"):ToggleAddPower()
end

local function toggleUFClassPower()
	M:GetModule("UnitFrames"):ToggleUFClassPower()
end

local function togglePortraits()
	M:GetModule("UnitFrames"):TogglePortraits()
end

local function toggleAllAuras()
	M:GetModule("UnitFrames"):ToggleAllAuras()
end

local function updateRaidTextScale()
	M:GetModule("UnitFrames"):UpdateRaidTextScale()
end

local function toggleCastBarLatency()
	M:GetModule("UnitFrames"):ToggleCastBarLatency()
end

local function toggleSwingBars()
	M:GetModule("UnitFrames"):ToggleSwingBars()
end

local function updateSmoothingAmount()
	M:SetSmoothingAmount(MaoRUISetDB["SmoothAmount"])
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

local function refreshPlateByEvents()
	M:GetModule("UnitFrames"):RefreshPlateByEvents()
end

local function updateScrollingFont()
	M:GetModule("UnitFrames"):UpdateScrollingFont()
end

local function updateRaidAurasOptions()
	M:GetModule("UnitFrames"):RaidAuras_UpdateOptions()
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

local function updateRareAlert()
	M:GetModule("Misc"):RareAlert()
end

local function updateIgnoredRares()
	M:GetModule("Misc"):RareAlert_UpdateIgnored()
end

local function updateSoloInfo()
	M:GetModule("Misc"):SoloInfo()
end

local function updateSpellItemAlert()
	M:GetModule("Misc"):SpellItemAlert()
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

local function updateMaxZoomLevel()
	M:GetModule("Misc"):UpdateMaxZoomLevel()
end

local function updateInfobarAnchor(self)
	if self:GetText() == "" then
		self:SetText(self.__default)
		R.db[self.__key][self.__value] = self:GetText()
	end

	if not MaoRUISetDB["DisableInfobars"] then
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

StaticPopupDialogs["RESET_DETAILS"] = {
	text = U["Reset Details check"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		M:GetModule("Skins"):ResetDetailsAnchor(true)
	end,
	whileDead = 1,
}
local function resetDetails()
	StaticPopup_Show("RESET_DETAILS")
end

local function AddTextureToOption(parent, index)
	local tex = parent[index]:CreateTexture()
	tex:SetInside(nil, 4, 4)
	tex:SetTexture(G.TextureList[index].texture)
	tex:SetVertexColor(cr, cg, cb)
end

-- Config
local HeaderTag = "|cff00cc4c"
local IsNew = "ISNEW"
G.HealthValues = {DISABLE, U["ShowHealthDefault"], U["ShowHealthCurMax"], U["ShowHealthCurrent"], U["ShowHealthPercent"], U["ShowHealthLoss"], U["ShowHealthLossPercent"]}

local function AddNewTag(parent, anchor)
	local tag = CreateFrame("Frame", nil, parent, "NewFeatureLabelTemplate")
	tag:SetPoint("LEFT", anchor or parent, -25, 10)
	tag:Show()
end

G.TabList = {
	IsNew..U["Actionbar"],
	IsNew..U["RaidFrame"],
	U["Nameplate"],
	U["Auras"],
	IsNew..U["Misc"],
	U["ChatFrame"],
	U["Skins"].."&"..U["Maps"],
	U["UI Settings"],
	U["Profile"],
}

G.OptionList = {		-- type, key, value, name, horizon, horizon2, doubleline
	[1] = {
		{1, "Actionbar", "Enable", HeaderTag..U["Enable Actionbar"], nil, nil, setupActionBar},
		--{4, "Actionbar", "Style", U["Actionbar Style"], true, true, {"-- 2*(3+12+3) --", "-- 2*(6+12+6) --", "-- 2*6+3*12+2*6 --", "-- 3*12 --", "-- 2*(12+6) --", "-- 3*(4+12+4) --", "-- What --", "-- MR --", "-- PVP2 --", "-- Cool --", "-- JK --"}},  --nop
		{},--blank
		{1, "Actionbar", "MicroMenu", U["Micromenu"], nil, nil, setupMicroMenu, nil, U["MicroMenuTip"]},
		{1, "Actionbar", "ShowStance", U["ShowStanceBar"], true, nil, setupStanceBar},
		{1, "Actionbar", "Cooldown", HeaderTag..U["Show Cooldown"], true, true},
		{},--blank
		{1, "Actionbar", "OverrideWA", U["HideCooldownOnWA"].."*", nil},
		{1, "Actionbar", "KeyDown", IsNew..U["KeyDown"].."*", true, nil, nil, updateHotkeys, U["KeyDownTip"]},
		{1, "Actionbar", "ButtonLock", IsNew..U["ButtonLock"].."*", true, true, nil, updateHotkeys, U["ButtonLockTip"]},
		{1, "Actionbar", "Hotkeys", U["Actionbar Hotkey"].."*", nil, nil, nil, updateHotkeys},
		{1, "Actionbar", "Macro", U["Actionbar Macro"].."*", true, nil, nil, updateHotkeys},
		{1, "Actionbar", "Grid", U["Actionbar Grid"], true, true, nil, updateHotkeys},
		{1, "Actionbar", "Classcolor", U["ClassColor BG"], nil, nil, nil, updateHotkeys},
		{1, "Actionbar", "EquipColor", U["EquipColor"].."*", true, nil, nil, updateHotkeys},	
		{1, "Misc", "SendActionCD", HeaderTag..U["SendActionCD"].."*", true, true, nil, nil, U["SendActionCDTip"]},	
		{3, "Actionbar", "MmssTH", IsNew..U["MmssThreshold"].."*", nil, nil, {60, 600, 1}, nil, U["MmssThresholdTip"]},
		{3, "Actionbar", "TenthTH", IsNew..U["TenthThreshold"].."*", true, nil, {0, 60, 1}, nil, U["TenthThresholdTip"]},
		{3, "ACCOUNT", "SmoothAmount", U["SmoothAmount"].."*", true, true, {.1, 1, .05}, updateSmoothingAmount, U["SmoothAmountTip"]},
		--{1, "Actionbar", "ShowGlow", U["ShowGlow"].."*", nil, nil, nil, updateOverlays},
		{},--blank
		{3, "Misc", "MaxZoom", U["MaxZoom"].."*", nil, nil, {1, 2.6, .1}, updateMaxZoomLevel},
		{3, "ACCOUNT", "UIScale", U["Setup UIScale"], true, nil, {.4, 1.15, .01}},
		{3, "Misc", "MaxAddOns", U["SysMaxAddOns"].."*", true, true,  {1, 50, 1}, nil, U["SysMaxAddOnsTip"]},
		--{3, "Misc", "InfoSize", U["InfobarFontSize"].."*", true, true,  {10, 50, 1}, updateInfobarSize},
		{2, "Misc", "InfoStrLeft", U["LeftInfobar"].."*", nil, nil, nil, updateInfobarAnchor, U["InfobarStrTip"]},
		{2, "Misc", "InfoStrRight", U["RightInfobar"].."*", true, nil, nil, updateInfobarAnchor, U["InfobarStrTip"]},
		{2, "ACCOUNT", "CustomTex", U["CustomTex"], true, true, nil, nil, U["CustomTexTip"]},
		{4, "ACCOUNT", "TexStyle", U["Texture Style"], false, nil, {}},
		{4, "ACCOUNT", "NumberFormat", U["Numberize"], true, nil, {U["Number Type1"], U["Number Type2"], U["Number Type3"]}},
		{4, "ACCOUNT", "GlowMode", U["GlowMode"].."*", true, true , {"Pixel", "Autocast", "Action Button", "Proc Glow"}},
	},
	[2] = {
		{1, "UFs", "Enable", HeaderTag..U["Enable UFs"], nil, nil, setupUnitFrame, nil, U["HideUFWarning"]},
		{1, "UFs", "Arena", U["Arena Frame"], true, nil},
		{1, "UFs", "ShowAuras", U["ShowAuras"].."*", true, true, setupUFAuras, toggleAllAuras},
		--{1, "UFs", "ClassPower", U["UFs ClassPower"].."*", true, nil, setupClassPower, toggleUFClassPower},
		--{1, "UFs", "Portrait", U["UFs Portrait"].."*", nil, nil, nil, togglePortraits},
		--{1, "UFs", "CCName", U["ClassColor Name"].."*", true, nil, nil, updateUFTextScale},
		--{1, "UFs", "PlayerAbsorb", U["PlayerAbsorb"].."*", nil, nil, nil, togglePlayerAbsorb, U["PlayerAbsorbTip"]},
		--{1, "UFs", "AddPower", U["AddPower"].."*", true, nil, nil, toggleAddPower, U["AddPowerTip"]},
		--{1, "UFs", "OverAbsorb", IsNew..U["OverAbsorb"].."*", nil, nil, nil, nil, U["OverAbsorbTip"]},
		--{3, "UFs", "UFTextScale", U["UFTextScale"].."*", nil, nil, {.8, 1.5, .05}, updateUFTextScale},
		--{4, "UFs", "HealthColor", U["HealthColor"].."*", true, nil, {U["Default Dark"], U["ClassColorHP"], U["GradientHP"], U["ClearHealth"], U["ClearClass"]}, updateUFTextScale},
		{1, "UFs", "Castbars", HeaderTag..U["UFs Castbar"], nil, nil, setupCastbar},
		--{1, "UFs", "LagString", U["Castbar LagString"].."*", true, nil, nil, toggleCastBarLatency},
		{1, "UFs", "SwingBar", U["UFs SwingBar"].."*", true, nil, setupSwingBars, toggleSwingBars},
		{1, "UFs", "PetCB", U["PetCastbar"], true, true},
		--{1, "UFs", "CombatText", HeaderTag..U["UFs CombatText"]},
		--{1, "UFs", "ScrollingCT", U["ScrollingCT"].."*", true, nil},
		--{1, "UFs", "AutoAttack", U["CombatText AutoAttack"].."*"},
		--{1, "UFs", "PetCombatText", U["CombatText ShowPets"].."*", true, nil},
		--{1, "UFs", "HotsDots", U["CombatText HotsDots"].."*"},
		--{1, "UFs", "FCTOverHealing", U["CombatText OverHealing"].."*"},
		--{3, "UFs", "FCTFontSize", U["FCTFontSize"].."*", true, nil, {12, 40, 1}, updateScrollingFont},
		{1, "UFs", "RaidFrame", HeaderTag..U["UFs RaidFrame"], nil, nil, setupRaidFrame, nil, U["RaidFrameTip"]},
		{1, "UFs", "SimpleMode", U["SimpleRaidFrame"], true, nil, setupSimpleRaidFrame, nil, U["SimpleRaidFrameTip"]},
		{1, "UFs", "PartyFrame", HeaderTag..U["PartyFrame"], true, true, setupPartyFrame, nil, U["PartyFrameTip"]},
		{1, "UFs", "PartyPetFrame", HeaderTag..U["PartyPetFrame"], nil, nil, setupPartyPetFrame, nil, U["PartyPetTip"]},
		--{1, "UFs", "PartyWatcher", HeaderTag..U["UFs PartyWatcher"], true, nil, setupPartyWatcher, nil, U["PartyWatcherTip"]},
		--{1, "UFs", "PWOnRight", U["PartyWatcherOnRight"].."*", true, true, nil, updatePartyElements},
		--{1, "UFs", "PartyWatcherSync", U["PartyWatcherSync"], nil, nil, nil, nil, U["PartyWatcherSyncTip"]},
		{1, "UFs", "ShowRaidDebuff", U["ShowRaidDebuff"].."*", true, nil, setupDebuffsIndicator, updateRaidAurasOptions, U["ShowRaidDebuffTip"]},
		{1, "UFs", "ShowRaidBuff", U["ShowRaidBuff"].."*", true, true, setupBuffsIndicator, updateRaidAurasOptions, U["ShowRaidBuffTip"]},
		--{1, "UFs", "DebuffClickThru", U["DebuffClickThru"].."*", nil, nil, nil, updateRaidAurasOptions, U["ClickThroughTip"]},
		--{1, "UFs", "BuffClickThru", U["BuffClickThru"].."*", true, nil, nil, updateRaidAurasOptions, U["ClickThroughTip"]},
		{3, "UFs", "RaidDebuffSize", U["RaidDebuffSize"].."*", nil, nil, {5, 30, 1}, updateRaidAurasOptions},
		{3, "UFs", "RaidBuffSize", U["RaidBuffSize"].."*", true, nil, {5, 30, 1}, updateRaidAurasOptions},
		{1, "UFs", "AuraClickThru", U["RaidAuras ClickThrough"].."*", true, true, nil, updateRaidAurasOptions, U["ClickThroughTip"]},
		{},--blank
		{1, "UFs", "RaidBuffIndicator", HeaderTag..U["RaidBuffIndicator"].."*", nil, nil, setupSpellsIndicator, updateRaidAurasOptions, U["RaidBuffIndicatorTip"]},
		{4, "UFs", "BuffIndicatorType", U["BuffIndicatorType"].."*", true, nil, {U["BI_Blocks"], U["BI_Icons"], U["BI_Numbers"]}, updateRaidAurasOptions},
		{3, "UFs", "BuffIndicatorScale", U["BuffIndicatorScale"].."*", true, true, {.8, 2, .1}, updateRaidAurasOptions},
		{},--blank
		{1, "UFs", "InstanceAuras", HeaderTag..U["Instance Auras"].."*", nil, nil, setupRaidDebuffs, updateRaidAurasOptions, U["InstanceAurasTip"]},
		{1, "UFs", "RaidClickSets", HeaderTag..U["Enable ClickSets"], true, nil, setupClickCast},
		{1, "UFs", "AutoRes", HeaderTag..U["UFs AutoRes"], true, true},
		{4, "UFs", "DispellType", U["Dispellable"].."*", nil, nil, {U["Always"], U["Filter"], DISABLE}, updateRaidAurasOptions, U["DispellTypeTip"]},
		{3, "UFs", "RaidDebuffScale", U["RaidDebuffScale"].."*", true, nil, {.8, 2, .1}, updateRaidAurasOptions},
		{3, "UFs", "RaidTextScale", U["UFTextScale"].."*", true, true, {.8, 1.5, .05}, updateRaidTextScale},
		{},--blank
		{4, "UFs", "RaidHealthColor", U["HealthColor"].."*", nil, nil, {U["Default Dark"], U["ClassColorHP"], U["GradientHP"], U["ClearHealth"], U["ClearClass"]}, updateRaidTextScale},
		{4, "UFs", "RaidHPMode", IsNew..U["HealthValueType"].."*", true, nil, {DISABLE, U["ShowHealthPercent"], U["ShowHealthCurrent"], U["ShowHealthLoss"], U["ShowHealthLossPercent"], U["ShowHealthAbsorb"]}, updateRaidTextScale, U["100PercentTip"]},
		{4, "UFs", "ShowRoleMode", U["ShowRoleMode"], true, true, {ALL, DISABLE, U["HideDPSRole"]}},
		{1, "UFs", "ShowSolo", U["ShowSolo"].."*", nil, nil, nil, updateAllHeaders, U["ShowSoloTip"]},
		{1, "UFs", "SmartRaid", HeaderTag..U["SmartRaid"].."*", true, nil, nil, updateAllHeaders, U["SmartRaidTip"]},
		{1, "UFs", "TeamIndex", U["RaidFrame TeamIndex"].."*", true, true, nil, updateTeamIndex},
		{1, "UFs", "SpecRaidPos", U["Spec RaidPos"], nil, nil, nil, nil, U["SpecRaidPosTip"]},
		{1, "UFs", "RCCName", U["ClassColor Name"].."*", true, nil, nil, updateRaidTextScale},
		{1, "UFs", "HideTip", U["HideTooltip"].."*", true, true, nil, updateRaidTextScale, U["HideTooltipTip"]},
	},
	[3] = {
		{1, "Nameplate", "Enable", HeaderTag..U["Enable Nameplate"], nil, nil, setupNameplateSize, refreshNameplates},
		{1, "Nameplate", "FriendPlate", U["FriendPlate"].."*", true, nil, nil, refreshNameplates, U["FriendPlateTip"]},
		{1, "Nameplate", "NameOnlyMode", U["NameOnlyMode"].."*", true, true, setupNameOnlySize, nil, U["NameOnlyModeTip"]},
		--{4, "Nameplate", "NameType", U["NameTextType"].."*", nil, nil, {DISABLE, U["Tag:name"], U["Tag:levelname"], U["Tag:rarename"], U["Tag:rarelevelname"]}, refreshNameplates, U["PlateLevelTagTip"]},
		{4, "Nameplate", "HealthType", U["HealthValueType"].."*", nil, nil, G.HealthValues, refreshNameplates, U["100PercentTip"]},
		{4, "Nameplate", "DispellMode", U["Dispellable"].."*", true, nil, {U["Filter"], U["Always"], DISABLE}, refreshNameplates, U["DispellableTip"]},
		{4, "Nameplate", "AuraFilter", U["NameplateAuraFilter"].."*", true, true, {U["BlackNWhite"], U["PlayerOnly"], U["IncludeCrowdControl"]}, refreshNameplates},
		{1, "Nameplate", "PlateAuras", HeaderTag..U["PlateAuras"].."*", nil, nil, setupNameplateFilter, refreshNameplates},
		{1, "Nameplate", "Desaturate", U["DesaturateIcon"].."*", true, nil, nil, refreshNameplates, U["DesaturateIconTip"]},
		{1, "Nameplate", "DebuffColor", U["DebuffColor"].."*", true, true, nil, refreshNameplates, U["DebuffColorTip"]},
		{3, "Nameplate", "FontSize", U["AuraFontSize"].."*", nil, nil, {10, 30, 1}, refreshNameplates},
		{3, "Nameplate", "SizeRatio", U["SizeRatio"].."*", true, nil, {.5, 1, .1}, refreshNameplates},
		{3, "Nameplate", "maxAuras", U["Max Auras"].."*", true, true, {1, 20, 1}, refreshNameplates},
		{3, "Nameplate", "AuraSize", U["Auras Size"].."*", nil, nil, {18, 40, 1}, refreshNameplates},
		--{4, "Nameplate", "TargetIndicator", U["TargetIndicator"].."*", nil, nil, {DISABLE, U["TopArrow"], U["RightArrow"], U["TargetGlow"], U["TopNGlow"], U["RightNGlow"]}, refreshNameplates},
		{3, "Nameplate", "ExecuteRatio", "|cffff0000"..U["ExecuteRatio"].."*", true, nil, {0, 90, 1}, nil, U["ExecuteRatioTip"]},
		{3, "Nameplate", "ExecuteRatio", U["ExecuteRatio"].."*", true, true, {0, 90, 1}, nil, U["ExecuteRatioTip"]},
		{1, "Nameplate", "FriendlyCC", U["Friendly CC"].."*"},
		{1, "Nameplate", "HostileCC", U["Hostile CC"].."*", true},
		--{1, "Nameplate", "FriendlyThru", "|cffff0000"..U["Friendly ClickThru"].."*", nil, nil, nil, updateClickThru, U["PlateClickThruTip"]},
		--{1, "Nameplate", "EnemyThru", "|cffff0000"..U["Enemy ClickThru"].."*", true, nil, nil, updateClickThru, U["PlateClickThruTip"]},
		{1, "Nameplate", "UnitTargeted", U["Show TargetedBy"].."*", true, true, nil, refreshPlateByEvents, U["TargetedByTip"]},
		{1, "Nameplate", "CastTarget", U["PlateCastTarget"].."*", nil, nil, nil, nil, U["PlateCastTargetTip"]},
		{1, "Nameplate", "InsideView", U["Nameplate InsideView"].."*", true, nil, nil, UpdatePlateCVars},
		{1, "Nameplate", "Interruptor", U["ShowInterruptor"].."*", true, true},
		--{1, "Nameplate", "QuestIndicator", U["QuestIndicator"]},
		--{1, "Nameplate", "AKSProgress", U["MythicProgress"], true},
		{1, "Nameplate", "BlockDBM", U["BlockDBM"], nil, nil, nil, nil, U["BlockDBMTip"]},
		{1, "Nameplate", "ColoredTarget", HeaderTag..U["ColoredTarget"].."*", true, nil, nil, nil, U["ColoredTargetTip"]},
		{1, "Nameplate", "ColoredFocus", HeaderTag..U["ColoredFocus"].."*", true, true, nil, nil, U["ColoredFocusTip"]},
		{5, "Nameplate", "TargetColor", U["TargetNP Color"].."*"},
		{5, "Nameplate", "FocusColor", U["FocusNP Color"].."*", 1},
		{5, "Nameplate", "SecureColor", U["Secure Color"].."*", 2},
		{5, "Nameplate", "TransColor", U["Trans Color"].."*", 3},
		{5, "Nameplate", "InsecureColor", U["Insecure Color"].."*", 4},
		{5, "Nameplate", "OffTankColor", U["OffTank Color"].."*", 5},
		{1, "Nameplate", "ColorByDot", HeaderTag..U["ColorByDot"].."*", nil, nil, setupNameplateColorDots, nil, U["ColorByDotTip"]},
		{1, "Nameplate", "CastbarGlow", HeaderTag..U["PlateCastbarGlow"].."*", true, nil, setupPlateCastbarGlow, nil, U["PlateCastbarGlowTip"]},
		{1, "Nameplate", "ShowCustomUnits", HeaderTag..U["ShowCustomUnits"].."*", true, true, setupNameplateUnitFilter, updateCustomUnitList, U["CustomUnitsTip"]},
		{1, "Nameplate", "ShowPowerUnits", HeaderTag..U["ShowPowerUnits"].."*", nil, nil, setupNameplatePowerUnits, updatePowerUnitList, U["PowerUnitsTip"]},
		{1, "Nameplate", "TankMode", HeaderTag..U["Tank Mode"].."*", true, nil, nil, nil, U["TankModeTip"]},
		{1, "Nameplate", "DPSRevertThreat", U["DPS Revert Threat"].."*", true, true, nil, nil, U["RevertThreatTip"]},	
		{1, "Nameplate", "CVarOnlyNames", U["CVarOnlyNames"], nil, nil, nil, updatePlateCVars, U["CVarOnlyNamesTip"]},
		{1, "Nameplate", "CVarShowNPCs", U["CVarShowNPCs"].."*", true, nil, nil, updatePlateCVars, U["CVarShowNPCsTip"]},
	},
	[4] = {
		{3, "Nameplate", "PlateRange", U["PlateRange"].."*", nil, nil, {0, 60, 1}, updatePlateCVars, U["PlateRange"]},  --PlateRangeTip
		{3, "Nameplate", "VerticalSpacing", U["NP VerticalSpacing"].."*", true, nil, {.5, 2.5, .1}, updatePlateCVars},
		{3, "Nameplate", "MinScale", U["Nameplate MinScale"].."*", true, true, {.5, 1, .1}, updatePlateCVars},
		--{3, "Nameplate", "MinAlpha", U["Nameplate MinAlpha"].."*", true, nil, {.3, 1, .1}, updatePlateCVars},
		{},--blank
		{1, "Nameplate", "ShowPlayerPlate", HeaderTag..U["Enable PlayerPlate"].."*", nil, nil, nil, togglePlayerPlate},
		{1, "Auras", "ClassAuras", U["Enable ClassAuras"], true,},
		{1, "Nameplate", "TargetPower", HeaderTag..U["TargetClassPower"].."*", true, true, nil, toggleTargetClassPower},
		{1, "Nameplate", "PPFadeout", U["PlayerPlate Fadeout"].."*", nil, nil, nil, togglePlateVisibility},
		{1, "Nameplate", "PPOnFire", U["PlayerPlate OnFire"], true, nil, nil, nil, U["PPOnFireTip"]},
		{1, "Nameplate", "PPPowerText", U["PlayerPlate PowerText"].."*", true, true, nil, togglePlatePower},
		{3, "Nameplate", "PPFadeoutAlpha", U["PlayerPlate FadeoutAlpha"].."*", nil, nil, {0, .5, .05}, togglePlateVisibility},
		{3, "Nameplate", "PPWidth", U["Width"].."*", true, nil, {100, 500, 1}, refreshNameplates},
		{3, "Nameplate", "PPBarHeight", U["PlayerPlate CPHeight"].."*", true, true, {2, 15, 1}, refreshNameplates},
		{3, "Nameplate", "PPHealthHeight", U["PlayerPlate HPHeight"].."*", false, nil, {2, 15, 1}, refreshNameplates},
		{3, "Nameplate", "PPPowerHeight", U["PlayerPlate MPHeight"].."*", true, nil, {2, 15, 1}, refreshNameplates},
		{},--blank
		{1, "Auras", "BuffFrame", HeaderTag..U["BuffFrame"], nil, nil, setupBuffFrame, nil, U["BuffFrameTip"]},
		{1, "Auras", "HideBlizBuff", U["HideBlizUI"], true, nil, nil, nil, U["HideBlizBuffTip"]},
		{1, "Nameplate", "PPGCDTicker", U["PlayerPlate GCDTicker"].."*", true, true, nil, toggleGCDTicker},
		{},--blank
		{1, "AuraWatch", "Enable", HeaderTag..U["Enable AuraWatch"], false, false, setupAuraWatch},
		{1, "AuraWatch", "DeprecatedAuras", U["DeprecatedAuras"], true},
		{1, "AuraWatch", "ClickThrough", U["AuraWatch ClickThrough"], true, true, nil, nil, U["ClickThroughTip"]},
		{1, "Auras", "Totems", HeaderTag..U["Enable Totembar"]},
		{1, "Auras", "VerticalTotems", U["VerticalTotems"].."*", true, nil, nil, refreshTotemBar},
		{1, "Auras", "Reminder", U["Enable Reminder"].."*", true, true, nil, updateReminder, U["ReminderTip"]},
		{3, "Auras", "TotemSize", U["TotemSize"].."*", nil, nil, {24, 60, 1}, refreshTotemBar},
		{3, "AuraWatch", "IconScale", U["AuraWatch IconScale"], true, nil, {.8, 2, .1}},
		{3, "AuraWatch", "MinCD", U["AuraWatch MinCD"].."*", true, true, {1, 60, 1}, nil, U["MinCDTip"]},
	},
	[5] = {
		{1, "Misc", "RaidTool", HeaderTag..U["Raid Manger"]},
		{1, "Misc", "RMRune", U["Runes Check"].."*", true},
		{4, "Misc", "EasyMarkKey", U["EasyMark"].."*", nil, nil, {"CTRL", "ALT", "SHIFT", DISABLE}, nil, U["EasyMarkTip"]},
		{4, "Misc", "ShowMarkerBar", U["ShowMarkerBar"].."*", true, nil, {U["Grids"], U["Horizontal"], U["Vertical"], DISABLE}, updateMarkerGrid, U["ShowMarkerBarTip"]},
		{3, "Misc", "MarkerSize", U["MarkerSize"].."*", true, true, {12, 50, 1}, updateMarkerGrid},
		{2, "Misc", "DBMCount", U["DBMCount"].."*", nil, nil, nil, nil, U["DBMCountTip"]},
		{2, "ACCOUNT", "IgnoredRares", IsNew..U["IgnoredRares"].."*", true, nil, updateIgnoredRares, U["IgnoredRaresTip"]},
		{1, "Misc", "QuestNotification", HeaderTag..U["QuestNotification"].."*", false, false, nil, nil, updateQuestNotification},
		{1, "Misc", "QuestProgress", U["QuestProgress"].."*", true},
		{1, "Misc", "OnlyCompleteRing", U["OnlyCompleteRing"].."*", true, true, nil, nil, U["OnlyCompleteRingTip"]},
		{1, "Misc", "InterruptAlert", HeaderTag..U["InterruptAlert"].."*", nil, nil, nil, updateInterruptAlert},
		{1, "Misc", "OwnInterrupt", U["OwnInterrupt"].."*", true},
		{1, "Misc", "DispellAlert", HeaderTag..U["DispellAlert"].."*", true, true, nil, updateInterruptAlert},
		{1, "Misc", "OwnDispell", U["OwnDispell"].."*"},
		{1, "Misc", "BrokenAlert", HeaderTag..U["BrokenAlert"].."*", true, nil, nil, updateInterruptAlert, U["BrokenAlertTip"]},
		{1, "Misc", "InstAlertOnly", U["InstAlertOnly"].."*", true, true, nil, updateInterruptAlert, U["InstAlertOnlyTip"]},
		{1, "Misc", "SpellItemAlert", U["SpellItemAlert"].."*", nil, nil, nil, updateSpellItemAlert, U["SpellItemAlertTip"]},
		{1, "Misc", "LeaderOnly", IsNew..U["LeaderOnly"].."*", true, nil, nil, nil, U["LeaderOnlyTip"]},
		{},--blank
		--{1, "Misc", "NzothVision", U["NzothVision"]},
		{1, "Misc", "InterruptSound", U["Interrupt Alarm"]},
		{1, "Misc", "AutoMark", U["Auto Mark"], true},
		{1, "Misc", "SoloInfo", U["SoloInfo"].."*", true, true, nil, nil, updateSoloInfo},
		{1, "Misc", "RareAlerter", HeaderTag..U["Rare Alert"].."*", nil, nil, nil, nil, updateRareAlert},
		{1, "Misc", "RarePrint", U["Alert In Chat"].."*", true},
		{1, "Misc", "RareAlertInWild", U["RareAlertInWild"].."*", true, true},
		--{1, "Misc", "kAutoOpen", U["kAutoOpen"], true},
		--{1, "Misc", "AutoConfirmRoll", U["AutoConfirmRoll"], true, true},
		{1, "Misc", "QuickQueue", U["QuickQueue"]},
		{1, "Misc", "AutoReagentInBank", U["Auto Reagent Bank"], true},
		{1, "Misc", "HunterPetHelp", U["HunterPetHelp"], true, true},
		{1, "Misc", "CtrlIndicator", U["Shiftfreeze"]},
		--{1, "Misc", "BlinkRogueHelper", U["BlinkRogueHelper"], true},
		{1, "Misc", "WallpaperKit", U["WallpaperKit"], true},
		{1, "Misc", "CrazyCatLady", U["Death Alarm"], true, true},
		{1, "UFs", "UFFade", U["UFFade"]},
		{1, "UFs", "UFPctText", U["UFPctText"], true},
	},
	[6] = {
		{1, "Chat", "Lock", HeaderTag..U["Lock Chat"]},
		{1, "Chat", "Outline", U["Font Outline"], true},
		{1, "Chat", "Sticky", U["Chat Sticky"].."*", true, true, nil, updateChatSticky},
		{3, "Chat", "ChatWidth", U["LockChatWidth"].."*", nil, nil, {200, 600, 1}, updateChatSize},
		{3, "Chat", "ChatHeight", U["LockChatHeight"].."*", true, nil, {100, 500, 1}, updateChatSize},
		{3, "Chat", "Matches", U["Keyword Match"].."*", true, true, {1, 3, 1}},
		{},--blank
		{4, "ACCOUNT", "TimestampFormat", U["TimestampFormat"].."*", nil, nil, {DISABLE, "03:27 PM", "03:27:32 PM", "15:27", "15:27:32"}},
		{4, "Chat", "ChatBGType", U["ChatBGType"].."*", true, nil, {DISABLE, U["Default Dark"], U["Gradient"]}, toggleChatBackground},
		--{1, "Chat", "Oldname", U["Default Channel"]},
		{3, "Chat", "EditFont", U["EditFont"].."*", true, true, {10, 30, 1}, toggleEditBoxAnchor},
		{1, "Chat", "Chatbar", U["ShowChatbar"]},
		{1, "Chat", "WhisperColor", U["Differ WhisperColor"].."*", true},
		{1, "Chat", "ChatItemLevel", U["ShowChatItemLevel"], true, true},
		{1, "Chat", "Freedom", U["Language Filter"].."*", nil, nil, nil, toggleLanguageFilter},
		{1, "Chat", "WhisperSound", U["WhisperSound"].."*", true, nil, nil, nil, U["WhisperSoundTip"]},
		{1, "Chat", "BottomBox", U["BottomBox"].."*", true, true, nil, toggleEditBoxAnchor},
		{1, "Chat", "SysFont", U["SysFont"], nil, nil, nil, nil, U["SysFontTip"]},
		{1, "Chat", "EnableFilter", HeaderTag..U["Enable Chatfilter"], true},
		{1, "Chat", "BlockAddonAlert", U["Block Addon Alert"]},
		{1, "Chat", "BlockSpammer", U["BlockSpammer"].."*", true, nil, nil, nil, U["BlockSpammerTip"]},
		{1, "Chat", "BlockStranger", "|cffff0000"..U["BlockStranger"].."*", true, true, nil, nil, U["BlockStrangerTip"]},
		{1, "Chat", "Invite", HeaderTag..U["Whisper Invite"]},
		{1, "Chat", "GuildInvite", U["Guild Invite Only"].."*", true},
		{2, "ACCOUNT", "ChatFilterWhiteList", HeaderTag..U["ChatFilterWhiteList"].."*", nil, nil, nil, updateFilterWhiteList, U["ChatFilterWhiteListTip"]},
		{2, "ACCOUNT", "ChatFilterList", U["Filter List"].."*", true, nil, nil, updateFilterList, U["FilterListTip"]},
		{2, "Chat", "Keyword", U["Whisper Keyword"].."*", true, true, nil, updateWhisperList, U["WhisperKeywordTip"]},
	},
	[7] = {
		{1, "Map", "DisableMap", "|cffff0000"..U["DisableMap"], nil, nil, nil, nil, U["DisableMapTip"]},
		{1, "Map", "MapRevealGlow", U["MapRevealGlow"].."*", true, nil, nil, nil, U["MapRevealGlowTip"]},
		{1, "Map", "DisableMinimap", "|cffff0000"..U["DisableMinimap"], true, true, nil, nil, U["DisableMinimapTip"]},
		{3, "Map", "MinimapScale", U["Minimap Scale"].."*", nil, nil, {.5, 3, .1}, updateMinimapScale},
		{3, "Map", "MinimapSize", U["Minimap Size"].."*", true, nil, {100, 500, 1}, updateMinimapScale},
		{3, "Skins", "FontScale", U["GlobalFontScale"], true, true, {.5, 1.5, .05}},
		--{2, "ACCOUNT", "IgnoredButtons", U["IgnoredButtons"], true, true, nil, U["IgnoredButtonsTip"]},
		--{1, "Map", "Calendar", U["MinimapCalendar"].."*", true, true, nil, showCalendar, U["MinimapCalendarTip"]},
		{1, "Map", "Clock", U["Minimap Clock"].."*", nil, nil, nil, showMinimapClock},
		{1, "Map", "CombatPulse", U["Minimap Pulse"], true},
		{1, "Map", "WhoPings", U["Show WhoPings"], true, true},
		{1, "Map", "EasyVolume", U["EasyVolume"], nil, nil, nil, U["EasyVolumeTip"]},
		{1, "Misc", "ExpRep", U["Show Expbar"], true},
		--{1, "Misc", "WorldQusetRewardIcons", U["WorldQusetRewardIcons"], true},
		{1, "Map", "MapShrinker", "大地图精简皮肤", true, true},
		--{1, "Map", "ShowRecycleBin", U["Show RecycleBin"]},
		--{3, "Misc", "WorldQusetRewardIconsSize", "WorldQusetRewardIconsSize", true, false, {21, 66, 1}},
		--{3, "UFs", "PlayerFrameScale", U["PlayerFrame Scale"], nil, nil, {0.6, 1.2, .1}},	
		{3, "Map", "MapScale", U["Map Scale"].."*", nil, nil, {.8, 2, .1}},
		{3, "Map", "MaxMapScale", U["Maximize Map Scale"].."*", true, nil, {.5, 1, .1}},
		{3, "Map", "MinimapScale", U["Minimap Scale"].."*", nil, nil, {1, 2, .1}, updateMinimapScale},
		{3, "Map", "zrMMbuttonsize", "小地图收纳图标大小".."*", true, nil, {10, 40, 1}, nil, updateMinimapScale},
		{4, "Map", "zrMMbuttonpos", "小地图图标收纳位置".."*", true, true, {U["TOP"], U["BOTTOM"], U["LEFT"], U["RIGHT"]}, updateMinimapScale, "更改后RL生效"},
		{},--blank
		--{1, "Skins", "BlizzardSkins", HeaderTag..U["BlizzardSkins"], nil, nil, nil, nil, U["BlizzardSkinsTips"]},
		--{1, "Skins", "AlertFrames", U["ReskinAlertFrames"]},
		{1, "Skins", "QuestTracker", U["QuestTracker"]},
		--{1, "Skins", "Loot", U["Loot"], true},
		{1, "Skins", "PetBattle", U["PetBattle Skin"], true},
		--{1, "Skins", "FlatMode", U["FlatMode"], true, true},
		--{1, "Skins", "Shadow", U["Shadow"]},
		--{1, "Skins", "FontOutline", U["FontOutline"], true},
		--{1, "Skins", "BgTex", U["BgTex"]},
		--{1, "Skins", "GreyBD", U["GreyBackdrop"], true, nil, nil, nil, U["GreyBackdropTip"]},
		--{3, "Skins", "SkinAlpha", U["SkinAlpha"].."*", nil, nil, {0, 1, .05}, updateSkinAlpha},
		--{1, "Skins", "ClassLine", U["ClassColor Line"]},
		--{1, "Skins", "InfobarLine", U["Infobar Line"], true},
		--{1, "Skins", "ChatbarLine", U["Chat Line"]},
		--{1, "Skins", "MenuLine", U["Menu Line"], true},
		--{1, "Skins", "Skada", U["Skada Skin"]},
		{},--blank
		{1, "Skins", "DBM", U["DBM Skin"]},
		{1, "Skins", "Details", U["Details Skin"], true, nil, resetDetails},
		{4, "Skins", "ToggleDirection", U["ToggleDirection"].."*", true, true, {U["LEFT"], U["RIGHT"], U["TOP"], U["BOTTOM"], DISABLE}, updateToggleDirection},
		{},--blank
		{1, "Skins", "Bigwigs", U["Bigwigs Skin"]},
		{1, "Skins", "TMW", U["TMW Skin"], true},
		{1, "Skins", "WeakAuras", U["WeakAuras Skin"], true, true},
		{1, "Skins", "Rematch", U["Rematch Skin"]},
		{1, "Skins", "PGFSkin", U["PGF Skin"], true},
	},
	[8] = {
		--{3, "Tooltip", "Scale", U["Tooltip Scale"].."*", nil, nil, {.5, 1.5, .1}},
		{4, "Tooltip", "TipAnchor", U["TipAnchor"].."*", nil, nil, {U["TOPLEFT"], U["TOPRIGHT"], U["BOTTOMLEFT"], U["BOTTOMRIGHT"]}, nil, U["TipAnchorTip"]},
		{4, "Tooltip", "HideInCombat", IsNew..U["HideInCombat"].."*", true, true, {DISABLE, "ALT", "SHIFT", "CTRL", ALWAYS}, nil, U["HideInCombatTip"]},
		{4, "Tooltip", "CursorMode", U["Follow Cursor"].."*", true, nil, {DISABLE, U["LEFT"], U["TOP"], U["RIGHT"]}},
		{1, "Tooltip", "HideTitle", U["Hide Title"].."*"},
		{1, "Tooltip", "HideRank", U["Hide Rank"].."*", true},
		{1, "Tooltip", "FactionIcon", U["FactionIcon"].."*", true, true},
		{1, "Tooltip", "HideJunkGuild", U["HideJunkGuild"].."*"},
		{1, "Tooltip", "HideRealm", U["Hide Realm"].."*", true},
		{1, "Tooltip", "SpecLevelByShift", U["Show SpecLevelByShift"].."*", true, true},
		{1, "Tooltip", "LFDRole", U["Group Roles"].."*"},
		{1, "Tooltip", "TargetBy", U["Show TargetedBy"].."*", true},
		{1, "Tooltip", "MythicScore", U["MDScore"].."*", true, true, nil, nil, U["MDScoreTip"]},
		{1, "Tooltip", "ItemQuality", U["ShowItemQuality"].."*"},
		{1, "Tooltip", "HideAllID", "|cffff0000"..U["HideAllID"], true},
		{1, "Tooltip", "AzeriteArmor", HeaderTag..U["Show AzeriteArmor"], true, true},
		{1, "Tooltip", "OnlyArmorIcons", U["Armor icons only"].."*"},
		{1, "Misc", "ItemLevel", HeaderTag..U["Show ItemLevel"], true, nil, nil, nil, U["ItemLevelTip"]},
		{1, "Misc", "MissingStats", HeaderTag..U["Show MissingStats"], true, true},
		{1, "Misc", "GemNEnchant", U["Show GemNEnchant"].."*"},
		{1, "Misc", "AzeriteTraits", U["Show AzeriteTraits"].."*", true},
		{1, "Misc", "HideTalking", U["No Talking"], true, true},
		{1, "ACCOUNT", "AutoBubbles", U["AutoBubbles"]},
		{1, "Misc", "HideBossEmote", U["HideBossEmote"].."*", true, nil, nil, toggleBossEmote},
		{1, "Misc", "HideBossBanner", U["Hide Bossbanner"].."*", true, true, nil, toggleBossBanner},
		{1, "Misc", "InstantDelete", U["InstantDelete"].."*"},
		{1, "Misc", "FasterLoot", U["Faster Loot"].."*", true, nil, nil, updateFasterLoot},
		{1, "Misc", "BlockInvite", "|cffff0000"..U["BlockInvite"].."*", true, true, nil, nil, U["BlockInviteTip"]},
		{1, "Misc", "FasterSkip", U["FasterMovieSkip"], nil, nil, nil, nil, U["FasterMovieSkipTip"]},
		{1, "Misc", "BlockRequest", "|cffff0000"..U["BlockRequest"].."*", true, nil, nil, nil, U["BlockRequestTip"]},
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
		{1, "Misc", "QuickJoin", HeaderTag..U["EnhancedPremade"], true, nil, nil, nil, U["EnhancedPremadeTip"]},
		--{1, "Misc", "SingingSocket", IsNew..U["SingingSocket"], true, true, nil, U["SingingSocketTip"]},
		--{1, "ACCOUNT", "VersionCheck", U["Version Check"]},
		{1, "ACCOUNT", "LockUIScale", U["Lock UIScale"], true, true},
		--{1, "ACCOUNT", "DisableInfobars", "|cffff0000"..U["DisableInfobars"], true},
	},
	[9] = {
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
			MaoRUISetDB[value] = newValue
		else
			return MaoRUISetDB[value]
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
	local parent, offset = guiPage[i].child, 40

	for _, option in pairs(G.OptionList[i]) do
		local optType, key, value, name, horizon, horizon2, data, callback, tooltip, disabled = unpack(option)
		local isNew
		if name then
			local rawName, hasNew = gsub(name, "ISNEW", "")
			name = rawName
			if hasNew > 0 then isNew = true end
		end

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
			if isNew then AddNewTag(cb, cb.name) end
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
			if disabled then cb:Hide() end
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
				offset = offset + 55
			end
			eb:SetText(CheckUIOption(key, value))
			eb:HookScript("OnEscapePressed", restoreEditbox)
			eb:HookScript("OnEnterPressed", acceptEditbox)

			local fs = M.CreateFS(eb, 14, name, "system", "CENTER", 0, 18)
			if isNew then AddNewTag(eb, fs) end
			local tip = U["EditBox Tip"]
			if tooltip then tip = tooltip.."|n"..tip end
			M.AddTooltip(eb, "ANCHOR_RIGHT", tip, "info", true)
		-- Slider
		elseif optType == 3 then
			local min, max, step = unpack(data)
			local x, y
			if horizon2 then
				x, y = 540, -offset + 30
			elseif horizon then
				x, y = 300, -offset + 30
			else
				x, y = 55, -offset - 26
				offset = offset + 55
			end
			local s = M.CreateSlider(parent, name, min, max, step, x, y)
			if isNew then AddNewTag(s, s.Text) end
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

			local dd = M.CreateDropDown(parent, 180, 21, data)
			if horizon2 then
				dd:SetPoint("TOPLEFT", 560, -offset + 28)
			elseif horizon then
				dd:SetPoint("TOPLEFT", 310, -offset + 28)
			else
				dd:SetPoint("TOPLEFT", 70, -offset - 21)
				offset = offset + 55
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

			local fs = M.CreateFS(dd, 14, name, "system", "CENTER", 0, 18)
			if isNew then AddNewTag(dd, fs) end
			if tooltip then
				M.AddTooltip(dd, "ANCHOR_RIGHT", tooltip, "info", true)
			end
		-- Colorswatch
		elseif optType == 5 then
			local swatch = M.CreateColorSwatch(parent, name, CheckUIOption(key, value))
			if isNew then AddNewTag(swatch) end
			local width = 65 + (horizon or 0)*130
			if horizon then
				swatch:SetPoint("TOPLEFT", width, -offset + 26)
			else
				swatch:SetPoint("TOPLEFT", width, -offset - 2)
				offset = offset + 28
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


StaticPopupDialogs["RELOAD_UI"] = {
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
	f = CreateFrame("Frame", "UIGUI", UIParent)
	tinsert(UISpecialFrames, "UIGUI")
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

	--[[local close = M.CreateButton(f, 72, 21, "关闭")
	close:SetPoint("BOTTOM", -310, 68)
	close:SetScript("OnClick", function() f:Hide() end)]]
	
	local MrHelp = M.CreateButton(f, 72, 21, "帮助")
	MrHelp:SetPoint("BOTTOM", -310, 68)
	MrHelp:SetScript("OnClick", function() SenduiCmd("/MrHelp") f:Hide() end)

	local ok = M.CreateButton(f, 72, 21, "确定")
	ok:SetPoint("BOTTOM", 320, 68)
	ok:SetScript("OnClick", function()
		M:SetupUIScale()
		f:Hide()
		if G.needUIReload then
			StaticPopup_Show("RELOAD_UI")
			G.needUIReload = nil
		end
	end)
	
	local KeyBind = M.CreateButton(f, 80, 21, MINIMAP_MENU_KEYBIND)
	KeyBind:SetPoint("BOTTOM", -380, 100)
	KeyBind:SetScript("OnClick", function() SenduiCmd("/Keybind") f:Hide() end)
	
	local MoveFrames = M.CreateButton(f, 80, 21, MINIMAP_MENU_SPECIALBUTTON)
	MoveFrames:SetPoint("BOTTOM", -295, 100)
	MoveFrames:SetScript("OnClick", function() SenduiCmd("/moveit") f:Hide() end)
	
	local Awc = M.CreateButton(f, 80, 21, MINIMAP_MENU_AURADIY)
	Awc:SetPoint("BOTTOM", -210, 100)
	Awc:SetScript("OnClick", function() SenduiCmd("/awc") f:Hide() end)
	
	local Dex = M.CreateButton(f, 80, 21, MINIMAP_MENU_DAMAGESTYLE)
	Dex:SetPoint("BOTTOM", -125, 100)
	Dex:SetScript("OnClick", function() SenduiCmd("/dex") f:Hide() end)
	
	local Dcp = M.CreateButton(f, 80, 21, MINIMAP_MENU_DOOMCOOLDOWN)
	Dcp:SetPoint("BOTTOM", -40, 100)
	Dcp:SetScript("OnClick", function() SenduiCmd("/dcp") f:Hide() end)

	local SwitchUF = M.CreateButton(f, 80, 21, MINIMAP_MENU_SWITCHUF)
	SwitchUF:SetPoint("BOTTOM", 45, 100)
	SwitchUF:SetScript("OnClick", function() SenduiCmd("/loadmr") f:Hide() end)

	local AFKScreen = M.CreateButton(f, 80, 21, MINIMAP_MENU_AFKSCREEN)
	AFKScreen:SetPoint("BOTTOM", 130, 100)
	AFKScreen:SetScript("OnClick", function() SenduiCmd("/wallpaperkit") f:Hide() end)

	local Simc = M.CreateButton(f, 80, 21, "Simc")
	Simc:SetPoint("BOTTOM", 215, 100)
	Simc:SetScript("OnClick", function() SenduiCmd("/simc") f:Hide() end)

	local Love = M.CreateButton(f, 80, 21, "Love")
	Love:SetPoint("BOTTOM", 300, 100)
	Love:SetScript("OnClick", function() SenduiCmd("/welovewow") f:Hide() end)
	
	local MoreSet = M.CreateButton(f, 80, 21, MINIMAP_MENU_MORE)
	MoreSet:SetPoint("BOTTOM", 385, 100)
	MoreSet:SetScript("OnClick", function() SenduiCmd("/ip") f:Hide() end)
											
	for i, name in pairs(G.TabList) do
		local rawName, isNew = gsub(name, "ISNEW", "")
		guiTab[i] = CreateTab(f, i, rawName)
		if isNew > 0 then AddNewTag(guiTab[i]) end
		guiPage[i] = CreateFrame("ScrollFrame", nil, f)
		guiPage[i]:SetPoint("TOPLEFT", 310, -120)
		guiPage[i]:SetSize(880, 520)
		guiPage[i]:Hide()
		guiPage[i].child = CreateFrame("Frame", nil, guiPage[i])
		guiPage[i].child:SetSize(610, 1)
		guiPage[i]:SetScrollChild(guiPage[i].child)
		CreateOption(i)
	end
	G:CreateProfileGUI(guiPage[9]) -- profile GUI
	G:SetupActionbarStyle(guiPage[1])

	local helpInfo = M.CreateHelpInfo(f, U["Option* Tips"])
	helpInfo:SetPoint("TOP", 280, -88)
	local guiHelpInfo = {
		text = U["GUIPanelHelp"],
		buttonStyle = HelpTip.ButtonStyle.GotIt,
		targetPoint = HelpTip.Point.LeftEdgeCenter,
		onAcknowledgeCallback = M.HelpInfoAcknowledge,
		callbackArg = "GUIPanel",
	}
	if not MaoRUISetDB["Help"]["GUIPanel"] then
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
	local function toggleGUI()
		if InCombatLockdown() then UIErrorsFrame:AddMessage(I.InfoColor..ERR_NOT_IN_COMBAT) return end
		OpenGUI()
		HideUIPanel(GameMenuFrame)
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)
	end

	hooksecurefunc(GameMenuFrame, "InitButtons", function(self)
		self:AddButton("- |cFFFFFF00 2|r|cFFFF0000 UI |r -", toggleGUI)

		for button in self.buttonPool:EnumerateActive() do
			if not button.resized then
				button:SetNormalFontObject("GameFontHighlight")
				button:SetHighlightFontObject("GameFontHighlight")
				button:SetDisabledFontObject("GameFontDisable")
				button:SetSize(160, 27)

				button.resized = true
			end
		end
	end)
end

SlashCmdList["MAORUIGUI"] = OpenGUI
SLASH_MAORUIGUI1 = '/mr'
