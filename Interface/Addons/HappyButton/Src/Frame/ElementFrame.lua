local addonName, _ = ...

---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class E: AceModule
local E = addon:GetModule("Element")

---@class Item: AceModule
local Item = addon:GetModule("Item")

---@class AttachFrameCache: AceModule
local AttachFrameCache = addon:GetModule("AttachFrameCache")

---@class Utils: AceModule
local U = addon:GetModule('Utils')

---@class ElementCallback: AceModule
local ECB = addon:GetModule('ElementCallback')

---@class Btn: AceModule
local Btn = addon:GetModule("Btn")

---@class LoadCondition: AceModule
local LoadCondition = addon:GetModule("LoadCondition")

---@class ElementCbInfo
---@field f fun(ele: ElementConfig, lastCbResults: CbResult[]): CbResult[]  -- f: function
---@field p ElementConfig -- p: params
---@field r CbResult[]
---@field btns Btn[]  -- 按钮，数量和CbResult保持一致
---@field e table<EventString, any[][]>  -- 监听物品及触发器事件
---@field loadCondEvents table<EventString, any[][]>  -- 监听物品加载条件事件
---@field passLoadCond boolean | nil -- 是否通过物品加载条件，nil表示没有判断
---@field c ElementCbInfo[] | nil  -- 子元素的callback

---@class Bar
---@field BarFrame nil|table|Button
---@field Icon string | number | nil

---@class ElementFrame: AceModule
---@field Cbs ElementCbInfo | nil
---@field Events table<EventString, any[][]>
---@field Config ElementConfig  -- 当前Frame的配置文件
---@field Window Frame
---@field Bar Bar
---@field IsMouseInside boolean  -- 鼠标是否处在框体内
---@field IconHeight number
---@field IconWidth number
---@field CurrentBarIndex number | nil 当前选择的Bar的下标
---@field attachFrameName string | nil -- 挂载frame的名字
---@field attachFrame Frame | nil -- 挂载frame
local ElementFrame = addon:NewModule("ElementFrame")



-- 判断是否水平方向展示
function ElementFrame:IsHorizontal()
    return
        self.Config.elesGrowth == const.GROWTH.LEFTBOTTOM
        or self.Config.elesGrowth == const.GROWTH.LEFTTOP
        or self.Config.elesGrowth == const.GROWTH.RIGHTBOTTOM
        or self.Config.elesGrowth == const.GROWTH.RIGHTTOP
end

-- 获取框体相对屏幕的位置
---@param frame  Frame
---@return number, number
function ElementFrame:GetPosition(frame)
    local frameLeft      = frame:GetLeft()
    local frameRight     = frame:GetRight()
    local frameBottom    = frame:GetBottom()
    local frameTop       = frame:GetTop()
    local frameX, frameY = frame:GetCenter()
    local x, y           = frame:GetCenter()
    if self.Config.attachFrameAnchorPos == const.ANCHOR_POS.TOPLEFT then
        x = frameLeft
        y = frameTop
    elseif self.Config.attachFrameAnchorPos == const.ANCHOR_POS.TOPRIGHT then
        x = frameRight
        y = frameTop
    elseif self.Config.attachFrameAnchorPos == const.ANCHOR_POS.BOTTOMLEFT then
        x = frameLeft
        y = frameBottom
    elseif self.Config.attachFrameAnchorPos == const.ANCHOR_POS.BOTTOMRIGHT then
        x = frameRight
        y = frameBottom
    elseif self.Config.attachFrameAnchorPos == const.ANCHOR_POS.TOP then
        x = frameX
        y = frameTop
    elseif self.Config.attachFrameAnchorPos == const.ANCHOR_POS.BOTTOM then
        x = frameX
        y = frameBottom
    elseif self.Config.attachFrameAnchorPos == const.ANCHOR_POS.LEFT then
        x = frameLeft
        y = frameY
    elseif self.Config.attachFrameAnchorPos == const.ANCHOR_POS.RIGHT then
        x = frameRight
        y = frameY
    elseif self.Config.attachFrameAnchorPos == const.ANCHOR_POS.CENTER then
        x = frameX
        y = frameY
    end
    return x, y
