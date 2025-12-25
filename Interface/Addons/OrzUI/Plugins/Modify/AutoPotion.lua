--## Version: 3.11.5 ## Author: ollidiemaus

local hamL = {}
if GetLocale() == "zhCN" then

-- InterfaceOptionsFrame
hamL["Addon Behaviour"] = "插件功能"
hamL["Auto Potion Settings"] = "Auto Potion 设置"
hamL["Cavedweller's Delight"] = "洞穴住民的挚爱"
hamL["Class/Racial Spells"] = "职业/种族技能"
hamL["Configure the behavior of the addon. IE: if you want to include class spells"] = "您可以在此设置技能。例：是否启用已添加的职业专属回血技能"
hamL["Current Priority"] = "当前优先"
hamL["Bandage Priority"] = "绷带优先"
hamL["Heartseeking Health Injector (tinker)"] = "觅心生命注射器（匠械）"
hamL["Include /stopcasting in the macro"] = "添加停止施法（/stopcasting）到宏内（重载界面生效）"
hamL["Includes the shortest Cooldown in the reset Condition of Castsequence. !!USE CAREFULLY!!"] = "包括了队列施法（Castsequence）重置条件中最短的冷却时间|cffff0000!!小心使用!!|r"
hamL["Invalid option: "] = "无效选项："
hamL["Items"] = "药水"
hamL["Low Priority Healthstones"] = "低优先使用治疗石"
hamL["Potion of Withering Dreams"] = "凋零梦境药水"
hamL["Potion of Withering Vitality"] = "枯萎活力药水"
hamL["Prioritize health potions over a healthstone."] = "优先使用治疗药水，而不是治疗石。"
hamL["Reset successful!"] = "重置成功！"
hamL["Reset to Default"] = "重置为默认"
hamL["The Settings of AutoPotion were reset due to breaking changes."] = "因为插件的代码重写，AutoPotion的设置已被重置。"
hamL["Useful for casters."] = "对于施法职业有用。"
-- code
hamL["AutoPotion"] = "自疗"
hamL["Auto Potion Title"]  = "|cff33ff99[便捷]|r自动药剂"
elseif GetLocale() == "zhTW" then
-- InterfaceOptionsFrame
hamL["Addon Behaviour"] = "插件功能"
hamL["Auto Potion Settings"] = "自動藥水 設定"
hamL["Cavedweller's Delight"] = "穴居者之喜"
hamL["Class/Racial Spells"] = "職業/種族技能"
hamL["Configure the behavior of the addon. IE: if you want to include class spells"] = "這裡可以調整插件的功能，例如也能使用職業法術。"
hamL["Current Priority"] = "目前的優先順序"
hamL["Bandage Priority"] = "繃帶優先"
hamL["Heartseeking Health Injector (tinker)"] = "覓心生命注射器 (裝置)"
hamL["Include /stopcasting in the macro"] = "包含 /在巨集中的停止施法"
hamL["Includes the shortest Cooldown in the reset Condition of Castsequence. !!USE CAREFULLY!!"] = "連續施放的重置條件使用最短的冷卻時間。!!請謹慎使用!!"
hamL["Invalid option: "] = "無效選項："
hamL["Items"] = "物品"
hamL["Low Priority Healthstones"] = "低優先級治療石"
hamL["Potion of Withering Dreams"] = "枯萎夢境藥水"
hamL["Potion of Withering Vitality"] = "凋萎活力藥水"
hamL["Prioritize health potions over a healthstone."] = "將治療藥水優先於治療石。"
hamL["Reset successful!"] = "重置成功！"
hamL["Reset to Default"] = "重置為預設值"
hamL["The Settings of AutoPotion were reset due to breaking changes."] = "因為插件大改版的關係，自動藥水的設定已被重置。"
hamL["Useful for casters."] = "對於施法者是很有用的。"
-- code
hamL["AutoPotion"] = "藥水"
hamL["Auto Potion Title"]  = "|cff33ff99[便捷]|r自動藥水"
else
-- InterfaceOptionsFrame
hamL["Addon Behaviour"] = "Addon Behaviour"
hamL["Auto Potion Settings"] = "Auto Potion Settings"
hamL["Cavedweller's Delight"] = "Cavedweller's Delight"
hamL["Class/Racial Spells"] = "Class/Racial Spells"
hamL["Configure the behavior of the addon. IE: if you want to include class spells"] = "Configure the behavior of the addon. IE: if you want to include class spells"
hamL["Current Priority"] = "Current Priority"
hamL["Bandage Priority"] = "Bandage Priority"
hamL["Heartseeking Health Injector (tinker)"] = "Heartseeking Health Injector (tinker)"
hamL["Include /stopcasting in the macro"] = "Include /stopcasting in the macro"
hamL["Includes the shortest Cooldown in the reset Condition of Castsequence. !!USE CAREFULLY!!"] = "Includes the shortest Cooldown in the reset Condition of Castsequence. !!USE CAREFULLY!!"
hamL["Invalid option: "] = "Invalid option: "
hamL["Items"] = "Items"
hamL["Low Priority Healthstones"] = "Low Priority Healthstones"
hamL["Potion of Withering Dreams"] = "Potion of Withering Dreams"
hamL["Potion of Withering Vitality"] = "Potion of Withering Vitality"
hamL["Prioritize health potions over a healthstone."] = "Prioritize health potions over a healthstone."
hamL["Reset successful!"] = "Reset successful!"
hamL["Reset to Default"] = "Reset to Default"
hamL["The Settings of AutoPotion were reset due to breaking changes."] = "The Settings of AutoPotion were reset due to breaking changes."
hamL["Useful for casters."] = "Useful for casters."
-- code
hamL["AutoPotion"] = "AutoPotion"
hamL["AutoBandage"] = "AutoBandage"
hamL["Auto Potion Title"] = "|cff33ff99[Cool]|rAutoPotion"
end

local ham = {}
-- Classic battleground UI Map IDs
-- Exposed on `ham` for use across modules (bandages, potions, etc.)
ham.MAP_ID_ALTERAC_VALLEY = 1459
ham.MAP_ID_WARSONG_GULCH = 1460
ham.MAP_ID_ARATHI_BASIN = 1461
local isRetail = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)

ham.Spell = {}

ham.Spell.new = function(id)
    local self = {}

    self.id = id
    if isRetail == true then
        self.cd = C_Spell.GetSpellCooldown(id).duration
        self.name = C_Spell.GetSpellName(id)
    else
        self.cd = GetSpellBaseCooldown(id)
        self.name = GetSpellInfo(id)
    end

    function self.getId()
        return self.id
    end

    function self.getName()
        return self.name
    end

    function self.getCd()
        return self.cd
    end

    function self.isKnown()
        return IsSpellKnown(self.id) or IsSpellKnown(self.id, true)
    end

    return self
end


ham.crimsonVialSpell = ham.Spell.new(185311)
ham.renewal = ham.Spell.new(108238)
ham.exhilaration = ham.Spell.new(109304)
ham.fortitudeOfTheBear = ham.Spell.new(388035)
ham.lastStand = ham.Spell.new(12975)
ham.bitterImmunity = ham.Spell.new(383762)
ham.desperatePrayer = ham.Spell.new(19236)
ham.expelHarm = ham.Spell.new(322101)
ham.healingElixir = ham.Spell.new(122281)
ham.darkPact = ham.Spell.new(108416)
ham.vampiricBlood = ham.Spell.new(55233)

-- Recuperate is only usable out of combat
ham.recuperate = ham.Spell.new(1231411)

--Racials WTF These are all seperate Spells
ham.giftOfTheNaaruDK = ham.Spell.new(59545)
ham.giftOfTheNaaruHunter = ham.Spell.new(59543)
ham.giftOfTheNaaruMage = ham.Spell.new(59548)
ham.giftOfTheNaaruMageWarlock = ham.Spell.new(416250)
ham.giftOfTheNaaruMonk = ham.Spell.new(121093)
ham.giftOfTheNaaruPaladin = ham.Spell.new(59542)
ham.giftOfTheNaaruPriest = ham.Spell.new(59544)
ham.giftOfTheNaaruRogue = ham.Spell.new(370626)
ham.giftOfTheNaaruShaman = ham.Spell.new(59547)
ham.giftOfTheNaaruWarrior = ham.Spell.new(28880)

ham.bagOfTricks = ham.Spell.new(312411)

ham.supportedSpells = {}
table.insert(ham.supportedSpells, ham.recuperate)
table.insert(ham.supportedSpells, ham.crimsonVialSpell)
table.insert(ham.supportedSpells, ham.renewal)
table.insert(ham.supportedSpells, ham.exhilaration)
table.insert(ham.supportedSpells, ham.fortitudeOfTheBear)
table.insert(ham.supportedSpells, ham.lastStand)
table.insert(ham.supportedSpells, ham.bitterImmunity)
table.insert(ham.supportedSpells, ham.desperatePrayer)
table.insert(ham.supportedSpells, ham.expelHarm)
table.insert(ham.supportedSpells, ham.healingElixir)
table.insert(ham.supportedSpells, ham.darkPact)
table.insert(ham.supportedSpells, ham.vampiricBlood)
table.insert(ham.supportedSpells, ham.giftOfTheNaaruDK)
table.insert(ham.supportedSpells, ham.giftOfTheNaaruHunter)
table.insert(ham.supportedSpells, ham.giftOfTheNaaruMage)
table.insert(ham.supportedSpells, ham.giftOfTheNaaruMageWarlock)
table.insert(ham.supportedSpells, ham.giftOfTheNaaruMonk)
table.insert(ham.supportedSpells, ham.giftOfTheNaaruPaladin)
table.insert(ham.supportedSpells, ham.giftOfTheNaaruPriest)
table.insert(ham.supportedSpells, ham.giftOfTheNaaruRogue)
table.insert(ham.supportedSpells, ham.giftOfTheNaaruShaman)
table.insert(ham.supportedSpells, ham.giftOfTheNaaruWarrior)
table.insert(ham.supportedSpells, ham.bagOfTricks)


