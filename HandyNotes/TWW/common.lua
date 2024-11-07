-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, TheWarWithin = ...
local L = TheWarWithin.locale

local Class = TheWarWithin.Class
local Group = TheWarWithin.Group

local Collectible = TheWarWithin.node.Collectible

-------------------------------------------------------------------------------

TheWarWithin.expansion = 11

-------------------------------------------------------------------------------
----------------------------------- GROUPS ------------------------------------
-------------------------------------------------------------------------------

TheWarWithin.groups.DELVE_REWARDS = Group('delve_rewards', 4203076, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.EXPANSION,
    HasEnabledNodes = function() return true end
})

TheWarWithin.groups.DISTURBED_EARTH = Group('disturbed_earth', 132386, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.EXPANSION
})

TheWarWithin.groups.PROFESSION_TREASURES = Group('profession_treasures', 4620676, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.EXPANSION
})

TheWarWithin.groups.SKYRIDING_GLYPH = Group('skyriding_glyph', 4728198, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.EXPANSION
})

-------------------------------------------------------------------------------

TheWarWithin.groups.BACK_TO_THE_WALL = Group('back_to_the_wall', 236681, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40620
})

TheWarWithin.groups.BEACON_OF_HOPE = Group('beacon_of_hope', 135922, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40308
})

TheWarWithin.groups.BIBLO_ARCHIVIST = Group('biblo_archivist', 5341597, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40622
})

TheWarWithin.groups.BOOKWORM = Group('bookworm', 4549129, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40629
})

TheWarWithin.groups.FLAMEGARDS_HOPE = Group('flamegards_hope', 463526, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 20594
})

TheWarWithin.groups.FLAT_EARTHEN = Group('flat_earthen', 4620670, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40606
})

TheWarWithin.groups.FLIGHT_MASTER = Group('flight_master', 'flight_point_y', {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40430
})

TheWarWithin.groups.FOR_THE_COLLECTIVE = Group('for_the_collective', 975747, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40630
})

TheWarWithin.groups.GOBBLIN_WITH_GLUBLURP = Group('gobblin_with_glublurp', 5763494, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40614
})

TheWarWithin.groups.ITSY_BITSY_SPIDER = Group('itsy_bitsy_spider', 5793405, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40624
})
TheWarWithin.groups.I_ONLY_NEED_ONE_TRIP = Group('i_only_need_one_trip', 236316, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40623
})

-- TheWarWithin.groups.KHAZ_ALGAR_LORE_HUNTER = Group('khaz_algar_lore_hunter', 4419344, {
--     defaults = TheWarWithin.GROUP_HIDDEN,
--     type = TheWarWithin.group_types.ACHIEVEMENT,
--     achievement = 40762
-- })

TheWarWithin.groups.LOST_AND_FOUND = Group('lost_and_found', 4635200, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40618
})

TheWarWithin.groups.MERELDAR_MENACE = Group('mereldar_menace', 135232, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40151
})

TheWarWithin.groups.MISSING_LYNX = Group('missing_lynx', 5689905, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40625
})

TheWarWithin.groups.NO_HARM_FROM_READING = Group('no_harm_from_reading', 463284, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40632
})

TheWarWithin.groups.NOT_SO_QUICK_FIX = Group('not_so_quick_fix', 134067, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40473
})

TheWarWithin.groups.NOTABLE_MACHINES = Group('notable_machines', 1506451, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40628
})

TheWarWithin.groups.ROCKED_TO_SLEEP = Group('rocked_to_sleep', 5788303, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40504
})

-- TheWarWithin.groups.SAFARI = Group('safari', 4048818, {
--     defaults = TheWarWithin.GROUP_HIDDEN,
--     type = TheWarWithin.group_types.ACHIEVEMENT,
--     achievement = 40194
-- })

TheWarWithin.groups.SECRETS_OF_AZEROTH = Group('secrets_of_azeroth', 'peg_gn', {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.EXPANSION
})

TheWarWithin.groups.SKITTERSHAW_SPIN = Group('skittershaw_spin', 879828, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40727
})

TheWarWithin.groups.SMELLING_HISTORY = Group('smelling_history', 4549130, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40542
})

TheWarWithin.groups.THE_UNSEEMING = Group('the_unseeming', 1386549, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40633
})