end

---@param element ElementConfig
---@return ElementFrame
function ElementFrame:New(element)
    local obj = setmetatable({}, { __index = self })
    obj.Config = element
    ElementFrame.InitialWindow(obj)
    obj.IsMouseInside = false
    obj.IconHeight = obj.Config.iconHeight or addon.G.iconHeight
    obj.IconWidth = obj.Config.iconWidth or addon.G.iconWidth
    obj.CurrentBarIndex = 1
    ElementFrame.ReLoadUI(obj)
    return obj
end

function ElementFrame:ReLoadUI()
    self.IconHeight = self.Config.iconHeight or addon.G.iconHeight
    self.IconWidth = self.Config.iconWidth or addon.G.iconWidth
    -- 移除旧的Cbs中的按钮
    self:ClearCbBtns(self.Cbs)
    self.Cbs = self:GetCbs(self.Config, nil)
    self.Events = E:GetEvents(self.Config, nil)
    self.attachFrameName, self.attachFrame = self:GetAttachFrame()
    AttachFrameCache:Add(self.attachFrameName, self.attachFrame)
    self:UpdateWindow()
    self:UpdateBar()
    self:CreateEditModeFrame()
    self:Update("PLAYER_ENTERING_WORLD", {})
    -- 设置初始的时候是否隐藏
    if self.Config.isDisplayMouseEnter == true then
        self:SetBarTransparency()
    end
end

---@param eleConfig ElementConfig
---@param rootConfig ElementConfig | nil
---@return ElementCbInfo | nil
function ElementFrame:GetCbs(eleConfig, rootConfig)
    if eleConfig.type == const.ELEMENT_TYPE.ITEM then
        local item = E:ToItem(eleConfig)
        ---@type ElementCbInfo
        local cb = { f = ECB.CallbackOfSingleMode, p = item, r = {}, btns = {}, e = E:GetEvents(item, rootConfig), loadCondEvents = E:GetLoadCondEvents(eleConfig), c = nil }
        return cb
    elseif eleConfig.type == const.ELEMENT_TYPE.MACRO then
        local macro = E:ToMacro(eleConfig)
        ---@type ElementCbInfo
        local cb = { f = ECB.CallbackOfMacroMode, p = macro, r = {}, btns = {}, e = E:GetEvents(macro, rootConfig), loadCondEvents = E:GetLoadCondEvents(eleConfig), c = nil }
        return cb
    elseif eleConfig.type == const.ELEMENT_TYPE.ITEM_GROUP then
        local itemGroup = E:ToItemGroup(eleConfig)
        ---@type ElementCbInfo
        local cb
        if itemGroup.extraAttr.mode == const.ITEMS_GROUP_MODE.RANDOM then
            cb = { f = ECB.CallbackOfRandomMode, p = itemGroup, r = {}, btns = {}, e = E:GetEvents(itemGroup, rootConfig), loadCondEvents = E:GetLoadCondEvents(eleConfig), c = nil }
        end
        if itemGroup.extraAttr.mode == const.ITEMS_GROUP_MODE.SEQ then
            cb = { f = ECB.CallbackOfSeqMode, p = itemGroup, r = {}, btns = {}, e = E:GetEvents(itemGroup, rootConfig), loadCondEvents = E:GetLoadCondEvents(eleConfig), c = nil }
        end
        return cb
    elseif eleConfig.type == const.ELEMENT_TYPE.SCRIPT then
        local script = E:ToScript(eleConfig)
        if script.extraAttr.script then
            ---@type ElementCbInfo
            local cb = { f = ECB.CallbackOfScriptMode, p = script, r = {}, btns = {}, e = E:GetEvents(script, rootConfig), loadCondEvents = E:GetLoadCondEvents(eleConfig), c = nil }
            return cb
        else
            return nil
        end
    elseif eleConfig.type == const.ELEMENT_TYPE.BAR then
        ---@type ElementCbInfo[]
        local cCb = {}
        local bar = E:ToBar(eleConfig)
        if bar.elements then
            for _, _eleConfig in ipairs(bar.elements) do
                table.insert(cCb, ElementFrame:GetCbs(_eleConfig, rootConfig or eleConfig))
            end
        end
        local cb = { f = nil, p = bar, r = {}, btns = {}, e = E:GetEvents(bar, rootConfig), loadCondEvents = E:GetLoadCondEvents(eleConfig), c = cCb }
        return cb
    end
    return nil
