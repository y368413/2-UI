local VisionsOfNZoth = {}

VisionsOfNZoth.Class = function (name, parent, attrs)
    parent = parent or {}
    local Class = attrs or {}
    Class.getters = {}
    Class.setters = {}

    setmetatable(Class, {
        __call = function (self, instance)
            instance = instance or {}
            instance.__class = Class;

            local address = tostring(instance):gsub("table: ", "", 1)

            setmetatable(instance, {
                __tostring = function ()
                    return '<'..name..' object at '..address..'>'
                end,

                __index = function (self, index)
                    local getter = Class.getters[index]
                    if getter then return getter(self) end
                    return Class[index]
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

            local init = Class.init
            if init then init(instance) end

            return instance
        end,

        __tostring = function ()
            return '<class "'..name..'">'
        end,

        __index = parent
    })

    if parent then
        setmetatable(Class.getters, { __index = parent.getters })
        setmetatable(Class.setters, { __index = parent.setters })
        Class.__parent = parent
    else
        -- Add default init() method for base class
        Class.init = function (self) end
    end

    return Class
end

VisionsOfNZoth.isinstance = function (instance, class)
    local function compare (c1, c2)
        if c2 == nil then return false end
        if c1 == c2 then return true end
        return compare(c1, c2.__parent)
    end
    return compare(class, instance.__class)
end

VisionsOfNZoth.clone = function (instance, newattrs)
    local clone = {}
    for k, v in pairs(instance) do clone[k] = v end
    for k, v in pairs(newattrs or {}) do clone[k] = v end
    return instance.__class(clone)
end


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local HandyNotes_VisionsOfNZoth = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_VisionsOfNZoth", "AceBucket-3.0", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes", true);

VisionsOfNZoth.maps = {};

VisionsOfNZoth.status = {
    Green = function (t) return string.format('(|cFF00FF00%s|r)', t) end,
    Gray = function (t) return string.format('(|cFF999999%s|r)', t) end,
    Red = function (t) return string.format('(|cFFFF0000%s|r)', t) end,
    Orange = function (t) return string.format('(|cFFFF8C00%s|r)', t) end
}

-------------------------------------------------------------------------------
----------------------------------- HELPERS -----------------------------------
-------------------------------------------------------------------------------

local DropdownMenu = CreateFrame("Frame", "HandyNotes_VisionsOfNZothDropdownMenu");
DropdownMenu.displayMode = "MENU";
local function initializeDropdownMenu (button, level, mapID, coord)
    if not level then return end
    local node = VisionsOfNZoth.maps[mapID].nodes[coord];
    local spacer = {text='', disabled=1, notClickable=1, notCheckable=1};

    if (level == 1) then
        UIDropDownMenu_AddButton({
            text=L["context_menu_title_Visions"], isTitle=1, notCheckable=1
        }, level);

        UIDropDownMenu_AddButton(spacer, level);

        if select(2, IsAddOnLoaded('TomTom')) then
            UIDropDownMenu_AddButton({
                text=L["context_menu_add_tomtom"], notCheckable=1,
                func=function (button)
                    local x, y = HandyNotes:getXY(coord);
                    TomTom:AddWaypoint(mapID, x, y, {
                        title = VisionsOfNZoth.NameResolver:GetCachedName(node.label),
                        persistent = nil,
                        minimap = true,
                        world = true
                    });
                end
            }, level);
        end

        UIDropDownMenu_AddButton({
            text=L["context_menu_hide_node"], notCheckable=1,
            func=function (button)
                HandyNotes_VisionsOfNZoth.db.char[mapID..'_coord_'..coord] = true;
                HandyNotes_VisionsOfNZoth:Refresh()
            end
        }, level);

        UIDropDownMenu_AddButton({
            text=L["context_menu_restore_hidden_nodes"], notCheckable=1,
            func=function ()
                table.wipe(HandyNotes_VisionsOfNZoth.db.char)
                HandyNotes_VisionsOfNZoth:Refresh()
            end
        }, level);

        UIDropDownMenu_AddButton(spacer, level);

        UIDropDownMenu_AddButton({
            text=CLOSE, notCheckable=1,
            func=function() CloseDropDownMenus() end
        }, level);
    end
end

-------------------------------------------------------------------------------
---------------------------------- CALLBACKS ----------------------------------
-------------------------------------------------------------------------------

function HandyNotes_VisionsOfNZoth:OnEnter(mapID, coord)
    local node = VisionsOfNZoth.maps[mapID].nodes[coord];
    local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip;

    if self:GetCenter() > UIParent:GetCenter() then
        tooltip:SetOwner(self, "ANCHOR_LEFT");
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT");
    end

    VisionsOfNZoth.NameResolver:Resolve(node.label, function (label)
        tooltip:SetText(label or UNKNOWN)

        -- optional top-right text
        if node.rlabel then
            local rtext = _G[tooltip:GetName()..'TextRight1']
            rtext:SetTextColor(1, 1, 1)
            rtext:SetText(node.rlabel)
            rtext:Show()
        end

        if node.sublabel then
            tooltip:AddLine(node.sublabel, 1, 1, 1)
        end

        if node.note and HandyNotes_VisionsOfNZoth.db.profile.show_notes then
            if node.sublabel then tooltip:AddLine(" ") end
            tooltip:AddLine(node.note, 1, 1, 1, true)
        end

        if HandyNotes_VisionsOfNZoth.db.profile.show_loot then
            local firstAchieve, firstOther = true, true
            for i, reward in ipairs(node.rewards or {}) do

                -- Add a blank line between achievements and other rewards
                local isAchieve = VisionsOfNZoth.isinstance(reward, VisionsOfNZoth.reward.Achievement)
                if isAchieve and firstAchieve then
                    tooltip:AddLine(" ")
                    firstAchieve = false
                elseif not isAchieve and firstOther then
                    tooltip:AddLine(" ")
                    firstOther = false
                end

                reward:render(tooltip);
            end
        end

        node._hover = true
        VisionsOfNZoth.MinimapDataProvider:RefreshAllData()
        VisionsOfNZoth.WorldMapDataProvider:RefreshAllData()
        tooltip:Show()
    end)
end

function HandyNotes_VisionsOfNZoth:OnLeave(mapID, coord)
    local node = VisionsOfNZoth.maps[mapID].nodes[coord]
    node._hover = false
    VisionsOfNZoth.MinimapDataProvider:RefreshAllData()
    VisionsOfNZoth.WorldMapDataProvider:RefreshAllData()
    if self:GetParent() == WorldMapButton then
        WorldMapTooltip:Hide();
    else
        GameTooltip:Hide();
    end
end

function HandyNotes_VisionsOfNZoth:OnClick(button, down, mapID, coord)
    local node = VisionsOfNZoth.maps[mapID].nodes[coord]
    if button == "RightButton" and down then
        DropdownMenu.initialize = function (button, level)
            initializeDropdownMenu(button, level, mapID, coord)
        end;
        ToggleDropDownMenu(1, nil, DropdownMenu, self, 0, 0)
    elseif button == "LeftButton" and down then
        if node.pois then
            node._focus = not node._focus
            HandyNotes_VisionsOfNZoth:Refresh()
        end
    end
end

function HandyNotes_VisionsOfNZoth:OnInitialize()
    VisionsOfNZoth.faction = UnitFactionGroup('player')
    self.db = LibStub("AceDB-3.0"):New('HandyNotes_VisionsOfNZothDB', VisionsOfNZoth.optionDefaults, "Default")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", function ()
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        self:ScheduleTimer("RegisterWithHandyNotes", 1)
    end)
end

-------------------------------------------------------------------------------
------------------------------------ MAIN -------------------------------------
-------------------------------------------------------------------------------

function HandyNotes_VisionsOfNZoth:RegisterWithHandyNotes()
    do
        local map, minimap
        local function iter(nodes, precoord)
            if not nodes then return nil end
            if minimap and self.db.profile.hide_minimap then return nil end
            local force = self.db.profile.force_nodes
            local coord, node = next(nodes, precoord)
            while coord do -- Have we reached the end of this zone?
                if node and (force or map:enabled(node, coord, minimap)) then
                    local icon, scale, alpha = node:display()
                    return coord, nil, icon, scale, alpha
                end
                coord, node = next(nodes, coord) -- Get next node
            end
            return nil, nil, nil, nil
        end
        function HandyNotes_VisionsOfNZoth:GetNodes2(mapID, _minimap)
            map = VisionsOfNZoth.maps[mapID]
            minimap = _minimap

            if map then
                map:prepare()
                return iter, map.nodes, nil
            end

            -- mapID not handled by this plugin
            return iter, nil, nil
        end
    end

    if self.db.profile.development then
        VisionsOfNZoth.BootstrapDevelopmentEnvironment()
    end

    HandyNotes:RegisterPluginDB("HandyNotes_VisionsOfNZoth", self, VisionsOfNZoth.options)

    self:RegisterBucketEvent({ "LOOT_CLOSED", "PLAYER_MONEY", "SHOW_LOOT_TOAST", "SHOW_LOOT_TOAST_UPGRADE" }, 2, "Refresh")
    self:Refresh()
end

function HandyNotes_VisionsOfNZoth:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_VisionsOfNZoth")
    VisionsOfNZoth.MinimapDataProvider:RefreshAllData()
    VisionsOfNZoth.WorldMapDataProvider:RefreshAllData()
end

local ICONS = "Interface\\Addons\\HandyNotes\\Icons\\icons.blp"
local ICONS_WIDTH = 255
local ICONS_HEIGHT = 255  --511

local function coords(x, y, grid, xo, yo)
    grid, xo, yo = grid or 32, xo or 0, yo or 0
    return { xo+x*grid, xo+(x+1)*grid-1, yo+y*grid, yo+(y+1)*grid-1 }
end

VisionsOfNZoth.icons = {

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

    quest_yellow = { icon=ICONS, coords=coords(0, 0) },
    quest_blue = { icon=ICONS, coords=coords(0, 1) },
    quest_orange = { icon=ICONS, coords=coords(0, 2) },
    quest_green = { icon=ICONS, coords=coords(0, 3) },
    quest_yellow_old = { icon=ICONS, coords=coords(0, 4) },
    quest_blue_old = { icon=ICONS, coords=coords(0, 5) },

    quest_repeat_yellow = { icon=ICONS, coords=coords(0, 6) },
    quest_repeat_blue = { icon=ICONS, coords=coords(0, 7) },
    quest_repeat_orange = { icon=ICONS, coords=coords(1, 0) },
    quest_repeat_blue_old = { icon=ICONS, coords=coords(1, 1) },

    peg_blue = { icon=ICONS, coords=coords(1, 2) },
    peg_red = { icon=ICONS, coords=coords(1, 3) },
    peg_green = { icon=ICONS, coords=coords(1, 4) },
    peg_yellow = { icon=ICONS, coords=coords(1, 5) },

    gpeg_red = { icon=ICONS, coords=coords(1, 6) },
    gpeg_green = { icon=ICONS, coords=coords(1, 7) },
    gpeg_yellow = { icon=ICONS, coords=coords(2, 7) },

    envelope = { icon=ICONS, coords=coords(6, 7) },
    orange_crystal = { icon=ICONS, coords=coords(2, 6) },

    door_down = { icon=ICONS, coords=coords(2, 0) },
    door_left = { icon=ICONS, coords=coords(2, 1) },
    door_right = { icon=ICONS, coords=coords(2, 2) },
    door_up = { icon=ICONS, coords=coords(2, 3) },

    portal_blue = { icon=ICONS, coords=coords(2, 4) },
    portal_red = { icon=ICONS, coords=coords(2, 5) },

    chest_gray = { icon=ICONS, coords=coords(3, 0) },
    chest_yellow = { icon=ICONS, coords=coords(3, 1) },
    chest_orange = { icon=ICONS, coords=coords(3, 2) },
    chest_red = { icon=ICONS, coords=coords(3, 3) },
    chest_purple = { icon=ICONS, coords=coords(3, 4) },
    chest_blue = { icon=ICONS, coords=coords(3, 5) },
    chest_lblue = { icon=ICONS, coords=coords(3, 6) },
    chest_teal = { icon=ICONS, coords=coords(3, 7) },
    chest_camo = { icon=ICONS, coords=coords(4, 0) },
    chest_lime = { icon=ICONS, coords=coords(4, 1) },
    chest_brown = { icon=ICONS, coords=coords(4, 2) },
    chest_white = { icon=ICONS, coords=coords(4, 3) },

    paw_yellow = { icon=ICONS, coords=coords(4, 4) },
    paw_green = { icon=ICONS, coords=coords(4, 5) },

    skull_white = { icon=ICONS, coords=coords(4, 6) },
    skull_blue = { icon=ICONS, coords=coords(4, 7) },

    skull_white_red_glow = { icon=ICONS, coords=coords(0, 0, 48, 160) },
    skull_blue_red_glow = { icon=ICONS, coords=coords(0, 1, 48, 160) },
    skull_white_green_glow = { icon=ICONS, coords=coords(1, 0, 48, 160) },
    skull_blue_green_glow = { icon=ICONS, coords=coords(1, 1, 48, 160) },

    star_chest = { icon=ICONS, coords=coords(0, 2, 48, 160) },
    star_skull = { icon=ICONS, coords=coords(0, 3, 48, 160) },
    star_swords = { icon=ICONS, coords=coords(0, 4, 48, 160) },

    shootbox_blue = { icon=ICONS, coords=coords(1, 2, 48, 160) },
    shootbox_yellow = { icon=ICONS, coords=coords(1, 3, 48, 160) },
    shootbox_pink = { icon=ICONS, coords=coords(1, 4, 48, 160) }
};

for name, icon in pairs(VisionsOfNZoth.icons) do
    if type(icon) == 'table' then
        icon.tCoordLeft = icon.coords[1]/ICONS_WIDTH
        icon.tCoordRight = icon.coords[2]/ICONS_WIDTH
        icon.tCoordTop = icon.coords[3]/ICONS_HEIGHT
        icon.tCoordBottom = icon.coords[4]/ICONS_HEIGHT
        icon.coords = nil
    end
end

-------------------------------------------------------------------------------
---------------------------------- DEFAULTS -----------------------------------
-------------------------------------------------------------------------------

VisionsOfNZoth.optionDefaults = {
    profile = {
        -- icon scales
        icon_scale_caves = 1,
        icon_scale_other = 1,
        icon_scale_pet_battles = 1,
        icon_scale_rares = 1,
        icon_scale_treasures = 1,
        icon_scale_assaultevents = 1,

        -- icon alphas
        icon_alpha_caves = 0.75,
        icon_alpha_other = 1.0,
        icon_alpha_pet_battles = 1.0,
        icon_alpha_rares = 0.75,
        icon_alpha_treasures = 0.75,
        icon_alpha_assaultevents = 1.0,

        -- visibility
        always_show_rares = false,
        always_show_treasures = false,
        hide_done_rare = false,
        hide_minimap = false,

        -- tooltip
        show_loot = true,
        show_notes = true,

        -- development
        development = false,
        force_nodes = false
    },
};

-------------------------------------------------------------------------------
--------------------------------- OPTIONS UI ----------------------------------
-------------------------------------------------------------------------------

VisionsOfNZoth.options = {
    type = "group",
    name = L["options_title_Visions"],
    get = function(info) return HandyNotes_VisionsOfNZoth.db.profile[info.arg] end,
    set = function(info, v) HandyNotes_VisionsOfNZoth.db.profile[info.arg] = v; HandyNotes_VisionsOfNZoth:Refresh() end,
    args = {}
}

VisionsOfNZoth.options.args.IconOptions = {
    type = "group",
    name = L["options_icon_settings"],
    inline = true,
    order = 0,
    args = {}
}

