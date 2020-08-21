local LegionTreasures = {}

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HL = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_LegionTreasures", "AceEvent-3.0")
LegionTreasures.HL = HL

local next = next
local GameTooltip = GameTooltip
local HandyNotes = HandyNotes
local GetItemInfo = GetItemInfo
local GetAchievementInfo = GetAchievementInfo
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetCurrencyInfo = GetCurrencyInfo

local ARTIFACT_LABEL = '|cffff8000' .. ARTIFACT_POWER .. '|r'

local cache_tooltip = CreateFrame("GameTooltip", "HNLegionTreasuresTooltip")
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
            name_cache[id] = HNLegionTreasuresTooltipTextLeft1:GetText()
        end
    end
    return name_cache[id]
end

local default_texture, npc_texture, follower_texture, currency_texture
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
local atlas_texture = function(atlas, scale)
    local texture, _, _, left, right, top, bottom = GetAtlasInfo(atlas)
    return {
        icon = texture,
        tCoordLeft = left,
        tCoordRight = right,
        tCoordTop = top,
        tCoordBottom = bottom,
        scale = scale or 1,
    }
end
local function work_out_label(point)
    local fallback
    if point.label then
        return point.label
    end
    if point.achievement then
        if point.criteria then
            local criteria = GetAchievementCriteriaInfoByID(point.achievement, point.criteria)
            if criteria then
                return criteria
            end
            fallback = 'achievement:'..point.achievement..'.'..point.criteria
        else
            local _, achievement = GetAchievementInfo(point.achievement)
            if achievement then
                return achievement
            end
            fallback = 'achievement:'..point.achievement
        end
    end
    if point.follower then
        local follower = C_Garrison.GetFollowerInfo(point.follower)
        if follower then
            return follower.name
        end
        fallback = 'follower:'..point.follower
    end
    if point.npc then
        local name = mob_name(point.npc)
        if name then
            return name
        end
        fallback = 'npc:'..point.npc
    end
    if point.item then
        local _, link, _, _, _, _, _, _, _, texture = GetItemInfo(point.item)
        if link then
            return link
        end
        fallback = 'item:'..point.item
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
    return fallback or UNKNOWN
end
local function work_out_texture(point)
    if point.atlas then
        if not icon_cache[point.atlas] then
            icon_cache[point.atlas] = atlas_texture(point.atlas)
        end
        return icon_cache[point.atlas]
    end
    if LegionTreasures.db.icon_item then
        if point.item then
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
    else
        if point.currency then
            if not currency_texture then
                currency_texture = atlas_texture("VignetteLoot", 1.5)
            end
            return currency_texture
        end
    end
    if point.follower then
        if not follower_texture then
            follower_texture = atlas_texture("GreenCross", 1.5)
        end
        return follower_texture
    end
    if point.npc then
        if not npc_texture then
            npc_texture = atlas_texture("DungeonSkull", 1)
        end
        return npc_texture
    end
    if not default_texture then
        default_texture = atlas_texture("Garr_TreasureIcon", 2.6)
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
        return label, icon, category, point.quest, point.faction, point.scale, point.alpha or 1
    end
end
local get_point_info_by_coord = function(uiMapID, coord)
    return get_point_info(LegionTreasures.points[uiMapID] and LegionTreasures.points[uiMapID][coord])
end

local function handle_tooltip(tooltip, point)
    if point then
        -- major:
        tooltip:AddLine(work_out_label(point))
        if point.follower then
            local follower = C_Garrison.GetFollowerInfo(point.follower)
            if follower then
                local quality = BAG_ITEM_QUALITY_COLORS[follower.quality]
                tooltip:AddDoubleLine(REWARD_FOLLOWER, follower.name,
                    0, 1, 0,
                    quality.r, quality.g, quality.b
                )
                tooltip:AddDoubleLine(follower.className, UNIT_LEVEL_TEMPLATE:format(follower.level))
            end
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
        if point.note then
            tooltip:AddLine(point.note, nil, nil, nil, true)
        end
        if point.quest and LegionTreasures.db.tooltip_questid then
            local quest = point.quest
            if type(quest) == 'table' then
                quest = string.join(", ", unpack(quest))
            end
            tooltip:AddDoubleLine("QuestID", quest or UNKNOWN)
        end

        if (LegionTreasures.db.tooltip_item or IsShiftKeyDown()) and (point.item or point.npc) then
            local comparison = ShoppingTooltip1

            do
                local side
                local rightDist = 0
                local leftPos = tooltip:GetLeft() or 0
                local rightPos = tooltip:GetRight() or 0

                rightDist = GetScreenWidth() - rightPos

                if (leftPos and (rightDist < leftPos)) then
                    side = "left"
                else
                    side = "right"
                end

                -- see if we should slide the tooltip
                if tooltip:GetAnchorType() and tooltip:GetAnchorType() ~= "ANCHOR_PRESERVE" then
                    local totalWidth = 0
                    if ( primaryItemShown  ) then
                        totalWidth = totalWidth + comparison:GetWidth()
                    end

                    if ( (side == "left") and (totalWidth > leftPos) ) then
                        tooltip:SetAnchorType(tooltip:GetAnchorType(), (totalWidth - leftPos), 0)
                    elseif ( (side == "right") and (rightPos + totalWidth) >  GetScreenWidth() ) then
                        tooltip:SetAnchorType(tooltip:GetAnchorType(), -((rightPos + totalWidth) - GetScreenWidth()), 0)
                    end
                end

                comparison:SetOwner(tooltip, "ANCHOR_NONE")
                comparison:ClearAllPoints()

                if ( side and side == "left" ) then
                    comparison:SetPoint("TOPRIGHT", tooltip, "TOPLEFT", 0, -10)
                else
                    comparison:SetPoint("TOPLEFT", tooltip, "TOPRIGHT", 0, -10)
                end
            end

            if point.item then
                comparison:SetHyperlink(("item:%d"):format(point.item))
            elseif point.npc then
                comparison:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(point.npc))
            end
            comparison:Show()
        end

        --if point.npc then
            --tooltip:AddLine("|cffeda55fClick|r to search for groups")
        --end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end
local handle_tooltip_by_coord = function(tooltip, uiMapID, coord)
    return handle_tooltip(tooltip, LegionTreasures.points[uiMapID] and LegionTreasures.points[uiMapID][coord])
end

---------------------------------------------------------
-- Plugin Handlers to HandyNotes
local HLHandler = {}
local info = {}

