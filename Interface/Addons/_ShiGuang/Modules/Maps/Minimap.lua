local _, ns = ...
local M, R, U, I = unpack(ns)
local module = M:GetModule("Maps")

local _G = _G
local select, pairs, unpack, next, tinsert = select, pairs, unpack, next, tinsert
local strmatch, strfind, strupper = strmatch, strfind, strupper
local UIFrameFadeOut, UIFrameFadeIn = UIFrameFadeOut, UIFrameFadeIn
local C_Timer_After = C_Timer.After
local cr, cg, cb = I.r, I.g, I.b
local LE_GARRISON_TYPE_6_0 = Enum.GarrisonType.Type_6_0
local LE_GARRISON_TYPE_7_0 = Enum.GarrisonType.Type_7_0
local LE_GARRISON_TYPE_8_0 = Enum.GarrisonType.Type_8_0
local LE_GARRISON_TYPE_9_0 = Enum.GarrisonType.Type_9_0

function module:CreatePulse()
	if not R.db["Map"]["CombatPulse"] then return end

	local bg = M.SetBD(Minimap)
	bg:SetFrameStrata("BACKGROUND")
	local anim = bg:CreateAnimationGroup()
	anim:SetLooping("BOUNCE")
	anim.fader = anim:CreateAnimation("Alpha")
	anim.fader:SetFromAlpha(.8)
	anim.fader:SetToAlpha(.2)
	anim.fader:SetDuration(1)
	anim.fader:SetSmoothing("OUT")

	local function updateMinimapAnim(event)
		if event == "PLAYER_REGEN_DISABLED" then
			bg:SetBackdropBorderColor(1, 0, 0)
			anim:Play()
		elseif not InCombatLockdown() then
			if C_Calendar.GetNumPendingInvites() > 0 or MiniMapMailFrame:IsShown() then
				bg:SetBackdropBorderColor(1, 1, 0)
				anim:Play()
			else
				anim:Stop()
				bg:SetBackdropBorderColor(0, 0, 0)
			end
		end
	end
	M:RegisterEvent("PLAYER_REGEN_ENABLED", updateMinimapAnim)
	M:RegisterEvent("PLAYER_REGEN_DISABLED", updateMinimapAnim)
	M:RegisterEvent("CALENDAR_UPDATE_PENDING_INVITES", updateMinimapAnim)
	M:RegisterEvent("UPDATE_PENDING_MAIL", updateMinimapAnim)

	MiniMapMailFrame:HookScript("OnHide", function()
		if InCombatLockdown() then return end
		anim:Stop()
		bg:SetBackdropBorderColor(0, 0, 0)
	end)
end

local function ToggleLandingPage(_, ...)
	if InCombatLockdown() then UIErrorsFrame:AddMessage(I.InfoColor..ERR_NOT_IN_COMBAT) return end
	if not C_Garrison.HasGarrison(...) then
		UIErrorsFrame:AddMessage(I.InfoColor..CONTRIBUTION_TOOLTIP_UNLOCKED_WHEN_ACTIVE)
		return
	end
	ShowGarrisonLandingPage(...)
end

