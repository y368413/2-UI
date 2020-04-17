local HandyNotes_HigherDimensionalLearning = {}

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HL = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_HigherDimensionalLearning", "AceEvent-3.0")
-- local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_HigherDimensionalLearning", true)
local next = next
local GameTooltip = GameTooltip
local HandyNotes = HandyNotes
local GetItemInfo = GetItemInfo
local GetAchievementInfo = GetAchievementInfo
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetCurrencyInfo = GetCurrencyInfo

local ARTIFACT_LABEL = '|cffff8000' .. ARTIFACT_POWER .. '|r'

local cache_tooltip = CreateFrame("GameTooltip", "HandyNotes_HigherDimensionalLearningCacheTooltip")
cache_tooltip:AddFontStrings(
    cache_tooltip:CreateFontString("$parentTextLeft1", nil, "GameTooltipText"),
    cache_tooltip:CreateFontString("$parentTextRight1", nil, "GameTooltipText")
)
local name_cache = {}
local function mob_name(id)
    if not name_cache[id] then
        -- this doesn't work with just clearlines and the setowner outside of this, and I'm not sure why
        cache_tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
        cache_tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(id))
        if cache_tooltip:IsShown() then
            name_cache[id] = _G["HandyNotes_HigherDimensionalLearningCacheTooltipTextLeft1"]:GetText()
        end
    end
    return name_cache[id]
end

local default_texture, npc_texture, follower_texture
local icon_cache = {}
local trimmed_icon = function(texture)
    if not icon_cache[texture] then
        icon_cache[texture] = {
            icon = texture,
            tCoordLeft = 0.1,
            tCoordRight = 0.9,
            tCoordTop = 0.1,
            tCoordBottom = 0.9,
        }
    end
    return icon_cache[texture]
end
local function work_out_label(point)
    local fallback
    if point.label then
        return point.label
    end
    if point.item then
        local _, link, _, _, _, _, _, _, _, texture = GetItemInfo(point.item)
        if link then
            return link
        end
        fallback = 'item:'..point.item
    end
    if point.npc then
        local name = mob_name(point.npc)
        if name then
            return name
        end
        fallback = 'npc:'..point.npc
    end
    if point.currency then
        if point.currency == 'ARTIFACT' then
            return ARTIFACT_LABEL
        end
        local name, _, texture = GetCurrencyInfo(point.currency)
        if name then
            return name
        end
    end
    return UNKNOWN
end
local function work_out_texture(point)
    if point.atlas then
        if not icon_cache[point.atlas] then
            local texture, _, _, left, right, top, bottom = GetAtlasInfo(point.atlas)
            icon_cache[point.atlas] = {
                icon = texture,
                tCoordLeft = left,
                tCoordRight = right,
                tCoordTop = top,
                tCoordBottom = bottom,
            }
        end
        return icon_cache[point.atlas]
    end
    if point.item and HandyNotes_HigherDimensionalLearning.db.icon_item then
        local texture = select(10, GetItemInfo(point.item))
        if texture then
            return trimmed_icon(texture)
        end
    end
    if point.currency then
        if point.currency == 'ARTIFACT' then
            local texture = select(10, GetAchievementInfo(11144))
            if texture then
                return trimmed_icon(texture)
            end
        else
            local texture = select(3, GetCurrencyInfo(point.currency))
            if texture then
                return trimmed_icon(texture)
            end
        end
    end
    if point.achievement then
        local texture = select(10, GetAchievementInfo(point.achievement))
        if texture then
            return trimmed_icon(texture)
        end
    end
    if point.follower then
        if not follower_texture then
            local texture, _, _, left, right, top, bottom = GetAtlasInfo("GreenCross")
            follower_texture = {
                icon = texture,
                tCoordLeft = left,
                tCoordRight = right,
                tCoordTop = top,
                tCoordBottom = bottom,
            }
        end
        return follower_texture
    end
    if point.npc then
        if not npc_texture then
            local texture, _, _, left, right, top, bottom = GetAtlasInfo("DungeonSkull")
            npc_texture = {
                icon = texture,
                tCoordLeft = left,
                tCoordRight = right,
                tCoordTop = top,
                tCoordBottom = bottom,
            }
        end
        return npc_texture
    end
    if not default_texture then
        local texture, _, _, left, right, top, bottom = GetAtlasInfo("minortalents-icon-book")
        default_texture = {
            icon = texture,
            tCoordLeft = left,
            tCoordRight = right,
            tCoordTop = top,
            tCoordBottom = bottom,
        }
    end
    return default_texture
end
local get_point_info = function(point)
    if point then
        local label = work_out_label(point)
        local icon = work_out_texture(point)
        local category = "treasure"
        if point.npc then
            category = "npc"
        elseif point.junk then
            category = "junk"
        end
        return label, icon, category, point.quest, point.faction
    end
end
local get_point_info_by_coord = function(mapFile, coord)
    mapFile = string.gsub(mapFile, "_terrain%d+$", "")
    return get_point_info(HandyNotes_HigherDimensionalLearning.points[mapFile] and HandyNotes_HigherDimensionalLearning.points[mapFile][coord])
