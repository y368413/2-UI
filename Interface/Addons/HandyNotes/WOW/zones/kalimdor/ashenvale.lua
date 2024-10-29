-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, WorldOfWarcraft = ...
local L = WorldOfWarcraft.locale
local Map = WorldOfWarcraft.Map

local Safari = WorldOfWarcraft.node.Safari

local Achievement = WorldOfWarcraft.reward.Achievement
local Section = WorldOfWarcraft.reward.Section
local Spacer = WorldOfWarcraft.reward.Spacer
local Transmog = WorldOfWarcraft.reward.Transmog

local POI = WorldOfWarcraft.poi.POI

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = Map({id = 63, settings = true})

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

map.nodes[93604000] = WorldOfWarcraft.node.AnniversaryRare({
    id = 121911,
    quest = 47463,
    rewards = {
        Transmog({item = 150394, slot = L['cloth']}), -- Mendicant's Slippers
        Transmog({item = 150395, slot = L['leather']}), -- Unnatural Leather Spaulders
        Transmog({item = 150414, slot = L['mail']}), -- Ancient Corroded Leggings
        Transmog({item = 150390, slot = L['plate']}), -- Strangely Glyphed Legplates
        Transmog({item = 150413, slot = L['plate']}), -- Dragonbone Wristguards
        Spacer(), Section(L['shared_drops']), Spacer(),
        Transmog({item = 150429, slot = L['dagger']}), -- Emerald Dragonfang
        Transmog({item = 150412, slot = L['1h_mace']}), -- Hammer of Bestial Fury
        Transmog({item = 150393, slot = L['1h_sword']}), -- Nightmare Blade
        Transmog({item = 150403, slot = L['crossbow']}), -- Polished Ironwood Crossbow
        Transmog({item = 150408, slot = L['staff']}), -- Staff of Rampant Growth
        Transmog({item = 150411, slot = L['cloak']}), -- Green Dragonskin Cloak
        Transmog({item = 150383, slot = L['staff']}) -- Amberseal Keeper
    }
}) -- Taerar

-------------------------------------------------------------------------------
------------------------------------ SAFARI -----------------------------------
-------------------------------------------------------------------------------

map.nodes[72207220] = Safari.ForestMoth({
    pois = {
        POI({
            17002460, 17602080, 17803140, 18601920, 18805920, 19005720,
            19203440, 19802020, 20002880, 20003300, 20405820, 20605080,
            21004860, 22203460, 22405760, 22804740, 22804860, 23003500,
            23405260, 23803780, 25002840, 25202740, 25203120, 25405260,
            25602540, 26203060, 26604240, 27002140, 28001760, 29004740,
            31804600, 32204160, 35006980, 35204280, 39204060, 39206940,
            39406680, 40006600, 40405640, 40605780, 42606140, 43204360,
            43204860, 43606920, 44406340, 44606760, 46606440, 46606460,
            47006200, 48606600, 51206280, 52006100, 52606320, 53807160,
            54007080, 54007260, 54007400, 54406960, 54802920, 55206920,
            56405520, 56407080, 56407240, 56607240, 57207360, 57406920,
            58206680, 58806540, 59406840, 59407320, 59407420, 59806460,
            59807180, 60007080, 60805540, 61008020, 61205700, 61404220,
            61807840, 61808260, 62205440, 62208120, 62208420, 62808260,
            63207560, 63207780, 63604360, 63807360, 63808440, 64008560,
            64204940, 64205160, 64406560, 65407180, 65606060, 65608580,
            65807400, 66206880, 66807400, 66808640, 67006240, 68007420,
            68406160, 68406500, 68608120, 69006420, 69007960, 69206600,
            69208260, 69408600, 69806300, 70008480, 70405980, 70808440,
            71205020, 71405660, 71407340, 71607940, 71607960, 72006760,
            72207040, 72207220, 72605540, 72807100, 73007280, 73207740,
            73207860, 73407040, 73806760, 73807700, 74207460, 74407020,
            76005200, 76207120, 77806580, 87004120, 87205060, 88806540,
            89004740, 90204860, 90806140
        })
    }
}) -- Forest Moth

map.nodes[69206280] = Safari.Frog({
    pois = {
        POI({
            44205280, 44205360, 44205520, 45005540, 46406820, 46606800,
            47407040, 47606980, 47607060, 48206920, 48606920, 48607000,
            53007140, 53007160, 53407020, 60007700, 61407440, 61607440,
            62207540, 62207560, 62807040, 62807060, 63806800, 64006960,
            64206700, 64206940, 65406500, 66006440, 67006340, 67006360,
            68006400, 68206240, 69206040, 69206080, 69206280, 69405800,
            69405900, 69605740, 70005620, 70005840, 70005860, 70005980,
            70605520, 70605720, 71005640, 71405400, 71605380, 72005480,
            72205320, 72605240, 73205140, 73805200, 74804640, 77204620,
            77805160, 78005040, 78205280, 78207220, 78405140, 78405380,
            78406500, 78605400, 78606500, 78607040, 78805980, 78806720,
            79006100, 79205600, 79205780, 79606520, 79606680, 80207120,
            80806380, 80807180, 81806440, 81806460, 84006540, 84006560,
            84806780, 86806840, 87006860, 91206380, 91406180, 91606560, 91806080
        })
    }
}) -- Frog

