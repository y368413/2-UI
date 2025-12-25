---@class addonTableSyndicator
local addonTable = select(2, ...)

function addonTable.Search.Initialize()
  addonTable.Search.InitializeSearchEngine()

  SlashCmdList["SyndicatorSearch"] = addonTable.Search.SearchEverywhereAndPrintResults
  SLASH_SyndicatorSearch1 = "/baganatorsearch"
  SLASH_SyndicatorSearch2 = "/bgrs"
  SLASH_SyndicatorSearch3 = "/syndicatorsearch"
  SLASH_SyndicatorSearch4 = "/syns"
end
