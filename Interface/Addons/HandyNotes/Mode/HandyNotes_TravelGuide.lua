----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local TravelGuide = {}

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
        icon_scale_others = 1.5,
        icon_alpha_others = 1.0,

        query_server = true,
        show_portal = true,
        show_orderhall = true,
        show_warfront = true,
        show_tram = true,
        show_boat = true,
        show_aboat = true,
        show_zeppelin = true,
        show_hzeppelin = true,
        show_note = true,
        easy_waypoint = true,
        show_tpplatform = true,
        show_herorestgate = true,
--      show_others = true,

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

local left, right, top, bottom = GetObjectIconTextureCoords("4772") --MagePortalAlliance
local left2, right2, top2, bottom2 = GetObjectIconTextureCoords("4773") --MagePortalHorde
local MagePortalAlliance = {
        icon = [[Interface\MINIMAP\OBJECTICONSATLAS]],
        tCoordLeft = left,
        tCoordRight = right,
        tCoordTop = top,
        tCoordBottom = bottom,
    }

constants.icon = {
    portal = MagePortalAlliance,
    orderhall = MagePortalAlliance,
    MagePortalHorde = {
        icon = [[Interface\MINIMAP\OBJECTICONSATLAS]],
        tCoordLeft = left2,
        tCoordRight = right2,
        tCoordTop = top2,
        tCoordBottom = bottom2,
    },
    mixedportal   = "Interface\\AddOns\\HandyNotes\\Icons\\portal_mixed",
    boat          = "Interface\\AddOns\\HandyNotes\\Icons\\boat",
    aboat         = "Interface\\AddOns\\HandyNotes\\Icons\\boat_alliance",
    boat_X        = "Interface\\AddOns\\HandyNotes\\Icons\\boat_grey_x",
    tram          = "Interface\\AddOns\\HandyNotes\\Icons\\tram",
    flightmaster  = "Interface\\MINIMAP\\TRACKING\\FlightMaster",
    zeppelin      = "Interface\\AddOns\\HandyNotes\\Icons\\zeppelin",
    hzeppelin     = "Interface\\AddOns\\HandyNotes\\Icons\\zeppelin_horde",
    worderhall    = "Interface\\AddOns\\HandyNotes\\Icons\\warrior",
    tpplatform    = "Interface\\MINIMAP\\TempleofKotmogu_ball_cyan",
    herosrestgate = "Interface\\AddOns\\HandyNotes\\Icons\\platform",
}


----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local HandyNotes_TravelGuide = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_TravelGuide", "AceEvent-3.0", "AceTimer-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local AceDB = LibStub("AceDB-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes")
TravelGuide.locale = L

HandyNotes_TravelGuide.constants = TravelGuide.constants

_G.HandyNotes_TravelGuide = HandyNotes_TravelGuide

local IsQuestCompleted = C_QuestLog.IsQuestFlaggedCompleted

local MagePortalHorde  = TravelGuide.constants.icon.MagePortalHorde
local BoatX            = TravelGuide.constants.icon.boat_x

----------------------------------------------------------------------------------------------------
-----------------------------------------------LOCALS-----------------------------------------------
----------------------------------------------------------------------------------------------------

local requires          = L["handler_tooltip_requires"]
local notavailable      = L["handler_tooltip_not_available"]
--local available       = L["handler_tooltip_available"] -- not in use
local RequiresPlayerLvl = L["handler_tooltip_requires_level"]
local RequiresQuest     = L["handler_tooltip_quest"]
local RetrievindData    = L["handler_tooltip_data"]
local sanctum_feature   = L["handler_tooltip_sanctum_feature"]
local TNRank            = L["handler_tooltip_TNTIER"]

----------------------------------------------------------------------------------------------------
----------------------------------------------FUNCTIONS---------------------------------------------
----------------------------------------------------------------------------------------------------

-- returns the controlling faction
local function GetWarfrontState(id)
    -- Battle for Stromgarde 11, Battle for Darkshore 118
    state = C_ContributionCollector.GetState(id)
    return (state == 1 or state == 2) and "Alliance" or "Horde"
end

-- returns the note for mixed portals
local function SetWarfrontNote()
    astate = GetWarfrontState(11) -- Battle for Stromgarde
    dstate = GetWarfrontState(118) -- Battle for Darkshore

    return (astate ~= select(1, UnitFactionGroup("player")) and notavailable or " ").."\n"..(dstate ~= select(1, UnitFactionGroup("player")) and notavailable or " ")
end

-- returns true when all requirements are fullfilled
local function ReqFullfilled(req, ...)
    if (req.quest and not IsQuestCompleted(req.quest))
    or (req.level and (UnitLevel("player") < req.level))
    or (req.sanctumtalent and not C_Garrison.GetTalentInfo(req.sanctumtalent).researched)
    or (req.timetravel and UnitLevel("player") >= 50 and not IsQuestCompleted(req.timetravel.quest) and not req.warfront and not req.timetravel.turn)
    or (req.timetravel and UnitLevel("player") >= 50 and IsQuestCompleted(req.timetravel.quest) and req.warfront and not req.timetravel.turn)
    or (req.timetravel and UnitLevel("player") >= 50 and IsQuestCompleted(req.timetravel.quest) and not req.warfront and req.timetravel.turn)
    or (req.warfront and GetWarfrontState(req.warfront) ~= select(1, UnitFactionGroup("player")))
    or (req.spell and not IsSpellKnown(req.spell))
    then
        return false
    end

	return true
end

-- workaround to prepare the multilabels with and without notes
-- because the game displays the first line in 14px and
-- the following lines in 13px with a normal for loop.
local function PrepareLabel(label, note)
    local t = {}
    for i, name in ipairs(label) do
        if (label and TravelGuide.db.show_note) then
            if label[i] and note[i] then
                t[i] = name.." ("..note[i]..")"
             else
            -- if there is no note for this Portal
                t[i] = name
            end
        else
        -- if the TravelGuide.db.show_note == false
            t[i] = name
        end
    end
    return table.concat(t, "\n")
end

----------------------------------------------------------------------------------------------------
------------------------------------------------ICON------------------------------------------------
----------------------------------------------------------------------------------------------------

local function SetIcon(point)
    local icon_key

    for i, k in ipairs({
        "portal", "orderhall", "mixedportal", "boat", "aboat", "zeppelin",
        "hzeppelin", "tram", "flightmaster", "herosrestgate", "tpplatform"
    }) do
        if point[k] then icon_key = k end
    end

    if (icon_key and TravelGuide.constants.icon[icon_key]) then
        return TravelGuide.constants.icon[icon_key]
    end
end

local GetPointInfo = function(point)
    local icon

    if point then
        local spellName = GetSpellInfo(point.spell)
        local label = point.label or point.multilabel and table.concat(point.multilabel, "\n") or spellName or UNKNOWN
        if point.requirements and not ReqFullfilled(point.requirements) then
            icon = ((point.portal or point.orderhall) and MagePortalHorde) or (point.boat and BoatX)
        else
            icon = SetIcon(point)
        end
        return label, icon, point.scale, point.alpha, point.portal, point.orderhall, point.mixedportal, point.zeppelin, point.hzeppelin, point.boat, point.aboat, point.covenant
    end
end

local GetPoinInfoByCoord = function(uMapID, coord)
    return GetPointInfo(TravelGuide.DB.points[uMapID] and TravelGuide.DB.points[uMapID][coord])
end

----------------------------------------------------------------------------------------------------
----------------------------------------------TOOLTIP-----------------------------------------------
----------------------------------------------------------------------------------------------------

local function SetTooltip(tooltip, point)
    local pointreq = point.requirements
    if point then
        if (point.label) then
            tooltip:AddLine(point.label)
        end
        if point.labelspell then
            local spellName = GetSpellInfo(point.labelspell)
            tooltip:AddLine(spellName)
        end
        if (point.note and TravelGuide.db.show_note) then
            tooltip:AddLine("("..point.note..")")
        end
        if (point.multilabel and not point.mixedportal) then
            tooltip:AddLine(PrepareLabel(point.multilabel, point.multinote))
        end
        if (point.npc) then
            tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(point.npc))
        end
        if (point.mixedportal) then
            tooltip:AddDoubleLine(PrepareLabel(point.multilabel, point.multinote), SetWarfrontNote(), nil,nil,nil,1) -- only the second line is red
        end
        if pointreq then
            if (pointreq.warfront and GetWarfrontState(pointreq.warfront) ~= select(1, UnitFactionGroup("player"))) then
                tooltip:AddLine(notavailable, 1) -- red
            end
            if (pointreq.level and UnitLevel("player") < pointreq.level) then
                tooltip:AddLine(RequiresPlayerLvl..": "..pointreq.level, 1) -- red
            end
            if (pointreq.quest and not IsQuestCompleted(pointreq.quest)) then
                if C_QuestLog.GetTitleForQuestID(pointreq.quest) ~= nil then
                    tooltip:AddLine(RequiresQuest..": ["..C_QuestLog.GetTitleForQuestID(pointreq.quest).."] (ID: "..pointreq.quest..")",1,0,0)
                else
                    tooltip:AddLine(RetrievindData,1,0,1) -- pink
                    C_Timer.After(1, function() HandyNotes_TravelGuide:Refresh() end) -- Refresh
    --              print("refreshed")
                end
            end
            if (pointreq.timetravel and UnitLevel("player") >= 50) then -- don't show this under level 50
                local spellName = GetSpellInfo(pointreq.timetravel["spell"])
                if spellName then
                    if (not IsQuestCompleted(pointreq.timetravel["quest"]) and not pointreq.warfront and not pointreq.timetravel["turn"]) then
                        tooltip:AddLine(requires..': '..spellName, 1) -- text red / uncompleted
                    elseif (IsQuestCompleted(pointreq.timetravel["quest"]) and pointreq.warfront and not pointreq.timetravel["turn"]) then
                        tooltip:AddLine(requires..': '..spellName, 1) -- text red / uncompleted
                    elseif (IsQuestCompleted(pointreq.timetravel["quest"]) and not pointreq.warfront and pointreq.timetravel["turn"]) then
                        tooltip:AddLine(requires..': '..spellName, 1) -- text red / uncompleted
                    end
                end
            end
            if (pointreq.spell) then -- don't show this if the spell is known
                local spellName = GetSpellInfo(pointreq.spell)
                local isKnown = IsSpellKnown(pointreq.spell)
                if spellName and not isKnown then
                    tooltip:AddLine(requires..': '..spellName, 1) -- red
                end
            end
            if point.covenant and pointreq.sanctumtalent then
                local TALENT = C_Garrison.GetTalentInfo(pointreq.sanctumtalent)
                if not TALENT["researched"] then
                    tooltip:AddLine(requires.." "..sanctum_feature..":", 1) -- red
                    tooltip:AddLine(TALENT["name"], 1, 1, 1) -- white
                    tooltip:AddTexture(TALENT["icon"], {margin={right=2}})
                    tooltip:AddLine("   ? "..format(TNRank, TALENT["tier"]+1), 0.6, 0.6, 0.6) -- grey
                end
            end
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end

