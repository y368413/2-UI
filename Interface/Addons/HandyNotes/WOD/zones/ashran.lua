-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, WarlordsOfDraenor = ...
local L = WarlordsOfDraenor.locale
local Map = WarlordsOfDraenor.Map

local Collectible = WarlordsOfDraenor.node.Collectible

local Follower = WarlordsOfDraenor.reward.Follower

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local stormshield = Map({id = 622, settings = true})
local warspear = Map({id = 624, settings = true})

-------------------------------------------------------------------------------
---------------------------------- FOLLOWERS ----------------------------------
-------------------------------------------------------------------------------

stormshield.nodes[45307020] = Collectible({
    id = 91479,
    icon = 608952,
    note = L['fen_tao_follower_note'],
    faction = 'Alliance',
    rewards = {Follower({id = 467, icon = 608952})}
}) -- Fen Tao (Alliance)

warspear.nodes[47004500] = Collectible({
    id = 91479,
    icon = 608952,
    note = L['fen_tao_follower_note'],
    faction = 'Horde',
    rewards = {Follower({id = 467, icon = 608952})}
}) -- Fen Tao (Horde)
