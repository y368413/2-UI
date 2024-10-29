--## SavedVariables: HandyNotes_SuramarShalAranTelemancyDB
-- $Id: Constants.lua 53 2018-07-26 14:05:30Z arith $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
-- Libraries
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local SuramarShalAranTelemancy = {}
SuramarShalAranTelemancy.addon_name = "HandyNotes_SuramarShalAranTelemancy"

local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(SuramarShalAranTelemancy.addon_name)
SuramarShalAranTelemancy.descName = L["HandyNotes - Suramar & Shal'Aran Telemancy"]
SuramarShalAranTelemancy.description = L["Shows the telemancy between Shal'Aran and nodes in Suramar"]
SuramarShalAranTelemancy.pluginName = L["Suramar & Shal'Aran Telemancy"]

local constants = {}
SuramarShalAranTelemancy.constants = constants

constants.defaults = {
	profile = {
		show_npcs = true,
		icon_scale = 1.5,
		icon_alpha = 1.0,
		query_server = true,
		show_note = true,
		ignore_InOutDoor = false,
		show_telemetryLab = true,
		show_unspecifiedEntrances = true,
		show_specifiedEntrance = true,
		show_leyline = true,
		show_shalaran = true,
	},
	char = {
		hidden = {
			['*'] = {},
		},
	},
}

local OBJECTICONS = "Interface\\MINIMAP\\OBJECTICONS"
constants.icon_texture = {
	flight = "Interface\\MINIMAP\\TRACKING\\FlightMaster",
	yellowButton 	= {
			icon = OBJECTICONS,
			tCoordLeft = 0.125, tCoordRight = 0.25, tCoordTop = 0.5, tCoordBottom = 0.625 },
	portal 		= {
			icon = OBJECTICONS,
			tCoordLeft = 0.125, tCoordRight = 0.25, tCoordTop = 0.875, tCoordBottom = 1 },
	door = "Interface\\MINIMAP\\Suramar_Door_Icon",
}

-- Define the default icon here
constants.defaultIcon = constants.icon_texture["portal"]

constants.events = {
	"ZONE_CHANGED",
	"ZONE_CHANGED_INDOORS",
	-- Fires when stepping off of a world map object. 
	-- Appears to fire whenever the player has moved off of a structure 
	-- such as a bridge or building and onto terrain or another object.
	"NEW_WMO_CHUNK",
--	"CLOSE_WORLD_MAP",
};


-- $Id: Handler.lua 99 2022-03-13 17:32:31Z arithmandar $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
-- Libraries
local string = _G.string
local format, gsub = string.format, string.gsub
local next, wipe, pairs, select, type = next, wipe, pairs, select, type
local GameTooltip, GetSpellInfo, CreateFrame, UnitClass, UnitRace = _G.GameTooltip, _G.GetSpellInfo, _G.CreateFrame, _G.UnitClass, _G.UnitRace
--local UIDropDownMenu_CreateInfo, CloseDropDownMenus, UIDropDownMenu_AddButton, ToggleDropDownMenu = L_UIDropDownMenu_CreateInfo, L_CloseDropDownMenus, L_UIDropDownMenu_AddButton, L_ToggleDropDownMenu

local WorldMapTooltip = GameTooltip
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted

-- ----------------------------------------------------------------------------
-- AddOn namespace.
local LH = LibStub("AceLocale-3.0"):GetLocale("HandyNotes", false)
local AceDB = LibStub("AceDB-3.0")
-- UIDropDownMenu
--local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local addon = LibStub("AceAddon-3.0"):NewAddon(SuramarShalAranTelemancy.addon_name, "AceEvent-3.0")
addon.constants = SuramarShalAranTelemancy.constants
addon.constants.addon_name = SuramarShalAranTelemancy.addon_name

addon.descName 		= SuramarShalAranTelemancy.descName
addon.description 	= SuramarShalAranTelemancy.description
addon.pluginName 	= SuramarShalAranTelemancy.pluginName

addon.Name = "HandyNotes_SuramarShalAranTelemancy"
_G.HandyNotes_SuramarShalAranTelemancy = addon

local profile

-- //////////////////////////////////////////////////////////////////////////
local function work_out_texture(point)
	if (point.type and SuramarShalAranTelemancy.constants.icon_texture[point.type]) then
		return SuramarShalAranTelemancy.constants.icon_texture[point.type]
	-- use the icon specified in point data
	elseif (point.icon) then
		return point.icon
	else
		return SuramarShalAranTelemancy.constants.defaultIcon
	end
