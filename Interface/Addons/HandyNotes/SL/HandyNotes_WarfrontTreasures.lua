local WarfrontTreasures = {}

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HL = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_WarfrontTreasures", "AceEvent-3.0")
-- local L = LibStub("AceLocale-3.0"):GetLocale(myname, true)
WarfrontTreasures.HL = HL


local next = next
local GameTooltip = GameTooltip
local WorldMapTooltip = WorldMapTooltip
local HandyNotes = HandyNotes
local GetItemInfo = GetItemInfo
local GetAchievementInfo = GetAchievementInfo
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementCriteriaInfoByID = GetAchievementCriteriaInfoByID
local GetCurrencyInfo = GetCurrencyInfo

local ARTIFACT_LABEL = '|cffff8000' .. ARTIFACT_POWER .. '|r'

local cache_tooltip = CreateFrame("GameTooltip", "HNBattleTreasuresTooltip")
cache_tooltip:AddFontStrings(
    cache_tooltip:CreateFontString("$parentTextLeft1", nil, "GameTooltipText"),
    cache_tooltip:CreateFontString("$parentTextRight1", nil, "GameTooltipText")
)
local name_cache = {}
local function mob_name(id)
    if not name_cache[id] then
        -- this doesn't work with just clearlines and the setowner outside of this, and I'm not sure why
        cache_tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
        --cache_tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(id))
        if cache_tooltip:IsShown() then
            name_cache[id] = HNBattleTreasuresTooltipTextLeft1:GetText()
        end
    end
    return name_cache[id]
end

local default_texture, npc_texture, follower_texture, currency_texture, junk_texture
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
        end
        local _, achievement = GetAchievementInfo(point.achievement)
        if achievement then
            return achievement
        end
        fallback = 'achievement:'..point.achievement
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
            icon_cache[point.atlas] = atlas_texture(point.atlas, point.scale)
        end
        return icon_cache[point.atlas]
    end
    if WarfrontTreasures.db.icon_item then
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
    if point.junk then
        if not junk_texture then
            junk_texture = atlas_texture("VignetteLoot", 1.5)
        end
        return junk_texture
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
    return get_point_info(WarfrontTreasures.points[uiMapID] and WarfrontTreasures.points[uiMapID][coord])
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
        if point.quest and WarfrontTreasures.db.tooltip_questid then
            local quest = point.quest
            if type(quest) == 'table' then
                quest = string.join(", ", unpack(quest))
            end
            tooltip:AddDoubleLine("QuestID", quest or UNKNOWN)
        end

        if (WarfrontTreasures.db.tooltip_item or IsShiftKeyDown()) and (point.item or point.npc) then
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
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end
local handle_tooltip_by_coord = function(tooltip, uiMapID, coord)
    return handle_tooltip(tooltip, WarfrontTreasures.points[uiMapID] and WarfrontTreasures.points[uiMapID][coord])
end

---------------------------------------------------------
-- Plugin Handlers to HandyNotes
local HLHandler = {}
local info = {}

