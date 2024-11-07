-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, WorldOfWarcraft = ...

local Safari = WorldOfWarcraft.node.Safari

local POI = WorldOfWarcraft.poi.POI

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = WorldOfWarcraft.Map({id = 56, settings = true})

-------------------------------------------------------------------------------
------------------------------------ SAFARI -----------------------------------
-------------------------------------------------------------------------------

map.nodes[60004380] = Safari.Cockroach({
    pois = {
        POI({
            26802520, 34005440, 34005480, 34802780, 53204120, 54203420,
            55403040, 56002540, 56803020, 57803520, 58602460, 60004380,
            60004600, 61404660, 62603740, 69603320
        })
    }
}) -- Cockroach

map.nodes[66605020] = Safari.MountainSkunk({
    pois = {
        POI({
            50001780, 51001540, 51802280, 64005200, 64805100, 65604460,
            66205080, 66605020, 66605480, 66804400, 67205240, 67805060,
            68404900, 68604900, 69004960, 69603700, 69804880, 69804980,
            72403940, 73404200
        })
    }
}) -- Mountain Skunk

map.nodes[66604400] = Safari.Squirrel({
    pois = {POI({63404840, 66005060, 66604400, 67205260, 70404660})}
}) -- Squirrel

map.nodes[54002520] = Safari.TinyBogBeast({
    pois = {
        POI({
            50203220, 50402800, 50403040, 50403060, 50602800, 51402880,
            51403000, 51403400, 51602900, 51603000, 51603380, 51803620,
            52202500, 52803040, 52803800, 53002920, 53003060, 53203340,
            53403360, 53602800, 54002520, 54403300, 54403520, 54603300,
            54603500, 55202740, 55202760, 55203040, 55203060, 55402420,
            55602420, 55603480, 55803440, 56202620, 56202660
        })
    }
}) -- Tiny Bog Beast

map.nodes[60005220] = Safari.Toad({
    pois = {
        POI({
            16403100, 19602960, 19804460, 20605100, 21602640, 22005500,
            22803680, 29002940, 33602020, 38402300, 38802300, 46603360,
            50603060, 51403560, 51603580, 53604160, 54603540, 56805020,
            57204580, 58407120, 58605020, 58606820, 59205640, 59407220,
            60005220, 60207280, 60406420, 61206620, 63005140, 63605420,
            64005720, 66006740, 66806880
        })
    }
}) -- Toad

map.nodes[51603580] = Safari.WaterSnake({
    pois = {
        POI({
            14004600, 14404120, 16404760, 18002580, 18804100, 20605100,
            21403020, 21603020, 24604500, 27402160, 29402500, 32002200,
            33602040, 38003260, 48206220, 50603060, 51002740, 51403580,
            51603580, 53403280, 53604160, 56804820, 56805040, 57006180,
            57404580, 57806640, 57806660, 58605820, 58804800, 59205640,
            59805200, 63805420, 64605440, 65806720
        })
    }
}) -- Water Snake

map.nodes[05906210] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[07205590] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[08005920] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[08605280] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[09906250] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[12305330] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[12603740] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[13203120] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[13305820] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[13705350] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[15402580] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[15606230] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[16003470] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[18305120] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[18306090] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[18602090] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[18604620] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[18904130] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[20205450] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[21105800] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[21703570] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[24002600] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[24401920] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[27003220] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[28601650] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[30902190] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[30903450] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[31801390] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[33802850] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[34402600] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[39602750] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[43603570] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[44803020] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[47503280] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[49003680] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[50703240] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[52903610] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[53404030] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[54704500] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[58606030] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[58906850] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[59104870] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[59805280] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[60605650] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[61107260] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[63405800] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[65006460] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[65106110] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[65606830] = WorldOfWarcraft.node.ScavengerPool(3874)
map.nodes[66307280] = WorldOfWarcraft.node.ScavengerPool(3874)