end

local get_point_info = function(point)
	local icon
	if point then
		local label = point.label or UNKNOWN
		if (point.type and point.type == "portal" and point.quest) then
			if IsQuestFlaggedCompleted(point.quest) then
				icon = work_out_texture(point)
			else
				local info = C_Texture.GetAtlasInfo("MagePortalHorde")
				icon = {
					icon = info.file,
					tCoordLeft = info.leftTexCoord,
					tCoordRight = info.rightTexCoord,
					tCoordTop = info.topTexCoord,
					tCoordBottom = info.bottomTexCoord,
				}
			end
		elseif (point.type and point.type == "door") then
			if (not point.scale) then point.scale = 0.8 end
			if (not point.alpha) then point.alpha = 0.8 end
			icon = work_out_texture(point)
		else
			icon = work_out_texture(point)
		end

		return label, icon, point.scale, point.alpha
	end
end

local get_point_info_by_coord = function(uMapID, coord)
	return get_point_info(SuramarShalAranTelemancy.DB.points[uMapID] and SuramarShalAranTelemancy.DB.points[uMapID][coord])
end

local function handle_tooltip(tooltip, point)
	if point then
		if (point.label) then
			if (point.npc and profile.query_server) then
				tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(point.npc))
			else
				tooltip:AddLine(point.label)
			end
		end
		if (point.spell) then
			local spellName = GetSpellInfo(point.spell)
			if (spellName) then
				tooltip:AddLine(spellName, 1, 1, 1, true)
			end
		end
		if (point.note and profile.show_note) then
			tooltip:AddLine("("..point.note..")", nil, nil, nil, true)
		end
	else
		tooltip:SetText(UNKNOWN)
	end
	tooltip:Show()
end

local handle_tooltip_by_coord = function(tooltip, uMapID, coord)
	return handle_tooltip(tooltip, SuramarShalAranTelemancy.DB.points[uMapID] and SuramarShalAranTelemancy.DB.points[uMapID][coord])
end

-- //////////////////////////////////////////////////////////////////////////
local PluginHandler = {}
local info = {}

function PluginHandler:OnEnter(uMapID, coord)
	local tooltip = self:GetParent() == WorldMapFrame:GetCanvas() and WorldMapTooltip or GameTooltip
	if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end
	handle_tooltip_by_coord(tooltip, uMapID, coord)
end

function PluginHandler:OnLeave(uMapID, coord)
	if self:GetParent() == WorldMapFrame:GetCanvas() then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end

local function hideNode(button, uMapID, coord)
	SuramarShalAranTelemancy.hidden[uMapID][coord] = true
	addon:Refresh()
end

local function closeAllDropdowns()
	CloseDropDownMenus(1)
end

local function addTomTomWaypoint(button, uMapID, coord)
	if TomTom then
		local x, y = HandyNotes:getXY(coord)
		TomTom:AddWaypoint(uMapID, x, y, {
			title = get_point_info_by_coord(uMapID, coord),
			persistent = nil,
			minimap = true,
			world = true
		})
	end
end

do
	local currentMapID = nil
	local currentCoord = nil
	local function generateMenu(button, level)
		if (not level) then return end
		if (level == 1) then
			-- Create the title of the menu
			info = UIDropDownMenu_CreateInfo()
			info.isTitle 		= true
			info.text 		= "HandyNotes - " ..addon.pluginName
			info.notCheckable 	= true
			UIDropDownMenu_AddButton(info, level)

			if TomTom then
				-- Waypoint menu item
				info = UIDropDownMenu_CreateInfo()
				info.text = LH["Add this location to TomTom waypoints"]
				info.notCheckable = true
				info.func = addTomTomWaypoint
				info.arg1 = currentMapID
				info.arg2 = currentCoord
				UIDropDownMenu_AddButton(info, level)
			end

			-- Hide menu item
			info = UIDropDownMenu_CreateInfo()
			info.text		= HIDE 
			info.notCheckable 	= true
			info.func		= hideNode
			info.arg1		= currentMapID
			info.arg2		= currentCoord
			UIDropDownMenu_AddButton(info, level)

			-- Close menu item
			info = UIDropDownMenu_CreateInfo()
			info.text		= CLOSE
			info.func		= closeAllDropdowns
			info.notCheckable 	= true
			UIDropDownMenu_AddButton(info, level)
		end
	end
	--local HL_Dropdown = CreateFrame("Frame", SuramarShalAranTelemancy.addon_name.."DropdownMenu")
	local HL_Dropdown = Create_UIDropDownMenu(SuramarShalAranTelemancy.addon_name.."DropdownMenu")
	HL_Dropdown.displayMode = "MENU"
	HL_Dropdown.initialize = generateMenu

	function PluginHandler:OnClick(button, down, uMapID, coord)
		if (button == "RightButton" and not down) then
			currentMapID = uMapID
			currentCoord = coord
			ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
		end
	end
