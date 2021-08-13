-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local _, Core = ...

-------------------------------------------------------------------------------
----------------------------------- COLORS ------------------------------------
-------------------------------------------------------------------------------

Core.COLORS = {
    Blue = 'FF0066FF',
    Gray = 'FF999999',
    Green = 'FF00FF00',
    LightBlue = 'FF8080FF',
    Orange = 'FFFF8C00',
    Red = 'FFFF0000',
    White = 'FFFFFFFF',
    Yellow = 'FFFFFF00',
    --------------------
    NPC = 'FFFFFD00',
    Spell = 'FF71D5FF'
}

Core.color = {}
Core.status = {}

for name, color in pairs(Core.COLORS) do
    Core.color[name] = function (t) return string.format('|c%s%s|r', color, t) end
    Core.status[name] = function (t) return string.format('(|c%s%s|r)', color, t) end
end

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
    preparer = CreateDatamineTooltip("HandyNotes_Core_NamePreparer"),
    resolver = CreateDatamineTooltip("HandyNotes_Core_NameResolver")
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
        Core.Debug('ERROR: npc link not prepared:', link)
    end

    local name = self.cache[link]
    if name == nil then
        self.resolver:SetHyperlink(link)
        name = _G[self.resolver:GetName().."TextLeft1"]:GetText() or UNKNOWN
        if name == UNKNOWN then
            Core.Debug('NameResolver returned UNKNOWN, recreating tooltip ...')
            self.resolver = CreateDatamineTooltip("HandyNotes_Core_NameResolver")
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
    for type, id in str:gmatch('{(%l+):(%d+)(%l*)}') do
        id = tonumber(id)
        if type == 'npc' then
            NameResolver:Prepare(("unit:Creature-0-0-0-0-%d"):format(id))
        elseif type == 'item' then
            C_Item.RequestLoadItemDataByID(id) -- prime item info
        elseif type == 'daily' or type == 'quest' then
            C_QuestLog.RequestLoadQuestByID(id) -- prime quest title
        elseif type == 'spell' then
            C_Spell.RequestLoadSpellData(id) -- prime spell info
        end
    end
end

local function RenderLinks(str, nameOnly)
    -- render numberic ids
    local links, _ = str:gsub('{(%l+):(%d+)(%l*)}', function (type, id, suffix)
        id = tonumber(id)
        if type == 'npc' then
            local name = NameResolver:Resolve(("unit:Creature-0-0-0-0-%d"):format(id))
            name = name..(suffix or '')
            if nameOnly then return name end
            return Core.color.NPC(name)
        elseif type == 'achievement' then
            if nameOnly then
                local _, name = GetAchievementInfo(id)
                if name then return name end
            else
                local link = GetAchievementLink(id)
                if link then
                    return Core.GetIconLink('achievement', 15)..link
                end
            end
        elseif type == 'currency' then
            local info = C_CurrencyInfo.GetCurrencyInfo(id)
            if info then
                if nameOnly then return info.name end
                local link = C_CurrencyInfo.GetCurrencyLink(id, 0)
                if link then
                    return '|T'..info.iconFileID..':0:0:1:-1|t '..link
                end
            end
        elseif type == 'faction' then
            local name = GetFactionInfoByID(id)
            if nameOnly then return name end
            return Core.color.NPC(name) -- TODO: colorize based on standing?
        elseif type == 'item' then
            local name, link, _, _, _, _, _, _, _, icon = GetItemInfo(id)
            if link and icon then
                if nameOnly then return name..(suffix or '') end
                return '|T'..icon..':0:0:1:-1|t '..link
            end
        elseif type == 'daily' or type == 'quest' then
            local name = C_QuestLog.GetTitleForQuestID(id)
            if name then
                if nameOnly then return name end
                local icon = (type == 'daily') and 'quest_ab' or 'quest_ay'
                return Core.GetIconLink(icon, 12)..Core.color.Yellow('['..name..']')
            end
        elseif type == 'spell' then
            local name, _, icon = GetSpellInfo(id)
            if name and icon then
                if nameOnly then return name end
                local spell = Core.color.Spell('|Hspell:'..id..'|h['..name..']|h')
                return '|T'..icon..':0:0:1:-1|t '..spell
            end
        end
        return type..'+'..id
    end)
    -- render non-numeric ids
    links, _ = links:gsub('{(%l+):([^}]+)}', function (type, id)
        if type == 'wq' then
            local icon = Core.GetIconLink('world_quest', 16, 0, -1)
            return icon..Core.color.Yellow('['..id..']')
        end
        return type..'+'..id
    end)
    return links
end

-------------------------------------------------------------------------------
-------------------------------- BAG FUNCTIONS --------------------------------
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

local function PlayerHasItem(item, count)
    for bag, slot in IterateBagSlots() do
        if GetContainerItemID(bag, slot) == item then
            if count and count > 1 then
                return select(2, GetContainerItemInfo(bag, slot)) >= count
            else return true end
        end
    end
    return false
end

-------------------------------------------------------------------------------
------------------------------ DATABASE FUNCTIONS -----------------------------
-------------------------------------------------------------------------------

local function GetDatabaseTable(...)
    local db = _G["HandyNotes_CoreDB"]
    for _, key in ipairs({...}) do
        if db[key] == nil then db[key] = {} end
        db = db[key]
    end
    return db
end

-------------------------------------------------------------------------------
------------------------------ LOCALE FUNCTIONS -------------------------------
-------------------------------------------------------------------------------

--[[

Wrap the AceLocale NewLocale() function to return a slightly modified locale
table. This table will ignore assignments of `nil`, allowing locales to include
noop translation lines in their files without overriding the default enUS
strings. This allows us to keep all the locale files in sync with the exact
same keys in the exact same order even before actual translations are done.

--]]

--[[local AceLocale = LibStub("AceLocale-3.0")
local LOCALES = {}

local function NewLocale (locale)
    if LOCALES[locale] then return LOCALES[locale] end
    local L = AceLocale:NewLocale("HandyNotes_Core", locale, (locale == 'enUS'), true)
    if not L then return end
    local wrapper = {}
    setmetatable(wrapper, {
        __index = function (self, key) return L[key] end,
        __newindex = function (self, key, value)
            if value == nil then return end
            L[key] = value
        end
    })
    return wrapper
end]]

-------------------------------------------------------------------------------
------------------------------ TABLE CONVERTERS -------------------------------
-------------------------------------------------------------------------------

local function AsTable (value, class)
    -- normalize to table of scalars
    if type(value) == 'nil' then return end
    if type(value) ~= 'table' then return {value} end
    if class and Core.IsInstance(value, class) then return {value} end
    return value
end

local function AsIDTable (value)
    -- normalize to table of id objects
    if type(value) == 'nil' then return end
    if type(value) ~= 'table' then return {{id=value}} end
    if value.id then return {value} end
    for i, v in ipairs(value) do
        if type(v) == 'number' then value[i] = {id=v} end
    end
    return value
end

-------------------------------------------------------------------------------

Core.AsIDTable = AsIDTable
Core.AsTable = AsTable
Core.GetDatabaseTable = GetDatabaseTable
Core.NameResolver = NameResolver
--Core.NewLocale = NewLocale
Core.PlayerHasItem = PlayerHasItem
Core.PrepareLinks = PrepareLinks
Core.RenderLinks = RenderLinks




-------------------------------------------------------------------------------
------------------------------------ CLASS ------------------------------------
-------------------------------------------------------------------------------

