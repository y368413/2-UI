local addonName, _ = ... ---@type string, table
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class E: AceModule
local E = addon:GetModule("Element")

---@class Item: AceModule
local Item = addon:GetModule("Item")

---@class Utils: AceModule
local U = addon:GetModule('Utils')

local L = LibStub("AceLocale-3.0"):GetLocale(addonName, false)

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class Trigger: AceModule
local Trigger = addon:GetModule("Trigger")

---@class Condition: AceModule
local Condition = addon:GetModule("Condition")

---@class Effect: AceModule
local Effect = addon:GetModule("Effect")

---@class Api: AceModule
local Api = addon:GetModule("Api")

---@class Macro: AceModule
local Macro = addon:GetModule("Macro")

---@class AuraCache: AceModule
local AuraCache = addon:GetModule("AuraCache")

---@class ElementCallback: AceModule
local ECB = addon:NewModule("ElementCallback")

---@class CbResult
---@field icon string | number | nil
---@field text string | nil
---@field borderColor RGBAColor | nil
---@field isLearned boolean | nil 是否学习或者拥有
---@field isUsable boolean | nil 是否可以使用
---@field isCooldown boolean | nil 是否冷却中
---@field count number | nil 物品堆叠数量|技能充能次数
---@field item ItemAttr | nil
---@field itemCooldown CooldownInfo | nil
---@field macro string | nil
---@field effects EffectConfig[] | nil
---@field isHideBtn boolean | nil  是否隐藏按钮
---@field leftClickCallback function | nil
local CbResult = {}

