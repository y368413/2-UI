--## Version: Diamond 1  ## Author: Leo Bolin
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
		[1] = T.standingColor[4], -- Stranger
        [2] = T.standingColor[5], -- Acquaintance/Pal
        [3] = T.standingColor[6], -- Buddy
        [4] = T.standingColor[6], -- Friend
        [5] = T.standingColor[7], -- Good Friend
        [6] = T.standingColor[8], -- Best Friend
        [9] = T.standingColor[9], -- Paragon
	},
	["chromie"] = {
		[1] = T.standingColor[4], -- Whelpling
		[2] = T.standingColor[4], -- Temporal Trainee
		[3] = T.standingColor[5], -- Timehopper
		[4] = T.standingColor[5], -- Chrono-Friend
		[5] = T.standingColor[6], -- Bronze Ally
		[6] = T.standingColor[7], -- Epoch-Mender
		[7] = T.standingColor[8], -- Timelord
	},
	["vivianne"] = {
		[1] = T.standingColor[5], -- Bodyguard
		[2] = T.standingColor[6], -- Trusted Bodyguard
		[3] = T.standingColor[8], -- Personal Wingman
	},
	["court of night"] = { -- also Marasmius, Stitchmasters
		[1] = T.standingColor[4], -- Neutral
		[2] = T.standingColor[5], -- Friendly
		[3] = T.standingColor[6], -- Honored
		[4] = T.standingColor[7], -- Revered
		[5] = T.standingColor[8], -- Exalted
	},
	["nomi"] = {
		[1] = T.standingColor[4], -- Apprentice
		[2] = T.standingColor[4], -- Apprentice
		[3] = T.standingColor[5], -- Journeyman
		[4] = T.standingColor[6], -- Journeyman
		[5] = T.standingColor[7], -- Journeyman
		[6] = T.standingColor[8], -- Expert
	},
	["sabellian"] = { -- also Wrathion
		[1] = T.standingColor[4], -- Acquaintance
		[2] = T.standingColor[5], -- Cohort
		[3] = T.standingColor[6], -- Ally
		[4] = T.standingColor[6], -- Fang
		[5] = T.standingColor[7], -- Friend
		[6] = T.standingColor[8], -- True Friend
		[9] = T.standingColor[9], -- Paragon
	},
	["artisan's consortium - dragon isles branch"] = {
		[1] = T.standingColor[4], -- Neutral
        [2] = T.standingColor[5], -- Preferred
        [3] = T.standingColor[6], -- Respected
        [4] = T.standingColor[7], -- Valued
        [5] = T.standingColor[8], -- Esteemed
	},
	["cobalt assembly"] = {
		[1] = T.standingColor[4], -- Empty
        [2] = T.standingColor[5], -- Low
        [3] = T.standingColor[6], -- Medium
        [4] = T.standingColor[7], -- High
        [5] = T.standingColor[8], -- Maximum
	},
	["glimmerogg racer"] = {
		[1] = T.standingColor[4], -- Aspirational
        [2] = T.standingColor[5], -- Amateur
        [3] = T.standingColor[6], -- Competent
        [4] = T.standingColor[7], -- Skilled
        [5] = T.standingColor[8], -- Professional
	},
	["soridormi"] = {
		[1] = T.standingColor[4], -- Anomaly
        [2] = T.standingColor[5], -- Future Friend
        [3] = T.standingColor[6], -- Rift-Mender
        [4] = T.standingColor[7], -- Timewalker
        [5] = T.standingColor[8], -- Legend
	},
	["azerothian archives"] = {
		[1] = T.standingColor[4], -- Junior
        [2] = T.standingColor[5], -- Capable
        [3] = T.standingColor[6], -- Learned
        [4] = T.standingColor[7], -- Resident
        [5] = T.standingColor[8], -- Tenured
	},
	["the general"] = {
		[1] = T.standingColor[4], -- Stranger
        [2] = T.standingColor[5], -- Acquaintance
        [3] = T.standingColor[5], -- Crony
        [4] = T.standingColor[6], -- Accomplice
        [5] = T.standingColor[6], -- Collaborator
        [6] = T.standingColor[6], -- Accessory
        [7] = T.standingColor[7], -- Abettor
        [8] = T.standingColor[7], -- Conspirator
        [9] = T.standingColor[8], -- Mastermind
	},
}
-- Reuse colors
T.friendStandingColor["aeda brightdawn"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["defender illona"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["delvar ironfist"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["leorajh"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["talonpriest ishaal"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["tormmok"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["marasmius"] = T.friendStandingColor["court of night"]
T.friendStandingColor["stitchmasters"] = T.friendStandingColor["court of night"]
T.friendStandingColor["wrathion"] = T.friendStandingColor["sabellian"]
T.friendStandingColor["the vizier"] = T.friendStandingColor["the general"]
T.friendStandingColor["the weaver"] = T.friendStandingColor["the general"]

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
		[9] = "faction_standing_paragon",
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
	["ve'nari"] = {
		[1] = "faction_standing_dubious",
		[2] = "faction_standing_apprehensive",
		[3] = "faction_standing_tentative",
		[4] = "faction_standing_ambivalent",
		[5] = "faction_standing_cordial",
		[6] = "faction_standing_appreciative",
		[9] = "faction_standing_paragon",
	},
	["vivianne"] = { -- also all other Bodyguards
		[1] = "faction_standing_bodyguard",
		[2] = "faction_standing_trusted_bodyguard",
		[3] = "faction_standing_personal_wingman",
	},
	["nomi"] = {
		[1] = "faction_standing_apprentice",
		[2] = "faction_standing_apprentice",
		[3] = "faction_standing_journeyman",
		[4] = "faction_standing_journeyman",
		[5] = "faction_standing_journeyman",
		[6] = "faction_standing_expert",
	},
	["court of night"] = { -- also Marasmius, Stitchmasters
		[1] = "faction_standing_neutral",
		[2] = "faction_standing_friendly",
		[3] = "faction_standing_honored",
		[4] = "faction_standing_revered",
		[5] = "faction_standing_exalted",
	},
	["the archivists' codex"] = {
		[1] = "faction_standing_tier_1",
		[2] = "faction_standing_tier_2",
		[3] = "faction_standing_tier_3",
		[4] = "faction_standing_tier_4",
		[5] = "faction_standing_tier_5",
		[6] = "faction_standing_tier_6",
		[9] = "faction_standing_paragon",
	},
	["artisan's consortium - dragon isles branch"] = {
		[1] = "faction_standing_neutral",
		[2] = "faction_standing_preferred",
		[3] = "faction_standing_respected",
		[4] = "faction_standing_valued",
		[5] = "faction_standing_esteemed",
	},
	["cobalt assembly"] = {
		[1] = "faction_standing_empty",
		[2] = "faction_standing_low",
		[3] = "faction_standing_medium",
		[4] = "faction_standing_high",
		[5] = "faction_standing_maximum",
	},
	["sabellian"] = { -- also Wrathion
		[1] = "faction_standing_acquaintance",
		[2] = "faction_standing_cohort",
		[3] = "faction_standing_ally",
		[4] = "faction_standing_fang",
		[5] = "faction_standing_friend",
		[6] = "faction_standing_true_friend",
		[7] = "faction_standing_paragon",
	},
	["glimmerogg racer"] = {
		[1] = "faction_standing_aspirational",
		[2] = "faction_standing_amateur",
		[3] = "faction_standing_competent",
		[4] = "faction_standing_skilled",
		[5] = "faction_standing_professional",
	},
	["soridormi"] = {
		[1] = "faction_standing_anomaly",
		[2] = "faction_standing_future_friend",
		[3] = "faction_standing_rift-mender",
		[4] = "faction_standing_timewalker",
		[5] = "faction_standing_legend",
	},
	["azerothian archives"] = {
		[1] = "faction_standing_junior",
		[2] = "faction_standing_capable",
		[3] = "faction_standing_learned",
		[4] = "faction_standing_resident",
		[5] = "faction_standing_tenured",
	},
	["the general"] = {
		[1] = "faction_standing_stranger",
		[2] = "faction_standing_acquaintance",
		[3] = "faction_standing_crony",
		[4] = "faction_standing_accomplice",
		[5] = "faction_standing_collaborator",
		[6] = "faction_standing_accessory",
		[7] = "faction_standing_abettor",
		[8] = "faction_standing_conspirator",
		[9] = "faction_standing_mastermind",
	},
}

T.friendStanding["conjurer margoss"] = T.friendStanding["nat pagle"]
T.friendStanding["akule riverhorn"] = T.friendStanding["nat pagle"]
T.friendStanding["ilyssia of the waters"] = T.friendStanding["nat pagle"]
T.friendStanding["impus"] = T.friendStanding["nat pagle"]
T.friendStanding["keeper raynae"] = T.friendStanding["nat pagle"]
T.friendStanding["sha'leth"] = T.friendStanding["nat pagle"]
T.friendStanding["aeda brightdawn"] = T.friendStanding["vivianne"]
T.friendStanding["defender illona"] = T.friendStanding["vivianne"]
T.friendStanding["delvar ironfist"] = T.friendStanding["vivianne"]
T.friendStanding["leorajh"] = T.friendStanding["vivianne"]
T.friendStanding["talonpriest ishaal"] = T.friendStanding["vivianne"]
T.friendStanding["tormmok"] = T.friendStanding["vivianne"]
T.friendStanding["marasmius"] = T.friendStanding["court of night"]
T.friendStanding["stitchmasters"] = T.friendStanding["court of night"]
T.friendStanding["wrathion"] = T.friendStanding["sabellian"]
T.friendStanding["the vizier"] = T.friendStanding["the general"]
T.friendStanding["the weaver"] = T.friendStanding["the general"]


-- Reputation item IDs - BoA and BoE
T.reputationItemBoA = {
	-- The War Within
	[222599] = "council of dornogal", -- Contract: Council of Dornogal (Quality 3)
	[222598] = "council of dornogal", -- Contract: Council of Dornogal (Quality 2)
	[222597] = "council of dornogal", -- Contract: Council of Dornogal (Quality 1)
	[222600] = "the assembly of the deeps", -- Contract: Assembly of the Deeps (Quality 1)
	[222601] = "the assembly of the deeps", -- Contract: Assembly of the Deeps (Quality 2)
	[222602] = "the assembly of the deeps", -- Contract: Assembly of the Deeps (Quality 3)
	[222605] = "hallowfall arathi", -- Contract: Hallowfall Arathi (Quality 3)
	[222604] = "hallowfall arathi", -- Contract: Hallowfall Arathi (Quality 2)
	[222603] = "hallowfall arathi", -- Contract: Hallowfall Arathi (Quality 1)
	[222608] = "the severed threads", -- Contract: The Severed Threads (Quality 3)
	[222607] = "the severed threads", -- Contract: The Severed Threads (Quality 2)
	[222606] = "the severed threads", -- Contract: The Severed Threads (Quality 1)

	-- Dragonflight
	[213536] = "azerothian archives", -- Priceless Artifact (1000)
	[210423] = "dream wardens", -- Dream Wardens Insignia (2500)
	[210423] = "dream wardens", -- Dream Wardens Insignia (2500)
	[211416] = "dream wardens", -- Dream Wardens Insignia (1000)
	[210421] = "dream wardens", -- Dream Wardens Insignia (500)
	[210420] = "dream wardens", -- Dream Wardens Insignia (250)
	[210419] = "dream wardens", -- Dream Wardens Insignia (50)
	[210246] = "dream wardens", -- Contract: Dream Wardens (Quality 3)
	[210245] = "dream wardens", -- Contract: Dream Wardens (Quality 2)
	[210244] = "dream wardens", -- Contract: Dream Wardens (Quality 1)
	[208952] = "soridormi", -- Soridormi's Letter of Commendation (1000)
	[210422] = "loamm niffen", -- Loamm Niffen Insignia (2500)
	[205985] = "loamm niffen", -- Loamm Niffen Insignia (500)
	[205342] = "loamm niffen", -- Loamm Niffen Insignia (250)
	[205365] = "loamm niffen", -- Loamm Niffen Insignia (50)
	[204993] = "loamm niffen", -- Contract: Loamm Niffen (Quality 1)
	[204991] = "loamm niffen", -- Contract: Loamm Niffen (Quality 2)
	[204992] = "loamm niffen", -- Contract: Loamm Niffen (Quality 3)
	[198503] = "artisan's consortium - dragon isles branch", -- Contract: Artisan's Consortium (Quality 1)
	[198504] = "artisan's consortium - dragon isles branch", -- Contract: Artisan's Consortium (Quality 2)
	[198505] = "artisan's consortium - dragon isles branch", -- Contract: Artisan's Consortium (Quality 3)
	[200443] = "dragonscale expedition", -- Dragon Isles Artifact (15)
	[200285] = "dragonscale expedition", -- Dragonscale Expedition Insignia (50)
	[200452] = "dragonscale expedition", -- Dragonscale Expedition Insignia (250)
	[201921] = "dragonscale expedition", -- Dragonscale Expedition Insignia (500)
	[202091] = "dragonscale expedition", -- Dragonscale Expedition Insignia (2500)
	[198506] = "dragonscale expedition", -- Contract: Dragonscale Expedition (Quality 1)
	[198507] = "dragonscale expedition", -- Contract: Dragonscale Expedition (Quality 2)
	[198508] = "dragonscale expedition", -- Contract: Dragonscale Expedition (Quality 3)
	[200449] = "iskaara tuskarr", -- Sacred Tuskarr Totem (15)
	[200287] = "iskaara tuskarr", -- Iskaara Tuskarr Insignia (50)
	[200453] = "iskaara tuskarr", -- Iskaara Tuskarr Insignia (250)
	[201922] = "iskaara tuskarr", -- Iskaara Tuskarr Insignia (500)
	[202092] = "iskaara tuskarr", -- Iskaara Tuskarr Insignia (2500)
	[198494] = "iskaara tuskarr", -- Contract: Iskaara Tuskarr (Quality 1)
	[198495] = "iskaara tuskarr", -- Contract: Iskaara Tuskarr (Quality 2)
	[198496] = "iskaara tuskarr", -- Contract: Iskaara Tuskarr (Quality 3)
	[200447] = "maruuk centaur", -- Centaur Hunting Trophy (25)
	[200288] = "maruuk centaur", -- Maruuk Centaur Insignia (50)
	[200454] = "maruuk centaur", -- Maruuk Centaur Insignia (250)
	[201923] = "maruuk centaur", -- Maruuk Centaur Insignia (500)
	[202094] = "maruuk centaur", -- Maruuk Centaur Insignia (2500)
	[198500] = "maruuk centaur", -- Contract: Maruuk Centaur (Quality 1)
	[198501] = "maruuk centaur", -- Contract: Maruuk Centaur (Quality 2)
	[198502] = "maruuk centaur", -- Contract: Maruuk Centaur (Quality 3)
	[200450] = "valdrakken accord", -- Titan Relic (15)
	[200289] = "valdrakken accord", -- Valdrakken Accord Insignia (50)
	[200455] = "valdrakken accord", -- Valdrakken Accord Insignia (250)
	[201924] = "valdrakken accord", -- Valdrakken Accord Insignia (500)
	[202093] = "valdrakken accord", -- Valdrakken Accord Insignia (2500)
	[198497] = "valdrakken accord", -- Contract: Valdrakken Accord (Quality 1)
	[198498] = "valdrakken accord", -- Contract: Valdrakken Accord (Quality 2)
	[198499] = "valdrakken accord", -- Contract: Valdrakken Accord (Quality 3)
	[200224] = "sabellian", -- Mark of Sargha (50)
	[201991] = "wrathion", -- Sargha's Signet (50)

	-- Shadowlands
	[173062] = "court of harvesters", -- Contract: Court of Harvesters
	[186522] = "death's advance", -- Contract: Death's Advance
	[173051] = "the ascended", -- Contract: The Ascended
	[187796] = "the enlightened", -- Contract: The Enlightened
	[191022] = "the enlightened", -- Eternal Curio
	[175924] = "the undying army", -- Contract: The Undying Army
	[173053] = "the wild hunt", -- Contract: The Wild Hunt
	[191299] = "the enlightened", -- Tribute to the Enlightened

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
	[153113] = "argussian reach|armies of legionfall|army of the light|court of farondis|dreamweavers|highmountain tribe|the nightfallen|the wardens|valarjar", -- Demon's Soulstone (1000)
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
	[20404]  = "cenarion circle", -- Encrypted Twilight Text (500 per 10)
	[17010]  = "thorium brotherhood", -- Fiery Core (500)
	[17011]  = "thorium brotherhood", -- Lava Core (500)
	[18945]  = "thorium brotherhood", -- Dark Iron Residue (625 per 100 or 15 per 4)
	[206374] = "argent dawn", -- Invader's Scourgestone
	[206375] = "argent dawn", -- Corruptor's Scourgestone
	[12844]  = "argent dawn", -- Argent Dawn Valor Token (100)

	-- Guild
	[69209] = "guild", -- Illustrious Guild Tabard (50% increase)
	[69210] = "guild", -- Renowned Guild Tabard (100% increase)
}

-- Reputation item IDs - Soulbound
T.reputationItemBoP = {
	-- Dragonflight
	[210920] = "dream wardens", -- Gift of Amirdrassil (2500)
	[210916] = "dream wardens", -- Ember of Fyrakk (2500)
	[210847] = "dream wardens", -- Tears of the Eye (2500)
	[210757] = "dream wardens", -- Scales of Remorse (2500)
	[210730] = "dream wardens", -- Mark of the Dream Wardens (2500)
	[211417] = "dream wardens", -- Dream Wardens Insignia (1000)
	[210950] = "dream wardens", -- Insight of Q'onzu (~767)
	[210959] = "dream wardens", -- Pact of the Netherwing (750)
	[211370] = "dream wardens", -- Branch of Gracus (750)
	[210954] = "dream wardens", -- Sprout of Rebirth (750)
	[211366] = "dream wardens", -- Drops of Moon Water (750)
	[211369] = "dream wardens", -- Charred Staff of the Overseer (750)
	[210921] = "dream wardens", -- Bounty of the Fallen Defector (500)
	[210952] = "dream wardens", -- Spare Heated Hearthstone (500)
	[210958] = "dream wardens", -- Crown of the Dryad Daughter (500)
	[211353] = "dream wardens", -- Roasted Ram Special (250)
	[210957] = "dream wardens", -- Rune of the Fire Druids (250)
	[210951] = "dream wardens", -- Treacherous Research Notes (250)
	[210997] = "dream wardens", -- Spare Party Hat (250)
	[211371] = "dream wardens", -- Dryad-Keeper Credentials (250)
	[211379] = "dream wardens", -- Tangled Yarn of Secrets (~118)
	[211374] = "dream wardens", -- Tangled Yarn of Secrets (~96)
	[211378] = "dream wardens", -- Tangled Yarn of Secrets (~19)
	[211377] = "dream wardens", -- Tangled Yarn of Secrets (~19)
	[211380] = "dream wardens", -- Tangled Yarn of Secrets (~9)
	[211372] = "dream wardens", -- Q'onzu's Consolation Prize (1)
	[206006] = "loamm niffen", -- Earth-Warder's Thanks (2500)
	[205998] = "loamm niffen", -- Sign of Respect (2500)
	[205992] = "loamm niffen", -- Regurgitated Half-Digested Fish (2500)
	[205251] = "loamm niffen", -- Champion's Rock Bar (1000)
	[205253] = "loamm niffen", -- Farmhand's Abundant Harvest (1000)
	[205989] = "loamm niffen", -- Symbol of Friendship (2500)
	[205991] = "loamm niffen", -- Shiny Token of Gratitude (2500)
	[205250] = "loamm niffen", -- Gift of the High Redolence (1000)
	[205249] = "loamm niffen", -- Pungent Niffen Incense (1000)
	[202018] = "winterpelt furbolg", -- Intact Scribe Stick
	[202017] = "winterpelt furbolg", -- Liberated Furbolg Artifacts
	[201783] = "iskaara tuskarr", -- Tutaqan's Commendation (2500)
	[201779] = "valdrakken accord", -- Merithra's Blessing (2500)
	[201781] = "valdrakken accord", -- Memory of Tyr (2500)
	[191264] = "sabellian|wrathion|valdrakken accord", -- Restored Obsidian Key (250 Sabellian/Wratghion, 50 Valdrakken)
	[205254] = "dragonscale expedition", -- Honorary Explorer's Compass (1000)
	[201782] = "dragonscale expedition", -- Tyr's Blessing (2500)
	[201411] = "dragonscale expedition", -- Ancient Vault Artifact (30)
	[192055] = "dragonscale expedition", -- Dragon Isles Artifact (15)
	[200071] = "iskaara tuskarr", -- Sacred Tuskarr Totem (15)
	[200093] = "maruuk centaur", -- Centaur Hunting Trophy (25)
	[199906] = "valdrakken accord", -- Titan Relic (15)
	[198790] = "artisan's consortium - dragon isles branch", -- I.O.U. (75)

	-- Shadowlands
	[186685] = "the archivists' codex", -- Relic Fragment (0.5)
	[187322] = "the archivists' codex", -- Crumbling Stone Tablet (4)
	[187457] = "the archivists' codex", -- Engraved Glass Pane (4)
	[187324] = "the archivists' codex", -- Gnawed Ancient Idol (4)
	[187323] = "the archivists' codex", -- Runic Diagram (4)
	[187460] = "the archivists' codex", -- Strangely Intricate Key (4)
	[187458] = "the archivists' codex", -- Unearthed Teleporter Sigil (4)
	[187459] = "the archivists' codex", -- Vial of Mysterious Liquid (4)
	[187465] = "the archivists' codex", -- Complicated Organism Harmonizer (24)
	[187327] = "the archivists' codex", -- Encrypted Korthian Journal (24)
	[187463] = "the archivists' codex", -- Enigmatic Map Fragments (24)
	[187325] = "the archivists' codex", -- Faded Razorwing Anatomy Illustration (24)
	[187326] = "the archivists' codex", -- Half-Completed Runeforge Pattern (24)
	[187462] = "the archivists' codex", -- Scroll of Shadowlands Fables (24)
	[187478] = "the archivists' codex", -- White Razorwing Talon (24)
	[187336] = "the archivists' codex", -- Forbidden Weapon Schematics (50)
	[187466] = "the archivists' codex", -- Korthian Cypher Book (50)
	[187332] = "the archivists' codex", -- Recovered Page of Voices (50)
	[187328] = "the archivists' codex", -- Ripped Cosmology Chart (50)
	[187334] = "the archivists' codex", -- Shattered Void Tablet (50)
	[187330] = "the archivists' codex", -- Naaru Shard Fragment (75)
	[187329] = "the archivists' codex", -- Old God Specimen Jar (75)
	[187467] = "the archivists' codex", -- Perplexing Rune-Cube (75)
	[187331] = "the archivists' codex", -- Tattered Fae Designs (75)
	[187311] = "the archivists' codex", -- Azgoth's Tattered Maps (150)
	[187333] = "the archivists' codex", -- Core of an Unknown Titan (150)
	[187350] = "the archivists' codex", -- Displaced Relic (150)
	[187335] = "the archivists' codex", -- Maldraxxus Larva Shell (150)
	[190339] = "the enlightened", -- Enlightened Offering (75)
	[190941] = "the enlightened", -- Teachings of the Elders (75)
	[176114] = "the countess", -- RSVP: The Countess
	[178686] = "stonehead", -- RSVP: Stonehead
	[176125] = "sika", -- RSVP: Sika
	[176118] = "rendle and cudgelface", -- RSVP: Rendle and Cudgelface
	[176117] = "polemarch adrestes", -- RSVP: Polemarch Adrestes
	[176124] = "plague deviser marileth", -- RSVP: Plague Deviser Marileth
	[176113] = "mikanikos", -- RSVP: Mikanikos
	[176112] = "lady moonberry", -- RSVP: Lady Moonberry
	[176123] = "kleia and pelagos", -- RSVP: Kleia and Pelagos
	[176116] = "hunt-captain korayn", -- RSVP: Hunt-Captain Korayn
	[176122] = "grandmaster vole", -- RSVP: Grandmaster Vole
	[176121] = "droman aliothe", -- RSVP: Droman Aliothe
	[176120] = "cryptkeeper kassir", -- RSVP: Cryptkeeper Kassir
	[176119] = "choofa", -- RSVP: Choofa
	[176097] = "baroness vashj", -- RSVP: Baroness Vashj
	[176115] = "alexandros mograine", -- RSVP: Alexandros Mograine

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
	[49702]  = "the sons of hodir", -- Sons of Hodir Commendation Badge (520)
	[44710]  = "wyrmrest cccord", -- Wyrmrest Commendation Badge (520)
	[43156]  = "wyrmrest accord", -- Tabard of the Wyrmrest Accord
	[35188]  = "cenarion expedition", -- Nesingwary Lackey Ear (15 for 150)

	-- The Burning Crusade
	[24290]  = "sporeggar", -- Mature Spore Sack (750 per 10, up to Friendly)
	[32506]  = "netherwing", -- Netherwing Egg (250)
	[32427]  = "netherwing", -- Netherwing Crystal (250 per 30)
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
	["guild"] 								= { ["id"] = 1168, 	["icon"] = 135026, 		["paragon"] = false,	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },

	-- The War Within
	["council of dornogal"] 				= { ["id"] = 2590, 	["icon"] = 5891369, 	["paragon"] = true, 	["friend"] = 25, ["kind"] = "renown", 		 ["factionGroup"] = false,		["warband"] = true, },
	--["earthen"] 							= { ["id"] = 2645, 	["icon"] = 5359645, 	["paragon"] = false, 	["friend"] = 0,  ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = true, }, -- seems to be scrapped
	["hallowfall arathi"] 					= { ["id"] = 2570, 	["icon"] = 5891368, 	["paragon"] = true, 	["friend"] = 25, ["kind"] = "renown", 		 ["factionGroup"] = false,		["warband"] = true, },
	["the assmebly of the deeps"] 			= { ["id"] = 2594, 	["icon"] = 6029027, 	["paragon"] = true, 	["friend"] = 25, ["kind"] = "renown", 		 ["factionGroup"] = false,		["warband"] = true, },
	["the severed threads"] 				= { ["id"] = 2600, 	["icon"] = 5891370, 	["paragon"] = true, 	["friend"] = 25, ["kind"] = "renown", 		 ["factionGroup"] = false,		["warband"] = true, },
	["the general"] 						= { ["id"] = 2605, 	["icon"] = 5862762, 	["paragon"] = true, 	["friend"] = 9,  ["kind"] = "friendship",    ["factionGroup"] = false,		["warband"] = true, },
	["the vizier"] 							= { ["id"] = 2607, 	["icon"] = 5862763, 	["paragon"] = true, 	["friend"] = 9,  ["kind"] = "friendship",    ["factionGroup"] = false,		["warband"] = true, },
	["the weaver"] 							= { ["id"] = 2601, 	["icon"] = 5862764, 	["paragon"] = true, 	["friend"] = 9,  ["kind"] = "friendship",    ["factionGroup"] = false,		["warband"] = true, },
	["brann bronzebeard"] 					= { ["id"] = 2640, 	["icon"] = 236444,  	["paragon"] = false, 	["friend"] = 60, ["kind"] = "friendship",    ["factionGroup"] = false,		["warband"] = true, },

	-- Dragonflight
	["artisan's consortium - dragon isles branch"] = { ["id"] = 2544, ["icon"] = 4557373, ["paragon"] = false, 	["friend"] = 5,  ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = true, },
	["azerothian archives"] 				= { ["id"] = 2615,  ["icon"] = 4638485,     ["paragon"] = false, 	["friend"] = 5,  ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = true, },
	["cobalt assembly"] 					= { ["id"] = 2550,  ["icon"] = 1394893, 	["paragon"] = false, 	["friend"] = 5,  ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = true, },
	["dragonscale expedition"] 				= { ["id"] = 2507, 	["icon"] = 4687628, 	["paragon"] = true, 	["friend"] = 25, ["kind"] = "renown", 		 ["factionGroup"] = false,		["warband"] = true, },
	["glimmerogg racer"] 					= { ["id"] = 2568,  ["icon"] = 5003559,     ["paragon"] = false,    ["friend"] = 5,  ["kind"] = "friendship",    ["factionGroup"] = false,		["warband"] = false, },
	["iskaara tuskarr"] 					= { ["id"] = 2511, 	["icon"] = 4687629, 	["paragon"] = true, 	["friend"] = 30, ["kind"] = "renown", 		 ["factionGroup"] = false,		["warband"] = true, },
	["loamm niffen"] 						= { ["id"] = 2564, 	["icon"] = 5140835, 	["paragon"] = true, 	["friend"] = 20, ["kind"] = "renown", 		 ["factionGroup"] = false,		["warband"] = true, },
	["dream wardens"] 						= { ["id"] = 2574, 	["icon"] = 5244643, 	["paragon"] = true, 	["friend"] = 20, ["kind"] = "renown", 		 ["factionGroup"] = false,		["warband"] = true, },
	["maruuk centaur"] 						= { ["id"] = 2503, 	["icon"] = 4687627, 	["paragon"] = true, 	["friend"] = 25, ["kind"] = "renown", 		 ["factionGroup"] = false,		["warband"] = true, },
	["sabellian"] 							= { ["id"] = 2518,  ["icon"] = 4630449,     ["paragon"] = false,    ["friend"] = 6,  ["kind"] = "friendship",    ["factionGroup"] = false,		["warband"] = true, },
	["soridormi"]  							= { ["id"] = 2553,  ["icon"] = 922527, 		["paragon"] = false, 	["friend"] = 5,  ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = true, },
	["valdrakken accord"] 					= { ["id"] = 2510, 	["icon"] = 4687630, 	["paragon"] = true, 	["friend"] = 30, ["kind"] = "renown", 		 ["factionGroup"] = false,		["warband"] = true, },
	["winterpelt furbolg"] 					= { ["id"] = 2526, 	["icon"] = 4672495, 	["paragon"] = false, 	["friend"] = 0,  ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["wrathion"] 							= { ["id"] = 2517,  ["icon"] = 4630449,     ["paragon"] = false,    ["friend"] = 6,  ["kind"] = "friendship",    ["factionGroup"] = false,		["warband"] = true, },

	-- Shadowlands
	["court of harvesters"]					= { ["id"] = 2413, 	["icon"] = 3514227, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["court of night"]						= { ["id"] = 2464, 	["icon"] = 3752258, 	["paragon"] = false, 	["friend"] = 5, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["death's advance"]						= { ["id"] = 2470, 	["icon"] = 4064729, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["marasmius"]							= { ["id"] = 2463, 	["icon"] = 464342, 		["paragon"] = false, 	["friend"] = 5, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, }, -- hidden from the Reputation Panel
	["stitchmasters"]						= { ["id"] = 2462, 	["icon"] = 3622121, 	["paragon"] = false, 	["friend"] = 5, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["the archivists' codex"]				= { ["id"] = 2472, 	["icon"] = 1506458, 	["paragon"] = true, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["the ascended"]						= { ["id"] = 2407, 	["icon"] = 3257748, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the avowed"]							= { ["id"] = 2439, 	["icon"] = 3601526, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the enlightened"]						= { ["id"] = 2478, 	["icon"] = 4226232, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the ember court"]						= { ["id"] = 2445, 	["icon"] = 3257751, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the undying army"]					= { ["id"] = 2410, 	["icon"] = 3492310, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the wild hunt"]						= { ["id"] = 2465, 	["icon"] = 3575389, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["ve'nari"]								= { ["id"] = 2432, 	["icon"] = 3527519, 	["paragon"] = true, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	-- The Ember Court
	["alexandros mograine"]					= { ["id"] = 2450, 	["icon"] = 3675493, 	["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["baroness vashj"]						= { ["id"] = 2446, 	["icon"] = 3675493, 	["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["choofa"]								= { ["id"] = 2454, 	["icon"] = 3675493, 	["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["cryptkeeper kassir"]					= { ["id"] = 2455, 	["icon"] = 3675493, 	["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["droman aliothe"]						= { ["id"] = 2456, 	["icon"] = 3675493, 	["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["grandmaster vole"]					= { ["id"] = 2457, 	["icon"] = 3675493, 	["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["hunt-captain korayn"]					= { ["id"] = 2451, 	["icon"] = 3675493, 	["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["kleia and pelagos"]					= { ["id"] = 2458, 	["icon"] = 3675493, 	["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["lady moonberry"]						= { ["id"] = 2447, 	["icon"] = 3675493, 	["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["mikanikos"]							= { ["id"] = 2448, 	["icon"] = 3675493, 	["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["plague deviser marileth"]				= { ["id"] = 2461, 	["icon"] = 3675493, 	["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["polemarch adrestes"]					= { ["id"] = 2452, 	["icon"] = 3675493, 	["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["rendle and cudgelface"]				= { ["id"] = 2453, 	["icon"] = 3675493, 	["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["sika"]								= { ["id"] = 2459, 	["icon"] = 3675493, 	["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["stonehead"]							= { ["id"] = 2460, 	["icon"] = 3675493, 	["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["the countess"]						= { ["id"] = 2449, 	["icon"] = 3675493, 	["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },

	-- Battle for Azeroth
	["7th legion"]							= { ["id"] = 2159, 	["icon"] = 2032591, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["champions of azeroth"]				= { ["id"] = 2164, 	["icon"] = 2032592, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["honeyback hive"]						= { ["id"] = 2395,  ["icon"] = 2027853,		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["order of embers"]						= { ["id"] = 2161, 	["icon"] = 2032594, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["proudmoore admiralty"]				= { ["id"] = 2160, 	["icon"] = 2065573, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["rajani"]								= { ["id"] = 2415, 	["icon"] = 3196265, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["rustbolt resistance"]					= { ["id"] = 2391, 	["icon"] = 2909316, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["storm's wake"]						= { ["id"] = 2162, 	["icon"] = 2032596, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["talanji's expedition"]				= { ["id"] = 2156, 	["icon"] = 2032597, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["the honorbound"]						= { ["id"] = 2157, 	["icon"] = 2032593, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["the unshackled"]						= { ["id"] = 2373,  ["icon"] = 2821782,		["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["tortollan seekers"]					= { ["id"] = 2163, 	["icon"] = 2032598, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["uldum accord"]						= { ["id"] = 2417, 	["icon"] = 3196264, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["voldunai"]							= { ["id"] = 2158, 	["icon"] = 2032599, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["waveblade ankoan"]					= { ["id"] = 2400,  ["icon"] = 2909045,		["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["zandalari empire"]					= { ["id"] = 2103, 	["icon"] = 2032601, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },

	-- Legion
	["argussian reach"] 					= { ["id"] = 2170, 	["icon"] = 1708496, 	["paragon"] = true,		["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["armies of legionfall"] 				= { ["id"] = 2045, 	["icon"] = 1585421, 	["paragon"] = true,		["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["army of the light"] 					= { ["id"] = 2165, 	["icon"] = 1708497, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["chromie"]								= { ["id"] = 2135, 	["icon"] = 237538, 		["paragon"] = false, 	["friend"] = 7, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["conjurer margoss"]					= { ["id"] = 1975, 	["icon"] = 132852, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["court of farondis"] 					= { ["id"] = 1900, 	["icon"] = 1394952, 	["paragon"] = true,  	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["dreamweavers"] 						= { ["id"] = 1883, 	["icon"] = 1394953, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["highmountain tribe"] 					= { ["id"] = 1828, 	["icon"] = 1394954, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the nightfallen"] 					= { ["id"] = 1859, 	["icon"] = 1394956, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the wardens"] 						= { ["id"] = 1894, 	["icon"] = 1394958, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["valarjar"] 							= { ["id"] = 1948, 	["icon"] = 1394957, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["talon's vengeance"]					= { ["id"] = 2018, 	["icon"] = 537444, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	-- Fisherfriends
	["akule riverhorn"]						= { ["id"] = 2099, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["corbyn"]								= { ["id"] = 2100, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, }, -- maybe 132915
	["ilyssia of the waters"]				= { ["id"] = 2097, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["impus"]								= { ["id"] = 2102, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, }, -- maybe 136218
	["keeper raynae"]						= { ["id"] = 2098, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["sha'leth"]							= { ["id"] = 2101, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },

	-- Warlords of Draenor
	["arakkoa outcasts"]					= { ["id"] = 1515, 	["icon"] = 1042646, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["council of exarchs"]					= { ["id"] = 1731, 	["icon"] = 1048727, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["frostwolf orcs"]						= { ["id"] = 1445, 	["icon"] = 1044164, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["hand of the prophet"]					= { ["id"] = 1847, 	["icon"] = 1048305,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, }, -- temp icon
	["laughing skull orcs"]					= { ["id"] = 1708, 	["icon"] = 1043559, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["order of the awakened"]				= { ["id"] = 1849, 	["icon"] = 1240656, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["sha'tari defense"]					= { ["id"] = 1710, 	["icon"] = 1042739, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", ["warband"] = false, },
	["steamwheedle preservation society"]	= { ["id"] = 1711, 	["icon"] = 1052654, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the saberstalkers"]					= { ["id"] = 1850, 	["icon"] = 1240657, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["vol'jin's headhunters"]				= { ["id"] = 1848, 	["icon"] = 1048305, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, }, -- temp icon
	["vol'jin's spear"]						= { ["id"] = 1681, 	["icon"] = 1042727, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["wrynn's vanguard"]					= { ["id"] = 1682, 	["icon"] = 1042294, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	-- Barracks Bodyguards
	["aeda brightdawn"]						= { ["id"] = 1740, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["kind"] = "friendship",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["defender illona"]						= { ["id"] = 1738, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["kind"] = "friendship",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["delvar ironfist"]						= { ["id"] = 1733, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["kind"] = "friendship",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["leorajh"]								= { ["id"] = 1741, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["talonpriest ishaal"]					= { ["id"] = 1737, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["tormmok"]								= { ["id"] = 1736, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["vivianne"]							= { ["id"] = 1739, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["kind"] = "friendship",	 ["factionGroup"] = "Horde",	["warband"] = false, },

	-- Mists of Pandaria
	["dominance offensive"]					= { ["id"] = 1375, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["emperor shaohao"]						= { ["id"] = 1492, 	["icon"] = 645160, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["forest hozen"]						= { ["id"] = 1228, 	["icon"] = 132159, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, }, -- temp icon
	["golden lotus"]						= { ["id"] = 1269, 	["icon"] = 643910, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["kirin tor offensive"]					= { ["id"] = 1387, 	["icon"] = 801132, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["operation: shieldwall"]				= { ["id"] = 1376, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["order of the cloud serpent"]			= { ["id"] = 1271, 	["icon"] = 646324, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["pearlfin jinyu"]						= { ["id"] = 1242, 	["icon"] = 463858, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, }, -- temp icon
	["shado-pan"]							= { ["id"] = 1270, 	["icon"] = 645204, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["shado-pan assault"]					= { ["id"] = 1435, 	["icon"] = 838811, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["sunreaver onslaught"]					= { ["id"] = 1388, 	["icon"] = 838819, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["the august celestials"]				= { ["id"] = 1341, 	["icon"] = 645203, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the black prince"]					= { ["id"] = 1359, 	["icon"] = 656543, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the klaxxi"]							= { ["id"] = 1337, 	["icon"] = 646377, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the lorewalkers"]						= { ["id"] = 1345, 	["icon"] = 645218, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the anglers"]							= { ["id"] = 1302, 	["icon"] = 643874, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["nat pagle"]							= { ["id"] = 1358, 	["icon"] = 133152, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, },
	["the tillers"]							= { ["id"] = 1272, 	["icon"] = 645198, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	-- The Tillers
	["chee chee"]							= { ["id"] = 1277, 	["icon"] = 132926, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, }, -- blue feather
	["ella"]								= { ["id"] = 1275, 	["icon"] = 454045, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, }, -- jade cat
	["farmer fung"]							= { ["id"] = 1283, 	["icon"] = 134210, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, }, -- marsh lily
	["fish fellreed"]						= { ["id"] = 1282, 	["icon"] = 454045, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, }, -- jade cat
	["gina mudclaw"]						= { ["id"] = 1281, 	["icon"] = 134210, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, }, -- marsh lily
	["haohan mudclaw"]						= { ["id"] = 1279, 	["icon"] = 237204, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, }, -- ruby shard
	["jogu the drunk"]						= { ["id"] = 1273, 	["icon"] = 133975, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, }, -- lovely apple
	["old hillpaw"]							= { ["id"] = 1276, 	["icon"] = 132926, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, }, -- blue feather
	["sho"]									= { ["id"] = 1278, 	["icon"] = 133975, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, }, -- lovely apple
	["tina mudclaw"]						= { ["id"] = 1280, 	["icon"] = 237204, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, }, -- ruby shard
	-- Hidden
	["nomi"]								= { ["id"] = 1357, 	["icon"] = 654236, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "friendship",	 ["factionGroup"] = false,		["warband"] = false, }, -- hidden from the Reputation Panel

	-- Cataclysm
	["avengers of hyjal"]					= { ["id"] = 1204, 	["icon"] = 512609, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["baradin's wardens"]					= { ["id"] = 1177, 	["icon"] = 456564, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["dragonmaw clan"]						= { ["id"] = 1172, 	["icon"] = 456565, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["guardians of hyjal"]					= { ["id"] = 1158, 	["icon"] = 456570, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["hellscream's reach"]					= { ["id"] = 1178, 	["icon"] = 456571, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["ramkahen"]							= { ["id"] = 1173, 	["icon"] = 456574, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the earthen ring"]					= { ["id"] = 1135, 	["icon"] = 456567, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["therazane"]							= { ["id"] = 1171, 	["icon"] = 456572, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["wildhammer clan"]						= { ["id"] = 1174, 	["icon"] = 456575, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },

	-- Wrath of the Lich King
	["argent crusade"]						= { ["id"] = 1106, 	["icon"] = 236689, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["kirin tor"]							= { ["id"] = 1090, 	["icon"] = 236693, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["knights of the ebon blade"]			= { ["id"] = 1098, 	["icon"] = 236694, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the ashen verdict"]					= { ["id"] = 1156, 	["icon"] = 343640, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, }, -- actual icon is same as argent crusade, use 343640 instead
	["the kalu'ak"]							= { ["id"] = 1073, 	["icon"] = 236697, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the sons of hodir"]					= { ["id"] = 1119, 	["icon"] = 254107, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the wyrmrest accord"]					= { ["id"] = 1091, 	["icon"] = 236699, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["alliance vanguard"]					= { ["id"] = 1037, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, }, -- generic alliance icon
	["explorer's league"]					= { ["id"] = 1068, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, }, -- generic alliance icon
	["the frostborn"]						= { ["id"] = 1126, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, }, -- generic alliance icon
	["the silver covenant"]					= { ["id"] = 1094, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, }, -- generic alliance icon - tabard uses 134472
	["valiance expedition"]					= { ["id"] = 1050, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, }, -- generic alliance icon
	["horde expedition"]					= { ["id"] = 1052, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, }, -- generic horde icon
	["the hand of vengeance"]				= { ["id"] = 1067, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, }, -- generic horde icon
	["the sunreavers"]						= { ["id"] = 1124, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, }, -- generic horde icon - tabard uses 134473
	["the taunka"]							= { ["id"] = 1064, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, }, -- generic horde icon
	["warsong offensive"]					= { ["id"] = 1085, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, }, -- generic horde icon
	-- Sholazar Basin
	["frenzyheart tribe"]					= { ["id"] = 1104, 	["icon"] = 236698, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the oracles"]							= { ["id"] = 1105, 	["icon"] = 252780, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },

	-- The Burning Crusade
	["ashtongue deathsworn"]				= { ["id"] = 1012, 	["icon"] = 236691, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["cenarion expedition"]					= { ["id"] = 942, 	["icon"] = 132280, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["honor hold"]							= { ["id"] = 946, 	["icon"] = 134502, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["keepers of time"]						= { ["id"] = 989, 	["icon"] = 134156, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, }, -- generic bronze dragon icon
	["kurenai"]								= { ["id"] = 978, 	["icon"] = 458240, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, }, -- generic icon
	["netherwing"]							= { ["id"] = 1015, 	["icon"] = 132250, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["ogri'la"]								= { ["id"] = 1038, 	["icon"] = 133594, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, }, -- alt 236695
	["sporeggar"]							= { ["id"] = 970, 	["icon"] = 134532, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the consortium"]						= { ["id"] = 933, 	["icon"] = 132881, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, }, -- alt 236426
	["the mag'har"]							= { ["id"] = 941, 	["icon"] = 970886, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["the scale of the sands"]				= { ["id"] = 990, 	["icon"] = 136106, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the violet eye"]						= { ["id"] = 967, 	["icon"] = 135933, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["thrallmar"]							= { ["id"] = 947, 	["icon"] = 134504, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["tranquillien"]						= { ["id"] = 922, 	["icon"] = 236765, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	-- Shattrath City
	["lower city"]							= { ["id"] = 1011, 	["icon"] = 135760, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["sha'tari skyguard"]					= { ["id"] = 1031, 	["icon"] = 132191, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["shattered sun offensive"]				= { ["id"] = 1077, 	["icon"] = 134993, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the aldor"]							= { ["id"] = 932, 	["icon"] = 255137, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the scryers"]							= { ["id"] = 934, 	["icon"] = 255136, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["the sha'tar"]							= { ["id"] = 935, 	["icon"] = 1708140, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },

	-- Classic
	["argent dawn"]							= { ["id"] = 529, 	["icon"] = 133440,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["bloodsail buccaneers"]				= { ["id"] = 87, 	["icon"] = 133168,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["brood of nozdormu"]					= { ["id"] = 910, 	["icon"] = 134156,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["cenarion circle"]						= { ["id"] = 609, 	["icon"] = 236692,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["darkmoon faire"]						= { ["id"] = 909, 	["icon"] = 1100023,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["hydraxian waterlords"]				= { ["id"] = 749, 	["icon"] = 135862,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["ravenholdt"]							= { ["id"] = 349, 	["icon"] = 132299,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["thorium brotherhood"]					= { ["id"] = 59, 	["icon"] = 1786406,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["timbermaw hold"]						= { ["id"] = 576, 	["icon"] = 236696,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["wintersaber trainers"]				= { ["id"] = 589, 	["icon"] = 132252,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	-- Alliance
	["darnassus"]							= { ["id"] = 69, 	["icon"] = 255141,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["exodar"]								= { ["id"] = 930, 	["icon"] = 255137,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["gilneas"]								= { ["id"] = 1134, 	["icon"] = 466012,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["gnomeregan"]							= { ["id"] = 54, 	["icon"] = 255139,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["ironforge"]							= { ["id"] = 47, 	["icon"] = 255138,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["stormwind"]							= { ["id"] = 72, 	["icon"] = 255140,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["tushui pandaren"]						= { ["id"] = 1353, 	["icon"] = 626190,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["obsidian warders"]					= { ["id"] = 2524, 	["icon"] = 4528812,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	-- Alliance Forces
	["silverwing sentinels"]				= { ["id"] = 890, 	["icon"] = 132279,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["stormpike guard"]						= { ["id"] = 730, 	["icon"] = 133433,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	["the league of arathor"]				= { ["id"] = 509, 	["icon"] = 132351,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance",	["warband"] = false, },
	-- Horde
	["bilgewater cartel"]					= { ["id"] = 1133, 	["icon"] = 463834,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["darkspear trolls"]					= { ["id"] = 530, 	["icon"] = 255145,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["huojin pandaren"]						= { ["id"] = 1352, 	["icon"] = 626190,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["orgrimmar"]							= { ["id"] = 76, 	["icon"] = 255142,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["silvermoon city"]						= { ["id"] = 911, 	["icon"] = 255136,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["thunder bluff"]						= { ["id"] = 81, 	["icon"] = 255144,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["undercity"]							= { ["id"] = 68, 	["icon"] = 255143,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["dark talons"]							= { ["id"] = 2523, 	["icon"] = 4528811,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	-- Horde Forces
	["frostwolf clan"]						= { ["id"] = 729, 	["icon"] = 133283,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["the defilers"]						= { ["id"] = 510, 	["icon"] = 237568,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	["warsong outriders"]					= { ["id"] = 889, 	["icon"] = 132366,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde",	["warband"] = false, },
	-- Steamwheedle Cartel
	["booty bay"]							= { ["id"] = 21, 	["icon"] = 236844,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["everlook"]							= { ["id"] = 577, 	["icon"] = 236854,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["gadgetzan"]							= { ["id"] = 369, 	["icon"] = 236846,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
	["ratchet"]								= { ["id"] = 470, 	["icon"] = 236717,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false,		["warband"] = false, },
}



local LL= {}

-- Localization Data

-- Translate this (including the "Notes:" part in Paragon.toc) and submit using CurseForge:
-- https://wow.curseforge.com/projects/paragon

-- Don't worry about translating the faction names - that is easily done via Wowhead!



-- English
LL["enUS"] = {
	-- Faction standing labels
	["faction_standing_hated"] 				= FACTION_STANDING_LABEL1, -- Hated
	["faction_standing_hostile"] 			= FACTION_STANDING_LABEL2, -- Hostile
	["faction_standing_unfriendly"] 		= FACTION_STANDING_LABEL3, -- Unfriendly
	["faction_standing_neutral"] 			= FACTION_STANDING_LABEL4, -- Neutral
	["faction_standing_friendly"] 			= FACTION_STANDING_LABEL5, -- Friendly
	["faction_standing_honored"] 			= FACTION_STANDING_LABEL6, -- Honored
	["faction_standing_revered"] 			= FACTION_STANDING_LABEL7, -- Revered
	["faction_standing_exalted"] 			= FACTION_STANDING_LABEL8, -- Exalted
	["faction_standing_paragon"] 			= "Paragon",
	["faction_standing_renown %d"] 			= "Renown %d",
	["faction_standing_level %d"] 			= "Level %d",
	["faction_standing_undiscovered"] 		= "Undiscovered",
	["faction_standing_unknown"] 			= "Saved data is out of date",
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
	-- Ve'nari
	["faction_standing_dubious"] 			= "Dubious",
	["faction_standing_apprehensive"] 		= "Apprehensive",
	["faction_standing_tentative"] 			= "Tentative",
	["faction_standing_ambivalent"] 		= "Ambivalent",
	["faction_standing_cordial"] 			= "Cordial",
	["faction_standing_appreciative"] 		= "Appreciative",
	-- Barracks Bodyguards
	["faction_standing_bodyguard"] 			= "Bodyguard",
	["faction_standing_trusted_bodyguard"]	= "Trusted Bodyguard",
	["faction_standing_personal_wingman"]	= "Personal Wingman",
	-- Nomi
	["faction_standing_apprentice"] 		= "Apprentice",
	["faction_standing_journeyman"] 		= "Journeyman",
	["faction_standing_expert"] 			= "Expert",
	-- The Archivists' Codex
	["faction_standing_tier_1"] 			= "Tier 1",
	["faction_standing_tier_2"] 			= "Tier 2",
	["faction_standing_tier_3"] 			= "Tier 3",
	["faction_standing_tier_4"] 			= "Tier 4",
	["faction_standing_tier_5"] 			= "Tier 5",
	["faction_standing_tier_6"] 			= "Tier 6",
	-- Artisan's Consortium
	["faction_standing_preferred"] 			= "Preferred",
	["faction_standing_respected"] 			= "Respected",
	["faction_standing_valued"] 			= "Valued",
	["faction_standing_esteemed"] 			= "Esteemed",
	-- Sabellian/Wrathion
	["faction_standing_cohort"] 			= "Cohort",
	["faction_standing_ally"] 				= "Ally",
	["faction_standing_fang"] 				= "Fang",
	["faction_standing_true_friend"] 		= "True Friend",
	-- Cobalt Assembly
	["faction_standing_empty"] 				= "Empty",
	["faction_standing_low"] 				= "Low",
	["faction_standing_medium"] 			= "Medium",
	["faction_standing_high"] 				= "High",
	["faction_standing_maximum"] 			= "Maximum",
	-- Glimmerogg Racer
	["faction_standing_aspirational"] 		= "Aspirational",
	["faction_standing_amateur"] 			= "Amateur",
	["faction_standing_competent"] 			= "Competent",
	["faction_standing_skilled"] 			= "Skilled",
	["faction_standing_professional"] 		= "Professional",
	-- Soridormi
	["faction_standing_anomaly"] 			= "Anomaly",
	["faction_standing_future_friend"] 		= "Future Friend",
	["faction_standing_rift-mender"] 		= "Rift-Mender",
	["faction_standing_timewalker"] 		= "Timewalker",
	["faction_standing_legend"] 			= "Legend",
	-- Azerothian Archives
	["faction_standing_junior"] 			= "Junior",
	["faction_standing_capable"] 			= "Capable",
	["faction_standing_learned"] 			= "Learned",
	["faction_standing_resident"] 			= "Resident",
	["faction_standing_tenured"] 			= "Tenured",
	-- The Severed Threads
	["faction_standing_crony"] 				= "Crony",
	["faction_standing_accomplice"] 		= "Accomplice",
	["faction_standing_collaborator"] 		= "Collaborator",
	["faction_standing_accessory"] 			= "Accessory",
	["faction_standing_abettor"] 			= "Abettor",
	["faction_standing_conspirator"] 		= "Conspirator",
	["faction_standing_mastermind"] 		= "Mastermind",


	-- Global
	["highest reputation"] 					= "Highest Reputation",
	["lowest reputation"] 					= "Lowest Reputation",
	["warband"]								= REPUTATION_SORT_TYPE_ACCOUNT, -- Warband

	-- Tooltips
	["hold shift for more"] 				= "<Hold Shift for More>",
	["hold shift for highest reputation"] 	= "<Hold Shift for Highest Reputation>",

	-- Slash Commands
	["/paragon help"] = "|cFF00FFFFParagon|r Usage:\n|cff00ffff/paragon <faction>|r  List Highest Reputation for the specified faction in chat\n|cff00ffff/paragon delete <name or name-realm>|r  Delete a character's data\n|cff00ffff/paragon config|r  Open the Options Panel",

	["/paragon delete no argument"] 		= "|cFF00FFFFParagon|r: No character name specified.",
	["delete character not found"]			= "|cFF00FFFFParagon|r: There is nothing to remove for \"%s\". Make sure you include the character's realm if it's not on %s.",
	["delete character successful"] 		= "|cFF00FFFFParagon|r: Removed all data for \"%s\".",

	-- Results Window
	["reputation not discovered"]			= "None of your characters have discovered\n%s yet.",
	["no results"]							= "Nothing to display for %s.",

	-- Settings Panel
	["cfgFrameSubtext"] 					= "Paragon keeps track of reputation for all your characters.\n\nType |cff00ffff/par <faction>|r in chat to bring up an overview window for a specific reputation faction.\n\n\nTo delete stored data for a character, type |cff00ffff/par delete <name or name-realm>|r in chat.",
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
	["cfgDisplayRealmNames"] 				= "Display Realm Names",
	["cfgShortRealmNames"] 					= "Abbreviate Realm Names Into Acronyms",
	

	-- Faction Names
	-- These should match the name displayed in game in the Reputation UI Panel

	-- This column should be in English		| This column should be translated

	-- Guild
	["f guild"] 							= "Guild",

	-- The War Within
	["f council of dornogal"] 				= "Council of Dornogal",
	["f earthen"] 							= "Earthen",
	["f hallowfall arathi"] 				= "Hallowfall Arathi",
	["f the assmebly of the deeps"] 		= "The Assembl of the Deeps",
	["f the severed threads"] 				= "The Severed Threads",
	["f the general"] 						= "The General",
	["f the vizier"] 						= "The Vizier",
	["f the weaver"] 						= "The Weaver",
	["f brann bronzebeard"] 				= "Brann Bronzebeard",

	-- Dragonflight
	["f artisan's consortium - dragon isles branch"] = "Artisan's Consortium - Dragon Isles Branch",
	["f azerothian archives"] 				= "Azerothian Archives",
	["f cobalt assembly"] 					= "Cobalt Assembly",
	["f dragonscale expedition"] 			= "Dragonscale Expedition",
	["f dream wardens"]						= "Dream Wardens",
	["f glimmerogg racer"]					= "Glimmerogg Racer",
	["f iskaara tuskarr"] 					= "Iskaara Tuskarr",
	["f loamm niffen"]						= "Loamm Niffen",
	["f maruuk centaur"] 					= "Maruuk Centaur",
	["f sabellian"]							= "Sabellian",
	["f soridormi"]  						= "Soridormi",
	["f valdrakken accord"] 				= "Valdrakken Accord",
	["f winterpelt furbolg"]				= "Winterpelt Furbolg",
	["f wrathion"]							= "Wrathion",

	-- Shadowlands
	["f court of harvesters"]				= "Court of Harvesters",
	["f court of night"]					= "Court of Night",
	["f death's advance"]					= "Death's Advance",
	["f marasmius"]							= "Marasmius",
	["f stitchmasters"]						= "Stitchmasters",
	["f the archivists' codex"]				= "The Archivists' Codex",
	["f the ascended"]						= "The Ascended",
	["f the avowed"]						= "The Avowed",
	["f the enlightened"]					= "The Enlightened",
	["f the ember court"]					= "The Ember Court",
	["f the undying army"]					= "The Undying Army",
	["f the wild hunt"]						= "The Wild Hunt",
	["f ve'nari"]							= "Ve'nari",
	-- The Ember Court
	["f alexandros mograine"]				= "Alexandros Mograine",
	["f baroness vashj"]					= "Baroness Vashj",
	["f choofa"]							= "Choofa",
	["f cryptkeeper kassir"]				= "Cryptkeeper Kassir",
	["f droman aliothe"]					= "Droman Aliothe",
	["f grandmaster vole"]					= "Grandmaster Vole",
	["f hunt-captain korayn"]				= "Hunt-Captain Korayn",
	["f kleia and pelagos"]					= "Kleia and Pelagos",
	["f lady moonberry"]					= "Lady Moonberry",
	["f mikanikos"]							= "Mikanikos",
	["f plague deviser marileth"]			= "Plague Deviser Marileth",
	["f polemarch adrestes"]				= "Polemarch Adrestes",
	["f rendle and cudgelface"]				= "Rendle and Crudgelface",
	["f sika"]								= "Sika",
	["f stonehead"]							= "Stonehead",
	["f the countess"]						= "The Countess",

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
	["f obsidian warders"]					= "Obsidian Warders",
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
	["f dark talons"]						= "Dark Talons",
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
-- If I missed something you want specially acronymed, please submit a ticket on GitHub to get it added:
-- https://github.com/leobolin/Paragon/issues

-- To Do:
--  - Russian realms need to be added (future Russian translator please help!)

T.realm_acronyms = {
	["52"] = "52",
	["aegwynn"] = "AW",
	["agamaggan"] = "AM",
	["ahn'qiraj"] = "AQ",
	["al'akir"] = "AA",
	["alexstrasza"] = "AX",
	["aman'thul"] = "AT",
	["anachronos"] = "AC",
	["anatheron"] = "AT",
	["andorhal"] = "AH",
	["anub'arak"] = "AA",
	["arak-arahm"] = "AA",
	["archimonde"] = "AM",
	["arguswacht"] = "AW",
	["auchindoun"] = "AD",
	["azgalor"] = "AG",
	["azjol-nerub"] = "AN",
	["azshara"] = "AZ",
	["azuremyst"] = "AM",
	["balnazzar"] = "BN",
	["barthilas"] = "BT",
	["blackhand"] = "BH",
	["blackrock"] = "BR",
	["blackwing"] = "BW",
	["bladefist"] = "BF",
	["bloodfeather"] = "BF",
	["bloodhoof"] = "BH",
	["bloodscalp"] = "BS",
	["blutkessel"] = "BK",
	["bonechewer"] = "BC",
	["boulderfist"] = "BF",
	["bronzebeard"] = "BB",
	["brotherhood"] = "BH",
	["c'thun"] = "CT",
	["caelestrasz"] = "CSZ",
	["cho'gall"] = "CG",
	["chromaggus"] = "CM",
	["clairvoyants"] = "CV",
	["coilfang"] = "CF",
	["crushridge"] = "CR",
	["daggerspine"] = "DS",
	["dalvengyr"] = "DG",
	["darkmoon"] = "DM",
	["darksorrow"] = "DS",
	["darkspear"] = "DS",
	["darrowmere"] = "DM",
	["dath'remar"] = "DR",
	["dawnbringer"] = "DB",
	["deathwing"] = "DW",
	["destromath"] = "DM",
	["dethecus"] = "DC",
	["doomhammer"] = "DH",
	["dragonblight"] = "DB",
	["dragonflight"] = "DF",
	["dragonmaw"] = "DM",
	["drak'tharon"] = "DT",
	["drak'thul"] = "DT",
	["dreadmaul"] = "DM",
	["drek'thar"] = "DT",
	["drenden"] = "DD",
	["dunemaul"] = "DM",
	["duskwood"] = "DW",
	["echsenkessel"] = "EK",
	["eldre'thalas"] = "ET",
	["executus"] = "EC",
	["exodar"] = "EX",
	["farstriders"] = "FS",
	["feathermoon"] = "FM",
	["firetree"] = "FT",
	["fizzcrank"] = "FC",
	["forscherliga"] = "FL",
	["frostmane"] = "FM",
	["frostmourne"] = "FM",
	["frostwhisper"] = "FW",
	["frostwolf"] = "FW",
	["galakrond"] = "GK",
	["genjuros"] = "GJ",
	["ghostlands"] = "GL",
	["gorefiend"] = "GF",
	["gorgonnash"] = "GG",
	["greymane"] = "GM",
	["gul'dan"] = "GD",
	["gundrak"] = "GD",
	["gurubashi"] = "GB",
	["hakkar"] = "HK",
	["haomarush"] = "HM",
	["hellfire"] = "HF",
	["hellscream"] = "HS",
	["hydraxis"] = "HX",
	["icecrown"] = "IC",
	["jaedenar"] = "JD",
	["jubei'thos"] = "JT",
	["kael'thas"] = "KT",
	["karazhan"] = "KZ",
	["kel'thuzad"] = "KT",
	["khaz'goroth"] = "KG",
	["kil'jaeden"] = "KJ",
	["kor'gall"] = "KG",
	["korialstrasz"] = "KSZ",
	["krag'jin"] = "KJ",
	["lightbringer"] = "LB",
	["lightninghoof"] = "LH",
	["maelstrom"] = "MS",
	["magtheridon"] = "MT",
	["mal'ganis"] = "MG",
	["mannoroth"] = "MR",
	["mazrigos"] = "MZ",
	["mithrilorden"] = "MO",
	["mok'nathal"] = "MN",
	["moonglade"] = "MG",
	["moonrunner"] = "MR",
	["mug'thol"] = "MT",
	["nachtwache"] = "NW",
	["nagrand"] = "NG",
	["nathrezim"] = "NR",
	["naxxramas"] = "NX",
	["nazjatar"] = "NJ",
	["ner'zhul"] = "NZ",
	["nera'thor"] = "NT",
	["nesingwary"] = "NW",
	["netherstorm"] = "NS",
	["nethersturm"] = "NS", -- German, not a typo
	["norgannon"] = "NG",
	["nozdormu"] = "ND",
	["outland"] = "OL",
	["perenolde"] = "PN",
	["proudmoore"] = "PM",
	["quel'dorei"] = "QD",
	["quel'thalas"] = "QT",
	["rashgarroth"] = "RG",
	["ravencrest"] = "RC",
	["ravenholdt"] = "RH",
	["rivendare"] = "RD",
	["runetotem"] = "RT",
	["saurfang"] = "SF",
	["scarshield"] = "SS",
	["sen'jin"] = "SJ",
	["shadowmoon"] = "SM",
	["shadowsong"] = "SS",
	["shen'dralar"] = "SD",
	["shu'halo"] = "SH",
	["silvermoon"] = "SM",
	["sinstralis"] = "SS",
	["skullcrusher"] = "SC",
	["skywall"] = "SW",
	["smolderthorn"] = "ST",
	["spinebreaker"] = "SB",
	["spirestone"] = "SS",
	["staghelm"] = "SH",
	["steamwheedle"] = "SW",
	["stonemaul"] = "SM",
	["stormrage"] = "SR",
	["stormreaver"] = "SR",
	["stormscale"] = "SC",
	["sunstrider"] = "SS",
	["talnivarr"] = "TN",
	["terokkar"] = "TK",
	["throk'feroth"] = "TF",
	["thunderhorn"] = "TH",
	["thunderlord"] = "TL",
	["todeskrallen"] = "TK",
	["todeswache"] = "TW",
	["tortheldrin"] = "TT",
	["trollbane"] = "TB",
	["turalyon"] = "TL",
	["uldaman"] = "UM",
	["un'goro"] = "UG",
	["underbog"] = "UB",
	["undermine"] = "UM",
	["varimathras"] = "VM",
	["vek'lor"] = "VL",
	["vek'nilash"] = "VN",
	["vol'jin"] = "VJ",
	["warsong"] = "WS",
	["whisperwind"] = "WW",
	["wildhammer"] = "WH",
	["windrunner"] = "WR",
	["winterhoof"] = "WH",
	["wrathbringer"] = "WB",
	["zangarmarsh"] = "ZM",
	["zul'jin"] = "ZJ",
	["zuluhed"] = "ZH",
	["(português)"] = "", -- Workaround for Aggra EU so it's not displayed as "A("
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


local L = T.L

SLASH_PARAGON1 = "/paragon"
SLASH_PARAGON2 = "/par"
local WARBAND_ICON = CreateAtlasMarkup("questlog-questtypeicon-account")

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
	["tooltip_alts_limit_shift"] = 10,
	["display_realm_names"] = true,
	["short_realm_names"] = false,
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

-- Cut off text that is too long
function ellipsis(str, limit)
	if #str > (limit + 1) then
		str = string.sub(str, 0, limit) .. "..."
	end

	return str
end


-- Create the frame and register events
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

-- Scroll Frame
resultsScrollFrame = CreateFrame("ScrollFrame", nil, resultsFrame, BackdropTemplateMixin and "BackdropTemplate")
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
resultsScrollFrame:EnableMouseWheel(1)
resultsScrollFrame:SetScript("OnMouseWheel",
	function (self, value)
		resultsScrollbar:SetValue(resultsScrollbar:GetValue() - (value*24*5))
	end
)
resultsFrame.scrollFrame = resultsScrollFrame

-- Scroll Bar
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

-- Content Frame
local resultsContent = CreateFrame("Frame", nil, resultsScrollFrame)
resultsScrollFrame.content = resultsContent
resultsScrollFrame:SetScrollChild(resultsContent)


-- Labels
local resultsFrameFactionLabel = resultsFrame:CreateFontString("OVERLAY", nil, "GameFontNormalLarge")
resultsFrameFactionLabel:SetPoint("TOPLEFT", 12, -32)
resultsFrameFactionLabel:SetHeight(24)
resultsFrameFactionLabel:SetJustifyH("LEFT")
resultsFrameFactionLabel:SetJustifyV("MIDDLE")






-- Realm formatting
local function format_realm(realmName)
	if realmName == T.realm or not ShiGuangDB["ParagonDBconfig"]["display_realm_names"] then
		return "" -- Same realm as player or realm names are turned off
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

		return "- ★" --.. realmName
	end
end


-- Function to update current player's repuation standings
local function updateFactions()
	if not ShiGuangDB then return end

	-- Replace current character's saved data with current data
	ShiGuangDB["ParagonDBcharacter"][T.charStr] = { ["name"] = T.player, ["realm"] = T.realm, ["class"] = T.class, ["level"] = T.level, ["factionGroup"] = T.factionGroup }

	for faction, data in pairs(T.faction) do
		local id, icon, paragon, factionGroup, friend, kind = data["id"], data["icon"], data["paragon"], data["factionGroup"], data["friend"], data["kind"]
		local name, standingId, barMin, barMax, barValue, renownLevel = "", 4, 0, 0, 0, 0

		if kind == "friendship" then
			local friendship = C_GossipInfo.GetFriendshipReputation(id)
			barValue = friendship.standing or 0
			barMin = friendship.reactionThreshold
			barMax = friendship.nextThreshold or 42000
			name = friendship.name or name

			if id == 1740 or id == 1738 or id == 1733 or id == 1741 or id == 1737 or id == 1736 or id == 1739 then -- Garrison Bodyguards
				if barValue >= 20000 then standingId = 3
				elseif barValue >= 10000 then standingId = 2
				else standingId = 1
				end
			elseif id == 2135 then -- Chromie
				if barValue >= 15000 then standingId = 7
				elseif barValue >= 10000 then standingId = 6
				elseif barValue >= 7000 then standingId = 5
				elseif barValue >= 4500 then standingId = 4
				elseif barValue >= 2500 then standingId = 3
				elseif barValue >= 1000 then standingId = 2
				else standingId = 1
				end
			elseif id == 2464 or id == 2463 or id == 2462 then -- Court of Night, Marasmius, Stitchmasters
				if barValue >= 42000 then standingId = 5
				elseif barValue >= 21000 then standingId = 4
				elseif barValue >= 9000 then standingId = 3
				elseif barValue >= 3000 then standingId = 2
				else standingId = 1
				end
			elseif id == 2432 then -- Ve'nari
				if barValue >= 42000 then standingId = 6
				elseif barValue >= 21000 then standingId = 5
				elseif barValue >= 14000 then standingId = 4
				elseif barValue >= 7000 then standingId = 3
				elseif barValue >= 1000 then standingId = 2
				else standingId = 1
				end
			elseif id == 2472 then -- The Archivists' Codex
				if barValue >= 41000 then standingId = 6
				elseif barValue >= 25000 then standingId = 5
				elseif barValue >= 14000 then standingId = 4
				elseif barValue >= 7500 then standingId = 3
				elseif barValue >= 3000 then standingId = 2
				else standingId = 1
				end
			elseif id == 2544 then -- Artisan's Consortium - Dragon Isles Branch
				if barValue >= 12500 then standingId = 5
				elseif barValue >= 5500 then standingId = 4
				elseif barValue >= 2500 then standingId = 3
				elseif barValue >= 500 then standingId = 2
				else standingId = 1
				end
			elseif id == 2550 then -- Cobalt Assembly
				if barValue >= 10000 then standingId = 5
				elseif barValue >= 3600 then standingId = 4
				elseif barValue >= 1200 then standingId = 3
				elseif barValue >= 300 then standingId = 2
				else standingId = 1
				end
			elseif id == 2553 then -- Soridormi
				if barValue >= 42000 then standingId = 5
				elseif barValue >= 24000 then standingId = 4
				elseif barValue >= 14000 then standingId = 3
				elseif barValue >= 7000 then standingId = 2
				else standingId = 1
				end
			elseif id == 2615 then -- Azerothian Archives
				if barValue >= 42000 then standingId = 5
				elseif barValue >= 32500 then standingId = 4
				elseif barValue >= 21000 then standingId = 3
				elseif barValue >= 10500 then standingId = 2
				else standingId = 1
				end
			elseif id == 2605 or id == 2607 or id == 2601 then -- The General, The Vizier, The Weaver
				if barValue >= 20000 then standingId = 9
				elseif barValue >= 17500 then standingId = 8
				elseif barValue >= 15000 then standingId = 7
				elseif barValue >= 12500 then standingId = 6
				elseif barValue >= 10000 then standingId = 5
				elseif barValue >= 7500 then standingId = 4
				elseif barValue >= 5000 then standingId = 3
				elseif barValue >= 2500 then standingId = 2
				else standingId = 1
				end
			elseif id == 2640 then -- Brann Bronzebeard
				if barValue >= 676997 then standingId = 60
				elseif barValue >= 664497 then standingId = 59
				elseif barValue >= 651997 then standingId = 58
				elseif barValue >= 639497 then standingId = 57
				elseif barValue >= 626997 then standingId = 56
				elseif barValue >= 614497 then standingId = 55
				elseif barValue >= 601997 then standingId = 54
				elseif barValue >= 589497 then standingId = 53
				elseif barValue >= 576997 then standingId = 52
				elseif barValue >= 564497 then standingId = 51
				elseif barValue >= 551997 then standingId = 50
				elseif barValue >= 539497 then standingId = 49
				elseif barValue >= 526997 then standingId = 48
				elseif barValue >= 514497 then standingId = 47
				elseif barValue >= 501997 then standingId = 46
				elseif barValue >= 489497 then standingId = 45
				elseif barValue >= 476997 then standingId = 44
				elseif barValue >= 464497 then standingId = 43
				elseif barValue >= 451997 then standingId = 42
				elseif barValue >= 439497 then standingId = 41
				elseif barValue >= 426997 then standingId = 40
				elseif barValue >= 414497 then standingId = 39
				elseif barValue >= 401997 then standingId = 38
				elseif barValue >= 389497 then standingId = 37
				elseif barValue >= 376997 then standingId = 36
				elseif barValue >= 364497 then standingId = 35
				elseif barValue >= 351997 then standingId = 34
				elseif barValue >= 339497 then standingId = 33
				elseif barValue >= 326997 then standingId = 32
				elseif barValue >= 314497 then standingId = 31
				elseif barValue >= 301997 then standingId = 30
				elseif barValue >= 289497 then standingId = 29
				elseif barValue >= 276997 then standingId = 28
				elseif barValue >= 264497 then standingId = 27
				elseif barValue >= 251997 then standingId = 26
				elseif barValue >= 239497 then standingId = 25
				elseif barValue >= 226997 then standingId = 24
				elseif barValue >= 214497 then standingId = 23
				elseif barValue >= 201997 then standingId = 22
				elseif barValue >= 189497 then standingId = 21
				elseif barValue >= 176997 then standingId = 20
				elseif barValue >= 164497 then standingId = 19
				elseif barValue >= 151997 then standingId = 18
				elseif barValue >= 139497 then standingId = 17
				elseif barValue >= 126997 then standingId = 16
				elseif barValue >= 114497 then standingId = 15
				elseif barValue >= 101997 then standingId = 14
				elseif barValue >= 89497 then standingId = 13
				elseif barValue >= 76997 then standingId = 12
				elseif barValue >= 64497 then standingId = 11
				elseif barValue >= 51997 then standingId = 10
				elseif barValue >= 41248 then standingId = 9
				elseif barValue >= 32290 then standingId = 8
				elseif barValue >= 24825 then standingId = 7
				elseif barValue >= 18604 then standingId = 6
				elseif barValue >= 13420 then standingId = 5
				elseif barValue >= 9100 then standingId = 4
				elseif barValue >= 5500 then standingId = 3
				elseif barValue >= 2500 then standingId = 2
				else standingId = 1
				end
			else -- Default
				if barValue >= 42000 then standingId = 6
				elseif barValue >= 33600 then standingId = 5
				elseif barValue >= 25200 then standingId = 4
				elseif barValue >= 16800 then standingId = 3
				elseif barValue >= 8400 then standingId = 2
				else standingId = 1
				end
			end
		elseif kind == "renown" then
			local data = C_MajorFactions.GetMajorFactionData(id)
			standingId = data.renownLevel or 1
			barValue = data.renownReputationEarned or 0
			barMax = data.renownLevelThreshold or 2500
			name = data.name or name
		else
			local factionData = C_Reputation.GetFactionDataByID(id)
			if factionData then
				name, standingId, barMin, barMax, barValue = factionData.name, factionData.reaction, factionData.currentReactionThreshold, factionData.nextReactionThreshold, factionData.currentStanding
			end
		end

		local currentValue, threshold, _, hasRewardPending = C_Reputation.GetFactionParagonInfo(id)


		if factionGroup == false or factionGroup == T.factionGroup then -- Only include same side and neutral factions
			if currentValue then
				currentValue = currentValue % threshold
				if hasRewardPending then currentValue = currentValue + threshold end

				ShiGuangDB["ParagonDBcharacter"][T.charStr][faction] = {
					["standingId"] = (kind == "renown") and standingId or 9, -- Paragon
					["current"] = currentValue,
					["max"] = threshold,
					["hasRewardPending"] = hasRewardPending,
				}
			elseif kind == "renown" then
				ShiGuangDB["ParagonDBcharacter"][T.charStr][faction] = {
					["standingId"] = standingId, -- Renown level
					["current"] = barValue,
					["max"] = barMax,
					["hasRewardPending"] = false,
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
			DEFAULT_CHAT_FRAME:AddMessage(L["/paragon delete no argument"])
		end
		return
	else
		characterName = string.lower(characterName)
	end

	if setContains(ShiGuangDB["ParagonDBcharacter"], characterName) then
		ShiGuangDB["ParagonDBcharacter"][characterName] = nil
		if verbose then
			DEFAULT_CHAT_FRAME:AddMessage(string.format(L["delete character successful"], characterName))
		end
		return
	else
		characterName = characterName .. string.lower("-"..T.realm)
	end

	if setContains(ShiGuangDB["ParagonDBcharacter"], characterName) and characterName ~= string.lower("-"..T.realm) then
		ShiGuangDB["ParagonDBcharacter"][characterName] = nil
		if verbose then
			DEFAULT_CHAT_FRAME:AddMessage(string.format(L["delete character successful"], characterName))
		end
		return
	elseif verbose and characterName == string.lower("-"..T.realm) then
		DEFAULT_CHAT_FRAME:AddMessage(L["/paragon delete no argument"])
	elseif verbose then
		DEFAULT_CHAT_FRAME:AddMessage(string.format(L["delete character not found"], characterName, T.realm))
	end
end


-- Functions to format standings
local function standing(standingId, faction)
	if setContains(T.faction, faction) then
		if T.faction[faction]["kind"] == "renown" then
			if standingId == T.faction[faction]["friend"] then
				return T.standing[9] -- Paragon
			elseif standingId > 0 then
				return L["faction_standing_renown %d"]:format(standingId)
			else
				return L["faction_standing_undiscovered"]
			end
		elseif faction == "brann bronzebeard" then
			if standingId == T.faction[faction]["friend"] then
				return T.standing[9] -- Paragon
			elseif standingId > 0 then
				return L["faction_standing_level %d"]:format(standingId)
			else
				return L["faction_standing_undiscovered"]
			end
		elseif T.faction[faction]["friend"] ~= 0 then
			if setContains(T.friendStanding, faction) then
				if T.friendStanding[faction][standingId] then
					return L[T.friendStanding[faction][standingId]]
				else
					return L["faction_standing_unknown"]
				end
			else
				return L[T.friendStanding["default"][standingId]]
			end
		elseif setContains(T.friendStanding, faction) then
			return L[T.friendStanding[faction][standingId]]
		else
			return T.standing[standingId]
		end
	else
		return T.standing[standingId]
	end
end

local function standingColor(standingId, faction)
	if setContains(T.faction, faction) then
		if T.faction[faction]["kind"] == "renown" then
			if standingId == T.faction[faction]["friend"] then
				return T.standingColor[9] -- Max renown
			elseif standingId >= 20 then
				return T.standingColor[7]
			elseif standingId >= 10 then
				return T.standingColor[6]
			elseif standingId > 0 then
				return T.standingColor[5]
			else
				return T.standingColor[4] -- Undiscovered
			end
		elseif faction == "brann bronzebeard" then
			if standingId == T.faction[faction]["friend"] then
				return T.standingColor[8] -- Max level
			elseif standingId >= 50 then
				return T.standingColor[7]
			elseif standingId >= 30 then
				return T.standingColor[6]
			elseif standingId > 1 then
				return T.standingColor[5]
			else
				return T.standingColor[4] -- Level 1
			end
		elseif T.faction[faction]["friend"] ~= 0 then
			if setContains(T.friendStandingColor, faction) then
				return T.friendStandingColor[faction][standingId] or T.standingColor[1]
			else
				return T.friendStandingColor["default"][standingId]
			end
		elseif setContains(T.friendStandingColor, faction) then
			return T.friendStandingColor[faction][standingId]
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
		return false
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
			sortTable[char] = tostring(string.format("%04.4d", tbl[faction]["standingId"]) .. "." .. string.format("%09.7d", tbl[faction]["current"]))
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

		if (not T.faction[faction]["warband"] and not (ShiGuangDB["ParagonDBconfig"]["tooltip_hide_exalted"] and standingId == 8) and not (ShiGuangDB["ParagonDBconfig"]["tooltip_hide_neutral"] and standingId == 4) and not (ShiGuangDB["ParagonDBconfig"]["tooltip_hide_unfriendly"] and standingId <= 3)) or outputFormat == "ui" then
			i = i + 1

			if i == 1 then
				if outputFormat == "ui" then
					--content frame
					resultsContent:Hide()

					resultsFrameFactionLabel:SetText("|T" .. T.faction[faction]["icon"] .. ":24:24|t  " .. L["f "..faction])

					resultsContent = CreateFrame("Frame", nil, resultsScrollFrame)
					resultsScrollFrame.content = resultsContent
					resultsScrollFrame:SetScrollChild(resultsContent)

					resultsFrame:Show()
				else
					out = "|cFF00FFFFParagon|r\n|T" .. T.faction[faction]["icon"] .. ":0|t " .. L["f "..faction] .. " - " .. L["highest reputation"]
				end
			end

			if ((i <= limit or outputFormat == "ui") and not T.faction[faction]["warband"]) or (T.faction[faction]["warband"] and char == T.charStr) then
				local displayAmount = FormatLargeNumber(factionTable[char]["current"]) .. " / " .. FormatLargeNumber(factionTable[char]["max"])
				if T.faction[faction]["kind"] == "renown" then
					if standingId == 0 or (standingId == T.faction[faction]["friend"] and not T.faction[faction]["paragon"]) then
						displayAmount = "" -- Max renown level (no paragon) or undiscovered
					end
				elseif standingId == 8 or (T.faction[faction]["friend"] ~= 0 and standingId >= T.faction[faction]["friend"] and standingId ~= 9) then -- Exalted/Best Friend
					displayAmount = "" -- Exalted reputations do not have amounts
				end

				local line = "|c" .. RAID_CLASS_COLORS[d["class"]].colorStr .. ellipsis(d["name"] .. format_realm(d["realm"]), 30) .. "|r  " .. standingColor(standingId, faction) .. standing(standingId, faction) .. displayAmount .. "|r"

				if outputFormat == "ui" then
					if T.faction[faction]["warband"] and char == T.charStr then i = 1 end

					local offset = (i - 1) * -24

					local rowBg = CreateFrame("Frame", nil, resultsContent, BackdropTemplateMixin and "BackdropTemplate")
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
					if T.faction[faction]["warband"] then
						label:SetText(WARBAND_ICON .. " |cff00ccff" .. L["warband"] .. "|r")
					else
						label:SetText("|c" .. RAID_CLASS_COLORS[d["class"]].colorStr .. ellipsis(d["name"] .. format_realm(d["realm"]), 23) .. "|r")
					end
					label:SetHeight(24)
					label:SetJustifyV("MIDDLE")

					-- Standing
					local label = rowBg:CreateFontString("OVERLAY", nil, "GameFontNormalSmall")
					label:SetPoint("TOPLEFT", 175, 0)
					label:SetText(standingColor(standingId, faction) .. standing(standingId, faction) .. "|r")
					label:SetHeight(24)
					label:SetJustifyV("MIDDLE")

					-- Amount
					if displayAmount ~= "" then
						local label = rowBg:CreateFontString("OVERLAY", nil, "GameFontNormalSmall")
						label:SetPoint("TOPLEFT", 270, 0)
						label:SetText(standingColor(standingId, faction) .. displayAmount .. "|r")
						label:SetHeight(24)
						--label:SetWidth(100)
						label:SetJustifyH("LEFT")
						label:SetJustifyV("MIDDLE")
					end

					if T.faction[faction]["warband"] and char == T.charStr then break end
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

			resultsFrameFactionLabel:SetText("|T" .. T.faction[faction]["icon"] .. ":24:24|t  " .. L["f "..faction])

			resultsContent = CreateFrame("Frame", nil, resultsScrollFrame)
			resultsScrollFrame.content = resultsContent
			resultsScrollFrame:SetScrollChild(resultsContent)

			resultsFrame:Show()

			local label = resultsContent:CreateFontString("OVERLAY", nil, "GameFontNormalLarge")
			label:SetPoint("TOPLEFT", 10, -10)
			label:SetText(string.format(L["reputation not discovered"], L["f "..faction]))
			label:SetJustifyV("MIDDLE")
			label:SetJustifyH("CENTER")
			label:SetWidth(360)
			label:SetHeight(460)
		else
			out = "|cFF00FFFFParagon|r: " .. string.format(L["no results"], "\"" .. L["f "..faction] .. "\"")
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
local function OnTooltipSetItem(tooltip, data)
	if not data then return end -- If there is no data we do nothing
	local tooltip = tooltip
	local match = string.match

	local link = data.guid and C_Item.GetItemLinkByGUID(data.guid)
	local itemId = data.id or false
	if not link or not itemId then return end

	if setContains(T.reputationItemBoA, itemId) or setContains(T.reputationItemBoP, itemId) then
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
				tooltip:AddLine("|cffffffff" .. (T.faction[faction]["warband"] and (WARBAND_ICON .. " ") or "") .. L["f "..faction] .. "|r")

				local displayAmount = FormatLargeNumber(d[faction]["current"]) .. " / " .. FormatLargeNumber(d[faction]["max"])
				if T.faction[faction]["kind"] == "renown" then
					if standingId == 0 or (standingId == T.faction[faction]["friend"] and not T.faction[faction]["paragon"]) then
						displayAmount = "" -- Max renown level (no paragon) or undiscovered
					end
				elseif d[faction]["standingId"] == 8 or (T.faction[faction]["friend"] ~= 0 and d[faction]["standingId"] >= T.faction[faction]["friend"]) then
					displayAmount = "" -- Exalted/Best Friend
				end

				if displayAmount ~= "" then
					tooltip:AddDoubleLine(standingColor(d[faction]["standingId"], faction) .. standing(d[faction]["standingId"], faction) .. "|r", standingColor(d[faction]["standingId"], faction) .. displayAmount .. "|r")
				else
					tooltip:AddLine(standingColor(d[faction]["standingId"], faction) .. standing(d[faction]["standingId"], faction) .. "|r")
				end
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
					tooltip:AddLine("|cff00ff00"..L["hold shift for more"].."|r")
				end
				--tooltip:AddLine(" ")
			end
		elseif ShiGuangDB["ParagonDBconfig"]["tooltip_alts_enabled_shift"] and limit_shift >= 1 and totalFactions == 1 then
			if IsShiftKeyDown() then
				tooltip:AddLine(" ")
				if ShiGuangDB["ParagonDBconfig"]["tooltip_alts_enabled_alt"] and IsAltKeyDown() then
					tooltip:AddLine(L["lowest reputation"])
				else
					tooltip:AddLine(L["highest reputation"])
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
				--tooltip:AddLine("|cff00ff00"..L["hold shift for highest reputation"].."|r")
			end
		end
	end
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetItem)


-- Slash Commands
function SlashCmdList.PARAGON(msg, editbox)
	local _, _, cmd, args = string.find(msg, "([%w%p]+)%s*(.*)$")
	if(cmd) then
		cmd = string.lower(cmd)
	end
	if(args) then
		args = string.lower(args)
	end

	if cmd == "config" or cmd == "cfg" or cmd == "settings" or cmd == "options" then
		Settings.OpenToCategory("Paragon")
	elseif cmd == "delete" or cmd == "del" then
		deleteCharacter(args, true)
	else
		local guildname = GetGuildInfo("player")

		if L["shorthands"] and L["shorthands"][string.lower(msg)] then
			msg = L["shorthands"][string.lower(msg)]
		elseif guildname and msg and string.lower(msg) == string.lower(guildname) then
			msg = "guild"
		-- Since shorthands and guild have failed, try partial match now
		-- Make sure no valid full faction string is given either
		else --if not outputFaction(msg, 1, "test") then
			msg = string.lower(msg)
			-- Partial string match against the localized faction name strings
			local found = false
			for f, _ in pairs(T.faction) do
				if L["f "..f] then
					if L["f "..f]:lower():find(msg, nil, true) then
						--print(format('Paragon Debug: Found "%s" as partial string in faction "%s".', msg, L["f "..f])) -- Debug
						msg, found = L["f "..f], true
						break
					end
				end
			end
			-- As last resort, partial string match against the shorthand strings
			if not found and L["shorthands"] then
				for s, f in pairs(L["shorthands"]) do
					if s:find(msg, nil, true) then
						--print(format('Paragon Debug: Found "%s" as partial string in shorthand "%s".', msg, s)) -- Debug
						msg = f
						break
					end
				end
			end
		end

		if outputFaction(msg, 1, "test") then
			outputFaction(msg, 0, "ui")
		else
			DEFAULT_CHAT_FRAME:AddMessage(L["/paragon help"])
		end
	end
end


-- Event Handler
local function eventHandler(self, event)
	if event == "VARIABLES_LOADED" then
		-- Make sure defaults are set
		if not ShiGuangDB["ParagonDBconfig"] then ShiGuangDB = {["ParagonDBconfig"] = T.defaults, ["ParagonDBcharacter"] = {} } end

		for key, value in pairs(T.defaults) do
			if not setContains(ShiGuangDB["ParagonDBconfig"], key) then
				ShiGuangDB["ParagonDBconfig"][key] = value
			end
		end
	end

	updateFactions()
end

frame:SetScript("OnEvent", eventHandler)

--local category, layout = Settings.RegisterCanvasLayoutCategory(cfgFrame, cfgFrame.name)
--Settings.RegisterAddOnCategory(category)
--T.SettingsID = category:GetID()
