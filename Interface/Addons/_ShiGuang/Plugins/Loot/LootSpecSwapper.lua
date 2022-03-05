--## Author: Cilraaz ## Version: 9.2.0.01
local LootSpecSwapper = {}

function LSS_CreateOptionsPanel()

  -- Create Main Panel
  local configFrame = CreateFrame('Frame', 'LSSConfigFrame', InterfaceOptionsFramePanelContainer)
  configFrame:Hide()
  configFrame.name = 'Loot Spec Swapper'
  InterfaceOptions_AddCategory(configFrame)

  -- Create Title
  local titleLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
  titleLabel:SetPoint('TOPLEFT', configFrame, 'TOPLEFT', 16, -16)
  titleLabel:SetText('Loot Spec Swapper')

  -- Version Info
  local versionLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
  versionLabel:SetPoint('BOTTOMLEFT', titleLabel, 'BOTTOMRIGHT', 8, 0)
  versionLabel:SetText('9.2.0.01')

  -- Author Info
  local authorLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
  authorLabel:SetPoint('TOPRIGHT', configFrame, 'TOPRIGHT', -16, -24)
  authorLabel:SetText("Author: Cilraaz-Aerie Peak")

  -- Options
  local optionsLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
  optionsLabel:SetPoint('TOPLEFT', titleLabel, 'BOTTOMLEFT', 0, -20)
  optionsLabel:SetText("LSS Options")

  -- Enable/Disable Checkbox
  local disableCheckbox = CreateFrame('CheckButton', nil, configFrame, 'InterfaceOptionsCheckButtonTemplate')
  disableCheckbox:SetPoint('TOPLEFT', optionsLabel, 'BOTTOMLEFT', 20, -5)
  disableCheckbox:SetChecked(ShiGuangPerDB.LSSdisabled)
  disableCheckbox:SetScript("OnClick", function(self)
    local tick = self:GetChecked()
    if tick then
      PlaySound(856) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON
    else
      PlaySound(857) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF
    end
    LootSpecSwapper.frame.SlashCommandHandler("toggle")
  end)

  -- Enable/Disable Label
  local disableLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
  disableLabel:SetPoint('LEFT', disableCheckbox, 'RIGHT', 0, 0)
  disableLabel:SetText("Check to disable Loot Spec Swapper")

  -- Per-Difficulty Checkbox
  local perDifficultyCheckbox = CreateFrame('CheckButton', nil, configFrame, 'InterfaceOptionsCheckButtonTemplate')
  perDifficultyCheckbox:SetPoint('TOPLEFT', disableCheckbox, 'BOTTOMLEFT', 0, -5)
  perDifficultyCheckbox:SetChecked(ShiGuangPerDB.perDifficulty)
  perDifficultyCheckbox:SetScript("OnClick", function(self)
    local tick = self:GetChecked()
    if tick then
      PlaySound(856) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON
    else
      PlaySound(857) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF
    end
    LootSpecSwapper.frame.SlashCommandHandler("diff")
  end)

  -- Per-Difficulty Label
  local perDifficultyLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
  perDifficultyLabel:SetPoint('LEFT', perDifficultyCheckbox, 'RIGHT', 0, 0)
  perDifficultyLabel:SetText("Check to enable per-difficulty settings")

  -- Silence Checkbox
  local silenceCheckbox = CreateFrame('CheckButton', nil, configFrame, 'InterfaceOptionsCheckButtonTemplate')
  silenceCheckbox:SetPoint('TOPLEFT', perDifficultyCheckbox, 'BOTTOMLEFT', 0, -5)
  silenceCheckbox:SetChecked(ShiGuangPerDB.globalSilence)
  silenceCheckbox:SetScript("OnClick", function(self)
    local tick = self:GetChecked()
    if tick then
      PlaySound(856) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON
    else
      PlaySound(857) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF
    end
    LootSpecSwapper.frame.SlashCommandHandler("quiet")
  end)

  -- Silence Label
  local silenceLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
  silenceLabel:SetPoint('LEFT', silenceCheckbox, 'RIGHT', 0, 0)
  silenceLabel:SetText("Check to disable addon messages")

  -- Spec Options
  local specOptionsLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
  specOptionsLabel:SetPoint('TOPLEFT', silenceCheckbox, 'BOTTOMLEFT', -20, -10)
  specOptionsLabel:SetText("Specializations Options")

  -- Forget Default Spec
  local forgetDefaultButton = CreateFrame('Button', nil, configFrame, 'UIPanelButtonTemplate')
  forgetDefaultButton:SetText("Forget Default Spec")
  forgetDefaultButton:SetWidth(150)
  forgetDefaultButton:SetHeight(24)
  forgetDefaultButton:SetPoint('TOPLEFT', specOptionsLabel, 'BOTTOMLEFT', 20, -5)
  forgetDefaultButton:SetScript("OnClick", function()
    LootSpecSwapper.frame.SlashCommandHandler("forgetdefault")
  end)
  forgetDefaultButton.tooltipText = "This will make the addon forget your default loot spec."

  -- Set Default Spec to current loot spec
  local setDefaultButton = CreateFrame('Button', nil, configFrame, 'UIPanelButtonTemplate')
  setDefaultButton:SetText("Default - Loot")
  setDefaultButton:SetWidth(150)
  setDefaultButton:SetHeight(24)
  setDefaultButton:SetPoint('TOPLEFT', forgetDefaultButton, 'TOPLEFT', 160, 0)
  setDefaultButton:SetScript("OnClick", function()
    LootSpecSwapper.frame.SlashCommandHandler("setdefault")
  end)
  setDefaultButton.tooltipText = "This will set the addon's default loot spec to your currently selected loot spec."
  
  local defaultFollowButton = CreateFrame('Button', nil, configFrame, 'UIPanelButtonTemplate')
  defaultFollowButton:SetText("Default - Actual")
  defaultFollowButton:SetWidth(150)
  defaultFollowButton:SetHeight(24)
  defaultFollowButton:SetPoint('TOPLEFT', setDefaultButton, 'TOPLEFT', 160, 0)
  defaultFollowButton:SetScript("OnClick", function()
    LootSpecSwapper.frame.SlashCommandHandler("setdefaulttofollow")
  end)
  defaultFollowButton.tooltipText = "This will set the addon's default loot spec to your current actual spec."

  -- Other Options
  local otherOptionsLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
  otherOptionsLabel:SetPoint('TOPLEFT', forgetDefaultButton, 'BOTTOMLEFT', -20, -10)
  otherOptionsLabel:SetText("Other Options")

  -- List Button
  local listButton = CreateFrame('Button', nil, configFrame, 'UIPanelButtonTemplate')
  listButton:SetText("List Selections")
  listButton:SetWidth(150)
  listButton:SetHeight(24)
  listButton:SetPoint('TOPLEFT', otherOptionsLabel, 'BOTTOMLEFT', 20, -5)
  listButton:SetScript("OnClick", function()
    LootSpecSwapper.frame.SlashCommandHandler("list")
  end)
  listButton.tooltipText = "List all loot spec selections"

  local resetButton = CreateFrame('Button', nil, configFrame, 'UIPanelButtonTemplate')
  resetButton:SetText("RESET LSS")
  resetButton:SetWidth(150)
  resetButton:SetHeight(24)
  resetButton:SetPoint('TOPLEFT', listButton, 'BOTTOMLEFT', 0, -100)
  resetButton:SetScript("OnClick", function()
    LootSpecSwapper.frame.SlashCommandHandler("reset")
  end)
  resetButton.tooltipText = "This will wipe all of your settings! Only press if you are certain you want to do this."

