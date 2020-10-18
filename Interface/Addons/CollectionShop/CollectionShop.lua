--------------------------------------------------------------------------------------------------------------------------------------------
-- Initialize Variables
--------------------------------------------------------------------------------------------------------------------------------------------
local NS = select( 2, ... );
local L = NS.localization;
NS.releasePatch = "9.0.1";
NS.versionString = "4.03";
NS.version = tonumber( NS.versionString );
--
NS.options = {};
--
NS.initialized = false;
NS.realmName = GetRealmName();
NS.playerLoginMsg = {};
NS.AuctionHouseFrameTab = nil;
NS.scan = {};
NS.modes = { "MOUNTS", "PETS", "TOYS", "APPEARANCES", "RECIPES" };
NS.modeNames = { "Mounts", "Pets", "Toys", "Appearances", "Recipes" };
NS.modeNums = { [NS.modes[1]] = 1, [NS.modes[2]] = 2, [NS.modes[3]] = 3, [NS.modes[4]] = 4, [NS.modes[5]] = 5 };
NS.modeColorCodes = { ITEM_QUALITY_COLORS[6].hex, ITEM_QUALITY_COLORS[5].hex, "|cff66bbff", "|c" .. TRANSMOGRIFY_FONT_COLOR:GenerateHexColor(), "|c" .. RAID_CLASS_COLORS["MONK"].colorStr };
NS.modeFilters = {};
NS.modeFiltersFlyout = {};
NS.mode = nil;
NS.modeName = nil;
NS.modeColorCode = nil;
NS.NUM_TRANSMOG_COLLECTION_TYPES = NS.Count(Enum.TransmogCollectionType);
--
NS.mountCollection = {};
NS.petCollection = {};
NS.toyCollection = {};
NS.appearanceCollection = {
	categoryNames = {},
	appearances = {},
	sources = {},
	getAllReady = false,
};
NS.recipeCollection = {};
NS.shopAppearancesBy = nil; -- appearance, source
--
NS.auction = {
	data = {
		live = {
			itemIds = {},
			appearanceSources = {},
		},
		groups = {},
		sortKey = nil,
		sortOrder = nil,
	},
};
NS.linkLevel = nil;
NS.linkSpecID = nil;
NS.playerClassID = select( 3, UnitClass( "player" ) );
NS.playerProfessions = {};
NS.numAuctionsWon = 0;
NS.copperAuctionsWon = 0;
NS.auctionsWon = {};
--
NS.adjustScrollFrame = true;
NS.isPctItemValue = nil; -- Set in ScrollFrame:Adjust()
NS.NextAdjustScroll = false;
NS.disableFlyoutChecks = false;
NS.buyAll = false;
NS.invTypeToSlotId = {
    ['INVTYPE_HEAD'] = 1,
    ['INVTYPE_SHOULDER'] = 3,
    ['INVTYPE_CLOAK'] = 15,
    ['INVTYPE_CHEST'] = 5,
    ['INVTYPE_ROBE'] = 5,
    ['INVTYPE_BODY'] = 4,
    ['INVTYPE_TABARD'] = 19,
    ['INVTYPE_WRIST'] = 9,
    ['INVTYPE_HAND'] = 10,
    ['INVTYPE_WAIST'] = 6,
    ['INVTYPE_LEGS'] = 7,
    ['INVTYPE_FEET'] = 8,
    ['INVTYPE_WEAPON'] = 16,
	['INVTYPE_WEAPONMAINHAND'] = 16,
	['INVTYPE_2HWEAPON'] = 16,
	['INVTYPE_RANGED'] = 16,
	['INVTYPE_RANGEDRIGHT'] = 16,
    ['INVTYPE_WEAPONOFFHAND'] = 17,
	['INVTYPE_SHIELD'] = 17,
    ['INVTYPE_HOLDABLE'] = 17,
};
NS.craftingProfessions = { 2259,2018,7411,4036,45357,25229,2108,3908,2550 }; -- Spells: Alchemy, Blacksmithing, Enchanting, Engineering, Inscription, Jewelcrafting, Leatherworking, Tailoring, Cooking
for i = 1, #NS.craftingProfessions do
	local spellName = GetSpellInfo( NS.craftingProfessions[i] );
	if spellName then
		NS.craftingProfessions[i] = spellName;
	else
		NS.Print( string.format( L["%d : Missing crafting profession spell."], NS.craftingProfessions[i] ) );
	end
end
NS.skills = {
	--
	-- Recipes may be associated with any of these skill ids, but this list associates the specific skill id back to its base skill id.
	-- http://www.wowhead.com/skills
	--
	-- name[baseSkillID] = baseSkillName
	--
	name = {
		[171] = NS.craftingProfessions[1], -- Alchemy
		[164] = NS.craftingProfessions[2], -- Blacksmithing
		[333] = NS.craftingProfessions[3], -- Enchanting
		[202] = NS.craftingProfessions[4], -- Engineering
		[773] = NS.craftingProfessions[5], -- Inscription
		[755] = NS.craftingProfessions[6], -- Jewelcrafting
		[165] = NS.craftingProfessions[7], -- Leatherworking
		[197] = NS.craftingProfessions[8], -- Tailoring
		[185] = NS.craftingProfessions[9], -- Cooking
	},
	--
	-- [specificSkillID] = baseSkillID
	-- [baseSkillName] = baseSkillID
	--
	-- Alchemy
	[NS.craftingProfessions[1]] = 171, -- Alchemy
	[171] = 171, -- Alchemy
	[2485] = 171, -- Alchemy
	[2484] = 171, -- Outland Alchemy
	[2483] = 171, -- Northrend Alchemy
	[2482] = 171, -- Cataclysm Alchemy
	[2481] = 171, -- Pandaria Alchemy
	[2480] = 171, -- Draenor Alchemy
	[2479] = 171, -- Legion Alchemy
	[2478] = 171, -- Kul Tiran Alchemy
	-- Blacksmithing
	[NS.craftingProfessions[2]] = 164, -- Blacksmithing
	[164] = 164, -- Blacksmithing
	[2477] = 164, -- Blacksmithing
	[2476] = 164, -- Outland Blacksmithing
	[2475] = 164, -- Northrend Blacksmithing
	[2474] = 164, -- Cataclysm Blacksmithing
	[2473] = 164, -- Pandaria Blacksmithing
	[2472] = 164, -- Draenor Blacksmithing
	[2454] = 164, -- Legion Blacksmithing
	[2437] = 164, -- Kul Tiran Blacksmithing
	-- Enchanting
	[NS.craftingProfessions[3]] = 333, -- Enchanting
	[333] = 333, -- Enchanting
	[2494] = 333, -- Enchanting
	[2488] = 333, -- Draenor Enchanting
	[2493] = 333, -- Outland Enchanting
	[2492] = 333, -- Northrend Enchanting
	[2491] = 333, -- Cataclysm Enchanting
	[2489] = 333, -- Pandaria Enchanting
	[2487] = 333, -- Legion Enchanting
	[2486] = 333, -- Kul Tiran Enchanting
	-- Engineering
	[NS.craftingProfessions[4]] = 202, -- Engineering
	[202] = 202, -- Engineering
	[2506] = 202, -- Engineering
	[2505] = 202, -- Outland Engineering
	[2504] = 202, -- Northrend Engineering
	[2503] = 202, -- Cataclysm Engineering
	[2502] = 202, -- Pandaria Engineering
	[2501] = 202, -- Draenor Engineering
	[2500] = 202, -- Legion Engineering
	[2499] = 202, -- Kul Tiran Engineering
	-- Inscription
	[NS.craftingProfessions[5]] = 773, -- Inscription
	[773] = 773, -- Inscription
	[2514] = 773, -- Inscription
	[2513] = 773, -- Outland Inscription
	[2512] = 773, -- Northrend Inscription
	[2511] = 773, -- Cataclysm Inscription
	[2510] = 773, -- Pandaria Inscription
	[2509] = 773, -- Draenor Inscription
	[2508] = 773, -- Legion Inscription
	[2507] = 773, -- Kul Tiran Inscription
	-- Jewelcrafting
	[NS.craftingProfessions[6]] = 755, -- Jewelcrafting
	[755] = 755, -- Jewelcrafting
	[2524] = 755, -- Jewelcrafting
	[2523] = 755, -- Outland Jewelcrafting
	[2522] = 755, -- Northrend Jewelcrafting
	[2521] = 755, -- Cataclysm Jewelcrafting
	[2520] = 755, -- Pandaria Jewelcrafting
	[2519] = 755, -- Draenor Jewelcrafting
	[2518] = 755, -- Legion Jewelcrafting
	[2517] = 755, -- Kul Tiran Jewelcrafting
	-- Leatherworking
	[NS.craftingProfessions[7]] = 165, -- Leatherworking
	[165] = 165, -- Leatherworking
	[2532] = 165, -- Leatherworking
	[2531] = 165, -- Outland Leatherworking
	[2530] = 165, -- Northrend Leatherworking
	[2529] = 165, -- Cataclysm Leatherworking
	[2528] = 165, -- Pandaria Leatherworking
	[2527] = 165, -- Draenor Leatherworking
	[2526] = 165, -- Legion Leatherworking
	[2525] = 165, -- Kul Tiran Leatherworking
	-- Tailoring
	[NS.craftingProfessions[8]] = 197, -- Tailoring
	[197] = 197, -- Tailoring
	[2540] = 197, -- Tailoring
	[2539] = 197, -- Outland Tailoring
	[2538] = 197, -- Northrend Tailoring
	[2537] = 197, -- Cataclysm Tailoring
	[2536] = 197, -- Pandaria Tailoring
	[2535] = 197, -- Draenor Tailoring
	[2534] = 197, -- Legion Tailoring
	[2533] = 197, -- Kul Tiran Tailoring
	-- Cooking
	[NS.craftingProfessions[9]] = 185, -- Cooking
	[185] = 185, -- Cooking
	[2548] = 185, -- Cooking
	[981] = 185, -- Apprentice Cooking
	[982] = 185, -- Journeyman Cookbook
	[2547] = 185, -- Outland Cooking
	[2546] = 185, -- Northrend Cooking
	[2545] = 185, -- Cataclysm Cooking
	[2544] = 185, -- Pandaria Cooking
	[2542] = 185, -- Legion Cooking
	[2543] = 185, -- Draenor Cooking
	[2541] = 185, -- Kul Tiran Cooking
	-- Archaeology
	-- [794] = 794, -- Archaeology
	-- Fishing
	-- [356] = 356, -- Fishing
	-- [2592] = 356, -- Fishing
	-- [2591] = 356, -- Outland Fishing
	-- [2590] = 356, -- Northrend Fishing
	-- [2589] = 356, -- Cataclysm Fishing
	-- [2588] = 356, -- Pandaria Fishing
	-- [2587] = 356, -- Draenor Fishing
	-- [2586] = 356, -- Legion Fishing
	-- [2585] = 356, -- Kul Tiran Fishing
	-- Herbalism
	-- [182] = 182, -- Herbalism
	-- [2556] = 182, -- Herbalism
	-- [2555] = 182, -- Outland Herbalism
	-- [2554] = 182, -- Northrend Herbalism
	-- [2553] = 182, -- Cataclysm Herbalism
	-- [2552] = 182, -- Pandaria Herbalism
	-- [2551] = 182, -- Draenor Herbalism
	-- [2550] = 182, -- Legion Herbalism
	-- [2549] = 182, -- Kul Tiran Herbalism
	-- Mining
	-- [186] = 186, -- Mining
	-- [2572] = 186, -- Mining
	-- [2571] = 186, -- Outland Mining
	-- [2570] = 186, -- Northrend Mining
	-- [2569] = 186, -- Cataclysm Mining
	-- [2568] = 186, -- Pandaria Mining
	-- [2567] = 186, -- Draenor Mining
	-- [2566] = 186, -- Legion Mining
	-- [2565] = 186, -- Kul Tiran Mining
	-- Skinning
	-- [393] = 393, -- Skinning
	-- [2564] = 393, -- Skinning
	-- [2563] = 393, -- Outland Skinning
	-- [2562] = 393, -- Northrend Skinning
	-- [2560] = 393, -- Pandaria Skinning
	-- [2561] = 393, -- Cataclysm Skinning
	-- [2559] = 393, -- Draenor Skinning
	-- [2558] = 393, -- Legion Skinning
	-- [2557] = 393, -- Kul Tiran Skinning
};
NS.ridingSpells = { 90265,34091,34090,33391,33388 }; -- Spells: Master Riding, Artisan Riding, Expert Riding, Journeyman Riding, Apprentice Riding
for i = 1, #NS.ridingSpells do
	local spellName = GetSpellInfo( NS.ridingSpells[i] );
	if spellName then
		NS.ridingSpells[i] = spellName;
	else
		NS.Print( string.format( L["%d : Missing riding spell."], NS.ridingSpells[i] ) );
	end
