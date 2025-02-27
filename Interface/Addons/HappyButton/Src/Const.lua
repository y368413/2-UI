local addonName, _ = ... ---@type string, table
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, false)

---@class Client: AceModule
local Client = addon:GetModule("Client")

---@class CONST: AceModule
local const = addon:NewModule("CONST")

---@enum ElementType
const.ELEMENT_TYPE = {
    ITEM = 1,
    ITEM_GROUP = 2,
    SCRIPT = 3,
    BAR = 4,
    MACRO = 5,
}

-- 元素分类选项
---@class ElementTypeOptions
---@type table<number, string>
const.ElementTypeOptions = {
    [const.ELEMENT_TYPE.ITEM] = L["Item"],
    [const.ELEMENT_TYPE.ITEM_GROUP] = L["Script"],
    [const.ELEMENT_TYPE.SCRIPT] = L["ItemGroup"],
    [const.ELEMENT_TYPE.BAR] = L["Bar"],
}

---@enum BarDisplayMode
const.BAR_DISPLAY_MODE = {
    Hidden = 0, -- 隐藏
    Alone = 1,  -- 独立的
    Mount = 2,  -- 挂载
}


-- 物品条分类选项
---@class BarDisplayModeOptions
---@type table<number, string>
const.BarDisplayModeOptions = {
    [const.BAR_DISPLAY_MODE.Hidden] = L["Hidden"],
    [const.BAR_DISPLAY_MODE.Alone] = L["Display as alone items bar"],
    [const.BAR_DISPLAY_MODE.Mount] = L["Append to the main frame"],
}

-- 物品分类
---@enum ItemType
const.ITEM_TYPE = {
    ITEM = 1,
    EQUIPMENT = 2,
    TOY = 3,
    SPELL = 4,
    MOUNT = 5,
    PET = 6,
}

-- 物品类型选项
---@class ItemTypeptions
---@type table<number, string>
const.ItemTypeOptions = {
    [const.ITEM_TYPE.ITEM] = L["Item"],
    [const.ITEM_TYPE.EQUIPMENT] = L["Equipment"],
    [const.ITEM_TYPE.TOY] = L["Toy"],
    [const.ITEM_TYPE.SPELL] = L["Spell"],
    [const.ITEM_TYPE.MOUNT] = L["Mount"],
    [const.ITEM_TYPE.PET] = L["Pet"],
}
-- 非正式服不支持宠物管理
if Client:IsRetail() == false then
    const.ItemTypeOptions[const.ITEM_TYPE.PET] = nil
end

-- 坐骑类型:https://warcraft.wiki.gg/wiki/API_C_MountJournal.GetMountInfoExtraByID
---@num MountTypeId
const.MOUNT_TYPE_ID = {
    GROUND = 230,                 -- 大部分地面坐骑
    TURTLE = 231,                 -- [海龟]  [骑乘乌龟]
    SEAHORE = 232,                --  [瓦斯琪尔海马] 只能在瓦斯琪尔召唤
    QIRAJI = 241,                 -- 安其拉坐骑，只能在安其拉神庙使用
    SWIFT_SPECTRAL_GRYPHON = 242, -- 迅捷光谱狮鹫（隐藏在坐骑日志中，在某些区域死亡时使用）
    RED_FLYING_CLOUD = 247,       -- [赤飞云盘]
    FLYING = 248,                 -- 大部分飞行坐骑
    IN_WATER = 254,               -- 只能在水里召唤 [深渊居民]、[ Brinedeep 底部进料器]、 [波塞多斯的缰绳]
    ON_WATER = 269,               -- 水上行走坐骑 水黾缰绳
    CHAUFFEURED = 284,            -- 传家宝司机
    KUAFON = 398,                 -- https://warcraft.wiki.gg/wiki/Kua%27fon%27s_Harness
    DRAGON = 402,                 -- 御龙术 [复苏始祖幼龙]
    HAI_LU_KONG = 407,            -- 海陆空，水底100%游泳
    SUPPORT_DRAGON = 424,         -- 支持御龙术的飞行坐骑
}

-- 物品组分类
---@enum ItemsGroupMode
const.ITEMS_GROUP_MODE = {
    RANDOM = 1,
    SEQ = 2,
    MULTIPLE = 3,
    SINGLE = 4
}