ham.Item = {}

ham.Item.new = function(id, name)
  local self = {}

  self.id = id
  self.name = name

  local function setName()
    local itemInfoName = C_Item.GetItemInfo(self.id)
    if itemInfoName ~= nil then
      self.name = itemInfoName
    end
  end

  function self.getId()
    return self.id
  end

  function self.getCount()
    return C_Item.GetItemCount(self.id, false, false)
  end

  return self
end

ham.defaults = {
    cdReset = false,
    stopCast = false,
    raidStone = false,
    witheringPotion = false,
    witheringDreamsPotion = false,
    cavedwellerDelight = true,
    heartseekingInjector = false,
    activatedSpells = { ham.recuperate.getId(), ham.crimsonVialSpell.getId(), ham.renewal.getId(),
        ham.exhilaration.getId(), ham.fortitudeOfTheBear.getId(), ham.lastStand.getId(), ham.bitterImmunity.getId(),
        ham.desperatePrayer.getId(), ham.healingElixir.getId(), ham.darkPact.getId(), ham.giftOfTheNaaruDK.getId(),
        ham.giftOfTheNaaruHunter.getId(), ham.giftOfTheNaaruMage.getId(), ham.giftOfTheNaaruMageWarlock.getId(),
        ham.giftOfTheNaaruMonk.getId(), ham.giftOfTheNaaruPaladin.getId(), ham.giftOfTheNaaruPriest.getId(),
        ham.giftOfTheNaaruRogue.getId(), ham.giftOfTheNaaruShaman.getId(), ham.giftOfTheNaaruWarrior.getId(),
        ham.bagOfTricks.getId() }
}

function ham.dbContains(id)
    local found = false
    for _, v in pairs(HAMDB.activatedSpells) do
        if v == id then
            found = true
        end
    end
    return found
end

function ham.removeFromDB(id)
    local backup = {}
    if ham.dbContains(id) then
        for _, v in pairs(HAMDB.activatedSpells) do
            if v ~= id then
                table.insert(backup, v)
            end
        end
    end

    HAMDB.activatedSpells = CopyTable(backup)
end

function ham.insertIntoDB(id)
    table.insert(HAMDB.activatedSpells, id)
end

local isRetail = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)
local isClassic = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
local isWrath = (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC)
local isCata = (WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC)
local isMop = (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC)

ham.healthstone = ham.Item.new(5512, "Healthstone")
ham.demonicHealthstone = ham.Item.new(224464, "Demonic Healthstone") ---1 Minute CD due to Pact of Gluttony
ham.invigoratingHealingPotionR3 = ham.Item.new(244839, "Invigorating Healing Potion")
ham.invigoratingHealingPotionR2 = ham.Item.new(244838, "Invigorating Healing Potion")
ham.invigoratingHealingPotionR1 = ham.Item.new(244835, "Invigorating Healing Potion")
ham.fleetingInvigoratingHealingPotionR3 = ham.Item.new(244849, "Fleeting Invigorating Healing Potion")
ham.fleetingInvigoratingHealingPotionR2 = ham.Item.new(244848, "Fleeting Invigorating Healing Potion")
ham.fleetingInvigoratingHealingPotionR1 = ham.Item.new(244847, "Fleeting Invigorating Healing Potion")
ham.algariHealingPotionR3 = ham.Item.new(211880, "Algari Healing Potion")
ham.algariHealingPotionR2 = ham.Item.new(211879, "Algari Healing Potion")
ham.algariHealingPotionR1 = ham.Item.new(211878, "Algari Healing Potion")
ham.fleetingAlgariHealingPotionR3 = ham.Item.new(212944, "Fleeting Algari Healing Potion")
ham.fleetingAlgariHealingPotionR2 = ham.Item.new(212943, "Fleeting Algari Healing Potion")
ham.fleetingAlgariHealingPotionR1 = ham.Item.new(212942, "Fleeting Algari Healing Potion")
ham.cavedwellersDelightR3 = ham.Item.new(212244, "Cavedweller's Delight")
ham.cavedwellersDelightR2 = ham.Item.new(212243, "Cavedweller's Delight")
ham.cavedwellersDelightR1 = ham.Item.new(212242, "Cavedweller's Delight")
ham.fleetingCavedwellersDelightR3 = ham.Item.new(212950, "Fleeting Cavedweller's Delight")
ham.fleetingCavedwellersDelightR2 = ham.Item.new(212949, "Fleeting Cavedweller's Delight")
ham.fleetingCavedwellersDelightR1 = ham.Item.new(212948, "Fleeting Cavedweller's Delight")
ham.thirdWind = ham.Item.new(138486, "\"Third Wind\" Potion")
ham.survivalistsHealingPotion = ham.Item.new(224021, "Survivalist's Healing Potion")
ham.witheringDreamsR3 = ham.Item.new(207041, "Potion of Withering Dreams")
ham.witheringDreamsR2 = ham.Item.new(207040, "Potion of Withering Dreams")
ham.witheringDreamsR1 = ham.Item.new(207039, "Potion of Withering Dreams")
ham.dreamR3 = ham.Item.new(207023, "Dreamwalker's Healing Potion")
ham.dreamsR2 = ham.Item.new(207022, "Dreamwalker's Healing Potion")
ham.dreamR1 = ham.Item.new(207021, "Dreamwalker's Healing Potion")
ham.witheringR3 = ham.Item.new(191371, "Potion of Withering Vitality")
ham.witheringR2 = ham.Item.new(191370, "Potion of Withering Vitality")
ham.witheringR1 = ham.Item.new(191369, "Potion of Withering Vitality")
ham.refreshingR3 = ham.Item.new(191380, "Refreshing Healing Potion")
ham.refreshingR2 = ham.Item.new(191379, "Refreshing Healing Potion")
ham.refreshingR1 = ham.Item.new(191378, "Refreshing Healing Potion")
ham.cosmic = ham.Item.new(187802, "Cosmic Healing Potion")
ham.spiritual = ham.Item.new(171267, "Spiritual Healing Potion")
ham.soulful = ham.Item.new(180317, "Soulful Healing Potion")
ham.ashran = ham.Item.new(115498, "Ashran Healing Tonic")
ham.abyssal = ham.Item.new(169451, "Abyssal Healing Potion")
ham.astral = ham.Item.new(152615, "Astral Healing Potion")
ham.coastal = ham.Item.new(152494, "Coastal Healing Potion")
ham.ancient = ham.Item.new(127834, "Ancient Healing Potion")
ham.aged = ham.Item.new(136569, "Aged Health Potion")
ham.tonic = ham.Item.new(109223, "Healing Tonic")
--Mists
ham.master = ham.Item.new(76097, "Master Healing Potion")
--Cata
ham.roguesDraught = ham.Item.new(63300, "Rogue's Draught")
ham.mythical = ham.Item.new(57191, "Mythical Healing Potion")
ham.crazy_alch = ham.Item.new(40077, "Crazy Alchemist's Potion")
ham.runic_inject = ham.Item.new(41166, "Runic Healing Injector")
ham.runic = ham.Item.new(33447, "Runic Healing Potion")
ham.superreju = ham.Item.new(22850, "Super Rejuvenation Potion")
ham.endless = ham.Item.new(43569, "Endless Healing Potion")
ham.injector = ham.Item.new(33092, "Healing Potion Injector")
ham.resurgent = ham.Item.new(39671, "Resurgent Healing Potion")
ham.argent = ham.Item.new(43531, "Argent Healing Potion")
ham.auchenai = ham.Item.new(32947, "Auchenai Healing Potion")
ham.super = ham.Item.new(22829, "Super Healing Potion")
ham.major = ham.Item.new(13446, "Major Healing Potion")
ham.lesser = ham.Item.new(858, "Lesser Healing Potion")
ham.combat = ham.Item.new(18839, "Combat Healing Potion")
--superior has probably wrong scaling
ham.superior = ham.Item.new(3928, "Superior Healing Potion")
ham.minor = ham.Item.new(118, "Minor Healing Potion")
ham.greater = ham.Item.new(1710, "Greater Healing Potion")
ham.healingPotion = ham.Item.new(929, "Healing Potion")
-- Classic PvP battleground-only draughts
ham.majorHealingDraught = ham.Item.new(17348, "Major Healing Draught")
ham.superiorHealingDraught = ham.Item.new(17349, "Superior Healing Draught")

------Healthstones for Classic------
ham.minor0 = ham.Item.new(5512, "Minor Healthstone")
ham.minor1 = ham.Item.new(19004, "Minor Healthstone")
ham.minor2 = ham.Item.new(19005, "Minor Healthstone")
ham.lesser0 = ham.Item.new(5511, "Lesser Healthstone")
ham.lesser1 = ham.Item.new(19006, "Lesser Healthstone")
ham.lesser2 = ham.Item.new(19007, "Lesser Healthstone")
ham.crystalFlakeThroatLozenge = ham.Item.new(23683, "Crystal Flake Throat Lozenge")
ham.healtsthone0 = ham.Item.new(5509, "Healthstone")
ham.lilyRoot = ham.Item.new(14894, "Lily Root")
ham.healtsthone1 = ham.Item.new(19008, "Healthstone")
ham.healtsthone2 = ham.Item.new(19009, "Healthstone")
ham.wipperRootTuber = ham.Item.new(11951, "Whipper Root Tuber")
ham.greater0 = ham.Item.new(5510, "Greater Healthstone")
ham.greater1 = ham.Item.new(19010, "Greater Healthstone")
ham.greater2 = ham.Item.new(19011, "Greater Healthstone")
ham.major0 = ham.Item.new(9421, "Major Healthstone")
ham.major1 = ham.Item.new(19012, "Major Healthstone")
ham.major2 = ham.Item.new(19013, "Major Healthstone")
------Healthstones for WotLK------
ham.master0 = ham.Item.new(22103, "Master Healthstone")
ham.master1 = ham.Item.new(22104, "Master Healthstone")
ham.master2 = ham.Item.new(22105, "Master Healthstone")
ham.demonicWotLK0 = ham.Item.new(36889, "Demonic Healthstone")
ham.demonicWotLK1 = ham.Item.new(36890, "Demonic Healthstone")
ham.demonicWotLK2 = ham.Item.new(36891, "Demonic Healthstone")
ham.fel0 = ham.Item.new(36892, "Fel Healthstone")
ham.fel1 = ham.Item.new(36893, "Fel Healthstone")
ham.fel2 = ham.Item.new(36894, "Fel Healthstone")
------Healthstones for Cata------

