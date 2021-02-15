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
		CreateItem(180290),				-- Night Fae Hearthstone
		CreateItem(182773),				-- Necrolord Hearthstone
		CreateItem(183716),				-- Venthyr Sinstone
		CreateItem(184353),				-- Kyrian Hearthstone
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
	LocZone("Ardenweald", 1565),
	{
		CreateConsumable(184503),	-- Attendant's Pocket Portal: Ardenweald
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
	LocZone("Bastion", 1533),
	{
		CreateConsumable(184500),	-- Attendant's Pocket Portal: Bastion
	})


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
	
-- TODO: Include destination in name
CreateDestination(
	"Hearth (Necrolord)",
	{
		CreateSpell(324547)		-- Hearth Kidneystone
	})

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
		CreateItem(181163),			-- Scroll of Teleport: Theater of Pain
		CreateConsumable(184502),	-- Attendant's Pocket Portal: Maldraxxus
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
		CreateConsumable(184504),	-- Attendant's Pocket Portal: Oribos
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
	LocZone("Revendreth", 1525),
	{
		CreateItem(184501),		-- 184501
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

----------------------------------------------------------------------------------
CreateDestination(
	"potions",		-- No localization.
	{
		CreateItem(5512),								-- 治療石
		CreateItem(177278),								-- 寧靜之瓶
    CreateItem(114124),								--幽靈藥水
    CreateItem(115531),								--迴旋艾斯蘭藥水
    CreateItem(116925),								--舊式的自由行動藥水
    CreateItem(118910),								--打鬥者的德拉諾敏捷藥水
    CreateItem(118911),								--打鬥者的德拉諾智力藥水
    CreateItem(118912),								--打鬥者的德拉諾力量藥水
    CreateItem(118913),								--打鬥者的無底德拉諾敏捷藥水
    CreateItem(118914),								--打鬥者的無底德拉諾智力藥水
    CreateItem(118915),								--打鬥者的無底德拉諾力量藥水
    CreateItem(127834),								--上古治療藥水
    CreateItem(127835),								--上古法力藥水
    CreateItem(127836),								--上古活力藥水 P
    CreateItem(127843),								--致命恩典藥水
    CreateItem(127844),								--遠古戰役藥水
    CreateItem(127845),								--不屈藥水
    CreateItem(127846),								--脈流藥水
    CreateItem(136569),								--陳年的生命藥水
    CreateItem(142117),								--持久之力藥水
    CreateItem(142325),								--打鬥者上古治療藥水
    CreateItem(142326),								--打鬥者持久之力藥水
    CreateItem(144396),								--悍勇治療藥水
    CreateItem(144397),								--悍勇護甲藥水
    CreateItem(144398),								--悍勇怒氣藥水
    CreateItem(152494),								--濱海治療藥水
    CreateItem(152495),								--濱海法力藥水
    CreateItem(152497),								--輕足藥水
    CreateItem(152503),								--隱身藥水
    CreateItem(152550),								--海霧藥水
    CreateItem(152557),								--鋼膚藥水
    CreateItem(152559),								--死亡湧升藥水
    CreateItem(152560),								--澎湃鮮血藥水
    CreateItem(152561),								--回復藥水
    CreateItem(152615),								--暗星治療藥水
    CreateItem(152619),								--暗星法力藥水
    CreateItem(163082),								--濱海回春藥水
    CreateItem(163222),								--智力戰鬥藥水
    CreateItem(163223),								--敏捷戰鬥藥水
    CreateItem(163224),								--力量戰鬥藥水
    CreateItem(163225),								--耐力戰鬥藥水
    CreateItem(167917),								--鬥陣濱海治療藥水
    CreateItem(167918),								--鬥陣力量戰鬥藥水
    CreateItem(167919),								--鬥陣敏捷戰鬥藥水
    CreateItem(167920),								--鬥陣智力戰鬥藥水
    CreateItem(168489),								--精良敏捷戰鬥藥水
    CreateItem(168498),								--精良智力戰鬥藥水
    CreateItem(168499),								--精良耐力戰鬥藥水
    CreateItem(168500),								--精良力量戰鬥藥水
    CreateItem(168501),								--精良鋼膚藥水
    CreateItem(168502),								--重組藥水
    CreateItem(168506),								--凝神決心藥水
    CreateItem(168529),								--地緣強化藥水
    CreateItem(169299),								--無盡狂怒藥水
    CreateItem(169300),								--野性癒合藥水
    CreateItem(169451),								--深淵治療藥水
    CreateItem(171263),								--靈魂純淨藥水
    CreateItem(171264),								--靈視藥水
    CreateItem(171266),								--魂隱藥水
    CreateItem(171267),								--鬼靈治療藥水
    CreateItem(171268),								--鬼靈法力藥水
    CreateItem(171269),								--鬼靈活力藥水
    CreateItem(171270),								--鬼靈敏捷藥水
    CreateItem(171271),								--堅實暗影藥水
    CreateItem(171272),								--鬼靈清晰藥水
    CreateItem(171273),								--鬼靈智力藥水
    CreateItem(171274),								--鬼靈耐力藥水
    CreateItem(171275),								--鬼靈力量藥水
    CreateItem(171349),								--魅影之火藥水
    CreateItem(171350),								--神性覺醒藥水
    CreateItem(171351),								--死亡凝視藥水
    CreateItem(171352),								--強力驅邪藥水
    CreateItem(171370),								--幽魂迅捷藥水
    CreateItem(176811),								--靈魄獻祭藥水
    CreateItem(183823),								--暢行無阻藥水
    CreateItem(184090),							 --導靈者之速藥水
	})

CreateDestination(
	"potionsShadowlands",		-- No localization.
	{
		CreateItem(5512),							 --治療石
    CreateItem(177278),							 -- 寧靜之瓶
    CreateItem(171263),							 --靈魂純淨藥水
    CreateItem(171264),							 --靈視藥水
    CreateItem(171266),							 --魂隱藥水
    CreateItem(171267),							 --鬼靈治療藥水
    CreateItem(171268),							 --鬼靈法力藥水
    CreateItem(171269),							 --鬼靈活力藥水
    CreateItem(171270),							 --鬼靈敏捷藥水
    CreateItem(171271),							 --堅實暗影藥水
    CreateItem(171272),							 --鬼靈清晰藥水
    CreateItem(171273),							 --鬼靈智力藥水
    CreateItem(171274),							 --鬼靈耐力藥水
    CreateItem(171275),							 --鬼靈力量藥水
    CreateItem(171349),							 --魅影之火藥水
    CreateItem(171350),							 --神性覺醒藥水
    CreateItem(171351),							 --死亡凝視藥水
    CreateItem(171352),							 --強力驅邪藥水
    CreateItem(171370),							 --幽魂迅捷藥水
    CreateItem(176811),							 --靈魄獻祭藥水
    CreateItem(183823),							 --暢行無阻藥水
    CreateItem(184090),							 --導靈者之速藥水
	})	

CreateDestination(
	"flasks",		-- No localization.
	{
		CreateItem(127847),							 --低語契約精煉藥劑
    CreateItem(127848),							 --七魔精煉藥劑
    CreateItem(127849),							 --無盡軍士精煉藥劑
    CreateItem(127850),							 --萬道傷痕精煉藥劑
    CreateItem(127858),							 --靈魂精煉藥劑
    CreateItem(152638),							 --洪流精煉藥劑
    CreateItem(152639),							 --無盡深淵精煉藥劑
    CreateItem(152640),							 --遼闊地平線精煉藥劑
    CreateItem(152641),							 --暗流精煉藥劑
    CreateItem(162518),							 --神秘精煉藥劑
    CreateItem(168651),							 --強效洪流精煉藥劑
    CreateItem(168652),							 --強效無盡深淵精煉藥劑
    CreateItem(168653),							 --強效遼闊地平線精煉藥劑
    CreateItem(168654),							 --強效暗流精煉藥劑
    CreateItem(168655),							 --強效神秘精煉藥劑
    CreateItem(171276),							 --鬼靈威力精煉藥劑
    CreateItem(171278),							 --鬼靈耐力精煉藥劑
    CreateItem(171280),							 -- --永恆精煉藥劑
	})	

CreateDestination(
	"flasksShadowlands",		-- Flasks added in Shadowlands (require level >= 50)
	{
    CreateItem(171276),							 --鬼靈威力精煉藥劑
    CreateItem(171278),							 --鬼靈耐力精煉藥劑
    CreateItem(171280),							 -- --永恆精煉藥劑
	})	

CreateDestination(
	"torghastItems",		-- 
	{
    CreateItem(168207),							 --掠奪的靈魄能量球
    CreateItem(170540),							 --飢餓的靈魄能量球
    CreateItem(184662),							 --被徵用的靈魄能量球
    CreateItem(176331),							 --精華掩蔽藥水
    CreateItem(176409),							 --活力虹吸精華
    CreateItem(176443),							 --消逝狂亂藥水
    CreateItem(168035),							 --淵喉污鼠韁繩
    CreateItem(170499),							 --淵喉巡者韁繩
    CreateItem(174464),							 --鬼靈鞍具
	})	
	
CreateDestination(
	"food",		-- Food (Crafted by cooking)
	{
    CreateItem(133557),							 --椒鹽火腿
    CreateItem(133561),							 --酥炸蘚鰓鱸魚
    CreateItem(133562),							 --醃漬風暴魟魚
    CreateItem(133563),							 --法隆納氣泡飲
    CreateItem(133564),							 --香料烤肋排
    CreateItem(133565),							 --脈燒肋排
    CreateItem(133566),							 --蘇拉瑪爾海陸大餐
    CreateItem(133567),							 --梭子魚莫古嘎古
    CreateItem(133568),							 --鯉香風暴魟魚
    CreateItem(133569),							 --卓格巴風味鮭魚
    CreateItem(133570),							 --飢腸盛宴
    CreateItem(133571),							 --艾薩拉沙拉
    CreateItem(133572),							 --夜裔精緻拼盤
    CreateItem(133573),							 --種籽風味炸魚盤
    CreateItem(133574),							 --魚卜魯特餐
    CreateItem(133575),							 --風乾鯖魚肉
    CreateItem(133576),							 --韃靼熊排
    CreateItem(133577),							 --戰士雜煮
    CreateItem(133578),							 --澎湃盛宴
    CreateItem(133579),							 --蘇拉瑪爾豪宴
    CreateItem(133681),							 --香脆培根
    CreateItem(142334),							 --香料龍隼煎蛋捲
    CreateItem(154881),							 --庫爾提拉米蘇
    CreateItem(154882),							 --蜜汁烤後腿
    CreateItem(154883),							 --鴉莓塔
    CreateItem(154884),							 --沼澤炸魚薯條
    CreateItem(154885),							 --蒙達吉
    CreateItem(154886),							 --香料笛鯛
    CreateItem(154887),							 --羅亞肉餅
    CreateItem(154889),							 --燒烤鯰魚
    CreateItem(154891),							 --調味腰內肉
    CreateItem(156525),							 --艦上盛宴
    CreateItem(156526),							 --豐盛的船長饗宴
    CreateItem(163781),							 --禍心巫術香腸
    CreateItem(165755),							 --蜂蜜餡餅
    CreateItem(166240),							 --血潤盛宴
    CreateItem(166343),							 --野莓麵包
    CreateItem(166344),							 --精心調味的肉排和馬鈴薯
    CreateItem(166804),							 --波拉勒斯血腸
    CreateItem(168310),							 --機當勞的「大機克」
    CreateItem(168312),							 --噴香燉魚
    CreateItem(168313),							 --烘焙港口薯
    CreateItem(168314),							 --比爾通肉乾
    CreateItem(168315),							 --超澎湃饗宴
    CreateItem(169280),							 --串烤鰻魚肉
    CreateItem(172040),							 --奶油糖醃製肋排
    CreateItem(172041),							 --刺鰭舒芙蕾佐炸物
    CreateItem(172042),							 --意外可口盛宴
    CreateItem(172043),							 --暴食享樂盛宴
    CreateItem(172044),							 --肉桂燉骨魚
    CreateItem(172045),							 --陰暗皇冠肉排凍
    CreateItem(172046),							 --魚子醬餅乾
    CreateItem(172047),							 --蜜糖鰤魚蛋糕
    CreateItem(172048),							 --肉餡蘋果餃子
    CreateItem(172049),							 --蘋果醬彩色餡餃
    CreateItem(172050),							 --蜜汁銀鰓香腸
    CreateItem(172051),							 --濃醬牛排
    CreateItem(172060),							 --靜謐魂食
    CreateItem(172061),							 --天使雞翅
    CreateItem(172062),							 --燉煮腿肉
    CreateItem(172063),							 --炸骨魚
    CreateItem(172068),							 --醃肉奶昔
    CreateItem(172069),							 --香蕉牛肉布丁
    CreateItem(184682),							 --特大號香檸魚排
	})	

CreateDestination(
	"foodShadowlands",		-- Food added in Shadowlands (Crafted by cooking)
	{
    CreateItem(172040),							 --奶油糖醃製肋排
    CreateItem(172041),							 --刺鰭舒芙蕾佐炸物
    CreateItem(172042),							 --意外可口盛宴
    CreateItem(172043),							 --暴食享樂盛宴
    CreateItem(172044),							 --肉桂燉骨魚
    CreateItem(172045),							 --陰暗皇冠肉排凍
    CreateItem(172046),							 --魚子醬餅乾
    CreateItem(172047),							 --蜜糖鰤魚蛋糕
    CreateItem(172048),							 --肉餡蘋果餃子
    CreateItem(172049),							 --蘋果醬彩色餡餃
    CreateItem(172050),							 --蜜汁銀鰓香腸
    CreateItem(172051),							 --濃醬牛排
    CreateItem(172060),							 --靜謐魂食
    CreateItem(172061),							 --天使雞翅
    CreateItem(172062),							 --燉煮腿肉
    CreateItem(172063),							 --炸骨魚
    CreateItem(172068),							 --醃肉奶昔
    CreateItem(172069),							 --香蕉牛肉布丁
    CreateItem(184682),							 --特大號香檸魚排
	})	

CreateDestination(
	"foodShadowlandsVendor",		-- Food sold by a vendor (Shadowlands)
	{
    CreateItem(173759),							 --糖霜亮皮
    CreateItem(173760),							 --銀莓雪糕
    CreateItem(173761),							 --糖衣光莓
    CreateItem(173762),							 --一瓶亞登露水
    CreateItem(173859),							 --靈體石榴
    CreateItem(174281),							 --淨化過的天泉水
    CreateItem(174282),							 --蓬鬆的巧巴達麵包
    CreateItem(174283),							 --冥魄湯
    CreateItem(174284),							 --秘天水果沙拉
    CreateItem(174285),							 --糖漬核桃
    CreateItem(177040),							 --安柏里亞露水
    CreateItem(178216),							 --燒烤沉睡菇
    CreateItem(178217),							 --蔚藍花茶
    CreateItem(178222),							 --蜜李派
    CreateItem(178223),							 --水煮絲行者卵
    CreateItem(178224),							 --清蒸果姆尾巴
    CreateItem(178225),							 --曠野獵者燉肉
    CreateItem(178226),							 --焦烤符文腹肉
    CreateItem(178227),							 --午夜星椒
    CreateItem(178228),							 --燉雪豌豆
    CreateItem(178247),							 --成熟的冬果
    CreateItem(178252),							 --一綑炬莓
    CreateItem(178534),							 --科比尼漿
    CreateItem(178535),							 --可疑的軟泥特調
    CreateItem(178536),							 --牛獸骨髓
    CreateItem(178537),							 --縛毛真菌
    CreateItem(178538),							 --甲蟲果昔
    CreateItem(178539),							 --溫熱牛獸奶
    CreateItem(178541),							 --烤髓骨
    CreateItem(178542),							 --顱骨特調
    CreateItem(178545),							 --骨蘋果茶
    CreateItem(178546),							 --可疑的肉品
    CreateItem(178547),							 --可疑的油炸禽類
    CreateItem(178548),							 --風味茶骨
    CreateItem(178549),							 --水煮肉
    CreateItem(178550),							 --陰暗松露
    CreateItem(178552),							 --血橘
    CreateItem(178900),							 --死亡胡椒腐肉
    CreateItem(179011),							 --蝙蝠肉麵包
    CreateItem(179012),							 --泥沼爬行者燉肉
    CreateItem(179013),							 --煙燻泥魚
    CreateItem(179014),							 --霜降吞食者肉排
    CreateItem(179015),							 --大蒜蜘蛛腿
    CreateItem(179016),							 --小屋乳酪
    CreateItem(179017),							 --綿羊奶酪
    CreateItem(179018),							 --骸豬肉排
    CreateItem(179019),							 --燒烤懼翼
    CreateItem(179020),							 --大蒜切片
    CreateItem(179021),							 --玫瑰甜椒
    CreateItem(179022),							 --清葉捲心菜
    CreateItem(179023),							 --大黃莖乾
    CreateItem(179025),							 --香米
    CreateItem(179026),							 --永夜麥片粥
    CreateItem(179166),							 --夜穫捲
    CreateItem(179267),							 --歿路沼澤白閃菇
    CreateItem(179268),							 --禍孽牛肝菌
    CreateItem(179269),							 --暮色杏仁慕斯
    CreateItem(179270),							 --影皮梅果
    CreateItem(179271),							 --掘息坑蘋果
    CreateItem(179272),							 --懼獵者的點心
    CreateItem(179273),							 --黑暗犬腰肉
    CreateItem(179274),							 --羔羊麵包
    CreateItem(179275),							 --捲心菜包肉塊
    CreateItem(179281),							 --尊殞羅宋湯
    CreateItem(179283),							 --小米薄酥餅
    CreateItem(179992),							 --幽影泉水
    CreateItem(179993),							 --灌能泥水
    CreateItem(180430),							 --手指點心
    CreateItem(184201),							 --泥濘水
    CreateItem(184202),							 --凍乾鹽漬肉
    CreateItem(184281),							 --泥霜凍飲
	})

CreateDestination(
	"conjuredManaFood",		-- Food crafted by mage
	{
    CreateItem(34062),							 --魔法法力軟餅
    CreateItem(43518),							 --魔法法力派
    CreateItem(43523),							 --魔法法力餡餅
    CreateItem(65499),							 --魔法法力蛋糕
    CreateItem(65500),							 --魔法法力餅乾
    CreateItem(65515),							 --魔法法力布朗尼
    CreateItem(65516),							 --魔法法力杯子蛋糕
    CreateItem(65517),							 --魔法法力棒棒糖
    CreateItem(80610),							 --魔法法力布丁
    CreateItem(80618),							 --魔法法力甜餅
    CreateItem(113509),							 --魔法法力餐包
	})

CreateDestination(
	"banners",		-- 战旗
	{
    CreateItem(63359),							 -- 合作旌旗
    CreateItem(64400),							 -- 合作旌旗
    CreateItem(64398),							 -- 團結軍旗
    CreateItem(64401),							 -- 團結軍旗
    CreateItem(64399),							 -- 協調戰旗
    CreateItem(64402),							 -- 協調戰旗
    CreateItem(18606),							 -- 聯盟戰旗
    CreateItem(18607),							 -- 部落戰旗
	})

CreateDestination(
	"utilities",		-- 实用工具
	{
    CreateItem(49040),							 -- 吉福斯
    CreateItem(109076),							 -- 哥布林滑翔工具組
    CreateItem(132514),							 -- 自動鐵錘
    CreateItem(153023),							 -- 光鑄增強符文
    CreateItem(171285),							 --影核之油
    CreateItem(171286),							 --防腐之油
    CreateItem(171436),							 --孔岩磨刀石
    CreateItem(171437),							 --幽影磨刀石
    CreateItem(171438),							 --孔岩平衡石
    CreateItem(171439),							 --幽影平衡石
    CreateItem(172346),							 --荒寂護甲片
    CreateItem(172347),							 --厚重荒寂護甲片
    CreateItem(172233),							 --致命兇殘之鼓
	})

CreateDestination(
	"openableItems",		-- 
	{
    CreateItem(171209),							 --沾血的袋子
    CreateItem(171210),							 --一袋自然的恩賜
    CreateItem(171211),							 --汎希爾的錢包
    CreateItem(174652),							 --一袋被遺忘的傳家寶
    CreateItem(178078),							 --重生之靈寶箱
    CreateItem(178513),							 --週年慶禮物
    CreateItem(178965),							 --小型的園丁袋子
    CreateItem(178966),							 --園丁的袋子
    CreateItem(178967),							 --大型的園丁袋子
    CreateItem(178968),							 --每週的園丁袋子
    CreateItem(178969),							 --Test Container
    CreateItem(180085),							 --琪瑞安紀念品
    CreateItem(180355),							 --華麗聖盒
    CreateItem(180378),							 --鍛造大師的箱子
    CreateItem(180379),							 --精緻紡織地毯
    CreateItem(180380),							 --精細網織品
    CreateItem(180386),							 --草藥師小袋
    CreateItem(180442),							 --一袋罪孽石
    CreateItem(180646),							 --不死軍團補給品
    CreateItem(180647),							 --晉升者補給品
    CreateItem(180648),							 --收割者廷衛補給品
    CreateItem(180649),							 --曠野獵者補給品
    CreateItem(180875),							 --馬車貨物
    CreateItem(180974),							 --學徒的袋子
    CreateItem(180975),							 --熟工的袋子
    CreateItem(180976),							 --專家的袋子
    CreateItem(180977),							 --靈魂看管者的袋子
    CreateItem(180979),							 --專家的大型袋子
    CreateItem(180980),							 --熟工的大型袋子
    CreateItem(180981),							 --學徒的大型袋子
    CreateItem(180983),							 --專家滿載的袋子
    CreateItem(180984),							 --熟工滿載的袋子
    CreateItem(180985),							 --學徒滿載的袋子
    CreateItem(180988),							 --熟工滿溢的袋子
    CreateItem(180989),							 --學徒滿溢的袋子
    CreateItem(181767),							 --小錢包
    CreateItem(181372),							 --晉升者的獻禮
    CreateItem(181475),							 --林地看守者的獎賞
    CreateItem(181476),							 --曠野獵者的獻禮
    CreateItem(181556),							 --廷尉的獻禮
    CreateItem(181557),							 --廷尉的大禮
    CreateItem(181732),							 --野心家獻禮
    CreateItem(181733),							 --盡責者獻禮
    CreateItem(181741),							 --楷模的獻禮
    CreateItem(182590),							 --爬藤蠕動的零錢包
    CreateItem(182591),							 --覆藤灌能紅寶石
    CreateItem(183699),							 --特選材料
    CreateItem(183701),							 --淨化儀式材料
    CreateItem(183702),							 --自然光采
    CreateItem(183703),							 --骸骨工匠背袋
    CreateItem(184045),							 --收割者廷衛的軍稅
    CreateItem(184046),							 --不死軍團武器箱
    CreateItem(184047),							 --晉升者武器箱
    CreateItem(184048),							 --曠野獵者武器袋
    CreateItem(184158),							 --黏黏的死靈魟魚卵
    CreateItem(184444),							 --晉升之路補給
    CreateItem(184522),							 --協力朦朧布包
    CreateItem(184589),							 --藥水袋
    CreateItem(184630),							 --冒險者布料箱
    CreateItem(184631),							 --冒險者附魔箱
    CreateItem(184632),							 --勇士魚類箱
    CreateItem(184633),							 --勇士肉類箱
    CreateItem(184634),							 --冒險者草藥箱
    CreateItem(184635),							 --冒險者礦石箱
    CreateItem(184636),							 --冒險者皮革箱
    CreateItem(184637),							 --英雄肉類箱
    CreateItem(184638),							 --英雄魚類箱
    CreateItem(184639),							 --勇士布料箱
    CreateItem(184640),							 --勇士皮革箱
    CreateItem(184641),							 --勇士礦石箱
    CreateItem(184642),							 --勇士草藥箱
    CreateItem(184643),							 --勇士附魔箱
    CreateItem(184644),							 --英雄布料箱
    CreateItem(184645),							 --英雄皮革箱
    CreateItem(184646),							 --英雄礦石箱
    CreateItem(184647),							 --英雄草藥箱
    CreateItem(184648),							 --英雄附魔箱
    CreateItem(184811),							 --阿特米德的恩賜
    CreateItem(184812),							 --阿波隆的恩賜
    CreateItem(184843),							 --回收的補給物資
    CreateItem(184868),							 --納撒亞寶物箱
    CreateItem(184869),							 --納撒亞寶物箱
	})