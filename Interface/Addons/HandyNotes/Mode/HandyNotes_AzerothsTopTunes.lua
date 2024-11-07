
------------------------------------------
--  This addon was heavily inspired by  --
--    HandyNotes_Lorewalkers            --
--    HandyNotes_LostAndFound           --
--  by Kemayo                           --
------------------------------------------


-- declaration
local HandyNotes_AzerothsTopTunes = {}
HandyNotes_AzerothsTopTunes.points = {}


-- our db and defaults
local db
local defaults = { profile = { completed = false, icon_scale = 1.4, icon_alpha = 0.8 } }


-- upvalues
local _G = getfenv(0)

local GameTooltip = _G.GameTooltip
local IsControlKeyDown = _G.IsControlKeyDown
local gsub = _G.string.gsub
local LibStub = _G.LibStub
local next = _G.next
local UIParent = _G.UIParent
local WorldMapButton = _G.WorldMapButton
local WorldMapTooltip = _G.WorldMapTooltip

local HandyNotes = _G.HandyNotes
local TomTom = _G.TomTom

local completedQuests = {}
local points = HandyNotes_AzerothsTopTunes.points
local playerFaction = UnitFactionGroup("player")

-- plugin handler for HandyNotes
local function infoFromCoord(mapFile, coord)
	mapFile = gsub(mapFile, "_terrain%d+$", "")

	local point = points[mapFile] and points[mapFile][coord]

	return point[2], point[3]
end

