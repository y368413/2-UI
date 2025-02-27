local addonName, _ = ...


---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class Utils: AceModule
local U = addon:GetModule('Utils')

---@class LoadCondition: AceModule
local LoadCondition = addon:NewModule("LoadCondition")


---@class LoadConditionConfig
---@field LoadCond true | false  -- 是否启用，默认true
---@field CombatCond true | false | nil  -- 战斗中加载true，战斗外加载false，都加载nil
---@field ClassCond nil | Class[]  -- 职业判断

-- 根据载入条件判断是否加载
---@param loadConditionConfig LoadConditionConfig
---@return boolean
function LoadCondition:Pass(loadConditionConfig)
    -- 旧版本没有这个配置项，配置通过
    if loadConditionConfig == nil then
        return true
    end
    -- 如果没有开启，则返回false
    if loadConditionConfig.LoadCond == false then
        return false
    end
    -- 开启了职业配置
    if loadConditionConfig.ClassCond ~= nil then
        local hasClass = false
        local _, classId = UnitClassBase("player")
        for _, id in ipairs(loadConditionConfig.ClassCond) do
            if classId == id then
                hasClass = true
                break
            end
        end
        if not hasClass then
            return false
        end
    end
    return true
end
