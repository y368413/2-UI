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

function module:CreatePulse()
	local bg = M.SetBD(Minimap)
	bg:SetFrameStrata("BACKGROUND")

	if not R.db["Map"]["CombatPulse"] then return end

	local MinimapMailFrame = MinimapCluster.IndicatorFrame.MailFrame
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
			if C_Calendar.GetNumPendingInvites() > 0 or MinimapMailFrame:IsShown() then
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

	MinimapMailFrame:HookScript("OnHide", function()
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
	local garrMinimapButton = _G.ExpansionLandingPageMinimapButton
	if garrMinimapButton then
		local binSettled
		local function updateMinimapButtons(self)
			self:ClearAllPoints()
		self:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 8, -8)
		self:SetScale(0.6)
		--self:GetNormalTexture():SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\2UI")
		--self:GetPushedTexture():SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\2UI")
		--self:GetHighlightTexture():SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\2UI")
		--self:SetSize(30, 30)
	
			--if self:IsShown() and not binSettled then
					--RecycleBinToggleButton:SetPoint("BOTTOMRIGHT", -18, -6)
				--binSettled = true
			--end
		end
		updateMinimapButtons(garrMinimapButton)
		garrMinimapButton:HookScript("OnShow", updateMinimapButtons)
		hooksecurefunc(garrMinimapButton, "UpdateIcon", updateMinimapButtons)
	
		local menuList = {
			{text =	_G.GARRISON_TYPE_9_0_LANDING_PAGE_TITLE, func = ToggleLandingPage, arg1 = Enum.GarrisonType.Type_9_0_Garrison, notCheckable = true},
			{text =	_G.WAR_CAMPAIGN, func = ToggleLandingPage, arg1 = Enum.GarrisonType.Type_8_0_Garrison, notCheckable = true},
			{text =	_G.ORDER_HALL_LANDING_PAGE_TITLE, func = ToggleLandingPage, arg1 = Enum.GarrisonType.Type_7_0_Garrison, notCheckable = true},
			{text =	_G.GARRISON_LANDING_PAGE_TITLE, func = ToggleLandingPage, arg1 = Enum.GarrisonType.Type_6_0_Garrison, notCheckable = true},
		}
		garrMinimapButton:HookScript("OnMouseDown", function(self, btn)
			if btn == "RightButton" then
				if _G.GarrisonLandingPage and _G.GarrisonLandingPage:IsShown() then
					HideUIPanel(_G.GarrisonLandingPage)
				end
				if _G.ExpansionLandingPage and _G.ExpansionLandingPage:IsShown() then
					HideUIPanel(_G.ExpansionLandingPage)
				end
				EasyMenu(menuList, M.EasyMenu, self, -80, 0, "MENU", 1)
			end
		end)
		garrMinimapButton:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_LEFT")
			GameTooltip:SetText(self.title, 1, 1, 1)
			GameTooltip:AddLine(self.description, nil, nil, nil, true)
			GameTooltip:AddLine(U["SwitchGarrisonType"], nil, nil, nil, true)
			GameTooltip:Show();
		end)
	end

	-- QueueStatus Button
	QueueStatusButton:SetParent(Minimap)
	QueueStatusButton:ClearAllPoints()
	QueueStatusButton:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 3, 3)
	QueueStatusButton:SetFrameLevel(999)
	QueueStatusButton:SetSize(30, 30)
	QueueStatusButtonIcon:SetAlpha(0)
	QueueStatusFrame:ClearAllPoints()
	QueueStatusFrame:SetPoint("TOPRIGHT", QueueStatusButton, "TOPRIGHT")

	hooksecurefunc(QueueStatusButton, "SetPoint", function(button, _, _, _, x, y)
		if not (x == 3 and y == 3) then
			button:ClearAllPoints()
			button:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 3, 3)
		end
	end)

	local queueIcon = Minimap:CreateTexture(nil, "ARTWORK")
	queueIcon:SetPoint("CENTER", QueueStatusButton)
	queueIcon:SetSize(50, 50)
	queueIcon:SetAtlas("Raid")
	local anim = queueIcon:CreateAnimationGroup()
	anim:SetLooping("REPEAT")
	anim.rota = anim:CreateAnimation("Rotation")
	anim.rota:SetDuration(2)
	anim.rota:SetDegrees(360)
	hooksecurefunc(QueueStatusFrame, "Update", function()
		queueIcon:SetShown(QueueStatusButton:IsShown())
	end)
	hooksecurefunc(QueueStatusButton.Eye, "PlayAnim", function() anim:Play() end)
	-- default anger red eye
	hooksecurefunc(QueueStatusButton.Eye, "StartPokeAnimationInitial", function() anim.rota:SetDuration(.5)	end)
	hooksecurefunc(QueueStatusButton.Eye, "StartPokeAnimationEnd", function() anim.rota:SetDuration(2) end)

	-- Difficulty Flags
	local instDifficulty = MinimapCluster.InstanceDifficulty
	if instDifficulty then
		local function updateFlagAnchor(frame, _, _, _, _, _, force)
			if force then return end
			frame:ClearAllPoints()
			frame:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -2, 2, true)
		end
		instDifficulty:SetParent(Minimap)
		instDifficulty:SetScale(.7)
		updateFlagAnchor(instDifficulty)
		hooksecurefunc(instDifficulty, "SetPoint", updateFlagAnchor)

		local function replaceFlag(self)
			self:SetTexture(I.flagTex)
		end
		local function reskinDifficulty(frame)
			if not frame then return end
			frame.Border:Hide()
			replaceFlag(frame.Background)
			hooksecurefunc(frame.Background, "SetAtlas", replaceFlag)
		end
		reskinDifficulty(instDifficulty.Default)
		reskinDifficulty(instDifficulty.Guild)
		reskinDifficulty(instDifficulty.ChallengeMode)
	end

	-- Mail and crafing icon
	local function updateMapAnchor(frame, _, _, _, _, _, force)
		if force then return end
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 0, 0, true)
	end
	local indicatorFrame = MinimapCluster.IndicatorFrame
	if indicatorFrame then
		updateMapAnchor(indicatorFrame)
		hooksecurefunc(indicatorFrame, "SetPoint", updateMapAnchor)
		indicatorFrame:SetFrameLevel(11)
	end

	-- Invites Icon
	GameTimeCalendarInvitesTexture:ClearAllPoints()
	GameTimeCalendarInvitesTexture:SetParent(Minimap)
	GameTimeCalendarInvitesTexture:SetPoint("TOPRIGHT")

	local Invt = CreateFrame("Button", nil, UIParent)
	Invt:SetPoint("TOPRIGHT", Minimap, "BOTTOMLEFT", -20, -20)
	Invt:SetSize(250, 80)
	Invt:Hide()
	M.SetBD(Invt)
	M.CreateFS(Invt, 16, I.InfoColor..GAMETIME_TOOLTIP_CALENDAR_INVITES)

	local lastInv = 0
	local function updateInviteVisibility()
		local thisTime = GetTime()
		if thisTime - lastInv > 1 then
			lastInv = thisTime
			Invt:SetShown(C_Calendar.GetNumPendingInvites() > 0)
		end
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
        --func = function() if (not PlayerTalentFrame) then C_AddOns.LoadAddOn('Blizzard_TalentUI') end
        --if (not GlyphFrame) then C_AddOns.LoadAddOn('Blizzard_GlyphUI') end
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
         --func = function() C_AddOns.LoadAddOn('Blizzard_Calendar') Calendar_Toggle() end, notCheckable = true},
    --{ text = BLIZZARD_STORE, icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster',
         --func = function() C_AddOns.LoadAddOn('Blizzard_StoreUI') securecall(ToggleStoreUI) end, notCheckable = true},
    --{ text = GAMEMENU_HELP, icon = 'Interface\\CHATFRAME\\UI-ChatIcon-Blizz',
         --func = function() ToggleFrame(HelpFrame) end, notCheckable = true},
    --{ text = BATTLEFIELD_MINIMAP,
         --func = function() securecall(ToggleBattlefieldMinimap) end, notCheckable = true},
    { text = "|cffff8800 ------------------------|r", notCheckable = true },
    { text = "           -|cFFFFFF00 2|r|cFFFF0000 UI |r- ", isTitle = true, notCheckable = true},
    { text = "|cffff8800 ------------------------|r", notCheckable = true },
    --{ text = MINIMAP_MENU_BARSTYLE,  icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster',
         --func = function() SenduiCmd("/mr");  end, notCheckable = true},
    { text = MINIMAP_MENU_KEYBIND, icon = 'Interface\\MacroFrame\\MacroFrame-Icon.blp',
        func = function() SenduiCmd("/Keybind"); end, notCheckable = true},
    { text = "|cFF00DDFF ----- "..BINDING_NAME_MOVEANDSTEER.." -----|r", isTitle = true, notCheckable = true },
    { text = MINIMAP_MENU_SPECIALBUTTON, icon = 'Interface\\Icons\\INV_Inscription_RunescrollOfFortitude_Red',
        func = function() SenduiCmd("/moveit"); end, notCheckable = true},
    { text = MINIMAP_MENU_AURADIY, icon = 'Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Shield',
        func = function() SenduiCmd("/awc"); end, notCheckable = true},
    --{ text = MINIMAP_MENU_QUESTBUTTON, icon = 'Interface\\GossipFrame\\ActiveQuestIcon',
        --func = function() SenduiCmd("/eqb"); end, notCheckable = true},
    --{ text = MINIMAP_MENU_CASTBAR, icon = 'Interface\\Icons\\INV_Misc_Bone_HumanSkull_02',
        --func = function() SenduiCmd("/cbs"); end, notCheckable = true},
    { text = MINIMAP_MENU_DAMAGESTYLE, icon = 'Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle',
        func = function() SenduiCmd("/dex"); end, notCheckable = true },
    { text = MINIMAP_MENU_DOOMCOOLDOWN, icon = 'Interface\\Icons\\Spell_Nature_Earthbind',
        func = function() SenduiCmd("/dcp"); end, notCheckable = true},
    { text = "传送助手", icon = 'Interface\\Calendar\\UI-Calendar-Button',
        func = function() SenduiCmd("/tomeofteleport"); end, notCheckable = true},
    --{ text = "|cFF00DDFF ------- "..MINIMAP_MENU_ONOFF.." -------|r", isTitle = true, notCheckable = true},
    --{ text = MINIMAP_MENU_INTERRUPT, icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster',
        --func = function() SenduiCmd("/esi"); end, notCheckable = true},
    --{text = MINIMAP_MENU_DISTANCE, hasArrow = true, notCheckable = true,
        --menuList={  
            --{ text = YES, func = function() SenduiCmd("/hardyards sho") end, notCheckable = true},
            --{ text = NO, func = function() SenduiCmd("/hardyards hid") end, notCheckable = true}
        --}
    --},
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
    { text = MINIMAP_MENU_AFKSCREEN, icon = 'Interface\\Icons\\Spell_Nature_Sentinal',
        func = function() SenduiCmd("/wallpaperkit"); end, notCheckable = true},
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
		if UnitIsUnit(unit, "player") then return end -- ignore player ping
		anim:Stop()
		f.text:SetText(GetUnitName(unit))
		f.text:SetTextColor(M.ClassColor(select(2, UnitClass(unit))))
		anim:Play()
	end)
