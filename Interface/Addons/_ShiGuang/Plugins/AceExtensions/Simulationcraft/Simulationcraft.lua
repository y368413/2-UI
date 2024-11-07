-- Author: Theck, navv_, seriallos  Version: 11.0.5-01

local Simulationcraft = {}

Simulationcraft.RoleTable = {
  -- Death Knight
  [250] = 'tank',
  [251] = 'attack',
  [252] = 'attack',
  -- Demon Hunter
  [577] = 'attack',
  [581] = 'tank',
  -- Druid
  [102] = 'spell',
  [103] = 'attack',
  [104] = 'tank',
  [105] = 'attack',
  -- Evoker
  [1467] = 'spell',
  [1468] = 'attack',
  -- Hunter
  [253] = 'attack',
  [254] = 'attack',
  [255] = 'attack',
  -- Mage
  [62] = 'spell',
  [63] = 'spell',
  [64] = 'spell',
  -- Monk
  [268] = 'tank',
  [269] = 'attack',
  [270] = 'attack',
  -- Paladin
  [65] = 'attack',
  [66] = 'tank',
  [70] = 'attack',
  -- Priest
  [256] = 'spell',
  [257] = 'attack',
  [258] = 'spell',
  -- Rogue
  [259] = 'attack',
  [260] = 'attack',
  [261] = 'attack',
  -- Shaman
  [262] = 'spell',
  [263] = 'attack',
  [264] = 'attack',
  -- Warlock
  [265] = 'spell',
  [266] = 'spell',
  [267] = 'spell',
  -- Warrior
  [71] = 'attack',
  [72] = 'attack',
  [73] = 'tank'
}

-- regionID lookup
Simulationcraft.RegionString = {
  [1] = 'us',
  [2] = 'kr',
  [3] = 'eu',
  [4] = 'tw',
  [5] = 'cn',
  [72] = 'tr'
}

-- non-localized profession names from ids
Simulationcraft.ProfNames = {
  [129] = 'First Aid',
  [164] = 'Blacksmithing',
  [165] = 'Leatherworking',
  [171] = 'Alchemy',
  [182] = 'Herbalism',
  [184] = 'Cooking',
  [186] = 'Mining',
  [197] = 'Tailoring',
  [202] = 'Engineering',
  [333] = 'Enchanting',
  [356] = 'Fishing',
  [393] = 'Skinning',
  [755] = 'Jewelcrafting',
  [773] = 'Inscription',
  [794] = 'Archaeology'  
}

-- non-localized spec names from spec ids
Simulationcraft.SpecNames = {
-- Death Knight
  [250] = 'Blood',
  [251] = 'Frost',
  [252] = 'Unholy',
-- Demon Hunter
  [577] = 'Havoc',
  [581] = 'Vengeance',
-- Druid 
  [102] = 'Balance',
  [103] = 'Feral',
  [104] = 'Guardian',
  [105] = 'Restoration',
-- Evoker
  [1473] = 'Augmentation',
  [1467] = 'Devastation',
  [1468] = 'Preservation',
-- Hunter 
  [253] = 'Beast Mastery',
  [254] = 'Marksmanship',
  [255] = 'Survival',
-- Mage 
  [62] = 'Arcane',
  [63] = 'Fire',
  [64] = 'Frost',
-- Monk 
  [268] = 'Brewmaster',
  [269] = 'Windwalker',
  [270] = 'Mistweaver',
-- Paladin 
  [65] = 'Holy',
  [66] = 'Protection',
  [70] = 'Retribution',
-- Priest 
  [256] = 'Discipline',
  [257] = 'Holy',
  [258] = 'Shadow',
-- Rogue 
  [259] = 'Assassination',
  [260] = 'Outlaw',
  [261] = 'Subtlety',
-- Shaman 
  [262] = 'Elemental',
  [263] = 'Enhancement',
  [264] = 'Restoration',
-- Warlock 
  [265] = 'Affliction',
  [266] = 'Demonology',
  [267] = 'Destruction',
-- Warrior 
  [71] = 'Arms',
  [72] = 'Fury',
  [73] = 'Protection'
}

-- slot name conversion stuff

-- The array indexes are NOT the slot ids - they are the "slot numbers" used by this addons.
Simulationcraft.slotNames = {
	"HeadSlot", -- [1]
	"NeckSlot", -- [2]
	"ShoulderSlot", -- [3]
	"BackSlot", -- [4]
	"ChestSlot", -- [5]
	"ShirtSlot", -- [6]
	"TabardSlot", -- [7]
	"WristSlot", -- [8]
	"HandsSlot", -- [9]
	"WaistSlot", -- [10]
	"LegsSlot", -- [11]
	"FeetSlot", -- [12]
	"Finger0Slot", -- [13]
	"Finger1Slot", -- [14]
	"Trinket0Slot", -- [15]
	"Trinket1Slot", -- [16]
	"MainHandSlot", -- [17]
	"SecondaryHandSlot", -- [18]
	"AmmoSlot" -- [19]
}
-- The array indexes are NOT the slot ids - they are the "slot numbers" used by this addons.
Simulationcraft.simcSlotNames = {
	'head', -- [1]
	'neck', -- [2]
	'shoulder', -- [3]
	'back', -- [4]
	'chest', -- [5]
	'shirt', -- [6]
	'tabard', -- [7]
	'wrist', -- [8]
	'hands', -- [9]
	'waist', -- [10]
	'legs', -- [11]
	'feet', -- [12]
	'finger1', -- [13]
	'finger2', -- [14]
	'trinket1', -- [15]
	'trinket2', -- [16]
	'main_hand', -- [17]
	'off_hand', -- [18]
	'ammo', -- [19]
}
-- Map of the INVTYPE_ returned by GetItemInfo to the slot number (NOT the slot id).
Simulationcraft.invTypeToSlotNum = {
	INVTYPE_HEAD=1,
	INVTYPE_NECK=2,
	INVTYPE_SHOULDER=3,
	INVTYPE_CLOAK=4,
	INVTYPE_CHEST=5, INVTYPE_ROBE=5, -- These are the same slot - which one is used appears to differ based on whether the item's model covers the legs.
	INVTYPE_BODY=6, -- shirt.
	INVTYPE_TABARD=7,
	INVTYPE_WRIST=8,
	INVTYPE_HAND=9,
	INVTYPE_WAIST=10,
	INVTYPE_LEGS=11,
	INVTYPE_FEET=12,
	INVTYPE_FINGER=13,
	-- 14 is also a finger slot number.
	INVTYPE_TRINKET=15,
	-- 16 is also a trinket slot number.
	INVTYPE_WEAPON=17, -- 1h weapon.
	INVTYPE_2HWEAPON=17, -- 2h weapon.
	INVTYPE_RANGED=17, -- bows.
	INVTYPE_RANGEDRIGHT=17, -- Guns, wands, crossbows.
	INVTYPE_SHIELD=18,
	INVTYPE_HOLDABLE=18, -- off hand, but not a weapon or shield.

	-- These types are no longer used in current content.
	INVTYPE_WEAPONMAINHAND=17, -- Likely no items have this type anymore.
	INVTYPE_WEAPONOFFHAND=18, -- Likely no items have this type anymore.
	INVTYPE_THROWN=17, -- Thrown weapons. I do not know if this slot number is correct, but it shouldn't matter since these are no longer obtainable and those that do exist are now gray items.
	--INVTYPE_RELIC=?, -- No corresponding slot number, and I do not think any such items exist. Existing relics were turned into non-equipable gray items. This is value is not used for legion relics either.
}

