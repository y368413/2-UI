local addonName, _ = ...

---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

local L = LibStub("AceLocale-3.0"):GetLocale(addonName, false)

---@class Utils: AceModule
local U = addon:GetModule('Utils')

---@class Result: AceModule
local R = addon:GetModule("Result")

---@class Item: AceModule
local Item = addon:GetModule("Item")

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class Api: AceModule
local Api = addon:GetModule("Api")

---@class ListenEvent: AceModule
local ListenEvent = addon:GetModule("ListenEvent")

---@class Macro: AceModule
local Macro = addon:NewModule("Macro")

---@alias MC string  --- MC:MacroChar宏字符的简称，用来将宏字符串按UTF-8格式拆分成一个个字符
---@alias MCList MC[]


---@class MacroParam
---@field reset string | nil  -- 队列宏使用
---@field slot  number | nil  -- 装备装备使用
---@field script string | nil -- 非cast/use/castsqueue/equit宏使用，例如/click、/say
---@field items ItemAttr[] | nil


---@class TargetCond
---@field type MacroTargetCondType

---@class BooleanCond
---@field type MacroBooleanCondType
---@field isTarget boolean -- 是否是目标条件还是玩家条件
---@field params nil | boolean | number[] | string[] | string | number


---@class MacroCond
---@field targetConds TargetCond[] | nil
---@field booleanConds BooleanCond[] | nil


---@class MacroCommand
---@field cmd MacroCmd           -- 宏命令类型
---@field conds MacroCond[] | nil     -- 条件
---@field param MacroParam  -- 宏参数

---@class MacroAst
---@field tooltip ItemAttr | nil
---@field commands MacroCommand[] | nil


---@class MacroParseResult
---@field cmd string[]
---@field conds string[][]
---@field remaining string[]


---@param mcList MCList
---@return string
function Macro:MCListToString(mcList)
    local s = ""
    for _, _t in ipairs(mcList) do
        s = s .. _t
    end
    return s
end

---@param macro string
---@return Result -- 返回宏AST结果
function Macro:Ast(macro)
    ---@type MacroAst
    local result = {
        tooltip = nil, -- 用于存储 showtooltip 的参数（如果有的话）
        commands = {}  -- 用于存储宏的其他命令
    }
    -- 按"\n"回车↩️拆分字符串
    local macroStrings = {} ---@type string[]
    for _, v in ipairs(U.String.Split(macro, "\n")) do
        v = U.String.Trim(v)
        if v ~= "" then
            table.insert(macroStrings, v)
        end
    end
    local commandStrings = macroStrings
    -- 如果第一行是#showtooltip开头，获取宏的图标
    if string.sub(macroStrings[1], 1, 12) == "#showtooltip" then
        local macroIcon = U.String.Trim(string.sub(macroStrings[1], 13))
        if macroIcon ~= "" then
            local macroIconItemAttr = Item:CreateItemAttr(macroIcon)
            Item:CompleteItemAttr(macroIconItemAttr)
            result.tooltip = macroIconItemAttr
        end
        commandStrings = { unpack(macroStrings, 2) }
    end
    ---------------------------------
    ---- 遍历命令字符串列表，组成AST
    ---------------------------------
    local macroCommands = {} ---@type MacroCommand[]
    for _, stat in ipairs(commandStrings) do
        local r = Macro:AstParse(stat)
        if r:is_err() then
            return r
        end
        local p = r:unwrap() ---@type MacroParseResult
        local cmd = Macro:MCListToString(p.cmd)
        local cmdR = Macro:AstCmd(cmd)
        if cmdR:is_err() then
            return cmdR
        end
        local conds = {} ---@type MacroCond[]
        for _, cond in ipairs(p.conds) do
            local condString = Macro:MCListToString(cond)
            condString = U.String.Trim(condString)
            condString = string.sub(condString, 2, -2) -- 移除宏条件的[和]，例如[help, dead, combat]变成help, dead, combat
            -- 如果宏条件内为空的条件：[]，则表示永远匹配，那么整个语句的条件可以移除
            if condString == "" then
                conds = {}
                break
            else
                table.insert(conds, Macro:AstCondition(condString):unwrap())
            end
        end
        local remaining = Macro:MCListToString(p.remaining)
        local paramR = Macro:AstParam(cmdR:unwrap(), remaining)
        if paramR:is_err() then
            return paramR
        end
        table.insert(macroCommands, {
            cmd = cmdR:unwrap(),
            conds = conds,
            param = paramR:unwrap()
        })
    end
    result.commands = macroCommands
    return R:Ok(result)
