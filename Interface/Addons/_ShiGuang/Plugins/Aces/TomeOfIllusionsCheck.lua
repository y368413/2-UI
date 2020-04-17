--## Author: Marihk ## Version: v2.4

TomeOfIllusionsCheck = {
  missingItemData = {},
  tomesToQuests = {
     [138795] = 42879, -- Tome of Illusions: Draenor
     [138793] = 42877, -- Tome of Illusions: Pandaria
     [138794] = 42878, -- Tome of Illusions: Secrets of the Shado-pan
     [138791] = 42875, -- Tome of Illusions: Cataclysm
     [138792] = 42876, -- Tome of Illusions: Elemental Lords
     [138790] = 42874, -- Tome of Illusions: Northrend
     [138789] = 42873, -- Tome of Illusions: Outland
     [138787] = 42871, -- Tome of Illusions: Azeroth
     -- The illusion and quest IDs below were provided by Brudarek on Curse.
     -- Thank you for contributing!
     [120287] = 42950, -- Enchanter's Illusion - Primal Victory
  	 [120286] = 42949, -- Enchanter's Illusion - Glorious Tyranny
  	 [138796] = 42891, -- Illusion: Executioner
  	 [138797] = 42892, -- Illusion: Mongoose
  	 [138798] = 42893, -- Illusion: Sunfire
  	 [138799] = 42894, -- Illusion: Soulfrost
  	 [138800] = 42895, -- Illusion: Blade Ward
  	 [138801] = 42896, -- Illusion: Blood Draining
  	 [138955] = 42973, -- Illusion: Rune of Razorice (DK)
  	 [138803] = 42900, -- Illusion: Mending
  	 [138804] = 42902, -- Illusion: Colossus
  	 [138805] = 42906, -- Illusion: Jade Spirit
  	 [138806] = 42907, -- Illusion: Mark of Shadowmoon
  	 [138807] = 42908, -- Illusion: Mark of the Shattered Hand
  	 [138808] = 42909, -- Illusion: Mark of the Bleeding Hollow
  	 [138809] = 42910, -- Illusion: Mark of Blackrock
  	 [138827] = 42934, -- Illusion: Nightmare
  	 [138828] = 42938, -- Illusion: Chronos
  	 [138832] = 42941, -- Illusion: Earthliving (Shaman)
  	 [138833] = 42942, -- Illusion: Flametongue (Shaman)
  	 [138834] = 42943, -- Illusion: Frostbrand (Shaman)
  	 [138835] = 42944, -- Illusion: Rockbiter (Shaman)
  	 [138836] = 42945, -- Illusion: Windfury (Shaman)
  	 [138838] = 42948, -- Illusion: Deathfrost
  	 [138954] = 42972, -- Illusion: Poisoned (Rogue)
  	 [138802] = 42898, -- Illusion: Power Torrent
     -- The illusion and quest IDs below were provided by Salty on Curse.
     -- Thank you for contributing!
     [118572] = 42946, -- Illusion - Flames of Ragnaros
     [128649] = 42947, -- Illusion - Winter's Grasp
  },
}

TomeOfIllusionsCheckFrame = LibStub("AceAddon-3.0"):NewAddon("TomeOfIllusionsCheck", "AceEvent-3.0")

-- Courtesy of http://www.lua.org/pil/19.3.html
local function pairsByKeys(t, f)
   local a = {}
   for n in pairs(t) do table.insert(a, n) end
   table.sort(a, f)
   local i = 0      -- iterator variable
   local iter = function ()   -- iterator function
      i = i + 1
      if a[i] == nil then return nil
      else return a[i], t[a[i]]
      end
   end
   return iter
end

function TomeOfIllusionsCheck:PrintTomeCheck()
  local tomesByName = {}
  for itemId, questId in pairs(TomeOfIllusionsCheck.tomesToQuests) do
    local itemName, itemLink, _, _, _, _, _, _, _, _, _ = GetItemInfo(itemId)
    tomesByName[itemName] = {
      questId = questId,
      itemLink = itemLink,
    }
  end
  table.sort(tomesByName)
  for itemName, itemInfo in pairsByKeys(tomesByName) do
    print(format("%s - %s", itemInfo.itemLink, C_QuestLog.IsQuestFlaggedCompleted(itemInfo.questId) and "|cFF32AA00 √ |r" or "|cFF8BA3FD X |r"))
  end
end

local function itemInfoReceived()
  for key, itemId in pairs(TomeOfIllusionsCheck.missingItemData) do
    local itemName, _, _, _, _, _, _, _, _, _, _ = GetItemInfo(itemId)
    if itemName then tremove(TomeOfIllusionsCheck.missingItemData, key) end
  end

  if #TomeOfIllusionsCheck.missingItemData == 0 then
    TomeOfIllusionsCheckFrame:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
    TomeOfIllusionsCheck:PrintTomeCheck()
  end
end

function TomeOfIllusionsCheck:CheckItemCache()
  for itemId, questId in pairs(TomeOfIllusionsCheck.tomesToQuests) do
     local itemName, _, _, _, _, _, _, _, _, _, _ = GetItemInfo(itemId)
     if not itemName then
       tinsert(TomeOfIllusionsCheck.missingItemData, itemId)
       TomeOfIllusionsCheckFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED", itemInfoReceived)
     end
  end
end

SLASH_TomeOfIllusionsCheck1 = "/tomecheck"
SlashCmdList["TomeOfIllusionsCheck"] = function()
  TomeOfIllusionsCheck:CheckItemCache()
  if #TomeOfIllusionsCheck.missingItemData == 0 then TomeOfIllusionsCheck:PrintTomeCheck() end
end

local lineAdded = false
local function OnIllusionBookTooltipAddLine(tooltip, ...)
   if not lineAdded then
      local _, link = tooltip:GetItem()
      if not link then return end
      local itemId = tonumber(string.match(link, 'item:(%d+):'))
      local questId = TomeOfIllusionsCheck.tomesToQuests[itemId]
      if questId then
        if C_QuestLog.IsQuestFlaggedCompleted(questId) then
          tooltip:AddLine(format("|cFF32AA00"..COLLECTED.."|r", itemId))
          lineAdded = true
        else
          tooltip:AddLine(format("|cFF8BA3FD"..NOT_COLLECTED.."|r", itemId))
          lineAdded = true
        end
      end
   end
end
GameTooltip:HookScript("OnTooltipSetItem", OnIllusionBookTooltipAddLine)
GameTooltip:HookScript("OnTooltipCleared", function(tooltip, ...) lineAdded = false end)