function module:ReskinRegions()
	-- Garrison
	hooksecurefunc("GarrisonLandingPageMinimapButton_UpdateIcon", function(self)
		self:ClearAllPoints()
		self:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 16, 12)
		self:SetScale(0.72)
		--self:GetNormalTexture():SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\2UI")
		--self:GetPushedTexture():SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\2UI")
		--self:GetHighlightTexture():SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\2UI")
		--self:SetSize(30, 30)

		if RecycleBinToggleButton and not RecycleBinToggleButton.settled then
			RecycleBinToggleButton:SetPoint("BOTTOMRIGHT", -15, -6)
			RecycleBinToggleButton.settled = true
		end
	end)

	local menuList = {
		{text =	GARRISON_TYPE_9_0_LANDING_PAGE_TITLE, func = ToggleLandingPage, arg1 = LE_GARRISON_TYPE_9_0, notCheckable = true},
		{text =	WAR_CAMPAIGN, func = ToggleLandingPage, arg1 = LE_GARRISON_TYPE_8_0, notCheckable = true},
		{text =	ORDER_HALL_LANDING_PAGE_TITLE, func = ToggleLandingPage, arg1 = LE_GARRISON_TYPE_7_0, notCheckable = true},
		{text =	GARRISON_LANDING_PAGE_TITLE, func = ToggleLandingPage, arg1 = LE_GARRISON_TYPE_6_0, notCheckable = true},
	}
	GarrisonLandingPageMinimapButton:HookScript("OnMouseDown", function(self, btn)
		if btn == "RightButton" then
			HideUIPanel(GarrisonLandingPage)
			EasyMenu(menuList, M.EasyMenu, self, -80, 0, "MENU", 1)
		end
	end)
	GarrisonLandingPageMinimapButton:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		GameTooltip:SetText(self.title, 1, 1, 1)
		GameTooltip:AddLine(self.description, nil, nil, nil, true)
		GameTooltip:AddLine(U["SwitchGarrisonType"], nil, nil, nil, true)
		GameTooltip:Show();
	end)

	-- QueueStatus Button
	QueueStatusMinimapButton:ClearAllPoints()
	QueueStatusMinimapButton:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", -6, -6)
	QueueStatusMinimapButtonBorder:Hide()
	QueueStatusMinimapButtonIconTexture:SetTexture(nil)

	local queueIcon = Minimap:CreateTexture(nil, "ARTWORK")
	queueIcon:SetPoint("CENTER", QueueStatusMinimapButton)
	queueIcon:SetSize(46, 46)
	queueIcon:SetTexture(I.eyeTex)
	local anim = queueIcon:CreateAnimationGroup()
	anim:SetLooping("REPEAT")
	anim.rota = anim:CreateAnimation("Rotation")
	anim.rota:SetDuration(2)
	anim.rota:SetDegrees(360)
	hooksecurefunc("QueueStatusFrame_Update", function()
		queueIcon:SetShown(QueueStatusMinimapButton:IsShown())
	end)
	hooksecurefunc("EyeTemplate_StartAnimating", function() anim:Play() end)
	hooksecurefunc("EyeTemplate_StopAnimating", function() anim:Stop() end)

	-- Difficulty Flags
	local flags = {"MiniMapInstanceDifficulty", "GuildInstanceDifficulty", "MiniMapChallengeMode"}
	for _, v in pairs(flags) do
		local flag = _G[v]
		flag:ClearAllPoints()
		flag:SetPoint("TOPLEFT" ,Minimap, "TOPLEFT", -6, 6)
		flag:SetScale(0.85)
	end
	
	--Tracking
	MiniMapTrackingBackground:SetAlpha(0)
	MiniMapTrackingButton:SetAlpha(0)
	MiniMapTracking:ClearAllPoints()
	MiniMapTracking:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 6, 5)
	MiniMapTracking:SetScale(0.8)
	
	-- Mail icon
	MiniMapMailFrame:ClearAllPoints()
	MiniMapMailFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 6,-2)
	MiniMapMailIcon:SetTexture(I.mailTex)
	MiniMapMailBorder:Hide()
	--MiniMapMailIcon:SetVertexColor(1, 1, 0)

	-- Invites Icon
	GameTimeCalendarInvitesTexture:ClearAllPoints()
	GameTimeCalendarInvitesTexture:SetParent("Minimap")
	GameTimeCalendarInvitesTexture:SetPoint("TOPRIGHT")

	local Invt = CreateFrame("Button", nil, UIParent)
	Invt:SetPoint("TOPRIGHT", Minimap, "BOTTOMLEFT", -20, -20)
	Invt:SetSize(250, 80)
	Invt:Hide()
	M.SetBD(Invt)
	M.CreateFS(Invt, 16, I.InfoColor..GAMETIME_TOOLTIP_CALENDAR_INVITES)

	local function updateInviteVisibility()
		Invt:SetShown(C_Calendar.GetNumPendingInvites() > 0)
	end
	M:RegisterEvent("CALENDAR_UPDATE_PENDING_INVITES", updateInviteVisibility)
	M:RegisterEvent("PLAYER_ENTERING_WORLD", updateInviteVisibility)

	Invt:SetScript("OnClick", function(_, btn)
		Invt:Hide()
		if btn == "LeftButton" and not InCombatLockdown() then
			ToggleCalendar()
		end
		M:UnregisterEvent("CALENDAR_UPDATE_PENDING_INVITES", updateInviteVisibility)
		M:UnregisterEvent("PLAYER_ENTERING_WORLD", updateInviteVisibility)
	end)