end

-- 第一步解析：
-- 生成cmd：例如 "/cast"、"/use"
-- 生成conds：例如["@target", "@mouseover, dead"]
-- 生成remaining：例如"reset=60 item:224464, item:211880; reset=60 item:5512, item:211880"、"疾跑"
---@param stat string
---@return Result
function Macro:AstParse(stat)
    local statement = U.String.Utf8ToTable(stat)
    local cmd = {} ---@type MC[]
    local cmdEnd = false
    local conds = {} ---@type MC[][]
    local condsEnd = false
    local cond = {} ---@type MC[]
    local condStart = false
    local remainings = {} ---@type MC[][]
    local remaining = {} ---@type MC[]
    local remainingStart = false
    if statement and #statement ~= 0 or statement[1] == "/" then
        for _, s in ipairs(statement) do
            if s == " " then                  -- 空格字符
                if cmdEnd == false then       -- 如果命令没有结束，此时空格表示结束命令语句
                    cmdEnd = true
                elseif condsEnd == false then -- 如果条件组没有结束
                    if condStart == true then -- 如果当前条件激活，追加到当前条件
                        table.insert(cond, s)
                    end                       -- 如果当前条件没有激活，则什么都不做，等待下一个"["来激活条件
                else                          -- 如果命令和条件组都结束了，则追加到剩余字符串中
                    table.insert(remaining, s)
                end
            elseif s == "[" then
                if cmdEnd == false then
                    return R:Err(s .. " [错误1。")
                end
                if condStart == true then
                    return R:Err(s .. " [错误2。")
                end
                if #cond ~= 0 then
                    return R:Err(s .. " [错误3。")
                end
                if condsEnd == true then
                    table.insert(remaining, s)
                else
                    table.insert(cond, s)
                    condStart = true
                end
            elseif s == "]" then
                if cmdEnd == false then
                    return R:Err(s .. " ]错误1。")
                end
                if condStart == false then
                    return R:Err(s .. " ]错误2。")
                end
                if cond[1] ~= "[" then
                    return R:Err(s .. " ]错误3。")
                end
                if condsEnd == true then
                    table.insert(remaining, s)
                else
                    table.insert(cond, s)
                    table.insert(conds, U.Table.DeepCopyList(cond))
                    cond = {}
                    condStart = false
                end
            elseif s == ";" then
                if cmdEnd == false then -- 如果当前处在命令阶段，不能加入;分号
                    return R:Err(s .. " ;错误1。")
                end
                if condStart == true then -- 如果当前正处在条件激活阶段，不能加入;分号
                    return R:Err(s .. " ;错误2。")
                end
                condsEnd = true
                table.insert(remainings, U.Table.DeepCopyList(remaining))
                remaining = {}
                remainingStart = false
            else
                if cmdEnd == false then       -- 如果命令cmd没有结束，追加到命令中
                    table.insert(cmd, s)
                elseif condsEnd == false then -- 如果条件组没有结束
                    if condStart == true then -- 如果当前条件处在激活状态，追加到当前条件
                        table.insert(cond, s)
                    else                      -- 如果当前条件组没有激活，此时表示条件组已经结束了，则结束条件组，追加到剩余字符串中
                        condsEnd = true
                        table.insert(remaining, s)
                        remainingStart = true
                    end
                else -- 命令和条件组都结束了，追加到剩余字符串中
                    table.insert(remaining, s)
                    remainingStart = true
                end
            end
        end
    end
    ---@type MacroParseResult
    local result = {
        cmd = cmd,
        conds = conds,
        remaining = remaining
    }
    return R:Ok(result)
end

