-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, WorldOfWarcraft = ...

local Safari = WorldOfWarcraft.node.Safari

local Achievement = WorldOfWarcraft.reward.Achievement

local POI = WorldOfWarcraft.poi.POI

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = WorldOfWarcraft.Map({id = 15, settings = true})

-------------------------------------------------------------------------------
------------------------------------ SAFARI -----------------------------------
-------------------------------------------------------------------------------

map.nodes[48002800] = Safari.Beetle({
    pois = {
        POI({
            41801060, 42001040, 43401020, 43600980, 45805760, 46005720,
            48002800, 49402860, 49602880, 49802840, 55201480, 55201560
        })
    }
}) -- Beetle

map.nodes[49402860] = Safari.GoldBeetle({
    pois = {
        POI({
            10604940, 13806280, 14005480, 14803660, 15206480, 19805680,
            24004120, 24804080, 27203840, 32403400, 42001060, 43401020,
            45604740, 46004600, 49402860, 49602880, 50204360, 50604620,
            51405260, 51804360, 52002200, 54603780, 55201480, 56605600,
            58602140, 61605160, 67605320, 68202600, 69004240, 71403860, 72604520
        })
    }
}) -- Gold Beetle

map.nodes[41002780] = Safari.KingSnake({
    pois = {
        POI({
            06006940, 06006980, 07206640, 08006620, 09803020, 09806880,
            10406820, 10603060, 10803020, 12005760, 12604360, 12804320,
            15202760, 15402740, 15802760, 16202700, 16803140, 17203220,
            17203260, 17604560, 18004540, 21402620, 21802620, 22003700,
            22203760, 26602520, 28403220, 28603200, 29602520, 30406940,
            30606940, 30606960, 31402980, 31802980, 32002940, 35006320,
            35206360, 36002600, 36202520, 39006700, 39206760, 39802140,
            40202180, 41002780, 41207080, 41402860, 41406980, 41606940,
            41802780, 41806980, 42002700, 42407340, 42607320, 42607360,
            43202020, 43202060, 43602000, 44201760, 44401740, 45006920,
            45206980, 45606960, 48003740, 48003780, 48207340, 48207360,
            48403260, 48803220, 49203280, 50206960, 53806720, 53806760,
            54606780, 54801440, 55001460, 58403540, 61202720, 62603540,
            62803560, 63802120, 64206280, 66005400, 66603240, 66607300,
            66803260, 66805380, 67002660, 67202200, 68006540, 68006560,
            70404060, 70407260, 70604040, 71007300, 71402960, 71802140,
            71802260, 71802940, 71804940, 72002240, 72002960, 72404840,
            72405740, 72604840, 72605720, 73207420, 73607420, 73607460,
            76202760, 76404000, 76404740, 76603140, 76804720, 77003160,
            78406360, 82403200, 82603220
        })
    }
}) -- King Snake

map.nodes[50404560] = Safari.Rattlesnake({
    pois = {
        POI({
            10003020, 11205180, 12405380, 12805840, 14406020, 16606020,
            17003080, 17003320, 17802760, 19004200, 19004960, 21802620,
            24404920, 27803840, 30802680, 32403400, 32803500, 39205640,
            39802160, 39805880, 40603260, 41006860, 42003240, 46204620,
            46603940, 47606020, 48802200, 50404560, 55806680, 56001540,
            63002760, 63602980, 64404400, 66602360, 67605080, 69403960,
            70204000, 70402280, 72204460, 73604580, 77002780, 82603360
        })
    }
}) -- Rattlesnake

map.nodes[41003240] = Safari.SpikyLizard({
    pois = {
        POI({
            10202920, 10804920, 13006820, 13605060, 14405720, 14406680,
            14803680, 15406580, 23006340, 24603800, 25204960, 32403420,
            35403920, 35603880, 36206280, 41003240, 42003220, 45607000,
            46400880, 46404660, 48203880, 50204620, 51004420, 51606020,
            52004280, 52203900, 52404600, 55604720, 56603000, 56604540,
            57202440, 60805140, 64604500, 67002340, 71005260, 71602220,
            76603420, 77403480
        })
    }
}) -- Spiky Lizard

map.nodes[34406140] = Safari.StripeTailedScorpid({
    pois = {
        POI({
            11405220, 12405740, 13806280, 14005500, 14603640, 15202740,
            16603060, 18805800, 20205720, 22606320, 23803740, 24204120,
            26005000, 28803120, 30602720, 30806920, 31204320, 32403440,
            32403480, 34004320, 34406140, 35403880, 38805680, 39405840,
            40202180, 40603280, 40803240, 45002500, 45404600, 46405640,
            47205260, 48807300, 51802280, 51803920, 52002200, 52604460,
            64404440, 67605360, 71402880, 74607000, 77202780
        })
    }
}) -- Stripe-Tailed Scorpid

-------------------------------------------------------------------------------
--------------------------------- DRAGONRACES ---------------------------------
-------------------------------------------------------------------------------

map.nodes[10001000] = WorldOfWarcraft.node.Dragonrace({
    label = '{quest:76523}',
    -- normal = {nil, nil, nil},
    -- advanced = {nil, nil, nil},
    -- reverse = {nil, nil, nil},
    rewards = {
        Achievement({id = 18566, criteria = 12, oneline = true}), -- normal bronze
        Achievement({id = 18567, criteria = 12, oneline = true}), -- normal silver
        Achievement({id = 18568, criteria = 12, oneline = true}), -- normal gold
        Achievement({id = 18569, criteria = 12, oneline = true}), -- advanced bronze
        Achievement({id = 18570, criteria = 12, oneline = true}), -- advanced silver
        Achievement({id = 18571, criteria = 12, oneline = true}), -- advanced gold
        Achievement({id = 18572, criteria = 12, oneline = true}), -- reverse bronze
        Achievement({id = 18573, criteria = 12, oneline = true}), -- reverse silver
        Achievement({id = 18574, criteria = 12, oneline = true}) -- reverse gold
    }
}) -- Fuselight Night Flight
