local MapIDAlteracValley = 91
local MapIDAlteracValleyKorrak = 1537
local MapIDIsleOfThunder = 504
local MapIDDalaran = 125
local MapIDTanaanJungle = 534
local MapIDAzsuna = 627
local MapIDDalaranLegion = 1014
local MapIDAntoranWastes = 885
local MapIDAlterac = 943

local ContinentIdOutland = 101
local ContinentIdPandaria = 424
local ContinentIdDraenor = 946
local ContinentIdBrokenIsles = 619
local ContinentIdArgus = 905
local ContinentIdZandalar = 875
local ContinentIdKulTiras = 876

local function AtZone(requiredZone)
	return function()
		local mapID = C_Map.GetBestMapForUnit("player")
		while mapID ~= 0 do
			if mapID == requiredZone then
				return true
			end
			mapID = C_Map.GetMapInfo(mapID).parentMapID
		end
		return false
	end
end

local function AtContinent(requiredContinent)
	return AtZone(requiredContinent)
end

local function AllowWhistle()
	--return AtContinent(ContinentIdBrokenIsles)() or AtContinent(ContinentIdArgus)() or AtContinent(ContinentIdKulTiras)() or AtContinent(ContinentIdZandalar)() or AtZone(MapIdAlterac)
	-- This is getting complicated - until I find a better way, always allow it.
	return true
end

local function InBFAZone()
	return AtContinent(ContinentIdKulTiras)() or AtContinent(ContinentIdZandalar)()
end

local function IsInAlteracValley()
	return AtZone(MapIDAlteracValley)() or AtZone(MapIDAlteracValleyKorrak)()
end

local function IsClass(requiredClass)
	return function()
		local _, playerClass = UnitClass("player")
		return playerClass == requiredClass
	end
end

local function HaveUpgradedZen()
	return C_QuestLog.IsQuestFlaggedCompleted(40236)
end

local DaySunday = 1
local DayMonday = 2
local DayTuesday = 3
local DayWednesday = 4
local DayThursday = 5
local DayFriday = 6
local DaySaturday = 7

local function OnDay(day)
	return function()
		local today = date("*t").wday
		return day == today
	end
end

local function OnDayAtContinent(day, continent)
	return function()
		return OnDay(day)() and AtContinent(continent)
	end
end

local function CreateDestination(zone, spells)	
	for i, spell in ipairs(spells) do
		spell.zone = zone
		tinsert(TeleporterDefaultSpells, spell)
	end
end


local function PrintZoneIndex(name)
	for i = 1, 10000 do
		local info = C_Map.GetMapInfo(i)
		if info and info.name == name then
			print(name .. " should be zone " .. i)
			return
		end
	end
	--print("Unknown zone " .. name)
end

local function LocZone(name, mapID)
	if mapID == 0 then
		PrintZoneIndex(name)		
		return name
	else
		local mapInfo =	C_Map.GetMapInfo(mapID)
		if not mapInfo then
			PrintZoneIndex(name)	
			return name
		end
		local locName = mapInfo.name
		return locName
	end
end

local function LocArea(name, areaID)
	local locName
	if areaID == 0 then
		for i = 1, 10000 do
			if C_Map.GetAreaInfo(i) == name then
				print(name .. " should be area " .. i)
			end
		end
		return name
	else
		locName = C_Map.GetAreaInfo(areaID)
		--if locName ~= name then
		--	print("Incorrect localization of " .. name .. ", got " .. locName)		
		--end
	end
	return locName
end

local CreateSpell = TeleporterCreateSpell
local CreateItem = TeleporterCreateItem
local CreateChallengeSpell = TeleporterCreateChallengeSpell
local CreateConditionalItem = TeleporterCreateConditionalItem
local CreateConditionalSpell = TeleporterCreateConditionalSpell
local CreateConditionalConsumable = TeleporterCreateConditionalConsumable
local CreateConsumable = TeleporterCreateConsumable

TeleporterDefaultSpells = 
{	
}

CreateDestination(
	TeleporterHearthString,
	{
		CreateItem(93672),				-- Dark Portal  黑暗之门
		CreateItem(54452),				-- Ethereal Portal  虚灵之门
		CreateItem(6948 ),				-- Hearthstone  炉石
		CreateItem(28585),				-- Ruby Slippers
		CreateConsumable(37118),		-- Scroll of Recall
		CreateConsumable(44314),		-- Scroll of Recall II
		CreateConsumable(44315),		-- Scroll of Recall III
		CreateItem(64488),				-- The Innkeeper's Daughter	  旅店老板的女儿
		CreateItem(142298),				-- Astonishingly Scarlet Slippers
		CreateConsumable(142543),		-- Scroll of Town Portal
		CreateItem(142542),				-- Tome of Town Portal  城镇传送门
		CreateItem(162973),				-- Greatfather Winter's Hearthstone  冬天爷爷的炉石 278244
		CreateItem(163045),				-- Headless Horseman's Hearthstone  无头骑士的炉石 278559
		CreateItem(166747),				-- Brewfest Reveler's Hearthstone  美酒节狂欢者的炉石
		CreateItem(166746),				-- Fire Eater's Hearthstone  吞火者的炉石
		CreateItem(165802),				-- Noble Gardener's Hearthstone  复活节的炉石
		CreateItem(168907),				-- Holographic Digitalization Hearthstone 全息数字化炉石
		CreateItem(165669),				-- Lunar Elder's Hearthstone  春节长者的炉石 285362
		CreateItem(165670),				-- Peddlefeet's Lovely Hearthstone  小匹德菲特的可爱炉石
		CreateItem(172179),				-- Eternal Traveler's Hearthstone  永恒旅者的炉石
	})
	
CreateDestination(
	TeleporterRecallString,
	{
		CreateSpell(556)				-- Astral Recall
	})

CreateDestination(
	TeleporterFlightString,
	{ 
		CreateConditionalItem(141605, AllowWhistle) 	-- Flight Master's Whistle
	})
	
CreateDestination(
	LocZone("Alterac Valley", 91),
	{
		CreateConditionalItem(17690, IsInAlteracValley ),	-- Frostwolf Insignia Rank 1
		CreateConditionalItem(17905, IsInAlteracValley ),	-- Frostwolf Insignia Rank 2
		CreateConditionalItem(17906, IsInAlteracValley ),	-- Frostwolf Insignia Rank 3
		CreateConditionalItem(17907, IsInAlteracValley ),	-- Frostwolf Insignia Rank 4
		CreateConditionalItem(17908, IsInAlteracValley ),	-- Frostwolf Insignia Rank 5
		CreateConditionalItem(17909, IsInAlteracValley ),	-- Frostwolf Insignia Rank 6
		CreateConditionalItem(17691, IsInAlteracValley ),	-- Stormpike Insignia Rank 1
		CreateConditionalItem(17900, IsInAlteracValley ),	-- Stormpike Insignia Rank 2
		CreateConditionalItem(17901, IsInAlteracValley ),	-- Stormpike Insignia Rank 3
		CreateConditionalItem(17902, IsInAlteracValley ),	-- Stormpike Insignia Rank 4
		CreateConditionalItem(17903, IsInAlteracValley ),	-- Stormpike Insignia Rank 5
		CreateConditionalItem(17904, IsInAlteracValley ),	-- Stormpike Insignia Rank 6
		CreateConditionalItem(18149, IsInAlteracValley ), -- Rune of Recall6
		CreateConditionalItem(18150, IsInAlteracValley ), -- Rune of Recall6
	})

CreateDestination(
	LocZone("Antoran Wastes", 885),
	{
		CreateConditionalItem(153226, AtZone(MapIDAntoranWastes))	-- Observer's Locus Resonator
	})

CreateDestination(
	LocZone("Argus", 905),
	{
		CreateItem(151652)				-- Wormhole Generator: Argus
	})

CreateDestination(
	LocZone("Ashran", 588),
	{
		CreateConsumable(116413),		-- Scroll of Town Portal
		CreateConsumable(119183),		-- Scroll of Risky Recall
		CreateSpell(176246),			-- Portal: Stormshield
		CreateSpell(176248),			-- Teleport: Stormshield
		CreateSpell(176244),			-- Portal: Warspear
		CreateSpell(176242),			-- Teleport: Warspear
	})

CreateDestination(
	LocZone("Azsuna", 630),
	{
		CreateConditionalItem(129276, AtZone(MapIDAzsuna)),	-- Beginner's Guide to Dimensional Rifting
		CreateConditionalConsumable(141016, AtContinent(ContinentIdBrokenIsles)),	-- Scroll of Town Portal: Faronaar
		CreateConditionalItem(140493, OnDayAtContinent(DayWednesday, ContinentIdBrokenIsles)),	-- Adept's Guide to Dimensional Rifting
	}, 630)

CreateDestination(
	LocArea("Bizmo's Brawlpub", 6618),
	{
		CreateItem(95051),				-- The Brassiest Knuckle
		CreateItem(118907),				-- Pit Fighter's Punching Ring
		CreateItem(144391),				-- Pugilist's Powerful Punching Ring
	})			
			