--- 将宏语句中的条件分解成宏target、宏mod、宏booleanCond
---@param condString string
---@return Result MacroCond
function Macro:AstCondition(condString)
    local macroCond = { booleanConds = {}, targetConds = {} } ---@type MacroCond
    if condString == nil or condString == "" then
        return R:Ok(macroCond)
    end
    local conds = U.String.Split(condString, ",")
    for _, cond in ipairs(conds) do
        if string.sub(cond, 1, 7) == "target=" then
            local c = string.sub(cond, 8)
            c = U.String.Trim(c)
            local targetCond = { type = c } ---@type TargetCond
            table.insert(macroCond.targetConds, targetCond)
        elseif string.sub(cond, 1, 1) == "@" then
            local c = string.sub(cond, 2)
            c = U.String.Trim(c)
            local targetCond = { type = c } ---@type TargetCond
            table.insert(macroCond.targetConds, targetCond)
        else
            table.insert(macroCond.booleanConds, Macro:AstStringToBooleanCond(cond))
        end
    end
    return R:Ok(macroCond)
end

-- 将宏条件字符串转为BooleanCond格式
---@param str string
---@return BooleanCond
function Macro:AstStringToBooleanCond(str)
    str = U.String.Trim(str)
    local boolCond = { type = "unknow", isTarget = false, params = nil } ---@type BooleanCond
    -- 目标是否存在：exists、noexists
    if str == "exists" then
        boolCond.type = "exists"
        boolCond.isTarget = true
        boolCond.params = true
        return boolCond
    end
    if str == "noexists" then
        boolCond.type = "exists"
        boolCond.isTarget = true
        boolCond.params = false
        return boolCond
    end
    -- 目标是否友善：help、harm
    if str == "help" then
        boolCond.type = "help"
        boolCond.isTarget = true
        boolCond.params = true
        return boolCond
    end
    if str == "harm" then
        boolCond.type = "help"
        boolCond.isTarget = true
        boolCond.params = false
        return boolCond
    end
    -- 目标是否死亡：dead、nodead
    if str == "dead" then
        boolCond.type = "dead"
        boolCond.isTarget = true
        boolCond.params = true
        return boolCond
    end
    if str == "nodead" then
        boolCond.type = "dead"
        boolCond.isTarget = true
        boolCond.params = false
        return boolCond
    end
    -- 目标是否在队伍中
    if str == "party" then
        boolCond.type = "party"
        boolCond.isTarget = true
        boolCond.params = true
        return boolCond
    end
    -- 目标是否在团队中
    if str == "raid" then
        boolCond.type = "raid"
        boolCond.isTarget = true
        boolCond.params = true
        return boolCond
    end
    -- 目标是否在载具中
    if str == "unithasvehicleui" then
        boolCond.type = "unithasvehicleui"
        boolCond.isTarget = true
        boolCond.params = true
        return boolCond
    end
    -- 玩家是否处在御龙术区域
    if str == "advflyable" then
        boolCond.type = "advflyable"
        boolCond.params = true
        return boolCond
    end
    -- 玩家是否可以退出载具
    if str == "canexitvehicle" then
        boolCond.type = "canexitvehicle"
        boolCond.params = true
        return boolCond
    end
    -- 玩家是否在引导法术，是否在引导法术：法术名称
    if str == "channeling" then
        boolCond.type = "channeling"
        boolCond.params = true
        return boolCond
    end
    if string.sub(str, 1, 11) == "channeling:" then
        str = string.sub(str, 12)
        str = U.String.Trim(str)
        boolCond.type = "channeling"
        boolCond.params = str
        return boolCond
    end
    -- 玩家是否在战斗中：combat、nocombat
    if str == "combat" then
        boolCond.type = "combat"
        boolCond.params = true
        return boolCond
    end
    if str == "nocombat" then
        boolCond.type = "combat"
        boolCond.params = false
        return boolCond
    end
    -- 玩家是否装备了某个槽位装备
    if string.sub(str, 1, 9) == "equipped:" then
        str = string.sub(str, 10)
        str = U.String.Trim(str)
        boolCond.type = "equipped"
        boolCond.params = str
        return boolCond
    end
    -- 玩家是否装备了某个装备（不要求指定槽位）
    if string.sub(str, 1, 5) == "worn:" then
        str = string.sub(str, 6)
        str = U.String.Trim(str)
        boolCond.type = "worn"
        boolCond.params = str
        return boolCond
    end
    -- 玩家是否可以飞行
    if str == "flyable" then
        boolCond.type = "flyable"
        boolCond.params = true
        return boolCond
    end
    if str == "noflyable" then
        boolCond.type = "flyable"
        boolCond.params = false
        return boolCond
    end
    -- 玩家是否在飞行
    if str == "flying" then
        boolCond.type = "flying"
        boolCond.params = true
        return boolCond
    end
    if str == "noflying" then
        boolCond.type = "flying"
        boolCond.params = false
        return boolCond
    end
    -- 玩家处在何种形态（德鲁伊）
    if string.sub(str, 1, 5) == "form:" then
        str = string.sub(str, 6)
        str = U.String.Trim(str)
        local forms = U.String.Split(str, "/")
        boolCond.type = "form"
        boolCond.params = forms
        return boolCond
    end
    -- 玩家处在何种姿态（盗贼、战士）
    if string.sub(str, 1, 7) == "stance:" then
        str = string.sub(str, 8)
        str = U.String.Trim(str)
        local stances = U.String.Split(str, "/")
        boolCond.type = "stance"
        boolCond.params = stances
        return boolCond
    end
    -- 玩家是否处在队伍中：group、group:party、group:raid
    if string == "group" then
        boolCond.type = "group"
        boolCond.params = true
        return boolCond
    end
    if string == "group:party" then
        boolCond.type = "group"
        boolCond.params = "party"
        return boolCond
    end
    if string == "group:raid" then
        boolCond.type = "group"
        boolCond.params = "raid"
        return boolCond
    end
    -- 玩家是否在屋内：indoors、outdoors
    if str == "indoors" then
        boolCond.type = "indoors"
        boolCond.params = true
        return boolCond
    end
    if str == "outdoors" then
        boolCond.type = "indoors"
        boolCond.params = false
        return boolCond
    end
    -- 玩家是否学习了某个技能
    if string.sub(str, 1, 6) == "known:" then
        str = string.sub(str, 7)
        str = U.String.Trim(str)
        boolCond.type = "known"
        boolCond.params = str
        return boolCond
    end
    -- 玩家是否在坐骑上
    if str == "mounted" then
        boolCond.type = "mounted"
        boolCond.params = true
        return boolCond
    end
    if str == "nomounted" then
        boolCond.type = "mounted"
        boolCond.params = false
        return boolCond
    end
    -- 玩家是否召唤了名称为pet的宠物（猎人、术士）
    -- 玩家是否召唤了类型为petFamily的宠物？
    if string.sub(str, 1, 4) == "pet:" then
        if string.sub(str, 1, 11) == "pet:family=" then
            str = string.sub(str, 12)
            str = U.String.Trim(str)
            boolCond.type = "petFamily"
            boolCond.params = str
        else
            str = string.sub(str, 5)
            str = U.String.Trim(str)
            boolCond.type = "pet"
            boolCond.params = str
        end
        return boolCond
    end
    -- 玩家是否在宠物战斗中
    if str == "petbattle" then
        boolCond.type = "petbattle"
        boolCond.params = true
        return boolCond
    end
    -- 玩家是否存在休息区域
    if str == "resting" then
        boolCond.type = "resting"
        boolCond.params = true
        return boolCond
    end
    -- 玩家处在何种专精
    if string.sub(str, 1, 5) == "spec:" then
        str = string.sub(str, 6)
        str = U.String.Trim(str)
        local specs = U.String.Split(str, "/")
        boolCond.type = "spec"
        boolCond.params = specs
        return boolCond
    end
    -- 玩家是否处在潜行状态
    if str == "stealth" then
        boolCond.type = "stealth"
        boolCond.params = true
        return boolCond
    end
    -- 玩家是否处在游泳状态
    if str == "swimming" then
        boolCond.type = "swimming"
        boolCond.params = true
        return boolCond
    end
    -- 当mod处在何种情况下激活
    if str == "nomod" or str == "nomodifier" then
        boolCond.type = "mod"
        boolCond.params = "nomod"
        return boolCond
    end
    if str == "mod" or str == "modifier" then
        boolCond.type = "mod"
        boolCond.params = "mod"
        return boolCond
    end
    if string.sub(str, 1, 9) == "modifier:" then
        str = string.sub(str, 10)
        boolCond.type = "mod"
        str = U.String.Trim(str)
        local mods = U.String.Split(str, "/")
        boolCond.params = mods
        return boolCond
    end
    if string.sub(str, 1, 4) == "mod:" then
        str = string.sub(str, 5)
        boolCond.type = "mod"
        str = U.String.Trim(str)
        local mods = U.String.Split(str, "/")
        boolCond.params = mods
        return boolCond
    end
    if string.sub(str, 1, 7) == "button:" then
        str = string.sub(str, 8)
        boolCond.type = "btn"
        str = U.String.Trim(str)
        local btns = U.String.Split(str, "/")
        boolCond.params = btns
        return boolCond
    end
    if string.sub(str, 1, 4) == "btn:" then
        str = string.sub(str, 5)
        boolCond.type = "btn"
        str = U.String.Trim(str)
        local btns = U.String.Split(str, "/")
        boolCond.params = btns
        return boolCond
    end
    boolCond.type = str
    return boolCond
