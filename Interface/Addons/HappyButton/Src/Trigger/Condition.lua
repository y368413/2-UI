local addonName, _ = ...


---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class Utils: AceModule
local U = addon:GetModule('Utils')

---@class Result: AceModule
local R = addon:GetModule("Result")

---@class Condition: AceModule
local Condition = addon:NewModule("Condition")

-- 创建条件组
---@return ConditionGroupConfig
function Condition:NewGroup()
    ---@type ConditionGroupConfig
    local group = {
        conditions = {},
        expression = "%cond.1",
        effects = {}
    }
    return group
end

-- 创建自身触发器
---@return ConditionConfig
function Condition:NewCondition()
    ---@type ConditionConfig
    local condition = {}
    return condition
end

-- 条件判断
---@param leftValue number | boolean
---@param rightValue number | boolean
---@param operator CondOperator
---@return Result
function Condition:ExecOperator(leftValue, operator, rightValue)
    if leftValue == nil or rightValue == nil then
        return R:Err("Invalid leftValue or rightValue.")
    end
    if operator == "=" then
        return R:Ok(leftValue == rightValue)
    elseif operator == "!=" then
        return R:Ok(leftValue ~= rightValue)
    elseif operator == "<" then
        return R:Ok(leftValue < rightValue)
    elseif operator == ">" then
        return R:Ok(leftValue > rightValue)
    elseif operator == "<=" then
        return R:Ok(leftValue <= rightValue)
    elseif operator == ">=" then
        return R:Ok(leftValue >= rightValue)
    else
        return R:Err("Invalid operator.")
    end
end


-- 多个条件
---@param condResults boolean[]
---@param expression CondExpr
---@return boolean
function Condition:ExecExpression(condResults, expression)
    -- 替换占位符
    local expr = expression:gsub("%%cond%.(%d)", function(index)
        local idx = tonumber(index)
        return tostring(condResults[idx])
    end)
    -- 处理简单的逻辑表达式
    local function evalSimpleExpr(e)
        -- 处理 AND
        local ands = {}
        for orPart in e:gmatch("[^%s]+") do
            if orPart == "and" then
                table.insert(ands, "and")
            else
                table.insert(ands, orPart)
            end
        end
        local result = true
        local currentOp = "and"  -- 默认操作符
        for _, part in ipairs(ands) do
            if part == "and" then
                currentOp = "and"
            elseif part == "or" then
                currentOp = "or"
            else
                if currentOp == "and" then
                    result = result and (part == "true")
                elseif currentOp == "or" then
                    result = result or (part == "true")
                end
            end
        end
        return result
    end

    -- 处理括号
    while true do
        local start, finish = expr:find("%b()")
        if not start then break end
        local subExpr = expr:sub(start + 1, finish - 1)
        local subResult = evalSimpleExpr(subExpr)
        expr = expr:sub(1, start - 1) .. tostring(subResult) .. expr:sub(finish + 1)
    end

    return evalSimpleExpr(expr)
end
