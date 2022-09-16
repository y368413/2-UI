local _, ns = ...
local M, R, U, I = unpack(ns)
local oUF = ns.oUF
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

local MiniMapMailFrame = I.isNewPatch and MinimapCluster.MailFrame or MiniMapMailFrame

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
	--if InCombatLockdown() then UIErrorsFrame:AddMessage(I.InfoColor..ERR_NOT_IN_COMBAT) return end -- fix by LibShowUIPanel
	if not C_Garrison.HasGarrison(...) then
		UIErrorsFrame:AddMessage(I.InfoColor..CONTRIBUTION_TOOLTIP_UNLOCKED_WHEN_ACTIVE)
		return
	end
	ShowGarrisonLandingPage(...)
end

function module:ReskinRegions()
	-- Garrison
	local function updateMinimapButtons(self)
		self:ClearAllPoints()
		self:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 16, 12)
		self:SetScale(0.72)
		--self:GetNormalTexture():SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\2UI")
		--self:GetPushedTexture():SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\2UI")
		--self:GetHighlightTexture():SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\2UI")
		--self:SetSize(30, 30)

		if self:IsShown() and RecycleBinToggleButton and not RecycleBinToggleButton.settled then
			RecycleBinToggleButton:SetPoint("BOTTOMRIGHT", -15, -6)
			RecycleBinToggleButton.settled = true
		end
	end

	if I.isNewPatch then
		updateMinimapButtons(ExpansionLandingPageMinimapButton)
		hooksecurefunc(ExpansionLandingPageMinimapButton, "UpdateIcon", updateMinimapButtons)

		-- QueueStatus Button
		QueueStatusButton:ClearAllPoints()
		QueueStatusButton:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", -5, -5)
		QueueStatusButton:Hide()
		QueueStatusButtonIcon:SetAlpha(0)
		QueueStatusButton:SetFrameLevel(999)
	
		local queueIcon = Minimap:CreateTexture(nil, "ARTWORK")
		queueIcon:SetPoint("CENTER", QueueStatusButton)
		queueIcon:SetSize(50, 50)
		queueIcon:SetTexture(I.eyeTex)
		local anim = queueIcon:CreateAnimationGroup()
		anim:SetLooping("REPEAT")
		anim.rota = anim:CreateAnimation("Rotation")
		anim.rota:SetDuration(2)
		anim.rota:SetDegrees(360)
		hooksecurefunc(QueueStatusFrame, "Update", function()
			queueIcon:SetShown(QueueStatusButton:IsShown())
		end)
		hooksecurefunc(QueueStatusButton.Eye, "PlayAnim", function() anim:Play() end)
		hooksecurefunc(QueueStatusButton.Eye, "StopAnimating", function() anim:Pause() end)
	else
		hooksecurefunc("GarrisonLandingPageMinimapButton_UpdateIcon", updateMinimapButtons)

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
		GarrisonLandingPageMinimapButton:SetFrameLevel(999)

		-- QueueStatus Button
		QueueStatusMinimapButton:ClearAllPoints()
		QueueStatusMinimapButton:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", -5, -5)
		QueueStatusMinimapButtonBorder:Hide()
		QueueStatusMinimapButtonIconTexture:SetTexture(nil)
		QueueStatusMinimapButton:SetFrameLevel(999)
	
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
	end

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
		--if btn == "LeftButton" and not InCombatLockdown() then -- fix by LibShowUIPanel
		if btn == "LeftButton" then
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