end

-- 处理宏命名
---@param str string -- 宏命令
---@return Result -- 返回处理后的宏命名
function Macro:AstCmd(str)
    if string.sub(str, 1, 1) == "/" then
        str = string.sub(str, 2)
    end
    -- 将cast替换成use
    if str == "cast" then
        str = "use"
    end
    return R:Ok(str)
end

-- 处理宏参数
---@param cmd string 宏命令
---@param str string 宏参数
---@return Result
function Macro:AstParam(cmd, str)
    str = U.String.Trim(str)
    local param = {} ---@type MacroParam
    if cmd == "use" then
        -- 如果是/use item:开头，表示使用物品
        if string.sub(str, 1, 5) == "item:" then
            local item = Item:CreateItemAttr(string.sub(str, 6), const.ITEM_TYPE.ITEM)
            Item:CompleteItemAttr(item)
            param.items = {}
            table.insert(param.items, item)
        else
            -- 如果是/use xxx字符串，表示使用技能，这里扩展可以使用物品、坐骑
            if tonumber(str) == nil then
                local item = Item:CreateItemAttr(str)
                Item:CompleteItemAttr(item)
                param.items = {}
                table.insert(param.items, item)
            else
                local slot = tonumber(str)
                -- 如果是/use 12 这种使用装备插嘈
                if slot > 19 then
                    return R:Err(L["Macro Error: Invalid equipment slot: %s"]:format(slot))
                end
                param.slot = slot
            end
        end
    else
        param.script = str
    end
    return R:Ok(param)