function RemoveFromList(list, itemToRemove)
  for i = #list, 1, -1 do
    if list[i] == itemToRemove then
      table.remove(list, i)
    end
  end
end

function ham.getDelightPots()
  if isRetail then
    return {
      ham.cavedwellersDelightR3,
      ham.cavedwellersDelightR2,
      ham.cavedwellersDelightR1,
      ham.fleetingCavedwellersDelightR3,
      ham.fleetingCavedwellersDelightR2,
      ham.fleetingCavedwellersDelightR1,
    }
  end
  return {}
end

function ham.getPots()
  if isRetail then
    local pots = {
      ham.fleetingInvigoratingHealingPotionR3,
      ham.invigoratingHealingPotionR3,
      ham.fleetingInvigoratingHealingPotionR2,
      ham.invigoratingHealingPotionR2,
      ham.fleetingInvigoratingHealingPotionR1,
      ham.invigoratingHealingPotionR1,
      ham.fleetingAlgariHealingPotionR3,
      ham.algariHealingPotionR3,
      ham.fleetingAlgariHealingPotionR2,
      ham.algariHealingPotionR2,
      ham.fleetingAlgariHealingPotionR1,
      ham.algariHealingPotionR1,
      ham.thirdWind,
      ham.survivalistsHealingPotion,
      ham.witheringDreamsR3,
      ham.witheringDreamsR2,
      ham.witheringDreamsR1,
      ham.dreamR3,
      ham.dreamsR2,
      ham.dreamR1,
      ham.witheringR3,
      ham.witheringR2,
      ham.witheringR1,
      ham.refreshingR3,
      ham.refreshingR2,
      ham.refreshingR1,
      ham.cosmic,
      ham.spiritual,
      ham.soulful,
      ham.ashran,
      ham.abyssal,
      ham.astral,
      ham.coastal,
      ham.ancient,
      ham.aged,
      ham.tonic,
      ham.master,
      ham.mythical,
      ham.runic,
      ham.resurgent,
      ham.super,
      ham.major,
      ham.lesser,
      ham.superior,
      ham.minor,
      ham.greater,
      ham.healingPotion
    }


    local isUnratedBattleground = C_PvP.IsBattleground() and not C_PvP.IsRatedBattleground()
    if not isUnratedBattleground then
      RemoveFromList(pots, ham.thirdWind)
    end

    if not HAMDB.witheringPotion then
      RemoveFromList(pots, ham.witheringR1)
      RemoveFromList(pots, ham.witheringR2)
      RemoveFromList(pots, ham.witheringR3)
    end

    if not HAMDB.witheringDreamsPotion then
      RemoveFromList(pots, ham.witheringDreamsR1)
      RemoveFromList(pots, ham.witheringDreamsR2)
      RemoveFromList(pots, ham.witheringDreamsR3)
    end

    return pots
  end
  if isClassic then
    -- Base Classic potions list
    local pots = {
      ham.major,
      ham.combat,
      ham.superior,
      ham.greater,
      ham.healingPotion,
      ham.lesser,
      ham.minor
    }

    -- If in a PvP battleground, prioritize battleground draughts
    local inInstance, instanceType = IsInInstance()
    local isInBattleground = inInstance and instanceType == "pvp"
    if isInBattleground then
      -- Insert in reverse order so final priority is Major then Superior
      table.insert(pots, 1, ham.superiorHealingDraught)
      table.insert(pots, 1, ham.majorHealingDraught)
    end

    return pots
  end

  if isWrath then
    return {
      ham.crazy_alch,
      ham.runic_inject,
      ham.runic,
      ham.superreju,
      ham.endless,
      ham.injector,
      ham.resurgent,
      ham.super,
      ham.argent,
      ham.auchenai,
      ham.major,
      ham.superior,
      ham.greater,
      ham.healingPotion,
      ham.lesser,
      ham.minor
    }
  end

  if isCata then
    return {
      ham.roguesDraught,
      ham.mythical,
      ham.crazy_alch,
      ham.runic_inject,
      ham.runic,
      ham.superreju,
      ham.endless,
      ham.injector,
      ham.resurgent,
      ham.super,
      ham.argent,
      ham.auchenai,
      ham.major,
      ham.superior,
      ham.greater,
      ham.healingPotion,
      ham.lesser,
      ham.minor
    }
  end

  if isMop then
    return {
      ham.master,
      ham.roguesDraught,
      ham.mythical,
      ham.crazy_alch,
      ham.runic_inject,
      ham.runic,
      ham.superreju,
      ham.endless,
      ham.injector,
      ham.resurgent,
      ham.super,
      ham.argent,
      ham.auchenai,
      ham.major,
      ham.superior,
      ham.greater,
      ham.healingPotion,
      ham.lesser,
      ham.minor
    }
  end
end

function ham.getHealthstonesClassic()
  if isClassic then
    return {
      ham.major2,
      ham.major1,
      ham.major0,
      ham.greater2,
      ham.greater1,
      ham.greater0,
      ham.wipperRootTuber,
      ham.healtsthone2,
      ham.healtsthone1,
      ham.lilyRoot,
      ham.healtsthone0,
      ham.crystalFlakeThroatLozenge,
      ham.lesser2,
      ham.lesser1,
      ham.lesser0,
      ham.minor2,
      ham.minor1,
      ham.minor0
    }
  end

  if isWrath then
    return {
      ham.fel2,
      ham.fel1,
      ham.fel0,
      ham.demonicWotLK2,
      ham.demonicWotLK1,
      ham.demonicWotLK0,
      ham.master2,
      ham.master1,
      ham.master0,
      ham.major2,
      ham.major1,
      ham.major0,
      ham.greater2,
      ham.greater1,
      ham.greater0,
      ham.healtsthone2,
      ham.healtsthone1,
      ham.healtsthone0,
      ham.lesser2,
      ham.lesser1,
      ham.lesser0,
      ham.minor2,
      ham.minor1,
      ham.minor0
    }
  end

  if isCata then
    return {
      ham.fel2,
      ham.fel1,
      ham.fel0,
      ham.demonicWotLK2,
      ham.demonicWotLK1,
      ham.demonicWotLK0,
      ham.master2,
      ham.master1,
      ham.master0,
      ham.major2,
      ham.major1,
      ham.major0,
      ham.greater2,
      ham.greater1,
      ham.greater0,
      ham.healtsthone2,
      ham.healtsthone1,
      ham.healtsthone0,
      ham.lesser2,
      ham.lesser1,
      ham.lesser0,
      ham.minor2,
      ham.minor1,
      ham.minor0
    }
  end

  if isMop then
    return {
      ham.healthstone,
      --probably remove the stuff below since there should only be one healtsthone left with MoP
      ham.fel2,
      ham.fel1,
      ham.fel0,
      ham.demonicWotLK2,
      ham.demonicWotLK1,
      ham.demonicWotLK0,
      ham.master2,
      ham.master1,
      ham.master0,
      ham.major2,
      ham.major1,
      ham.major0,
      ham.greater2,
      ham.greater1,
      ham.greater0,
      ham.healtsthone2,
      ham.healtsthone1,
      ham.healtsthone0,
      ham.lesser2,
      ham.lesser1,
      ham.lesser0,
      ham.minor2,
      ham.minor1,
      ham.minor0
    }
  end
end


local isRetail = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)
local isClassic = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
local isWrath = (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC)
local isCata = (WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC)
local isMop = (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC)

-- Classic bandages
ham.linenBandage = ham.Item.new(1251, "Linen Bandage")
ham.heavyLinenBandage = ham.Item.new(2581, "Heavy Linen Bandage")
ham.woolBandage = ham.Item.new(3530, "Wool Bandage")
ham.heavyWoolBandage = ham.Item.new(3531, "Heavy Wool Bandage")
ham.silkBandage = ham.Item.new(6450, "Silk Bandage")
ham.heavySilkBandage = ham.Item.new(6451, "Heavy Silk Bandage")
ham.mageweaveBandage = ham.Item.new(8544, "Mageweave Bandage")
ham.heavyMageweaveBandage = ham.Item.new(8545, "Heavy Mageweave Bandage")
ham.runeclothBandage = ham.Item.new(14529, "Runecloth Bandage")
ham.heavyRuneclothBandage = ham.Item.new(14530, "Heavy Runecloth Bandage")

-- Alterac Valley (Classic-only)
ham.alteracHeavyRuneclothBandage = ham.Item.new(19307, "Alterac Heavy Runecloth Bandage")

-- Warsong Gulch (Classic-only)
ham.wsgRuneclothBandage = ham.Item.new(19066, "Warsong Gulch Runecloth Bandage")
ham.wsgMageweaveBandage = ham.Item.new(19067, "Warsong Gulch Mageweave Bandage")
ham.wsgSilkBandage = ham.Item.new(19068, "Warsong Gulch Silk Bandage")

