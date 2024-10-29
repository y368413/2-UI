local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:RegisterModule("Misc")

local _G = getfenv(0)
local select, unpack, tonumber, gsub = select, unpack, tonumber, gsub
local InCombatLockdown, IsModifiedClick, IsAltKeyDown = InCombatLockdown, IsModifiedClick, IsAltKeyDown
local GetNumArchaeologyRaces = GetNumArchaeologyRaces
local GetNumArtifactsByRace = GetNumArtifactsByRace
local GetArtifactInfoByRace = GetArtifactInfoByRace
local GetArchaeologyRaceInfo = GetArchaeologyRaceInfo
local EquipmentManager_UnequipItemInSlot = EquipmentManager_UnequipItemInSlot
local EquipmentManager_RunAction = EquipmentManager_RunAction
local GetInventoryItemTexture = GetInventoryItemTexture
local BuyMerchantItem = BuyMerchantItem
local GetMerchantItemLink = GetMerchantItemLink
local GetMerchantItemMaxStack = GetMerchantItemMaxStack
local Screenshot = Screenshot
local GetTime, GetCVarBool, SetCVar = GetTime, GetCVarBool, SetCVar
local GetNumLootItems, LootSlot = GetNumLootItems, LootSlot
local GetNumSavedInstances = GetNumSavedInstances
local GetInstanceInfo = GetInstanceInfo
local GetSavedInstanceInfo = GetSavedInstanceInfo
local SetSavedInstanceExtend = SetSavedInstanceExtend
local RequestRaidInfo, RaidInfoFrame_Update = RequestRaidInfo, RaidInfoFrame_Update
local IsGuildMember, C_BattleNet_GetGameAccountInfoByGUID, C_FriendList_IsFriend = IsGuildMember, C_BattleNet.GetGameAccountInfoByGUID, C_FriendList.IsFriend
local C_Map_GetMapInfo, C_Map_GetBestMapForUnit = C_Map.GetMapInfo, C_Map.GetBestMapForUnit

--[[
	Miscellaneous 各种有用没用的小玩意儿
]]
local MISC_LIST = {}

function MISC:RegisterMisc(name, func)
	if not MISC_LIST[name] then
		MISC_LIST[name] = func
	end
end

function MISC:OnLogin()
	for name, func in next, MISC_LIST do
		if name and type(func) == "function" then
			func()
		end
	end

	-- Init
	MISC:NakedIcon()
	MISC:ExtendInstance()
	MISC:VehicleSeatMover()
	MISC:UIWidgetFrameMover()
	MISC:MoveDurabilityFrame()
	MISC:MoveTicketStatusFrame()
	MISC:UpdateScreenShot()
	MISC:UpdateFasterLoot()
	MISC:TradeTargetInfo()
	MISC:BlockStrangerInvite()
	MISC:ToggleBossBanner()
	MISC:ToggleBossEmote()
	MISC:FasterMovieSkip()
	MISC:EnhanceDressup()
	MISC:FuckTrainSound()
	MISC:JerryWay()
	MISC:QuickMenuButton()
	MISC:BaudErrorFrameHelpTip()
	MISC:EnhancedPicker()
	MISC:UpdateMaxZoomLevel()
	MISC:MoveBlizzFrames()
	MISC:HandleUITitle()

	--MISC:CreateRM()
	--MISC:FreeMountCD()
	--MISC:xMerchant()
	--MISC:BlinkRogueHelper()
	
	----------------QuickQueue.lua----------------------
	if R.db["Misc"]["QuickQueue"] then
	  local QuickQueue = CreateFrame("Frame")
	    QuickQueue:RegisterEvent("LFG_ROLE_CHECK_SHOW")
	    QuickQueue:SetScript("OnEvent", function(self, event, ...) CompleteLFGRoleCheck(true) end)
	end

	-- Unregister talent event
	if PlayerTalentFrame then
		PlayerTalentFrame:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	else
		hooksecurefunc("TalentFrame_LoadUI", function()
			PlayerTalentFrame:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
		end)
	end

	-- Always show altpower value
	hooksecurefunc("UnitPowerBarAlt_SetUp", function(self)
		local statusFrame = self.statusFrame
		if statusFrame.enabled then
			statusFrame:Show()
			statusFrame.Hide = statusFrame.Show
		end
	end)

	-- Auto chatBubbles
	if MaoRUISetDB["AutoBubbles"] then
		local function updateBubble()
			local name, instType = GetInstanceInfo()
			if name and instType == "raid" then
				SetCVar("chatBubbles", 1)
			else
				SetCVar("chatBubbles", 0)
			end
		end
		M:RegisterEvent("PLAYER_ENTERING_WORLD", updateBubble)
	end

	-- Readycheck sound on master channel
	M:RegisterEvent("READY_CHECK", function()
		PlaySound(SOUNDKIT.READY_CHECK, "master")
	end)

	-- Instant delete
	local deleteDialog = StaticPopupDialogs["DELETE_GOOD_ITEM"]
	if deleteDialog.OnShow then
		hooksecurefunc(deleteDialog, "OnShow", function(self)
			if R.db["Misc"]["InstantDelete"] then
				self.editBox:SetText(DELETE_ITEM_CONFIRM_STRING)
			end
		end)
	end
