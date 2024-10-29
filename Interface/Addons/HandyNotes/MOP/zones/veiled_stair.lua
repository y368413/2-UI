-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, MistsOfPandaria = ...
local Map = MistsOfPandaria.Map
local L = MistsOfPandaria.locale

local Treasure = MistsOfPandaria.node.Treasure

local Achievement = MistsOfPandaria.reward.Achievement
local Item = MistsOfPandaria.reward.Item
-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------
local map = Map({id = 433, settings = true})

-------------------------------------------------------------------------------
---------------------------------- TREASURES ----------------------------------
-------------------------------------------------------------------------------

map.nodes[74947652] = Treasure({
    label = '{item:86473}',
    quest = 31428,
    rewards = {
        Achievement({id = 7997, criteria = {id = 1, qty = true}}), -- Riches of Pandaria
        Item({item = 86473})
    }
}) -- The Hammer of Folly

map.nodes[54677130] = Treasure({
    label = L['forgotten_lockbox'],
    quest = 31867,
    icon = 'chest_bn',
    note = L['forgotten_lockbox_note']
}) -- Chest of Supplies
