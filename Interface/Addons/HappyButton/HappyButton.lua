local addonName, _ = ... ---@type string, table

---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class BarCore: AceModule
local BarCore = addon:GetModule("BarCore")

BarCore:Start()
