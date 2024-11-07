﻿local _, ns = ...
local M, R, U, I = unpack(ns)
local oUF = ns.oUF
if not R.Infobar.System then return end

local module = M:GetModule("Infobar")
local info = module:RegisterInfobar("Fps", R.Infobar.SystemPos)

local ipairs, tinsert, wipe, sort = ipairs, tinsert, wipe, sort
local format, floor, min, max = format, floor, min, max
local GetFramerate, GetTime = GetFramerate, GetTime
local GetCVarBool, SetCVar = GetCVarBool, SetCVar
local UpdateAddOnCPUUsage, GetAddOnCPUUsage = UpdateAddOnCPUUsage, GetAddOnCPUUsage
local UpdateAddOnMemoryUsage, GetAddOnMemoryUsage = UpdateAddOnMemoryUsage, GetAddOnMemoryUsage
local IsShiftKeyDown = IsShiftKeyDown
local IsAddOnLoaded = C_AddOns.IsAddOnLoaded
local ResetCPUUsage, collectgarbage, gcinfo = ResetCPUUsage, collectgarbage, gcinfo

local showMoreString = "%d %s (%s)"
local usageString = "%.3f ms"
local enableString = "|cff55ff55"..VIDEO_OPTIONS_ENABLED
local disableString = "|cffff5555"..VIDEO_OPTIONS_DISABLED
local scriptProfileStatus = GetCVarBool("scriptProfile")
local entered

local function formatMemory(value)
	if value > 1024 then
		return format("%.1fm", value / 1024)
	else
		return format("%.0fk", value)
	end
end

local function sortByMemory(a, b)
	if a and b then
		return (a[3] == b[3] and a[2] < b[2]) or a[3] > b[3]
	end
end

local function sortByCPU(a, b)
	if a and b then
		return (a[4] == b[4] and a[2] < b[2]) or a[4] > b[4]
	end
end

local usageColor = {0, 1, 0, 1, 1, 0, 1, 0, 0}
local function smoothColor(cur, max)
	local r, g, b = oUF:RGBColorGradient(cur, max, unpack(usageColor))
	return r, g, b
end

local infoTable = {}
local function BuildAddonList()
	local numAddons = C_AddOns.GetNumAddOns()
	if numAddons == #infoTable then return end

	wipe(infoTable)
	for i = 1, numAddons do
		local _, title, _, loadable = C_AddOns.GetAddOnInfo(i)
		if loadable then
			tinsert(infoTable, {i, title, 0, 0})
		end
	end
end

local function UpdateMemory()
	UpdateAddOnMemoryUsage()

	local total = 0
	for _, data in ipairs(infoTable) do
		if IsAddOnLoaded(data[1]) then
			local mem = GetAddOnMemoryUsage(data[1])
			data[3] = mem
			total = total + mem
		end
	end
	sort(infoTable, sortByMemory)

	return total
end

local function UpdateCPU()
	UpdateAddOnCPUUsage()

	local total = 0
	for _, data in ipairs(infoTable) do
		if IsAddOnLoaded(data[1]) then
			local addonCPU = GetAddOnCPUUsage(data[1])
			data[4] = addonCPU
			total = total + addonCPU
		end
	end
	sort(infoTable, sortByCPU)

	return total
end

local function colorFPS(fps)
	if fps < 15 then
		return "|cffD80909"..fps
	elseif fps < 30 then
		return "|cffE8DA0F"..fps
	else
		return "|cff0CD809"..fps
	end
end

local function setFrameRate(self)
	local fps = floor(GetFramerate())
	self.text:SetText(colorFPS(fps).."|rFps")
end

info.onUpdate = function(self, elapsed)
	self.timer = (self.timer or 0) + elapsed
	if self.timer > 1 then
		setFrameRate(self)
		if entered then self:onEnter() end

		self.timer = 0
	end
end