end

-- Create our base frame
local lssFrame = CreateFrame("frame")
LootSpecSwapper.frame = lssFrame

-- Initialize SavedVariables
--if type(ShiGuangPerDB) ~= "table" then
  --ShiGuangPerDB = {}
--end

-- Difficulty Name Table
local difficultyNames = {
  ["1"] = "Dungeon Normal",
  ["2"] = "Dungeon Heroic",
  ["14"] = "Raid Normal",
  ["15"] = "Raid Heroic",
  ["16"] = "Raid Mythic",
  ["17"] = "Raid LFR",
  ["23"] = "Dungeon Mythic"
}

-- Table for boss names that don't match the Encounter Journal encounter name
local bossFixes = {
  -- Dungeons
  ["Milificent Manastorm"] = "The Manastorms",
  ["Millhouse Manastorm"] = "The Manastorms",
  ["Halkias"] = "Halkias, the Sin-Stained Goliath",
  ["Azules"] = "Kin-Tara",
  ["Devos"] = "Devos, Paragon of Doubt",
  ["Stitchflesh's Creation"] = "Surgeon Stitchflesh",
  ["Dessia the Decapitator"] = "An Affront of Challengers",
  ["Paceran the Virulent"] = "An Affront of Challengers",
  ["Sathel the Accursed"] = "An Affront of Challengers",
  -- Raids
  --- World Bosses
  ["Valinor"] = "Valinor, the Light of Eons",
  --- Castle Nathria
  ["Margore"] = "Huntsman Altimor",
  ["Kael'thas Sunstrider"] = "Sun King's Salvation",
  ["High Torturor Darithos"] = "Sun King's Salvation",
  ["Bleakwing Assassin"] = "Sun King's Salvation",
  ["Vile Occultist"] = "Sun King's Salvation",
  ["Castellan Niklaus"] = "The Council of Blood",
  ["Baroness Frieda"] = "The Council of Blood",
  ["Lord Stavros"] = "The Council of Blood",
  ["General Kaal"] = "Stone Legion Generals",
  ["General Grashaal"] = "Stone Legion Generals",
  --- Sanctum of Domination
  ["Eye of the Jailer"] = "The Eye of the Jailer",
  ["Kyra"] = "The Nine",
  ["Signe"] = "The Nine",
  ["Skyja"] = "The Nine",
}

