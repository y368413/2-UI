----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local Oribos = {}
local constants = {}
Oribos.constants = constants

----------------------------------------------------------------------------------------------------
----------------------------------------------DEFAULTS----------------------------------------------
----------------------------------------------------------------------------------------------------

constants.defaults = {
    profile = {
        icon_scale_auctioneer = 1.25,
        icon_alpha_auctioneer = 1,
        icon_scale_banker = 1.25,
        icon_alpha_banker = 1,
        icon_scale_barber = 1.25,
        icon_alpha_barber = 1,
        icon_scale_guildvault = 1.3,
        icon_alpha_guildvault = 1,
        icon_scale_innkeeper = 1.25,
        icon_alpha_innkeeper = 1,
        icon_scale_mail = 1.25,
        icon_alpha_mail = 1,
        icon_scale_portal = 1.5,
        icon_alpha_portal = 1,
        icon_scale_portaltrainer = 1.25,
        icon_alpha_portaltrainer = 1,
        icon_scale_reforge = 1.25,
        icon_alpha_reforge = 1,
        icon_scale_stablemaster = 1.25,
        icon_alpha_stablemaster = 1,
        icon_scale_trainer = 1.25,
        icon_alpha_trainer = 1,
        icon_scale_transmogrifier = 1.25,
        icon_alpha_transmogrifier = 1,
        icon_scale_tpplatform = 1.5,
        icon_alpha_tpplatform = 1,
        icon_scale_vendor = 1.25,
        icon_alpha_vendor = 1,
        icon_scale_void = 1.25,
        icon_alpha_void = 1,
        icon_scale_zonegateway = 2,
        icon_alpha_zonegateway = 1,
        -- icon_scale_others = 1.25,
        -- icon_alpha_others = 1,

        show_auctioneer = true,
        show_banker = true,
        show_barber = true,
        show_guildvault = true,
        show_innkeeper = true,
        show_mail = true,
        show_portal = true,
        show_portaltrainer = true,
        show_tpplatform = true,
        show_reforge = true,
        show_stablemaster = true,
        show_trainer = true,
        show_transmogrifier = true,
        show_vendor = true,
        show_void = true,
        show_zonegateway = true,
        -- show_others = true,

        show_onlymytrainers = false,
        use_old_picons = false,
        picons_vendor = false,
        picons_trainer = false,
        fmaster_waypoint = true,
        fmaster_waypoint_dropdown = 1,
        easy_waypoint = true,
        easy_waypoint_dropdown = 1,

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
    "auctioneer",
    -- "anvil",
    "banker",
    "barber",
    "guildvault",
    "innkeeper",
    "mail",
    "portal",
    "portaltrainer",
    "reforge",
    "stablemaster",
    "trainer",
    "transmogrifier",
    "tpplatform",
    "vendor",
    "void",
    "zonegateway"
}

constants.icon = {
    portal          = "Interface\\AddOns\\HandyNotes\\icons\\portal_blue",
    portal_red      = "Interface\\AddOns\\HandyNotes\\icons\\portal_red",

    -- npc/poi icons
    auctioneer      = "Interface\\MINIMAP\\TRACKING\\Auctioneer",
    anvil           = "Interface\\AddOns\\HandyNotes\\icons\\anvil",
    banker          = "Interface\\MINIMAP\\TRACKING\\Banker",
    barber          = "Interface\\MINIMAP\\TRACKING\\Barbershop",
    guildvault      = "Interface\\ICONS\\Achievement_ChallengeMode_Auchindoun_Gold",
    innkeeper       = "Interface\\MINIMAP\\TRACKING\\Innkeeper",
    mail            = "Interface\\MINIMAP\\TRACKING\\Mailbox",
    reforge         = "Interface\\AddOns\\HandyNotes\\icons\\reforge",
    stablemaster    = "Interface\\MINIMAP\\TRACKING\\StableMaster",
    trainer         = "Interface\\MINIMAP\\TRACKING\\Profession",
    portaltrainer   = "Interface\\MINIMAP\\TRACKING\\Profession",
    transmogrifier  = "Interface\\MINIMAP\\TRACKING\\Transmogrifier",
    tpplatform      = "Interface\\MINIMAP\\TempleofKotmogu_ball_cyan",
    vendor          = "Interface\\AddOns\\HandyNotes\\icons\\vendor",
    void            = "Interface\\AddOns\\HandyNotes\\icons\\void",

    -- covenant icons
    kyrian          = "Interface\\AddOns\\HandyNotes\\icons\\kyrian",
    necrolord       = "Interface\\AddOns\\HandyNotes\\icons\\necrolord",
    nightfae        = "Interface\\AddOns\\HandyNotes\\icons\\nightfae",
    venthyr         = "Interface\\AddOns\\HandyNotes\\icons\\venthyr",

    -- profession icons (since Dragonflight)
    alchemy = "Interface\\ICONS\\ui_profession_alchemy",
    blacksmithing = "Interface\\ICONS\\ui_profession_blacksmithing",
    cooking = "Interface\\ICONS\\ui_profession_cooking",
    enchanting = "Interface\\ICONS\\ui_profession_enchanting",
    engineering = "Interface\\ICONS\\ui_profession_engineering",
    fishing = "Interface\\ICONS\\ui_profession_fishing",
    herbalism = "Interface\\ICONS\\ui_profession_herbalism",
    inscription = "Interface\\ICONS\\ui_profession_inscription",
    jewelcrafting = "Interface\\ICONS\\ui_profession_jewelcrafting",
    leatherworking = "Interface\\ICONS\\ui_profession_leatherworking",
    mining = "Interface\\ICONS\\ui_profession_mining",
    skinning = "Interface\\ICONS\\ui_profession_skinning",
    tailoring = "Interface\\ICONS\\ui_profession_tailoring",

    -- profession icons OLD
    alchemy_old = "Interface\\ICONS\\trade_alchemy",
    blacksmithing_old = "Interface\\ICONS\\trade_blacksmithing",
    cooking_old = "Interface\\ICONS\\INV_Misc_Food_15",
    enchanting_old = "Interface\\ICONS\\trade_engraving",
    engineering_old = "Interface\\ICONS\\trade_engineering",
    fishing_old = "Interface\\ICONS\\trade_fishing",
    herbalism_old = "Interface\\ICONS\\spell_nature_naturetouchgrow",
    inscription_old = "Interface\\ICONS\\inv_inscription_tradeskill01",
    jewelcrafting_old = "Interface\\ICONS\\inv_misc_gem_01",
    leatherworking_old = "Interface\\ICONS\\inv_misc_armorkit_17",
    mining_old = "Interface\\ICONS\\trade_mining",
    skinning_old = "Interface\\ICONS\\inv_misc_pelt_wolf_01",
    tailoring_old = "Interface\\ICONS\\trade_tailoring"
}


----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------
local HandyNotes_Oribos = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_Oribos", "AceEvent-3.0")
local AceDB = LibStub("AceDB-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HBD = LibStub('HereBeDragons-2.0')
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes")
Oribos.locale = L

_G.HandyNotes_Oribos = HandyNotes_Oribos

local IsQuestCompleted = C_QuestLog.IsQuestFlaggedCompleted
local constantsicon = Oribos.constants.icon

----------------------------------------------------------------------------------------------------
-----------------------------------------------LOCALS-----------------------------------------------
----------------------------------------------------------------------------------------------------

local requires          = L["handler_tooltip_requires"]
local RequiresQuest     = L["handler_tooltip_quest"]
local RetrievingData    = L["handler_tooltip_data"]

----------------------------------------------------------------------------------------------------
--------------------------------------------GET NPC NAMES-------------------------------------------
----------------------------------------------------------------------------------------------------

local NPClinkOribos = CreateFrame("GameTooltip", "NPClinkOribos", UIParent, "GameTooltipTemplate")
local function GetCreatureNameByID(id)
    if (not id) then return end

    NPClinkOribos:SetOwner(UIParent, "ANCHOR_NONE")
    NPClinkOribos:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(id))
    local name      = _G["NPClinkOribosTextLeft1"]:GetText()
    local sublabel  = _G["NPClinkOribosTextLeft2"]:GetText()
    return name, sublabel
end

----------------------------------------------------------------------------------------------------
---------------------------------------------PROFESSIONS--------------------------------------------
----------------------------------------------------------------------------------------------------

function HandyNotes_Oribos:CharacterHasProfession(SkillLineID)
    local prof1, prof2 = GetProfessions()
    local ID1 = prof1 and select(7, GetProfessionInfo(prof1))
    local ID2 = prof2 and select(7, GetProfessionInfo(prof2))

    if (ID1 == SkillLineID or ID2 == SkillLineID) then
        return true
    end
    return false
end

local function HasTwoProfessions()
    local prof1, prof2 = GetProfessions()
    if (prof1 and prof2) then
        return true
    end
    return false
end

----------------------------------------------------------------------------------------------------
---------------------------------------FLIGHT MASTER WAYPOINT---------------------------------------
----------------------------------------------------------------------------------------------------

local fmaster_waypoint = 0
local function CreateFlightMasterWaypoint()
    local dropdown = Oribos.db.fmaster_waypoint_dropdown

    if (dropdown == 1) then
        -- create Blizzard waypoint
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(1550, 47.02/100, 51.16/100))
        C_SuperTrack.SetSuperTrackedUserWaypoint(true)
        fmaster_waypoint = 1
       --HandyNotes_Oribos:debugmsg("Create Blizzard")
    elseif (C_AddOns.IsAddOnLoaded("TomTom") and dropdown == 2) then
        -- create TomTom waypoint
        Oribos.uid = TomTom:AddWaypoint(1671, 61.91/100, 68.78/100, {title = GetCreatureNameByID(162666)})
        fmaster_waypoint = 1
        --HandyNotes_Oribos:debugmsg("Create TomTom")
    elseif (dropdown == 3) then
        -- create both waypoints
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(1550, 47.02/100, 51.16/100))
        C_SuperTrack.SetSuperTrackedUserWaypoint(true)
        if (C_AddOns.IsAddOnLoaded("TomTom")) then
            Oribos.uid = TomTom:AddWaypoint(1671, 61.91/100, 68.78/100, {title = GetCreatureNameByID(162666)})
        end
        fmaster_waypoint = 1
        --HandyNotes_Oribos:debugmsg("Create Both")
    end
