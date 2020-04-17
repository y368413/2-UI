local HandyNotes_BFA_Jelly = {}

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HL = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_BFA_Jelly", "AceEvent-3.0")
local next = next
local GameTooltip = GameTooltip
local HandyNotes = HandyNotes
local DEFAULT_LABEL = "Jelly"

local icon_cache = {}
local function poi_texture(poi)
    if not icon_cache[poi] then
        local left, right, top, bottom = GetPOITextureCoords(poi)
        icon_cache[poi] = {
            icon = [[Interface\Minimap\POIIcons]],
            tCoordLeft = left,
            tCoordRight = right,
            tCoordTop = top,
            tCoordBottom = bottom,
            --scale = 2,
            r = 1, g = 1, b = 1,
        }
    end
    return icon_cache[poi]
end
local function atlas_texture(atlas, scale)
    if not icon_cache[atlas..scale] then
        local texture, _, _, left, right, top, bottom = GetAtlasInfo(atlas)
        icon_cache[atlas..scale] = {
            icon = texture,
            tCoordLeft = left,
            tCoordRight = right,
            tCoordTop = top,
            tCoordBottom = bottom,
            scale = scale or 1,
            r = 1, g = 1, b = 0,
        }
    end
    return icon_cache[atlas..scale]
end

local function work_out_texture(point,mm)
    if point.atlas then
        return atlas_texture(point.atlas)
    end
    if point.poi then
        return poi_texture(point.poi)
    end
    if point.npc then
        return atlas_texture("DungeonSkull", 1.5)
    end
    
if (mm) then
    return atlas_texture("PartyMember",1.0)
  else
    return atlas_texture("PartyMember",1.0)
  end
    
    --return atlas_texture("PlayerControlled")
    --return atlas_texture("MonsterFriend")
end

local get_point_info = function(point,mm)
    if point then
        return point.label or DEFAULT_LABEL, work_out_texture(point,mm), point.scale
    end
end
local get_point_info_by_coord = function(uiMapID, coord)
    return get_point_info(HandyNotes_BFA_Jelly.points[uiMapID] and HandyNotes_BFA_Jelly.points[uiMapID][coord])
end

local function handle_tooltip(tooltip, point)
    if point then
        tooltip:AddLine(point.label or DEFAULT_LABEL)
        if point.quest and not IsQuestFlaggedCompleted(point.quest) then
            tooltip:AddLine(NEED, 1, 0, 0)
        end
        if point.note then
            tooltip:AddLine(point.note, nil, nil, nil, true)
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end
local handle_tooltip_by_coord = function(tooltip, uiMapID, coord)
    return handle_tooltip(tooltip, HandyNotes_BFA_Jelly.points[uiMapID] and HandyNotes_BFA_Jelly.points[uiMapID][coord])
end

---------------------------------------------------------
-- Plugin Handlers to HandyNotes
local HLHandler = {}
local info = {}

