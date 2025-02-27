----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local _, TravelGuide =  ...

local constants = {}
TravelGuide.constants = constants

----------------------------------------------------------------------------------------------------
----------------------------------------------DEFAULTS----------------------------------------------
----------------------------------------------------------------------------------------------------

constants.defaults = {
    profile = {
        icon_scale_portal = 1.5,
        icon_alpha_portal = 1.0,
        icon_scale_boat = 1.5,
        icon_alpha_boat = 1.0,
        icon_scale_zeppelin = 1.5,
        icon_alpha_zeppelin = 1.0,
        icon_scale_covenant = 1.3,
        icon_alpha_covenant = 1.0,
        icon_scale_tram = 1.5,
        icon_alpha_tram = 1.0,
        icon_scale_animaGateway = 1.5,
        icon_alpha_animaGateway = 1.0,
        icon_scale_teleportPlatform = 1.5,
        icon_alpha_teleportPlatform = 1.0,
        icon_scale_molemachine = 1.5,
        icon_alpha_molemachine = 1.0,
        icon_scale_others = 1.5,
        icon_alpha_others = 1.0,

        show_portal = true,
        show_orderhall = true,
        show_warfront = true,
        show_petBattlePortal = true,
        show_ogreWaygate = true,
        show_reflectivePortal = true,
        show_tram = true,
        show_boat = true,
        show_aboat = true,
        show_zeppelin = true,
        show_hzeppelin = true,
        show_note = true,
        remove_unknown = false,
        remove_AreaPois = true,
        easy_waypoint = true,
        easy_waypoint_dropdown = 1,
        show_animaGateway = true,
        show_teleportPlatform = true,
        show_molemachine = true,
        -- show_others = true,

        force_nodes = false,
        show_prints = false,
    },
    global = {
        dev = false,
    },
    char = {
        hidden = {
            ['*'] = {},
        },
    },
}

----------------------------------------------------------------------------------------------------
------------------------------------------------ICONS-----------------------------------------------
----------------------------------------------------------------------------------------------------

constants.icongroup = {
    "portal",
    "boat",
    "zeppelin",
    "tram",
    "molemachine",
    "animaGateway",
    "teleportPlatform"
}

constants.icon = {
    portal            = "Interface\\AddOns\\HandyNotes\\Icons\\portal_blue",
    orderhall         = "Interface\\AddOns\\HandyNotes\\Icons\\portal_blue",
    petBattlePortal   = "Interface\\AddOns\\HandyNotes\\Icons\\portal_blue",
    portal_red        = "Interface\\AddOns\\HandyNotes\\Icons\\portal_red",
    ogreWaygate       = "Interface\\AddOns\\HandyNotes\\Icons\\portal_ogre",
    portal_purple     = "Interface\\AddOns\\HandyNotes\\Icons\\portal_purple",
    portal_mixed      = "Interface\\AddOns\\HandyNotes\\Icons\\portal_mixed",
    boat              = "Interface\\AddOns\\HandyNotes\\Icons\\boat",
    aboat             = "Interface\\AddOns\\HandyNotes\\Icons\\boat_alliance",
    boat_x            = "Interface\\AddOns\\HandyNotes\\Icons\\boat_grey_x",
    tram              = "Interface\\AddOns\\HandyNotes\\Icons\\tram",
    flightMaster      = "Interface\\MINIMAP\\TRACKING\\FlightMaster",
    zeppelin          = "Interface\\AddOns\\HandyNotes\\Icons\\zeppelin",
    hzeppelin         = "Interface\\AddOns\\HandyNotes\\Icons\\zeppelin_horde",
    zeppelin_x        = "Interface\\AddOns\\HandyNotes\\icons\\zeppelin_grey_x",
    worderhall        = "Interface\\AddOns\\HandyNotes\\Icons\\warrior",
    teleportPlatform  = "Interface\\MINIMAP\\TempleofKotmogu_ball_cyan",
    animaGateway      = "Interface\\AddOns\\HandyNotes\\Icons\\platform",
    molemachine       = "Interface\\AddOns\\HandyNotes\\Icons\\molemachine",
    molemachine_x     = "Interface\\AddOns\\HandyNotes\\Icons\\molemachine_grey_x"
}