-- Arathi Basin (Classic-only) - neutral bandages
ham.abMageweaveBandage = ham.Item.new(20065, "Arathi Basin Mageweave Bandage")
ham.abRuneclothBandage = ham.Item.new(20066, "Arathi Basin Runecloth Bandage")
ham.abSilkBandage = ham.Item.new(20067, "Arathi Basin Silk Bandage")

-- Arathi Basin (Classic-only) - faction bandages
-- Horde (Defiler's)
ham.defilersSilkBandage = ham.Item.new(20235, "Defiler's Silk Bandage")
ham.defilersMageweaveBandage = ham.Item.new(20232, "Defiler's Mageweave Bandage")
ham.defilersRuneclothBandage = ham.Item.new(20234, "Defiler's Runecloth Bandage")
-- Alliance (Highlander's)
ham.highlandersSilkBandage = ham.Item.new(20244, "Highlander's Silk Bandage")
ham.highlandersMageweaveBandage = ham.Item.new(20237, "Highlander's Mageweave Bandage")
ham.highlandersRuneclothBandage = ham.Item.new(20243, "Highlander's Runecloth Bandage")

-- TBC
ham.netherweaveBandage = ham.Item.new(21990, "Netherweave Bandage")
ham.heavyNetherweaveBandage = ham.Item.new(21991, "Heavy Netherweave Bandage")

-- WotLK
ham.frostweaveBandage = ham.Item.new(34721, "Frostweave Bandage")
ham.heavyFrostweaveBandage = ham.Item.new(34722, "Heavy Frostweave Bandage")

-- Cataclysm
ham.embersilkBandage = ham.Item.new(53049, "Embersilk Bandage")
ham.heavyEmbersilkBandage = ham.Item.new(53050, "Heavy Embersilk Bandage")
ham.denseEmbersilkBandage = ham.Item.new(53051, "Dense Embersilk Bandage")

-- Mists of Pandaria
ham.windwoolBandage = ham.Item.new(72985, "Windwool Bandage")
ham.heavyWindwoolBandage = ham.Item.new(72986, "Heavy Windwool Bandage")

-- Retail (Dragonflight)
ham.wilderclothBandage = ham.Item.new(194041, "Wildercloth Bandage")
ham.denseWilderclothBandage = ham.Item.new(194207, "Dense Wildercloth Bandage")

-- Return a prioritized list of bandage items for the current client
function ham.getBandages()
  -- Classic Era only has classic bandages
  if isClassic then
    -- Base priority list for Classic
    local list = {
      ham.heavyRuneclothBandage,
      ham.runeclothBandage,
      ham.heavyMageweaveBandage,
      ham.mageweaveBandage,
      ham.heavySilkBandage,
      ham.silkBandage,
      ham.heavyWoolBandage,
      ham.woolBandage,
      ham.heavyLinenBandage,
      ham.linenBandage,
    }

    -- When inside a PvP instance, prioritize battleground-specific bandages
    local inInstance, instanceType = IsInInstance()
    if inInstance and instanceType == "pvp" then
      local mapId = C_Map.GetBestMapForUnit("player")
      -- Alterac Valley
      if mapId == ham.MAP_ID_ALTERAC_VALLEY then
        if ham.alteracHeavyRuneclothBandage.getCount() > 0 then
          table.insert(list, 1, ham.alteracHeavyRuneclothBandage)
        end
      end
      -- Warsong Gulch
      if mapId == ham.MAP_ID_WARSONG_GULCH then
        -- Highest to lowest: Runecloth > Mageweave > Silk
        if ham.wsgRuneclothBandage.getCount() > 0 then
          table.insert(list, 1, ham.wsgRuneclothBandage)
        elseif ham.wsgMageweaveBandage.getCount() > 0 then
          table.insert(list, 1, ham.wsgMageweaveBandage)
        elseif ham.wsgSilkBandage.getCount() > 0 then
          table.insert(list, 1, ham.wsgSilkBandage)
        end
      end
      -- Arathi Basin
      if mapId == ham.MAP_ID_ARATHI_BASIN then
        local faction = UnitFactionGroup("player")
        -- Build AB-specific priority (runecloth > mageweave > silk), faction first then neutral
        local abPriority = {}
        if faction == "Alliance" then
          table.insert(abPriority, ham.highlandersRuneclothBandage)
          table.insert(abPriority, ham.abRuneclothBandage)
          table.insert(abPriority, ham.highlandersMageweaveBandage)
          table.insert(abPriority, ham.abMageweaveBandage)
          table.insert(abPriority, ham.highlandersSilkBandage)
          table.insert(abPriority, ham.abSilkBandage)
        else
          table.insert(abPriority, ham.defilersRuneclothBandage)
          table.insert(abPriority, ham.abRuneclothBandage)
          table.insert(abPriority, ham.defilersMageweaveBandage)
          table.insert(abPriority, ham.abMageweaveBandage)
          table.insert(abPriority, ham.defilersSilkBandage)
          table.insert(abPriority, ham.abSilkBandage)
        end
        for _, bandage in ipairs(abPriority) do
          if bandage.getCount() > 0 then
            table.insert(list, 1, bandage)
            break
          end
        end
      end
    end

    return list
  end

  -- Wrath Classic
  if isWrath then
    return {
      ham.heavyFrostweaveBandage,
      ham.frostweaveBandage,
      ham.heavyNetherweaveBandage,
      ham.netherweaveBandage,
      ham.heavyRuneclothBandage,
      ham.runeclothBandage,
      ham.heavyMageweaveBandage,
      ham.mageweaveBandage,
      ham.heavySilkBandage,
      ham.silkBandage,
      ham.heavyWoolBandage,
      ham.woolBandage,
      ham.heavyLinenBandage,
      ham.linenBandage,
    }
  end

  -- Cataclysm Classic
  if isCata then
    return {
      ham.denseEmbersilkBandage,
      ham.heavyEmbersilkBandage,
      ham.embersilkBandage,
      ham.heavyFrostweaveBandage,
      ham.frostweaveBandage,
      ham.heavyNetherweaveBandage,
      ham.netherweaveBandage,
      ham.heavyRuneclothBandage,
      ham.runeclothBandage,
      ham.heavyMageweaveBandage,
      ham.mageweaveBandage,
      ham.heavySilkBandage,
      ham.silkBandage,
      ham.heavyWoolBandage,
      ham.woolBandage,
      ham.heavyLinenBandage,
      ham.linenBandage,
    }
  end

  -- Mists Classic
  if isMop then
    return {
      ham.heavyWindwoolBandage,
      ham.windwoolBandage,
      ham.denseEmbersilkBandage,
      ham.heavyEmbersilkBandage,
      ham.embersilkBandage,
      ham.heavyFrostweaveBandage,
      ham.frostweaveBandage,
      ham.heavyNetherweaveBandage,
      ham.netherweaveBandage,
      ham.heavyRuneclothBandage,
      ham.runeclothBandage,
      ham.heavyMageweaveBandage,
      ham.mageweaveBandage,
      ham.heavySilkBandage,
      ham.silkBandage,
      ham.heavyWoolBandage,
      ham.woolBandage,
      ham.heavyLinenBandage,
      ham.linenBandage,
    }
  end

  -- Retail (include modern first, then legacy in case they exist)
  return {
    ham.denseWilderclothBandage,
    ham.wilderclothBandage,
    ham.heavyWindwoolBandage,
    ham.windwoolBandage,
    ham.denseEmbersilkBandage,
    ham.heavyEmbersilkBandage,
    ham.embersilkBandage,
    ham.heavyFrostweaveBandage,
    ham.frostweaveBandage,
    ham.heavyNetherweaveBandage,
    ham.netherweaveBandage,
    ham.heavyRuneclothBandage,
    ham.runeclothBandage,
    ham.heavyMageweaveBandage,
    ham.mageweaveBandage,
    ham.heavySilkBandage,
    ham.silkBandage,
    ham.heavyWoolBandage,
    ham.woolBandage,
    ham.heavyLinenBandage,
    ham.linenBandage,
  }
end



ham.Player = {}

ham.Player.new = function()
  local self = {}

  self.localizedClass, self.englishClass, self.classIndex = UnitClass("player");

  function self.getHealingItems()
    local healingItems = {}
    return healingItems
  end

  function self.getHealingSpells()
    local mySpells = {}
    for i, id in ipairs(HAMDB.activatedSpells) do
      local currentSpell = ham.Spell.new(id)
      if currentSpell.isKnown() then
        table.insert(mySpells, currentSpell)
      end
    end
    return mySpells
  end

  return self
end


local macroName = hamL["AutoPotion"]
local bandageMacroName = hamL["AutoBandage"] or "AutoBandage"
local isRetail = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)
local isClassic = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
local isWrath = (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC)
local isCata = (WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC)
local isMop = (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC)

-- Configuration options
-- Use in-memory options as HAMDB updates are not persisted instantly.
-- We'll also use lazy initialization to prevent early access issues.
setmetatable(ham, {
  __index = function(t, k)
    if k == "options" then
      t.options = {
        cdReset = HAMDB.cdReset or false,
        stopCast = HAMDB.stopCast or false,
        raidStone = HAMDB.raidStone or false,
        witheringPotion = HAMDB.witheringPotion or false,
        witheringDreamsPotion = HAMDB.witheringDreamsPotion or false,
        cavedwellerDelight = HAMDB.cavedwellerDelight or true,
        heartseekingInjector = HAMDB.heartseekingInjector or false,
      }
      return t.options
    end
  end
})

ham.debug = false
ham.tinkerSlot = nil
ham.myPlayer = ham.Player.new()

local spellsMacroString = ''
local itemsMacroString = ''
local macroStr = ''
local resetType = "combat"
local shortestCD = nil
local bagUpdates = false -- debounce watcher for BAG_UPDATE events
local debounceTime = 3   -- seconds
local combatRetry = 0    -- number of combat retries

-- MegaMacro addon compatibility
local megaMacro = {
  name = "MegaMacro", -- the addon name
  retries = 0,        -- number of loaded checks to prevent infinite loop
  checked = false,    -- did we check for the addon?
  installed = false,  -- is the addon installed?
  loaded = false,     -- is the addon loaded?
}

-- Slots to check for tinkers
-- As of 2024-10-27, only Head, Wrist and Guns can have tinkers.
local tinkerSlots = {
  1,  -- Head
  9,  -- Wrist
  18, -- Gun
  14, -- Trinket 2 (for debugging)
}

local function log(message)
  if ham.debug then
    print(hamL["Auto Potion Title"] .. message)
  end
end

local function addPlayerHealingItemIfAvailable()
  if isRetail and ham.options.heartseekingInjector and ham.tinkerSlot then
    table.insert(ham.itemIdList, "slot:" .. ham.tinkerSlot)
  end
  for i, value in ipairs(ham.myPlayer.getHealingItems()) do
    if value.getCount() > 0 then
      table.insert(ham.itemIdList, value.getId())
      break;
    end
  end
end

local function addHealthstoneIfAvailable()
  if isClassic == true or isWrath == true or isCata == true or isMop == true then
    for i, value in ipairs(ham.getHealthstonesClassic()) do
      if value.getCount() > 0 then
        table.insert(ham.itemIdList, value.getId())
        --we break because all Healthstones share a cd so we only want the highest healing one
        break;
      end
    end
  else
    if ham.healthstone.getCount() > 0 then
      table.insert(ham.itemIdList, ham.healthstone.getId())
    end
    if ham.demonicHealthstone.getCount() > 0 then
      table.insert(ham.itemIdList, ham.demonicHealthstone.getId())
      if ham.options.cdReset then
        if shortestCD == nil then
          shortestCD = 60
        end
        if 60 < shortestCD then
          shortestCD = 60
        end
      end
    end
  end
end

local function addPotIfAvailable(useDelightPots)
  log("Updating pot counts...")
  useDelightPots = useDelightPots or false
  local pots = useDelightPots and ham.getDelightPots() or ham.getPots()
  for i, value in ipairs(pots) do
    log("Item: " .. tostring(value.getId()) .. " Count: " .. tostring(value.getCount()))
    if value.getCount() > 0 then
      table.insert(ham.itemIdList, value.getId())
      --we break because all Pots share a cd so we only want the highest healing one
      break;
    end
  end
end

function ham.updateHeals()
  ham.itemIdList = {}
  --ham.spellIDs = ham.myPlayer.getHealingSpells()
  ham.mySpells = ham.myPlayer.getHealingSpells()

  -- Priority 1: Add player items, including tinkers
  addPlayerHealingItemIfAvailable()

  -- Priority 2: Add Healthstone if NOT set to lower priority
  if not ham.options.raidStone then
    addHealthstoneIfAvailable()
  end

  -- Priority 3: Add Health Pots if available, and Heartseeking is NOT available or enabled
  if not ham.options.heartseekingInjector or not ham.tinkerSlot then
    addPotIfAvailable()
  end

  -- Priority 4: Add Cavedweller's Delight if enabled
  if ham.options.cavedwellerDelight then
    addPotIfAvailable(true)
  end

  -- Priority 5: Add Healthstone if set to lower priority
  if ham.options.raidStone then
    addHealthstoneIfAvailable()
  end
end

local function createMacroIfMissing()
  -- dont create macro if MegaMacro is installed and loaded
  if megaMacro.installed and megaMacro.loaded then
    return
  end
  local name = GetMacroInfo(macroName)
  if name == nil then
    CreateMacro(macroName, "INV_Misc_QuestionMark")
  end
end

local function createBandageMacroIfMissing()
  -- dont create macro if MegaMacro is installed and loaded
  if megaMacro.installed and megaMacro.loaded then
    return
  end
  local name = GetMacroInfo(bandageMacroName)
  if name == nil then
    CreateMacro(bandageMacroName, "INV_Misc_QuestionMark")
  end
end

local function setShortestSpellCD(newSpell)
  if ham.options.cdReset then
    local cd
    cd = GetSpellBaseCooldown(newSpell) / 1000
    if shortestCD == nil then
      shortestCD = cd
    end
    if cd < shortestCD then
      shortestCD = cd
    end
  end
end

local function setResetType()
  if ham.options.cdReset == true and shortestCD ~= nil then
    resetType = "combat/" .. shortestCD
  else
    resetType = "combat"
  end
end

local function buildSpellMacroString()
  spellsMacroString = ''

  if next(ham.mySpells) ~= nil then
    local spellCounter = 1
    for i, spell in ipairs(ham.mySpells) do
      local name = ''
      if spell.getId() == ham.recuperate.getId() then
        --we don't want to add recuperate because even thought its a spell its only usable out of combat
      else
        name = spell.getName();
        setShortestSpellCD(spell.getId())

        --TODO HEALING Elixir Twice because it has two charges ?! kinda janky but will work for now
        if spell.getId() == ham.healingElixir.getId() then
          name = spell.getName() .. ", " .. spell.getName()
        end
        if spellCounter == 1 then
          spellsMacroString = name;
        else
          spellsMacroString = spellsMacroString .. ", " .. name;
        end
        spellCounter = spellCounter + 1
      end
    end
  end
end

local function buildItemMacroString()
  if next(ham.itemIdList) ~= nil then
    for i, name in ipairs(ham.itemIdList) do
      local entry
      -- Check if the entry starts with "slot:" and extract the slot number
      if type(name) == "string" and name:match("^slot:") then
        entry = name:sub(6)               -- Extract everything after "slot:"
      else
        entry = "item:" .. tostring(name) -- Default to item ID formatting
      end
      -- Add the entry to the macro string
      if i == 1 then
        itemsMacroString = entry
      else
        itemsMacroString = itemsMacroString .. ", " .. entry
      end
    end
  end
end

local function UpdateMegaMacro(newCode)
  for _, macro in pairs(MegaMacroGlobalData.Macros) do
    if macro.DisplayName == macroName then
      MegaMacro.UpdateCode(macro, newCode)
      log("MegaMacro updated with: " .. newCode)
      return
    end
  end
  print(
    "|cffff0000自动药剂错误：在 MegaMacro 中缺少全局 "..hamL["AutoPotion"].." 宏。请创建它然后重新加载你的游戏。")
end

local function UpdateMegaMacroByName(name, newCode)
  for _, macro in pairs(MegaMacroGlobalData.Macros) do
    if macro.DisplayName == name then
      MegaMacro.UpdateCode(macro, newCode)
      log("MegaMacro updated (" .. name .. ") with: " .. newCode)
      return true
    end
  end
  print("|cffff0000AutoPotion Error:|r Missing global '" ..
    tostring(name) .. "' macro in MegaMacro. Please create it then reload your game.")
  return false
end

local function checkMegaMacroAddon()
  -- MegaMacro is only available for retail
  if not isRetail then
    megaMacro.checked = true
    return
  end

  -- is MegaMacro installed?
  local name = C_AddOns.GetAddOnInfo(megaMacro.name)
  if not name then
    megaMacro.installed = false
    megaMacro.checked = true
    return
  end

  megaMacro.installed = true

  -- is the addon loaded?
  if C_AddOns.IsAddOnLoaded(megaMacro.name) then
    megaMacro.loaded = true
    megaMacro.checked = true
    return
  end

  -- Retry loading if not yet loaded
  if megaMacro.retries < 3 then
    megaMacro.retries = megaMacro.retries + 1
    C_Timer.After(debounceTime, checkMegaMacroAddon)
  else
    megaMacro.checked = true
  end
end

-- Build bandage macro string (highest available bandage first)
local function buildBandageMacroString()
  local sequence = {}
  local bandages = ham.getBandages()
  for _, item in ipairs(bandages) do
    if item.getCount() > 0 then
      table.insert(sequence, "item:" .. tostring(item.getId()))
      break
    end
  end

  if #sequence == 0 then
    return "#showtooltip"
  end
  return "#showtooltip\n/use [@player] " .. sequence[1]
end

-- check if player has the engineering tinker: Heartseeking Health Injector
function ham.checkTinker()
  if not isRetail then return end
  ham.tinkerSlot = nil -- always reset
  for _, slot in ipairs(tinkerSlots) do
    local itemID = GetInventoryItemID("player", slot)
    if itemID then
      local spellName, spellID = C_Item.GetItemSpell(itemID)
      if spellName then
        -- note: i'm not an engineer, so i use a trinket with a use effect for debugging.
        -- this is why the "Phylactery" reference exists if debugging is enabled --- phuze.
        -- note: Using "spellName" to find "Heartseeking" can only support English region.
        -- So I add spellID to support other region, e.g. Taiwan (TW), China (CN) and Korea (KR) --- Nephits
        if ham.debug then
          if spellName:find("Phylactery") or spellName:find("Heartseeking") or spellID == 452767 then
            ham.tinkerSlot = slot
          end
        else
          if spellName:find("Heartseeking") or spellID == 452767 then
            ham.tinkerSlot = slot
          end
        end
      end
    end
  end
end

function ham.updateMacro()
  --if next(ham.itemIdList) == nil and next(ham.spellIDs) == nil then
  if next(ham.itemIdList) == nil and next(ham.mySpells) == nil then
    macroStr = "#showtooltip"
    if ham.options.stopCast then
      macroStr = macroStr .. "\n/stopcasting \n"
    end
  else
    resetType = "combat"
    buildItemMacroString()
    buildSpellMacroString()
    setResetType()
    macroStr = "#showtooltip \n"
    if ham.options.stopCast then
      macroStr = macroStr .. "/stopcasting \n"
    end
    --recuperate
    --this condition is needed because if not used the castsequence will use off gcd heals direclty after recuperate
    local combatCondition=''
    if isRetail and ham.dbContains(ham.recuperate.getId()) and ham.recuperate.isKnown() then
      combatCondition = ',combat'
      macroStr = macroStr .. "/cast [nocombat] " .. ham.recuperate.getName() .. "\n"
    end

    macroStr = macroStr .. "/castsequence [@player"..combatCondition.."] reset=" .. resetType .. " "
    if spellsMacroString ~= "" then
      macroStr = macroStr .. spellsMacroString
    end
    if spellsMacroString ~= "" and itemsMacroString ~= "" then
      macroStr = macroStr .. ", "
    end
    if itemsMacroString ~= "" then
      macroStr = macroStr .. itemsMacroString
    end
  end

  if not megaMacro.checked then
    log("未检查到 MegaMacro 插件。正在重试。")
    checkMegaMacroAddon()
    return
  end

  if megaMacro.installed and megaMacro.loaded then
    UpdateMegaMacro(macroStr)
    return
  end

  log("未启用 MegaMacro 插件。正在创建默认宏。")
  createMacroIfMissing()

  -- Use pcall to suppress LUA errors
  local success, err = pcall(function()
    EditMacro(macroName, macroName, nil, macroStr)
  end)
  if success then
    log('宏已更新。')
  end
end

function ham.updateBandageMacro()
  local bandageMacroStr = buildBandageMacroString()
  if megaMacro.installed and megaMacro.loaded then
    UpdateMegaMacroByName(bandageMacroName, bandageMacroStr)
  else
    createBandageMacroIfMissing()
    local success, err = pcall(function()
      EditMacro(bandageMacroName, bandageMacroName, nil, bandageMacroStr)
    end)
    if success then
      log('Bandage macro updated.')
    end
  end
end

local function MakeMacro()
  -- dont attempt to create macro until MegaMacro addon is checked
  if not megaMacro.checked then
    log("未检查到 MegaMacro 或未加载。正在重试。")
    checkMegaMacroAddon()
    return
  end

  -- retry if player is still in combat
  if InCombatLockdown() then
    if combatRetry < 4 then
      combatRetry = combatRetry + 1
      log("玩家正在战斗中。重试尝试：" .. combatRetry)
      C_Timer.After(0.5, MakeMacro)
    else
      log("在4次尝试后未能更新宏。")
    end
    return
  end

  -- safe to update macro
  combatRetry = 0
  ham.checkTinker()
  ham.updateHeals()
  ham.updateMacro()
  ham.updateBandageMacro()

  ham.settingsFrame:updatePrio()
  ham.settingsFrame:updateBandagePrio()
end

-- debounce handler for BAG_UPDATE events which can fire very rapidly
local function onBagUpdate()
  if bagUpdates then
    return
  end
  log("event: BAG_UPDATE")
  bagUpdates = true
  C_Timer.After(debounceTime, function()
    MakeMacro()
    bagUpdates = false
  end)
end

local updateFrame = CreateFrame("Frame")
updateFrame:RegisterEvent("ADDON_LOADED")
updateFrame:RegisterEvent("BAG_UPDATE")
updateFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
updateFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
if isClassic == false then
  updateFrame:RegisterEvent("TRAIT_CONFIG_UPDATED")
end
updateFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
updateFrame:RegisterEvent("UNIT_PET")
updateFrame:SetScript("OnEvent", function(self, event, arg1, ...)
  -- when addon is loaded
  if event == "ADDON_LOADED" and arg1 == "OrzUI" then
    updateFrame:UnregisterEvent("ADDON_LOADED")
    log("event: ADDON_LOADED")
    MakeMacro()
    return
  end
  -- player is in combat, do nothing
  if InCombatLockdown() then
    return
  end
  -- bag update events
  if event == "BAG_UPDATE" then
    onBagUpdate()
    -- on loading/reloading
  elseif event == "UNIT_PET" then
    log("event: UNIT_PET")
    MakeMacro()
    -- when pet is called
  elseif event == "PLAYER_ENTERING_WORLD" then
    log("event: PLAYER_ENTERING_WORLD")
    MakeMacro()
    -- on exiting combat
  elseif event == "PLAYER_REGEN_ENABLED" then
    log("event: PLAYER_REGEN_ENABLED")
    -- Wait a second after combat ends to update the macro
    -- as the UI may still be cleaning up a protected state.
    C_Timer.After(0.5, MakeMacro)
    -- when talents change and classic is false
  elseif isClassic == false and event == "TRAIT_CONFIG_UPDATED" then
    log("event: TRAIT_CONFIG_UPDATED")
    MakeMacro()
    -- when player changes equipment
  elseif event == "PLAYER_EQUIPMENT_CHANGED" then
    log("event: PLAYER_EQUIPMENT_CHANGED")
    MakeMacro()
  end
end)


_G["BINDING_NAME_MACRO AutoPotion"] = hamL["Auto Potion Title"]  --"AutoPotion Macro"
_G["BINDING_NAME_MACRO AutoBandage"] = "AutoBandage Macro"

local isRetail = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)
local isClassic = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
local isWrath = (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC)
local isCata = (WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC)

