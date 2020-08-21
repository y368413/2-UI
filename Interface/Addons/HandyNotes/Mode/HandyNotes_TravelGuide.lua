local _G = getfenv(0)
local TravelGuide = {}
local constants = {}
TravelGuide.constants = constants

constants.defaults = {
	profile = {
		icon_scale = 1.5,
		icon_alpha = 1.0,
		query_server = true,
		show_portal = true,
		show_orderhall = true,
		show_warfront = true,
		show_tram = true,
		show_boat = true,
		show_aboat = true,
		show_zepplin = true,
		show_hzepplin = true,
--		show_others = true,
		show_note = true,
		easy_waypoint = true,
	},
	char = {
		hidden = {
			['*'] = {},
		},
	},
}

local left, right, top, bottom = GetObjectIconTextureCoords("4772") --MagePortalAlliance
local left2, right2, top2, bottom2 = GetObjectIconTextureCoords("4773") --MagePortalHorde
constants.icon_texture = {
	portal = {
					icon = [[Interface\MINIMAP\OBJECTICONSATLAS]],
					tCoordLeft = left,
					tCoordRight = right,
					tCoordTop = top,
					tCoordBottom = bottom,
				},
	mixedportal = "Interface\\AddOns\\HandyNotes\\Icons\\MixedPortal",
	boat 		= "Interface\\AddOns\\HandyNotes\\Icons\\Boat",
	aboat 		= "Interface\\AddOns\\HandyNotes\\Icons\\Boat_Alliance",
	tram  		= "Interface\\AddOns\\HandyNotes\\Icons\\Tram",
	flightmaster = "Interface\\MINIMAP\\TRACKING\\FlightMaster",	
	zeppelin 	= "Interface\\AddOns\\HandyNotes\\Icons\\Zeppelin",			
	hzeppelin 	= "Interface\\AddOns\\HandyNotes\\Icons\\Zeppelin_Horde",
	worderhall	= "Interface\\Icons\\ClassIcon_Warrior",
}	
--[[-------------------------------------NOT IN USE-------------------------------------
vehicle 		= "Interface\\MINIMAP\\Vehicle-Air-Occupied",
valliance		= "Interface\\MINIMAP\\Vehicle-Air-Alliance",
vhorde			= "Interface\\MINIMAP\\Vehicle-Air-Horde",
azeppelin 	= "Interface\\AddOns\\HandyNotes\\Icons\\Zeppelin_Alliance",
molemachine  = "Interface\\AddOns\\HandyNotes\\Icons\\Molemachine",
tram 		= {
			icon = "Interface\\MINIMAP\\OBJECTICONSATLAS",
			tCoordLeft = 0.532, tCoordRight = 0.561, tCoordTop = 0.935, tCoordBottom = 1 },
			tCoordLeft = 0.563, tCoordRight = 0.594, tCoordTop = 0.931, tCoordBottom = 0.993 },
portal 		= {
			icon = "Interface\\MINIMAP\\OBJECTICONS",
			tCoordLeft = 0.125, tCoordRight = 0.25, tCoordTop = 0.875, tCoordBottom = 1 },
			tCoordLeft = 0.532, tCoordRight = 0.561, tCoordTop = 0.935, tCoordBottom = 0.993 },
aboat 		= {
					icon = "Interface\\MINIMAP\\OBJECTICONSATLAS",
					tCoordLeft = 0.012, tCoordRight = 0.054, tCoordTop = 0.538, tCoordBottom = 0.622 },
	
hboat 		= {
					icon = "Interface\\MINIMAP\\OBJECTICONSATLAS",
					tCoordLeft = 0.012, tCoordRight = 0.055, tCoordTop = 0.665, tCoordBottom = 0.751 },	
hboat 		= "Interface\\AddOns\\HandyNotes\\Icons\\Boat_Horde",
	
]]--

local _G = getfenv(0)
-- Libraries
local string = _G.string
local format, gsub = string.format, string.gsub
local next, wipe, pairs, select, type = next, wipe, pairs, select, type
local GameTooltip, WorldMapTooltip, GetSpellInfo, CreateFrame, UnitClass = _G.GameTooltip, _G.WorldMapTooltip, _G.GetSpellInfo, _G.CreateFrame, _G.UnitClass
local UIDropDownMenu_CreateInfo, CloseDropDownMenus, UIDropDownMenu_AddButton, ToggleDropDownMenu = _G.UIDropDownMenu_CreateInfo, _G.CloseDropDownMenus, _G.UIDropDownMenu_AddButton, _G.ToggleDropDownMenu
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local LibStub = _G.LibStub
local pairs = _G.pairs
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes")
local AceDB = LibStub("AceDB-3.0")

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HandyNotes_TravelGuide = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_TravelGuide", "AceEvent-3.0", "AceTimer-3.0")

HandyNotes_TravelGuide.descName = L["HandyNotes: TravelGuide"]
HandyNotes_TravelGuide.description = L["Shows the portal, zepplin and boat locations on the World Map and the MiniMap."]
HandyNotes_TravelGuide.pluginName = L["TravelGuide"]

_G.HandyNotes_TravelGuide = HandyNotes_TravelGuide;

local notavailable = L["currently NOT available"]
--local available = L["currently available"] -- not in use

-- //////////////////////////////////////////////////////////////////////////
-- get creature's name from server
local mcache_tooltip = CreateFrame("GameTooltip", "HandyNotes_TravelGuide_mcacheToolTip", UIParent, "GameTooltipTemplate")
local creature_cache

-- activation code
local function getCreatureNamebyID(id)
	mcache_tooltip:SetOwner(UIParent, "ANCHOR_NONE")
	mcache_tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(id))
	creature_cache = _G["HandyNotes_TravelGuide_mcacheToolTipTextLeft1"]:GetText()
end
-- //////////////////////////////////////////////////////////////////////////
-- get questname from server
local MyScanningTooltip = CreateFrame("GameTooltip", "MyScanningTooltip", UIParent, "GameTooltipTemplate")
local QuestTitleFromID = setmetatable({}, { __index = function(t, id)
	MyScanningTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	MyScanningTooltip:SetHyperlink("quest:"..id)
	local title = MyScanningTooltipTextLeft1:GetText()
	MyScanningTooltip:Hide()
	if title and title ~= RETRIEVING_DATA then
		t[id] = title
		return title
	end
end })
-- //////////////////////////////////////////////////////////////////////////
local function work_out_texture(point)
	local icon_key
	
	if (point.boat) then icon_key = "boat" end
	if (point.aboat) then icon_key = "aboat" end
	if (point.zeppelin) then icon_key = "zeppelin" end
	if (point.hzeppelin) then icon_key = "hzeppelin" end
	if (point.portal) then icon_key = "portal" end
	if (point.mixedportal) then icon_key = "mixedportal" end
	if (point.orderhall) then icon_key = "portal" end
	if (point.worderhall) then icon_key = "worderhall" end
	if (point.tram) then icon_key = "tram" end
	if (point.flightmaster) then icon_key = "flightmaster" end

	if (icon_key and TravelGuide.constants.icon_texture[icon_key]) then
		return TravelGuide.constants.icon_texture[icon_key]
	elseif (point.type and TravelGuide.constants.icon_texture[point.type]) then
		return TravelGuide.constants.icon_texture[point.type]
	-- use the icon specified in point data
	elseif (point.icon) then
		return point.icon
	else
		return TravelGuide.constants.defaultIcon
	end
end

local left, right, top, bottom = GetObjectIconTextureCoords("4773") --MagePortalHorde
MagePortalHorde = {
				icon = [[Interface\MINIMAP\OBJECTICONSATLAS]],
				tCoordLeft = left,
				tCoordRight = right,
				tCoordTop = top,
				tCoordBottom = bottom,
}

local get_point_info = function(point)
	local icon
	if point then
		local label = point.label or point.label2 or UNKNOWN
		if ((point.portal or point.boat) == true and (point.lvl or point.quest)) then
		if (point.portal and point.quest) then
			if IsQuestFlaggedCompleted(point.quest) then
				icon = work_out_texture(point)
			else
				icon = MagePortalHorde	
			end
		end
		if (point.boat and point.quest) then
			if IsQuestFlaggedCompleted(point.quest) then
				icon = work_out_texture(point)
			else
				icon = "Interface\\AddOns\\HandyNotes\\Icons\\XBoatgrey"
			end
		end
		if (point.lvl) then
			if (UnitLevel("player") >= point.lvl) then
				icon = work_out_texture(point)
			else 
				icon = MagePortalHorde
			end
		end
		if (point.warfront and point.warfront == "arathi" and (UnitLevel("player") == 120)) then
			if ((astate == 1 or astate == 2) and point.faction and point.faction == "Alliance") then
				icon = work_out_texture(point)
			elseif ((astate == 3 or astate == 4) and point.faction and point.faction == "Horde") then
				icon = work_out_texture(point)
			else
				icon = MagePortalHorde
			end
		end
		if (point.warfront and point.warfront == "darkshore" and (UnitLevel("player") == 120)) then
			if ((dstate == 1 or dstate == 2) and point.faction and point.faction == "Alliance") then
				icon = work_out_texture(point)
			elseif ((dstate == 3 or dstate == 4) and point.faction and point.faction == "Horde") then
				icon = work_out_texture(point)
			else
				icon = MagePortalHorde
			end
		end
			else icon = work_out_texture(point)		
		end
			return label, label2, icon, point.scale, point.alpha
	end
end 

local get_point_info_by_coord = function(uMapID, coord)
	return get_point_info(TravelGuide.DB.points[uMapID] and TravelGuide.DB.points[uMapID][coord])
end

local function handle_tooltip(tooltip, point)
if ((astate == 4 and dstate == 4) and point.faction and point.faction == "Horde") then
--	warfrontnote = 
	asetnote = 0
	dsetnote = 0
elseif ((astate == 1 or astate == 2) and point.faction and point.faction == "Alliance") then
	warfrontnote = " ".."\n"..notavailable
	asetnote = 0
	dsetnote = 1
elseif ((astate == 3 or astate == 4) and point.faction and point.faction == "Horde") then
	warfrontnote = " ".."\n"..notavailable
	asetnote = 0
	dsetnote = 1
elseif ((dstate == 1 or dstate == 2) and point.faction and point.faction == "Alliance") then
	warfrontnote = notavailable.."\n".." "
	asetnote = 1
	dsetnote = 0