----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local addon = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_TravelGuide", "AceEvent-3.0")
local AceDB = LibStub("AceDB-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HBD = LibStub('HereBeDragons-2.0')
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes")
TravelGuide.locale = L

_G.HandyNotes_TravelGuide = addon

local IsQuestCompleted = C_QuestLog.IsQuestFlaggedCompleted
local IsQuestCompletedOnAccount = C_QuestLog.IsQuestFlaggedCompletedOnAccount

local portal_red       = TravelGuide.constants.icon.portal_red
local BoatX            = TravelGuide.constants.icon.boat_x
local ZeppelinX        = TravelGuide.constants.icon.zeppelin_x
local molemachineX     = TravelGuide.constants.icon.molemachine_x

----------------------------------------------------------------------------------------------------
-----------------------------------------------LOCALS-----------------------------------------------
----------------------------------------------------------------------------------------------------

local requires          = L["handler_tooltip_requires"]
local notavailable      = L["handler_tooltip_not_available"]
-- local available       = L["handler_tooltip_available"] -- not in use
local RequiresPlayerLvl = L["handler_tooltip_requires_level"]
local RequiresQuest     = L["handler_tooltip_quest"]
local RequiresRep       = L["handler_tooltip_rep"]
local RequiresToy       = L["handler_tooltip_toy"]
local RetrievingData    = L["handler_tooltip_data"]
local sanctum_feature   = L["handler_tooltip_sanctum_feature"]
local TNRank            = L["handler_tooltip_TNTIER"]

local areaPoisToRemove = {
    -- Alliance
    [5846] = true, -- Vol'dun
    [5847] = true, -- Nazmir
    [5848] = true, -- Zuldazar
    [5873] = true, -- Dustwallow Marsh, Boat to Menethil Harbor, Wetlands
    [5874] = true, -- Wetlands, Boat to Theramore Isle, Dustwallow Marsh
    [5875] = true, -- Wetlands, Boat to Daggercap Bay, Howling Fjord
    [5876] = true, -- Howling Fjord, Boat to Menethil Harbor, Wetlands
    [5877] = true, -- Borean Tundra, Boat to Stormwind City
    [5878] = true, -- Stormwind, Boat to Valiance Keep, Borean Tundra
    [5879] = true, -- Stormwind, Boat to Boralus Harbor, Tiragarde Sound
    [5880] = true, -- Tiragarde Sound, Boat to Stormwind City
    [5892] = true, -- The Jade Forest, Portal to Stormwind City
    [6014] = true, -- Stormwind Portal Room
    [7340] = true, -- Thaldraszus, Boat to Stormwind
    [7335] = true, -- Stormwind, Boat to Dragon Isle

    -- Horde
    [5843] = true, -- Drustvar
    [5844] = true, -- Tiragarde Sound
    [5845] = true, -- Stormsong Valley
    [5883] = true, -- Northern Stranglethorn, Zeppelin to Orgrimmar
    [5884] = true, -- Orgrimmar, Zeppelin to Grom'gol, Schlingendorntal
    [5885] = true, -- Orgrimmar, Zeppelin to Warsong Hold, Borean Tundra
    [5886] = true, -- Borean Tundra, Zeppelin to Orgrimmar
    [5887] = true, -- Echo Isles, Boat to Dazar'alor, Zuldazar
    [5888] = true, -- Zuldazar, Boat to Echo Isles, Durotar
    [5890] = true, -- The Jade Forest, Portal to Orgrimmar
    [6015] = true, -- Orgrimmar Portal Room
    [6138] = true, -- Mechagon
    [7339] = true, -- Thaldraszus, Zeppelin to Orgrimmar
    [7341] = true, -- Durotar, Zeppelin to the Waking Shores, Dragon Isles

    -- Neutral
    [5881] = true, -- The Cape of Stranglethorn, Boat to Ratschet
    [5882] = true, -- Northern Barrens, Boat to Booty
    [7017] = true, -- Oribos, Portal to Korthia
    [7019] = true, -- Oribos, Portal to Zereth Mortis
    [7020] = true, -- Zereth Mortis, Portalstone to Oribos
    [7944] = true, -- Amirdrassil, Boat to Stormglen
    [7945] = true, -- Gilneas, Boat to Belanaar
    [7959] = true, -- Dustwallow Marsh, Portal to Dalaran
    [7960] = true, -- Dragonblight, Portal to Dalaran
    [7961] = true, -- Searing Gorge, Portal to Dalaran
    [8001] = true, -- Dornogal, Portal to Azj-Kahet
    [8002] = true, -- Azj-Kahet, Portal to Dornogal
    [8003] = true, -- Dornogal, To Ringing Deeps
    [8004] = true, -- Ringing Deeps, to Isle of Dorn (bottom)
    [8006] = true, -- Isle of Dorn, To Ringing Deeps (bottom)
    [8009] = true, -- Isle of Dorn, To Ringing Deeps (top)
    [8010] = true, -- Ringing Deeps, to Isle of Dorn (middle)
    [8171] = true, -- Dornogal, Portal to the Timeways
    [8247] = true, -- Ringing Deeps, Mole Machine to Siren Isle
    [8248] = true, -- Isle of Dorn, Zeppelin to Siren Isle
    [8249] = true, -- Siren Isle, Zeppelin to Dornogal
    [8250] = true, -- Siren Isle, Mole Machine to Gundargaz
    [8230] = true, -- Dornogal, Teleporter to Undermine
    [8231] = true, -- Undermine, Teleporter to Dornogal
}

----------------------------------------------------------------------------------------------------
---------------------------------------------HookScript---------------------------------------------
----------------------------------------------------------------------------------------------------

-- This will remove specified AreaPois on the WorldMapFrame
local function RemoveAreaPOIs()
    if (not TravelGuide.db.remove_AreaPois) then return end

    for pin in WorldMapFrame:EnumeratePinsByTemplate("AreaPOIPinTemplate") do
        local areaPoiID = pin.poiInfo.areaPoiID
        if (areaPoisToRemove[areaPoiID]) then
            WorldMapFrame:RemovePin(pin)
            addon:debugmsg("removed AreaPOI "..areaPoiID.." "..pin.poiInfo.name)
        end
    end
end

----------------------------------------------------------------------------------------------------
----------------------------------------------FUNCTIONS---------------------------------------------
----------------------------------------------------------------------------------------------------

-- returns the controlling faction
local function GetWarfrontState(id)
    -- Battle for Stromgarde 11, Battle for Darkshore 118
    local state = C_ContributionCollector.GetState(id)

    return (state == 1 or state == 2) and "Alliance" or "Horde"
end

-- returns the note for mixed portals
local function SetWarfrontNote()
    local astate = GetWarfrontState(11) -- Battle for Stromgarde
    local dstate = GetWarfrontState(118) -- Battle for Darkshore

    return (astate ~= select(1, UnitFactionGroup("player")) and notavailable or " ").."\n"..(dstate ~= select(1, UnitFactionGroup("player")) and notavailable or " ")
end

-- returns true when all requirements are fulfilled
local function ReqFulfilled(req, ...)
    local PLAYERLVL = UnitLevel("player")
    local REQLVL = req.timetravel and req.timetravel.level or 50

    if (req.quest and not req.accquest and not IsQuestCompleted(req.quest))
    or (req.quest and req.accquest and not IsQuestCompletedOnAccount(req.quest))
    or (req.level and (PLAYERLVL < req.level))
    or (req.sanctumtalent and not C_Garrison.GetTalentInfo(req.sanctumtalent).researched)
    or (req.timetravel and PLAYERLVL >= REQLVL and not IsQuestCompleted(req.timetravel.quest) and not req.warfront and not req.timetravel.turn)
    or (req.timetravel and PLAYERLVL >= REQLVL and IsQuestCompleted(req.timetravel.quest) and req.warfront and not req.timetravel.turn)
    or (req.timetravel and PLAYERLVL >= REQLVL and IsQuestCompleted(req.timetravel.quest) and not req.warfront and req.timetravel.turn)
    or (req.warfront and GetWarfrontState(req.warfront) ~= select(1, UnitFactionGroup("player")))
    or (req.spell and not IsSpellKnown(req.spell))
    or (req.toy and not PlayerHasToy(req.toy))
    then
        return false
    end

    if (req.reputation) then
        local standing = C_Reputation.GetFactionDataByID(req.reputation[1]).currentStanding
        return standing >= req.reputation[2]
    end

    if (req.multiquest) then
        for i, quest in pairs(req.multiquest) do
            local isAccwide = req.multiaccquest and req.multiaccquest[i]
            if ((not isAccwide and not IsQuestCompleted(quest)) or (isAccwide and not IsQuestCompletedOnAccount(quest))) then return false end
        end
    end

    if (req.multilevel) then
        for i, level in pairs(req.multilevel) do
            if (PLAYERLVL < level) then return false end
        end

    end

    return true
end

local function RefreshAfter(time)
    C_Timer.After(time, function() addon:Refresh() end)
end

-- workaround to prepare the multilabels with and without notes
-- because the game displays the first line in 14px and
-- the following lines in 13px with a normal for loop.
local function Prepare(label, note, level, quest, accwide)
    local t = {}

    for i, name in ipairs(label) do
        local NOTE = ''
        local LEVEL = ''
        local QUEST = ''
        local questID = quest and quest[i]
        local isAccwide = accwide and accwide[i]

        -- set spell name as label
        if (type(name) == "number") then
            name = C_Spell.GetSpellInfo(name).name
        end

        -- add additional notes
        if (note and note[i] and TravelGuide.db.show_note) then
            NOTE = " ("..note[i]..")"
        end

        -- add required level information
        if (level and level[i] and UnitLevel("player") < level[i]) then
            LEVEL = "\n    |cFFFF0000"..RequiresPlayerLvl..": "..level[i].."|r"
        end

        -- add required quest information
        if (questID and ((isAccwide and not IsQuestCompletedOnAccount(questID)) or (not isAccwide and not IsQuestCompleted(questID)))) then
            local title = C_QuestLog.GetTitleForQuestID(quest[i])
            if (title ~= nil) then
                QUEST = "\n    |cFFFF0000"..RequiresQuest..": ["..title.."] (ID: "..quest[i]..")|r" -- red
            else
                QUEST = "\n    |cFFFF00FF"..RetrievingData.."|r" -- pink
                RefreshAfter(1) -- Refresh
            end
        end

        -- store everything together
        t[i] = name..NOTE..LEVEL..QUEST
    end
    return table.concat(t, "\n")
end

----------------------------------------------------------------------------------------------------
------------------------------------------------ICON------------------------------------------------
----------------------------------------------------------------------------------------------------

local function SetIcon(node)
    local icon_key = node.icon

    if (icon_key and TravelGuide.constants.icon[icon_key]) then
        return TravelGuide.constants.icon[icon_key]
    end
end

local function GetIconScale(icon)
    if (icon == "portal" or icon == "orderhall" or icon == "portal_mixed" or icon == "petBattlePortal" or icon == "ogreWaygate" or icon == "portal_purple") then
        return TravelGuide.db["icon_scale_portal"]
    elseif (icon == "boat" or icon == "aboat") then
        return TravelGuide.db["icon_scale_boat"]
    elseif (icon == "zeppelin" or icon == "hzeppelin") then
        return TravelGuide.db["icon_scale_zeppelin"]
    end

    return TravelGuide.db["icon_scale_"..icon] or TravelGuide.db["icon_scale_others"]
end

local function GetIconAlpha(icon)
    if (icon == "portal" or icon == "orderhall" or icon == "portal_mixed" or icon == "petBattlePortal" or icon == "ogreWaygate" or icon == "portal_purple") then
        return TravelGuide.db["icon_alpha_portal"]
    elseif (icon == "boat" or icon == "aboat") then
        return TravelGuide.db["icon_alpha_boat"]
    elseif (icon == "zeppelin" or icon == "hzeppelin") then
        return TravelGuide.db["icon_alpha_zeppelin"]
    end

    return TravelGuide.db["icon_alpha_"..icon] or TravelGuide.db["icon_alpha_others"]
end

local GetNodeInfo = function(node)
    local icon

    if (node) then
        local label = node.label or node.multilabel and Prepare(node.multilabel) or UNKNOWN
        if (node.requirements and not ReqFulfilled(node.requirements)) then
            icon = ((node.icon == "portal" or node.icon == "orderhall" or node.icon == "portal_mixed" or node.icon == "petBattlePortal" or node.icon == "ogreWaygate" or node.icon == "portal_purple") and portal_red)
            or (node.icon == "boat" and BoatX)
            or (node.icon == "zeppelin" and ZeppelinX)
            or (node.icon == "molemachine" and molemachineX)
        else
            icon = SetIcon(node)
        end
        return label, icon, node.icon, node.scale, node.alpha
    end
end

local GetNodeInfoByCoord = function(uMapID, coord)
    return GetNodeInfo(TravelGuide.DB.nodes[uMapID] and TravelGuide.DB.nodes[uMapID][coord])
end

----------------------------------------------------------------------------------------------------
----------------------------------------------TOOLTIP-----------------------------------------------
----------------------------------------------------------------------------------------------------

local function SetTooltip(tooltip, node)
    if (not node) then
        tooltip:SetText(UNKNOWN)
        tooltip:Show()
        return
    end

    local reqs = node.requirements
    if (node.label) then
        tooltip:AddLine(node.label)
    end
    if (node.note and TravelGuide.db.show_note) then
        tooltip:AddLine("("..node.note..")")
    end
    if (node.multilabel and node.icon ~= "portal_mixed") then
        if (reqs) then
            tooltip:AddLine(Prepare(node.multilabel, node.multinote, reqs.multilevel, reqs.multiquest, reqs.multiaccquest))
        else
            tooltip:AddLine(Prepare(node.multilabel, node.multinote))
        end
    end
    if (node.npc) then
        tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(node.npc))
    end
    if (node.icon == "portal_mixed") then
        tooltip:AddDoubleLine(Prepare(node.multilabel, node.multinote), SetWarfrontNote(), nil, nil, nil, 1) -- only the second line is red
    end
    if (reqs) then
        if (reqs.warfront and GetWarfrontState(reqs.warfront) ~= select(1, UnitFactionGroup("player"))) then
            tooltip:AddLine(notavailable, 1) -- red
        end
        if (reqs.level and UnitLevel("player") < reqs.level) then
            tooltip:AddLine(RequiresPlayerLvl..": "..reqs.level, 1) -- red
        end
        if (reqs.quest) then
            local questNotCompleted = (not reqs.accquest and not IsQuestCompleted(reqs.quest))
            local questNotCompletedOnAccount = (reqs.accquest and not IsQuestCompletedOnAccount(reqs.quest))
            if (questNotCompleted or questNotCompletedOnAccount) then
                if (not reqs.hideQuestName) then
                    local questTitle = C_QuestLog.GetTitleForQuestID(reqs.quest)
                    if (questTitle) then
                        tooltip:AddLine(RequiresQuest..": ["..questTitle.."] (ID: "..reqs.quest..")", 1, 0, 0)
                    else
                        tooltip:AddLine(RetrievingData, 1, 0, 1) -- pink
                        RefreshAfter(1) -- Refresh
                    end
                elseif (reqs.item) then -- OgreWaygate
                    local name = C_Item.GetItemNameByID(reqs.item[1]) or RetrievingData
                    local quantity = reqs.item[2]
                    if name == RetrievingData then RefreshAfter(1) end

                    tooltip:AddLine(requires..": "..quantity.."x "..name, 1) -- red
                elseif (node.icon == "molemachine") then
                    tooltip:AddLine(L["handler_tooltip_not_discovered"], 1) -- red
                end
            end
        end
        if (reqs.reputation) then
            local reqValuesForStandings = {0, 36000, 39000, 42000, 45000, 51000, 63000, 84000}
            local faction = C_Reputation.GetFactionDataByID(reqs.reputation[1])
            if (faction and faction.reaction < reqs.reputation[2]) then
                local reqValue = reqValuesForStandings[reqs.reputation[2]]
                local value = faction.currentStanding
                tooltip:AddLine(RequiresRep..": ", 1) -- red
                GameTooltip_ShowProgressBar(GameTooltip, 0, reqValue, value, faction.name..": "..value.." / "..reqValue)
            end
        end

        local REQLVL = reqs.timetravel and reqs.timetravel.level or 50
        if (reqs.timetravel and UnitLevel("player") >= REQLVL) then
            local spellName = C_Spell.GetSpellInfo(reqs.timetravel["spell"]).name
            if (spellName) then
                local questCompleted = IsQuestCompleted(reqs.timetravel.quest)
                if (not questCompleted and not reqs.warfront and not reqs.timetravel["turn"])
                or (questCompleted and reqs.warfront and not reqs.timetravel["turn"])
                or (questCompleted and not reqs.warfront and reqs.timetravel["turn"]) then
                    tooltip:AddLine(requires..': '..spellName, 1) -- text red / uncompleted
                end
            end
        end
        if (reqs.spell) then -- don't show this if the spell is known
            local spellName = C_Spell.GetSpellInfo(reqs.spell).name
            local isKnown = IsSpellKnown(reqs.spell)
            if (spellName and not isKnown) then
                tooltip:AddLine(requires..': '..spellName, 1) -- red
            end
        end
        if (reqs.toy) then
            local toyName = C_Item.GetItemInfo(reqs.toy) or RetrievingData
            local isKnown = PlayerHasToy(reqs.toy)
            if (toyName == RetrievingData) then RefreshAfter(1) end

            if (not isKnown) then
                tooltip:AddLine(RequiresToy..': '..toyName, 1) -- red
            end
        end
        if (node.covenant and reqs.sanctumtalent) then
            local TALENT = C_Garrison.GetTalentInfo(reqs.sanctumtalent)
            if (not TALENT["researched"]) then
                tooltip:AddLine(requires.." "..sanctum_feature..":", 1) -- red
                tooltip:AddLine(TALENT["name"], 1, 1, 1) -- white
                tooltip:AddTexture(TALENT["icon"], {margin = {right = 2}})
                tooltip:AddLine("   • "..format(TNRank, TALENT["tier"] + 1), 0.6, 0.6, 0.6) -- grey
            end
        end
    end

    tooltip:Show()
