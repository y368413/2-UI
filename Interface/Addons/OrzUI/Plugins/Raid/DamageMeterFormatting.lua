-- ## Author: Giftia + GPT-5.2 ## Version: 0.2.4 DamageMeterFormatFix
-- Purpose:
--   - SessionWindow: show "Total (Per Second)" (e.g. Damage Done (DPS))
-- This is a UI hook; Blizzard does NOT provide an official API to change the display format.

local ADDON_TO_HOOK = "Blizzard_DamageMeter";

local hooked = false;
local DEBUG = false;

local function Print(msg)
	if DEFAULT_CHAT_FRAME then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffd200DamageMeterFormatFix:|r " .. tostring(msg));
	end
end

local function AbbrevNumberOrZero(v)
	if v == nil then
		return nil;
	end

	-- AbbreviateLargeNumbers is a Blizzard global utility used by the default Damage Meter UI.
	local ok, text = pcall(AbbreviateLargeNumbers, v);
	if not ok then
		return nil;
	end
	return text;
end

local function ShouldOverrideValueText(entry)
	-- Only override when both fields exist (Blizzard doesn't display both).
	return entry ~= nil and entry.value ~= nil and entry.valuePerSecond ~= nil and type(entry.GetValue) == "function";
end

local function FindOwningSourceWindow(entry)
	-- Source page (spell breakdown) entries live under a SourceWindow container.
	-- We only need to detect it so we can avoid overriding Blizzard's own formatting on that page.
	local parent = entry and entry.GetParent and entry:GetParent() or nil;
	local maxHops = 20;
	while parent and maxHops > 0 do
		-- DamageMeterSourceWindowMixin-like shape.
		if type(parent.GetSourceGUID) == "function" and type(parent.GetScrollBox) == "function" then
			return parent;
		end

		parent = parent.GetParent and parent:GetParent() or nil;
		maxHops = maxHops - 1;
	end

	return nil;
end

local function IsSourcePageEntry(entry)
	-- Fast-path: spell entries always belong to the source (breakdown) page.
	if entry and (entry.spellID ~= nil or type(entry.GetSpellID) == "function") then
		return true;
	end

	return FindOwningSourceWindow(entry) ~= nil;
end

local function ApplyTotalPerSecondValueText(entry)
	if not entry or not entry.GetValue then
		if DEBUG then
			Print("no entry or no GetValue");
		end
		return;
	end

	if not ShouldOverrideValueText(entry) then
		return;
	end

	-- Do NOT touch the source page; Blizzard already formats it (including skill %).
	if IsSourcePageEntry(entry) then
		return;
	end

	local totalText = AbbrevNumberOrZero(entry.value);
	local perSecondText = AbbrevNumberOrZero(entry.valuePerSecond);
	if not totalText or not perSecondText then
		return;
	end

	-- Format: Total (PerSecond)
	-- Example: 1.2M (54.3K)
	entry:GetValue():SetText(string.format("%s (%s)", totalText, perSecondText));
end

local function ApplyValueText(entry)
	ApplyTotalPerSecondValueText(entry);
end

local function TryHookDamageMeter()
	if not DamageMeterEntryMixin or type(DamageMeterEntryMixin) ~= "table" then
		return;
	end

	if type(DamageMeterEntryMixin.UpdateValue) ~= "function" then
		return;
	end

	if hooked then
		return;
	end

	-- hooksecurefunc runs after the original function; we then overwrite the value text.
	-- Note: hooksecurefunc only supports:
	--   hooksecurefunc([table,] "function", hookfunc)
	hooksecurefunc(DamageMeterEntryMixin, "UpdateValue", function(entry)
		-- Never allow secret-value access to break the UI; if something errors, just keep Blizzard's original text.
		local ok, err = pcall(ApplyValueText, entry);
		if not ok and DEBUG then
			Print(err);
		end
	end);

	hooked = true;
	if DEBUG then
		Print("hooked DamageMeterEntryMixin.UpdateValue()");
	end
end

local function ApplyToVisibleDamageMeterEntries()
	-- IMPORTANT: Avoid calling SessionWindow:Refresh() from addon code.
	-- Refresh triggers BuildDataProvider() which compares secret GUID values and can error when called from addon context.
	if not DamageMeter or type(DamageMeter.ForEachSessionWindow) ~= "function" then
		return;
	end

	local function SafeApply(entry)
		local ok = pcall(ApplyValueText, entry);
		return ok;
	end

	DamageMeter:ForEachSessionWindow(function(sessionWindow)
		if not sessionWindow then
			return;
		end

		-- Entries in the scroll box.
		if type(sessionWindow.EnumerateEntryFrames) == "function" then
			for _index, entry in sessionWindow:EnumerateEntryFrames() do
				SafeApply(entry);
			end
		end

		-- Local player entry is outside the scroll box.
		if type(sessionWindow.GetLocalPlayerEntry) == "function" then
			local localEntry = sessionWindow:GetLocalPlayerEntry();
			SafeApply(localEntry);
		end
	end);
end

SLASH_DMFF1 = "/dmff";
SlashCmdList.DMFF = function(msg)
	msg = (msg or ""):lower():gsub("^%s+", ""):gsub("%s+$", "");

	if msg == "debug" then
		DEBUG = not DEBUG;
		Print("debug=" .. tostring(DEBUG));
		if IsAddOnLoaded and IsAddOnLoaded(ADDON_TO_HOOK) then
			TryHookDamageMeter();
		end
		return;
	end

	if msg == "hook" then
		TryHookDamageMeter();
		Print("hooked=" .. tostring(hooked));
		return;
	end

	Print("hooked=" .. tostring(hooked) .. "  (commands: /dmff hook, /dmff debug)");
end

local f = CreateFrame("Frame");
f:RegisterEvent("ADDON_LOADED");
f:RegisterEvent("PLAYER_LOGIN");
f:RegisterEvent("PLAYER_REGEN_ENABLED");
f:RegisterEvent("DAMAGE_METER_COMBAT_SESSION_UPDATED");
f:RegisterEvent("DAMAGE_METER_CURRENT_SESSION_UPDATED");
f:RegisterEvent("DAMAGE_METER_RESET");
f:SetScript("OnEvent", function(self, event, addonName)
	if event == "ADDON_LOADED" then
		-- Try on every addon load; once Blizzard_DamageMeter is loaded the mixins will exist.
		TryHookDamageMeter();
	elseif event == "PLAYER_LOGIN" then
		-- If Blizzard_DamageMeter is already loaded by the time we log in, hook immediately.
		if IsAddOnLoaded and IsAddOnLoaded(ADDON_TO_HOOK) then
			TryHookDamageMeter();
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
		-- Leaving combat: re-apply formatting to anything currently visible.
		if hooked then
			ApplyToVisibleDamageMeterEntries();
		end
	elseif event == "DAMAGE_METER_COMBAT_SESSION_UPDATED" or event == "DAMAGE_METER_CURRENT_SESSION_UPDATED" or event == "DAMAGE_METER_RESET" then
		-- Keep text updated without forcing a Refresh from addon code.
		if hooked then
			ApplyToVisibleDamageMeterEntries();
		end
	end
end);


-- 创建伤害统计格式修复管理器
local formatManager = CreateFrame("Frame", "DamageMeterFormatManager", UIParent)
formatManager:RegisterEvent("ADDON_LOADED")
formatManager:RegisterEvent("PLAYER_LOGIN")
formatManager:RegisterEvent("PLAYER_REGEN_ENABLED")
formatManager:RegisterEvent("DAMAGE_METER_COMBAT_SESSION_UPDATED")
formatManager:RegisterEvent("DAMAGE_METER_CURRENT_SESSION_UPDATED")
formatManager:RegisterEvent("DAMAGE_METER_RESET")

formatManager:SetScript("OnEvent", function(self, event, addonName)
    if event == "ADDON_LOADED" then
        -- Try on every addon load; once Blizzard_DamageMeter is loaded the mixins will exist.
        TryHookDamageMeter()
    elseif event == "PLAYER_LOGIN" then
        -- If Blizzard_DamageMeter is already loaded by the time we log in, hook immediately.
        if IsAddOnLoaded and IsAddOnLoaded(ADDON_TO_HOOK) then
            TryHookDamageMeter()
        end
    elseif event == "PLAYER_REGEN_ENABLED" then
        -- Leaving combat: re-apply formatting to anything currently visible.
        if damageMeterHooked then
            ApplyToVisibleDamageMeterEntries()
        end
    elseif event == "DAMAGE_METER_COMBAT_SESSION_UPDATED" or event == "DAMAGE_METER_CURRENT_SESSION_UPDATED" or event == "DAMAGE_METER_RESET" then
        -- Keep text updated without forcing a Refresh from addon code.
        if damageMeterHooked then
            ApplyToVisibleDamageMeterEntries()
        end
    end
end)

------------------------------------------------------------DamageMeterMod_Texture
-- 处理状态条纹理替换的辅助函数
local function ApplyMaterialsToStatusBar(statusBar)
    if statusBar and not statusBar.__MaterialsApplied then
        -- 替换状态条纹理
        statusBar:SetStatusBarTexture("Interface\\AddOns\\OrzUI\\Media\\Modules\\Skada\\YaSkada05.blp")
        
        -- 隐藏边框 - 使用BackgroundEdge
        if statusBar.BackgroundEdge then
            statusBar.BackgroundEdge:Hide()
        end
        
        -- 隐藏背景 - 使用Background
        if statusBar.Background then
            statusBar.Background:Hide()
        end
        
        -- 标记已处理
        statusBar.__MaterialsApplied = true
    end
end

-- 主要纹理替换和边框背景隐藏函数
local function ReplaceDamageMeterTextures()
    -- 检查所有伤害统计窗口（通常最多3个）
    for i = 1, 3 do
        local mainWindow = _G["DamageMeterSessionWindow" .. i]
        
        -- 如果窗口存在
        if mainWindow then
            -- 处理LocalPlayerEntry的状态条
            if mainWindow.LocalPlayerEntry and mainWindow.LocalPlayerEntry.StatusBar then
                ApplyMaterialsToStatusBar(mainWindow.LocalPlayerEntry.StatusBar)
            end
            
            -- 如果窗口有ScrollBox
            if mainWindow.ScrollBox and mainWindow.ScrollBox.ScrollTarget then
                local scrollTarget = mainWindow.ScrollBox.ScrollTarget
                
                -- 遍历滚动目标下的所有子元素（伤害统计条）
                for _, child in ipairs({scrollTarget:GetChildren()}) do
                    -- 如果子元素有StatusBar
                    if child.StatusBar then
                        ApplyMaterialsToStatusBar(child.StatusBar)
                    end
                end
            end
        end
    end
end

-- 创建定时器定期执行替换
local timer = C_Timer.NewTicker(1, function()
    ReplaceDamageMeterTextures()
end)

-- 玩家登录时立即执行一次
local DamageMeterMod_Texture = CreateFrame("Frame")
DamageMeterMod_Texture:RegisterEvent("PLAYER_LOGIN")
DamageMeterMod_Texture:SetScript("OnEvent", function()
    C_Timer.After(1, function()
        ReplaceDamageMeterTextures()
    end)
end)

-----------------------------------------------------------------------DamageMeterMod_Hover
-- 创建智能的鼠标检测区域
local function CreateSmartHoverFrame(parentWindow)
    if not parentWindow then return nil end
    
    local hoverFrame = CreateFrame("Frame", parentWindow:GetName().."SmartHoverController", parentWindow)
    
    -- 获取窗口尺寸
    local windowWidth = parentWindow:GetWidth() or 300
    local windowHeight = parentWindow:GetHeight() or 200
    
    -- 创建三个悬停检测区域：左上、右上、以及除交互元素外的其他区域
    local leftHover = CreateFrame("Frame", nil, hoverFrame)
    leftHover:SetPoint("TOPLEFT", parentWindow, "TOPLEFT", 0, 0)
    leftHover:SetPoint("BOTTOMLEFT", parentWindow, "TOPLEFT", 0, -30)
    leftHover:SetWidth(windowWidth * 0.3)  -- 左侧30%区域
    
    local rightHover = CreateFrame("Frame", nil, hoverFrame)
    rightHover:SetPoint("TOPRIGHT", parentWindow, "TOPRIGHT", 0, 0)
    rightHover:SetPoint("BOTTOMRIGHT", parentWindow, "TOPRIGHT", 0, -30)
    rightHover:SetWidth(windowWidth * 0.3)  -- 右侧30%区域
    
    local centerHover = CreateFrame("Frame", nil, hoverFrame)
    centerHover:SetPoint("TOPLEFT", leftHover, "TOPRIGHT", 0, 0)
    centerHover:SetPoint("TOPRIGHT", rightHover, "TOPLEFT", 0, 0)
    centerHover:SetPoint("BOTTOM", parentWindow, "TOP", 0, -30)
    
    -- 启用鼠标检测但不拦截点击
    leftHover:EnableMouse(true)
    rightHover:EnableMouse(true)
    centerHover:EnableMouse(true)
    
    -- 设置较低的层级
    leftHover:SetFrameStrata("BACKGROUND")
    rightHover:SetFrameStrata("BACKGROUND")
    centerHover:SetFrameStrata("BACKGROUND")
    
    hoverFrame.leftHover = leftHover
    hoverFrame.rightHover = rightHover
    hoverFrame.centerHover = centerHover
    
    return hoverFrame
end

-- 动态构建fadeElements表，只包含实际存在的元素
local function BuildFadeElements()
    local elements = {}
    local windowNames = {"DamageMeterSessionWindow1", "DamageMeterSessionWindow2", "DamageMeterSessionWindow3"}
    
    for _, windowName in ipairs(windowNames) do
        local window = _G[windowName]
        if window then
            -- 确保ScrollBox可以接收鼠标事件
            if window.ScrollBox and window.ScrollBox.ScrollTarget then
                window.ScrollBox:EnableMouse(true)
                window.ScrollBox.ScrollTarget:EnableMouse(true)
            end
            
            -- 添加该窗口的所有界面元素
            local windowElements = {
                window.Header,
                window.SettingsDropdown and window.SettingsDropdown.Icon,
                window.DamageMeterTypeDropdown and window.DamageMeterTypeDropdown.Arrow,
                window.SessionDropdown and window.SessionDropdown.Background,
                window.DamageMeterTypeDropdown and window.DamageMeterTypeDropdown.TypeName,
                window.SessionDropdown and window.SessionDropdown.SessionName,
                window.SessionDropdown and window.SessionDropdown.Text
            }
            
            for _, element in ipairs(windowElements) do
                if element then
                    table.insert(elements, element)
                end
            end
        end
    end
    
    return elements
end

-- 初始隐藏所有元素
local fadeElements = BuildFadeElements()
for _, element in ipairs(fadeElements) do
    element:SetAlpha(0)
    -- 不禁用元素的鼠标检测，让它们可以点击
    -- element:EnableMouse(false)
end

-- 创建智能悬停检测区域
local mainHoverFrame = CreateSmartHoverFrame(DamageMeterSessionWindow1)
local hideTimer = nil
local isMouseOverHoverArea = false
local hideDelay = 3  -- 鼠标离开后3秒隐藏

-- 悬停显示/隐藏函数
local function ShowFadeElements()
    -- 如果已经有隐藏计时器，先取消
    if hideTimer then
        hideTimer:Cancel()
        hideTimer = nil
    end
    
    for _, element in ipairs(fadeElements) do
        if element:GetAlpha() < 1 then
            UIFrameFadeIn(element, 0.3, element:GetAlpha(), 1)
        end
    end
end

local function HideFadeElements()
    for _, element in ipairs(fadeElements) do
        if element:GetAlpha() > 0 then
            UIFrameFadeOut(element, 0.3, element:GetAlpha(), 0)
        end
    end
end

-- 鼠标进入悬停区域时的处理
local function OnEnterHoverArea()
    isMouseOverHoverArea = true
    
    -- 取消任何待定的隐藏计时器
    if hideTimer then
        hideTimer:Cancel()
        hideTimer = nil
    end
    
    ShowFadeElements()
end

-- 鼠标离开悬停区域时的处理
local function OnLeaveHoverArea()
    isMouseOverHoverArea = false
    
    -- 取消任何已有的隐藏计时器
    if hideTimer then
        hideTimer:Cancel()
        hideTimer = nil
    end
    
    -- 设置新的隐藏计时器，延迟3秒
    hideTimer = C_Timer.After(hideDelay, function()
        if not isMouseOverHoverArea then
            HideFadeElements()
        end
    end)
end

-- 为标题栏元素添加鼠标检测
local function SetupHeaderMouseInteraction(window)
    if not window or not window.Header then return end
    
    -- 为Header添加鼠标检测
    if window.Header then
        window.Header:EnableMouse(true)
        window.Header:SetScript("OnEnter", function(self)
            OnEnterHoverArea()
        end)
        window.Header:SetScript("OnLeave", function(self)
            OnLeaveHoverArea()
        end)
    end
    
    -- 为下拉菜单添加鼠标检测
    if window.SettingsDropdown then
        window.SettingsDropdown:EnableMouse(true)
        window.SettingsDropdown:SetScript("OnEnter", function(self)
            OnEnterHoverArea()
        end)
        window.SettingsDropdown:SetScript("OnLeave", function(self)
            OnLeaveHoverArea()
        end)
    end
    
    if window.DamageMeterTypeDropdown then
        window.DamageMeterTypeDropdown:EnableMouse(true)
        window.DamageMeterTypeDropdown:SetScript("OnEnter", function(self)
            OnEnterHoverArea()
        end)
        window.DamageMeterTypeDropdown:SetScript("OnLeave", function(self)
            OnLeaveHoverArea()
        end)
    end
    
    if window.SessionDropdown then
        window.SessionDropdown:EnableMouse(true)
        window.SessionDropdown:SetScript("OnEnter", function(self)
            OnEnterHoverArea()
        end)
        window.SessionDropdown:SetScript("OnLeave", function(self)
            OnLeaveHoverArea()
        end)
    end
end

if mainHoverFrame then
    -- 设置悬停区域的事件
    mainHoverFrame.leftHover:SetScript("OnEnter", OnEnterHoverArea)
    mainHoverFrame.leftHover:SetScript("OnLeave", OnLeaveHoverArea)
    
    mainHoverFrame.rightHover:SetScript("OnEnter", OnEnterHoverArea)
    mainHoverFrame.rightHover:SetScript("OnLeave", OnLeaveHoverArea)
    
    mainHoverFrame.centerHover:SetScript("OnEnter", OnEnterHoverArea)
    mainHoverFrame.centerHover:SetScript("OnLeave", OnLeaveHoverArea)
    
    -- 为标题栏元素设置鼠标交互
    SetupHeaderMouseInteraction(DamageMeterSessionWindow1)
end

-- 为存在的窗口创建额外的悬停检测区域
local function CreateAdditionalHoverFrames()
    local windowNames = {"DamageMeterSessionWindow2", "DamageMeterSessionWindow3"}
    
    for _, windowName in ipairs(windowNames) do
        local window = _G[windowName]
        if window then
            local hoverFrame = CreateSmartHoverFrame(window)
            
            if hoverFrame then
                hoverFrame.leftHover:SetScript("OnEnter", OnEnterHoverArea)
                hoverFrame.leftHover:SetScript("OnLeave", OnLeaveHoverArea)
                
                hoverFrame.rightHover:SetScript("OnEnter", OnEnterHoverArea)
                hoverFrame.rightHover:SetScript("OnLeave", OnLeaveHoverArea)
                
                hoverFrame.centerHover:SetScript("OnEnter", OnEnterHoverArea)
                hoverFrame.centerHover:SetScript("OnLeave", OnLeaveHoverArea)
                
                -- 为标题栏元素设置鼠标交互
                SetupHeaderMouseInteraction(window)
            end
        end
    end
end

-- 创建框架管理器来处理初始化和事件
local hoverManager = CreateFrame("Frame", "DamageMeterHoverManager", UIParent)
hoverManager:RegisterEvent("PLAYER_ENTERING_WORLD")

hoverManager:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_ENTERING_WORLD" then
        C_Timer.After(2, function()
            -- 重新构建fadeElements以确保包含最新元素
            fadeElements = BuildFadeElements()
            -- 创建额外的悬停检测框架
            CreateAdditionalHoverFrames()
        end)
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
    end
end)
---------------------------------------------------------------------DamageMeterMod_FrameBind
-- 创建框架定位管理器
local frameManager = CreateFrame("Frame", "DamageMeterFrameManager", UIParent)
frameManager:RegisterEvent("PLAYER_ENTERING_WORLD")

