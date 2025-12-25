local _, ns = ...
local M, R, U, I = unpack(ns)
local UF = M:GetModule("UnitFrames")

-- 点击施法提示窗口
local ClickCastTooltip = CreateFrame("Frame", "OrzUI_ClickCastTooltip", UIParent, "BackdropTemplate")
-- 确保全局变量可访问
_G.ClickCastTooltip = ClickCastTooltip
ClickCastTooltip:SetFrameStrata("TOOLTIP")
ClickCastTooltip:SetFrameLevel(999)
ClickCastTooltip:Hide()

-- 设置背景和边框
local function SetupTooltipAppearance()
	ClickCastTooltip:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	})
	ClickCastTooltip:SetBackdropColor(0, 0, 0, 0.5)
	ClickCastTooltip:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
end

SetupTooltipAppearance()

-- 按键映射表
local keyToLocale = {
	["LMB"] = "左键",
	["RMB"] = "右键", 
	["MMB"] = "中键",
	["MB4"] = "侧键4",
	["MB5"] = "侧键5",
	["MWU"] = "滚轮上",
	["MWD"] = "滚轮下",
}

-- 修饰键映射
local modifierKeys = {
	["ALT"] = "Alt",
	["CTRL"] = "Ctrl", 
	["SHIFT"] = "Shift",
	["ALT-CTRL"] = "Alt+Ctrl",
	["ALT-SHIFT"] = "Alt+Shift",
	["CTRL-SHIFT"] = "Ctrl+Shift",
	["ALT-CTRL-SHIFT"] = "Alt+Ctrl+Shift",
}

-- 获取当前按下的修饰键
local function GetCurrentModifiers()
	local modifiers = {}
	if IsAltKeyDown() then table.insert(modifiers, "ALT") end
	if IsControlKeyDown() then table.insert(modifiers, "CTRL") end
	if IsShiftKeyDown() then table.insert(modifiers, "SHIFT") end
	
	if #modifiers == 0 then
		return nil
	elseif #modifiers == 1 then
		return modifiers[1]
	else
		table.sort(modifiers)
		return table.concat(modifiers, "-")
	end
end

-- 缓存上一次的修饰键状态，避免频繁更新
local lastModifierState = nil

-- 检查修饰键状态是否改变
local function HasModifierChanged()
	local current = GetCurrentModifiers()
	-- 处理 nil 值比较
	local currentStr = current or "none"
	local lastStr = lastModifierState or "none"
	
	if currentStr ~= lastStr then
		lastModifierState = current
		return true
	end
	return false
end

-- 过滤点击施法设置
local function FilterClickSets(clickSets, currentModifier)
	local filtered = {}
	
	for fullkey, value in pairs(clickSets) do
		local keyModifier, baseKey = strmatch(fullkey, "^(.+)%-(%w+)$")
		if not keyModifier then
			-- 没有修饰键的按键
			if not currentModifier then
				filtered[fullkey] = value
			end
		else
			-- 有修饰键的按键
			if currentModifier and keyModifier == currentModifier then
				filtered[fullkey] = value
			elseif not currentModifier then
				-- 显示所有按键时也包含修饰键组合
				filtered[fullkey] = value
			end
		end
	end
	
	return filtered
end

-- 按优先级排序按键（基础按键优先，然后按修饰键复杂度排序）
local function SortClickKeys(keys)
	local function GetKeyPriority(fullkey)
		local keyModifier, baseKey = strmatch(fullkey, "^(.+)%-(%w+)$")
		if not keyModifier then
			return 0 -- 基础按键优先级最高
		else
			-- 修饰键越多优先级越低
			local modCount = 0
			for mod in gmatch(keyModifier, "[^%-]+") do
				modCount = modCount + 1
			end
			return modCount
		end
	end
	
	table.sort(keys, function(a, b)
		local priorityA = GetKeyPriority(a)
		local priorityB = GetKeyPriority(b)
		if priorityA == priorityB then
			return a < b -- 字母顺序
		end
		return priorityA < priorityB
	end)
end

-- 获取法术名称和图标
local function GetSpellInfo(spellID)
	if tonumber(spellID) then
		-- 兼容新旧版本的API
		local spellName, spellTexture
		if C_Spell and C_Spell.GetSpellName then
			spellName = C_Spell.GetSpellName(spellID)
			spellTexture = C_Spell.GetSpellTexture(spellID)
		else
			spellName = GetSpellName(spellID)
			spellTexture = GetSpellTexture(spellID)
		end
		return spellName, spellTexture
	else
		-- 处理特殊命令
		if spellID == "target" then
			return "设为目标", "Interface\\Icons\\Ability_Hunter_SniperShot"
		elseif spellID == "focus" then
			return "设为焦点", "Interface\\Icons\\Ability_Hunter_MasterMarksman"
		elseif spellID == "follow" then
			return "跟随", "Interface\\Icons\\Ability_Tracking"
		elseif strmatch(spellID, "^/") then
			return "自定义宏", "Interface\\Icons\\INV_Misc_Note_01"
		end
	end
	return spellID, "Interface\\Icons\\INV_Misc_QuestionMark"
