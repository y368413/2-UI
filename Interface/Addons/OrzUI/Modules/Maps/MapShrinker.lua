--[[## Author: Lars Norberg ## Version: 1.0.37-Release--]]
local _, ns = ...
local M, R, U, I = unpack(ns)
local module = M:GetModule("Maps")

-- Retrive addon folder name, and our local, private namespace.
local MapShrinker = {}
-- Lua API
local ipairs = ipairs
local pairs = pairs
local select = select
local string_format = string.format
local string_gsub = string.gsub

-- WoW API
-----------------------------------------------------------
local CreateFrame = CreateFrame
local GetBestMapForUnit = C_Map and C_Map.GetBestMapForUnit
local GetFallbackWorldMapID = C_Map and C_Map.GetFallbackWorldMapID
local GetMapInfo = C_Map and C_Map.GetMapInfo
local GetPlayerMapPosition = C_Map and C_Map.GetPlayerMapPosition
local hooksecurefunc = hooksecurefunc
local InCombatLockdown = InCombatLockdown
local IsAddOnLoaded = C_AddOns.IsAddOnLoaded
local UIParent = UIParent


-- Utility Functions
-----------------------------------------------------------
local StripCache = {}
local Strip = function(object)
	local cache = StripCache[object]
	if (not cache) then
		cache = {}
		StripCache[object] = cache
	end
	for i = 1, object:GetNumRegions() do
		local region = select(i, object:GetRegions())
		if (region) and (region:GetObjectType() == "Texture") then
			-- Store this only once.
			if (not cache[region]) then
				cache[region] = region:GetTexture()
			end
			region:SetTexture(nil)
		end
	end
end
local Unstrip = function(object)
	local cache = StripCache[object]
	if (not cache) then
		return
	end
	for i = 1, object:GetNumRegions() do
		local region = select(i, object:GetRegions())
		if (region) and (region:GetObjectType() == "Texture") then
			if (cache[region]) then
				region:SetTexture(cache[region])
			end
		end
	end
end

local CalculateScale = function()
	local min, max = 0.65, 0.95 -- our own scale limits
	local uiMin, uiMax = 0.65, 1.15 -- blizzard uiScale slider limits
	local uiScale = UIParent:GetEffectiveScale() -- current blizzard uiScale
	-- Calculate and return a relative scale
	-- that is user adjustable through graphics settings,
	-- but still keeps itself within our intended limits.
	if (uiScale < uiMin) then
		return min
	elseif (uiScale > uiMax) then
		return max
	else
		return ((uiScale - uiMin) / (uiMax - uiMin)) * (max - min) + min
	end
end

-- Callbacks
-----------------------------------------------------------
local WorldMapFrame_Maximize = function()
	local WorldMapFrame = WorldMapFrame
	WorldMapFrame:SetParent(UIParent)
	WorldMapFrame:SetScale(1)

	if (WorldMapFrame:GetAttribute("UIPanelLayout-area") ~= "center") then
		SetUIPanelAttribute(WorldMapFrame, "area", "center")
	end

	if (WorldMapFrame:GetAttribute("UIPanelLayout-allowOtherPanels") ~= true) then
		SetUIPanelAttribute(WorldMapFrame, "allowOtherPanels", true)
	end

	WorldMapFrame:OnFrameSizeChanged()

	WorldMapFrame.NavBar:Hide()
	WorldMapFrame.BorderFrame:SetAlpha(0)
	WorldMapFrameBg:Hide()

	WorldMapFrameCloseButton:ClearAllPoints()
	WorldMapFrameCloseButton:SetPoint("TOPLEFT", 4, -70)

	WorldMapFrame.MapShrinkerBackdrop:Show()
	WorldMapFrame.MapShrinkerBorder:Show()
end

local WorldMapFrame_Minimize = function()
	local WorldMapFrame = WorldMapFrame
	if (not WorldMapFrame:IsMaximized()) then
		WorldMapFrame:ClearAllPoints()
		WorldMapFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 16, -94)

		WorldMapFrame.NavBar:Show()
		WorldMapFrame.BorderFrame:SetAlpha(1)
		WorldMapFrameBg:Show()

		WorldMapFrameCloseButton:ClearAllPoints()
		WorldMapFrameCloseButton:SetPoint("TOPRIGHT", 5, 5)

		--WorldMapFrame_UnstripOverlays()

		WorldMapFrame.MapShrinkerBackdrop:Hide()
		WorldMapFrame.MapShrinkerBorder:Hide()
	end
end

local WorldMapFrame_SyncState = function()
	local WorldMapFrame = WorldMapFrame
	if (WorldMapFrame:IsMaximized()) then
		WorldMapFrame:ClearAllPoints()
		WorldMapFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 30)
	end