---@class Frame
ham.settingsFrame = CreateFrame("Frame")
local ICON_SIZE = 50
local PADDING_CATERGORY = 45
local PADDING = 25
local PADDING_HORIZONTAL = 220
local classButtons = {}
local prioFrames = {}
local prioTextures = {}
local prioFramesCounter = 0
local firstIcon = nil
local positionx = 0
local currentPrioTitle = nil
local myClassTitle = nil
local lastStaticElement = nil

-- Bandage priority UI state
local bandageFrames = {}
local bandageTextures = {}
local bandageFirstIcon = nil
local bandagePositionX = 0
local bandagePrioTitle = nil

function ham.settingsFrame:updateConfig(option, value)
	if ham.options[option] ~= nil then
		ham.options[option] = value -- Update in-memory
		HAMDB[option] = value -- Persist to DB
	else
		print(hamL["Invalid option: "] .. tostring(option))
	end
	-- Rebuild the macro and update priority frame
	ham.checkTinker()
	ham.updateHeals()
	ham.updateMacro()
	self:updatePrio()
	self:updateBandagePrio()
end

function ham.settingsFrame:OnEvent(event, addOnName)
	if addOnName == "OrzUI" then
		if event == "ADDON_LOADED" then
			HAMDB = HAMDB or CopyTable(ham.defaults)
			if HAMDB.activatedSpells == nil then
				print(hamL["The Settings of AutoPotion were reset due to breaking changes."])
				HAMDB = CopyTable(ham.defaults)
			end
			self:InitializeOptions()
		end
	end
	if event == "PLAYER_LOGIN" then
		self:InitializeClassSpells(myClassTitle)
		ham.updateHeals()
		ham.updateMacro()
		self:updatePrio()
		self:updateBandagePrio()
	end