elseif ((dstate == 3 or dstate == 4) and point.faction and point.faction == "Horde") then
	warfrontnote = notavailable.."\n".." "
	asetnote = 1
	dsetnote = 0
else 
	warfrontnote = notavailable.."\n"..notavailable	
	asetnote = 1
	dsetnote = 1
end

	if point then
		if (point.label) then
			if (point.npc and profile.query_server) then
				tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(point.npc))
			else
				tooltip:AddLine(point.label)
			end
		end
		if (point.mixedportal) then
			if (profile.show_note) then
				tooltip:AddDoubleLine(point.label1, warfrontnote, nil,nil,nil,1,0,0)
			elseif (not profile.show_note) then
				tooltip:AddDoubleLine(point.label2, warfrontnote, nil,nil,nil,1,0,0)
			end	
		end	
		if (point.label1 and profile.show_note and not point.mixedportal) then
				tooltip:AddLine(point.label1)
			elseif (not point.mixedportal) then
				tooltip:AddLine(point.label2)
			end
		if (point.note and profile.show_note) then
			tooltip:AddLine("("..point.note..")", nil, nil, nil, false) --when true text is wrapping
		end
		if (point.spell) then
			local spellName = GetSpellInfo(point.spell)
			if (spellName) then
				tooltip:AddLine(spellName, 1, 1, 1)
			end
		end	
		if (point.warfront and point.warfront == "arathi" and asetnote == 1) then
			tooltip:AddLine(notavailable, 1, 0, 0)
		end
		if (point.warfront and point.warfront == "darkshore" and dsetnote == 1) then
			tooltip:AddLine(notavailable, 1, 0, 0)
		end
		if (point.lvl and UnitLevel("player") < point.lvl) then
			tooltip:AddLine(L["Requires at least player level: "]..point.lvl, 1, 0, 0, true)
		end
		if (point.quest and profile.query_server and IsQuestFlaggedCompleted(point.quest) ==false and QuestTitleFromID[point.quest] ~= nil) then
			tooltip:AddLine(L["Unlocked with quest: ["]..QuestTitleFromID[point.quest].."] (ID: "..point.quest..")",1,0,0)
		elseif (point.quest and profile.query_server and IsQuestFlaggedCompleted(point.quest) ==false and QuestTitleFromID[point.quest] == nil) then
			tooltip:AddLine(L["RETRIEVING DATA..."],1,0,1)	
		end
	else
		tooltip:SetText(UNKNOWN)
	end
	tooltip:Show()
end

local handle_tooltip_by_coord = function(tooltip, uMapID, coord)
	return handle_tooltip(tooltip, TravelGuide.DB.points[uMapID] and TravelGuide.DB.points[uMapID][coord])
end

-- //////////////////////////////////////////////////////////////////////////
local PluginHandler = {}
local info = {}

function PluginHandler:OnEnter(uMapID, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
	if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end
	handle_tooltip_by_coord(tooltip, uMapID, coord)
end

function PluginHandler:OnLeave(uMapID, coord)
	if self:GetParent() == WorldMapButton then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end

local function hideNode(button, uMapID, coord)
	TravelGuide.hidden[uMapID][coord] = true
	HandyNotes_TravelGuide:Refresh()
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
--		local spacer = {text='', disabled=true, notClickable=true, notCheckable=true}
			
			-- Create the title of the menu
			info = UIDropDownMenu_CreateInfo()
			info.isTitle 		= true
			info.text 		= "HandyNotes: " ..HandyNotes_TravelGuide.pluginName
			info.notCheckable 	= true
			UIDropDownMenu_AddButton(info, level)
			
--			UIDropDownMenu_AddButton(spacer, level)
			
			if TomTom and not profile.easy_waypoint then
				-- Waypoint menu item
				info = UIDropDownMenu_CreateInfo()
				info.text = L["Add to TomTom"]
				info.notCheckable = true
				info.func = addTomTomWaypoint
				info.arg1 = currentMapID
				info.arg2 = currentCoord
				UIDropDownMenu_AddButton(info, level)
			end

			-- Hide menu item
			info = UIDropDownMenu_CreateInfo()
			info.text		= L["Hide this node"] 
			info.notCheckable 	= true
			info.func		= hideNode
			info.arg1		= currentMapID
			info.arg2		= currentCoord
			UIDropDownMenu_AddButton(info, level)
			
--			UIDropDownMenu_AddButton(spacer, level)
			
			-- Close menu item
			info = UIDropDownMenu_CreateInfo()
			info.text		= CLOSE
			info.func		= closeAllDropdowns
			info.notCheckable 	= true
			UIDropDownMenu_AddButton(info, level)
		end
	end
	local HL_Dropdown = CreateFrame("Frame", "HandyNotes_TravelGuideDropdownMenu")
	HL_Dropdown.displayMode = "MENU"
	HL_Dropdown.initialize = generateMenu

	function PluginHandler:OnClick(button, down, uMapID, coord)
		if ((down or button ~= "RightButton") and profile.easy_waypoint) then
			return
		end
		if ((button == "RightButton" and not down) and not profile.easy_waypoint) then
			currentMapID = uMapID
			currentCoord = coord
			ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
		end
		if (IsControlKeyDown() and profile.easy_waypoint) then
			currentMapID = uMapID
			currentCoord = coord
			ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
		else
		if profile.easy_waypoint then
			addTomTomWaypoint(button, uMapID, coord)
		end
		end
	end
end

do

local currentMapID = nil
	local function iter(t, prestate)
		if not t then return nil end
		local state, value = next(t, prestate)
		while state do
			if value and TravelGuide:ShouldShow(state, value, currentMapID) then
				local label, label2, icon, quest, lvl, scale, alpha = get_point_info(value)
				scale = (scale or 1) * (icon and icon.scale or 1) * profile.icon_scale
				alpha = (alpha or 1) * (icon and icon.alpha or 1) * profile.icon_alpha
				return state, nil, icon, scale, alpha
			end
			state, value = next(t, state)
		end
		return nil, nil, nil, nil, nil, nil
	end
	function PluginHandler:GetNodes2(uMapID, minimap)
		currentMapID = uMapID
		return iter, TravelGuide.DB.points[uMapID], nil
	end
	function TravelGuide:ShouldShow(coord, point, currentMapID)
		if (TravelGuide.hidden[currentMapID] and TravelGuide.hidden[currentMapID][coord]) then
			return false
		end
		-- this will check if any node is for specific class
		if (point.class and point.class ~= select(2, UnitClass("player"))) then
			return false
		end
		-- this will check if any node is for specific faction
		if (point.faction and point.faction ~= select(1, UnitFactionGroup("player"))) then
			return false
		end
		if (point.portal and not TravelGuide.db.show_portal) then return false; end
		if (point.orderhall and not TravelGuide.db.show_orderhall) then return false; end
		if (point.worderhall and not TravelGuide.db.show_orderhall) then return false; end
		if (point.warfront and not TravelGuide.db.show_warfront) then return false; end
		if (point.mixedportal and not TravelGuide.db.show_warfront) then return false; end
		if (point.flightmaster and not TravelGuide.db.show_orderhall) then return false; end
		if (point.tram and not TravelGuide.db.show_tram) then return false; end
		if (point.boat and not TravelGuide.db.show_boat) then return false; end
		if (point.aboat and not TravelGuide.db.show_aboat) then return false; end
		if (point.zeppelin and not TravelGuide.db.show_zepplin) then return false; end
		if (point.hzeppelin and not TravelGuide.db.show_hzepplin) then return false; end
		return true
	end
end

-- //////////////////////////////////////////////////////////////////////////
function HandyNotes_TravelGuide:OnInitialize()
	self.db = AceDB:New("HandyNotes_TravelGuideDB", TravelGuide.constants.defaults)

	profile = self.db.profile
	TravelGuide.db = profile
	TravelGuide.hidden = self.db.char.hidden

	-- Initialize database with HandyNotes
	HandyNotes:RegisterPluginDB(HandyNotes_TravelGuide.pluginName, PluginHandler, TravelGuide.config.options)
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "WorldEnter");
end

function HandyNotes_TravelGuide:WorldEnter()
    self:UnregisterEvent("PLAYER_ENTERING_WORLD");
    self:ScheduleTimer("RegisterWithHandyNotes", 2);
	C_Timer.After(5, function()
	end );
end

function HandyNotes_TravelGuide:RegisterWithHandyNotes()
	astate = C_ContributionCollector.GetState(11)  --Battle for Stromgarde
	dstate = C_ContributionCollector.GetState(118) --Battle for Darkshore
--	astate = 1  --Battle for Stromgarde only for testing
--	dstate = 2  --Battle for Darkshore only for testing
--	print(astate..dstate) --only for testing
end

function HandyNotes_TravelGuide:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", HandyNotes_TravelGuide.pluginName)
end

function HandyNotes_TravelGuide:OnEnable()
end

function HandyNotes_TravelGuide:ZONE_CHANGED()
	HandyNotes_TravelGuide:Refresh()
end

function HandyNotes_TravelGuide:ZONE_CHANGED_INDOORS()
	HandyNotes_TravelGuide:Refresh()
end

function HandyNotes_TravelGuide:NEW_WMO_CHUNK()
	HandyNotes_TravelGuide:Refresh()
end

function HandyNotes_TravelGuide:QUEST_FINISHED()
	HandyNotes_TravelGuide:Refresh()
end
--[[
function HandyNotes_TravelGuide:CLOSE_WORLD_MAP()
	closeAllDropdowns()
end

SLASH_TGREFRESH1 = "/tgrefresh"
SlashCmdList["TGREFRESH"] = function(msg)
	HandyNotes_TravelGuide:Refresh()
	print("TravelGuide refreshed");
end
]]-- //////////////////////////////////////////////////////////////////////////


local config = {}
TravelGuide.config = config