end

-- Hide boss banner
function MISC:ToggleBossBanner()
	if R.db["Misc"]["HideBossBanner"] then
		BossBanner:UnregisterAllEvents()
	else
		BossBanner:RegisterEvent("BOSS_KILL")
		BossBanner:RegisterEvent("ENCOUNTER_LOOT_RECEIVED")
	end
end

-- Hide boss emote
function MISC:ToggleBossEmote()
	if R.db["Misc"]["HideBossEmote"] then
		RaidBossEmoteFrame:UnregisterAllEvents()
	else
		RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_EMOTE")
		RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_WHISPER")
		RaidBossEmoteFrame:RegisterEvent("CLEAR_BOSS_EMOTES")
	end
end

-- Get Naked
function MISC:NakedIcon()
	local bu = CreateFrame("Button", nil, CharacterFrameInsetRight)
	bu:SetSize(21, 21)
	bu:SetPoint("LEFT", PaperDollSidebarTab1, "RIGHT", 80, -2)
	M.PixelIcon(bu, "Interface\\ICONS\\SPELL_SHADOW_TWISTEDFAITH", true)
	bu.bg:SetPoint("TOPLEFT", 2, -3)
	bu.bg:SetPoint("BOTTOMRIGHT", 0, -2)
	M.AddTooltip(bu, "ANCHOR_RIGHT", U["Get Naked"])

	local function UnequipItemInSlot(i)
		local action = EquipmentManager_UnequipItemInSlot(i)
		EquipmentManager_RunAction(action)
	end

	bu:SetScript("OnDoubleClick", function()
		for i = 1, 17 do
			local texture = GetInventoryItemTexture("player", i)
			if texture then
				UnequipItemInSlot(i)
			end
		end
	end)
end

-- Extend Instance
function MISC:ExtendInstance()
	local bu = CreateFrame("Button", nil, RaidInfoFrame)
	bu:SetPoint("TOPRIGHT", -35, -5)
	bu:SetSize(25, 25)
	M.PixelIcon(bu, C_Spell.GetSpellTexture(80353), true)
	bu.title = U["Extend Instance"]
	local tipStr = format(U["Extend Instance Tip"], I.LeftButton, I.RightButton)
	M.AddTooltip(bu, "ANCHOR_RIGHT", tipStr, "system")

	bu:SetScript("OnMouseUp", function(_, btn)
		for i = 1, GetNumSavedInstances() do
			local _, _, _, _, _, extended, _, isRaid = GetSavedInstanceInfo(i)
			if isRaid then
				if btn == "LeftButton" then
					if not extended then
						SetSavedInstanceExtend(i, true)		-- extend
					end
				else
					if extended then
						SetSavedInstanceExtend(i, false)	-- cancel
					end
				end
			end
		end
		RequestRaidInfo()
		RaidInfoFrame_Update()
	end)
end

-- Reanchor Vehicle
function MISC:VehicleSeatMover()
	local frame = CreateFrame("Frame", "UIVehicleSeatMover", UIParent)
	frame:SetSize(125, 125)
	M.Mover(frame, U["VehicleSeat"], "VehicleSeat", {"BOTTOMRIGHT", UIParent, -285, 21})

	hooksecurefunc(VehicleSeatIndicator, "SetPoint", function(self, _, parent)
		if parent ~= frame then
			self:ClearAllPoints()
			self:SetPoint("TOPLEFT", frame)
		end
	end)
