-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 local Shadowlands = {}

-------------------------------------------------------------------------------
----------------------------------- COLORS ------------------------------------
-------------------------------------------------------------------------------

Shadowlands.COLORS = {
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

Shadowlands.color = {}
Shadowlands.status = {}

for name, color in pairs(Shadowlands.COLORS) do
    Shadowlands.color[name] = function (t) return string.format('|c%s%s|r', color, t) end
    Shadowlands.status[name] = function (t) return string.format('(|c%s%s|r)', color, t) end
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
    preparer = CreateDatamineTooltip("HandyNotes_Shadowlands_NamePreparer"),
    resolver = CreateDatamineTooltip("HandyNotes_Shadowlands_NameResolver")
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
        Shadowlands.Debug('ERROR: npc link not prepared:', link)
    end

    local name = self.cache[link]
    if name == nil then
        self.resolver:SetHyperlink(link)
        name = _G[self.resolver:GetName().."TextLeft1"]:GetText() or UNKNOWN
        if name == UNKNOWN then
            Shadowlands.Debug('NameResolver returned UNKNOWN, recreating tooltip ...')
            self.resolver = CreateDatamineTooltip("HandyNotes_Shadowlands_NameResolver")
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
            GetItemInfo(id) -- prime item info
        elseif type == 'daily' or type == 'quest' then
            C_QuestLog.GetTitleForQuestID(id) -- prime quest title
        elseif type == 'spell' then
            GetSpellInfo(id) -- prime spell info
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
            return Shadowlands.color.NPC(name)
        elseif type == 'achievement' then
            if nameOnly then
                local _, name = GetAchievementInfo(id)
                if name then return name end
            else
                local link = GetAchievementLink(id)
                if link then
                    return Shadowlands.GetIconLink('achievement', 15)..link
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
                if nameOnly then return name end
                return '|T'..icon..':0:0:1:-1|t '..link
            end
        elseif type == 'daily' or type == 'quest' then
            local name = C_QuestLog.GetTitleForQuestID(id)
            if name then
                if nameOnly then return name end
                local icon = (type == 'daily') and 'quest_ab' or 'quest_ay'
                return Shadowlands.GetIconLink(icon, 12)..Shadowlands.color.Yellow('['..name..']')
            end
        elseif type == 'spell' then
            local name, _, icon = GetSpellInfo(id)
            if name and icon then
                if nameOnly then return name end
                local spell = Shadowlands.color.Spell('|Hspell:'..id..'|h['..name..']|h')
                return '|T'..icon..':0:0:1:-1|t '..spell
            end
        end
        return type..'+'..id
    end)
    -- render non-numeric ids
    links, _ = links:gsub('{(%l+):([^}]+)}', function (type, id)
        if type == 'wq' then
            local icon = Shadowlands.GetIconLink('world_quest', 16, 0, -1)
            return icon..Shadowlands.color.Yellow('['..id..']')
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
    local db = _G["HandyNotes_ShadowlandsDB"]
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
    local L = AceLocale:NewLocale("HandyNotes", locale, (locale == 'enUS'), true)
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
    if class and Shadowlands.IsInstance(value, class) then return {value} end
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

Shadowlands.AsIDTable = AsIDTable
Shadowlands.AsTable = AsTable
Shadowlands.GetDatabaseTable = GetDatabaseTable
Shadowlands.NameResolver = NameResolver
Shadowlands.NewLocale = NewLocale
Shadowlands.PlayerHasItem = PlayerHasItem
Shadowlands.PrepareLinks = PrepareLinks
Shadowlands.RenderLinks = RenderLinks


-------------------------------------------------------------------------------
------------------------------------ CLASS ------------------------------------
-------------------------------------------------------------------------------

Shadowlands.Class = function (name, parent, attrs)
    if type(name) ~= 'string' then error('name param must be a string') end
    if parent and not Shadowlands.IsClass(parent) then error('parent param must be a class') end

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

Shadowlands.IsClass = function (class)
    return type(class) == 'table' and class.getters and class.setters
end

Shadowlands.IsInstance = function (instance, class)
    if type(instance) ~= 'table' then return false end
    local function compare (c1, c2)
        if c2 == nil then return false end
        if c1 == c2 then return true end
        return compare(c1, c2.__parent)
    end
    return compare(class, instance.__class)
end

Shadowlands.Clone = function (instance, newattrs)
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

 

local HandyNotes_Shadowlands = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_Shadowlands", "AceBucket-3.0", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes")
if not HandyNotes then return end

Shadowlands.locale = L
Shadowlands.maps = {}

_G["HandyNotes_Shadowlands"] = HandyNotes_Shadowlands

-------------------------------------------------------------------------------
----------------------------------- HELPERS -----------------------------------
-------------------------------------------------------------------------------