Core.Class = function (name, parent, attrs)
    if type(name) ~= 'string' then error('name param must be a string') end
    if parent and not Core.IsClass(parent) then error('parent param must be a class') end

    local Class = attrs or {}
    Class.getters = Class.getters or {}
    Class.setters = Class.setters or {}

    local instance_metatable = {
        __tostring = function (self)
            return '<'..name..' instance at '..self.__address..'>'
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
    }

    setmetatable(Class, {
        __call = function (self, ...)
            local instance = {}
            instance.__class = Class
            instance.__address = tostring(instance):gsub("table: ", "", 1)
            setmetatable(instance, instance_metatable)
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

Core.IsClass = function (class)
    return type(class) == 'table' and class.getters and class.setters
end

Core.IsInstance = function (instance, class)
    if type(instance) ~= 'table' then return false end
    local function compare (c1, c2)
        if c2 == nil then return false end
        if c1 == c2 then return true end
        return compare(c1, c2.__parent)
    end
    return compare(class, instance.__class)
end

Core.Clone = function (instance, newattrs)
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


local Addon = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_Core","AceBucket-3.0", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes")
if not HandyNotes then return end

Core.addon = Addon
Core.locale = L
Core.maps = {}

_G["HandyNotes_Core"] = Addon

-------------------------------------------------------------------------------
----------------------------------- HELPERS -----------------------------------
-------------------------------------------------------------------------------

local DropdownMenu = CreateFrame("Frame", "HandyNotes_CoreDropdownMenu")
DropdownMenu.displayMode = "MENU"
local function InitializeDropdownMenu(level, mapID, coord)
    if not level then return end
    local node = Core.maps[mapID].nodes[coord]
    local spacer = {text='', disabled=1, notClickable=1, notCheckable=1}

    if (level == 1) then
        UIDropDownMenu_AddButton({
            text=Core.plugin_name, isTitle=1, notCheckable=1
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
                        title = Core.RenderLinks(node.label, true),
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
                Addon.db.char[mapID..'_coord_'..coord] = true
                Addon:Refresh()
            end
        }, level)

        UIDropDownMenu_AddButton({
            text=L["context_menu_restore_hidden_nodes"], notCheckable=1,
            func=function ()
                wipe(Addon.db.char)
                Addon:Refresh()
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

function Addon:OnEnter(mapID, coord)
    local map = Core.maps[mapID]
    local node = map.nodes[coord]

    if self:GetCenter() > UIParent:GetCenter() then
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    end

    node:Render(GameTooltip, map:CanFocus(node))
    map:SetFocus(node, true, true)
    Core.MinimapDataProvider:RefreshAllData()
    Core.WorldMapDataProvider:RefreshAllData()
    GameTooltip:Show()
end

function Addon:OnLeave(mapID, coord)
    local map = Core.maps[mapID]
    local node = map.nodes[coord]
    map:SetFocus(node, false, true)
    Core.MinimapDataProvider:RefreshAllData()
    Core.WorldMapDataProvider:RefreshAllData()
    GameTooltip:Hide()
end

function Addon:OnClick(button, down, mapID, coord)
    local map = Core.maps[mapID]
    local node = map.nodes[coord]
    if button == "RightButton" and down then
        DropdownMenu.initialize = function (_, level)
            InitializeDropdownMenu(level, mapID, coord)
        end
        ToggleDropDownMenu(1, nil, DropdownMenu, self, 0, 0)
    elseif button == "LeftButton" and down then
        if map:CanFocus(node) then
            map:SetFocus(node, not node._focus)
            Addon:Refresh()
        end
    end
end

function Addon:OnInitialize()
    Core.class = select(2, UnitClass('player'))
    Core.faction = UnitFactionGroup('player')
    self.db = LibStub("AceDB-3.0"):New('HandyNotes_CoreDB', Core.optionDefaults, "Default")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", function ()
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        self:ScheduleTimer("RegisterWithHandyNotes", 1)
    end)

    -- Add global groups to settings panel
    Core.CreateGlobalGroupOptions()

    -- Add quick-toggle menu button to top-right corner of world map
    local template = "HandyNotes_CoreWorldMapOptionsButtonTemplate"
    Core.world_map_button = LibStub("Krowi_WorldMapButtons-1.0"):Add(template, "DROPDOWNTOGGLEBUTTON")

    -- Query localized expansion title
    if not Core.expansion then error('Expansion not set: HandyNotes_Core') end
    local expansion_name = EJ_GetTierInfo(Core.expansion)
    Core.plugin_name = 'HandyNotes: '..expansion_name
    Core.options.name = ('%02d - '):format(Core.expansion)..expansion_name
end

-------------------------------------------------------------------------------
------------------------------------ MAIN -------------------------------------
-------------------------------------------------------------------------------

function Addon:RegisterWithHandyNotes()
    do
        local map, minimap, force
        local function iter(nodes, precoord)
            if not nodes then return nil end
            if minimap and Core:GetOpt('hide_minimap') then return nil end
            local coord, node = next(nodes, precoord)
            while coord do -- Have we reached the end of this zone?
                if node and (force or map:IsNodeEnabled(node, coord, minimap)) then
                    local icon, scale, alpha = node:GetDisplayInfo(map.id, minimap)
                    return coord, nil, icon, scale, alpha
                end
                coord, node = next(nodes, coord) -- Get next node
            end
            return nil, nil, nil, nil
        end
        function Addon:GetNodes2(mapID, _minimap)
            if Core:GetOpt('show_debug_map') then
                Core.Debug('Loading nodes for map: '..mapID..' (minimap='..tostring(_minimap)..')')
            end

            map = Core.maps[mapID]
            minimap = _minimap
            force = Core:GetOpt('force_nodes') or Core.dev_force

            if map then
                map:Prepare()
                return iter, map.nodes, nil
            end

            -- mapID not handled by this plugin
            return iter, nil, nil
        end
    end

    if Core:GetOpt('development') then
        Core.BootstrapDevelopmentEnvironment()
    end

    HandyNotes:RegisterPluginDB("HandyNotes_Core", self, Core.options)

    -- Refresh in any cases where node status may have changed
    self:RegisterBucketEvent({
        "BAG_UPDATE",
        "CRITERIA_EARNED",
        "CRITERIA_UPDATE",
        "LOOT_CLOSED",
        "PLAYER_MONEY",
        "SHOW_LOOT_TOAST",
        "SHOW_LOOT_TOAST_UPGRADE",
        "QUEST_TURNED_IN",
        "ZONE_CHANGED_NEW_AREA"
    }, 2, "Refresh")

    -- Also refresh whenever the size of the world map frame changes
    hooksecurefunc(WorldMapFrame, 'OnFrameSizeChanged', function ()
        self:Refresh()
    end)

    self:Refresh()
end

function Addon:Refresh()
    if self._refreshTimer then return end
    self._refreshTimer = C_Timer.NewTimer(0.1, function ()
        self._refreshTimer = nil
        self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_Core")
        Core.MinimapDataProvider:RefreshAllData()
        Core.WorldMapDataProvider:RefreshAllData()
    end)
end

-------------------------------------------------------------------------------
-------------------------------- ICONS & GLOWS --------------------------------
-------------------------------------------------------------------------------

local ICONS = "Interface\\Addons\\HandyNotes\\Icons\\artwork\\icons"
local GLOWS = "Interface\\Addons\\HandyNotes\\Icons\\artwork\\glows"

local function Icon(name) return ICONS..'\\'..name..'.blp' end
local function Glow(name) return GLOWS..'\\'..name..'.blp' end

local DEFAULT_ICON = 454046
local DEFAULT_GLOW = Glow('square_icon')

Core.icons = { -- name => path

    -- Red, Blue, Yellow, Purple, Green, Pink, Lime, Navy, Teal
    chest_bk = {Icon('chest_black'), Glow('chest')},
    chest_bl = {Icon('chest_blue'), Glow('chest')},
    chest_bn = {Icon('chest_brown'), Glow('chest')},
    chest_gn = {Icon('chest_green'), Glow('chest')},
    chest_gy = {Icon('chest_gray'), Glow('chest')},
    chest_lm = {Icon('chest_lime'), Glow('chest')},
    chest_nv = {Icon('chest_navy'), Glow('chest')},
    chest_pk = {Icon('chest_pink'), Glow('chest')},
    chest_pp = {Icon('chest_purple'), Glow('chest')},
    chest_rd = {Icon('chest_red'), Glow('chest')},
    chest_tl = {Icon('chest_teal'), Glow('chest')},
    chest_yw = {Icon('chest_yellow'), Glow('chest')},

    crystal_b = {Icon('crystal_blue'), Glow('crystal')},
    crystal_o = {Icon('crystal_orange'), Glow('crystal')},
    crystal_p = {Icon('crystal_purple'), Glow('crystal')},

    flight_point_g = {Icon('flight_point_gray'), Glow('flight_point')},
    flight_point_y = {Icon('flight_point_yellow'), Glow('flight_point')},

    horseshoe_b = {Icon('horseshoe_black'), Glow('horseshoe')},
    horseshoe_g = {Icon('horseshoe_gray'), Glow('horseshoe')},
    horseshoe_o = {Icon('horseshoe_orange'), Glow('horseshoe')},

    paw_g = {Icon('paw_green'), Glow('paw')},
    paw_y = {Icon('paw_yellow'), Glow('paw')},

    peg_bl = {Icon('peg_blue'), Glow('peg')},
    peg_bk = {Icon('peg_black'), Glow('peg')},
    peg_gn = {Icon('peg_green'), Glow('peg')},
    peg_rd = {Icon('peg_red'), Glow('peg')},
    peg_yw = {Icon('peg_yellow'), Glow('peg')},

    portal_bl = {Icon('portal_blue'), Glow('portal')},
    portal_gy = {Icon('portal_gray'), Glow('portal')},
    portal_gn = {Icon('portal_green'), Glow('portal')},
    portal_pp = {Icon('portal_purple'), Glow('portal')},
    portal_rd = {Icon('portal_red'), Glow('portal')},
    
    quest_ab = {Icon('quest_available_blue'), Glow('quest_available')},
    quest_ag = {Icon('quest_available_green'), Glow('quest_available')},
    quest_ao = {Icon('quest_available_orange'), Glow('quest_available')},
    quest_ay = {Icon('quest_available_yellow'), Glow('quest_available')},

    skull_b = {Icon('skull_blue'), Glow('skull')},
    skull_w = {Icon('skull_white'), Glow('skull')},

    star_chest_b = {Icon('star_chest_blue'), Glow('star_chest')},
    star_chest_g = {Icon('star_chest_gray'), Glow('star_chest')},
    star_chest_p = {Icon('star_chest_pink'), Glow('star_chest')},
    star_chest_y = {Icon('star_chest_yellow'), Glow('star_chest')},

    war_mode_flags = {Icon('war_mode_flags'), nil},
    war_mode_swords = {Icon('war_mode_swords'), nil},

    ------------------------------ MISCELLANEOUS ------------------------------

    alliance = {Icon('alliance'), nil},
    horde = {Icon('horde'), nil},

    achievement = {Icon('achievement'), nil},
    door_down = {Icon('door_down'), Glow('door_down')},
    envelope = {Icon('envelope'), Glow('envelope')},
    left_mouse = {Icon('left_mouse'), nil},
    scroll = {Icon('scroll'), Glow('scroll')},
    world_quest = {Icon('world_quest'), Glow('world_quest')},

}

-------------------------------------------------------------------------------
------------------------------- HELPER FUNCTIONS ------------------------------
-------------------------------------------------------------------------------

local function GetIconPath(name)
    if type(name) == 'number' then return name end
    local info = Core.icons[name]
    return info and info[1] or DEFAULT_ICON
end

local function GetIconLink(name, size, offsetX, offsetY)
    local link = "|T"..GetIconPath(name)..":"..size..":"..size
    if offsetX and offsetY then
        link = link..':'..offsetX..':'..offsetY
    end
    return link.."|t"
end

local function GetGlowPath(name)
    if type(name) == 'number' then return DEFAULT_GLOW end
    local info = Core.icons[name]
    return info and info[2] or nil
end

Core.GetIconLink = GetIconLink
Core.GetIconPath = GetIconPath
Core.GetGlowPath = GetGlowPath

-------------------------------------------------------------------------------
---------------------------------- DEFAULTS -----------------------------------
-------------------------------------------------------------------------------

Core.optionDefaults = {
    profile = {
        show_worldmap_button = true,
        -- visibility
        hide_done_rares = false,
        hide_minimap = false,
        maximized_enlarged = true,
        show_completed_nodes = false,
        use_char_achieves = false,
        per_map_settings = false,

        -- tooltip
        show_loot = true,
        show_notes = true,

        -- rewards
        show_mount_rewards = true,
        show_pet_rewards = true,
        show_toy_rewards = true,
        show_transmog_rewards = true,
        show_all_transmog_rewards = false,
        
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

function Core:GetOpt(n) return Core.addon.db.profile[n] end
function Core:SetOpt(n, v) Core.addon.db.profile[n] = v; Core.addon:Refresh() end

function Core:GetColorOpt(n)
    local db = Core.addon.db.profile
    return db[n..'_R'], db[n..'_G'], db[n..'_B'], db[n..'_A']
end

function Core:SetColorOpt(n, r, g, b, a)
    local db = Core.addon.db.profile
    db[n..'_R'], db[n..'_G'], db[n..'_B'], db[n..'_A'] = r, g, b, a
    Core.addon:Refresh()
end

-------------------------------------------------------------------------------
--------------------------------- OPTIONS UI ----------------------------------
-------------------------------------------------------------------------------

Core.options = {
    type = "group",
    name = nil, -- populated in core.lua
    childGroups = "tab",
    get = function(info) return Core:GetOpt(info.arg) end,
    set = function(info, v) Core:SetOpt(info.arg, v) end,
    args = {
        GeneralTab = {
            type = "group",
            name = L["options_general_settings"],
            desc = L["options_general_description"],
            order = 0,
            args = {
                GeneralHeader = {
                    type = "header",
                    name = L["options_general_settings"],
                    order = 1,
                },
                show_worldmap_button = {
                    type = "toggle",
                    arg = "show_worldmap_button",
                    name = L["options_show_worldmap_button"],
                    desc = L["options_show_worldmap_button_desc"],
                    set = function(info, v)
                        Core:SetOpt(info.arg, v)
                        Core.world_map_button:Refresh()
                    end,
                    order = 2,
                    width = "full",
                },
                maximized_enlarged = {
                    type = "toggle",
                    arg = "maximized_enlarged",
                    name = L["options_toggle_maximized_enlarged"],
                    desc = L["options_toggle_maximized_enlarged_desc"],
                    order = 3,
                    width = "full",
                },
                per_map_settings = {
                    type = "toggle",
                    arg = "per_map_settings",
                    name = L["options_toggle_per_map_settings"],
                    desc = L["options_toggle_per_map_settings_desc"],
                    order = 4,
                    width = "full",
                },
                RewardsHeader = {
                    type = "header",
                    name = L["options_rewards_settings"],
                    order = 10,
                },
                show_mount_rewards = {
                    type = "toggle",
                    arg = "show_mount_rewards",
                    name = L["options_mount_rewards"],
                    desc = L["options_mount_rewards_desc"],
                    order = 11,
                    width = "full",
                },
                show_pet_rewards = {
                    type = "toggle",
                    arg = "show_pet_rewards",
                    name = L["options_pet_rewards"],
                    desc = L["options_pet_rewards_desc"],
                    order = 11,
                    width = "full",
                },
                show_toy_rewards = {
                    type = "toggle",
                    arg = "show_toy_rewards",
                    name = L["options_toy_rewards"],
                    desc = L["options_toy_rewards_desc"],
                    order = 11,
                    width = "full",
                },
                show_transmog_rewards = {
                    type = "toggle",
                    arg = "show_transmog_rewards",
                    name = L["options_transmog_rewards"],
                    desc = L["options_transmog_rewards_desc"],
                    order = 11,
                    width = "full",
                },
                show_all_transmog_rewards = {
                    type = "toggle",
                    arg = "show_all_transmog_rewards",
                    name = L["options_all_transmog_rewards"],
                    desc = L["options_all_transmog_rewards_desc"],
                    order = 12,
                    width = "full",
                },
                VisibilityHeader = {
                    type = "header",
                    name = L["options_visibility_settings"],
                    order = 20,
                },
                show_completed_nodes = {
                    type = "toggle",
                    arg = "show_completed_nodes",
                    name = L["options_show_completed_nodes"],
                    desc = L["options_show_completed_nodes_desc"],
                    order = 21,
                    width = "full",
                },
                hide_done_rare = {
                    type = "toggle",
                    arg = "hide_done_rares",
                    name = L["options_toggle_hide_done_rare"],
                    desc = L["options_toggle_hide_done_rare_desc"],
                    order = 22,
                    width = "full",
                },
                hide_minimap = {
                    type = "toggle",
                    arg = "hide_minimap",
                    name = L["options_toggle_hide_minimap"],
                    desc = L["options_toggle_hide_minimap_desc"],
                    order = 23,
                    width = "full",
                },
                use_char_achieves = {
                    type = "toggle",
                    arg = "use_char_achieves",
                    name = L["options_toggle_use_char_achieves"],
                    desc = L["options_toggle_use_char_achieves_desc"],
                    order = 24,
                    width = "full",
                },
                restore_all_nodes = {
                    type = "execute",
                    name = L["options_restore_hidden_nodes"],
                    desc = L["options_restore_hidden_nodes_desc"],
                    order = 25,
                    width = "full",
                    func = function ()
                        wipe(Core.addon.db.char)
                        Core.addon:Refresh()
                    end
                },
                FocusHeader = {
                    type = "header",
                    name = L["options_focus_settings"],
                    order = 30,
                },
                POI_scale = {
                    type = "range",
                    name = L["options_scale"],
                    desc = L["options_scale_desc"],
                    min = 1, max = 3, step = 0.01,
                    arg = "poi_scale",
                    width = "full",
                    order = 31,
                },
                POI_color = {
                    type = "color",
                    name = L["options_poi_color"],
                    desc = L["options_poi_color_desc"],
                    hasAlpha = true,
                    set = function(_, ...) Core:SetColorOpt('poi_color', ...) end,
                    get = function() return Core:GetColorOpt('poi_color') end,
                    order = 32,
                },
                PATH_color = {
                    type = "color",
                    name = L["options_path_color"],
                    desc = L["options_path_color_desc"],
                    hasAlpha = true,
                    set = function(_, ...) Core:SetColorOpt('path_color', ...) end,
                    get = function() return Core:GetColorOpt('path_color') end,
                    order = 33,
                },
                restore_poi_colors = {
                    type = "execute",
                    name = L["options_reset_poi_colors"],
                    desc = L["options_reset_poi_colors_desc"],
                    order = 34,
                    width = "full",
                    func = function ()
                        local df = Core.optionDefaults.profile
                        Core:SetColorOpt('poi_color', df.poi_color_R, df.poi_color_G, df.poi_color_B, df.poi_color_A)
                        Core:SetColorOpt('path_color', df.path_color_R, df.path_color_G, df.path_color_B, df.path_color_A)
                    end
                },
                TooltipsHeader = {
                    type = "header",
                    name = L["options_tooltip_settings"],
                    order = 40,
                },
                show_loot = {
                    type = "toggle",
                    arg = "show_loot",
                    name = L["options_toggle_show_loot"],
                    desc = L["options_toggle_show_loot_desc"],
                    order = 41,
                },
                show_notes = {
                    type = "toggle",
                    arg = "show_notes",
                    name = L["options_toggle_show_notes"],
                    desc = L["options_toggle_show_notes_desc"],
                    order = 42,
                }
            }
        },
        GlobalTab = {
            type = "group",
            name = L["options_global"],
            desc = L["options_global_description"],
            disabled = function () return Core:GetOpt('per_map_settings') end,
            order = 1,
            args = {}
        },
        ZonesTab = {
            type = "group",
            name = L["options_zones"],
            desc = L["options_zones_description"],
            childGroups = "select",
            order = 2,
            args = {}
        }
    }
}

-- Display these groups in the global settings tab. They are the most common
-- group options that players might want to customize.

function Core.CreateGlobalGroupOptions()
    for i, group in ipairs({
        Core.groups.RARE,
        Core.groups.TREASURE,
        Core.groups.PETBATTLE,
        Core.groups.MISC
    }) do
        Core.options.args.GlobalTab.args['group_icon_'..group.name] = {
            type = "header",
            name = function () return Core.RenderLinks(group.label, true) end,
            order = i * 10,
        }

        Core.options.args.GlobalTab.args['icon_scale_'..group.name] = {
            type = "range",
            name = L["options_scale"],
            desc = L["options_scale_desc"],
            min = 0.3, max = 3, step = 0.01,
            arg = group.scaleArg,
            width = 1.13,
            order = i * 10 + 1,
        }

        Core.options.args.GlobalTab.args['icon_alpha_'..group.name] = {
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

function Core.CreateGroupOptions (map, group)
    -- Check if we've already initialized this group
    if _INITIALIZED[group.name..map.id] then return end
    _INITIALIZED[group.name..map.id] = true

    -- Check if map info exists (ignore if PTR/beta zone)
    local map_info = C_Map.GetMapInfo(map.id)
    if not map_info then return end

    -- Create map options group under zones tab
    local options = Core.options.args.ZonesTab.args['Zone_'..map.id]
    if not options then
        options = {
            type = "group",
            name = map_info.name,
            args = {
                OpenWorldMap = {
                    type = "execute",
                    name = L["options_open_world_map"],
                    desc = L["options_open_world_map_desc"],
                    order = 1,
                    width = "full",
                    func = function ()
                        if not WorldMapFrame:IsShown() then
                            InterfaceOptionsFrame:Hide()
                            HideUIPanel(GameMenuFrame)
                        end
                        OpenWorldMap(map.id)
                    end
                },
                IconsGroup = {
                    type = "group",
                    name = L["options_icon_settings"],
                    inline = true,
                    order = 2,
                    args = {}
                },
                VisibilityGroup = {
                    type = "group",
                    name = L["options_visibility_settings"],
                    inline = true,
                    order = 3,
                    args = {}
                }
            }
        }
        Core.options.args.ZonesTab.args['Zone_'..map.id] = options
    end

    map._icons_order = map._icons_order or 0
    map._visibility_order = map._visibility_order or 0

    options.args.IconsGroup.args["icon_toggle_"..group.name] = {
        type = "toggle",
        get = function () return group:GetDisplay(map.id) end,
        set = function (info, v) group:SetDisplay(v, map.id) end,
        name = function () return Core.RenderLinks(group.label, true) end,
        desc = function () return Core.RenderLinks(group.desc) end,
        disabled = function () return not group:IsEnabled() end,
        width = 0.9,
        order = map._icons_order
    }

    options.args.VisibilityGroup.args["header_"..group.name] = {
        type = "header",
        name = function () return Core.RenderLinks(group.label, true) end,
        order = map._visibility_order
    }

    options.args.VisibilityGroup.args['icon_scale_'..group.name] = {
        type = "range",
        name = L["options_scale"],
        desc = L["options_scale_desc"],
        get = function () return group:GetScale(map.id) end,
        set = function (info, v) group:SetScale(v, map.id) end,
        disabled = function () return not (group:IsEnabled() and group:GetDisplay(map.id)) end,
        min = 0.3, max = 3, step = 0.01,
        width = 0.95,
        order = map._visibility_order + 1
    }

    options.args.VisibilityGroup.args['icon_alpha_'..group.name] = {
        type = "range",
        name = L["options_opacity"],
        desc = L["options_opacity_desc"],
        get = function () return group:GetAlpha(map.id) end,
        set = function (info, v) group:SetAlpha(v, map.id) end,
        disabled = function () return not (group:IsEnabled() and group:GetDisplay(map.id)) end,
        min = 0, max = 1, step = 0.01,
        width = 0.95,
        order = map._visibility_order + 2
    }

    map._icons_order = map._icons_order + 1
    map._visibility_order = map._visibility_order + 3
end


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

-- Register all addons objects for the CTRL+ALT handler
local plugins = "HandyNotes_ZarPlugins"
if _G[plugins] == nil then _G[plugins] = {} end
_G[plugins][#_G[plugins] + 1] = Core

local function BootstrapDevelopmentEnvironment()
    _G['HandyNotes_ZarPluginsDevelopment'] = true

    -- Add development settings to the UI
    Core.options.args.GeneralTab.args.DevelopmentHeader = {
        type = "header",
        name = L["options_dev_settings"],
        order = 100,
    }
    Core.options.args.GeneralTab.args.show_debug_map = {
        type = "toggle",
        arg = "show_debug_map",
        name = L["options_toggle_show_debug_map"],
        desc = L["options_toggle_show_debug_map_desc"],
        order = 101,
    }
    Core.options.args.GeneralTab.args.show_debug_quest = {
        type = "toggle",
        arg = "show_debug_quest",
        name = L["options_toggle_show_debug_quest"],
        desc = L["options_toggle_show_debug_quest_desc"],
        order = 102,
    }
    Core.options.args.GeneralTab.args.force_nodes = {
        type = "toggle",
        arg = "force_nodes",
        name = L["options_toggle_force_nodes"],
        desc = L["options_toggle_force_nodes_desc"],
        order = 103,
    }

    -- Print debug messages for each quest ID that is flipped
    local QTFrame = CreateFrame('Frame', "HandyNotes_CoreQT")
    local history = Core.GetDatabaseTable('quest_id_history')
    local lastCheck = GetTime()
    local quests = {}
    local changed = {}
    local max_quest_id = 100000

    local function DebugQuest(...)
        if Core:GetOpt('show_debug_quest') then Core.Debug(...) end
    end

    C_Timer.After(2, function ()
        -- Give some time for quest info to load in before we start
        for id = 0, max_quest_id do quests[id] = C_QuestLog.IsQuestFlaggedCompleted(id) end
        QTFrame:SetScript('OnUpdate', function ()
            if GetTime() - lastCheck > 1 and Core:GetOpt('show_debug_quest') then
                for id = 0, max_quest_id do
                    local s = C_QuestLog.IsQuestFlaggedCompleted(id)
                    if s ~= quests[id] then
                        changed[#changed + 1] = {time(), id, quests[id], s}
                        quests[id] = s
                    end
                end
                if #changed <= 10 then
                    -- changing zones will sometimes cause thousands of quest
                    -- ids to flip state, we do not want to report on those
                    for i, args in ipairs(changed) do
                        table.insert(history, 1, args)
                        DebugQuest('Quest', args[2], 'changed:', args[3], '=>', args[4])
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
    local IQFrame = CreateFrame('Frame', "HandyNotes_CoreIQ", WorldMapFrame)
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

    -- Slash commands
    SLASH_PETID1 = "/petid"
    SlashCmdList["PETID"] = function(name)
        if #name == 0 then return print('Usage: /petid NAME') end
        local petid = C_PetJournal.FindPetIDByName(name)
        if petid then
            print(name..": "..petid)
        else
            print("NO MATCH FOR: /petid "..name)
        end
    end

    SLASH_MOUNTID1 = "/mountid"
    SlashCmdList["MOUNTID"] = function(name)
        if #name == 0 then return print('Usage: /mountid NAME') end
        for i, m in ipairs(C_MountJournal.GetMountIDs()) do
            if (C_MountJournal.GetMountInfoByID(m) == name) then
                return print(name..": "..m)
            end
        end
        print("NO MATCH FOR: /mountid "..name)
    end

end

-------------------------------------------------------------------------------

-- Debug function that prints entries from the quest id history

_G['HandyNotes_CoreQuestHistory'] = function (count)
    local history = Core.GetDatabaseTable('quest_id_history')
    if #history == 0 then return print('Quest ID history is empty') end
    for i = 1, (count or 10) do
        if i > #history then break end
        local time, id, old, new, _
        if history[i][1] == 'Quest' then
            _, id, _, old, _, new = unpack(history[i])
            time = 'MISSING'
        else
            time, id, old, new = unpack(history[i])
            time = date('%H:%M:%S', time)
        end
        print(time, '::', id, '::', old, '=>', new)
    end
end

-------------------------------------------------------------------------------

-- Debug function that iterates over each pin template and removes it from the
-- map. This is helpful for determining which template a pin is coming from.

local hidden = {}
_G['HandyNotes_CoreRemovePins'] = function ()
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

function Core.Debug(...)
    if not Core.addon.db then return end
    if Core:GetOpt('development') then print(Core.color.Blue('DEBUG:'), ...) end
end

function Core.Warn(...)
    if not Core.addon.db then return end
    if Core:GetOpt('development') then print(Core.color.Orange('WARN:'), ...) end
end

function Core.Error(...)
    if not Core.addon.db then return end
    if Core:GetOpt('development') then print(Core.color.Red('ERROR:'), ...) end
end

-------------------------------------------------------------------------------

_G['HandyNotes_CoreScanQuestObjectives'] = function (start, end_)
    local function attemptObjectiveInfo (quest, index)
        local text, objectiveType, finished, fulfilled = GetQuestObjectiveInfo(quest, index, true)
        if text or objectiveType or finished or fulfilled then
            print(quest, index, text, objectiveType, finished, fulfilled)
        end
    end

    for i = start, end_, 1 do
        for j = 0, 10, 1 do
            attemptObjectiveInfo(i, j)
        end
    end
end

-------------------------------------------------------------------------------
Core.BootstrapDevelopmentEnvironment = BootstrapDevelopmentEnvironment


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local Class = Core.Class

local HBD = LibStub("HereBeDragons-2.0")
local HBDPins = LibStub("HereBeDragons-Pins-2.0")

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
    self.fgroups = {}
    self.settings = self.settings or false

    setmetatable(self.nodes, {
        __newindex = function (nodes, coord, node)
            self:AddNode(coord, node)
        end
    })

    -- auto-register this map
    if Core.maps[self.id] then error('Map already registered: '..self.id) end
    Core.maps[self.id] = self
end

function Map:AddNode(coord, node)
    if not Core.IsInstance(node, Core.node.Node) then
        error(format('All nodes must be instances of the Node() class: %d %s', coord, tostring(node)))
    end

    if node.fgroup then
        if not self.fgroups[node.fgroup] then self.fgroups[node.fgroup] = {} end
        local fgroup = self.fgroups[node.fgroup]
        fgroup[#fgroup + 1] = coord
    end

    if node.group ~= Core.groups.QUEST then
        -- Initialize group defaults and UI controls for this map if the group does
        -- not inherit its settings and defaults from a parent map
        if self.settings then Core.CreateGroupOptions(self, node.group) end

        -- Keep track of all groups associated with this map
        if not self.groups[node.group.name] then
            self.groups[#self.groups + 1] = node.group
            self.groups[node.group.name] = true
        end
    end

    rawset(self.nodes, coord, node)

    -- Add node to each parent map ID requested
    if node.parent then
        -- Calculate world coordinates for the node
        local x, y = HandyNotes:getXY(coord)
        local wx, wy = HBD:GetWorldCoordinatesFromZone(x, y, self.id)
        if not (wx and wy) then
            error(format('Missing world coords: (%d: %d) => ???', self.id, coord))
        end
        for i, parent in ipairs(node.parent) do
            -- Calculate parent zone coordinates and add node
            local px, py = HBD:GetZoneCoordinatesFromWorld(wx, wy, parent.id)
            if not (px and py) then
                error(format('Missing map coords: (%d: %d) => (%d: ???)', self.id, coord, parent.id))
            end
            local map = Core.maps[parent.id] or Map({id=parent.id})
            map.nodes[HandyNotes:getCoord(px, py)] = Core.Clone(node, {pois=(parent.pois or false)})
        end
    end
end

function Map:HasEnabledGroups()
    for i, group in ipairs(self.groups) do
        if group:IsEnabled() then return true end
    end
    return false
end

function Map:CanFocus(node)
    if node.focusable then return true end
    if type(node.pois) == 'table' then return true end
    if node.fgroup then
        for i, coord in ipairs(self.fgroups[node.fgroup]) do
            if type(self.nodes[coord].pois) == 'table' then return true end
        end
    end
    return false
end

function Map:CanDisplay(node, coord, minimap)
    -- Check if the zone is still phased
    if node ~= self.intro and not self.phased then return false end

    -- Minimap may be disabled for this node
    if not node.minimap and minimap then return false end

    -- Node may be faction restricted
    if node.faction and node.faction ~= Core.faction then return false end

    return true
end

function Map:IsNodeEnabled(node, coord, minimap)
    local db = Core.addon.db

    -- Check for dev force enable
    if Core:GetOpt('force_nodes') or Core.dev_force then return true end

    -- Check if we've been hidden by the user
    if db.char[self.id..'_coord_'..coord] then return false end

    -- Check if the node is disabled in the current context
    if not self:CanDisplay(node, coord, minimap) then return false end

    -- Check if node's group is disabled
    if not node.group:IsEnabled() then return false end

    -- Check for prerequisites and quest (or custom) completion
    if not node:IsEnabled() then return false end

    -- Display the node based off the group display setting
    return node.group:GetDisplay(self.id)
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

function Map:SetFocus(node, state, hover)
    local attr = hover and '_hover' or '_focus'
    if node.fgroup then
        for i, coord in ipairs(self.fgroups[node.fgroup]) do
            self.nodes[coord][attr] = state
        end
    else
        node[attr] = state
    end
end

-------------------------------------------------------------------------------
---------------------------- MINIMAP DATA PROVIDER ----------------------------
-------------------------------------------------------------------------------

local MinimapPinsKey = "HandyNotes_CoreMinimapPins"
local MinimapDataProvider = CreateFrame("Frame", "HandyNotes_CoreMinimapDP")
local MinimapPinTemplate = 'HandyNotes_CoreMinimapPinTemplate'
local MinimapPinMixin = {}

_G['HandyNotes_CoreMinimapPinMixin'] = MinimapPinMixin

MinimapDataProvider.facing = GetPlayerFacing()
MinimapDataProvider.pins = {}
MinimapDataProvider.pool = {}
MinimapDataProvider.minimap = true
MinimapDataProvider.updateTimer = 0

function MinimapDataProvider:ReleaseAllPins()
    for i, pin in ipairs(self.pins) do
        if pin.acquired then
            self.pool[pin] = true
            pin.acquired = false
            pin:OnReleased()
            pin:Hide()
        end
    end
end

function MinimapDataProvider:AcquirePin(template, ...)
    local pin = next(self.pool)
    if pin then
        self.pool[pin] = nil -- remove it from the pool
    else
        pin = CreateFrame("Button", "HandyNotes_CorePin"..(#self.pins + 1), Minimap, template)
        pin.provider = self
        pin:OnLoad()
        pin:Hide()
        self.pins[#self.pins + 1] = pin
    end
    pin.acquired = true
    pin:OnAcquired(...)
end

function MinimapDataProvider:RefreshAllData()
    -- Skip refresh if rotate minimap is on and we failed to get a facing value
    if GetCVar('rotateMinimap') == '1' and self.facing == nil then return end

    HBDPins:RemoveAllMinimapIcons(MinimapPinsKey)
    self:ReleaseAllPins()

    local map = Core.maps[HBD:GetPlayerZone()]
    if not map then return end

    for coord, node in pairs(map.nodes) do
        if node._prepared and map:IsNodeEnabled(node, coord, true) then
            -- If this icon has a glow enabled, render it
            local glow = node:GetGlow(map.id, true)
            if glow then
                glow[1] = coord -- update POI coord for this placement
                glow:Render(self, MinimapPinTemplate)
            end

            -- Render any POIs this icon has registered
            if node.pois and (node._focus or node._hover) then
                for i, poi in ipairs(node.pois) do
                    if poi:IsEnabled() then
                        poi:Render(self, MinimapPinTemplate)
                    end
                end
            end
        end
    end
end

function MinimapDataProvider:RefreshAllRotations()
    for i, pin in ipairs(self.pins) do
        if pin.acquired then pin:UpdateRotation() end
    end
end

function MinimapDataProvider:OnUpdate()
    local facing = GetPlayerFacing()
    if facing ~= self.facing then
        self.facing = facing
        self:RefreshAllRotations()
        self.updateTimer = 0
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
    if GetCVar('rotateMinimap') == '1' then self:UpdateRotation() end
    HBDPins:AddMinimapIconMap(MinimapPinsKey, self, mapID, x, y, true)
end

function MinimapPinMixin:OnReleased()
    if self.ticker then
        self.ticker:Cancel()
        self.ticker = nil
    end
end

function MinimapPinMixin:UpdateRotation()
    -- If the pin has a rotation, its original value will be stored in the
    -- `rotation` attribute. Update to accommodate player facing.
    if self.rotation == nil then return end
    self.texture:SetRotation(self.rotation + math.pi*2 - self.provider.facing)
end

MinimapDataProvider:SetScript('OnUpdate', function ()
    if GetCVar('rotateMinimap') == '1' then
        MinimapDataProvider:OnUpdate()
    end
end)

Core.addon:RegisterEvent('MINIMAP_UPDATE_ZOOM', function (...)
    MinimapDataProvider:RefreshAllData()
end)

Core.addon:RegisterEvent('CVAR_UPDATE', function (_, varname)
    if varname == 'ROTATE_MINIMAP' then
        MinimapDataProvider:RefreshAllData()
    end
end)

-------------------------------------------------------------------------------
--------------------------- WORLD MAP DATA PROVIDER ---------------------------
-------------------------------------------------------------------------------

local WorldMapDataProvider = CreateFromMixins(MapCanvasDataProviderMixin)
local WorldMapPinTemplate = 'HandyNotes_CoreWorldMapPinTemplate'
local WorldMapPinMixin = CreateFromMixins(MapCanvasPinMixin)

_G['HandyNotes_CoreWorldMapPinMixin'] = WorldMapPinMixin

function WorldMapDataProvider:RemoveAllData()
    if self:GetMap() then
        self:GetMap():RemoveAllPinsByTemplate(WorldMapPinTemplate)
    end
end

function WorldMapDataProvider:RefreshAllData(fromOnShow)
    self:RemoveAllData()

    if not self:GetMap() then return end
    local map = Core.maps[self:GetMap():GetMapID()]
    if not map then return end

    for coord, node in pairs(map.nodes) do
        if node._prepared and map:IsNodeEnabled(node, coord, false) then
            -- If this icon has a glow enabled, render it
            local glow = node:GetGlow(map.id, false)
            if glow then
                glow[1] = coord -- update POI coord for this placement
                glow:Render(self:GetMap(), WorldMapPinTemplate)
            end

            -- Render any POIs this icon has registered
            if node.pois and (node._focus or node._hover) then
                for i, poi in ipairs(node.pois) do
                    if poi:IsEnabled() then
                        poi:Render(self:GetMap(), WorldMapPinTemplate)
                    end
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

Core.Map = Map
Core.MinimapDataProvider = MinimapDataProvider
Core.WorldMapDataProvider = WorldMapDataProvider


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local L = Core.locale
local Class = Core.Class

-------------------------------------------------------------------------------
------------------------------------ GROUP ------------------------------------
-------------------------------------------------------------------------------

local Group = Class('Group')

function Group:Initialize(name, icon, attrs)
    if not name then error('Groups must be initialized with a name!') end
    if not icon then error('Groups must be initialized with an icon!') end

    self.name = name
    self.icon = icon

    self.label = L["options_icons_"..name]
    self.desc = L["options_icons_"..name.."_desc"]

    -- Prepare any links in this group label/description
    Core.PrepareLinks(self.label)
    Core.PrepareLinks(self.desc)

    if attrs then
        for k, v in pairs(attrs) do self[k] = v end
    end

    self.alphaArg = 'icon_alpha_'..self.name
    self.scaleArg = 'icon_scale_'..self.name
    self.displayArg = 'icon_display_'..self.name

    if not self.defaults then self.defaults = {} end
    self.defaults.alpha = self.defaults.alpha or 1
    self.defaults.scale = self.defaults.scale or 1
    self.defaults.display = self.defaults.display ~= false
end

function Group:HasEnabledNodes(map)
    for coord, node in pairs(map.nodes) do
        if node.group == self and map:CanDisplay(node, coord) then
            return true
        end
    end
    return false
end

-- Override to hide this group in the UI under certain circumstances
function Group:IsEnabled()
    if self.class and self.class ~= Core.class then return false end
    if self.faction and self.faction ~= Core.faction then return false end
    return true
end

function Group:_GetOpt (option, default, mapID)
    local value
    if Core:GetOpt('per_map_settings') then
        value = Core:GetOpt(option..'_'..mapID)
    else
        value = Core:GetOpt(option)
    end
    return (value == nil) and default or value
end

function Group:_SetOpt (option, value, mapID)
    if Core:GetOpt('per_map_settings') then
        return Core:SetOpt(option..'_'..mapID, value)
    end
    return Core:SetOpt(option, value)
end

-- Get group settings
function Group:GetAlpha(mapID) return self:_GetOpt(self.alphaArg, self.defaults.alpha, mapID) end
function Group:GetScale(mapID) return self:_GetOpt(self.scaleArg, self.defaults.scale, mapID) end
function Group:GetDisplay(mapID) return self:_GetOpt(self.displayArg, self.defaults.display, mapID) end

-- Set group settings
function Group:SetAlpha(v, mapID) self:_SetOpt(self.alphaArg, v, mapID) end
function Group:SetScale(v, mapID) self:_SetOpt(self.scaleArg, v, mapID) end
function Group:SetDisplay(v, mapID) self:_SetOpt(self.displayArg, v, mapID) end

-------------------------------------------------------------------------------

Core.Group = Group

Core.GROUP_HIDDEN = {display=false}
Core.GROUP_HIDDEN75 = {alpha=0.75, display=false}
Core.GROUP_ALPHA75 = {alpha=0.75}

Core.groups = {
    PETBATTLE = Group('pet_battles', 'paw_y'),
    QUEST = Group('quests', 'quest_ay'),
    RARE = Group('rares', 'skull_w', {defaults=Core.GROUP_ALPHA75}),
    TREASURE = Group('treasures', 'chest_gy', {defaults=Core.GROUP_ALPHA75}),
    MISC = Group('misc', 454046),
}

-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local Class = Core.Class

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

local Item = Class('Item', Requirement)

function Item:Initialize(id, count)
    self.id, self.count = id, count
    self.text = string.format('{item:%d}', self.id)
    if self.count and self.count > 1 then
        self.text = self.text..' x'..self.count
    end
end

function Item:IsMet()
    return Core.PlayerHasItem(self.id, self.count)
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
----------------------------------- WAR MODE ----------------------------------
-------------------------------------------------------------------------------

local WarMode = Class('WarMode', Requirement, {
    text = PVP_LABEL_WAR_MODE,
    IsMet = function () return C_PvP.IsWarModeActive() or C_PvP.IsWarModeDesired() end
})()

-------------------------------------------------------------------------------

Core.requirement = {
    Currency=Currency,
    GarrisonTalent=GarrisonTalent,
    Item=Item,
    Requirement=Requirement,
    Spell=Spell,
    WarMode=WarMode
}


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local L = Core.locale
local Class = Core.Class
local Group = Core.Group
local IsInstance = Core.IsInstance
local Requirement = Core.requirement.Requirement

-------------------------------------------------------------------------------
------------------------------------ NODE -------------------------------------
-------------------------------------------------------------------------------

--[[

Base class for all displayed nodes.

    label (string): Tooltip title for this node
    sublabel (string): Oneline string to display under label
    group (Group): Options group for this node (display, scale, alpha)
    fgroup (string): A category of nodes that should be focused together
    icon (string|number): The icon texture to display
    alpha (float): The default alpha value for this type
    scale (float): The default scale value for this type
    minimap (bool): Should the node be displayed on the minimap
    parent (int|int[]): Parent map IDs to display the node on
    quest (int|int[]): Quest IDs that cause this node to disappear
    questAny (boolean): Hide node if *any* quests are true (default *all*)
    questCount (boolean): Display completed quest count as rlabel
    questDeps (int|int[]): Quest IDs that must be true to appear
    requires (str|Requirement[]): Requirements to interact or unlock
    rewards (Reward[]): Array of rewards for this node
--]]

local Node = Class('Node', nil, {
    label = UNKNOWN,
    minimap = true,
    alpha = 1,
    scale = 1,
    icon = "default",
    group = Core.groups.MISC
})

function Node:Initialize(attrs)
    -- assign all attributes
    if attrs then
        for k, v in pairs(attrs) do self[k] = v end
    end

    -- normalize table values
    self.quest = Core.AsTable(self.quest)
    self.questDeps = Core.AsTable(self.questDeps)
    self.parent = Core.AsIDTable(self.parent)
    self.requires = Core.AsTable(self.requires, Requirement)

    -- ensure proper group is assigned
    if not IsInstance(self.group, Group) then
        error('group attribute must be a Group class instance: '..self.group)
    end
end

--[[
Return the associated texture, scale and alpha value to pass to HandyNotes
for this node.
--]]

function Node:GetDisplayInfo(mapID, minimap)
    local icon = Core.GetIconPath(self.icon)
    local scale = self.scale * self.group:GetScale(mapID)
    local alpha = self.alpha * self.group:GetAlpha(mapID)

    if not minimap and WorldMapFrame.isMaximized and Core:GetOpt('maximized_enlarged') then
        scale = scale * 1.3 -- enlarge on maximized world map
    end

    return icon, scale, alpha
end

--[[
Return the glow POI for this node. If the node is hovered or focused, a green
glow is applyed to help highlight the node.
--]]

function Node:GetGlow(mapID, minimap)
    if self.glow and (self._focus or self._hover) then
        local _, scale, alpha = self:GetDisplayInfo(mapID, minimap)
        self.glow.alpha = alpha
        self.glow.scale = scale
        if self._focus then
            self.glow.r, self.glow.g, self.glow.b = 0, 1, 0
        else
            self.glow.r, self.glow.g, self.glow.b = 1, 1, 0
        end
        return self.glow
    end
end

--[[
Return the "collected" status of this node. A node is collected if all
associated rewards have been obtained (achievements, toys, pets, mounts).
--]]

function Node:IsCollected()
    for reward in self:IterateRewards() do
        if reward:IsEnabled() and reward:IsObtainable() and not reward:IsObtained() then return false end
    end
    return true
end

--[[
Return the "completed" state of this node. A node is completed if any or all
associated quests have been completed. The behavior of any vs all is switched
with the `questAny` attribute (default: all).

This method can also be overridden to check for some other form of completion,
such as an achievement criteria.

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
Return true if this node should be displayed.
--]]

function Node:IsEnabled()
    -- Check prerequisites
    if not self:PrerequisiteCompleted() then return false end

    -- Check completed state
    if self.group == Core.groups.QUEST or not Core:GetOpt('show_completed_nodes') then
        if self:IsCompleted() then return false end
    end

    return true
end

--[[
Iterate over rewards that are enabled for this character.
--]]

function Node:IterateRewards()
    local index, reward = 0
    return function ()
        if not (self.rewards and #self.rewards) then return end
        repeat
            index = index + 1
            if index > #self.rewards then return end
            reward = self.rewards[index]
        until reward:IsEnabled()
        return reward
    end
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
Prepare this node for display by fetching localization information for anything
referenced in the text attributes of this node. This method is called when a
world map containing this node is opened.
--]]

function Node:Prepare()
    -- verify chosen icon exists
    if type(self.icon) == 'string' and Core.icons[self.icon] == nil then
        error('unknown icon: '..self.icon)
    end

    -- initialize glow POI (if glow icon available)

    if not self.glow then
        local icon = Core.GetGlowPath(self.icon)
        if icon then
            self.glow = Core.poi.Glow({ icon=icon })
        end
    end

    Core.PrepareLinks(self.label)
    Core.PrepareLinks(self.sublabel)
    Core.PrepareLinks(self.note)

    if self.requires then
        for i, req in ipairs(self.requires) do
            if IsInstance(req, Requirement) then
                Core.PrepareLinks(req:GetText())
            else
                Core.PrepareLinks(req)
            end
        end
    end

    if self.rewards then
        for i, reward in ipairs(self.rewards) do
            reward:Prepare()
        end
    end
end

--[[
Render this node onto the given tooltip. Many features are optional depending
on the attributes set on this specific node, such as setting an `rlabel` or
`sublabel` value.
--]]

function Node:Render(tooltip, focusable)
    -- render the label text with NPC names resolved
    tooltip:SetText(Core.RenderLinks(self.label, true))

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
        color = (count == #self.quest) and Core.status.Green or Core.status.Gray
        rlabel = rlabel..' '..color(tostring(count)..'/'..#self.quest)
    end

    if self.faction then
        rlabel = rlabel..' '..Core.GetIconLink(self.faction:lower(), 16, 1, -1)
    end

    if focusable then
        -- add an rlabel hint to use left-mouse to focus the node
        local focus = Core.GetIconLink('left_mouse', 12)..Core.status.Gray(L["focus"])
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
        tooltip:AddLine(Core.RenderLinks(self.sublabel, true), 1, 1, 1)
    end

    -- display item, spell or other requirements
    if self.requires then
        for i, req in ipairs(self.requires) do
            if IsInstance(req, Requirement) then
                color = req:IsMet() and Core.color.White or Core.color.Red
                text = color(L["Requires"]..' '..req:GetText())
            else
                text = Core.color.Red(L["Requires"]..' '..req)
            end
            tooltip:AddLine(Core.RenderLinks(text, true))
        end
    end

    -- additional text for the node to describe how to interact with the
    -- object or summon the rare
    if self.note and Core:GetOpt('show_notes') then
        if self.requires or self.sublabel then tooltip:AddLine(" ") end
        tooltip:AddLine(Core.RenderLinks(self.note), 1, 1, 1, true)
    end

    -- all rewards (achievements, pets, mounts, toys, quests) that can be
    -- collected or completed from this node
    if self.rewards and Core:GetOpt('show_loot') then
        local firstAchieve, firstOther = true, true
        for reward in self:IterateRewards() do

            -- Add a blank line between achievements and other rewards
            local isAchieve = IsInstance(reward, Core.reward.Achievement)
            local isSpacer = IsInstance(reward, Core.reward.Spacer)
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
--------------------------------- COLLECTIBLE ---------------------------------
-------------------------------------------------------------------------------

local Collectible = Class('Collectible', Node)

function Collectible.getters:label()
    if self.id then return ("{npc:%d}"):format(self.id) end
    if self.item then return ("{item:%d}"):format(self.item) end
    for reward in self:IterateRewards() do
        if IsInstance(reward, Core.reward.Achievement) then
            return GetAchievementCriteriaInfoByID(reward.id, reward.criteria[1].id) or UNKNOWN
        end
    end
    return UNKNOWN
end

function Collectible:IsCompleted()
    if self:IsCollected() then return true end
    return Node.IsCompleted(self)
end

-------------------------------------------------------------------------------
------------------------------------ INTRO ------------------------------------
-------------------------------------------------------------------------------

local Intro = Class('Intro', Node, {
    icon = 'quest_ay',
    scale = 3,
    group = Core.groups.QUEST,
    minimap = false
})

function Intro:Initialize(attrs)
    Node.Initialize(self, attrs)
    if self.quest then
        C_QuestLog.GetTitleForQuestID(self.quest[1]) -- fetch info from server
    end
end

function Intro.getters:label()
    if self.quest then
        return C_QuestLog.GetTitleForQuestID(self.quest[1]) or UNKNOWN
    end
    return UNKNOWN
end

-------------------------------------------------------------------------------
------------------------------------- NPC -------------------------------------
-------------------------------------------------------------------------------

local NPC = Class('NPC', Node)

function NPC:Initialize(attrs)
    Node.Initialize(self, attrs)
    if not self.id then error('id required for NPC nodes') end
end

function NPC.getters:label()
    return ("{npc:%d}"):format(self.id)
end

-------------------------------------------------------------------------------
---------------------------------- PETBATTLE ----------------------------------
-------------------------------------------------------------------------------

local PetBattle = Class('PetBattle', NPC, {
    icon = 'paw_y',
    scale = 1.2,
    group = Core.groups.PETBATTLE
})

-------------------------------------------------------------------------------
------------------------------------ QUEST ------------------------------------
-------------------------------------------------------------------------------

local Quest = Class('Quest', Node, {
    note = AVAILABLE_QUEST,
    group = Core.groups.QUEST
})

function Quest:Initialize(attrs)
    Node.Initialize(self, attrs)
    C_QuestLog.GetTitleForQuestID(self.quest[1]) -- fetch info from server
end

function Quest.getters:icon()
    return self.daily and 'quest_ab' or 'quest_ay'
end

function Quest.getters:label()
    return C_QuestLog.GetTitleForQuestID(self.quest[1]) or UNKNOWN
end

-------------------------------------------------------------------------------
------------------------------------ RARE -------------------------------------
-------------------------------------------------------------------------------

local Rare = Class('Rare', NPC, {
    scale = 1.2,
    group = Core.groups.RARE
})

function Rare.getters:icon()
    return self:IsCollected() and 'skull_w' or 'skull_b'
end

function Rare:IsEnabled()
    if Core:GetOpt('hide_done_rares') and self:IsCollected() then return false end
    return NPC.IsEnabled(self)
end

function Rare:GetGlow(mapID, minimap)
    local glow = NPC.GetGlow(self, mapID, minimap)
    if glow then return glow end

    if _G['HandyNotes_ZarPluginsDevelopment'] and not self.quest then
        local _, scale, alpha = self:GetDisplayInfo(mapID, minimap)
        self.glow.alpha = alpha
        self.glow.scale = scale
        self.glow.r, self.glow.g, self.glow.b = 1, 0, 0
        return self.glow
    end
end

-------------------------------------------------------------------------------
---------------------------------- TREASURE -----------------------------------
-------------------------------------------------------------------------------

local Treasure = Class('Treasure', Node, {
    icon = 'chest_gy',
    scale = 1.3,
    group = Core.groups.TREASURE
})

function Treasure.getters:label()
    for reward in self:IterateRewards() do
        if IsInstance(reward, Core.reward.Achievement) then
            return GetAchievementCriteriaInfoByID(reward.id, reward.criteria[1].id) or UNKNOWN
        end
    end
    return UNKNOWN
end

function Treasure:GetGlow(mapID, minimap)
    local glow = Node.GetGlow(self, mapID, minimap)
    if glow then return glow end

    if _G['HandyNotes_ZarPluginsDevelopment'] and not self.quest then
        local _, scale, alpha = self:GetDisplayInfo(mapID, minimap)
        self.glow.alpha = alpha
        self.glow.scale = scale
        self.glow.r, self.glow.g, self.glow.b = 1, 0, 0
        return self.glow
    end
end

-------------------------------------------------------------------------------

Core.node = {
    Node=Node,
    Collectible=Collectible,
    Intro=Intro,
    NPC=NPC,
    PetBattle=PetBattle,
    Quest=Quest,
    Rare=Rare,
    Treasure=Treasure
}


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------


local Class = Core.Class
local L = Core.locale

local Green = Core.status.Green
local Orange = Core.status.Orange
local Red = Core.status.Red

-------------------------------------------------------------------------------

local function Icon(icon) return '|T'..icon..':0:0:1:-1|t ' end

-- in zhCN’s built-in font, ARHei.ttf, the glyph of U+2022 <bullet> is missing.
-- use U+00B7 <middle dot> instead.
local bullet = (GetLocale() == "zhCN" and "→" or "?")

-------------------------------------------------------------------------------
----------------------------------- REWARD ------------------------------------
-------------------------------------------------------------------------------

local Reward = Class('Reward')

function Reward:Initialize(attrs)
    if attrs then
        for k, v in pairs(attrs) do self[k] = v end
    end
end

function Reward:IsEnabled()
    if self.class and self.class ~= Core.class then return false end
    if self.faction and self.faction ~= Core.faction then return false end
    if self.display_option and not Core:GetOpt(self.display_option) then return false end
    return true
end

function Reward:IsObtainable() return true end
function Reward:IsObtained() return true end

-- These functions drive the appearance of the tooltip
function Reward:GetLines() return function () end end
function Reward:GetCategoryIcon() end
function Reward:GetStatus() end
function Reward:GetText() return UNKNOWN end

function Reward:Prepare() end

function Reward:Render(tooltip)
    local text = self:GetText()
    local status = self:GetStatus()

    -- Add category icon (if registered)
    local icon = self:GetCategoryIcon()
    if text and icon then
        text = Icon(icon)..text
    end

    -- Add indent if requested
    if self.indent then
        text = '   '..text
    end

    -- Render main line and optional status
    if text and status then
        tooltip:AddDoubleLine(text, status)
    elseif text then
        tooltip:AddLine(text)
    end

    -- Render follow-up lines (example: achievement criteria)
    for text, status, r, g, b in self:GetLines() do
        if text and status then
            tooltip:AddDoubleLine(text, status, r, g, b)
        elseif text then
            tooltip:AddLine(text, r, g, b)
        end
    end
end

-------------------------------------------------------------------------------
----------------------------------- SECTION -----------------------------------
-------------------------------------------------------------------------------

local Section = Class('Section', Reward)

function Section:Initialize(title)
    self.title = title
end

function Section:IsEnabled() return true end

function Section:Prepare()
    Core.PrepareLinks(self.title)
end

function Section:Render(tooltip)
    tooltip:AddLine(Core.RenderLinks(self.title, true)..':')
end

-------------------------------------------------------------------------------
----------------------------------- SPACER ------------------------------------
-------------------------------------------------------------------------------

local Spacer = Class('Spacer', Reward)

function Spacer:IsEnabled() return true end

function Spacer:Render(tooltip)
    tooltip:AddLine(' ')
end

-------------------------------------------------------------------------------
--------------------------------- ACHIEVEMENT ---------------------------------
-------------------------------------------------------------------------------

local Achievement = Class('Achievement', Reward)
local GetCriteriaInfo = function (id, criteria)
    local results = {GetAchievementCriteriaInfoByID(id, criteria)}
    if not results[1] then
        if criteria <= GetAchievementNumCriteria(id) then
            results = {GetAchievementCriteriaInfo(id, criteria)}
        else
            Core.Error('unknown achievement criteria ('..id..', '..criteria..')')
            return UNKNOWN
        end
    end
    return unpack(results)
end

function Achievement:Initialize(attrs)
    Reward.Initialize(self, attrs)
    self.criteria = Core.AsIDTable(self.criteria)
end

function Achievement:IsObtained()
    local _,_,_,completed,_,_,_,_,_,_,_,_,earnedByMe = GetAchievementInfo(self.id)
    completed = completed and (not Core:GetOpt('use_char_achieves') or earnedByMe)
    if completed then return true end
    if self.criteria then
        for i, c in ipairs(self.criteria) do
            local _, _, completed = GetCriteriaInfo(self.id, c.id)
            if not completed then return false end
        end
        return true
    end
    return false
end

function Achievement:GetText()
    local _,name,_,_,_,_,_,_,_,icon = GetAchievementInfo(self.id)
    return Icon(icon)..ACHIEVEMENT_COLOR_CODE..'['..name..']|r'
end

function Achievement:GetStatus()
    if not self.oneline and self.criteria then return end
    return self:IsObtained() and Green(L['completed']) or Red(L['incomplete'])
end

function Achievement:GetLines()
    local completed = self:IsObtained()
    local index = 0
    return function ()
        -- ignore sub-lines if oneline is enabled or no criteria were given
        if self.oneline or not self.criteria then return end

        -- increment our criteria counter
        index = index + 1
        if index > #self.criteria then return end

        local c = self.criteria[index]
        local cname, _, ccomp, qty, req = GetCriteriaInfo(self.id, c.id)
        if (cname == '' or c.qty) then
            cname = c.suffix or cname
            cname = (completed and req..'/'..req or qty..'/'..req)..' '..cname
        end

        local r, g, b = .6, .6, .6
        local ctext = "   "..bullet.." "..cname
        if (completed or ccomp) then
            r, g, b = 0, 1, 0
        end

        local note, status = c.note
        if c.quest then
            if C_QuestLog.IsQuestFlaggedCompleted(c.quest) then
                status = Core.status.Green(L['defeated'])
            else
                status = Core.status.Red(L['undefeated'])
            end
            note = note and (note..'  '..status) or status
        end

        return ctext, note, r, g, b
    end
end

-------------------------------------------------------------------------------
----------------------------------- CURRENCY ----------------------------------
-------------------------------------------------------------------------------

local Currency = Class('Currency', Reward)

function Currency:GetText()
    local info = C_CurrencyInfo.GetCurrencyInfo(self.id)
    local text = C_CurrencyInfo.GetCurrencyLink(self.id, 0)
    if self.note then -- additional info
        text = text..' ('..self.note..')'
    end
    return Icon(info.iconFileID)..text
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

function Item:Prepare()
    Core.PrepareLinks(self.note)
end

function Item:IsObtained()
    if self.quest then return C_QuestLog.IsQuestFlaggedCompleted(self.quest) end
    if self.bag then return Core.PlayerHasItem(self.item) end
    return true
end

function Item:GetText()
    local text = self.itemLink
    if self.type then -- mount, pet, toy, etc
        text = text..' ('..self.type..')'
    end
    if self.note then -- additional info
        text = text..' ('..Core.RenderLinks(self.note, true)..')'
    end
    return Icon(self.itemIcon)..text
end

function Item:GetStatus()
    if self.bag then
        local collected = Core.PlayerHasItem(self.item)
        return collected and Green(L['completed']) or Red(L['incomplete'])
    elseif self.status then
        return format('(%s)', self.status)
    elseif self.quest then
        local completed = C_QuestLog.IsQuestFlaggedCompleted(self.quest)
        return completed and Green(L['completed']) or Red(L['incomplete'])
    elseif self.weekly then
        local completed = C_QuestLog.IsQuestFlaggedCompleted(self.weekly)
        return completed and Green(L['weekly']) or Red(L['weekly'])
    end
end

-------------------------------------------------------------------------------
------------------------------------ MOUNT ------------------------------------
-------------------------------------------------------------------------------

local Mount = Class('Mount', Item, {
    display_option='show_mount_rewards',
    type=L["mount"]
})

function Mount:IsObtained()
    return select(11, C_MountJournal.GetMountInfoByID(self.id))
end

function Mount:GetStatus()
    local collected = select(11, C_MountJournal.GetMountInfoByID(self.id))
    return collected and Green(L["known"]) or Red(L["missing"])
end

-------------------------------------------------------------------------------
------------------------------------- PET -------------------------------------
-------------------------------------------------------------------------------

local Pet = Class('Pet', Item, {
    display_option='show_pet_rewards',
    type=L["pet"]
})

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

function Pet:GetStatus()
    local n, m = C_PetJournal.GetNumCollectedInfo(self.id)
    return (n > 0) and Green(n..'/'..m) or Red(n..'/'..m)
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

function Quest:GetText()
    local name = C_QuestLog.GetTitleForQuestID(self.id[1])
    return Core.GetIconLink('quest_ay', 13)..' '..(name or UNKNOWN)
end

function Quest:GetStatus()
    if #self.id == 1 then
        local completed = C_QuestLog.IsQuestFlaggedCompleted(self.id[1])
        return completed and Green(L['completed']) or Red(L['incomplete'])
    else
        local count = 0
        for i, id in ipairs(self.id) do
            if C_QuestLog.IsQuestFlaggedCompleted(id) then count = count + 1 end
        end
        local status = count..'/'..#self.id
        return (count == #self.id) and Green(status) or Red(status)
    end
end

-------------------------------------------------------------------------------
------------------------------------ SPELL ------------------------------------
-------------------------------------------------------------------------------

local Spell = Class('Spell', Item, { type = L["spell"] })

function Spell:IsObtained()
    return IsSpellKnown(self.spell)
end

function Spell:GetStatus()
    local collected = IsSpellKnown(self.spell)
    return collected and Green(L["known"]) or Red(L["missing"])
end

-------------------------------------------------------------------------------
------------------------------------- TOY -------------------------------------
-------------------------------------------------------------------------------
local Toy = Class('Toy', Item, {
    display_option='show_toy_rewards',
    type=L["toy"]
})

function Toy:IsObtained()
    return PlayerHasToy(self.item)
end

function Toy:GetStatus()
    local collected = PlayerHasToy(self.item)
    return collected and Green(L["known"]) or Red(L["missing"])
end

-------------------------------------------------------------------------------
---------------------------------- TRANSMOG -----------------------------------
-------------------------------------------------------------------------------
local Transmog = Class('Transmog', Item, {
    display_option='show_transmog_rewards'
})
local CTC = C_TransmogCollection

function Transmog:Initialize(attrs)
    Item.Initialize(self, attrs)
    if self.slot then
        self.type = self.slot -- backwards compat
    end
end
function Transmog:Prepare()
    Item.Prepare(self)
    local sourceID = select(2, CTC.GetItemInfo(self.item))
    if sourceID then CTC.PlayerCanCollectSource(sourceID) end
    GetItemSpecInfo(self.item)
    CTC.PlayerHasTransmog(self.item)
end

function Transmog:IsEnabled()
    if not Item.IsEnabled(self) then return false end
    if Core:GetOpt('show_all_transmog_rewards') then return true end
    if not (self:IsLearnable() and self:IsObtainable()) then return false end
    return true
end

function Transmog:IsKnown()
    if CTC.PlayerHasTransmog(self.item) then return true end
    local appearanceID, sourceID = CTC.GetItemInfo(self.item)
    if sourceID and CTC.PlayerHasTransmogItemModifiedAppearance(sourceID) then return true end
    if appearanceID then
        local sources = CTC.GetAppearanceSources(appearanceID)
        if sources then
            for i, source in pairs(sources) do
                if source.isCollected then return true end
            end
        end
    end
    return false
end

function Transmog:IsLearnable()
    local sourceID = select(2, CTC.GetItemInfo(self.item))
    if sourceID then
        local infoReady, canCollect = CTC.PlayerCanCollectSource(sourceID)
        if infoReady and not canCollect then return false end
    end
    return true
end

function Transmog:IsObtainable()
    if not Item.IsObtainable(self) then return false end
    -- Cosmetic cloaks do not behave well with the GetItemSpecInfo() function.
    -- They return an empty table even though you can get the item to drop.
    local _, _, _, ilvl, _, _, _, _, equipLoc = GetItemInfo(self.item)
    if not (ilvl == 1 and equipLoc == 'INVTYPE_CLOAK' and self.slot == L["cosmetic"]) then
        -- Verify the item drops for any of the players specs
        local specs = GetItemSpecInfo(self.item)
        if type(specs) == 'table' and #specs == 0 then return false end
    end
    return true
end

function Transmog:IsObtained()
    -- Check if the player knows the appearance
    if self:IsKnown() then return true end
    -- Verify the player can obtain and learn the item's appearance
    if not (self:IsObtainable() and self:IsLearnable()) then return true end
    return false
end

function Transmog:GetStatus()
    local collected = self:IsKnown()
    local status = collected and Green(L["known"]) or Red(L["missing"])

    if not collected then
        if not self:IsLearnable() then
            status = Orange(L["unlearnable"])
        elseif not self:IsObtainable() then
            status = Orange(L["unobtainable"])
        end
    end

    return status
end

-------------------------------------------------------------------------------

Core.reward = {
    Reward=Reward,
    Section=Section,
    Spacer=Spacer,
    Achievement=Achievement,
    Currency=Currency,
    Item=Item,
    Mount=Mount,
    Pet=Pet,
    Quest=Quest,
    Spell=Spell,
    Toy=Toy,
    Transmog=Transmog
}



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
_G["HandyNotes_CoreWorldMapOptionsButtonMixin"] = WorldMapOptionsButtonMixin

function WorldMapOptionsButtonMixin:OnLoad()
    UIDropDownMenu_SetInitializeFunction(self.DropDown, function (dropdown, level)
        dropdown:GetParent():InitializeDropDown(level)
    end)
    UIDropDownMenu_SetDisplayMode(self.DropDown, "MENU")

    self.GroupDesc = CreateFrame('Frame', 'HandyNotes_CoreGroupMenuSliderOption',
        nil, 'HandyNotes_CoreTextMenuOptionTemplate')
    self.AlphaOption = CreateFrame('Frame', 'HandyNotes_CoreAlphaMenuSliderOption',
        nil, 'HandyNotes_CoreSliderMenuOptionTemplate')
    self.ScaleOption = CreateFrame('Frame', 'HandyNotes_CoreScaleMenuSliderOption',
        nil, 'HandyNotes_CoreSliderMenuOptionTemplate')
end

function WorldMapOptionsButtonMixin:OnMouseDown(button)
    self.Icon:SetPoint("TOPLEFT", 8, -8)
    local xOffset = WorldMapFrame.isMaximized and 30 or 0
    self.DropDown.point = WorldMapFrame.isMaximized and "TOPRIGHT" or "TOPLEFT"
    ToggleDropDownMenu(1, nil, self.DropDown, self, xOffset, -5)
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
end

function WorldMapOptionsButtonMixin:OnMouseUp()
    self.Icon:SetPoint("TOPLEFT", self, "TOPLEFT", 6, -6)
end

function WorldMapOptionsButtonMixin:OnEnter()
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip_SetTitle(GameTooltip, Core.plugin_name)
    GameTooltip_AddNormalLine(GameTooltip, L["map_button_text"])
    GameTooltip:Show()
end

function WorldMapOptionsButtonMixin:Refresh()
    local enabled = Core:GetOpt('show_worldmap_button')
    local map = Core.maps[self:GetParent():GetMapID() or 0]
    if enabled and map and map:HasEnabledGroups() then self:Show() else self:Hide() end
end

function WorldMapOptionsButtonMixin:InitializeDropDown(level)
    local map, icon, iconLink = Core.maps[self:GetParent():GetMapID()]

    if level == 1 then
        UIDropDownMenu_AddButton({
            isTitle = true,
            notCheckable = true,
            text = WORLD_MAP_FILTER_TITLE
        })

        for i, group in ipairs(map.groups) do
            if group:IsEnabled() and group:HasEnabledNodes(map) then
                icon = group.icon
                if group.name == 'misc' then
                    -- find an icon from the misc nodes in the map
                    for coord, node in pairs(map.nodes) do
                        if node.group == group then
                            icon = node.icon
                            break
                        end
                    end
                end

                if type(icon) == 'number' then
                    iconLink = Core.GetIconLink(icon, 12, 1, 0)..' '
                else
                    iconLink = Core.GetIconLink(icon, 16)
                end

                UIDropDownMenu_AddButton({
                    text = iconLink..' '..Core.RenderLinks(group.label, true),
                    isNotRadio = true,
                    keepShownOnClick = true,
                    hasArrow = true,
                    value = group,
                    checked = group:GetDisplay(map.id),
                    arg1 = group,
                    func = function (button, group)
                        group:SetDisplay(button.checked, map.id)
                    end
                })
            end
        end

        UIDropDownMenu_AddSeparator()
        UIDropDownMenu_AddButton({
            text = L["options_reward_types"],
            isNotRadio = true,
            notCheckable = true,
            keepShownOnClick = true,
            hasArrow = true,
            value = 'rewards'
        })
        UIDropDownMenu_AddButton({
            text = L["options_show_completed_nodes"],
            isNotRadio = true,
            keepShownOnClick = true,
            checked = Core:GetOpt('show_completed_nodes'),
            func = function (button, option)
                Core:SetOpt('show_completed_nodes', button.checked)
            end
        })
        UIDropDownMenu_AddButton({
            text = L["options_toggle_hide_done_rare"],
            isNotRadio = true,
            keepShownOnClick = true,
            checked = Core:GetOpt('hide_done_rares'),
            func = function (button, option)
                Core:SetOpt('hide_done_rares', button.checked)
            end
        })
        UIDropDownMenu_AddButton({
            text = L["options_toggle_use_char_achieves"],
            isNotRadio = true,
            keepShownOnClick = true,
            checked = Core:GetOpt('use_char_achieves'),
            func = function (button, option)
                Core:SetOpt('use_char_achieves', button.checked)
            end
        })

        UIDropDownMenu_AddSeparator()
        UIDropDownMenu_AddButton({
            text = L["options_open_settings_panel"],
            isNotRadio = true,
            notCheckable = true,
            disabled = not map.settings,
            func = function (button, option)
                InterfaceOptionsFrame_Show()
                InterfaceOptionsFrame_OpenToCategory('HandyNotes')
                LibStub('AceConfigDialog-3.0'):SelectGroup(
                    'HandyNotes', 'plugins', 'HandyNotes', 'ZonesTab', 'Zone_'..map.id
                )
            end
        })
    elseif level == 2 then
        if UIDROPDOWNMENU_MENU_VALUE == 'rewards' then
            for i, type in ipairs({'mount', 'pet', 'toy', 'transmog'}) do
                UIDropDownMenu_AddButton({
                    text = L["options_"..type.."_rewards"],
                    isNotRadio = true,
                    keepShownOnClick = true,
                    checked = Core:GetOpt('show_'..type..'_rewards'),
                    func = function (button, option)
                        Core:SetOpt('show_'..type..'_rewards', button.checked)
                    end
                }, 2)
            end
        else
            -- Get correct map ID to query/set options for
            local group = UIDROPDOWNMENU_MENU_VALUE

            self.GroupDesc.Text:SetText(Core.RenderLinks(group.desc))
            UIDropDownMenu_AddButton({ customFrame = self.GroupDesc }, 2)
            UIDropDownMenu_AddButton({
                notClickable = true,
                notCheckable = true
            }, 2)

            UIDropDownMenu_AddSlider({
                text = L["options_opacity"],
                min = 0, max = 1, step=0.01,
                value = group:GetAlpha(map.id),
                frame = self.AlphaOption,
                percentage = true,
                func = function (v) group:SetAlpha(v, map.id) end
            }, 2)

            UIDropDownMenu_AddSlider({
                text = L["options_scale"],
                min = 0.3, max = 3, step=0.05,
                value = group:GetScale(map.id),
                frame = self.ScaleOption,
                func = function (v) group:SetScale(v, map.id) end
            }, 2)
        end
    end
end

-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local Class = Core.Class
local HBD = LibStub('HereBeDragons-2.0')

local ARROW = "Interface\\AddOns\\HandyNotes\\Icons\\Artwork\\arrow"
local CIRCLE = "Interface\\AddOns\\HandyNotes\\Icons\\Artwork\\circle"
local LINE = "Interface\\AddOns\\HandyNotes\\Icons\\Artwork\\line"

-------------------------------------------------------------------------------

local function ResetPin(pin)
    pin.texture:SetRotation(0)
    pin.texture:SetTexCoord(0, 1, 0, 1)
    pin.texture:SetVertexColor(1, 1, 1, 1)
    pin.frameOffset = 0
    pin.rotation = nil
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

    -- normalize table values
    self.quest = Core.AsTable(self.quest)
    self.questDeps = Core.AsTable(self.questDeps)
end

function POI:IsCompleted()
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

function POI:IsEnabled()
    -- Not enabled if any dependent quest ids are false
    if self.questDeps then
        for i, quest in ipairs(self.questDeps) do
            if not C_QuestLog.IsQuestFlaggedCompleted(quest) then return false end
        end
    end

    return not self:IsCompleted()
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
    size = size * Core:GetOpt('poi_scale')
    t:SetVertexColor(unpack({Core:GetColorOpt('poi_color')}))
    t:SetTexture(CIRCLE)
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

    t:SetTexture(self.icon)

    if self.r then
        t:SetVertexColor(self.r, self.g, self.b, self.a or 0.5)
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
        map:AcquirePin(template, self, CIRCLE, self[i])
        if i < #self then
            map:AcquirePin(template, self, LINE, self[i], self[i+1])
        end
    end
end

function Path:Draw(pin, type, xy1, xy2)
    local t = ResetPin(pin)
    t:SetVertexColor(unpack({Core:GetColorOpt('path_color')}))
    t:SetTexture(type)

    -- constant size for minimaps, variable size for world maps
    local size = pin.minimap and 4 or (pin.parentHeight * 0.003)
    local line_width = pin.minimap and 60 or (pin.parentHeight * 0.05)

    -- apply user scaling
    size = size * Core:GetOpt('poi_scale')
    line_width = line_width * Core:GetOpt('poi_scale')

    if type == CIRCLE then
        pin:SetSize(size, size)
        return HandyNotes:getXY(xy1)
    elseif type == LINE then
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
            pin.rotation = -math.atan2(wy2-wy1, wx2-wx1)
        else
            local x1p = x1 * pin.parentWidth
            local x2p = x2 * pin.parentWidth
            local y1p = y1 * pin.parentHeight
            local y2p = y2 * pin.parentHeight
            line_length = sqrt((x2p-x1p)^2 + (y2p-y1p)^2)
            pin.rotation = -math.atan2(y2p-y1p, x2p-x1p)
        end
        pin:SetSize(line_length, line_width)
        pin.texture:SetRotation(pin.rotation)

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
            map:AcquirePin(template, self, CIRCLE, self.path[i])
            if i < #self.path then
                map:AcquirePin(template, self, LINE, self.path[i], self.path[i+1])
            end
        end
    else
        map:AcquirePin(template, self, CIRCLE, self[1])
        map:AcquirePin(template, self, CIRCLE, self[2])
        map:AcquirePin(template, self, LINE, self[1], self[2])
    end
end

-------------------------------------------------------------------------------
------------------------------------ ARROW ------------------------------------
-------------------------------------------------------------------------------

local Arrow = Class('Arrow', Line)

function Arrow:Render(map, template)
    -- draw a segmented line and the head of the arrow
    Line.Render(self, map, template)
    map:AcquirePin(template, self, ARROW, self[1], self[2])
end

function Arrow:Draw(pin, type, xy1, xy2)
    local x, y = Line.Draw(self, pin, type, xy1, xy2)
    if x and y then return x, y end -- circle or line

    -- constant size for minimaps, variable size for world maps
    local head_length = pin.minimap and 40 or (pin.parentHeight * 0.04)
    local head_width = pin.minimap and 15 or (pin.parentHeight * 0.015)
    head_length = head_length * Core:GetOpt('poi_scale')
    head_width = head_width * Core:GetOpt('poi_scale')
    pin:SetSize(head_width, head_length)

    local x1, y1 = HandyNotes:getXY(xy1)
    local x2, y2 = HandyNotes:getXY(xy2)
    if pin.minimap then
        local mapID = HBD:GetPlayerZone()
        local wx1, wy1 = HBD:GetWorldCoordinatesFromZone(x1, y1, mapID)
        local wx2, wy2 = HBD:GetWorldCoordinatesFromZone(x2, y2, mapID)
        pin.rotation = -math.atan2(wy2-wy1, wx2-wx1) + (math.pi / 2)
    else
        local x1p = x1 * pin.parentWidth
        local x2p = x2 * pin.parentWidth
        local y1p = y1 * pin.parentHeight
        local y2p = y2 * pin.parentHeight
        pin.rotation = -math.atan2(y2p-y1p, x2p-x1p) - (math.pi / 2)
    end
    pin.texture:SetRotation(pin.rotation)

    return x2, y2
end

-------------------------------------------------------------------------------

Core.poi = {
    POI=POI,
    Glow=Glow,
    Path=Path,
    Line=Line,
    Arrow=Arrow
}

-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------


local Class = Core.Class
local Group = Core.Group
local Map = Core.Map

local Node = Core.node.Node
local Quest = Core.node.Quest
local Achievement = Core.reward.Achievement

-------------------------------------------------------------------------------

Core.expansion = 8

-------------------------------------------------------------------------------

Core.groups.ASSAULT_EVENT = Group('assault_events', 'peg_yw')
Core.groups.BOW_TO_YOUR_MASTERS = Group('bow_to_your_masters', 1850548, {defaults=Core.GROUP_HIDDEN, faction='Horde'})
Core.groups.BRUTOSAURS = Group('brutosaurs', 1881827, {defaults=Core.GROUP_HIDDEN})
Core.groups.CARVED_IN_STONE = Group('carved_in_stone', 134424, {defaults=Core.GROUP_HIDDEN})
Core.groups.CATS_NAZJ = Group('cats_nazj', 454045)
Core.groups.COFFERS = Group('coffers', 'star_chest_g')
Core.groups.DAILY_CHESTS = Group('daily_chests', 'chest_bl', {defaults=Core.GROUP_ALPHA75})
Core.groups.DRUST_FACTS = Group('drust_facts', 2101971, {defaults=Core.GROUP_HIDDEN})
Core.groups.DUNE_RIDER = Group('dune_rider', 134962, {defaults=Core.GROUP_HIDDEN})
Core.groups.EMBER_RELICS = Group('ember_relics', 514016, {defaults=Core.GROUP_HIDDEN, faction='Alliance'})
Core.groups.GET_HEKD = Group('get_hekd', 1604165, {defaults=Core.GROUP_HIDDEN})
Core.groups.HONEYBACKS = Group('honeybacks', 2066005, {defaults=Core.GROUP_HIDDEN, faction='Alliance'})
Core.groups.HOPPIN_SAD = Group('hoppin_sad', 804969, {defaults=Core.GROUP_HIDDEN})
Core.groups.LIFE_FINDS_A_WAY = Group('life_finds_a_way', 236192, {defaults=Core.GROUP_HIDDEN})
Core.groups.LOCKED_CHEST = Group('locked_chest', 'chest_gy', {defaults=Core.GROUP_ALPHA75})
Core.groups.MECH_CHEST = Group('mech_chest', 'chest_rd', {defaults=Core.GROUP_ALPHA75})
Core.groups.MISC_NAZJ = Group('misc_nazj', 528288)
Core.groups.MUSHROOM_HARVEST = Group('mushroom_harvest', 1869654, {defaults=Core.GROUP_HIDDEN})
Core.groups.PAKU_TOTEMS = Group('paku_totems', 'flight_point_y', {defaults=Core.GROUP_HIDDEN, faction='Horde'})
Core.groups.PRISMATICS = Group('prismatics', 'crystal_p', {defaults=Core.GROUP_HIDDEN})
Core.groups.RECRIG = Group('recrig', 'peg_bl')
Core.groups.SAUSAGE_SAMPLER = Group('sausage_sampler', 133200, {defaults=Core.GROUP_HIDDEN, faction='Alliance'})
Core.groups.SCAVENGER_OF_THE_SANDS = Group('scavenger_of_the_sands', 135725, {defaults=Core.GROUP_HIDDEN})
Core.groups.SECRET_SUPPLY = Group('secret_supplies', 'star_chest_b', {defaults=Core.GROUP_HIDDEN75})
Core.groups.SHANTY_RAID = Group('shanty_raid', 1500866, {defaults=Core.GROUP_HIDDEN})
Core.groups.SLIMES_NAZJ = Group('slimes_nazj', 132107)
Core.groups.SQUIRRELS = Group('squirrels', 237182, {defaults=Core.GROUP_HIDDEN})
Core.groups.SUPPLY = Group('supplies', 'star_chest_g', {defaults=Core.GROUP_HIDDEN75})
Core.groups.TALES_OF_DE_LOA = Group('tales_of_de_loa', 1875083, {defaults=Core.GROUP_HIDDEN})
Core.groups.THREE_SHEETS = Group('three_sheets', 135999, {defaults=Core.GROUP_HIDDEN})
Core.groups.TIDESAGE_LEGENDS = Group('tidesage_legends', 1500881, {defaults=Core.GROUP_HIDDEN})
Core.groups.UPRIGHT_CITIZENS = Group('upright_citizens', 516667, {defaults=Core.GROUP_HIDDEN, faction='Alliance'})
Core.groups.VISIONS_BUFFS = Group('visions_buffs', 132183)
Core.groups.VISIONS_CHEST = Group('visions_chest', 'chest_gy')
Core.groups.VISIONS_CRYSTALS = Group('visions_crystals', 'crystal_o')
Core.groups.VISIONS_MAIL = Group('visions_mail', 'envelope')
Core.groups.VISIONS_MISC = Group('visions_misc', 2823166)

-------------------------------------------------------------------------------
---------------------------------- CALLBACKS ----------------------------------
-------------------------------------------------------------------------------

-- Listen for aura applied/removed events so we can refresh when the player
-- enters and exits the alternate future
Core.addon:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED', function ()
    local _,e,_,_,_,_,_,_,t,_,_,s  = CombatLogGetCurrentEventInfo()
    if (e == 'SPELL_AURA_APPLIED' or e == 'SPELL_AURA_REMOVED') and
        t == UnitName('player') and s == 296644 then
        C_Timer.After(1, function() Core.addon:Refresh() end)
    end
end)

Core.addon:RegisterEvent('QUEST_ACCEPTED', function (_, _, id)
    if id == 56540 then
        Core.Debug('Vale assaults unlock detected')
        C_Timer.After(1, function() Core.addon:Refresh() end)
    end
end)

Core.addon:RegisterEvent('QUEST_WATCH_UPDATE', function (_, index)
    local info = C_QuestLog.GetInfo(index)
    if info and info.questID == 56376 then
        Core.Debug('Uldum assaults unlock detected')
        C_Timer.After(1, function() Core.addon:Refresh() end)
    end
end)

Core.addon:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED', function (...)
    -- Watch for a spellcast event that signals a ravenous slime was fed
    -- https://www.wowhead.com/spell=293775/schleimphage-feeding-tracker
    local _, source, _, spellID = ...
    if source == 'player' and spellID == 293775 then
        C_Timer.After(1, function() Core.addon:Refresh() end)
    end
end)

-------------------------------------------------------------------------------
-------------------------------- TIMED EVENTS ---------------------------------
-------------------------------------------------------------------------------

local TimedEvent = Class('TimedEvent', Quest, {
    icon = "peg_yw",
    scale = 2,
    group = Core.groups.ASSAULT_EVENT,
    note = ''
})

function TimedEvent:PrerequisiteCompleted()
    -- Timed events that are not active today return nil here
    return C_TaskQuest.GetQuestTimeLeftMinutes(self.quest[1])
end

Core.node.TimedEvent = TimedEvent

-------------------------------------------------------------------------------
------------------------------ WAR SUPPLY CRATES ------------------------------
-------------------------------------------------------------------------------

-- quest = 53640 (50 conquest looted for today)

Core.node.Supply = Class('Supply', Node, {
    icon = 'star_chest_g',
    scale = 1.5,
    label = L["supply_chest"],
    rlabel = Core.GetIconLink('war_mode_swords', 16),
    note=L["supply_chest_note"],
    requires = Core.requirement.WarMode,
    rewards={ Achievement({id=12572}) },
    group = Core.groups.SUPPLY
})

Core.node.SecretSupply = Class('SecretSupply', Core.node.Supply, {
    icon = 'star_chest_b',
    group = Core.groups.SECRET_SUPPLY,
    label = L["secret_supply_chest"],
    note = L["secret_supply_chest_note"]
})

Core.node.Coffer = Class('Coffer', Node, {
    icon = 'star_chest_g',
    scale = 1.5,
    group = Core.groups.COFFERS
})

-------------------------------------------------------------------------------
----------------------------- VISIONS ASSAULT MAP -----------------------------
-------------------------------------------------------------------------------

local VisionsMap = Class('VisionsMap', Map)

function VisionsMap:Prepare()
    Map.Prepare(self)
    self.assault = self.GetAssault()
    self.phased = self.assault ~= nil
end

function VisionsMap:CanDisplay(node, coord, minimap)
    local assault = node.assault
    if assault then
        assault = type(assault) == 'number' and {assault} or assault
        for i=1, #assault + 1, 1 do
            if i > #assault then return false end
            if assault[i] == self.assault then break end
        end
    end

    return Map.CanDisplay(self, node, coord, minimap)
end

Core.VisionsMap = VisionsMap

-------------------------------------------------------------------------------
-------------------------------- WARFRONT MAP ---------------------------------
-------------------------------------------------------------------------------

local WarfrontMap = Class('WarfrontMap', Map)

function WarfrontMap:CanDisplay(node, coord, minimap)
    -- Disable nodes that are not available when the other faction controls
    if node.controllingFaction then
        local state = C_ContributionCollector.GetState(self.collector)
        local faction = (state == 1 or state == 2) and 'Alliance' or 'Horde'
        if faction ~= node.controllingFaction then return false end
    end
    return Map.CanDisplay(self, node, coord, minimap)
end

Core.WarfrontMap = WarfrontMap