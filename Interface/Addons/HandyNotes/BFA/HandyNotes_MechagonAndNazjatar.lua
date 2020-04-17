local MechagonAndNazjatar = {}

MechagonAndNazjatar.Class = function (name, parent)
    parent = parent or {}
    local Class = { getters = {}, setters = {} }

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

MechagonAndNazjatar.isinstance = function (instance, class)
    local function compare (c1, c2)
        if c2 == nil then return false end
        if c1 == c2 then return true end
        return compare(c1, c2.__parent)
    end
    return compare(class, instance.__class)
end


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local HandyNotes_MechagonAndNazjatar = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_MechagonAndNazjatar", "AceBucket-3.0", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes");
MechagonAndNazjatar.maps = {};

MechagonAndNazjatar.status = {
    Green = function (t) return string.format('(|cFF00FF00%s|r)', t) end,
    Gray = function (t) return string.format('(|cFF999999%s|r)', t) end,
    Red = function (t) return string.format('(|cFFFF0000%s|r)', t) end,
    Orange = function (t) return string.format('(|cFFFF8C00%s|r)', t) end
}

------------------------------------ TODO -------------------------------------

-- Add area indicators on hover for zone rares
-- Stick area indicators on click and highlight rare icon blue
-- Add backdrop tooltip for Naz zone-wide rares
-- Add filtering for rewards (pets vs mounts vs transmog vs achievements)

-------------------------------------------------------------------------------
----------------------------------- HELPERS -----------------------------------
-------------------------------------------------------------------------------

local function debug(...)
    if (HandyNotes_MechagonAndNazjatar.db.profile.show_debug) then
        print(...);
    end
end

