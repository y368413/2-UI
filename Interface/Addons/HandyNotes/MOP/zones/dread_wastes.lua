-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local ADDON_NAME, MistsOfPandaria = ...
local Map = MistsOfPandaria.Map
local L = MistsOfPandaria.locale

local Rare = MistsOfPandaria.node.Rare

local Achievement = MistsOfPandaria.reward.Achievement
local Mount = MistsOfPandaria.reward.Mount

-------------------------------------------------------------------------------

local map = Map({ id=422, settings=true })

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

map.nodes[47606160] = Rare({
    id=69842,
    note=L["zandalari_warbringer_note"],
    rewards={
        Achievement({id=8078, criteria={
            {id=2, qty=true, suffix=L["zandalari_warbringer_killed"]}
        }}),
        Mount({item=94229, id=535}), -- Reins of the Slate Primordial Direhorn
        Mount({item=94230, id=534}), -- Reins of the Amber Primordial Direhorn
        Mount({item=94231, id=536}) -- Reins of the Jade Primordial Direhorn
    }
}) -- Zandalari Warbringer