end

-- 将BooleanCond格式转为宏条件字符串
---@param boolCond BooleanCond 宏BooleanCond ast
---@param verify boolean 是否验证条件是否成立
---@param target MacroTargetCondType | nil 宏目标
---@return string | nil, boolean -- 宏条件字符串，是否通过校验
function Macro:CgBooleanCond(boolCond, verify, target)
    target = target or "target"
    -- 目标是否存在
    if boolCond.type == "exists" then
        if boolCond.params == true then
            if verify then
                if not UnitExists(target) then
                    return "exists", false
                end
            end
            return "exists", true
        else
            if verify then
                if UnitExists(target) then
                    return "noexists", false
                end
            end
            return "noexists", true
        end
    end
    -- 目标是否友善
    if boolCond.type == "help" then
        if boolCond.params == true then
            if verify then
                if not UnitCanAssist("player", target) then
                    return "help", false
                end
            end
            return "help", true
        else
            if verify then
                if not UnitCanAttack("player", target) then
                    return "harm", false
                end
            end
            return "harm", true
        end
    end
    -- 目标是否死亡
    if boolCond.type == "dead" then
        if boolCond.params == true then
            if verify then
                if not UnitIsDeadOrGhost(target) then
                    return "dead", false
                end
            end
            return "dead", true
        else
            if verify then
                if UnitIsDeadOrGhost(target) then
                    return "nodead", false
                end
            end
            return "nodead", true
        end
    end
    -- 目标是否在队伍中
    if boolCond.type == "party" then
        if verify then
            if not UnitInParty(target) then
                return "party", false
            end
        end
        return "party", true
    end
    -- 目标是否在团队中
    if boolCond.type == "raid" then
        if verify then
            if not UnitInRaid(target) then
                return "raid", false
            end
        end
        return "raid", true
    end
    -- 目标是否在载具中
    if boolCond.type == "unithasvehicleui" then
        if verify then
            if not UnitInVehicle(target) then
                return "unithasvehicleui", false
            end
        end
        return "unithasvehicleui", true
    end
    -- 玩家是否处在御龙术区域
    if boolCond.type == "advflyable" then
        if verify then
            if not IsAdvancedFlyableArea() then
                return "advflyable", false
            end
        end
        return "advflyable", true
    end
    -- 玩家是否可以退出载具
    if boolCond.type == "canexitvehicle" then
        if verify then
            if not CanExitVehicle() then
                return "canexitvehicle", false
            end
        end
        return "canexitvehicle", true
    end
    -- 玩家是否在引导法术，是否在引导法术：法术名称
    if boolCond.type == "channeling" then
        if verify then
            local name, _, _, _, _, _, _, _, _, _ = UnitChannelInfo("player")
            if name then
                if boolCond.params == true then
                    return "channeling", true
                else
                    if name == boolCond.params then
                        return "channeling:" .. boolCond.params, true
                    else
                        return "channeling:" .. boolCond.params, false
                    end
                end
            else
                if boolCond.params == true then
                    return "channeling", false
                else
                    return "channeling:" .. boolCond.params, false
                end
            end
        end
        if boolCond.params == true then
            return "channeling", true
        else
            return "channeling:" .. boolCond.params, true
        end
    end
    -- 玩家是否在战斗中
    if boolCond.type == "combat" then
        if boolCond.params == true then
            if verify then
                if not InCombatLockdown() then
                    return "combat", false
                end
            end
            return "combat", true
        else
            if verify then
                if InCombatLockdown() then
                    return "nocombat", false
                end
            end
            return "nocombat", true
        end
    end
    -- 玩家是否装备了某个槽位装备
    if boolCond.type == "equipped" then
        if verify then
            ---@diagnostic disable-next-line: param-type-mismatch
            if not Api.IsEquippedItemType(boolCond.params) then
                return "equipped:" .. boolCond.params, false
            end
        end
        return "equipped:" .. boolCond.params, true
    end
    -- 玩家是否装备了某个装备（不要求指定槽位）
    if boolCond.type == "worn" then
        if verify then
            ---@diagnostic disable-next-line: param-type-mismatch
            if not Api.IsEquippedItemType(boolCond.params) then
                return "worn:" .. boolCond.params, false
            end
        end
        return "worn:" .. boolCond.params, true
    end
    -- 玩家是否可以飞行
    if boolCond.type == "flyable" then
        if boolCond.params == true then
            if verify then
                if not IsFlyableArea() then
                    return "flyable", false
                end
            end
            return "flyable", true
        else
            if verify then
                if IsFlyableArea() then
                    return "noflyable", false
                end
            end
            return "noflyable", true
        end
    end
    -- 玩家是否在飞行
    if boolCond.type == "flying" then
        if boolCond.params == true then
            if verify then
                if not IsFlying() then
                    return "flying", false
                end
            end
            return "flying", true
        else
            if verify then
                if IsFlying() then
                    return "noflying", false
                end
            end
            return "noflying", true
        end
    end
    -- 玩家处在何种形态（德鲁伊）
    if boolCond.type == "form" then
        if type(boolCond.params) == "table" then
            ---@diagnostic disable-next-line: param-type-mismatch
            local condString = "form:" .. table.concat(boolCond.params, "/")
            if verify then
                ---@diagnostic disable-next-line: param-type-mismatch
                if U.Table.IsInArray(boolCond.params, tostring(GetShapeshiftForm())) then
                    return condString, true
                else
                    return condString, false
                end
            else
                return condString, true
            end
        else
            return "form", true
        end
    end
    -- 玩家处在何种姿态（盗贼、战士）
    if boolCond.type == "stance" then
        if type(boolCond.params) == "table" then
            ---@diagnostic disable-next-line: param-type-mismatch
            local condString = "stance:" .. table.concat(boolCond.params, "/")
            if verify then
                ---@diagnostic disable-next-line: param-type-mismatch
                if U.Table.IsInArray(boolCond.params, tostring(GetShapeshiftForm())) then
                    return condString, true
                else
                    return condString, false
                end
            else
                return condString, true
            end
        else
            return "stance", true
        end
    end
    -- 玩家是否处在队伍中：group、group:party、group:raid
    if boolCond.type == "group" then
        if boolCond.params == true then
            if verify then
                if IsInGroup() or IsInRaid() then
                    return "group", true
                else
                    return "group", false
                end
            end
            return "group", true
        else
            if verify then
                if boolCond.params == "party" and IsInGroup() then
                    return "group:" .. boolCond.params, true
                end
                if boolCond.params == "raid" and IsInRaid() then
                    return "group:" .. boolCond.params, true
                end
                return "group:" .. boolCond.params, false
            end
            return "group:" .. boolCond.params, true
        end
    end
    -- 玩家是否在屋内：indoors、outdoors
    if boolCond.type == "indoors" then
        if boolCond.params == true then
            if verify then
                if not IsIndoors() then
                    return "indoors", false
                end
            end
            return "indoors", true
        else
            if verify then
                if not IsOutdoors() then
                    return "outdoors", false
                end
            end
            return "outdoors", true
        end
    end
    -- 玩家是否学习了某个技能
    if boolCond.type == "known" then
        if verify then
            ---@diagnostic disable-next-line: param-type-mismatch
            local spellInfo = Api.GetSpellInfo(boolCond.params or 0)
            if spellInfo then
                if IsPlayerSpell(spellInfo.spellID) then
                    return "known:" .. boolCond.params, true
                end
            end
            return "known:" .. boolCond.params, false
        else
            return "known:" .. boolCond.params, true
        end
    end
    -- 玩家是否在坐骑上
    if boolCond.type == "mounted" then
        if boolCond.params == true then
            if verify then
                if not IsMounted() then
                    return "mounted", false
                end
            end
            return "mounted", true
        else
            if verify then
                if not IsMounted() then
                    return "nomounted", false
                end
            end
            return "nomounted", true
        end
    end
    -- 玩家是否召唤了名称为pet的宠物（猎人、术士）
    -- 玩家是否召唤了类型为petFamily的宠物？
    if boolCond.type == "pet" then
        if verify then
            if UnitName("pet") ~= boolCond.params then
                return "pet:" .. boolCond.params, false
            end
        end
        return "pet:" .. boolCond.params, true
    end
    if boolCond.type == "petFamily" then
        if verify then
            if UnitCreatureFamily("pet") ~= boolCond.params then
                return "pet:family=" .. boolCond.params, false
            end
        end
        return "pet:family=" .. boolCond.params, true
    end
    -- 玩家是否在宠物战斗中
    if boolCond.type == "petbattle" then
        if verify then
            if not C_PetBattles.IsInBattle() then
                return "petbattle", false
            end
        end
        return "petbattle", true
    end
    -- 玩家是否存在休息区域
    if boolCond.type == "resting" then
        if verify then
            if not IsResting() then
                return "resting", false
            end
        end
        return "resting", true
    end
    -- 玩家处在何种专精
    if boolCond.type == "spec" then
        if type(boolCond.params) == "table" then
            ---@diagnostic disable-next-line: param-type-mismatch
            local condString = "spec:" .. table.concat(boolCond.params, "/")
            if verify then
                ---@diagnostic disable-next-line: param-type-mismatch
                if U.Table.IsInArray(boolCond.params, tostring(GetSpecialization())) then
                    return condString, true
                else
                    return condString, false
                end
            else
                return condString, false
            end
        else
            return "spec", true
        end
    end
    -- 玩家是否处在潜行状态
    if boolCond.type == "stealth" then
        if verify then
            if not IsStealthed() then
                return "stealth", false
            end
        end
        return "stealth", true
    end
    -- 玩家是否处在游泳状态
    if boolCond.type == "swimming" then
        if verify then
            if not IsSubmerged("player") then
                return "swimming", false
            end
        end
        return "swimming", true
    end
    -- 当mod处在何种情况下激活
    if boolCond.type == "mod" then
        if boolCond.params == "mod" then
            if verify then
                if not IsModifierKeyDown() then
                    return "mod", false
                end
            end
            return "mod", true
        elseif boolCond.params == "nomod" then
            if verify then
                if IsModifierKeyDown() then
                    return "nomod", false
                end
            end
            return "nomod", true
        else
            if type(boolCond.params) == "table" then
                ---@diagnostic disable-next-line: param-type-mismatch
                local condString = "mod:" .. table.concat(boolCond.params, "/")
                ---@diagnostic disable-next-line: param-type-mismatch
                for _, m in ipairs(boolCond.params) do
                    if m == "alt" and IsAltKeyDown() then
                        return condString, true
                    end
                    if m == "shift" and IsShiftKeyDown() then
                        return condString, true
                    end
                    if m == "ctrl" and IsControlKeyDown() then
                        return condString, true
                    end
                    if m == "lalt" and IsLeftAltKeyDown() then
                        return condString, true
                    end
                    if m == "ralt" and IsRightAltKeyDown() then
                        return condString, true
                    end
                    if m == "lshift" and IsLeftShiftKeyDown() then
                        return condString, true
                    end
                    if m == "rshift" and IsRightShiftKeyDown() then
                        return condString, true
                    end
                    if m == "lctrl" and IsLeftControlKeyDown() then
                        return condString, true
                    end
                    if m == "rctrl" and IsRightControlKeyDown() then
                        return condString, true
                    end
                end
                return condString, false
            else
                return "mod:", true
            end
        end
    end
    -- 鼠标按键点击
    if boolCond.type == "btn" then
        if type(boolCond.params) == "table" then
            ---@diagnostic disable-next-line: param-type-mismatch
            local condString = "btn:" .. table.concat(boolCond.params, "/")
            if verify then
                ---@diagnostic disable-next-line: param-type-mismatch
                if (U.Table.IsInArray(boolCond.params, "1")) then
                    return condString, true
                else
                    return condString, false
                end
            else
                return condString, false
            end
        else
            return "btn", true
        end
    end
    return boolCond.type, true