local SetTooltipByCoord = function(tooltip, uMapID, coord)
    return SetTooltip(tooltip, TravelGuide.DB.points[uMapID] and TravelGuide.DB.points[uMapID][coord])
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
    if self:GetParent() == WorldMapButton then
        WorldMapTooltip:Hide()
    else
        GameTooltip:Hide()
    end
end

local function hideNode(button, uMapID, coord)
    TravelGuide.hidden[uMapID][coord] = true
    HandyNotes_TravelGuide:Refresh()
end

local function closeAllDropdowns()
    CloseDropDownMenus(1)
end

local function addTomTomWaypoint(button, uMapID, coord)
    if IsAddOnLoaded("TomTom") then
        local x, y = HandyNotes:getXY(coord)
        TomTom:AddWaypoint(uMapID, x, y, {
            title = GetPoinInfoByCoord(uMapID, coord),
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

--------------------------------------------CONTEXT MENU--------------------------------------------

do
    local currentMapID = nil
    local currentCoord = nil
    local function generateMenu(button, level)
        if (not level) then return end
        if (level == 1) then
--      local spacer = {text='', disabled=true, notClickable=true, notCheckable=true}

            -- Create the title of the menu
            info = UIDropDownMenu_CreateInfo()
            info.isTitle = true
            info.text = L["handler_context_menu_addon_name"]
            info.notCheckable = true
            UIDropDownMenu_AddButton(info, level)

--            UIDropDownMenu_AddButton(spacer, level)

            if IsAddOnLoaded("TomTom") and not TravelGuide.db.easy_waypoint then
                -- Waypoint menu item
                info = UIDropDownMenu_CreateInfo()
                info.text = L["handler_context_menu_add_tomtom"]
                info.notCheckable = true
                info.func = addTomTomWaypoint
                info.arg1 = currentMapID
                info.arg2 = currentCoord
                UIDropDownMenu_AddButton(info, level)
            end

            -- Hide menu item
            info = UIDropDownMenu_CreateInfo()
            info.text         = L["handler_context_menu_hide_node"]
            info.notCheckable = true
            info.func         = hideNode
            info.arg1         = currentMapID
            info.arg2         = currentCoord
            UIDropDownMenu_AddButton(info, level)

--          UIDropDownMenu_AddButton(spacer, level)

            -- Close menu item
            info = UIDropDownMenu_CreateInfo()
            info.text         = CLOSE
            info.func         = closeAllDropdowns
            info.notCheckable = true
            UIDropDownMenu_AddButton(info, level)
        end
    end

    local HL_Dropdown = CreateFrame("Frame", "HandyNotes_TravelGuideDropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function PluginHandler:OnClick(button, down, uMapID, coord)
        if ((down or button ~= "RightButton") and TravelGuide.db.easy_waypoint and IsAddOnLoaded("TomTom")) then
            return
        end
        if ((button == "RightButton" and not down) and (not TravelGuide.db.easy_waypoint or not IsAddOnLoaded("TomTom"))) then
            currentMapID = uMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        end
        if (IsControlKeyDown() and TravelGuide.db.easy_waypoint and IsAddOnLoaded("TomTom")) then
            currentMapID = uMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        else
        if TravelGuide.db.easy_waypoint and IsAddOnLoaded("TomTom") then
            addTomTomWaypoint(button, uMapID, coord)
        end
        end
    end
end

do

local currentMapID = nil
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do
            if value and TravelGuide:ShouldShow(state, value, currentMapID) then
                local _, icon, scale, alpha, portal, orderhall, mixedportal, zeppelin, hzeppelin, boat, aboat, covenant = GetPointInfo(value)
                if portal or orderhall or mixedportal then
                scale = (scale or 1) * TravelGuide.db.icon_scale_portal
                alpha = (alpha or 1) * TravelGuide.db.icon_alpha_portal
                elseif boat or aboat then
                scale = (scale or 1) * TravelGuide.db.icon_scale_boat
                alpha = (alpha or 1) * TravelGuide.db.icon_alpha_boat
                elseif zeppelin or hzeppelin then
                scale = (scale or 1) * TravelGuide.db.icon_scale_zeppelin
                alpha = (alpha or 1) * TravelGuide.db.icon_alpha_zeppelin
                elseif covenant then
                scale = (scale or 1) * TravelGuide.db.icon_scale_covenant
                alpha = (alpha or 1) * TravelGuide.db.icon_alpha_covenant
                else
                scale = (scale or 1) * TravelGuide.db.icon_scale_others
                alpha = (alpha or 1) * TravelGuide.db.icon_alpha_others
                end
                return state, nil, icon, scale, alpha
            end
            state, value = next(t, state)
        end
        return nil, nil, nil, nil, nil, nil
    end
    function PluginHandler:GetNodes2(uMapID, minimap)
        currentMapID = uMapID
        return iter, TravelGuide.DB.points[uMapID], nil
    end
    function TravelGuide:ShouldShow(coord, point, currentMapID)
    if not TravelGuide.db.force_nodes then
        if (TravelGuide.hidden[currentMapID] and TravelGuide.hidden[currentMapID][coord]) then
            return false
        end
        -- this will check if any node is for specific class
        if (point.class and point.class ~= select(2, UnitClass("player"))) then
            return false
        end
        -- this will check if any node is for specific faction
        if (point.faction and point.faction ~= select(1, UnitFactionGroup("player"))) then
            return false
        end
        -- this will check if any node is for specific covenant
        if (point.covenant and point.covenant ~= C_Covenants.GetActiveCovenantID()) then
            return false
        end
        if (point.portal and not TravelGuide.db.show_portal) then return false end
        if (point.orderhall and not TravelGuide.db.show_orderhall) then return false end
        if (point.worderhall and not TravelGuide.db.show_orderhall) then return false end
        if (point.requirements and point.requirements.warfront and not TravelGuide.db.show_warfront) then return false end
        if (point.mixedportal and not TravelGuide.db.show_warfront) then return false end
        if (point.flightmaster and not TravelGuide.db.show_orderhall) then return false end
        if (point.tram and not TravelGuide.db.show_tram) then return false end
        if (point.boat and not TravelGuide.db.show_boat) then return false end
        if (point.aboat and not TravelGuide.db.show_aboat) then return false end
        if (point.zeppelin and not TravelGuide.db.show_zeppelin) then return false end
        if (point.hzeppelin and not TravelGuide.db.show_hzeppelin) then return false end
        if (point.herosrestgate and not TravelGuide.db.show_herorestgate) then return false end
        if (point.tpplatform and not TravelGuide.db.show_tpplatform) then return false end
    end
        return true
    end
end

---------------------------------------------------------------------------------------------------
----------------------------------------------REGISTER---------------------------------------------
---------------------------------------------------------------------------------------------------

function HandyNotes_TravelGuide:OnInitialize()
    self.db = AceDB:New("HandyNotes_TravelGuideDB", TravelGuide.constants.defaults)

    profile = self.db.profile
    TravelGuide.db = profile

    global = self.db.global
    TravelGuide.global = global

    TravelGuide.hidden = self.db.char.hidden

    if TravelGuide.global.dev then
        TravelGuide.devmode()
    end

    -- Initialize database with HandyNotes
    HandyNotes:RegisterPluginDB(HandyNotes_TravelGuide.pluginName, PluginHandler, TravelGuide.config.options)
end

function HandyNotes_TravelGuide:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", HandyNotes_TravelGuide.pluginName)
end

function HandyNotes_TravelGuide:OnEnable()
end

----------------------------------------------EVENTS-----------------------------------------------

local frame, events = CreateFrame("Frame"), {};
function events:ZONE_CHANGED(...)
    HandyNotes_TravelGuide:Refresh()

    if TravelGuide.global.dev and TravelGuide.db.show_prints then
        print("TravelGuide: refreshed after ZONE_CHANGED")
    end
end

function events:ZONE_CHANGED_INDOORS(...)
    HandyNotes_TravelGuide:Refresh()

    if TravelGuide.global.dev and TravelGuide.db.show_prints then
        print("TravelGuide: refreshed after ZONE_CHANGED_INDOORS")
    end
end

function events:QUEST_FINISHED(...)
    HandyNotes_TravelGuide:Refresh()

    if TravelGuide.global.dev and TravelGuide.db.show_prints then
        print("TravelGuide: refreshed after QUEST_FINISHED")
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
HandyNotes_TravelGuide.pluginName  = L["TravelGuide_plugin_name"]
HandyNotes_TravelGuide.description = L["TravelGuide_plugin_desc"]

----------------------------------------------------------------------------------------------------
-----------------------------------------------CONFIG-----------------------------------------------
----------------------------------------------------------------------------------------------------

local config = {}
TravelGuide.config = config

config.options = {
    type = "group",
    name = HandyNotes_TravelGuide.pluginName,
    desc = HandyNotes_TravelGuide.description,
    childGroups = "tab",
    get = function(info) return TravelGuide.db[info[#info]] end,
    set = function(info, v)
        TravelGuide.db[info[#info]] = v
        HandyNotes_TravelGuide:SendMessage("HandyNotes_NotifyUpdate", HandyNotes_TravelGuide.pluginName)
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
                    order = 12,
                },
                show_orderhall = {
                    type = "toggle",
                    name = L["config_order_hall_portal"],
                    desc = L["config_order_hall_portal_desc"],
                    order = 13,
                },
                show_warfront = {
                    type = "toggle",
                    width = "full",
                    name = L["config_warfront_portal"],
                    desc = L["config_warfront_portal_desc"],
                    order = 14,
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
                    hidden = function()
                        if select(1, UnitFactionGroup("player")) == "Alliance" then
                            return true
                        end
                    end,
                    order = 16,
                },
                show_zeppelin = {
                    type = "toggle",
                    name = L["config_zeppelin"],
                    desc = L["config_zeppelin_desc"],
                    hidden = function()
                        if select(1, UnitFactionGroup("player")) == "Alliance" then
                            return true
                        end
                    end,
                    order = 17,
                },
                show_hzeppelin = {
                    type = "toggle",
                    name = L["config_zeppelin_horde"],
                    desc = L["config_zeppelin_horde_desc"],
                    hidden = function()
                        if select(1, UnitFactionGroup("player")) == "Horde" then
                            return true
                        end
                    end,
                    order = 18,
                },
                show_tram = {
                    type = "toggle",
                    name = L["config_deeprun_tram"],
                    desc = L["config_deeprun_tram_desc"],
                    order = 19,
                },
                show_note = {
                    type = "toggle",
                    name = L["config_note"],
                    desc = L["config_note_desc"],
                    order = 20,
                },
                shadowlands_line = {
                    type = "header",
                    name = "",
                    order = 21,
                },
                show_tpplatform = {
                    type = "toggle",
                    width = "full",
                    name = L["config_teleport_platform"],
                    desc = L["config_teleport_platform_desc"],
                    order = 22,
                },
                show_herorestgate = {
                    type = "toggle",
                    width = "full",
                    name = L["config_anima_gateway"],
                    desc = L["config_anima_gateway_desc"],
                    order = 23,
                },
                other_line = {
                    type = "header",
                    name = "",
                    order = 25,
                },
                easy_waypoint = {
                    type = "toggle",
                    width = "full",
                    name = function()
                        if IsAddOnLoaded("TomTom") then
                            return L["config_easy_waypoints"]
                        else
                            return L["config_easy_waypoints"].." |cFFFF0000("..L["handler_tooltip_requires"].." TomTom)|r"
                        end
                    end,
                    disabled = function() return not IsAddOnLoaded("TomTom") end,
                    desc = L["config_easy_waypoints_desc"],
                    order = 26,
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
                        HandyNotes_TravelGuide:Refresh()
                        print("TravelGuide: "..L["config_restore_nodes_print"])
                    end,
                    order = 27,
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

for i, icongroup in ipairs({"portal", "boat", "zeppelin", "others"}) do

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
        width = 1.13,
        order = i *10 + 1,
    }

    config.options.args.SCALEALPHA.args["icon_alpha_"..icongroup] = {
        type = "range",
        name = L["config_icon_alpha"],
        desc = L["config_icon_alpha_desc"],
        min = 0, max = 1, step = 0.01,
        arg = "icon_alpha_"..icongroup,
        width = 1.13,
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

    SLASH_TGREFRESH1 = "/tgrefresh"
    SlashCmdList["TGREFRESH"] = function(msg)
        HandyNotes_TravelGuide:Refresh()
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
        InterfaceOptionsFrame_Show()
        InterfaceOptionsFrame_OpenToCategory('HandyNotes')
        LibStub('AceConfigDialog-3.0'):SelectGroup('HandyNotes', 'plugins', 'TravelGuide')
    end

end

TravelGuide.devmode = devmode



----------------------------------------------------------------------------------------------------
-----------------------------------------------LOCALS-----------------------------------------------
----------------------------------------------------------------------------------------------------

local function GetMapNames(id1, id2)
    if id1 and id2 then
        return format("%s, %s", C_Map.GetMapInfo(id1).name, C_Map.GetMapInfo(id2).name)
    end
    return C_Map.GetMapInfo(id1).name
end

----------------------------------------------COVENANT----------------------------------------------

local Kyrian    = 1
local Venthyr   = 2
local Nightfae  = 3
local Necrolord = 4
local PH = L["PH"] -- PLACEHOLDER

--------------------------------------------SHADOWLANDS---------------------------------------------

local Shadowlands = GetMapNames(1550)
local PtoOribos = L["Portal to Oribos"]
local WstoOribos = L["Waystone to Oribos"]
local RingTransference= L["To Ring of Transference"]
local RingFates = L["To Ring of Fates"]
local IntoTheMaw = L["Into the Maw"]
local PtoThorghast = L["Portal to Thorghast"]

local AGtoHerosrest = L["Anima Gateway to Hero's rest"]

-------------------------------------------------BfA------------------------------------------------

local Zandalar = GetMapNames(875)
local Zuldazar = GetMapNames(875, 862)
local PtoZuldazar = L["Portal to Zuldazar"]
local BtoZuldazar = L["Boat to Zuldazar"]
local returntoZuldazar = L["Return to Zuldazar"]
local BtoVolDun = L["Boat to Vol'Dun"]
local BtoNazmir = L["Boat to Nazmir"]
local PtoNazjatar = L["Portal to Nazjatar"]
local StoMechagon = L["Submarine to Mechagon"]
local PtoSilithus = L["Portal to Silithus"]

local KulTiras = GetMapNames(876)
local TiragardeSound = GetMapNames(876, 895)
local PtoBoralus = L["Portal to Boralus"]
local BtoBoralus = L["Boat to Boralus"]
local returntoBoralus = L["Return to Boralus"]
local BtoDrustvar = L["Boat to Drustvar"]
local BtoStormsongValley = L["Boat to Stormsong Valley"]
local BtoTiragardeSound = L["Boat to Tiragarde Sound"]

local PtoArathiHighlands = L["Portal to Arathi Highlands"]
local PtoPortofZandalar = L["Portal to Port of Zandalar"]
local PtoDarkshore = L["Portal to Darkshore"]
local PtoPortofBoralus = L["Portal to Port of Boralus"]

-----------------------------------------------LEGION-----------------------------------------------

local BrokenIsles = GetMapNames(619)
local Stormheim = GetMapNames(619, 634)
local PtoStormheim = L["Portal to Stormheim"]
local PtoHelheim = L["Portal to Helheim"]
local PtoDala = L["Portal to Dalaran"]
local PtoAzsuna = L["Portal to Azsuna"]
local PtoValsharah = L["Portal to Val'sharah"]
local PtoEmeraldDreamway = L["Portal to Emerald Dreamway"]
local PtoSuramar = L["Portal to Suramar"]
local PtoHighmountain = L["Portal to Highmountain"]
local GEtoTrueshotLodge = L["Great Eagle to Trueshot Lodge"]
local JtoSkyhold = L["Jump to Skyhold"]
local dalaran = GetMapNames(627)
local azsuna = GetMapNames(630)
local valsharah = GetMapNames(641)
local suramar = GetMapNames(680)
local highmountain = GetMapNames(650)
local stormheim = GetMapNames(634)
local brokenshore = GetMapNames(646)

-------------------------------------------------WoD------------------------------------------------

local PtoStormshield = L["Portal to Stormshield"]
local PtoLionswatch = L["Portal to Lion's watch"]
local PtoWarspear = L["Portal to Warspear"]
local PtoVolmar = L["Portal to Vol'mar"]
local Ashran = GetMapNames(572, 588)
local TanaanJungle = GetMapNames(572, 534)

-------------------------------------------------MoP------------------------------------------------

local Pandaria = GetMapNames(424)
local TownlongSteppes = GetMapNames(424, 388)
local PtoIofT = L["Portal to Isle of Thunder"]
local PtoSPG = L["Portal to Shado-Pan Garrison"]
local PtoJadeForest = L["Portal to Jade Forest"]
local KunLaiSummit = GetMapNames(424, 379)
local PtoPeakofSerenity = L["Portal to Peak of Serenity"]

-------------------------------------------------CATA-----------------------------------------------

local Maelstrom = GetMapNames(948)
local Deepholm = GetMapNames(948, 207)
local PtoTolBarad = L["Portal to Tol Barad"]
local PtoUldum = L["Portal to Uldum"]
local PtoDeepholm = L["Portal to Deepholm"]
local PtoVashjir = L["Portal to Vashj'ir"]
local PtoHyjal = L["Portal to Hyjal"]
local PtoTwilightHighlands = L["Portal to Twilight Highlands"]
local PtoTempleofEarth = L["Portal to Temple of Earth"]
local PtoTherazanesThrone = L["Portal to Therazane's Throne"]

------------------------------------------------WotLK-----------------------------------------------

local CrystalsongForest = GetMapNames(113, 127)
local PtotPurpleParlor = L["Portal to the Purple Parlor"]
local BoreanTundra = GetMapNames(113, 114)
local ZtoBoreanTundra = L["Zeppelin to Borean Tundra"]
local BtoBoreanTundra = L["Boat to Borean Tundra"]
local WarsongHold = GetMapNames(113)..", "..C_Map.GetAreaInfo(4129)
local ValianceKeep = GetMapNames(113)..", "..C_Map.GetAreaInfo(4032)
local BtoUnuPe = L["Boat to Unu'Pe"]
local Dragonblight = GetMapNames(113, 115)
local BtoMoaKiHarbor = L["Boat to Moa'Ki Harbor"]
local HowlingFjord = GetMapNames(113, 117)
local PtoHowlingFjord = L["Portal to Howling Fjord"]
local VengeanceLanding = GetMapNames(113)..", "..C_Map.GetAreaInfo(4000)
local BtoHowlingFjord = L["Boat to Howling Fjord"]
local Valgarde = GetMapNames(113)..", "..C_Map.GetAreaInfo(3981)
local BtoKamagua = L["Boat to Kamagua"]

-------------------------------------------------BC-------------------------------------------------

local AzuremystIsle = GetMapNames(12, 97)
local PtoExodar = L["Portal to Exodar"]
local inExodar = L["in Exodar"]
local Outland = GetMapNames(101)
local PtoHellfirePeninsula = L["Portal to Hellfire Peninsula"]
local PtoIofQD = L["Portal to Isle of Quel'Danas"]
local PtoShattrath = L["Portal to Shattrath"]
local TerokkarForest = GetMapNames(101, 108)

-----------------------------------------------VANILLA----------------------------------------------

local Durotar = GetMapNames(12, 1)
local PtoOG = L["Portal to Orgrimmar"]
local ZtoOG = L["Zeppelin to Orgrimmar"]
local Mulgore = GetMapNames(12, 7)
local PtoTB = L["Portal to Thunder Bluff"]
local ZtoTB = L["Zeppelin to Thunder Bluff"]
local Tirisfal = GetMapNames(13, 18)
local PtoUC = L["Portal to Undercity"]
local inUCMq = L["in Undercity Magic Quarter"]
local Orboftranslocation = L["Orb of translocation"]
local EversongWoods = GetMapNames(13, 94)
local PtoSM = L["Portal to Silvermoon"]
local NorthernBarrens = GetMapNames(12, 10)
local BtoRatchet = L["Boat to Ratchet"]
local ElwynnForest = GetMapNames(13, 37)
local PtoSW = L["Portal to Stormwind"]
local BtoSW = L["Boat to Stormwind"]
local DrTtoSW = L["Deeprun Tram to Stormwind"]
local Teldrassil = GetMapNames(12, 57)
local PtoDarnassus = L["Portal to Darnassus"]
local DunMorogh = GetMapNames(13, 27)
local PtoIF = L["Portal to Ironforge"]
local DrTtoIF = L["Deeprun Tram to Ironforge"]
local BtoMenethilHarbor = L["Boat to Menethil Harbor"]
local EasternKingdoms = GetMapNames(13)
local Wetlands = GetMapNames(13, 56)
local ZtoStranglethornVale = L["Zeppelin to Stranglethorn Vale"]
local PtoStranglethornVale = L["Portal to Stranglethorn Vale"]
local StranglethornVale = GetMapNames(13, 224)
local BtoBootyBay = L["Boat to Booty Bay"]
local GromgolBaseCamp = GetMapNames(13)..", "..C_Map.GetAreaInfo(117)
local Kalimdor = GetMapNames(12)
local DustwallowMarsh = GetMapNames(12, 70)
local BtoTheramore = L["Boat to Theramore"]
local PtoCavernsofTime = L["Portal to Caverns of Time"]
local Tanaris = GetMapNames(12, 71)
local ArathiHighlands = GetMapNames(13, 14)
local Darkshore = GetMapNames(12, 62)
local PtoDalaCrater = L["Portal to Dalaran Crater"]
local HillsbradFoothills = GetMapNames(13, 25)
local PtoSepulcher = L["Portal to the Sepulcher"]
local SilverpineForest = GetMapNames(13, 21)

----------------------------------------------------------------------------------------------------
----------------------------------------------DATABASE----------------------------------------------
----------------------------------------------------------------------------------------------------

local DB = {}
TravelGuide.DB = DB

DB.points = {
--[[ structure:
    [UiMapID] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            label         = ["STRING"],         -- label for singel destination nodes
            multilabel    = {TABLE},            -- label for multi destination nodes
            note          = ["STRING"],         -- additional destination notes
            multinote     = {TABLE},            -- additional notes for multi destination nodes
            requirements  = {                   -- additional notes for requirements
                TABLE FOR:
                quest         = [ID],           -- additional notes for a required quest
                spell         = [ID],           -- additional notes for a required spell
                level         = [PLAYERLEVEL],  -- additional notes for a required player level
                sanctumtalent = [ID],           -- additional notes for a required sanctum upgrade
                warfront      = [ID],           -- additional notes for warfront nodes
                timetravel    = {               -- additional requirement for nodes
                TABLE FOR:
                    quest = [ID],               -- hidden quest id to track the timezone from Zidormi
                    spell = [ID],               -- time travel spell id
                    turn = [BOOLEAN]            -- to turn the timezone in Sillithus
                },
            },
            faction       = ["FACTION"],        -- shows only for selected faction
            class         = [CLASS NAME],       -- shows only for selected class
            covenant      = [COVENAT NAME],     -- shows only for selected covenant
        },
    },
]]

------------------------------------------------------------------------------------------SHADOWLANDS------------------------------------------------------------------------------------------

    [1550] = { -- Shadowlands
        [45665085] = { portal=true, label=PtoOG, note=Durotar, faction="Horde", requirements={quest=60151} },
        [45665054] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance", requirements={quest=60151} },
        [23411094] = { portal=true, label=WstoOribos },
        [76015007] = { portal=true, label=PtoOribos, covenant=Kyrian, requirements={sanctumtalent=1058} },
        [47928153] = { portal=true, label=PtoOribos, covenant=Nightfae, requirements={sanctumtalent=1055} },
        [62772775] = { portal=true, label=PtoOribos, covenant=Necrolord, requirements={sanctumtalent=1052} },
        },
    [1670] = { -- Oribos - Ring of Fates
        [20835477] = { portal=true, label=PtoOG, note=Durotar, faction="Horde", requirements={quest=60151} },
        [20894567] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance", requirements={quest=60151} },
        [52094278] = { tpplatform=true, label=RingTransference },
        [57145040] = { tpplatform=true, label=RingTransference },
        [52095784] = { tpplatform=true, label=RingTransference },
        [47055029] = { tpplatform=true, label=RingTransference },
        },
    [1671] = { -- Oribos - Ring of Transference
        [49525107] = { portal=true, label=IntoTheMaw },
        [49504243] = { tpplatform=true, label=RingFates },
        [55735162] = { tpplatform=true, label=RingFates },
        [49506073] = { tpplatform=true, label=RingFates },
        [43375150] = { tpplatform=true, label=RingFates },
        },
    [1536] = { -- Maldraxxus
        [51147034] = { portal=true, label=PtoOribos, covenant=Necrolord, requirements={sanctumtalent=1052} },
        },
    [1698] = { -- Seat of the Primus
        [56373149] = { portal=true, label=PtoOribos, covenant=Necrolord, requirements={sanctumtalent=1052} },
        },
    [1533] = { -- Bastion
        [55985276] = { herosrestgate=true, label=AGtoHerosrest }, --1 --Blizzard marked
        [46964891] = { herosrestgate=true, label=AGtoHerosrest }, --2 --Blizzard marked
        [52983802] = { herosrestgate=true, label=AGtoHerosrest }, --3 --Blizzard marked
        [65581959] = { portal=true, label=PtoOribos, covenant=Kyrian, requirements={sanctumtalent=1058} },
        },
        [1707] = { -- Elysian Hold
        [48816478] = { portal=true, label=PtoOribos, covenant=Kyrian, requirements={sanctumtalent=1058} },
        },
    [1565] = { -- Ardenweald
        [46605126] = { portal=true, label=PtoOribos, covenant=Nightfae, requirements={sanctumtalent=1055} },
        },
    [1702] = { -- Hearth of the Forest - The Roots
        [59972842] = { portal=true, label=PtoOribos, covenant=Nightfae, requirements={sanctumtalent=1055} },
        },
    [1543] = { -- The Maw
        [42374215] = { portal=true, label=WstoOribos },
        [48183943] = { portal=true, label=PtoThorghast, requirements={level=60} },
        },

----------------------------------------------------------------------------------------------BfA----------------------------------------------------------------------------------------------

    [875] = { -- Zandalar
        [58206200] = { portal=true, multilabel={PtoSM, PtoOG, PtoTB, PtoSilithus, PtoNazjatar}, multinote={EversongWoods, Durotar, Mulgore, Kalimdor}, faction="Horde" },
        [56307065] = { boat=true, label=StoMechagon, note=KulTiras, requirements={quest=55651}, faction="Horde" },
        [33201921] = { boat=true, label=returntoBoralus, note=TiragardeSound, requirements={quest=51229}, faction="Alliance" }, -- Vol'Dun Barnard "The Smasher" Baysworth
        [62492642] = { boat=true, label=returntoBoralus, note=TiragardeSound, requirements={quest=51088}, faction="Alliance" }, -- Nazmir Desha Stormwallow
        [47137856] = { boat=true, label=returntoBoralus, note=TiragardeSound, requirements={quest=51359}, faction="Alliance" }, -- Zuldazar Daria Smithson
        [58287605] = { boat=true, multilabel={BtoDrustvar, BtoStormsongValley, BtoTiragardeSound}, multinote={KulTiras, KulTiras, KulTiras}, faction="Horde" },
        [58367208] = { mixedportal=true, multilabel={PtoArathiHighlands, PtoDarkshore}, multinote={EasternKingdoms, Kalimdor}, requirements={level=50}, faction="Horde" },
        },
    [862] = { -- Zuldazar
        [58304450] = { portal=true, multilabel={PtoSM, PtoOG, PtoTB, PtoSilithus, PtoNazjatar}, multinote={EversongWoods, Durotar, Mulgore, Kalimdor}, faction="Horde" },
        [55255824] = { boat=true, label=StoMechagon, note=KulTiras, requirements={quest=55651}, faction="Horde" },
        [58466293] = { boat=true, multilabel={BtoDrustvar, BtoStormsongValley, BtoTiragardeSound}, multinote={KulTiras, KulTiras, KulTiras}, faction="Horde" },
        [58596055] = { mixedportal=true, multilabel={PtoArathiHighlands, PtoDarkshore}, multinote={EasternKingdoms, Kalimdor}, requirements={level=50}, faction="Horde" },
        },                               -- quest=51340, Drustvar   quest=51532, Stormsong valley   quest=51421, tiragard sound
    [1165] = { -- Dazar'alor
        [51004600] = { portal=true, multilabel={PtoSM, PtoOG, PtoTB, PtoSilithus, PtoNazjatar}, multinote={EversongWoods, Durotar, Mulgore, Kalimdor}, faction="Horde" },
        [41808760] = { boat=true, label=StoMechagon, note=KulTiras, requirements={quest=55651}, faction="Horde" },
        [51859453] = { mixedportal=true, multilabel={PtoArathiHighlands, PtoDarkshore}, multinote={EasternKingdoms, Kalimdor}, requirements={level=50}, faction="Horde" },
        },
    [1163] = { -- Dazar'alor - The Great Seal
        [73706210] = { portal=true, label=PtoSM, note=EversongWoods, faction="Horde" },
        [73706980] = { portal=true, label=PtoOG, note=Durotar, requirements={quest=46931}, faction="Horde" },
        [73707730] = { portal=true, label=PtoTB, note=Mulgore, faction="Horde" },
        [73708530] = { portal=true, label=PtoSilithus, note=Kalimdor, requirements={quest=46931,level=50}, faction="Horde" },
        [63008530] = { portal=true, label=PtoNazjatar, requirements={quest=55053, level=50}, faction="Horde" },
        },
    [1355] = { -- Nazjatar
        [47286278] = { portal=true, label=PtoZuldazar, note=Zandalar, requirements={quest=55053, level=50}, faction="Horde" },
        [40005260] = { portal=true, label=PtoBoralus, note=KulTiras, requirements={quest=54972, level=50}, faction="Alliance" },
        },
    [876] = { -- Kul Tiras
        [61404950] = { portal=true, multilabel={PtoSW, PtoIF, PtoExodar, PtoSilithus, PtoNazjatar}, multinote={ElwynnForest, DunMorogh, AzuremystIsle, Kalimdor}, faction="Alliance" },
        [69046516] = { boat=true, label=returntoZuldazar, note=Zandalar, requirements={quest=51438}, faction="Horde" }, -- Tiragarde Sound speak: Erul Dawnbrook
        [25936716] = { boat=true, label=returntoZuldazar, note=Zandalar, requirements={quest=51340}, faction="Horde" }, -- Drustvar
        [54371416] = { boat=true, label=returntoZuldazar, note=Zandalar, requirements={quest=51696}, faction="Horde" }, -- Stormsong Valley 51902450 boat Grok Seahandler
        [54141818] = { boat=true, label=returntoZuldazar, note=Zandalar, requirements={quest=51696}, faction="Horde" }, -- Stormsong Valley 51403370 Flightmaster Muka Stormbreaker
        [20332457] = { boat=true, label=returntoZuldazar, note=Zandalar, requirements={quest=55651}, faction="Horde" }, -- Mechagon
--noboat        [20742783] = { boat=true, label=returntoBoralus, note=TiragardeSound, quest=54992, faction="Alliance" }, --Mechagon --quest=54992,
        [62095274] = { boat=true, multilabel={BtoVolDun, BtoNazmir, BtoZuldazar}, multinote={Zandalar, Zandalar, Zandalar}, faction="Alliance" },
        [60855074] = { mixedportal=true, multilabel={PtoArathiHighlands, PtoDarkshore}, multinote={EasternKingdoms, Kalimdor}, requirements={level=50}, faction="Alliance" },
        },      -- Voldun 51283, nazmir 51088, zuldazar 51308
    [895] = { -- Tiragarde Sound
        [74302350] = { portal=true, multilabel={PtoSW, PtoIF, PtoExodar, PtoSilithus, PtoNazjatar}, multinote={ElwynnForest, DunMorogh, AzuremystIsle, Kalimdor}, faction="Alliance" },
        [73692628] = { boat=true, multilabel={BtoVolDun, BtoNazmir, BtoZuldazar}, multinote={Zandalar, Zandalar, Zandalar}, faction="Alliance" },
        [73362568] = { mixedportal=true, multilabel={PtoArathiHighlands, PtoDarkshore}, multinote={EasternKingdoms, Kalimdor}, requirements={level=50}, faction="Alliance" },

        },
    [942] = { -- Stormsong Valley
        [51902450] = { boat=true, label=returntoZuldazar, note=Zandalar, requirements={quest=51696}, faction="Horde" }, --Stormsong valley 51902450 boat Grok Seahandler
        [51403370] = { boat=true, label=returntoZuldazar, note=Zandalar, requirements={quest=51696}, faction="Horde" }, --Stormsong Valley 51403370 Flightmaster Muka Stormbreaker
        },
    [1161] = { -- Boralus
        [70401600] = { portal=true, multilabel={PtoSW, PtoIF, PtoExodar, PtoSilithus, PtoNazjatar}, multinote={ElwynnForest, DunMorogh, AzuremystIsle, Kalimdor}, faction="Alliance" },
        [67952669] = { boat=true, multilabel={BtoVolDun, BtoNazmir, BtoZuldazar}, multinote={Zandalar, Zandalar, Zandalar}, faction="Alliance" },
        [66352486] = { mixedportal=true, multilabel={PtoArathiHighlands, PtoDarkshore}, multinote={EasternKingdoms, Kalimdor}, requirements={level=50}, faction="Alliance" }, --quest=53194,
        },

--------------------------------------------------------------------------------------------LEGION---------------------------------------------------------------------------------------------

    [619] = { -- Broken Isles
        [30712543] = { orderhall=true, multilabel={PtoDala, PtoEmeraldDreamway}, multinote={BrokenIsles}, class="DRUID" },
        [63326940] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="DEATHKNIGHT" },
        [45406523] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [46086351] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        [33675793] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [33675788] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        [52082914] = { portal=true, label=PtoDala, note=BrokenIsles },
        [65492873] = { portal=true, label=PtoHelheim, note=Stormheim },
        [41702157] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="HUNTER" }, -- quest=40953, ????
        [52597039] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Broken Shore
        [61353269] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Stormheim
        [34544019] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Val'sharah
        [46022488] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Highmountain
        [33995326] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Azsuna
        [43944460] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Suramar
        },
    [627] = { -- Dalaran Broken Isles
        [39506320] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [55302400] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        [72854121] = { flightmaster=true, label=GEtoTrueshotLodge, note=BrokenIsles..", "..highmountain, class="HUNTER" }, --quest=40953, ????
        },
    [630] = { -- Azsuna
        [46664141] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [46644121] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
--coord [46664141] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [82135737] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        [47582809] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
        },
    [634] = { -- Stormheim
        [30084070] = { portal=true, label=PtoDala, note=BrokenIsles },
        [73633938] = { portal=true, label=PtoHelheim, note=Stormheim },
        [60175223] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
        },
    [649] = { -- Stormheim - Helheim
        [66584793] = { portal=true, label=PtoStormheim, note=Stormheim },
        },
    [650] = { -- Highmountain
        [34585114] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="HUNTER" }, --quest=40953, ????
        [46115996] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
        },
    [750] = { -- Highmountain - Thunder Totem
        [39834206] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
        },
    [641] = { -- Val'sharah
        [41742385] = { orderhall=true, multilabel={PtoDala, PtoEmeraldDreamway}, multinote={BrokenIsles}, class="DRUID" },
        [54707490] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
        },
    [680] = { -- Suramar
        [33094822] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
        },
    [646] = { -- Broken Shore
        [44816132] = { worderhall=true, label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
        },
    [830] = { -- Krokuun
        [62008694] = { portal=true, label=PtoDala, note=BrokenIsles },
        },
    [832] = { -- Krokuun Vindikaar
        [43272508] = { portal=true, label=PtoDala, note=BrokenIsles },
        },
    [882] = { -- Mac'Aree
        [51668722] = { portal=true, label=PtoDala, note=BrokenIsles },
        },
    [884] = { -- Mac'Aree Vindikaar
        [49332529] = { portal=true, label=PtoDala, note=BrokenIsles },
        },
    [885] = { -- Antorische Ödnis
        [75893732] = { portal=true, label=PtoDala, note=BrokenIsles },
        },
    [887] = { -- Antorische Ödnis Vindikaar
        [33785600] = { portal=true, label=PtoDala, note=BrokenIsles },
        },

-------------------------------------------------------------------------------------------ORDERHALL-------------------------------------------------------------------------------------------

    [747] = { -- The Dreamgrove *DRUID*
        [56604310] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="DRUID" },
        [55502200] = { orderhall=true, label=PtoEmeraldDreamway, class="DRUID" },
        },
    [648] = { -- Acherus: The Ebon Hold - Hall of Command *DEATHKNIGHT*
        [24703370] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="DEATHKNIGHT" },
        },
    [720] = { -- Mardum, the Shattered Abyss - Upper Command Center *DEMONHUNTER*
        [59269182] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="DEMONHUNTER" }, --quest=42872, access to orderhall
        [58361658] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="DEMONHUNTER" },
        },
    [734] = { -- Hall of the Guardian *MAGE*
        [57299056] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="MAGE" },
        [66784670] = { orderhall=true, requirements={spell=223413}, label=PtoValsharah, note=BrokenIsles, class="MAGE" },
        [67214172] = { orderhall=true, requirements={spell=223413}, label=PtoStormheim, note=BrokenIsles, class="MAGE" },
        [60235191] = { orderhall=true, requirements={spell=223413}, label=PtoSuramar, note=BrokenIsles, class="MAGE" },
        [54684456] = { orderhall=true, requirements={spell=223413}, label=PtoHighmountain, note=BrokenIsles, class="MAGE" },
        [54993963] = { orderhall=true, requirements={spell=223413}, label=PtoAzsuna, note=BrokenIsles, class="MAGE" },
        },
    [726] = { -- The Maelstrom *SHAMAN*
        [29835200] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="SHAMAN" },
        },
    [24] = { -- Light's Hope Chapel *PALADIN*
        [37646407] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="PALADIN" },