end

function module:UpdateMinimapScale()
	if R.db["Map"]["DisableMinimap"] then return end

	local size = R.db["Map"]["MinimapSize"]
	local scale = R.db["Map"]["MinimapScale"]
	Minimap:SetSize(size, size)
	Minimap:SetScale(scale)
	if Minimap.mover then
		Minimap.mover:SetSize(size*scale, size*scale)
	end
end

function M:GetMinimapShape()
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
			TimeManagerClockButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -2)
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
	f:SetFrameLevel(999)
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

function module:Minimap_OnMouseUp(btn)
		if btn == "LeftButton" then 
			if IsAltKeyDown() then ToggleFrame(WorldMapFrame) --Alt+鼠标左键点击显示大地图
			elseif IsShiftKeyDown() then ToggleCalendar() --if InCombatLockdown() then UIErrorsFrame:AddMessage(I.InfoColor..ERR_NOT_IN_COMBAT) return end 
			elseif IsControlKeyDown() then
			    Minimap:OnClick()--鼠标左键点击小地图显示Ping位置提示
			else 
			  local button = MinimapCluster.Tracking.Button
				if button then
					button:OpenMenu()
					if button.menu then button.menu:ClearAllPoints() button.menu:SetPoint("CENTER", self, -100, 100) end
				end
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
	targetPoint = HelpTip.Point.LeftEdgeCenter,
	onAcknowledgeCallback = M.HelpInfoAcknowledge,
	callbackArg = "MinimapInfo",
	alignment = 3,
}

