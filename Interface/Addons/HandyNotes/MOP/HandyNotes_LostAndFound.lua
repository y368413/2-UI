---------------------------------------------------------## Author: Kemayo  ## Version: v14 ## SavedVariables: HandyNotes_LostAndFoundDB
-- Addon declaration
HandyNotes_LostAndFound = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_LostAndFound", "AceEvent-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")

---------------------------------------------------------
-- Our db upvalue and db defaults
local db
local defaults = {
    profile = {
        show_lost = true,
        show_riches = true,
        show_junk = true,
        found = false,
        icon_scale = 1.0,
        icon_alpha = 1.0,
        icon_item = true,
    },
}

---------------------------------------------------------
-- Localize some globals
local next = next
local GameTooltip = GameTooltip
local HandyNotes = HandyNotes
local GetItemInfo = GetItemInfo
local GetAchievementInfo = GetAchievementInfo
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo

---------------------------------------------------------
-- Constants

local points = {
    -- [mapFile] = { [coord] = { type=[type], id=[id], junk=[bool], }, }
    -- [] = { item=, }, -- 
    [379] = { -- Kun Lai Summit
        [52907140] = { item=86394, note="in the cave", quest=31413, }, -- Hozen Warrior Spear
        [35207640] = { item=86125, quest=31304, npc=64227, }, -- Kafa Press
        [73107350] = { label="Sprite's Cloth Chest", note="in the cave", quest=31412, },
        [71206260] = { item=88723, note="in Stash of Yaungol Weapons", quest=31421, }, -- Sturdy Yaungol Spear
        [44705240] = { item=86393, quest=31417, }, -- Tablet of Ren Yun
        [64234513] = { item=86471, achievement=7997, quest=31420, note="in the cave" }, -- Ancient Mogu Tablet
        [50366177] = { label="Hozen Treasure Cache", achievement=7997, note="in the cave", quest=31414, },
        [36707970] = { label="Lost Adventurer's Belongings", achievement=7997, quest=31418, },
        [47007300] = { label="Mo-Mo's Treasure Chest", junk=true, quest=31868, },
        [52575154] = { item=86430, achievement=7997, note="in Rikktik's Tiny Chest", quest=31419, }, -- Rikktik's Tick Remover
        [72013396] = { item=86422, achievement=7997, quest=31416, }, -- Statue of Xuen
        [59405300] = { label="Stolen Sprite Treasure", achievement=7997, note="in the cave", quest=31415, },
        [59247303] = { item=86427, achievement=7997, quest=31422, }, -- Terracotta Head
    },
    [382] = { -- KnucklethumpHole, cave in Kun-Lai
        [52002750] = { label="Hozen Treasure Cache", achievement=7997, quest=31414, },
    },
    [383] = { -- TheDeeper, cave in Kun-Lai
        [24106580] = { item=86394, level=12, quest=31413, }, -- Hozen Warrior Spear
    },
    [381] = { -- PrankstersHollow, cave in Kun-Lai
        [54706980] = { label="Sprite's Cloth Chest", quest=31412, },
    },
    [380] = { -- HowlingwindCavern, cave in Kun-Lai
        [41674412] = { label="Stolen Sprite Treasure", achievement=7997, quest=31415, },
    },
    [388] = { -- Townlong Steppes
        [66304470] = { item=86518, quest=31425, }, -- Yaungol Fire Carrier
        [66804800] = { item=86518, quest=31425, }, -- Yaungol Fire Carrier
        [62823405] = { label="Abandoned Crate of Goods", achievement=7997, note="in a tent", quest=31427, },
        [65838608] = { item=86472, achievement=7997, quest=31426, }, -- Amber Encased Moth
        [52845617] = { item=86517, achievement=7997, quest=31424, }, -- Hardened Sap of Kri'vess
        [57505850] = { item=86517, achievement=7997, quest=31424, }, -- Hardened Sap of Kri'vess
        [32806160] = { item=86516, achievement=7997, note="in the cave", quest=31423, }, -- Fragment of Dread
    },
    [389] = { -- Niuzao Catacombs, cave in Townlong
        [56406480] = { item=86516, achievement=7997, quest=31423, }, -- Fragment of Dread
        [36908760] = { item=86516, achievement=7997, quest=31423, }, -- Fragment of Dread
        [48408860] = { item=86516, achievement=7997, quest=31423, }, -- Fragment of Dread
        [64502150] = { item=86516, achievement=7997, quest=31423, }, -- Fragment of Dread
    },
    [376] = { -- Valley of the Four Winds
        [46802460] = { item=85973, npc=64004, quest=31284, }, -- Ancient Pandaren Fishing Charm
        [45403820] = { item=86079, npc=64191, quest=31292, }, -- Ancient Pandaren Woodcutter
        [15402920] = { item=86218, quest=31407, }, -- Staff of the Hidden Master
        [14903360] = { item=86218, quest=31407, }, -- Staff of the Hidden Master
        [17503570] = { item=86218, quest=31407, }, -- Staff of the Hidden Master
        [19103780] = { item=86218, quest=31407, }, -- Staff of the Hidden Master
        [19004250] = { item=86218, quest=31407, }, -- Staff of the Hidden Master
        [43603740] = { label="Cache of Pilfered Goods", quest=31406, },
        [92003900] = { item=87524, junk=true, quest=31869, }, -- Boat-Building Instructions
        [23712833] = { label="Virmen Treasure Cache", achievement=7997, quest=31405, },
        [75105510] = { item=86220, achievement=7997, quest=31408, } -- Saurok Stone Tablet
    },
    [422] = { -- Dread Wastes
        [66306660] = { item=86522, quest=31433, }, -- Blade of the Prime
        [25905030] = { item=86525, quest=31436, note="in the underwater cave", }, -- Bloodsoaked Chitin Fragment
        [30209080] = { item=86524, quest=31435, }, -- Dissector's Staff of Mutation
        [33003010] = { item=86521, quest=31431, }, -- Lucid Amulet of the Agile Mind
        [48703000] = { item=86520, quest=31430, }, -- Malik's Stalwart Spear
        [42206360] = { item=86529, npc=65552, quest=31432, }, -- Manipulator's Talisman on a Glinting Rapana Whelk (65552)
        [56607780] = { item=86523, quest=31434, }, -- Swarming Cleaver of Ka'roz
        [54305650] = { item=86526, quest=31437, }, -- Swarmkeeper's Medallion
        [71803610] = { item=86519, quest=31429, }, -- Wind-Reaver's Dagger of Quick Strikes
        [28804190] = { item=86527, quest=31438, }, -- Blade of the Poisoned Mind
    },
    [418] = { -- Krasarang Wilds
        [42409200] = { item=86122, label="Equipment Locker", quest=31410, }, -- Plankwalking Greaves
        [52308870] = { item=87266, note="in a barrel", quest=31411, }, -- Recipe: Banana Infused Rum
        [50804930] = { item=86124, quest=31409, }, -- Pandaren Fishing Spear
        [52007300] = { item=87798, junk=true, quest=31863, }, -- Stack of Papers
        [71000920] = { item=86220, achievement=7997, note="in the cave", quest=31408, }, -- Saurok Stone Tablet
    },
    [390] = { -- Vale of Eternal Blossoms
        -- nothing?
    },
    [371] = { -- The Jade Forest
        [39400730] = { item=85776, note="in the well", quest=31397, }, -- Wodin's Mantid Shaker
        [39264665] = { item=86199, npc=64272, quest=31307, }, -- Jade Infused Blade
        [43001160] = { item=86198, quest=31403, }, -- Hammer of Ten Thunders
        [41801760] = { item=86198, quest=31403, }, -- Hammer of Ten Thunders
        [41201390] = { item=86198, quest=31403, }, -- Hammer of Ten Thunders
        [46102920] = { item=85777, note="in the cave", quest=31399, }, -- Ancient Pandaren Mining Pick
        [47106740] = { item=86196, quest=31402, }, --Ancient Jinyu Staff
        [46207120] = { item=86196, quest=31402, }, --Ancient Jinyu Staff
        [26223235] = { item=85780, achievement=7997, quest=31400, }, -- Ancient Pandaren Tea Pot
        [31962775] = { item=85781, achievement=7997, quest=31401, }, -- Lucky Pandaren Coin
        [23493505] = { item=86216, achievement=7997, quest=31404, }, -- Pandaren Ritual Stone
        [24005300] = { label="Chest of Supplies", junk=true, quest=31864, },
        [46308070] = { label="Offering of Rememberance", junk=true, quest=31865, },
        [51229999] = { label="Ship's Locker", achievement=7997, quest=31396, },
        [62452752] = { label="Stash of Gems", junk=true, quest=31866, },
    },
    [373] = { -- Greenstone Quarry, cave in Jade Forest
        [33107800] = { item=85777, quest=31399, }, -- Ancient Pandaren Mining Pick
        [44007050] = { item=85777, quest=31399, }, -- Ancient Pandaren Mining Pick
        [43703850] = { item=85777, quest=31399, }, -- Ancient Pandaren Mining Pick
        [38704750] = { item=85777, quest=31399, }, -- Ancient Pandaren Mining Pick
        [32606270] = { item=85777, quest=31399, }, -- Ancient Pandaren Mining Pick
        [38231394] = { item=85777, quest=31399, }, -- Ancient Pandaren Mining Pick
    },
    [433] = { -- Veiled Stair, TheHiddenPass
        [74937648] = { item=86473, achievement=7997, quest=31428, }, -- The Hammer of Folly
        [55107200] = { label="Forgotten Lockbox", junk=true, quest=31867, },
    },
    [554] = { -- Timeless Isle
        -- [] = { label="", quest=, },
    },
}