local DropdownMenu = CreateFrame("Frame", "HandyNotes_ShadowlandsDropdownMenu")
DropdownMenu.displayMode = "MENU"
local function InitializeDropdownMenu(level, mapID, coord)
    if not level then return end
    local node = Shadowlands.maps[mapID].nodes[coord]
    local spacer = {text='', disabled=1, notClickable=1, notCheckable=1}

    if (level == 1) then
        UIDropDownMenu_AddButton({
            text=L["context_menu_title"], isTitle=1, notCheckable=1
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
                        title = Shadowlands.RenderLinks(node.label, true),
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
                HandyNotes_Shadowlands.db.char[mapID..'_coord_'..coord] = true
                HandyNotes_Shadowlands:Refresh()
            end
        }, level)

        UIDropDownMenu_AddButton({
            text=L["context_menu_restore_hidden_nodes"], notCheckable=1,
            func=function ()
                wipe(HandyNotes_Shadowlands.db.char)
                HandyNotes_Shadowlands:Refresh()
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

function HandyNotes_Shadowlands:OnEnter(mapID, coord)
    local map = Shadowlands.maps[mapID]
    local node = map.nodes[coord]

    if self:GetCenter() > UIParent:GetCenter() then
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    end

    node:Render(GameTooltip, map:HasPOIs(node))
    map:SetFocus(node, true, true)
    Shadowlands.MinimapDataProvider:RefreshAllData()
    Shadowlands.WorldMapDataProvider:RefreshAllData()
    GameTooltip:Show()
end

function HandyNotes_Shadowlands:OnLeave(mapID, coord)
    local map = Shadowlands.maps[mapID]
    local node = map.nodes[coord]
    map:SetFocus(node, false, true)
    Shadowlands.MinimapDataProvider:RefreshAllData()
    Shadowlands.WorldMapDataProvider:RefreshAllData()
    GameTooltip:Hide()
end

function HandyNotes_Shadowlands:OnClick(button, down, mapID, coord)
    local map = Shadowlands.maps[mapID]
    local node = map.nodes[coord]
    if button == "RightButton" and down then
        DropdownMenu.initialize = function (_, level)
            InitializeDropdownMenu(level, mapID, coord)
        end
        ToggleDropDownMenu(1, nil, DropdownMenu, self, 0, 0)
    elseif button == "LeftButton" and down then
        if map:HasPOIs(node) then
            map:SetFocus(node, not node._focus)
            HandyNotes_Shadowlands:Refresh()
        end
    end
end

function HandyNotes_Shadowlands:OnInitialize()
    Shadowlands.class = select(2, UnitClass('player'))
    Shadowlands.faction = UnitFactionGroup('player')
    self.db = LibStub("AceDB-3.0"):New('HandyNotes_ShadowlandsDB', Shadowlands.optionDefaults, "Default")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", function ()
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        self:ScheduleTimer("RegisterWithHandyNotes", 1)
    end)

    -- Add global groups to settings panel
    Shadowlands.CreateGlobalGroupOptions()

    -- Add quick-toggle menu button to top-right corner of world map
    WorldMapFrame:AddOverlayFrame(
        "HandyNotes_ShadowlandsWorldMapOptionsButtonTemplate",
        "DROPDOWNTOGGLEBUTTON", "TOPRIGHT",
        WorldMapFrame:GetCanvasContainer(), "TOPRIGHT", -68, -2
    )

    -- Query localized expansion title
    if not Shadowlands.expansion then error('Expansion not set: HandyNotes_Shadowlands') end
    local expansion_name = EJ_GetTierInfo(Shadowlands.expansion)
    Shadowlands.plugin_name = 'HandyNotes: '..expansion_name
    Shadowlands.options.name = ('%02d - '):format(Shadowlands.expansion)..expansion_name
end

-------------------------------------------------------------------------------
------------------------------------ MAIN -------------------------------------
-------------------------------------------------------------------------------

function HandyNotes_Shadowlands:RegisterWithHandyNotes()
    do
        local map, minimap, force
        local function iter(nodes, precoord)
            if not nodes then return nil end
            if minimap and Shadowlands:GetOpt('hide_minimap') then return nil end
            local coord, node = next(nodes, precoord)
            while coord do -- Have we reached the end of this zone?
                if node and (force or map:IsNodeEnabled(node, coord, minimap)) then
                    local icon, scale, alpha = node:GetDisplayInfo(minimap)
                    return coord, nil, icon, scale, alpha
                end
                coord, node = next(nodes, coord) -- Get next node
            end
            return nil, nil, nil, nil
        end
        function HandyNotes_Shadowlands:GetNodes2(mapID, _minimap)
            if Shadowlands:GetOpt('show_debug_map') then
                Shadowlands.Debug('Loading nodes for map: '..mapID..' (minimap='..tostring(_minimap)..')')
            end

            map = Shadowlands.maps[mapID]
            minimap = _minimap
            force = Shadowlands:GetOpt('force_nodes') or Shadowlands.dev_force

            if map then
                map:Prepare()
                return iter, map.nodes, nil
            end

            -- mapID not handled by this plugin
            return iter, nil, nil
        end
    end

    if Shadowlands:GetOpt('development') then
        Shadowlands.BootstrapDevelopmentEnvironment()
    end

    HandyNotes:RegisterPluginDB("HandyNotes_Shadowlands", self, Shadowlands.options)

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

function HandyNotes_Shadowlands:Refresh()
    if self._refreshTimer then return end
    self._refreshTimer = C_Timer.NewTimer(0.1, function ()
        self._refreshTimer = nil
        self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_Shadowlands")
        Shadowlands.MinimapDataProvider:RefreshAllData()
        Shadowlands.WorldMapDataProvider:RefreshAllData()
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

Shadowlands.icons = { -- name => path

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

    paw_g = {Icon('paw_green'), Glow('paw')},
    paw_y = {Icon('paw_yellow'), Glow('paw')},

    peg_wb = {Icon('peg_white_blue'), Glow('peg')},
    peg_wg = {Icon('peg_white_green'), Glow('peg')},
    peg_wr = {Icon('peg_white_red'), Glow('peg')},
    peg_wy = {Icon('peg_white_yellow'), Glow('peg')},

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
    flight_point = {Icon('flight_point'), Glow('flight_point')},
    horseshoe = {Icon('horseshoe'), Glow('horseshoe')},
    left_mouse = {Icon('left_mouse'), nil},
    scroll = {Icon('scroll'), Glow('scroll')},
    world_quest = {Icon('world_quest'), Glow('world_quest')},

}

-------------------------------------------------------------------------------
------------------------------- HELPER FUNCTIONS ------------------------------
-------------------------------------------------------------------------------

local function GetIconPath(name)
    if type(name) == 'number' then return name end
    local info = Shadowlands.icons[name]
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
    local info = Shadowlands.icons[name]
    return info and info[2] or nil
end

Shadowlands.GetIconLink = GetIconLink
Shadowlands.GetIconPath = GetIconPath
Shadowlands.GetGlowPath = GetGlowPath


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 
local L = Shadowlands.locale

-------------------------------------------------------------------------------
---------------------------------- DEFAULTS -----------------------------------
-------------------------------------------------------------------------------

Shadowlands.optionDefaults = {
    profile = {
        -- visibility
        hide_done_rares = false,
        hide_minimap = false,
        maximized_enlarged = true,
        show_completed_nodes = false,
        use_char_achieves = false,

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

function Shadowlands:GetOpt(n) return HandyNotes_Shadowlands.db.profile[n] end
function Shadowlands:SetOpt(n, v) HandyNotes_Shadowlands.db.profile[n] = v; HandyNotes_Shadowlands:Refresh() end

function Shadowlands:GetColorOpt(n)
    local db = HandyNotes_Shadowlands.db.profile
    return db[n..'_R'], db[n..'_G'], db[n..'_B'], db[n..'_A']
end

function Shadowlands:SetColorOpt(n, r, g, b, a)
    local db = HandyNotes_Shadowlands.db.profile
    db[n..'_R'], db[n..'_G'], db[n..'_B'], db[n..'_A'] = r, g, b, a
    HandyNotes_Shadowlands:Refresh()
end

-------------------------------------------------------------------------------
--------------------------------- OPTIONS UI ----------------------------------
-------------------------------------------------------------------------------

Shadowlands.options = {
    type = "group",
    name = nil, -- populated in core.lua
    childGroups = "tab",
    get = function(info) return Shadowlands:GetOpt(info.arg) end,
    set = function(info, v) Shadowlands:SetOpt(info.arg, v) end,
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
                restore_all_nodes = {
                    type = "execute",
                    name = L["options_restore_hidden_nodes"],
                    desc = L["options_restore_hidden_nodes_desc"],
                    order = 16,
                    width = "full",
                    func = function ()
                        wipe(HandyNotes_Shadowlands.db.char)
                        HandyNotes_Shadowlands:Refresh()
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
                    set = function(_, ...) Shadowlands:SetColorOpt('poi_color', ...) end,
                    get = function() return Shadowlands:GetColorOpt('poi_color') end,
                    order = 22,
                },
                PATH_color = {
                    type = "color",
                    name = L["options_path_color"],
                    desc = L["options_path_color_desc"],
                    hasAlpha = true,
                    set = function(_, ...) Shadowlands:SetColorOpt('path_color', ...) end,
                    get = function() return Shadowlands:GetColorOpt('path_color') end,
                    order = 23,
                },
                restore_poi_colors = {
                    type = "execute",
                    name = L["options_reset_poi_colors"],
                    desc = L["options_reset_poi_colors_desc"],
                    order = 24,
                    width = "full",
                    func = function ()
                        local df = Shadowlands.optionDefaults.profile
                        Shadowlands:SetColorOpt('poi_color', df.poi_color_R, df.poi_color_G, df.poi_color_B, df.poi_color_A)
                        Shadowlands:SetColorOpt('path_color', df.path_color_R, df.path_color_G, df.path_color_B, df.path_color_A)
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

function Shadowlands.CreateGlobalGroupOptions()
    for i, group in ipairs({
        Shadowlands.groups.RARE,
        Shadowlands.groups.TREASURE,
        Shadowlands.groups.PETBATTLE,
        Shadowlands.groups.MISC
    }) do
        Shadowlands.options.args.GlobalTab.args['group_icon_'..group.name] = {
            type = "header",
            name = function () return Shadowlands.RenderLinks(group.label, true) end,
            order = i * 10,
        }

        Shadowlands.options.args.GlobalTab.args['icon_scale_'..group.name] = {
            type = "range",
            name = L["options_scale"],
            desc = L["options_scale_desc"],
            min = 0.3, max = 3, step = 0.01,
            arg = group.scaleArg,
            width = 1.13,
            order = i * 10 + 1,
        }

        Shadowlands.options.args.GlobalTab.args['icon_alpha_'..group.name] = {
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

function Shadowlands.CreateGroupOptions (map, group)
    -- Check if we've already initialized this group
    if _INITIALIZED[group.name..map.id] then return end
    _INITIALIZED[group.name..map.id] = true

    -- Create map options group under zones tab
    local options = Shadowlands.options.args.ZonesTab.args['Zone_'..map.id]
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
        Shadowlands.options.args.ZonesTab.args['Zone_'..map.id] = options
    end

    map._icons_order = map._icons_order or 0
    map._visibility_order = map._visibility_order or 0

    options.args.IconsGroup.args["icon_toggle_"..group.name] = {
        type = "toggle",
        arg = group.displayArg,
        name = function () return Shadowlands.RenderLinks(group.label, true) end,
        desc = function () return Shadowlands.RenderLinks(group.desc) end,
        disabled = function () return not group:IsEnabled() end,
        width = 0.9,
        order = map._icons_order
    }

    options.args.VisibilityGroup.args["header_"..group.name] = {
        type = "header",
        name = function () return Shadowlands.RenderLinks(group.label, true) end,
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
_G[plugins][#_G[plugins] + 1] = Shadowlands

local function BootstrapDevelopmentEnvironment()
    _G['HandyNotes_ZarPluginsDevelopment'] = true

    -- Add development settings to the UI
    Shadowlands.options.args.GeneralTab.args.DevelopmentHeader = {
        type = "header",
        name = L["options_dev_settings"],
        order = 100,
    }
    Shadowlands.options.args.GeneralTab.args.show_debug_map = {
        type = "toggle",
        arg = "show_debug_map",
        name = L["options_toggle_show_debug_map"],
        desc = L["options_toggle_show_debug_map_desc"],
        order = 101,
    }
    Shadowlands.options.args.GeneralTab.args.show_debug_quest = {
        type = "toggle",
        arg = "show_debug_quest",
        name = L["options_toggle_show_debug_quest"],
        desc = L["options_toggle_show_debug_quest_desc"],
        order = 102,
    }
    Shadowlands.options.args.GeneralTab.args.force_nodes = {
        type = "toggle",
        arg = "force_nodes",
        name = L["options_toggle_force_nodes"],
        desc = L["options_toggle_force_nodes_desc"],
        order = 103,
    }

    -- Print debug messages for each quest ID that is flipped
    local QTFrame = CreateFrame('Frame', "HandyNotes_ShadowlandsQT")
    local history = Shadowlands.GetDatabaseTable('quest_id_history')
    local lastCheck = GetTime()
    local quests = {}
    local changed = {}
    local max_quest_id = 100000

    local function DebugQuest(...)
        if Shadowlands:GetOpt('show_debug_quest') then Shadowlands.Debug(...) end
    end

    C_Timer.After(2, function ()
        -- Give some time for quest info to load in before we start
        for id = 0, max_quest_id do quests[id] = C_QuestLog.IsQuestFlaggedCompleted(id) end
        QTFrame:SetScript('OnUpdate', function ()
            if GetTime() - lastCheck > 1 and Shadowlands:GetOpt('show_debug_quest') then
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
    local IQFrame = CreateFrame('Frame', "HandyNotes_ShadowlandsIQ", WorldMapFrame)
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

_G['HandyNotes_ShadowlandsQuestHistory'] = function (count)
    local history = Shadowlands.GetDatabaseTable('quest_id_history')
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
_G['HandyNotes_ShadowlandsRemovePins'] = function ()
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

function Shadowlands.Debug(...)
    if not HandyNotes_Shadowlands.db then return end
    if Shadowlands:GetOpt('development') then print(Shadowlands.color.Blue('DEBUG:'), ...) end
end

function Shadowlands.Warn(...)
    if not HandyNotes_Shadowlands.db then return end
    if Shadowlands:GetOpt('development') then print(Shadowlands.color.Orange('WARN:'), ...) end
end

function Shadowlands.Error(...)
    if not HandyNotes_Shadowlands.db then return end
    if Shadowlands:GetOpt('development') then print(Shadowlands.color.Red('ERROR:'), ...) end
end

-------------------------------------------------------------------------------

Shadowlands.BootstrapDevelopmentEnvironment = BootstrapDevelopmentEnvironment


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 

local Class = Shadowlands.Class
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
    if Shadowlands.maps[self.id] then error('Map already registered: '..self.id) end
    Shadowlands.maps[self.id] = self
end

function Map:AddNode(coord, node)
    if not Shadowlands.IsInstance(node, Shadowlands.node.Node) then
        error(format('All nodes must be instances of the Node() class: %d %s', coord, tostring(node)))
    end

    if node.fgroup then
        if not self.fgroups[node.fgroup] then self.fgroups[node.fgroup] = {} end
        local fgroup = self.fgroups[node.fgroup]
        fgroup[#fgroup + 1] = coord
    end

    if node.group ~= Shadowlands.groups.QUEST then
        -- Initialize group defaults and UI controls for this map if the group does
        -- not inherit its settings and defaults from a parent map
        if self.settings then Shadowlands.CreateGroupOptions(self, node.group) end

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
            local map = Shadowlands.maps[parent.id] or Map({id=parent.id})
            map.nodes[HandyNotes:getCoord(px, py)] = Shadowlands.Clone(node, {pois=(parent.pois or false)})
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
    local db = HandyNotes_Shadowlands.db

    -- Check for dev force enable
    if Shadowlands:GetOpt('force_nodes') or Shadowlands.dev_force then return true end

    -- Check if the zone is still phased
    if node ~= self.intro and not self.phased then return false end

    -- Check if we've been hidden by the user
    if db.char[self.id..'_coord_'..coord] then return false end

    -- Minimap may be disabled for this node
    if not node.minimap and minimap then return false end

    -- Node may be faction restricted
    if node.faction and node.faction ~= Shadowlands.faction then return false end

    -- Check if node's group is disabled
    if not node.group:IsEnabled() then return false end

    -- Check for prerequisites and quest (or custom) completion
    if not node:IsEnabled() then return false end

    -- Display the node based off the group display setting
    return node.group:GetDisplay()
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

local MinimapPinsKey = "HandyNotes_ShadowlandsMinimapPins"
local MinimapDataProvider = CreateFrame("Frame", "HandyNotes_ShadowlandsMinimapDP")
local MinimapPinTemplate = 'HandyNotes_ShadowlandsMinimapPinTemplate'
local MinimapPinMixin = {}

_G['HandyNotes_ShadowlandsMinimapPinMixin'] = MinimapPinMixin

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
        pin = CreateFrame("Button", "HandyNotes_ShadowlandsPin"..(#self.pins + 1), Minimap, template)
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

    local map = Shadowlands.maps[HBD:GetPlayerZone()]
    if not map then return end

    for coord, node in pairs(map.nodes) do
        if node._prepared and map:IsNodeEnabled(node, coord, true) then
            -- If this icon has a glow enabled, render it
            local glow = node:GetGlow(true)
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

HandyNotes_Shadowlands:RegisterEvent('MINIMAP_UPDATE_ZOOM', function (...)
    MinimapDataProvider:RefreshAllData()
end)

HandyNotes_Shadowlands:RegisterEvent('CVAR_UPDATE', function (_, varname)
    if varname == 'ROTATE_MINIMAP' then
        MinimapDataProvider:RefreshAllData()
    end
end)

-------------------------------------------------------------------------------
--------------------------- WORLD MAP DATA PROVIDER ---------------------------
-------------------------------------------------------------------------------

local WorldMapDataProvider = CreateFromMixins(MapCanvasDataProviderMixin)
local WorldMapPinTemplate = 'HandyNotes_ShadowlandsWorldMapPinTemplate'
local WorldMapPinMixin = CreateFromMixins(MapCanvasPinMixin)

_G['HandyNotes_ShadowlandsWorldMapPinMixin'] = WorldMapPinMixin

function WorldMapDataProvider:RemoveAllData()
    if self:GetMap() then
        self:GetMap():RemoveAllPinsByTemplate(WorldMapPinTemplate)
    end
end

function WorldMapDataProvider:RefreshAllData(fromOnShow)
    self:RemoveAllData()

    if not self:GetMap() then return end
    local map = Shadowlands.maps[self:GetMap():GetMapID()]
    if not map then return end

    for coord, node in pairs(map.nodes) do
        if node._prepared and map:IsNodeEnabled(node, coord, false) then
            -- If this icon has a glow enabled, render it
            local glow = node:GetGlow(false)
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

Shadowlands.Map = Map
Shadowlands.MinimapDataProvider = MinimapDataProvider
Shadowlands.WorldMapDataProvider = WorldMapDataProvider




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
    Shadowlands.PrepareLinks(self.label)
    Shadowlands.PrepareLinks(self.desc)

    if attrs then
        for k, v in pairs(attrs) do self[k] = v end
    end

    self.alphaArg = 'icon_alpha_'..self.name
    self.scaleArg = 'icon_scale_'..self.name
    self.displayArg = 'icon_display_'..self.name

    local opt_defaults = Shadowlands.optionDefaults.profile
    if not self.defaults then self.defaults = {} end
    opt_defaults[self.alphaArg] = self.defaults.alpha or 1
    opt_defaults[self.scaleArg] = self.defaults.scale or 1
    opt_defaults[self.displayArg] = self.defaults.display ~= false
end

-- Override to hide this group in the UI under certain circumstances
function Group:IsEnabled()
    if self.class and self.class ~= Shadowlands.class then return false end
    if self.faction and self.faction ~= Shadowlands.faction then return false end
    return true
end

-- Get group settings
function Group:GetAlpha() return Shadowlands:GetOpt(self.alphaArg) end
function Group:GetScale() return Shadowlands:GetOpt(self.scaleArg) end
function Group:GetDisplay() return Shadowlands:GetOpt(self.displayArg) end

-- Set group settings
function Group:SetAlpha(v) Shadowlands:SetOpt(self.alphaArg, v) end
function Group:SetScale(v) Shadowlands:SetOpt(self.scaleArg, v) end
function Group:SetDisplay(v) Shadowlands:SetOpt(self.displayArg, v) end

-------------------------------------------------------------------------------

Shadowlands.Group = Group

Shadowlands.GROUP_HIDDEN = {display=false}
Shadowlands.GROUP_HIDDEN75 = {alpha=0.75, display=false}
Shadowlands.GROUP_ALPHA75 = {alpha=0.75}

Shadowlands.groups = {
    PETBATTLE = Group('pet_battles', 'paw_y'),
    QUEST = Group('quests', 'quest_ay'),
    RARE = Group('rares', 'skull_w', {defaults=Shadowlands.GROUP_ALPHA75}),
    TREASURE = Group('treasures', 'chest_gy', {defaults=Shadowlands.GROUP_ALPHA75}),
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
    return Shadowlands.PlayerHasItem(self.id, self.count)
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

Shadowlands.requirement = {
    Currency=Currency,
    GarrisonTalent=GarrisonTalent,
    Item=Item,
    Requirement=Requirement,
    Spell=Spell,
    WarMode=WarMode
}




local Group = Shadowlands.Group
local IsInstance = Shadowlands.IsInstance
local Requirement = Shadowlands.requirement.Requirement

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
    group = Shadowlands.groups.MISC
})

function Node:Initialize(attrs)
    -- assign all attributes
    if attrs then
        for k, v in pairs(attrs) do self[k] = v end
    end

    -- normalize table values
    self.quest = Shadowlands.AsTable(self.quest)
    self.questDeps = Shadowlands.AsTable(self.questDeps)
    self.parent = Shadowlands.AsIDTable(self.parent)
    self.requires = Shadowlands.AsTable(self.requires, Requirement)

    -- ensure proper group is assigned
    if not IsInstance(self.group, Group) then
        error('group attribute must be a Group class instance: '..self.group)
    end
end

--[[
Return the associated texture, scale and alpha value to pass to HandyNotes
for this node.
--]]

function Node:GetDisplayInfo(minimap)
    local icon = Shadowlands.GetIconPath(self.icon)
    local scale = self.scale * self.group:GetScale()
    local alpha = self.alpha * self.group:GetAlpha()

    if not minimap and WorldMapFrame.isMaximized and Shadowlands:GetOpt('maximized_enlarged') then
        scale = scale * 1.3 -- enlarge on maximized world map
    end

    return icon, scale, alpha
end

--[[
Return the glow POI for this node. If the node is hovered or focused, a green
glow is applyed to help highlight the node.
--]]

function Node:GetGlow(minimap)
    if self.glow and (self._focus or self._hover) then
        local _, scale, alpha = self:GetDisplayInfo(minimap)
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
        if not reward:IsObtained() then return false end
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
    if self.group == Shadowlands.groups.QUEST or not Shadowlands:GetOpt('show_completed_nodes') then
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
    if type(self.icon) == 'string' and Shadowlands.icons[self.icon] == nil then
        error('unknown icon: '..self.icon)
    end

    -- initialize glow POI (if glow icon available)

    if not self.glow then
        local icon = Shadowlands.GetGlowPath(self.icon)
        if icon then
            self.glow = Shadowlands.poi.Glow({ icon=icon })
        end
    end

    Shadowlands.PrepareLinks(self.label)
    Shadowlands.PrepareLinks(self.sublabel)
    Shadowlands.PrepareLinks(self.note)

    if self.requires then
        for i, req in ipairs(self.requires) do
            if IsInstance(req, Requirement) then
                Shadowlands.PrepareLinks(req:GetText())
            else
                Shadowlands.PrepareLinks(req)
            end
        end
    end
end

--[[
Render this node onto the given tooltip. Many features are optional depending
on the attributes set on this specific node, such as setting an `rlabel` or
`sublabel` value.
--]]

function Node:Render(tooltip, hasPOIs)
    -- render the label text with NPC names resolved
    tooltip:SetText(Shadowlands.RenderLinks(self.label, true))

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
        color = (count == #self.quest) and Shadowlands.status.Green or Shadowlands.status.Gray
        rlabel = rlabel..' '..color(tostring(count)..'/'..#self.quest)
    end

    if self.faction then
        rlabel = rlabel..' '..Shadowlands.GetIconLink(self.faction:lower(), 16, 1, -1)
    end

    if hasPOIs then
        -- add an rlabel hint to use left-mouse to focus the node
        local focus = Shadowlands.GetIconLink('left_mouse', 12)..Shadowlands.status.Gray(L["focus"])
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
        tooltip:AddLine(Shadowlands.RenderLinks(self.sublabel, true), 1, 1, 1)
    end

    -- display item, spell or other requirements
    if self.requires then
        for i, req in ipairs(self.requires) do
            if IsInstance(req, Requirement) then
                color = req:IsMet() and Shadowlands.color.White or Shadowlands.color.Red
                text = color(L["Requires"]..' '..req:GetText())
            else
                text = Shadowlands.color.Red(L["Requires"]..' '..req)
            end
            tooltip:AddLine(Shadowlands.RenderLinks(text, true))
        end
    end

    -- additional text for the node to describe how to interact with the
    -- object or summon the rare
    if self.note and Shadowlands:GetOpt('show_notes') then
        if self.requires or self.sublabel then tooltip:AddLine(" ") end
        tooltip:AddLine(Shadowlands.RenderLinks(self.note), 1, 1, 1, true)
    end

    -- all rewards (achievements, pets, mounts, toys, quests) that can be
    -- collected or completed from this node
    if self.rewards and Shadowlands:GetOpt('show_loot') then
        local firstAchieve, firstOther = true, true
        for reward in self:IterateRewards() do

            -- Add a blank line between achievements and other rewards
            local isAchieve = IsInstance(reward, Shadowlands.reward.Achievement)
            local isSpacer = IsInstance(reward, Shadowlands.reward.Spacer)
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
        if IsInstance(reward, Shadowlands.reward.Achievement) then
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
    group = Shadowlands.groups.QUEST,
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
    group = Shadowlands.groups.PETBATTLE
})

-------------------------------------------------------------------------------
------------------------------------ QUEST ------------------------------------
-------------------------------------------------------------------------------

local Quest = Class('Quest', Node, {
    note = AVAILABLE_QUEST,
    group = Shadowlands.groups.QUEST
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
    group = Shadowlands.groups.RARE
})

function Rare.getters:icon()
    return self:IsCollected() and 'skull_w' or 'skull_b'
end

function Rare:IsEnabled()
    if Shadowlands:GetOpt('hide_done_rares') and self:IsCollected() then return false end
    return NPC.IsEnabled(self)
end

function Rare:GetGlow(minimap)
    local glow = NPC.GetGlow(self, minimap)
    if glow then return glow end

    if _G['HandyNotes_ZarPluginsDevelopment'] and not self.quest then
        local _, scale, alpha = self:GetDisplayInfo(minimap)
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
    group = Shadowlands.groups.TREASURE
})

function Treasure.getters:label()
    for reward in self:IterateRewards() do
        if IsInstance(reward, Shadowlands.reward.Achievement) then
            return GetAchievementCriteriaInfoByID(reward.id, reward.criteria[1].id) or UNKNOWN
        end
    end
    return UNKNOWN
end

function Treasure:GetGlow(minimap)
    local glow = Node.GetGlow(self, minimap)
    if glow then return glow end

    if _G['HandyNotes_ZarPluginsDevelopment'] and not self.quest then
        local _, scale, alpha = self:GetDisplayInfo(minimap)
        self.glow.alpha = alpha
        self.glow.scale = scale
        self.glow.r, self.glow.g, self.glow.b = 1, 0, 0
        return self.glow
    end
end

-------------------------------------------------------------------------------

Shadowlands.node = {
    Node=Node,
    Collectible=Collectible,
    Intro=Intro,
    NPC=NPC,
    PetBattle=PetBattle,
    Quest=Quest,
    Rare=Rare,
    Treasure=Treasure
}






local Green = Shadowlands.status.Green
local Orange = Shadowlands.status.Orange
local Red = Shadowlands.status.Red

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
    if self.class and self.class ~= Shadowlands.class then return false end
    if self.faction and self.faction ~= Shadowlands.faction then return false end
    return true
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
            Shadowlands.Error('unknown achievement criteria ('..id..', '..criteria..')')
            return UNKNOWN
        end
    end
    return unpack(results)
end

function Achievement:Initialize(attrs)
    Reward.Initialize(self, attrs)
    self.criteria = Shadowlands.AsIDTable(self.criteria)
end

function Achievement:IsObtained()
    local _,_,_,completed,_,_,_,_,_,_,_,_,earnedByMe = GetAchievementInfo(self.id)
    completed = completed and (not Shadowlands:GetOpt('use_char_achieves') or earnedByMe)
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

function Achievement:Render(tooltip)
    local _,name,_,_,_,_,_,_,_,icon = GetAchievementInfo(self.id)
    local completed = self:IsObtained()
    if self.criteria and not self.oneline then
        tooltip:AddLine(ACHIEVEMENT_COLOR_CODE..'['..name..']|r')
        tooltip:AddTexture(icon, {margin={right=2}})
        for i, c in ipairs(self.criteria) do
            local cname,_,ccomp,qty,req = GetCriteriaInfo(self.id, c.id)
            if (cname == '' or c.qty) then
                cname = c.suffix or cname
                cname = (completed and req..'/'..req or qty..'/'..req)..' '..cname
            end

            local r, g, b = .6, .6, .6
            local ctext = "   ? "..cname
            if (completed or ccomp) then
                r, g, b = 0, 1, 0
            end

            local note, status = c.note
            if c.quest then
                if C_QuestLog.IsQuestFlaggedCompleted(c.quest) then
                    status = Shadowlands.status.Green(L['defeated'])
                else
                    status = Shadowlands.status.Red(L['undefeated'])
                end
                note = note and (note..'  '..status) or status
            end

            if note then
                tooltip:AddDoubleLine(ctext, note, r, g, b)
            else
                tooltip:AddLine(ctext, r, g, b)
            end
        end
    else
        local status = completed and Green(L['completed']) or Red(L['incomplete'])
        tooltip:AddDoubleLine(ACHIEVEMENT_COLOR_CODE..'['..name..']|r', status)
        tooltip:AddTexture(icon, {margin={right=2}})
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

    local line = Shadowlands.GetIconLink('quest_ay', 13)..' '..(name or UNKNOWN)
    tooltip:AddDoubleLine(line, status)
end

-------------------------------------------------------------------------------
------------------------------------ SPELL ------------------------------------
-------------------------------------------------------------------------------

local Spell = Class('Spell', Item)

function Spell:IsObtained()
    return IsSpellKnown(self.spell)
end

function Spell:Render(tooltip)
    local collected = IsSpellKnown(self.spell)
    local status = collected and Green(L["known"]) or Red(L["missing"])
    tooltip:AddDoubleLine(self.itemLink..' ('..L["spell"]..')', status)
    tooltip:AddTexture(self.itemIcon, {margin={right=2}})
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
    if sourceID then
        local infoReady, canCollect = CTC.PlayerCanCollectSource(sourceID)
        if infoReady and not canCollect then return true end
    end

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

Shadowlands.reward = {
    Reward=Reward,
    Section=Section,
    Spacer=Spacer,
    Achievement=Achievement,
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
_G["HandyNotes_ShadowlandsWorldMapOptionsButtonMixin"] = WorldMapOptionsButtonMixin

function WorldMapOptionsButtonMixin:OnLoad()
    UIDropDownMenu_SetInitializeFunction(self.DropDown, function (dropdown, level)
        dropdown:GetParent():InitializeDropDown(level)
    end)
    UIDropDownMenu_SetDisplayMode(self.DropDown, "MENU")

    self.GroupDesc = CreateFrame('Frame', 'HandyNotes_ShadowlandsGroupMenuSliderOption',
        nil, 'HandyNotes_ShadowlandsTextMenuOptionTemplate')
    self.AlphaOption = CreateFrame('Frame', 'HandyNotes_ShadowlandsAlphaMenuSliderOption',
        nil, 'HandyNotes_ShadowlandsSliderMenuOptionTemplate')
    self.ScaleOption = CreateFrame('Frame', 'HandyNotes_ShadowlandsScaleMenuSliderOption',
        nil, 'HandyNotes_ShadowlandsSliderMenuOptionTemplate')
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
    GameTooltip_SetTitle(GameTooltip, Shadowlands.plugin_name)
    GameTooltip_AddNormalLine(GameTooltip, L["map_button_text"])
    GameTooltip:Show()
end

function WorldMapOptionsButtonMixin:Refresh()
    local map = Shadowlands.maps[self:GetParent():GetMapID() or 0]
    if map and map:HasEnabledGroups() then self:Show() else self:Hide() end
end

function WorldMapOptionsButtonMixin:InitializeDropDown(level)
    if level == 1 then
        UIDropDownMenu_AddButton({
            isTitle = true,
            notCheckable = true,
            text = WORLD_MAP_FILTER_TITLE
        })

        local map, icon = Shadowlands.maps[self:GetParent():GetMapID()]

        for i, group in ipairs(map.groups) do
            if group:IsEnabled() then
                if type(group.icon) == 'number' then
                    icon = Shadowlands.GetIconLink(group.icon, 12, 1, 0)..' '
                else
                    icon = Shadowlands.GetIconLink(group.icon, 16)
                end
                UIDropDownMenu_AddButton({
                    text = icon..' '..Shadowlands.RenderLinks(group.label, true),
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
            checked = Shadowlands:GetOpt('show_completed_nodes'),
            func = function (button, option)
                Shadowlands:SetOpt('show_completed_nodes', button.checked)
            end
        })
        UIDropDownMenu_AddButton({
            text = L["options_toggle_use_char_achieves"],
            isNotRadio = true,
            keepShownOnClick = true,
            checked = Shadowlands:GetOpt('use_char_achieves'),
            func = function (button, option)
                Shadowlands:SetOpt('use_char_achieves', button.checked)
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
                    'HandyNotes', 'plugins', 'HandyNotes_Shadowlands', 'ZonesTab', 'Zone_'..map.id
                )
            end
        })
    elseif level == 2 then
        -- Get correct map ID to query/set options for
        local group = UIDROPDOWNMENU_MENU_VALUE

        self.GroupDesc.Text:SetText(Shadowlands.RenderLinks(group.desc))
        UIDropDownMenu_AddButton({ customFrame = self.GroupDesc }, 2)
        UIDropDownMenu_AddButton({
            notClickable = true,
            notCheckable = true
        }, 2)

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

 

local HBD = LibStub('HereBeDragons-2.0')

local CIRCLE = "Interface\\AddOns\\HandyNotes\\Icons\\artwork\\circle"
local LINE = "Interface\\AddOns\\HandyNotes\\Icons\\artwork\\line"

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
    size = size * Shadowlands:GetOpt('poi_scale')
    t:SetVertexColor(unpack({Shadowlands:GetColorOpt('poi_color')}))
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
    t:SetVertexColor(unpack({Shadowlands:GetColorOpt('path_color')}))
    t:SetTexture(type)

    -- constant size for minimaps, variable size for world maps
    local size = pin.minimap and 5 or (pin.parentHeight * 0.005)
    local line_width = pin.minimap and 60 or (pin.parentHeight * 0.05)

    -- apply user scaling
    size = size * Shadowlands:GetOpt('poi_scale')
    line_width = line_width * Shadowlands:GetOpt('poi_scale')

    if type == CIRCLE then
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
    map:AcquirePin(template, self, CIRCLE, self.corner1)
    map:AcquirePin(template, self, CIRCLE, self.corner2)
    map:AcquirePin(template, self, LINE, self.corner1, self.path[#self.path])
    map:AcquirePin(template, self, LINE, self.corner2, self.path[#self.path])
    map:AcquirePin(template, self, LINE, self.corner1, self.corner2)
end

-------------------------------------------------------------------------------

Shadowlands.poi = {
    POI=POI,
    Glow=Glow,
    Path=Path,
    Line=Line,
    Arrow=Arrow
}


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 



local Map = Shadowlands.Map

-------------------------------------------------------------------------------

Shadowlands.expansion = 9

-------------------------------------------------------------------------------
------------------------------------ ICONS ------------------------------------
-------------------------------------------------------------------------------

local ICONS = "Interface\\Addons\\HandyNotes\\Icons\\artwork\\Icons"
local function Icon(name) return ICONS..'\\'..name..'.blp' end

Shadowlands.icons.cov_sigil_ky = {Icon('covenant_kyrian'), nil}
Shadowlands.icons.cov_sigil_nl = {Icon('covenant_necrolord'), nil}
Shadowlands.icons.cov_sigil_nf = {Icon('covenant_nightfae'), nil}
Shadowlands.icons.cov_sigil_vn = {Icon('covenant_venthyr'), nil}

-------------------------------------------------------------------------------
---------------------------------- CALLBACKS ----------------------------------
-------------------------------------------------------------------------------

HandyNotes_Shadowlands:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED', function (...)
    -- Watch for a spellcast event that signals the kitten was pet.
    -- https://www.wowhead.com/spell=321337/petting
    -- Watch for a spellcast event for collecting a shard
    -- https://shadowlands.wowhead.com/spell=335400/collecting
    local _, source, _, spellID = ...
    if source == 'player' and (spellID == 321337 or spellID == 335400) then
        C_Timer.After(1, function() HandyNotes_Shadowlands:Refresh() end)
    end
end)

-------------------------------------------------------------------------------
---------------------------------- COVENANTS ----------------------------------
-------------------------------------------------------------------------------

Shadowlands.covenants = {
    KYR = { id = 1, icon = 'cov_sigil_ky' },
    VEN = { id = 2, icon = 'cov_sigil_vn' },
    FAE = { id = 3, icon = 'cov_sigil_nf' },
    NEC = { id = 4, icon = 'cov_sigil_nl' }
}

local function ProcessCovenant (node)
    if node.covenant == nil then return end
    local data = C_Covenants.GetCovenantData(node.covenant.id)

    -- Add covenant sigil to top-right corner of tooltip
    node.rlabel = Shadowlands.GetIconLink(node.covenant.icon, 13)

    if not node._covenantProcessed then
        local subl = Shadowlands.color.Orange(string.format(L["covenant_required"], data.name))
        node.sublabel = node.sublabel and subl..'\n'..node.sublabel or subl
        node._covenantProcessed = true
    end
end

-------------------------------------------------------------------------------
----------------------------------- GROUPS ------------------------------------
-------------------------------------------------------------------------------

Shadowlands.groups.ANIMA_SHARD = Group('anima_shard', 'crystal_b', {defaults=Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.BONUS_BOSS = Group('bonus_boss', 'peg_wr')
Shadowlands.groups.BONUS_EVENT = Group('bonus_event', 'peg_wy')
Shadowlands.groups.CARRIAGE = Group('carriages', 'horseshoe')
Shadowlands.groups.RIFTSTONE = Group('riftstone', 'portal_b')
Shadowlands.groups.SLIME_CAT = Group('slime_cat', 3732497, {defaults=Shadowlands.GROUP_HIDDEN})

-------------------------------------------------------------------------------
------------------------------------ MAPS -------------------------------------
-------------------------------------------------------------------------------

local SLMap = Class('ShadowlandsMap', Map)

function SLMap:Prepare ()
    Map.Prepare(self)
    for coord, node in pairs(self.nodes) do
        -- Update rlabel and sublabel for covenant-restricted nodes
        ProcessCovenant(node)
    end
end

Shadowlands.Map = SLMap

-------------------------------------------------------------------------------
--------------------------------- REQUIREMENTS --------------------------------
-------------------------------------------------------------------------------

local Venari = Class('Venari', Shadowlands.requirement.Requirement)

function Venari:Initialize(quest)
    self.text = L["venari_upgrade"]
    self.quest = quest
end

function Venari:IsMet()
    return C_QuestLog.IsQuestFlaggedCompleted(self.quest)
end

Shadowlands.requirement.Venari = Venari

-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 




local PetBattle = Shadowlands.node.PetBattle
local Rare = Shadowlands.node.Rare
local Treasure = Shadowlands.node.Treasure

local Achievement = Shadowlands.reward.Achievement
local Item = Shadowlands.reward.Item
local Mount = Shadowlands.reward.Mount
local Pet = Shadowlands.reward.Pet
local Quest = Shadowlands.reward.Quest
local Transmog = Shadowlands.reward.Transmog
local Toy = Shadowlands.reward.Toy

local Path = Shadowlands.poi.Path
local POI = Shadowlands.poi.POI

-------------------------------------------------------------------------------

local NIGHTFAE = Shadowlands.covenants.FAE
local map = Map({ id=1565, settings=true })

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

map.nodes[34606800] = Rare({
    id=164477,
    quest=59226,
    rewards={
        Achievement({id=14309, criteria=48714})
    }
}) -- Deathbinder Hroth

map.nodes[47522845] = Rare({
    id=164238,
    quest={59201,62271},
    note=L["deifir_note"],
    rewards={
        Achievement({id=14309, criteria=48784}),
        Pet({item=180631, id=2920}) -- Gorm Needler
    },
    pois={
        Path({
            47522845, 48052741, 48692650, 49172530, 49652403, 49022308, 48842184,
            48162099, 47362116, 46712135, 46332211, 46432338, 46452445, 46602590,
            46932693, 47112793, 47522845
        })
    }
}) -- Deifir the Untamed

map.nodes[48397717] = Rare({
    id=163229,
    quest=58987,
    rewards={
        Achievement({id=14309, criteria=48794})
    }
}) -- Dustbrawl

map.nodes[57862955] = Rare({
    id=167851,
    quest=60266,
    note=L["lehgo_note"],
    rewards={
        Achievement({id=14309, criteria=48790})
    }
}) -- Egg-Tender Leh'go

map.nodes[68612765] = Rare({
    id=171688,
    quest=61184,
    note=L["faeflayer_note"],
    rewards={
        Achievement({id=14309, criteria=48798})
    }
}) -- Faeflayer

map.nodes[54067601] = Rare({
    id=163370,
    quest=59006,
    rewards={
        Achievement({id=14309, criteria=48795}),
        Pet({item=183196, id=3035}) -- Lavender Nibbler
    }
}) -- Gormbore

map.nodes[27885248] = Rare({
    id=164107,
    quest=59145,
    rewards={
        Achievement({id=14309, criteria=48781}),
        Mount({item=180725, id=1362}) -- Spinemaw Gladechewer
    }
}) -- Gormtamer Tizo

map.nodes[32423026] = Rare({
    id=164112,
    quest=59157,
    requires=Shadowlands.requirement.Item(175247),
    note=L["humongozz_note"],
    rewards={
        Achievement({id=14309, criteria=48782}),
        Mount({item=182650, id=1415}) -- Arboreal Gulper
    }
}) -- Humon'gozz

map.nodes[67465147] = Rare({
    id=160448,
    quest=59221,
    rewards={
        Achievement({id=14309, criteria=48787}),
        Transmog({item=179596, slot=L["cosmetic"]}), -- Drust Mask of Dominance
        Quest({id=62246}) -- A Fallen Friend
    }
}) -- Hunter Vivian

-- Mysterious Mushroom Ring (36474814)
-- Mysterious Mushroom Ring (47924018)

-- map.nodes[] = Rare({
--     id=164093,
--     quest=nil,
--     rewards={
--         Achievement({id=14309, criteria=48780}),
--         Pet({item=180644, id=2907}) -- Rocky
--     }
-- }) -- Macabre

map.nodes[62102470] = Rare({
    id=165053,
    quest=nil,
    rewards={
        Achievement({id=14309, criteria=48788})
    }
}) -- Mymaen

local RainbowGlow = Class('RainbowGlow', Shadowlands.poi.Glow)

function RainbowGlow:Draw(pin, xy)
    local r, g, b, diff = 10, 0, 0, 1
    pin.ticker = C_Timer.NewTicker(0.05, function ()
        if r == 0 and g > b then b = b + diff
        elseif g == 0 and b > r then r = r + diff
        elseif b == 0 and r > g then g = g + diff
        elseif r == 0 and g <= b then g = g - diff
        elseif g == 0 and b <= r then b = b - diff
        elseif b == 0 and r <= g then r = r - diff
        end
        pin.texture:SetVertexColor(r/10, g/10, b/10, 1)
    end)
    self.r, self.g, self.b, self.a = 1, 0, 0, 1
    return Shadowlands.poi.Glow.Draw(self, pin, xy)
end

map.nodes[50092091] = Rare({
    id=164547,
    quest=59235,
    note=L["rainbowhorn_note"],
    glow=RainbowGlow({ icon=Shadowlands.GetGlowPath('skull_w') }),
    rewards={
        Achievement({id=14309, criteria=48715}),
        Item({item=182179, quest=62434}) -- Runestag Soul
    }
}) -- Mystic Rainbowhorn

map.nodes[57874983] = Rare({
    id=168135,
    quest=60306,
    covenant=NIGHTFAE,
    requires=Shadowlands.requirement.Item(178675),
    note=L["night_mare_note"],
    rewards={
        Achievement({id=14309, criteria=48793}),
        Mount({item=180728, id=1306}) -- Swift Gloomhoof
    },
    pois={
        Path({
            59175611, 59905695, 60875610, 62155544, 62445355, 62145199,
            62075045, 61664920, 60634907, 59524941, 58534879, 57874983
        }), -- Night Mare
        Path({18356218, 17576184, 17756284, 18916346, 19776344}), -- Broken Soulweb
        POI({50413303}) -- Elder Gwenna
    }
}) -- Night Mare

map.nodes[51105740] = Rare({
    id=164391,
    quest={59208,62270},
    note=L["old_ardeite_note"],
    rewards={
        Achievement({id=14309, criteria=48785}),
        Pet({item=180643, id=2908}) -- Chirpy Valeshrieker
    }
}) -- Old Ardeite

map.nodes[65104430] = Rare({
    id=167726,
    quest=60273,
    note=L["rootwrithe_note"],
    rewards={
        Achievement({id=14309, criteria=48791})
    }
}) -- Rootwrithe

map.nodes[65702430] = Rare({
    id=167724,
    quest=60258,
    note=L["rotbriar_note"],
    rewards={
        Achievement({id=14309, criteria=48789}),
        Item({item=175729, note=L["trinket"]}) -- Rotbriar Sprout
    }
}) -- Rotbriar Changeling

map.nodes[72425175] = Rare({
    id=171451,
    quest=61177,
    rewards={
        Achievement({id=14309, criteria=48797}),
        Transmog({item=180164, slot=L["staff"]}) -- Soultwister's Scythe
    }
}) -- Soultwister Cero

map.nodes[37675917] = Rare({
    id=164415,
    quest=59220,
    covenant=NIGHTFAE,
    note=L["skuld_vit_note"],
    rewards={
        Achievement({id=14309, criteria=48786}),
        Item({item=182183, quest=62439}) -- Wolfhawk Soul
    }
}) -- Skuld Vit

map.nodes[59304660] = Rare({
    id=167721,
    quest=60290,
    note=L["slumbering_note"],
    rewards={
        Achievement({id=14309, criteria=48792})
    }
}) -- The Slumbering Emperor

map.nodes[30115536] = Rare({
    id=168647,
    quest=61632,
    covenant=NIGHTFAE,
    requires=Shadowlands.requirement.GarrisonTalent(1247, L["anima_channeled"]),
    note=L["valfir_note"],
    rewards={
        Achievement({id=14309, criteria=48796}),
        Mount({item=180730, id=1393}), -- Glimmerfur Prowler
        Item({item=182176, quest=62431}) -- Shadowstalker Soul
    },
    pois={
        Path({29265611, 30115536, 30875464})
    }
}) -- Valfir the Unrelenting

map.nodes[58306180] = Rare({
    id=164147,
    quest=59170,
    note=L["wrigglemortis_note"],
    rewards={
        Achievement({id=14309, criteria=48783})
    }
}) -- Wrigglemortis

--------------------------- STAR LAKE AMPHITHEATER ----------------------------

map.nodes[41254443] = Rare({
    id=171743,
    quest=61633,
    covenant=NIGHTFAE,
    requires=Shadowlands.requirement.GarrisonTalent(1244, L["anima_channeled"]),
    label=L["star_lake"],
    note=L["star_lake_note"],
    rewards = {
        Achievement({id=14353, criteria={
            48708, -- Argus
            48709, -- Azshara
            48706, -- Gul'dan
            48704, -- Jaina
            48707, -- Kil'jaeden
            48710, -- N'Zoth
            48705  -- Xavius
        }})
    }
})

-------------------------------------------------------------------------------
---------------------------------- TREASURES ----------------------------------
-------------------------------------------------------------------------------

map.nodes[56002101] = Treasure({
    quest=61072,
    rewards={
        Achievement({id=14313, criteria=50031}),
        Pet({item=180630, id=2921}) -- Gorm Harrier
    }
}) -- Aerto's Body

map.nodes[63893778] = Treasure({
    quest=61074,
    note=L["cache_of_the_moon"],
    rewards={
        Achievement({id=14313, criteria=50039}),
        Mount({item=180731, id=1397}) -- Wildseed Cradle
    },
    pois={
        POI({
            38995696, -- Diary of the Night
            39755440, -- Gardener's Hammer
            40315262, -- Gardener's Basket
            38495808, -- Gardener's Flute
            38856010, -- Gardener's Wand
        })
    }
}) -- Cache of the Moon

map.nodes[36236527] = Treasure({
    quest=61110,
    requires=Shadowlands.requirement.Item(180652),
    note=L["cache_of_the_night"],
    rewards={
        Achievement({id=14313, criteria=50044}),
        Pet({item=180637, id=2914}) -- Starry Dreamfoal
    }, pois={
        POI({
            42414672, -- Enchanted Bough
            51556160, -- Fae Ornament
            36982983  -- Raw Dream Silk
        })
    }
}) -- Cache of the Night

map.nodes[37646159] = Treasure({
    quest=61068,
    note=L["darkreach_supplies"],
    rewards={
        Achievement({id=14313, criteria=50045}),
        Transmog({item=179594, slot=L["leather"]}) -- Witherscorn Guise
    },
    pois={
        Path({37646159, 37166279, 36686399, 36196520})
    }
}) -- Darkreach Supplies

map.nodes[41953253] = Treasure({
    quest=61147,
    note=L["desiccated_moth"],
    rewards={
        Achievement({id=14313, criteria=50040}),
        Pet({item=180640, id=2911}) -- Amber Glitterwing
    },
    pois={
        POI({41413161}), -- Bounding Shroom
        POI({31763247}) -- Aromatic Flowers
    }
}) -- Desiccated Moth

map.nodes[37683688] = Treasure({
    quest=61070,
    note=L["dreamsong_heart"],
    rewards={
        Achievement({id=14313, criteria=50041}),
        Transmog({item=179510, slot=L["warglaive"]}) -- Dreamsong Warglaive
    },
    pois={
        POI({38013631}) -- Bounding Shroom
    }
}) -- Dreamsong Heart

map.nodes[44827587] = Treasure({
    quest=61175,
    note=L["elusive_faerie_cache"],
    rewards={
        Achievement({id=14313, criteria=50043}),
        Transmog({item=179512, slot=L["1h_sword"]}) -- Dreamsong Saber
    },
    pois={
        Path({
            44827587, 44477530, 44417436, 44647334, 44877246, 45057161,
            45417087, 45837033, 46497011
        }) -- to Faerie Lamp
    }
}) -- Elusive Faerie Cache

map.nodes[36422506] = Treasure({
    quest=62259,
    note=L["enchanted_dreamcatcher"],
    rewards={
        Achievement({id=14313, criteria=50042}),
        Item({item=183129, quest=62259}) -- Anima-Laden Dreamcatcher
    }
}) -- Enchanted Dreamcatcher

map.nodes[49715589] = Treasure({
    quest=61073,
    note=L["faerie_trove"],
    rewards={
        Achievement({id=14313, criteria=50035}),
        Pet({item=182673, id=3022}) -- Shimmerbough Hoarder
    }
}) -- Faerie Trove

map.nodes[67803462] = Treasure({
    quest=61165,
    note=L["harmonic_chest"],
    rewards={
        Achievement({id=14313, criteria=50036})
    }
}) -- Harmonic Chest

map.nodes[48213927] = Treasure({
    quest=61067,
    note=L["hearty_dragon_plume"],
    rewards={
        Achievement({id=14313, criteria=50037}),
        Toy({item=182729}) -- Hearty Dragon Plume
    },
    pois={
        POI({46424032, 48964102, 50084159})
    }
}) -- Hearty Dragon Plume

map.nodes[48282031] = Treasure({
    quest=62187,
    rewards={
        Achievement({id=14313, criteria=50032}),
        Item({item=182731, quest=62187}) -- Satchel of Culexwood
    }
}) -- Lost Satchel

map.nodes[31764100] = Treasure({
    quest={61080, 61081, 61084, 61085, 61086},
    questCount=true,
    note=L["playful_vulpin_note"],
    rewards={
        Achievement({id=14313, criteria=50038}),
        Pet({item=180645, id=2905}) -- Dodger
    },
    pois={
        POI({
            31764100, 31854363, 32604292, 34104500, 40082870, 40722741,
            40945156, 41312874, 41902742, 41374979, 50215353, 51165507,
            65222265, 67162888, 67553191, 69003036, 70143004, 72393146
        }) -- Possible spawns
    }
}) -- Playful Vulpin Befriended (171206)

map.nodes[76672974] = Treasure({
    quest=62186,
    note=L["swollen_anima_seed"],
    rewards={
        Achievement({id=14313, criteria=50034}),
        Item({item=182730, quest=62186}) -- Swollen Anima Seed
    }
}) -- Swollen Anima Seed

map.nodes[26285897] = Treasure({
    quest=61192, -- 61208 = failed, 61198 = passed
    label=L["tame_gladerunner"],
    note=L["tame_gladerunner_note"],
    rewards={
        Mount({item=180727, id=1360}) -- Shimmermist Runner
    },
    pois={
        Path({
            32545304, 32005370, 31345426, 30745484, 30115532, 29455591,
            29735683, 30015767, 29335798, 29385915, 28725860, 28205819,
            27515788, 26985831, 26285897
        })
    }
}) -- Tame Gladerunner

map.nodes[52943729] = Treasure({
    quest=61065,
    rewards={
        Achievement({id=14313, criteria=50033}),
        Pet({item=180642, id=2909}) -- Downfeather Ragewing
    }
}) -- Veilwing Egg (Ancient Cloudfeather Egg)

-------------------------------------------------------------------------------
--------------------------------- BATTLE PETS ---------------------------------
-------------------------------------------------------------------------------

map.nodes[39956449] = PetBattle({
    id=173376,
    rewards={
        Achievement({id=14625, criteria=49404})
    }
}) -- Nightfang

map.nodes[40192880] = PetBattle({
    id=173381,
    rewards={
        Achievement({id=14625, criteria=49402})
    }
}) -- Rascal

map.nodes[51274406] = PetBattle({
    id=173377,
    rewards={
        Achievement({id=14625, criteria=49403})
    }
}) -- Faryl

map.nodes[58205690] = PetBattle({
    id=173372,
    rewards={
        Achievement({id=14625, criteria=49405})
    }
}) -- Glitterdust

-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 




local Node = Shadowlands.node.Node














-------------------------------------------------------------------------------

local KYRIAN = Shadowlands.covenants.KYR

local map = Map({ id = 1533, settings=true })

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

map.nodes[32592336] = Rare({
    id=171211,
    quest=61083,
    requires=Shadowlands.requirement.Item(180613),
    note=L["aspirant_eolis_note"],
    rewards={
        Achievement({id=14307, criteria=50613}),
        Transmog({item=183607, slot=L["polearm"]}) -- Uncertain Aspirant's Spear
    },
    pois={
        POI({
            31412295, 31412386, 32052123, 32122305, 32332113, 32562449,
            32762035, 33062071, 33172321,
        }) -- Fragile Humility Scroll
    }
}) -- Aspirant Eolis

map.nodes[51344080] = Rare({
    id=160629,
    quest={58648,62192},
    note=L["baedos_note"],
    rewards={
        Achievement({id=14307, criteria=50592})
    }
}) -- Baedos

map.nodes[48985031] = Rare({
    id=170659,
    quest={60897,62158},
    note=L["basilofos_note"],
    rewards={
        Achievement({id=14307, criteria=50602}),
        Toy({item=182655}) -- Hill King's Roarbox
    }
}) -- Basilofos, King of the Hill

map.nodes[55358024] = Rare({
    id=161527,
    label=L["beasts_of_bastion"],
    note=L["beasts_of_bastion_note"],
    quest={60570, 60571, 60569, 58526},
    questCount=true,
    rewards = {
        Achievement({id=14307, criteria={
            {id=50597, quest=60570}, -- Sigilback
            {id=50598, quest=60571}, -- Cloudtail
            {id=50599, quest=60569}, -- Nemaeus
            {id=50617, quest=58526}, -- Aethon
        }}),
        Toy({item=174445}), -- Glimmerfly Cocoon
        Transmog({item=179485, slot=L["dagger"]}), -- Fang of Nemaeus
        Transmog({item=179486, slot=L["1h_mace"]}), -- Sigilback's Smashshell
        Transmog({item=179487, slot=L["warglaive"]}), -- Aethon's Horn
        Transmog({item=179488, slot=L["fist"]}), -- Cloudtail's Paw
    }
}) -- Beasts of Bastion

map.nodes[55826249] = Rare({
    id=171189,
    quest={59022,62167},
    note=L["bookkeeper_mnemis_note"],
    rewards={
        Achievement({id=14307, criteria=50612}),
        Item({item=182682, note=L["trinket"]}) -- Book-Borrower Identification
    }
}) -- Bookkeeper Mnemis

map.nodes[50435804] = Rare({
    id=170932,
    quest={60978,62191},
    note=L["cloudfeather_patriarch_note"],
    rewards={
        Achievement({id=14307, criteria=50604}),
        Pet({item=180812, id=2925}) -- Golden Teroclaw
    }
}) -- Cloudfeather Guardian

map.nodes[66004367] = Rare({
    id=171014,
    quest=61002,
    note=L["collector_astor_note"],
    rewards={
        Achievement({id=14307, criteria=50610})
    },
    pois={
        POI({
            -- 66194411, Mercia's Legacy: Chapter One
            -- 65904411, Mercia's Legacy: Chapter Two
            -- 65734396, Mercia's Legacy: Chapter Three
            -- 65734345, Mercia's Legacy: Chapter Four
            -- 65934316, Mercia's Legacy: Chapter Five
            -- 66204327, Mercia's Legacy: Chapter Six
            64174218 -- Mercia's Legacy: Chapter Seven
        })
    }
}) -- Collector Astorestes

map.nodes[56904778] = Rare({
    id=171010,
    quest=60999,
    requires=Shadowlands.requirement.Item(180651),
    note=L["corrupted_clawguard_note"],
    rewards={
        Achievement({id=14307, criteria=50615})
    },
    pois={
        POI({55004125}) -- Forgefire Outpost
    }
}) -- Corrupted Clawguard

map.nodes[27823014] = Rare({
    id=170623,
    quest=60883,
    note=L["dark_watcher_note"],
    rewards={
        Achievement({id=14307, criteria=50603})
        -- also dropped class-specific finesse conduits
    }
}) -- Dark Watcher

map.nodes[37004180] = Rare({
    id=171011,
    quest={61069,61000},
    note=L["demi_hoarder_note"],
    rewards={
        Achievement({id=14307, criteria=50611})
    },
    pois={
        Path({
            37004180, 37714171, 37944069, 38484042, 39004077, 39354145,
            39854155, 40334106, 40424024, 40733931, 41233883
        })
    }
}) -- Demi the Relic Hoarder

map.nodes[41354887] = Rare({
    id=163460,
    quest=62650,
    note=L["in_small_cave"]..' '..L["dionae_note"],
    rewards={
        Achievement({id=14307, criteria=50595})
    }
}) -- Dionae

map.nodes[45546459] = Rare({
    id=171255,
    quest={61082,61091,62251},
    rewards={
        Achievement({id=14307, criteria=50614}),
        Item({item=180062}) -- Heavenly Drum
    },
    pois={
        Path({45546459, 44656486, 44766596, 45366670, 45866643, 45616562})
    }
}) -- Echo of Aella <Hand of Courage>

map.nodes[51151953] = Rare({
    id=171009,
    quest=60998,
    rewards={
        Achievement({id=14307, criteria=50605})
    },
    pois={
        Path({
            51151953, 50761914, 50681837, 50731769, 50931703, 51351673,
            51881686, 52251724, 52451799, 52351868, 52051918, 51651962,
            51151953
        })
    }
}) -- Enforcer Aegeon

map.nodes[60427305] = Rare({
    id=160721,
    quest=58222,
    rewards={
        Achievement({id=14307, criteria=50596}),
        Transmog({item=180444, slot=L["leather"]}) -- Harmonia's Chosen Belt
    },
    pois={
        Path({60137285, 60427305, 60597376})
    }
}) -- Fallen Acolyte Erisne

map.nodes[42908265] = Rare({
    id=158659,
    quest={57705,57708},
    note=L["herculon_note"],
    requires=Shadowlands.requirement.Item(172451, 10),
    rewards={
        Achievement({id=14307, criteria=50582})
    }
}) -- Herculon

map.nodes[51456859] = Rare({
    id=160882,
    quest=58319,
    note=L["nikara_note"],
    rewards={
        Achievement({id=14307, criteria=50594}),
        Transmog({item=183608, slot=L["offhand"]}) -- Evernote Vesper
    }
}) -- Nikara Blackheart

map.nodes[30365517] = Rare({
    id=171327,
    quest=nil,
    note=L["activation_unknown"],
    rewards={
        Achievement({id=14307, criteria=50616}),
    }
}) -- Reekmonger

map.nodes[61295090] = Rare({
    id=160985,
    quest=58320,
    note=L["nikara_note"],
    rewards={
        Achievement({id=14307, criteria=50593}),
        Transmog({item=183608, slot=L["offhand"]}) -- Evernote Vesper
    }
}) -- Selena the Reborn

local Sotirstus = Class('Sotirstus', Rare)

function Sotirstus.getters:label ()
    return GetAchievementCriteriaInfoByID(14307, 50618) or UNKNOWN
end

map.nodes[22432285] = Sotirstus({
   id=156339,
   quest=61634,
   covenant=KYRIAN,
   requires=Shadowlands.requirement.GarrisonTalent(1241, L["anima_channeled"]),
   note=L["sotiros_orstus_note"],
   rewards={
       Achievement({id=14307, criteria=50618})
   }
}) -- Orstus and Sotiros

map.nodes[61409050] = Rare({
    id=170548,
    quest=nil,
    note=L["sundancer_note"],
    rewards={
        Achievement({id=14307, criteria=50601}),
        Mount({item=180773, id=1307}) -- Sundancer
    },
    pois={
        Path({
            58209700, 61009560, 61609340, 61409050,
            61708710, 62808430, 62508060, 61107910
        }),
        POI({60049398}) -- Buff?
    }
}) -- Sundancer

map.nodes[63503590] = Rare({
    id=171012,
    quest={61001,61046,61047},
    questCount=true,
    note=L["swelling_tear_note"],
    rewards={
        Achievement({id=14307, criteria={
            {id=50607, quest=61001}, -- Embodied Hunger
            {id=50609, quest=61047}, -- Worldfeaster Chronn
            {id=50608, quest=61046}, -- Xixin the Ravening
        }}),
        Transmog({item=183605, slot=L["warglaive"]}) -- Devourer Wrought Warglaive
    },
    pois={
        POI({47434282, 52203280, 56031463, 59825165, 63503590})
    }
}) -- Swelling Tear

map.nodes[43482524] = Rare({
    id=171008,
    quest=60997,
    note=L["unstable_memory_note"],
    rewards={
        Achievement({id=14307, criteria=50606})
    }
}) -- Unstable Memory

map.nodes[40635306] = Rare({
    id=167078,
    quest={60314,62197},
    covenant=KYRIAN,
    requires=Shadowlands.requirement.GarrisonTalent(1238, L["anima_channeled"]),
    note=L["wingflayer_note"],
    rewards={
        Achievement({id=14307, criteria=50600}),
        Item({item=182749}) -- Regurgitated Kyrian Wings
    }
}) -- Wingflayer the Cruel

-------------------------------------------------------------------------------
---------------------------------- TREASURES ----------------------------------
-------------------------------------------------------------------------------

-- Treasure of Courage (27051932)
-- Treasure of Purity (26852473)
-- Treasure of Humility (24662039)
-- Treasure of Wisdom (23652548)

map.nodes[46114536] = Treasure({
    quest=61006,
    note=L["in_cave"],
    rewards={
        Achievement({id=14311, criteria=50053})
    },
    pois={
            POI({46454661}) -- Entrance
    }
}) -- Abandoned Stockpile

map.nodes[35834811] = Treasure({
    quest=61053,
    requires=Shadowlands.requirement.Item(180536),
    note=L["broken_flute"],
    rewards={
        Achievement({id=14311, criteria=50055}),
        Item({item=180064}) -- Ascended Flute
    }
}) -- Broken Flute

map.nodes[53498880] = Treasure({
    quest=60977, -- 60933 makes the chest visible
    label=L["cache_of_the_ascended"],
    note=L["cache_of_the_ascended_note"],
    rewards={
        Achievement({id=14307, criteria=50619}),
        Shadowlands.reward.Spacer(),
        Achievement({id=14734, criteria={49818, 49815, 49816, 49819, 49817} }),
        Mount({item=183741, id=1426}) -- Ascended Skymane
    },
    pois={
        POI({
            64326980, -- Vesper of Purity
            33325980, -- Vesper of Courage
            71933896, -- Vesper of Humility
            39132038, -- Vesper of Wisdom
            32171776, -- Vesper of Loyalty
        })
    }
}) -- Cache of the Ascended

map.nodes[51471795] = Treasure({
    quest=61052,
    requires=Shadowlands.requirement.Item(180534),
    note=L["experimental_construct_part"],
    rewards={
        Achievement({id=14311, criteria=50054}),
        Transmog({item=183609, slot=L["fist"]}) -- Re-Powered Golliath Fists
    },
    pois={
        POI({53541715, 53141903}) -- Unstable Anima Core
    }
}) -- Experimental Construct Part

map.nodes[35085805] = Treasure({
    quest=60893,
    requires=Shadowlands.requirement.Spell(333063),
    note=L["gift_of_agthia"],
    rewards={
        Achievement({id=14311, criteria=50058}),
        Item({item=180063}) -- Unearthly Chime
    },
    pois={
        Path({39085448, 38455706, 37405674, 37115684, 35165822})
    }
}) -- Gift of Agthia

map.nodes[70473645] = Treasure({
    quest=60892,
    requires=Shadowlands.requirement.Spell(333045),
    note=L["gift_of_chyrus"],
    rewards={
        Achievement({id=14311, criteria=50060})
    },
    pois={
        POI({69374031})
    }
}) -- Gift of Chyrus

map.nodes[27602179] = Treasure({
    quest=60895,
    requires=Shadowlands.requirement.Spell(333070),
    note=L["gift_of_devos"],
    rewards={
        Achievement({id=14311, criteria=50062}),
        Item({item=179977}) -- Benevolent Gong
    },
    pois={
        Path({
            23932482, 24712512, 25232402, 25832329, 25792226, 25192140,
            25732097, 26552137, 27122130, 27102031, 27452003, 27702102,
            27602179
        }) -- Suggested path
    }
}) -- Gift of Devos

map.nodes[40601890] = Treasure({
    quest=60894,
    requires=Shadowlands.requirement.Spell(333068),
    note=L["gift_of_thenios"],
    rewards={
        Achievement({id=14311, criteria=50061})
    },
    pois={
        POI({41662331, 39551900}) -- Transport platform
}}) -- Gift of Thenios

map.nodes[64877114] = Treasure({
    quest=60890,
    requires=Shadowlands.requirement.Spell(332785),
    note=L["gift_of_vesiphone"],
    rewards={
        Achievement({id=14311, criteria=50059}),
        Pet({item=180859, id=2935}) -- White Vulpin
    }
}) -- Gift of Vesiphone

map.nodes[58233999] = Treasure({
    quest=61049,
    note=L["larion_harness"],
    rewards={
        Achievement({id=14311, criteria=50051}),
        Item({item=182652})
    },
    pois={
        POI({55694287}) -- Entrance
    }
}) -- Larion Tamer's Harness

map.nodes[59336092] = Treasure({
    quest=61048,
    rewards={
        Achievement({id=14311, criteria=50050}),
        Item({item=182693, quest=62170}) -- You'll Never Walk Alone
    }
}) -- Lost Disciple's Notes

map.nodes[56481714] = Treasure({
    quest=61150,
    requires=Shadowlands.requirement.Item(180797),
    note=L["memorial_offering"],
    rewards={
        Achievement({id=14311, criteria=50056})
    },
    pois={
        POI({
            56851899, -- Drink Tray
        })
    }
}) -- Memorial Offering
--Kobri coordinate 47967389

map.nodes[52038607] = Treasure({
    quest=58329,
    rewards={
        Achievement({id=14311, criteria=50049}),
        Item({item=174007})
    }
}) -- Purifying Draught

-- 58292 (purians), 58294 (first offer), 58293 (second offer)
map.nodes[53508037] = Treasure({
    quest=58298,
    note=L["scroll_of_aeons"],
    rewards={
        Achievement({id=14311, criteria=50047}),
        Toy({item=173984}) -- Scroll of Aeons
    },
    pois={
        POI({54428387, 56168305})
    }
}) -- Scroll of Aeons

map.nodes[40504980] = Treasure({
    quest=61044,
    rewards={
        Achievement({id=14311, criteria=50052}),
        Transmog({item=182561, slot=L["cloak"]}) -- Fallen Disciple's Cloak
    }
}) -- Stolen Equipment

map.nodes[36012652] = Treasure({
    quest=61183,
    requires=Shadowlands.requirement.Item(180858),
    note=L["vesper_of_silver_wind"],
    rewards={
        Mount({item=180772, id=1404}) -- Silverwind Larion
    }
}) -- Vesper of the Silver Wind
-- 61229 (mallet forged)
-- 61191 (vesper rung)

map.nodes[58667135] = Treasure({
    quest=60478,
    rewards={
        Achievement({id=14311, criteria=50048}),
        Item({item=179982}) -- Kyrian Bell
    }
}) -- Vesper of Virtues

-------------------------------------------------------------------------------
--------------------------------- BATTLE PETS ---------------------------------
-------------------------------------------------------------------------------

map.nodes[34806280] = PetBattle({
    id=173131,
    rewards={
        Achievement({id=14625, criteria=49416})
    }
}) -- Stratios

map.nodes[36603180] = PetBattle({
    id=173133,
    rewards={
        Achievement({id=14625, criteria=49417})
    }
}) -- Jawbone

map.nodes[51393833] = PetBattle({
    id=173130,
    rewards={
        Achievement({id=14625, criteria=49415})
    }
}) -- Zolla

map.nodes[54555609] = PetBattle({
    id=173129,
    rewards={
        Achievement({id=14625, criteria=49414})
    }
}) -- Thenia

-------------------------------------------------------------------------------
----------------------------- ANIMA CRYSTAL SHARDS ----------------------------
-------------------------------------------------------------------------------

local AnimaShard = Class('AnimaShard', Node, {
    label = L["anima_shard"],
    icon = 'crystal_b',
    scale = 1.5,
    group = Shadowlands.groups.ANIMA_SHARD,
    rewards = {
        Achievement({id=14339, criteria={
            {id=0, qty=true, suffix=L["anima_shard"]}
        }})
    }
})

map.nodes[39057704] = AnimaShard({quest=61225, note=L["anima_shard_61225"]})
map.nodes[43637622] = AnimaShard({quest=61235, note=L["anima_shard_61235"]})
map.nodes[48427273] = AnimaShard({quest=61236, note=L["anima_shard_61236"]})
map.nodes[52677555] = AnimaShard({quest=61237, note=L["anima_shard_61237"]})
map.nodes[53317362] = AnimaShard({quest=61238, note=L["anima_shard_61238"]})
map.nodes[53498060] = AnimaShard({quest=61239, note=L["anima_shard_61239"]})
map.nodes[55968666] = AnimaShard({quest=61241, note=L["anima_shard_61241"]})
map.nodes[61048566] = AnimaShard({quest=61244, note=L["anima_shard_61244"]})
map.nodes[58108008] = AnimaShard({quest=61245, note=L["anima_shard_61245"]})
map.nodes[56877498] = AnimaShard({quest=61247, note=L["anima_shard_61247"]})
map.nodes[65527192] = AnimaShard({quest=61249, note=L["anima_shard_61249"],
    pois={
        POI({63467240}) -- Transport platform
    }
})
map.nodes[58156391] = AnimaShard({quest=61250, note=L["anima_shard_61250"]})
map.nodes[54005970] = AnimaShard({quest=61251, note=L["anima_shard_61251"]})
map.nodes[46706595] = AnimaShard({quest=61253, note=L["anima_shard_61253"]})
map.nodes[50685614] = AnimaShard({quest=61254, note=L["anima_shard_61254"]})
map.nodes[34846578] = AnimaShard({quest=61257, note=L["anima_shard_61257"]})
map.nodes[51674802] = AnimaShard({quest=61258, note=L["anima_shard_61258"]})
map.nodes[47084923] = AnimaShard({quest=61260, note=L["anima_shard_61260"]})
map.nodes[41394663] = AnimaShard({quest=61261, note=L["anima_shard_61261"]})
map.nodes[40045912] = AnimaShard({quest=61263, note=L["anima_shard_61263"]})
map.nodes[38525326] = AnimaShard({quest=61264, note=L["anima_shard_61264"]})
map.nodes[57645567] = AnimaShard({quest=61270, note=L["anima_shard_61270"]})
map.nodes[65254288] = AnimaShard({quest=61271, note=L["anima_shard_61271"]})
map.nodes[72384029] = AnimaShard({quest=61273, note=L["anima_shard_61273"]})
map.nodes[66892692] = AnimaShard({quest=61274, note=L["anima_shard_61274"]})
map.nodes[57553827] = AnimaShard({quest=61275, note=L["anima_shard_61275"],
    pois={
        POI({55694287}) -- Entrance
    }
})
map.nodes[52163939] = AnimaShard({quest=61277, note=L["anima_shard_61277"]})
map.nodes[49993826] = AnimaShard({quest=61278, note=L["anima_shard_61278"]})
map.nodes[48483491] = AnimaShard({quest=61279, note=L["anima_shard_61279"]})
map.nodes[56722884] = AnimaShard({quest=61280, note=L["anima_shard_61280"]})
map.nodes[56201731] = AnimaShard({quest=61281, note=L["anima_shard_61281"]})
map.nodes[59881391] = AnimaShard({quest=61282, note=L["anima_shard_61282"]})
map.nodes[52440942] = AnimaShard({quest=61283, note=L["anima_shard_61283"],
    pois={
        POI({53650953}) -- Entrance
    }
})
map.nodes[46691804] = AnimaShard({quest=61284, note=L["anima_shard_61284"]})
map.nodes[44942845] = AnimaShard({quest=61285, note=L["anima_shard_61285"]})
map.nodes[42302402] = AnimaShard({quest=61286, note=L["anima_shard_61286"]})
map.nodes[37102468] = AnimaShard({quest=61287, note=L["anima_shard_61287"]})
map.nodes[42813321] = AnimaShard({quest=61288, note=L["anima_shard_61288"]})
map.nodes[42713940] = AnimaShard({quest=61289, note=L["anima_shard_61289"]})
map.nodes[33033762] = AnimaShard({quest=61290, note=L["anima_shard_61290"]})
map.nodes[31002747] = AnimaShard({quest=61291, note=L["anima_shard_61291"]})
map.nodes[30612373] = AnimaShard({quest=61292, note=L["anima_shard_61292"]})
map.nodes[24642298] = AnimaShard({quest=61293, note=L["anima_shard_61293"]})
map.nodes[26152262] = AnimaShard({quest=61294, note=L["anima_shard_61294"]})
map.nodes[24371821] = AnimaShard({quest=61295, note=L["anima_shard_61295"]})

-------------------------------------------------------------------------------

local gardens = Map({ id=1693 })
local font = Map({ id=1694 })
local wake = Map({ id=1666 })

wake.nodes[52508860] = AnimaShard({quest=61296, note=L["anima_shard_61296"], parent=map.id})
wake.nodes[36202280] = AnimaShard({quest=61297, note=L["anima_shard_61297"], parent=map.id})
gardens.nodes[46605310] = AnimaShard({quest=61298, note=L["anima_shard_61298"]})
gardens.nodes[69403870] = AnimaShard({quest=61299, note=L["anima_shard_61299"]})
font.nodes[49804690] = AnimaShard({quest=61300, note=L["anima_shard_61300"]})


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 




local Collectible = Shadowlands.node.Collectible













-------------------------------------------------------------------------------

local NECROLORD = Shadowlands.covenants.NEC

local map = Map({ id=1536, settings=true })

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

map.nodes[52663542] = Rare({
    id=162727,
    quest=58870,
    rewards={
        Achievement({id=14308, criteria=48876})
    }
}) -- Bubbleblood

map.nodes[49012351] = Rare({
    id=159105,
    quest=58005,
    rewards={
        Achievement({id=14308, criteria=48866})
    }
}) -- Collector Kash

map.nodes[26392633] = Rare({
    id=157058,
    quest=58335,
    rewards={
        Achievement({id=14308, criteria=48872})
    }
}) -- Corpsecutter (Bonebreaker) Moroc

map.nodes[76835707] = Rare({
    id=162711,
    quest=58868,
    rewards={
        Achievement({id=14308, criteria=48851}),
        Pet({id=2953, item=181263}) -- Shy Melvin
    }
}) -- Deadly Dapperling

map.nodes[46734550] = Rare({
    id=162797,
    quest=58878,
    note=L["deepscar_note"],
    rewards={
        Achievement({id=14308, criteria=48852}),
        Transmog({item=182191, slot=L["1h_mace"]}) -- Slobber-Soaked Chew Toy
    },
    pois={
        POI({48125190, 53974548})
    }
}) -- Deepscar

map.nodes[45052842] = Rare({
    id=162669,
    quest=58835,
    rewards={
        Achievement({id=14308, criteria=48855})
    }
}) -- Devour'us

map.nodes[31603540] = Rare({
    id=162741,
    quest=58872,
    covenant=NECROLORD,
    requires=Shadowlands.requirement.GarrisonTalent(1250, L["anima_channeled"]),
    note=L["gieger_note"],
    rewards={
        Mount({item=182080, id=1411}) -- Predatory Bonejowl
    }
}) -- Gieger

map.nodes[57795155] = Rare({
    id=162588,
    quest=58837,
    note=L["gristlebeak_note"],
    rewards={
        Achievement({id=14308, criteria=48853}),
        Transmog({item=182196, slot=L["crossbow"]}) -- Arbalest of the Colossal Predator
    }
}) -- Gristlebeak

map.nodes[38794333] = Rare({
    id=161105,
    quest=58332,
    note=L["schmitd_note"],
    rewards={
        Achievement({id=14308, criteria=48848}),
        Transmog({item=182192, slot=L["plate"]}) -- Knee-Obstructing Legguards
    }
}) -- Indomitable Schmitd

map.nodes[72872891] = Rare({
    id=174108,
    quest=62369,
    rewards={
        Achievement({id=14308, criteria=49724})
    }
}) -- Necromantic Anomaly

map.nodes[66023532] = Rare({
    id=162690,
    quest=58851,
    rewards={
        Achievement({id=14308, criteria=49723}),
        Mount({item=182084, id=1373}) -- Gorespine
    }
}) -- Nerissa Heartless

map.nodes[53726132] = Rare({
    id=162767,
    quest=58875,
    rewards={
        Achievement({id=14308, criteria=48849}),
        Transmog({item=182205, slot=L["mail"]}) -- Scarab-Shell Faceguard
    }
}) -- Nirvaska the Summoner

map.nodes[50346328] = Rare({
    id=161857,
    quest=58629,
    rewards={
        Achievement({id=14308, criteria=48868})
    }
}) -- Pesticide

map.nodes[53841877] = Rare({
    id=159753,
    quest=58004,
    rewards={
        Achievement({id=14308, criteria=48865}),
        Pet({item=181283, id=2964}) -- Foulwing Hatchling
    }
}) -- Ravenomous

map.nodes[51744439] = Rare({
    id=168147,
    quest=58784,
    covenant=NECROLORD,
    requires=Shadowlands.requirement.GarrisonTalent(1253, L["anima_channeled"]),
    note=L["sabriel_note"],
    rewards={
        Achievement({id=14308, criteria=48874}),
        Achievement({id=14802, criteria=48874}),
        Mount({item=182083, id=1374}), -- Bonecleaver's Skullboar
        Mount({item=182075, id=1374}) -- Bonehoof Tauralus
    }
}) -- Sabriel the Bonecleaver

map.nodes[62107580] = Rare({
    id=158406,
    quest=58006,
    rewards={
        Achievement({id=14308, criteria=48857}),
        Pet({item=181267, id=2957}) -- Writhing Spine
    }
}) -- Scunner

map.nodes[55502361] = Rare({
    id=159886,
    quest=58003,
    note=L["chelicerae_note"],
    rewards={
        Achievement({id=14308, criteria=48873}),
        Pet({item=181172, id=2948}) -- Boneweave Hatchling
    }
}) -- Sister Chelicerae

map.nodes[42465345] = Rare({
    id=162528,
    quest=58768,
    rewards={
        Achievement({id=14308, criteria=48869}),
        Pet({item=181266, id=2956}), -- Bloodlouse Hatchling
        Pet({item=181265, id=2955}) -- Corpselouse Hatchling
    }
}) -- Smorgas the Feaster

map.nodes[44215132] = Rare({
    id=162586,
    quest=58783,
    rewards={
        Achievement({id=14308, criteria=48850}),
        Transmog({item=182190, slot=L["leather"]}), -- Tauralus Hide Collar
        Mount({item=181815, id=1370,}) -- Armored Bonehoof Tauralus
    }
}) -- Tahonta

map.nodes[50562011] = Rare({
    id=160059,
    quest=58091,
    note=L["taskmaster_xox_note"],
    rewards={
        Achievement({id=14308, criteria=48867})
    }
}) -- Taskmaster Xox

map.nodes[24184297] = Rare({
    id=162180,
    quest=58678,
    note=L["leeda_note"],
    rewards={
        Achievement({id=14308, criteria=48870}),
        Transmog({item=184180, slot=L["cloth"]})
    }
}) -- Thread Mistress Leeda

map.nodes[33538086] = Rare({
    id=162819,
    quest=nil,
    note=L["malkorak_note"],
    rewards={
        Achievement({id=14308, criteria=48875}),
        Mount({item=182085, id=1372}) -- Umbral Bloodtusk
    }
}) -- Warbringer Mal'Korak

map.nodes[28965138] = Rare({
    id=157125,
    quest=62079,
    requires=Shadowlands.requirement.Item(175841),
    note=L["zargox_the_reborn_note"],
    rewards={
        Achievement({id=14308, criteria=48864})
    },
    pois={
        POI({26314280})
    }
}) -- Zargox the Reborn

------------------------- POOL OF MIXED MONSTROSITIES -------------------------

local OOZE = "|T646670:0|t"
local GOO = "|T136007:0|t"
local OIL = "|T136124:0|t"

map.nodes[58197421] = Rare({
    id=157226,
    quest={61718, 61719, 61720, 61721, 61722, 61723, 61724},
    questCount=true,
    note=L["mixed_pool_note"],
    rewards = {
        Achievement({id=14721, criteria={
            {id=48858, quest=61721, note=OOZE..' > '..GOO..' '..OIL}, -- Gelloh
            {id=48863, quest=61719, note=GOO..' > '..OOZE..' '..OIL}, -- Corrupted Sediment
            {id=48854, quest=61718, note=OIL..' > '..OOZE..' '..GOO}, -- Pulsing Leech
            {id=48860, quest=61722, note='('..OOZE..' = '..GOO..') > '..OIL}, -- Boneslurp
            {id=48862, quest=61723, note='('..OOZE..' = '..OIL..') > '..GOO}, -- Burnblister
            {id=48861, quest=61720, note='('..GOO..' = '..OIL..') > '..OOZE}, -- Violet Mistake
            {id=48859, quest=61724, note=OOZE..' = '..GOO..' = '..OIL}, -- Oily Invertebrate
        }}),
        Mount({item=182079, id=1410, note=L["Violet"]}), -- Slime-Covered Reins of the Hulking Deathroc
        Pet({item=181270, id=2960, note=L["Oily"]}) -- Decaying Oozewalker
    }
})

------------------------------- THEATER OF PAIN -------------------------------

map.nodes[50354728] = Rare({
    id=162853,
    quest=62786,
    label=C_Map.GetMapInfo(1683).name,
    rewards = {
        Achievement({id=14802, criteria={
            50397, -- Azmogal
            50398, -- Unbreakable Urtz
            50399, -- Xantuth the Blighted
            50400, -- Mistress Dyrax
            50402, -- Devmorta
            50403, -- Ti'or
            48874  -- Sabriel the Bonecleaver
        }})
    }
})

-------------------------------------------------------------------------------
---------------------------------- TREASURES ----------------------------------
-------------------------------------------------------------------------------

map.nodes[44083989] = Treasure({
    quest=60368,
    label=L["blackhound_cache"]
}) -- Blackhound Cache

map.nodes[36797862] = Treasure({
    label=L["bladesworn_supply_cache"]
}) -- Bladesworn Supply Cache

map.nodes[54011234] = Treasure({
    quest=nil,
    label=L["cache_of_eyes"],
    note=L["cache_of_eyes_note"],
    rewards={
        -- Achievement({id=14312, criteria=50070}),
        Pet({item=181171, id=2947}) -- Luminous Webspinner
    }
}) -- Cache of Eyes

map.nodes[49441509] = Treasure({
    quest=59244,
    rewards={
        Achievement({id=14312, criteria=50070}),
        Item({item=183696}) -- Sp-eye-glass
    }
}) -- Chest of Eyes

Map({id=1649}).nodes[34565549] = Treasure({
    quest=58710,
    note=L["forgotten_mementos"],
    parent=map.id,
    rewards={
        Achievement({id=14312, criteria=50069})
    },
    pois={
        POI({25815353}) -- Vault Portcullis Chain
    }
}) -- Forgotten Mementos

map.nodes[41511953] = Treasure({
    quest=62602, -- Currently account-wide? Spinebug is lootable on alts but treasure is gone
    label=L["giant_cache_of_epic_treasure"],
    note=L["spinebug_note"],
    rewards={
        Pet({id=3047}) -- Spinebug
    }
}) -- Giant Cache of Epic Treasure

map.nodes[72895365] = Treasure({
    quest=61484,
    note=L["glutharns_note"],
    rewards={
        Achievement({id=14312, criteria=50072})
    }
}) -- Glutharn's Stash

map.nodes[30792874] = Treasure({
    quest=60730,
    rewards={
        Achievement({id=14312, criteria=50065})
    }
}) -- Halis's Lunch Pail

map.nodes[32742127] = Treasure({
    quest=60587,
    note=L["kyrian_keepsake_note"],
    rewards={
        Achievement({id=14312, criteria=50064}),
        Item({item=180085}),
        Item({item=175708, note=L["neck"]})
    }
}) -- Kyrian Keepsake

map.nodes[62505990] = Treasure({
    quest=59245,
    note=L["misplaced_supplies"],
    rewards={
        Achievement({id=14312, criteria=50071}),
    },
    pois={
        POI({61925851}) -- Way up
    }
}) -- Misplaced Supplies

map.nodes[42382333] = Treasure({
    quest=61470,
    note=L["necro_tome_note"],
    rewards={
        Achievement({id=14312, criteria=50068}),
        Toy({item=182732}) -- The Necronom-i-nom
    },
    pois={
        POI({40693305}) -- NPC location
    }
}) -- Necro Tome

map.nodes[47236216] = Treasure({
    quest=59358,
    rewards={
        Achievement({id=14312, criteria=50063}),
        Transmog({item=180749, slot=L["shield"]}) -- Hauk's Battle-Scarred Bulwark
    }
}) -- Ornate Bone Shield

map.nodes[57667581] = Treasure({
    quest=61474,
    note=L["plaguefallen_chest_note"],
    rewards={
        Achievement({id=14312, criteria=50074}),
        Pet({item=183515, id=3045}) -- Reanimated Plague
    },
    pois={
        POI({62487656})
    }
}) -- Plaguefallen Chest

map.nodes[64672475] = Treasure({
    quest=61514,
    requires=Shadowlands.requirement.Spell(337041),
    note=L["ritualists_cache_note"],
    rewards={
        Achievement({id=14312, criteria=50075}),
        Item({item=183517, quest=62372}) -- Page 76 of the Necronom-i-nom
    },
    pois={
        POI({69873103, 69073250, 71473663}), -- Bone Pile
        POI({71733540}) -- Book of Binding Ritials
    }
}) -- Ritualist's Cache

map.nodes[31737004] = Treasure({
    quest=61491,
    requires=Shadowlands.requirement.Item(181777),
    note=L["runespeakers_trove_note"],
    rewards={
        Achievement({id=14312, criteria=50073}),
        Transmog({item=183516, slot=L['cloth']}) -- Stained Bonefused Mantle
    },
    pois={
        POI({37867013})
    }
}) -- Runespeaker's Trove

map.nodes[73564986] = Treasure({
    quest=61451,
    note=L["stolen_jar_note"],
    rewards={
        Achievement({id=14312, criteria=50067}),
        Item({item=182618, quest=62085}) -- ... Why Me?
    }
}) -- Stolen Jar

map.nodes[55893897] = Treasure({
    quest={59428,59429},
    label='{npc:165037}',
    note=L["strange_growth_note"],
    rewards={
        --Item({item=182607}), -- Hairy Egg
        Pet({item=182606, id=3013}) -- Bloodlouse Larva
    }
}) -- Strange Growth

map.nodes[59867906] = Treasure({
    quest=61444,
    note=L["vat_of_slime_note"],
    rewards={
        Achievement({id=14312, criteria=50066}),
        Toy({item=181825}) -- Phial of Ravenous Slime
    }
}) -- Vat of Conspicuous Slime

map.nodes[51444848] = Treasure({
    quest={61127,61128}, -- {arm, sword}
    questCount=true,
    note=L["oonar_sorrowbane_note"],
    rewards={
        Achievement({id=14626, criteria=0}),
        Pet({item=181164, id=2944}), -- Oonar's Arm
        Transmog({item=180273, slot=L["2h_sword"]}), --Sorrowbane
    },
    pois={
        POI({50945317, 37114699, 53634792, 76445672})
    }
}) -- Oonar's Arm and Sorrowbane

-------------------------------------------------------------------------------
--------------------------------- BATTLE PETS ---------------------------------
-------------------------------------------------------------------------------

map.nodes[34005526] = PetBattle({
    id=173263,
    rewards={
        Achievement({id=14625, criteria=49412})
    }
}) -- Rotgut

map.nodes[46865000] = PetBattle({
    id=173257,
    rewards={
        Achievement({id=14625, criteria=49413})
    }
}) -- Caregiver Maximillian

map.nodes[54062806] = PetBattle({
    id=173274,
    rewards={
        Achievement({id=14625, criteria=49410})
    }
}) -- Gorgemouth

map.nodes[63234687] = PetBattle({
    id=173267,
    rewards={
        Achievement({id=14625, criteria=49411})
    }
}) -- Dundley Stickyfingers

-------------------------------------------------------------------------------
------------------------------- NINE AFTERLIVES -------------------------------
-------------------------------------------------------------------------------

local Kitten = Class('Kitten', Collectible, {
    sublabel = L["pet_cat"],
    icon = 3732497, -- inv_catslime
    group = Shadowlands.groups.SLIME_CAT
})

map.nodes[65225065] = Kitten({id=174224, rewards={
    Achievement({id=14634, criteria=49428})
}}) -- Envy

map.nodes[51002750] = Kitten({id=174230, rewards={
    Achievement({id=14634, criteria=49430})
}, note=L["lime"]}) -- Lime

map.nodes[49461761] = Kitten({id=174234, rewards={
    Achievement({id=14634, criteria=49431})
}}) -- Mayhem

map.nodes[34305310] = Kitten({id=174237, rewards={
    Achievement({id=14634, criteria=49433})
}}) -- Meowmalade

map.nodes[47533375] = Kitten({id=174236, rewards={
    Achievement({id=14634, criteria=49432})
}, note=L["moldstopheles"]}) -- Moldstopheles

map.nodes[64802240] = Kitten({id=174226, rewards={
    Achievement({id=14634, criteria=49429})
}}) -- Mr. Jigglesworth

map.nodes[50246027] = Kitten({id=174223, rewards={
    Achievement({id=14634, criteria=49427})
}, note=L["pus_in_boots"]}) -- Pus-In-Boots

map.nodes[32005700] = Kitten({id=174221, rewards={
    Achievement({id=14634, criteria=49426})
}}) -- Snots

Map({id=1697}).nodes[45203680] = Kitten({id=174195, parent=map.id, rewards={
    Achievement({id=14634, criteria=49425})
}, note=L["hairball"]}) -- Hairball


-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 




local NPC = Shadowlands.node.NPC














-------------------------------------------------------------------------------

local VENTHYR = Shadowlands.covenants.VEN
local map = Map({ id=1525, settings=true })

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

map.nodes[53247300] = Rare({
    id=166393,
    quest=59854,
    note=L["amalgamation_of_filth_note"],
    rewards={
        Achievement({id=14310, criteria=48814}),
        Transmog({item=183729, slot=L["leather"]}) -- Filth-Splattered Headcover
    },
    pois={
        POI({52747386, 53857251, 54537436, 53897368}) -- Rubbish Box
    }
}) -- Amalgamation of Filth

map.nodes[25304850] = Rare({
    id=164388,
    quest=59584,
    note=L["amalgamation_of_light_note"],
    rewards={
        Achievement({id=14310, criteria=48811}),
        Transmog({item=179924, slot=L["leather"]}), -- Light-Infused Jacket
        Item({item=180688}) -- Infused Remnant of Light
    }
}) -- Amalgamation of Light

map.nodes[65782914] = Rare({
    id=170434,
    quest=60836,
    note=L["amalgamation_of_sin_note"],
    rewards={
        Achievement({id=14310, criteria=50029}),
        Transmog({item=183730, slot=L["plate"]}) -- Sinstone-Studded Greathelm
    }
}) -- Amalgamation of Sin

map.nodes[35817052] = Rare({
    id=166576,
    quest=59893,
    rewards={
        Achievement({id=14310, criteria=48816}),
        Transmog({item=183731, slot=L["plate"]}) -- Smolder-Tempered Legplates
    }
}) -- Azgar

map.nodes[35003230] = Rare({
    id=166292,
    quest=nil,
    note=L["bog_beast_note"],
    rewards={
        Achievement({id=14310, criteria=48818}),
        Pet({item=180588, id=2896}) -- Bucket of Primordial Sludge
    }
}) -- Bog Beast

map.nodes[66555946] = Rare({
    id=165206,
    quest=59582,
    note=L["endlurker_note"],
    rewards={
        Achievement({id=14310, criteria=48810}),
        Item({item=179927, note=L["trinket"]}) -- Glowing Endmire Stinger
    }
}) -- Endlurker

map.nodes[37084742] = Rare({
    id=166710,
    quest=59913,
    note=L["executioner_aatron_note"],
    rewards={
        Achievement({id=14310, criteria=48819}),
        Item({item=180696}), -- Legion Wing Insignia
        Transmog({item=183737, slot=L["plate"]}) -- Aatron's Stone Girdle
    }
}) -- Executioner Aatron

map.nodes[43055183] = Rare({
    id=161310,
    quest=58441,
    rewards={
        Achievement({id=14310, criteria=48807}),
        Transmog({item=180502, slot=L["leather"]}) -- Adrastia's Executioner Gloves
    },
    pois={
        Path({43055183, 41525104, 41264940, 42734893, 44135004, 44435182, 43055183})
    }
}) -- Executioner Adrastia

map.nodes[62484716] = Rare({
    id=166521,
    quest=59869,
    note=L["famu_note"],
    rewards={
        Achievement({id=14310, criteria=48815}),
        Mount({item=180582, id=1379}), -- Endmire Flyer
    }
}) -- Famu the Infinite

map.nodes[32641545] = Rare({
    id=159496,
    quest=61618,
    covenant=VENTHYR,
    requires=Shadowlands.requirement.GarrisonTalent(1259, L["anima_channeled"]),
    note=L["madalav_note"],
    pois={
        POI({32661483}) -- Madalav's Hammer
    }
}) -- Forgemaster Madalav

map.nodes[20485298] = Rare({
    id=167464,
    quest=60173,
    note=L["grand_arcanist_dimitri_note"],
    rewards={
        Achievement({id=14310, criteria=48821})
    }
}) -- Grand Arcanist Dimitri

map.nodes[45847919] = Rare({
    id=165290,
    quest=59612,
    covenant=VENTHYR,
    requires=Shadowlands.requirement.GarrisonTalent(1256, L["anima_channeled"]),
    note=L["harika_note"],
    rewards={
        Transmog({item=183720, slot=L["leather"]}), -- Dredbatskin Jerkin
        Mount({item=180461, id=1310}) -- Horrid Brood Dredwing
    },
    pois={
        POI({43257769}), -- Ballista Bolt
        POI({41187469, 40917690}) -- Dredhollow Tools
    }
}) -- Harika the Horrid

map.nodes[51985179] = Rare({
    id=166679,
    quest=59900,
    rewards={
        Achievement({id=14310, criteria=48817}),
        Mount({item=180581, id=1298}) -- Harnessed Hopecrusher
    }
}) -- Hopecrusher

map.nodes[61717949] = Rare({
    id=166993,
    quest=60022,
    rewards={
        Achievement({id=14310, criteria=48820}),
        Item({item=180705}), -- Gargon Training Manual
        Item({item=180704}) -- Infused Pet Biscuit
    }
}) -- Huntmaster Petrus

map.nodes[21803590] = Rare({
    id=160640,
    quest=58210,
    requires=Shadowlands.requirement.Item(177223),
    note=L["innervus_note"],
    rewards={
        Achievement({id=14310, criteria=48801}),
        Transmog({item=183735, slot=L["cloth"]}) -- Rogue Sinstealer's Mantle
    }
}) -- Innervus

map.nodes[67978179] = Rare({
    id=165152,
    quest=59580,
    note=L["leeched_soul_note"],
    rewards={
        Achievement({id=14310, criteria=48809}),
        Transmog({item=183736, slot=L["cloth"]}),
        Pet({item=180585, id=2897}) -- Bottled Up Emotions
    }
}) -- Leeched Soul

map.nodes[75976161] = Rare({
    id=161891,
    quest=58633,
    note=L["lord_mortegore_note"],
    rewards={
        Achievement({id=14310, criteria=48808}),
        Transmog({item=180501, slot=L["mail"]}) -- Skull-Formed Headcage
    }
}) -- Lord Mortegore

map.nodes[49003490] = Rare({
    id=170048,
    quest=60729,
    note=L["manifestation_of_wrath_note"],
    rewards={
        Achievement({id=14310, criteria=48822}),
        Pet({item=180585, id=2897}) -- Bottled Up Emotions
    }
}) -- Manifestation of Wrath

map.nodes[38316914] = Rare({
    id=160675,
    quest=58213,
    note=L["scrivener_lenua_note"],
    rewards={
        Achievement({id=14310, criteria=48800}),
        Pet({item=180587, id=2893}) -- Animated Tome
    }
}) -- Scrivener Lenua

map.nodes[67443048] = Rare({
    id=162481,
    quest=62252,
    note=L["sinstone_hoarder_note"],
    rewards={
        Achievement({id=14310, criteria=50030}),
        Item({item=180677}), -- Discarded Medal of Valor
        Transmog({item=183732, slot=L["mail"]}) -- Sinstone-Linked Greaves
    }
}) -- Sinstone Hoarder

map.nodes[34045555] = Rare({
    id=160857,
    quest=58263,
    note=L["sire_ladinas_note"],
    rewards={
        Achievement({id=14310, criteria=48806}),
        Toy({item=180873}) -- Smolderheart
    }
}) -- Sire Ladinas

map.nodes[78934975] = Rare({
    id=160385,
    quest=58130,
    note=L["soulstalker_doina_note"],
    rewards={
        Achievement({id=14310, criteria=48799}),
        Item({item=180692}) -- Box of Stalker Traps
    }
}) -- Soulstalker Doina

map.nodes[31312324] = Rare({
    id=159503,
    quest=62220,
    rewards={
        Achievement({id=14310, criteria=48803}),
        Transmog({item=180488, slot=L["plate"]}) -- Fist-Forged Breastplate
    }
}) -- Stonefist

map.nodes[66507080] = Rare({
    id=165253,
    quest=59595,
    rewards={
        Achievement({id=14310, criteria=48812}),
        Item({item=179363, quest=60517}) -- The Toll of the Road
    }
}) -- Tollkeeper Varaboss

map.nodes[43007910] = Rare({
    id=155779,
    quest=56877,
    note=L["tomb_burster_note"],
    rewards={
        Achievement({id=14310, criteria=48802}),
        Pet({item=180584, id=2891}) -- Rose Spiderling
    }
}) -- Tomb Burster

map.nodes[38607200] = Rare({
    id=160821,
    quest=58259,
    requires=Shadowlands.requirement.Item(173939),
    note=L["worldedge_gorger_note"],
    rewards={
        Achievement({id=14310, criteria=48805}),
        Item({item=180583, quest=61188}) -- Impressionable Gorger Spawn
    }
}) -- Worldedge Gorger

-------------------------------------------------------------------------------
---------------------------------- TREASURES ----------------------------------
-------------------------------------------------------------------------------

-- Stoneguard Satchel (76226410) (60896,60939)
-- Reliquary of Remembrance (79763376) (item=180403)
-- Unimplemented treasure? (50244910)

map.nodes[51855954] = Treasure({
    quest=59888,
    rewards={
        Achievement({id=14314, criteria=50902}),
        Item({item=182744}) -- Ornate Belt Buckle
    }
}) -- Abandoned Curios

map.nodes[69327795] = Treasure({
    quest=59833,
    rewards={
        Achievement({id=14314, criteria=50896}),
        Toy({item=179393}) -- Mirror of Envious Dreams
    }
}) -- Chest of Envious Dreams

map.nodes[64187265] = Treasure({
    quest=59883,
    rewards={
        Achievement({id=14314, criteria=50897}),
        Item({item=179392}) -- Orb of Burgeoning Ambition
    }
}) -- Filcher's Prize

map.nodes[46395817] = Treasure({
    quest=59886,
    rewards={
        Achievement({id=14314, criteria=50900})
    }
}) -- Fleeing Soul's Bundle

map.nodes[47335536] = Treasure({
    quest=62243,
    note=L["forbidden_chamber_note"],
    rewards={
        Achievement({id=14314, criteria=50084})
    }
}) -- Forbidden Chamber

map.nodes[75465542] = Treasure({
    quest=59887,
    note=L["gilded_plum_chest_note"],
    rewards={
        Achievement({id=14314, criteria=50901}),
        Item({item=179390}) -- Tantalizingly Large Golden Plum
    },
    pois={
        Path({74625754, 75095665, 75465542, 76015458, 76455372})
    }
}) -- Gilded Plum Chest

map.nodes[37726925] = Treasure({
    quest=61990,
    note=L["lost_quill_note"],
    rewards={
        Achievement({id=14314, criteria=50076}),
        Pet({item=182613, id=3008}) -- Lost Quill
    }
}) -- Lost Quill

map.nodes[29693723] = Treasure({
    quest=62198,
    requires=Shadowlands.requirement.Currency(1820, 30),
    rewards={
        Achievement({id=14314, criteria=50081}),
        Toy({item=182780}) -- Muckpool Cookpot
    }
}) -- Makeshift Muckpool

map.nodes[79993697] = Treasure({
    quest=62156,
    note=L["rapier_fearless_note"],
    rewards={
        Achievement({id=14314, criteria=50079})
    }
}) -- Rapier of the Fearless

map.nodes[61525864] = Treasure({
    quest=59885,
    note=L["remlates_cache_note"],
    rewards={
        Achievement({id=14314, criteria=50899})
    }
}) -- Remlate's Hidden Cache

map.nodes[31055506] = Treasure({
    quest=59889,
    rewards={
        Achievement({id=14314, criteria=50895}),
        Item({item=182738, quest=62189}) -- Bundle of Smuggled Parasol Components
    }
}) -- Smuggled Cache

map.nodes[38394424] = Treasure({
    quest=61999,
    rewards={
        Achievement({id=14314, criteria=50077}),
        Toy({item=182694}) -- Stylish Black Parasol
    }
}) -- Stylish Parasol

map.nodes[63367398] = Treasure({
    quest=62199,
    note=L["taskmaster_trove_note"],
    rewards={
        Achievement({id=14314, criteria=50082}),
        Toy({item=183986}) -- Bondable Sinstone
    }
}) -- Taskmaster's Trove

map.nodes[57374337] = Treasure({
    quest=nil,
    requires=Shadowlands.requirement.Currency(1820, 99),
    note=L["the_count_note"],
    rewards={
        Achievement({id=14314, criteria=50078}),
        Pet({item=182612, id=3009}) -- The Count's Pendant
    }
}) -- The Count

map.nodes[70176005] = Treasure({
    quest=62164,
    note=L["dredglaive_note"],
    rewards={
        Achievement({id=14314, criteria=50080}),
        Transmog({item=177807, slot=L["warglaive"]}) -- Vyrtha's Dredglaive
    }
}) -- Vrytha's Dredglaive

map.nodes[68446445] = Treasure({
    quest=59884,
    rewards={
        Achievement({id=14314, criteria=50898})
    }
}) -- Wayfarer's Abandoned Spoils

-------------------------------------------------------------------------------

-- Not at this location for me -Zar
-- map.nodes[30342472] = Treasure({
--     quest=60665,
--     label=L["bleakwood_chest"],
--     rewards={
--         Pet({item=180592, id=2901}), -- Trapped Stonefiend
--         Transmog({item=182720, slot=L["mail"]}), -- Mail Courier's Tunic
--         Transmog({item=180398, slot=L["polearm"]}) -- Stonewrought Legion Halberd
--     }
-- }) -- Bleakwood Chest

map.nodes[73597539] = Treasure({
    quest=62196,
    label=L["forgotten_anglers_rod"],
    rewards={
        Toy({item=180993}) -- Bat Visage Bobber
    }
}) -- Forgotten Angler's Rod

-------------------------------------------------------------------------------
--------------------------------- BATTLE PETS ---------------------------------
-------------------------------------------------------------------------------

map.nodes[25263799] = PetBattle({
    id=173303,
    rewards={
        Achievement({id=14625, criteria=49409})
    }
}) -- Scorch

map.nodes[39945249] = PetBattle({
    id=173315,
    rewards={
        Achievement({id=14625, criteria=49408})
    }
}) -- Sylla

map.nodes[61354121] = PetBattle({
    id=173331,
    rewards={
        Achievement({id=14625, criteria=49406})
    }
}) -- Addius the Tormentor

map.nodes[67626608] = PetBattle({
    id=173324,
    rewards={
        Achievement({id=14625, criteria=49407})
    }
}) -- Eyegor

-------------------------------------------------------------------------------
---------------------------- THE AFTERLIFE EXPRESS ----------------------------
-------------------------------------------------------------------------------

local Carriage = Class('Carriage', NPC, {
    icon = 'horseshoe',
    scale = 1.2,
    group = Shadowlands.groups.CARRIAGE
})

map.nodes[50217067] = Carriage({
    id=158365,
    rewards={ Achievement({id=14771, criteria=50170}) },
    pois={
        Path({
            61646948, 61317022, 60747099, 60097166, 59487245, 58747306,
            57937314, 57107308, 56317325, 55527318, 54907229, 54227157,
            53457133, 52567129, 51737135, 51037104, 50217067, 49777078,
            49087176, 48297197, 47527241, 46707290, 45867344, 45057385,
            44307361, 43667254, 43147164, 42447066, 41696959, 40976873,
            40386790, 40606672, 41056578, 41446465, 41596336, 41756230,
            42116124, 42836046, 43485973, 43605910
        })
    }
}) -- Banewood Carriage

map.nodes[54784842] = Carriage({
    id=174750,
    rewards={ Achievement({id=14771, criteria=50168}) },
    pois={
        Path({
            54784842, 53944909, 53044932, 52084962, 51335050, 50535120,
            49945193, 49285216, 48765143, 48035069, 47394964, 46944832,
            46764721, 47104691, 47564794, 47924913, 48475001, 48905053,
            49435025, 50045066, 50774996, 51544918, 52294866, 53184838,
            53994806, 54544773, 54784842
        })
    }
}) -- Chalice Carriage

map.nodes[63865885] = Carriage({
    id=158336,
    rewards={ Achievement({id=14771, criteria=50172}) },
    pois={
        Path({
            62535921, 62426040, 61806117, 61156162, 61326239, 62046252,
            62726224, 63436223, 64086263, 64866323, 65776393, 66626458,
            67516524, 68276591, 68206736, 67676828, 66806772, 65846757,
            65046796, 64276882, 63336907, 62526932, 61796934, 62216827,
            62706719, 63046602, 63436485, 63976392, 64526285, 64706183,
            64566066, 64405968, 63865885, 63015872, 62535921
        })
    }
}) -- Darkhaven Carriage

map.nodes[57263726] = Carriage({
    id=174751,
    rewards={ Achievement({id=14771, criteria=50169}) },
    pois={
        Path({
            57263726, 57513861, 57823963, 58434056, 58944093, 59414007,
            59173914, 58973790, 58983663, 59123533, 59563411, 59973304,
            60483221, 59913144, 59443176, 59063262, 58533367, 58083468,
            57583592, 57263726, 56503725, 55923724, 55293621, 54563601,
            53773623, 53713765, 53843907, 54674041, 55173969, 55593869,
            55923724
        })
    }
}) -- Old Gate Carriage

map.nodes[66727652] = Carriage({
    id=161879,
    rewards={ Achievement({id=14771, criteria=50171}) },
    pois={
        Path({
            73116864, 72506873, 71626856, 70786928, 69946991, 69096963,
            68356880, 67766840, 67166922, 66346979, 65297056, 65067173,
            65217324, 65447461, 66117565, 66727652, 67047776, 67487904,
            68358046, 68348124, 68568163, 68918168, 69188130, 69148075,
            68838042, 68358046
        })
    }
}) -- Pridefall Carriage

map.nodes[52634155] = Carriage({
    id=174754,
    rewards={ Achievement({id=14771, criteria=50173}) },
    pois={
        Path({
            46644671, 45864613, 45784494, 45354378, 44844287, 44374202,
            44394091, 44844006, 45353914, 45743800, 45723704, 45583628,
            46173554, 46853531, 47573540, 48223570, 48883619, 49673623,
            50393626, 51023641, 51573725, 52173818, 52383928, 52404036,
            52634155, 52384269, 52394388, 52024500, 51474591, 50764667,
            49954673, 49174676, 48464699, 47694787, 47134703, 46644671
        })
    }
}) -- The Castle Carriage

-------------------------------------------------------------------------------
-------------------------------- LOYAL GORGER ---------------------------------
-------------------------------------------------------------------------------

-- Daily completion: 61843

map.nodes[59305700] = NPC({
    id=173499,
    icon=3601543,
    quest={
        61839, -- Nipping at the Undergrowth
        61840, -- Vineroot on the Menu
        61842, -- Vineroot Will Not Do
        61844, -- Hungry Hungry Gorger
        62044, -- Standing Toe to Toe
        62045, -- Ready for More
        62046  -- A New Pack
    },
    questDeps=61188,
    questCount=true,
    note=L["loyal_gorger_note"],
    rewards={
        Mount({item=182589, id=1391}) -- Loyal Gorger
    }
})

-------------------------------------------------------------------------------
------------------------------ SINRUNNER BLANCHY ------------------------------
-------------------------------------------------------------------------------

-- daily completed: 62107

local Blanchy = Class('Blanchy', NPC, {
    id=173468,
    icon=2143082,
    quest={62038, 62042, 62047, 62049, 62048, 62050},
    questCount=true,
    rewards={
        Mount({item=182614, id=1414}) -- Blanchy's Reins
    }
})

function Blanchy.getters:note ()
    local note = L["sinrunner_note"]
    local status
    for i, quest in ipairs(self.quest) do
        if C_QuestLog.IsQuestFlaggedCompleted(quest) then
            status = Shadowlands.status.Green(i)
        else
            status = Shadowlands.status.Red(i)
        end
        note = note..'\n\n'..status..' '..L["sinrunner_note_day"..i]
    end
    return note
end

map.nodes[62874341] = Blanchy()


-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = Map({ id=1543, phased=false, settings=true })

function map:Prepare ()
    Map.Prepare(self)
    self.phased = C_QuestLog.IsQuestFlaggedCompleted(62907)
end

-------------------------------------------------------------------------------
------------------------------------ INTRO ------------------------------------
-------------------------------------------------------------------------------

local MawIntro = Class('MawIntro', Shadowlands.node.Intro, {
    quest=62907, -- Eye of the Jailor activation
    label=L['return_to_the_maw'],
    note=L["maw_intro_note"]
})

map.intro = MawIntro({
    rewards={
        Quest({id={
            62882, -- Setting the Ground Rules
            60287  -- Rule 1: Have an Escape Plan
        }})
    }
})

map.nodes[80306280] = map.intro

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

-- map.nodes[] = Rare({
--     id=157964,
--     quest=nil,
--     rewards={
--         Achievement({id=14744, criteria=49841}),
--     }
-- }) -- Adjutant Dekaris

map.nodes[19324172] = Rare({
    id=170301,
    quest=60788,
    note=L["apholeias_note"],
    rewards={
        Achievement({id=14744, criteria=49842}),
        Item({item=182327}) -- Dominion Etching Loss 182327
    }
}) -- Apholeias, Herald of Loss

map.nodes[39014119] = Rare({
    id=157833,
    quest=57469,
    rewards={
        Achievement({id=14744, criteria=49843}),
    }
}) -- Borr-Geth

map.nodes[27731305] = Rare({
    id=171317,
    quest=61106,
    rewards={
        Achievement({id=14744, criteria=49844}),
    }
}) -- Conjured Death

map.nodes[60964805] = Rare({
    id=160770,
    quest=62281,
    note=L["in_cave"],
    rewards={
        Achievement({id=14744, criteria=49845}),
    }
}) -- Darithis the Bleak

map.nodes[49128175] = Rare({
    id=158025,
    quest=62282,
    rewards={
        Achievement({id=14744, criteria=49846}),
    }
}) -- Darklord Taraxis

map.nodes[32946646] = Rare({
    id=170711,
    quest=60909,
    rewards={
        Achievement({id=14744, criteria=49847}),
    }
}) -- Dolos <Death's Knife>

map.nodes[23765341] = Rare({
    id=170774,
    quest=60915,
    rewards={
        Achievement({id=14744, criteria=49848}),
    }
}) -- Eketra <The Impaler>

map.nodes[42342108] = Rare({
    id=169827,
    quest=60666,
    note=L["ekphoras_note"],
    rewards={
        Achievement({id=14744, criteria=49849}),
        Item({item=182328}) -- Dominion Etching: Grief
    }
}) -- Ekphoras, Herald of Grief

map.nodes[27584966] = Rare({
    id=154330,
    quest=57509,
    rewards={
        Achievement({id=14744, criteria=49850}),
    }
}) -- Eternas the Tormentor

map.nodes[20586935] = Rare({
    id=170303,
    quest=62260,
    note=L["exos_note"],
    rewards={
        Achievement({id=14744, criteria=49851}),
    }
}) -- Exos, Herald of Domination

map.nodes[16945102] = Rare({
    id=162849,
    quest=60987,
    rewards={
        Achievement({id=14744, criteria=49852}),
    }
}) -- Morguliax <Lord of Decapitation>

map.nodes[45507376] = Rare({
    id=158278,
    quest=57573,
    note=L["in_small_cave"],
    rewards={
        Achievement({id=14744, criteria=49853}),
    }
}) -- Nascent Devourer

map.nodes[48801830] = Rare({
    id=164064,
    quest=60667,
    rewards={
        Achievement({id=14744, criteria=49854}),
    }
}) -- Obolos <Prime Adjutant>

map.nodes[23692139] = Rare({
    id=172577,
    quest=61519,
    note=L["orophea_note"],
    rewards={
        Achievement({id=14744, criteria=49855}),
        Toy({item=181794}) -- Orophea's Lyre
    },
    pois={
        POI({26772932}) -- Eurydea's Amulet
    }
}) -- Orophea

map.nodes[30726036] = Rare({
    id=170634,
    quest=60884,
    rewards={
        Achievement({id=14744, criteria=49856}),
    }
}) -- Shadeweaver Zeris

map.nodes[35974156] = Rare({
    id=166398,
    quest=60834,
    rewards={
        Achievement({id=14744, criteria=49857}),
    }
}) -- Soulforger Rhovus

map.nodes[28701204] = Rare({
    id=170302,
    quest=60789, -- 62722?
    note=L["talaporas_note"],
    rewards={
        Achievement({id=14744, criteria=49858}),
        Item({item=182326}) -- Dominion Etching: Pain
    }
}) -- Talaporas, Herald of Pain

map.nodes[27397152] = Rare({
    id=170731,
    quest=60914,
    rewards={
        Achievement({id=14744, criteria=49859}),
    }
}) -- Thanassos <Death's Voice>

map.nodes[37676591] = Rare({
    id=172862,
    quest=61568,
    note=L["yero_note"],
    rewards={
        Achievement({id=14744, criteria=49860}),
    },
    pois={
        Path({
            37446212, 37356052, 37585887, 38465859, 39185892, 39026021,
            38456142, 38146265, 37936400, 37676591
        })
    }
}) -- Yero the Skittish

-------------------------------------------------------------------------------
---------------------------- BONUS OBJECTIVE BOSSES ---------------------------
-------------------------------------------------------------------------------

local BonusBoss = Class('BonusBoss', NPC, {
    icon = 'peg_wr',
    scale = 1.8,
    group = Shadowlands.groups.BONUS_BOSS
})

map.nodes[23004160] = BonusBoss({
    id=169102,
    quest=61136,
    note=L["in_cave"],
    rewards={
        Achievement({id=14660, criteria=49485}),
    },
    pois={
        POI({20813927}) -- Cave entrance
    }
}) -- Agonix

map.nodes[26075498] = BonusBoss({
    id=170787,
    quest=60920,
    rewards={
        Achievement({id=14660, criteria=49487}),
    }
}) -- Akros <Death's Hammer>

map.nodes[28712513] = BonusBoss({
    id=168693,
    quest=61346,
    rewards={
        Achievement({id=14660, criteria=49484}),
    }
}) -- Cyrixia <The Willbreaker>

map.nodes[25831479] = BonusBoss({
    id=162452,
    quest=59230,
    rewards={
        Achievement({id=14660, criteria=49476}),
    }
}) -- Dartanos <Flayer of Souls>

map.nodes[19205740] = BonusBoss({
    id=162844,
    quest=61140,
    rewards={
        Achievement({id=14660, criteria=50410}),
    }
}) -- Dath Rezara <Lord of Blades>

map.nodes[31982122] = BonusBoss({
    id=158314,
    quest=59183,
    rewards={
        Achievement({id=14660, criteria=49475}),
    }
}) -- Drifting Sorrow

map.nodes[60456478] = BonusBoss({
    id=172523,
    quest=62209,
    rewards={
        Achievement({id=14660, criteria=49490}),
    }
}) -- Houndmaster Vasanok

map.nodes[30846866] = BonusBoss({
    id=170692,
    quest=60903,
    rewards={
        Achievement({id=14660, criteria=49486}),
    }
}) -- Krala <Death's Wings>

map.nodes[27311754] = BonusBoss({
    id=171316,
    quest=61125,
    rewards={
        Achievement({id=14660, criteria=49488}),
    }
}) -- Malevolent Stygia

map.nodes[38642880] = BonusBoss({
    id=172207,
    quest=62618,
    rewards={
        Achievement({id=14660, criteria=50408}),
    }
}) -- Odalrik

map.nodes[25364875] = BonusBoss({
    id=162845,
    quest=60991,
    rewards={
        Achievement({id=14660, criteria=49480}),
    }
}) -- Orrholyn <Lord of Bloodletting>

map.nodes[26173744] = BonusBoss({
    id=162829,
    quest=62228,
    rewards={
        Achievement({id=14660, criteria=49479}),
    }
}) -- Razkazzar <Lord of Axes>

map.nodes[55626318] = BonusBoss({
    id=172521,
    quest=62210,
    note=L["in_cave"]..' '..L["sanngror_note"],
    rewards={
        Achievement({id=14660, criteria=49489}),
    },
    pois={
        POI({55806753}) -- Cave entrance
    }
}) -- Sanngror the Torturer

map.nodes[61737795] = BonusBoss({
    id=172524,
    quest=62211,
    note=L["in_cave"],
    rewards={
        Achievement({id=14660, criteria=49491}),
    },
    pois={
        POI({59268001}) -- Cave entrance
    }
}) -- Skittering Broodmother

map.nodes[20782968] = BonusBoss({
    id=162965,
    quest=58918,
    rewards={
        Achievement({id=14660, criteria=49481}),
    }
}) -- Sorath the Sated

map.nodes[36253744] = BonusBoss({
    id=165047,
    quest=59441,
    rewards={
        Achievement({id=14660, criteria=49482}),
    }
}) -- Soulsmith Yol-Mattar

map.nodes[36844480] = BonusBoss({
    id=156203,
    quest=62539,
    rewards={
        Achievement({id=14660, criteria=50409}),
    }
}) -- Stygian Incinerator

map.nodes[40705959] = BonusBoss({
    id=173086,
    quest=61728,
    note=L["valis_note"],
    rewards={
        Achievement({id=14660, criteria=49492}),
    }
}) -- Valis the Cruel

-- map.nodes[] = BonusBoss({
--     id=165973,
--     quest=61124,
--     rewards={
--         Achievement({id=14660, criteria=49483}),
--     }
-- }) -- Warren Mongrel

-------------------------------------------------------------------------------
---------------------------- BONUS OBJECTIVE EVENTS ---------------------------
-------------------------------------------------------------------------------

local BonusEvent = Class('BonusEvent', Shadowlands.node.Quest, {
    icon = 'peg_wy',
    scale = 1.8,
    group = Shadowlands.groups.BONUS_EVENT,
    note = ''
})

local SOUL_WELL = BonusEvent({ quest=59007, note=L["soul_well_note"] })

map.nodes[21573436] = SOUL_WELL
map.nodes[30394255] = SOUL_WELL
map.nodes[32401771] = SOUL_WELL
map.nodes[27446463] = BonusEvent({ quest=59784, note=L["obliterated_soul_shards_note"] })

-------------------------------------------------------------------------------
------------------------------ CHAOTIC RIFTSTONES -----------------------------
-------------------------------------------------------------------------------

local Riftstone = Class('Riftstone', Shadowlands.node.NPC, {
    id = 174962,
    scale = 1.3,
    group = Shadowlands.groups.RIFTSTONE,
    requires = Shadowlands.requirement.Venari(63177),
    note = L["chaotic_riftstone_note"]
})

-------------------------------------------------------------------------------

map.nodes[19184778] = Riftstone({
    icon='portal_r',
    pois = {
        Path({
            19184778, 19514836, 20374847, 20814712, 21054574, 21284422,
            21474288, 21674130, 21883962, 22093797, 22283651, 22523492,
            22793322, 23023168, 23163023, 23072884, 22642774, 22172670,
            22192555, 22632442, 23262330, 23952216, 24552100, 25181974,
            25751848, 25211784
        })
    }
})

map.nodes[25211784] = Riftstone({
    icon='portal_r',
    pois = {
        Path({
            25211784, 25591838, 25521963, 25232106, 24772195, 24222297,
            23772402, 23292515, 22812643, 22382788, 22102923, 21873072,
            21663233, 21473393, 21303536, 21113691, 20943838, 20793981,
            20644130, 20494291, 20364444, 20214618, 20074764, 19654902,
            19184778
        })
    }
})

-------------------------------------------------------------------------------

map.nodes[23433121] = Riftstone({
    icon='portal_b',
    pois = {
        Path({
            23433121, 22863048, 22972907, 23842859, 24742908, 25642985,
            26473071, 27183160, 27983266, 28793372, 29643479, 30453580,
            31263682, 32143793, 32983903, 33724011, 34214141, 34804362
        })
    }
})

map.nodes[34804362] = Riftstone({
    icon='portal_b',
    pois = {
        Path({
            34804362, 34734255, 34514116, 34083976, 33683863, 33063734,
            32353625, 31483515, 30653419, 29733318, 28853225, 28063145,
            27193061, 26212974, 25282901, 24352838, 23382834, 22742938,
            22693066, 23433121
        })
    }
})

-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 




local Intro = Shadowlands.node.Intro







local Arrow = Shadowlands.poi.Arrow


-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = Map({ id=118 })
local nodes = map.nodes

function map:Prepare ()
    Map.Prepare(self)

    -- Hide nodes until the "Return of the Scourge" is completed
    if Shadowlands.faction == 'Alliance' then
        self.phased = C_QuestLog.IsQuestFlaggedCompleted(60767)
    else
        self.phased = C_QuestLog.IsQuestFlaggedCompleted(60761)
    end
end

-------------------------------------------------------------------------------
------------------------------------ INTRO ------------------------------------
-------------------------------------------------------------------------------

if UnitFactionGroup('player') == 'Alliance' then
    map.intro = Intro({
        quest=60767,
        note=L["prepatch_intro"],
        rewards={
            Quest({id={60113, 60116, 60117, 59876, 60766, 60767}})
        }
    })
else
    map.intro = Intro({
        quest=60761,
        note=L["prepatch_intro"],
        rewards={
            Quest({id={60115, 60669, 60670, 60725, 60759, 60761}})
        }
    })
end

map.nodes[43905720] = map.intro

-------------------------------------------------------------------------------
--------------------------------- SPAWN TIMES ---------------------------------
-------------------------------------------------------------------------------

local SPAWNS = {}
local EXPECTED = {}

hooksecurefunc(HandyNotes_Shadowlands, 'OnInitialize', function ()
    SPAWNS = Shadowlands.GetDatabaseTable('prepatch', 'spawns')
    EXPECTED = Shadowlands.GetDatabaseTable('prepatch', 'expected')

    for npc = 174048, 174067 do
        if SPAWNS[npc] == nil then SPAWNS[npc] = 1 end
    end

    local function UpdateSpawnTimes(startNPC, time)
        EXPECTED[startNPC] = time + 24000 -- 6h40m
        local next = function (id) return (id == 174048) and 174067 or (id - 1) end
        local npc = next(startNPC)
        while npc ~= startNPC do
            time = time + 1200 -- 20 minutes
            EXPECTED[npc] = time
            npc = next(npc)
        end
    end

    HandyNotes_Shadowlands:RegisterEvent('VIGNETTES_UPDATED', function (...)
        for _, guid in ipairs(C_VignetteInfo.GetVignettes()) do
            local info = C_VignetteInfo.GetVignetteInfo(guid)
            if (info and info.objectGUID and info.onWorldMap) then
                local id = select(6, strsplit("-", info.objectGUID))
                local npc = tonumber(id)
                if SPAWNS[npc] and time() - SPAWNS[npc] > 3600 then
                    SPAWNS[npc] = time()
                    Shadowlands.Debug('Detected '..info.name..' spawn at '..date('%H:%M:%S', SPAWNS[npc]))
                    UpdateSpawnTimes(npc, SPAWNS[npc])
                end
            end
        end
    end)
end)

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

local ICCRare = Class('ICCRare', Rare, { fgroup='iccrares' })

function ICCRare.getters:note()
    if EXPECTED[self.id] and time() < EXPECTED[self.id] then
        local spawn = Shadowlands.color.Blue(date('%H:%M', EXPECTED[self.id]))
        return L["icecrown_rares"]..'\n\n'..L["next_spawn"]:format(spawn)
    end
    return L["icecrown_rares"]
end

function ICCRare:GetGlow(minimap)
    local expected = EXPECTED[self.id] or 0
    if expected > time() and expected - time() < 1080 then
        local _, scale, alpha = self:GetDisplayInfo(minimap)
        self.glow.alpha = alpha
        self.glow.scale = scale * 1.1
        self.glow.r, self.glow.g, self.glow.b = 1, 0, 1
        return self.glow
    end
    return Shadowlands.node.NPC.GetGlow(self, minimap)
end

local function SharedLoot(rewards)
    -- Only shared item on live appears to be the keepsake
    rewards[#rewards + 1] = Item({item=183616}) -- Accursed Keepsake
    return rewards
end

-------------------------------------------------------------------------------

nodes[31607050] = ICCRare({
    id=174067,
    --quest=62345,
    sublabel=L["orig_nax"],
    rlabel='(1)',
    rewards=SharedLoot({
        Transmog({item=183642, slot=L["cloth"]}), -- Robes of Rasped Breaths
        Transmog({item=183654, slot=L["plate"]}), -- Etched Dragonbone Stompers
        Item({item=183676, note=L["ring"]}) -- Hailstone Loop
    }),
    pois={ POI({44204910}), Arrow({44204910, 31607050}) }
}) -- Noth the Plaguebringer

nodes[36506740] = ICCRare({
    id=174066,
    --quest=62344,
    sublabel=L["orig_nax"],
    rlabel='(2)',
    rewards=SharedLoot({
        Transmog({item=183643, slot=L["2h_axe"]}), -- Severance of Mortality
        Transmog({item=183645, slot=L["leather"]}), -- Cinch of the Tortured
        Transmog({item=183644, slot=L["mail"]}) -- Regurgitator's Shoulderpads
    }),
    pois={ POI({31607050}), Arrow({31607050, 36506740}) }
}) -- Patchwerk

nodes[49703270] = ICCRare({
    id=174065,
    --quest=62343,
    sublabel=L["orig_icc"],
    rlabel='(3)',
    rewards=SharedLoot({
        Transmog({item=183647, slot=L["polearm"]}), -- Bloodspatter
        Transmog({item=183646, slot=L["mail"]}), -- Chestguard of Siphoned Vitality
        Transmog({item=183648, slot=L["plate"]}) -- Veincrusher Gauntlets
    }),
    pois={ POI({36506740}), Arrow({36506740, 49703270}) }
}) -- Blood Queen Lana'thel

nodes[57103030] = ICCRare({
    id=174064,
    --quest=62342,
    sublabel=L["orig_icc"],
    rlabel='(4)',
    rewards=SharedLoot({
        Transmog({item=183649, slot=L["leather"]}), -- Bag of Discarded Entrails
        Transmog({item=183651, slot=L["plate"]}), -- Chestplate of Septic Sutures
        Item({item=183650, note=L["trinket"]}) -- Miniscule Abomination in a Jar
    }),
    pois={ POI({49703270}), Arrow({49703270, 57103030}) }
}) -- Professor Putricide

nodes[51107850] = ICCRare({
    id=174063,
    --quest=62341,
    sublabel=L["orig_icc"],
    rlabel='(5)',
    rewards=SharedLoot({
        Transmog({item=183652, slot=L["bow"]}), -- Zod's Echoing Longbow
        Transmog({item=183653, slot=L["leather"]}), -- Deathwhisper Vestment
        Transmog({item=183655, slot=L["mail"]}) -- Handgrips of Rime and Sleet
    }),
    pois={ POI({57103030}), Arrow({57103030, 51107850}) }
}) -- Lady Deathwhisper

nodes[57805610] = ICCRare({
    id=174062,
    --quest=62340,
    sublabel=L["orig_utp"],
    rlabel='(6)',
    rewards=SharedLoot({
        Transmog({item=183656, slot=L["leather"]}), -- Drake Rider's Jerkin
        Transmog({item=183657, slot=L["mail"]}), -- Skadi's Scaled Sollerets
        Transmog({item=183670, slot=L["plate"]}), -- Skadi's Saronite Belt
        Mount({item=44151, id=264}) -- Reins of the Blue Proto-Drake
    }),
    pois={ POI({51107850}), Arrow({51107850, 57805610}) }
}) -- Skadi the Ruthless

nodes[52305260] = ICCRare({
    id=174061,
    --quest=62339,
    sublabel=L["orig_utk"],
    rlabel='(7)',
    rewards=SharedLoot({
        Transmog({item=183658, slot=L["2h_axe"]}), -- Ingvar's Monolithic Skullcleaver
        Transmog({item=183668, slot=L["leather"]}), -- Razor-Barbed Leather Belt
        Item({item=183659, note=L["ring"]}) -- Annhylde's Band
    }),
    pois={ POI({57805610}), Arrow({57805610, 52305260}) }
}) -- Ingvar the Plunderer

nodes[54004470] = ICCRare({
    id=174060,
    --quest=62338,
    sublabel=L["orig_utk"],
    rlabel='(8)',
    rewards=SharedLoot({
        Transmog({item=183678, slot=L["fist"]}), -- Keleseth's Influencer
        Transmog({item=183661, slot=L["mail"]}), -- Drake Stabler's Gauntlets
        Transmog({item=183680, slot=L["cloak"]}) -- Royal Sanguine Cloak
    }),
    pois={ POI({52305260}), Arrow({52305260, 54004470}) }
}) -- Prince Keleseth

nodes[64802210] = ICCRare({
    id=174059,
    --quest=62337,
    sublabel=L["orig_tot"],
    rlabel='(9)',
    rewards=SharedLoot({
        Transmog({item=183638, slot=L["dagger"]}), -- Phantasmic Kris
        Transmog({item=183637, slot=L["leather"]}), -- Shoulderpads of the Notorious Knave
        Transmog({item=183636, slot=L["plate"]}) -- Helm of the Violent Fracas
    }),
    pois={ POI({54004470}), Arrow({54004470, 64802210}) }
}) -- The Black Knight

nodes[70603850] = ICCRare({
    id=174058,
    --quest=62336,
    sublabel=L["orig_fos"],
    rlabel='(10)',
    rewards=SharedLoot({
        Transmog({item=183675, slot=L["cloth"]}), -- Cold Sweat Mitts
        Transmog({item=183639, slot=L["mail"]}), -- Gaze of Bewilderment
        Transmog({item=183635, slot=L["plate"]}), -- Grieving Gauntlets
        Item({item=183634}) -- Papa's Mint Condition Bag
    }),
    pois={ POI({64802210}), Arrow({64802210, 70603850}) }
}) -- Bronjahm

nodes[47136590] = ICCRare({
    id=174057,
    --quest=62335,
    sublabel=L["orig_pos"],
    rlabel='(11)',
    rewards=SharedLoot({
        Transmog({item=183674, slot=L["cloth"]}), -- Rimewoven Pantaloons
        Transmog({item=183633, slot=L["leather"]}), -- Fringed Wyrmleather Leggings
        Transmog({item=183632, slot=L["shield"]}) -- Protector of Stolen Souls
    }),
    pois={ POI({70603850}), Arrow({70603850, 47136590}) }
}) -- Scourgelord Tyrannus

nodes[59107240] = ICCRare({
    id=174056,
    --quest=62334,
    sublabel=L["orig_pos"],
    rlabel='(12)',
    rewards=SharedLoot({
        Transmog({item=183630, slot=L["2h_mace"]}), -- Garfrost's Two-Ton Bludgeon
        Transmog({item=183666, slot=L["plate"]}), -- Legguards of the Frosty Fathoms
        Item({item=183631, note=L["ring"]}) -- Ring of Carnelian and Sinew
    }),
    pois={ POI({47136590}), Arrow({47136590, 59107240}) }
}) -- Forgemaster Garfrost

nodes[58208350] = ICCRare({
    id=174055,
    --quest=62333,
    sublabel=L["orig_hor"],
    rlabel='(13)',
    rewards=SharedLoot({
        Transmog({item=183687, slot=L["cloth"]}), -- Frayed Flesh-Stitched Shoulderguards
        Transmog({item=183663, slot=L["cloth"]}), -- Sightless Capuchin of Ulmaas
        Transmog({item=183662, slot=L["mail"]}) -- Frostsworn Rattleshirt
    }),
    pois={ POI({59107240}), Arrow({59107240, 58208350}) }
}) -- Marwyn

nodes[50208810] = ICCRare({
    id=174054,
    --quest=62332,
    sublabel=L["orig_hor"],
    rlabel='(14)',
    rewards=SharedLoot({
        Transmog({item=183667, slot=L["1h_sword"]}), -- Geistslicer
        Transmog({item=183664, slot=L["cloth"]}), -- Bracer of Ground Molars
        Transmog({item=183665, slot=L["plate"]}) -- Valonforth's Marred Pauldrons
    }),
    pois={ POI({58208350}), Arrow({58208350, 50208810}) }
}) -- Falric

nodes[80326135] = ICCRare({
    id=174053,
    --quest=62331,
    sublabel=L["orig_dtk"],
    rlabel='(15)',
    rewards=SharedLoot({
        Transmog({item=183686, slot=L["leather"]}), -- Breeches of the Skeletal Serpent
        Transmog({item=183684, slot=L["shield"]}), -- Tharon'ja's Protectorate
        Item({item=183685, note=L["ring"]}) -- Phantasmic Seal of the Prophet
    }),
    pois={ POI({50208810}), Arrow({50208810, 80326135}) }
}) -- The Prophet Tharon'ja

nodes[77806610] = ICCRare({
    id=174052,
    --quest=62330,
    sublabel=L["orig_dtk"],
    rlabel='(16)',
    rewards=SharedLoot({
        Transmog({item=183627, slot=L["1h_mace"]}), -- Summoner's Granite Gavel
        Transmog({item=183671, slot=L["mail"]}), -- Necromantic Wristwraps
        Transmog({item=183672, slot=L["plate"]}) -- Cuirass of Undeath
    }),
    pois={ POI({80326135}), Arrow({80326135, 77806610}) }
}) -- Novos the Summoner

nodes[58303940] = ICCRare({
    id=174051,
    --quest=62329,
    sublabel=L["orig_dtk"],
    rlabel='(17)',
    rewards=SharedLoot({
        Transmog({item=183626, slot=L["2h_sword"]}), -- Troll Gorer
        Transmog({item=183669, slot=L["cloth"]}), -- Cowl of the Rampaging Troll
        Transmog({item=183640, slot=L["mail"]}) -- Leggings of Disreputable Charms
    }),
    pois={ POI({77806610}), Arrow({77806610, 58303940}) }
}) -- Trollgore

nodes[67505800] = ICCRare({
    id=174050,
    --quest=62328,
    sublabel=L["orig_azn"],
    rlabel='(18)',
    rewards=SharedLoot({
        Transmog({item=183681, slot=L["dagger"]}), -- Webrending Machete
        Transmog({item=183682, slot=L["cloth"]}), -- Cinch of the Servant
        Transmog({item=183683, slot=L["leather"]}) -- Skittering Vestments
    }),
    pois={ POI({58303940}), Arrow({58303940, 67505800}) }
}) -- Krik'thir the Gatewatcher

nodes[29606220] = ICCRare({
    id=174049,
    --quest=62327,
    sublabel=L["orig_atk"],
    rlabel='(19)',
    rewards=SharedLoot({
        Transmog({item=183679, slot=L["leather"]}), -- Taldaram's Supple Slippers
        Transmog({item=183677, slot=L["mail"]}), -- Blood-Drinker's Belt
        Item({item=183625, note=L["neck"]}) -- Reforged Necklace of Taldaram
    }),
    pois={ POI({67505800}), Arrow({67505800, 29606220}) }
}) -- Prince Taldaram

nodes[44204910] = ICCRare({
    id=174048,
    --quest=62326,
    sublabel=L["orig_atk"],
    rlabel='(20)',
    rewards=SharedLoot({
        Transmog({item=183624, slot=L["dagger"]}), -- Serrated Blade of Nadox
        Transmog({item=183641, slot=L["cloth"]}), -- Shoulderpads of Corpal Rigidity
        Item({item=183673, note=L["ring"]}) -- Nerubian Aegis Ring
    }),
    pois={ POI({29606220}), Arrow({29606220, 44204910}) }
}) -- Elder Nadox