--      in Eastern Plaguelands and Eastern Kingdoms another portal POI
        },
    [717] = { -- Dreadscar Rift *WARLOCK*
        [74333750] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="WARLOCK" },
        },
    [702] = { -- Netherlight Temple *PRIEST*
        [49798075] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="PRIEST" },
        },
    [695] = { -- Skyhold *WARRIOR*
--      [58322500] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="WARRIOR" },
        [58322500] = { worderhall=true, label=dalaran.."\n"..format(stormheim.."\n"..azsuna.."\n"..valsharah.."\n"..highmountain.."\n"..suramar.."\n"..brokenshore..""), note=BrokenIsles, class="WARRIOR" },
        },
    [709] = { -- The Wandering Isle *MONK*
        [52405714] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="MONK" },
        [50055441] = { orderhall=true, label=PtoPeakofSerenity, note=KunLaiSummit, class="MONK" },
        },
    [739] = { -- Trueshotlodge *HUNTER*
        [48634352] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="HUNTER" }, --quest=40953, access to orderhall ???
        },

----------------------------------------------------------------------------------------------WoD----------------------------------------------------------------------------------------------

    [572] = { -- Draenor
        [73004300] = { portal=true, multilabel={PtoOG, PtoVolmar}, multinote={Durotar, TanaanJungle}, faction="Horde" },
        [73014305] = { portal=true, multilabel={PtoSW, PtoLionswatch}, multinote={ElwynnForest, TanaanJungle}, faction="Alliance" },
        [34683698] = { portal=true, label=PtoWarspear, note=Ashran, requirements={quest=36614}, faction="Horde" },
        [53556087] = { portal=true, label=PtoStormshield, note=Ashran, requirements={quest=36615}, faction="Alliance" },
        [60424563] = { portal=true, label=PtoWarspear, note=Ashran, requirements={quest=37935}, faction="Horde" },
        [59594867] = { portal=true, label=PtoStormshield, note=Ashran, requirements={quest=38445}, faction="Alliance" },
        },
    [588] = { -- Ashran
        [44001300] = { portal=true, multilabel={PtoOG, PtoVolmar}, multinote={Durotar, TanaanJungle}, faction="Horde" },
        [40009000] = { portal=true, multilabel={PtoSW, PtoLionswatch}, multinote={ElwynnForest, TanaanJungle}, faction="Alliance" },
        },
    [590] = { -- Frostwall (Garrison)
        [75104890] = { portal=true, label=PtoWarspear, note=Ashran, requirements={quest=36614}, faction="Horde" },
        },
    [525] = { -- Frostfire Ridge
        [51496593] = { portal=true, label=PtoWarspear, note=Ashran, requirements={quest=36614}, faction="Horde" },
        },
    [582] = { -- Lunarfall (Garrison)
        [70102750] = { portal=true, label=PtoStormshield, note=Ashran, requirements={quest=36615}, faction="Alliance" },
        },
    [539] = { -- Shadowmoon Valley
        [32871553] = { portal=true, label=PtoStormshield, note=Ashran, requirements={quest=36615}, faction="Alliance" },
        },
    [534] = { -- Tanaan Jungle
        [61004734] = { portal=true, label=PtoWarspear, note=Ashran, requirements={quest=37935}, faction="Horde" },
        [57446050] = { portal=true, label=PtoStormshield, note=Ashran, requirements={quest=38445}, faction="Alliance" },
        },
    [624] = { -- Warspear (Ashran)
        [60705160] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        [53104390] = { portal=true, label=PtoVolmar, note=TanaanJungle, requirements={quest=37935}, faction="Horde" },
        },
    [622] = { -- Stormshield (Ashran)
        [60903800] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [36314116] = { portal=true, label=PtoLionswatch, note=TanaanJungle, requirements={quest=38445}, faction="Alliance" },
        },

