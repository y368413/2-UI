local _, ns = ...
local M, R, U, I = unpack(ns)
if not R.Infobar.System then return end

local module = M:GetModule("Infobar")
local info = module:RegisterInfobar("System", R.Infobar.SystemPos)
local min, max, floor, mod, format, sort, select = math.min, math.max, math.floor, mod, string.format, table.sort, select
local GetFramerate, GetNetStats, GetTime, GetCVarBool, SetCVar = GetFramerate, GetNetStats, GetTime, GetCVarBool, SetCVar
local GetNumAddOns, GetAddOnInfo, IsShiftKeyDown, IsAddOnLoaded = GetNumAddOns, GetAddOnInfo, IsShiftKeyDown, IsAddOnLoaded
local UpdateAddOnCPUUsage, GetAddOnCPUUsage, ResetCPUUsage = UpdateAddOnCPUUsage, GetAddOnCPUUsage, ResetCPUUsage
local VIDEO_OPTIONS_ENABLED, VIDEO_OPTIONS_DISABLED, FRAMERATE_LABEL = VIDEO_OPTIONS_ENABLED, VIDEO_OPTIONS_DISABLED, FRAMERATE_LABEL

local usageTable, showMode, entered = {}, 0
local usageString = "%.1f Ms"

local function colorLatency(latency)
	if latency < 250 then
		return "|cff0CD809"..latency
	elseif latency < 500 then
		return "|cffE8DA0F"..latency
	else
		return "|cffD80909"..latency
	end
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

info.onUpdate = function(self, elapsed)
	self.timer = (self.timer or 0) + elapsed
	if self.timer > 1 then
			local fps = floor(GetFramerate())
			local _, _, latencyHome, latencyWorld = GetNetStats()
			local latency = max(latencyHome, latencyWorld)
			self.text:SetText(colorFPS(fps).."|rFps "..colorLatency(latency).."|rMs")
		if entered then self:onEnter() end

		self.timer = 0
	end
end

local function updateUsageTable()
	local numAddons = GetNumAddOns()
	if numAddons == #usageTable then return end

	wipe(usageTable)
	for i = 1, numAddons do
		usageTable[i] = {i, select(2, GetAddOnInfo(i)), 0}
	end
end

local function sortUsage(a, b)
	if a and b then
		return a[3] > b[3]
	end
end

local function updateUsage()
	UpdateAddOnCPUUsage()

	local total = 0
	for i = 1, #usageTable do
		local value = usageTable[i]
		value[3] = GetAddOnCPUUsage(value[1])
		total = total + value[3]
	end
	sort(usageTable, sortUsage)

	return total
end

local systemText = {
	[0] = "|cff55ff55"..U["Rotation"],
	[1] = "|cffff9900"..U["FPS"],
	[2] = "|cffffff55"..U["Latency"]
}

info.onEnter = function(self)
	entered = true
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0, -15)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(U["System"], 0,.6,1)
	GameTooltip:AddLine(" ")

	local scriptProfile = GetCVarBool("scriptProfile")
	if scriptProfile then
		updateUsageTable()
		local totalCPU = updateUsage()
		if totalCPU > 0 then
			local maxAddOns = R.Infobar.MaxAddOns
			local isShiftKeyDown = IsShiftKeyDown()
			local maxShown = isShiftKeyDown and #usageTable or min(maxAddOns, #usageTable)
			local numEnabled = 0
			for i = 1, #usageTable do
				local value = usageTable[i]
				if value and IsAddOnLoaded(value[1]) then
					numEnabled = numEnabled + 1
					if numEnabled <= maxShown then
						local r = value[3] / totalCPU
						local g = 1.5 - r
						GameTooltip:AddDoubleLine(value[2], format(usageString, value[3] / max(1, GetTime() - module.loginTime)), 1,1,1, r,g,0)
					end
				end
			end

			if not isShiftKeyDown and (numEnabled > maxAddOns) then
				local hiddenUsage = 0
				for i = (maxAddOns + 1), numEnabled do
					hiddenUsage = hiddenUsage + usageTable[i][3]
				end
				GameTooltip:AddDoubleLine(format("%d %s (%s)", numEnabled - maxAddOns, U["Hidden"], U["Hold Shift"]), format(usageString, hiddenUsage), .6,.8,1, .6,.8,1)
			end
			GameTooltip:AddLine(" ")
		end
	end

	local _, _, latencyHome, latencyWorld = GetNetStats()
	local fps = floor(GetFramerate())
	GameTooltip:AddDoubleLine(U["Home Latency"]..":", colorLatency(latencyHome).."|r Ms", .6,.8,1, 1,1,1)
	GameTooltip:AddDoubleLine(U["World Latency"]..":", colorLatency(latencyWorld).."|r Ms", .6,.8,1, 1,1,1)
	GameTooltip:AddDoubleLine(FRAMERATE_LABEL, colorFPS(fps).."|r Fps", .6,.8,1, 1,1,1)
	GameTooltip:AddDoubleLine(" ", I.LineString)
	if scriptProfile then
		GameTooltip:AddDoubleLine(" ", I.RightButton..U["ResetCPUUsage"].." ", 1,1,1, .6,.8,1)
	end
	GameTooltip:AddDoubleLine(" ", I.LeftButton..U["CPU Usage"]..": "..(scriptProfile and "|cff55ff55"..VIDEO_OPTIONS_ENABLED or "|cffff5555"..VIDEO_OPTIONS_DISABLED).." ", 1,1,1, .6,.8,1)
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

local status = GetCVarBool("scriptProfile")
info.onMouseUp = function(self, btn)
	local scriptProfile = GetCVarBool("scriptProfile")
	if btn == "RightButton" and scriptProfile then
		ResetCPUUsage()
		module.loginTime = GetTime()
	elseif btn == "MiddleButton" then
		MaoRUIDB["SystemInfoType"] = mod(MaoRUIDB["SystemInfoType"] + 1, 3)
	elseif btn == "LeftButton" then
		if scriptProfile then
			SetCVar("scriptProfile", 0)
		else
			SetCVar("scriptProfile", 1)
		end

		if GetCVarBool("scriptProfile") == status then
			StaticPopup_Hide("CPUUSAGE")
		else
			StaticPopup_Show("CPUUSAGE")
		end
	end
	self:onEnter()
end