CreateDestination(			
	LocZone("Black Temple", 490),
	{			
		CreateItem(32757),				-- Blessed Medallion of Karabor
		CreateItem(151016), 			-- Fractured Necrolyte Skull
	})
				
CreateDestination(			
	LocZone("Blackrock Depths", 242),
	{			
		CreateItem(37863)				-- Direbrew's Remote
	})

CreateDestination(			
	LocZone("Blackrock Foundry", 596),
	{	
		CreateChallengeSpell(169771)	-- Teleport: Blackrock Foundry
	})

CreateDestination(			
	LocZone("Blade's Edge Mountains", 105),	
	{
		CreateItem(30544),				-- Ultrasafe Transporter - Toshley's Station
	})

CreateDestination(			
	LocArea("Bladespire Citadel", 6864),
	{
		CreateItem(118662), 			-- Bladespire Relic
	})

CreateDestination(			
	LocArea("Booty Bay", 35),	
	{
		CreateItem(50287),				-- Boots of the Bay
	})
	
CreateDestination(			
	LocZone("Boralus", 1161),
	{
		CreateSpell(281403),			-- Teleport: Boralus
		CreateSpell(281400),			-- Portal: Boralus
		CreateItem(166560),				-- Captain's Signet of Command
	})

CreateDestination(			
	LocZone("Brawl'gar Arena", 503),	
	{
		CreateItem(95050),				-- The Brassiest Knuckle
		CreateItem(118908),				-- Pit Fighter's Punching Ring
		CreateItem(144392),				-- Pugilist's Powerful Punching Ring
	}, 503)
	
CreateDestination(			
	LocZone("Broken Isles",	619),
	{
		CreateConsumable(132523), 		-- Reaves Battery (can't always teleport, don't currently check).	
		CreateItem(144341), 			-- Rechargeable Reaves Battery
	})

CreateDestination(			
	LocZone("Dalaran", 41) .. " (Legion)",	
	{
		CreateSpell(224871),		-- Portal: Dalaran - Broken Isles (UNTESTED)
		CreateSpell(224869),		-- Teleport: Dalaran - Broken Isles	(UNTESTED)
		CreateItem(138448),			-- Emblem of Margoss
		CreateItem(139599),			-- Empowered Ring of the Kirin Tor
		CreateItem(140192),			-- Dalaran Hearthstone
		CreateConditionalItem(43824, AtZone(MapIDDalaranLegion)),	-- The Schools of Arcane Magic - Mastery
	})

CreateDestination(			
	LocZone("Dalaran", 41) .. " (WotLK)",	
	{
		CreateSpell(53140),			-- Teleport: Dalaran
		CreateSpell(53142),			-- Portal: Dalaran
	-- ilvl 200 rings
		CreateItem(40586),			-- Band of the Kirin Tor
		CreateItem(44934),			-- Loop of the Kirin Tor
		CreateItem(44935),			-- Ring of the Kirin Tor
		CreateItem(40585),			-- Signet of the Kirin Tor
	-- ilvl 213 rings
		CreateItem(45688),			-- Inscribed Band of the Kirin Tor
		CreateItem(45689),			-- Inscribed Loop of the Kirin Tor
		CreateItem(45690),			-- Inscribed Ring of the Kirin Tor
		CreateItem(45691),			-- Inscribed Signet of the Kirin Tor
	-- ilvl 226 rings
		CreateItem(48954),			-- Etched Band of the Kirin Tor
		CreateItem(48955),			-- Etched Loop of the Kirin Tor
		CreateItem(48956),			-- Etched Ring of the Kirin Tor
		CreateItem(48957),			-- Etched Signet of the Kirin Tor
	-- ilvl 251 rings
		CreateItem(51560),			-- Runed Band of the Kirin Tor
		CreateItem(51558),			-- Runed Loop of the Kirin Tor
		CreateItem(51559),			-- Runed Ring of the Kirin Tor
		CreateItem(51557),			-- Runed Signet of the Kirin Tor

		CreateConditionalItem(43824, AtZone(MapIDDalaran)),	-- The Schools of Arcane Magic - Mastery
		CreateItem(52251),			-- Jaina's Locket
	})
	
CreateDestination(			
	LocArea("Dalaran Crater", 279),
	{
		CreateSpell(120145),		-- Ancient Teleport: Dalaran
		CreateSpell(120146),		-- Ancient Portal: Dalaran
	})

CreateDestination(			
	LocZone("Darnassus", 89),
	{
		CreateSpell(3565),			-- Teleport: Darnassus
		CreateSpell(11419),			-- Portal: Darnassus
	})
	
CreateDestination(			
	LocZone("Dazar'alor", 1163),
	{
		CreateSpell(281404),		-- Teleport: Dazar'alor
		CreateSpell(281402),		-- Portal: Dazar'alor
		CreateItem(166559),			-- Commander's Signet of Battle
		CreateConditionalItem(165581, AtZone(1163)), -- Crest of Pa'ku
	})

CreateDestination(
	LocZone("Deepholm", 207),
	{
		CreateConsumable(58487),	-- Potion of Deepholm
	})

CreateDestination(
	LocZone("Draenor", 572),
	{
		CreateConditionalConsumable(117389, AtContinent(ContinentIdDraenor)), -- Draenor Archaeologist's Lodestone
		CreateItem(112059),			-- Wormhole Centrifuge
		CreateConditionalItem(129929, AtContinent(ContinentIdOutland)),	-- Ever-Shifting Mirror
	})
	
CreateDestination(
	"Draenor Dungeons",					-- No localization
	{
		CreateChallengeSpell(159897),	-- Teleport: Auchindoun
		CreateChallengeSpell(159895),	-- Teleport: Bloodmaul Slag Mines
		CreateChallengeSpell(159901),	-- Teleport: Overgrown Outpost
		CreateChallengeSpell(159900),	-- Teleport: Grimrail Depot
		CreateChallengeSpell(159896),	-- Teleport: Iron Docks
		CreateChallengeSpell(159899),	-- Teleport: Shadowmoon Burial Grounds
		CreateChallengeSpell(159898),	-- Teleport: Skyreach
		CreateChallengeSpell(159902),	-- Teleport: Upper Blackrock Spire
	})

CreateDestination(
	LocZone("Acherus: The Ebon Hold", 647),
	{
		CreateSpell(50977),			-- Death Gate
	})

CreateDestination(
	LocZone("Emerald Dreamway", 715),
	{
		CreateSpell(193753), 		-- Dreamwalk
	})

CreateDestination(
	LocZone("The Exodar", 103),
	{
		CreateSpell(32271),			-- Teleport: Exodar
		CreateSpell(32266),			-- Portal: Exodar
	})

CreateDestination(
	"Fishing Pool",					-- No localization.
	{	
		CreateConditionalSpell(201891, AtContinent(ContinentIdBrokenIsles)),		-- Undercurrent
		CreateConditionalConsumable(162515, InBFAZone),	-- Midnight Salmon
	})
	
CreateDestination(
	GARRISON_LOCATION_TOOLTIP,
	{
		CreateItem(110560),				-- Garrison Hearthstone
	})

	
CreateDestination(
	LocZone("Hall of the Guardian", 734),
	{
		CreateChallengeSpell(193759), 	-- Teleport: Hall of the Guardian
	})
--	
CreateDestination(
	LocZone("Highmountain", 869),
	{
		CreateConditionalConsumable(141017, AtContinent(ContinentIdBrokenIsles)),				-- Scroll of Town Portal: Lian'tril
		CreateConditionalItem(140493, OnDayAtContinent(DayThursday, ContinentIdBrokenIsles)),	-- Adept's Guide to Dimensional Rifting
	})

CreateDestination(
	LocZone("Icecrown", 118),
	{
		CreateItem(46874),				-- Argent Crusader's Tabard
	})

CreateDestination(
	LocZone("Ironforge", 87),
	{
		CreateSpell(3562),				-- Teleport: Ironforge
		CreateSpell(11416)				-- Portal: Ironforge
	})

CreateDestination(
	LocZone("Isle of Thunder", 504),
	{
		CreateConditionalItem(95567, AtZone(MapIDIsleOfThunder )),	-- Kirin Tor Beacon
		CreateConditionalItem(95568, AtZone(MapIDIsleOfThunder )),	-- Sunreaver Beacon
	})

CreateDestination(
	LocArea("Karabor", 6930),
	{
		CreateItem(118663),				-- Relic of Karabor
	})

CreateDestination(
	LocZone("Karazhan", 794),
	{
		CreateItem(22589),		-- Atiesh, Greatstaff of the Guardian
		CreateItem(22630),		-- Atiesh, Greatstaff of the Guardian
		CreateItem(22631),		-- Atiesh, Greatstaff of the Guardian
		CreateItem(22632),		-- Atiesh, Greatstaff of the Guardian
		CreateItem(142469), 	-- Violet Seal of the Grand Magus
	})
	
CreateDestination(
	LocZone("Kul Tiras", 876),
	{
		CreateItem(168807)		-- Wormhole Generator: Kul Tiras
	})

CreateDestination(
	LocZone("Kun-Lai Summit", 379),
	{
		CreateConditionalSpell(126892, function() return not HaveUpgradedZen() end ),	-- Zen Pilgrimage
	})
	