----------------------------------------------------------------------------------------------MoP----------------------------------------------------------------------------------------------

    [424] = { -- Pandaria
        [29534767] = { portal=true, label=PtoIofT, note=Pandaria, requirements={quest=32680}, faction="Horde" },
        [29144595] = { portal=true, label=PtoIofT, note=Pandaria, requirements={quest=32681}, faction="Alliance" },
        [19100943] = { portal=true, label=PtoSPG, note=TownlongSteppes, requirements={quest=32212}, faction="Horde" },
        [24331611] = { portal=true, label=PtoSPG, note=TownlongSteppes, requirements={quest=32644}, faction="Alliance" },
        [55215658] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [67816760] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [59883557] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        [50784779] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        [44792782] = { orderhall=true, label=PtoOG, note=Durotar, class="MONK", faction="Horde" },
        [44972774] = { orderhall=true, label=PtoSW, note=ElwynnForest, class="MONK", faction="Alliance" },
        },
    [390] = { -- Vale of Eternal Blossoms
        [90876620] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [63461261] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        },
    [1530] = { -- Vale of Eternal Blossoms BFA Vision of N'Zoth
        [91606427] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [63720988] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        },
    [392] = { -- Shrine of Two Moons - The Imperial Mercantile
        [73304270] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        },
    [394] = { -- Shrine of Seven Stars - The Imperial Exchange
        [71703570] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        },
    [388] = { -- Townlong Steppes
        [49746867] = { portal=true, label=PtoIofT, note=Pandaria, requirements={quest=32681}, faction="Alliance" },
        [50607340] = { portal=true, label=PtoIofT, note=Pandaria, requirements={quest=32680}, faction="Horde" },
        },
    [379] = { -- Kun-Lai Summit
        [48534357] = { orderhall=true, label=PtoOG, note=Durotar, class="MONK", faction="Horde" },
        [48964336] = { orderhall=true, label=PtoSW, note=ElwynnForest, class="MONK", faction="Alliance" },
        },