end

local get_local_day
do
    local daymap = {
        [0] = "SUNDAY",
        [1] = "MONDAY",
        [2] = "TUESDAY",
        [3] = "WEDNESDAY",
        [4] = "THURSDAY",
        [5] = "FRIDAY",
        [6] = "SATURDAY",
    }
    get_local_day = function(day)
        return _G["WEEKDAY_" .. daymap[day]]
    end
end

local function handle_tooltip(tooltip, point)
    if point then
        -- major:
        if point.label then
            tooltip:AddLine(point.label)
        elseif point.item then
            if HandyNotes_HigherDimensionalLearning.db.tooltip_item or IsLeftShiftKeyDown() then
                tooltip:SetHyperlink(("item:%d"):format(point.item))
            else
                local link = select(2, GetItemInfo(point.item))
                tooltip:AddLine(link)
            end
        elseif point.follower then
            local follower = C_Garrison.GetFollowerInfo(point.follower)
            if follower then
                local quality = BAG_ITEM_QUALITY_COLORS[follower.quality]
                tooltip:AddLine(follower.name, quality.r, quality.g, quality.b)
                tooltip:AddDoubleLine(follower.className, UNIT_LEVEL_TEMPLATE:format(follower.level))
                tooltip:AddLine(REWARD_FOLLOWER, 0, 1, 0)
            else
                tooltip:AddLine(UNKNOWN, 1, 0, 0)
            end
        elseif point.npc then
            tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(point.npc))
        end

        if point.item and point.npc then
            tooltip:AddDoubleLine(CREATURE, mob_name(point.npc) or point.npc)
        end
        if point.currency then
            local name
            if point.currency == 'ARTIFACT' then
                name = ARTIFACT_LABEL
            else
                name = GetCurrencyInfo(point.currency)
            end
            tooltip:AddDoubleLine(CURRENCY, name or point.currency)
        end
        if point.achievement then
            local _, name, _, complete = GetAchievementInfo(point.achievement)
            tooltip:AddDoubleLine(BATTLE_PET_SOURCE_6, name or point.achievement,
                nil, nil, nil,
                complete and 0 or 1, complete and 1 or 0, 0
            )
            if point.criteria then
                local criteria, _, complete = GetAchievementCriteriaInfoByID(point.achievement, point.criteria)
                tooltip:AddDoubleLine(" ", criteria,
                    nil, nil, nil,
                    complete and 0 or 1, complete and 1 or 0, 0
                )
            end
        end
        if point.day then
            local today = tonumber(date('%w')) == point.day
            tooltip:AddDoubleLine("Day", get_local_day(point.day), nil, nil, nil, today and 0 or 1, today and 1 or 0, 0)
        end
        if point.note then
            tooltip:AddLine(point.note, nil, nil, nil, true)
        end
        if HandyNotes_HigherDimensionalLearning.db.tooltip_questid then
            tooltip:AddDoubleLine("QuestID", point.quest or UNKNOWN)
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end
local handle_tooltip_by_coord = function(tooltip, mapFile, coord)
    mapFile = string.gsub(mapFile, "_terrain%d+$", "")
    return handle_tooltip(tooltip, HandyNotes_HigherDimensionalLearning.points[mapFile] and HandyNotes_HigherDimensionalLearning.points[mapFile][coord])
end

---------------------------------------------------------
-- Plugin Handlers to HandyNotes
local HLHandler = {}
local info = {}

function HLHandler:OnEnter(mapFile, coord)
    local tooltip = GameTooltip
    if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    handle_tooltip_by_coord(tooltip, mapFile, coord)
end

