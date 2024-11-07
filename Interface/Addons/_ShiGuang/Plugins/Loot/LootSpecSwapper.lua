--## Author: Cilraaz ## Version: 11.0.2.01
local LootSpecSwapper = {}

function LSS_CreateOptionsPanel()

  -- Create Main Panel
  local configFrame = CreateFrame('Frame', 'LSSConfigFrame', InterfaceOptionsFramePanelContainer)
  configFrame:Hide()
  configFrame.name = '[拾取]专精切换'  --Loot Spec Swapper

  local BuildInfo = { GetBuildInfo() }
  if BuildInfo[4] >= 110000 then
    local category, layout = Settings.RegisterCanvasLayoutCategory(configFrame, configFrame.name)
    Settings.RegisterAddOnCategory(category)
    LootSpecSwapper.SettingsCategory = category
  else
    InterfaceOptions_AddCategory(configFrame)
  end

  -- Create Title
  local titleLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
  titleLabel:SetPoint('TOPLEFT', configFrame, 'TOPLEFT', 16, -16)
  titleLabel:SetText('专精切换')

  -- Version Info
  local versionLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
  versionLabel:SetPoint('BOTTOMLEFT', titleLabel, 'BOTTOMRIGHT', 8, 0)
  versionLabel:SetText('11.0.2.01')

  -- Author Info
  local authorLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
  authorLabel:SetPoint('TOPRIGHT', configFrame, 'TOPRIGHT', -16, -24)
  authorLabel:SetText("作者: Cilraaz-Aerie Peak")

  -- Options
  local optionsLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
  optionsLabel:SetPoint('TOPLEFT', titleLabel, 'BOTTOMLEFT', 0, -20)
  optionsLabel:SetText("LSS 选项")

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
  disableLabel:SetText("禁用专精切换")

  -- Per-Difficulty Checkbox
  local LSSperDifficultyCheckbox = CreateFrame('CheckButton', nil, configFrame, 'InterfaceOptionsCheckButtonTemplate')
  LSSperDifficultyCheckbox:SetPoint('TOPLEFT', disableCheckbox, 'BOTTOMLEFT', 0, -5)
  LSSperDifficultyCheckbox:SetChecked(ShiGuangPerDB.LSSperDifficulty)
  LSSperDifficultyCheckbox:SetScript("OnClick", function(self)
    local tick = self:GetChecked()
    if tick then
      PlaySound(856) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON
    else
      PlaySound(857) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF
    end
    LootSpecSwapper.frame.SlashCommandHandler("diff")
  end)

  -- Per-Difficulty Label
  local LSSperDifficultyLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
  LSSperDifficultyLabel:SetPoint('LEFT', LSSperDifficultyCheckbox, 'RIGHT', 0, 0)
  LSSperDifficultyLabel:SetText("启用每个难度的设置")

  -- Silence Checkbox
  local silenceCheckbox = CreateFrame('CheckButton', nil, configFrame, 'InterfaceOptionsCheckButtonTemplate')
  silenceCheckbox:SetPoint('TOPLEFT', LSSperDifficultyCheckbox, 'BOTTOMLEFT', 0, -5)
  silenceCheckbox:SetChecked(ShiGuangPerDB.LSSglobalSilence)
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
  silenceLabel:SetText("禁用插件消息")

  -- Spec Options
  local specOptionsLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
  specOptionsLabel:SetPoint('TOPLEFT', silenceCheckbox, 'BOTTOMLEFT', -20, -10)
  specOptionsLabel:SetText("专精选项")

  -- Forget Default Spec
  local forgetDefaultButton = CreateFrame('Button', nil, configFrame, 'UIPanelButtonTemplate')
  forgetDefaultButton:SetText("遗忘默认专精")
  forgetDefaultButton:SetWidth(150)
  forgetDefaultButton:SetHeight(24)
  forgetDefaultButton:SetPoint('TOPLEFT', specOptionsLabel, 'BOTTOMLEFT', 20, -5)
  forgetDefaultButton:SetScript("OnClick", function()
    LootSpecSwapper.frame.SlashCommandHandler("forgetdefault")
  end)
  forgetDefaultButton.tooltipText = "这将使插件忘记你的默认战利品专精设置。"

  -- Set Default Spec to current loot spec
  local setDefaultButton = CreateFrame('Button', nil, configFrame, 'UIPanelButtonTemplate')
  setDefaultButton:SetText("默认 - 战利品")
  setDefaultButton:SetWidth(150)
  setDefaultButton:SetHeight(24)
  setDefaultButton:SetPoint('TOPLEFT', forgetDefaultButton, 'TOPLEFT', 160, 0)
  setDefaultButton:SetScript("OnClick", function()
    LootSpecSwapper.frame.SlashCommandHandler("setdefault")
  end)
  setDefaultButton.tooltipText = "这将把插件的默认战利品专精设置为你当前选择的战利品专精。"
  
  local defaultFollowButton = CreateFrame('Button', nil, configFrame, 'UIPanelButtonTemplate')
  defaultFollowButton:SetText("默认 - 实际")
  defaultFollowButton:SetWidth(150)
  defaultFollowButton:SetHeight(24)
  defaultFollowButton:SetPoint('TOPLEFT', setDefaultButton, 'TOPLEFT', 160, 0)
  defaultFollowButton:SetScript("OnClick", function()
    LootSpecSwapper.frame.SlashCommandHandler("setdefaulttofollow")
  end)
  defaultFollowButton.tooltipText = "这将把插件的默认战利品专精设置为你当前实际的专精。"

  -- Other Options
  local otherOptionsLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
  otherOptionsLabel:SetPoint('TOPLEFT', forgetDefaultButton, 'BOTTOMLEFT', -20, -10)
  otherOptionsLabel:SetText("其他选项")

  -- List Button
  local listButton = CreateFrame('Button', nil, configFrame, 'UIPanelButtonTemplate')
  listButton:SetText("列表选择")
  listButton:SetWidth(150)
  listButton:SetHeight(24)
  listButton:SetPoint('TOPLEFT', otherOptionsLabel, 'BOTTOMLEFT', 20, -5)
  listButton:SetScript("OnClick", function()
    LootSpecSwapper.frame.SlashCommandHandler("list")
  end)
  listButton.tooltipText = "列出所有战利品专精选择。"

  local resetButton = CreateFrame('Button', nil, configFrame, 'UIPanelButtonTemplate')
  resetButton:SetText("重置 LSS")
  resetButton:SetWidth(150)
  resetButton:SetHeight(24)
  resetButton:SetPoint('TOPLEFT', listButton, 'BOTTOMLEFT', 0, -100)
  resetButton:SetScript("OnClick", function()
    LootSpecSwapper.frame.SlashCommandHandler("reset")
  end)
  resetButton.tooltipText = "这将清除你所有的设置！只有当你确定要这样做时才按下。"

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
-- ["Actual Boss Name"] = "Encounter Journal Boss Name",
local bossFixes = {
  -- Dungeons (Cataclysm)
  ["Asaad"] = "Asaad, Caliph of Zephyrs",
  -- Dungeons (Legion)
  ["Dargrul"] = "Dargrul the Underking",
  -- Dungeons (BfA)
  ["Captain Eudora"] = "Council o\' Captains",
  ["Captain Jolly"] = "Council o\' Captains",
  ["Captain Raoul"] = "Council o\' Captains",
  ["Shark Puncher"] = "Ring of Booty",
  -- Dungeons (SL)
  ["Milificent Manastorm"] = "The Manastorms",
  ["Millhouse Manastorm"] = "The Manastorms",
  ["Halkias"] = "Halkias, the Sin-Stained Goliath",
  ["Azules"] = "Kin-Tara",
  ["Devos"] = "Devos, Paragon of Doubt",
  ["Stitchflesh's Creation"] = "Surgeon Stitchflesh",
  ["Dessia the Decapitator"] = "An Affront of Challengers",
  ["Paceran the Virulent"] = "An Affront of Challengers",
  ["Sathel the Accursed"] = "An Affront of Challengers",
  -- Dungeons (DF)
  ["Rira Hackclaw"] = "Hackclaw's War-Band",
  ["Gashtooth"] = "Hackclaw's War-Band",
  ["Tricktotem"] = "Hackclaw's War-Band",
  ["Erkhart Stormvein"] = "Kyrakka and Erkhart Stormvein",
  ["Teera"] = "Teera and Maruuk",
  ["Maruuk"] = "Teera and Maruuk",
  ["Baelog"] = "The Lost Dwarves",
  ["Eric \"The Swift\""] = "The Lost Dwarves",
  ["Olaf"] = "The Lost Dwarves",
  -- Dungeons (TWW)
  ["Nx"] = "Fangs of the Queen",
  ["Vx"] = "Fangs of the Queen",
  ["Starved Crawler"] = "Avanoxx",
  ["Thirsty Patron"] = "Brew Master Aldryr",
  ["Brew Drop"] = "I'pa",
  ["Cindy"] = "Benk Buzzbee",
  ["Ravenous Cinderbee"] = "Benk Buzzbee",
  ["Yes Man"] = "Goldie Baronbottom",
  ["Elaena Emberlanz"] = "Captain Dailcry",
  ["Sergeant Shaynemail"] = "Captain Dailcry",
  ["Taener Duelmal"] = "Captain Dailcry",
  ["E.D.N.A"] = "E.D.N.A.",
  ["Speaker Dorlita"] = "Master Machinists",
  ["Speaker Brokk"] = "Master Machinists",

  -- Raids
  --- World Bosses (SL)
  ["Valinor"] = "Valinor, the Light of Eons",
  ["Mor'geth"] = "Mor'geth, Tormentor of the Damned",
  ["Sav'thul"] = "Antros",
  --- Castle Nathria (SL)
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
  --- Sanctum of Domination (SL)
  ["Eye of the Jailer"] = "The Eye of the Jailer",
  ["Kyra"] = "The Nine",
  ["Signe"] = "The Nine",
  ["Skyja"] = "The Nine",
  --- Sepulcher of the First Ones (SL)
  ["Vigilant Custodian"] = "Vigilant Guardian",
  ["Skolex"] = "Skolex, the Insatiable Ravener",
  ["Dausegne"] = "Dausegne, the Fallen Oracle",
  ["Prototype of War"] = "Prototype Pantheon",
  ["Prototype of Duty"] = "Prototype Pantheon",
  ["Lihuvim"] = "Lihuvim, Principal Architect",
  ["Halondrus"] = "Halondrus the Reclaimer",
  ["Mal'Ganis"] = "Lords of Dread",
  ["Kin'tessa"] = "Lords of Dread",
  --- World Bosses (DF)
  ["Strunraan"] = "Strunraan, The Sky's Misery",
  ["Basrikron"] = "Basrikron, The Shale Wing",
  ["Bazual"] = "Bazual, The Dreaded Flame",
  ["Liskanoth"] = "Liskanoth, The Futurebane",
  --- Vault of the Incarnates (DF)
  ["Kadros Icewrath"] = "The Primal Council",
  ["Dathea Stormlash"] = "The Primal Council",
  ["Opalfang"] = "The Primal Council",
  ["Embar Firepath"] = "The Primal Council",
  ["Sennarth"] = "Sennarth, the Cold Breath",
  --- Aberrus, the Shadowed Crucible (DF)
  ["Kazzara"] = "Kazzara, the Hellforged",
  ["Essence of Shadow"] = "The Amalgamation Chamber",
  ["Eternal Blaze"] = "The Amalgamation Chamber",
  ["Neldris"] = "The Forgotten Experiments",
  ["Thadrion"] = "The Forgotten Experiments",
  ["Rionthus"] = "The Forgotten Experiments",
  ["Rashok"] = "Rashok, the Elder",
  ["Warlord Kagni"] = "Assault of the Zaqali",
  ["Zskarn"] = "The Vigilant Steward, Zskarn",
  ["Neltharion"] = "Echo of Neltharion",
  ["Sarkareth"] = "Scalecommander Sarkareth",
  --- Amidrassil (DF)
  ["Urctos"] = "Council of Dreams",
  ["Aerwynn"] = "Council of Dreams",
  ["Pip"] = "Council of Dreams",
  ["Nymue"] = "Nymue, Weaver of the Cycle",
  ["Tindral Sageswift"] = "Tindral Sageswift, Seer of the Flame",
  ["Fyrakk"] = "Fyrakk the Blazing",
  --- World Bosses (TWW)
  ["Kordac"] = "Kordac, the Dormant Protector",
  ["Shurrai"] = "Shurrai, Atrocity of the Undersea",
  ["Orta"] = "Orta, the Broken Mountain",
  --- Nerub-ar Palace (TWW)
  ["Sikran"] = "Sikran, Captain of the Sureki",
  ["Anum'arash"] = "The Silken Court",
  ["Skeinspinner Takazj"] = "The Silken Court",
  ["Shattershell Scarab"] = "The Silken Court",
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
local print = print
local UnitName = UnitName
local UnitIsDead = UnitIsDead
local EJ_GetDifficulty = EJ_GetDifficulty
local EJ_GetInstanceInfo = EJ_GetInstanceInfo

local printOutput = function(msg)
  if (not ShiGuangPerDB.LSSglobalSilence) then
    print(msg)
  end
end

local function BonusWindowClosed()
  if ( (lssFrame.onBonusWindowClosedSpec) and (lssFrame.onBonusWindowClosedSpec) ~= (GetLootSpecialization()) ) then
    local newSpec = lssFrame.onBonusWindowClosedSpec
    if (newSpec == -1) then
      SetLootSpecialization(0)
      printOutput("专精切换：已将战利品专精更改为当前专精。")
    else
      SetLootSpecialization(newSpec)
      printOutput("专精切换：已更改战利品专精为： <<"..(select(2,GetSpecializationInfoByID(newSpec)))..">>")
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

      if ShiGuangPerDB.LSSperDifficulty then
        local _,_,diff = GetInstanceInfo()
        if diff then
          if ShiGuangPerDB.LSSspecPerBoss[diff] then
            if ShiGuangPerDB.LSSspecPerBoss[diff][EJInstanceID] then
              newSpec = ShiGuangPerDB.LSSspecPerBoss[diff][EJInstanceID][targetName]
            end
          end
        end
      else
        if ShiGuangPerDB.LSSspecPerBoss.allDifficulties[EJInstanceID] then
          newSpec = ShiGuangPerDB.LSSspecPerBoss.allDifficulties[EJInstanceID][targetName]
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
    if (ShiGuangPerDB.LSSafterLootSpec ~= 0) then
      if (GroupLootContainer and GroupLootContainer:IsVisible()) then
        lssFrame.onBonusWindowClosedSpec = ShiGuangPerDB.LSSafterLootSpec
        hooksecurefunc("BonusRollFrame_OnHide", BonusWindowClosed)
        hooksecurefunc("BonusRollFrame_CloseBonusRoll", BonusWindowClosed)
        hooksecurefunc("BonusRollFrame_FinishedFading", BonusWindowClosed)
        hooksecurefunc("BonusRollFrame_AdvanceLootSpinnerAnim", BonusWindowClosed)
      else
        newSpec = ShiGuangPerDB.LSSafterLootSpec
      end
      inDefaultSpecAlready = true
    end
  end
  if (newSpec and GetLootSpecialization() ~= newSpec) then
    if (newSpec == -1) then
      SetLootSpecialization(0)
      printOutput("专精切换： 已将战利品专精更改为当前专精。")
    else
      SetLootSpecialization(newSpec)
      printOutput("专精切换： 已更改战利品专精为： <<"..(select(2,GetSpecializationInfoByID(newSpec)))..">>")
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
        printOutput("专精切换：你必须先设置一个拾取专精（右键点击你的角色框架）")
      else
        local EJInstanceID = EncounterJournal.instanceID
        if ShiGuangPerDB.LSSperDifficulty then
          local diff = EJ_GetDifficulty()
          if diff then
            ShiGuangPerDB.LSSspecPerBoss[diff][EJInstanceID][currTarget] = currSpec
          end
        else
          ShiGuangPerDB.LSSspecPerBoss.allDifficulties[EJInstanceID][currTarget] = currSpec
        end
      end
    end
  elseif cmd and string.lower(cmd) == "setspecafter" then
    local currSpec = (GetLootSpecialization())
    if (type(currSpec) == "number") then
      if (currSpec == 0) then
        ShiGuangPerDB.LSSafterLootSpec = -1
      else
        ShiGuangPerDB.LSSafterLootSpec = currSpec
      end
    end
    printOutput("专精切换：将你的战利品专精设置为你当前选择的专精。")
  elseif cmd and string.lower(cmd) == "setactualafter" then
    ShiGuangPerDB.LSSafterLootSpec = -1
    printOutput("专精切换：将你的战利品专精设置为你当前实际的专精。")
  elseif cmd and string.lower(cmd) == "list" then
    printOutput("专精切换：列表")
    if ShiGuangPerDB.LSSperDifficulty then
      for k,v in pairs(ShiGuangPerDB.LSSspecPerBoss) do
        if k ~= "allDifficulties" then
          for instance, bossInfo in pairs(v) do
            for boss, spec in pairs(bossInfo) do
              local _, specName = GetSpecializationInfoByID(spec)
              printOutput("难度："..difficultyNames[tostring(k)].." - 实例ID："..instance.." - Boss："..boss.." - "..specName)
            end
          end
        end
      end
    else
      for instance, bossInfo in pairs(ShiGuangPerDB.LSSspecPerBoss.allDifficulties) do
        for boss, spec in pairs(bossInfo) do
          local _, specName = GetSpecializationInfoByID(spec)
          printOutput("所有难度 - 实例ID："..instance.." - Boss："..boss.." - "..specName)
        end
      end
    end
    if (ShiGuangPerDB.LSSafterLootSpec) then
      if (ShiGuangPerDB.LSSafterLootSpec == 0) then
        printOutput("默认专精：<<无默认>>")
      elseif (ShiGuangPerDB.LSSafterLootSpec == -1) then
        printOutput("默认专精：<<当前专精>>")
      else
        local _, specName = GetSpecializationInfoByID(ShiGuangPerDB.LSSafterLootSpec)
        printOutput("默认专精："..specName)
      end
    end
  elseif cmd and string.lower(cmd) == "forget" then
    local currTarget = overrideTarget or UnitName("target")
    if (type(currTarget) == "string") then
      local EJInstanceID = EncounterJournal.instanceID
      if ShiGuangPerDB.LSSperDifficulty then
        local diff = EJ_GetDifficulty()
        if diff then
          ShiGuangPerDB.LSSspecPerBoss[diff][EJInstanceID][currTarget] = nil
        end
      else
        ShiGuangPerDB.LSSspecPerBoss.allDifficulties[EJInstanceID][currTarget] = nil
      end
    end
  elseif cmd and string.lower(cmd) == "forgetdefault" then
    ShiGuangPerDB.LSSafterLootSpec = 0
    printOutput("专精切换：遗忘默认专精。")
  elseif cmd and string.lower(cmd) == "diff" then
    ShiGuangPerDB.LSSperDifficulty = not ShiGuangPerDB.LSSperDifficulty
    printOutput("根据每个难度记录专精：" .. (ShiGuangPerDB.LSSperDifficulty and "启用" or "禁用"))
  elseif cmd and string.lower(cmd) == "toggle" then
    ShiGuangPerDB.LSSdisabled = not ShiGuangPerDB.LSSdisabled
    if ShiGuangPerDB.LSSdisabled then
      f:Hide()
      journalRestoreButton:Hide()
    else
      journalRestoreButton:Show()
    end
    printOutput("专精切换：" .. ((not ShiGuangPerDB.LSSdisabled) and "启用。" or "禁用。"))
  elseif cmd and string.lower(cmd) == "quiet" then
    printOutput("专精切换：禁用消息")
    ShiGuangPerDB.LSSglobalSilence = not ShiGuangPerDB.LSSglobalSilence
    printOutput("专精切换：启用消息")
  elseif cmd and string.lower(cmd) == "reset" then
    printOutput("正在重置专精切换。")
    ShiGuangPerDB.LSSspecPerBoss = nil
    ShiGuangPerDB.LSSafterLootSpec = 0
    ShiGuangPerDB.LSSglobalSilence = false
    ShiGuangPerDB.LSSperDifficulty = false
    ShiGuangPerDB.LSSdisabled = false
    ReloadUI()
  else
    printOutput("未找到命令："..cmd.."\n专精切换可使用：\n/lss toggle | quiet | list | diff | forget | setdefault | forgetdefault | setdefaulttofollow | reset")
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
    printOutput("请先选择一个Boss。")
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
    if ShiGuangPerDB.LSSperDifficulty then
      local diff = EJ_GetDifficulty()
      if diff then
        selectedSpec = ShiGuangPerDB.LSSspecPerBoss[diff][EJInstanceID][overrideTarget]
      else
        printOutput("请先选择一个难度。")
      end
    else
      selectedSpec = ShiGuangPerDB.LSSspecPerBoss.allDifficulties[EJInstanceID][overrideTarget]
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
    lssFrame.SlashCommandHandler("setspecafter")
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
saveButtonDesc:SetText("Boss：<n未选择\n左键：切换，右键：清除")
saveButtonDesc:SetWidth(450)
saveButtonDesc:SetHeight(64)
saveButtonDesc:SetPoint("BOTTOM", 0, -43)

journalDefaultButton:SetParent(f)
journalDefaultButton:ClearAllPoints()
journalDefaultButton:SetPoint("TOP",f,"TOP",0,-135)
journalRestoreButton:Hide()

local defaultButtonDesc = journalDefaultButton:CreateFontString(nil, "OVERLAY", nil)
defaultButtonDesc:SetFont("Fonts\\FRIZQT__.TTF", 10)
defaultButtonDesc:SetText("默认：（战利品拾取后切回）\n左键：保存，右键：清除\n（使用角色头像菜单来选择……）")
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
    journalSaveButton:SetText("<无>")
  end
end

local function UpdateDefaultButton(bossSpec)
  if (type(bossSpec) == "number") then
    if (bossSpec == 0) then
      journalDefaultButton:SetNormalTexture(0,0,0,0,1)
      journalDefaultButton:SetText("<无>")
    elseif (bossSpec == -1) then
      journalDefaultButton:SetNormalTexture(0,0,0,0,1)
      journalDefaultButton:SetText("<自动>")
    else
      local _, _, _, icon = GetSpecializationInfoByID(bossSpec)
      journalDefaultButton:SetNormalTexture(icon)
      journalDefaultButton:SetText("")
    end
  else
    journalDefaultButton:SetNormalTexture(0,0,0,0,1)
    journalDefaultButton:SetText("<无>")
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
      if ShiGuangPerDB.LSSperDifficulty then
        local diff = EJ_GetDifficulty()
        if diff then
          if not ShiGuangPerDB.LSSspecPerBoss[diff] then
            ShiGuangPerDB.LSSspecPerBoss[diff] = {}
          end
          if not ShiGuangPerDB.LSSspecPerBoss[diff][EJInstanceID] then
            ShiGuangPerDB.LSSspecPerBoss[diff][EJInstanceID] = {}
          end
          bossSpec = ShiGuangPerDB.LSSspecPerBoss[diff][EJInstanceID][bossName]
        end
      else
        if not ShiGuangPerDB.LSSspecPerBoss.allDifficulties[EJInstanceID] then
          ShiGuangPerDB.LSSspecPerBoss.allDifficulties[EJInstanceID] = {}
        end
        bossSpec = ShiGuangPerDB.LSSspecPerBoss.allDifficulties[EJInstanceID][bossName]
      end
      saveButtonDesc:SetText("Boss："..bossName.."\n左键：切换，右键：清除")
      UpdateSaveButton(bossSpec)
    end

    UpdateDefaultButton(ShiGuangPerDB.LSSafterLootSpec)
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
    journalRestoreButton:SetFrameStrata(EncounterJournalCloseButton:GetFrameStrata())
    journalRestoreButton:SetFrameLevel(EncounterJournalCloseButton:GetFrameLevel() + 100)
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

  if addon == "_ShiGuang" then
    -- Create defaults
    ShiGuangPerDB.LSSspecPerBoss = ShiGuangPerDB.LSSspecPerBoss or {}
    ShiGuangPerDB.LSSspecPerBoss.allDifficulties = ShiGuangPerDB.LSSspecPerBoss.allDifficulties or {}
    ShiGuangPerDB.LSSperDifficulty = ShiGuangPerDB.LSSperDifficulty or false
    ShiGuangPerDB.LSSafterLootSpec = ShiGuangPerDB.LSSafterLootSpec or 0
    ShiGuangPerDB.LSSglobalSilence = ShiGuangPerDB.LSSglobalSilence or false
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