local cache_tooltip = CreateFrame("GameTooltip", "HNTreasureHunterTooltip")
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
            name_cache[id] = HNTreasureHunterTooltipTextLeft1:GetText()
        end
    end
    return name_cache[id]
end

local default_texture
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
    return UNKNOWN
end
local function work_out_texture(point)
    if point.item and db.icon_item then
        local texture = select(10, GetItemInfo(point.item))
        if texture then
            return trimmed_icon(texture)
        end
    end
    if point.achievement then
        local texture = select(10, GetAchievementInfo(point.achievement))
        if texture then
            return trimmed_icon(texture)
        end
    end
    -- if point.npc then

    -- end
    return trimmed_icon(default_texture)
end
local get_point_info = function(point)
    if not default_texture then
        default_texture = select(10, GetAchievementInfo(7284))
    end
    if point then
        local label = work_out_label(point)
        local icon = work_out_texture(point)
        local category = "treasure"
        if point.achievement == 7997 then
            category = "riches"
        -- elseif point.npc then
        --     category = "npc"
        elseif point.junk then
            category = "junk"
        end
        return label, icon, category, point.quest
    end
end
local get_point_info_by_coord = function(uiMapId, coord)
    return get_point_info(points[uiMapId] and points[uiMapId][coord])
end

local function handle_tooltip(tooltip, point)
    if point then
        -- major:
        if point.label then
            tooltip:AddLine(point.label)
        elseif point.item then
            tooltip:SetHyperlink(("item:%d"):format(point.item))
        elseif point.npc then
            tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(point.npc))
        end

        if point.item and point.npc then
            tooltip:AddDoubleLine(CREATURE, mob_name(point.npc) or point.npc)
        end
        if point.achievement then
            local _, name = GetAchievementInfo(point.achievement)
            tooltip:AddDoubleLine(BATTLE_PET_SOURCE_6, name or point.achievement)
        end
        if point.note then
            tooltip:AddLine(point.note)
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end
local handle_tooltip_by_coord = function(tooltip, uiMapId, coord)
    return handle_tooltip(tooltip, points[uiMapId] and points[uiMapId][coord])
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