end

local function RemoveFlightMasterWaypoint()
    local dropdown = Oribos.db.fmaster_waypoint_dropdown

    if (fmaster_waypoint == 1) then
        if (dropdown == 1) then
            -- remove Blizzard waypoint
            C_Map.ClearUserWaypoint()
            fmaster_waypoint = 0
            --HandyNotes_Oribos:debugmsg("Remove Blizzard")
        elseif (C_AddOns.IsAddOnLoaded("TomTom") and dropdown == 2) then
            -- remove TomTom waypoint
            TomTom:RemoveWaypoint(Oribos.uid)
            fmaster_waypoint = 0
            --HandyNotes_Oribos:debugmsg("Remove TomTom")
        elseif (dropdown == 3) then
            -- remove both waypoints
            C_Map.ClearUserWaypoint()
            if (C_AddOns.IsAddOnLoaded("TomTom")) then
                TomTom:RemoveWaypoint(Oribos.uid)
            end
            fmaster_waypoint = 0
            --HandyNotes_Oribos:debugmsg("Remove Both")
        end
    end
end

----------------------------------------------------------------------------------------------------
----------------------------------------------PREPARE-----------------------------------------------
local function Prepare(label, note)
    local t = {}
    local NOTE

    for i, name in ipairs(label) do

        -- set spell name as label
        if (type(name) == "number") then
            name = C_Spell.GetSpellInfo(name).name
        end

        -- add additional notes
        if (note and note[i]) then
            NOTE = " ("..note[i]..")"
        else
            NOTE = ''
        end

        -- store everything together
        t[i] = name..NOTE
    end

    return table.concat(t, "\n")