function module:RecycleBin()
	if not R.db["Map"]["ShowRecycleBin"] then return end

	local blackList = {
		["GameTimeFrame"] = true,
		["MiniMapLFGFrame"] = true,
		["BattlefieldMinimap"] = true,
		["MinimapBackdrop"] = true,
		["TimeManagerClockButton"] = true,
		["FeedbackUIButton"] = true,
		["MiniMapBattlefieldFrame"] = true,
		["QueueStatusMinimapButton"] = true,
		["GarrisonLandingPageMinimapButton"] = true,
		["MinimapZoneTextButton"] = true,
		["RecycleBinFrame"] = true,
		["RecycleBinToggleButton"] = true,
	}

	local function updateRecycleTip(bu)
		bu.text = I.RightButton..U["AutoHide"]..": "..(MaoRUIDB["AutoRecycle"] and "|cff55ff55"..VIDEO_OPTIONS_ENABLED or "|cffff5555"..VIDEO_OPTIONS_DISABLED)
	end

	local bu = CreateFrame("Button", "RecycleBinToggleButton", Minimap)
	bu:SetSize(30, 30)
	bu:SetPoint("BOTTOMRIGHT", 4, -6)
	bu:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	bu.Icon = bu:CreateTexture(nil, "ARTWORK")
	bu.Icon:SetAllPoints()
	bu.Icon:SetTexture(I.binTex)
	bu:SetHighlightTexture(I.binTex)
	bu.title = I.InfoColor..U["Minimap RecycleBin"]
	bu:SetFrameLevel(999)
	M.AddTooltip(bu, "ANCHOR_LEFT")
	updateRecycleTip(bu)

	local width, height, alpha = 220, 40, .5
	local bin = CreateFrame("Frame", "RecycleBinFrame", UIParent)
	bin:SetPoint("BOTTOMRIGHT", bu, "BOTTOMLEFT", -3, 10)
	bin:SetSize(width, height)
	bin:Hide()

	local tex = M.SetGradient(bin, "H", 0, 0, 0, 0, alpha, width, height)
	tex:SetPoint("CENTER")
	local topLine = M.SetGradient(bin, "H", cr, cg, cb, 0, alpha, width, R.mult)
	topLine:SetPoint("BOTTOM", bin, "TOP")
	local bottomLine = M.SetGradient(bin, "H", cr, cg, cb, 0, alpha, width, R.mult)
	bottomLine:SetPoint("TOP", bin, "BOTTOM")
	local rightLine = M.SetGradient(bin, "V", cr, cg, cb, alpha, alpha, R.mult, height + R.mult*2)
	rightLine:SetPoint("LEFT", bin, "RIGHT")

	local function hideBinButton()
		bin:Hide()
	end
	local function clickFunc(force)
		if force == 1 or MaoRUIDB["AutoRecycle"] then
			UIFrameFadeOut(bin, .5, 1, 0)
			C_Timer_After(.5, hideBinButton)
		end
	end

	local ignoredButtons = {
		["GatherMatePin"] = true,
		["HandyNotes.-Pin"] = true,
	}
	M.SplitList(ignoredButtons, MaoRUIDB["IgnoredButtons"])

	local function isButtonIgnored(name)
		for addonName in pairs(ignoredButtons) do
			if strmatch(name, addonName) then
				return true
			end
		end
	end

	local isGoodLookingIcon = {
		["Narci_MinimapButton"] = true,
	}

	local iconsPerRow = 10
	local rowMult = iconsPerRow/2 - 1
	local currentIndex, pendingTime, timeThreshold = 0, 5, 12
	local buttons, numMinimapChildren = {}, 0
	local removedTextures = {
		[136430] = true,
		[136467] = true,
	}

	local function ReskinMinimapButton(child, name)
		for j = 1, child:GetNumRegions() do
			local region = select(j, child:GetRegions())
			if region:IsObjectType("Texture") then
				local texture = region:GetTexture() or ""
				if removedTextures[texture] or strfind(texture, "Interface\\CharacterFrame") or strfind(texture, "Interface\\Minimap") then
					region:SetTexture(nil)
					region:Hide() -- hide CircleMask
				end
				if not region.__ignored then
					region:ClearAllPoints()
					region:SetAllPoints()
				end
				if not isGoodLookingIcon[name] then
					region:SetTexCoord(unpack(I.TexCoord))
				end
			end
			child:SetSize(34, 34)
			M.CreateSD(child, 3, 3)
		end

		tinsert(buttons, child)
	end

	local function KillMinimapButtons()
		for _, child in pairs(buttons) do
			if not child.styled then
				child:SetParent(bin)
				if child:HasScript("OnDragStop") then child:SetScript("OnDragStop", nil) end
				if child:HasScript("OnDragStart") then child:SetScript("OnDragStart", nil) end
				if child:HasScript("OnClick") then child:HookScript("OnClick", clickFunc) end

				if child:IsObjectType("Button") then
					child:SetHighlightTexture(I.bdTex) -- prevent nil function
					child:GetHighlightTexture():SetColorTexture(1, 1, 1, .25)
				elseif child:IsObjectType("Frame") then
					child.highlight = child:CreateTexture(nil, "HIGHLIGHT")
					child.highlight:SetAllPoints()
					child.highlight:SetColorTexture(1, 1, 1, .25)
				end

				-- Naughty Addons
				local name = child:GetName()
				if name == "DBMMinimapButton" then
					child:SetScript("OnMouseDown", nil)
					child:SetScript("OnMouseUp", nil)
				elseif name == "BagSync_MinimapButton" then
					child:HookScript("OnMouseUp", clickFunc)
				end

				child.styled = true
			end
		end
	end

	local function CollectRubbish()
		local numChildren = Minimap:GetNumChildren()
		if numChildren ~= numMinimapChildren then
			for i = 1, numChildren do
				local child = select(i, Minimap:GetChildren())
				local name = child and child.GetName and child:GetName()
				if name and not child.isExamed and not blackList[name] then
					if (child:IsObjectType("Button") or strmatch(strupper(name), "BUTTON")) and not isButtonIgnored(name) then
						ReskinMinimapButton(child, name)
					end
					child.isExamed = true
				end
			end

			numMinimapChildren = numChildren
		end

		KillMinimapButtons()

		currentIndex = currentIndex + 1
		if currentIndex < timeThreshold then
			C_Timer_After(pendingTime, CollectRubbish)
		end
	end

	local shownButtons = {}
	local function SortRubbish()
		if #buttons == 0 then return end

		wipe(shownButtons)
		for _, button in pairs(buttons) do
			if next(button) and button:IsShown() then -- fix for fuxking AHDB
				tinsert(shownButtons, button)
			end
		end

		local numShown = #shownButtons
		local row = numShown == 0 and 1 or M:Round((numShown + rowMult) / iconsPerRow)
		local newHeight = row*37 + 3
		bin:SetHeight(newHeight)
		tex:SetHeight(newHeight)
		rightLine:SetHeight(newHeight + 2*R.mult)

		for index, button in pairs(shownButtons) do
			button:ClearAllPoints()
			if index == 1 then
				button:SetPoint("BOTTOMRIGHT", bin, -3, 3)
			elseif row > 1 and mod(index, row) == 1 or row == 1 then
				button:SetPoint("RIGHT", shownButtons[index - row], "LEFT", -3, 0)
			else
				button:SetPoint("BOTTOM", shownButtons[index - 1], "TOP", 0, 3)
			end
		end
	end

	bu:SetScript("OnClick", function(_, btn)
		--if btn == "RightButton" then
			--MaoRUIDB["AutoRecycle"] = not MaoRUIDB["AutoRecycle"]
			--updateRecycleTip(bu)
			--bu:GetScript("OnEnter")(bu)
		--else
			if bin:IsShown() then
				clickFunc(1)
			else
				SortRubbish()
				UIFrameFadeIn(bin, .5, 0, 1)
			end
		--end
	end)

	CollectRubbish()