end

local WorldMapFrame_UpdateMaximizedSize = function()
	local WorldMapFrame = WorldMapFrame
	local width, height = WorldMapFrame:GetSize()
	local scale = CalculateScale() + 0.1
	local magicNumber = (1 - scale) * 100
	WorldMapFrame:SetSize((width * scale) - (magicNumber + 2), (height * scale) - 2)

	-- This fails in Dragonflight at startup,
	-- uncertain what events or methods to safely call it after.
	if (MapShrinker.ClientMajor < 10) then
		WorldMapFrame:OnCanvasSizeChanged()
	end
end

MapShrinker.StyleWorldMap = function(self)
	if not R.db["Map"]["MapShrinker"] then return end
	local backdrop = CreateFrame("Frame", nil, WorldMapFrame, BackdropTemplateMixin and "BackdropTemplate")
	backdrop:Hide()
	backdrop:SetFrameLevel(WorldMapFrame:GetFrameLevel())
	backdrop:SetPoint("TOP", 0, 25-66)
	backdrop:SetPoint("LEFT", -25, 0)
	backdrop:SetPoint("BOTTOM", 0, -25)
	backdrop:SetPoint("RIGHT", 25, 0)
	backdrop:SetBackdrop({ bgFile = [[Interface\Tooltips\UI-Tooltip-Background]], insets = { left = 25, right = 25, top = 25, bottom = 25 }})
	backdrop:SetBackdropColor(0, 0, 0, .95)

	local border = CreateFrame("Frame", nil, WorldMapFrame, BackdropTemplateMixin and "BackdropTemplate")
	border:Hide()
	border:SetFrameLevel(WorldMapFrame:GetFrameLevel() + 10)
	border:SetAllPoints(backdrop)
	border:SetBackdrop({ edgeSize = 32, edgeFile = nil })
	border:SetBackdropBorderColor(.35, .35, .35, 1)

	WorldMapFrame.MapShrinkerBackdrop = backdrop
	WorldMapFrame.MapShrinkerBorder = border

	WorldMapFrame:EnableMouse(false)

	WorldMapFrame.BlackoutFrame.Blackout:SetTexture(nil)
	WorldMapFrame.BlackoutFrame:EnableMouse(false)
	WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:SetParent(MapShrinker.UIHider)

	for index,button in pairs(WorldMapFrame.overlayFrames) do
		if (type(button) == "table") then
			if (button.Icon) then
				local texture = button.Icon:GetTexture()
				if (texture) then
					button.Border:SetAlpha(0)
					button.Background:SetAlpha(0)
				else
					for i = 1, button:GetNumRegions() do
						local region = select(i, button:GetRegions())
						if (region and region:GetObjectType() == "Texture") then
							region:SetTexture(nil)
						end
					end
					if (button.Button) then
						button.Button:Hide()
					end
					if (button.Text) then
						button.Text:Hide()
					end
				end
			end
		end
	end

end