end

----------------------------------------------------------------------------------------------------
------------------------------------------------ICON------------------------------------------------
----------------------------------------------------------------------------------------------------

local function SetIcon(node)
    local icon_key = node.icon

    if (node.picon) then
        if (Oribos.db.picons_vendor and (node.icon == "vendor" or node.icon == "anvil")) then
            icon_key = Oribos.db.use_old_picons and node.picon.."_old" or node.picon
        end

        if (Oribos.db.picons_trainer and node.icon == "trainer") then
            icon_key = Oribos.db.use_old_picons and node.picon.."_old" or node.picon
        end
    end

    if (icon_key and constantsicon[icon_key]) then
        return constantsicon[icon_key]
    end
end

local function GetIconScale(icon, picon)
    -- makes the picon smaller
    if (picon ~= nil and Oribos.db.picons_vendor and (icon == "vendor" or icon == "anvil")) then return Oribos.db["icon_scale_vendor"] * 0.75 end
    if (picon ~= nil and Oribos.db.picons_trainer and icon == "trainer") then return Oribos.db["icon_scale_trainer"] * 0.75 end
    -- anvil npcs are vendors
    if (icon == "anvil") then
        return Oribos.db["icon_scale_vendor"]
    -- combine the four zone gateway icons
    elseif (icon == "kyrian" or icon == "necrolord" or icon == "nightfae" or icon == "venthyr") then
        return  Oribos.db["icon_scale_zonegateway"]
    end

    return Oribos.db["icon_scale_"..icon]
end

local function GetIconAlpha(icon)
    -- anvil npcs are vendors
    if (icon == "anvil") then
        return Oribos.db["icon_alpha_vendor"]
    -- combine the four zone gateway icons
    elseif (icon == "kyrian" or icon == "necrolord" or icon == "nightfae" or icon == "venthyr") then
        return  Oribos.db["icon_alpha_zonegateway"]
    end

    return Oribos.db["icon_alpha_"..icon]
end

local GetNodeInfo = function(node)
    local icon
    if (node) then
        local label = GetCreatureNameByID(node.npc) or node.label or node.multilabel and Prepare(node.multilabel) or UNKNOWN
        if (node.icon == "portal" and node.quest and not IsQuestCompleted(node.quest)) then
            icon = Oribos.constants.icon["portal_red"]
        else
            icon = SetIcon(node)
        end
        return label, icon, node.icon, node.picon, node.scale, node.alpha -- icon returns the path
    end
end