end

-- Reanchor UIWidgets
function MISC:UIWidgetFrameMover()
	local frame1 = CreateFrame("Frame", "UIWidgetMover", UIParent)
	frame1:SetSize(210, 60)
	M.Mover(frame1, U["UIWidgetFrame"], "UIWidgetFrame", {"TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, -43})

	hooksecurefunc(UIWidgetBelowMinimapContainerFrame, "SetPoint", function(self, _, parent)
		if parent ~= frame1 then
			self:ClearAllPoints()
			self:SetPoint("TOPRIGHT", frame1)
		end
	end)

	local frame2 = CreateFrame("Frame", "UIWidgetPowerBarMover", UIParent)
	frame2:SetSize(260, 40)
	M.Mover(frame2, U["UIWidgetPowerBar"], "UIWidgetPowerBar", {"BOTTOM", UIParent, "BOTTOM", 0, 150})

	hooksecurefunc(UIWidgetPowerBarContainerFrame, "SetPoint", function(self, _, parent)
		if parent ~= frame2 then
			self:ClearAllPoints()
			self:SetPoint("CENTER", frame2)
		end
	end)
end

-- Reanchor DurabilityFrame
function MISC:MoveDurabilityFrame()
	hooksecurefunc(DurabilityFrame, "SetPoint", function(self, _, parent)
		if parent == "MinimapCluster" or parent == MinimapCluster then
			self:ClearAllPoints()
			self:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, -30)
		end
	end)
end

-- Reanchor TicketStatusFrame
function MISC:MoveTicketStatusFrame()
	hooksecurefunc(TicketStatusFrame, "SetPoint", function(self, relF)
		if relF == "TOPRIGHT" then
			self:ClearAllPoints()
			self:SetPoint("TOP", UIParent, "TOP", -400, -20)
		end
	end)
end

-- Achievement screenshot
function MISC:ScreenShotOnEvent(_, alreadyEarnedOnAccount)
	if alreadyEarnedOnAccount then return end
	MISC.ScreenShotFrame.delay = 1
	MISC.ScreenShotFrame:Show()
end

function MISC:UpdateScreenShot()
	if not MISC.ScreenShotFrame then
		MISC.ScreenShotFrame = CreateFrame("Frame")
		MISC.ScreenShotFrame:Hide()
		MISC.ScreenShotFrame:SetScript("OnUpdate", function(self, elapsed)
			self.delay = self.delay - elapsed
			if self.delay < 0 then
				Screenshot()
				self:Hide()
			end
		end)
	end

	if R.db["Misc"]["Screenshot"] then
		M:RegisterEvent("ACHIEVEMENT_EARNED", MISC.ScreenShotOnEvent)
	else
		MISC.ScreenShotFrame:Hide()
		M:UnregisterEvent("ACHIEVEMENT_EARNED", MISC.ScreenShotOnEvent)
	end
end

-- Faster Looting
local lootDelay = 0
function MISC:DoFasterLoot()
	local thisTime = GetTime()
	if thisTime - lootDelay >= .3 then
		lootDelay = thisTime
		if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
			for i = GetNumLootItems(), 1, -1 do
				LootSlot(i)
			end
			lootDelay = thisTime
		end
	end
end

function MISC:UpdateFasterLoot()
	if R.db["Misc"]["FasterLoot"] then
		M:RegisterEvent("LOOT_READY", MISC.DoFasterLoot)
	else
		M:UnregisterEvent("LOOT_READY", MISC.DoFasterLoot)
	end
end

-- TradeFrame hook
function MISC:TradeTargetInfo()
	local infoText = M.CreateFS(TradeFrame, 16, "")
	infoText:ClearAllPoints()
	infoText:SetPoint("TOP", TradeFrameRecipientNameText, "BOTTOM", 0, -5)

	local function updateColor()
		local r, g, b = M.UnitColor("NPC")
		TradeFrameRecipientNameText:SetTextColor(r, g, b)

		local guid = UnitGUID("NPC")
		if not guid then return end
		local text = "|cffff0000"..U["Stranger"]
		if C_BattleNet_GetGameAccountInfoByGUID(guid) or C_FriendList_IsFriend(guid) then
			text = "|cffffff00"..FRIEND
		elseif IsGuildMember(guid) then
			text = "|cff00ff00"..GUILD
		end
		infoText:SetText(text)
	end
	hooksecurefunc("TradeFrame_Update", updateColor)
end

-- Block invite from strangers
function MISC:BlockStrangerInvite()
	M:RegisterEvent("PARTY_INVITE_REQUEST", function(_, _, _, _, _, _, _, guid)
		if R.db["Misc"]["BlockInvite"] and not (C_BattleNet_GetGameAccountInfoByGUID(guid) or C_FriendList_IsFriend(guid) or IsGuildMember(guid)) then
			DeclineGroup()
			StaticPopup_Hide("PARTY_INVITE")
		end
	end)

	M:RegisterEvent("GROUP_INVITE_CONFIRMATION", function()
		if not R.db["Misc"]["BlockRequest"] then return end

		local guid = GetNextPendingInviteConfirmation()
		if not guid then return end

		if not (C_BattleNet_GetGameAccountInfoByGUID(guid) or C_FriendList_IsFriend(guid) or IsGuildMember(guid)) then
			RespondToInviteConfirmation(guid, false)
			StaticPopup_Hide("GROUP_INVITE_CONFIRMATION")
		end
	end)
end

-- Archaeology counts
do
	local function CalculateArches(self)
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
		GameTooltip:ClearLines()
		GameTooltip:AddLine("|c0000FF00"..U["Arch Count"]..":")
		GameTooltip:AddLine(" ")
		local total = 0
		for i = 1, GetNumArchaeologyRaces() do
			local numArtifacts = GetNumArtifactsByRace(i)
			local count = 0
			for j = 1, numArtifacts do
				local completionCount = select(10, GetArtifactInfoByRace(i, j))
				count = count + completionCount
			end
			local name = GetArchaeologyRaceInfo(i)
			if numArtifacts > 1 then
				GameTooltip:AddDoubleLine(name..":", I.InfoColor..count)
				total = total + count
			end
		end
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine("|c0000ff00"..TOTAL..":", "|cffff0000"..total)
		GameTooltip:Show()
	end

	local function AddCalculateIcon()
		local bu = CreateFrame("Button", nil, ArchaeologyFrameCompletedPage)
		bu:SetPoint("TOPRIGHT", -45, -45)
		bu:SetSize(35, 35)
		M.PixelIcon(bu, "Interface\\ICONS\\Ability_Iyyokuk_Calculate", true)
		bu:SetScript("OnEnter", CalculateArches)
		bu:SetScript("OnLeave", M.HideTooltip)
	end

	local function setupMisc(event, addon)
		if addon == "Blizzard_ArchaeologyUI" then
			AddCalculateIcon()
			-- Repoint Bar, todo: add mover for this, UIParentBottomManagedFrameContainer
		--	ArcheologyDigsiteProgressBar.ignoreFramePositionManager = true
		--	ArcheologyDigsiteProgressBar:SetPoint("BOTTOM", 0, 150)
		--	M.CreateMF(ArcheologyDigsiteProgressBar)

			M:UnregisterEvent(event, setupMisc)
		end
	end

	M:RegisterEvent("ADDON_LOADED", setupMisc)

	local newTitleString = ARCHAEOLOGY_DIGSITE_PROGRESS_BAR_TITLE.." %s/%s"
	local function updateArcTitle(_, ...)
		local numFindsCompleted, totalFinds = ...
		if ArcheologyDigsiteProgressBar then
			ArcheologyDigsiteProgressBar.BarTitle:SetFormattedText(newTitleString, numFindsCompleted, totalFinds)
		end
	end
	M:RegisterEvent("ARCHAEOLOGY_SURVEY_CAST", updateArcTitle)
	M:RegisterEvent("ARCHAEOLOGY_FIND_COMPLETE", updateArcTitle)
end

-- Drag AltPowerbar
do
	local mover = CreateFrame("Frame", "UIAltBarMover", PlayerPowerBarAlt)
	mover:SetPoint("CENTER", UIParent, 0, -200)
	mover:SetSize(20, 20)
	M.CreateMF(PlayerPowerBarAlt, mover)

	hooksecurefunc(PlayerPowerBarAlt, "SetPoint", function(_, _, parent)
		if parent ~= mover then
			PlayerPowerBarAlt:ClearAllPoints()
			PlayerPowerBarAlt:SetPoint("CENTER", mover)
		end
	end)

	hooksecurefunc("UnitPowerBarAlt_SetUp", function(self)
		local statusFrame = self.statusFrame
		if statusFrame.enabled then
			statusFrame:Show()
			statusFrame.Hide = statusFrame.Show
		end
	end)

	local altPowerInfo = {
		text = U["Drag AltBar Tip"],
		buttonStyle = HelpTip.ButtonStyle.GotIt,
		targetPoint = HelpTip.Point.RightEdgeCenter,
		onAcknowledgeCallback = M.HelpInfoAcknowledge,
		callbackArg = "AltPower",
	}
	PlayerPowerBarAlt:HookScript("OnEnter", function(self)
		if not MaoRUISetDB["Help"]["AltPower"] then
			HelpTip:Show(self, altPowerInfo)
		end
	end)
end

-- ALT+RightClick to buy a stack
do
	local cache = {}
	local itemLink, id

	StaticPopupDialogs["BUY_STACK"] = {
		text = CHARMS_BUY_STACK,
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			if not itemLink then return end
			BuyMerchantItem(id, GetMerchantItemMaxStack(id))
			cache[itemLink] = true
			itemLink = nil
		end,
		hideOnEscape = 1,
		hasItemFrame = 1,
	}

	local _MerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClick
	function MerchantItemButton_OnModifiedClick(self, ...)
		if IsAltKeyDown() then
			id = self:GetID()
			itemLink = GetMerchantItemLink(id)
			if not itemLink then return end
			local name, _, quality, _, _, _, _, maxStack, _, texture = C_Item.GetItemInfo(itemLink)
			if maxStack and maxStack > 1 then
				if not cache[itemLink] then
					local r, g, b = C_Item.GetItemQualityColor(quality or 1)
					StaticPopup_Show("BUY_STACK", " ", " ", {["texture"] = texture, ["name"] = name, ["color"] = {r, g, b, 1}, ["link"] = itemLink, ["index"] = id, ["count"] = maxStack})
				else
					BuyMerchantItem(id, GetMerchantItemMaxStack(id))
				end
			end
		end
		_MerchantItemButton_OnModifiedClick(self, ...)
	end
end

local function skipOnKeyDown(self, key)
	if not R.db["Misc"]["FasterSkip"] then return end
	if key == "ESCAPE" then
		if self:IsShown() and self.closeDialog and self.closeDialog.confirmButton then
			self.closeDialog:Hide()
		end
	end
end

local function skipOnKeyUp(self, key)
	if not R.db["Misc"]["FasterSkip"] then return end
	if key == "SPACE" or key == "ESCAPE" or key == "ENTER" then
		if self:IsShown() and self.closeDialog and self.closeDialog.confirmButton then
			self.closeDialog.confirmButton:Click()
		end
	end
end

function MISC:FasterMovieSkip()
	MovieFrame.closeDialog = MovieFrame.CloseDialog
	MovieFrame.closeDialog.confirmButton = MovieFrame.CloseDialog.ConfirmButton
	CinematicFrame.closeDialog.confirmButton = CinematicFrameCloseDialogConfirmButton

	MovieFrame:HookScript("OnKeyDown", skipOnKeyDown)
	MovieFrame:HookScript("OnKeyUp", skipOnKeyUp)
	CinematicFrame:HookScript("OnKeyDown", skipOnKeyDown)
	CinematicFrame:HookScript("OnKeyUp", skipOnKeyUp)
end

function MISC:EnhanceDressup()
	if not R.db["Misc"]["EnhanceDressup"] then return end

	local parent = _G.DressUpFrameResetButton
	local button = MISC:MailBox_CreatButton(parent, 80, 22, U["Undress"], {"RIGHT", parent, "LEFT", -1, 0})
	button:RegisterForClicks("AnyUp")
	button:SetScript("OnClick", function(_, btn)
		local actor = DressUpFrame.ModelScene:GetPlayerActor()
		if not actor then return end

		if btn == "LeftButton" then
			actor:Undress()
		else
			actor:UndressSlot(19)
		end
	end)

	M.AddTooltip(button, "ANCHOR_TOP", format(U["UndressButtonTip"], I.LeftButton, I.RightButton))

	DressUpFrame.LinkButton:SetWidth(80)
	DressUpFrame.LinkButton:SetText(SOCIAL_SHARE_TEXT)
end

function MISC:FuckTrainSound()
	local trainSounds = {
	--[[Blood Elf]]	"539219", "539203", "1313588", "1306531",
	--[[Draenei]]	"539516", "539730",
	--[[Dwarf]]		"539802", "539881",
	--[[Gnome]]		"540271", "540275",
	--[[Goblin]]	"541769", "542017",
	--[[Human]]		"540535", "540734",
	--[[Night Elf]]	"540870", "540947", "1316209", "1304872",
	--[[Orc]]		"541157", "541239",
	--[[Pandaren]]	"636621", "630296", "630298",
	--[[Tauren]]	"542818", "542896",
	--[[Troll]] 	"543085", "543093",
	--[[Undead]]	"542526", "542600",
	--[[Worgen]]	"542035", "542206", "541463", "541601",
	--[[Dark Iron]]	"1902030", "1902543",
	--[[Highmount]]	"1730534", "1730908",
	--[[Kul Tiran]]	"2531204", "2491898",
	--[[Lightforg]]	"1731282", "1731656",
	--[[MagharOrc]] "1951457", "1951458",
	--[[Mechagnom]] "3107651", "3107182",
	--[[Nightborn]]	"1732030", "1732405",
	--[[Void Elf]]	"1732785", "1733163",
	--[[Vulpera]] 	"3106252", "3106717",
	--[[Zandalari]]	"1903049", "1903522",
	}
	for _, soundID in pairs(trainSounds) do
		MuteSoundFile(soundID)
	end
end

function MISC:JerryWay()
	if hash_SlashCmdList["/WAY"] then return end -- disable this when other addons use Tomtom command

	local pointString = I.InfoColor.."|Hworldmap:%d+:%d+:%d+|h[|A:Waypoint-MapPin-ChatIcon:13:13:0:0|a%s (%s, %s)%s]|h|r"

	local function GetCorrectCoord(x)
		x = tonumber(x)
		if x then
			if x > 100 then
				return 100
			elseif x < 0 then
				return 0
			end
			return x
		end
	end

	SlashCmdList["UI_JERRY_WAY"] = function(msg)
		msg = gsub(msg, "(%d)[%.,] (%d)", "%1 %2")
		local x, y, z = strmatch(msg, "(%S+)%s(%S+)(.*)")
		if x and y then
			local mapID = C_Map_GetBestMapForUnit("player")
			if mapID then
				local mapInfo = C_Map_GetMapInfo(mapID)
				local mapName = mapInfo and mapInfo.name
				if mapName then
					x = GetCorrectCoord(x)
					y = GetCorrectCoord(y)
					if x and y then
						print(format(pointString, mapID, x*100, y*100, mapName, x, y, z or ""))
						C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(mapID, x/100, y/100))
						C_SuperTrack.SetSuperTrackedUserWaypoint(true)
					end
				end
			end
		end
	end
	SLASH_UI_JERRY_WAY1 = "/way"