end

-- 创建Bar
function ElementFrame:UpdateBar()
    if not self.Bar then
        local barFrame = CreateFrame("Frame", ("HtBarFrame-%s"):format(self.Config.id), self.Window)
        self.Bar = { BarFrame = barFrame, Icon = self.Config.icon }
    end
    if self.Config.elesGrowth == const.GROWTH.RIGHTBOTTOM then
        self.Bar.BarFrame:SetPoint("TOPLEFT", self.Window, "TOPLEFT", 0, 0)
    elseif self.Config.elesGrowth == const.GROWTH.RIGHTTOP then
        self.Bar.BarFrame:SetPoint("BOTTOMLEFT", self.Window, "BOTTOMLEFT", 0, 0)
    elseif self.Config.elesGrowth == const.GROWTH.LEFTBOTTOM then
        self.Bar.BarFrame:SetPoint("TOPRIGHT", self.Window, "TOPRIGHT", 0, 0)
    elseif self.Config.elesGrowth == const.GROWTH.LEFTTOP then
        self.Bar.BarFrame:SetPoint("BOTTOMRIGHT", self.Window, "BOTTOMRIGHT", 0, 0)
    elseif self.Config.elesGrowth == const.GROWTH.TOPLEFT then
        self.Bar.BarFrame:SetPoint("BOTTOMRIGHT", self.Window, "BOTTOMRIGHT", 0, 0)
    elseif self.Config.elesGrowth == const.GROWTH.TOPRIGHT then
        self.Bar.BarFrame:SetPoint("BOTTOMLEFT", self.Window, "BOTTOMLEFT", 0, 0)
    elseif self.Config.elesGrowth == const.GROWTH.BOTTOMLEFT then
        self.Bar.BarFrame:SetPoint("TOPRIGHT", self.Window, "TOPRIGHT", 0, 0)
    elseif self.Config.elesGrowth == const.GROWTH.BOTTOMRIGHT then
        self.Bar.BarFrame:SetPoint("TOPLEFT", self.Window, "TOPLEFT", 0, 0)
    else
        -- 默认右下
        self.Bar.BarFrame:SetPoint("TOPLEFT", self.Window, "TOPLEFT", 0, 0)
    end
    self.Bar.BarFrame:SetWidth(self.IconWidth)
    self.Bar.BarFrame:SetHeight(self.IconHeight)
end


-- 更新
---@param event EventString
---@param eventArgs any[]
function ElementFrame:Update(event, eventArgs)
    self:UpdateCbPassLoadCond(self.Cbs, event, eventArgs)
    if InCombatLockdown() then
        self:InCombatUpdate(event, eventArgs)
    else
        self:OutCombatUpdate(event, eventArgs)
    end
end


-- 根据事件更新Cb是否通过加载条件
---@param cb ElementCbInfo
---@param event EventString
---@param eventArgs any[]
function ElementFrame:UpdateCbPassLoadCond(cb, event, eventArgs)
    if cb == nil then
        return
    end
    -- 如果是加载条件的事件，先更新加载条件
    if cb.loadCondEvents[event] ~= nil or cb.passLoadCond == nil then
        cb.passLoadCond = LoadCondition:Pass(cb.p.loadCond)
    end
    if cb.c then
        for _, c in ipairs(cb.c) do
            self:UpdateCbPassLoadCond(c, event, eventArgs)
        end
    end
