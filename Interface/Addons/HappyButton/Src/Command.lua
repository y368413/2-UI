local addonName, _ = ... ---@type string, table

---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class BarCore: AceModule
local BarCore = addon:GetModule("BarCore")

---@class HbFrame: AceModule
local HbFrame = addon:GetModule("HbFrame")