end

-- 创建提示内容
local function CreateTooltipContent(clickSets, currentModifier)
	local filtered = FilterClickSets(clickSets, currentModifier)
	local lines = {}
	
	-- 添加标题
	if currentModifier then
		table.insert(lines, {
			text = modifierKeys[currentModifier] .. "+点击施法技能",
			color = {1, 0.82, 0}, -- 金色
			size = 14,
			bold = true
		})
	else
		table.insert(lines, {
			text = "点击施法技能",
			color = {1, 0.82, 0}, -- 金色  
			size = 14,
			bold = true
		})
	end
	
	-- 添加分隔线
	table.insert(lines, {
		text = "─────────────────",
		color = {0.5, 0.5, 0.5},
		size = 12
	})
	
	-- 按键排序
	local sortedKeys = {}
	for fullkey in pairs(filtered) do
		table.insert(sortedKeys, fullkey)
	end
	SortClickKeys(sortedKeys)
	
	-- 添加每个按键的信息
	for _, fullkey in ipairs(sortedKeys) do
		local value = filtered[fullkey]
		local spellName, spellTexture = GetSpellInfo(value)
		
		-- 解析按键
		local keyModifier, baseKey = strmatch(fullkey, "^(.+)%-(%w+)$")
		local displayKey
		if keyModifier then
			displayKey = modifierKeys[keyModifier] .. "+" .. (keyToLocale[baseKey] or baseKey)
		else
			displayKey = keyToLocale[fullkey] or fullkey
		end
		
		table.insert(lines, {
			text = displayKey .. ": " .. (spellName or "未知技能"),
			color = {1, 1, 1}, -- 白色
			size = 12,
			texture = spellTexture
		})
	end
	
	if #sortedKeys == 0 then
		table.insert(lines, {
			text = "无可用的点击施法技能",
			color = {0.7, 0.7, 0.7}, -- 灰色
			size = 12
		})
	end
	
	return lines
end

-- 更新提示窗口内容
local function UpdateTooltipContent(lines)
	-- 清除现有内容
	if ClickCastTooltip.contentFrames then
		for _, frame in ipairs(ClickCastTooltip.contentFrames) do
			frame:Hide()
			frame:SetParent(nil)
		end
	end
	ClickCastTooltip.contentFrames = {}
	
	local yOffset = -10
	local maxWidth = 0
	
	for i, line in ipairs(lines) do
		local frame = CreateFrame("Frame", nil, ClickCastTooltip)
		frame:SetPoint("TOPLEFT", ClickCastTooltip, "TOPLEFT", 10, yOffset)
		table.insert(ClickCastTooltip.contentFrames, frame)
		
		-- 创建图标（如果有）
		local iconSize = line.size or 12
		if line.texture then
			local icon = frame:CreateTexture(nil, "ARTWORK")
			icon:SetTexture(line.texture)
			icon:SetSize(iconSize, iconSize)
			icon:SetPoint("LEFT", frame, "LEFT", 0, 0)
			
			-- 文本偏移
			local text = frame:CreateFontString(nil, "OVERLAY")
			text:SetPoint("LEFT", icon, "RIGHT", 4, 0)
			text:SetFont(STANDARD_TEXT_FONT, line.size or 12, line.bold and "OUTLINE" or "")
			text:SetTextColor(unpack(line.color or {1, 1, 1}))
			text:SetText(line.text)
			
			local textWidth = text:GetStringWidth()
			local totalWidth = iconSize + 4 + textWidth
			frame:SetSize(totalWidth, iconSize)
			maxWidth = math.max(maxWidth, totalWidth)
		else
			-- 只有文本
			local text = frame:CreateFontString(nil, "OVERLAY")
			text:SetPoint("LEFT", frame, "LEFT", 0, 0)
			text:SetFont(STANDARD_TEXT_FONT, line.size or 12, line.bold and "OUTLINE" or "")
			text:SetTextColor(unpack(line.color or {1, 1, 1}))
			text:SetText(line.text)
			
			local textWidth = text:GetStringWidth()
			frame:SetSize(textWidth, line.size or 12)
			maxWidth = math.max(maxWidth, textWidth)
		end
		
		yOffset = yOffset - (line.size or 12) - 2
	end
	
	-- 设置提示窗口大小
	ClickCastTooltip:SetSize(maxWidth + 20, math.abs(yOffset) + 10)
