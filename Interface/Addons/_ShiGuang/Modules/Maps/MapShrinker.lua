--[[

	The MIT License (MIT)

	Copyright (c) 2022 Lars Norberg

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.

--]]
-- Retrive addon folder name, and our local, private namespace.
local MapShrinker = {}
local string_format = string.format
local string_gsub = string.gsub

-- WoW API
-----------------------------------------------------------
local GetBestMapForUnit = C_Map and C_Map.GetBestMapForUnit
local GetFallbackWorldMapID = C_Map and C_Map.GetFallbackWorldMapID
local GetMapInfo = C_Map and C_Map.GetMapInfo
local GetPlayerMapPosition = C_Map and C_Map.GetPlayerMapPosition

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

local GetFormattedCoordinates = function(x, y)
	return 	string_gsub(string_format("|cfff0f0f0%.2f|r", x*100), "%.(.+)", "|cffa0a0a0.%1|r"),
			string_gsub(string_format("|cfff0f0f0%.2f|r", y*100), "%.(.+)", "|cffa0a0a0.%1|r")
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
local Coords_OnUpdate = function(self, elapsed)
	self.elapsed = self.elapsed + elapsed
	if (self.elapsed < .02) then 
		return 
	end 
	local pX, pY, cX, cY
	local mapID = GetBestMapForUnit("player")
	if (mapID) then 
		local mapPosObject = GetPlayerMapPosition(mapID, "player")
		if (mapPosObject) then 
			pX, pY = mapPosObject:GetXY()
		end 
	end 
	if (WorldMapFrame.ScrollContainer:IsMouseOver()) then 
		cX, cY = WorldMapFrame.ScrollContainer:GetNormalizedCursorPosition()
	end
	if ((pX) and (pY) and (pX > 0) and (pY > 0)) then 
		self.Player:SetFormattedText("%s:|r   %s, %s", PLAYER, GetFormattedCoordinates(pX, pY))
	else 
		self.Player:SetText(" ")
	end 
	if ((cX) and (cY) and (cX > 0) and (cY > 0) and (cX < 100) and (cY < 100)) then 
		self.Cursor:SetFormattedText("%s:|r   %s, %s", MOUSE_LABEL, GetFormattedCoordinates(cX, cY))
	else
		self.Cursor:SetText(" ")  --NOT_APPLICABLE
	end 
	self.elapsed = 0
end

local WorldMapFrame_StripOverlays = function()
	for _,object in pairs(WorldMapFrame.overlayFrames) do
		if (type(object) == "table") and (object.Icon) then
			local texture = object.Icon:GetTexture()
			if (texture) then
				object.Border:SetAlpha(0)
				object.Background:SetAlpha(0)
			else
				if (InCombatLockdown()) then
					MapShrinker:RegisterEvent("PLAYER_REGEN_ENABLED")
				else
					Strip(object)
					object.Text:Hide()
					object.Button:Hide()
				end
			end
		end
	end
end

local WorldMapFrame_UnstripOverlays = function()
	for _,object in pairs(WorldMapFrame.overlayFrames) do
		if (type(object) == "table") and (object.Icon) then
			local texture = object.Icon:GetTexture()
			if (texture) then
				object.Border:SetAlpha(1)
				object.Background:SetAlpha(1)
			else
				if (InCombatLockdown()) then
					MapShrinker:RegisterEvent("PLAYER_REGEN_ENABLED")
				else
					Unstrip(object)
					object.Text:Show()
					object.Button:Show()
				end
			end
		end
	end
end