end

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
		if UnitIsUnit(unit, "player") then return end -- ignore player ping
		anim:Stop()
		f.text:SetText(GetUnitName(unit))
		f.text:SetTextColor(M.ClassColor(select(2, UnitClass(unit))))
		anim:Play()
	end)
end

function module:UpdateMinimapScale()
	local size = R.db["Map"]["MinimapSize"]
	local scale = R.db["Map"]["MinimapScale"]
	Minimap:SetSize(size, size)
	Minimap:SetScale(scale)
	if Minimap.mover then
		Minimap.mover:SetSize(size*scale, size*scale)
	end
end

function GetMinimapShape() -- LibDBIcon
	if not module.initialized then
		module:UpdateMinimapScale()
		module.initialized = true
	end
	return "SQUARE"
end

function module:ShowMinimapClock()
	if R.db["Map"]["Clock"] then
		if not TimeManagerClockButton then LoadAddOn("Blizzard_TimeManager") end
		if not TimeManagerClockButton.styled then
			TimeManagerClockButton:DisableDrawLayer("BORDER")
			TimeManagerClockButton:ClearAllPoints()
			TimeManagerClockButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, I.isNewPatch and -2 or -8)
			TimeManagerClockButton:SetFrameLevel(10)
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
			GameTimeFrame:SetNormalTexture("")
			GameTimeFrame:SetPushedTexture("")
			GameTimeFrame:SetHighlightTexture("")
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

local function GetVolumeColor(cur)
	local r, g, b = oUF:RGBColorGradient(cur, 100, 1, 1, 1, 1, .8, 0, 1, 0, 0)
	return r, g, b
end

local function GetCurrentVolume()
	return M:Round(GetCVar("Sound_MasterVolume") * 100)