end

ham.settingsFrame:RegisterEvent("PLAYER_LOGIN")
ham.settingsFrame:RegisterEvent("ADDON_LOADED")
ham.settingsFrame:SetScript("OnEvent", ham.settingsFrame.OnEvent)

function ham.settingsFrame:createPrioFrame(id, iconTexture, positionx, isSpell, isTinker)
	local icon = CreateFrame("Frame", nil, self.content, UIParent)
	icon:SetFrameStrata("MEDIUM")
	icon:SetWidth(ICON_SIZE)
	icon:SetHeight(ICON_SIZE)
	icon:HookScript("OnEnter", function(_, btn, down)
		GameTooltip:SetOwner(icon, "ANCHOR_TOPRIGHT")
		if isSpell == true then
			GameTooltip:SetSpellByID(id)
		elseif isTinker then
			GameTooltip:SetInventoryItem("player", id)
		else
			GameTooltip:SetItemByID(id)
		end
		GameTooltip:Show()
	end)
	icon:HookScript("OnLeave", function(_, btn, down)
		GameTooltip:Hide()
	end)
	local texture = icon:CreateTexture(nil, "BACKGROUND")
	texture:SetTexture(iconTexture)
	texture:SetAllPoints(icon)
	---@diagnostic disable-next-line: inject-field
	icon.texture = texture

	if firstIcon == nil then
		icon:SetPoint("TOPLEFT", currentPrioTitle, 0, -PADDING)
		firstIcon = icon
	else
		icon:SetPoint("TOPLEFT", firstIcon, positionx, 0)
	end
	icon:Show()
	table.insert(prioFrames, icon)
	table.insert(prioTextures, texture)
	prioFramesCounter = prioFramesCounter + 1
	return icon
end

-- Create a bandage priority icon frame
function ham.settingsFrame:createBandagePrioFrame(id, iconTexture, positionx)
	local icon = CreateFrame("Frame", nil, self.content, UIParent)
	icon:SetFrameStrata("MEDIUM")
	icon:SetWidth(ICON_SIZE)
	icon:SetHeight(ICON_SIZE)
	icon:HookScript("OnEnter", function(_, btn, down)
		GameTooltip:SetOwner(icon, "ANCHOR_TOPRIGHT")
		GameTooltip:SetItemByID(id)
		GameTooltip:Show()
	end)
	icon:HookScript("OnLeave", function(_, btn, down)
		GameTooltip:Hide()
	end)
	local texture = icon:CreateTexture(nil, "BACKGROUND")
	texture:SetTexture(iconTexture)
	texture:SetAllPoints(icon)
	---@diagnostic disable-next-line: inject-field
	icon.texture = texture

	if bandageFirstIcon == nil then
		icon:SetPoint("TOPLEFT", bandagePrioTitle, 0, -PADDING)
		bandageFirstIcon = icon
	else
		icon:SetPoint("TOPLEFT", bandageFirstIcon, positionx, 0)
	end
	icon:Show()
	table.insert(bandageFrames, icon)
	table.insert(bandageTextures, texture)
	return icon
end