local WorldMapFrame_Maximize = function(self)
	local WorldMapFrame = WorldMapFrame
	WorldMapFrame:SetParent(UIParent)
	WorldMapFrame:SetScale(1)

	--if (WorldMapFrame:GetAttribute("UIPanelLayout-area") ~= "center") then
		--SetUIPanelAttribute(WorldMapFrame, "area", "center")
	--end

	--if (WorldMapFrame:GetAttribute("UIPanelLayout-allowOtherPanels") ~= true) then
		--SetUIPanelAttribute(WorldMapFrame, "allowOtherPanels", true)
	--end

	WorldMapFrame:OnFrameSizeChanged()

	if (WorldMapFrame:GetMapID()) then
		WorldMapFrame.NavBar:Refresh()
	end

	WorldMapFrame.NavBar:Hide()
	WorldMapFrame.BorderFrame:SetAlpha(0)
	WorldMapFrameBg:Hide()
	
	WorldMapFrameCloseButton:ClearAllPoints()
	WorldMapFrameCloseButton:SetPoint("TOPLEFT", 21, -66)

	WorldMapFrame_StripOverlays()

	WorldMapFrame.MapShrinkerBackdrop:Show()
	WorldMapFrame.MapShrinkerBorder:Show()
	WorldMapFrame.MapShrinkerCoords:Show()
end

local WorldMapFrame_Minimize = function(self)
	local WorldMapFrame = WorldMapFrame
	if (not WorldMapFrame:IsMaximized()) then
		WorldMapFrame:ClearAllPoints()
		WorldMapFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 16, -94)

		WorldMapFrame.NavBar:Show()
		WorldMapFrame.BorderFrame:SetAlpha(1)
		WorldMapFrameBg:Show()
		
		WorldMapFrameCloseButton:ClearAllPoints()
		WorldMapFrameCloseButton:SetPoint("TOPRIGHT", 5, 5)

		WorldMapFrame_UnstripOverlays()

		WorldMapFrame.MapShrinkerBackdrop:Hide()
		WorldMapFrame.MapShrinkerBorder:Hide()
		WorldMapFrame.MapShrinkerCoords:Hide()
	end
end

local WorldMapFrame_SyncState = function(self)
	local WorldMapFrame = WorldMapFrame
	if (WorldMapFrame:IsMaximized()) then
		WorldMapFrame:ClearAllPoints()
		WorldMapFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 30)
	end
end

local WorldMapFrame_UpdateSize = function(self)
	local WorldMapFrame = WorldMapFrame
	local width, height = WorldMapFrame:GetSize()
	local scale = CalculateScale()
	local magicNumber = (1 - scale) * 100
	WorldMapFrame:SetSize((width * scale) - (magicNumber + 2), (height * scale) - 2)
	WorldMapFrame:OnCanvasSizeChanged()
end


-- Addon API
-----------------------------------------------------------
-- Custom check to see if we can run this addon at all. 
MapShrinker.IsIncompatible = function(self)
	if (not self.IsRetail) then
		return true
	end
end

MapShrinker.CreateCoordinates = function(self)
	local WorldMapFrame = WorldMapFrame
	if (not WorldMapFrame) then
		return
	end

	local coords = CreateFrame("Frame", nil, WorldMapFrame)
	coords:SetFrameStrata(WorldMapFrame.BorderFrame:GetFrameStrata())
	coords:SetFrameLevel(WorldMapFrame.BorderFrame:GetFrameLevel() + 10)
	coords.elapsed = 0
	WorldMapFrame.MapShrinkerCoords = coords

	local player = coords:CreateFontString()
	player:SetFontObject(NumberFont_Shadow_Med)
	player:SetFont(player:GetFont(), 14, "THINOUTLINE")
	player:SetShadowColor(0,0,0,0)
	player:SetTextColor(255/255, 234/255, 137/255)
	player:SetAlpha(.85)
	player:SetDrawLayer("OVERLAY")
	player:SetJustifyH("LEFT")
	player:SetJustifyV("BOTTOM")
	player:SetPoint("BOTTOMLEFT", WorldMapFrame.MapShrinkerBorder, "TOPLEFT", 32, -16)

	local cursor = coords:CreateFontString()
	cursor:SetFontObject(NumberFont_Shadow_Med)
	cursor:SetFont(cursor:GetFont(), 14, "THINOUTLINE")
	cursor:SetShadowColor(0,0,0,0)
	cursor:SetTextColor(255/255, 234/255, 137/255)
	cursor:SetAlpha(.85)
	cursor:SetDrawLayer("OVERLAY")
	cursor:SetJustifyH("RIGHT")
	cursor:SetJustifyV("BOTTOM")
	cursor:SetPoint("BOTTOMRIGHT", WorldMapFrame.MapShrinkerBorder, "TOPRIGHT", -32, -16)

	coords.Player = player
	coords.Cursor = cursor
	coords:SetScript("OnUpdate", Coords_OnUpdate)