function HandyNotes_AzerothsTopTunes:OnEnter(mapFile, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip

	if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local name, note = infoFromCoord(mapFile, coord)

	tooltip:SetText(name)
	tooltip:AddLine(note, 1, 1, 1)

	if TomTom then
		tooltip:AddLine(" ")
		tooltip:AddLine("Right-click to set a waypoint.", 1, 1, 1)
		tooltip:AddLine("Control-Right-click to set waypoints to every music roll.", 1, 1, 1)
	end

	tooltip:Show()
end

function HandyNotes_AzerothsTopTunes:OnLeave()
	if self:GetParent() == WorldMapButton then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end


local function createWaypoint(mapFile, coord)
	local x, y = HandyNotes:getXY(coord)
	local m = HandyNotes:GetMapFiletoMapID(mapFile)

	local name = infoFromCoord(mapFile, coord)

	TomTom:AddMFWaypoint(m, nil, x, y, { title = name })
	TomTom:SetClosestWaypoint()
end

local function createAllWaypoints()
	for mapFile, coords in next, points do
		for coord, questID in next, coords do
			if coord and (db.completed or not completedQuests[questID]) then
				createWaypoint(mapFile, coord)
			end
		end
	end
end

function HandyNotes_AzerothsTopTunes:OnClick(button, down, mapFile, coord)
	if TomTom and button == "RightButton" and not down then
		if IsControlKeyDown() then
			createAllWaypoints()
		else
			createWaypoint(mapFile, coord)
		end
	end
end


do
	-- custom iterator we use to iterate over every node in a given zone
	local function iter(t, prestate)
		if not completedQuests[38356] or not completedQuests[37961] then return end
		if not t then return end

		local state, value = next(t, prestate)

		while state do -- have we reached the end of this zone?
			if (db.completed or not completedQuests[value[1]]) then
				return state, nil, "interface\\icons\\inv_misc_punchcards_yellow", db.icon_scale, db.icon_alpha
			end

			state, value = next(t, state) -- get next data
		end
	end

	local function iterCont(t, prestate)
		if not completedQuests[38356] or not completedQuests[37961] then return end
		if not t then return end

		local zone = t.Z
		local mapFile = HandyNotes:GetMapIDtoMapFile(t.C[zone])
		local state, value, data, cleanMapFile

		while mapFile do
			cleanMapFile = gsub(mapFile, "_terrain%d+$", "")
			data = points[cleanMapFile]

			if data then -- only if there is data for this zone
				state, value = next(data, prestate)

				while state do -- have we reached the end of this zone?
					if (db.completed or not completedQuests[value[1]]) then
						return state, mapFile, "interface\\icons\\inv_misc_punchcards_yellow", db.icon_scale, db.icon_alpha
					end

					state, value = next(data, state) -- get next data
				end
			end

			-- get next zone
			zone = next(t.C, zone)
			t.Z = zone
			mapFile = HandyNotes:GetMapIDtoMapFile(t.C[zone])
			prestate = nil
		end
	end

	function HandyNotes_AzerothsTopTunes:GetNodes(mapFile)
		local C = HandyNotes:GetContinentZoneList(mapFile) -- Is this a continent?

		if C then
			local tbl = { C = C, Z = next(C) }
			return iterCont, tbl, nil
		else
			mapFile = gsub(mapFile, "_terrain%d+$", "")
			return iter, points[mapFile], nil
		end
	end
end


-- config
local options = {
	type = "group",
	name = "Azeroth's Top Tunes",
	desc = "Music Scrolls for your Garrison Jukebox.",
	get = function(info) return db[info[#info]] end,
	set = function(info, v)
		db[info[#info]] = v
		HandyNotes_AzerothsTopTunes:Refresh()
	end,
	args = {
		desc = {
			name = "These settings control the look and feel of the icon.",
			type = "description",
			order = 1,
		},
		completed = {
			name = "Show completed",
			desc = "Show icons for music scrolls you have already collected.",
			type = "toggle",
			width = "full",
			arg = "completed",
			order = 2,
		},
		icon_scale = {
			type = "range",
			name = "Icon Scale",
			desc = "Change the size of the icons.",
			min = 0.25, max = 2, step = 0.01,
			arg = "icon_scale",
			order = 3,
		},
		icon_alpha = {
			type = "range",
			name = "Icon Alpha",
			desc = "Change the transparency of the icons.",
			min = 0, max = 1, step = 0.01,
			arg = "icon_alpha",
			order = 4,
		},
	},
}


-- initialise
function HandyNotes_AzerothsTopTunes:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then
		HandyNotes:Print("Your installed copy of HandyNotes is out of date and the Azeroth's Top Tunes plug-in will not work correctly.  Please update HandyNotes to version 1.5.0 or newer.")
		return
	end

	HandyNotes:RegisterPluginDB("HandyNotes_AzerothsTopTunes", self, options)

	completedQuests = C_QuestLog.GetQuestsCompleted(completedQuests)
	db = LibStub("AceDB-3.0"):New("HandyNotes_AzerothsTopTunesDB", defaults, "Default").profile

	HandyNotes_AzerothsTopTunes:Refresh()
	HandyNotes_AzerothsTopTunes:RegisterEvent("CRITERIA_UPDATE", "Refresh")
end

function HandyNotes_AzerothsTopTunes:Refresh(_, questID)
	if questID then completedQuests[questID] = true end
	self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_AzerothsTopTunes")
end


-- activate
LibStub("AceAddon-3.0"):NewAddon(HandyNotes_AzerothsTopTunes, "HandyNotes_AzerothsTopTunes", "AceEvent-3.0")

----------------------
-- Eastern Kingdoms --
----------------------

points["BlackwingDescent"] = {
	[47377918] = { 38063, "Legends of Azeroth", "Defeat Nefarian.\nThis is NOT a guaranteed drop." },
}

points["BurningSteppes"] = {
	[23242635] = { 38063, "Legends of Azeroth", "Inside the Blackwing Descent raid.\n\nDefeat Nefarian.\nThis is NOT a guaranteed drop." },
}

points["DeadwindPass"] = {
	[46927479] = { 38093, "Karazhan Opera House", "Inside the Karazhan raid.\n\nComplete the Opera House event.\nThis is NOT a guaranteed drop." },
}

points["Duskwood"] = {
	[23503710] = { 38088, "Ghost", "Kill yourself somehow, then speak to the Forlorn Composer." },
}

points["Karazhan"] = {
	[17713439] = { 38093, "Karazhan Opera House", "Inside the Karazhan raid.\n\nComplete the Opera House event.\nThis is NOT a guaranteed drop." },
}

points["StranglethornVale"] = {
	[41285134] = { 38087, "Angelic", "Loot the Arena Master Chest in the center of the Gurubashi Battle Ring.\nOnly available once every four hours." },
}

points["TheCapeOfStranglethorn"] = {
	[46532626] = { 38087, "Angelic", "Loot the Arena Master Chest in the center of the Gurubashi Battle Ring.\nOnly available once every four hours." },
}

points["Tirisfal"] = {
	[17566754] = { 38096, "Faerie Dragon", "Loot the Faerie Dragon Nest in the center of the mushroom circle.\nOnly available while the Fey-Drunk Darters are casting their spell." },
	[60148499] = { 38095, "Lament of the Highborne", "Inside Undercity.\n\nLoot the strongbox at the base of a pillar to the left of Sylvannas Windrunner." },
}

points["Undercity"] = {
	[58119388] = { 38095, "Lament of the Highborne", "Loot the strongbox at the base of a pillar to the left of Sylvannas Windrunner." },
}

if playerFaction == "Alliance" then
	points["DunMorogh"] = {
		[31393804] = { 38081, "Tinkertown", "Inside the Gnomeregan dungeon.\n\nKill mobs for [Grime-Encrusted Object], clean them at the Sparkle-Matic 5200 and open the box it gives you.\nThis is NOT a guaranteed drop." },
		[65802243] = { 38075, "Cold Mountain", "Inside Ironforge.\n\nGo fishing for a bit in the Folorn Cavern." },
	}

	points["Gnomeregan"] = {
		[64946316] = { 38081, "Tinkertown", "Kill mobs for [Grime-Encrusted Object], clean them at the Sparkle-Matic 5200 and open the box it gives you.\nThis is NOT a guaranteed drop." },
	}

	points["Ironforge"] = {
		[47001983] = { 38075, "Cold Mountain", "Go fishing for a bit in the Folorn Cavern." },
	}

	points["NewTinkertownStart"] = {
		[32503700] = { 38081, "Tinkertown", "Inside the Gnomeregan dungeon.\n\nKill mobs for [Grime-Encrusted Object], clean them at the Sparkle-Matic 5200 and open the box it gives you.\nThis is NOT a guaranteed drop." },
	}
end

if playerFaction == "Horde" then
	points["StranglethornVale"][63852180] = { 38080, "Zul'Gurub Voo Doo", "Inside the Zul'Gurub dungeon.\n\nDefeat Jin'do the Godbreaker.\nThis is NOT a guaranteed drop." }
	points["StranglethornJungle"] = {
		[71953290] = { 38080, "Zul'Gurub Voo Doo", "Inside the Zul'Gurub dungeon.\n\nDefeat Jin'do the Godbreaker.\nThis is NOT a guaranteed drop." },
	}
	points["ZulGurub"] = {
		[50933982] = { 38080, "Zul'Gurub Voo Doo", "Defeat Jin'do the Godbreaker.\nThis is NOT a guaranteed drop." },
	}
end


--------------
-- Kalimdor --
--------------

points["Ashenvale"] = {
	[56404923] = { 38090, "Magic", "Loot the Lost Sentinel's Pouch inside a large hollow tree trunk." }
}

points["Darnassus"] = {
	[43007600] = { 38100, "Shalandis Isle", "Loot the chest on the top floor of the Temple of the Moon,\non the wall opposite Tyrande Whisperwind." },
}

points["Tanaris"] = {
	[61705195] = { 38066, "The Shattering", "Inside the Dragon Soul raid.\n\nDefeat Madness of Deathwing.\nThis is NOT a guaranteed drop." },
}

points["Winterspring"] = {
	[68007390] = { 38089, "Mountains", "Loot the Frozen Supplies in a nook at the base of the pillar." },
}

if playerFaction == "Horde" then
	points["Mulgore"] = {
		[35882188] = { 38076, "Mulgore Plains", "Inside Thunder Bluff.\n\nGo fishing for a bit in the Pools of Vision\nbeneath the Spirit Rise." },
	}
	points["ThunderBluff"] = {
		[25701640] = { 38076, "Mulgore Plains", "Go fishing for a bit in the Pools of Vision\nbeneath the Spirit Rise." },
	}
end


-------------
-- Outland --
-------------

points["ShadowmoonValley"] = {
	[57384968] = { 38091, "The Black Temple", "Loot the Warden's Scrollcase inside the Warden's Cage." },
	[70994642] = { 38064, "The Burning Legion", "Inside the Black Temple raid.\n\nDefeat Illidan.\nThis is NOT a guaranteed drop." },
}


---------------
-- Northrend --
---------------

points["Dragonblight"] = {
	[87335092] = { 38065, "Wrath of the Lich King", "Inside the Naxxramas raid.\n\nDefeat Kel'Thuzad.\nThis is NOT a guaranteed drop." },
}

points["HallsofLightning"] = {
	[19185606] = { 38098, "Mountains of Thunder", "Defeat Loken on Heroic difficulty.\nThis is NOT a guaranteed drop." },
}

points["IcecrownCitadel"] = {
	[49795290] = { 38092, "Invincible", "Defeat The Lich King.\nThis is NOT a guaranteed drop." }
}

points["IcecrownGlacier"] = {
	[53838714] = { 38092, "Invincible", "Inside the Icecrown Citadel raid.\n\nDefeat The Lich King.\nThis is NOT a guaranteed drop." }
}

points["Naxxramas"] = {
	[36542288] = { 38065, "Wrath of the Lich King", "Defeat Kel'Thuzad.\nThis is NOT a guaranteed drop." },
}

points["TheStormPeaks"] = {
	[45292148] = { 38098, "Mountains of Thunder", "Inside the Halls of Lightning dungeon.\n\nDefeat Loken on Heroic difficulty.\nThis is NOT a guaranteed drop." },
}

if playerFaction == "Alliance" then
	points["IcecrownGlacier"][75951993] = { 38094, "The Argent Tournament", "Purchased from any city quartermaster for 25 [Champion's Seal]." }
	points["GrizzlyHills"] = {
		[57113318] = { 38097, "Totems of the Grizzlemaw", "Speak to Remington Brode, who patrols all over Grizzly Hills.\nHe starts at Amberpine Lodge, follows the road counter-clockwise to Conquest Hold,\nthen north to Westfall Brigade Encampment, and then south to Camp Oneqwah.\n\nWhen you find him select \"<Breathe deeply.>\",\"I'm looking for a song...\",\n\"A song about the wilderness.\", and \"Yes!\"" },
	}
end

if playerFaction == "Horde" then
	points["IcecrownGlacier"][75952363] = { 38094, "The Argent Tournament", "Purchased from any city quartermaster for 25 [Champion's Seal]." }
	points["GrizzlyHills"] = {
		[22026934] = { 38097, "Totems of the Grizzlemaw", "Speak to Remington Brode, who patrols all over Grizzly Hills.\nHe starts at Amberpine Lodge, follows the road counter-clockwise to Conquest Hold,\nthen north to Westfall Brigade Encampment, and then south to Camp Oneqwah.\n\nWhen you find him select \"<Breathe deeply.>\",\"I'm looking for a song...\",\n\"A song about the wilderness.\", and \"Yes!\"" },
	}
end


---------------
-- Cataclysm --
---------------

points["DarkmoonFaireIsland"] = {
	[51507505] = { 38099, "Darkmoon Carousel", "Purchased from Chester for 90 [Darkmoon Prize Ticket]." }
}


--------------
-- Pandaria --
--------------

points["TheHiddenPass"] = {
	[48486149] = { 38067, "Heart of Pandaria", "Inside the Terrace of Endless Spring raid.\n\nDefeat Sha of Fear.\nThis is NOT a guaranteed drop." },
}

points["TerraceOfEndlessSpring"] = {
	[38914829] = { 38067, "Heart of Pandaria", "Defeat Sha of Fear.\nThis is NOT a guaranteed drop." },
}

points["ValeofEternalBlossoms"] = {
	[82222928] = { 38102, "Song of Liu Lang", "Purchased from Tan Shin Tiao for 100 gold.\nRequires Revered with The Lorewalkers." },
}

if playerFaction == "Alliance" then
	points["Krasarang"] = {
		[89533354] = { 38071, "High Seas", "Purchased from Proveditor Grantley for 500 [Domination Point Commission]." },
	}
end

if playerFaction == "Horde" then
	points["Krasarang"] = {
		[10605360] = { 38072, "War March", "Purchased from Ongrom Black Tooth for 500 [Lion's Landing Commission]." },
	}
end


-------------
-- Draenor --
-------------

points["FoundryRaid"] = {
	[48363460] = { 38068, "A Siege of Worlds", "Defeat Blackhand.\nThis is NOT a guaranteed drop." },
}

points["Gorgrond"] = {
	[51562724] = { 38068, "A Siege of Worlds", "Inside the Blackrock Foundry raid.\n\nDefeat Blackhand.\nThis is NOT a guaranteed drop." },
}
