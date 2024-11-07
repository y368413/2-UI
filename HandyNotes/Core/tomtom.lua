-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, Core = ...

-------------------------------------------------------------------------------
----------------------------------- TOM TOM -----------------------------------
-------------------------------------------------------------------------------

local function AddSingleWaypoint(node, mapID, coord)
    local x, y = HandyNotes:getXY(coord)
    TomTom:AddWaypoint(mapID, x, y, {
        title = Core.RenderLinks(node.label, true),
        from = Core.plugin_name,
        persistent = nil,
        minimap = true,
        world = true
    })
end

local function AddGroupWaypoints(node, mapID)
    local map = Core.maps[mapID]
    for peerCoord, peerNode in pairs(map.nodes) do
        if peerNode.group[1] == node.group[1] and peerNode:IsEnabled() then
            AddSingleWaypoint(peerNode, mapID, peerCoord)
        end
    end
end

local function AddFocusGroupWaypoints(node, mapID)
    local map = Core.maps[mapID]
    for peerCoord, peerNode in pairs(map.nodes) do
        if peerNode.fgroup == node.fgroup and peerNode:IsEnabled() then
            AddSingleWaypoint(peerNode, mapID, peerCoord)
        end
    end
end

Core.tomtom = {
    AddSingleWaypoint = AddSingleWaypoint,
    AddGroupWaypoints = AddGroupWaypoints,
    AddFocusGroupWaypoints = AddFocusGroupWaypoints
}