function module:ShowMinimapHelpInfo()
	Minimap:HookScript("OnEnter", function()
		if not MaoRUISetDB["Help"]["MinimapInfo"] then
			HelpTip:Show(MinimapCluster, minimapInfo)
		end
	end)
end

function module:SetupMinimap()
	if C_AddOns.IsAddOnLoaded("SexyMap") then R.db["Map"]["DisableMinimap"] = true end
	if R.db["Map"]["DisableMinimap"] then return end

	-- Shape and Position
	Minimap:SetFrameLevel(10)
	Minimap:SetMaskTexture("Interface\\Buttons\\WHITE8X8")
	DropDownList1:SetClampedToScreen(true)

	local mover = M.Mover(Minimap, U["Minimap"], "Minimap", R.Minimap.Pos)
	Minimap:ClearAllPoints()
	Minimap:SetPoint("TOPRIGHT", mover)
	hooksecurefunc(Minimap, "SetPoint", function(frame, _, _, _, _, _, force)
		if force then return end
		frame:ClearAllPoints()
		frame:SetPoint("TOPRIGHT", mover, "TOPRIGHT", 0, 0, true)
	end)

	Minimap.mover = mover

	self:UpdateMinimapScale()
	self:ShowMinimapClock()
	self:ShowCalendar()

	-- Minimap clicks
	Minimap:EnableMouseWheel(true)
	Minimap:SetScript("OnMouseWheel", module.Minimap_OnMouseWheel)
	Minimap:SetScript("OnMouseUp", module.Minimap_OnMouseUp)

	-- Hide Blizz
	MinimapCluster:EnableMouse(false)
	MinimapCluster.BorderTop:Hide()
	MinimapCluster.ZoneTextButton:Hide()
	Minimap:SetArchBlobRingScalar(0)
	Minimap:SetQuestBlobRingScalar(0)
	M.HideObject(Minimap.ZoomIn)
	M.HideObject(Minimap.ZoomOut)
	M.HideObject(MinimapCompassTexture)

	_G.MinimapCluster.Tracking:SetAlpha(0)
	_G.MinimapCluster.Tracking:SetScale(0.0001)


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
