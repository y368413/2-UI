function Syndicator.Tracking.GetCurrencyTooltipData(currencyID, sameConnectedRealm, sameFaction)
  local matchingRealms
  if sameConnectedRealm then
    local realms = Syndicator.Utilities.GetConnectedRealms()

    matchingRealms = {}
    for _, r in ipairs(realms) do
      matchingRealms[r] = true
    end
  end

  local currentFaction = UnitFactionGroup("player")

  local summary = {}
  for character, info in pairs(SYNDICATOR_DATA.Characters) do
    if not info.details.hidden and (not sameConnectedRealm or matchingRealms[info.details.realmNormalized]) and (not sameFaction or info.details.faction == currentFaction) then
      if info.currencies and info.currencies[currencyID] and info.currencies[currencyID] > 0 then
        table.insert(summary, {
          character = info.details.character,
          realmNormalized = info.details.realmNormalized,
          className = info.details.className,
          race = info.details.race,
          sex = info.details.sex,
          quantity = info.currencies[currencyID]
        })
      end
    end
  end

  return summary
end