MapShrinker.SetUpMap = function(self)
	if not R.db["Map"]["MapShrinker"] then return end
	if (self.Styled) then return end
	self:StyleWorldMap()
	SetCVar("miniWorldMap", 0)
	hooksecurefunc(WorldMapFrame, "Maximize", WorldMapFrame_Maximize)
	hooksecurefunc(WorldMapFrame, "Minimize", WorldMapFrame_Minimize)
	hooksecurefunc(WorldMapFrame, "SynchronizeDisplayState", WorldMapFrame_SyncState)
	hooksecurefunc(WorldMapFrame, "UpdateMaximizedSize", WorldMapFrame_UpdateMaximizedSize)
	-- Button removed in WoW Retail 11.0.0.
	if (WorldMapFrameButton) then
		WorldMapFrameButton:UnregisterAllEvents()
		WorldMapFrameButton:SetParent(MapShrinker.UIHider)
		WorldMapFrameButton:Hide()
	end
	if (WorldMapFrame:IsMaximized()) then
		WorldMapFrame_UpdateMaximizedSize()
		WorldMapFrame_Maximize()
	end
	self.Styled = true
end

MapShrinker.OnEvent = function(self, event, ...)
	if not R.db["Map"]["MapShrinker"] then return end
	if (event == "ADDON_LOADED") then
		local addon = ...
		if (addon == "Blizzard_WorldMap") then
			self:SetUpMap()
			self:UnregisterEvent("ADDON_LOADED")
		end
	elseif (event == "PLAYER_ENTERING_WORLD") then
		self.inWorld = true
	end
end

MapShrinker.OnInit = function(self)
	if not R.db["Map"]["MapShrinker"] then return end
	-- Tell the environment what subfolder to find our media in.
	-- Create a frame to hide UI elements with.
	self.UIHider = CreateFrame("Frame", nil, UIParent)
	self.UIHider:SetAllPoints()
	self.UIHider:Hide()
end

MapShrinker.OnEnable = function(self)
	if not R.db["Map"]["MapShrinker"] then return end
	if (IsAddOnLoaded("Blizzard_WorldMap")) then
		self:SetUpMap()
	else
		self:RegisterEvent("ADDON_LOADED")
	end
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

-- Setup the environment-----------------------------------------------------------
(function(self)
	local currentClientPatch, currentClientBuild = GetBuildInfo()
	currentClientBuild = tonumber(currentClientBuild)
	local MAJOR,MINOR,PATCH = string.split(".", currentClientPatch)
	MapShrinker.IsRetail = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)
	MapShrinker.ClientMajor = tonumber(MAJOR)
	MapShrinker.ClientMinor = tonumber(MINOR)
	MapShrinker.ClientBuild = currentClientBuild
	MapShrinker.RegisterEvent = function(_, ...) self:RegisterEvent(...) end
	MapShrinker.RegisterUnitEvent = function(_, ...) self:RegisterUnitEvent(...) end
	MapShrinker.UnregisterEvent = function(_, ...) self:UnregisterEvent(...) end
	MapShrinker.UnregisterAllEvents = function(_, ...) self:UnregisterAllEvents(...) end
	MapShrinker.IsEventRegistered = function(_, ...) self:IsEventRegistered(...) end
	self:RegisterEvent("ADDON_LOADED")
	self:SetScript("OnEvent", function(self, event, ...)
	if not R.db["Map"]["MapShrinker"] then return end
		if (event == "ADDON_LOADED") then
			if ((...) == "OrzUI") then
				self:UnregisterEvent("ADDON_LOADED")
				if (MapShrinker.OnInit) then
					MapShrinker:OnInit()
				end
				if (IsLoggedIn()) then
					if (MapShrinker.OnEnable) then
						MapShrinker:OnEnable()
					end
				else
					self:RegisterEvent("PLAYER_LOGIN")
				end
				return
			end
		elseif (event == "PLAYER_LOGIN") then
			self:UnregisterEvent("PLAYER_LOGIN")
			if (MapShrinker.OnEnable) then
				MapShrinker:OnEnable()
			end
			return
		end
		if (MapShrinker.OnEvent) then
			MapShrinker:OnEvent(event, ...)
		end
	end)
end)((function() return CreateFrame("Frame", nil, WorldFrame) end)())