-- Generic Variables
local autoSwapActive = false

-- EJ frame stuffs
local journalSaveButton = CreateFrame("Button", "EncounterJournalEncounterFrameInfoCreatureButton1LSSSaveButton",UIParent,"UIPanelButtonTemplate")
local journalDefaultButton = CreateFrame("Button", "EncounterJournalEncounterFrameInfoCreatureButton1LSSDefaultButton",UIParent,"UIPanelButtonTemplate")
local journalRestoreButton = CreateFrame("Button", "EncounterJournalEncounterFrameInfoCreatureButton1LSSRestoreButton",UIParent,"UIPanelButtonTemplate")
local f = CreateFrame("frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")

-- Spec Variables
local currPlayerSpecTable = {}
local maxSpecs = GetNumSpecializations()
local _,_,classID = UnitClass("player")
local nextSpecTable = {}
local lastSpec
local firstSpec

-- LUA locals
local UnitName = UnitName
local UnitIsDead = UnitIsDead
local EJ_GetDifficulty = EJ_GetDifficulty
local EJ_GetInstanceInfo = EJ_GetInstanceInfo

local printOutput = function(msg)
  if (not ShiGuangPerDB.globalSilence) then
    print(msg)
  end
end

local function BonusWindowClosed()
  if ( (lssFrame.onBonusWindowClosedSpec) and (lssFrame.onBonusWindowClosedSpec) ~= (GetLootSpecialization()) ) then
    local newSpec = lssFrame.onBonusWindowClosedSpec
    if (newSpec == -1) then
      SetLootSpecialization(0)
      printOutput("Loot Spec Swapper: CHANGED LOOT SPEC TO FOLLOW CURRENT SPEC")
    else
      SetLootSpecialization(newSpec)
      printOutput("Loot Spec Swapper: CHANGED LOOT SPEC TO: <<"..(select(2,GetSpecializationInfoByID(newSpec)))..">>")
    end
  end

  lssFrame.onBonusWindowClosedSpec = nil