end
NS.mountInfo = {
	-- As of 05/08/2020
	--[mountItemId] = { displayID, spellID }, -- creatureName -- itemName
	[90655] = { 45797, 132036 }, -- Thundering Ruby Cloud Serpent -- Reins of the Thundering Ruby Cloud Serpent
	[153594] = { 80513, 256123 }, -- Xiwyllag ATV -- Xiwyllag ATV
	[161134] = { 81816, 261437 }, -- Mecha-Mogul Mk2 -- Mecha-Mogul Mk2
	[163573] = { 81690, 260175 }, -- Goldenmane -- Goldenmane's Reins
	[163574] = { 81694, 260174 }, -- Terrified Pack Mule -- Chewed-On Reins of the Terrified Pack Mule
	[163575] = { 76706, 243795 }, -- Leaping Veinseeker -- Reins of a Tamed Bloodfeaster
	[163576] = { 75324, 237286 }, -- Dune Scavenger -- Captured Dune Scavenger
	[163131] = { 73253, 278803 }, -- Great Sea Ray -- Great Sea Ray
	[71718] = { 17011, 101573 }, -- Swift Shorestrider -- Swift Shorestrider
	[52200] = { 25279, 73313 }, -- Crimson Deathcharger -- Reins of the Crimson Deathcharger
	[34060] = { 22719, 44153 }, -- Flying Machine -- Flying Machine
	[79771] = { 40568, 113120 }, -- Feldrake -- Feldrake
	[128671] = { 64960, 191314 }, -- Minion of Grumpus -- Minion of Grumpus
	[41508] = { 25871, 55531 }, -- Mechano-Hog -- Mechano-Hog
	[82453] = { 42185, 120043 }, -- Jeweled Onyx Panther -- Jeweled Onyx Panther
	[83087] = { 42499, 121838 }, -- Ruby Panther -- Ruby Panther
	[72582] = { 38972, 102514 }, -- Corrupted Hippogryph -- Corrupted Hippogryph
	[72145] = { 16992, 102349 }, -- Swift Springstrider -- Swift Springstrider
	[54069] = { 31803, 74856 }, -- Blazing Hippogryph -- Blazing Hippogryph
	[49283] = { 21973, 42776 }, -- Spectral Tiger -- Reins of the Spectral Tiger
	[49285] = { 23656, 46197 }, -- X-51 Nether-Rocket -- X-51 Nether-Rocket
	[95416] = { 46686, 134359 }, -- Sky Golem -- Sky Golem
	[69228] = { 38048, 97581 }, -- Savage Raptor -- Savage Raptor
	[87250] = { 43637, 126507 }, -- Depleted-Kyparium Rocket -- Depleted-Kyparium Rocket
	[72575] = { 37204, 102488 }, -- White Riding Camel -- White Riding Camel
	[34061] = { 22720, 44151 }, -- Turbo--Charged Flying Machine -- Turbo-Charged Flying Machine
	[72146] = { 1961, 102350 }, -- Swift Lovebird -- Swift Lovebird
	[83088] = { 42502, 121837 }, -- Jade Panther -- Jade Panther
	[128311] = { 64426, 189364 }, -- Coalfist Gronnling -- Coalfist Gronnling
	[116794] = { 54114, 171851 }, -- Garn Nighthowl -- Garn Nighthowl
	[68008] = { 37231, 93623 }, -- Mottled Drake -- Mottled Drake
	[93671] = { 48014, 136505 }, -- Ghastly Charger -- Ghastly Charger's Skull
	[65891] = { 35750, 93326 }, -- Sandstone Drake -- Vial of the Sands
	[44413] = { 25870, 60424 }, -- Mekgineer's Chopper -- Mekgineer's Chopper
	[49286] = { 23647, 46199 }, -- X-51 Nether-Rocket X-TREME -- X-51 Nether-Rocket X-TREME
	[68825] = { 37800, 96503 }, -- Amani Dragonhawk -- Amani Dragonhawk
	[83089] = { 42501, 121839 }, -- Sunstone Panther -- Sunstone Panther
	[87251] = { 43638, 126508 }, -- Geosynchronous World Spinner -- Geosynchronous World Spinner
	[137686] = { 70099, 213209 }, -- Steelbound Devourer -- Steelbound Harness
	[44554] = { 28082, 61451 }, -- Flying Carpet -- Flying Carpet
	[83090] = { 42500, 121836 }, -- Sapphire Panther -- Sapphire Panther
	[54068] = { 31721, 74918 }, -- Wooly White Rhino -- Wooly White Rhino
	[49282] = {	25335, 51412 }, -- Big Battle Bear -- Big Battle Bear
	[49284] = { 21974, 42777 }, -- Swift Spectral Tiger -- Reins of the Swift Spectral Tiger
	[67151] = { 34955, 98718 }, -- Subdued Seahorse -- Reins of Poseidus
	[49290] = { 34655, 65917 }, -- Magic Rooster -- Magic Rooster Egg
};
NS.petInfo = {
	-- As of 05/08/2020
	--[companionPetItemId] = { speciesID, creatureID }, -- itemName
	--[[ not in game ]] [173296] = { 0000, 000000}, -- Rikki's Pith Helmet
	[170072] = { 2766, 155829}, -- Armored Vaultbot
	[167810] = { 2763, 151632}, -- Slimy Hermit Crab
	[167806] = { 2760, 151673}, -- Slimy Octopode
	[167809] = { 2762, 151651}, -- Slimy Darkhunter
	[167808] = { 2758, 151697}, -- Slimy Eel
	[167805] = { 2757, 151700}, -- Slimy Otter
	[167804] = { 2765, 151631}, -- Slimy Sea Slug
	[167807] = { 2761, 151696}, -- Slimy Fangtooth
	[166487] = { 2552, 148979 }, -- Leatherwing Screecher
	[152878] = { 2201, 139743 }, -- Enchanted Tiki Mask
	[151645] = { 2001, 117340 }, -- Model D1-BB-L3R
	[151269] = { 2002, 117341 }, -- Naxxy
	[151569] = { 2063, 124389 }, -- Sneaky Marmot
	[151633] = { 2065, 124594 }, -- Dig Rat
	[142448] = { 1984, 116080 }, -- Albino Buzzard
	[141532] = { 1943, 33975 }, -- Noblegarden Bunny
	[116403] = { 1516, 85846 }, -- Bush Chicken
	[116439] = { 1517, 85872 }, -- Blazing Cindercrawler
	[116756] = { 1518, 85994 }, -- Stout Alemental
	[89587] = { 381, 61086 }, -- Porcupette
	[116801] = { 1521, 86061 }, -- Cursed Birman
	[116804] = { 1523, 86067 }, -- Widget the Departed
	[8485] = { 40, 7385 }, -- Bombay Cat
	[10822] = { 56, 7543 }, -- Dark Whelpling
	[11027] = { 64, 7550 }, -- Wood Frog
	[70908] = { 319, 53884 }, -- Feline Familiar
	[23083] = { 128, 16701 }, -- Spirit of Summer
	[46398] = { 224, 34364 }, -- Calico Cat
	[101570] = { 1276, 72160 }, -- Moon Moon
	[117528] = { 1533, 86532 }, -- Lanticore Spawnling
	[118101] = { 1536, 86715 }, -- Zangar Spore
	[118105] = { 1539, 86718 }, -- Seaborne Spore
	[11026] = { 65, 7549 }, -- Tree Frog
	[33154] = { 162, 23909 }, -- Sinister Squashling
	[39896] = { 194, 32589 }, -- Tickbird Hatchling
	[130167] = { 1803, 99389 }, -- Thistleleaf Adventurer
	[90900] = { 1039, 67230 }, -- Imperial Moth
	[90902] = { 1040, 67233 }, -- Imperial Silkworm
	[85220] = { 650, 63365 }, -- Terrible Turnip
	[39899] = { 195, 32590 }, -- White Tickbird Hatchling
	[60216] = { 262, 43916 }, -- De-Weaponized Mechanical Companion
	[8486] = { 41, 7384 }, -- Cornish Rex Cat
	[8494] = { 49, 7391 }, -- Hyacinth Macaw
	[34535] = { 57, 7547 }, -- Azure Whelpling
	[20769] = { 114, 15429 }, -- Disgusting Oozeling
	[44721] = { 196, 32592 }, -- Proto-Drake Whelp
	[118675] = { 1563, 7546 }, -- Bronze Whelpling
	[118741] = { 1565, 88134 }, -- Mechanical Scorpid
	[118921] = { 1566, 88222 }, -- Everbloom Peachick
	[118923] = { 1567, 88225 }, -- Sentinel's Companion
	[46821] = { 229, 34724 }, -- Shimmering Wyrmling (Horde)
	[46820] = { 229, 34724 }, -- Shimmering Wyrmling (Alliance)
	[91003] = { 1061, 67319 }, -- Darkmoon Hatchling
	[91040] = { 1063, 67332 }, -- Darkmoon Eye
	[67274] = { 267, 46898 }, -- Enchanted Lantern
	[127704] = { 1577, 88514 }, -- Bloodthorn Hatchling
	[88148] = { 792, 65314 }, -- Jade Crane Chick
	[127703] = { 1588, 88415 }, -- Dusty Sporewing
	[8491] = { 42, 7383 }, -- Black Tabby Cat
	[8492] = { 50, 7387 }, -- Green Wing Macaw
	[8499] = { 58, 7544 }, -- Crimson Whelpling
	[8500] = { 68, 7553 }, -- Great Horned Owl
	[21277] = { 116, 15699 }, -- Tranquil Mechanical Yeti
	[29363] = { 136, 20408 }, -- Mana Wyrmling
	[44794] = { 200, 32791 }, -- Spring Rabbit
	[48112] = { 232, 35396 }, -- Darting Hatchling
	[127701] = { 1598, 88575 }, -- Glowing Sporebat
	[104202] = { 1343, 73668 }, -- Bonkers
	[29364] = { 137, 20472 }, -- Brown Rabbit
	[48114] = { 233, 35395 }, -- Deviate Hatchling
	[104317] = { 1349, 73741 }, -- Rotten Little Helper
	[21309] = { 117, 15710 }, -- Tiny Snowman
	[29901] = { 138, 21010 }, -- Blue Moth
	[48116] = { 234, 35400 }, -- Gundrak Hatchling
	[74610] = { 341, 55571 }, -- Lunar Lantern
	[29902] = { 139, 21009 }, -- Red Moth
	[48118] = { 235, 35387 }, -- Leaping Hatchling
	[74611] = { 342, 55574 }, -- Festival Lantern
	[8487] = { 43, 7382 }, -- Orange Tabby Cat
	[8498] = { 59, 7545 }, -- Emerald Whelpling
	[21308] = { 118, 15706 }, -- Winter Reindeer
	[48120] = { 236, 35399 }, -- Obsidian Hatchling
	[132519] = { 1886, 106210 }, -- Trigger
	[136921] = { 1886, 106210 }, -- Trigger
	[136924] = { 1889, 106278 }, -- Felbat Pup
	[44970] = { 205, 33194 }, -- Dun Morogh Cub
	[48122] = { 237, 35397 }, -- Ravasaur Hatchling
	[29953] = { 142, 21055 }, -- Golden Dragonhawk Hatchling
	[111660] = { 1387, 77221 }, -- Iron Starlette
	[29956] = { 143, 21064 }, -- Red Dragonhawk Hatchling
	[44973] = { 207, 33198 }, -- Durotar Scorpion
	[48126] = { 239, 35394 }, -- Razzashi Hatchling
	[8490] = { 44, 7380 }, -- Siamese Cat
	[8497] = { 72, 7560 }, -- Snowshoe Rabbit
	[138810] = { 1911, 109216 }, -- Sting Ray Pup
	[21305] = { 120, 15705 }, -- Winter's Little Helper
	[29957] = { 144, 21063 }, -- Silver Dragonhawk Hatchling
	[111402] = { 1403, 79410 }, -- Mechanical Axebeak
	[127748] = { 1662, 93143 }, -- Cinder Pup
	[127753] = { 1664, 93483 }, -- Nightmare Bell
	[112057] = { 1412, 80329 }, -- Lifelike Mechanical Frostboar
	[127749] = { 1672, 94623 }, -- Corrupted Nest Guardian
	[29960] = { 146, 21076 }, -- Firefly
	[44980] = { 210, 33219 }, -- Mulgore Hatchling
	[67275] = { 292, 50545 }, -- Magic Lamp
	[29904] = { 141, 21018 }, -- White Moth
	[67282] = { 293, 50722 }, -- Elementium Geode
	[29903] = { 140, 21008 }, -- Yellow Moth
	[118599] = { 1429, 83584 }, -- Autumnal Sproutling
	[87526] = { 844, 64899 }, -- Mechanical Pandaren Dragonling
	[127856] = { 1687, 94867 }, -- Left Shark
	[118595] = { 1432, 83594 }, -- Nightshade Sproutling
	[127868] = { 1688, 94927 }, -- Crusher
	[22235] = { 122, 16085 }, -- Peddlefeet
	[44984] = { 212, 33205 }, -- Ammen Vale Lashling
	[94573] = { 1205, 70154 }, -- Direhorn Runt
	[44971] = { 206, 33197 }, -- Tirisfal Batling
	[80008] = { 848, 59358 }, -- Darkmoon Rabbit
	[94935] = { 1209, 70260 }, -- Tiny White Carp
	[94190] = { 1185, 69848 }, -- Spectral Porcupette
	[94932] = { 1206, 70257 }, -- Tiny Red Carp
	[94934] = { 1208, 70259 }, -- Tiny Green Carp
	[44982] = { 213, 33227 }, -- Enchanted Broom
	[85447] = { 652, 63559 }, -- Tiny Goldfish
	[128533] = { 1699, 96403 }, -- Enchanted Cauldron
	[128534] = { 1700, 96404 }, -- Enchanted Torch
	[128535] = { 1701, 96405 }, -- Enchanted Pen
	[44965] = { 204, 33188 }, -- Teldrassil Sproutling
	[10360] = { 75, 7565 }, -- Black Kingsnake
	[82775] = { 846, 61883 }, -- Sapphire Cub
	[94574] = { 1200, 70083 }, -- Pygmy Direhorn
	[94595] = { 1201, 70098 }, -- Spawn of G'nathus
	[45002] = { 215, 33274 }, -- Mechanopeep
	[8489] = { 46, 7386 }, -- White Kitten
	[94933] = { 1207, 70258 }, -- Tiny Blue Carp
	[45606] = { 218, 33810 }, -- Sen'jin Fetish
	[128770] = { 1725, 97229 }, -- Grumpling
	[48124] = { 238, 35398 }, -- Razormaw Hatchling
	[130154] = { 1907, 108568 }, -- Pygmy Owl
	[72068] = { 311, 53283 }, -- Guardian Cub
	[46707] = { 166, 24753 }, -- Pint-Sized Pink Pachyderm
	[94903] = { 1204, 70082 }, -- Pierre
	[11825] = { 85, 9656 }, -- Pet Bombling
	[59597] = { 261, 43800 }, -- Personal World Destroyer
	[69239] = { 306, 52831 }, -- Winterspring Cub
	[82774] = { 845, 61877 }, -- Jade Owl
	[116064] = { 1478, 85527 }, -- Syd the Squid
	[8501] = { 67, 7555 }, -- Hawk Owl
	[10361] = { 77, 7562 }, -- Brown Snake
	[11826] = { 86, 9657 }, -- Lil' Smoky
	[8488] = { 45, 7381 }, -- Silver Tabby Cat
	[8495] = { 51, 7389 }, -- Senegal
	[29958] = { 145, 21056 }, -- Blue Dragonhawk Hatchling
	[10394] = { 70, 14421 }, -- Brown Prairie Dog
	[44822] = { 74, 7561 }, -- Albino Snake
	[117404] = { 115, 86445 }, -- Land Shark
	[4401] = { 39, 2671 }, -- Mechanical Squirrel
	[8496] = { 47, 7390 }, -- Cockatiel
	[10393] = { 55, 7395 }, -- Undercity Cockroach
	[118919] = { 1495, 85667 }, -- Ore Eater
	[10392] = { 78, 7567 }, -- Crimson Snake
	[127705] = { 1661, 93142 }, -- Lost Netherpup
	[21301] = { 119, 15698 }, -- Father Winter's Helper
	[127754] = { 1663, 93352 }, -- Periwinkle Calf
	[126926] = { 1665, 93808 }, -- Ghostshell Crab
	[11023] = { 52, 7394 }, -- Ancona Chicken
	[129216] = { 1764, 98236 }, -- Energized Manafiend
	[44974] = { 209, 33200 }, -- Elwynn Lamb
	[129218] = { 1765, 98238 }, -- Empyreal Manafiend
	[39898] = { 197, 32591 }, -- Cobra Hatchling
	[129217] = { 1766, 98237 }, -- Empowered Manafiend
	[116155] = { 1511, 85710 }, -- Lovebird Hatchling
	[100905] = { 1256, 71693 }, -- Rascal-Bot
	[15996] = { 95, 12419 }, -- Lifelike Toad
	[140323] = { 1930, 112167 }, -- Lagan
	[89368] = { 849, 66104 }, -- Chi-Ji Kite
	[10398] = { 83, 8376 }, -- Mechanical Chicken
	[88147] = { 820, 64232 }, -- Singing Cricket
	[126925] = { 1666, 93814 }, -- Blorp
	[141348] = { 1937, 113827 }, -- Wonderous Wisdomball
	[91031] = { 1062, 67329 }, -- Darkmoon Glowfly
	[140761] = { 1933, 112945 }, -- Nightmare Treant
	[94191] = { 1184, 69849 }, -- Stunted Direhorn
	[89367] = { 850, 66105 }, -- Yu'lon Kite
	[143756] = { 1998, 117180 }, -- Everliving Spore
	[143754] = { 1999, 117182 }, -- Cavern Moccasin
	[143755] = { 2000, 117184 }, -- Young Venomfang
	[146953] = { 2042, 120397 }, -- Scraps
};
NS.toyInfo = {
	-- As of 05/08/2020
	--[toyItemId] = { catNum, subCatNum }, -- itemName
	[168807] = { 6, 1 }, -- Wormhole Generator: Kul Tiras
	[168808] = { 6, 1 }, -- Wormhole Generator: Zandalar
	[166743] = { 12, 4 }, -- Blight Bomber
	[166744] = { 12, 4 }, -- Glaive Tosser
	[160740] = { 12, 4 }, -- Croak Crock
	[160751] = { 12, 4 }, -- Dance of the Dead
	[151652] = { 6, 1 }, -- Wormhole Generator: Argus
	[144393] = { 12, 4 }, -- Portable Yak Wash
	[142265] = { 12, 4 }, -- Big Red Raygun
	[122681] = { 12, 4 }, -- Sternfathom's Pet Journal
	[129956] = { 12, 4 }, -- Leather Love Seat
	[130157] = { 12, 4 }, -- Syxsehnz Rod
	[130169] = { 12, 4 }, -- Tournament Favor
	[130171] = { 12, 4 }, -- Cursed Orb
	[130191] = { 12, 4 }, -- Trapped Treasure Chest Kit
	[130214] = { 12, 4 }, -- Worn Doll
	[130232] = { 12, 4 }, -- Moonfeather Statue
	[130251] = { 6, 8 }, -- JewelCraft
	[130254] = { 12, 4 }, -- Chatterstone
	[132518] = { 6, 1 }, -- Blingtron's Circuit Design Tutorial
	[109167] = { 6, 1 }, -- Findle's Loot-A-Rang
	[112059] = { 6, 1 }, -- Wormhole Centrifuge
	[128536] = { 12, 4 }, -- Leylight Brazier
	[128807] = { 12, 4 }, -- Coin of Many Faces
	[87215] = { 6, 1 }, -- Wormhole Generator: Pandaria
	[88531] = { 6, 5 }, -- Lao Chin's Last Mug
	[108739] = { 12, 1 }, -- Pretty Draenor Pearl
	[40727] = { 6, 1 }, -- Gnomish Gravity Well
	[60854] = { 6, 1 }, -- Loot-A-Rang
	[134007] = { 12, 4 }, -- Eternal Black Diamond Ring
	[40768] = { 6, 1 }, -- MOLL-E
	[45984] = { 12, 4 }, -- Unusual Compass
	[48933] = { 6, 1 }, -- Wormhole Generator: Northrend
	[52201] = { 12, 4 }, -- Muradin's Favor
	[52253] = { 12, 4 }, -- Sylvanas' Music Box
	[30542] = { 6, 1 }, -- Dimensional Ripper - Area 52
	[30544] = { 6, 1 }, -- Ultrasafe Transporter: Toshley's Station
	[18984] = { 6, 1 }, -- Dimensional Ripper - Everlook
	[18986] = { 6, 1 }, -- Ultrasafe Transporter: Gadgetzan
	[23767] = { 6, 1 }, -- Crashin' Thrashin' Robot
	[108631] = { 12, 3 }, -- Crashin' Thrashin' Roller Controller
	[108633] = { 12, 3 }, -- Crashin' Thrashin' Cannon Controller
	[108634] = { 12, 3 }, -- Crashin' Thrashin' Mortar Controller
	[108635] = { 12, 3 }, -- Crashin' Thrashin' Killdozer Controller
	[17716] = { 6, 1 }, -- Snowmaster 9000
	[140363] = { 12, 4 }, -- Pocket Fel Spreader
	[1973] = { 12, 4 }, -- Orb of Deception
	[18660] = { 6, 1 }, -- World Enlarger
	[36862] = { 6, 8 }, -- Worn Troll Dice
	[36863] = { 6, 8 }, -- Decahedral Dwarven Dice
	[63269] = { 6, 8 }, -- Loaded Gnomish Dice
	[71628] = { 6, 8 }, -- Sack of Starfish
	[101571] = { 6, 8 }, -- Moonfang Shroud
	[105898] = { 6, 8 }, -- Moonfang's Paw
	[108745] = { 6, 1 }, -- Personal Hologram
	[109183] = { 6, 1 }, -- World Shrinker
	[116689] = { 12, 3 }, -- Pineapple Lounge Cushion
	[116690] = { 12, 3 }, -- Safari Lounge Cushion
	[116691] = { 12, 3 }, -- Zhevra Lounge Cushion
	[116692] = { 12, 3 }, -- Fuzzy Green Lounge Cushion
	[118427] = { 12, 4 }, -- Autographed Hearthstone Card
	[119210] = { 6, 8 }, -- Hearthstone Board
	[119212] = { 6, 8 }, -- Winning Hand
	[127695] = { 12, 4 }, -- Spirit Wand
	[127707] = { 12, 4 }, -- Indestructible Bone
	[128310] = { 12, 1 }, -- Burning Blade
	[128794] = { 12, 4 }, -- Sack of Spectral Spiders
	[129211] = { 6, 8 }, -- Steamy Romance Novel Kit
	[129958] = { 10, 11 }, -- Leather Pet Leash
	[129960] = { 10, 11 }, -- Leather Pet Bed
	[129961] = { 10, 11 }, -- Flaming Hoop
};
NS.mountItemIds = {};
NS.petItemIds = { 82800 };
NS.toyItemIds = {};
NS.appearanceItemIds = {};
NS.recipeItemIds = {};
for k, v in pairs( NS.mountInfo ) do
	NS.mountItemIds[#NS.mountItemIds + 1] = k;
end
for k, v in pairs( NS.petInfo ) do
	NS.petItemIds[#NS.petItemIds + 1] = k;
end
for k, v in pairs( NS.toyInfo ) do
	NS.toyItemIds[#NS.toyItemIds + 1] = k;
end
for k, v in pairs( NS.recipeInfo ) do
	NS.recipeItemIds[#NS.recipeItemIds + 1] = k;
end
NS.TRANSMOGRIFY_FONT_COLOR_CODE = "|c" .. TRANSMOGRIFY_FONT_COLOR:GenerateHexColor();
if not ITEM_QUALITY_COLORS[-1] then
	ITEM_QUALITY_COLORS[-1] = { hex="|cff9d9d9d", r=0, g=0, b=0 };
end
NS.SELECT_AN_AUCTION = function()
	return string.format( L["Select an auction to buy or click \"Buy All\""] .. ( NS.mode == "APPEARANCES" and "\n" .. L["%sEach result is the lowest buyout auction for an|r %s"] or "" ), HIGHLIGHT_FONT_COLOR_CODE, NS.modeColorCode .. ( NS.shopAppearancesBy == "appearance" and L["Appearance"] or L["Appearance Source"] ) .. FONT_COLOR_CODE_CLOSE );
end
--------------------------------------------------------------------------------------------------------------------------------------------
-- Record enabled addons (used for Auctioneer check)
--------------------------------------------------------------------------------------------------------------------------------------------
local addonEnabled = {};
local character = UnitName( "player" );
for i = 1, GetNumAddOns() do
	local name,_,_,loadable = GetAddOnInfo( i );
	if loadable and GetAddOnEnableState( character, i ) > 0 then
		addonEnabled[name] = true;
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
-- Default SavedVariables/PerCharacter & Upgrade
--------------------------------------------------------------------------------------------------------------------------------------------
NS.DefaultSavedVariables = function()
	return {
		["version"] = NS.version,
		["getAllScan"] = {},
		["flyoutPanelOpen"] = true,
		["undressCharacter"] = true,
		["live"] = false,
		["auctionsWonReminder"] = true,
		["maxItemPriceCopper"] = { [NS.modes[1]] = 0, [NS.modes[2]] = 0, [NS.modes[3]] = 0, [NS.modes[4]] = 0, [NS.modes[5]] = 0 },
		["tsmItemValueSource"] = "",
		["modeFilters"] = { [NS.modes[1]] = {}, [NS.modes[2]] = {}, [NS.modes[3]] = {}, [NS.modes[4]] = {}, [NS.modes[5]] = {} },
		["autoselectAfterAuctionUnavailable"] = true,
	};
end
--
NS.DefaultSavedVariablesPerCharacter = function()
	return {
		["version"] = NS.version,
	};
end
--
NS.Upgrade = function()
	local vars = NS.DefaultSavedVariables();
	local version = NS.db["version"];
	-- 1.05
	if version < 1.05 then
		NS.db["tsmItemValueSource"] = vars["tsmItemValueSource"]; -- New db variable
	end
	-- 2.0
	if version < 2.0 then
		wipe( NS.db["getAllScan"] ); -- New data structure and information requirements
	end
	-- 2.07
	if version < 2.07 then
		NS.db["autoselectAfterAuctionUnavailable"] = vars["autoselectAfterAuctionUnavailable"]; -- New db variable
	end
	-- 3.0
	if version < 3.0 then
		wipe( NS.db["getAllScan"] ); -- New itemType "recipe"
		-- New mode settings, RECIPES (5)
		NS.db["maxItemPriceCopper"][NS.modes[5]] = 0;
		NS.db["modeFilters"][NS.modes[5]] = {};
	end
	-- 3.02 / 4.0
	if version < 4.0 then
		wipe( NS.db["getAllScan"] ); -- Fixed bad recipe level table error in 3.02 and reset in 4.0 for massive AH changes in 8.3
	end
	--
	NS.db["version"] = NS.version;
end
--
NS.UpgradePerCharacter = function()
	local varspercharacter = NS.DefaultSavedVariablesPerCharacter();
	local version = NS.dbpc["version"];
	-- X.xx
	--if version < X.xx then
		-- Do upgrade
	--end
	--
	NS.dbpc["version"] = NS.version;
end
--------------------------------------------------------------------------------------------------------------------------------------------
-- AuctionHouseFrameCollectionShopTab / DressUpModel
--------------------------------------------------------------------------------------------------------------------------------------------
NS.AuctionHouseFrame_SetDisplayMode = function( self, displayMode ) -- AuctionHouseFrame.SetDisplayMode
	if displayMode == AuctionHouseFrameDisplayMode.CollectionShop then
		NS.UpdateTitleText(); -- Clears the "Browse Auctions" Blizzard title text
		NS.linkLevel = UnitLevel( "player" );
		CollectionShopEventsFrame:RegisterEvent( "PLAYER_SPECIALIZATION_CHANGED" );
		CollectionShopEventsFrame:RegisterEvent( "INSPECT_READY" );
		CollectionShopEventsFrame:RegisterEvent( "UI_ERROR_MESSAGE" );
		NotifyInspect( "player" );
		-- Incompatible with Auctioneer
		if addonEnabled["Auc-Advanced"] then
			NS.Print( RED_FONT_COLOR_CODE .. L["Warning: This addon is incompatible with Auctioneer."] .. FONT_COLOR_CODE_CLOSE );
		end
	elseif AuctionFrameCollectionShop:IsShown() then
		AuctionFrameCollectionShop:Hide();
	end
end
--
NS.IsTabShown = function()
	if AuctionFrameCollectionShop and AuctionHouseFrame:IsShown() and PanelTemplates_GetSelectedTab( AuctionHouseFrame ) == NS.AuctionHouseFrameTab:GetID() then
		return true;
	else
		return false;
	end
end
--
NS.DressUpFrameCancelButton_OnClick = function()
	if AuctionFrameCollectionShop and AuctionFrameCollectionShop:IsShown() then
		AuctionFrameCollectionShop_FlyoutPanel:Reset();
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
-- AuctionFrameCollectionShop
--------------------------------------------------------------------------------------------------------------------------------------------
NS.Reset = function( filterOnClick )
	CollectionShopEventsFrame:UnregisterEvent( "CHAT_MSG_SYSTEM" );
	NS.scan:Reset(); -- Also Unregisters auction house events
	wipe( NS.auction.data.live.itemIds );
	wipe( NS.auction.data.live.appearanceSources );
	wipe( NS.auction.data.groups );
	NS.disableFlyoutChecks = false;
	NS.buyAll = false;
	if AuctionHouseFrame and not NS.IsTabShown() then -- Stop monitoring spec and UI errors, unset mode, and reset buyout tracking when tab is changed or Auction House closed
		CollectionShopEventsFrame:UnregisterEvent( "PLAYER_SPECIALIZATION_CHANGED" );
		CollectionShopEventsFrame:UnregisterEvent( "INSPECT_READY" );
		CollectionShopEventsFrame:UnregisterEvent( "UI_ERROR_MESSAGE" );
		NS.SetMode( nil, "noReset" );
		if NS.numAuctionsWon > 0 and NS.db["auctionsWonReminder"] then
			NS.Print( RED_FONT_COLOR_CODE .. string.format( L["Remember when leaving %s to equip or use auctions won to update your Collections for future Shop results."], NS.title ) .. FONT_COLOR_CODE_CLOSE );
		end
		NS.numAuctionsWon = 0;
		NS.copperAuctionsWon = 0;
		wipe( NS.auctionsWon );
		wipe( NS.mountCollection );
		wipe( NS.petCollection );
		wipe( NS.toyCollection );
		wipe( NS.recipeCollection );
		if NS.options.MainFrame:IsShown() then
			NS.options.MainFrame:Hide(); -- Close options frame, prevents errors on Buyouts tab
		end
	end
	if NS.mode then -- Max Item Price
		AuctionFrameCollectionShop_MaxItemPriceFrameText:SetText( string.format( L["Max Item Price: %s"], ( NS.db["maxItemPriceCopper"][NS.mode] == 0 and L["None"] or NS.MoneyToString( NS.db["maxItemPriceCopper"][NS.mode] ) ) ) );
		AuctionFrameCollectionShop_MaxItemPriceFrame:Show();
	else
		AuctionFrameCollectionShop_MaxItemPriceFrame:Hide();
	end
	if NS.mode == "APPEARANCES" or NS.mode == "RECIPES" then -- Undress Character
		AuctionFrameCollectionShop_UndressCharacterCheckButton:SetChecked( NS.db["undressCharacter"] );
		AuctionFrameCollectionShop_UndressCharacterCheckButton:Show();
	else
		AuctionFrameCollectionShop_UndressCharacterCheckButton:Hide();
	end
	if NS.adjustScrollFrame then
		AuctionFrameCollectionShop_ScrollFrame:Adjust(); -- Must go before sort buttons to set NS.isPctItemValue
	end
	if NS.mode then
		NS.AuctionSortButtons_Action( "Show" );
		NS.AuctionSortButtons_Action( "Arrow:Hide" );
		NS.AuctionSortButtons_Action( "Enable" );
		if NS.isPctItemValue then
			AuctionFrameCollectionShop_PctItemValueSortButton:Click();
		else
			AuctionFrameCollectionShop_ItemPriceSortButton:Click();
		end
	else
		NS.AuctionSortButtons_Action( "Hide" );
	end
	AuctionFrameCollectionShop_ModeSelectionButton:Reset();
	AuctionFrameCollectionShop_ScrollFrame:Reset(); -- Includes: UpdateTitleText()
	if NS.mode then -- Mode Message or Mode Selection
		AuctionFrameCollectionShop_ModeSelectionFrame:Hide();
		NS.JumbotronFrame_Message( ( NS.db["live"] or NS.db["getAllScan"][NS.realmName] ) and L["Ready"] or L["Auction House data required"] );
		NS.StatusFrame_Message( ( not NS.db["live"] and not NS.db["getAllScan"][NS.realmName] ) and L["Press \"Scan\" to perform a GetAll scan"] or L["Press \"Shop\""] );
	else
		AuctionFrameCollectionShop_JumbotronFrame:Hide();
		AuctionFrameCollectionShop_ModeSelectionFrame:Show();
		NS.StatusFrame_Message( L["Choose Collection Mode"] );
	end
	NS.UpdateTimeSinceLastScan();
	AuctionFrameCollectionShop_LiveCheckButton:Enable();
	AuctionFrameCollectionShop_LiveCheckButton:SetChecked( NS.db["live"] );
	--[[ Temporarily disabled ]] AuctionFrameCollectionShop_LiveCheckButton:Hide();
	AuctionFrameCollectionShop_ScanButton:Reset();
	AuctionFrameCollectionShop_ShopButton:Reset();
	AuctionFrameCollectionShop_BuyAllButton:Reset();
	AuctionFrameCollectionShop_FlyoutPanel:Reset( filterOnClick );
	HideUIPanel( DressUpFrame );
end
--
NS.AuctionSortButtons_Action = function( action )
	local buttons = { "Name", "Lvl", "Category", "ItemPrice" };
	if NS.isPctItemValue then
		buttons[#buttons + 1] = "PctItemValue"; -- % Item Value
	end
	for i = 1, #buttons do
		local button = _G["AuctionFrameCollectionShop_" .. buttons[i] .. "SortButton"];
		local arrow = _G[button:GetName() .. "Arrow"];
		if action == "Arrow:Hide" then
			arrow:Hide();
		elseif action == "Disable" then
			button:Disable();
		elseif action == "Enable" then
			if arrow:IsShown() then
				button:Enable();
			else
				button:Enable();
				arrow:Hide();
			end
		elseif action == "Hide" then
			button:Hide();
		elseif action == "Show" then
			button:Show();
		end
	end
end
--
NS.JumbotronFrame_Message = function( text )
	AuctionFrameCollectionShop_JumbotronFrameText:SetText( ( text and ( NS.modeColorCode .. NS.modeName .. FONT_COLOR_CODE_CLOSE .. ": " .. text ) or nil ) );
	AuctionFrameCollectionShop_JumbotronFrame:Show();
end
--
NS.SetMode = function( mode, noReset )
	NS.mode = mode and NS.modes[mode] or nil;
	NS.modeName = mode and NS.modeNames[mode] or nil;
	NS.modeColorCode = mode and NS.modeColorCodes[mode] or nil;
	wipe( NS.modeFilters );
	wipe( NS.modeFiltersFlyout );
	-- filter: key(1), string(2), default(3), info(4)
	-- modeFilters: qualities(1), categories(2), collected(3), petLevels(4) or itemRequiresLevels(4), misc(5), craftedByProfession(6)
	local poor = { ITEM_QUALITY0_DESC, ITEM_QUALITY_COLORS[0].hex .. ITEM_QUALITY0_DESC .. FONT_COLOR_CODE_CLOSE, true, 0 };
	local common = { ITEM_QUALITY1_DESC, ITEM_QUALITY_COLORS[1].hex .. ITEM_QUALITY1_DESC .. FONT_COLOR_CODE_CLOSE, true, 1 };
	local uncommon = { ITEM_QUALITY2_DESC, ITEM_QUALITY_COLORS[2].hex .. ITEM_QUALITY2_DESC .. FONT_COLOR_CODE_CLOSE, true, 2 };
	local rare = { ITEM_QUALITY3_DESC, ITEM_QUALITY_COLORS[3].hex .. ITEM_QUALITY3_DESC .. FONT_COLOR_CODE_CLOSE, true, 3 };
	local epic = { ITEM_QUALITY4_DESC, ITEM_QUALITY_COLORS[4].hex .. ITEM_QUALITY4_DESC .. FONT_COLOR_CODE_CLOSE, true, 4 };
	local notCollected = NS.mode and { "notCollected", NS.modeColorCode .. L["Not Collected"] .. FONT_COLOR_CODE_CLOSE, true } or nil;
	local collected = { "collected", RED_FONT_COLOR_CODE .. L["Collected"] .. FONT_COLOR_CODE_CLOSE, false };
	local requiresLevel = { "requiresLevel", RED_FONT_COLOR_CODE .. L["Requires Level"] .. FONT_COLOR_CODE_CLOSE, false };
	local requiresProfession = { "requiresProfession", RED_FONT_COLOR_CODE .. L["Requires Profession"] .. FONT_COLOR_CODE_CLOSE, false };
	local craftedByProfession = { "craftedByProfession", "|cffaf8356" .. L["Crafted by a Profession"] .. FONT_COLOR_CODE_CLOSE, true };
	if NS.mode == "MOUNTS" then
		NS.modeFilters = {
			{ rare, epic },
			{},
			{ notCollected, collected },
			{},
			{
				requiresLevel,
				requiresProfession,
				{ "requiresRidingSkill", RED_FONT_COLOR_CODE .. L["Requires Riding Skill"] .. FONT_COLOR_CODE_CLOSE, false },
			},
			{ craftedByProfession },
		};
		AuctionFrameCollectionShop_FlyoutPanel_ToggleCategories:Disable(); -- Mounts have no categories
	elseif NS.mode == "PETS" then
		NS.modeFilters = {
			{ common, uncommon, rare, epic },
			( function()
				local categories,categoryName = {};
				for i = 1, #AuctionCategories[10].subCategories do
					categoryName = AuctionCategories[10].subCategories[i].name;
					categories[#categories + 1] = { categoryName, ( i == 11 and ( L["Include"] .. " " ) or "" ) .. categoryName, true }; -- Pet Family (or Include Companion Pets)
				end
				return categories;
			end )(),
			{
				notCollected,
				{ "collected", NORMAL_FONT_COLOR_CODE .. L["Collected (1-2/3)"] .. FONT_COLOR_CODE_CLOSE, false },
				{ "collectedMax", RED_FONT_COLOR_CODE .. L["Collected (3/3)"] .. FONT_COLOR_CODE_CLOSE, false },
			},
			{
				{ "petLevels1", L["Level 1-10"], true },
				{ "petLevels2", L["Level 11-15"], true },
				{ "petLevels3", L["Level 16-20"], true },
				{ "petLevels4", L["Level 21-24"], true },
				{ "petLevels5", L["Level 25"], true },
			},
			{
				{ "groupBySpecies", L["Group By Species"], true },
			},
			{ craftedByProfession },
		};
	elseif NS.mode == "TOYS" then
		NS.modeFilters = {
			{ common, uncommon, rare, epic },
			( function()
				local cnums = {
					{ 6, 1 }, -- Consumables > Explosives and Devices
					{ 6, 5 }, -- Consumables > Food & Drink
					{ 6, 8 }, -- Consumables > Other
					{ 12, 1 }, -- Miscellaneous > Junk
					{ 10, 11 }, -- Battle Pets > Companion Pets
					{ 12, 3 }, -- Miscellaneous > Holiday
					{ 12, 4 }, -- Miscellaneous > Other
				};
				local categories,categoryName = {};
				for i = 1, #cnums do
					categoryName = AuctionCategories[cnums[i][1]].subCategories[cnums[i][2]].name .. " (" .. AuctionCategories[cnums[i][1]].name .. ")";
					categories[#categories + 1] = { categoryName, categoryName, true, { cnums[i][1], cnums[i][2] } };
				end
				return categories;
			end )(),
			{ notCollected, collected },
			{},
			{ requiresLevel, requiresProfession },
			{ craftedByProfession },
		};
	elseif NS.mode == "APPEARANCES" then
		NS.modeFilters = {
			{ uncommon, rare, epic },
			( function()
				local auctionCategoryIndexes = {};
				-- Weapons: One-Handed, Two-Handed, Ranged
				for i = 1, 3 do
					for x = 1, #AuctionCategories[1].subCategories[i].subCategories do
						auctionCategoryIndexes[AuctionCategories[1].subCategories[i].subCategories[x].name] = { 1, i, x };
					end
				end
				-- Armor: Plate, Mail, Leather, Cloth ------ 1 = Plate, 2 = Mail, 3 = Leather, 4 = Cloth
				local classArmorIndexes = {
					["WARRIOR"] = 1,
					["DEATHKNIGHT"] = 1,
					["PALADIN"] = 1,
					["MONK"] = 3,
					["PRIEST"] = 4,
					["SHAMAN"] = 2,
					["DRUID"] = 3,
					["ROGUE"] = 3,
					["MAGE"] = 4,
					["WARLOCK"] = 4,
					["HUNTER"] = 2,
					["DEMONHUNTER"] = 3,
				};
				local classArmorIndex = classArmorIndexes[select( 2, UnitClass( "player" ) )];
				for i = 1, 4 do
					if i == classArmorIndex then -- Just one
						for x = 1, #AuctionCategories[2].subCategories[i].subCategories do
							auctionCategoryIndexes[AuctionCategories[2].subCategories[i].subCategories[x].name] = { 2, i, x };
						end
					end
				end
				-- Armor: Miscellaneous -> Cloak, Held In Off-hand, Shields, Shirt
				auctionCategoryIndexes[BACKSLOT] = { 2, 5, 2 }; -- Appearances calls this "Back" - AuctionCategories[2].subCategories[5].subCategories[2].name
				auctionCategoryIndexes[AuctionCategories[2].subCategories[5].subCategories[5].name] = { 2, 5, 5 };
				auctionCategoryIndexes[AuctionCategories[2].subCategories[5].subCategories[6].name] = { 2, 5, 6 };
				auctionCategoryIndexes[AuctionCategories[2].subCategories[5].subCategories[7].name] = { 2, 5, 7 };
				-- Categories
				local categories,categoryName = {};
				for i = 1, NS.NUM_TRANSMOG_COLLECTION_TYPES do
					categoryName = C_TransmogCollection.GetCategoryInfo( i );
					NS.appearanceCollection.categoryNames[i] = categoryName or false;
					if categoryName and categoryName ~= TABARDSLOT and auctionCategoryIndexes[categoryName] then
						categories[#categories + 1] = { categoryName, categoryName, true, auctionCategoryIndexes[categoryName] };
					end
				end
				return categories;
			end )(),
			{
				notCollected,
				{ "collectedUnknownSources", NORMAL_FONT_COLOR_CODE .. L["Collected - Unknown Sources"] .. FONT_COLOR_CODE_CLOSE, false },
				{ "collectedKnownSources", RED_FONT_COLOR_CODE .. L["Collected - Known Sources"] .. FONT_COLOR_CODE_CLOSE, false },
			},
			{
				{ "itemRequiresLevels1", L["Level 1-60"], true },		-- Classic
				{ "itemRequiresLevels2", L["Level 61-70"], true },		-- TBC
				{ "itemRequiresLevels3", L["Level 71-80"], true },		-- WotLK
				{ "itemRequiresLevels4", L["Level 81-85"], true },		-- Cata
				{ "itemRequiresLevels5", L["Level 86-90"], true },		-- MoP
				{ "itemRequiresLevels6", L["Level 91-100"], true },		-- WoD
				{ "itemRequiresLevels7", L["Level 101-110"], true },	-- Legion
				{ "itemRequiresLevels8", L["Level 111-120"], true },	-- Battle
			},
			{
				requiresLevel,
				requiresProfession,
				{ "nonsetItems", L["Non-set Items"], true },
			},
			{ craftedByProfession },
		};
	elseif NS.mode == "RECIPES" then
		-- Record Player Professions
		wipe( NS.playerProfessions );
		local prof1, prof2, archaeology, fishing, cooking = GetProfessions();
		local professions = { prof1, prof2, cooking };
		for i = 1, 3 do
			if professions[i] then -- nil if player doesn't have cooking or both primary professions
				local _,_,skillLevel,_,_,_,skillLine = GetProfessionInfo( professions[i] ); -- returns base skill id rather than expac specific
				NS.playerProfessions[skillLine] = skillLevel; -- skillLevel not used since professions were splintered into expacs in BfA
			end
		end
		--
		NS.modeFilters = {
			{ common, uncommon, rare, epic },
			( function()
				local categories,categoryName,skillLine = {};
				for i = 1, #AuctionCategories[9].subCategories do
					categoryName = AuctionCategories[9].subCategories[i].name;
					skillLine = NS.skills[categoryName]; -- This will exclude the last three auction categories: First Aid, Fishing, and Book
					if skillLine and NS.playerProfessions[skillLine] then -- Only include profession categories the player has learned
						categories[#categories + 1] = { categoryName, categoryName, true, i }; -- Profession name and auction subcategory index
					end
				end
				return categories;
			end )(),
			{ notCollected, collected },
			{},
			{
				requiresLevel,
				requiresProfession,
				{ "requiresProfessionSpec", RED_FONT_COLOR_CODE .. L["Requires Profession Specialization"] .. FONT_COLOR_CODE_CLOSE, false },
			},
			{ craftedByProfession },
		};
		-- Modify misc(5) requiresProfession(2) string(2) because recipes will only show up for learned professions anyways
		NS.modeFilters[5][2][2] = RED_FONT_COLOR_CODE .. L["Requires Profession Level"] .. FONT_COLOR_CODE_CLOSE;
	end
	-- Combine Filters for Flyout
	for i = 1, #NS.modeFilters do
		for x = 1, #NS.modeFilters[i] do
			NS.modeFiltersFlyout[#NS.modeFiltersFlyout + 1] = NS.modeFilters[i][x];
			if NS.db["modeFilters"][NS.mode][NS.modeFilters[i][x][1]] == nil then
				NS.db["modeFilters"][NS.mode][NS.modeFilters[i][x][1]] = NS.modeFilters[i][x][3]; -- default
			end
		end
	end
	-- Toggle Categories Button
	if NS.mode == "PETS" then
		AuctionFrameCollectionShop_FlyoutPanel_ToggleCategories:SetText( L["Toggle Pet Families"] );
	else
		AuctionFrameCollectionShop_FlyoutPanel_ToggleCategories:SetText( L["Toggle Categories"] );
	end
	-- Update and/or Reset
	if NS.mode == "MOUNTS" then
		if not next( NS.mountCollection ) then
			NS.UpdateMountCollection();
		else
			NS.Reset();
		end
	elseif NS.mode == "PETS" then -- petCollection updated during ImportShopData
		NS.Reset();
	elseif NS.mode == "TOYS" then
		if not next( NS.toyCollection ) then
			NS.UpdateToyCollection();
		else
			NS.Reset();
		end
	elseif NS.mode == "APPEARANCES" then -- appearanceCollection is updated just before ImportShopData
		NS.Reset();
	elseif NS.mode == "RECIPES" then
		if not next( NS.recipeCollection ) then
			NS.UpdateRecipeCollection();
		else
			NS.Reset();
		end
	elseif not NS.mode and not noReset then
		NS.Reset();
	end
end
--
NS.StatusFrame_Message = function( text )
	AuctionFrameCollectionShop_DialogFrame_StatusFrameText:SetText( text );
	AuctionFrameCollectionShop_DialogFrame_BuyoutFrame:Hide();
	AuctionFrameCollectionShop_DialogFrame_StatusFrame:Show();
end
--
NS.BuyoutFrame_Activate = function()
	AuctionFrameCollectionShop_DialogFrame_BuyoutFrame_BuyoutButton:Enable();
	AuctionFrameCollectionShop_DialogFrame_BuyoutFrame_CancelButton:Enable();
	AuctionFrameCollectionShop_DialogFrame_StatusFrame:Hide();
	AuctionFrameCollectionShop_DialogFrame_BuyoutFrame:Show();
end
--
NS.UpdateTimeSinceLastScan = function()
	local timeSinceLastGetAllScan = NS.db["getAllScan"][NS.realmName] and ( time() - NS.db["getAllScan"][NS.realmName]["time"] ) or nil;
	local timeSinceLastGetAllScanText = ( function()
		if NS.db["live"] then
			return GREEN_FONT_COLOR_CODE .. L["Live"] .. FONT_COLOR_CODE_CLOSE;
		elseif type( timeSinceLastGetAllScan ) ~= "number" or timeSinceLastGetAllScan > 1200 then -- 1200 sec = 20 min
			return RED_FONT_COLOR_CODE .. ( timeSinceLastGetAllScan and NS.SecondsToStrTime( timeSinceLastGetAllScan ) or L["Never"] ) .. FONT_COLOR_CODE_CLOSE;
		else
			return HIGHLIGHT_FONT_COLOR_CODE .. NS.SecondsToStrTime( timeSinceLastGetAllScan ) .. FONT_COLOR_CODE_CLOSE;
		end
	end )();
	AuctionFrameCollectionShop_TimeSinceLastGetAllScanFrameText:SetText( string.format( L["Time since last scan: %s"], timeSinceLastGetAllScanText ) );
end
--
NS.UpdateTitleText = function()
	local text = {};
	if #NS.auction.data.groups > 0 then
		text[#text + 1] = NS.FormatNum( #NS.auction.data.groups ) .. " " .. NS.modeColorCode .. ( ( NS.mode == "APPEARANCES" and NS.shopAppearancesBy == "source" ) and L["Appearance Sources"] or NS.modeName ) .. FONT_COLOR_CODE_CLOSE;
	end
	if NS.numAuctionsWon > 0 then
		text[#text + 1] = NS.numAuctionsWon .. " " .. GREEN_FONT_COLOR_CODE .. ( NS.numAuctionsWon == 1 and L["Buyout"] or L["Buyouts"] ) .. FONT_COLOR_CODE_CLOSE .. " (" .. NS.MoneyToString( NS.copperAuctionsWon, HIGHLIGHT_FONT_COLOR_CODE ) .. ")";
	end
	AuctionHouseFrameTitleText:SetText( "" ); -- This is the Blizzard AH title
	AuctionFrameCollectionShop_TitleText:SetText( table.concat( text, HIGHLIGHT_FONT_COLOR_CODE .. "   " .. FONT_COLOR_CODE_CLOSE ) );
	AuctionFrameCollectionShop_BuyoutsMailButton:SetText( NS.numAuctionsWon );
	if not NS.mode or NS.numAuctionsWon == 0 then
		AuctionFrameCollectionShop_BuyoutsMailButton:Hide();
	else
		AuctionFrameCollectionShop_BuyoutsMailButton:Show();
	end
end
--
NS.AuctionSortButton_OnClick = function( button, itemInfoKey )
	-- Update Arrows
	local arrow = _G[button:GetName() .. "Arrow"];
	local l,_,_,_,r,t,_,b = arrow:GetTexCoord();
	local direction = ( function() if t == 0 and b == 1.0 then return "down" else return "up" end end )();
	local order;
	--
	if arrow:IsShown() and direction == "up" or not arrow:IsShown() then
		t = 0;
		b = 1.0;
		order = "ASC"; -- Arrow facing downward
	else
		t = 1.0;
		b = 0;
		order = "DESC"; -- Arrow facing upward
	end
	--
	NS.AuctionSortButtons_Action( "Arrow:Hide" );
	arrow:SetTexCoord( 0, 0.5625, t, b );
	arrow:Show();
	-- Return sorted data to frame
	NS.auction.data.sortKey = itemInfoKey;
	NS.auction.data.sortOrder = order;
	NS.AuctionDataGroups_Sort();
	if NS.buyAll then
		NS.AuctionGroup_OnClick( 1 );
	else
		AuctionFrameCollectionShop_ScrollFrame:Update();
	end
end
--
NS.AuctionGroup_OnClick = function( groupKey )
	if NS.scan.status == "ready" or NS.scan.status == "selected" then
		-- SELECT
		local auction = CopyTable( NS.auction.data.groups[groupKey][5][1] ); -- auctions(5), first auction(1)
		NS.scan.query.remaining = 1;
		NS.scan.query.auction = auction;
		NS.scan.query.auction.groupKey = groupKey;
		NS.scan.query.searchString = NS.auction.data.groups[groupKey][2]; -- name(2)
		NS.scan.query.rarity = auction[4]; -- quality/rarity(4)
		NS.scan.query.exactMatch = true;
		NS.scan.query.itemClassFilters = nil;
		if NS.buyAll and groupKey == 1 then
			AuctionFrameCollectionShop_ScrollFrame:SetVerticalScroll( 0 ); -- Scroll to top when first group is selected during Buy All
		end
		AuctionFrameCollectionShop_ScrollFrame:Update();
		NS.scan:Start( "SELECT" );
	elseif NS.scan.status == "buying" then
		NS.Print( L["Selection ignored, buying"] );
	else
		NS.Print( L["Selection ignored, scanning"] );
	end
end
--
NS.AuctionGroup_AuctionMissing = function( groupKey, OnMessageOnly )
	PlaySound( 1427 ); -- SPELL_Shadow_Fizzle
	local itemPrice = NS.auction.data.groups[groupKey][5][1][1]; -- auctions(5), first auction(1), itemPrice(1)
	local itemLink = NS.auction.data.groups[groupKey][5][1][2]; -- auctions(5), first auction(1), itemLink(2)
	local itemId = NS.auction.data.groups[groupKey][5][1][6]; -- auctions(5), first auction(1), itemId(6)
	local groupAuctions = NS.auction.data.groups[groupKey][5]; -- auctions(5)
	local auction,removed,RemoveAuctions,RemovalComplete;
	--
	RemoveAuctions = function()
		if not NS.db["live"] then
			local scanAuctions = NS.db["getAllScan"][NS.realmName]["data"]["itemIds"][itemId];
			-- Remove auctions(5) that match by itemPrice(1) and itemLink(2) from scan data
			auction = 1;
			while auction <= #scanAuctions do
				if NS.scan.status ~= "scanning" and NS.scan.status ~= "buying" then return end -- Check for Reset
				--
				if scanAuctions[auction][1] == itemPrice and ( itemId == 82800 and scanAuctions[auction][2] or NS.NormalizeItemLink( scanAuctions[auction][2] ) ) == itemLink then
					table.remove( scanAuctions, auction ); -- Remove auction from scan data
				else
					auction = auction + 1;
				end
			end
			if #scanAuctions == 0 then
				scanAuctions = nil; -- Remove empty itemId from scan data
			end
		end
		-- Remove auctions(5) that match by itemPrice(1) and itemLink(2) or itemId(6) from group
		auction = 1;
		while auction <= #groupAuctions do
			if NS.scan.status ~= "scanning" and NS.scan.status ~= "buying" then return end -- Check for Reset
			--
			if groupAuctions[auction][1] ~= itemPrice then break end -- Auctions in a group are sorted by itemPrice(1) ASC, so once we exceed itemPrice we won't find any matches
			--
			if NS.NormalizeItemLink( groupAuctions[auction][2] ) == itemLink then
				table.remove( groupAuctions, auction ); -- Remove auction from group
			else
				auction = auction + 1;
			end
		end
		--
		if #groupAuctions == 0 then
			-- All auctions removed, so just remove Group
			NS.AuctionDataGroups_RemoveGroup( groupKey );
			removed = "group";
			return RemovalComplete();
		else
			-- Some auctions removed, update and filter group
			NS.AuctionDataGroups_UpdateGroup( groupKey );
			local groupId = NS.auction.data.groups[groupKey][1]; -- itemId(1) or speciesID(1) or itemLink(1) or appearanceID(1) or sourceID(1)
			NS.scan:FilterGroups( function()
				-- Was group removed?
				if not NS.AuctionDataGroups_FindGroupKey( groupId ) then
					removed = "group";
				else
					removed = "auction";
				end
				return RemovalComplete();
			end, groupKey );
		end
	end
	--
	RemovalComplete = function()
		NS.scan.status = "ready";
		if removed == "group" then
			-- Group removed
			NS.AuctionGroup_Deselect();
			if #NS.auction.data.groups > 0 then
				-- More groups exist
				if NS.buyAll then
					NS.AuctionGroup_OnClick( 1 );
				else
					NS.StatusFrame_Message( NS.SELECT_AN_AUCTION() );
					AuctionFrameCollectionShop_BuyAllButton:Enable();
					OnMessageOnly(); -- Callback
				end
			else
				-- No groups exist
				NS.StatusFrame_Message( L["No additional auctions matched your settings"] );
				AuctionFrameCollectionShop_BuyAllButton:Reset();
				OnMessageOnly(); -- Callback
			end
		elseif removed == "auction" then
			-- Single auction removed
			NS.AuctionDataGroups_Sort();
			if NS.buyAll then
				NS.AuctionGroup_OnClick( 1 );
			else
				if NS.db["autoselectAfterAuctionUnavailable"] then
					-- Auto-select ON
					NS.NextAdjustScroll = true;
					NS.AuctionGroup_OnClick( NS.scan.query.auction.groupKey );
					NS.Print( string.format( NS.mode == "APPEARANCES" and L["Selecting %s for %s, same %s."] or L["Selecting %s for %s, next cheapest."], NS.scan.query.auction[2], NS.MoneyToString( NS.scan.query.auction[1] ), ( NS.mode == "APPEARANCES" and ( NS.shopAppearancesBy == "appearance" and L["appearance"] or L["source"] ) or nil ) ) );
				else
					-- Auto-select OFF
					-- Treat exactly like group removed when more groups exist
					NS.AuctionGroup_Deselect();
					NS.StatusFrame_Message( NS.SELECT_AN_AUCTION() );
					AuctionFrameCollectionShop_BuyAllButton:Enable();
					OnMessageOnly(); -- Callback
				end
			end
		end
	end
	--
	RemoveAuctions();
end
--
NS.AuctionGroup_Deselect = function()
	NS.scan.status = "ready";
	wipe( NS.scan.query.auction );
	AuctionFrameCollectionShop_ScrollFrame:Update();
	if NS.mode == "MOUNTS" or NS.mode == "PETS" or NS.mode == "APPEARANCES" or NS.mode == "RECIPES" then
		HideUIPanel( DressUpFrame );
		AuctionFrameCollectionShop_FlyoutPanel:Reset();
	end
end
--
NS.FlyoutPanelToggleCategories = function()
	local checked = false;
	for i = 1, #NS.modeFilters[2] do
		if NS.mode == "PETS" and i == #NS.modeFilters[2] then break end -- Skip Include Companion Pets
		if not NS.db["modeFilters"][NS.mode][NS.modeFilters[2][i][1]] then
			checked = true;
			break;
		end
	end
	for i = 1, #NS.modeFilters[2] do
		if NS.mode == "PETS" and i == #NS.modeFilters[2] then break end -- Skip Include Companion Pets
		NS.db["modeFilters"][NS.mode][NS.modeFilters[2][i][1]] = checked;
	end
	NS.Reset( true );
end
--
NS.FlyoutPanelSetChecks = function( checked )
	for i = 1, #NS.modeFiltersFlyout do
		NS.db["modeFilters"][NS.mode][NS.modeFiltersFlyout[i][1]] = checked;
	end
	NS.Reset( true );
end
--------------------------------------------------------------------------------------------------------------------------------------------
-- Item Link & Tooltip
--------------------------------------------------------------------------------------------------------------------------------------------
NS.NormalizeItemLink = function( itemLink )
	if string.match( itemLink, "|Hbattlepet:" ) then return itemLink; end
	local itemString = string.match( itemLink, "item[%-?%d:]+" );
	local itemStringPieces = {};
	for piece in string.gmatch( itemString, "([^:]*):?" ) do
		if #itemStringPieces == 9 then
			piece = NS.linkLevel; -- Player level
		elseif #itemStringPieces == 10 then
			piece = NS.linkSpecID; -- Player Spec ID
		end
		itemStringPieces[#itemStringPieces + 1] = piece;
	end
	if not string.match( itemString, ":$" ) then
		itemStringPieces[#itemStringPieces] = nil;
	end
	itemString = table.concat( itemStringPieces, ":" );
	return string.gsub( itemLink, "item[%-?%d:]+", itemString );
end
--
NS.FindInTooltip = function( itemLink, textColor, textPatterns, minLine, maxLine )
	NS.GameTooltip:ClearLines();
	NS.GameTooltip:SetHyperlink( itemLink );
	local gtn,totalLines = NS.GameTooltip:GetName(),NS.GameTooltip:NumLines();
	local textLeft,textLeftText,textLeftColor = nil,nil,{};
	if totalLines == 1 and _G[gtn ..'TextLeft' .. 1]:GetText() == RETRIEVING_ITEM_INFO then
		return "retry"; -- Retrieving Item Information
	else
		for line = 1, totalLines do
			if maxLine and line > maxLine then break end
			if not minLine or line >= minLine then
				--
				textLeft = _G[gtn ..'TextLeft' .. line];
				textLeftText = textLeft:GetText();
				if not textLeftText then return end
				--
				local textLeftColorMatch = false;
				if textColor then
					textLeftColor.r, textLeftColor.g, textLeftColor.b = textLeft:GetTextColor();
					if textColor.r == math.floor( textLeftColor.r * 256 ) and textColor.g == math.floor( textLeftColor.g * 256 ) and textColor.b == math.floor( textLeftColor.b * 256 ) then
						textLeftColorMatch = true;
					end
				end
				--
				local textLeftPatternMatch = false;
				if textPatterns and ( ( textColor and textLeftColorMatch ) or not textColor ) then
					for i = 1, #textPatterns do
						if string.match( textLeftText, textPatterns[i] ) then
							textLeftPatternMatch = true;
							break; -- Gotcha sucka!
						end
					end
				end
				--
				if ( ( textColor and textPatterns ) and ( textLeftColorMatch and textLeftPatternMatch ) ) or ( ( textColor and not textPatterns ) and textLeftColorMatch ) or ( ( textPatterns and not textColor ) and textLeftPatternMatch ) then
					return textLeftText;
				end
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
-- Auction Data Groups
--------------------------------------------------------------------------------------------------------------------------------------------
NS.AuctionDataGroups_FindGroupKey = function( groupId )
	for groupKey = 1, #NS.auction.data.groups do
		if NS.auction.data.groups[groupKey][1] == groupId then
			return groupKey;
		end
	end
	return nil;
end
--
NS.AuctionDataGroups_RemoveAuction = function( groupKey )
	local groupAuctions = NS.auction.data.groups[groupKey][5];
	table.remove( groupAuctions, 1 ); -- auctions(5), first auction(1)
	-- Remove or update group
	if #groupAuctions == 0 then
		NS.AuctionDataGroups_RemoveGroup( groupKey );
		return "group";
	else
		NS.AuctionDataGroups_UpdateGroup( groupKey );
		return "auction";
	end
end
--
NS.AuctionDataGroups_RemoveGroup = function( groupKey )
	table.remove( NS.auction.data.groups, groupKey );
	return "group";
end
--
NS.AuctionDataGroups_UpdateGroup = function( groupKey )
	-- First, normalize itemLink to match current player's AH links.
	-- The GetAll scan may have been performed on another character or when current character was a different spec or level.
	if not NS.db["live"] then
		NS.auction.data.groups[groupKey][5][1][2] = NS.NormalizeItemLink( NS.auction.data.groups[groupKey][5][1][2] );
	end
	-- Update Group
	local itemValue = NS.isPctItemValue and ( TSM_API and TSM_API.GetCustomPriceValue( NS.db["tsmItemValueSource"], TSM_API.ToItemString( NS.auction.data.groups[groupKey][5][1][2] ) ) ) or nil;
	NS.auction.data.groups[groupKey][2] = string.match( NS.auction.data.groups[groupKey][5][1][2], "%|h%[(.+)%]%|h" ); -- group name(2) copied from auctions(5), then first auction(1), get name via itemLink(2)
	NS.auction.data.groups[groupKey][4] = NS.auction.data.groups[groupKey][5][1][1]; -- group itemPrice(4) copied from auctions(5), then first auction(1), then itemPrice(1)
	NS.auction.data.groups[groupKey][6] = ( NS.mode == "PETS" or NS.mode == "RECIPES" ) and NS.auction.data.groups[groupKey][5][1][9] or NS.auction.data.groups[groupKey][5][1][5]; -- group lvl(6) copied from auctions(5), then first auction(1), then lvl(9) or requiresLevel(5)
	NS.auction.data.groups[groupKey][7] = ( not itemValue or itemValue == 0 ) and 123456789 or ( ( NS.auction.data.groups[groupKey][4] * 100 ) / itemValue ); -- pctItemValue(7)
	--NS.auction.data.groups[groupKey][8] -- RESERVED for recipe - requiresProfession(Level)
end
--
NS.AuctionDataGroups_Filter = function( groupKey, FilterFunction, OnGroupsComplete, filterNotMatch, filter )
	if not filter then return OnGroupsComplete(); end
	--
	local groupKeyStart,groupKeyStop,groupBatchNum,groupBatchSize,groupBatchRetry,filterGroupIds,NextGroup,GroupsComplete;
	local groupKeyList = type( groupKey ) == "table" and CopyTable( groupKey ) or nil;
	local groupKey = not groupKeyList and groupKey or nil;
	--
	NextGroup = function()
		if NS.scan.status ~= "scanning" and NS.scan.status ~= "buying" then return end -- Check for Reset
		--
		if groupKey <= groupKeyStop then
			if not groupKeyList or groupKeyList[groupKey] then
				if not groupBatchRetry.inProgress or ( groupBatchRetry.inProgress and groupBatchRetry.groupBatchNum[groupBatchNum] ) then -- Not currently retrying or retrying and match
					local match = FilterFunction( NS.auction.data.groups[groupKey] );
					--
					-- DEBUG
					--
					-- if match == "retry" and groupBatchRetry.attempts == groupBatchRetry.attemptsMax then
					-- 	NS.Print( string.format( L["Filter failed at %s for %s"], RETRIEVING_ITEM_INFO, NS.auction.data.groups[groupKey][5][1][2] ) ); -- auctions(5) first auction(1) itemLink(2)
					-- end
					--
					-- Validate - ignore, retry, or match
					if match == "retry" and groupBatchRetry.attempts < groupBatchRetry.attemptsMax then
						-- Retry required, add it
						if not groupBatchRetry.inProgress then
							groupBatchRetry.count = groupBatchRetry.count + 1;
							groupBatchRetry.groupBatchNum[groupBatchNum] = true;
						end
					elseif ( ( not match or match == "retry" ) and filterNotMatch ) or ( match and match ~= "retry" and not filterNotMatch ) then
						--
						-- FILTER
						--
						table.insert( filterGroupIds, NS.auction.data.groups[groupKey][1] ); -- groupId(1)
					end
					-- Retry successful, remove it
					if groupBatchRetry.inProgress and ( not match or match ~= "retry" ) then
						groupBatchRetry.count = groupBatchRetry.count - 1;
						groupBatchRetry.groupBatchNum[groupBatchNum] = nil;
					end
				end
			end
			-- Batch Complete
			if groupBatchNum == groupBatchSize or groupKey == groupKeyStop then
				if groupBatchRetry.count > 0 and ( not groupBatchRetry.inProgress or ( groupBatchRetry.inProgress and groupBatchRetry.attempts < groupBatchRetry.attemptsMax ) ) then
					-- Start Batch Retry
					groupBatchRetry.inProgress = true;
					groupBatchRetry.attempts = groupBatchRetry.attempts + 1;
					groupKey = ( groupKey - groupBatchNum ) + 1; -- Reset groupKey to start of batch for retry
					groupBatchNum = 1;
					local after = groupBatchRetry.attempts * 0.01;
					return C_Timer.After( after, NextGroup );
				else
					-- No Batch Retry
					groupBatchRetry.inProgress = false;
					groupBatchRetry.count = 0;
					groupBatchRetry.attempts = 0;
					wipe( groupBatchRetry.groupBatchNum );
					groupKey = groupKey + 1;
					groupBatchNum = 1;
					return C_Timer.After( 0.001, NextGroup );
				end
			end
			-- Group Complete
			groupKey = groupKey + 1;
			groupBatchNum = groupBatchNum + 1;
			return NextGroup();
		else
			return GroupsComplete();
		end
	end
	--
	GroupsComplete = function()
		if NS.scan.status ~= "scanning" and NS.scan.status ~= "buying" then return end -- Check for Reset
		if filter == "analyze" then return OnGroupsComplete( filterGroupIds ); end -- Return for analysis -- DO NOT REMOVE GROUPS --
		--
		local recheckGroupIds = {}; -- APPEARANCES ONLY
		-- Remove filtered auction or group
		for i = 1, #filterGroupIds do
			local groupKey = NS.AuctionDataGroups_FindGroupKey( filterGroupIds[i] );
			if ( NS.mode == "APPEARANCES" and NS.AuctionDataGroups_RemoveAuction( groupKey ) or NS.AuctionDataGroups_RemoveGroup( groupKey ) ) ~= "group" then
				-- Auction removed, group must be rechecked -- APPEARANCES ONLY --
				table.insert( recheckGroupIds, filterGroupIds[i] ); -- i.e. appearanceID or sourceID
			end
		end
		-- Recheck auction removed groups, their new first auction may be a match
		if #recheckGroupIds > 0 then
			local recheckGroupKeys = {};
			for i = 1, #recheckGroupIds do
				recheckGroupKeys[NS.AuctionDataGroups_FindGroupKey( recheckGroupIds[i] )] = true;
			end
			return NS.AuctionDataGroups_Filter( recheckGroupKeys, FilterFunction, OnGroupsComplete, filterNotMatch, filter );
		else
			return OnGroupsComplete();
		end
	end
	--
	groupKeyStart = groupKey or 1;
	groupKeyStop = groupKey or #NS.auction.data.groups;
	groupKey = groupKeyStart;
	groupBatchNum = 1;
	groupBatchSize = 50;
	groupBatchRetry = { inProgress = false, count = 0, attempts = 0, attemptsMax = 50, groupBatchNum = {} };
	filterGroupIds = {};
	NextGroup();
end
--
NS.AuctionDataGroups_Sort = function()
	if #NS.auction.data.groups == 0 then return end
	--
	local groupId;
	if NS.scan.query.auction.groupKey then
		groupId = NS.auction.data.groups[NS.scan.query.auction.groupKey][1]; -- itemId(1) or speciesID(1) or itemLink(1) or appearanceID(1)
	end
	--
	table.sort ( NS.auction.data.groups,
		function ( item1, item2 )
			if item1[NS.auction.data.sortKey] == item2[NS.auction.data.sortKey] then
				if item1[4] ~= item2[4] then -- itemPrice
					return item1[4] < item2[4]; -- itemPrice
				else
					return item1[3] < item2[3]; -- category
				end
			end
			if NS.auction.data.sortOrder == "ASC" then
				return item1[NS.auction.data.sortKey] < item2[NS.auction.data.sortKey];
			elseif NS.auction.data.sortOrder == "DESC" then
				return item1[NS.auction.data.sortKey] > item2[NS.auction.data.sortKey];
			end
		end
	);
	-- Find selected groupKey after reordering them
	if groupId then
		NS.scan.query.auction.groupKey = NS.AuctionDataGroups_FindGroupKey( groupId );
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
-- Scan
--------------------------------------------------------------------------------------------------------------------------------------------
function NS.scan:Reset()
	CollectionShopEventsFrame:UnregisterEvent( "AUCTION_HOUSE_BROWSE_RESULTS_UPDATED" );
	CollectionShopEventsFrame:UnregisterEvent( "AUCTION_HOUSE_THROTTLED_SYSTEM_READY" );
	CollectionShopEventsFrame:UnregisterEvent( "ITEM_SEARCH_RESULTS_UPDATED" );
	CollectionShopEventsFrame:UnregisterEvent( "REPLICATE_ITEM_LIST_UPDATE" );
	-- Check if GETALL scan was interupted
	if self.type == "GETALL" and self.status == "scanning" then
		if ( C_AuctionHouse.IsThrottledMessageSystemReady() ) then
			C_AuctionHouse.ReplicateItems( "CLEAR_BROWSE_FRAME_RESULTS", nil, nil, 0, false, nil, false, false ); -- Prevents WoW from crashing on subsequent queries, not sure why
		end
	end
	--
	self.query = {
		searchString = "",
		sorts = { sortOrder=0, reverseSort=false }, -- Buyout(4) doesn't work right so Price(0) is preferable
		minLevel = nil,
		maxLevel = nil,
		-- filters = {}, -- This is recreated each time a browse query is sent
		uncollectedOnly = false,
		usableOnly = false,
		upgradesOnly = false,
		exactMatch = false,
		qualities = {}, -- These are added to the filters table when sending a browse query
		--
		itemClassFilters = nil,
		--
		queue = {},
		categoryName = nil,
		subCategoryName = nil,
		remaining = 1,
		auction = {}, 	-- SELECT
		rarity = nil,
		attempts = 1,
		maxAttempts = 100,
		--
		browseResults = nil, -- This temporarily holds the browse results of a browse query and are removed 1-by-1 during item searches
	};
	self.type = nil;
	self.status = "ready"; -- ready, scanning, selected, buying
	self.triggerAuctionWon = nil;
	self.selectedOwner = nil;
end
--
function NS.scan:Start( type )
	if self.status ~= "ready" and self.status ~= "selected" then return end
	--
	self.status = "scanning";
	self.type = type;
	self.selectedOwner = nil;
	wipe( self.query.qualities );
	NS.AuctionSortButtons_Action( "Disable" );
	AuctionFrameCollectionShop_JumbotronFrame:Hide();
	AuctionFrameCollectionShop_DialogFrame_BuyoutFrame_SelectedOwnerLabel:Hide();
	AuctionFrameCollectionShop_DialogFrame_BuyoutFrame_SelectedOwnerEditbox:Hide();
	AuctionFrameCollectionShop_DialogFrame_BuyoutFrame_BuyoutButton:Disable();
	AuctionFrameCollectionShop_DialogFrame_BuyoutFrame_CancelButton:Disable();
	AuctionFrameCollectionShop_LiveCheckButton:Disable();
	AuctionFrameCollectionShop_ScanButton:Disable();
	AuctionFrameCollectionShop_BuyAllButton:Disable();
	NS.disableFlyoutChecks = true;
	AuctionFrameCollectionShop_FlyoutPanel_ScrollFrame:Update();
	AuctionFrameCollectionShop_FlyoutPanel_NameSearchEditbox:Disable();
	--
	if type == "GETALL" then
		NS.JumbotronFrame_Message( L["Scanning Auction House"] );
		NS.StatusFrame_Message( L["Request sent, waiting on auction data... This can take a minute, please wait..."] );
		AuctionFrameCollectionShop_ShopButton:Disable();
		for i = 1, 4 do
			self.query.qualities[i] = true;
		end
		self:QueryGetAllSend();
	elseif type == "SELECT" then
		AuctionFrameCollectionShop_ShopButton:SetText( L["Abort"] );
		-- Blizzard Battle Pet searches don't technically respect the rarity filter.
		-- Only the highest rarity available is filterable.
		-- Example: pets available in green and blue will only show when filtering includes blue
		if self.query.auction[6] == 82800 then -- Battle Pet cage - itemId(6)
			for i = 1, 3 do
				self.query.qualities[i] = true; -- Add all three pet qualities (common, uncommon, rare) to be sure we get a result if it exists
			end
		else
			-- Items outside of Battle Pets should be OK with standard quality filtering
			self.query.qualities[self.query.rarity] = true;
		end
		self:QueryBrowseSend();
	elseif type == "SHOP" then
		NS.JumbotronFrame_Message( L["Shopping"] );
		NS.StatusFrame_Message( "..." );
		AuctionFrameCollectionShop_ShopButton:SetText( L["Abort"] );
		-- ALL MODES: Name Search
		local nameSearch = strtrim( AuctionFrameCollectionShop_FlyoutPanel_NameSearchEditbox:GetText() );
		if nameSearch ~= "" then
			self.query.searchString = string.lower( nameSearch );
		end
		-- ALL MODES: Qualities
		for i = 1, #NS.modeFilters[1] do
			if NS.db["modeFilters"][NS.mode][NS.modeFilters[1][i][1]] then
				self.query.qualities[NS.modeFilters[1][i][4]] = true;
			end
		end
		if not next( self.query.qualities ) then
			return self:Complete( RED_FONT_COLOR_CODE .. L["You must check at least one rarity filter"] .. FONT_COLOR_CODE_CLOSE );
		end
		-- RECIPES: Player Professions Check
		if NS.mode == "RECIPES" and not next( NS.playerProfessions ) then
			return self:Complete( RED_FONT_COLOR_CODE .. L["You must have a primary profession or Cooking"] .. FONT_COLOR_CODE_CLOSE );
		end
		-- MOST MODES: Categories Filter Check
		if NS.mode == "PETS" or NS.mode == "TOYS" or NS.mode == "APPEARANCES" or NS.mode == "RECIPES" then
			local categoriesFilterCheck = false;
			for i = 1, #NS.modeFilters[2] do
				if NS.db["modeFilters"][NS.mode][NS.modeFilters[2][i][1]] and not ( NS.mode == "PETS" and i == #NS.modeFilters[2] ) then -- Companion Pets doesn't count, not a Pet Family
					categoriesFilterCheck = true;
					break;
				end
			end
			if not categoriesFilterCheck then
				return self:Complete( RED_FONT_COLOR_CODE .. string.format( L["You must check at least one %s filter"], ( NS.mode == "PETS" and L["Pet Family"] ) or ( NS.mode == "TOYS" and L["Auction Category"] ) or ( NS.mode == "APPEARANCES" and L["Appearance Category"] ) or ( NS.mode == "RECIPES" and L["Recipe Category"] ) ) .. FONT_COLOR_CODE_CLOSE );
			end
		end
		-- ALL MODES: Collected Filter Check
		local collectedFilterCheck = false;
		for i = 1, #NS.modeFilters[3] do
			if NS.db["modeFilters"][NS.mode][NS.modeFilters[3][i][1]] then
				collectedFilterCheck = true;
				break;
			end
		end
		if not collectedFilterCheck then
			return self:Complete( RED_FONT_COLOR_CODE .. L["You must check at least one Collected filter"] .. FONT_COLOR_CODE_CLOSE );
		end
		-- SHOP BY MODE
		--------------------------------------------------------------------------------------------------------------------------------------------
		if NS.mode == "MOUNTS" then
			if NS.db["live"] then
				self.query.itemClassFilters = AuctionCategories[12].subCategories[5].filters; -- Miscellaneous => Mount
				self.query.categoryName = AuctionCategories[12].name; -- Miscellaneous
				self.query.subCategoryName = AuctionCategories[12].subCategories[5].name; -- Mount
				self:QueryBrowseSend();
			else
				self:ImportShopData();
			end
		--------------------------------------------------------------------------------------------------------------------------------------------
		elseif NS.mode == "PETS" then
			if NS.db["live"] then
				-- Auction Categories
				for i = 1, #AuctionCategories[10].subCategories do
					if NS.db["modeFilters"][NS.mode][AuctionCategories[10].subCategories[i].name] then
						table.insert( self.query.queue, function()
							self.query.itemClassFilters = AuctionCategories[10].subCategories[i].filters; -- Battle Pets => Pet Family (or Companion Pets)
							self.query.categoryName = AuctionCategories[10].name; -- Battle Pets
							self.query.subCategoryName = AuctionCategories[10].subCategories[i].name; -- Pet Family (or Companion Pets)
						end );
					end
				end
				-- Pet Levels Filter Check
				local petLevelsFilterCheck = false;
				for i = 1, #NS.modeFilters[4] do
					if NS.db["modeFilters"][NS.mode][NS.modeFilters[4][i][1]] then
						petLevelsFilterCheck = true;
						break;
					end
				end
				if not petLevelsFilterCheck then
					return self:Complete( RED_FONT_COLOR_CODE .. L["You must check at least one Level filter"] .. FONT_COLOR_CODE_CLOSE );
				end
				--
				self.query.remaining = #self.query.queue;
				self.query.queue[1]();
				self:QueryBrowseSend();
			else
				self:ImportShopData();
			end
		--------------------------------------------------------------------------------------------------------------------------------------------
		elseif NS.mode == "TOYS" then
			if NS.db["live"] then
				for i = 1, #NS.modeFilters[2] do
					-- Auction Categories
					if NS.db["modeFilters"][NS.mode][NS.modeFilters[2][i][1]] then
						local cat,subcat = unpack( NS.modeFilters[2][i][4] );
						table.insert( self.query.queue, function()
							self.query.itemClassFilters = AuctionCategories[cat].subCategories[subcat].filters; -- Category => Subcategory
							self.query.categoryName = AuctionCategories[cat].name; -- Category
							self.query.subCategoryName = AuctionCategories[cat].subCategories[subcat].name; -- Subcategory
						end );
					end
				end
				self.query.remaining = #self.query.queue;
				self.query.queue[1]();
				self:QueryBrowseSend();
			else
				self:ImportShopData();
			end
		--------------------------------------------------------------------------------------------------------------------------------------------
		elseif NS.mode == "APPEARANCES" then
			NS.shopAppearancesBy = ( NS.db["modeFilters"][NS.mode][NS.modeFilters[3][2][1]] or NS.db["modeFilters"][NS.mode][NS.modeFilters[3][3][1]] ) and "source" or "appearance";
			if NS.db["live"] then
				for i = 1, #NS.modeFilters[2] do
					-- Auction Categories
					if NS.db["modeFilters"][NS.mode][NS.modeFilters[2][i][1]] then
						local cat,subcat1,subcat2 = unpack( NS.modeFilters[2][i][4] );
						table.insert( self.query.queue, function()
							self.query.itemClassFilters = AuctionCategories[cat].subCategories[subcat1].subCategories[subcat2].filters; -- Category => Subcategory1 => Subcateogry2
							self.query.categoryName = AuctionCategories[cat].name; -- Category
							self.query.subCategoryName = AuctionCategories[cat].subCategories[subcat1].name .. " > " .. AuctionCategories[cat].subCategories[subcat1].subCategories[subcat2].name; -- Subcategory1 > Subcategory2
						end );
					end
				end
				self.query.remaining = #self.query.queue;
				self.query.queue[1]();
				self:QueryBrowseSend();
			else
				if not NS.appearanceCollection.getAllReady then
					self:UpdateAppearanceCollection();
				else
					self:ImportShopData();
				end
			end
		elseif NS.mode == "RECIPES" then
			if NS.db["live"] then
				for i = 1, #NS.modeFilters[2] do
					-- Auction Categories
					if NS.db["modeFilters"][NS.mode][NS.modeFilters[2][i][1]] then
						local subcat = NS.modeFilters[2][i][4];
						table.insert( self.query.queue, function()
							self.query.itemClassFilters = AuctionCategories[9].subCategories[subcat].filters; -- Recipes => Profession
							self.query.categoryName = AuctionCategories[9].name; -- Recipes
							self.query.subCategoryName = AuctionCategories[9].subCategories[subcat].name; -- Profession
						end );
					end
				end
				--
				self.query.remaining = #self.query.queue;
				self.query.queue[1]();
				self:QueryBrowseSend();
			else
				self:ImportShopData();
			end
		end
	end
end
--
function NS.scan:QueryBrowseSend()
	if self.status ~= "scanning" then return end
	if C_AuctionHouse.IsThrottledMessageSystemReady() then
		self.browseResults = nil;
		self.query.attempts = 1; -- Set to default on successful attempt
		local query = {};
		query.searchString = self.query.searchString;
		query.sorts = self.query.sorts;
		query.minLevel = self.query.minLevel;
		query.maxLevel = self.query.maxLevel;
		--
		query.filters = {};
		if self.query.uncollectedOnly then query.filters[#query.filters + 1] = 0; end
		if self.query.usableOnly then query.filters[#query.filters + 1] = 1; end
		if self.query.upgradesOnly then query.filters[#query.filters + 1] = 2; end
		if self.query.exactMatch then query.filters[#query.filters + 1] = 3; end
		if self.query.qualities[0] then query.filters[#query.filters + 1] = 4; end
		if self.query.qualities[1] then query.filters[#query.filters + 1] = 5; end
		if self.query.qualities[2] then query.filters[#query.filters + 1] = 6; end
		if self.query.qualities[3] then query.filters[#query.filters + 1] = 7; end
		if self.query.qualities[4] then query.filters[#query.filters + 1] = 8; end
		--
		query.itemClassFilters = self.query.itemClassFilters;
		--
		CollectionShopEventsFrame:RegisterEvent( "AUCTION_HOUSE_BROWSE_RESULTS_UPDATED" );
		CollectionShopEventsFrame:RegisterEvent( "AUCTION_HOUSE_THROTTLED_SYSTEM_READY" );
		C_AuctionHouse.SendBrowseQuery( query );
	elseif self.query.attempts < self.query.maxAttempts then
		-- Increment attempts, delay and reattempt
		self.query.attempts = self.query.attempts + 1;
		C_Timer.After( 0.10, function() self:QueryBrowseSend() end );
	else
		-- Abort
		NS.Print( L["Could not query Auction House after several attempts. Please try again later."] );
		NS.Reset();
	end
end
--
function NS.scan:QuerySearchSend()
	local itemKey = self.browseResults[1]["itemKey"]; -- Pull first browse result because we'll start with first and remove them after retrieve
	local sorts = { sortOrder=0, reverseSort=false };
	local separateOwnerItems = false;
	CollectionShopEventsFrame:RegisterEvent( "ITEM_SEARCH_RESULTS_UPDATED" );
	C_AuctionHouse.SendSearchQuery( itemKey, sorts, separateOwnerItems );
end
--
function NS.scan:QueryGetAllSend()
	if self.status ~= "scanning" then return end
	local canSendThrottledMessage = C_AuctionHouse.IsThrottledMessageSystemReady();
	if canSendThrottledMessage then
		if NS.db["getAllScan"][NS.realmName] then
			NS.db["getAllScan"][NS.realmName] = nil;
		end
		--
		NS.appearanceCollection.getAllReady = false;
		--
		NS.db["getAllScan"][NS.realmName] = {
			["data"] = {
				["itemIds"] = {},
				["appearanceSources"] = {}
			},
			["time"] = time(),
		};
		--
		CollectionShopEventsFrame:RegisterEvent( "REPLICATE_ITEM_LIST_UPDATE" );
		C_AuctionHouse.ReplicateItems();
	else
		-- Abort
		NS.Print( L["Blizzard allows a GetAll scan once per 20 minutes or per game client launch. Please try again later."] );
		NS.Reset();
	end
end
--
function NS.scan:OnBrowseResultsUpdated() -- AUCTION_HOUSE_BROWSE_RESULTS_UPDATED
	CollectionShopEventsFrame:UnregisterEvent( "AUCTION_HOUSE_BROWSE_RESULTS_UPDATED" );
	-- Not really doing anything here right now.
end
--
function NS.scan:OnThrottledSystemReady() -- AUCTION_HOUSE_THROTTLED_SYSTEM_READY
	CollectionShopEventsFrame:UnregisterEvent( "AUCTION_HOUSE_THROTTLED_SYSTEM_READY" );
	if self.status ~= "scanning" then return end
	self:QueryBrowseRetrieve();
end
--
function NS.scan:OnItemSearchResultsUpdated() -- ITEM_SEARCH_RESULTS_UPDATED
	CollectionShopEventsFrame:UnregisterEvent( "ITEM_SEARCH_RESULTS_UPDATED" );
	if self.triggerAuctionWon then
		self.triggerAuctionWon = nil; -- reset to default
		self:AfterAuctionWon();
	else
		if self.status ~= "scanning" then return end
		self:QuerySearchRetrieve();
	end
end
--
function NS.scan:OnReplicateItemListUpdate() -- REPLICATE_ITEM_LIST_UPDATE
	CollectionShopEventsFrame:UnregisterEvent( "REPLICATE_ITEM_LIST_UPDATE" );
	if self.status ~= "scanning" then return end
	if self.type == "GETALL" then
		self:QueryGetAllRetrieve();
	end
end
--
function NS.scan:AuctionItemType( itemId )
	if NS.mountInfo[itemId] then
		return "mount";
	elseif itemId == 82800 or NS.petInfo[itemId] then
		return "pet";
	elseif NS.toyInfo[itemId] then
		return "toy";
	elseif NS.recipeInfo[itemId] then
		return "recipe";
	else
		local _,_,_,invType = GetItemInfoInstant( itemId );
		if invType and NS.invTypeToSlotId[invType] then
			return "possible-appearance";
		else
			return nil; -- No type
		end
	end
end
--
function NS.scan:GetSearchItemInfo( itemSearchResultIndex )
	local data = ( self.type == "SHOP" and NS.auction.data.live ) or nil;
	--
	local browseResultInfo = self.browseResults[1];
	local itemKey = browseResultInfo["itemKey"];
	local resultInfo = C_AuctionHouse.GetItemSearchResultInfo( itemKey, itemSearchResultIndex );
	local itemKeyInfo = C_AuctionHouse.GetItemKeyInfo( itemKey );
	------------------------------------------------------------------------------
	-- browseResultInfo ----------------------------------------------------------
	------------------------------------------------------------------------------
	-- itemKey	structure ItemKey
	-- appearanceLink	string (nilable)
	-- totalQuantity	number
	-- minPrice	number
	-- containsOwnerItem	boolean
	------------------------------------------------------------------------------
	-- resultInfo ----------------------------------------------------------------
	------------------------------------------------------------------------------
	-- itemKey	structure ItemKey
	-- owners	string[]
	-- timeLeft	Enum.AuctionHouseTimeLeftBand
	-- auctionID	number
	-- quantity	number
	-- itemLink	string (nilable)
	-- containsOwnerItem	boolean
	-- containsAccountItem	boolean
	-- containsSocketedItem	boolean
	-- bidder	string (nilable)
	-- minBid	number (nilable)
	-- bidAmount	number (nilable)
	-- buyoutAmount	number (nilable)
	-- timeLeftSeconds	number (nilable)
	------------------------------------------------------------------------------
	-- itemKeyInfo ---------------------------------------------------------------
	------------------------------------------------------------------------------
	-- itemName	string
	-- battlePetLink	string (nilable)
	-- appearanceLink	string (nilable)
	-- quality	number	Enum.ItemQuality
	-- iconFileID	number	FileID
	-- isPet	boolean
	-- isCommodity	boolean
	-- isEquipment	boolean
	------------------------------------------------------------------------------
	-- The pre 8.3 auction info --------------------------------------------------
	------------------------------------------------------------------------------
	-- _,texture,count,quality,_,level,levelColHeader,_,_,buyoutPrice,_,_,_,owner,ownerFullName,_,itemId
	------------------------------------------------------------------------------
	local texture = itemKeyInfo.iconFileID;
	local quality = itemKeyInfo.quality;
	local level = itemKey.itemLevel;
	local buyoutPrice = resultInfo.buyoutAmount or 0;
	local itemId = itemKey.itemID;
	local itemLink;
	if ( self.type == "SHOP" or self.type == "SELECT" ) and NS.db["maxItemPriceCopper"][NS.mode] > 0 and buyoutPrice > NS.db["maxItemPriceCopper"][NS.mode] then
		return "maxprice";
	elseif buyoutPrice > 0 and ( self.type ~= "SELECT" or buyoutPrice == self.query.auction[1] ) and ( quality == -1 or self.query.qualities[quality] ) then
		local auctionItemType = self:AuctionItemType( itemId );
		if not auctionItemType then return end -- Skip auctions that aren't the type we need
		--
		if self.query.qualities[quality] then
			itemLink = resultInfo.itemLink; -- Ignore missing quality (-1) to force retry
		end
		--
		if not itemLink then
			return "retry";
		else
			if self.type == "SHOP" then
				local appearanceID,sourceID;
				--
				if auctionItemType == "possible-appearance" then
					if quality > 1 then -- Transmoggable gear is uncommon or higher quality
						appearanceID,sourceID = NS.GetAppearanceSourceInfo( itemLink );
						if not appearanceID then
							return "retry-possible-appearance"; -- Retry for appearanceID or if item has none then prevent inclusion after max retries
						end
						if not NS.FindKeyByValue( data["appearanceSources"], sourceID ) then
							data["appearanceSources"][#data["appearanceSources"] + 1] = sourceID; -- List of unique sources to update appearanceCollection
						end
					else
						return nil; -- No poor and common quality items
					end
				end
				--
				if not data["itemIds"][itemId] then
					data["itemIds"][itemId] = {}; -- Store auctions by itemId
				end
				-- Add auction
				data["itemIds"][itemId][#data["itemIds"][itemId] + 1] = {
					buyoutPrice, -- itemPrice
					itemLink,
					texture,
					quality,
					( not itemKeyInfo.isPet and level or ( auctionItemType == "recipe" and NS.recipeInfo[itemId][3] > 1 and NS.recipeInfo[itemId][3] ) or 1 ), -- requiresLevel -- requiredLevel(3)
					appearanceID,
					sourceID,
				};
			elseif self.type == "SELECT" and itemLink == self.query.auction[2] then -- itemLink(2)
				self.selectedOwner = resultInfo.owners[1] or nil;
				self.query.auction.auctionID = resultInfo.auctionID;
				return "found";
			end
		end
	end
end
--
function NS.scan:GetReplicateItemInfo( index )
	local data = ( self.type == "GETALL" and NS.db["getAllScan"][NS.realmName]["data"] ) or ( self.type == "SHOP" and NS.auction.data.live );
	local _,texture,count,quality,_,level,levelColHeader,_,_,buyoutPrice,_,_,_,owner,ownerFullName,_,itemId = C_AuctionHouse.GetReplicateItemInfo( index );
	local itemLink;
	if ( self.type == "SHOP" or self.type == "SELECT" ) and NS.db["maxItemPriceCopper"][NS.mode] > 0 and buyoutPrice > NS.db["maxItemPriceCopper"][NS.mode] then
		return "maxprice";
	elseif count == 1 and buyoutPrice > 0 and ( self.type ~= "SELECT" or buyoutPrice == self.query.auction[1] ) and ( quality == -1 or self.query.qualities[quality] ) then
		local auctionItemType = self:AuctionItemType( itemId );
		if not auctionItemType then return end -- Skip auctions that aren't the type we need
		--
		if self.query.qualities[quality] then
			itemLink = C_AuctionHouse.GetReplicateItemLink( index ); -- Ignore missing quality (-1) to force retry
		end
		--
		if not itemLink then
			return "retry";
		else
			if self.type == "SHOP" or self.type == "GETALL" then
				local appearanceID,sourceID;
				--
				if auctionItemType == "possible-appearance" then
					if quality > 1 then -- Transmoggable gear is uncommon or higher quality
						appearanceID,sourceID = NS.GetAppearanceSourceInfo( itemLink );
						if not appearanceID then
							return "retry-possible-appearance"; -- Retry for appearanceID or if item has none then prevent inclusion after max retries
						end
						if not NS.FindKeyByValue( data["appearanceSources"], sourceID ) then
							data["appearanceSources"][#data["appearanceSources"] + 1] = sourceID; -- List of unique sources to update appearanceCollection
						end
					else
						return nil; -- No poor and common quality items
					end
				end
				--
				if not data["itemIds"][itemId] then
					data["itemIds"][itemId] = {}; -- Store auctions by itemId
				end
				-- Add auction
				data["itemIds"][itemId][#data["itemIds"][itemId] + 1] = {
					buyoutPrice, -- itemPrice
					itemLink,
					texture,
					quality,
					( levelColHeader == "REQ_LEVEL_ABBR" and level or ( auctionItemType == "recipe" and NS.recipeInfo[itemId][3] > 1 and NS.recipeInfo[itemId][3] ) or 1 ), -- requiresLevel -- requiredLevel(3)
					appearanceID,
					sourceID,
				};
			elseif self.type == "SELECT" and itemLink == self.query.auction[2] then -- itemLink(2)
				self.selectedOwner = ( ownerFullName and ownerFullName ) or ( owner and owner ) or nil; -- ownerFullName is empty when player from same realm
				return "found";
			end
		end
	end
end
--
function NS.scan:QueryBrowseRetrieve()
	if self.status ~= "scanning" then return end -- Scan interrupted
	--
	if not self.browseResults then
		self.browseResults = C_AuctionHouse.GetBrowseResults();
		-- Note: It might be a good idea to remove items here based on whether maxItemPriceExceeded
		-- SELECT scan removes browse results that don't have the same itemID
		if self.type == "SELECT" then
			local i = 1;
			while i <= #self.browseResults do
				if NS.scan.status ~= "scanning" then return end -- Check for Reset
				--
				if self.browseResults[i]["itemKey"]["itemID"] ~= self.query.auction[6] then -- itemID(6)
					table.remove( self.browseResults, i ); -- Remove result from browse results
				else
					i = i + 1;
				end
			end
		end
	end
	--
	if #self.browseResults > 0 then
		return self:QuerySearchSend();
	else
		-- Query complete
		self.query.remaining = self.query.remaining - 1;
		if self.query.remaining == 0 then
			if self.type == "SHOP" then -- Live
				if NS.mode == "APPEARANCES" then
					self:UpdateAppearanceCollection(); -- SHOP scan "almost" complete
				else
					self:ImportShopData(); -- SHOP scan "almost" complete
				end
			else
				self:Complete(); -- SELECT scan complete
			end
		else
			self.query.queue[#self.query.queue - ( self.query.remaining - 1 )]();
			self:QueryBrowseSend();
		end
	end
end
--
function NS.scan:QuerySearchRetrieve()
	if self.status ~= "scanning" then return end -- Scan interrupted
	--
	local totalAuctions = C_AuctionHouse.GetNumItemSearchResults(self.browseResults[1]["itemKey"]);
	local batchAuctions = totalAuctions;
	--
	local auctionBatchNum,auctionBatchRetry,maxItemPriceExceeded,NextAuction,SearchRetrieveComplete;
	--
	if self.type == "SHOP" then
		local categoryDesc = HIGHLIGHT_FONT_COLOR_CODE .. self.query.categoryName .. " > " .. self.query.subCategoryName .. FONT_COLOR_CODE_CLOSE;
		if #self.browseResults == 0 then
			NS.StatusFrame_Message( string.format( L["Scanning %s: No matches"], categoryDesc ) );
		else
			NS.StatusFrame_Message( string.format( L["Scanning %s: %d results so far..."], categoryDesc, #self.browseResults ) );
		end
	end
	--
	NextAuction = function()
		if self.status ~= "scanning" then return end -- Scan interrupted
		--
		if not auctionBatchRetry.inProgress or ( auctionBatchRetry.inProgress and auctionBatchRetry.auctionBatchNum[auctionBatchNum] ) then -- Not currently retrying or retrying and match
			local get = self:GetSearchItemInfo( auctionBatchNum );
			if get == "retry" or ( get == "retry-possible-appearance" and ( not auctionBatchRetry.inProgress or auctionBatchRetry.attempts < 10 ) ) then
				-- Retry required
				if not auctionBatchRetry.inProgress then
					auctionBatchRetry.count = auctionBatchRetry.count + 1;
					auctionBatchRetry.auctionBatchNum[auctionBatchNum] = true;
				end
			else
				if get == "maxprice" then
					--
					-- MAX ITEM PRICE EXCEEDED!!!
					--
					maxItemPriceExceeded = true;
					return SearchRetrieveComplete();
				elseif get == "found" then
					--
					-- SELECT MATCH FOUND!!!
					--
					self.query.auction.found = true;
					return SearchRetrieveComplete();
				elseif auctionBatchRetry.inProgress then
					-- Retry successful (or max Appearance attempts)
					auctionBatchRetry.count = auctionBatchRetry.count - 1;
					auctionBatchRetry.auctionBatchNum[auctionBatchNum] = nil;
				end
			end
		end
		-- Batch Complete
		if auctionBatchNum == batchAuctions then
			if auctionBatchRetry.count > 0 and ( not auctionBatchRetry.inProgress or ( auctionBatchRetry.inProgress and auctionBatchRetry.attempts < auctionBatchRetry.attemptsMax ) ) then
				-- Start Batch Retry
				auctionBatchRetry.inProgress = true;
				auctionBatchRetry.attempts = auctionBatchRetry.attempts + 1;
				auctionBatchNum = 1;
				local after = auctionBatchRetry.attempts * 0.01;
				return C_Timer.After( after, NextAuction );
			else
				-- No Batch Retry
				return SearchRetrieveComplete();
			end
		else
			-- Auction Complete
			auctionBatchNum = auctionBatchNum + 1;
			return NextAuction();
		end
	end
	--
	SearchRetrieveComplete = function()
		-- Search retrieve complete
		table.remove( self.browseResults, 1 );
		self:QueryBrowseRetrieve();
	end
	--
	if batchAuctions == 0 then
		SearchRetrieveComplete();
	else
		auctionBatchNum = 1;
		auctionBatchRetry = { inProgress = false, count = 0, attempts = 0, attemptsMax = 50, auctionBatchNum = {} };
		NextAuction();
	end
end
--
function NS.scan:QueryGetAllRetrieve()
	if self.status ~= "scanning" then return end -- Scan interrupted
	local totalAuctions = C_AuctionHouse.GetNumReplicateItems();
	local auctionNum,auctionBatchNum,auctionBatchSize,auctionBatchRetry,NextAuction;
	--
	NextAuction = function()
		if self.status ~= "scanning" then return end -- Scan interrupted
		--
		if auctionNum <= totalAuctions then
			if not auctionBatchRetry.inProgress or ( auctionBatchRetry.inProgress and auctionBatchRetry.auctionBatchNum[auctionBatchNum] ) then -- Not currently retrying or retrying and match
				local get = self:GetReplicateItemInfo( auctionNum );
				if get == "retry" or ( get == "retry-possible-appearance" and ( not auctionBatchRetry.inProgress or auctionBatchRetry.attempts < 10 ) ) then
					-- Retry required
					if not auctionBatchRetry.inProgress then
						auctionBatchRetry.count = auctionBatchRetry.count + 1;
						auctionBatchRetry.auctionBatchNum[auctionBatchNum] = true;
					end
				elseif auctionBatchRetry.inProgress then
					-- Retry successful (or max Appearance attempts)
					auctionBatchRetry.count = auctionBatchRetry.count - 1;
					auctionBatchRetry.auctionBatchNum[auctionBatchNum] = nil;
				end
			end
			-- Batch Complete
			if auctionBatchNum == auctionBatchSize or auctionNum == totalAuctions then
				if auctionBatchRetry.count > 0 and ( not auctionBatchRetry.inProgress or ( auctionBatchRetry.inProgress and auctionBatchRetry.attempts < auctionBatchRetry.attemptsMax ) ) then
					-- Start Batch Retry
					auctionBatchRetry.inProgress = true;
					auctionBatchRetry.attempts = auctionBatchRetry.attempts + 1;
					auctionNum = ( auctionNum - auctionBatchNum ) + 1; -- Reset auctionNum to start of batch for retry
					auctionBatchNum = 1;
					local after = auctionBatchRetry.attempts * 0.01;
					return C_Timer.After( after, NextAuction );
				else
					-- NotRequired/Stop/Reset Batch Retry
					auctionBatchRetry.inProgress = false;
					auctionBatchRetry.count = 0;
					auctionBatchRetry.attempts = 0;
					wipe( auctionBatchRetry.auctionBatchNum );
					auctionBatchNum = 0; -- +1 @ auction complete
					NS.StatusFrame_Message( string.format( L["%s remaining auctions...\n\nCollecting auction item links for all modes."], HIGHLIGHT_FONT_COLOR_CODE .. ( totalAuctions - auctionNum ) .. FONT_COLOR_CODE_CLOSE ) );
				end
			end
			-- Auction Complete
			auctionNum = auctionNum + 1;
			auctionBatchNum = auctionBatchNum + 1;
			return NextAuction();
		else
			-- ALL AUCTIONS COMPLETE
			self:Complete();
		end
	end
	--
	auctionNum = 1;
	auctionBatchNum = 1;
	auctionBatchSize = 50;
	auctionBatchRetry = { inProgress = false, count = 0, attempts = 0, attemptsMax = 50, auctionBatchNum = {} };
	NextAuction();
end
--
function NS.scan:UpdateAppearanceCollection()
	local data1 = NS.db["live"] and NS.auction.data.live or NS.db["getAllScan"][NS.realmName]["data"];
	--
	NS.JumbotronFrame_Message( L["Updating Collection"] );
	--
	NS.BatchDataLoop( {
		data = data1["appearanceSources"],
		attemptsMax = 50,
		AbortFunction = function()
			if self.status ~= "scanning" then
				return true;
			end
		end,
		DataFunction = function( data, dataNum )
			local sourceID = data[dataNum];
			--
			if not NS.appearanceCollection.sources[sourceID] then -- Skip existing sources
				local isInfoReady, canCollect = C_TransmogCollection.PlayerCanCollectSource( sourceID );
				--
				if isInfoReady and canCollect then
					local categoryID,appearanceID,_,_,sourceCollected,itemLink = C_TransmogCollection.GetAppearanceSourceInfo( sourceID );
					if categoryID ~= 6 then -- Exclude TABARDSLOT
						-- Appearance
						if not NS.appearanceCollection.appearances[appearanceID] then
							local sets = C_TransmogSets.GetSetsContainingSourceID( sourceID );
							local belongsToSet = #sets > 0;
							--
							local appearanceCollected = sourceCollected;
							if not sourceCollected then
								local sources = C_TransmogCollection.GetAllAppearanceSources( appearanceID );
								if sources then -- You never know, this API is wonky sometimes
									for i = 1, #sources do
										local _,_,_,_,isCollected = C_TransmogCollection.GetAppearanceSourceInfo( sources[i] );
										if isCollected then
											appearanceCollected = true;
											break; -- Stop ASAP
										end
									end
								end
							end
							NS.appearanceCollection.appearances[appearanceID] = { belongsToSet, appearanceCollected };
						end
						-- Source
						NS.appearanceCollection.sources[sourceID] = { appearanceID, sourceCollected };
						-- ItemID
						local itemId = tonumber( string.match( itemLink, "item:(%d+):" ) );
						local itemIdKey = NS.FindKeyByField( NS.appearanceItemIds, 1, itemId );
						if not itemIdKey then
							NS.appearanceItemIds[#NS.appearanceItemIds + 1] = { itemId, categoryID };
						end
					end
				elseif not isInfoReady then
					return "retry";
				end
			end
		end,
		EndBatchFunction = function( data, dataNum )
			NS.StatusFrame_Message( string.format( L["%s items remaining..."], HIGHLIGHT_FONT_COLOR_CODE .. ( #data - dataNum ) .. FONT_COLOR_CODE_CLOSE ) );
		end,
		CompleteFunction = function()
			if not NS.db["live"] then
				NS.appearanceCollection.getAllReady = true;
			end
			NS.JumbotronFrame_Message( L["Shopping"] );
			self:ImportShopData();
		end,
	} );
end
--
function NS.scan:ImportShopData()
	local data = NS.db["live"] and NS.auction.data.live.itemIds or NS.db["getAllScan"][NS.realmName]["data"]["itemIds"];
	local itemIds = ( NS.mode == "MOUNTS" and NS.mountItemIds ) or ( NS.mode == "PETS" and NS.petItemIds ) or ( NS.mode == "TOYS" and NS.toyItemIds ) or ( NS.mode == "APPEARANCES" and NS.appearanceItemIds ) or ( NS.mode == "RECIPES" and NS.recipeItemIds );
	--
	local itemNum,itemId,category,speciesID,appearanceID,petLevel,sourceID,skillLevel,auctionNum,auctionBatchNum,auctionBatchSize,getAppearanceAttempts,getAppearanceAttemptsMax,NextItem,NextAuction,AdvanceBatch,AddToGroup,GetAppearance;
	--
	AddToGroup = function()
		if self.status ~= "scanning" then return end
		local groupId = ( NS.mode == "MOUNTS" and itemId ) or ( NS.mode == "PETS" and ( ( NS.db["modeFilters"][NS.mode][NS.modeFilters[5][1][1]] and speciesID ) or ( itemId == 82800 and data[itemId][auctionNum][2] ) or itemId ) ) or
		--[[continued]]( NS.mode == "TOYS" and itemId ) or ( NS.mode == "APPEARANCES" and ( NS.shopAppearancesBy == "appearance" and appearanceID or sourceID ) ) or ( NS.mode == "RECIPES" and itemId ); -- 82800 is Pet Cage for Battle Pets, misc(5), Group By Species(1), key(1), itemLink(2)
		local groupKey = NS.AuctionDataGroups_FindGroupKey( groupId );
		if not groupKey then
			groupKey = #NS.auction.data.groups + 1;
			NS.auction.data.groups[groupKey] = {
				groupId,		-- [1] itemId or speciesID or itemLink or appearanceID or sourceID
				"",				-- [2] itemName
				category,		-- [3] category
				0,				-- [4] itemPrice
				{},				-- [5] auctions
				0,				-- [6] lvl
				0,				-- [7] pctItemValue
				false,			-- [8] recipe - requiresProfession(Level) <<< SET AFTERWARDS WHEN NECESSARY IN FILTER GROUPS >>>
			};
		end
		-- Add data to auction data groups
		NS.auction.data.groups[groupKey][5][#NS.auction.data.groups[groupKey][5] + 1] = CopyTable( data[itemId][auctionNum] ); -- Add to auctions(5)
		NS.auction.data.groups[groupKey][5][#NS.auction.data.groups[groupKey][5]][6] = itemId; -- Add itemId(6) to auction
		NS.auction.data.groups[groupKey][5][#NS.auction.data.groups[groupKey][5]][7] = category; -- Add category(7) to auction
		NS.auction.data.groups[groupKey][5][#NS.auction.data.groups[groupKey][5]][8] = ( NS.mode == "PETS" and speciesID ) or ( NS.mode == "APPEARANCES" and appearanceID ) or nil; -- Add speciesID(8) or appearanceID(8) to auction
		NS.auction.data.groups[groupKey][5][#NS.auction.data.groups[groupKey][5]][9] = ( NS.mode == "PETS" and petLevel ) or ( NS.mode == "APPEARANCES" and sourceID ) or ( NS.mode == "RECIPES" and skillLevel ) or nil; -- Add petLevel(9) or sourceID(9) or skillLevel(9) to auction
		return AdvanceBatch();
	end
	--
	AdvanceBatch = function()
		auctionNum = auctionNum + 1;
		if auctionBatchNum == auctionBatchSize then
			NS.StatusFrame_Message( string.format( L["%s remaining items..."], HIGHLIGHT_FONT_COLOR_CODE .. ( #itemIds - itemNum ) .. FONT_COLOR_CODE_CLOSE ) );
			auctionBatchNum = 1;
			return C_Timer.After( 0.001, NextAuction );
		else
			auctionBatchNum = auctionBatchNum + 1;
			return NextAuction();
		end
	end
	--
	NextAuction = function()
		if self.status ~= "scanning" then return end
		--
		if auctionNum <= #data[itemId] then
			local discard;
			-- Filter: Quality
			-- Option: Max Item Price
			-- Filter: Name
			-- Filter: Requires Level
			if not self.query.qualities[data[itemId][auctionNum][4]] then
				discard = true;
			elseif NS.db["maxItemPriceCopper"][NS.mode] ~= 0 and data[itemId][auctionNum][1] > NS.db["maxItemPriceCopper"][NS.mode] then
				discard = true;
			elseif not NS.db["live"] and self.query.searchString ~= "" and not string.find( string.lower( string.match( data[itemId][auctionNum][2], "%[([^%[%]]+)%]" ) ), self.query.searchString, nil, true ) then
				discard = true;
			elseif NS.mode ~= "PETS" and not NS.db["modeFilters"][NS.mode][NS.modeFilters[5][1][1]] and data[itemId][auctionNum][5] > NS.linkLevel then -- misc(5), requiresLevel(1), key(1), requiresLevel(5)
				discard = true;
			end
			-- MODE SPECIFIC
			if NS.mode == "MOUNTS" then
				-- Filter: Not Collected, Collected
				if not discard and NS.mountCollection[itemId] and ( ( NS.mountCollection[itemId] == 0 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][1][1]] ) or ( NS.mountCollection[itemId] > 0 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][2][1]] ) ) then -- collected(3), Not Collected(1)/Collected(2), key(1)
					discard = true;
				end
			elseif NS.mode == "PETS" then
				if not discard then
					if itemId == 82800 then
						-- Battle Pet
						local _;
						_,speciesID,petLevel = strsplit( ":", data[itemId][auctionNum][2] ); -- battlepet:0:speciesID:level:breedQuality:maxHealth:power:speed:customName
						speciesID,petLevel = tonumber( speciesID ), tonumber( petLevel );
					else
						-- Companion Pet
						speciesID,petLevel = NS.petInfo[itemId][1], 1;
					end
					-- Filter: category
					category = AuctionCategories[10].subCategories[select( 3, C_PetJournal.GetPetInfoBySpeciesID( speciesID ) )].name;
					if not NS.db["modeFilters"][NS.mode][category] then
						discard = true;
					end
				end
				-- Filter: collected
				if not discard then
					local collected,collectedMax;
					if not NS.petCollection[speciesID] then
						collected,collectedMax = C_PetJournal.GetNumCollectedInfo( speciesID );
						NS.petCollection[speciesID] = { collected, collectedMax };
					else
						collected,collectedMax = unpack( NS.petCollection[speciesID] );
					end
					if collected == 0 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][1][1]] then -- collected(3), Collected (0/3)(1), key(1)
						discard = true;
					elseif collected > 0 and collected < collectedMax and not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][2][1]] then -- collected(3), Collected (1-2/3)(2), key(1)
						discard = true;
					elseif collected == collectedMax and not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][3][1]] then -- collected(3), Collected (3/3)(3), key(1)
						discard = true;
					end
				end
				-- Filter: petLevels
				if not discard then
					if petLevel <= 10 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[4][1][1]] then -- petLevels(4), Level 1-10(1), key(1)
						discard = true;
					elseif petLevel >= 11 and petLevel <= 15 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[4][2][1]] then -- petLevels(4), Level 11-15(2), key(1)
						discard = true;
					elseif petLevel >= 16 and petLevel <= 20 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[4][3][1]] then -- petLevels(4), Level 16-20(3), key(1)
						discard = true;
					elseif petLevel >= 21 and petLevel <= 24 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[4][4][1]] then -- petLevels(4), Level 21-24(4), key(1)
						discard = true;
					elseif petLevel == 25 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[4][5][1]] then -- petLevels(4), Level 25(5), key(1)
						discard = true;
					end
				end
			elseif NS.mode == "TOYS" then
				-- Filter: Not Collected, Collected
				if not discard and NS.toyCollection[itemId] and ( ( NS.toyCollection[itemId] == 0 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][1][1]] ) or ( NS.toyCollection[itemId] > 0 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][2][1]] ) ) then -- collected(3), Not Collected(1)/Collected(2), key(1)
					discard = true;
				end
			elseif NS.mode == "APPEARANCES" then
				-- Filter: itemRequiresLevels
				if not discard then
					local itemRequiresLevel = data[itemId][auctionNum][5]; -- requiresLevel(5)
					--
					if itemRequiresLevel <= 60 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[4][1][1]] then -- itemRequiresLevels(4), Level 1-60(1), key(1)
						discard = true;
					elseif itemRequiresLevel >= 61 and itemRequiresLevel <= 70 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[4][2][1]] then -- itemRequiresLevels(4), Level 61-70(2), key(1)
						discard = true;
					elseif itemRequiresLevel >= 71 and itemRequiresLevel <= 80 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[4][3][1]] then -- itemRequiresLevels(4), Level 71-80(3), key(1)
						discard = true;
					elseif itemRequiresLevel >= 81 and itemRequiresLevel <= 85 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[4][4][1]] then -- itemRequiresLevels(4), Level 81-85(4), key(1)
						discard = true;
					elseif itemRequiresLevel >= 86 and itemRequiresLevel <= 90 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[4][5][1]] then -- itemRequiresLevels(4), Level 86-90(5), key(1)
						discard = true;
					elseif itemRequiresLevel >= 91 and itemRequiresLevel <= 100 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[4][6][1]] then -- itemRequiresLevels(4), Level 91-100(6), key(1)
						discard = true;
					elseif itemRequiresLevel >= 101 and itemRequiresLevel <= 110 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[4][7][1]] then -- itemRequiresLevels(4), Level 101-110(7), key(1)
						discard = true;
					elseif itemRequiresLevel >= 111 and itemRequiresLevel <= 120 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[4][8][1]] then -- itemRequiresLevels(4), Level 111-120(8), key(1)
						discard = true;
					end
				end
				-- Filters: Not Collected, Collected
				if not discard then
					appearanceID, sourceID = data[itemId][auctionNum][6], data[itemId][auctionNum][7]; -- appearanceID(6), sourceID(7)
					if not NS.appearanceCollection.appearances[appearanceID] then
						discard = true;
					elseif not NS.appearanceCollection.appearances[appearanceID][2] then -- isCollected(2)
						-- Filter: Not Collected
						if not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][1][1]] then
							discard = true;
						end
					else
						-- Filter: Collected - Unknown Sources
						if not NS.appearanceCollection.sources[sourceID][2] and not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][2][1]] then
							discard = true;
						-- Filter: Collected - Known Sources
						elseif NS.appearanceCollection.sources[sourceID][2] and not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][3][1]] then
							discard = true;
						end
					end
				end
				-- Filter: Non-set Items
				if not discard and not NS.db["modeFilters"][NS.mode][NS.modeFilters[5][3][1]] and not NS.appearanceCollection.appearances[appearanceID][1] then -- misc(5), nonsetItems(3), key(1)
					discard = true;
				end
			elseif NS.mode == "RECIPES" then
				skillLevel = NS.recipeInfo[itemId][4]; -- skillLevel(4)
				if not discard then
					-- Filter: Not Collected, Collected
					if NS.recipeCollection[itemId] and ( ( NS.recipeCollection[itemId] == 0 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][1][1]] ) or ( NS.recipeCollection[itemId] > 0 and not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][2][1]] ) ) then -- collected(3), Not Collected(1)/Collected(2), key(1)
						discard = true;
					-- Filter: Requires Profession Specialization
					elseif not NS.db["modeFilters"][NS.mode][NS.modeFilters[5][3][1]] and NS.recipeInfo[itemId][5] --[[spellID]] and not IsPlayerSpell( NS.recipeInfo[itemId][5] ) then -- misc(5), requiresProfessionSpec(5), key(1), requiresAbility(5) x 2
						discard = true;
					-- Remove non-usable class-specific recipes
					elseif NS.recipeInfo[itemId][6] and not NS.FindKeyByValue( NS.recipeInfo[itemId][6], NS.playerClassID ) then -- allowableClasses(6)
						discard = true;
					end
				end
			end
			-- ALL MODES
			-- Filter: Crafted by a Profession
			if not discard and not NS.db["modeFilters"][NS.mode][NS.modeFilters[6][1][1]] then -- craftedByProfession(6), key(1), key(1)
				if NS.mode == "PETS" and itemId == 82800 then
					for companionPetId, companionPetInfo in pairs( NS.petInfo ) do
						if companionPetInfo[1] == speciesID then -- speciesID(1)
							if NS.craftedItems[companionPetId] then
								discard = true; -- Craftable Battle Pet? It is if it matches a craftable Companion Pet by speciesID
							end
							break;
						end
					end
				elseif NS.craftedItems[itemId] then
					discard = true;
				end
			end
			-- Discard?
			if not discard then
				return AddToGroup();
			else
				return AdvanceBatch();
			end
		else
			itemNum = itemNum + 1;
			return NextItem();
		end
	end
	--
	NextItem = function()
		if self.status ~= "scanning" then return end
		--
		if itemNum <= #itemIds then
			itemId = NS.mode == "APPEARANCES" and itemIds[itemNum][1] or itemIds[itemNum];
			category =
			--[[continued]]( NS.mode == "MOUNTS" and AuctionCategories[12].subCategories[5].name ) or
			--[[continued]]( NS.mode == "PETS" and "tbd" ) or
			--[[continued]]( NS.mode == "TOYS" and AuctionCategories[NS.toyInfo[itemId][1]].subCategories[NS.toyInfo[itemId][2]].name .. " (" .. AuctionCategories[NS.toyInfo[itemId][1]].name .. ")" ) or
			--[[continued]]( NS.mode == "APPEARANCES" and NS.appearanceCollection.categoryNames[itemIds[itemNum][2]] ) or
			--[[continued]]( NS.mode == "RECIPES" and NS.skills.name[NS.skills[NS.recipeInfo[itemId][2]]] );
			if
			-- Filter: Category
			-- Filter: itemId in data?
			--
			-- Mounts: no categories, Pets: categories are determined later, but don't let Companion Pets thru if not checked
			-- Toys, Appearances: simply category check
			-- Recipes: category check plus profession (category) must be known by player
			-- Lastly, check the data to see if the item is present in our auction data
			--[[continued]]( NS.mode == "MOUNTS" or ( NS.mode == "PETS" and ( itemId == 82800 or NS.db["modeFilters"][NS.mode][NS.modeFilters[2][#NS.modeFilters[2]][1]] ) ) or
			--[[continued]]( NS.mode == "TOYS" and NS.db["modeFilters"][NS.mode][category] ) or
			--[[continued]]( NS.mode == "APPEARANCES" and NS.db["modeFilters"][NS.mode][category] ) or
			--[[continued]]( NS.mode == "RECIPES" and NS.db["modeFilters"][NS.mode][category] and NS.playerProfessions[NS.skills[category]] ) ) and
			--[[continued]]data[itemId] then -- categories(2), Companion Pets(2), key(1)
				-- Start auctions for item
				auctionNum = 1;
				return NextAuction();
			else
				-- Skip item: category checkbox not checked or no auctions matching the itemId
				itemNum = itemNum + 1;
				return NextItem();
			end
		else
			-- ALL ITEMS COMPLETE
			for groupKey = 1, #NS.auction.data.groups do
				NS.Sort( NS.auction.data.groups[groupKey][5], 1, "ASC" ); -- auctions(5) by itemPrice(1) in ASC
				NS.AuctionDataGroups_UpdateGroup( groupKey ); -- Update itemName, itemPrice, and Lvl to match first auction in group
			end
			--
			NS.StatusFrame_Message( L["Filtering, one moment please..."] );
			self:FilterGroups( function() self:Complete() end );
		end
	end
	--
	itemNum = 1;
	auctionBatchNum = 1;
	auctionBatchSize = 50;
	NextItem();
end
--
function NS.scan:FilterGroups( OnComplete, groupKey )
	--
	-- This method runs a nested series of the following function:
	-- NS.AuctionDataGroups_Filter( groupKey, FilterFunction, OnGroupsComplete, filterNotMatch, filter )
	--
	-- The job of this function is to match (or not match) groups and filter them out of the auction groups.
	--
	---------------------------------------------------------------------------------
	-- #1 Filter: Requires Profession (Level) --- looks for red crafting professions
	---------------------------------------------------------------------------------
	NS.AuctionDataGroups_Filter(
		groupKey,

		-- #1 FilterFunction
		function( group ) return NS.FindInTooltip( group[5][1][2], { r=255, g=32, b=32 }, NS.craftingProfessions, ( NS.mode == "RECIPES" and 1 or 4 ) ); --[[ auctions(5), first auction(1), itemLink(2) ]] end,

		-- #1 OnGroupsComplete
		function( filterGroupIds )

			-- #1 filter "analyze" - mark red profession recipe groups to color lvl
			if NS.mode == "RECIPES" and filterGroupIds then
				for i = 1, #filterGroupIds do
					 local groupKey = NS.AuctionDataGroups_FindGroupKey( filterGroupIds[i] );
					 NS.auction.data.groups[groupKey][8] = true;
				end
			end

			--------------------------------------------------------------------
			-- #2 Filter: Requires Riding Skill --- looks for red riding skills
			--------------------------------------------------------------------
			NS.AuctionDataGroups_Filter(
				groupKey,

				-- #2 FilterFunction
				function( group ) return NS.FindInTooltip( group[5][1][2], { r=255, g=32, b=32 }, NS.ridingSpells, 4 ); --[[ auctions(5), first auction(1), itemLink(2) ]] end,

				-- #2 OnGroupsComplete
				function()

					-- <<< THE END >>>
					return OnComplete();
				end,

				-- #2 filterNotMatch
				false,

				-- #2 filter
				( NS.mode == "MOUNTS" and not NS.db["modeFilters"][NS.mode][NS.modeFilters[5][3][1]] or false ) -- misc(5), Requires Riding Skill(3), key(1)
			);

		end,

		-- #1 filterNotMatch
		false,

		-- #1 filter
		( NS.mode ~= "PETS" and ( not NS.db["modeFilters"][NS.mode][NS.modeFilters[5][2][1]] or ( NS.mode == "RECIPES" and "analyze" ) or false ) ) -- misc(5), requiresProfession(2), key(1)
	);
end
--
function NS.scan:Complete( cancelMessage )
	if self.status ~= "scanning" then return end -- Scan interrupted
	--
	if self.type == "SELECT" then
		-- SELECT: If not found, remove auction. Otherwise, set status to "Selected" and activate buyout frame
		if not self.query.auction.found then
			-- NOT FOUND
			NS.Print( string.format( L["%s for %s is no longer available and has been removed"], self.query.auction[2], NS.MoneyToString( self.query.auction[1] ) ) ); -- itemLink(2), itemPrice(1)
			return NS.AuctionGroup_AuctionMissing( self.query.auction.groupKey, function()
				-- OnMessageOnly
				NS.AuctionSortButtons_Action( "Enable" );
				NS.disableFlyoutChecks = false;
				AuctionFrameCollectionShop_FlyoutPanel_ScrollFrame:Update();
				AuctionFrameCollectionShop_FlyoutPanel_NameSearchEditbox:Enable();
				AuctionFrameCollectionShop_LiveCheckButton:Enable();
				AuctionFrameCollectionShop_ScanButton:Reset();
				AuctionFrameCollectionShop_ShopButton:Reset();
			end );
		else
			-- FOUND
			self.status = "selected";
			if NS.mode ~= "TOYS" then
				local dressableRecipe = ( NS.mode == "RECIPES" and IsDressableItem( self.query.auction[2] ) );
				-- Hide Flyout Panel and Open or Close DressUpFrame
				if NS.mode ~= "RECIPES" or dressableRecipe then
					AuctionFrameCollectionShop_FlyoutPanel:Hide();
					if not DressUpFrame:IsShown() then
						if NS.mode == "APPEARANCES" or NS.mode == "RECIPES" then
							DressUpFrame_Show(DressUpFrame); -- Required to load the "player" mode for the dress up scene
						end
					end
				elseif NS.mode == "RECIPES" and DressUpFrame:IsShown() then
					HideUIPanel( DressUpFrame );
					AuctionFrameCollectionShop_FlyoutPanel:Reset();
				end
				-- DressUp -- Delay to allow frame to initialize
				C_Timer.After( 0.001, function()					
					if NS.mode == "MOUNTS" then
						DressUpMountLink( self.query.auction[2] ); -- itemLink(2)
					elseif NS.mode == "PETS" then
						DressUpBattlePetLink( self.query.auction[2] ); -- itemLink(2)
					elseif NS.mode == "APPEARANCES" or ( NS.mode == "RECIPES" and dressableRecipe ) then
						if NS.db["undressCharacter"] then
							DressUpFrame.ModelScene:GetPlayerActor():Undress();
							PlaySound( 798 ); -- gsTitleOptionOK: Keeps the sound consistent with the ResetButton click below
						else
							DressUpFrameResetButton:Click(); -- ^^
						end
						DressUpVisual( self.query.auction[2] ); -- itemLink(2)
					end
				end );
			end
			AuctionFrameCollectionShop_DialogFrame_BuyoutFrame_SelectedOwnerEditbox:SetText( ( self.selectedOwner and self.selectedOwner or L["Unknown"] ) );
			AuctionFrameCollectionShop_DialogFrame_BuyoutFrame_SelectedOwnerLabel:Show();
			AuctionFrameCollectionShop_DialogFrame_BuyoutFrame_SelectedOwnerEditbox:Show();
			NS.BuyoutFrame_Activate();
			AuctionFrameCollectionShop_BuyAllButton:Enable();
		end
	elseif self.type == "SHOP" then
		-- SHOP: Clicked the "Shop" button
		self.status = "ready";
		wipe( self.query.queue );
		wipe( NS.auction.data.live.itemIds );
		wipe( NS.auction.data.live.appearanceSources );
		--
		collectgarbage( "collect" );
		NS.AuctionDataGroups_Sort();
		AuctionFrameCollectionShop_JumbotronFrame:Hide();
		AuctionFrameCollectionShop_ScrollFrame:Update();
		--
		if #NS.auction.data.groups > 0 then
			NS.StatusFrame_Message( NS.SELECT_AN_AUCTION() );
			AuctionFrameCollectionShop_BuyAllButton:Enable();
		else
			NS.StatusFrame_Message( cancelMessage or L["No auctions were found that matched your settings"] );
		end
	elseif self.type == "GETALL" then
		-- GETALL: Clicked the "Scan" button
		self.status = "ready";
		collectgarbage( "collect" );
		if ( C_AuctionHouse.IsThrottledMessageSystemReady() ) then
			C_AuctionHouse.ReplicateItems( "CLEAR_BROWSE_FRAME_RESULTS", nil, nil, 0, false, nil, false, false ); -- Prevents WoW from crashing on subsequent queries, not sure why
		end
		NS.JumbotronFrame_Message( L["Auction House scan complete. Ready"] );
		NS.StatusFrame_Message( string.format( L["Blizzard allows a GetAll scan once every %s. Press \"Shop\""], RED_FONT_COLOR_CODE .. L["15 min"] .. FONT_COLOR_CODE_CLOSE ) );
		NS.UpdateTimeSinceLastScan();
	end
	--
	NS.AuctionSortButtons_Action( "Enable" );
	NS.disableFlyoutChecks = false;
	AuctionFrameCollectionShop_FlyoutPanel_ScrollFrame:Update();
	AuctionFrameCollectionShop_FlyoutPanel_NameSearchEditbox:Enable();
	AuctionFrameCollectionShop_LiveCheckButton:Enable();
	AuctionFrameCollectionShop_ScanButton:Reset();
	AuctionFrameCollectionShop_ShopButton:Reset();
end
--
function NS.scan:OnChatMsgSystem( ... ) -- CHAT_MSG_SYSTEM
	local arg1 = ...;
	if not arg1 then return end
	if arg1 == string.format( ERR_AUCTION_WON_S, NS.auction.data.groups[self.query.auction.groupKey][2] ) then -- itemName(2)
		-- You won an auction for %s
		self.triggerAuctionWon = true; -- Used in handler for event below to trigger process for after "You won an auction for %s"
		CollectionShopEventsFrame:RegisterEvent( "ITEM_SEARCH_RESULTS_UPDATED" );
		CollectionShopEventsFrame:UnregisterEvent( "CHAT_MSG_SYSTEM" );
	end
end
--
function NS.scan:OnUIErrorMessage( ... ) -- UI_ERROR_MESSAGE
	local arg2 = select( 2, ... );
	if not arg2 then return end
	if self.status ~= "buying" then
		-- Not Buying
		if arg2 == ERR_AUCTION_DATABASE_ERROR then
			NS.Print( RED_FONT_COLOR_CODE .. arg2 .. FONT_COLOR_CODE_CLOSE );
			return NS.Reset(); -- Reset on Internal Auction Error
		else
			return -- Ignore errors unexpected when not buying an auction
		end
	elseif (
		-- Buying
		arg2 ~= ERR_AUCTION_DATABASE_ERROR and
		arg2 ~= ERR_ITEM_NOT_FOUND and
		arg2 ~= ERR_AUCTION_HIGHER_BID and
		arg2 ~= ERR_AUCTION_BID_OWN and
		arg2 ~= ERR_NOT_ENOUGH_MONEY and
		arg2 ~= ERR_RESTRICTED_ACCOUNT and	-- Starter Edition account
		arg2 ~= ERR_ITEM_MAX_COUNT ) then
		return -- Ignore errors unexpected during buying an auction
	end
	--
	-- Handle error expected when buying an auction
	--
	CollectionShopEventsFrame:UnregisterEvent( "CHAT_MSG_SYSTEM" );
	--
	if arg2 == ERR_ITEM_NOT_FOUND or arg2 == ERR_AUCTION_HIGHER_BID or arg2 == ERR_AUCTION_BID_OWN then
		if arg2 == ERR_ITEM_NOT_FOUND or arg2 == ERR_AUCTION_HIGHER_BID then
			NS.Print( RED_FONT_COLOR_CODE .. L["That auction is no longer available and has been removed"] .. FONT_COLOR_CODE_CLOSE );
		elseif arg2 == ERR_AUCTION_BID_OWN then
			NS.Print( RED_FONT_COLOR_CODE .. L["That auction belonged to a character on your account and has been removed"] .. FONT_COLOR_CODE_CLOSE );
		end
		--
		return NS.AuctionGroup_AuctionMissing( self.query.auction.groupKey, function()
			-- OnMessageOnly
			NS.AuctionSortButtons_Action( "Enable" );
			AuctionFrameCollectionShop_ScanButton:Reset();
			AuctionFrameCollectionShop_ShopButton:Enable();
		end );
	else
		self.status = "ready";
		NS.StatusFrame_Message( arg2 );
		AuctionFrameCollectionShop_BuyAllButton:Enable();
	end
	--
	NS.AuctionSortButtons_Action( "Enable" );
	AuctionFrameCollectionShop_ScanButton:Reset();
	AuctionFrameCollectionShop_ShopButton:Enable();
end
--
function NS.scan:AfterAuctionWon()
	-- Update buyouts and money spent
	NS.numAuctionsWon = NS.numAuctionsWon + 1;
	NS.copperAuctionsWon = NS.copperAuctionsWon + self.query.auction[1]; -- itemPrice(1)
	self.query.auction.modeNum = NS.modeNums[NS.mode];
	table.insert( NS.auctionsWon, CopyTable( self.query.auction ) ); -- auction
	-- Remove ONE matching auction from GetAll scan data
	if not NS.db["live"] then
		local scanAuctions = NS.db["getAllScan"][NS.realmName]["data"]["itemIds"][self.query.auction[6]];
		for auction = 1, #scanAuctions do
			if #NS.auction.data.groups == 0 then return end -- Check for Reset
			-- Match by itemPrice(1) and itemLink(2)
			if scanAuctions[auction][1] == self.query.auction[1] and ( self.query.auction[6] == 82800 and scanAuctions[auction][2] or NS.NormalizeItemLink( scanAuctions[auction][2] ) ) == self.query.auction[2] then -- Don't waste precious time here normalizing a battlepet: itemLink
				table.remove( scanAuctions, auction );
				break; -- Just ONE
			end
		end
		if #scanAuctions == 0 then
			scanAuctions = nil; -- Remove empty itemId from scan data
		end
	end
	-- Update collection counts and decide what to remove from Groups
	local removeGroup,removeSpecies;
	if NS.mode == "MOUNTS" then
		NS.mountCollection[self.query.auction[6]] = 1; -- itemId(6), collected(1)
		if not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][2][1]] then -- collected(3), Collected(2), key(1)
			removeGroup = true;
		end
	elseif NS.mode == "PETS" then
		NS.petCollection[self.query.auction[8]][1] = math.min( ( NS.petCollection[self.query.auction[8]][1] + 1 ), NS.petCollection[self.query.auction[8]][2] ); -- speciesID(8), collected(1), collectedMax(2)
		local collected,collectedMax = unpack( NS.petCollection[self.query.auction[8]] );
		if ( collected < collectedMax and not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][2][1]] ) or ( collected == collectedMax and not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][3][1]] ) then -- collected(3), Collected (1-2/3)(2)/Collected (3/3)(3), key(1)
			removeSpecies = true;
		end
	elseif NS.mode == "TOYS" then
		NS.toyCollection[self.query.auction[6]] = 1; -- item(6), collected(1)
		if not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][2][1]] then -- collected(3), Collected(2), key(1)
			removeGroup = true;
		end
	elseif NS.mode == "APPEARANCES" then
		NS.appearanceCollection.appearances[self.query.auction[8]][2] = true; -- appearanceID(8), isCollected(2)
		NS.appearanceCollection.sources[self.query.auction[9]][2] = true; -- sourceID(9), isCollected(2)
		if NS.shopAppearancesBy == "appearance" or not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][3][1]] then -- collected(3), Collected - Known Sources(3), key(1)
			removeGroup = true;
		end
	elseif NS.mode == "RECIPES" then
		NS.recipeCollection[self.query.auction[6]] = 1; -- itemId(6), collected(1)
		if not NS.db["modeFilters"][NS.mode][NS.modeFilters[3][2][1]] then -- collected(3), Collected(2), key(1)
			removeGroup = true;
		end
	end
	-- Remove Group(s) or Auction
	local groupId; -- If Auction removed instead of Group, we need groupKey to reselect
	if removeGroup or ( removeSpecies and NS.db["modeFilters"][NS.mode][NS.modeFilters[5][1][1]] ) then -- misc(5), Group By Species(1), key(1)
		NS.AuctionDataGroups_RemoveGroup( self.query.auction.groupKey );
	elseif removeSpecies and not NS.db["modeFilters"][NS.mode][NS.modeFilters[5][1][1]] then -- misc(5), Group By Species(1), key(1)
		local groupKey = 1;
		while groupKey <= #NS.auction.data.groups do
			if NS.auction.data.groups[groupKey][5][1][8] == self.query.auction[8] then -- auctions(5), first auction(1), speciesID(8)
				NS.AuctionDataGroups_RemoveGroup( groupKey );
			else
				groupKey = groupKey + 1;
			end
		end
	elseif NS.AuctionDataGroups_RemoveAuction( self.query.auction.groupKey ) == "auction" then
		groupId = NS.auction.data.groups[NS.scan.query.auction.groupKey][1];
	end
	--
	NS.AuctionGroup_Deselect();
	if #NS.auction.data.groups > 0 then
		-- More groups exist
		if NS.buyAll then
			return NS.AuctionGroup_OnClick( 1 );
		elseif groupId then
			NS.AuctionDataGroups_Sort();
			NS.NextAdjustScroll = true;
			return NS.AuctionGroup_OnClick( NS.AuctionDataGroups_FindGroupKey( groupId ) );
		else
			NS.StatusFrame_Message( NS.SELECT_AN_AUCTION() );
			AuctionFrameCollectionShop_BuyAllButton:Enable();
		end
	else
		-- No groups exist
		NS.StatusFrame_Message( L["No additional auctions matched your settings"] );
		AuctionFrameCollectionShop_BuyAllButton:Reset();
	end
	--
	NS.AuctionSortButtons_Action( "Enable" );
	AuctionFrameCollectionShop_ScanButton:Reset();
	AuctionFrameCollectionShop_ShopButton:Enable();
