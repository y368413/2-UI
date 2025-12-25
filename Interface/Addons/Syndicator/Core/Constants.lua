---@class addonTableSyndicator
local addonTable = select(2, ...)

addonTable.Constants = {
  AllBagIndexes = {
    Enum.BagIndex.Backpack,
    Enum.BagIndex.Bag_1,
    Enum.BagIndex.Bag_2,
    Enum.BagIndex.Bag_3,
    Enum.BagIndex.Bag_4,
  },
  AllBankIndexes = {},
  AllWarbandIndexes = {},

  IsRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE,
  IsClassic = WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE,
  IsMists = WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC,
  IsCata = WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC,
  IsWrath = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC,
  IsBC = WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC or GetBuildInfo():match("^2%.") ~= nil,
  IsEra = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC and GetBuildInfo():match("^1%.") ~= nil,

  IsTitan = GetBuildInfo():match("^3%.8") ~= nil,

  IsLegacyAH = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC or IsUsingLegacyAuctionClient ~= nil and IsUsingLegacyAuctionClient(),

  BattlePetCageID = 82800,

  BankBagSlotsCount = 0,

  MaxGuildBankTabItemSlots = 98,

  EquippedInventorySlotOffset = 1,

  WarbandBankActive = false,

  MailExpiryDuration = 30 * 24 * 60 * 60,
}

addonTable.Constants.IsBrokenTooltipScanning = false

if addonTable.Constants.IsRetail then
  addonTable.Constants.WarbandBankActive = true
  addonTable.Constants.CharacterBankTabsActive = Enum.BagIndex.CharacterBankTab_1 ~= nil
  table.insert(addonTable.Constants.AllBagIndexes, Enum.BagIndex.ReagentBag)
  addonTable.Constants.BagSlotsCount = 5
  addonTable.Constants.MaxBagSize = 42
  if addonTable.Constants.CharacterBankTabsActive then
    addonTable.Constants.AllBankIndexes = {
      Enum.BagIndex.CharacterBankTab_1,
      Enum.BagIndex.CharacterBankTab_2,
      Enum.BagIndex.CharacterBankTab_3,
      Enum.BagIndex.CharacterBankTab_4,
      Enum.BagIndex.CharacterBankTab_5,
      Enum.BagIndex.CharacterBankTab_6,
    }
    addonTable.Constants.BankBagSlotsCount = 0
  else
    addonTable.Constants.AllBankIndexes = {
      Enum.BagIndex.Bank,
      Enum.BagIndex.BankBag_1,
      Enum.BagIndex.BankBag_2,
      Enum.BagIndex.BankBag_3,
      Enum.BagIndex.BankBag_4,
      Enum.BagIndex.BankBag_5,
      Enum.BagIndex.BankBag_6,
      Enum.BagIndex.BankBag_7,
      Enum.BagIndex.Reagentbank,
    }
    addonTable.Constants.BankBagSlotsCount = 7
  end
  addonTable.Constants.AllWarbandIndexes = {
    Enum.BagIndex.AccountBankTab_1,
    Enum.BagIndex.AccountBankTab_2,
    Enum.BagIndex.AccountBankTab_3,
    Enum.BagIndex.AccountBankTab_4,
    Enum.BagIndex.AccountBankTab_5,
  }
end

if addonTable.Constants.IsEra or KeyRingButtonIDToInvSlotID then
  table.insert(addonTable.Constants.AllBagIndexes, Enum.BagIndex.Keyring)
end
if addonTable.Constants.IsEra then
  addonTable.Constants.BankBagSlotsCount = 6
elseif addonTable.Constants.IsClassic then
  addonTable.Constants.BankBagSlotsCount = 7
end
if addonTable.Constants.IsClassic then
  addonTable.Constants.AllBankIndexes = {
    Enum.BagIndex.Bank,
  }
  -- Workaround for the enum containing the wrong values for the bank bag slots
  for i = 1, addonTable.Constants.BankBagSlotsCount do
    addonTable.Constants.AllBankIndexes[i + 1] = NUM_BAG_SLOTS + i
  end
  addonTable.Constants.BagSlotsCount = 4
  addonTable.Constants.MaxBagSize = 36
end

addonTable.Constants.Events = {
  "CharacterDeleted",
  "GuildDeleted",

  "BagCacheUpdate",
  "WarbandBankCacheUpdate",
  "MailCacheUpdate",
  "CurrencyCacheUpdate",
  "WarbandCurrencyCacheUpdate",
  "GuildCacheUpdate",
  "GuildNameSet",
  "EquippedCacheUpdate",
  "VoidCacheUpdate",
  "AuctionsCacheUpdate",

  "Ready",

  "AuctionValueSourceChanged"
}

-- Hidden currencies for all characters tooltips as they are shared between characters
addonTable.Constants.SharedCurrencies = {
  2032, -- Trader's Tender
  3292, -- Infinite Knowledge
}

local AccountBoundTooltipLines = {
  ITEM_BIND_TO_BNETACCOUNT,
  ITEM_BNETACCOUNTBOUND,
  ITEM_BIND_TO_ACCOUNT,
  ITEM_ACCOUNTBOUND,
}
local AccountBoundTooltipLinesNotBound = {
  ITEM_ACCOUNTBOUND_UNTIL_EQUIP,
  ITEM_BIND_TO_ACCOUNT_UNTIL_EQUIP,
}
addonTable.Constants.AccountBoundTooltipLines = {}
addonTable.Constants.AccountBoundTooltipLinesNotBound = {}
-- Done this way because not all the lines exist on all clients
for _, line in pairs(AccountBoundTooltipLines) do
  table.insert(addonTable.Constants.AccountBoundTooltipLines, line)
end
for _, line in pairs(AccountBoundTooltipLinesNotBound) do
  table.insert(addonTable.Constants.AccountBoundTooltipLinesNotBound, line)
end

Syndicator.Constants = CopyTable(addonTable.Constants)