end

-- 显示点击施法提示
function UF:ShowClickCastTooltip(frame)
	-- 安全检查：确保数据库已初始化
	if not R or not R.db or not R.db["UFs"] or not R.db["UFs"]["RaidClickSets"] then 
		return 
	end
	if not OrzUISetDB or not OrzUISetDB["ClickSets"] or not OrzUISetDB["ClickSets"][I.MyClass] then 
		return 
	end
	
	local clickSets = OrzUISetDB["ClickSets"][I.MyClass]
	if not next(clickSets) then 
		return 
	end
	
	local currentModifier = GetCurrentModifiers()
	local lines = CreateTooltipContent(clickSets, currentModifier)
	
	UpdateTooltipContent(lines)
	
	-- 定位提示窗口 - 固定在框体左侧，顶部对齐
	_G.ClickCastTooltip:ClearAllPoints()
	_G.ClickCastTooltip:SetPoint("TOPRIGHT", frame, "TOPLEFT", -5, 0)
	_G.ClickCastTooltip:Show()
	
	-- 存储当前关联的框体
	_G.ClickCastTooltip.currentFrame = frame

	
	-- 确保不超出屏幕边界
	local scale = _G.ClickCastTooltip:GetEffectiveScale()
	local x, y = _G.ClickCastTooltip:GetCenter()
	local screenWidth = GetScreenWidth() * UIParent:GetEffectiveScale() / scale
	local screenHeight = GetScreenHeight() * UIParent:GetEffectiveScale() / scale
	
	-- 如果左侧超出屏幕，则显示在右侧
	if x - _G.ClickCastTooltip:GetWidth()/2 < 0 then
		_G.ClickCastTooltip:ClearAllPoints()
		_G.ClickCastTooltip:SetPoint("TOPLEFT", frame, "TOPRIGHT", 5, 0)
	end
	
	-- 如果顶部超出屏幕，则向下调整
	if y + _G.ClickCastTooltip:GetHeight()/2 > screenHeight then
		_G.ClickCastTooltip:ClearAllPoints()
		_G.ClickCastTooltip:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", -5, 0)
	end
end

-- 隐藏点击施法提示
function UF:HideClickCastTooltip()
	_G.ClickCastTooltip:Hide()
	_G.ClickCastTooltip.currentFrame = nil
end

-- 更新提示窗口（当修饰键状态改变时）
function UF:UpdateClickCastTooltip(frame)
	if _G.ClickCastTooltip:IsShown() then
		-- 重新显示提示窗口以反映当前修饰键状态
		UF:ShowClickCastTooltip(frame)
	end
end

-- 窗体跟随鼠标功能
local function UpdateTooltipPosition()
	if not _G.ClickCastTooltip:IsShown() then return end
	
	local x, y = GetCursorPosition()
	local scale = UIParent:GetEffectiveScale()
	x = x / scale
	y = y / scale
	
	-- 设置偏移量，避免鼠标遮挡窗体
	local offsetX = 15
	local offsetY = -15
	
	_G.ClickCastTooltip:ClearAllPoints()
	_G.ClickCastTooltip:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", x + offsetX, y + offsetY)
	
	-- 确保不超出屏幕边界
	local tooltipWidth = _G.ClickCastTooltip:GetWidth()
	local tooltipHeight = _G.ClickCastTooltip:GetHeight()
	local screenWidth = GetScreenWidth()
	local screenHeight = GetScreenHeight()
	
	-- 右边界检查
	if x + offsetX + tooltipWidth > screenWidth then
		offsetX = -tooltipWidth - 15
	end
	
	-- 上边界检查
	if y + offsetY + tooltipHeight > screenHeight then
		offsetY = -tooltipHeight - 15
	end
	
	-- 左边界检查
	if x + offsetX < 0 then
		offsetX = 15
	end
	
	-- 下边界检查
	if y + offsetY < 0 then
		offsetY = 15
	end
	
	_G.ClickCastTooltip:ClearAllPoints()
	_G.ClickCastTooltip:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", x + offsetX, y + offsetY)
end

-- 注册修饰键状态改变事件（已禁用鼠标跟随）
local modifierFrame = CreateFrame("Frame")
modifierFrame:SetScript("OnUpdate", function(self, elapsed)
	-- 每帧检查，避免卡顿
	if _G.ClickCastTooltip:IsShown() then
		local currentFrame = _G.ClickCastTooltip.currentFrame
		if currentFrame and HasModifierChanged() then
			UF:UpdateClickCastTooltip(currentFrame)
		end
		-- 鼠标跟随功能已禁用，提示框固定在框体左侧
		-- UpdateTooltipPosition()
	end
end)

-- 存储当前关联的框体
_G.ClickCastTooltip.currentFrame = nil