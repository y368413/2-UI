---@class addonTableSyndicator
local addonTable = select(2, ...)

addonTable.Locales = CopyTable(SYNDICATOR_LOCALES.enUS)
for key, translation in pairs(SYNDICATOR_LOCALES[GetLocale()]) do
  addonTable.Locales[key] = translation
end
for key, translation in pairs(addonTable.Locales) do
  _G["SYNDICATOR_L_" .. key] = translation
end

Syndicator.Locales = addonTable.Locales
