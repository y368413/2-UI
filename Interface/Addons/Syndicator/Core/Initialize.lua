---@class addonTableSyndicator
local addonTable = select(2, ...)

addonTable.CallbackRegistry = CreateFromMixins(CallbackRegistryMixin)
addonTable.CallbackRegistry:OnLoad()
addonTable.CallbackRegistry:GenerateCallbackEvents(addonTable.Constants.Events)

Syndicator.CallbackRegistry = addonTable.CallbackRegistry

addonTable.Utilities.OnAddonLoaded("Syndicator", function()
  addonTable.Config.InitializeData()
  addonTable.SlashCmd.Initialize()
  addonTable.Options.Initialize()

  addonTable.Tracking.Initialize()

  addonTable.Search.Initialize()
end)