end

-- 将条件AST转为宏字符串
---@param macroCond MacroCond  宏条件AST
---@param verify boolean 验证条件是否成立
---@return string | nil, boolean  -- 条件字符串, 是否通过校验
function Macro:CgCond(macroCond, verify)
    local condStrings = {} ---@type string[]
    local target = nil ---@type MacroTargetCondType
    local verifyResult = true
    if macroCond.targetConds and #macroCond.targetConds > 0 then
        target = macroCond.targetConds[1].type
        table.insert(condStrings, "@" .. target)
    end
    if macroCond.booleanConds then
        for _, booleanCond in ipairs(macroCond.booleanConds) do
            local condString, verifyR = Macro:CgBooleanCond(booleanCond, verify, target)
            if verifyR == false then
                verifyResult = false
            end
            table.insert(condStrings, condString)
        end
    end
    if #condStrings then
        return table.concat(condStrings, ","), verifyResult
    else
        return nil, verifyResult
    end
end

-- 将参数AST转为宏字符串
---@param command MacroCommand
---@return string | nil
function Macro:CgParam(command)
    if command == nil then
        return ""
    end
    if command.cmd == nil or command.param == nil then
        return ""
    end
    local itemsString = nil ---@type string | nil
    if command.param.items then
        local itemNames = {} ---@type string[]
        for _, item in ipairs(command.param.items) do
            table.insert(itemNames, item.name)
        end
        itemsString = table.concat(itemNames, ",")
    end
    local slotString = nil ---@type string | nil
    if command.param.slot then
        slotString = tostring(command.param.slot)
    end
    if command.cmd == "use" then
        return slotString or itemsString
    else
        return command.param.script
    end
