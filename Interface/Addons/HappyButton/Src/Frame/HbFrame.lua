local addonName, _ = ...

---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class E: AceModule
local E = addon:GetModule("Element")

---@class Utils: AceModule
local U = addon:GetModule('Utils')

---@class LoadCondition: AceModule
local LoadCondition = addon:GetModule("LoadCondition")

---@class ElementFrame: AceModule
local ElementFrame = addon:GetModule('ElementFrame')

---@class HbFrame: AceModule
---@field EFrames ElementFrame[]
local HbFrame = addon:NewModule("HbFrame")


-- 初始化UI模块
function HbFrame:Initial()
    local elementsConfig = addon.db.profile.elements ---@type ElementConfig[]
    local eFrames = {} ---@type table<string, ElementFrame>
    for _, eleConfig in ipairs(elementsConfig) do
        eFrames[eleConfig.id] = ElementFrame:New(eleConfig)
    end
    HbFrame.EFrames = eFrames
end

-- 增加
---@param eleConfig ElementConfig
function HbFrame:AddEframe(eleConfig)
    if self.EFrames[eleConfig.id] ~= nil then
        self.EFrames[eleConfig.id]:Update("PLAYER_ENTERING_WORLD", {})
        return
    end
    self.EFrames[eleConfig.id] = ElementFrame:New(eleConfig)
end

-- 移除
---@param eleConfig ElementConfig
function HbFrame:DeleteEframe(eleConfig)
    if self.EFrames[eleConfig.id] == nil then
        return
    end
    local eFrame = self.EFrames[eleConfig.id]
    eFrame:Delete()
    self.EFrames[eleConfig.id] = nil
end

-- 重载所有UI
function HbFrame:ReloadAllEframeUI()
    if not self.EFrames then
        return
    end
    for _, eFrame in pairs(self.EFrames) do
        eFrame:ReLoadUI()
    end
end

-- 重载UI
---@param eleConfig ElementConfig
function HbFrame:ReloadEframeUI(eleConfig)
    if self.EFrames[eleConfig.id] == nil then
        return
    end
    local eFrame = self.EFrames[eleConfig.id]
    eFrame:ReLoadUI()
end

-- 重载Window框体位置
---@param eleConfig ElementConfig
function HbFrame:UpdateEframeWindow(eleConfig)
    if self.EFrames[eleConfig.id] == nil then
        return
    end
    local eFrame = self.EFrames[eleConfig.id]
    eFrame:UpdateWindow()
end

-- 更新
---@param eleConfig ElementConfig
---@param event EventString | nil
function HbFrame:UpdateEframe(eleConfig, event)
    if self.EFrames[eleConfig.id] == nil then
        return
    end
    local eFrame = self.EFrames[eleConfig.id]
    eFrame:Update(event or "PLAYER_ENTERING_WORLD", {})
end

-- 全部更新
---@param event EventString -- 事件名称
---@param eventArgs any[] -- 事件参数
function HbFrame:UpdateAllEframes(event, eventArgs)
    if not self.EFrames then
        return
    end
    for _, eFrame in pairs(self.EFrames) do
        eFrame:Update(event, eventArgs)
    end
end

function HbFrame:CompleteItemAttr()
    if not self.EFrames then
        return
    end
    for _, eFrame in pairs(self.EFrames) do
        eFrame:CompleteItemAttr()
    end
end

-- 更新按键设置
function HbFrame:UpdateRegisterForClicks()
    if not self.EFrames then
        return
    end
    for _, eFrame in pairs(self.EFrames) do
        if eFrame and eFrame.Cbs then
            for _, cb in ipairs(eFrame.Cbs) do
                if cb.btns then
                    for _, btn in ipairs(cb.btns) do
                        btn:UpdateRegisterForClicks()
                    end
                end
            end
        end
    end
end

-- 开启编辑模式
function HbFrame:OpenEditMode()
    if not self.EFrames then
        return
    end
    for _, eFrame in pairs(self.EFrames) do
        eFrame:OpenEditMode()
    end
end

-- 关闭编辑模式
function HbFrame:CloseEditMode()
    if not self.EFrames then
        return
    end
    for _, eFrame in pairs(self.EFrames) do
        eFrame:CloseEditMode()
    end
end

-- 处理战斗event
function HbFrame:OnCombatEvent()
    if not self.EFrames then
        return
    end
    for _, eFrame in pairs(self.EFrames) do
        if LoadCondition:Pass(eFrame.Config.loadCond) then
            if eFrame.Config.loadCond and eFrame.Config.loadCond.CombatCond == false then
                eFrame:HideWindow()
            else
                eFrame:ShowWindow()
                eFrame:CbBtnsUpdateBySelf(eFrame.Cbs, "PLAYER_REGEN_DISABLED", {})
            end
        else
            eFrame:HideWindow()
        end
    end
end