-- 物品组类型选项
---@class ItemsGroupModeOptions
---@type table<number, string>
const.ItemsGroupModeOptions = {
    [const.ITEMS_GROUP_MODE.RANDOM] = L["Display one item, randomly selected."],
    [const.ITEMS_GROUP_MODE.SEQ] = L["Display one item, selected sequentially."],
}

-- 宏目标条件选项
---@class MacroTargetOptions
---@type table<string, string>
const.MacroTargetOptions = {
    ["target"] = "target",
    ["player"] = "player",
    ["focus"] = "focus",
    ["cursor"] = "cursor",
    ["mouseover"] = "mouseover",
}

--[[
-- 排列方向
]]
---@enum Arrange
const.ARRANGE = {
    HORIZONTAL = 1, -- 水平
    VERTICAL = 2,   -- 垂直
}

-- 排列方向类型选项
---@class ArrangeOptions
---@type table<number, string>
const.ArrangeOptions = {
    [const.ARRANGE.HORIZONTAL] = L["Horizontal"],
    [const.ARRANGE.VERTICAL] = L["Vertical"],
}

--[[
生长方向
]]
---@enum Growth
const.GROWTH = {
    TOPLEFT = "TOPLEFT",
    TOPRIGHT = "TOPRIGHT",
    BOTTOMLEFT = "BOTTOMLEFT",
    BOTTOMRIGHT = "BOTTOMRIGHT",
    LEFTTOP = "LEFTTOP",
    LEFTBOTTOM = "LEFTBOTTOM",
    RIGHTTOP = "RIGHTTOP",
    RIGHTBOTTOM = "RIGHTBOTTOM"
}

-- 生长方向类型选项
---@class ArrangeOptions
---@type table<Growth, string>
const.GrowthOptions = {
    [const.GROWTH.TOPLEFT] = L["TOPLEFT"],
    [const.GROWTH.TOPRIGHT] = L["TOPRIGHT"],
    [const.GROWTH.BOTTOMLEFT] = L["BOTTOMLEFT"],
    [const.GROWTH.BOTTOMRIGHT] = L["BOTTOMRIGHT"],
    [const.GROWTH.LEFTTOP] = L["LEFTTOP"],
    [const.GROWTH.LEFTBOTTOM] = L["LEFTBOTTOM"],
    [const.GROWTH.RIGHTTOP] = L["RIGHTTOP"],
    [const.GROWTH.RIGHTBOTTOM] = L["RIGHTBOTTOM"],
}

-- 依附锚点位置
---@enum AnchorPos
const.ANCHOR_POS = {
    TOPLEFT = "TOPLEFT",
    TOPRIGHT = "TOPRIGHT",
    BOTTOMLEFT = "BOTTOMLEFT",
    BOTTOMRIGHT = "BOTTOMRIGHT",
    TOP = "TOP",
    BOTTOM = "BOTTOM",
    LEFT = "LEFT",
    RIGHT = "RIGHT",
    CENTER = "CENTER"
}

-- 依附锚点位置选项
---@class AnchorPosOptions
---@type table<number, string>
const.AnchorPosOptions = {
    [const.ANCHOR_POS.TOPLEFT] = L["TOPLEFT"],
    [const.ANCHOR_POS.TOPRIGHT] = L["TOPRIGHT"],
    [const.ANCHOR_POS.BOTTOMLEFT] = L["BOTTOMLEFT"],
    [const.ANCHOR_POS.BOTTOMRIGHT] = L["BOTTOMRIGHT"],
    [const.ANCHOR_POS.TOP] = L["TOP"],
    [const.ANCHOR_POS.BOTTOM] = L["BOTTOM"],
    [const.ANCHOR_POS.LEFT] = L["LEFT"],
    [const.ANCHOR_POS.RIGHT] = L["RIGHT"],
    [const.ANCHOR_POS.CENTER] = L["CENTER"],
}



---@class LoadCondCombatOptions
const.LoadCondCombatOptions = {
    [false] = L["Load when out of combat"],
    [true] = L["Load when in combat"],
}

---@class LoadCondAttachFrameOptions
const.LoadCondAttachFrameOptions = {
    [false] = L["Load when attach frame hide"],
    [true] = L["Load when attach frame show"],
}