local GetNodeInfoByCoord = function(uMapID, coord)
    return GetNodeInfo(Oribos.DB.nodes[uMapID] and Oribos.DB.nodes[uMapID][coord])
end

----------------------------------------------------------------------------------------------------
----------------------------------------------TOOLTIP-----------------------------------------------
----------------------------------------------------------------------------------------------------

local function SetTooltip(tooltip, node)

    if (node) then
        if (node.npc) then
            local name, sublabel = GetCreatureNameByID(node.npc)
            if (name) then
                tooltip:AddLine(name)
            end
            if (sublabel) then
                tooltip:AddLine(sublabel,1,1,1)
            end
        end
        if (node.label) then
            tooltip:AddLine(node.label)
        end
        if (node.note) then
            tooltip:AddLine("("..node.note..")")
        end
        if (node.multilabel) then
            tooltip:AddLine(Prepare(node.multilabel, node.multinote))
        end
        if (node.quest and not IsQuestCompleted(node.quest)) then
            if (C_QuestLog.GetTitleForQuestID(node.quest) ~= nil) then
                tooltip:AddLine(RequiresQuest..": ["..C_QuestLog.GetTitleForQuestID(node.quest).."] (ID: "..node.quest..")",1,0,0)
            else
                tooltip:AddLine(RetrievingData,1,0,1) -- pink
                C_Timer.After(1, function() HandyNotes_Oribos:Refresh() end) -- Refresh
                -- print("refreshed")
            end
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end

local SetTooltipByCoord = function(tooltip, uMapID, coord)
    return SetTooltip(tooltip, Oribos.DB.nodes[uMapID] and Oribos.DB.nodes[uMapID][coord])
end

----------------------------------------------------------------------------------------------------
-------------------------------------------PluginHandler--------------------------------------------
----------------------------------------------------------------------------------------------------

local PluginHandler = {}
local info = {}

