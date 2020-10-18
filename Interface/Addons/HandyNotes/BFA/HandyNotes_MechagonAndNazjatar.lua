-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local MechagonAndNazjatar = {}

-------------------------------------------------------------------------------
----------------------------------- COLORS ------------------------------------
-------------------------------------------------------------------------------

MechagonAndNazjatar.COLORS = {
    Blue = 'FF0066FF',
    Green = 'FF00FF00',
    Gray = 'FF999999',
    Red = 'FFFF0000',
    Orange = 'FFFF8C00',
    Yellow = 'FFFFFF00',
    White = 'FFFFFFFF',
    --------------------
    NPC = 'FFFFFD00',
    Spell = 'FF71D5FF'
}

MechagonAndNazjatar.color = {}
MechagonAndNazjatar.status = {}

for name, color in pairs(MechagonAndNazjatar.COLORS) do
    MechagonAndNazjatar.color[name] = function (t) return string.format('|c%s%s|r', color, t) end
    MechagonAndNazjatar.status[name] = function (t) return string.format('(|c%s%s|r)', color, t) end
end

-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 

-------------------------------------------------------------------------------
------------------------------------ CLASS ------------------------------------
-------------------------------------------------------------------------------

MechagonAndNazjatar.Class = function (name, parent, attrs)
    if type(name) ~= 'string' then error('name param must be a string') end
    if parent and not MechagonAndNazjatar.IsClass(parent) then error('parent param must be a class') end

    local Class = attrs or {}
    Class.getters = Class.getters or {}
    Class.setters = Class.setters or {}

    setmetatable(Class, {
        __call = function (self, ...)
            local instance = {}
            instance.__class = Class

            local address = tostring(instance):gsub("table: ", "", 1)

            setmetatable(instance, {
                __tostring = function ()
                    return '<'..name..' object at '..address..'>'
                end,

                __index = function (self, index)
                    -- Walk up the class hierarchy and check for a static value
                    -- followed by a getter function on each parent class
                    local _Class = Class
                    repeat
                        -- Use rawget to skip __index on Class, we want to
                        -- check each class object individually
                        local value = rawget(_Class, index)
                        if value ~= nil then return value end
                        local getter = _Class.getters[index]
                        if getter then return getter(self) end
                        _Class = _Class.__parent
                    until _Class == nil
                end,

                __newindex = function (self, index, value)
                    local setter = Class.setters[index]
                    if setter then
                        setter(self, value)
                    else
                        rawset(self, index, value)
                    end
                end
            })

            instance:Initialize(...)
            return instance
        end,

        __tostring = function ()
            return '<class "'..name..'">'
        end,

        -- Make parent class attributes accessible on child class objects
        __index = parent
    })

    if parent then
        -- Set parent class and allow parent class setters to be used
        Class.__parent = parent
        setmetatable(Class.setters, { __index = parent.setters })
    elseif not Class.Initialize then
        -- Add default Initialize() method for base class
        Class.Initialize = function (self) end
    end

    return Class
end

-------------------------------------------------------------------------------
----------------------------------- HELPERS -----------------------------------
-------------------------------------------------------------------------------

MechagonAndNazjatar.IsClass = function (class)
    return type(class) == 'table' and class.getters and class.setters
end

MechagonAndNazjatar.IsInstance = function (instance, class)
    if type(instance) ~= 'table' then return false end
    local function compare (c1, c2)
        if c2 == nil then return false end
        if c1 == c2 then return true end
        return compare(c1, c2.__parent)
    end
    return compare(class, instance.__class)
end

MechagonAndNazjatar.Clone = function (instance, newattrs)
    local clone = {}
    for k, v in pairs(instance) do clone[k] = v end
    if newattrs then
        for k, v in pairs(newattrs) do clone[k] = v end
    end
    return instance.__class(clone)
end


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 

local HandyNotes_MechagonAndNazjatar = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_MechagonAndNazjatar", "AceBucket-3.0", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes")

MechagonAndNazjatar.locale = L
MechagonAndNazjatar.maps = {}

_G["HandyNotes_MechagonAndNazjatar"] = HandyNotes_MechagonAndNazjatar

-------------------------------------------------------------------------------
----------------------------------- HELPERS -----------------------------------
-------------------------------------------------------------------------------

local DropdownMenu = CreateFrame("Frame", "HandyNotes_MechagonAndNazjatarDropdownMenu");
DropdownMenu.displayMode = "MENU"
local function InitializeDropdownMenu(level, mapID, coord)
    if not level then return end
    local node = MechagonAndNazjatar.maps[mapID].nodes[coord]
    local spacer = {text='', disabled=1, notClickable=1, notCheckable=1}

    if (level == 1) then
        UIDropDownMenu_AddButton({
            text=L["context_menu_title_Mechagon"], isTitle=1, notCheckable=1
        }, level)

        UIDropDownMenu_AddButton(spacer, level)

        UIDropDownMenu_AddButton({
            text=L["context_menu_set_waypoint"], notCheckable=1,
            disabled=not C_Map.CanSetUserWaypointOnMap(mapID),
            func=function (button)
                local x, y = HandyNotes:getXY(coord)
                C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(mapID, x, y))
                C_SuperTrack.SetSuperTrackedUserWaypoint(true)
            end
        }, level)

        if select(2, IsAddOnLoaded('TomTom')) then
            UIDropDownMenu_AddButton({
                text=L["context_menu_add_tomtom"], notCheckable=1,
                func=function (button)
                    local x, y = HandyNotes:getXY(coord)
                    TomTom:AddWaypoint(mapID, x, y, {
                        title = MechagonAndNazjatar.NameResolver:Resolve(node.label),
                        persistent = nil,
                        minimap = true,
                        world = true
                    })
                end
            }, level)
        end

        UIDropDownMenu_AddButton({
            text=L["context_menu_hide_node"], notCheckable=1,
            func=function (button)
                HandyNotes_MechagonAndNazjatar.db.char[mapID..'_coord_'..coord] = true
                HandyNotes_MechagonAndNazjatar:Refresh()
            end
        }, level)

        UIDropDownMenu_AddButton({
            text=L["context_menu_restore_hidden_nodes"], notCheckable=1,
            func=function ()
                wipe(HandyNotes_MechagonAndNazjatar.db.char)
                HandyNotes_MechagonAndNazjatar:Refresh()
            end
        }, level)

        UIDropDownMenu_AddButton(spacer, level)

        UIDropDownMenu_AddButton({
            text=CLOSE, notCheckable=1,
            func=function() CloseDropDownMenus() end
        }, level)
    end
end

-------------------------------------------------------------------------------
---------------------------------- CALLBACKS ----------------------------------
-------------------------------------------------------------------------------

function HandyNotes_MechagonAndNazjatar:OnEnter(mapID, coord)
    local node = MechagonAndNazjatar.maps[mapID].nodes[coord]
    local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip

    if self:GetCenter() > UIParent:GetCenter() then
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end

    node:Render(tooltip)
    node._hover = true
    MechagonAndNazjatar.MinimapDataProvider:RefreshAllData()
    MechagonAndNazjatar.WorldMapDataProvider:RefreshAllData()
    tooltip:Show()
end

function HandyNotes_MechagonAndNazjatar:OnLeave(mapID, coord)
    local node = MechagonAndNazjatar.maps[mapID].nodes[coord]
    node._hover = false
    MechagonAndNazjatar.MinimapDataProvider:RefreshAllData()
    MechagonAndNazjatar.WorldMapDataProvider:RefreshAllData()
    if self:GetParent() == WorldMapButton then
        WorldMapTooltip:Hide()
    else
        GameTooltip:Hide()
    end
end

function HandyNotes_MechagonAndNazjatar:OnClick(button, down, mapID, coord)
    local node = MechagonAndNazjatar.maps[mapID].nodes[coord]
    if button == "RightButton" and down then
        DropdownMenu.initialize = function (_, level)
            InitializeDropdownMenu(level, mapID, coord)
        end
        ToggleDropDownMenu(1, nil, DropdownMenu, self, 0, 0)
    elseif button == "LeftButton" and down then
        if node.pois then
            node._focus = not node._focus
            HandyNotes_MechagonAndNazjatar:Refresh()
        end
    end
end

function HandyNotes_MechagonAndNazjatar:OnInitialize()
    MechagonAndNazjatar.faction = UnitFactionGroup('player')
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_MechagonAndNazjatarDB", MechagonAndNazjatar.optionDefaults, "Default")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", function ()
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        self:ScheduleTimer("RegisterWithHandyNotes", 1)
    end)

    -- Add global groups to settings panel
    MechagonAndNazjatar.CreateGlobalGroupOptions()

    -- Add quick-toggle menu button to top-right corner of world map
    WorldMapFrame:AddOverlayFrame(
        "HandyNotes_MechagonAndNazjatarWorldMapOptionsButtonTemplate",
        "DROPDOWNTOGGLEBUTTON", "TOPRIGHT",
        WorldMapFrame:GetCanvasContainer(), "TOPRIGHT", -68, -2
    )
end

-------------------------------------------------------------------------------
------------------------------------ MAIN -------------------------------------
-------------------------------------------------------------------------------

function HandyNotes_MechagonAndNazjatar:RegisterWithHandyNotes()
    do
        local map, minimap
        local function iter(nodes, precoord)
            if not nodes then return nil end
            if minimap and MechagonAndNazjatar:GetOpt('hide_minimap') then return nil end
            local coord, node = next(nodes, precoord)
            while coord do -- Have we reached the end of this zone?
                if node and map:IsNodeEnabled(node, coord, minimap) then
                    local icon, scale, alpha = node:GetDisplayInfo(map)
                    return coord, nil, icon, scale, alpha
                end
                coord, node = next(nodes, coord) -- Get next node
            end
            return nil, nil, nil, nil
        end
        function HandyNotes_MechagonAndNazjatar:GetNodes2(mapID, _minimap)
            if MechagonAndNazjatar:GetOpt('show_debug_map') then
                MechagonAndNazjatar.Debug('Loading nodes for map: '..mapID..' (minimap='..tostring(_minimap)..')')
            end
            map = MechagonAndNazjatar.maps[mapID]
            minimap = _minimap

            if map then
                map:Prepare()
                return iter, map.nodes, nil
            end

            -- mapID not handled by this plugin
            return iter, nil, nil
        end
    end

    if MechagonAndNazjatar:GetOpt('development') then
        MechagonAndNazjatar.BootstrapDevelopmentEnvironment()
    end

    HandyNotes:RegisterPluginDB("HandyNotes_MechagonAndNazjatar", self, MechagonAndNazjatar.options)

    self:RegisterBucketEvent({
        "LOOT_CLOSED", "PLAYER_MONEY", "SHOW_LOOT_TOAST",
        "SHOW_LOOT_TOAST_UPGRADE", "QUEST_TURNED_IN"
    }, 2, "Refresh")

    self:Refresh()
end

function HandyNotes_MechagonAndNazjatar:Refresh()
    if self._refreshTimer then return end
    self._refreshTimer = C_Timer.NewTimer(0.1, function ()
        self._refreshTimer = nil
    self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_MechagonAndNazjatar")
        MechagonAndNazjatar.MinimapDataProvider:RefreshAllData()
        MechagonAndNazjatar.WorldMapDataProvider:RefreshAllData()
    end)
end


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 

-------------------------------------------------------------------------------
------------------------------- TEXTURE ATLASES -------------------------------
-------------------------------------------------------------------------------

local ICONS = "Interface\\Addons\\HandyNotes\\Icons\\icons.blp"
local ICONS_WIDTH = 255
local ICONS_HEIGHT = 255


local function coords(x, y, grid, xo, yo)
    grid, xo, yo = grid or 32, xo or 0, yo or 0
    return { xo+x*grid, xo+(x+1)*grid-1, yo+y*grid, yo+(y+1)*grid-1 }
end

MechagonAndNazjatar.icons = {

    ---------------------------------------------------------------------------
    ---------------------------------- GAME -----------------------------------
    ---------------------------------------------------------------------------

    default = "Interface\\Icons\\TRADE_ARCHAEOLOGY_CHESTOFTINYGLASSANIMALS",
    diablo_murloc = "Interface\\Icons\\inv_pet_diablobabymurloc.blp",
    emerald_cat = "Interface\\Icons\\trade_archaeology_catstatueemeraldeyes.blp",
    green_egg = "Interface\\Icons\\Inv_egg_02.blp",
    slime = "Interface\\Icons\\ability_creature_poison_05.blp",
    quest_chalice = 236669,

    ---------------------------------------------------------------------------
    -------------------------------- EMBEDDED ---------------------------------
    ---------------------------------------------------------------------------

    -- coords={l, r, t, b}

    quest_yellow = { icon=ICONS, coords=coords(0, 0), glow='quest' },
    quest_blue = { icon=ICONS, coords=coords(0, 1), glow='quest' },
    quest_orange = { icon=ICONS, coords=coords(0, 2), glow='quest' },
    quest_green = { icon=ICONS, coords=coords(0, 3), glow='quest' },
    quest_yellow_old = { icon=ICONS, coords=coords(0, 4), glow='quest' },
    quest_blue_old = { icon=ICONS, coords=coords(0, 5), glow='quest' },

    quest_repeat_yellow = { icon=ICONS, coords=coords(0, 6), glow='quest_repeat' },
    quest_repeat_blue = { icon=ICONS, coords=coords(0, 7), glow='quest_repeat' },
    quest_repeat_orange = { icon=ICONS, coords=coords(1, 0), glow='quest_repeat' },
    quest_repeat_blue_old = { icon=ICONS, coords=coords(1, 1), glow='quest_repeat' },

    peg_blue = { icon=ICONS, coords=coords(1, 2), glow='peg' },
    peg_red = { icon=ICONS, coords=coords(1, 3), glow='peg' },
    peg_green = { icon=ICONS, coords=coords(1, 4), glow='peg' },
    peg_yellow = { icon=ICONS, coords=coords(1, 5), glow='peg' },

    gpeg_red = { icon=ICONS, coords=coords(1, 6), glow='peg' },
    gpeg_green = { icon=ICONS, coords=coords(1, 7), glow='peg' },
    gpeg_yellow = { icon=ICONS, coords=coords(2, 7), glow='peg' },

    envelope = { icon=ICONS, coords=coords(0, 8), glow='envelope' },
    horseshoe = { icon=ICONS, coords=coords(0, 9), glow='horseshoe' },
    world_quest = { icon=ICONS, coords=coords(0, 10), glow='world_quest' },
    anima_crystal = { icon=ICONS, coords=coords(1, 9), glow='crystal' },
    left_mouse = { icon=ICONS, coords=coords(2, 9) },
    orange_crystal = { icon=ICONS, coords=coords(2, 6), glow='crystal' },

    door_down = { icon=ICONS, coords=coords(2, 0), glow='door' },
    door_left = { icon=ICONS, coords=coords(2, 1), glow='door' },
    door_right = { icon=ICONS, coords=coords(2, 2), glow='door' },
    door_up = { icon=ICONS, coords=coords(2, 3), glow='door' },

    portal_blue = { icon=ICONS, coords=coords(2, 4), glow='portal' },
    portal_red = { icon=ICONS, coords=coords(2, 5), glow='portal' },
    portal_green = { icon=ICONS, coords=coords(3, 9), glow='portal' },
    portal_purple = { icon=ICONS, coords=coords(4, 9), glow='portal' },

    chest_gray = { icon=ICONS, coords=coords(3, 0), glow='treasure' },
    chest_yellow = { icon=ICONS, coords=coords(3, 1), glow='treasure' },
    chest_orange = { icon=ICONS, coords=coords(3, 2), glow='treasure' },
    chest_red = { icon=ICONS, coords=coords(3, 3), glow='treasure' },
    chest_purple = { icon=ICONS, coords=coords(3, 4), glow='treasure' },
    chest_blue = { icon=ICONS, coords=coords(3, 5), glow='treasure' },
    chest_lblue = { icon=ICONS, coords=coords(3, 6), glow='treasure' },
    chest_teal = { icon=ICONS, coords=coords(3, 7), glow='treasure' },
    chest_camo = { icon=ICONS, coords=coords(4, 0), glow='treasure' },
    chest_lime = { icon=ICONS, coords=coords(4, 1), glow='treasure' },
    chest_brown = { icon=ICONS, coords=coords(4, 2), glow='treasure' },
    chest_white = { icon=ICONS, coords=coords(4, 3), glow='treasure' },

    paw_yellow = { icon=ICONS, coords=coords(4, 4), glow='paw' },
    paw_green = { icon=ICONS, coords=coords(4, 5), glow='paw' },

    skull_white = { icon=ICONS, coords=coords(4, 6), glow='skull' },
    skull_blue = { icon=ICONS, coords=coords(4, 7), glow='skull' },

    star_chest = { icon=ICONS, coords=coords(0, 0, 48, 160), glow='star_chest' },
    star_skull = { icon=ICONS, coords=coords(0, 1, 48, 160), glow='star_chest' },
    star_swords = { icon=ICONS, coords=coords(0, 2, 48, 160), glow='star_chest' },

    shootbox_blue = { icon=ICONS, coords=coords(0, 3, 48, 160), glow='shootbox' },
    shootbox_yellow = { icon=ICONS, coords=coords(0, 4, 48, 160), glow='shootbox' },
    shootbox_pink = { icon=ICONS, coords=coords(0, 5, 48, 160), glow='shootbox' },

    kyrian_sigil = { icon=ICONS, coords=coords(1, 8)},
    necrolord_sigil = { icon=ICONS, coords=coords(2, 8)},
    nightfae_sigil = { icon=ICONS, coords=coords(3, 8)},
    venthyr_sigil = { icon=ICONS, coords=coords(4, 8)},
}


local function InitIcon(icon, width, height)
    if type(icon) == 'table' then
        icon.tCoordLeft = icon.coords[1]/width
        icon.tCoordRight = icon.coords[2]/width
        icon.tCoordTop = icon.coords[3]/height
        icon.tCoordBottom = icon.coords[4]/height
        function icon:link (size)
            return (
                "|T"..ICONS..":"..size..":"..size..":0:0:"..
                (width+1)..":"..(height+1)..":"..
                self.coords[1]..":"..self.coords[2]..":"..
                self.coords[3]..":"..self.coords[4].."|t"
            )
        end
    end