function HLHandler:OnEnter(uiMapID, coord)
    local tooltip = GameTooltip
    if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    handle_tooltip_by_coord(tooltip, uiMapID, coord)
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
    HandyNotes_BFA_Jelly.hidden[uiMapID][coord] = true
    HL:Refresh()
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
            info.text         = "HandyNotes_BFA_Jelly"
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)
            wipe(info)

            if TomTom then
                -- Waypoint menu item
                info.text = "Create waypoint"
                info.notCheckable = 1
                info.func = createWaypoint
                info.arg1 = currentZone
                info.arg2 = currentCoord
                UIDropDownMenu_AddButton(info, level)
                wipe(info)
            end

            -- Hide menu item
            info.text         = "Hide node"
            info.notCheckable = 1
            info.func         = hideNode
            info.arg1         = currentZone
            info.arg2         = currentCoord
            UIDropDownMenu_AddButton(info, level)
            wipe(info)

            -- Close menu item
            info.text         = "Close"
            info.func         = closeAllDropdowns
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)
            wipe(info)
        end
    end
    local HL_Dropdown = CreateFrame("Frame", "HandyNotes_BFA_JellyDropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function HLHandler:OnClick(button, down, uiMapID, coord)
        if button == "RightButton" and not down then
            currentZone = uiMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        end
    end
end

function HLHandler:OnLeave(uiMapID, coord)
    GameTooltip:Hide()
end

do
    local currentZone, isminimap
    -- This is a custom iterator we use to iterate over every node in a given zone
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do -- Have we reached the end of this zone?
            if value and not HandyNotes_BFA_Jelly.hidden[currentZone][state] then
                local label, icon, scale = get_point_info(value,isminimap)
                scale = (scale or 1) * (icon and icon.scale or 1) * HandyNotes_BFA_Jelly.db.icon_scale
                return state, nil, icon, scale, HandyNotes_BFA_Jelly.db.icon_alpha
            end
            state, value = next(t, state) -- Get next data
        end
        
        return nil, nil, nil, nil
    end
    function HLHandler:GetNodes2(uiMapID, minimap)
        isminimap = minimap
        --print( (isminimap == true and "For Minimap" or "For Map") )
        currentZone = uiMapID
        return iter, HandyNotes_BFA_Jelly.points[uiMapID], nil
    end
end

---------------------------------------------------------
-- Addon initialization, enabling and disabling

function HL:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_BFA_JellyDB", HandyNotes_BFA_Jelly.defaults)
    HandyNotes_BFA_Jelly.db = self.db.profile
    HandyNotes_BFA_Jelly.hidden = self.db.char.hidden
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB("HandyNotes_BFA_Jelly", HLHandler, HandyNotes_BFA_Jelly.options)

    -- watch for LOOT_CLOSED
    self:RegisterEvent("LOOT_CLOSED")
end

function HL:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_BFA_Jelly")
end

function HL:LOOT_CLOSED()
    self:Refresh()
end

HandyNotes_BFA_Jelly.defaults = {
    profile = {
        -- found = false,
        icon_scale = 1.0,
        icon_alpha = 1.0,
        icon_item = true,
    },
    char = {
        hidden = {
            ['*'] = {},
        },
    },
}

HandyNotes_BFA_Jelly.options = {
    type = "group",
    name = "BFA_Jelly",
    get = function(info) return HandyNotes_BFA_Jelly.db[info[#info]] end,
    set = function(info, v)
        HandyNotes_BFA_Jelly.db[info[#info]] = v
        HL:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_BFA_Jelly")
    end,
    args = {
        icon = {
            type = "group",
            name = "Icon settings",
            inline = true,
            args = {
                desc = {
                    name = "These settings control the look and feel of the icon.",
                    type = "description",
                    order = 0,
                },
                icon_scale = {
                    type = "range",
                    name = "Icon Scale",
                    desc = "The scale of the icons",
                    min = 0.25, max = 2, step = 0.01,
                    order = 20,
                },
                icon_alpha = {
                    type = "range",
                    name = "Icon Alpha",
                    desc = "The alpha transparency of the icons",
                    min = 0, max = 1, step = 0.01,
                    order = 30,
                },
            },
        },
        display = {
            type = "group",
            name = "What to display",
            inline = true,
            args = {
                -- found = {
                --     type = "toggle",
                --     name = "Show found",
                --     desc = "Show waypoints for items you've already found?",
                --     order = 20,
                -- },
                unhide = {
                    type = "execute",
                    name = "Reset hidden nodes",
                    desc = "Show all nodes that you manually hid by right-clicking on them and choosing \"hide\".",
                    func = function()
                        for map,coords in pairs(HandyNotes_BFA_Jelly.hidden) do
                            wipe(coords)
                        end
                        HL:Refresh()
                    end,
                    order = 50,
                },
            },
        },
    },
}

local player_faction = UnitFactionGroup("player")
HandyNotes_BFA_Jelly.should_show_point = function(coord, point, currentZone, currentLevel)
    if point.level and point.level ~= currentLevel then
        return false
    end
    if HandyNotes_BFA_Jelly.hidden[currentZone] and HandyNotes_BFA_Jelly.hidden[currentZone][coord] then
        return false
    end
    if point.junk and not HandyNotes_BFA_Jelly.db.show_junk then
        return false
    end
    if point.faction and point.faction ~= player_faction then
        return false
    end
    if (not HandyNotes_BFA_Jelly.db.found) then
        if point.quest and IsQuestFlaggedCompleted(point.quest) then
            return false
        end
        if point.achievement then
            local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuildAch, wasEarnedByMe, earnedBy = GetAchievementInfo(point.achievement)
            if completed then
                return false
            end
            if point.criteria then
                local description, type, completed, quantity, requiredQuantity, characterName, flags, assetID, quantityString, criteriaID = GetAchievementCriteriaInfoByID(point.achievement, point.criteria)
                if completed then
                    return false
                end
            end
        end
        if point.follower and C_Garrison.IsFollowerCollected(point.follower) then
            return false
        end
        -- This is actually super-targeted at Basten, who is repeatable daily and drops a toy
        -- Might want to generalize at some point...
        if point.toy and point.item and point.repeatable and select(4, C_ToyBox.GetToyInfo(point.item)) then
            return false
        end
    end
    if (not HandyNotes_BFA_Jelly.db.repeatable) and point.repeatable then
        return false
    end
    if point.npc and not point.follower and not HandyNotes_BFA_Jelly.db.show_npcs then
        return false
    end
    return true
end


HandyNotes_BFA_Jelly.points = {
    --[[ structure:
    [mapFile] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            label=[string], -- label: text that'll be the label, optional
            item=[id], -- itemid
            quest=[id], -- will be checked, for whether character already has it
            achievement=[id], -- will be shown in the tooltip
            junk=[bool], -- doesn't count for achievement
            npc=[id], -- related npc id, used to display names in tooltip
            note=[string], -- some text which might be helpful
        },
    },
    --]]
    [942] = { -- Stormsong Valley
      -- Many things from NaThuRe's comment on wowhead
      -- http://www.wowhead.com/item=138258/reins-of-the-long-forgotten-hippogryph#comments:id=2400520
      
      [33127166] = {},
      [31717454] = {},
      [28227487] = {},
      [63242847] = {},
      [61402233] = {},
      [58853083] = {},
      [55103126] = {},
      [54033128] = {},
      [55782794] = {},
      [56063713] = {},
      [53304319] = {},
      [49853674] = {},
      [56282895] = {},
      [58582841] = {},
      [63272224] = {},
      [61455592] = {},
      [55234102] = {},
      [56632036] = {},
      [56401877] = {},
      [47392542] = {},
      [37333729] = {},
      [35713135] = {},
      [46554198] = {},
      [66936351] = {},
      [64245243] = {},
      [62084611] = {},
      [58272138] = {},
      [56142606] = {},
      [52533913] = {},
      [63135140] = {},
      [58305429] = {},
      [54724845] = {},
      [56215878] = {},
      [66437037] = {},
      [69717598] = {},
      [71326724] = {},
      [66005821] = {},
      [68255541] = {},
      [61475192] = {},
      [64013728] = {},
      [62502271] = {},
      [53912773] = {},
      [52372708] = {},
      [49263559] = {},
      [58082745] = {},
      [63602567] = {},
      [31466014] = {},
      [60522915] = {},
      [63602823] = {},
      [57862850] = {},
      [57583001] = {},
      [55243846] = {},
      [53344312] = {},
      [44634927] = {},
      [44215094] = {},
      [40394735] = {},
      [36774769] = {},
      [35555237] = {},
      [35116445] = {},
      [33246787] = {},
      [33397199] = {},
      [29827619] = {},
      [25516716] = {},
      [56253051] = {},
      [53043602] = {},
      [40924223] = {},
      [38816351] = {},
      [45886448] = {},
      [72137418] = {},
      [67605657] = {},
      [63612818] = {},
      [63861965] = {},
      [46404761] = {},
      [41104632] = {},
      [31313167] = {},
      [35752942] = {},
      [35803691] = {},
      [37975124] = {},
      [33605317] = {},
      [27646434] = {},
      [28016934] = {},
      [27507297] = {},
      [62767516] = {},
      [71197187] = {},
      [70086658] = {},
      [67315390] = {},
      [63133135] = {},
      [66974071] = {},
      [55072764] = {},
      [44783916] = {},
      [42565113] = {},
      [32065961] = {},
      [30926305] = {},
      [49127533] = {},
      [52337559] = {},
      [63137659] = {},
      [72167529] = {},
      [56027562] = {},
      [56307615] = {},
      [64067522] = {},
      [60915447] = {},
      [59135622] = {},
      [47025596] = {},
      [48955481] = {},
      [49116311] = {},
      [44006535] = {},
      [37086278] = {},
      [36415979] = {},
      [26426547] = {},
      [26977160] = {},
      [26257732] = {},
      [53217669] = {},
      [53577347] = {},
      [52207409] = {},
      [63467366] = {},
      [68106829] = {},
      [61182941] = {},
      [60061955] = {},
      [55112090] = {},
      [59752354] = {},
      [57442781] = {},
      [45172768] = {},
      [46712279] = {},
      [47622934] = {},
      [44274148] = {},
      [56003718] = {},
      [37153881] = {},
      [35213214] = {},
      [32993278] = {},
      [30596036] = {},
      [32135798] = {},
      [33506332] = {},
      [38804415] = {},
      [41114635] = {},
      [41684023] = {},
      [43414500] = {},
      [43883437] = {},
      [44872625] = {},
      [45294212] = {},
      [48563006] = {},
      [55342560] = {},
      [56594228] = {},
      [57522229] = {},
      [57732432] = {},
      [57954974] = {},
      [58386143] = {},
      [59713159] = {},
      [60071953] = {},
      [60082151] = {},
      [60733285] = {},
      [61441736] = {},
      [61621868] = {},
      [61672937] = {},
      [62143964] = {},
      [63242993] = {},
      [63933641] = {},
      [64272900] = {},
      [64453103] = {},
      [66893455] = {},
      [69146686] = {},
      [71976668] = {},
      [32306380] = {},
      [27707430] = {},
      [37706410] = {},
      [60907680] = {},
      [60007320] = {},
      [50705020] = {},
      [70905400] = {},
      [50207580] = {},
      [47206690] = {},
      [57207700] = {},
      [50907940] = {},
      [24807100] = {},
      [65904510] = {},
      [64903370] = {},
      [66704550] = {},
      [50103930] = {},
      [58705820] = {},
      [53805130] = {},
      [45805060] = {},
      [50405410] = {},
      [62307430] = {},
      [65803650] = {},
      [58101950] = {},
      [63401880] = {},
      [64802130] = {},
      [66805870] = {},
      [63203370] = {},
      [47503430] = {},
      [50405410] = {},
      [58502310] = {},
      [42304090] = {},
      [60605670] = {},
      [50606710] = {},
      [40306160] = {},
      [27707120] = {},
      [42405440] = {},
      [47605090] = {},
      [49404980] = {},
      [67003930] = {},
      [49704880] = {},
      [59205320] = {},
      [52905350] = {},
    },
    
}
--[862] = { -- Zuldazar
--[1165] = { -- Dazar'alor
--[863] = { -- Nazmir
--[864] = { -- Vol'dun
--[895] = { -- Tiragarde Sound
--[896] = { -- Drustvar
--[942] = { -- Stormsong Valley