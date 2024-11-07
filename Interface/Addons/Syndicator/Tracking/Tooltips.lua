Syndicator.Tooltips = {}

local LibBattlePetTooltipLine = LibStub("LibBattlePetTooltipLine-1-0")

local function CharacterAndRealmComparator(a, b)
  if a.realmNormalized == b.realmNormalized then
    return a.character < b.character
  else
    return a.realmNormalized < b.realmNormalized
  end
end

local function GuildAndRealmComparator(a, b)
  if a.realmNormalized == b.realmNormalized then
    return a.guild < b.guild
  else
    return a.realmNormalized < b.realmNormalized
  end
end

local function IsBoA(itemLink)
  if itemLink:match("battlepet:") then
    return true
  end

  local tooltipData
  if Syndicator.Constants.IsClassic then
    tooltipData = Syndicator.Utilities.DumpClassicTooltip(function(tooltip) tooltip:SetHyperlink(itemLink) end)
  else
    tooltipData = C_TooltipInfo.GetHyperlink(itemLink)
  end

  if not tooltipData then
    return false
  end

  for _, line in ipairs(tooltipData.lines) do
    if tIndexOf(Syndicator.Constants.AccountBoundTooltipLines, line.leftText) ~= nil then
      return true
    end
  end

  return false
end

