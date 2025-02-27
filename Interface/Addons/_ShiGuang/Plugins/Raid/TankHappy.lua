--## Author: TuTu、huchang47 ## Version: 1.0.3
local _, classEn = UnitClass("player")
-- 非猎人盗贼萨满就不加载
if classEn ~= "HUNTER" and classEn ~= "ROGUE" and classEn ~= "SHAMAN" then return end

local spell = 34477 -- 误导
if classEn == "HUNTER" then
    spell = 34477 -- 误导
elseif classEn == "ROGUE" then
    spell = 57934 -- 嫁祸诀窍
elseif classEn == "SHAMAN" then
    spell = 974 -- 地盾
end

local aura_env = {
    config = {
        -- 插件名称
        name = "TankHappy",
        icon = "Interface\\Icons\\Ability_Hunter_WingClip",
        desc = "自动选择误导、嫁祸、地盾坦克或者宠物",
        -- 作者信息
        author = "TuTu，huchang47",
        -- 当前版本号
        version = "1.0.3"
    }
}
local matter = aura_env.config.matter  -- 预留配置字段（当前版本未使用）
local name = aura_env.config.name     -- 插件名称 ("TankHappy")
local btn = _G[name]    

-- buff/debuff检查函数
local function UnitAura(unit, auraName)
    return AuraUtil.FindAuraByName(auraName, unit) ~= nil
end

-- 从全局环境获取按钮引用（如果存在）

-- 加载队伍成员专精检测库
--aura_env.inspect = LibStub:GetLibrary("LibGroupInSpecT-1.1", true)
aura_env.last = nil  -- 用于存储上次的提示信息

-- 如果全局按钮不存在则创建新按钮
if not _G[name] then
    -- 创建安全动作按钮（战斗锁定安全）
    aura_env.btn = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate")
    aura_env.btn:SetSize(32, 32)  -- 设置按钮尺寸
    aura_env.btn:RegisterForClicks("AnyUp", "AnyDown")  -- 注册所有点击事件
    aura_env.btn:SetHighlightTexture('Interface\\Buttons\\ButtonHilight-Square')  -- 设置高亮纹理
    
    -- 设置按钮属性
    aura_env.btn:SetAttribute("type", "spell")        -- 按钮类型为施法
    aura_env.btn:SetAttribute("unit", "target")       -- 默认目标为当前目标
    aura_env.btn:SetAttribute("spell", spell)         -- 设置要施放的法术ID
    aura_env.btn:SetAttribute("checkselfcast", false) -- 禁用自我施法检查
    aura_env.btn:SetAttribute("checkfocuscast", false)-- 禁用焦点施法检查
else
    -- 如果按钮已存在则复用
    aura_env.btn = _G[name]
end

local isDebug = false  -- 调试模式开关，true时打印调试信息

-- 更新宏目标的函数
aura_env.UpdateMacro = function(unit)
    --print("UpdateMacro " .. unit)  -- 打印当前更新的目标单位
    local text  -- 存储提示文本3
    if UnitExists(unit) then  -- 如果目标单位存在
        -- 获取法术名称用于验证
        local spellName = C_Spell.GetSpellName(spell)
        if not spellName then
            print(aura_env.id, "错误", "未知法术 " .. spell)  -- 非法术ID时报错
        end
        -- 战斗状态检查（防止战斗中修改安全按钮属性）
        if InCombatLockdown() or UnitAffectingCombat("player") then
            aura_env.needUpdate = true  -- 标记需要后续更新
            return
        end
        if not InCombatLockdown() and not UnitAffectingCombat("player") then
            aura_env.btn:SetAttribute("unit", unit)  -- 设置按钮的目标单位属性
        end
        -- 生成提示文本：法术链接 + 目标单位
        text = C_Spell.GetSpellLink(spell) .. " 选中目标：-> " .. unit
        -- 萨满逻辑：优先给自己，已有则给坦克
        if classEn == "SHAMAN" and IsPlayerSpell(383010) then
            -- 检查自己是否已有大地之盾效果
            local hasShield = UnitAura("player", C_Spell.GetSpellName(spell))
            if not hasShield and not InCombatLockdown() and not UnitAffectingCombat("player") then
                -- 给自己施放（当没有盾时）
                aura_env.btn:SetAttribute("unit", "player")
                text = C_Spell.GetSpellLink(spell) .. " 正在施放给自己"
            elseif not InCombatLockdown() and not UnitAffectingCombat("player") then
                -- 已有效果时给坦克施放
                aura_env.btn:SetAttribute("unit", unit)
                text = C_Spell.GetSpellLink(spell) .. " 已存在于自己，切换给坦克"
            end
        end
    else
        -- 无有效目标时恢复默认设置
        if not InCombatLockdown() and not UnitAffectingCombat("player") then
            aura_env.btn:SetAttribute("unit", "target")  -- 重置为默认目标
            text = C_Spell.GetSpellLink(spell) .. " 无目标"  -- 生成无目标提示文本
        end
    end
    -- 调试模式下或文本变化时打印信息
    if isDebug or text ~= aura_env.last then
        print(text)  -- 输出当前设置状态
        aura_env.last = text  -- 缓存最后显示文本
    end
end

-- 检测坦克的函数
-- 需要检测的队伍成员和宠物单位列表（按优先级顺序）
local members = {"party1", "party2", "party3", "party4", "party1pet", "party2pet", "party3pet", "party4pet"}
-- 主检测函数：自动选择坦克目标
aura_env.UpdateTank = function()
    --print("开始 UpdateTank")
    -- 团队中不自动选择（需要手动处理）
    if InCombatLockdown() or IsInRaid() then
        return
    end
    -- 优先检测焦点目标（如果存在且是友方）
    if UnitExists("focus") and UnitIsFriend("player", "focus") and UnitCanAssist("player", "focus") then
        --print("开始检测 焦点")
        aura_env.UpdateMacro("focus")
        return
    end
    -- 遍历队伍成员和宠物列表
    for i = 1, #members do
        local isPet = i >= 5  -- 索引5之后的是宠物单位
        local unit = UnitName(members[i])
        if unit then
            --print("开始检测" .. unit .. (isPet and ", is pet" or ""))
            -- 如果是宠物单位直接使用
            if isPet then
                aura_env.UpdateMacro(unit)
                return
            end
            -- 获取单位详细信息
            if UnitGroupRolesAssigned(unit) == "TANK" and UnitIsConnected(unit) then
                aura_env.UpdateMacro(unit)
                return
            end
        end
    end
    -- 职业后备方案
    if classEn == "HUNTER" then
        aura_env.UpdateMacro("pet")  -- 猎人默认使用宠物
    elseif classEn == "ROGUE" then
        aura_env.UpdateMacro()  -- 潜行者无目标（嫁祸当前目标）
    elseif classEn == "SHAMAN" then
        aura_env.UpdateMacro("player") -- 萨满默认对自己地盾
    end
end

-- 坦克好开心初始化函数
aura_env.onInit = function()
    print("=== 坦克好开心 ===")
    -- 如果处于战斗锁定状态，延迟1秒后重试初始化
    if InCombatLockdown() then
        C_Timer.After(1, function()
            aura_env.onInit()  -- 递归调用自身实现延迟重试
        end)
    else
        -- 创建定时器，每秒执行一次UpdateTank检测
        C_Timer.NewTicker(1, function()
            aura_env.UpdateTank()  -- 执行坦克目标检测和宏更新
        end)
    end
end

-- 立即执行初始化
aura_env.onInit()