end
--------------------------------------------------------------------------------------------------------------------------------------------
-- Mounts, Toys, & Appearances
--------------------------------------------------------------------------------------------------------------------------------------------
NS.UpdateMountCollection = function()
	local addonMountsTotal = NS.Count( NS.mountInfo );
	local addonmountsUpdated = 0;
	--
	local mountIDs = C_MountJournal.GetMountIDs();
	for i = 1, #mountIDs do
		local _,spellID,_,_,_,_,_,_,_,_,isCollected = C_MountJournal.GetMountInfoByID( mountIDs[i] );
		local creatureDisplayID = C_MountJournal.GetMountInfoExtraByID( mountIDs[i] );
		local itemId = NS.PairsFindKeyByField( NS.mountInfo, 2, spellID );
		if itemId then
			NS.mountCollection[itemId] = isCollected and 1 or 0;
			addonmountsUpdated = addonmountsUpdated + 1;
			if addonmountsUpdated == addonMountsTotal then
				break;
			end
		end
	end
	NS.Reset();
end
--
NS.UpdateToyCollection = function()
	for itemId,_ in pairs( NS.toyInfo ) do
		NS.toyCollection[itemId] = PlayerHasToy( itemId ) and 1 or 0;
	end
	NS.Reset();
end
--
NS.UpdateRecipeCollection = function()
	for itemId,_ in pairs( NS.recipeInfo ) do
		NS.recipeCollection[itemId] = IsPlayerSpell( NS.recipeInfo[itemId][1] ) and 1 or 0; -- spellID (1)
	end
	NS.Reset();
