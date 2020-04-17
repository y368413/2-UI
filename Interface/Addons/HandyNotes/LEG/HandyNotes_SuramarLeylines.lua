local SuramarLeylines = {}

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HL = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_SuramarLeylines", "AceEvent-3.0")
-- local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes", true)
SuramarLeylines_HL = HL

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
local default_texture = work_out_texture("worldquest-questmarker-abilityhighlight")
local entrance_texture = work_out_texture("map-icon-SuramarDoor.tga")
entrance_texture.r = 0
entrance_texture.g = 0
entrance_texture.b = 1

local get_point_info = function(point)
    if point then
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
        return label, point.entrance and entrance_texture or default_texture
    end
end
local get_point_info_by_coord = function(uiMapId, coord)
    return get_point_info(SuramarLeylines_points[uiMapId] and SuramarLeylines_points[uiMapId][coord])
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
    return handle_tooltip(tooltip, SuramarLeylines_points[uiMapId] and SuramarLeylines_points[uiMapId][coord])
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
    SuramarLeylines_hidden[uiMapId][coord] = true
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
            info.text         = "SuramarLeylines"
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
    local HL_Dropdown = CreateFrame("Frame", "HandyNotes_SuramarLeylinesDropdownMenu")
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
            if value and SuramarLeylines:ShouldShow(value) then
                local label, icon = get_point_info(value)
                return state, nil, icon, SuramarLeylines_db.icon_scale, SuramarLeylines_db.icon_alpha
            end
            state, value = next(t, state) -- Get next data
        end
        return nil, nil, nil, nil
    end
    function HLHandler:GetNodes2(uiMapId, minimap)
        currentLevel = level
        currentZone = uiMapId
        return iter, SuramarLeylines_points[uiMapId], nil
    end
    function SuramarLeylines:ShouldShow(point)
        if point.entrance and not SuramarLeylines_db.entrances then
            return false
        end
        if point.level and point.level ~= currentLevel then
            return false
        end
        if SuramarLeylines_db.complete then
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
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_SuramarLeylinesDB", SuramarLeylines_defaults)
    SuramarLeylines_db = self.db.profile
    SuramarLeylines_hidden = self.db.char.hidden
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB("HandyNotes_SuramarLeylines", HLHandler, SuramarLeylines_options)

    -- watch for LOOT_CLOSED
    self:RegisterEvent("LOOT_CLOSED")
end

function HL:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_SuramarLeylines")
end

function HL:LOOT_CLOSED()
    self:Refresh()
end


SuramarLeylines_defaults = {
    profile = {
        icon_scale = 1.5,
        icon_alpha = 1.0,
        complete = false,
    },
}

SuramarLeylines_options = {
    type = "group",
    name = "SuramarLeylines",
    get = function(info) return SuramarLeylines_db[info[#info]] end,
    set = function(info, v)
        SuramarLeylines_db[info[#info]] = v
        SuramarLeylines_HL:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_SuramarLeylines")
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
            },
        },
    },
}

SuramarLeylines_points = {
    [680] = { -- Suramar
        [41703890] = { achievement=10756, criteria=31056, }, -- Anora Hollow (the prerequisite!)
        [29008480] = { achievement=10756, criteria=31918, }, -- Soul Vaults
        [59304280] = { achievement=10756, criteria=31914, }, -- Kel'balor
        [65804190] = { achievement=10756, criteria=31913, }, -- Elor'shan
        [20405040] = { achievement=10756, criteria=31917, }, -- Falanaar South
        [21404330] = { achievement=10756, criteria=31916, }, -- Falanaar North
        [24301940] = { achievement=10756, criteria=31919, }, -- Moon Guard
        [35702410] = { achievement=10756, criteria=31915, }, -- Moonwhisper Gulch
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
