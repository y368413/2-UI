local addonName, ns = ...
ns[1] = {}			-- M, Basement
ns[2] = {}			-- R, Config
ns[3] = {}			-- U, Locales
ns[4] = {}			-- I, Database

MaoRUIPerDB, MaoRUIDB = {}, {}
ShiGuangDB = ShiGuangDB or {}
ShiGuangPerDB = ShiGuangPerDB or {}

local M, R, U, I = unpack(ns)
local pairs, next, tinsert = pairs, next, table.insert
local min, max = math.min, math.max
local CombatLogGetCurrentEventInfo, GetPhysicalScreenSize = CombatLogGetCurrentEventInfo, GetPhysicalScreenSize

-- Events
local events = {}

local host = CreateFrame("Frame")
host:SetScript("OnEvent", function(_, event, ...)
	for func in pairs(events[event]) do
		if event == "COMBAT_LOG_EVENT_UNFILTERED" then
			func(event, CombatLogGetCurrentEventInfo())
		else
			func(event, ...)
		end
	end
end)

function M:RegisterEvent(event, func, unit1, unit2)
	if not events[event] then
		events[event] = {}
		if unit1 then
			host:RegisterUnitEvent(event, unit1, unit2)
		else
			host:RegisterEvent(event)
		end
	end

	events[event][func] = true
end

function M:UnregisterEvent(event, func)
	local funcs = events[event]
	if funcs and funcs[func] then
		funcs[func] = nil

		if not next(funcs) then
			events[event] = nil
			host:UnregisterEvent(event)
		end
	end
end

-- Modules
local modules, initQueue = {}, {}

function M:RegisterModule(name)
	if modules[name] then print("Module <"..name.."> has been registered.") return end
	local module = {}
	module.name = name
	modules[name] = module

	tinsert(initQueue, module)
	return module
end

function M:GetModule(name)
	if not modules[name] then print("Module <"..name.."> does not exist.") return end

	return modules[name]
end

-- Init
local function GetBestScale()
	local scale = max(.4, min(1.15, 768 / I.ScreenHeight))
	return M:Round(scale, 2)
end

function M:SetupUIScale(init)
	if MaoRUIDB["LockUIScale"] then MaoRUIDB["UIScale"] = GetBestScale() end
	local scale = MaoRUIDB["UIScale"]
	if init then
		local pixel = 1
		local ratio = 768 / I.ScreenHeight
		R.mult = (pixel / scale) - ((pixel - ratio) / scale)
	elseif not InCombatLockdown() then
		UIParent:SetScale(scale)
	end
end

local isScaling = false
local function UpdatePixelScale(event)
	if isScaling then return end
	isScaling = true

	if event == "UI_SCALE_CHANGED" then
		I.ScreenWidth, I.ScreenHeight = GetPhysicalScreenSize()
	end
	M:SetupUIScale(true)
	M:SetupUIScale()

	isScaling = false
end

local function IncorrectExpansion()
	local f = CreateFrame("Frame", nil, UIParent)
	f:SetPoint("CENTER")
	f:SetSize(10, 10)
	local text = f:CreateFontString()
	text:SetPoint("CENTER")
	text:SetFont(STANDARD_TEXT_FONT, 43, "OUTLINE")
	text:SetText(U["IncorrectExpansion"])
end

M:RegisterEvent("PLAYER_LOGIN", function()
	if not I.isNewPatch then
		IncorrectExpansion()
		return
	end

	-- Initial
	M:SetupUIScale()
	M:RegisterEvent("UI_SCALE_CHANGED", UpdatePixelScale)
	M:SetSmoothingAmount(MaoRUIPerDB["UFs"]["SmoothAmount"])

	for _, module in next, initQueue do
		if module.OnLogin then
			module:OnLogin()
		else
			print("Module <"..module.name.."> does not loaded.")
		end
	end

	M.Modules = modules
end)

_G[addonName] = ns