end

for name, icon in pairs(MechagonAndNazjatar.icons) do InitIcon(icon, ICONS_WIDTH, ICONS_HEIGHT) end


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 
local L = MechagonAndNazjatar.locale

-------------------------------------------------------------------------------
---------------------------------- DEFAULTS -----------------------------------
-------------------------------------------------------------------------------

MechagonAndNazjatar.optionDefaults = {
    profile = {
        -- visibility
        hide_done_rares = false,
        hide_minimap = false,
        show_completed_nodes = false,

        -- tooltip
        show_loot = true,
        show_notes = true,

        -- development
        development = false,
        show_debug_map = false,
        show_debug_quest = false,
        force_nodes = false,

        -- poi/path scale
        poi_scale = 1,

        -- poi color
        poi_color_R = 0,
        poi_color_G = 0.5,
        poi_color_B = 1,
        poi_color_A = 1,

        -- path color
        path_color_R = 0,
        path_color_G = 0.5,
        path_color_B = 1,
        path_color_A = 1
    },
}

-------------------------------------------------------------------------------
----------------------------------- HELPERS -----------------------------------
-------------------------------------------------------------------------------

function MechagonAndNazjatar:GetOpt(n) return HandyNotes_MechagonAndNazjatar.db.profile[n] end
function MechagonAndNazjatar:SetOpt(n, v) HandyNotes_MechagonAndNazjatar.db.profile[n] = v; HandyNotes_MechagonAndNazjatar:Refresh() end

function MechagonAndNazjatar:GetColorOpt(n)
    local db = HandyNotes_MechagonAndNazjatar.db.profile
    return db[n..'_R'], db[n..'_G'], db[n..'_B'], db[n..'_A']
end

function MechagonAndNazjatar:SetColorOpt(n, r, g, b, a)
    local db = HandyNotes_MechagonAndNazjatar.db.profile
    db[n..'_R'], db[n..'_G'], db[n..'_B'], db[n..'_A'] = r, g, b, a
    HandyNotes_MechagonAndNazjatar:Refresh()
end

-------------------------------------------------------------------------------
--------------------------------- OPTIONS UI ----------------------------------
-------------------------------------------------------------------------------

MechagonAndNazjatar.options = {
    type = "group",
    name = L["options_title_Mechagon"],
    childGroups = "tab",
    get = function(info) return MechagonAndNazjatar:GetOpt(info.arg) end,
    set = function(info, v) MechagonAndNazjatar:SetOpt(info.arg, v) end,
    args = {
        GeneralTab = {
            type = "group",
            name = L["options_general_settings"],
            desc = L["options_general_description"],
            order = 0,
            args = {
                VisibilityHeader = {
                    type = "header",
                    name = L["options_visibility_settings"],
                    order = 10,
                },
                show_completed_nodes = {
                    type = "toggle",
                    arg = "show_completed_nodes",
                    name = L["options_show_completed_nodes"],
                    desc = L["options_show_completed_nodes_desc"],
                    order = 11,
                    width = "full",
                },
                hide_done_rare = {
                    type = "toggle",
                    arg = "hide_done_rares",
                    name = L["options_toggle_hide_done_rare"],
                    desc = L["options_toggle_hide_done_rare_desc"],
                    order = 12,
                    width = "full",
                },
                hide_minimap = {
                    type = "toggle",
                    arg = "hide_minimap",
                    name = L["options_toggle_hide_minimap"],
                    desc = L["options_toggle_hide_minimap_desc"],
                    order = 13,
                    width = "full",
                },
                restore_all_nodes = {
                    type = "execute",
                    name = L["options_restore_hidden_nodes"],
                    desc = L["options_restore_hidden_nodes_desc"],
                    order = 14,
                    width = "full",
                    func = function ()
                        wipe(HandyNotes_MechagonAndNazjatar.db.char)
                        HandyNotes_MechagonAndNazjatar:Refresh()
                    end
                },
                FocusHeader = {
                    type = "header",
                    name = L["options_focus_settings"],
                    order = 20,
                },
                POI_scale = {
                    type = "range",
                    name = L["options_scale"],
                    desc = L["options_scale_desc"],
                    min = 1, max = 3, step = 0.01,
                    arg = "poi_scale",
                    width = "full",
                    order = 21,
                },
                POI_color = {
                    type = "color",
                    name = L["options_poi_color"],
                    desc = L["options_poi_color_desc"],
                    hasAlpha = true,
                    set = function(_, ...) MechagonAndNazjatar:SetColorOpt('poi_color', ...) end,
                    get = function() return MechagonAndNazjatar:GetColorOpt('poi_color') end,
                    order = 22,
                },
                PATH_color = {
                    type = "color",
                    name = L["options_path_color"],
                    desc = L["options_path_color_desc"],
                    hasAlpha = true,
                    set = function(_, ...) MechagonAndNazjatar:SetColorOpt('path_color', ...) end,
                    get = function() return MechagonAndNazjatar:GetColorOpt('path_color') end,
                    order = 23,
                },
                restore_poi_colors = {
                    type = "execute",
                    name = L["options_reset_poi_colors"],
                    desc = L["options_reset_poi_colors_desc"],
                    order = 24,
                    width = "full",
                    func = function ()
                        local df = MechagonAndNazjatar.optionDefaults.profile
                        MechagonAndNazjatar:SetColorOpt('poi_color', df.poi_color_R, df.poi_color_G, df.poi_color_B, df.poi_color_A)
                        MechagonAndNazjatar:SetColorOpt('path_color', df.path_color_R, df.path_color_G, df.path_color_B, df.path_color_A)
                    end
                },
                TooltipsHeader = {
                    type = "header",
                    name = L["options_tooltip_settings"],
                    order = 30,
                },
                show_loot = {
                    type = "toggle",
                    arg = "show_loot",
                    name = L["options_toggle_show_loot"],
                    desc = L["options_toggle_show_loot_desc"],
                    order = 31,
                },
                show_notes = {
                    type = "toggle",
                    arg = "show_notes",
                    name = L["options_toggle_show_notes"],
                    desc = L["options_toggle_show_notes_desc"],
                    order = 32,
                }
            }
        },
        GlobalTab = {
            type = "group",
            name = L["options_global"],
            desc = L["options_global_description"],
            order = 1,
            args = {
            }
        },
        ZonesTab = {
            type = "group",
            name = L["options_zones"],
            desc = L["options_zones_description"],
            childGroups = "select",
            order = 2,
            args = {
            }
        }
    }
}

-- Display these groups in the global settings tab. They are the most common
-- group options that players might want to customize.

function MechagonAndNazjatar.CreateGlobalGroupOptions()
    for i, group in ipairs({
        MechagonAndNazjatar.groups.RARE,
        MechagonAndNazjatar.groups.TREASURE,
        MechagonAndNazjatar.groups.PETBATTLE,
        MechagonAndNazjatar.groups.OTHER
    }) do
        MechagonAndNazjatar.options.args.GlobalTab.args['group_icon_'..group.name] = {
            type = "header",
            name = L["options_icons_"..group.name],
            order = i * 10,
        }

        MechagonAndNazjatar.options.args.GlobalTab.args['icon_scale_'..group.name] = {
            type = "range",
            name = L["options_scale"],
            desc = L["options_scale_desc"],
            min = 0.3, max = 3, step = 0.01,
            arg = group.scaleArg,
            width = 1.13,
            order = i * 10 + 1,
        }

        MechagonAndNazjatar.options.args.GlobalTab.args['icon_alpha_'..group.name] = {
            type = "range",
            name = L["options_opacity"],
            desc = L["options_opacity_desc"],
            min = 0, max = 1, step = 0.01,
            arg = group.alphaArg,
            width = 1.13,
            order = i * 10 + 2,
        }
    end
end

-------------------------------------------------------------------------------
------------------------------- OPTIONS HELPERS -------------------------------
-------------------------------------------------------------------------------

local _INITIALIZED = {}

function MechagonAndNazjatar.CreateGroupOptions (map, group)
    -- Check if we've already initialized this group
    if _INITIALIZED[group.name..map.id] then return end
    _INITIALIZED[group.name..map.id] = true

    -- Create map options group under zones tab
    local options = MechagonAndNazjatar.options.args.ZonesTab.args['Zone_'..map.id]
    if not options then
        options = {
            type = "group",
            name = C_Map.GetMapInfo(map.id).name,
            args = {
                IconsGroup = {
                    type = "group",
                    name = L["options_icon_settings"],
                    inline = true,
                    order = 1,
                    args = {}
                },
                VisibilityGroup = {
                    type = "group",
                    name = L["options_visibility_settings"],
                    inline = true,
                    order = 2,
                    args = {}
                }
            }
        }
        MechagonAndNazjatar.options.args.ZonesTab.args['Zone_'..map.id] = options
    end

    map._icons_order = map._icons_order or 0
    map._visibility_order = map._visibility_order or 0

    options.args.IconsGroup.args["icon_toggle_"..group.name] = {
        type = "toggle",
        arg = group.displayArg,
        name = L["options_icons_"..group.name],
        desc = L["options_icons_"..group.name.."_desc"],
        disabled = function () return not group:IsEnabled() end,
        width = 0.9,
        order = map._icons_order
    }

    options.args.VisibilityGroup.args["header_"..group.name] = {
        type = "header",
        name = L["options_icons_"..group.name],
        order = map._visibility_order
    }

    options.args.VisibilityGroup.args['icon_scale_'..group.name] = {
        type = "range",
        name = L["options_scale"],
        desc = L["options_scale_desc"],
        disabled = function () return not (group:IsEnabled() and group:GetDisplay()) end,
        min = 0.3, max = 3, step = 0.01,
        arg = group.scaleArg,
        width = 0.95,
        order = map._visibility_order + 1
    }

    options.args.VisibilityGroup.args['icon_alpha_'..group.name] = {
        type = "range",
        name = L["options_opacity"],
        desc = L["options_opacity_desc"],
        disabled = function () return not (group:IsEnabled() and group:GetDisplay()) end,
        min = 0, max = 1, step = 0.01,
        arg = group.alphaArg,
        width = 0.95,
        order = map._visibility_order + 2
    }

    map._icons_order = map._icons_order + 1
    map._visibility_order = map._visibility_order + 3
end


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 
local L = MechagonAndNazjatar.locale

-------------------------------------------------------------------------------
--------------------------------- DEVELOPMENT ---------------------------------
-------------------------------------------------------------------------------

--[[

To enable all development settings and functionality:

    1. Tweak any setting in the addon and exit the game.
    2. Open the settings file for this addon.
        WTF/Account/<account>/SavedVariables/HandyNotes_<this_addon>.lua
    3. Add a new line under profiles => Default.
        ["development"] = true,
    4. Save and star the game. You should now see development settings
       at the bottom of the addon settings window.

--]]