end
--
NS.GetAppearanceSourceInfo = function( itemLink )
    local _,_,_,invType = GetItemInfoInstant( itemLink );
    local slotId = NS.invTypeToSlotId[invType];
	if NS.linkSpecID == 72 and invType == "INVTYPE_2HWEAPON" and GetInventoryItemID( "player", slotId ) then
		slotId = 17; -- Fury Warrior requires 2H Weapons in the "Off Hand" unless no weapon is equipped in the "Main Hand"
	end
    NS.Model:Undress();
    NS.Model:TryOn( itemLink, slotId );
    local sourceID = NS.Model:GetSlotTransmogSources( slotId );
    if sourceID then
		local _,appearanceID = C_TransmogCollection.GetAppearanceSourceInfo( sourceID );
        return appearanceID, sourceID;
    else
		return nil;
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
-- Slash Commands
--------------------------------------------------------------------------------------------------------------------------------------------
NS.SlashCmdHandler = function( cmd )
	if not NS.initialized then return end
	--
	if cmd == "buyoutbuttonclick" and NS.IsTabShown() then
		AuctionFrameCollectionShop_DialogFrame_BuyoutFrame_BuyoutButton:Click();
		return; -- Stop function
	end
	--
	if NS.options.MainFrame:IsShown() then
		NS.options.MainFrame:Hide();
	elseif cmd == "" or cmd == "options" then
		NS.options.MainFrame:ShowTab( 1 );
	elseif cmd == "buyouts" then
		NS.options.MainFrame:ShowTab( 2 );
	elseif cmd == "getallscandata" then
		NS.options.MainFrame:ShowTab( 3 );
	elseif cmd == "help" then
		NS.options.MainFrame:ShowTab( 4 );
	elseif cmd == "recipes" then
		local numRecipes = NS.Count( NS.recipeInfo );
		local numWithSkill, numWithoutSkill = 0, 0;
		for _,info in pairs( NS.recipeInfo ) do
			if NS.skills[info[2]] then
				numWithSkill = numWithSkill + 1;
			else
				numWithoutSkill = numWithoutSkill + 1;
				NS.Print( numWithoutSkill .. '. ' .. info[1] .. ', ' .. info[2] .. ', ' .. info[3] .. ', ' .. info[4] .. ': ' .. GetSpellInfo( info[1] ) );
			end
		end
		NS.Print( 'Recipes: ' .. numRecipes .. ' (' .. numWithSkill .. ' with skill, ' .. numWithoutSkill .. ' without skill)' );
	elseif cmd == "data" then
		if NS.db["getAllScan"][NS.realmName] then
			local data = NS.db["getAllScan"][NS.realmName]["data"];
			local uniqueItemIds = NS.Count( data["itemIds"] );
			local auctions = 0;
			local appearanceSources = #data["appearanceSources"];
			for itemId,_ in pairs( data["itemIds"] ) do
				auctions = NS.Count( data["itemIds"][itemId] ) + auctions;
			end
			NS.Print( GREEN_FONT_COLOR_CODE .. string.format( L["Realm: %s, UniqueItemIds: %d, Auctions: %d, Appearance Sources: %d"], NS.realmName, uniqueItemIds, auctions, appearanceSources ) .. FONT_COLOR_CODE_CLOSE );
		else
			NS.Print( RED_FONT_COLOR_CODE .. string.format( L["Realm: %s, No data"], NS.realmName ) .. FONT_COLOR_CODE_CLOSE );
		end
	elseif string.match( cmd, "^app" ) or string.match( cmd, "^appearance" ) then
		if not NS.IsTabShown() then
			NS.Print( string.format( L["%s auction house tab must be shown."], NS.title ) );
			return; -- STOP
		end
		local _,itemIdStringLink = strsplit( " ", strtrim( cmd ), 2 );
		if itemIdStringLink then
			NS.GetItemInfo( itemIdStringLink, function( itemName,itemLink,_,_,_,_,_,_,invType,texture )
				local itemID = itemLink and GetItemInfoInstant( itemLink ) or nil;
				--
				if not itemID then
					NS.Print( string.format( L["%s, item not found"], itemIdStringLink ) );
					return; -- STOP
				end
				--
				if not invType then
					NS.Print( string.format( L["%s, invType missing"], itemLink ) );
					return; -- STOP
				end
				--
				local slotId = NS.invTypeToSlotId[invType];
				--
				if not slotId then
					NS.Print( string.format( L["%s, slotId missing"], itemLink ) );
					return; -- STOP;
				end
				--
				local appearanceID,sourceID = NS.GetAppearanceSourceInfo( itemLink );
				--
				if not appearanceID or not sourceID then
					NS.Print( string.format( L["%s, appearanceID or sourceID missing"], itemLink ) );
					return; -- STOP
				end
				-- Reverse Lookup
				local _,rlAppearanceID,_,rlTexture = C_TransmogCollection.GetAppearanceSourceInfo( sourceID );
				--
				if appearanceID ~= rlAppearanceID or texture ~= rlTexture then
					NS.Print( string.format( L["%s, model malfunction, data mismatch"], itemLink ) );
					return; -- STOP
				end
				--
				NS.Print( string.format( L["ItemID: %s, invType: %s, slotId: %s"], itemID, invType, slotId ) );
				NS.Print( string.format( L["AppearanceID: %s, SourceID: %s, |T%s:32|t %s"], appearanceID, sourceID, texture, itemLink ) );
			end );
		else
			NS.Print( "/cs appearance [itemID] or [itemString] or [itemLink]" );
		end
	else
		NS.options.MainFrame:ShowTab( 4 );
		NS.Print( L["Unknown command, opening Help"] );
	end