function ham.settingsFrame:updatePrio()
	local spellCounter = 0
	local itemCounter = 0

	for i, frame in pairs(prioFrames) do
		frame:Hide()
	end

	-- Add spells to priority frames
	--if next(ham.spellIDs) ~= nil then
	if next(ham.mySpells) ~= nil then
		--for i, id in ipairs(ham.spellIDs) do
		for i, spell in ipairs(ham.mySpells) do
			local iconTexture, originalIconTexture
			if isRetail == true then
				iconTexture, originalIconTexture = C_Spell.GetSpellTexture(spell.getId())
			else
				iconTexture = GetSpellTexture(spell.getId())
			end
			local currentFrame = prioFrames[i]
			local currentTexture = prioTextures[i]
			if currentFrame ~= nil then
				currentFrame:SetScript("OnEnter", nil)
				currentFrame:SetScript("OnLeave", nil)
				currentFrame:HookScript("OnEnter", function(_, btn, down)
					GameTooltip:SetOwner(currentFrame, "ANCHOR_TOPRIGHT")
					GameTooltip:SetSpellByID(spell.getId())
					GameTooltip:Show()
				end)
				currentFrame:HookScript("OnLeave", function(_, btn, down)
					GameTooltip:Hide()
				end)
				currentTexture:SetTexture(iconTexture)
				currentTexture:SetAllPoints(currentFrame)
				currentFrame.texture = currentTexture
				currentFrame:Show()
			else
				self:createPrioFrame(id, iconTexture, positionx, true, false)
				positionx = positionx + (ICON_SIZE + (ICON_SIZE / 2))
			end
			spellCounter = spellCounter + 1
		end
	end

	-- Add items to priority frames
	if next(ham.itemIdList) ~= nil then
		for i, id in ipairs(ham.itemIdList) do
			local entry
			local iconTexture
			local isTinker = false

			-- if the entry is a gear slot (ie: tinker)
			if type(id) == "string" and id:match("^slot:") then
				local slot = assert(tonumber(id:sub(6)), "Invalid slot number")
				entry = GetInventoryItemID("player", slot)
				iconTexture = GetInventoryItemTexture("player", slot)
				isTinker = true
				-- otherwise its a normal item id
			else
				local _, _, _, _, _, _, _, _, _, tmpTexture = C_Item.GetItemInfo(id)
				entry = id
				iconTexture = tmpTexture
			end

			local currentFrame = prioFrames[i + spellCounter]
			local currentTexture = prioTextures[i + spellCounter]

			if currentFrame ~= nil then
				currentFrame:SetScript("OnEnter", nil)
				currentFrame:SetScript("OnLeave", nil)
				currentFrame:HookScript("OnEnter", function(_, btn, down)
					GameTooltip:SetOwner(currentFrame, "ANCHOR_TOPRIGHT")
					if isTinker then
						GameTooltip:SetInventoryItem("player", ham.tinkerSlot)
					else
						GameTooltip:SetItemByID(id)
					end
					GameTooltip:Show()
				end)
				currentFrame:HookScript("OnLeave", function(_, btn, down)
					GameTooltip:Hide()
				end)
				currentTexture:SetTexture(iconTexture)
				currentTexture:SetAllPoints(currentFrame)
				currentFrame.texture = currentTexture
				currentFrame:Show()
			else
				self:createPrioFrame(entry, iconTexture, positionx, false, isTinker)
				positionx = positionx + (ICON_SIZE + (ICON_SIZE / 2))
			end
			itemCounter = itemCounter + 1
		end
	end
end

-- Update the Bandage Priority section
function ham.settingsFrame:updateBandagePrio()
	-- hide existing
	for _, frame in pairs(bandageFrames) do
		frame:Hide()
	end

	bandagePositionX = 0

	-- Build the prioritized bandage list for the current context
	if ham.getBandages then
		local bandages = ham.getBandages()
		local shown = 0
		for _, item in ipairs(bandages) do
			if item.getCount and item.getCount() > 0 then
				local id = item.getId()
				local _, _, _, _, _, _, _, _, _, iconTexture = C_Item.GetItemInfo(id)
				local idx = shown + 1
				local currentFrame = bandageFrames[idx]
				local currentTexture = bandageTextures[idx]
				if currentFrame ~= nil then
					currentFrame:SetScript("OnEnter", nil)
					currentFrame:SetScript("OnLeave", nil)
					currentFrame:HookScript("OnEnter", function(_, btn, down)
						GameTooltip:SetOwner(currentFrame, "ANCHOR_TOPRIGHT")
						GameTooltip:SetItemByID(id)
						GameTooltip:Show()
					end)
					currentFrame:HookScript("OnLeave", function(_, btn, down)
						GameTooltip:Hide()
					end)
					currentTexture:SetTexture(iconTexture)
					currentTexture:SetAllPoints(currentFrame)
					currentFrame.texture = currentTexture
					currentFrame:Show()
				else
					self:createBandagePrioFrame(id, iconTexture, bandagePositionX)
					bandagePositionX = bandagePositionX + (ICON_SIZE + (ICON_SIZE / 2))
				end
				shown = shown + 1
			end
		end
	end
end