function PluginHandler:OnEnter(uMapID, coord)
    local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
    if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
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
    Oribos.hidden[uMapID][coord] = true
    HandyNotes_Oribos:Refresh()
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

    local HL_Dropdown = CreateFrame("Frame", "HandyNotes_OribosDropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function PluginHandler:OnClick(button, down, uMapID, coord)
        local TomTom = select(2, C_AddOns.IsAddOnLoaded('TomTom'))
        local dropdown = Oribos.db.easy_waypoint_dropdown

        if (down or button ~= "RightButton") then return end

        if (button == "RightButton" and not down and not Oribos.db.easy_waypoint) then
            currentMapID = uMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        elseif (IsControlKeyDown() and Oribos.db.easy_waypoint) then
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
            if (value and Oribos:ShouldShow(state, value, currentMapID)) then
                local _, icon, iconname, piconname, scale, alpha = GetNodeInfo(value)
                    scale = (scale or 1) * GetIconScale(iconname, piconname)
                    alpha = (alpha or 1) * GetIconAlpha(iconname)
                return state, nil, icon, scale, alpha
            end
            state, value = next(t, state)
        end
        return nil, nil, nil, nil, nil, nil
    end

    function PluginHandler:GetNodes2(uMapID, minimap)
        currentMapID = uMapID
        return iter, Oribos.DB.nodes[uMapID], nil
    end

    function Oribos:ShouldShow(coord, node, currentMapID)
        if (not Oribos.db.force_nodes) then
            if (Oribos.hidden[currentMapID] and Oribos.hidden[currentMapID][coord]) then
                return false
            end
            -- this will check if any node is for a specific class
            if (node.class and node.class ~= select(2, UnitClass("player"))) then
                return false
            end
            -- this will check if any node is for a specific faction
            if (node.faction and node.faction ~= select(1, UnitFactionGroup("player"))) then
                return false
            end
            -- this will check if any node is for a specific covenant
            if (node.covenant and node.covenant ~= C_Covenants.GetActiveCovenantID()) then
                return false
            end
            -- this will check if the node is for a specific profession
            if (node.profession and (not HandyNotes_Oribos:CharacterHasProfession(node.profession) and HasTwoProfessions()) and Oribos.db.show_onlymytrainers and not node.auctioneer) then
                return false
            end
            if (node.icon == "auctioneer" and (not HandyNotes_Oribos:CharacterHasProfession(node.profession) or not Oribos.db.show_auctioneer)) then return false end
            if (node.icon == "banker" and not Oribos.db.show_banker) then return false end
            if (node.icon == "barber" and not Oribos.db.show_barber) then return false end
            if (node.icon == "greatvault" and not Oribos.db.show_greatvault) then return false end
            if (node.icon == "guildvault" and not Oribos.db.show_guildvault) then return false end
            if (node.icon == "innkeeper" and not Oribos.db.show_innkeeper) then return false end
            if (node.icon == "mail" and not Oribos.db.show_mail) then return false end
            if (node.icon == "portal" and (not Oribos.db.show_portal or C_AddOns.IsAddOnLoaded("HandyNotes_TravelGuide"))) then return false end
            if (node.icon == "tpplatform" and (not Oribos.db.show_tpplatform or C_AddOns.IsAddOnLoaded("HandyNotes_TravelGuide"))) then return false end
            if (node.icon == "reforge" and not Oribos.db.show_reforge) then return false end
            if (node.icon == "stablemaster" and not Oribos.db.show_stablemaster) then return false end
            if (node.icon == "trainer" and not Oribos.db.show_trainer) then return false end
            if (node.icon == "portaltrainer" and not Oribos.db.show_portaltrainer) then return false end
            if (node.icon == "transmogrifier" and not Oribos.db.show_transmogrifier) then return false end
            if ((node.icon == "vendor" or node.icon == "anvil") and not Oribos.db.show_vendor) then return false end
            if (node.icon == "void" and not Oribos.db.show_void) then return false end
            if ((node.icon == "kyrian" or node.icon == "necrolord" or node.icon == "nightfae" or node.icon == "venthyr") and not Oribos.db.show_zonegateway) then return false end
        end
        return true
    end
end

---------------------------------------------------------------------------------------------------
----------------------------------------------REGISTER---------------------------------------------
---------------------------------------------------------------------------------------------------

function HandyNotes_Oribos:OnInitialize()
    self.db = AceDB:New("HandyNotes_OribosDB", Oribos.constants.defaults)

    profile = self.db.profile
    Oribos.db = profile

    global = self.db.global
    Oribos.global = global

    Oribos.hidden = self.db.char.hidden

    if (Oribos.global.dev) then
        Oribos.devmode()
    end

    -- Initialize database with HandyNotes
    HandyNotes:RegisterPluginDB(HandyNotes_Oribos.pluginName, PluginHandler, Oribos.config.options)
end

function HandyNotes_Oribos:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", HandyNotes_Oribos.pluginName)
end

function HandyNotes_Oribos:OnEnable()
end

----------------------------------------------EVENTS-----------------------------------------------

local frame, events = CreateFrame("Frame"), {};
function events:PLAYER_ENTERING_WORLD(...)
    -- MapID is 1550 when you use the Portal to Korthia
    if (C_Map.GetBestMapForUnit("player") == 1550) then
        RemoveFlightMasterWaypoint()
    end
end

function events:ZONE_CHANGED(...)
    HandyNotes_Oribos:Refresh()

    --HandyNotes_Oribos:debugmsg("Oribos: refreshed after ZONE_CHANGED")
    --HandyNotes_Oribos:debugmsg("MapID: "..C_Map.GetBestMapForUnit("player"))

    if (C_Map.GetBestMapForUnit("player") == 1671) then
        RemoveFlightMasterWaypoint()
    end
end

function events:ZONE_CHANGED_INDOORS(...)
    HandyNotes_Oribos:Refresh()

    --HandyNotes_Oribos:debugmsg("Oribos: refreshed after ZONE_CHANGED_INDOORS")

    -- Set automatically a waypoint (Blizzard, TomTom or both) to the flightmaster.
    if Oribos.db.fmaster_waypoint and C_Map.GetBestMapForUnit("player") == 1671 then
        CreateFlightMasterWaypoint()
    elseif C_Map.GetBestMapForUnit("player") == 1670 then
        RemoveFlightMasterWaypoint()
    end
end

function events:QUEST_FINISHED(...)
    HandyNotes_Oribos:Refresh()

    --HandyNotes_Oribos:debugmsg("Oribos: refreshed after QUEST_FINISHED")
end

function events:SKILL_LINES_CHANGED(...)
    HandyNotes_Oribos:Refresh()

    --HandyNotes_Oribos:debugmsg("Oribos: refreshed after SKILL_LINES_CHANGED")
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
HandyNotes_Oribos.pluginName  = L["config_plugin_name"]
HandyNotes_Oribos.description = L["config_plugin_desc"]

----------------------------------------------------------------------------------------------------
-----------------------------------------------CONFIG-----------------------------------------------
----------------------------------------------------------------------------------------------------

local config = {}
Oribos.config = config

config.options = {
    type = "group",
    name = HandyNotes_Oribos.pluginName,
    desc = HandyNotes_Oribos.description,
    childGroups = "tab",
    get = function(info) return Oribos.db[info[#info]] end,
    set = function(info, v)
        Oribos.db[info[#info]] = v
        HandyNotes_Oribos:SendMessage("HandyNotes_NotifyUpdate", HandyNotes_Oribos.pluginName)
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
                    order = 1,
                },
                desc2 = {
                    type = "description",
                    name = L["config_travelguide_note"],
                    hidden = function()
                        return not C_AddOns.IsAddOnLoaded("HandyNotes_TravelGuide")
                    end,
                    order = 30,
                },
                line_trade_skills = {
                    type = "header",
                    name = TRADE_SKILLS, -- Professions
                    order = 31,
                },
                show_onlymytrainers = {
                    type = "toggle",
                    width = "full",
                    name = L["config_onlymytrainers"],
                    desc = L["config_onlymytrainers_desc"],
                    order = 32,
                },
                picons = {
                    type = "description",
                    width = 0.97,
                    name = L["config_picons"],
                    fontSize = "medium",
                    order = 33,
                },
                picons_vendor = {
                    type = "toggle",
                    width = 0.5,
                    name = L["config_vendor"],
                    desc = L["config_picons_vendor_desc"],
                    order = 33.1,
                },
                picons_trainer = {
                    type = "toggle",
                    width = 0.8,
                    name = L["config_trainer"],
                    desc = L["config_picons_trainer_desc"],
                    order = 33.2,
                },
                use_old_picons = {
                    type = "toggle",
                    width = "full",
                    name = L["config_use_old_picons"],
                    desc = L["config_use_old_picons_desc"],
                    disabled = function() return not (Oribos.db.picons_trainer or Oribos.db.picons_vendor) end,
                    order = 34,
                },
                line_misc = {
                    type = "header",
                    name = "",
                    order = 35,
                },
                fmaster_waypoint = {
                    type = "toggle",
                    width = 1.57,
                    name = L["config_fmaster_waypoint"],
                    desc = L["config_fmaster_waypoint_desc"],
                    order = 36,
                },
                fmaster_waypoint_dropdown = {
                    type = "select",
                    values = { L["Blizzard"], L["TomTom"], L["Both"] },
                    disabled = function() return not Oribos.db.fmaster_waypoint end,
                    hidden = function() return not C_AddOns.IsAddOnLoaded("TomTom") end,
                    name = L["config_waypoint_dropdown"],
                    desc = L["config_waypoint_dropdown_desc"],
                    width = 0.7,
                    order = 36.1,
                },
                easy_waypoint = {
                    type = "toggle",
                    width = 1.57,
                    name = L["config_easy_waypoints"],
                    desc = L["config_easy_waypoints_desc"],
                    order = 37,
                },
                easy_waypoint_dropdown = {
                    type = "select",
                    values = { L["Blizzard"], L["TomTom"], L["Both"] },
                    disabled = function() return not Oribos.db.easy_waypoint end,
                    hidden = function() return not C_AddOns.IsAddOnLoaded("TomTom") end,
                    name = L["config_waypoint_dropdown"],
                    desc = L["config_waypoint_dropdown_desc"],
                    width = 0.7,
                    order = 37.1,
                },
                unhide = {
                    type = "execute",
                    width = "full",
                    name = L["config_restore_nodes"],
                    desc = L["config_restore_nodes_desc"],
                    func = function()
                        for map,coords in pairs(Oribos.hidden) do
                            wipe(coords)
                        end
                        HandyNotes_Oribos:Refresh()
                        print("Oribos: "..L["config_restore_nodes_print"])
                    end,
                    order = 38,
                },
            },
            },
        },
    },
    SCALEALPHA = {
        type = "group",
        name = L["config_tab_scale_alpha"],
        -- desc = L["config_scale_alpha_desc"],
        order = 1,
        args = {
        },
    },
    },
}

