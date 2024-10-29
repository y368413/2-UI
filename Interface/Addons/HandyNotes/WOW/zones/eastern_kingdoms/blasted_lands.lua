-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, WorldOfWarcraft = ...
local L = WorldOfWarcraft.locale
local Map = WorldOfWarcraft.Map

local Safari = WorldOfWarcraft.node.Safari

local Achievement = WorldOfWarcraft.reward.Achievement
local Transmog = WorldOfWarcraft.reward.Transmog

local POI = WorldOfWarcraft.poi.POI

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = Map({id = 17, settings = true})

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

map.nodes[33604960] = WorldOfWarcraft.node.AnniversaryRare({
    id = 121818,
    quest = 47461,
    rewards = {
        Transmog({item = 150380, slot = L['cloak']}), -- Eskhandar's Pelt
        Transmog({item = 150385, slot = L['cloth']}), -- Fel Infused Leggings
        Transmog({item = 150386, slot = L['cloth']}), -- Blacklight Bracer
        Transmog({item = 150381, slot = L['leather']}), -- Flayed Doomguard Belt
        Transmog({item = 150382, slot = L['leather']}), -- Doomhide Gauntlets
        Transmog({item = 150379, slot = L['mail']}), -- Infernal Headcage
        Transmog({item = 150427, slot = L['1h_mace']}), -- Empyrean Demolisher
        Transmog({item = 150383, slot = L['staff']}) -- Amberseal Keeper
    }
}) -- Lord Kazzak

-------------------------------------------------------------------------------
------------------------------------ SAFARI -----------------------------------
-------------------------------------------------------------------------------

map.nodes[51403860] = Safari.FireBeetle({
    pois = {
        POI({
            31807260, 32206440, 33407500, 36807340, 37004840, 37004880,
            37606040, 40007480, 40205460, 40406840, 40605420, 40806300,
            41403580, 41603560, 42001480, 42002640, 42201440, 42402240,
            42402300, 42803260, 43208040, 43401940, 43402060, 43404260,
            43407920, 43603180, 43604220, 44203780, 44403340, 44403360,
            44603860, 45404560, 45407920, 45408660, 45601360, 45602000,
            47801280, 47802640, 48401180, 48803580, 49008240, 49603640,
            50602920, 51203740, 51403860, 53003060, 53201760, 54801560,
            55203820, 55403220, 55807860, 56607400, 57601960, 57802400,
            57803480, 58002460, 58003980, 59602720, 59602760, 59807960,
            60001640, 60001660, 60607120, 60803280, 60803580, 61006460,
            61203200, 61207040, 61406600, 61603940, 61606540, 62004020,
            62401380, 62607980, 63407280, 63407380, 63603460, 63802760,
            64202640, 64403040, 64603020, 65004220, 65406880, 65807980,
            66407300, 66407860, 67003660, 67603200, 67803580, 67804060,
            71405320, 71804820, 71805340, 71805360
        })
    }
}) -- Fire Beetle

map.nodes[53602980] = Safari.Scorpid({
    pois = {
        POI({
            37605520, 38605440, 39807440, 40605420, 40606320, 42603160,
            43204260, 43208000, 43401980, 44203780, 45408020, 45801380,
            47802600, 48201260, 48204680, 48607920, 48803580, 49002600,
            50403220, 52402540, 53602980, 55001540, 55203240, 55608020,
            57007300, 58003980, 59002820, 59602740, 59807900, 60603580,
            60803340, 61007120, 61806600, 63607280, 64403060, 65004200,
            67603220, 68003980, 68806340, 69606340, 69807300
        })
    }
}) -- Scorpid

map.nodes[59806040] = Safari.Scorpling({
    pois = {
        POI({
            55405980, 55606000, 56006140, 56006160, 56406300, 56806300,
            57405920, 57405980, 57605940, 57605980, 58206440, 58206460,
            58405740, 58405780, 58605740, 58605760, 58606420, 59406040,
            59406060, 59606080, 59806040, 60005800, 60005860, 61405700,
            61405880, 61605640, 61605680, 61605840, 61605860, 62406020,
            62406060, 62606020, 62606060, 64006000, 64406180, 64606180,
            65206040, 65206060
        })
    }
}) -- Scorpling

map.nodes[45407960] = Safari.Spider({
    pois = {POI({39407460, 45407960, 61606540})}
}) -- Spider

-------------------------------------------------------------------------------
--------------------------------- DRAGONRACES ---------------------------------
-------------------------------------------------------------------------------

map.nodes[10001000] = WorldOfWarcraft.node.Dragonrace({
    label = '{quest:76469}',
    -- normal = {nil, nil, nil},
    -- advanced = {nil, nil, nil},
    -- reverse = {nil, nil, nil},
    rewards = {
        Achievement({id = 18566, criteria = 9, oneline = true}), -- normal bronze
        Achievement({id = 18567, criteria = 9, oneline = true}), -- normal silver
        Achievement({id = 18568, criteria = 9, oneline = true}), -- normal gold
        Achievement({id = 18569, criteria = 9, oneline = true}), -- advanced bronze
        Achievement({id = 18570, criteria = 9, oneline = true}), -- advanced silver
        Achievement({id = 18571, criteria = 9, oneline = true}), -- advanced gold
        Achievement({id = 18572, criteria = 9, oneline = true}), -- reverse bronze
        Achievement({id = 18573, criteria = 9, oneline = true}), -- reverse silver
        Achievement({id = 18574, criteria = 9, oneline = true}) -- reverse gold
    }
}) -- Blasted Lands Bolt

map.nodes[43209080] = WorldOfWarcraft.node.ScavengerPool(3876)
map.nodes[46708850] = WorldOfWarcraft.node.ScavengerPool(3876)
map.nodes[52708480] = WorldOfWarcraft.node.ScavengerPool(3876)
map.nodes[57508420] = WorldOfWarcraft.node.ScavengerPool(3876)
map.nodes[61508480] = WorldOfWarcraft.node.ScavengerPool(3876)
map.nodes[68007960] = WorldOfWarcraft.node.ScavengerPool(3876)
map.nodes[69303590] = WorldOfWarcraft.node.ScavengerPool(3876)
map.nodes[69504030] = WorldOfWarcraft.node.ScavengerPool(3876)
map.nodes[69802970] = WorldOfWarcraft.node.ScavengerPool(3876)
map.nodes[70902360] = WorldOfWarcraft.node.ScavengerPool(3876)
map.nodes[71207550] = WorldOfWarcraft.node.ScavengerPool(3876)
map.nodes[72104380] = WorldOfWarcraft.node.ScavengerPool(3876)
map.nodes[72106230] = WorldOfWarcraft.node.ScavengerPool(3876)
map.nodes[72106950] = WorldOfWarcraft.node.ScavengerPool(3876)
map.nodes[73802110] = WorldOfWarcraft.node.ScavengerPool(3876)