CreateDestination(
	LocZone("Maldraxxus", 1536),
	{
		CreateItem(181163),		-- Scroll of Teleport: Theater of Pain
	})
	
CreateDestination(
	LocZone("Mechagon", 1490),
	{
		CreateConsumable(167075),	-- Ultrasafe Transporter: Mechagon
	})
	
CreateDestination(
	"Mole Machine",					-- No localization.
	{
		CreateSpell(265225),		-- Mole Machine
	})

CreateDestination(
	LocZone("Moonglade", 80),
	{
		CreateSpell(18960),		-- Teleport: Moonglade
		CreateItem(21711),		-- Lunar Festival Invitation
	})

CreateDestination(
	LocZone("Netherstorm", 109),
	{
		CreateItem(30542),		-- Dimensional Ripper - Area 52
	})

CreateDestination(
	LocZone("Northrend", 113),
	{
		CreateItem(48933),		-- Wormhole Generator: Northrend
	})

CreateDestination(
	LocZone("Orgrimmar", 85),
	{
		CreateSpell(3567),		-- Teleport: Orgrimmar
		CreateSpell(11417),		-- Portal: Orgrimmar
		CreateItem(63207),		-- Wrap of Unity
		CreateItem(63353),		-- Shroud of Cooperation
		CreateItem(65274),		-- Cloak of Coordination
	})
	
CreateDestination(
	LocZone("Oribos", 1670),
	{
		CreateSpell(344587),	-- Teleport: Oribos
		CreateSpell(344597),	-- Portal: Oribos
	})

CreateDestination(
	LocZone("Outland", 101),
	{
		CreateConditionalItem(129929, AtContinent(ContinentIdDraenor) ),	-- Ever-Shifting Mirror
	})

CreateDestination(
	LocZone("Pandaria", 424),
	{
		CreateConditionalConsumable(87548, AtContinent(ContinentIdPandaria)), 	-- Lorewalker's Lodestone
		CreateItem(87215),														-- Wormhole Generator: Pandaria
	})

CreateDestination(
	"Pandaria Dungeons",		-- No localization.
	{
		CreateChallengeSpell(131225),	-- Path of the Setting Sun	
		CreateChallengeSpell(131222),	-- Path of the Mogu King
		CreateChallengeSpell(131231),	-- Path of the Scarlet Blade	
		CreateChallengeSpell(131229),	-- Path of the Scarlet Mitre	
		CreateChallengeSpell(131232),	-- Path of the Necromancer
		CreateChallengeSpell(131206),	-- Path of the Shado-Pan
		CreateChallengeSpell(131228),	-- Path of the Black Ox
		CreateChallengeSpell(131205),	-- Path of the Stout Brew
		CreateChallengeSpell(131204),	-- Path of the Jade Serpent
	})

CreateDestination(
	"Random",		-- No localization.
	{
		CreateSpell(147420),								-- One With Nature
		CreateItem(64457), 									-- The Last Relic of Argus
		CreateConditionalItem(136849, IsClass("DRUID")),	-- Nature's Beacon
	})
	
--返回营地312372
CreateDestination(
	"Fox",		-- No localization.
	{
		CreateSpell(312372),								-- 返回营地
	})

CreateDestination(
	LocArea("Ravenholdt", 0),
	{
		CreateItem(139590),		-- Scroll of Teleport: Ravenholdt
	})

CreateDestination(
	LocZone("Shattrath City", 111),
	{
		CreateSpell(33690),		-- Teleport: Shattrath (Alliance)
		CreateSpell(33691),		-- Portal: Shattrath (Alliance)
		CreateSpell(35715),		-- Teleport: Shattrath (Horde)
		CreateSpell(35717),		-- Portal: Shattrath (Horde)
	})

CreateDestination(
	LocArea("Shipyard", 6668),
	{
		CreateItem(128353),		-- Admiral's Compass
	})

CreateDestination(
	LocZone("Silvermoon City", 110),
	{
		CreateSpell(32272),		-- Teleport: Silvermoon
		CreateSpell(32267),		-- Portal: Silvermoon
	})

CreateDestination(
	LocArea("Stonard", 75),
	{
		CreateSpell(49358),		-- Teleport: Stonard
		CreateSpell(49361),		-- Portal: Stonard
	})

CreateDestination(
	LocZone("Stormheim", 634),
	{
		CreateConditionalItem(140493, OnDayAtContinent(DayFriday, ContinentIdBrokenIsles)),	-- Adept's Guide to Dimensional Rifting
	})

CreateDestination(
	LocZone("Stormwind City", 84),
	{
		CreateSpell(3561),		-- Teleport: Stormwind
		CreateSpell(10059),		-- Portal: Stormwind
		CreateItem(63206),		-- Wrap of Unity
		CreateItem(63352),		-- Shroud of Cooperation
		CreateItem(65360),		-- Cloak of Coordination
	})

CreateDestination(
	LocZone("Suramar", 680),
	{
		CreateItem(140324),																		-- Mobile Telemancy Beacon
		CreateConditionalConsumable(141014, AtContinent(ContinentIdBrokenIsles)),				-- Scroll of Town Portal: Sashj'tar
		CreateConditionalItem(140493, OnDayAtContinent(DayTuesday, ContinentIdBrokenIsles)),	-- Adept's Guide to Dimensional Rifting
	})
		
CreateDestination(
	LocZone("Tanaan Jungle", 534),
	{
		CreateConditionalItem(128502, AtZone(MapIDTanaanJungle)),	-- Hunter's Seeking Crystal
		CreateConditionalItem(128503, AtZone(MapIDTanaanJungle)),	-- Master Hunter's Seeking Crystal
	})

CreateDestination(
	LocZone("Tanaris", 71),
	{
		CreateItem(18986),		-- Ultrasafe Transporter - Gadgetzan
	})

CreateDestination(
	LocArea("Temple of Five Dawns", 5820),
	{
		CreateConditionalSpell(126892, function() return HaveUpgradedZen() end ),	-- Zen Pilgrimage
	})
	
CreateDestination(
	LocZone("The Maw", 1543),
	{
		CreateConsumable(180817),		-- Cypher of Relocation
	})
	
CreateDestination(
	LocZone("The Shadowlands", 1550),
	{
		CreateItem(172924),		-- Wormhole Generator: Shadowlands
	})

CreateDestination(
	LocArea("Theramore Isle", 513),
	{
		CreateSpell(49359),		-- Teleport: Theramore
		CreateSpell(49360),		-- Portal: Theramore
	})

CreateDestination(
	LocZone("Timeless Isle", 554),
	{
		CreateItem(103678),		-- Time-Lost Artifact
	})

CreateDestination(
	LocZone("Thunder Bluff", 88),
	{
		CreateSpell(3566),		-- Teleport: Thunder Bluff
		CreateSpell(11420),		-- Portal: Thunder Bluff
	})

CreateDestination(
	LocZone("Tol Barad", 773),
	{
		CreateItem(63378),		-- Hellscream's Reach Tabard
		CreateItem(63379),		-- Baradin's Wardens Tabard
		CreateSpell(88342),		-- Teleport: Tol Barad (Alliance)
		CreateSpell(88344),		-- Teleport: Tol Barad (Horde)
		CreateSpell(88345),		-- Portal: Tol Barad (Alliance)
		CreateSpell(88346),		-- Portal: Tol Barad (Horde)
	})

CreateDestination(
	LocZone("Undercity", 90),
	{
		CreateSpell(3563),		-- Teleport: Undercity
		CreateSpell(11418),		-- Portal: Undercity
	})

CreateDestination(
	LocZone("Val'sharah", 641),
	{
		CreateConditionalConsumable(141013, AtContinent(ContinentIdBrokenIsles)),			-- Scroll of Town Portal: Shala'nir
		CreateConditionalConsumable(141015, AtContinent(ContinentIdBrokenIsles)),			-- Scroll of Town Portal: Kal'delar	
		CreateConditionalItem(140493, OnDayAtContinent(DayMonday, ContinentIdBrokenIsles)),	-- Adept's Guide to Dimensional Rifting
	})

-- I don't know why there are so many of these, not sure which is right but it's now safe to
-- list them all.
CreateDestination(
	LocZone("Vale of Eternal Blossoms", 390),
	{
		CreateSpell(132621),	-- Teleport: Vale of Eternal Blossoms
		CreateSpell(132627),	-- Teleport: Vale of Eternal Blossoms
		CreateSpell(132620),	-- Portal: Vale of Eternal Blossoms
		CreateSpell(132622),	-- Portal: Vale of Eternal Blossoms
		CreateSpell(132624),	-- Portal: Vale of Eternal Blossoms
		CreateSpell(132626),	-- Portal: Vale of Eternal Blossoms
	})

CreateDestination(
	LocZone("Winterspring", 83),
	{
		CreateItem(18984),		-- Dimensional Ripper - Everlook
	})
	
CreateDestination(
	LocZone("Zandalar", 875),
	{
		CreateItem(168808)		-- Wormhole Generator: Zandalar
	})