-- table for conversion to upgrade level, stolen from AMR (<3)

Simulationcraft.upgradeTable = {
  [0]   =  0,
  [1]   =  1, -- 1/1 -> 8
  [373] =  1, -- 1/2 -> 4
  [374] =  2, -- 2/2 -> 8
  [375] =  1, -- 1/3 -> 4
  [376] =  2, -- 2/3 -> 4
  [377] =  3, -- 3/3 -> 4
  [378] =  1, -- 1/1 -> 7
  [379] =  1, -- 1/2 -> 4
  [380] =  2, -- 2/2 -> 4
  [445] =  0, -- 0/2 -> 0
  [446] =  1, -- 1/2 -> 4
  [447] =  2, -- 2/2 -> 8
  [451] =  0, -- 0/1 -> 0
  [452] =  1, -- 1/1 -> 8
  [453] =  0, -- 0/2 -> 0
  [454] =  1, -- 1/2 -> 4
  [455] =  2, -- 2/2 -> 8
  [456] =  0, -- 0/1 -> 0
  [457] =  1, -- 1/1 -> 8
  [458] =  0, -- 0/4 -> 0
  [459] =  1, -- 1/4 -> 4
  [460] =  2, -- 2/4 -> 8
  [461] =  3, -- 3/4 -> 12
  [462] =  4, -- 4/4 -> 16
  [465] =  0, -- 0/2 -> 0
  [466] =  1, -- 1/2 -> 4
  [467] =  2, -- 2/2 -> 8
  [468] =  0, -- 0/4 -> 0
  [469] =  1, -- 1/4 -> 4
  [470] =  2, -- 2/4 -> 8
  [471] =  3, -- 3/4 -> 12
  [472] =  4, -- 4/4 -> 16
  [476] =  0, -- ? -> 0
  [479] =  0, -- ? -> 0
  [491] =  0, -- ? -> 0
  [492] =  1, -- ? -> 0
  [493] =  2, -- ? -> 0
  [494] = 0,
  [495] = 1,
  [496] = 2,
  [497] = 3,
  [498] = 4,
  [504] = 3,
  [505] = 4,
  -- WOW-20726patch6.2.3_Retail
  [529] = 0, -- 0/2 -> 0
  [530] = 1, -- 1/2 -> 5
  [531] = 2 -- 2/2 -> 10
}

Simulationcraft.zandalariLoaBuffs = {
  [292359] = 'akunda',
  [292360] = 'bwonsamdi',
  [292362] = 'gonk',
  [292363] = 'kimbul',
  [292364] = 'kragwa',
  [292361] = 'paku',
}

Simulationcraft.azeriteEssenceSlotsMajor = {
  0
}

Simulationcraft.azeriteEssenceSlotsMinor = {
  1,
  2
}

Simulationcraft.covenants = {
  [1] = 'kyrian',
  [2] = 'venthyr',
  [3] = 'night_fae',
  [4] = 'necrolord',
}

Simulationcraft.upgradeAchievements = {
  40107, -- Harbinger of the Weathered
  40115, -- Harbinger of the Carved
  40118, -- Harbinger of the Runed
  40939, -- Harbinger of the Gilded
}

-- Upgrade currencies and item

Simulationcraft.upgradeCurrencies = {
  [1191] = 'Valor',
  [1792] = 'Honor',
  [2122] = 'Storm Sigil',
  [2245] = 'Flightstones',
  [2806] = 'Whelpling\'s Awakened Crest',
  [2807] = 'Drake\'s Awakened Crest',
  [2809] = 'Wyrm\'s Awakened Crest',
  [2812] = 'Aspect\'s Awakened Crest',
  [2914] = 'Weathered Harbinger Crest',
  [2915] = 'Carved Harbinger Crest',
  [2916] = 'Runed Harbinger Crest',
  [2917] = 'Gilded Harbinger Crest',
  [3008] = 'Valorstones',
}

Simulationcraft.upgradeItems = {
  [190453] = 'Spark of Ingenuity',
  [197921] = 'Primal Infusion',
  [198046] = 'Concentrated Primal Infusion',
  [198048] = 'Titan Training Matrix I',
  [198056] = 'Titan Training Matrix II',
  [198058] = 'Titan Training Matrix III',
  [198059] = 'Titan Training Matrix IV',
  [204440] = 'Spark of Shadowflame',
  [204673] = 'Titan Training Matrix V',
  [204681] = 'Enchanted Whelpling\'s Shadowflame Crest',
  [204682] = 'Enchanted Wyrm\'s Shadowflame Crest',
  [204697] = 'Enchanted Aspect\'s Shadowflame Crest',
  [206366] = 'Cracked Trophy of Strife',
  [206959] = 'Spark of Dreams',
  [206960] = 'Enchanted Wyrm\'s Dreaming Crest',
  [206961] = 'Enchanted Aspect\'s Dreaming Crest',
  [206977] = 'Enchanted Whelpling\'s Dreaming Crest',
  [210221] = 'Forged Combatant\'s Heraldry',
  [210232] = 'Forged Aspirant\'s Heraldry',
  [210233] = 'Forged Gladiator\'s Heraldry',
  [211296] = 'Spark of Omens',
  [211494] = 'Spark of Beginnings',
  [211516] = 'Spark of Awakening',
  [211518] = 'Enchanted Wyrm\'s Awakened Crest',
  [211519] = 'Enchanted Aspect\'s Awakened Crest',
  [211520] = 'Enchanted Whelpling\'s Awakened Crest',
  [224069] = 'Enchanted Weathered Harbinger Crest',
  [224072] = 'Enchanted Runed Harbinger Crest',
  [224073] = 'Enchanted Gilded Harbinger Crest',
  [228338] = 'Soul Sigil I',
  [228339] = 'Soul Sigil II',
}