TheWarWithin.groups.YOU_CANT_HANG_WITH_US = Group('you_cant_hang_with_us', 5763494, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40634
})

TheWarWithin.groups.CRITTER_LOVE = Group('critter_love', 3459801, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.ACHIEVEMENT,
    achievement = 40475
})

TheWarWithin.groups.DRAGONRACE = Group('dragonrace', 1100022, {
    defaults = TheWarWithin.GROUP_HIDDEN,
    type = TheWarWithin.group_types.EXPANSION
})
-------------------------------------------------------------------------------
---------------------------- KHAZ ALGAR LORE HUNTER ---------------------------
-------------------------------------------------------------------------------

-- local LoreObject = Class('LoreObject', Collectible, {
--     icon = 4419344,
--     group = TheWarWithin.groups.KHAZ_ALGAR_LORE_HUNTER
-- })

-- TheWarWithin.node.LoreObject = LoreObject

-------------------------------------------------------------------------------
------------------------------- SKYRIDING GLYPH -------------------------------
-------------------------------------------------------------------------------

local SkyridingGlyph = Class('SkyridingGlyph', Collectible, {
    icon = 4728198,
    label = L['skyriding_glyph'],
    group = TheWarWithin.groups.SKYRIDING_GLYPH
})

TheWarWithin.node.SkyridingGlyph = SkyridingGlyph

-------------------------------------------------------------------------------
----------------------------- PROFESSION TREASURES ----------------------------
-------------------------------------------------------------------------------

local ProfessionMaster = Class('ProfessionMaster', TheWarWithin.node.NPC, {
    scale = 0.9,
    group = TheWarWithin.groups.PROFESSION_TREASURES
})

function ProfessionMaster:IsEnabled()
    if not TheWarWithin.PlayerHasProfession(self.skillID) then return false end
    return TheWarWithin.node.NPC.IsEnabled(self)
end

local ProfessionTreasure = Class('ProfessionTreasure', TheWarWithin.node.Item, {
    scale = 0.9,
    group = TheWarWithin.groups.PROFESSION_TREASURES
})

function ProfessionTreasure:IsEnabled()
    if not TheWarWithin.PlayerHasProfession(self.skillID) then return false end
    return TheWarWithin.node.Item.IsEnabled(self)
end

TheWarWithin.node.ProfessionMasters = {}
TheWarWithin.node.ProfessionTreasures = {}

local PM = TheWarWithin.node.ProfessionMasters
local PT = TheWarWithin.node.ProfessionTreasures

for _, profession in pairs(TheWarWithin.professions) do
    if profession.variantID ~= nil then
        local name = profession.name
        local icon = profession.icon
        local skillID = profession.skillID
        local variantID = profession.variantID[11]

        PM[name] = Class(name .. 'Master', ProfessionMaster, {
            icon = icon,
            skillID = skillID,
            requires = TheWarWithin.requirement.Profession(skillID, variantID, 1)
        })

        PT[name] = Class(name .. 'Treasure', ProfessionTreasure, {
            icon = icon,
            skillID = skillID,
            requires = TheWarWithin.requirement.Profession(skillID, variantID, 1)
        })
    end
end

-- Herbalism
-- map.nodes[0000] = PT.Herbalism({quest = nil, id = 224265}) -- Deepgrove Rose -- Random Drop 5 per week

-------------------------------------------------------------------------------
-------------------------------- DISTURBED DIRT -------------------------------
-------------------------------------------------------------------------------

TheWarWithin.node.DisturbedEarth = Class('Disturbed_earth', TheWarWithin.node.Node, {
    icon = 132386,
    scale = 0.7,
    label = '{npc:213440}',
    group = TheWarWithin.groups.DISTURBED_EARTH,
    requires = {TheWarWithin.requirement.Reputation(2594, 2, true)}, -- Assembly of the Deeps Renown 2
    rewards = {
        TheWarWithin.reward.Item({item = 212493}), -- Odd Glob of Wax
        TheWarWithin.reward.Achievement({id = 40585, criteria = {id = 1, qty = true}}) -- Super Size Snuffling
    }
}) -- Disturbed Earth - Not on Minimap but quite visible from some distance
-- first loot triggered quest 84543 probably not relevant