end

----------------------------------------------------------------------------	右键菜单---------------------------------------
--动作条样式
local SetMrbarMenuFrame = CreateFrame("Frame", "ClickMenu", UIParent, "UIDropDownMenuTemplate")
local SetMrbarMicromenu = {  
    --{ text = "|cffff8800 ------------------------|r", notCheckable = true },
    --{ text = "           "..MAINMENU_BUTTON.."", isTitle = true, notCheckable = true},
    --{ text = "|cffff8800 ------------------------|r", notCheckable = true },
    --{ text = CHARACTER, icon = 'Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle',
        --func = function() ToggleFrame(CharacterFrame) end, notCheckable = true},
    --{ text = SPELLBOOK, icon = 'Interface\\MINIMAP\\TRACKING\\Class',
        --func = function() ToggleFrame(SpellBookFrame) end, notCheckable = true},
    --{ text = TALENTS, icon = 'Interface\\MINIMAP\\TRACKING\\Ammunition',
        --func = function() if (not PlayerTalentFrame) then LoadAddOn('Blizzard_TalentUI') end
        --if (not GlyphFrame) then LoadAddOn('Blizzard_GlyphUI') end
        --ToggleTalentFrame() end, notCheckable = true},
    --{ text = INVENTORY_TOOLTIP,  icon = 'Interface\\MINIMAP\\TRACKING\\Banker',
        --func = function() ToggleAllBags() end, notCheckable = true},
    --{ text = ACHIEVEMENTS, icon = 'Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Shield',
        --func = function() ToggleAchievementFrame() end, notCheckable = true},
    --{ text = QUEST_LOG, icon = 'Interface\\GossipFrame\\ActiveQuestIcon',
        --func = function() ToggleQuestLog() end, notCheckable = true},
    --{ text = FRIENDS, icon = 'Interface\\FriendsFrame\\PlusManz-BattleNet',
        --func = function() ToggleFriendsFrame() end, notCheckable = true},
    --{ text = GUILD, icon = 'Interface\\GossipFrame\\TabardGossipIcon',
        --func = function() if (IsTrialAccount()) then UIErrorsFrame:AddMessage(ERR_RESTRICTED_ACCOUNT, 1, 0, 0) else ToggleGuildFrame() end end, notCheckable = true},
    --{ text = GROUP_FINDER, icon = 'Interface\\LFGFRAME\\BattleNetWorking0',
        --func = function() securecall(PVEFrame_ToggleFrame, 'GroupFinderFrame', LFDParentFrame) end, notCheckable = true},
    --{ text = ENCOUNTER_JOURNAL, icon = 'Interface\\MINIMAP\\TRACKING\\Profession',
        --func = function() ToggleEncounterJournal() end, notCheckable = true},
    --{ text = PLAYER_V_PLAYER, icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster', --broke
	     --func = function() securecall(PVEFrame_ToggleFrame, 'PVPUIFrame', HonorFrame) end, notCheckable = true},
    --{ text = MOUNTS, icon = 'Interface\\MINIMAP\\TRACKING\\StableMaster',  --broke
	      --func = function() ToggleCollectionsJournal() end, notCheckable = true},
   -- { text = PETS, icon = 'Interface\\MINIMAP\\TRACKING\\StableMaster',  --broke
	  --func = function() securecall(ToggleCollectionsJournal, 2) end, tooltipTitle = securecall(MicroButtonTooltipText, MOUNTS_AND_PETS, 'TOGGLEPETJOURNAL'), notCheckable = true},
    --{ text = TOY_BOX, icon = 'Interface\\MINIMAP\\TRACKING\\Reagents',  --broke 
	  --func = function() securecall(ToggleCollectionsJournal, 3) end, tooltipTitle = securecall(MicroButtonTooltipText, TOY_BOX, 'TOGGLETOYBOX'), notCheckable = true},
    --{ text = 'Heirlooms', icon = 'Interface\\MINIMAP\\TRACKING\\Reagents',  --broke
	  --func = function() securecall(ToggleCollectionsJournal, 4) end, tooltipTitle = securecall(MicroButtonTooltipText, TOY_BOX, 'TOGGLETOYBOX'), notCheckable = true},
    --{ text = "Calender",icon = 'Interface\\Calendar\\UI-Calendar-Button',  --broke 
         --func = function() LoadAddOn('Blizzard_Calendar') Calendar_Toggle() end, notCheckable = true},
    --{ text = BLIZZARD_STORE, icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster',
         --func = function() LoadAddOn('Blizzard_StoreUI') securecall(ToggleStoreUI) end, notCheckable = true},
    --{ text = GAMEMENU_HELP, icon = 'Interface\\CHATFRAME\\UI-ChatIcon-Blizz',
         --func = function() ToggleFrame(HelpFrame) end, notCheckable = true},
    --{ text = BATTLEFIELD_MINIMAP,
         --func = function() securecall(ToggleBattlefieldMinimap) end, notCheckable = true},
    { text = "|cffff8800 ------------------------|r", notCheckable = true },
    { text = "           -|cFFFFFF00 2|r|cFFFF0000 UI |r- ", isTitle = true, notCheckable = true},
    { text = "|cffff8800 ------------------------|r", notCheckable = true },
    { text = MINIMAP_MENU_BARSTYLE,  icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster',
         func = function() SenduiCmd("/mr");  end, notCheckable = true},
    { text = MINIMAP_MENU_KEYBIND, icon = 'Interface\\MacroFrame\\MacroFrame-Icon.blp',
        func = function() SenduiCmd("/Keybind"); end, notCheckable = true},
    { text = "|cFF00DDFF ----- "..BINDING_NAME_MOVEANDSTEER.." -----|r", isTitle = true, notCheckable = true },
    { text = MINIMAP_MENU_SPECIALBUTTON, icon = 'Interface\\Icons\\INV_Inscription_RunescrollOfFortitude_Red',
        func = function() SenduiCmd("/moveit"); end, notCheckable = true},
    { text = MINIMAP_MENU_AURADIY, icon = 'Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Shield',
        func = function() SenduiCmd("/awc"); end, notCheckable = true},
    --{ text = MINIMAP_MENU_QUESTBUTTON, icon = 'Interface\\GossipFrame\\ActiveQuestIcon',
        --func = function() SenduiCmd("/eqb"); end, notCheckable = true},
    { text = MINIMAP_MENU_CASTBAR, icon = 'Interface\\Icons\\INV_Misc_Bone_HumanSkull_02',
        func = function() SenduiCmd("/cbs"); end, notCheckable = true},
    { text = MINIMAP_MENU_DAMAGESTYLE, icon = 'Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle',
        func = function() SenduiCmd("/dex"); end, notCheckable = true },
    --{ text = MINIMAP_MENU_BOSSFRAME, icon = 'Interface\\MINIMAP\\TRACKING\\QuestBlob',
        --func = function() SenduiCmd("/sb test"); end, notCheckable = true},
    --{ text = "聊天屏蔽", icon = 'Interface\\Calendar\\UI-Calendar-Button',
        --func = function() SenduiCmd("/ecf"); end, notCheckable = true},
    { text = "|cFF00DDFF ------- "..MINIMAP_MENU_ONOFF.." -------|r", isTitle = true, notCheckable = true},
    --{ text = MINIMAP_MENU_INTERRUPT, icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster',
        --func = function() SenduiCmd("/esi"); end, notCheckable = true},
    {text = MINIMAP_MENU_DISTANCE, hasArrow = true, notCheckable = true,
        menuList={  
            { text = YES, func = function() SenduiCmd("/hardyards sho") end, notCheckable = true},
            { text = NO, func = function() SenduiCmd("/hardyards hid") end, notCheckable = true}
        }
    },
    --{text = MINIMAP_MENU_COMBOPOINTS, hasArrow = true, notCheckable = true,
        --menuList={  
            --{ text = YES, func = function() SenduiCmd("/bht hiton") end, notCheckable = true},
            --{ text = NO, func = function() SenduiCmd("/bht hitoff") end, notCheckable = true}
        --}
    --},
    --{text = MINIMAP_MENU_COMPAREITEMS, hasArrow = true, notCheckable = true,
        --menuList={  
            --{ text = YES, func = function() SenduiCmd("/run SetCVar('alwaysCompareItems', 1)") end, notCheckable = true},
            --{ text = NO, func = function() SenduiCmd("/run SetCVar('alwaysCompareItems', 0)") end, notCheckable = true}
        --}
    --},
    { text = "|cFF00DDFF ------- Style -------|r", isTitle = true, notCheckable = true },
    { text = MINIMAP_MENU_SWITCHUF, icon = 'Interface\\Icons\\Spell_Holy_Crusade',
        func = function() SenduiCmd("/loadmr"); end, notCheckable = true},
    --{ text = MINIMAP_MENU_AFKSCREEN, icon = 'Interface\\Icons\\Spell_Nature_Sentinal',
        --func = function() SenduiCmd("/wallpaperkit"); end, notCheckable = true},
    --{ text = MINIMAP_MENU_CHECKFOODSSS, icon = 'Interface\\MINIMAP\\TRACKING\\Reagents',
        --func = function() SenduiCmd("/hj"); end, notCheckable = true  },
    --{ text = MINIMAP_MENU_WORLDQUESTREWARD, icon = 'Interface\\Calendar\\UI-Calendar-Button',
        --func = function() SenduiCmd("/wqa popup"); end, notCheckable = true},
    --{ text = "|cFF00DDFF -- OneKeyMacro --|r", func = function() SenduiCmd("/MacroHelp"); end, notCheckable = true},
    { text = "  |cFFBF00FFSimc|r", func = function() SenduiCmd("/simc"); end, notCheckable = true},
    { text = "  |cFFBF00FFWe Love WOW|r", func = function() SenduiCmd("/welovewow"); end, notCheckable = true},
    { text = "|cffff8800 --------------------------|r", isTitle = true, notCheckable = true  },
    { text = "  |cFFBF00FF"..MINIMAP_MENU_QUSETIONANSWER.."|r", func = function() SenduiCmd("/MrHelp"); end, notCheckable = true},
    { text = "  |cFFBF00FF2 UI"..MINIMAP_MENU_UISETTING.."|r", func = function() SenduiCmd("/mr"); end, notCheckable = true},
    { text = "|cffff8800 --------------------------|r", isTitle = true, notCheckable = true  },
    { text = "            |cFFBF00FF"..MINIMAP_MENU_MORE.."|r", func = function() SenduiCmd("/ip"); end, notCheckable = true},
    --{ text = "ESC菜单", func = function() ToggleFrame(GameMenuFrame) end, notCheckable = true},
    --{ text = "                       ", isTitle = true, notCheckable = true  },
    --{ text = LOGOUT, func = function() Logout() end, notCheckable = true},
    --{ text = QUIT, func = function() ForceQuit() end, notCheckable = true},
}


