local _, ns = ...
local M, R, U, I = unpack(ns)
local oUF = ns.oUF
local UF = M:GetModule("UnitFrames")

local strmatch, format, wipe = strmatch, format, wipe
local pairs, ipairs, next, tonumber, unpack, gsub = pairs, ipairs, next, tonumber, unpack, gsub
local GetSpellName = C_Spell.GetSpellName
local InCombatLockdown = InCombatLockdown
local GetTime, IsInRaid, IsInGroup = GetTime, IsInRaid, IsInGroup
local C_ChatInfo_SendAddonMessage = C_ChatInfo.SendAddonMessage
local LE_PARTY_CATEGORY_HOME = LE_PARTY_CATEGORY_HOME
local LE_PARTY_CATEGORY_INSTANCE = LE_PARTY_CATEGORY_INSTANCE

-- RaidFrame Elements
function UF:CreateRaidIcons(self)
	local parent = CreateFrame("Frame", nil, self)
	parent:SetAllPoints()
	parent:SetFrameLevel(self:GetFrameLevel() + 2)

	local check = parent:CreateTexture(nil, "OVERLAY")
	check:SetSize(16, 16)
	check:SetPoint("BOTTOM", 0, 1)
	self.ReadyCheckIndicator = check

	local resurrect = parent:CreateTexture(nil, "OVERLAY")
	resurrect:SetSize(20, 20)
	resurrect:SetPoint("CENTER", self, 1, 0)
	self.ResurrectIndicator = resurrect

	local role = parent:CreateTexture(nil, "OVERLAY")
	role:SetSize(12, 12)
	role:SetPoint("TOPLEFT", 12, 8)
	self.RaidRoleIndicator = role

	local summon = parent:CreateTexture(nil, "OVERLAY")
	summon:SetSize(32, 32)
	summon:SetPoint("CENTER", parent)
	self.SummonIndicator = summon
end

function UF:UpdateTargetBorder()
	if UnitIsUnit("target", self.unit) then
		self.TargetBorder:Show()
	else
		self.TargetBorder:Hide()
	end
end

function UF:CreateTargetBorder(self)
	local border = M.CreateBDFrame(self, 0)
	border:SetBackdropBorderColor(.9, .9, .9)
	border:Hide()

	self.TargetBorder = border
	self:RegisterEvent("PLAYER_TARGET_CHANGED", UF.UpdateTargetBorder, true)
	self:RegisterEvent("GROUP_ROSTER_UPDATE", UF.UpdateTargetBorder, true)
end

function UF:UpdateThreatBorder(_, unit)
	if unit ~= self.unit then return end

	local element = self.ThreatIndicator
	local status = UnitThreatSituation(unit)

	if status and status > 1 then
		local r, g, b = unpack(oUF.colors.threat[status])
		element:SetBackdropBorderColor(r, g, b)
		element:Show()
	else
		element:Hide()
	end
end

function UF:CreateThreatBorder(self)
	local threatIndicator = M.CreateSD(self.backdrop, 4, true)
	threatIndicator:SetOutside(self, 4+R.mult, 4+R.mult)
	self.backdrop.__shadow = nil

	self.ThreatIndicator = threatIndicator
	self.ThreatIndicator.Override = UF.UpdateThreatBorder
end

local keyList = {}
local mouseButtonList = {"LMB","RMB","MMB","MB4","MB5"}
local modKeyList = {"","ALT-","CTRL-","SHIFT-","ALT-CTRL-","ALT-SHIFT-","CTRL-SHIFT-","ALT-CTRL-SHIFT-"}
local numModKeys = #modKeyList

for i = 1, #mouseButtonList do
	local button = mouseButtonList[i]
	for j = 1, numModKeys do
		local modKey = modKeyList[j]
		keyList[modKey..button] = modKey.."%s"..i
	end
end

local wheelGroupIndex = {}
for i = 1, numModKeys do
	local modKey = modKeyList[i]
	wheelGroupIndex[5 + i] = modKey.."MOUSEWHEELUP"
	wheelGroupIndex[numModKeys + 5 + i] = modKey.."MOUSEWHEELDOWN"
end
for keyIndex, keyString in pairs(wheelGroupIndex) do
	keyString = gsub(keyString, "MOUSEWHEELUP", "MWU")
	keyString = gsub(keyString, "MOUSEWHEELDOWN", "MWD")
	keyList[keyString] = "%s"..keyIndex
end