end

local SetTooltipByCoord = function(tooltip, uMapID, coord)
    return SetTooltip(tooltip, TravelGuide.DB.nodes[uMapID] and TravelGuide.DB.nodes[uMapID][coord])
end

----------------------------------------------------------------------------------------------------
-------------------------------------------PluginHandler--------------------------------------------
----------------------------------------------------------------------------------------------------

local PluginHandler = {}
local info = {}

function PluginHandler:OnEnter(uMapID, coord)
    local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
    if (self:GetCenter() > UIParent:GetCenter()) then -- compare X coordinate
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    SetTooltipByCoord(tooltip, uMapID, coord)
end

function PluginHandler:OnLeave(uMapID, coord)
    if (self:GetParent() == WorldMapButton) then
        WorldMapTooltip:Hide()
    else
        GameTooltip:Hide()
    end
end

local function hideNode(button, uMapID, coord)
    TravelGuide.hidden[uMapID][coord] = true
    addon:Refresh()
end

local function closeAllDropdowns()
    CloseDropDownMenus(1)
end

local function addTomTomWaypoint(button, uMapID, coord)
    if (C_AddOns.IsAddOnLoaded("TomTom")) then
        local x, y = HandyNotes:getXY(coord)
        TomTom:AddWaypoint(uMapID, x, y, {
            title = GetNodeInfoByCoord(uMapID, coord),
            from = L["handler_context_menu_addon_name"],
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

local function addBlizzardWaypoint(button, uMapID, coord)
    local x, y = HandyNotes:getXY(coord)
    local parentMapID = C_Map.GetMapInfo(uMapID)["parentMapID"]
    if (not C_Map.CanSetUserWaypointOnMap(uMapID)) then
        local wx, wy = HBD:GetWorldCoordinatesFromZone(x, y, uMapID)
        uMapID = parentMapID
        x, y = HBD:GetZoneCoordinatesFromWorld(wx, wy, parentMapID)
    end

    C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(uMapID, x, y))
    C_SuperTrack.SetSuperTrackedUserWaypoint(true)
end

--------------------------------------------CONTEXT MENU--------------------------------------------

do
    local currentMapID = nil
    local currentCoord = nil
    local function generateMenu(button, level)
        if (not level) then return end
        if (level == 1) then

            -- Create the title of the menu
            UIDropDownMenu_AddButton({
                isTitle = true,
                text = L["handler_context_menu_addon_name"],
                notCheckable = true
            }, level)

            -- TomTom waypoint menu item
            if (C_AddOns.IsAddOnLoaded("TomTom")) then
                UIDropDownMenu_AddButton({
                    text = L["handler_context_menu_add_tomtom"],
                    notCheckable = true,
                    func = addTomTomWaypoint,
                    arg1 = currentMapID,
                    arg2 = currentCoord
                }, level)
            end

            -- Blizzard waypoint menu item
            UIDropDownMenu_AddButton({
                text = L["handler_context_menu_add_map_pin"],
                notCheckable = true,
                func = addBlizzardWaypoint,
                arg1 = currentMapID,
                arg2 = currentCoord
            }, level)

            -- Hide menu item
            UIDropDownMenu_AddButton({
                text         = L["handler_context_menu_hide_node"],
                notCheckable = true,
                func         = hideNode,
                arg1         = currentMapID,
                arg2         = currentCoord
            }, level)

            -- Close menu item
            UIDropDownMenu_AddButton({
                text         = CLOSE,
                func         = closeAllDropdowns,
                notCheckable = true
            }, level)

        end
    end

    local HL_Dropdown = CreateFrame("Frame", "HandyNotes_TravelGuideDropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function PluginHandler:OnClick(button, down, uMapID, coord)
        local TomTom = select(2, C_AddOns.IsAddOnLoaded('TomTom'))
        local dropdown = TravelGuide.db.easy_waypoint_dropdown

        if (down or button ~= "RightButton") then return end

        if (button == "RightButton" and not down and not TravelGuide.db.easy_waypoint) then
            currentMapID = uMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        elseif (IsControlKeyDown() and TravelGuide.db.easy_waypoint) then
            currentMapID = uMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        elseif (not TomTom or dropdown == 1) then
            addBlizzardWaypoint(button, uMapID, coord)
        elseif (TomTom and dropdown == 2) then
            addTomTomWaypoint(button, uMapID, coord)
        else
            addBlizzardWaypoint(button, uMapID, coord)
            if (TomTom) then addTomTomWaypoint(button, uMapID, coord) end
        end
    end
end

do
    local currentMapID = nil
    local function iter(t, prestate)
        if (not t) then return nil end
        local state, value = next(t, prestate)
        while state do
            if (value and TravelGuide:ShouldShow(state, value, currentMapID)) then
                local _, icon, iconname, scale, alpha = GetNodeInfo(value)
                    scale = (scale or 1) * GetIconScale(iconname)
                    alpha = (alpha or 1) * GetIconAlpha(iconname)
                return state, nil, icon, scale, alpha
            end
            state, value = next(t, state)
        end
        return nil, nil, nil, nil, nil, nil
    end

    function PluginHandler:GetNodes2(uMapID, minimap)
        currentMapID = uMapID
        return iter, TravelGuide.DB.nodes[uMapID], nil
    end

    function TravelGuide:ShouldShow(coord, node, currentMapID)
        if (not TravelGuide.db.force_nodes) then
            if (TravelGuide.hidden[currentMapID] and TravelGuide.hidden[currentMapID][coord]) then return false end
            if (node.requirements and TravelGuide.db.remove_unknown and not ReqFulfilled(node.requirements)) then return false end
            if (node.class and node.class ~= select(2, UnitClass("player"))) then return false end
            if (node.faction and node.faction ~= select(1, UnitFactionGroup("player"))) then return false end
            if (node.race and node.race ~= select(2, UnitRace("player"))) then return false end
            if (node.covenant and node.covenant ~= C_Covenants.GetActiveCovenantID()) then return false end
            if (node.icon == "portal" and not TravelGuide.db.show_portal) then return false end
            if (node.icon == "orderhall" and not TravelGuide.db.show_orderhall) then return false end
            if (node.icon == "worderhall" and not TravelGuide.db.show_orderhall) then return false end
            if (node.requirements and node.requirements.warfront and not TravelGuide.db.show_warfront) then return false end
            if (node.icon == "portal_mixed" and not TravelGuide.db.show_warfront) then return false end
            if (node.icon == "petBattlePortal" and not TravelGuide.db.show_petBattlePortal) then return false end
            if (node.icon == "ogreWaygate" and not TravelGuide.db.show_ogreWaygate) then return false end
            if (node.icon == "portal_purple" and not TravelGuide.db.show_reflectivePortal) then return false end
            if (node.icon == "flightMaster" and not TravelGuide.db.show_orderhall) then return false end
            if (node.icon == "tram" and not TravelGuide.db.show_tram) then return false end
            if (node.icon == "boat" and not TravelGuide.db.show_boat) then return false end
            if (node.icon == "aboat" and not TravelGuide.db.show_aboat) then return false end
            if (node.icon == "zeppelin" and not TravelGuide.db.show_zeppelin) then return false end
            if (node.icon == "hzeppelin" and not TravelGuide.db.show_hzeppelin) then return false end
            if (node.icon == "animaGateway" and not TravelGuide.db.show_animaGateway) then return false end
            if (node.icon == "teleportPlatform" and not TravelGuide.db.show_teleportPlatform) then return false end
            if (node.icon == "molemachine" and not TravelGuide.db.show_molemachine) then return false end
        end
        return true
    end
end

---------------------------------------------------------------------------------------------------
----------------------------------------------REGISTER---------------------------------------------
---------------------------------------------------------------------------------------------------

function addon:OnInitialize()
    self.db = AceDB:New("HandyNotes_TravelGuideDB", TravelGuide.constants.defaults, true)
    self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
    self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
    self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")

    TravelGuide.db = self.db.profile
    TravelGuide.global = self.db.global
    TravelGuide.hidden = self.db.char.hidden

    -- Initialize database with HandyNotes
    HandyNotes:RegisterPluginDB(addon.pluginName, PluginHandler, TravelGuide.config.options)
    -- Get the option table for profiles
    TravelGuide.config.options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    TravelGuide.config.options.args.profiles.order = 2

    -- Get the options table for development
    if (TravelGuide.global.dev) then TravelGuide.devmode() end
end

function addon:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", addon.pluginName)
end

function addon:OnEnable()
end

function addon:OnProfileChanged(event, database, newProfileKey)
    TravelGuide.db = database.profile
    self:Refresh()
end

----------------------------------------------EVENTS-----------------------------------------------

local frame, events = CreateFrame("Frame"), {};
function events:ZONE_CHANGED(...)
    addon:Refresh()

    addon:debugmsg("refreshed after ZONE_CHANGED")
end

function events:ZONE_CHANGED_INDOORS(...)
    addon:Refresh()

    addon:debugmsg("refreshed after ZONE_CHANGED_INDOORS")
end

function events:QUEST_FINISHED(...)
    addon:Refresh()

    addon:debugmsg("refreshed after QUEST_FINISHED")
end

function events:PLAYER_LOGIN(...)
    -- Hook the RefreshAllData() function of the "AreaPOIPinTemplate" data provider
    for dp in pairs(WorldMapFrame.dataProviders) do
        if (not dp.GetPinTemplates and type(dp.GetPinTemplate) == "function") then
            if (dp:GetPinTemplate() == "AreaPOIPinTemplate") then
                hooksecurefunc(dp, "RefreshAllData", RemoveAreaPOIs)
            end
        end
    end
end

frame:SetScript("OnEvent", function(self, event, ...)
    events[event](self, ...); -- call one of the functions above
end);

for k, v in pairs(events) do
    frame:RegisterEvent(k); -- Register all events for which handlers have been defined
end

----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------
addon.pluginName  = L["TravelGuide_plugin_name"]
addon.description = L["TravelGuide_plugin_desc"]

----------------------------------------------------------------------------------------------------
-----------------------------------------------CONFIG-----------------------------------------------
----------------------------------------------------------------------------------------------------

local config = {}
TravelGuide.config = config

config.options = {
    type = "group",
    name = addon.pluginName,
    desc = addon.description,
    childGroups = "tab",
    get = function(info) return TravelGuide.db[info[#info]] end,
    set = function(info, v)
        TravelGuide.db[info[#info]] = v
        addon:SendMessage("HandyNotes_NotifyUpdate", addon.pluginName)
    end,
    args = {
    ICONDISPLAY = {
        type = "group",
        name = L["config_tab_general"],
--      desc = L[""],
        order = 0,
        args = {
            display = {
            type = "group",
            name = L["config_what_to_display"],
            inline = true,
            order = 10,
            args = {
                desc = {
                    type = "description",
                    name = L["config_what_to_display_desc"],
                    order = 11,
                },
                show_portal = {
                    type = "toggle",
                    name = L["config_portal"],
                    desc = L["config_portal_desc"],
                    order = 12.0,
                },
                show_orderhall = {
                    type = "toggle",
                    name = L["config_order_hall_portal"],
                    desc = L["config_order_hall_portal_desc"],
                    order = 12.1,
                },
                show_warfront = {
                    type = "toggle",
                    name = L["config_warfront_portal"],
                    desc = L["config_warfront_portal_desc"],
                    order = 12.2,
                },
                show_petBattlePortal = {
                    type = "toggle",
                    name = L["config_petbattle_portal"],
                    desc = L["config_petbattle_portal_desc"],
                    order = 12.3,
                },
                show_ogreWaygate = {
                    type = "toggle",
                    name = L["config_ogreWaygate"],
                    desc = L["config_ogreWaygate_desc"],
                    order = 12.4,
                },
                show_reflectivePortal = {
                    type = "toggle",
                    name = L["config_show_reflectivePortal"],
                    desc = L["config_show_reflectivePortal_desc"],
                    order = 12.5,
                },
                show_boat = {
                    type = "toggle",
                    name = L["config_boat"],
                    desc = L["config_boat_desc"],
                    order = 15,
                },
                show_aboat = {
                    type = "toggle",
                    name = L["config_boat_alliance"],
                    desc = L["config_boat_alliance_desc"],
                    hidden = function() return select(1, UnitFactionGroup("player")) == "Alliance" end,
                    order = 16,
                },
                show_zeppelin = {
                    type = "toggle",
                    name = L["config_zeppelin"],
                    desc = L["config_zeppelin_desc"],
                    hidden = function() return select(1, UnitFactionGroup("player")) == "Alliance" end,
                    order = 17,
                },
                show_hzeppelin = {
                    type = "toggle",
                    name = L["config_zeppelin_horde"],
                    desc = L["config_zeppelin_horde_desc"],
                    hidden = function() return select(1, UnitFactionGroup("player")) == "Horde" end,
                    order = 18,
                },
                show_tram = {
                    type = "toggle",
                    name = L["config_tram"],
                    desc = L["config_tram_desc"],
                    order = 19,
                },
                show_molemachine = {
                    type = "toggle",
                    name = L["config_molemachine"],
                    desc = L["config_molemachine_desc"],
                    order = 20,
                },
                show_note = {
                    type = "toggle",
                    name = L["config_note"],
                    desc = L["config_note_desc"],
                    order = 21,
                },
                shadowlands_line = {
                    type = "header",
                    name = "",
                    order = 22,
                },
                show_animaGateway = {
                    type = "toggle",
                    width = "full",
                    name = L["config_animaGateway"],
                    desc = L["config_animaGateway_desc"],
                    order = 23,
                },
                show_teleportPlatform = {
                    type = "toggle",
                    width = "full",
                    name = L["config_teleportPlatform"],
                    desc = L["config_teleportPlatform_desc"],
                    order = 24,
                },
                other_line = {
                    type = "header",
                    name = "",
                    order = 25,
                },
                remove_unknown = {
                    type = "toggle",
                    width = "full",
                    name = L["config_remove_unknown"],
                    desc = L["config_remove_unknown_desc"],
                    order = 25.1,
                },
                remove_AreaPois = {
                    type = "toggle",
                    width = "full",
                    name = L["config_remove_AreaPois"],
                    desc = L["config_remove_AreaPois_desc"],
                    set = function(info, v)
                        TravelGuide.db[info[#info]] = v
                        addon:SendMessage("HandyNotes_NotifyUpdate", addon.pluginName)
                        WorldMapFrame:RefreshAllDataProviders()
                    end,
                    order = 26,
                },
                easy_waypoint = {
                    type = "toggle",
                    width = 1.57,
                    name = L["config_easy_waypoints"],
                    desc = L["config_easy_waypoints_desc"],
                    order = 27,
                },
                easy_waypoint_dropdown = {
                    type = "select",
                    values = { L["Blizzard"], L["TomTom"], L["Both"] },
                    disabled = function() return not TravelGuide.db.easy_waypoint end,
                    hidden = function() return not C_AddOns.IsAddOnLoaded("TomTom") end,
                    name = L["config_waypoint_dropdown"],
                    desc = L["config_waypoint_dropdown_desc"],
                    width = 0.7,
                    order = 27.1,
                },
                unhide = {
                    type = "execute",
                    width = "full",
                    name = L["config_restore_nodes"],
                    desc = L["config_restore_nodes_desc"],
                    func = function()
                        for map,coords in pairs(TravelGuide.hidden) do
                            wipe(coords)
                        end
                        addon:Refresh()
                        print("TravelGuide: "..L["config_restore_nodes_print"])
                    end,
                    order = 28,
                },
            },
            },
        },
    },
    SCALEALPHA = {
        type = "group",
        name = L["config_tab_scale_alpha"],
--      desc = L["config_scale_alpha_desc"],
        order = 1,
        args = {

        },
    },
    },
}

-- create the scale / alpha config menu
for i, icongroup in ipairs(TravelGuide.constants.icongroup) do

    config.options.args.SCALEALPHA.args["name_"..icongroup] = {
        type = "header",
        name = L["config_"..icongroup],
        order = i *10,
    }

    config.options.args.SCALEALPHA.args["icon_scale_"..icongroup] = {
        type = "range",
        name = L["config_icon_scale"],
        desc = L["config_icon_scale_desc"],
        min = 0.25, max = 3, step = 0.01,
        arg = "icon_scale_"..icongroup,
        width = 1.19,
        order = i *10 + 1,
    }

    config.options.args.SCALEALPHA.args["icon_alpha_"..icongroup] = {
        type = "range",
        name = L["config_icon_alpha"],
        desc = L["config_icon_alpha_desc"],
        min = 0, max = 1, step = 0.01,
        arg = "icon_alpha_"..icongroup,
        width = 1.19,
        order = i *10 + 2,
    }
end

----------------------------------------------------------------------------------------------------
-------------------------------------------DEV CONFIG TAB-------------------------------------------
----------------------------------------------------------------------------------------------------

-- Activate the developer mode with:
-- /script HandyNotes_TravelGuideDB.global.dev = true
-- /reload

local function devmode()
    TravelGuide.config.options.args["DEV"] = {
        type = "group",
        name = L["dev_config_tab"],
--      desc = L[""],
        order = 3,
        args = {
                force_nodes = {
                    type = "toggle",
                    name = L["dev_config_force_nodes"],
                    desc = L["dev_config_force_nodes_desc"],
                    order = 0,
                },
                show_prints = {
                    type = "toggle",
                    name = L["dev_config_show_prints"],
                    desc = L["dev_config_show_prints_desc"],
                    order = 1,
                },
        },
    }

    SLASH_TGREFRESH1 = "/tgrefresh"
    SlashCmdList["TGREFRESH"] = function(msg)
        addon:Refresh()
        print("TravelGuide refreshed")
    end

    SLASH_TGWARFRONTS1 = "/tgwarfronts"
    SlashCmdList["TGWARFRONTS"] = function(msg)
        print("~~~~~~~~~~~~~~~~~~~~~~")
        print("TravelGuide: Warfronts")
        print("Arathi: "..C_ContributionCollector.GetState(11)) --Battle for Stromgarde
        print("Darkshore: "..C_ContributionCollector.GetState(118)) --Battle for Darkshore
        print("~~~~~~~~~~~~~~~~~~~~~~")
    end

    SLASH_TG1 = "/tg"
    SlashCmdList["TG"] = function(msg)
        Settings.OpenToCategory('HandyNotes')
        LibStub('AceConfigDialog-3.0'):SelectGroup('HandyNotes', 'plugins', 'TravelGuide')
    end

end

function addon:debugmsg(msg)

    if (TravelGuide.global.dev and TravelGuide.db.show_prints) then
        print("|CFFFF6666TravelGuide: |r"..msg)
    end

end

TravelGuide.devmode = devmode