end

function MISC:BaudErrorFrameHelpTip()
	if not C_AddOns.IsAddOnLoaded("!BaudErrorFrame") then return end
	local button, count = _G.BaudErrorFrameMinimapButton, _G.BaudErrorFrameMinimapCount
	if not button then return end

	local errorInfo = {
		text = U["BaudErrorTip"],
		buttonStyle = HelpTip.ButtonStyle.GotIt,
		targetPoint = HelpTip.Point.TopEdgeCenter,
		alignment = HelpTip.Alignment.Right,
		offsetX = -15,
		onAcknowledgeCallback = M.HelpInfoAcknowledge,
		callbackArg = "BaudError",
	}
	hooksecurefunc(count, "SetText", function(_, text)
		if not MaoRUISetDB["Help"]["BaudError"] then
			text = tonumber(text)
			if text and text > 0 then
				HelpTip:Show(button, errorInfo)
			end
		end
	end)
end

-- Buttons to enhance popup menu
function MISC:CustomMenu_AddFriend(rootDescription, data, name)
	rootDescription:CreateButton(I.InfoColor..ADD_CHARACTER_FRIEND, function()
		local fullName = data.server and data.name.."-"..data.server or data.name
		C_FriendList.AddFriend(name or fullName)
	end)
end

local guildInviteString = gsub(CHAT_GUILD_INVITE_SEND, HEADER_COLON, "")
function MISC:CustomMenu_GuildInvite(rootDescription, data, name)
	rootDescription:CreateButton(I.InfoColor..guildInviteString, function()
		local fullName = data.server and data.name.."-"..data.server or data.name
		C_GuildInfo.Invite(name or fullName)
	end)
