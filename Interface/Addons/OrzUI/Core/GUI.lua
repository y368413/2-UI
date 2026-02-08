local _, ns = ...
local B, C, L, DB = unpack(ns)
local G = B:RegisterModule("GUI")

local unpack, strfind, gsub = unpack, strfind, gsub
local tonumber, pairs, ipairs, next, type, tinsert = tonumber, pairs, ipairs, next, type, tinsert
local cr, cg, cb = DB.r, DB.g, DB.b
local guiTab, guiPage, f = {}, {}

-- Default Settings
G.DefaultSettings = {
	MidNight = false,
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
		BuffFrame = true,
		HideBlizBuff = false,
		ReverseBuff = false,
		BuffSize = 30,
		BuffsPerRow = 16,
		ReverseDebuff = false,
		DebuffSize = 34,
		DebuffsPerRow = 16,
		PrivateSize = 21,
		ReversePrivate = false,
		CDAnimation = false,
	},
	AuraWatch = {
		Enable = true,
		ClickThrough = false,
		IconScale = 1,
		DeprecatedAuras = false,
		MinCD = 3,
	},
	Avada = {
		Enable = false,
	},
	UFs = {
		Enables = false,
		Portrait = false,
		ShowAuras = true,
		Arena = true,
		Castbars = true,
		AddPower = true,
		OffOnTop = false,
		RaidFrame = true,
		AutoRes = true,
		NumGroups = 8,
		RaidDirec = 1,
		RaidRows = 1,
		RaidSpacing = 5,
		SimpleMode = true,
		SMRScale = 12,
		SMRPerCol = 30,
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
		RaidClickSets = true,
		TeamIndex = false,
		ClassPower = true,
		CPWidth = 150,
		CPHeight = 5,
		CPxOffset = 12,
		CPyOffset = -2,
		RuneTimer = true,
		RaidBuffIndicator = true,
		PartyFrame = true,
		PartyDirec = 3,
		PartyWidth = 130,
		PartyHeight = 21,
		PartyPowerHeight = 6,
		PartySpacing = 5,
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
		CCName = false,
		RCCName = true,
		HideTip = false,
		SortByRole = true,
		SortAscending = false,
		PlayerAbsorb = false,
		AutoBuffs = false,
		ShowRoleMode = 1,
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
		
		UFPctText = true,
		UFFade = true,
		RaidClickSetsTooltips = false,
	},
	Chat = {
		Sticky = false,
		Lock = true,
		Invite = true,
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
		ChatWidth = 310,
		ChatHeight = 128,
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
		FontSize = 14,
		SizeRatio = .5,
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
		PPHealthBar = true,
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
		PPFadeout = true,
		PPFadeoutAlpha = 0,
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
		UnitTargeted = false,
		ColorByDot = false,
		DotColor = {r=1, g=.5, b=.2},
		DotSpells = {},
		RaidTargetX = 0,
		RaidTargetY = 3,
		PlateRange = 45,
		AurasPerRow = 6,
		ShowDispel = true,

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
		CursorHappy = true,
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
		DBMCount = "8",
		EasyMarkKey = 1,
		ShowMarkerBar = 3,
		MarkerSize = 21,
		BlockInvite = false,
		BlockRequest = false,
		SendActionCD = true,
		MDGuildBest = true,
		FasterSkip = true,
		EnhanceDressup = true,
		QuestTool = true,
		InfoStrLeft = "[spec][time][guild][friend][ping][fps][gold][dura][bags]",
		InfoStrRight = "[zone]",
		InfoSize = 13,
		MaxAddOns = 21,
		MenuButton = true,
		QuickJoin = true,
		MaxZoom = 2.6,
		SingingSocket = true,
		
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
		QuestAutoCollapse = "SCENARIO",
		HideQuests = false,
		AutoRoll = 3,
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
	DetectVersion = DB.Version,
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
	Help = {["GUIPanel"] = true, ["MinimapInfo"] = true, ["AltPower"] = true, ["ChatScroll"] = true, ["ChatSwitch"] = true, ["AutoRepair"] = true, ["QuickJoin"] = true,},
	CornerSpells = {},
	CustomTex = "",
	MajorSpells = {},
	AutoRecycle = false,
	IgnoredButtons = "",
	RaidBuffsWhite = {},
	RaidDebuffsBlack = {},
	NameplateWhite = {},
	NameplateBlack = {},
	IgnoreNotes = {},
	GlowMode = 3,
	IgnoredRares = "",
	AvadaIndex = {},
	AvadaProfile = {},
	AddOnProfiler = false,
	SmoothBars = true,
	MilitaryTime = true,
}