function module:WhoPingsMyMap()
	if not R.db["Map"]["WhoPings"] then return end
	local f = CreateFrame("Frame", nil, Minimap)
	f:SetAllPoints()
	f.text = M.CreateFS(f, 14, "", false, "TOP", 0, -3)
	local anim = f:CreateAnimationGroup()
	anim:SetScript("OnPlay", function() f:SetAlpha(1) end)
	anim:SetScript("OnFinished", function() f:SetAlpha(0) end)
	anim.fader = anim:CreateAnimation("Alpha")
	anim.fader:SetFromAlpha(1)
	anim.fader:SetToAlpha(0)
	anim.fader:SetDuration(3)
	anim.fader:SetSmoothing("OUT")
	anim.fader:SetStartDelay(3)

	M:RegisterEvent("MINIMAP_PING", function(_, unit)
		if unit == "player" then return end -- ignore player ping
		anim:Stop()
		f.text:SetText(GetUnitName(unit))
		f.text:SetTextColor(M.ClassColor(select(2, UnitClass(unit))))
		anim:Play()
	end)
end

function module:UpdateMinimapScale()
	local size = Minimap:GetWidth()
	local scale = R.db["Map"]["MinimapScale"]
	Minimap:SetScale(scale)
	Minimap.mover:SetSize(size*scale, size*scale)