end

lssFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
lssFrame:RegisterEvent("LOOT_CLOSED")
lssFrame:SetScript("OnEvent", function(self, event)
  if (ShiGuangPerDB.LSSdisabled) then return end
  local newSpec = nil
  if (event == "PLAYER_TARGET_CHANGED") then
    if (not UnitIsDead("target")) then
      local currMapID = (C_Map.GetBestMapForUnit("player")) or 0
      local EJInstanceID = EJ_GetInstanceForMap(currMapID)
      local targetName = UnitName("target")
      if not targetName then return end
      if not (targetName == "General Kaal" and EJInstanceID == 1189) then
        if bossFixes[targetName] then targetName = bossFixes[targetName] end
      end

      if ShiGuangPerDB.perDifficulty then
        local _,_,diff = GetInstanceInfo()
        if diff then
          if ShiGuangPerDB.specPerBoss[diff] then
            if ShiGuangPerDB.specPerBoss[diff][EJInstanceID] then
              newSpec = ShiGuangPerDB.specPerBoss[diff][EJInstanceID][targetName]
            end
          end
        end
      else
        if ShiGuangPerDB.specPerBoss.allDifficulties[EJInstanceID] then
          newSpec = ShiGuangPerDB.specPerBoss.allDifficulties[EJInstanceID][targetName]
        end
      end
      if newSpec then
        inDefaultSpecAlready = false
        autoSwapActive = true
      else
        --printOutput("LSS: An error has occurred. Spec setting for this boss (all difficulties) not found.")
      end
    end
  elseif (autoSwapActive and (not (inDefaultSpecAlready--[[ or InCombatLockdown()]]))) then
    autoSwapActive = false
    if (ShiGuangPerDB.afterLootSpec ~= 0) then
      if (GroupLootContainer and GroupLootContainer:IsVisible()) then
        lssFrame.onBonusWindowClosedSpec = ShiGuangPerDB.afterLootSpec
        hooksecurefunc("BonusRollFrame_OnHide", BonusWindowClosed)
        hooksecurefunc("BonusRollFrame_CloseBonusRoll", BonusWindowClosed)
        hooksecurefunc("BonusRollFrame_FinishedFading", BonusWindowClosed)
        hooksecurefunc("BonusRollFrame_AdvanceLootSpinnerAnim", BonusWindowClosed)
      else
        newSpec = ShiGuangPerDB.afterLootSpec
      end
      inDefaultSpecAlready = true
    end
  end
  if (newSpec and GetLootSpecialization() ~= newSpec) then
    if (newSpec == -1) then
      SetLootSpecialization(0)
      printOutput("Loot Spec Swapper: CHANGED LOOT SPEC TO FOLLOW CURRENT SPEC")
    else
      SetLootSpecialization(newSpec)
      printOutput("Loot Spec Swapper: CHANGED LOOT SPEC TO: <<"..(select(2,GetSpecializationInfoByID(newSpec)))..">>")
    end
  end
end)

