local SuramarTelemancyandLeylines = {}

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HL = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_SuramarTelemancyandLeylines", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes")
SuramarTelemancyandLeylines_HL = HL

local next = next
local GameTooltip = GameTooltip
local HandyNotes = HandyNotes

local function work_out_texture(atlas)
    local texture, _, _, left, right, top, bottom = GetAtlasInfo(atlas)
    return {
        icon = texture,
        tCoordLeft = left,
        tCoordRight = right,
        tCoordTop = top,
        tCoordBottom = bottom,
    }
end

local enabled_texture = work_out_texture("MagePortalAlliance")
local disabled_texture = work_out_texture("MagePortalHorde")
local enabled_entrance_texture = work_out_texture("map-icon-SuramarDoor.tga")
enabled_entrance_texture.r = 0
enabled_entrance_texture.g = 0
enabled_entrance_texture.b = 1
local disabled_entrance_texture = work_out_texture("map-icon-SuramarDoor.tga")
disabled_entrance_texture.r = 1
disabled_entrance_texture.g = 0
disabled_entrance_texture.b = 0

local get_point_info = function(point)
    if point then
        local texture
        if C_QuestLog.IsQuestFlaggedCompleted(point.quest) then
            texture = point.entrance and enabled_entrance_texture or enabled_texture
        else
            texture = point.entrance and disabled_entrance_texture or disabled_texture
        end
        local label
        if point.label then
            label = point.label
        elseif point.achievement then
            if point.criteria then
                label = GetAchievementCriteriaInfoByID(point.achievement, point.criteria)
            else
                label = select(2, GetAchievementInfo(point.achievement))
            end
        else
            label = UNKNOWN
        end
        return label, texture
    end
end
local get_point_info_by_coord = function(uiMapId, coord)
    return get_point_info(SuramarTelemancyandLeylines_points[uiMapId] and SuramarTelemancyandLeylines_points[uiMapId][coord])
end

local function handle_tooltip(tooltip, point)
    if point then
        if point.label then
            tooltip:AddLine(point.label)
        end
        if point.achievement then
            if point.criteria then
                local criteria, _, complete = GetAchievementCriteriaInfoByID(point.achievement, point.criteria)
                tooltip:AddLine(criteria,
                    complete and 0 or 1, complete and 1 or 0, 0
                )
                local _, name, _, complete = GetAchievementInfo(point.achievement)
                tooltip:AddLine(name)
            else
                local _, name, _, complete = GetAchievementInfo(point.achievement)
                tooltip:AddDoubleLine(BATTLE_PET_SOURCE_6, name or point.achievement,
                    nil, nil, nil,
                    complete and 0 or 1, complete and 1 or 0, 0
                )
            end
        end
        if point.quest then
            if IsQuestFlaggedCompleted(point.quest) then
                tooltip:AddLine(ACTIVE_PETS, 0, 1, 0) -- Active
            else
                tooltip:AddLine(FACTION_INACTIVE, 1, 0, 0) -- Inactive
            end
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end
local handle_tooltip_by_coord = function(tooltip, uiMapId, coord)
    return handle_tooltip(tooltip, SuramarTelemancyandLeylines_points[uiMapId] and SuramarTelemancyandLeylines_points[uiMapId][coord])
end

---------------------------------------------------------
-- Plugin Handlers to HandyNotes
local HLHandler = {}
local info = {}

function HLHandler:OnEnter(uiMapId, coord)
    local tooltip = GameTooltip
    if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    handle_tooltip_by_coord(tooltip, uiMapId, coord)
end