CreateDestination(
	LocZone("Zuldazar", 862),
	{
		CreateConsumable(157542),	-- Portal Scroll of Specificity
		CreateConsumable(160218),	-- Portal Scroll of Specificity
	})
	
-- Generate this file using /tele cache and copy TomeOfTele_DevCache from the global options file.
TomeOfTele_Cache = {
	[128502] = {
		"Hunter's Seeking Crystal", -- [1]
		"|cff0070dd|Hitem:128502::::::::60:102:::::::|h[Hunter's Seeking Crystal]|h|r", -- [2]
		3, -- [3]
		40, -- [4]
		1, -- [5]
		"Consumable", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		1020388, -- [10]
		0, -- [11]
		0, -- [12]
		8, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[37118] = {
		"Scroll of Recall", -- [1]
		"|cffffffff|Hitem:37118::::::::60:102:::::::|h[Scroll of Recall]|h|r", -- [2]
		1, -- [3]
		7, -- [4]
		0, -- [5]
		"Consumable", -- [6]
		"Other", -- [7]
		20, -- [8]
		"", -- [9]
		237450, -- [10]
		37, -- [11]
		0, -- [12]
		8, -- [13]
		0, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[118908] = {
		"Pit Fighter's Punching Ring", -- [1]
		"|cffa335ee|Hitem:118908::::::::60:102:::::::|h[Pit Fighter's Punching Ring]|h|r", -- [2]
		4, -- [3]
		44, -- [4]
		40, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		1043909, -- [10]
		4000000, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		5, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[44314] = {
		"Scroll of Recall II", -- [1]
		"|cffffffff|Hitem:44314::::::::60:102:::::::|h[Scroll of Recall II]|h|r", -- [2]
		1, -- [3]
		17, -- [4]
		15, -- [5]
		"Consumable", -- [6]
		"Other", -- [7]
		20, -- [8]
		"", -- [9]
		237447, -- [10]
		37, -- [11]
		0, -- [12]
		8, -- [13]
		0, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[18149] = {
		"Rune of Recall", -- [1]
		"|cff1eff00|Hitem:18149::::::::60:102:::::::|h[Rune of Recall]|h|r", -- [2]
		2, -- [3]
		25, -- [4]
		0, -- [5]
		"Quest", -- [6]
		"Quest", -- [7]
		1, -- [8]
		"", -- [9]
		134418, -- [10]
		0, -- [11]
		12, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[95050] = {
		"The Brassiest Knuckle", -- [1]
		"|cffa335ee|Hitem:95050::::::::60:102:::::::|h[The Brassiest Knuckle]|h|r", -- [2]
		4, -- [3]
		39, -- [4]
		35, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133345, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		4, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[17902] = {
		"Stormpike Insignia Rank 4", -- [1]
		"|cff0070dd|Hitem:17902::::::::60:102:::::::|h[Stormpike Insignia Rank 4]|h|r", -- [2]
		3, -- [3]
		29, -- [4]
		0, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TRINKET", -- [9]
		133431, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[17906] = {
		"Frostwolf Insignia Rank 3", -- [1]
		"|cff1eff00|Hitem:17906::::::::60:102:::::::|h[Frostwolf Insignia Rank 3]|h|r", -- [2]
		2, -- [3]
		29, -- [4]
		0, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TRINKET", -- [9]
		133284, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[128503] = {
		"Master Hunter's Seeking Crystal", -- [1]
		"|cffa335ee|Hitem:128503::::::::60:102:::::::|h[Master Hunter's Seeking Crystal]|h|r", -- [2]
		4, -- [3]
		40, -- [4]
		1, -- [5]
		"Consumable", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		1020388, -- [10]
		0, -- [11]
		0, -- [12]
		8, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[162973] = {
		"Greatfather Winter's Hearthstone", -- [1]
		"|cff0070dd|Hitem:162973::::::::60:102:::::::|h[Greatfather Winter's Hearthstone]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		2124576, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[40585] = {
		"Signet of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:40585::::::::60:102:::::::|h[Signet of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		35, -- [4]
		30, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133415, -- [10]
		2125, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[51558] = {
		"Runed Loop of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:51558::::::::60:102:::::::|h[Runed Loop of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		35, -- [4]
		30, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133415, -- [10]
		31250, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[17691] = {
		"Stormpike Insignia Rank 1", -- [1]
		"|cff1eff00|Hitem:17691::::::::60:102:::::::|h[Stormpike Insignia Rank 1]|h|r", -- [2]
		2, -- [3]
		29, -- [4]
		0, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TRINKET", -- [9]
		133429, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[144391] = {
		"Pugilist's Powerful Punching Ring", -- [1]
		"|cffa335ee|Hitem:144391::::::::60:102:::::::|h[Pugilist's Powerful Punching Ring]|h|r", -- [2]
		4, -- [3]
		50, -- [4]
		45, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		1043910, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[95051] = {
		"The Brassiest Knuckle", -- [1]
		"|cffa335ee|Hitem:95051::::::::60:102:::::::|h[The Brassiest Knuckle]|h|r", -- [2]
		4, -- [3]
		39, -- [4]
		35, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133345, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		4, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[18986] = {
		"Ultrasafe Transporter: Gadgetzan", -- [1]
		"|cff0070dd|Hitem:18986::::::::60:102:::::::|h[Ultrasafe Transporter: Gadgetzan]|h|r", -- [2]
		3, -- [3]
		25, -- [4]
		0, -- [5]
		"Consumable", -- [6]
		"Explosives and Devices", -- [7]
		1, -- [8]
		"", -- [9]
		133870, -- [10]
		5000, -- [11]
		0, -- [12]
		0, -- [13]
		3, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[63352] = {
		"Shroud of Cooperation", -- [1]
		"|cff1eff00|Hitem:63352::::::::60:102:::::::|h[Shroud of Cooperation]|h|r", -- [2]
		2, -- [3]
		20, -- [4]
		15, -- [5]
		"Armor", -- [6]
		"Cloth", -- [7]
		1, -- [8]
		"INVTYPE_CLOAK", -- [9]
		461810, -- [10]
		375000, -- [11]
		4, -- [12]
		1, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[6948] = {
		"Hearthstone", -- [1]
		"|cffffffff|Hitem:6948::::::::60:102:::::::|h[Hearthstone]|h|r", -- [2]
		1, -- [3]
		1, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		134414, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[142543] = {
		"Scroll of Town Portal", -- [1]
		"|cff0070dd|Hitem:142543::::::::60:102:::::::|h[Scroll of Town Portal]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		1, -- [5]
		"Consumable", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		1529349, -- [10]
		0, -- [11]
		0, -- [12]
		8, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[144392] = {
		"Pugilist's Powerful Punching Ring", -- [1]
		"|cffa335ee|Hitem:144392::::::::60:102:::::::|h[Pugilist's Powerful Punching Ring]|h|r", -- [2]
		4, -- [3]
		50, -- [4]
		45, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		1043910, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[141014] = {
		"Scroll of Town Portal: Sashj'tar", -- [1]
		"|cff1eff00|Hitem:141014::::::::60:102:::::::|h[Scroll of Town Portal: Sashj'tar]|h|r", -- [2]
		2, -- [3]
		45, -- [4]
		45, -- [5]
		"Consumable", -- [6]
		"Other", -- [7]
		5, -- [8]
		"", -- [9]
		237018, -- [10]
		0, -- [11]
		0, -- [12]
		8, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[44315] = {
		"Scroll of Recall III", -- [1]
		"|cffffffff|Hitem:44315::::::::60:102:::::::|h[Scroll of Recall III]|h|r", -- [2]
		1, -- [3]
		27, -- [4]
		26, -- [5]
		"Consumable", -- [6]
		"Other", -- [7]
		20, -- [8]
		"", -- [9]
		237451, -- [10]
		37, -- [11]
		0, -- [12]
		8, -- [13]
		0, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[141015] = {
		"Scroll of Town Portal: Kal'delar", -- [1]
		"|cff1eff00|Hitem:141015::::::::60:102:::::::|h[Scroll of Town Portal: Kal'delar]|h|r", -- [2]
		2, -- [3]
		45, -- [4]
		45, -- [5]
		"Consumable", -- [6]
		"Other", -- [7]
		5, -- [8]
		"", -- [9]
		237020, -- [10]
		0, -- [11]
		0, -- [12]
		8, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[40586] = {
		"Band of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:40586::::::::60:102:::::::|h[Band of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		35, -- [4]
		30, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133416, -- [10]
		2125, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[51559] = {
		"Runed Ring of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:51559::::::::60:102:::::::|h[Runed Ring of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		35, -- [4]
		30, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133416, -- [10]
		31250, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[141016] = {
		"Scroll of Town Portal: Faronaar", -- [1]
		"|cff1eff00|Hitem:141016::::::::60:102:::::::|h[Scroll of Town Portal: Faronaar]|h|r", -- [2]
		2, -- [3]
		45, -- [4]
		45, -- [5]
		"Consumable", -- [6]
		"Other", -- [7]
		5, -- [8]
		"", -- [9]
		237448, -- [10]
		0, -- [11]
		0, -- [12]
		8, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[110560] = {
		"Garrison Hearthstone", -- [1]
		"|cffffffff|Hitem:110560::::::::60:102:::::::|h[Garrison Hearthstone]|h|r", -- [2]
		1, -- [3]
		35, -- [4]
		10, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		1041860, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		5, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[168907] = {
		"Holographic Digitalization Hearthstone", -- [1]
		"|cff0070dd|Hitem:168907::::::::60:102:::::::|h[Holographic Digitalization Hearthstone]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		2491049, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		7, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[63353] = {
		"Shroud of Cooperation", -- [1]
		"|cff1eff00|Hitem:63353::::::::60:102:::::::|h[Shroud of Cooperation]|h|r", -- [2]
		2, -- [3]
		20, -- [4]
		15, -- [5]
		"Armor", -- [6]
		"Cloth", -- [7]
		1, -- [8]
		"INVTYPE_CLOAK", -- [9]
		461813, -- [10]
		375000, -- [11]
		4, -- [12]
		1, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[141017] = {
		"Scroll of Town Portal: Lian'tril", -- [1]
		"|cff1eff00|Hitem:141017::::::::60:102:::::::|h[Scroll of Town Portal: Lian'tril]|h|r", -- [2]
		2, -- [3]
		45, -- [4]
		45, -- [5]
		"Consumable", -- [6]
		"Other", -- [7]
		5, -- [8]
		"", -- [9]
		237447, -- [10]
		0, -- [11]
		0, -- [12]
		8, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[54452] = {
		"Ethereal Portal", -- [1]
		"|cff0070dd|Hitem:54452::::::::60:102:::::::|h[Ethereal Portal]|h|r", -- [2]
		3, -- [3]
		27, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		236222, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[119183] = {
		"Scroll of Risky Recall", -- [1]
		"|cff1eff00|Hitem:119183::::::::60:102:::::::|h[Scroll of Risky Recall]|h|r", -- [2]
		2, -- [3]
		40, -- [4]
		40, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		134943, -- [10]
		0, -- [11]
		15, -- [12]
		4, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[153226] = {
		"Observer's Locus Resonator", -- [1]
		"|cffffffff|Hitem:153226::::::::60:102:::::::|h[Observer's Locus Resonator]|h|r", -- [2]
		1, -- [3]
		1, -- [4]
		1, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		1405817, -- [10]
		0, -- [11]
		15, -- [12]
		4, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[46874] = {
		"Argent Crusader's Tabard", -- [1]
		"|cff0070dd|Hitem:46874::::::::60:102:::::::|h[Argent Crusader's Tabard]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TABARD", -- [9]
		135026, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[18150] = {
		"Rune of Recall", -- [1]
		"|cff1eff00|Hitem:18150::::::::60:102:::::::|h[Rune of Recall]|h|r", -- [2]
		2, -- [3]
		25, -- [4]
		0, -- [5]
		"Quest", -- [6]
		"Quest", -- [7]
		1, -- [8]
		"", -- [9]
		134421, -- [10]
		0, -- [11]
		12, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[17903] = {
		"Stormpike Insignia Rank 5", -- [1]
		"|cff0070dd|Hitem:17903::::::::60:102:::::::|h[Stormpike Insignia Rank 5]|h|r", -- [2]
		3, -- [3]
		29, -- [4]
		0, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TRINKET", -- [9]
		133432, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[17907] = {
		"Frostwolf Insignia Rank 4", -- [1]
		"|cff0070dd|Hitem:17907::::::::60:102:::::::|h[Frostwolf Insignia Rank 4]|h|r", -- [2]
		3, -- [3]
		29, -- [4]
		0, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TRINKET", -- [9]
		133285, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[65274] = {
		"Cloak of Coordination", -- [1]
		"|cffa335ee|Hitem:65274::::::::60:102:::::::|h[Cloak of Coordination]|h|r", -- [2]
		4, -- [3]
		29, -- [4]
		15, -- [5]
		"Armor", -- [6]
		"Cloth", -- [7]
		1, -- [8]
		"INVTYPE_CLOAK", -- [9]
		461815, -- [10]
		1250000, -- [11]
		4, -- [12]
		1, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[163045] = {
		"Headless Horseman's Hearthstone", -- [1]
		"|cff0070dd|Hitem:163045::::::::60:102:::::::|h[Headless Horseman's Hearthstone]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		2124575, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[87548] = {
		"Lorewalker's Lodestone", -- [1]
		"|cff1eff00|Hitem:87548::::::::60:102:::::::|h[Lorewalker's Lodestone]|h|r", -- [2]
		2, -- [3]
		1, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		20, -- [8]
		"", -- [9]
		135248, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[51560] = {
		"Runed Band of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:51560::::::::60:102:::::::|h[Runed Band of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		35, -- [4]
		30, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133416, -- [10]
		31250, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[32757] = {
		"Blessed Medallion of Karabor", -- [1]
		"|cffa335ee|Hitem:32757::::::::60:102:::::::|h[Blessed Medallion of Karabor]|h|r", -- [2]
		4, -- [3]
		32, -- [4]
		0, -- [5]
		"Quest", -- [6]
		"Quest", -- [7]
		1, -- [8]
		"INVTYPE_NECK", -- [9]
		133279, -- [10]
		0, -- [11]
		12, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[140192] = {
		"Dalaran Hearthstone", -- [1]
		"|cffffffff|Hitem:140192::::::::60:102:::::::|h[Dalaran Hearthstone]|h|r", -- [2]
		1, -- [3]
		35, -- [4]
		10, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		1444943, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[63378] = {
		"Hellscream's Reach Tabard", -- [1]
		"|cff0070dd|Hitem:63378::::::::60:102:::::::|h[Hellscream's Reach Tabard]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TABARD", -- [9]
		456571, -- [10]
		1, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[22589] = {
		"Atiesh, Greatstaff of the Guardian", -- [1]
		"|cffff8000|Hitem:22589::::::::60:102:::::::|h[Atiesh, Greatstaff of the Guardian]|h|r", -- [2]
		5, -- [3]
		30, -- [4]
		0, -- [5]
		"Weapon", -- [6]
		"Staves", -- [7]
		1, -- [8]
		"INVTYPE_2HWEAPON", -- [9]
		135226, -- [10]
		50695, -- [11]
		2, -- [12]
		10, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[103678] = {
		"Time-Lost Artifact", -- [1]
		"|cffa335ee|Hitem:103678::::::::60:102:::::::|h[Time-Lost Artifact]|h|r", -- [2]
		4, -- [3]
		39, -- [4]
		35, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TRINKET", -- [9]
		643915, -- [10]
		1, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		4, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[48955] = {
		"Etched Loop of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:48955::::::::60:102:::::::|h[Etched Loop of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		35, -- [4]
		30, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133415, -- [10]
		31250, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[87215] = {
		"Wormhole Generator: Pandaria", -- [1]
		"|cff0070dd|Hitem:87215::::::::60:102:::::::|h[Wormhole Generator: Pandaria]|h|r", -- [2]
		3, -- [3]
		35, -- [4]
		29, -- [5]
		"Consumable", -- [6]
		"Explosives and Devices", -- [7]
		1, -- [8]
		"", -- [9]
		651094, -- [10]
		5000, -- [11]
		0, -- [12]
		0, -- [13]
		3, -- [14]
		4, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[30542] = {
		"Dimensional Ripper - Area 52", -- [1]
		"|cff0070dd|Hitem:30542::::::::60:102:::::::|h[Dimensional Ripper - Area 52]|h|r", -- [2]
		3, -- [3]
		27, -- [4]
		0, -- [5]
		"Consumable", -- [6]
		"Explosives and Devices", -- [7]
		1, -- [8]
		"", -- [9]
		133865, -- [10]
		5000, -- [11]
		0, -- [12]
		0, -- [13]
		3, -- [14]
		1, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[45688] = {
		"Inscribed Band of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:45688::::::::60:102:::::::|h[Inscribed Band of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		35, -- [4]
		30, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133416, -- [10]
		31250, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[166747] = {
		"Brewfest Reveler's Hearthstone", -- [1]
		"|cff0070dd|Hitem:166747::::::::60:102:::::::|h[Brewfest Reveler's Hearthstone]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		2491063, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[116413] = {
		"Scroll of Town Portal", -- [1]
		"|cffffffff|Hitem:116413::::::::60:102:::::::|h[Scroll of Town Portal]|h|r", -- [2]
		1, -- [3]
		40, -- [4]
		40, -- [5]
		"Consumable", -- [6]
		"Other", -- [7]
		5, -- [8]
		"", -- [9]
		134943, -- [10]
		0, -- [11]
		0, -- [12]
		8, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[139590] = {
		"Scroll of Teleport: Ravenholdt", -- [1]
		"|cff0070dd|Hitem:139590::::::::60:102:::::::|h[Scroll of Teleport: Ravenholdt]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		10, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		134941, -- [10]
		0, -- [11]
		15, -- [12]
		4, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[95567] = {
		"Kirin Tor Beacon", -- [1]
		"|cffffffff|Hitem:95567::::::::60:102:::::::|h[Kirin Tor Beacon]|h|r", -- [2]
		1, -- [3]
		35, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		801132, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		4, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[136849] = {
		"Nature's Beacon", -- [1]
		"|cff0070dd|Hitem:136849::::::::60:102:::::::|h[Nature's Beacon]|h|r", -- [2]
		3, -- [3]
		45, -- [4]
		7, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		236160, -- [10]
		125000, -- [11]
		15, -- [12]
		4, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[37863] = {
		"Direbrew's Remote", -- [1]
		"|cff0070dd|Hitem:37863::::::::60:102:::::::|h[Direbrew's Remote]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Consumable", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		133015, -- [10]
		0, -- [11]
		0, -- [12]
		8, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[63379] = {
		"Baradin's Wardens Tabard", -- [1]
		"|cff0070dd|Hitem:63379::::::::60:102:::::::|h[Baradin's Wardens Tabard]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TABARD", -- [9]
		456564, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[140324] = {
		"Mobile Telemancy Beacon", -- [1]
		"|cff0070dd|Hitem:140324::::::::60:102:::::::|h[Mobile Telemancy Beacon]|h|r", -- [2]
		3, -- [3]
		45, -- [4]
		1, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		237445, -- [10]
		750000, -- [11]
		15, -- [12]
		4, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[144341] = {
		"Rechargeable Reaves Battery", -- [1]
		"|cff0070dd|Hitem:144341::::::::60:102:::::::|h[Rechargeable Reaves Battery]|h|r", -- [2]
		3, -- [3]
		45, -- [4]
		0, -- [5]
		"Consumable", -- [6]
		"Explosives and Devices", -- [7]
		1, -- [8]
		"", -- [9]
		1405815, -- [10]
		87500, -- [11]
		0, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[43824] = {
		"The Schools of Arcane Magic - Mastery", -- [1]
		"|cff0070dd|Hitem:43824::::::::60:102:::::::|h[The Schools of Arcane Magic - Mastery]|h|r", -- [2]
		3, -- [3]
		30, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		133743, -- [10]
		0, -- [11]
		15, -- [12]
		4, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[95568] = {
		"Sunreaver Beacon", -- [1]
		"|cffffffff|Hitem:95568::::::::60:102:::::::|h[Sunreaver Beacon]|h|r", -- [2]
		1, -- [3]
		35, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		838819, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		4, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[17904] = {
		"Stormpike Insignia Rank 6", -- [1]
		"|cffa335ee|Hitem:17904::::::::60:102:::::::|h[Stormpike Insignia Rank 6]|h|r", -- [2]
		4, -- [3]
		29, -- [4]
		0, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TRINKET", -- [9]
		133433, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[17908] = {
		"Frostwolf Insignia Rank 5", -- [1]
		"|cff0070dd|Hitem:17908::::::::60:102:::::::|h[Frostwolf Insignia Rank 5]|h|r", -- [2]
		3, -- [3]
		29, -- [4]
		0, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TRINKET", -- [9]
		133286, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[48956] = {
		"Etched Ring of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:48956::::::::60:102:::::::|h[Etched Ring of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		35, -- [4]
		30, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133416, -- [10]
		31250, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[166559] = {
		"Commander's Signet of Battle", -- [1]
		"|cffa335ee|Hitem:166559::::::::60:102:::::::|h[Commander's Signet of Battle]|h|r", -- [2]
		4, -- [3]
		70, -- [4]
		50, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		804962, -- [10]
		478832, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		7, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[45689] = {
		"Inscribed Loop of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:45689::::::::60:102:::::::|h[Inscribed Loop of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		35, -- [4]
		30, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133415, -- [10]
		31250, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[50287] = {
		"Boots of the Bay", -- [1]
		"|cff0070dd|Hitem:50287::::::::60:102:::::::|h[Boots of the Bay]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FEET", -- [9]
		132578, -- [10]
		1, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[166560] = {
		"Captain's Signet of Command", -- [1]
		"|cffa335ee|Hitem:166560::::::::60:102:::::::|h[Captain's Signet of Command]|h|r", -- [2]
		4, -- [3]
		70, -- [4]
		50, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		804960, -- [10]
		480545, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		7, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[58487] = {
		"Potion of Deepholm", -- [1]
		"|cffffffff|Hitem:58487::::::::60:102:::::::|h[Potion of Deepholm]|h|r", -- [2]
		1, -- [3]
		31, -- [4]
		31, -- [5]
		"Consumable", -- [6]
		"Potion", -- [7]
		20, -- [8]
		"", -- [9]
		463898, -- [10]
		5000, -- [11]
		0, -- [12]
		1, -- [13]
		0, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[18984] = {
		"Dimensional Ripper - Everlook", -- [1]
		"|cff0070dd|Hitem:18984::::::::60:102:::::::|h[Dimensional Ripper - Everlook]|h|r", -- [2]
		3, -- [3]
		25, -- [4]
		0, -- [5]
		"Consumable", -- [6]
		"Explosives and Devices", -- [7]
		1, -- [8]
		"", -- [9]
		133873, -- [10]
		5000, -- [11]
		0, -- [12]
		0, -- [13]
		3, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[160218] = {
		"Portal Scroll of Specificity", -- [1]
		"|cff0070dd|Hitem:160218::::::::60:102:::::::|h[Portal Scroll of Specificity]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		1, -- [5]
		"Consumable", -- [6]
		"Other", -- [7]
		5, -- [8]
		"", -- [9]
		1392955, -- [10]
		0, -- [11]
		0, -- [12]
		8, -- [13]
		1, -- [14]
		7, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[118663] = {
		"Relic of Karabor", -- [1]
		"|cffa335ee|Hitem:118663::::::::60:102:::::::|h[Relic of Karabor]|h|r", -- [2]
		4, -- [3]
		1, -- [4]
		40, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		133316, -- [10]
		6250000, -- [11]
		15, -- [12]
		4, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[138448] = {
		"Emblem of Margoss", -- [1]
		"|cff0070dd|Hitem:138448::::::::60:102:::::::|h[Emblem of Margoss]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		237560, -- [10]
		0, -- [11]
		15, -- [12]
		4, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[64488] = {
		"The Innkeeper's Daughter", -- [1]
		"|cff0070dd|Hitem:64488::::::::60:102:::::::|h[The Innkeeper's Daughter]|h|r", -- [2]
		3, -- [3]
		32, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		458254, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[165670] = {
		"Peddlefeet's Lovely Hearthstone", -- [1]
		"|cff0070dd|Hitem:165670::::::::60:102:::::::|h[Peddlefeet's Lovely Hearthstone]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		2491048, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[157542] = {
		"Portal Scroll of Specificity", -- [1]
		"|cff0070dd|Hitem:157542::::::::60:102:::::::|h[Portal Scroll of Specificity]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		1, -- [5]
		"Consumable", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		1392955, -- [10]
		0, -- [11]
		0, -- [12]
		8, -- [13]
		1, -- [14]
		7, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[48957] = {
		"Etched Signet of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:48957::::::::60:102:::::::|h[Etched Signet of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		35, -- [4]
		30, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133415, -- [10]
		31250, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[162515] = {
		"Midnight Salmon", -- [1]
		"|cff1eff00|Hitem:162515::::::::60:102:::::::|h[Midnight Salmon]|h|r", -- [2]
		2, -- [3]
		50, -- [4]
		0, -- [5]
		"Tradeskill", -- [6]
		"Other", -- [7]
		200, -- [8]
		"", -- [9]
		237302, -- [10]
		625, -- [11]
		7, -- [12]
		11, -- [13]
		0, -- [14]
		7, -- [15]
		nil, -- [16]
		true, -- [17]
	},
	[117389] = {
		"Draenor Archaeologist's Lodestone", -- [1]
		"|cff1eff00|Hitem:117389::::::::60:102:::::::|h[Draenor Archaeologist's Lodestone]|h|r", -- [2]
		2, -- [3]
		1, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		20, -- [8]
		"", -- [9]
		135248, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[181163] = {
		"Scroll of Teleport: Theater of Pain", -- [1]
		"|cffffffff|Hitem:181163::::::::60:102:::::::|h[Scroll of Teleport: Theater of Pain]|h|r", -- [2]
		1, -- [3]
		1, -- [4]
		0, -- [5]
		"Consumable", -- [6]
		"Explosives and Devices", -- [7]
		1, -- [8]
		"", -- [9]
		134943, -- [10]
		25000, -- [11]
		0, -- [12]
		0, -- [13]
		1, -- [14]
		7, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[167075] = {
		"Ultrasafe Transporter: Mechagon", -- [1]
		"|cffffffff|Hitem:167075::::::::60:102:::::::|h[Ultrasafe Transporter: Mechagon]|h|r", -- [2]
		1, -- [3]
		1, -- [4]
		0, -- [5]
		"Consumable", -- [6]
		"Explosives and Devices", -- [7]
		100, -- [8]
		"", -- [9]
		986487, -- [10]
		1, -- [11]
		0, -- [12]
		0, -- [13]
		1, -- [14]
		7, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[139599] = {
		"Empowered Ring of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:139599::::::::60:102:::::::|h[Empowered Ring of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		50, -- [4]
		40, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133415, -- [10]
		31250, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[132523] = {
		"Reaves Battery", -- [1]
		"|cff1eff00|Hitem:132523::::::::60:102:::::::|h[Reaves Battery]|h|r", -- [2]
		2, -- [3]
		42, -- [4]
		0, -- [5]
		"Consumable", -- [6]
		"Explosives and Devices", -- [7]
		20, -- [8]
		"", -- [9]
		1405815, -- [10]
		875, -- [11]
		0, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[64457] = {
		"The Last Relic of Argus", -- [1]
		"|cff0070dd|Hitem:64457::::::::60:102:::::::|h[The Last Relic of Argus]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		458240, -- [10]
		0, -- [11]
		15, -- [12]
		4, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[63206] = {
		"Wrap of Unity", -- [1]
		"|cff0070dd|Hitem:63206::::::::60:102:::::::|h[Wrap of Unity]|h|r", -- [2]
		3, -- [3]
		20, -- [4]
		15, -- [5]
		"Armor", -- [6]
		"Cloth", -- [7]
		1, -- [8]
		"INVTYPE_CLOAK", -- [9]
		461811, -- [10]
		750000, -- [11]
		4, -- [12]
		1, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[17901] = {
		"Stormpike Insignia Rank 3", -- [1]
		"|cff1eff00|Hitem:17901::::::::60:102:::::::|h[Stormpike Insignia Rank 3]|h|r", -- [2]
		2, -- [3]
		29, -- [4]
		0, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TRINKET", -- [9]
		133430, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[142469] = {
		"Violet Seal of the Grand Magus", -- [1]
		"|cffa335ee|Hitem:142469::::::::60:102:::::::|h[Violet Seal of the Grand Magus]|h|r", -- [2]
		4, -- [3]
		50, -- [4]
		45, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		1391739, -- [10]
		20, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[17909] = {
		"Frostwolf Insignia Rank 6", -- [1]
		"|cffa335ee|Hitem:17909::::::::60:102:::::::|h[Frostwolf Insignia Rank 6]|h|r", -- [2]
		4, -- [3]
		29, -- [4]
		0, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TRINKET", -- [9]
		133287, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[140493] = {
		"Adept's Guide to Dimensional Rifting", -- [1]
		"|cff0070dd|Hitem:140493::::::::60:102:::::::|h[Adept's Guide to Dimensional Rifting]|h|r", -- [2]
		3, -- [3]
		45, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		134917, -- [10]
		1, -- [11]
		15, -- [12]
		4, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[165802] = {
		"Noble Gardener's Hearthstone", -- [1]
		"|cff0070dd|Hitem:165802::::::::60:102:::::::|h[Noble Gardener's Hearthstone]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		2491065, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[45691] = {
		"Inscribed Signet of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:45691::::::::60:102:::::::|h[Inscribed Signet of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		35, -- [4]
		30, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133415, -- [10]
		31250, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[44934] = {
		"Loop of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:44934::::::::60:102:::::::|h[Loop of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		35, -- [4]
		30, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133415, -- [10]
		2125, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[17690] = {
		"Frostwolf Insignia Rank 1", -- [1]
		"|cff1eff00|Hitem:17690::::::::60:102:::::::|h[Frostwolf Insignia Rank 1]|h|r", -- [2]
		2, -- [3]
		29, -- [4]
		0, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TRINKET", -- [9]
		133283, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[45690] = {
		"Inscribed Ring of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:45690::::::::60:102:::::::|h[Inscribed Ring of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		35, -- [4]
		30, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133416, -- [10]
		31250, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[17905] = {
		"Frostwolf Insignia Rank 2", -- [1]
		"|cff1eff00|Hitem:17905::::::::60:102:::::::|h[Frostwolf Insignia Rank 2]|h|r", -- [2]
		2, -- [3]
		29, -- [4]
		0, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TRINKET", -- [9]
		133283, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[129929] = {
		"Ever-Shifting Mirror", -- [1]
		"|cff0070dd|Hitem:129929::::::::60:102:::::::|h[Ever-Shifting Mirror]|h|r", -- [2]
		3, -- [3]
		40, -- [4]
		40, -- [5]
		"Miscellaneous", -- [6]
		"Holiday", -- [7]
		1, -- [8]
		"", -- [9]
		458243, -- [10]
		0, -- [11]
		15, -- [12]
		3, -- [13]
		1, -- [14]
		1, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[168807] = {
		"Wormhole Generator: Kul Tiras", -- [1]
		"|cff0070dd|Hitem:168807::::::::60:102:::::::|h[Wormhole Generator: Kul Tiras]|h|r", -- [2]
		3, -- [3]
		50, -- [4]
		45, -- [5]
		"Consumable", -- [6]
		"Explosives and Devices", -- [7]
		1, -- [8]
		"", -- [9]
		2000841, -- [10]
		5000, -- [11]
		0, -- [12]
		0, -- [13]
		3, -- [14]
		7, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[28585] = {
		"Ruby Slippers", -- [1]
		"|cffa335ee|Hitem:28585::::::::60:102:::::::|h[Ruby Slippers]|h|r", -- [2]
		4, -- [3]
		32, -- [4]
		27, -- [5]
		"Armor", -- [6]
		"Cloth", -- [7]
		1, -- [8]
		"INVTYPE_FEET", -- [9]
		132566, -- [10]
		36045, -- [11]
		4, -- [12]
		1, -- [13]
		1, -- [14]
		1, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[48933] = {
		"Wormhole Generator: Northrend", -- [1]
		"|cff0070dd|Hitem:48933::::::::60:102:::::::|h[Wormhole Generator: Northrend]|h|r", -- [2]
		3, -- [3]
		30, -- [4]
		24, -- [5]
		"Consumable", -- [6]
		"Explosives and Devices", -- [7]
		1, -- [8]
		"", -- [9]
		135778, -- [10]
		5000, -- [11]
		0, -- [12]
		0, -- [13]
		3, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[180817] = {
		"Cypher of Relocation", -- [1]
		"|cffffffff|Hitem:180817::::::::60:102:::::::|h[Cypher of Relocation]|h|r", -- [2]
		1, -- [3]
		60, -- [4]
		0, -- [5]
		"Quest", -- [6]
		"Quest", -- [7]
		1, -- [8]
		"", -- [9]
		442739, -- [10]
		0, -- [11]
		12, -- [12]
		0, -- [13]
		1, -- [14]
		8, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[172179] = {
		"Eternal Traveler's Hearthstone", -- [1]
		"|cff0070dd|Hitem:172179::::::::60:102:::::::|h[Eternal Traveler's Hearthstone]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		3084684, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[165581] = {
		"Crest of Pa'ku", -- [1]
		"|cffa335ee|Hitem:165581::::::::60:102:::::::|h[Crest of Pa'ku]|h|r", -- [2]
		4, -- [3]
		60, -- [4]
		50, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TRINKET", -- [9]
		2103844, -- [10]
		635963, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		7, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[168808] = {
		"Wormhole Generator: Zandalar", -- [1]
		"|cff0070dd|Hitem:168808::::::::60:102:::::::|h[Wormhole Generator: Zandalar]|h|r", -- [2]
		3, -- [3]
		50, -- [4]
		45, -- [5]
		"Consumable", -- [6]
		"Explosives and Devices", -- [7]
		1, -- [8]
		"", -- [9]
		2000840, -- [10]
		5000, -- [11]
		0, -- [12]
		0, -- [13]
		3, -- [14]
		7, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[22630] = {
		"Atiesh, Greatstaff of the Guardian", -- [1]
		"|cffff8000|Hitem:22630::::::::60:102:::::::|h[Atiesh, Greatstaff of the Guardian]|h|r", -- [2]
		5, -- [3]
		30, -- [4]
		0, -- [5]
		"Weapon", -- [6]
		"Staves", -- [7]
		1, -- [8]
		"INVTYPE_2HWEAPON", -- [9]
		135226, -- [10]
		50860, -- [11]
		2, -- [12]
		10, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[151652] = {
		"Wormhole Generator: Argus", -- [1]
		"|cff0070dd|Hitem:151652::::::::60:102:::::::|h[Wormhole Generator: Argus]|h|r", -- [2]
		3, -- [3]
		45, -- [4]
		39, -- [5]
		"Consumable", -- [6]
		"Explosives and Devices", -- [7]
		1, -- [8]
		"", -- [9]
		237560, -- [10]
		5000, -- [11]
		0, -- [12]
		0, -- [13]
		3, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[22632] = {
		"Atiesh, Greatstaff of the Guardian", -- [1]
		"|cffff8000|Hitem:22632::::::::60:102:::::::|h[Atiesh, Greatstaff of the Guardian]|h|r", -- [2]
		5, -- [3]
		30, -- [4]
		0, -- [5]
		"Weapon", -- [6]
		"Staves", -- [7]
		1, -- [8]
		"INVTYPE_2HWEAPON", -- [9]
		135226, -- [10]
		47650, -- [11]
		2, -- [12]
		10, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[52251] = {
		"Jaina's Locket", -- [1]
		"|cffa335ee|Hitem:52251::::::::60:102:::::::|h[Jaina's Locket]|h|r", -- [2]
		4, -- [3]
		30, -- [4]
		30, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		133308, -- [10]
		0, -- [11]
		15, -- [12]
		4, -- [13]
		3, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[172924] = {
		"Wormhole Generator: Shadowlands", -- [1]
		"|cff0070dd|Hitem:172924::::::::60:102:::::::|h[Wormhole Generator: Shadowlands]|h|r", -- [2]
		3, -- [3]
		60, -- [4]
		1, -- [5]
		"Consumable", -- [6]
		"Explosives and Devices", -- [7]
		1, -- [8]
		"", -- [9]
		3610528, -- [10]
		5000, -- [11]
		0, -- [12]
		0, -- [13]
		3, -- [14]
		8, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[21711] = {
		"Lunar Festival Invitation", -- [1]
		"|cffffffff|Hitem:21711::::::::60:102:::::::|h[Lunar Festival Invitation]|h|r", -- [2]
		1, -- [3]
		23, -- [4]
		1, -- [5]
		"Consumable", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		134941, -- [10]
		0, -- [11]
		0, -- [12]
		8, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[142298] = {
		"Astonishingly Scarlet Slippers", -- [1]
		"|cffa335ee|Hitem:142298::::::::60:102:::::::|h[Astonishingly Scarlet Slippers]|h|r", -- [2]
		4, -- [3]
		50, -- [4]
		40, -- [5]
		"Armor", -- [6]
		"Cloth", -- [7]
		1, -- [8]
		"INVTYPE_FEET", -- [9]
		1336642, -- [10]
		252322, -- [11]
		4, -- [12]
		1, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[63207] = {
		"Wrap of Unity", -- [1]
		"|cff0070dd|Hitem:63207::::::::60:102:::::::|h[Wrap of Unity]|h|r", -- [2]
		3, -- [3]
		20, -- [4]
		15, -- [5]
		"Armor", -- [6]
		"Cloth", -- [7]
		1, -- [8]
		"INVTYPE_CLOAK", -- [9]
		461814, -- [10]
		750000, -- [11]
		4, -- [12]
		1, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[166746] = {
		"Fire Eater's Hearthstone", -- [1]
		"|cff0070dd|Hitem:166746::::::::60:102:::::::|h[Fire Eater's Hearthstone]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		2491064, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[93672] = {
		"Dark Portal", -- [1]
		"|cff0070dd|Hitem:93672::::::::60:102:::::::|h[Dark Portal]|h|r", -- [2]
		3, -- [3]
		27, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		255348, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[141013] = {
		"Scroll of Town Portal: Shala'nir", -- [1]
		"|cff1eff00|Hitem:141013::::::::60:102:::::::|h[Scroll of Town Portal: Shala'nir]|h|r", -- [2]
		2, -- [3]
		45, -- [4]
		45, -- [5]
		"Consumable", -- [6]
		"Other", -- [7]
		5, -- [8]
		"", -- [9]
		237019, -- [10]
		0, -- [11]
		0, -- [12]
		8, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[22631] = {
		"Atiesh, Greatstaff of the Guardian", -- [1]
		"|cffff8000|Hitem:22631::::::::60:102:::::::|h[Atiesh, Greatstaff of the Guardian]|h|r", -- [2]
		5, -- [3]
		30, -- [4]
		0, -- [5]
		"Weapon", -- [6]
		"Staves", -- [7]
		1, -- [8]
		"INVTYPE_2HWEAPON", -- [9]
		135226, -- [10]
		47471, -- [11]
		2, -- [12]
		10, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[30544] = {
		"Ultrasafe Transporter: Toshley's Station", -- [1]
		"|cff0070dd|Hitem:30544::::::::60:102:::::::|h[Ultrasafe Transporter: Toshley's Station]|h|r", -- [2]
		3, -- [3]
		27, -- [4]
		0, -- [5]
		"Consumable", -- [6]
		"Explosives and Devices", -- [7]
		1, -- [8]
		"", -- [9]
		321487, -- [10]
		5000, -- [11]
		0, -- [12]
		0, -- [13]
		3, -- [14]
		1, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[151016] = {
		"Fractured Necrolyte Skull", -- [1]
		"|cff0070dd|Hitem:151016::::::::60:102:::::::|h[Fractured Necrolyte Skull]|h|r", -- [2]
		3, -- [3]
		27, -- [4]
		10, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		133731, -- [10]
		0, -- [11]
		15, -- [12]
		4, -- [13]
		1, -- [14]
		1, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[65360] = {
		"Cloak of Coordination", -- [1]
		"|cffa335ee|Hitem:65360::::::::60:102:::::::|h[Cloak of Coordination]|h|r", -- [2]
		4, -- [3]
		29, -- [4]
		15, -- [5]
		"Armor", -- [6]
		"Cloth", -- [7]
		1, -- [8]
		"INVTYPE_CLOAK", -- [9]
		461812, -- [10]
		1250000, -- [11]
		4, -- [12]
		1, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[128353] = {
		"Admiral's Compass", -- [1]
		"|cff0070dd|Hitem:128353::::::::60:102:::::::|h[Admiral's Compass]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		134234, -- [10]
		0, -- [11]
		15, -- [12]
		4, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[118907] = {
		"Pit Fighter's Punching Ring", -- [1]
		"|cffa335ee|Hitem:118907::::::::60:102:::::::|h[Pit Fighter's Punching Ring]|h|r", -- [2]
		4, -- [3]
		44, -- [4]
		40, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		1043909, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		5, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[51557] = {
		"Runed Signet of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:51557::::::::60:102:::::::|h[Runed Signet of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		35, -- [4]
		30, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133415, -- [10]
		31250, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[44935] = {
		"Ring of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:44935::::::::60:102:::::::|h[Ring of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		35, -- [4]
		30, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133416, -- [10]
		2125, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[165669] = {
		"Lunar Elder's Hearthstone", -- [1]
		"|cff0070dd|Hitem:165669::::::::60:102:::::::|h[Lunar Elder's Hearthstone]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Junk", -- [7]
		1, -- [8]
		"", -- [9]
		2491049, -- [10]
		0, -- [11]
		15, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[48954] = {
		"Etched Band of the Kirin Tor", -- [1]
		"|cffa335ee|Hitem:48954::::::::60:102:::::::|h[Etched Band of the Kirin Tor]|h|r", -- [2]
		4, -- [3]
		35, -- [4]
		30, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_FINGER", -- [9]
		133416, -- [10]
		31250, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		2, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[17900] = {
		"Stormpike Insignia Rank 2", -- [1]
		"|cff1eff00|Hitem:17900::::::::60:102:::::::|h[Stormpike Insignia Rank 2]|h|r", -- [2]
		2, -- [3]
		29, -- [4]
		0, -- [5]
		"Armor", -- [6]
		"Miscellaneous", -- [7]
		1, -- [8]
		"INVTYPE_TRINKET", -- [9]
		133429, -- [10]
		0, -- [11]
		4, -- [12]
		0, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[141605] = {
		"Flight Master's Whistle", -- [1]
		"|cff0070dd|Hitem:141605::::::::60:102:::::::|h[Flight Master's Whistle]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		1, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		132161, -- [10]
		0, -- [11]
		15, -- [12]
		4, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[142542] = {
		"Tome of Town Portal", -- [1]
		"|cff0070dd|Hitem:142542::::::::60:102:::::::|h[Tome of Town Portal]|h|r", -- [2]
		3, -- [3]
		1, -- [4]
		1, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		1529351, -- [10]
		0, -- [11]
		15, -- [12]
		4, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[118662] = {
		"Bladespire Relic", -- [1]
		"|cffa335ee|Hitem:118662::::::::60:102:::::::|h[Bladespire Relic]|h|r", -- [2]
		4, -- [3]
		1, -- [4]
		40, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		133283, -- [10]
		6250000, -- [11]
		15, -- [12]
		4, -- [13]
		1, -- [14]
		0, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[112059] = {
		"Wormhole Centrifuge", -- [1]
		"|cff0070dd|Hitem:112059::::::::60:102:::::::|h[Wormhole Centrifuge]|h|r", -- [2]
		3, -- [3]
		40, -- [4]
		34, -- [5]
		"Consumable", -- [6]
		"Explosives and Devices", -- [7]
		1, -- [8]
		"", -- [9]
		892831, -- [10]
		5000, -- [11]
		0, -- [12]
		0, -- [13]
		3, -- [14]
		5, -- [15]
		nil, -- [16]
		false, -- [17]
	},
	[129276] = {
		"Beginner's Guide to Dimensional Rifting", -- [1]
		"|cff0070dd|Hitem:129276::::::::60:102:::::::|h[Beginner's Guide to Dimensional Rifting]|h|r", -- [2]
		3, -- [3]
		45, -- [4]
		0, -- [5]
		"Miscellaneous", -- [6]
		"Other", -- [7]
		1, -- [8]
		"", -- [9]
		134915, -- [10]
		1250000, -- [11]
		15, -- [12]
		4, -- [13]
		1, -- [14]
		6, -- [15]
		nil, -- [16]
		false, -- [17]
	},
}

