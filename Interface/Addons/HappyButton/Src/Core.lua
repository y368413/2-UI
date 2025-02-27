local addonName, _ = ... ---@type string, table
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class Utils: AceModule
local U = addon:GetModule('Utils')

---@class HbFrame: AceModule
local HbFrame = addon:GetModule("HbFrame")

---@class PlayerCache: AceModule
local PlayerCache = addon:GetModule("PlayerCache")

---@class AttachFrameCache: AceModule
local AttachFrameCache = addon:GetModule("AttachFrameCache")

---@class AuraCache: AceModule
local AuraCache = addon:GetModule("AuraCache")

---@class ItemCache: AceModule
local ItemCache = addon:GetModule("ItemCache")

---@class BarCore: AceModule
local BarCore = addon:NewModule("BarCore")

BarCore.Frame = CreateFrame("Frame")

-- 初始化配置
function BarCore:Initial()
    PlayerCache:Initial()
    AttachFrameCache:Initial()
    AuraCache:Initial()
    ItemCache:Initial()
    HbFrame:Initial()
end

---@type table<EventString, boolean> key表示事件名称，value表示是否循环监听
local registerEvents = {
    ["PLAYER_ENTERING_WORLD"] = true,           -- 读地图
    ["PLAYER_LOGIN"] = true,                    -- 登录
    ["UNIT_SPELLCAST_SUCCEEDED"] = true,        -- 施法成功
    ["SPELL_UPDATE_CHARGES"] = true,            -- 技能充能改变
    ["PLAYER_REGEN_ENABLED"] = true,            -- 退出战斗事件
    ["PLAYER_EQUIPMENT_CHANGED"] = true,        -- 装备改变（物品、装备）
    ["SPELLS_CHANGED"] = true,                  -- 技能改变（技能）
    ["PLAYER_TALENT_UPDATE"] = true,            -- 天赋改变（技能）
    ["PLAYER_TARGET_CHANGED"] = true,           -- 目标改变（脚本、触发器）
    ["BAG_UPDATE"] = true,                      -- 背包物品改变(物品、装备)
    ["MODIFIER_STATE_CHANGED"] = true,          -- 修饰按键按下
    ["UPDATE_MOUSEOVER_UNIT"] = true,           -- 鼠标指向改变
    ["ZONE_CHANGED"] = true,                    -- 区域改变
    ["MOUNT_JOURNAL_USABILITY_CHANGED"] = true, -- 坐骑可用改变
    ["NEW_MOUNT_ADDED"] = true,                 -- 学会新的坐骑
    ["PET_BAR_UPDATE_COOLDOWN"] = true,         -- 宠物相关
    ["NEW_PET_ADDED"] = true,                   -- 学会新的宠物
    ["NEW_TOY_ADDED"] = true,                   -- 学会新的玩具
    ["SPELL_UPDATE_COOLDOWN"] = false,          -- 触发冷却
    ["UNIT_AURA"] = false,                      -- 光环改变
    ["ADDON_LOADED"] = false,                   -- 加载插件
    ["CVAR_UPDATE"] = false,                    -- 改变cvar
    ["PLAYER_REGEN_DISABLED"] = false,          -- 进入战斗事件
}

-- 限流事件
local throttlingEvents = {
    ["BAG_UPDATE"] = {},
}

-- 延迟事件
local delayEvents = {
    ["UPDATE_MOUSEOVER_UNIT"] = true,
    ["UNIT_SPELLCAST_SUCCEEDED"] = true
}

-- 注册事件
function BarCore:Start()
    for event, _ in pairs(registerEvents) do
        BarCore.Frame:RegisterEvent(event)
    end
    BarCore.Frame:SetScript("OnEvent", function(_, event, ...)
        local args = { ... }
        if event == "PLAYER_LOGIN" then
            BarCore:Initial()
        end
        if event == "PLAYER_REGEN_DISABLED" then
            HbFrame:OnCombatEvent()
        end
        if event == "CVAR_UPDATE" then
            -- 如果用户修改了鼠标按下CVAR，需要通知按钮改变RegisterForClicks
            local cvar_name = args[1]
            if cvar_name == "ActionButtonUseKeyDown" then
                HbFrame:UpdateRegisterForClicks()
            end
        end
        if event == "UNIT_AURA" or event == "PLAYER_TARGET_CHANGED" then
            AuraCache:Update(event, args)
        end
        if event == "SPELL_UPDATE_COOLDOWN" then
            ItemCache:UpdateGcd()
        end
        -- 当玩家技能发生改变的时候，如果配置文件中有需要更新的ItemAttr，则更新ItemAttr（这是由于API无法获取非当前玩家拥有技能的信息）
        if event == "PLAYER_TALENT_UPDATE" or "SPELLS_CHANGED" then
            HbFrame:CompleteItemAttr()
        end
        if registerEvents[event] == true then
            if throttlingEvents[event] ~= nil then
                if throttlingEvents[event].waiting ~= true then
                    HbFrame:UpdateAllEframes(event, args)
                    throttlingEvents[event].waiting = true
                    C_Timer.After(0.2, function()
                        throttlingEvents[event].waiting = false
                    end)
                end
            elseif delayEvents[event] ~= nil then
                C_Timer.After(0.1, function()
                    -- 施法完成事件只监控玩家
                    if event == "UNIT_SPELLCAST_SUCCEEDED" then
                        if args[1] == "player" then
                            HbFrame:UpdateAllEframes(event, args)
                        end
                    else
                        HbFrame:UpdateAllEframes(event, args)
                    end
                end)
            else
                HbFrame:UpdateAllEframes(event, args)
            end
        end
    end)
end