local function createWaypoint(button, uiMapId, coord)
    if TomTom then
        local x, y = HandyNotes:getXY(coord)
        TomTom:AddWaypoint(uiMapId, x, y, {
            title = get_point_info_by_coord(uiMapId, coord),
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

local function hideNode(button, uiMapId, coord)
    SuramarTelemancyandLeylines_hidden[uiMapId][coord] = true
    HL:Refresh()
end

local function closeAllDropdowns()
    CloseDropDownMenus(1)
end

do
    local currentZone, currentCoord
    local function generateMenu(button, level)
        if (not level) then return end
        wipe(info)
        if (level == 1) then
            -- Create the title of the menu
            info.isTitle      = 1
            info.text         = "SuramarTelemancyandLeylines"
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)
            wipe(info)

            if TomTom then
                -- Waypoint menu item
                info.text = "Create waypoint"
                info.notCheckable = 1
                info.func = createWaypoint
                info.arg1 = currentZone
                info.arg2 = currentCoord
                UIDropDownMenu_AddButton(info, level)
                wipe(info)
            end

            -- Close menu item
            info.text         = "Close"
            info.func         = closeAllDropdowns
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)
            wipe(info)
        end
    end
    local HL_Dropdown = CreateFrame("Frame", "HandyNotes_SuramarTelemancyandLeylinesDropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function HLHandler:OnClick(button, down, uiMapId, coord)
        if button == "RightButton" and not down then
            currentZone = uiMapId
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        end
    end
end

function HLHandler:OnLeave(uiMapId, coord)
    GameTooltip:Hide()
end

do
    -- This is a custom iterator we use to iterate over every node in a given zone
    local currentLevel, currentZone
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do -- Have we reached the end of this zone?
            if value and SuramarTelemancyandLeylines:ShouldShow(value) then
                local label, icon = get_point_info(value)
                return state, nil, icon, SuramarTelemancyandLeylines_db.icon_scale, SuramarTelemancyandLeylines_db.icon_alpha
            end
            state, value = next(t, state) -- Get next data
        end
        return nil, nil, nil, nil
    end
    function HLHandler:GetNodes2(uiMapId, minimap)
        currentLevel = level
        currentZone = uiMapId
        return iter, SuramarTelemancyandLeylines_points[uiMapId], nil
    end
    function SuramarTelemancyandLeylines:ShouldShow(point)
        if point.entrance and not SuramarTelemancyandLeylines_db.entrances then
            return false
        end
        if point.level and point.level ~= currentLevel then
            return false
        end

        if point.hide_after and IsQuestFlaggedCompleted(point.hide_after) then
            return false
        end
        if point.hide_before and not SuramarTelemancyandLeylines_db.upcoming and not IsQuestFlaggedCompleted(point.hide_before) then
            return false
        end
        if SuramarTelemancyandLeylines_db.complete then
            return true
        end
        if point.achievement then
            if point.criteria then
                return not select(3, GetAchievementCriteriaInfoByID(point.achievement, point.criteria))
            else
                return not select(4, GetAchievementInfo(point.achievement))
            end
        end
        if not point.quest then
            return true
        end
        return not IsQuestFlaggedCompleted(point.quest)
    end
end

---------------------------------------------------------
-- Addon initialization, enabling and disabling

function HL:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_SuramarTelemancyandLeylinesDB", SuramarTelemancyandLeylines_defaults)
    SuramarTelemancyandLeylines_db = self.db.profile
    SuramarTelemancyandLeylines_hidden = self.db.char.hidden
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB("HandyNotes_SuramarTelemancyandLeylines", HLHandler, SuramarTelemancyandLeylines_options)

    -- watch for LOOT_CLOSED
    self:RegisterEvent("LOOT_CLOSED")
end

function HL:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_SuramarTelemancyandLeylines")
end

function HL:LOOT_CLOSED()
    self:Refresh()
end


SuramarTelemancyandLeylines_defaults = {
    profile = {
        icon_scale = 1.5,
        icon_alpha = 1.0,
        entrances = true,
        upcoming = false,
	complete = false,
    },
}

SuramarTelemancyandLeylines_options = {
    type = "group",
    name = "SuramarTelemancyandLeylines",
    get = function(info) return SuramarTelemancyandLeylines_db[info[#info]] end,
    set = function(info, v)
        SuramarTelemancyandLeylines_db[info[#info]] = v
        SuramarTelemancyandLeylines_HL:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_SuramarTelemancyandLeylines")
    end,
    args = {
        icon = {
            type = "group",
            name = "Icon settings",
            inline = true,
            args = {
                desc = {
                    name = "These settings control the look and feel of the icon.",
                    type = "description",
                    order = 0,
                },
                icon_scale = {
                    type = "range",
                    name = "Icon Scale",
                    desc = "The scale of the icons",
                    min = 0.25, max = 2, step = 0.01,
                    order = 20,
                },
                icon_alpha = {
                    type = "range",
                    name = "Icon Alpha",
                    desc = "The alpha transparency of the icons",
                    min = 0, max = 1, step = 0.01,
                    order = 30,
                },
            },
        },
        display = {
            type = "group",
            name = "What to display",
            inline = true,
            args = {
                complete = {
                    type = "toggle",
                    name = "Show complete",
                    desc = "Show icons for the leyline taps already activated",
                    order = 0,
                },
		entrances = {
                    type = "toggle",
                    name = "Show entrances",
                    desc = "Show icons for the entrances to the portal areas, as well as just the portal locations",
                    order = 0,
                },
                upcoming = {
                    type = "toggle",
                    name = "Show upcoming portals",
                    desc = "Show the upcoming portals, which can't yet be activated because you're not on the right quest step",
                    order = 10,
                },
            },
        },
    },
}


SuramarTelemancyandLeylines_points = {
    [680] = { -- Suramar
        [36204710] = { quest=40956, label=L["Ruins of Elune'eth"], hide_before=40956, }, -- Ruins of Elune'eth, storyline: Survey Says...
        [22903580] = { quest=42230, label=L["Falanaar"], hide_before=42228, }, -- Falanaar, storyline: Valewalker's Burden, hidden until Hidden City
        [47508200] = { quest=42487, label=L["Waning Crescent"], hide_after=43569, hide_before=42486, }, --Waning Crescent, storyline: Friends on the Outside, hidden until Little One Lost, hidden after Arluin's Request
        [64006040] = { quest=44084, label=L["Twilight Vineyards"], hide_before=42838, }, -- Twilight Vineyards, storyline: Vengeance for Margaux, hidden until Reversal
        [52007800] = { quest=42889, label=L["Evermoon Terrace"], hide_before=43569, }, -- Evermoon Terrace, storyline: The Way Back Home, hidden until 38694
        [54496943] = { quest=44740, label=L["Astravar Harbor"], hide_before=44738, }, -- Astravar Harbor, storyline: Staging Point, hidden until Full Might of the Elves
        -- These ones are general-access after Ruins is opened:
        [30801090] = { quest=43808, label=L["Moon Guard Stronghold"], hide_before=40956, }, -- Moon Guard Stronghold
        [42203540] = { quest=43809, label=L["Tel'anor"], hide_before=40956, }, -- Tel'anor
        [43406070] = { quest=43813, label=L["Sanctum of Order"], hide_before=40956, }, -- Sanctum of Order
        [43607910] = { quest=43811, label=L["Lunastre Estate"], hide_before=40956, }, -- Lunastre Estate
        [35808210] = { quest=41575, label=L["Felsoul Hold"], hide_before=40956, }, -- Felsoul Hold
        -- entrances
        [27802230] = { quest=43808, entrance=true, label=L["Moon Guard (entrance)"], hide_before=40956, }, -- Moon Guard (entrance)
        [42606170] = { quest=43813, entrance=true, label=L["Sanctum of Order (entrance)"], hide_before=40956, }, -- Sanctum of Order (entrance)
--Leylines
        [41703890] = { achievement=10756, criteria=31056, }, -- Anora Hollow (the prerequisite!)
        [29008480] = { achievement=10756, criteria=31918, }, -- Soul Vaults
        [59304280] = { achievement=10756, criteria=31914, }, -- Kel'balor
        [65804190] = { achievement=10756, criteria=31913, }, -- Elor'shan
        [20405040] = { achievement=10756, criteria=31917, }, -- Falanaar South
        [21404330] = { achievement=10756, criteria=31916, }, -- Falanaar North
        [24301940] = { achievement=10756, criteria=31919, }, -- Moon Guard
        [35702410] = { achievement=10756, criteria=31915, }, -- Moonwhisper Gulch
    },
    [684] = { -- Fal'adore
        [40901350] = { quest=42230, label=L["Falanaar"], hide_before=42228 }, -- Falanaar
    },
    [682] = { -- The Fel Breach
        [53403680] = { quest=41575, label=L["Felsoul Hold"], hide_before=40956 }, -- Felsoul Hold
    },
    [685] = { -- Falanaar Tunnels
        [65105210] = { achievement=10756, criteria=31916, }, -- Falanaar North
        [58107520] = { achievement=10756, criteria=31917, }, -- Falanaar South
    },
    [686] = { -- Elor'shan
        [46704720] = { achievement=10756, criteria=31913, },
    },
    [687] = { -- Kel'balor
        [52304490] = { achievement=10756, criteria=31914, },
    },
    [689] = { -- Ley Station Moonfall, Moonwhisper Gulch
        [54004470] = { achievement=10756, criteria=31915, },
    },
    [690] = { -- Ley Station Aethenar, Moon Guard
        [48704870] = { achievement=10756, criteria=31919, },
    },
}