end

function module:SoundVolume()
	if not R.db["Map"]["EasyVolume"] then return end

	local f = CreateFrame("Frame", nil, Minimap)
	f:SetAllPoints()
	local text = M.CreateFS(f, 30)

	local anim = f:CreateAnimationGroup()
	anim:SetScript("OnPlay", function() f:SetAlpha(1) end)
	anim:SetScript("OnFinished", function() f:SetAlpha(0) end)
	anim.fader = anim:CreateAnimation("Alpha")
	anim.fader:SetFromAlpha(1)
	anim.fader:SetToAlpha(0)
	anim.fader:SetDuration(3)
	anim.fader:SetSmoothing("OUT")
	anim.fader:SetStartDelay(1)

	module.VolumeText = text
	module.VolumeAnim = anim
end

function module:Minimap_OnMouseWheel(zoom)
	if IsControlKeyDown() and module.VolumeText then
		local value = GetCurrentVolume()
		local mult = IsAltKeyDown() and 100 or 5
		value = value + zoom*mult
		if value > 100 then value = 100 end
		if value < 0 then value = 0 end

		SetCVar("Sound_MasterVolume", tostring(value/100))
		module.VolumeText:SetText(value)
		module.VolumeText:SetTextColor(GetVolumeColor(value))
		module.VolumeAnim:Stop()
		module.VolumeAnim:Play()
	else
		if zoom > 0 then
			Minimap_ZoomIn()
		else
			Minimap_ZoomOut()
		end
	end
end

function module:BuildMinimapDropDown()
	local dropdown = CreateFrame("Frame", "UIMiniMapTrackingDropDown", _G.UIParent, "UIDropDownMenuTemplate")
	dropdown:SetID(1)
	dropdown:SetClampedToScreen(true)
	dropdown:Hide()
	dropdown.noResize = true
	_G.UIDropDownMenu_Initialize(dropdown, _G.MiniMapTrackingDropDown_Initialize, "MENU")

	module.MinimapTracking = dropdown
end

function module:Minimap_OnMouseUp(btn)
		if btn == "LeftButton" then 
			if IsAltKeyDown() then ToggleFrame(WorldMapFrame) --Alt+鼠标左键点击显示大地图
			elseif IsShiftKeyDown() then ToggleCalendar() --if InCombatLockdown() then UIErrorsFrame:AddMessage(I.InfoColor..ERR_NOT_IN_COMBAT) return end 
			elseif IsControlKeyDown() then ToggleDropDownMenu(1, nil, UIMiniMapTrackingDropDown, "cursor")
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
	Minimap:SetFrameLevel(10)
	Minimap:SetMaskTexture("Interface\\Buttons\\WHITE8X8")
	DropDownList1:SetClampedToScreen(true)

	local mover = M.Mover(Minimap, U["Minimap"], "Minimap", R.Minimap.Pos)
	Minimap:ClearAllPoints()
	Minimap:SetPoint("TOPRIGHT", mover)
	if I.isNewPatch then
		hooksecurefunc(Minimap, "SetPoint", function(frame, _, parent)
			if parent ~= mover then
				frame:SetPoint("TOPRIGHT", mover)
			end
		end)
	end
	Minimap.mover = mover

	self:UpdateMinimapScale()
	self:ShowMinimapClock()
	self:ShowCalendar()
	self:BuildMinimapDropDown()

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
		"MinimapCompassTexture", -- isNewPatch
	}

	for _, v in pairs(frames) do
		local object = _G[v]
		if object then
			M.HideObject(object)
		end
	end
	MinimapCluster:EnableMouse(false)
	Minimap:SetArchBlobRingScalar(0)
	Minimap:SetQuestBlobRingScalar(0)
	if I.isNewPatch then
		M.HideObject(Minimap.ZoomIn)
		M.HideObject(Minimap.ZoomOut)
		MinimapCluster.Tracking:Hide()
		MinimapCluster.BorderTop:Hide()
		MinimapCluster.ZoneTextButton:Hide()
	end

	-- Add Elements
	self:CreatePulse()
	--self:RecycleBin()
	self:ReskinRegions()
	self:WhoPingsMyMap()
	self:ShowMinimapHelpInfo()
	self:SoundVolume()

	-- HybridMinimap
	M:RegisterEvent("ADDON_LOADED", module.HybridMinimapOnLoad)
end
