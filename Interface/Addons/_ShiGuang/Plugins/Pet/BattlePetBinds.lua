-- Author: Simca@Malfurion   ## Version: v2.29.0

local  BattlePetBinds = {}
local SOBC = _G.SetOverrideBindingClick
local BattlePetBinds_find = string.find
local BattlePetBinds_len = string.len
local BattlePetBinds_lower = string.lower
local BattlePetBinds_sub = string.sub
local BattlePetBinds_tostr = tostring
local BattlePetBinds_upper = string.upper

local BPB_BindState = false
local BattlePetBinds = CreateFrame("FRAME", "BattlePetBinds")
BattlePetBinds:RegisterEvent("ADDON_LOADED")
BattlePetBinds:RegisterEvent("PET_BATTLE_OPENING_START")
BattlePetBinds:RegisterEvent("PET_BATTLE_OPENING_DONE")
BattlePetBinds:RegisterEvent("PET_BATTLE_OVER")
BattlePetBinds:RegisterEvent("PET_BATTLE_CLOSE")

-- shorten binding names for display purposes
function BattlePetBinds.BPB_Shorten(binding)
	
	local text = binding
	local modifiers = ""
	
	-- go here for modifiers
	if BattlePetBinds_len(text) > 3 then
		-- shorten CTRL, ALT, SHIFT, BUTTON, and NUMPAD into single letters
		if BattlePetBinds_find(text, "ALT-") then text = BattlePetBinds_sub(text, BattlePetBinds_find(text, "ALT-") + 4) modifiers = modifiers .. "A" end
		if BattlePetBinds_find(text, "CTRL-") then text = BattlePetBinds_sub(text, BattlePetBinds_find(text, "CTRL-") + 5) modifiers = modifiers .. "C" end
		if BattlePetBinds_find(text, "SHIFT-") then text = BattlePetBinds_sub(text, BattlePetBinds_find(text, "SHIFT-") + 6) modifiers = modifiers .. "S" end
		if BattlePetBinds_find(text, "NUMPAD") then text = BattlePetBinds_sub(text, BattlePetBinds_find(text, "NUMPAD") + 6) modifiers = "N" end
		if BattlePetBinds_find(text, "BUTTON") then text = BattlePetBinds_sub(text, BattlePetBinds_find(text, "BUTTON") + 6) modifiers = "M" end
	end
	
	-- go here for obscure keys only (since modifiers are dealt with)
	if BattlePetBinds_len(text) > 2 then
		-- handle PAGEUP and PAGEDOWN
		if BattlePetBinds_find(text, "PAGEUP") then text = "Up" modifiers = modifiers .. "P" end
		if BattlePetBinds_find(text, "PAGEDOWN") then text = "Dwn" modifiers = modifiers .. "P" end
		
		-- handle MOUSEWHEELUP and MOUSEWHEELDOWN
		if BattlePetBinds_find(text, "MOUSEWHEELUP") then text = "Up" modifiers = "M" end
		if BattlePetBinds_find(text, "MOUSEWHEELDOWN") then text = "Dwn" modifiers = "M" end
		
		-- handle obscure NUMPAD operators
		if BattlePetBinds_find(text, "PLUS") then text = "+" end
		if BattlePetBinds_find(text, "MINUS") then text = "-" end
		if BattlePetBinds_find(text, "MULTIPLY") then text = "*" end
		if BattlePetBinds_find(text, "DIVIDE") then text = "/" end
		if BattlePetBinds_find(text, "DECIMAL") then text = "." end
		
		-- exceptions list for things that look better as 4 letters
		local exceptionsList = { ["HOME"] = true, ["BACKSPACE"] = true, ["CAPSLOCK"] = true, }
		
		-- chop off anything left in strings greater than 3 chars and lowercase everything after the first char if not an exception
		if (BattlePetBinds_len(text) > 2) and (not exceptionsList[text]) then
			text = BattlePetBinds_upper(BattlePetBinds_sub(text, 1, 1)) .. BattlePetBinds_lower(BattlePetBinds_sub(text, 2, 3))
		elseif (BattlePetBinds_len(text) > 3) then
			text = BattlePetBinds_upper(BattlePetBinds_sub(text, 1, 1)) .. BattlePetBinds_lower(BattlePetBinds_sub(text, 2, 4))
		end
	end
	
	text = modifiers .. text
	
	return text
end

