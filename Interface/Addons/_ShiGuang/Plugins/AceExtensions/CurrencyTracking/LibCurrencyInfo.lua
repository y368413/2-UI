--[[
Name: LibCurrencyInfo
Revision: $Rev: 59 $
Maintainers: Arith
Website: https://www.wowace.com/projects/libcurrencyinfo
Dependencies: None
License: MIT
]]

local data = {}

data.CurrencyByCategory = {
	[1] = { -- Miscellaneous
--		1, -- Currency Token Test Token 4
--		2, -- Currency Token Test Token 2
--		4, -- Currency Token Test Token 5
--		42, -- Badge of Justice
		81, -- Epicurean's Award
		402, -- Ironpaw Token
		515, -- Darkmoon Prize Ticket
		1379, -- Trial of Style Token
		1388, -- Armor Scraps
		1401, -- Stronghold Supplies
	},
	[2] = { -- Player vs. Player
--		103, -- Arena Points
--		104, -- Honor Points DEPRECATED
--		121, -- Alterac Valley Mark of Honor
--		122, -- Arathi Basin Mark of Honor
--		123, -- Eye of the Storm Mark of Honor
--		124, -- Strand of the Ancients Mark of Honor
--		125, -- Warsong Gulch Mark of Honor
--		126, -- Wintergrasp Mark of Honor
--		161, -- Stone Keeper's Shard
--		181, -- Honor Points DEPRECATED2
--		201, -- Venture Coin
--		321, -- Isle of Conquest Mark of Honor
		391, -- Tol Barad Commendation
		1602, -- Conquest, this one is actually under Hidden
		1792, -- Honor, Used to purchase Unrated PvP equipment in Stormwind and Orgrimmar.

	},
	[21] = { -- Wrath of the Lich King
		61, -- Dalaran Jewelcrafter's Token
		241, -- Champion's Seal
	},
	[22] = { -- Dungeon and Raid
--		101, -- Emblem of Heroism
--		102, -- Emblem of Valor
--		221, -- Emblem of Conquest
--		301, -- Emblem of Triumph
--		341, -- Emblem of Frost
		1166, -- Timewarped Badge
	},
	[23] = { -- Burning Crusade
		1704, -- Spirit Shard
	},
--	[41] = { -- Test
--		22, -- Birmingham Test Item 3
--	},
	[81] = { -- Cataclysm
		361, -- Illustrious Jewelcrafter's Token
		416, -- Mark of the World Tree
		614, -- Mote of Darkness
		615, -- Essence of Corrupted Deathwing
	},
	[82] = { -- Archaeology
		384, -- Dwarf Archaeology Fragment
		385, -- Troll Archaeology Fragment
		393, -- Fossil Archaeology Fragment
		394, -- Night Elf Archaeology Fragment
		397, -- Orc Archaeology Fragment
		398, -- Draenei Archaeology Fragment
		399, -- Vrykul Archaeology Fragment
		400, -- Nerubian Archaeology Fragment
		401, -- Tol'vir Archaeology Fragment
		676, -- Pandaren Archaeology Fragment
		677, -- Mogu Archaeology Fragment
		754, -- Mantid Archaeology Fragment
		821, -- Draenor Clans Archaeology Fragment
		828, -- Ogre Archaeology Fragment
		829, -- Arakkoa Archaeology Fragment
--		830, -- n/a
		1172, -- Highborne Archaeology Fragment
		1173, -- Highmountain Tauren Archaeology Fragment
		1174, -- Demonic Archaeology Fragment
		1534, -- Zandalari Archaeology Fragment, Added in patch 8.0.1.25902
		1535, -- Drust Archaeology Fragment, Added in patch 8.0.1.25902
	},
--	[89] = { -- Meta
--		483, -- Conquest Arena Meta
--		484, -- Conquest Rated BG Meta
--		692, -- Conquest Random BG Meta
--	},
	[133] = { -- Mists of Pandaria
		697, -- Elder Charm of Good Fortune
		698, -- Zen Jewelcrafter's Token
		738, -- Lesser Charm of Good Fortune
		752, -- Mogu Rune of Fate
		776, -- Warforged Seal
		777, -- Timeless Coin
		789, -- Bloody Coin
		810, -- Black Iron Fragment
	},
	[137] = { -- Warlords of Draenor
		823, -- Apexis Crystal
		824, -- Garrison Resources
--		897, -- UNUSED
		910, -- Secret of Draenor Alchemy
		944, -- Artifact Fragment
		980, -- Dingy Iron Coins
		994, -- Seal of Tempered Fate
		999, -- Secret of Draenor Tailoring
		1008, -- Secret of Draenor Jewelcrafting
		1017, -- Secret of Draenor Leatherworking
		1020, -- Secret of Draenor Blacksmithing
		1101, -- Oil
		1129, -- Seal of Inevitable Fate
	},
	[141] = { -- Legion
		1149, -- Sightless Eye
		1154, -- Shadowy Coins
		1155, -- Ancient Mana
		1171, -- Artifact Knowledge, this is actually in "hidden" category, but would make more sense to put under Legion one
		1220, -- Order Resources
		1226, -- Nethershard
		1268, -- Timeworn Artifact
		1273, -- Seal of Broken Fate
		1275, -- Curious Coin
		1299, -- Brawler's Gold
		1314, -- Lingering Soul Fragment
		1342, -- Legionfall War Supplies
		1355, -- Felessence
		1356, -- Echoes of Battle
		1357, -- Echoes of Domination
		1416, -- Coins of Air
		1508, -- Veiled Argunite
		1533, -- Wakening Essence
	},
	[142] = { -- Hidden
--		395, -- Justice Points
--		396, -- Valor Points
--		1171,	 -- Artifact Knowledge, this to be categorize in Legion
		1191,	 -- Valor
		1324,	 -- Horde Qiraji Commendation
		1325,	 -- Alliance Qiraji Commendation
--		1347,	 -- Legionfall Building - Personal Tracker - Mage Tower (Hidden)
--		1349,	 -- Legionfall Building - Personal Tracker - Command Tower (Hidden)
--		1350,	 -- Legionfall Building - Personal Tracker - Nether Tower (Hidden)
		1501,	 -- Writhing Essence
		1506,	 -- Argus Waystone
		1540,	 -- Wood
		1541,	 -- Iron
		1559,	 -- Essence of Storms
		1579,	 -- Champions of Azeroth
		1592,	 -- Order of Embers
		1593,	 -- Proudmoore Admiralty
		1594,	 -- Storm's Wake
		1595,	 -- Talanji's Expedition
		1596,	 -- Voldunai
		1597,	 -- Zandalari Empire
		1598,	 -- Tortollan Seekers
		1599,	 -- 7th Legion
		1600,	 -- Honorbound
-- 		1602,	 -- Conquest, this to be categorize in PvP
		1703,	 -- BFA Season Rated Participation Currency
--		1705,	 -- Warfronts - Personal Tracker - Iron in Chest (Hidden)
--		1714,	 -- Warfronts - Personal Tracker - Wood in Chest (Hidden)
		1722,	 -- Azerite Ore
		1723,	 -- Lumber
		1738,	 -- Unshackled
		1739,	 -- Ankoan
--		1740,	 -- Rustbolt Resistance (Hidden)
		1742,	 -- Rustbolt Resistance
		1745,	 -- Nazjatar Ally - Neri Sharpfin
		1746,	 -- Nazjatar Ally - Vim Brineheart
		1747,	 -- Nazjatar Ally - Poen Gillbrack
		1748,	 -- Nazjatar Ally - Bladesman Inowari
		1749,	 -- Nazjatar Ally - Hunter Akana
		1750,	 -- Nazjatar Ally - Farseer Ori
		1752,	 -- Honeyback Hive
		1757, 	 -- Uldum Accord
		1758, 	 -- Rajani
		1761, 	 -- Enemy Damage
		1762, 	 -- Enemy Health
		1763, 	 -- Deaths
--		1769, 	 -- Quest Experience (Standard, Hidden)
		1794, 	 -- Atonement Anima
		1804, 	 -- Ascended
		1805, 	 -- Undying Army
		1806, 	 -- Wild Hunt
		1807, 	 -- Court of Harvesters
		1808, 	 -- Channeled Anima
		1810, 	 -- Redeemed Soul
		1822, 	 -- Renown
		1837, 	 -- The Ember Court
		1838, 	 -- The Countess
		1839, 	 -- Rendle and Cudgelface
		1840, 	 -- Stonehead
		1841, 	 -- Cryptkeeper Kassir
		1842, 	 -- Baroness Vashj
		1843, 	 -- Plague Deviser Marileth
		1844, 	 -- Grandmaster Vole
		1845, 	 -- Alexandros Mograine
		1846, 	 -- Sika
		1847, 	 -- Kleia and Pelegos
		1848, 	 -- Polemarch Adrestes
		1849, 	 -- Mikanikos
		1850, 	 -- Choofa
		1851, 	 -- Droman Aliothe
		1852, 	 -- Hunt-Captain Korayn
		1853, 	 -- Lady Moonberry
		1877, 	 -- Bonus Experience
		1878, 	 -- Stitchmasters
		1880, 	 -- Ve'nari
		1883, 	 -- Soulbind Conduit Energy
		1884, 	 -- The Avowed
		1887, 	 -- Court of Night
		1888, 	 -- Marasmius
		1889, 	 -- Adventure Campaign Progress
		1891, 	 -- Honor from Rated
--		1902, 	 -- 9.1 - Torghast XP - Prototype - LJS, 
--		1903, 	 -- Invisible Reward, 
		1907, 	 -- Death's Advance	Grants reputation with the Death's Advance., 
		1947, 	 -- Bonus Valor, 
		1982,	 -- The Enlightened	Grants reputation with The Enlightened.
		1997,	 -- Archivists' Codex
		2000,	 -- Motes of Fate	
	},
	[143] = { -- Battle for Azeroth
		1299,	 -- Brawler's Gold
		1560,	 -- War Resources
		1565,	 -- Rich Azerite Fragment
		1580,	 -- Seal of Wartorn Fate
		1587,	 -- War Supplies
		1710,	 -- Seafarer's Dubloon
		1715,	 -- Progenitor Shard
		1716,	 -- Honorbound Service Medal
		1717,	 -- 7th Legion Service Medal
		1718,	 -- Titan Residuum
		1719,	 -- Corrupted Memento
		1721,	 -- Prismatic Manapearl
		1755, 	 -- Coalescing Visions
		1803,	 -- Echoes of Ny'alotha
	},
	[144] = { -- Virtual
		1553, -- Azerite
		1585, -- Honor
		1586, -- Honor Level
	},
	[245] = { -- Shadowlands
--		1743, 	 -- Fake Anima for Quest Tracking
		1754, 	 -- Argent Commendation
		1767, 	 -- Stygia
		1802, 	 -- Shadowlands PvP Weekly Reward Progress
--		1811, 	 -- zzoldSanctum Architect
--		1812, 	 -- zzoldSanctum Anima Weaver
		1813, 	 -- Reservoir Anima
		1816, 	 -- Sinstone Fragments
		1819, 	 -- Medallion of Service
		1820, 	 -- Infused Ruby
		1828, 	 -- Soul Ash
		1829, 	 -- Renown-Kyrian
		1830, 	 -- Renown-Venthyr
		1831, 	 -- Renown-NightFae
		1832, 	 -- Renown-Necrolord
		1859, 	 -- Reservoir Anima-Kyrian
		1860, 	 -- Reservoir Anima-Venthyr
		1861, 	 -- Reservoir Anima-Night Fae
		1862, 	 -- Reservoir Anima-Necrolord
		1863, 	 -- Redeemed Soul-Kyrian
		1864, 	 -- Redeemed Soul-Venthyr
		1865, 	 -- Redeemed Soul-Night Fae
		1866, 	 -- Redeemed Soul-Necrolord
		1867, 	 -- Sanctum Architect-Kyrian
		1868, 	 -- Sanctum Architect-Venthyr
		1869, 	 -- Sanctum Architect-Night Fae
		1870, 	 -- Sanctum Architect-Necrolord
		1871, 	 -- Sanctum Anima Weaver-Kyrian
		1872, 	 -- Sanctum Anima Weaver-Venthyr
		1873, 	 -- Sanctum Anima Weaver-Night Fae
		1874, 	 -- Sanctum Anima Weaver-Necrolord
		1885, 	 -- Grateful Offering
		1904, 	 -- Tower Knowledge, 
		1906, 	 -- Soul Cinders, 
		1931, 	 -- Cataloged Research, 
		1977,	 -- Stygian Ember
		1979,	 -- Cyphers of the First Ones
		2009,	 -- Cosmic Flux	Swirling fragments of creation energy that enable transformation, Cosmic Flux can be used to empower equipment at the Creation Catalyst in Zereth Mortis or fuel the Runecarver's Chamber in Torghast.
--		2010,	 -- [DNT] Byron Test Currency	A currency used to test currencies.
	},
	[248] = { -- Torghast UI (Hidden)
		1909, 	 -- Torghast - Scoreboard - Clear Percent, 
		1910, 	 -- Torghast - Scoreboard - Souls Percent, 
		1911, 	 -- Torghast - Scoreboard - Urns Percent, 
		1912, 	 -- Torghast - Scoreboard - Hot Streak Percent, 
		1913, 	 -- Torghast - Scoreboard - Total Time, 
		1914, 	 -- Torghast - Scoreboard - Par Time, 
		1915, 	 -- Torghast - Scoreboard - Deaths Excess Count, 
		1916, 	 -- Torghast - Scoreboard - Deaths Start Count, 
		1917, 	 -- Torghast - Scoreboard - Floor Reached, 
		1918, 	 -- Torghast - Scoreboard - Toast Display - Time Score, 
		1919, 	 -- Torghast - Scoreboard - Toast Display - Hot Streak Score, 
		1920, 	 -- Torghast - Scoreboard - Toast Display - Deaths Excess Score, 
		1921, 	 -- Torghast - Scoreboard - Toast Display - Total Score, 
		1922, 	 -- Torghast - Scoreboard - Toast Display - Total Rewards, 
		1923, 	 -- Torghast - Scoreboard - Toast Display - Bonus - Souls Rescued, 
		1924, 	 -- Torghast - Scoreboard - Toast Display - Bonus - Urns Broken, 
		1925, 	 -- Torghast - Scoreboard - Toast Display - Deaths Zero, 
		1926, 	 -- Torghast - Scoreboard - Toast Display - Stars, 
		1932, 	 -- Torghast - Scoreboard - Toast Display - Boss Killed, 
		1933, 	 -- Torghast - Scoreboard - Toast Display - Bonus - Chests Opened, 
		1934, 	 -- Torghast - Scoreboard - Toast Display - Bonus - Escorts Complete, 
		1935, 	 -- Torghast - Scoreboard - Toast Display - Bonus - No Trap Damage, 
		1936, 	 -- Torghast - Scoreboard - Toast Display - Bonus - Kill Boss Fast, 
		1937, 	 -- Torghast - Scoreboard - Toast Display - Bonus - Single Stacks, 
		1938, 	 -- Torghast - Scoreboard - Toast Display - Bonus - 5 Stacks, 
		1939, 	 -- Torghast - Scoreboard - Toast Display - Bonus - Broker Killer, 
		1940, 	 -- Torghast - Scoreboard - Toast Display - Bonus - Elite Slayer, 
		1941, 	 -- Torghast - Scoreboard - Toast Display - Bonus - 1000 Phantasma, 
		1942, 	 -- Torghast - Scoreboard - Toast Display - Bonus - 500 Phant Left, 
		1943, 	 -- Torghast - Scoreboard - Toast Display - Bonus - No Deaths, 
		1944, 	 -- Torghast - Scoreboard - Toast Display - Bonus - No Epics, 
		1945, 	 -- Torghast - Scoreboard - Toast Display - Bonus - Elite Unnatural, 
		1946, 	 -- Torghast - Scoreboard - Toast Display - Total Rewards - AV Bonus, 
		1948, 	 -- Torghast - Scoreboard - Toast Display - Bonus - Kill Boss Faster, 
		1949, 	 -- Torghast - Scoreboard - Toast Display - Bonus - 30+ Count, 
		1950,	 -- Torghast - Scoreboard - Toast Display - 1 Star Value
		1951,	 -- Torghast - Scoreboard - Toast Display - 2 Star Value
		1952,	 -- Torghast - Scoreboard - Toast Display - 3 Star Value
		1953,	 -- Torghast - Scoreboard - Toast Display - 4 Star Value
		1954,	 -- Torghast - Scoreboard - Toast Display - 5 Star Value
		1955,	 -- Torghast - Scoreboard - Toast Display - Points While Empowered
		1956,	 -- Torghast - Scoreboard - Toast Display - Points Empowered Score
		1957,	 -- Torghast - Scoreboard - Floor Clear Percent Floor 1
		1958,	 -- Torghast - Scoreboard - Floor Clear Percent Floor 2
		1959,	 -- Torghast - Scoreboard - Floor Clear Percent Floor 3
		1960,	 -- Torghast - Scoreboard - Floor Clear Percent Floor 4
		1961,	 -- Torghast - Scoreboard - Floor Empowered Percent Floor 1
		1962,	 -- Torghast - Scoreboard - Floor Empowered Percent Floor 2
		1963,	 -- Torghast - Scoreboard - Floor Empowered Percent Floor 3
		1964,	 -- Torghast - Scoreboard - Floor Empowered Percent Floor 4
		1965,	 -- Torghast - Scoreboard - Floor Time Floor 1
		1966,	 -- Torghast - Scoreboard - Floor Time Floor 2
		1967,	 -- Torghast - Scoreboard - Floor Time Floor 3
		1968,	 -- Torghast - Scoreboard - Floor Time Floor 4
		1969,	 -- Torghast - Scoreboard - Floor Par Time Floor 1
		1970,	 -- Torghast - Scoreboard - Floor Par Time Floor 2
		1971,	 -- Torghast - Scoreboard - Floor Par Time Floor 3
		1972,	 -- Torghast - Scoreboard - Floor Par Time Floor 4
		1976,	 -- Torghast - Scoreboard - Toast Display - Bonus - Phant Left Group
		1980,	 -- Torghast - Scoreboard - Run Layer
		1981,	 -- Torghast - Scoreboard - Run ID

	},
}