local function createWaypoint(button, mapFile, coord)
    if TomTom then
        local mapId = HandyNotes:GetMapFiletoMapID(mapFile)
        local x, y = HandyNotes:getXY(coord)
        TomTom:AddWaypoint(mapId, x, y, {
            title = get_point_info_by_coord(mapFile, coord),
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

local function hideNode(button, mapFile, coord)
    HandyNotes_HigherDimensionalLearning.hidden[mapFile][coord] = true
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
            info.text         = "HandyNotes_HigherDimensionalLearning"
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
    local HL_Dropdown = CreateFrame("Frame", "HandyNotes_HigherDimensionalLearningDropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function HLHandler:OnClick(button, down, mapFile, coord)
        if button == "RightButton" and not down then
            currentZone = string.gsub(mapFile, "_terrain%d+$", "")
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        end
    end
end

function HLHandler:OnLeave(mapFile, coord)
    GameTooltip:Hide()
end

do
    -- This is a custom iterator we use to iterate over every node in a given zone
    local currentLevel, currentZone
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do -- Have we reached the end of this zone?
            if value and HandyNotes_HigherDimensionalLearning.should_show_point(state, value, currentZone, currentLevel) then
            -- Debug("iter step", state, icon, HandyNotes_HigherDimensionalLearning.db.icon_scale, HandyNotes_HigherDimensionalLearning.db.icon_alpha, category, quest)
                local label, icon = get_point_info(value)
                return state, nil, icon, HandyNotes_HigherDimensionalLearning.db.icon_scale, HandyNotes_HigherDimensionalLearning.db.icon_alpha
            end
            state, value = next(t, state) -- Get next data
        end
        return nil, nil, nil, nil
    end
    function HLHandler:GetNodes(mapFile, minimap, level)
        currentLevel = level
        mapFile = string.gsub(mapFile, "_terrain%d+$", "")
        currentZone = mapFile
        return iter, HandyNotes_HigherDimensionalLearning.points[mapFile], nil
    end
end

---------------------------------------------------------
-- Addon initialization, enabling and disabling

function HL:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_HigherDimensionalLearningDB", HandyNotes_HigherDimensionalLearning.defaults)
    HandyNotes_HigherDimensionalLearning.db = self.db.profile
    HandyNotes_HigherDimensionalLearning.hidden = self.db.char.hidden
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB("HandyNotes_HigherDimensionalLearning", HLHandler, HandyNotes_HigherDimensionalLearning.options)

    -- watch for LOOT_CLOSED
    self:RegisterEvent("LOOT_CLOSED")
end

function HL:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_HigherDimensionalLearning")
end

function HL:LOOT_CLOSED()
    self:Refresh()
end


HandyNotes_HigherDimensionalLearning.defaults = {
    profile = {
        found = false,
        today = true,
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

HandyNotes_HigherDimensionalLearning.options = {
    type = "group",
    name = "HigherDimensionalLearning",
    get = function(info) return HandyNotes_HigherDimensionalLearning.db[info[#info]] end,
    set = function(info, v)
        HandyNotes_HigherDimensionalLearning.db[info[#info]] = v
        HL:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_HigherDimensionalLearning")
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
                today = {
                    type = "toggle",
                    name = "Show today's only",
                    desc = "One book spawns (intermittently) each weekday. If this is checked, only show today's.",
                    order = 10,
                },
                found = {
                    type = "toggle",
                    name = "Show found",
                    desc = "Show waypoints for items you've already found?",
                    order = 20,
                },
                unhide = {
                    type = "execute",
                    name = "Reset hidden nodes",
                    desc = "Show all nodes that you manually hid by right-clicking on them and choosing \"hide\".",
                    func = function()
                        for map,coords in pairs(HandyNotes_HigherDimensionalLearning.hidden) do
                            wipe(coords)
                        end
                        HL:Refresh()
                    end,
                    order = 50,
                },
            },
        },
    },
}

local player_faction = UnitFactionGroup("player")
HandyNotes_HigherDimensionalLearning.should_show_point = function(coord, point, currentZone, currentLevel)
    if point.level and point.level ~= currentLevel then
        return false
    end
    if HandyNotes_HigherDimensionalLearning.hidden[currentZone] and HandyNotes_HigherDimensionalLearning.hidden[currentZone][coord] then
        return false
    end
    if point.junk and not HandyNotes_HigherDimensionalLearning.db.show_junk then
        return false
    end
    if point.faction and point.faction ~= player_faction then
        return false
    end
    if (not HandyNotes_HigherDimensionalLearning.db.found) then
        if point.quest and IsQuestFlaggedCompleted(point.quest) then
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
    if (not HandyNotes_HigherDimensionalLearning.db.repeatable) and point.repeatable then
        return false
    end
    if point.npc and not point.follower and not HandyNotes_HigherDimensionalLearning.db.show_npcs then
        return false
    end
    if point.day and HandyNotes_HigherDimensionalLearning.db.today and tonumber(date('%w')) ~= point.day then
        return false
    end
    return true
end


HandyNotes_HigherDimensionalLearning.points = {
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
    ["Azsuna"] = {
        [68115116] = { achievement=11175, criteria=32196, day=0, atlas="minortalents-icon-book", }, -- ch 1, Sunday
        [55257153] = { achievement=11175, criteria=32197, day=1, note="On top of the tower, have fun with that", atlas="minortalents-icon-book", }, -- ch 2, Monday
        [33371118] = { achievement=11175, criteria=32198, day=2, atlas="minortalents-icon-book", }, -- ch 3, Tuesday
        [58351229] = { achievement=11175, criteria=32199, day=3, note="Portal @ 58.72, 14.17", atlas="minortalents-icon-book", }, -- ch 4, Wednesday
        [53142199] = { achievement=11175, criteria=32200, day=4, note="Path @ 52.00, 17.63", atlas="minortalents-icon-book", }, -- ch 5, Thursday
        [61114626] = { achievement=11175, criteria=32201, day=5, atlas="minortalents-icon-book", }, -- ch 6, Friday
        [55674820] = { achievement=11175, criteria=32202, day=6, note="On top of the tower, have fun with that", atlas="minortalents-icon-book", }, -- ch 7, Saturday
    },
}