-- set up buttons to be clicked on by our new bindings (replaces Bindings.xml)
local function BPB_CreateHotKeys()
	for i = 1, 10 do
		local button = "BPB_HotKey"..i
		CreateFrame("Button", button, nil, "SecureActionButtonTemplate")
	end
	CreateFrame("Button", "BPB_NothingButton", nil, "SecureActionButtonTemplate")
	CreateFrame("Button", "BPB_LongForfeit", nil, "SecureActionButtonTemplate")
	_G["BPB_HotKey1"]:SetScript("OnClick", (function(...)
        StaticPopup_Hide("PET_BATTLE_FORFEIT", nil)
        StaticPopup_Hide("PET_BATTLE_FORFEIT_NO_PENALTY", nil)
        C_PetBattles.UseAbility(1)
    end))
	_G["BPB_HotKey2"]:SetScript("OnClick", (function(...)
        StaticPopup_Hide("PET_BATTLE_FORFEIT", nil)
        StaticPopup_Hide("PET_BATTLE_FORFEIT_NO_PENALTY", nil)
        C_PetBattles.UseAbility(2)
    end))
	_G["BPB_HotKey3"]:SetScript("OnClick", (function(...)
        StaticPopup_Hide("PET_BATTLE_FORFEIT", nil)
        StaticPopup_Hide("PET_BATTLE_FORFEIT_NO_PENALTY", nil)
        C_PetBattles.UseAbility(3)
    end))
	_G["BPB_HotKey4"]:SetScript("OnClick", (function(...)
        StaticPopup_Hide("PET_BATTLE_FORFEIT", nil)
        StaticPopup_Hide("PET_BATTLE_FORFEIT_NO_PENALTY", nil)
        local selectionFrame = PetBattleFrame.BottomFrame.PetSelectionFrame
        local battleState = C_PetBattles.GetBattleState()
        local selectedActionType = C_PetBattles.GetSelectedAction()
        local mustSwap = ((not selectedActionType) or (selectedActionType == BATTLE_PET_ACTION_NONE)) and (battleState == LE_PET_BATTLE_STATE_WAITING_PRE_BATTLE) or (battleState == LE_PET_BATTLE_STATE_WAITING_FOR_FRONT_PETS)
        if (selectionFrame:IsShown() and (not mustSwap)) then
            PetBattlePetSelectionFrame_Hide(selectionFrame)
        else
            PetBattlePetSelectionFrame_Show(selectionFrame)
        end
    end))
	_G["BPB_HotKey5"]:SetScript("OnClick", (function(...)
        local usable = C_PetBattles.IsTrapAvailable()
        if (usable) then
            StaticPopup_Hide("PET_BATTLE_FORFEIT", nil)
            StaticPopup_Hide("PET_BATTLE_FORFEIT_NO_PENALTY", nil)
            C_PetBattles.UseTrap()
        end
    end))
	_G["BPB_HotKey6"]:SetScript("OnClick", (function(...)
        StaticPopup_Hide("PET_BATTLE_FORFEIT", nil)
        StaticPopup_Hide("PET_BATTLE_FORFEIT_NO_PENALTY", nil)
        C_PetBattles.ForfeitGame()
    end))
	_G["BPB_HotKey7"]:SetScript("OnClick", (function(...)
        StaticPopup_Hide("PET_BATTLE_FORFEIT", nil)
        StaticPopup_Hide("PET_BATTLE_FORFEIT_NO_PENALTY", nil)
        C_PetBattles.SkipTurn()
    end))
	_G["BPB_HotKey8"]:SetScript("OnClick", (function(...)
        if (C_PetBattles.CanActivePetSwapOut() and C_PetBattles.CanPetSwapIn(1)) then
            C_PetBattles.ChangePet(1)
            PetBattlePetSelectionFrame_Hide(PetBattleFrame.BottomFrame.PetSelectionFrame)
        end
    end))
	_G["BPB_HotKey9"]:SetScript("OnClick", (function(...)
        if (C_PetBattles.CanActivePetSwapOut() and C_PetBattles.CanPetSwapIn(2)) then
            C_PetBattles.ChangePet(2)
            PetBattlePetSelectionFrame_Hide(PetBattleFrame.BottomFrame.PetSelectionFrame)
        end
    end))
	_G["BPB_HotKey10"]:SetScript("OnClick", (function(...)
        if (C_PetBattles.CanActivePetSwapOut() and C_PetBattles.CanPetSwapIn(3)) then
            C_PetBattles.ChangePet(3)
            PetBattlePetSelectionFrame_Hide(PetBattleFrame.BottomFrame.PetSelectionFrame)
        end
    end))
	_G["BPB_LongForfeit"]:SetScript("OnClick", (function(...)
        if (StaticPopup1:IsVisible()) then
            StaticPopup1Button1:Click()
        else
            local forfeitPenalty = C_PetBattles.GetForfeitPenalty()
            if (forfeitPenalty == 0) then
                StaticPopup_Show("PET_BATTLE_FORFEIT_NO_PENALTY", nil, nil, nil)
            else
                StaticPopup_Show("PET_BATTLE_FORFEIT", forfeitPenalty, nil, nil)
            end
        end
    end))
