----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local HandyNotes_Oribos = {}
local constants = {}
HandyNotes_Oribos.constants = constants

----------------------------------------------------------------------------------------------------
----------------------------------------------DEFAULTS----------------------------------------------
----------------------------------------------------------------------------------------------------

constants.defaults = {
    profile = {
        icon_scale = 1.25,
        icon_alpha = 1.0,

        show_auctioneer = true,
        show_banker = true,
        show_barber = true,
        show_innkeeper = true,
        show_mail = true,
        show_portal = true,
        show_tpplatform = true,
        show_reforge = true,
        show_stablemaster = true,
        show_trainer = true,
        show_onlymytrainers = false,
        show_transmogrifier = true,
        show_vendor = true,
        show_void = true,
--        show_others = true,

        easy_waypoint = true,

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

constants.icon = {
    portal = {
        icon = [[Interface\MINIMAP\OBJECTICONSATLAS]],
        tCoordLeft = left,
        tCoordRight = right,
        tCoordTop = top,
        tCoordBottom = bottom,
    },

    MagePortalHorde = {
        icon = [[Interface\MINIMAP\OBJECTICONSATLAS]],
        tCoordLeft = left2,
        tCoordRight = right2,
        tCoordTop = top2,
        tCoordBottom = bottom2,
    },

    auctioneer      = "Interface\\MINIMAP\\TRACKING\\Auctioneer",
    anvil           = "Interface\\AddOns\\HandyNotes\\icons\\anvil",
    banker          = "Interface\\MINIMAP\\TRACKING\\Banker",
    barber          = "Interface\\MINIMAP\\TRACKING\\Barbershop",
--    flightmaster    = "Interface\\MINIMAP\\TRACKING\\FlightMaster",
--    food            = "Interface\\MINIMAP\\TRACKING\\Food",
    innkeeper       = "Interface\\MINIMAP\\TRACKING\\Innkeeper",
    mail            = "Interface\\AddOns\\HandyNotes\\icons\\mail",
    reforge         = "Interface\\AddOns\\HandyNotes\\icons\\reforge",
    stablemaster    = "Interface\\MINIMAP\\TRACKING\\StableMaster",
    trainer      = "Interface\\MINIMAP\\TRACKING\\Profession",
--    reagents        = "Interface\\MINIMAP\\TRACKING\\Reagents",
    transmogrifier  = "Interface\\MINIMAP\\TRACKING\\Transmogrifier",
    tpplatform      = "Interface\\MINIMAP\\TempleofKotmogu_ball_cyan",
    vendor          = "Interface\\AddOns\\HandyNotes\\icons\\vendor",
    void            = "Interface\\AddOns\\HandyNotes\\icons\\void",

}


----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------
local Oribos = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_Oribos", "AceEvent-3.0", "AceTimer-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local AceDB = LibStub("AceDB-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes")

_G.HandyNotes_Oribos = Oribos

local IsQuestCompleted = C_QuestLog.IsQuestFlaggedCompleted
local constantsicon = constants.icon

----------------------------------------------------------------------------------------------------
-----------------------------------------------LOCALS-----------------------------------------------
----------------------------------------------------------------------------------------------------

local requires          = L["handler_tooltip_requires"]
local RequiresQuest     = L["handler_tooltip_quest"]
local RetrievindData    = L["handler_tooltip_data"]

----------------------------------------------------------------------------------------------------
--------------------------------------------GET NPC NAMES-------------------------------------------
----------------------------------------------------------------------------------------------------

local NPClinkOribos = CreateFrame("GameTooltip", "NPClinkOribos", UIParent, "GameTooltipTemplate")
local function GetCreatureNamebyID(id)
	NPClinkOribos:SetOwner(UIParent, "ANCHOR_NONE")
	NPClinkOribos:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(id))
    local name      = _G["NPClinkOribosTextLeft1"]:GetText()
    local sublabel  = _G["NPClinkOribosTextLeft2"]:GetText()
    return name, sublabel
end

----------------------------------------------------------------------------------------------------
---------------------------------------------PROFESSIONS--------------------------------------------
----------------------------------------------------------------------------------------------------

function Oribos:CharacterHasProfession(SkillLineID)
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
    if prof1 and prof2 then
        return true
    end
    return false
end

----------------------------------------------------------------------------------------------------
------------------------------------------------ICON------------------------------------------------
----------------------------------------------------------------------------------------------------

local function SetIcon(point)
    local icon_key

    for i, k in ipairs({
        "auctioneer", "anvil", "banker", "barber", "innkeeper", "mail", "portal",
        "reforge", "stablemaster", "trainer", "transmogrifier", "tpplatform", "vendor", "void"
    }) do
        if point[k] then icon_key = k end
    end

    if (icon_key and constantsicon[icon_key]) then
        return constantsicon[icon_key]
    end
end

local GetPointInfo = function(point)
    local icon
    if point then
        local label = GetCreatureNamebyID(point.npc) or point.label or UNKNOWN
        if (point.portal and (point.lvl or point.quest)) then
            if (point.lvl and (UnitLevel("player") < point.lvl)) and (point.quest and not IsQuestCompleted(point.quest)) then
                icon = HandyNotes_Oribos.constants.icon["MagePortalHorde"]
            elseif (point.lvl and (UnitLevel("player") < point.lvl)) then
                icon = HandyNotes_Oribos.constants.icon["MagePortalHorde"]
            elseif (point.quest and not IsQuestCompleted(point.quest)) then
                icon = HandyNotes_Oribos.constants.icon["MagePortalHorde"]
            else
                icon = SetIcon(point)
            end
        else
            icon = SetIcon(point)
        end
        return label, icon, point.scale, point.alpha
    end
end

local GetPoinInfoByCoord = function(uMapID, coord)
    return GetPointInfo(HandyNotes_Oribos.DB.points[uMapID] and HandyNotes_Oribos.DB.points[uMapID][coord])
end

----------------------------------------------------------------------------------------------------
----------------------------------------------TOOLTIP-----------------------------------------------
----------------------------------------------------------------------------------------------------

local function SetTooltip(tooltip, point)

    if point then
        if point.npc then
            local name, sublabel = GetCreatureNamebyID(point.npc)
            if name then
                tooltip:AddLine(name)
            end
            if sublabel then
                tooltip:AddLine(sublabel,1,1,1)
            end
        end
        if point.label then
            tooltip:AddLine(point.label)
        end
        if point.note then
            tooltip:AddLine(point.note)
        end
        if (point.quest and not IsQuestCompleted(point.quest)) then
            if C_QuestLog.GetTitleForQuestID(point.quest) ~= nil then
                tooltip:AddLine(RequiresQuest..": ["..C_QuestLog.GetTitleForQuestID(point.quest).."] (ID: "..point.quest..")",1,0,0)
            else
                tooltip:AddLine(RetrievindData,1,0,1) -- pink
                C_Timer.After(1, function() Oribos:Refresh() end) -- Refresh
--              print("refreshed")
            end
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end

local SetTooltipByCoord = function(tooltip, uMapID, coord)
    return SetTooltip(tooltip, HandyNotes_Oribos.DB.points[uMapID] and HandyNotes_Oribos.DB.points[uMapID][coord])
end

----------------------------------------------------------------------------------------------------
--[[-----------------------------------------PluginHandler--------------------------------------------
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
    HandyNotes_Oribos.hidden[uMapID][coord] = true
    Oribos:Refresh()
end

local function closeAllDropdowns()
    CloseDropDownMenus(1)
end

local function addTomTomWaypoint(button, uMapID, coord)
    if TomTom then
        local x, y = HandyNotes:getXY(coord)
        TomTom:AddWaypoint(uMapID, x, y, {
            title = GetPoinInfoByCoord(uMapID, coord),
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end]]

--------------------------------------------CONTEXT MENU--------------------------------------------

--[[do
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

            if TomTom and not HandyNotes_Oribos.db.easy_waypoint then
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

    local HL_Dropdown = CreateFrame("Frame", "HandyNotes_OribosDropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function PluginHandler:OnClick(button, down, uMapID, coord)
        if ((down or button ~= "RightButton") and HandyNotes_Oribos.db.easy_waypoint and TomTom) then
            return
        end
        if ((button == "RightButton" and not down) and (not HandyNotes_Oribos.db.easy_waypoint or not TomTom)) then
            currentMapID = uMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        end
        if (IsControlKeyDown() and HandyNotes_Oribos.db.easy_waypoint and TomTom) then
            currentMapID = uMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        else
        if HandyNotes_Oribos.db.easy_waypoint and TomTom then
            addTomTomWaypoint(button, uMapID, coord)
        end
        end
    end
end]]

--[[do

local currentMapID = nil
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do
            if value and HandyNotes_Oribos:ShouldShow(state, value, currentMapID) then
                local _, icon, scale, alpha = GetPointInfo(value)
                    scale = (scale or 1) * HandyNotes_Oribos.db.icon_scale
                    alpha = (alpha or 1) * HandyNotes_Oribos.db.icon_alpha
                return state, nil, icon, scale, alpha
            end
            state, value = next(t, state)
        end
        return nil, nil, nil, nil, nil, nil
    end
    function PluginHandler:GetNodes2(uMapID, minimap)
        currentMapID = uMapID
        return iter, HandyNotes_Oribos.DB.points[uMapID], nil
    end
    function HandyNotes_Oribos:ShouldShow(coord, point, currentMapID)
    if not HandyNotes_Oribos.db.force_nodes then
        if (HandyNotes_Oribos.hidden[currentMapID] and HandyNotes_Oribos.hidden[currentMapID][coord]) then
            return false
        end
        -- this will check if any node is for a specific class
        if (point.class and point.class ~= select(2, UnitClass("player"))) then
            return false
        end
        -- this will check if any node is for a specific faction
        if (point.faction and point.faction ~= select(1, UnitFactionGroup("player"))) then
            return false
        end
        -- this will check if any node is for a specific covenant
        if (point.covenant and point.covenant ~= C_Covenants.GetActiveCovenantID()) then
            return false
        end
        -- this will check if the node is for a specific profession
        if (point.profession and (not Oribos:CharacterHasProfession(point.profession) and HasTwoProfessions()) and HandyNotes_Oribos.db.show_onlymytrainers and not point.auctioneer) then
            return false
        end
        if (point.auctioneer and (not Oribos:CharacterHasProfession(point.profession) or not HandyNotes_Oribos.db.show_auctioneer)) then return false; end
        if (point.banker and not HandyNotes_Oribos.db.show_banker) then return false; end
        if (point.barber and not HandyNotes_Oribos.db.show_barber) then return false; end
        if (point.innkeeper and not HandyNotes_Oribos.db.show_innkeeper) then return false; end
        if (point.mail and not HandyNotes_Oribos.db.show_mail) then return false; end
        if (point.portal and (not HandyNotes_Oribos.db.show_portal or IsAddOnLoaded("HandyNotes_TravelGuide"))) then return false; end
        if (point.tpplatform and (not HandyNotes_Oribos.db.show_tpplatform or IsAddOnLoaded("HandyNotes_TravelGuide"))) then return false; end
        if (point.reforge and not HandyNotes_Oribos.db.show_reforge) then return false; end
        if (point.stablemaster and not HandyNotes_Oribos.db.show_stablemaster) then return false; end
        if (point.trainer and not HandyNotes_Oribos.db.show_trainer) then return false; end
        if (point.transmogrifier and not HandyNotes_Oribos.db.show_transmogrifier) then return false; end
        if ((point.vendor or point.anvil) and not HandyNotes_Oribos.db.show_vendor) then return false; end
        if (point.void and not HandyNotes_Oribos.db.show_void) then return false; end
    end
        return true
    end
end]]

---------------------------------------------------------------------------------------------------
----------------------------------------------REGISTER---------------------------------------------
---------------------------------------------------------------------------------------------------

function Oribos:OnInitialize()
    self.db = AceDB:New("HandyNotes_OribosDB", HandyNotes_Oribos.constants.defaults)

    profile = self.db.profile
    HandyNotes_Oribos.db = profile

    global = self.db.global
    HandyNotes_Oribos.global = global

    HandyNotes_Oribos.hidden = self.db.char.hidden

    if HandyNotes_Oribos.global.dev then
        HandyNotes_Oribos.devmode()
    end

    -- Initialize database with HandyNotes
    HandyNotes:RegisterPluginDB(Oribos.pluginName, PluginHandler, HandyNotes_Oribos.config.options)
end

function Oribos:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", Oribos.pluginName)
end

function Oribos:OnEnable()
end

----------------------------------------------EVENTS-----------------------------------------------

local frame, events = CreateFrame("Frame"), {};
function events:ZONE_CHANGED(...)
    Oribos:Refresh()

    if HandyNotes_Oribos.global.dev and HandyNotes_Oribos.db.show_prints then
        print("Oribos: refreshed after ZONE_CHANGED")
    end
end

function events:ZONE_CHANGED_INDOORS(...)
    Oribos:Refresh()

    if HandyNotes_Oribos.global.dev and HandyNotes_Oribos.db.show_prints then
        print("Oribos: refreshed after ZONE_CHANGED_INDOORS")
    end
end

function events:QUEST_FINISHED(...)
    Oribos:Refresh()

    if HandyNotes_Oribos.global.dev and HandyNotes_Oribos.db.show_prints then
        print("Oribos: refreshed after QUEST_FINISHED")
    end
end

function events:SKILL_LINES_CHANGED(...)
    Oribos:Refresh()

    if HandyNotes_Oribos.global.dev and HandyNotes_Oribos.db.show_prints then
        print("Oribos: refreshed after SKILL_LINES_CHANGED")
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
Oribos.pluginName  = L["config_plugin_name"]
Oribos.description = L["config_plugin_desc"]

----------------------------------------------------------------------------------------------------
-----------------------------------------------CONFIG-----------------------------------------------
----------------------------------------------------------------------------------------------------

local config = {}
HandyNotes_Oribos.config = config

config.options = {
    type = "group",
    name = Oribos.pluginName,
    desc = Oribos.description,
    childGroups = "tab",
    get = function(info) return HandyNotes_Oribos.db[info[#info]] end,
    set = function(info, v)
        HandyNotes_Oribos.db[info[#info]] = v
        Oribos:SendMessage("HandyNotes_NotifyUpdate", Oribos.pluginName)
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
                icon_scale = {
                    type = "range",
                    name = L["config_icon_scale"],
                    desc = L["config_icon_scale_desc"],
                    min = 0.25, max = 3, step = 0.01,
                    width = 1,
                    order = 2,
                },
                icon_alpha = {
                    type = "range",
                    name = L["config_icon_alpha"],
                    desc = L["config_icon_alpha_desc"],
                    min = 0, max = 1, step = 0.01,
                    width = 1,
                    order = 2.1,
                },
                show_auctioneer = {
                    type = "toggle",
                    name = L["config_auctioneer"],
                    desc = L["config_auctioneer_desc"],
                    order = 3,
                    hidden = function() return not Oribos:CharacterHasProfession(202) end,
                },
                show_portal = {
                    type = "toggle",
                    name = function()
                        if not IsAddOnLoaded("HandyNotes_TravelGuide") then
                            return L["config_portal"]
                        else
                            return L["config_portal"].." |cFFFF0000(*)|r"
                        end
                    end,
                    desc = L["config_portal_desc"],
                    order = 28,
                    disabled = function() return IsAddOnLoaded("HandyNotes_TravelGuide") end,
                },
                show_tpplatform = {
                    type = "toggle",
                    name = function()
                        if not IsAddOnLoaded("HandyNotes_TravelGuide") then
                            return L["config_tpplatforms"]
                        else
                            return L["config_tpplatforms"].." |cFFFF0000(*)|r"
                        end
                    end,
                    desc = L["config_tpplatforms_desc"],
                    order = 29,
                    disabled = function() return IsAddOnLoaded("HandyNotes_TravelGuide") end,
                },
                desc2 = {
                    type = "description",
                    name = L["config_travelguide_note"],
                    hidden = function()
                        return not IsAddOnLoaded("HandyNotes_TravelGuide")
                    end,
                    order = 30,
                },
                other_line = {
                    type = "header",
                    name = "",
                    order = 31,
                },
                show_onlymytrainers = {
                    type = "toggle",
                    width = "full",
                    name = L["config_onlymytrainers"],
                    desc = L["config_onlymytrainers_desc"],
                    order = 32,
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
                    order = 33,
                },
                unhide = {
                    type = "execute",
                    width = "full",
                    name = L["config_restore_nodes"],
                    desc = L["config_restore_nodes_desc"],
                    func = function()
                        for map,coords in pairs(HandyNotes_Oribos.hidden) do
                            wipe(coords)
                        end
                        Oribos:Refresh()
                        print("Covenant Sanctum: "..L["config_restore_nodes_print"])
                    end,
                    order = 34,
                },
            },
            },
        },
    },
--    SCALEALPHA = {
--        type = "group",
--        name = L["config_tab_scale_alpha"],
--        desc = L["config_scale_alpha_desc"],
--        order = 1,
--        args = {
--
--        },
--    },
    },
}

local icongroup = {
    "banker", "barber", "innkeeper", "mail", "reforge",
    "stablemaster", "trainer", "transmogrifier", "vendor", "void"
}

for i, icongroup in ipairs(icongroup) do

    config.options.args.ICONDISPLAY.args.display.args["show_"..icongroup] = {
        type = "toggle",
        name = L["config_"..icongroup],
        desc = L["config_"..icongroup.."_desc"],
        order = i+2,
    }

end

--[[
for i, icongroup in ipairs(icongroup) do

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
]]


----------------------------------------------------------------------------------------------------
-------------------------------------------DEV CONFIG TAB-------------------------------------------
----------------------------------------------------------------------------------------------------

-- Activate the developer mode with:
-- /script HandyNotes_OribosDB.global.dev = true
-- /reload

local function devmode()
    HandyNotes_Oribos.config.options.args["DEV"] = {
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
        Oribos:Refresh()
        print("Oribos refreshed")
    end

    SLASH_ORIBOS1 = "/oribos"
    SlashCmdList["ORIBOS"] = function(msg)
        InterfaceOptionsFrame_Show()
        InterfaceOptionsFrame_OpenToCategory('HandyNotes')
        LibStub('AceConfigDialog-3.0'):SelectGroup('HandyNotes', 'plugins', 'Oribos')
    end

end

HandyNotes_Oribos.devmode = devmode




----------------------------------------------------------------------------------------------------
-----------------------------------------------LOCALS-----------------------------------------------
----------------------------------------------------------------------------------------------------

local function GetMapNames(id1, id2)
    return format("%s, %s", C_Map.GetMapInfo(id1).name, C_Map.GetMapInfo(id2).name)
end

local PtoOG = L["Portal to Orgrimmar"]
local Durotar = GetMapNames(12, 1)
local PtoSW = L["Portal to Stormwind"]
local ElwynnForest = GetMapNames(13, 37)
local RingTransference = L["To Ring of Transference"]
local RingFates = L["To Ring of Fates"]
local IntoTheMaw = L["Into the Maw"]

----------------------------------------------------------------------------------------------------
----------------------------------------------DATABASE----------------------------------------------
----------------------------------------------------------------------------------------------------

local DB = {}
HandyNotes_Oribos.DB = DB

DB.points = {

[1670] = { -- Ring of Fates
    -- HALL OF SHAPES
    -- Juwe
    [34574459] = { vendor=true, npc=156733, profession=755 },
    [35204130] = { trainer=true, npc=156670, profession=755 },
    -- Engineer
    [37684297] = { vendor=true, npc=156692, profession=202 },
    [38074470] = { trainer=true, npc=156691, profession=202 },
    [38334378] = { auctioneer=true, npc=173571, profession=202 },
    -- Inscription
    [35963855] = { vendor=true, npc=156732, profession=773 },
    [36503673] = { trainer=true, npc=156685, profession=773 },
    [37193554] = { vendor=true, npc=164736, profession=773 },
    -- Alchemy
    [38873943] = { vendor=true, npc=156689, profession=171 },
    [39244037] = { trainer=true, npc=156687, profession=171 },
    -- Herbalism
    [40233828] = { trainer=true, npc=156686, profession=182 },

    [38653356] = { anvil=true, npc=156777 },
    -- Mining
    [39353297] = { trainer=true, npc=156668, profession=186 },
    -- Blacksmith
    [40473150] = { trainer=true, npc=156666, profession=164 },
    -- Skinning
    [42162811] = { trainer=true, npc=156667, profession=393 },
    -- Leatherworking
    [42292666] = { trainer=true, npc=156669, profession=165 },
    [44502653] = { vendor=true, npc=156696, profession=165 },
    -- Tailor
    [45493182] = { trainer=true, npc=156681, profession=197 },
    -- Cooking
    [46232637] = { vendor=true, npc=168353 },
    [46202560] = { trainer=true, npc=156672 }, -- , profession=185
    -- Fishing
    [46832259] = { vendor=true, npc=156690 },
    [47542360] = { trainer=true, npc=156671 }, -- , profession=356
    -- Enchanting
    [48412939] = { trainer=true, npc=156683, profession=333 },
    [47572905] = { vendor=true, npc=156694, profession=333 },

    -- HALL OF HOLDING
    -- Banker
    [59812681] = { banker=true, npc=156479 },
    [60432950] = { banker=true, npc=156479 },
    [58693031] = { banker=true, npc=156479 },
    [58102771] = { banker=true, npc=156479 },
--    65203600 "Guild Vault"

    -- THE IDYLLIA
    [62815176] = { mail=true, label=L["Mailbox"] },
    [73854906] = { mail=true, label=L["Mailbox"] },
    [67485033] = { innkeeper=true, npc=156688 },

    -- HALL OF CURIOSITIES
    [64456418] = { barber=true, npc=156735 },
    [65196756] = { vendor=true, npc=156769 },
    [64596987] = { transmogrifier=true, npc=156663 },
    [64407055] = { void=true, npc=156664 },
    [61767215] = { vendor=true, npc=169524 },
    [59257541] = { stablemaster=true, npc=156791 },
    [56787554] = { anvil=true, npc=173369 },
    [56727171] = { vendor=true, npc=173370 },

    -- THE ENCLAVE
    [47867789] = { vendor=true, npc=176067 }, -- Quartermaster
    [47577721] = { vendor=true, npc=176064 }, -- Quartermaster
    [47087695] = { vendor=true, npc=176065 }, -- Quartermaster

    [35055815] = { vendor=true, npc=164095 },
    [34445752] = { vendor=true, npc=168011 },
    [34645648] = { reforge=true, npc=164096 },

    [20835477] = { portal=true, label=PtoOG, note=Durotar, faction="Horde", quest=60151 },
    [20894567] = { portal=true, label=PtoSW, note=ElwynnForest, faction="Alliance", quest=60151 },

    [52094278] = { tpplatform=true, label=RingTransference },
    [57145040] = { tpplatform=true, label=RingTransference },
    [52095784] = { tpplatform=true, label=RingTransference },
    [47055029] = { tpplatform=true, label=RingTransference },
},

[1671] = { -- Ring of Transference
    [49525107] = { portal=true, label=IntoTheMaw },
    [49504243] = { tpplatform=true, label=RingFates },
    [55735162] = { tpplatform=true, label=RingFates },
    [49506073] = { tpplatform=true, label=RingFates },
    [43375150] = { tpplatform=true, label=RingFates },
},

[1672] = {
    [51284300] = { vendor=true, npc=167881 },
},

} -- DB ENDE