--[[    [371] = { -- The Jade Forest
        [28501401] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        [] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        },
]]--
    [504] = { -- Isle of Thunder
        [64707348] = { portal=true, label=PtoSPG, note=TownlongSteppes, requirements={quest=32644}, faction="Alliance" },
        [33213269] = { portal=true, label=PtoSPG, note=TownlongSteppes, requirements={quest=32212}, faction="Horde" },
        },

---------------------------------------------------------------------------------------------CATA----------------------------------------------------------------------------------------------

    [198] = { -- Mount Hyjal
        [62602310] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [63492444] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        },
    [207] = { -- Deepholm
        [48515381] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [50935310] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        [49325034] = { portal=true, label=PtoTherazanesThrone, note=Deepholm, requirements={quest=26709} },
        [57211352] = { portal=true, label=PtoTempleofEarth, note=Deepholm, requirements={quest=26971} },
        },
    [948] = { -- Maelstrom
        [51182842] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [51172840] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        },
    [241] = { -- Twilight Highlands
        [79517782] = { portal=true, label=PtoSW, note=ElwynnForest, requirements={quest=27537}, faction="Alliance" },
        [73625351] = { portal=true, label=PtoOG, note=Durotar, requirements={quest=26798}, faction="Horde" },
        },
    [244] = { -- Tol Barad
        [47115193] = { portal=true, label=PtoSW, note=ElwynnForest, requirements={level=30}, faction="Alliance" },
        [47115192] = { portal=true, label=PtoOG, note=Durotar, requirements={level=30}, faction="Horde" },
        },
    [245] = { -- Tol Barad Peninsula
        [75255887] = { portal=true, label=PtoSW, note=ElwynnForest, requirements={level=30}, faction="Alliance" },
        [56277966] = { portal=true, label=PtoOG, note=Durotar, requirements={level=30}, faction="Horde" },
        },