do
    local currentZone, currentCoord
    local function generateMenu(button, level)
        if (not level) then return end
        for k in pairs(info) do info[k] = nil end
        if (level == 1) then
            -- Create the title of the menu
            info.isTitle      = 1
            info.text         = "HandyNotes-LostAndFound"
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)

            if TomTom then
                -- Waypoint menu item
                info.disabled     = nil
                info.isTitle      = nil
                info.notCheckable = nil
                info.text = "Create waypoint"
                info.icon = nil
                info.func = createWaypoint
                info.arg1 = currentZone
                info.arg2 = currentCoord
                UIDropDownMenu_AddButton(info, level);
            end

            -- Close menu item
            info.text         = "Close"
            info.icon         = nil
            info.func         = function() CloseDropDownMenus() end
            info.arg1         = nil
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level);
        end
    end
    local HL_Dropdown = CreateFrame("Frame", "HandyNotes_LostAndFoundDropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function HLHandler:OnClick(button, down, uiMapId, coord)
        if button == "RightButton" and not down then
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
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do -- Have we reached the end of this zone?
            if value then
                local label, icon, category, quest = get_point_info(value)
                if (
                    (category ~= "junk" or db.show_junk)
                    and (category ~= "riches" or db.show_riches)
                    and (category ~= "lost" or db.show_lost)
                    and (db.found or not (quest and C_QuestLog.IsQuestFlaggedCompleted(quest)))
                ) then
                    return state, nil, icon, db.icon_scale, db.icon_alpha
                end
            end
            state, value = next(t, state) -- Get next data
        end
        return nil, nil, nil, nil
    end
    function HLHandler:GetNodes2(uiMapId, minimap)
        return iter, points[uiMapId], nil
    end
end

---------------------------------------------------------
-- Options table
local options = {
    type = "group",
    name = "LostAndFound",
    desc = "LostAndFound",
    get = function(info) return db[info[#info]] end,
    set = function(info, v)
        db[info[#info]] = v
        HandyNotes_LostAndFound:SendMessage("HandyNotes_NotifyUpdate", "LostAndFound")
    end,
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
        icon_item = {
            type = "toggle",
            name = "Item icons",
            desc = "Show the icons for items, if known; otherwise, the achievement icon will be used",
        },
        show_lost = {
            type = "toggle",
            name = "Lost and Found",
            desc = "Show items that count for the Lost and Found achievement",
        },
        show_riches = {
            type = "toggle",
            name = "Riches of Pandaria",
            desc = "Show items that count for the Riches of Pandaria achievement",
        },
        show_junk = {
            type = "toggle",
            name = "Junk",
            desc = "Show items which don't count for any achievement",
        },
        found = {
            type = "toggle",
            name = "Show found",
            desc = "Show waypoints for items you've already found?",
        },
    },
}


---------------------------------------------------------
-- Addon initialization, enabling and disabling

function HandyNotes_LostAndFound:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_LostAndFoundDB", defaults)
    db = self.db.profile
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB("LostAndFound", HLHandler, options)
end

function HandyNotes_LostAndFound:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "LostAndFound")
end
