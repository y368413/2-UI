-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 local Shadowlands = {}

-------------------------------------------------------------------------------
----------------------------------- COLORS ------------------------------------
-------------------------------------------------------------------------------

Shadowlands.COLORS = {
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
                if nameOnly then return name..(suffix or '') end
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
                    local icon, scale, alpha = node:GetDisplayInfo(map.id, minimap)
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

local ICONS = "Interface\\Addons\\HandyNotes\\Icons\\Artwork\\icons"
local GLOWS = "Interface\\Addons\\HandyNotes\\Icons\\Artwork\\glows"

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
            disabled = function () return Shadowlands:GetOpt('per_map_settings') end,
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
        get = function () return group:GetDisplay(map.id) end,
        set = function (info, v) group:SetDisplay(v, map.id) end,
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

local MinimapPinsKey = "HandyNotes_ShadowlandsMinimapPins"
local MinimapDataProvider = CreateFrame("Frame", "HandyNotes_ShadowlandsMinimapDP")
local MinimapPinTemplate = 'HandyNotes_ShadowlandsMinimapPinTemplate'
local MinimapPinMixin = {}

_G['HandyNotes_ShadowlandsMinimapPinMixin'] = MinimapPinMixin

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
        pin = CreateFrame("Button", "HandyNotes_ShadowlandsPin"..(#self.pins + 1), Minimap, template)
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

    local map = Shadowlands.maps[HBD:GetPlayerZone()]
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

if not self.defaults then self.defaults = {} end
    self.defaults.alpha = self.defaults.alpha or 1
    self.defaults.scale = self.defaults.scale or 1
    self.defaults.display = self.defaults.display ~= false
end

-- Override to hide this group in the UI under certain circumstances
function Group:IsEnabled()
    if self.class and self.class ~= Shadowlands.class then return false end
    if self.faction and self.faction ~= Shadowlands.faction then return false end
    return true
end

function Group:_GetOpt (option, default, mapID)
    local value
    if Shadowlands:GetOpt('per_map_settings') then
        value = Shadowlands:GetOpt(option..'_'..mapID)
    else
        value = Shadowlands:GetOpt(option)
    end
    return (value == nil) and default or value
end

function Group:_SetOpt (option, value, mapID)
    if Shadowlands:GetOpt('per_map_settings') then
        return Shadowlands:SetOpt(option..'_'..mapID, value)
    end
    return Shadowlands:SetOpt(option, value)
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

function Node:GetDisplayInfo(mapID, minimap)
    local icon = Shadowlands.GetIconPath(self.icon)
    local scale = self.scale * self.group:GetScale(mapID)
    local alpha = self.alpha * self.group:GetAlpha(mapID)

    if not minimap and WorldMapFrame.isMaximized and Shadowlands:GetOpt('maximized_enlarged') then
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
    if self.class and self.class ~= Shadowlands.class then return false end
    if self.faction and self.faction ~= Shadowlands.faction then return false end
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
    Shadowlands.PrepareLinks(self.title)
end

function Section:Render(tooltip)
    tooltip:AddLine(Shadowlands.RenderLinks(self.title, true)..':')
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
                status = Shadowlands.status.Green(L['defeated'])
            else
                status = Shadowlands.status.Red(L['undefeated'])
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
    return Shadowlands.GetIconLink('quest_ay', 13)..' '..(name or UNKNOWN)
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

Shadowlands.reward = {
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
    local map, icon = Shadowlands.maps[self:GetParent():GetMapID()]

    if level == 1 then
        UIDropDownMenu_AddButton({
            isTitle = true,
            notCheckable = true,
            text = WORLD_MAP_FILTER_TITLE
        })

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
    local size = pin.minimap and 4 or (pin.parentHeight * 0.003)
    local line_width = pin.minimap and 60 or (pin.parentHeight * 0.05)

    -- apply user scaling
    size = size * Shadowlands:GetOpt('poi_scale')
    line_width = line_width * Shadowlands:GetOpt('poi_scale')

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
    head_length = head_length * Shadowlands:GetOpt('poi_scale')
    head_width = head_width * Shadowlands:GetOpt('poi_scale')
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
------------------------------ CALLING TREASURES ------------------------------
-------------------------------------------------------------------------------

-- Add reward information to Blizzard's vignette treasures for callings

local VIGNETTES = {
    [4212] = {
        Pet({item=180592, id=2901}) -- Trapped Stonefiend
    }, -- Bleakwood Chest
    [4214] = {
        Toy({item=184418}) -- Acrobatic Steward
    }, -- Gilded Chest
    [4366] = {
        Toy({item=184447}) -- Kevin's Party Supplies
    }, -- Slime-Coated Crate

    -- [4174] = {}, -- Secret Treasure
    -- [4176] = {}, -- Secret Treasure
    -- [4202] = {}, -- Spouting Growth
    -- [4211] = {}, -- Bonebound Chest
    -- [4213] = {}, -- Enchanted Chest
    -- [4222] = {}, -- Faerie Stash
    -- [4224] = {}, -- Faerie Stash
    -- [4225] = {}, -- Faerie Stash
    -- [4238] = {}, -- Lunarlight Pod
    -- [4243] = {}, -- Skyward Bell
    -- [4244] = {}, -- Wish Cricket
    -- [4263] = {}, -- Silver Strongbox
    -- [4266] = {}, -- Silver Strongbox
    -- [4269] = {}, -- Silver Strongbox
    -- [4270] = {}, -- Silver Strongbox
    -- [4271] = {}, -- Silver Strongbox
    -- [4272] = {}, -- Silver Strongbox
    -- [4274] = {}, -- Steward's Golden Chest
    -- [4275] = {}, -- Skyward Bell
    -- [4278] = {}, -- Hidden Hoard
    -- [4279] = {}, -- Hidden Hoard
    -- [4282] = {}, -- Virtue of Penitence
    -- [4308] = {}, -- Stoneborn Satchel
    -- [4314] = {}, -- Pugilist's Prize
    -- [4317] = {}, -- Pugilist's Prize
    -- [4323] = {}, -- Stoneborn Satchel
    -- [4324] = {}, -- Stoneborn Satchel
    -- [4325] = {}, -- Stoneborn Satchel
    -- [4327] = {}, -- Stoneborn Satchel
    -- [4347] = {}, -- Greedstone
    -- [4362] = {}, -- Spouting Growth
    -- [4363] = {}, -- Spouting Growth
    -- [4374] = {}, -- Runebound Coffer
    -- [4375] = {}, -- Runebound Coffer
}

hooksecurefunc(GameTooltip, 'SetText', function(self)
    local owner = self:GetOwner()
    if owner and owner.vignetteID then
        local rewards = VIGNETTES[owner.vignetteID]
        if rewards and #rewards > 0 then
            self:AddLine(' ') -- add blank line before rewards
            for i, reward in ipairs(rewards) do
                if reward:IsEnabled() then
                    reward:Render(self)
                end
            end
        end
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

function Reward:GetCategoryIcon()
    return self.covenant and Shadowlands.GetIconPath(self.covenant.icon)
end

function Reward:IsObtainable()
    if self.covenant then
        if self.covenant.id ~= C_Covenants.GetActiveCovenantID() then
            return false
        end
    end
    return true
end

-------------------------------------------------------------------------------
----------------------------------- GROUPS ------------------------------------
-------------------------------------------------------------------------------

Shadowlands.groups.ANIMA_SHARD = Group('anima_shard', 'crystal_b', {defaults=Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.BLESSINGS = Group('blessings', 1022951, {defaults=Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.BONUS_BOSS = Group('bonus_boss', 'peg_rd')
Shadowlands.groups.BONUS_EVENT = Group('bonus_event', 'peg_yw')
Shadowlands.groups.CARRIAGE = Group('carriages', 'horseshoe_g', {defaults=Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.DREDBATS = Group('dredbats', 'flight_point_g', {defaults=Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.FAERIE_TALES = Group('faerie_tales', 355498, {defaults=Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.FUGITIVES = Group('fugitives', 236247, {defaults=Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.GRAPPLES = Group('grapples', 'peg_bk', {defaults=Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.INQUISITORS = Group('inquisitors', 3528307, {defaults=Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.MAW_LORE = Group('maw_lore', 'chest_gy')
Shadowlands.groups.RIFTSTONE = Group('riftstone', 'portal_b')
Shadowlands.groups.SINRUNNER = Group('sinrunners', 'horseshoe_o', {defaults=Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.SLIME_CAT = Group('slime_cat', 3732497, {defaults=Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.STYGIAN_CACHES = Group('stygian_caches', 'chest_nv', {defaults=Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.VESPERS = Group('vespers', 3536181, {defaults=Shadowlands.GROUP_HIDDEN})

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

 



local Collectible = Shadowlands.node.Collectible
local PetBattle = Shadowlands.node.PetBattle
local Rare = Shadowlands.node.Rare
local Treasure = Shadowlands.node.Treasure

local Achievement = Shadowlands.reward.Achievement
local Item = Shadowlands.reward.Item
local Mount = Shadowlands.reward.Mount
local Pet = Shadowlands.reward.Pet
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
        Achievement({id=14309, criteria=48714}),
        Transmog({item=180166, slot=L["staff"]}) -- Deathbinder's Staff
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
        Achievement({id=14309, criteria=48790}),
        Transmog({item=179539, slot=L["2h_mace"]}) -- Kelox's Eggbeater
    }
}) -- Egg-Tender Leh'go

map.nodes[68612765] = Rare({
    id=171688,
    quest=61184,
    note=L["faeflayer_note"],
    rewards={
        Achievement({id=14309, criteria=48798}),
        Transmog({item=180144, slot=L["1h_axe"]}) -- Faeflayer's Hatchet
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
    note=L["gormtamer_tizo_note"],
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
        Item({item=183091, quest=62246}) -- Lifewoven Bracelet
    }
}) -- Hunter Vivian

local MACABRE = Rare({
    id=164093,
    quest=59140,
    note=L["macabre_note"],
    rewards={
        Achievement({id=14309, criteria=48780}),
        Pet({item=180644, id=2907}) -- Rocky
    }
}) -- Macabre

map.nodes[32664480] = MACABRE
map.nodes[36474814] = MACABRE
map.nodes[47924018] = MACABRE
-- map.nodes[57912935] = MACABRE
map.nodes[59952940] = MACABRE

map.nodes[62102470] = Rare({
    id=165053,
    quest=59431,
    note=L["mymaen_note"],
    rewards={
        Achievement({id=14309, criteria=48788}),
        Transmog({item=179502, slot=L["dagger"]}) -- Ripvine Barb
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

map.nodes[65702809] = Rare({
    id=164547,
    quest=59235,
    note=L["rainbowhorn_note"],
    glow=RainbowGlow({ icon=Shadowlands.GetGlowPath('skull_w') }),
    rewards={
        Achievement({id=14309, criteria=48715}),
        Transmog({item=179586, slot=L["bow"]}), -- Elderwood Piercer
        Item({item=182179, quest=62434, covenant=NIGHTFAE}) -- Runestag Soul
    },
    pois={
        POI({
            25015001, 27014503, 39026001, 30043610, 41317121, 44801918,
            50012003, 55235575, 58376104
        }), -- Great Horn of the Runestag
        Path({
            65702809, 65672916, 65352999, 65233107, 65013210, 64853308,
            64573397, 64213482, 63623536, 62963583, 62263646, 61453630,
            60813657, 60143712, 59313711, 58963710, 58653677, 58063633,
            57523568, 57033495, 56643411, 56513330, 56123234, 55663140,
            55283023, 55682914, 55732793, 54942744, 54062761, 53352839,
            53052966, 53163094, 53183227, 52843340, 53343426, 54143466,
            54953438, 55733402, 56643411
        }), -- Loop 1
        Path({
            58963710, 58453771, 57893818, 57553889, 57263955, 56793999,
            56264029, 55764055, 55334097, 54994158, 54764224, 54564296,
            54234346, 53844383, 53384412, 52894450, 52344454, 51894489,
            51474549, 50804577, 50174571, 49404575, 48724543, 48034533,
            47474474, 46934420, 46354351, 45654325, 45334245, 44934144,
            44524072, 43854049, 43194024, 42514002, 41893955, 41253933,
            40573894, 39933849, 39313791, 38623767, 37943792, 37633838,
            37423955, 37464080, 37754181, 38254275, 38614375, 38804493,
            38874601, 38914713, 39264816, 39664905, 40254978, 40975018,
            41745053, 42545065, 43114997, 43834977, 44564987, 45284962,
            45984909, 46564839, 47284763, 47794667, 48034533
        })
    }
}) -- Mystic Rainbowhorn

map.nodes[57874983] = Rare({
    id=168135,
    quest=60306,
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
        Achievement({id=14309, criteria=48791}),
        Transmog({item=179603, slot=L["shield"]}) -- Nettlehusk Barrier
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
}) -- Rotbriar Boggart

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
        Transmog({item=180146, slot=L["1h_axe"]}), -- Axe of Broken Wills
        Item({item=182183, quest=62439, covenant=NIGHTFAE}) -- Wolfhawk Soul
    }
}) -- Skuld Vit

map.nodes[59304660] = Rare({
    id=167721,
    quest=60290,
    note=L["slumbering_note"],
    rewards={
        Achievement({id=14309, criteria=48792}),
        Item({item=175711, note=L["ring"]}) -- Slumberwood Band
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
        Transmog({item=180154, slot=L["2h_axe"]}), -- Greataxe of Unrelenting Pursuit
        Mount({item=180730, id=1393, covenant=NIGHTFAE}), -- Wild Glimmerfur Prowler
        Item({item=182176, quest=62431, covenant=NIGHTFAE}) -- Shadowstalker Soul
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
        Achievement({id=14309, criteria=48783}),
        Transmog({item=181396, slot=L["polearm"]}) -- Thornsweeper Scythe
    }
}) -- Wrigglemortis

--------------------------- STAR LAKE AMPHITHEATER ----------------------------

map.nodes[41254443] = Rare({
    id=171743,
    quest=61633, -- 61205 ??
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
        }}),
        Item({item=182454, type=L["trinket"], note=L["guldan"]}), -- Murmurs in the Dark
        Mount({item=180748, id=1332}) -- Silky Shimmermoth
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
        Transmog({item=179549, slot=L["1h_mace"]}), -- Nightwillow Cudgel
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
        Transmog({item=179593, slot=L["cloth"]}), -- Darkreach Mask
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
        POI({31763247, 36445960}) -- Aromatic Flowers
    }
}) -- Desiccated Moth

map.nodes[37643706] = Treasure({
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
        Transmog({item=179512, slot=L["1h_sword"]}), -- Dreamsong Saber
        Toy({item=184490}) -- Fae Pipes
    },
    pois={
        POI({46497011}), -- Faerie Lamp
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
        Achievement({id=14313, criteria=50036}),
        Transmog({item=179565, slot=L["offhand"]}), -- Songwood Stem
        Toy({item=184489}) -- Fae Harp
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
map.nodes[34224452] = PetBattle({
    id=175778,
    rewards={
        Achievement({id=14881, criteria=51048})
    }
}) -- Briarpaw

map.nodes[26546222] = PetBattle({
    id=175779,
    note=L["in_small_cave"],
    rewards={
        Achievement({id=14881, criteria=51049})
    }
}) -- Chittermaw

map.nodes[49884175] = PetBattle({
    id=175780,
    note=L["in_small_cave"],
    rewards={
        Achievement({id=14881, criteria=51050})
    }
}) -- Mistwing

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
    note=L["faryl_note"],
    rewards={
        Achievement({id=14625, criteria=49403}),
        Shadowlands.reward.Spacer(),
        Achievement({id=14868, criteria=11, oneline=true}), -- Aquatic
        Achievement({id=14869, criteria=11, oneline=true}), -- Beast
        Achievement({id=14870, criteria=11, oneline=true}), -- Critter
        Achievement({id=14871, criteria=11, oneline=true}), -- Dragon
        Achievement({id=14872, criteria=11, oneline=true}), -- Elemental
        Achievement({id=14873, criteria=11, oneline=true}), -- Flying
        Achievement({id=14874, criteria=11, oneline=true}), -- Humanoid
        Achievement({id=14875, criteria=11, oneline=true}), -- Magic
        Achievement({id=14876, criteria=11, oneline=true}), -- Mechanical
        Achievement({id=14877, criteria=11, oneline=true}), -- Undead
    }
}) -- Faryl

map.nodes[58205690] = PetBattle({
    id=173372,
    note=L["glitterdust_note"],
    rewards={
        Achievement({id=14625, criteria=49405}),
        Shadowlands.reward.Spacer(),
        Achievement({id=14868, criteria=10, oneline=true}), -- Aquatic
        Achievement({id=14869, criteria=10, oneline=true}), -- Beast
        Achievement({id=14870, criteria=10, oneline=true}), -- Critter
        Achievement({id=14871, criteria=10, oneline=true}), -- Dragon
        Achievement({id=14872, criteria=10, oneline=true}), -- Elemental
        Achievement({id=14873, criteria=10, oneline=true}), -- Flying
        Achievement({id=14874, criteria=10, oneline=true}), -- Humanoid
        Achievement({id=14875, criteria=10, oneline=true}), -- Magic
        Achievement({id=14876, criteria=10, oneline=true}), -- Mechanical
        Achievement({id=14877, criteria=10, oneline=true}), -- Undead
    }
}) -- Glitterdust
-------------------------------------------------------------------------------
---------------------------- FRACTURED FAIRY TALES ----------------------------
-------------------------------------------------------------------------------

local Tale = Class('Tale', Collectible, {
    icon=355498,
    note=L["lost_book_note"],
    group=Shadowlands.groups.FAERIE_TALES,
    pois={
        POI({63622274}) -- Archivist Dreyden
    },
    IsCollected = function (self)
        if Shadowlands.PlayerHasItem(self.rewards[2].item) then return true end
        return Collectible.IsCollected(self)
    end
})

local MEANDERING = Tale({
    id=174721,
    rewards={
        Achievement({id=14788, criteria=50012}),
        Item({item=183877, quest=62619})
    },
    pois={
        Path({
            53054452, 53544400, 54204350, 54674267, 54974164, 55444087,
            56044040, 56684009, 57253957, 57573871, 58013798, 58603759,
            58913716
        })
    }
}) -- A Meandering Story

local WANDERING = Tale({
    id=174723,
    rewards={
        Achievement({id=14788, criteria=50013}),
        Item({item=183878, quest=62620})
    }
}) -- A Wandering Tale

local ESCAPIST = Tale({
    id=174724,
    rewards={
        Achievement({id=14788, criteria=50014}),
        Item({item=183879, quest=62621})
    }
}) -- An Escapist Novel

local JOURNAL = Tale({
    id=174725,
    rewards={
        Achievement({id=14788, criteria=50015}),
        Item({item=183880, quest=62622})
    }
}) -- A Travel Journal

local NAUGHTY = Tale({
    id=174726,
    rewards={
        Achievement({id=14788, criteria=50016}),
        Item({item=183881, quest=62623})
    }
}) -- A Naughty Story

map.nodes[56044040] = MEANDERING

map.nodes[30004480] = WANDERING
map.nodes[35602680] = WANDERING
map.nodes[36404800] = WANDERING
map.nodes[37894005] = WANDERING

map.nodes[32603160] = ESCAPIST
map.nodes[40004460] = ESCAPIST
map.nodes[40602760] = ESCAPIST
map.nodes[40944230] = ESCAPIST

map.nodes[40094168] = JOURNAL
map.nodes[49664016] = JOURNAL
map.nodes[50202500] = JOURNAL
map.nodes[50174187] = JOURNAL

map.nodes[33605740] = NAUGHTY
map.nodes[39806560] = NAUGHTY
map.nodes[51005480] = NAUGHTY

-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

 



local Collectible = Shadowlands.node.Collectible
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
            32762035, 33062071, 33172321
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
        Achievement({id=14307, criteria=50602})
        -- Toy({item=182655}) -- Hill King's Roarbox (gone?)
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
        -- Toy({item=174445}), -- Glimmerfly Cocoon
        Transmog({item=179485, slot=L["dagger"]}), -- Fang of Nemaeus
        Transmog({item=179486, slot=L["1h_mace"]}), -- Sigilback's Smashshell
        Transmog({item=179487, slot=L["warglaive"]}), -- Aethon's Horn
        Transmog({item=179488, slot=L["fist"]}), -- Cloudtail's Paw
    }
}) -- Beasts of Bastion

map.nodes[55826249] = Rare({
    id=171189,
    quest=59022,
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
        Pet({item=180812, id=2925}) -- Golden Cloudfeather
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
            64174218, -- Mercia's Legacy: Chapter Seven
            65074138, -- Mercia's Legacy: Chapter Seven
            65184396, -- Mercia's Legacy: Chapter Seven
            65514293, -- Mercia's Legacy: Chapter Seven
            65844451, -- Mercia's Legacy: Chapter Seven
            66214333, -- Mercia's Legacy: Chapter Seven
            67394283, -- Mercia's Legacy: Chapter Seven
            67604342, -- Mercia's Legacy: Chapter Seven
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
        Achievement({id=14307, criteria=50603}),
        Transmog({item=184297, slot=L["2h_sword"]}) -- Death Warden's Greatblade
    }
}) -- Dark Watcher

map.nodes[37004180] = Rare({
    id=171011,
    quest={61069,61000},
    note=L["demi_hoarder_note"],
    rewards={
        Achievement({id=14307, criteria=50611}),
        -- https://www.wowhead.com/object=354649/relic-hoard
        Transmog({item=183606, slot=L["shield"]}), -- Bulwark of Echoing Courage
        Transmog({item=183608, slot=L["offhand"]}), -- Evernote Vesper
        Transmog({item=183613, slot=L["dagger"]}), -- Glinting Daybreak Dagger
        Transmog({item=183611, slot=L["2h_sword"]}), -- Humble Ophelia's Greatblade
        Transmog({item=183609, slot=L["fist"]}), -- Re-Powered Golliath Fists
        Transmog({item=183607, slot=L["polearm"]}), -- Uncertain Aspirant's Spear
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
        Achievement({id=14307, criteria=50595}),
        Pet({item=180856, id=2932}) -- Silvershell Snapper
    }
}) -- Dionae

map.nodes[45656550] = Rare({
    id=171255,
    quest={61082,61091,62251},
    rewards={
        Achievement({id=14307, criteria=50614}),
        Item({item=180062}) -- Heavenly Drum
    },
    pois={
        Path({
            45126865, 45596837, 45836792, 46266754, 46326688, 46756655,
            47196619, 47366568, 47516509, 47196458, 46916413, 46516378,
            46036393, 45726457, 45636517, 45686586, 45896645, 46326688
        }),
        Path({
            45896645, 45406672, 45106624, 44756599, 44636542, 44656487,
            45046456, 45436462, 45696476
        })
        -- Path({45546459, 44656486, 44766596, 45366670, 45866643, 45616562})
    }
}) -- Echo of Aella <Hand of Courage>

map.nodes[51151953] = Rare({
    id=171009,
    quest=60998,
    note=L["aegeon_note"],
    rewards={
        Achievement({id=14307, criteria=50605}),
        Toy({item=184404}) -- Ever-Abundant Hearth
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
        -- https://www.wowhead.com/object=336428/aspirants-chest
        -- Item({item=182759, quest=62200}) -- Functioning Anima Core
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

map.nodes[22432285] = Rare({
   id=156339,
   label=GetAchievementCriteriaInfoByID(14307, 50618) or UNKNOWN,
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

local SWELLING_TEAR = Rare({
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
        Transmog({item=183605, slot=L["warglaive"]}), -- Devourer Wrought Warglaive
        Pet({item=180869, id=2940}) -- Devoured Wader
    }
}) -- Swelling Tear

map.nodes[39604499] = SWELLING_TEAR
map.nodes[47434282] = SWELLING_TEAR
map.nodes[52203280] = SWELLING_TEAR
map.nodes[56031463] = SWELLING_TEAR
map.nodes[59825165] = SWELLING_TEAR
map.nodes[63503590] = SWELLING_TEAR

map.nodes[53498868] = Rare({
    id=170899,
    quest=60977, -- 60933 makes Cache of the Ascended visible
    label=GetAchievementCriteriaInfoByID(14307, 50619),
    note=L["ascended_council_note"],
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
}) -- The Ascended Council

map.nodes[43482524] = Rare({
    id=171008,
    quest=60997,
    note=L["unstable_memory_note"],
    rewards={
        Achievement({id=14307, criteria=50606}),
        Toy({item=184413}) -- Mnemonic Attunement Pane
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

map.nodes[61061510] = Treasure({
    quest=61698,
    label=L["cloudwalkers_coffer"],
    note=L["cloudwalkers_coffer_note"],
    rewards={
        Item({item=180783}) -- Design: Crown of the Righteous
    },
    pois={
        POI({59011639}) -- First Flower
    }
}) -- Cloudwalker's Coffer

map.nodes[51471795] = Treasure({
    quest=61052,
    requires=Shadowlands.requirement.Item(180534),
    note=L["experimental_construct_part"],
    rewards={
        Achievement({id=14311, criteria=50054}),
        Transmog({item=183609, slot=L["fist"]}) -- Re-Powered Golliath Fists
    },
    pois={
        POI({
            49811739, 50871471, 52041999, 52471448, 52861966, 53001500,
            53141903, 53541715
        }) -- Unstable Anima Core
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
        Achievement({id=14311, criteria=50060}),
        Toy({item=183988}) -- Bondable Val'kyr Diadem
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
        Achievement({id=14311, criteria=50061}),
        Transmog({item=181290, slot=L["cosmetic"], covenant=KYRIAN}) -- Harmonious Sigil of the Archon
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
        Pet({item=180859, id=2935}) -- Purity
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
            33996651, -- Kobri (Cliffs of Respite)
            43573224, -- Kobri (Sagehaven)
            47967389, -- Kobri (Aspirant's Rest)
            51804641, -- Kobri (Hero's Rest)
            52164709, -- Kobri (Hero's Rest)
            53498033, -- Kobri (Aspirant's Crucible)
        })
    }
}) -- Memorial Offering

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
    quest=61183, -- 61229 (mallet forged) 61191 (vesper rung)
    requires=Shadowlands.requirement.Item(180858),
    label=L["vesper_of_silver_wind"],
    note=L["vesper_of_silver_wind_note"],
    rewards={
        Mount({item=180772, id=1404}) -- Silverwind Larion
    }
}) -- Vesper of the Silver Wind


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

map.nodes[52727429] = PetBattle({
    id=175777,
    rewards={
        Achievement({id=14881, criteria=51047})
    }
}) -- Crystalsnap

map.nodes[25903078] = PetBattle({
    id=175783,
    rewards={
        Achievement({id=14881, criteria=51053})
    }
}) -- Digallo

map.nodes[46524930] = PetBattle({
    id=175785,
    rewards={
        Achievement({id=14881, criteria=51055})
    }
}) -- Kostos

map.nodes[34806280] = PetBattle({
    id=173131,
    note=L["stratios_note"],
    rewards={
        Achievement({id=14625, criteria=49416}),
        Shadowlands.reward.Spacer(),
        Achievement({id=14868, criteria=9, oneline=true}), -- Aquatic
        Achievement({id=14869, criteria=9, oneline=true}), -- Beast
        Achievement({id=14870, criteria=9, oneline=true}), -- Critter
        Achievement({id=14871, criteria=9, oneline=true}), -- Dragon
        Achievement({id=14872, criteria=9, oneline=true}), -- Elemental
        Achievement({id=14873, criteria=9, oneline=true}), -- Flying
        Achievement({id=14874, criteria=9, oneline=true}), -- Humanoid
        Achievement({id=14875, criteria=9, oneline=true}), -- Magic
        Achievement({id=14876, criteria=9, oneline=true}), -- Mechanical
        Achievement({id=14877, criteria=9, oneline=true}), -- Undead
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
    note=L["zolla_note"],
    rewards={
        Achievement({id=14625, criteria=49415}),
        Shadowlands.reward.Spacer(),
        Achievement({id=14868, criteria=7, oneline=true}), -- Aquatic
        Achievement({id=14869, criteria=7, oneline=true}), -- Beast
        Achievement({id=14870, criteria=7, oneline=true}), -- Critter
        Achievement({id=14871, criteria=7, oneline=true}), -- Dragon
        Achievement({id=14872, criteria=7, oneline=true}), -- Elemental
        Achievement({id=14873, criteria=7, oneline=true}), -- Flying
        Achievement({id=14874, criteria=7, oneline=true}), -- Humanoid
        Achievement({id=14875, criteria=7, oneline=true}), -- Magic
        Achievement({id=14876, criteria=7, oneline=true}), -- Mechanical
        Achievement({id=14877, criteria=7, oneline=true}), -- Undead
    }
}) -- Zolla

map.nodes[54555609] = PetBattle({
    id=173129,
    note=L["thenia_note"],
    rewards={
        Achievement({id=14625, criteria=49414}),
        Shadowlands.reward.Spacer(),
        Achievement({id=14868, criteria=8, oneline=true}), -- Aquatic
        Achievement({id=14869, criteria=8, oneline=true}), -- Beast
        Achievement({id=14870, criteria=8, oneline=true}), -- Critter
        Achievement({id=14871, criteria=8, oneline=true}), -- Dragon
        Achievement({id=14872, criteria=8, oneline=true}), -- Elemental
        Achievement({id=14873, criteria=8, oneline=true}), -- Flying
        Achievement({id=14874, criteria=8, oneline=true}), -- Humanoid
        Achievement({id=14875, criteria=8, oneline=true}), -- Magic
        Achievement({id=14876, criteria=8, oneline=true}), -- Mechanical
        Achievement({id=14877, criteria=8, oneline=true}), -- Undead
    }
}) -- Thenia


-------------------------------------------------------------------------------
----------------------------- COUNT YOUR BLESSINGS ----------------------------
-------------------------------------------------------------------------------

map.nodes[34753001] = Collectible({
    icon=1022951,
    group=Shadowlands.groups.BLESSINGS,
    label='{spell:327976}',
    note=L["count_your_blessings_note"],
    rewards={
        Achievement({id=14767, criteria=49946})
    }
}) -- Purified Blessing of Fortitude

map.nodes[53832886] = Collectible({
    icon=1022951,
    group=Shadowlands.groups.BLESSINGS,
    label='{spell:327974}',
    note=L["count_your_blessings_note"],
    rewards={
        Achievement({id=14767, criteria=49944})
    }
}) -- Purified Blessing of Grace

map.nodes[45285979] = Collectible({
    icon=1022951,
    group=Shadowlands.groups.BLESSINGS,
    label='{spell:327975}',
    note=L["count_your_blessings_note"],
    rewards={
        Achievement({id=14767, criteria=49945})
    }
}) -- Purified Blessing of Power

-------------------------------------------------------------------------------
------------------------- RALLYING CRY OF THE ASCENDED ------------------------
-------------------------------------------------------------------------------

map.nodes[32171776] = Collectible({
    icon=3536181,
    group=Shadowlands.groups.VESPERS,
    label=L["vesper_of_loyalty"],
    note=L["vespers_ascended_note"],
    rewards={
        Achievement({id=14734, criteria=49817})
    }
}) -- Vesper of Loyalty

map.nodes[33325980] = Collectible({
    icon=3536181,
    group=Shadowlands.groups.VESPERS,
    label=L["vesper_of_courage"],
    note=L["vespers_ascended_note"],
    rewards={
        Achievement({id=14734, criteria=49815})
    }
}) -- Vesper of Courage

map.nodes[39132038] = Collectible({
    icon=3536181,
    group=Shadowlands.groups.VESPERS,
    label=L["vesper_of_wisdom"],
    note=L["vespers_ascended_note"],
    rewards={
        Achievement({id=14734, criteria=49819})
    }
}) -- Vesper of Wisdom

map.nodes[64326980] = Collectible({
    icon=3536181,
    group=Shadowlands.groups.VESPERS,
    label=L["vesper_of_purity"],
    note=L["vespers_ascended_note"],
    rewards={
        Achievement({id=14734, criteria=49818})
    }
}) -- Vesper of Purity

map.nodes[71933896] = Collectible({
    icon=3536181,
    group=Shadowlands.groups.VESPERS,
    label=L["vesper_of_humility"],
    note=L["vespers_ascended_note"],
    rewards={
        Achievement({id=14734, criteria=49816})
    }
}) -- Vesper of Humility

-------------------------------------------------------------------------------
--------------------------------- SHARD LABOR ---------------------------------
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

map.nodes[60552554] = AnimaShard({
    quest={61298, 61299, 61300},
    questCount=true,
    note=L["anima_shard_spires"]
})

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
        Achievement({id=14308, criteria=48876}),
        Transmog({item=184290, slot=L["dagger"]}), -- Blood-Dyed Bonesaw
        Transmog({item=184154, slot=L["cosmetic"]}), -- Grungy Containment Pack
        Toy({item=184476}) -- Regenerating Slime Vial
    }
}) -- Bubbleblood

map.nodes[49012351] = Rare({
    id=159105,
    quest=58005,
    rewards={
        Achievement({id=14308, criteria=48866}),
        Transmog({item=184188, slot=L["1h_axe"]}), -- Collector's Corpse Gambrel
        Transmog({item=184181, slot=L["1h_axe"]}), -- Kash's Favored Hook
        Transmog({item=184189, slot=L["1h_axe"]}), -- Stained Fleshgorer
        Transmog({item=184182, slot=L["1h_axe"]}) -- Strengthened Abomination Hook
    }
}) -- Collector Kash

map.nodes[26392633] = Rare({
    id=157058,
    quest=58335,
    rewards={
        Achievement({id=14308, criteria=48872}),
        Transmog({item=184177, slot=L["1h_axe"]}), -- Grotesque Goring Pick
        Transmog({item=184176, slot=L["warglaive"]}) -- Moroc's Boneslicing Warglaive
    }
}) -- Corpsecutter Moroc

map.nodes[76835707] = Rare({
    id=162711,
    quest=58868,
    rewards={
        Achievement({id=14308, criteria=48851}),
        Transmog({item=184280, slot=L["cloth"]}), -- Dapper Threads
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
        Achievement({id=14308, criteria=48855}),
        Transmog({item=184178, slot=L["2h_sword"]}) -- Worldrending Claymore
    }
}) -- Devour'us

map.nodes[31603540] = Rare({
    id=162741,
    quest=58872,
    covenant=NECROLORD,
    requires=Shadowlands.requirement.GarrisonTalent(1250, L["anima_channeled"]),
    note=L["gieger_note"],
    rewards={
        Transmog({item=184298, slot=L["offhand"]}), -- Amalgamated Forsworn's Journal
        Mount({item=182080, id=1411, covenant=NECROLORD}) -- Predatory Plagueroc
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
        Achievement({id=14308, criteria=49724}),
        -- Item({item=184174, note=L["ring"]}), -- Clasp of Death
        Transmog({item=181810, slot=L["cosmetic"]}) -- Phylactery of the Dead Conniver
    }
}) -- Necromantic Anomaly

map.nodes[66023532] = Rare({
    id=162690,
    quest=58851,
    rewards={
        Achievement({id=14308, criteria=49723}),
        Transmog({item=184179, slot=L["2h_sword"]}), -- Lichsworn Commander's Boneblade
        Mount({item=182084, id=1373}) -- Gorespine
    }
}) -- Nerissa Heartless

map.nodes[50346328] = Rare({
    id=161857,
    quest=58629,
    note=L["nirvaska_note"],
    rewards={
        Achievement({id=14308, criteria=48868}),
        Transmog({item=183700, slot=L["cloth"]}) -- Forgotten Summoner's Shoulderpads
    }
}) -- Nirvaska the Summoner

map.nodes[53726132] = Rare({
    id=162767,
    quest=58875,
    rewards={
        Achievement({id=14308, criteria=48849}),
        Transmog({item=182205, slot=L["mail"]}) -- Scarab-Shell Faceguard
    }
}) -- Pesticide

map.nodes[53841877] = Rare({
    id=159753,
    quest=58004,
    rewards={
        Achievement({id=14308, criteria=48865}),
        Transmog({item=184184, slot=L["dagger"]}), -- Ravenomous's Acid-Tipped Stinger
        Pet({item=181283, id=2964}) -- Foulwing Buzzer
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
        Mount({item=181815, id=1370, covenant=NECROLORD}) -- Armored Bonehoof Tauralus
    }
}) -- Sabriel the Bonecleaver

map.nodes[62107580] = Rare({
    id=158406,
    quest=58006,
    rewards={
        Achievement({id=14308, criteria=48857}),
        Transmog({item=184287, slot=L["mail"]}), -- Scum-Caked Epaulettes
        Pet({item=181267, id=2957}) -- Writhing Spine
    }
}) -- Scunner

map.nodes[55502361] = Rare({
    id=159886,
    quest=58003,
    note=L["chelicerae_note"],
    rewards={
        Achievement({id=14308, criteria=48873}),
        Transmog({item=184289, slot=L["1h_sword"]}), -- Spindlefang Spellblade
        Pet({item=181172, id=2948}) -- Boneweave Hatchling
    }
}) -- Sister Chelicerae

map.nodes[42465345] = Rare({
    id=162528,
    quest=58768,
    rewards={
        Achievement({id=14308, criteria=48869}),
        Transmog({item=184299, slot=L["leather"]}), -- Goresoaked Carapace
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
        Mount({item=182075, id=1366, covenant=NECROLORD}) -- Bonehoof Tauralus
    }
}) -- Tahonta

map.nodes[50562011] = Rare({
    id=160059,
    quest=58091,
    note=L["taskmaster_xox_note"],
    rewards={
        Achievement({id=14308, criteria=48867}),
        Transmog({item=184186, slot=L["1h_axe"]}), -- Flesh-Fishing Hook
        Transmog({item=184192, slot=L["1h_axe"]}), -- Pristine Alabaster Gorer
        Transmog({item=184187, slot=L["1h_axe"]}) -- Taskmaster's Tenderizer
    }
}) -- Taskmaster Xox

map.nodes[24184297] = Rare({
    id=162180,
    quest=58678,
    note=L["leeda_note"],
    rewards={
        Achievement({id=14308, criteria=48870}),
        Transmog({item=184180, slot=L["cloth"]}) -- Leeda's Unrefined Mask
    }
}) -- Thread Mistress Leeda

map.nodes[33718016] = Rare({
    id=162819,
    quest=58889,
    rewards={
        Achievement({id=14308, criteria=48875}),
        Transmog({item=184288, slot=L["shield"]}), -- Ruthless Warlord's Barrier
        Mount({item=182085, id=1372}) -- Blisterback Bloodtusk
    }
}) -- Warbringer Mal'Korak

map.nodes[28965138] = Rare({
    id=157125,
    quest=59290,
    requires=Shadowlands.requirement.Item(175841),
    note=L["zargox_the_reborn_note"],
    rewards={
        Achievement({id=14308, criteria=48864}),
        Transmog({item=184285, slot=L["plate"]}), -- Boneclutched Shackles
        Transmog({item=181804, slot=L["cosmetic"], covenant=NECROLORD}) -- Trophy of the Reborn Bonelord
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
        Toy({item=183903}), -- Smelly Jelly
        -- Item({item=184185, type=L["neck"], note=L["Boneslurp"]}), -- Grunge-Caked Collarbone
        -- Item({item=184279, type=L["trinket"], note=L["Pulsing"]}), -- Siphoning Blood-Drinker
        Shadowlands.reward.Spacer(),
        Shadowlands.reward.Section('{npc:157308}'), -- Corrupted Sediment
        Transmog({item=184302, slot=L["mail"], indent=true}), -- Residue-Coated Muck Waders
        Shadowlands.reward.Spacer(),
        Shadowlands.reward.Section('{npc:157309}'), -- Violet Mistake
        Transmog({item=184301, slot=L["leather"], indent=true}), -- Twenty-Loop Violet Girdle
        Mount({item=182079, id=1410, indent=true}), -- Slime-Covered Reins of the Hulking Deathroc
        Shadowlands.reward.Spacer(),
        Shadowlands.reward.Section('{npc:157312}'), -- Oily Invertebrate
        Transmog({item=184300, slot=L["cloak"], indent=true}), -- Fused Spineguard
        Item({item=184155, note=L["cosmetic"], quest=62804, indent=true}), -- Recovered Containment Pack
        Pet({item=181270, id=2960, indent=true}) -- Decaying Oozewalker
    }
})

------------------------------- THEATER OF PAIN -------------------------------

map.nodes[50354728] = Rare({
    id=162853,
    quest=62786,
    label=C_Map.GetMapInfo(1683).name,
    note=L["theater_of_pain_note"],
    rewards = {
        Achievement({id=14802, criteria={
            50397, -- Azmogal
            50398, -- Unbreakable Urtz
            50399, -- Xantuth the Blighted
            50400, -- Mistress Dyrax
            50402, -- Devmorta
            50403, -- Ti'or
            48874  -- Sabriel the Bonecleaver
        }}),
        Mount({item=184062, id=1437}) -- Gnawed Reins of the Battle-Bound Warhound
    }
})

-------------------------------------------------------------------------------
---------------------------------- TREASURES ----------------------------------
-------------------------------------------------------------------------------

map.nodes[44083989] = Treasure({
    quest=60368,
    label=L["blackhound_cache"],
    note=L["blackhound_cache_note"],
    covenant=NECROLORD,
    rewards={
        Toy({item=184318}) -- Battlecry of Krexus
    }
}) -- Blackhound Cache

-- map.nodes[36797862] = Treasure({
--     label=L["bladesworn_supply_cache"]
-- }) -- Bladesworn Supply Cache

map.nodes[54011234] = Treasure({
    label=L["cache_of_eyes"],
    note=L["cache_of_eyes_note"],
    rewards={
        Pet({item=181171, id=2947}) -- Luminous Webspinner
    },
    -- Still no quest id for this chest, so we'll just complete when collected
    IsCompleted = function (self) return self:IsCollected() end
}) -- Cache of Eyes

map.nodes[48301630] = Treasure({
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

map.nodes[62405997] = Treasure({
    quest=60311,
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
        Pet({item=183515, id=3045}) -- Iridescent Ooze
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

local STOLEN_JAR = Treasure({
    quest=61451,
    note=L["stolen_jar_note"],
    rewards={
        Achievement({id=14312, criteria=50067}),
        Item({item=182618, quest=62085}) -- ... Why Me?
    }
}) -- Stolen Jar

map.nodes[66135027] = STOLEN_JAR
map.nodes[66145045] = STOLEN_JAR
map.nodes[73564986] = STOLEN_JAR

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

map.nodes[61907879] = PetBattle({
    id=175784,
    rewards={
        Achievement({id=14881, criteria=51054})
    }
}) -- Gelatinous

map.nodes[26482675] = PetBattle({
    id=175786,
    rewards={
        Achievement({id=14881, criteria=51056})
    }
}) -- Glurp

map.nodes[34005526] = PetBattle({
    id=173263,
    note=L["rotgut_note"],
    rewards={
        Achievement({id=14625, criteria=49412}),
        Shadowlands.reward.Spacer(),
        Achievement({id=14868, criteria=4, oneline=true}), -- Aquatic
        Achievement({id=14869, criteria=4, oneline=true}), -- Beast
        Achievement({id=14870, criteria=4, oneline=true}), -- Critter
        Achievement({id=14871, criteria=4, oneline=true}), -- Dragon
        Achievement({id=14872, criteria=4, oneline=true}), -- Elemental
        Achievement({id=14873, criteria=4, oneline=true}), -- Flying
        Achievement({id=14874, criteria=4, oneline=true}), -- Humanoid
        Achievement({id=14875, criteria=4, oneline=true}), -- Magic
        Achievement({id=14876, criteria=4, oneline=true}), -- Mechanical
        Achievement({id=14877, criteria=4, oneline=true}), -- Undead
    }
}) -- Rotgut

map.nodes[46865000] = PetBattle({
    id=173257,
    note=L["maximillian_note"],
    rewards={
        Achievement({id=14625, criteria=49413}),
        Shadowlands.reward.Spacer(),
        Achievement({id=14868, criteria=6, oneline=true}), -- Aquatic
        Achievement({id=14869, criteria=6, oneline=true}), -- Beast
        Achievement({id=14870, criteria=6, oneline=true}), -- Critter
        Achievement({id=14871, criteria=6, oneline=true}), -- Dragon
        Achievement({id=14872, criteria=6, oneline=true}), -- Elemental
        Achievement({id=14873, criteria=6, oneline=true}), -- Flying
        Achievement({id=14874, criteria=6, oneline=true}), -- Humanoid
        Achievement({id=14875, criteria=6, oneline=true}), -- Magic
        Achievement({id=14876, criteria=6, oneline=true}), -- Mechanical
        Achievement({id=14877, criteria=6, oneline=true}), -- Undead
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
    note=L["dundley_note"],
    rewards={
        Achievement({id=14625, criteria=49411}),
        Shadowlands.reward.Spacer(),
        Achievement({id=14868, criteria=5, oneline=true}), -- Aquatic
        Achievement({id=14869, criteria=5, oneline=true}), -- Beast
        Achievement({id=14870, criteria=5, oneline=true}), -- Critter
        Achievement({id=14871, criteria=5, oneline=true}), -- Dragon
        Achievement({id=14872, criteria=5, oneline=true}), -- Elemental
        Achievement({id=14873, criteria=5, oneline=true}), -- Flying
        Achievement({id=14874, criteria=5, oneline=true}), -- Humanoid
        Achievement({id=14875, criteria=5, oneline=true}), -- Magic
        Achievement({id=14876, criteria=5, oneline=true}), -- Mechanical
        Achievement({id=14877, criteria=5, oneline=true}), -- Undead
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

 



local Collectible = Shadowlands.node.Collectible
local NPC = Shadowlands.node.NPC
local Arrow = Shadowlands.poi.Arrow













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
        Transmog({item=179926, slot=L["cloth"]}), -- Light-Infused Tunic
        Transmog({item=179924, slot=L["leather"]}), -- Light-Infused Jacket
        Transmog({item=179653, slot=L["mail"]}), -- Light-Infused Hauberk
        Transmog({item=179925, slot=L["plate"]}), -- Light-Infused Breastplate
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
    quest=59823,
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
        Transmog({item=183739, slot=L["cloth"]}), -- Endmire Wristwarmers
        Mount({item=180582, id=1379}), -- Endmire Flyer
    }
}) -- Famu the Infinite

map.nodes[32641545] = Rare({
    id=159496,
    quest=61618,
    covenant=VENTHYR,
    requires=Shadowlands.requirement.GarrisonTalent(1259, L["anima_channeled"]),
    note=L["madalav_note"],
    rewards={
        Transmog({item=180939, slot=L["cosmetic"]}) -- Mantle of the Forgemaster's Dark Blades
    },
    pois={
        POI({32661483}) -- Madalav's Hammer
    }
}) -- Forgemaster Madalav

map.nodes[20485298] = Rare({
    id=167464,
    quest=60173,
    note=L["grand_arcanist_dimitri_note"],
    rewards={
        Achievement({id=14310, criteria=48821}),
        Transmog({item=180503, slot=L["dagger"]}) -- Grand Arcanist's Soulblade
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
        Mount({item=180461, id=1310, covenant=VENTHYR}) -- Horrid Brood Dredwing
    },
    pois={
        POI({43257769}) -- Ballista Bolt
    }
}) -- Harika the Horrid

map.nodes[51985179] = Rare({
    id=166679,
    quest=59900,
    rewards={
        Achievement({id=14310, criteria=48817}),
        Mount({item=180581, id=1298, covenant=VENTHYR}) -- Hopecrusher Gargon
    }
}) -- Hopecrusher

map.nodes[61717949] = Rare({
    id=166993,
    quest=60022,
    rewards={
        Achievement({id=14310, criteria=48820}),
        Item({item=180705, class='HUNTER'}) -- Gargon Training Manual
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
        Transmog({item=183736, slot=L["cloth"]}), -- Pride Resistant Handwraps
        Pet({item=180585, id=2897}) -- Bottled Up Rage
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
        Pet({item=180585, id=2897}) -- Bottled Up Rage
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
    id=160392,
    quest=58130,
    note=L["soulstalker_doina_note"],
    rewards={
        Achievement({id=14310, criteria=48799})
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
    quest=61231,
    note=L["tomb_burster_note"],
    rewards={
        Achievement({id=14310, criteria=48802}),
        Pet({item=180584, id=2891}) -- Blushing Spiderling
    }
}) -- Tomb Burster

map.nodes[38607200] = Rare({
    id=160821,
    quest=58259,
    requires=Shadowlands.requirement.Item(173939),
    note=L["worldedge_gorger_note"],
    rewards={
        Achievement({id=14310, criteria=48805}),
        Item({
            item=180583,
            quest=61188,
            IsObtained = function (self)
                if select(11, C_MountJournal.GetMountInfoByID(1391)) then
                    return true
                end
                return Item.IsObtained(self)
            end
        }), -- Impressionable Gorger Spawn
        Mount({item=182589, id=1391}) -- Loyal Gorger
    }
}) -- Worldedge Gorger

-------------------------------------------------------------------------------
---------------------------------- TREASURES ----------------------------------
-------------------------------------------------------------------------------
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
        Achievement({id=14314, criteria=50897})
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
        Achievement({id=14314, criteria=50084}),
        Toy({item=184075}) -- Stonewrought Sentry
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
    note=L["smuggled_cache_note"],
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
    quest=62063,
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

map.nodes[25662361] = PetBattle({
    id=175781,
    rewards={
        Achievement({id=14881, criteria=51051})
    }
}) -- Sewer Creeper

map.nodes[53004149] = PetBattle({
    id=175782,
    rewards={
        Achievement({id=14881, criteria=51052})
    }
}) -- The Countess

map.nodes[39945249] = PetBattle({
    id=173315,
    note=L["sylla_note"],
    rewards={
        Achievement({id=14625, criteria=49408}),
        Shadowlands.reward.Spacer(),
        Achievement({id=14868, criteria=1, oneline=true}), -- Aquatic
        Achievement({id=14869, criteria=1, oneline=true}), -- Beast
        Achievement({id=14870, criteria=1, oneline=true}), -- Critter
        Achievement({id=14871, criteria=1, oneline=true}), -- Dragon
        Achievement({id=14872, criteria=1, oneline=true}), -- Elemental
        Achievement({id=14873, criteria=1, oneline=true}), -- Flying
        Achievement({id=14874, criteria=1, oneline=true}), -- Humanoid
        Achievement({id=14875, criteria=1, oneline=true}), -- Magic
        Achievement({id=14876, criteria=1, oneline=true}), -- Mechanical
        Achievement({id=14877, criteria=1, oneline=true}), -- Undead
    }
}) -- Sylla

map.nodes[61354121] = PetBattle({
    id=173331,
    note=L["addius_note"],
    rewards={
        Achievement({id=14625, criteria=49406}),
        Shadowlands.reward.Spacer(),
        Achievement({id=14868, criteria=3, oneline=true}), -- Aquatic
        Achievement({id=14869, criteria=3, oneline=true}), -- Beast
        Achievement({id=14870, criteria=3, oneline=true}), -- Critter
        Achievement({id=14871, criteria=3, oneline=true}), -- Dragon
        Achievement({id=14872, criteria=3, oneline=true}), -- Elemental
        Achievement({id=14873, criteria=3, oneline=true}), -- Flying
        Achievement({id=14874, criteria=3, oneline=true}), -- Humanoid
        Achievement({id=14875, criteria=3, oneline=true}), -- Magic
        Achievement({id=14876, criteria=3, oneline=true}), -- Mechanical
        Achievement({id=14877, criteria=3, oneline=true}), -- Undead
    }
}) -- Addius the Tormentor

map.nodes[67626608] = PetBattle({
    id=173324,
    note=L["eyegor_note"],
    rewards={
        Achievement({id=14625, criteria=49407}),
        Shadowlands.reward.Spacer(),
        Achievement({id=14868, criteria=2, oneline=true}), -- Aquatic
        Achievement({id=14869, criteria=2, oneline=true}), -- Beast
        Achievement({id=14870, criteria=2, oneline=true}), -- Critter
        Achievement({id=14871, criteria=2, oneline=true}), -- Dragon
        Achievement({id=14872, criteria=2, oneline=true}), -- Elemental
        Achievement({id=14873, criteria=2, oneline=true}), -- Flying
        Achievement({id=14874, criteria=2, oneline=true}), -- Humanoid
        Achievement({id=14875, criteria=2, oneline=true}), -- Magic
        Achievement({id=14876, criteria=2, oneline=true}), -- Mechanical
        Achievement({id=14877, criteria=2, oneline=true}), -- Undead
    }
}) -- Eyegor

-------------------------------------------------------------------------------
---------------------------------- CARRIAGES ----------------------------------
-------------------------------------------------------------------------------

local Carriage = Class('Carriage', NPC, {
    icon = 'horseshoe_g',
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

map.nodes[47694787] = Carriage({
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
------------------------------ CASTLE SINRUNNERS ------------------------------
-------------------------------------------------------------------------------

local Sinrunner = Class('Sinrunner', NPC, {
    icon = 'horseshoe_o',
    scale = 1.2,
    group = Shadowlands.groups.SINRUNNER
})

map.nodes[41304731] = Sinrunner({
    id=174032,
    requires=Shadowlands.requirement.Currency(1820, 5),
    rewards={ Achievement({id=14770, criteria={50175,50176}}) },
    pois={
        Path({
            41304731, 41464669, 42054607, 41874510, 41124495, 40244475,
            39414432, 39064339, 39064170, 39054014, 39093895, 39633808,
            39973739, 39483657, 39063587, 39043502, 39513412, 40053319,
            40363272, 40853196, 41433106, 41833043, 42202985, 42732902,
            43232849, 43872849, 44512868, 45022906, 45063013, 45063112,
            45063208, 45053252, 45383261, 45343344, 45043348, 45053397,
            44853458, 44343536, 44153626, 43983713, 43883809, 43743902,
            44153988, 44034071, 43304079, 42684134, 42354225, 42034311,
            42044416, 42084502, 42054607
        })
    }
}) -- Hole in the Wall => Ramparts => Hole in the Wall

map.nodes[39464455] = Sinrunner({
    id=174032,
    requires=Shadowlands.requirement.Currency(1820, 5),
    rewards={ Achievement({id=14770, criteria={50175,50176}}) },
    pois={
        Path({
            39464455, 39064339, 39064170, 39054014, 39093895, 39633808,
            39973739, 39483657, 39063587, 39043502, 39513412, 40053319,
            40363272, 40853196, 41433106, 41833043, 42202985, 42732902,
            43232849, 43872849, 44512868, 45022906, 45063013, 45063112,
            45063208, 45053252, 45383261, 45343344, 45043348, 45053397,
            44853458, 44343536, 44153626, 43983713, 43883809, 43743902,
            44153988, 44034071, 43304079, 42684134, 42354225, 42034311,
            42044416, 42084502, 42054607, 41464669, 41304731
        })
    }
}) -- The Abandoned Purlieu => Hole in the Wall

map.nodes[40153776] = Sinrunner({
    id=174032,
    requires=Shadowlands.requirement.Currency(1820, 5),
    rewards={ Achievement({id=14770, criteria={50175,50176}}) },
    pois={
        Path({
            40153776, 39973739, 39483657, 39063587, 39043502, 39513412,
            40053319, 40363272, 40853196, 41433106, 41833043, 42202985,
            42732902, 43232849, 43872849, 44512868, 45022906, 45063013,
            45063112, 45063208, 45053252, 45383261, 45343344, 45043348,
            45053397, 44853458, 44343536, 44153626, 43983713, 43883809,
            43743902, 44153988, 44034071, 43304079, 42684134, 42354225,
            42034311, 42044416, 42084502, 42054607, 41464669, 41304731
        })
    }
}) -- Dominance Gate => Hole in the Wall

map.nodes[60346271] = Sinrunner({
    id=174032,
    requires=Shadowlands.requirement.Currency(1820, 5),
    rewards={ Achievement({id=14770, criteria=50174}) },
    pois={
        Path({
            60346271, 59926265, 59296277, 58786286, 58176293, 57536310,
            56776328, 56156337, 55596351, 55246340, 55096242, 54966141,
            54826032, 54665928, 54485856, 54365781, 54255677, 54525588,
            54895519, 55475485, 56195445, 56775395, 57395347, 57945307,
            58375248, 58805183, 59025103, 58945013, 59014930, 59194847,
            59194760, 59194686, 59124605, 58964517, 58884437, 58824343,
            58794245, 58754166, 58804094, 59234033, 59433974, 59763915,
            60183876, 60633892, 60763966
        })
    }
}) -- Darkhaven => Old Gate

map.nodes[55246221] = Sinrunner({
    id=174032,
    requires=Shadowlands.requirement.Currency(1820, 5),
    rewards={ Achievement({id=14770, criteria=50174}) },
    pois={
        Path({
            55246221, 54966141, 54826032, 54665928, 54485856, 54365781,
            54255677, 54525588, 54895519, 55475485, 56195445, 56775395,
            57395347, 57945307, 58375248, 58805183, 59025103, 58945013,
            59014930, 59194847, 59194760, 59194686, 59124605, 58964517,
            58884437, 58824343, 58794245, 58754166, 58804094, 59234033,
            59433974, 59763915, 60183876, 60633892, 60763966
        })
    }
}) -- Wildwall => Old Gate

map.nodes[71624105] = Sinrunner({
    id=174032,
    requires=Shadowlands.requirement.Currency(1820, 5),
    rewards={ Achievement({id=14770, criteria=50177}) },
    pois={
        Path({
            71624105, 72164110, 72834061, 73464009, 73894112, 74404207,
            74984302, 75614371, 76374405, 76824489, 77044604, 77064722,
            77454830, 77504953, 77635068, 77265175, 76855266, 76435372,
            76045451, 75505532, 75165648, 74705738, 74095803, 73315796,
            72455795, 71685792, 70935796, 70305858, 69645824, 68525724,
            67825686, 67025699, 66165737, 65455787, 64735861, 64005885,
            63235874, 62585910, 62446025, 62436123, 62936212, 63396186
        })
    }
}) -- Absolution Crypt => Darkhaven

map.nodes[77394882] = Sinrunner({
    id=174032,
    requires=Shadowlands.requirement.Currency(1820, 5),
    rewards={ Achievement({id=14770, criteria=50177}) },
    pois={
        Path({
            77394882, 77504953, 77635068, 77265175, 76855266, 76435372,
            76045451, 75505532, 75165648, 74705738, 74095803, 73315796,
            72455795, 71685792, 70935796, 70305858, 69645824, 68525724,
            67825686, 67025699, 66165737, 65455787, 64735861, 64005885,
            63235874, 62585910, 62446025, 62436123, 62936212, 63396186
        })
    }
}) -- Edge of Sin => Darkhaven

map.nodes[76365372] = Sinrunner({
    id=174032,
    requires=Shadowlands.requirement.Currency(1820, 5),
    rewards={ Achievement({id=14770, criteria=50177}) },
    pois={
        Path({
            76365372, 76045451, 75505532, 75165648, 74705738, 74095803,
            73315796, 72455795, 71685792, 70935796, 70305858, 69645824,
            68525724, 67825686, 67025699, 66165737, 65455787, 64735861,
            64005885, 63235874, 62585910, 62446025, 62436123, 62936212,
            63396186
        })
    }
}) -- Edge of Sin => Darkhaven

map.nodes[69635800] = Sinrunner({
    id=174032,
    requires=Shadowlands.requirement.Currency(1820, 5),
    rewards={ Achievement({id=14770, criteria=50177}) },
    pois={
        Path({
            69635800, 69115793, 68525724, 67825686, 67025699, 66165737,
            65455787, 64735861, 64005885, 63235874, 62585910, 62446025,
            62436123, 62936212, 63396186
        })
    }
}) -- Edge of Sin => Darkhaven

map.nodes[48836885] = Sinrunner({
    id=174032,
    requires=Shadowlands.requirement.Currency(1820, 5),
    rewards={ Achievement({id=14770, criteria=50175}) },
    pois={
        Path({
            48836885, 48776937, 49306972, 49847016, 50256959, 50726915,
            51176855, 51566801, 52106783, 52626798, 53026849, 53466892,
            53926909, 54236859, 54266781, 54156698, 54036627, 53986562,
            53936490, 53986407, 54476370, 55086352, 55066266, 54916179,
            54846142, 54676026, 54505916, 54355828, 54195723, 53835626,
            53355546, 52575540, 51845510, 51225437, 50725358, 50225280,
            49595233, 48905194, 48365134, 47715199, 47205278, 46625368,
            46115446, 45655519, 45155587, 44515616, 43715627, 42995614,
            42295630, 41675639, 41035649, 40575560, 40125460, 39955357,
            39485259, 39245155, 39335039, 39724939, 40174839, 40564749,
            40844697
        })
    }
}) -- Wanecrypt Hill => Hole in the Wall

map.nodes[54926234] = Sinrunner({
    id=174032,
    requires=Shadowlands.requirement.Currency(1820, 5),
    rewards={ Achievement({id=14770, criteria=50175}) },
    pois={
        Path({
            54926234, 54846142, 54676026, 54505916, 54355828, 54195723,
            53835626, 53355546, 52575540, 51845510, 51225437, 50725358,
            50225280, 49595233, 48905194, 48365134, 47715199, 47205278,
            46625368, 46115446, 45655519, 45155587, 44515616, 43715627,
            42995614, 42295630, 41675639, 41035649, 40575560, 40125460,
            39955357, 39485259, 39245155, 39335039, 39724939, 40174839,
            40564749, 40844697
        })
    }
}) -- Wildwall => Hole in the Wall

map.nodes[53535504] = Sinrunner({
    id=174032,
    requires=Shadowlands.requirement.Currency(1820, 5),
    rewards={ Achievement({id=14770, criteria=50175}) },
    pois={
        Path({
            53535504, 52575540, 51845510, 51225437, 50725358, 50225280,
            49595233, 48905194, 48365134, 47715199, 47205278, 46625368,
            46115446, 45655519, 45155587, 44515616, 43715627, 42995614,
            42295630, 41675639, 41035649, 40575560, 40125460, 39955357,
            39485259, 39245155, 39335039, 39724939, 40174839, 40564749,
            40844697
        })
    }
}) -- Briar Gate => Hole in the Wall

map.nodes[44035641] = Sinrunner({
    id=174032,
    requires=Shadowlands.requirement.Currency(1820, 5),
    rewards={ Achievement({id=14770, criteria=50175}) },
    pois={
        Path({
            44035641, 43715627, 42995614, 42295630, 41675639, 41035649,
            40575560, 40125460, 39955357, 39485259, 39245155, 39335039,
            39724939, 40174839, 40564749, 40844697
        })
    }
}) -- Charred Ramparts => Hole in the Wall

-------------------------------------------------------------------------------
------------------------------- DREDBAT STATUES -------------------------------
-------------------------------------------------------------------------------

local Dredbat = Class('Dredbat', NPC, {
    id=161015,
    icon='flight_point_g',
    group=Shadowlands.groups.DREDBATS,
    requires=Shadowlands.requirement.Currency(1820, 5),
    rewards={ Achievement({id=14769, criteria={id=1, qty=true}}) }
})
map.nodes[25103757] = Dredbat({ pois={ Arrow({25103757, 30024700}) } })
map.nodes[31905920] = Dredbat({ pois={ Arrow({31905920, 38954941}) } })
map.nodes[57246125] = Dredbat({ pois={ Arrow({57246125, 60286116}) } })
map.nodes[60396117] = Dredbat({ pois={ Arrow({60396117, 57495549}) } })
map.nodes[64076201] = Dredbat({ pois={ Arrow({64076201, 70125719}) } })
map.nodes[64076201] = Dredbat({ pois={ Arrow({64076201, 70125719}) } })

-------------------------------------------------------------------------------
------------------------------ ABSOLUTION FOR ALL -----------------------------
-------------------------------------------------------------------------------


local SOULS = {
    64894834, 65404450, 65704610, 65904250, 66274301, 67894205, 68165149,
    68604460, 69215297, 70045363, 70105630, 70205500, 70494580, 70604340,
    70605200, 70605200, 70804400, 71004180, 71305350, 71504690, 71584367,
    71595309, 71705440, 72224482, 72304440, 72605510, 72624360, 72795195,
    74455192, 75174702
}

for _, coord in ipairs(SOULS) do
    map.nodes[coord] = NPC({
        id=156150,
        icon='peg_yw',
        scale=1,
        note=L["fugitive_soul_note"],
        group=Shadowlands.groups.FUGITIVES,
        rewards={
            Achievement({id=14274, criteria={id=1, qty=true, suffix=L["souls_absolved"]}})
        }
    })
end

local RITUALISTS = {
    65305069, 65324883, 66585357, 67204610, 69204650, 69304210, 71704790,
    72004600, 72505390
}

for _, coord in ipairs(RITUALISTS) do
    map.nodes[coord] = NPC({
        id=159406,
        icon='peg_bk',
        scale=1.2,
        note=L["avowed_ritualist_note"],
        group=Shadowlands.groups.FUGITIVES,
        rewards={
            Achievement({id=14274, criteria={id=1, qty=true, suffix=L["souls_absolved"]}})
        }
    })
end

-------------------------------------------------------------------------------
------------------------ ITS ALWAYS SINNY IN REVENDRETH -----------------------
-------------------------------------------------------------------------------

local Inquisitor = Class('Inquisitor', Collectible, {
    icon='peg_rd',
    scale=1.3,
    group=Shadowlands.groups.INQUISITORS,
    pois={ POI({72995199}) } -- Archivist Fane
})

map.nodes[76185212] = Inquisitor({
    id=159151,
    note=L["inquisitor_note"],
    requires=Shadowlands.requirement.Item(172999),
    rewards={
        Achievement({id=14276, criteria=48136})
    }
}) -- Inquisitor Traian

map.nodes[64714638] = Inquisitor({
    id=156918,
    note=L["inquisitor_note"],
    requires=Shadowlands.requirement.Item(172998),
    rewards={
        Achievement({id=14276, criteria=48135})
    }
}) -- Inquisitor Otilia

map.nodes[67274339] = Inquisitor({
    id=156919,
    note=L["inquisitor_note"],
    requires=Shadowlands.requirement.Item(172997),
    rewards={
        Achievement({id=14276, criteria=48134})
    }
}) -- Inquisitor Petre

map.nodes[69764722] = Inquisitor({
    id=156916,
    note=L["inquisitor_note"],
    requires=Shadowlands.requirement.Item(172996),
    rewards={
        Achievement({id=14276, criteria=48133})
    }
}) -- Inquisitor Sorin

map.nodes[75304415] = Inquisitor({
    id=159152,
    note=L["high_inquisitor_note"],
    requires=Shadowlands.requirement.Item(173000),
    rewards={
        Achievement({id=14276, criteria=48137})
    }
}) -- High Inquisitor Gabi

map.nodes[71254236] = Inquisitor({
    id=159153,
    note=L["high_inquisitor_note"],
    requires=Shadowlands.requirement.Item(173001),
    rewards={
        Achievement({id=14276, criteria=48138})
    }
}) -- High Inquisitor Radu

map.nodes[72085313] = Inquisitor({
    id=159155,
    note=L["high_inquisitor_note"],
    requires=Shadowlands.requirement.Item(173006),
    rewards={
        Achievement({id=14276, criteria=48140})
    }
}) -- High Inquisitor Dacian

map.nodes[69775225] = Inquisitor({
    id=159154,
    note=L["high_inquisitor_note"],
    requires=Shadowlands.requirement.Item(173005),
    rewards={
        Achievement({id=14276, criteria=48139})
    }
}) -- High Inquisitor Magda

map.nodes[69664542] = Inquisitor({
    id=159157,
    note=L["grand_inquisitor_note"],
    requires=Shadowlands.requirement.Item(173008),
    rewards={
        Achievement({id=14276, criteria=48142})
    }
}) -- Grand Inquisitor Aurica

map.nodes[64485273] = Inquisitor({
    id=159156,
    note=L["grand_inquisitor_note"],
    requires=Shadowlands.requirement.Item(173007),
    rewards={
        Achievement({id=14276, criteria=48141})
    }
}) -- Grand Inquisitor Nicu

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
    local function status(i)
        if C_QuestLog.IsQuestFlaggedCompleted(self.quest[i]) then
            return Shadowlands.status.Green(i)
        else
            return Shadowlands.status.Red(i)
        end
    end

    local note = L["sinrunner_note"]
    note = note..'\n\n'..status(1)..' '..L["sinrunner_note_day1"]
    note = note..'\n\n'..status(2)..' '..L["sinrunner_note_day2"]
    note = note..'\n\n'..status(3)..' '..L["sinrunner_note_day3"]
    note = note..'\n\n'..status(4)..' '..L["sinrunner_note_day4"]
    note = note..'\n\n'..status(5)..' '..L["sinrunner_note_day5"]
    note = note..'\n\n'..status(6)..' '..L["sinrunner_note_day6"]
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

map.nodes[25923116] = Rare({
    id=157964,
    quest=57482,
    note=L["dekaris_note"],
    rlabel=Shadowlands.status.LightBlue('+80 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49841})
    }
}) -- Adjutant Dekaris

map.nodes[19324172] = Rare({
    id=170301,
    quest=60788,
    note=L["apholeias_note"],
    rlabel=Shadowlands.status.LightBlue('+100 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49842}),
        Item({item=184106, note=L["ring"]}), -- Gimble
        Item({item=182327}) -- Dominion Etching: Loss
    }
}) -- Apholeias, Herald of Loss

map.nodes[39014119] = Rare({
    id=157833,
    quest=57469,
    rlabel=Shadowlands.status.LightBlue('+100 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49843}),
        Toy({item=184312}) -- Borr-Geth's Fiery Brimstone
    }
}) -- Borr-Geth

map.nodes[27731305] = Rare({
    id=171317,
    quest=61106,
    rlabel=Shadowlands.status.LightBlue('+80 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49844}),
        Transmog({item=183887, slot=L["1h_sword"]}) -- Suirhtaned, Blade of the Heir
    }
}) -- Conjured Death

map.nodes[60964805] = Rare({
    id=160770,
    quest=62281,
    note=L["in_cave"],
    rlabel=Shadowlands.status.LightBlue('+100 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49845})
    }
}) -- Darithis the Bleak

map.nodes[49128175] = Rare({
    id=158025,
    quest=62282,
    rlabel=Shadowlands.status.LightBlue('+80 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49846})
    }
}) -- Darklord Taraxis

map.nodes[28086058] = Rare({
    id=170711,
    quest=60909,
    rlabel=Shadowlands.status.LightBlue('+100 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49847})
    }
}) -- Dolos <Death's Knife>

map.nodes[23765341] = Rare({
    id=170774,
    quest=60915,
    rlabel=Shadowlands.status.LightBlue('+100 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49848})
    }
}) -- Eketra <The Impaler>

map.nodes[42342108] = Rare({
    id=169827,
    quest=60666,
    note=L["ekphoras_note"],
    rlabel=Shadowlands.status.LightBlue('+100 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49849}),
        Item({item=184105, note=L["ring"]}), -- Gyre
        Item({item=182328}) -- Dominion Etching: Grief
    }
}) -- Ekphoras, Herald of Grief

map.nodes[19194608] = Rare({ -- was 27584966
    id=154330,
    quest=57509,
    rlabel=Shadowlands.status.LightBlue('+80 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49850}),
        Pet({item=183407, id=3037}) -- Contained Essence of Dread
    }
}) -- Eternas the Tormentor

map.nodes[20586935] = Rare({
    id=170303,
    quest=62260,
    note=L["exos_note"],
    rlabel=Shadowlands.status.LightBlue('+100 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49851}),
        Item({item=184108, note=L["neck"]}), -- Vorpal Amulet
        Item({item=183066, quest=63160}), -- Korrath's Grimoire: Aleketh
        Item({item=183067, quest=63161}), -- Korrath's Grimoire: Belidir
        Item({item=183068, quest=63162})  -- Korrath's Grimoire: Gyadrek
    }
}) -- Exos, Herald of Domination

map.nodes[53507950] = Rare({
    id=174827,
    note=L["gorged_shadehound_note"],
    -- quest=61124,
    rewards={
        Mount({item=184167, id=1304}) -- Mawsworn Soulhunter
    }
}) -- Gorged Shadehound

map.nodes[30775000] = Rare({
    id=175012,
    quest=62788,
    note=L["ikras_note"],
    rlabel=Shadowlands.status.LightBlue('+100 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=50621})
    }
}) -- Ikras the Devourer

map.nodes[16945102] = Rare({
    id=162849,
    quest=60987,
    rlabel=Shadowlands.status.LightBlue('+100 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49852}),
        Toy({item=184292}) -- Ancient Elethium Coin
    }
}) -- Morguliax <Lord of Decapitation>

map.nodes[45507376] = Rare({
    id=158278,
    quest=57573,
    note=L["in_small_cave"],
    rlabel=Shadowlands.status.LightBlue('+80 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49853})
    }
}) -- Nascent Devourer

map.nodes[48801830] = Rare({
    id=164064,
    quest=60667,
    rlabel=Shadowlands.status.LightBlue('+80 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49854})
    }
}) -- Obolos <Prime Adjutant>

map.nodes[23692139] = Rare({
    id=172577,
    quest=61519,
    note=L["orophea_note"],
    rlabel=Shadowlands.status.LightBlue('+80 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49855}),
        Toy({item=181794}) -- Orophea's Lyre
    },
    pois={
        POI({26772932}) -- Eurydea's Amulet
    }
}) -- Orophea

map.nodes[32946646] = Rare({
    id=170634,
    quest=60884,
    rlabel=Shadowlands.status.LightBlue('+100 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49856}),
        Item({item=183066, quest=63160}), -- Korrath's Grimoire: Aleketh
        Item({item=183067, quest=63161}), -- Korrath's Grimoire: Belidir
        Item({item=183068, quest=63162}) -- Korrath's Grimoire: Gyadrek
    }
}) -- Shadeweaver Zeris

map.nodes[35974156] = Rare({
    id=166398,
    quest=60834,
    rlabel=Shadowlands.status.LightBlue('+80 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49857})
    }
}) -- Soulforger Rhovus

map.nodes[28701204] = Rare({
    id=170302,
    quest=60789, -- 62722?
    note=L["talaporas_note"],
    rlabel=Shadowlands.status.LightBlue('+100 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49858}),
        Transmog({item=184107, slot=L["cloak"]}), -- Borogove Cloak
        Item({item=182326}) -- Dominion Etching: Pain
    }
}) -- Talaporas, Herald of Pain

map.nodes[27397152] = Rare({
    id=170731,
    quest=60914,
    rlabel=Shadowlands.status.LightBlue('+100 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49859}),
    }
}) -- Thanassos <Death's Voice>

map.nodes[37446212] = Rare({
    id=172862,
    quest=61568,
    note=L["yero_note"],
    rlabel=Shadowlands.status.LightBlue('+80 '..L["rep"]),
    rewards={
        Achievement({id=14744, criteria=49860})
    },
    pois={
        Path({
            37976153, 38786073, 39155953, 38795855, 37925852, 37375934,
            37346068, 37446212
        })
    }
}) -- Yero the Skittish

-------------------------------------------------------------------------------
---------------------------- BONUS OBJECTIVE BOSSES ---------------------------
-------------------------------------------------------------------------------

local BonusBoss = Class('BonusBoss', NPC, {
    icon = 'peg_rd',
    scale = 1.8,
    group = Shadowlands.groups.BONUS_BOSS,
    rlabel = Shadowlands.status.LightBlue('+40 '..L["rep"])
})

map.nodes[28204450] = BonusBoss({
    id=169102,
    quest=61136, -- 63380
    rewards={
        Achievement({id=14660, criteria=49485})
    }
}) -- Agonix

map.nodes[34087453] = BonusBoss({
    id=170787,
    quest=60920,
    rewards={
        Achievement({id=14660, criteria=49487})
    }
}) -- Akros <Death's Hammer>

map.nodes[28712513] = BonusBoss({
    id=168693,
    quest=61346,
    rewards={
        Achievement({id=14660, criteria=49484}),
        Item({item=183070, quest=63164}) -- Mawsworn Orders
    }
}) -- Cyrixia <The Willbreaker>

map.nodes[25831479] = BonusBoss({
    id=162452,
    quest=59230,
    rewards={
        Achievement({id=14660, criteria=49476})
    }
}) -- Dartanos <Flayer of Souls>

map.nodes[19205740] = BonusBoss({
    id=162844,
    quest=61140,
    rewards={
        Achievement({id=14660, criteria=50410}),
        Item({item=183066, quest=63160}), -- Korrath's Grimoire: Aleketh
        Item({item=183067, quest=63161}), -- Korrath's Grimoire: Belidir
        Item({item=183068, quest=63162}) -- Korrath's Grimoire: Gyadrek
    }
}) -- Dath Rezara <Lord of Blades>

map.nodes[31982122] = BonusBoss({
    id=158314,
    quest=59183,
    note=L["drifting_sorrow_note"],
    rewards={
        Achievement({id=14660, criteria=49475})
    }
}) -- Drifting Sorrow

map.nodes[60456478] = BonusBoss({
    id=172523,
    quest=62209,
    rewards={
        Achievement({id=14660, criteria=49490})
    }
}) -- Houndmaster Vasanok

map.nodes[20782968] = BonusBoss({
    id=162965,
    quest=58918,
    rewards={
        Achievement({id=14660, criteria=49481})
    }
}) -- Huwerath

map.nodes[30846866] = BonusBoss({
    id=170692,
    quest=63381,
    rewards={
        Achievement({id=14660, criteria=49486})
    }
}) -- Krala <Death's Wings>

map.nodes[27311754] = BonusBoss({
    id=171316,
    quest=61125,
    rewards={
        Achievement({id=14660, criteria=49488})
    }
}) -- Malevolent Stygia

map.nodes[38642880] = BonusBoss({
    id=172207,
    quest=62618,
    rewards={
        Achievement({id=14660, criteria=50408}),
        Achievement({id=14761, criteria=49909}),
        Item({item=183061, quest=63158}) -- Wailing Coin
    }
}) -- Odalrik

map.nodes[25364875] = BonusBoss({
    id=162845,
    quest=60991,
    rewards={
        Achievement({id=14660, criteria=49480})
    }
}) -- Orrholyn <Lord of Bloodletting>

map.nodes[22674223] = BonusBoss({
    id=175821,
    quest=63044, -- 63388 ??
    note=L["in_cave"],
    rewards={
        Achievement({id=14660, criteria=51058})
    },
    pois={
        POI({20813927}) -- Cave entrance
    }
}) -- Ratgusher

map.nodes[26173744] = BonusBoss({
    id=162829,
    quest=60992,
    rewards={
        Achievement({id=14660, criteria=49479})
    }
}) -- Razkazzar <Lord of Axes>

map.nodes[55626318] = BonusBoss({
    id=172521,
    quest=62210,
    note=L["in_cave"]..' '..L["sanngror_note"],
    rewards={
        Achievement({id=14660, criteria=49489})
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
        Achievement({id=14660, criteria=49491})
    },
    pois={
        POI({59268001}) -- Cave entrance
    }
}) -- Skittering Broodmother

map.nodes[36253744] = BonusBoss({
    id=165047,
    quest=59441,
    rewards={
        Achievement({id=14660, criteria=49482})
    }
}) -- Soulsmith Yol-Mattar

map.nodes[36844480] = BonusBoss({
    id=156203,
    quest=62539,
    rewards={
        Achievement({id=14660, criteria=50409})
    }
}) -- Stygian Incinerator

map.nodes[40705959] = BonusBoss({
    id=173086,
    quest=61728,
    note=L["valis_note"],
    rewards={
        Achievement({id=14660, criteria=49492})
    }
}) -- Valis the Cruel

-------------------------------------------------------------------------------
---------------------------- BONUS OBJECTIVE EVENTS ---------------------------
-------------------------------------------------------------------------------

local BonusEvent = Class('BonusEvent', Shadowlands.node.Quest, {
    icon = 'peg_yw',
    scale = 1.8,
    group = Shadowlands.groups.BONUS_EVENT,
    note = ''
})

local SOUL_WELL = BonusEvent({ quest=59007, note=L["soul_well_note"] })

map.nodes[21573436] = SOUL_WELL
map.nodes[30394255] = SOUL_WELL
map.nodes[32401771] = SOUL_WELL
--map.nodes[27446463] = BonusEvent({ quest=59784, note=L["obliterated_soul_shards_note"] })

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
    fgroup='riftstone1',
    pois={Line({19184778, 25211784})}
})

map.nodes[25211784] = Riftstone({
    icon='portal_r',
    fgroup='riftstone1'
})

-------------------------------------------------------------------------------

map.nodes[23433121] = Riftstone({
    icon='portal_b',
    fgroup='riftstone2',
    pois={Line({23433121, 34804362})}
})

map.nodes[34804362] = Riftstone({
    icon='portal_b',
    fgroup='riftstone2'
})

-------------------------------------------------------------------------------

map.nodes[48284145] = NPC({
    group=Shadowlands.groups.RIFTSTONE,
    icon='portal_b',
    id=172925,
    minimap=false,
    note=L["animaflow_teleporter_note"],
    requires=Shadowlands.requirement.Venari(61600),
    scale=1.3,
    pois={
        Arrow({48284145, 34181473}), -- The Tremaculum
        Arrow({48284145, 53426364}) -- The Beastwarrens
    }
})

-------------------------------------------------------------------------------
---------------------------------- GRAPPLES -----------------------------------
-------------------------------------------------------------------------------

local GRAPPLES = {
    17574994, 20753838, 20764394, 21553194, 22014819, 22174389, 22475485,
    22534798, 22942220, 22956723, 23034411, 23076836, 23676572, 24542916,
    24833046, 24866552, 25456554, 25633108, 26116811, 26132722, 26306726,
    26342905, 26541861, 26952753, 27202506, 27362593, 27896168, 28161347,
    28634916, 29561776, 29661285, 29863694, 29951784, 30033617, 30132835,
    30582337, 30591312, 30756551, 30942597, 31221584, 31316530, 31351499,
    31655664, 32056840, 32194490, 32426772, 32674369, 32904238, 33102066,
    33286365, 33295928, 33374532, 33584024, 33767056, 34074701, 34237005,
    34463889, 34624440, 35006680, 36244139, 36264642, 37844512, 40334904,
    41184945, 41304785, 42264174
}

for _, coord in ipairs(GRAPPLES) do
    map.nodes[coord] = NPC({
        group=Shadowlands.groups.GRAPPLES,
        icon='peg_bk',
        id=176308,
        requires=Shadowlands.requirement.Venari(63217),
        scale=1.25,
    })
end

-------------------------------------------------------------------------------
---------------------------------- MAW LORE -----------------------------------
-------------------------------------------------------------------------------

local Lore = Class('MawLore', Treasure, {
    group=Shadowlands.groups.MAW_LORE,
    rlabel=Shadowlands.status.LightBlue('+150 '..L["rep"]),
    IsCompleted=function(self)
        if C_QuestLog.IsOnQuest(self.quest[1]) then return true end
        return Treasure.IsCompleted(self)
    end
})

Map({id=1822}).nodes[73121659] = Lore({
    quest=63157,
    note=L["box_of_torments_note"],
    parent={ id=map.id, pois={POI({27702020})} },
    rewards={
        Achievement({id=14761, criteria=49908}),
        Item({item=183060, quest=63157})
    }
}) -- Box of Torments

-- Shadehound Armor Plating ??

map.nodes[35764553] = Lore({
    quest=63163,
    note=L["tormentors_notes_note"],
    rewards={
        Achievement({id=14761, criteria=49914}),
        Item({item=183069, quest=63163})
    }
}) -- Tormentor's Notes

map.nodes[19363340] = Lore({
    quest=63159,
    note=L["words_of_warden_note"],
    rewards={
        Achievement({id=14761, criteria=49910}),
        Item({item=183063, quest=63159})
    }
}) -- Words of the Warden

-------------------------------------------------------------------------------
------------------------------- STYGIAN CACHES --------------------------------
-------------------------------------------------------------------------------

local Cache = Class('Cache', Shadowlands.node.Node, {
    group=Shadowlands.groups.STYGIAN_CACHES,
    icon='chest_nv',
    label=L["stygian_cache"],
    note=L["stygian_cache_note"],
    scale=1.3,
    rewards={
        Shadowlands.reward.Currency({id=1767, note='48'})
    }
})

map.nodes[15705040] = Cache()
map.nodes[19604460] = Cache()
map.nodes[19805500] = Cache()
map.nodes[24301660] = Cache()
map.nodes[28402560] = Cache()
map.nodes[29621283] = Cache()
map.nodes[35201630] = Cache()
map.nodes[35902360] = Cache()
map.nodes[39802510] = Cache()
map.nodes[44201870] = Cache()
map.nodes[45204740] = Cache()

-------------------------------------------------------------------------------
----------------------------------- VE'NARI -----------------------------------
-------------------------------------------------------------------------------

map.nodes[46914169] = NPC({
    id=162804,
    icon=3527519,
    note=L["venari_note"],
    rewards={
        Achievement({id=14895, oneline=true}), -- 'Ghast Five
        Section(C_Map.GetMapInfo(1543).name),
        Shadowlands.reward.Spacer(),
        Item({item=184613, quest=63177, note=L["Apprehensive"]}), -- Encased Riftwalker Essence
        Item({item=184653, quest=63217, note=L["Tentative"]}), -- Animated Levitating Chain
        Item({item=180949, quest=61600, note=L["Tentative"]}), -- Animaflow Stabilizer
        Item({item=184605, quest=63092, note=L["Tentative"]}), -- Sigil of the Unseen
        Item({item=184588, quest=63091, note=L["Ambivalent"]}), -- Soul-Stabilizing Talisman
        Shadowlands.reward.Spacer(),
        Section(L["torghast"]),
        Shadowlands.reward.Spacer(),
        Item({item=184620, quest=63202, note=L["Apprehensive"]}), -- Vessel of Unforunate Spirits
        Item({item=184615, quest=63183, note=L["Apprehensive"]}), -- Extradimensional Pockets
        Item({item=184617, quest=63193, note=L["Tentative"]}), -- Bangle of Seniority
        Item({item=184621, quest=63204, note=L["Ambivalent"]}), -- Ritual Prism of Fortune
        Item({item=184618, quest=63200, note=L["Cordial"]}), -- Rank Insignia: Acquisitionist
        Item({item=184619, quest=63201, note=L["Cordial"]}), -- Loupe of Unusual Charm
        Item({item=180952, quest=nil, note=L["Appreciative"]}), -- Possibility Matrix
    }
})