function UF:DefaultClickSets()
	if not OrzUISetDB["ClickSets"][I.MyClass] then OrzUISetDB["ClickSets"][I.MyClass] = {} end
	if not next(OrzUISetDB["ClickSets"][I.MyClass]) then
		--if R.ClickCastList[I.MyClass] then
			for fullkey, spellID in pairs(R.ClickCastList[I.MyClass]) do
				OrzUISetDB["ClickSets"][I.MyClass][fullkey] = spellID
			--end
		end
	end
end

local onEnterString = "self:ClearBindings();"
local onLeaveString = onEnterString
for keyIndex, keyString in pairs(wheelGroupIndex) do
	onEnterString = format("%sself:SetBindingClick(0, \"%s\", self:GetName(), \"Button%d\");", onEnterString, keyString, keyIndex)
end
local onMouseString = "if not self:IsUnderMouse(false) then self:ClearBindings(); end"

local function setupMouseWheelCast(self)
	local found
	for fullkey in pairs(OrzUISetDB["ClickSets"][I.MyClass]) do
		if strmatch(fullkey, "MW%w") then
			found = true
			break
		end
	end

	if found then
		-- 添加提示功能到clickcast属性中
		local tooltipOnEnter = ""
		local tooltipOnLeave = ""
		
		if R.db["UFs"]["RaidClickSets"] and R.db["UFs"]["RaidClickSetsTooltips"] then
			tooltipOnEnter = "if UF and UF.ShowClickCastTooltip then UF:ShowClickCastTooltip(self); if _G.ClickCastTooltip then _G.ClickCastTooltip.currentFrame = self; end; end;"
			tooltipOnLeave = "if UF and UF.HideClickCastTooltip then UF:HideClickCastTooltip(); if _G.ClickCastTooltip then _G.ClickCastTooltip.currentFrame = nil; end; end;"
		end
		
		self:SetAttribute("clickcast_onenter", onEnterString .. tooltipOnEnter)
		self:SetAttribute("clickcast_onleave", onLeaveString .. tooltipOnLeave)
		self:SetAttribute("_onshow", onLeaveString)
		self:SetAttribute("_onhide", onLeaveString)
		self:SetAttribute("_onmousedown", onMouseString)
	end
end

local fixedSpells = {
	[360823] = 365585, -- incorrect spellID for Evoker
}

local function setupClickSets(self)
	if self.clickCastRegistered then return end

	for fullkey, value in pairs(OrzUISetDB["ClickSets"][I.MyClass]) do
		if fullkey == "SHIFT-LMB" then self.focuser = true end

		local keyIndex = keyList[fullkey]
		if keyIndex then
			if tonumber(value) then
				value = fixedSpells[value] or value
				local spellName = GetSpellName(value)
				if spellName then
					self:SetAttribute(format(keyIndex, "type"), "macro")
					self:SetAttribute(format(keyIndex, "macrotext"), "/cast [@mouseover]"..spellName)
				end
			elseif value == "target" then
				self:SetAttribute(format(keyIndex, "type"), "target")
			elseif value == "focus" then
				self:SetAttribute(format(keyIndex, "type"), "focus")
			elseif value == "follow" then
				self:SetAttribute(format(keyIndex, "type"), "macro")
				self:SetAttribute(format(keyIndex, "macrotext"), "/follow mouseover")
			elseif strmatch(value, "/") then
				self:SetAttribute(format(keyIndex, "type"), "macro")
				value = gsub(value, "~", "\n")
				self:SetAttribute(format(keyIndex, "macrotext"), value)
			end
		end
	end

	setupMouseWheelCast(self)

	-- 如果没有滚轮绑定但启用了提示功能，单独设置提示事件
	if R.db["UFs"]["RaidClickSets"] and R.db["UFs"]["RaidClickSetsTooltips"] then
		local hasWheelBinding = false
		for fullkey in pairs(OrzUISetDB["ClickSets"][I.MyClass]) do
			if strmatch(fullkey, "MW%w") then
				hasWheelBinding = true
				break
			end
		end
		
		if not hasWheelBinding then
			-- 没有滚轮绑定时，使用SetScript设置提示功能
			self:SetScript("OnEnter", function(frame)
				if UF.ShowClickCastTooltip then
					UF:ShowClickCastTooltip(frame)
					if _G.ClickCastTooltip then
						_G.ClickCastTooltip.currentFrame = frame
					end
				end
			end)
			
			self:SetScript("OnLeave", function(frame)
				if UF.HideClickCastTooltip then
					UF:HideClickCastTooltip()
					if _G.ClickCastTooltip then
						_G.ClickCastTooltip.currentFrame = nil
					end
				end
			end)
		end
	end

	self.clickCastRegistered = true
end

