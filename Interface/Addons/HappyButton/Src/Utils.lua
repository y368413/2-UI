local addonName, _ = ... ---@type string, table

---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')


---@class UtilsTable
---@field IsArray fun(table: table): boolean
---@field Contains fun(table: table, element: any): boolean
---@field IsInArray fun(array: table, element: any): boolean
---@field GetArrayIndex fun(table: table, element: any): number
---@field DeepCopy fun(original: table): table
---@field SafeGet fun(table: table, ...: string|number): any?
---@field Equal fun(t1: table, t2: table): boolean
local UtilsTable = {}

---@class UtilsPrint
---@field Print fun(...): nil
---@field PrintColoredText fun(text: any, color: string): nil
---@field PrintSuccessText fun(text: any): nil
---@field PrintErrorText fun(text: any): nil
---@field PrintWarnText fun(text: any): nil
---@field PrintInfoText fun(text: any): nil
---@field PrintTable fun(table: table, indent: number | nil): nil
local UtilsPrint = {}

---@class UtilsString
---@field Utf8ToTable fun(str: string): string[] 将字符串转为字符列表
---@field ToVertical fun(text: string | nil): string 将字符串转为竖形结构
---@field GenerateID fun(): string 返回随机ID
---@field Trim fun(str: string): string
---@field Split fun(str: string, delimiter: string): string[]
local UtilsString = {}

---@class Utils: AceModule
local Utils = addon:NewModule("Utils")

Utils.Table = UtilsTable
Utils.Print = UtilsPrint
Utils.String = UtilsString

-- 判断table是否是数组
function UtilsTable.IsArray(t)
    if type(t) ~= "table" then return false end

    local i = 1
    for _ in pairs(t) do
        if t[i] == nil then
            return false
        end
        i = i + 1
    end
    return true
end

-- 检查表中是否包含某个元素
function UtilsTable.Contains(table, element)
    for _, value in ipairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

-- 检查目标是否在数组中
---@param array table
---@param target any
---@return boolean
function UtilsTable.IsInArray(array, target)
    for _, value in ipairs(array) do
        if value == target then
            return true
        end
    end
    return false
end

-- 检查目标在数组中的下标, 如果找到返回下标，如果没有返回0
---@param array table
---@param target any
---@return number
function UtilsTable.GetArrayIndex(array, target)
    for index, value in ipairs(array) do
        if value == target then
            return index
        end
    end
    return 0
end


-- 深度复制
---@param orig any
---@return any
function UtilsTable.DeepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[UtilsTable.DeepCopy(orig_key)] = UtilsTable.DeepCopy(orig_value)
        end
        setmetatable(copy, UtilsTable.DeepCopy(getmetatable(orig)))
    else -- 基本数据类型直接赋值
        copy = orig
    end
    return copy
end

