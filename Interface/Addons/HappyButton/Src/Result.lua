local addonName, _ = ... ---@type string, table
---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class Result: AceModule
---@field _value any | nil
---@field _error string | nil
local Result = addon:NewModule("Result")

-- 定义 Result 的 Ok 构造函数
---@param value any
---@return Result<any>
function Result:Ok(value)
    local obj = setmetatable({}, { __index = self })
    obj._value = value
    obj._error = nil
    return obj
end

-- 定义 Result 的 Err 构造函数
---@param err string
---@return Result
function Result:Err(err)
    local obj = setmetatable({}, { __index = self })
    if err == nil then
        error("err must not be nil.")
    end
    obj._error = err
    return obj
end

function Result:is_ok()
    return self._error == nil
end

function Result:is_err()
    return self._error ~= nil
end

-- 定义方法来处理 Result
---@return any
function Result:unwrap()
    if self:is_ok() then
        return self._value
    else
        error("Called unwrap on an Err: " .. tostring(self._error))
    end
end

function Result:unwrap_or(default)
    if self:is_ok() then
        return self._value
    else
        return default
    end
end

---@return any
function Result:unwrap_err()
    if not self:is_ok() then
        return self._error
    else
        error("Called unwrap_err on an Ok: " .. tostring(self._value))
    end
end