end

function MISC:CustomMenu_CopyName(rootDescription, data, name)
	rootDescription:CreateButton(I.InfoColor..COPY_NAME, function()
		local editBox = ChatEdit_ChooseBoxForSend()
		local hasText = (editBox:GetText() ~= "")
		ChatEdit_ActivateChat(editBox)
		editBox:Insert(name or data.name)
		if not hasText then editBox:HighlightText() end
	end)
end

function MISC:CustomMenu_Whisper(rootDescription, data)
	rootDescription:CreateButton(I.InfoColor..WHISPER, function()
		ChatFrame_SendTell(data.name)
	end)
end

function MISC:QuickMenuButton()
	if not R.db["Misc"]["MenuButton"] then return end

	--hooksecurefunc(UnitPopupManager, "OpenMenu", function(_, which)
	--	print("MENU_UNIT_"..which)
	--end)

	Menu.ModifyMenu("MENU_UNIT_SELF", function(_, rootDescription, data)
		MISC:CustomMenu_CopyName(rootDescription, data)
		MISC:CustomMenu_Whisper(rootDescription, data)
	end)

	Menu.ModifyMenu("MENU_UNIT_TARGET", function(_, rootDescription, data)
		MISC:CustomMenu_CopyName(rootDescription, data)
	end)

	Menu.ModifyMenu("MENU_UNIT_PLAYER", function(_, rootDescription, data)
		MISC:CustomMenu_GuildInvite(rootDescription, data)
	end)

	Menu.ModifyMenu("MENU_UNIT_FRIEND", function(_, rootDescription, data)
		MISC:CustomMenu_AddFriend(rootDescription, data)
		MISC:CustomMenu_GuildInvite(rootDescription, data)
	end)

	Menu.ModifyMenu("MENU_UNIT_BN_FRIEND", function(_, rootDescription, data)
		local fullName
		local gameAccountInfo = data.accountInfo and data.accountInfo.gameAccountInfo
		if gameAccountInfo then
			local characterName = gameAccountInfo.characterName
			local realmName = gameAccountInfo.realmName
			if characterName and realmName then
				fullName = characterName.."-"..realmName
			end
		end
		MISC:CustomMenu_AddFriend(rootDescription, data, fullName)
		MISC:CustomMenu_GuildInvite(rootDescription, data, fullName)
		MISC:CustomMenu_CopyName(rootDescription, data, fullName)
	end)

	Menu.ModifyMenu("MENU_UNIT_PARTY", function(_, rootDescription, data)
		MISC:CustomMenu_GuildInvite(rootDescription, data)
	end)

	Menu.ModifyMenu("MENU_UNIT_RAID", function(_, rootDescription, data)
		MISC:CustomMenu_AddFriend(rootDescription, data)
		MISC:CustomMenu_GuildInvite(rootDescription, data)
		MISC:CustomMenu_CopyName(rootDescription, data)
		MISC:CustomMenu_Whisper(rootDescription, data)
	end)

	Menu.ModifyMenu("MENU_UNIT_RAID_PLAYER", function(_, rootDescription, data)
		MISC:CustomMenu_GuildInvite(rootDescription, data)
	end)