end

-- set up text indicators for forfeit, pass turn, and pet swapping HotKeys
local function BPB_CreateHotKeyTexts()
	for i = 6, 10 do
		BattlePetBinds:CreateFontString("BPB_HotKeyText"..i, "OVERLAY", "NumberFontNormalSmall")  --NumberFontNormalSmallGray
	end
	_G["BPB_HotKeyText6"]:SetParent(PetBattleFrame.BottomFrame.ForfeitButton)
	_G["BPB_HotKeyText7"]:SetParent(PetBattleFrame.BottomFrame.TurnTimer.SkipButton)
	_G["BPB_HotKeyText8"]:SetParent(PetBattleFrame.BottomFrame.PetSelectionFrame.Pet1)
	_G["BPB_HotKeyText9"]:SetParent(PetBattleFrame.BottomFrame.PetSelectionFrame.Pet2)
	_G["BPB_HotKeyText10"]:SetParent(PetBattleFrame.BottomFrame.PetSelectionFrame.Pet3)
	_G["BPB_HotKeyText6"]:SetPoint("TOPRIGHT", PetBattleFrame.BottomFrame.ForfeitButton, "TOPRIGHT", -1, -3)
	_G["BPB_HotKeyText7"]:SetPoint("TOPRIGHT", PetBattleFrame.BottomFrame.TurnTimer.SkipButton, "TOPRIGHT", -1, -6)
	_G["BPB_HotKeyText8"]:SetPoint("BOTTOMRIGHT", PetBattleFrame.BottomFrame.PetSelectionFrame.Pet1, "BOTTOMRIGHT", -6, 9)
	_G["BPB_HotKeyText9"]:SetPoint("BOTTOMRIGHT", PetBattleFrame.BottomFrame.PetSelectionFrame.Pet2, "BOTTOMRIGHT", -6, 9)
	_G["BPB_HotKeyText10"]:SetPoint("BOTTOMRIGHT", PetBattleFrame.BottomFrame.PetSelectionFrame.Pet3, "BOTTOMRIGHT", -6, 9)
	for i = 6, 10 do
		local fstr = "BPB_HotKeyText"..i
		_G[fstr]:SetJustifyH("RIGHT")
		_G[fstr]:SetHeight(10)
		_G[fstr]:SetWidth(46)
		_G[fstr]:SetText(BattlePetBinds.BPB_Shorten(ShiGuangDB.Bind[i]))
		_G[fstr]:Show()
	end
end

-- update the hotkey texts with the binds in case they've changed and also increase widths slightly
function BattlePetBinds.UpdateHotKeyTexts()
	
	for i = 1, 3 do
		PetBattleFrame.BottomFrame.abilityButtons[i].HotKey:SetText(BattlePetBinds.BPB_Shorten(ShiGuangDB.Bind[i]))
		PetBattleFrame.BottomFrame.abilityButtons[i].HotKey:SetWidth(46)
	end
	
	PetBattleFrame.BottomFrame.SwitchPetButton.HotKey:SetText(BattlePetBinds.BPB_Shorten(ShiGuangDB.Bind[4]))
	PetBattleFrame.BottomFrame.SwitchPetButton.HotKey:SetWidth(46)
	PetBattleFrame.BottomFrame.CatchButton.HotKey:SetText(BattlePetBinds.BPB_Shorten(ShiGuangDB.Bind[5]))
	PetBattleFrame.BottomFrame.CatchButton.HotKey:SetWidth(46)
	for i = 6, 10 do
		local fstr = "BPB_HotKeyText"..i
		_G[fstr]:SetText(BattlePetBinds.BPB_Shorten(ShiGuangDB.Bind[i]))
	end
