-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, Cataclysm = ...
local L = Cataclysm.locale
local Map = Cataclysm.Map

local Rare = Cataclysm.node.Rare

local Mount = Cataclysm.reward.Mount
local Toy = Cataclysm.reward.Toy
local Transmog = Cataclysm.reward.Transmog

local Path = Cataclysm.poi.Path
local POI = Cataclysm.poi.POI

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

-- local forest = Map({id = 201, settings = true})
local depths = Map({id = 204, settings = true})
local expanse = Map({id = 205, settings = true})

-------------------------------------------------------------------------------
----------------------------------- GROUPS ------------------------------------
-------------------------------------------------------------------------------

Cataclysm.groups.WHALE_SHARK = Cataclysm.Group('whale_shark', 237311, {
    defaults = Cataclysm.GROUP_HIDDEN,
    type = Cataclysm.group_types.ACHIEVEMENT,
    achievement = 4975,
    label = '{achievement:4975}'
})

-------------------------------------------------------------------------------
------------------------------------ RARES ------------------------------------
-------------------------------------------------------------------------------

local Poseidus = Rare({
    id = 50005,
    fgroup = 'poseidus',
    rewards = {
        Mount({item = 67151, id = 420}),
        Transmog({item = 67131, slot = L['cloak']}),
        Transmog({item = 67132, slot = L['cloth']}),
        Transmog({item = 67133, slot = L['cloth']}),
        Transmog({item = 67134, slot = L['cloak']}),
        Transmog({item = 67135, slot = L['leather']}),
        Transmog({item = 67140, slot = L['cloak']}),
        Transmog({item = 67141, slot = L['plate']}),
        Transmog({item = 67142, slot = L['cloak']}),
        Transmog({item = 67143, slot = L['plate']}),
        Transmog({item = 67144, slot = L['plate']}),
        Transmog({item = 67145, slot = L['shield']}),
        Transmog({item = 67146, slot = L['cloth']}),
        Transmog({item = 67147, slot = L['cloth']}),
        Transmog({item = 67148, slot = L['mail']}),
        Transmog({item = 67149, slot = L['offhand']}),
        Transmog({item = 67150, slot = L['mail']})
    }
}) -- Poseidus

depths.nodes[40407380] = Poseidus
expanse.nodes[44604960] = Poseidus
expanse.nodes[39406880] = Poseidus
expanse.nodes[65804320] = Poseidus
expanse.nodes[57208080] = Poseidus

expanse.nodes[57006960] = Rare({id = 50052, rewards = {Toy({item = 134022})}}) -- Burgy Blackheart

depths.nodes[63123162] = Rare({
    id = 50009,
    rewards = {
        Transmog({item = 69843, slot = L['polearm']}),
        Transmog({item = 67131, slot = L['cloak']}),
        Transmog({item = 67132, slot = L['cloth']}),
        Transmog({item = 67133, slot = L['cloth']}),
        Transmog({item = 67134, slot = L['cloak']}),
        Transmog({item = 67135, slot = L['leather']}),
        Transmog({item = 67140, slot = L['cloak']}),
        Transmog({item = 67141, slot = L['plate']}),
        Transmog({item = 67142, slot = L['cloak']}),
        Transmog({item = 67143, slot = L['plate']}),
        Transmog({item = 67144, slot = L['plate']}),
        Transmog({item = 67145, slot = L['shield']}),
        Transmog({item = 67146, slot = L['cloth']}),
        Transmog({item = 67147, slot = L['cloth']}),
        Transmog({item = 67148, slot = L['mail']}),
        Transmog({item = 67149, slot = L['offhand']}),
        Transmog({item = 67150, slot = L['mail']})
    },
    pois = {Path({Cataclysm.poi.Circle({origin = 70502950, radius = 7.5})})}
}) -- Mobus

depths.nodes[46202980] = Rare({
    id = 50050,
    rewards = {Transmog({item = 67233, slot = L['plate']})},
    pois = {POI({41803280, 48203440, 51003220, 48402640, 48002760})}
}) -- Shok'sharak

expanse.nodes[56804220] = Rare({
    id = 40728,
    rewards = {Cataclysm.reward.Achievement({id = 4975})}, -- From Hell's Heart I Stab at Thee
    group = {Cataclysm.groups.RARE, Cataclysm.groups.WHALE_SHARK},
    pois = {
        Path({
            64403820, 60404000, 55804280, 52804440, 50204800, 48805280,
            48806000, 50606500, 53806980, 60007100
        })
    }
}) -- Whale Shark
