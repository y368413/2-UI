-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local MistsOfPandaria = {}

-------------------------------------------------------------------------------
----------------------------------- COLORS ------------------------------------
-------------------------------------------------------------------------------

MistsOfPandaria.COLORS = {
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

MistsOfPandaria.color = {}
MistsOfPandaria.status = {}

for name, color in pairs(MistsOfPandaria.COLORS) do
    MistsOfPandaria.color[name] = function (t) return string.format('|c%s%s|r', color, t) end
    MistsOfPandaria.status[name] = function (t) return string.format('(|c%s%s|r)', color, t) end
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
    preparer = CreateDatamineTooltip("HandyNotes_MistsOfPandaria_NamePreparer"),
    resolver = CreateDatamineTooltip("HandyNotes_MistsOfPandaria_NameResolver")
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
        MistsOfPandaria.Debug('ERROR: npc link not prepared:', link)
    end

    local name = self.cache[link]
    if name == nil then
        self.resolver:SetHyperlink(link)
        name = _G[self.resolver:GetName().."TextLeft1"]:GetText() or UNKNOWN
        if name == UNKNOWN then
            MistsOfPandaria.Debug('NameResolver returned UNKNOWN, recreating tooltip ...')
            self.resolver = CreateDatamineTooltip("HandyNotes_MistsOfPandaria_NameResolver")
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
            return MistsOfPandaria.color.NPC(name)
        elseif type == 'achievement' then
            if nameOnly then
                local _, name = GetAchievementInfo(id)
                if name then return name end
            else
                local link = GetAchievementLink(id)
                if link then
                    return MistsOfPandaria.GetIconLink('achievement', 15)..link
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
                return MistsOfPandaria.GetIconLink(icon, 12)..MistsOfPandaria.color.Yellow('['..name..']')
            end
        elseif type == 'spell' then
            local name, _, icon = GetSpellInfo(id)
            if name and icon then
                if nameOnly then return name end
                local spell = MistsOfPandaria.color.Spell('|Hspell:'..id..'|h['..name..']|h')
                return '|T'..icon..':0:0:1:-1|t '..spell
            end
        end
        return type..'+'..id
    end)
    -- render non-numeric ids
    links, _ = links:gsub('{(%l+):([^}]+)}', function (type, id)
        if type == 'wq' then
            local icon = MistsOfPandaria.GetIconLink('world_quest', 16, 0, -1)
            return icon..MistsOfPandaria.color.Yellow('['..id..']')
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
    local db = _G["HandyNotes_MistsOfPandariaDB"]
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

local AceLocale = LibStub("AceLocale-3.0")
local LOCALES = {}

local function NewLocale (locale)
    if LOCALES[locale] then return LOCALES[locale] end
    local L = AceLocale:NewLocale("HandyNotes_MistsOfPandaria", locale, (locale == 'enUS'), true)
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
end

-------------------------------------------------------------------------------
------------------------------ TABLE CONVERTERS -------------------------------
-------------------------------------------------------------------------------

local function AsTable (value, class)
    -- normalize to table of scalars
    if type(value) == 'nil' then return end
    if type(value) ~= 'table' then return {value} end
    if class and MistsOfPandaria.IsInstance(value, class) then return {value} end
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

MistsOfPandaria.AsIDTable = AsIDTable
MistsOfPandaria.AsTable = AsTable
MistsOfPandaria.GetDatabaseTable = GetDatabaseTable
MistsOfPandaria.NameResolver = NameResolver
MistsOfPandaria.NewLocale = NewLocale
MistsOfPandaria.PlayerHasItem = PlayerHasItem
MistsOfPandaria.PrepareLinks = PrepareLinks
MistsOfPandaria.RenderLinks = RenderLinks



-------------------------------------------------------------------------------
------------------------------------ CLASS ------------------------------------
-------------------------------------------------------------------------------

MistsOfPandaria.Class = function (name, parent, attrs)
    if type(name) ~= 'string' then error('name param must be a string') end
    if parent and not MistsOfPandaria.IsClass(parent) then error('parent param must be a class') end

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

MistsOfPandaria.IsClass = function (class)
    return type(class) == 'table' and class.getters and class.setters
end

MistsOfPandaria.IsInstance = function (instance, class)
    if type(instance) ~= 'table' then return false end
    local function compare (c1, c2)
        if c2 == nil then return false end
        if c1 == c2 then return true end
        return compare(c1, c2.__parent)
    end
    return compare(class, instance.__class)
end

MistsOfPandaria.Clone = function (instance, newattrs)
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

local HandyNotes_MistsOfPandaria = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_MistsOfPandaria", "AceBucket-3.0", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes")
if not HandyNotes then return end

MistsOfPandaria.locale = L
MistsOfPandaria.maps = {}

_G[HandyNotes_MistsOfPandaria] = HandyNotes_MistsOfPandaria

-------------------------------------------------------------------------------
----------------------------------- HELPERS -----------------------------------
-------------------------------------------------------------------------------

