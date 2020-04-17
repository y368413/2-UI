local _, realm, player, faction

local quests = {
  [71635] = {29443, 15},
  [71636] = {29444, 15},
  [71637] = {29445, 15},
  [71638] = {29446, 15},
  [71715] = {29451, 85},
  [71716] = {29464, 85},
  [71951] = {29456, 15},
  [71952] = {29457, 15},
  [71953] = {29458, 15},
}

local function TooltipAppend(tip, item)
  if type(ShiGuangDB[realm][faction]) == "table" then
    local temp = {}
    for player2, data in pairs(ShiGuangDB[realm][faction]) do
      if player2 ~= player and (not data[item]) and (data.level or 0) >= quests[item][2] then
        table.insert(temp, "|c"..RAID_CLASS_COLORS[data.class or "PRIEST"].colorStr..player2.."|r")
      end
    end
    if temp[1] then
      table.sort(temp)
      local list = ""
      for i, player2 in ipairs(temp) do
        list = list..player2..(i == #temp - 1 and " and " or ", ")
      end
      tip:AddLine(NEED..list:sub(0, list:trim():len()-1)..".", 0, 1, 1, true)
    end
  end
end

local function TooltipSetItem(tip)
  if type(ShiGuangDB[realm][faction][player]) == "table" then
    local _, item = tip:GetItem()
    if item then
      item = tonumber(item:match("item:(%d+)"))
      if item and quests[item] then
        if ShiGuangDB[realm][faction][player][item] then
          tip:AddLine(ERR_QUEST_ALREADY_DONE, 1, 0, 0, false)
        else
          tip:AddLine(ITEM_STARTS_QUEST, 0, 1, 0, false)
        end
        TooltipAppend(tip, item)
      end
    end
  end
end

local addon = CreateFrame("Frame")
addon:RegisterEvent("ADDON_LOADED")

addon:SetScript("OnEvent", function(addon, event)
  if event == "ADDON_LOADED" then
    realm, player, faction = GetRealmName(), UnitName("player"), UnitFactionGroup("player")

    --DarkmoonFaireQuestsDB = DarkmoonFaireQuestsDB or {}
    ShiGuangDB[realm] = ShiGuangDB[realm] or {}
    ShiGuangDB[realm][faction] = ShiGuangDB[realm][faction] or {}
    ShiGuangDB[realm][faction][player] = ShiGuangDB[realm][faction][player] or {}
    ShiGuangDB[realm][faction][player].level, _, ShiGuangDB[realm][faction][player].class = UnitLevel("player"), UnitClass("player")

    ItemRefTooltip:HookScript("OnTooltipSetItem", TooltipSetItem)
    GameTooltip:HookScript("OnTooltipSetItem", TooltipSetItem)

    local function UpdatePlayerDatabase()
      ShiGuangDB[realm][faction][player].level = UnitLevel("player")
      for item, quest in pairs(quests) do
        if C_QuestLog.IsQuestFlaggedCompleted(quest[1]) then
          ShiGuangDB[realm][faction][player][item] = 1
        else
          ShiGuangDB[realm][faction][player][item] = nil
        end
      end
    end

    addon:UnregisterAllEvents()
    addon:RegisterEvent("PLAYER_LEVEL_UP")
    addon:RegisterEvent("PLAYER_LOGIN")
    addon:RegisterEvent("PLAYER_LOGOUT")
    addon:RegisterEvent("QUEST_AUTOCOMPLETE") -- none of these quests are autocompleted so maybe this is a bit excessive?
    addon:RegisterEvent("QUEST_FINISHED") -- sadly the quest may not yet be flagged completed when this occurs so we need to fire this on more than just this event :(
    addon:RegisterEvent("QUEST_LOG_UPDATE") -- happens quite often, is it really needed when we track the logout event?
    addon:SetScript("OnEvent", UpdatePlayerDatabase)
    UpdatePlayerDatabase()
  end
end)