function ham.settingsFrame:InitializeOptions()
	-- Create the main panel inside the Interface Options container
	self.panel = CreateFrame("Frame", hamL["Auto Potion Title"], InterfaceOptionsFramePanelContainer)
	self.panel.name = hamL["Auto Potion Title"]

	-- Register with Interface Options
	if InterfaceOptions_AddCategory then
		InterfaceOptions_AddCategory(self.panel)
	else
        local category = Settings.RegisterCanvasLayoutCategory(self.panel, hamL["Auto Potion Title"])
		Settings.RegisterAddOnCategory(category)
		self.panel.categoryID = category:GetID() -- for OpenToCategory use
	end

	-- inset frame to provide some padding
	self.content = CreateFrame("Frame", nil, self.panel)
	self.content:SetPoint("TOPLEFT", self.panel, "TOPLEFT", 16, -16)
	self.content:SetPoint("BOTTOMRIGHT", self.panel, "BOTTOMRIGHT", -16, 16)

	-- title
	local title = self.content:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
	title:SetPoint("TOP", 0, 0)
	title:SetText(hamL["Auto Potion Settings"])

	-- subtitle
	local subtitle = self.content:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	subtitle:SetPoint("TOPLEFT", 0, -40)
	subtitle:SetText(hamL["Configure the behavior of the addon. IE: if you want to include class spells"])

	-- behavior title
	local behaviourTitle = self.content:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
	behaviourTitle:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -PADDING)
	behaviourTitle:SetText(hamL["Addon Behaviour"])

	-------------  Stop Casting  -------------	
	local stopCastButton = CreateFrame("CheckButton", nil, self.content, "InterfaceOptionsCheckButtonTemplate")
	stopCastButton:SetPoint("TOPLEFT", behaviourTitle, 0, -PADDING)
	---@diagnostic disable-next-line: undefined-field
	stopCastButton.Text:SetText(hamL["Include /stopcasting in the macro"])
	stopCastButton:HookScript("OnClick", function(_, btn, down)
		ham.settingsFrame:updateConfig("stopCast", stopCastButton:GetChecked())
	end)
	stopCastButton:HookScript("OnEnter", function(_, btn, down)
		---@diagnostic disable-next-line: param-type-mismatch
		GameTooltip:SetOwner(stopCastButton, "ANCHOR_TOPRIGHT")
		GameTooltip:SetText(hamL["Useful for casters."])
		GameTooltip:Show()
	end)
	stopCastButton:HookScript("OnLeave", function(_, btn, down)
		GameTooltip:Hide()
	end)
	stopCastButton:SetChecked(HAMDB.stopCast)
	lastStaticElement = stopCastButton

	-------------  Shortest Cooldown  -------------	
	local cdResetButton = CreateFrame("CheckButton", nil, self.content, "InterfaceOptionsCheckButtonTemplate")
	cdResetButton:SetPoint("TOPLEFT", lastStaticElement, 0, -PADDING)
	---@diagnostic disable-next-line: undefined-field
	cdResetButton.Text:SetText(hamL
		["Includes the shortest Cooldown in the reset Condition of Castsequence. !!USE CAREFULLY!!"])
	cdResetButton:HookScript("OnClick", function(_, btn, down)
		ham.settingsFrame:updateConfig("cdReset", cdResetButton:GetChecked())
	end)
	cdResetButton:SetChecked(HAMDB.cdReset)
	lastStaticElement = cdResetButton

	-------------  Healthstone Priority  -------------	
	local raidStoneButton = CreateFrame("CheckButton", nil, self.content, "InterfaceOptionsCheckButtonTemplate")
	raidStoneButton:SetPoint("TOPLEFT", lastStaticElement, 0, -PADDING)
	---@diagnostic disable-next-line: undefined-field
	raidStoneButton.Text:SetText(hamL["Low Priority Healthstones"])
	raidStoneButton:HookScript("OnClick", function(_, btn, down)
		ham.settingsFrame:updateConfig("raidStone", raidStoneButton:GetChecked())
	end)
	raidStoneButton:HookScript("OnEnter", function(_, btn, down)
		---@diagnostic disable-next-line: param-type-mismatch
		GameTooltip:SetOwner(raidStoneButton, "ANCHOR_TOPRIGHT")
		GameTooltip:SetText(hamL["Prioritize health potions over a healthstone."])
		GameTooltip:Show()
	end)
	raidStoneButton:HookScript("OnLeave", function(_, btn, down)
		GameTooltip:Hide()
	end)
	raidStoneButton:SetChecked(HAMDB.raidStone)
	lastStaticElement = raidStoneButton


	-------------  ITEMS  -------------
	local witheringPotionButton = nil
	local witheringDreamsPotionButton = nil
	local cavedwellerDelightButton = nil
	local heartseekingButton = nil
	if isRetail then
		local itemsTitle = self.content:CreateFontString("ARTWORK", nil, "GameFontNormalHuge")
		itemsTitle:SetPoint("TOPLEFT", lastStaticElement, 0, -PADDING_CATERGORY)
		itemsTitle:SetText(hamL["Items"])

		---Withering Potion---
		witheringPotionButton = CreateFrame("CheckButton", nil, self.content, "InterfaceOptionsCheckButtonTemplate")
		witheringPotionButton:SetPoint("TOPLEFT", itemsTitle, 0, -PADDING)
		---@diagnostic disable-next-line: undefined-field
		witheringPotionButton.Text:SetText(hamL["Potion of Withering Vitality"])
		witheringPotionButton:HookScript("OnClick", function(_, btn, down)
			ham.settingsFrame:updateConfig("witheringPotion", witheringPotionButton:GetChecked())
		end)
		witheringPotionButton:HookScript("OnEnter", function(_, btn, down)
			---@diagnostic disable-next-line: param-type-mismatch
			GameTooltip:SetOwner(witheringPotionButton, "ANCHOR_TOPRIGHT")
			GameTooltip:SetItemByID(ham.witheringR3.getId())
			GameTooltip:Show()
		end)
		witheringPotionButton:HookScript("OnLeave", function(_, btn, down)
			GameTooltip:Hide()
		end)
		witheringPotionButton:SetChecked(HAMDB.witheringPotion)

		---Withering Dreams Potion---
		witheringDreamsPotionButton = CreateFrame("CheckButton", nil, self.content, "InterfaceOptionsCheckButtonTemplate")
		witheringDreamsPotionButton:SetPoint("TOPLEFT", itemsTitle, PADDING_HORIZONTAL, -PADDING)
		---@diagnostic disable-next-line: undefined-field
		witheringDreamsPotionButton.Text:SetText(hamL["Potion of Withering Dreams"])
		witheringDreamsPotionButton:HookScript("OnClick", function(_, btn, down)
			ham.settingsFrame:updateConfig("witheringDreamsPotion", witheringDreamsPotionButton:GetChecked())
		end)
		witheringDreamsPotionButton:HookScript("OnEnter", function(_, btn, down)
			---@diagnostic disable-next-line: param-type-mismatch
			GameTooltip:SetOwner(witheringDreamsPotionButton, "ANCHOR_TOPRIGHT")
			GameTooltip:SetItemByID(ham.witheringDreamsR3.getId())
			GameTooltip:Show()
		end)
		witheringDreamsPotionButton:HookScript("OnLeave", function(_, btn, down)
			GameTooltip:Hide()
		end)
		witheringDreamsPotionButton:SetChecked(HAMDB.witheringDreamsPotion)

		---Cavedwellers Delight---
		cavedwellerDelightButton = CreateFrame("CheckButton", nil, self.content, "InterfaceOptionsCheckButtonTemplate")
		cavedwellerDelightButton:SetPoint("TOPLEFT", itemsTitle, PADDING_HORIZONTAL * 2, -PADDING)
		---@diagnostic disable-next-line: undefined-field
		cavedwellerDelightButton.Text:SetText(hamL["Cavedweller's Delight"])
		cavedwellerDelightButton:HookScript("OnClick", function(_, btn, down)
			ham.settingsFrame:updateConfig("cavedwellerDelight", cavedwellerDelightButton:GetChecked())
		end)
		cavedwellerDelightButton:HookScript("OnEnter", function(_, btn, down)
			---@diagnostic disable-next-line: param-type-mismatch
			GameTooltip:SetOwner(cavedwellerDelightButton, "ANCHOR_TOPRIGHT")
			GameTooltip:SetItemByID(ham.cavedwellersDelightR3.getId())
			GameTooltip:Show()
		end)
		cavedwellerDelightButton:HookScript("OnLeave", function(_, btn, down)
			GameTooltip:Hide()
		end)
		cavedwellerDelightButton:SetChecked(HAMDB.cavedwellerDelight)

		---Heartseeking Health Injector---
		heartseekingButton = CreateFrame("CheckButton", nil, self.content, "InterfaceOptionsCheckButtonTemplate")
		--Padding*2 because its a new Row
		heartseekingButton:SetPoint("TOPLEFT", itemsTitle, 0, -PADDING * 2)
		---@diagnostic disable-next-line: undefined-field
		heartseekingButton.Text:SetText(hamL["Heartseeking Health Injector (tinker)"])
		heartseekingButton:HookScript("OnClick", function(_, btn, down)
			ham.settingsFrame:updateConfig("heartseekingInjector", heartseekingButton:GetChecked())
		end)
		heartseekingButton:HookScript("OnEnter", function(_, btn, down)
			---@diagnostic disable-next-line: param-type-mismatch
			if ham.tinkerSlot then
				GameTooltip:SetOwner(heartseekingButton, "ANCHOR_TOPRIGHT")
				GameTooltip:SetInventoryItem("player", ham.tinkerSlot)
				GameTooltip:Show()
			end
		end)
		heartseekingButton:HookScript("OnLeave", function(_, btn, down)
			GameTooltip:Hide()
		end)
		heartseekingButton:SetChecked(HAMDB.heartseekingInjector)

		lastStaticElement = heartseekingButton
	end

	-------------  CLASS / RACIALS  -------------
	myClassTitle = self.content:CreateFontString("ARTWORK", nil, "GameFontNormalHuge")
	myClassTitle:SetPoint("TOPLEFT", lastStaticElement, 0, -PADDING_CATERGORY)
	myClassTitle:SetText(hamL["Class/Racial Spells"])

	-------------  CURRENT PRIORITY  -------------
	currentPrioTitle = self.content:CreateFontString("ARTWORK", nil, "GameFontNormalHuge")
	currentPrioTitle:SetPoint("TOPLEFT", myClassTitle, 0, -PADDING_CATERGORY - PADDING)
	currentPrioTitle:SetText(hamL["Current Priority"])

	-------------  BANDAGE PRIORITY  -------------
	bandagePrioTitle = self.content:CreateFontString("ARTWORK", nil, "GameFontNormalHuge")
	bandagePrioTitle:SetPoint("TOPLEFT", currentPrioTitle, 0, -PADDING_CATERGORY - ICON_SIZE)
	bandagePrioTitle:SetText(hamL["Bandage Priority"])


	-------------  RESET BUTTON  -------------
	local btn = CreateFrame("Button", nil, self.content, "UIPanelButtonTemplate")
	btn:SetPoint("BOTTOMLEFT", 1, 0)
	btn:SetText(hamL["Reset to Default"])
	btn:SetWidth(120)
	btn:SetScript("OnClick", function()
		HAMDB = CopyTable(ham.defaults)

		for spellID, button in pairs(classButtons) do
			if ham.dbContains(spellID) then
				button:SetChecked(true)
			else
				button:SetChecked(false)
			end
		end
		cdResetButton:SetChecked(HAMDB.cdReset)
		raidStoneButton:SetChecked(HAMDB.raidStone)
		if isRetail then
			witheringPotionButton:SetChecked(HAMDB.witheringPotion)
			witheringDreamsPotionButton:SetChecked(HAMDB.witheringDreamsPotion)
			cavedwellerDelightButton:SetChecked(HAMDB.cavedwellerDelight)
		end
		ham.updateHeals()
		ham.updateMacro()
		self:updatePrio()
		self:updateBandagePrio()
		print(hamL["Reset successful!"])
	end)
end

function ham.settingsFrame:InitializeClassSpells(relativeTo)
	local lastbutton = nil
	local posy = -PADDING
	if next(ham.supportedSpells) ~= nil then
		local count = 0
		for i, spell in ipairs(ham.supportedSpells) do
			if spell.isKnown() then
				local button = CreateFrame("CheckButton", nil, self.content, "InterfaceOptionsCheckButtonTemplate")

				if count == 3 then
					lastbutton = nil
					count = 0
					posy = posy - PADDING
				end
				if lastbutton ~= nil then
					button:SetPoint("TOPLEFT", lastbutton, PADDING_HORIZONTAL, 0)
				else
					button:SetPoint("TOPLEFT", relativeTo, 0, posy)
				end
				---@diagnostic disable-next-line: undefined-field
				button.Text:SetText(spell.getName())
				button:HookScript("OnClick", function(_, btn, down)
					if button:GetChecked() then
						ham.insertIntoDB(spell.getId())
					else
						ham.removeFromDB(spell.getId())
					end
					ham.updateHeals()
					ham.updateMacro()
					self:updatePrio()
				end)
				button:HookScript("OnEnter", function(_, btn, down)
					---@diagnostic disable-next-line: param-type-mismatch
					GameTooltip:SetOwner(button, "ANCHOR_TOPRIGHT")
					GameTooltip:SetSpellByID(spell.getId());
					GameTooltip:Show()
				end)
				button:HookScript("OnLeave", function(_, btn, down)
					GameTooltip:Hide()
				end)
				button:SetChecked(ham.dbContains(spell.getId()))
				table.insert(classButtons, spell.getId(), button)
				lastbutton = button
				count = count + 1
			end
		end
	end
end

SLASH_HAM1 = "/ham"
SLASH_HAM2 = "/healtsthoneautomacro"
SLASH_HAM3 = "/ap"
SLASH_HAM4 = "/autopotion"

SlashCmdList.HAM = function(msg, editBox)
	-- Check if the message contains "debug"
	if msg and msg:trim():lower() == "debug" then
		ham.debug = not ham.debug
		ham.checkTinker()
        print(hamL["Auto Potion Title"].." 开发模式已经" .. (ham.debug and "启用" or "禁用"))
		return
	end

	-- Open settings if no "debug" keyword was passed
	if InterfaceOptions_AddCategory then
        InterfaceOptionsFrame_OpenToCategory(hamL["Auto Potion Title"])
	else
        local settingsCategoryID = _G[hamL["Auto Potion Title"]].categoryID
		Settings.OpenToCategory(settingsCategoryID)
	end
end