local DropdownMenu = CreateFrame("Frame", "HandyNotes_MistsOfPandariaDropdownMenu")
DropdownMenu.displayMode = "MENU"
local function InitializeDropdownMenu(level, mapID, coord)
    if not level then return end
    local node = MistsOfPandaria.maps[mapID].nodes[coord]
    local spacer = {text='', disabled=1, notClickable=1, notCheckable=1}

    if (level == 1) then
        UIDropDownMenu_AddButton({
            text=MistsOfPandaria.plugin_name, isTitle=1, notCheckable=1
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
                        title = MistsOfPandaria.RenderLinks(node.label, true),
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
                HandyNotes_MistsOfPandaria.db.char[mapID..'_coord_'..coord] = true
                HandyNotes_MistsOfPandaria:Refresh()
            end
        }, level)

        UIDropDownMenu_AddButton({
            text=L["context_menu_restore_hidden_nodes"], notCheckable=1,
            func=function ()
                wipe(HandyNotes_MistsOfPandaria.db.char)
                HandyNotes_MistsOfPandaria:Refresh()
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

function HandyNotes_MistsOfPandaria:OnEnter(mapID, coord)
    local map = MistsOfPandaria.maps[mapID]
    local node = map.nodes[coord]

    if self:GetCenter() > UIParent:GetCenter() then
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    end

    node:Render(GameTooltip, map:HasPOIs(node))
    map:SetFocus(node, true, true)
    MistsOfPandaria.MinimapDataProvider:RefreshAllData()
    MistsOfPandaria.WorldMapDataProvider:RefreshAllData()
    GameTooltip:Show()
end

function HandyNotes_MistsOfPandaria:OnLeave(mapID, coord)
    local map = MistsOfPandaria.maps[mapID]
    local node = map.nodes[coord]
    map:SetFocus(node, false, true)
    MistsOfPandaria.MinimapDataProvider:RefreshAllData()
    MistsOfPandaria.WorldMapDataProvider:RefreshAllData()
    GameTooltip:Hide()
end

function HandyNotes_MistsOfPandaria:OnClick(button, down, mapID, coord)
    local map = MistsOfPandaria.maps[mapID]
    local node = map.nodes[coord]
    if button == "RightButton" and down then
        DropdownMenu.initialize = function (_, level)
            InitializeDropdownMenu(level, mapID, coord)
        end
        ToggleDropDownMenu(1, nil, DropdownMenu, self, 0, 0)
    elseif button == "LeftButton" and down then
        if map:HasPOIs(node) then
            map:SetFocus(node, not node._focus)
            HandyNotes_MistsOfPandaria:Refresh()
        end
    end
end

function HandyNotes_MistsOfPandaria:OnInitialize()
    MistsOfPandaria.class = select(2, UnitClass('player'))
    MistsOfPandaria.faction = UnitFactionGroup('player')
    self.db = LibStub("AceDB-3.0"):New('HandyNotes_MistsOfPandariaDB', MistsOfPandaria.optionDefaults, "Default")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", function ()
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        self:ScheduleTimer("RegisterWithHandyNotes", 1)
    end)

    -- Add global groups to settings panel
    MistsOfPandaria.CreateGlobalGroupOptions()

    -- Add quick-toggle menu button to top-right corner of world map
    WorldMapFrame:AddOverlayFrame(
        "HandyNotes_MistsOfPandariaWorldMapOptionsButtonTemplate",
        "DROPDOWNTOGGLEBUTTON", "TOPRIGHT",
        WorldMapFrame:GetCanvasContainer(), "TOPRIGHT", -68, -2
    )

    -- Query localized expansion title
    if not MistsOfPandaria.expansion then error('Expansion not set: HandyNotes_MistsOfPandaria') end
    local expansion_name = EJ_GetTierInfo(MistsOfPandaria.expansion)
    MistsOfPandaria.plugin_name = 'HandyNotes: '..expansion_name
    MistsOfPandaria.options.name = ('%02d - '):format(MistsOfPandaria.expansion)..expansion_name
end

-------------------------------------------------------------------------------
------------------------------------ MAIN -------------------------------------
-------------------------------------------------------------------------------

function HandyNotes_MistsOfPandaria:RegisterWithHandyNotes()
    do
        local map, minimap, force
        local function iter(nodes, precoord)
            if not nodes then return nil end
            if minimap and MistsOfPandaria:GetOpt('hide_minimap') then return nil end
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
        function HandyNotes_MistsOfPandaria:GetNodes2(mapID, _minimap)
            if MistsOfPandaria:GetOpt('show_debug_map') then
                MistsOfPandaria.Debug('Loading nodes for map: '..mapID..' (minimap='..tostring(_minimap)..')')
            end

            map = MistsOfPandaria.maps[mapID]
            minimap = _minimap
            force = MistsOfPandaria:GetOpt('force_nodes') or MistsOfPandaria.dev_force

            if map then
                map:Prepare()
                return iter, map.nodes, nil
            end

            -- mapID not handled by this plugin
            return iter, nil, nil
        end
    end

    if MistsOfPandaria:GetOpt('development') then
        MistsOfPandaria.BootstrapDevelopmentEnvironment()
    end

    HandyNotes:RegisterPluginDB("HandyNotes_MistsOfPandaria", self, MistsOfPandaria.options)

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

function HandyNotes_MistsOfPandaria:Refresh()
    if self._refreshTimer then return end
    self._refreshTimer = C_Timer.NewTimer(0.1, function ()
        self._refreshTimer = nil
        self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_MistsOfPandaria")
        MistsOfPandaria.MinimapDataProvider:RefreshAllData()
        MistsOfPandaria.WorldMapDataProvider:RefreshAllData()
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

MistsOfPandaria.icons = { -- name => path

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

    portal_b = {Icon('portal_blue'), Glow('portal')},
    portal_g = {Icon('portal_green'), Glow('portal')},
    portal_p = {Icon('portal_purple'), Glow('portal')},
    portal_r = {Icon('portal_red'), Glow('portal')},

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
    local info = MistsOfPandaria.icons[name]
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
    local info = MistsOfPandaria.icons[name]
    return info and info[2] or nil
end

MistsOfPandaria.GetIconLink = GetIconLink
MistsOfPandaria.GetIconPath = GetIconPath
MistsOfPandaria.GetGlowPath = GetGlowPath



-------------------------------------------------------------------------------
---------------------------------- DEFAULTS -----------------------------------
-------------------------------------------------------------------------------

MistsOfPandaria.optionDefaults = {
    profile = {
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

function MistsOfPandaria:GetOpt(n) return HandyNotes_MistsOfPandaria.db.profile[n] end
function MistsOfPandaria:SetOpt(n, v) HandyNotes_MistsOfPandaria.db.profile[n] = v; HandyNotes_MistsOfPandaria:Refresh() end

function MistsOfPandaria:GetColorOpt(n)
    local db = HandyNotes_MistsOfPandaria.db.profile
    return db[n..'_R'], db[n..'_G'], db[n..'_B'], db[n..'_A']
end

function MistsOfPandaria:SetColorOpt(n, r, g, b, a)
    local db = HandyNotes_MistsOfPandaria.db.profile
    db[n..'_R'], db[n..'_G'], db[n..'_B'], db[n..'_A'] = r, g, b, a
    HandyNotes_MistsOfPandaria:Refresh()
end

-------------------------------------------------------------------------------
--------------------------------- OPTIONS UI ----------------------------------
-------------------------------------------------------------------------------

MistsOfPandaria.options = {
    type = "group",
    name = nil, -- populated in core.lua
    childGroups = "tab",
    get = function(info) return MistsOfPandaria:GetOpt(info.arg) end,
    set = function(info, v) MistsOfPandaria:SetOpt(info.arg, v) end,
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
                maximized_enlarged = {
                    type = "toggle",
                    arg = "maximized_enlarged",
                    name = L["options_toggle_maximized_enlarged"],
                    desc = L["options_toggle_maximized_enlarged_desc"],
                    order = 14,
                    width = "full",
                },
                use_char_achieves = {
                    type = "toggle",
                    arg = "use_char_achieves",
                    name = L["options_toggle_use_char_achieves"],
                    desc = L["options_toggle_use_char_achieves_desc"],
                    order = 15,
                    width = "full",
                },
                per_map_settings = {
                    type = "toggle",
                    arg = "per_map_settings",
                    name = L["options_toggle_per_map_settings"],
                    desc = L["options_toggle_per_map_settings_desc"],
                    order = 16,
                    width = "full",
                },
                restore_all_nodes = {
                    type = "execute",
                    name = L["options_restore_hidden_nodes"],
                    desc = L["options_restore_hidden_nodes_desc"],
                    order = 17,
                    width = "full",
                    func = function ()
                        wipe(HandyNotes_MistsOfPandaria.db.char)
                        HandyNotes_MistsOfPandaria:Refresh()
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
                    set = function(_, ...) MistsOfPandaria:SetColorOpt('poi_color', ...) end,
                    get = function() return MistsOfPandaria:GetColorOpt('poi_color') end,
                    order = 22,
                },
                PATH_color = {
                    type = "color",
                    name = L["options_path_color"],
                    desc = L["options_path_color_desc"],
                    hasAlpha = true,
                    set = function(_, ...) MistsOfPandaria:SetColorOpt('path_color', ...) end,
                    get = function() return MistsOfPandaria:GetColorOpt('path_color') end,
                    order = 23,
                },
                restore_poi_colors = {
                    type = "execute",
                    name = L["options_reset_poi_colors"],
                    desc = L["options_reset_poi_colors_desc"],
                    order = 24,
                    width = "full",
                    func = function ()
                        local df = MistsOfPandaria.optionDefaults.profile
                        MistsOfPandaria:SetColorOpt('poi_color', df.poi_color_R, df.poi_color_G, df.poi_color_B, df.poi_color_A)
                        MistsOfPandaria:SetColorOpt('path_color', df.path_color_R, df.path_color_G, df.path_color_B, df.path_color_A)
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
            disabled = function () return MistsOfPandaria:GetOpt('per_map_settings') end,
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

function MistsOfPandaria.CreateGlobalGroupOptions()
    for i, group in ipairs({
        MistsOfPandaria.groups.RARE,
        MistsOfPandaria.groups.TREASURE,
        MistsOfPandaria.groups.PETBATTLE,
        MistsOfPandaria.groups.MISC
    }) do
        MistsOfPandaria.options.args.GlobalTab.args['group_icon_'..group.name] = {
            type = "header",
            name = function () return MistsOfPandaria.RenderLinks(group.label, true) end,
            order = i * 10,
        }

        MistsOfPandaria.options.args.GlobalTab.args['icon_scale_'..group.name] = {
            type = "range",
            name = L["options_scale"],
            desc = L["options_scale_desc"],
            min = 0.3, max = 3, step = 0.01,
            arg = group.scaleArg,
            width = 1.13,
            order = i * 10 + 1,
        }

        MistsOfPandaria.options.args.GlobalTab.args['icon_alpha_'..group.name] = {
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

function MistsOfPandaria.CreateGroupOptions (map, group)
    -- Check if we've already initialized this group
    if _INITIALIZED[group.name..map.id] then return end
    _INITIALIZED[group.name..map.id] = true

    -- Create map options group under zones tab
    local options = MistsOfPandaria.options.args.ZonesTab.args['Zone_'..map.id]
    if not options then
        options = {
            type = "group",
            name = C_Map.GetMapInfo(map.id).name,
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
        MistsOfPandaria.options.args.ZonesTab.args['Zone_'..map.id] = options
    end

    map._icons_order = map._icons_order or 0
    map._visibility_order = map._visibility_order or 0

    options.args.IconsGroup.args["icon_toggle_"..group.name] = {
        type = "toggle",
        get = function () return group:GetDisplay(map.id) end,
        set = function (info, v) group:SetDisplay(v, map.id) end,
        name = function () return MistsOfPandaria.RenderLinks(group.label, true) end,
        desc = function () return MistsOfPandaria.RenderLinks(group.desc) end,
        disabled = function () return not group:IsEnabled() end,
        width = 0.9,
        order = map._icons_order
    }

    options.args.VisibilityGroup.args["header_"..group.name] = {
        type = "header",
        name = function () return MistsOfPandaria.RenderLinks(group.label, true) end,
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
_G[plugins][#_G[plugins] + 1] = MistsOfPandaria

local function BootstrapDevelopmentEnvironment()
    _G['HandyNotes_ZarPluginsDevelopment'] = true

    -- Add development settings to the UI
    MistsOfPandaria.options.args.GeneralTab.args.DevelopmentHeader = {
        type = "header",
        name = L["options_dev_settings"],
        order = 100,
    }
    MistsOfPandaria.options.args.GeneralTab.args.show_debug_map = {
        type = "toggle",
        arg = "show_debug_map",
        name = L["options_toggle_show_debug_map"],
        desc = L["options_toggle_show_debug_map_desc"],
        order = 101,
    }
    MistsOfPandaria.options.args.GeneralTab.args.show_debug_quest = {
        type = "toggle",
        arg = "show_debug_quest",
        name = L["options_toggle_show_debug_quest"],
        desc = L["options_toggle_show_debug_quest_desc"],
        order = 102,
    }
    MistsOfPandaria.options.args.GeneralTab.args.force_nodes = {
        type = "toggle",
        arg = "force_nodes",
        name = L["options_toggle_force_nodes"],
        desc = L["options_toggle_force_nodes_desc"],
        order = 103,
    }

    -- Print debug messages for each quest ID that is flipped
    local QTFrame = CreateFrame('Frame', "HandyNotes_MistsOfPandariaQT")
    local history = MistsOfPandaria.GetDatabaseTable('quest_id_history')
    local lastCheck = GetTime()
    local quests = {}
    local changed = {}
    local max_quest_id = 100000

    local function DebugQuest(...)
        if MistsOfPandaria:GetOpt('show_debug_quest') then MistsOfPandaria.Debug(...) end
    end

    C_Timer.After(2, function ()
        -- Give some time for quest info to load in before we start
        for id = 0, max_quest_id do quests[id] = C_QuestLog.IsQuestFlaggedCompleted(id) end
        QTFrame:SetScript('OnUpdate', function ()
            if GetTime() - lastCheck > 1 and MistsOfPandaria:GetOpt('show_debug_quest') then
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
    local IQFrame = CreateFrame('Frame', "HandyNotes_MistsOfPandariaIQ", WorldMapFrame)
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

_G['HandyNotes_MistsOfPandariaQuestHistory'] = function (count)
    local history = MistsOfPandaria.GetDatabaseTable('quest_id_history')
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
_G['HandyNotes_MistsOfPandariaRemovePins'] = function ()
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

function MistsOfPandaria.Debug(...)
    if not HandyNotes_MistsOfPandaria.db then return end
    if MistsOfPandaria:GetOpt('development') then print(MistsOfPandaria.color.Blue('DEBUG:'), ...) end
end

function MistsOfPandaria.Warn(...)
    if not HandyNotes_MistsOfPandaria.db then return end
    if MistsOfPandaria:GetOpt('development') then print(MistsOfPandaria.color.Orange('WARN:'), ...) end
end

function MistsOfPandaria.Error(...)
    if not HandyNotes_MistsOfPandaria.db then return end
    if MistsOfPandaria:GetOpt('development') then print(MistsOfPandaria.color.Red('ERROR:'), ...) end
end

-------------------------------------------------------------------------------

MistsOfPandaria.BootstrapDevelopmentEnvironment = BootstrapDevelopmentEnvironment



-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local Class = MistsOfPandaria.Class

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
    if MistsOfPandaria.maps[self.id] then error('Map already registered: '..self.id) end
    MistsOfPandaria.maps[self.id] = self
end

function Map:AddNode(coord, node)
    if not MistsOfPandaria.IsInstance(node, MistsOfPandaria.node.Node) then
        error(format('All nodes must be instances of the Node() class: %d %s', coord, tostring(node)))
    end

    if node.fgroup then
        if not self.fgroups[node.fgroup] then self.fgroups[node.fgroup] = {} end
        local fgroup = self.fgroups[node.fgroup]
        fgroup[#fgroup + 1] = coord
    end

    if node.group ~= MistsOfPandaria.groups.QUEST then
        -- Initialize group defaults and UI controls for this map if the group does
        -- not inherit its settings and defaults from a parent map
        if self.settings then MistsOfPandaria.CreateGroupOptions(self, node.group) end

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
        for i, parent in ipairs(node.parent) do
            -- Calculate parent zone coordinates and add node
            local px, py = HBD:GetZoneCoordinatesFromWorld(wx, wy, parent.id)
            if not (px and py) then
                error(format('No parent coords for node: %d %s %d', coord, tostring(node), parent.id))
            end
            local map = MistsOfPandaria.maps[parent.id] or Map({id=parent.id})
            map.nodes[HandyNotes:getCoord(px, py)] = MistsOfPandaria.Clone(node, {pois=(parent.pois or false)})
        end
    end
end

function Map:HasEnabledGroups()
    for i, group in ipairs(self.groups) do
        if group:IsEnabled() then return true end
    end
    return false
end

function Map:HasPOIs(node)
    if type(node.pois) == 'table' then return true end
    if node.fgroup then
        for i, coord in ipairs(self.fgroups[node.fgroup]) do
            if type(self.nodes[coord].pois) == 'table' then return true end
        end
    end
    return false
end

function Map:IsNodeEnabled(node, coord, minimap)
    local db = HandyNotes_MistsOfPandaria.db

    -- Check for dev force enable
    if MistsOfPandaria:GetOpt('force_nodes') or MistsOfPandaria.dev_force then return true end

    -- Check if the zone is still phased
    if node ~= self.intro and not self.phased then return false end

    -- Check if we've been hidden by the user
    if db.char[self.id..'_coord_'..coord] then return false end

    -- Minimap may be disabled for this node
    if not node.minimap and minimap then return false end

    -- Node may be faction restricted
    if node.faction and node.faction ~= MistsOfPandaria.faction then return false end

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

local MinimapPinsKey = "HandyNotes_MistsOfPandariaMinimapPins"
local MinimapDataProvider = CreateFrame("Frame", "HandyNotes_MistsOfPandariaMinimapDP")
local MinimapPinTemplate = 'HandyNotes_MistsOfPandariaMinimapPinTemplate'
local MinimapPinMixin = {}

_G['HandyNotes_MistsOfPandariaMinimapPinMixin'] = MinimapPinMixin

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
        pin = CreateFrame("Button", "HandyNotes_MistsOfPandariaPin"..(#self.pins + 1), Minimap, template)
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

    local map = MistsOfPandaria.maps[HBD:GetPlayerZone()]
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
                    poi:Render(self, MinimapPinTemplate)
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

HandyNotes_MistsOfPandaria:RegisterEvent('MINIMAP_UPDATE_ZOOM', function (...)
    MinimapDataProvider:RefreshAllData()
end)

HandyNotes_MistsOfPandaria:RegisterEvent('CVAR_UPDATE', function (_, varname)
    if varname == 'ROTATE_MINIMAP' then
        MinimapDataProvider:RefreshAllData()
    end
end)

-------------------------------------------------------------------------------
--------------------------- WORLD MAP DATA PROVIDER ---------------------------
-------------------------------------------------------------------------------

local WorldMapDataProvider = CreateFromMixins(MapCanvasDataProviderMixin)
local WorldMapPinTemplate = 'HandyNotes_MistsOfPandariaWorldMapPinTemplate'
local WorldMapPinMixin = CreateFromMixins(MapCanvasPinMixin)

_G['HandyNotes_MistsOfPandariaWorldMapPinMixin'] = WorldMapPinMixin

function WorldMapDataProvider:RemoveAllData()
    if self:GetMap() then
        self:GetMap():RemoveAllPinsByTemplate(WorldMapPinTemplate)
    end
end

function WorldMapDataProvider:RefreshAllData(fromOnShow)
    self:RemoveAllData()

    if not self:GetMap() then return end
    local map = MistsOfPandaria.maps[self:GetMap():GetMapID()]
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

MistsOfPandaria.Map = Map
MistsOfPandaria.MinimapDataProvider = MinimapDataProvider
MistsOfPandaria.WorldMapDataProvider = WorldMapDataProvider




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
    MistsOfPandaria.PrepareLinks(self.label)
    MistsOfPandaria.PrepareLinks(self.desc)

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

-- Override to hide this group in the UI under certain circumstances
function Group:IsEnabled()
    if self.class and self.class ~= MistsOfPandaria.class then return false end
    if self.faction and self.faction ~= MistsOfPandaria.faction then return false end
    return true
end

function Group:_GetOpt (option, default, mapID)
    local value
    if MistsOfPandaria:GetOpt('per_map_settings') then
        value = MistsOfPandaria:GetOpt(option..'_'..mapID)
    else
        value = MistsOfPandaria:GetOpt(option)
    end
    return (value == nil) and default or value
end

function Group:_SetOpt (option, value, mapID)
    if MistsOfPandaria:GetOpt('per_map_settings') then
        return MistsOfPandaria:SetOpt(option..'_'..mapID, value)
    end
    return MistsOfPandaria:SetOpt(option, value)
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

MistsOfPandaria.Group = Group

MistsOfPandaria.GROUP_HIDDEN = {display=false}
MistsOfPandaria.GROUP_HIDDEN75 = {alpha=0.75, display=false}
MistsOfPandaria.GROUP_ALPHA75 = {alpha=0.75}

MistsOfPandaria.groups = {
    PETBATTLE = Group('pet_battles', 'paw_y'),
    QUEST = Group('quests', 'quest_ay'),
    RARE = Group('rares', 'skull_w', {defaults=MistsOfPandaria.GROUP_ALPHA75}),
    TREASURE = Group('treasures', 'chest_gy', {defaults=MistsOfPandaria.GROUP_ALPHA75}),
    MISC = Group('misc', 454046),
}


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
    return MistsOfPandaria.PlayerHasItem(self.id, self.count)
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

MistsOfPandaria.requirement = {
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

local Group = MistsOfPandaria.Group
local IsInstance = MistsOfPandaria.IsInstance
local Requirement = MistsOfPandaria.requirement.Requirement

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
    group = MistsOfPandaria.groups.MISC
})

function Node:Initialize(attrs)
    -- assign all attributes
    if attrs then
        for k, v in pairs(attrs) do self[k] = v end
    end

    -- normalize table values
    self.quest = MistsOfPandaria.AsTable(self.quest)
    self.questDeps = MistsOfPandaria.AsTable(self.questDeps)
    self.parent = MistsOfPandaria.AsIDTable(self.parent)
    self.requires = MistsOfPandaria.AsTable(self.requires, Requirement)

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
    local icon = MistsOfPandaria.GetIconPath(self.icon)
    local scale = self.scale * self.group:GetScale(mapID)
    local alpha = self.alpha * self.group:GetAlpha(mapID)

    if not minimap and WorldMapFrame.isMaximized and MistsOfPandaria:GetOpt('maximized_enlarged') then
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
    if self.group == MistsOfPandaria.groups.QUEST or not MistsOfPandaria:GetOpt('show_completed_nodes') then
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
    if type(self.icon) == 'string' and MistsOfPandaria.icons[self.icon] == nil then
        error('unknown icon: '..self.icon)
    end

    -- initialize glow POI (if glow icon available)

    if not self.glow then
        local icon = MistsOfPandaria.GetGlowPath(self.icon)
        if icon then
            self.glow = MistsOfPandaria.poi.Glow({ icon=icon })
        end
    end

    MistsOfPandaria.PrepareLinks(self.label)
    MistsOfPandaria.PrepareLinks(self.sublabel)
    MistsOfPandaria.PrepareLinks(self.note)

    if self.requires then
        for i, req in ipairs(self.requires) do
            if IsInstance(req, Requirement) then
                MistsOfPandaria.PrepareLinks(req:GetText())
            else
                MistsOfPandaria.PrepareLinks(req)
            end
        end
    end

    for reward in self:IterateRewards() do
        reward:Prepare()
    end
end

--[[
Render this node onto the given tooltip. Many features are optional depending
on the attributes set on this specific node, such as setting an `rlabel` or
`sublabel` value.
--]]

function Node:Render(tooltip, hasPOIs)
    -- render the label text with NPC names resolved
    tooltip:SetText(MistsOfPandaria.RenderLinks(self.label, true))

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
        color = (count == #self.quest) and MistsOfPandaria.status.Green or MistsOfPandaria.status.Gray
        rlabel = rlabel..' '..color(tostring(count)..'/'..#self.quest)
    end

    if self.faction then
        rlabel = rlabel..' '..MistsOfPandaria.GetIconLink(self.faction:lower(), 16, 1, -1)
    end

    if hasPOIs then
        -- add an rlabel hint to use left-mouse to focus the node
        local focus = MistsOfPandaria.GetIconLink('left_mouse', 12)..MistsOfPandaria.status.Gray(L["focus"])
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
        tooltip:AddLine(MistsOfPandaria.RenderLinks(self.sublabel, true), 1, 1, 1)
    end

    -- display item, spell or other requirements
    if self.requires then
        for i, req in ipairs(self.requires) do
            if IsInstance(req, Requirement) then
                color = req:IsMet() and MistsOfPandaria.color.White or MistsOfPandaria.color.Red
                text = color(L["Requires"]..' '..req:GetText())
            else
                text = MistsOfPandaria.color.Red(L["Requires"]..' '..req)
            end
            tooltip:AddLine(MistsOfPandaria.RenderLinks(text, true))
        end
    end

    -- additional text for the node to describe how to interact with the
    -- object or summon the rare
    if self.note and MistsOfPandaria:GetOpt('show_notes') then
        if self.requires or self.sublabel then tooltip:AddLine(" ") end
        tooltip:AddLine(MistsOfPandaria.RenderLinks(self.note), 1, 1, 1, true)
    end

    -- all rewards (achievements, pets, mounts, toys, quests) that can be
    -- collected or completed from this node
    if self.rewards and MistsOfPandaria:GetOpt('show_loot') then
        local firstAchieve, firstOther = true, true
        for reward in self:IterateRewards() do

            -- Add a blank line between achievements and other rewards
            local isAchieve = IsInstance(reward, MistsOfPandaria.reward.Achievement)
            local isSpacer = IsInstance(reward, MistsOfPandaria.reward.Spacer)
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
        if IsInstance(reward, MistsOfPandaria.reward.Achievement) then
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
    group = MistsOfPandaria.groups.QUEST,
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
    group = MistsOfPandaria.groups.PETBATTLE
})

-------------------------------------------------------------------------------
------------------------------------ QUEST ------------------------------------
-------------------------------------------------------------------------------

local Quest = Class('Quest', Node, {
    note = AVAILABLE_QUEST,
    group = MistsOfPandaria.groups.QUEST
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
    group = MistsOfPandaria.groups.RARE
})

function Rare.getters:icon()
    return self:IsCollected() and 'skull_w' or 'skull_b'
end

function Rare:IsEnabled()
    if MistsOfPandaria:GetOpt('hide_done_rares') and self:IsCollected() then return false end
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
    group = MistsOfPandaria.groups.TREASURE
})

function Treasure.getters:label()
    for reward in self:IterateRewards() do
        if IsInstance(reward, MistsOfPandaria.reward.Achievement) then
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

MistsOfPandaria.node = {
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


local Green = MistsOfPandaria.status.Green
local Orange = MistsOfPandaria.status.Orange
local Red = MistsOfPandaria.status.Red

-------------------------------------------------------------------------------

local function Icon(icon) return '|T'..icon..':0:0:1:-1|t ' end

-- in zhCN¡¯s built-in font, ARHei.ttf, the glyph of U+2022 <bullet> is missing.
-- use U+00B7 <middle dot> instead.
local bullet = (GetLocale() == "zhCN" and "¡¤" or "?")
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
    if self.class and self.class ~= MistsOfPandaria.class then return false end
    if self.faction and self.faction ~= MistsOfPandaria.faction then return false end
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
function Section:Prepare()
    MistsOfPandaria.PrepareLinks(self.title)
end

function Section:Render(tooltip)
    tooltip:AddLine(MistsOfPandaria.RenderLinks(self.title, true)..':')
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
            MistsOfPandaria.Error('unknown achievement criteria ('..id..', '..criteria..')')
            return UNKNOWN
        end
    end
    return unpack(results)
end

function Achievement:Initialize(attrs)
    Reward.Initialize(self, attrs)
    self.criteria = MistsOfPandaria.AsIDTable(self.criteria)
end

function Achievement:IsObtained()
    local _,_,_,completed,_,_,_,_,_,_,_,_,earnedByMe = GetAchievementInfo(self.id)
    completed = completed and (not MistsOfPandaria:GetOpt('use_char_achieves') or earnedByMe)
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
    if not self.oneline then return end
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
                status = MistsOfPandaria.status.Green(L['defeated'])
            else
                status = MistsOfPandaria.status.Red(L['undefeated'])
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

function Item:IsObtained()
    if self.quest then return C_QuestLog.IsQuestFlaggedCompleted(self.quest) end
    return true
end

function Item:GetText()
    local text = self.itemLink
    if self.type then -- mount, pet, toy, etc
        text = text..' ('..self.type..')'
    end
    if self.note then -- additional info
        text = text..' ('..self.note..')'
    end
    return Icon(self.itemIcon)..text
end

function Item:GetStatus()
    if self.quest then
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

-- /run for i,m in ipairs(C_MountJournal.GetMountIDs()) do if (C_MountJournal.GetMountInfoByID(m) == "NAME") then print(m) end end

local Mount = Class('Mount', Item, { type = L["mount"] })

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

-- /run print(C_PetJournal.FindPetIDByName("NAME"))

local Pet = Class('Pet', Item, { type = L["pet"] })

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
    return MistsOfPandaria.GetIconLink('quest_ay', 13)..' '..(name or UNKNOWN)
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

local Toy = Class('Toy', Item, { type = L["toy"] })

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

local Transmog = Class('Transmog', Item)
local CTC = C_TransmogCollection

function Transmog:Initialize(attrs)
    Item.Initialize(self, attrs)
    if self.slot then
        self.type = self.slot -- backwards compat
    end
end

function Transmog:IsObtained()
    -- Check if the player knows the appearance
    if CTC.PlayerHasTransmog(self.item) then return true end

    -- Verify the item drops for any of the players specs
    local specs = GetItemSpecInfo(self.item)
    if type(specs) == 'table' and #specs == 0 then return true end

    -- Verify the player can learn the item's appearance
    local sourceID = select(2, CTC.GetItemInfo(self.item))
    if sourceID then
        local infoReady, canCollect = CTC.PlayerCanCollectSource(sourceID)
        if infoReady and not canCollect then return true end
    end

    return false
end

function Transmog:GetStatus()
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

    return status
end

-------------------------------------------------------------------------------

MistsOfPandaria.reward = {
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
_G["HandyNotes_MistsOfPandariaWorldMapOptionsButtonMixin"] = WorldMapOptionsButtonMixin

function WorldMapOptionsButtonMixin:OnLoad()
    UIDropDownMenu_SetInitializeFunction(self.DropDown, function (dropdown, level)
        dropdown:GetParent():InitializeDropDown(level)
    end)
    UIDropDownMenu_SetDisplayMode(self.DropDown, "MENU")

    self.GroupDesc = CreateFrame('Frame', 'HandyNotes_MistsOfPandariaGroupMenuSliderOption',
        nil, 'HandyNotes_MistsOfPandariaTextMenuOptionTemplate')
    self.AlphaOption = CreateFrame('Frame', 'HandyNotes_MistsOfPandariaAlphaMenuSliderOption',
        nil, 'HandyNotes_MistsOfPandariaSliderMenuOptionTemplate')
    self.ScaleOption = CreateFrame('Frame', 'HandyNotes_MistsOfPandariaScaleMenuSliderOption',
        nil, 'HandyNotes_MistsOfPandariaSliderMenuOptionTemplate')
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
    GameTooltip_SetTitle(GameTooltip, MistsOfPandaria.plugin_name)
    GameTooltip_AddNormalLine(GameTooltip, L["map_button_text"])
    GameTooltip:Show()
end

function WorldMapOptionsButtonMixin:Refresh()
    local map = MistsOfPandaria.maps[self:GetParent():GetMapID() or 0]
    if map and map:HasEnabledGroups() then self:Show() else self:Hide() end
end

function WorldMapOptionsButtonMixin:InitializeDropDown(level)
    local map, icon = MistsOfPandaria.maps[self:GetParent():GetMapID()]

    if level == 1 then
        UIDropDownMenu_AddButton({
            isTitle = true,
            notCheckable = true,
            text = WORLD_MAP_FILTER_TITLE
        })

        for i, group in ipairs(map.groups) do
            if group:IsEnabled() then
                if type(group.icon) == 'number' then
                    icon = MistsOfPandaria.GetIconLink(group.icon, 12, 1, 0)..' '
                else
                    icon = MistsOfPandaria.GetIconLink(group.icon, 16)
                end
                UIDropDownMenu_AddButton({
                    text = icon..' '..MistsOfPandaria.RenderLinks(group.label, true),
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
            text = L["options_show_completed_nodes"],
            isNotRadio = true,
            keepShownOnClick = true,
            checked = MistsOfPandaria:GetOpt('show_completed_nodes'),
            func = function (button, option)
                MistsOfPandaria:SetOpt('show_completed_nodes', button.checked)
            end
        })
        UIDropDownMenu_AddButton({
            text = L["options_toggle_use_char_achieves"],
            isNotRadio = true,
            keepShownOnClick = true,
            checked = MistsOfPandaria:GetOpt('use_char_achieves'),
            func = function (button, option)
                MistsOfPandaria:SetOpt('use_char_achieves', button.checked)
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
                    'HandyNotes', 'plugins', "HandyNotes_MistsOfPandaria", 'ZonesTab', 'Zone_'..map.id
                )
            end
        })
    elseif level == 2 then
        -- Get correct map ID to query/set options for
        local group = UIDROPDOWNMENU_MENU_VALUE

        self.GroupDesc.Text:SetText(MistsOfPandaria.RenderLinks(group.desc))
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

-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local HBD = LibStub('HereBeDragons-2.0')

local ARROW = "Interface\\AddOns\\HandyNotes\\Icons\\artwork\\arrow"
local CIRCLE = "Interface\\AddOns\\HandyNotes\\Icons\\artwork\\circle"
local LINE = "Interface\\AddOns\\HandyNotes\\Icons\\artwork\\line"

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
    size = size * MistsOfPandaria:GetOpt('poi_scale')
    t:SetVertexColor(unpack({MistsOfPandaria:GetColorOpt('poi_color')}))
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
    t:SetVertexColor(unpack({MistsOfPandaria:GetColorOpt('path_color')}))
    t:SetTexture(type)

    -- constant size for minimaps, variable size for world maps
    local size = pin.minimap and 4 or (pin.parentHeight * 0.003)
    local line_width = pin.minimap and 60 or (pin.parentHeight * 0.05)

    -- apply user scaling
    size = size * MistsOfPandaria:GetOpt('poi_scale')
    line_width = line_width * MistsOfPandaria:GetOpt('poi_scale')

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
    head_length = head_length * MistsOfPandaria:GetOpt('poi_scale')
    head_width = head_width * MistsOfPandaria:GetOpt('poi_scale')
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

MistsOfPandaria.poi = {
    POI=POI,
    Glow=Glow,
    Path=Path,
    Line=Line,
    Arrow=Arrow
}


-------------------------------------------------------------------------------

MistsOfPandaria.expansion = 5

-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local Map = MistsOfPandaria.Map
local Rare = MistsOfPandaria.node.Rare

local Achievement = MistsOfPandaria.reward.Achievement
local Mount = MistsOfPandaria.reward.Mount

-------------------------------------------------------------------------------

local map = Map({ id=422, settings=true })

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

map.nodes[47606160] = Rare({
    id=69842,
    note=L["zandalari_warbringer_note"],
    rewards={
        Achievement({id=8078, criteria={
            {id=2, qty=true, suffix=L["zandalari_warbringer_killed"]}
        }}),
        Mount({item=94229, id=535}), -- Reins of the Slate Primordial Direhorn
        Mount({item=94230, id=534}), -- Reins of the Amber Primordial Direhorn
        Mount({item=94231, id=536}) -- Reins of the Jade Primordial Direhorn
    }
}) -- Zandalari Warbringer


-------------------------------------------------------------------------------

local map = Map({ id=371, settings=true })

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

map.nodes[52601900] = Rare({
    id=69842,
    note=L["zandalari_warbringer_note"],
    rewards={
        Achievement({id=8078, criteria={
            {id=2, qty=true, suffix=L["zandalari_warbringer_killed"]}
        }}),
        Mount({item=94229, id=535}), -- Reins of the Slate Primordial Direhorn
        Mount({item=94230, id=534}), -- Reins of the Amber Primordial Direhorn
        Mount({item=94231, id=536}) -- Reins of the Jade Primordial Direhorn
    }
}) -- Zandalari Warbringer


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

-- local ADDON_NAME, MistsOfPandaria = ...
-- local Map = MistsOfPandaria.Map

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

-- local map = Map({ id=418, settings=true })
-- local nodes = map.nodes




-------------------------------------------------------------------------------

local map = Map({ id=379, settings=true })

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

map.nodes[75006760] = Rare({
    id=69842,
    note=L["zandalari_warbringer_note"],
    rewards={
        Achievement({id=8078, criteria={
            {id=2, qty=true, suffix=L["zandalari_warbringer_killed"]}
        }}),
        Mount({item=94229, id=535}), -- Reins of the Slate Primordial Direhorn
        Mount({item=94230, id=534}), -- Reins of the Amber Primordial Direhorn
        Mount({item=94231, id=536}) -- Reins of the Jade Primordial Direhorn
    }
}) -- Zandalari Warbringer




-------------------------------------------------------------------------------

local map = Map({ id=388, settings=true })

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

map.nodes[36608560] = Rare({
    id=69842,
    note=L["zandalari_warbringer_note"],
    rewards={
        Achievement({id=8078, criteria={
            {id=2, qty=true, suffix=L["zandalari_warbringer_killed"]}
        }}),
        Mount({item=94229, id=535}), -- Reins of the Slate Primordial Direhorn
        Mount({item=94230, id=534}), -- Reins of the Amber Primordial Direhorn
        Mount({item=94231, id=536}) -- Reins of the Jade Primordial Direhorn
    }
}) -- Zandalari Warbringer


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

-- local ADDON_NAME, MistsOfPandaria = ...
-- local Map = MistsOfPandaria.Map

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

-- local map = Map({ id=390, settings=true })
-- local nodes = map.nodes


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

-- local ADDON_NAME, MistsOfPandaria = ...
-- local Map = MistsOfPandaria.Map

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

-- local map = Map({ id=376, settings=true })
-- local nodes = map.nodes


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

-- local ADDON_NAME, MistsOfPandaria = ...
-- local Map = MistsOfPandaria.Map

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

-- local map = Map({ id=504, settings=true })
-- local nodes = map.nodes


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local Node = MistsOfPandaria.node.Node
local NPC = MistsOfPandaria.node.NPC
local Treasure = MistsOfPandaria.node.Treasure

local Item = MistsOfPandaria.reward.Item
local Pet = MistsOfPandaria.reward.Pet
local Toy = MistsOfPandaria.reward.Toy

local Path = MistsOfPandaria.poi.Path
local POI = MistsOfPandaria.poi.POI

-------------------------------------------------------------------------------

local Rare = Class('TimelessRare', MistsOfPandaria.node.Rare)

function Rare:Render(tooltip)
    MistsOfPandaria.node.Rare.Render(self, tooltip)

    -- If two quests are given, the first is flipped the first time you ever
    -- loot the rare and the second is the daily tracker. On the first day, you
    -- can loot each rare twice.
    if self.quest and #self.quest == 2 then
        if not C_QuestLog.IsQuestFlaggedCompleted(self.quest[1]) then
            tooltip:AddLine(' ')
            tooltip:AddLine(MistsOfPandaria.color.Orange(L["looted_twice"]), 1, 1, 1, true)
        end
    end
end

-------------------------------------------------------------------------------

local map = Map({ id=554, settings=true })
local lostspirits = Map({ id=555 }) -- Cavern of Lost Spirits

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

map.nodes[34403250] = Rare({
    id=73666,
    quest={33288, 33312},
    note=L["archiereus_note"],
    rewards={
        Achievement({id=8714, criteria=31})
    },
    pois={
        POI({42805480}) -- Mistweaver Ku
    }
}) -- Archiereus of Flame

map.nodes[62097715] = Rare({
    id=72775,
    quest={33276, 33301},
    rewards={
        Achievement({id=8714, criteria=23986}),
        Achievement({id=8728, criteria=24034}), -- Gulp Froglet
        Pet({id=1338, item=104169}) -- Gulp Froglet
    },
    pois={
        POI({62097715, 63607260, 64807460, 65606980, 66806660}) -- Spawns
    }
}) -- Bufo

map.nodes[25063598] = Rare({
    id=72045,
    quest={33318, 32966},
    note=L["chelon_note"],
    rewards={
        Achievement({id=8714, criteria=23974}),
        Achievement({id=8728, criteria=24072}), -- Hardened Shell
        Toy({item=86584}) -- Hardened Shell
    }
}) -- Chelon

map.nodes[62384384] = Rare({
    id=73171,
    quest={33274, 33299},
    rewards={
        Achievement({id=8714, criteria=23996}),
        Achievement({id=8728, criteria={24055, 24074}}), -- Blackflame Daggers, Big Bag of Herbs
        Toy({item=104302}), -- Blackflame Daggers
        Item({item=106130}) -- Big Bag of Herbs
    },
    pois={
        Path({
            65426021, 67235734, 68225690, 69635427, 70635181, 71014722,
            69814461, 69044288, 66614262, 64434227, 62384384, 60624841
        })
    }
}) -- Champion of the Black Flame

map.nodes[52954988] = Rare({
    id=73175,
    quest={33286, 33310},
    rewards={
        Achievement({id=8714, criteria=23981}),
        Achievement({id=8728, criteria={24054, 24038}}), -- Falling Flame, Glowing Blue Ash
        Item({item=104299}), -- Falling Flame
        Item({item=104261}) -- Glowing Blue Ash
    }
}) -- Cinderfall

map.nodes[43896989] = Rare({
    id=72049,
    quest={33319, 32967},
    note=L["cranegnasher_note"],
    rewards={
        Achievement({id=8714, criteria=23976}),
        Achievement({id=8728, criteria=24041}), -- Pristine Stalker Hide
        Item({item=104268}) -- Pristine Stalker Hide
    },
    pois={
        POI({45238400}) -- Fishgorged Cranes
    }
}) -- Cranegnasher

map.nodes[26082283] = Rare({
    id=73281,
    quest={33290, 33314},
    requires=MistsOfPandaria.requirement.Item(104115),
    note=L["dread_ship_note"],
    rewards={
        Achievement({id=8714, criteria=23987}),
        Achievement({id=8728, criteria=24050}), -- Rime of the Time-Lost Mariner
        Toy({item=104294}) -- Rime of the Time-Lost Mariner
    },
    pois={
        POI({26322792}) -- Cursed Gravestone
    }
}) -- Dread Ship Vazuvius

map.nodes[30535067] = Rare({
    id=73158,
    quest={33261, 33295},
    note=L["emerald_gander_note"],
    rewards={
        Achievement({id=8714, criteria=23967})
    },
    pois={
        POI({
            29465012, 30076178, 30185857, 30535067, 30584364, 31286682,
            31386563, 31493965, 31517989, 31766262, 31958040, 32055222,
            32424870, 36224036, 36638408, 38334073, 39476853, 40594355,
            41074082, 42176766, 42706996, 44306167, 44755486, 45095358
        })
    }
}) -- Emerald Gander

map.nodes[14215240] = Rare({
    id=73279,
    quest={33289, 33313},
    note=L["evermaw_note"],
    rewards={
        Achievement({id=8714, criteria=23990}),
        Item({item=104115}) -- Mist-Filled Spirit Lantern
    },
    pois={
        Path({
            33019113, 30568918, 28068714, 25608463, 23658160, 22107833,
            20617473, 19057094, 17566721, 16116356, 14855997, 14375586,
            14255183, 14174775, 14094376, 14003959, 13923549, 14083139,
            15012764, 16212413, 17582050, 18941689, 20321337, 21931006,
            24860678, 27530425, 30750261, 34290222, 37810248, 42060284,
            45270305, 48090364, 51040433, 53980511, 56580581, 58950612,
            61680640, 64120704, 64140707, 66320848, 68531052, 70571266,
            72521474, 74181725, 75552016, 76852319, 78152623, 79212939,
            80083238, 80963554, 81603881, 81664251, 81514619, 81384975,
            81255324, 81035661, 80826003, 80626356, 80406708, 79597027,
            78627337, 77667631, 76607942, 75448221, 73748450, 72078649,
            70138864, 68099073, 66159267, 64269456, 62259625, 59859709,
            57379739, 55019758, 52569771, 49929782, 47529798, 45119807,
            42599776, 40289655, 38019499, 35819325, 33019113
        })
    }
}) -- Evermaw

map.nodes[44003400] = Rare({
    id=73172,
    quest={33285, 33309},
    rewards={
        Achievement({id=8714, criteria=23995}),
        Achievement({id=8728, criteria=24053}), -- Ordon Death Chime
        Item({item=104298, note=L["trinket"]}) -- Ordon Death Chime
    }
}) -- Flintlord Gairan

map.nodes[64002700] = Rare({
    id=73282,
    quest={33275, 33300},
    rewards={
        Achievement({id=8714, criteria=23982}),
        Achievement({id=8728, criteria=24027}), -- Ruby Droplet
        Pet({id=1328, item=104159}) -- Ruby Droplet
    }
}) -- Garnia

map.nodes[62086372] = Rare({
    id=72970,
    quest={33291, 33315},
    rewards={
        Achievement({id=8714, criteria=23988}),
        Achievement({id=8728, criteria={24039, 24040}}), -- Odd Polished Stone, Glinting Pile of Stone
        Toy({item=104262}), -- Odd Polished Stone
        Item({item=104263}) -- Glinting Pile of Stone
    }
}) -- Golganarr

map.nodes[24805500] = Rare({
    id=73161,
    quest={33272, 33297},
    note=L["great_turtle_furyshell_note"],
    rewards={
        Achievement({id=8714, criteria=23969}),
        Achievement({id=8728, criteria=24072}), -- Hardened Shell
        Toy({item=86584}) -- Hardened Shell
    },
    pois={
        Path({24134948, 23174726, 22024583, 21494263}),
        Path({24807031, 23146803, 22816508, 22856185}),
        POI({
            20724295, 21966163, 22096756, 22286598, 22354287, 22355353,
            22456783, 23155999, 23455775, 23584919, 23606338, 23665353,
            24565808, 24785905, 25165270, 25605832, 25645600, 25765788,
            25867230, 26045024
        }) -- Stationary spawns
    }
}) -- Great Turtle Furyshell

map.nodes[42387523] = Rare({
    id=72909,
    quest={33260, 33294},
    rewards={
        Achievement({id=8714, criteria=23970}),
        Achievement({id=8728, criteria={24047, 24046}}), -- Swarmling of Gu'chi, Sticky Silkworm Goo
        Pet({id=1345, item=104291}), -- Swarmling of Gu'chi
        Item({item=104290}) -- Sticky Silkworm Goo
    },
    pois={
        Path({
            41467211, 40916989, 38847014, 36256953, 34197060, 31987059,
            29937174, 31417454, 32287785, 33918004, 35928119, 38018272,
            40198236, 40647913, 42387523, 41467211
        })
    }
}) -- Gu'chi the Swarmbringer

map.nodes[65875660] = Rare({
    id=73167,
    quest={33287, 33311},
    rewards={
        Achievement({id=8714, criteria=23984}),
        Achievement({id=8728, criteria=24081}), -- Reins of the Thundering Onyx Cloud Serpent
        Mount({item=104269, id=561}) -- Thundering Onyx Cloud Serpent
    }
}) -- Huolon

map.nodes[28764361] = Rare({
    id=73163,
    quest={33278, 33303},
    note=L["imperial_python_note"],
    rewards={
        Achievement({id=8714, criteria=23989}),
        Achievement({id=8728, criteria=24029}), -- Death Adder Hatchling
        Pet({item=104161, id=1330}) -- Death Adder Hatchling
    },
    pois={
        POI({
            25914618, 27056896, 27656178, 28764361, 28916409, 29337383,
            30563630, 30907608, 33674610, 34057420, 36397405, 44316581,
            50684582, 53325823
        })
    }
}) -- Imperial Python

map.nodes[34046916] = Rare({
    id=73160,
    quest={33270, 33296},
    note=L["ironfur_steelhorn_note"],
    rewards={
        Achievement({id=8714, criteria=23968})
    },
    pois={
        POI({
            27024610, 27564009, 29937026, 32044588, 32564426, 33236147,
            33976228, 34046774, 34046916, 35026757, 35736952, 39976625,
            41046615, 41203741, 43905468, 44785287, 46046378
        })
    }
}) -- Ironfur Steelhorn

map.nodes[53298314] = Rare({
    id=73169,
    quest={33281, 33306},
    rewards={
        Achievement({id=8714, criteria=23994}),
        Achievement({id=8728, criteria=24068}), -- Warning Sign
        Toy({item=104331}) -- Warning Sign
    }
}) -- Jakur of Ordon

map.nodes[34088384] = Rare({
    id=72193,
    quest={33258, 33292},
    note=L["karkanos_note"],
    rewards={
        Achievement({id=8714, criteria=23973}),
        Achievement({id=8728, criteria=24079}), -- Giant Purse of Timeless Coins
        Item({item=104035}) -- Giant Purse of Timeless Coins
    }
}) -- Karkanos

map.nodes[67614423] = Rare({
    id=73277,
    quest={33273, 33298},
    rewards={
        Achievement({id=8714, criteria=23979}),
        Achievement({id=8728, criteria=24025}), -- Ashleaf Spriteling
        Pet({id=1323, item=104156}) -- Ashleaf Spriteling
    }
}) -- Leafmender

map.nodes[18036202] = Rare({
    id=73166,
    quest={33277, 33302},
    note=L["monstrous_spineclaw_note"],
    rewards={
        Achievement({id=8714, criteria=23985}),
        Achievement({id=8728, criteria=24033}), -- Spineclaw Crab
        Pet({item=104168, id=1337}) -- Spineclaw Crab
    },
    pois={
        POI({
            16103654, 16306071, 17377226, 17735384, 18036202, 18255509,
            18355853, 18767563, 20394765, 20717747, 20797142, 21053567,
            21153248, 21156353, 21913600, 22383043, 22793512, 23502794,
            23713527, 24727504, 25357482, 27517472, 27768033, 29368443,
            30743114, 33188564, 36068786, 40749101, 44778961, 52368699,
            62138293, 62508013, 65707822, 67937803, 68907404, 69947106,
            70466704, 71396302
        })
    }
}) -- Monstrous Spineclaw

map.nodes[60768795] = Rare({
    id=72048,
    quest=nil,
    note=L["rattleskew_note"],
    rewards={
        Achievement({id=8714, criteria=23977}),
        Achievement({id=8728, criteria=24065}), -- Captain Zvezdan's Lost Leg
        Item({item=104321, note=L["trinket"]}) -- Captain Zvezdan's Lost Leg
    }
}) -- Rattleskew

lostspirits.nodes[42153233] = Rare({
    id=73157,
    quest={33283, 33307},
    note=L["cavern_of_lost_spirits"],
    parent={ id=map.id, pois={POI({43624055})} },
    rewards={
        Achievement({id=8714, criteria=23980}),
        Achievement({id=8728, criteria=24063}), -- Golden Moss
        Item({item=104313, note=L["trinket"]}) -- Golden Moss
    }
}) -- Rock Moss

map.nodes[59004880] = Rare({
    id=71864,
    quest=32960, -- 33164
    note=L["spelurk_note"],
    rewards={
        Achievement({id=8714, criteria=23975}),
        Achievement({id=8728, criteria=24064}), -- Cursed Talisman
        Item({item=104320}) -- Cursed Talisman
    },
    pois={
        POI({
            22403870, 25007190, 32006150, 32603280, 33805450, 37704110,
            39607780, 42805540, 47308080, 48005120, 50407170, 52206260,
            55107290, 55305030, 55605930, 63104530, 64507230, 65405170,
            68406040
        }) -- Lost Artifact locations
    }
}) -- Spelurk

lostspirits.nodes[48116069] = Rare({
    id=72769,
    quest={33259, 33293},
    note=L["cavern_of_lost_spirits"],
    parent={ id=map.id, pois={POI({43624055})} },
    rewards={
        Achievement({id=8714, criteria=23978}),
        Achievement({id=8728, criteria={24060, 24037}}), -- Jadefire Spirit, Glowing Green Ash
        Pet({id=1348, item=104307}), -- Jadefire Spirit
        Item({item=104258}) -- Glowing Green Ash
    },
    pois={
        POI({
            48006094, 54797178, 55633192, 62283465, 65236484, 70776311,
            74443334
        }) -- Caverns spawns
    }
}) -- Spirit of Jadefire

map.nodes[71348293] = Rare({
    id=73704,
    quest={33280, 33305},
    rewards={
        Achievement({id=8714, criteria=24144})
    }
}) -- Stinkbraid

map.nodes[54094240] = Rare({
    id=72808,
    quest={33279, 33304},
    note=L["in_small_cave"],
    rewards={
        Achievement({id=8714, criteria=23983}),
        Achievement({id=8728, criteria=24041}), -- Pristine Stalker Hide
        Item({item=104268}) -- Pristine Stalker Hide
    }
}) -- Tsavo'ka

map.nodes[43002500] = Rare({
    id=73173,
    quest={33284, 33308},
    rewards={
        Achievement({id=8714, criteria=23993}),
        Achievement({id=8728, criteria=24059}), -- Sunset Stone
        Item({item=104306}) -- Sunset Stone
    }
}) -- Urdur the Cauterizer

map.nodes[57617660] = Rare({
    id=73170,
    quest={33321, 33322}, -- 44696
    rewards={
        Achievement({id=8714, criteria=23992}),
        Achievement({id=8728, criteria=24058}), -- Ashen Stone
        Item({item=104305}) -- Ashen Stone
    }
}) -- Watcher Osu

map.nodes[47008700] = Rare({
    id=72245,
    quest={32997, 33316},
    rewards={
        Achievement({id=8714, criteria=23971}),
        Achievement({id=8728, criteria=24056}), -- Rain Stone
        Item({item=104303}) -- Rain Stone
    }
}) -- Zesqua

map.nodes[37797773] = Rare({
    id=71919,
    quest={33317, 32959},
    note=L["zhugon_note"],
    rewards={
        Achievement({id=8714, criteria=23972}),
        Achievement({id=8728, criteria=24032}), -- Skunky Alemental
        Pet({item=104167, id=1336}) -- Skunky Alemental
    }
}) -- Zhu-Gon Sour

-------------------------------------------------------------------------------
---------------------------------- TREASURES ----------------------------------
-------------------------------------------------------------------------------

local MossCoveredChest = Class('MossCoveredChest', Treasure)

MossCoveredChest.label = L["moss_covered_chest"]
MossCoveredChest.icon = "chest_gn"
MossCoveredChest.rewards = {
    Achievement({id=8729, criteria=1})
}

map.nodes[36703410] = MossCoveredChest({ quest=33170 })
map.nodes[25502720] = MossCoveredChest({ quest=33171 })
map.nodes[27403910] = MossCoveredChest({ quest=33172 })
map.nodes[30703650] = MossCoveredChest({ quest=33173 })
map.nodes[22403540] = MossCoveredChest({ quest=33174 })
map.nodes[22104930] = MossCoveredChest({ quest=33175 })
map.nodes[24805300] = MossCoveredChest({ quest=33176 })
map.nodes[25704580] = MossCoveredChest({ quest=33177 })
map.nodes[22306810] = MossCoveredChest({ quest=33178 })
map.nodes[26806870] = MossCoveredChest({ quest=33179 })
map.nodes[31007630] = MossCoveredChest({ quest=33180 })
map.nodes[35307640] = MossCoveredChest({ quest=33181 })
map.nodes[38707160] = MossCoveredChest({ quest=33182 })
map.nodes[39807950] = MossCoveredChest({ quest=33183 })
map.nodes[34808420] = MossCoveredChest({ quest=33184 })
map.nodes[43608410] = MossCoveredChest({ quest=33185 })
map.nodes[47005370] = MossCoveredChest({ quest=33186 })
map.nodes[46704670] = MossCoveredChest({ quest=33187 })
map.nodes[51204570] = MossCoveredChest({ quest=33188 })
map.nodes[55504430] = MossCoveredChest({ quest=33189 })
map.nodes[58005070] = MossCoveredChest({ quest=33190 })
map.nodes[65704780] = MossCoveredChest({ quest=33191 })
map.nodes[63805920] = MossCoveredChest({ quest=33192 })
map.nodes[64907560] = MossCoveredChest({ quest=33193 })
map.nodes[60206600] = MossCoveredChest({ quest=33194 })
map.nodes[49706570] = MossCoveredChest({ quest=33195 })
map.nodes[53107080] = MossCoveredChest({ quest=33196 })
map.nodes[52706270] = MossCoveredChest({ quest=33197 })
map.nodes[61708850] = MossCoveredChest({ quest=33227 })
map.nodes[44206530] = MossCoveredChest({ quest=33198 })
map.nodes[26006140] = MossCoveredChest({ quest=33199 })
map.nodes[24603850] = MossCoveredChest({ quest=33200 })
map.nodes[59903130] = MossCoveredChest({ quest=33201 })
map.nodes[29703180] = MossCoveredChest({ quest=33202 })

lostspirits.nodes[62853535] = Treasure({
    quest=33203,
    label=L["skull_covered_chest"],
    note=L["cavern_of_lost_spirits"],
    parent={ id=map.id, pois={POI({43624055})} },
    rewards={
        Achievement({id=8729, criteria=2})
    }
}) -- Skull-Covered Chest

map.nodes[47602760] = Treasure({
    quest=33210,
    label=L["blazing_chest"],
    icon='chest_rd',
    rewards={
        Achievement({id=8729, criteria=24118})
    }
}) -- Blazing Chest

map.nodes[28203520] = Treasure({
    quest=33204,
    label=L["sturdy_chest"],
    note=L["sturdy_chest_note"],
    icon="chest_bn",
    rewards={
        Achievement({id=8729, criteria=4})
    }
}) -- Sturdy Chest

map.nodes[26806490] = Treasure({
    quest=33205,
    label=L["sturdy_chest"],
    note=L["sturdy_chest_note"],
    icon="chest_bn",
    rewards={
        Achievement({id=8729, criteria=4})
    }
}) -- Sturdy Chest

map.nodes[64607040] = Treasure({
    quest=33206,
    label=L["sturdy_chest"],
    icon="chest_bn",
    rewards={
        Achievement({id=8729, criteria=4})
    }
}) -- Sturdy Chest

map.nodes[59204950] = Treasure({
    quest=33207,
    label=L["sturdy_chest"],
    note=L["spelurk_cave"],
    icon="chest_bn",
    rewards={
        Achievement({id=8729, criteria=4})
    },
}) -- Sturdy Chest

map.nodes[69503290] = Treasure({
    quest=33208,
    label=L["smoldering_chest"],
    icon='chest_yw',
    rewards={
        Achievement({id=8729, criteria=5})
    }
}) -- Smoldering Chest

map.nodes[54007820] = Treasure({
    quest=33209,
    label=L["smoldering_chest"],
    icon='chest_yw',
    rewards={
        Achievement({id=8729, criteria=5})
    }
}) -- Smoldering Chest

-------------------------------------------------------------------------------
--------------------------- EXTREME TREASURE HUNTER ---------------------------
-------------------------------------------------------------------------------

map.nodes[49676941] = Treasure({
    quest=32969,
    note=L["gleaming_treasure_chest_note"],
    icon="star_chest_g",
    scale=1.5,
    rewards={
        Achievement({id=8726, criteria=24018})
    },
    pois={
        POI({51607460}),
        Path({51607460, 51157221, 51067103, 50596978, 49676941})
    }
}) -- Gleaming Treasure Chest

map.nodes[53934723] = Treasure({
    quest=32968,
    note=L["ropebound_treasure_chest_note"],
    icon="star_chest_g",
    scale=1.5,
    rewards={
        Achievement({id=8726, criteria=24019})
    },
    pois={
        POI({60204590}),
        Path({60204590, 57804728, 55144409, 53934723})
    }
}) -- Rope-Bound Treasure Chest

map.nodes[58506010] = Treasure({
    quest=32971,
    note=L["mist_covered_treasure_chest_note"],
    icon="star_chest_g",
    scale=1.5,
    rewards={
        Achievement({id=8726, criteria=24020})
    }
}) -- Mist-Covered Treasure Chest

-------------------------------------------------------------------------------
-------------------- WHERE THERE'S PIRATES, THERE'S BOOTY ---------------------
-------------------------------------------------------------------------------

map.nodes[22705890] = Treasure({
    quest=32956,
    note=L["in_water_cave"],
    icon="star_chest_g",
    scale=1.5,
    rewards={
        Achievement({id=8727, criteria=24022})
    },
    pois={
        POI({16905710}) -- Cave Entrance
    }
}) -- Blackguard's Jetsam

map.nodes[70608090] = Treasure({
    quest=32970,
    icon="star_chest_g",
    scale=1.5,
    note=L["gleaming_treasure_satchel_note"],
    rewards={
        Achievement({id=8727, criteria=24023})
    }
}) -- Gleaming Treasure Satchel

map.nodes[40409300] = Treasure({
    quest=32957,
    requires=MistsOfPandaria.requirement.Item(104015),
    icon="star_chest_g",
    scale=1.5,
    note=L["sunken_treasure_note"],
    rewards={
        Achievement({id=8727, criteria=24021}),
        Achievement({id=8728, criteria=24024}), -- Cursed Swabby Helmet
        Toy({item=134024}) -- Cursed Swabby Helmet
    }
}) -- Sunken Treasure

-------------------------------------------------------------------------------
-------------------------------- MISCELLANEOUS --------------------------------
-------------------------------------------------------------------------------

map.nodes[46177088] = Node({
    quest=32961,
    icon=132781,
    label=L["neverending_spritewood"],
    note=L["neverending_spritewood_note"],
    rewards={
        Achievement({id=8728, criteria=24028}), -- Dandelion Frolicker
        Pet({item=104160, id=1329}) -- Dandelion Frolicker
    }
})

lostspirits.nodes[53395699] = NPC({
    id=71876,
    icon=133730,
    quest=32962,
    note=L["cavern_of_lost_spirits"]..' '..L["zarhym_note"],
    parent={ id=map.id, pois={POI({43624055})} },
    rewards={
        Achievement({id=8743}) -- Zarhym Altogether
    }
}) -- Zarhym