-------------------------------------------------------------------------------
-------------------- ACHIEVEMENT: KHAZ ALGAR FLIGHT MASTER --------------------
-------------------------------------------------------------------------------

local FlightMaster = Class('FlightMaster', Collectible, {
    icon = 'flight_point_y',
    scale = 2,
    group = TheWarWithin.groups.FLIGHT_MASTER
}) -- Flight Point

TheWarWithin.node.FlightMaster = FlightMaster

-------------------------------------------------------------------------------
------------------------------ KHAZ ALGAR SAFARI ------------------------------
-------------------------------------------------------------------------------

-- local Safari = Class('Safari', Collectible,
--     {icon = 'paw_g', group = TheWarWithin.groups.SAFARI}) -- Khaz Algar Safari

-- TheWarWithin.node.Safari = Safari

-- map.nodes[0000] = Safari({
--     id = 222071,
--     rewards = {Achievement({id = 40194, criteria = 67292}), Pet({id = 4457})}
--     -- pois = {POI({0000})}
-- }) -- Chitin Burrower

-- map.nodes[0000] = Safari({
--     id = 222613,
--     rewards = {Achievement({id = 40194, criteria = 67294}), Pet({id = 4514})}
--     -- pois = {POI({0000})}
-- }) -- Fallowspark Glowfly

-- map.nodes[0000] = Safari({
--     id = 222615,
--     rewards = {Achievement({id = 40194, criteria = 67296}), Pet({id = 4516})}
--     -- pois = {POI({0000})}
-- }) -- Vibrant Glowfly

-- map.nodes[0000] = Safari({
--     id = 222344,
--     rewards = {Achievement({id = 40194, criteria = 67298}), Pet({id = 4477})}
--     -- pois = {POI({0000})}
-- }) -- Verdant Scootlefish

-- map.nodes[0000] = Safari({
--     id = 222351,
--     rewards = {Achievement({id = 40194, criteria = 67300}), Pet({id = 4480})}
--     -- pois = {POI({0000})}
-- }) -- Shadowy Oozeling

-- map.nodes[0000] = Safari({
--     id = 222582,
--     rewards = {Achievement({id = 40194, criteria = 67302}), Pet({id = 4498})}
--     -- pois = {POI({0000})}
-- }) -- Ebon Ploughworm

-- map.nodes[0000] = Safari({
--     id = 222195,
--     rewards = {Achievement({id = 40194, criteria = 67304}), Pet({id = 4460})}
--     -- pois = {POI({0000})}
-- }) -- Arathi Chicken

-- map.nodes[0000] = Safari({
--     id = 222877,
--     rewards = {Achievement({id = 40194, criteria = 67306}), Pet({id = 4535})}
--     -- pois = {POI({0000})}
-- }) -- Ghostcap Menace

-- map.nodes[0000] = Safari({
--     id = 222421,
--     rewards = {Achievement({id = 40194, criteria = 67308}), Pet({id = 4483})}
--     -- pois = {POI({0000})}
-- }) -- Vile Bloodtick

-- map.nodes[0000] = Safari({
--     id = 222499,
--     rewards = {Achievement({id = 40194, criteria = 67310}), Pet({id = 4485})}
--     -- pois = {POI({0000})}
-- }) -- Mossy Snail

-- map.nodes[0000] = Safari({
--     id = 222739,
--     rewards = {Achievement({id = 40194, criteria = 67312}), Pet({id = 4522})}
--     -- pois = {POI({0000})}
-- }) -- Troglofrog

-- map.nodes[0000] = Safari({
--     id = 222775,
--     rewards = {Achievement({id = 40194, criteria = 67314}), Pet({id = 4526})}
--     -- pois = {POI({0000})}
-- }) -- Sandstone Mosswool

-- map.nodes[0000] = Safari({
--     id = 223136,
--     rewards = {Achievement({id = 40194, criteria = 67316}), Pet({id = 4544})}
--     -- pois = {POI({0000})}
-- }) -- Umbral Amalgam

-- map.nodes[0000] = Safari({
--     id = 223094,
--     rewards = {Achievement({id = 40194, criteria = 67318}), Pet({id = 4538})}
--     -- pois = {POI({0000})}
-- }) -- Cobalt Ramolith