local Simulationcraft = LibStub("AceAddon-3.0"):NewAddon(Simulationcraft, "Simulationcraft", "AceConsole-3.0", "AceEvent-3.0")
local LibRealmInfo = LibStub("LibRealmInfo")
local SimcFrame = nil

local OFFSET_ITEM_ID = 1
local OFFSET_ENCHANT_ID = 2
local OFFSET_GEM_ID_1 = 3
-- local OFFSET_GEM_ID_2 = 4
-- local OFFSET_GEM_ID_3 = 5
local OFFSET_GEM_ID_4 = 6
local OFFSET_GEM_BASE = OFFSET_GEM_ID_1
local OFFSET_SUFFIX_ID = 7
-- local OFFSET_FLAGS = 11
-- local OFFSET_CONTEXT = 12
local OFFSET_BONUS_ID = 13

local OFFSET_GEM_BONUS_FROM_MODS = 2

local ITEM_MOD_TYPE_DROP_LEVEL = 9
-- 28 shows frequently but is currently unknown
local ITEM_MOD_TYPE_CRAFT_STATS_1 = 29
local ITEM_MOD_TYPE_CRAFT_STATS_2 = 30

local SUPPORTED_LOADOUT_SERIALIZATION_VERSION = 2

local WeeklyRewards         = _G.C_WeeklyRewards

-- New talents for Dragonflight
local ClassTalents          = _G.C_ClassTalents
local Traits                = _G.C_Traits

-- GetAddOnMetadata was global until 10.1. It's now in C_AddOns. This line will use C_AddOns if available and work in either WoW build
local GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata

-- Some global item functions have been moved into C_Item in 11.0
local GetDetailedItemLevelInfo = C_Item and C_Item.GetDetailedItemLevelInfo or GetDetailedItemLevelInfo
local GetItemInfoInstant = C_Item and C_Item.GetItemInfoInstant or GetItemInfoInstant
local GetItemCount = C_Item and C_Item.GetItemCount or GetItemCount

-- Talent string export
local bitWidthHeaderVersion         = 8
local bitWidthSpecID                = 16
local bitWidthRanksPurchased        = 6

-- load stuff from extras.lua
-- local upgradeTable        = Simulationcraft.upgradeTable
local slotNames           = Simulationcraft.slotNames
local simcSlotNames       = Simulationcraft.simcSlotNames
local specNames           = Simulationcraft.SpecNames
local profNames           = Simulationcraft.ProfNames
local regionString        = Simulationcraft.RegionString
local zandalariLoaBuffs   = Simulationcraft.zandalariLoaBuffs

-- Most of the guts of this addon were based on a variety of other ones, including
-- Statslog, AskMrRobot, and BonusScanner. And a bunch of hacking around with AceGUI.
-- Many thanks to the authors of those addons, and to reia for fixing my awful amateur
-- coding mistakes regarding objects and namespaces.

function Simulationcraft:OnInitialize()
  Simulationcraft:RegisterChatCommand('simc', 'HandleChatCommand')
end

function Simulationcraft:OnEnable()

end

function Simulationcraft:OnDisable()

end