-- 随机选择callback
-- 函数永远只能返回包含一个CbResult的列表
---@param element ItemGroupConfig
---@param lastCbResults CbResult[] 上一次更新的结果
---@return CbResult[]
function ECB.CallbackOfRandomMode(element, lastCbResults)
    -- 如果上一次结果可用，则继续使用上一次的结果
    if lastCbResults and #lastCbResults then
        local r = lastCbResults[1]
        if r and r.item then
            if Item:IsLearned(r.item.id, r.item.type) and Item:IsUsable(r.item.id, r.item.type) and Item:IsCooldown(Item:GetCooldown(r.item)) then
                return lastCbResults
            end
        end
    end
    local usableItemList = {} ---@type ItemConfig[]
    local cooldownItemList = {} ---@type ItemConfig[]
    for _, ele in ipairs(element.elements) do
        local item = E:ToItem(ele)
        local isLearned = Item:IsLearned(item.extraAttr.id, item.extraAttr.type)
        local isUsable = Item:IsUsable(item.extraAttr.id, item.extraAttr.type)
        local isCooldown = Item:IsCooldown(Item:GetCooldown(item.extraAttr))
        if isLearned and isUsable then
            table.insert(usableItemList, item)
        end
        if isLearned and isUsable and isCooldown then
            table.insert(cooldownItemList, item)
        end
    end
    ---@type CbResult
    local cb
    -- 如果有冷却可用的item，随机选择一个
    if #cooldownItemList > 0 then
        local randomIndex = math.random(1, #cooldownItemList)
        local selectedItem = cooldownItemList[randomIndex]
        cb = ECB:CallbackByItemConfig(selectedItem)
    elseif #usableItemList > 0 then
        -- 没有没有冷却可用，则选择可用
        local randomIndex = math.random(1, #usableItemList)
        local selectedItem = usableItemList[randomIndex]
        cb = ECB:CallbackByItemConfig(selectedItem)
    elseif #element.elements > 0 then
        -- 没有可用的item时随机返回一个
        local randomIndex = math.random(1, #element.elements)
        local selectedItem = E:ToItem(element.elements[randomIndex])
        cb = ECB:CallbackByItemConfig(selectedItem)
    else
        cb = ECB:NilCallback()
    end
    return { cb, }
end

-- 顺序选择callback
-- 函数永远只能返回包含一个CbResult的列表
---@param element ItemGroupConfig
---@param lastCbResults CbResult[] 上一次更新的结果
---@return CbResult[]
function ECB.CallbackOfSeqMode(element, lastCbResults)
    if lastCbResults and #lastCbResults then
        local r = lastCbResults[1]
        if r and r.item then
            if Item:IsLearned(r.item.id, r.item.type) and Item:IsUsable(r.item.id, r.item.type) and Item:IsCooldown(Item:GetCooldown(r.item)) then
                return lastCbResults
            end
        end
    end
    ---@type CbResult
    local cb
    for _, ele in ipairs(element.elements) do
        local item = E:ToItem(ele)
        local isLearned = Item:IsLearned(item.extraAttr.id, item.extraAttr.type)
        local isUsable = Item:IsUsable(item.extraAttr.id, item.extraAttr.type)
        if isLearned and isUsable then
            local isCooldown = Item:IsCooldown(Item:GetCooldown(item.extraAttr))
            if isCooldown then
                cb = ECB:CallbackByItemConfig(item)
                break
            end
        end
    end
    if cb == nil then
        if #element.elements > 0 then
            local randomIndex = math.random(1, #element.elements)
            local selectedItem = E:ToItem(element.elements[randomIndex])
            cb = ECB:CallbackByItemConfig(selectedItem)
        else
            cb = ECB:NilCallback()
        end
    end
    return { cb, }
end

-- 宏callback
-- 函数永远只能返回包含一个CbResult的列表
---@param element MacroConfig
---@param lastCbResults CbResult[] 上一次更新的结果
---@return CbResult[]
function ECB.CallbackOfMacroMode(element, lastCbResults)
    ---@type CbResult
    local cb = {}
    local ast = element.extraAttr.ast
    if element.icon then
        cb.icon = element.icon
    end
    if ast == nil then
        return { cb, }
    end
    if ast.tooltip ~= nil then
        cb.item = ast.tooltip
    end
    if ast.commands ~= nil then
        local macroStrings = {} ---@type string[]
        for _, command in ipairs(ast.commands) do
            local macroCondString = nil ---@type nil | string
            local commandMet = false -- 用来判断每一条宏命令的条件语句是否满足条件，如果有一个条件满足，则整条语句可以执行
            if command.conds then
                if #command.conds == 0 then
                    commandMet = true
                else
                    for _, cond in ipairs(command.conds) do
                        local condString, condMet = Macro:CgCond(cond, true)
                        if condMet == true then
                            commandMet = true
                        end
                        if condString ~= nil then
                            if macroCondString == nil then
                                macroCondString = ""
                            end
                            macroCondString = macroCondString .. "[" .. condString .. "]"
                        end
                    end
                end
            else
                commandMet = true        -- 如果没有宏条件，则默认满足条件
            end
            local macroParamString = nil --- @type nil | string
            if command.param then
                macroParamString = Macro:CgParam(command)
            end
            local macroString = "/" .. command.cmd
            if macroCondString then
                macroString = macroString .. " " .. macroCondString
            end
            if macroParamString then
                macroString = macroString .. " " .. macroParamString
            end
            table.insert(macroStrings, macroString)
            if commandMet == true and command.cmd == "use" and cb.item == nil then
                if command.param.items and #command.param.items > 0 then
                    cb.item = command.param.items[1]
                end
                if command.param.slot then
                    local slotItemID = GetInventoryItemID("player", command.param.slot)
                    if slotItemID then
                        local itemID, _, _, _, icon, _, _ = Api.GetItemInfoInstant(slotItemID)
                        if itemID then
                            local itemAttr = {
                                id = itemID,
                                icon = icon,
                                name = C_Item.GetItemNameByID(itemID),
                                type =
                                    const.ITEM_TYPE.EQUIPMENT
                            } ---@type ItemAttr
                            cb.item = itemAttr
                        end
                    end
                end
            end
        end
        cb.macro = table.concat(macroStrings, "\n")
    end
    return { cb, }
end

-- 获取宏图标
---@param element ElementConfig
---@return ItemAttr | nil
function ECB.UpdateMacroItemInfo(element)
    local macro = E:ToMacro(element)
    local ast = macro.extraAttr.ast
    if ast == nil then
        return nil
    end
    if ast.tooltip ~= nil then
        return ast.tooltip
    end
    if ast.commands ~= nil then
        for _, command in ipairs(ast.commands) do
            if command.cmd == "use" then
                local commandMet = false -- 用来判断每一条宏命令的条件语句是否满足条件，如果有一个条件满足，则整条语句可以执行
                if command.conds then
                    for _, cond in ipairs(command.conds) do
                        local _, condMet = Macro:CgCond(cond, true)
                        if condMet == true then
                            commandMet = true
                        end
                    end
                else
                    commandMet = true -- 如果没有宏条件，则默认满足条件
                end
                if commandMet then
                    if command.param.items and #command.param.items > 0 then
                        return command.param.items[1]
                    end
                    if command.param.slot then
                        local slotItemID = GetInventoryItemID("player", command.param.slot)
                        if slotItemID then
                            local itemID, _, _, _, icon, _, _ = Api.GetItemInfoInstant(slotItemID)
                            if itemID then
                                local itemAttr = {
                                    id = itemID,
                                    icon = icon,
                                    name = C_Item.GetItemNameByID(itemID),
                                    type =
                                        const.ITEM_TYPE.EQUIPMENT
                                } ---@type ItemAttr
                                return itemAttr
                            end
                        end
                    end
                end
            end
        end
    end
    return nil
end

-- 单个展示模式callback
-- 函数永远只能返回包含一个CbResult的列表
---@param element ItemConfig
---@param lastCbResults CbResult[] 上一次更新的结果
---@return CbResult[]
function ECB.CallbackOfSingleMode(element, lastCbResults)
    if #lastCbResults == 0 then
        table.insert(lastCbResults, ECB:CallbackByItemConfig(element))
    end
    return lastCbResults
end

-- 脚本模式
---@param element ScriptConfig
---@param lastCbResults CbResult[]
---@return CbResult[]
function ECB.CallbackOfScriptMode(element, lastCbResults)
    local script = E:ToScript(element)
    local cbResults = {} ---@type CbResult[]
    local func, loadstringErr = loadstring(script.extraAttr.script)
    if not func then
        local errMsg = L["Illegal script."] .. " " .. loadstringErr
        U.Print.PrintErrorText(errMsg)
        return cbResults
    end
    local cbStatus, cbResult = pcall(func())
    if not cbStatus then
        local errMsg = L["Illegal script."] .. " " .. tostring(cbResult)
        U.Print.PrintErrorText(errMsg)
        return cbResults
    end
    -- 兼容返回列表和单个cbResult
    if not U.Table.IsArray(cbResult) then
        table.insert(cbResults, cbResult)
        return cbResults
    end
    for _, cb in ipairs(cbResult) do
        if cb then
            table.insert(cbResults, cb)
        end
    end
    return cbResults
end

---@param element ItemConfig
---@return CbResult
function ECB:CallbackByItemConfig(element)
    local item = E:ToItem(element)
    ---@type CbResult
    local cbResult = {
        icon = item.extraAttr.icon,
        text = item.extraAttr.name or item.title,
        item = item.extraAttr,
    }
    return cbResult
end

---@return CbResult
function ECB:NilCallback()
    ---@type CbResult
    return {
        icon = 134400,
        text = "",
        isLearned = false,
        isUsable = false,
        count = 0,
        item = nil,
        macro = nil,
        leftClickCallback = nil
    }
end

-- 更新自身触发器
---@param cbResult CbResult
---@param event EventString
---@param eventArgs any[]
function ECB:UpdateSelfTrigger(cbResult, event, eventArgs)
    if cbResult.item then
        -- 物品、装备
        if const.ITEM_TYPE.ITEM == cbResult.item.type or const.ITEM_TYPE.EQUIPMENT == cbResult.item.type then
            if cbResult.isLearned == nil or U.Table.IsInArray({ "PLAYER_ENTERING_WORLD", "BAG_UPDATE", "PLAYER_EQUIPMENT_CHANGED" }, event) then
                cbResult.isLearned = Item:IsLearned(cbResult.item.id, cbResult.item.type)
                -- 如果物品没有学会，则默认不会对可用性和冷却进行判断以减少API调用
                if cbResult.isLearned == false then
                    return
                end
            end
            if cbResult.isUsable == nil or U.Table.IsInArray({ "PLAYER_ENTERING_WORLD", "BAG_UPDATE_COOLDOWN", "UNIT_SPELLCAST_SUCCEEDED", "PLAYER_EQUIPMENT_CHANGED" }, event) then
                cbResult.isUsable = Item:IsUsable(cbResult.item.id, cbResult.item.type)
            end
            if cbResult.isCooldown == nil or U.Table.IsInArray({ "PLAYER_ENTERING_WORLD", "BAG_UPDATE_COOLDOWN", "UNIT_SPELLCAST_SUCCEEDED", "PLAYER_EQUIPMENT_CHANGED", "MODIFIER_STATE_CHANGED"}, event) then
                cbResult.itemCooldown = Item:GetCooldown(cbResult.item)
                cbResult.isCooldown = Item:IsCooldown(cbResult.itemCooldown)
            end
            cbResult.count = Api.GetItemCount(cbResult.item.id, false)
        end
        -- 技能
        if const.ITEM_TYPE.SPELL == cbResult.item.type then
            if cbResult.isLearned == nil or U.Table.IsInArray({ "PLAYER_ENTERING_WORLD", "SPELLS_CHANGED" }, event) then
                cbResult.isLearned = Item:IsLearned(cbResult.item.id, cbResult.item.type)
                if cbResult.isLearned == false then
                    return
                end
            end
            if cbResult.isUsable == nil or U.Table.IsInArray({ "PLAYER_ENTERING_WORLD", "UNIT_SPELLCAST_SUCCEEDED" }, event) then
                cbResult.isUsable = Item:IsUsable(cbResult.item.id, cbResult.item.type)
            end
            if cbResult.isCooldown == nil or U.Table.IsInArray({ "PLAYER_ENTERING_WORLD", "UNIT_SPELLCAST_SUCCEEDED", "MODIFIER_STATE_CHANGED", "HB_GCD_UPDATE" }, event) then
                cbResult.itemCooldown = Item:GetCooldown(cbResult.item)
                cbResult.isCooldown = Item:IsCooldown(cbResult.itemCooldown)
            end
            if cbResult.count == nil or U.Table.IsInArray({ "PLAYER_ENTERING_WORLD", "SPELL_UPDATE_CHARGES" }, event) then
                local chargeInfo = Api.GetSpellCharges(cbResult.item.id)
                if chargeInfo then
                    cbResult.count = chargeInfo.currentCharges
                end
            end
        end
        -- 玩具
        if const.ITEM_TYPE.TOY == cbResult.item.type then
            if cbResult.isLearned == nil or U.Table.IsInArray({ "PLAYER_ENTERING_WORLD", "NEW_TOY_ADDED" }, event) then
                cbResult.isLearned = Item:IsLearned(cbResult.item.id, cbResult.item.type)
                if cbResult.isLearned == false then
                    return
                end
            end
            if cbResult.isUsable == nil or U.Table.IsInArray({ "PLAYER_ENTERING_WORLD", }, event) then
                cbResult.isUsable = Item:IsUsable(cbResult.item.id, cbResult.item.type)
            end
            if cbResult.isCooldown == nil or U.Table.IsInArray({ "PLAYER_ENTERING_WORLD", "UNIT_SPELLCAST_SUCCEEDED", "MODIFIER_STATE_CHANGED"}, event) then
                cbResult.itemCooldown = Item:GetCooldown(cbResult.item)
                cbResult.isCooldown = Item:IsCooldown(cbResult.itemCooldown)
            end
            cbResult.count = nil
        end
        -- 坐骑
        if const.ITEM_TYPE.MOUNT == cbResult.item.type then
            if cbResult.isLearned == nil or U.Table.IsInArray({ "PLAYER_ENTERING_WORLD", "NEW_MOUNT_ADDED" }, event) then
                cbResult.isLearned = Item:IsLearned(cbResult.item.id, cbResult.item.type)
                if cbResult.isLearned == false then
                    return
                end
            end
            if cbResult.isUsable == nil or U.Table.IsInArray({ "PLAYER_ENTERING_WORLD", "MOUNT_JOURNAL_USABILITY_CHANGED" }, event) then
                cbResult.isUsable = Item:IsUsable(cbResult.item.id, cbResult.item.type)
            end
            cbResult.count = nil
        end
        -- 宠物
        if const.ITEM_TYPE.PET == cbResult.item.type then
            if cbResult.isLearned == nil or U.Table.IsInArray({ "PLAYER_ENTERING_WORLD", "NEW_PET_ADDED" }, event) then
                cbResult.isLearned = Item:IsLearned(cbResult.item.id, cbResult.item.type)
                if cbResult.isLearned == false then
                    return
                end
            end
            if cbResult.isUsable == nil or U.Table.IsInArray({ "PLAYER_ENTERING_WORLD", "PET_BAR_UPDATE_COOLDOWN" }, event) then
                cbResult.isUsable = Item:IsUsable(cbResult.item.id, cbResult.item.type)
            end
            if cbResult.isCooldown == nil or U.Table.IsInArray({ "PLAYER_ENTERING_WORLD", "UNIT_SPELLCAST_SUCCEEDED", "PET_BAR_UPDATE_COOLDOWN", "MODIFIER_STATE_CHANGED" }, event) then
                cbResult.itemCooldown = Item:GetCooldown(cbResult.item)
                cbResult.isCooldown = Item:IsCooldown(cbResult.itemCooldown)
            end
            cbResult.count = nil
        end
    end
    -- 更新物品边框,物品边框不会改变颜色，只需要第一次的时候更新
    if cbResult.item and cbResult.borderColor == nil then
        if cbResult.item.type == const.ITEM_TYPE.ITEM or cbResult.item.type == const.ITEM_TYPE.TOY or cbResult.item.type == const.ITEM_TYPE.EQUIPMENT then
            local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expansionID, setID, isCraftingReagent =
                Api.GetItemInfo(cbResult.item.id)
            if itemQuality then
                cbResult.borderColor = const.ItemQualityColor[itemQuality]
            end
        elseif cbResult.item.type == const.ITEM_TYPE.MOUNT then
            cbResult.borderColor = const.ItemQualityColor[Enum.ItemQuality.Epic]
        elseif cbResult.item.type == const.ITEM_TYPE.PET then
            cbResult.borderColor = const.ItemQualityColor[Enum.ItemQuality.Rare]
        end
    end
    if cbResult.borderColor == nil then
        cbResult.borderColor = const.DefaultItemColor
    end
end

-- 对cbResult进行触发器处理
---@param eleConfig ElementConfig
---@param cbResult CbResult
function ECB:UseTrigger(eleConfig, cbResult)
    local effects = {} ---@type EffectConfig[]
    if not eleConfig.triggers or #eleConfig.triggers == 0 then
        return effects
    end
    if not eleConfig.condGroups or #eleConfig.condGroups == 0 then
        cbResult.effects = effects
        return effects
    end
    local triggers = {} ---@type table<string, TriggerConfig>
    for _, trigger in ipairs(eleConfig.triggers) do
        triggers[trigger.id] = trigger
    end
    for _, condGroup in ipairs(eleConfig.condGroups) do
        if condGroup.effects and #condGroup.effects > 0 and condGroup.conditions and #condGroup.conditions and condGroup.expression then
            local condResults = {} ---@type boolean[]
            for _, cond in ipairs(condGroup.conditions) do
                local condResult = false ---@type boolean
                if cond.leftTriggerId and cond.leftVal and triggers[cond.leftTriggerId] then
                    local leftTrigger = triggers[cond.leftTriggerId] ---@type TriggerConfig
                    if leftTrigger.type == "self" then
                        local leftValue = cbResult[cond.leftVal]
                        if type(cond.rightValue) == "number" or type(cond.rightValue) == "boolean" then
                            -- 判断条件返回真/假
                            ---@diagnostic disable-next-line: param-type-mismatch
                            local r = Condition:ExecOperator(leftValue, cond.operator, cond.rightValue)
                            if r:is_ok() then
                                condResult = r:unwrap()
                            end
                        end
                    end
                    if leftTrigger.type == "aura" then
                        ---@type table<AuraTriggerCond, any>
                        local auraTriggerCond = {}
                        local trigger = Trigger:ToAuraTriggerConfig(leftTrigger)
                        if trigger.confine then
                            auraTriggerCond.targetIsEnemy = false
                            auraTriggerCond.targetCanAttack = false
                            local target = trigger.confine.target
                            if target ~= nil or target ~= "player" then
                                if UnitIsEnemy("player", target) then
                                    auraTriggerCond.targetIsEnemy = true
                                end
                                if UnitCanAttack("player", "target") then
                                    auraTriggerCond.targetCanAttack = true
                                end
                            end
                            if UnitExists(target) and UnitIsEnemy("player", target) then
                                auraTriggerCond.targetIsEnemy = true
                            else
                                auraTriggerCond.targetIsEnemy = false
                            end
                            local spellId = trigger.confine.spellId
                            if spellId then
                                -- 追加需要处理的缓存
                                if cond.leftVal == "exist" then
                                    AuraCache:PutTask(target, spellId, nil, true)
                                end
                                if cond.leftVal == "remainingTime" then
                                    AuraCache:PutTask(target, spellId, tonumber(cond.rightValue), true)
                                end
                                auraTriggerCond.exist = false
                                auraTriggerCond.remainingTime = 0
                                local aura = AuraCache:Get(target, spellId)
                                if aura then
                                    if aura.isHelpful and trigger.confine.type == "buff" then
                                        auraTriggerCond.exist = true
                                        auraTriggerCond.remainingTime = aura.expirationTime - GetTime()
                                    end
                                    if aura.isHarmful and trigger.confine.type == "defbuff" then
                                        auraTriggerCond.exist = true
                                        auraTriggerCond.remainingTime = aura.expirationTime - GetTime()
                                    end
                                end
                                local leftValue = auraTriggerCond[cond.leftVal]
                                ---@diagnostic disable-next-line: param-type-mismatch
                                local r = Condition:ExecOperator(leftValue, cond.operator, cond.rightValue)
                                if r:is_ok() then
                                    condResult = r:unwrap()
                                end
                            end
                        end
                    end
                    if leftTrigger.type == "item" then
                        local itemTriggerCond = Trigger:GetItemTriggerCond(leftTrigger)
                        local leftValue = itemTriggerCond[cond.leftVal]
                        ---@diagnostic disable-next-line: param-type-mismatch
                        local r = Condition:ExecOperator(leftValue, cond.operator, cond.rightValue)
                        if r:is_ok() then
                            condResult = r:unwrap()
                        end
                    end
                end
                table.insert(condResults, condResult)
            end
            -- 判断条件组返回真/假
            local condGroupR = Condition:ExecExpression(condResults, condGroup.expression)
            if condGroupR then
                for _, effect in ipairs(condGroup.effects) do
                    -- 首先判断状态，如果状态为nil则不处理
                    if effect.status ~= nil then
                        -- 判断是否有相同的效果，如果有则替换，没有则添加
                        local hasSame = false
                        for index, _effect in ipairs(effects) do
                            if _effect.type == effect.type then
                                hasSame = true
                                effects[index] = effect
                                break
                            end
                        end
                        if hasSame == false then
                            table.insert(effects, effect)
                        end
                    end
                end
            end
        end
    end
    cbResult.effects = effects
end
