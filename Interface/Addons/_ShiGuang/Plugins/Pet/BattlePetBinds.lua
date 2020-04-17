-- Author: Simca@Malfurion   ## Version: r18

local SOBC = _G.SetOverrideBindingClick

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
		_G[fstr]:SetText(BPBindOptions_Bind[i])
		_G[fstr]:Show()
	end
end

-- update the hotkey texts with the binds in case they've changed and also increase widths slightly
function UpdateHotKeys()
	for i = 1, 3 do
		PetBattleFrame.BottomFrame.abilityButtons[i].HotKey:SetText(BPBindOptions_Bind[i])
		PetBattleFrame.BottomFrame.abilityButtons[i].HotKey:SetWidth(46)
	end
	PetBattleFrame.BottomFrame.SwitchPetButton.HotKey:SetText(BPBindOptions_Bind[4])
	PetBattleFrame.BottomFrame.SwitchPetButton.HotKey:SetWidth(46)
	PetBattleFrame.BottomFrame.CatchButton.HotKey:SetText(BPBindOptions_Bind[5])
	PetBattleFrame.BottomFrame.CatchButton.HotKey:SetWidth(46)
	for i = 6, 10 do
		local fstr = "BPB_HotKeyText"..i
		_G[fstr]:SetText(BPBindOptions_Bind[i])
	end
end


local BattlePetBinds = CreateFrame("FRAME", "BattlePetBinds")
BattlePetBinds:RegisterEvent("ADDON_LOADED")
BattlePetBinds:RegisterEvent("PET_BATTLE_OPENING_START")
BattlePetBinds:RegisterEvent("PET_BATTLE_OPENING_DONE")
BattlePetBinds:RegisterEvent("PET_BATTLE_OVER")
BattlePetBinds:RegisterEvent("PET_BATTLE_CLOSE")
local BPB_BindState = false
-- set our event handler function
BattlePetBinds:SetScript("OnEvent", function(self, event, ...) -- event handler function
	if (event == "ADDON_LOADED") and (... == "_ShiGuang") then
			BPBindOptions_Bind = {
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
		if not InCombatLockdown() and C_PetBattles.IsInBattle() then
			BPB_CreateHotKeys()
			BPB_CreateHotKeyTexts()
			for i = 1, 5 do
				SOBC(BattlePetBinds, true, tostring(i), "BPB_NothingButton")
			end
			for i = 1, 10 do
				SOBC(BattlePetBinds, true, BPBindOptions_Bind[i], "BPB_HotKey"..i)
			end
			BPB_BindState = true
			BattlePetBinds:RegisterEvent("PLAYER_REGEN_ENABLED")
			BattlePetBinds:RegisterEvent("PLAYER_REGEN_DISABLED")
		end
	elseif ((event == "PET_BATTLE_OPENING_START") or (event == "PET_BATTLE_OPENING_DONE")) and not InCombatLockdown() then
		if not BPB_HotKey1 then BPB_CreateHotKeys() end
		if not BPB_HotKeyText1 then BPB_CreateHotKeyTexts() end
		UpdateHotKeys()
		for i = 1, 5 do
			SOBC(BattlePetBinds, true, tostring(i), "BPB_NothingButton")
		end
		for i = 1, 10 do
			SOBC(BattlePetBinds, true, BPBindOptions_Bind[i], "BPB_HotKey"..i)
		end
		BPB_BindState = true
		BattlePetBinds:RegisterEvent("PLAYER_REGEN_ENABLED")
		BattlePetBinds:RegisterEvent("PLAYER_REGEN_DISABLED")
	elseif BPB_BindState and ((event == "PET_BATTLE_OVER") or (event == "PET_BATTLE_CLOSE") or (event == "PLAYER_REGEN_ENABLED") or (event == "PLAYER_REGEN_DISABLED")) then
		ClearOverrideBindings(BattlePetBinds)
		BPB_BindState = false
		BattlePetBinds:UnregisterEvent("PLAYER_REGEN_ENABLED")
		BattlePetBinds:UnregisterEvent("PLAYER_REGEN_DISABLED")
	end
end)