end

-- Enhanced ColorPickerFrame
local function translateColor(r)
	if not r then r = "ff" end
	return tonumber(r, 16)/255
end

function MISC:EnhancedPicker_UpdateColor()
	local r, g, b = strmatch(self.colorStr, "(%x%x)(%x%x)(%x%x)$")
	r = translateColor(r)
	g = translateColor(g)
	b = translateColor(b)
	_G.ColorPickerFrame.Content.ColorPicker:SetColorRGB(r, g, b)
end

local function GetBoxColor(box)
	local r = box:GetText()
	r = tonumber(r)
	if not r or r < 0 or r > 255 then r = 255 end
	return r
end

local function updateColorRGB(self)
	local r = GetBoxColor(_G.ColorPickerFrame.__boxR)
	local g = GetBoxColor(_G.ColorPickerFrame.__boxG)
	local b = GetBoxColor(_G.ColorPickerFrame.__boxB)
	self.colorStr = format("%02x%02x%02x", r, g, b)
	MISC.EnhancedPicker_UpdateColor(self)
end

local function updateColorStr(self)
	self.colorStr = self:GetText()
	MISC.EnhancedPicker_UpdateColor(self)
end

local function createCodeBox(width, index, text)
	local parent = ColorPickerFrame.Content.ColorSwatchCurrent
	local offset = -3

	local box = M.CreateEditBox(_G.ColorPickerFrame, width, 22)
	box:SetMaxLetters(index == 4 and 6 or 3)
	box:SetTextInsets(0, 0, 0, 0)
	box:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 0, -index*24 + offset)
	M.CreateFS(box, 14, text, "system", "LEFT", -15, 0)
	if index == 4 then
		box:HookScript("OnEnterPressed", updateColorStr)
	else
		box:HookScript("OnEnterPressed", updateColorRGB)
	end
	return box