local overrideTarget = nil
local overrideSpec = nil
function lssFrame.SlashCommandHandler(cmd)
  if cmd and string.lower(cmd) == "record" then
    local currSpec = overrideSpec or (GetLootSpecialization())
    local currTarget = overrideTarget or UnitName("target")

    if (type(currSpec) == "number" and type(currTarget) == "string") then
      if (currSpec == 0) then
        printOutput("Loot Spec Swapper: You must set a spec first (right-click your character frame).")
      else
        local EJInstanceID = EncounterJournal.instanceID
        if ShiGuangPerDB.perDifficulty then
          local diff = EJ_GetDifficulty()
          if diff then
            ShiGuangPerDB.specPerBoss[diff][EJInstanceID][currTarget] = currSpec
          end
        else
          ShiGuangPerDB.specPerBoss.allDifficulties[EJInstanceID][currTarget] = currSpec
        end
      end
    end
  elseif cmd and string.lower(cmd) == "setdefault" then
    local currSpec = (GetLootSpecialization())
    if (type(currSpec) == "number") then
      if (currSpec == 0) then
        ShiGuangPerDB.afterLootSpec = -1
      else
        ShiGuangPerDB.afterLootSpec = currSpec
      end
    end
    printOutput("Loot Spec Swapper: Set default spec to follow your currently selected loot spec.")
  elseif cmd and string.lower(cmd) == "setdefaulttofollow" then
    ShiGuangPerDB.afterLootSpec = -1
    printOutput("Loot Spec Swapper: Set default spec to follow your actual spec.")
  elseif cmd and string.lower(cmd) == "list" then
    printOutput("Loot Spec Swapper: List")
    if ShiGuangPerDB.perDifficulty then
      for k,v in pairs(ShiGuangPerDB.specPerBoss) do
        if k ~= "allDifficulties" then
          for instance, bossInfo in pairs(v) do
            for boss, spec in pairs(bossInfo) do
              local _, specName = GetSpecializationInfoByID(spec)
              printOutput("Difficulty: "..difficultyNames[tostring(k)].." - Instance ID: "..instance.." - Boss: "..boss.." - "..specName)
            end
          end
        end
      end
    else
      for instance, bossInfo in pairs(ShiGuangPerDB.specPerBoss.allDifficulties) do
        for boss, spec in pairs(bossInfo) do
          local _, specName = GetSpecializationInfoByID(spec)
          printOutput("All Difficulties - Instance ID: "..instance.." - Boss: "..boss.." - "..specName)
        end
      end
    end
    if (ShiGuangPerDB.afterLootSpec) then
      if (ShiGuangPerDB.afterLootSpec == 0) then
        printOutput("Default Spec: <<No default>>")
      elseif (ShiGuangPerDB.afterLootSpec == -1) then
        printOutput("Default Spec: <<Current Spec>>")
      else
        local _, specName = GetSpecializationInfoByID(ShiGuangPerDB.afterLootSpec)
        printOutput("Default Spec: "..specName)
      end
    end
  elseif cmd and string.lower(cmd) == "forget" then
    local currTarget = overrideTarget or UnitName("target")
    if (type(currTarget) == "string") then
      local EJInstanceID = EncounterJournal.instanceID
      if ShiGuangPerDB.perDifficulty then
        local diff = EJ_GetDifficulty()
        if diff then
          ShiGuangPerDB.specPerBoss[diff][EJInstanceID][currTarget] = nil
        end
      else
        ShiGuangPerDB.specPerBoss.allDifficulties[EJInstanceID][currTarget] = nil
      end
    end
  elseif cmd and string.lower(cmd) == "forgetdefault" then
    ShiGuangPerDB.afterLootSpec = 0
    printOutput("Loot Spec Swapper: Forgot default spec.")
  elseif cmd and string.lower(cmd) == "diff" then
    ShiGuangPerDB.perDifficulty = not ShiGuangPerDB.perDifficulty
    printOutput("Store per difficulty-level: " .. (ShiGuangPerDB.perDifficulty and "true" or "false"))
  elseif cmd and string.lower(cmd) == "toggle" then
    ShiGuangPerDB.LSSdisabled = not ShiGuangPerDB.LSSdisabled
    if ShiGuangPerDB.LSSdisabled then
      f:Hide()
      journalRestoreButton:Hide()
    else
      journalRestoreButton:Show()
    end
    printOutput("Loot Spec Swapper: " .. ((not ShiGuangPerDB.LSSdisabled) and "Enabled." or "Disabled."))
  elseif cmd and string.lower(cmd) == "quiet" then
    printOutput("Loot Spec Swapper: Silenced")
    ShiGuangPerDB.globalSilence = not ShiGuangPerDB.globalSilence
    printOutput("Loot Spec Swapper: Unsilenced")
  elseif cmd and string.lower(cmd) == "reset" then
    printOutput("Resetting Loot Spec Swapper.")
    ShiGuangPerDB.specPerBoss = nil
    ReloadUI()
  else
    printOutput("Command not found: "..cmd.."\nLoot Spec Swapper: Usage:\n/lss toggle | quiet | list | diff | forget | setdefault | forgetdefault | setdefaulttofollow | reset")
  end