config.options = {
	type = "group",
	name = HandyNotes_TravelGuide.pluginName,
	desc = HandyNotes_TravelGuide.description,
	get = function(info) return TravelGuide_db[info[#info]] end,
	set = function(info, v)
		TravelGuide_db[info[#info]] = v
		HandyNotes_TravelGuide:SendMessage("HandyNotes_NotifyUpdate", HandyNotes_TravelGuide.pluginName)
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
			name = L["What to display?"],
			inline = true,
			order = 20,
			args = {
				desc = {
					name = L["These settings control what type of icons to be displayed."],
					type = "description",
					order = 0,
				},
				show_boat = {
					type = "toggle",
					name = L["Boat"],
					desc = L["Show the boat locations."],
					order = 20,
				},
				show_aboat = {
					type = "toggle",
					name = L["Alliance Boat"],
					desc = L["Show the Alliance boat locations."],
					order = 22,
				},
				show_zepplin = {
					type = "toggle",
					name = L["Zeppelin"],
					desc = L["Show the Zeppelin locations."],
					order = 23,
				},	
				show_hzepplin = {
					type = "toggle",
					name = L["Horde Zeppelin"],
					desc = L["Show the Horde Zeppelin locations."],
					order = 24,
				},
				show_portal = {
					type = "toggle",
					name = L["Portal"],
					desc = L["Show the portal locations."],
					order = 25,
				},
				show_orderhall = {
					type = "toggle",
					name = L["Order Hall portal"],
					desc = L["Show the Order Hall portal locations."],
					order = 26,
				},
				show_warfront = {
					type = "toggle",
					name = L["Warfront portal"],
					desc = L["Show the Warfront portal locations."],
					order = 27,
				},
				show_tram = {
					type = "toggle",
					name = L["Deeprun Tram"],
					desc = L["Show the Deeprun Tram locations in Stormwind and Ironforge."],
					order = 28,
				},
				show_note = {
					type = "toggle",
					name = L["Note"],
					desc = L["Show the node's additional notes when it's available."],
					order = 29,
				},
				easy_waypoint = {
					type = "toggle",
					name = L["Easy waypoints"],
					desc = L["easy_waypoints_desc"],
					order = 30,
				},
--[[				
				show_others = {
					type = "toggle",
					name = L["Others"],
					desc = L["Show all the other POIs."],
					order = 30,
				},
]]--				
			},
		},
		plugin_config = {
			type = "group",
			name = L["AddOn Settings"],
			inline = true,
			order = 30,
			args = {
--[[				query_server = {
					type = "toggle",
					name = L["Query from server"],
					desc = L["Send query request to server to lookup localized name. May be a little bit slower for the first time lookup but would be very fast once the name is found and cached."],
					order = 10,
				},
]]--				
				unhide = {
					type = "execute",
					name = L["Restore hidden nodes"],
					desc = L["Show all nodes that you manually hid by right-clicking on them and choosing \"Hide this node\"."],
					width = "full",
					func = function()
						for map,coords in pairs(TravelGuide.hidden) do
							wipe(coords)
						end
						HandyNotes_TravelGuide:Refresh()
						print("TravelGuide: "..L["All hidden nodes have been restored"])
					end,
					order = 50,
				},
			},
		},
	},
}


--BFA---------------------------------------------------------------------------
local Zandalar = L["Zandalar"]
local Zuldazar = L["Zandalar, Zuldazar"]
local PtoZuldazar = L["Portal to Zuldazar"]
local BtoZuldazar = L["Boat to Zuldazar"]
local returntoZuldazar = L["Return to Zuldazar"]
local BtoVolDun = L["Boat to Vol'Dun"]
local BtoNazmir = L["Boat to Nazmir"]
local PtoNazjatar = L["Portal to Nazjatar"]
local StoMechagon = L["Submarine to Mechagon"]
local PtoSilithus = L["Portal to Silithus"]

local KulTiras = L["Kul Tiras"]
local TiragardeSound = L["Kul Tiras, Tiragarde Sound"]
local PtoBoralus = L["Portal to Boralus"]
local BtoBoralus = L["Boat to Boralus"]
local returntoBoralus = L["Return to Boralus"]
local BtoDrustvar = L["Boat to Drustvar"]
local BtoStormsongValley = L["Boat to Stormsong Valley"]
local BtoTiragardeSound = L["Boat to Tiragarde Sound"]

local PtoArathiHighlands = L["Portal to Arathi Highlands"]
local PtoPortofZandalar = L["Portal to Port of Zandalar"]
local PtoDarkshore = L["Portal to Darkshore"]
local PtoPortofBoralus = L["Portal to Port of Boralus"]

--Legion------------------------------------------------------------------------
local BrokenIsles = L["Broken Isles"]
local Stormheim = L["Broken Isles, Stormheim"]
local PtoStormheim = L["Portal to Stormheim"]
local PtoHelheim = L["Portal to Helheim"]
local PtoDala = L["Portal to Dalaran"]
local PtoAzsuna = L["Portal to Azsuna"]
local PtoEmeraldDreamway = L["Portal to Emerald Dreamway"]
local GEtoTrueshotLodge = L["Great Eagle to Trueshot Lodge"]
local JtoSkyhold = L["Jump to Skyhold"]
local dalaran = L["Dalaran"]
local azsuna = L["Azsuna"]
local valsharah = L["Val'sharah"]
local suramar = L["Suramar"]
local highmountain = L["Highmountain"]
local stormheim = L["Stormheim"]
local brokenshore = L["Broken Shore"]

--WOD---------------------------------------------------------------------------
local PtoStormshield = L["Portal to Stormshield"]
local PtoLionswatch = L["Portal to Lion's watch"]
local PtoWarspear = L["Portal to Warspear"]
local PtoVolmar = L["Portal to Vol'mar"]
local Ashran = L["Draenor, Ashran"]
local TanaanJungle = L["Draenor, Tanaan Jungle"]

--MOP---------------------------------------------------------------------------
local Pandaria = L["Pandaria"]
local TownlongSteppes = L["Pandaria, Townlong Steppes"]
local PtoIofT =  L["Portal to Isle of Thunder"]
local PtoSPG = L["Portal to Shado-Pan Garrison"]
local PtoJadeForest = L["Portal to Jade Forest"]
local PtoPeakofSerenity = L["Portal to Peak of Serenity"]
local KunLaiSummit = L["Pandaria, Kun-Lai Summit"]

--CATA--------------------------------------------------------------------------
local Maelstrom = L["Maelstrom"]
local Deepholm = L["Maelstrom, Deepholm"]
local PtoTolBarad = L["Portal to Tol Barad"]
local PtoUldum = L["Portal to Uldum"]
local PtoDeepholm = L["Portal to Deepholm"]
local PtoVashjir = L["Portal to Vashj'ir"]
local PtoHyjal = L["Portal to Hyjal"]
local PtoTwilightHighlands = L["Portal to Twilight Highlands"]
local PtoTempleofEarth = L["Portal to Temple of Earth"]
local PtoTherazanesThrone = L["Portal to Therazane's Throne"]

--WOTLK-------------------------------------------------------------------------
local CrystalsongForest = L["Northrend, Crystalsong Forest"]
local PtotPurpleParlor = L["Portal to the Purple Parlor"]
local BoreanTundra = L["Northrend, Borean Tundra"]
local ZtoBoreanTundra = L["Zeppelin to Borean Tundra"]
local BtoBoreanTundra = L["Boat to Borean Tundra"]
local WarsongHold = L["Northrend, Warsong Hold"]
local ValianceKeep = L["Northrend, Valiance Keep"]
local BtoUnuPe = L["Boat to Unu'Pe"]
local Dragonblight = L["Northrend, Dragonblight"]
local BtoMoaKiHarbor = L["Boat to Moa'Ki Harbor"]
local HowlingFjord = L["Northrend, Howling Fjord"]
local PtoHowlingFjord = L["Portal to Howling Fjord"]
local VengeanceLanding = L["Northrend, Vengeance Landing"]
local BtoHowlingFjord = L["Boat to Howling Fjord"]
local Valgarde = L["Northrend, Valgarde"]
local BtoKamagua = L["Boat to Kamagua"]

--BC----------------------------------------------------------------------------
local AzuremystIsle = L["Kalimdor, Azuremyst Isle"]
local PtoExodar = L["Portal to Exodar"]
local inExodar = L["in Exodar"]
local Outland = L["Outland"]
local PtoHellfirePeninsula = L["Portal to Hellfire Peninsula"]
local PtoIofQD = L["Portal to Isle of Quel'Danas"]
local PtoShattrath = L["Portal to Shattrath"]
local TerokkarForest = L["Outland, Terokkar Forest"]

--Vanilla-----------------------------------------------------------------------
local Durotar = L["Kalimdor, Durotar"]
local PtoOG = L["Portal to Orgrimmar"]
local ZtoOG = L["Zeppelin to Orgrimmar"]
local Mulgore = L["Kalimdor, Mulgore"]
local PtoTB = L["Portal to Thunder Bluff"]
local ZtoTB = L["Zeppelin to Thunder Bluff"]
local Tirisfal = L["Eastern Kingdoms, Tirisfal Glades"]
local PtoUC = L["Portal to Undercity"]
local Orboftranslocation = L["Orb of translocation"]
local inUCMq = L["in Undercity Magic Quarter"]
local EversongWoods = L["Eastern Kingdoms, Eversong Woods"]
local PtoSM = L["Portal to Silvermoon"]
local NorthernBarrens = L["Kalimdor, Northern Barrens"]
local BtoRatchet = L["Boat to Ratchet"]
local ElwynnForest = L["Eastern Kingdoms, Elwynn Forest"]
local PtoSW = L["Portal to Stormwind"]
local BtoSW = L["Boat to Stormwind"]
local DrTtoSW = L["Deeprun Tram to Stormwind"]
local Teldrassil = L["Kalimdor, Teldrassil"]
local PtoDarnassus = L["Portal to Darnassus"]
local DunMorogh = L["Eastern Kingdoms, Dun Morogh"]
local PtoIF = L["Portal to Ironforge"]
local DrTtoIF = L["Deeprun Tram to Ironforge"]
local BtoMenethilHarbor = L["Boat to Menethil Harbor"]
local EasternKingdoms = L["Eastern Kingdoms"]
local Wetlands = L["Eastern Kingdoms, Wetlands"]
local ZtoStranglethornVale = L["Zeppelin to Stranglethorn Vale"]
local PtoStranglethornVale = L["Portal to Stranglethorn Vale"]
local StranglethornVale = L["Eastern Kingdoms, Stranglethorn Vale"]
local BtoBootyBay = L["Boat to Booty Bay"]
local GromgolBaseCamp = L["Eastern Kingdoms, Grom'gol Base Camp"]
local Kalimdor = L["Kalimdor"]
local DustwallowMarsh = L["Kalimdor, Dustwallow Marsh"]
local BtoTheramore = L["Boat to Theramore"]
local PtoCavernsofTime = L["Portal to Caverns of Time"]
local Tanaris = L["Kalimdor, Tanaris"]
local ArathiHighlands = L["Eastern Kingdoms, Arathi Highlands"]
local Darkshore = L["Kalimdor, Darkshore"]
local PtoDalaCrater = L["Portal to Dalaran Crater"]
local HillsbradFoothills = L["Eastern Kingdoms, Hillsbrad Foothills"]
local Ptotomb = L["Portal to Tombs"]
local SilverpineForest = L["Eastern Kingdoms, Silverpine Forest"]

--LOCAL END--------------------------------------------------------------------------------
local DB = {}

TravelGuide.DB = DB

DB.points = {
-- MAPID from https://wow.gamepedia.com/UiMapID
-- /dump C_Map.GetBestMapForUnit("player")
-- /dump WorldMapFrame:GetMapID()
-- /dump UnitClass("player")
--[[ structure:
	[UiMapID] = { -- "_terrain1" etc will be stripped from attempts to fetch this
		[coord] = {
			spell= [ID]				-- show spell in the tooltip
			label= [string], 		-- label: text that'll be the label, optional
			note= [string],			-- additional notes for this node
			lvl = [PLAYERlvl],
			faction= [FACTION],     -- shows only for selected faction
			class= [CLASS NAME],	-- specified the class name so that this node will only be available for this class
			npc= [id], 				-- related npc id, used to display names in tooltip
			type= [string], 		-- the pre-define icon type which can be found in Constant.lua
		},
	},

--]]
--BFA----------------------------------------------------------------------------------------------------------------------------------------------------------
	[875] = { -- Zandalar
		[58206200] = { portal=true, label1=PtoSM.." ("..EversongWoods..")\n"..format(PtoOG.." ("..Durotar..")\n"..PtoTB.." ("..Mulgore..")\n"..PtoSilithus.." ("..Kalimdor..")\n"..PtoNazjatar..""), 
									label2=PtoSM.."\n"..format(PtoOG.."\n"..PtoTB.."\n"..PtoSilithus.."\n"..PtoNazjatar..""), faction="Horde" },
		[56307065] = { boat=true, label=StoMechagon, note=KulTiras, quest=55651, faction="Horde" },
		[33201921] = { boat=true, label=returntoBoralus, note=TiragardeSound, quest=51229, faction="Alliance" }, --quest=51229, Vol'Dun Barnard "The Smasher" Baysworth
		[62492642] = { boat=true, label=returntoBoralus, note=TiragardeSound, quest=51088, faction="Alliance" }, --quest=51088, Nazmir Desha Stormwallow
		[47137856] = { boat=true, label=returntoBoralus, note=TiragardeSound, quest=51359, faction="Alliance" }, --quest=51359, Zuldazar Daria Smithson
		[58287605] = { boat=true, label1=BtoDrustvar.." ("..KulTiras..")\n"..format(BtoStormsongValley.." ("..KulTiras..")\n"..BtoTiragardeSound.." ("..KulTiras..")"), 
								  label2=BtoDrustvar.."\n"..format(BtoStormsongValley.."\n"..BtoTiragardeSound..""),faction="Horde" },
		[58367208] = { mixedportal=true, label1=PtoArathiHighlands.." ("..EasternKingdoms..")\n"..format(PtoDarkshore.." ("..Kalimdor..")"),
										 label2=PtoArathiHighlands.."\n"..format(PtoDarkshore..""), lvl=120, faction="Horde", warfront="both" },
		},	
	[862] = { -- Zuldazar
		[58304450] = { portal=true, label1=PtoSM.." ("..EversongWoods..")\n"..format(PtoOG.." ("..Durotar..")\n"..PtoTB.." ("..Mulgore..")\n"..PtoSilithus.." ("..Kalimdor..")\n"..PtoNazjatar..""), 
									label2=PtoSM.."\n"..format(PtoOG.."\n"..PtoTB.."\n"..PtoSilithus.."\n"..PtoNazjatar..""), faction="Horde" },		
		[55255824] = { boat=true, label=StoMechagon, note=KulTiras, quest=55651, faction="Horde" },
		[58466293] = { boat=true, label1=BtoDrustvar.." ("..KulTiras..")\n"..format(BtoStormsongValley.." ("..KulTiras..")\n"..BtoTiragardeSound.." ("..KulTiras..")"), 
								  label2=BtoDrustvar.."\n"..format(BtoStormsongValley.."\n"..BtoTiragardeSound..""), faction="Horde" },
		[58596055] = { mixedportal=true, label1=PtoArathiHighlands.." ("..EasternKingdoms..")\n"..format(PtoDarkshore.." ("..Kalimdor..")"),
										 label2=PtoArathiHighlands.."\n"..format(PtoDarkshore..""), lvl=120, faction="Horde", warfront="both" },
		},						-- quest=51340, Drustvar	quest=51532, Stormsong valley	quest=51421, tiragard sound
	[1165] = { -- Dazar'alor
		[51004600] = { portal=true, label1=PtoSM.." ("..EversongWoods..")\n"..format(PtoOG.." ("..Durotar..")\n"..PtoTB.." ("..Mulgore..")\n"..PtoSilithus.." ("..Kalimdor..")\n"..PtoNazjatar..""),
									label2=PtoSM.."\n"..format(PtoOG.."\n"..PtoTB.."\n"..PtoSilithus.."\n"..PtoNazjatar..""), faction="Horde" },
		[41808760] = { boat=true, label=StoMechagon, note=KulTiras, quest=55651, faction="Horde" }, --quest=55651,
		[51859453] = { mixedportal=true, label1=PtoArathiHighlands.." ("..EasternKingdoms..")\n"..format(PtoDarkshore.." ("..Kalimdor..")"),
										 label2=PtoArathiHighlands.."\n"..format(PtoDarkshore..""), lvl=120, faction="Horde", warfront="both" },
		},
	[1163] = { -- Dazar'alor - The Great Seal
		[73706210] = { portal=true, label=PtoSM, note=EversongWoods, faction="Horde" },
		[73706980] = { portal=true, label=PtoOG, note=Durotar, quest=46931, faction="Horde" },
		[73707730] = { portal=true, label=PtoTB, note=Mulgore, faction="Horde" },
		[73708530] = { portal=true, label=PtoSilithus, note=Kalimdor, lvl=120, quest=46931, faction="Horde" },
		[63008530] = { portal=true, label=PtoNazjatar, quest=55053, faction="Horde" },
		},
	[1355] = { -- Nazjatar
		[47286278] = { portal=true, label=PtoZuldazar, note=Zandalar, quest=55053, faction="Horde" }, --quest=55053,
		[40005260] = { portal=true, label=PtoBoralus, note=KulTiras, quest=54972, faction="Alliance" }, --quest=54972,
		},	
	[876] = { -- Kul Tiras
		[61404950] = { portal=true, label1=PtoSW.." ("..ElwynnForest..")\n"..format(PtoIF.." ("..DunMorogh..")\n"..PtoExodar.." ("..AzuremystIsle..")\n"..PtoSilithus.." ("..Kalimdor..")\n"..PtoNazjatar..""),
									label2=PtoSW.."\n"..format(PtoIF.."\n"..PtoExodar.."\n"..PtoSilithus.."\n"..PtoNazjatar..""), faction="Alliance" },
		[69046516] = { boat=true, label=returntoZuldazar, note=Zandalar, quest=51438, faction="Horde" }, --quest=51438, Tiragarde Sound speak: Erul Dawnbrook
		[25936716] = { boat=true, label=returntoZuldazar, note=Zandalar, quest=51340, faction="Horde" }, --quest=51340, Drustvar
		[54371416] = { boat=true, label=returntoZuldazar, note=Zandalar, quest=51696, faction="Horde" }, --quest=51696, Stormsong valley 51902450 boat Grok Seahandler
		[54141818] = { boat=true, label=returntoZuldazar, note=Zandalar, quest=51696, faction="Horde" }, --quest=51696, Stormsong Valley 51403370 Flightmaster Muka Stormbreaker
		[20332457] = { boat=true, label=returntoZuldazar, note=Zandalar, quest=55651, faction="Horde" }, --quest=55651, Mechagon 
--noboat		[20742783] = { boat=true, label=returntoBoralus, note=TiragardeSound, quest=54992, faction="Alliance" }, --Mechagon --quest=54992,
		[62095274] = { boat=true, label1=BtoVolDun.." ("..Zandalar..")\n"..format(BtoNazmir.." ("..Zandalar..")\n"..BtoZuldazar.." ("..Zandalar..")"),
								  label2=BtoVolDun.."\n"..format(BtoNazmir.."\n"..BtoZuldazar..""),		faction="Alliance" },
		[60855074] = { mixedportal=true, label1=PtoArathiHighlands.." ("..EasternKingdoms..")\n"..format(PtoDarkshore.." ("..Kalimdor..")"),
										 label2=PtoArathiHighlands.."\n"..format(PtoDarkshore..""), lvl=120, faction="Alliance", warfront="both" },
		},						-- Voldun  51283			nazmir	51088			zuldazar  51308
	[895] = { -- Tiragarde Sound
		[74302350] = { portal=true, label1=PtoSW.." ("..ElwynnForest..")\n"..format(PtoIF.." ("..DunMorogh..")\n"..PtoExodar.." ("..AzuremystIsle..")\n"..PtoSilithus.." ("..Kalimdor..")\n"..PtoNazjatar..""),
									label2=PtoSW.."\n"..format(PtoIF.."\n"..PtoExodar.."\n"..PtoSilithus.."\n"..PtoNazjatar..""), faction="Alliance" },
		[73692628] = { boat=true, label1=BtoVolDun.." ("..Zandalar..")\n"..format(BtoNazmir.." ("..Zandalar..")\n"..BtoZuldazar.." ("..Zandalar..")"),
								  label2=BtoVolDun.."\n"..format(BtoNazmir.."\n"..BtoZuldazar..""), faction="Alliance" },
		[73362568] = { mixedportal=true, label1=PtoArathiHighlands.." ("..EasternKingdoms..")\n"..format(PtoDarkshore.." ("..Kalimdor..")"),
										 label2=PtoArathiHighlands.."\n"..format(PtoDarkshore..""), lvl=120, faction="Alliance", warfront="both" },

		},	
	[942] = { -- Stormsong Valley
		[51902450] = { boat=true, label=returntoZuldazar, note=Zandalar, quest=51696, faction="Horde" }, --Stormsong valley 51902450 boat Grok Seahandler
		[51403370] = { boat=true, label=returntoZuldazar, note=Zandalar, quest=51696, faction="Horde" }, --Stormsong Valley 51403370 Flightmaster Muka Stormbreaker
		},	
	[1161] = { -- Boralus
		[70401600] = { portal=true, label1=PtoSW.." ("..ElwynnForest..")\n"..format(PtoIF.." ("..DunMorogh..")\n"..PtoExodar.." ("..AzuremystIsle..")\n"..PtoSilithus.." ("..Kalimdor..")\n"..PtoNazjatar..""),
									label2=PtoSW.."\n"..format(PtoIF.."\n"..PtoExodar.."\n"..PtoSilithus.."\n"..PtoNazjatar..""),faction="Alliance" },
		[67952669] = { boat=true, label1=BtoVolDun.." ("..Zandalar..")\n"..format(BtoNazmir.." ("..Zandalar..")\n"..BtoZuldazar.." ("..Zandalar..")"),
								  label2=BtoVolDun.."\n"..format(BtoNazmir.."\n"..BtoZuldazar..""), faction="Alliance" },
		[66352486] = { mixedportal=true, label1=PtoArathiHighlands.." ("..EasternKingdoms..")\n"..format(PtoDarkshore.." ("..Kalimdor..")"),
										 label2=PtoArathiHighlands.."\n"..format(PtoDarkshore..""), lvl=120, faction="Alliance", warfront="both" }, --quest=53194,
		},	
--Legion----------------------------------------------------------------------------------------------------------------------------------------------------------
	[619] = { -- Broken Isles
		[30712543] = { orderhall=true, label1=PtoDala.." ("..BrokenIsles..")\n"..format(PtoEmeraldDreamway),
									   label2=PtoDala.."\n"..format(PtoEmeraldDreamway), class="DRUID" },
		[63326940] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="DEATHKNIGHT" },
		[45406523] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[46086351] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		[33675793] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[33675788] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		[52082914] = { portal=true, label=PtoDala, note=BrokenIsles },
		[65492873] = { portal=true, label=PtoHelheim, note=Stormheim },
		[41702157] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="HUNTER" }, -- quest=40953, ????
		[52597039] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Broken Shore
		[61353269] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Stormheim
		[34544019] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Val'sharah
		[46022488] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Highmountain
		[33995326] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Azuna
		[43944460] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Suramar
		},
	[627] = { -- Dalaran Broken Isles
		[39506320] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[55302400] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		[72854121] = { flightmaster=true, label=GEtoTrueshotLodge, note=Durotar, class="HUNTER" }, --quest=40953, ????
		},
	[630] = { -- Azsuna
		[46664141] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[46644121] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
--coord		[46664141] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[82135737] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		[47582809] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
		},	
	[634] = { -- Stormheim
		[30084070] = { portal=true, label=PtoDala, note=BrokenIsles },
		[73633938] = { portal=true, label=PtoHelheim, note=Stormheim },
		[60175223] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
		},
	[649] = { -- Stormheim - Helheim
		[66584793] = { portal=true, label=PtoStormheim, note=Stormheim },
		},
	[650] = { -- Highmountain
		[34585114] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="HUNTER" }, --quest=40953, ????
		[46115996] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
		},
	[750] = { -- Highmountain - Thunder Totem
		[39834206] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
		},	
	[641] = { -- Val'sharah
		[41742385] = { orderhall=true, label1=PtoDala.." ("..BrokenIsles..")\n"..format(PtoEmeraldDreamway), 
									   label2=PtoDala.."\n"..format(PtoEmeraldDreamway), class="DRUID" },
		[54707490] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
		},
	[680] = { -- Suramar
		[33094822] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
		},	
	[646] = { -- Broken Shore
		[44816132] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
		},
	[830] = { -- Krokuun
		[62008694] = { portal=true, label=PtoDala, note=BrokenIsles },
		},		
	[832] = { -- Krokuun Vindikaar
		[43272508] = { portal=true, label=PtoDala, note=BrokenIsles },
		},
	[882] = { -- Mac'Aree
		[51668722] = { portal=true, label=PtoDala, note=BrokenIsles },
		},		
	[884] = { -- Mac'Aree Vindikaar
		[49332529] = { portal=true, label=PtoDala, note=BrokenIsles },
		},
	[885] = { -- Antorische Ödnis
		[75893732] = { portal=true, label=PtoDala, note=BrokenIsles },
		},		
	[887] = { -- Antorische Ödnis Vindikaar
		[33785600] = { portal=true, label=PtoDala, note=BrokenIsles },
		},
