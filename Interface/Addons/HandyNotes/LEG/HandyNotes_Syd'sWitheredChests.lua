---- Addon declaration -- ËÕÀ­Âê¿Ý·¨ÕßÑµÁ·±¦Ïä

HandyNotes_WitheredChests = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_WitheredChests", "AceEvent-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")

---- Options database --

local db

local defaults = {
    profile = {
        completed = false,
        iconScale = 1.5,
        iconAlpha = 1.0,
    }
}

local options = {
    type = "group",
    name = "Withered Chests",
    desc = "Shows location of chests in the Withered Army Training scenario.",
    get = function(info) return db[info[#info]] end,
    set = function(info, v)
        db[info[#info]] = v
        HandyNotes_WitheredChests:SendMessage("HandyNotes_NotifyUpdate", "Withered Chests")
    end,
    args = {
        desc = {
            name = "Control the appearance of the icons.",
            type = "description",
            order = 1,
        },
        completed = {
            name = "Show Completed",
            desc = "Show icons for chests you have already looted.",
            type = "toggle",
            width = "full",
            arg = "completed",
            order = 2,
        },
        iconScale = {
            type = "range",
            name = "Icon Scale",
            desc = "Size of the icons.",
            min = 0.25, max = 2, step = 0.01,
            arg = "iconScale",
            order = 3,
        },
        iconAlpha = {
            type = "range",
            name = "Icon Alpha",
            desc = "Transparency of the icons.",
            min = 0, max = 1, step = 0.01,
            arg = "iconAlpha",
            order = 4,
        }
    }
}

--
-- Icons
--

local icons = {
    ["Boss"]                      = [[Interface\MINIMAP\Minimap_skull_elite]],
    ["Mobs"]                      = [[Interface\MINIMAP\Minimap_skull_normal]],
    ["Treasure Chest"]            = [[Interface\MINIMAP\Minimap_chest_normal]],
    ["Glimmering Treasure Chest"] = [[Interface\MINIMAP\Minimap_chest_elite]],
    ["Locked Door"]               = [[Interface\MINIMAP\Suramar_Door_Icon]]
}

--
-- Map nodes
--

local zone = "FalanaarTunnelsScenario"
--local zone = "FalanaarTunnels"
local levelOffset = 40 -- 31 for testing in the real tunnels

local nodes = {
    [zone] = {
        -- Level 1: Temple of Fal'adora
        [1 + levelOffset] = {
            [75702890] = { title="Treasure Chest", quest=43120, item=139018, desc="Encourages your withered troops to more efficiently focus their attacks on enemies." },
            [29304090] = { title="Treasure Chest", quest=43149, item=139010, desc="Increase the health of your withered troops by 25%." },
            [32505220] = { title="Treasure Chest", quest=43140, item=140778, desc="Enterprising accountants from Falanaar developed a way to access their banks in remote locations. \n\nNote: Take the stairs down." },
            [32607290] = { title="Glimmering Treasure Chest", quest=43146, item=140451, desc="One of the members of your withered army can wear the helm, causing it to become a powerful Withered Mana-Rager." },
            [40901390] = { title="Glimmering Treasure Chest", quest=43071, item=139011, desc="One of the members of your withered army can wear the helm, causing it to become a powerful Withered Berserker." },
            [43102140] = { title="Boss", name="Lapilia", tip="Move from your Withered when you have a glowing circle around you." },
	    [57004094] = { title="Locked Door", notes="Requires 2 Berserkers." },
	    [45822958] = { title="Locked Door", notes="Requires 10 Withered." },
	    [71083340] = { title="Mobs", notes="Several packs of Volatile Wraith; one pack has three. Beware!"}
        },
        -- Level 2: Falanaar Tunnels
        [2 + levelOffset] = {
            [51403010] = { title="Treasure Chest", quest=43111, item=139017, desc="Reduces the chance that your withered troops will run away when injured." },
            [67405200] = { title="Treasure Chest", quest=43144, item=141296, desc="Toy: Creates a floating Mana Basin for 2 min. Party and raid members can use the basin to acquire Mana Catalyst increasing the regen of conjured foods and magical foods purchased in Suramar. (1 Hour Cooldown)" },
            [60107220] = { title="Treasure Chest", quest=43148, item=140448, desc="Increase the damage of your withered troops by 25%." },
            [45914641] = { title="Treasure Chest", quest=43143, item=141314, desc="Artifact Power." },
            [49308030] = { title="Treasure Chest", quest=43141, item=136914, desc="Teaches you how to summon this companion." },
            [36103190] = { title="Glimmering Treasure Chest", quest=43135, item=139028, desc="One of the members of your withered army can wear the disc, granting it powerful magical abilities." },
            [44205340] = { title="Glimmering Treasure Chest", quest=43134, item=139027, desc="One of the members of your withered army can wear the lenses, allowing it to see hidden treasure chests." },
            [62206180] = { title="Glimmering Treasure Chest", quest=43128, item=139019, desc="One of the members of your withered army can wear the helm, causing it to become a powerful Withered Mana-Rager." },
            [32206520] = { title="Glimmering Treasure Chest", quest=43145, item=140450, desc="One of the members of your withered army can wear the helm, causing it to become a powerful Withered Berserker." },
            [62308940] = { title="Treasure Chest", quest=43142, item=141313, desc="Artifact Power." },
            [65205050] = { title="Boss", name="Brood Guardian Phyx", tip="Interrupt Cleaving Claws, Brood Expansion spawns many small spiders." },
            [60005830] = { title="Boss", name="Volatile Wraithlord", tip="Identical to Volatile Wraith, just bigger and badder!" },
            [57807350] = { title="Boss", name="Furog the Elfbreaker", tip="Pull to tunnel you just cleared. Non-interruptible so stuns or fear will help." },
            [53309080] = { title="Boss", name="Psilych", tip="Avoid the webs it casts on the floor." },
            [52342782] = { title="Boss", name="Leystalker Dro", tip="This boss can appear after this point! Kill quickly, stuns and fears help, kite when he charges around." },
	    [57457786] = { title="Mobs", notes="Small spiders continuously spawn and run down the stairs until you reach Psilych."},
	    [59654677] = { title="Locked Door", notes="Requires 10 Withered." },
	    [38153325] = { title="Locked Door", notes="Requires 10 Withered, always 3 Withered inside." },
	    [56955348] = { title="Locked Door", notes="Requires 10 Withered." },
	    [44895508] = { title="Locked Door", notes="Requires Leystalker Dro's key." },
	    [42837136] = { title="Locked Door", notes="Locked until Fal'dorei Silkwitch is killed."}
        }
    }
}

--
-- HandyNotes Plugin Handler
--

local HNWCHandler = {}
local level
local TREASURE_CHEST_WITHERED = 5
local GLIMMERING_CHEST_WITHERED = 10

local function iter(t, prestate)
    if not t then return nil end
    local state, value = next(t, prestate)
    -- Iterate over all values in the zone
    while state do
	if value and (db.completed or not value.quest or 
	    not (C_QuestLog.IsQuestFlaggedCompleted(value.quest) or value.completed))
	    then
	    return state, nil, icons[value.title], 
	    db.iconScale, db.iconAlpha
	end
	state, value = next(t, state)
    end
    return nil
end

function HNWCHandler:GetNodes(mapFile, minimap, dungeonLevel)
    level = dungeonLevel
    --print(mapFile .. ", level: " .. level);

    -- Only iterate when it's the scenario
    if mapFile == zone then
	return iter, nodes[mapFile][level], nil
    else
	return iter, nil, nil
    end
end

-- Create tooltip
function HNWCHandler:OnEnter(mapFile, coord)
    local node = nodes[mapFile][level][coord]
    local tooltip = (self:GetParent() == WorldMapButton) and WorldMapTooltip or 
	GameTooltip
    local r, g, b = 1, 1, 1

    if node then
	if self:GetCenter() > UIParent:GetCenter() then
	    tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
	    tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	if node.title == "Boss" then
	    tooltip:AddLine(node.title, r, g, b)
	    tooltip:AddLine(node.name)
	    tooltip:AddLine("Tip: " .. node.tip, r, g, b, true)
	elseif node.title == "Mobs" then
	    tooltip:AddLine(node.title)
	    tooltip:AddLine(node.notes, r, g, b, true)
	elseif node.title == "Locked Door" then
	    tooltip:AddLine(node.title, r, g, b)
	    tooltip:AddLine(node.notes)
	else
	    local _, itemLink, _, _, _, _, _, _, _, _ = GetItemInfo(node.item)
	    tooltip:AddLine(node.title, r, g, b)
	    num = (node.title == "Treasure Chest") and 
		TREASURE_CHEST_WITHERED or GLIMMERING_CHEST_WITHERED
	    tooltip:AddLine("Requires " .. num .. " Withered.")
	    if itemLink then
		tooltip:AddLine(" ")
		tooltip:AddLine("Contents:")
		tooltip:AddLine(itemLink)
		tooltip:AddLine(node.desc, r, g, b, true)
	    end
	    tooltip:Show()
	end
	tooltip:Show()
    end -- if node
end

-- Hide tooltip
function HNWCHandler:OnLeave(mapFile, coord)
    if self:GetParent() == WorldMapButton then
        WorldMapTooltip:Hide()
    else
        GameTooltip:Hide()
    end
end

-- Create context menu
--[[
function HNWCHandler:OnClick(button, down, mapFile, coord)
end
--]]

--
-- AceAddon methods
--

function HandyNotes_WitheredChests:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_WitheredChestsDB", defaults)
    db = self.db.profile
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB("Withered Chests", HNWCHandler, options)
end

--[[
function HandyNotes_WitheredChests:OnEnable()
end

function HandyNotes_WitheredChests:OnDisable()
end
--]]

--
-- Chest sent back
--

-- Check if a chest is close enough to have been sent back
local function findClosestChest(mapFile, level, posX, posY)
    posX = math.floor(posX * 10000)
    posY = math.floor(posY * 10000)

    for coord in pairs(nodes[mapFile][level]) do
	local nodeX = math.floor(coord / 10000)
	local nodeY = coord % 10000
	local diffX = posX - nodeX
	local diffY = posY - nodeY
	diffX = (diffX < 0) and -diffX or diffX
	diffY = (diffY < 0) and -diffY or diffY

	local node = nodes[mapFile][level][coord]
	if (node.title == "Treasure Chest" or node.title == 
	    "Glimmering Treasure Chest") and diffX < 100 and diffY < 100 then
	    return coord
	end
    end
    return nil
end

hooksecurefunc("SelectGossipOption", function ()
    local mapID = C_Map.GetBestMapForUnit("player")
	WorldMapFrame:SetMapID(mapID)
    local _, _, _, _, mapFile = C_Map.GetMapInfo(mapID)

    if mapFile == zone then
	local level = GetCurrentMapDungeonLevel()
	local posX, posY = GetPlayerMapPosition("player")
	local coord = findClosestChest(mapFile, level, posX, posY)
	if coord then
	    local node = nodes[mapFile][level][coord]
	    -- Temporarily mark the chest as sent back; Next run the quest will
	    -- be flagged as completed
	    node.completed = true
	    HandyNotes_WitheredChests:SendMessage("HandyNotes_NotifyUpdate", "Withered Chests")
	end
    end
end)