end

-- 删除cb下面的btn信息
---@param cb ElementCbInfo
function ElementFrame:ClearCbBtns(cb)
    if cb == nil then
        return
    end
    if cb.r then
        cb.r = {}
    end
    if cb.btns then
        for i = #cb.btns, 1, -1 do
            cb.btns[i]:Delete()
            cb.btns[i] = nil
        end
    end
    if cb.c then
        for _, c in ipairs(cb.c) do
            self:ClearCbBtns(c)
        end
    end
end

-- 统计cb下面的btn数量
---@param cb ElementCbInfo
---@return number
function ElementFrame:CountCbBtnNumber(cb)
    if cb == nil then
        return 0
    end
    local count = 0
    if cb.btns then
        count = count + #cb.btns
    end
    if cb.c then
        for _, c in ipairs(cb.c) do
            count = count + self:CountCbBtnNumber(c)
        end
    end
    return count
end

-- 更新cb下面的btn
---@param cb ElementCbInfo
---@param event EventString
---@param eventArgs any[]
function ElementFrame:CbBtnsUpdateBySelf(cb, event, eventArgs)
    if cb == nil then
        return
    end
    if cb.btns then
        for _, btn in ipairs(cb.btns) do
            btn:UpdateBySelf(event, eventArgs)
        end
    end
    if cb.c then
        for _, c in ipairs(cb.c) do
            self:CbBtnsUpdateBySelf(c, event, eventArgs)
        end
    end
end


-- 执行cb函数
---@param cb ElementCbInfo
---@param btnIndex {index: number}  -- 用来维护当前frame的btn顺序
---@param event EventString
---@param eventArgs any[]
function ElementFrame:ExcuteCb(cb, btnIndex, event, eventArgs)
    if cb == nil then
        return
    end
    -- 如果是物品条，判断物品条的加载条件是否满足，满足则继续，不满足则递归清除物品的cb
    if cb.p.type == const.ELEMENT_TYPE.BAR then
        if cb.passLoadCond == true then
            if cb.p.elements then
                for _, c in ipairs(cb.c) do
                    self:ExcuteCb(c, btnIndex, event, eventArgs)
                end
            end
        else
            self:ClearCbBtns(cb)
        end
        return
    end
    -- 非物品条，先判断物品是否满足加载条件
    if cb.passLoadCond == true then
        -- 如果当前事件不是这个cb需要监听的事件，则使用上一次cb;否则执行回调函数cb
        if cb.e[event] ~= nil and E:CompareEventParam(cb.e[event], eventArgs) then
            cb.r = cb.f(cb.p, cb.r)
            -- 反向遍历 rs 数组
            for i = #cb.r, 1, -1 do
                ECB:UpdateSelfTrigger(cb.r[i], event, eventArgs)
                ECB:UseTrigger(cb.p, cb.r[i])
                -- 战斗外更新，如果发现隐藏按钮则是移除按钮，首先需要将状态改成false
                cb.r[i].isHideBtn = false
                if cb.r[i].effects then
                    for _, effect in ipairs(cb.r[i].effects) do
                        if effect.type == "btnHide" and effect.status == true then
                            cb.r[i].isHideBtn = true
                            break
                        end
                    end
                end
            end
        end
    else
        cb.r = {}
    end
    local cbBtnIndex = 0
    for _, r in ipairs(cb.r) do
        if r.isHideBtn ~= true then
            btnIndex.index = btnIndex.index + 1
            cbBtnIndex = cbBtnIndex + 1
            -- 如果图标不足，补全图标
            if cbBtnIndex > #cb.btns then
                local btn = Btn:New(self, cb, cbBtnIndex)
                table.insert(cb.btns, btn)
            end
            local btn = cb.btns[cbBtnIndex]
            btn:UpdateByElementFrame(cbBtnIndex, btnIndex.index, event, eventArgs)
        end
    end
    -- 如果按钮过多，删除冗余按钮
    if cbBtnIndex < #cb.btns then
        for i = #cb.btns, cbBtnIndex + 1, -1 do
            cb.btns[i]:Delete()
            cb.btns[i] = nil
        end
    end