for i, group in ipairs{'treasures', 'rares', 'assaultevents', 'pet_battles', 'caves', 'other'} do
    VisionsOfNZoth.options.args.IconOptions.args['group_icon_'..group] = {
        type = "header",
        name = L["options_icons_"..group],
        order = i * 10,
    }

    VisionsOfNZoth.options.args.IconOptions.args['icon_scale_'..group] = {
        type = "range",
        name = L["options_scale"],
        desc = L["options_scale_desc"],
        min = 0.25, max = 3, step = 0.01,
        arg = "icon_scale_"..group,
        order = i * 10 + 1,
    }

    VisionsOfNZoth.options.args.IconOptions.args['icon_alpha_'..group] = {
        type = "range",
        name = L["options_opacity"],
        desc = L["options_opacity_desc"],
        min = 0, max = 1, step = 0.01,
        arg = "icon_alpha_"..group,
        order = i * 10 + 2,
    }
end

VisionsOfNZoth.options.args.VisibilityGroup = {
    type = "group",
    order = 10,
    name = L["options_visibility_settings"],
    inline = true,
    args = {
        groupGeneral = {
            type = "header",
            name = L["options_general_settings"],
            order = 100,
        },
        always_show_rares = {
            type = "toggle",
            arg = "always_show_rares",
            name = L["options_toggle_looted_rares"],
            desc = L["options_toggle_looted_rares_desc"],
            order = 101,
            width = "full",
        },
        always_show_treasures = {
            type = "toggle",
            arg = "always_show_treasures",
            name = L["options_toggle_looted_treasures"],
            desc = L["options_toggle_looted_treasures_desc"],
            order = 102,
            width = "full",
        },
        hide_done_rare = {
            type = "toggle",
            arg = "hide_done_rare",
            name = L["options_toggle_hide_done_rare"],
            desc = L["options_toggle_hide_done_rare_desc"],
            order = 103,
            width = "full",
        },
        hide_minimap = {
            type = "toggle",
            arg = "hide_minimap",
            name = L["options_toggle_hide_minimap"],
            desc = L["options_toggle_hide_minimap_desc"],
            order = 104,
            width = "full",
        },
        restore_all_nodes = {
            type = "execute",
            name = L["options_restore_hidden_nodes"],
            desc = L["options_restore_hidden_nodes_desc"],
            order = 105,
            func = function ()
                table.wipe(HandyNotes_VisionsOfNZoth.db.char)
                HandyNotes_VisionsOfNZoth:Refresh()
            end
        }
    },
}