---@enum AttachFrame
const.ATTACH_FRAME = {
    UIParent = "UIParent"
}

-- 常见依附框体
---@class AttachFrameOptions
---@type table<number, string>
const.AttachFrameOptions = {
    ["UIParent"] = L["UIParent"],
    ["CharacterFrame"] = L["CharacterFrame"],
    ["GameMenuFrame"] = L["GameMenuFrame"],
    ["Minimap"] = L["Minimap"],
    ["ProfessionsBookFrame"] = L["ProfessionsBookFrame"],
    ["WorldMapFrame"] = L["WorldMapFrame"],
    ["PVEFrame"] = L["PVEFrame"],
    ["CollectionsJournal"] = L["CollectionsJournal"]
}


-- 文本表达式选项
---@class TextOptions
---@type table<TextExpr, string>
const.TextOptions = {
    ["%n"] = L["Item Name"],
    ["%s"] = L["Item Count"],
}

-- 物品颜色代码
-- https://wowpedia.fandom.com/wiki/Enum.ItemQuality
if Client.Version < 90001 then
    ---@type table<Enum.ItemQuality, RGBAColor>
    const.ItemQualityColor = {
        [Enum.ItemQuality.Poor] = { 0.617, 0.617, 0.617, 1 },     -- 灰色
        [1] = { 1, 1, 1, 1 },                                     -- 普通
        [2] = { 0.118, 1, 0, 1 },                                 -- 优秀
        [3] = { 0.00, 0.439, 0.867, 1 },                          -- 精良
        [Enum.ItemQuality.Epic] = { 0.639, 0.208, 0.933, 1 },     -- 史诗
        [Enum.ItemQuality.Legendary] = { 1, 0.502, 0, 1 },        -- 传说
        [Enum.ItemQuality.Artifact] = { 0.902, 0.800, 0.502, 1 }, -- 神器
        [Enum.ItemQuality.Heirloom] = { 0, 0.800, 1, 1 },         -- 传家宝
        [Enum.ItemQuality.WoWToken] = { 0, 0.800, 1, 1 },         -- 代币
    }
else
    ---@type table<Enum.ItemQuality, RGBAColor>
    const.ItemQualityColor = {
        [Enum.ItemQuality.Poor] = { 0.617, 0.617, 0.617, 1 },     -- 灰色
        [Enum.ItemQuality.Common] = { 1, 1, 1, 1 },               -- 普通
        [Enum.ItemQuality.Uncommon] = { 0.118, 1, 0, 1 },         -- 优秀
        [Enum.ItemQuality.Rare] = { 0.00, 0.439, 0.867, 1 },      -- 精良
        [Enum.ItemQuality.Epic] = { 0.639, 0.208, 0.933, 1 },     -- 史诗
        [Enum.ItemQuality.Legendary] = { 1, 0.502, 0, 1 },        -- 传说
        [Enum.ItemQuality.Artifact] = { 0.902, 0.800, 0.502, 1 }, -- 神器
        [Enum.ItemQuality.Heirloom] = { 0, 0.800, 1, 1 },         -- 传家宝
        [Enum.ItemQuality.WoWToken] = { 0, 0.800, 1, 1 },         -- 代币
    }
end

-- 默认边框代码
---@type RGBAColor
const.DefaultItemColor = { 0.2, 0.2, 0.2, 1 }

-- 触发器类型选项
---@type table<TriggerType, string>
const.TriggerTypeOptions = {
    ["self"] = L["Self Trigger"],
    ["aura"] = L["Aura Trigger"],
    ["item"] = L["Item Trigger"]
}

-- 触发器目标选项
---@type table<TriggerTarget, string>
const.TriggerTargetOptions = {
    ["player"] = L["Player"],
    ["target"] = L["Target"]
}


-- 触发器光环类型
---@type table<AuraType, string>
const.AuraTypeOptions = {
    ["buff"] = L["Buff"],
    ["defbuff"] = L["Debuff"]
}

-- 运算符类型
---@type table<CondOperator, string>
const.OperateOptions = {
    ["="] = "=",
    ["!="] = "!=",
    [">"] = ">",
    [">="] = ">=",
    ["<"] = "<",
    ["<="] = "<="
}