map.nodes[20204020] = Safari.Maggot({
    pois = {
        POI({
            19603740, 19603940, 19803780, 19804580, 20004140, 20204020,
            20604180, 20803620, 21203700, 21406000, 21606020, 21806160,
            22003820, 22606240, 23206260, 24006320, 24806340, 24806360,
            25406020, 25406120, 25606120, 25806280, 26006220, 26406360,
            26806380, 27206320, 27806400, 28206200, 28406040, 28406140,
            28406260, 78004600, 78404440, 78404520, 78604540, 79404640,
            79404660, 80004880, 80205040, 80205080, 80406500, 80606480,
            80804980, 81205080, 81206640, 81206660, 81206980, 81406800,
            81604860, 81606780, 82207020, 82406640, 82406660, 82407900,
            82606640, 82607140, 82607160, 82806740, 83206900, 83207860,
            83807020, 84007700, 84207280, 84407520, 84607400, 84607520,
            85007760, 88007820, 88207860, 88607860, 89007760, 89407680
        })
    }
}) -- Maggot

map.nodes[12003240] = Safari.Rat({
    pois = {
        POI({
            11003180, 11203440, 11203460, 11403060, 12003100, 12003240,
            12003260, 12203540, 12203560, 12403420, 13003220, 47406540,
            72608020, 73008100, 73206000, 73606100, 87205280
        })
    }
}) -- Rat

map.nodes[73606280] = Safari.Roach({
    pois = {
        POI({
            46405920, 72608020, 73206000, 73206280, 73606280, 85806120, 88405660
        })
    }
}) -- Roach

map.nodes[12201420] = Safari.RustySnail({
    pois = {
        POI({
            05601240, 05601260, 05801460, 06202840, 06202860, 07001240,
            07202920, 07401460, 08202980, 09001300, 09201140, 09201160,
            09401420, 09403080, 09602820, 10002660, 10003200, 10201440,
            10201460, 10201580, 10202980, 10203100, 11001560, 11002940,
            11201440, 11201460, 11402700, 11403000, 11602680, 11802280,
            12001520, 12003000, 12201420, 12402540, 12402560, 12402840,
            12402860, 12601540, 12602540, 12602640, 12802420, 13202840,
            13202860, 13401600, 13402680, 13602920, 14002840, 14202020,
            14202460, 14401720, 14402300, 14402440, 14402640, 14402660,
            14601720, 14601940, 14601960, 14602280, 14802180, 14802540,
            14802560, 14802840, 14802860, 15201520, 15202400, 15202740,
            15602080, 15602240, 15602260, 15602840, 15602860
        })
    }
}) -- Rusty Snail

map.nodes[64608400] = Safari.Squirrel({
    pois = {
        POI({
            18002500, 18805920, 20203300, 21605760, 23203060, 24403780,
            31004400, 34003780, 35203240, 42005740, 44805660, 52406320,
            53807160, 54007080, 54007260, 54805520, 55206920, 57006840,
            58206660, 58806220, 60808020, 62408120, 62808260, 63807360,
            63808440, 64406560, 64608400, 65407180, 65807400, 66206880,
            67006240, 67608560, 68406160, 68608120, 69006420, 69007960,
            69208260, 70008460, 70808440, 71405660, 71607960, 72207040,
            72605520, 73007280, 73205440, 73604680, 73806760, 74807280,
            75806520, 76207100, 77007260, 80805920, 82804920, 84004720
        })
    }
}) -- Squirrel

map.nodes[73805200] = Safari.Toad({
    pois = {
        POI({
            44205360, 45005540, 47407040, 47607000, 47607060, 48206920,
            48606920, 53207020, 53207160, 60007700, 61607440, 62207540,
            62207560, 63806800, 64006960, 64206700, 65406500, 66006420,
            66806360, 67006340, 68006400, 68206240, 69206020, 69206080,
            69206280, 69405820, 69405900, 69605720, 70005640, 70005840,
            70005860, 70005980, 70605520, 70605700, 71005640, 71405400,
            72005480, 72205320, 72605240, 73205140, 73805200, 74804640,
            77204620, 77805160, 78005040, 78205280, 78207240, 78405140,
            78405380, 78607040, 78806720, 79006000, 79205580, 79205780,
            79206120, 79606540, 79606560, 79606680, 80207140, 80806380,
            81007200, 81806440, 81806460, 84006540, 84006560, 84806800,
            86806860, 91206380, 91406200, 91606560, 91806080
        })
    }
}) -- Toad

-------------------------------------------------------------------------------
--------------------------------- DRAGONRACES ---------------------------------
-------------------------------------------------------------------------------

map.nodes[37043058] = WorldOfWarcraft.node.Dragonrace({
    label = '{quest:75378}',
    normal = {2317, 69, 64},
    advanced = {2347, 64, 59},
    reverse = {2377, 64, 59},
    rewards = {
        Achievement({id = 17712, criteria = 6, oneline = true}), -- normal bronze
        Achievement({id = 17713, criteria = 6, oneline = true}), -- normal silver
        Achievement({id = 17714, criteria = 6, oneline = true}), -- normal gold
        Achievement({id = 17715, criteria = 6, oneline = true}), -- advanced bronze
        Achievement({id = 17716, criteria = 6, oneline = true}), -- advanced silver
        Achievement({id = 17717, criteria = 6, oneline = true}), -- advanced gold
        Achievement({id = 17718, criteria = 6, oneline = true}), -- reverse bronze
        Achievement({id = 17719, criteria = 6, oneline = true}), -- reverse silver
        Achievement({id = 17720, criteria = 6, oneline = true}) -- reverse gold
    }
}) -- Ashenvale Ambit

map.nodes[08401350] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[10401680] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[10602830] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[12801840] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[13002420] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[13302690] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[13902150] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[33004990] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[35705200] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[37004660] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[38405020] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[45006990] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[47407280] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[49006790] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[51607260] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[52506950] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[59007920] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[61207570] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[63307160] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[64606690] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[68306330] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[69905780] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[72405330] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[74005040] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[76204520] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[78105060] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[78805820] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[78806420] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[79107060] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[82506360] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[85406790] = WorldOfWarcraft.node.ScavengerPool(3874)