end

-- set up binds
function BattlePetBinds.SetOverrideBindings()
	-- remove old blizzard bindings
	for i = 1, 5 do
		SOBC(BattlePetBinds, true, BattlePetBinds_tostr(i), "BPB_NothingButton")
	end
	
	-- set up our override binding clicks
	for i = 1, 10 do
		local button = "BPB_HotKey"..i
		SOBC(BattlePetBinds, true, ShiGuangDB.Bind[i], button)
	end
	
	-- set up "confirm forfeit" bind if the user wants it
	if (ShiGuangDB.ForfeitCheck) then
		SOBC(BattlePetBinds, true, ShiGuangDB.Bind[6], "BPB_LongForfeit")
	end
	
	-- tell the boolean we have set our bindings
	BPB_BindState = true
end

-- event handler function
local function BattlePetBinds_OnEvent(self, event, ...)

	-- if this addon loads then
	if (event == "ADDON_LOADED") and (... == "_ShiGuang") then
		
		-- create SavedVariables table using default values if not already found
		--if (not ShiGuangDB) then ShiGuangDB = {} end
		if (not ShiGuangDB.ForfeitCheck) then ShiGuangDB.ForfeitCheck = false end
		if (not ShiGuangDB.Bind) then
			ShiGuangDB.Bind = {
				"1", -- Attack #1
				"2", -- Attack #2
				"3", -- Attack #3
				"4", -- accessing the Swap Pet Menu
				"5", -- throwing traps
				"F", -- forfeiting
				"T", -- passing your turn
				"F1", -- swapping to Pet #1
				"F2", -- swapping to Pet #2
				"F3", -- swapping to Pet #3
			}
		end
		
		for i = 1, 10 do
			_G["BPBConfigButton"..i]:SetText(BattlePetBinds.BPB_Desc[i] .. "的按键：" .. BattlePetBinds.BPB_Shorten(ShiGuangDB.Bind[i]))
		end
		
		-- set checkbox to status of ForfeitCheck
		BPBConfigForfeitBox:SetChecked(ShiGuangDB.ForfeitCheck)
		
		-- create and bind hotkeys if we're not in combat and we're in a pet battle
		if not InCombatLockdown() and C_PetBattles.IsInBattle() then
			
			-- create hotkey frames and hotkey text frames (because we know they don't exist at addon load)
			BPB_CreateHotKeys()
			BPB_CreateHotKeyTexts()

			-- set up bindings
			BattlePetBinds.SetOverrideBindings()
			
			-- register combat enter/exit events
			BattlePetBinds:RegisterEvent("PLAYER_REGEN_ENABLED")
			BattlePetBinds:RegisterEvent("PLAYER_REGEN_DISABLED")
		end
	
	-- if we start a pet battle and are not in combat then (checking both opening events to account for Blizzard event misfire bug)
	elseif ((event == "PET_BATTLE_OPENING_START") or (event == "PET_BATTLE_OPENING_DONE")) and not InCombatLockdown() then
		
		-- create hotkey frames if they don't exist
		if not BPB_HotKey1 then
			BPB_CreateHotKeys()
		end
		
		-- create hotkey text frames if they don't exist
		if not BPB_HotKeyText1 then
			BPB_CreateHotKeyTexts()
		end
		
		-- update existing hotkey texts
		BattlePetBinds.UpdateHotKeyTexts()

		-- set up bindings
		BattlePetBinds.SetOverrideBindings()
		
		-- register combat enter/exit events
		BattlePetBinds:RegisterEvent("PLAYER_REGEN_ENABLED")
		BattlePetBinds:RegisterEvent("PLAYER_REGEN_DISABLED")
		
	-- if the pet battle ends then (checking both closing events to account for Blizzard event misfire bug) OR is interrupted by combat
	elseif BPB_BindState and ((event == "PET_BATTLE_OVER") or (event == "PET_BATTLE_CLOSE") or (event == "PLAYER_REGEN_ENABLED") or (event == "PLAYER_REGEN_DISABLED")) then
		-- remove our bindings
		ClearOverrideBindings(BattlePetBinds)
		
		-- tell the boolean that we have removed our bindings
		BPB_BindState = false
		
		-- unregister combat enter/exit events
		BattlePetBinds:UnregisterEvent("PLAYER_REGEN_ENABLED")
		BattlePetBinds:UnregisterEvent("PLAYER_REGEN_DISABLED")
	end
end

if GetLocale() == "zhCN" then
  BattlePetBindsLocal = "|cFFBF00FF[宠物]|r按键绑定";
elseif GetLocale() == "zhTW" then
  BattlePetBindsLocal = "|cFFBF00FF[宠物]|r按键绑定";
else
  BattlePetBindsLocal = "BattlePetBinds";
end

-- create slash commands
SLASH_BATTLEPETBINDS1 = "/battlepetbinds"
SLASH_BATTLEPETBINDS2 = "/bpbinds"
SLASH_BATTLEPETBINDS3 = "/petbinds"
SlashCmdList["BATTLEPETBINDS"] = function(msg)
	Settings.OpenToCategory(BattlePetBindsLocal)
end

-- set our event handler function
BattlePetBinds:SetScript("OnEvent", BattlePetBinds_OnEvent)
-- THERE IS NO NEED TO MODIFY THIS FILE NOW.
-- ALL SETTINGS ARE IN-GAME UNDER ESCAPE --> INTERFACE --> ADDONS --> BATTLEPETBINDS

------------------------------
-- Author: Simca@Malfurion  --
------------------------------

-- Thanks to Ro for inspiration (and the title/version/description code) for the overall structure of this Options panel

-- localize addon namespace

-- current button variable for masterframe config
local currID

BattlePetBinds.BPB_Desc = { -- local text variable to help ease implementation of foreign localizations (at a later stage if ever)
	"一号技能",
	"二号技能",
	"三号技能",
	"切换宠物菜单",
	"放置陷阱",
	"认输",
	"跳过回合",
	"切换到一号宠物",
	"切换到二号宠物",
	"切换到三号宠物",
}
BattlePetBinds.masterTransfer = false

local Options = CreateFrame("Frame")
local properName = BattlePetBindsLocal

local function CreateFont(fontName, r, g, b, anchorPoint, relativeTo, relativePoint, cx, cy, xoff, yoff, text)
	local font = Options:CreateFontString(nil, "BACKGROUND", fontName)
	font:SetJustifyH("LEFT")
	font:SetJustifyV("TOP")
	if type(r) == "string" then -- r is text, no positioning
		text = r
	else
		if r then
			font:SetTextColor(r, g, b, 1)
		end
		font:SetSize(cx, cy)
		font:SetPoint(anchorPoint, relativeTo, relativePoint, xoff, yoff)
	end
	font:SetText(text)
	return font
end

local title = CreateFont("GameFontNormalLarge", properName)
title:SetPoint("TOPLEFT", 16, -16)
local ver = CreateFont("GameFontNormalSmall", "版本 v2.29.0")
ver:SetPoint("BOTTOMLEFT", title, "BOTTOMRIGHT", 4, 0)
local auth = CreateFont("GameFontNormalSmall", "来自于 Simca")
auth:SetPoint("BOTTOMLEFT", ver, "BOTTOMRIGHT", 3, 0)
local desc = CreateFont("GameFontHighlight", nil, nil, nil, "TOPLEFT", title, "BOTTOMLEFT" , 580, 40, 0, -8, "允许用户轻松定义所有宠物对战功能（包括跳过回合、更换宠物和认输）的自定义按键绑定的插件，而不会覆盖非宠物对战的按键绑定！")

-- create and hide the master keybind accepting frame
local masterFrame = CreateFrame("Button", "BPBConfigMaster", Options)

-- transfer the key being rebound from one key to another (this occurs when 
local function masterFrame_TransferBurden()
	for i = 1, 10 do
		_G["BPBConfigButton"..i]:SetText(BattlePetBinds.BPB_Desc[i] .. "的按键：" .. BattlePetBinds.BPB_Shorten(ShiGuangDB.Bind[i]))
	end
	
	_G["BPBConfigButton"..currID]:SetText("请为" ..  BattlePetBinds.BPB_Desc[currID] .. "输入新的按键！")
	
	BattlePetBinds.masterTransfer = true
end

-- hide the masterFrame (so that input can be accepted once again)
local function BPB_HideMasterFrame()
	masterFrame:SetFrameStrata("HIGH")
	masterFrame:UnregisterEvent("PLAYER_REGEN_DISABLED")
	masterFrame:UnlockHighlight()
	masterFrame:EnableKeyboard(false)
	masterFrame:EnableMouse(false)
	masterFrame:EnableMouseWheel(false)
	masterFrame:SetHeight(1)
	masterFrame:SetWidth(1)
	masterFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT")
	
	BattlePetBinds.masterTransfer = false
	
	masterFrame:Hide()
	
	--[[masterFrame:SetScript("OnKeyDown", nil)
	masterFrame:SetScript("OnMouseDown", nil)
	masterFrame:SetScript("OnMouseWheel", nil)]]--
	
	_G["BPBConfigButton"..currID]:SetText(BattlePetBinds.BPB_Desc[currID] .. "的按键：" .. BattlePetBinds.BPB_Shorten(ShiGuangDB.Bind[currID]))
	currID = 0
end

-- accept keybinds into the masterFrame when it is enabled
local function masterFrame_OnKeyDown(self, key)
	-- thanks to the authors of AceGUI-3.0 for this line of code and idea
	local testkey = key
	local ignoreKeys = { ["UNKNOWN"] = true, ["LSHIFT"] = true, ["LCTRL"] = true, ["LALT"] = true, ["RSHIFT"] = true, ["RCTRL"] = true, ["RALT"] = true, ["PRINTSCREEN"] = true, }
	
	if (ignoreKeys[testkey]) then return end
	
	if (testkey == "ESCAPE") and (not BattlePetBinds.masterTransfer) then
		BPB_HideMasterFrame()
		return
	elseif (testkey == "ESCAPE") then
		return
	end
	
	if IsShiftKeyDown() then testkey = "SHIFT-"..testkey end
	if IsControlKeyDown() then testkey = "CTRL-"..testkey end
	if IsAltKeyDown() then testkey = "ALT-"..testkey end
	
	local duplicate = false
	for i = 1, 10 do
		if (ShiGuangDB.Bind[i] == testkey) then duplicate = i break end
	end
	
	if duplicate then
		ShiGuangDB.Bind[currID] = testkey
		currID = duplicate
		masterFrame_TransferBurden()
	else
		ShiGuangDB.Bind[currID] = testkey
		BPB_HideMasterFrame()
	end
end

-- accept mousebinds into the masterFrame when it is enabled
local function masterFrame_OnMouseDown(self, button)
	--if IsShiftKeyDown() then button = "SHIFT-"..button end
	--if IsControlKeyDown() then button = "CTRL-"..button end
	--if IsAltKeyDown() then button = "ALT-"..button end
	local testkey = button
	
	if ( testkey == "LeftButton" ) then
		testkey = "BUTTON1"
	elseif ( testkey == "RightButton" ) then
		testkey = "BUTTON2"
	elseif ( testkey == "MiddleButton" ) then
		testkey = "BUTTON3"
	else
		testkey = BattlePetBinds_upper(testkey)
	end
	
	local duplicate = false
	for i = 1, 10 do
		if (ShiGuangDB.Bind[i] == testkey) then duplicate = i break end
	end
	
	if duplicate then
		ShiGuangDB.Bind[currID] = testkey
		currID = duplicate
		masterFrame_TransferBurden()
	else
		ShiGuangDB.Bind[currID] = testkey
		BPB_HideMasterFrame()
	end
end

-- accept mousewheelbinds into the masterFrame when it is enabled
local function masterFrame_OnMouseWheel(self, delta)
	--if IsShiftKeyDown() then delta = "SHIFT-"..delta end
	--if IsControlKeyDown() then delta = "CTRL-"..delta end
	--if IsAltKeyDown() then delta = "ALT-"..delta end
	local testkey = delta
	
	if testkey == 1 then
		testkey = "MOUSEWHEELUP"
	elseif (testkey == -1) then
		testkey = "MOUSEWHEELDOWN"
	end
	
	local duplicate = false
	for i = 1, 10 do
		if (ShiGuangDB.Bind[i] == testkey) then duplicate = i break end
	end
	
	if duplicate then
		ShiGuangDB.Bind[currID] = testkey
		currID = duplicate
		masterFrame_TransferBurden()
	else
		ShiGuangDB.Bind[currID] = testkey
		BPB_HideMasterFrame()
	end
end

masterFrame:SetScript("OnKeyDown", masterFrame_OnKeyDown)
masterFrame:SetScript("OnMouseDown", masterFrame_OnMouseDown)
masterFrame:SetScript("OnMouseWheel", masterFrame_OnMouseWheel)
masterFrame:Hide()

-- effectively this is the "ShowMasterFrame()" function
local function BPBConfigButton_OnClick(self, ...)
	if InCombatLockdown() then return end
	masterFrame:SetFrameStrata("FULLSCREEN_DIALOG")
	masterFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	masterFrame:LockHighlight()
	--masterFrame:EnableMouse(true)
	--masterFrame:EnableMouseWheel(true)
	masterFrame:EnableKeyboard(true)
	masterFrame:SetHeight(UIParent:GetHeight())
	masterFrame:SetWidth(UIParent:GetWidth())
	masterFrame:SetPoint("CENTER", UIParent, "CENTER")
	masterFrame:SetScript("OnKeyDown", masterFrame_OnKeyDown)
	masterFrame:SetScript("OnMouseDown", masterFrame_OnMouseDown)
	masterFrame:SetScript("OnMouseWheel", masterFrame_OnMouseWheel)
	
	BattlePetBinds.masterTransfer = true
	
	masterFrame:Show()
	
	currID = self:GetID()
	self:SetText("请为" ..  BattlePetBinds.BPB_Desc[currID] .. "输入新的按键！")
end

-- create the 10 UI buttons
for i = 1, 10 do
	local currentbutton = "BPBConfigButton" .. i
	CreateFrame("Button", currentbutton, Options, "UIPanelButtonTemplate")
	if (i == 1) then
		_G[currentbutton]:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 20, -40)
	else
		_G[currentbutton]:SetPoint("TOPLEFT", _G["BPBConfigButton" .. (i - 1)], "BOTTOMLEFT", 0, -10)
	end
	_G[currentbutton]:SetID(i)
	_G[currentbutton]:SetNormalFontObject("GameFontNormal")
	_G[currentbutton]:SetScript("OnClick", BPBConfigButton_OnClick)
	_G[currentbutton]:SetWidth(320)
end

-- create checkbox
local checkbox = CreateFrame("CheckButton", "BPBConfigForfeitBox", Options, "UICheckButtonTemplate")
checkbox:SetPoint("BOTTOMLEFT", Options, "BOTTOMLEFT", 64, 64)
checkbox:SetSize(32, 32)
checkbox.text:SetFontObject("GameFontNormal")
checkbox.text:SetText(" 当按下认输按键时需要二次确认")

-- OnClick for checkbox
local function BPBConfigForfeitBox_OnClick(self, button, down)
	ShiGuangDB.ForfeitCheck = BPBConfigForfeitBox:GetChecked()
end
	
-- hide masterFrame in combat
local function masterFrame_OnEvent(self, event, ...)
	if (event == "PLAYER_REGEN_DISABLED") then
		BPB_HideMasterFrame()
	end
end

-- defaults
function Options.OnDefault()
	if masterFrame:IsShown() then BPB_HideMasterFrame() end
	ShiGuangDB.Bind = {
		"1", -- Attack #1
		"2", -- Attack #2
		"3", -- Attack #3
		"4", -- accessing the Swap Pet Menu
		"5", -- throwing traps
		"F", -- forfeiting
		"T", -- passing your turn
		"F1", -- swapping to Pet #1
		"F2", -- swapping to Pet #2
		"F3", -- swapping to Pet #3
	}
	
	for i = 1, 10 do
		_G["BPBConfigButton"..i]:SetText(BattlePetBinds.BPB_Desc[i] .. "的按键：" .. BattlePetBinds.BPB_Shorten(ShiGuangDB.Bind[i]))
	end
end

-- update hotkeys when okay is pressed if in battle
function Options.OnCommit()
	if not InCombatLockdown() and C_PetBattles.IsInBattle() then
		BattlePetBinds.UpdateHotKeyTexts()
		BattlePetBinds.SetOverrideBindings()
	end
end

-- refresh function (empty)
function Options.OnRefresh() end

-- set script for checkbox
BPBConfigForfeitBox:SetScript("OnClick", BPBConfigForfeitBox_OnClick)

-- Add the Options panel to the Blizzard list
local category = Settings.RegisterCanvasLayoutCategory(Options, properName, properName)
category.ID = BattlePetBindsLocal
Settings.RegisterAddOnCategory(category)