local pendingFrames = {}
function UF:CreateClickSets(self)
	if not R.db["UFs"]["RaidClickSets"] then return end

	if InCombatLockdown() then
		pendingFrames[self] = true
	else
		setupClickSets(self)
		pendingFrames[self] = nil
	end
end

function UF:DelayClickSets()
	if not next(pendingFrames) then return end

	for frame in next, pendingFrames do
		UF:CreateClickSets(frame)
	end
end

function UF:AddClickSetsListener()
	if not R.db["UFs"]["RaidClickSets"] then return end

	M:RegisterEvent("PLAYER_REGEN_ENABLED", UF.DelayClickSets)
end

local function UpdateAltPowerAnchor(element)
	if R.db["UFs"]["PartyAltPower"] then
		local self = element.__owner
		local horizon = R.db["UFs"]["PartyDirec"] > 2
		local relF = horizon and "TOP" or "LEFT"
		local relT = horizon and "BOTTOM" or "RIGHT"
		local xOffset = horizon and 0 or 5
		local yOffset = horizon and -5 or 0
		local otherSide = R.db["UFs"]["PWOnRight"]
		if otherSide then
			xOffset = horizon and 0 or -5
			yOffset = horizon and 5 or 0
		end

		element:Show()
		element:ClearAllPoints()
		if otherSide then
			element:SetPoint(relT, self, relF, xOffset, yOffset)
		else
			local parent = horizon and self.Power or self
			element:SetPoint(relF, parent, relT, xOffset, yOffset)
		end
	else
		element:Hide()
	end
end

function UF:CreatePartyAltPower(self)
	local altPower = M.CreateFS(self, 16, "")
	self:Tag(altPower, "[altpower]")
	altPower.__owner = self
	UpdateAltPowerAnchor(altPower)

	self.altPower = altPower
	self.altPower.UpdateAnchor = UpdateAltPowerAnchor
end

function UF:UpdatePartyElements()
	for _, frame in pairs(oUF.objects) do
		if frame.raidType == "party" then
			if frame.altPower then
				frame.altPower:UpdateAnchor()
			end
		end
	end
end

-- 创建点击施法配置按钮
function UF:CreateClickCastConfigButton(self)
	 if not R.db["UFs"]["RaidClickSets"] then return end
	 -- 创建按钮（始终显示，不受RaidClickSets配置影响）
	local button = CreateFrame("Button", nil, self, "BackdropTemplate")
	button:SetSize(6, 6) -- 更小的矩形
	button:SetPoint("TOPRIGHT", self, "TOPLEFT", 0, 0) -- 左对齐框体上方
	
	-- 获取职业颜色
	local unit = self.unit or "player"
	local _, class = UnitClass(unit)
	local classColor = RAID_CLASS_COLORS[class] or RAID_CLASS_COLORS["PRIEST"] -- 默认牧师颜色
	
	-- 设置简单的半透明背景，无边框
	button:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8X8",
		edgeFile = "Interface\\Buttons\\WHITE8X8",
		tile = false,
		tileSize = 0,
		edgeSize = 1,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	button:SetBackdropColor(classColor.r, classColor.g, classColor.b, 0.6) -- 职业颜色，60%透明度
	button:SetBackdropBorderColor(0, 0, 0, 1) -- 黑色边框
	
	-- 鼠标悬停效果
	button:SetScript("OnEnter", function(self)
		-- 悬停时增加透明度
		self:SetBackdropColor(classColor.r, classColor.g, classColor.b, 0.9)
		
		-- 显示提示
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:SetText("点击施法配置", 1, 1, 1)
		GameTooltip:AddLine("点击打开点击施法设置界面", 0.7, 0.7, 0.7, true)
		GameTooltip:Show()
	end)
	
	button:SetScript("OnLeave", function(self)
		-- 恢复正常透明度
		self:SetBackdropColor(classColor.r, classColor.g, classColor.b, 0.6)
		GameTooltip:Hide()
	end)
	
	-- 点击事件
	button:SetScript("OnClick", function(self)
		-- 获取GUI模块并打开点击施法配置界面
		local G = M:GetModule("GUI")
		if G and G.SetupClickCast then
			-- 传递按钮的父级框架，这样配置界面可以正确定位
			G:SetupClickCast(button:GetParent())
		else
			print("点击施法配置界面未找到")
		end
	end)
	
	-- 存储按钮引用
	self.clickCastConfigButton = button
	
	-- 默认显示按钮
	button:Show()
end

-- 显示/隐藏配置按钮
function UF:ToggleClickCastConfigButton(self, show)
	if self.clickCastConfigButton then
		if show then
			self.clickCastConfigButton:Show()
		else
			self.clickCastConfigButton:Hide()
		end
	end
end