-- create the general config menu
for i, icongroup in ipairs(Oribos.constants.icongroup) do

    config.options.args.ICONDISPLAY.args.display.args["show_"..icongroup] = {
        type = "toggle",
        name = L["config_"..icongroup],
        desc = L["config_"..icongroup.."_desc"],
        order = i+2,
    }

end

-- set some parameters for general config menu points
local gcmp = config.options.args.ICONDISPLAY.args.display.args
gcmp.show_auctioneer["hidden"] = function() return not HandyNotes_Oribos:CharacterHasProfession(202) end

gcmp.show_portal["name"] = function() return C_AddOns.IsAddOnLoaded("HandyNotes_TravelGuide") and L["config_portal"].." |cFFFF0000(*)|r" or L["config_portal"] end
gcmp.show_portal["disabled"] = function() return C_AddOns.IsAddOnLoaded("HandyNotes_TravelGuide") end

gcmp.show_portaltrainer["hidden"] = function() return not (select(2, UnitClass("player")) == "MAGE") end

gcmp.show_tpplatform["name"] = function() return C_AddOns.IsAddOnLoaded("HandyNotes_TravelGuide") and L["config_tpplatform"].." |cFFFF0000(*)|r" or L["config_tpplatform"] end
gcmp.show_tpplatform["disabled"] = function() return C_AddOns.IsAddOnLoaded("HandyNotes_TravelGuide") end

-- create the scale / alpha config menu
for i, icongroup in ipairs(Oribos.constants.icongroup) do

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