end

do
	-- This is a custom iterator we use to iterate over every node in a given zone
	local currentMapID = nil
	local function iter(t, prestate)
		if not t then return nil end
		local state, value = next(t, prestate)
		while state do -- Have we reached the end of this zone?
			if value and SuramarShalAranTelemancy:ShouldShow(state, value, currentMapID) then
				local label, icon, scale, alpha = get_point_info(value)
				scale = (scale or 1) * (icon and icon.scale or 1) * profile.icon_scale
				alpha = (alpha or 1) * (icon and icon.alpha or 1) * profile.icon_alpha
				return state, nil, icon, scale, alpha
			end
			state, value = next(t, state) -- Get next data
		end
		return nil, nil, nil, nil, nil, nil
	end
	function PluginHandler:GetNodes2(uMapID, minimap)
		currentMapID = uMapID
		return iter, SuramarShalAranTelemancy.DB.points[uMapID], nil
	end
	function SuramarShalAranTelemancy:ShouldShow(coord, point, currentMapID)
		if (SuramarShalAranTelemancy.hidden[currentMapID] and SuramarShalAranTelemancy.hidden[currentMapID][coord]) then
			return false
		end
		if (point.dungeonLevel and point.dungeonLevel ~= currentLevel) then
			return false
		end
		if (point.hide_indoor and not profile.ignore_InOutDoor and IsIndoors()) then
			return false
		end
		if (point.hide_outdoor and not profile.ignore_InOutDoor and IsOutdoors()) then
			return false
		end
		if (point.isTelemetryLabRelated and not profile.show_telemetryLab) then
			return false
		end
		if (point.isUnspecifiedEntrance and not profile.show_unspecifiedEntrances) then
 			return false
		end
		if (point.leyline and not profile.show_leyline) then
			return false
		end
		if (point.shalaran and not profile.show_shalaran) then
			return false
		end
		if (point.type and point.type == "door" and not point.quest and not point.isTelemetryLabRelated and not point.isUnspecifiedEntrance and not point.leyline and not profile.show_specifiedEntrance) then
			return false
		end
		if (point.hide_after and IsQuestFlaggedCompleted(point.hide_after)) then
			return false
		end
		if (point.hide_before and not IsQuestFlaggedCompleted(point.hide_before)) then
			return false
		end
		-- this will check if any node is for specific class
		if (point.class and point.class ~= select(2, UnitClass("player"))) then
			return false
		end
		-- this will check if any node is for specific race
		if (point.class and point.class ~= select(2, UnitRace("player"))) then
			return false
		end
		return true
	end
end

-- //////////////////////////////////////////////////////////////////////////
function addon:OnInitialize()
	self.db = AceDB:New(SuramarShalAranTelemancy.addon_name.."DB", SuramarShalAranTelemancy.constants.defaults)
	
	profile = self.db.profile
	SuramarShalAranTelemancy.db = profile
	SuramarShalAranTelemancy.hidden = self.db.char.hidden

	-- Initialize database with HandyNotes
	HandyNotes:RegisterPluginDB(addon.pluginName, PluginHandler, SuramarShalAranTelemancy.config.options)
end

function addon:OnEnable()
	for key, value in pairs( addon.constants.events ) do
		self:RegisterEvent( value );
	end
end

function addon:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", addon.pluginName)
end

function addon:ZONE_CHANGED()
	addon:Refresh()
end

function addon:ZONE_CHANGED_INDOORS()
	addon:Refresh()
end

function addon:NEW_WMO_CHUNK()
	addon:Refresh()
end
--[[
function addon:CLOSE_WORLD_MAP()
	closeAllDropdowns()
end
]]
-- //////////////////////////////////////////////////////////////////////////


-- $Id: Config.lua 23 2017-05-02 07:16:40Z arith $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs = _G.pairs
-- Libraries
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addon = LibStub("AceAddon-3.0"):GetAddon(SuramarShalAranTelemancy.addon_name)