-- map.nodes[0000] = Safari({
--     id = 223092,
--     rewards = {Achievement({id = 40194, criteria = 67320}), Pet({id = 4540})}
--     -- pois = {POI({0000})}
-- }) -- Alabaster Stonecharger

-- map.nodes[0000] = Safari({
--     id = 223698,
--     rewards = {Achievement({id = 40194, criteria = 68270}), Pet({id = 4577})}
--     -- pois = {POI({0000})}
-- }) -- Cinderhoney Emberstinger

-- map.nodes[0000] = Safari({
--     id = 222066,
--     rewards = {Achievement({id = 40194, criteria = 67293}), Pet({id = 4456})}
--     -- pois = {POI({0000})}
-- }) -- Arachnoid Hatchling

-- map.nodes[0000] = Safari({
--     id = 222614,
--     rewards = {Achievement({id = 40194, criteria = 67295}), Pet({id = 4515})}
--     -- pois = {POI({0000})}
-- }) -- Azure Flickerfly

-- map.nodes[0000] = Safari({
--     id = 222325,
--     rewards = {Achievement({id = 40194, criteria = 67297}), Pet({id = 4471})}
--     -- pois = {POI({0000})}
-- }) -- Aubergine Scootlefish

-- map.nodes[0000] = Safari({
--     id = 222354,
--     rewards = {Achievement({id = 40194, criteria = 67299}), Pet({id = 4481})}
--     -- pois = {POI({0000})}
-- }) -- Voidling Ooze

-- map.nodes[0000] = Safari({
--     id = 222584,
--     rewards = {Achievement({id = 40194, criteria = 67301}), Pet({id = 4499})}
--     -- pois = {POI({0000})}
-- }) -- Common Ploughworm

-- map.nodes[0000] = Safari({
--     id = 222194,
--     rewards = {Achievement({id = 40194, criteria = 67303}), Pet({id = 4461})}
--     -- pois = {POI({0000})}
-- }) -- Greenlands Chicken

-- map.nodes[0000] = Safari({
--     id = 222875,
--     rewards = {Achievement({id = 40194, criteria = 67305}), Pet({id = 4533})}
--     -- pois = {POI({0000})}
-- }) -- Meek Bloodlasher

-- map.nodes[0000] = Safari({
--     id = 222608,
--     rewards = {Achievement({id = 40194, criteria = 67307}), Pet({id = 4510})}
--     -- pois = {POI({0000})}
-- }) -- Winged Arachnoid

-- map.nodes[0000] = Safari({
--     id = 222713,
--     rewards = {Achievement({id = 40194, criteria = 67309}), Pet({id = 4518})}
--     -- pois = {POI({0000})}
-- }) -- Magmashell Crawler

-- map.nodes[0000] = Safari({
--     id = 222736,
--     rewards = {Achievement({id = 40194, criteria = 67311}), Pet({id = 4521})}
--     -- pois = {POI({0000})}
-- }) -- Subterranean Dartwog

-- map.nodes[0000] = Safari({
--     id = 222774,
--     rewards = {Achievement({id = 40194, criteria = 67313}), Pet({id = 4525})}
--     -- pois = {POI({0000})}
-- }) -- Fragrant Stonelamb

-- map.nodes[0000] = Safari({
--     id = 222778,
--     rewards = {Achievement({id = 40194, criteria = 67315}), Pet({id = 4529})}
--     -- pois = {POI({0000})}
-- }) -- Shale Mosswool

-- map.nodes[0000] = Safari({
--     id = 223090,
--     rewards = {Achievement({id = 40194, criteria = 67317}), Pet({id = 4541})}
--     -- pois = {POI({0000})}
-- }) -- Bedrock Stonecharger

-- map.nodes[0000] = Safari({
--     id = 223093,
--     rewards = {Achievement({id = 40194, criteria = 	67319}), Pet({id = 4539})}
--     -- pois = {POI({0000})}
-- }) -- Granite Ramolith

-- map.nodes[0000] = Safari({
--     id = 223715,
--     rewards = {Achievement({id = 40194, criteria = 68269}), Pet({id = 4574})}
--     -- pois = {POI({0000})}
-- }) -- Snuffling