end
--
SLASH_COLLECTIONSHOP1 = "/collectionshop";
SLASH_COLLECTIONSHOP2 = "/cs";
SlashCmdList["COLLECTIONSHOP"] = function( msg ) NS.SlashCmdHandler( msg ) end;
--------------------------------------------------------------------------------------------------------------------------------------------
-- CollectionShopInterfaceOptionsPanel : Interface > Addons > CollectionShop
--------------------------------------------------------------------------------------------------------------------------------------------
NS.Frame( "CollectionShopInterfaceOptionsPanel", UIParent, {
	topLevel = true,
	hidden = true,
	setPoint = { "TOPLEFT" },
	OnLoad = function( self )
		self.name = NS.title;
	end,
} );
NS.TextFrame( "Text", CollectionShopInterfaceOptionsPanel, L["Use either slash command, /cs or /collectionshop"], {
	setAllPoints = true,
	setPoint = { "TOPLEFT", 16, -16 },
	justifyV = "TOP",
} );
--------------------------------------------------------------------------------------------------------------------------------------------
-- "CollectionShop" AuctionHouseFrame Tab (AuctionFrameCollectionShop)
--------------------------------------------------------------------------------------------------------------------------------------------
NS.Blizzard_AuctionHouseUI_OnLoad = function()
	if AuctionFrameCollectionShop then return end -- Make absolute sure this code only runs once
	--
	NS.Frame( "AuctionFrameCollectionShop", UIParent, {
		template = "AuctionHouseBackgroundTemplate",
		topLevel = true,
		hidden = true,
		size = { 824 - 30, 447 + 98 - 34 }, --f:SetSize( 758, 447 ); 66 x removed from close button
		OnShow = NS.Reset,
		OnHide = NS.Reset,
		bg = { "3054898" }, -- Interface\\AuctionFrame\\AuctionHouseBackgrounds
		OnLoad = function( self )
			self.Bg:SetTexCoord( 0.2, 0.4, 0.4, 0.8 );
			self.Bg:SetPoint( "TOPLEFT", 0, -60 );
			self.Bg:SetPoint( "BOTTOMRIGHT", 0, -5 );
		end,
	} );
	NS.Model = NS.Frame( "_DressUpModel", AuctionFrameCollectionShop, {
		type = "DressUpModel",
		OnLoad = function( self )
			self:SetUnit( "player" );
		end,
	} );
	NS.GameTooltip = NS.Frame( NS.addon .. "_GameTooltip", UIParent, {
		topLevel = true,
		type = "GameTooltip",
		OnLoad = function( self )
			self:SetOwner( UIParent, "ANCHOR_NONE" );
			self:AddFontStrings(
				self:CreateFontString( "$parentTextLeft1", nil, "GameTooltipText" ),
				self:CreateFontString( "$parentTextRight1", nil, "GameTooltipText" )
			);
		end,
	} );
	NS.TextFrame( "_Title", AuctionFrameCollectionShop, "", {
		setPoint = {
			{ "TOPLEFT", 74, -24 + 12 },
			{ "RIGHT", -20, 0 },
		},
		justifyH = "CENTER",
	} );
	NS.CheckButton( "_UndressCharacterCheckButton", AuctionFrameCollectionShop, L["Undress Character"], {
		template = "InterfaceOptionsSmallCheckButtonTemplate",
		size = { 16, 16 },
		setPoint = { "RIGHT", "#sibling", "RIGHT", -130, 0 },
		tooltip = L["Show character with\nselected item only"],
		db = "undressCharacter",
	} );
	NS.TextFrame( "_MaxItemPriceFrame", AuctionFrameCollectionShop, "", {
		size = { 150, 16 },
		setPoint = { "LEFT", "$parent_Title", "LEFT", 3, 0 },
		fontObject = "GameFontHighlightSmall",
	} );
	NS.Button( "_NameSortButton", AuctionFrameCollectionShop, NAME, {
		template = "AuctionSortButtonTemplate",
		size = { 287, 19 },
		setPoint = { "TOPLEFT", 52, -40 },
		OnClick = function( self )
			NS.AuctionSortButton_OnClick( self, 2 );
		end,
	} );
	NS.Button( "_LvlSortButton", AuctionFrameCollectionShop, L["Lvl"], {
		template = "AuctionSortButtonTemplate",
		size = { 54, 19 },
		setPoint = { "TOPLEFT", "#sibling", "TOPRIGHT", -2, 0 },
		OnClick = function( self )
			NS.AuctionSortButton_OnClick( self, 6 );
		end,
	} );
	NS.Button( "_CategorySortButton", AuctionFrameCollectionShop, L["Category"], {
		template = "AuctionSortButtonTemplate",
		size = { 202, 19 },
		setPoint = { "TOPLEFT", "#sibling", "TOPRIGHT", -2, 0 },
		OnClick = function( self )
			NS.AuctionSortButton_OnClick( self, 3 );
		end,
	} );
	NS.Button( "_ItemPriceSortButton", AuctionFrameCollectionShop, L["Item Price"], {
		template = "AuctionSortButtonTemplate",
		size = { 188, 19 },
		setPoint = { "TOPLEFT", "#sibling", "TOPRIGHT", -2, 0 },
		OnClick = function( self )
			NS.AuctionSortButton_OnClick( self, 4 );
		end,
	} );
	NS.Button( "_PctItemValueSortButton", AuctionFrameCollectionShop, L["% Item Value"], {
		template = "AuctionSortButtonTemplate",
		size = { 95, 19 },
		setPoint = { "TOPLEFT", "#sibling", "TOPRIGHT", -2, 0 },
		OnClick = function( self )
			NS.AuctionSortButton_OnClick( self, 7 );
		end,
	} );
	NS.ScrollFrame( "_ScrollFrame", AuctionFrameCollectionShop, {
		size = { 733 - 19, ( 30 * 12 - 5 ) }, -- 30 x {number of rows}
		setPoint = { "TOPLEFT", "$parent_NameSortButton", "BOTTOMLEFT", 1, -5 },
		buttonTemplate = "AuctionFrameCollectionShop_ScrollFrameButtonTemplate",
		update = {
			numToDisplay = 12, -- {number of rows}
			buttonHeight = 30,
			UpdateFunction = function( sf )
				local items = NS.auction.data.groups;
				local numItems = #items;
				FauxScrollFrame_Update( sf, numItems, sf.numToDisplay, sf.buttonHeight );
				-- Next auction selected, possibly out of view
				if NS.NextAdjustScroll then
					NS.NextAdjustScroll = false;
					local maxScroll = numItems <= sf.numToDisplay and 0 or ( ( numItems - sf.numToDisplay ) * sf.buttonHeight );
					local midScrollPosition = math.floor( sf.numToDisplay / 2 );
					local vScroll = NS.scan.query.auction.groupKey <= midScrollPosition and 0 or ( ( NS.scan.query.auction.groupKey - midScrollPosition ) * sf.buttonHeight );
					sf:SetVerticalScroll( vScroll > maxScroll and maxScroll or vScroll );
				end
				--
				local offset = FauxScrollFrame_GetOffset( sf );
				-- Is selected auction in view?
				if NS.scan.status == "selected" then
					if NS.scan.query.auction.groupKey >= ( offset + 1 ) and NS.scan.query.auction.groupKey <= ( offset + sf.numToDisplay ) then
						AuctionFrameCollectionShop_DialogFrame_BuyoutFrame_BuyoutButton:Enable();
						AuctionFrameCollectionShop_DialogFrame_BuyoutFrame_CancelButton:Enable();
					else
						AuctionFrameCollectionShop_DialogFrame_BuyoutFrame_BuyoutButton:Disable();
						AuctionFrameCollectionShop_DialogFrame_BuyoutFrame_CancelButton:Disable();
					end
				end
				--
				for num = 1, sf.numToDisplay do
					local bn = sf.buttonName .. num; -- button name
					local b = _G[bn]; -- button
					local k = offset + num; -- key
					b:UnlockHighlight();
					if k <= numItems then
						local OnClick = function()
							NS.AuctionGroup_OnClick( k );
						end
						local IsHighlightLocked = function()
							if NS.scan.query.auction.groupKey and NS.scan.query.auction.groupKey == k then
								return true;
							else
								return false;
							end
						end
						b:SetScript( "OnClick", OnClick );
						_G[bn .. "_IconTexture"]:SetNormalTexture( items[k][5][1][3] ); -- auctions(5), first auction(1), texture(3)
						_G[bn .. "_IconTexture"]:SetScript( "OnEnter", function( self )
							GameTooltip:SetOwner( self, "ANCHOR_RIGHT" );
							if string.match( items[k][5][1][2], "|Hbattlepet:" ) then -- auctions(5), first auction(1), itemLink(2)
								local _,speciesID,level,breedQuality,maxHealth,power,speed,customName = strsplit( ":", items[k][5][1][2] )
								BattlePetToolTip_Show( tonumber( speciesID ), tonumber( level ), tonumber( breedQuality ), tonumber( maxHealth ), tonumber( power ), tonumber( speed ), customName );
							else
								GameTooltip:SetHyperlink( items[k][5][1][2] );
							end
							b:LockHighlight();
						end );
						_G[bn .. "_IconTexture"]:SetScript( "OnLeave", function() GameTooltip_Hide(); if not IsHighlightLocked() then b:UnlockHighlight(); end end );
						_G[bn .. "_IconTexture"]:SetScript( "OnClick", OnClick );
						_G[bn .. "_NameText"]:SetText( items[k][2] ); -- group name(2)
						_G[bn .. "_NameText"]:SetTextColor( GetItemQualityColor( items[k][5][1][4] ) ); -- auctions(5), first auction(1), quality(4)
						_G[bn .. "_LvlText"]:SetText( ( ( NS.mode ~= "PETS" and NS.mode ~= "RECIPES" and items[k][6] > NS.linkLevel ) or ( NS.mode == "RECIPES" and items[k][8] ) ) and RED_FONT_COLOR_CODE .. items[k][6] .. FONT_COLOR_CODE_CLOSE or items[k][6] ); -- group lvl(6) requiresProfession(Level)(8)
						--
						local category = items[k][3];
						if NS.mode == "MOUNTS" then
							category = ( NS.mountCollection[items[k][5][1][6]] == 0 and NS.modeColorCode .. category .. FONT_COLOR_CODE_CLOSE ) or RED_FONT_COLOR_CODE .. category .. FONT_COLOR_CODE_CLOSE; -- auctions(5), first auction(1), itemId(6)
						elseif NS.mode == "PETS" then
							local collected,collectedMax = unpack( NS.petCollection[items[k][5][1][8]] );
							category = ( collected == 0 and NS.modeColorCode .. category .. FONT_COLOR_CODE_CLOSE ) or ( collected < collectedMax and NORMAL_FONT_COLOR_CODE .. category .. FONT_COLOR_CODE_CLOSE ) or RED_FONT_COLOR_CODE .. category .. FONT_COLOR_CODE_CLOSE;
						elseif NS.mode == "TOYS" then
							category = ( NS.toyCollection[items[k][5][1][6]] == 0 and NS.modeColorCode .. category .. FONT_COLOR_CODE_CLOSE ) or RED_FONT_COLOR_CODE .. category .. FONT_COLOR_CODE_CLOSE; -- auctions(5), first auction(1), itemId(6)
						elseif NS.mode == "APPEARANCES" then
							local appearanceID, sourceID = items[k][5][1][8], items[k][5][1][9]; -- auctions(5), first auction(1), appearanceID(8), sourceID(9)
							category = ( not NS.appearanceCollection.appearances[appearanceID][2] and NS.modeColorCode .. category .. FONT_COLOR_CODE_CLOSE ) or ( not NS.appearanceCollection.sources[sourceID][2] and NORMAL_FONT_COLOR_CODE .. category .. FONT_COLOR_CODE_CLOSE ) or RED_FONT_COLOR_CODE .. category .. FONT_COLOR_CODE_CLOSE; -- isCollected(2)
						elseif NS.mode == "RECIPES" then
							category = ( NS.recipeCollection[items[k][5][1][6]] == 0 and NS.modeColorCode .. category .. FONT_COLOR_CODE_CLOSE ) or RED_FONT_COLOR_CODE .. category .. FONT_COLOR_CODE_CLOSE; -- auctions(5), first auction(1), itemId(6)
						end
						_G[bn .. "_CategoryText"]:SetText( category ); -- group category(3)
						--
						MoneyFrame_Update( bn .. "_ItemPriceSmallMoneyFrame", items[k][4] ); -- group itemPrice(4)
						--
						_G[bn .. "_PctItemValueText"]:SetText( items[k][7] == 123456789 and RED_FONT_COLOR_CODE .. L["N/A"] .. FONT_COLOR_CODE_CLOSE or math.floor( items[k][7] ) .. "%" ); -- group pctItemValue(7)
						b:Show();
						if IsHighlightLocked() then b:LockHighlight(); end
					else
						b:Hide();
					end
				end
				--
				NS.UpdateTitleText();
			end
		},
		OnLoad = function( self )
			function self:Adjust()
				NS.adjustScrollFrame = false;
				if TSM_API and NS.db["tsmItemValueSource"] ~= "" then
					NS.isPctItemValue = true;
					AuctionFrameCollectionShop_NameSortButton:SetSize( 262, 19 );
					AuctionFrameCollectionShop_CategorySortButton:SetSize( 152, 19 );
					AuctionFrameCollectionShop_ItemPriceSortButton:SetSize( 161, 19 );
					AuctionFrameCollectionShop_PctItemValueSortButton:Show();
					for i = 1, self.numToDisplay do
						_G["AuctionFrameCollectionShop_ScrollFrameButton" .. i .. "_Name"]:SetSize( 225, 30 );
						_G["AuctionFrameCollectionShop_ScrollFrameButton" .. i .. "_Category"]:SetSize( 150, 30 );
						_G["AuctionFrameCollectionShop_ScrollFrameButton" .. i .. "_ItemPrice"]:SetSize( 159, 30 );
						_G["AuctionFrameCollectionShop_ScrollFrameButton" .. i .. "_PctItemValue"]:Show();
					end
				else
					NS.isPctItemValue = false;
					AuctionFrameCollectionShop_NameSortButton:SetSize( 287, 19 );
					AuctionFrameCollectionShop_CategorySortButton:SetSize( 202, 19 );
					AuctionFrameCollectionShop_ItemPriceSortButton:SetSize( 179, 19 );
					AuctionFrameCollectionShop_PctItemValueSortButton:Hide();
					for i = 1, self.numToDisplay do
						_G["AuctionFrameCollectionShop_ScrollFrameButton" .. i .. "_Name"]:SetSize( 250, 30 );
						_G["AuctionFrameCollectionShop_ScrollFrameButton" .. i .. "_Category"]:SetSize( 200, 30 );
						_G["AuctionFrameCollectionShop_ScrollFrameButton" .. i .. "_ItemPrice"]:SetSize( 177, 30 );
						_G["AuctionFrameCollectionShop_ScrollFrameButton" .. i .. "_PctItemValue"]:Hide();
					end
				end
			end
		end,
	} );
	NS.TextFrame( "_JumbotronFrame", AuctionFrameCollectionShop, "", {
		hidden = true,
		size = { 733 - 19, ( 334 - 22 ) },
		setPoint = { "TOPLEFT", "$parent_ScrollFrame", "TOPLEFT" },
		fontObject = "GameFontHighlightLarge",
		justifyH = "CENTER",
	} );
	NS.Frame( "_ModeSelectionFrame", AuctionFrameCollectionShop, {
		hidden = true,
		size = { 733 - 19, ( 334 - 22 ) },
		setPoint = { "TOPLEFT", "$parent_ScrollFrame", "TOPLEFT" },
	} );
	NS.TextFrame( "_ModeHoverFrame", AuctionFrameCollectionShop_ModeSelectionFrame, "", {
		size = { 733 - 19, 17 },
		setPoint = { "TOPLEFT", "$parent", "TOPLEFT", 0, ( -108 + 17 + 20 ) },
		fontObject = "GameFontHighlightLarge",
		justifyH = "CENTER",
	} );
	NS.Button( "_MountsModeButton", AuctionFrameCollectionShop_ModeSelectionFrame, nil, {
		template = false,
		size = { 96, 96 },
		setPoint = { "TOPLEFT", "$parent", "TOPLEFT", 86.5, -108 },
		normalTexture = 132261, -- 631718 is the original mount journal icon
		texCoord = { 1, 0, 0, 1 }, -- Flip horse head around to match Mount journal icon
		OnClick = function ()
			NS.SetMode( 1 ); -- MOUNTS
		end,
		OnEnter = function()
			AuctionFrameCollectionShop_ModeSelectionFrame_ModeHoverFrameText:SetText( NS.modeColorCodes[1] .. NS.modeNames[1] .. FONT_COLOR_CODE_CLOSE );
		end,
		OnLeave = function()
			AuctionFrameCollectionShop_ModeSelectionFrame_ModeHoverFrameText:SetText();
		end,
	} );
	NS.Button( "_PetsModeButton", AuctionFrameCollectionShop_ModeSelectionFrame, nil, {
		template = false,
		size = { 96, 96 },
		setPoint = { "LEFT", "#sibling", "RIGHT", 20, 0 },
		normalTexture = 631719,
		OnClick = function ()
			NS.SetMode( 2 ); -- PETS
		end,
		OnEnter = function()
			AuctionFrameCollectionShop_ModeSelectionFrame_ModeHoverFrameText:SetText( NS.modeColorCodes[2] .. NS.modeNames[2] .. FONT_COLOR_CODE_CLOSE );
		end,
		OnLeave = function()
			AuctionFrameCollectionShop_ModeSelectionFrame_ModeHoverFrameText:SetText();
		end,
	} );
	NS.Button( "_ToysModeButton", AuctionFrameCollectionShop_ModeSelectionFrame, nil, {
		template = false,
		size = { 96, 96 },
		setPoint = { "LEFT", "#sibling", "RIGHT", 20, 0 },
		normalTexture = 454046,
		OnClick = function ()
			NS.SetMode( 3 ); -- TOYS
		end,
		OnEnter = function()
			AuctionFrameCollectionShop_ModeSelectionFrame_ModeHoverFrameText:SetText( NS.modeColorCodes[3] .. NS.modeNames[3] .. FONT_COLOR_CODE_CLOSE );
		end,
		OnLeave = function()
			AuctionFrameCollectionShop_ModeSelectionFrame_ModeHoverFrameText:SetText();
		end,
	} );
	NS.Button( "_AppearancesModeButton", AuctionFrameCollectionShop_ModeSelectionFrame, nil, {
		template = false,
		size = { 96, 96 },
		setPoint = { "LEFT", "#sibling", "RIGHT", 20, 0 },
		normalTexture = 132658,
		OnClick = function ()
			NS.SetMode( 4 ); -- APPEARANCES
		end,
		OnEnter = function()
			AuctionFrameCollectionShop_ModeSelectionFrame_ModeHoverFrameText:SetText( NS.modeColorCodes[4] .. NS.modeNames[4] .. FONT_COLOR_CODE_CLOSE );
		end,
		OnLeave = function()
			AuctionFrameCollectionShop_ModeSelectionFrame_ModeHoverFrameText:SetText();
		end,
	} );
	NS.Button( "_RecipesModeButton", AuctionFrameCollectionShop_ModeSelectionFrame, nil, {
		template = false,
		size = { 96, 96 },
		setPoint = { "LEFT", "#sibling", "RIGHT", 20, 0 },
		normalTexture = 134939,
		OnClick = function ()
			NS.SetMode( 5 ); -- RECIPES
		end,
		OnEnter = function()
			AuctionFrameCollectionShop_ModeSelectionFrame_ModeHoverFrameText:SetText( NS.modeColorCodes[5] .. NS.modeNames[5] .. FONT_COLOR_CODE_CLOSE );
		end,
		OnLeave = function()
			AuctionFrameCollectionShop_ModeSelectionFrame_ModeHoverFrameText:SetText();
		end,
	} );
	NS.Frame( "_DialogFrame", AuctionFrameCollectionShop, {
		size = { 733 - 19, 64 + 27 },
		setPoint = { "TOP", "$parent_ScrollFrame", "BOTTOM" },
	} );
	NS.Frame( "_BuyoutFrame", AuctionFrameCollectionShop_DialogFrame, {
		hidden = true,
		setAllPoints = true,
	} );
	NS.TextFrame( "_SelectedOwnerLabel", AuctionFrameCollectionShop_DialogFrame_BuyoutFrame, L["Seller:"], {
		size = { 50, 20 },
		setPoint = { "LEFT", "$parent", "LEFT", 7, 0 },
	} );
	NS.InputBox( "_SelectedOwnerEditbox", AuctionFrameCollectionShop_DialogFrame_BuyoutFrame, {
		size = { 150, 20 },
		setPoint = { "LEFT", "#sibling", "RIGHT", 5, 0 },
		OnEnterPressed = function( self )
			self:ClearFocus();
		end,
		OnEditFocusGained = function( self )
			self:HighlightText();
			self.originalValue = self:GetText();
		end,
		OnEditFocusLost = function( self )
			self:HighlightText( 0, 0 );
			self:SetText( self.originalValue );
		end,
		tooltip = function( self )
			if self:GetText() == L["Unknown"] then
				return L["Try reselecting the auction\nto load the seller's name."];
			end
		end,
		OnLoad = function( self )
			self.tooltipAnchor = { self, "ANCHOR_TOPLEFT", -7, 0 };
		end,
	} );
	NS.Button( "_CancelButton", AuctionFrameCollectionShop_DialogFrame_BuyoutFrame, CANCEL, {
		size = { 120, 30 },
		setPoint = { "LEFT", "$parent", "CENTER", 5, 0 },
		OnClick = function()
			if NS.buyAll then
				AuctionFrameCollectionShop_BuyAllButton:Click();
			else
				NS.AuctionGroup_Deselect();
				NS.StatusFrame_Message( NS.SELECT_AN_AUCTION() );
			end
		end,
	} );
	NS.Button( "_BuyoutButton", AuctionFrameCollectionShop_DialogFrame_BuyoutFrame, BUYOUT, {
		size = { 120, 30 },
		setPoint = { "RIGHT", "$parent", "CENTER", -5, 0 },
		OnClick = function( self )
			if NS.scan.status == "selected" then
				NS.scan.status = "buying";
				NS.AuctionSortButtons_Action( "Disable" );
				AuctionFrameCollectionShop_DialogFrame_BuyoutFrame_BuyoutButton:Disable();
				AuctionFrameCollectionShop_DialogFrame_BuyoutFrame_CancelButton:Disable();
				AuctionFrameCollectionShop_ScanButton:Disable();
				AuctionFrameCollectionShop_ShopButton:Disable();
				AuctionFrameCollectionShop_BuyAllButton:Disable();
				CollectionShopEventsFrame:RegisterEvent( "CHAT_MSG_SYSTEM" );
				C_AuctionHouse.PlaceBid( NS.scan.query.auction.auctionID, NS.scan.query.auction[1] ); -- itemPrice(1)
			end
		end,
	} );
	NS.TextFrame( "_StatusFrame", AuctionFrameCollectionShop_DialogFrame, "", {
		setAllPoints = true,
		justifyH = "CENTER",
	} );
	NS.Button( "_CloseButton", AuctionFrameCollectionShop, CLOSE, {
		size = { 80, 22 },
		setPoint = { "BOTTOMRIGHT", 0, -22 },
		OnClick = function() C_AuctionHouse.CloseAuctionHouse() end,
	} );
	NS.Button( "_BuyAllButton", AuctionFrameCollectionShop, L["Buy All"], {
		size = { 80, 22 },
		setPoint = { "RIGHT", "#sibling", "LEFT" },
		tooltip = function()
			if not NS.buyAll then
				return L["Automatically selects the next (first) auction and\ncontinues to do so after every confirmed buyout."];
			end
		end,
		OnClick = function( self )
			if NS.buyAll then
				NS.buyAll = false;
				self:SetText( L["Buy All"] );
				NS.StatusFrame_Message( string.format( L["Buy All has been stopped. %s"], NS.SELECT_AN_AUCTION() ) );
				NS.AuctionGroup_Deselect();
			else
				NS.buyAll = true;
				self:SetText( L["Stop"] );
				NS.StatusFrame_Message( L["Scanning..."] );
				NS.AuctionGroup_OnClick( 1 );
			end
		end,
		OnLoad = function( self )
			function self:Reset()
				NS.buyAll = false;
				self:Disable();
				self:SetText( L["Buy All"] );
			end
		end,
	} );
	NS.Button( "_ShopButton", AuctionFrameCollectionShop, L["Shop"], {
		size = { 80, 22 },
		setPoint = { "RIGHT", "#sibling", "LEFT" },
		OnClick = function( self )
			AuctionFrameCollectionShop_FlyoutPanel_NameSearchEditbox:ClearFocus();
			--
			if NS.scan.status == "ready" or NS.scan.status == "selected" then
				-- Shop
				NS.Reset();
				NS.scan:Start( "SHOP" );
			else
				-- Abort
				NS.Reset();
			end
		end,
		OnLoad = function( self )
			function self:Reset()
				if NS.mode and ( NS.db["live"] or NS.db["getAllScan"][NS.realmName] ) then
					self:Enable();
				else
					self:Disable();
				end
				self:SetText( L["Shop"] );
			end
		end,
	} );
	NS.Button( "_ScanButton", AuctionFrameCollectionShop, L["Scan"], {
		size = { 80, 22 },
		setPoint = { "RIGHT", "#sibling", "LEFT" },
		OnClick = function( self )
			if NS.scan.status == "ready" or NS.scan.status == "selected" then
				-- Scan
				NS.Reset();
				NS.scan:Start( "GETALL" );
			else
				-- Should not fire, but just in case. Also, no Abort option for this scan type
				NS.Print( L["Selection ignored, busy scanning or buying an auction"] );
			end
		end,
		OnLoad = function( self )
			function self:Reset()
				if NS.mode and not NS.db["live"] and ( not NS.db["getAllScan"][NS.realmName] or ( time() - NS.db["getAllScan"][NS.realmName]["time"] ) > 1200 ) then
					self:Enable();
				else
					self:Disable();
				end
				self:SetText( L["Scan"] );
			end
		end,
	} );
	NS.TextFrame( "_TimeSinceLastGetAllScanFrame", AuctionFrameCollectionShop, "", {
		size = { 270, 22 },
		setPoint = { "RIGHT", "#sibling", "LEFT", -47, 0 },
		fontObject = "GameFontNormalSmall",
		justifyH = "CENTER",
	} );
	NS.CheckButton( "_LiveCheckButton", AuctionFrameCollectionShop, L["Live"], {
		template = "InterfaceOptionsSmallCheckButtonTemplate",
		size = { 16, 16 },
		setPoint = { "RIGHT", "$parent_ScanButton", "LEFT", -30, 0 },
		tooltip = L["Scan Auction House live when\npressing \"Shop\" instead of\nusing GetAll scan data.\n\nLive scans only search\nthe pages required for the\nfilters you checked and may\nbe faster in certain modes or\nwhen using a low max price."],
		db = "live",
		OnClick = function()
			NS.Reset();
		end,
	} );
	NS.Button( "_OptionsButton", AuctionFrameCollectionShop, nil, {
		template = false,
		size = { 32, 32 },
		setPoint = { "TOPRIGHT", "$parent_NameSortButton", "BOTTOMLEFT", -6, -9 },
		normalTexture = 134063,
		tooltip = L["Options"],
		OnClick = function()
			NS.SlashCmdHandler( "" );
		end,
		OnLoad = function( self )
			self.tooltipAnchor = { self, "ANCHOR_BOTTOMRIGHT", 3, 33 };
		end,
	} );
	NS.Button( "_ModeSelectionButton", AuctionFrameCollectionShop, nil, {
		template = false,
		size = { 32, 32 },
		setPoint = { "TOP", "#sibling", "BOTTOM", 0, -6 },
		normalTexture = 631718,
		tooltip = L["Choose Collection Mode"],
		OnClick = function( self )
			if NS.scan.status == "ready" or NS.scan.status == "selected" then
				NS.SetMode( nil );
			else
				NS.Print( L["Selection ignored, busy scanning or buying an auction"] );
			end
		end,
		OnLoad = function( self )
			self.tooltipAnchor = { self, "ANCHOR_BOTTOMRIGHT", 3, 33 };
			function self:Reset()
				if not NS.mode then
					self:Hide();
				elseif not self:IsShown() then
					if NS.mode == "MOUNTS" then
						self:SetNormalTexture( 631718 );
					elseif NS.mode == "PETS" then
						self:SetNormalTexture( 631719 );
					elseif NS.mode == "TOYS" then
						self:SetNormalTexture( 454046 );
					elseif NS.mode == "APPEARANCES" then
						self:SetNormalTexture( 132658 );
					elseif NS.mode == "RECIPES" then
						self:SetNormalTexture( 134939 );
					end
					self:Show();
				end
			end
		end,
	} );
	NS.Button( "_BuyoutsMailButton", AuctionFrameCollectionShop, nil, {
		template = false,
		size = { 32, 32 },
		setPoint = { "TOP", "#sibling", "BOTTOM", 0, -6 },
		normalTexture = 133471,
		tooltip = L["Buyouts"],
		OnClick = function( self )
			NS.SlashCmdHandler( "buyouts" );
		end,
		OnLoad = function( self )
			self.tooltipAnchor = { self, "ANCHOR_BOTTOMRIGHT", 3, 33 };
		end,
	} );
	NS.Frame( "_FlyoutPanel", AuctionFrameCollectionShop, {
		template = "BasicFrameTemplate",
		size = { 247, 423 + 112 }, -- 274 with scrollbar, 247 without scrollbar
		setPoint = { "LEFT", "$parent", "RIGHT", 8, -13 },
		bg = { "3054898" }, -- Interface\\AuctionFrame\\AuctionHouseBackgrounds
		OnLoad = function( self )
			function self:Reset( filterOnClick )
				if not filterOnClick then
					AuctionFrameCollectionShop_FlyoutPanel_ScrollFrame:SetVerticalScroll( 0 ); -- Scroll to top
				end
				AuctionFrameCollectionShop_FlyoutPanel_ScrollFrame:Update();
				AuctionFrameCollectionShop_FlyoutPanel_NameSearchEditbox:Enable();
				if NS.mode and NS.db["flyoutPanelOpen"] and not self:IsShown() then
					self:Show();
				elseif ( not NS.mode or not NS.db["flyoutPanelOpen"] ) and self:IsShown() then
					self:Hide();
				end
			end
			self.Bg:SetTexCoord( 0.2, 0.4, 0.4, 0.8 );
			self.Bg:SetPoint( "TOPLEFT", 0, 0 );
			self.Bg:SetPoint( "BOTTOMRIGHT", 0, -5 );
			self.Bg:SetHorizTile( false );
			self.Bg:SetVertTile( false );
			self.TitleText:SetWordWrap( false );
			self.TitleText:SetPoint( "LEFT", 4, 0 );
			self.TitleText:SetPoint( "RIGHT", -28, 0 );
			self.TitleText:SetText( L["Shop Filters"] );
			self.CloseButton:SetScript( "OnClick", function( self )
				self:GetParent().FlyoutPanelButton:Click();
			end );
		end,
		OnShow = function( self )
			self.FlyoutPanelButton:SetNormalTexture( "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up" );
			self.FlyoutPanelButton:SetPushedTexture( "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down" );
		end,
		OnHide = function( self )
			self.FlyoutPanelButton:SetNormalTexture( "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up" );
			self.FlyoutPanelButton:SetPushedTexture( "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down" );
		end,
	} );
	NS.InputBox( "_NameSearchEditbox", AuctionFrameCollectionShop_FlyoutPanel, {
		template = "SearchBoxTemplate",
		size = { 170, 20 },
		setPoint = { "TOP", "$parent", "TOP", 0, -23 },
		maxLetters = 50,
		OnEnterPressed = function( self )
			if self:GetText() == "" then
				self:ClearFocus();
			else
				AuctionFrameCollectionShop_ShopButton:Click();
			end
		end,
		OnEditFocusGained = function( self )
			self:HighlightText();
		end,
		OnEditFocusLost = function( self )
			self:HighlightText( 0, 0 );
		end,
		OnLoad = function( self )
			self.Instructions:SetText( L["Item Name"] );
		end,
	} );
	NS.ScrollFrame( "_ScrollFrame", AuctionFrameCollectionShop_FlyoutPanel, {
		size = { 242, ( 20 * 21 - 5 ) }, -- 20 x {number of rows}
		setPoint = { "TOPLEFT", 1, -47 },
		buttonTemplate = "AuctionFrameCollectionShop_FlyoutPanel_ScrollFrameButtonTemplate",
		update = {
			numToDisplay = 21, -- {number of rows}
			buttonHeight = 20,
			UpdateFunction = function( sf )
				local items = NS.modeFiltersFlyout;
				local numItems = #items;
				FauxScrollFrame_Update( sf, numItems, sf.numToDisplay, sf.buttonHeight );
				-- Adjust FlyoutPanel width for scrollbar
				local flyoutWidth = ( function() if numItems > sf.numToDisplay then return 274 else return 247 end end )();
				AuctionFrameCollectionShop_FlyoutPanel:SetWidth( flyoutWidth );
				if NS.disableFlyoutChecks then
					AuctionFrameCollectionShop_FlyoutPanel_ToggleCategories:Disable();
					AuctionFrameCollectionShop_FlyoutPanel_UncheckAll:Disable();
					AuctionFrameCollectionShop_FlyoutPanel_CheckAll:Disable();
				else
					if NS.mode ~= "MOUNTS" then -- Mounts have no categories
						AuctionFrameCollectionShop_FlyoutPanel_ToggleCategories:Enable();
					end
					AuctionFrameCollectionShop_FlyoutPanel_UncheckAll:Enable();
					AuctionFrameCollectionShop_FlyoutPanel_CheckAll:Enable();
				end
				-- Filter: key(1), string(2), default(3), info(4)
				for num = 1, sf.numToDisplay do
					local k = FauxScrollFrame_GetOffset( sf ) + num; -- key
					local bn = sf.buttonName .. num; -- button name
					local b = _G[bn]; -- button
					local c = _G[bn .. "_Check"]; -- check
					b:UnlockHighlight();
					if NS.disableFlyoutChecks then
						c:Disable();
					else
						c:Enable();
					end
					if k <= numItems then
						b:SetScript( "OnClick", function() c:Click() end );
						_G[bn .. "_NameText"]:SetText( items[k][2] );
						--
						c:SetChecked( NS.db["modeFilters"][NS.mode][items[k][1]] );
						c:SetScript( "OnEnter", function() b:LockHighlight(); end );
						c:SetScript( "OnLeave", function() b:UnlockHighlight(); end );
						c:SetScript( "OnClick", function() NS.db["modeFilters"][NS.mode][items[k][1]] = c:GetChecked(); NS.Reset( true ); end );
						--
						b:Show();
					else
						b:Hide();
					end
				end
			end
		},
	} );
	NS.Button( "_UncheckAll", AuctionFrameCollectionShop_FlyoutPanel, L["Uncheck All"], {
		size = { 96, 20 },
		setPoint = { "BOTTOMRIGHT", "$parent", "BOTTOM", -2, 9 },
		fontObject = "GameFontNormalSmall",
		OnClick = function()
			NS.FlyoutPanelSetChecks( false );
		end,
	} );
	NS.Button( "_ToggleCategories", AuctionFrameCollectionShop_FlyoutPanel, "", {
		size = { 144, 20 },
		setPoint = { "BOTTOM", "$parent", "BOTTOM", 0, 32 },
		fontObject = "GameFontNormalSmall",
		OnClick = function()
			NS.FlyoutPanelToggleCategories();
		end,
	} );
	NS.Button( "_CheckAll", AuctionFrameCollectionShop_FlyoutPanel, L["Check All"], {
		size = { 96, 20 },
		setPoint = { "BOTTOMLEFT", "$parent", "BOTTOM", 2, 9 },
		fontObject = "GameFontNormalSmall",
		OnClick = function()
			NS.FlyoutPanelSetChecks( true );
		end,
	} );
	NS.Button( "_FlyoutPanelButton", AuctionFrameCollectionShop, nil, {
		template = false,
		size = { 28, 28 },
		setPoint = { "TOPRIGHT", "$parent", "TOPRIGHT", 5, -22 },
		normalTexture = "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up",
		pushedTexture = "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down",
		highlightTexture = "Interface\\Buttons\\UI-Common-MouseHilight",
		OnClick = function ( self )
			if not NS.mode then return end
			if self.FlyoutPanel:IsShown() then
				self.FlyoutPanel:Hide();
				NS.db["flyoutPanelOpen"] = false;
			else
				self.FlyoutPanel:Show();
				NS.db["flyoutPanelOpen"] = true;
			end
		end,
		OnLoad = function( self )
			self.FlyoutPanel = _G[self:GetParent():GetName() .. "_FlyoutPanel"];
			self.FlyoutPanel.FlyoutPanelButton = self;
		end,
	} );
	-- Set AuctionFrameCollectionShop inside AuctionHouseFrame
	AuctionFrameCollectionShop:SetParent( AuctionHouseFrame );
	AuctionFrameCollectionShop:SetPoint( "TOPLEFT" );
	-- Add "CollectionShop" tab to AuctionHouseFrame
	local numTab = #AuctionHouseFrame.Tabs + 1;
	NS.AuctionHouseFrameTab = NS.Button( "CollectionShopTab", AuctionHouseFrame, NS.title, {
		template = "AuctionHouseFrameDisplayModeTabTemplate",
		OnLoad = function( self )
			self:SetID( numTab ); -- Easy way to compare with selected tab
			AuctionHouseFrame.Tabs[numTab] = self; -- parentArray Tabs
			AuctionHouseFrame.AuctionFrameCollectionShop = AuctionFrameCollectionShop; -- parentKey
			self:SetPoint( "LEFT", AuctionHouseFrame.Tabs[#AuctionHouseFrame.Tabs - 1], "RIGHT", -15, 0 ); -- Align with previous tab
			AuctionHouseFrameDisplayMode.CollectionShop = { "AuctionFrameCollectionShop" }; -- Define new display mode
			self.displayMode = AuctionHouseFrameDisplayMode.CollectionShop; -- Assign new display mode to tab
			AuctionHouseFrame.tabsForDisplayMode[self.displayMode] = numTab; -- Add manually because Blizz does this on AH load
		end,
	} );
	PanelTemplates_SetNumTabs( AuctionHouseFrame, numTab );
	PanelTemplates_EnableTab( AuctionHouseFrame, numTab );
	-- Hook tab click
	hooksecurefunc( AuctionHouseFrame, "SetDisplayMode", NS.AuctionHouseFrame_SetDisplayMode );
	-- Hook DressUpModelCancelButton
	DressUpFrameCloseButton:HookScript( "OnClick", NS.DressUpFrameCancelButton_OnClick );
	DressUpFrameCancelButton:HookScript( "OnClick", NS.DressUpFrameCancelButton_OnClick );
	-- Add new appearance sources to appearanceCollection to prevent unnecessary source lookups
	CollectionShopEventsFrame:RegisterEvent( "TRANSMOG_COLLECTION_SOURCE_ADDED" );
end
--------------------------------------------------------------------------------------------------------------------------------------------
-- CollectionShopEventsFrame
--------------------------------------------------------------------------------------------------------------------------------------------
NS.Frame( "CollectionShopEventsFrame", UIParent, {
	topLevel = true,
	hidden = true,
	OnEvent = function ( self, event, ... )
		if		event == "ADDON_LOADED"						then
			if IsAddOnLoaded( NS.addon ) then
				if not NS.initialized then
					-- Set Default SavedVariables
					if not COLLECTIONSHOP_SAVEDVARIABLES then
						COLLECTIONSHOP_SAVEDVARIABLES = NS.DefaultSavedVariables();
					end
					-- Set Default SavedVariablesPerCharacter
					if not COLLECTIONSHOP_SAVEDVARIABLESPERCHARACTER then
						COLLECTIONSHOP_SAVEDVARIABLESPERCHARACTER = NS.DefaultSavedVariablesPerCharacter();
					end
					-- Localize SavedVariables
					NS.db = COLLECTIONSHOP_SAVEDVARIABLES;
					NS.dbpc = COLLECTIONSHOP_SAVEDVARIABLESPERCHARACTER;
					-- Upgrade if old version
					if NS.db["version"] < NS.version then
						NS.Upgrade();
					end
					-- Upgrade Per Character if old version
					if NS.dbpc["version"] < NS.version then
						NS.UpgradePerCharacter();
					end
					--
					NS.initialized = true;
				elseif IsAddOnLoaded( "Blizzard_AuctionHouseUI" ) then
					self:UnregisterEvent( "ADDON_LOADED" );
					NS.Blizzard_AuctionHouseUI_OnLoad();
				end
			end
		elseif	event == "PLAYER_LOGIN"						then
			self:UnregisterEvent( "PLAYER_LOGIN" );
			--InterfaceOptions_AddCategory( CollectionShopInterfaceOptionsPanel );
			if #NS.playerLoginMsg > 0 then
				for _,msg in ipairs( NS.playerLoginMsg ) do
					NS.Print( msg );
				end
			end
		elseif	event == "AUCTION_HOUSE_BROWSE_RESULTS_UPDATED"				then	NS.scan:OnBrowseResultsUpdated();
		elseif	event == "AUCTION_HOUSE_THROTTLED_SYSTEM_READY"				then	NS.scan:OnThrottledSystemReady();
		elseif	event == "ITEM_SEARCH_RESULTS_UPDATED"						then	NS.scan:OnItemSearchResultsUpdated();
		elseif	event == "REPLICATE_ITEM_LIST_UPDATE"						then	NS.scan:OnReplicateItemListUpdate();
		elseif	event == "CHAT_MSG_SYSTEM"									then	NS.scan:OnChatMsgSystem( ... );
		elseif	event == "UI_ERROR_MESSAGE"									then	NS.scan:OnUIErrorMessage( ... );
		elseif	event == "TRANSMOG_COLLECTION_SOURCE_ADDED"					then
			local arg1 = ...;
			if not arg1 then return end
			--
			local sourceID = arg1;
			local _,appearanceID = C_TransmogCollection.GetAppearanceSourceInfo( sourceID );
			if appearanceID then
				-- Update Appearances and Sources
				NS.appearanceCollection.appearances[appearanceID] = { nil, true }; -- categoryID(1) not currently being used, isCollected(2)
				NS.appearanceCollection.sources[sourceID] = { appearanceID, true }; -- isCollected(2)
			end
		elseif	event == "PLAYER_SPECIALIZATION_CHANGED"	then
			local arg1 = select( 1, ... );
			if not arg1 then return end
			if arg1 == "player" then
				AuctionHouseFrameBuyTab:Click(); -- Go to browse tab if player changes specs while using addon, AH links are based on spec
			end
		elseif	event == "INSPECT_READY"					then
			self:UnregisterEvent( "INSPECT_READY" );
			NS.linkSpecID = GetInspectSpecialization( "player" );
		end
	end,
	OnLoad = function( self )
		self:RegisterEvent( "ADDON_LOADED" );
		self:RegisterEvent( "PLAYER_LOGIN" );
	end,
} );