local config = {}
SuramarShalAranTelemancy.config = config

config.options = {
	type = "group",
	name = addon.pluginName,
	desc = addon.description,
	get = function(info) return SuramarShalAranTelemancy.db[info[#info]] end,
	set = function(info, v)
		SuramarShalAranTelemancy.db[info[#info]] = v
		addon:SendMessage("HandyNotes_NotifyUpdate", addon.pluginName)
	end,
	args = {
		icon = {
			type = "group",
			name = L["Icon settings"],
			inline = true,
			order = 10,
			args = {
				desc = {
					name = L["These settings control the look and feel of the icon."],
					type = "description",
					order = 0,
				},
				icon_scale = {
					type = "range",
					name = L["Icon Scale"],
					desc = L["The scale of the icons"],
					min = 0.25, max = 2, step = 0.01,
					order = 20,
				},
				icon_alpha = {
					type = "range",
					name = L["Icon Alpha"],
					desc = L["The alpha transparency of the icons"],
					min = 0, max = 1, step = 0.01,
					order = 30,
				},
			},
		},
		display = {
			type = "group",
			name = L["What to display"],
			inline = true,
			order = 20,
			args = {
				desc = {
					name = L["These settings control what type of icons to be displayed."],
					type = "description",
					order = 0,
				},
				show_shalaran = {
					type = "toggle",
					name = L["Shal'Aran Portals"],
					desc = L["Show portals inside Shal'Aran"],
					order = 12,
				},
				show_telemetryLab = {
					type = "toggle",
					name = L["Telemetry Lab"],
					desc = L["Show Telemetry Lab related telemancies, mainly quest related from Oculeth's quest: \"The Delicate Art of Telemancy\"."],
					order = 13,
				},
				show_leyline = {
					type = "toggle",
					name = L["Leyline Entrances"],
					desc = L["Show entrances which lead to the leyline."],
					order = 14,
				},
				show_specifiedEntrance = {
					type = "toggle",
					name = L["Specified Entrances"],
					desc = L["Show the entrances which lead to known caves or space."],
					order = 15,
				},
				show_unspecifiedEntrances = {
					type = "toggle",
					name = L["Unspecified Entrances"],
					desc = L["Show the entrances which are not specified more precisely."],
					order = 16,
				},
			},
		},
		plugin_config = {
			type = "group",
			name = L["AddOn Settings"],
			inline = true,
			order = 30,
			args = {
				query_server = {
					type = "toggle",
					name = L["Query from server"],
					desc = L["Send query request to server to lookup NPC's localized name. May be a little bit slower for the first time lookup but would be very fast once the name is found and cached."],
					order = 10,
				},
				show_note = {
					type = "toggle",
					name = L["Show note"],
					desc = L["Show the node's additional notes when it's available."],
					order = 11,
				},
				ignore_InOutDoor = {
					type = "toggle",
					name = L["Ignore in-/out-door"],
					desc = L["Ignore whether it is currently indoor or outdoor, show all nodes."],
					order = 12,
				},
				unhide = {
					type = "execute",
					name = L["Reset hidden nodes"],
					desc = L["Show all nodes that you manually hid by right-clicking on them and choosing \"hide\"."],
					func = function()
						for map,coords in pairs(SuramarShalAranTelemancy.hidden) do
							wipe(coords)
						end
						addon:Refresh()
					end,
					order = 50,
				},
			},
		},
	},
}



-- $Id: DB.lua 99 2022-03-13 17:32:31Z arithmandar $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs = _G.pairs;
-- Libraries
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------

local function GetLocaleLibBabble(typ)
	local rettab = {}
	local tab = LibStub(typ):GetBaseLookupTable()
	local loctab = LibStub(typ):GetUnstrictLookupTable()
	for k,v in pairs(loctab) do
		rettab[k] = v;
	end
	for k,v in pairs(tab) do
		if not rettab[k] then
			rettab[k] = v;
		end
	end
	return rettab;
end
local BZ = GetLocaleLibBabble("LibBabble-SubZone-3.0");

local DB = {}

SuramarShalAranTelemancy.DB = DB

DB.points = {
	--[[ structure:
	[mapID] = { -- "_terrain1" etc will be stripped from attempts to fetch this
		[coord] = {
			label = [string], 		-- label: text that'll be the label, optional
			npc = [id], 				-- related npc id, used to display names in tooltip
			type = [string], 			-- the pre-define icon type which can be found in Constant.lua
			class = [CLASS NAME],		-- specified the class name so that this node will only be available for this class
			note=[string],			-- additional notes for this node
		},
	},
	--]]
	[680] = { -- Suramar
		-- Class specified nodes
		[33084820] = { -- Warrior
			spell = 192085,
			type = "portal", 
			scale = 0.8,
			class = "WARRIOR", 
		},
		[33435044] = { -- Mage
			label = L["Teleportation Nexus"],
			note = format(L["Portal to %s"], BZ["Hall of the Guardian"]), 
			type = "portal", 
			scale = 0.8,
			class = "MAGE" 
		},
		[70207105] = { -- Hunter
			label = L["Great Eagle"], 
			npc = 109572, 
			type = "flight", 
			class = "HUNTER" 
		},
		[41328282] = { -- Hunter
			label = L["Great Eagle"], 
			npc = 109572, 
			type = "flight", 
			class = "HUNTER" 
		},
		-- Nightborne
		[57968657] = {
			label = BZ["Shal'Aran"],
			note = format(L["Portal to %s"], BZ["Shal'Aran"]), 
			type = "portal", 
			scale = 0.5,
			race = "Nightborne" 
		},
		[58188733] = {
			label = BZ["Orgrimmar"],
			note = format(L["Portal to %s"], BZ["Orgrimmar"]), 
			type = "portal", 
			scale = 0.5,
			race = "Nightborne" 
		},
		[58668762] = {
			label = BZ["Dalaran"],
			note = format(L["Portal to %s"], BZ["Dalaran"]), 
			type = "portal", 
			scale = 0.5,
			race = "Nightborne" 
		},
		
		-- Common nodes
		-- Ruins of Elune'eth
		[36094727] = {  
			quest = 40956, 
			label = BZ["Ruins of Elune'eth"], 
			type = "portal", 
			hide_before = 40956, 
			hide_indoor = true, -- Ruins of Elune'eth node is a bit overlaped with Shal'Aran, so hide indoor would be better
		},
		[36344493] = {  
			quest = 40956, 
			label = format(L["Portal to %s"], BZ["Ruins of Elune'eth"]), 
			type = "portal", 
			shalaran = true,
			hide_before = 40956, 
			hide_outdoor = true,
			scale = 0.6,
		},
		-- Falanaar
		[22903580] = { -- Falanaar has another map, so this is the entrance in Suramar map
			quest = 42230, 
			type = "door",
			label = BZ["Falanaar"],
			note = L["Entrance"].." - "..BZ["Falanaar"].."\n"..format(L["Portal to %s"], BZ["Shal'Aran"]), 
			hide_before = 42228, 
			--hide_indoor = true,
		}, 
		[35894555] = { 
			quest = 42230, 
			label = format(L["Portal to %s"], BZ["Falanaar"]), 
			type = "portal", 
			shalaran = true,
			hide_before = 42228, 
			hide_outdoor = true, 
			scale = 0.6,
		}, 
		-- Waning Crescent
		[47748138] = { 
			quest = 42487, 
			label = BZ["The Waning Crescent"], 
			type = "portal", 
			hide_after = 43569, 
			hide_before = 42486, 
		}, 
		[36504474] = { 
			quest = 42487, 
			label = format(L["Portal to %s"], BZ["The Waning Crescent"]), 
			type = "portal", 
			shalaran = true,
			hide_after = 43569, 
			hide_before = 42486, 
			hide_outdoor = true, 
			scale = 0.6,
		}, 
		-- Twilight Vineyards
		[64006043] = { 
			quest = 44084, 
			label = BZ["Twilight Vineyards"], 
			type = "portal", 
			hide_before = 42838, 
		}, 
		[36944500] = {
			quest = 44084, 
			label = format(L["Portal to %s"], BZ["Twilight Vineyards"]), 
			type = "portal", 
			shalaran = true,
			hide_before = 42838, 
			hide_outdoor = true,
			scale = 0.6,
		}, 
		-- Evermoon Terrace
		[51997875] = { 
			quest = 42889, 
			label = BZ["Evermoon Terrace"], 
			type = "portal", 
			hide_before = 43569, 
		}, 
		[36504475] = {
			quest = 42889, 
			label = format(L["Portal to %s"], BZ["Evermoon Terrace"]), 
			type = "portal", 
			shalaran = true,
			hide_before = 43569, 
			hide_outdoor = true,
			scale = 0.6,
		}, 
		-- Astravar Harbor
		[54486944] = { 
			quest = 44740, 
			label = BZ["Astravar Harbor"], 
			type = "portal", 
			hide_before = 44738, 
		}, 
		[36764504] = { 
			quest = 44740, 
			label = format(L["Portal to %s"], BZ["Astravar Harbor"]), 
			type = "portal", 
			shalaran = true,
			hide_before = 44738, 
			hide_outdoor = true,
			scale = 0.6,
		}, 
		-- Moon Guard Stronghold
		[30831103] = { 
			quest = 43808, 
			label = BZ["Moonfall Overlook"], 
			type = "portal", 
			hide_before = 40956, 
		}, 
		[36004524] = {
			quest = 43808, 
			label = format(L["Portal to %s"], BZ["Moonfall Overlook"]), 
			type = "portal", 
			shalaran = true,
			hide_before = 40956, 
			hide_outdoor = true,
			scale = 0.6,
		}, 
		-- Moon Guard (entrance)
		[27802230] = { 
			quest = 43808, 
			type = "door",
			label = BZ["Moonfall Overlook"], 
			note = L["Entrance"],
			hide_before = 40956, 
		}, 
		-- Tel'anor
		[42023523] = { 
			quest = 43809, 
			label = BZ["Tel'anor"], 
			type = "portal", 
			hide_before = 40956, 
		},
		[36924466] = { 
			quest = 43809, 
			label = format(L["Portal to %s"], BZ["Tel'anor"]), 
			type = "portal", 
			shalaran = true,
			hide_before = 40956, 
			hide_outdoor = true,
			scale = 0.6,
		},
		-- Sanctum of Order
		[43406057] = { 
			quest = 43813, 
			label = BZ["Sanctum of Order"], 
			type = "portal", 
			hide_before = 40956, 
			hide_outdoor = true, -- hide outdoor as we will show the entrance to Sanctum of Order
		}, 
		[36694465] = { 
			quest = 43813, 
			label = format(L["Portal to %s"], BZ["Sanctum of Order"]), 
			type = "portal", 
			shalaran = true,
			hide_before = 40956, 
			hide_outdoor = true,
			scale = 0.6,
		}, 
		[43366232] = {
			quest = 43813, 
			type = "door",
			label = BZ["Sanctum of Order"], 
			note = L["Entrance"].." - "..BZ["The Grand Promenade"].."\n"..format(L["Portal to %s"], BZ["Shal'Aran"]),
			hide_before = 40956, 
			hide_indoor = true,
		}, 
		[45856450] = {
			quest = 43813, 
			type = "door",
			label = BZ["Sanctum of Order"], 
			note = L["Entrance"].." - "..BZ["Sanctum of Order"].."\n"..format(L["Portal to %s"], BZ["Shal'Aran"]),
			hide_before = 40956, 
			hide_indoor = true,
		}, 
		-- Lunastre Estate
		[43697924] = { 
			quest = 43811, 
			label = BZ["Lunastre Estate"], 
			type = "portal", 
			hide_before = 40956, 
		}, 
		[36154504] = { 
			quest = 43811, 
			label = format(L["Portal to %s"], BZ["Lunastre Estate"]), 
			type = "portal", 
			shalaran = true,
			hide_before = 40956, 
			hide_outdoor = true,
			scale = 0.6,
		}, 
		-- Felsoul Hold
		[35808210] = { -- Felsoul Hold has another map, so here we show the entrance of Felsoul Hold
			quest = 41575, 
			type = "door",
			label = BZ["Felsoul Hold"], 
			note = L["Entrance"].." - "..BZ["Felsoul Hold"].."\n"..format(L["Portal to %s"], BZ["Shal'Aran"]), 
			hide_before = 40956, 
		}, 
		[36104574] = { 
			quest = 41575, 
			label = format(L["Portal to %s"], BZ["Felsoul Hold"]), 
			type = "portal", 
			shalaran = true,
			hide_before = 40956, 
			hide_outdoor = true,
			scale = 0.6,
		}, 
		-- Oculeth's related telemancies
		[49414689] = {
			quest = 40011, -- quest: Oculeth's Workshop
			label = BZ["Oculeth's Workshop"],
			type = "portal",
			note = L["Telemancy to: \n  o Garden\n  - Test Chamber"],
			hide_before = 42229, -- quest: Shal'Aran
			isTelemetryLabRelated = true,
		},
		[55793973] = {
			quest = 40011, -- quest: The Delicate Art of Telemancy. The actual quest ID is 40747 but this node should be useful and available once completed 40011.
			label = BZ["Warpwind Cliffs"].." - "..L["Garden"],
			note = L["Telemancy to: \n  o Fountain\n  o Warp Lab\n  - Library"],
			type = "portal",
			hide_before = 40011, -- quest: Shal'Aran. 
			isTelemetryLabRelated = true,
		},
		[54244446] = {
			quest = 40011, -- quest: The Delicate Art of Telemancy. The actual quest ID is 40747 but this node should be useful and available once completed 40011.
			label = BZ["Warpwind Cliffs"].." - "..L["Fountain"],
			note = L["Telemancy to: \n  o Telemetry Lab\n  o Garden\n  x Breakfast Nook"],
			type = "portal",
			hide_before = 40011, -- quest: Shal'Aran. 
			isTelemetryLabRelated = true,
		},
		[53083682] = {
			quest = 40011, -- quest: The Delicate Art of Telemancy. The actual quest ID is 40747 but this node should be useful and available once completed 40011.
			label = BZ["Warpwind Cliffs"].." - "..L["Telemetry Lab"],
			note = L["Telemancy to: \n  o Fountain"],
			type = "portal",
			hide_before = 40011, -- quest: Shal'Aran. 
			isTelemetryLabRelated = true,
		},
		[52134511] = {
			quest = 40011, -- quest: The Delicate Art of Telemancy. The actual quest ID is 40747 but this node should be useful and available once completed 40011.
			label = BZ["Warpwind Cliffs"].." - "..L["Warp Lab"],
			note = L["Telemancy to: \n  o Workshop"],
			type = "portal",
			hide_before = 40011, -- quest: Shal'Aran. 
			isTelemetryLabRelated = true,
		},
		[59733667] = {
			quest = 40011, -- quest: The Delicate Art of Telemancy. The actual quest ID is 40747 but this node should be useful and available once completed 40011.
			label = BZ["Oculeth's Test Chamber"],
			note = L["Telemancy to: \n  o Workshop"],
			type = "portal",
			hide_before = 40011, -- quest: Shal'Aran. 
			isTelemetryLabRelated = true,
		},
		[56342741] = {
			quest = 40011, -- quest: The Delicate Art of Telemancy. The actual quest ID is 40747 but this node should be useful and available once completed 40011.
			label = BZ["The Drift"].." - "..L["Library"],
			type = "yellowButton",
			hide_before = 40011, -- quest: Shal'Aran. 
			isTelemetryLabRelated = true,
		},
		[55383549] = {
			quest = 40011, -- quest: The Delicate Art of Telemancy. The actual quest ID is 40747 but this node should be useful and available once completed 40011.
			label = BZ["Warpwind Cliffs"].." - "..L["Outside of The Drift"],
			note = L["Telemancy to: \n  - Storage"],
			type = "portal",
			hide_before = 40011, -- quest: Shal'Aran. 
			isTelemetryLabRelated = true,
		},
		[57973505] = {
			quest = 40011, -- quest: The Delicate Art of Telemancy. The actual quest ID is 40747 but this node should be useful and available once completed 40011.
			label = BZ["Warpwind Cliffs"].." - "..L["Storage"],
			note = L["Telemancy to: \n  - Garden"],
			type = "portal",
			hide_before = 40011, -- quest: Shal'Aran. 
			isTelemetryLabRelated = true,
		},
		-- End of Oculeth's related telemancies
		[55333463] = {
			label = BZ["The Drift"],
			note = L["Entrance"],
			type = "door",
			isTelemetryLabRelated = true,
		},
		-- Entrance of caves or special indoor space
		-- Leyline related entrance
		[41733894] = { -- Anora Hollow
			type = "door",
			leyline = true,
			label = format(L["Entrance of %s"], BZ["Ley Station Anora"]), 
		}, 
		[35632405] = { -- Moonwhisper Gulch
			type = "door",
			leyline = true,
			label = format(L["Entrance of %s"], BZ["Ley Station Moonfall"]), 
		}, 
		[24231934] = { -- Moon Guard
			type = "door",
			leyline = true,
			label = format(L["Entrance of %s"], BZ["Ley Station Aethenar"]), 
		}, 
		[59234273] = { -- Kel'balor
			type = "door",
			leyline = true,
			label = format(L["Entrance of %s"], BZ["Kel'balor"]), 
		}, 
		[65854188] = { -- Elor'shan
			type = "door",
			leyline = true,
			label = format(L["Entrance of %s"], BZ["Elor'shan"]), 
		}, 
		[29068463] = { 
			type = "door",
			leyline = true,
			label = format(L["Entrance of %s"], BZ["Halls of the Eclipse"]), 
		}, 
		[20555049] = { 
			type = "door",
			leyline = true,
			label = format(L["Entrance of %s"], BZ["Falanaar Tunnels"]), 
		}, 
		[21374317] = { 
			type = "door",
			leyline = true,
			label = format(L["Entrance of %s"], BZ["Falanaar Tunnels"]), 
		}, 
		[34678438] = { 
			type = "door",
			label = format(L["Entrance of %s"], BZ["The Arcway Vaults"]), 
		}, 
		[34437382] = { 
			type = "door",
			label = format(L["Entrance of %s"], BZ["Felmaw Cavern"]), 
		}, 
		[36587675] = { 
			type = "door",
			label = format(L["Entrance of %s"], BZ["The Fel Breach"]), 
		}, 
		[27167251] = { 
			type = "door",
			label = format(L["Entrance of %s"], BZ["Den of the Demented"]), 
		}, 
		[54714602] = { 
			type = "door",
			label = format(L["Entrance of %s"], BZ["Teloth'aran"]), 
		}, 
		[73046779] = { 
			type = "door",
			label = format(L["Entrance of %s"], BZ["Azuregale Cove"]), 
		}, 
		[35114753] = { 
			type = "door",
			label = format(L["Entrance of %s"], BZ["Shal'Aran"]), 
			scale = 0.8,
			alpha = 0.8,
		}, 
		-- Entrances of undefined places
		[49613380] = { 
			type = "door",
			label = L["Entrance"], 
			isUnspecifiedEntrance = true,
		}, 
		[35903449] = { 
			type = "door",
			label = L["Entrance"], 
			isUnspecifiedEntrance = true,
		}, 
		[23755104] = { 
			type = "door",
			label = L["Entrance"], 
			isUnspecifiedEntrance = true,
		}, 
		[24365092] = { 
			type = "door",
			label = L["Entrance"], 
			isUnspecifiedEntrance = true,
		}, 
		[30235497] = { 
			type = "door",
			label = L["Entrance"], 
			isUnspecifiedEntrance = true,
		}, 
		[38139062] = { 
			type = "door",
			label = L["Entrance"], 
			isUnspecifiedEntrance = true,
		}, 
		[42372999] = { 
			type = "door",
			label = L["Entrance"], 
			isUnspecifiedEntrance = true,
		}, 
		[40412933] = { 
			type = "door",
			label = L["Entrance"], 
			isUnspecifiedEntrance = true,
		}, 
		[19301895] = { 
			type = "door",
			label = L["Entrance"], 
			isUnspecifiedEntrance = true,
		}, 
		[25326382] = { 
			type = "door",
			label = L["Entrance"], 
			isUnspecifiedEntrance = true,
		}, 
		[28495615] = { 
			type = "door",
			label = L["Entrance"], 
			isUnspecifiedEntrance = true,
		}, 
		[61643958] = { 
			type = "door",
			label = L["Entrance"], 
			isUnspecifiedEntrance = true,
		}, 
	},
	[685] = { -- Falanaar / Fal'adore
		[40941368] = { 
			quest = 42230, 
			label = format(L["Portal to %s"], BZ["Shal'Aran"]),
			dungeonLevel = 32, 
			type = "portal", 
			hide_before = 42228,
			hide_outdoor = true,
		}, 
	},
	[683] = { -- Felsoul Hold / The Fel Breach
		[53733676] = { 
			quest = 41575, 
			label = format(L["Portal to %s"], BZ["Shal'Aran"]),
			dungeonLevel = 23,
			type = "portal", 
			hide_before = 40956,
			hide_outdoor = true,
		}, 
		[24609004] = { 
			type = "door",
			label = format(L["Entrance of %s"], BZ["Felsoul Hold"]), 
		}, 
		[29514112] = { 
			type = "door",
			label = format(L["Entrance of %s"], BZ["The Fel Breach"]), 
		}, 
	},
	[85] = { -- Orgrimmar
		[40077681] = {
			label = BZ["The Nighthold"],
			note = format(L["Portal to %s"], BZ["The Nighthold"]), 
			type = "portal", 
			scale = 0.8,
			race = "Nightborne" 
		},
	},
}
