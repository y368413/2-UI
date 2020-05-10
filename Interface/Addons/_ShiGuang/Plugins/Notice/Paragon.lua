--## Version: Bismuth 8  ## Author: Leo Bolin
local T = {}

-- Player variables
T.player, T.realm, T.level = UnitName("player"), GetRealmName(), UnitLevel("player")
T.classLocalized, T.class, T.classIndex = UnitClass("player")
T.factionGroup, _ = UnitFactionGroup("player")
T.charStr = string.lower(T.player.."-"..T.realm)

-- Standing colors
T.standingColor = {
	[1] = "|cffcc2222", -- Hated
	[2] = "|cffff0000", -- Hostile
	[3] = "|cffee6622", -- Unfriendly
	[4] = "|cffffff00", -- Neutral
	[5] = "|cff00ff00", -- Friendly
	[6] = "|cff00ff88", -- Honored
	[7] = "|cff00ffcc", -- Revered
	[8] = "|cff4cc2ff", -- Exalted (old color ff00ffff)
	[9] = "|cff4cc2ff", -- Paragon
}

T.friendStandingColor = {
	["default"] = {
		[1] = "|cffee6622", -- Stranger
		[2] = "|cffffff00", -- Acquaintance/Pal
		[3] = "|cff00ff00", -- Buddy
		[4] = "|cff00ff88", -- Friend
		[5] = "|cff00ffcc", -- Good Friend
		[6] = "|cff4cc2ff", -- Best Friend
	},
	["chromie"] = {
		[1] = "|cffee6622", -- Whelpling
		[2] = "|cffffff00", -- Temporal Trainee
		[3] = "|cff00ff00", -- Timehopper
		[4] = "|cff00ff88", -- Chrono-Friend
		[5] = "|cff00ff88", -- Bronze Ally
		[6] = "|cff00ffcc", -- Epoch-Mender
		[7] = "|cff4cc2ff", -- Timelord
	},
	["vivianne"] = {
		[1] = "|cffffff00", -- Bodyguard
		[2] = "|cff00ff88", -- Trusted Bodyguard
		[3] = "|cff4cc2ff", -- Personal Wingman
	},
}
-- Reuse Bodyguard colors
T.friendStandingColor["aeda brightdawn"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["defender illona"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["delvar ironfist"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["leorajh"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["talonpriest ishaal"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["tormmok"] = T.friendStandingColor["vivianne"]

-- Localized standing
T.standing = {
	[1] = FACTION_STANDING_LABEL1, -- Hated
	[2] = FACTION_STANDING_LABEL2, -- Hostile
	[3] = FACTION_STANDING_LABEL3, -- Unfriendly
	[4] = FACTION_STANDING_LABEL4, -- Neutral
	[5] = FACTION_STANDING_LABEL5, -- Friendly
	[6] = FACTION_STANDING_LABEL6, -- Honored
	[7] = FACTION_STANDING_LABEL7, -- Revered
	[8] = FACTION_STANDING_LABEL8, -- Exalted
	[9] = "Paragon", -- Paragon - this is overwritten by localization as faction_standing_paragon in Locale.lua
}

-- Localized friend standing labels
T.friendStanding = {
	["default"] = {
		[1] = "faction_standing_stranger",
		[2] = "faction_standing_acquaintance",
		[3] = "faction_standing_buddy",
		[4] = "faction_standing_friend",
		[5] = "faction_standing_good_friend",
		[6] = "faction_standing_best_friend",
	},
	["nat pagle"] = { -- also Conjurer Margoss and Fisherfriends
		[1] = "faction_standing_stranger",
		[2] = "faction_standing_pal",
		[3] = "faction_standing_buddy",
		[4] = "faction_standing_friend",
		[5] = "faction_standing_good_friend",
		[6] = "faction_standing_best_friend",
	},
	["corbyn"] = {
		[1] = "faction_standing_stranger",
		[2] = "faction_standing_curiosity",
		[3] = "faction_standing_non-threat",
		[4] = "faction_standing_friend",
		[5] = "faction_standing_helpful_friend",
		[6] = "faction_standing_best_friend",
	},
	["chromie"] = {
		[1] = "faction_standing_whelpling",
		[2] = "faction_standing_temporal_trainee",
		[3] = "faction_standing_timehopper",
		[4] = "faction_standing_chrono-friend",
		[5] = "faction_standing_bronze_ally",
		[6] = "faction_standing_epoch-mender",
		[7] = "faction_standing_timelord",
	},
	["vivianne"] = { -- also all other Bodyguards
		[1] = "faction_standing_bodyguard",
		[2] = "faction_standing_trusted_bodyguard",
		[3] = "faction_standing_personal_wingman",
	},
}
-- Reuse Nat Pagle's labels for Margoss and Fisherfriends since they are the same
T.friendStanding["conjurer margoss"] = T.friendStanding["nat pagle"]
T.friendStanding["akule riverhorn"] = T.friendStanding["nat pagle"]
T.friendStanding["ilyssia of the waters"] = T.friendStanding["nat pagle"]
T.friendStanding["impus"] = T.friendStanding["nat pagle"]
T.friendStanding["keeper raynae"] = T.friendStanding["nat pagle"]
T.friendStanding["sha'leth"] = T.friendStanding["nat pagle"]
-- Reuse Bodyguard labels
T.friendStanding["aeda brightdawn"] = T.friendStanding["vivianne"]
T.friendStanding["defender illona"] = T.friendStanding["vivianne"]
T.friendStanding["delvar ironfist"] = T.friendStanding["vivianne"]
T.friendStanding["leorajh"] = T.friendStanding["vivianne"]
T.friendStanding["talonpriest ishaal"] = T.friendStanding["vivianne"]
T.friendStanding["tormmok"] = T.friendStanding["vivianne"]


-- Reputation item IDs - BoA and BoE
T.reputationItemBoA = {
	-- Battle for Azeroth
	[165016] = "7th legion", -- Contract: 7th Legion
	[174507] = "7th legion", -- Fallen Soldier's Insignia (250)
	[153668] = "champions of azeroth", -- Contract: Champions of Azeroth
	[174502] = "champions of azeroth", -- Tear of Azeroth (250)
	[168822] = "honeyback hive", -- Thin Jelly (20)
	[168825] = "honeyback hive", -- Rich Jelly (80)
	[168828] = "honeyback hive", -- Royal Jelly (160)
	[153662] = "order of embers", -- Contract: Order of Embers
	[174503] = "order of embers", -- Exotically Spiced Carrot (250)
	[153661] = "proudmoore admiralty", -- Contract: Proudmoore Admiralty
	[174504] = "proudmoore admiralty", -- Proudmoore War Copper (250)
	[172008] = "rajani", -- Contract: Rajani
	[173374] = "rajani", -- Rajani Insignia (250)
	[168960] = "rustbolt resistance", -- Contract: Rustbolt Resistance
	[168497] = "rustbolt resistance", -- Rustbolt Resistance Insignia (100)
	[174521] = "rustbolt resistance", -- Transferable Kernel of E-steam (250)
	[153663] = "storm's wake", -- Contract: Storm's Wake
	[174505] = "storm's wake", -- Tide-Speaker's Tome (250)
	[153665] = "talanji's expedition", -- Contract: Talanji's Expedition
	[174506] = "talanji's expedition", -- Golden Insect Wings (250)
	[165017] = "the honorbound", -- Contract: The Honorbound
	[174508] = "the honorbound", -- Fallen Soldier's Insignia (250)
	[168959] = "the unshackled", -- Contract: Unshackled
	[174523] = "the unshackled", -- Waveswept Abyssal Conch (250)
	[153667] = "tortollan seekers", -- Contract: Tortollan Seekers
	[174519] = "tortollan seekers", -- Verdant Hills of Chokingvine - Page 17 (250)
	[172010] = "uldum accord", -- Contract: Uldum Accord
	[173376] = "uldum accord", -- Uldum Accord Insignia (250)
	[153666] = "voldunai", -- Contract: Voldunai
	[174501] = "voldunai", -- Ornate Voldunai Jewelry (250)
	[153664] = "zandalari empire", -- Contract: Zandalari Empire
	[174518] = "zandalari empire", -- Jani Figurine (250)
	[168956] = "waveblade ankoan", -- Contract: Ankoan
	[174522] = "waveblade ankoan", -- Waveswept Abyssal Conch (250)

	-- Legion
	[152954] = "argussian reach", -- Greater Argussian Reach Insignia (750)
	[152960] = "argussian reach", -- Argussian Reach Insignia (250)
	[152464] = "armies of legionfall", -- Greater Legionfall Insignia (750)
	[146950] = "armies of legionfall", -- Legionfall Insignia (250)
	[152955] = "army of the light", -- Greater Army of the Light Insignia (750)
	[152957] = "army of the light", -- Army of the Light Insignia (250)
	[150927] = "court of farondis", -- Greater Court of Farondis Insignia (1500)
	[146943] = "court of farondis", -- Court of Farondis Insignia (250)
	[141340] = "court of farondis", -- Court of Farondis Insignia (250)
	[150926] = "dreamweavers", -- Greater Dreamweaer Insignia (1500)
	[141339] = "dreamweavers", -- Dreamweaver Insignia (250)
	[146942] = "dreamweavers", -- Dreamweaver Insignia (250)
	[150928] = "highmountain tribe", -- Greater Highmountain Tribe Insignia (1500)
	[141341] = "highmountain tribe", -- Highmountain Tribe Insignia (250)
	[146944] = "highmountain tribe", -- Highmountain Tribe Insignia (250)
	[150930] = "the nightfallen", -- Greater Nightfallen Insignia (750)
	[141343] = "the nightfallen", -- Nightfallen Insignia (250)
	[146946] = "the nightfallen", -- Nightfallen Insignia (250)
	[150929] = "the wardens", -- Greater Wardens Insignia (1500)
	[141342] = "the wardens", -- Wardens Insignia (250)
	[146945] = "the wardens", -- Wardens Insignia (250)
	[150925] = "valarjar", -- Greater Valarjar Insignia (1500)
	[141338] = "valarjar", -- Valarjar Insignia (250)
	[146941] = "valarjar", -- Valarjar Insignia (250)

	-- Warlords of Draenor
	[128315] = "arakkoa outcasts|council of exarchs|frostwolf orcs|hand of the prophet|laughing skull orcs|order of the awakened|sha'tari defense|steamwheedle preservation society|the saberstalkers|vol'jin's headhunters", -- Medallion of the Legion (1000)
	[167924] = "arakkoa outcasts", -- Commendation of the Arakkoa Outcasts (300)
	[117492] = "arakkoa outcasts", -- Relic of Rukhmar (2500)
	[167929] = "council of exarchs", -- Commendation of the Council of Exarchs (300)
	[167928] = "frostwolf orcs", -- Commendation of the Frostwolf Orcs (300)
	[168018] = "hand of the prophet", -- Commendation of the Hand of the Prophet (300)
	[167930] = "laughing skull orcs", -- Commendation of the Laughing Skull Orcs (300)
	[167925] = "order of the awakened", -- Commendation of the Order of the Awakened (300)
	[167932] = "sha'tari defense", -- Commendation of the Sha'tari Defense (300)
	[167926] = "steamwheedle preservation society", -- Commendation of the Steamwheedle Preservation Society (300)
	[118100] = "steamwheedle preservation society", -- Highmaul Relic (350)
	[118654] = "steamwheedle preservation society", -- Aogexon's Fang (500)
	[118655] = "steamwheedle preservation society", -- Bergruu's Horn (500)
	[118656] = "steamwheedle preservation society", -- Dekorhan's Tusk (500)
	[118657] = "steamwheedle preservation society", -- Direhoof's Hide (500)
	[118658] = "steamwheedle preservation society", -- Gagrog's Skull (500)
	[118659] = "steamwheedle preservation society", -- Mu'gra's Head (500)
	[118660] = "steamwheedle preservation society", -- Thek'talon's Talon (500)
	[118661] = "steamwheedle preservation society", -- Xelganak's Stinger (500)
	[120172] = "steamwheedle preservation society", -- Vileclaw's Claw (500)
	[167927] = "the saberstalkers", -- Commendation of the Saberstalkers (300)
	[168017] = "vol'jin's headhunters", -- Commendation of Vol'jin's Headhunters (300)

	-- Mists of Pandaria
	[143943] = "dominance offensive", -- Commendation of the Dominance Offensive (300)
	[143947] = "emperor shaohao", -- Commendation of Emperor Shaohao (500)
	[94227]  = "golden lotus", -- Stolen Golden Lotus Insignia (1000)
	[143937] = "golden lotus", -- Commendation of the Golden Lotus (300)
	[90816]  = "golden lotus", -- Relic of the Thunder King (300)
	[90815]  = "golden lotus", -- Relic of Guo-Lai (150)
	[143940] = "kirin tor offensive", -- Commendation of the Kirin Tor Offensive (300)
	[143944] = "operation: shieldwall", -- Commendation of Operation: Shieldwall (300)
	[143942] = "order of the cloud serpent", -- Commendation of the Order of the Cloud Serpent (300)
	[104286] = "order of the cloud serpent", -- Quivering Firestorm Egg (1000)
	[94223]  = "shado-pan", -- Stolen Shado-Pan Insignia (1000)
	[143936] = "shado-pan", -- Commendation of the Shado-Pan (300)
	[143945] = "shado-pan assault", -- Commendation of the Shado-Pan Assault (300)
	[95496]  = "shado-pan assault", -- Shado-Pan Assault Insignia (100)
	[143939] = "sunreaver onslaught", -- Commendation of the Sunreaver Onslaught (300)
	[94225]  = "the august celestials", -- Stolen Celestial Insignia (1000)
	[143938] = "the august celestials", -- Commendation of The August Celestials (300)
	[94226]  = "the klaxxi", -- Stolen Klaxxi Insignia (1000)
	[143935] = "the klaxxi", -- Commendation of The Klaxxi (300)
	[143946] = "the anglers", -- Commendation of The Anglers (300)
	[143941] = "the tillers", -- Commendation of The Tillers (300)

	-- Cataclysm
	[63517]  = "baradin's wardens", -- Baradin's Wardens Commendation (250)
	[133150] = "dragonmaw clan", -- Commendation of the Dragonmaw Clan (500)
	[133152] = "guardians of hyjal", -- Commendation of the Guardians of Hyjal (500)
	[63518]  = "hellscream's reach", -- Hellscream's Reach Commendation (250)
	[133154] = "ramkahen", -- Commendation of the Ramkahen (500)
	[133159] = "the earthen ring", -- Commendation of The Earthen Ring (500)
	[133160] = "therazane", -- Commendation of Therazane (500)
	[133151] = "wildhammer clan", -- Commendation of the Wildhammer Clan (500)

	-- Wrath of the Lich King
	[129942] = "argent crusade", -- Commendation of the Argent Crusade (500)
	[129940] = "kirin tor", -- Commendation of the Kirin Tor (500)
	[129941] = "knights of the ebon blade", -- Commendation of the Ebon Blade (500)
	[129943] = "the sons of hodir", -- Commendation of the Sons of Hodir (500)
	[42780]  = "the sons of hodir", -- Relic of Ulduar (325 per 10)
	[129944] = "the wyrmrest accord", -- Commendation of the Wyrmrest Accord (500)
	[129954] = "horde expedition", -- Commendation of the Horde Expedition (500)
	[129955] = "alliance vanguard", -- Commendation of the Alliance Vanguard (500)

	-- The Burning Crusade
	[24401]  = "cenarion expedition", -- Unidentified Plant Parts (250 per 10, up to Honored)
	[129949] = "cenarion expedition", -- Commendation of the Cenarion Expedition (500)
	[129948] = "honor hold", -- Commendation of Honor Hold (500)
	[129950] = "keepers of time", -- Commendation of the Keepers of Time (500)
	[24449]  = "sporeggar", -- Fertile Spores (750 per 6)
	[24291]  = "sporeggar", -- Bog Lord Tendril (750 per 6, up to Friendly)
	[24246]  = "sporeggar", -- Sanguine Hibiscus (750 per 5)
	[129945] = "the consortium", -- Commendation of The Consortium (500)
	[129947] = "thrallmar", -- Commendation of Thrallmar (500)
	[129951] = "lower city", -- Commendation of Lower City (500)
	[29740]  = "the aldor", -- Fel Armament (350)
	[30809]  = "the aldor", -- Mark of Sargeras (250 per 10)
	[29425]  = "the aldor", -- Mark of Kil'jaeden (250 per 10, up to Honored)
	[29739]  = "the scryers", -- Arcane Tome (350)
	[30810]  = "the scryers", -- Sunfury Signet (250 per 10)
	[29426]  = "the scryers", -- Firewing Signet (250 per 10, up to Honored)
	[129946] = "the sha'tar", -- Commendation of The Sha'tar

	-- Classic
	[20404] = "cenarion circle", -- Encrypted Twilight Text (500 per 10)
	[17010] = "thorium brotherhood", -- Fiery Core (500)
	[17011] = "thorium brotherhood", -- Lava Core (500)
	[18945] = "thorium brotherhood", -- Dark Iron Residue (625 per 100 or 15 per 4)

	-- Guild
	[69209] = "guild", -- Illustrious Guild Tabard (50% increase)
	[69210] = "guild", -- Renowned Guild Tabard (100% increase)
}

-- Reputation item IDs - Soulbound
T.reputationItemBoP = {
	-- Battle for Azeroth
	[170184] = "the unshackled|waveblade ankoan", -- Ancient Reefwalker Bark (350 The Unshackled/Waveblade Ankoan)
	[163617] = "7th legion", -- Rusted Alliance Insignia (250)
	[163217] = "champions of azeroth", -- Azeroth's Tear (250)
	[163614] = "order of embers", -- Exotic Spices (250)
	[163616] = "proudmoore admiralty", -- Dented Coin (250)
	[173375] = "rajani", -- Rajani Insignia (250)
	[173736] = "rustbolt resistance", -- Layered Information Kernel of E-steam (250)
	[163615] = "storm's wake", -- Lost Sea Scroll (250)
	[163619] = "talanji's expedition", -- Golden Beetle (250)
	[163621] = "the honorbound", -- Rusted Horde Insignia (250)
	[170079] = "the unshackled", -- Abyssal Conch (150)
	[169942] = "the unshackled", -- Vibrant Sea Blossom (400)
	[166501] = "tortollan seekers", -- Soggy Page (250)
	[173377] = "uldum accord", -- Uldum Accord Insignia (250)
	[163618] = "voldunai", -- Shimmering Shell (250)
	[170081] = "waveblade ankoan", -- Abyssal Conch (150)
	[169941] = "waveblade ankoan", -- Ceremonial Ankoan Scabbard (400)
	[163620] = "zandalari empire", -- Island Flotsam (250)

	-- Legion
	[152961] = "argussian reach", -- Greater Argussian Reach Insignia (750)
	[152959] = "argussian reach", -- Argussian Reach Insignia (250)
	[147727] = "armies of legionfall", -- Greater Legionfall Insignia (750)
	[146949] = "armies of legionfall", -- Legionfall Insignia (250)
	[152956] = "army of the light", -- Greater Army of the Light Insignia (750)
	[152958] = "army of the light", -- Army of the Light Insignia (250)
	[138777] = "conjurer margoss", -- Drowned Mana (50)
	[147410] = "court of farondis", -- Greater Court of Farondis Insignia (1500)
	[141989] = "court of farondis", -- Greater Court of Farondis Insignia (1500)
	[146937] = "court of farondis", -- Court of Farondis Insignia (250)
	[139023] = "court of farondis", -- Court of Farondis Insignia (250)
	[141988] = "dreamweavers", -- Greater Dreamweaer Insignia (1500)
	[147411] = "dreamweavers", -- Greater Dreamweaer Insignia (1500)
	[139021] = "dreamweavers", -- Dreamweaver Insignia (250)
	[146936] = "dreamweavers", -- Dreamweaver Insignia (250)
	[141990] = "highmountain tribe", -- Greater Highmountain Tribe Insignia (1500)
	[147412] = "highmountain tribe", -- Greater Highmountain Tribe Insignia (1500)
	[139024] = "highmountain tribe", -- Highmountain Tribe Insignia (250)
	[146938] = "highmountain tribe", -- Highmountain Tribe Insignia (250)
	[147413] = "the nightfallen", -- Greater Nightfallen Insignia (750)
	[141992] = "the nightfallen", -- Greater Nightfallen Insignia (750)
	[139026] = "the nightfallen", -- Nightfallen Insignia (250)
	[146940] = "the nightfallen", -- Nightfallen Insignia (250)
	[141870] = "the nightfallen", -- Arcane Tablet of Falanar (100, up to Exalted)
	[147416] = "the nightfallen", -- Arcane Tablet of Falanar (100)
	[140260] = "the nightfallen", -- Arcane Remnant of Falanar (25, up to Exalted)
	[147418] = "the nightfallen", -- Arcane Remnant of Falanar (25)
	[141991] = "the wardens", -- Greater Wardens Insignia (1500)
	[147415] = "the wardens", -- Greater Wardens Insignia (1500)
	[139025] = "the wardens", -- Wardens Insignia (250)
	[146939] = "the wardens", -- Wardens Insignia (250)
	[141987] = "valarjar", -- Greater Valarjar Insignia (1500)
	[147414] = "valarjar", -- Greater Valarjar Insignia (1500)
	[139020] = "valarjar", -- Valarjar Insignia (250)
	[146935] = "valarjar", -- Valarjar Insignia (250)
	[142363] = "talon's vengeance", -- Mark of Prey (100)
	[146960] = "akule riverhorn", -- Ancient Totem Fragment (75)
	[146961] = "corbyn", -- Shiny Bauble (75)
	[146848] = "ilyssia of the waters", -- Framented Enchantment (75)
	[146963] = "impus", -- Desecrated Seaweed (75)
	[146959] = "keeper rayne", -- Corrupted Globule (75)
	[146962] = "sha'leth", -- Golden Minnow (75)

	-- Warlords of Draenor
	[118099] = "steamwheedle preservation society", -- Gorian Artifact Fragment (250 per 20)

	-- Mists of Pandaria
	[86592]  = "golden lotus|order of the cloud serpent|shado-pan|the anglers|the august celestials|the klaxxi|the lorewalkers|the tillers", -- Hozen Peace Pipe (1000)
	[79265]  = "chee chee|old hillpaw", -- Blue Feather (900 with Chee Chee or Old Hillpaw, 540 with other Tillers members)
	[79266]  = "ella|fish fellreed", -- Jade Cat (900 with Ella or Fish Fellreed, 540 with other Tillers members)
	[79267]  = "jogu the drunk|sho", -- Lovely Apple (900 with Jogu the Drunk or Sho, 540 with other Tillers members)
	[79268]  = "farmer fung|gina mudclaw", -- Marsh Lily (900 with Farmer Fung or Gina Mudclaw, 540 with other Tillers members)
	[79264]  = "haohan mudclaw|tina mudclaw", -- Ruby Shard (900 with Haohan Mudclaw or Tina Mudclaw, 540 with other Tillers members)
	[89155]  = "order of the cloud serpent", -- Onyx Egg (500)

	-- Cataclysm
	[65909]  = "dragonmaw clan", -- Tabard of the Dragonmaw Clan
	[65906]  = "guardians of hyjal", -- Tabard of the Guardians of Hyjal
	[65904]  = "ramkahen", -- Tabard of Ramkahen
	[65905]  = "the earthen ring", -- Tabard of the Earthen Ring
	[65907]  = "therazane", -- Tabard of Therazane
	[65908]  = "wildhammer clan", -- Tabard of the Wildhammer Clan

	-- Wrath of the Lich King
	[44711]  = "argent crusade", -- Argent Crusade Commendation Badge (520)
	[43154]  = "argent crusade", -- Tabard of the Argent Crusade
	[44713]  = "knights of the ebon blade", -- Ebon Blade Commendation Badge (520)
	[43155]  = "knights of the ebon blade", -- Tabard of the Ebon Blade
	[43950]  = "kirin tor", -- Kirin Tor Commendation Badge
	[43157]  = "kirin tor", -- Tabard of the Kirin Tor
	[49702]  = "the Sons of hodir", -- Sons of Hodir Commendation Badge (520)
	[44710]  = "wyrmrest cccord", -- Wyrmrest Commendation Badge (520)
	[43156]  = "wyrmrest accord", -- Tabard of the Wyrmrest Accord

	-- The Burning Crusade
	[24290]  = "sporeggar", -- Mature Spore Sack (750 per 10, up to Friendly)
	[32506]  = "netherwing", -- Netherwing Egg (250)
	[25433]  = "kurenai|the consortium|the mag'har", -- Obsidian Warbeads (250 Consortium per 10, or 500 Kurenai/Mag'har per 10)
	[29209]  = "the consortium", -- Zaxxis Insignia (250 per 10)
	[25416]  = "the consortium", -- Oshu'gun Crystal Fragment (250 per 10, up to Friendly)
	[25463]  = "the consortium", -- Pair of Ivory Tusks (250 per 3, up to Friendly)

	-- Classic
	[71088]  = "bilgewater cartel", -- Bilgewater Writ of Commendation (250)
	[64884]  = "bilgewater cartel", -- Bilgewater Cartel Tabard
	[45720]  = "darkspear trolls", -- Sen'jin Commendation Badge (250)
	[70150]  = "darkspear trolls", -- Sen'jin Writ of Commendation (250)
	[45582]  = "darkspear trolls", -- Darkspear Tabard
	[45714]  = "darnassus", -- Darnassus Commendation Badge (250)
	[70145]  = "darnassus", -- Darnassus Writ of Commendation (250)
	[45579]  = "darnassus", -- Darnassus Tabard
	[45715]  = "exodar", -- Exodar Commendation Badge (250)
	[70146]  = "exodar", -- Exodar Writ of Commendation (250)
	[45580]  = "exodar", -- Exodar Tabard
	[71087]  = "gilneas", -- Gilneas Writ of Commendation (250)
	[64882]  = "gilneas", -- Gilneas Tabard
	[45716]  = "gnomeregan", -- Gnomeregan Commendation Badge (250)
	[70147]  = "gnomeregan", -- Gnomeregan Writ of Commendation (250)
	[45578]  = "gnomeregan", -- Gnomeregan Tabard
	[83080]  = "huojin pandaren", -- Huojin Tabard
	[45717]  = "ironforge", -- Ironforge Commendation Badge (250)
	[70148]  = "ironforge", -- Ironforge Writ of Commendation (250)
	[45577]  = "ironforge", -- Ironforge Tabard
	[45719]  = "orgrimmar", -- Orgrimmar Commendation Badge (250)
	[70149]  = "orgrimmar", -- Orgrimmar Writ of Commendation (250)
	[45581]  = "orgrimmar", -- Orgrimmar Tabard
	[45721]  = "silvermoon city", -- Silvermoon Commendation Badge (250)
	[70151]  = "silvermoon city", -- Silvermoon Writ of Commendation (250)
	[45585]  = "silvermoon city", -- Silvermoon City Tabard
	[45718]  = "stormwind", -- Stormwind Commendation Badge (250)
	[70152]  = "stormwind", -- Stormwind Writ of Commendation (250)
	[45574]  = "stormwind", -- Stormwind Tabard
	[45722]  = "thunder bluff", -- Thunder Bluff Commendation Badge (250)
	[70153]  = "thunder bluff", -- Thunder Bluff Writ of Commendation (250)
	[45584]  = "thunder bluff", -- Thunder Bluff Tabard
	[83079]  = "tushui pandaren", -- Tushui Tabard
	[45723]  = "undercity", -- Undercity Commendation Badge (250)
	[70154]  = "undercity", -- Undercity Writ of Commendation (250)
	[45583]  = "undercity", -- Undercity Tabard
	[21377]  = "timbermaw hold", -- Deadwood Headdress Feather (2000 per 5)
	[21383]  = "timbermaw hold", -- Winterfall Spirit Beads (2000 per 5)
}


-- Factions
T.faction = {
	-- Guild
	["guild"] 								= { ["id"] = 1168, 	["icon"] = 135026, 		["paragon"] = false,	["friend"] = 0, ["factionGroup"] = false, },

	-- Battle for Azeroth
	["7th legion"]							= { ["id"] = 2159, 	["icon"] = 2032591, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["champions of azeroth"]				= { ["id"] = 2164, 	["icon"] = 2032592, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = false, },
	["honeyback hive"]						= { ["id"] = 2395,  ["icon"] = 2027853,		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["order of embers"]						= { ["id"] = 2161, 	["icon"] = 2032594, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["proudmoore admiralty"]				= { ["id"] = 2160, 	["icon"] = 2065573, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["rajani"]								= { ["id"] = 2415, 	["icon"] = 3196265, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = false, },
	["rustbolt resistance"]					= { ["id"] = 2391, 	["icon"] = 2909316, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = false, },
	["storm's wake"]						= { ["id"] = 2162, 	["icon"] = 2032596, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["talanji's expedition"]				= { ["id"] = 2156, 	["icon"] = 2032597, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["the honorbound"]						= { ["id"] = 2157, 	["icon"] = 2032593, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["the unshackled"]						= { ["id"] = 2373,  ["icon"] = 2821782,		["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["tortollan seekers"]					= { ["id"] = 2163, 	["icon"] = 2032598, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = false, },
	["uldum accord"]						= { ["id"] = 2417, 	["icon"] = 3196264, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = false, },
	["voldunai"]							= { ["id"] = 2158, 	["icon"] = 2032599, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["waveblade ankoan"]					= { ["id"] = 2400,  ["icon"] = 2909045,		["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["zandalari empire"]					= { ["id"] = 2103, 	["icon"] = 2032601, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = "Horde", },

	-- Legion
	["argussian reach"] 					= { ["id"] = 2170, 	["icon"] = 1708496, 	["paragon"] = true,		["friend"] = 0, ["factionGroup"] = false, },
	["armies of legionfall"] 				= { ["id"] = 2045, 	["icon"] = 1585421, 	["paragon"] = true,		["friend"] = 0, ["factionGroup"] = false, },
	["army of the light"] 					= { ["id"] = 2165, 	["icon"] = 1708497, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = false, },
	["chromie"]								= { ["id"] = 2135, 	["icon"] = 237538, 		["paragon"] = false, 	["friend"] = 7, ["factionGroup"] = false, },
	["conjurer margoss"]					= { ["id"] = 1975, 	["icon"] = 132852, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, },
	["court of farondis"] 					= { ["id"] = 1900, 	["icon"] = 1394952, 	["paragon"] = true,  	["friend"] = 0, ["factionGroup"] = false, },
	["dreamweavers"] 						= { ["id"] = 1883, 	["icon"] = 1394953, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = false, },
	["highmountain tribe"] 					= { ["id"] = 1828, 	["icon"] = 1394954, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = false, },
	["the nightfallen"] 					= { ["id"] = 1859, 	["icon"] = 1394956, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = false, },
	["the wardens"] 						= { ["id"] = 1894, 	["icon"] = 1394958, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = false, },
	["valarjar"] 							= { ["id"] = 1948, 	["icon"] = 1394957, 	["paragon"] = true, 	["friend"] = 0, ["factionGroup"] = false, },
	["talon's vengeance"]					= { ["id"] = 2018, 	["icon"] = 537444, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	-- Fisherfriends
	["akule riverhorn"]						= { ["id"] = 2099, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, },
	["corbyn"]								= { ["id"] = 2100, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, }, -- maybe 132915
	["ilyssia of the waters"]				= { ["id"] = 2097, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, },
	["impus"]								= { ["id"] = 2102, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, }, -- maybe 136218
	["keeper raynae"]						= { ["id"] = 2098, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, },
	["sha'leth"]							= { ["id"] = 2101, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, },

	-- Warlords of Draenor
	["arakkoa outcasts"]					= { ["id"] = 1515, 	["icon"] = 1042646, 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["council of exarchs"]					= { ["id"] = 1731, 	["icon"] = 1048727, 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["frostwolf orcs"]						= { ["id"] = 1445, 	["icon"] = 1044164, 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["hand of the prophet"]					= { ["id"] = 1847, 	["icon"] = 1048305,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", }, -- temp icon
	["laughing skull orcs"]					= { ["id"] = 1708, 	["icon"] = 1043559, 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["order of the awakened"]				= { ["id"] = 1849, 	["icon"] = 1240656, 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["sha'tari defense"]					= { ["id"] = 1710, 	["icon"] = 1042739, 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["steamwheedle preservation society"]	= { ["id"] = 1711, 	["icon"] = 1052654, 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["the saberstalkers"]					= { ["id"] = 1850, 	["icon"] = 1240657, 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["vol'jin's headhunters"]				= { ["id"] = 1848, 	["icon"] = 1048305, 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", }, -- temp icon
	["vol'jin's spear"]						= { ["id"] = 1681, 	["icon"] = 1042727, 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["wrynn's vanguard"]					= { ["id"] = 1682, 	["icon"] = 1042294, 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	-- Barracks Bodyguards
	["aeda brightdawn"]						= { ["id"] = 1740, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["factionGroup"] = "Horde", },
	["defender illona"]						= { ["id"] = 1738, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["factionGroup"] = "Alliance", },
	["delvar ironfist"]						= { ["id"] = 1733, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["factionGroup"] = "Alliance", },
	["leorajh"]								= { ["id"] = 1741, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["factionGroup"] = false, },
	["talonpriest ishaal"]					= { ["id"] = 1737, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["factionGroup"] = false, },
	["tormmok"]								= { ["id"] = 1736, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["factionGroup"] = false, },
	["vivianne"]							= { ["id"] = 1739, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["factionGroup"] = "Horde", },

	-- Mists of Pandaria
	["dominance offensive"]					= { ["id"] = 1375, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["emperor shaohao"]						= { ["id"] = 1492, 	["icon"] = 607848, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["forest hozen"]						= { ["id"] = 1228, 	["icon"] = 132159, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", }, -- temp icon
	["golden lotus"]						= { ["id"] = 1269, 	["icon"] = 643910, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["kirin tor offensive"]					= { ["id"] = 1387, 	["icon"] = 801132, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["operation: shieldwall"]				= { ["id"] = 1376, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["order of the cloud serpent"]			= { ["id"] = 1271, 	["icon"] = 646324, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["pearlfin jinyu"]						= { ["id"] = 1242, 	["icon"] = 463858, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", }, -- temp icon
	["shado-pan"]							= { ["id"] = 1270, 	["icon"] = 645204, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["shado-pan assault"]					= { ["id"] = 1435, 	["icon"] = 838811, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["sunreaver onslaught"]					= { ["id"] = 1388, 	["icon"] = 838819, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["the august celestials"]				= { ["id"] = 1341, 	["icon"] = 645203, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["the black prince"]					= { ["id"] = 1359, 	["icon"] = 656543, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["the klaxxi"]							= { ["id"] = 1337, 	["icon"] = 646377, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["the lorewalkers"]						= { ["id"] = 1345, 	["icon"] = 617219, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["the anglers"]							= { ["id"] = 1302, 	["icon"] = 643874, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["nat pagle"]							= { ["id"] = 1358, 	["icon"] = 133152, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, },
	["the tillers"]							= { ["id"] = 1272, 	["icon"] = 645198, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	-- The Tillers
	["chee chee"]							= { ["id"] = 1277, 	["icon"] = 132926, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, }, -- blue feather
	["ella"]								= { ["id"] = 1275, 	["icon"] = 454045, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, }, -- jade cat
	["farmer fung"]							= { ["id"] = 1283, 	["icon"] = 134210, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, }, -- marsh lily
	["fish fellreed"]						= { ["id"] = 1282, 	["icon"] = 454045, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, }, -- jade cat
	["gina mudclaw"]						= { ["id"] = 1281, 	["icon"] = 134210, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, }, -- marsh lily
	["haohan mudclaw"]						= { ["id"] = 1279, 	["icon"] = 237204, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, }, -- ruby shard
	["jogu the drunk"]						= { ["id"] = 1273, 	["icon"] = 133975, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, }, -- lovely apple
	["old hillpaw"]							= { ["id"] = 1276, 	["icon"] = 132926, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, }, -- blue feather
	["sho"]									= { ["id"] = 1278, 	["icon"] = 133975, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, }, -- lovely apple
	["tina mudclaw"]						= { ["id"] = 1280, 	["icon"] = 237204, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, }, -- ruby shard
	-- Hidden
	["nomi"]								= { ["id"] = 1357, 	["icon"] = 571695, 		["paragon"] = false, 	["friend"] = 6, ["factionGroup"] = false, }, -- hidden from the Reputation Panel

	-- Cataclysm
	["avengers of hyjal"]					= { ["id"] = 1204, 	["icon"] = 512609, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["baradin's wardens"]					= { ["id"] = 1177, 	["icon"] = 456564, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["dragonmaw clan"]						= { ["id"] = 1172, 	["icon"] = 456565, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["guardians of hyjal"]					= { ["id"] = 1158, 	["icon"] = 456570, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["hellscream's reach"]					= { ["id"] = 1178, 	["icon"] = 456571, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["ramkahen"]							= { ["id"] = 1173, 	["icon"] = 456574, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["the earthen ring"]					= { ["id"] = 1135, 	["icon"] = 456567, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["therazane"]							= { ["id"] = 1171, 	["icon"] = 456572, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["wildhammer clan"]						= { ["id"] = 1174, 	["icon"] = 456575, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },

	-- Wrath of the Lich King
	["argent crusade"]						= { ["id"] = 1106, 	["icon"] = 236689, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["kirin tor"]							= { ["id"] = 1090, 	["icon"] = 236693, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["knights of the ebon blade"]			= { ["id"] = 1098, 	["icon"] = 236694, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["the ashen verdict"]					= { ["id"] = 1156, 	["icon"] = 343640, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, }, -- actual icon is same as argent crusade, use 343640 instead
	["the kalu'ak"]							= { ["id"] = 1073, 	["icon"] = 236697, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["the sons of hodir"]					= { ["id"] = 1119, 	["icon"] = 254107, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["the wyrmrest accord"]					= { ["id"] = 1091, 	["icon"] = 236699, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["alliance vanguard"]					= { ["id"] = 1037, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", }, -- generic alliance icon
	["explorer's league"]					= { ["id"] = 1068, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", }, -- generic alliance icon
	["the frostborn"]						= { ["id"] = 1126, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", }, -- generic alliance icon
	["the silver covenant"]					= { ["id"] = 1094, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", }, -- generic alliance icon - tabard uses 134472
	["valiance expedition"]					= { ["id"] = 1050, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", }, -- generic alliance icon
	["horde expedition"]					= { ["id"] = 1052, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", }, -- generic horde icon
	["the hand of vengeance"]				= { ["id"] = 1067, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", }, -- generic horde icon
	["the sunreavers"]						= { ["id"] = 1124, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", }, -- generic horde icon - tabard uses 134473
	["the taunka"]							= { ["id"] = 1064, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", }, -- generic horde icon
	["warsong offensive"]					= { ["id"] = 1085, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", }, -- generic horde icon
	-- Sholazar Basin
	["frenzyheart tribe"]					= { ["id"] = 1104, 	["icon"] = 236698, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["the oracles"]							= { ["id"] = 1105, 	["icon"] = 252780, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },

	-- The Burning Crusade
	["ashtongue deathsworn"]				= { ["id"] = 1012, 	["icon"] = 236691, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["cenarion expedition"]					= { ["id"] = 942, 	["icon"] = 132280, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, }, -- guardian of cenarius icon
	["honor hold"]							= { ["id"] = 946, 	["icon"] = 134502, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["keepers of time"]						= { ["id"] = 989, 	["icon"] = 134156, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, }, -- generic bronze dragon icon
	["kurenai"]								= { ["id"] = 978, 	["icon"] = 458240, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", }, -- generic icon
	["netherwing"]							= { ["id"] = 1015, 	["icon"] = 132250, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["ogri'la"]								= { ["id"] = 1038, 	["icon"] = 133594, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, }, -- alt 236695
	["sporeggar"]							= { ["id"] = 970, 	["icon"] = 134532, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["the consortium"]						= { ["id"] = 933, 	["icon"] = 132881, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, }, -- alt 236426
	["the mag'har"]							= { ["id"] = 941, 	["icon"] = 970886, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["the scale of the sands"]				= { ["id"] = 990, 	["icon"] = 136106, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["the violet eye"]						= { ["id"] = 967, 	["icon"] = 236693, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, }, -- kirin tor icon
	["thrallmar"]							= { ["id"] = 947, 	["icon"] = 134504, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["tranquillien"]						= { ["id"] = 922, 	["icon"] = 236765, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	-- Shattrath City
	["lower city"]							= { ["id"] = 1011, 	["icon"] = 135760, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["sha'tari skyguard"]					= { ["id"] = 1031, 	["icon"] = 132191, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["shattered sun offensive"]				= { ["id"] = 1077, 	["icon"] = 134993, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["the aldor"]							= { ["id"] = 932, 	["icon"] = 255137, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["the scryers"]							= { ["id"] = 934, 	["icon"] = 255136, 		["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["the sha'tar"]							= { ["id"] = 935, 	["icon"] = 1708140, 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },

	-- Classic
	["argent dawn"]							= { ["id"] = 529, 	["icon"] = 133440,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["bloodsail buccaneers"]				= { ["id"] = 87, 	["icon"] = 133168,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["brood of nozdormu"]					= { ["id"] = 910, 	["icon"] = 134156,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["cenarion circle"]						= { ["id"] = 609, 	["icon"] = 132280,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["darkmoon faire"]						= { ["id"] = 909, 	["icon"] = 1100024,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["hydraxian waterlords"]				= { ["id"] = 749, 	["icon"] = 135862,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["ravenholdt"]							= { ["id"] = 349, 	["icon"] = 132299,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["thorium brotherhood"]					= { ["id"] = 59, 	["icon"] = 1786406,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["timbermaw hold"]						= { ["id"] = 576, 	["icon"] = 236696,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["wintersaber trainers"]				= { ["id"] = 589, 	["icon"] = 132252,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	-- Alliance
	["darnassus"]							= { ["id"] = 69, 	["icon"] = 255141,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["exodar"]								= { ["id"] = 930, 	["icon"] = 255137,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["gilneas"]								= { ["id"] = 1134, 	["icon"] = 466012,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["gnomeregan"]							= { ["id"] = 54, 	["icon"] = 255139,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["ironforge"]							= { ["id"] = 47, 	["icon"] = 255138,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["stormwind"]							= { ["id"] = 72, 	["icon"] = 255140,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["tushui pandaren"]						= { ["id"] = 1353, 	["icon"] = 626190,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	-- Alliance Forces
	["silverwing sentinels"]				= { ["id"] = 890, 	["icon"] = 132279,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["stormpike guard"]						= { ["id"] = 730, 	["icon"] = 133433,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	["the league of arathor"]				= { ["id"] = 509, 	["icon"] = 132351,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Alliance", },
	-- Horde
	["bilgewater cartel"]					= { ["id"] = 1133, 	["icon"] = 463834,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["darkspear trolls"]					= { ["id"] = 530, 	["icon"] = 255145,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["huojin pandaren"]						= { ["id"] = 1352, 	["icon"] = 626190,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["orgrimmar"]							= { ["id"] = 76, 	["icon"] = 255142,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["silvermoon city"]						= { ["id"] = 911, 	["icon"] = 255136,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["thunder bluff"]						= { ["id"] = 81, 	["icon"] = 255144,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["undercity"]							= { ["id"] = 68, 	["icon"] = 255143,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	-- Horde Forces
	["frostwolf clan"]						= { ["id"] = 729, 	["icon"] = 133283,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["the defilers"]						= { ["id"] = 510, 	["icon"] = 237568,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	["warsong outriders"]					= { ["id"] = 889, 	["icon"] = 132366,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = "Horde", },
	-- Steamwheedle Cartel
	["booty bay"]							= { ["id"] = 21, 	["icon"] = 236844,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["everlook"]							= { ["id"] = 577, 	["icon"] = 236854,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["gadgetzan"]							= { ["id"] = 369, 	["icon"] = 236846,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
	["ratchet"]								= { ["id"] = 470, 	["icon"] = 236717,	 	["paragon"] = false, 	["friend"] = 0, ["factionGroup"] = false, },
}



local LL= {}

-- Localization Data

-- Translate this (including the "Notes:" part in Paragon.toc) and submit using CurseForge:
-- https://wow.curseforge.com/projects/paragon

-- Don't worry about translating the faction names - that is easily done via Wowhead!



-- English
LL["enUS"] = {
	-- Faction standing labels
	["faction_standing_paragon"] 			= "Paragon",
	-- Defaults (also used by Halfhill factions, etc)
	["faction_standing_stranger"] 			= "Stranger",
	["faction_standing_acquaintance"] 		= "Acquaintance",
	["faction_standing_buddy"] 				= "Buddy",
	["faction_standing_friend"] 			= "Friend",
	["faction_standing_good_friend"]		= "Good Friend",
	["faction_standing_best_friend"] 		= "Best Friend",
	-- Nat Pagle/Conjurer Margoss/Fisherfriends
	["faction_standing_pal"] 				= "Pal",
	-- Corbyn
	["faction_standing_curiosity"] 			= "Curiosity",
	["faction_standing_non-threat"] 		= "Non-Threat",
	["faction_standing_helpful_friend"]		= "Helpful Friend",
	-- Chromie
	["faction_standing_whelpling"] 			= "Whelpling",
	["faction_standing_temporal_trainee"] 	= "Temporal Trainee",
	["faction_standing_timehopper"] 		= "Timehopper",
	["faction_standing_chrono-friend"] 		= "Chrono-Friend",
	["faction_standing_bronze_ally"] 		= "Bronze Ally",
	["faction_standing_epoch-mender"] 		= "Epoch-Mender",
	["faction_standing_timelord"] 			= "Timelord",
	-- Barracks Bodyguards
	["faction_standing_bodyguard"] 			= "Bodyguard",
	["faction_standing_trusted_bodyguard"]	= "Trusted Bodyguard",
	["faction_standing_personal_wingman"]	= "Personal Wingman",


	-- Global
	["highest reputation"] 					= "Highest Reputation",
	["lowest reputation"] 					= "Lowest Reputation",

	-- Tooltips
	["hold shift for more"] 				= "<Hold Shift for More>",
	["hold shift for highest reputation"] 	= "<Hold Shift for Highest Reputation>",

	-- Slash Commands
	["/paragon help"] = "|cFF00FFFFParagon|r Usage:\n|cff00ffff/paragon <faction>|r  List Highest Reputation for the specified faction in chat\n|cff00ffff/paragon delete <name or name-realm>|r  Delete a character's data",  --\n|cff00ffff/paragon config|r  Open the Options Panel

	["/paragon delete no argument"] 		= "|cFF00FFFFParagon|r: No character name specified.",
	["delete character not found"]			= "|cFF00FFFFParagon|r: There is nothing to remove for \"%s\". Make sure you include the character's realm if it's not on %s.",
	["delete character successful"] 		= "|cFF00FFFFParagon|r: Removed all data for \"%s\".",

	-- Results Window
	["reputation not discovered"]			= "None of your characters have discovered\n%s yet.",
	["no results"]							= "Nothing to display for %s.",

	-- Settings Panel
	["cfgFrameSubtext"] 					= "You can list characters that have reputation with a specific faction by typing |cff00ffff/paragon <faction>|r in chat.",
	["cfgChatOutputLimitLabel"] 			= "Maximum Chat Lines",
	["cfgTooltipHeader"] 					= "Item Tooltips",
	["cfgTooltipSubtext"] 					= "Paragon can add additional information to tooltips for reputation related items.",
	["cfgTooltipPersonalEnabled"] 			= "Show Your Current Reputation",
	["cfgHighestReputationLabel"] 			= "Character List",
	["cfgTooltipAltsEnabled"] 				= "Show Highest Reputation",
	["cfgTooltipAltsEnabledShift"] 			= "Show Extended Highest Reputation When Holding |cff00ff00<Shift>|r",
	["cfgTooltipAltsEnabledAlt"] 			= "Switch to Lowest Reputation When Holding |cff00ff00<Alt>|r",
	["cfgTooltipAltsLimitLabel"] 			= "Characters Listed",
	["cfgTooltipAltsLimitShiftLabel"] 		= "When Holding |cff00ff00<Shift>|r",
	["cfgTooltipFiltersLabel"] 				= "Filters",
	["cfgTooltipHideExalted"] 				= "Exclude "..T.standingColor[8].."Exalted|r Characters from Character List (Non-Paragon Reputations)",
	["cfgTooltipHideNeutral"] 				= "Exclude "..T.standingColor[4].."Neutral|r Characters from Character List",
	["cfgTooltipHideUnfriendly"] 			= "Exclude "..T.standingColor[3].."Unfriendly|r, "..T.standingColor[2].."Hostile|r and "..T.standingColor[1].."Hated|r Characters from Character List",
	["cfgShortRealmNames"] 					= "Shorten Realm Names to Acronyms",


	-- Faction Names
	-- These should match the name displayed in game in the Reputation UI Panel

	-- Guild
	["f guild"] 							= "Guild",

	-- Battle for Azeroth
	["f 7th legion"]						= "7th Legion",
	["f champions of azeroth"]				= "Champions of Azeroth",
	["f honeyback hive"] 					= "Honeyback Hive",
	["f order of embers"]					= "Order of Embers",
	["f proudmoore admiralty"]				= "Proudmoore Admiralty",
	["f rajani"]							= "Rajani",
	["f rustbolt resistance"] 				= "Rustbolt Resistance",
	["f storm's wake"]						= "Storm's Wake",
	["f talanji's expedition"]				= "Talanji's Expedition",
	["f the honorbound"]					= "The Honorbound",
	["f the unshackled"] 					= "The Unshackled",
	["f tortollan seekers"]					= "Tortollan Seekers",
	["f uldum accord"] 						= "Uldum Accord",
	["f voldunai"]							= "Voldunai",
	["f waveblade ankoan"] 					= "Waveblade Ankoan",
	["f zandalari empire"]					= "Zandalari Empire",

	-- Legion
	["f argussian reach"] 					= "Argussian Reach",
	["f armies of legionfall"] 				= "Armies of Legionfall",
	["f army of the light"] 				= "Army of the Light",
	["f chromie"] 							= "Chromie",
	["f conjurer margoss"] 					= "Conjurer Margoss",
	["f court of farondis"] 				= "Court of Farondis",
	["f dreamweavers"] 						= "Dreamweavers",
	["f highmountain tribe"] 				= "Highmountain Tribe",
	["f the nightfallen"] 					= "The Nightfallen",
	["f the wardens"] 						= "The Wardens",
	["f valarjar"] 							= "Valarjar",
	["f talon's vengeance"] 				= "Talon's Vengeance",
	-- Fisherfriends
	["f akule riverhorn"] 					= "Akule Riverhorn",
	["f corbyn"] 							= "Corbyn",
	["f ilyssia of the waters"] 			= "Ilyssia of the Waters",
	["f impus"] 							= "Impus",
	["f keeper raynae"] 					= "Keeper Raynae",
	["f sha'leth"] 							= "Sha'leth",

	-- Warlords of Draenor
	["f arakkoa outcasts"] 					= "Arakkoa Outcasts",
	["f council of exarchs"]				= "Council of Exarchs",
	["f frostwolf orcs"]					= "Frostwolf Orcs",
	["f hand of the prophet"]				= "Hand of the Prophet",
	["f laughing skull orcs"]				= "Laughing Skull Orcs",
	["f order of the awakened"]				= "Order of the Awakened",
	["f sha'tari defense"]					= "Sha'tari Defense",
	["f steamwheedle preservation society"]	= "Steamwheedle Preservation Society",
	["f the saberstalkers"]					= "The Saberstalkers",
	["f vol'jin's headhunters"]				= "Vol'jin's Headhunters",
	["f vol'jin's spear"]					= "Vol'jin's Spear",
	["f wrynn's vanguard"]					= "Wrynn's Vanguard",
	-- Barracks Bodyguards
	["f aeda brightdawn"]					= "Aeda Brightdawn",
	["f defender illona"]					= "Defender Illona",
	["f delvar ironfist"]					= "Delvar Ironfist",
	["f leorajh"]							= "Leorajh",
	["f talonpriest ishaal"]				= "Talonpriest Ishaal",
	["f tormmok"]							= "Tormmok",
	["f vivianne"]							= "Vivianne",

	-- Mists of Pandaria
	["f dominance offensive"]				= "Dominance Offensive",
	["f emperor shaohao"]					= "Emperor Shaohao",
	["f forest hozen"]						= "Forest Hozen",
	["f golden lotus"]						= "Golden Lotus",
	["f kirin tor offensive"]				= "Kirin Tor Offensive",
	["f operation: shieldwall"]				= "Operation: Shieldwall",
	["f order of the cloud serpent"]		= "Order of the Cloud Serpent",
	["f pearlfin jinyu"]					= "Pearlfin Jinyu",
	["f shado-pan"]							= "Shado-Pan",
	["f shado-pan assault"]					= "Shado-Pan Assault",
	["f sunreaver onslaught"]				= "Sunreaver Onslaught",
	["f the august celestials"]				= "The August Celestials",
	["f the black prince"]					= "The Black Prince",
	["f the klaxxi"]						= "The Klaxxi",
	["f the lorewalkers"]					= "The Lorewalkers",
	["f the anglers"]						= "The Anglers",
	["f nat pagle"]							= "Nat Pagle",
	["f the tillers"]						= "The Tillers",
	["f chee chee"]							= "Chee Chee",
	["f ella"]								= "Ella",
	["f farmer fung"]						= "Farmer Fung",
	["f fish fellreed"]						= "Fish Fellreed",
	["f gina mudclaw"]						= "Gina Mudclaw",
	["f haohan mudclaw"]					= "Haohan Mudclaw",
	["f jogu the drunk"]					= "Jogu the Drunk",
	["f old hillpaw"]						= "Old Hillpaw",
	["f sho"]								= "Sho",
	["f tina mudclaw"]						= "Tina Mudclaw",
	["f nomi"]								= "Nomi", -- Hidden from the Reputation Panel

	-- Cataclysm
	["f avengers of hyjal"]					= "Avengers of Hyjal",
	["f baradin's wardens"]					= "Baradin's Wardens",
	["f dragonmaw clan"]					= "Dragonmaw Clan",
	["f guardians of hyjal"]				= "Guardians of Hyjal",
	["f hellscream's reach"]				= "Hellscream's Reach",
	["f ramkahen"]							= "Ramkahen",
	["f the earthen ring"]					= "The Earthen Ring",
	["f therazane"]							= "Therazane",
	["f wildhammer clan"]					= "Wildhammer Clan",

	-- Wrath of the Lich King
	["f argent crusade"]					= "Argent Crusade",
	["f kirin tor"]							= "Kirin Tor",
	["f knights of the ebon blade"]			= "Knights of the Ebon Blade",
	["f the ashen verdict"]					= "The Ashen Verdict",
	["f the kalu'ak"]						= "The Kalu'ak",
	["f the sons of hodir"]					= "The Sons of Hodir",
	["f the wyrmrest accord"]				= "The Wyrmrest Accord",
	["f alliance vanguard"]					= "Alliance Vanguard",
	["f explorer's league"]					= "Explorer's League",
	["f the frostborn"]						= "The Frostborn",
	["f the silver covenant"]				= "The Silver Covenant",
	["f valiance expedition"]				= "Valiance Expedition",
	["f horde expedition"]					= "Horde Expedition",
	["f the hand of vengeance"]				= "The Hand of Vengeance",
	["f the sunreavers"]					= "The Sunreavers",
	["f the taunka"]						= "The Taunka",
	["f warsong offensive"]					= "Warsong Offensive",
	-- Sholazar Basin
	["f frenzyheart tribe"]					= "Frenzyheart Tribe",
	["f the oracles"]						= "The Oracles",

	-- The Burning Crusade
	["f ashtongue deathsworn"]				= "Ashtongue Deathsworn",
	["f cenarion expedition"]				= "Cenarion Expedition",
	["f honor hold"]						= "Honor Hold",
	["f keepers of time"]					= "Keepers of Time",
	["f kurenai"]							= "Kurenai",
	["f netherwing"]						= "Netherwing",
	["f ogri'la"]							= "Ogri'la",
	["f sporeggar"]							= "Sporeggar",
	["f the consortium"]					= "The Consortium",
	["f the mag'har"]						= "The Mag'har",
	["f the scale of the sands"]			= "The Scale of the Sands",
	["f the violet eye"]					= "The Violet Eye",
	["f thrallmar"]							= "Thrallmar",
	["f tranquillien"]						= "Tranquillien",
	-- Shattrath City
	["f lower city"]						= "Lower City",
	["f sha'tari skyguard"]					= "Sha'tari Skyguard",
	["f shattered sun offensive"]			= "Shattered Sun Offensive",
	["f the aldor"]							= "The Aldor",
	["f the scryers"]						= "The Scryers",
	["f the sha'tar"]						= "The Sha'tar",

	-- Classic
	["f argent dawn"]						= "Argent Dawn",
	["f bloodsail buccaneers"]				= "Bloodsail Buccaneers",
	["f brood of nozdormu"]					= "Brood of Nozdormu",
	["f cenarion circle"]					= "Cenarion Circle",
	["f darkmoon faire"]					= "Darkmoon Faire",
	["f hydraxian waterlords"]				= "Hydraxian Waterlords",
	["f ravenholdt"]						= "Ravenholdt",
	["f thorium brotherhood"]				= "Thorium Brotherhood",
	["f timbermaw hold"]					= "Timbermaw Hold",
	["f wintersaber trainers"]				= "Wintersaber Trainers",
	-- Alliance
	["f darnassus"]							= "Darnassus",
	["f exodar"]							= "Exodar",
	["f gilneas"]							= "Gilneas",
	["f gnomeregan"]						= "Gnomeregan",
	["f ironforge"]							= "Ironforge",
	["f stormwind"]							= "Stormwind",
	["f tushui pandaren"]					= "Tushui Pandaren",
	-- Alliance Forces
	["f silverwing sentinels"]				= "Silverwing Sentinels",
	["f stormpike guard"]					= "Stormpike Guard",
	["f the league of arathor"]				= "The League of Arathor",
	-- Horde
	["f bilgewater cartel"]					= "Bilgewater Cartel",
	["f darkspear trolls"]					= "Darkspear Trolls",
	["f huojin pandaren"]					= "Huojin Pandaren",
	["f orgrimmar"]							= "Orgrimmar",
	["f silvermoon city"]					= "Silvermoon City",
	["f thunder bluff"]						= "Thunder Bluff",
	["f undercity"]							= "Undercity",
	-- Horde Forces
	["f frostwolf clan"]					= "Frostwolf Clan",
	["f the defilers"]						= "The Defilers",
	["f warsong outriders"]					= "Warsong Outriders",
	-- Steamwheedle Cartel
	["f booty bay"]							= "Booty Bay",
	["f everlook"]							= "Everlook",
	["f gadgetzan"]							= "Gadgetzan",
	["f ratchet"]							= "Ratchet",
}



-- Realm Name Acronyms

-- Note that these are not language-specific and should include all available realms, as players may mix realms freely
-- Only include lowercase, single words that need to be specially acronymed

-- I have gone through all English, German and Spanish reams (US, Oceanic and EU) as of 2018-02-17
-- If I missed something you want specially acronymed, please submit a ticket on CurseForge to get it added:
-- https://wow.curseforge.com/projects/paragon

-- To Do:
--  - Russian realms need to be added (future Russian translator please help!)
--  - If someone wants to sort them alphabetically for OCD reasons, be my guest

T.realm_acronyms = {
	["azuremyst"] = "AM",
	["bladefist"] = "BF",
	["bloodfeather"] = "BF",
	["bronzebeard"] = "BB",
	["darrowmere"] = "DM",
	["dragonblight"] = "DB",
	["galakrond"] = "GK",
	["korialstrasz"] = "KSZ",
	["lightbringer"] = "LB",
	["moonrunner"] = "MR",
	["proudmoore"] = "PM",
	["shadowsong"] = "SS",
	["shu'halo"] = "SH",
	["silvermoon"] = "SM",
	["skywall"] = "SW",
	["windrunner"] = "WR",
	["blackrock"] = "BR",
	["blackwing"] = "BW",
	["bonechewer"] = "BC",
	["boulderfist"] = "BF",
	["coilfang"] = "CF",
	["crushridge"] = "CR",
	["daggerspine"] = "DS",
	["destromath"] = "DM",
	["dragonmaw"] = "DM",
	["dunemaul"] = "DM",
	["frostwolf"] = "FW",
	["gorgonnash"] = "GG",
	["gurubashi"] = "GB",
	["kil'jaeden"] = "KJ",
	["nazjatar"] = "NJ",
	["ner'zhul"] = "NZ",
	["rivendare"] = "RD",
	["spinebreaker"] = "SB",
	["spirestone"] = "SS",
	["stonemaul"] = "SM",
	["stormscale"] = "SC",
	["feathermoon"] = "FM",
	["azjol-nerub"] = "AN",
	["doomhammer"] = "DH",
	["icecrown"] = "IC",
	["perenolde"] = "PN",
	["zangarmarsh"] = "ZM",
	["kel'thuzad"] = "KT",
	["darkspear"] = "DS",
	["deathwing"] = "DW",
	["bloodscalp"] = "BS",
	["nathrezim"] = "NR",
	["alexstrasza"] = "AX",
	["blackhand"] = "BH",
	["dawnbringer"] = "DB",
	["fizzcrank"] = "FC",
	["ghostlands"] = "GL",
	["greymane"] = "GM",
	["hellscream"] = "HS",
	["hydraxis"] = "HX",
	["kael'thas"] = "KT",
	["mok'nathal"] = "MN",
	["nesingwary"] = "NW",
	["quel'dorei"] = "QD",
	["ravencrest"] = "RC",
	["runetotem"] = "RT",
	["sen'jin"] = "SJ",
	["staghelm"] = "SH",
	["terokkar"] = "TK",
	["thunderhorn"] = "TH",
	["vek'nilash"] = "VN",
	["whisperwind"] = "WW",
	["winterhoof"] = "WH",
	["aegwynn"] = "AW",
	["agamaggan"] = "AM",
	["archimonde"] = "AM",
	["azgalor"] = "AG",
	["azshara"] = "AZ",
	["balnazzar"] = "BN",
	["cho'gall"] = "CG",
	["chromaggus"] = "CM",
	["drak'tharon"] = "DT",
	["drak'thul"] = "DT",
	["frostmane"] = "FM",
	["hakkar"] = "HK",
	["mal'ganis"] = "MG",
	["mug'thol"] = "MT",
	["stormreaver"] = "SR",
	["underbog"] = "UB",
	["thunderlord"] = "TL",
	["wildhammer"] = "WH",
	["farstriders"] = "FS",
	["brotherhood"] = "BH",
	["lightninghoof"] = "LH",
	["maelstrom"] = "MS",
	["52"] = "52",
	["bloodhoof"] = "BH",
	["drenden"] = "DD",
	["duskwood"] = "DW",
	["eldre'thalas"] = "ET",
	["exodar"] = "EX",
	["norgannon"] = "NG",
	["stormrage"] = "SR",
	["trollbane"] = "TB",
	["turalyon"] = "TL",
	["uldaman"] = "UM",
	["undermine"] = "UM",
	["zul'jin"] = "ZJ",
	["andorhal"] = "AH",
	["anatheron"] = "AT",
	["anub'arak"] = "AA",
	["auchindoun"] = "AD",
	["dragonflight"] = "DF",
	["dalvengyr"] = "DG",
	["executus"] = "EC",
	["firetree"] = "FT",
	["gorefiend"] = "GF",
	["haomarush"] = "HM",
	["jaedenar"] = "JD",
	["mannoroth"] = "MR",
	["magtheridon"] = "MT",
	["shadowmoon"] = "SM",
	["skullcrusher"] = "SC",
	["smolderthorn"] = "ST",
	["tortheldrin"] = "TT",
	["warsong"] = "WS",
	["zuluhed"] = "ZH",
	["steamwheedle"] = "SW",
	["ravenholdt"] = "RH",
	["aman'thul"] = "AT",
	["caelestrasz"] = "CSZ",
	["dath'remar"] = "DR",
	["khaz'goroth"] = "KG",
	["nagrand"] = "NG",
	["saurfang"] = "SF",
	["barthilas"] = "BT",
	["dreadmaul"] = "DM",
	["frostmourne"] = "FM",
	["gundrak"] = "GD",
	["jubei'thos"] = "JT",
	["quel'thalas"] = "QT",
	["anachronos"] = "AC",
	["hellfire"] = "HF",
	["al'akir"] = "AA",
	["ahn'qiraj"] = "AQ",
	["darksorrow"] = "DS",
	["frostwhisper"] = "FW",
	["genjuros"] = "GJ",
	["karazhan"] = "KZ",
	["kor'gall"] = "KG",
	["mazrigos"] = "MZ",
	["outland"] = "OL",
	["moonglade"] = "MG",
	["sunstrider"] = "SS",
	["talnivarr"] = "TN",
	["darkmoon"] = "DM",
	["scarshield"] = "SS",
	["drek'thar"] = "DT",
	["vol'jin"] = "VJ",
	["arak-arahm"] = "AA",
	["naxxramas"] = "NX",
	["rashgarroth"] = "RG",
	["sinstralis"] = "SS",
	["throk'feroth"] = "TF",
	["varimathras"] = "VM",
	["clairvoyants"] = "CV",
	["netherstorm"] = "NS",
	["nethersturm"] = "NS", -- German, not a typo
	["nozdormu"] = "ND",
	["blutkessel"] = "BK",
	["dethecus"] = "DC",
	["echsenkessel"] = "EK",
	["gul'dan"] = "GD",
	["krag'jin"] = "KJ",
	["nera'thor"] = "NT",
	["un'goro"] = "UG",
	["vek'lor"] = "VL",
	["wrathbringer"] = "WB",
	["mithrilorden"] = "MO",
	["nachtwache"] = "NW",
	["forscherliga"] = "FL",
	["todeswache"] = "TW",
	["arguswacht"] = "AW",
	["todeskrallen"] = "TK",
	["c'thun"] = "CT",
	["shen'dralar"] = "SD",
	["(portugu¨ºs)"] = "", -- Workaround for Aggra EU so it's not displayed as "A("
}

-- End of localization data




-- L metatable
local L, LD = LL[GetLocale()], LL.enUS
T.L = setmetatable({}, { __index = function(self, key)
	local s = L and L[key] or LD[key] or ("#NOLOC#" .. tostring(key) .. "#")
	self[key] = s
	return s
end, __call = function(self, key)
	return self[key]
end })

-- Add localized string to T.standing
T.standing[9] = T.L["faction_standing_paragon"]


SLASH_PARAGON1 = "/paragon"
SLASH_PARAGON2 = "/par"

-- Default settings
T.defaults = {
	["chat_output_limit"] = 10,
	["tooltip_personal_enabled"] = true,
	["tooltip_hide_unfriendly"] = true,
	["tooltip_hide_neutral"] = false,
	["tooltip_hide_exalted"] = false,
	["tooltip_alts_enabled"] = true,
	["tooltip_alts_enabled_shift"] = true,
	["tooltip_alts_enabled_alt"] = false,
	["tooltip_alts_limit"] = 3,
	["tooltip_alts_limit_shift"] = 12,
	["short_realm_names"] = true,
}


-- Function to check if a set of keys exist
local function setContains(set, key)
    return set[key] ~= nil
end


-- Title Case Function
local function titleCase(str)
	local function tchelper(first, rest)
		return first:upper()..rest:lower()
	end

	return (str:gsub("(%a)([%w_']*)", tchelper))
end

-- Capitalize first word
local function capitalize(str)
    return (str:gsub("^%l", string.upper))
end

-- Table sorting
function getKeysSortedByValue(tbl, sortFunction)
	local keys = {}
	for key in pairs(tbl) do
		table.insert(keys, key)
	end
	
	table.sort(keys, function(a, b)
		return sortFunction(tbl[a], tbl[b])
	end)

	return keys
end


-- Create the frame
local frame = CreateFrame("FRAME", "ParagonFrame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("VARIABLES_LOADED")
frame:RegisterEvent("UPDATE_FACTION")
frame:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")


-- Results Frame
local resultsFrame = CreateFrame("FRAME", "ParagonResultsFrame", UIParent, "BasicFrameTemplate")
resultsFrame:SetMovable(true)
resultsFrame:SetSize(420, 580)
resultsFrame:SetPoint("CENTER", UIParent, "CENTER")
resultsFrame:EnableMouse(true)
resultsFrame:RegisterForDrag("LeftButton")
resultsFrame:SetScript("OnDragStart", resultsFrame.StartMoving)
resultsFrame:SetScript("OnDragStop", resultsFrame.StopMovingOrSizing)
resultsFrame:Hide()
tinsert(UISpecialFrames, "ParagonResultsFrame")



local resultsFrameTitle = resultsFrame:CreateFontString("OVERLAY", nil, "GameFontNormal")
resultsFrameTitle:SetPoint("TOPLEFT", 0, -4)
resultsFrameTitle:SetWidth(420)
resultsFrameTitle:SetJustifyH("CENTER")
resultsFrameTitle:SetText("Paragon")

--scrollframe
resultsScrollFrame = CreateFrame("ScrollFrame", nil, resultsFrame)
resultsScrollFrame:SetPoint("TOPLEFT", 6, -64)
resultsScrollFrame:SetPoint("BOTTOMRIGHT", -28, 6)
resultsScrollFrame:SetBackdrop({
	bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 8, edgeSize = 8, 
	insets = { left = 2, right = 2, top = 2, bottom = 2 }}
)
resultsScrollFrame:SetBackdropColor(0, 0, 0, 0.8)
resultsScrollFrame:SetBackdropBorderColor(0, 0, 0, 0.8)
resultsFrame.scrollFrame = resultsScrollFrame

--scrollbar
resultsScrollbar = CreateFrame("Slider", nil, resultsScrollFrame, "UIPanelScrollBarTemplate")
resultsScrollbar:SetPoint("TOPLEFT", resultsFrame, "TOPRIGHT", -24, -80)
resultsScrollbar:SetPoint("BOTTOMRIGHT", resultsFrame, "BOTTOMRIGHT", -8, 24)
resultsScrollbar:SetMinMaxValues(1, 1000)
resultsScrollbar:SetValueStep(1)
resultsScrollbar.scrollStep = 24
resultsScrollbar:SetValue(0)
resultsScrollbar:SetWidth(16)
resultsScrollbar:SetScript("OnValueChanged",
	function (self, value)
		self:GetParent():SetVerticalScroll(value)
	end
)
local scrollbg = resultsScrollbar:CreateTexture(nil, "BACKGROUND")
scrollbg:SetAllPoints(resultsScrollbar)
scrollbg:SetTexture(0, 0, 0, 0.4)
frame.scrollbar = resultsScrollbar

--content frame
local resultsContent = CreateFrame("Frame", nil, resultsScrollFrame)
resultsScrollFrame.content = resultsContent
resultsScrollFrame:SetScrollChild(resultsContent)


-- Labels
local resultsFrameFactionLabel = resultsFrame:CreateFontString("OVERLAY", nil, "GameFontNormalLarge")
resultsFrameFactionLabel:SetPoint("TOPLEFT", 10, -32)
resultsFrameFactionLabel:SetHeight(24)
resultsFrameFactionLabel:SetJustifyV("MIDDLE")






-- Realm formatting
local function format_realm(realmName)
	if realmName == T.realm then
		return "" -- Same realm as player, hide it
	else
		--[[if ShiGuangDB["ParagonDBconfig"]["short_realm_names"] then
			local parts = {}
			for part in string.gmatch(realmName, "[^ ]+") do
				tinsert(parts, part)
			end

			realmName = ""
			for i, part in pairs(parts) do
				if setContains(T.realm_acronyms, string.lower(part)) then
					realmName = realmName .. T.realm_acronyms[string.lower(part)]
				else
					realmName = realmName .. string.sub(part, 1, 1)
				end
			end
		end]]

		return "- ¡ï" --.. realmName
	end
end


-- Function to update current player's repuation standings
local function updateFactions()
	if not ShiGuangDB then return end

	-- Replace current character's saved data with current data
	ShiGuangDB["ParagonDBcharacter"][T.charStr] = { ["name"] = T.player, ["realm"] = T.realm, ["class"] = T.class, ["level"] = T.level, ["factionGroup"] = T.factionGroup }

	for faction, data in pairs(T.faction) do
		local id, icon, paragon, factionGroup = data["id"], data["icon"], data["paragon"], data["factionGroup"]
		local name, _, standingId, barMin, barMax, barValue, _, _, _, _, _, _, _, _, _, _ = GetFactionInfoByID(id)
		local currentValue, threshold, _, hasRewardPending = C_Reputation.GetFactionParagonInfo(id)


		if factionGroup == false or factionGroup == T.factionGroup then -- Only include same side and neutral factions
			if currentValue then
				local displayValue = currentValue % threshold
				if hasRewardPending then displayValue = displayValue + threshold end

				ShiGuangDB["ParagonDBcharacter"][T.charStr][faction] = {
					["standingId"] = 9, -- Paragon
					["current"] = displayValue,
					["max"] = threshold,
					["hasRewardPending"] = hasRewardPending,
				}
			elseif barValue then
				ShiGuangDB["ParagonDBcharacter"][T.charStr][faction] = {
					["standingId"] = standingId,
					["current"] = barValue - barMin,
					["max"] = barMax - barMin,
					["hasRewardPending"] = false,
				}
			end
		end
	end
end


-- Function to delete saved data for a specified character
local function deleteCharacter(characterName, verbose)
	if not characterName then
		if verbose then
			DEFAULT_CHAT_FRAME:AddMessage(T.L["/paragon delete no argument"])
		end
		return
	else
		characterName = string.lower(characterName)
	end

	if setContains(ShiGuangDB["ParagonDBcharacter"], characterName) then
		ShiGuangDB["ParagonDBcharacter"][characterName] = nil
		if verbose then
			DEFAULT_CHAT_FRAME:AddMessage(string.format(T.L["delete character successful"], characterName))
		end
		return
	else
		characterName = characterName .. string.lower("-"..T.realm)
	end

	if setContains(ShiGuangDB["ParagonDBcharacter"], characterName) and characterName ~= string.lower("-"..T.realm) then
		ShiGuangDB["ParagonDBcharacter"][characterName] = nil
		if verbose then
			DEFAULT_CHAT_FRAME:AddMessage(string.format(T.L["delete character successful"], characterName))
		end
		return
	elseif verbose and characterName == string.lower("-"..T.realm) then
		DEFAULT_CHAT_FRAME:AddMessage(T.L["/paragon delete no argument"])
	elseif verbose then
		DEFAULT_CHAT_FRAME:AddMessage(string.format(T.L["delete character not found"], characterName, T.realm))
	end
end


-- Functions to format standings
local function standing(standingId, faction)
	if setContains(T.faction, faction) then
		if T.faction[faction]["friend"] ~= 0 then
			if setContains(T.friendStanding, faction) then
				return T.L[T.friendStanding[faction][standingId]]
			else
				return T.L[T.friendStanding["default"][standingId]]
			end
		else
			return T.standing[standingId]
		end
	else
		return T.standing[standingId]
	end
end

local function standingColor(standingId, faction)
	if setContains(T.faction, faction) then
		if T.faction[faction]["friend"] ~= 0 then
			if setContains(T.friendStandingColor, faction) then
				return T.friendStandingColor[faction][standingId]
			else
				return T.friendStandingColor["default"][standingId]
			end
		else
			return T.standingColor[standingId]
		end
	else
		return T.standingColor[standingId]
	end
end


-- Function to output saved data for a specific faction
local function outputFaction(factionName, limit, outputFormat, currentLine)
	local faction = string.lower(factionName) -- Convert to lower case

	updateFactions() -- Make sure player data is up to date

	-- Check if the faction exists
	if not setContains(T.faction, faction) then
		return -- Break
	elseif outputFormat == "test" then
		return true
	end

	-- Local variables
	local factionTable, sortTable = {}, {}
	local ui, scrollcontainer, scroll = nil, nil, nil

	-- Sorting table
	for char, tbl in pairs(ShiGuangDB["ParagonDBcharacter"]) do
		if setContains(tbl, faction) then
			factionTable[char] = tbl[faction]
			sortTable[char] = tostring(tbl[faction]["standingId"] .. "." .. string.format("%09.7d", tbl[faction]["current"]))
		end
	end

	-- Sort the table
	local sortedKeys
	if outputFormat == "tooltip" and ShiGuangDB["ParagonDBconfig"]["tooltip_alts_enabled_alt"] and IsAltKeyDown() then -- Reverse order when holding <Alt>
		sortedKeys = getKeysSortedByValue(sortTable, function(a, b) return a < b end)
	else
		sortedKeys = getKeysSortedByValue(sortTable, function(a, b) return a > b end)
	end

	local i, out = 0, nil
	for _, char in ipairs(sortedKeys) do
		local d = ShiGuangDB["ParagonDBcharacter"][char]
		local standingId = factionTable[char]["standingId"]

		if (not (ShiGuangDB["ParagonDBconfig"]["tooltip_hide_exalted"] and standingId == 8) and not (ShiGuangDB["ParagonDBconfig"]["tooltip_hide_neutral"] and standingId == 4) and not (ShiGuangDB["ParagonDBconfig"]["tooltip_hide_unfriendly"] and standingId <= 3)) or outputFormat == "ui" then
			i = i + 1

			if i == 1 then
				if outputFormat == "ui" then
					--content frame
					resultsContent:Hide()

					resultsFrameFactionLabel:SetText("|T" .. T.faction[faction]["icon"] .. ":24:24|t  " .. T.L["f "..faction])

					resultsContent = CreateFrame("Frame", nil, resultsScrollFrame)
					resultsScrollFrame.content = resultsContent
					resultsScrollFrame:SetScrollChild(resultsContent)

					resultsFrame:Show()
				else
					out = "|cFF00FFFFParagon|r\n|T" .. T.faction[faction]["icon"] .. ":0|t " .. T.L["f "..faction] .. " - " .. T.L["highest reputation"]
				end
			end

			if i <= limit or outputFormat == "ui" then
				local displayAmount = "  " .. FormatLargeNumber(factionTable[char]["current"]) .. " / " .. FormatLargeNumber(factionTable[char]["max"])
				if standingId == 8 or (T.faction[faction]["friend"] ~= 0 and standingId >= T.faction[faction]["friend"]) then -- Exalted/Best Friend
					displayAmount = "" -- Exalted reputations do not have amounts
				end

				local line = "|c" .. RAID_CLASS_COLORS[d["class"]].colorStr .. d["name"] .. format_realm(d["realm"]) .. "|r  " .. standingColor(standingId, faction) .. standing(standingId, faction) .. displayAmount .. "|r"

				if outputFormat == "ui" then
					local offset = (i - 1) * -24

					local rowBg = CreateFrame("Frame", nil, resultsContent)
					rowBg:SetPoint("TOPLEFT", 0, offset or 0)
					rowBg:SetPoint("TOPRIGHT", 0, offset or 0)
					rowBg:SetHeight(24)
					rowBg:SetBackdrop({
						bgFile = "Interface/Tooltips/UI-Tooltip-Background",
						tile = true, tileSize = 8, edgeSize = 0, 
						insets = { left = 0, right = 0, top = 0, bottom = 0 }}
					)
					if i % 2 == 1 then
						rowBg:SetBackdropColor(0, 0, 0, 0.4)
					else
						rowBg:SetBackdropColor(0, 0, 0, 0)
					end

					-- Character Name
					local label = rowBg:CreateFontString("OVERLAY", nil, "GameFontNormalSmall")
					label:SetPoint("TOPLEFT", 10, 0)
					label:SetText("|c" .. RAID_CLASS_COLORS[d["class"]].colorStr .. d["name"] .. format_realm(d["realm"]) .. "|r")
					label:SetHeight(24)
					label:SetJustifyV("MIDDLE")

					-- Standing
					local label = rowBg:CreateFontString("OVERLAY", nil, "GameFontNormalSmall")
					label:SetPoint("TOPLEFT", 160, 0)
					label:SetText(standingColor(standingId, faction) .. standing(standingId, faction) .. "|r")
					label:SetHeight(24)
					label:SetJustifyV("MIDDLE")

					-- Amount
					if standingId ~= 8 then
						local label = rowBg:CreateFontString("OVERLAY", nil, "GameFontNormalSmall")
						label:SetPoint("TOPLEFT", 240, 0)
						label:SetText(standingColor(standingId, faction) .. displayAmount .. "|r")
						label:SetHeight(24)
						label:SetWidth(100)
						--label:SetJustifyH("CENTER")
						label:SetJustifyV("MIDDLE")
					end
				elseif outputFormat == "tooltip" and i == currentLine then
					return "|cff808080" .. i .. ".|r " .. line
				else
					out = out .. "\n|cff808080" .. i .. ".|r " .. line
				end
			end
		end
	end

	if i == 0 then
		if outputFormat == "ui" then
			--content frame
			resultsContent:Hide()

			resultsFrameFactionLabel:SetText("|T" .. T.faction[faction]["icon"] .. ":24:24|t  " .. T.L["f "..faction])

			resultsContent = CreateFrame("Frame", nil, resultsScrollFrame)
			resultsScrollFrame.content = resultsContent
			resultsScrollFrame:SetScrollChild(resultsContent)

			resultsFrame:Show()

			local label = resultsContent:CreateFontString("OVERLAY", nil, "GameFontNormalLarge")
			label:SetPoint("TOPLEFT", 10, -10)
			label:SetText(string.format(T.L["reputation not discovered"], T.L["f "..faction]))
			label:SetJustifyV("MIDDLE")
			label:SetJustifyH("CENTER")
			label:SetWidth(360)
			label:SetHeight(460)
		else
			out = "|cFF00FFFFParagon|r: " .. string.format(T.L["no results"], "\"" .. T.L["f "..faction] .. "\"")
		end
	end

	

	if outputFormat == "chat" then
		-- Write data to the chat frame
		DEFAULT_CHAT_FRAME:AddMessage(out)
	elseif outputFormat == "ui" then
		local height = (i*24)-510

		resultsScrollbar:SetValue(0)

		if i <= 21 then
			resultsScrollbar:SetMinMaxValues(1, 1)
			resultsScrollbar:Hide()
			resultsContent:SetSize(420, 510)
		else
			resultsScrollbar:SetMinMaxValues(1, height)
			resultsScrollbar:Show()
			resultsContent:SetSize(420, height)
		end
	end
end


-- Function to add information to item tooltips
local function GameTooltip_OnTooltipSetItem(tooltip)
	local tooltip = tooltip
	local match = string.match
	local _, link = tooltip:GetItem()
	if not link then return; end -- Break if the link is invalid
	
	-- String matching to get item ID
	local itemString = match(link, "item[%-?%d:]+")
	local _, itemId = strsplit(":", itemString or "")

	-- TradeSkillFrame workaround
	if itemId == "0" and TradeSkillFrame ~= nil and TradeSkillFrame:IsVisible() then
		if (GetMouseFocus():GetName()) == "TradeSkillSkillIcon" then
			itemId = GetTradeSkillItemLink(TradeSkillFrame.selectedSkill):match("item:(%d+):") or nil
		else
			for i = 1, 8 do
				if (GetMouseFocus():GetName()) == "TradeSkillReagent"..i then
					itemId = GetTradeSkillReagentItemLink(TradeSkillFrame.selectedSkill, i):match("item:(%d+):") or nil
					break
				end
			end
		end
	end

	itemId = tonumber(itemId) -- Make sure itemId is an integer

	if itemId and (setContains(T.reputationItemBoA, itemId) or setContains(T.reputationItemBoP, itemId)) then
		updateFactions() -- Make sure player data is up to date

		local bound, faction = nil, nil
		if setContains(T.reputationItemBoA, itemId) then
			bound, faction = "BoA", T.reputationItemBoA[itemId]
		else
			bound, faction = "BoP", T.reputationItemBoP[itemId]
		end

		local d = ShiGuangDB["ParagonDBcharacter"][T.charStr]
		local limit = tonumber(ShiGuangDB["ParagonDBconfig"]["tooltip_alts_limit"])
		local limit_shift = tonumber(ShiGuangDB["ParagonDBconfig"]["tooltip_alts_limit_shift"])

		local factions = { strsplit("|", faction) }
		local totalFactions = 0

		for _, faction in pairs(factions) do
			if setContains(d, faction) and ShiGuangDB["ParagonDBconfig"]["tooltip_personal_enabled"] then
				totalFactions = totalFactions + 1

				tooltip:AddLine(" ")
				tooltip:AddLine("|cffffffff" .. T.L["f "..faction] .. "|r")

				local displayAmount = "  " .. FormatLargeNumber(d[faction]["current"]) .. " / " .. FormatLargeNumber(d[faction]["max"])
				if d[faction]["standingId"] == 8 or (T.faction[faction]["friend"] ~= 0 and d[faction]["standingId"] >= T.faction[faction]["friend"]) then -- Exalted/Best Friend
					displayAmount = ""
				end

				tooltip:AddLine(standingColor(d[faction]["standingId"], faction) .. standing(d[faction]["standingId"], faction) .. displayAmount .. "|r")
			end
		end

		if ShiGuangDB["ParagonDBconfig"]["tooltip_alts_enabled"] and limit >= 1 and totalFactions == 1 then
			if bound == "BoA" and outputFaction(faction, 1, "tooltip", 1) then
				--tooltip:AddLine(" ")
				--if ShiGuangDB["ParagonDBconfig"]["tooltip_alts_enabled_alt"] and IsAltKeyDown() then
					--tooltip:AddLine(T.L["lowest reputation"])
				--else
					--tooltip:AddLine(T.L["highest reputation"])
				--end
				tooltip:AddLine(outputFaction(faction, 1, "tooltip", 1))

				if limit >= 2 then
					for i = 2, limit do
						if outputFaction(faction, i, "tooltip", i) then
							tooltip:AddLine(outputFaction(faction, i, "tooltip", i))
						end
					end
				end

				if ShiGuangDB["ParagonDBconfig"]["tooltip_alts_enabled_shift"] and limit_shift > limit then  -- and IsShiftKeyDown()
					for i = (limit + 1), limit_shift do
						if outputFaction(faction, i, "tooltip", i) then
							tooltip:AddLine(outputFaction(faction, i, "tooltip", i))
						end
					end
				elseif ShiGuangDB["ParagonDBconfig"]["tooltip_alts_enabled_shift"] and limit_shift > limit and outputFaction(faction, (limit + 1), "tooltip", (limit + 1)) then
					tooltip:AddLine("|cff00ff00"..T.L["hold shift for more"].."|r")
				end
				tooltip:AddLine(" ")
			end
		elseif ShiGuangDB["ParagonDBconfig"]["tooltip_alts_enabled_shift"] and limit_shift >= 1 and totalFactions == 1 then
			if IsShiftKeyDown() then
				tooltip:AddLine(" ")
				if ShiGuangDB["ParagonDBconfig"]["tooltip_alts_enabled_alt"] and IsAltKeyDown() then
					tooltip:AddLine(T.L["lowest reputation"])
				else
					tooltip:AddLine(T.L["highest reputation"])
				end
				tooltip:AddLine(outputFaction(faction, 1, "tooltip", 1))

				if limit_shift >= 2 then
					for i = 2, limit_shift do
						if outputFaction(faction, i, "tooltip", i) then
							tooltip:AddLine(outputFaction(faction, i, "tooltip", i))
						end
					end
				end
				tooltip:AddLine(" ")
			--else
				--tooltip:AddLine(" ")
				--tooltip:AddLine("|cff00ff00"..T.L["hold shift for highest reputation"].."|r")
			end
		end
	end
end


-- Slash Commands
function SlashCmdList.PARAGON(msg, editbox)
	local _, _, cmd, args = string.find(msg, "([%w%p]+)%s*(.*)$")
	if(cmd) then
		cmd = string.lower(cmd)
	end
	if(args) then
		args = string.lower(args)
	end

	--if cmd == "config" or cmd == "cfg" or cmd == "settings" or cmd == "options" then
		--InterfaceOptionsFrame_OpenToCategory("Paragon")
	--else
	if cmd == "delete" then
		deleteCharacter(args, true)
	else
		-- this is ugly and needs a better implementation
		if msg == "argus" or msg == "argussian" or msg == "reach" then msg = "argussian reach" end
		if msg == "armies" or msg == "legionfall"then msg = "armies of legionfall" end
		if msg == "army" or msg == "light" or msg == "army of light" then msg = "army of the light" end
		if msg == "court" or msg == "farondis" then msg = "court of farondis" end
		if msg == "highmountain" then msg = "highmountain tribe" end
		if msg == "nightfallen" or msg == "nightborne" then msg = "the nightfallen" end
		if msg == "wardens" or msg == "warden" then msg = "the wardens" end
		if msg == "champions" or msg == "azeroth" then msg = "champions of azeroth" end
		if msg == "proudmoore" then msg = "proudmoore admiralty" end
		if msg == "tortollan" then msg = "tortollan seekers" end
		if msg == "zandalari" then msg = "zandalari empire" end
		if msg == "talanji" or msg == "talanji's" then msg = "talanji's expedition" end
		if msg == "honorbound" then msg = "the honorbound" end

		if outputFaction(msg, 1, "test") then
			outputFaction(msg, tonumber(ShiGuangDB["ParagonDBconfig"]["chat_output_limit"]), "ui")
		else
			DEFAULT_CHAT_FRAME:AddMessage(T.L["/paragon help"])
		end
	end
end


-- Event Handler
local function eventHandler(self, event)
	if event == "VARIABLES_LOADED" then
		-- Make sure defaults are set
		if not ShiGuangDB["ParagonDBconfig"] then ShiGuangDB["ParagonDBconfig"] = T.defaults end
		if not ShiGuangDB["ParagonDBcharacter"] then ShiGuangDB["ParagonDBcharacter"] = {} end

		for key, value in pairs(T.defaults) do
			if not setContains(ShiGuangDB["ParagonDBconfig"], key) then
				ShiGuangDB["ParagonDBconfig"][key] = value
			end
		end
	end

	updateFactions()
end

frame:SetScript("OnEvent", eventHandler)

GameTooltip:HookScript("OnTooltipSetItem", GameTooltip_OnTooltipSetItem)