end

journalRestoreButton:SetScript("OnClick",function(self)
  f:Show()
  self:Hide()
  ShiGuangPerDB.LSSminimized = false
end)
journalSaveButton:SetScript("OnClick",function(self, button)
  local EJInstanceID = EncounterJournal.instanceID
  if (not EncounterJournalEncounterFrameInfoCreatureButton1) or (not EncounterJournalEncounterFrameInfoCreatureButton1.name) or (not EJInstanceID) then
    printOutput("Select a boss first.")
    return
  end
  if (button == "RightButton") then
    overrideTarget = EJ_GetEncounterInfo(EncounterJournal.encounterID)
    lssFrame.SlashCommandHandler("forget")
    overrideTarget = nil
  else
    overrideTarget = EJ_GetEncounterInfo(EncounterJournal.encounterID)
    overrideSpec = firstSpec
    local selectedSpec = nil
    if ShiGuangPerDB.perDifficulty then
      local diff = EJ_GetDifficulty()
      if diff then
        selectedSpec = ShiGuangPerDB.specPerBoss[diff][EJInstanceID][overrideTarget]
      else
        printOutput("Select a difficulty first.")
      end
    else
      selectedSpec = ShiGuangPerDB.specPerBoss.allDifficulties[EJInstanceID][overrideTarget]
    end
    if selectedSpec then
      overrideSpec = selectedSpec
      firstSpec = selectedSpec
      overrideSpec = currPlayerSpecTable[nextSpecTable[overrideSpec]][1]
      firstSpec = overrideSpec
    end
    lssFrame.SlashCommandHandler("record")
    overrideTarget = nil
    overrideSpec = nil
  end
end)

journalSaveButton:RegisterForClicks("AnyDown")
journalDefaultButton:SetScript("OnClick",function(self, button)
  if (button == "RightButton") then
    lssFrame.SlashCommandHandler("forgetdefault")
  else
    lssFrame.SlashCommandHandler("setdefault")
  end
end)
journalDefaultButton:RegisterForClicks("AnyDown")

journalSaveButton:SetWidth(80)
journalSaveButton:SetHeight(80)
journalSaveButton:SetPoint("CENTER",0,400)
journalDefaultButton:SetWidth(80)
journalDefaultButton:SetHeight(80)
journalDefaultButton:SetPoint("CENTER",0,400)

f:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",tile = true, tileSize = 32, edgeSize = 32,insets = { left = 11, right = 12, top = 12, bottom = 11 }})
f:SetBackdropColor(0,0,0,1)
f:SetFrameStrata("HIGH")
f:SetToplevel(true)
f:EnableMouse(true)
f:SetMovable(true)
f:RegisterForDrag("LeftButton")
f:SetScript("OnDragStart", function(self) self:StartMoving() end)
f:SetScript("OnDragStop", function (self) self:StopMovingOrSizing() end)
f:SetWidth(220)
f:SetHeight(260)

local ttl = CreateFrame("frame", nil, f)
ttl:SetWidth(185)
ttl:SetHeight(40)
ttl:SetPoint("TOP", 0, 15)
ttl:SetFrameStrata("BACKGROUND")

ttl:EnableMouse(true)
ttl:RegisterForDrag("LeftButton")
ttl:SetScript("OnDragStart", function(self) self:GetParent():StartMoving() end)
ttl:SetScript("OnDragStop", function(self) self:GetParent():StopMovingOrSizing() end)

local ttx = ttl:CreateTexture(nil, "BACKGROUND")
ttx:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")
ttx:SetPoint("TOPRIGHT", 57, 0)
ttx:SetPoint("BOTTOMLEFT", -58, -24)