-- set some parameters for scale / alpha config menu points
local sacmp = config.options.args.SCALEALPHA.args
sacmp.name_auctioneer["hidden"] = function() return not HandyNotes_Oribos:CharacterHasProfession(202) end
sacmp.icon_scale_auctioneer["hidden"] = function() return not HandyNotes_Oribos:CharacterHasProfession(202) end
sacmp.icon_alpha_auctioneer["hidden"] = function() return not HandyNotes_Oribos:CharacterHasProfession(202) end

sacmp.name_portal["name"] = function() return C_AddOns.IsAddOnLoaded("HandyNotes_TravelGuide") and L["config_portal"].." |cFFFF0000(*)|r" or L["config_portal"] end
sacmp.icon_scale_portal["disabled"] = function() return C_AddOns.IsAddOnLoaded("HandyNotes_TravelGuide") end
sacmp.icon_alpha_portal["disabled"] = function() return C_AddOns.IsAddOnLoaded("HandyNotes_TravelGuide") end

sacmp.name_portaltrainer["hidden"] = function() return not (select(2, UnitClass("player")) == "MAGE") end
sacmp.icon_scale_portaltrainer["hidden"] = function() return not (select(2, UnitClass("player")) == "MAGE") end
sacmp.icon_alpha_portaltrainer["hidden"] = function() return not (select(2, UnitClass("player")) == "MAGE") end

sacmp.name_tpplatform["name"] = function() return C_AddOns.IsAddOnLoaded("HandyNotes_TravelGuide") and L["config_tpplatform"].." |cFFFF0000(*)|r" or L["config_tpplatform"] end
sacmp.icon_scale_tpplatform["disabled"] = function() return C_AddOns.IsAddOnLoaded("HandyNotes_TravelGuide") end
sacmp.icon_alpha_tpplatform["disabled"] = function() return C_AddOns.IsAddOnLoaded("HandyNotes_TravelGuide") end


----------------------------------------------------------------------------------------------------
-------------------------------------------DEV CONFIG TAB-------------------------------------------
----------------------------------------------------------------------------------------------------

-- Activate the developer mode with:
-- /script HandyNotes_OribosDB.global.dev = true
-- /reload