--ORDERHALL------------------------------------------------------------------------------------		
	[747] = { -- The Dreamgrove  *DRUID*
		[56604310] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="DRUID" },
		[55502200] = { orderhall=true, label=PtoEmeraldDreamway, class="DRUID" },
		},
	[648] = { -- Acherus: The Ebon Hold - Hall of Command  *DEATHKNIGHT*
		[24703370] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="DEATHKNIGHT" },
		},
	[720] = { --  	Mardum, the Shattered Abyss - Upper Command Center  *DEMONHUNTER*
		[59269182] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="DEMONHUNTER" }, --quest=42872, access to orderhall
		[58361658] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="DEMONHUNTER" },
		},	
	[734] = { -- Hall of the Guardian  *MAGE*
		[57299056] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="MAGE" },
--		[66784670] = { orderhall=true, label=PtoValsharah, note=BrokenIsles, class="MAGE" },
--		[67214172] = { orderhall=true, label=PtoStormheim, note=BrokenIsles, class="MAGE" },
--		[60235191] = { orderhall=true, label=PtoSuramar, note=BrokenIsles, class="MAGE" },
--		[54684456] = { orderhall=true, label=PtoHighmountain, note=BrokenIsles, class="MAGE" },
--		[54993963] = { orderhall=true, label=PtoAzsuna, note=BrokenIsles, class="MAGE" },
		},
	[726] = { -- The Maelstrom  *SHAMAN*
		[29835200] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="SHAMAN" },
		},
	[24] = { -- Light's Hope Chapel  *PALADIN*
		[37646407] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="PALADIN" },