---------------------------------------------------------------------------------------------WotLK---------------------------------------------------------------------------------------------

    [125] = { -- Dalaran Northrend
        [40086282] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [55302542] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        [25634785] = { portal=true, label=PtotPurpleParlor },
        },
    [127] = { -- Crystalsong Forest
        [26194278] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [31223174] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        },
    [113] = { -- Northrend
        [47874119] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [48664124] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        [78858355] = { aboat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        [78858356] = { boat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
        [24607066] = { aboat=true, label=BtoSW, note=ElwynnForest, faction="Horde" },
        [24607065] = { boat=true, label=BtoSW, note=ElwynnForest, faction="Alliance" },
        [47106782] = { boat=true, multilabel={BtoUnuPe, BtoKamagua}, multinote={BoreanTundra, HowlingFjord} },
        [30506590] = { boat=true, label=BtoMoaKiHarbor, note=Dragonblight },
        [66408188] = { boat=true, label=BtoMoaKiHarbor, note=Dragonblight },
        [17556488] = { zeppelin=true, label=ZtoOG, note=Durotar, faction="Horde" },
        [17556489] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
        [84057266] = { portal=true, label=PtoUC, note=Tirisfal, faction="Horde" },
        },
    [115] = { -- Dragonblight
        [47797887] = { boat=true, label=BtoUnuPe, note=BoreanTundra },
        [49847853] = { boat=true, label=BtoKamagua, note=HowlingFjord },
        },
    [114] = { -- Borean Tundra
        [79015410] = { boat=true, label=BtoMoaKiHarbor, note=Dragonblight },
        [59946947] = { aboat=true, label=BtoSW, note=ElwynnForest, faction="Horde" },
        [41255344] = { zeppelin=true, label=ZtoOG, note=Durotar, faction="Horde" },
        [41255345] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
        },
    [117] = { -- Howling Fjord
        [23295769] = { boat=true, label=BtoMoaKiHarbor, note=Dragonblight },
        [61506270] = { aboat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        [77612813] = { portal=true, label=PtoUC, note=Tirisfal, faction="Horde" },
        },

----------------------------------------------------------------------------------------------BC-----------------------------------------------------------------------------------------------

    [100] = { -- Hellfire Peninsula
        [89225101] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [89234946] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        },
    [111] = { -- Shattrath City
        [57224827] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [48594200] = { portal=true, label=PtoIofQD, note=EasternKingdoms },
        [56834888] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        },
    [101] = { -- Outland
        [43886598] = { portal=true, multilabel={PtoSW, PtoIofQD}, multinote={ElwynnForest, EasternKingdoms}, faction="Alliance" },
        [43886599] = { portal=true, multilabel={PtoOG, PtoIofQD}, multinote={Durotar, EasternKingdoms}, faction="Horde" },
        [69075236] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [69075190] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        },
    [108] = { -- Terokkar Forest
        [30252350] = { portal=true, multilabel={PtoSW, PtoIofQD}, multinote={ElwynnForest, EasternKingdoms}, faction="Alliance" },
        [30252350] = { portal=true, multilabel={PtoOG, PtoIofQD}, multinote={Durotar, EasternKingdoms}, faction="Horde" },
        },
    [103] = { -- Exodar
        [48306290] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        },
    [97] = { -- Azuremyst Isle
        [20335407] = { requirements={timetravel={quest=54411, spell=290245}}, portal=true, label=PtoDarnassus, note=Teldrassil },
        [26364616] = { portal=true, label=PtoSW, note=ElwynnForest..")\n("..inExodar.."", faction="Alliance" },
        },
    [110] = { -- Silvermoon City
        [49401510] = { portal=true, label=PtoUC, note=Tirisfal..")\n("..Orboftranslocation.."", faction="Horde" },
        [58501890] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        },
    [94] = { -- Eversong Woods
        [52803270] = { portal=true, multilabel={PtoUC, PtoOG}, multinote={Tirisfal, Durotar}, faction="Horde" },
        },

--------------------------------------------------------------------------------------------Vanilla--------------------------------------------------------------------------------------------

    [12] = { -- Kalimdor
        [59236650] = { aboat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        [59246651] = { boat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
        [56835629] = { boat=true, label=BtoBootyBay, note=StranglethornVale },
        [43561640] = { requirements={timetravel={quest=54411, spell=290245}}, portal=true, multilabel={PtoSW, PtoExodar}, multinote={ElwynnForest, AzuremystIsle},faction="Alliance" },
        [39401090] = { requirements={timetravel={quest=54411, spell=290245}}, portal=true, multilabel={PtoExodar, PtoHellfirePeninsula}, multinote={AzuremystIsle, Outland}, faction="Alliance" },
        [43211616] = { requirements={timetravel={quest=54411, spell=290245}}, portal=true, label=PtoExodar, note=Teldrassil, faction="Horde" },
        [29922620] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [59468340] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [59448340] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        [56122758] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [56222774] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        [29332713] = { requirements={timetravel={quest=54411, spell=290245}}, portal=true, label=PtoDarnassus, note=Teldrassil },
        [45405420] = { zeppelin=true, label=ZtoOG, note=Durotar, faction="Horde" },
        [45405421] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
        [58154245] = { zeppelin=true, multilabel={ZtoTB, ZtoStranglethornVale, ZtoBoreanTundra}, multinote={Mulgore, GromgolBaseCamp, WarsongHold}, faction="Horde" },
        [58154246] = { hzeppelin=true, multilabel={ZtoTB, ZtoStranglethornVale, ZtoBoreanTundra}, multinote={Mulgore, GromgolBaseCamp, WarsongHold}, faction="Alliance" },
        [42857909] = { requirements={quest=46931, level=50, timetravel={quest=50659, spell=255152, turn=true}}, portal=true, label=PtoZuldazar, note=Zandalar, faction="Horde" },
        [42847905] = { requirements={level=50, timetravel={quest=50659, spell=255152, turn=true}}, portal=true, label=PtoBoralus, note=TiragardeSound, faction="Alliance" },
        [59414237] = { portal=true, multilabel={PtoTolBarad, PtoUldum, PtoDeepholm, PtoVashjir, PtoHyjal, PtoTwilightHighlands, PtoUC, PtoDala, PtoJadeForest, PtoZuldazar, PtoAzsuna, PtoWarspear, PtoShattrath, PtoCavernsofTime, PtoOribos},
                                    multinote={EasternKingdoms, Kalimdor, Maelstrom, EasternKingdoms, Kalimdor, EasternKingdoms, Tirisfal, CrystalsongForest, Pandaria, Zandalar, BrokenIsles, Ashran, TerokkarForest, Tanaris, Shadowlands}, faction="Horde" },
        [46612303] = { requirements={level=50, warfront=118, timetravel={quest=54411, spell=290245}}, portal=true, label=PtoPortofBoralus, note=TiragardeSound, faction="Alliance" },
        [46302282] = { requirements={level=50, warfront=118, timetravel={quest=54411, spell=290245}}, portal=true, label=PtoPortofZandalar, note=Zuldazar, faction="Horde" },
        },-- Portal to Oribos quest=60151
    [7] = { -- Mulgore
        [33692368] = { zeppelin=true, label=ZtoOG, note=Durotar, faction="Horde" },
        [33692369] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
        },
    [88] = { -- Thunder Bluff
        [14222574] = { zeppelin=true, label=ZtoOG, note=Durotar, faction="Horde" },
        [14222575] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
        },
    [1] = { -- Durotar
        [47881015] = { portal=true, multilabel={PtoDala, PtoJadeForest, PtoZuldazar, PtoAzsuna, PtoWarspear, PtoShattrath, PtoCavernsofTime, PtoOribos},
                                    multinote={CrystalsongForest, Pandaria, Zandalar, BrokenIsles, Ashran, TerokkarForest, Tanaris, Shadowlands}, faction="Horde" },
        [45550380] = { hzeppelin=true, multilabel={ZtoTB, ZtoStranglethornVale, ZtoBoreanTundra}, multinote={Mulgore, GromgolBaseCamp, WarsongHold}, faction="Alliance" },
        [45550381] = { zeppelin=true, multilabel={ZtoTB, ZtoStranglethornVale, ZtoBoreanTundra}, multinote={Mulgore, GromgolBaseCamp, WarsongHold}, faction="Horde" },
        [46980375] = { portal=true, multilabel={PtoTolBarad, PtoUldum, PtoDeepholm, PtoVashjir, PtoHyjal, PtoTwilightHighlands, PtoUC}, multinote={EasternKingdoms, Kalimdor, Maelstrom, EasternKingdoms, Kalimdor, EasternKingdoms, Tirisfal}, faction="Horde" },
        },
    [85] = { -- Orgrimmar
        [59078945] = { portal=true, multilabel={PtoDala, PtoJadeForest, PtoZuldazar, PtoAzsuna, PtoWarspear, PtoShattrath, PtoCavernsofTime, PtoOribos}, multinote={CrystalsongForest, Pandaria, Zandalar, BrokenIsles, Ashran, TerokkarForest, Tanaris, Shadowlands}, faction="Horde" },
        [50435651] = { portal=true, label=PtoUC, note=Tirisfal, faction="Horde" },
        [43126480] = { zeppelin=true, label=ZtoTB, note=Mulgore, faction="Horde" },
        [43126481] = { hzeppelin=true, label=ZtoTB, note=Mulgore, faction="Alliance" },
        [50103773] = { portal=true, multilabel={PtoTolBarad, PtoUldum, PtoDeepholm, PtoVashjir, PtoHyjal, PtoTwilightHighlands}, multinote={EasternKingdoms, Kalimdor, Maelstrom, EasternKingdoms, Kalimdor, EasternKingdoms}, faction="Horde" },
                                    -- Vashj'ir complete quest 25924
                                    -- TolBarad at level 30
                                    -- other portals at level ?? Shadowlands
        [45306178] = { hzeppelin=true, label=ZtoBoreanTundra, note=WarsongHold, faction="Alliance" },
        [52885242] = { hzeppelin=true, label=ZtoStranglethornVale, note=GromgolBaseCamp, faction="Alliance" },
        },
    [71] = { -- Tanaris
        [65794954] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        [65924954] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        },
    [74] = { -- Cavern of Time
        [58202660] = { portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        [59002670] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        },
    [81] = { -- Silithus
        [41604520] = { requirements={quest=46931, level=50, timetravel={quest=50659, spell=255152, turn=true}}, portal=true, label=PtoZuldazar, note=Zandalar, faction="Horde" },
        [41474479] = { requirements={level=50, timetravel={quest=50659, spell=255152, turn=true}}, portal=true, label=PtoBoralus, note=TiragardeSound, faction="Alliance" },
        },
    [70] = { -- Dustwallow Marsh
        [71625648] = { aboat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        [71625647] = { boat=true, label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
        },
    [62] = { -- Darkshore
        [48023627] = { requirements={level=50, warfront=118, timetravel={quest=54411, spell=290245}}, portal=true, label=PtoPortofBoralus, note=TiragardeSound, faction="Alliance" },
        [46243511] = { requirements={level=50, warfront=118, timetravel={quest=54411, spell=290245}}, portal=true, label=PtoPortofZandalar, note=Zuldazar, faction="Horde" },
        },
    [89] = { -- Darnassus
        [44247867] = { requirements={timetravel={quest=54411, spell=290245}}, portal=true, multilabel={PtoExodar, PtoHellfirePeninsula}, multinote={AzuremystIsle, Outland}, faction="Alliance" },
        },
    [57] = { -- Teldrassil
        [29085646] = { requirements={timetravel={quest=54411, spell=290245}}, portal=true, multilabel={PtoExodar, PtoHellfirePeninsula}, multinote={AzuremystIsle, Outland}, faction="Alliance" },
        [55009370] = { requirements={timetravel={quest=54411, spell=290245}}, portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [52048951] = { requirements={timetravel={quest=54411, spell=290245}}, portal=true, label=PtoExodar, note=AzuremystIsle },
        },
    [56] = { -- Wetlands
        [06216261] = { aboat=true, label=BtoTheramore, note=DustwallowMarsh, faction="Horde" },
        [04415718] = { aboat=true, label=BtoHowlingFjord, note=Valgarde, faction="Horde" },
        },
--[[    NOT USED
    [10] = { -- Northern Barrens
        [70307341] = { boat=true, label=format(BtoBootyBay) },
        },
    [210] = { -- Cape of Stranglethorn
        [38546670] = { boat=true, label=format(BtoRatchet) },
        },
]]--
    [13] = { -- Eastern Kingdom
        [44068694] = { zeppelin=true, multilabel={ZtoOG, PtoUC}, multinote={Durotar, Tirisfal}, faction="Horde" },
        [44068695] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
        [41107209] = { aboat=true, multilabel={BtoBoralus, BtoBoreanTundra}, multinote={KulTiras, ValianceKeep}, faction="Horde" },
        [41107210] = { boat=true, multilabel={BtoBoralus, BtoBoreanTundra, PtoDarnassus}, multinote={TiragardeSound, ValianceKeep, Teldrassil}, faction="Alliance" },
        [45995488] = { aboat=true, multilabel={BtoTheramore, BtoHowlingFjord}, multinote={DustwallowMarsh, Valgarde}, faction="Horde" },
        [45995482] = { boat=true, multilabel={BtoTheramore, BtoHowlingFjord}, multinote={DustwallowMarsh, Valgarde}, faction="Alliance" },
        [42999362] = { boat=true, label=BtoRatchet, note=NorthernBarrens },
        [56161316] = { portal=true, multilabel={PtoOG, PtoUC}, multinote={Durotar, Tirisfal}, faction="Horde" },
        [43637155] = { portal=true, multilabel={PtoTolBarad, PtoUldum, PtoDeepholm, PtoVashjir, PtoHyjal, PtoTwilightHighlands, DrTtoIF, PtoDarnassus, PtoDala, PtoJadeForest, PtoBoralus, PtoAzsuna, PtoStormshield, PtoShattrath, PtoExodar, PtoCavernsofTime, PtoOribos},
                                    multinote={EasternKingdoms, Kalimdor, Maelstrom, EasternKingdoms, Kalimdor, EasternKingdoms, DunMorogh, Teldrassil, CrystalsongForest, Pandaria, TiragardeSound, BrokenIsles, Ashran, TerokkarForest, AzuremystIsle, Tanaris, Shadowlands}, faction="Alliance" },
        [43337195] = { tram=true, label=DrTtoIF, note=DunMorogh, faction="Horde" },
        [43863354] = { requirements={timetravel={quest=52758, spell=276824}}, portal=true, multilabel={PtoHowlingFjord, PtoOG, PtoStranglethornVale, PtoSM, PtoHellfirePeninsula}, multinote={VengeanceLanding, Durotar, GromgolBaseCamp, EversongWoods, Outland}, faction="Horde" },
        [47835898] = { tram=true, label=DrTtoSW, note=ElwynnForest },
        [60835906] = { portal=true, label=PtoSW, note=ElwynnForest, requirements={quest=27537}, faction="Alliance" },
        [35224839] = { portal=true, label=PtoSW, note=ElwynnForest, requirements={level=30}, faction="Alliance" },
        [60105603] = { portal=true, label=PtoOG, note=Durotar, requirements={quest=26798}, faction="Horde" }, --quest=26798,
        [34394957] = { portal=true, label=PtoOG, note=Durotar, requirements={level=30}, faction="Horde" },
        [57663241] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="PALADIN" },
        [49714419] = { requirements={level=50, warfront=11, timetravel={quest=52781, spell=276950}}, portal=true, label=PtoPortofZandalar, note=Zuldazar, faction="Horde" },
        [49244725] = { requirements={level=50, warfront=11, timetravel={quest=52781, spell=276950}}, portal=true, label=PtoPortofBoralus, note=TiragardeSound, faction="Alliance" },
        [41003949] = { portal=true, label=PtoDalaCrater, note=HillsbradFoothills, faction="Horde", requirements={quest=27478} },
        [43674008] = { portal=true, label=PtoSepulcher, note=SilverpineForest, faction="Horde", requirements={quest=27478} },
        },-- Portal to Oribos quest=60151
    [84] = { -- Stormwind City
        [74481841] = { portal=true, multilabel={PtoTolBarad, PtoUldum, PtoDeepholm, PtoVashjir, PtoHyjal, PtoTwilightHighlands}, multinote={EasternKingdoms, Kalimdor, Maelstrom, EasternKingdoms, Kalimdor, EasternKingdoms}, faction="Alliance" },
        [46419032] = { portal=true, multilabel={PtoDala, PtoJadeForest, PtoBoralus, PtoAzsuna, PtoStormshield, PtoShattrath, PtoExodar, PtoCavernsofTime, PtoOribos},
                                    multinote={CrystalsongForest, Pandaria, TiragardeSound, BrokenIsles, Ashran, TerokkarForest, AzuremystIsle, Tanaris, Shadowlands}, faction="Alliance" },
        [22015670] = { aboat=true, label=BtoBoralus, note=TiragardeSound, faction="Horde" },
        [17592553] = { aboat=true, label=BtoBoreanTundra, note=ValianceKeep, faction="Horde" },
        [23805620] = { portal=true, label=PtoDarnassus, note=Teldrassil, faction="Alliance" },
        [69403140] = { tram=true, label=DrTtoIF, note=DunMorogh },
        },
    [499] = { -- Deeprun Tram
        [42554350] = { tram=true, label=DrTtoIF, note=DunMorogh },
        [42556750] = { tram=true, label=DrTtoIF, note=DunMorogh },
        },
    [37] = { -- Elwynn Forest
        [17804775] = { portal=true, multilabel={PtoDala, PtoJadeForest, PtoBoralus, PtoAzsuna, PtoStormshield, PtoShattrath, PtoExodar, PtoCavernsofTime, PtoOribos},
                                    multinote={CrystalsongForest, Pandaria, TiragardeSound, BrokenIsles, Ashran, TerokkarForest, AzuremystIsle, Tanaris, Shadowlands}, faction="Alliance" },
        [06003035] = { aboat=true, label=BtoBoralus, note=TiragardeSound, faction="Horde" },
        [03631530] = { aboat=true, label=BtoBoreanTundra, note=ValianceKeep, faction="Horde" },
        [07253035] = { portal=true, label=PtoDarnassus, note=Teldrassil, faction="Alliance" },
        [31801155] = { portal=true, multilabel={PtoTolBarad, PtoUldum, PtoDeepholm, PtoVashjir, PtoHyjal, PtoTwilightHighlands}, multinote={EasternKingdoms, Kalimdor, Maelstrom, EasternKingdoms, Kalimdor, EasternKingdoms}, faction="Alliance" },
        [29251812] = { tram=true, label=DrTtoIF, note=DunMorogh },
        },
    [90] = { -- Undercity
        [85301700] = { requirements={timetravel={quest=52758, spell=276824}}, portal=true, label=PtoHellfirePeninsula, note=Outland, faction="Horde" },
        },
    [18] = { -- Tirisfal Glades
        [65906865] = { requirements={timetravel={quest=52758, spell=276824}}, portal=true, label=PtoHellfirePeninsula, note=Outland..")\n("..inUCMq.."", faction="Horde" },
        [59416743] = { requirements={timetravel={quest=52758, spell=276824}}, portal=true, label=PtoSM, note=EversongWoods..")\n("..Orboftranslocation.."", faction="Horde" },
        [60475885] = { requirements={timetravel={quest=52758, spell=276824}}, portal=true, label=PtoOG, note=Durotar, faction="Horde" },
        [62035926] = { requirements={timetravel={quest=52758, spell=276824}}, portal=true, label=PtoStranglethornVale, note=GromgolBaseCamp, faction="Horde" },
        [58875901] = { requirements={timetravel={quest=52758, spell=276824}}, portal=true, label=PtoHowlingFjord, note=VengeanceLanding, faction="Horde" },
        },
    [21] = { -- Silverpine Forest
        [47254337] = { portal=true, label=PtoDalaCrater, note=HillsbradFoothills, faction="Horde", requirements={quest=27478} },
        },
    [25] = { -- Hillsbrad Foothills
        [30293662] = { portal=true, label=PtoSepulcher, note=SilverpineForest, faction="Horde", requirements={quest=27478} },
        },
    [14] = { -- Arathi Highlands
        [27432937] = { requirements={level=50, warfront=11, timetravel={quest=52781, spell=276950}}, portal=true, label=PtoPortofZandalar, note=Zuldazar, faction="Horde" },
        [21956514] = { requirements={level=50, warfront=11, timetravel={quest=52781, spell=276950}}, portal=true, label=PtoPortofBoralus, note=TiragardeSound, faction="Alliance" },
        },
    [50] = { -- Northern Stranglethorn
        [37195161] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
        },
    [224] = { -- Stranglethorn Vale
        [41403390] = { hzeppelin=true, label=ZtoOG, note=Durotar, faction="Alliance" },
        },
    [23] = { -- Eastern Plaguelands
        [75234942] = { orderhall=true, label=PtoDala, note=BrokenIsles, class="PALADIN" },
        },
    [27] = { -- Dun Morogh
        [70452731] = { tram=true, label=DrTtoSW, note=ElwynnForest },
        },
    [87] = { -- Ironforge
        [76205120] = { tram=true, label=DrTtoSW, note=ElwynnForest },
        },

}