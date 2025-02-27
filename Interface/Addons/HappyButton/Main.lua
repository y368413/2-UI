local addonName, HT = ... ---@type string, table
---@class HappyButton: AceModule
local addon = LibStub("AceAddon-3.0"):NewAddon(HT, addonName, "AceHook-3.0", "AceConsole-3.0", "AceEvent-3.0")

addon:SetDefaultModuleState(false)
