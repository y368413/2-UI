-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, WorldOfWarcraft = ...

local Safari = WorldOfWarcraft.node.Safari

local POI = WorldOfWarcraft.poi.POI

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local map = WorldOfWarcraft.Map({id = 97, settings = true})
local exodar = WorldOfWarcraft.Map({id = 103, settings = true})
local ammenvale = WorldOfWarcraft.Map({id = 468, settings = true})

-------------------------------------------------------------------------------
------------------------------------ SAFARI -----------------------------------
-------------------------------------------------------------------------------

map.nodes[37201180] = Safari.GreyMoth({
    pois = {
        POI({
            09008320, 09408720, 11208900, 11607760, 12008280, 12208540,
            13208640, 13208660, 14208180, 15208620, 15208960, 16407900,
            16607900, 16608320, 17208840, 18608020, 23406860, 23606860,
            25806640, 26206760, 26606740, 27404880, 27405720, 28207820,
            29406260, 29606240, 29606260, 32404960, 32604960, 32807580,
            33202800, 34006120, 34606860, 34802000, 35006840, 35603480,
            37007460, 37201180, 37201640, 37201680, 37203020, 37402300,
            37602360, 38206720, 38404820, 38604840, 40202240, 40202260,
            40205940, 40205960, 40405140, 40405160, 40602580, 40605140,
            40803100, 41203160, 41404260, 41604300, 42204660, 42806000,
            43201240, 43201260, 43203600, 43403520, 44000920, 44403140,
            44403160, 44406660, 44603140, 44603160, 45205660, 45404500,
            45405620, 45604440, 46202300, 48001040, 48001060, 48006960,
            48206900, 48404620, 48603760, 48805560, 49206360, 49803080,
            50402420, 50602420, 51006660, 51204740, 51204760, 51205740,
            51205760, 51802200, 53205420, 53403520, 53603520, 53801940,
            53802880, 54004160, 54604920, 55201100, 55403040, 55403060,
            56206340, 56206360, 56405460, 57603900, 58404640, 58602320,
            58604640, 59205500, 59406100, 59606600, 62604780, 64204020
        })
    }
}) -- Grey Moth

ammenvale.nodes[37201180] = Safari.GreyMoth({
    parent = map.id,
    pois = {POI({49205740, 54603200})}
}) -- Grey Moth

exodar.nodes[60804800] = Safari.Mouse({
    parent = map.id,
    pois = {
        POI({
            25003360, 35203920, 38802880, 41001980, 41206880, 46202800,
            47605980, 47803180, 47806120, 60804800, 64404080
        })
    }
}) -- Mouse

map.nodes[36801520] = Safari.Skunk({
    pois = {
        POI({
            30207380, 30805580, 36801520, 40201540, 42200780, 46200740,
            47601160, 53402560, 57004860
        })
    }
}) -- Skunk