-- 改进的主定位函数 - 自适应不同数量的窗口
local function SetupDamageMeterPositions()
    -- 动态处理存在的窗口
    local previousWindow = DamageMeterSessionWindow1
    
    -- 按顺序处理Window2和Window3
    for i = 2, 3 do
        local windowName = "DamageMeterSessionWindow"..i
        local currentWindow = _G[windowName]
        
        if currentWindow then
            -- 获取主窗口尺寸
            local mainHeight = DamageMeterSessionWindow1:GetHeight()
            local mainWidth = DamageMeterSessionWindow1:GetWidth()
            
            if mainHeight and mainHeight > 0 and mainWidth and mainWidth > 0 then
                -- 设置尺寸与主窗口一致
                currentWindow:SetHeight(mainHeight)
                currentWindow:SetWidth(mainWidth)
            end
            
            -- 清除现有锚点并设置位置
            currentWindow:ClearAllPoints()
            currentWindow:SetPoint("BOTTOM", previousWindow, "TOP", 0, 0)
            
            -- 设置框架层级
            currentWindow:SetFrameStrata(previousWindow:GetFrameStrata() or "MEDIUM")
            
            previousWindow = currentWindow
        end
    end
end

-- 改进的尺寸同步函数
local function SyncFrameSizes()
    local mainHeight = DamageMeterSessionWindow1:GetHeight()
    local mainWidth = DamageMeterSessionWindow1:GetWidth()
    
    if mainHeight and mainHeight > 0 and mainWidth and mainWidth > 0 then
        -- 同步所有存在的窗口
        for i = 1, 3 do
            local windowName = "DamageMeterSessionWindow"..i
            local window = _G[windowName]
            if window then
                window:SetHeight(mainHeight)
                window:SetWidth(mainWidth)
            end
        end
        
        -- 重新建立位置关系
        local previousWindow = DamageMeterSessionWindow1
        for i = 2, 3 do
            local currentWindow = _G["DamageMeterSessionWindow"..i]
            if currentWindow then
                currentWindow:ClearAllPoints()
                currentWindow:SetPoint("BOTTOM", previousWindow, "TOP", 0, 0)
                previousWindow = currentWindow
            end
        end
    end
end

-- 事件处理
frameManager:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_ENTERING_WORLD" then
        C_Timer.After(2, function()
            SetupDamageMeterPositions()
            
            -- 注册尺寸监控
            C_Timer.NewTicker(1, function()
                local mainHeight = DamageMeterSessionWindow1:GetHeight()
                local mainWidth = DamageMeterSessionWindow1:GetWidth()
                
                -- 检查尺寸变化
                if mainHeight and mainHeight ~= (self.lastHeight or 0) or 
                   mainWidth and mainWidth ~= (self.lastWidth or 0) then
                    
                    self.lastHeight = mainHeight
                    self.lastWidth = mainWidth
                    
                    SyncFrameSizes()
                end
            end)
        end)
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
    end
end)