end

-- 战斗外更新
---@param event EventString
---@param eventArgs any[]
function ElementFrame:OutCombatUpdate(event, eventArgs)
    if self.Cbs == nil then
        return
    end
    -- 首先判断载入条件
    if self.Cbs.passLoadCond == false then
        self:HideWindow()
        return
    end
    -- 事件不在监听范围内则跳过
    if self.Events[event] == nil or not E:CompareEventParam(self.Events[event], eventArgs) then
        return
    end
    local btnIndex = { index = 0 }
    self:ExcuteCb(self.Cbs, btnIndex, event, eventArgs)
    -- self:SetWindowSize()
    if self.Config.loadCond and self.Config.loadCond.CombatCond == true then
        self:HideWindow()
    else
        self:ShowWindow()
    end
end

-- 战斗中更新
---@param event EventString
---@param eventArgs any[]
function ElementFrame:InCombatUpdate(event, eventArgs)
    if event and self.Events[event] == nil then
        return
    end
    if LoadCondition:Pass(self.Config.loadCond) == false then
        return
    end
    self:CbBtnsUpdateBySelf(self.Cbs, event, eventArgs)
end

function ElementFrame:InitialWindow()
    self.Window = CreateFrame("Frame", ("HtWindow-%s"):format(self.Config.id), UIParent)
    self.Window:SetFrameStrata("BACKGROUND")
    self.Window:SetMovable(true)
    self.Window:EnableMouse(true)
    self.Window:RegisterForDrag("LeftButton")
    self.Window:SetClampedToScreen(true)
    self:ShowWindow()

    -- 监听鼠标点击事件：右键关闭编辑模式
    self.Window:SetScript("OnMouseDown", function(_, button)
        if button == "RightButton" then
            if addon.G.IsEditMode == true then
                addon:SendMessage(const.EVENT.EXIT_EDIT_MODE)
            end
        end
    end)

    -- 监听拖动事件并更新位置
    self.Window:SetScript("OnDragStart", function(frame)
        frame:StartMoving()
    end)

    -- 监听窗口的拖拽事件
    self.Window:SetScript("OnDragStop", function(frame)
        frame:StopMovingOrSizing()
        local parentX, parentY = self:GetPosition(frame:GetParent() or UIParent)
        local frameX, frameY   = self:GetPosition(frame)
        local newX             = frameX - parentX
        local newY             = frameY - parentY
        self.Config.posX       = math.floor(newX)
        self.Config.posY       = math.floor(newY)
    end)

    self.Window:SetScript("OnUpdate", function(frame)
        if addon.G.IsEditMode == true then
            return
        end
        local mouseOver = frame:IsMouseOver()
        if mouseOver and not self.IsMouseInside then
            if self.Config.isDisplayMouseEnter == true then
                self:SetBarNonTransparency()
            end
            self.IsMouseInside = true
        elseif not mouseOver and self.IsMouseInside then
            if self.Config.isDisplayMouseEnter == true then
                self:SetBarTransparency()
            end
            self.IsMouseInside = false
        end
    end)
end


-- 获取当前依附的框体名称、框体
---@return string, Frame
function ElementFrame:GetAttachFrame()
    -- 设置Window框体挂载目标
    local attachFrame = UIParent
    local attachFrameName = const.ATTACH_FRAME.UIParent
    if self.Config.attachFrame and self.Config.attachFrame ~= const.ATTACH_FRAME.UIParent then
        local frame = _G[self.Config.attachFrame]
        if frame then
            attachFrame = frame
            attachFrameName = self.Config.attachFrame
        end
    end
    return attachFrameName, attachFrame
