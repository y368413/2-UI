local addonName, _ = ...


---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class Utils: AceModule
local U = addon:GetModule('Utils')

---@class Api: AceModule
local Api = addon:GetModule("Api")

---@class Item: AceModule
local Item = addon:GetModule("Item")

---@class Trigger: AceModule
local Trigger = addon:NewModule("Trigger")

---@class AuraCache: AceModule
local AuraCache = addon:GetModule("AuraCache")

local L = LibStub("AceLocale-3.0"):GetLocale(addonName, false)

-- 创建自身触发器
---@return TriggerConfig
function Trigger:NewSelfTriggerConfig()
    ---@type TriggerConfig
    local triggerConfig = {
        id = U.String.GenerateID(),
        type = "self",
        confine = {}
    }
    return triggerConfig
end


-- 创建物品触发器
---@return TriggerConfig
function Trigger:NewItemTriggerConfig()
    ---@type TriggerConfig
    local triggerConfig = {
        id = U.String.GenerateID(),
        type = "item",
        confine = {}
    }
    return triggerConfig
end

---@param config TriggerConfig
---@return SelfTriggerConfig
function Trigger:ToSelfTriggerConfig(config)
    return config --- @type SelfTriggerConfig
end


---@param config TriggerConfig
---@return AuraTriggerConfig
function Trigger:ToAuraTriggerConfig(config)
    return config --- @type AuraTriggerConfig
end

---@param config TriggerConfig
---@return ItemTriggerConfig
function Trigger:ToItemTriggerConfig(config)
    return config --- @type ItemTriggerConfig
end

-- 获取触发器名称
---@param triggerType  TriggerType
---@return string
function Trigger:GetTriggerName(triggerType)
    if triggerType == "self" then
        return L["Self Trigger"]
    end
    if triggerType == "aura" then
        return L["Aura Trigger"]
    end
    if triggerType == "item" then
        return L["Item Trigger"]
    end
    return "Unknown"
end


-- 根据触发器类型获取触发器条件列表
-- ！！！返回列表的key值务必在ElementCallback函数的返回值中！！！
---@param triggerType TriggerType
---@return table<string, type>
function Trigger:GetConditions(triggerType)
    if triggerType == "self" then
        return {
            count = "number",
            isLearned = "boolean",
            isUsable = "boolean",
            isCooldown = "boolean"
        } ---@type table<SelfTriggerCond, type>
    end
    if triggerType == "aura" then
        return {
            remainingTime = "number",
            targetIsEnemy = "boolean",
            targetCanAttack = "boolean",
            exist = "boolean"
        } ---@type table<AuraTriggerCond, type>
    end
    if triggerType == "item" then
        return {
            count = "number",
            isLearned = "boolean",
            isUsable = "boolean",
            isCooldown = "boolean"
        } ---@type table<ItemTriggerCond, type>
    end
    return {}
end

-- 根据触发器类型获取触发器条件选项
---@param triggerType TriggerType
---@return table<string, string>
function Trigger:GetConditionsOptions(triggerType)
    local conditions = self:GetConditions(triggerType)
    local options = {}
    for k, cond in pairs(conditions) do
        options[k] = L[k]
    end
    return options
end


---@param confine TriggerConfine
---@return AuraTriggerConfine
function Trigger:ToAuraConfine(confine)
    ---@type AuraTriggerConfine
    return confine
end

---@param triggerConfig TriggerConfig
---@return table<ItemTriggerCond, any>
function Trigger:GetItemTriggerCond(triggerConfig)
    ---@type table<ItemTriggerCond, any>
    local result = {}
    local trigger = Trigger:ToItemTriggerConfig(triggerConfig)
    if not trigger.confine then
        return result
    end
    local item = trigger.confine.item
    if item == nil then
        return result
    end
    result.isLearned = Item:IsLearned(item.id, item.type)
    result.isUsable = Item:IsUsable(item.id, item.type)
    result.isCooldown = Item:IsCooldown(Item:GetCooldown(item))
    if item.type == const.ITEM_TYPE.ITEM then
        result.count = Api.GetItemCount(item.id, false)
    elseif item.type == const.ITEM_TYPE.SPELL then
        local chargeInfo = Api.GetSpellCharges(item.id)
        if chargeInfo then
            result.count = chargeInfo.currentCharges
        end
    else
        result.count = 1
    end
    return result
end

---@param confine TriggerConfine
---@return ItemTriggerConfine
function Trigger:ToItemConfine(confine)
    ---@type ItemTriggerConfine
    return confine
end