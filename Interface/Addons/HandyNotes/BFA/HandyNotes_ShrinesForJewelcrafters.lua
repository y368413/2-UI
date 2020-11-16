local ShrinesForJewelcrafters = {}
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes", false)

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HandyNotes_ShrinesForJewelcrafters = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_ShrinesForJewelcrafters", "AceEvent-3.0")
local next = next
local GameTooltip = GameTooltip
local HandyNotes = HandyNotes

local ARTIFACT_LABEL = '|cffff8000' .. ARTIFACT_POWER .. '|r'

local cache_tooltip = CreateFrame("GameTooltip", "HNBattleTreasuresTooltip")
cache_tooltip:AddFontStrings(
    cache_tooltip:CreateFontString("$parentTextLeft1", nil, "GameTooltipText"),
    cache_tooltip:CreateFontString("$parentTextRight1", nil, "GameTooltipText")
)
local name_cache = {}

local function mob_name(id)
    if not name_cache[id] then
        -- this doesn't work with just clearlines and the setowner outside of this, and I'm not sure why
        cache_tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
        cache_tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(id))
        if cache_tooltip:IsShown() then
            name_cache[id] = HNBattleTreasuresTooltipTextLeft1:GetText()
        end
    end
    return name_cache[id]
end

local default_texture, Shrine_texture
local icon_cache = {}

local trimmed_icon = function(texture)
    if not icon_cache[texture] then
        icon_cache[texture] = {
            icon = texture,
            tCoordLeft = 0.1,
            tCoordRight = 0.9,
            tCoordTop = 0.1,
            tCoordBottom = 0.9,
        }
    end
    return icon_cache[texture]
end

local atlas_texture = function(atlas, scale)
    return {
        icon = C_Texture.GetAtlasInfo(atlas).file,
            tCoordLeft = C_Texture.GetAtlasInfo(atlas).leftTexCoord,
            tCoordRight = C_Texture.GetAtlasInfo(atlas).rightTexCoord,
            tCoordTop = C_Texture.GetAtlasInfo(atlas).topTexCoord,
            tCoordBottom = C_Texture.GetAtlasInfo(atlas).bottomTexCoord,
        scale = scale or 0.85,
    }
end

local function work_out_label(point)
    local fallback
    if point.label then
        return point.label
    end
    return fallback or UNKNOWN
end

local function work_out_texture(point)
    if point.atlas then
        if not icon_cache[point.atlas] then
            icon_cache[point.atlas] = atlas_texture(point.atlas, point.scale)
        end
        return icon_cache[point.atlas]
    end
    if point.Shrine then
        return {
            icon = point.pathto,
            tCoordLeft = 0,
            tCoordRight = 1,
            tCoordTop = 0,
            tCoordBottom = 1,
            scale = 2.2,
        }
    end
    if not default_texture then
        default_texture = atlas_texture("Garr_TreasureIcon", 2.6)
        return default_texture
    end
    return default_texture
end

local get_point_info = function(point)
    if point then
        local label = work_out_label(point)
        local icon = work_out_texture(point)
        local category = "Shrine"
        -- if point.timeRift then
        --     category = "timeRift"
        -- end -- in case to add something else
        return label, icon, category, point.quest, point.faction, point.scale, point.alpha or 1
    end
end
local get_point_info_by_coord = function(uiMapID, coord)
    return get_point_info(ShrinesForJewelcrafters_points[uiMapID] and ShrinesForJewelcrafters_points[uiMapID][coord])
end

local function handle_tooltip(tooltip, point)
    if point then
        -- major:
        tooltip:AddLine(work_out_label(point))
        if point.note then
            tooltip:AddLine(point.note, nil, nil, nil, true)
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end
local handle_tooltip_by_coord = function(tooltip, uiMapID, coord)
    return handle_tooltip(tooltip, ShrinesForJewelcrafters_points[uiMapID] and ShrinesForJewelcrafters_points[uiMapID][coord])
end

---------------------------------------------------------
-- Plugin Handlers to HandyNotes
local HLHandler = {}
local info = {}

function HLHandler:OnEnter(uiMapID, coord)
    local tooltip = GameTooltip
    if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    handle_tooltip_by_coord(tooltip, uiMapID, coord)
end

local function createWaypointBulk(button, uiMapID)
    if TomTom then
        for coord, v in pairs(ShrinesForJewelcrafters_points[uiMapID]) do
            local x, y = HandyNotes:getXY(coord)
            TomTom:AddWaypoint(uiMapID, x, y, {
                title = get_point_info_by_coord(uiMapID, coord),
                persistent = nil,
                minimap = true,
                world = true
            })
        end
    end
end

