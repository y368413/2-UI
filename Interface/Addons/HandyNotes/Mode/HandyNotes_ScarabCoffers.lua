local ScarabCoffers = {}

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HL = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_ScarabCoffers", "AceEvent-3.0")
-- local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_ScarabCoffers", true)
ScarabCoffers_HL = HL

local next = next
local GameTooltip = GameTooltip
local HandyNotes = HandyNotes
local DEFAULT_LABEL = "Scarab Coffer"

local icon_cache = {}
local function poi_texture(poi)
    if not icon_cache[poi] then
        local left, right, top, bottom = GetPOITextureCoords(poi)
        icon_cache[poi] = {
            icon = [[Interface\Minimap\POIIcons]],
            tCoordLeft = left,
            tCoordRight = right,
            tCoordTop = top,
            tCoordBottom = bottom,
            r = 1, g = 1, b = 1,
        }
    end
    return icon_cache[poi]
end
local function atlas_texture(atlas, scale)
    if not icon_cache[atlas] then
        local texture, _, _, left, right, top, bottom = GetAtlasInfo(atlas)
        icon_cache[atlas] = {
            icon = texture,
            tCoordLeft = left,
            tCoordRight = right,
            tCoordTop = top,
            tCoordBottom = bottom,
            scale = scale or 1,
            r = 1, g = 1, b = 1,
        }
    end
    return icon_cache[atlas]
end

local function work_out_texture(point)
    if point.atlas then
        return atlas_texture(point.atlas)
    end
    if point.poi then
        return poi_texture(point.poi)
    end
    if point.npc then
        return atlas_texture("DungeonSkull", 1.5)
    end
    return atlas_texture("mythicplus-chest-silver")
end

local get_point_info = function(point)
    if point then
        return point.label or DEFAULT_LABEL, work_out_texture(point), point.scale
    end
end
local get_point_info_by_coord = function(uiMapID, coord)
    return get_point_info(ScarabCoffers_points[uiMapID] and ScarabCoffers_points[uiMapID][coord])
end

local function handle_tooltip(tooltip, point)
    if point then
        tooltip:AddLine(point.label or DEFAULT_LABEL)
        if point.quest and not C_QuestLog.IsQuestFlaggedCompleted(point.quest) then
            tooltip:AddLine(NEED, 1, 0, 0)
        end
        if point.note then
            tooltip:AddLine(point.note, nil, nil, nil, true)
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end
local handle_tooltip_by_coord = function(tooltip, uiMapID, coord)
    return handle_tooltip(tooltip, ScarabCoffers_points[uiMapID] and ScarabCoffers_points[uiMapID][coord])
end

---------------------------------------------------------
-- Plugin Handlers to HandyNotes
local HLHandler = {}
local info = {}

function HLHandler:OnEnter(uiMapID, coord)
    local tooltip = GameTooltip
    if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    handle_tooltip_by_coord(tooltip, uiMapID, coord)
end

