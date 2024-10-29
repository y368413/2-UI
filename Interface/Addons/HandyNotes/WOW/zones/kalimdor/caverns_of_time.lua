-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, WorldOfWarcraft = ...
local L = WorldOfWarcraft.locale
local Map = WorldOfWarcraft.Map

local Pet = WorldOfWarcraft.reward.Pet
local Transmog = WorldOfWarcraft.reward.Transmog

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = Map({id = 75, settings = true})

-------------------------------------------------------------------------------
------------------------------------- NPC -------------------------------------
-------------------------------------------------------------------------------

map.nodes[50704110] = WorldOfWarcraft.node.AnniversaryNPC({
    id = 158061,
    icon = 136235,
    rewards = {
        Transmog({item = 147885}), -- Bronze-Tinted Sunglasses
        Transmog({item = 178514, slot = L['cloak']}), -- Crafted Cloak of War
        Pet({item = 136925, id = 1890}), -- Corgi Pup
        Pet({item = 186556, id = 3100}) -- Timeless Mechanical Dragonling
    }
}) -- Historian Ma'di