end

function module:ShowMinimapClock()
	if R.db["Map"]["Clock"] then
		if not TimeManagerClockButton then LoadAddOn("Blizzard_TimeManager") end
		if not TimeManagerClockButton.styled then
			TimeManagerClockButton:DisableDrawLayer("BORDER")
			TimeManagerClockButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -8)
			TimeManagerClockTicker:SetFont(unpack(I.Font))
			TimeManagerClockTicker:SetTextColor(1, 1, 1)

			TimeManagerClockButton.styled = true
		end
		TimeManagerClockButton:Show()
	else
		if TimeManagerClockButton then TimeManagerClockButton:Hide() end
	end
end

function module:ShowCalendar()
	if R.db["Map"]["Calendar"] then
		if not GameTimeFrame.styled then
			GameTimeFrame:SetNormalTexture(nil)
			GameTimeFrame:SetPushedTexture(nil)
			GameTimeFrame:SetHighlightTexture(nil)
			GameTimeFrame:SetSize(18, 18)
			GameTimeFrame:SetParent(Minimap)
			GameTimeFrame:ClearAllPoints()
			GameTimeFrame:SetPoint("BOTTOMRIGHT", Minimap, 1, 18)
			GameTimeFrame:SetHitRectInsets(0, 0, 0, 0)

			for i = 1, GameTimeFrame:GetNumRegions() do
				local region = select(i, GameTimeFrame:GetRegions())
				if region.SetTextColor then
					region:SetTextColor(cr, cg, cb)
					region:SetFont(unpack(I.Font))
					break
				end
			end

			GameTimeFrame.styled = true
		end
		GameTimeFrame:Show()
	else
		GameTimeFrame:Hide()
	end
