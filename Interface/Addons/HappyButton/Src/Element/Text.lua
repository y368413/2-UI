local addonName, _ = ...


---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')


---@class Text: AceModule
local Text = addon:NewModule("Text")

---@param text TextExpr
---@return TextConfig
function Text:New(text)
    ---@type TextConfig
    local textConfig = {
        text = text
    }
    return textConfig
end

---@param text string
---@return string
function Text:GetTextDesc(text)
    if const.TextOptions[text] then
        return const.TextOptions[text]
    else
        return text
    end
end