end

MapShrinker.StyleWorldMap = function(self)
	QuestMapFrame:SetScript("OnHide", nil) 
	QuestMapFrame.VerticalSeparator:Hide()

	--WorldMapFrame.BlackoutFrame.Blackout:SetTexture(nil)
	--WorldMapFrame.BlackoutFrame:EnableMouse(false)
	--WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:SetParent(MapShrinker.UIHider)

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

	WorldMapFrame_StripOverlays()
end

MapShrinker.HookWorldMap = function(self)
	hooksecurefunc(WorldMapFrame, "Maximize", WorldMapFrame_Maximize)
	hooksecurefunc(WorldMapFrame, "Minimize", WorldMapFrame_Minimize)
	hooksecurefunc(WorldMapFrame, "SynchronizeDisplayState", WorldMapFrame_SyncState)
	hooksecurefunc(WorldMapFrame, "UpdateMaximizedSize", WorldMapFrame_UpdateSize)

	-- Do NOT use HookScript on the WorldMapFrame, 
	-- as it WILL taint it after the 3rd opening in combat.
	-- Super weird, but super important. Do it this way instead.
	-- *Note that this even though seemingly identical, 
	--  is in fact NOT the same taint as that occurring when
	--  a new quest item button is spawned in the tracker in combat.
	local WorldMapFrame_OnShow
	WorldMapFrame_OnShow = function(_, event, ...)
		local WorldMapFrame = WorldMapFrame
		if (WorldMapFrame:IsMaximized()) then
			WorldMapFrame:UpdateMaximizedSize()
			WorldMapFrame_Maximize()
		else
			WorldMapFrame_Minimize()
		end
		-- Noop it after the first run
		WorldMapFrame_OnShow = function() end
	end
	hooksecurefunc(WorldMapFrame, "Show", WorldMapFrame_OnShow)
end

MapShrinker.SetUpMap = function(self)
	if (self.Styled) then
		return
	end

	self:StyleWorldMap()
	self:HookWorldMap()
	self:CreateCoordinates()

	SetCVar("miniWorldMap", 0) 

	WorldMapFrameButton:UnregisterAllEvents()
	WorldMapFrameButton:SetParent(MapShrinker.UIHider)

	if (WorldMapFrame:IsMaximized()) then
		WorldMapFrame.MapShrinkerBackdrop:Show()
		WorldMapFrame.MapShrinkerBorder:Show()
		WorldMapFrame:UpdateMaximizedSize()
		WorldMapFrame_Maximize(WorldMapFrame)
	end

	self.Styled = true
end

-- Addon Core
-----------------------------------------------------------
-- Your event handler.
-- Any events you add should be handled here.
-- @input event <string> The name of the event that fired.
-- @input ... <misc> Any payloads passed by the event handlers.
MapShrinker.OnEvent = function(self, event, ...)
	if (event == "ADDON_LOADED") then
		local addon = ...
		if (addon == "Blizzard_WorldMap") then
			self:SetUpMap()
			self:UnregisterEvent("ADDON_LOADED")
		end
	elseif (event == "PLAYER_REGEN_ENABLED") then
		if (WorldMapFrame:IsMaximized()) then
			WorldMapFrame_StripOverlays()
		else
			WorldMapFrame_UnstripOverlays()
		end
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	end
end