end

function MISC:EnhancedPicker()
	local pickerFrame = _G.ColorPickerFrame
	pickerFrame:SetHeight(250)
	M.CreateMF(pickerFrame.Header, pickerFrame) -- movable by header

	local colorBar = CreateFrame("Frame", nil, pickerFrame)
	colorBar:SetSize(1, 22)
	colorBar:SetPoint("BOTTOM", 0, 38)

	local count = 0
	for class, name in pairs(LOCALIZED_CLASS_NAMES_MALE) do
		local value = I.ClassColors[class]
		if value then
			local bu = M.CreateButton(colorBar, 22, 22, true)
			bu.Icon:SetColorTexture(value.r, value.g, value.b)
			bu:SetPoint("LEFT", count*22, 0)
			bu.colorStr = value.colorStr
			bu:SetScript("OnClick", MISC.EnhancedPicker_UpdateColor)
			M.AddTooltip(bu, "ANCHOR_TOP", "|c"..value.colorStr..name)

			count = count + 1
		end
	end
	colorBar:SetWidth(count*22)

	pickerFrame.__boxR = createCodeBox(45, 1, "|cffff0000R")
	pickerFrame.__boxG = createCodeBox(45, 2, "|cff00ff00G")
	pickerFrame.__boxB = createCodeBox(45, 3, "|cff0000ffB")

	local hexBox = pickerFrame.Content and pickerFrame.Content.HexBox
	if hexBox then
		M.ReskinEditBox(hexBox)
		hexBox:ClearAllPoints()
		hexBox:SetPoint("BOTTOMRIGHT", -25, 67)
	end

	pickerFrame.Content.ColorPicker.__owner = pickerFrame
	pickerFrame.Content.ColorPicker:HookScript("OnColorSelect", function(self)
		local r, g, b = self.__owner:GetColorRGB()
		r = M:Round(r*255)
		g = M:Round(g*255)
		b = M:Round(b*255)

		self.__owner.__boxR:SetText(r)
		self.__owner.__boxG:SetText(g)
		self.__owner.__boxB:SetText(b)
	end)
end

function MISC:UpdateMaxZoomLevel()
	SetCVar("cameraDistanceMaxZoomFactor", R.db["Misc"]["MaxZoom"])
end

-- Move and save blizz frames
function MISC:MoveBlizzFrames()
	--M:BlizzFrameMover(CharacterFrame)
end