--		in Eastern Plaguelands and Eastern Kingdoms another portal POI
		},
	[717] = { -- Dreadscar Rift  *WARLOCK*
		[74333750] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="WARLOCK" },
		},
	[702] = { -- Netherlight Temple  *PRIEST*
		[49798075] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="PRIEST" },
		},
	[695] = { -- Skyhold  *WARRIOR*
--		[58322500] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="WARRIOR" },
		[58322500] = { worderhall=true, label=dalaran.."\n"..format(stormheim.."\n"..azsuna.."\n"..valsharah.."\n"..highmountain.."\n"..suramar.."\n"..brokenshore..""), note=BrokenIsles, class="WARRIOR" },
		},
	[709] = { -- The Wandering Isle  *MONK*
		[52405714] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="MONK" },
		[50055441] = { orderhall=true, label=PtoPeakofSerenity, note=KunLaiSummit, class="MONK" },
		},
	[739] = { -- Trueshotlodge  *HUNTER*
		[48634352] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="HUNTER" }, --quest=40953, access to orderhall ???
		},		
		
--Warlords of Draenor----------------------------------------------------------------------------------------------------------------------------------------------
	[572] = { -- Draenor
		[73004300] = { portal=true, label1=PtoOG.." ("..Durotar..")\n"..format(PtoVolmar.." ("..TanaanJungle..")"),
									label2=PtoOG.."\n"..format(PtoVolmar..""), faction="Horde"},
		[73014305] = { portal=true, label1=PtoSW.." ("..ElwynnForest..")\n"..format(PtoLionswatch.." ("..TanaanJungle..")"),
									label2=PtoSW.."\n"..format(PtoLionswatch..""), faction="Alliance"},
        [34683698] = { portal=true, label=PtoWarspear, note=Ashran, quest=36614, faction="Horde"},
		[53556087] = { portal=true, label=PtoStormshield, note=Ashran, quest=36615, faction="Alliance"},
		[60424563] = { portal=true, label=PtoWarspear, note=Ashran, quest=37935, faction="Horde"},
		[59594867] = { portal=true, label=PtoStormshield, note=Ashran, quest=38445, faction="Alliance"},
		},
	[588] = { -- Ashran
		[44001300] = { portal=true, label1=PtoOG.." ("..Durotar..")\n"..format(PtoVolmar.." ("..TanaanJungle..")"),
									label2=PtoOG.."\n"..format(PtoVolmar..""), faction="Horde"},
		[40009000] = { portal=true, label1=PtoSW.." ("..ElwynnForest..")\n"..format(PtoLionswatch.." ("..TanaanJungle..")"),
									label2=PtoSW.."\n"..format(PtoLionswatch..""), faction="Alliance"},
		},
	[590] = { -- Frostwall (Garrison)
		[75104890] = { portal=true, label=PtoWarspear, note=Ashran, quest=36614, faction="Horde"},
		},
	[525] = { -- Frostfire Ridge
		[51496593] = { portal=true, label=PtoWarspear, note=Ashran, quest=36614, faction="Horde"},
		},
	[582] = { -- Lunarfall (Garrison)
		[70102750] = { portal=true, label=PtoStormshield, note=Ashran, quest=36615, faction="Alliance"},
		},
	[539] = { -- Shadowmoon Valley
		[32871553] = { portal=true, label=PtoStormshield, note=Ashran, quest=36615, faction="Alliance"},
		},
	[534] = { -- Tanaan Jungle
		[61004734] = { portal=true, label=PtoWarspear, note=Ashran, quest=37935, faction="Horde"},
		[57446050] = { portal=true, label=PtoStormshield, note=Ashran, quest=38445, faction="Alliance"},
		},
	[624] = { -- Warspear (Ashran)
		[60705160] = { portal=true, label=PtoOG, note=Durotar, faction="Horde"},
		[53104390] = { portal=true, label=PtoVolmar, note=TanaanJungle, quest=37935, faction="Horde"},
		},
	[622] = { -- Stormshield (Ashran)
		[60903800] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance"},
		[36314116] = { portal=true, label=PtoLionswatch, note=TanaanJungle, quest=38445, faction="Alliance"},
		},	
		