local DropdownMenu = CreateFrame("Frame", "HandyNotes_MechagonAndNazjatarDropdownMenu");
DropdownMenu.displayMode = "MENU";
local function initializeDropdownMenu (button, level, mapID, coord)
    if not level then return end
    local node = MechagonAndNazjatar.maps[mapID].nodes[coord];
    local spacer = {text='', disabled=1, notClickable=1, notCheckable=1};

    if (level == 1) then
        UIDropDownMenu_AddButton({
            text=L["context_menu_title_Mechagon"], isTitle=1, notCheckable=1
        }, level);

        UIDropDownMenu_AddButton(spacer, level);

        if select(2, IsAddOnLoaded('TomTom')) then
            UIDropDownMenu_AddButton({
                text=L["context_menu_add_tomtom"], notCheckable=1,
                func=function (button)
                    local x, y = HandyNotes:getXY(coord);
                    TomTom:AddWaypoint(mapID, x, y, {
                        title = node.label,
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
                HandyNotes_MechagonAndNazjatar.db.char[mapID..'_coord_'..coord] = true;
                HandyNotes_MechagonAndNazjatar:Refresh()
            end
        }, level);

        UIDropDownMenu_AddButton({
            text=L["context_menu_restore_hidden_nodes"], notCheckable=1,
            func=function ()
                table.wipe(HandyNotes_MechagonAndNazjatar.db.char)
                HandyNotes_MechagonAndNazjatar:Refresh()
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

function HandyNotes_MechagonAndNazjatar:OnEnter(mapID, coord)
    local node = MechagonAndNazjatar.maps[mapID].nodes[coord];
    local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip;

    if self:GetCenter() > UIParent:GetCenter() then
        tooltip:SetOwner(self, "ANCHOR_LEFT");
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT");
    end

    tooltip:SetText(node.label);

    -- optional top-right text
    if node.rlabel then
        local rtext = _G[tooltip:GetName()..'TextRight1']
        rtext:SetTextColor(1, 1, 1)
        rtext:SetText(node.rlabel)
        rtext:Show()
    end

    if node.note and HandyNotes_MechagonAndNazjatar.db.profile.show_notes then
        tooltip:AddLine(node.note, 1, 1, 1, true);
    end

    if HandyNotes_MechagonAndNazjatar.db.profile.show_loot then
        local firstAchieve, firstOther = true, true
        for i, reward in ipairs(node.rewards or {}) do

            -- Add a blank line between achievements and other rewards
            local isAchieve = MechagonAndNazjatar.isinstance(reward, MechagonAndNazjatar.reward.Achievement)
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

    tooltip:Show();
end

function HandyNotes_MechagonAndNazjatar:OnLeave( mapID, coord )
    if self:GetParent() == WorldMapButton then
        WorldMapTooltip:Hide();
    else
        GameTooltip:Hide();
    end
end

function HandyNotes_MechagonAndNazjatar:OnClick(button, down, mapID, coord)
    local node = MechagonAndNazjatar.maps[mapID].nodes[coord];
    if button == "RightButton" and down then
        DropdownMenu.initialize = function (button, level)
            initializeDropdownMenu(button, level, mapID, coord);
        end;
        ToggleDropDownMenu(1, nil, DropdownMenu, self, 0, 0)
    elseif button == "LeftButton" and down then
        -- toggle sticky overlay
    end
end

function HandyNotes_MechagonAndNazjatar:OnInitialize()
    MechagonAndNazjatar.faction = UnitFactionGroup('player')
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_MechagonAndNazjatarDB", MechagonAndNazjatar.optionDefaults, "Default")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", function ()
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        self:ScheduleTimer("RegisterWithHandyNotes", 1)
    end);
end

-------------------------------------------------------------------------------
------------------------------------ MAIN -------------------------------------
-------------------------------------------------------------------------------

function HandyNotes_MechagonAndNazjatar:RegisterWithHandyNotes()
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
        function HandyNotes_MechagonAndNazjatar:GetNodes2(mapID, _minimap)
            map = MechagonAndNazjatar.maps[mapID]
            minimap = _minimap

            if map then
                map:prepare()
                return iter, map.nodes, nil
            end

            -- mapID not handled by this plugin
            return iter, nil, nil
        end
    end

    if self.db.profile.development then MechagonAndNazjatar.add_dev_options() end
    HandyNotes:RegisterPluginDB("HandyNotes_MechagonAndNazjatar", self, MechagonAndNazjatar.options)
    self:RegisterBucketEvent({ "LOOT_CLOSED", "PLAYER_MONEY", "SHOW_LOOT_TOAST", "SHOW_LOOT_TOAST_UPGRADE" }, 2, "Refresh")
    self:Refresh()
end

function HandyNotes_MechagonAndNazjatar:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_MechagonAndNazjatar")
end


local ICONS = "Interface\\Addons\\HandyNotes\\Icons\\icons.blp"
local ICONS_SIZE = 255

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

for name, icon in pairs(MechagonAndNazjatar.icons) do
    if type(icon) == 'table' then
        icon.tCoordLeft = icon.coords[1]/ICONS_SIZE
        icon.tCoordRight = icon.coords[2]/ICONS_SIZE
        icon.tCoordTop = icon.coords[3]/ICONS_SIZE
        icon.tCoordBottom = icon.coords[4]/ICONS_SIZE
        icon.coords = nil
    end
end

-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local L = L;

-------------------------------------------------------------------------------
---------------------------------- DEFAULTS -----------------------------------
-------------------------------------------------------------------------------

MechagonAndNazjatar.optionDefaults = {
    profile = {
        -- icon scales
        icon_scale_caves = 1,
        icon_scale_other = 1,
        icon_scale_pet_battles = 1,
        icon_scale_rares = 1,
        icon_scale_treasures = 1,

        -- icon alphas
        icon_alpha_caves = 0.75,
        icon_alpha_other = 1.0,
        icon_alpha_pet_battles = 1.0,
        icon_alpha_rares = 0.75,
        icon_alpha_treasures = 0.75,

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
        show_debug = false,
        ignore_quests = false,
        force_nodes = false
    },
};

-------------------------------------------------------------------------------
--------------------------------- OPTIONS UI ----------------------------------
-------------------------------------------------------------------------------

MechagonAndNazjatar.options = {
    type = "group",
    name = L["options_title_Mechagon"],
    get = function(info) return HandyNotes_MechagonAndNazjatar.db.profile[info.arg] end,
    set = function(info, v) HandyNotes_MechagonAndNazjatar.db.profile[info.arg] = v; HandyNotes_MechagonAndNazjatar:Refresh() end,
    args = {}
}

MechagonAndNazjatar.options.args.IconOptions = {
    type = "group",
    name = L["options_icon_settings"],
    inline = true,
    order = 0,
    args = {}
}

for i, group in ipairs{'treasures', 'rares', 'pet_battles', 'caves', 'other'} do
    MechagonAndNazjatar.options.args.IconOptions.args['group_icon_'..group] = {
        type = "header",
        name = L["options_icons_"..group],
        order = i * 10,
    }

    MechagonAndNazjatar.options.args.IconOptions.args['icon_scale_'..group] = {
        type = "range",
        name = L["options_scale"],
        desc = L["options_scale_desc"],
        min = 0.25, max = 3, step = 0.01,
        arg = "icon_scale_"..group,
        order = i * 10 + 1,
    }

    MechagonAndNazjatar.options.args.IconOptions.args['icon_alpha_'..group] = {
        type = "range",
        name = L["options_opacity"],
        desc = L["options_opacity_desc"],
        min = 0, max = 1, step = 0.01,
        arg = "icon_alpha_"..group,
        order = i * 10 + 2,
    }
end

MechagonAndNazjatar.options.args.VisibilityGroup = {
    type = "group",
    order = 10,
    name = L["options_visibility_settings"],
    inline = true,
    args = {
        groupGeneral = {
            type = "header",
            name = L["options_general_settings"],
            order = 30,
        },
        always_show_rares = {
            type = "toggle",
            arg = "always_show_rares",
            name = L["options_toggle_looted_rares"],
            desc = L["options_toggle_looted_rares_desc"],
            order = 31,
            width = "full",
        },
        always_show_treasures = {
            type = "toggle",
            arg = "always_show_treasures",
            name = L["options_toggle_looted_treasures"],
            desc = L["options_toggle_looted_treasures_desc"],
            order = 32,
            width = "full",
        },
        hide_done_rare = {
            type = "toggle",
            arg = "hide_done_rare",
            name = L["options_toggle_hide_done_rare"],
            desc = L["options_toggle_hide_done_rare_desc"],
            order = 35,
            width = "full",
        },
        hide_minimap = {
            type = "toggle",
            arg = "hide_minimap",
            name = L["options_toggle_hide_minimap"],
            desc = L["options_toggle_hide_minimap_desc"],
            order = 36,
            width = "full",
        },
    },
}

MechagonAndNazjatar.options.args.TooltipGroup = {
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

MechagonAndNazjatar.add_dev_options = function ()
    -- To enable these options, manually set "development = true" in your
    -- settings file for this addon
    MechagonAndNazjatar.options.args.DevelopmentGroup = {
        type = "group",
        order = 30,
        name = L["options_dev_settings"],
        desc = L["options_dev_settings_desc"],
        inline = true,
        args = {
            show_debug = {
                type = "toggle",
                arg = "show_debug",
                name = L["options_toggle_show_debug"],
                desc = L["options_toggle_show_debug_desc"],
                order = 1,
            },
            ignore_quests = {
                type = "toggle",
                arg = "ignore_quests",
                name = L["options_toggle_ignore_quests"],
                desc = L["options_toggle_ignore_quests_desc"],
                order = 2,
            },
            force_nodes = {
                type = "toggle",
                arg = "force_nodes",
                name = L["options_toggle_force_nodes"],
                desc = L["options_toggle_force_nodes_desc"],
                order = 3,
            }
        }
    }
end


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local Class = MechagonAndNazjatar.Class

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local Map = Class('Map')

Map.id = 0

function Map:init ()
    self.nodes = {}
end

function Map:prepare () end

function Map:enabled (node, coord, minimap)
    local db = HandyNotes_MechagonAndNazjatar.db

    -- Check if we've been hidden by the user
    if db.char[self.id..'_coord_'..coord] then return false end

    return node:enabled(self, coord, minimap)
end

-------------------------------------------------------------------------------

MechagonAndNazjatar.Map = Map


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local isinstance = MechagonAndNazjatar.isinstance

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
    local db = HandyNotes_MechagonAndNazjatar.db
    local icon = self.icon
    if type(icon) == 'string' then
        icon = MechagonAndNazjatar.icons[self.icon] or MechagonAndNazjatar.icons.default
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
    local db = HandyNotes_MechagonAndNazjatar.db

    -- Minimap may be disabled for this node
    if not self.minimap and minimap then return false end

    -- Node may be faction restricted
    if self.faction and self.faction ~= MechagonAndNazjatar.faction then return false end

    if not db.profile.ignore_quests then
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
Cave.scale = 1.1
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

local NPC_TOOLTIP_NAME = "HandyNotes_MechagonAndNazjatar_npcToolTip"
local NPC_TOOLTIP = nil
local NPC_CACHE = {}

local function CreateDatamineFrame()
    NPC_TOOLTIP = CreateFrame("GameTooltip", NPC_TOOLTIP_NAME, UIParent,
        "GameTooltipTemplate")
    NPC_TOOLTIP:SetOwner(UIParent, "ANCHOR_NONE")
end

CreateDatamineFrame() -- create the initial frame

-------------------------------------------------------------------------------

local NPC = Class('NPC', Node)

function NPC:init ()
    Node.init(self)
    if not self.id then error('id required for NPC nodes') end
end

function NPC.getters:label ()
    local name = NPC_CACHE[self.id]
    if not name then
        NPC_TOOLTIP:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(self.id))
        name = _G[NPC_TOOLTIP_NAME.."TextLeft1"]:GetText()
        if name and name ~= '' then
            NPC_CACHE[self.id] = name
        else
            -- Sometimes the tooltip breaks and permanently stops returning
            -- info. When this happens, the only way I've found to fix it is to
            -- recreate the frame. I wish there was an actual API for this.
            CreateDatamineFrame()
            name = UNKNOWN
        end
    end
    return name
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

local Quest = Class('Quest', Node)

Quest.note = AVAILABLE_QUEST

function Quest:init()
    Node.init(self)
    C_QuestLog.GetQuestInfo(self.quest[1]) -- fetch info from server
end

function Quest.getters:icon()
    return self.daily and 'quest_blue' or 'quest_yellow'
end

function Quest.getters:label()
    return C_QuestLog.GetQuestInfo(self.quest[1])
end

-------------------------------------------------------------------------------
------------------------------------ RARE -------------------------------------
-------------------------------------------------------------------------------

local Rare = Class('Rare', NPC)

Rare.scale = 1.2
Rare.group = "rares"

function Rare.getters:icon ()
    return self:done() and 'skull_white' or 'skull_blue'
end

function Rare:enabled (map, coord, minimap)
    local db = HandyNotes_MechagonAndNazjatar.db
    if db.profile.hide_done_rare and self:done() then return false end
    if db.profile.always_show_rares then return true end
    return NPC.enabled(self, map, coord, minimap)
end

-------------------------------------------------------------------------------
----------------------------------- SUPPLY ------------------------------------
-------------------------------------------------------------------------------

local Supply = Class('Supply', Node)

Supply.icon = "star_chest"
Supply.scale = 1.4
Supply.group = "treasures"

-------------------------------------------------------------------------------
---------------------------------- TREASURE -----------------------------------
-------------------------------------------------------------------------------

local Treasure = Class('Treasure', Node)

Treasure.icon = "chest_gray"
Treasure.scale = 1.2
Treasure.group = "treasures"

function Treasure:enabled (map, coord, minimap)
    local db = HandyNotes_MechagonAndNazjatar.db
    if db.profile.always_show_treasures then return true end
    return Node.enabled(self, map, coord, minimap)
end

-------------------------------------------------------------------------------

MechagonAndNazjatar.node = {
    Node=Node,
    Cave=Cave,
    NPC=NPC,
    PetBattle=PetBattle,
    Quest=Quest,
    Rare=Rare,
    Supply=Supply,
    Treasure=Treasure
}


local Green = MechagonAndNazjatar.status.Green
local Orange = MechagonAndNazjatar.status.Orange
local Red = MechagonAndNazjatar.status.Red

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
local GetCriteriaInfo = GetAchievementCriteriaInfoByID

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
        local _, _, completed = GetAchievementCriteriaInfoByID(self.id, c.id)
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
        local ctext = "   • "..cname..(c.suffix or '')
        if (completed or ccomp) then
            r, g, b = 0, 1, 0
        end

        if c.note and HandyNotes_MechagonAndNazjatar.db.profile.show_notes then
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
    item:ContinueOnItemLoad(function()
        self.itemLink = item:GetItemLink()
        self.itemIcon = item:GetItemIcon()
    end)
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
        status = completed and Green('(√)') or Red('(X)')
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
        local completed = IsQuestFlaggedCompleted(self.id)
        status = completed and Green('(√)') or Red('(X)')
    else
        local count = 0
        for i, id in ipairs(self.id) do
            if IsQuestFlaggedCompleted(id) then count = count + 1 end
        end
        status = count..'/'..#self.id
        status = (count == #self.id) and Green(status) or Red(status)
    end

    local icon = MechagonAndNazjatar.icons.quest_yellow
    tooltip:AddDoubleLine((name or UNKNOWN), status)
    tooltip:AddTexture(icon.icon, {
        width = 12,
        height = 12,
        texCoords = {
            left=icon.tCoordLeft,
            right=icon.tCoordRight,
            top=icon.tCoordTop,
            bottom=icon.tCoordBottom
        },
        margin = { right=0 }
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
    if self.note and HandyNotes_MechagonAndNazjatar.db.profile.show_notes then
        suffix = suffix..' ('..self.note..')'
    end

    tooltip:AddDoubleLine(self.itemLink..suffix, status)
    tooltip:AddTexture(self.itemIcon, {margin={right=2}})
end

-------------------------------------------------------------------------------

MechagonAndNazjatar.reward = {
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
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------



local Map = MechagonAndNazjatar.Map


local Node = MechagonAndNazjatar.node.Node
local Cave = MechagonAndNazjatar.node.Cave
local NPC = MechagonAndNazjatar.node.NPC
local PetBattle = MechagonAndNazjatar.node.PetBattle
local Quest = MechagonAndNazjatar.node.Quest
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

local options = MechagonAndNazjatar.options.args.VisibilityGroup.args
local defaults = MechagonAndNazjatar.optionDefaults.profile

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = Map({ id=1462 })
local nodes = map.nodes
local TIME_DISPLACEMENT = 296644

function map:prepare ()
    self.future = AuraUtil.FindAuraByName(GetSpellInfo(TIME_DISPLACEMENT), 'player')
end

function map:enabled (node, coord, minimap)
    if not Map.enabled(self, node, coord, minimap) then return false end

    -- check node's future availability (nil=no, 1=yes, 2=both)
    if self.future and not node.future then return false end
    if not self.future and node.future == 1 then return false end

    local profile = HandyNotes_MechagonAndNazjatar.db.profile
    if isinstance(node, Treasure) then
        if node.quest then return profile.chest_mech end
        return profile.locked_mech
    end
    if isinstance(node, Rare) then return profile.rare_mech end
    if isinstance(node, PetBattle) then return profile.pet_mech end
    if node.label == L["rec_rig"] then return profile.recrig_mech end

    -- node for the More Recycling daily
    if isinstance(node, Quest) then return true end

    return false;
end

-- Listen for aura applied/removed events so we can refresh when the player
-- enters and exits the alternate future
HandyNotes_MechagonAndNazjatar:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED', function ()
    local _,e,_,_,_,_,_,_,t,_,_,s  = CombatLogGetCurrentEventInfo()
    if (e == 'SPELL_AURA_APPLIED' or e == 'SPELL_AURA_REMOVED') and
        t == UnitName('player') and s == TIME_DISPLACEMENT then
        C_Timer.After(1, function()
            HandyNotes_MechagonAndNazjatar:Refresh();
        end);
    end
end)

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

defaults['chest_mech'] = true;
defaults['locked_mech'] = true;
defaults['rare_mech'] = true;
defaults['pet_mech'] = true;
defaults['recrig_mech'] = true;

options.groupMechagon = {
    type = "header",
    name = L["Mechagon"],
    order = 0,
};

options.mechChestMechagon = {
    type = "toggle",
    arg = "chest_mech",
    name = L["options_toggle_mech_chest"],
    desc = L["options_toggle_mech_chest_desc"],
    order = 1,
    width = "normal",
};


options.lockedChestMechagon = {
    type = "toggle",
    arg = "locked_mech",
    name = L["options_toggle_locked_chest"],
    desc = L["options_toggle_locked_chest_desc"],
    order = 2,
    width = "normal",
};

options.rareMechagon = {
    type = "toggle",
    arg = "rare_mech",
    name = L["options_toggle_rares"],
    desc = L["options_toggle_rares_desc"],
    order = 3,
    width = "normal",
};

options.petMechagon = {
    type = "toggle",
    arg = "pet_mech",
    name = L["options_toggle_battle_pets"],
    desc = L["options_toggle_battle_pets_desc"],
    order = 4,
    width = "normal",
};

options.recrigMechagon = {
    type = "toggle",
    arg = "recrig_mech",
    name = L["options_toggle_recrig"],
    desc = L["options_toggle_recrig_desc"],
    order = 5,
    width = "normal",
};

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

nodes[52894092] = Rare({id=151934, quest=55512, future=2, note=nil, rewards={
    Achievement({id=13470, criteria=45124}), -- Kill
    Mount({id=1229, item=168823}) -- Rusty Mechanocrawler
}}); -- Arachnoid Harvester

nodes[55622571] = Rare({id=151308, quest=55539, note=nil, rewards={
    Achievement({id=13470, criteria=45131}), -- Kill
    Item({item=169688, quest=56515}) -- Vinyl: Gnomeregan Forever
}}); -- Boggac Skullbash

nodes[51265010] = Rare({id=153200, quest=55857, note=L["drill_rig"]..'(DR-JD41).', rewards={
    Achievement({id=13470, criteria=45152}), -- Kill
    Item({item=167042, quest=55030}), -- Blueprint: Scrap Trap
    Item({item=169691, quest=56518}) -- Vinyl: Depths of Ulduar
}}); -- Boilburn

nodes[65842288] = Rare({id=152001, quest=55537, note=L["cave_spawn"], rewards={
    Achievement({id=13470, criteria=45130}), -- Kill
    Item({item=167846, quest=55061}), -- Blueprint: Mechano-Treat
    Pet({id=2719, item=169392}) -- Bonebiter
}}); -- Bonepicker

nodes[66535891] = Rare({id=154739, quest=56368, note=L["drill_rig"]..'(DR-CC73).', rewards={
    Achievement({id=13470, criteria=45411}), -- Kill
    Item({item=169170, quest=55078}) -- Blueprint: Utility Mechanoclaw
}}); -- Caustic Mechaslime

nodes[82522072] = Rare({id=149847, quest=55812, note=L["crazed_trogg_note"], rewards={
    Achievement({id=13470, criteria=45137}), -- Kill
    Item({item=169169, quest=55077}), -- Blueprint: Blue Spraybot
    Item({item=169168, quest=55076}), -- Blueprint: Green Spraybot
    Item({item=169167, quest=55075}), -- Blueprint: Orange Spraybot
    Item({item=167792, quest=55452}), -- Paint Vial: Fel Mint Green
    Item({item=167793, quest=55457}) -- Paint Vial: Overload Orange
}}); -- Crazed Trogg

nodes[35464229] = Rare({id=151569, quest=55514, note=L["deepwater_note"], rewards={
    Achievement({id=13470, criteria=45128}), -- Kill
    Item({item=167836, quest=55057}), -- Blueprint: Canned Minnows
}}); --Deepwater Maw

nodes[63122559] = Rare({id=150342, quest=55814, note=L["drill_rig"]..'(DR-TR35).', rewards={
    Achievement({id=13470, criteria=45138}), -- Kill
    Item({item=167042, quest=55030}), -- Blueprint: Scrap Trap
    Item({item=169691, quest=56518}) -- Vinyl: Depths of Ulduar
}}); -- Earthbreaker Gulroc

nodes[55075684] = Rare({id=154153, quest=56207, note=nil, rewards={
    Achievement({id=13470, criteria=45373}), -- Kill
    Item({item=169174, quest=55082}), -- Blueprint: Rustbolt Pocket Turret
    Transmog({item=170466, slot=L["staff"]}), -- Junkyard Motivator
    Transmog({item=170467, slot=L["1h_sword"]}), -- Whirring Chainblade
    Transmog({item=170468, slot=L["gun"]}), -- Supervolt Zapper
    Transmog({item=170470, slot=L["shield"]}) -- Reinforced Grease Deflector
}}); -- Enforcer KX-T57

nodes[65515167] = Rare({id=151202, quest=55513, note=L["foul_manifest_note"], rewards={
    Achievement({id=13470, criteria=45127}), -- Kill
    Item({item=167871, quest=55063}) -- Blueprint: G99.99 Landshark
}}); -- Foul Manifestation

nodes[44553964] = Rare({id=151884, quest=55367, note=L["furor_note"], rewards={
    Achievement({id=13470, criteria=45126}), -- Kill
    Item({item=167793, quest=55457}), -- Paint Vial: Overload Orange
    Pet({id=2712, item=169379}) -- Snowsoft Nibbler
}}); -- Fungarian Furor

nodes[61395117] = Rare({id=153228, quest=55852, note=L["cogstar_note"], rewards={
    Achievement({id=13470, criteria=45155}), -- Kill
    Item({item=167847, quest=55062}), -- Blueprint: Ultrasafe Transporter: Mechagon
    Transmog({item=170467, slot=L["1h_sword"]}) -- Whirring Chainblade
}}); -- Gear Checker Cogstar

nodes[59836701] = Rare({id=153205, quest=55855, note=L["drill_rig"]..'(DR-JD99).', rewards={
    Achievement({id=13470, criteria=45146}), -- Kill
    Item({item=169691, quest=56518}) -- Vinyl: Depths of Ulduar
}}); -- Gemicide

nodes[73135414] = Rare({id=154701, quest=56367, note=L["drill_rig"]..'(DR-CC61).', rewards={
    Achievement({id=13470, criteria=45410}), -- Kill
    Item({item=167846, quest=55061}) -- Blueprint: Mechano-Treat
}}); -- Gorged Gear-Cruncher

nodes[77124471] = Rare({id=151684, quest=55399, note=nil, rewards={
    Achievement({id=13470, criteria=45121}) -- Kill
}}); -- Jawbreaker

nodes[44824637] = Rare({id=152007, quest=55369, note=L["killsaw_note"], rewards={
    Achievement({id=13470, criteria=45125}), -- Kill
    Toy({item=167931}) -- Mechagonian Sawblades
}}); -- Killsaw

nodes[60654217] = Rare({id=151933, quest=55544, note=L["beastbot_note"], rewards={
    Achievement({id=13470, criteria=45136}), -- Kill
    Achievement({id=13708, criteria={45772,45775,45776,45777,45778}}), -- Most Minis Wins
    Item({item=169848, weekly=57135}), -- Azeroth Mini Pack: Bondo's Yard
    Item({item=169173, quest=55081}), -- Blueprint: Anti-Gravity Pack
    Pet({id=2715, item=169382}) -- Lost Robogrip
}}); -- Malfunctioning Beastbot (55926 56506)

nodes[57165258] = Rare({id=151124, quest=55207, note=L["nullifier_note"], rewards={
    Achievement({id=13470, criteria=45117}), -- Kill
    Item({item=168490, quest=55069}), -- Blueprint: Protocol Transference Device
    Item({item=169688, quest=56515}) -- Vinyl: Gnomeregan Forever
}}); -- Mechagonian Nullifier

nodes[88142077] = Rare({id=151672, quest=55386, future=2, note=nil, rewards={
    Achievement({id=13470, criteria=45119}), -- Kill
    Pet({id=2720, item=169393}) -- Arachnoid Skitterbot
}}); -- Mecharantula

nodes[61036101] = Rare({id=151627, quest=55859, note=nil, rewards={
    Achievement({id=13470, criteria=45156}), -- Kill
    Item({item=168248, quest=55068}), -- Blueprint: BAWLD-371
    Transmog({item=170467, slot=L["1h_sword"]}) -- Whirring Chainblade
}}); -- Mr. Fixthis

nodes[56243595] = Rare({id=153206, quest=55853, note=L["drill_rig"]..'(DR-TR28).', rewards={
    Achievement({id=13470, criteria=45145}), -- Kill
    Item({item=167846, quest=55061}), -- Blueprint: Mechano-Treat
    Item({item=169691, quest=56518}), -- Vinyl: Depths of Ulduar
    Transmog({item=170466, slot=L["staff"]}) -- Junkyard Motivator
}}); -- Ol' Big Tusk

nodes[57063944] = Rare({id=151296, quest=55515, note=L["avenger_note"], rewards={
    Achievement({id=13470, criteria=45129}), -- Kill
    Item({item=168492, quest=55071}) -- Blueprint: Emergency Rocket Chicken
}}); -- OOX-Avenger/MG

nodes[56636287] = Rare({id=152764, quest=55856, note=L["leachbeast_note"], rewards={
    Achievement({id=13470, criteria=45157}), -- Kill
    Item({item=167794, quest=55454}), -- Paint Vial: Lemonade Steel
}}); -- Oxidized Leachbeast

nodes[22466873] = Rare({id=151702, quest=55405, note=nil, rewards={
    Achievement({id=13470, criteria=45122}), -- Kill
    Transmog({item=170468, slot=L["gun"]}) -- Supervolt Zapper
}}); -- Paol Pondwader

nodes[40235317] = Rare({id=150575, quest=55368, note=L["cave_spawn"], rewards={
    Achievement({id=13470, criteria=45123}), -- Kill
    Item({item=168001, quest=55517}) -- Paint Vial: Big-ol Bronze
}}); -- Rumblerocks

nodes[65637850] = Rare({id=152182, quest=55811, note=nil, rewards={
    Achievement({id=13470, criteria=45135}), -- Kill
    Item({item=169173, quest=55081}), -- Blueprint: Anti-Gravity Pack
    Mount({id=1248, item=168370}) -- Rusted Keys to the Junkheap Drifter
}}); -- Rustfeather

nodes[82287300] = Rare({id=155583, quest=56737, note=L["scrapclaw_note"], rewards={
    Achievement({id=13470, criteria=45691}), -- Kill
    Transmog({item=170470, slot=L["shield"]}) -- Reinforced Grease Deflector
}}); -- Scrapclaw

nodes[19127975] = Rare({id=150937, quest=55545, note=nil, rewards={
    Achievement({id=13470, criteria=45133}), -- Kill
    Item({item=168063, quest=55065}) -- Blueprint: Rustbolt Kegerator
}}); -- Seaspit

nodes[81852708] = Rare({id=153000, quest=55810, note=L["sparkqueen_note"], rewards={
    Achievement({id=13470, criteria=45134}) -- Kill
}}); -- Sparkqueen P'Emp

nodes[26257806] = Rare({id=153226, quest=55854, note=nil, rewards={
    Achievement({id=13470, criteria=45154}), -- Kill
    Item({item=168062, quest=55064}), -- Blueprint: Rustbolt Gramophone
    Item({item=169690, quest=56517}), -- Vinyl: Battle of Gnomeregan
    Item({item=169689, quest=56516}), -- Vinyl: Mimiron's Brainstorm
    Item({item=169692, quest=56519}) -- Vinyl: Triumph of Gnomeregan
}}); -- Steel Singer Freza

nodes[80962019] = Rare({id=155060, quest=56419, note=L["doppel_note"], label=L["doppel_gang"], rewards={
    Achievement({id=13470, criteria=45433}) -- Kill
}}); -- The Doppel Gang

nodes[68434776] = Rare({id=152113, quest=55858, note=L["drill_rig"]..'(DR-CC88).', rewards={
    Achievement({id=13470, criteria=45153}), -- Kill
    Item({item=169691, quest=56518}), -- Vinyl: Depths of Ulduar
    Pet({id=2753, item=169886}) -- Spraybot 0D
}}); -- The Kleptoboss

nodes[57335827] = Rare({id=154225, quest=56182, future=2, note=L["rusty_note"], rewards={
    Achievement({id=13470, criteria=45374}), -- Kill
    Toy({item=169347}), -- Judgment of Mechagon
    Transmog({item=170467, slot=L["1h_sword"]}) -- Whirring Chainblade
}}); -- The Rusty Prince

nodes[72344987] = Rare({id=151625, quest=55364, note=nil, rewards={
    Achievement({id=13470, criteria=45118}), -- Kill
    Item({item=167846, quest=55061}), -- Blueprint: Mechano-Treat
    Transmog({item=170467, slot=L["1h_sword"]}) -- Whirring Chainblade
}}); -- The Scrap King

nodes[57062218] = Rare({id=151940, quest=55538, note=L["cave_spawn"], rewards={
    Achievement({id=13470, criteria=45132}) -- Kill
}}); -- Uncle T'Rogg

nodes[53824933] = Rare({id=150394, quest=55546, future=2, note=L["vaultbot_note"], rewards={
    Achievement({id=13470, criteria=45158}), -- Kill
    Item({item=167843, quest=55058}), -- Blueprint: Vaultbot Key
    Item({item=167796, quest=55455}), -- Paint Vial: Mechagon Gold
    Pet({id=2766, item=170072}) -- Armored Vaultbot
}}); -- Armored Vaultbot

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
RED_PAINT = Item({item=170146, quest=56907}) -- Paint Bottle: Nukular Red

-- Recently it looks like these are in fixed spawns compared to when 8.2 hit
nodes[23195699] = Treasure({label=L["iron_chest"], note=L["iron_chest_note"], rewards={RED_PAINT}})
nodes[13228581] = Treasure({label=L["iron_chest"], note=L["iron_chest_note"], rewards={RED_PAINT}})
nodes[19018086] = Treasure({label=L["iron_chest"], note=L["iron_chest_note"], rewards={RED_PAINT}})
nodes[30775964] = Treasure({label=L["iron_chest"], note=L["iron_chest_note"], rewards={RED_PAINT}})
nodes[20537120] = Treasure({label=L["msup_chest"], note=L["msup_chest_note"], rewards={RED_PAINT}})
nodes[18357618] = Treasure({label=L["rust_chest"], note=L["rust_chest_note"], rewards={RED_PAINT}})
nodes[25267825] = Treasure({label=L["rust_chest"], note=L["rust_chest_note"], rewards={RED_PAINT}})
nodes[23988441] = Treasure({label=L["rust_chest"], note=L["rust_chest_note"], rewards={RED_PAINT}})

-------------------------------------------------------------------------------
------------------------------ MECHANIZED CHESTS ------------------------------
-------------------------------------------------------------------------------

--[[local MechChest = Class('MechChest', Treasure)

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
local TREASURE10 = MechChest({quest=55556, icon='chest_lblue'})]]

local TREASURE1 = Treasure({quest=55547, icon='chest_blue', label=L["mech_chest"]})
local TREASURE2 = Treasure({quest=55548, icon='chest_brown', label=L["mech_chest"]})
local TREASURE3 = Treasure({quest=55549, icon='chest_orange', label=L["mech_chest"]})
local TREASURE4 = Treasure({quest=55550, icon='chest_yellow', label=L["mech_chest"]})
local TREASURE5 = Treasure({quest=55551, icon='chest_camo', future=1, label=L["mech_chest"]})
local TREASURE6 = Treasure({quest=55552, icon='chest_lime', label=L["mech_chest"]})
local TREASURE7 = Treasure({quest=55553, icon='chest_red', label=L["mech_chest"]})
local TREASURE8 = Treasure({quest=55554, icon='chest_purple', label=L["mech_chest"]})
local TREASURE9 = Treasure({quest=55555, icon='chest_teal', label=L["mech_chest"]})
local TREASURE10 = Treasure({quest=55556, icon='chest_lblue', label=L["mech_chest"]})

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

--nodes[53486145] = Quest({quest=55743, requires=56117, daily=true, minimap=false, scale=1.8, rewards={ Achievement({id=13708, criteria={45772,45775,45776,45777,45778}}), -- Most Minis Wins
--    Item({item=169848, weekly=57134}), -- Azeroth Mini Pack: Bondo's Yard
--}})

-------------------------------------------------------------------------------

local RegRig = Class('RegRig', Node)

function RegRig.getters:rlabel ()
    local G, GR, N, H = MechagonAndNazjatar.status.Green, MechagonAndNazjatar.status.Gray, L['normal'], L['hard']
    local normal = IsQuestFlaggedCompleted(55847) and G(N) or GR(N)
    local hard = IsQuestFlaggedCompleted(55848) and G(H) or GR(H)
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

MechagonAndNazjatar.maps[1462] = map




-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = Map({ id=1355 })
local nodes = map.nodes

function map:prepare ()
    self.phased = self.intros[MechagonAndNazjatar.faction]:done()
end

function map:enabled (node, coord, minimap)
    if not Map.enabled(self, node, coord, minimap) then return false end

    -- always show the intro helper nodes, and hide all other nodes if we're
    -- not phased yet
    if node.icon == 'quest_yellow' then return true end
    if not self.phased and node.icon ~= 'quest_yellow' then return false end

    local profile = HandyNotes_MechagonAndNazjatar.db.profile
    if isinstance(node, Treasure) then return profile.treasure_nazjatar end
    if isinstance(node, Rare) then return profile.rare_nazjatar end
    if isinstance(node, Supply) then return profile.supply_nazjatar end
    if isinstance(node, Cave) then return profile.cave_nazjatar end
    if isinstance(node, PetBattle) then return profile.pet_nazjatar end
    if node.id == 151782 or node.label == L["slimy_cocoon"] then
        return profile.slime_nazjatar
    end
    if node.label == L["cat_figurine"] then
        return profile.cats_nazjatar
    end
    if node.label == L["mardivas_lab"] or node.label == L["murloco"] then
        return profile.misc_nazjatar
    end
    return false
end

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

defaults['treasure_nazjatar'] = true;
defaults['rare_nazjatar'] = true;
defaults['pet_nazjatar'] = true;
defaults['supply_nazjatar'] = true;
defaults['slime_nazjatar'] = true;
defaults['cats_nazjatar'] = true;
defaults['cave_nazjatar'] = true;
defaults['misc_nazjatar'] = true;

options.groupNazjatar = {
    type = "header",
    name = L["Nazjatar"],
    order = 10,
};

options.treasureNazjatar = {
    type = "toggle",
    arg = "treasure_nazjatar",
    name = L["options_toggle_treasures"],
    desc = L["options_toggle_treasures_nazj"],
    order = 11,
    width = "normal",
};

options.supplyNazjatar = {
    type = "toggle",
    arg = "supply_nazjatar",
    name = L["options_toggle_supplies"],
    desc = L["options_toggle_supplies_desc"],
    order = 12,
    width = "normal",
};

options.rareNazjatar = {
    type = "toggle",
    arg = "rare_nazjatar",
    name = L["options_toggle_rares"],
    desc = L["options_toggle_rares_desc"],
    order = 13,
    width = "normal",
};

options.petNazjatar = {
    type = "toggle",
    arg = "pet_nazjatar",
    name = L["options_toggle_battle_pets"],
    desc = L["options_toggle_battle_pets_desc"],
    order = 14,
    width = "normal",
};

options.slimesNazjatar = {
    type = "toggle",
    arg = "slime_nazjatar",
    name = L["options_toggle_slimes_nazj"],
    desc = L["options_toggle_slimes_nazj_desc"],
    order = 15,
    width = "normal",
};

options.catsNazjatar = {
    type = "toggle",
    arg = "cats_nazjatar",
    name = L["options_toggle_cats_nazj"],
    desc = L["options_toggle_cats_nazj_desc"],
    order = 16,
    width = "normal",
};

options.caveNazjatar = {
    type = "toggle",
    arg = "cave_nazjatar",
    name = L["options_toggle_caves"],
    desc = L["options_toggle_caves_desc"],
    order = 17,
    width = "normal",
};

options.miscNazjatar = {
    type = "toggle",
    arg = "misc_nazjatar",
    name = L["options_toggle_misc"],
    desc = L["options_toggle_misc_nazj"],
    order = 18,
    width = "normal",
};

-------------------------------------------------------------------------------
------------------------------------ INTRO ------------------------------------
-------------------------------------------------------------------------------

local Intro = Class('Intro', Node)

Intro.note = L["naz_intro_note"]
Intro.icon = 'quest_yellow'
Intro.scale = 3

function Intro.getters:label ()
    return GetAchievementCriteriaInfo(13710, 1) -- Welcome to Nazjatar
end

nodes[11952801] = Intro({quest=56156, faction='Alliance', rewards={
    -- The Wolf's Offensive => A Way Home
    Quest({id={56031,56043,55095,54969,56640,56641,56642,56643,56644,55175,54972}}),
    -- Essential Empowerment => Scouting the Palace
    Quest({id={55851,55533,55374,55400,55407,55425,55497,55618,57010,56162,56350}}),
    -- The Lost Shaman => A Tempered Blade
    Quest({id={55361,55362,55363,56156}})
}})

nodes[11952802] = Intro({quest=55500, faction='Horde', rewards={
    -- The Warchief's Order => A Way Home
    Quest({id={56030,56044,55054,54018,54021,54012,55092,56063,54015,56429,55094,55053}}),
    -- Essential Empowerment => Scouting the Palace
    Quest({id={55851,55533,55374,55400,55407,55425,55497,55618,57010,56161,55481}}),
    -- Settling In => Save A Friend
    Quest({id={55384,55385,55500}})
}})

map.intros = { Alliance = nodes[11952801], Horde = nodes[11952802] }

HandyNotes_MechagonAndNazjatar:RegisterEvent('QUEST_TURNED_IN', function (_, questID)
    if questID == 56156 or questID == 55500 then
        C_Timer.After(1, function()
            HandyNotes_MechagonAndNazjatar:Refresh();
        end);
    end
end)

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

nodes[52394183] = Rare({id=152415, quest=56279, note=L["alga_note"], rewards={
    Achievement({id=13691, criteria=45519}), -- Kill
    Achievement({id=13692, criteria=46083}) -- Blind Eye (170189)
}}); -- Alga the Eyeless

nodes[66443875] = Rare({id=152416, quest=56280, note=L["allseer_note"], rewards={
    Achievement({id=13691, criteria=45520}) -- Kill
}}); -- Allseer Oma'kill

nodes[58605329] = Rare({id=152566, quest=56281, note=L["anemonar_note"], rewards={
    Achievement({id=13691, criteria=45522}), -- Kill
    Achievement({id=13692, criteria={46088,46089}}), -- Ancient Reefwalker Bark, Reefwalker Bark
    Item({item=170184, weekly=57140}) -- Ancient Reefwalker Bark
}}); -- Anemonar

nodes[73985395] = Rare({id=152361, quest=56282, note=L["banescale_note"], rewards={
    Achievement({id=13691, criteria=45524}), -- Kill
    Achievement({id=13692, criteria=46093}) -- Snapdragon Scent Gland
}}); -- Banescale the Packfather

nodes[37378256] = Rare({id=152712, quest=56269, note=L["cave_spawn"], rewards={
    Achievement({id=13691, criteria=45525}), -- Kill
    Pet({id=2682, item=169372}) -- Necrofin Tadpole
}}); -- Blindlight

nodes[40790735] = Rare({id=152464, quest=56283, note=L["cave_spawn"], rewards={
    Achievement({id=13691, criteria=45527}), -- Kill
    Pet({id=2690, item=169356}) -- Caverndark Nightmare
}}); -- Caverndark Terror

nodes[49208875] = Rare({id=152556, quest=56270, note=L["ucav_spawn"], rewards={
    Achievement({id=13691, criteria=45528}), -- Kill
    Achievement({id=13692, criteria=46101}), -- Eel Filet
}}); -- Chasm-Haunter

nodes[57074363] = Rare({id=152291, quest=56272, note=L["cora_spawn"], rewards={
    Achievement({id=13691, criteria=45530}), -- Kill
    Achievement({id=13692, criteria=46096}) -- Fathom Ray Wing
}}); -- Deepglider

nodes[64543531] = Rare({id=152414, quest=56284, note=L["elderunu_note"], rewards={
    Achievement({id=13691, criteria=45531}) -- Kill
}}); -- Elder Unu

nodes[51757487] = Rare({id=152555, quest=56285, note=nil, rewards={
    Achievement({id=13691, criteria=45532}), -- Kill
    Pet({id=2693, item=169359}) -- Spawn of Nalaada
}}); -- Elderspawn Nalaada

nodes[36044496] = Rare({id=152553, quest=56273, note=L["area_spawn"], rewards={
    Achievement({id=13691, criteria=45533}), -- Kill
    Achievement({id=13692, criteria=46092}) -- Razorshell
}}); -- Garnetscale

nodes[45715170] = Rare({id=152448, quest=56286, note=L["glimmershell_note"], rewards={
    Achievement({id=13691, criteria=45534}), -- Kill
    Achievement({id=13692, criteria=46099}), -- Giant Crab Leg
    Pet({id=2686, item=169352}) -- Pearlescent Glimmershell
}}); -- Iridescent Glimmershell

nodes[50056991] = Rare({id=152567, quest=56287, note=L["kelpwillow_note"], rewards={
    Achievement({id=13691, criteria=45535}), -- Kill
    Achievement({id=13692, criteria={46088,46089}}), -- Ancient Reefwalker Bark, Reefwalker Bark
    Item({item=170184, weekly=57140}) -- Ancient Reefwalker Bark
}}); -- Kelpwillow

nodes[29412899] = Rare({id=152323, quest=55671, note=L["gakula_note"], rewards={
    Achievement({id=13691, criteria=45536}), -- Kill
    Pet({id=2681, item=169371}) -- Murgle
}}); -- King Gakula

nodes[78132501] = Rare({id=152397, quest=56288, note=L["oronu_note"], rewards={
    Achievement({id=13691, criteria=45539}), -- Kill
    Achievement({id=13692, criteria={46088,46089}}), -- Ancient Reefwalker Bark, Reefwalker Bark
    Item({item=170184, weekly=57140}) -- Ancient Reefwalker Bark
}}); -- Oronu

nodes[42728740] = Rare({id=152681, quest=56289, note=nil, rewards={
    Achievement({id=13691, criteria=45540}), -- Kill
    Pet({id=2701, item=169367}) -- Seafury
}}); -- Prince Typhonus

nodes[42997551] = Rare({id=152682, quest=56290, note=nil, rewards={
    Achievement({id=13691, criteria=45541}), -- Kill
    Pet({id=2702, item=169368}) -- Stormwrath
}}); -- Prince Vortran

nodes[35554141] = Rare({id=152548, quest=56292, note=L["matriarch_note"], rewards={
    Achievement({id=13691, criteria=45545}), -- Kill
    Achievement({id=13692, criteria=46087}), -- Intact Naga Skeleton
    Pet({id=2704, item=169370}) -- Scalebrood Hydra
}}); -- Scale Matriarch Gratinax

nodes[27193708] = Rare({id=152545, quest=56293, note=L["matriarch_note"], rewards={
    Achievement({id=13691, criteria=45546}), -- Kill
    Achievement({id=13692, criteria=46087}), -- Intact Naga Skeleton
    Pet({id=2704, item=169370}) -- Scalebrood Hydra
}}); -- Scale Matriarch Vynara

nodes[28604664] = Rare({id=152542, quest=56294, note=L["matriarch_note"], rewards={
    Achievement({id=13691, criteria=45547}), -- Kill
    Achievement({id=13692, criteria=46087}), -- Intact Naga Skeleton
    Pet({id=2704, item=169370}) -- Scalebrood Hydra
}}); -- Scale Matriarch Zodia

nodes[62740809] = Rare({id=152552, quest=56295, note=L["cave_spawn"], rewards={
    Achievement({id=13691, criteria=45548}), -- Kill
    Toy({item=170187}) -- Shadescale
}}); -- Shassera

nodes[39601700] = Rare({id=153658, quest=56296, note=L["area_spawn"], rewards={
    Achievement({id=13691, criteria=45549}), -- Kill
    Achievement({id=13692, criteria={46090,46091}}) -- Voltscale Shield, Tidal Guard
}}); -- Shiz'narasz the Consumer

nodes[71365456] = Rare({id=152359, quest=56297, note=nil, rewards={
    Achievement({id=13691, criteria=45550}), -- Kill
    Achievement({id=13692, criteria=46093}) -- Snapdragon Scent Gland
}}); -- Siltstalker the Packmother

nodes[59704791] = Rare({id=152290, quest=56298, note=L["cora_spawn"], rewards={
    Achievement({id=13691, criteria=45551}), -- Kill
    Achievement({id=13692, criteria=46096}), -- Fathom Ray Wing
    Mount({id=1257, item=169163}) -- Silent Glider
}}); -- Soundless

nodes[62462964] = Rare({id=153898, quest=56122, note=L["tidelord_note"], rewards={
    Achievement({id=13691, criteria=45553}) -- Kill
}}); -- Tidelord Aquatus

nodes[57962648] = Rare({id=153928, quest=56123, note=L["tidelord_note"], rewards={
    Achievement({id=13691, criteria=45554}) -- Kill
}}); -- Tidelord Dispersius

nodes[65872243] = Rare({id=154148, quest=56106, note=L["tidemistress_note"], rewards={
    Achievement({id=13691, criteria=45555}), -- Kill
    Toy({item=170196}) -- Shirakess Warning Sign
}}); -- Tidemistress Leth'sindra

nodes[66964817] = Rare({id=152360, quest=56278, note=L["area_spawn"], rewards={
    Achievement({id=13691, criteria=45556}), -- Kill
    Achievement({id=13692, criteria=46094}) -- Alpha Fin
}}); -- Toxigore the Alpha

nodes[31282935] = Rare({id=152568, quest=56299, note=L["urduu_note"], rewards={
    Achievement({id=13691, criteria=45557}), -- Kill
    Achievement({id=13692, criteria={46088,46089}}), -- Ancient Reefwalker Bark, Reefwalker Bark
    Item({item=170184, weekly=57140}) -- Ancient Reefwalker Bark
}}); -- Urduu

nodes[67243458] = Rare({id=151719, quest=56300, note=L["voice_deeps_notes"], rewards={
    Achievement({id=13691, criteria=45558}), -- Kill
    Achievement({id=13692, criteria=46086}) -- Abyss Pearl
}}); -- Voice in the Deeps

nodes[36931120] = Rare({id=150191, quest=55584, note=L["avarius_note"], rewards={
    Pet({id=2706, item=169373}) -- Brinestone Algan
}}); -- Avarius

nodes[54664179] = Rare({id=149653, quest=55366, note=L["lasher_note"], rewards={
    Pet({id=2708, item=169375}) -- Coral Lashling
}}); -- Carnivorous Lasher

nodes[48002427] = Rare({id=150468, quest=55603, note=L["vorkoth_note"], rewards={
    Pet({id=2709, item=169376}) -- Skittering Eel
}}); -- Vor'koth

-------------------------------------------------------------------------------
---------------------------------- ZONE RARES ---------------------------------
-------------------------------------------------------------------------------

local start = 09452400;
local function coord(x, y)
    return start + x*2500000 + y*400;
end

nodes[coord(0,0)] = Rare({id=152794, quest=56268, minimap=false, note=L["zone_spawn"], rewards={
    Achievement({id=13691, criteria=45521}), -- Kill
    Pet({id=2697, item=169363}) -- Amethyst Softshell
}}); -- Amethyst Spireshell

nodes[coord(1,0)] = Rare({id=152756, quest=56271, minimap=false, note=L["zone_spawn"], rewards={
    Achievement({id=13691, criteria=45529}), -- Kill
    Pet({id=2695, item=169361}) -- Daggertooth Frenzy
}}); -- Daggertooth Terror

nodes[coord(2,0)] = Rare({id=144644, quest=56274, minimap=false, note=L["zone_spawn"], rewards={
    Achievement({id=13691, criteria=45537}), -- Kill
    Achievement({id=13692, criteria=46098}), -- Brightspine Shell
    Pet({id=2700, item=169366}) -- Wriggler
}}); -- Mirecrawler

nodes[coord(0,1)] = Rare({id=152465, quest=56275, minimap=false, note=L["needle_note"], rewards={
    Achievement({id=13691, criteria=45538}), -- Kill
    Achievement({id=13692, criteria=46099}), -- Giant Crab Leg
    Pet({id=2689, item=169355}) -- Chitterspine Needler
}}); -- Needlespine

nodes[coord(1,2)] = Rare({id=150583, quest=56291, minimap=false, note=L["zone_spawn"]..' '..L["rockweed_note"], rewards={
    Achievement({id=13691, criteria=45542}), -- Kill
    Pet({id=2707, item=169374}) -- Budding Algan
}}); -- Rockweed Shambler

nodes[coord(1,1)] = Rare({id=151870, quest=56276, minimap=false, note=L["sandcastle_note"], rewards={
    Achievement({id=13691, criteria=45543}), -- Kill
    Pet({id=2703, item=169369}) -- Sandkeep
}}); -- Sandcastle

nodes[coord(2,1)] = Rare({id=152795, quest=56277, minimap=false, note=L["east_spawn"], rewards={
    Achievement({id=13691, criteria=45544}), -- Kill
    Achievement({id=13692, criteria=46099}), -- Giant Crab Leg
    Pet({id=2684, item=169350}) -- Glittering Diamondshell
}}); -- Sandclaw Stoneshell

-------------------------------------------------------------------------------
------------------------------------ CAVES ------------------------------------
-------------------------------------------------------------------------------

nodes[39897717] = Cave({parent=nodes[37378256], label=L["blindlight_cave"]});
nodes[42261342] = Cave({parent=nodes[40790735], label=L["caverndark_cave"]});
nodes[47588538] = Cave({parent=nodes[49208875], label=L["chasmhaunt_cave"]});
nodes[63081189] = Cave({parent=nodes[62740809], label=L["shassera_cave"]});

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
};

-- first quest is daily, second quest means done and gone until weekly reset
nodes[32773951] = NPC({id=151782, icon="slime", quest={55430,55473},
    note=L["ravenous_slime_note"], rewards=SLIME_PETS});
nodes[45692409] = NPC({id=151782, icon="slime", quest={55429,55472},
    note=L["ravenous_slime_note"], rewards=SLIME_PETS});
nodes[54894868] = NPC({id=151782, icon="slime", quest={55427,55470},
    note=L["ravenous_slime_note"], rewards=SLIME_PETS});
nodes[71722569] = NPC({id=151782, icon="slime", quest={55428,55471},
    note=L["ravenous_slime_note"], rewards=SLIME_PETS});

-- once the second quest is true, the eggs should be displayed
nodes[32773952] = Node({icon="green_egg", quest=55478, requires=55473,
    label=L["slimy_cocoon"], note=L["slimy_cocoon_note"], rewards=SLIME_PETS});
nodes[45692410] = Node({icon="green_egg", quest=55477, requires=55472,
    label=L["slimy_cocoon"], note=L["slimy_cocoon_note"], rewards=SLIME_PETS});
nodes[54894869] = Node({icon="green_egg", quest=55475, requires=55470,
    label=L["slimy_cocoon"], note=L["slimy_cocoon_note"], rewards=SLIME_PETS});
nodes[71722570] = Node({icon="green_egg", quest=55476, requires=55471,
    label=L["slimy_cocoon"], note=L["slimy_cocoon_note"], rewards=SLIME_PETS});

HandyNotes_MechagonAndNazjatar:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED', function (...)
    -- Watch for a spellcast event that signals the slime was fed.
    -- https://www.wowhead.com/spell=293775/schleimphage-feeding-tracker
    local _, source, _, spellID = ...
    if (source == 'player' and spellID == 293775) then
        C_Timer.After(1, function()
            HandyNotes_MechagonAndNazjatar:Refresh();
        end);
    end
end)

-------------------------------------------------------------------------------
---------------------------------- TREASURES ----------------------------------
-------------------------------------------------------------------------------

-- Arcane Chests
nodes[34454040] = Treasure({quest=55954, label=L["arcane_chest"], note=L["arcane_chest_01"]});
nodes[49576450] = Treasure({quest=55949, label=L["arcane_chest"], note=L["arcane_chest_02"]});
nodes[85303860] = Treasure({quest=55938, label=L["arcane_chest"], note=L["arcane_chest_03"]});
nodes[37906050] = Treasure({quest=55957, label=L["arcane_chest"], note=L["arcane_chest_04"]});
nodes[79502720] = Treasure({quest=55942, label=L["arcane_chest"], note=L["arcane_chest_05"]});
nodes[44704890] = Treasure({quest=55947, label=L["arcane_chest"], note=L["arcane_chest_06"]});
nodes[34604360] = Treasure({quest=55952, label=L["arcane_chest"], note=L["arcane_chest_07"]});
nodes[26003240] = Treasure({quest=55953, label=L["arcane_chest"], note=L["arcane_chest_08"]});
nodes[50605000] = Treasure({quest=55955, label=L["arcane_chest"], note=L["arcane_chest_09"]});
nodes[64303330] = Treasure({quest=55943, label=L["arcane_chest"], note=L["arcane_chest_10"]});
nodes[52804980] = Treasure({quest=55945, label=L["arcane_chest"], note=L["arcane_chest_11"]});
nodes[48508740] = Treasure({quest=55951, label=L["arcane_chest"], note=L["arcane_chest_12"]});
nodes[43405820] = Treasure({quest=55948, label=L["arcane_chest"], note=L["arcane_chest_13"]});
nodes[73203580] = Treasure({quest=55941, label=L["arcane_chest"], note=L["arcane_chest_14"]});
nodes[80402980] = Treasure({quest=55939, label=L["arcane_chest"], note=L["arcane_chest_15"]});
nodes[58003500] = Treasure({quest=55946, label=L["arcane_chest"], note=L["arcane_chest_16"]});
nodes[74805320] = Treasure({quest=55940, label=L["arcane_chest"], note=L["arcane_chest_17"]});
nodes[39804920] = Treasure({quest=55956, label=L["arcane_chest"], note=L["arcane_chest_18"]});
nodes[38707440] = Treasure({quest=55950, label=L["arcane_chest"], note=L["arcane_chest_19"]});
nodes[56303380] = Treasure({quest=55944, label=L["arcane_chest"], note=L["arcane_chest_20"]});

-- Glowing Arcane Chests
nodes[37900640] = Treasure({quest=55959, icon="shootbox_blue", scale=2, label=L["glowing_chest"], note=L["glowing_chest_1"]})
nodes[43951693] = Treasure({quest=55963, icon="shootbox_blue", scale=2, label=L["glowing_chest"], note=L["glowing_chest_2"]})
nodes[24803520] = Treasure({quest=56912, icon="shootbox_blue", scale=2, label=L["glowing_chest"], note=L["glowing_chest_3"]})
nodes[55701450] = Treasure({quest=55961, icon="shootbox_blue", scale=2, label=L["glowing_chest"], note=L["glowing_chest_4"]})
nodes[61402290] = Treasure({quest=55958, icon="shootbox_blue", scale=2, label=L["glowing_chest"], note=L["glowing_chest_5"]})
nodes[64102860] = Treasure({quest=55962, icon="shootbox_blue", scale=2, label=L["glowing_chest"], note=L["glowing_chest_6"]})
nodes[37201920] = Treasure({quest=55960, icon="shootbox_blue", scale=2, label=L["glowing_chest"], note=L["glowing_chest_7"]})
nodes[80493194] = Treasure({quest=56547, icon="shootbox_blue", scale=2, label=L["glowing_chest"], note=L["glowing_chest_8"]})

-------------------------------------------------------------------------------
-------------------------------- CAT FIGURINES --------------------------------
-------------------------------------------------------------------------------

nodes[28752910] = Node({quest=56983, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_01"]})
nodes[71342369] = Node({quest=56988, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_02"]})
nodes[73582587] = Node({quest=56992, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_03"]})
nodes[58212198] = Node({quest=56990, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_04"]})
nodes[61092681] = Node({quest=56984, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_05"]})
nodes[40168615] = Node({quest=56987, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_06"]})
nodes[59093053] = Node({quest=56985, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_07"]})
nodes[55362715] = Node({quest=56986, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_08"]})
nodes[61641079] = Node({quest=56991, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_09"]})
nodes[38004925] = Node({quest=56989, icon="emerald_cat", label=L["cat_figurine"], note=L["cat_figurine_10"]})

HandyNotes_MechagonAndNazjatar:RegisterEvent('CRITERIA_EARNED', function (...)
    -- Watch for criteria events that signal the figurine was clicked
    local _, achievement = ...
    if achievement == 13836 then
        C_Timer.After(1, function()
            HandyNotes_MechagonAndNazjatar:Refresh();
        end);
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
}});

nodes[47864647] = Supply({label=L["supply_chest"], rewards={ASSASSIN_ACHIEVE}}); -- north basin
nodes[47285170] = Supply({label=L["supply_chest"], rewards={ASSASSIN_ACHIEVE}}); -- south basin
nodes[45237040] = Supply({label=L["supply_chest"], rewards={ASSASSIN_ACHIEVE}}); -- south of newhome
nodes[33493889] = Supply({label=L["supply_chest"], rewards={ASSASSIN_ACHIEVE}}); -- ashen strand (also 33283441?)
nodes[59663755] = Supply({label=L["supply_chest"], rewards={ASSASSIN_ACHIEVE}}); -- coral forest
nodes[76873699] = Supply({label=L["supply_chest"], rewards={ASSASSIN_ACHIEVE}}); -- zin-azshari

-------------------------------------------------------------------------------
-------------------------------- MISCELLANEOUS --------------------------------
-------------------------------------------------------------------------------

nodes[60683221] = Node({quest=55121, icon="portal_blue", scale=1.5, label=L["mardivas_lab"], rewards={
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

nodes[45993245] = Node({icon="diablo_murloc", label=L["murloco"], note=L["tentacle_taco"]})

-------------------------------------------------------------------------------

MechagonAndNazjatar.maps[1355] = map