local function devmode()
    Oribos.config.options.args["DEV"] = {
        type = "group",
        name = L["dev_config_tab"],
--      desc = L[""],
        order = 2,
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

    SLASH_ORIBOSREFRESH1 = "/oribosrefresh"
    SlashCmdList["ORIBOSREFRESH"] = function(msg)
        HandyNotes_Oribos:Refresh()
        print("Oribos refreshed")
    end

    SLASH_ORIBOS1 = "/oribos"
    SlashCmdList["ORIBOS"] = function(msg)
        Settings.OpenToCategory('HandyNotes')
        LibStub('AceConfigDialog-3.0'):SelectGroup('HandyNotes', 'plugins', 'Oribos')
    end

end

Oribos.devmode = devmode




----------------------------------------------------------------------------------------------------
-----------------------------------------------LOCALS-----------------------------------------------
----------------------------------------------------------------------------------------------------

local function GetMapNames(id1, id2)
    if (id1 and id2) then
        return format("%s, %s", C_Map.GetMapInfo(id1).name, C_Map.GetMapInfo(id2).name)
    else
        return C_Map.GetMapInfo(id1).name
    end
end

local PtoOG = L["Portal to Orgrimmar"]
local Durotar = GetMapNames(12, 1)
local PtoSW = L["Portal to Stormwind"]
local ElwynnForest = GetMapNames(13, 37)
local RingTransference = L["To Ring of Transference"]
local RingFates = L["To Ring of Fates"]
local IntoTheMaw = L["Into the Maw"]
local Korthia = GetMapNames(1543, 1961)
local KeepersRespite = L["To Keeper's Respite"]
local PtoZerethMortis = L["Portal to Zereth Mortis"]

local guildvault = L["config_guildvault"]
local mailbox = L["Mailbox"]

----------------------------------------------------------------------------------------------------
----------------------------------------------DATABASE----------------------------------------------
----------------------------------------------------------------------------------------------------

local DB = {}
Oribos.DB = DB

DB.nodes = {

[1670] = { -- Ring of Fates
    -- HALL OF SHAPES
    -- Juwe
    [34574459] = { icon="vendor", npc=156733, profession=755, picon="jewelcrafting" },
    [35204130] = { icon="trainer", npc=156670, profession=755, picon="jewelcrafting" },
    -- Engineer
    [37684297] = { icon="vendor", npc=156692, profession=202, picon="engineering" },
    [38074470] = { icon="trainer", npc=156691, profession=202, picon="engineering" },
    [38334378] = { icon="auctioneer", npc=173571, profession=202 },
    -- Inscription
    [35963855] = { icon="vendor", npc=156732, profession=773, picon="inscription" },
    [36503673] = { icon="trainer", npc=156685, profession=773, picon="inscription" },
    [37193554] = { icon="vendor", npc=164736, profession=773, picon="inscription" },
    -- Alchemy
    [38873943] = { icon="vendor", npc=156689, profession=171, picon="alchemy" },
    [39244037] = { icon="trainer", npc=156687, profession=171, picon="alchemy" },
    -- Herbalism
    [40233828] = { icon="trainer", npc=156686, profession=182, picon="herbalism" },

    [38653356] = { icon="anvil", npc=156777 },
    -- Mining
    [39353297] = { icon="trainer", npc=156668, profession=186, picon="mining" },
    -- Blacksmith
    [40473150] = { icon="trainer", npc=156666, profession=164, picon="blacksmithing" },
    -- Skinning
    [42162811] = { icon="trainer", npc=156667, profession=393, picon="skinning" },
    -- Leatherworking
    [42292666] = { icon="trainer", npc=156669, profession=165, picon="leatherworking" },
    [44502653] = { icon="vendor", npc=156696, profession=165, picon="leatherworking" },
    -- Tailor
    [45493182] = { icon="trainer", npc=156681, profession=197, picon="tailoring" },
    -- Cooking
    [47492372] = { icon="vendor", npc=168353, picon="cooking" },
    [46822268] = { icon="trainer", npc=156672, picon="cooking" }, -- , profession=185
    -- Fishing
    [46282576] = { icon="vendor", npc=156690, picon="fishing" },
    [46172640] = { icon="trainer", npc=156671, picon="fishing" }, -- , profession=356
    -- Enchanting
    [48412939] = { icon="trainer", npc=156683, profession=333, picon="enchanting" },
    [47572905] = { icon="vendor", npc=156694, profession=333, picon="enchanting" },

    -- HALL OF HOLDING
    -- Banker
    [59812681] = { icon="banker", npc=156479 },
    [60432950] = { icon="banker", npc=156479 },
    [58693031] = { icon="banker", npc=156479 },
    [58102771] = { icon="banker", npc=156479 },
    [58163602] = { icon="mail", label=mailbox },
    [65203600] = { icon="guildvault", label=guildvault },

    -- THE IDYLLIA
    [62935176] = { icon="mail", label=mailbox },
    [73734910] = { icon="mail", label=mailbox },
    [67485033] = { icon="innkeeper", npc=156688 },

    -- HALL OF CURIOSITIES
    [64456418] = { icon="barber", npc=156735 },
    [65196756] = { icon="vendor", npc=156769 },
    [64596987] = { icon="transmogrifier", npc=156663 },
    [64407055] = { icon="void", npc=156664 },
    [61767215] = { icon="vendor", npc=169524 },
    [59257541] = { icon="stablemaster", npc=156791 },
    [56787554] = { icon="anvil", npc=173369 },
    [56727171] = { icon="vendor", npc=173370 },

    -- THE ENCLAVE
    [47867789] = { icon="vendor", npc=176067 }, -- Quartermaster
    [47577721] = { icon="vendor", npc=176064 }, -- Quartermaster
    [47087695] = { icon="vendor", npc=176065 }, -- Quartermaster
    [46677736] = { icon="vendor", npc=176066 }, -- Quartermaster
    [46227780] = { icon="vendor", npc=176368 }, -- Quartermaster

    [35055815] = { icon="vendor", npc=164095 },
    [34445752] = { icon="vendor", npc=168011 },
    [34645648] = { icon="reforge", npc=164096 },

    [23324895] = { icon="portaltrainer", npc=176186, class="MAGE" },
    [30645226] = { icon="mail", label=mailbox },

    [20835477] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde", quest=60151 },
    [20894567] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance", quest=60151 },

    [52094278] = { icon="tpplatform", label=RingTransference },
    [57145040] = { icon="tpplatform", label=RingTransference },
    [52095784] = { icon="tpplatform", label=RingTransference },
    [47055029] = { icon="tpplatform", label=RingTransference },
},

[1671] = { -- Ring of Transference
    [49525107] = { icon="portal", label=IntoTheMaw },
    [30702319] = { icon="portal", label=KeepersRespite, note=Korthia, quest=63665 },
    [49504243] = { icon="tpplatform", label=RingFates },
    [55735162] = { icon="tpplatform", label=RingFates },
    [49506073] = { icon="tpplatform", label=RingFates },
    [43375150] = { icon="tpplatform", label=RingFates },

    [67345157] = { icon="kyrian", label=C_Map.GetMapInfo(1533).name },
    [62183266] = { icon="necrolord", label=C_Map.GetMapInfo(1536).name },
    [49587788] = { icon="nightfae", label=C_Map.GetMapInfo(1565).name },
    [32015156] = { icon="venthyr", label=C_Map.GetMapInfo(1525).name },
    [49562609] = { icon="portal", label=PtoZerethMortis, quest=64957 }
},

[1672] = {
    [51284300] = { icon="vendor", npc=167881 },
},

} -- DB ENDE