-- 条件表达式
---@class CondExpressionOptions
---@type table<CondExpr, string>
const.CondExpressionOptions = {
    ["%cond.1"] = L["Cond1"],
    ["%cond.1 and %cond.2"] = L["Cond1 and Cond2"],
    ["%cond.1 or %cond.2"] = L["Cond1 or Cond2"],
    ["%cond.1 and %cond.2 and %cond.3"] = L["Cond1 and Cond2 and Cond3"],
    ["%cond.1 or %cond.2 or %cond.3"] = L["Cond1 or Cond2 or Cond3"],
    ["(%cond.1 and %cond.2) or %cond.3"] = L["(Cond1 and Cond2) or Cond3"],
    ["(%cond.1 or %cond.2) and %cond.3"] = L["(Cond1 or Cond2) and Cond3"],
}

-- 布尔类型选择器
const.BooleanOptions = {
    [true] = L["True"],
    [false] = L["False"]
}

---@class LoadCondCombatOptions
const.OpenEffectOptions = {
    [false] = L["Close"],
    [true] = L["Open"],
}

--[[
事件监听
]]

---@type table<EventString, EventString>
const.BUILDIN_EVENTS = {
    ["BAG_UPDATE"] = "BAG_UPDATE",                             -- 背包物品改变(物品、装备)
    ["PLAYER_EQUIPMENT_CHANGED"] = "PLAYER_EQUIPMENT_CHANGED", -- 装备改变（物品、装备）
    ["PLAYER_TARGET_CHANGED"] = "PLAYER_TARGET_CHANGED",       -- 目标改变（脚本、触发器）
    ["PLAYER_TALENT_UPDATE"] = "PLAYER_TALENT_UPDATE",         -- 天赋改变（技能）
    ["SPELLS_CHANGED"] = "SPELLS_CHANGED",                     -- 技能改变（技能）
    ["UNIT_AURA"] = "UNIT_AURA"                                -- 单位光环改变
}

--[[职业]]
---@enum Class
const.CLASS = {
    WARRIOR = 1,
    PALADIN = 2,
    HUNTER = 3,
    ROGUE = 4,
    PRIEST = 5,
    DEATHKNIGHT = 6,
    SHAMAN = 7,
    MAGE = 8,
    WARLOCK = 9,
    MONK = 10,
    DRUID = 11,
    DEMONHUNTER = 12,
    EVOKER = 13,
}

--[[职业选项]]
const.ClassOptions = {
    [const.CLASS.WARRIOR] = L["Warrior"],
    [const.CLASS.PALADIN] = L["Paladin"],
    [const.CLASS.HUNTER] = L["Hunter"],
    [const.CLASS.ROGUE] = L["Rogue"],
    [const.CLASS.PRIEST] = L["Priest"],
    [const.CLASS.DEATHKNIGHT] = L["Death Knight"],
    [const.CLASS.SHAMAN] = L["Shaman"],
    [const.CLASS.MAGE] = L["Mage"],
    [const.CLASS.WARLOCK] = L["Warlock"],
    [const.CLASS.MONK] = L["Monk"],
    [const.CLASS.DRUID] = L["Druid"],
    [const.CLASS.DEMONHUNTER] = L["Demon Hunter"],
    [const.CLASS.EVOKER] = L["Evoker"],
}

-- 非正式服没有唤魔师、恶魔猎手、武僧
if Client:IsRetail() == false then
    const.ClassOptions[const.CLASS.MONK] = nil
    const.ClassOptions[const.CLASS.DEMONHUNTER] = nil
    const.ClassOptions[const.CLASS.EVOKER] = nil
end

--[[
-- 自定义事件常量
]]
const.EVENT = {
    EXIT_EDIT_MODE = "EXIT_EDIT_MODE", -- 退出编辑模式
    HB_UNIT_AURA = "HB_UNIT_AURA",  -- 自定义光环通知
    HB_GCD_UPDATE = "HB_GCD_UPDATE",  -- GCD更新
    HB_UPDATE_CONFIG = "HB_UPDATE_CONFIG",  -- 自定义更新配置事件
    HB_FRAME_CHANGE = "HB_FRAME_CHANGE"  -- 框体改变状态
}