local function BootstrapDevelopmentEnvironment()
    -- Add development settings to the UI
    MechagonAndNazjatar.options.args.GeneralTab.args.DevelopmentHeader = {
        type = "header",
        name = L["options_dev_settings"],
        order = 100,
    }
    MechagonAndNazjatar.options.args.GeneralTab.args.show_debug_map = {
        type = "toggle",
        arg = "show_debug_map",
        name = L["options_toggle_show_debug_map"],
        desc = L["options_toggle_show_debug_map_desc"],
        order = 101,
    }
    MechagonAndNazjatar.options.args.GeneralTab.args.show_debug_quest = {
        type = "toggle",
        arg = "show_debug_quest",
        name = L["options_toggle_show_debug_quest"],
        desc = L["options_toggle_show_debug_quest_desc"],
        order = 102,
    }
    MechagonAndNazjatar.options.args.GeneralTab.args.force_nodes = {
        type = "toggle",
        arg = "force_nodes",
        name = L["options_toggle_force_nodes"],
        desc = L["options_toggle_force_nodes_desc"],
        order = 103,
    }

    -- Register all addons objects for the CTRL+ALT handler
    local plugins = "HandyNotes_ZarPlugins"
    if _G[plugins] == nil then _G[plugins] = {} end
    _G[plugins][#_G[plugins] + 1] = MechagonAndNazjatar

    -- Initialize a history for quest ids so we still have a record after /reload
    if _G["HandyNotes_MechagonAndNazjatarDB"]['quest_id_history'] == nil then
        _G["HandyNotes_MechagonAndNazjatarDB"]['quest_id_history'] = {}
    end
    local history = _G["HandyNotes_MechagonAndNazjatarDB"]['quest_id_history']

    -- Print debug messages for each quest ID that is flipped
    local QTFrame = CreateFrame('Frame', "HandyNotes_MechagonAndNazjatarQT")
    local lastCheck = GetTime()
    local quests = {}
    local changed = {}
    local max_quest_id = 100000

    local function DebugQuest(...)
        if MechagonAndNazjatar:GetOpt('show_debug_quest') then MechagonAndNazjatar.Debug(...) end
    end

    C_Timer.After(2, function ()
        -- Give some time for quest info to load in before we start
        for id = 0, max_quest_id do quests[id] = C_QuestLog.IsQuestFlaggedCompleted(id) end
        QTFrame:SetScript('OnUpdate', function ()
            if GetTime() - lastCheck > 1 and MechagonAndNazjatar:GetOpt('show_debug_quest') then
                for id = 0, max_quest_id do
                    local s = C_QuestLog.IsQuestFlaggedCompleted(id)
                    if s ~= quests[id] then
                        changed[#changed + 1] = {'Quest', id, 'changed:', tostring(quests[id]), '=>', tostring(s)}
                        quests[id] = s
                    end
                end
                if #changed <= 10 then
                    -- changing zones will sometimes cause thousands of quest
                    -- ids to flip state, we do not want to report on those
                    for i, args in ipairs(changed) do
                        table.insert(history, 1, args)
                        DebugQuest(unpack(args))
                    end
                end
                if #history > 100 then
                    for i = #history, 101, -1 do
                        history[i] = nil
                    end
                end
                lastCheck = GetTime()
                wipe(changed)
            end
        end)
        DebugQuest('Quest IDs are now being tracked')
    end)

    -- Listen for LCTRL + LALT when the map is open to force display nodes
    local IQFrame = CreateFrame('Frame', "HandyNotes_MechagonAndNazjatarIQ", WorldMapFrame)
    local groupPins = WorldMapFrame.pinPools.GroupMembersPinTemplate
    IQFrame:SetPropagateKeyboardInput(true)
    IQFrame:SetScript('OnKeyDown', function (_, key)
        if (key == 'LCTRL' or key == 'LALT') and IsLeftControlKeyDown() and IsLeftAltKeyDown() then
            IQFrame:SetPropagateKeyboardInput(false)
            for i, _ns in ipairs(_G[plugins]) do
                if not _ns.dev_force then
                    _ns.dev_force = true
                    _ns.addon:Refresh()
                end
            end
            -- Hide player pins on the map
            groupPins:GetNextActive():Hide()
        end
    end)
    IQFrame:SetScript('OnKeyUp', function (_, key)
        if key == 'LCTRL' or key == 'LALT' then
            IQFrame:SetPropagateKeyboardInput(true)
            for i, _ns in ipairs(_G[plugins]) do
                if _ns.dev_force then
                    _ns.dev_force = false
                    _ns.addon:Refresh()
                end
            end
            -- Show player pins on the map
            groupPins:GetNextActive():Show()
        end
    end)
end

-------------------------------------------------------------------------------

-- Debug function that iterates over each pin template and removes it from the
-- map. This is helpful for determining which template a pin is coming from.

local hidden = {}
_G['HandyNotes_MechagonAndNazjatarRemovePins'] = function ()
    for k, v in pairs(WorldMapFrame.pinPools) do
        if not hidden[k] then
            hidden[k] = true
            print('Removing pin template:', k)
            WorldMapFrame:RemoveAllPinsByTemplate(k)
            return
        end
    end
end

-------------------------------------------------------------------------------

function MechagonAndNazjatar.Debug(...)
    if MechagonAndNazjatar:GetOpt('development') then print(MechagonAndNazjatar.color.Blue('DEBUG:'), ...) end
end

function MechagonAndNazjatar.Warn(...)
    if MechagonAndNazjatar:GetOpt('development') then print(MechagonAndNazjatar.color.Orange('WARN:'), ...) end
end

function MechagonAndNazjatar.Error(...)
    if MechagonAndNazjatar:GetOpt('development') then print(MechagonAndNazjatar.color.Red('ERROR:'), ...) end
end

-------------------------------------------------------------------------------

MechagonAndNazjatar.BootstrapDevelopmentEnvironment = BootstrapDevelopmentEnvironment

-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 
local Class = MechagonAndNazjatar.Class

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

--[[

Base class for all maps.

    id (integer): MapID value for this map
    intro (Node): An intro node to display when phased
    phased (boolean): If false, hide all nodes except the intro node.
    settings (boolean): Create a settings panel for this map (default: false).

--]]

local Map = Class('Map', nil, {
    id = 0,
    intro = nil,
    phased = true,
    settings = false
})

function Map:Initialize(attrs)
    for k, v in pairs(attrs) do self[k] = v end

    self.nodes = {}
    self.groups = {}
    self.settings = self.settings or false

    setmetatable(self.nodes, {
        __newindex = function (nodes, coord, node)
            self:AddNode(coord, node)
        end
    })

    -- auto-register this map
    if MechagonAndNazjatar.maps[self.id] then error('Map already registered: '..self.id) end
    MechagonAndNazjatar.maps[self.id] = self
end

function Map:AddNode(coord, node)
    if not MechagonAndNazjatar.IsInstance(node, MechagonAndNazjatar.node.Node) then
        error('All nodes must be instances of the Node() class:', coord, node)
    end

    if node.group.name ~= 'intro' then
        -- Initialize group defaults and UI controls for this map if the group does
        -- not inherit its settings and defaults from a parent map
        if self.settings then MechagonAndNazjatar.CreateGroupOptions(self, node.group) end

        -- Keep track of all groups associated with this map
        if not self.groups[node.group.name] then
            self.groups[#self.groups + 1] = node.group
            self.groups[node.group.name] = true
        end
    end

    rawset(self.nodes, coord, node)
end

function Map:Prepare()
    for coord, node in pairs(self.nodes) do
        -- prepare each node once to ensure its dependent data is loaded
        if not node._prepared then
            node:Prepare()
            node._prepared = true
        end
    end
end

function Map:IsNodeEnabled(node, coord, minimap)
    local db = HandyNotes_MechagonAndNazjatar.db

    -- Debug option to force display all nodes
    if MechagonAndNazjatar:GetOpt('force_nodes') or MechagonAndNazjatar.dev_force then return true end

    -- Check if the zone is still phased
    if node ~= self.intro and not self.phased then return false end

    -- Check if we've been hidden by the user
    if db.char[self.id..'_coord_'..coord] then return false end

    -- Minimap may be disabled for this node
    if not node.minimap and minimap then return false end

    -- Node may be faction restricted
    if node.faction and node.faction ~= MechagonAndNazjatar.faction then return false end

    -- Display the intro node!
    if node == self.intro then return not node:IsCompleted() end

    -- Check if node's group is disabled
    if not node.group:IsEnabled() then return false end

    -- Check for prerequisites and quest (or custom) completion
    if not node:IsEnabled() then return false end

    -- Display the node based off the group display setting
    return node.group:GetDisplay()
end

function Map:HasEnabledGroups()
    for i, group in ipairs(self.groups) do
        if group:IsEnabled() then return true end
    end
    return false
end

-------------------------------------------------------------------------------
---------------------------- MINIMAP DATA PROVIDER ----------------------------
-------------------------------------------------------------------------------

local HBD = LibStub("HereBeDragons-2.0")
local HBDPins = LibStub("HereBeDragons-Pins-2.0")
local MinimapPinsKey = "HandyNotes_MechagonAndNazjatarMinimapPins"
local MinimapDataProvider = CreateFrame("Frame", "HandyNotes_MechagonAndNazjatarMinimapDP")
local MinimapPinTemplate = 'HandyNotes_MechagonAndNazjatarMinimapPinTemplate'
local MinimapPinMixin = {}

_G['HandyNotes_MechagonAndNazjatarMinimapPinMixin'] = MinimapPinMixin

MinimapDataProvider.facing = GetPlayerFacing()
MinimapDataProvider.pins = {}
MinimapDataProvider.pool = {}
MinimapDataProvider.minimap = true

function MinimapDataProvider:ReleaseAllPins()
    for i, pin in ipairs(self.pins) do
        self.pool[pin] = true
        pin:OnReleased()
        pin:Hide()
    end
end

function MinimapDataProvider:AcquirePin(template, ...)
    local pin = next(self.pool)
    if pin then
        self.pool[pin] = nil -- remove it from the pool
    else
        pin = CreateFrame("Button", "HandyNotes_MechagonAndNazjatarPin"..(#self.pins + 1), Minimap, template)
        pin.provider = self
        pin:OnLoad()
        pin:Hide()
        self.pins[#self.pins + 1] = pin
    end
    pin:OnAcquired(...)
end

function MinimapDataProvider:RefreshAllData()
    -- Skip refresh if rotate minimap is on and we failed to get a facing value
    if GetCVar('rotateMinimap') == '1' and self.facing == nil then return end

    HBDPins:RemoveAllMinimapIcons(MinimapPinsKey)
    self:ReleaseAllPins()

    local map = MechagonAndNazjatar.maps[HBD:GetPlayerZone()]
    if not map then return end

    for coord, node in pairs(map.nodes) do
        if node._prepared and map:IsNodeEnabled(node, coord, true) then
            -- If this icon has a glow enabled, render it
            local glow = node:GetGlow(map)
            if glow then
                glow[1] = coord -- update POI coord for this placement
                glow:Render(self, MinimapPinTemplate)
            end

            -- Render any POIs this icon has registered
            if node.pois and (node._focus or node._hover) then
                for i, poi in ipairs(node.pois) do
                    poi:Render(self, MinimapPinTemplate)
                end
            end
        end
    end
end

function MinimapDataProvider:OnUpdate()
    local facing = GetPlayerFacing()
    if facing ~= self.facing then
        if GetCVar('rotateMinimap') == '1' then
            self:RefreshAllData()
        end
        self.facing = facing
    end
end

function MinimapPinMixin:OnLoad()
    self:SetFrameLevel(Minimap:GetFrameLevel() + 3)
    self:SetFrameStrata(Minimap:GetFrameStrata())
    self.minimap = true
end

function MinimapPinMixin:OnAcquired(poi, ...)
    local mapID = HBD:GetPlayerZone()
    local x, y = poi:Draw(self, ...)
    if GetCVar('rotateMinimap') == '1' then
        self.texture:SetRotation(self.texture:GetRotation() + math.pi*2 - self.provider.facing)
    end
    HBDPins:AddMinimapIconMap(MinimapPinsKey, self, mapID, x, y, true)
end

function MinimapPinMixin:OnReleased()
    if self.ticker then
        self.ticker:Cancel()
        self.ticker = nil
    end
end

MinimapDataProvider:SetScript('OnUpdate', function ()
    MinimapDataProvider:OnUpdate()
end)

HandyNotes_MechagonAndNazjatar:RegisterEvent('MINIMAP_UPDATE_ZOOM', function (...)
    MinimapDataProvider:RefreshAllData()
end)

HandyNotes_MechagonAndNazjatar:RegisterEvent('CVAR_UPDATE', function (_, varname)
    if varname == 'ROTATE_MINIMAP' then
        MinimapDataProvider:RefreshAllData()
    end
end)

-------------------------------------------------------------------------------
--------------------------- WORLD MAP DATA PROVIDER ---------------------------
-------------------------------------------------------------------------------

local WorldMapDataProvider = CreateFromMixins(MapCanvasDataProviderMixin)
local WorldMapPinTemplate = 'HandyNotes_MechagonAndNazjatarWorldMapPinTemplate'
local WorldMapPinMixin = CreateFromMixins(MapCanvasPinMixin)

_G['HandyNotes_MechagonAndNazjatarWorldMapPinMixin'] = WorldMapPinMixin

function WorldMapDataProvider:RemoveAllData()
    if self:GetMap() then
        self:GetMap():RemoveAllPinsByTemplate(WorldMapPinTemplate)
    end
end

function WorldMapDataProvider:RefreshAllData(fromOnShow)
    self:RemoveAllData()

    if not self:GetMap() then return end
    local map = MechagonAndNazjatar.maps[self:GetMap():GetMapID()]
    if not map then return end

    for coord, node in pairs(map.nodes) do
        if node._prepared and map:IsNodeEnabled(node, coord, false) then
            -- If this icon has a glow enabled, render it
            local glow = node:GetGlow(map)
            if glow then
                glow[1] = coord -- update POI coord for this placement
                glow:Render(self:GetMap(), WorldMapPinTemplate)
            end

            -- Render any POIs this icon has registered
            if node.pois and (node._focus or node._hover) then
                for i, poi in ipairs(node.pois) do
                    poi:Render(self:GetMap(), WorldMapPinTemplate)
                end
            end
        end
    end
end

function WorldMapPinMixin:OnLoad()
    -- The MAP_HIGHLIGHT frame level is well below the level standard
    -- HandyNotes pins use, preventing mouseover conflicts
    self:UseFrameLevelType("PIN_FRAME_LEVEL_MAP_HIGHLIGHT")
end

function WorldMapPinMixin:OnAcquired(poi, ...)
    local _, _, w, h = self:GetParent():GetRect()
    self.parentWidth = w
    self.parentHeight = h
    if (w and h) then
        local x, y = poi:Draw(self, ...)
        self:ApplyCurrentScale()
        self:SetPosition(x, y)
    end
end

function WorldMapPinMixin:OnReleased()
    if self.ticker then
        self.ticker:Cancel()
        self.ticker = nil
    end
end

function WorldMapPinMixin:ApplyFrameLevel()
    -- Allow frame level adjustments in POIs even if the current frame level
    -- type has a range of only 1 frame level
    MapCanvasPinMixin.ApplyFrameLevel(self)
    self:SetFrameLevel(self:GetFrameLevel() + self.frameOffset)
end

-------------------------------------------------------------------------------
------------------------------ HANDYNOTES HOOKS -------------------------------
-------------------------------------------------------------------------------

-- HandyNotes removes its data provider from the world map when the global
-- enable/disable checkbox is toggled at the top of its UI window. We need
-- to do the same thing here or our paths will still display.

local OnEnable = HandyNotes.OnEnable
local OnDisable = HandyNotes.OnDisable

function HandyNotes:OnEnable()
    OnEnable(self)
    if not HandyNotes.db.profile.enabled then return end
    WorldMapFrame:AddDataProvider(WorldMapDataProvider)
end

function HandyNotes:OnDisable()
    OnDisable(self)
    if WorldMapFrame.dataProviders[WorldMapDataProvider] then
        WorldMapFrame:RemoveDataProvider(WorldMapDataProvider)
    end
end

-------------------------------------------------------------------------------

MechagonAndNazjatar.Map = Map
MechagonAndNazjatar.MinimapDataProvider = MinimapDataProvider
MechagonAndNazjatar.WorldMapDataProvider = WorldMapDataProvider



-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 
local Class = MechagonAndNazjatar.Class

-------------------------------------------------------------------------------
------------------------------------ GROUP ------------------------------------
-------------------------------------------------------------------------------

local Group = Class('Group')

function Group:Initialize(name, defaults)
    if not name then error('Groups must be initialized with a name!') end

    self.name = name
    self.defaults = defaults

    self.alphaArg = 'icon_alpha_'..self.name
    self.scaleArg = 'icon_scale_'..self.name
    self.displayArg = 'icon_display_'..self.name

    local opt_defaults = MechagonAndNazjatar.optionDefaults.profile
    if not self.defaults then self.defaults = {} end
    opt_defaults[self.alphaArg] = self.defaults.alpha or 1
    opt_defaults[self.scaleArg] = self.defaults.scale or 1
    opt_defaults[self.displayArg] = self.defaults.display ~= false
end

-- Override to hide this group in the UI under certain circumstances
function Group:IsEnabled() return true end

-- Get group settings
function Group:GetAlpha() return MechagonAndNazjatar:GetOpt(self.alphaArg) end
function Group:GetScale() return MechagonAndNazjatar:GetOpt(self.scaleArg) end
function Group:GetDisplay() return MechagonAndNazjatar:GetOpt(self.displayArg) end

-- Set group settings
function Group:SetAlpha(v) MechagonAndNazjatar:SetOpt(self.alphaArg, v) end
function Group:SetScale(v) MechagonAndNazjatar:SetOpt(self.scaleArg, v) end
function Group:SetDisplay(v) MechagonAndNazjatar:SetOpt(self.displayArg, v) end

-------------------------------------------------------------------------------

MechagonAndNazjatar.Group = Group

MechagonAndNazjatar.GROUP_HIDDEN = {display=false}
MechagonAndNazjatar.GROUP_ALPHA75 = {alpha=0.75}

MechagonAndNazjatar.groups = {
    CAVE = Group('caves', MechagonAndNazjatar.GROUP_ALPHA75),
    INTRO = Group('intro'),
    OTHER = Group('other'),
    PETBATTLE = Group('pet_battles'),
    QUEST = Group('quests'),
    RARE = Group('rares', MechagonAndNazjatar.GROUP_ALPHA75),
    SUPPLY = Group('supplies'),
    TREASURE = Group('treasures', MechagonAndNazjatar.GROUP_ALPHA75),
}

-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 
local Class = MechagonAndNazjatar.Class

-------------------------------------------------------------------------------
--------------------------------- REQUIREMENT ---------------------------------
-------------------------------------------------------------------------------

--[[

Base class for all node requirements.

    text (string): Requirement text

--]]

local Requirement = Class('Requirement', nil, { text = UNKNOWN })
function Requirement:GetText() return self.text end
function Requirement:IsMet() return false end

-------------------------------------------------------------------------------
---------------------------------- CURRENCY -----------------------------------
-------------------------------------------------------------------------------

local Currency = Class('Currency', Requirement)

function Currency:Initialize(id, count)
    self.id, self.count = id, count
    self.text = string.format('{currency:%d} x%d', self.id, self.count)
end

function Currency:IsMet()
    local info = C_CurrencyInfo.GetCurrencyInfo(self.id)
    return info and info.quantity >= self.count
end

-------------------------------------------------------------------------------
------------------------------- GARRISON TALENT -------------------------------
-------------------------------------------------------------------------------

local GarrisonTalent = Class('GarrisonTalent', Requirement)

function GarrisonTalent:Initialize(id, text)
    self.id, self.text = id, text
end

function GarrisonTalent:GetText()
    local info = C_Garrison.GetTalentInfo(self.id)
    return self.text:format(info.name)
end

function GarrisonTalent:IsMet()
    local info = C_Garrison.GetTalentInfo(self.id)
    return info and info.researched
end

-------------------------------------------------------------------------------
------------------------------------ ITEM -------------------------------------
-------------------------------------------------------------------------------

local function IterateBagSlots()
    local bag, slot, slots = nil, 1, 1
    return function ()
        if bag == nil or slot == slots then
            repeat
                bag = (bag or -1) + 1
                slot = 1
                slots = GetContainerNumSlots(bag)
            until slots > 0 or bag > 4
            if bag > 4 then return end
        else
            slot = slot + 1
        end
        return bag, slot
    end
end

-------------------------------------------------------------------------------

local Item = Class('Item', Requirement)

function Item:Initialize(id, count)
    self.id, self.count = id, count
    self.text = string.format('{item:%d}', self.id)
    if self.count and self.count > 1 then
        self.text = self.text..' x'..self.count
    end
end

function Item:IsMet()
    for bag, slot in IterateBagSlots() do
        if GetContainerItemID(bag, slot) == self.id then
            if self.count and self.count > 1 then
                return select(2, GetContainerItemInfo(bag, slot)) >= self.count
            else return true end
        end
    end
    return false
end

-------------------------------------------------------------------------------
------------------------------------ SPELL ------------------------------------
-------------------------------------------------------------------------------

local Spell = Class('Spell', Requirement)

function Spell:Initialize(id)
    self.id = id
    self.text = string.format('{spell:%d}', self.id)
end

function Spell:IsMet()
    for i = 1, 255 do
        local buff = select(10, UnitAura('player', i, 'HELPFUL'))
        local debuff = select(10, UnitAura('player', i, 'HARMFUL'))
        if buff == self.id or debuff == self.id then return true end
    end
    return false
end

-------------------------------------------------------------------------------

MechagonAndNazjatar.requirement = {
    Currency=Currency,
    GarrisonTalent=GarrisonTalent,
    Item=Item,
    Requirement=Requirement,
    Spell=Spell
}


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 
local L = MechagonAndNazjatar.locale
local Class = MechagonAndNazjatar.Class
local Group = MechagonAndNazjatar.Group
local IsInstance = MechagonAndNazjatar.IsInstance
local Requirement = MechagonAndNazjatar.requirement.Requirement

-------------------------------------------------------------------------------
------------------------------------ NODE -------------------------------------
-------------------------------------------------------------------------------

--[[

Base class for all displayed nodes.

    label (string): Tooltip title for this node
    sublabel (string): Oneline string to display under label
    group (Group): Options group for this node (display, scale, alpha)
    icon (string|table): The icon texture to display
    alpha (float): The default alpha value for this type
    scale (float): The default scale value for this type
    minimap (bool): Should the node be displayed on the minimap
    quest (int|int[]): Quest IDs that cause this node to disappear
    questAny (boolean): Hide node if *any* quests are true (default *all*)
    questCount (boolean): Display completed quest count as rlabel
    questDeps (int|int[]): Quest IDs that must be true to appear
    requires (str): Requirement to interact or unlock (sets sublabel)
    rewards (Reward[]): Array of rewards for this node

--]]

local Node = Class('Node')

Node.label = UNKNOWN
Node.minimap = true
Node.alpha = 1
Node.scale = 1
Node.icon = "default"
Node.group = MechagonAndNazjatar.groups.OTHER

function Node:Initialize(attrs)
    -- assign all attributes
    if attrs then
        for k, v in pairs(attrs) do self[k] = v end
    end

    -- normalize quest ids as tables instead of single values
    for i, key in ipairs{'quest', 'questDeps'} do
        if type(self[key]) == 'number' then self[key] = {self[key]} end
    end

    -- normalize requirements as a table
    if type(self.requires) == 'string' or IsInstance(self.requires, Requirement) then
        self.requires = {self.requires}
    end

    -- materialize group if given as a name
    if not IsInstance(self.group, Group) then
        error('group attribute must be a Group class instance: '..self.group)
    end

    -- display nodes on minimap by default
    self.minimap = self.minimap ~= false
end

--[[
Return the associated texture, scale and alpha value to pass to HandyNotes
for this node.
--]]

function Node:GetDisplayInfo(map)
    local scale = self.scale * self.group:GetScale()
    local alpha = self.alpha * self.group:GetAlpha()
    return self.icon, scale, alpha
end

--[[
Return the glow POI for this node. If the node is hovered or focused, a green
glow is applyed to help highlight the node.
--]]

function Node:GetGlow(map)
    if self._glow and (self._focus or self._hover) then
        local _, scale, alpha = self:GetDisplayInfo(map)
        self._glow.alpha = alpha
        self._glow.scale = scale
        if self._focus then
            self._glow.r, self._glow.g, self._glow.b = 0, 1, 0
        else
            self._glow.r, self._glow.g, self._glow.b = 1, 1, 0
            self._glow.a = 0.5
        end
        return self._glow
    end
end

--[[
Return the "collected" status of this node. A node is collected if all
associated rewards have been obtained (achievements, toys, pets, mounts).
--]]

function Node:IsCollected()
    if not self.rewards then return true end
    for i, reward in ipairs(self.rewards) do
        if not reward:IsObtained() then return false end
    end
    return true
end

--[[
Return true if this node should be displayed.
--]]

function Node:IsEnabled()
    -- Check prerequisites
    if not self:PrerequisiteCompleted() then return false end

    -- Check completed state
    if not MechagonAndNazjatar:GetOpt('show_completed_nodes') then
        if self:IsCompleted() then return false end
    end

    return true
end

--[[
Return the prerequisite state of this node. A node has its prerequisites met if
all quests defined in the `questDeps` attribute are completed. This method can
be overridden to check for other prerequisite criteria.
--]]

function Node:PrerequisiteCompleted()
    -- Prerequisite not met if any dependent quest ids are false
    if not self.questDeps then return true end
    for i, quest in ipairs(self.questDeps) do
        if not C_QuestLog.IsQuestFlaggedCompleted(quest) then return false end
    end
    return true
end

--[[
Return the "completed" state of this node. A node is completed if any or all
associated quests have been completed. The behavior of any vs all is switched
with the `questAny` attribute. This method can also be overridden to check for
some other form of completion, such as an achievement criteria.

This method is *not* called if the "Show completed" setting is enabled.
--]]

function Node:IsCompleted()
    if self.quest and self.questAny then
        -- Completed if *any* attached quest ids are true
        for i, quest in ipairs(self.quest) do
            if C_QuestLog.IsQuestFlaggedCompleted(quest) then return true end
        end
    elseif self.quest then
        -- Completed only if *all* attached quest ids are true
        for i, quest in ipairs(self.quest) do
            if not C_QuestLog.IsQuestFlaggedCompleted(quest) then return false end
        end
        return true
    end
    return false
end

--[[
Prepare this node for display by fetching localization information for anything
referenced in the text attributes of this node. This method is called when a
world map containing this node is opened.
--]]

function Node:Prepare()
    -- initialize icon from string name
    if type(self.icon) == 'string' then
        self.icon = MechagonAndNazjatar.icons[self.icon] or MechagonAndNazjatar.icons.default
    end

    -- initialize glow POI (if glow icon available)
    --if type(self.icon) == 'table' and self.icon.glow and MechagonAndNazjatar.glows[self.icon.glow] then
        --local Glow = self.GlowClass or MechagonAndNazjatar.poi.Glow
        --self._glow = Glow({ icon=MechagonAndNazjatar.glows[self.icon.glow] })
    --end

    MechagonAndNazjatar.NameResolver:Prepare(self.label)
    MechagonAndNazjatar.PrepareLinks(self.sublabel)
    MechagonAndNazjatar.PrepareLinks(self.note)
end

--[[
Render this node onto the given tooltip. Many features are optional depending
on the attributes set on this specific node, such as setting an `rlabel` or
`sublabel` value.
--]]

function Node:Render(tooltip)
    -- render the label text with NPC names resolved
    tooltip:SetText(MechagonAndNazjatar.NameResolver:Resolve(self.label))

    local color, text
    local rlabel = self.rlabel or ''

    if self.questCount and self.quest and #self.quest then
        -- set rlabel to a (completed / total) display for quest ids
        local count = 0
        for i, quest in ipairs(self.quest) do
            if C_QuestLog.IsQuestFlaggedCompleted(quest) then
                count = count + 1
            end
        end
        color = (count == #self.quest) and MechagonAndNazjatar.status.Green or MechagonAndNazjatar.status.Gray
        rlabel = rlabel..' '..color(tostring(count)..'/'..#self.quest)
    end

    if self.pois then
        -- add an rlabel hint to use left-mouse to focus the node
        local focus = MechagonAndNazjatar.icons.left_mouse:link(12)..MechagonAndNazjatar.status.Gray(L["focus"])
        rlabel = (#rlabel > 0) and focus..' '..rlabel or focus
    end

    -- render top-right label text
    if #rlabel > 0 then
        local rtext = _G[tooltip:GetName()..'TextRight1']
        rtext:SetTextColor(1, 1, 1)
        rtext:SetText(rlabel)
        rtext:Show()
    end

    -- optional text directly under label
    if self.sublabel then
        tooltip:AddLine(MechagonAndNazjatar.RenderLinks(self.sublabel, true), 1, 1, 1)
    end

    -- display item, spell or other requirements
    if self.requires then
        for i, req in ipairs(self.requires) do
            if IsInstance(req, Requirement) then
                color = req:IsMet() and MechagonAndNazjatar.color.White or MechagonAndNazjatar.color.Red
                text = color(L["Requires"]..' '..req:GetText())
            else
                text = MechagonAndNazjatar.color.Red(L["Requires"]..' '..req)
            end
            tooltip:AddLine(MechagonAndNazjatar.RenderLinks(text, true))
        end
    end

    -- additional text for the node to describe how to interact with the
    -- object or summon the rare
    if self.note and MechagonAndNazjatar:GetOpt('show_notes') then
        if self.requires or self.sublabel then tooltip:AddLine(" ") end
        tooltip:AddLine(MechagonAndNazjatar.RenderLinks(self.note), 1, 1, 1, true)
    end

    -- all rewards (achievements, pets, mounts, toys, quests) that can be
    -- collected or completed from this node
    if self.rewards and MechagonAndNazjatar:GetOpt('show_loot') then
        local firstAchieve, firstOther = true, true
        for i, reward in ipairs(self.rewards) do

            -- Add a blank line between achievements and other rewards
            local isAchieve = IsInstance(reward, MechagonAndNazjatar.reward.Achievement)
            local isSpacer = IsInstance(reward, MechagonAndNazjatar.reward.Spacer)
            if isAchieve and firstAchieve then
                tooltip:AddLine(" ")
                firstAchieve = false
            elseif not (isAchieve or isSpacer) and firstOther then
                tooltip:AddLine(" ")
                firstOther = false
            end

            reward:Render(tooltip)
        end
    end
end

-------------------------------------------------------------------------------
------------------------------------ CAVE -------------------------------------
-------------------------------------------------------------------------------

local Cave = Class('Cave', Node, {
    icon = 'door_down',
    scale = 1.2,
    group = MechagonAndNazjatar.groups.CAVE
})

function Cave:Initialize(attrs)
    Node.Initialize(self, attrs)

    if self.parent == nil then
        error('One or more parent nodes are required for Cave nodes')
    elseif IsInstance(self.parent, Node) then
        -- normalize parent nodes as tables instead of single values
        self.parent = {self.parent}
    end
end

function Cave:IsEnabled()
    local function HasEnabledParent()
        for i, parent in ipairs(self.parent) do
            if parent:IsEnabled() then
                return true
            end
        end
        return false
    end

    -- Check if all our parents are hidden
    if not HasEnabledParent() then return false end

    return Node.IsEnabled(self)
end

-------------------------------------------------------------------------------
------------------------------------ INTRO ------------------------------------
-------------------------------------------------------------------------------

local Intro = Class('Intro', Node, {
    icon = 'quest_yellow',
    scale = 3,
    group = MechagonAndNazjatar.groups.INTRO,
})

-------------------------------------------------------------------------------
------------------------------------- NPC -------------------------------------
-------------------------------------------------------------------------------

local NPC = Class('NPC', Node)

function NPC:Initialize(attrs)
    Node.Initialize(self, attrs)
    if not self.id then error('id required for NPC nodes') end
end

function NPC.getters:label()
    return ("unit:Creature-0-0-0-0-%d"):format(self.id)
end

-------------------------------------------------------------------------------
---------------------------------- PETBATTLE ----------------------------------
-------------------------------------------------------------------------------

local PetBattle = Class('PetBattle', NPC, {
    icon = 'paw_yellow',
    scale = 1.2,
    group = MechagonAndNazjatar.groups.PETBATTLE
})

-------------------------------------------------------------------------------
------------------------------------ QUEST ------------------------------------
-------------------------------------------------------------------------------

local Quest = Class('Quest', Node, {
    note = AVAILABLE_QUEST,
    group = MechagonAndNazjatar.groups.QUEST
})

function Quest:Initialize(attrs)
    Node.Initialize(self, attrs)
    C_QuestLog.GetTitleForQuestID(self.quest[1]) -- fetch info from server
end

function Quest.getters:icon()
    return self.daily and 'quest_blue' or 'quest_yellow'
end

function Quest.getters:label()
    return C_QuestLog.GetTitleForQuestID(self.quest[1])
end

-------------------------------------------------------------------------------
------------------------------------ RARE -------------------------------------
-------------------------------------------------------------------------------

local Rare = Class('Rare', NPC, {
    scale = 1.2,
    group = MechagonAndNazjatar.groups.RARE
})

function Rare.getters:icon()
    return self:IsCollected() and 'skull_white' or 'skull_blue'
end

function Rare:IsEnabled()
    if MechagonAndNazjatar:GetOpt('hide_done_rares') and self:IsCollected() then return false end
    return NPC.IsEnabled(self)
end

function Rare:GetGlow(map)
    local glow = NPC.GetGlow(self, map)
    if glow then return glow end

    if MechagonAndNazjatar:GetOpt('development') and not self.quest then
        local _, scale, alpha = self:GetDisplayInfo(map)
        self._glow.alpha = alpha
        self._glow.scale = scale
        self._glow.r, self._glow.g, self._glow.b = 1, 0, 0
        return self._glow
    end
end

-------------------------------------------------------------------------------
---------------------------------- TREASURE -----------------------------------
-------------------------------------------------------------------------------

local Treasure = Class('Treasure', Node, {
    icon = 'chest_gray',
    scale = 1.3,
    group = MechagonAndNazjatar.groups.TREASURE
})

function Treasure.getters:label()
    if not self.rewards then return UNKNOWN end
    for i, reward in ipairs(self.rewards) do
        if IsInstance(reward, MechagonAndNazjatar.reward.Achievement) then
            return GetAchievementCriteriaInfoByID(reward.id, reward.criteria[1].id)
        end
    end
    return UNKNOWN
end

function Treasure:GetGlow(map)
    local glow = Node.GetGlow(self, map)
    if glow then return glow end

    if MechagonAndNazjatar:GetOpt('development') and not self.quest then
        local _, scale, alpha = self:GetDisplayInfo(map)
        self._glow.alpha = alpha
        self._glow.scale = scale
        self._glow.r, self._glow.g, self._glow.b = 1, 0, 0
        return self._glow
    end
end

-------------------------------------------------------------------------------
----------------------------------- SUPPLY ------------------------------------
-------------------------------------------------------------------------------

local Supply = Class('Supply', Treasure, {
    icon = 'star_chest',
    scale = 2,
    group = MechagonAndNazjatar.groups.SUPPLY
})

-------------------------------------------------------------------------------

MechagonAndNazjatar.node = {
    Node=Node,
    Cave=Cave,
    Intro=Intro,
    NPC=NPC,
    PetBattle=PetBattle,
    Quest=Quest,
    Rare=Rare,
    Supply=Supply,
    Treasure=Treasure
}


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 

local Class = MechagonAndNazjatar.Class
local L = MechagonAndNazjatar.locale

local Green = MechagonAndNazjatar.status.Green
local Orange = MechagonAndNazjatar.status.Orange
local Red = MechagonAndNazjatar.status.Red

-------------------------------------------------------------------------------
----------------------------------- REWARD ------------------------------------
-------------------------------------------------------------------------------

local Reward = Class('Reward')

function Reward:Initialize(attrs)
    if attrs then
        for k, v in pairs(attrs) do self[k] = v end
    end
end

function Reward:IsObtained()
    return true
end

function Reward:Render(tooltip)
    tooltip:AddLine('Render not implemented: '..tostring(self))
end

-------------------------------------------------------------------------------
----------------------------------- SECTION -----------------------------------
-------------------------------------------------------------------------------

local Section = Class('Section', Reward)

function Section:Initialize(title)
    self.title = title
end

function Section:Render(tooltip)
    tooltip:AddLine(self.title..':')
    tooltip:AddLine(' ')
end

-------------------------------------------------------------------------------
----------------------------------- SPACER ------------------------------------
-------------------------------------------------------------------------------

local Spacer = Class('Spacer', Reward)

function Spacer:Render(tooltip)
    tooltip:AddLine(' ')
end

-------------------------------------------------------------------------------
--------------------------------- ACHIEVEMENT ---------------------------------
-------------------------------------------------------------------------------

-- /run print(GetAchievementCriteriaInfo(ID, NUM))

local Achievement = Class('Achievement', Reward)
local GetCriteriaInfo = function (id, criteria)
    local results = {GetAchievementCriteriaInfoByID(id, criteria)}
    if not results[1] then
        if criteria <= GetAchievementNumCriteria(id) then
            results = {GetAchievementCriteriaInfo(id, criteria)}
        else
            MechagonAndNazjatar.Error('unknown achievement criteria ('..id..', '..criteria..')')
            return UNKNOWN
        end
    end
    return unpack(results)
end

function Achievement:Initialize(attrs)
    Reward.Initialize(self, attrs)

    -- we allow a single number, table of numbers or table of
    -- objects: {id=<number>, note=<string>}
    if type(self.criteria) == 'number' then
        self.criteria = {{id=self.criteria}}
    else
        local crittab = {}
        for i, criteria in ipairs(self.criteria) do
            if type(criteria) == 'number' then
                crittab[#crittab + 1] = {id=criteria}
            else
                crittab[#crittab + 1] = criteria
            end
        end
        self.criteria = crittab
    end
end

function Achievement:IsObtained()
    if select(4, GetAchievementInfo(self.id)) then return true end
    for i, c in ipairs(self.criteria) do
        local _, _, completed = GetCriteriaInfo(self.id, c.id)
        if not completed then return false end
    end
    return true
end

function Achievement:Render(tooltip)
    local _,name,_,completed,_,_,_,_,_,icon = GetAchievementInfo(self.id)
    tooltip:AddLine(ACHIEVEMENT_COLOR_CODE..'['..name..']|r')
    tooltip:AddTexture(icon, {margin={right=2}})
    for i, c in ipairs(self.criteria) do
        local cname,_,ccomp,qty,req = GetCriteriaInfo(self.id, c.id)
        if (cname == '' or c.qty) then cname = qty..'/'..req end

        local r, g, b = .6, .6, .6
        local ctext = "   ? "..cname..(c.suffix or '')
        if (completed or ccomp) then
            r, g, b = 0, 1, 0
        end

        local note, status = c.note
        if c.quest then
            if C_QuestLog.IsQuestFlaggedCompleted(c.quest) then
                status = MechagonAndNazjatar.status.Green(L['defeated'])
            else
                status = MechagonAndNazjatar.status.Red(L['undefeated'])
            end
            note = note and (note..'  '..status) or status
        end

        if note then
            tooltip:AddDoubleLine(ctext, note, r, g, b)
        else
            tooltip:AddLine(ctext, r, g, b)
        end
    end
end

-------------------------------------------------------------------------------
------------------------------------ ITEM -------------------------------------
-------------------------------------------------------------------------------

local Item = Class('Item', Reward)

function Item:Initialize(attrs)
    Reward.Initialize(self, attrs)

    if not self.item then
        error('Item() reward requires an item id to be set')
    end
    self.itemLink = L["retrieving"]
    self.itemIcon = 'Interface\\Icons\\Inv_misc_questionmark'
    local item = _G.Item:CreateFromItemID(self.item)
    if not item:IsItemEmpty() then
        item:ContinueOnItemLoad(function()
            self.itemLink = item:GetItemLink()
            self.itemIcon = item:GetItemIcon()
        end)
    end
end

function Item:IsObtained()
    if self.quest then return C_QuestLog.IsQuestFlaggedCompleted(self.quest) end
    return true
end

function Item:Render(tooltip)
    local text = self.itemLink
    local status = ''
    if self.quest then
        local completed = C_QuestLog.IsQuestFlaggedCompleted(self.quest)
        status = completed and Green(L['completed']) or Red(L['incomplete'])
    elseif self.weekly then
        local completed = C_QuestLog.IsQuestFlaggedCompleted(self.weekly)
        status = completed and Green(L['weekly']) or Red(L['weekly'])
    end

    if self.note then
        text = text..' ('..self.note..')'
    end
    tooltip:AddDoubleLine(text, status)
    tooltip:AddTexture(self.itemIcon, {margin={right=2}})
end

-------------------------------------------------------------------------------
------------------------------------ MOUNT ------------------------------------
-------------------------------------------------------------------------------

-- /run for i,m in ipairs(C_MountJournal.GetMountIDs()) do if (C_MountJournal.GetMountInfoByID(m) == "NAME") then print(m) end end

local Mount = Class('Mount', Item)

function Mount:IsObtained()
    return select(11, C_MountJournal.GetMountInfoByID(self.id))
end

function Mount:Render(tooltip)
    local collected = select(11, C_MountJournal.GetMountInfoByID(self.id))
    local status = collected and Green(L["known"]) or Red(L["missing"])
    local text = self.itemLink..' ('..L["mount"]..')'

    if self.note then
        text = text..' ('..self.note..')'
    end

    tooltip:AddDoubleLine(text, status)
    tooltip:AddTexture(self.itemIcon, {margin={right=2}})
end

-------------------------------------------------------------------------------
------------------------------------- PET -------------------------------------
-------------------------------------------------------------------------------

-- /run print(C_PetJournal.FindPetIDByName("NAME"))

local Pet = Class('Pet', Item)

function Pet:Initialize(attrs)
    if attrs.item then
        Item.Initialize(self, attrs)
    else
        Reward.Initialize(self, attrs)
        local name, icon = C_PetJournal.GetPetInfoBySpeciesID(self.id)
        self.itemIcon = icon
        self.itemLink = '|cff1eff00['..name..']|r'
    end
end

function Pet:IsObtained()
    return C_PetJournal.GetNumCollectedInfo(self.id) > 0
end

function Pet:Render(tooltip)
    local n, m = C_PetJournal.GetNumCollectedInfo(self.id)
    local text = self.itemLink..' ('..L["pet"]..')'
    local status = (n > 0) and Green(n..'/'..m) or Red(n..'/'..m)

    if self.note then
        text = text..' ('..self.note..')'
    end

    tooltip:AddDoubleLine(text, status)
    tooltip:AddTexture(self.itemIcon, {margin={right=2}})
end

-------------------------------------------------------------------------------
------------------------------------ QUEST ------------------------------------
-------------------------------------------------------------------------------

local Quest = Class('Quest', Reward)

function Quest:Initialize(attrs)
    Reward.Initialize(self, attrs)
    if type(self.id) == 'number' then
        self.id = {self.id}
    end
    C_QuestLog.GetTitleForQuestID(self.id[1]) -- fetch info from server
end

function Quest:IsObtained()
    for i, id in ipairs(self.id) do
        if not C_QuestLog.IsQuestFlaggedCompleted(id) then return false end
    end
    return true
end

function Quest:Render(tooltip)
    local name = C_QuestLog.GetTitleForQuestID(self.id[1])

    local status
    if #self.id == 1 then
        local completed = C_QuestLog.IsQuestFlaggedCompleted(self.id[1])
        status = completed and Green(L['completed']) or Red(L['incomplete'])
    else
        local count = 0
        for i, id in ipairs(self.id) do
            if C_QuestLog.IsQuestFlaggedCompleted(id) then count = count + 1 end
        end
        status = count..'/'..#self.id
        status = (count == #self.id) and Green(status) or Red(status)
    end

    local line = MechagonAndNazjatar.icons.quest_yellow:link(13)..' '..(name or UNKNOWN)
    tooltip:AddDoubleLine(line, status)
end

-------------------------------------------------------------------------------
------------------------------------- TOY -------------------------------------
-------------------------------------------------------------------------------

local Toy = Class('Toy', Item)

function Toy:IsObtained()
    return PlayerHasToy(self.item)
end

function Toy:Render(tooltip)
    local collected = PlayerHasToy(self.item)
    local status = collected and Green(L["known"]) or Red(L["missing"])
    tooltip:AddDoubleLine(self.itemLink..' ('..L["toy"]..')', status)
    tooltip:AddTexture(self.itemIcon, {margin={right=2}})
end

-------------------------------------------------------------------------------
---------------------------------- TRANSMOG -----------------------------------
-------------------------------------------------------------------------------

local Transmog = Class('Transmog', Item)
local CTC = C_TransmogCollection

function Transmog:IsObtained()
    -- Check if the player knows the appearance
    if CTC.PlayerHasTransmog(self.item) then return true end

    -- Verify the item drops for any of the players specs
    local specs = GetItemSpecInfo(self.item)
    if type(specs) == 'table' and #specs == 0 then return true end

    -- Verify the player can learn the item's appearance
    local sourceID = select(2, CTC.GetItemInfo(self.item))
    if not (sourceID and select(2, CTC.PlayerCanCollectSource(sourceID))) then return true end

    return false
end

function Transmog:Render(tooltip)
    local collected = CTC.PlayerHasTransmog(self.item)
    local status = collected and Green(L["known"]) or Red(L["missing"])

    if not collected then
        -- check if we can't learn this item
        local sourceID = select(2, CTC.GetItemInfo(self.item))
        if not (sourceID and select(2, CTC.PlayerCanCollectSource(sourceID))) then
            status = Orange(L["unlearnable"])
        else
            -- check if the item doesn't drop
            local specs = GetItemSpecInfo(self.item)
            if type(specs) == 'table' and #specs == 0 then
                status = Orange(L["unobtainable"])
            end
        end
    end

    local suffix = ' ('..L[self.slot]..')'
    if self.note then
        suffix = suffix..' ('..self.note..')'
    end

    tooltip:AddDoubleLine(self.itemLink..suffix, status)
    tooltip:AddTexture(self.itemIcon, {margin={right=2}})
end

-------------------------------------------------------------------------------

MechagonAndNazjatar.reward = {
    Reward=Reward,
    Section=Section,
    Spacer=Spacer,
    Achievement=Achievement,
    Item=Item,
    Mount=Mount,
    Pet=Pet,
    Quest=Quest,
    Toy=Toy,
    Transmog=Transmog
}


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 
local L = MechagonAndNazjatar.locale

-------------------------------------------------------------------------------
--------------------------- UIDROPDOWNMENU_ADDSLIDER --------------------------
-------------------------------------------------------------------------------

local function UIDropDownMenu_AddSlider (info, level)
    local function format (v)
        if info.percentage then return FormatPercentage(v, true) end
        return string.format("%.2f", v)
    end

    info.frame.Label:SetText(info.text)
    info.frame.Value:SetText(format(info.value))
    info.frame.Slider:SetMinMaxValues(info.min, info.max)
    info.frame.Slider:SetMinMaxValues(info.min, info.max)
    info.frame.Slider:SetValueStep(info.step)
    info.frame.Slider:SetAccessorFunction(function () return info.value end)
    info.frame.Slider:SetMutatorFunction(function (v)
        info.frame.Value:SetText(format(v))
        info.func(v)
    end)
    info.frame.Slider:UpdateVisibleState()

    UIDropDownMenu_AddButton({ customFrame = info.frame }, level)
end

-------------------------------------------------------------------------------
---------------------------- WORLD MAP BUTTON MIXIN ---------------------------
-------------------------------------------------------------------------------

local WorldMapOptionsButtonMixin = {}
_G["HandyNotes_MechagonAndNazjatarWorldMapOptionsButtonMixin"] = WorldMapOptionsButtonMixin

function WorldMapOptionsButtonMixin:OnLoad()
    UIDropDownMenu_SetInitializeFunction(self.DropDown, function (dropdown, level)
        dropdown:GetParent():InitializeDropDown(level)
    end)
    UIDropDownMenu_SetDisplayMode(self.DropDown, "MENU")

    self.AlphaOption = CreateFrame('Frame', 'HandyNotes_MechagonAndNazjatarAlphaMenuSliderOption',
        nil, 'HandyNotes_MechagonAndNazjatarSliderMenuOptionTemplate')
    self.ScaleOption = CreateFrame('Frame', 'HandyNotes_MechagonAndNazjatarScaleMenuSliderOption',
        nil, 'HandyNotes_MechagonAndNazjatarSliderMenuOptionTemplate')
end

function WorldMapOptionsButtonMixin:OnMouseDown(button)
    self.Icon:SetPoint("TOPLEFT", 6, -6)
    local xOffset = WorldMapFrame.isMaximized and -125 or 0
    ToggleDropDownMenu(1, nil, self.DropDown, self, xOffset, -5)
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
end

function WorldMapOptionsButtonMixin:OnMouseUp()
    self.Icon:SetPoint("TOPLEFT", self, "TOPLEFT", 4, -4)
end

function WorldMapOptionsButtonMixin:OnEnter()
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip_SetTitle(GameTooltip, L["context_menu_title_Mechagon"])
    GameTooltip_AddNormalLine(GameTooltip, L["map_button_text"])
    GameTooltip:Show()
end

function WorldMapOptionsButtonMixin:Refresh()
    local map = MechagonAndNazjatar.maps[self:GetParent():GetMapID() or 0]
    if map and map:HasEnabledGroups() then self:Show() else self:Hide() end
end

function WorldMapOptionsButtonMixin:InitializeDropDown(level)
    if level == 1 then
        UIDropDownMenu_AddButton({
            isTitle = true,
            notCheckable = true,
            text = WORLD_MAP_FILTER_TITLE
        })

        local map = MechagonAndNazjatar.maps[self:GetParent():GetMapID()]

        for i, group in ipairs(map.groups) do
            if group:IsEnabled() then
                UIDropDownMenu_AddButton({
                    text = L["options_icons_"..group.name],
                    isNotRadio = true,
                    keepShownOnClick = true,
                    hasArrow = true,
                    value = group,
                    checked = group:GetDisplay(),
                    arg1 = group,
                    func = function (button, group)
                        group:SetDisplay(button.checked)
                    end
                })
            end
        end

        UIDropDownMenu_AddSeparator()
        UIDropDownMenu_AddButton({
            text = L["options_show_completed_nodes"],
            isNotRadio = true,
            keepShownOnClick = true,
            checked = MechagonAndNazjatar:GetOpt('show_completed_nodes'),
            func = function (button, option)
                MechagonAndNazjatar:SetOpt('show_completed_nodes', button.checked)
            end
        })
    elseif level == 2 then
        -- Get correct map ID to query/set options for
        local group = UIDROPDOWNMENU_MENU_VALUE

        UIDropDownMenu_AddSlider({
            text = L["options_opacity"],
            min = 0, max = 1, step=0.01,
            value = group:GetAlpha(),
            frame = self.AlphaOption,
            percentage = true,
            func = function (v) group:SetAlpha(v) end
        }, 2)

        UIDropDownMenu_AddSlider({
            text = L["options_scale"],
            min = 0.3, max = 3, step=0.05,
            value = group:GetScale(),
            frame = self.ScaleOption,
            func = function (v) group:SetScale(v) end
        }, 2)
    end
end

-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 
local Class = MechagonAndNazjatar.Class
local HBD = LibStub('HereBeDragons-2.0')

-------------------------------------------------------------------------------

local function ResetPin(pin)
    pin.texture:SetRotation(0)
    pin.texture:SetTexCoord(0, 1, 0, 1)
    pin.texture:SetVertexColor(1, 1, 1, 1)
    pin.frameOffset = 0
    pin:SetAlpha(1)
    if pin.SetScalingLimits then -- World map only!
        pin:SetScalingLimits(nil, nil, nil)
    end
    return pin.texture
end

-------------------------------------------------------------------------------
-------------------------- POI (Point of Interest) ----------------------------
-------------------------------------------------------------------------------

local POI = Class('POI')

function POI:Initialize(attrs)
    for k, v in pairs(attrs) do self[k] = v end
end

function POI:Render(map, template)
    -- draw a circle at every coord
    for i=1, #self, 1 do
        map:AcquirePin(template, self, self[i])
    end
end

function POI:Draw(pin, xy)
    local t = ResetPin(pin)
    local size = (pin.minimap and 10 or (pin.parentHeight * 0.012))
    size = size * MechagonAndNazjatar:GetOpt('poi_scale')
    t:SetVertexColor(unpack({MechagonAndNazjatar:GetColorOpt('poi_color')}))
    t:SetTexture("Interface\\AddOns\\HandyNotes\\Icons\\circle")
    pin:SetSize(size, size)
    return HandyNotes:getXY(xy)
end

-------------------------------------------------------------------------------
------------------------------------ GLOW -------------------------------------
-------------------------------------------------------------------------------

local Glow = Class('Glow', POI)

function Glow:Draw(pin, xy)
    local t = ResetPin(pin)

    local hn_alpha, hn_scale
    if pin.minimap then
        hn_alpha = HandyNotes.db.profile.icon_alpha_minimap
        hn_scale = HandyNotes.db.profile.icon_scale_minimap
    else
        hn_alpha = HandyNotes.db.profile.icon_alpha
        hn_scale = HandyNotes.db.profile.icon_scale
    end

    local size = 15 * hn_scale * self.scale

    t:SetTexCoord(self.icon.tCoordLeft, self.icon.tCoordRight, self.icon.tCoordTop, self.icon.tCoordBottom)
    t:SetTexture(self.icon.icon)

    if self.r then
        t:SetVertexColor(self.r, self.g, self.b, self.a or 1)
    end

    pin.frameOffset = 1
    if pin.SetScalingLimits then -- World map only!
        pin:SetScalingLimits(1, 1.0, 1.2)
    end
    pin:SetAlpha(hn_alpha * self.alpha)
    pin:SetSize(size, size)
    return HandyNotes:getXY(xy)
end

-------------------------------------------------------------------------------
------------------------------------ PATH -------------------------------------
-------------------------------------------------------------------------------

local Path = Class('Path', POI)

function Path:Render(map, template)
    -- draw a circle at every coord and a line between them
    for i=1, #self, 1 do
        map:AcquirePin(template, self, 'circle', self[i])
        if i < #self then
            map:AcquirePin(template, self, 'line', self[i], self[i+1])
        end
    end
end

function Path:Draw(pin, type, xy1, xy2)
    local t = ResetPin(pin)
    t:SetVertexColor(unpack({MechagonAndNazjatar:GetColorOpt('path_color')}))
    t:SetTexture("Interface\\AddOns\\HandyNotes\\Icons\\"..type)

    -- constant size for minimaps, variable size for world maps
    local size = pin.minimap and 5 or (pin.parentHeight * 0.005)
    local line_width = pin.minimap and 60 or (pin.parentHeight * 0.05)

    -- apply user scaling
    size = size * MechagonAndNazjatar:GetOpt('poi_scale')
    line_width = line_width * MechagonAndNazjatar:GetOpt('poi_scale')

    if type == 'circle' then
        pin:SetSize(size, size)
        return HandyNotes:getXY(xy1)
    else
        local x1, y1 = HandyNotes:getXY(xy1)
        local x2, y2 = HandyNotes:getXY(xy2)
        local line_length

        if pin.minimap then
            local mapID = HBD:GetPlayerZone()
            local wx1, wy1 = HBD:GetWorldCoordinatesFromZone(x1, y1, mapID)
            local wx2, wy2 = HBD:GetWorldCoordinatesFromZone(x2, y2, mapID)
            local wmapDistance = sqrt((wx2-wx1)^2 + (wy2-wy1)^2)
            local mmapDiameter = C_Minimap:GetViewRadius() * 2
            line_length = Minimap:GetWidth() * (wmapDistance / mmapDiameter)
            t:SetRotation(-math.atan2(wy2-wy1, wx2-wx1))
        else
            local x1p = x1 * pin.parentWidth
            local x2p = x2 * pin.parentWidth
            local y1p = y1 * pin.parentHeight
            local y2p = y2 * pin.parentHeight
            line_length = sqrt((x2p-x1p)^2 + (y2p-y1p)^2)
            t:SetRotation(-math.atan2(y2p-y1p, x2p-x1p))
        end
        pin:SetSize(line_length, line_width)

        return (x1+x2)/2, (y1+y2)/2
    end
end

-------------------------------------------------------------------------------
------------------------------------ LINE -------------------------------------
-------------------------------------------------------------------------------

local Line = Class('Line', Path)

function Line:Initialize(attrs)
    Path.Initialize(self, attrs)

    -- draw a segmented line between two far-away points
    local x1, y1 = HandyNotes:getXY(self[1])
    local x2, y2 = HandyNotes:getXY(self[2])

    -- find an appropriate number of segments
    self.distance = sqrt(((x2-x1) * 1.85)^2 + (y2-y1)^2)
    self.segments = floor(self.distance / 0.015)

    self.path = {}
    for i=0, self.segments, 1 do
        self.path[#self.path + 1] = HandyNotes:getCoord(
            x1 + (x2-x1) / self.segments * i,
            y1 + (y2-y1) / self.segments * i
        )
    end
end

function Line:Render(map, template)
    if map.minimap then
        for i=1, #self.path, 1 do
            map:AcquirePin(template, self, 'circle', self.path[i])
            if i < #self.path then
                map:AcquirePin(template, self, 'line', self.path[i], self.path[i+1])
            end
        end
    else
        map:AcquirePin(template, self, 'circle', self[1])
        map:AcquirePin(template, self, 'circle', self[2])
        map:AcquirePin(template, self, 'line', self[1], self[2])
    end
end

-------------------------------------------------------------------------------
------------------------------------ ARROW ------------------------------------
-------------------------------------------------------------------------------

local Arrow = Class('Arrow', Path)

function Arrow:Initialize(attrs)
    Line.Initialize(self, attrs)

    local x1, y1 = HandyNotes:getXY(self[1])
    local x2, y2 = HandyNotes:getXY(self[2])
    local angle = math.atan2(y2 - y1, (x2 - x1) * 1.85) + (math.pi * 0.5)
    local xdiff = math.cos(angle) * (self.distance / self.segments / 4)
    local ydiff = math.sin(angle) * (self.distance / self.segments / 4)

    local xl, yl = HandyNotes:getXY(self.path[#self.path - 1])
    self.corner1 = HandyNotes:getCoord(xl + xdiff, yl + ydiff)
    self.corner2 = HandyNotes:getCoord(xl - xdiff, yl - ydiff)
end

function Arrow:Render(map, template)
    -- draw a segmented line
    Line.Render(self, map, template)

    -- draw the head of the arrow
    map:AcquirePin(template, self, 'circle', self.corner1)
    map:AcquirePin(template, self, 'circle', self.corner2)
    map:AcquirePin(template, self, 'line', self.corner1, self.path[#self.path])
    map:AcquirePin(template, self, 'line', self.corner2, self.path[#self.path])
    map:AcquirePin(template, self, 'line', self.corner1, self.corner2)
end

-------------------------------------------------------------------------------

MechagonAndNazjatar.poi = {
    POI=POI,
    Glow=Glow,
    Path=Path,
    Line=Line,
    Arrow=Arrow
}


 

-------------------------------------------------------------------------------
------------------------------ DATAMINE TOOLTIP -------------------------------
-------------------------------------------------------------------------------

local function CreateDatamineTooltip (name)
    local f = CreateFrame("GameTooltip", name, UIParent, "GameTooltipTemplate")
    f:SetOwner(UIParent, "ANCHOR_NONE")
    return f
end

local NameResolver = {
    cache = {},
    prepared = {},
    preparer = CreateDatamineTooltip("HandyNotes_MechagonAndNazjatar_NamePreparer"),
    resolver = CreateDatamineTooltip("HandyNotes_MechagonAndNazjatar_NameResolver")
}

function NameResolver:IsLink (link)
    if link == nil then return link end
    return strsub(link, 1, 5) == 'unit:'
end

function NameResolver:Prepare (link)
    if self:IsLink(link) and not (self.cache[link] or self.prepared[link]) then
        -- use a separate tooltip to spam load NPC names, doing this with the
        -- main tooltip can sometimes cause it to become unresponsive and never
        -- update its text until a reload
        self.preparer:SetHyperlink(link)
        self.prepared[link] = true
    end
end

function NameResolver:Resolve (link)
    -- may be passed a raw name or a hyperlink to be resolved
    if not self:IsLink(link) then return link or UNKNOWN end

    -- all npcs must be prepared ahead of time to avoid breaking the resolver
    if not self.prepared[link] then
        MechagonAndNazjatar.Debug('ERROR: npc link not prepared:', link)
    end

    local name = self.cache[link]
    if name == nil then
        self.resolver:SetHyperlink(link)
        name = _G[self.resolver:GetName().."TextLeft1"]:GetText() or UNKNOWN
        if name == UNKNOWN then
            MechagonAndNazjatar.Debug('NameResolver returned UNKNOWN, recreating tooltip ...')
            self.resolver = CreateDatamineTooltip("HandyNotes_MechagonAndNazjatar_NameResolver")
        else
            self.cache[link] = name
        end
    end
    return name
end

-------------------------------------------------------------------------------
-------------------------------- LINK RENDERER --------------------------------
-------------------------------------------------------------------------------

local function PrepareLinks(str)
    if not str then return end
    for type, id in str:gmatch('{(%l+):(%w+)}') do
        -- NOTE: no prep apprears to be necessary for currencies
        if type == 'npc' then
            NameResolver:Prepare(("unit:Creature-0-0-0-0-%d"):format(id))
        elseif type == 'item' then
            GetItemInfo(tonumber(id)) -- prime item info
        elseif type == 'quest' then
            C_QuestLog.GetTitleForQuestID(tonumber(id)) -- prime quest title
        elseif type == 'spell' then
            GetSpellInfo(tonumber(id)) -- prime spell info
        end
    end
end

local function RenderLinks(str, nameOnly)
    return str:gsub('{(%l+):([^}]+)}', function (type, id)
        if type == 'npc' then
            local name = NameResolver:Resolve(("unit:Creature-0-0-0-0-%d"):format(id))
            if nameOnly then return name end
            return MechagonAndNazjatar.color.NPC(name)
        elseif type == 'achievement' then
            if nameOnly then
                local _, name = GetAchievementInfo(tonumber(id))
                if name then return name end
            else
                local link = GetAchievementLink(tonumber(id))
                if link then return link end
            end
        elseif type == 'currency' then
            local info = C_CurrencyInfo.GetCurrencyInfo(tonumber(id))
            if info then
                if nameOnly then return info.name end
                local link = C_CurrencyInfo.GetCurrencyLink(tonumber(id), 0)
                if link then
                    return '|T'..info.iconFileID..':0:0:1:-1|t '..link
                end
            end
        elseif type == 'item' then
            local name, link, _, _, _, _, _, _, _, icon = GetItemInfo(tonumber(id))
            if link and icon then
                if nameOnly then return name end
                return '|T'..icon..':0:0:1:-1|t '..link
            end
        elseif type == 'quest' then
            local name = C_QuestLog.GetTitleForQuestID(tonumber(id))
            if name then
                return MechagonAndNazjatar.icons.quest_yellow:link(12)..MechagonAndNazjatar.color.Yellow(name)
            end
        elseif type == 'spell' then
            local name, _, icon = GetSpellInfo(tonumber(id))
            if name and icon then
                if nameOnly then return name end
                local spell = MechagonAndNazjatar.color.Spell('|Hspell:'..id..'|h['..name..']|h')
                return '|T'..icon..':0:0:1:-1|t '..spell
            end
        elseif type == 'wq' then
            return MechagonAndNazjatar.icons.world_quest:link(16)..MechagonAndNazjatar.color.Yellow(id)
        end
        return type..'+'..id
    end)
end

-------------------------------------------------------------------------------

MechagonAndNazjatar.NameResolver = NameResolver
MechagonAndNazjatar.PrepareLinks = PrepareLinks
MechagonAndNazjatar.RenderLinks = RenderLinks

-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 
local L = MechagonAndNazjatar.locale
local Class = MechagonAndNazjatar.Class
local Group = MechagonAndNazjatar.Group
local Map = MechagonAndNazjatar.Map

local Node = MechagonAndNazjatar.node.Node
local PetBattle = MechagonAndNazjatar.node.PetBattle
local Quest = MechagonAndNazjatar.node.Quest
local Rare = MechagonAndNazjatar.node.Rare
local Treasure = MechagonAndNazjatar.node.Treasure

local Achievement = MechagonAndNazjatar.reward.Achievement
local Item = MechagonAndNazjatar.reward.Item
local Mount = MechagonAndNazjatar.reward.Mount
local Pet = MechagonAndNazjatar.reward.Pet
local Toy = MechagonAndNazjatar.reward.Toy
local Transmog = MechagonAndNazjatar.reward.Transmog

-------------------------------------------------------------------------------

MechagonAndNazjatar.groups.LOCKED_CHEST = Group('locked_chest')
MechagonAndNazjatar.groups.MECH_CHEST = Group('mech_chest')
MechagonAndNazjatar.groups.RECRIG = Group('recrig')

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = Map({ id=1462, settings=true })
local nodes = map.nodes
local TIME_DISPLACEMENT = 296644

function map:Prepare ()
    Map.Prepare(self)
    self.future = AuraUtil.FindAuraByName(GetSpellInfo(TIME_DISPLACEMENT), 'player')
end

function map:IsNodeEnabled(node, coord, minimap)
    -- check node's future availability (nil=no, 1=yes, 2=both)
    if self.future and not node.future then return false end
    if not self.future and node.future == 1 then return false end
    return Map.IsNodeEnabled(self, node, coord, minimap)
end

-- Listen for aura applied/removed events so we can refresh when the player
-- enters and exits the alternate future
HandyNotes_MechagonAndNazjatar:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED', function ()
    local _,e,_,_,_,_,_,_,t,_,_,s  = CombatLogGetCurrentEventInfo()
    if (e == 'SPELL_AURA_APPLIED' or e == 'SPELL_AURA_REMOVED') and
        t == UnitName('player') and s == TIME_DISPLACEMENT then
        C_Timer.After(1, function()
            HandyNotes_MechagonAndNazjatar:Refresh()
        end)
    end
end)

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

nodes[52894092] = Rare({id=151934, quest=55512, future=2, note=nil, rewards={
    Achievement({id=13470, criteria=45124}), -- Kill
    Mount({id=1229, item=168823}) -- Rusty Mechanocrawler
}}) -- Arachnoid Harvester

nodes[55622571] = Rare({id=151308, quest=55539, note=nil, rewards={
    Achievement({id=13470, criteria=45131}), -- Kill
    Item({item=169688, quest=56515}) -- Vinyl: Gnomeregan Forever
}}) -- Boggac Skullbash

nodes[51265010] = Rare({id=153200, quest=55857, note=L["drill_rig"]..'(DR-JD41).', rewards={
    Achievement({id=13470, criteria=45152}), -- Kill
    Item({item=167042, quest=55030}), -- Blueprint: Scrap Trap
    Item({item=169691, quest=56518}) -- Vinyl: Depths of Ulduar
}}) -- Boilburn

nodes[65842288] = Rare({id=152001, quest=55537, note=L["cave_spawn"], rewards={
    Achievement({id=13470, criteria=45130}), -- Kill
    Item({item=167846, quest=55061}), -- Blueprint: Mechano-Treat
    Pet({id=2719, item=169392}) -- Bonebiter
}}) -- Bonepicker

nodes[66535891] = Rare({id=154739, quest=56368, note=L["drill_rig"]..'(DR-CC73).', rewards={
    Achievement({id=13470, criteria=45411}), -- Kill
    Item({item=169170, quest=55078}) -- Blueprint: Utility Mechanoclaw
}}) -- Caustic Mechaslime

nodes[82522072] = Rare({id=149847, quest=55812, note=L["crazed_trogg_note"], rewards={
    Achievement({id=13470, criteria=45137}), -- Kill
    Item({item=169169, quest=55077}), -- Blueprint: Blue Spraybot
    Item({item=169168, quest=55076}), -- Blueprint: Green Spraybot
    Item({item=169167, quest=55075}), -- Blueprint: Orange Spraybot
    Item({item=167792, quest=55452}), -- Paint Vial: Fel Mint Green
    Item({item=167793, quest=55457}) -- Paint Vial: Overload Orange
}}) -- Crazed Trogg

nodes[35464229] = Rare({id=151569, quest=55514, note=L["deepwater_note"], rewards={
    Achievement({id=13470, criteria=45128}), -- Kill
    Item({item=167836, quest=55057}), -- Blueprint: Canned Minnows
}}) --Deepwater Maw

nodes[63122559] = Rare({id=150342, quest=55814, note=L["drill_rig"]..'(DR-TR35).', rewards={
    Achievement({id=13470, criteria=45138}), -- Kill
    Item({item=167042, quest=55030}), -- Blueprint: Scrap Trap
    Item({item=169691, quest=56518}) -- Vinyl: Depths of Ulduar
}}) -- Earthbreaker Gulroc

nodes[55075684] = Rare({id=154153, quest=56207, note=nil, rewards={
    Achievement({id=13470, criteria=45373}), -- Kill
    Item({item=169174, quest=55082}), -- Blueprint: Rustbolt Pocket Turret
    Transmog({item=170466, slot=L["staff"]}), -- Junkyard Motivator
    Transmog({item=170467, slot=L["1h_sword"]}), -- Whirring Chainblade
    Transmog({item=170468, slot=L["gun"]}), -- Supervolt Zapper
    Transmog({item=170470, slot=L["shield"]}) -- Reinforced Grease Deflector
}}) -- Enforcer KX-T57

nodes[65515167] = Rare({id=151202, quest=55513, note=L["foul_manifest_note"], rewards={
    Achievement({id=13470, criteria=45127}), -- Kill
    Item({item=167871, quest=55063}) -- Blueprint: G99.99 Landshark
}}) -- Foul Manifestation

nodes[44553964] = Rare({id=151884, quest=55367, note=L["furor_note"], rewards={
    Achievement({id=13470, criteria=45126}), -- Kill
    Item({item=167793, quest=55457}), -- Paint Vial: Overload Orange
    Pet({id=2712, item=169379}) -- Snowsoft Nibbler
}}) -- Fungarian Furor

nodes[61395117] = Rare({id=153228, quest=55852, note=L["cogstar_note"], rewards={
    Achievement({id=13470, criteria=45155}), -- Kill
    Item({item=167847, quest=55062}), -- Blueprint: Ultrasafe Transporter: Mechagon
    Transmog({item=170467, slot=L["1h_sword"]}) -- Whirring Chainblade
}}) -- Gear Checker Cogstar

nodes[59836701] = Rare({id=153205, quest=55855, note=L["drill_rig"]..'(DR-JD99).', rewards={
    Achievement({id=13470, criteria=45146}), -- Kill
    Item({item=169691, quest=56518}) -- Vinyl: Depths of Ulduar
}}) -- Gemicide

nodes[73135414] = Rare({id=154701, quest=56367, note=L["drill_rig"]..'(DR-CC61).', rewards={
    Achievement({id=13470, criteria=45410}), -- Kill
    Item({item=167846, quest=55061}) -- Blueprint: Mechano-Treat
}}) -- Gorged Gear-Cruncher

nodes[77124471] = Rare({id=151684, quest=55399, note=nil, rewards={
    Achievement({id=13470, criteria=45121}) -- Kill
}}) -- Jawbreaker

nodes[44824637] = Rare({id=152007, quest=55369, note=L["killsaw_note"], rewards={
    Achievement({id=13470, criteria=45125}), -- Kill
    Toy({item=167931}) -- Mechagonian Sawblades
}}) -- Killsaw

nodes[60654217] = Rare({id=151933, quest=55544, note=L["beastbot_note"], rewards={
    Achievement({id=13470, criteria=45136}), -- Kill
    Achievement({id=13708, criteria={45772,45775,45776,45777,45778}}), -- Most Minis Wins
    Item({item=169848, weekly=57135}), -- Azeroth Mini Pack: Bondo's Yard
    Item({item=169173, quest=55081}), -- Blueprint: Anti-Gravity Pack
    Pet({id=2715, item=169382}) -- Lost Robogrip
}}) -- Malfunctioning Beastbot (55926 56506)

nodes[57165258] = Rare({id=151124, quest=55207, note=L["nullifier_note"], rewards={
    Achievement({id=13470, criteria=45117}), -- Kill
    Item({item=168490, quest=55069}), -- Blueprint: Protocol Transference Device
    Item({item=169688, quest=56515}) -- Vinyl: Gnomeregan Forever
}}) -- Mechagonian Nullifier

nodes[88142077] = Rare({id=151672, quest=55386, future=2, note=nil, rewards={
    Achievement({id=13470, criteria=45119}), -- Kill
    Pet({id=2720, item=169393}) -- Arachnoid Skitterbot
}}) -- Mecharantula

nodes[61036101] = Rare({id=151627, quest=55859, note=nil, rewards={
    Achievement({id=13470, criteria=45156}), -- Kill
    Item({item=168248, quest=55068}), -- Blueprint: BAWLD-371
    Transmog({item=170467, slot=L["1h_sword"]}) -- Whirring Chainblade
}}) -- Mr. Fixthis

nodes[56243595] = Rare({id=153206, quest=55853, note=L["drill_rig"]..'(DR-TR28).', rewards={
    Achievement({id=13470, criteria=45145}), -- Kill
    Item({item=167846, quest=55061}), -- Blueprint: Mechano-Treat
    Item({item=169691, quest=56518}), -- Vinyl: Depths of Ulduar
    Transmog({item=170466, slot=L["staff"]}) -- Junkyard Motivator
}}) -- Ol' Big Tusk

nodes[57063944] = Rare({id=151296, quest=55515, note=L["avenger_note"], rewards={
    Achievement({id=13470, criteria=45129}), -- Kill
    Item({item=168492, quest=55071}) -- Blueprint: Emergency Rocket Chicken
}}) -- OOX-Avenger/MG

nodes[56636287] = Rare({id=152764, quest=55856, note=L["leachbeast_note"], rewards={
    Achievement({id=13470, criteria=45157}), -- Kill
    Item({item=167794, quest=55454}), -- Paint Vial: Lemonade Steel
}}) -- Oxidized Leachbeast

nodes[22466873] = Rare({id=151702, quest=55405, note=nil, rewards={
    Achievement({id=13470, criteria=45122}), -- Kill
    Transmog({item=170468, slot=L["gun"]}) -- Supervolt Zapper
}}) -- Paol Pondwader

nodes[40235317] = Rare({id=150575, quest=55368, note=L["cave_spawn"], rewards={
    Achievement({id=13470, criteria=45123}), -- Kill
    Item({item=168001, quest=55517}) -- Paint Vial: Big-ol Bronze
}}) -- Rumblerocks

nodes[65637850] = Rare({id=152182, quest=55811, note=nil, rewards={
    Achievement({id=13470, criteria=45135}), -- Kill
    Item({item=169173, quest=55081}), -- Blueprint: Anti-Gravity Pack
    Mount({id=1248, item=168370}) -- Rusted Keys to the Junkheap Drifter
}}) -- Rustfeather

nodes[82287300] = Rare({id=155583, quest=56737, note=L["scrapclaw_note"], rewards={
    Achievement({id=13470, criteria=45691}), -- Kill
    Transmog({item=170470, slot=L["shield"]}) -- Reinforced Grease Deflector
}}) -- Scrapclaw

nodes[19127975] = Rare({id=150937, quest=55545, note=nil, rewards={
    Achievement({id=13470, criteria=45133}), -- Kill
    Item({item=168063, quest=55065}) -- Blueprint: Rustbolt Kegerator
}}) -- Seaspit

nodes[81852708] = Rare({id=153000, quest=55810, note=L["sparkqueen_note"], rewards={
    Achievement({id=13470, criteria=45134}) -- Kill
}}) -- Sparkqueen P'Emp

nodes[26257806] = Rare({id=153226, quest=55854, note=nil, rewards={
    Achievement({id=13470, criteria=45154}), -- Kill
    Item({item=168062, quest=55064}), -- Blueprint: Rustbolt Gramophone
    Item({item=169690, quest=56517}), -- Vinyl: Battle of Gnomeregan
    Item({item=169689, quest=56516}), -- Vinyl: Mimiron's Brainstorm
    Item({item=169692, quest=56519}) -- Vinyl: Triumph of Gnomeregan
}}) -- Steel Singer Freza

nodes[80962019] = Rare({id=155060, quest=56419, note=L["doppel_note"], label=L["doppel_gang"], rewards={
    Achievement({id=13470, criteria=45433}) -- Kill
}}) -- The Doppel Gang

nodes[68434776] = Rare({id=152113, quest=55858, note=L["drill_rig"]..'(DR-CC88).', rewards={
    Achievement({id=13470, criteria=45153}), -- Kill
    Item({item=169691, quest=56518}), -- Vinyl: Depths of Ulduar
    Pet({id=2753, item=169886}) -- Spraybot 0D
}}) -- The Kleptoboss

nodes[57335827] = Rare({id=154225, quest=56182, future=2, note=L["rusty_note"], rewards={
    Achievement({id=13470, criteria=45374}), -- Kill
    Toy({item=169347}), -- Judgment of Mechagon
    Transmog({item=170467, slot=L["1h_sword"]}) -- Whirring Chainblade
}}) -- The Rusty Prince

nodes[72344987] = Rare({id=151625, quest=55364, note=nil, rewards={
    Achievement({id=13470, criteria=45118}), -- Kill
    Item({item=167846, quest=55061}), -- Blueprint: Mechano-Treat
    Transmog({item=170467, slot=L["1h_sword"]}) -- Whirring Chainblade
}}) -- The Scrap King

nodes[57062218] = Rare({id=151940, quest=55538, note=L["cave_spawn"], rewards={
    Achievement({id=13470, criteria=45132}) -- Kill
}}) -- Uncle T'Rogg

nodes[53824933] = Rare({id=150394, quest=55546, future=2, note=L["vaultbot_note"], rewards={
    Achievement({id=13470, criteria=45158}), -- Kill
    Item({item=167843, quest=55058}), -- Blueprint: Vaultbot Key
    Item({item=167796, quest=55455}), -- Paint Vial: Mechagon Gold
    Pet({id=2766, item=170072}) -- Armored Vaultbot
}}) -- Armored Vaultbot

-------------------------------------------------------------------------------
--------------------------------- BATTLE PETS ---------------------------------
-------------------------------------------------------------------------------

nodes[64706460] = PetBattle({id=154922}) -- Gnomefeaster
nodes[60704650] = PetBattle({id=154923}) -- Sputtertude
nodes[60605690] = PetBattle({id=154924}) -- Goldenbot XD
nodes[59205090] = PetBattle({id=154925}) -- Creakclank
nodes[65405770] = PetBattle({id=154926}) -- CK-9 Micro-Oppression Unit
nodes[51104540] = PetBattle({id=154927}) -- Unit 35
nodes[39504010] = PetBattle({id=154928}) -- Unit 6
nodes[72107290] = PetBattle({id=154929}) -- Unit 17

-------------------------------------------------------------------------------
-------------------------------- LOCKED CHESTS --------------------------------
-------------------------------------------------------------------------------

-- All chests have a chance to drop
local RED_PAINT = Item({item=170146, quest=56907}) -- Paint Bottle: Nukular Red

-- Recently it looks like these are in fixed spawns compared to when 8.2 hit
nodes[23195699] = Treasure({
    group=MechagonAndNazjatar.groups.LOCKED_CHEST,
    label=L["iron_chest"],
    note=L["iron_chest_note"],
    rewards={RED_PAINT}
})

nodes[13228581] = Treasure({
    group=MechagonAndNazjatar.groups.LOCKED_CHEST,
    label=L["iron_chest"],
    note=L["iron_chest_note"],
    rewards={RED_PAINT}
})

nodes[19018086] = Treasure({
    group=MechagonAndNazjatar.groups.LOCKED_CHEST,
    label=L["iron_chest"],
    note=L["iron_chest_note"],
    rewards={RED_PAINT}
})

nodes[30775964] = Treasure({
    group=MechagonAndNazjatar.groups.LOCKED_CHEST,
    label=L["iron_chest"],
    note=L["iron_chest_note"],
    rewards={RED_PAINT}
})

nodes[20537120] = Treasure({
    group=MechagonAndNazjatar.groups.LOCKED_CHEST,
    label=L["msup_chest"],
    note=L["msup_chest_note"],
    rewards={RED_PAINT}
})

nodes[18357618] = Treasure({
    group=MechagonAndNazjatar.groups.LOCKED_CHEST,
    label=L["rust_chest"],
    note=L["rust_chest_note"],
    rewards={RED_PAINT}
})

nodes[25267825] = Treasure({
    group=MechagonAndNazjatar.groups.LOCKED_CHEST,
    label=L["rust_chest"],
    note=L["rust_chest_note"],
    rewards={RED_PAINT}
})

nodes[23988441] = Treasure({
    group=MechagonAndNazjatar.groups.LOCKED_CHEST,
    label=L["rust_chest"],
    note=L["rust_chest_note"],
    rewards={RED_PAINT}
})

-------------------------------------------------------------------------------
------------------------------ MECHANIZED CHESTS ------------------------------
-------------------------------------------------------------------------------

local MechChest = Class('MechChest', Treasure)

MechChest.group = MechagonAndNazjatar.groups.MECH_CHEST
MechChest.label = L["mech_chest"]
MechChest.rewards = {
    Achievement({id=13708, criteria={45773,45781,45779,45780,45785}}), -- Most Minis Wins
    Item({item=167790, quest=55451}), -- Paint Vial: Fireball Red
    Item({item=169850, weekly=57133}) -- Azeroth Mini Pack: Mechagon
}

local TREASURE1 = MechChest({quest=55547, icon='chest_blue'})
local TREASURE2 = MechChest({quest=55548, icon='chest_brown'})
local TREASURE3 = MechChest({quest=55549, icon='chest_orange'})
local TREASURE4 = MechChest({quest=55550, icon='chest_yellow'})
local TREASURE5 = MechChest({quest=55551, icon='chest_camo', future=1})
local TREASURE6 = MechChest({quest=55552, icon='chest_lime'})
local TREASURE7 = MechChest({quest=55553, icon='chest_red'})
local TREASURE8 = MechChest({quest=55554, icon='chest_purple'})
local TREASURE9 = MechChest({quest=55555, icon='chest_teal'})
local TREASURE10 = MechChest({quest=55556, icon='chest_lblue'})

-- object 325659
nodes[43304977] = TREASURE1
nodes[49223021] = TREASURE1
nodes[52115326] = TREASURE1
nodes[53254190] = TREASURE1
nodes[56973861] = TREASURE1
-- object 325660
nodes[20617141] = TREASURE2
nodes[30785183] = TREASURE2
nodes[35683833] = TREASURE2
nodes[40155409] = TREASURE2
-- object 325661
nodes[59946357] = TREASURE3
nodes[65866460] = TREASURE3
nodes[67075645] = TREASURE3
nodes[73515334] = TREASURE3
nodes[80374838] = TREASURE3
-- object 325662
nodes[65555284] = TREASURE4
nodes[72594733] = TREASURE4
nodes[73014950] = TREASURE4
nodes[76215286] = TREASURE4
nodes[81196149] = TREASURE4
-- object 325663
nodes[56665739] = TREASURE5
nodes[58634160] = TREASURE5
nodes[61583230] = TREASURE5
nodes[64365961] = TREASURE5
nodes[70654796] = TREASURE5
-- object 325664
nodes[66432227] = TREASURE6
nodes[64092627] = TREASURE6
nodes[56782918] = TREASURE6
nodes[57142283] = TREASURE6
nodes[55612404] = TREASURE6
nodes[50662858] = TREASURE6
-- object 325665
nodes[67322289] = TREASURE7
nodes[80691868] = TREASURE7
nodes[85752824] = TREASURE7
nodes[86232042] = TREASURE7
nodes[88732015] = TREASURE7
-- object 325666
nodes[48367595] = TREASURE8
nodes[57258202] = TREASURE8
nodes[62297390] = TREASURE8
nodes[66767759] = TREASURE8
-- object 325667
nodes[63626715] = TREASURE9
nodes[72126545] = TREASURE9
nodes[76516601] = TREASURE9
nodes[81167231] = TREASURE9
nodes[85166335] = TREASURE9
-- object 325668
nodes[24796526] = TREASURE10
nodes[20537696] = TREASURE10
nodes[21788303] = TREASURE10
nodes[12088568] = TREASURE10

-------------------------------------------------------------------------------
-------------------------------- MISCELLANEOUS --------------------------------
-------------------------------------------------------------------------------

nodes[53486145] = Quest({quest=55743, questDeps=56117, daily=true, minimap=false, scale=1.8, rewards={
    Achievement({id=13708, criteria={45772,45775,45776,45777,45778}}), -- Most Minis Wins
    Item({item=169848, weekly=57134}), -- Azeroth Mini Pack: Bondo's Yard
}})

-------------------------------------------------------------------------------

local RegRig = Class('RegRig', Node, { group=MechagonAndNazjatar.groups.RECRIG })

function RegRig.getters:rlabel ()
    local G, GR, N, H = MechagonAndNazjatar.status.Green, MechagonAndNazjatar.status.Gray, L['normal'], L['hard']
    local normal = C_QuestLog.IsQuestFlaggedCompleted(55847) and G(N) or GR(N)
    local hard = C_QuestLog.IsQuestFlaggedCompleted(55848) and G(H) or GR(H)
    return normal..' '..hard
end

nodes[69976201] = RegRig({icon="peg_blue", scale=2, label=L["rec_rig"], rewards={
    Achievement({id=13708, criteria={45773,45781,45779,45780,45785}}), -- Most Minis Wins
    Item({item=169850, note=L["normal"], weekly=57132}), -- Azeroth Mini Pack: Mechagon
    Item({item=168495, note=L["hard"], quest=55074}), -- Blueprint: Rustbolt Requisitions
    Pet({id=2721, item=169396}), -- Echoing Oozeling
    Pet({id=2756, item=169879}) -- Irradiated Elementaling
}, note=L["rec_rig_note"]}) -- Reclamation Rig ???=56079

-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 
local L = MechagonAndNazjatar.locale
local Class = MechagonAndNazjatar.Class
local Group = MechagonAndNazjatar.Group
local Map = MechagonAndNazjatar.Map

local Node = MechagonAndNazjatar.node.Node
local Cave = MechagonAndNazjatar.node.Cave
local NPC = MechagonAndNazjatar.node.NPC
local PetBattle = MechagonAndNazjatar.node.PetBattle
local Rare = MechagonAndNazjatar.node.Rare
local Supply = MechagonAndNazjatar.node.Supply
local Treasure = MechagonAndNazjatar.node.Treasure

local Achievement = MechagonAndNazjatar.reward.Achievement
local Item = MechagonAndNazjatar.reward.Item
local Mount = MechagonAndNazjatar.reward.Mount
local Pet = MechagonAndNazjatar.reward.Pet
local Quest = MechagonAndNazjatar.reward.Quest
local Toy = MechagonAndNazjatar.reward.Toy
local Transmog = MechagonAndNazjatar.reward.Transmog

-------------------------------------------------------------------------------

MechagonAndNazjatar.groups.CATS_NAZJ = Group('cats_nazj')
MechagonAndNazjatar.groups.MISC_NAZJ = Group('misc_nazj')
MechagonAndNazjatar.groups.SLIMES_NAZJ = Group('slimes_nazj')
MechagonAndNazjatar.groups.TREASURES_NAZJ = Group('treasures_nazj')

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = Map({ id=1355, phased=false, settings=true })
local nodes = map.nodes

function map:Prepare ()
    Map.Prepare(self)
    self.phased = self.intro:IsCompleted()
end

-------------------------------------------------------------------------------
------------------------------------ INTRO ------------------------------------
-------------------------------------------------------------------------------

local Intro = Class('Intro', MechagonAndNazjatar.node.Intro)

Intro.note = L["naz_intro_note"]

function Intro.getters:label ()
    return GetAchievementCriteriaInfoByID(13709, 45756) -- Welcome to Nazjatar
end

if UnitFactionGroup('player') == 'Alliance' then
    map.intro = Intro({quest=56156, faction='Alliance', rewards={
        -- The Wolf's Offensive => A Way Home
        Quest({id={56031,56043,55095,54969,56640,56641,56642,56643,56644,55175,54972}}),
        -- Essential Empowerment => Scouting the Palace
        Quest({id={55851,55533,55374,55400,55407,55425,55497,55618,57010,56162,56350}}),
        -- The Lost Shaman => A Tempered Blade
        Quest({id={55361,55362,55363,56156}})
    }})
else
    map.intro = Intro({quest=55500, faction='Horde', rewards={
        -- The Warchief's Order => A Way Home
        Quest({id={56030,56044,55054,54018,54021,54012,55092,56063,54015,56429,55094,55053}}),
        -- Essential Empowerment => Scouting the Palace
        Quest({id={55851,55533,55374,55400,55407,55425,55497,55618,57010,56161,55481}}),
        -- Settling In => Save A Friend
        Quest({id={55384,55385,55500}})
    }})
end

nodes[11952801] = map.intro

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

nodes[52394183] = Rare({id=152415, quest=56279, note=L["alga_note"], rewards={
    Achievement({id=13691, criteria=45519}), -- Kill
    Achievement({id=13692, criteria=46083}) -- Blind Eye (170189)
}}) -- Alga the Eyeless

nodes[66443875] = Rare({id=152416, quest=56280, note=L["allseer_note"], rewards={
    Achievement({id=13691, criteria=45520}) -- Kill
}}) -- Allseer Oma'kill

nodes[58605329] = Rare({id=152566, quest=56281, note=L["anemonar_note"], rewards={
    Achievement({id=13691, criteria=45522}), -- Kill
    Achievement({id=13692, criteria={46088,46089}}), -- Ancient Reefwalker Bark, Reefwalker Bark
    Item({item=170184, weekly=57140}) -- Ancient Reefwalker Bark
}}) -- Anemonar

nodes[73985395] = Rare({id=152361, quest=56282, note=L["banescale_note"], rewards={
    Achievement({id=13691, criteria=45524}), -- Kill
    Achievement({id=13692, criteria=46093}) -- Snapdragon Scent Gland
}}) -- Banescale the Packfather

nodes[37378256] = Rare({id=152712, quest=56269, note=L["cave_spawn"], rewards={
    Achievement({id=13691, criteria=45525}), -- Kill
    Pet({id=2682, item=169372}) -- Necrofin Tadpole
}}) -- Blindlight

nodes[40790735] = Rare({id=152464, quest=56283, note=L["cave_spawn"], rewards={
    Achievement({id=13691, criteria=45527}), -- Kill
    Pet({id=2690, item=169356}) -- Caverndark Nightmare
}}) -- Caverndark Terror

nodes[49208875] = Rare({id=152556, quest=56270, note=L["ucav_spawn"], rewards={
    Achievement({id=13691, criteria=45528}), -- Kill
    Achievement({id=13692, criteria=46101}), -- Eel Filet
}}) -- Chasm-Haunter

nodes[57074363] = Rare({id=152291, quest=56272, note=L["cora_spawn"], rewards={
    Achievement({id=13691, criteria=45530}), -- Kill
    Achievement({id=13692, criteria=46096}) -- Fathom Ray Wing
}}) -- Deepglider

nodes[64543531] = Rare({id=152414, quest=56284, note=L["elderunu_note"], rewards={
    Achievement({id=13691, criteria=45531}) -- Kill
}}) -- Elder Unu

nodes[51757487] = Rare({id=152555, quest=56285, note=nil, rewards={
    Achievement({id=13691, criteria=45532}), -- Kill
    Pet({id=2693, item=169359}) -- Spawn of Nalaada
}}) -- Elderspawn Nalaada

nodes[36044496] = Rare({id=152553, quest=56273, note=L["area_spawn"], rewards={
    Achievement({id=13691, criteria=45533}), -- Kill
    Achievement({id=13692, criteria=46092}) -- Razorshell
}}) -- Garnetscale

nodes[45715170] = Rare({id=152448, quest=56286, note=L["glimmershell_note"], rewards={
    Achievement({id=13691, criteria=45534}), -- Kill
    Achievement({id=13692, criteria=46099}), -- Giant Crab Leg
    Pet({id=2686, item=169352}) -- Pearlescent Glimmershell
}}) -- Iridescent Glimmershell

nodes[50056991] = Rare({id=152567, quest=56287, note=L["kelpwillow_note"], rewards={
    Achievement({id=13691, criteria=45535}), -- Kill
    Achievement({id=13692, criteria={46088,46089}}), -- Ancient Reefwalker Bark, Reefwalker Bark
    Item({item=170184, weekly=57140}) -- Ancient Reefwalker Bark
}}) -- Kelpwillow

nodes[29412899] = Rare({id=152323, quest=55671, note=L["gakula_note"], rewards={
    Achievement({id=13691, criteria=45536}), -- Kill
    Pet({id=2681, item=169371}) -- Murgle
}}) -- King Gakula

nodes[78132501] = Rare({id=152397, quest=56288, note=L["oronu_note"], rewards={
    Achievement({id=13691, criteria=45539}), -- Kill
    Achievement({id=13692, criteria={46088,46089}}), -- Ancient Reefwalker Bark, Reefwalker Bark
    Item({item=170184, weekly=57140}) -- Ancient Reefwalker Bark
}}) -- Oronu

nodes[42728740] = Rare({id=152681, quest=56289, note=nil, rewards={
    Achievement({id=13691, criteria=45540}), -- Kill
    Pet({id=2701, item=169367}) -- Seafury
}}) -- Prince Typhonus

nodes[42997551] = Rare({id=152682, quest=56290, note=nil, rewards={
    Achievement({id=13691, criteria=45541}), -- Kill
    Pet({id=2702, item=169368}) -- Stormwrath
}}) -- Prince Vortran

nodes[35554141] = Rare({id=152548, quest=56292, note=L["matriarch_note"], rewards={
    Achievement({id=13691, criteria=45545}), -- Kill
    Achievement({id=13692, criteria=46087}), -- Intact Naga Skeleton
    Pet({id=2704, item=169370}) -- Scalebrood Hydra
}}) -- Scale Matriarch Gratinax

nodes[27193708] = Rare({id=152545, quest=56293, note=L["matriarch_note"], rewards={
    Achievement({id=13691, criteria=45546}), -- Kill
    Achievement({id=13692, criteria=46087}), -- Intact Naga Skeleton
    Pet({id=2704, item=169370}) -- Scalebrood Hydra
}}) -- Scale Matriarch Vynara

nodes[28604664] = Rare({id=152542, quest=56294, note=L["matriarch_note"], rewards={
    Achievement({id=13691, criteria=45547}), -- Kill
    Achievement({id=13692, criteria=46087}), -- Intact Naga Skeleton
    Pet({id=2704, item=169370}) -- Scalebrood Hydra
}}) -- Scale Matriarch Zodia

nodes[62740809] = Rare({id=152552, quest=56295, note=L["cave_spawn"], rewards={
    Achievement({id=13691, criteria=45548}), -- Kill
    Toy({item=170187}) -- Shadescale
}}) -- Shassera

nodes[39601700] = Rare({id=153658, quest=56296, note=L["area_spawn"], rewards={
    Achievement({id=13691, criteria=45549}), -- Kill
    Achievement({id=13692, criteria={46090,46091}}) -- Voltscale Shield, Tidal Guard
}}) -- Shiz'narasz the Consumer

nodes[71365456] = Rare({id=152359, quest=56297, note=nil, rewards={
    Achievement({id=13691, criteria=45550}), -- Kill
    Achievement({id=13692, criteria=46093}) -- Snapdragon Scent Gland
}}) -- Siltstalker the Packmother

nodes[59704791] = Rare({id=152290, quest=56298, note=L["cora_spawn"], rewards={
    Achievement({id=13691, criteria=45551}), -- Kill
    Achievement({id=13692, criteria=46096}), -- Fathom Ray Wing
    Mount({id=1257, item=169163}) -- Silent Glider
}}) -- Soundless

nodes[62462964] = Rare({id=153898, quest=56122, note=L["tidelord_note"], rewards={
    Achievement({id=13691, criteria=45553}) -- Kill
}}) -- Tidelord Aquatus

nodes[57962648] = Rare({id=153928, quest=56123, note=L["tidelord_note"], rewards={
    Achievement({id=13691, criteria=45554}) -- Kill
}}) -- Tidelord Dispersius

nodes[65872243] = Rare({id=154148, quest=56106, note=L["tidemistress_note"], rewards={
    Achievement({id=13691, criteria=45555}), -- Kill
    Toy({item=170196}) -- Shirakess Warning Sign
}}) -- Tidemistress Leth'sindra

nodes[66964817] = Rare({id=152360, quest=56278, note=L["area_spawn"], rewards={
    Achievement({id=13691, criteria=45556}), -- Kill
    Achievement({id=13692, criteria=46094}) -- Alpha Fin
}}) -- Toxigore the Alpha

nodes[31282935] = Rare({id=152568, quest=56299, note=L["urduu_note"], rewards={
    Achievement({id=13691, criteria=45557}), -- Kill
    Achievement({id=13692, criteria={46088,46089}}), -- Ancient Reefwalker Bark, Reefwalker Bark
    Item({item=170184, weekly=57140}) -- Ancient Reefwalker Bark
}}) -- Urduu

nodes[67243458] = Rare({id=151719, quest=56300, note=L["voice_deeps_notes"], rewards={
    Achievement({id=13691, criteria=45558}), -- Kill
    Achievement({id=13692, criteria=46086}) -- Abyss Pearl
}}) -- Voice in the Deeps

nodes[36931120] = Rare({id=150191, quest=55584, note=L["avarius_note"], rewards={
    Pet({id=2706, item=169373}) -- Brinestone Algan
}}) -- Avarius

nodes[54664179] = Rare({id=149653, quest=55366, note=L["lasher_note"], rewards={
    Pet({id=2708, item=169375}) -- Coral Lashling
}}) -- Carnivorous Lasher

nodes[48002427] = Rare({id=150468, quest=55603, note=L["vorkoth_note"], rewards={
    Pet({id=2709, item=169376}) -- Skittering Eel
}}) -- Vor'koth

-------------------------------------------------------------------------------
---------------------------------- ZONE RARES ---------------------------------
-------------------------------------------------------------------------------

local start = 09452400
local function coord(x, y)
    return start + x*2500000 + y*400
end

nodes[coord(0,0)] = Rare({id=152794, quest=56268, minimap=false, note=L["zone_spawn"], rewards={
    Achievement({id=13691, criteria=45521}), -- Kill
    Pet({id=2697, item=169363}) -- Amethyst Softshell
}}) -- Amethyst Spireshell

nodes[coord(1,0)] = Rare({id=152756, quest=56271, minimap=false, note=L["zone_spawn"], rewards={
    Achievement({id=13691, criteria=45529}), -- Kill
    Pet({id=2695, item=169361}) -- Daggertooth Frenzy
}}) -- Daggertooth Terror

nodes[coord(2,0)] = Rare({id=144644, quest=56274, minimap=false, note=L["zone_spawn"], rewards={
    Achievement({id=13691, criteria=45537}), -- Kill
    Achievement({id=13692, criteria=46098}), -- Brightspine Shell
    Pet({id=2700, item=169366}) -- Wriggler
}}) -- Mirecrawler

nodes[coord(0,1)] = Rare({id=152465, quest=56275, minimap=false, note=L["needle_note"], rewards={
    Achievement({id=13691, criteria=45538}), -- Kill
    Achievement({id=13692, criteria=46099}), -- Giant Crab Leg
    Pet({id=2689, item=169355}) -- Chitterspine Needler
}}) -- Needlespine

nodes[coord(1,2)] = Rare({id=150583, quest=56291, minimap=false, note=L["zone_spawn"]..' '..L["rockweed_note"], rewards={
    Achievement({id=13691, criteria=45542}), -- Kill
    Pet({id=2707, item=169374}) -- Budding Algan
}}) -- Rockweed Shambler

nodes[coord(1,1)] = Rare({id=151870, quest=56276, minimap=false, note=L["sandcastle_note"], rewards={
    Achievement({id=13691, criteria=45543}), -- Kill
    Pet({id=2703, item=169369}) -- Sandkeep
}}) -- Sandcastle

nodes[coord(2,1)] = Rare({id=152795, quest=56277, minimap=false, note=L["east_spawn"], rewards={
    Achievement({id=13691, criteria=45544}), -- Kill
    Achievement({id=13692, criteria=46099}), -- Giant Crab Leg
    Pet({id=2684, item=169350}) -- Glittering Diamondshell
}}) -- Sandclaw Stoneshell

-------------------------------------------------------------------------------
------------------------------------ CAVES ------------------------------------
-------------------------------------------------------------------------------

nodes[39897717] = Cave({parent=nodes[37378256], label=L["blindlight_cave"]})
nodes[42261342] = Cave({parent=nodes[40790735], label=L["caverndark_cave"]})
nodes[47588538] = Cave({parent=nodes[49208875], label=L["chasmhaunt_cave"]})
nodes[63081189] = Cave({parent=nodes[62740809], label=L["shassera_cave"]})

-------------------------------------------------------------------------------
------------------------------------ SLIMES -----------------------------------
-------------------------------------------------------------------------------

local SLIME_PETS = {
    Pet({id=2762, item=167809}), -- Slimy Darkhunter
    Pet({id=2758, item=167808}), -- Slimy Eel
    Pet({id=2761, item=167807}), -- Slimy Fangtooth
    Pet({id=2763, item=167810}), -- Slimy Hermit Crab
    Pet({id=2760, item=167806}), -- Slimy Octopode
    Pet({id=2757, item=167805}), -- Slimy Otter
    Pet({id=2765, item=167804})  -- Slimy Sea Slug
}

-- first quest is daily, second quest means done and gone until weekly reset
nodes[32773951] = NPC({id=151782, icon="slime", group=MechagonAndNazjatar.groups.SLIMES_NAZJ, quest={55430,55473}, questAny=true,
    note=L["ravenous_slime_note"], rewards=SLIME_PETS})
nodes[45692409] = NPC({id=151782, icon="slime", group=MechagonAndNazjatar.groups.SLIMES_NAZJ, quest={55429,55472}, questAny=true,
    note=L["ravenous_slime_note"], rewards=SLIME_PETS})
nodes[54894868] = NPC({id=151782, icon="slime", group=MechagonAndNazjatar.groups.SLIMES_NAZJ, quest={55427,55470}, questAny=true,
    note=L["ravenous_slime_note"], rewards=SLIME_PETS})
nodes[71722569] = NPC({id=151782, icon="slime", group=MechagonAndNazjatar.groups.SLIMES_NAZJ, quest={55428,55471}, questAny=true,
    note=L["ravenous_slime_note"], rewards=SLIME_PETS})

-- once the second quest is true, the eggs should be displayed
nodes[32773952] = Node({icon="green_egg", group=MechagonAndNazjatar.groups.SLIMES_NAZJ, quest=55478, questDeps=55473,
    label=L["slimy_cocoon"], note=L["slimy_cocoon_note"], rewards=SLIME_PETS})
nodes[45692410] = Node({icon="green_egg", group=MechagonAndNazjatar.groups.SLIMES_NAZJ, quest=55477, questDeps=55472,
    label=L["slimy_cocoon"], note=L["slimy_cocoon_note"], rewards=SLIME_PETS})
nodes[54894869] = Node({icon="green_egg", group=MechagonAndNazjatar.groups.SLIMES_NAZJ, quest=55475, questDeps=55470,
    label=L["slimy_cocoon"], note=L["slimy_cocoon_note"], rewards=SLIME_PETS})
nodes[71722570] = Node({icon="green_egg", group=MechagonAndNazjatar.groups.SLIMES_NAZJ, quest=55476, questDeps=55471,
    label=L["slimy_cocoon"], note=L["slimy_cocoon_note"], rewards=SLIME_PETS})

HandyNotes_MechagonAndNazjatar:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED', function (...)
    -- Watch for a spellcast event that signals the slime was fed.
    -- https://www.wowhead.com/spell=293775/schleimphage-feeding-tracker
    local _, source, _, spellID = ...
    if (source == 'player' and spellID == 293775) then
        C_Timer.After(1, function()
            HandyNotes_MechagonAndNazjatar:Refresh()
        end)
    end
end)

-------------------------------------------------------------------------------
---------------------------------- TREASURES ----------------------------------
-------------------------------------------------------------------------------

-- Arcane Chests
nodes[34454040] = Treasure({quest=55954, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_01"]})
nodes[49576450] = Treasure({quest=55949, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_02"]})
nodes[85303860] = Treasure({quest=55938, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_03"]})
nodes[37906050] = Treasure({quest=55957, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_04"]})
nodes[79502720] = Treasure({quest=55942, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_05"]})
nodes[44704890] = Treasure({quest=55947, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_06"]})
nodes[34604360] = Treasure({quest=55952, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_07"]})
nodes[26003240] = Treasure({quest=55953, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_08"]})
nodes[50605000] = Treasure({quest=55955, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_09"]})
nodes[64303330] = Treasure({quest=55943, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_10"]})
nodes[52804980] = Treasure({quest=55945, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_11"]})
nodes[48508740] = Treasure({quest=55951, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_12"]})
nodes[43405820] = Treasure({quest=55948, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_13"]})
nodes[73203580] = Treasure({quest=55941, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_14"]})
nodes[80402980] = Treasure({quest=55939, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_15"]})
nodes[58003500] = Treasure({quest=55946, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_16"]})
nodes[74805320] = Treasure({quest=55940, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_17"]})
nodes[39804920] = Treasure({quest=55956, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_18"]})
nodes[38707440] = Treasure({quest=55950, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_19"]})
nodes[56303380] = Treasure({quest=55944, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, label=L["arcane_chest"], note=L["arcane_chest_20"]})

-- Glowing Arcane Chests
nodes[37900640] = Treasure({quest=55959, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, icon="shootbox_blue", scale=2, label=L["glowing_chest"], note=L["glowing_chest_1"]})
nodes[43951693] = Treasure({quest=55963, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, icon="shootbox_blue", scale=2, label=L["glowing_chest"], note=L["glowing_chest_2"]})
nodes[24803520] = Treasure({quest=56912, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, icon="shootbox_blue", scale=2, label=L["glowing_chest"], note=L["glowing_chest_3"]})
nodes[55701450] = Treasure({quest=55961, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, icon="shootbox_blue", scale=2, label=L["glowing_chest"], note=L["glowing_chest_4"]})
nodes[61402290] = Treasure({quest=55958, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, icon="shootbox_blue", scale=2, label=L["glowing_chest"], note=L["glowing_chest_5"]})
nodes[64102860] = Treasure({quest=55962, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, icon="shootbox_blue", scale=2, label=L["glowing_chest"], note=L["glowing_chest_6"]})
nodes[37201920] = Treasure({quest=55960, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, icon="shootbox_blue", scale=2, label=L["glowing_chest"], note=L["glowing_chest_7"]})
nodes[80493194] = Treasure({quest=56547, group=MechagonAndNazjatar.groups.TREASURES_NAZJ, icon="shootbox_blue", scale=2, label=L["glowing_chest"], note=L["glowing_chest_8"]})

-------------------------------------------------------------------------------
-------------------------------- CAT FIGURINES --------------------------------
-------------------------------------------------------------------------------

nodes[28752910] = Node({quest=56983, group=MechagonAndNazjatar.groups.CATS_NAZJ, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_01"]})
nodes[71342369] = Node({quest=56988, group=MechagonAndNazjatar.groups.CATS_NAZJ, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_02"]})
nodes[73582587] = Node({quest=56992, group=MechagonAndNazjatar.groups.CATS_NAZJ, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_03"]})
nodes[58212198] = Node({quest=56990, group=MechagonAndNazjatar.groups.CATS_NAZJ, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_04"]})
nodes[61092681] = Node({quest=56984, group=MechagonAndNazjatar.groups.CATS_NAZJ, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_05"]})
nodes[40168615] = Node({quest=56987, group=MechagonAndNazjatar.groups.CATS_NAZJ, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_06"]})
nodes[59093053] = Node({quest=56985, group=MechagonAndNazjatar.groups.CATS_NAZJ, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_07"]})
nodes[55362715] = Node({quest=56986, group=MechagonAndNazjatar.groups.CATS_NAZJ, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_08"]})
nodes[61641079] = Node({quest=56991, group=MechagonAndNazjatar.groups.CATS_NAZJ, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_09"]})
nodes[38004925] = Node({quest=56989, group=MechagonAndNazjatar.groups.CATS_NAZJ, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_10"]})

HandyNotes_MechagonAndNazjatar:RegisterEvent('CRITERIA_EARNED', function (...)
    -- Watch for criteria events that signal the figurine was clicked
    local _, achievement = ...
    if achievement == 13836 then
        C_Timer.After(1, function()
            HandyNotes_MechagonAndNazjatar:Refresh()
        end)
    end
end)

-------------------------------------------------------------------------------
--------------------------------- BATTLE PETS ---------------------------------
-------------------------------------------------------------------------------

nodes[34702740] = PetBattle({id=154910, note=L["in_cave"]}) -- Prince Wiggletail
nodes[71905110] = PetBattle({id=154911}) -- Chomp
nodes[58304810] = PetBattle({id=154912}) -- Silence
nodes[42201400] = PetBattle({id=154913}) -- Shadowspike Lurker
nodes[50605030] = PetBattle({id=154914, note=L["in_cave"]}) -- Pearlhusk Crawler
nodes[51307500] = PetBattle({id=154915}) -- Elderspawn of Nalaada
nodes[29604970] = PetBattle({id=154916, note=L["in_cave"]}) -- Ravenous Scalespawn
nodes[56400810] = PetBattle({id=154917, note=L["in_cave"]}) -- Mindshackle
nodes[46602800] = PetBattle({id=154918, note=L["in_cave"]}) -- Kelpstone
nodes[37501670] = PetBattle({id=154919, note=L["in_cave"]}) -- Voltgorger
nodes[61472290] = PetBattle({id=154920, note=L["in_cave"]}) -- Frenzied Knifefang
nodes[28102670] = PetBattle({id=154921, note=L["in_cave"]}) -- Giant Opaline Conch

-------------------------------------------------------------------------------
------------------------------ WAR SUPPLY CHESTS ------------------------------
-------------------------------------------------------------------------------

local ASSASSIN_ACHIEVE = Achievement({id=13720, criteria={
    {id=45790, suffix=L["assassin_looted"]}
}})

nodes[47864647] = Supply({label=L["supply_chest"], rewards={ASSASSIN_ACHIEVE}}) -- north basin
nodes[47285170] = Supply({label=L["supply_chest"], rewards={ASSASSIN_ACHIEVE}}) -- south basin
nodes[45237040] = Supply({label=L["supply_chest"], rewards={ASSASSIN_ACHIEVE}}) -- south of newhome
nodes[33493889] = Supply({label=L["supply_chest"], rewards={ASSASSIN_ACHIEVE}}) -- ashen strand (also 33283441?)
nodes[59663755] = Supply({label=L["supply_chest"], rewards={ASSASSIN_ACHIEVE}}) -- coral forest
nodes[76873699] = Supply({label=L["supply_chest"], rewards={ASSASSIN_ACHIEVE}}) -- zin-azshari

-------------------------------------------------------------------------------
-------------------------------- MISCELLANEOUS --------------------------------
-------------------------------------------------------------------------------

nodes[60683221] = Node({quest=55121, group=MechagonAndNazjatar.groups.MISC_NAZJ, icon="portal_blue", scale=1.5, label=L["mardivas_lab"], rewards={
    Achievement({id=13699, criteria={ -- Periodic Destruction
        {id=45678, note=' ('..L["no_reagent"]..')'}, -- Arcane Amalgamation
        {id=45679, note=' ('..L["swater"]..')'}, -- Watery Amalgamation
        {id=45680, note=' ('..L["sfire"]..')'}, -- Burning Amalgamation
        {id=45681, note=' ('..L["searth"]..')'}, -- Dusty Amalgamation
        {id=45682, note=' ('..L["swater"].." + "..L["gearth"]..')'}, -- Zomera
        {id=45683, note=' ('..L["swater"].." + "..L["gfire"]..')'}, -- Omus
        {id=45684, note=' ('..L["swater"].." + "..L["gwater"]..')'}, -- Osgen
        {id=45685, note=' ('..L["sfire"].." + "..L["gearth"]..')'}, -- Moghiea
        {id=45686, note=' ('..L["sfire"].." + "..L["gwater"]..')'}, -- Xue
        {id=45687, note=' ('..L["sfire"].." + "..L["gfire"]..')'}, -- Ungormath
        {id=45688, note=' ('..L["searth"].." + "..L["gwater"]..')'}, -- Spawn of Salgos
        {id=45689, note=' ('..L["searth"].." + "..L["gearth"]..')'}, -- Herald of Salgos
        {id=45690, note=' ('..L["searth"].." + "..L["gfire"]..')'} -- Salgos the Eternal
    }}),
    Transmog({item=170138, slot=L["offhand"], note=L["Watery"]}), -- Scroll of Violent Tides
    Transmog({item=170126, slot=L["bow"], note=L["Burning"]}), -- Igneous Longbow
    Transmog({item=170383, slot=L["shield"], note=L["Dusty"]}), -- Coralspine Bulwark
    Transmog({item=170137, slot=L["dagger"], note=L["Zomera"]}), -- Azerite-Infused Crystal Flayer
    Transmog({item=170132, slot=L["1h_sword"], note=L["Omus"]}), -- Slicer of Omus
    Transmog({item=170130, slot=L["warglaives"], note=L["Osgen"]}), -- Glaive of Swells
    Transmog({item=170128, slot=L["staff"], note=L["Moghiea"]}), -- Majestic Shirakess Greatstaff
    Transmog({item=170127, slot=L["polearm"], note=L["Xue"]}), -- Pyroclastic Halberd
    Transmog({item=170131, slot=L["wand"], note=L["Ungormath"]}), -- Tidal Wand of Malevolence
    Transmog({item=170124, slot=L["2h_sword"], note=L["Spawn"]}), -- Coral-Sharpened Greatsword
    Transmog({item=170125, slot=L["fist"], note=L["Herald"]}), -- Behemoth Claw of the Abyss
    Transmog({item=170129, slot=L["1h_mace"], note=L["Salgos"]}) -- Salgos' Volatile Basher
}})

nodes[45993245] = Node({icon="diablo_murloc", group=MechagonAndNazjatar.groups.MISC_NAZJ, label=L["murloco"], note=L["tentacle_taco"]})
