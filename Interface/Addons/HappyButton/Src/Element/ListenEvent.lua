local addonName, _ = ...

---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class ListenEvent: AceModule
local ListenEvent = addon:NewModule("ListenEvent")

---@param itemAttr ItemAttr
---@return table<EventString, {}>
function ListenEvent:GetEventFromItemAttr(itemAttr)
    local events = {} ---@type table<EventString, {}>
    local hasItem = false
    local hasEquipment = false
    local hasSpell = false
    local hasToy = false
    local hasMount = false
    local hasPet = false
    if itemAttr.type == const.ITEM_TYPE.ITEM then
        hasItem = true
    end
    if itemAttr.type == const.ITEM_TYPE.EQUIPMENT then
        hasEquipment = true
    end
    if itemAttr.type == const.ITEM_TYPE.TOY then
        hasToy = true
    end
    if itemAttr.type == const.ITEM_TYPE.SPELL then
        hasSpell = true
    end
    if itemAttr.type == const.ITEM_TYPE.MOUNT then
        hasMount = true
    end
    if itemAttr.type == const.ITEM_TYPE.PET then
        hasPet = true
    end
    if hasItem or hasEquipment then
        events["BAG_UPDATE"] = {}
    end
    if hasEquipment then
        events["PLAYER_EQUIPMENT_CHANGED"] = {}
    end
    if hasSpell then
        events["SPELLS_CHANGED"] = {}
        events["PLAYER_TALENT_UPDATE"] = {}
    end
    return events
end

---@param macroCommands MacroCommand[]
---@return table<EventString, {}>
function ListenEvent:GetEventFromMacroCommand(macroCommands)
    local events = {} ---@type table<EventString, {}>
    local target = "target" ---@type MacroTargetCondType
    if macroCommands == nil then
        return events
    end
    for _, macroCommand in ipairs(macroCommands) do
        if macroCommand.conds then
            for _, cond in ipairs(macroCommand.conds) do
                if cond.targetConds then
                    for _, targetCond in ipairs(cond.targetConds) do
                        target = targetCond.type
                    end
                end
                if cond.booleanConds then
                    for _, booleanCond in ipairs(cond.booleanConds) do
                        if booleanCond.type == "exists" then
                            if target == "target" then
                                events["PLAYER_TARGET_CHANGED"] = {}
                            end
                        end
                    end
                end
            end
        end
        if macroCommand.param and macroCommand.param.items then
            for _, item in ipairs(macroCommand.param.items) do
                local paramEvents = ListenEvent:GetEventFromItemAttr(item)
                for e, _ in pairs(paramEvents) do
                    events[e] = {}
                end
            end
        end
    end
    return events
end