--Mists of Pandaria-------------------------------------------------------------------------------------------------------------------------------------------------
	[424] = { -- Pandaria
		[29534767] = { portal=true, label=PtoIofT, note=Pandaria, quest=32680, faction="Horde" }, --quest=32680,
		[29144595] = { portal=true, label=PtoIofT, note=Pandaria, quest=32681, faction="Alliance" }, --quest=32681,
		[19100943] = { portal=true, label=PtoSPG, note=TownlongSteppes, quest=32212, faction="Horde" }, --quest=32212,
		[24331611] = { portal=true, label=PtoSPG, note=TownlongSteppes, quest=32644, faction="Alliance" }, --quest=32644,
		[55215658] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[67816760] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[59883557] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		[50784779] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		[44792782] = { orderhall=true, label=PtoOG, note=Durotar, class="MONK", faction="Horde" },
		[44972774] = { orderhall=true, label=PtoSW, note=ElwynnForest, class="MONK", faction="Alliance" },
		},
	[390] = { -- Vale of Eternal Blossoms
		[90876620] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[63461261] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		},
	[1530] = { -- Vale of Eternal Blossoms BFA Vision of N'Zoth
		[91606427] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[63720988] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		},
	[392] = { -- Shrine of Two Moons - The Imperial Mercantile
		[73304270] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		},	
	[394] = { -- Shrine of Seven Stars - The Imperial Exchange
		[71703570] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		},		
	[388] = { -- Townlong Steppes
		[49746867] = { portal=true, label=PtoIofT, note=Pandaria, quest=32681, faction="Alliance" }, --quest=32681,
		[50607340] = { portal=true, label=PtoIofT, note=Pandaria, quest=32680, faction="Horde" }, --quest=32680,
		},
	[379] = { -- Kun-Lai Summit
		[48534357] = { orderhall=true, label=PtoOG, note=Durotar, class="MONK", faction="Horde" },
		[48964336] = { orderhall=true, label=PtoSW, note=ElwynnForest, class="MONK", faction="Alliance" },
		},	
--[[	[371] = { -- The Jade Forest
		[28501401] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		[] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		},
]]--		
	[504] = { -- Isle of Thunder
		[64707348] = { portal=true, label=PtoSPG, note=TownlongSteppes, quest=32644, faction="Alliance" }, --quest=32644,
		[33213269] = { portal=true, label=PtoSPG, note=TownlongSteppes, quest=32212, faction="Horde" }, --quest=32212,
		},
		
--Cataclysm---------------------------------------------------------------------------------------------------------------------------------------------------------
	[198] = { -- Mount Hyjal
		[62602310] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[63492444] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		},
	[207] = { -- Deepholm
		[48515381] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[50935310] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		[49325034] = { portal=true, label=PtoTherazanesThrone, note=Deepholm, quest=26709 }, --quest=26709
		[57211352] = { portal=true, label=PtoTempleofEarth, note=Deepholm, quest=26971 }, --quest=26971
		},
	[948] = { -- Maelstrom
		[51182842] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[51172840] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		},
	[241] = { -- Twilight Highlands
		[79517782] = { portal=true, label=PtoSW, note=ElwynnForest, quest=27537, faction="Alliance" }, --quest=27537,
		[73625351] = { portal=true, label=PtoOG, note=Durotar, quest=26798, faction="Horde" }, --quest=26798,
		},
	[244] = { -- Tol Barad
		[47115193] = { portal=true, label=PtoSW, note=ElwynnForest, lvl=85, faction="Alliance" },
		[47115192] = { portal=true, label=PtoOG, note=Durotar, lvl=85, faction="Horde" },
		},
	[245] = { -- Tol Barad Peninsula
		[75255887] = { portal=true, label=PtoSW, note=ElwynnForest, lvl=85, faction="Alliance" },
		[56277966] = { portal=true, label=PtoOG, note=Durotar, lvl=85, faction="Horde" },
		},
		