function HLHandler:OnEnter(uiMapID, coord)
    local tooltip = GameTooltip
    if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
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
    LegionTreasures.hidden[uiMapID][coord] = true
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
            info.text         = "LegionTreasures"
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
    local HL_Dropdown = CreateFrame("Frame", "HandyNotes_LegionTreasuresDropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function HLHandler:OnClick(button, down, uiMapID, coord)
        currentZone = uiMapID
        currentCoord = coord
        -- given we're in a click handler, this really *should* exist, but just in case...
        local point = LegionTreasures.points[currentZone] and LegionTreasures.points[currentZone][currentCoord]
        if button == "RightButton" and not down then
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        end
    end
end

function HLHandler:OnLeave(uiMapID, coord)
    GameTooltip:Hide()
    ShoppingTooltip1:Hide()
end

do
    -- This is a custom iterator we use to iterate over every node in a given zone
    local currentLevel, currentZone
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do -- Have we reached the end of this zone?
            if value and LegionTreasures.should_show_point(state, value, currentZone, currentLevel) then
                local label, icon, _, _, _, scale, alpha = get_point_info(value)
                scale = (scale or 1) * (icon and icon.scale or 1) * LegionTreasures.db.icon_scale
                return state, nil, icon, scale, LegionTreasures.db.icon_alpha * alpha
            end
            state, value = next(t, state) -- Get next data
        end
        return nil, nil, nil, nil
    end
    local function UnitHasBuff(unit, spellid)
        local buffname = GetSpellInfo(spellid)
        for i = 1, 40 do
            local name = UnitBuff(unit, i)
            if not name then
                -- reached the end, probably
                return
            end
            if buffname == name then
                return UnitBuff(unit, i)
            end
        end
    end
    function HLHandler:GetNodes2(uiMapID, minimap)
        currentZone = uiMapID
        isMinimap = minimap
        if minimap and LegionTreasures.map_spellids[uiMapID] then
            if LegionTreasures.map_spellids[uiMapID] == true then
                return iter
            end
            if UnitHasBuff("player", LegionTreasures.map_spellids[uiMapID]) then
                return iter
            end
        end
        return iter, LegionTreasures.points[uiMapID], nil
    end
end

---------------------------------------------------------
-- Addon initialization, enabling and disabling

function HL:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_LegionTreasuresDB", LegionTreasures.defaults)
    LegionTreasures.db = self.db.profile
    LegionTreasures.hidden = self.db.char.hidden
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB("HandyNotes_LegionTreasures", HLHandler, LegionTreasures.options)

    -- watch for LOOT_CLOSED
    self:RegisterEvent("LOOT_CLOSED", "Refresh")
    self:RegisterEvent("ZONE_CHANGED_INDOORS", "Refresh")
end

function HL:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_LegionTreasures")
end


LegionTreasures.defaults = {
    profile = {
        show_on_world = true,
        show_on_minimap = true,
        show_junk = false,
        show_npcs = true,
        show_treasure = true,
        found = false,
        repeatable = true,
        icon_scale = 1.0,
        icon_alpha = 1.0,
        icon_item = false,
        tooltip_item = true,
        tooltip_questid = false,
    },
    char = {
        hidden = {
            ['*'] = {},
        },
    },
}

LegionTreasures.options = {
    type = "group",
    name = "LegionTreasures",
    get = function(info) return LegionTreasures.db[info[#info]] end,
    set = function(info, v)
        LegionTreasures.db[info[#info]] = v
        LegionTreasures.HL:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_LegionTreasures")
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
                show_on_world = {
                    type = "toggle",
                    name = "World Map",
                    desc = "Show icons on world map",
                    order = 40,
                },
                show_on_minimap = {
                    type = "toggle",
                    name = "Minimap",
                    desc = "Show icons on the minimap",
                    order = 50,
                },
            },
        },
        display = {
            type = "group",
            name = "What to display",
            inline = true,
            args = {
                icon_item = {
                    type = "toggle",
                    name = "Use item icons",
                    desc = "Show the icons for items, if known; otherwise, the achievement icon will be used",
                    order = 0,
                },
                tooltip_item = {
                    type = "toggle",
                    name = "Use item tooltips",
                    desc = "Show the full tooltips for items",
                    order = 10,
                },
                found = {
                    type = "toggle",
                    name = "Show found",
                    desc = "Show waypoints for items you've already found?",
                    order = 20,
                },
                show_npcs = {
                    type = "toggle",
                    name = "Show NPCs",
                    desc = "Show rare NPCs to be killed, generally for items or achievements",
                    order = 30,
                },
                show_treasure = {
                    type = "toggle",
                    name = "Show treasure",
                    desc = "Show treasure that can be looted",
                    order = 30,
                },
                show_junk = {
                    type = "toggle",
                    name = "Junk",
                    desc = "Show items which don't count for any achievement",
                    order = 40,
                },
                -- repeatable = {
                --     type = "toggle",
                --     name = "Show repeatable",
                --     desc = "Show items which are repeatable? This generally means ones which have a daily tracking quest attached",
                --     order = 40,
                -- },
                tooltip_questid = {
                    type = "toggle",
                    name = "Show quest ids",
                    desc = "Show the internal id of the quest associated with this node. Handy if you want to report a problem with it.",
                    order = 40,
                },
                unhide = {
                    type = "execute",
                    name = "Reset hidden nodes",
                    desc = "Show all nodes that you manually hid by right-clicking on them and choosing \"hide\".",
                    func = function()
                        for map,coords in pairs(LegionTreasures.hidden) do
                            wipe(coords)
                        end
                        LegionTreasures.HL:Refresh()
                    end,
                    order = 50,
                },
            },
        },
    },
}

local allQuestsComplete = function(quests)
    if type(quests) == 'table' then
        -- if it's a table, only count as complete if all quests are complete
        for _, quest in ipairs(quests) do
            if not IsQuestFlaggedCompleted(quest) then
                return false
            end
        end
        return true
    elseif IsQuestFlaggedCompleted(quests) then
        return true
    end
end

local player_faction = UnitFactionGroup("player")
local player_name = UnitName("player")
LegionTreasures.should_show_point = function(coord, point, currentZone, currentLevel)
    if point.level and point.level ~= currentLevel then
        return false
    end
    if LegionTreasures.hidden[currentZone] and LegionTreasures.hidden[currentZone][coord] then
        return false
    end
    if LegionTreasures.outdoors_only and IsIndoors() then
        return false
    end
    if point.junk and not LegionTreasures.db.show_junk then
        return false
    end
    if point.faction and point.faction ~= player_faction then
        return false
    end
    if (not LegionTreasures.db.found) then
        if point.quest then
            if allQuestsComplete(point.quest) then
                return false
            end
        elseif point.achievement then
            local completedByMe = select(13, GetAchievementInfo(point.achievement))
            if completedByMe then
                return false
            end
            if point.criteria then
                local _, _, completed, _, _, completedBy = GetAchievementCriteriaInfoByID(point.achievement, point.criteria)
                if completed and completedBy == player_name then
                    return false
                end
            end
        end
        if point.follower and C_Garrison.IsFollowerCollected(point.follower) then
            return false
        end
        if point.toy and point.item and PlayerHasToy(point.item) then
            return false
        end
    end
    -- if (not LegionTreasures.db.repeatable) and point.repeatable then
    --     return false
    -- end
    if not point.follower then
        if point.npc then
            if not LegionTreasures.db.show_npcs then
                return false
            end
        else
            -- Not an NPC, not a follower, must be treasure
            if not LegionTreasures.db.show_treasure then
                return false
            end
        end
    end
    if point.hide_before and not LegionTreasures.db.upcoming and not allQuestsComplete(point.hide_before) then
        return false
    end
    return true
end

-- note to self: I like Garr_TreasureIcon...

local ORDER = 1220 -- order resources currency
local ARGUNITE = 1508
local ARTIFACT = 'ARTIFACT'
local CHEST = 'Treasure Chest'
local CHEST_SM = 'Small Treasure Chest'
local CHEST_GLIM = 'Glimmering Treasure Chest'
local LEGION_SUPPLIES = 'Legion War Supplies'
local REQ_GRAPPLE = 'Requires: Stormforged Grapple Launcher'
local path = function(questid, label, atlas, note, scale)
    label = label or "Path to treasure"
    atlas = atlas or "map-icon-SuramarDoor.tga" -- 'PortalPurple'
    return {
        quest = questid,
        label = label,
        atlas = atlas,
        path = true,
        scale = scale,
        note = note,
    }
end
LegionTreasures.path = path
local grapple = function(questid, note)
    -- 'Vehicle-SilvershardMines-Arrow'
    return path(questid, "Grapple start point", 'MiniMap-DeadArrow', note, 1.5)
end
LegionTreasures.grapple = grapple

LegionTreasures.map_spellids = {
    [630] = 182958, -- Azsuna
    [650] = 188741, -- Highmountain
    [634] = 182957, -- Stormheim
    [680] = 199416, -- Suramar
    [641] = 185719, -- Val'sharah
    [882] = true, -- MacAree
    [885] = true, -- Antoran Wastes
    [830] = true, -- Krokuun
}

LegionTreasures.points = {
    --[[ structure:
    [mapFile] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            label=[string], -- label: text that'll be the label, optional
            item=[id], -- itemid
            quest=[id], -- will be checked, for whether character already has it
            currency=[id], -- currencyid
            achievement=[id], -- will be shown in the tooltip
            junk=[bool], -- doesn't count for achievement
            npc=[id], -- related npc id, used to display names in tooltip
            note=[string], -- some text which might be helpful
        },
    },
    --]]
    [630] = { -- Azsuna
        [26254713] = {quest=44105, currency=ARTIFACT, label=CHEST_SM},
        [34583556] = {quest=44102, currency=ARTIFACT, label=CHEST_SM},
        [40575767] = {quest=38316, currency=ARTIFACT, label=CHEST},
        [41393075] = {quest=42292, currency=ARTIFACT, label=CHEST},
        [42600810] = {quest=38367, currency=ARTIFACT, label=CHEST_GLIM},
        [43402243] = {quest=42297, currency=ARTIFACT, label=CHEST_GLIM},
        [44473946] = {quest=37713, currency=ARTIFACT, label=CHEST_SM},
        [47860773] = {quest=42295, currency=ARTIFACT, label=CHEST_SM},
        [49384536] = {quest=37828, currency=ARTIFACT, item=122681, label=CHEST},
        [49415800] = {quest=38370, currency=ARTIFACT, item=141882, label=CHEST},
        [49653448] = {quest=37831, currency=ARTIFACT, label=CHEST_SM},
        [50215029] = {quest=42290, currency=ARTIFACT, label=CHEST_SM},
        [50465211] = {quest=44081, currency=ARTIFACT, item=140685, label="Treacherous Stallions", note="Ley Portal @ 60.3, 46.3; kill the stallions"},
        [60304630] = path(44081, "Ley Portal", "MagePortalAlliance"),
        [51502430] = {quest=42289, currency=ARTIFACT, label=CHEST, note="Leyhollow cave entrance @ 47.8, 23.7"},
        [47802370] = path(42289),
        [52004210] = {quest=42281, currency=ARTIFACT, label=CHEST_SM},
        [52842059] = {quest=42339, currency=ARTIFACT, label=CHEST, note="Cave entrance @ 53.9, 22.4; don't wake up the bears"},
        [53902240] = path(42339),
        [53033726] = {quest=37596, currency=ARTIFACT, label=CHEST_SM},
        [53176444] = {quest=37829, currency=ARTIFACT, label=CHEST},
        [53504545] = {quest=42283, currency=ARTIFACT, label=CHEST_SM},
        [53611813] = {quest=44104, currency=ARTIFACT, label=CHEST_SM},
        [53684396] = {quest=42282, currency=ARTIFACT, label=CHEST_SM},
        [53834053] = {quest=42284, currency=ARTIFACT, label=CHEST_SM, note="Inside the Academy"},
        [54313633] = {quest=42287, currency=ARTIFACT, label=CHEST_SM},
        [54403490] = {quest=42285, currency=ARTIFACT, label=CHEST_SM, note="Inside the Academy"},
        [54875214] = {quest=44405, currency=ARTIFACT, label=CHEST_SM},
        [55310505] = {quest=38389, currency=ARTIFACT, label=CHEST_SM},
        [55362774] = {quest=42288, currency=ARTIFACT, label=CHEST_SM},
        [55621855] = {quest=40711, currency=ARTIFACT, label=CHEST, note="Ley Portal inside tower"},
        [55905690] = {quest=38365, currency=ARTIFACT, label="Disputed Treasure"},
        [56443481] = {quest=38251, currency=ARTIFACT, item=132950, label=CHEST},
        [56892499] = {quest=42338, currency=ARTIFACT, label=CHEST_SM, note="Cave entrance @ 55.7, 25.4"},
        [55702540] = path(42338),
        [57153106] = {quest=38419, currency=ARTIFACT, label=CHEST},
        [57901220] = {quest=37958, currency=ARTIFACT, label=CHEST},
        [58364378] = {quest=37830, currency=ARTIFACT, label=CHEST_GLIM},
        [58381229] = {quest=37980, currency=ARTIFACT, label=CHEST, note="Ley Portal @ 58.7, 14.1"},
        [58701410] = path(37980, "Ley Portal", "MagePortalAlliance"),
        [58645340] = {quest=40752, currency=ARTIFACT, label=CHEST_SM},
        [59876316] = {quest=42272, currency=ARTIFACT, label=CHEST_SM},
        [62405840] = {quest=42273, currency=ARTIFACT, label=CHEST_SM},
        [62814479] = {quest=42294, currency=ARTIFACT, label=CHEST_SM},
        [63005420] = {quest=42278, currency=ARTIFACT, label=CHEST_SM, note="Cave entrance @ 64.0, 52.9"},
        [64005290] = path(42278),
        [63231521] = {quest=37832, currency=ARTIFACT, label=CHEST},
        [63653919] = {quest=42293, currency=ARTIFACT, label=CHEST_SM},
        [65066978] = {quest=38239, item=129070, label="Seemingly Unguarded Treasure", note="Seemingly..."},
        [65462961] = {quest=42958, currency=ARTIFACT, label=CHEST_SM},
        [66064345] = {quest=40751, currency=ARTIFACT, label=CHEST_SM},
        [68872973] = {quest=44103, currency=ARTIFACT, label=CHEST_SM, note="Underwater cave, entrance is on east side of cliff"},
    },
    [650] = { -- Highmountain
        [36616213] = {quest=40488, currency=ARTIFACT, label=CHEST},
        [37353381] = {quest=40477, currency=ARTIFACT, label=CHEST_SM},
        [39005450] = {quest=44731, currency=ARTIFACT, label=CHEST, note="Path up behind Nesingwary's camp"},
        [39307621] = {quest=40473, currency=ARTIFACT, label=CHEST, note="Hard to reach; try from behind the totem"},
        [39376229] = {quest=40474, currency=ARTIFACT, label=CHEST},
        [39555744] = {quest=39812, currency=ARTIFACT, label=CHEST},
        [39704830] = {quest=39494, currency=ARTIFACT, item=131763, label="Floating Treasure", note="On river surface, moves"},
        [42203482] = {quest=40480, currency=ARTIFACT, label=CHEST_SM},
        [42212730] = {quest=40479, currency=ARTIFACT, label=CHEST},
        [43582510] = {quest=40478, currency=ARTIFACT, label=CHEST, note="Cave entrance @ 42.5, 25.4"},
        [42502540] = path(40478),
        [43757275] = {quest=40510, currency=ARTIFACT, label=CHEST_SM},
        [45192746] = {quest=44279, currency=ARTIFACT, label=CHEST_SM, note="Underwater cave"},
        [45573462] = {quest=40481, currency=ARTIFACT, label=CHEST_SM},
        [46227340] = {quest=40489, currency=ARTIFACT, label=CHEST},
        [46302760] = {quest=44280, item=131753, label=CHEST},
        [46682810] = {quest=40482, currency=ARTIFACT, label=CHEST_GLIM, note="Top of the building"},
        [46814013] = {quest=40507, currency=ARTIFACT, label=CHEST_SM, note="All the way at the top of the mountain"},
        [47644406] = {quest=39503, item=131926, label=CHEST, note="1/4 of slow fall toy", toy=true},
        [49647128] = {quest=39606, currency=ARTIFACT, label=CHEST_GLIM, note="Inside cave"},
        [49653772] = {quest=39466, item=131927, label=CHEST, note="1/4 of slow fall toy, in nest at top of mountain", toy=true},
        [50243861] = {quest=40497, currency=ARTIFACT, label=CHEST_SM, note="Cave @ 51.6, 37.4"},
        [50813504] = {quest=40506, currency=ARTIFACT, label=CHEST_SM, note="All the way at the top of the mountain"},
        [50983647] = {quest=40496, currency=ARTIFACT, label=CHEST, note="Cave @ 51.6, 37.4"},
        [50983880] = {quest=40498, currency=ARTIFACT, label=CHEST},
        [52023241] = {quest=40505, currency=ARTIFACT, label=CHEST},
        [52305141] = {quest=39766, item=131802, label="Totally Safe Treasure Chest"},
        [53035224] = {quest=40493, currency=ARTIFACT, label=CHEST_SM},
        [49905380] = path(40493, "Crystal Fissure"),
        [51175305] = {quest=39471, currency=ARTIFACT, label=CHEST_GLIM, note="Path past the Skyhorn"},
        [52566637] = {quest=42453, currency=ARTIFACT, label=CHEST, note="Only after Battle of Snowblind Mesa quests are done?"},
        [53004830] = path(39471, "Path to Reflection Peak"),
        [53063946] = {quest=40499, currency=ARTIFACT, label=CHEST_SM},
        [53414868] = {quest=40500, currency=ARTIFACT, label=CHEST_SM},
        [53454352] = {quest=40484, currency=ARTIFACT, label=CHEST_SM, note="Cave entrance @ 55.1, 44.3"},
        [53615103] = {quest=39824, item=131810, label=CHEST, note="1/4 of slow fall toy; on ledge, path to southeast", toy=true},
        [55405270] = path(39824, "Path to Derelict Skyhorn Kite"),
        [54174159] = {quest=40483, currency=ARTIFACT, label=CHEST_GLIM, note="Cave entrance @ 55.1, 44.3"},
        [55104430] = path({40483, 40484, 40414}, "Candle Rock"),
        [55134965] = {quest=40487, currency=ARTIFACT, label=CHEST_SM},
        [38406150] = path(40476, "Lifespring Cavern"),
        [41407250] = path(40489, "Bitestone Enclave"),
        [44707230] = path({39606, 40508, 40509, 48381}, "Neltharion's Vault"),
        [51603740] = path({40496, 40497, 40406}, "Rockcrawler Chasm"),
        [48103390] = path({40496, 40497, 40406}, "Rockcrawler Chasm"),
        [32206680] = {achievement=10774, item=139773, toy=true}, -- Emerald Winds
    },
    [634] = { -- Stormheim
        [27335749] = {quest=38529, currency=ARTIFACT, label=CHEST, note="Cave entrance @ 31.4, 57.1"},
        [31405710] = path(38529),
        [31105600] = {quest=38676, currency=ORDER, label=CHEST_SM},
        [32054719] = {quest=43196, currency=ARTIFACT, label=CHEST},
        [32742791] = {quest=38490, currency=ARTIFACT, label=CHEST, note="Cave entrance @ 33.6, 27.3"},
        [33602730] = path(38490),
        [33143607] = {quest=38495, currency=ARTIFACT, label=CHEST},
        [35033660] = {quest=38487, currency=ARTIFACT, label=CHEST, note="Cave entrance @ 34.8, 34.2"},
        [34803420] = path(38487),
        [35176898] = {quest=38478, currency=ARTIFACT, label=CHEST_SM},
        [35735415] = {quest=38677, currency=ARTIFACT, item=140310, label=CHEST, note="On the wrecked ship"},
        [35924792] = {quest=38680, currency=ARTIFACT, label=CHEST_SM},
        [37183865] = {quest=43208, currency=ARTIFACT, label=CHEST_SM},
        [39486518] = {quest=38486, currency=ARTIFACT, label=CHEST},
        [39571934] = {quest=38498, currency=ARTIFACT, label=CHEST_SM},
        [40656852] = {quest=38475, currency=ARTIFACT, label=CHEST_SM, note="In tower; grapple to wall, then to top of tower"},
        [41744604] = {quest=38488, currency=ARTIFACT, label=CHEST_SM},
        [42336112] = {quest=38477, currency=ARTIFACT, label=CHEST_SM},
        [42473407] = {quest=43189, currency=ARTIFACT, item=141896, label=CHEST_GLIM, note="Entrance @ 42.2, 34.9"},
        [42203490] = path(43189),
        [42616579] = {quest=38474, currency=ARTIFACT, label=CHEST},
        [43164049] = {quest=43238, currency=ARTIFACT, label=CHEST_SM, note=REQ_GRAPPLE},
        [43708009] = {quest=43239, currency=ARTIFACT, label=CHEST_SM, note="Grapple starting by Erilar at 43.8, 80.6"},
        [43708009] = grapple(43239),
        [44166997] = {quest=38489, currency=ARTIFACT, label=CHEST_SM, note="On top of the hut, grapple up"},
        [44983823] = {quest=43240, currency=ARTIFACT, label=CHEST_SM, note=REQ_GRAPPLE},
        [46606496] = {quest=38681, currency=ARTIFACT, label=CHEST_SM, note="Cave entrance @ 48.2, 65.2"},
        [48206520] = path(38681),
        [46768040] = {quest=38481, currency=ARTIFACT, label=CHEST, note=REQ_GRAPPLE},
        [47463412] = {quest=43255, currency=ARTIFACT, label=CHEST_SM, note=REQ_GRAPPLE},
        [47986237] = {quest=38738, currency=ARTIFACT, label=CHEST, note="Underwater, at base of waterfall"},
        [48137421] = {quest=38476, currency=ARTIFACT, label=CHEST_SM},
        [49085999] = {quest=43207, currency=ARTIFACT, label=CHEST_SM},
        [49694731] = {quest=38763, currency=ARTIFACT, item=132897, label=CHEST_GLIM, note="Guarded by Vault Keepers"},
        [49777801] = {quest=38485, currency=ARTIFACT, label=CHEST_SM, note=REQ_GRAPPLE},
        [50061816] = {quest=43195, currency=ARTIFACT, label=CHEST},
        [50314100] = {quest=38483, currency=ARTIFACT, label=CHEST_SM, note="In cave"},
        [50554125] = {quest=43246, currency=ARTIFACT, label=CHEST_SM, note=REQ_GRAPPLE},
        [52018058] = {quest=38480, currency=ARTIFACT, label=CHEST_SM, note=REQ_GRAPPLE},
        [53229314] = {quest=43190, currency=ARTIFACT, label=CHEST_SM},
        [55004716] = {quest=40095, currency=ARTIFACT, label=CHEST},
        [57946321] = {quest=40090, currency=ARTIFACT, label=CHEST_SM},
        [58044751] = {quest=40082, currency=ARTIFACT, label=CHEST_SM},
        [59305846] = {quest=40088, currency=ARTIFACT, label=CHEST},
        [60834273] = {quest=40094, currency=ARTIFACT, label=CHEST_SM, note=REQ_GRAPPLE},
        [61404440] = {quest=40093, currency=ARTIFACT, label=CHEST_SM},
        [61836289] = {quest=40089, currency=ARTIFACT, label=CHEST},
        [61836289] = {quest=40089, currency=ARTIFACT, label=CHEST},
        [61933255] = {quest=38744, currency=ARTIFACT, label=CHEST_SM},
        [62667362] = {quest=40091, currency=ARTIFACT, label=CHEST_SM},
        [64293956] = {quest=43302, currency=ARTIFACT, label=CHEST_SM},
        [64224161] = path(43302),
        [65364310] = {quest=43205, currency=ARTIFACT, label=CHEST_SM},
        [65585737] = {quest=43187, currency=ARTIFACT, label=CHEST_SM},
        [67935774] = {quest=40083, currency=ARTIFACT, label=CHEST_SM},
        [68462959] = {quest=40108, currency=ARTIFACT, label=CHEST_GLIM, note=REQ_GRAPPLE},
        [68402000] = path(40108),
        [68974183] = {quest=40086, currency=ARTIFACT, label=CHEST_SM, note="Tomb entrance @ 70.0, 42.6"},
        [69964262] = path(40086),
        [69144478] = {quest=38637, currency=ARTIFACT, label=CHEST_SM, note=REQ_GRAPPLE},
        [69986719] = {quest=43188, currency=ARTIFACT, label=CHEST_SM},
        [71924425] = {quest=43305, currency=ARTIFACT, label=CHEST_SM, note=REQ_GRAPPLE},
        [70734281] = grapple(43305),
        [72135489] = {quest=42628, currency=ARTIFACT, label=CHEST_SM},
        [73154570] = {quest=43194, currency=ARTIFACT, label=CHEST_SM},
        [73334150] = {quest=40085, currency=ARTIFACT, label=CHEST_SM},
        [73965223] = {quest=42632, currency=ARTIFACT, label=CHEST_SM},
        [73975858] = {quest=43237, currency=ARTIFACT, label=CHEST_SM},
        [74414182] = {quest=43306, currency=ARTIFACT, label=CHEST_SM, note=REQ_GRAPPLE},
        [75164949] = {quest=42629, currency=ARTIFACT, label=CHEST, note="On top of the mast"},
        [75676060] = {quest=43304, currency=ARTIFACT, label=CHEST_SM, note=REQ_GRAPPLE},
        [78427138] = {quest=43307, currency=ARTIFACT, label=CHEST, note="*Really* requires the Stormforged Grapple Launcher"},
        [75846406] = grapple(43307, "Route *requires* taking some falling damage, I think."),
        [81876750] = {quest=40099, currency=ARTIFACT, label=CHEST},
        [82405451] = {quest=43191, currency=ARTIFACT, label=CHEST_SM},
    },
    [680] = { -- Suramar
        [16602974] = {quest=43846, currency=ARTIFACT, label=CHEST_SM},
        [17275462] = {quest=43844, currency=ARTIFACT, label=CHEST},
        [19791604] = {quest=43845, currency=ARTIFACT, label=CHEST_SM, note="Cave entrance @ 19.4, 19.4"},
        [19401940] = path(43845),
        [20605040] = path({43839, 43840, 43747}, "Falanaar Tunnels"),
        [21425446] = {quest=42842, item=136269, label="Kel'danath's Manaflask"},
        [22863574] = path({43838, 43988}, "Temple of Fal'adora"),
        [23414880] = {quest=43842, currency=ARTIFACT, label=CHEST_SM},
        [25958548] = {quest=43831, currency=ARTIFACT, label=CHEST_SM},
        [26354127] = {quest=42827, item=139890, label="Ancient Mana Chunk"},
        [26831696] = {quest=43847, currency=ARTIFACT, label=CHEST_SM},
        [26877073] = {quest=43987, item=140327, label="Kyrtos's Research Notes", note="Cave entrance @ 27.3, 72.9"},
        [27307290] = path(43987),
        [29271622] = {quest=43848, currency=ARTIFACT, label=CHEST},
        [29768817] = {quest=43748, item=141655, label="Shimmering Ancient Mana Cluster"},
        [31956249] = {quest=43831, currency=ARTIFACT, label=CHEST_SM},
        [32317708] = {quest=43834, currency=ARTIFACT, label=CHEST_SM, note="Inside the Lightbreaker, after quests; portal @ 31.0, 85.1"},
        [31008510] = path(43834),
        [35561209] = {quest=43989, item=140329, label="Arcane Power Unit"},
        [38138712] = {quest=43830, currency=ARTIFACT, label=CHEST_SM},
        [41961919] = {quest=43746, item=139786, label="Shimmering Ancient Mana Cluster"},
        [42051968] = {quest=43849, item=139786, label=CHEST_GLIM},
        [42577668] = {quest=43870, currency=ARTIFACT, label=CHEST_SM, note="Upstairs"},
        [44053194] = {quest=43856, item=139786, label=CHEST_GLIM, note="Cave entrance behind waterfall @ 42.2, 30.0"},
        [42203000] = path(43856),
        [44302289] = {quest=43850, currency=ARTIFACT, label=CHEST},
        [44387587] = {quest=43869, currency=ARTIFACT, label=CHEST_SM},
        [44803100] = {quest=43986, item=140326, label="Enchanted Burial Urn", note="Doesn't stand out much; by the bench, upper level"},
        [46552599] = {quest=43744, item=141655, label="Shimmering Ancient Mana Cluster"},
        [48117321] = {quest=43865, currency=ARTIFACT, label=CHEST_SM, note="Grapple to it"},
        [48143399] = {quest=43853, currency=ARTIFACT, label=CHEST_SM},
        [48288261] = {quest=43866, currency=ARTIFACT, label=CHEST_SM, note="Grapple from 48.4, 82.2"},
        [48408220] = grapple(43866),
        [48297121] = {quest=44324, currency=ARTIFACT, label=CHEST, note="Upstairs"},
        [48587217] = {quest=44323, currency=ARTIFACT, label=CHEST, note="Upstairs"},
        [48957379] = {quest=43867, currency=ARTIFACT, label=CHEST, note="Upstairs"},
        [49988493] = {quest=43864, currency=ARTIFACT, label=CHEST_SM, note="Grapple from 50.0, 84.5"},
        [50008450] = grapple(43864),
        [50068061] = {quest=44325, currency=ARTIFACT, label=CHEST, note="Upstairs"},
        [51503859] = {quest=43855, currency=ARTIFACT, label=CHEST_SM},
        [51908214] = {quest=43868, currency=ARTIFACT, label=CHEST},
        [52272989] = {quest=43854, currency=ARTIFACT, label=CHEST},
        [52733130] = {quest=40767, currency=ARTIFACT, label="Dusty Coffer"},
        [49503390] = path({43854,40767}),
        [54326033] = {quest=43875, currency=ARTIFACT, label=CHEST},
        [55685480] = {quest=43871, currency=ARTIFACT, label=CHEST_SM},
        [57326039] = {quest=43873, currency=ARTIFACT, label=CHEST},
        [57686197] = {quest=43874, currency=ARTIFACT, label=CHEST},
        [60356851] = {quest=43876, item=139786, label=CHEST_GLIM},
        [61365550] = {quest=43872, currency=ARTIFACT, label=CHEST},
        [63654911] = {quest=43857, currency=ARTIFACT, label=CHEST_SM},
        [65814191] = {quest=43743, item=141655, label="Shimmering Ancient Mana Cluster", note="At the back of the leyline cave"},
        [67315511] = {quest=43858, currency=ARTIFACT, label=CHEST},
        [71464975] = {quest=43859, currency=ARTIFACT, label=CHEST_SM},
        [76886150] = {quest=43860, currency=ARTIFACT, label=CHEST_SM, note="Underwater, in a sunken ship"},
        [79647289] = {quest=43741, item=141655, label="Shimmering Ancient Mana Cluster"},
        [81965745] = {quest=43861, currency=ARTIFACT, label=CHEST_SM, note="Entrance @ 79.3, 57.4"},
        [79305740] = path(43861),
        [83126933] = {quest=43863, currency=ARTIFACT, label=CHEST},
        [83975764] = {quest=43862, currency=ARTIFACT, label=CHEST},
    },
    [641] = { -- Val'sharah
        [33815826] = {quest=39081, currency=ARTIFACT, label=CHEST},
        -- [37005734] = {quest=39083, currency=ARTIFACT, label=CHEST_SM},
        [38456530] = {quest=39080, currency=ARTIFACT, label=CHEST_SM, note="Basement; must have completed The Farmsteads"},
        [38626718] = {quest=39079, currency=ARTIFACT, label=CHEST_SM},
        [39945460] = {quest=38369, currency=ARTIFACT, label=CHEST_SM},
        [41404560] = path({39085,39086}, "Darkpens"),
        [42665801] = {quest=39077, currency=ARTIFACT, label=CHEST_SM},
        [43068822] = {quest=44138, currency=ARTIFACT, label=CHEST, note="Cave entrance @ 43.7, 89.9"},
        [43225488] = {quest=39084, currency=ARTIFACT, label=CHEST, note="Top of wall"},
        [43397589] = {quest=38363, currency=ARTIFACT, label=CHEST_SM},
        [44358257] = {quest=38387, currency=ARTIFACT, item=141892, label=CHEST, note="Cave under the inn; entrance behind the building"},
        [45106120] = {quest=39083, currency=ARTIFACT, label=CHEST_SM, note="Hidden in the tree"},
        [46448630] = {quest=38277, currency=ARTIFACT, label=CHEST_SM},
        [48687381] = {quest=38366, currency=ARTIFACT, label=CHEST_SM, note="Under tree roots"},
        [48998615] = {quest=38886, currency=ARTIFACT, label=CHEST_SM},
        [51247777] = {quest=38388, currency=ARTIFACT, label=CHEST_SM, note="Cave entrance @ 50.9, 77.0"},
        [50907700] = path(38388),
        [54003489] = {quest=38390, item=141891, currency=ARTIFACT, label=CHEST_GLIM, note="Cave entrance @ 53.2, 38.0"},
        [53203800] = path(38390),
        [54187061] = {quest=39093, currency=ARTIFACT, label=CHEST_SM, note="In cave"},
        [54417419] = {quest=38359, currency=ARTIFACT, label=CHEST_SM, note="In house behind the fence"},
        [54506048] = {quest=39097, currency=ARTIFACT, item=130152, label=CHEST, note="In cave"},
        [54908056] = {quest=38864, currency=ARTIFACT, label=CHEST_SM, note="In underwater cave"},
        -- [54958054] = {quest=38861, currency=ARTIFACT, label=CHEST_SM, note="In underwater cave"}, -- removed? swapped for 38864?
        [54108210] = path(38864, "Route to cave"),
        [55557762] = {quest=38466, item=130147, toy=true, label="Unguarded Thistlemaw Treasure", note="Unguarded..."},
        [56008376] = {quest=38861, currency=ARTIFACT, label=CHEST_SM},
        [56225730] = {quest=39072, currency=ARTIFACT, label=CHEST_SM},
        [59887228] = {quest=38943, currency=ARTIFACT, label=CHEST_SM, note="Upstairs, stairs on the right"},
        [60498216] = {quest=38893, currency=ARTIFACT, label=CHEST_SM, note="Cave entrance @ 62.1, 86.1"},
        [62108610] = path(38893),
        [61006400] = {quest=39087, currency=ARTIFACT, label=CHEST_SM},
        [61017917] = {quest=39089, currency=ARTIFACT, label=CHEST_GLIM},
        [61073421] = {quest=39088, currency=ARTIFACT, label=CHEST, note="Underwater, hidden in roots"},
        [61657372] = {quest=39087, currency=ARTIFACT, label=CHEST_SM},
        [62076737] = {quest=39071, currency=ARTIFACT, label=CHEST, note="Chest behind waterfall"},
        [62707040] = {quest=39069, currency=ARTIFACT, label=CHEST_SM, note="Second floor balcony"},
        [62708526] = {quest=44136, currency=ARTIFACT, label=CHEST_SM},
        [63007700] = {quest=39070, currency=ARTIFACT, label=CHEST_SM, note="Inside Den of Claws, entrance @ 62.2, 76.2"},
        [62207620] = path(39070, "Den of Claws entrance"),
        [63277401] = {quest=39102, currency=ARTIFACT, label=CHEST},
        [63378841] = {quest=38389, currency=ARTIFACT, label=CHEST_SM},
        [63904556] = {quest=44139, currency=ARTIFACT, label=CHEST_SM},
        [64608546] = {quest=38900, currency=ARTIFACT, label=CHEST},
        [65907920] = {quest=38391, currency=ARTIFACT, label=CHEST_SM},
        [64715126] = {quest=38355, currency=ARTIFACT, label=CHEST_SM},
        [65398629] = {quest=39074, currency=ARTIFACT, label=CHEST},
        [66604090] = {quest=39108, currency=ARTIFACT, label=CHEST},
        -- [67105770] = {quest=, item=139023, label="Elven Chest"}, -- no tracking quest triggers here...
        [67215928] = {quest=38782, currency=ARTIFACT, label=CHEST, note="Cave entrance @ 65.9, 56.3; doesn't appear until area quests are finished"},
        [65905630] = path(38782, "Darkgrove Cavern"),
        [67395342] = {quest=38386, currency=ARTIFACT, label=CHEST_SM},
        [68334060] = {quest=39073, currency=ARTIFACT, label=CHEST_SM},
        [69475999] = {quest=38781, currency=ARTIFACT, label=CHEST_SM},
        [70225704] = {quest=38783, currency=ARTIFACT, label=CHEST_SM},
    },
    [646] = { -- Broken Shore
        -- TODO: are any treasures actually quest-gated?
    },
    [830] = { -- Krokuun
        [48505890] = {quest=nil, currency=ARGUNITE, achievement=12074, criteria=37594}, -- Lost Krokul Chest
        [51257624] = {quest=48884, currency=ARGUNITE, achievement=12074, criteria=37592, note="Requires Lightforge Warframe. Jump on the rubble."}, -- Krokuul Emergency Cache
        [55907420] = {quest=49156, currency=ARGUNITE, achievement=12074, criteria=37959, note="Requires Shroud of Arcane Echoes"}, -- Precious Augari Keepsakes
        [62803730] = {quest=nil, currency=ARGUNITE, item=151246, note="Climb up behind the tower", achievement=12074, criteria=37593}, -- Legion Tower Chest
        [75246960] = {quest=49154, currency=ARGUNITE, achievement=12074, criteria=37958, note="Requires Shroud of Arcane Echoes. Stealth before opening."}, -- Long-Lost Augari Treasure

        -- Junk:
        [72293223] = {quest=48339, currency=ARGUNITE, label="Eredar War Supplies", junk=true},
        [52856280] = {quest=48339, currency=ARGUNITE, label="Eredar War Supplies", junk=true},
        [61406640] = {quest=48339, currency=ARGUNITE, label="Eredar War Supplies", junk=true},
        [43505520] = {quest=48339, currency=ARGUNITE, label="Eredar War Supplies", junk=true},

        [48603090] = {quest=47999, currency=ARGUNITE, label="Eredar War Supplies", junk=true},
        [59544417] = {quest=47999, currency=ARGUNITE, label="Eredar War Supplies", junk=true},
        [61573519] = {quest=47999, currency=ARGUNITE, label="Eredar War Supplies", junk=true},
        [62803810] = {quest=47999, currency=ARGUNITE, label="Eredar War Supplies", junk=true},
        [66802490] = {quest=47999, currency=ARGUNITE, label="Eredar War Supplies", junk=true},
        [62394178] = {quest=47999, currency=ARGUNITE, label="Eredar War Supplies", junk=true},

        [67606990] = {quest=48000, currency=ARGUNITE, label="Eredar War Supplies", junk=true, note="Up on the ridge"},
        [69406280] = {quest=48000, currency=ARGUNITE, label="Eredar War Supplies", junk=true},
        [75006420] = {quest=48000, currency=ARGUNITE, label="Eredar War Supplies", junk=true},
        [71426162] = {quest=48000, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},

        [46508520] = {quest=47997, currency=ARGUNITE, label="Eredar War Supplies", junk=true},
        [40617531] = {quest=47997, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},

        [64203910] = {quest=48885, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true, note="Requires Light's Judgement. Blow the pile of ruble with the ability"},

        [47705940] = {quest=48886, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true, note="Requires Light's Judgement. Blow the pile of ruble with the ability"},

        [32047451] = {quest=48336, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [35475618] = {quest=48336, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [37007430] = {quest=48336, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [41335836] = {quest=48336, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},

        [36396765] = {quest=48336, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},

        [56675875] = {quest=47752, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [55605240] = {quest=47752, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [53305110] = {quest=47752, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [52025959] = {quest=47752, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},

        [58207179] = {quest=47753, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [59377345] = {quest=47753, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [58607990] = {quest=47753, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
  [58407610] = { npc=120393, quest=48627 },
	[40704340] = { npc=125824, quest=48561 },
	[45305890] = { npc=124775, quest=48564 },
	[33307620] = { npc=122912, quest=48562 },
	[38305980] = { npc=122911, quest=48563 },
	[70503370] = { npc=126419, quest=48667 },
	[52803110] = { npc=123464, quest=48565 },
	[54708120] = { npc=123689, quest=48628 },
	[70108140] = { npc=125479, quest=48665 },
	--[69305940] = { npc=1, label=L["Tereck the Selector - Entrance"], },
	[69205940] = { npc=124804, quest=48664 },
	[60901960] = { npc=125388, quest=48091 },
	[42406990] = { npc=125820, quest=48666 },
    },
    [885] = { -- Antoran Wastes
        [49135934] = {quest=49020, currency=ARGUNITE, achievement=12074, criteria=37698, note="Behind the waterfall"}, -- Legion Treasure Hoard
        [52102720] = {quest=nil, currency=ARGUNITE, achievement=12074, criteria=37697, note="Requires Light's Judgement"}, -- Fel-Bound Chest
        [57346366] = {quest=nil, currency=ARGUNITE, achievement=12074, criteria=37960, note="Requires Shroud of Arcane Echoes"}, -- Missing Augari Chest
        [58906140] = {quest=nil, currency=ARGUNITE, achievement=12074, criteria=37695, note="Requires Lightforged Warframe"}, -- Forgotten Legion Supplies
        [65903980] = {quest=nil, currency=ARGUNITE, achievement=12074, criteria=37696, note="Requires Light's Judgement"}, -- Ancient Legion War Cache
        [75705260] = {quest=49021, currency=ARGUNITE, achievement=12074, criteria=37699}, -- Timeworn Fel Chest

        -- Junk:
        [57836485] = {quest=48382, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [60897052] = {quest=48382, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [62106933] = {quest=48382, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [64475836] = {quest=48382, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [67516988] = {quest=48382, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [69406320] = {quest=48382, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},

        [56393555] = {quest=48383, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [51693779] = {quest=48383, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [59883581] = {quest=48383, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [58403090] = {quest=48383, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [55103930] = {quest=48383, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},

        [59101940] = {quest=48384, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [66581711] = {quest=48384, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [64062748] = {quest=48384, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},

        [57735890] = {quest=48385, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [55925384] = {quest=48385, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [48225455] = {quest=48385, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},

        [72404210] = {quest=48387, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [66603641] = {quest=48387, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [68903340] = {quest=48387, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [69503966] = {quest=48387, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},

        [55991401] = {quest=48388, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [59581389] = {quest=48388, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [55402040] = {quest=48388, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [54202800] = {quest=48388, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},

        [65225180] = {quest=48389, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true, note="In the cave"},
        [60344695] = {quest=48389, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [64315036] = {quest=48389, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true, note="In the cave"},
        [60684104] = {quest=48389, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [65484091] = {quest=48389, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},

        [73306850] = {quest=48390, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [76465651] = {quest=48390, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true}, -- Verify me...
        [76565823] = {quest=48390, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [78025620] = {quest=48390, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},

        [65224956] = {quest=48391, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [68005070] = {quest=48391, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [69785509] = {quest=48391, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [63075799] = {quest=48391, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true, note="In the cave"},

        [52102720] = {quest=49019, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true},
        [65204060] = {quest=49018, currency=ARGUNITE, label=LEGION_SUPPLIES, junk=true, note="Requires Light's Judgement to be equipped in the Vindicaar Matrix. Blow the pile of ruble with the ability"},
  [73507200] = { npc=127090, quest=48817 },
	[74905700] = { npc=127096, quest=48818 },
	[61703690] = { npc=122958, quest=49183 },
	[61402100] = { npc=127376, quest=48865 },
	[80506280] = { npc=127084, quest=48816 }, -- portal position
	[55704590] = { npc=122999, quest=49241 },
	[63102520] = { npc=127288, quest=48821 }, -- Entrance
	[61104570] = { npc=126946, quest=48815 }, --Path Start
	[62305350] = { npc=126254, quest=48813 },
	[57403290] = { npc=122947, quest=49240 }, -- Inside Building
	[65602660] = { npc=127705, quest=48970 }, -- Same as Puscilla
	[65602660] = { npc=126040, quest=48809 }, -- Cave Entrance
	[54703910] = { npc=127581, quest=48966 }, -- Spot to Summon
	[64304820] = { npc=126208, quest=48812 }, -- Cave Entrance
	[66005410] = { npc=126115, quest=48811 }, -- Cave Entrance
	[55702190] = { npc=127300, quest=48824 },
	[52903620] = { npc=126199, quest=48810 },
	[52902940] = { npc=127291, quest=48822 },
	[50905530] = { npc=127118, quest=48820 },
	[61406510] = { npc=126338, quest=48814 },
    },
    [833] = { -- Nath'raxas Spire
    },
    [882] = { -- MacAree
        [27284015] = {quest=48750, achievement=12074, criteria=37601, currency=ARGUNITE, note="You will need a Glider, jump from 31.92, 45.19"}, -- Shattered House Chest
        [40275130] = {quest=48747, achievement=12074, criteria=37598, currency=ARGUNITE, note="Requires Lightforge Warframe. Jump on the rubble."}, -- Void-Tinged Chest
        [40896985] = {quest=49153, achievement=12074, criteria=37957, currency=ARGUNITE, note="Requires Shroud of Arcane Echoes. Stealth before opening."}, -- Augari Goods
        [42900550] = {quest=nil, achievement=12074, criteria=37595, currency=ARGUNITE, note="Requires Lightforged Warframe."}, -- Eredar Treasure Cache
        [43445440] = {quest=48751, achievement=12074, criteria=37602, currency=ARTIFACT, note="You will need a Glider"}, -- Doomseeker's Treasure
        [50693851] = {quest=48744, achievement=12074, criteria=37596, currency=ARTIFACT}, -- Chest of Ill-Gotten Gains
        [57097677] = {quest=48346, achievement=12074, criteria=37600, currency=ARTIFACT, note="Climb from 59.67, 76.40"}, -- Desperate Eredar's Cache
        [62152241] = {quest=49151, achievement=12074, criteria=37956, currency=ARGUNITE, note="Requires Shroud of Arcane Echoes. Stealth before opening."}, -- Secret Augari Chest
        [62207120] = {quest=nil, achievement=12074, criteria=37597, currency=ARGUNITE, note="Requires Light's Judgement'."}, -- Student's Surprising Surplus
        [70245976] = {quest=48748, achievement=12074, criteria=37599, currency=ARGUNITE}, -- Augari Secret Stash
        [70602730] = {quest=nil, achievement=12074, criteria=37955, currency=ARGUNITE, note="Requires Shroud of Arcane Echoes. Stealth before opening."}, -- Augari-Runed Chest

        -- Junk:
        [53228020] = {quest=48346, label=LEGION_SUPPLIES, junk=true, currency=ARTIFACT},
        [54825759] = {quest=48346, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},
        [54806700] = {quest=48346, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},
        [59476292] = {quest=48346, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},
        [59906980] = {quest=48346, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},

        [53902320] = {quest=48350, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},
        [53603410] = {quest=48350, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},
        [58704082] = {quest=48350, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},
        [59602090] = {quest=48350, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},
        [63311994] = {quest=48350, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},

        [37205550] = {quest=48351, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},
        [42305750] = {quest=48351, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},
        [43776836] = {quest=48351, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},
        [43617138] = {quest=48351, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},

        [44601860] = {quest=48357, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},
        [57821057] = {quest=48357, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},

        [28904422] = {quest=48361, label="Void-Seeped Cache", junk=true, currency=ARGUNITE},
        [25834447] = {quest=48361, label="Void-Seeped Cache", junk=true, currency=ARGUNITE},

        [62013276] = {quest=48362, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},

        [43776836] = {quest=48371, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},
        [48704980] = {quest=48371, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},
        [25263016] = {quest=48371, label="Ancient Eredar Cache", junk=true, currency=ARGUNITE},
        [50605600] = {quest=48371, label="Ancient Eredar Cache", junk=true, item=153334, currency=ARGUNITE},

        [33752371] = {quest=48371, label="Void-Seeped Cache", junk=true, currency=ARGUNITE},

        [31552541] = {quest=49264, label="Void-Seeped Cache", junk=true, currency=ARGUNITE},
        [37583619] = {quest=49264, label="Void-Seeped Cache", junk=true, currency=ARGUNITE},
        [37102010] = {quest=49264, label="Void-Seeped Cache", junk=true, currency=ARGUNITE},
  [62695006] = { npc=126900, quest=48718 },
	[33754831] = { npc=126867, quest=48705 },
	[41331224] = { npc=126864, quest=48702 },
    },
    -- Small zones
    [627] = { -- Dalaran
        [28466450] = {quest=41929, item=7676, label="Desmond's Lockbox", note="Locked"},
        [47404120] = {quest=45365, item=143534, toy=true, note="On the table on the second floor of the Legerdemain Lounge", level=10},
        -- Dog pebble, questid is for showing Dog the pebble, not looting it
        [38102920] = {quest=46952, item=147420, note="Show to Dog in your Draenor garrison", hide_before=30526},
        [42104440] = {quest=46952, item=147420, note="Show to Dog in your Draenor garrison", hide_before=30526},
        [41005320] = {quest=46952, item=147420, note="Show to Dog in your Draenor garrison", hide_before=30526},
        [46205390] = {quest=46952, item=147420, note="Show to Dog in your Draenor garrison", hide_before=30526},
        [49406940] = {quest=46952, item=147420, note="Show to Dog in your Draenor garrison", hide_before=30526},
        [51706220] = {quest=46952, item=147420, note="Show to Dog in your Draenor garrison", hide_before=30526},
        [54505320] = {quest=46952, item=147420, note="Show to Dog in your Draenor garrison", hide_before=30526},
        [54304080] = {quest=46952, item=147420, note="Show to Dog in your Draenor garrison", hide_before=30526},
        [47702920] = {quest=46952, item=147420, note="Show to Dog in your Draenor garrison", hide_before=30526},
        [44601820] = {quest=46952, item=147420, note="Show to Dog in your Draenor garrison", hide_before=30526},
    },
    [642] = { -- Darkpens, Val'sharah
        [42018849] = {quest=39085, currency=ARTIFACT, label=CHEST_SM, note="In water at bottom of stairs"},
        [50905168] = {quest=39086, currency=ARTIFACT, label=CHEST_GLIM},
    },
    [649] = { -- Helheim in Stormheim
        [79842471] = {quest=38510, currency=ARTIFACT, label=CHEST_SM},
        [83322456] = {quest=38503, currency=ARTIFACT, label=CHEST, note="Underwater in a ship"},
        [19634698] = {quest=38516, currency=ARTIFACT, label=CHEST},
        [60845332] = {quest=38383, currency=ARTIFACT, label=CHEST_SM},
    },
    [636] = { -- Stormscale Cavern, Stormheim
        [20134125] = {quest=38529, currency=ARTIFACT, label=CHEST},
    },
    [631] = { -- NarthalasAcademy, Azsuna
        [53633986] = {quest=42284, currency=ARTIFACT, label=CHEST_SM},
        [71212211] = {quest=42285, currency=ARTIFACT, label=CHEST_SM, note="Door opens after you finish nearby quests"},
    },
    [633] = { -- TempleofaThousandLights, Azsuna
    },
    [632] = { -- OceanusCove, Azsuna
        [69294839] = {quest=37649, currency=ARTIFACT, label=CHEST_GLIM},
        [45346686] = {quest=42291, currency=ARTIFACT, label=CHEST_SM},
    },
    [651] = { -- BitestoneEnclave, Highmountain
        [85213787] = {quest=40489, currency=ARTIFACT, label=CHEST},
    },
    [655] = { -- LifespringCavern, Lower, Highmountain
        [39505740] = {quest=40476, currency=ARTIFACT, label=CHEST_GLIM},
    },
    [656] = { -- LifespringCavern, Upper, Highmountain
        [61703450] = {quest=40476, currency=ARTIFACT, label=CHEST_GLIM},
    },
    [659] = { -- StonedarkGrotto, Highmountain
        [35987235] = {quest=40478, currency=ARTIFACT, label=CHEST},
    },
    [654] = { -- MucksnoutDen, Highmountain
        [60592533] = {quest=40494, currency=ARTIFACT, label=CHEST},
    },
    [750] = { -- ThunderTotem, Highmountain
        [13715555] = {quest=40491, currency=ARTIFACT, label=CHEST_SM},
        [63435929] = {quest=39531, item=141322, label="A Steamy Jewelry Box"},
        [50667537] = {quest=40472, currency=ARTIFACT, label=CHEST_SM},
        [32354174] = {quest=40475, currency=ARTIFACT, label=CHEST_SM, note="On a boat"},
        [31843842] = {quest=44352, currency=ARTIFACT, label=CHEST, note="Underwater cave, below the boat"},
    },
    [652] = { -- ThunderTotemInterior, Highmountain
        [62946793] = {quest=40471, currency=ARTIFACT, label=CHEST},
    },
    [657] = { -- Path of Huln, floor 1, Highmountain
        [52002890] = path(39606, "Titan Waygate"),
        [59304130] = {quest=39606, currency=ARTIFACT, label="Treasures of Deathwing", note="Take the Waygate to get up, and use the brazier"},
        [40215031] = {quest=40509, currency=ARTIFACT, label=CHEST},
        [60425458] = {quest=40508, currency=ARTIFACT, label=CHEST_SM},
    },
    [658] = { -- Path of Huln, floor 2, Highmountain
    },
    [682] = { -- Felsoul Hold, Suramar ("SuramarLegionScar")
        [40502903] = {quest=40902, currency=ARTIFACT, label=CHEST_SM},
        [54573780] = {quest=43835, currency=ARTIFACT, label=CHEST_SM},
    },
    [684] = { -- Temple of Fal'adora, Suramar
        [35525280] = {quest=43988, item=140328, label="Volatile Leyline Crystal", note="Downstairs"},
        [38605414] = {quest=43838, currency=ARTIFACT, label=CHEST_SM, note="Downstairs"},
    },
    [685] = { -- Falanaar Tunnels, Suramar
        [58307020] = {quest=43840, currency=ARTIFACT, label=CHEST}, -- also triggered 43839
        [35513253] = {quest=43747, item=141655, label="Shimmering Ancient Mana Cluster"},
        [48644258] = {quest=43839, currency=ARTIFACT, label=CHEST_SM, note="Climb spiderweb"}, -- TODO: verify location
    },
    [686] = { -- Elor'shan
        [49301730] = {quest=43743, item=141655, label="Shimmering Ancient Mana Cluster"},
    },

    -- DH starter
    [672] = { -- Mardum the Shattered Abyss
        [23065389] = {quest=40797, item=129210, label=CHEST_SM, note="Cave entrance @ 23.6, 54.2"},
        [23605420] = path(40797),
        [34857020] = {quest=39970, item=129210, label=CHEST_SM},
        [41763761] = {quest=40759, item=129196, label=CHEST_SM},
        [42194916] = {quest=40223, item=129210, label=CHEST_SM},
        [45017785] = {quest=39971, item=129192, label=CHEST_SM},
        [51135079] = {quest=40743, item=129210, label=CHEST_SM},
        [63702360] = {quest=40772, item=129210, label=CHEST_SM}, -- in soul engine
        [66922767] = {quest=39974, item=129210, label=CHEST_SM},
        [69704240] = {quest=39976, item=129210, label=CHEST_SM},
        [73494892] = {quest=39975, item=129195, label=CHEST_SM},
        [74285453] = {quest=39977, item=129210, label=CHEST_SM, note="Cave entrance @ 70.7, 54.0"},
        [70705400] = path(39977),
        [76243899] = {quest=40338, item=129210, label=CHEST_SM},
        [78755047] = {quest=40274, item=129210, label=CHEST_SM},
        [82075043] = {quest=40820, item=129196, label=CHEST_SM},
    },
    [673] = { -- Cryptic Hollow, Mardum
        [48761530] = {quest=39972, item=129196, label=CHEST_SM},
        [54855845] = {quest=39973, item=128946, label=CHEST_SM},
    },
    [674] = { -- Soul Engine, Lower, Mardum
        [46803320] = {quest=40772, item=129210, label=CHEST_SM},
    },
    [675] = {-- Soul Engine, Upper, Mardum
        [49844883] = {quest=40772, item=129210, label=CHEST_SM},
    },
    [677] = { -- Illidari Ward, Vault of the Wardens
        [58693475] = {quest=40909, item=129210, label=CHEST_SM},
        [47325464] = {quest=40910, item=129210, label=CHEST_SM},
    },
    [678] = { -- Vault of the Wardens
        [32104817] = {quest=40911, item=129196, label=CHEST_SM},
        [41506361] = {quest=40914, item=129196, label=CHEST_SM},
        [56994013] = {quest=40913, item=129210, label=CHEST_SM},
        [41413287] = {quest=40912, item=129210, label=CHEST_SM},
    },
    [679] = { -- Warden's Court, Vault of the Wardens
        [24421005] = {quest=40915, item=129210, label=CHEST_SM},
        [23268157] = {quest=40916, item=129210, label=CHEST_SM},
    },
}


local merge = function(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
end

merge(LegionTreasures.points[630], { -- Azsuna
    [29255365] = {quest=42417, npc=107327, item=129079}, -- Bilebrain
    [30784800] = {quest=42286, npc=107136, item=141873}, -- Houndmaster Stroxis
    [32302970] = {quest=38238, npc=91187, item=129067, note="Patrols the beach"}, -- Beacher
    [32604880] = {quest=44108, npc=109504, item=129075}, -- Ragemaw
    [33404120] = {quest=44670, npc=107105, item=141869}, -- Broodmother Lizax
    [34953390] = {quest=42505, npc=107657, item=141868, note="Walks around the pool"}, -- Arcanist Shal'iman
    [35305030] = {quest=38037, npc=90803, item=129083, note="Cache of Infernals"}, -- Infernal Lord
    [37404320] = {quest=42280, npc=107113, item=141875}, -- Vorthax
    [41054180] = {quest=37537, npc=89016, item=129080}, -- Ravyn-Drath
    [43152815] = {quest=38352, npc=91579, item=129056}, -- Doomlord Kazrok
    [43532458] = {quest=42069, npc=105938, item=129087}, -- Felwing
    [45305780] = {quest=37824, npc=89884, item=129090}, -- Flog the Captain-Eater
    [47203420] = {quest=37726, npc=89650, item=129082}, -- Valiyaka the Stormbringer
    [49105520] = {quest=37909, npc=90164, item=129069, note="Patrols the road"}, -- Warbringer Mox'na
    [49500880] = {quest=37928, npc=90217, item=129061}, -- Normantis the Deposed
    [50003440] = {quest=37823, npc=89865, item=129072}, -- Mrrgrl the Tidereaver
    [50803160] = {quest=37869, npc=90057, item=129084}, -- Daggerbeak
    [52402305] = {quest=38268, npc=91289, item=129063}, -- Cailyn Paledoom
    [53404400] = {quest=37821, npc=89846, item=129066}, -- Captain Volo'ren
    [55104590] = {quest=42450, npc=107127, item=129086}, -- Brawlgoth
    [55476980] = {quest=42699, npc=108255, item=141877}, -- Coura, Mistress of Arcana
    [56102905] = {quest=38061, npc=90901, item=138395}, -- Pridelord Meowl
    [58517882] = {quest=44671, npc=108136, item=129081}, -- The Muscle
    [59304630] = {quest=38212, npc=91100, item=129068, note="Top of the mountain"}, -- Brogozog
    [59601230] = {quest=37932, npc=90244, item=129085, note="Unbound rift"}, -- Arcavellus
    [59705520] = {quest=37822, npc=89850, item=129065}, -- The Oracle
    [61306200] = {quest=38217, npc=91113, item=129062}, -- Tide Behemoth
    [65164000] = {quest=37820, npc=89816, item=129091, note="Horn of the Siren"}, -- Golza the Iron Fin
    [65555680] = {quest=42221, npc=106990, item=129073}, -- Chief Bitterbrine
    [67105140] = {quest=37989, npc=90505, item=129064}, -- Syphonus
})
merge(LegionTreasures.points[650], { -- Highmountain
    [36751635] = {quest=40084, npc=98299, item=131799}, -- Bodash the Hoarder
    [37704570] = {quest=40405, npc=97449, item=131761}, -- Bristlemaul
    [40955775] = {quest=39963, npc=97793, item=131773, note="Abandoned Fishing Pole"}, -- Flamescale
    [41503185] = {quest=40175, npc=98890, item=131921}, -- Slumber
    [41954150] = {quest=39782, npc=97203, item=129175, note="Abandoned Fishing Pole"}, -- Tenpak Flametotem
    [43164800] = {quest=40413, npc=100230, item=131781, note="Loot chest afterwards"}, -- Amateur hunters (100230, 100231, 100232)
    [44201210] = {quest=39994, npc=97933, item=131798, note="Wanders a bit"}, -- Crab Rider Grmlrml
    [45705500] = {quest=40681, npc=101077, item=131730}, -- Sekhan
    [46500745] = {quest=40096, npc=98311, item=131797}, -- Mrrklr
    [46653145] = {quest=39646, npc=96410, item=131900, note="Abandoned Fishing Pole"}, -- Majestic Elderhorn
    [48404015] = {quest=39806, npc=97345, item=131809, note="1/4 of slow fall toy", toy=true}, -- Crawshuk the Hungry
    [48502545] = {quest=39646, npc=96410, item=131900, note="Wanders a bit"}, -- Majestic Elderhorn
    [48605000] = {quest=39784, npc=97215, item=131756, note="Help him tame Arru, loot inside the cave afterwards"}, -- Beastmaster Pao'lek
    [49202710] = {quest=40242, npc=96621, item=131808}, -- Mellok, Son of Torok 
    [50803460] = {quest=40406, npc=98024, item=131776, note="In cave"}, -- Luggut the Eggeater
    [51052570] = {quest=39762, npc=97093, item=131791}, -- Shara Felbreath
    [51054825] = {quest=39802, npc=97326, item=138783}, -- Hartli the Snatcher
    [51453190] = {quest=39465, npc=95872, item=131769}, -- Skullhat
    [53755125] = {quest=39872, npc=97653, item=131800, note="Loot chest afterwards"}, -- Taurson
    [54404110] = {quest=40414, npc=100495, item=131780, note="Cave entrance @ 55.1, 44.3. Blow out candles."}, -- Devouring Darkness
    [55104430] = LegionTreasures.path(40414),
    [54447454] = {quest=40773, npc=101649, item=1220}, -- Frostshard
    [54504060] = {quest=39866, npc=97593, item=131792, note="Top of mountain"}, -- Mynta Talonscreech
    [56357250] = {quest=39235, npc=94877, item=138396}, -- Brogrul the Mighty
    [56406050] = {quest=40347, npc=96590, item=131775, note="Wanders a bit"}, -- Gurbog da Basher
    [52405850] = {quest=40423, npc=109498, item=131767, note="Use the Seemingly Unguarded Treasure to summon the Unethical Adventurers"}, -- Unethical Adventurers
})
merge(LegionTreasures.points[634], { -- Stormheim
    [36505250] = {quest=38472, npc=92152, item=138418}, -- Whitewater Typhoon
    [38454305] = {quest=38626, npc=92599, item=129101}, -- Bloodstalker Alpha
    [40657240] = {quest=38424, npc=91892, item=129113}, -- Thane Irglov the Merciless
    [41456700] = {quest=38333, npc=91529, item=129291}, -- Glimar Ironfist
    [41753410] = {quest=40068, npc=98188, item=132898, note="Cave under the statue's axe"}, -- Egyl the Enduring
    [45857735] = {quest=38431, npc=91874, item=129048}, -- Bladesquall
    [46808405] = {quest=38425, npc=91803, item=129206}, -- Fathnyr
    [47154985] = {quest=38774, npc=93166, item=129163}, -- Tiptog the Lost
    [49507175] = {quest=38423, npc=91795, item=129208}, -- Stormdrake Matriarch
    [51607465] = {quest=42591, npc=107926, item=138417}, -- Hannval the Butcher
    [54802940] = {quest=42437, npc=107487, item=130132}, -- Starbuck
    [58004515] = {quest=38642, npc=92685, item=129123}, -- Captain Brvet
    [58353390] = {quest=43342, npc=110363, item=139387}, -- Roteye
    [59806805] = {quest=39031, npc=92751, item=132895}, -- Ivory Sentinel
    [61554335] = {quest=40081, npc=98268, item=129199}, -- Tarben
    [62056050] = {quest=39120, npc=94413, item=129133}, -- Isel the Hammer
    [63707420] = {quest=37908, npc=90139, item=140686}, -- Inquisitor Ernstenbok
    [64805175] = {quest=38847, npc=93401, item=129219}, -- Urgev the Flayer
    [67303990] = {quest=38685, npc=92763, item=129041}, -- The Nameless King
    [72504990] = {quest=38837, npc=93371, item=129035}, -- Mordvigbjorn
    [73454765] = {quest=40109, npc=98421, item=138419}, -- Kottr Vondyr
    [73906060] = {quest=43343, npc=94347, item=130134, faction="Alliance"}, -- Dread-Rider Cortis
    [78606115] = {quest=40113, npc=98503, item=138421}, -- Grrvrgull the Conqueror
})
merge(LegionTreasures.points[680], { -- Suramar
    --[67065161] = {quest=99999, npc=, item=1220, note="marked as rare but seems to have no questID yet"}, -- Broodmother Shu'malis
    [13555345] = {quest=44124, npc=112802, item=140949}, -- Mar'tura
    [16552655] = {quest=43996, npc=103841, item=140401}, -- Shadowquill
    [18606105] = {quest=43542, npc=110824, item=140399}, -- Tideclaw
    [22155180] = {quest=41319, npc=99792, item=121806}, -- Elfbane
    [24052540] = {quest=43484, npc=105547, item=121759}, -- Rauren
    [24403515] = {quest=44071, npc=112497, item=139897}, -- Maia the White Wolf
    [24554740] = {quest=43449, npc=110577, item=140388}, -- Oreth the Vile
    [26104075] = {quest=42831, npc=109054, item=139926}, -- Shal'an
    [27756545] = {quest=43992, npc=110832, item=121747, note="Portal Key"}, -- Gorgroth
    [29405330] = {quest=44676, npc=113368, item=138839, note="Cave entrance @ 29.3, 50.7"}, -- Llorian
    [29305070] = LegionTreasures.path(44676),
    [33705125] = {quest=43954, npc=111197, item=140934}, -- Anax
    [33801510] = {quest=43717, npc=106351, item=140372}, -- Artificer Lothaire
    [34156100] = {quest=43351, npc=110024, item=140386}, -- Mal'Dreth the Corruptor
    [35256725] = {quest=44675, npc=106526, item=141866}, -- Lady Rivantas
    [36203380] = {quest=43718, npc=111329, item=140390}, -- Matron Hagatha
    [38052280] = {quest=43369, npc=110438, item=140406}, -- Siegemaster Aedrin
    [40953280] = {quest=43358, npc=110340, item=121739}, -- Myonix
    [42058005] = {quest=43348, npc=109954, item=140405}, -- Magister Phaedris
    [42155640] = {quest=43580, npc=110870, item=121754}, -- Apothecary Faldren
    [48055635] = {quest=40905, npc=102303, item=121735}, -- Lieutenant Strathmar
    [49607900] = {quest=43603, npc=111007, item=140396}, -- Randril
    [53203020] = {quest=40897, npc=99610, item=121755}, -- Garvrulg
    [54455610] = {quest=43792, npc=111651, item=121808}, -- Degren
    [54806375] = {quest=43794, npc=111649, item=139918}, -- Ambassador D'vwinn
    [61005300] = {quest=43597, npc=110944, item=140404, note="Wanders a bit"}, -- Guardian Thor'el
    [61653960] = {quest=43993, npc=103223, item=121737}, -- Hertha Grimdottir
    [62506370] = {quest=43793, npc=111653, item=121810}, -- Miasu
    [62554810] = {quest=43495, npc=110726, item=139969}, -- Cadraeus
    [65555915] = {quest=43481, npc=110656, item=140403}, -- Arcanist Lylandre
    [66656715] = {quest=43968, npc=107846, item=140314, toy=true}, -- Pinchshank
    [67657105] = {quest=41136, npc=103214, item=140381, note="Cave entrance @ 72.4, 68.1"}, -- Har'kess the Insatiable
    [72406810] = LegionTreasures.path(41136),
    [68155895] = {quest=41135, npc=100864, item=139952, note="Cave entrance @ 69.9, 57.0"}, -- Cora'Kar
    [69905700] = LegionTreasures.path(41135),
    [75505730] = {quest=44003, npc=103575, item=121801}, -- Reef Lord Raj'his
    [80157000] = {quest=40680, npc=103183, item=140019, note="Wanders along the underwater trench"}, -- Rok'nash
    [87856250] = {quest=41786, npc=103827, item=140384}, -- King Morgalash
})
merge(LegionTreasures.points[641], { -- Val'sharah
    [34405830] = {quest=39121, npc=94414, item=141876}, -- Kiranys Duskwhisper
    [38055280] = {quest=38772, npc=92423, item=130136}, -- Theryssia
    [41657825] = {quest=38479, npc=92180, item=130171}, -- Seersei
    [44155210] = {quest=38767, npc=92965, item=130166, note="Bottom floor"}, -- Darkshade
    [45608880] = {quest=43446, npc=110562, item=130135}, -- Bahagar
    [47205800] = {quest=39357, npc=95221, item=130214}, -- Mad Henryk
    [52808750] = {quest=38889, npc=93686, item=128690, note="Shivering Ashmaw Cub"}, -- Jinikki the Puncturer
    [58753400] = {quest=40080, npc=93030, item=1220}, -- Ironbranch
    [59757745] = {quest=38468, npc=92117, item=130154, note="Talk to Lorel Sagefeather"}, -- Gorebeak
    [60304425] = {quest=39858, npc=97517, item=130125}, -- Dreadbog
    [60359065] = {quest=38887, npc=93654, item=130115, note="Talk to Elindya Featherlight, then follow her"}, -- Skul'vrax
    [61056940] = {quest=39596, npc=95318, item=130137}, -- Perrexx the Corruptor
    [61802955] = {quest=40079, npc=98241, item=130118}, -- Lyrath Moonfeather
    [62604750] = {quest=38780, npc=93205, item=130121}, -- Thondrax
    [65805345] = {quest=40126, npc=95123, item=130122}, -- Grelda the Hag
    [66853685] = {quest=39856, npc=97504, item=130116}, -- Wraithtalon
    [67156960] = {quest=43176, npc=109708, item=130133}, -- Undergrell Attack
    [67504510] = {quest=39130, npc=94485, item=130168}, -- Pollous the Fetid
})
merge(LegionTreasures.points[649], { -- Helheim
    [28156375] = {quest=39870, npc=97630, item=129188, pet=true}, -- Soulthirster
    [85105030] = {quest=38461, npc=92040, item=129044}, -- Fenri
})
merge(LegionTreasures.points[633], { -- TempleofaThousandLights
    [62303090] = {quest=42699, npc=108255, item=141877}, -- Coura, Mistress of Arcana
})
merge(LegionTreasures.points[658], { -- Path of Huln, floor 2, Highmountain
    [54508400] = {quest=48381, npc=125951, item=141708}, -- Obsidian Deathwarder
})

-- Broken Shore:
merge(LegionTreasures.points[646], { -- Broken Shore
    [31315933] = {quest=47028, npc=121112}, -- Somber Dawn
    [39194241] = {quest=46095, npc=117091}, -- Felmaw Emberfiend
    [39553265] = {quest=46965, npc=121029, note="Inside Blood Nest", alpha=0.4}, -- Brood Mother Nix
    [40348045] = {quest=46202, npc=118993}, -- Dreadeye
    [40385977] = {quest=46951, npc=120998, note="Inside the Pit of Agony", alpha=0.4}, -- Flllurlokkr
    [41601723] = {quest=47026, npc=121107}, -- Lady Eldrathe
    [42404282] = {quest=46092, npc=117094}, -- Malorus the Soulkeeper
    [44645317] = {quest=46304, npc=119629, outdoors_only=true, item=142233, mount=true}, -- Lord Hel'Nurath
    [49114800] = {quest=46100, npc=117090}, -- Xorogun the Flamecarver
    [49553794] = {quest=46097, npc=117136}, -- Doombringer Zar'thoz
    [51814293] = {quest=46093, npc=117086}, -- Emberfire
    [54027882] = {quest=46953, npc=121016}, -- Aqueux
    -- [54564848] = {quest=nil, npc=120968}, -- Bonegnasher the Petrifying
    [57085649] = {quest=46094, npc=117096}, -- Potionmaster Gloop
    [57793148] = {quest=46098, npc=117095}, -- Dreadblade Annihilator
    [58294288] = {quest=46099, npc=117093}, -- Felbringer Xar'thok
    [59692724] = {quest=46090, npc=117141, note="Inside Felbreach Hollow", alpha=0.4}, -- Malgrazoth
    [60474504] = {quest=46313, npc=119718}, -- Imp Mother Bruva
    [60965330] = {quest=46101, npc=116953}, -- Corrupted Bonebreaker
    [61913840] = {quest=46096, npc=117089}, -- Inquisitor Chillbane
    [64443020] = {quest=47068, npc=116166, note="Inside Felsworn Vault", alpha=0.4}, -- Eye of Gurgh
    [65233182] = {quest=46091, npc=117140, outdoors_only = true,}, -- Salethan the Broodwalker
    [77842292] = {quest=46995, npc=121037}, -- Grossir 
    [78322747] = {quest=47036, npc=121134}, -- Duke Sithizi
    [78334004] = {quest=47001, npc=121046}, -- Brother Badatin
    [89473084] = {quest=46102, npc=117103}, -- Felcaller Zelthae
    [89913238] = {quest=47090, npc=117471}, -- Si'vash
})

-- Argus:
merge(LegionTreasures.points[830], { -- Krokuun
    [33007600] = {quest=48562, npc=122912}, -- Commander Sathrenael
    [38145920] = {quest=48563, npc=122911, item=153299, note="Either go through the Xenedar, or climb up from 42, 57.1"}, -- Commander Vecaya
    [41707020] = {quest=48666, npc=125820}, -- Imp Mother Laglath
    [50301730] = {quest=48561, npc=125824, item=153316}, -- Khazaduum
    [44505870] = {quest=48564, npc=124775, item=153255}, -- Commander Endaxis
    [53403090] = {quest=48565, npc=123464, item=153124, toy=true}, -- Sister Subversia
    [55508020] = {quest=48628, npc=123689, item=153329}, -- Talestra the Vile
    [58007480] = {quest=48627, npc=120393}, -- Siegemaster Voraan
    [60802080] = {quest=48629, npc=125388, item=153114}, -- Vagath the Betrayed
    [69605750] = {quest=48664, npc=124804, item=153263}, -- Tereck the Selector
    [69708050] = {quest=48665, npc=125479}, -- Tar Spitter
    [70503370] = {quest=48667, npc=126419, item=153190}, -- Naroua
	[55947421] = { object = 277344, },
	[75186978] = { object = 277343, },
	[57506350] = { },
	[59267343] = { },
	[57005471] = { },
	[50206670] = { },
	[71366154] = { },

	[52707610] = { },
	[53107310] = { },
	[56807220] = { },
	[58207180] = { },
	[59307330] = { },
	[60207600] = { },
	[58607985] = { quest=47753 },
	[58108050] = { },
	[56208050] = { },
	[55208110] = { },
	
	[43806700] = { },
	[43806970] = { },
	[45906790] = { },
	[46906820] = { },
	[45807300] = { },
	[48267376] = { quest=47997 },
	[49707580] = { },
	[45907740] = { },
	[46807980] = { },
	[46608340] = { },
	[46508510] = { },
	[46508660] = { },
	[44208650] = { },
	[42508770] = { },
	[42708580] = { },
	[41608380] = { },
	[41107990] = { },
	[42707550] = { },
	[40607530] = { },
	[40307410] = { },
	
	[59705210] = { },
	[58505060] = { },
	[57005470] = { },
	[56705860] = { },
	[55505850] = { },
	[52005950] = { },
	[51405950] = { },
	[49605880] = { },
	[50405130] = { },
	[52205420] = { },
	[53235096] = { quest=47752 },
	[55505230] = { },
	
	[59101880] = { },
	[60901870] = { },
	[66902570] = { },
	[66702500] = { },
	[65902290] = { },
	[64602320] = { },
	[62502590] = { },
	[60402360] = { },
	[57702620] = { },
	[60802870] = { },
	[60502790] = { },
	[58502880] = { },
	[59503050] = { },
	[62303210] = { },
	[60603320] = { },
	[59503280] = { },
	[61603520] = { },
	[62703800] = { },
	[62504170] = { },
	[59604420] = { },
	[59703950] = { },
	[58303630] = { },
	[55903680] = { },
	[55503590] = { },
	[54803180] = { },
	[54003040] = { },
	[52003680] = { },
	[51603580] = { },
	[49803670] = { },
	[46223621] = { },
	[47702890] = { },
	[48703100] = { },
	[48403350] = { },
	[49103360] = { },
	[51103220] = { },

	[36507610] = { },
	[36907430] = { },
	[37807370] = { },
	[32107450] = { },
	[31907290] = { },
	[28307130] = { },
	[28607050] = { },
	[26106810] = { },
	[27206680] = { },
	[31906750] = { },
	[30306410] = { },
	[29605770] = { },
	[36506760] = { },
	[37106410] = { },
	[34606300] = { },
	[40606070] = { },
	[41385831] = { },
	[40505550] = { },
	[38905910] = { },
	[38705720] = { },
	[36605890] = { },
	[36805620] = { },
	[36205540] = { },
	[35405630] = { },
	[33605520] = { },
	[29605770] = { },
	
	[70503070] = { },
	[72303250] = { },
	[73503430] = { },
	[72503600] = { },
	[67703460] = { },
	[65903510] = { },
	[68503880] = { },
	[64904210] = { },
	[63104250] = { },
	[61806420] = { },
	[61306650] = { },
	[54606590] = { },
	[53956768] = { },
	[52906280] = { },
	[51606350] = { },
	[46206180] = { },
	[45805850] = { },
	[43505520] = { },
	[43505080] = { },
	[46404910] = { },
	[46304650] = { },
	[44904350] = { },
	[46104070] = { },
	[47604190] = { },
})

merge(LegionTreasures.points[885], { -- Antoran Wastes
    [50905530] = {quest=48820, npc=127118}, -- Worldsplitter Skuul
    [52702950] = {quest=48822, npc=127291}, -- Watcher Aival
    [53103580] = {quest=48810, npc=126199, item=152903, mount=true}, -- Vrax'thul
    [54003800] = {quest=48966, npc=127581, item=153195, pet=true, note="Gather bones in Scavenger's Boneyard"}, -- The Many-Faced Devourer
    [55702190] = {quest=48824, npc=127300, item=153319}, -- Void Warden Valsuran
    [56204550] = {quest=49241, npc=122999}, -- Gar'zoth
    [57403290] = {quest=49240, npc=122947, item=153327}, -- Mistress Il'thendra
    [58001200] = {quest=48968, npc=127703, note="3 people on the runes to summon; don't interrupt Doom Star"}, -- Doomcaster Suprax
    [60575159] = {quest=48816, npc=127084, note="Use the portal slightly west from him at 80, 62.4"}, -- Commander Texlaz
    [60674831] = {quest=48815, npc=126946, item=151543}, -- Inquisitor Vethroz
    [60902290] = {quest=48865, npc=127376}, -- Chief Alchemist Munculus
    [61703720] = {quest=49183, npc=122958, item=152905, mount=true}, -- Blistermaw
    [61906430] = {quest=48814, npc=126338}, -- Wrath-Lord Yarez
    [62405380] = {quest=48813, npc=126254}, -- Lieutenant Xakaar
    [63102520] = {quest=48821, npc=127288, item=152790, mount=true}, -- Houndmaster Kerrax
    [63225754] = {quest=48811, npc=126115, note="The entrance to the cave is north east from her in the spider area at 66, 54.1"}, -- Ven'orn
    [63902090] = {quest=48809, npc=126040, note="Entrance to the cave is south east - use the eastern bridge to get there."}, -- Puscilla
    [64304820] = {quest=48812, npc=126208, item=153190}, -- Varga
    [66981777] = {quest=48970, npc=127705, item=153252, pet=true}, -- Mother Rosula
    [73207080] = {quest=48817, npc=127090, item=153324}, -- Admiral Rel'var
    [75605650] = {quest=48818, npc=127096}, -- All-Seer Xanarian
	[69013346] = {},
	[71195442] = { },
	[72185677] = { },
	[76695809] = { },
	[75605266] = { },
	
	[65903980] = { },
	[52202720] = { },
	[58805920] = { },
	[49005930] = { },

	[58704330] = { },
	[60204360] = { },
	[60604090] = { },
	[60404690] = { },
	[62104580] = { },
	[64204230] = { },
	[64604010] = { },
	[64204710] = { },
	[62905000] = { },
	[64305030] = { },
	[65205170] = { },
	[65504090] = { },

	[71105450] = { },
	[69805520] = { },
	[68005060] = { },
	[67404780] = { },
	[66604670] = { },
	[65304950] = { },
	[65105060] = { },
	[65105500] = { },
	[63505620] = { },
	[63105750] = { },
	[64105860] = { },
	
	[59601390] = { },
	[59301750] = { },
	[55901400] = { },
	[55901720] = { },
	[55502050] = { },
	[56002660] = { },
	[54202790] = { },
	[51502600] = { },
	
	[72205680] = { },
	[76505660] = { },
	[78005610] = { },
	[76605810] = { },
	[77205890] = { },
	[80506160] = { },
	[82606510] = { },
	[82506750] = { },
	[81306860] = { },
	[77207510] = { },
	[72607270] = { },
	[73406860] = { },
	[76506480] = { },
	[77306410] = { },
	
	[65502850] = { },
	[63703650] = { },
	[66703640] = { },
	[68903350] = { },
	[68004020] = { },
	[69503950] = { },
	[72504210] = { },
	[73504670] = { },
})
merge(LegionTreasures.points[833], { -- Nath'raxas Spire
    [38954032] = {quest=48561, npc=125824, item=153316}, -- Khazaduum
})

merge(LegionTreasures.points[882], { -- MacAree
    [27202980] = {quest=48707, npc=126869}, -- Captain Faruq
    [30304040] = {quest=48709, npc=127323, item=153056, pet=true}, -- Ataxon
    [33704750] = {quest=48705, npc=126867, item=152844, mount=true}, -- Venomtail Skyfin
    [35203720] = {quest=48708, npc=126885}, -- Umbraliss
    [35505870] = {quest=48711, npc=126896, note="On the 2nd floor."}, -- Herald of Chaos
    [36302360] = {quest=48703, npc=126865}, -- Vigilant Thanos
    [38705580] = {quest=48697, npc=126860, item=153190}, -- Kaara the Pale
    [39716420] = {quest=48706, npc=126868, note="Inside the building"}, -- Turek the Lucid
    [41301160] = {quest=48702, npc=126864, item=152998}, -- Feasel the Muffin Thief
    [43806020] = {quest=48700, npc=126862, item=153193, toy=true}, -- Baruut the Bloodthirsty
    [44204980] = {quest=48712, npc=126898, item=153190}, -- Sabuul
    [44607160] = {quest=48692, npc=122838}, -- Shadowcaster Voruun
    [48504090] = {quest=48713, npc=126899}, -- Jed'hin Champion Vorusk
    [49505280] = {quest=48935, npc=126913, item=153203}, -- Slithon the Last
    [49700990] = {quest=48721, npc=126912, item=152904, mount=true}, -- Skreeg the Devourer
    [55705990] = {quest=48695, npc=126852, item=152814, mount=true}, -- Wrangler Kravos
    [56801450] = {quest=48720, npc=126910}, -- Commander Xethgar
    [58003090] = {quest=48716, npc=125497}, -- Overseer Y'Sorna
    [59203770] = {quest=48714, npc=124440}, -- Overseer Y'Beda
    [60402970] = {quest=48717, npc=125498}, -- Overseer Y'Morna
    [61405020] = {quest=48718, npc=126900, item=153181, toy=true, note="Can drop three different scroll toys"}, -- Instructor Tarahna
    [63806460] = {quest=48704, npc=126866}, -- Vigilant Kuro
    [64002950] = {quest=48719, npc=126908}, -- Zul'tan the Numerous
    [52796704] = {quest=48693, npc=126815}, -- Soultwisted Monstrosity
    [70404670] = {quest=48710, npc=126889}, -- Sorolis the Ill-Fated
	[35303588] = {  },
	[32912386] = {  },
	[47206250] = {  },
	[48106150] = {  },
	[52806170] = {  },
	[54905760] = {  },
	[57506170] = {  },
	[59506390] = {  },
	[59806970] = {  },
	[60907060] = {  },
	[54806700] = {  },
	[53006650] = {  },
	[50906720] = {  },
	[51807140] = {  },
	[50107590] = {  },
	[52808250] = {  },
	[53208000] = {  },
	[55107780] = {  },
	[55407350] = {  },
	[57507510] = {  },

	[53902320] = {  },
	[54902500] = {  },
	[53502750] = {  },
	[53603450] = {  },
	[55003520] = {  },
	[58704070] = {  },
	[60503350] = {  },
	[60503200] = {  },
	[62302630] = {  },
	[63302250] = {  },
	[63301990] = {  },
	[59502090] = {  },

	[47507080] = {  },
	[46907330] = {  },
	[46007220] = {  },
	[44506870] = {  },
	[43706840] = {  },
	[43607150] = {  },
	[41106890] = {  },
	[38506700] = {  },
	[36306640] = {  },
	[34206560] = {  },
	[38506440] = {  },
	[38106360] = {  },
	[37206270] = {  },
	[37106100] = {  },
	[37805870] = {  },
	[39205920] = {  },
	[40506280] = {  },
	[41606330] = {  },
	[42406150] = {  },
	[43506010] = {  },
	[42305750] = {  },
	[44005650] = {  },
	[42605380] = {  },
	[40505550] = {  },
	[37205550] = {  },
	[35705620] = {  },
	[33805550] = {  },
	[34205750] = {  },
	[34305920] = {  },
	[35605710] = {  },

	[67202820] = {  },
	[66502900] = {  },
	[64902950] = {  },
	[62003280] = {  },
	[67803190] = {  },
	[69503270] = {  },
	[70103380] = {  },
	[68803710] = {  },
	[65303560] = {  },
	[68504130] = {  },
	[65504190] = {  },
	[69504490] = {  },
	[67204620] = {  },
	[66004690] = {  },
	[68404890] = {  },
	[69604960] = {  },
	[70505110] = {  },
	[68505310] = {  },
	[67205370] = {  },
	[67205690] = {  },
	[65906010] = {  },
	[64505950] = {  },
	[64605600] = {  },
	[61505550] = {  },
	[62905050] = {  },
	[63804530] = {  },
	[59804660] = {  },
	[60904370] = {  },
	[61904270] = {  },
	[62204080] = {  },

	[58701330] = {  },
	[58001060] = {  },
	[53300850] = {  },
	[55001740] = {  },
	[52601630] = {  },
	[50001420] = {  },
	[48201210] = {  },
	[46101320] = {  },
	[46501510] = {  },
	[45101350] = {  },
	[44701850] = {  },
	[42501790] = {  },
	[47901970] = {  },
	[47602190] = {  },
	[48602110] = {  },
	[45102480] = {  },
	[49502410] = {  },
	[50002950] = {  },
	[51702860] = {  },

	[19704210] = {  },
	[24703860] = {  },
	[29003380] = {  },
	[25503000] = {  },
	[32604700] = {  },
	[47103660] = {  },
	[49503580] = {  },
	[49003950] = {  },
	[49904160] = {  },
	[53604200] = {  },
	[54704490] = {  },
	[51004770] = {  },
	[48404980] = {  },
	[49805510] = {  },
	[50605580] = {  },
	[59505870] = {  },
})

-- DH starter:
merge(LegionTreasures.points[672], { -- MardumtheShatteredAbyss
    [63502350] = {quest=40231, npc=97058, item=128948}, -- Count Nefarious
    [68852760] = {quest=40234, npc=82877, item=128947}, -- General Volroth
    [74455730] = {quest=40232, npc=97059, item=128944}, -- King Voras
    [81054125] = {quest=40233, npc=97057, item=133580}, -- Overseer Brutarg

})
merge(LegionTreasures.points[674], { -- SoulEngine
    [51255740] = {quest=40231, npc=97058, item=128948}, -- Count Nefarious
})
merge(LegionTreasures.points[677], { -- VaultOfTheWardensDH
    [49553285] = {quest=40251, npc=96997, item=128945}, -- Kethrazor
    [68753630] = {quest=40301, npc=97069, item=128958}, -- Wrath-Lord Lekos
})