function Syndicator.Tooltips.AddItemLines(tooltip, summaries, itemLink)
  if itemLink == nil then
    return
  end

  local success, key = pcall(Syndicator.Utilities.GetItemKey, itemLink)

  if not success then
    return
  end

  local connectedRealmsOnly = Syndicator.Config.Get("tooltips_connected_realms_only_2")
  local factionOnly = Syndicator.Config.Get("tooltips_faction_only")
  if IsBoA(itemLink) then
    connectedRealmsOnly = false
    factionOnly = false
  end
  local tooltipInfo = summaries:GetTooltipInfo(key, connectedRealmsOnly, factionOnly)

  -- Remove any equipped information from the tooltip if the option is disabled
  -- (and remove the character if it has none of the items not equipped)
  if not Syndicator.Config.Get("show_equipped_items_in_tooltips") then
    for _, char in ipairs(tooltipInfo.characters) do
      char.equipped = 0
    end
  end

  if Syndicator.Config.Get("tooltips_sort_by_name") then
    table.sort(tooltipInfo.characters, CharacterAndRealmComparator)
    table.sort(tooltipInfo.guilds, GuildAndRealmComparator)
  else
    table.sort(tooltipInfo.characters, function(a, b)
      local left = a.bags + a.bank + a.mail + a.equipped + a.void + a.auctions
      local right = b.bags + b.bank + b.mail + b.equipped + b.void + b.auctions
      if left == right then
        return CharacterAndRealmComparator(a, b)
      else
        return left > right
      end
    end)
    table.sort(tooltipInfo.guilds, function(a, b)
      if a.bank == b.bank then
        return GuildAndRealmComparator(a, b)
      else
        return a.bank > b.bank
      end
    end)
  end

  if not Syndicator.Config.Get(Syndicator.Config.Options.SHOW_GUILD_BANKS_IN_TOOLTIPS) then
    tooltipInfo.guilds = {}
  end

  if #tooltipInfo.characters == 0 and #tooltipInfo.guilds == 0 and tooltipInfo.warband[1] == 0 then
    return
  end

  -- Used to ease adding to battle pet tooltip which doesn't have AddDoubleLine
  local function AddDoubleLine(left, right, ...)
    if tooltip.AddDoubleLine then
      tooltip:AddDoubleLine(left, right, ...)
    elseif tooltip.PetType then
      LibBattlePetTooltipLine:AddDoubleLine(tooltip, left, right)
    end
  end

  local result = "  "
  local totals = 0
  local seenRealms = {}

  for index, s in ipairs(tooltipInfo.characters) do
    totals = totals + s.bags + s.bank + s.mail + s.equipped + s.void + s.auctions
    seenRealms[s.realmNormalized] = true
  end
  for index, s in ipairs(tooltipInfo.guilds) do
    totals = totals + s.bank
    seenRealms[s.realmNormalized] = true
  end
  totals = totals + tooltipInfo.warband[1]
  seenRealms[GetNormalizedRealmName() or ""] = true -- ensure realm name is shown for a different realm

  local realmCount = 0
  for realm in pairs(seenRealms) do
    realmCount = realmCount + 1
  end
  local appendRealm = false
  if realmCount > 1 then
    appendRealm = true
  end

  if totals == 0 then
    return
  end

  AddDoubleLine(SYNDICATOR_L_INVENTORY, LINK_FONT_COLOR:WrapTextInColorCode(SYNDICATOR_L_TOTAL_X:format(WHITE_FONT_COLOR:WrapTextInColorCode(totals))))

  local charactersShown = 0
  for _, s in ipairs(tooltipInfo.characters) do
    local entries = {}
    if s.bags > 0 then
      table.insert(entries, SYNDICATOR_L_BAGS_X:format(WHITE_FONT_COLOR:WrapTextInColorCode(s.bags)))
    end
    if s.bank > 0 then
      table.insert(entries, SYNDICATOR_L_BANK_X:format(WHITE_FONT_COLOR:WrapTextInColorCode(s.bank)))
    end
    if s.mail > 0 then
      table.insert(entries, SYNDICATOR_L_MAIL_X:format(WHITE_FONT_COLOR:WrapTextInColorCode(s.mail)))
    end
    if s.equipped > 0 then
      table.insert(entries, SYNDICATOR_L_EQUIPPED_X:format(WHITE_FONT_COLOR:WrapTextInColorCode(s.equipped)))
    end
    if s.void > 0 then
      table.insert(entries, SYNDICATOR_L_VOID_X:format(WHITE_FONT_COLOR:WrapTextInColorCode(s.void)))
    end
    if s.auctions > 0 then
      table.insert(entries, SYNDICATOR_L_AUCTIONS_X:format(WHITE_FONT_COLOR:WrapTextInColorCode(s.auctions)))
    end
    local character = s.character
    if appendRealm then
      character = character .. "-" .. s.realmNormalized
    end
    if s.className then
      character = "|c" .. (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[s.className].colorStr .. character .. "|r"
    end
    if Syndicator.Config.Get(Syndicator.Config.Options.SHOW_CHARACTER_RACE_ICONS) and s.race then
      character = Syndicator.Utilities.GetCharacterIcon(s.race, s.sex) .. " " .. character
    end
    if #entries > 0 then
      if charactersShown >= Syndicator.Config.Get("tooltips_character_limit") then
        tooltip:AddLine("  ...")
        break
      end
      AddDoubleLine("  " .. character, LINK_FONT_COLOR:WrapTextInColorCode(strjoin(", ", unpack(entries))))
      charactersShown = charactersShown + 1
    end
  end

  for index = 1, math.min(#tooltipInfo.guilds, Syndicator.Config.Get("tooltips_character_limit")) do
    local s = tooltipInfo.guilds[index]
    local output = SYNDICATOR_L_GUILD_X:format(WHITE_FONT_COLOR:WrapTextInColorCode(s.bank))
    local guild = TRANSMOGRIFY_FONT_COLOR:WrapTextInColorCode(s.guild)
    if appendRealm then
      guild = guild .. "-" .. s.realmNormalized
    end
    if Syndicator.Config.Get(Syndicator.Config.Options.SHOW_CHARACTER_RACE_ICONS) then
      guild = Syndicator.Utilities.GetGuildIcon() .. " " .. guild
    end
    AddDoubleLine("  " .. guild, LINK_FONT_COLOR:WrapTextInColorCode(output))
  end
  if #tooltipInfo.guilds > Syndicator.Config.Get("tooltips_character_limit") then
    tooltip:AddLine("  ...")
  end
  if tooltipInfo.warband[1] > 0 then
    AddDoubleLine("  " .. PASSIVE_SPELL_FONT_COLOR:WrapTextInColorCode(SYNDICATOR_L_WARBAND), WHITE_FONT_COLOR:WrapTextInColorCode(tooltipInfo.warband[1]))
  end
  tooltip:Show()
end

function Syndicator.Tooltips.AddCurrencyLines(tooltip, currencyID)
  if tIndexOf(Syndicator.Constants.SharedCurrencies, currencyID) ~= nil then
    return
  end

  local summary = Syndicator.Tracking.GetCurrencyTooltipData(currencyID, Syndicator.Config.Get("tooltips_connected_realms_only_2"), Syndicator.Config.Get("tooltips_faction_only"))

  if Syndicator.Config.Get("tooltips_sort_by_name") then
    table.sort(summary, CharacterAndRealmComparator)
  else
    table.sort(summary, function(a, b)
      if a.quantity == b.quantity then
        return CharacterAndRealmComparator(a, b)
      else
        return a.quantity > b.quantity
      end
    end)
  end

  local quantity = 0
  local seenRealms = {}

  for index, s in ipairs(summary) do
    quantity = quantity + s.quantity
    seenRealms[s.realmNormalized] = true
  end
  seenRealms[GetNormalizedRealmName() or ""] = true -- ensure realm name is shown for a different realm

  if quantity == 0 then -- nothing to show
    return
  end

  local realmCount = 0
  for realm in pairs(seenRealms) do
    realmCount = realmCount + 1
  end
  local appendRealm = false
  if realmCount > 1 then
    appendRealm = true
  end

  tooltip:AddLine(SYNDICATOR_L_ALL_CHARACTERS_COLON .. " " .. WHITE_FONT_COLOR:WrapTextInColorCode(FormatLargeNumber(quantity)))
  for index = 1, math.min(#summary, Syndicator.Config.Get("tooltips_character_limit")) do
    local s = summary[index]
    local character = s.character
    if appendRealm then
      character = character .. "-" .. s.realmNormalized
    end
    if s.className then
      character = "|c" .. (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[s.className].colorStr .. character .. "|r"
    end
    if Syndicator.Config.Get(Syndicator.Config.Options.SHOW_CHARACTER_RACE_ICONS) and s.race then
      character = Syndicator.Utilities.GetCharacterIcon(s.race, s.sex) .. " " .. character
    end
    tooltip:AddDoubleLine("  " .. character, WHITE_FONT_COLOR:WrapTextInColorCode(FormatLargeNumber(s.quantity)))
  end
  if #summary > Syndicator.Config.Get("tooltips_character_limit") then
    tooltip:AddLine("  ...")
  end
  tooltip:Show()
end