function HLHandler:OnEnter(uiMapID, coord)
    local tooltip = self:GetParent() == WorldMapFrame:GetCanvas() and WorldMapTooltip or GameTooltip
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
    WarfrontTreasures.hidden[uiMapID][coord] = true
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
            info.text         = "HandyNotes - Warfront Treasures"
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
    local HL_Dropdown = CreateFrame("Frame", "HandyNotes_WarfrontTreasuresDropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function HLHandler:OnClick(button, down, uiMapID, coord)
        currentZone = uiMapID
        currentCoord = coord
        -- given we're in a click handler, this really *should* exist, but just in case...
        local point = WarfrontTreasures.points[currentZone] and WarfrontTreasures.points[currentZone][currentCoord]
        if button == "RightButton" and not down then
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        end
    end
end

function HLHandler:OnLeave(uiMapID, coord)
    if self:GetParent() == WorldMapFrame:GetCanvas() then
        WorldMapTooltip:Hide()
    else
        GameTooltip:Hide()
    end
    ShoppingTooltip1:Hide()
end

do
    -- This is a custom iterator we use to iterate over every node in a given zone
    local currentZone, isMinimap
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do -- Have we reached the end of this zone?
            if value and WarfrontTreasures.should_show_point(state, value, currentZone, isMinimap) then
                local label, icon, _, _, _, scale, alpha = get_point_info(value)
                scale = (scale or 1) * (icon and icon.scale or 1) * WarfrontTreasures.db.icon_scale
                return state, nil, icon, scale, WarfrontTreasures.db.icon_alpha * alpha
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
        if minimap and WarfrontTreasures.map_spellids[uiMapID] then
            if WarfrontTreasures.map_spellids[mapFile] == true then
                return iter
            end
            if UnitHasBuff("player", WarfrontTreasures.map_spellids[mapFile]) then
                return iter
            end
        end
        return iter, WarfrontTreasures.points[uiMapID], nil
    end
end

---------------------------------------------------------
-- Addon initialization, enabling and disabling

function HL:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_WarfrontTreasuresDB", WarfrontTreasures.defaults)
    WarfrontTreasures.db = self.db.profile
    WarfrontTreasures.hidden = self.db.char.hidden
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB("HandyNotes_WarfrontTreasures", HLHandler, WarfrontTreasures.options)

    -- watch for LOOT_CLOSED
    self:RegisterEvent("LOOT_CLOSED", "Refresh")
    self:RegisterEvent("ZONE_CHANGED_INDOORS", "Refresh")
end

function HL:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_WarfrontTreasures")
end


WarfrontTreasures.defaults = {
    profile = {
        show_on_world = true,
        show_on_minimap = false,
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

WarfrontTreasures.options = {
    type = "group",
    name ="HandyNotes_WarfrontTreasures",
    get = function(info) return WarfrontTreasures.db[info[#info]] end,
    set = function(info, v)
        WarfrontTreasures.db[info[#info]] = v
        WarfrontTreasures.HL:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_WarfrontTreasures")
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
                        for map,coords in pairs(WarfrontTreasures.hidden) do
                            wipe(coords)
                        end
                        WarfrontTreasures.HL:Refresh()
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
WarfrontTreasures.should_show_point = function(coord, point, currentZone, isMinimap)
    if isMinimap and not WarfrontTreasures.db.show_on_minimap and not point.minimap then
        return false
    elseif not isMinimap and not WarfrontTreasures.db.show_on_world then
        return false
    end
    if point.level and point.level ~= currentLevel then
        return false
    end
    if WarfrontTreasures.hidden[currentZone] and WarfrontTreasures.hidden[currentZone][coord] then
        return false
    end
    if WarfrontTreasures.outdoors_only and IsIndoors() then
        return false
    end
    if point.junk and not WarfrontTreasures.db.show_junk then
        return false
    end
    if point.faction and point.faction ~= player_faction then
        return false
    end
    if (not WarfrontTreasures.db.found) then
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
    -- if (not WarfrontTreasures.db.repeatable) and point.repeatable then
    --     return false
    -- end
    if not point.follower then
        if point.npc then
            if not WarfrontTreasures.db.show_npcs then
                return false
            end
        else
            -- Not an NPC, not a follower, must be treasure
            if not WarfrontTreasures.db.show_treasure then
                return false
            end
        end
    end
    if point.hide_before and not WarfrontTreasures.db.upcoming and not allQuestsComplete(point.hide_before) then
        return false
    end
    return true
end


-- note to self: I like Garr_TreasureIcon...

local merge = function(t1, t2)
    if not t2 then return t1 end
    for k, v in pairs(t2) do
        t1[k] = v
    end
end
WarfrontTreasures.merge = merge

local AZERITE = 1553
local CHEST = 'Treasure Chest'
local CHEST_SM = 'Small Treasure Chest'
local CHEST_GLIM = 'Glimmering Treasure Chest'

local path_meta = {__index = {
    label = "Path to treasure",
    atlas = "map-icon-SuramarDoor.tga", -- 'PortalPurple'
    path = true,
    scale = 1.1,
}}
local path = function(details)
    return setmetatable(details or {}, path_meta)
end
WarfrontTreasures.path = path

WarfrontTreasures.map_spellids = {
    -- [862] = 0, -- Zuldazar
    -- [863] = 0, -- Nazmir
    -- [864] = 0, -- Vol'dun
    -- [895] = 0, -- Tiragarde Sound
    -- [896] = 0, -- Drustvar
    -- [942] = 0, -- Stormsong Valley
}

WarfrontTreasures.points = {
    --[[ structure:
    [uiMapID] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            label=[string], -- label: text that'll be the label, optional
            item=[id], -- itemid
            quest=[id], -- will be checked, for whether character already has it
            currency=[id], -- currencyid
            achievement=[id], -- will be shown in the tooltip
            junk=[bool], -- doesn't count for achievement
            npc=[id], -- related npc id, used to display names in tooltip
            note=[string], -- some text which might be helpful
            hide_before=[id], -- hide if quest not completed
        },
    },
    --]]
    [14] = { -- Zuldazar
    },
}



local merge = WarfrontTreasures.merge
local path = WarfrontTreasures.path

merge(WarfrontTreasures.points[14], { --Arathi
    --World Boss
    [38804140] = {quest=52848, npc=137374,}, -- The Lion's Roar
    [38804140] = {quest=52847, npc=138122,}, -- Doom's Howl

	--Mounts
	[65906790] = {quest=nil, npc=142709, item=163644,}, -- Beastrider Kama
	[56604450] = {quest=nil, npc=142312, item=163645,}, -- Skullripper
	[67406120] = {quest=nil, npc=142692, item=163706,}, -- Nimar the Slayer
	[33003860] = {quest=nil, npc=132074, item=163646,}, -- Overseer Krix
	[49004000] = {quest=nil, npc=142739, item=163578,note="Spawns when Horde have control?"}, -- Knight-Captain Aldrin
	[53805820] = {quest=nil, npc=142741, item=163579,note="Spawns when Alliance have control?"}, -- Doomrider Helgrim

	--Toys
	[47607790] = {quest=nil, npc=132965, item=163775,}, -- Molok the Crusher
	[28904550] = {quest=nil, npc=142684, item=163750,}, -- Kovork
	[62808080] = {quest=nil, npc=142682, item=163745,}, -- Zalas Witherbark
    [48908430] = {quest=nil, npc=135058, item=163744,}, -- Kor'gresh Coldrage
    [43005700] = {quest=nil, npc=142683, item=163741,}, -- Ruul Onestone
    [51224018] = {quest=nil, npc=142690, item=163738,}, -- Singer
    [26703260] = {quest=nil, npc=142725, item=163736,}, -- Horrific Apparition 1
    [19506090] = {quest=nil, npc=142725, item=163736,}, -- Horrific Apparition 2
    [23104670] = {quest=nil, npc=142686, item=163735,}, -- Foulbelly
    [79603030] = {quest=nil, npc=142662, item=163713,}, -- Geomancer Flintdagger

    --Pets
    [21532120] = {quest=nil, npc=126427, item=163650,}, -- Branchlord Aldrus
    [36906600] = {quest=nil, npc=142361, item=163690,}, -- Plaguefeather
    [42006100] = {quest=nil, npc=126462, item=163711,note="Patrols the roads"}, -- Fozruk
    [56705410] = {quest=nil, npc=142301, item=163648,}, -- Venomarus
    [18302760] = {quest=nil, npc=142321, item=163689,}, -- Ragebeak
    [14003690] = {quest=nil, npc=142251, item=163684,}, -- Yogursa
    [52207660] = {quest=nil, npc=142716, item=163712,}, -- Man-Hunter Rog
    [56603600] = {quest=nil, npc=141668, item=163677,}, -- Echo of Myzrael
    [50653690] = {quest=nil, npc=142688, item=163652,}, -- Darbel Montrose

    --Goliaths
    [61933150] = {quest=nil, npc=141618, item=163700,}, -- Cresting Goliath
    [45805280] = {quest=nil, npc=141616, item=163698,}, -- Thundering Goliath
    [29905960] = {quest=nil, npc=140765, item=163701,}, -- Rumbling Goliath
    [30604500] = {quest=nil, npc=141615, item=163691,}, -- Burning Goliath
})