info.onEnter = function(self)
	entered = true

	if not next(infoTable) then BuildAddonList() end
	local isShiftKeyDown = IsShiftKeyDown()
	local maxAddOns = R.db["Misc"]["MaxAddOns"]
	local maxShown = isShiftKeyDown and #infoTable or min(maxAddOns, #infoTable)

	local _, anchor, offset = module:GetTooltipAnchor(info)
	GameTooltip:SetOwner(self, "ANCHOR_"..anchor, 0, offset)
	GameTooltip:ClearLines()

	if self.showMemory or not scriptProfileStatus then
		local totalMemory = UpdateMemory()
		GameTooltip:AddDoubleLine(U["System"], formatMemory(totalMemory), 0,.6,1, .6,.8,1)
		GameTooltip:AddLine(" ")

		local numEnabled = 0
		for _, data in ipairs(infoTable) do
			if IsAddOnLoaded(data[1]) then
				numEnabled = numEnabled + 1
				if numEnabled <= maxShown then
					local r, g, b = smoothColor(data[3], totalMemory)
					GameTooltip:AddDoubleLine(data[2], formatMemory(data[3]), 1,1,1, r,g,b)
				end
			end
		end

		if not isShiftKeyDown and (numEnabled > maxAddOns) then
			local hiddenMemory = 0
			for i = (maxAddOns + 1), numEnabled do
				hiddenMemory = hiddenMemory + infoTable[i][3]
			end
			GameTooltip:AddDoubleLine(format(showMoreString, numEnabled - maxAddOns, U["Hidden"], U["Hold Shift"]), formatMemory(hiddenMemory), .6,.8,1, .6,.8,1)
		end
	else
		local totalCPU = UpdateCPU()
		local passedTime = max(1, GetTime() - module.loginTime)
		GameTooltip:AddDoubleLine(U["System"], format(usageString, totalCPU / passedTime, 0,.6,1, .6,.8,1))
		GameTooltip:AddLine(" ")

		local numEnabled = 0
		for _, data in ipairs(infoTable) do
			if IsAddOnLoaded(data[1]) then
				numEnabled = numEnabled + 1
				if numEnabled <= maxShown then
					local r, g, b = smoothColor(data[4], totalCPU)
					GameTooltip:AddDoubleLine(data[2], format(usageString, data[4] / passedTime), 1,1,1, r,g,b)
				end
			end
		end

		if not isShiftKeyDown and (numEnabled > maxAddOns) then
			local hiddenUsage = 0
			for i = (maxAddOns + 1), numEnabled do
				hiddenUsage = hiddenUsage + infoTable[i][4]
			end
			GameTooltip:AddDoubleLine(format(showMoreString, numEnabled - maxAddOns, U["Hidden"], U["Hold Shift"]), format(usageString, hiddenUsage / passedTime), .6,.8,1, .6,.8,1)
		end
	end

	GameTooltip:AddDoubleLine(" ", I.LineString)
	GameTooltip:AddDoubleLine(" ", I.LeftButton..U["Collect Memory"].." ", 1,1,1, .6,.8,1)
	if scriptProfileStatus then
		GameTooltip:AddDoubleLine(" ", I.RightButton..U["SwitchSystemInfo"].." ", 1,1,1, .6,.8,1)
	end
	GameTooltip:AddDoubleLine(" ", I.ScrollButton..U["CPU Usage"]..": "..(GetCVarBool("scriptProfile") and enableString or disableString).." ", 1,1,1, .6,.8,1)
	GameTooltip:Show()
end

info.onLeave = function()
	entered = false
	GameTooltip:Hide()
end

StaticPopupDialogs["CPUUSAGE"] = {
	text = U["ReloadUI Required"],
	button1 = APPLY,
	button2 = CLASS_TRIAL_THANKS_DIALOG_CLOSE_BUTTON,
	OnAccept = function() ReloadUI() end,
	whileDead = 1,
}

info.onMouseUp = function(self, btn)
	if btn == "LeftButton" then
		if scriptProfileStatus then
			ResetCPUUsage()
			module.loginTime = GetTime()
		end
		local before = gcinfo()
		collectgarbage("collect")
		print(format("|cff66C6FF%s:|r %s", U["Collect Memory"], formatMemory(before - gcinfo())))
		self:onEnter()
	elseif btn == "RightButton" and scriptProfileStatus then
		self.showMemory = not self.showMemory
		self:onEnter()
	elseif btn == "MiddleButton" then
		if GetCVarBool("scriptProfile") then
			SetCVar("scriptProfile", 0)
		else
			SetCVar("scriptProfile", 1)
		end

		if GetCVarBool("scriptProfile") == scriptProfileStatus then
			StaticPopup_Hide("CPUUSAGE")
		else
			StaticPopup_Show("CPUUSAGE")
		end
		self:onEnter()
	end
end