local ttlTxt = ttl:CreateFontString(nil, "OVERLAY", nil)
ttlTxt:SetFont("Fonts/MORPHEUS.ttf", 15)
ttlTxt:SetText("Loot Spec Swapper")
ttlTxt:SetWidth(450)
ttlTxt:SetHeight(64)
ttlTxt:SetPoint("TOP", 0, 12)

local fClose = CreateFrame("Button", nil, f, "UIPanelCloseButton")
fClose:SetPoint("TOPRIGHT", 12, 12)
fClose:SetScript("OnClick", function(self) self:GetParent():Hide(); journalRestoreButton:Show(); ShiGuangPerDB.LSSminimized = true end)
fClose:Show()

journalSaveButton:SetParent(f)
journalSaveButton:SetText("<none>")
journalSaveButton:ClearAllPoints()
journalSaveButton:SetPoint("TOP",f,"TOP",0,-25)

local saveButtonDesc = journalSaveButton:CreateFontString(nil, "OVERLAY", nil)
saveButtonDesc:SetFont("Fonts\\FRIZQT__.TTF", 10)
saveButtonDesc:SetText("Boss: <none selected>\nLMB:Toggle, RMB:Clear")
saveButtonDesc:SetWidth(450)
saveButtonDesc:SetHeight(64)
saveButtonDesc:SetPoint("BOTTOM", 0, -43)

journalDefaultButton:SetParent(f)
journalDefaultButton:ClearAllPoints()
journalDefaultButton:SetPoint("TOP",f,"TOP",0,-135)
journalRestoreButton:Hide()

local defaultButtonDesc = journalDefaultButton:CreateFontString(nil, "OVERLAY", nil)
defaultButtonDesc:SetFont("Fonts\\FRIZQT__.TTF", 10)
defaultButtonDesc:SetText("Default (switches back after looting):\nLMB:Save, RMB: Clear\n(Use the portrait menu to pick...)")
defaultButtonDesc:SetWidth(450)
defaultButtonDesc:SetHeight(64)
defaultButtonDesc:SetPoint("BOTTOM", 0, -48)

f:Hide()

local function UpdateSaveButton(bossSpec)
  if (type(bossSpec) == "number") then
    local _, _, _, icon = GetSpecializationInfoByID(bossSpec)
    journalSaveButton:SetNormalTexture(icon)
    journalSaveButton:SetText("")
  else
    journalSaveButton:SetNormalTexture(0,0,0,0,1)
    journalSaveButton:SetText("<none>")
  end
end

local function UpdateDefaultButton(bossSpec)
  if (type(bossSpec) == "number") then
    if (bossSpec == 0) then
      journalDefaultButton:SetNormalTexture(0,0,0,0,1)
      journalDefaultButton:SetText("<none>")
    elseif (bossSpec == -1) then
      journalDefaultButton:SetNormalTexture(0,0,0,0,1)
      journalDefaultButton:SetText("<auto>")
    else
      local _, _, _, icon = GetSpecializationInfoByID(bossSpec)
      journalDefaultButton:SetNormalTexture(icon)
      journalDefaultButton:SetText("")
    end
  else
    journalDefaultButton:SetNormalTexture(0,0,0,0,1)
    journalDefaultButton:SetText("<none>")
  end
end

journalSaveButton:SetScript("OnUpdate",function(self)
  if (self:IsVisible()) then
    local bossID = EncounterJournal.encounterID
    local bossName = ""
    if bossID ~= nil then
      bossName = EJ_GetEncounterInfo(EncounterJournal.encounterID)
    end
    local EJInstanceID = EncounterJournal.instanceID

    if (type(bossName) == "string" and bossName ~= "") then
      local bossSpec
      if ShiGuangPerDB.perDifficulty then
        local diff = EJ_GetDifficulty()
        if diff then
          if not ShiGuangPerDB.specPerBoss[diff] then
            ShiGuangPerDB.specPerBoss[diff] = {}
          end
          if not ShiGuangPerDB.specPerBoss[diff][EJInstanceID] then
            ShiGuangPerDB.specPerBoss[diff][EJInstanceID] = {}
          end
          bossSpec = ShiGuangPerDB.specPerBoss[diff][EJInstanceID][bossName]
        end
      else
        if not ShiGuangPerDB.specPerBoss.allDifficulties[EJInstanceID] then
          ShiGuangPerDB.specPerBoss.allDifficulties[EJInstanceID] = {}
        end
        bossSpec = ShiGuangPerDB.specPerBoss.allDifficulties[EJInstanceID][bossName]
      end
      saveButtonDesc:SetText("Boss: "..bossName.."\nLMB:Toggle, RMB:Clear")
      UpdateSaveButton(bossSpec)
    end

    UpdateDefaultButton(ShiGuangPerDB.afterLootSpec)
  end
end)

