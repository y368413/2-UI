-- $Id: Constants.lua 194 2020-07-07 15:33:16Z arith $
local _G = getfenv(0)
local constants = {}

local WoWClassic = select(4, GetBuildInfo()) < 20000
constants.defaults = {
	profile = {
		show_currency = true,
		show_money = false,
		show_iconOnly = false,
		show_tooltip = true,
		hide_zero = true,
		breakupnumbers = true,
		icon_first = false,
		always_lock = false,
		hide_in_combat = false,
		hide_in_petbattle = false,
		hide_in_battleground = false,
		point = { "BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -6, 0 },
		scale = 1,
		alpha = 1,
		bgalpha = 0.1,
		tooltip_alpha = 0.9,
		tooltip_scale = 1,
		currencies = {
				[1580] = true,
				[1719] = true,
				[1755] = true,
	  },
		items = {},
		maxItems = 0, -- 0 means un-limited
		--optionsCopied = false,
		currencyFormatConverted = false,
		showLowerDenominations = true,
	},
}

constants.items = {
	relics = {
		174768, -- Cursed Relic
		174767, -- Mogu Relic
		174766, -- Mantid Relic
		174765, -- Tol'vir Relic
		174764, -- Tol'vir Relic Fragment
		174761, -- Aqir Relic
		174760, -- Mantid Relic Fragment
		174759, -- Mogu Relic Fragment
		174758, -- Voidwarped Relic Fragment
		174756, -- Aqir Relic Fragment
	},
	professions = {
		[3908] = { -- Tailoring: Cloth
			-- Shadowland
			173202, -- Shrouded Cloth
			173204, -- Lightless Silk
			-- RoA
			167738, -- Gilded Seaweave
			-- BfA
			158378, -- Embroidered Deep Sea Satin
			152577, -- Deep Sea Satin
			152576, -- Tidespray Linen
			-- Legion
			151567, -- Lightweave Cloth
			146711, -- Bolt of Starweave
			146710, -- Bolt of Shadowcloth
			127681, -- Sharp Spritethorn
			127037, -- Runic Catgut
			127004, -- Imbued Silkweave
			124437, -- Shal'dorei Silk
			-- WoD
			111557, -- Sumptuous Fur
			111556, -- Hexweave Cloth
			-- MoP
			98619, -- Celestial Cloth
			92960, -- Silkworm Cocoon
			82447, -- Imperial Silk
			82441, -- Bolt of Windwool Cloth
			72988, -- Windwool Cloth
			-- Catalysm
			54440, -- Dreamcloth
			53643, -- Bolt of Embersilk Cloth
			53010, -- Embersilk Cloth
			--WotLK
			42253, -- Iceweb Spider Silk
			41595, -- Spellweave
			41594, -- Moonshroud
			41593, -- Ebonweave
			41511, -- Bolt of Imbued Frostweave
			41510, -- Bolt of Frostweave
			33470, -- Frostweave Cloth
			-- BC
			24272, -- Shadowcloth
			24271, -- Spellcloth
			21881, -- Netherweb Spider Silk
			21877, -- Netherweave Cloth
			21845, -- Primal Mooncloth
			21844, -- Bolt of Soulcloth
			21842, -- Bolt of Imbued Netherweave
			21840, -- Bolt of Netherweave
			-- Classic
			14342, -- Mooncloth
			14256, -- Felcloth
			14227, -- Ironweb Spider Silk
			14048, -- Bolt of Runecloth
			14047, -- Runecloth
			10285, -- Shadow Silk
			4339, -- Bolt of Mageweave
			4338, -- Mageweave Cloth
			4337, -- Thick Spider's Silk
			4306, -- Silk Cloth
			4305, -- Bolt of Silk Cloth
			3182, -- Spider's Silk
			2997, -- Bolt of Woolen Cloth
			2996, -- Bolt of Linen Cloth
			2592, -- Wool Cloth
			2589, -- Linen Cloth
		},
		[2575] = { -- Mining: Metal & Stone
			-- RoA
			168185, -- Osmenite Ore
			-- BfA
			152513, -- Platinum Ore
			152512, -- Monelite Ore
			152579, -- Storm Silver Ore
			-- Legion
			151564, -- Empyrium
			124461, -- Demonsteel Bar
			124444, -- Infernal Brimstone
			123919, -- Felslate
			123918, -- Leystone Ore
			-- WoD
			115508, -- Draenic Stone
			109992, -- Blackrock Fragment
			109991, -- True Iron Nugget
			109119, -- True Iron Ore
			109118, -- Blackrock Ore
			108445, -- Draenic Coal
			108391, -- Titanium Ore Nugget
			108309, -- Pyrite Ore Nugget
			108308, -- Elementium Ore Nugget
			108307, -- Obsidium Ore Nugget
			108306, -- Saronite Ore Nugget
			108305, -- Cobalt Ore Nugget
			108304, -- Khorium Ore Nugget
			108303, -- Eternium Ore Nugget
			108302, -- Adamantite Ore Nugget
			108301, -- Fel Iron Ore Nugget
			108300, -- Mithril Ore Nugget
			108299, -- Truesilver Ore Nugget
			108298, -- Thorium Ore Nugget
			108297, -- Iron Ore Nugget
			108296, -- Gold Ore Nugget
			108295, -- Tin Ore Nugget
			108294, -- Silver Ore Nugget
			108257, -- Truesteel Ingot
			-- MoP
			97546, -- Kyparite Fragment
			97512, -- Ghost Iron Nugget
			72104, -- Living Steel, Alchemy
			72103, -- White Trillium Ore
			72096, -- Ghost Iron Bar
			72095, -- Trillium Bar, Alchemy
			72094, -- Black Trillium Ore
			72093, -- Kyparite
			72092, -- Ghost Iron Ore
			-- Cayaclysm
			65365, -- Folded Obsidium
			58480, -- Truegold, Alchemy
			54849, -- Obsidium Bar
			53039, -- Hardened Elementium Bar
			53038, -- Obsidium Ore
			52186, -- Elementium Bar
			52185, -- Elementium Ore
			52183, -- Pyrite Ore
			51950, -- Pyrium Bar, Alchemy
			-- WolTK
			41163, -- Titanium Bar, Alchemy
			37663, -- Titansteel Bar
			36916, -- Cobalt Bar
			36913, -- Saronite Bar
			36912, -- Saronite Ore
			36910, -- Titanium Ore
			36909, -- Cobalt Ore
			-- BC
			35128, -- Hardened Khorium
			23573, -- Hardened Adamantite Bar
			23449, -- Khorium Bar
			23448, -- Felsteel Bar
			23447, -- Eternium Bar
			23446, -- Adamantite Bar
			23445, -- Fel Iron Bar
			23427, -- Eternium Ore
			23426, -- Khorium Ore
			23425, -- Adamantite Ore
			23424, -- Fel Iron Ore
			-- Classic
			22203, -- Large Obsidian Shard
			22202, -- Small Obsidian Shard
			18567, -- Elemental Flux
			18562, -- Elementium Ingot
			17771, -- Enchanted Elementium Bar
			17203, -- Sulfuron Ingot
			12809, -- Guardian Stone
			12655, -- Enchanted Thorium Bar
			12365, -- Dense Stone
			12359, -- Thorium Bar
			11371, -- Dark Iron Bar
			11370, -- Dark Iron Ore
			10620, -- Thorium Ore
			7912, -- Solid Stone
			7911, -- Truesilver Ore
			6037, -- Truesilver Bar
			3857, -- Coal
			3577, -- Gold Bar
			3576, -- Tin Bar
			3575, -- Iron Bar
			3860, -- Mithril Bar
			3859, -- Steel Bar
			3858, -- Mithril Ore
			2842, -- Silver Bar
			2841, -- Bronze Bar
			2840, -- Copper Bar
			2838, -- Heavy Stone
			2836, -- Coarse Stone
			2835, -- Rough Stone
			2776, -- Gold Ore
			2775, -- Silver Ore
			2772, -- Iron Ore
			2771, -- Tin Ore
			2770, -- Copper Ore
		},
		[2108] = { -- Leatherworking
			-- Shadowland
			177281, --  Heavy Sorrowscale
			177279, --  Gaunt Sinew
			172438, --  Enchanted Heavy Desolate Hide
			172333, --  Purified Leather
			172332, --  Necrotic Leather
			172331, --  Sinful Leather
			172330, --  Unseelie Leather
			172097, --  Heavy Desolate Hide
			172096, --  Heavy Desolate Leather
			172095, --  Desolate Hide Scraps
			172094, --  Desolate Hide
			172093, --  Desolate Leather Scraps
			172092, --  Pallid Bone
			172090, --  Sorrowscale Fragment
			172089, --  Desolate Leather
			-- RoA
			168649, -- Dredged Leather
			168650, -- Cragscale
			-- BfA
--			164978, -- Mallet of Thunderous Skins, not quite a "gathered" item to be tracked
			152542, -- Hardened Tempest Hide
			153051, -- Mistscale
			154165, -- Calcified Bone
			154722, -- Tempest Hide
			152541, -- Coarse Leather
			153050, -- Shimmerscale
			154164, -- Blood-Stained Bone
			-- Legion
			151566, -- Fiendish Leather
			124116, -- Felhide
			124115, -- Stormscale
			124113, -- Stonehide Leather
			-- WoD
			112185, --  Wind Scale Fragment
			112184, --  Cobra Scale Fragment
			112183, --  Nether Dragonscale Fragment
			112182, --  Patch of Fel Hide
			112181, --  Fel Scale Fragment
			112180, --  Patch of Crystal Infused Leather
			112179, --  Patch of Thick Clefthoof Leather
			112178, --  Jormungar Scale Fragment
			112177, --  Nerubian Chitin Fragment
			112158, --  Icy Dragonscale Fragment
			112157, --  Prismatic Scale Fragment
			112156, --  Blackened Dragonscale Fragment
			112155, --  Deepsea Scale Fragment
			110611, --  Burnished Leather
			110610, --  Raw Beast Hide Scraps
			110609, --  Raw Beast Hide
			-- MoP
			79101, -- Prismatic Scale
			72163, -- Magnificent Hide
			72162, -- Sha-Touched Leather
			72120, -- Exotic Leather
			-- Catalysm
			56516, --  Heavy Savage Leather
			52982, --  Deepsea Scale
			52980, --  Pristine Hide
			52979, --  Blackened Dragonscale
			52977, --  Savage Leather Scraps
			52976, --  Savage Leather
			-- WotLK			
			44128, --  Arctic Fur
			38425, --  Heavy Borean Leather
			33568, --  Borean Leather
			38557, --  Icy Dragonscale
			38558, --  Nerubian Chitin
			38561, --  Jormungar Scale
			33567, --  Borean Leather Scraps
			-- BC
			29548, --  Nether Dragonscales
			29547, --  Wind Scales
			29539, --  Cobra Scales
			25708, --  Thick Clefthoof Leather
			25707, --  Fel Hide
			25700, --  Fel Scales
			25699, --  Crystal Infused Leather
			25649, --  Knothide Leather Scraps
			23793, --  Heavy Knothide Leather
			21887, --  Knothide Leather
			-- Classic
			20381, --  Dreamscale
			19768, --  Primal Tiger Leather
			19767, --  Primal Bat Leather
			17967, --  Refined Scale of Onyxia
			17012, --  Core Leather
			15419, --  Warbear Leather
			15417, --  Devilsaur Leather
			15416, --  Black Dragonscale
			15415, --  Blue Dragonscale
			15414, --  Red Dragonscale
			15412, --  Green Dragonscale
			15410, --  Scale of Onyxia
			15408, --  Heavy Scorpid Scale
			15407, --  Cured Rugged Hide
			12810, --  Enchanted Leather
			8172, --  Cured Thick Hide
			8171, --  Rugged Hide
			8170, --  Rugged Leather
			8169, --  Thick Hide
			8168, --  Jet Black Feather
			8167, --  Turtle Scale
			8165, --  Worn Dragonscale
			8154, --  Scorpid Scale
			7392, --  Green Whelp Scale
			7286, --  Black Whelp Scale
			6471, --  Perfect Deviate Scale
			6470, --  Deviate Scale
			5785, --  Thick Murloc Scale
			5784, --  Slimy Murloc Scale
			5116, --  Long Tail Feather
			5082, --  Thin Kodo Leather
			4461, --  Raptor Hide
			4304, --  Thick Leather
			4236, --  Cured Heavy Hide
			4235, --  Heavy Hide
			4234, --  Heavy Leather
			4233, --  Cured Medium Hide
			4232, --  Medium Hide
			4231, --  Cured Light Hide
			2934, --  Ruined Leather Scraps
			2319, --  Medium Leather
			2318, --  Light Leather
			783, --  Light Hide
		},
		[7411] = { -- Enchanting
			-- RoA
			164766, -- Iwen's Enchanting Rod
			-- BfA
			152882, -- Runed Norgal Rod
			152877, -- Veiled Crystal
			152876, -- Umbra Shard
			152875, -- Gloom Dust
			-- Legion
			156930, -- Rich Illusion Dust
			124442, -- Chaos Crystal
			124441, -- Leylight Shard
			124440, -- Arkhana
			-- WoD
			115504, -- Fractured Temporal Crystal
			115502, -- Small Luminous Shard
			113588, -- Temporal Crystal
			111245, -- Luminous Shard
			109693, -- Draenic Dust
			-- MoP
			105718, -- Sha Crystal Fragment
			102218, -- Spirit of War
			94289, -- Haunting Spirit
			89738, -- Essence or Dust
			80433, -- Blood Spirit
			74252, -- Small Ethereal Shard
			74250, -- Mysterious Essence
			74249, -- Spirit Dust
			74248, -- Sha Crystal
			74247, -- Ethereal Shard
			-- Cataclysm
			52722, -- Maelstrom Crystal
			52721, -- Heavenly Shard
			52720, -- Small Heavenly Shard
			52719, -- Greater Celestial Essence
			52718, -- Lesser Celestial Essence
			52555, -- Hypnotic Dust
			-- WolTK
			34057, -- Abyss Crystal
			34056, -- Lesser Cosmic Essence
			34055, -- Greater Cosmic Essence
			34054, -- Infinite Dust
			34053, -- Small Dream Shard
			34052, -- Dream Shard
			-- BC
			22450, -- Void Crystal
			22449, -- Large Prismatic Shard
			22448, -- Small Prismatic Shard
			22447, -- Lesser Planar Essence
			22446, -- Greater Planar Essence
			22445, -- Arcane Dust
			-- Classic
			20725, -- Nexus Crystal
			16204, -- Light Illusion Dust
			16203, -- Greater Eternal Essence
			16202, -- Lesser Eternal Essence
			14344, -- Large Brilliant Shard
			14343, -- Small Brilliant Shard
			11178, -- Large Radiant Shard
			11176, -- Dream Dust
			11175, -- Greater Nether Essence
			11174, -- Lesser Nether Essence
			10943, -- Strange Dust
			10939, -- Greater Magic Essence
			10938, -- Lesser Magic Essence
		},
		[2366] = { -- Herbalism
			-- RoA
			168487, -- Zin'anthid
			-- BfA
			152505, -- Riverbud
			152506, -- Star Moss
			152507, -- Akunda's Bite
			152508, -- Winter's Kiss
			152509, -- Siren's Pollen
			152510, -- Anchor Weed
			152511, -- Sea Stalk
			-- Legion
			151565, -- Astral Glory
			129289, -- Felwort Seed
			129288, -- Starlight Rose Seed
			129287, -- Fjarnskaggl Seed
			129286, -- Foxflower Seed
			129285, -- Dreamleaf Seed
			129284, -- Aethril Seed
			128304, -- Yseralline Seed
			124106, -- Felwort
			124105, -- Starlight Rose
			124104, -- Fjarnskaggl
			124103, -- Foxflower
			124102, -- Dreamleaf
			124101, -- Aethril
			-- WoD
			116053, -- Draenic Seeds
			109629, -- Talador Orchid Petal
			109628, -- Nagrand Arrowbloom Petal
			109627, -- Starflower Petal
			109626, -- Gorgrond Flytrap Ichor
			109625, -- Broken Fireweed Stem
			109624, -- Broken Frostweed Stem
			109129, -- Talador Orchid
			109128, -- Nagrand Arrowbloom
			109127, -- Starflower
			109126, -- Gorgrond Flytrap
			109125, -- Fireweed
			109124, -- Frostweed
			108365, -- Whiptail Stem
			108364, -- Twilight Jasmine Petal
			108363, -- Heartblossom Petal
			108362, -- Azshara's Veil Stem
			108361, -- Stormvine Stalk
			108360, -- Cinderbloom Petal
			108359, -- Fire Leaf Bramble
			108358, -- Deadnettle Bramble
			108357, -- Talandra's Rose Petal
			108356, -- Icethorn Bramble
			108355, -- Lichbloom Stalk
			108354, -- Tiger Lily Petal
			108353, -- Adder's Tongue Stem
			108352, -- Goldclover Leaf
			108351, -- Mana Thistle Leaf
			108350, -- Nightmare Vine Stem
			108349, -- Netherbloom Leaf
			108348, -- Ancient Lichen Petal
			108347, -- Terocone Leaf
			108346, -- Ragveil Cap
			108345, -- Dreaming Glory Petal
			108344, -- Felweed Stalk
			108343, -- Icecap Petal
			108342, -- Sorrowmoss Leaf
			108341, -- Mountain Silversage Stalk
			108340, -- Golden Sansam Leaf
			108339, -- Dreamfoil Blade
			108338, -- Gromsblood Leaf
			108337, -- Ghost Mushroom Cap
			108336, -- Blindweed Stem
			108335, -- Sungrass Stalk
			108334, -- Arthas' Tears Petal
			108333, -- Purple Lotus Petal
			108332, -- Firebloom Petal
			108331, -- Goldthorn Bramble
			108330, -- Stranglekelp Blade
			108329, -- Dragon's Teeth Stem
			108328, -- Fadeleaf Petal
			108327, -- Grave Moss Leaf
			108326, -- Khadgar's Whisker Stem
			108325, -- Liferoot Stem
			108324, -- Kingsblood Petal
			108323, -- Wild Steelbloom Petal
			108322, -- Bruiseweed Stem
			108321, -- Swiftthistle Leaf
			108320, -- Briarthorn Bramble
			108319, -- Earthroot Stem
			108318, -- Mageroyal Petal
			-- MoP
			97624, -- Desecrated Herb Pod
			97623, -- Fool's Cap Spores
			97622, -- Snow Lily Petal
			97621, -- Silkweed Stem
			97620, -- Rain Poppy Petal
			97619, -- Torn Green Tea Leaf
			79011, -- Fool's Cap
			79010, -- Snow Lily
			72238, -- Golden Lotus
			72237, -- Rain Poppy
			72235, -- Silkweed
			72234, -- Green Tea Leaf
			-- Cayaclysm
			52988, -- Whiptail
			52987, -- Twilight Jasmine
			52986, -- Heartblossom
			52985, -- Azshara's Veil
			52984, -- Stormvine
			52983, -- Cinderbloom
			-- WolTK
			39970, -- Fire Leaf
			37921, -- Deadnettle
			36908, -- Frost Lotus
			36907, -- Talandra's Rose
			36906, -- Icethorn
			36905, -- Lichbloom
			36904, -- Tiger Lily
			36903, -- Adder's Tongue
			36902, -- Constrictor Grass
			36901, -- Goldclover
			-- BC
			22797, -- Nightmare Seed
			22794, -- Fel Lotus
			22793, -- Mana Thistle
			22792, -- Nightmare Vine
			22791, -- Netherbloom
			22790, -- Ancient Lichen
			22789, -- Terocone
			22788, -- Flame Cap
			22787, -- Ragveil
			22786, -- Dreaming Glory
			22785, -- Felweed
			22710, -- Bloodthistle
			-- Classic
			19727, -- Blood Scythe
			19726, -- Bloodvine
			13468, -- Black Lotus
			13467, -- Icecap
			13466, -- Sorrowmoss
			13465, -- Mountain Silversage
			13464, -- Golden Sansam
			13463, -- Dreamfoil
			8846, -- Gromsblood
			8845, -- Ghost Mushroom
			8839, -- Blindweed
			8838, -- Sungrass
			8836, -- Arthas' Tears
			8831, -- Purple Lotus
			8153, -- Wildvine
			4625, -- Firebloom
			3821, -- Goldthorn
			3820, -- Stranglekelp
			3819, -- Dragon's Teeth
			3818, -- Fadeleaf
			3369, -- Grave Moss
			3358, -- Khadgar's Whisker
			3357, -- Liferoot
			3356, -- Kingsblood
			3355, -- Wild Steelbloom
			2453, -- Bruiseweed
			2452, -- Swiftthistle
			2450, -- Briarthorn
			2449, -- Earthroot
			2447, -- Peacebloom
			785, -- Mageroyal
			765, -- Silverleaf
		},
		[25229] = { -- Jewelcrafting
			-- RoA
			168190, -- Lava Lazuli
			168188, -- Sage Agate
			168193, -- Azsharine
			168635, -- Leviathan's Eye
			168191, -- Sea Currant
			168189, -- Dark Opal
			168192, -- Sand Spinel
			
			154125, -- Royal Quartz
			154124, -- Laribole
			154123, -- Amberblaze
			154122, -- Tidal Amethyst
			154121, -- Scarlet Diamond
			154120, -- Owlseye
			153706, -- Kraken's Eye
			153705, -- Kyanite
			153704, -- Viridium
			153703, -- Solstone
			153702, -- Kubiline
			153701, -- Rubellite
			153700, -- Golden Beryl
			151722, -- Florid Malachite
			151721, -- Hesselian
			151720, -- Chemirine
			151719, -- Lightsphene
			151718, -- Argulite
			151579, -- Labradorite
			130245, -- Saber's Eye
			130183, -- Shadowruby
			130182, -- Maelstrom Sapphire
			130181, -- Pandemonite
			130180, -- Dawnlight
			130179, -- Eye of Prophecy
			130178, -- Furystone
			130177, -- Queen's Opal
			130176, -- Skystone
			130175, -- Chaotic Spinel
			130174, -- Azsunite
			130173, -- Deep Amber
			130172, -- Sangrite
			129100, -- Gem Chip
			76734, -- Serpent's Eye
			76142, -- Sun's Radiance
			76141, -- Imperial Amethyst
			76140, -- Vermilion Onyx
			76139, -- Wild Jade
			76138, -- River's Heart
			76137, -- Alexandrite
			76136, -- Pandarian Garnet
			76135, -- Roguestone
			76134, -- Sunstone
			76133, -- Lapis Lazuli
			76132, -- Primal Diamond
			76131, -- Primordial Ruby
			76130, -- Tiger Opal
			71810, -- Elven Peridot
			71809, -- Shadow Spinel
			71808, -- Lava Coral
			71807, -- Deepholm Iolite
			71806, -- Lightstone
			71805, -- Queen's Garnet
			52303, -- Shadowspirit Diamond
			52196, -- Chimera's Eye
			52195, -- Amberjewel
			52194, -- Demonseye
			52193, -- Ember Topaz
			52192, -- Dream Emerald
			52191, -- Ocean Sapphire
			52190, -- Inferno Ruby
			52182, -- Jasper
			52181, -- Hessonite
			52180, -- Nightstone
			52179, -- Alicite
			52178, -- Zephyrite
			52177, -- Carnelian
			42225, -- Dragon's Eye
			41334, -- Earthsiege Diamond
			41266, -- Skyflare Diamond
			36934, -- Eye of Zul
			36933, -- Forest Emerald
			36932, -- Dark Jade
			36931, -- Ametrine
			36930, -- Monarch Topaz
			36929, -- Huge Citrine
			36928, -- Dreadstone
			36927, -- Twilight Opal
			36926, -- Shadow Crystal
			36925, -- Majestic Zircon
			36924, -- Sky Sapphire
			36923, -- Chalcedony
			36922, -- King's Amber
			36921, -- Autumn's Glow
			36920, -- Sun Crystal
			36919, -- Cardinal Ruby
			36918, -- Scarlet Ruby
			36917, -- Bloodstone
			36784, -- Siren's Tear
			36783, -- Northsea Pearl
			32249, -- Seaspray Emerald
			32231, -- Pyrestone
			32230, -- Shadowsong Amethyst
			32229, -- Lionseye
			32228, -- Empyrean Sapphire
			32227, -- Crimson Spinel
			31079, -- Mercurial Adamantite
			25868, -- Skyfire Diamond
			25867, -- Earthstorm Diamond
			24479, -- Shadow Pearl
			24478, -- Jaggal Pearl
			24243, -- Adamantite Powder
			23441, -- Nightseye
			23440, -- Dawnstone
			23439, -- Noble Topaz
			23438, -- Star of Elune
			23437, -- Talasite
			23436, -- Living Ruby
			23117, -- Azure Moonstone
			23112, -- Golden Draenite
			23107, -- Shadow Draenite
			23079, -- Deep Peridot
			23077, -- Blood Garnet
			21929, -- Flame Spessarite
			21752, -- Thorium Setting
			20963, -- Mithril Filigree
			20817, -- Bronze Setting
			20816, -- Delicate Copper Wire
			13926, -- Golden Pearl
			12800, -- Azerothian Diamond
			12799, -- Large Opal
			12364, -- Huge Emerald
			12363, -- Arcane Crystal
			12361, -- Blue Sapphire
			11382, -- Blood of the Mountain
			7971, -- Black Pearl
			7910, -- Star Ruby
			7909, -- Aquamarine
			5500, -- Iridescent Pearl
			5498, -- Small Lustrous Pearl
			3864, -- Citrine
			1705, -- Lesser Moonstone
			1529, -- Jade
			1210, -- Shadowgem
			1206, -- Moss Agate
			818, -- Tigerseye
			774, -- Malachite
		},
		[4036] = { -- Engineering
			-- RoA
			169470, -- Pressure Relief Valve
			167649, -- Hundred-Fathom Lure
			167064, -- 500S-Cybergenic Powercore
			168483, -- Protocol Transference Device
			167158, -- Pascal-K1N6's Proprietary Gizmo-matic			
			
			163569, -- Insulated Wiring
			161137, -- Blast-Fired Electric Servomotor
			161136, -- Azerite Forged Protection Plating
			161132, -- Crush Resistant Stabilizer
			161131, -- Barely Stable Azerite Reactor
			160502, -- Chemical Blasting Cap
			144329, -- Hardened Felglass
			140785, -- Hardened Circuitboard Plating
			140784, -- Fel Piston Stabilizer
			140783, -- Predictive Combat Operations Databank
			140782, -- Neural Net Detangler
			140781, -- X-87 Battle Circuit
			136638, -- True Iron Barrel
			136637, -- Oversized Blasting Cap
			136636, -- Sniping Scope
			136633, -- Loose Trigger
			111366, -- Gearspring Parts
			98717, -- Balanced Trillium Ingot
			94113, -- Jard's Peculiar Energy Source
			94111, -- Lightning Steel Ingot
			90146, -- Tinker's Kit
			77468, -- High-Explosive Gunpowder
			77467, -- Ghost Iron Bolts
			67749, -- Electrified Ether
			61981, -- Inferno Ink
			60224, -- Handful of Obsidium Bolts
			52188, -- Jeweler's Setting
			44501, -- Goblin-Machined Piston
			44500, -- Elementium-Plated Exhaust Pipe
			44499, -- Salvaged Iron Golem Parts
			40533, -- Walnut Stock
			39690, -- Volatile Blasting Trigger
			39684, -- Hair Trigger
			39683, -- Froststeel Tube
			39682, -- Overcharged Capacitor
			39681, -- Handful of Cobalt Bolts
			32423, -- Icy Blasting Primers
			23787, -- Felsteel Stabilizer
			23786, -- Khorium Power Core
			23785, -- Hardened Adamantite Tube
			23784, -- Adamantite Frame
			23783, -- Handful of Fel Iron Bolts
			23782, -- Fel Iron Casing
			23781, -- Elemental Blasting Powder
			18631, -- Truesilver Transformer
			17056, -- Light Feather
			16006, -- Delicate Arcanite Converter
			16000, -- Thorium Tube
			15994, -- Thorium Widget
			15992, -- Dense Blasting Powder
			10647, -- Engineer's Ink
			10561, -- Mithril Casing
			10560, -- Unstable Trigger
			10559, -- Mithril Tube
			10558, -- Gold Power Core
			10505, -- Solid Blasting Powder
			9061, -- Goblin Rocket Fuel
			9060, -- Inlaid Mithril Cylinder
			7191, -- Fused Wiring
			7071, -- Iron Buckle
			4611, -- Blue Pearl
			4404, -- Silver Contact
			4400, -- Heavy Stock
			4399, -- Wooden Stock
			4389, -- Gyrochronatom
			4387, -- Iron Strut
			4382, -- Bronze Framework
			4377, -- Heavy Blasting Powder
			4375, -- Whirring Bronze Gizmo
			4371, -- Bronze Tube
			4364, -- Coarse Blasting Powder
			4359, -- Handful of Copper Bolts
			4357, -- Rough Blasting Powder
			814, -- Flask of Oil
		},
		[2259] = { -- Alchemy
			166270, -- Potion of the Unveiling Eye
			163225, -- Battle Potion of Stamina
			163224, -- Battle Potion of Strength
			163223, -- Battle Potion of Agility
			163222, -- Battle Potion of Intellect
			163082, -- Coastal Rejuvenation Potion
			162519, -- Mystical Cauldron
			162113, -- Potion of Herb Tracking
			152668, -- Expulsom
			152641, -- Flask of the Undertow
			152640, -- Flask of the Vast Horizon
			152639, -- Flask of Endless Fathoms
			152638, -- Flask of the Currents
			152615, -- Astral Healing Potion
			152561, -- Potion of Replenishment
			152560, -- Potion of Bursting Blood
			152559, -- Potion of Rising Death
			152550, -- Sea Mist Potion
			152503, -- Potion of Concealment
			152497, -- Lightfoot Potion
			152496, -- Demitri's Draught of Deception
			152495, -- Coastal Mana Potion
			152494, -- Coastal Healing Potion
			151609, -- Tears of the Naaru
			151608, -- Lightblood Elixir
			151568, -- Primal Sargerite
			142117, -- Potion of Prolonged Power
			141323, -- Wild Transmutation
			136653, -- Silvery Salve
			128159, -- Elemental Distillate
			128158, -- Wildswater
			127851, -- Spirit Cauldron
			127850, -- Flask of Ten Thousand Scars
			127849, -- Flask of the Countless Armies
			127848, -- Flask of the Seventh Demon
			127847, -- Flask of the Whispered Pact
			127846, -- Leytorrent Potion
			127844, -- Potion of the Old War
			127843, -- Potion of Deadly Grace
			127841, -- Skystep Potion
			127840, -- Skaggldrynk
			127839, -- Avalanche Elixir
			127838, -- Sylvan Elixir
			127837, -- Draught of Raw Magic
			127836, -- Ancient Rejuvenation Potion
			127835, -- Ancient Mana Potion
			127834, -- Ancient Healing Potion
			124124, -- Blood of Sargeras
			118711, -- Draenic Water Walking Elixir
			118704, -- Pure Rage Potion
			118700, -- Secret of Draenor Alchemy
			118472, -- Savage Blood
			116981, -- Fire Ammonite Oil
			116979, -- Blackwater Anti-Venom
			116276, -- Draenic Living Action Potion
			116271, -- Draenic Water Breathing Elixir
			116268, -- Draenic Invisibility Potion
			116266, -- Draenic Swiftness Potion
			113264, -- Sorcerous Air
			113263, -- Sorcerous Earth
			113262, -- Sorcerous Water
			113261, -- Sorcerous Fire
			112090, -- Transmorphic Tincture
			109226, -- Draenic Rejuvenation Potion
			109223, -- Healing Tonic
			109222, -- Draenic Mana Potion
			109221, -- Draenic Channeled Mana Potion
			109220, -- Draenic Versatility Potion
			109219, -- Draenic Strength Potion
			109218, -- Draenic Intellect Potion
			109217, -- Draenic Agility Potion
			109160, -- Greater Draenic Stamina Flask
			109156, -- Greater Draenic Strength Flask
			109155, -- Greater Draenic Intellect Flask
			109153, -- Greater Draenic Agility Flask
			109152, -- Draenic Stamina Flask
			109148, -- Draenic Strength Flask
			109147, -- Draenic Intellect Flask
			109145, -- Draenic Agility Flask
			109123, -- Crescent Oil
			108996, -- Alchemical Catalyst
			93705, -- Nimble Wild Jade
			93351, -- Potion of Luck
			87872, -- Desecrated Oil
			76701, -- Mystic Sun's Radiance
			76698, -- Subtle Sun's Radiance
			76697, -- Smooth Sun's Radiance
			76684, -- Etched Imperial Amethyst
			76682, -- Veiled Imperial Amethyst
			76675, -- Lucent Vermilion Onyx
			76672, -- Artful Vermilion Onyx
			76669, -- Fierce Vermilion Onyx
			76667, -- Wicked Vermilion Onyx
			76660, -- Potent Vermilion Onyx
			76659, -- Crafty Vermilion Onyx
			76658, -- Deadly Vermilion Onyx
			76657, -- Steady Wild Jade
			76652, -- Jagged Wild Jade
			76648, -- Turbid Wild Jade
			76637, -- Stormy River's Heart
			76142, -- Sun's Radiance
			76141, -- Imperial Amethyst
			76140, -- Vermilion Onyx
			76139, -- Wild Jade
			76138, -- River's Heart
			76132, -- Primal Diamond
			76131, -- Primordial Ruby
			76098, -- Master Mana Potion
			76097, -- Master Healing Potion
			76096, -- Darkwater Potion
			76095, -- Potion of Mogu Power
			76094, -- Alchemist's Rejuvenation
			76093, -- Potion of the Jade Serpent
			76092, -- Potion of Focus
			76089, -- Virmen's Bite
			76088, -- Flask of Winter's Bite
			76087, -- Flask of the Earth
			76086, -- Flask of Falling Leaves
			76085, -- Flask of the Warm Sun
			76084, -- Flask of Spring Blossoms
			76083, -- Monk's Elixir
			76081, -- Elixir of Mirrors
			76080, -- Elixir of Perfection
			76079, -- Elixir of Peace
			76078, -- Elixir of the Rapids
			76077, -- Elixir of Weaponry
			76076, -- Mad Hozen Elixir
			72104, -- Living Steel
			72095, -- Trillium Bar
			68357, -- Lucent Ember Topaz
			67438, -- Flask of Flowing Water
			67415, -- Draught of War
			65460, -- Big Cauldron of Battle
			62288, -- Cauldron of Battle
			58489, -- Potion of Illusion
			58488, -- Potion of Treasure Finding
			58487, -- Potion of Deepholm
			58480, -- Truegold
			58148, -- Elixir of the Master
			58146, -- Golemblood Potion
			58145, -- Potion of the Tol'vir
			58144, -- Elixir of Mighty Speed
			58143, -- Prismatic Elixir
			58142, -- Deathblood Venom
			58094, -- Elixir of Impossible Accuracy
			58092, -- Elixir of the Cobra
			58091, -- Volcanic Potion
			58089, -- Elixir of the Naga
			58088, -- Flask of Titanic Strength
			58087, -- Flask of the Winds
			58086, -- Flask of the Draconic Mind
			58085, -- Flask of Steelskin
			58084, -- Ghost Elixir
			57194, -- Potion of Concentration
			57193, -- Mighty Rejuvenation Potion
			57192, -- Mythical Mana Potion
			57191, -- Mythical Healing Potion
			57099, -- Mysterious Potion
			56850, -- Deepstone Oil
			54464, -- Random Volatile Element
			52303, -- Shadowspirit Diamond
			52247, -- Subtle Amberjewel
			52246, -- Stormy Ocean Sapphire
			52245, -- Steady Dream Emerald
			52241, -- Smooth Amberjewel
			52239, -- Potent Ember Topaz
			52227, -- Nimble Dream Emerald
			52226, -- Mystic Amberjewel
			52223, -- Jagged Dream Emerald
			52217, -- Veiled Demonseye
			52214, -- Fierce Ember Topaz
			52213, -- Etched Demonseye
			52209, -- Deadly Ember Topaz
			52205, -- Artful Ember Topaz
			52195, -- Amberjewel
			52194, -- Demonseye
			52193, -- Ember Topaz
			52192, -- Dream Emerald
			52191, -- Ocean Sapphire
			52190, -- Inferno Ruby
			51950, -- Pyrium Bar
			46379, -- Flask of Stoneblood
			46378, -- Flask of Pure Mojo
			46377, -- Flask of Endless Rage
			46376, -- Flask of the Frost Wyrm
			45621, -- Elixir of Minor Accuracy
			44958, -- Ethereal Oil
			44332, -- Elixir of Mighty Thoughts
			44331, -- Elixir of Lightning Speed
			44330, -- Elixir of Armor Piercing
			44329, -- Elixir of Expertise
			44327, -- Elixir of Deadly Strikes
			44325, -- Elixir of Accuracy
			41334, -- Earthsiege Diamond
			41266, -- Skyflare Diamond
			41163, -- Titanium Bar
			40217, -- Mighty Shadow Protection Potion
			40216, -- Mighty Nature Protection Potion
			40215, -- Mighty Frost Protection Potion
			40214, -- Mighty Fire Protection Potion
			40213, -- Mighty Arcane Protection Potion
			40212, -- Potion of Wild Magic
			40211, -- Potion of Speed
			40195, -- Pygmy Oil
			40173, -- Turbid Eye of Zul
			40168, -- Steady Eye of Zul
			40166, -- Nimble Eye of Zul
			40165, -- Jagged Eye of Zul
			40153, -- Veiled Dreadstone
			40152, -- Potent Ametrine
			40149, -- Lucent Ametrine
			40147, -- Deadly Ametrine
			40146, -- Fierce Ametrine
			40143, -- Etched Dreadstone
			40127, -- Mystic King's Amber
			40124, -- Smooth King's Amber
			40122, -- Stormy Majestic Zircon
			40115, -- Subtle King's Amber
			40109, -- Elixir of Mighty Mageblood
			40087, -- Powerful Rejuvenation Potion
			40081, -- Potion of Nightmares
			40079, -- Lesser Flask of Toughness
			40078, -- Elixir of Mighty Fortitude
			40077, -- Crazy Alchemist's Potion
			40076, -- Guru's Elixir
			40073, -- Elixir of Mighty Strength
			40072, -- Elixir of Versatility
			40070, -- Spellpower Elixir
			40068, -- Wrath Elixir
			40067, -- Icy Mana Potion
			39671, -- Resurgent Healing Potion
			39666, -- Elixir of Mighty Agility
			36934, -- Eye of Zul
			36931, -- Ametrine
			36928, -- Dreadstone
			36925, -- Majestic Zircon
			36922, -- King's Amber
			36919, -- Cardinal Ruby
			36860, -- Eternal Fire
			35627, -- Eternal Shadow
			35625, -- Eternal Life
			35624, -- Eternal Earth
			35623, -- Eternal Air
			35622, -- Eternal Water
			34440, -- Mad Alchemist's Potion
			33448, -- Runic Mana Potion
			33447, -- Runic Healing Potion
			32852, -- Cauldron of Major Shadow Protection
			32851, -- Cauldron of Major Nature Protection
			32850, -- Cauldron of Major Frost Protection
			32849, -- Cauldron of Major Fire Protection
			32839, -- Cauldron of Major Arcane Protection
			32068, -- Elixir of Ironskin
			32067, -- Elixir of Draenic Wisdom
			32063, -- Earthen Elixir
			32062, -- Elixir of Major Fortitude
			31679, -- Fel Strength Elixir
			31677, -- Fel Mana Potion
			31676, -- Fel Regeneration Potion
			28104, -- Elixir of Mastery
			28103, -- Adept's Elixir
			28102, -- Onslaught Elixir
			28101, -- Unstable Mana Potion
			28100, -- Volatile Healing Potion
			25899, -- Brutal Earthstorm Diamond
			25868, -- Skyfire Diamond
			25867, -- Earthstorm Diamond
			23571, -- Primal Might
			22871, -- Shrouding Potion
			22866, -- Flask of Pure Death
			22861, -- Flask of Blinding Light
			22854, -- Flask of Relentless Assault
			22853, -- Flask of Mighty Versatility
			22851, -- Flask of Fortification
			22850, -- Super Rejuvenation Potion
			22848, -- Elixir of Empowerment
			22847, -- Major Holy Protection Potion
			22846, -- Major Shadow Protection Potion
			22845, -- Major Arcane Protection Potion
			22844, -- Major Nature Protection Potion
			22842, -- Major Frost Protection Potion
			22841, -- Major Fire Protection Potion
			22840, -- Elixir of Major Mageblood
			22839, -- Destruction Potion
			22838, -- Haste Potion
			22837, -- Heroic Potion
			22836, -- Major Dreamless Sleep Potion
			22835, -- Elixir of Major Shadow Power
			22833, -- Elixir of Major Firepower
			22832, -- Super Mana Potion
			22831, -- Elixir of Major Agility
			22830, -- Elixir of the Searching Eye
			22829, -- Super Healing Potion
			22828, -- Insane Strength Potion
			22827, -- Elixir of Major Frost Power
			22826, -- Sneaking Potion
			22825, -- Elixir of Healing Power
			22824, -- Elixir of Major Strength
			22823, -- Elixir of Camouflage
			22457, -- Primal Mana
			22456, -- Primal Shadow
			22452, -- Primal Earth
			22451, -- Primal Air
			21886, -- Primal Life
			21885, -- Primal Water
			21884, -- Primal Fire
			21546, -- Elixir of Greater Firepower
			20008, -- Living Action Potion
			20007, -- Mageblood Elixir
			20004, -- Mighty Troll's Blood Elixir
			20002, -- Greater Dreamless Sleep Potion
			19440, -- Powerful Anti-Venom
			18294, -- Elixir of Greater Water Breathing
			18253, -- Major Rejuvenation Potion
			17708, -- Elixir of Frost Power
			13512, -- Flask of Supreme Power
			13511, -- Flask of Distilled Wisdom
			13510, -- Flask of the Titans
			13506, -- Potion of Petrification
			13462, -- Purification Potion
			13461, -- Greater Arcane Protection Potion
			13459, -- Greater Shadow Protection Potion
			13458, -- Greater Nature Protection Potion
			13457, -- Greater Fire Protection Potion
			13456, -- Greater Frost Protection Potion
			13454, -- Greater Arcane Elixir
			13453, -- Elixir of Brute Force
			13452, -- Elixir of the Mongoose
			13447, -- Elixir of the Sages
			13446, -- Major Healing Potion
			13444, -- Major Mana Potion
			13443, -- Superior Mana Potion
			13442, -- Mighty Rage Potion
			13423, -- Stonescale Oil
			12808, -- Essence of Undeath
			12803, -- Living Essence
			12360, -- Arcanite Bar
			12190, -- Dreamless Sleep Potion
			10592, -- Catseye Elixir
			9264, -- Elixir of Shadow Power
			9233, -- Elixir of Detect Demon
			9224, -- Elixir of Demonslaying
			9210, -- Ghost Dye
			9206, -- Elixir of Giants
			9197, -- Elixir of Dream Vision
			9187, -- Elixir of Greater Agility
			9179, -- Elixir of Greater Intellect
			9172, -- Invisibility Potion
			9155, -- Arcane Elixir
			9154, -- Elixir of Detect Undead
			9144, -- Wildvine Potion
			9088, -- Gift of Arthas
			9061, -- Goblin Rocket Fuel
			9030, -- Restorative Potion
			8956, -- Oil of Immolation
			8949, -- Elixir of Agility
			8827, -- Elixir of Water Walking
			7082, -- Essence of Air
			7080, -- Essence of Water
			7078, -- Essence of Fire
			7076, -- Essence of Earth
			7068, -- Elemental Fire
			6662, -- Elixir of Giant Growth
			6453, -- Strong Anti-Venom
			6452, -- Anti-Venom
			6373, -- Elixir of Firepower
			6372, -- Swim Speed Potion
			6371, -- Fire Oil
			6370, -- Blackmouth Oil
			6149, -- Greater Mana Potion
			6052, -- Nature Protection Potion
			6051, -- Holy Protection Potion
			6050, -- Frost Protection Potion
			6049, -- Fire Protection Potion
			6048, -- Shadow Protection Potion
			6037, -- Truesilver Bar
			5997, -- Elixir of Minor Defense
			5996, -- Elixir of Water Breathing
			5634, -- Free Action Potion
			5633, -- Great Rage Potion
			5631, -- Rage Potion
			4596, -- Discolored Healing Potion
			3928, -- Superior Healing Potion
			3829, -- Frost Oil
			3828, -- Elixir of Detect Lesser Invisibility
			3827, -- Mana Potion
			3826, -- Major Troll's Blood Elixir
			3825, -- Elixir of Fortitude
			3824, -- Shadow Oil
			3823, -- Lesser Invisibility Potion
			3577, -- Gold Bar
			3391, -- Elixir of Ogre's Strength
			3390, -- Elixir of Lesser Agility
			3388, -- Strong Troll's Blood Elixir
			3387, -- Limited Invulnerability Potion
			3386, -- Potion of Curing
			3385, -- Lesser Mana Potion
			3383, -- Elixir of Wisdom
			3382, -- Weak Troll's Blood Elixir
			2459, -- Swiftness Potion
			2458, -- Elixir of Minor Fortitude
			2457, -- Elixir of Minor Agility
			2456, -- Minor Rejuvenation Potion
			2455, -- Minor Mana Potion
			2454, -- Elixir of Lion's Strength
			1710, -- Greater Healing Potion
			929, -- Healing Potion
			858, -- Lesser Healing Potion
			118, -- Minor Healing Potion
		},
		[2018] = { -- Blacksmithing
			162120, -- Platinum Whetstone
			162115, -- Magnetic Mining Pick
			162109, -- Storm Silver Spurs
			159826, -- Monelite Skeleton Key
			152813, -- Monel-Hardened Stirrups
			152812, -- Monel-Hardened Hoofplates
			151923, -- Empyrial Rivet
			136708, -- Demonsteel Stirrups
			128777, -- Heated Leystone Bar
			128016, -- Steelforged Essence
			128015, -- Truesteel Essence
			127732, -- Savage Truesteel Essence
			127731, -- Savage Steelforged Essence
			127714, -- Mighty Truesteel Essence
			127713, -- Mighty Steelforged Essence
			124461, -- Demonsteel Bar
			124455, -- Masterwork Leystone Armguards
			124454, -- Brimstone-Crusted Armguards
			124453, -- Brimstone-Covered Armguards
			124450, -- Engraved Leystone Armguards
			124435, -- Leystone Neckplate
			124434, -- Handmade Leystone Helm
			124433, -- Handmade Leystone Boots
			124432, -- Leystone Dome
			124431, -- Leystone Faceguard
			124430, -- Leystone Soleplate
			124429, -- Leystone Footguard
			124428, -- Leystone Heelguard
			124427, -- Leystone Shinplate
			124424, -- Hard Leystone Nail
			124423, -- Heated Hard Leystone Ingot
			124422, -- Hard Leystone Ingot
			124421, -- Lump of Leystone Slag
			124420, -- Leystone Shard
			124419, -- Hard Leystone Bar
			124418, -- Leystone Slag
			124411, -- Scrapmetal Cuffplate
			124410, -- Scrapmetal Handguard
			124409, -- Scrapmetal Palmplate
			124408, -- Scrapmetal Fingerplates
			124407, -- Large Heated Metal Scrap
			124406, -- Medium Heated Metal Scrap
			124405, -- Small Heated Metal Scrap
			124397, -- Hard Leystone Armguards
			124396, -- Dull Hard Leystone Armguards
			124395, -- Heated Hard Leystone Bar
			124394, -- Hard Leystone Bar
			124393, -- Leystone Slag
			124049, -- Handcrafted Leystone Gauntlets
			124010, -- Leystone Fingerguard
			124009, -- Leystone Cuffplate
			124007, -- Leystone Bar
			123956, -- Leystone Hoofplates
			118720, -- Secret of Draenor Blacksmithing
			116654, -- Truesteel Grinder
			116428, -- Truesteel Reshaper
			108257, -- Truesteel Ingot
			98717, -- Balanced Trillium Ingot
			94111, -- Lightning Steel Ingot
			90046, -- Living Steel Belt Buckle
			86599, -- Ghost Iron Shield Spike
			86597, -- Living Steel Weapon Chain
			82960, -- Ghostly Skeleton Key
			65365, -- Folded Obsidium
			55057, -- Pyrium Weapon Chain
			55056, -- Pyrium Shield Spike
			55055, -- Elementium Shield Spike
			55054, -- Ebonsteel Belt Buckle
			55053, -- Obsidium Skeleton Key
			44936, -- Titanium Plating
			43854, -- Cobalt Skeleton Key
			43853, -- Titanium Skeleton Key
			42500, -- Titanium Shield Spike
			41976, -- Titanium Weapon Chain
			41611, -- Eternal Belt Buckle
			33185, -- Adamantite Weapon Chain
			28421, -- Adamantite Weightstone
			28420, -- Fel Weightstone
			25521, -- Greater Rune of Warding
			23576, -- Greater Ward of Shielding
			23575, -- Lesser Ward of Shielding
			23559, -- Lesser Rune of Warding
			23530, -- Felsteel Shield Spike
			23529, -- Adamantite Sharpening Stone
			23528, -- Fel Sharpening Stone
			18262, -- Elemental Sharpening Stone
			15872, -- Arcanite Skeleton Key
			15871, -- Truesilver Skeleton Key
			15870, -- Golden Skeleton Key
			15869, -- Silver Skeleton Key
			12645, -- Thorium Shield Spike
			12644, -- Dense Grinding Stone
			12643, -- Dense Weightstone
			12404, -- Dense Sharpening Stone
			9060, -- Inlaid Mithril Cylinder
			7967, -- Mithril Shield Spike
			7966, -- Solid Grinding Stone
			7965, -- Solid Weightstone
			7964, -- Solid Sharpening Stone
			7071, -- Iron Buckle
			6043, -- Iron Counterweight
			6042, -- Iron Shield Spike
			6041, -- Steel Weapon Chain
			3486, -- Heavy Grinding Stone
			3478, -- Coarse Grinding Stone
			3470, -- Rough Grinding Stone
			3241, -- Heavy Weightstone
			3240, -- Coarse Weightstone
			3239, -- Rough Weightstone
			2871, -- Heavy Sharpening Stone
			2863, -- Coarse Sharpening Stone
			2862, -- Rough Sharpening Stone
		},
		[7620] = { -- Fishing
			174328, --  Aberrant Voidfin
			174327, --  Malformed Gnasher
			168646, --  Mauve Stinger
			168302, --  Viper Fish
			152549, --  Redtail Loach
			152548, --  Tiragarde Perch
			152547, --  Great Sea Catfish
			152546, --  Lane Snapper
			152545, --  Frenzied Fangtooth
			152544, --  Slimy Mackerel
			152543, --  Sand Shifter
			139669, --  Ancient Black Barracuda
			139667, --  Axefish
			139666, --  Tainted Runescale Koi
			139664, --  Magic-Eater Frog
			139663, --  Thundering Stormray
			139662, --  Graybelly Lobster
			139661, --  Oodelfjisk
			139660, --  Ancient Highmountain Salmon
			139659, --  Coldriver Carp
			139658, --  Mountain Puffer
			139657, --  Ancient Mossgill
			139656, --  Thorned Flounder
			139655, --  Terrorfin
			139654, --  Ghostly Queenfish
			139653, --  Nar'thalas Hermit
			139652, --  Leyshimmer Blenny
			138967, --  Big Fountain Goldfish
			133742, --  Ancient Black Barracuda
			133740, --  Axefish
			133739, --  Tainted Runescale Koi
			133737, --  Magic-Eater Frog
			133736, --  Thundering Stormray
			133735, --  Graybelly Lobster
			133734, --  Oodelfjisk
			133733, --  Ancient Highmountain Salmon
			133732, --  Coldriver Carp
			133731, --  Mountain Puffer
			133730, --  Ancient Mossgill
			133729, --  Thorned Flounder
			133728, --  Terrorfin
			133727, --  Ghostly Queenfish
			133726, --  Nar'thalas Hermit
			133725, --  Leyshimmer Blenny
			133607, --  Silver Mackerel
			127994, --  Felmouth Frenzy Lunker
			127991, --  Felmouth Frenzy
			124669, --  Darkmoon Daggermaw
			124112, --  Black Barracuda
			124111, --  Runescale Koi
			124110, --  Stormray
			124109, --  Highmountain Salmon
			124108, --  Mossgill Perch
			124107, --  Cursed Queenfish
			122696, --  Sea Scorpion Lunker
			118565, --  Savage Piranha
			116822, --  Jawless Skulker Lunker
			116821, --  Fat Sleeper Lunker
			116820, --  Blind Lake Lunker
			116819, --  Fire Ammonite Lunker
			116818, --  Abyssal Gulper Lunker
			116817, --  Blackwater Whiptail Lunker
			111676, --  Enormous Jawless Skulker
			111675, --  Enormous Fat Sleeper
			111674, --  Enormous Blind Lake Sturgeon
			111673, --  Enormous Fire Ammonite
			111672, --  Enormous Sea Scorpion
			111671, --  Enormous Abyssal Gulper Eel
			111670, --  Enormous Blackwater Whiptail
			111669, --  Jawless Skulker
			111668, --  Fat Sleeper
			111667, --  Blind Lake Sturgeon
			111666, --  Fire Ammonite
			111665, --  Sea Scorpion
			111664, --  Abyssal Gulper Eel
			111663, --  Blackwater Whiptail
			111662, --  Small Blackwater Whiptail
			111659, --  Small Abyssal Gulper Eel
			111658, --  Small Sea Scorpion
			111656, --  Small Fire Ammonite
			111652, --  Small Blind Lake Sturgeon
			111651, --  Small Fat Sleeper
			111650, --  Small Jawless Skulker
			111601, --  Enormous Crescent Saberfish
			111595, --  Crescent Saberfish
			111589, --  Small Crescent Saberfish
			74866, --  Golden Carp
			74865, --  Krasarang Paddlefish
			74864, --  Reef Octopus
			74863, --  Jewel Danio
			74861, --  Tiger Gourami
			74860, --  Redbelly Mandarin
			74859, --  Emperor Salmon
			74857, --  Giant Mantis Shrimp
			74856, --  Jade Lungfish
			62778, --  Toughened Flesh
			53072, --  Deepsea Sagefish
			53071, --  Algaefin Rockfish
			53070, --  Fathom Eel
			53069, --  Murglesnout
			53068, --  Lavascale Catfish
			53067, --  Striped Lurker
			53066, --  Blackbelly Mudfish
			53065, --  Albino Cavefish
			53064, --  Highland Guppy
			53063, --  Mountain Trout
			53062, --  Sharptooth
			43652, --  Slippery Eel
			43647, --  Shimmering Minnow
			43646, --  Fountain Goldfish
			43572, --  Magic Eater
			43571, --  Sewer Carp
			41814, --  Glassfin Minnow
			41813, --  Nettlefish
			41812, --  Barrelhead Goby
			41810, --  Fangtooth Herring
			41809, --  Glacial Salmon
			41808, --  Bonescale Snapper
			41807, --  Dragonfin Angelfish
			41806, --  Musselback Sculpin
			41805, --  Borean Man O' War
			41803, --  Rockfin Grouper
			41802, --  Imperial Manta Ray
			41801, --  Moonglow Cuttlefish
			41800, --  Deep Sea Monsterbelly
			37588, --  Mostly Digested Fish
			35285, --  Giant Sunfish
			33824, --  Crescent-Tail Skullfish
			33823, --  Bloodfin Catfish
			27439, --  Furious Crawdad
			27438, --  Golden Darter
			27437, --  Icefin Bluefish
			27435, --  Figluster's Mudfish
			27429, --  Zangarian Sporefish
			27425, --  Spotted Feltail
			27422, --  Barbed Gill Trout
			23676, --  Moongraze Stag Tenderloin
			21153, --  Raw Greater Sagefish
			21071, --  Raw Sagefish
			13889, --  Raw Whitescale Salmon
			13888, --  Darkclaw Lobster
			13760, --  Raw Sunscale Salmon
			13759, --  Raw Nightfin Snapper
			13758, --  Raw Redgill
			13756, --  Raw Summer Bass
			13754, --  Raw Glossy Mightfish
			8365, --  Raw Mithril Head Trout
			6362, --  Raw Rockscale Cod
			6361, --  Raw Rainbow Fin Albacore
			6317, --  Raw Loch Frenzy
			6308, --  Raw Bristle Whisker Catfish
			6303, --  Raw Slitherskin Mackerel
			6291, --  Raw Brilliant Smallfish
			6289, --  Raw Longjaw Mud Snapper
			4603, --  Raw Spotted Yellowtail
		},
		[2550] = { -- Cooking
			166344, -- Seasoned Steak and Potatoes
			166343, -- Wild Berry Bread
			166240, -- Sanguinated Feast
			165755, -- Honey Potpie
			163781, -- Heartsbane Hexwurst
			156526, -- Bountiful Captain's Feast
			156525, -- Galley Banquet
			154891, -- Seasoned Loins
			154889, -- Grilled Catfish
			154888, -- Sailor's Pie
			154887, -- Loa Loaf
			154886, -- Spiced Snapper
			154885, -- Mon'Dazi
			154884, -- Swamp Fish 'n Chips
			154883, -- Ravenberry Tarts
			154882, -- Honey-Glazed Haunches
			154881, -- Kul Tiramisu
			152564, -- Feast of the Fishes
			142334, -- Spiced Falcosaur Omelet
			133681, -- Crispy Bacon
			133579, -- Lavish Suramar Feast
			133578, -- Hearty Feast
			133577, -- Fighter Chow
			133576, -- Bear Tartare
			133575, -- Dried Mackerel Strips
			133574, -- Fishbrul Special
			133573, -- Seed-Battered Fish Plate
			133572, -- Nightborne Delicacy Platter
			133571, -- Azshari Salad
			133570, -- The Hungry Magister
			133569, -- Drogbar-Style Salmon
			133568, -- Koi-Scented Stormray
			133567, -- Barracuda Mrglgagh
			133566, -- Suramar Surf and Turf
			133565, -- Leybeque Ribs
			133564, -- Spiced Rib Roast
			133563, -- Faronaar Fizz
			133562, -- Pickled Stormray
			133561, -- Deep-Fried Mossgill
			133557, -- Salt & Pepper Shank
			128498, -- Fel Eggs and Ham
			126936, -- Sugar-Crusted Fish Feast
			126935, -- Fancy Darkmoon Feast
			126934, -- Lemon Herb Filet
			122348, -- Buttered Sturgeon
			122347, -- Whiptail Fillet
			122346, -- Jumbo Sea Dog
			122345, -- Pickled Eel
			122344, -- Salty Squid Roll
			122343, -- Sleeper Sushi
			111458, -- Feast of the Waters
			111457, -- Feast of Blood
			111456, -- Grilled Saberfish
			111455, -- Saberfish Broth
			111454, -- Gorgrond Chowder
			111453, -- Calamari Crepes
			111452, -- Sleeper Surprise
			111450, -- Frosty Stew
			111449, -- Blackrock Barbecue
			111447, -- Talador Surf and Turf
			111446, -- Skulker Chowder
			111445, -- Fiery Calamari
			111444, -- Fat Sleeper Cakes
			111442, -- Sturgeon Stew
			111441, -- Grilled Gulper
			111439, -- Steamed Scorpion
			111438, -- Clefthoof Sausages
			111437, -- Rylak Crepes
			111436, -- Braised Riverbeast
			111434, -- Pan-Seared Talbuk
			111433, -- Blackrock Ham
			111431, -- Hearty Elekk Steak
			101750, -- Fluffy Silkfeather Omelet
			101749, -- Stuffed Lushrooms
			101748, -- Spiced Blossom Soup
			101747, -- Farmer's Delight
			101746, -- Seasoned Pomfruit Slices
			101745, -- Mango Ice
			101662, -- Pandaren Treasure Noodle Cart Kit
			101661, -- Deluxe Noodle Cart Kit
			101630, -- Noodle Cart Kit
			87264, -- Four Senses Brew
			87248, -- Great Banquet of the Brew
			87246, -- Banquet of the Brew
			87244, -- Great Banquet of the Oven
			87242, -- Banquet of the Oven
			87240, -- Great Banquet of the Steamer
			87238, -- Banquet of the Steamer
			87236, -- Great Banquet of the Pot
			87234, -- Banquet of the Pot
			87232, -- Great Banquet of the Wok
			87230, -- Banquet of the Wok
			87228, -- Great Banquet of the Grill
			87226, -- Banquet of the Grill
			86432, -- Banana Infused Rum
			86074, -- Spicy Vegetable Chips
			86073, -- Spicy Salmon
			86070, -- Wildfowl Ginseng Soup
			86069, -- Rice Pudding
			86057, -- Sliced Peaches
			86026, -- Perfectly Cooked Instant Noodles
			85504, -- Krasarang Fritters
			85501, -- Viseclaw Soup
			81414, -- Pearl Milk Tea
			81413, -- Skewered Peanut Chicken
			81412, -- Blanched Needle Mushrooms
			81411, -- Peach Pie
			81410, -- Green Curry Fish
			81409, -- Tangy Yogurt
			81408, -- Red Bean Bun
			81406, -- Roasted Barley Tea
			81405, -- Boiled Silkworm Pupa
			81404, -- Dried Needle Mushrooms
			81403, -- Dried Peaches
			81402, -- Toasted Fish Jerky
			81401, -- Yak Cheese Curds
			81400, -- Pounded Rice Cake
			75038, -- Mad Brewer's Breakfast
			75037, -- Jade Witch Brew
			75026, -- Ginseng Tea
			75016, -- Great Pandaren Banquet
			74919, -- Pandaren Banquet
			74656, -- Chun Tian Spring Rolls
			74655, -- Twin Fish Platter
			74654, -- Wildfowl Roast
			74653, -- Steamed Crab Surprise
			74652, -- Fire Spirit Salmon
			74651, -- Shrimp Dumplings
			74650, -- Mogu Fish Stew
			74649, -- Braised Turtle
			74648, -- Sea Mist Rice Noodles
			74647, -- Valley Stir Fry
			74646, -- Black Pepper Ribs and Shrimp
			74645, -- Eternal Blossom Fish
			74644, -- Swirling Mist Soup
			74643, -- Sauteed Carrots
			74642, -- Charbroiled Tiger Steak
			74641, -- Fish Cake
			74636, -- Golden Carp Consomme
			68687, -- Scalding Murglesnout
			67230, -- Venison Jerky
			62790, -- Darkbrew Lager
			62680, -- Chocolate Cookie
			62677, -- Fish Fry
			62676, -- Blackened Surprise
			62675, -- Starfire Espresso
			62674, -- Highland Spirits
			62673, -- Feathered Lure
			62672, -- South Island Iced Tea
			62671, -- Severed Sagefish Head
			62670, -- Beer-Basted Crocolisk
			62669, -- Skewered Eel
			62668, -- Blackbelly Sushi
			62667, -- Mushroom Sauce Mudfish
			62666, -- Delicious Sagefish Tail
			62665, -- Basilisk Liverdog
			62664, -- Crocolisk Au Gratin
			62663, -- Lavascale Minestrone
			62662, -- Grilled Dragon
			62661, -- Baked Rockfish
			62660, -- Pickled Guppy
			62659, -- Hearty Seafood Soup
			62658, -- Tender Baked Turtle
			62657, -- Lurker Lunch
			62656, -- Whitecrest Gumbo
			62655, -- Broiled Mountain Trout
			62654, -- Lavascale Fillet
			62653, -- Salted Eye
			62652, -- Seasoned Crab
			62651, -- Lightly Fried Lurker
			62649, -- Fortune Cookie
			62290, -- Seafood Magnifique Feast
			62289, -- Broiled Dragon Feast
			46691, -- Bread of the Dead
			45932, -- Black Jelly
			44953, -- Worg Tartare
			44840, -- Cranberry Chutney
			44839, -- Candied Sweet Potato
			44838, -- Slow-Roasted Turkey
			44837, -- Spice Bread Stuffing
			44836, -- Pumpkin Pie
			43492, -- Haunted Herring
			43491, -- Bad Clams
			43490, -- Tasty Cupcake
			43488, -- Last Week's Mammoth
			43480, -- Small Feast
			43478, -- Gigantic Feast
			43268, -- Dalaran Clam Chowder
			43015, -- Fish Feast
			43005, -- Spiced Mammoth Treats
			43004, -- Critter Bites
			43001, -- Tracker Snacks
			43000, -- Dragonfin Filet
			42999, -- Blackened Dragonfin
			42998, -- Cuttlesteak
			42997, -- Blackened Worg Steak
			42996, -- Snapper Extreme
			42995, -- Hearty Rhino
			42994, -- Rhinolicious Wormsteak
			42993, -- Spicy Fried Herring
			42942, -- Baked Manta Ray
			39520, -- Kungaloosh
			35565, -- Juicy Bear Burger
			35563, -- Charred Bear Kabobs
			34832, -- Captain Rumsey's Lager
			34769, -- Imperial Manta Steak
			34768, -- Spicy Blue Nettlefish
			34767, -- Firecracker Salmon
			34766, -- Poached Northern Sculpin
			34765, -- Pickled Fangtooth
			34764, -- Poached Nettlefish
			34763, -- Smoked Salmon
			34762, -- Grilled Sculpin
			34761, -- Sauteed Goby
			34760, -- Grilled Bonescale
			34759, -- Smoked Rockfin
			34758, -- Mighty Rhino Dogs
			34757, -- Very Burnt Worg
			34756, -- Spiced Worm Burger
			34755, -- Tender Shoveltusk Steak
			34754, -- Mega Mammoth Meal
			34753, -- Great Feast
			34752, -- Rhino Dogs
			34751, -- Roasted Worg
			34750, -- Worm Delight
			34749, -- Shoveltusk Steak
			34748, -- Mammoth Meal
			34747, -- Northern Stew
			34411, -- Hot Apple Cider
			33924, -- Delicious Chocolate Cake
			33874, -- Kibler's Bits
			33872, -- Spicy Hot Talbuk
			33867, -- Broiled Bloodfin
			33866, -- Stormchops
			33825, -- Skullfish Soup
			33053, -- Hot Buttered Trout
			33052, -- Fisherman's Feast
			33048, -- Stewed Trout
			33004, -- Clamlette Magnifique
			31673, -- Crunchy Serpent
			31672, -- Mok'Nathal Shortribs
			30816, -- Spice Bread
			30155, -- Clam Bar
			27667, -- Spicy Crawdad
			27666, -- Golden Fish Sticks
			27665, -- Poached Bluefish
			27664, -- Grilled Mudfish
			27663, -- Blackened Sporefish
			27662, -- Feltail Delight
			27661, -- Blackened Trout
			27660, -- Talbuk Steak
			27659, -- Warp Burger
			27658, -- Roasted Clefthoof
			27657, -- Blackened Basilisk
			27655, -- Ravager Dog
			27651, -- Buzzard Bites
			27636, -- Bat Bites
			27635, -- Lynx Steak
			24105, -- Roasted Moongraze Tenderloin
			22645, -- Crunchy Spider Surprise
			21217, -- Sagefish Delight
			21072, -- Smoked Sagefish
			21023, -- Dirge's Kickin' Chimaerok Chops
			20452, -- Smoked Desert Dumplings
			20074, -- Heavy Crocolisk Stew
			18254, -- Runn Tum Tuber Surprise
			18045, -- Tender Wolf Steak
			17222, -- Spider Sausage
			17198, -- Winter Veil Egg Nog
			17197, -- Gingerbread Cookie
			16766, -- Undermine Clam Chowder
			13935, -- Baked Salmon
			13934, -- Mightfish Steak
			13933, -- Lobster Stew
			13932, -- Poached Sunscale Salmon
			13931, -- Nightfin Soup
			13930, -- Filet of Redgill
			13929, -- Hot Smoked Bass
			13928, -- Grilled Squid
			13927, -- Cooked Glossy Mightfish
			13851, -- Hot Wolf Ribs
			12224, -- Crispy Bat Wing
			12218, -- Monster Omelet
			12217, -- Dragonbreath Chili
			12216, -- Spiced Chili Crab
			12215, -- Heavy Kodo Stew
			12214, -- Mystery Stew
			12213, -- Carrion Surprise
			12212, -- Jungle Stew
			12210, -- Roast Raptor
			12209, -- Lean Wolf Steak
			10841, -- Goldthorn Tea
			8364, -- Mithril Head Trout
			7676, -- Thistle Tea
			6890, -- Smoked Bear Meat
			6888, -- Herb Baked Egg
			6887, -- Spotted Yellowtail
			6657, -- Savory Deviate Delight
			6316, -- Loch Frenzy Delight
			6290, -- Brilliant Smallfish
			6038, -- Giant Clam Scorcho
			5527, -- Goblin Deviled Clams
			5526, -- Clam Chowder
			5525, -- Boiled Clams
			5480, -- Lean Venison
			5479, -- Crispy Lizard Tail
			5478, -- Dig Rat Stew
			5477, -- Strider Stew
			5476, -- Fillet of Frenzy
			5474, -- Roasted Kodo Meat
			5473, -- Scorpid Surprise
			5472, -- Kaldorei Spider Kabob
			5095, -- Rainbow Fin Albacore
			4594, -- Rockscale Cod
			4593, -- Bristle Whisker Catfish
			4592, -- Longjaw Mud Snapper
			4457, -- Barbecued Buzzard Wing
			3729, -- Soothing Turtle Bisque
			3728, -- Tasty Lion Steak
			3727, -- Hot Lion Chops
			3726, -- Big Bear Steak
			3666, -- Gooey Spider Cake
			3665, -- Curiously Tasty Omelet
			3664, -- Crocolisk Gumbo
			3663, -- Murloc Fin Soup
			3662, -- Crocolisk Steak
			3220, -- Blood Sausage
			2888, -- Beer Basted Boar Ribs
			2687, -- Dry Pork Ribs
			2685, -- Succulent Pork Ribs
			2684, -- Coyote Steak
			2683, -- Crab Cake
			2682, -- Cooked Crab Claw
			2681, -- Roasted Boar Meat
			2680, -- Spiced Wolf Meat
			2679, -- Charred Wolf Meat
			1082, -- Redridge Goulash
			1017, -- Seasoned Wolf Kabob
			787, -- Slitherskin Mackerel
			733, -- Westfall Stew
			724, -- Goretusk Liver Pie
		},
	},
	others = {
		173363, -- Vessel of Horrific Visions
		163036, -- Polished Pet Charm, added in patch 8.0.1.26624
		157796, -- Purified Titan Essence, added in 7.3.5.25807
		124099, -- Blackfang Claw
		119819, -- Caged Mighty Clefthoof
		119817, -- Caged Mighty Riverbeast
		119815, -- Caged Mighty Wolf
		119814, -- Leathery Caged Beast
		119813, -- Furry Caged Beast
		119810, -- Meaty Caged Beast
		118100, -- Highmaul Relic
		117397, -- Nats Lucky Coin
		116415, -- Pet Charm
		113578, -- Hearty Soup Bone
		101529, -- Celestial Coin
		76061, -- Spirit of Harmony
		43089, -- Vrykul Bones
		28558, -- Spirit Shard, currency tokens dropped by bosses in the Auchindoun
		162517, -- U'taka
		162516, -- Rasboralus
		162515, -- Midnight Salmon
		160298, -- Durable Flux
		160059, -- Amber Tanning Oil
		158205, -- Acacia Powder
		158186, -- Distilled Water
		142335, -- Pristine Falcosaur Feather
		137597, -- Oily Transmutagen
		137596, -- Black Transmutagen
		137595, -- Viscous Transmutagen
		127759, -- Felblight
		124439, -- Unbroken Tooth
		124438, -- Unbroken Claw
		124436, -- Foxflower Flux
		118472, -- Savage Blood
		115524, -- Taladite Crystal
		114781, -- Timber
		112377, -- War Paints
		109123, -- Crescent Oil
		108996, -- Alchemical Catalyst
		90407, -- Sparkling Shard
		83092, -- Orb of Mystery
		83064, -- Spinefish
		71998, -- Essence of Destruction
		69237, -- Living Ember
		65893, -- Sands of Time
		65892, -- Pyrium-Laced Crystalline Vial
		62786, -- Cocoa Beans
		56850, -- Deepstone Oil
		52078, -- Chaos Orb
		49908, -- Primordial Saronite
		47556, -- Crusader Orb
		45087, -- Runed Orb
		44958, -- Ethereal Oil
		44853, -- Honey
		44835, -- Autumnal Herbs
		43102, -- Frozen Orb
		43007, -- Northern Spices
		40199, -- Pygmy Suckerfish
		40195, -- Pygmy Oil
		39354, -- Light Parchment
		34664, -- Sunmote
		32428, -- Heart of Darkness
		30817, -- Simple Flour
		21882, -- Soul Essence
		20520, -- Dark Rune
		19943, -- Massive Mojo
		19441, -- Huge Venom Sac
		18240, -- Ogre Tannin
		17011, -- Lava Core
		17010, -- Fiery Core
		13757, -- Lightning Eel
		13423, -- Stonescale Oil
		13422, -- Stonescale Eel
		12811, -- Righteous Orb
		12804, -- Powerful Mojo
		12662, -- Demonic Rune
		11291, -- Star Wood
		10290, -- Pink Dye
		9262, -- Black Vitriol
		9210, -- Ghost Dye
		7072, -- Naga Scale
		6371, -- Fire Oil
		6370, -- Blackmouth Oil
		6359, -- Firefin Snapper
		6358, -- Oily Blackmouth
		6261, -- Orange Dye
		6260, -- Blue Dye
		5637, -- Large Fang
		5635, -- Sharp Claw
		4470, -- Simple Wood
		4402, -- Small Flame Sac
		4342, -- Purple Dye
		4341, -- Yellow Dye
		4340, -- Gray Dye
		3466, -- Strong Flux
		3371, -- Crystal Vial
		3164, -- Discolored Worg Heart
		2880, -- Weak Flux
		2678, -- Mild Spices
		2605, -- Green Dye
		2604, -- Red Dye
		2325, -- Black Dye
		2324, -- Bleach
		1475, -- Small Venom Sac
		1288, -- Large Venom Sac
	},
	world_events = {
		21100, -- Coin of Ancestry, Lunar Festiva
		23247, -- Burning Blossom, Midsummer Fire Festiva
		33226, -- Tricky Treat, Hallow's End
		37829, -- Brewfest Prize Token
		44791, -- Noblegarden Chocolate
		49927, -- Love Token, Love is in the Air
	},
	pvp = {
		20559, -- Arathi Basin Mark of Honor
		20558, -- Warsong Gulch Mark of Honor
		20560, -- Alterac Valley Mark of Honor
		137642, -- Mark of Honor
		103533, -- Vicious Saddle
		26045, -- HALAA_BATTLE_TOKEN 
		26044, -- HALAA_RESEARCH_TOKEN 
	},
	elemental = {
		-- BfA
		165703, -- Breath of Bwonsamdi
		165948, -- Tidalcore
		162461, -- Sanguicell
		162460, -- Hydrocore
		163203, -- Hypersensitive Azeritometer Sensor
		152668, -- Expulsom
		-- Legion
		151568, -- Primal Sargerite, added in patch 7.3.0.24484
		124124, -- Blood of Sargeras
		124123, -- Demonfire
		124112, -- Leyfire
		-- WoD
		113261, -- Sorcerous Fire
		113262, -- Sorcerous Water
		113263, -- Sorcerous Earth
		113264, -- Sorcerous Air
		120945, -- Primal Spirit
		-- MoP
		89112, -- Mote of Harmony
		76061, -- Spirit of Harmony
		-- Cataclysm
		54464, -- Random Volatile Element
		52329, -- Volatile Life
		52328, -- Volatile Air
		52327, -- Volatile Earth
		52326, -- Volatile Water
		52325, -- Volatile Fire
		-- WolTK
		37705, -- Crystallized Water
		37704, -- Crystallized Life
		37703, -- Crystallized Shadow
		37702, -- Crystallized Fire
		37701, -- Crystallized Earth
		37700, -- Crystallized Air
		36860, -- Eternal Fire
		35627, -- Eternal Shadow
		35625, -- Eternal Life
		35624, -- Eternal Earth
		35623, -- Eternal Air
		35622, -- Eternal Water
		-- BC
		30183, -- Nether Vortex
		23572, -- Primal Nether
		23571, -- Primal Might
		22578, -- Mote of Water
		22577, -- Mote of Shadow
		22576, -- Mote of Mana
		22575, -- Mote of Life
		22574, -- Mote of Fire
		22573, -- Mote of Earth
		22572, -- Mote of Air
		22457, -- Primal Mana
		22456, -- Primal Shadow
		22452, -- Primal Earth
		22451, -- Primal Air
		21886, -- Primal Life
		21885, -- Primal Water
		21884, -- Primal Fire
		-- Classic
		12808, -- Essence of Undeath
		12803, -- Living Essence
		10286, -- Heart of the Wild
		7972, -- Ichor of Undeath
		7082, -- Essence of Air
		7081, -- Breath of Wind
		7080, -- Essence of Water
		7079, -- Globe of Water
		7078, -- Essence of Fire
		7077, -- Heart of Fire
		7076, -- Essence of Earth
		7075, -- Core of Earth
		7070, -- Elemental Water
		7069, -- Elemental Air
		7068, -- Elemental Fire
		7067, -- Elemental Earth
	},
	meat = {
		-- 8.x.x
		174353, -- Questionable Meat
		174328, -- Aberrant Voidfin
		174327, -- Malformed Gnasher
		168646, -- Mauve Stinger
		168645, -- Moist Fillet
		168303, -- Rubbery Flank
		168302, -- Viper Fish
		166741, -- Nomi's Grocery Tote
		163782, -- Cursed Haunch
		160712, -- Powdered Sugar
		160711, -- Aromatic Fish Oil
		160710, -- Wild Berries
		160709, -- Fresh Potato
		160400, -- Foosaka
		160399, -- Wild Flour
		160398, -- Choral Honey
		154899, -- Thick Paleo Steak
		154898, -- Meaty Haunch
		154897, -- Stringy Loins
		152631, -- Briny Flesh
		152549, -- Redtail Loach
		152548, -- Tiragarde Perch
		152547, -- Great Sea Catfish
		152546, -- Lane Snapper
		152545, -- Frenzied Fangtooth
		152544, -- Slimy Mackerel
		152543, -- Sand Shifter
		-- 7.x.x
		146757, -- Prepared Ingredients
		142336, -- Falcosaur Egg
		139669, -- Ancient Black Barracuda
		139668, -- Seabottom Squid
		139667, -- Axefish
		139666, -- Tainted Runescale Koi
		139665, -- Seerspine Puffer
		139664, -- Magic-Eater Frog
		139663, -- Thundering Stormray
		139662, -- Graybelly Lobster
		139661, -- Oodelfjisk
		139660, -- Ancient Highmountain Salmon
		139659, -- Coldriver Carp
		139658, -- Mountain Puffer
		139657, -- Ancient Mossgill
		139656, -- Thorned Flounder
		139655, -- Terrorfin
		139654, -- Ghostly Queenfish
		139653, -- Nar'thalas Hermit
		139652, -- Leyshimmer Blenny
		138967, -- Big Fountain Goldfish
		135512, -- Thick Slab of Bacon
		133742, -- Ancient Black Barracuda
		133741, -- Seabottom Squid
		133740, -- Axefish
		133739, -- Tainted Runescale Koi
		133738, -- Seerspine Puffer
		133737, -- Magic-Eater Frog
		133736, -- Thundering Stormray
		133735, -- Graybelly Lobster
		133734, -- Oodelfjisk
		133733, -- Ancient Highmountain Salmon
		133732, -- Coldriver Carp
		133731, -- Mountain Puffer
		133730, -- Ancient Mossgill
		133729, -- Thorned Flounder
		133728, -- Terrorfin
		133727, -- Ghostly Queenfish
		133726, -- Nar'thalas Hermit
		133725, -- Leyshimmer Blenny
		133680, -- Slice of Bacon
		133607, -- Silver Mackerel
		133593, -- Royal Olive
		133592, -- Stonedark Snail
		133591, -- River Onion
		133590, -- Muskenbutter
		133589, -- Dalapeño Pepper
		133588, -- Flaked Sea Salt
		124121, -- Wildfowl Egg
		124120, -- Leyblood
		124119, -- Big Gamy Ribs
		124118, -- Fatty Bearsteak
		124117, -- Lean Shank
		124112, -- Black Barracuda
		124111, -- Runescale Koi
		124110, -- Stormray
		124109, -- Highmountain Salmon
		124108, -- Mossgill Perch
		124107, -- Cursed Queenfish
		-- 6.x.x
		128500, -- Fel Ham
		128499, -- Fel Egg
		127994, -- Felmouth Frenzy Lunker
		127991, -- Felmouth Frenzy
		124669, -- Darkmoon Daggermaw
		122696, -- Sea Scorpion Lunker
		118565, -- Savage Piranha
		116822, -- Jawless Skulker Lunker
		116821, -- Fat Sleeper Lunker
		116820, -- Blind Lake Lunker
		116819, -- Fire Ammonite Lunker
		116818, -- Abyssal Gulper Lunker
		116817, -- Blackwater Whiptail Lunker
		111676, -- Enormous Jawless Skulker
		111675, -- Enormous Fat Sleeper
		111674, -- Enormous Blind Lake Sturgeon
		111673, -- Enormous Fire Ammonite
		111672, -- Enormous Sea Scorpion
		111671, -- Enormous Abyssal Gulper Eel
		111670, -- Enormous Blackwater Whiptail
		111669, -- Jawless Skulker
		111668, -- Fat Sleeper
		111667, -- Blind Lake Sturgeon
		111666, -- Fire Ammonite
		111665, -- Sea Scorpion
		111664, -- Abyssal Gulper Eel
		111663, -- Blackwater Whiptail
		111662, -- Small Blackwater Whiptail
		111659, -- Small Abyssal Gulper Eel
		111658, -- Small Sea Scorpion
		111656, -- Small Fire Ammonite
		111652, -- Small Blind Lake Sturgeon
		111651, -- Small Fat Sleeper
		111650, -- Small Jawless Skulker
		111601, -- Enormous Crescent Saberfish
		111595, -- Crescent Saberfish
		111589, -- Small Crescent Saberfish
		109144, -- Blackwater Whiptail Flesh
		109143, -- Abyssal Gulper Eel Flesh
		109142, -- Sea Scorpion Segment
		109141, -- Fire Ammonite Tentacle
		109140, -- Blind Lake Sturgeon Flesh
		109139, -- Fat Sleeper Flesh
		109138, -- Jawless Skulker Flesh
		109137, -- Crescent Saberfish Flesh
		109136, -- Raw Boar Meat
		109135, -- Raw Riverbeast Meat
		109134, -- Raw Elekk Meat
		109133, -- Rylak Egg
		109132, -- Raw Talbuk Meat
		109131, -- Raw Clefthoof Meat
		-- 5.x.x
		102543, -- Aged Mogu'shan Cheese
		102542, -- Ancient Pandaren Spices
		102541, -- Aged Balsamic Vinegar
		102540, -- Fresh Mangos
		102539, -- Fresh Strawberries
		102538, -- Fresh Shao-Tien Rice
		102537, -- Fresh Silkfeather Hawk Eggs
		102536, -- Fresh Lushroom
		85585, -- Red Beans
		85584, -- Silkworm Pupa
		85583, -- Needle Mushrooms
		85506, -- Viseclaw Meat
		79250, -- Fresh Pomfruit
		79246, -- Delicate Blossom Petals
		75014, -- Raw Crocolisk Belly
		74866, -- Golden Carp
		74865, -- Krasarang Paddlefish
		74864, -- Reef Octopus
		74863, -- Jewel Danio
		74861, -- Tiger Gourami
		74860, -- Redbelly Mandarin
		74859, -- Emperor Salmon
		74857, -- Giant Mantis Shrimp
		74856, -- Jade Lungfish
		74854, -- Instant Noodles
		74853, -- 100 Year Soy Sauce
		74852, -- Yak Milk
		74851, -- Rice
		74850, -- White Turnip
		74849, -- Pink Turnip
		74848, -- Striped Melon
		74847, -- Jade Squash
		74846, -- Witchberries
		74845, -- Ginseng
		74844, -- Red Blossom Leek
		74843, -- Scallions
		74842, -- Mogu Pumpkin
		74841, -- Juicycrunch Carrot
		74840, -- Green Cabbage
		74839, -- Wildfowl Breast
		74838, -- Raw Crab Meat
		74837, -- Raw Turtle Meat
		74834, -- Mushan Ribs
		74833, -- Raw Tiger Steak
		74832, -- Barley
		74662, -- Rice Flour
		74661, -- Black Pepper
		74660, -- Pandaren Peach
		74659, -- Farm Chicken
		-- 4.x.x
		67229, -- Stag Flank
		62791, -- Blood Shrimp
		62785, -- Delicate Wing
		62784, -- Crocolisk Tail
		62783, -- Basilisk
		62782, -- Dragon Flank
		62781, -- Giant Turtle Tongue
		62780, -- Snake Eye
		62779, -- Monstrous Claw
		62778, -- Toughened Flesh
		53072, -- Deepsea Sagefish
		53071, -- Algaefin Rockfish
		53070, -- Fathom Eel
		53069, -- Murglesnout
		53068, -- Lavascale Catfish
		53067, -- Striped Lurker
		53066, -- Blackbelly Mudfish
		53065, -- Albino Cavefish
		53064, -- Highland Guppy
		53063, -- Mountain Trout
		53062, -- Sharptooth
		-- 3.x.x
		44834, -- Wild Turkey
		43652, -- Slippery Eel
		43647, -- Shimmering Minnow
		43646, -- Fountain Goldfish
		43572, -- Magic Eater
		43571, -- Sewer Carp
		43501, -- Northern Egg
		43013, -- Chilled Meat
		43012, -- Rhino Meat
		43011, -- Worg Haunch
		43010, -- Worm Meat
		43009, -- Shoveltusk Flank
		41814, -- Glassfin Minnow
		41813, -- Nettlefish
		41812, -- Barrelhead Goby
		41810, -- Fangtooth Herring
		41809, -- Glacial Salmon
		41808, -- Bonescale Snapper
		41807, -- Dragonfin Angelfish
		41806, -- Musselback Sculpin
		41805, -- Borean Man O' War
		41803, -- Rockfin Grouper
		41802, -- Imperial Manta Ray
		41801, -- Moonglow Cuttlefish
		41800, -- Deep Sea Monsterbelly
		36782, -- Succulent Clam Meat
		35794, -- Silvercoat Stag Meat
		34736, -- Chunk o' Mammoth
		-- 2.x.x
		37588, -- Mostly Digested Fish
		35562, -- Bear Flank
		35285, -- Giant Sunfish
		33824, -- Crescent-Tail Skullfish
		33823, -- Bloodfin Catfish
		31671, -- Serpent Flesh
		31670, -- Raptor Ribs
		27682, -- Talbuk Venison
		27681, -- Warped Flesh
		27678, -- Clefthoof Meat
		27677, -- Chunk o' Basilisk
		27674, -- Ravager Flesh
		27671, -- Buzzard Meat
		27669, -- Bat Flesh
		27668, -- Lynx Meat
		27439, -- Furious Crawdad
		27438, -- Golden Darter
		27437, -- Icefin Bluefish
		27435, -- Figluster's Mudfish
		27429, -- Zangarian Sporefish
		27425, -- Spotted Feltail
		27422, -- Barbed Gill Trout
		24477, -- Jaggal Clam Meat
		23676, -- Moongraze Stag Tenderloin
		22644, -- Crunchy Spider Leg
		-- 1.x.x
		21153, --  Raw Greater Sagefish
		21071, --  Raw Sagefish
		21024, --  Chimaerok Tenderloin
		20424, --  Sandworm Meat
		13889, --  Raw Whitescale Salmon
		13888, --  Darkclaw Lobster
		13760, --  Raw Sunscale Salmon
		13759, --  Raw Nightfin Snapper
		13758, --  Raw Redgill
		13756, --  Raw Summer Bass
		13754, --  Raw Glossy Mightfish
		12223, --  Meaty Bat Wing
		12208, --  Tender Wolf Meat
		12207, --  Giant Egg
		12206, --  Tender Crab Meat
		12205, --  White Spider Meat
		12204, --  Heavy Kodo Meat
		12203, --  Red Wolf Meat
		12202, --  Tiger Meat
		12184, --  Raptor Flesh
		12037, --  Mystery Meat
		8959, --  Raw Spinefin Halibut
		8365, --  Raw Mithril Head Trout
		7974, --  Zesty Clam Meat
		6889, --  Small Egg
		6362, --  Raw Rockscale Cod
		6361, --  Raw Rainbow Fin Albacore
		6317, --  Raw Loch Frenzy
		6308, --  Raw Bristle Whisker Catfish
		6303, --  Raw Slitherskin Mackerel
		6291, --  Raw Brilliant Smallfish
		6289, --  Raw Longjaw Mud Snapper
		5504, --  Tangy Clam Meat
		5503, --  Clam Meat
		5471, --  Stag Meat
		5470, --  Thunder Lizard Tail
		5469, --  Strider Meat
		5468, --  Soft Frenzy Flesh
		5467, --  Kodo Meat
		5466, --  Scorpid Stinger
		5465, --  Small Spider Leg
		4655, --  Giant Clam Meat
		4603, --  Raw Spotted Yellowtail
		3731, --  Lion Meat
		3730, --  Big Bear Meat
		3712, --  Turtle Meat
		3685, --  Raptor Egg
		3667, --  Tender Crocolisk Meat
		3404, --  Buzzard Wing
		3174, --  Spider Ichor
		3173, --  Bear Meat
		3172, --  Boar Intestines
		2924, --  Crocolisk Meat
		2886, --  Crag Boar Rib
		2677, --  Boar Ribs
		2675, --  Crawler Claw
		2674, --  Crawler Meat
		2673, --  Coyote Meat
		2672, --  Stringy Wolf Meat
		2665, --  Stormwind Seasoning Herbs
		2251, --  Gooey Spider Leg
		1468, --  Murloc Fin
		1080, --  Tough Condor Meat
		1015, --  Lean Wolf Flank
		769, --  Chunk of Boar Meat
		731, --  Goretusk Snout
		730, --  Murloc Eye
		729, --  Stringy Vulture Meat
		723, --  Goretusk Liver
	},

--[[	quest = {
		166682, -- Blight Specialist Mask
		166459, -- Xibek's Key
		166273, -- Darkscale Key
		166244, -- Token of Shadiness
		165835, -- Pristine Gizmo
		165659, -- Freshly-Dug Ore
		163991, -- Flagon of Applebrew
		163990, -- Baked Egg
		163989, -- Slice of Cheese
		163988, -- Chunk of Boar Meat
		163853, -- Pilgrimage Scroll
		163852, -- Tortollan Pilgrimage Scroll
		163841, -- Dung Beetle Surprise
		163208, -- Uncle Sezahjin's Fried Chicken
		163036, -- Polished Pet Charm
		163033, -- Surging Mote
		161133, -- Unsanctified Storm Silver Ingots
		160895, -- Irontide Key
		160744, -- Pristine Blowgun of the Sethrak
		160742, -- Pristine Soul Coffer
		160668, -- Lost Coin
		160565, -- Fading Umbral Wand
		160556, -- Bot Cluster Bomb
		160550, -- Enormous Anchor Pod
		160480, -- Marine Dog Tags
		160440, -- Unsanctified Storm Silver Ore
		160301, -- Disgustingly Damp Flower
		160250, -- Dead Pollen-Covered Wasp
		160058, -- Stabilize Magma Elemental
		160035, -- Enormous Anchor Pod
		159956, -- Disgustingly Damp Flower
		159877, -- Dead Pollen-Covered Bee
		159827, -- Bomb-samdi Mojo Bombs
		159755, -- Ravasaur Stomach Lining
		159752, -- Fishbone Key
		159727, -- Flagon of Applebrew
		159726, -- Baked Egg
		159724, -- Slice of Cheese
		159723, -- Chunk of Boar Meat
		159156, -- Sweete's Orders
		158654, -- Treadward's Ring
		158184, -- Fresh Meat
		157846, -- Sack of Aromatic Onions
		157845, -- Falconer's Whistle
		157840, -- Falconer's Key
		157833, -- Spirit Essence
		157806, -- Personal Keepsake
		156853, -- Battered Hand Cannon
		156519, -- Camoflauge Kit
		156481, -- Jin'Tiki's Empowered Fetish
		156480, -- Jin'Tiki's Fetish
		155906, -- Tarnished Silver Blade
		154990, -- Etched Drust Bone
		154989, -- Zandalari Idol
		154935, -- Pristine Bwonsamdi Voodoo Mask
		154934, -- Pristine High Apothecary's Hood
		154933, -- Pristine Rezan Idol
		154932, -- Pristine Urn of Passage
		154931, -- Pristine Akun'Jar Vase
		154930, -- Pristine Ritual Fetish
		154929, -- Pristine Jagged Blade of the Drust
		154928, -- Pristine Disembowling Sickle
		154927, -- Pristine Ancient Runebound Tome
		154926, -- Pristine Ceremonial Bonesaw
		154892, -- Skycaller Gem
		154888, -- Sailor's Pie
		153694, -- Poisoned Dagger
		153219, -- Squished Demon Eye
		153069, -- All-Seer's Draught
		153012, -- Poisoned Mojo Flask
		152961, -- Greater Argussian Reach Insignia
		152956, -- Greater Army of the Light Insignia
		152868, -- Anglin' Art's Mudfish Bait
		152845, -- Mudfish Innards
		152705, -- Thesis Paper Page
		152703, -- \
		152699, -- \
		152698, -- Grimestone Stew
		152644, -- Thistlevine Seeds
		152628, -- Azerite Cannonball
		152408, -- Stolen Pylon Core
		152357, -- Vigilant Power Crystal
		152296, -- Primal Obliterum
		152203, -- Reforged Armory Key
		152097, -- Lightforged Bulwark
		152096, -- Void-Purged Krokul
		152095, -- Krokul Ridgestalker
		151927, -- Prototype Gravitational Reduction Slippers
		151545, -- Stolen Time
		151544, -- Stolen Time
		151492, -- Bronze Drake
		151491, -- Favor of the Bronze
		151490, -- Stolen Time
		151489, -- Wings of the Bronze
		151488, -- Hide of the Bronze
		151487, -- Fangs of the Bronze
		151486, -- Reputation
		151485, -- Reputation
		151484, -- Reputation
		151483, -- Timewarped Badge
		151347, -- Town Hall Door Key
		151191, -- Old Bottle Cap
		147727, -- Greater Legionfall Insignia
		147415, -- Greater Wardens Insignia
		147414, -- Greater Valarjar Insignia
		147413, -- Greater Nightfallen Insignia
		147412, -- Greater Highmountain Tribe Insignia
		147411, -- Greater Dreamweaver Insignia
		147410, -- Greater Court of Farondis Insignia
		147211, -- Sparkling Kirin Tor Coin
		146708, -- Ancient Demonsteel Armor
		146700, -- Ancient Gravenscale Armor
		146692, -- Ancient Dreadleather Armor
		146684, -- Ancient Imbued Silkweave Armor
		144076, -- Rigging Rope
		144075, -- Waxy Reeds
		144074, -- Mainsail
		144073, -- Ship Mast
		143924, -- Burning Key
		143785, -- Tome of the Tranquil Mind
		143779, -- The Focusing Iris
		143753, -- Damp Pet Supplies
		143542, -- Crown Co. \
		143496, -- Nethersworn Manifesto
		142502, -- Empowered Portal Stone
		142372, -- Well-Tailored Robes
		142365, -- Magnificent Mantle
		142246, -- Broken Pocket Watch
		142080, -- Bundle of Fresh Sweetgrass
		141351, -- Tear of Elune
		140933, -- Runed Aspirant's Band
		140932, -- Earthen Mark
		140931, -- Bandit Wanted Poster
		140930, -- Acolyte's Vows
		140929, -- Squire's Oath
		140928, -- Ox Initiate's Pledge
		140927, -- Water Globe
		140926, -- Bowmen's Orders
		140925, -- Enchanted Bark
		140924, -- Ashtongue Beacon
		140923, -- Ghoul Tombstone
		140922, -- Imp Pact
		140248, -- Master Jeweler's Gem
		140246, -- Arc of Snow
		140245, -- The Tidemistress' Enchanted Pearl
		140243, -- Azurefall Essence
		140242, -- Astromancer's Compass
		140240, -- Enchanted Moonwell Waters
		140239, -- Excavated Highborne Artifact
		140236, -- A Mrglrmrl Mlrglr
		140235, -- Small Jar of Arcwine
		140189, -- Third Year Blue
		140188, -- Second Year Blue
		140187, -- First Year Blue
		139593, -- Sack of Salvaged Goods
		139540, -- Aponi's Journal Page
		139043, -- Tear of Elune
		138875, -- Small Ley Crystal
		138853, -- Phial of Nightwell Energy
		138414, -- Emergency Pirate Outfit
		138392, -- Amplifier Fragment
		138301, -- Control Orb
		138190, -- Sharp Wooden Stake
		138146, -- Radiant Ley Crystal
		137642, -- Mark of Honor
		137613, -- Hearty Steak
		137612, -- Raw Meat
		137609, -- Wood
		137268, -- Fragment of Xavius
		137189, -- Satyr Horn
		137178, -- Enchanted Firecrackers
		136918, -- Sallow Essence
		136917, -- Roseate Essence
		136916, -- Fjarnsk
		136915, -- Woody Seed Cluster
		136909, -- Aethrem Crystal
		136850, -- Stolen Ley Crystal
		136694, -- Ancient Scrolls of Meitre
		136406, -- Dravax's Key
		136342, -- Obliterum Ash
		134088, -- Chapter from The Purple Hills of Mac'Aree
		134087, -- Page from The Purple Hills of Mac'Aree
		133972, -- Basilisk Meat
		133944, -- Rageshard
		133941, -- Hobart's Prototype Gunshoes
		133928, -- Prototype Pump-Action Bandage Gun
		133808, -- Prized Racing Snail
		133575, -- Dried Mackerel Strips
		132887, -- Bouquet of Moon Lilies
		132886, -- Moon Lily
		132749, -- Legion Portal Fragment
		132523, -- Reaves Battery
		130935, -- Pristine Houndstooth Hauberk
		130934, -- Pristine Orb of Inner Chaos
		130933, -- Pristine Malformed Abyssal
		130932, -- Pristine Flayed-Skin Chronicle
		130931, -- Pristine Imp's Cup
		130930, -- Pristine Stonewood Bow
		130929, -- Pristine Drogbar Gem-Roller
		130928, -- Pristine Hand-Smoothed Pyrestone
		130927, -- Pristine Moosebone Fish-Hook
		130926, -- Pristine Trailhead Drum
		130925, -- Pristine Nobleman's Letter Opener
		130924, -- Pristine Pre-War Highborne Tapestry
		130923, -- Pristine Quietwine Vial
		130922, -- Pristine Inert Leystone Charm
		130921, -- Pristine Violetglass Vessel
		130905, -- Mark of the Deceiver
		130904, -- Highmountain Ritual-Stone
		130903, -- Ancient Suramar Scroll
		130891, -- Namha's Tanning Mixture
		130872, -- Stonehide Leather Lining
		130870, -- Tanned Stonehide Leather
		130869, -- Shaved Stonehide Pelt
		130222, -- Masterful Shadowruby
		130220, -- Quick Dawnlight
		130219, -- Deadly Eye of Prophecy
		130078, -- Leatherworking Pattern Scrap
		129278, -- Foxflower Scent Gland
		129143, -- Scribbled Ramblings
		129142, -- Runed Journal Page
		129141, -- Blight-Choked Herb
		129140, -- Jeweled Spade Handle
		129138, -- Ram's-Horn Trowel
		129137, -- Nibbled Foxflower Stem
		129136, -- Blight-Twisted Herb
		129135, -- Ragged Strips of Silk
		129122, -- Felwort Sample
		129121, -- Starlight Rosedust
		129120, -- Fjarnskaggl Sample
		129119, -- Foxflower Sample
		129118, -- Dreamleaf Sample
		129117, -- Aethril Sample
		129032, -- Roseate Pigment
		128852, -- Infernal Brimstone Sample
		128659, -- Merry Supplies
		128658, -- Spooky Supplies
		128632, -- Savage Snowball
		128373, -- Rush Order: Shipyard
		128290, -- Runewritten Tome
		128287, -- Detonator
		128272, -- Equipment Blueprint: Felsmoke Launchers
		128271, -- Equipment Blueprint: Ghostly Spyglass
		128270, -- Equipment Blueprint: Gyroscopic Internal Stabilizer
		128269, -- Equipment Blueprint: Ice Cutter
		128266, -- Equipment Blueprint: True Iron Rudder
		128265, -- Equipment Blueprint: Tuskarr Fishing Net
		128264, -- Equipment Blueprint: Unsinkable
		128230, -- Equipment Blueprint: High Intensity Fog Lights
		128228, -- Equipment Blueprint: Trained Shark Tank
		128224, -- Deucus' Experiemental Treasure Potion
		127840, -- Skaggldrynk
		127837, -- Draught of Raw Magic
		127663, -- Trained Shark Tank
		127294, -- Handcrafted Silkweave Robe
		127293, -- Torn, Ragged Mess
		126951, -- Equipment Blueprint: Bilge Pump
		124451, -- Felsmith's Infernal Brimstone
		124449, -- Felsmith's Leystone Armguards
		124436, -- Foxflower Flux
		124427, -- Leystone Shinplate
		124425, -- Felsmith's Leystone Bar
		124418, -- Leystone Slag
		124417, -- Shopkeeper's Leystone Ore
		124403, -- Medium Metal Scrap
		124402, -- Small Metal Scrap
		124396, -- Dull Hard Leystone Armguards
		124395, -- Heated Hard Leystone Bar
		124115, -- Stormscale
		124113, -- Stonehide Leather
		124099, -- Blackfang Claw
		124007, -- Leystone Bar
		124005, -- Shopkeeper's Leystone Ore
		122612, -- Vrykul Armament
		122535, -- Traveler's Pet Supplies
		122457, -- Ultimate Battle-Training Stone
		122456, -- Commander's Draenic Versatility Potion
		122455, -- Commander's Draenic Strength Potion
		122454, -- Commander's Draenic Intellect Potion
		122453, -- Commander's Draenic Agility Potion
		122452, -- Commander's Draenic Swiftness Potion
		122451, -- Commander's Draenic Invisibility Potion
		122429, -- Iskar's Tome of Shadows
		121832, -- Demon's Blood
		121822, -- Journal Page
		120945, -- Primal Spirit
		118736, -- Captain's Whistle
		118697, -- Big Bag of Pet Supplies
		118473, -- Small Sack of Salvaged Goods
		118471, -- Salvaged Parts
		117397, -- Nat's Lucky Coin
		116925, -- Vintage Free Action Potion
		116766, -- Apexis Keystone
		116755, -- Nat's Hookshot
		116754, -- Molten Catfish
		116747, -- Page from Nat's Fishing Journal
		116445, -- Anxious Spiritshard
		116444, -- Forlorn Spiritshard
		116443, -- Peaceful Spiritshard
		116442, -- Vengeful Spiritshard
		116429, -- Flawless Battle-Training Stone
		116415, -- Shiny Pet Charm
		115981, -- Abrogator Stone Cluster
		115524, -- Taladite Crystal
		115510, -- Elemental Rune
		115504, -- Fractured Temporal Crystal
		114926, -- Restorative Goldcap
		114902, -- Neatly Bundled Goods
		114875, -- Eventide Fishing Journal
		114874, -- Moonshell Claw Bait
		114807, -- War Ravaged Armor Set
		114628, -- Icespine Stinger Bait
		114627, -- Frostwolf Fishing Journal
		114616, -- War Ravaged Weaponry
		114224, -- Pristine Apexis Scroll
		114223, -- Pristine Apexis Hieroglyph
		114222, -- Pristine Apexis Crystal
		114221, -- Pristine Outcast Dreamcatcher
		114220, -- Pristine Talonpriest Mask
		114219, -- Pristine Sundial
		114218, -- Pristine Solar Orb
		114217, -- Pristine Decree Scrolls
		114216, -- Pristine Burial Urn
		114215, -- Pristine Dreamcatcher
		114213, -- Pristine Imperial Decree Stele
		114212, -- Pristine Rylak Riding Harness
		114211, -- Pristine Stone Dentures
		114210, -- Pristine Eye of Har'gunn the Blind
		114209, -- Pristine Mortar and Pestle
		114208, -- Pristine Gladiator's Shield
		114188, -- Pristine Pictogram Carving
		114186, -- Pristine Ogre Figurine
		114184, -- Pristine Stone Manacles
		114182, -- Pristine Stonemaul Succession Stone
		114178, -- Pristine Doomsday Prophecy
		114176, -- Pristine Gronn-Tooth Necklace
		114174, -- Pristine Flask of Blazegrease
		114172, -- Pristine Ancestral Talisman
		114170, -- Pristine Cracked Ivory Idol
		114168, -- Pristine Ceremonial Tattoo Needles
		114166, -- Pristine Calcified Eye In a Jar
		114164, -- Pristine Barbed Fishing Hook
		114162, -- Pristine Hooked Dagger
		114160, -- Pristine Weighted Chopping Axe
		114158, -- Pristine Blackrock Razor
		114156, -- Pristine Elemental Bellows
		114154, -- Pristine Metalworker's Hammer
		114152, -- Pristine Warsong Ceremonial Pike
		114150, -- Pristine Screaming Bullroarer
		114148, -- Pristine Warsinger's Drums
		114146, -- Pristine Wolfskin Snowshoes
		114144, -- Pristine Frostwolf Ancestry Scrimshaw
		114142, -- Pristine Fang-Scarred Frostwolf Axe
		114124, -- Phantom Potion
		113489, -- Shackle Key
		112970, -- Enriched Seeds
		112377, -- War Paints
		112278, -- Ace of Iron
		112277, -- Two of Iron
		112276, -- Three of Iron
		112275, -- Five of Iron
		112274, -- Four of Iron
		112273, -- Six of Iron
		112272, -- Seven of Iron
		112271, -- Eight of Iron
		112100, -- Elixir of Shadows
		112099, -- Major Elixir of Shadows
		111908, -- Draenei Bucket
		111556, -- Hexweave Cloth
		111366, -- Gearspring Parts
		110611, -- Burnished Leather
		110469, -- Mysterious Boots
		109585, -- Arakkoa Cipher
		109584, -- Ogre Missive
		109259, -- Shadow Council Spellbook
		109152, -- Draenic Stamina Flask
		108996, -- Alchemical Catalyst
		108439, -- Draenor Clan Orator Cane
		108257, -- Truesteel Ingot
		106981, -- Power Slinger
		106958, -- Winterwasp Antidote
		106952, -- Power Transformer: Jump
		106950, -- Power Transformer: Dash
		104039, -- Blackrock Blasting Powder
		103643, -- Dew of Eternal Morning
		103642, -- Book of the Ages
		103641, -- Singing Crystal
		95623, -- Sunreaver Bounty
		95622, -- Arcane Trove
		95497, -- Burial Trove Key
		95390, -- Pristine Kypari Sap Container
		95389, -- Pristine Pollen Collector
		95388, -- Pristine Mantid Lamp
		95387, -- Pristine Remains of a Paragon
		95386, -- Pristine Sound Beacon
		95385, -- Pristine Praying Mantid
		95384, -- Pristine Ancient Sap Feeder
		95383, -- Pristine Banner of the Mantid Empire
		95373, -- Mantid Amber Sliver
		94905, -- Case of Tactical Mana Bombs
		94221, -- Shan'ze Ritual Stone
		94111, -- Lightning Steel Ingot
		93668, -- Saur Fetish
		91806, -- Unstable Portal Shard
		89209, -- Pristine Monument Ledger
		89185, -- Pristine Standard of Niuzao
		89184, -- Pristine Pearl of Yu'lon
		89183, -- Pristine Apothecary Tins
		89182, -- Pristine Gold-Inlaid Figurine
		89181, -- Pristine Carved Bronze Mirror
		89180, -- Pristine Empty Keg
		89179, -- Pristine Walking Cane
		89178, -- Pristine Twin Stein Set
		89176, -- Pristine Branding Iron
		89175, -- Pristine Iron Amulet
		89174, -- Pristine Edicts of the Thunder King
		89173, -- Pristine Thunder King Insignia
		89172, -- Pristine Petrified Bone Whip
		89171, -- Pristine Terracotta Arm
		89170, -- Pristine Mogu Runestone
		89169, -- Pristine Manacles of Rebellion
		89112, -- Mote of Harmony
		88586, -- Chao Cookies
		88578, -- Cup of Kafa
		88532, -- Lotus Water
		88487, -- Volatile Orb
		88398, -- Root Veggie Stew
		88388, -- Squirmy Delight
		88382, -- Keenbean Kafa
		88379, -- Grummlecake
		87399, -- Restored Artifact
		86536, -- Wu Kao Dart of Lethargy
		86534, -- Shiny Shado-Pan Coin
		86489, -- Succulent Turtle Filet
		86392, -- Letter to Sungshin Ironpaw
		86057, -- Sliced Peaches
		86026, -- Perfectly Cooked Instant Noodles
		85998, -- Thresher Jaw
		85558, -- Pristine Game Board
		85557, -- Pristine Pandaren Tea Set
		85507, -- Alliance Orders
		85477, -- Pristine Mogu Coin
		85230, -- Sea Monarch Chunks
		84762, -- Highly Explosive Yaungol Oil
		84727, -- Ancient Spirit Dust
		83097, -- Tortoise Jerky
		83023, -- Shado-Pan Crossbow Bolt Bundle
		82864, -- Living Amber
		81404, -- Dried Needle Mushrooms
		81402, -- Toasted Fish Jerky
		81400, -- Pounded Rice Cake
		81178, -- Stone Key
		81175, -- Crispy Dojani Eel
		80303, -- Pristine Crane Egg
		80234, -- Yoon's Apple
		80212, -- The Master's Flame
		80074, -- Celestial Jade
		79869, -- Mogu Statue Piece
		79868, -- Pandaren Pottery Shard
		79731, -- Scroll of Wisdom
		79320, -- Half a Lovely Apple
		79237, -- Enormous Crocolisk Tail
		79028, -- Saltback Meat Scrap
		79027, -- Saltback Meat
		76061, -- Spirit of Harmony
		74866, -- Golden Carp
		74857, -- Giant Mantis Shrimp
		74856, -- Jade Lungfish
		74853, -- 100 Year Soy Sauce
		74845, -- Ginseng
		74841, -- Juicycrunch Carrot
		74839, -- Wildfowl Breast
		74833, -- Raw Tiger Steak
		74662, -- Rice Flour
		74661, -- Black Pepper
		74260, -- Bamboo Key
		73183, -- Snowblossom Petals
		72056, -- Plump Frogs
		72052, -- Bit of Glass
		72048, -- Darkmoon Banner Kit
		72018, -- Discarded Weapon
		71967, -- Horseshoe
		71083, -- Darkmoon Game Token
		69990, -- Mulgore Pine Cone
		69956, -- Blind Cavefish
		69933, -- Blind Minnow
		69914, -- Giant Catfish
		69907, -- Corpse Worm
		69233, -- Cone of Cold
		69027, -- Cone of Cold
		68645, -- Smoked Meat
		68644, -- Winterspring Cub Whisker
		67273, -- Chillwind Omelet
		67272, -- Shy-Rotam Steak
		67271, -- Hell-Hoot Barbecue
		67270, -- Ursius Flank
		66939, -- Forgehammer Weapons
		65731, -- Yetichoke Hearts
		65730, -- Stagwich
		64641, -- \
		64640, -- Infectis Puffer Sashimi
		64639, -- Silversnap Ice
		64492, -- Ramkahen Badge of Valor
		64313, -- Elemental-Imbued Weapon
		63347, -- Sack of Grain
		63023, -- Sweet Tea
		62909, -- \
		62908, -- Hair of the Dog
		62804, -- Eye of Twilight
		62795, -- Silversnap Swim Tonic
		62750, -- Draenethyst Crystals
		62610, -- Titan Device Component
		62608, -- Uldum Chest Key Code
		62592, -- Charred Highland Birch
		62513, -- Purified Black Dragon Egg
		61384, -- Doublerum
		61383, -- Garr's Key Lime Pie
		61382, -- Garr's Limeade
		61381, -- Yance's Special Burger Patty
		61037, -- Plague Disseminator Control Rune
		60866, -- Battered Weapons and Armor
		60504, -- Painite Chunk
		60373, -- Linzi's Gift
		59358, -- Broken Shard
		58949, -- Stag Eye
		58933, -- Westfall Mud Pie
		58883, -- Sassy's Largesse
		58882, -- Sassy's Samples
		58856, -- Royal Monkfish
		58788, -- Overgrown Earthworm
		58783, -- Jade Crystal Composite
		58500, -- Jade Crystal Cluster
		57519, -- Cookie's Special Ramlette
		57518, -- Mr. Bubble's Shockingly Delicious Ice Cream
		57177, -- Tainted Hide
		56248, -- Alliance S.E.A.L. Equipment
		56081, -- Trapper's Key
		56057, -- Heart of the Forest
		55805, -- The Pewter Pounder
		55247, -- Gnaws Tooth Necklace
		55188, -- Medallion Fragment
		55185, -- Pilfered Cannonball
		55141, -- Spiralung
		55123, -- Smoldering Core
		54884, -- Hefty Sack of Clams
		54615, -- Tender Turtle Meat
		54453, -- Six-Pack of Kaja'Cola
		54213, -- Molotov Cocktail
		53009, -- Juniper Berries
		52974, -- Mack's Deep Sea Grog
		52708, -- Charred Basilisk Meat
		52484, -- Kaja'Cola Zero-One
		50130, -- Snagglebolt's Khorium Bomb
		49943, -- Lovely Silvermoon City Card
		49942, -- Lovely Exodar Card
		49941, -- Lovely Thunder Bluff Card
		49940, -- Lovely Ironforge Card
		49939, -- Lovely Orgrimmar Card
		49938, -- Lovely Darnassus Card
		49937, -- Lovely Undercity Card
		49936, -- Lovely Stormwind Card
		49927, -- Love Token
		49884, -- Kaja'Cola
		49881, -- Slaver's Key
		49769, -- Confiscated Arms
		49718, -- Infused Saronite Bar
		49226, -- Mysterious Concoction
		49211, -- Mound o' Meat
		49202, -- Black Gunpowder Keg
		49197, -- Maurin's Concoction
		49196, -- Smeed's Harnesses
		49134, -- Korrah's Report
		49104, -- Ancient Engravings of Neptulon
		49102, -- Ancient Tablet Fragment
		49090, -- Field Journal
		49042, -- Artillery Signal
		47833, -- Furien's Journal
		47196, -- Venomhide Baby Tooth
		47044, -- Stack of Macaroons
		47036, -- Fresh Chum
		47035, -- Discarded Soul Crystal
		46955, -- Kraken Tooth
		46769, -- Tweedle's Pow-Pow Powder
		46754, -- Tweedle's Tiny Package
		46734, -- Battle Triage Kit
		46701, -- Tweedle's Improvised Explosive
		46365, -- Mystlash Hydra Blubber
		46315, -- Thorned Bloodcup
		46311, -- Sheelah's Sealed Missive
		46114, -- Champion's Writ
		45902, -- Phantom Ghostfish
		45678, -- Blood-Soaked Axe
		45192, -- Aspirant's Seal
		45000, -- Winter Hyacinth
		44987, -- Valiant's Seal
		44985, -- Shattershield Arrow
		44868, -- Frenzied Cyclone Bracers
		44724, -- Everfrost Chip
		44434, -- Dark Matter
		44301, -- Tainted Essence
		44246, -- Orb of Illusion
		43616, -- Abandoned Armor
		43610, -- Abandoned Helm
		43609, -- Pile of Bones
		43473, -- Drakefire Chile Ale
		43472, -- Snowfall Lager
		43470, -- Worg Tooth Oatmeal Stout
		43462, -- Airy Pale Ale
		43148, -- Crystalsong Carrot
		43143, -- Wild Mustard
		43141, -- Fate Rune of Unsurpassed Vigor
		43138, -- Half Full Dalaran Wine Glass
		43135, -- Fate Rune of Fleet Feet
		43134, -- Fate Rune of Primal Energy
		43100, -- Infused Mushroom
		43094, -- Fate Rune of Nigh Invincibility
		43090, -- Fate Rune of Baneful Intent
		42700, -- Reforged Armor of the Stormlord
		42422, -- Jotunheim Cage Key
		42246, -- Essence of Ice
		42159, -- Storm Hammer
		41612, -- Vial of Frost Oil
		41557, -- Refined Gleaming Ore
		41340, -- Fresh Ice Rhino Meat
		41336, -- Medical Supply Crate
		41130, -- Inventor's Disk Fragment
		40652, -- Scarlet Onslaught Trunk Key
		40641, -- Cold Iron Key
		40042, -- Caraway Burnwine
		39691, -- Succulent Orca Stew
		39616, -- Essence of the Monsoon
		39520, -- Kungaloosh
		39327, -- Noth's Special Brew
		39305, -- Tiki Hex Remover
		38380, -- Zul'Drak Rat
		38323, -- Water Elemental Link
		38144, -- Harkor's Ingredients
		37829, -- Brewfest Prize Token
		37727, -- Ruby Acorn
		37500, -- Key to Refurbished Shredder
		37247, -- Anderhol's Slider Cider
		36873, -- Drakkari Spirit Dust
		36870, -- Sacred Drakkari Offering
		36786, -- Bark of the Walkers
		36770, -- Zort's Protective Elixir
		36758, -- Sacred Mojo
		35836, -- Zim'bo's Mojo
		35799, -- Frozen Mojo
		35586, -- Frozen Axe
		35488, -- Brilliant Crimson Spinel
		35487, -- Delicate Crimson Spinel
		35288, -- Uncured Caribou Hide
		35276, -- Gnomish Emergency Toolkit
		35230, -- Darnarian's Scroll of Teleportation
		34684, -- Handful of Summer Petals
		34599, -- Juggling Torch
		34537, -- Bloodberry Elixir
		34500, -- Ata'mal Armament
		34483, -- Orb of Murloc Control
		34477, -- Darkspine Chest Key
		34338, -- Mana Remnants
		34255, -- Razorthorn Flayer Gland
		34127, -- Tasty Reef Fish
		34125, -- Shoveltusk Soup
		34083, -- Awakening Rod
		34068, -- Weighted Jack-o'-Lantern
		34020, -- Jungle River Water
		34017, -- Small Step Brew
		33838, -- Giant Kaliri Wing
		33462, -- Scroll of Strength VI
		33461, -- Scroll of Stamina VI
		33460, -- Scroll of Versatility VI
		33458, -- Scroll of Intellect VI
		33457, -- Scroll of Agility VI
		33448, -- Runic Mana Potion
		33447, -- Runic Healing Potion
		33352, -- Tough Ram Meat
		33284, -- Gjalerbron Cage Key
		33226, -- Tricky Treat
		33061, -- Grimtotem Key
		33050, -- Grimtotem Note
		33034, -- Gordok Grog
		33031, -- Thunder 45
		33030, -- Barleybrew Clear
		32720, -- Time-Lost Offering
		32569, -- Apexis Shard
		32446, -- Elixir of Shadows
		32079, -- Shaffar's Stasis Chamber Key
		31812, -- Doom Skull
		31754, -- Grisly Totem
		31673, -- Crunchy Serpent
		31672, -- Mok'Nathal Shortribs
		31655, -- Veil Skith Prison Key
		31653, -- Condensed Nether Gas
		31536, -- Camp Anger Key
		31535, -- Bloodboil Poison
		31451, -- Pure Energy
		31450, -- Stealth of the Stalker
		31449, -- Distilled Stalker Sight
		31437, -- Medicinal Drake Essence
		31372, -- Rocknail Flayer Carcass
		31347, -- Bleeding Hollow Torch
		30858, -- Peon Sleep Potion
		30816, -- Spice Bread
		30811, -- Scroll of Demonic Unbanishing
		30810, -- Sunfury Signet
		30809, -- Mark of Sargeras
		30704, -- Ruuan'ok Claw
		30425, -- Bleeding Hollow Blood
		30361, -- Oronok's Tuber of Spell Power
		30359, -- Oronok's Tuber of Strength
		30358, -- Oronok's Tuber of Agility
		30357, -- Oronok's Tuber of Healing
		29750, -- Ethereum Stasis Chamber Key
		29736, -- Arcane Rune
		29735, -- Holy Dust
		29482, -- Ethereum Essence
		29460, -- Ethereum Prison Key
		29292, -- Helboar Bacon
		28501, -- Ravager Egg Omelet
		28103, -- Adept's Elixir
		28102, -- Onslaught Elixir
		28100, -- Volatile Healing Potion
		27651, -- Buzzard Bites
		27553, -- Crimson Steer Energy Drink
		27503, -- Scroll of Strength V
		27502, -- Scroll of Stamina V
		27501, -- Scroll of Versatility V
		27499, -- Scroll of Intellect V
		27498, -- Scroll of Agility V
		26044, -- Halaa Research Token
		25449, -- Bundle of Skins
		24581, -- Mark of Thrallmar
		24579, -- Mark of Honor Hold
		24502, -- Warmaul Skull
		24421, -- Nagrand Cherry
		24338, -- Hellfire Spineleaf
		24245, -- Glowcap
		24105, -- Roasted Moongraze Tenderloin
		24072, -- Sand Pear Pie
		23989, -- Crystal of Ferocity
		23986, -- Crystal of Insight
		23985, -- Crystal of Vitality
		23801, -- Bristlelimb Key
		23756, -- Cookie's Jumbo Gumbo
		23444, -- Goldenmist Special Brew
		23435, -- Elderberry Pie
		23424, -- Fel Iron Ore
		23327, -- Fire-Toasted Bun
		23326, -- Midsummer Sausage
		23247, -- Burning Blossom
		23246, -- Fiery Festival Brew
		23211, -- Toasted Smorc
		22850, -- Super Rejuvenation Potion
		22832, -- Super Mana Potion
		22831, -- Elixir of Major Agility
		22829, -- Super Healing Potion
		22779, -- Scourgebane Draught
		22778, -- Scourgebane Infusion
		22645, -- Crunchy Spider Surprise
		21100, -- Coin of Ancestry
		20557, -- Hallow's End Pumpkin Treat
		20390, -- Candy Bar
		19971, -- High Test Eternium Fishing Line
		19221, -- Darkmoon Special Reserve
		18588, -- Ez-Thro Dynamite II
		18284, -- Kreeg's Stout Beatdown
		18269, -- Gordok Green Grog
		18253, -- Major Rejuvenation Potion
		17119, -- Deeprun Rat Kabob
		15874, -- Soft-Shelled Clam
		15447, -- Living Rot
		14530, -- Heavy Runecloth Bandage
		13546, -- Bloodbelly Fish
		13452, -- Elixir of the Mongoose
		13447, -- Elixir of the Sages
		13446, -- Major Healing Potion
		13444, -- Major Mana Potion
		12622, -- Shardtooth Meat
		11584, -- Cactus Apple Surprise
		11567, -- Crystal Spire
		11566, -- Crystal Charge
		11565, -- Crystal Yield
		11563, -- Crystal Force
		11562, -- Crystal Restore
		11516, -- Cenarion Plant Salve
		11148, -- Samophlange Manual Page
		6807, -- Frog Leg Stew
		6529, -- Shiny Bauble
		6372, -- Swim Speed Potion
		6290, -- Brilliant Smallfish
		5997, -- Elixir of Minor Defense
		5951, -- Moist Towelette
		5457, -- Severed Voodoo Claw
		5342, -- Raptor Punch
		5205, -- Sprouted Frond
		4702, -- Prospector's Pick
		4656, -- Small Pumpkin
		4604, -- Forest Mushroom Cap
		4540, -- Tough Hunk of Bread
		4536, -- Shiny Red Apple
		3825, -- Elixir of Fortitude
		3666, -- Gooey Spider Cake
		3434, -- Slumber Sand
		3382, -- Weak Troll's Blood Elixir
		3220, -- Blood Sausage
		2888, -- Beer Basted Boar Ribs
		2863, -- Coarse Sharpening Stone
		2842, -- Silver Bar
		2772, -- Iron Ore
		2723, -- Bottle of Dalaran Noir
		2455, -- Minor Mana Potion
		2454, -- Elixir of Lion's Strength
		2449, -- Earthroot
		2070, -- Darnassian Bleu
		1180, -- Scroll of Stamina
		1127, -- Flash Bundle
		1017, -- Seasoned Wolf Kabob
		961, -- Healing Herb
		955, -- Scroll of Intellect
		858, -- Lesser Healing Potion
		785, -- Mageroyal
		414, -- Dalaran Sharp
		159, -- Refreshing Spring Water
		118, -- Minor Healing Potion
	},]]
}

constants.itemCategories = {
	["relics"] = INVTYPE_RELIC,
	["world_events"] = BATTLE_PET_SOURCE_7,
	["pvp"] = PVP,
	["elemental"] = CurrencyTracking_Elemental,
	["meat"] = CurrencyTracking_Meat, 
	["others"] = MISCELLANEOUS,
--	["quest"] = ITEM_BIND_QUEST,
	["professions"] = TRADE_SKILLS,
}

if WoWClassic then
	constants.events = {
		"PLAYER_REGEN_ENABLED",
		"PLAYER_REGEN_DISABLED",
--		"PET_BATTLE_OPENING_START",
--		"PET_BATTLE_CLOSE",
		"BATTLEFIELDS_SHOW",
		"BATTLEFIELDS_CLOSED",
		"BAG_UPDATE",
--		"TRADE_CURRENCY_CHANGED",
--		"ARTIFACT_UPDATE",
--		"ARTIFACT_XP_UPDATE",
		"TRADE_PLAYER_ITEM_CHANGED",
--		"PLAYER_TRADE_CURRENCY",
		"CHAT_MSG_CURRENCY",
--		"SHIPMENT_CRAFTER_REAGENT_UPDATE",
--		"CURRENCY_DISPLAY_UPDATE",
		-- Money
		"PLAYER_MONEY",
		"PLAYER_TRADE_MONEY",
		"TRADE_MONEY_CHANGED",
		"SEND_MAIL_MONEY_CHANGED",
		"SEND_MAIL_COD_CHANGED",
		"TRIAL_STATUS_UPDATE",
		"CHAT_MSG_MONEY",
	}

else
	constants.events = {
		"PLAYER_REGEN_ENABLED",
		"PLAYER_REGEN_DISABLED",
		"PET_BATTLE_OPENING_START",
		"PET_BATTLE_CLOSE",
		"BATTLEFIELDS_SHOW",
		"BATTLEFIELDS_CLOSED",
		"BAG_UPDATE",
		"TRADE_CURRENCY_CHANGED",
		"ARTIFACT_UPDATE",
		"ARTIFACT_XP_UPDATE",
		"TRADE_PLAYER_ITEM_CHANGED",
		"PLAYER_TRADE_CURRENCY",
		"CHAT_MSG_CURRENCY",
		"SHIPMENT_CRAFTER_REAGENT_UPDATE",
		"CURRENCY_DISPLAY_UPDATE",
		-- Money
		"PLAYER_MONEY",
		"PLAYER_TRADE_MONEY",
		"TRADE_MONEY_CHANGED",
		"SEND_MAIL_MONEY_CHANGED",
		"SEND_MAIL_COD_CHANGED",
		"TRIAL_STATUS_UPDATE",
		"CHAT_MSG_MONEY",
	}
end


-- $Id: Core.lua 191 2020-07-02 16:19:06Z arith $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs, ipairs, select, unpack, type = _G.pairs, _G.ipairs, _G.select, _G.unpack, _G.type
local string, tonumber = _G.string, _G.tonumber
-- Libraries
local format, strsub, strlen, strgmatch = string.format, string.sub, string.len, string.gmatch
local floor, fmod = math.floor, math.fmod
-- WoW
local GameTooltip = _G.GameTooltip
local BreakUpLargeNumbers = _G.BreakUpLargeNumbers
local GetCurrencyListSize, GetCurrencyListInfo, GetCurrencyInfo = _G.GetCurrencyListSize, _G.GetCurrencyListInfo, _G.GetCurrencyInfo
local GetItemInfoInstant, GetItemCount, GetItemInfo, GetItemIcon = _G.GetItemInfoInstant, _G.GetItemCount, _G.GetItemInfo, _G.GetItemIcon
local UnitName, GetRealmName = _G.UnitName, _G.GetRealmName
local GetMoney = _G.GetMoney

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local LibStub = _G.LibStub
local LibCurrencyInfo = LibStub:GetLibrary("LibCurrencyInfo")
local AceDB = LibStub("AceDB-3.0")
local LDB_CurrencyTracking = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("CurrencyTracking", {
	type = "data source",
	text = CurrencyTracking_TITLE,
	label = CurrencyTracking_TITLE,
})

local CurrencyTracking = LibStub("AceAddon-3.0"):NewAddon("CurrencyTracking", "AceEvent-3.0")
CurrencyTracking.constants = constants
_G.CurrencyTracking = CurrencyTracking
local profile
local item_list

-- local booleans, constants, and arrays
local isInLockdown = false		-- boolean to check if player is in combat
local isInBattleGround = false		-- boolean to check if player is in battleground
local CT_ORIG_GAMPTOOLTIP_SCALE = GameTooltip:GetScale()	-- to get the original GameTooltip's scaling value
local CT_CURRSTR = nil
local CURRENCIESLIST = {}		-- initialize currency list array
local numCurrencies = 0			-- initialize the number of currencies

-- codes adopted from Accountant_Classic
local function getFormattedValue(amount)
	if (amount and type(amount) == "number") then 
		local gold = floor(amount / (COPPER_PER_SILVER * SILVER_PER_GOLD))
		local goldDisplay = profile.breakupnumbers and BreakUpLargeNumbers(gold) or gold
		local silver = floor((amount - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER)
		local copper = fmod(amount, COPPER_PER_SILVER)
		
		local TMP_GOLD_AMOUNT_TEXTURE, TMP_SILVER_AMOUNT_TEXTURE, TMP_COPPER_AMOUNT_TEXTURE

		if (profile.icon_first) then
			TMP_GOLD_AMOUNT_TEXTURE 	= "|TInterface\\MoneyFrame\\UI-GoldIcon:%d:%d:2:0|t %s"
			TMP_SILVER_AMOUNT_TEXTURE 	= "|TInterface\\MoneyFrame\\UI-SilverIcon:%d:%d:2:0|t %02d"
			TMP_COPPER_AMOUNT_TEXTURE 	= "|TInterface\\MoneyFrame\\UI-CopperIcon:%d:%d:2:0|t %02d"

			if (profile.showLowerDenominations) then
				if (gold >0) then
					return format("|cffffffff"..TMP_GOLD_AMOUNT_TEXTURE.." "..TMP_SILVER_AMOUNT_TEXTURE.." "..TMP_COPPER_AMOUNT_TEXTURE.."|r", 0, 0, goldDisplay, 0, 0, silver, 0, 0, copper)
				elseif (silver >0) then 
					return format("|cffffffff"..TMP_SILVER_AMOUNT_TEXTURE.." "..TMP_COPPER_AMOUNT_TEXTURE.."|r", 0, 0, silver, 0, 0, copper)
				elseif (copper >0) then
					return format("|cffffffff"..TMP_COPPER_AMOUNT_TEXTURE.."|r", 0, 0, copper)
				else
					return ""
				end
			else
				return format("|cffffffff"..TMP_GOLD_AMOUNT_TEXTURE.."|r", 0, 0, goldDisplay)
			end
		else
			TMP_GOLD_AMOUNT_TEXTURE 	= "%s|TInterface\\MoneyFrame\\UI-GoldIcon:%d:%d:2:0|t"
			TMP_SILVER_AMOUNT_TEXTURE 	= "%02d|TInterface\\MoneyFrame\\UI-SilverIcon:%d:%d:2:0|t"
			TMP_COPPER_AMOUNT_TEXTURE 	= "%02d|TInterface\\MoneyFrame\\UI-CopperIcon:%d:%d:2:0|t"

			if (profile.showLowerDenominations) then
				if (gold >0) then
					return format(" |cffffffff"..TMP_GOLD_AMOUNT_TEXTURE.." "..TMP_SILVER_AMOUNT_TEXTURE.." "..TMP_COPPER_AMOUNT_TEXTURE.."|r", goldDisplay, 0, 0, silver, 0, 0, copper, 0, 0)
				elseif (silver >0) then 
					return format(" |cffffffff"..SILVER_AMOUNT_TEXTURE.." "..TMP_COPPER_AMOUNT_TEXTURE.."|r", silver, 0, 0, copper, 0, 0)
				elseif (copper >0) then
					return format(" |cffffffff"..COPPER_AMOUNT_TEXTURE.."|r", copper, 0, 0)
				else
					return ""
				end
			else
				return format(" |cffffffff"..TMP_GOLD_AMOUNT_TEXTURE.."|r", goldDisplay, 0, 0)
			end
		end
	end
end

-- Codes adopted from TitanPanel
local function addTooltipText(text)
	if ( text ) then
		-- Append a "\n" to the end 
		if ( strsub(text, -1, -1) ~= "\n" ) then
			text = text.."\n"
		end
		
		-- See if the string is intended for a double column
		for text1, text2 in strgmatch(text, "([^\t\n]*)\t?([^\t\n]*)\n") do
			if ( text2 ~= "" ) then
				-- Add as double wide
				GameTooltip:AddDoubleLine(text1, text2)
			elseif ( text1 ~= "" ) then
				-- Add single column line
				GameTooltip:AddLine(text1)
			else
				-- Assume a blank line
				GameTooltip:AddLine("\n")
			end			
		end
	end
end

-- Codes adopted from TitanCurrency and revised by arith
local function getTooltipText()
	local display = ""
	local tooltip = ""
	local cCount
	cCount = GetCurrencyListSize()
	for i = 1, cCount do 
		-- // GetCurrencyListInfo() syntax:
		-- // name, isHeader, isExpanded, isUnused, isWatched, count, icon = GetCurrencyListInfo(index)
		local name, isHeader, isUnused, count, icon, _
		name, isHeader, _, isUnused, _, count, icon = GetCurrencyListInfo(i)
		if ( isHeader ) then
			tooltip = tooltip..name.."\n"
		elseif ( (count >= 0) and not isUnused ) then
			if (icon ~= nil) then
				local icount = profile.breakupnumbers and BreakUpLargeNumbers(count) or count
				if (count == 0) then
					if (not profile.hide_zero) then
						display = " - "..name.."\t|cffff0000"..icount.." |r|T"..icon..":16|t"
					end
				else
					display = " - "..name.."\t|cffffffff"..icount.." |r|T"..icon..":16|t"
				end
			end
			-- trace(display)
			tooltip = strconcat(tooltip, display, "|r\n")
		end
	end 
	return tooltip    
end

local function button_OnMouseDown(self, buttonName)    
	-- Prevent activation when in combat or when lock is set to true
	if (isInLockdown or profile.always_lock) then
		return
	end
	if(CurrencyTracking.frame:IsVisible()) then
		-- Handle left button clicks
		if (buttonName == "LeftButton") then
			-- Hide tooltip while draging
			GameTooltip:Hide()
			CurrencyTracking.frame:StartMoving()
		elseif (buttonName == "RightButton") then
			CurrencyTracking:OpenOptions(self.isItem)
			GameTooltip_Hide()
		end
	end
end

local function button_OnMouseUp(self, buttonName)
	if (isInLockdown or profile.always_lock) then
		return
	end
	if(CurrencyTracking.frame:IsVisible()) then
		CurrencyTracking.frame:StopMovingOrSizing()
		local point, relativeTo, relativePoint, xOfs, yOfs = CurrencyTracking.frame:GetPoint()
		profile.point = { point, relativeTo, relativePoint, xOfs, yOfs }
	end
end

local function button_OnEnter(self)
	if (isInLockdown) then
		return
	end
	
	if(CurrencyTracking.frame:IsVisible()) then
		if (not GameTooltip:IsShown()) then
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", -10, 0)
			GameTooltip:SetBackdropColor(0, 0, 0, profile.tooltip_alpha)
			GameTooltip:SetText("|cFFFFFFFF"..CurrencyTracking_TITLE, 1, 1, 1, nil, 1)
			local tooltip = getTooltipText()
			if (tooltip) then
				addTooltipText(tooltip)
			end
			GameTooltip:SetScale(profile.tooltip_scale)
			GameTooltip:Show()
		else
			GameTooltip:Hide()
		end
	end
end

local function button_OnLeave(self)
	GameTooltip_Hide()
	GameTooltip:SetScale(CT_ORIG_GAMPTOOLTIP_SCALE)
end

local function handleTrackedButtons(button, currencyID, itemID)
	item_list = CurrencyTracking.db.item_list
	if not button then return end
	local buttonName = button:GetName()
	local bi = tonumber(strsub(buttonName, strlen("CurrencyTrackingButton")+1))
	local maxItems = profile.maxItems or 0
	local nRow, nRowItem
	local rowHeight = 20
	
	if (maxItems == 0) then 
		nRow = 1
	else
		nRow = ( (bi - (bi % maxItems) ) / maxItems ) + 1
		nRowItem = bi % maxItems
		if nRowItem == 0 then nRowItem = maxItems end
	end
	
	local itemName, itemLink, count, icon, _
	local width = 15
	if (currencyID) then 
		_, count, icon = GetCurrencyInfo(currencyID) 
	elseif (itemID) then
		if (item_list[itemID] and item_list[itemID][1] and item_list[itemID][2] and item_list[itemID][3]) then
			itemName, icon, itemLink = item_list[itemID][1], item_list[itemID][2], item_list[itemID][3]
		else
			itemName, itemLink, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
			if not itemName then itemName, itemLink, _, _, _, _, _, _, _, icon = GetItemInfo(itemID) end
			local t = {}
			t.itemID = itemID
			t.itemName = itemName
			t.itemLink = itemLink
			CurrencyTracking.Query.RefreshItem(t)
		end
		count = GetItemCount(itemID, true)
	end

	if (currencyID or itemID) then
		button.icon:SetTexture(icon or 0)
		if (profile.show_iconOnly) then
			button.count:Hide()
		else
			if (count and count == 0) then 
				button.count:SetText("|cffff0000"..count.."|r")
			elseif (count and count > 0) then
				count = profile.breakupnumbers and BreakUpLargeNumbers(count) or count
				button.count:SetText(count)
			else
				button.count:SetText("")
			end
			button.count:Show()
			width = button.count:GetStringWidth() + 10

			if (profile.icon_first) then
				button.icon:SetPoint("LEFT", 0, 0)
				if (not profile.show_iconOnly) then
					button.count:SetPoint("LEFT", button.icon, "RIGHT", 2, 0)
				end
			else
				if (profile.show_iconOnly) then
					button.icon:SetPoint("LEFT", 0, 0)
				else
					button.count:SetPoint("LEFT", 0, 0)
					button.icon:SetPoint("LEFT", button.count, "RIGHT", 2, 0)
				end
			end
		end
	else -- money
		button.icon:SetTexture(nil)
		button.count:SetText(getFormattedValue(GetMoney()))
		width = button.count:GetStringWidth()
	end
	
	button:SetWidth(width)
	if (bi == 1) then
		button:SetPoint("TOPRIGHT", 0, 0)
	else
		if (nRow == 1) then
			button:SetPoint("TOPRIGHT", _G["CurrencyTrackingButton"..bi-1], "TOPLEFT", profile.show_iconOnly and -21 or -12, 0)
		else
			if (nRowItem == 1) then
		button:SetPoint("TOPRIGHT", _G["CurrencyTrackingButton"..bi-maxItems], "TOPLEFT", 0, -rowHeight)
			else
				button:SetPoint("TOPRIGHT", _G["CurrencyTrackingButton"..bi-1], "TOPLEFT", profile.show_iconOnly and -21 or -12, 0)
			end
		end
	end
	button:SetScript("OnMouseDown", button_OnMouseDown)
	button:SetScript("OnMouseUp", button_OnMouseUp)
	if (currencyID and profile.show_tooltip) then
		button:SetScript("OnEnter", button_OnEnter)
	else
		button:SetScript("OnEnter", nil)
	end
	button:SetScript("OnLeave", button_OnLeave)
	button.highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	button.highlight:SetWidth(width)
	button.highlight:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
	button.highlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
	button.isCurrency = currencyID and true or nil
	button.currencyID = currencyID or nil
	button.isMoney = (not currencyID and not itemID) and true or nil
	button.isItem = itemID and true or nil
	button.itemID = itemID or nil
	button.itemName = itemID and itemName or nil
	button.itemLink = itemLink or nil
	if (button.isItem) then
		button.LinkButton.tooltipText = itemLink or nil
	else
		button.LinkButton.tooltipText = currencyID and LibCurrencyInfo:GetCurrencyTokenStrings(currencyID) or nil
	end
	if (currencyID or itemID) then
		button.LinkButton:Show()
	else
		button.LinkButton:Hide()
	end
	button:Show()

end

local function currencyButton_Update()
	local nf = _G["CurrencyTrackingFrame"]
	local button
	local gwidth = 0
	local bi = 1

	-- tracked currencies
	for currencyID, v in pairs(profile["currencies"]) do
		if (currencyID and type(currencyID) == "number" and profile["currencies"][currencyID] == true) then
			local _, count = GetCurrencyInfo(currencyID)

			if (count >= 0) then
				if (profile.hide_zero and count == 0) then
					-- do nothing
				else
					button = _G["CurrencyTrackingButton"..bi]
					if not button then button = CreateFrame("Button", "CurrencyTrackingButton"..bi, nf, "CurrencyTrackingButtonTemplate") end
					handleTrackedButtons(button, currencyID)
					gwidth = gwidth + button:GetWidth()
					bi = bi + 1
				end
			end
		end
	end
	-- tracked items
	for itemID, v in pairs(profile["items"]) do
		if (itemID and profile["items"][itemID] == true) then
			local count = GetItemCount(itemID, true)
			if (profile.hide_zero and count == 0) then
				-- do nothing
			else
				button = _G["CurrencyTrackingButton"..bi]
				if not button then button = CreateFrame("Button", "CurrencyTrackingButton"..bi, nf, "CurrencyTrackingButtonTemplate") end
				handleTrackedButtons(button, nil, itemID)
				gwidth = gwidth + button:GetWidth()
				bi = bi + 1
			end
		end
	end
	-- handle money
	if (profile.show_money) then
		button = _G["CurrencyTrackingButton"..bi]
		if not button then button = CreateFrame("Button", "CurrencyTrackingButton"..bi, nf, "CurrencyTrackingButtonTemplate") end
		handleTrackedButtons(button)
		gwidth = gwidth + button:GetWidth()
		bi = bi + 1
	end

	nf:SetWidth(gwidth)

	button = _G["CurrencyTrackingButton"..bi]
	while button do
		button.icon:SetTexture(nil)
		button.count:SetText(nil)
		if (profile.show_iconOnly) then
			button.count:Hide()
		else
			button.count:Show()
		end
		button:SetWidth(0)
		button.isCurrency = nil
		button.isMoney = nil
		button.isItem = nil
		button.itemID = nil
		button.currencyID = nil
		button.itemName = nil
		button.itemLink = nil
		button.LinkButton.tooltipText = nil
		button.LinkButton:Hide()
		button:Hide()
		bi = bi + 1
		button = _G["CurrencyTrackingButton"..bi]
	end
end

local function currencyString_Update()
	local currencystr = ""

	local CT_CURRENCY_TEXTURE

	-- tracked currencies
	for currencyID, v in pairs(profile["currencies"]) do
		if (currencyID and type(currencyID) == "number" and profile["currencies"][currencyID] == true) then
			local _, count, icon = GetCurrencyInfo(currencyID)
			if not icon then icon = 0 end -- somehow Legionfall War Supplies' icon is not available in 7.2.5.23959, this should temporary resolve the blocking issue
			
			if (count >= 0) then
				if (profile.hide_zero and count == 0) then
					-- do nothing
				else
					if (count == 0) then 
						if (profile.icon_first) then
							CT_CURRENCY_TEXTURE = "|T"..icon..":%d:%d:2:0|t "..RED_FONT_COLOR_CODE.."%s "..FONT_COLOR_CODE_CLOSE
						else
							CT_CURRENCY_TEXTURE = RED_FONT_COLOR_CODE.." %s"..FONT_COLOR_CODE_CLOSE.."|T"..icon..":%d:%d:2:0|t "
						end
					else
						if (profile.icon_first) then
							CT_CURRENCY_TEXTURE = "|T"..icon..":%d:%d:2:0|t "..HIGHLIGHT_FONT_COLOR_CODE.."%s "..FONT_COLOR_CODE_CLOSE
						else
							CT_CURRENCY_TEXTURE = HIGHLIGHT_FONT_COLOR_CODE.." %s"..FONT_COLOR_CODE_CLOSE.."|T"..icon..":%d:%d:2:0|t "
						end
					end
					count = profile.breakupnumbers and BreakUpLargeNumbers(count) or count
					if (profile.icon_first) then
						currencystr = currencystr..format(CT_CURRENCY_TEXTURE, 0, 0, count)
					else
						currencystr = currencystr..format(CT_CURRENCY_TEXTURE, count, 0, 0)
					end
				end
			end
		end
	end
	-- tracked items
	for itemID, v in pairs(profile["items"]) do
		if (itemID and profile["items"][itemID] == true) then
			local count = GetItemCount(itemID, true)
			--local icon = select(10, GetItemInfo(itemID))
			local icon = GetItemIcon(itemID)

			if (profile.hide_zero and count == 0) then
				-- do nothing
			else
				local displayString
				if (profile.icon_first) then
					displayString = format("|T%d:%d:%d:2:0|t |cffffffff%d|r", icon, 16, 16, count)
				else
					displayString = format("|cffffffff%d|r|T%d:%d:%d:2:0|t ", count, icon, 16, 16)
				end
				
				currencystr = currencystr..displayString
			end
		end
	end
	-- return could be nil if no any currency being tracked
	return currencystr
end

local function getButtonText()
	local currencystr = currencyString_Update()

	if (currencystr) then 
		if (profile.show_money) then
			currencystr = currencystr..getFormattedValue(GetMoney())
		end
	else
		if (profile.show_money) then
			currencystr = getFormattedValue(GetMoney())
		else
			currencystr = CurrencyTracking_TITLE
		end
	end
	
	return currencystr
end

local function currencyUpdate()
	if (profile.show_currency) then currencyButton_Update() end

	local currencystr = getButtonText()
	if (currencystr ~= CT_CURRSTR) then
		LDB_CurrencyTracking.text = currencystr
		CT_CURRSTR = currencystr
	end
end

local function createCurrencyFrame()
	local f = CreateFrame("Frame")
	
	local nf = _G["CurrencyTrackingFrame"]
	if not nf then nf = CreateFrame("Frame", "CurrencyTrackingFrame") end
	nf:SetParent("UIParent")
	nf:SetWidth(200)
	nf:SetHeight(20)
	nf.Texture = nf:CreateTexture(nil, "BACKGROUND")
	local point, relativeTo, relativePoint, ofsx, ofsy = unpack(profile.point)
	nf:SetPoint(point or "BOTTOMRIGHT", "UIParent", relativePoint or "BOTTOMRIGHT", ofsx or 0, ofsy or 0)
	--nf:SetClampedToScreen(true)
	nf:SetMovable(true)
	nf:EnableMouse(true)
	
	return nf
end

local function setupLDB()
	-- LDB object setting up
	LDB_CurrencyTracking.icon = "Interface\\Icons\\timelesscoin"
	LDB_CurrencyTracking.OnClick = (function(self, button)
		if button == "LeftButton" then
			CurrencyTracking:OpenOptions()
		elseif button == "RightButton" then
		end
	end)

	LDB_CurrencyTracking.OnTooltipShow = (function(tooltip)
		if not tooltip or not tooltip.AddLine then return end
		local tooltiptxt = getTooltipText()
		GameTooltip:SetBackdropColor(0, 0, 0, profile.tooltip_alpha)
		GameTooltip:SetText(CurrencyTracking_TITLE, 1, 1, 1, nil, 1)
		if (tooltiptxt) then
			addTooltipText(tooltiptxt)
		end
		GameTooltip:SetScale(profile.tooltip_scale)
	end)
	
	LDB_CurrencyTracking.text = getButtonText()
end

local function frameRefresh()
	if( profile.show_currency == true) then
		CurrencyTracking.frame:Show()
		CurrencyTracking.frame:SetAlpha(profile.alpha)
		--CurrencyTracking.frame.Texture:SetColorTexture(0, 0, 0, profile.bgalpha)
		CurrencyTracking.frame:SetScale(profile.scale)
		--CurrencyTracking.frame:SetBackdropBorderColor(0, 1.0, 0, 1)
		--CurrencyTracking.frame:SetBackdropColor(0, 0, 1.0, 1)
		local bi = 1
		local button
		button = _G["CurrencyTrackingButton"..bi]
		while button and button:IsVisible() and button.icon:GetTexture() do
			if (profile.icon_first) then
				button.icon:SetPoint("LEFT", 0, 0)
				if (not profile.show_iconOnly) then
					button.count:SetPoint("LEFT", button.icon, "RIGHT", 2, 0)
				end
			else
				if (profile.show_iconOnly) then
					button.icon:SetPoint("LEFT", 0, 0)
				else
					button.count:SetPoint("LEFT", 0, 0)
					button.icon:SetPoint("LEFT", button.count, "RIGHT", 2, 0)
				end
			end
			bi = bi + 1
			button = _G["CurrencyTrackingButton"..bi]
		end
	else
		CurrencyTracking.frame:Hide()
	end
end

local function getNumberOfCurrencies()
	local n = 0
	for k,v in pairs(LibCurrencyInfo.data.CurrencyByCategory) do
		n = n + 1 + #v
	end
	
	return n
end

local function populateCurrencyList()
	if not CURRENCIESLIST then CURRENCIESLIST = {} end

	local i = 1
	local lang = GetLocale()
	for k,v in pairs(LibCurrencyInfo.data.CurrencyByCategory) do
		CURRENCIESLIST[i] = { isHeader = true, headerKey = k }
		i = i + 1
		for ka,id in ipairs(v) do
			CURRENCIESLIST[i] = { id = id }
			i = i + 1
		end
	end
end

function CurrencyTracking:OnInitialize()
	self.db = AceDB:New("CurrencyTrackingDB", CurrencyTracking.constants.defaults)
	profile = self.db.profile
	item_list = self.db.item_list

	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh")

	self:SetupOptions()
	self.frame = createCurrencyFrame()
	numCurrencies = getNumberOfCurrencies()
	populateCurrencyList()
end

function CurrencyTracking:OnEnable()
	for key, value in pairs( CurrencyTracking.constants.events ) do
		self:RegisterEvent( value )
	end

	setupLDB()
	self.Query.ScanItems() -- pre-scan items so that they will properly showed in option panel
	currencyUpdate()
	self:Refresh()
end

function CurrencyTracking:Refresh()
	profile = self.db.profile
	currencyUpdate()
	frameRefresh()
end

-- ///////////////////////////////////////////////////
-- Event handling
-- ///////////////////////////////////////////////////
local function hideFrame(key)
	if (profile.show_currency and profile[key]) then
		local nf = _G["CurrencyTrackingFrame"]
		nf:Hide()
	end
end

-- ///////////////////////////////////////////////////
-- Combat
-- Event fired whenever you enter combat
function CurrencyTracking:PLAYER_REGEN_DISABLED()
	isInLockdown = true
	hideFrame("hide_in_combat")
end

-- Event fired after ending combat
function CurrencyTracking:PLAYER_REGEN_ENABLED()
	isInLockdown = false
	
	local nf = _G["CurrencyTrackingFrame"]
	if (profile.show_currency and not nf:IsShown()) then
		if (isInBattleGround and profile.hide_in_battleground) then
			-- if player is in battleground and also set to auto-hide frame untile leave battle ground, 
			-- then we should not show the frame after player ending combat, so do nothing here!
		else
			nf:Show()
		end
	end
end

-- ///////////////////////////////////////////////////
-- Battleground
-- Event fired when the battlegrounds signup window is opened.
function CurrencyTracking:BATTLEFIELDS_SHOW()
	isInBattleGround = true
	hideFrame("hide_in_battleground")
end

-- Event fired when the battlegrounds signup window is closed.
function CurrencyTracking:BATTLEFIELDS_CLOSED()
	isInBattleGround = false
	
	local nf = _G["CurrencyTrackingFrame"]
	if (profile.show_currency and not nf:IsShown()) then
		nf:Show()
	end
end

-- ///////////////////////////////////////////////////
-- Pet battle
function CurrencyTracking:PET_BATTLE_OPENING_START()
	hideFrame("hide_in_petbattle")
end

function CurrencyTracking:PET_BATTLE_CLOSE()
	local nf = _G["CurrencyTrackingFrame"]
	if (profile.show_currency and not nf:IsShown()) then
		if (isInBattleGround and profile.hide_in_battleground) then
			-- if player is in battleground and also set to auto-hide frame untile leave battle ground, 
			-- then we should not show the frame right after pet battle ends, so do nothing here!
		else
			nf:Show()
		end
	end
end

-- Fired when a bags inventory changes.
function CurrencyTracking:BAG_UPDATE()
	currencyUpdate()
end

function CurrencyTracking:TRADE_CURRENCY_CHANGED()
	currencyUpdate()
end

-- This event fires whenever the data for an artifact has been updated, such as after completing a new one. 
function CurrencyTracking:ARTIFACT_UPDATE()
	currencyUpdate()
end

-- Event fired when gaining artifact power for the current equipped artifact weapon.
function CurrencyTracking:ARTIFACT_XP_UPDATE()
	currencyUpdate()
end

-- Fired when an item in the target's trade window is changed (items added or removed from trade).
function CurrencyTracking:TRADE_PLAYER_ITEM_CHANGED()
	currencyUpdate()
end

function CurrencyTracking:PLAYER_TRADE_CURRENCY()
	currencyUpdate()
end

-- Fires when you gain currency other than money (for example Chef's Awards or Champion's Seals). 
function CurrencyTracking:CHAT_MSG_CURRENCY()
	currencyUpdate()
end

function CurrencyTracking:SHIPMENT_CRAFTER_REAGENT_UPDATE()
	currencyUpdate()
end

-- Fired every time the UI need to draw the currencies list. 
function CurrencyTracking:CURRENCY_DISPLAY_UPDATE()
	currencyUpdate()
end

function CurrencyTracking:PLAYER_MONEY()
	currencyUpdate()
end
function CurrencyTracking:PLAYER_TRADE_MONEY()
	currencyUpdate()
end
function CurrencyTracking:TRADE_MONEY_CHANGED()
	currencyUpdate()
end
function CurrencyTracking:SEND_MAIL_MONEY_CHANGED()
	currencyUpdate()
end
function CurrencyTracking:SEND_MAIL_COD_CHANGED()
	currencyUpdate()
end
function CurrencyTracking:TRIAL_STATUS_UPDATE()
	currencyUpdate()
end
function CurrencyTracking:CHAT_MSG_MONEY()
	currencyUpdate()
end



-- $Id: Query.lua 191 2020-07-02 16:19:06Z arith $
-- WoW
local GetTime, CreateFrame = _G.GetTime, _G.CreateFrame
local Query = CurrencyTracking:NewModule("Query", "AceEvent-3.0")
CurrencyTracking.Query = Query

local db
local SPAM_PROTECT = 0.5

-- codes adopted from AtlasLoot ItemQuery

function Query:OnInitialize()
	db = CurrencyTracking.db
	if (db.item_list == nil) then db.item_list = {} end
	item_list = db.item_list
end

function Query:OnEnable()

end

function Query:OnDisable()

end

function Query.RefreshItem(item)
	if not item_list[item.itemID] then
		if ( item.itemName and item.icon ) then
			item_list[item.itemID] = { item.itemName, item.icon, item.itemLink }
		end
	else
		if ( item_list[item.itemID][1] ~= item.itemName ) then
			item_list[item.itemID] = { item.itemName, item.icon, item.itemLink }
		end
	end
end


-- scanItems()
-- pre-scan items so that they will properly showed in option panel
-- this function will not generate any visible result but it's more like scanning items 
-- so that those will be in your cache
function Query.ScanItems()
	for k, v in pairs(CurrencyTracking.constants.items) do
		if k == "professions" then
			for ka, profs in pairs(v) do
				for kb, itemID in ipairs(profs) do
					if ( item_list[itemID] and item_list[itemID][1] ) then
						-- do nothing
					else
						local itemName, itemLink, icon, _
						itemName, itemLink, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
						if not itemName then itemName, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID) end
						local item = {}
						item.itemID = itemID
						item.itemName = itemName
						item.itemLink = itemLink
						item.icon = icon
						Query.RefreshItem(item)
					end
				end
			end
		else
			for ka, itemID in ipairs(v) do
				if ( item_list[itemID] and item_list[itemID][1] ) then
					-- do nothing
				else
					local itemName, itemLink, icon, _
					itemName, itemLink, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
					if not itemName then itemName, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID) end
					local item = {}
					item.itemID = itemID
					item.itemName = itemName
					item.itemLink = itemLink
					item.icon = icon
					Query.RefreshItem(item)
				end
			end
		end
	end
end