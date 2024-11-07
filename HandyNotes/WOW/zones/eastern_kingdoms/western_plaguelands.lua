-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, WorldOfWarcraft = ...

local Safari = WorldOfWarcraft.node.Safari

-- local Achievement = WorldOfWarcraft.reward.Achievement

local POI = WorldOfWarcraft.poi.POI

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = WorldOfWarcraft.Map({id = 22, settings = true})

-------------------------------------------------------------------------------
------------------------------------ SAFARI -----------------------------------
-------------------------------------------------------------------------------

map.nodes[49807780] = Safari.BlackRat({
    pois = {POI({47206760, 49807780, 52607880})}
}) -- Black Rat

map.nodes[43005220] = Safari.Squirrel({
    pois = {POI({32006060, 37606740, 43005220, 50404780})}
}) -- Squirrel

-------------------------------------------------------------------------------
--------------------------------- DRAGONRACES ---------------------------------
-------------------------------------------------------------------------------

-- map.nodes[10001000] = WorldOfWarcraft.node.Dragonrace({
--     label = '{quest:76510}',
--     normal = {nil, nil, nil},
--     advanced = {nil, nil, nil},
--     reverse = {nil, nil, nil},
--     rewards = {
--         Achievement({id = 18566, criteria = 10, oneline = true}), -- normal bronze
--         Achievement({id = 18567, criteria = 10, oneline = true}), -- normal silver
--         Achievement({id = 18568, criteria = 10, oneline = true}), -- normal gold
--         Achievement({id = 18569, criteria = 10, oneline = true}), -- advanced bronze
--         Achievement({id = 18570, criteria = 10, oneline = true}), -- advanced silver
--         Achievement({id = 18571, criteria = 10, oneline = true}), -- advanced gold
--         Achievement({id = 18572, criteria = 10, oneline = true}), -- reverse bronze
--         Achievement({id = 18573, criteria = 10, oneline = true}), -- reverse silver
--         Achievement({id = 18574, criteria = 10, oneline = true}) -- reverse gold
--     }
-- }) -- Plaguelands Plunge

map.nodes[29906890] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[32607040] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[35206930] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[38307510] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[41707680] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[45407680] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[46507450] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[50707120] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[53407390] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[55907040] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[57507880] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[60406250] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[62108230] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[65408330] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[66706290] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[69405840] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[69504460] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[69805140] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[70003980] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[71608250] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[73005940] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[75908130] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[76506170] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[77706560] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[78808000] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[79607040] = WorldOfWarcraft.node.ScavengerPool(3875)
map.nodes[79707470] = WorldOfWarcraft.node.ScavengerPool(3875)
