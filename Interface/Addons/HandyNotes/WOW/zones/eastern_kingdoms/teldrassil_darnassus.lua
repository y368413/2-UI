-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, WorldOfWarcraft = ...
local Map = WorldOfWarcraft.Map

local Safari = WorldOfWarcraft.node.Safari

local POI = WorldOfWarcraft.poi.POI

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = Map({id = 57, settings = true})
local darnassus = Map({id = 89, settings = true})
local shadowglen = Map({id = 460, settings = true})
-------------------------------------------------------------------------------
------------------------------------ SAFARI -----------------------------------
-------------------------------------------------------------------------------

map.nodes[54405260] = Safari.CrestedOwl({
    pois = {
        POI({
            38402720, 38803400, 39204840, 39204860, 39803040, 39803060,
            40202460, 40203940, 40204440, 40204460, 40805160, 41205700,
            41402560, 42003600, 42206040, 42206060, 42604240, 42604260,
            43006680, 43203340, 43204640, 43402520, 43403880, 43806220,
            45202600, 45803280, 46005060, 46206640, 47003560, 47004640,
            47004660, 47204260, 48206700, 50004860, 51005420, 51405120,
            51405160, 51605140, 52405800, 52605800, 52806400, 54005540,
            54006640, 54006660, 54405240, 54405260, 54605260, 55405820,
            55806460, 56404760, 57205700, 57206180, 57406680, 58805220,
            60004400, 60204780, 60205040, 60205060, 61006000, 62404520,
            62604520, 62605560, 63004880, 63005840
        })
    }
}) -- Crested Owl

shadowglen.nodes[37807420] = Safari.CrestedOwl({
    parent = map.id,
    pois = {POI({37807420, 46004380})}
}) -- Crested Owl

darnassus.nodes[41208160] = Safari.ElfinRabbit({
    parent = map.id,
    pois = {
        POI({
            32007080, 32604160, 41208160, 42204740, 45008080, 45203540,
            49207420, 55206640, 67205160, 68004740
        })
    }
}) -- Elfin Rabbit

map.nodes[49404740] = Safari.ElfinRabbit({
    pois = {
        POI({
            40203060, 40603340, 43006160, 43403820, 49404740, 50205040,
            55205600, 55409080, 60406080
        })
    }
}) -- Elfin Rabbit

darnassus.nodes[61205100] = Safari.ForestMoth({
    parent = map.id,
    pois = {
        POI({
            42404740, 45205000, 46403660, 46603680, 48405640, 53605440,
            61205100, 62204580, 67405400, 67804760, 73205040
        })
    }
}) -- Forest Moth

map.nodes[61205100] = Safari.ForestMoth({
    pois = {POI({40603020, 56005400, 62005020})}
}) -- Forest Moth

map.nodes[42405680] = Safari.SmallFrog({
    pois = {
        POI({
            41405520, 42205580, 42405680, 42405800, 43005780, 43005900,
            44802360, 45402320, 51606140, 52406340, 53406040, 56805900,
            57206040, 57206060, 58805800
        })
    }
}) -- Small Frog