local function getLinks(input)
  local separatedLinks = {}
  for link in input:gmatch("|c.-|h|r") do
     separatedLinks[#separatedLinks + 1] = link
  end
  return separatedLinks
end

function Simulationcraft:HandleChatCommand(input)
  local args = {strsplit(' ', input)}

  local debugOutput = false
  local noBags = false
  local showMerchant = false
  local links = getLinks(input)

  for _, arg in ipairs(args) do
    if arg == 'debug' then
      debugOutput = true
    elseif arg == 'nobag' or arg == 'nobags' or arg == 'nb' then
      noBags = true
    elseif arg == 'merchant' then
      showMerchant = true
    end
  end

  self:PrintSimcProfile(debugOutput, noBags, showMerchant, links)
end

local function GetItemSplit(itemLink)
  local itemString = string.match(itemLink, "item:([%-?%d:]+)")
  local itemSplit = {}

  -- Split data into a table
  for _, v in ipairs({strsplit(":", itemString)}) do
    if v == "" then
      itemSplit[#itemSplit + 1] = 0
    else
      itemSplit[#itemSplit + 1] = tonumber(v)
    end
  end

  return itemSplit
end

local function GetItemName(itemLink)
  local name = string.match(itemLink, '|h%[(.*)%]|')
  local removeIcons = gsub(name, '|%a.+|%a', '')
  local trimmed = string.match(removeIcons, '^%s*(.*)%s*$')
  -- check for empty string or only spaces
  if string.match(trimmed, '^%s*$') then
    return nil
  end

  return trimmed
end

-- char size for utf8 strings
local function ChrSize(char)
  if not char then
      return 0
  elseif char > 240 then
      return 4
  elseif char > 225 then
      return 3
  elseif char > 192 then
      return 2
  else
      return 1
  end
end

-- SimC tokenize function
local function Tokenize(str)
  str = str or ""
  -- convert to lowercase and remove spaces
  str = string.lower(str)
  str = string.gsub(str, ' ', '_')

  -- keep stuff we want, dumpster everything else
  local s = ""
  for i=1,str:len() do
    local b = str:byte(i)
    -- keep digits 0-9
    if b >= 48 and b <= 57 then
      s = s .. str:sub(i,i)
      -- keep lowercase letters
    elseif b >= 97 and b <= 122 then
      s = s .. str:sub(i,i)
      -- keep %, +, ., _
    elseif b == 37 or b == 43 or b == 46 or b == 95 then
      s = s .. str:sub(i,i)
      -- save all multibyte chars
    elseif ChrSize(b) > 1 then
      local offset = ChrSize(b) - 1
      s = s .. str:sub(i, i + offset)
      i = i + offset -- luacheck: no unused
    end
  end
  -- strip trailing spaces
  if string.sub(s, s:len())=='_' then
    s = string.sub(s, 0, s:len()-1)
  end
  return s
end

-- method to add spaces to UnitRace names for proper tokenization
local function FormatRace(str)
  str = str or ""
  local matches = {}
  for match, _ in string.gmatch(str, '([%u][%l]*)') do
    matches[#matches+1] = match
  end
  return string.join(' ', unpack(matches))
end

-- method for constructing the talent string
local function CreateSimcTalentString()
  local talentInfo = {}
  local maxTiers = 7
  local maxColumns = 3
  for tier = 1, maxTiers do
    for column = 1, maxColumns do
      local _, _, _, selected, _ = GetTalentInfo(tier, column, GetActiveSpecGroup())
      if selected then
        talentInfo[tier] = column
      end
    end
  end

  local str = 'talents='
  for i = 1, maxTiers do
    if talentInfo[i] then
      str = str .. talentInfo[i]
    else
      str = str .. '0'
    end
  end

  return str
end

-- class_talents= builder for dragonflight
-- Older function, leave around for reference
-- local function GetTalentString(configId)
--   local entryStrings = {}
--
--   local active = false
--   if configId == ClassTalents.GetActiveConfigID() then
--     active = true
--   end
--
--   local configInfo = Traits.GetConfigInfo(configId)
--   for _, treeId in pairs(configInfo.treeIDs) do
--     local nodes = Traits.GetTreeNodes(treeId)
--     for _, nodeId in pairs(nodes) do
--       local node = Traits.GetNodeInfo(configId, nodeId)
--       if node.ranksPurchased > 0 then
--         entryStrings[#entryStrings + 1] = node.activeEntry.entryID .. ":" .. node.activeEntry.rank
--       end
--     end
--   end
--
--   local str = "class_talents=" .. table.concat(entryStrings, '/')
--   if not active then
--     -- comment out the class_talents and then prepend a comment with the loadout name
--     str = '# ' .. str
--     str = '# Saved Loadout: ' .. configInfo.name .. '\n' .. str
--   end
--
--   return str
-- end

local function WriteLoadoutHeader(exportStream, serializationVersion, specID, treeHash)
  exportStream:AddValue(bitWidthHeaderVersion, serializationVersion)
  exportStream:AddValue(bitWidthSpecID, specID)
  for _, hashVal in ipairs(treeHash) do
    exportStream:AddValue(8, hashVal)
  end
end

local function GetActiveEntryIndex(treeNode)
  for i, entryID in ipairs(treeNode.entryIDs) do
    if(treeNode.activeEntry and entryID == treeNode.activeEntry.entryID) then
      return i;
    end
  end

  return 0;
end

local function WriteLoadoutContent(exportStream, configID, treeID)
  local treeNodes = C_Traits.GetTreeNodes(treeID)
  for _, treeNodeID in ipairs(treeNodes) do
    local treeNode = C_Traits.GetNodeInfo(configID, treeNodeID);

    local isNodeGranted = treeNode.activeRank - treeNode.ranksPurchased > 0;
    local isNodePurchased = treeNode.ranksPurchased > 0;
    local isNodeSelected = isNodeGranted or isNodePurchased;
    local isPartiallyRanked = treeNode.ranksPurchased ~= treeNode.maxRanks;
    local isChoiceNode = treeNode.type == Enum.TraitNodeType.Selection
      or treeNode.type == Enum.TraitNodeType.SubTreeSelection;

    exportStream:AddValue(1, isNodeSelected and 1 or 0);
    if(isNodeSelected) then
      exportStream:AddValue(1, isNodePurchased and 1 or 0);

      if isNodePurchased then
        exportStream:AddValue(1, isPartiallyRanked and 1 or 0);
        if(isPartiallyRanked) then
          exportStream:AddValue(bitWidthRanksPurchased, treeNode.ranksPurchased);
        end

        exportStream:AddValue(1, isChoiceNode and 1 or 0);
        if(isChoiceNode) then
          local entryIndex = GetActiveEntryIndex(treeNode);
          if(entryIndex <= 0 or entryIndex > 4) then
            local configInfo = Traits.GetConfigInfo(configID)
            local errorMsg = "Talent loadout '" .. configInfo.name .. "' is corrupt/incomplete. Find that talent"
              .. " loadout in your talents UI and delete or update it. It may be on a different spec."
            print(errorMsg);
            error(errorMsg);
          end

          -- store entry index as zero-index
          exportStream:AddValue(2, entryIndex - 1);
        end
      end
    end
  end
end

local function GetExportString(configID)
  local active = false
  if configID == ClassTalents.GetActiveConfigID() then
    active = true
  end

  local exportStream = ExportUtil.MakeExportDataStream();
  local configInfo = Traits.GetConfigInfo(configID);
  local currentSpecID = PlayerUtil.GetCurrentSpecID();
  local treeID = configInfo.treeIDs[1];
  local treeHash = C_Traits.GetTreeHash(treeID);
  local serializationVersion = C_Traits.GetLoadoutSerializationVersion();

  WriteLoadoutHeader(exportStream, serializationVersion, currentSpecID, treeHash )
  WriteLoadoutContent(exportStream, configID, treeID)

  local str = "talents=" .. exportStream:GetExportString()
  if not active then
    -- comment out the talents and then prepend a comment with the loadout name
    str = '# ' .. str
    -- Make sure any pipe characters get unescaped, otherwise breaks checksums
    str = '# Saved Loadout: ' .. configInfo.name:gsub("||", "|") .. '\n' .. str
  end

  return str
end

-- function that translates between the game's role values and ours
local function TranslateRole(spec_id, str)
  local spec_role = Simulationcraft.RoleTable[spec_id]
  if spec_role ~= nil then
    return spec_role
  end

  if str == 'TANK' then
    return 'tank'
  elseif str == 'DAMAGER' then
    return 'attack'
  elseif str == 'HEALER' then
    return 'attack'
  else
    return ''
  end
end

-- =================== Item Information =========================

local function GetItemStringFromItemLink(slotNum, itemLink, debugOutput)
  local itemSplit = GetItemSplit(itemLink)
  local simcItemOptions = {}
  local gems = {}
  local gemBonuses = {}

  -- Item id
  local itemId = itemSplit[OFFSET_ITEM_ID]
  simcItemOptions[#simcItemOptions + 1] = ',id=' .. itemId

  -- Enchant
  if itemSplit[OFFSET_ENCHANT_ID] > 0 then
    simcItemOptions[#simcItemOptions + 1] = 'enchant_id=' .. itemSplit[OFFSET_ENCHANT_ID]
  end

  -- Gems
  for gemOffset = OFFSET_GEM_ID_1, OFFSET_GEM_ID_4 do
    local gemIndex = (gemOffset - OFFSET_GEM_BASE) + 1
    gems[gemIndex] = 0
    gemBonuses[gemIndex] = 0
    if itemSplit[gemOffset] > 0 then
      local gemId = itemSplit[gemOffset]
      if gemId > 0 then
        gems[gemIndex] = gemId
      end
    end
  end

  -- Remove any trailing zeros from the gems array
  while #gems > 0 and gems[#gems] == 0 do
    table.remove(gems, #gems)
  end

  if #gems > 0 then
    simcItemOptions[#simcItemOptions + 1] = 'gem_id=' .. table.concat(gems, '/')
  end

  -- New style item suffix, old suffix style not supported
  if itemSplit[OFFSET_SUFFIX_ID] ~= 0 then
    simcItemOptions[#simcItemOptions + 1] = 'suffix=' .. itemSplit[OFFSET_SUFFIX_ID]
  end

  local bonuses = {}

  for index=1, itemSplit[OFFSET_BONUS_ID] do
    bonuses[#bonuses + 1] = itemSplit[OFFSET_BONUS_ID + index]
  end

  if #bonuses > 0 then
    simcItemOptions[#simcItemOptions + 1] = 'bonus_id=' .. table.concat(bonuses, '/')
  end

  -- Shadowlands looks like it changed the item string
  -- There's now a variable list of additional data after bonus IDs, looks like some kind of type/value pairs
  local linkOffset = OFFSET_BONUS_ID + #bonuses + 1

  local craftedStats = {}
  local numPairs = itemSplit[linkOffset]
  for index=1, numPairs do
    local pairOffset = 1 + linkOffset + (2 * (index - 1))
    local pairType = itemSplit[pairOffset]
    local pairValue = itemSplit[pairOffset + 1]
    if pairType == ITEM_MOD_TYPE_DROP_LEVEL then
      simcItemOptions[#simcItemOptions + 1] = 'drop_level=' .. pairValue
    elseif pairType == ITEM_MOD_TYPE_CRAFT_STATS_1 or pairType == ITEM_MOD_TYPE_CRAFT_STATS_2 then
      craftedStats[#craftedStats + 1] = pairValue
    end
  end

  if #craftedStats > 0 then
    simcItemOptions[#simcItemOptions + 1] = 'crafted_stats=' .. table.concat(craftedStats, '/')
  end

  -- gem bonuses
  local gemBonusOffset = linkOffset + (2 * numPairs) + OFFSET_GEM_BONUS_FROM_MODS
  local numGemBonuses = itemSplit[gemBonusOffset]
  local gemBonuses = {}
  for index=1, numGemBonuses do
    local offset = gemBonusOffset + index
    gemBonuses[index] = itemSplit[offset]
  end

  if #gemBonuses > 0 then
    simcItemOptions[#simcItemOptions + 1] = 'gem_bonus_id=' .. table.concat(gemBonuses, '/')
  end

  local craftingQuality = C_TradeSkillUI.GetItemCraftedQualityByItemInfo(itemLink);
  if craftingQuality then
    simcItemOptions[#simcItemOptions + 1] = 'crafting_quality=' .. craftingQuality
  end

  local itemStr = ''
  itemStr = itemStr .. (simcSlotNames[slotNum] or 'unknown') .. "=" .. table.concat(simcItemOptions, ',')
  if debugOutput then
    itemStr = itemStr .. '\n# ' .. gsub(itemLink, "\124", "\124\124") .. '\n'
  end

  return itemStr
end

function Simulationcraft:GetItemStrings(debugOutput)
  local items = {}
  for slotNum=1, #slotNames do
    local slotId = GetInventorySlotInfo(slotNames[slotNum])
    local itemLink = GetInventoryItemLink('player', slotId)

    -- if we don't have an item link, we don't care
    if itemLink then
      -- In theory, this should always be loaded/cached
      local name = GetItemName(itemLink)

      -- get correct level for scaling gear
      local level, _, _ = GetDetailedItemLevelInfo(itemLink)

      local itemComment
      if name and level then
        itemComment = name .. ' (' .. level .. ')'
      end

      items[slotNum] = {
        string = GetItemStringFromItemLink(slotNum, itemLink, debugOutput),
        name = itemComment
      }
    end
  end

  return items
end

function Simulationcraft:GetBagItemStrings(debugOutput)
  local bagItems = {}

  -- https://wowpedia.fandom.com/wiki/BagID
  -- Bag indexes are a pain, need to start in the negatives to check everything (like the default bank container)
  for bag=BACKPACK_CONTAINER - ITEM_INVENTORY_BANK_BAG_OFFSET, NUM_TOTAL_EQUIPPED_BAG_SLOTS + NUM_BANKBAGSLOTS do
    for slot=1, C_Container.GetContainerNumSlots(bag) do
      local itemId = C_Container.GetContainerItemID(bag, slot)

      -- something is in the bag slot
      if itemId then
        local _, _, _, itemEquipLoc = GetItemInfoInstant(itemId)
        local slotNum = Simulationcraft.invTypeToSlotNum[itemEquipLoc]

        -- item can be equipped
        if slotNum then
          local info = C_Container.GetContainerItemInfo(bag, slot)
          local itemLink = C_Container.GetContainerItemLink(bag, slot)
          bagItems[#bagItems + 1] = {
            string = GetItemStringFromItemLink(slotNum, itemLink, debugOutput),
            slotNum = slotNum
          }
          local itemName = GetItemName(itemLink)
          local level, _, _ = GetDetailedItemLevelInfo(itemLink)
          if itemName and level then
            bagItems[#bagItems].name = itemName .. ' (' .. level .. ')'
          end
        end
      end
    end
  end

  -- order results by paper doll slot, not bag slot
  table.sort(bagItems, function (a, b) return a.slotNum < b.slotNum end)

  return bagItems
end

-- Scan buffs to determine which loa racial this player has, if any
function Simulationcraft:GetZandalariLoa()
  local zandalariLoa = nil
  for index = 1, 32 do
    local auraData = C_UnitAuras.GetBuffDataByIndex("player", index)
    local spellId = auraData.spellId
    if spellId == nil then
      break
    end
    if zandalariLoaBuffs[spellId] then
      zandalariLoa = zandalariLoaBuffs[spellId]
      break
    end
  end
  return zandalariLoa
end

function Simulationcraft:GetSlotHighWatermarks()
  if C_ItemUpgrade and C_ItemUpgrade.GetHighWatermarkForSlot then
    local slots = {}
    -- These are not normal equipment slots, they are Enum.ItemRedundancySlot
    for slot = 0, 16 do
      local characterHighWatermark, accountHighWatermark = C_ItemUpgrade.GetHighWatermarkForSlot(slot)
      if characterHighWatermark or accountHighWatermark then
        slots[#slots + 1] = table.concat({  slot, characterHighWatermark, accountHighWatermark }, ':')
      end
    end
    return table.concat(slots, '/')
  end
end

function Simulationcraft:GetUpgradeCurrencies()
  local upgradeCurrencies = {}
  -- Collect actual currencies
  for currencyId, currencyName in pairs(Simulationcraft.upgradeCurrencies) do
    local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(currencyId)
    if currencyInfo and currencyInfo.quantity > 0 then
      upgradeCurrencies[#upgradeCurrencies + 1] = table.concat({ "c", currencyId, currencyInfo.quantity }, ':')
    end
  end

  -- Collect items that get used as currencies
  for itemId, itemName in pairs(Simulationcraft.upgradeItems) do
    local count = GetItemCount(itemId, true, true, true)
    if count > 0 then
      upgradeCurrencies[#upgradeCurrencies + 1] = table.concat({ "i", itemId, count }, ':')
    end
  end

  return table.concat(upgradeCurrencies, '/')
end

function Simulationcraft:GetItemUpgradeAchievements()
  local achieves = {}
  for i=1, #Simulationcraft.upgradeAchievements do
    local achId = Simulationcraft.upgradeAchievements[i]
    _, name, points, complete = GetAchievementInfo(achId)
    if complete then
      achieves[#achieves + 1] = achId
    end
  end
  return table.concat(achieves, '/')
end

function Simulationcraft:GetMainFrame(text)
  -- Frame code largely adapted from https://www.wowinterface.com/forums/showpost.php?p=323901&postcount=2
  if not SimcFrame then
    -- Main Frame
    local f = CreateFrame("Frame", "SimcFrame", UIParent, "DialogBoxFrame")
    f:ClearAllPoints()
    -- load position from local DB
    f:SetPoint("CENTER",nil,"CENTER",0,0)
    f:SetSize(750, 400)
    f:SetBackdrop({
      bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
      edgeFile = "Interface\\PVPFrame\\UI-Character-PVP-Highlight",
      edgeSize = 16,
      insets = { left = 8, right = 8, top = 8, bottom = 8 },
    })
    f:SetMovable(true)
    f:SetClampedToScreen(true)
    f:SetScript("OnMouseDown", function(self, button) -- luacheck: ignore
      if button == "LeftButton" then
        self:StartMoving()
      end
    end)
    f:SetScript("OnMouseUp", function(self, _) -- luacheck: ignore
      self:StopMovingOrSizing()
    end)

    -- scroll frame
    local sf = CreateFrame("ScrollFrame", "SimcScrollFrame", f, "UIPanelScrollFrameTemplate")
    sf:SetPoint("LEFT", 16, 0)
    sf:SetPoint("RIGHT", -32, 0)
    sf:SetPoint("TOP", 0, -32)
    sf:SetPoint("BOTTOM", SimcFrameButton, "TOP", 0, 0)

    -- edit box
    local eb = CreateFrame("EditBox", "SimcEditBox", SimcScrollFrame)
    eb:SetSize(sf:GetSize())
    eb:SetMultiLine(true)
    eb:SetAutoFocus(true)
    eb:SetFontObject("ChatFontNormal")
    eb:SetScript("OnEscapePressed", function() f:Hide() end)
    sf:SetScrollChild(eb)

    -- resizing
    f:SetResizable(true)
    if f.SetMinResize then
      -- older function from shadowlands and before
      -- Can remove when Dragonflight is in full swing
      f:SetMinResize(150, 100)
    else
      -- new func for dragonflight
      f:SetResizeBounds(150, 100, nil, nil)
    end
    local rb = CreateFrame("Button", "SimcResizeButton", f)
    rb:SetPoint("BOTTOMRIGHT", -6, 7)
    rb:SetSize(16, 16)

    rb:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    rb:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    rb:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

    rb:SetScript("OnMouseDown", function(self, button) -- luacheck: ignore
        if button == "LeftButton" then
            f:StartSizing("BOTTOMRIGHT")
            self:GetHighlightTexture():Hide() -- more noticeable
        end
    end)
    rb:SetScript("OnMouseUp", function(self, _) -- luacheck: ignore
        f:StopMovingOrSizing()
        self:GetHighlightTexture():Show()
        eb:SetWidth(sf:GetWidth())

        -- save size between sessions
        --frameConfig.width = f:GetWidth()
        --frameConfig.height = f:GetHeight()
    end)

    SimcFrame = f
  end
  SimcEditBox:SetText(text)
  SimcEditBox:HighlightText()
  return SimcFrame
end

-- Adapted from https://github.com/philanc/plc/blob/master/plc/checksum.lua
local function adler32(s)
  -- return adler32 checksum  (uint32)
  -- adler32 is a checksum defined by Mark Adler for zlib
  -- (based on the Fletcher checksum used in ITU X.224)
  -- implementation based on RFC 1950 (zlib format spec), 1996
  local prime = 65521 --largest prime smaller than 2^16
  local s1, s2 = 1, 0

  -- limit s size to ensure that modulo prime can be done only at end
  -- 2^40 is too large for WoW Lua so limit to 2^30
  if #s > (bit.lshift(1, 30)) then error("adler32: string too large") end

  for i = 1,#s do
    local b = string.byte(s, i)
    s1 = s1 + b
    s2 = s2 + s1
    -- no need to test or compute mod prime every turn.
  end

  s1 = s1 % prime
  s2 = s2 % prime

  return (bit.lshift(s2, 16)) + s1
end --adler32()

function Simulationcraft:GetSimcProfile(debugOutput, noBags, showMerchant, links)
  -- addon metadata
  local versionComment = '# SimC Addon ' .. '11.0.5-01'
  local wowVersion, wowBuild, _, wowToc = GetBuildInfo()
  local wowVersionComment = '# WoW ' .. wowVersion .. '.' .. wowBuild .. ', TOC ' .. wowToc
  local simcVersionWarning = '# Requires SimulationCraft 1000-01 or newer'

  -- Basic player info
  local _, realmName, _, _, _, _, region, _, _, realmLatinName, _ = LibRealmInfo:GetRealmInfoByUnit('player')

  local playerName = UnitName('player')
  local _, playerClass = UnitClass('player')
  local playerLevel = UnitLevel('player')

  -- Try Latin name for Russian servers first, then realm name from LibRealmInfo, then Realm Name from the game
  -- Latin name for Russian servers as most APIs use the latin name, not the cyrillic name
  local playerRealm = realmLatinName or realmName or GetRealmName()

  -- Try region from LibRealmInfo first, then use default API
  -- Default API can be wrong for region-switching players
  local playerRegion = region or GetCurrentRegionName() or regionString[GetCurrentRegion()]

  -- Race info
  local _, playerRace = UnitRace('player')

  -- fix some races to match SimC format
  if playerRace == 'Scourge' then --lulz
    playerRace = 'Undead'
  else
    playerRace = FormatRace(playerRace)
  end

  local isZandalariTroll = false
  if Tokenize(playerRace) == 'zandalari_troll' then
    isZandalariTroll = true
  end

  -- Spec info
  local role, globalSpecID, playerRole
  local specId = GetSpecialization()
  if specId then
    globalSpecID,_,_,_,_,role = GetSpecializationInfo(specId)
  end
  local playerSpec = specNames[ globalSpecID ] or 'unknown'

  -- Professions
  local pid1, pid2 = GetProfessions()
  local firstProf, firstProfRank, secondProf, secondProfRank, profOneId, profTwoId
  if pid1 then
    _,_,firstProfRank,_,_,_,profOneId = GetProfessionInfo(pid1)
  end
  if pid2 then
    _,_,secondProfRank,_,_,_,profTwoId = GetProfessionInfo(pid2)
  end

  firstProf = profNames[ profOneId ]
  secondProf = profNames[ profTwoId ]

  local playerProfessions = '' -- luacheck: ignore
  if pid1 or pid2 then
    playerProfessions = 'professions='
    if pid1 then
      playerProfessions = playerProfessions..Tokenize(firstProf)..'='..tostring(firstProfRank)..'/'
    end
    if pid2 then
      playerProfessions = playerProfessions..Tokenize(secondProf)..'='..tostring(secondProfRank)
    end
  else
    playerProfessions = ''
  end

  -- create a header comment with basic player info and a date
  local headerComment = (
    "# " .. playerName .. ' - ' .. playerSpec
    .. ' - ' .. date('%Y-%m-%d %H:%M') .. ' - '
    .. playerRegion .. '/' .. playerRealm
 )


  -- Construct SimC-compatible strings from the basic information
  local player = Tokenize(playerClass) .. '="' .. playerName .. '"'
  playerLevel = 'level=' .. playerLevel
  playerRace = 'race=' .. Tokenize(playerRace)
  playerRole = 'role=' .. TranslateRole(globalSpecID, role)
  local playerSpecStr = 'spec=' .. Tokenize(playerSpec)
  playerRealm = 'server=' .. Tokenize(playerRealm)
  playerRegion = 'region=' .. Tokenize(playerRegion)

  -- Build the output string for the player (not including gear)
  local simcPrintError = nil
  local simulationcraftProfile = ''

  simulationcraftProfile = simulationcraftProfile .. headerComment .. '\n'
  simulationcraftProfile = simulationcraftProfile .. versionComment .. '\n'
  simulationcraftProfile = simulationcraftProfile .. wowVersionComment .. '\n'
  simulationcraftProfile = simulationcraftProfile .. simcVersionWarning .. '\n'
  simulationcraftProfile = simulationcraftProfile .. '\n'

  simulationcraftProfile = simulationcraftProfile .. player .. '\n'
  simulationcraftProfile = simulationcraftProfile .. playerLevel .. '\n'
  simulationcraftProfile = simulationcraftProfile .. playerRace .. '\n'
  if isZandalariTroll then
    local zandalari_loa = Simulationcraft:GetZandalariLoa()
    if zandalari_loa then
      simulationcraftProfile = simulationcraftProfile .. "zandalari_loa=" .. zandalari_loa .. '\n'
    end
  end
  simulationcraftProfile = simulationcraftProfile .. playerRegion .. '\n'
  simulationcraftProfile = simulationcraftProfile .. playerRealm .. '\n'
  simulationcraftProfile = simulationcraftProfile .. playerRole .. '\n'
  simulationcraftProfile = simulationcraftProfile .. playerProfessions .. '\n'
  simulationcraftProfile = simulationcraftProfile .. playerSpecStr .. '\n'
  simulationcraftProfile = simulationcraftProfile .. '\n'

  if playerSpec == 'unknown' then -- luacheck: ignore
    -- do nothing
    -- Player does not have a spec / is in starting player area
  elseif ClassTalents then
    -- DRAGONFLIGHT
    -- new dragonflight talents
    if Traits.GetLoadoutSerializationVersion() ~= SUPPORTED_LOADOUT_SERIALIZATION_VERSION then
      simcPrintError = 'This version of the SimC addon does not work with this version of WoW.\n'
      simcPrintError = simcPrintError .. 'There is a mismatch in the version of talent string exports.\n'
      simcPrintError = simcPrintError .. '\n'
      if Traits.GetLoadoutSerializationVersion() > SUPPORTED_LOADOUT_SERIALIZATION_VERSION then
        simcPrintError = simcPrintError .. 'WoW is using a newer version - you probably need to update your addon.\n'
      else
        simcPrintError = simcPrintError .. 'WoW is using an older version - you may be running an alpha/beta addon that is not currently ready for retail.\n'
      end
      simcPrintError = simcPrintError .. '\n'
      simcPrintError = simcPrintError .. 'WoW talent string export version = ' .. Traits.GetLoadoutSerializationVersion() .. '\n'
      simcPrintError = simcPrintError .. 'Addon talent string export version = ' .. SUPPORTED_LOADOUT_SERIALIZATION_VERSION .. '\n'
    end

    local currentConfigId = ClassTalents.GetActiveConfigID()

    simulationcraftProfile = simulationcraftProfile .. GetExportString(currentConfigId) .. '\n'
    simulationcraftProfile = simulationcraftProfile .. '\n'

    local specConfigs = ClassTalents.GetConfigIDsBySpecID(globalSpecID)

    for _, configId in pairs(specConfigs) do
      simulationcraftProfile = simulationcraftProfile .. GetExportString(configId) .. '\n'
    end
  else
    -- old talents
    local playerTalents = CreateSimcTalentString()
    simulationcraftProfile = simulationcraftProfile .. playerTalents .. '\n'
  end

  simulationcraftProfile = simulationcraftProfile .. '\n'

  -- Method that gets gear information
  local items = Simulationcraft:GetItemStrings(debugOutput)

  -- output gear
  for slotNum=1, #slotNames do
    local item = items[slotNum]
    if item then
      if item.name then
        simulationcraftProfile = simulationcraftProfile .. '# ' .. item.name .. '\n'
      end
      simulationcraftProfile = simulationcraftProfile .. items[slotNum].string .. '\n'
    end
  end

  -- output gear from bags
  if noBags == false then
    local bagItems = Simulationcraft:GetBagItemStrings(debugOutput)

    if #bagItems > 0 then
      simulationcraftProfile = simulationcraftProfile .. '\n'
      simulationcraftProfile = simulationcraftProfile .. '### Gear from Bags\n'
      for i=1, #bagItems do
        simulationcraftProfile = simulationcraftProfile .. '#\n'
        if bagItems[i].name and bagItems[i].name ~= '' then
          simulationcraftProfile = simulationcraftProfile .. '# ' .. bagItems[i].name .. '\n'
        end
        simulationcraftProfile = simulationcraftProfile .. '# ' .. bagItems[i].string .. '\n'
      end
    end
  end

  -- output weekly reward gear
  if WeeklyRewards then
    if WeeklyRewards:HasAvailableRewards() then
      simulationcraftProfile = simulationcraftProfile .. '\n'
      simulationcraftProfile = simulationcraftProfile .. '### Weekly Reward Choices\n'
      local activities = WeeklyRewards.GetActivities()
      for _, activityInfo in ipairs(activities) do
        for _, rewardInfo in ipairs(activityInfo.rewards) do
          local _, _, _, itemEquipLoc = GetItemInfoInstant(rewardInfo.id)
          local itemLink = WeeklyRewards.GetItemHyperlink(rewardInfo.itemDBID)
          local itemName = GetItemName(itemLink);
          local slotNum = Simulationcraft.invTypeToSlotNum[itemEquipLoc]
          if slotNum then
            local itemStr = GetItemStringFromItemLink(slotNum, itemLink, debugOutput)
            local level, _, _ = GetDetailedItemLevelInfo(itemLink)
            simulationcraftProfile = simulationcraftProfile .. '#\n'
            if itemName and level then
              itemNameComment = itemName .. ' ' .. '(' .. level .. ')'
              simulationcraftProfile = simulationcraftProfile .. '# ' .. itemNameComment .. '\n'
            end
            simulationcraftProfile = simulationcraftProfile .. '# ' .. itemStr .. "\n"
          end
        end
      end
      simulationcraftProfile = simulationcraftProfile .. '#\n'
      simulationcraftProfile = simulationcraftProfile .. '### End of Weekly Reward Choices\n'
    end
  end

  -- Dump out equippable items from a vendor, this is mostly for debugging / data collection
  local numMerchantItems = GetMerchantNumItems()
  if showMerchant and numMerchantItems > 0 then
    simulationcraftProfile = simulationcraftProfile .. '\n'
    simulationcraftProfile = simulationcraftProfile .. '\n### Merchant items\n'
    for i=1,numMerchantItems do
      local link = GetMerchantItemLink(i)
      local name,_,_,_,_,_,_,_,invType = GetItemInfo(link)
      if name and invType ~= "" then
        local slotNum = Simulationcraft.invTypeToSlotNum[invType]
        -- Doesn't work, seems to always return base item level
        -- local level, _, _ = GetDetailedItemLevelInfo(itemLink)
        local itemStr = GetItemStringFromItemLink(slotNum, link, false)
        simulationcraftProfile = simulationcraftProfile .. '#\n'
        if name then
          simulationcraftProfile = simulationcraftProfile .. '# ' .. name .. '\n'
        end
        simulationcraftProfile = simulationcraftProfile .. '# ' .. itemStr .. "\n"
      end
    end
  end


  -- output item links that were included in the /simc chat line
  if links and #links > 0 then
    simulationcraftProfile = simulationcraftProfile .. '\n'
    simulationcraftProfile = simulationcraftProfile .. '\n### Linked gear\n'
    for _, v in pairs(links) do
      local name,_,_,_,_,_,_,_,invType = GetItemInfo(v)
      if name and invType ~= "" then
        local slotNum = Simulationcraft.invTypeToSlotNum[invType]
        local itemStr = GetItemStringFromItemLink(slotNum, v, debugOutput)
        simulationcraftProfile = simulationcraftProfile .. '#\n'
        simulationcraftProfile = simulationcraftProfile .. '# ' .. name .. '\n'
        simulationcraftProfile = simulationcraftProfile .. '# ' .. itemStr .. "\n"
      else -- Someone linked something that was not gear.
        simcPrintError = "Error: " .. v .. " is not gear."
        break
      end
    end
  end

  simulationcraftProfile = simulationcraftProfile .. '\n'
  simulationcraftProfile = simulationcraftProfile .. '### Additional Character Info\n'

  local upgradeCurrenciesStr = Simulationcraft:GetUpgradeCurrencies()
  simulationcraftProfile = simulationcraftProfile .. '#\n'
  simulationcraftProfile = simulationcraftProfile .. '# upgrade_currencies=' .. upgradeCurrenciesStr .. '\n'

  local highWatermarksStr = Simulationcraft:GetSlotHighWatermarks()
  if highWatermarksStr then
    simulationcraftProfile = simulationcraftProfile .. '#\n'
    simulationcraftProfile = simulationcraftProfile .. '# slot_high_watermarks=' .. highWatermarksStr .. '\n'
  end

  -- sanity checks - if there's anything that makes the output completely invalid, punt!
  if specId==nil then
    simcPrintError = "Error: You need to pick a spec!"
  end

  simulationcraftProfile = simulationcraftProfile .. '\n'

  -- Simple checksum to provide a lightweight verification that the input hasn't been edited/modified
  local checksum = adler32(simulationcraftProfile)

  simulationcraftProfile = simulationcraftProfile .. '# Checksum: ' .. string.format('%x', checksum)

  return simulationcraftProfile, simcPrintError
end

-- This is the workhorse function that constructs the profile
function Simulationcraft:PrintSimcProfile(debugOutput, noBags, showMerchant, links)
  local simulationcraftProfile, simcPrintError = Simulationcraft:GetSimcProfile(debugOutput, noBags, showMerchant, links)

  local f = Simulationcraft:GetMainFrame(simcPrintError or simulationcraftProfile)
  f:Show()
end