end

function ElementFrame:UpdateWindow()
    if self:IsHorizontal() then
        self.Window:SetHeight(self.IconHeight)
        self.Window:SetWidth(self.IconWidth)
    else
        self.Window:SetHeight(self.IconHeight)
        self.Window:SetWidth(self.IconWidth)
    end

    -- 将窗口定位到初始位置
    local x = self.Config.posX or 0
    local y = self.Config.posY or 0

    self.Window:ClearAllPoints()
    self.Window:SetParent(self.attachFrame)
    -- 设置锚点位置
    local frameAnchorPos = self.Config.anchorPos or const.ANCHOR_POS.CENTER
    local attachFrameAnchorPos = self.Config.attachFrameAnchorPos or const.ANCHOR_POS.CENTER
    self.Window:SetPoint(frameAnchorPos, self.attachFrame, attachFrameAnchorPos, x, y)
end

-- 创建编辑模式背景
function ElementFrame:CreateEditModeFrame()
    self.EditModeBg = self.Window:CreateTexture(nil, "BACKGROUND")
    self.EditModeBg:SetPoint("TOPLEFT", self.Window, "TOPLEFT", 0, 0)
    self.EditModeBg:SetPoint("BOTTOMRIGHT", self.Window, "BOTTOMRIGHT", 0, 0)
    self.EditModeBg:SetColorTexture(0, 0, 1, 0.5) -- 蓝色半透明背景
    self.EditModeBg:Hide()
end

--- 将单个Bar类型设置成透明
function ElementFrame:SetBarTransparency()
    self.Bar.BarFrame:SetAlpha(0)
end

--- 将单个Bar类型设置成不透明
function ElementFrame:SetBarNonTransparency()
    self.Bar.BarFrame:SetAlpha(1)
end

--- 将单个Bar类型设置成隐藏
function ElementFrame:SetBarHidden()
    self.Bar.BarFrame:Hide()
end

--- 将单个Bar类型设置成不透明
function ElementFrame:SetBarShow()
    self.Bar.BarFrame:Show()
end

-- 设置窗口宽度：窗口会遮挡视图，会减少鼠标可点击范围，因此窗口宽度尽可能小
function ElementFrame:SetWindowSize()
    local buttonNum = self:CountCbBtnNumber(self.Cbs)
    if buttonNum == 0 then
        buttonNum = 1
    end
    if self:IsHorizontal() then
        self.Window:SetWidth(self.IconWidth * buttonNum)
        self.Window:SetHeight(self.IconHeight)
    else
        self.Window:SetWidth(self.IconWidth)
        self.Window:SetHeight(self.IconHeight * buttonNum)
    end
end

-- 隐藏窗口
function ElementFrame:HideWindow()
    self.Window:Hide()
end

-- 显示窗口
function ElementFrame:ShowWindow()
    self.Window:Show()
end

-- 开启编辑模式
function ElementFrame:OpenEditMode()
    if addon.G.IsEditMode == true then
        self.Window:Show()
        self.EditModeBg:Show()
        self:SetBarHidden()
    end
end

-- 关闭编辑模式
function ElementFrame:CloseEditMode()
    if addon.G.IsEditMode == false then
        self.EditModeBg:Hide()
        self:SetBarShow()
    end
end

-- 更新配置文件中的物品属性
function ElementFrame:CompleteItemAttr()
    if self.Config == nil then
        return
    end
    E:CompleteItemAttr(self.Config)
end

-- 卸载框体
function ElementFrame:Delete()
    self.Window:Hide()
    self.Window:ClearAllPoints()
    self.Window = nil
    self:ClearCbBtns(self.Cbs)
end