data.CurrencyCategories = {
	[1] = { enUS="Miscellaneous",deDE="Verschiedenes",esES="Miscelánea",esMX="Miscelánea",frFR="Divers",itIT="Varie",koKR="기타",ptBR="Diversos",ruRU="Разное",zhCN="其它",zhTW="雜項", },
	[2] = { enUS="Player vs. Player",deDE="Spieler gegen Spieler",esES="Jugador contra Jugador",esMX="Jugador contra Jugador",frFR="JcJ",itIT="Personaggio vs Personaggio",koKR="플레이어 간 전투",ptBR="Jogador x Jogador",ruRU="PvP",zhCN="PvP",zhTW="玩家對玩家", },
	[3] = { enUS="Unused",deDE="Unbenutzt",esES="No las uso",esMX="No las uso",frFR="Inutilisées",itIT="Non usato",koKR="미사용",ptBR="Não usado",ruRU="Неактивно",zhCN="未使用",zhTW="未使用", hide=true, },
	[4] = { enUS="Classic",deDE="Classic",esES="Clásico",esMX="Clásico",frFR="Classique",itIT="Classico",koKR="오리지널",ptBR="Clássico",ruRU="World of Warcraft",zhCN="经典旧世",zhTW="艾澤拉斯", hide=true, },
	[21] = { enUS="Wrath of the Lich King",deDE="Wrath of the Lich King",esES="Wrath of the Lich King",esMX="Wrath of the Lich King",frFR="Wrath of the Lich King",itIT="Wrath of the Lich King",koKR="리치 왕의 분노",ptBR="Wrath of the Lich King",ruRU="Wrath of the Lich King",zhCN="巫妖王之怒",zhTW="巫妖王之怒", },
	[22] = { enUS="Dungeon and Raid",deDE="Dungeon und Schlachtzug",esES="Mazmorra y banda",esMX="Calabozo y banda",frFR="Donjons & Raids",itIT="Spedizioni e Incursioni",koKR="던전 및 공격대",ptBR="Masmorras e Raides",ruRU="Подземелья и рейды",zhCN="地下城与团队副本",zhTW="地城與團隊", },
	[23] = { enUS="Burning Crusade",deDE="Burning Crusade",esES="Burning Crusade",esMX="Burning Crusade",frFR="Burning Crusade",itIT="Burning Crusade",koKR="불타는 성전",ptBR="Burning Crusade",ruRU="Burning Crusade",zhCN="燃烧的远征",zhTW="燃燒的遠征", hide=true, },
	[81] = { enUS="Cataclysm",deDE="Cataclysm",esES="Cataclysm",esMX="Cataclysm",frFR="Cataclysm",itIT="Cataclysm",koKR="대격변",ptBR="Cataclysm",ruRU="Cataclysm",zhCN="大地的裂变",zhTW="浩劫與重生", },
	[82] = { enUS="Archaeology",deDE="Archäologie",esES="Arqueología",esMX="Arqueología",frFR="Archéologie",itIT="Archeologia",koKR="고고학",ptBR="Arqueologia",ruRU="Археология",zhCN="考古学",zhTW="考古學", },
	[133] = { enUS="Mists of Pandaria",deDE="Mists of Pandaria",esES="Mists of Pandaria",esMX="Mists of Pandaria",frFR="Mists of Pandaria",itIT="Mists of Pandaria",koKR="판다리아의 안개",ptBR="Mists of Pandaria",ruRU="Mists of Pandaria",zhCN="熊猫人之谜",zhTW="潘達利亞之謎", },
	[137] = { enUS="Warlords of Draenor",deDE="Warlords of Draenor",esES="Warlords of Draenor",esMX="Warlords of Draenor",frFR="Warlords of Draenor",itIT="Warlords of Draenor",koKR="드레노어의 전쟁군주",ptBR="Warlords of Draenor",ruRU="Warlords of Draenor",zhCN="德拉诺之王",zhTW="德拉諾之霸", },
	[141] = { enUS="Legion",deDE="Legion",esES="Legion",esMX="Legion",frFR="Legion",itIT="Legion",koKR="군단",ptBR="Legion",ruRU="Legion",zhCN="军团再临",zhTW="軍團", },
	[142] = { enUS="Hidden",deDE="Versteckt",esES="Oculto",esMX="Oculto",frFR="Caché",itIT="Nascosto",koKR="숨김",ptBR="Escondido",ruRU="Невидимые чары",zhCN="隐藏",zhTW="隱藏", },
	[143] = { enUS="Battle for Azeroth",deDE="Battle for Azeroth",esES="Battle for Azeroth",esMX="Battle for Azeroth",frFR="Battle for Azeroth",itIT="Battle for Azeroth",koKR="격전의 아제로스",ptBR="Battle for Azeroth",ruRU="Battle for Azeroth",zhCN="争霸艾泽拉斯",zhTW="決戰艾澤拉斯", },
	[144] = { enUS="Virtual",deDE="Virtuell",esES="Virtual",esMX="Virtual",frFR="Virtuelle",itIT="Virtuale",koKR="가상",ptBR="Virtual",ruRU="Виртуальная валюта",zhCN="虚拟",zhTW="虛擬", },
	[245] = { enUS=EXPANSION_NAME8,deDE=EXPANSION_NAME8,esES=EXPANSION_NAME8,esMX=EXPANSION_NAME8,frFR=EXPANSION_NAME8,itIT=EXPANSION_NAME8,koKR=EXPANSION_NAME8,ptBR=EXPANSION_NAME8,ruRU=EXPANSION_NAME8,zhCN=EXPANSION_NAME8,zhTW=EXPANSION_NAME8, },
	[248] = { enUS="Torghast",deDE="Torghast",esES="Torghast",esMX="Torghast",frFR="Tourment",itIT="Torgast",koKR="토르가스트",ptBR="Thanator",ruRU="Торгаст",zhCN="托加斯特",zhTW="托迦司", hide=true, },
}

