local addonName, _ = ... ---@type string, table

---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class HbFrame: AceModule
local HbFrame = addon:GetModule("HbFrame")

-- 主窗口右键事件
addon:RegisterMessage(const.EVENT.EXIT_EDIT_MODE, function()
    addon.G.IsEditMode = false
    HbFrame:CloseEditMode()
end)


-- 自定义光环改变事件
addon:RegisterMessage(const.EVENT.HB_UNIT_AURA, function(event, ...)
    local args = {...}
    local target = args[1]
    local spellId = args[2]
    HbFrame:UpdateAllEframes(const.EVENT.HB_UNIT_AURA, {target, spellId})
end)

-- 自定义GCD更新
addon:RegisterMessage(const.EVENT.HB_GCD_UPDATE, function()
    HbFrame:UpdateAllEframes(const.EVENT.HB_GCD_UPDATE, {})
end)

-- 依附框架改变
addon:RegisterMessage(const.EVENT.HB_FRAME_CHANGE, function(event, ...)
    local args = {...}
    local frameName = args[1]
    HbFrame:UpdateAllEframes(const.EVENT.HB_FRAME_CHANGE, {frameName, })
end)