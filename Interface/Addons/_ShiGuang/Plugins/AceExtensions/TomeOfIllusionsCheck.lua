--## Author: Marihk ## Version: v2.4

TomeOfIllusionsCheck = {
  missingItemData = {},
  tomesToQuests = {
     [174932] = 58927, --幻象：虚空之锋          Illusion: Void Edge
     [172177] = 57596, --幻象：怨幽之寒          Illusion: Wraithchill
     [138795] = 42879, --幻象之书：德拉诺        Tome of Illusions: Draenor
     [138793] = 42877, --幻象之书：潘达利亚      Tome of Illusions: Pandaria
     [138794] = 42878, --幻象之书：影踪派的秘密  Tome of Illusions: Secrets of the Shado-pan
     [138791] = 42875, --幻象之书：大地的裂变    Tome of Illusions: Cataclysm
     [138792] = 42876, --幻象之书：元素领主      Tome of Illusions: Elemental Lords
     [138790] = 42874, --幻象之书：诺森德        Tome of Illusions: Northrend
     [138789] = 42873, --幻象之书：外域          Tome of Illusions: Outland
     [138787] = 42871, --幻象之书：艾泽拉斯      Tome of Illusions: Azeroth
     -- The illusion and quest IDs below were provided by Brudarek on Curse.
     -- Thank you for contributing!
     [120287] = 42950, --附魔师的幻象 - 原始胜利 Enchanter's Illusion - Primal Victory
  	 [120286] = 42949, --附魔师的幻象 - 辉煌暴君 Enchanter's Illusion - Glorious Tyranny
  	 [138796] = 42891, --幻象：斩杀              Illusion: Executioner
  	 [138797] = 42892, --幻象：猫鼬              Illusion: Mongoose
  	 [138798] = 42893, --幻象：阳炎              Illusion: Sunfire
  	 [138799] = 42894, --幻象：魂霜              Illusion: Soulfrost
  	 [138800] = 42895, --幻象：利刃防护          Illusion: Blade Ward
  	 [138801] = 42896, --幻象：吸血              Illusion: Blood Draining
  	 [138803] = 42900, --幻象：治愈              Illusion: Mending
  	 [138804] = 42902, --幻象：巨神像            Illusion: Colossus
  	 [138805] = 42906, --幻象：玉魂              Illusion: Jade Spirit
  	 [138806] = 42907, --幻象：影月之印          Illusion: Mark of Shadowmoon
  	 [138807] = 42908, --幻象：碎手之印          Illusion: Mark of the Shattered Hand
  	 [138808] = 42909, --幻象：血环之印          Illusion: Mark of the Bleeding Hollow
  	 [138809] = 42910, --幻象：黑石之印          Illusion: Mark of Blackrock
  	 [138827] = 42934, --幻象：梦魇              Illusion: Nightmare
  	 [138828] = 42938, --幻象：时光              Illusion: Chronos
  	 [138832] = 42941, --幻象：大地生命(职业:SM) Illusion: Earthliving (Shaman)
  	 [138833] = 42942, --幻象：火舌(职业:SM)     Illusion: Flametongue (Shaman)
  	 [138834] = 42943, --幻象：冰封(职业:SM)     Illusion: Frostbrand (Shaman)
  	 [138835] = 42944, --幻象：石化(职业:SM)     Illusion: Rockbiter (Shaman)
  	 [138836] = 42945, --幻象：风怒(职业:SM)     Illusion: Windfury (Shaman)
  	 [138954] = 42972, --幻象：淬毒(职业:DZ)     Illusion: Poisoned (Rogue)
  	 [138955] = 42973, --幻象：冰锋符文(职业:DK) Illusion: Rune of Razorice (DK)
  	 [138838] = 42948, --幻象：死亡霜冻          Illusion: Deathfrost
  	 [138802] = 42898, --幻象：能量洪流          Illusion: Power Torrent
     -- The illusion and quest IDs below were provided by Salty on Curse.
     -- Thank you for contributing!
     [118572] = 42946, --幻象：拉格纳罗斯的怒焰  Illusion - Flames of Ragnaros
     [128649] = 42947, --幻象：寒冬之握          Illusion - Winter's Grasp
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