--Wrath of the Lich King-------------------------------------------------------------------------------------------------------------------------------------------
	[125] = { -- Dalaran Northrend
		[40086282] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[55302542] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		[25634785] = { portal=true, label=PtotPurpleParlor },
		},
	[127] = { -- Crystalsong Forest
		[26194278] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[31223174] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		},
	[113] = { -- Northrend
		[47874119] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[48664124] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		[78858355] = { aboat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
		[78858356] = { boat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
		[24607066] = { aboat=true, label=BtoSW, note=ElwynnForest, faction="Horde" },
		[24607065] = { boat=true, label=BtoSW, note=ElwynnForest, faction="Alliance" },
		[47106782] = { boat=true, label1= BtoUnuPe.." ("..BoreanTundra..")\n"..format(BtoKamagua.." ("..HowlingFjord..")"),
								  label2= BtoUnuPe.."\n"..format(BtoKamagua..""), },
		[30506590] = { boat=true, label=BtoMoaKiHarbor, note=Dragonblight },
		[66408188] = { boat=true, label=BtoMoaKiHarbor, note=Dragonblight },
		[17556488] = { zeppelin=true, label=ZtoOG, note=Durotar, faction="Horde" },
		[17556489] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
		[84057266] = { portal=true, label=PtoUC, note=Tirisfal, faction="Horde" },
		},
	[115] = { -- Dragonblight
		[47797887] = { boat=true, label=BtoUnuPe, note=BoreanTundra },
		[49847853] = { boat=true, label=BtoKamagua, note=HowlingFjord },
		},
	[114] = { -- Borean Tundra
		[79015410] = { boat=true, label=BtoMoaKiHarbor, note=Dragonblight },
		[59946947] = { aboat=true, label=BtoSW, note=ElwynnForest, faction="Horde" },
		[41255344] = { zeppelin=true, label=ZtoOG, note=Durotar, faction="Horde" },
		[41255345] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
		},
	[117] = { -- Howling Fjord
		[23295769] = { boat=true, label=BtoMoaKiHarbor, note=Dragonblight },
		[61506270] = { aboat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
		[77612813] = { portal=true, label=PtoUC, note=Tirisfal, faction="Horde" },
		},

--The Burning Crusade-------------------------------------------------------------------------------------------------------------------------------------------
	[100] = { -- Hellfire Peninsula
		[89225101] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[89234946] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		},
	[111] = { -- Shattrath City
		[57224827] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[48594200] = { portal=true, label=PtoIofQD, note=EasternKingdoms, },
		[56834888] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		},
	[101] = { -- Outland
		[43886598] = { portal=true, label1=PtoSW.." ("..ElwynnForest..")\n"..format(PtoIofQD.." ("..EasternKingdoms..")"),
									label2=PtoSW.."\n"..format(PtoIofQD..""), faction="Alliance" },
		[43886599] = { portal=true, label1=PtoOG.." ("..Durotar..")\n"..format(PtoIofQD.." ("..EasternKingdoms..")"),
									label2=PtoOG.."\n"..format(PtoIofQD..""), faction="Horde" },
		[69075236] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[69075190] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		},
	[108] = { --Terokkar Forest
		[30252350] = { portal=true, label1=PtoSW.." ("..ElwynnForest..")\n"..format(PtoIofQD.." ("..EasternKingdoms..")"),
									label2=PtoSW.."\n"..format(PtoIofQD..""), faction="Alliance" },
		[30252350] = { portal=true, label1=PtoOG.." ("..Durotar..")\n"..format(PtoIofQD.." ("..EasternKingdoms..")"),
									label2=PtoOG.."\n"..format(PtoIofQD..""), faction="Horde" },
		},
	[103] = { -- Exodar
		[48306290] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		},
	[97] = { -- Azuremyst Isle
		[20335407] = { portal=true, label=PtoDarnassus, note=Teldrassil },
		[26364616] = { portal=true, label=PtoSW, note=ElwynnForest..")\n("..inExodar.."", faction="Alliance" },
		},
	[110] = { -- Silvermoon City
		[49401510] = { portal=true, label=PtoUC, note=Tirisfal..")\n("..Orboftranslocation.."", faction="Horde" },
		[58501890] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" }, 
		},
	[94] = { -- Eversong Woods
		[52803270] = { portal=true, label1=PtoUC.." ("..Tirisfal..")\n"..format(PtoOG.." ("..Durotar..")"),
									label2=PtoUC.."\n"..format(PtoOG..""), faction="Horde" },
		},
--[[	[17] = { -- Blasted Lands
--		[72644947] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		},
]]--

--Vanilla-------------------------------------------------------------------------------------------------------------------------------------------------------
	[12] = { -- Kalimdor
		[59236650] = { aboat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
		[59246651] = { boat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
		[56835629] = { boat=true, label=BtoBootyBay, note=StranglethornVale },
		[43181817] = { spell=290245, portal=true, label1=PtoSW.." ("..ElwynnForest..")\n"..format(PtoExodar.." ("..AzuremystIsle..")"),
												   label2=PtoSW.."\n"..format(PtoExodar..""),faction="Alliance" },
		[39401090] = { spell=290245, portal=true, label1=PtoExodar.." ("..AzuremystIsle..")\n"..format(PtoHellfirePeninsula.." ("..Outland..")"),
												   label2=PtoExodar.."\n"..format(PtoHellfirePeninsula..""), faction="Alliance" },
		[43211616] = { spell=290245, portal=true, label=PtoExodar, note=Teldrassil, faction="Horde" },									   
		[29922620] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[59468340] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[59448340] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		[56122758] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[56222774] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		[29332713] = { portal=true, label=PtoDarnassus, note=Teldrassil },
		[45405420] = { zeppelin=true, label=ZtoOG, note=Durotar, faction="Horde" },
		[45405421] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
		[58154245] = { zeppelin=true, label1=ZtoTB.." ("..Mulgore..")\n"..format(ZtoStranglethornVale.." ("..GromgolBaseCamp..")\n"..ZtoBoreanTundra.." ("..WarsongHold..")"),
									  label2=ZtoTB.."\n"..format(ZtoStranglethornVale.."\n"..ZtoBoreanTundra..""), faction="Horde" },
		[58154246] = { hzeppelin=true, label1=ZtoTB.." ("..Mulgore..")\n"..format(ZtoStranglethornVale.." ("..GromgolBaseCamp..")\n"..ZtoBoreanTundra.." ("..WarsongHold..")"), 
									   label2=ZtoTB.."\n"..format(ZtoStranglethornVale.."\n"..ZtoBoreanTundra..""),faction="Alliance" },
		[42857909] = { portal=true, label=PtoZuldazar, note=Zandalar, lvl=120, quest=46931, faction="Horde" },
		[42847905] = { portal=true, label=PtoBoralus, note=TiragardeSound, lvl=120, faction="Alliance" },
		[59414237] = { portal=true, label1=PtoTolBarad.." ("..EasternKingdoms..")\n"..format(PtoUldum.." ("..Kalimdor..")\n"..PtoDeepholm.." ("..Maelstrom..")\n"..PtoVashjir.." ("..EasternKingdoms..")\n"..PtoHyjal.." ("..Kalimdor..")\n"..PtoTwilightHighlands.." ("..EasternKingdoms..")\n"..PtoUC.." ("..Tirisfal..")\n"..PtoDala.." ("..CrystalsongForest..")\n"..PtoJadeForest.." ("..Pandaria..")\n"..PtoZuldazar.." ("..Zandalar..")\n"..PtoAzsuna.." ("..BrokenIsles..")\n"..PtoWarspear.." ("..Ashran..")\n"..PtoShattrath.." ("..TerokkarForest..")\n"..PtoCavernsofTime.." ("..Tanaris..")"),
									label2=PtoTolBarad.."\n"..format(PtoUldum.."\n"..PtoDeepholm.."\n"..PtoVashjir.."\n"..PtoHyjal.."\n"..PtoTwilightHighlands.."\n"..PtoUC.."\n"..PtoDala.."\n"..PtoJadeForest.."\n"..PtoZuldazar.."\n"..PtoAzsuna.."\n"..PtoWarspear.."\n"..PtoShattrath.."\n"..PtoCavernsofTime..""), faction="Horde" },
		[46612303] = { portal=true, label=PtoPortofBoralus, note=TiragardeSound, lvl=120, faction="Alliance", warfront="darkshore"},
		[46302282] = { portal=true, label=PtoPortofZandalar, note=Zuldazar, lvl=120, faction="Horde", warfront="darkshore" },
		},
	[7] = { -- Mulgore
		[33692368] = { zeppelin=true, label=ZtoOG, note=Durotar, faction="Horde" },
		[33692369] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
		},		
	[88] = { -- Thunder Bluff
		[14222574] = { zeppelin=true, label=ZtoOG, note=Durotar, faction="Horde" },
		[14222575] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
		},
	[1] = { -- Durotar
		[47881015] = { portal=true, label1=PtoDala.." ("..CrystalsongForest..")\n"..format(PtoJadeForest.." ("..Pandaria..")\n"..PtoZuldazar.." ("..Zandalar..")\n"..PtoAzsuna.." ("..BrokenIsles..")\n"..PtoWarspear.." ("..Ashran..")\n"..PtoShattrath.." ("..TerokkarForest..")\n"..PtoCavernsofTime.." ("..Tanaris..")"),
									label2=PtoDala.."\n"..format(PtoJadeForest.."\n"..PtoZuldazar.."\n"..PtoAzsuna.."\n"..PtoWarspear.."\n"..PtoShattrath.."\n"..PtoCavernsofTime..""), faction="Horde" },
		[45550380] = { hzeppelin=true, label1=ZtoTB.." ("..Mulgore..")\n"..format(ZtoStranglethornVale.." ("..GromgolBaseCamp..")\n"..ZtoBoreanTundra.." ("..WarsongHold..")"),
									   label2=ZtoTB.."\n"..format(ZtoStranglethornVale.."\n"..ZtoBoreanTundra..""), faction="Alliance" },
		[45550381] = { zeppelin=true, label1=ZtoTB.." ("..Mulgore..")\n"..format(ZtoStranglethornVale.." ("..GromgolBaseCamp..")\n"..ZtoBoreanTundra.." ("..WarsongHold..")"), 
									  label2=ZtoTB.."\n"..format(ZtoStranglethornVale.."\n"..ZtoBoreanTundra..""), faction="Horde" },
		[46980375] = { portal=true, label1=PtoTolBarad.." ("..EasternKingdoms..")\n"..format(PtoUldum.." ("..Kalimdor..")\n"..PtoDeepholm.." ("..Maelstrom..")\n"..PtoVashjir.." ("..EasternKingdoms..")\n"..PtoHyjal.." ("..Kalimdor..")\n"..PtoTwilightHighlands.." ("..EasternKingdoms..")\n"..PtoUC.." ("..Tirisfal..")"),
									label2=PtoTolBarad.."\n"..format(PtoUldum.."\n"..PtoDeepholm.."\n"..PtoVashjir.."\n"..PtoHyjal.."\n"..PtoTwilightHighlands.."\n"..PtoUC..""), faction="Horde" },
		},
	[85] = { -- Orgrimmar
		[59078945] = { portal=true, label1=PtoDala.." ("..CrystalsongForest..")\n"..format(PtoJadeForest.." ("..Pandaria..")\n"..PtoZuldazar.." ("..Zandalar..")\n"..PtoAzsuna.." ("..BrokenIsles..")\n"..PtoWarspear.." ("..Ashran..")\n"..PtoShattrath.." ("..TerokkarForest..")\n"..PtoCavernsofTime.." ("..Tanaris..")"),
									label2=PtoDala.."\n"..format(PtoJadeForest.."\n"..PtoZuldazar.."\n"..PtoAzsuna.."\n"..PtoWarspear.."\n"..PtoShattrath.."\n"..PtoCavernsofTime..""), faction="Horde" },
		[50435651] = { portal=true, label=PtoUC, note=Tirisfal, faction="Horde" },
		[43126480] = { zeppelin=true, label=ZtoTB, note=Mulgore, faction="Horde" },
		[43126481] = { hzeppelin=true, label=ZtoTB, note=Mulgore, faction="Alliance" },
		[50103773] = { portal=true, label1=PtoTolBarad.." ("..EasternKingdoms..")\n"..format(PtoUldum.." ("..Kalimdor..")\n"..PtoDeepholm.." ("..Maelstrom..")\n"..PtoVashjir.." ("..EasternKingdoms..")\n"..PtoHyjal.." ("..Kalimdor..")\n"..PtoTwilightHighlands.." ("..EasternKingdoms..")"),
									label2=PtoTolBarad.."\n"..format(PtoUldum.."\n"..PtoDeepholm.."\n"..PtoVashjir.."\n"..PtoHyjal.."\n"..PtoTwilightHighlands..""), faction="Horde", },
									-- Vashj'ir complete quest 25924
									-- TolBarad at lvl 85
									-- other portals at lvl 80
		[45306178] = { hzeppelin=true, label=ZtoBoreanTundra, note=WarsongHold, faction="Alliance" },
		[52885242] = { hzeppelin=true, label=ZtoStranglethornVale, note=GromgolBaseCamp, faction="Alliance" },
		},		
	[71] = { -- Tanaris
		[65794954] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		[65924954] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		},
	[74] = { -- Cavern of Time
		[58202660] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		[59002670] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		},
	[81] = { -- Silithus
		[41604520] = { portal=true, label =PtoZuldazar, note=Zandalar, lvl=120, quest=46931, faction="Horde" },
		[41474479] = { portal=true, label =PtoBoralus, note=TiragardeSound, lvl=120, faction="Alliance" },
		},	
	[70] = { -- Dustwallow Marsh
		[71625648] = { aboat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
		[71625647] = { boat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
		},
	[62] = { -- Darkshore
		[48023627] = { portal=true, label=PtoPortofBoralus, note=TiragardeSound, lvl=120, faction="Alliance", warfront="darkshore" },
		[46243511] = { portal=true, label=PtoPortofZandalar, note=Zuldazar, lvl=120, faction="Horde", warfront="darkshore" },
		},	
	[89] = { -- Darnassus
		[44247867] = { spell= 290245, portal=true, label1=PtoExodar.." ("..AzuremystIsle..")\n"..format(PtoHellfirePeninsula.." ("..Outland..")"),
												   label2=PtoExodar.."\n"..format(PtoHellfirePeninsula..""), faction="Alliance" },
		},
	[57] = { -- Teldrassil
		[29085646] = { spell= 290245, portal=true, label1=PtoExodar.." ("..AzuremystIsle..")\n"..format(PtoHellfirePeninsula.." ("..Outland..")"),
												   label2=PtoExodar.."\n"..format(PtoHellfirePeninsula..""), faction="Alliance" },
		[55009370] = { spell= 290245, portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
		[52048951] = { spell= 290245, portal=true, label=PtoExodar, note=AzuremystIsle },
		},		
	[56] = { -- Wetlands
		[06216261] = { aboat=true, label=BtoTheramore, note=DustwallowMarsh, faction="Horde" },
		[04415718] = { aboat=true, label=BtoHowlingFjord, note=Valgarde, faction="Horde" },
		},
--[[	NOT USED
	[10] = { --Northern Barrens 
		[70307341] = { boat=true, label=format(BtoBootyBay) },
		},
	[210] = { -- Cape of Stranglethorn
		[38546670] = { boat=true, label=format(BtoRatchet) },
		},
]]--
	[13] = { -- Eastern Kingdom
		[44068694] = { zeppelin=true, label1=ZtoOG.." ("..Durotar..")\n"..format(PtoUC.." ("..Tirisfal..")"),
									  label2=ZtoOG.."\n"..format(PtoUC..""), faction="Horde" },
		[44068695] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
		[41107209] = { aboat=true, label1=BtoBoralus.." ("..KulTiras..")\n"..format(BtoBoreanTundra.." ("..ValianceKeep..")"),
								   label2=BtoBoralus.."\n"..format(BtoBoreanTundra..""), faction="Horde" },
		[41107210] = { boat=true, label1=BtoBoralus.." ("..TiragardeSound..")\n"..format(BtoBoreanTundra.." ("..ValianceKeep..")\n"..PtoDarnassus.." ("..Teldrassil..")"),
								  label2=BtoBoralus.."\n"..format(BtoBoreanTundra.."\n"..PtoDarnassus..""), faction="Alliance" },
		[45995488] = { aboat=true, label1=BtoTheramore.." ("..DustwallowMarsh..")\n"..format(BtoHowlingFjord.." ("..Valgarde..")"),
								   label2=BtoTheramore.."\n"..format(BtoHowlingFjord..""), faction="Horde" },
		[45995482] = { boat=true, label1=BtoTheramore.." ("..DustwallowMarsh..")\n"..format(BtoHowlingFjord.." ("..Valgarde..")"),
								  label2=BtoTheramore.."\n"..format(BtoHowlingFjord..""), faction="Alliance" },
		[42999362] = { boat=true, label=BtoRatchet, note=NorthernBarrens },
		[56161316] = { portal=true, label1=PtoOG.." ("..Durotar..")\n"..format(PtoUC.." ("..Tirisfal..")"),
									label2=PtoOG.."\n"..format(PtoUC..""), faction="Horde" },
		--[43637155] = { portal=true, label1=PtoTolBarad.." ("..EasternKingdoms..")\n"..format(PtoUldum.." ("..Kalimdor..")\n"..PtoDeepholm.." ("..Maelstrom..")\n"..PtoVashjir.." ("..EasternKingdoms..")\n"..PtoHyjal.." ("..Kalimdor..")\n"..PtoTwilightHighlands.." ("..EasternKingdoms..")\n"..DrTtoIF.." ("..DunMorogh..")\n"..PtoDarnassus.." ("..Teldrassil..")\n"..PtoDala.." ("..CrystalsongForest..")\n"..PtoJadeForest.." ("..Pandaria..")\n"..PtoBoralus.." ("..TiragardeSound..")\n"..PtoAzsuna.." ("..BrokenIsles..")\n"..PtoStormshield.." ("..Ashran..")\n"..PtoShattrath.." ("..TerokkarForest..")\n"..PtoExodar.." ("..AzuremystIsle..")\n"..PtoCavernsofTime.." ("..Tanaris..")"),
									--label2=PtoTolBarad.."\n"..format(PtoUldum.."\n"..PtoDeepholm.."\n"..PtoVashjir.."\n"..PtoHyjal.."\n"..PtoTwilightHighlands.."\n"..DrTtoIF.."\n"..PtoDarnassus.."\n"..PtoDala.."\n"..PtoJadeForest.."\n"..PtoBoralus.."\n"..PtoAzsuna.."\n"..PtoStormshield.."\n"..PtoShattrath.."\n"..PtoExodar.."\n"..PtoCavernsofTime..""), faction="Alliance" },
		[43337195] = { tram=true, label=DrTtoIF, note=DunMorogh, faction="Horde" },
		[43863354] = { spell= 290245, portal=true, label1=PtoHowlingFjord.." ("..VengeanceLanding..")\n"..format(PtoOG.." ("..Durotar..")\n"..PtoStranglethornVale.." ("..GromgolBaseCamp..")\n"..PtoSM.." ("..EversongWoods..")\n"..PtoHellfirePeninsula.." ("..Outland..")"),
												   label2=PtoHowlingFjord.."\n"..format(PtoOG.."\n"..PtoStranglethornVale.."\n"..PtoSM.."\n"..PtoHellfirePeninsula..""), faction="Horde" },
		[47835898] = { tram=true, label=DrTtoSW, note=ElwynnForest, },
		[60835906] = { portal=true, label=PtoSW, note=ElwynnForest, quest=27537, faction="Alliance" },
		[35224839] = { portal=true, label=PtoSW, note=ElwynnForest, lvl=85, faction="Alliance" },
		[60105603] = { portal=true, label=PtoOG, note=Durotar, quest=26798, faction="Horde" }, --quest=26798,
		[34394957] = { portal=true, label=PtoOG, note=Durotar, lvl=85, faction="Horde" },
		[57663241] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="PALADIN" },
		[49714419] = { portal=true, label=PtoPortofZandalar, note=Zuldazar, lvl=120, faction="Horde", warfront="arathi" },
		[49244725] = { portal=true, label=PtoPortofBoralus, note=TiragardeSound, lvl=120, faction="Alliance", warfront="arathi" },
--		[41003949] = { portal=true, label=PtoDalaCrater, note=HillsbradFoothills, faction="Horde" },
--		[43674008] = { portal=true, label=Ptotomb, note=SilverpineForest, faction="Horde" },
		},
	[84] = { -- Stormwind City
		[74481841] = { portal=true, label1=PtoTolBarad.." ("..EasternKingdoms..")\n"..format(PtoUldum.." ("..Kalimdor..")\n"..PtoDeepholm.." ("..Maelstrom..")\n"..PtoVashjir.." ("..EasternKingdoms..")\n"..PtoHyjal.." ("..Kalimdor..")\n"..PtoTwilightHighlands.." ("..EasternKingdoms..")"),
									label2=PtoTolBarad.."\n"..format(PtoUldum.."\n"..PtoDeepholm.."\n"..PtoVashjir.."\n"..PtoHyjal.."\n"..PtoTwilightHighlands..""), faction="Alliance" },
		[46419032] = { portal=true, label1=PtoDala.." ("..CrystalsongForest..")\n"..format(PtoJadeForest.." ("..Pandaria..")\n"..PtoBoralus.." ("..TiragardeSound..")\n"..PtoAzsuna.." ("..BrokenIsles..")\n"..PtoStormshield.." ("..Ashran..")\n"..PtoShattrath.." ("..TerokkarForest..")\n"..PtoExodar.." ("..AzuremystIsle..")\n"..PtoCavernsofTime.." ("..Tanaris..")"),
									label2=PtoDala.."\n"..format(PtoJadeForest.."\n"..PtoBoralus.."\n"..PtoAzsuna.."\n"..PtoStormshield.."\n"..PtoShattrath.."\n"..PtoExodar.."\n"..PtoCavernsofTime..""), faction="Alliance" },
		[22015670] = { aboat=true, label=BtoBoralus, note=TiragardeSound, faction="Horde" },
		[17592553] = { aboat=true, label=BtoBoreanTundra, note=ValianceKeep, faction="Horde" },
		[23805620] = { portal=true, label=PtoDarnassus, note=Teldrassil, faction="Alliance" },
		[69403140] = { tram=true, label=DrTtoIF, note=DunMorogh },
		},
	[499] = { -- Deeprun Tram
		[42554350] = { tram=true, label=DrTtoIF, note=DunMorogh, },
		[42556750] = { tram=true, label=DrTtoIF, note=DunMorogh, },
		},	
	[37] = { -- Elwynn Forest
		[17804775] = { portal=true, label1=PtoDala.." ("..CrystalsongForest..")\n"..format(PtoJadeForest.." ("..Pandaria..")\n"..PtoBoralus.." ("..TiragardeSound..")\n"..PtoAzsuna.." ("..BrokenIsles..")\n"..PtoStormshield.." ("..Ashran..")\n"..PtoShattrath.." ("..TerokkarForest..")\n"..PtoExodar.." ("..AzuremystIsle..")\n"..PtoCavernsofTime.." ("..Tanaris..")"),
									label2=PtoDala.."\n"..format(PtoJadeForest.."\n"..PtoBoralus.."\n"..PtoAzsuna.."\n"..PtoStormshield.."\n"..PtoShattrath.."\n"..PtoExodar.."\n"..PtoCavernsofTime..""), faction="Alliance" },
		[06003035] = { aboat=true, label=BtoBoralus, note=TiragardeSound, faction="Horde" },
		[03631530] = { aboat=true, label=BtoBoreanTundra, note=ValianceKeep, faction="Horde" },
		[07253035] = { portal=true, label=PtoDarnassus, note=Teldrassil, faction="Alliance" },
		[31801155] = { portal=true, label1=PtoTolBarad.." ("..EasternKingdoms..")\n"..format(PtoUldum.." ("..Kalimdor..")\n"..PtoDeepholm.." ("..Maelstrom..")\n"..PtoVashjir.." ("..EasternKingdoms..")\n"..PtoHyjal.." ("..Kalimdor..")\n"..PtoTwilightHighlands.." ("..EasternKingdoms..")"),
									label2=PtoTolBarad.."\n"..format(PtoUldum.."\n"..PtoDeepholm.."\n"..PtoVashjir.."\n"..PtoHyjal.."\n"..PtoTwilightHighlands..""), faction="Alliance" },
		[29251812] = { tram=true, label=DrTtoIF, note=DunMorogh },
		},
	[90] = { -- Undercity
		[85301700] = { spell= 290245, portal=true, label=PtoHellfirePeninsula, note=Outland, faction="Horde" },
		},
	[18] = { -- Tirisfal Glades
		[65906865] = { spell= 290245, portal=true, label=PtoHellfirePeninsula, note=Outland..")\n("..inUCMq.."", faction="Horde" },
		[59416743] = { spell= 290245, portal=true, label=PtoSM, note=EversongWoods..")\n("..Orboftranslocation.."", faction="Horde" },
		[60475885] = { spell= 290245, portal=true, label=PtoOG, note=Durotar, faction="Horde" },
		[62035926] = { spell= 290245, portal=true, label=PtoStranglethornVale, note=GromgolBaseCamp, faction="Horde" },
		[58875901] = { spell= 290245, portal=true, label=PtoHowlingFjord, note=VengeanceLanding, faction="Horde" },
		},
	[21] = { -- Silverpine Forest
--		[47254337] = { portal=true, label=PtoDalaCrater, note=HillsbradFoothills, faction="Horde" }, --questid missing
		},
	[25] = { -- Hillsbrad Foothills
--		[30293662] = { portal=true, label=Ptotomb, note=SilverpineForest, faction="Horde" }, --questid missing
		},
	[14] = { -- Arathi Highlands
		[27432937] = { portal=true, label=PtoPortofZandalar, note=Zuldazar, lvl=120, faction="Horde", warfront="arathi" },
		[21956514] = { portal=true, label=PtoPortofBoralus, note=TiragardeSound, lvl=120, faction="Alliance", warfront="arathi" },
		},
	[50] = { -- Northern Stranglethorn
		[37195161] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
		},
	[224] = { --Stranglethorn Vale
		[41403390] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
		},
	[23] = { -- Eastern Plaguelands
		[75234942] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="PALADIN" },
		},
	[27] = { -- Dun Morogh
		[70452731] = { tram=true, label=DrTtoSW, note=ElwynnForest, },
		},
	[87] = { -- Ironforge
		[76205120] = { tram=true, label=DrTtoSW, note=ElwynnForest, },
		},
}