VisionsOfNZoth.options.args.TooltipGroup = {
    type = "group",
    order = 20,
    name = L["options_tooltip_settings"],
    inline = true,
    args = {
        show_loot = {
            type = "toggle",
            arg = "show_loot",
            name = L["options_toggle_show_loot"],
            desc = L["options_toggle_show_loot_desc"],
            order = 102,
        },
        show_notes = {
            type = "toggle",
            arg = "show_notes",
            name = L["options_toggle_show_notes"],
            desc = L["options_toggle_show_notes_desc"],
            order = 103,
        }
    }
}


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
    VisionsOfNZoth.options.args.DevelopmentGroup = {
        type = "group",
        order = 30,
        name = L["options_dev_settings"],
        desc = L["options_dev_settings_desc"],
        inline = true,
        args = {
            force_nodes = {
                type = "toggle",
                arg = "force_nodes",
                name = L["options_toggle_force_nodes"],
                desc = L["options_toggle_force_nodes_desc"],
                order = 3,
            }
        }
    }

    -- Print debug messages for each quest ID that is flipped
    local QTFrame = CreateFrame('Frame', "HandyNotes_VisionsOfNZothQT")
    local lastCheck = GetTime()
    local quests = {}
    local max_quest_id = 100000
    C_Timer.After(1, function ()
        -- Give some time for quest info to load in before we start
        for id = 0, max_quest_id do quests[id] = IsQuestFlaggedCompleted(id) end
        QTFrame:SetScript('OnUpdate', function ()
            if GetTime() - lastCheck > 1 then
                local changed = {}
                for id = 0, max_quest_id do
                    local s = IsQuestFlaggedCompleted(id)
                    if s ~= quests[id] then
                        changed[#changed + 1] = {'Quest', id, 'changed:', tostring(quests[id]), '=>', tostring(s)}
                        quests[id] = s
                    end
                end
                if #changed <= 10 then
                    -- changing zones will sometimes cause thousands of quest
                    -- ids to flip state, we do not want to report on those
                    for i, args in ipairs(changed) do
                    end
                end
                lastCheck = GetTime()
            end
        end)
    end)

    -- Listen for LCTRL + LALT when the world map is open to display nodes
    -- that have already been cleared by quest ids.
    local IQFrame = CreateFrame('Frame', "HandyNotes_VisionsOfNZothIQ", WorldMapFrame)
    local groupPins = WorldMapFrame.pinPools.GroupMembersPinTemplate
    IQFrame:SetPropagateKeyboardInput(true)
    IQFrame:SetScript('OnKeyDown', function (_, key)
        if not VisionsOfNZoth.ignore_quests and (key == 'LCTRL' or key == 'LALT') then
            if IsLeftControlKeyDown() and IsLeftAltKeyDown() then
                IQFrame:SetPropagateKeyboardInput(false)
                VisionsOfNZoth.ignore_quests = true
                HandyNotes_VisionsOfNZoth:Refresh()

                -- Hide player pins on the map
                groupPins:GetNextActive():Hide()
            end
        end
    end)
    IQFrame:SetScript('OnKeyUp', function (_, key)
        if VisionsOfNZoth.ignore_quests and (key == 'LCTRL' or key == 'LALT') then
            IQFrame:SetPropagateKeyboardInput(true)
            VisionsOfNZoth.ignore_quests = false
            HandyNotes_VisionsOfNZoth:Refresh()

            -- Show player pins on the map
            groupPins:GetNextActive():Show()
        end
    end)
end

-------------------------------------------------------------------------------

VisionsOfNZoth.BootstrapDevelopmentEnvironment = BootstrapDevelopmentEnvironment


-------------------------------------------------------------------------------
local Class = VisionsOfNZoth.Class
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local Map = Class('Map')

Map.id = 0
Map.intro = nil
Map.phased = true

function Map:init ()
    self.nodes = {}
end

function Map:prepare ()
    for coord, node in pairs(self.nodes) do
        VisionsOfNZoth.NameResolver:Prepare(node.label)
    end
end

function Map:enabled (node, coord, minimap)
    local db = HandyNotes_VisionsOfNZoth.db

    -- Check if the zone is still phased
    if node ~= self.intro and not self.phased then return false end

    -- Check if we've been hidden by the user
    if db.char[self.id..'_coord_'..coord] then return false end

    -- Check minimap, faction and quest completion
    if not node:enabled(self, coord, minimap) then return false end

    return true
end

-------------------------------------------------------------------------------
---------------------------- MINIMAP DATA PROVIDER ----------------------------
-------------------------------------------------------------------------------

local HBD = LibStub("HereBeDragons-2.0")
local HBDPins = LibStub("HereBeDragons-Pins-2.0")
local MinimapPinsKey = "HandyNotes_VisionsOfNZothMinimapPins"
local MinimapDataProvider = CreateFrame("Frame", "HandyNotes_VisionsOfNZothMinimapDP")

MinimapDataProvider.facing = GetPlayerFacing()
MinimapDataProvider.indoors = GetCVar("minimapZoom")+0 == Minimap:GetZoom() and "outdoor" or "indoor"
MinimapDataProvider.pins = {}
MinimapDataProvider.pool = {}

-- The HBD author has already figured out the scale values for each zoom level
MinimapDataProvider.scales = {
    indoor = {1, 1.25, 5/3, 2.5, 3.75, 6},
    outdoor = {1, 7/6, 1.4, 1.75, 7/3, 3.5}
}

-- These values for width/height seem to render the minimap POIs correctly. I
-- still haven't figured out how to get these values out of the API, these were
-- manually found by tweaking values at a 1.5 width/height ratio until things
-- looked right =/.
MinimapDataProvider.sizes = {
    [1527] = {1750, 1312},   -- Uldum
    [1530] = {700, 466}     -- Vale
}

function MinimapDataProvider:ReleasePin(pin)
    pin:Hide()
    self.pool[pin] = true
end

function MinimapDataProvider:ReleaseAllPins()
    for i, pin in ipairs(self.pins) do
        self:ReleasePin(pin)
    end
end

function MinimapDataProvider:AcquirePin(mapID, poi, ...)
    local pin = next(self.pool)
    if pin then
        self.pool[pin] = nil -- remove it from the pool
    else
        pin = self:CreatePin()
    end

    local scale = self.scales[self.indoors][Minimap:GetZoom()+1]
    local sizes = self.sizes[mapID] or {750, 500}
    pin.parentWidth = sizes[1] * scale
    pin.parentHeight = sizes[2] * scale

    local x, y = poi:draw(pin, ...)
    if GetCVar('rotateMinimap') == '1' then
        pin.texture:SetRotation(pin.texture:GetRotation() + math.pi*2 - self.facing)
    end
    HBDPins:AddMinimapIconMap(MinimapPinsKey, pin, mapID, x, y, true)
end

function MinimapDataProvider:CreatePin()
    local name = "HandyNotes_VisionsOfNZothPin"..(#self.pins + 1)
    local pin = CreateFrame("Button", name, Minimap)
    local texture = pin:CreateTexture(nil, "OVERLAY")
    pin:SetFrameLevel(Minimap:GetFrameLevel() + 3)
    pin:SetFrameStrata(Minimap:GetFrameStrata())
    pin:SetParent(Minimap)
    pin:SetWidth(12)
    pin:SetHeight(12)
    pin.minimap = true
    pin.texture = texture
    texture:SetAllPoints(pin)
    texture:SetTexelSnappingBias(0)
    texture:SetSnapToPixelGrid(false)
    pin:Hide()
    self.pins[#self.pins + 1] = pin
    return pin
end

function MinimapDataProvider:RefreshAllData()
    self.lastRefresh = GetTime()
    HBDPins:RemoveAllMinimapIcons(MinimapPinsKey)
    self:ReleaseAllPins()

    local map = VisionsOfNZoth.maps[HBD:GetPlayerZone()]
    if not map then return end

    for coord, node in pairs(map.nodes) do
        if (node._focus or node._hover) and map:enabled(node, coord, true) then
            for i, poi in ipairs(node.pois or {}) do
                poi:render(self, map.id)
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

MinimapDataProvider:SetScript('OnUpdate', function ()
    MinimapDataProvider:OnUpdate()
end)

HandyNotes_VisionsOfNZoth:RegisterEvent('MINIMAP_UPDATE_ZOOM', function (...)
    local zoom = Minimap:GetZoom()
    if GetCVar("minimapZoom") == GetCVar("minimapInsideZoom") then
        Minimap:SetZoom(zoom < 2 and zoom + 1 or zoom - 1)
    end
    MinimapDataProvider.indoors = GetCVar("minimapZoom")+0 == Minimap:GetZoom() and "outdoor" or "indoor"
    Minimap:SetZoom(zoom)
end)

hooksecurefunc(Minimap, "SetZoom", function ()
    MinimapDataProvider:RefreshAllData()
end)

-------------------------------------------------------------------------------
--------------------------- WORLD MAP DATA PROVIDER ---------------------------
-------------------------------------------------------------------------------

local WorldMapDataProvider = CreateFromMixins(MapCanvasDataProviderMixin)
local WorldMapPinTemplate = 'HandyNotes_VisionsOfNZothWorldMapPinTemplate'
local WorldMapPinMixin = CreateFromMixins(MapCanvasPinMixin)

_G['HandyNotes_VisionsOfNZothWorldMapPinMixin'] = WorldMapPinMixin

function WorldMapDataProvider:RemoveAllData()
    if self:GetMap() then
        self:GetMap():RemoveAllPinsByTemplate(WorldMapPinTemplate)
    end
end

function WorldMapDataProvider:RefreshAllData(fromOnShow)
    self:RemoveAllData()

    if not self:GetMap() then return end
    local map = VisionsOfNZoth.maps[self:GetMap():GetMapID()]
    if not map then return end

    for coord, node in pairs(map.nodes) do
        if (node._focus or node._hover) and map:enabled(node, coord, false) then
            for i, poi in ipairs(node.pois or {}) do
                poi:render(self:GetMap(), WorldMapPinTemplate)
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
    local l, b, w, h = self:GetParent():GetRect()
    self.parentWidth = w
    self.parentHeight = h
    if (w and h) then
        local x, y = poi:draw(self, ...)
        self:SetPosition(x, y)
    end
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

VisionsOfNZoth.Map = Map
VisionsOfNZoth.MinimapDataProvider = MinimapDataProvider
VisionsOfNZoth.WorldMapDataProvider = WorldMapDataProvider


local isinstance = VisionsOfNZoth.isinstance

-------------------------------------------------------------------------------
------------------------------------ NODE -------------------------------------
-------------------------------------------------------------------------------

--[[

Base class for all displayed nodes.

    label (string): Tooltip title for this node
    icon (string|table): The icon texture to display
    alpha (float): The default alpha value for this type
    scale (float): The default scale value for this type
    minimap (bool): Should the node be displayed on the minimap
    quest (int|int[]): Quest IDs that cause this node to disappear
    requires (int|int[]): Quest IDs that must be true to appear
    rewards (Reward[]): Array of rewards for this node

--]]

local Node = Class('Node')

Node.label = UNKNOWN
Node.minimap = true
Node.alpha = 1
Node.scale = 1
Node.icon = "default"
Node.group = "other"

function Node:init ()
    -- normalize quest ids as tables instead of single values
    for i, key in ipairs{'quest', 'requires'} do
        if type(self[key]) == 'number' then self[key] = {self[key]} end
    end

    if self.minimap == nil then
        self.minimap = true
    end
end

function Node:display ()
    local db = HandyNotes_VisionsOfNZoth.db
    local icon = self.icon
    if type(icon) == 'string' then
        icon = VisionsOfNZoth.icons[self.icon] or VisionsOfNZoth.icons.default
    end
    local scale = self.scale * (db.profile['icon_scale_'..self.group] or 1)
    local alpha = self.alpha * (db.profile['icon_alpha_'..self.group] or 1)
    return icon, scale, alpha
end

function Node:done ()
    for i, reward in ipairs(self.rewards or {}) do
        if not reward:obtained() then return false end
    end
    return true
end

function Node:enabled (map, coord, minimap)
    local db = HandyNotes_VisionsOfNZoth.db

    -- Minimap may be disabled for this node
    if not self.minimap and minimap then return false end

    -- Node may be faction restricted
    if self.faction and self.faction ~= VisionsOfNZoth.faction then return false end

    if not VisionsOfNZoth.ignore_quests then
        -- All attached quest ids must be false
        for i, quest in ipairs(self.quest or {}) do
            if IsQuestFlaggedCompleted(quest) then return false end
        end

        -- All required quest ids must be true
        for i, quest in ipairs(self.requires or {}) do
            if not IsQuestFlaggedCompleted(quest) then return false end
        end
    end

    return true
end

-------------------------------------------------------------------------------
------------------------------------ CAVE -------------------------------------
-------------------------------------------------------------------------------

local Cave = Class('Cave', Node)

Cave.icon = "door_down"
Cave.scale = 1.2
Cave.group = "caves"

function Cave:init ()
    Node.init(self)

    if self.parent == nil then
        error('One or more parent nodes are required for Cave nodes')
    elseif isinstance(self.parent, Node) then
        -- normalize parent nodes as tables instead of single values
        self.parent = {self.parent}
    end
end

function Cave:enabled (map, coord, minimap)
    if not Node.enabled(self, map, coord, minimap) then return false end

    local function hasEnabledParent ()
        for i, parent in ipairs(self.parent or {}) do
            if parent:enabled(map, coord, minimap) then
                return true
            end
        end
        return false
    end

    -- Check if all our parents are hidden
    if not hasEnabledParent() then return false end

    return true
end

-------------------------------------------------------------------------------
------------------------------------- NPC -------------------------------------
-------------------------------------------------------------------------------

local NPC = Class('NPC', Node)

function NPC:init ()
    Node.init(self)
    if not self.id then error('id required for NPC nodes') end
end

function NPC.getters:label ()
    return ("unit:Creature-0-0-0-0-%d"):format(self.id)
end

-------------------------------------------------------------------------------
---------------------------------- PETBATTLE ----------------------------------
-------------------------------------------------------------------------------

local PetBattle = Class('PetBattle', NPC)

PetBattle.icon = "paw_yellow"
PetBattle.group = "pet_battles"

-------------------------------------------------------------------------------
------------------------------------ QUEST ------------------------------------
-------------------------------------------------------------------------------

local Quest = Class('Quest', Node, {note=AVAILABLE_QUEST})
local QUEST_IDS = {}

function Quest:init ()
    Node.init(self)
    C_QuestLog.GetQuestInfo(self.quest[1]) -- fetch info from server

    for i, id in ipairs(self.quest) do
        QUEST_IDS[id] = true
    end
end

function Quest.getters:icon ()
    return self.daily and 'quest_blue' or 'quest_yellow'
end

function Quest.getters:label ()
    return C_QuestLog.GetQuestInfo(self.quest[1])
end

-- When a quest node is turned in, force a refresh. Not all quests give loot.
HandyNotes_VisionsOfNZoth:RegisterEvent('QUEST_TURNED_IN', function (_, id)
    if QUEST_IDS[id] then
        C_Timer.After(1, function() HandyNotes_VisionsOfNZoth:Refresh() end)
    end
end)

-------------------------------------------------------------------------------
-------------------------------- TIMED EVENT --------------------------------
-------------------------------------------------------------------------------

local TimedEvent = Class('TimedEvent', Quest, {scale=2, note=''})

TimedEvent.group = "assaultevents"

function TimedEvent.getters:icon ()
    -- Override icon getter to be a simple yellow peg
    return 'peg_yellow'
end

function TimedEvent:enabled (map, coord, minimap)
    if not VisionsOfNZoth.ignore_quests then
        -- Timed events that are not active today return nil here
        if not C_TaskQuest.GetQuestTimeLeftMinutes(self.quest[1]) then
            return false
        end
    end
    return Quest.enabled(self, map, coord, minimap)
end

-------------------------------------------------------------------------------
------------------------------------ RARE -------------------------------------
-------------------------------------------------------------------------------

local Rare = Class('Rare', NPC)

Rare.group = "rares"

function Rare.getters:icon ()
    if self._focus then
        return self:done() and 'skull_white_green_glow' or 'skull_blue_green_glow'
    end
    if HandyNotes_VisionsOfNZoth.db.profile.development and not self.quest then
        return self:done() and 'skull_white_red_glow' or 'skull_blue_red_glow'
    end
    return self:done() and 'skull_white' or 'skull_blue'
end

function Rare.getters:scale ()
    if self._focus or (HandyNotes_VisionsOfNZoth.db.profile.development and not self.quest) then
        return 2.3
    end
    return 1.5
end

function Rare:enabled (map, coord, minimap)
    local db = HandyNotes_VisionsOfNZoth.db
    if db.profile.hide_done_rare and self:done() then return false end
    if db.profile.always_show_rares then return true end
    return NPC.enabled(self, map, coord, minimap)
end

-------------------------------------------------------------------------------
---------------------------------- TREASURE -----------------------------------
-------------------------------------------------------------------------------

local Treasure = Class('Treasure', Node, {
    icon = 'chest_gray',
    scale = 1.3,
    group = 'treasures'
})

function Treasure:enabled (map, coord, minimap)
    local db = HandyNotes_VisionsOfNZoth.db
    if db.profile.always_show_treasures then return true end
    return Node.enabled(self, map, coord, minimap)
end

-------------------------------------------------------------------------------
----------------------------------- SUPPLY ------------------------------------
-------------------------------------------------------------------------------

local Supply = Class('Supply', Treasure, {
    icon = 'star_chest',
    scale = 2
})

-------------------------------------------------------------------------------

VisionsOfNZoth.node = {
    Node=Node,
    Cave=Cave,
    NPC=NPC,
    PetBattle=PetBattle,
    Quest=Quest,
    Rare=Rare,
    Supply=Supply,
    TimedEvent=TimedEvent,
    Treasure=Treasure
}

local Green = VisionsOfNZoth.status.Green
local Orange = VisionsOfNZoth.status.Orange
local Red = VisionsOfNZoth.status.Red

-------------------------------------------------------------------------------
----------------------------------- REWARD ------------------------------------
-------------------------------------------------------------------------------

local Reward = Class('Reward')

function Reward:obtained ()
    return true
end

function Reward:render (tooltip)
    tooltip:AddLine('Render not implemented: '..tostring(self))
end

-------------------------------------------------------------------------------
--------------------------------- ACHIEVEMENT ---------------------------------
-------------------------------------------------------------------------------

-- /run print(GetAchievementCriteriaInfo(ID, NUM))

local Achievement = Class('Achievement', Reward)
local GetCriteriaInfo = function (id, criteria)
    local results = {GetAchievementCriteriaInfoByID(id, criteria)}
    if not results[1] then
        results = {GetAchievementCriteriaInfo(id, criteria)}
    end
    return unpack(results)
end

function Achievement:init ()
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

function Achievement:obtained ()
    if select(4, GetAchievementInfo(self.id)) then return true end
    for i, c in ipairs(self.criteria) do
        local _, _, completed = GetCriteriaInfo(self.id, c.id)
        if not completed then return false end
    end
    return true
end

function Achievement:render (tooltip)
    local _,name,_,completed,_,_,_,_,_,icon = GetAchievementInfo(self.id)
    tooltip:AddLine(ACHIEVEMENT_COLOR_CODE..'['..name..']|r')
    tooltip:AddTexture(icon, {margin={right=2}})
    for i, c in ipairs(self.criteria) do
        local cname,_,ccomp,qty,req = GetCriteriaInfo(self.id, c.id)
        if (cname == '') then cname = qty..'/'..req end

        local r, g, b = .6, .6, .6
        local ctext = "   ? "..cname..(c.suffix or '')
        if (completed or ccomp) then
            r, g, b = 0, 1, 0
        end

        if c.note and HandyNotes_VisionsOfNZoth.db.profile.show_notes then
            tooltip:AddDoubleLine(ctext, c.note, r, g, b)
        else
            tooltip:AddLine(ctext, r, g, b)
        end
    end
end

-------------------------------------------------------------------------------
------------------------------------ ITEM -------------------------------------
-------------------------------------------------------------------------------

local Item = Class('Item', Reward)

function Item:init ()
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

function Item:obtained ()
    if self.quest then return IsQuestFlaggedCompleted(self.quest) end
    return true
end

function Item:render (tooltip)
    local text = self.itemLink
    local status = ''
    if self.quest then
        local completed = IsQuestFlaggedCompleted(self.quest)
        status = completed and Green(L['completed']) or Red(L['incomplete'])
    elseif self.weekly then
        local completed = IsQuestFlaggedCompleted(self.weekly)
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

-- /run for i,m in ipairs(C_MountJournal.GetMountIDs()) do if (C_MountJournal.GetMountInfoByID(m) == "NAME") then print(m); end end

local Mount = Class('Mount', Item)

function Mount:obtained ()
    return select(11, C_MountJournal.GetMountInfoByID(self.id))
end

function Mount:render (tooltip)
    local collected = select(11, C_MountJournal.GetMountInfoByID(self.id))
    local status = collected and Green(L["known"]) or Red(L["missing"])
    tooltip:AddDoubleLine(self.itemLink..' ('..L["mount"]..')', status)
    tooltip:AddTexture(self.itemIcon, {margin={right=2}})
end

-------------------------------------------------------------------------------
------------------------------------- PET -------------------------------------
-------------------------------------------------------------------------------

-- /run print(C_PetJournal.FindPetIDByName("NAME"))

local Pet = Class('Pet', Item)

function Pet:obtained ()
    return C_PetJournal.GetNumCollectedInfo(self.id) > 0
end

function Pet:render (tooltip)
    local n, m = C_PetJournal.GetNumCollectedInfo(self.id)
    local status = (n > 0) and Green(n..'/'..m) or Red(n..'/'..m)
    tooltip:AddDoubleLine(self.itemLink..' ('..L["pet"]..')', status)
    tooltip:AddTexture(self.itemIcon, {margin={right=2}})
end

-------------------------------------------------------------------------------
------------------------------------ QUEST ------------------------------------
-------------------------------------------------------------------------------

local Quest = Class('Quest', Reward)

function Quest:init ()
    if type(self.id) == 'number' then
        self.id = {self.id}
    end
    C_QuestLog.GetQuestInfo(self.id[1]) -- fetch info from server
end

function Quest:obtained ()
    for i, id in ipairs(self.id) do
        if not IsQuestFlaggedCompleted(id) then return false end
    end
    return true
end

function Quest:render (tooltip)
    local name = C_QuestLog.GetQuestInfo(self.id[1])

    local status = ''
    if #self.id == 1 then
        local completed = IsQuestFlaggedCompleted(self.id[1])
        status = completed and Green(L['completed']) or Red(L['incomplete'])
    else
        local count = 0
        for i, id in ipairs(self.id) do
            if IsQuestFlaggedCompleted(id) then count = count + 1 end
        end
        status = count..'/'..#self.id
        status = (count == #self.id) and Green(status) or Red(status)
    end

    local icon = VisionsOfNZoth.icons.quest_chalice
    tooltip:AddDoubleLine((name or UNKNOWN), status)
    tooltip:AddTexture(icon, {
        width = 12,
        height = 12,
        margin = { right=5 }
    })
end

-------------------------------------------------------------------------------
------------------------------------- TOY -------------------------------------
-------------------------------------------------------------------------------

local Toy = Class('Toy', Item)

function Toy:obtained ()
    return PlayerHasToy(self.item)
end

function Toy:render (tooltip)
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

function Transmog:obtained ()
    -- Check if the player knows the appearance
    if CTC.PlayerHasTransmog(self.item) then return true end

    -- Verify the item drops for any of the players specs
    local specs = GetItemSpecInfo(self.item)
    if type(specs) == 'table' and #specs == 0 then return true end

    -- Verify the player can learn the item's appearance
    local sourceID = select(2, CTC.GetItemInfo(self.item))
    if not select(2, CTC.PlayerCanCollectSource(sourceID)) then return true end

    return false
end

function Transmog:render (tooltip)
    local collected = CTC.PlayerHasTransmog(self.item)
    local status = collected and Green(L["known"]) or Red(L["missing"])

    if not collected then
        -- check if we can't learn this item
        local sourceID = select(2, CTC.GetItemInfo(self.item))
        if not select(2, CTC.PlayerCanCollectSource(sourceID)) then
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
    if self.note and HandyNotes_VisionsOfNZoth.db.profile.show_notes then
        suffix = suffix..' ('..self.note..')'
    end

    tooltip:AddDoubleLine(self.itemLink..suffix, status)
    tooltip:AddTexture(self.itemIcon, {margin={right=2}})
end

-------------------------------------------------------------------------------

VisionsOfNZoth.reward = {
    Reward=Reward,
    Achievement=Achievement,
    Item=Item,
    Mount=Mount,
    Pet=Pet,
    Quest=Quest,
    Toy=Toy,
    Transmog=Transmog
}

-------------------------------------------------------------------------------
-------------------------- POI (Point of Interest) ----------------------------
-------------------------------------------------------------------------------

local POI = Class('POI')

function POI:render (map, template)
    -- draw a circle at every coord
    for i=1, #self, 1 do
        map:AcquirePin(template, self, self[i])
    end
end

function POI:draw (pin, xy)
    local t = pin.texture
    local size = pin.minimap and 10 or (pin.parentHeight * 0.015)
    t:SetTexCoord(0, 1, 0, 1)
    t:SetVertexColor(0, 0.5, 1, 1)
    t:SetTexture("Interface\\AddOns\\HandyNotes\\Icons\\circle")
    pin:SetAlpha(0.75)
    pin:SetSize(size, size)
    return HandyNotes:getXY(xy)
end

-------------------------------------------------------------------------------
------------------------------------ BLOB -------------------------------------
-------------------------------------------------------------------------------

local Blob = Class('Blob')

-------------------------------------------------------------------------------
------------------------------------ PATH -------------------------------------
-------------------------------------------------------------------------------

local Path = Class('Path', POI)

function Path:render (map, template)
    -- draw a circle at every coord and a line between them
    for i=1, #self, 1 do
        map:AcquirePin(template, self, 'circle', self[i])
        if i < #self then
            map:AcquirePin(template, self, 'line', self[i], self[i+1])
        end
    end
end

function Path:draw (pin, type, xy1, xy2)
    local t = pin.texture
    t:SetTexCoord(0, 1, 0, 1)
    t:SetVertexColor(0, 0.5, 1, 1)
    t:SetTexture("Interface\\AddOns\\HandyNotes\\Icons\\"..type)

    pin:SetAlpha(0.75)
    if type == 'circle' then
        pin:SetSize(5, 5)
        return HandyNotes:getXY(xy1)
    else
        local x1, y1 = HandyNotes:getXY(xy1)
        local x2, y2 = HandyNotes:getXY(xy2)
        local x1p = x1 * pin.parentWidth
        local x2p = x2 * pin.parentWidth
        local y1p = y1 * pin.parentHeight
        local y2p = y2 * pin.parentHeight
        pin:SetSize(sqrt((x2p-x1p)^2 + (y2p-y1p)^2), 60)
        t:SetRotation(-math.atan2(y2p-y1p, x2p-x1p))
        return (x1+x2)/2, (y1+y2)/2
    end
end

-------------------------------------------------------------------------------

VisionsOfNZoth.poi = {
    POI=POI,
    Path=Path
}


-------------------------------------------------------------------------------
------------------------------ DATAMINE TOOLTIP -------------------------------
-------------------------------------------------------------------------------

local NameResolver = CreateFrame("GameTooltip", "HandyNotes_VisionsOfNZoth_NameResolver", UIParent, "GameTooltipTemplate")

NameResolver.cache = {}
NameResolver.prepared = {}

NameResolver:SetOwner(UIParent, "ANCHOR_NONE")
NameResolver:HookScript("OnTooltipSetUnit", function(self)
    local callback = self.callback
    if callback then
        local name = _G[self:GetName().."TextLeft1"]:GetText()
        self.cache[self.link] = name
        self.callback = nil
        self.link = nil
        callback(name)
    end
end)

function NameResolver:GetCachedName (link)
    if self:IsLink(link) then
        return self.cache[link] or UNKNOWN
    end
    return link
end

function NameResolver:IsLink (link)
    if link == nil then return link end
    return strsub(link, 1, 5) == 'unit:'
end

function NameResolver:Prepare (link)
    if self:IsLink(link) and not (self.cache[link] or self.prepared[link]) then
        self:SetHyperlink(link)
        self.prepared[link] = true
    end
end

function NameResolver:Resolve (link, callback)
    -- may be passed a raw name or a hyperlink to be resolved
    if self:IsLink(link) then
        local name = self.cache[link]
        if name and name ~= '' then
            callback(name)
        else
            self.link = link
            self.callback = callback
            self:SetHyperlink(link)
        end
    else
        callback(link)
    end
end

-------------------------------------------------------------------------------

VisionsOfNZoth.NameResolver = NameResolver


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local Map = VisionsOfNZoth.Map
local clone = VisionsOfNZoth.clone

local Node = VisionsOfNZoth.node.Node
local Cave = VisionsOfNZoth.node.Cave
local NPC = VisionsOfNZoth.node.NPC
local PetBattle = VisionsOfNZoth.node.PetBattle
local Rare = VisionsOfNZoth.node.Rare
local Supply = VisionsOfNZoth.node.Supply
local TimedEvent = VisionsOfNZoth.node.TimedEvent
local Treasure = VisionsOfNZoth.node.Treasure

local Achievement = VisionsOfNZoth.reward.Achievement
local Item = VisionsOfNZoth.reward.Item
local Mount = VisionsOfNZoth.reward.Mount
local Pet = VisionsOfNZoth.reward.Pet
local Quest = VisionsOfNZoth.reward.Quest
local Toy = VisionsOfNZoth.reward.Toy

local Path = VisionsOfNZoth.poi.Path
local POI = VisionsOfNZoth.poi.POI

local options = VisionsOfNZoth.options.args.VisibilityGroup.args
local defaults = VisionsOfNZoth.optionDefaults.profile

local AQR, EMP, AMA = 0, 1, 2 -- assaults

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = Map({ id=1527, phased=false })
local nodes = map.nodes

local function GetAssault ()
    local textures = C_MapExplorationInfo.GetExploredMapTextures(map.id)
    if textures and textures[1].fileDataIDs[1] == 3165083 then
        return AQR -- left
    elseif textures and textures[1].fileDataIDs[1] == 3165092 then
        return EMP -- middle
    elseif textures and textures[1].fileDataIDs[1] == 3165098 then
        return AMA -- right
    end
end

function map:prepare ()
    Map.prepare(self)
    self.assault = GetAssault()
    self.phased = self.assault ~= nil
end

function map:enabled (node, coord, minimap)
    if not Map.enabled(self, node, coord, minimap) then return false end

    if node == map.intro then return true end

    local assault = node.assault
    if assault then
        assault = type(assault) == 'number' and {assault} or assault
        for i=1, #assault + 1, 1 do
            if i > #assault then return false end
            if assault[i] == self.assault then break end
        end
    end

    local profile = HandyNotes_VisionsOfNZoth.db.profile
    if isinstance(node, Treasure) then return profile.chest_uldum end
    if isinstance(node, Supply) then return profile.coffer_uldum end
    if isinstance(node, Rare) then return profile.rare_uldum end
    if isinstance(node, PetBattle) then return profile.pet_uldum end
    if isinstance(node, TimedEvent) then return profile.event_uldum end
    if node.alpaca then return profile.alpaca_uldum end

    return true
end

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

defaults['chest_uldum'] = true
defaults['coffer_uldum'] = true
defaults['rare_uldum'] = true
defaults['event_uldum'] = true
defaults['pet_uldum'] = true
defaults['alpaca_uldum'] = true

options.groupUldum = {
    type = "header",
    name = L["uldum"],
    order = 0,
}

options.chestUldum = {
    type = "toggle",
    arg = "chest_uldum",
    name = L["options_toggle_chests"],
    desc = L["options_toggle_chests_desc"],
    order = 1,
    width = "normal",
}

options.cofferUldum = {
    type = "toggle",
    arg = "coffer_uldum",
    name = L["options_toggle_coffers"],
    desc = L["options_toggle_coffers_desc"],
    order = 2,
    width = "normal",
}

options.rareUldum = {
    type = "toggle",
    arg = "rare_uldum",
    name = L["options_toggle_rares"],
    desc = L["options_toggle_rares_desc"],
    order = 3,
    width = "normal",
}

options.eventUldum = {
    type = "toggle",
    arg = "event_uldum",
    name = L["options_toggle_assault_events"],
    desc = L["options_toggle_assault_events_desc"],
    order = 4,
    width = "normal",
}

options.petUldum = {
    type = "toggle",
    arg = "pet_uldum",
    name = L["options_toggle_battle_pets"],
    desc = L["options_toggle_battle_pets_desc"],
    order = 5,
    width = "normal",
}

options.alpacaUldum = {
    type = "toggle",
    arg = "alpaca_uldum",
    name = L["options_toggle_alpaca_uldum"],
    desc = L["options_toggle_alpaca_uldum_desc"],
    order = 6,
    width = "normal",
}

-------------------------------------------------------------------------------
------------------------------------ INTRO ------------------------------------
-------------------------------------------------------------------------------

local Intro = Class('Intro', Node)

Intro.note = L["uldum_intro_note"]
Intro.icon = 'quest_yellow'
Intro.scale = 3

function Intro:enabled ()
    if not Node.enabled(self) then return false end
    return map.assault == nil
end

function Intro.getters:label ()
    return select(2, GetAchievementInfo(14153)) -- Uldum Under Assault
end

-- Network Diagnostics => Surfacing Threats
local Q = Quest({id={58506, 56374, 56209, 56375, 56472, 56376}})

if UnitFactionGroup('player') == 'Alliance' then
    map.intro = Intro({faction='Alliance', rewards={
        Quest({id={58496, 58498, 58502}}), Q
    }})
else
    map.intro = Intro({faction='Horde', rewards={
        Quest({id={58582, 58583}}), Q
    }})
end

nodes[46004300] = map.intro

HandyNotes_VisionsOfNZoth:RegisterEvent('QUEST_WATCH_UPDATE', function (_, index)
    local _, _, _, _, _, _, _, questID = GetQuestLogTitle(index)
    if questID == 56376 then
        C_Timer.After(1, function()
            HandyNotes_VisionsOfNZoth:Refresh()
        end)
    end
end)

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

nodes[64572623] = Rare({id=157170, quest=57281, assault=AMA, note=L["chamber_of_the_stars"]}) -- Acolyte Taspu
nodes[66817436] = Rare({id=158557, quest=57669, assault=EMP}) -- Actiss the Deceiver
nodes[73805180] = Rare({id=151883, quest=55468, assault=AMA}) -- Anaua
nodes[32426443] = Rare({id=155703, quest=56834}) -- Anq'uri the Titanic
nodes[38732500] = Rare({id=154578, quest=58612, assault=AQR, note=L["aqir_flayer"], pois={
    POI({ -- Aqir Hive Worker
        41202497, 40472249, 39882209, 38942459, 37102236, 36502179, 37782046,
        36761891, 37591749, 36041891, 35691808, 33551946, 32251624, 35031801,
        35292068, 33461670, 35102299, 37981821, 40952468
    }),
    POI({ -- Aqir Reaper
        41863885, 41264078, 41494146, 41104233, 40464372, 40624452, 40834550,
        39984480, 39814467, 39254356, 37994321, 37584213, 39764251, 39333892,
        29816310, 32056727, 32426645, 33646358, 37094853
    })
}}) -- Aqir Flayer
nodes[30595944] = Rare({id=154576, quest=58614, assault=AQR, note=L["aqir_titanus"], pois={
    POI({30266161, 30076533, 31496674, 33356610, 32486946, 34856598}),
    Path({37295892, 36485588, 37285284}),
    Path({38134884, 36535023, 34765141, 32935159}),
    Path({33325836, 33865418}),
    Path({26795106, 27055372, 27025596}),
    Path({28526114, 28975921, 28805676, 28945481}),
    Path({43194180, 42864292, 41284445, 40884731}),
    Path({40864255, 41714037}),
    Path({38314290, 40354482}),
    Path({32994510, 35434436, 36284239}),
    Path({41243247, 40503334, 39233745})
}}) -- Aqir Titanus
nodes[38214521] = Rare({id=162172, quest=58694, assault=AQR, note=L["aqir_warcaster"], pois={
    POI({
        29666397, 30346691, 30396549, 30946805, 31296612, 31316747, 31546811,
        31586663, 31906347, 32256093, 32796516, 32856283, 33046590, 33246733,
        33656812, 33666517, 33976361, 34446875, 34466522, 36844697, 38284543,
        39303882, 39314582, 39754049, 39873790, 39944596, 40033882, 40144315,
        40214146, 40233654, 40264433, 40544320, 40883978, 40894302, 40924132,
        41463988, 41993776, 42913735
    }) -- Aqir Voidcaster
}}) -- Aqir Warcaster
nodes[44854235] = Rare({id=162370, quest=58718, assault={AQR,AMA}}) -- Armagedillo
nodes[65035129] = Rare({id=152757, quest=55710, assault=AMA, note=L["atekhramun"]}) -- Atekhramun
nodes[45605777] = Rare({id=162171, quest=58699, assault=AQR, note=L["chamber_of_the_sun"]..' '..L["dunewalker"]}) -- Captain Dunewalker
nodes[75425216] = Rare({id=157167, quest=57280, assault={AQR,AMA}}) -- Champion Sen-mat
nodes[30854971] = Rare({id=162147, quest=58696, assault=AQR, rewards={
    Mount({id=1319, item=174769}) -- Malevolent Drone
}}) -- Corpse Eater
nodes[49363822] = Rare({id=158594, quest=57672, assault=EMP}) -- Doomsayer Vathiris
nodes[48657067] = Rare({id=158491, quest=57662, assault=EMP, pois={
    Path({53287082, 54066945, 53446815, 49866959, 48097382, 46537211, 46257561, 44217851})
}}) -- Falconer Amenophis
nodes[75056816] = Rare({id=157120, quest=57258, assault={AQR, AMA}}) -- Fangtaker Orsa
nodes[55475169] = Rare({id=158633, quest=57680, assault=EMP, pois={
    POI({
        53845079, 54215140, 54255185, 54575190, 54605233, 54635076, 54704963,
        54925253, 55065317, 55214990, 55335305, 55445072, 55475169, 55495031,
        55705404, 55835437, 55915107, 55935310, 56425386, 56485353
    })
}, rewards={
    Item({item=175142}), -- All-Seeing Right Eye
    Toy({item=175140}) -- All-Seeing Eye
}, note=L["gaze_of_nzoth"]..' '..L["right_eye"]}) -- Gaze of N'Zoth
nodes[54694317] = Rare({id=158597, quest=57675, assault=EMP}) -- High Executor Yothrim
nodes[47507718] = Rare({id=158528, quest=57664, assault=EMP}) -- High Guard Reshef
nodes[42485873] = Rare({id=162163, quest=58701, assault=AQR, pois={
    Path({42485873, 44396076, 46215988, 46785800, 46465623, 44545616, 43055653, 42485873})
}}) -- High Priest Ytaessis
nodes[80504715] = Rare({id=151995, quest=55502, assault=AMA, pois={
    Path({80504715, 79804519, 77204597})
}}) -- Hik-Ten the Taskmaster
nodes[60033950] = Rare({id=160623, quest=58206, assault=EMP, note=L["hmiasma"]}) -- Hungering Miasma
nodes[19755847] = Rare({id=155531, quest=56823, assault=AQR, note=L["wastewander"], pois={
    POI({
        17896249, 18026020, 18406490, 18966279, 19176080, 19626403, 19696174,
        19976498, 20036084, 20336267, 20686052, 20796452, 21365790, 22056027,
        22086169, 22135658, 22156465, 22656370, 22905737, 22976012, 23205863,
        23246283, 23706188, 24146211, 24316070, 24366309, 24495822, 24616524,
        24806225, 25306412
    }) -- Wastewander Host
}}) -- Infested Wastewander Captain
nodes[73908353] = Rare({id=157134, quest=57259, rewards={
    Mount({id=1314, item=174641}) -- Drake of the Four Winds
}}) -- Ishak of the Four Winds
nodes[77005000] = Rare({id=152431, quest=55629, assault=AMA, note=L["kanebti"]}) -- Kaneb-ti
nodes[71237375] = Rare({id=156655, quest=57433, assault=EMP}) -- Korzaran the Slaughterer
nodes[34681890] = Rare({id=154604, quest=56340, assault=AQR, note=L["chamber_of_the_moon"], rewards={
    Pet({id=2847, item=174475}) -- Rotbreath
}}) -- Lord Aj'qirai
nodes[30476602] = Rare({id=156078, quest=56952, assault=AQR, pois={
    POI({30476602, 32876907, 33696573})
}}) -- Magus Rehleth
nodes[66842035] = Rare({id=157157, quest=57277, assault=AMA}) -- Muminah the Incandescent
nodes[62012454] = Rare({id=152677, quest=55684, assault=AMA}) -- Nebet the Ascended
nodes[35071729] = Rare({id=162196, quest=58681}) -- Obsidian Annihilator
nodes[37505978] = Rare({id=162142, quest=58693, assault=AQR}) -- Qho
nodes[58175712] = Rare({id=156299, quest=57430, assault={AQR, EMP}, pois={
    Path({51055121, 52684913, 54554907, 56165227, 56795451, 58095721, 58536856})
}}) -- R'khuzj the Unfathomable
nodes[28651339] = Rare({id=162173, quest=58864, assault=AQR, pois={
    Path({
        38031012, 36071044, 34261112, 31611053, 29200919, 27930731, 26460550,
        24980615, 24810886, 26881180, 28651339, 28381641, 29341853, 29392137,
        29472409, 29822663, 30342939, 30333188, 30103380
    })
}}) -- R'krox the Runt
nodes[68593204] = Rare({id=157146, quest=57273, assault=AMA, rewards={
    Mount({id=1317, item=174753}) -- Waste Marauder
}}) -- Rotfeaster
nodes[69714215] = Rare({id=152040, quest=55518, assault=AMA}) -- Scoutmaster Moswen
nodes[73536459] = Rare({id=151948, quest=55496, assault=AMA}) -- Senbu the Pridefather
nodes[57003794] = Rare({id=161033, quest=58333, assault=EMP, pois={
    POI({57003794, 52174326})
}})-- Shadowmaw
nodes[58558282] = Rare({id=156654, quest=57432, assault=EMP}) -- Shol'thoss the Doomspeaker
nodes[61297484] = Rare({id=160532, quest=58169, assault={AQR, EMP}}) -- Shoth the Darkened
nodes[21236105] = Rare({id=162140, quest=58697, assault=AQR, rewards={
    Pet({id=2848, item=174476}) -- Aqir Tunneler
}, pois={
    Path({22486168, 21316279, 19896347, 19356128, 20345804, 21435846, 24325860, 24866015, 24406194, 22486168})
}}) -- Skikx'traz
nodes[66676804] = Rare({id=162372, quest=58715, assault={AQR, AMA}, pois={
    POI({58606160, 58038282, 66676804, 70997407})
}}) -- Spirit of Cyrus the Black
nodes[49944011] = Rare({id=162352, quest=58716, assault={AQR, AMA}, note=L["in_water_cave"]}) -- Spirit of Dark Ritualist Zakahn
nodes[52154012] = Cave({parent=nodes[49944011], assault={AQR, AMA}, label=L["spirit_cave"]}) -- Entrance
nodes[78986389] = Rare({id=151878, quest=58613, assault=AMA}) -- Sun King Nahkotep
nodes[84785704] = Rare({id=151897, quest=55479, assault=AMA}) -- Sun Priestess Nubitt
nodes[73347447] = Rare({id=151609, quest=55353, assault=AMA}) -- Sun Prophet Epaphos
nodes[65903522] = Rare({id=152657, quest=55682, assault=AMA, pois={
    Path({68043800, 64873862, 64503660, 65903522, 67003162, 67743515, 68043800})
}}) -- Tat the Bonechewer
nodes[49328235] = Rare({id=158636, quest=57688, assault=EMP, note=L["platform"], rewards={
    Toy({item=169303}) -- Hell-Bent Bracers
}}) -- The Grand Executor
nodes[84324729] = Rare({id=157188, quest=57285, assault=AMA, note=L["tomb_widow"]}) -- The Tomb Widow
nodes[60014937] = Rare({id=158595, quest=57673, assault=EMP}) -- Thoughtstealer Vos
nodes[67486382] = Rare({id=152788, quest=55716, assault=AMA, note=L["uatka"], rewards={
    Item({item=174875}) -- Obelisk of the Sun
}}) -- Uat-ka the Sun's Wrath
nodes[33592569] = Rare({id=162170, quest=58702, assault=AQR}) -- Warcaster Xeshro
nodes[79505217] = Rare({id=151852, quest=55461, assault=AMA, pois={
    Path({77755217, 81265217})
}}) -- Watcher Rehu
nodes[80165708] = Rare({id=157164, quest=57279, assault=AMA}) -- Zealot Tekem
nodes[39694159] = Rare({id=162141, quest=58695, assault=AQR}) -- Zuythiz

-------------------------------------------------------------------------------
------------------------------- NEFERSET RARES --------------------------------
-------------------------------------------------------------------------------

local start = 45009400;
local function coord(x, y)
    return start + x*2500000 + y*400;
end

local NefRare = Class('NefersetRare', Rare, {
    assault=EMP, note=L["neferset_rare"],
    pois={POI({50007868, 50568833, 55207930})}
})

function NefRare:enabled (map, coord, minimap)
    if not Rare.enabled(self, map, coord, minimap) then return false end
    -- Only show if a Summoning Ritual event is active or completed
    for i, quest in ipairs({57359, 57620, 57621}) do
        if C_TaskQuest.GetQuestTimeLeftMinutes(quest) or IsQuestFlaggedCompleted(quest) then
            return true
        end
    end
    return false
end

nodes[coord(0, 0)] = NefRare({id=157472, quest=57437}) -- Aphrom the Guise of Madness
nodes[coord(1, 0)] = NefRare({id=157470, quest=57436}) -- R'aas the Anima Devourer
nodes[coord(2, 0)] = NefRare({id=157390, quest=57434}) -- R'oyolok the Reality Eater
nodes[coord(3, 0)] = NefRare({id=157476, quest=57439}) -- Shugshul the Flesh Gorger
nodes[coord(4, 0)] = NefRare({id=157473, quest=57438, rewards={
    Toy({item=174874}) -- Budget K'thir Disguise
}}) -- Yiphrim the Will Ravager
nodes[coord(5, 0)] = NefRare({id=157469, quest=57435}) -- Zoth'rum the Intellect Pillager

-------------------------------------------------------------------------------
---------------------------------- TREASURES ----------------------------------
-------------------------------------------------------------------------------

local AQRChest = Class('AQRChest', Treasure, {
    assault=AQR, label=L["infested_cache"]
})

local AQRTR1 = AQRChest({quest=58138, icon='chest_blue'})
local AQRTR2 = AQRChest({quest=58139, icon='chest_purple'})
local AQRTR3 = AQRChest({quest=58140, icon='chest_orange'})
local AQRTR4 = AQRChest({quest=58141, icon='chest_yellow'})
local AQRTR5 = AQRChest({quest=58142, icon='chest_teal'})

-- quest=58138
nodes[43925868] = clone(AQRTR1, {note=L["chamber_of_the_sun"]})
nodes[44855696] = AQRTR1
nodes[45845698] = clone(AQRTR1, {note=L["chamber_of_the_sun"]})
nodes[46176156] = AQRTR1
nodes[46525801] = AQRTR1
nodes[50555882] = AQRTR1
nodes[51736032] = AQRTR1
-- quest=58139
nodes[27476410] = AQRTR2
nodes[30526540] = AQRTR2
nodes[31166796] = AQRTR2
nodes[32764770] = AQRTR2
nodes[32976010] = AQRTR2
nodes[33366210] = AQRTR2
nodes[33476998] = AQRTR2
-- quest=58140
nodes[18356130] = AQRTR3
nodes[19836512] = AQRTR3
nodes[20585920] = AQRTR3
nodes[21706436] = AQRTR3
nodes[23406539] = AQRTR3
nodes[23055936] = AQRTR3
nodes[24525507] = AQRTR3
nodes[24606387] = AQRTR3
nodes[26066468] = AQRTR3
-- quest=58141
nodes[36032024] = AQRTR4
nodes[37484577] = AQRTR4
nodes[38774014] = AQRTR4
nodes[39692354] = AQRTR4
nodes[39754504] = AQRTR4
nodes[40244251] = AQRTR4
nodes[40454422] = AQRTR4
nodes[40823893] = AQRTR4
nodes[41604250] = AQRTR4
-- quest=58142
nodes[28030834] = AQRTR5
nodes[30671611] = AQRTR5
nodes[30903046] = AQRTR5
nodes[31303070] = AQRTR5
nodes[31521515] = AQRTR5
nodes[33571901] = AQRTR5
nodes[33953036] = AQRTR5
nodes[35101878] = AQRTR5
nodes[35413157] = AQRTR5
nodes[36871616] = AQRTR5
nodes[41592264] = clone(AQRTR5, {note=L["chamber_of_the_moon"]})
nodes[45561320] = AQRTR5

nodes[36252324] = Supply({quest=58137, assault=AQR,
    label=L["infested_strongbox"], note=L["chamber_of_the_moon"]})

-------------------------------------------------------------------------------

local EMPChest = Class('EMPChest', Treasure, {
    assault=EMP, label=L["black_empire_cache"]
})

local EMPTR1 = EMPChest({quest=57623, icon='chest_blue', note=L["single_chest"]})
local EMPTR2 = EMPChest({quest=57624, icon='chest_purple', note=L["single_chest"]})
local EMPTR3 = EMPChest({quest=57625, icon='chest_lime', note=L["in_water"]..' '..L["single_chest"]})
local EMPTR4 = EMPChest({quest=57626, icon='chest_orange'})
local EMPTR5 = EMPChest({quest=57627, icon='chest_yellow'})
local EMPTR6 = EMPChest({quest=57635, icon='chest_teal'})

-- quest=57623
nodes[58361535] = EMPTR1
-- quest=57624
nodes[50793143] = EMPTR2
-- quest=57625
nodes[52705006] = EMPTR3
-- quest=57626
nodes[57808250] = EMPTR4
nodes[57817487] = EMPTR4
nodes[58247282] = EMPTR4
nodes[59226749] = EMPTR4
nodes[59416224] = EMPTR4
nodes[60576213] = EMPTR4
nodes[61778172] = EMPTR4
nodes[62588188] = EMPTR4
nodes[62977610] = EMPTR4
nodes[62996440] = EMPTR4
nodes[64436501] = EMPTR4
nodes[66756810] = EMPTR4
nodes[67547066] = EMPTR4
nodes[70217325] = EMPTR4
-- quest=57627
nodes[59816610] = EMPTR5
nodes[59867422] = EMPTR5
nodes[60246529] = EMPTR5
nodes[60757493] = EMPTR5
nodes[60967000] = EMPTR5
nodes[61206544] = EMPTR5
nodes[61817595] = EMPTR5
nodes[62157346] = EMPTR5
nodes[62737184] = EMPTR5
nodes[62807565] = EMPTR5
nodes[63867065] = EMPTR5
nodes[64607503] = EMPTR5
nodes[65357117] = EMPTR5
nodes[67167394] = EMPTR5
-- quest=57635
nodes[45697961] = EMPTR6
nodes[47507687] = EMPTR6
nodes[49037684] = EMPTR6
nodes[49398584] = EMPTR6
nodes[49807210] = EMPTR6
nodes[50207510] = EMPTR6
nodes[51157388] = EMPTR6
nodes[51207970] = EMPTR6
nodes[51707135] = EMPTR6
nodes[51777298] = EMPTR6
nodes[51897858] = EMPTR6
nodes[52197757] = EMPTR6
nodes[55397860] = EMPTR6
nodes[55658346] = EMPTR6

local EMPCOFF = Supply({quest=57628, assault=EMP, note=L["cursed_relic"],
    label=L["black_empire_coffer"]})

nodes[71657334] = EMPCOFF

-------------------------------------------------------------------------------

local AMAChest = Class('AMAChest', Treasure, {
    assault=AMA, label=L["amathet_cache"]
})

local AMATR1 = AMAChest({quest=55689, icon='chest_blue'})
local AMATR2 = AMAChest({quest=55690, icon='chest_purple'})
local AMATR3 = AMAChest({quest=55691, icon='chest_orange'})
local AMATR4 = AMAChest({quest=55698, icon='chest_yellow'})
local AMATR5 = AMAChest({quest=55699, icon='chest_teal'})
local AMATR6 = AMAChest({quest=55700, icon='chest_lime'})

-- quest=55689
nodes[78265073] = AMATR1
nodes[80575110] = AMATR1
nodes[80785611] = AMATR1
nodes[81585359] = AMATR1
nodes[84534540] = AMATR1
nodes[84836185] = AMATR1
nodes[84995395] = AMATR1
nodes[85005097] = AMATR1
nodes[85275138] = AMATR1
nodes[85285297] = AMATR1
-- quest=55690
nodes[70325819] = AMATR2
nodes[71226851] = AMATR2
nodes[71305922] = AMATR2
nodes[72216422] = AMATR2
nodes[73117297] = AMATR2
nodes[73707393] = AMATR2
nodes[73987095] = AMATR2
nodes[74206460] = AMATR2
nodes[78286207] = AMATR2
nodes[79166486] = AMATR2
-- quest=55691
nodes[71504750] = AMATR3
nodes[72474857] = AMATR3
nodes[73035386] = AMATR3
nodes[73045143] = AMATR3
nodes[74195187] = AMATR3
nodes[75335579] = AMATR3
nodes[75575372] = AMATR3
nodes[76364879] = AMATR3
nodes[78125302] = AMATR3
-- quest=55698
nodes[71884388] = AMATR4
nodes[72764468] = AMATR4
nodes[72944350] = AMATR4
nodes[73714646] = AMATR4
nodes[74364390] = AMATR4
nodes[75134608] = AMATR4
nodes[76344679] = AMATR4
nodes[77274934] = AMATR4
nodes[77544828] = AMATR4
nodes[79314578] = AMATR4
-- quest=55699 (no blizzard minimap icon for this one?)
nodes[63084970] = AMATR5
nodes[64094488] = AMATR5
nodes[65403796] = AMATR5
nodes[66394350] = AMATR5
nodes[66624829] = AMATR5
nodes[67004050] = AMATR5
nodes[67884158] = AMATR5
nodes[69744236] = AMATR5
nodes[69874163] = AMATR5
-- quest=55700
nodes[60932455] = AMATR6
nodes[61343060] = AMATR6
nodes[62722355] = AMATR6
nodes[63122508] = clone(AMATR6, {note=L["chamber_of_the_stars"]})
nodes[63532160] = AMATR6
nodes[65543142] = AMATR6
nodes[65882147] = clone(AMATR6, {note=L["chamber_of_the_stars"]})
nodes[67172800] = clone(AMATR6, {note=L["chamber_of_the_stars"]})
nodes[68222051] = AMATR6
nodes[68933234] = AMATR6

local AMACOFF = Supply({quest=55692, assault=AMA,
    label=L["amathet_reliquary"], sublabel=L["tolvir_relic"]})

nodes[64463415] = clone(AMACOFF, {note=L["chamber_of_the_stars"]})
nodes[66882414] = AMACOFF
nodes[67464294] = AMACOFF
nodes[73337356] = AMACOFF
nodes[73685054] = AMACOFF
nodes[75914194] = AMACOFF
nodes[83116028] = AMACOFF

-------------------------------------------------------------------------------
-------------------------------- ASSAULT EVENTS -------------------------------
-------------------------------------------------------------------------------

nodes[34392928] = TimedEvent({quest=58679, assault=AQR, note=L["dormant_destroyer"]}) -- Dormant Destroyer
nodes[20765913] = TimedEvent({quest=58676, assault=AQR, note=L["dormant_destroyer"]}) -- Dormant Destroyer
nodes[31365562] = TimedEvent({quest=58667, assault=AQR, note=L["obsidian_extract"]}) -- Obsidian Extraction
nodes[36542060] = TimedEvent({quest=59003, assault=AQR, note=L["chamber_of_the_moon"]..' '..L["combust_cocoon"]}) -- Combustible Cocoons
nodes[37054778] = TimedEvent({quest=58961, assault=AQR, note=L["ambush_settlers"]}) -- Ambushed Settlers
nodes[27765714] = TimedEvent({quest=58974, assault=AQR, note=L["ambush_settlers"]}) -- Ambushed Settlers
nodes[22496418] = TimedEvent({quest=58952, assault=AQR, note=L["purging_flames"]}) -- Purging Flames
nodes[28336559] = TimedEvent({quest=58990, assault=AQR, note=L["titanus_egg"]}) -- Titanus Egg
nodes[46845804] = TimedEvent({quest=58981, assault=AQR, note=L["chamber_of_the_sun"]..' '..L["hardened_hive"]}) -- Hardened Hive
nodes[37136702] = TimedEvent({quest=58662, assault=AQR, note=L["burrowing_terrors"]}) -- Burrowing Terrors
nodes[45134306] = TimedEvent({quest=58661, assault=AQR, note=L["burrowing_terrors"]}) -- Burrowing Terrors
nodes[31614380] = TimedEvent({quest=58660, assault=AQR, note=L["burrowing_terrors"]}) -- Burrowing Terrors

-------------------------------------------------------------------------------

local MAWREWARD = {Achievement({id=14161, criteria=1})}

nodes[46793424] = TimedEvent({quest=58256, assault=EMP, note=L["consuming_maw"], rewards=MAWREWARD}) -- Consuming Maw
nodes[55382132] = TimedEvent({quest=58257, assault=EMP, note=L["consuming_maw"], rewards=MAWREWARD}) -- Consuming Maw
nodes[60154555] = TimedEvent({quest=58216, assault=EMP, note=L["consuming_maw"], rewards=MAWREWARD}) -- Consuming Maw
nodes[62407931] = TimedEvent({quest=58258, assault=EMP, note=L["consuming_maw"], rewards=MAWREWARD}) -- Consuming Maw

nodes[48518489] = TimedEvent({quest=57522, assault=EMP, note=L["call_of_void"]}) -- Call of the Void
nodes[53677575] = TimedEvent({quest=57585, assault=EMP, note=L["call_of_void"]}) -- Call of the Void
nodes[65907284] = TimedEvent({quest=57541, assault=EMP, note=L["call_of_void"]}) -- Call of the Void
nodes[52015072] = TimedEvent({quest=57543, assault=EMP, note=L["executor_nzoth"]}) -- Executor of N'Zoth
nodes[57044951] = TimedEvent({quest=57592, assault=EMP, note=L["executor_nzoth"]}) -- Executor of N'Zoth
nodes[59014663] = TimedEvent({quest=57580, assault=EMP, note=L["executor_nzoth"]}) -- Executor of N'Zoth
nodes[60203789] = TimedEvent({quest=57449, assault=EMP, note=L["executor_nzoth"]}) -- Executor of N'Zoth
nodes[66476806] = TimedEvent({quest=57582, assault=EMP, note=L["executor_nzoth"]}) -- Executor of N'Zoth
nodes[49443920] = TimedEvent({quest=58276, assault=EMP, note=L["in_flames"]}) -- Mar'at In Flames
nodes[50578232] = TimedEvent({quest=58275, assault=EMP, note=L["monstrous_summon"]}) -- Monstrous Summoning
nodes[59767241] = TimedEvent({quest=57429, assault=EMP, note=L["pyre_amalgamated"], rewards={
    Pet({id=2851, item=174478}) -- Wicked Lurker
}}) -- Pyre of the Amalgamated One (also 58330?)
nodes[49997867] = TimedEvent({quest=57620, assault=EMP, note=L["summoning_ritual"]}) -- Summoning Ritual
nodes[50568833] = TimedEvent({quest=57359, assault=EMP, note=L["summoning_ritual"]}) -- Summoning Ritual
nodes[55227932] = TimedEvent({quest=57621, assault=EMP, note=L["summoning_ritual"]}) -- Summoning Ritual
nodes[62037070] = TimedEvent({quest=58271, assault=EMP, note=L["voidflame_ritual"]}) -- Voidflame Ritual

nodes[46243068] = TimedEvent({quest=57586, assault=EMP, pois={
    Path({44272884, 44772860, 45202953, 46012982, 46243068, 47193047, 47773145, 47803309, 47203350})
}}) -- Spirit Drinker
nodes[47174044] = TimedEvent({quest=57456, assault=EMP, pois={
    Path({47944278, 47084245, 47254116, 47053964, 46583882, 46943783})
}}) -- Spirit Drinker
nodes[52733202] = TimedEvent({quest=57587, assault=EMP, pois={
    Path({53993205, 52733202, 51713098, 50903050, 50412889, 49212843, 48162695, 47002657})
}}) -- Spirit Drinker
nodes[58347785] = TimedEvent({quest=57590, assault=EMP, pois={
    Path({58908017, 58347785, 58907588, 58187367, 58687192, 58896905, 58886621})
}}) -- Spirit Drinker
nodes[59022780] = TimedEvent({quest=57588, assault=EMP, pois={
    Path({58102290, 58422547, 59022780, 59602914, 60063133, 60753296, 60453467})
}}) -- Spirit Drinker
nodes[60005506] = TimedEvent({quest=57591, assault=EMP, pois={
    Path({60315245, 59785364, 60005506, 60385696, 60495866})
}}) -- Spirit Drinker
nodes[64066598] = TimedEvent({quest=57589, assault=EMP, pois={
    Path({63356496, 64066598, 65306702, 65436896, 66697001, 67986971, 68547031, 68677190, 69447238, 69867349})
}}) -- Spirit Drinker

-------------------------------------------------------------------------------

nodes[84205548] = TimedEvent({quest=55670, assault=AMA, note=L["raiding_fleet"]}) -- Amathet Raiding Fleet
nodes[76094793] = TimedEvent({quest=57243, assault=AMA, note=L["slave_camp"]}) -- Amathet Slave Camp
nodes[62062069] = TimedEvent({quest=55356, assault=AMA, note=L["beacon_of_sun_king"]}) -- Beacon of the Sun King
nodes[71594586] = TimedEvent({quest=55358, assault=AMA, note=L["beacon_of_sun_king"]}) -- Beacon of the Sun King
nodes[83496186] = TimedEvent({quest=55357, assault=AMA, note=L["beacon_of_sun_king"]}) -- Beacon of the Sun King
nodes[64502932] = TimedEvent({quest=57215, assault=AMA, note=L["engine_of_ascen"]}) -- Engine of Ascension
nodes[64442267] = TimedEvent({quest=55355, assault=AMA, note=L["lightblade_training"]}) -- Lightblade Training Grounds
nodes[64483034] = TimedEvent({quest=55359, assault=AMA, note=L["chamber_of_the_stars"]..' '..L["ritual_ascension"]}) -- Ritual of Ascension
nodes[66515030] = TimedEvent({quest=57235, assault=AMA, note=L["solar_collector"]}) -- Solar Collector
nodes[80256607] = TimedEvent({quest=57234, assault=AMA, note=L["solar_collector"]}) -- Solar Collector
nodes[69905991] = TimedEvent({quest=55360, assault=AMA, note=L["unsealed_tomb"]}) -- The Unsealed Tomb
nodes[61414704] = TimedEvent({quest=55354, assault=AMA, note=L["virnall_front"]}) -- The Vir'nall Front
nodes[65513779] = TimedEvent({quest=57219, assault=AMA, note=L["unearthed_keeper"]}) -- Unearthed Keeper
nodes[71366849] = TimedEvent({quest=57217, assault=AMA, note=L["unearthed_keeper"]}) -- Unearthed Keeper
nodes[78225754] = TimedEvent({quest=57223, assault=AMA, note=L["unearthed_keeper"]}) -- Unearthed Keeper
nodes[82534796] = TimedEvent({quest=57218, assault=AMA, note=L["unearthed_keeper"]}) -- Unearthed Keeper

-------------------------------------------------------------------------------
--------------------------------- BATTLE PETS ---------------------------------
-------------------------------------------------------------------------------

nodes[35453159] = PetBattle({id=162465}) -- Aqir Sandcrawler
nodes[57604356] = PetBattle({id=162466}) -- Blotto
nodes[62043188] = PetBattle({id=162458}) -- Retinus the Seeker
nodes[61745440] = PetBattle({id=162461}) -- Whispers

-------------------------------------------------------------------------------
------------------------------- SPRINGFUR ALPACA ------------------------------
-------------------------------------------------------------------------------

local function GetAlpacaStatus ()
    local count = select(4, GetQuestObjectiveInfo(58881, 0, false))
    if count ~= nil then return VisionsOfNZoth.status.Gray(tostring(count)..'/7') end
end

local Alpaca = Class('Alpaca', NPC, {
    id=162765, icon=2916287, quest=58879, alpaca=true,
    note=L["friendly_alpaca"],
    pois={POI({
        15006200, 24000900, 27004800, 30002900, 39000800, 41007000, 47004800,
        52001900, 55006900, 62705340, 63011446, 70003900, 76636813
    })},
    rewards={Mount({id=1329, item=174859})} -- Springfur Alpaca
})

local Gersahl = Class('Gersahl', Node, {
    icon=134190, alpaca=true, label=L["gersahl"], note=L["gersahl_note"],
    pois={POI({
        43802760, 46922961, 49453556, 50504167, 50583294, 53133577, 55484468,
        56114967, 56202550, 56265101, 56691882, 56901740, 57112548, 57235056,
        57281602, 57458491, 57474682, 57741910, 58005169, 58131768, 58202808,
        58967759, 59027433, 59098568, 59266302, 59557986, 59567664, 59628482,
        59805460, 60018165, 60447755, 60627655, 61371430, 64717249, 65167045,
        65427433, 66047881, 66137572, 66217063, 66257753, 66557212, 67377771,
        68097535, 68117202, 68517407, 68947308, 69237501, 71087875, 71657803
    })},
    rewards={Item({item=174858})} -- Gersahl Greens
})

Alpaca.getters.rlabel = GetAlpacaStatus
Gersahl.getters.rlabel = GetAlpacaStatus

nodes[47004800] = Alpaca()
nodes[58005169] = Gersahl()

-------------------------------------------------------------------------------

VisionsOfNZoth.maps[map.id] = map


local MAN, MOG, EMP = 0, 1, 2 -- assaults

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = Map({ id=1530, phased=false })
local nodes = map.nodes

local function GetAssault()
    local textures = C_MapExplorationInfo.GetExploredMapTextures(map.id)
    if textures and textures[1].fileDataIDs[1] == 3155826 then
        return MAN -- left
    elseif textures and textures[1].fileDataIDs[1] == 3155832 then
        return MOG -- middle
    elseif textures and textures[1].fileDataIDs[1] == 3155841 then
        return EMP -- right
    end
end

function map:prepare ()
    Map.prepare(self)
    self.assault = GetAssault()
    self.phased = self.assault ~= nil
end

function map:enabled (node, coord, minimap)
    if not Map.enabled(self, node, coord, minimap) then return false end

    if node == map.intro then return true end

    local assault = node.assault
    if assault then
        assault = type(assault) == 'number' and {assault} or assault
        for i=1, #assault + 1, 1 do
            if i > #assault then return false end
            if assault[i] == self.assault then break end
        end
    end

    local profile = HandyNotes_VisionsOfNZoth.db.profile
    if isinstance(node, Treasure) then return profile.chest_vale end
    if isinstance(node, Supply) then return profile.coffer_vale end
    if isinstance(node, Rare) then return profile.rare_vale end
    if isinstance(node, PetBattle) then return profile.pet_vale end
    if isinstance(node, TimedEvent) then return profile.event_vale end

    return true
end

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

defaults['chest_vale'] = true
defaults['coffer_vale'] = true
defaults['rare_vale'] = true
defaults['event_vale'] = true
defaults['pet_vale'] = true

options.groupVale = {
    type = "header",
    name = L["vale"],
    order = 10,
}

options.chestVale = {
    type = "toggle",
    arg = "chest_vale",
    name = L["options_toggle_chests"],
    desc = L["options_toggle_chests_desc"],
    order = 11,
    width = "normal",
}

options.cofferVale = {
    type = "toggle",
    arg = "coffer_vale",
    name = L["options_toggle_coffers"],
    desc = L["options_toggle_coffers_desc"],
    order = 12,
    width = "normal",
}

options.rareVale = {
    type = "toggle",
    arg = "rare_vale",
    name = L["options_toggle_rares"],
    desc = L["options_toggle_rares_desc"],
    order = 13,
    width = "normal",
}

options.eventVale = {
    type = "toggle",
    arg = "event_vale",
    name = L["options_toggle_assault_events"],
    desc = L["options_toggle_assault_events_desc"],
    order = 14,
    width = "normal",
}

options.petVale = {
    type = "toggle",
    arg = "pet_vale",
    name = L["options_toggle_battle_pets"],
    desc = L["options_toggle_battle_pets_desc"],
    order = 15,
    width = "normal",
}

-------------------------------------------------------------------------------
------------------------------------ INTRO ------------------------------------
-------------------------------------------------------------------------------

local Intro = Class('Intro', Node)

Intro.note = L["vale_intro_note"]
Intro.icon = 'quest_yellow'
Intro.scale = 3

function Intro:enabled ()
    if not Node.enabled(self) then return false end
    return map.assault == nil
end

function Intro.getters:label ()
    return select(2, GetAchievementInfo(14154)) -- Defend the Vale
end

-- Network Diagnostics => Surfacing Threats
local Q1 = Quest({id={58506, 56374, 56209, 56375, 56472, 56376}})
-- Forging Onward => Magni's Findings
local Q2 = Quest({id={56377, 56536, 56537, 56538, 56539, 56771, 56540}})

if UnitFactionGroup('player') == 'Alliance' then
    map.intro = Intro({faction='Alliance', rewards={
        Quest({id={58496, 58498, 58502}}), Q1, Q2
    }})
else
    map.intro = Intro({faction='Horde', rewards={
        Quest({id={58582, 58583}}), Q1, Q2
    }})
end

nodes[26005200] = map.intro

HandyNotes_VisionsOfNZoth:RegisterEvent('QUEST_ACCEPTED', function (_, _, id)
    if id == 56540 then
        C_Timer.After(1, function()
            HandyNotes_VisionsOfNZoth:Refresh()
        end)
    end
end)

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

nodes[20007460] = Rare({id=160825, quest=58300, assault=MAN}) -- Amber-Shaper Esh'ri
nodes[34156805] = Rare({id=157466, quest=57363, assault=MOG, rewards={
    Mount({id=1328, item=174840}) -- Xinlao
}}) -- Anh-De the Loyal
nodes[57084098] = Rare({id=154447, quest=56237, assault=EMP}) -- Brother Meller
nodes[06487204] = Rare({id=160878, quest=58307, assault=MAN}) -- Buh'gzaki the Blasphemous
nodes[06406433] = Rare({id=160893, quest=58308, assault=MAN, pois={
    Path({06476733, 06416420, 04016423, 04025675, 03985061, 06484877, 06484597})
}}) -- Captain Vor'lek
nodes[81226450] = Rare({id=154467, quest=56255, assault=EMP}) -- Chief Mek-mek
nodes[18806841] = Rare({id=157183, quest=58296, assault=MOG, pois={
    POI({16806672, 18316516, 19026494, 20166403, 20816263, 20866845, 21016961, 19927330, 18607211})
}}) -- Coagulated Anima
nodes[66556794] = Rare({id=154559, quest=56323, assault=EMP, note=L["big_blossom_mine"]}) -- Deeplord Zrihj
nodes[26506657] = Rare({id=160872, quest=58304, assault=MAN}) -- Destroyer Krox'tazar
nodes[41505721] = Rare({id=157287, quest=57349, assault=MOG, pois={
    Path({41745982, 40446144, 38995953, 39805740, 41505721, 45405297})
}}) -- Dokani Obliterator
nodes[13004085] = Rare({id=160874, quest=58305, assault=MAN}) -- Drone Keeper Ak'thet
nodes[10004085] = Rare({id=160876, quest=58306, assault=MAN}) -- Enraged Amber Elemental
nodes[45244524] = Rare({id=157267, quest=57343, assault=EMP, pois={
    Path({44174609, 45244524, 45324176, 44783891})
}}) -- Escaped Mutation
nodes[29513800] = Rare({id=157153, quest=57344, assault=MOG, rewards={
    Mount({id=1297, item=173887}) -- Clutch of Ha-Li
}, pois={
    Path({37323630, 33973378, 29053930, 31524387, 37313632, 37323630})
}}) -- Ha-Li
nodes[28895272] = Rare({id=160810, quest=58299, assault=MAN}) -- Harbinger Il'koxik
nodes[12835129] = Rare({id=160868, quest=58303, assault=MAN}) -- Harrier Nir'verash
nodes[28214047] = Rare({id=157171, quest=57347, assault=MOG}) -- Heixi the Stonelord
nodes[19736082] = Rare({id=160826, quest=58301, assault=MAN}) -- Hive-Guard Naz'ruzek
nodes[12183091] = Rare({id=157160, quest=57345, assault=MOG, rewards={
    Mount({id=1327, item=174841}) -- Ren's Stalwart Hound
}, pois={
    Path({13132578, 11833049, 08953570})
}}) -- Houndlord Ren
nodes[19976576] = Rare({id=160930, quest=58312, assault=MAN}) -- Infused Amber Ooze
nodes[17201162] = Rare({id=160968, quest=58295, assault=MOG, note=L["guolai_left"]}) -- Jade Colossus
nodes[26691061] = Rare({id=157290, quest=57350, assault=MOG, note=L["in_small_cave"]}) -- Jade Watcher
nodes[17850918] = Rare({id=160920, quest=58310, assault=MAN}) -- Kal'tik the Blight
nodes[45985858] = Rare({id=157266, quest=57341, assault=EMP, pois={
    Path({45985858, 48645963, 50576511, 48936926, 45877046, 43096817, 42486336, 45985858})
}}) -- Kilxl the Gaping Maw
nodes[25673816] = Rare({id=160867, quest=58302, assault=MAN}) -- Kzit'kovok
nodes[14813374] = Rare({id=160922, quest=58311, assault=MAN}) -- Needler Zhesalla
nodes[90314599] = Rare({id=154106, quest=56094, assault=EMP}) -- Quid
nodes[21901232] = Rare({id=157162, quest=57346, assault=MOG, note=L["guolai_center"], rewards={
    Item({item=174230}), -- Pristine Cloud Serpent Scale
    Mount({id=1313, item=174649}) -- Rajani Warserpent
}}) -- Rei Lun
nodes[64175175] = Rare({id=154490, quest=56302, assault=EMP}) -- Rijz'x the Devourer
nodes[46425710] = Rare({id=156083, quest=56954, assault=MOG, rewards={
    Item({item=174071}) -- Sanguifang's Pulsating Canine
}}) -- Sanguifang
nodes[25074411] = Rare({id=160906, quest=58309, assault=MAN}) -- Skiver
nodes[17873752] = Rare({id=157291, quest=57351, assault=MOG}) -- Spymaster Hul'ach
nodes[26057505] = Rare({id=157279, quest=57348, assault=MOG, pois={
    Path({23467717, 25247587, 26837367, 27117143})
}}) -- Stormhowl
nodes[29132207] = Rare({id=156424, quest=58507, assault=MOG, rewards={
    Toy({item=174873}) -- Trans-mogu-rifier
}}) -- Tashara
nodes[47496373] = Rare({id=154600, quest=56332, assault=MOG}) -- Teng the Awakened
nodes[52024173] = Rare({id=157176, quest=57342, assault=EMP, note=L["platform"], rewards={
    Pet({id=2845, item=174473}) -- K'uddly
}}) -- The Forgotten
nodes[09586736] = Rare({id=157468, quest=57364, note=L["tisiphon"]}) -- Tisiphon
nodes[86664165] = Rare({id=154394, quest=56213, assault=EMP}) -- Veskan the Fallen
nodes[66732812] = Rare({id=154332, quest=56183, assault=EMP, note=L["pools_of_power"]}) -- Voidtender Malketh
nodes[52956225] = Rare({id=154495, quest=56303, assault=EMP, rewards={
    Item({item=175141}), -- All-Seeing Left Eye
    Toy({item=175140}), -- All-Seeing Eye
    Pet({id=2846, item=174474}) -- Corrupted Tentacle
}, note=L["left_eye"]}) -- Will of N'Zoth
nodes[53794889] = Rare({id=157443, quest=57358, assault=MOG}) -- Xiln the Mountain
nodes[70954053] = Rare({id=154087, quest=56084, assault=EMP}) -- Zror'um the Infinite

-------------------------------------------------------------------------------
---------------------------------- TREASURES ----------------------------------
-------------------------------------------------------------------------------

local MANChest = Class('MANChest', Treasure, {
    assault=MAN, label=L["ambered_cache"]
})

local MANTR1 = MANChest({quest=58224, icon='chest_blue'})
local MANTR2 = MANChest({quest=58225, icon='chest_purple'})
local MANTR3 = MANChest({quest=58226, icon='chest_orange'})
local MANTR4 = MANChest({quest=58227, icon='chest_yellow'})
local MANTR5 = MANChest({quest=58228, icon='chest_teal'})

-- quest=58224
nodes[04066172] = MANTR1
nodes[05165140] = MANTR1
nodes[07223945] = MANTR1
nodes[10662334] = MANTR1
nodes[11552553] = MANTR1
nodes[15797164] = MANTR1
nodes[15887672] = MANTR1
-- quest=58225
nodes[16021946] = MANTR2
nodes[17432634] = MANTR2
nodes[19001350] = clone(MANTR2, {note=L["guolai"]})
nodes[21051415] = MANTR2
nodes[26301110] = MANTR2
-- quest=58226
nodes[07693682] = MANTR3
nodes[09302831] = MANTR3
nodes[10174243] = MANTR3
nodes[12085118] = MANTR3
nodes[15083162] = MANTR3
nodes[15324320] = MANTR3
nodes[16343312] = MANTR3
nodes[17714771] = MANTR3
nodes[18253632] = MANTR3
-- quest=58227
nodes[18063844] = MANTR4
nodes[22903439] = MANTR4
nodes[24153524] = MANTR4
nodes[24994118] = MANTR4
nodes[25843841] = MANTR4
nodes[26524136] = MANTR4
nodes[26704680] = MANTR4
nodes[29944580] = MANTR4
nodes[30074194] = MANTR4
nodes[31724184] = MANTR4
-- quest=58228
nodes[07356617] = MANTR5
nodes[10746891] = MANTR5
nodes[15406394] = MANTR5
nodes[16096581] = MANTR5
nodes[19897504] = MANTR5
nodes[19975976] = MANTR5
nodes[21506269] = MANTR5
nodes[21636992] = MANTR5

nodes[21586246] = Supply({quest=58770, assault=MAN, label=L["ambered_coffer"], sublabel=L["mantid_relic"]})

-------------------------------------------------------------------------------

local MOGChest = Class('MOGChest', Treasure, {
    assault=MOG, label=L["mogu_plunder"]
})

local MOGTR1 = MOGChest({quest=57206, icon='chest_blue', note=L["guolai"]})
local MOGTR2 = MOGChest({quest=57208, icon='chest_lime'})
local MOGTR3 = MOGChest({quest=57209, icon='chest_orange'})
local MOGTR4 = MOGChest({quest=57211, icon='chest_yellow'})
local MOGTR5 = MOGChest({quest=57212, icon='chest_teal'})
local MOGTR6 = MOGChest({quest=57213, icon='chest_purple'})

-- quest=57206
nodes[13500720] = MOGTR1
nodes[17741256] = MOGTR1
nodes[20221140] = MOGTR1
nodes[20441477] = MOGTR1
nodes[22971552] = MOGTR1
nodes[23850753] = MOGTR1
nodes[26001261] = MOGTR1
nodes[26130403] = MOGTR1
nodes[27061822] = MOGTR1
-- quest=57208
nodes[18292766] = MOGTR2
nodes[20462833] = MOGTR2
nodes[21982793] = MOGTR2
nodes[24773504] = MOGTR2
nodes[25114049] = MOGTR2
nodes[26801860] = MOGTR2
nodes[30283762] = MOGTR2
nodes[30983065] = MOGTR2
nodes[33503481] = MOGTR2
-- quest=57209
nodes[19281942] = MOGTR3
nodes[20311853] = MOGTR3
nodes[21271385] = MOGTR3
nodes[27981820] = MOGTR3
nodes[31241393] = MOGTR3
nodes[32721893] = MOGTR3
-- quest=57211
nodes[15496436] = MOGTR4
nodes[16704468] = MOGTR4
nodes[17356860] = MOGTR4
nodes[18787398] = MOGTR4
nodes[21356297] = MOGTR4
nodes[29774890] = MOGTR4
-- quest=57212
nodes[42436854] = MOGTR5
nodes[44186853] = MOGTR5
nodes[47937093] = MOGTR5
nodes[48466580] = MOGTR5
nodes[51146319] = MOGTR5
nodes[52276731] = MOGTR5
-- quest=57213
nodes[32097104] = MOGTR6
nodes[33346985] = MOGTR6
nodes[33876683] = MOGTR6
nodes[37666584] = MOGTR6
nodes[38417028] = MOGTR6

local MOGCOFF = Supply({quest=57214, assault=MOG, label=L["mogu_strongbox"],
    sublabel=L["mogu_relic"]})

nodes[10782831] = MOGCOFF
nodes[20006321] = MOGCOFF
nodes[24430269] = clone(MOGCOFF, {note=L["guolai_center"]})
nodes[43134209] = MOGCOFF
nodes[50182143] = MOGCOFF

-------------------------------------------------------------------------------

local EMPChest = Class('EMPChest', Treasure, {
    assault=EMP, label=L["black_empire_cache"]
})

local EMPTR1 = EMPChest({quest=57197, icon='chest_blue'})
local EMPTR2 = EMPChest({quest=57199, icon='chest_purple', note=L["pools_of_power"]})
local EMPTR3 = EMPChest({quest=57200, icon='chest_orange'})
local EMPTR4 = EMPChest({quest=57201, icon='chest_yellow'})
local EMPTR5 = EMPChest({quest=57202, icon='chest_teal', note=L["big_blossom_mine"]})
local EMPTR6 = EMPChest({quest=57203, icon='chest_lime'})

-- quest=57197
nodes[42024621] = EMPTR1
nodes[42314323] = EMPTR1
nodes[42814020] = EMPTR1
nodes[44274195] = EMPTR1
nodes[44483693] = EMPTR1
nodes[46314037] = EMPTR1
nodes[50673444] = EMPTR1
nodes[52673967] = EMPTR1
nodes[53884179] = EMPTR1
-- quest=57199 (DONT FORGET TO ADD TO THE POOLS OF POWER MAP BELOW)
nodes[56113034] = EMPTR2
nodes[56152716] = EMPTR2
nodes[58452979] = EMPTR2
nodes[61422747] = EMPTR2
nodes[64932682] = EMPTR2
nodes[67222783] = EMPTR2
nodes[69933311] = EMPTR2
nodes[70282286] = EMPTR2
nodes[73242533] = EMPTR2
-- quest=57200
nodes[57334165] = EMPTR3
nodes[59186181] = EMPTR3
nodes[59605624] = EMPTR3
nodes[61674641] = EMPTR3
nodes[62035159] = EMPTR3
nodes[62585721] = EMPTR3
nodes[65206504] = EMPTR3
nodes[65855969] = EMPTR3
nodes[67565584] = EMPTR3
-- quest=57201
nodes[70215370] = EMPTR4
nodes[76594867] = EMPTR4
nodes[77076363] = EMPTR4
nodes[77413129] = EMPTR4
nodes[78305251] = EMPTR4
nodes[78435833] = EMPTR4
nodes[79034330] = EMPTR4
nodes[80733960] = EMPTR4
nodes[81363381] = EMPTR4
nodes[87813771] = EMPTR4
-- quest=57202
nodes[60806337] = EMPTR5
nodes[63107059] = EMPTR5
nodes[64297053] = EMPTR5
nodes[68306247] = EMPTR5
nodes[68705880] = EMPTR5
nodes[70686357] = EMPTR5
nodes[71516854] = EMPTR5
-- quest=57203
nodes[42456853] = EMPTR6
nodes[44196852] = EMPTR6
nodes[47947095] = EMPTR6
nodes[48476579] = EMPTR6
nodes[51136323] = EMPTR6
nodes[52266732] = EMPTR6

local EMPCOFF = Supply({quest=57628, assault=EMP,
    label=L["black_empire_coffer"], sublabel=L["cursed_relic"]})

nodes[53116634] = EMPCOFF
nodes[54804100] = clone(EMPCOFF, {note=L["platform"]})
nodes[62975086] = EMPCOFF
nodes[68662806] = clone(EMPCOFF, {note=L["pools_of_power"]})
nodes[69516094] = EMPCOFF
nodes[76626437] = EMPCOFF

-------------------------------------------------------------------------------

-- Blizzard added a separate map for the pools of power midway through the
-- first week, yay ...

local pmap = clone(map, {id=1579, nodes={}})
local pnodes = pmap.nodes
pmap.intro = nil

-- quest=57199
pnodes[09235255] = EMPTR2
pnodes[09554460] = EMPTR2
pnodes[15235182] = EMPTR2
pnodes[23234539] = EMPTR2
pnodes[32504372] = EMPTR2
pnodes[38294622] = EMPTR2
pnodes[45715972] = EMPTR2
pnodes[46313359] = EMPTR2
pnodes[54384017] = EMPTR2

pnodes[42104690] = clone(EMPCOFF, {note=L["pools_of_power"]})

-------------------------------------------------------------------------------
-------------------------------- ASSAULT EVENTS -------------------------------
-------------------------------------------------------------------------------

nodes[29266081] = TimedEvent({quest=57445, assault=MAN, note=L["noodle_cart"]}) -- Chin's Noodle Cart
nodes[08852675] = TimedEvent({quest=57521, assault=MAN, note=L["empowered_wagon"]}) -- Empowered War Wagon
nodes[11006443] = TimedEvent({quest=57085, assault=MAN, note=L["empowered_wagon"]}) -- Empowered War Wagon
nodes[18556572] = TimedEvent({quest=57540, assault=MAN, note=L["kunchong_incubator"]}) -- Kunchong Incubator
nodes[06484227] = TimedEvent({quest=57558, assault=MAN, note=L["mantid_hatch"]}) -- Mantid Hatchery
nodes[06487067] = TimedEvent({quest=57089, assault=MAN, note=L["mantid_hatch"]}) -- Mantid Hatchery
nodes[19287227] = TimedEvent({quest=57384, assault=MAN, note=L["mending_monstro"]}) -- Mending Monstrosity
nodes[26644650] = TimedEvent({quest=57404, assault=MAN, note=L["ravager_hive"]}) -- Ravager Hive
nodes[16964567] = TimedEvent({quest=57484, assault=MAN, note=L["ritual_wakening"]}) -- Ritual of Wakening
nodes[14073421] = TimedEvent({quest=57453, assault=MAN, note=L["swarm_caller"]}) -- Swarm Caller
nodes[25663647] = TimedEvent({quest=57517, assault=MAN, note=L["swarm_caller"]}) -- Swarm Caller
nodes[27011715] = TimedEvent({quest=57519, assault=MAN, note=L["swarm_caller"]}) -- Swarm Caller
nodes[31146095] = TimedEvent({quest=57542, assault=MAN, note=L["swarm_caller"]}) -- Swarm Caller
nodes[11384092] = TimedEvent({quest=57476, assault=MAN, note=L["feeding_grounds"]}) -- Vil'thik Feeding Grounds
nodes[11034854] = TimedEvent({quest=57508, assault=MAN, note=L["war_banner"]}) -- Zara'thik War Banner

-------------------------------------------------------------------------------

nodes[31332897] = TimedEvent({quest=57087, assault=MOG, note=L["colored_flames"]}) -- Baruk Obliterator
nodes[19167199] = TimedEvent({quest=57272, assault=MOG, note=L["colored_flames"]}) -- Bloodbound Effigy
nodes[25791737] = TimedEvent({quest=57339, assault=MOG, note=L["guolai_right"]..' '..L["construction_ritual"]}) -- Construction Ritual
nodes[14582315] = TimedEvent({quest=57158, assault=MOG, note=L["electric_empower"]}) -- Electric Empowerment
nodes[22423650] = TimedEvent({quest=58367, assault=MOG, note=L["empowered_demo"]}) -- Empowered Demolisher
nodes[26661700] = TimedEvent({quest=58370, assault=MOG, note=L["empowered_demo"]}) -- Empowered Demolisher
nodes[20421247] = TimedEvent({quest=57171, assault=MOG, note=L["goldbough_guardian"]}) -- Goldbough Guardian
nodes[33477097] = TimedEvent({quest=58334, assault=MOG, note=L["in_flames"]}) -- Mistfall In Flames
nodes[50236341] = TimedEvent({quest=57299, assault=MOG, note=L["mystery_sacro"]}) -- Mysterious Sarcophagus
nodes[24824769] = TimedEvent({quest=57323, assault=MOG, note=L["serpent_binding"]}) -- Serpent Binding
nodes[17054571] = TimedEvent({quest=57256, assault=MOG, note=L["stormchosen_arena"]}) -- Stormchosen Arena
nodes[19870750] = TimedEvent({quest=57049, assault=MOG, note=L["guolai_left"]..' '..L["vault_of_souls"]}) -- Vault of Souls
nodes[21411413] = TimedEvent({quest=57023, assault=MOG, note=L["guolai_center"]..' '..L["weighted_artifact"]}) -- Weighted Mogu Artifact
nodes[47662165] = TimedEvent({quest=57101, assault=MOG, note=L["colored_flames"]}) -- Zan-Tien Serpent Cage

-------------------------------------------------------------------------------

local MAWREWARD = {Achievement({id=14161, criteria=1})}

nodes[41354535] = TimedEvent({quest=58439, assault=EMP, note=L["consuming_maw"], rewards=MAWREWARD}) -- Consuming Maw
nodes[46365714] = TimedEvent({quest=58438, assault=EMP, note=L["consuming_maw"], rewards=MAWREWARD}) -- Consuming Maw
nodes[81314952] = TimedEvent({quest=58442, assault=EMP, note=L["consuming_maw"], rewards=MAWREWARD}) -- Consuming Maw

nodes[42316703] = TimedEvent({quest=56090, assault=EMP, note=L["protect_stout"]}) -- Protecting the Stout
nodes[43624146] = TimedEvent({quest=57146, assault=EMP, note=L["corruption_tear"]}) -- Corruption Tear
nodes[49356668] = TimedEvent({quest=56074, assault=EMP, note=L["void_conduit"]}) -- Void Conduit
nodes[56685933] = TimedEvent({quest=56178, assault=EMP, note=L["void_conduit"]}) -- Void Conduit
nodes[60614333] = TimedEvent({quest=56163, assault=EMP, note=L["bound_guardian"]}) -- Bound Guardian
nodes[60416780] = TimedEvent({quest=56099, assault=EMP, note=L["big_blossom_mine"]..' '..L["font_corruption"]}) -- Font of Corruption
nodes[69502214] = TimedEvent({quest=57375, assault=EMP, note=L["pulse_mound"]}) -- Pulsating Mound
nodes[74164004] = TimedEvent({quest=56076, assault=EMP, note=L["abyssal_ritual"]}) -- Abyssal Ritual
nodes[76365163] = TimedEvent({quest=57379, assault=EMP, note=L["infested_statue"]}) -- Infested Jade Statue
nodes[79233315] = TimedEvent({quest=56177, assault=EMP, note=L["void_conduit"]}) -- Void Conduit
nodes[79525433] = TimedEvent({quest=56180, assault=EMP, note=L["bound_guardian"]}) -- Bound Guardian

-------------------------------------------------------------------------------
--------------------------------- BATTLE PETS ---------------------------------
-------------------------------------------------------------------------------

nodes[28553494] = PetBattle({id=162470}) -- Baruk Stone Defender
nodes[56172822] = PetBattle({id=162468}) -- K'tiny the Mad
nodes[57465427] = PetBattle({id=162469}) -- Tormentius
nodes[07333190] = PetBattle({id=162471}) -- Vil'thik Hatchling

-------------------------------------------------------------------------------

VisionsOfNZoth.maps[map.id] = map
VisionsOfNZoth.maps[pmap.id] = pmap


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local Buff = Class('Buff', Node)
local Crystal = Class('Crystal', Node, {icon='orange_crystal', scale=1.5, label=L["odd_crystal"]})

local MAIL = Node({icon='envelope', scale=1.2, label=L["mailbox"], rewards={
    Mount({id=1315, item=174653}) -- Mail Muncher
}, note=L["mail_muncher"]})

local CHEST1 = Treasure({label=L["black_empire_cache"], sublabel=string.format(L["clear_sight"], 1)})
local CHEST2 = Treasure({label=L["black_empire_cache"], sublabel=string.format(L["clear_sight"], 2)})
local CHEST3 = Treasure({label=L["black_empire_cache"], sublabel=string.format(L["clear_sight"], 3)})
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local orgrimmar = Map({ id=1469 })

function orgrimmar:enabled (node, coord, minimap)
    if not Map.enabled(self, node, coord, minimap) then return false end

    local profile = HandyNotes_VisionsOfNZoth.db.profile
    if isinstance(node, Treasure) then return profile.chest_visions end
    if isinstance(node, Buff) then return profile.buff_visions end
    if node == MAIL then return profile.mail_visions end
    return profile.misc_visions
end

local stormwind = Map({ id=1470 })

function stormwind:enabled (node, coord, minimap)
    if not Map.enabled(self, node, coord, minimap) then return false end

    local profile = HandyNotes_VisionsOfNZoth.db.profile
    if isinstance(node, Treasure) then return profile.chest_visions end
    if isinstance(node, Buff) then return profile.buff_visions end
    if isinstance(node, Crystal) then return profile.crystal_visions end
    if node == MAIL then return profile.mail_visions end
    return profile.misc_visions
end

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

defaults['chest_visions'] = true
defaults['buff_visions'] = true
defaults['crystal_visions'] = true
defaults['mail_visions'] = true
defaults['misc_visions'] = true

options.groupVisions = {
    type = "header",
    name = L["horrific_visions"],
    order = 20,
}

options.chestVisions = {
    type = "toggle",
    arg = "chest_visions",
    name = L["options_toggle_chests"],
    desc = L["options_toggle_visions_chest_desc"],
    order = 21,
    width = "normal",
}

options.buffVisions = {
    type = "toggle",
    arg = "buff_visions",
    name = L["options_toggle_visions_buffs"],
    desc = L["options_toggle_visions_buffs_desc"],
    order = 22,
    width = "normal",
}

options.crystalVisions = {
    type = "toggle",
    arg = "crystal_visions",
    name = L["options_toggle_visions_crystals"],
    desc = L["options_toggle_visions_crystals_desc"],
    order = 23,
    width = "normal",
}

options.mailVisions = {
    type = "toggle",
    arg = "mail_visions",
    name = L["options_toggle_visions_mail"],
    desc = L["options_toggle_visions_mail_desc"],
    order = 24,
    width = "normal",
}

options.miscVisions = {
    type = "toggle",
    arg = "misc_visions",
    name = L["options_toggle_misc"],
    desc = L["options_toggle_visions_misc_desc"],
    order = 25,
    width = "normal",
}

-------------------------------------------------------------------------------
---------------------------------- ORGRIMMAR ----------------------------------
-------------------------------------------------------------------------------

-- Valley of Strength
orgrimmar.nodes[46927409] = CHEST1
orgrimmar.nodes[48036506] = CHEST1
orgrimmar.nodes[48197761] = CHEST1
orgrimmar.nodes[49537689] = CHEST1
orgrimmar.nodes[50067075] = CHEST1
orgrimmar.nodes[52967707] = CHEST1

-- Valley of Spirits
orgrimmar.nodes[32046909] = CHEST2
orgrimmar.nodes[34746325] = CHEST2
orgrimmar.nodes[34937546] = CHEST2
orgrimmar.nodes[35556927] = CHEST2
orgrimmar.nodes[35767889] = CHEST2
orgrimmar.nodes[37528493] = CHEST2
orgrimmar.nodes[39388038] = CHEST2

-- The Drag
orgrimmar.nodes[56915817] = clone(CHEST2, {note=L["inside_building"]})
orgrimmar.nodes[57116273] = CHEST2
orgrimmar.nodes[57415604] = CHEST2
orgrimmar.nodes[57554961] = CHEST2
orgrimmar.nodes[60175638] = CHEST2
orgrimmar.nodes[60745806] = clone(CHEST2, {note=L["inside_building"]})
orgrimmar.nodes[60985254] = CHEST2

-- Valley of Wisdom
orgrimmar.nodes[39474727] = CHEST3
orgrimmar.nodes[41224994] = CHEST3
orgrimmar.nodes[42064971] = CHEST3
orgrimmar.nodes[45195352] = CHEST3
orgrimmar.nodes[46895101] = CHEST3
orgrimmar.nodes[48474897] = CHEST3
orgrimmar.nodes[48874617] = CHEST3

-- Valley of Honor
orgrimmar.nodes[66283141] = CHEST3
orgrimmar.nodes[66763903] = CHEST3
orgrimmar.nodes[69164858] = CHEST3
orgrimmar.nodes[69384572] = CHEST3

-------------------------------------------------------------------------------

-- Valley of Strength
orgrimmar.nodes[48708380] = Crystal({note=L["c_behind_bank_counter"]})
orgrimmar.nodes[49406870] = Crystal({note=L["c_hidden_boxes"]})
orgrimmar.nodes[53508200] = Crystal({note=L["c_inside_hut"]})

-- Valley of Spirits
orgrimmar.nodes[33406570] = Crystal({note=L["c_center_building"]})
orgrimmar.nodes[35406940] = Crystal({note=L["c_top_building"]})
orgrimmar.nodes[37908450] = Crystal({note=L["c_behind_pillar"]})
orgrimmar.nodes[38508070] = Crystal({note=L["c_behind_boss"]})

-- The Drag
orgrimmar.nodes[57605860] = Crystal({note=L["c_inside_orphanage"]})
orgrimmar.nodes[57706510] = Crystal({note=L["c_inside_transmog"]})
orgrimmar.nodes[57904860] = Crystal({note=L["c_behind_boss"]})
orgrimmar.nodes[60405510] = Crystal({note=L["c_inside_leatherwork"]})

-- Valley of Wisdom
orgrimmar.nodes[38904990] = Crystal({note=L["c_inside_big_tent"]})
orgrimmar.nodes[41704480] = Crystal({note=L["c_inside_hut"]})
orgrimmar.nodes[48404410] = Crystal({note=L["c_on_small_hill"]})
orgrimmar.nodes[51004520] = Crystal({note=L["c_by_pillar_boxes"]})

-- Valley of Honor
orgrimmar.nodes[63903040] = Crystal({note=L["c_behind_rexxar"]})
orgrimmar.nodes[65805060] = Crystal({note=L["c_inside_cacti"]})
orgrimmar.nodes[67003740] = Crystal({note=L["c_inside_auction"]})
orgrimmar.nodes[68204290] = Crystal({note=L["c_underneath_bridge"]})

-------------------------------------------------------------------------------

orgrimmar.nodes[39304900] = MAIL
orgrimmar.nodes[39708030] = MAIL
orgrimmar.nodes[52707580] = MAIL
orgrimmar.nodes[60105130] = MAIL
orgrimmar.nodes[67673924] = MAIL

-------------------------------------------------------------------------------

orgrimmar.nodes[32106430] = Buff({icon=461119, label=L["spirit_of_wind"],
    note=L["spirit_of_wind_note"]..'\n\n'..L["buffs_change"]})
orgrimmar.nodes[44667697] = Buff({icon=133044, label=L["smiths_strength"],
    note=L["smiths_strength_note"]..'\n\n'..L["buffs_change"]})
orgrimmar.nodes[54277833] = Buff({icon=134991, label=L["heroes_bulwark"],
    note=L["heroes_bulwark_note"]..'\n\n'..L["buffs_change"]})
orgrimmar.nodes[57676513] = Buff({icon=1717106, label=L["ethereal_essence"],
    note=L["ethereal_essence_note"]..'\n\n'..L["buffs_change"]})

-------------------------------------------------------------------------------

orgrimmar.nodes[54027044] = NPC({id=162358, icon=2823166, note=L["ethereal_note"]})
orgrimmar.nodes[46828078] = Node({icon=967522, label=L["colored_potion"],
    note=string.format(L["colored_potion_note"], L["yelmak"])})

local SHAVE_KIT = Node({icon=1001616, label=L["shave_kit"], note=L["shave_kit_note"], rewards={
    Toy({item=174920}) -- Coifcurl's Close Shave Kit
}})

function SHAVE_KIT:enabled (map, coord, minimap)
    if not Node.enabled(self, map, coord, minimap) then return false end
    return HandyNotes_VisionsOfNZoth.db.profile.always_show_treasures or (not self:done())
end

orgrimmar.nodes[39906120] = SHAVE_KIT

-------------------------------------------------------------------------------
---------------------------------- STORMWIND ----------------------------------
-------------------------------------------------------------------------------

-- Cathedral Square
stormwind.nodes[51955788] = CHEST1
stormwind.nodes[55085027] = CHEST1
stormwind.nodes[55845275] = CHEST1
stormwind.nodes[57034974] = CHEST1

-- Trade District
stormwind.nodes[61027547] = CHEST2
stormwind.nodes[61886605] = CHEST2
stormwind.nodes[63687447] = CHEST2
stormwind.nodes[66617039] = CHEST2

-- Dwarven District
stormwind.nodes[60573394] = CHEST2
stormwind.nodes[62522946] = CHEST2
stormwind.nodes[63424206] = CHEST2
stormwind.nodes[66223412] = CHEST2
stormwind.nodes[66694422] = CHEST2

-- Mage Quarter
stormwind.nodes[43018320] = CHEST3
stormwind.nodes[44658694] = CHEST3
stormwind.nodes[47478888] = CHEST3
stormwind.nodes[50169002] = CHEST3
stormwind.nodes[54048542] = CHEST3

-- Old Town
stormwind.nodes[72056202] = CHEST3
stormwind.nodes[73565625] = CHEST3
stormwind.nodes[75286476] = CHEST3
stormwind.nodes[76475374] = clone(CHEST3, {note=L["inside_building"]})

-------------------------------------------------------------------------------

-- Cathedral Square
stormwind.nodes[53005190] = Crystal({note=L["c_left_cathedral"]})
stormwind.nodes[54605940] = Crystal({note=L["c_behind_boxes"]})
stormwind.nodes[58405510] = Crystal({note=L["c_on_small_hill"]})

-- Trade District
stormwind.nodes[60406880] = Crystal({note=L["c_alley_corner"]})
stormwind.nodes[62007690] = Crystal({note=L["c_behind_mailbox"]})
stormwind.nodes[66107570] = Crystal({note=L["c_behind_cart"]})
stormwind.nodes[69007310] = Crystal({note=L["c_left_inquisitor"]})

-- Dwarven District
stormwind.nodes[62703700] = Crystal({note=L["c_forge_corner"]})
stormwind.nodes[63404170] = Crystal()
stormwind.nodes[64603090] = Crystal({note=L["c_behind_boxes"]})
stormwind.nodes[67304470] = Crystal({note=L["c_forge_corner"]})

-- Mage Quarter
stormwind.nodes[44208790] = Crystal({note=L["c_walkway_corner"]})
stormwind.nodes[47408160] = Crystal({note=L["c_behind_house_counter"]})
stormwind.nodes[47708940] = Crystal({note=L["c_walkway_platform"]})
stormwind.nodes[52408340] = Crystal({note=L["c_behind_house_counter"]})

-- Old Town
stormwind.nodes[74605920] = Crystal({note=L["c_behind_boxes"]})
stormwind.nodes[75605340] = Crystal({note=L["c_bar_upper"]})
stormwind.nodes[75606460] = Crystal({note=L["c_behind_mailbox"]})
stormwind.nodes[76506850] = Crystal({note=L["c_behind_stables"]})

-------------------------------------------------------------------------------

stormwind.nodes[49688700] = MAIL
stormwind.nodes[54635751] = MAIL
stormwind.nodes[61687604] = MAIL
stormwind.nodes[62073082] = MAIL
stormwind.nodes[75716456] = MAIL

-------------------------------------------------------------------------------

stormwind.nodes[58404919] = Buff({icon=132183, label=L["bear_spirit"],
    note=L["bear_spirit_note"]..'\n\n'..L["buffs_change"]})
stormwind.nodes[53545906] = Buff({icon=1621334, label=L["requited_bulwark"],
    note=L["requited_bulwark_note"]..'\n\n'..L["buffs_change"]})
stormwind.nodes[59553713] = Buff({icon=133035, label=L["empowered"],
    note=L["empowered_note"]..'\n\n'..L["buffs_change"]})
stormwind.nodes[63107740] = Buff({icon=133784, label=L["enriched"],
    note=L["enriched_note"]..'\n\n'..L["buffs_change"]})

-------------------------------------------------------------------------------

stormwind.nodes[57204620] = NPC({id=162358, icon=2823166, note=L["ethereal_note"]})
stormwind.nodes[51765852] = Node({icon=967522, label=L["colored_potion"],
    note=string.format(L["colored_potion_note"], L["morgan_pestle"])})

local VOID_SKULL = Node({icon=237272, label=L["void_skull"], note=L["void_skull_note"], rewards={
    Toy({item=174921}) -- Void-Touched Skull
}})

function VOID_SKULL:enabled (map, coord, minimap)
    if not Node.enabled(self, map, coord, minimap) then return false end
    return HandyNotes_VisionsOfNZoth.db.profile.always_show_treasures or (not self:done())
end

stormwind.nodes[58905290] = VOID_SKULL

stormwind.nodes[59106390] = Rare({id=158284, note=L["craggle"], pois={
    Path({
        58707630, 57507290, 56406950, 56706670, 59106390, 62306130, 64706190,
        67006490, 68406710
    })
}, rewards={
    Toy({item=174926}) -- Overly Sensitive Void Spectacles
}}) -- Craggle Wobbletop

-------------------------------------------------------------------------------

VisionsOfNZoth.maps[orgrimmar.id] = orgrimmar
VisionsOfNZoth.maps[stormwind.id] = stormwind



-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = Map({ id=864 })
local nodes = map.nodes

function map:enabled (node, coord, minimap)
    if not Map.enabled(self, node, coord, minimap) then return false end

    local profile = HandyNotes_VisionsOfNZoth.db.profile
    if node.alpaca then return profile.alpaca_voldun end

    return true
end

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

defaults['alpaca_voldun'] = true

options.groupVoldun = {
    type = "header",
    name = L["voldun"],
    order = 30,
}

options.alpacaVoldun = {
    type = "toggle",
    arg = "alpaca_voldun",
    name = L["options_toggle_alpaca_voldun"],
    desc = L["options_toggle_alpaca_voldun_desc"],
    order = 31,
    width = "normal",
}

-------------------------------------------------------------------------------
------------------------------ ELUSIVE QUICKHOOF ------------------------------
-------------------------------------------------------------------------------

nodes[43006900] = NPC({id=162681, icon=2916283, alpaca=true, pois={
    POI({
        26405250, 29006600, 31106730, 42006000, 43006900, 51108590, 52508900,
        54008200, 54605320, 55007300
    })
}, rewards={
    Mount({id=1324, item=174860}) -- Elusive Quickhoof
}, note=L["elusive_alpaca"]})

-------------------------------------------------------------------------------

VisionsOfNZoth.maps[map.id] = map