local function createWaypoint(button, uiMapID, coord)
    if TomTom then
        local x, y = HandyNotes:getXY(coord)
        TomTom:AddWaypoint(uiMapID, x, y, {
            title = get_point_info_by_coord(uiMapID, coord),
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

local function hideNode(button, uiMapID, coord)
    ShrinesForJewelcrafters_hidden[uiMapID][coord] = true
    HandyNotes_ShrinesForJewelcrafters:Refresh()
end

local function closeAllDropdowns()
    CloseDropDownMenus(1)
end

do
    local currentZone, currentCoord
    local function generateMenu(button, level)
        if (not level) then return end
        wipe(info)
        if (level == 1) then
            -- Create the title of the menu
            info.isTitle      = 1
            info.text         = "HandyNotes - " .. "HandyNotes_ShrinesForJewelcrafters"
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)
            wipe(info)

            if TomTom then
                -- Waypoint menu item
                info.text = L["Create waypoint"]
                info.notCheckable = 1
                info.func = createWaypoint
                info.arg1 = currentZone
                info.arg2 = currentCoord
                UIDropDownMenu_AddButton(info, level)
                wipe(info)
            end

            -- Hide menu item
            info.text         = L["Hide node"]
            info.notCheckable = 1
            info.func         = hideNode
            info.arg1         = currentZone
            info.arg2         = currentCoord
            UIDropDownMenu_AddButton(info, level)
            wipe(info)

            -- Close menu item
            info.text         = L["Close"]
            info.func         = closeAllDropdowns
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)
            wipe(info)
        end
    end
    local HL_Dropdown = CreateFrame("Frame", "HandyNotes_ShrinesForJewelcraftersDropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function HLHandler:OnClick(button, down, uiMapID, coord)
        currentZone = uiMapID
        currentCoord = coord
        -- given we're in a click handler, this really *should* exist, but just in case...
        local point = ShrinesForJewelcrafters_points[currentZone] and ShrinesForJewelcrafters_points[currentZone][currentCoord]
        if button == "RightButton" and not down then
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        end
    end
end

function HLHandler:OnLeave(uiMapID, coord)
    GameTooltip:Hide()
    ShoppingTooltip1:Hide()
end

do
    -- This is a custom iterator we use to iterate over every node in a given zone
    local currentZone, isMinimap
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do -- Have we reached the end of this zone?
            if value and ShrinesForJewelcrafters_should_show_point(state, value, currentZone, isMinimap) then
                local label, icon, _, _, _, scale, alpha = get_point_info(value)
                scale = (scale or 1) * (icon and icon.scale or 1) * ShrinesForJewelcrafters_db.icon_scale
                return state, nil, icon, scale, ShrinesForJewelcrafters_db.icon_alpha * alpha
            end
            state, value = next(t, state) -- Get next data
        end
        return nil, nil, nil, nil
    end
    local function UnitHasBuff(unit, spellid)
        local buffname = GetSpellInfo(spellid)
        for i = 1, 40 do
            local name = UnitBuff(unit, i)
            if not name then
                -- reached the end, probably
                return
            end
            if buffname == name then
                return UnitBuff(unit, i)
            end
        end
    end
    function HLHandler:GetNodes2(uiMapID, minimap)
        currentZone = uiMapID
        isMinimap = minimap
        if minimap and ShrinesForJewelcrafters_map_spellids[uiMapID] then
            if ShrinesForJewelcrafters_map_spellids[mapFile] == true then
                return iter
            end
            if UnitHasBuff("player", ShrinesForJewelcrafters_map_spellids[mapFile]) then
                return iter
            end
        end
        return iter, ShrinesForJewelcrafters_points[uiMapID], nil
    end
end

---------------------------------------------------------
-- Addon initialization, enabling and disabling

function HandyNotes_ShrinesForJewelcrafters:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_ShrinesForJewelcraftersDB", ShrinesForJewelcrafters_defaults)
    ShrinesForJewelcrafters_db = self.db.profile
    ShrinesForJewelcrafters_hidden = self.db.char.hidden
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB("HandyNotes_ShrinesForJewelcrafters", HLHandler, ShrinesForJewelcrafters_options)

    -- watch for LOOT_CLOSED
    self:RegisterEvent("LOOT_CLOSED", "Refresh")
    self:RegisterEvent("ZONE_CHANGED_INDOORS", "Refresh")
end

function HandyNotes_ShrinesForJewelcrafters:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_ShrinesForJewelcrafters")
end


ShrinesForJewelcrafters_defaults = {
    profile = {
        show_on_world = true,
        show_on_minimap = true,
        show_Shrine = true,
        repeatable = true,
        icon_scale = 0.6,
        icon_alpha = 1.0,
    },
    char = {
        hidden = {
            ['*'] = {},
        },
    },
}

ShrinesForJewelcrafters_options = {
    type = "group",
    name = "ShrinesForJewelcrafters",
    get = function(info) return ShrinesForJewelcrafters_db[info[#info]] end,
    set = function(info, v)
        ShrinesForJewelcrafters_db[info[#info]] = v
        HandyNotes_ShrinesForJewelcrafters:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_ShrinesForJewelcrafters")
    end,
    args = {
        icon = {
            type = "group",
            name = L["Icon settings"],
            inline = true,
            args = {
                desc = {
                    name = L["These settings control the look of the icon."],
                    type = "description",
                    order = 0,
                },
                icon_scale = {
                    type = "range",
                    name = L["Icon Scale"],
                    desc = L["The scale of the icons"],
                    min = 0.25, max = 2, step = 0.01,
                    order = 10,
                },
                icon_alpha = {
                    type = "range",
                    name = L["Icon Alpha"],
                    desc = L["The alpha transparency of the icons"],
                    min = 0, max = 1, step = 0.01,
                    order = 20,
                },
                show_on_world = {
                    type = "toggle",
                    name = L["World Map"],
                    desc = L["Show icons on world map"],
                    order = 30,
                },
                show_on_minimap = {
                    type = "toggle",
                    name = L["Minimap"],
                    desc = L["Show icons on the minimap"],
                    order = 40,
                },
            },
        },
        display = {
            type = "group",
            name = L["What to display"],
            inline = true,
            args = {
                show_Shrine = {
                    type = "toggle",
                    name = L["Show Shrines"],
                    desc = L["Show Shrines which Jewelercrafters can use to create gems"],
                    order = 20,
                },
                unhide = {
                    type = "execute",
                    name = L["Reset hidden nodes"],
                    desc = L["Show all nodes that you manually hid by right-clicking on them and choosing \"hide\"."],
                    func = function()
                        for map,coords in pairs(ShrinesForJewelcrafters_hidden) do
                            wipe(coords)
                        end
                        HandyNotes_ShrinesForJewelcrafters:Refresh()
                    end,
                    order = 30,
                },
            },
        },
    },
}

local player_faction = UnitFactionGroup("player")
local player_name = UnitName("player")
ShrinesForJewelcrafters_should_show_point = function(coord, point, currentZone, isMinimap)
    if isMinimap and not ShrinesForJewelcrafters_db.show_on_minimap and not point.minimap then
        return false
    elseif not isMinimap and not ShrinesForJewelcrafters_db.show_on_world then
        return false
    end
    if ShrinesForJewelcrafters_hidden[currentZone] and ShrinesForJewelcrafters_hidden[currentZone][coord] then
        return false
    end
    if ShrinesForJewelcrafters_outdoors_only and IsIndoors() then
        return false
    end
    if point.faction and point.faction ~= player_faction then
        return false
    end
    if point.Shrine and not ShrinesForJewelcrafters_db.show_Shrine then
        return false
    end
    if point.hide_before and not ShrinesForJewelcrafters_db.upcoming then
        return false
    end
    return true
end


local path_meta = {__index = {
    label = "Path to treasure",
    atlas = "map-icon-SuramarDoor.tga",
    path = true,
    scale = 1.1,
}}

ShrinesForJewelcrafters_map_spellids = {
    -- [862] = 0, -- Zuldazar
    -- [863] = 0, -- Nazmir
    -- [864] = 0, -- Vol'dun
    -- [895] = 0, -- Tiragarde Sound
    -- [896] = 0, -- Drustvar
    -- [942] = 0, -- Stormsong Valley
}

ShrinesForJewelcrafters_points = {
    [862] = { -- Zuldazar
        [43146435] = {
            ["label"] = L["Shrine of Nature"],
            ["cont"] = true,
            Shrine = true,
            ["note"] = L["Laribole"], -- green
            ["pathto"] = "Interface\\Icons\\INV_Jewelcrafting_80_Gem02_Green",
        },
    },

    [863] = { -- Nazmir
        [61323724] = {
            ["label"] = L["Shrine of the Dawning"],
            ["cont"] = true,
            Shrine = true,
            ["note"] = L["Scarlet Diamond"], -- red
            ["pathto"] = "Interface\\Icons\\INV_Jewelcrafting_80_Gem02_Red",
        },
    },

    [864] = { -- Vol'dun
        [44183805] = {
            ["label"] = L["Shrine of the Sands"],
            ["cont"] = true,
            Shrine = true,
            ["note"] = L["Amberblaze"], -- orange
            ["pathto"] = "Interface\\Icons\\INV_Jewelcrafting_80_Gem02_Orange",
        },
    },

    [895] = { -- Tiragarde Sound
        [46362345] = {
            ["label"] = L["Shrine of the Sea"],
            ["cont"] = true,
            Shrine = true,
            ["note"] = L["Royal Quartz"], -- blue
            ["pathto"] = "Interface\\Icons\\INV_Jewelcrafting_80_Gem02_Blue",
        },
    },

    [896] = { -- Drustvar
        [34133546] = {
            ["label"] = L["Shrine of the Eventide"],
            ["cont"] = true,
            Shrine = true,
            ["note"] = L["Tidal Amethyst"], -- purple
            ["pathto"] = "Interface\\Icons\\INV_Jewelcrafting_80_Gem02_Purple",
        },
    },

    [942] = { -- Stormsong Valley
        [60705851] = {
            ["label"] = L["Shrine of Storms"],
            ["cont"] = true,
            Shrine = true,
            ["note"] = L["Owlseye"], -- yellow
            ["pathto"] = "Interface\\Icons\\INV_Jewelcrafting_80_Gem02_Yellow",
        },
    },

    [1183] = { -- Thornheart
    },

    [1161] = { -- Boralus
    },

    [1165] = { -- Dazar'alor
    },
}