local function createWaypoint(button, uiMapID, coord)
    if TomTom then
        local x, y = HandyNotes:getXY(coord)
        TomTom:AddWaypoint(uiMapID, x, y, {
            title = get_point_info_by_coord(uiMapID, coord),
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

local function hideNode(button, uiMapID, coord)
    ScarabCoffers_hidden[uiMapID][coord] = true
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
            info.text         = "HandyNotes - ScarabCoffers"
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

            -- Hide menu item
            info.text         = "Hide node"
            info.notCheckable = 1
            info.func         = hideNode
            info.arg1         = currentZone
            info.arg2         = currentCoord
            UIDropDownMenu_AddButton(info, level)
            wipe(info)

            -- Close menu item
            info.text         = "Close"
            info.func         = closeAllDropdowns
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)
            wipe(info)
        end
    end
    local HL_Dropdown = CreateFrame("Frame", "HandyNotes_ScarabCoffersDropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function HLHandler:OnClick(button, down, uiMapID, coord)
        if button == "RightButton" and not down then
            currentZone = uiMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        end
    end
end

function HLHandler:OnLeave(uiMapID, coord)
    GameTooltip:Hide()
end

do
    local currentZone
    -- This is a custom iterator we use to iterate over every node in a given zone
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do -- Have we reached the end of this zone?
            if value and not ScarabCoffers_hidden[currentZone][state] then
                local label, icon, scale = get_point_info(value)
                scale = (scale or 1) * (icon and icon.scale or 1) * ScarabCoffers_db.icon_scale
                return state, nil, icon, scale, ScarabCoffers_db.icon_alpha
            end
            state, value = next(t, state) -- Get next data
        end
        return nil, nil, nil, nil
    end
    function HLHandler:GetNodes2(uiMapID, minimap)
        currentZone = uiMapID
        return iter, ScarabCoffers_points[uiMapID], nil
    end
end

---------------------------------------------------------
-- Addon initialization, enabling and disabling

function HL:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_ScarabCoffersDB", ScarabCoffers_defaults)
    ScarabCoffers_db = self.db.profile
    ScarabCoffers_hidden = self.db.char.hidden
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB("HandyNotes_ScarabCoffers", HLHandler, ScarabCoffers_options)

    -- watch for LOOT_CLOSED
    self:RegisterEvent("LOOT_CLOSED")
end

function HL:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_ScarabCoffers")
end

function HL:LOOT_CLOSED()
    self:Refresh()
end


ScarabCoffers_defaults = {
    profile = {
        -- found = false,
        icon_scale = 1.5,
        icon_alpha = 1.0,
        icon_item = true,
    },
    char = {
        hidden = {
            ['*'] = {},
        },
    },
}

ScarabCoffers_options = {
    type = "group",
    name = "ScarabCoffers",
    get = function(info) return ScarabCoffers_db[info[#info]] end,
    set = function(info, v)
        ScarabCoffers_db[info[#info]] = v
        ScarabCoffers_HL:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_ScarabCoffers")
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
                    min = 0.50, max = 3, step = 0.1,
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
                -- found = {
                --     type = "toggle",
                --     name = "Show found",
                --     desc = "Show waypoints for items you've already found?",
                --     order = 20,
                -- },
                unhide = {
                    type = "execute",
                    name = "Reset hidden nodes",
                    desc = "Show all nodes that you manually hid by right-clicking on them and choosing \"hide\".",
                    func = function()
                        for map,coords in pairs(ScarabCoffers_hidden) do
                            wipe(coords)
                        end
                        ScarabCoffers_HL:Refresh()
                    end,
                    order = 50,
                },
            },
        },
    },
}

local player_faction = UnitFactionGroup("player")
ScarabCoffers_should_show_point = function(coord, point, currentZone, currentLevel)
    if point.level and point.level ~= currentLevel then
        return false
    end
    if ScarabCoffers_hidden[currentZone] and ScarabCoffers_hidden[currentZone][coord] then
        return false
    end
    if point.junk and not ScarabCoffers_db.show_junk then
        return false
    end
    if point.faction and point.faction ~= player_faction then
        return false
    end
    if (not ScarabCoffers_db.found) then
        if point.quest and C_QuestLog.IsQuestFlaggedCompleted(point.quest) then
            return false
        end
        if point.achievement then
            local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuildAch, wasEarnedByMe, earnedBy = GetAchievementInfo(point.achievement)
            if completed then
                return false
            end
            if point.criteria then
                local description, type, completed, quantity, requiredQuantity, characterName, flags, assetID, quantityString, criteriaID = GetAchievementCriteriaInfoByID(point.achievement, point.criteria)
                if completed then
                    return false
                end
            end
        end
        if point.follower and C_Garrison.IsFollowerCollected(point.follower) then
            return false
        end
        -- This is actually super-targeted at Basten, who is repeatable daily and drops a toy
        -- Might want to generalize at some point...
        if point.toy and point.item and point.repeatable and select(4, C_ToyBox.GetToyInfo(point.item)) then
            return false
        end
    end
    if (not ScarabCoffers_db.repeatable) and point.repeatable then
        return false
    end
    if point.npc and not point.follower and not ScarabCoffers_db.show_npcs then
        return false
    end
    return true
end

ScarabCoffers_points = {
    --[[ structure:
    [mapFile] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            label=[string], -- label: text that'll be the label, optional
            item=[id], -- itemid
            quest=[id], -- will be checked, for whether character already has it
            achievement=[id], -- will be shown in the tooltip
            junk=[bool], -- doesn't count for achievement
            npc=[id], -- related npc id, used to display names in tooltip
            note=[string], -- some text which might be helpful
        },
    },
    --]]
    [319] = { --AQ40
        [33904890] = {}, --Silithid Royalty
        [64202600] = {}, --Fankriss
        [58305000] = {}, --Princess Huhuran
        [47505510] = {}, --Princess Huhuran 2
        [56206570] = {}, --Twin Emperors
        [50607810] = {}, --Twin Emperors 2
        [51408340] = {}, --Twin Emperors 3
        [48108500] = {}, --Twin Emperors 4
        [47908120] = {}, --Twin Emperors 5
        [34208350] = {}, --Ouro
        [39106870] = {}, --Ouro 2
    },
    [247] = { --AQ20
        [59102840] = {}, --Kurinaxx
        [61205150] = {}, --General Rajaxx
        [72906610] = {}, --Buru the Gorger
        [57207890] = {}, --Ayamiss the Hunter
        [54908720] = {}, --Ayamiss the Hunter 2
        [34105330] = {}, --Moam
        [41604630] = {}, --Moam 2
        [41003250] = {}, --Moam 3
        [41007710] = {}, --Ossirian the Unscarred
    },
}