data.Currencies = {
	[1] = { id=1, category=1, hide=true }, -- Currency Token Test Token 4, Miscellaneous
	[2] = { id=2, category=1, hide=true }, -- Currency Token Test Token 2, Miscellaneous
	[4] = { id=4, category=1, hide=true }, -- Currency Token Test Token 5, Miscellaneous
	[22] = { id=22, category=41, hide=true }, -- Birmingham Test Item 3, Test
	[42] = { id=42, category=1, hide=true }, -- Badge of Justice, Miscellaneous
	[61] = { id=61, category=21 }, -- Dalaran Jewelcrafter's Token, Wrath of the Lich King
	[81] = { id=81, category=1 }, -- Epicurean's Award, Miscellaneous
	[101] = { id=101, category=22, hide=true }, -- Emblem of Heroism, Dungeon and Raid
	[102] = { id=102, category=22, hide=true }, -- Emblem of Valor, Dungeon and Raid
	[103] = { id=103, category=2, hide=true }, -- Arena Points, Player vs. Player
	[104] = { id=104, category=2, hide=true }, -- Honor Points DEPRECATED, Player vs. Player
	[121] = { id=121, category=2, hide=true }, -- Alterac Valley Mark of Honor, Player vs. Player
	[122] = { id=122, category=2, hide=true }, -- Arathi Basin Mark of Honor, Player vs. Player
	[123] = { id=123, category=2, hide=true }, -- Eye of the Storm Mark of Honor, Player vs. Player
	[124] = { id=124, category=2, hide=true }, -- Strand of the Ancients Mark of Honor, Player vs. Player
	[125] = { id=125, category=2, hide=true }, -- Warsong Gulch Mark of Honor, Player vs. Player
	[126] = { id=126, category=2, hide=true }, -- Wintergrasp Mark of Honor, Player vs. Player
	[161] = { id=161, category=2, hide=true }, -- Stone Keeper's Shard, Player vs. Player
	[181] = { id=181, category=2, hide=true }, -- Honor Points DEPRECATED2, Player vs. Player
	[201] = { id=201, category=2, hide=true }, -- Venture Coin, Player vs. Player
	[221] = { id=221, category=22, hide=true }, -- Emblem of Conquest, Dungeon and Raid
	[241] = { id=241, category=21 }, -- Champion's Seal, Wrath of the Lich King
	[301] = { id=301, category=22, hide=true }, -- Emblem of Triumph, Dungeon and Raid
	[321] = { id=321, category=2, hide=true }, -- Isle of Conquest Mark of Honor, Player vs. Player
	[341] = { id=341, category=22, hide=true }, -- Emblem of Frost, Dungeon and Raid
	[361] = { id=361, category=81 }, -- Illustrious Jewelcrafter's Token, Cataclysm
	[384] = { id=384, category=82 }, -- Dwarf Archaeology Fragment, Archaeology
	[385] = { id=385, category=82 }, -- Troll Archaeology Fragment, Archaeology
	[391] = { id=391, category=2 }, -- Tol Barad Commendation, Player vs. Player
	[393] = { id=393, category=82 }, -- Fossil Archaeology Fragment, Archaeology
	[394] = { id=394, category=82 }, -- Night Elf Archaeology Fragment, Archaeology
	[395] = { id=395, category=142, hide=true }, -- Justice Points, Hidden
	[396] = { id=396, category=142, hide=true }, -- Valor Points, Hidden
	[397] = { id=397, category=82 }, -- Orc Archaeology Fragment, Archaeology
	[398] = { id=398, category=82 }, -- Draenei Archaeology Fragment, Archaeology
	[399] = { id=399, category=82 }, -- Vrykul Archaeology Fragment, Archaeology
	[400] = { id=400, category=82 }, -- Nerubian Archaeology Fragment, Archaeology
	[401] = { id=401, category=82 }, -- Tol'vir Archaeology Fragment, Archaeology
	[402] = { id=402, category=1 }, -- Ironpaw Token, Miscellaneous
	[416] = { id=416, category=81 }, -- Mark of the World Tree, Cataclysm
	[483] = { id=483, category=89, hide=true }, -- Conquest Arena Meta, Meta
	[484] = { id=484, category=89, hide=true }, -- Conquest Rated BG Meta, Meta
	[515] = { id=515, category=1 }, -- Darkmoon Prize Ticket, Miscellaneous
	[614] = { id=614, category=81 }, -- Mote of Darkness, Cataclysm
	[615] = { id=615, category=81 }, -- Essence of Corrupted Deathwing, Cataclysm
	[676] = { id=676, category=82 }, -- Pandaren Archaeology Fragment, Archaeology
	[677] = { id=677, category=82 }, -- Mogu Archaeology Fragment, Archaeology
	[692] = { id=692, category=89, hide=true }, -- Conquest Random BG Meta, Meta
	[697] = { id=697, category=133 }, -- Elder Charm of Good Fortune, Mists of Pandaria
	[698] = { id=698, category=133 }, -- Zen Jewelcrafter's Token, Mists of Pandaria
	[738] = { id=738, category=133 }, -- Lesser Charm of Good Fortune, Mists of Pandaria
	[752] = { id=752, category=133 }, -- Mogu Rune of Fate, Mists of Pandaria
	[754] = { id=754, category=82 }, -- Mantid Archaeology Fragment, Archaeology
	[776] = { id=776, category=133 }, -- Warforged Seal, Mists of Pandaria
	[777] = { id=777, category=133 }, -- Timeless Coin, Mists of Pandaria
	[789] = { id=789, category=133 }, -- Bloody Coin, Mists of Pandaria
	[810] = { id=810, category=133 }, -- Black Iron Fragment, Mists of Pandaria
	[821] = { id=821, category=82 }, -- Draenor Clans Archaeology Fragment, Archaeology
	[823] = { id=823, category=137 }, -- Apexis Crystal, Warlords of Draenor
	[824] = { id=824, category=137 }, -- Garrison Resources, Warlords of Draenor
	[828] = { id=828, category=82 }, -- Ogre Archaeology Fragment, Archaeology
	[829] = { id=829, category=82 }, -- Arakkoa Archaeology Fragment, Archaeology
	[830] = { id=830, category=82, hide=true }, -- n/a, Archaeology
	[897] = { id=897, category=137, hide=true }, -- UNUSED, Warlords of Draenor
	[910] = { id=910, category=137 }, -- Secret of Draenor Alchemy, Warlords of Draenor
	[944] = { id=944, category=137 }, -- Artifact Fragment, Warlords of Draenor
	[980] = { id=980, category=137 }, -- Dingy Iron Coins, Warlords of Draenor
	[994] = { id=994, category=137 }, -- Seal of Tempered Fate, Warlords of Draenor
	[999] = { id=999, category=137 }, -- Secret of Draenor Tailoring, Warlords of Draenor
	[1008] = { id=1008, category=137 }, -- Secret of Draenor Jewelcrafting, Warlords of Draenor
	[1017] = { id=1017, category=137 }, -- Secret of Draenor Leatherworking, Warlords of Draenor
	[1020] = { id=1020, category=137 }, -- Secret of Draenor Blacksmithing, Warlords of Draenor
	[1101] = { id=1101, category=137 }, -- Oil, Warlords of Draenor
	[1129] = { id=1129, category=137 }, -- Seal of Inevitable Fate, Warlords of Draenor
	[1149] = { id=1149, category=141 }, -- Sightless Eye, Legion
	[1154] = { id=1154, category=141 }, -- Shadowy Coins, Legion
	[1155] = { id=1155, category=141 }, -- Ancient Mana, Legion
	[1166] = { id=1166, category=22 }, -- Timewarped Badge, Dungeon and Raid
	[1171] = { id=1171, category=141 }, -- Artifact Knowledge, Hidden
	[1172] = { id=1172, category=82 }, -- Highborne Archaeology Fragment, Archaeology
	[1173] = { id=1173, category=82 }, -- Highmountain Tauren Archaeology Fragment, Archaeology
	[1174] = { id=1174, category=82 }, -- Demonic Archaeology Fragment, Archaeology
	[1191] = { id=1191, category=22, hide=true }, -- Valor, Dungeon and Raid
	[1220] = { id=1220, category=141 }, -- Order Resources, Legion
	[1226] = { id=1226, category=141 }, -- Nethershard, Legion
	[1268] = { id=1268, category=141 }, -- Timeworn Artifact, Legion
	[1273] = { id=1273, category=141 }, -- Seal of Broken Fate, Legion
	[1275] = { id=1275, category=141 }, -- Curious Coin, Legion
	[1299] = { id=1299, category=141 }, -- Brawler's Gold, Legion
	[1299] = { id=1299, category=143 }, -- Brawler's Gold
	[1314] = { id=1314, category=141 }, -- Lingering Soul Fragment, Legion
	[1324] = { id=1324, category=142 }, -- Horde Qiraji Commendation, Hidden
	[1325] = { id=1325, category=142 }, -- Alliance Qiraji Commendation, Hidden
	[1342] = { id=1342, category=141 }, -- Legionfall War Supplies, Legion
	[1347] = { id=1347, category=142, hide=true }, -- Legionfall Building - Personal Tracker - Mage Tower (Hidden), Hidden
	[1349] = { id=1349, category=142, hide=true }, -- Legionfall Building - Personal Tracker - Command Tower (Hidden), Hidden
	[1350] = { id=1350, category=142, hide=true }, -- Legionfall Building - Personal Tracker - Nether Tower (Hidden), Hidden
	[1355] = { id=1355, category=141 }, -- Felessence, Legion
	[1356] = { id=1356, category=141 }, -- Echoes of Battle, Legion
	[1357] = { id=1357, category=141 }, -- Echoes of Domination, Legion
	[1379] = { id=1379, category=1 }, -- Trial of Style Token, Miscellaneous
	[1388] = { id=1388, category=1 }, -- Armor Scraps
	[1401] = { id=1401, category=1 }, -- Stronghold Supplies
	[1416] = { id=1416, category=141 }, -- Coins of Air, Legion
	[1501] = { id=1501, category=141 }, -- Writhing Essence, Legion
	[1506] = { id=1506, category=141 }, -- Argus Waystone, Legion
	[1508] = { id=1508, category=141 }, -- Veiled Argunite, Legion
	[1533] = { id=1533, category=141 }, -- Wakening Essence, Used by Arcanomancer Vridiel in Dalaran above the Broken Isles to create or upgrade Legion Legendary items.
	[1534] = { id=1534, category=82 }, -- Zandalari Archaeology Fragment,  
	[1535] = { id=1535, category=82 }, -- Drust Archaeology Fragment,  
	[1540] = { id=1540, category=142 }, -- Wood, Gathered by harvesting trees and piles of wood throughout the warfront. Used to construct buildings and upgrade troops.
	[1541] = { id=1541, category=142 }, -- Iron, Gathered by workers and miners when a mine is captured. Used to construct buildings and recruit or upgrade troops.
	[1553] = { id=1553, category=144 }, -- Azerite, The blood of Azeroth crystalizes into chunks of Azerite, an extremely potent and powerful material.
	[1559] = { id=1559, category=142 }, -- Essence of Storms, Extremely rare, found while killing enemies in the warfront. Used to grant yourself unbridled power at the Altar.
	[1560] = { id=1560, category=143 }, -- War Resources
	[1560] = { id=1560, category=143 }, -- War Resources, Used to recruit troops, run missions, and research upgrades for your war effort.
	[1565] = { id=1565, category=143 }, -- Rich Azerite Fragment
	[1565] = { id=1565, category=143 }, -- Rich Azerite Fragment, A fragment of rich Azerite. Turn-in to a nearby War Master for rewards.
	[1579] = { id=1579, category=142 }, -- Champions of Azeroth, Grants reputation with the Champions of Azeroth.
	[1580] = { id=1580, category=143 }, -- Seal of Wartorn Fate
	[1580] = { id=1580, category=143 }, -- Seal of Wartorn Fate, Twists fate to provide an opportunity for additional treasure from Battle for Azeroth raid and dungeon bosses.
	[1585] = { id=1585, category=144 }, -- Honor, Granted from slaying enemies of your faction
	[1586] = { id=1586, category=144 }, -- Honor Level, Granted from slaying many enemies of your faction
	[1587] = { id=1587, category=143 }, -- War Supplies
	[1587] = { id=1587, category=143 }, -- War Supplies, Used to raise a force for the Battle of Stromgarde
	[1592] = { id=1592, category=142 }, -- Order of Embers, Grants reputation with the Order of Embers.
	[1593] = { id=1593, category=142 }, -- Proudmore Admiralty, Grants reputation with Proudmore Admiralty.
	[1594] = { id=1594, category=142 }, -- Storm's Wake, Grants reputation with Storm's Wake.
	[1595] = { id=1595, category=142 }, -- Talanji's Expedition, Grants reputation with Talanji's Expedition.
	[1596] = { id=1596, category=142 }, -- Voldunai, Grants reputation with the Voldunai.
	[1597] = { id=1597, category=142 }, -- Zandalari Empire, Grants reputation with the Zandalari Empire.
	[1598] = { id=1598, category=142 }, -- Tortollan Seekers, Grants reputation with the Tortollan Seekers.
	[1599] = { id=1599, category=142 }, -- 7th Legion, Grants reputation with the 7th Legion.
	[1600] = { id=1600, category=142 }, -- Honorbound, Grants reputation with the Honorbound.
	[1602] = { id=1602, category=2 }, -- Conquest, Earned from PvP activities.
	[1703] = { id=1703, category=142 }, -- PVP Season Rated Participation Currency
	[1704] = { id=1704, category=23 }, -- Spirit Shard
	[1705] = { id=1705, category=142 }, -- Warfronts - Personal Tracker - Iron in Chest (Hidden)
	[1710] = { id=1710, category=143 }, -- Seafarer's Dubloon
	[1714] = { id=1714, category=142 }, -- Warfronts - Personal Tracker - Wood in Chest (Hidden)
	[1715] = { id=1715, category=143 }, -- Progenitor Shard
	[1716] = { id=1716, category=143 }, -- Honorbound Service Medal
	[1717] = { id=1717, category=143 }, -- 7th Legion Service Medal
	[1718] = { id=1718, category=143 }, -- Titan Residuum
	[1719] = { id=1719, category=143 }, -- Corrupted Mementos
	[1721] = { id=1721, category=143 }, -- Prismatic Manapearl
	[1722] = { id=1722, category=142 }, -- Azerite Ore
	[1723] = { id=1723, category=142 }, -- Lumber
	[1728] = { id=1728, category=142 }, -- Phantasma
	[1738] = { id=1738, category=142 }, -- Unshackled
	[1739] = { id=1739, category=142 }, -- Ankoan
	[1740] = { id=1740, category=142, hide=true }, -- Rustbolt Resistance (Hidden)
	[1742] = { id=1742, category=142 }, -- Rustbolt Resistance
	[1743] = { id=1743, category=245, hide=true }, -- Fake Anima for Quest Tracking
	[1744] = { id=1744, category=142 }, -- Corrupted Memento
	[1745] = { id=1745, category=142 }, -- Nazjatar Ally - Neri Sharpfin
	[1746] = { id=1746, category=142 }, -- Nazjatar Ally - Vim Brineheart
	[1747] = { id=1747, category=142 }, -- Nazjatar Ally - Poen Gillbrack
	[1748] = { id=1748, category=142 }, -- Nazjatar Ally - Bladesman Inowari
	[1749] = { id=1749, category=142 }, -- Nazjatar Ally - Hunter Akana
	[1750] = { id=1750, category=142 }, -- Nazjatar Ally - Farseer Ori
	[1752] = { id=1752, category=142 }, -- Honeyback Hive
	[1754] = { id=1754, category=245 }, -- Argent Commendation
	[1755] = { id=1755, category=143 }, -- Coalescing Visions
	[1757] = { id=1757, category=142 }, -- Uldum Accord
	[1758] = { id=1758, category=142 }, -- Rajani
	[1761] = { id=1761, category=142 }, -- Enemy Damage
	[1762] = { id=1762, category=142 }, -- Enemy Health
	[1763] = { id=1763, category=142 }, -- Deaths
	[1767] = { id=1767, category=245 }, -- Stygia
	[1769] = { id=1769, category=142, hide=true }, -- Quest Experience (Standard, Hidden)
	[1792] = { id=1792, category=2 }, -- Honor
	[1794] = { id=1794, category=142 }, -- Atonement Anima
	[1802] = { id=1802, category=245 }, -- Shadowlands PvP Weekly Reward Progress
	[1803] = { id=1803, category=143 }, -- Echoes of Ny'alotha
	[1804] = { id=1804, category=142 }, -- Ascended
	[1805] = { id=1805, category=142 }, -- Undying Army
	[1806] = { id=1806, category=142 }, -- Wild Hunt
	[1807] = { id=1807, category=142 }, -- Court of Harvesters
	[1808] = { id=1808, category=142 }, -- Channeled Anima
	[1810] = { id=1810, category=142 }, -- Redeemed Soul
	[1811] = { id=1811, category=245, hide=true }, -- zzoldSanctum Architect
	[1812] = { id=1812, category=245, hide=true }, -- zzoldSanctum Anima Weaver
	[1813] = { id=1813, category=245 }, -- Reservoir Anima
	[1816] = { id=1816, category=245 }, -- Sinstone Fragments
	[1819] = { id=1819, category=245 }, -- Medallion of Service
	[1820] = { id=1820, category=245 }, -- Infused Ruby
	[1822] = { id=1822, category=142 }, -- Renown
	[1828] = { id=1828, category=245 }, -- Soul Ash
	[1829] = { id=1829, category=245 }, -- Renown-Kyrian
	[1830] = { id=1830, category=245 }, -- Renown-Venthyr
	[1831] = { id=1831, category=245 }, -- Renown-NightFae
	[1832] = { id=1832, category=245 }, -- Renown-Necrolord
	[1835] = { id=1835, category=1, hide=true }, -- Linked Currency Test (Src) - PTH
	[1836] = { id=1836, category=1, hide=true }, -- Linked Currency Test (Dst) - PTH
	[1837] = { id=1837, category=142 }, -- The Ember Court
	[1838] = { id=1838, category=142 }, -- The Countess
	[1839] = { id=1839, category=142 }, -- Rendle and Cudgelface
	[1840] = { id=1840, category=142 }, -- Stonehead
	[1841] = { id=1841, category=142 }, -- Cryptkeeper Kassir
	[1842] = { id=1842, category=142 }, -- Baroness Vashj
	[1843] = { id=1843, category=142 }, -- Plague Deviser Marileth
	[1844] = { id=1844, category=142 }, -- Grandmaster Vole
	[1845] = { id=1845, category=142 }, -- Alexandros Mograine
	[1846] = { id=1846, category=142 }, -- Sika
	[1847] = { id=1847, category=142 }, -- Kleia and Pelegos
	[1848] = { id=1848, category=142 }, -- Polemarch Adrestes
	[1849] = { id=1849, category=142 }, -- Mikanikos
	[1850] = { id=1850, category=142 }, -- Choofa
	[1851] = { id=1851, category=142 }, -- Droman Aliothe
	[1852] = { id=1852, category=142 }, -- Hunt-Captain Korayn
	[1853] = { id=1853, category=142 }, -- Lady Moonberry
	[1859] = { id=1859, category=245 }, -- Reservoir Anima-Kyrian
	[1860] = { id=1860, category=245 }, -- Reservoir Anima-Venthyr
	[1861] = { id=1861, category=245 }, -- Reservoir Anima-Night Fae
	[1862] = { id=1862, category=245 }, -- Reservoir Anima-Necrolord
	[1863] = { id=1863, category=245 }, -- Redeemed Soul-Kyrian
	[1864] = { id=1864, category=245 }, -- Redeemed Soul-Venthyr
	[1865] = { id=1865, category=245 }, -- Redeemed Soul-Night Fae
	[1866] = { id=1866, category=245 }, -- Redeemed Soul-Necrolord
	[1867] = { id=1867, category=245 }, -- Sanctum Architect-Kyrian
	[1868] = { id=1868, category=245 }, -- Sanctum Architect-Venthyr
	[1869] = { id=1869, category=245 }, -- Sanctum Architect-Night Fae
	[1870] = { id=1870, category=245 }, -- Sanctum Architect-Necrolord
	[1871] = { id=1871, category=245 }, -- Sanctum Anima Weaver-Kyrian
	[1872] = { id=1872, category=245 }, -- Sanctum Anima Weaver-Venthyr
	[1873] = { id=1873, category=245 }, -- Sanctum Anima Weaver-Night Fae
	[1874] = { id=1874, category=245 }, -- Sanctum Anima Weaver-Necrolord
	[1877] = { id=1877, category=142 }, -- Bonus Experience
	[1878] = { id=1878, category=142 }, -- Stitchmasters
	[1880] = { id=1880, category=142 }, -- Ve'nari
	[1883] = { id=1883, category=142 }, -- Soulbind Conduit Energy
	[1884] = { id=1884, category=142 }, -- The Avowed
	[1885] = { id=1885, category=245 }, -- Grateful Offering
	[1887] = { id=1887, category=142 }, -- Court of Night
	[1888] = { id=1888, category=142 }, -- Marasmius
	[1889] = { id=1889, category=142 }, -- Adventure Campaign Progress
	[1891] = { id=1891, category=142 }, -- Honor from Rated
	[1902] = { id=1902, category=142, hidden=true }, -- 9.1 - Torghast XP - Prototype - LJS
	[1903] = { id=1903, category=142, hidden=true }, -- Invisible Reward
	[1904] = { id=1904, category=245 }, -- Tower Knowledge
	[1906] = { id=1906, category=245 }, -- Soul Cinders
	[1907] = { id=1907, category=142 }, -- Death's Advance
	[1909] = { id=1909, category=248, hidden=true }, -- Torghast - Scoreboard - Clear Percent
	[1910] = { id=1910, category=248, hidden=true }, -- Torghast - Scoreboard - Souls Percent
	[1911] = { id=1911, category=248, hidden=true }, -- Torghast - Scoreboard - Urns Percent
	[1912] = { id=1912, category=248, hidden=true }, -- Torghast - Scoreboard - Hot Streak Percent
	[1913] = { id=1913, category=248, hidden=true }, -- Torghast - Scoreboard - Total Time
	[1914] = { id=1914, category=248, hidden=true }, -- Torghast - Scoreboard - Par Time
	[1915] = { id=1915, category=248, hidden=true }, -- Torghast - Scoreboard - Deaths Excess Count
	[1916] = { id=1916, category=248, hidden=true }, -- Torghast - Scoreboard - Deaths Start Count
	[1917] = { id=1917, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Reached
	[1918] = { id=1918, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Time Score
	[1919] = { id=1919, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Hot Streak Score
	[1920] = { id=1920, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Deaths Excess Score
	[1921] = { id=1921, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Total Score
	[1922] = { id=1922, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Total Rewards
	[1923] = { id=1923, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - Souls Rescued
	[1924] = { id=1924, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - Urns Broken
	[1925] = { id=1925, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Deaths Zero
	[1926] = { id=1926, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Stars
	[1931] = { id=1931, category=245 }, -- Cataloged Research
	[1932] = { id=1932, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Boss Killed
	[1933] = { id=1933, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - Chests Opened
	[1934] = { id=1934, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - Escorts Complete
	[1935] = { id=1935, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - No Trap Damage
	[1936] = { id=1936, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - Kill Boss Fast
	[1937] = { id=1937, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - Single Stacks
	[1938] = { id=1938, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - 5 Stacks
	[1939] = { id=1939, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - Broker Killer
	[1940] = { id=1940, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - Elite Slayer
	[1941] = { id=1941, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - 1000 Phantasma
	[1942] = { id=1942, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - 500 Phant Left
	[1943] = { id=1943, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - No Deaths
	[1944] = { id=1944, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - No Epics
	[1945] = { id=1945, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - Elite Unnatural
	[1946] = { id=1946, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Total Rewards - AV Bonus
	[1947] = { id=1947, category=142 }, -- Bonus Valor
	[1948] = { id=1948, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - Kill Boss Faster
	[1949] = { id=1949, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - 30+ Count
	[1950] = { id=1950, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - 1 Star Value
	[1951] = { id=1951, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - 2 Star Value
	[1952] = { id=1952, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - 3 Star Value
	[1953] = { id=1953, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - 4 Star Value
	[1954] = { id=1954, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - 5 Star Value
	[1955] = { id=1955, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Points While Empowered
	[1956] = { id=1956, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Points Empowered Score
	[1957] = { id=1957, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Clear Percent Floor 1
	[1958] = { id=1958, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Clear Percent Floor 2
	[1959] = { id=1959, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Clear Percent Floor 3
	[1960] = { id=1960, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Clear Percent Floor 4
	[1961] = { id=1961, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Empowered Percent Floor 1
	[1962] = { id=1962, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Empowered Percent Floor 2
	[1963] = { id=1963, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Empowered Percent Floor 3
	[1964] = { id=1964, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Empowered Percent Floor 4
	[1965] = { id=1965, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Time Floor 1
	[1966] = { id=1966, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Time Floor 2
	[1967] = { id=1967, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Time Floor 3
	[1968] = { id=1968, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Time Floor 4
	[1969] = { id=1969, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Par Time Floor 1
	[1970] = { id=1970, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Par Time Floor 2
	[1971] = { id=1971, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Par Time Floor 3
	[1972] = { id=1972, category=248, hidden=true }, -- Torghast - Scoreboard - Floor Par Time Floor 4
	[1976] = { id=1976, category=248, hidden=true }, -- Torghast - Scoreboard - Toast Display - Bonus - Phant Left Group
	[1977] = { id=1977, category=245 }, -- Stygian Ember
	[1981] = { id=1980, category=248, hidden=true }, -- Torghast - Scoreboard - Run Layer
	[1981] = { id=1981, category=248, hidden=true }, -- Torghast - Scoreboard - Run ID
	[1997] = { id=1997, category=142 }, -- Archivists' Codex
	[1979] = { id=1979, category=245, }, -- Cyphers of the First Ones
	[1980] = { id=1980, category=248, hidden=true }, -- Torghast - Scoreboard - Run Layer
	[1981] = { id=1981, category=248, hidden=true }, -- Torghast - Scoreboard - Run ID
	[1982] = { id=1982, category=142, }, -- The Enlightened
	[1997] = { id=1997, category=142, }, -- Archivists' Codex
	[2000] = { id=2000, category=142, }, -- Motes of Fate
	[2009] = { id=2009, category=245, }, -- Cosmic Flux
	[2010] = { id=2010, category=245, hidden=true }, -- [DNT] Byron Test Currency
}






-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs, type = _G.pairs, _G.type
-- Libraries
local tonumber, error = _G.tonumber, _G.error
local GetCurrencyInfo
local GetLocale = _G.GetLocale

-- Determine WoW TOC Version
local WoWClassic, WoWRetail
local wowtocversion  = select(4, GetBuildInfo())
if wowtocversion < 30000 then
	WoWClassic = true
else
	WoWRetail = true
end

if WoWClassic then
	GetCurrencyInfo = _G.GetCurrencyInfo
else -- Shadowlands
	GetCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo
end

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local LibStub = _G.LibStub

local MAJOR_VERSION = "LibCurrencyInfo"
local MINOR_VERSION = 90000 + tonumber(("$Rev: 42 $"):match("%d+"))

local lib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

lib.data = data

local LANGS = {
	["enUS"] = true,
	["zhCN"] = true,
	["zhTW"] = true,
}

local function CheckLang(lang)
	if not lang then return end
	if (LANGS[lang]) then return true end
end

function lib:GetCurrencyByID(currencyID, lang)
	if not currencyID or type(currencyID) ~= "number" then return end

	local name, currentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered, rarity, categoryID, categoryName, currencyDesc

	if (lang) then
		if ( not CheckLang(lang) ) then
			error(format("The specified language \"%s\" is invalid or not available", lang))
			return nil
		end
	else
		lang = GetLocale()
	end
	
	if WoWClassic then
		name, currentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered, rarity = GetCurrencyInfo(currencyID)
	else
		local curr = GetCurrencyInfo(currencyID)
		if curr then
		name = curr.name
		currentAmount = curr.quantity
		texture = curr.iconFileID
		earnedThisWeek = curr.quantityEarnedThisWeek
		weeklyMax = curr.maxWeeklyQuantity
		totalMax = curr.maxQuantity
		isDiscovered = curr.discovered
		rarity = curr.quality
		end
	end
	if not name then return end
	local CurrencyDisplayInfo = C_CurrencyInfo.GetBasicCurrencyInfo(currencyID)
	
	categoryID = lib.data.Currencies[currencyID].category
	categoryName = lib.data.CurrencyCategories[categoryID] and lib.data.CurrencyCategories[categoryID][lang] or nil
	--currencyDesc = lib.data.CurrencyDesc[currencyID] and lib.data.CurrencyDesc[currencyID][lang] or nil
	currencyDesc = CurrencyDisplayInfo and CurrencyDisplayInfo.description or nil
	
	return name, currentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered, rarity, categoryID, categoryName, currencyDesc
end

function lib:GetCurrencyByCategoryID(categoryID)
	if not categoryID or type(categoryID) ~= "number" then return end
	
	if lib.data.CurrencyByCategory[categoryID] then return lib.data.CurrencyByCategory[categoryID] end
end

function lib:GetCurrencyTokenStrings(currencyID, lang)
	if not currencyID or type(currencyID) ~= "number" then return end

	local name, count, _, _, _, totalMax, _, _, _, _, currencyDesc = lib:GetCurrencyByID(currencyID, lang)
	if not name then return end
	if not count then count = 0 end

	local str = HIGHLIGHT_FONT_COLOR_CODE..name
	if currencyDesc then str = str.."\n"..NORMAL_FONT_COLOR_CODE..currencyDesc end
	if (totalMax and totalMax > 0) then
		str = str.."\n\n"..NORMAL_FONT_COLOR_CODE..format(CURRENCY_TOTAL_CAP, HIGHLIGHT_FONT_COLOR_CODE, count, totalMax)
	else
		str = str.."\n\n"..NORMAL_FONT_COLOR_CODE..format(CURRENCY_TOTAL, HIGHLIGHT_FONT_COLOR_CODE, count)
	end
	
	return str
end

function lib:GetCurrencyCategoryNameByCurrencyID(currencyID, lang)
	if not currencyID or type(currencyID) ~= "number" then return end
	if not lib.data.Currencies[currencyID] then return end
	
	local categoryID = lib.data.Currencies[currencyID].category
	if not categoryID then return end
	if not lib.data.CurrencyCategories[categoryID] then return end
	
	return lib.data.CurrencyCategories[categoryID][lang] or lib.data.CurrencyCategories[categoryID]["enUS"]
	
end

function lib:GetCurrencyCategoryNameByCategoryID(categoryID, lang)
	if not lib.data.CurrencyCategories[categoryID] then return end
	
	return lib.data.CurrencyCategories[categoryID][lang] or lib.data.CurrencyCategories[categoryID]["enUS"]
	
end