SlashCmdList["LOOTSPECSWAPPER"] = lssFrame.SlashCommandHandler
SLASH_LOOTSPECSWAPPER1 = "/lootspecswapper"
SLASH_LOOTSPECSWAPPER2 = "/lss"

local loadframe = CreateFrame("frame")
loadframe:RegisterEvent("ADDON_LOADED")
loadframe:SetScript("OnEvent",function(self,event,addon)
  if (addon == "Blizzard_EncounterJournal") then
    maxSpecs = GetNumSpecializations()
    f:SetParent(EncounterJournal)
    f:Show()
    f:ClearAllPoints()
    f:SetPoint("TOP",EncounterJournal,"TOP",650,0)
    journalRestoreButton:SetWidth(60)
    journalRestoreButton:SetHeight(14)
    journalRestoreButton:SetText("LSS>>")
    journalRestoreButton:SetParent(EncounterJournal)
    journalRestoreButton:ClearAllPoints()
    journalRestoreButton:SetPoint("TOP",EncounterJournal,"TOP",340,-4)
    if (ShiGuangPerDB.LSSminimized) then fClose:Click() end
    for i=1,maxSpecs do
      local id, _, _, icon = GetSpecializationInfoForClassID(classID, i)
      currPlayerSpecTable[i] = {id, icon}
      if i == 1 then
        firstSpec = id
      end
      if i > 1 then
        nextSpecTable[lastSpec] = i
      end
      if i == maxSpecs then
        nextSpecTable[id] = 1
      end
      lastSpec = id
    end
  end

  if addon == "LootSpecSwapper" then
    -- Create defaults
    ShiGuangPerDB.specPerBoss = ShiGuangPerDB.specPerBoss or {}
    ShiGuangPerDB.specPerBoss.allDifficulties = ShiGuangPerDB.specPerBoss.allDifficulties or {}
    ShiGuangPerDB.perDifficulty = ShiGuangPerDB.perDifficulty or false
    ShiGuangPerDB.afterLootSpec = ShiGuangPerDB.afterLootSpec or 0
    ShiGuangPerDB.globalSilence = ShiGuangPerDB.globalSilence or false
    ShiGuangPerDB.LSSminimized = ShiGuangPerDB.LSSminimized or false
    ShiGuangPerDB.LSSdisabled = ShiGuangPerDB.LSSdisabled or false

    -- Remove old SavedVariables data
    if ShiGuangPerDB.bossNameToSpecMapping then ShiGuangPerDB.bossNameToSpecMapping = nil; end
    if ShiGuangPerDB.bossNameToSpecMapping_L then ShiGuangPerDB.bossNameToSpecMapping_L = nil; end
    if ShiGuangPerDB.bossNameToSpecMapping_N then ShiGuangPerDB.bossNameToSpecMapping_N = nil; end
    if ShiGuangPerDB.bossNameToSpecMapping_H then ShiGuangPerDB.bossNameToSpecMapping_H = nil; end
    if ShiGuangPerDB.bossNameToSpecMapping_M then ShiGuangPerDB.bossNameToSpecMapping_M = nil; end
    if ShiGuangPerDB.specToSwitchToAfterLooting then ShiGuangPerDB.specToSwitchToAfterLooting = nil; end

    -- Create Options Panel
    LSS_CreateOptionsPanel()
  end
end)