-- 深度复制字典
function UtilsTable.DeepCopyDict(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == 'table' then
            copy[k] = UtilsTable.DeepCopyDict(v)
        else
            copy[k] = v
        end
    end
    return copy
end

-- 深度复制列表
function UtilsTable.DeepCopyList(original)
    local copy = {}
    for k, v in ipairs(original) do
        if type(v) == 'table' then
            copy[k] = UtilsTable.DeepCopyDict(v)
        else
            copy[k] = v
        end
    end
    return copy
end

-- 安全的get语法
function UtilsTable.SafeGet(t, ...)
    local v = t
    for _, key in ipairs({...}) do
        if v then
            v = v[key]
        else
            return nil  -- 如果中间有任何一部分为 nil，直接返回 nil
        end
    end
    return v
end

-- 比较两个table是否相等
---@param t1 table
---@param t2 table
---@return boolean
function UtilsTable.Equal(t1, t2)
    -- 如果两个表引用的是同一个表
    if t1 == t2 then
        return true
    end

    -- 如果两个表不是表类型，直接返回 false
    if type(t1) ~= "table" or type(t2) ~= "table" then
        return false
    end

    -- 检查 t1 中的每个键值对是否都在 t2 中
    for key, value in pairs(t1) do
        -- 如果 t2 中没有该键，或者该键的值不相等
        if t2[key] == nil or not UtilsTable.Equal(value, t2[key]) then
            return false
        end
    end

    -- 检查 t2 中的每个键值对是否都在 t1 中
    for key, _ in pairs(t2) do
        -- 如果 t1 中没有该键，说明 t1 和 t2 不相等
        if t1[key] == nil then
            return false
        end
    end
    return true
end

-- 修改全局打印方法，在打印信息前加上插件名称
function UtilsPrint.Print(...) _G.print(
    "|cfffff700H|r|cffeeaf7aa|r|cffe38483pp|r|cffd966a6y|r|cffc84dcaB|r|cffb539e6u|r|cff9f2bfft|r|cffa636f3t|r|cffbb4ed2o|r|cffe38280n|r" ..
    "|cfffff700:|r", ...) end

-- 打印彩色字体
function UtilsPrint.PrintColoredText(text, color)
    local coloredText = "|c" .. color .. text .. "|r"
    UtilsPrint.Print(coloredText)
end

-- 打印成功
function UtilsPrint.PrintSuccessText(text)
    local coloredText = "|cff00ff00" .. text .. "|r"
    UtilsPrint.Print(coloredText)
end

-- 打印错误
function UtilsPrint.PrintErrorText(text)
    local coloredText = "|cffff0000" .. text .. "|r"
    UtilsPrint.Print(coloredText)
end

-- 打印警告
function UtilsPrint.PrintWarnText(text)
    local coloredText = "|cffffd700" .. text .. "|r"
    UtilsPrint.Print(coloredText)
end

-- 打印信息
function UtilsPrint.PrintInfoText(text)
    UtilsPrint.Print(text)
end

-- 调试打印对象
function UtilsPrint.PrintTable(tbl, indent)
    -- 如果没有提供缩进级别，则初始化为2
    indent = indent or 2
    -- 遍历表
    if tbl == nil then
        print(nil)
        return
    end
    for key, value in pairs(tbl) do
        -- 创建缩进字符串
        local formatting = string.rep("  ", indent) .. tostring(key) .. ": "

        if type(value) == "table" then
            -- 如果值是一个表，则递归调用 printTable
            print(formatting .. "{")
            UtilsPrint.PrintTable(value, indent + 1)
            print(string.rep("  ", indent) .. "}")
        else
            -- 否则，打印键和值
            print(formatting .. tostring(value))
        end
    end
end

-- 调试打印对象
function UtilsPrint.PrintDictType(tbl, indent)
    -- 如果没有提供缩进级别，则初始化为2
    indent = indent or 2
    -- 遍历表
    if tbl == nil then
        print(nil)
        return
    end
    for key, value in pairs(tbl) do
        local formatting = string.rep("  ", indent) .. tostring(key) .. ": "
        if type(value) == "table" then
            print(formatting .. "{")
            UtilsPrint.PrintTable(value, indent + 1)
            print(string.rep("  ", indent) .. "}")
        else
            print(formatting .. tostring(type(value)))
        end
    end
end

-- 函数：将 UTF-8 字符串拆分为单个字符表
---@param str string
---@return string[]
function UtilsString.Utf8ToTable(str)
    local charTable = {} ---@type string[]
    local i = 1
    local length = #str

    while i <= length do
        local byte = string.byte(str, i)
        local charLength

        if byte >= 240 then     -- 4字节字符 (例如 emoji)
            charLength = 4
        elseif byte >= 224 then -- 3字节字符 (中文、韩文等)
            charLength = 3
        elseif byte >= 192 then -- 2字节字符 (部分拉丁字母等)
            charLength = 2
        else                    -- 1字节字符 (ASCII)
            charLength = 1
        end

        local char = str:sub(i, i + charLength - 1)
        table.insert(charTable, char)
        i = i + charLength
    end

    return charTable
end


function UtilsString.ToVertical(str)
    if str == nil then
        return ""
    end
    local chars = UtilsString.Utf8ToTable(str)
    local verticalStr = ""
    for _, char in ipairs(chars) do
        verticalStr = verticalStr .. char .. "\n"
    end
    return verticalStr
end


-- 生成时间戳+8位随机字符串来标识配置的唯一性
---@return string
function UtilsString.GenerateID()
    local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    local result = {}
    -- 生成随机部分
    for _ = 1, 8 do
        local index = math.random(#chars)
        table.insert(result, chars:sub(index, index))
    end
    -- 获取时间戳
    local timestamp = time()
    -- 拼接随机字符串和时间戳
    return timestamp .. '_' .. table.concat(result)
end


-- 去除首尾空格
---@param str string
---@return string
function UtilsString.Trim(str)
    return string.match(str, "^%s*(.-)%s*$")
end


-- 按特殊字符拆分字符串
---@param str string 需要拆分的字符串
---@param delimiter string 分隔符
---@return string[]
function UtilsString.Split(str, delimiter)
    local result = {}
    for part in string.gmatch(str, "([^" .. delimiter .. "]+)") do
        table.insert(result, part)
    end
    return result
end