end

-- 宏ast转为宏字符串
---@param macroAst MacroAst
---@param verify boolean 是否验证条件是否成立
---@return string
function Macro:Cg(macroAst, verify)
    local macroStrings = {} ---@type string[]
    if macroAst.tooltip then
        table.insert(macroStrings, "#showtooltip " .. macroAst.tooltip.name)
    end
    if macroAst.commands ~= nil then
        for _, command in ipairs(macroAst.commands) do
            local macroCondString = nil ---@type nil | string
            if command.conds then
                for _, cond in ipairs(command.conds) do
                    local condString = select(1, Macro:CgCond(cond, verify))
                    if condString ~= nil then
                        if macroCondString == nil then
                            macroCondString = ""
                        end
                        macroCondString = macroCondString .. "[" .. condString .. "]"
                    end
                end
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
        end
    end
    return table.concat(macroStrings, "\n")
end

-- 获取宏AST需要监听的事件列表
---@param macroAst MacroAst
---@return table<EventString, {}>
function Macro:GetEventsFromAst(macroAst)
    local events = {} ---@type table<EventString, {}>
    if macroAst.tooltip then
        for event, eventParams in pairs(ListenEvent:GetEventFromItemAttr(macroAst.tooltip)) do
            events[event] = eventParams
        end
    end
    if macroAst.commands then
        for event, eventParams in pairs(ListenEvent:GetEventFromMacroCommand(macroAst.commands)) do
            events[event] = eventParams
        end
    end
    return events
end