-- Initial settings
G.TextureList = {
	[1] = {texture = DB.normTex, name = L["Highlight"]},
	[2] = {texture = DB.gradTex, name = L["Gradient"]},
	[3] = {texture = DB.flatTex, name = L["Flat"]},
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
	if addon ~= "OrzUI" then return end

	-- Transfer old data START
	if OrzUISetDB["NameplateFilter"] then
		if OrzUISetDB["NameplateFilter"][1] then
			if not OrzUISetDB["NameplateWhite"] then OrzUISetDB["NameplateWhite"] = {} end
			for spellID, value in pairs(OrzUISetDB["NameplateFilter"][1]) do
				OrzUISetDB["NameplateWhite"][spellID] = value
			end
		end
		if OrzUISetDB["NameplateFilter"][2] then
			if not OrzUISetDB["NameplateBlack"] then OrzUISetDB["NameplateBlack"] = {} end
			for spellID, value in pairs(OrzUISetDB["NameplateFilter"][2]) do
				OrzUISetDB["NameplateBlack"][spellID] = value
			end
		end
	end
	if OrzUISetDB["RaidAuraWatch"] then
		if not OrzUISetDB["RaidBuffsWhite"] then OrzUISetDB["RaidBuffsWhite"] = {} end
		for spellID in pairs(OrzUISetDB["RaidAuraWatch"]) do
			OrzUISetDB["RaidBuffsWhite"][spellID] = true
		end
	end
	-- Transfer old data END

	InitialSettings(G.AccountSettings, OrzUISetDB)
	if not next(OrzUIPerDB) then
		for i = 1, 5 do OrzUIPerDB[i] = {} end
	end

	if not OrzUISetDB["ProfileIndex"][DB.MyFullName] then
		OrzUISetDB["ProfileIndex"][DB.MyFullName] = 1
	end

	if OrzUISetDB["ProfileIndex"][DB.MyFullName] == 1 then
		C.db = OrzUIDB
	else
		C.db = OrzUIPerDB[OrzUISetDB["ProfileIndex"][DB.MyFullName] - 1]
	end
	InitialSettings(G.DefaultSettings, C.db, true)

	if not C.db["MidNight"] then
		C.db["Actionbar"]["MBPerRow"] = 1
		C.db["MidNight"] = true
	end

	B:SetupUIScale(true)
	if OrzUISetDB["CustomTex"] ~= "" then
		DB.normTex = "Interface\\"..OrzUISetDB["CustomTex"]
	else
		if not G.TextureList[OrzUISetDB["TexStyle"]] then
			OrzUISetDB["TexStyle"] = 2 -- reset value if not exists
		end
		DB.normTex = G.TextureList[OrzUISetDB["TexStyle"]].texture
	end

	if not C.db["Map"]["DisableMinimap"] then
		GetMinimapShape = B.GetMinimapShape
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
	G:SetupUFClassPower(guiPage[2])
end

local function setupUFAuras()
	G:SetupUFAuras(guiPage[2])
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
	SlashCmdList["ORZUI_AWCONFIG"]()
end

local function updateBagSortOrder()
	C_Container.SetSortBagsRightToLeft(C.db["Bags"]["BagSortMode"] == 1)
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
	B:GetModule("Actionbar"):UpdateBarConfig()
end

local function updateOverlays()
	B:GetModule("Actionbar"):UpdateOverlays()
end

local function updateEquipColor()
	local Bar = B:GetModule("Actionbar")
	for _, button in pairs(Bar.buttons) do
		if button.Border and button.Update then
			Bar.UpdateEquipItemColor(button)
		end
	end
end

local function updateCooldown()
	SetCVar("countdownForCooldowns", C.db["Actionbar"]["Cooldown"] and 1 or 0)
end

local function updateReminder()
	B:GetModule("Auras"):InitReminder()
end

local function refreshTotemBar()
	if not C.db["Auras"]["Totems"] then return end
	B:GetModule("Auras"):TotemBar_Init()
end

local function updateChatSticky()
	B:GetModule("Chat"):ChatWhisperSticky()
end

local function updateWhisperList()
	B:GetModule("Chat"):UpdateWhisperList()
end

local function updateFilterList()
	B:GetModule("Chat"):UpdateFilterList()
end

local function updateFilterWhiteList()
	B:GetModule("Chat"):UpdateFilterWhiteList()
end

local function updateChatSize()
	B:GetModule("Chat"):UpdateChatSize()
end

local function toggleChatBackground()
	B:GetModule("Chat"):ToggleChatBackground()
end

local function toggleEditBoxAnchor()
	B:GetModule("Chat"):ToggleEditBoxAnchor()
end

local function updateToggleDirection()
	B:GetModule("Skins"):RefreshToggleDirection()
end

local function updatePlateCVars()
	B:GetModule("UnitFrames"):UpdatePlateCVars()
end

local function updateCustomUnitList()
	B:GetModule("UnitFrames"):CreateUnitTable()
end

local function updatePowerUnitList()
	B:GetModule("UnitFrames"):CreatePowerUnitTable()
end

local function refreshNameplates()
	B:GetModule("UnitFrames"):RefreshAllPlates()
end

local function updateClickThru()
	B:GetModule("UnitFrames"):UpdatePlateSize()
end

local function togglePlatePower()
	B:GetModule("UnitFrames"):TogglePlatePower()
end

local function togglePlateHealth()
	B:GetModule("UnitFrames"):TogglePlateHealth()
end

local function togglePlateVisibility()
	B:GetModule("UnitFrames"):TogglePlateVisibility()
end

local function toggleAvada()
	B:GetModule("UnitFrames"):Avada_Toggle()
end

local function toggleAvadaGUI()
	G:SetupAvada()
	if f then f:Hide() end
end

local function togglePlayerPlate()
	refreshNameplates()
	B:GetModule("UnitFrames"):TogglePlayerPlate()
end

local function toggleTargetClassPower()
	refreshNameplates()
	B:GetModule("UnitFrames"):ToggleTargetClassPower()
end

local function toggleGCDTicker()
	B:GetModule("UnitFrames"):ToggleGCDTicker()
end

local function updateUFTextScale()
	B:GetModule("UnitFrames"):UpdateTextScale()
end

local function togglePlayerAbsorb()
	if _G.oUF_Player then
		B:GetModule("UnitFrames").UpdateFrameHealthTag(_G.oUF_Player)
	end
end

local function toggleAddPower()
	B:GetModule("UnitFrames"):ToggleAddPower()
end

local function toggleUFClassPower()
	B:GetModule("UnitFrames"):ToggleUFClassPower()
end

local function togglePortraits()
	B:GetModule("UnitFrames"):TogglePortraits()
end

local function toggleAllAuras()
	B:GetModule("UnitFrames"):ToggleAllAuras()
end

local function updateRaidTextScale()
	B:GetModule("UnitFrames"):UpdateRaidTextScale()
end

local function updateAllHeaders()
	B:GetModule("UnitFrames"):UpdateAllHeaders()
end

local function updateTeamIndex()
	local UF = B:GetModule("UnitFrames")
	if UF.CreateAndUpdateRaidHeader then
		UF:CreateAndUpdateRaidHeader()
		UF:UpdateRaidTeamIndex()
	end
	updateRaidTextScale()
end

local function updatePartyElements()
	B:GetModule("UnitFrames"):UpdatePartyElements()
end

local function refreshPlateByEvents()
	B:GetModule("UnitFrames"):RefreshPlateByEvents()
end

local function updateRaidAurasOptions()
	B:GetModule("UnitFrames"):RaidAuras_UpdateOptions()
end

local function refreseExecuteRatio()
	B:GetModule("UnitFrames"):UpdateExcutedCurve()
end

local function updateMinimapScale()
	B:GetModule("Maps"):UpdateMinimapScale()
end

local function showMinimapClock()
	B:GetModule("Maps"):ShowMinimapClock()
end

local function showCalendar()
	B:GetModule("Maps"):ShowCalendar()
end

local function updateInterruptAlert()
	B:GetModule("Misc"):InterruptAlert()
end

local function updateRareAlert()
	B:GetModule("Misc"):RareAlert()
end

local function updateIgnoredRares()
	B:GetModule("Misc"):RareAlert_UpdateIgnored()
end

local function updateSoloInfo()
	B:GetModule("Misc"):SoloInfo()
end

local function updateSpellItemAlert()
	B:GetModule("Misc"):SpellItemAlert()
end

local function updateQuestNotification()
	B:GetModule("Misc"):QuestNotification()
end

local function updateScreenShot()
	B:GetModule("Misc"):UpdateScreenShot()
end

local function updateFasterLoot()
	B:GetModule("Misc"):UpdateFasterLoot()
end

local function toggleBossBanner()
	B:GetModule("Misc"):ToggleBossBanner()
end

local function toggleBossEmote()
	B:GetModule("Misc"):ToggleBossEmote()
end

local function updateMarkerGrid()
	B:GetModule("Misc"):RaidTool_UpdateGrid()
end

local function updateMaxZoomLevel()
	B:GetModule("Misc"):UpdateMaxZoomLevel()
end

local function updateInfobarAnchor(self)
	if self:GetText() == "" then
		self:SetText(self.__default)
		C.db[self.__key][self.__value] = self:GetText()
	end

	if not OrzUISetDB["DisableInfobars"] then
		B:GetModule("Infobar"):Infobar_UpdateAnchor()
	end
end

local function updateInfobarSize()
	B:GetModule("Infobar"):UpdateInfobarSize()
end

local function updateSkinAlpha()
	for _, frame in pairs(C.frames) do
		frame:SetBackdropColor(0, 0, 0, C.db["Skins"]["SkinAlpha"])
	end
end

local function toggleSmooth()
	local UF = B:GetModule("UnitFrames")
	if UF then
		for bar in pairs(UF.smoothbars) do
			UF:SmoothBar(bar)
		end
	end
end

local function updateTimeMode()
	SetCVar("timeMgrUseMilitaryTime", OrzUISetDB["MilitaryTime"] and "1" or "0")
end

StaticPopupDialogs["RESET_DETAILS"] = {
	text = L["Reset Details check"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		B:GetModule("Skins"):ResetDetailsAnchor(true)
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
G.HealthValues = {DISABLE, L["ShowHealthDefault"], L["ShowHealthCurMax"], L["ShowHealthCurrent"], L["ShowHealthPercent"], L["ShowHealthLoss"],}

local function AddNewTag(parent, anchor)
	local tag = CreateFrame("Frame", nil, parent, "NewFeatureLabelTemplate")
	tag:SetPoint("LEFT", anchor or parent, -25, 10)
	tag:Show()
end

G.TabList = {
	IsNew..L["Actionbar"],
	IsNew..L["RaidFrame"],
	L["Nameplate"],
	L["Auras"],
	IsNew..L["Misc"],
	L["ChatFrame"],
	L["Skins"].."&"..L["Maps"],
	L["UI Settings"],
	L["Profile"],
}

G.OptionList = {		-- type, key, value, name, horizon, horizon2, doubleline
	[1] = {
		{1, "Actionbar", "Enable", HeaderTag..L["Enable Actionbar"], nil, nil, setupActionBar},
		--{4, "Actionbar", "Style", L["Actionbar Style"], true, true, {"-- 2*(3+12+3) --", "-- 2*(6+12+6) --", "-- 2*6+3*12+2*6 --", "-- 3*12 --", "-- 2*(12+6) --", "-- 3*(4+12+4) --", "-- What --", "-- MR --", "-- PVP2 --", "-- Cool --", "-- JK --"}},  --nop
		{},--blank
		{1, "Actionbar", "MicroMenu", L["Micromenu"], nil, nil, setupMicroMenu, nil, L["MicroMenuTip"]},
		{1, "Actionbar", "ShowStance", L["ShowStanceBar"], true, nil, setupStanceBar},
		{1, "Actionbar", "Cooldown", HeaderTag..L["Show Cooldown"], true, true},
		{},--blank
		{1, "Actionbar", "OverrideWA", L["HideCooldownOnWA"].."*", nil},
		{1, "Actionbar", "KeyDown", IsNew..L["KeyDown"].."*", true, nil, nil, updateHotkeys, L["KeyDownTip"]},
		{1, "Actionbar", "ButtonLock", IsNew..L["ButtonLock"].."*", true, true, nil, updateHotkeys, L["ButtonLockTip"]},
		{1, "Actionbar", "Hotkeys", L["Actionbar Hotkey"].."*", nil, nil, nil, updateHotkeys},
		{1, "Actionbar", "Macro", L["Actionbar Macro"].."*", true, nil, nil, updateHotkeys},
		{1, "Actionbar", "Grid", L["Actionbar Grid"], true, true, nil, updateHotkeys},
		{1, "Actionbar", "Classcolor", L["ClassColor BG"], nil, nil, nil, updateHotkeys},
		{1, "Actionbar", "EquipColor", L["EquipColor"].."*", true, nil, nil, updateHotkeys},	
		{1, "Misc", "SendActionCD", HeaderTag..L["SendActionCD"].."*", true, true, nil, nil, L["SendActionCDTip"]},	
		--{3, "Actionbar", "MmssTH", IsNew..L["MmssThreshold"].."*", nil, nil, {60, 600, 1}, nil, L["MmssThresholdTip"]},
		--{3, "Actionbar", "TenthTH", IsNew..L["TenthThreshold"].."*", true, nil, {0, 60, 1}, nil, L["TenthThresholdTip"]},
		--{3, "ACCOUNT", "SmoothAmount", L["SmoothAmount"].."*", true, true, {.1, 1, .05}, updateSmoothingAmount, L["SmoothAmountTip"]},
		--{1, "Actionbar", "ShowGlow", L["ShowGlow"].."*", nil, nil, nil, updateOverlays},
		{},--blank
		{3, "Misc", "MaxZoom", L["MaxZoom"].."*", nil, nil, {1, 2.6, .1}, updateMaxZoomLevel},
		{3, "ACCOUNT", "UIScale", L["Setup UIScale"], true, nil, {.4, 1.15, .01}},
		{3, "Misc", "MaxAddOns", L["SysMaxAddOns"].."*", true, true,  {1, 50, 1}, nil, L["SysMaxAddOnsTip"]},
		--{3, "Misc", "InfoSize", L["InfobarFontSize"].."*", true, true,  {10, 50, 1}, updateInfobarSize},
		{2, "Misc", "InfoStrLeft", L["LeftInfobar"].."*", nil, nil, nil, updateInfobarAnchor, L["InfobarStrTip"]},
		{2, "Misc", "InfoStrRight", L["RightInfobar"].."*", true, nil, nil, updateInfobarAnchor, L["InfobarStrTip"]},
		{2, "ACCOUNT", "CustomTex", L["CustomTex"], true, true, nil, nil, L["CustomTexTip"]},
		{4, "ACCOUNT", "TexStyle", L["Texture Style"], false, nil, {}},
		{4, "ACCOUNT", "NumberFormat", L["Numberize"], true, nil, {L["Number Type1"], L["Number Type2"], L["Number Type3"]}},
		{4, "ACCOUNT", "GlowMode", L["GlowMode"].."*", true, true , {"Pixel", "Autocast", "Action Button", "Proc Glow"}},
	},
	[2] = {
		{1, "UFs", "Arena", L["Arena Frame"], nil, nil},
		{1, "UFs", "ShowAuras", L["ShowAuras"].."*", true, nil, setupUFAuras, toggleAllAuras},
		{1, "UFs", "Castbars", HeaderTag..L["UFs Castbar"], nil, nil, setupCastbar},
		{1, "UFs", "PetCB", L["PetCastbar"], true},
		--{1, "UFs", "InstanceAuras", HeaderTag..L["Instance Auras"].."*", nil, nil, setupRaidDebuffs, updateRaidAurasOptions, L["InstanceAurasTip"]},
		--{4, "UFs", "DispellType", L["Dispellable"].."*", nil, nil, {L["Always"], L["Filter"], DISABLE}, updateRaidAurasOptions, L["DispellTypeTip"]},
		--{3, "UFs", "RaidDebuffScale", L["RaidDebuffScale"].."*", true, nil, {.8, 2, .1}, updateRaidAurasOptions},
		{3, "UFs", "RaidTextScale", L["UFTextScale"].."*", true, true, {.8, 1.5, .05}, updateRaidTextScale},
		--{1, "UFs", "RaidClickSetsTooltips", HeaderTag.."快捷施法技能鼠标提示", true, true},
		--{1, "UFs", "AuraClickThru", L["RaidAuras ClickThrough"].."*", true, true, nil, updateRaidAurasOptions, L["ClickThroughTip"]},
		--{1, "UFs", "FCTOverHealing", L["CombatText OverHealing"].."*"},
		--{1, "UFs", "SwingBar", L["UFs SwingBar"].."*", true, nil, setupSwingBars, toggleSwingBars},
		--{3, "UFs", "FCTFontSize", L["FCTFontSize"].."*", true, true, {12, 40, 1}, updateScrollingFont},
		{1, "UFs", "RaidFrame", HeaderTag..L["UFs RaidFrame"], nil, nil, setupRaidFrame, nil, L["RaidFrameTip"]},
		{1, "UFs", "SimpleMode", L["SimpleRaidFrame"], true, nil, setupSimpleRaidFrame, nil, L["SimpleRaidFrameTip"]},
		{1, "UFs", "RaidClickSets", HeaderTag..L["Enable ClickSets"], true, true, setupClickCast},
		{1, "UFs", "PartyFrame", HeaderTag..L["PartyFrame"], nil, nil, setupPartyFrame, nil, L["PartyFrameTip"]},
		{1, "UFs", "PartyPetFrame", HeaderTag..L["PartyPetFrame"], true, nil, setupPartyPetFrame, nil, L["PartyPetTip"]},
		--{1, "UFs", "PartyWatcher", HeaderTag..L["UFs PartyWatcher"], true, nil, setupPartyWatcher, nil, L["PartyWatcherTip"]},
		--{1, "UFs", "PWOnRight", L["PartyWatcherOnRight"].."*", true, true, nil, updatePartyElements},
		--{1, "UFs", "PartyWatcherSync", L["PartyWatcherSync"], nil, nil, nil, nil, L["PartyWatcherSyncTip"]},
		--{1, "UFs", "ShowRaidDebuff", L["ShowRaidDebuff"].."*", true, nil, setupDebuffsIndicator, updateRaidAurasOptions, L["ShowRaidDebuffTip"]},
		--{1, "UFs", "ShowRaidBuff", L["ShowRaidBuff"].."*", true, true, setupBuffsIndicator, updateRaidAurasOptions, L["ShowRaidBuffTip"]},
		--{1, "UFs", "DebuffClickThru", L["DebuffClickThru"].."*", nil, nil, nil, updateRaidAurasOptions, L["ClickThroughTip"]},
		--{1, "UFs", "BuffClickThru", L["BuffClickThru"].."*", true, nil, nil, updateRaidAurasOptions, L["ClickThroughTip"]},
		--{3, "UFs", "RaidDebuffSize", L["RaidDebuffSize"].."*", nil, nil, {5, 30, 1}, updateRaidAurasOptions},
		--{3, "UFs", "RaidBuffSize", L["RaidBuffSize"].."*", true, nil, {5, 30, 1}, updateRaidAurasOptions},
		--{3, "UFs", "BuffIndicatorScale", L["BuffIndicatorScale"].."*", true, true, {.8, 2, .1}, updateRaidAurasOptions},
		--{3, "UFs", "PrivateSize", "PrivateAuras", nil, nil, {5, 30, 1}},
		--{1, "UFs", "RaidBuffIndicator", HeaderTag..L["RaidBuffIndicator"].."*", nil, nil, setupSpellsIndicator, updateRaidAurasOptions, L["RaidBuffIndicatorTip"]},
		--{4, "UFs", "BuffIndicatorType", L["BuffIndicatorType"].."*", true, nil, {L["BI_Blocks"], L["BI_Icons"], L["BI_Numbers"]}, updateRaidAurasOptions},
		{},--blank
		{4, "UFs", "RaidHealthColor", L["HealthColor"].."*", nil, nil, {L["Default Dark"], L["ClassColorHP"], L["GradientHP"], L["ClearHealth"], L["ClearClass"]}, updateRaidTextScale},
		{4, "UFs", "RaidHPMode", IsNew..L["HealthValueType"].."*", true, nil, {DISABLE, L["ShowHealthPercent"], L["ShowHealthCurrent"], L["ShowHealthLoss"]}, updateRaidTextScale, L["100PercentTip"]},
		{4, "UFs", "ShowRoleMode", L["ShowRoleMode"], true, true, {ALL, DISABLE, L["HideDPSRole"]}},
		{1, "UFs", "ShowSolo", L["ShowSolo"].."*", nil, nil, nil, updateAllHeaders, L["ShowSoloTip"]},
		{1, "UFs", "SmartRaid", HeaderTag..L["SmartRaid"].."*", true, nil, nil, updateAllHeaders, L["SmartRaidTip"]},
		{1, "UFs", "TeamIndex", L["RaidFrame TeamIndex"].."*", true, true, nil, updateTeamIndex},
		{1, "UFs", "SpecRaidPos", L["Spec RaidPos"], nil, nil, nil, nil, L["SpecRaidPosTip"]},
		{1, "UFs", "RCCName", L["ClassColor Name"].."*", true, nil, nil, updateRaidTextScale},
		{1, "UFs", "HideTip", L["HideTooltip"].."*", true, true, nil, updateRaidTextScale, L["HideTooltipTip"]},
		{},--blank
		{},--blank
		{1, "UFs", "Enables", HeaderTag..L["Enable UFs"], nil, nil, setupUnitFrame, nil, L["HideUFWarning"]},
		{1, "UFs", "ClassPower", L["UFs ClassPower"].."*", true, nil, setupClassPower, toggleUFClassPower},
		--{1, "UFs", "Portrait", L["UFs Portrait"].."*", nil, nil, nil, togglePortraits},
		{1, "UFs", "CCName", L["ClassColor Name"].."*", true, true, nil, updateUFTextScale},
		--{1, "UFs", "AddPower", L["AddPower"].."*", nil, nil, nil, toggleAddPower, L["AddPowerTip"]},
		{3, "UFs", "UFTextScale", L["UFTextScale"].."*", nil, nil, {.8, 1.5, .05}, updateUFTextScale},
		{4, "UFs", "HealthColor", L["HealthColor"].."*", true, nil, {L["Default Dark"], L["ClassColorHP"], L["GradientHP"], L["ClearHealth"], L["ClearClass"]}, updateUFTextScale},
		{1, "UFs", "PlayerAbsorb", L["PlayerAbsorb"].."*", true, true, nil, togglePlayerAbsorb, L["PlayerAbsorbTip"]},
	},
	[3] = {
		{1, "Nameplate", "Enable", HeaderTag..L["Enable Nameplate"], nil, nil, setupNameplateSize, refreshNameplates},
		{1, "Nameplate", "FriendPlate", L["FriendPlate"].."*", true, nil, nil, refreshNameplates, L["FriendPlateTip"]},
		{1, "Nameplate", "NameOnlyMode", L["NameOnlyMode"].."*", true, true, setupNameOnlySize, nil, L["NameOnlyModeTip"]},
		--{4, "Nameplate", "NameType", L["NameTextType"].."*", nil, nil, {DISABLE, L["Tag:name"], L["Tag:levelname"], L["Tag:rarename"], L["Tag:rarelevelname"]}, refreshNameplates, L["PlateLevelTagTip"]},
		{1, "Nameplate", "PlateAuras", HeaderTag..L["PlateAuras"].."*", nil, nil, setupNameplateFilter, refreshNameplates},
		{1, "Nameplate", "ColoredTarget", HeaderTag..L["ColoredTarget"].."*", true, nil, nil, nil, L["ColoredTargetTip"]},
		{1, "Nameplate", "ColoredFocus", HeaderTag..L["ColoredFocus"].."*", true, true, nil, nil, L["ColoredFocusTip"]},
		{1, "Nameplate", "ShowDispel", L["Dispellable"].."*", nil, nil, nil, refreshNameplates},
		{1, "Nameplate", "Desaturate", L["DesaturateIcon"].."*", true, nil, nil, refreshNameplates, L["DesaturateIconTip"]},
		{1, "Nameplate", "DebuffColor", L["DebuffColor"].."*", true, true, nil, refreshNameplates, L["DebuffColorTip"]},
		{},--blank
		{3, "Nameplate", "FontSize", L["AuraFontSize"].."*", nil, nil, {10, 30, 1}, refreshNameplates},
		{3, "Nameplate", "SizeRatio", L["SizeRatio"].."*", true, nil, {.5, 1, .1}, refreshNameplates},
		{3, "Nameplate", "maxAuras", L["Max Auras"].."*", true, true, {1, 20, 1}, refreshNameplates},
		{3, "Nameplate", "AurasPerRow", L["IconsPerRow"].."*", nil, nil, {1, 20, 1}, refreshNameplates},
		--{4, "Nameplate", "TargetIndicator", L["TargetIndicator"].."*", nil, nil, {DISABLE, L["TopArrow"], L["RightArrow"], L["TargetGlow"], L["TopNGlow"], L["RightNGlow"]}, refreshNameplates},
		{3, "Nameplate", "ExecuteRatio", L["ExecuteRatio"].."*", true, nil, {0, 90, 1}, refreseExecuteRatio, L["ExecuteRatioTip"]},
		{4, "Nameplate", "HealthType", L["HealthValueType"].."*", true, true, G.HealthValues, refreshNameplates, L["100PercentTip"]},
		{},--blank
		{1, "Nameplate", "FriendlyCC", L["Friendly CC"].."*"},
		{1, "Nameplate", "HostileCC", L["Hostile CC"].."*", true},
		{1, "Nameplate", "FriendlyThru", "|cffff0000"..L["Friendly ClickThru"].."*", nil, nil, nil, updateClickThru, L["PlateClickThruTip"]},
		{1, "Nameplate", "EnemyThru", "|cffff0000"..L["Enemy ClickThru"].."*", true, nil, nil, updateClickThru, L["PlateClickThruTip"]},
		--{1, "Nameplate", "UnitTargeted", L["Show TargetedBy"].."*", true, true, nil, refreshPlateByEvents, L["TargetedByTip"]},
		{1, "Nameplate", "CastTarget", L["PlateCastTarget"].."*", nil, nil, nil, nil, L["PlateCastTargetTip"]},
		--{1, "Nameplate", "InsideView", L["Nameplate InsideView"].."*", true, nil, nil, UpdatePlateCVars},
		{1, "Nameplate", "Interruptor", L["ShowInterruptor"].."*", true},
		--{1, "Nameplate", "QuestIndicator", L["QuestIndicator"]},
		--{1, "Nameplate", "AKSProgress", L["MythicProgress"], true},
		{5, "Nameplate", "TargetColor", L["TargetNP Color"].."*"},
		{5, "Nameplate", "FocusColor", L["FocusNP Color"].."*", 1},
		{5, "Nameplate", "SecureColor", L["Secure Color"].."*", 2},
		{5, "Nameplate", "TransColor", L["Trans Color"].."*", 3},
		{5, "Nameplate", "InsecureColor", L["Insecure Color"].."*", 4},
		{5, "Nameplate", "OffTankColor", L["OffTank Color"].."*", 5},
		--{1, "Nameplate", "ColorByDot", HeaderTag..L["ColorByDot"].."*", nil, nil, setupNameplateColorDots, nil, L["ColorByDotTip"]},
		--{1, "Nameplate", "CastbarGlow", HeaderTag..L["PlateCastbarGlow"].."*", true, nil, setupPlateCastbarGlow, nil, L["PlateCastbarGlowTip"]},
		{1, "Nameplate", "ShowCustomUnits", HeaderTag..L["ShowCustomUnits"].."*", nil, nil, setupNameplateUnitFilter, updateCustomUnitList, L["CustomUnitsTip"]},
		--{1, "Nameplate", "ShowPowerUnits", HeaderTag..L["ShowPowerUnits"].."*", nil, nil, setupNameplatePowerUnits, updatePowerUnitList, L["PowerUnitsTip"]},
		{1, "Nameplate", "TankMode", HeaderTag..L["Tank Mode"].."*", true, nil, nil, nil, L["TankModeTip"]},
		{1, "Nameplate", "DPSRevertThreat", L["DPS Revert Threat"].."*", true, true, nil, nil, L["RevertThreatTip"]},	
		{1, "Nameplate", "CVarOnlyNames", L["CVarOnlyNames"], nil, nil, nil, updatePlateCVars, L["CVarOnlyNamesTip"]},
		{1, "Nameplate", "CVarShowNPCs", L["CVarShowNPCs"].."*", true, nil, nil, updatePlateCVars, L["CVarShowNPCsTip"]},
		{1, "ACCOUNT", "SmoothBars", L["SmoothBars"], true, true, nil, toggleSmooth, L["SmoothBarsTip"]},
	},
	[4] = {
		{3, "Nameplate", "PlateRange", L["PlateRange"].."*", nil, nil, {0, 60, 1}, updatePlateCVars, L["PlateRange"]},  --PlateRangeTip
		{3, "Nameplate", "VerticalSpacing", L["NP VerticalSpacing"].."*", true, nil, {.5, 2.5, .1}, updatePlateCVars},
		{3, "Nameplate", "MinScale", L["Nameplate MinScale"].."*", true, true, {.5, 1, .1}, updatePlateCVars},
		--{3, "Nameplate", "MinAlpha", L["Nameplate MinAlpha"].."*", true, nil, {.3, 1, .1}, updatePlateCVars},
		{},--blank
		{1, "Nameplate", "ShowPlayerPlate", HeaderTag..L["Enable PlayerPlate"].."*", nil, nil, nil, togglePlayerPlate},
		--{1, "Auras", "ClassAuras", L["Enable ClassAuras"], true,},
		--{1, "Avada", "Enable", IsNew..HeaderTag..L["Enable ClassAuras"].."*", true, nil, toggleAvadaGUI, toggleAvada},
		{1, "Nameplate", "PPHealthBar", L["PlayerPlate HealthBar"].."*", true, nil, nil, togglePlateHealth},
		{1, "Nameplate", "TargetPower", HeaderTag..L["TargetClassPower"].."*", true, true, nil, toggleTargetClassPower},
		{1, "Nameplate", "PPFadeout", L["PlayerPlate Fadeout"].."*", nil, nil, nil, togglePlateVisibility},
		--{1, "Nameplate", "PPOnFire", L["PlayerPlate OnFire"], true, nil, nil, nil, L["PPOnFireTip"]},
		{1, "Nameplate", "PPPowerText", L["PlayerPlate PowerText"].."*", true, nil, nil, togglePlatePower},
		{3, "Nameplate", "PPFadeoutAlpha", L["PlayerPlate FadeoutAlpha"].."*", nil, nil, {0, .5, .05}, togglePlateVisibility},
		{3, "Nameplate", "PPWidth", L["Width"].."*", true, nil, {100, 500, 1}, refreshNameplates},
		{3, "Nameplate", "PPBarHeight", L["PlayerPlate CPHeight"].."*", true, true, {2, 15, 1}, refreshNameplates},
		{3, "Nameplate", "PPHealthHeight", L["PlayerPlate HPHeight"].."*", false, nil, {2, 15, 1}, refreshNameplates},
		{3, "Nameplate", "PPPowerHeight", L["PlayerPlate MPHeight"].."*", true, nil, {2, 15, 1}, refreshNameplates},
		{},--blank
		{1, "Auras", "BuffFrame", HeaderTag..L["BuffFrame"], nil, nil, setupBuffFrame, nil, L["BuffFrameTip"]},
		{1, "Auras", "HideBlizBuff", L["HideBlizUI"], true, nil, nil, nil, L["HideBlizBuffTip"]},
		{1, "Nameplate", "PPGCDTicker", L["PlayerPlate GCDTicker"].."*", true, true, nil, toggleGCDTicker},
		{},--blank
		{1, "AuraWatch", "Enable", HeaderTag..L["Enable AuraWatch"], false, false, setupAuraWatch},
		{1, "AuraWatch", "DeprecatedAuras", L["DeprecatedAuras"], true},
		{1, "AuraWatch", "ClickThrough", L["AuraWatch ClickThrough"], true, true, nil, nil, L["ClickThroughTip"]},
		{1, "Auras", "Totems", HeaderTag..L["Enable Totembar"]},
		{1, "Auras", "VerticalTotems", L["VerticalTotems"].."*", true, nil, nil, refreshTotemBar},
		--{1, "Auras", "Reminder", L["Enable Reminder"].."*", true, true, nil, updateReminder, L["ReminderTip"]},
		{1, "Auras", "CDAnimation", L["CDAnimation"], true, true},
		{3, "Auras", "TotemSize", L["TotemSize"].."*", nil, nil, {24, 60, 1}, refreshTotemBar},
		{3, "AuraWatch", "IconScale", L["AuraWatch IconScale"], true, nil, {.8, 2, .1}},
		{3, "AuraWatch", "MinCD", L["AuraWatch MinCD"].."*", true, true, {1, 60, 1}, nil, L["MinCDTip"]},
	},
	[5] = {
		{1, "Misc", "RaidTool", HeaderTag..L["Raid Manger"]},
		{1, "Misc", "RMRune", L["Runes Check"].."*", true},
		{4, "Misc", "EasyMarkKey", L["EasyMark"].."*", nil, nil, {"CTRL", "ALT", "SHIFT", DISABLE}, nil, L["EasyMarkTip"]},
		{4, "Misc", "ShowMarkerBar", L["ShowMarkerBar"].."*", true, nil, {L["Grids"], L["Horizontal"], L["Vertical"], DISABLE}, updateMarkerGrid, L["ShowMarkerBarTip"]},
		{4, "Misc", "AutoRoll", IsNew..L["Auto Roll"], true, true, {format("|A:%s:%s|a", "lootroll-toast-icon-need-up", "16:16").." "..NEED, format("|A:%s:%s|a", "lootroll-toast-icon-pass-up", "16:16").." "..PASS, DISABLE}},
		{2, "Misc", "DBMCount", L["DBMCount"].."*", nil, nil, nil, nil, L["DBMCountTip"]},
		{2, "ACCOUNT", "IgnoredRares", IsNew..L["IgnoredRares"].."*", true, nil, updateIgnoredRares, L["IgnoredRaresTip"]},
		{3, "Misc", "MarkerSize", L["MarkerSize"].."*", true, true, {12, 50, 1}, updateMarkerGrid},
		{1, "Misc", "QuestNotification", HeaderTag..L["QuestNotification"].."*", false, false, nil, nil, updateQuestNotification},
		{1, "Misc", "QuestProgress", L["QuestProgress"].."*", true},
		{1, "Misc", "OnlyCompleteRing", L["OnlyCompleteRing"].."*", true, true, nil, nil, L["OnlyCompleteRingTip"]},
		{1, "Misc", "InterruptAlert", HeaderTag..L["InterruptAlert"].."*", nil, nil, nil, updateInterruptAlert},
		{1, "Misc", "OwnInterrupt", L["OwnInterrupt"].."*", true},
		{1, "Misc", "DispellAlert", HeaderTag..L["DispellAlert"].."*", true, true, nil, updateInterruptAlert},
		{1, "Misc", "OwnDispell", L["OwnDispell"].."*"},
		{1, "Misc", "BrokenAlert", HeaderTag..L["BrokenAlert"].."*", true, nil, nil, updateInterruptAlert, L["BrokenAlertTip"]},
		{1, "Misc", "InstAlertOnly", L["InstAlertOnly"].."*", true, true, nil, updateInterruptAlert, L["InstAlertOnlyTip"]},
		{1, "Misc", "SpellItemAlert", L["SpellItemAlert"].."*", nil, nil, nil, updateSpellItemAlert, L["SpellItemAlertTip"]},
		{1, "Misc", "LeaderOnly", IsNew..L["LeaderOnly"].."*", true, nil, nil, nil, L["LeaderOnlyTip"]},
		--{1, "Misc", "HideQuests", L["HideQuests"].."*", true, true},
		{},--blank
		--{1, "Misc", "NzothVision", L["NzothVision"]},
		--{1, "Misc", "InterruptSound", L["Interrupt Alarm"]},
		{1, "Misc", "AutoMark", L["Auto Mark"]},
		{1, "Misc", "SoloInfo", L["SoloInfo"].."*", true, nil, nil, nil, updateSoloInfo},
		{1, "Misc", "RareAlerter", HeaderTag..L["Rare Alert"].."*", nil, nil, nil, nil, updateRareAlert},
		{1, "Misc", "RarePrint", L["Alert In Chat"].."*", true},
		{1, "Misc", "RareAlertInWild", L["RareAlertInWild"].."*", true, true},
		--{1, "Misc", "kAutoOpen", L["kAutoOpen"], true},
		--{1, "Misc", "AutoConfirmRoll", L["AutoConfirmRoll"], true, true},
		{1, "Misc", "QuickQueue", L["QuickQueue"]},
		--{1, "Misc", "AutoReagentInBank", L["Auto Reagent Bank"], true},
		{1, "Misc", "HunterPetHelp", L["HunterPetHelp"], true},
		{1, "UFs", "AutoRes", HeaderTag..L["UFs AutoRes"], true, true},
		{1, "Misc", "CtrlIndicator", L["Shiftfreeze"]},
		--{1, "Misc", "BlinkRogueHelper", L["BlinkRogueHelper"], true},
		{1, "Misc", "WallpaperKit", L["WallpaperKit"], true},
		{1, "Misc", "CrazyCatLady", L["Death Alarm"], true, true},
		--{1, "UFs", "UFFade", L["UFFade"]},
		--{1, "UFs", "UFPctText", L["UFPctText"], true},
	},
	[6] = {
		{1, "Chat", "Lock", HeaderTag..L["Lock Chat"]},
		{1, "Chat", "Outline", L["Font Outline"], true},
		{1, "Chat", "Sticky", L["Chat Sticky"].."*", true, true, nil, updateChatSticky},
		{3, "Chat", "ChatWidth", L["LockChatWidth"].."*", nil, nil, {200, 600, 1}, updateChatSize},
		{3, "Chat", "ChatHeight", L["LockChatHeight"].."*", true, nil, {100, 500, 1}, updateChatSize},
		{3, "Chat", "Matches", L["Keyword Match"].."*", true, true, {1, 3, 1}},
		{},--blank
		{4, "ACCOUNT", "TimestampFormat", L["TimestampFormat"].."*", nil, nil, {DISABLE, "03:27 PM", "03:27:32 PM", "15:27", "15:27:32"}},
		{4, "Chat", "ChatBGType", L["ChatBGType"].."*", true, nil, {DISABLE, L["Default Dark"], L["Gradient"]}, toggleChatBackground},
		--{1, "Chat", "Oldname", L["Default Channel"]},
		{3, "Chat", "EditFont", L["EditFont"].."*", true, true, {10, 30, 1}, toggleEditBoxAnchor},
		{1, "Chat", "Chatbar", L["ShowChatbar"]},
		{1, "Chat", "WhisperColor", L["Differ WhisperColor"].."*", true},
		{1, "Chat", "ChatItemLevel", L["ShowChatItemLevel"], true, true},
		{1, "Chat", "WhisperSound", L["WhisperSound"].."*", nil, nil, nil, nil, L["WhisperSoundTip"]},
		{1, "Chat", "BottomBox", L["BottomBox"].."*", true, nil, nil, toggleEditBoxAnchor},
		{1, "Chat", "SysFont", L["SysFont"], true, true, nil, nil, L["SysFontTip"]},
		{1, "Chat", "EnableFilter", HeaderTag..L["Enable Chatfilter"]},
		{1, "Chat", "BlockAddonAlert", L["Block Addon Alert"], true},
		{1, "Chat", "BlockSpammer", L["BlockSpammer"].."*", true, true, nil, nil, L["BlockSpammerTip"]},
		{1, "Chat", "BlockStranger", "|cffff0000"..L["BlockStranger"].."*", nil, nil, nil, nil, L["BlockStrangerTip"]},
		{1, "Chat", "Invite", HeaderTag..L["Whisper Invite"], true},
		{1, "Chat", "GuildInvite", L["Guild Invite Only"].."*", true, true},
		{2, "ACCOUNT", "ChatFilterWhiteList", HeaderTag..L["ChatFilterWhiteList"].."*", nil, nil, nil, updateFilterWhiteList, L["ChatFilterWhiteListTip"]},
		{2, "ACCOUNT", "ChatFilterList", L["Filter List"].."*", true, nil, nil, updateFilterList, L["FilterListTip"]},
		{2, "Chat", "Keyword", L["Whisper Keyword"].."*", true, true, nil, updateWhisperList, L["WhisperKeywordTip"]},
	},
	[7] = {
		{1, "Map", "DisableMap", "|cffff0000"..L["DisableMap"], nil, nil, nil, nil, L["DisableMapTip"]},
		--{1, "Map", "MapRevealGlow", L["MapRevealGlow"].."*", true, nil, nil, nil, L["MapRevealGlowTip"]},
		{1, "Map", "DisableMinimap", "|cffff0000"..L["DisableMinimap"], true, nil, nil, nil, L["DisableMinimapTip"]},
		{3, "Map", "MinimapScale", L["Minimap Scale"].."*", nil, nil, {.5, 3, .1}, updateMinimapScale},
		{3, "Map", "MinimapSize", L["Minimap Size"].."*", true, nil, {100, 500, 1}, updateMinimapScale},
		{3, "Skins", "FontScale", L["GlobalFontScale"], true, true, {.5, 1.5, .05}},
		--{2, "ACCOUNT", "IgnoredButtons", L["IgnoredButtons"], true, true, nil, L["IgnoredButtonsTip"]},
		--{1, "Map", "Calendar", L["MinimapCalendar"].."*", true, true, nil, showCalendar, L["MinimapCalendarTip"]},
		{1, "Map", "Clock", L["Minimap Clock"].."*", nil, nil, nil, showMinimapClock},
		{1, "Map", "CombatPulse", L["Minimap Pulse"], true},
		{1, "Map", "WhoPings", L["Show WhoPings"], true, true},
		{1, "Map", "EasyVolume", L["EasyVolume"], nil, nil, nil, L["EasyVolumeTip"]},
		{1, "Misc", "ExpRep", L["Show Expbar"], true},
		--{1, "Misc", "WorldQusetRewardIcons", L["WorldQusetRewardIcons"], true},
		{1, "Map", "MapShrinker", "大地图精简皮肤", true, true},
		--{3, "Misc", "WorldQusetRewardIconsSize", "WorldQusetRewardIconsSize", true, false, {21, 66, 1}},	
		{3, "Map", "MapScale", L["Map Scale"].."*", nil, nil, {.8, 2, .1}},
		{3, "Map", "MaxMapScale", L["Maximize Map Scale"].."*", true, nil, {.5, 1, .1}},
		{3, "Map", "MinimapScale", L["Minimap Scale"].."*", nil, nil, {1, 2, .1}, updateMinimapScale},
		{3, "Map", "zrMMbuttonsize", "小地图收纳图标大小".."*", true, nil, {10, 40, 1}, nil, updateMinimapScale},
		{4, "Map", "zrMMbuttonpos", "小地图图标收纳位置".."*", true, true, {L["TOP"], L["BOTTOM"], L["LEFT"], L["RIGHT"]}, updateMinimapScale, "更改后RL生效"},
		{},--blank
		--{1, "Skins", "BlizzardSkins", HeaderTag..L["BlizzardSkins"], nil, nil, nil, nil, L["BlizzardSkinsTips"]},
		--{1, "Skins", "AlertFrames", L["ReskinAlertFrames"]},
		{1, "Skins", "QuestTracker", L["QuestTracker"]},
		--{1, "Skins", "Loot", L["Loot"], true},
		{1, "Skins", "PetBattle", L["PetBattle Skin"], true},
		--{1, "Map", "ShowRecycleBin", L["Show RecycleBin"], true, true},
		--{1, "Skins", "FlatMode", L["FlatMode"], true, true},
		--{1, "Skins", "Shadow", L["Shadow"]},
		--{1, "Skins", "FontOutline", L["FontOutline"], true},
		--{1, "Skins", "BgTex", L["BgTex"]},
		--{1, "Skins", "GreyBD", L["GreyBackdrop"], true, nil, nil, nil, L["GreyBackdropTip"]},
		--{3, "Skins", "SkinAlpha", L["SkinAlpha"].."*", nil, nil, {0, 1, .05}, updateSkinAlpha},
		--{1, "Skins", "ClassLine", L["ClassColor Line"]},
		--{1, "Skins", "InfobarLine", L["Infobar Line"], true},
		--{1, "Skins", "ChatbarLine", L["Chat Line"]},
		--{1, "Skins", "MenuLine", L["Menu Line"], true},
		--{1, "Skins", "Skada", L["Skada Skin"]},
		{},--blank
		{1, "Skins", "DBM", L["DBM Skin"]},
		{1, "Skins", "Details", L["Details Skin"], true, nil, resetDetails},
		{4, "Skins", "ToggleDirection", L["ToggleDirection"].."*", true, true, {L["LEFT"], L["RIGHT"], L["TOP"], L["BOTTOM"], DISABLE}, updateToggleDirection},
		{},--blank
		{1, "Skins", "Bigwigs", L["Bigwigs Skin"]},
		{1, "Skins", "TMW", L["TMW Skin"], true},
		{1, "Skins", "WeakAuras", L["WeakAuras Skin"], true, true},
		{1, "Skins", "Rematch", L["Rematch Skin"]},
		{1, "Skins", "PGFSkin", L["PGF Skin"], true},
	},
	[8] = {
		--{3, "Tooltip", "Scale", L["Tooltip Scale"].."*", nil, nil, {.5, 1.5, .1}},
		{4, "Tooltip", "TipAnchor", L["TipAnchor"].."*", nil, nil, {L["TOPLEFT"], L["TOPRIGHT"], L["BOTTOMLEFT"], L["BOTTOMRIGHT"]}, nil, L["TipAnchorTip"]},
		{4, "Tooltip", "HideInCombat", IsNew..L["HideInCombat"].."*", true, true, {DISABLE, "ALT", "SHIFT", "CTRL", ALWAYS}, nil, L["HideInCombatTip"]},
		{4, "Tooltip", "CursorMode", L["Follow Cursor"].."*", true, nil, {DISABLE, L["LEFT"], L["TOP"], L["RIGHT"]}},
		{1, "Tooltip", "HideTitle", L["Hide Title"].."*"},
		{1, "Tooltip", "HideRank", L["Hide Rank"].."*", true},
		{1, "Tooltip", "FactionIcon", L["FactionIcon"].."*", true, true},
		{1, "Tooltip", "HideJunkGuild", L["HideJunkGuild"].."*"},
		{1, "Tooltip", "HideRealm", L["Hide Realm"].."*", true},
		{1, "Tooltip", "SpecLevelByShift", L["Show SpecLevelByShift"].."*", true, true},
		{1, "Tooltip", "LFDRole", L["Group Roles"].."*"},
		{1, "Tooltip", "TargetBy", L["Show TargetedBy"].."*", true},
		{1, "Tooltip", "MythicScore", L["MDScore"].."*", true, true, nil, nil, L["MDScoreTip"]},
		{1, "Tooltip", "ItemQuality", L["ShowItemQuality"].."*"},
		{1, "Tooltip", "HideAllID", "|cffff0000"..L["HideAllID"], true},
		{1, "Tooltip", "AzeriteArmor", HeaderTag..L["Show AzeriteArmor"], true, true},
		{1, "Tooltip", "OnlyArmorIcons", L["Armor icons only"].."*"},
		{1, "Tooltip", "CursorHappy", "鼠标闪光(方便定位)".."*", true},
		{1, "ACCOUNT", "MilitaryTime", IsNew..TIMEMANAGER_24HOURMODE, true, true, nil, updateTimeMode},
		{1, "Misc", "ItemLevel", HeaderTag..L["Show ItemLevel"], nil, nil, nil, nil, L["ItemLevelTip"]},
		{1, "Misc", "MissingStats", HeaderTag..L["Show MissingStats"], true},
		{1, "Misc", "GemNEnchant", L["Show GemNEnchant"].."*", true, true},
		{1, "Misc", "AzeriteTraits", L["Show AzeriteTraits"].."*"},
		{1, "Misc", "HideTalking", L["No Talking"], true},
		{1, "ACCOUNT", "AutoBubbles", L["AutoBubbles"], true, true},
		{1, "Misc", "HideBossEmote", L["HideBossEmote"].."*", nil, nil, nil, toggleBossEmote},
		{1, "Misc", "HideBossBanner", L["Hide Bossbanner"].."*", true, nil, nil, toggleBossBanner},
		--{1, "Misc", "InstantDelete", L["InstantDelete"].."*", true, true},
		{1, "Misc", "FasterLoot", L["Faster Loot"].."*", true, true, nil, updateFasterLoot},
		{1, "Misc", "FasterSkip", L["FasterMovieSkip"], nil, nil, nil, nil, L["FasterMovieSkipTip"]},
		{1, "Misc", "BlockInvite", "|cffff0000"..L["BlockInvite"].."*", true, nil, nil, nil, L["BlockInviteTip"]},
		{1, "Misc", "BlockRequest", "|cffff0000"..L["BlockRequest"].."*", true, true, nil, nil, L["BlockRequestTip"]},
		{1, "Misc", "ParagonRep", L["ParagonRep"]},
		{1, "Misc", "Mail", L["Mail Tool"], true},
		{1, "Misc", "TradeTabs", L["TradeTabs"], true, true},
		{1, "Misc", "PetFilter", L["Show PetFilter"]},
		{1, "Misc", "Screenshot", L["Auto ScreenShot"].."*", true, nil, nil, updateScreenShot},
		{1, "Misc", "Focuser", L["Easy Focus"], true, true},
		{1, "Misc", "MDGuildBest", L["MDGuildBest"], nil, nil, nil, nil, L["MDGuildBestTip"]},
		{1, "Misc", "MenuButton", L["MenuButton"], true, nil, nil, nil, L["MenuButtonTip"]},
		{1, "Misc", "EnhanceDressup", L["EnhanceDressup"], true, true, nil, nil, L["EnhanceDressupTip"]},
		--{1, "Misc", "QuestTool", L["QuestTool"], nil, nil, nil, nil, L["QuestToolTip"]},
		{1, "Misc", "QuickJoin", HeaderTag..L["EnhancedPremade"], nil, nil, nil, nil, L["EnhancedPremadeTip"]},
		{1, "Misc", "SingingSocket", IsNew..L["SingingSocket"], true, nil, nil, L["SingingSocketTip"]},
		--{1, "ACCOUNT", "VersionCheck", L["Version Check"]},
		{1, "ACCOUNT", "LockUIScale", L["Lock UIScale"], true, true},
		--{1, "ACCOUNT", "DisableInfobars", "|cffff0000"..L["DisableInfobars"], true},
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
	tab:SetPoint("TOP", -320 + 80*(i-1) + C.mult, -121)
	tab:SetSize(80, 30)
	B.CreateBD(tab, .3)
	B.CreateFS(tab, 15, name, "system", "CENTER", 0, 0)
	tab.index = i

	tab:SetScript("OnClick", tabOnClick)
	tab:SetScript("OnEnter", tabOnEnter)
	tab:SetScript("OnLeave", tabOnLeave)

	return tab
end

local function CheckUIOption(key, value, newValue)
	if key == "ACCOUNT" then
		if newValue ~= nil then
			OrzUISetDB[value] = newValue
		else
			return OrzUISetDB[value]
		end
	else
		if newValue ~= nil then
			C.db[key][value] = newValue
		else
			return C.db[key][value]
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
	local current = B:Round(tonumber(v), 2)
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
			local cb = B.CreateCheckBox(parent)
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
			cb.name = B.CreateFS(cb, 14, name, false, "LEFT", 30, 0)
			if isNew then AddNewTag(cb, cb.name) end
			cb:SetChecked(CheckUIOption(key, value))
			cb:SetScript("OnClick", onCheckboxClick)
			if data and type(data) == "function" then
				local bu = B.CreateGear(parent)
				bu:SetPoint("LEFT", cb.name, "RIGHT", -2, 1)
				bu:SetScript("OnClick", data)
			end
			if tooltip then
				B.AddTooltip(cb, "ANCHOR_RIGHT", tooltip, "info", true)
			end
			if disabled then cb:Hide() end
		-- Editbox
		elseif optType == 2 then
			local eb = B.CreateEditBox(parent, 210, 23)
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

			local fs = B.CreateFS(eb, 14, name, "system", "CENTER", 0, 18)
			if isNew then AddNewTag(eb, fs) end
			local tip = L["EditBox Tip"]
			if tooltip then tip = tooltip.."|n"..tip end
			B.AddTooltip(eb, "ANCHOR_RIGHT", tip, "info", true)
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
			local s = B.CreateSlider(parent, name, min, max, step, x, y)
			if isNew then AddNewTag(s, s.Text) end
			s.__key = key
			s.__value = value
			s.__name = name
			s.__callback = callback
			s.__default = (key == "ACCOUNT" and G.AccountSettings[value]) or G.DefaultSettings[key][value]
			s:SetValue(CheckUIOption(key, value))
			s:SetScript("OnValueChanged", onSliderChanged)
			s.value:SetText(B:Round(CheckUIOption(key, value), 2))
			if tooltip then
				B.AddTooltip(s, "ANCHOR_RIGHT", tooltip, "info", true)
			end
		-- Dropdown
		elseif optType == 4 then
			if value == "TexStyle" then
				for _, v in ipairs(G.TextureList) do
					tinsert(data, v.name)
				end
			end

			local dd = B.CreateDropDown(parent, 180, 21, data)
			if horizon2 then
				dd:SetPoint("TOPLEFT", 560, -offset + 28)
			elseif horizon then
				dd:SetPoint("TOPLEFT", 310, -offset + 32)
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

			local fs = B.CreateFS(dd, 14, name, "system", "CENTER", 0, 18)
			if isNew then AddNewTag(dd, fs) end
			if tooltip then
				B.AddTooltip(dd, "ANCHOR_RIGHT", tooltip, "info", true)
			end
		-- Colorswatch
		elseif optType == 5 then
			local swatch = B.CreateColorSwatch(parent, name, CheckUIOption(key, value))
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
				local line = B.SetGradient(parent, "H", 1, 1, 1, .25, .25, 770, C.mult)
				line:SetPoint("TOPLEFT", 26, -offset - 8)
			end
			offset = offset + 16
		end
	end
end


StaticPopupDialogs["RELOAD_ORZUI"] = {
	text = L["ReloadUI Required"],
	button1 = APPLY,
	button2 = CLASS_TRIAL_THANKS_DIALOG_CLOSE_BUTTON,
	OnAccept = function()
		ReloadUI()
	end,
}

local function OpenGUI()
	if f then f:Show() return end

	-- Main Frame
	f = CreateFrame("Frame", "OrzUIGUI", UIParent)
	tinsert(UISpecialFrames, "OrzUIGUI")
	local bgTexture = f:CreateTexture("name", "BACKGROUND")
	bgTexture:SetTexture("Interface\\Destiny\\UI-Destiny");  --FontStyles\\FontStyleGarrisons
	bgTexture:SetTexCoord(0,1,0,600/1024);
	bgTexture:SetAllPoints();
	bgTexture:SetAlpha(1)
	f:SetSize(1440, 720)
	f:SetPoint("CENTER")
	f:SetFrameStrata("HIGH")
	f:SetFrameLevel(10)
	B.CreateMF(f)
	B.CreateFS(f, 43, "2 UI", true, "TOP", 0, -62)
	B.CreateFS(f, 21, "v"..DB.Version, false, "TOP", 80, -80)

	--[[local close = B.CreateButton(f, 72, 21, "关闭")
	close:SetPoint("BOTTOM", -310, 68)
	close:SetScript("OnClick", function() f:Hide() end)]]
	
	local MrHelp = B.CreateButton(f, 72, 21, "帮助")
	MrHelp:SetPoint("BOTTOM", -310, 68)
	MrHelp:SetScript("OnClick", function() SenduiCmd("/MrHelp") f:Hide() end)

	local ok = B.CreateButton(f, 72, 21, "确定")
	ok:SetPoint("BOTTOM", 320, 68)
	ok:SetScript("OnClick", function()
		B:SetupUIScale()
		f:Hide()
		if G.needUIReload then
			StaticPopup_Show("RELOAD_ORZUI")
			G.needUIReload = nil
		end
	end)
	
	local KeyBind = B.CreateButton(f, 90, 21, MINIMAP_MENU_KEYBIND)
	KeyBind:SetPoint("BOTTOM", -300, 100)
	KeyBind:SetScript("OnClick", function() SenduiCmd("/Keybind") f:Hide() end)
	
	local MoveFrames = B.CreateButton(f, 90, 21, MINIMAP_MENU_SPECIALBUTTON)
	MoveFrames:SetPoint("BOTTOM", -200, 100)
	MoveFrames:SetScript("OnClick", function() SenduiCmd("/moveit") f:Hide() end)

	local UpdateLog = B.CreateButton(f, 90, 21, MINIMAP_MENU_UPDATELOG)
	UpdateLog:SetPoint("BOTTOM", -100, 100)
	UpdateLog:SetScript("OnClick", function() SenduiCmd("/MrHelp") f:Hide() end)

	local AFKScreen = B.CreateButton(f, 90, 21, MINIMAP_MENU_AFKSCREEN)
	AFKScreen:SetPoint("BOTTOM", 0, 100)
	AFKScreen:SetScript("OnClick", function() SenduiCmd("/wallpaperkit") f:Hide() end)

	local Simc = B.CreateButton(f, 90, 21, "Simc")
	Simc:SetPoint("BOTTOM", 100, 100)
	Simc:SetScript("OnClick", function() SenduiCmd("/simc") f:Hide() end)

	local Love = B.CreateButton(f, 90, 21, "Love")
	Love:SetPoint("BOTTOM", 200, 100)
	Love:SetScript("OnClick", function() SenduiCmd("/welovewow") f:Hide() end)
	
	local MoreSet = B.CreateButton(f, 90, 21, MINIMAP_MENU_MORE)
	MoreSet:SetPoint("BOTTOM", 300, 100)
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

	local helpInfo = B.CreateHelpInfo(f, L["Option* Tips"])
	helpInfo:SetPoint("TOP", 280, -88)
	local guiHelpInfo = {
		text = L["GUIPanelHelp"],
		buttonStyle = HelpTip.ButtonStyle.GotIt,
		targetPoint = HelpTip.Point.LeftEdgeCenter,
		onAcknowledgeCallback = B.HelpInfoAcknowledge,
		callbackArg = "GUIPanel",
	}
	if not OrzUISetDB["Help"]["GUIPanel"] then
		HelpTip:Show(helpInfo, guiHelpInfo)
	end

	local credit = CreateFrame("Button", nil, f)
	credit:SetPoint("BOTTOM", 0, 66)
	credit:SetSize(360, 21)
	B.CreateFS(credit, 18, "This GUI learn form Siweia·s NDui，Sincere Gratitude!", true)
	

	local function showLater(event)
		if event == "PLAYER_REGEN_DISABLED" then
			if f:IsShown() then
				f:Hide()
				B:RegisterEvent("PLAYER_REGEN_ENABLED", showLater)
			end
		else
			f:Show()
			B:UnregisterEvent(event, showLater)
		end
	end
	B:RegisterEvent("PLAYER_REGEN_DISABLED", showLater)

	SelectTab(1)
end

function G:OnLogin()
	local function toggleGUI()
		if InCombatLockdown() then UIErrorsFrame:AddMessage(DB.InfoColor..ERR_NOT_IN_COMBAT) return end
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
SLASH_MAORUIGUI1 = '/orzui'