end

function module:Minimap_OnMouseWheel(zoom)
	if zoom > 0 then
		Minimap_ZoomIn()
	else
		Minimap_ZoomOut()
	end
end

local NDuiMiniMapTrackingDropDown = CreateFrame("Frame", "NDuiMiniMapTrackingDropDown", _G.UIParent, "UIDropDownMenuTemplate")
NDuiMiniMapTrackingDropDown:SetID(1)
NDuiMiniMapTrackingDropDown:SetClampedToScreen(true)
NDuiMiniMapTrackingDropDown:Hide()
NDuiMiniMapTrackingDropDown.noResize = true
_G.UIDropDownMenu_Initialize(NDuiMiniMapTrackingDropDown, _G.MiniMapTrackingDropDown_Initialize, "MENU")

function module:Minimap_OnMouseUp(btn)
		if btn == "LeftButton" then 
			if IsAltKeyDown() then ToggleFrame(WorldMapFrame) --Alt+鼠标左键点击显示大地图
			elseif IsShiftKeyDown() then if InCombatLockdown() then UIErrorsFrame:AddMessage(I.InfoColor..ERR_NOT_IN_COMBAT) return end ToggleCalendar()
			elseif IsControlKeyDown() then ToggleDropDownMenu(1, nil, NDuiMiniMapTrackingDropDown, "cursor")
			else Minimap_OnClick(self) --鼠标左键点击小地图显示Ping位置提示
			end
		elseif btn == "MiddleButton" then ToggleFrame(ObjectiveTrackerFrame)  --M:DropDown(MapMicromenu, MapMenuFrame, 0, 0) --鼠标中键显示系统菜单
		elseif btn == "RightButton" then EasyMenu(SetMrbarMicromenu, SetMrbarMenuFrame, "cursor", 0, 0, "MENU", 2) --鼠标右键显示增强菜单
		end