-- Initialization.
-- This fires when the addon and its settings are loaded.
MapShrinker.OnInit = function(self)
	--if (self:IsIncompatible()) then return end

	-- Tell the environment what subfolder to find our media in.
	--self:SetMediaPath("Media")

	-- Create a frame to hide UI elements with.
	self.UIHider = CreateFrame("Frame", nil, UIParent)
	self.UIHider:SetAllPoints()
	self.UIHider:Hide()
end

-- Enabling.
-- This fires when most of the user interface has been loaded
-- and most data is available to the user.
MapShrinker.OnEnable = function(self)
	--if (self:IsIncompatible()) then return end
	if (C_AddOns.IsAddOnLoaded("Blizzard_WorldMap")) then
		self:SetUpMap()
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end


-- Setup the environment
-----------------------------------------------------------
(function(self)
	-- Event API
	-----------------------------------------------------------
	-- Proxy event registering to the addon namespace.
	-- The 'self' within these should refer to our proxy frame,
	-- which has been passed to this environment method as the 'self'.
	MapShrinker.RegisterEvent = function(_, ...) self:RegisterEvent(...) end
	MapShrinker.RegisterUnitEvent = function(_, ...) self:RegisterUnitEvent(...) end
	MapShrinker.UnregisterEvent = function(_, ...) self:UnregisterEvent(...) end
	MapShrinker.UnregisterAllEvents = function(_, ...) self:UnregisterAllEvents(...) end
	MapShrinker.IsEventRegistered = function(_, ...) self:IsEventRegistered(...) end

	-- Event Dispatcher and Initialization Handler
	-----------------------------------------------------------
	-- Assign our event script handler, 
	-- which runs our initialization methods,
	-- and dispatches event to the addon namespace.
	self:RegisterEvent("ADDON_LOADED")
	self:SetScript("OnEvent", function(self, event, ...) 
		if (event == "ADDON_LOADED") then
			-- Nothing happens before this has fired for your addon.
			-- When it fires, we remove the event listener 
			-- and call our initialization method.
			if ((...) == "_ShiGuang") then
				-- Delete our initial registration of this event.
				-- Note that you are free to re-register it in any of the 
				-- addon namespace methods. 
				self:UnregisterEvent("ADDON_LOADED")
				-- Call the initialization method.
				if (MapShrinker.OnInit) then
					MapShrinker:OnInit()
				end
				-- If this was a load-on-demand addon, 
				-- then we might be logged in already.
				-- If that is the case, directly run 
				-- the enabling method.
				if (IsLoggedIn()) then
					if (MapShrinker.OnEnable) then
						MapShrinker:OnEnable()
					end
				else
					-- If this is a regular always-load addon, 
					-- we're not yet logged in, and must listen for this.
					self:RegisterEvent("PLAYER_LOGIN")
				end
				-- Return. We do not wish to forward the loading event 
				-- for our own addon to the namespace event handler.
				-- That is what the initialization method exists for.
				return
			end
		elseif (event == "PLAYER_LOGIN") then
			-- This event only ever fires once on a reload, 
			-- and anything you wish done at this event, 
			-- should be put in the namespace enable method.
			self:UnregisterEvent("PLAYER_LOGIN")
			-- Call the enabling method.
			if (MapShrinker.OnEnable) then
				MapShrinker:OnEnable()
			end
			-- Return. We do not wish to forward this 
			-- to the namespace event handler.
			return 
		end
		-- Forward other events than our two initialization events
		-- to the addon namespace's event handler. 
		-- Note that you can always register more ADDON_LOADED
		-- if you wish to listen for other addons loading.  
		if (MapShrinker.OnEvent) then
			MapShrinker:OnEvent(event, ...) 
		end
	end)
end)((function() return CreateFrame("Frame", nil, WorldFrame) end)())
