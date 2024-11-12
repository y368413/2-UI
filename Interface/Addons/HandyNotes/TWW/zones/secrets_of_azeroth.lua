-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, TheWarWithin = ...
local Class = TheWarWithin.Class
local L = TheWarWithin.locale
local Map = TheWarWithin.Map

local Node = TheWarWithin.node.Node

local Achievement = TheWarWithin.reward.Achievement
local Item = TheWarWithin.reward.Item

local Entrance = TheWarWithin.poi.Entrance
local POI = TheWarWithin.poi.POI
local Path = TheWarWithin.poi.Path

local QuestStatus = TheWarWithin.tooltip.QuestStatus

-------------------------------------------------------------------------------

local tanaris = TheWarWithin.maps[71] or Map({id = 71, settings = false})
local zuldazar = TheWarWithin.maps[862] or Map({id = 862, settings = false})
local desolace = TheWarWithin.maps[66] or Map({id = 66, settings = false})
local deadwindPass = TheWarWithin.maps[42] or Map({id = 42, settings = false})
local thousandNeedles = TheWarWithin.maps[64] or Map({id = 64, settings = false})
local azsuna = TheWarWithin.maps[630] or Map({id = 630, settings = true})
local howlingFjord = TheWarWithin.maps[117] or Map({id = 117, settings = true})

-------------------------------------------------------------------------------
--------------------------- SECRETS OF AZEROTH NODE ---------------------------
-------------------------------------------------------------------------------

local SecretOfAzeroth = Class('SecretOfAzeroth', Node, {
    icon = 'peg_gn',
    scale = 1.5,
    group = TheWarWithin.groups.SECRETS_OF_AZEROTH
}) -- Secret of Azeroth

-------------------------------------------------------------------------------
------------------------------- ALYX START NODE -------------------------------
-------------------------------------------------------------------------------

local START_QUEST = 84617

tanaris.nodes[63025024] = SecretOfAzeroth({
    label = '{npc:226683}',
    note = L['alyx_kickoff_note'],
    quest = START_QUEST,
    requires = TheWarWithin.requirement.Quest(84521) -- ![Thoughtful Pursuits]
}) -- Alyx

-------------------------------------------------------------------------------
----------------------------- CELEBRATION CRATES ------------------------------
-------------------------------------------------------------------------------

local CELEBRATION_CRATES = {
    [1] = {
        coordinates = 54235421,
        item = 226200,
        map = zuldazar,
        note = L['1_soggy_celebration_crate_note'],
        parentMapID = 875, -- Zandalar
        pois = {POI({54275451, color = 'Blue'})}, -- Nikto
        quest = 83794 -- ![Soggy Celebration Crate]
    },
    [2] = {
        coordinates = 54005810,
        item = 232263,
        map = desolace,
        note = L['2_hazy_celebration_crate_note'],
        parentMapID = 12, -- Kalimdor
        quest = 85574 -- ![Hazy Celebration Crate]
    },
    [3] = {
        coordinates = 22608370,
        item = 228322,
        map = deadwindPass,
        note = L['3_dirt_caked_celebration_crate_note'],
        pois = {
            Entrance({39837346}), --
            Path({
                39837346, 39817208, 38697210, 38717323, 37397338, 35657427,
                33627288, 33387274, 33257072, 34897036, 36067181, 36337388,
                35567528, 34857553, 30248135, 25858132, 22608370
            })
        },
        parentMapID = 13, -- Eastern Kingdoms
        quest = 84470 -- ![Dirt-Caked Celebration Crate]
    },
    [4] = {
        coordinates = 66002220,
        item = 228767,
        map = azsuna,
        note = format(L['4_sandy_celebration_crate'],
            C_CurrencyInfo.GetCoinTextureString(5000000)),
        pois = {
            POI({65604880}), -- Ending
            Path({
                66002220, 65402340, 65202380, 64402620, 63602780, 63402880,
                63202980, 63403120, 63403320, 64203500, 65203640, 65603680,
                66203940, 66404040, 66604300, 66604500, 66404660, 65804820,
                65604880
            })
        },
        parentMapID = 619, -- Broken Isles
        quest = 84624, -- ![Sandy Celebration Crate]
        requires = TheWarWithin.requirement.Item(228768) -- Water-Resistant Receipt
    },
    [5] = {
        coordinates = 29400636,
        item = 226375,
        map = howlingFjord,
        note = L['5_battered_celebration_crate'],
        parentMapID = 113, -- Northrend
        quest = 83931 -- ![Battered Celebration Crate]
    },
    [6] = {
        coordinates = 69186860,
        item = 228212,
        map = tanaris,
        note = L['6_waterlogged_celebration_crate'],
        parentMapID = 12, -- Kalimdor,
        quest = 84426 -- ![Waterlogged Celebration Crate]
    }
}

for num, crate in ipairs(CELEBRATION_CRATES) do
    crate.map.nodes[crate.coordinates] = SecretOfAzeroth({
        label = format('{item:%d}', crate.item),
        note = crate.note,
        pois = crate.pois or nil,
        quest = crate.quest,
        questDeps = START_QUEST,
        requires = crate.requires or nil,
        rewards = {Item({item = crate.item, quest = crate.quest})},
        rlabel = TheWarWithin.status.Gray(format('#%d', num))
    })
end

-------------------------------------------------------------------------------
--------------------- WATER-RESISTANT RECEIPT (CRATE #4) ----------------------
-------------------------------------------------------------------------------

thousandNeedles.nodes[64938438] = SecretOfAzeroth({
    label = '{item:228768}',
    note = L['water_resistant_receipt_note'],
    pois = {
        Entrance({66028651}), --
        Path({66028651, 65678567, 65038493, 64938438})
    },
    rewards = {
        Item({item = 228768, bag = true}) -- Water-Resistant Receipt
    }
}) -- Water-Resistant Receipt

-------------------------------------------------------------------------------
--------------------------- CELEBRATION CRATE LIST ----------------------------
-------------------------------------------------------------------------------

local CrateList = Class('CrateList', SecretOfAzeroth, {
    label = L['celebration_crates_label'],
    questDeps = START_QUEST,
    rewards = {
        Achievement({id = 40979, criteria = {qty = true, id = 1}}) -- No Crate Left Behind
    }
})

function CrateList.getters:note()
    local note = L['celebration_crates_note'] .. '\n'
    for num, crate in ipairs(CELEBRATION_CRATES) do
        local mName = C_Map.GetMapInfo(crate.map.id).name
        local pName = C_Map.GetMapInfo(crate.parentMapID).name
        local qDone = QuestStatus(crate.quest, num, false)
        note = note .. format('%s %s (%s)', qDone, mName, pName)
    end
    return note
end

tanaris.nodes[66644537] = CrateList()