end

function module:SetupHybridMinimap()
	HybridMinimap.CircleMask:SetTexture("Interface\\BUTTONS\\WHITE8X8")
end

function module:HybridMinimapOnLoad(addon)
	if addon == "Blizzard_HybridMinimap" then
		module:SetupHybridMinimap()
		M:UnregisterEvent(self, module.HybridMinimapOnLoad)
	end
end

local minimapInfo = {
	text = U["MinimapHelp"],
	buttonStyle = HelpTip.ButtonStyle.GotIt,
	targetPoint = HelpTip.Point.LeftEdgeBottom,
	onAcknowledgeCallback = M.HelpInfoAcknowledge,
	callbackArg = "MinimapInfo",
	alignment = 3,
}

function module:ShowMinimapHelpInfo()
	Minimap:HookScript("OnEnter", function()
		if not MaoRUIDB["Help"]["MinimapInfo"] then
			HelpTip:Show(MinimapCluster, minimapInfo)
		end
	end)
end

function module:SetupMinimap()
	-- Shape and Position
	Minimap:ClearAllPoints()
	Minimap:SetPoint(unpack(R.Minimap.Pos))
	Minimap:SetSize(186, 186)
	Minimap:SetFrameLevel(10)
	Minimap:SetMaskTexture("Interface\\Buttons\\WHITE8X8")
	DropDownList1:SetClampedToScreen(true)

	local mover = M.Mover(Minimap, U["Minimap"], "Minimap", R.Minimap.Pos)
	Minimap:ClearAllPoints()
	Minimap:SetPoint("TOPRIGHT", mover)
	Minimap.mover = mover

	self:UpdateMinimapScale()
	self:ShowMinimapClock()
	self:ShowCalendar()

	-- Minimap clicks
	Minimap:EnableMouseWheel(true)
	Minimap:SetScript("OnMouseWheel", module.Minimap_OnMouseWheel)
	Minimap:SetScript("OnMouseUp", module.Minimap_OnMouseUp)

	-- Hide Blizz
	local frames = {
		"MinimapBorderTop",
		"MinimapNorthTag",
		"MinimapBorder",
		"MinimapZoneTextButton",
		"MinimapZoomOut",
		"MinimapZoomIn",
		"MiniMapWorldMapButton",
		"MiniMapMailBorder",
		--"MiniMapTracking",
	}

	for _, v in pairs(frames) do
		M.HideObject(_G[v])
	end
	MinimapCluster:EnableMouse(false)
	Minimap:SetArchBlobRingScalar(0)
	Minimap:SetQuestBlobRingScalar(0)

	-- Add Elements
	self:CreatePulse()
	self:ReskinRegions()
	self:WhoPingsMyMap()
	self:ShowMinimapHelpInfo()

	-- HybridMinimap
	M:RegisterEvent("ADDON_LOADED", module.HybridMinimapOnLoad)
end
