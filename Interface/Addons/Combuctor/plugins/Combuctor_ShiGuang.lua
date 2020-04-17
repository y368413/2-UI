-----------------------Author:y368413-----------------------
local OpenItems = {
--------T_SPELL_BY_NAME
  [112023] = "",-- Recipe: Draenic Philosopher's Stone] = "", all learnable] = "", it should replace most items in table T_RECIPES
  [114171] = "",-- Crate Restored Artifact] = "", common for all
  [113271] = "",-- Giant Kaliri Egg] = "", Gain xxx Garrison Resources] = "",common for all
  [128316] = "",-- Bulging Barrel of Oil] = "", Convert to Oil
  [138865] = "",-- Gladiator's Triumph] = "", Grants 50 Artifact Power to your currently equipped Artifact.
  [139669] = "",-- Toss the fish back into the water] = "", granting 50 Artifact Power to your fishing artifact.
  [133742] = "",-- Toss the fish back into the water] = "", increasing Fishing skill by 5] = "", up to a max of 800.
  [139390] = "",-- Artifact Research Notes] = "", Use: Read to gain new knowledge about your artifact] = "", increasing the rate at which you earn Artifact Power.
  [129097] = "", -- 30 Ancient Mana
  [140243] = "", -- 50 Ancient Mana
  [140401] = "", -- 75 Ancient Mana
  [140236] = "", -- [100 Ancient Mana
  [140240] = "", -- 150 Ancient Mana
  [140242] = "", -- 200 Ancient Mana
  [140239] = "", -- 300 Ancient Mana
  [140526] = "", -- Eredar Signet] = "", Use: Provides a significant increase to character experience.
  [141028] = "", -- Grimoire of Knowledge] = "", Use: Open your Followers page and use this item to grant 4000 XP directly to a Champion.
--------T_SPELL_BY_USE_TEXT
  [168701] = "", -- Create a soulbound item appropriate for your loot specialization] = "", Tormented Trinket
  [168178] = "", -- Salvage] = "", Bag of Salvaged Goods] = "", can be used only in salvage-yard shown on button only in garrison even if disabled zone-lock
  [58165] = "",  -- Open the clam!] = "", Big-Mouth Clam
  [166550] = "",  -- Flip Card] = "", Card of Omens
  [163769] = "", -- Toss Fish] = "", Lunarfall Carp] = "", can be used only in garrison shown on button only in garrison.
  [233232] = "", -- 25 mana
  [193080] = "", -- 30 mana
  [222333] = "", -- 50 mana
  [223677] = "", -- 75 mana
  [222942] = "", -- [100 mana
  [222947] = "", -- 150 mana
  [222950] = "", -- 200 mana
  [222945] = "", -- 300 mana
-----------T_RECIPES
  [122219] = "", -- Music Roll: Way of the Monk
  [122594] = "", -- Rush Order: Tailoring Emporium
  [100865] = "", -- Plans: Balanced Trillium Ingot and Its Uses
  [118592] = "", -- Partial Receipt: Gizmothingies
  [128440] = "", -- Contract: Dowser Goodwell
  [100863] = "", -- Pattern: Celestial Cloth and Its Uses] = "", some old recipes has no leraning spell
  [138883] = "", -- 4th line contains Use: Target one of your troops to restore 1 vitality.
  [111972] = "", -- Enchanter's Study] = "", Level 2] = "", 2nd line contains "Garrison Blueprint"
  [128315] = "", -- Medallion of the Legion] = "", 2nd line contains "Use: Crush the medallion] = "", increasing reputation with the denizens of Draenor by 1] = "",000. (1 Sec Cooldown)"
  [127751] = "", -- Fel-Touched Pet Supplies] = "", 3rd line Use: Open the bag. (1 Sec Cooldown)
  [44983] = "", -- Strand Crawler] = "", 3rd line contains "Use: Teaches you how to summon this companion."
  [104165] = "", -- Kovok] = "", 3rd line contains "Use: Teaches you how to summon and dismiss this companion."
  [118427] = "", -- Autographed Hearthstone Card] = "", 3rd line contains "Use: Adds this toy to your toy box."
  [127413] = "", -- Jeweled Arakkoa Effigy] = "", 3rd line contains "Use: Pry out the eyes of the statue."
----------------------------------------------------------------T_ITEMS---------------------------------
  [140327] = "", -- Kyrtos's Research Notes
  [136269] = "", -- Kel'danath's Manaflask
  [140448] = "", -- Lens of Qin'dera
  [139025] = "", -- Wardens Insignia
  [139028] = "", -- Disc of the Starcaller
   [69838] = "", -- Chirping Box
   [89125] = "", -- Sack of Pet Supplies
   [16885] = "", -- Heavy Junkbox
   [78890] = "", -- Crystalline Geode
   [78891] = "", -- Elementium-Coated Geode
   [98134] = "", [98546] = "", -- Scenario - Push Loot
   [93146] = "", [93147] = "", [93148] = "", [93149] = "", [94207] = "", [118697] = "", [98095] = "", [91085] = "", [91086] = "", -- Pet Supplies
  [89112] = "", -- Motes of Harmony祥和微粒
  [2934] = "",  -- Ruined Leather Scraps
  [25649] = "",  -- Knothide Leather Scraps
  [33567] = "",  -- Borean Leather Scraps
  [52977] = "",  -- Savage Leather Scraps
  [72162] = "",  -- Sha-Touched Leather
  [97512] = "", -- Ghost Iron Nugget
  [97546] = "", -- Kyparite Fragment
  [115504] = "", -- Fractured Temporal Crystal碎裂的时光水晶
  [108294] = "",-- Silver Ore Nugget
  [108295] = "", -- Tin Ore Nugget
  [108296] = "", -- Gold Ore Nugget
  [108297] = "", -- Iron Ore Nugget
  [108298] = "", -- Thorium Ore Nugget
  [108299] = "", -- Truesilver Ore Nugget
  [108300] = "", -- Mithril Ore Nugget
  [108301] = "", -- Fel Iron Ore Nugget
  [108302] = "", -- Adamantite Ore Nugget
  [108303] = "", -- Eternium Ore Nugget
  [108304] = "", -- Khorium Ore Nugget
  [108305] = "", -- Cobalt Ore Nugget
  [108306] = "", -- Saronite Ore Nugget
  [108307] = "", -- Obsidium Ore Nugget
  [108308] = "", -- Elementium Ore Nugget
  [108309] = "", -- Pyrite Ore Nugget
  [108391] = "", -- Titanium Ore Nugget  
  [109991] = "", -- True Iron Nugget真铁矿块
  [109992] = "", -- Blackrock Fragment黑石碎片
  [110610] = "", -- Raw Beast Hide Scraps
  [112158] = "", -- Icy Dragonscale Fragment
  [112177] = "", -- Nerubian Chitin Fragment
  [112178] = "", -- Jormungar Scale Fragment
  [112179] = "", -- Patch of Thick Clefthoof Leather
  [112180] = "", -- Patch of Crystal Infused Leather
  [112181] = "", -- Fel Scale Fragment
  [112182] = "", -- Patch of Fel Hide
  [112183] = "", -- Nether Dragonscale Fragment
  [112184] = "", -- Cobra Scale Fragment
  [112185] = "", -- Wind Scale Fragment
  [111589] = "", [111595] = "", [111601] = "", -- Crescent Saberfish新月剑齿鱼
  [111659] = "", [111664] = "", [111671] = "", -- Abyssal Gulper Eel深渊大嘴鳗
  [111652] = "", [111667] = "", [111674] = "", -- Blind Lake Sturgeon盲眼湖鲟
  [111662] = "", [111663] = "", [111670] = "", -- Blackwater Whiptail黑水鞭尾鱼
  [111658] = "", [111665] = "", [111672] = "", -- Sea Scorpion海蝎子
  [111651] = "", [111668] = "", [111675] = "", -- Fat Sleeper塘鲈
  [111656] = "", [111666] = "", [111673] = "", -- Fire Ammonite熔火鱿鱼
  [111650] = "", [111669] = "", [111676] = "", -- Jawless Skulker无颚潜鱼
  [118267] = "", -- Ravenmother Offering
  [120301] = "", [120302] = "", -- Create Armor Enhancement] = "", Weapon Boost
  [113992] = "", -- Scribe's Research Notes
  [115981] = "", -- Abrogator Stone Cluster
  [118897] = "", -- Miner's Coffee
  [118903] = "", -- Preserved Mining Pick
  [128373] = "", -- Rush Order: Shipyard
  [111356] = "", [111364] = "", [111387] = "", [111350] = "", [111349] = "", [111351] = "", [115357] = "", [109558] = "", -- Draenor 700 skills
  [111923] = "", [115358] = "", [115356] = "", [115359] = "", [111921] = "", [111922] = "", [109586] = "", -- Draenor 700 skills
  [120321] = "", -- Mystery Bag
  [122535] = "", -- Traveler's Pet Supplies
  [97619] = "", -- Torn Green Tea Leaf
  [97620] = "", -- Rain Poppy Petal
  [97621] = "", -- Silkweed Stem
  [97622] = "", -- Snow Lily Petal
  [97623] = "", -- Fool's Cap Spores
  [108318] = "", -- Mageroyal Petal
  [108319] = "", -- Earthroot Stem
  [108320] = "", -- Briarthorn Bramble
  [108321] = "", -- Swiftthistle Leaf
  [108322] = "", -- Bruiseweed Stem
  [108323] = "", -- Wild Steelbloom Petal
  [108324] = "", -- Kingsblood Petal
  [108325] = "", -- Liferoot Stem
  [108326] = "", -- Khadgar's Whisker Stem
  [108327] = "", -- Grave Moss Leaf
  [108328] = "", -- Fadeleaf Petal
  [108329] = "", -- Dragon's Teeth Stem
  [108330] = "", -- Stranglekelp Blade
  [108331] = "", -- Goldthorn Bramble
  [108332] = "", -- Firebloom Petal
  [108333] = "", -- Purple Lotus Petal
  [108334] = "", -- Arthas' Tears Petal
  [108335] = "", -- Sungrass Stalk
  [108336] = "", -- Blindweed Stem
  [108337] = "", -- Ghost Mushroom Cap
  [108338] = "", -- Gromsblood Leaf
  [108339] = "", -- Dreamfoil Blade
  [108340] = "", -- Golden Sansam Leaf
  [108341] = "", -- Mountain Silversage Stalk
  [108342] = "", -- Sorrowmoss Leaf
  [108343] = "", -- Icecap Petal
  [108344] = "", -- Felweed Stalk
  [108345] = "", -- Dreaming Glory Petal
  [108346] = "", -- Ragveil Cap
  [108347] = "", -- Terocone Leaf
  [108348] = "", -- Ancient Lichen Petal
  [108349] = "", -- Netherbloom Leaf
  [108350] = "", -- Nightmare Vine Stem
  [108351] = "", -- Mana Thistle Leaf
  [108352] = "", -- Goldclover Leaf
  [108353] = "", -- Adder's Tongue Stem
  [108354] = "", -- Tiger Lily Petal
  [108355] = "", -- Lichbloom Stalk
  [108356] = "", -- Icethorn Bramble
  [108357] = "", -- Talandra's Rose Petal
  [108358] = "", -- Deadnettle Bramble
  [108359] = "", -- Fire Leaf Bramble
  [108360] = "", -- Cinderbloom Petal
  [108361] = "", -- Stormvine Stalk
  [108362] = "", -- Azshara's Veil Stem
  [108363] = "", -- Heartblossom Petal
  [108364] = "", -- Twilight Jasmine Petal
  [108365] = "", -- Whiptail Stem
  [109624] = "", -- Broken Frostweed Stem
  [109625] = "", -- Broken Fireweed Stem
  [109626] = "", -- Gorgrond Flytrap Ichor
  [109627] = "", -- Starflower Petal
  [109628] = "", -- Nagrand Arrowbloom Petal
  [109629] = "", -- Talador Orchid Petal
  [115510] = "", -- Elemental Rune
  [128490] = "", -- Blueprint: Oil Rig
  [128446] = "", -- Saberstalker Teachings: Trailblazer
  [122514] = "", -- Mission Completion Orders
  [112087] = "", -- Obsidian Frostwolf Petroglyph
  [128488] = "", -- Ship: The Awakener
  [128225] = "", -- Empowered Apexis Fragment
  [110508] = "", -- "Fragrant" Pheromone Fish
  [32971] = "", -- Water Bucket
  [128294] = "", -- Trade Agreement: Arakkoa Outcasts
  [114002] = "", -- Encoded Message
  [103641] = "", -- Singing Crystal
  [103642] = "", -- Book of the Ages
  [103643] = "", -- Dew of Eternal Morning
  [104287] = "", -- Windfeather Plume
  [122599] = "", -- Tome of Sorcerous Elements
  [122605] = "", -- Tome of the Stones
  [140397] = "", -- G'Hanir's Blossom
  [140439] = "", -- Sunblossom Pollen
  [140260] = "", -- Arcane Remnant of Falanaar
  [141870] = "", -- Arcane Tablet of Falanaar
  [139023] = "", -- Court of Farondis Insignia 
  [139021] = "", -- Dreamweaver Insignia 
  [139024] = "", -- Highmountain Tribe Insignia 
  [139026] = "", -- Nightfallen Insignia 
  [139020] = "", -- Valarjar Insignia 
  [141340] = "", -- Court of Farondis Insignia BoA
  [141339] = "", -- Dreamweaver Insignia BoA
  [141341] = "", -- Highmountain Tribe Insignia BoA
  [141343] = "", -- Nightfallen Insignia BoA
  [141338] = "", -- Valarjar Insignia BoA
  [141342] = "", -- Wardens Insignia BoA
  [141989] = "", -- Greater Court of Farondis Insignia 
  [141988] = "", -- Greater Dreamweaver Insignia 
  [141990] = "", -- Greater Highmountain Tribe Insignia 
  [141992] = "", -- Greater Nightfallen Insignia 
  [141987] = "", -- Greater Valarjar Insignia 
  [141991] = "", -- Greater Wardens Insignia
  [139010] = "", -- Petrified Silkweave
  [139017] = "", -- Soothing Leystone Shard
  [139376] = "", -- Healing Well
  [136412] = "", -- Heavy Armor Set
  [137207] = "", -- Fortified Armor Set
  [137208] = "", -- Indestructible Armor Set
  [142156] = "", -- Order Resources Cache
  [140451] = "", -- Spellmask of Azsylla
  [140329] = "", -- Infinite Stone
  [139027] = "", -- Lenses of Spellseer Dellian
  [139011] = "", -- Berserking Helm of Ondry'el
  [140450] = "", -- Berserking Helm of Taenna
  [142447] = "", -- Torn Sack of Pet Supplies
  [142156] = "", -- Order Resources Cache
  [20565] = "",
};

local GarrisonItems = {
--scanned from tooltips
	[141858] = "",
	[141922] = "",
	[140517] = "",
	[141667] = "",
	[141859] = "",
	[141923] = "",
	[140518] = "",
	[141668] = "",
	[141924] = "",
	[140519] = "",
	[141669] = "",
	[140392] = "",
	[140520] = "",
	[141670] = "",
	[138732] = "",
	[141926] = "",
	[140521] = "",
	[141671] = "",
	[141863] = "",
	[141927] = "",
	[140522] = "",
	[143716] = "",
	[143333] = "",
	[141928] = "",
	[140459] = "",
	[140523] = "",
	[141673] = "",
	[140396] = "",
	[140460] = "",
	[138480] = "",
	[141674] = "",
	[141930] = "",
	[140461] = "",
	[140525] = "",
	[141675] = "",
	[141931] = "",
	[140462] = "",
	[141676] = "",
	[141932] = "",
	[140463] = "",
	[141677] = "",
	[140847] = "",
	[141933] = "",
	[139506] = "",
	[141678] = "",
	[141934] = "",
	[139507] = "",
	[141679] = "",
	[141935] = "",
	[140466] = "",
	[139508] = "",
	[141680] = "",
	[141872] = "",
	[141936] = "",
	[140467] = "",
	[140531] = "",
	[141681] = "",
	[141937] = "",
	[140468] = "",
	[140532] = "",
	[141682] = "",
	[142449] = "",
	[142002] = "",
	[139511] = "",
	[141683] = "",
	[142450] = "",
	[143536] = "",
	[139512] = "",
	[141684] = "",
	[141876] = "",
	[142451] = "",
	[140471] = "",
	[141685] = "",
	[141877] = "",
	[141941] = "",
	[142005] = "",
	[138812] = "",
	[140409] = "",
	[140473] = "",
	[138813] = "",
	[142454] = "",
	[140474] = "",
	[138814] = "",
	[142455] = "",
	[140475] = "",
	[141689] = "",
	[141945] = "",
	[140476] = "",
	[141690] = "",
	[140349] = "",
	[141946] = "",
	[140477] = "",
	[141883] = "",
	[141947] = "",
	[140478] = "",
	[141948] = "",
	[140479] = "",
	[141310] = "",
	[141949] = "",
	[140480] = "",
	[143738] = "",
	[141886] = "",
	[141950] = "",
	[140481] = "",
	[143739] = "",
	[141887] = "",
	[138885] = "",
	[140482] = "",
	[143740] = "",
	[141313] = "",
	[141888] = "",
	[138886] = "",
	[143677] = "",
	[143741] = "",
	[143869] = "",
	[141889] = "",
	[143486] = "",
	[140484] = "",
	[143742] = "",
	[143870] = "",
	[140357] = "",
	[141954] = "",
	[140485] = "",
	[139591] = "",
	[143743] = "",
	[143871] = "",
	[141891] = "",
	[140422] = "",
	[140486] = "",
	[143680] = "",
	[143744] = "",
	[141892] = "",
	[141956] = "",
	[140487] = "",
	[132950] = "",
	[141701] = "",
	[140488] = "",
	[141638] = "",
	[143746] = "",
	[141383] = "",
	[131802] = "",
	[141639] = "",
	[143747] = "",
	[141384] = "",
	[142534] = "",
	[141704] = "",
	[141896] = "",
	[142535] = "",
	[141705] = "",
	[140364] = "",
	[140492] = "",
	[141706] = "",
	[140237] = "",
	[140365] = "",
	[141707] = "",
	[14038] = "",
	[140366] = "",
	[140494] = "",
	[141708] = "",
	[140470] = "",
	[131732] = "", --Overrided values
	[140367] = "",
	[140389] = "",
	[131808] = "",
	[140528] = "",
	[140359] = "",
	[140176] = "",
	[140382] = "",
	[140304] = "",
	[140368] = "",
	[143498] = "",
	[140358] = "",
	[142007] = "",
	[131795] = "",
	[141710] = "",
	[140241] = "",
	[140305] = "",
	[141391] = "",
	[143499] = "",
	[140497] = "",
	[141385] = "",
	[141389] = "",
	[141711] = "",
	[141953] = "",
	[140306] = "",
	[140370] = "",
	[138782] = "",
	[140498] = "",
	[132897] = "",
	[141890] = "",
	[141390] = "",
	[141952] = "",
	[140307] = "",
	[141393] = "",
	[139413] = "",
	[141405] = "",
	[141024] = "",
	[143714] = "",
	[143757] = "",
	[140244] = "",
	[141394] = "",
	[140372] = "",
	[140469] = "",
	[141699] = "",
	[141702] = "",
	[138816] = "",
	[141929] = "",
	[140511] = "",
	[140421] = "",
	[141395] = "",
	[141944] = "",
	[141703] = "",
	[140373] = "",
	[143715] = "",
	[141942] = "",
	[140361] = "",
	[140310] = "",
	[141396] = "",
	[131751] = "",
	[141386] = "",
	[140490] = "",
	[139608] = "",
	[140369] = "",
	[140247] = "",
	[141855] = "",
	[141397] = "",
	[141387] = "",
	[140503] = "",
	[143540] = "",
	[139609] = "",
	[141403] = "",
	[141709] = "",
	[140393] = "",
	[141398] = "",
	[131753] = "",
	[140504] = "",
	[140491] = "",
	[139610] = "",
	[138881] = "",
	[140410] = "",
	[138864] = "",
	[141399] = "",
	[140371] = "",
	[140505] = "",
	[143749] = "",
	[139611] = "",
	[141402] = "",
	[140250] = "",
	[138781] = "",
	[141400] = "",
	[140524] = "",
	[141314] = "",
	[130152] = "",
	[139612] = "",
	[142453] = "",
	[140251] = "",
	[141337] = "",
	[141401] = "",
	[141943] = "",
	[140507] = "",
	[143844] = "",
	[139613] = "",
	[140379] = "",
	[140252] = "",
	[138783] = "",
	[140380] = "",
	[140444] = "",
	[140508] = "",
	[142533] = "",
	[139614] = "",
	[138880] = "",
	[142004] = "",
	[138784] = "",
	[140381] = "",
	[140445] = "",
	[140509] = "",
	[142006] = "",
	[139615] = "",
	[138865] = "",
	[140254] = "",
	[138785] = "",
	[141404] = "",
	[143487] = "",
	[140510] = "",
	[142003] = "",
	[139616] = "",
	[140377] = "",
	[140255] = "",
	[141852] = "",
	[140383] = "",
	[143533] = "",
	[142555] = "",
	[143538] = "",
	[139617] = "",
	[143713] = "",
	[141672] = "",
	[141853] = "",
	[140384] = "",
	[136360] = "", --Overrided values
	[141023] = "",
	[143745] = "",
	[143868] = "",
	[140374] = "",
	[141921] = "",
	[141854] = "",
	[140385] = "",
	[141951] = "",
	[140513] = "",
	[141392] = "",
	[138839] = "",
	[138487] = "",
	[138786] = "",
	[140322] = "",
	[140386] = "",
	[131763] = "",
	[140489] = "",
	[140530] = "",
	[140529] = "",
	[139510] = "",
	[143488] = "",
	[141856] = "",
	[140387] = "",
	[141925] = "",
	[140515] = "", --Overrided values
	[140391] = "",
	[139509] = "",
	[142054] = "",
	[141955] = "",
	[141857] = "",
	[140388] = "",
	[141388] = "",
	[140516] = "",
	[140512] = "",
	[141940] = "",
	[140685] = "",
	[142001] = "",
--autogenerated table
   [140953] = "",
   [140242] = "",
   [140245] = "",
   [140235] = "",
   [140733] = "",
   [129098] = "",
   [140404] = "",
   [140399] = "",
   [139889] = "",
   [129097] = "",
   [137010] = "",
   [140405] = "",
   [139884] = "",
   [140240] = "",
   [140401] = "",
   [140243] = "",
   [140390] = "",
   [129036] = "",
   [140949] = "",
   [139890] = "",
   [141655] = "",
   [139786] = "",
   [140734] = "",
   [140732] = "",
   [140402] = "",
   [140735] = "",
   [140239] = "",
   [140403] = "",
   [140246] = "",
   [140236] = "",
   [140248] = "",
   [136806] = "",
   [140406] = "",
   [140234] = "",
--autogenerated table (maybe incomplete] = "", skips spellIDs < 2077[13)
	[137208] = "",
	[141028] = "",
	[137207] = "",
	[136412] = "",
--autogenerated table  (maybe incomplete] = "", skips spellIDs < 215915)
	[139851] = "",
	[139860] = "",
	[139863] = "",
	[139855] = "",
	[139844] = "",
	[139839] = "",
	[139874] = "",
	[139821] = "",
	[139833] = "",
	[139852] = "",
	[139808] = "",
	[139842] = "",
	[140583] = "",
	[139811] = "",
	[139846] = "",
	[139837] = "",
	[139827] = "",
	[139849] = "",
	[140760] = "",
	[139869] = "",
	[139835] = "",
	[139859] = "",
	[139871] = "",
	[139841] = "",
	[139831] = "",
	[139814] = "",
	[139870] = "",
	[140156] = "",
	[139830] = "",
	[139845] = "",
	[139825] = "",
	[139847] = "",
	[139829] = "",
	[139850] = "",
	[139872] = "",
	[140573] = "",
	[139809] = "",
	[139854] = "",
	[139878] = "",
	[139856] = "",
	[139861] = "",
	[139876] = "",
	[139419] = "",
	[139819] = "",
	[139804] = "",
	[139873] = "",
	[139862] = "",
	[139828] = "",
	[140749] = "",
	[139867] = "",
	[140582] = "",
	[140581] = "",
	[140572] = "",
	[140571] = "",
	[138413] = "",
	[139834] = "",
	[139823] = "",
	[139877] = "",
	[139864] = "",
	[139838] = "",
	[139868] = "",
	[139866] = "",
	[139836] = "",
	[139865] = "",
	[139840] = "",
	[139428] = "",
	[139875] = "",
	[139799] = "",
	[139792] = "",
	[139795] = "",
	[139857] = "",
	[139824] = "",
	[139801] = "",
	[139858] = "",
	[139832] = "",
	[139848] = "",
	[139826] = "",
	[139853] = "",
	[139816] = "",
	[139822] = "",
	[139813] = "",
	[139843] = "",
	[139802] = "",
	[138416] = "",
	[139812] = "",
	--manual overrides
	[139879] = "", --Crate of Champion Equipment
--Autogenerated table
	[133701] = "", --Skrog Toenail] = "",
	[133702] = "", --Aromatic Murloc Slime] = "",
	[133703] = "", --Pearlescent Conch] = "",
	[133704] = "", --Rusty Queenfish Brooch] = "",
	[133705] = "", --Rotten Fishbone] = "",
	[133706] = "", --Mossgill Bait] = "",
	[133707] = "", --Nightmare Nightcrawler] = "",
	[133708] = "", --Drowned Thistleleaf] = "",
	[133709] = "", --Funky Sea Snail] = "",
	[133710] = "", --Salmon Lure] = "",
	[133711] = "", --Swollen Murloc Egg] = "",
	[133712] = "", --Frost Worm] = "",
	[133713] = "", --Moosehorn Hook] = "",
	[133714] = "", --Silverscale Minnow] = "",
	[133715] = "", --Ancient Vrykul Ring] = "",
	[133716] = "", --Soggy Drakescale] = "",
	[133717] = "", --Enchanted Lure] = "",
	[133719] = "", --Sleeping Murloc] = "",
	[133720] = "", --Demonic Detritus] = "",
	[133721] = "", --Message in a Beer Bottle] = "",
	[133722] = "", --Axefish Lure] = "",
	[133723] = "", --Stunned] = "", Angry Shark] = "",
	[133724] = "", --Decayed Whale Blubber] = "",
--Autogenerated table
	--+Fishing Rare Fish
	[133725] = "", --Leyshimmer Blenny] = "",
	[133726] = "", --Nar'thalas Hermit] = "",
	[133727] = "", --Ghostly Queenfish] = "",
	[133728] = "", --Terrorfin] = "",
	[133729] = "", --Thorned Flounder] = "",
	[133730] = "", --Ancient Mossgill] = "",
	[133731] = "", --Mountain Puffer] = "",
	[133732] = "", --Coldriver Carp] = "",
	[133733] = "", --Ancient Highmountain Salmon] = "",
	[133734] = "", --Oodelfjisk] = "",
	[133735] = "", --Graybelly Lobster] = "",
	[133736] = "", --Thundering Stormray] = "",
	[133737] = "", --Magic-Eater Frog] = "",
	[133738] = "", --Seerspine Puffer] = "",
	[133739] = "", --Tainted Runescale Koi] = "",
	[133740] = "", --Axefish] = "",
	[133741] = "", --Seabottom Squid] = "",
	[133742] = "", --Ancient Black Barracuda] = "",
	--Artifact Rare Fish
	[139652] = "", --Leyshimmer Blenny] = "",
	[139653] = "", --Nar'thalas Hermit] = "",
	[139654] = "", --Ghostly Queenfish] = "",
	[139655] = "", --Terrorfin] = "",
	[139656] = "", --Thorned Flounder] = "",
	[139657] = "", --Ancient Mossgill] = "",
	[139658] = "", --Mountain Puffer] = "",
	[139659] = "", --Coldriver Carp] = "",
	[139660] = "", --Ancient Highmountain Salmon] = "",
	[139661] = "", --Oodelfjisk] = "",
	[139662] = "", --Graybelly Lobster] = "",
	[139663] = "", --Thundering Stormray] = "",
	[139664] = "", --Magic-Eater Frog] = "",
	[139665] = "", --Seerspine Puffer] = "",
	[139666] = "", --Tainted Runescale Koi] = "",
	[139667] = "", --Axefish] = "",
	[139668] = "", --Seabottom Squid] = "",
	[139669] = "", --Ancient Black Barracuda] = "",
------- Contracts
      [116915] = "",     --Inactive Apexis Guardian"] = "",
      [114245] = "",     --Abu'Gar's Favorite Lure"] = "",
      [114243] = "",     --Abu'Gar's Finest Reel"] = "",
      [114242] = "",     --Abu'Gar's Vitality"] = "",
      [119161] = "",     --Contract: Karg Bloodfury"] = "",
      [119162] = "",     --Contract: Cleric Maluuf"] = "",
      [119165] = "",     --Contract: Professor Felblast"] = "",
      [119166] = "",     --Contract: Cacklebone"] = "",
      [119167] = "",     --Contract: Vindicator Heluun"] = "",
      [119248] = "",     --Contract: Dawnseeker Rukaryx"] = "",
      [119233] = "",     --Contract: Kaz the Shrieker"] = "",
      [119240] = "",     --Contract: Lokra"] = "",
      [119242] = "",     --Contract: Magister Serena"] = "",
      [119243] = "",     --Contract: Magister Krelas"] = "",
      [119244] = "",     --Contract: Hulda Shadowblade"] = "",
      [119245] = "",     --Contract: Dark Ranger Velonara"] = "",
      [119252] = "",     --Contract: Rangari Erdanii"] = "",
      [119253] = "",     --Contract: Spirit of Bony Xuk"] = "",
      [119254] = "",     --Contract: Pitfighter Vaandaam"] = "",
      [119255] = "",     --Contract: Bruto"] = "",
      [119256] = "",     --Contract: Glirin"] = "",
      [119257] = "",     --Contract: Penny Clobberbottom"] = "",
      [119267] = "",     --Contract: Ziri'ak"] = "",
      [119288] = "",     --Contract: Daleera Moonfang"] = "",
      [119291] = "",     --Contract: Artificer Andren"] = "",
      [119292] = "",     --Contract: Vindicator Onaala"] = "",
      [119296] = "",     --Contract: Rangari Chel"] = "",
      [119298] = "",     --Contract: Ranger Kaalya"] = "",
      [119418] = "",     --Contract: Morketh Bladehowl"] = "",
      [119420] = "",     --Contract: Miall"] = "",
      [122135] = "",     --Contract: Greatmother Geyah"] = "",
      [122136] = "",     --Contract: Kal'gor the Honorable"] = "",
      [122137] = "",     --Contract: Bruma Swiftstone"] = "",
      [122138] = "",     --Contract: Ulna Thresher"] = "",
      [112737] = "",     --Contract: Ka'la of the Frostwolves"] = "",
      [112848] = "",     --Contract: Daleera Moonfang"] = "",
      [114825] = "",     --Contract: Ulna Thresher"] = "",
      [114826] = "",     --Contract: Bruma Swiftstone"] = "",
      [119164] = "",     --Contract: Arakkoa Outcasts Follower"] = "",
      [119168] = "",     --Contract: Vol'jin's Spear Follower"] = "",
      [119169] = "",     --Contract: Wrynn's Vanguard Follower"] = "",
      [119821] = "",     --Contract: Dawnseeker Rukaryx"] = "",
      [128439] = "",     --Contract: Pallas"] = "",
      [128440] = "",     --Contract: Dowser Goodwell"] = "",
      [128441] = "",     --Contract: Solar Priest Vayx"] = "",
      [128445] = "",     --Contract: Dowser Bigspark"] = "",
      [114119] = "",     --Crate of Salvage"] = "",
      [114116] = "",     --Bag of Salvaged Goods"] = "",
      [114120] = "",     --Big Crate of Salvage"] = "",
      [114781] = "",     --Timber"] = "",
      [116053] = "",     --Draenic Seeds"] = "",
      [115508] = "",     --Draenic Stone"] = "",
      [113991] = "",     --Iron Trap"] = "",
      [115009] = "",     --Improved IronTrap"] = "",
      [115010] = "",     --Deadly Iron Trap"] = "",
      [119813] = "",     --Furry Caged Beast"] = "",
      [119814] = "",     --Leathery Caged Beast"] = "",
      [119810] = "",     --Meaty Caged Beast"] = "",
      [119819] = "",     --Caged Mighty Clefthoof"] = "",
      [119817] = "",     --Caged Mighty Riverbeast"] = "",
      [119815] = "",     --Caged Mighty Wolf"] = "",
      [117397] = "",     --Nat's Lucky Coin"] = "",
      [128373] = "",     --Rush Order: Shipyard"] = "",
      [122307] = "",     --Rush Order: Barn"] = "",
      [122487] = "",     --Rush Order: Gladiator's Sanctum"] = "",
      [122490] = "",     --Rush Order: Dwarven Bunker"] = "",
      [122491] = "",     --Rush Order: War Mill"] = "",
      [122496] = "",     --Rush Order: Garden Shipment"] = "",
      [122497] = "",     --Rush Order: Garden Shipment"] = "",
      [122500] = "",     --Rush Order: Gnomish Gearworks"] = "",
      [122501] = "",     --Rush Order: Goblin Workshop"] = "",
      [122502] = "",     --Rush Order: Mine Shipment"] = "",
      [122503] = "",     --Rush Order: Mine Shipment"] = "",
      [122576] = "",     --Rush Order: Alchemy Lab"] = "",
      [122590] = "",     --Rush Order: Enchanter's Study"] = "",
      [122591] = "",     --Rush Order: Engineering Works"] = "",
      [122592] = "",     --Rush Order: Gem Boutique"] = "",
      [122593] = "",     --Rush Order: Scribe's Quarters"] = "",
      [122594] = "",     --Rush Order: Tailoring Emporium"] = "",
      [122595] = "",     --Rush Order: The Forge"] = "",
      [122596] = "",     --Rush Order: The Tannery"] = "",  
      [113681] = "",     --Iron Horde Scraps"] = "",
      [113823] = "",     --Crusted Iron Horde Pauldrons"] = "",
      [113822] = "",     --Ravaged Iron Horde Belt"] = "",
      [113821] = "",     --Battered Iron Horde Helmet"] = "",   
      [118897] = "",     --Miner's Coffee"] = "",
      [118903] = "",     --Preserved Mining Pick"] = "",    
      [118215] = "",     --Book of Garrison Blueprints"] = "",
      [111812] = "",     --Garrison Blueprint: Alchemy Lab] = "", Level 1"] = "",
      [111929] = "",     --Garrison Blueprint: Alchemy Lab] = "", Level 2"] = "",
      [111930] = "",     --Garrison Blueprint: Alchemy Lab] = "", Level 3"] = "",
      [111968] = "",     --Garrison Blueprint: Barn] = "", Level 2"] = "",
      [111969] = "",     --Garrison Blueprint: Barn] = "", Level 3"] = "",
      [111956] = "",     --Garrison Blueprint: Barracks] = "", Level 1"] = "",
      [111970] = "",     --Garrison Blueprint: Barracks] = "", Level 2"] = "",
      [111971] = "",     --Garrison Blueprint: Barracks] = "", Level 3"] = "",
      [111966] = "",     --Garrison Blueprint: Dwarven Bunker] = "", Level 2"] = "",
      [111967] = "",     --Garrison Blueprint: Dwarven Bunker] = "", Level 3"] = "",
      [111817] = "",     --Garrison Blueprint: Enchanter's Study] = "", Level 1"] = "",
      [111972] = "",     --Garrison Blueprint: Enchanter's Study] = "", Level 2"] = "",
      [111973] = "",     --Garrison Blueprint: Enchanter's Study] = "", Level 3"] = "",
      [109258] = "",     --Garrison Blueprint: Engineering Works] = "", Level 1"] = "",
      [109256] = "",     --Garrison Blueprint: Engineering Works] = "", Level 2"] = "",
      [109257] = "",     --Garrison Blueprint: Engineering Works] = "", Level 3"] = "",
      [109578] = "",     --Garrison Blueprint: Fishing Shack"] = "",
      [111927] = "",     --Garrison Blueprint: Fishing Shack] = "", Level 2"] = "",
      [111928] = "",     --Garrison Blueprint: Fishing Shack] = "", Level 3"] = "",
      [116248] = "",     --Garrison Blueprint: Frostwall Mines] = "", Level 2"] = "",
      [116249] = "",     --Garrison Blueprint: Frostwall Mines] = "", Level 3"] = "",
      [116431] = "",     --Garrison Blueprint: Frostwall Tavern] = "", Level 2"] = "",
      [116432] = "",     --Garrison Blueprint: Frostwall Tavern] = "", Level 3"] = "",
      [111814] = "",     --Garrison Blueprint: Gem Boutique] = "", Level 1"] = "",
      [111974] = "",     --Garrison Blueprint: Gem Boutique] = "", Level 2"] = "",
      [111975] = "",     --Garrison Blueprint: Gem Boutique] = "", Level 3"] = "",
      [111980] = "",     --Garrison Blueprint: Gladiator's Sanctum] = "", Level 2"] = "",
      [111981] = "",     --Garrison Blueprint: Gladiator's Sanctum] = "", Level 3"] = "",
      [111984] = "",     --Garrison Blueprint: Gnomish Gearworks] = "", Level 2"] = "",
      [111985] = "",     --Garrison Blueprint: Gnomish Gearworks] = "", Level 3"] = "",
      [116200] = "",     --Garrison Blueprint: Goblin Workshop] = "", Level 2"] = "",
      [116201] = "",     --Garrison Blueprint: Goblin Workshop] = "", Level 3"] = "",
      [109577] = "",     --Garrison Blueprint: Herb Garden] = "", Level 2"] = "",
      [111997] = "",     --Garrison Blueprint: Herb Garden] = "", Level 3"] = "",
      [109254] = "",     --Garrison Blueprint: Lumber Mill] = "", Level 2"] = "",
      [109255] = "",     --Garrison Blueprint: Lumber Mill] = "", Level 3"] = "",
      [109576] = "",     --Garrison Blueprint: Lunarfall Excavation] = "", Level 2"] = "",
      [111996] = "",     --Garrison Blueprint: Lunarfall Excavation] = "", Level 3"] = "",
      [107694] = "",     --Garrison Blueprint: Lunarfall Inn] = "", Level 2"] = "",
      [109065] = "",     --Garrison Blueprint: Lunarfall Inn] = "", Level 3"] = "",
      [109062] = "",     --Garrison Blueprint: Mage Tower] = "", Level 2"] = "",
      [109063] = "",     --Garrison Blueprint: Mage Tower] = "", Level 3"] = "",
      [111998] = "",     --Garrison Blueprint: Menagerie] = "", Level 2"] = "",
      [111999] = "",     --Garrison Blueprint: Menagerie] = "", Level 3"] = "",
      [111957] = "",     --Garrison Blueprint: Salvage Yard] = "", Level 1"] = "",
      [111976] = "",     --Garrison Blueprint: Salvage Yard] = "", Level 2"] = "",
      [111977] = "",     --Garrison Blueprint: Salvage Yard] = "", Level 3"] = "",
      [111815] = "",     --Garrison Blueprint: Scribe's Quarters] = "", Level 1"] = "",
      [111978] = "",     --Garrison Blueprint: Scribe's Quarters] = "", Level 2"] = "",
      [111979] = "",     --Garrison Blueprint: Scribe's Quarters] = "", Level 3"] = "",
      [116196] = "",     --Garrison Blueprint: Spirit Lodge] = "", Level 2"] = "",
      [116197] = "",     --Garrison Blueprint: Spirit Lodge] = "", Level 3"] = "",
      [112002] = "",     --Garrison Blueprint: Stables] = "", Level 2"] = "",
      [112003] = "",     --Garrison Blueprint: Stables] = "", Level 3"] = "",
      [111982] = "",     --Garrison Blueprint: Storehouse] = "", Level 2"] = "",
      [111983] = "",     --Garrison Blueprint: Storehouse] = "", Level 3"] = "",
      [111816] = "",     --Garrison Blueprint: Tailoring Emporium] = "", Level 1"] = "",
      [111992] = "",     --Garrison Blueprint: Tailoring Emporium] = "", Level 2"] = "",
      [111993] = "",     --Garrison Blueprint: Tailoring Emporium] = "", Level 3"] = "",
      [111813] = "",     --Garrison Blueprint: The Forge] = "", Level 1"] = "",
      [111990] = "",     --Garrison Blueprint: The Forge] = "", Level 2"] = "",
      [111991] = "",     --Garrison Blueprint: The Forge] = "", Level 3"] = "",
      [111818] = "",     --Garrison Blueprint: The Tannery] = "", Level 1"] = "",
      [111988] = "",     --Garrison Blueprint: The Tannery] = "", Level 2"] = "",
      [111989] = "",     --Garrison Blueprint: The Tannery] = "", Level 3"] = "",
      [111986] = "",     --Garrison Blueprint: Trading Post] = "", Level 2"] = "",
      [111987] = "",     --Garrison Blueprint: Trading Post] = "", Level 3"] = "",
      [116185] = "",     --Garrison Blueprint: War Mill] = "", Level 2"] = "",
      [116186] = "",     --Garrison Blueprint: War Mill] = "", Level 3"] = "",
      [127267] = "",     --Ship Blueprint: Carrier"] = "",
      [127268] = "",     --Ship Blueprint: Transport"] = "",
      [127269] = "",     --Ship Blueprint: Battleship (horde)"] = "",
      [127270] = "",     --Ship Blueprint: Submarine"] = "",
      [127268] = "",     --Ship Blueprint: Transport"] = "",
      [126900] = "",     --Ship Blueprint: Destroyer"] = "",
      [128492] = "",     --Ship Blueprint: Battleship (alliance)"] = "",
 ---Legion
      --随从经验
      [141028] = "",     --知识魔典"] = "",
 ---Legion 
      --神器物品
      [130152] = "",
	[131763] = "",
	[131795] = "",
	[131802] = "",
	[131808] = "",
	[132897] = "",
	[138480] = "",
	[138781] = "",
	[138783] = "",
	[138785] = "",
	[138786] = "",
	[138839] = "",
	[138885] = "",
	[139507] = "",
	[139508] = "",
	[139509] = "",
	[139510] = "",
	[139511] = "",
	[139608] = "",
	[139611] = "",
	[139612] = "",
	[139613] = "",
	[139614] = "",
	[139615] = "",
	[139617] = "",
	[140176] = "",
	[140251] = "",
	[140252] = "",
	[140255] = "",
	[140310] = "",
	[140349] = "",
	[140388] = "",
	[140517] = "",
	[141023] = "",
	[141024] = "",
	[141310] = "",
	[141313] = "",
	[141383] = "",
	[141384] = "",
	[141387] = "",
	[141390] = "",
	[141391] = "",
	[141393] = "",
	[141394] = "",
	[141395] = "",
	[141396] = "",
	[141397] = "",
	[141398] = "",
	[141399] = "",
	[141400] = "",
	[141401] = "",
	[141402] = "",
	[141404] = "",
	[141639] = "",
	[141667] = "",
	[141668] = "",
	[141670] = "",
	[141673] = "",
	[141677] = "",
	[141689] = "",
	[141690] = "",
	[141703] = "",
	[141705] = "",
	[141706] = "",
	[141859] = "",
	[141863] = "",
	[141888] = "",
	[141889] = "",
	[141896] = "",
	[141921] = "",
	[141924] = "",
	[141926] = "",
	[141927] = "",
	[141928] = "",
	[141931] = "",
	[141933] = "",
	[141934] = "",
	[141936] = "",
	[141941] = "",
	[141942] = "",
	[141944] = "",
	[141945] = "",
	[141947] = "",
	[141950] = "",
	[141951] = "",
	[141956] = "",
	[142001] = "",
	[142002] = "",
	[142003] = "",
	[142004] = "",
	[142005] = "",
	[142006] = "",
	[142007] = "",
	[142054] = "",
	--苏拉玛能量
	[140402] = "",
	[140248] = "",
	[139890] = "",
	[140243] = "",
	[140399] = "",
	[140949] = "",
	[140236] = "",
	[139786] = "",
	[140240] = "",
	[140245] = "",
	[140405] = "",
	[137010] = "",
      --随从升级
      [136412] = "",     --重型装甲套装"] = "",
      [137207] = "",     --强韧护甲套装"] = "",
      [137208] = "",     --不灭护甲套装"] = "",
      [139792] = "",     --丰饶饰品"] = "",
      [139801] = "",     --幸运装饰品"] = "",
      [139851] = "",     --瓦拉加尔之力"] = "",
      [139419] = "",    --金香蕉"] = "",
      --密钥
      [138019] = "",     --钥石：黑鸦堡垒"] = "",
    [116395] = "",     --Comprehensive Outpost Construction Guide"] = "",
    [116394] = "",     --Outpost Building Assembly Notes"] = "",
------- Abilities & Traits
      [118354] = "",     --Follower Re-training Certificate"] = "",
      [122272] = "",     --Follower Ability Retraining Manual"] = "",
      [122273] = "",     --Follower Trait Retraining Guide"] = "",
      [123858] = "",     --Follower Retraining Scroll Case"] = "",
      [118475] = "",     --Hearthstone Strategy Guide"] = "",
      [118474] = "",     --Supreme Manual of Dance"] = "",
      [122584] = "",     --Winning with Wildlings"] = "",
      [122583] = "",     --Grease Monkey Guide"] = "",
      [122582] = "",     --Guide to Arakkoa Relations"] = "",
      [122580] = "",     --Ogre Buddy Handbook"] = "",
      ------- Other enhancements
      [120311] = "",     --The Blademaster's Necklace"] = "",
      [122298] = "",     --Bodyguard Miniaturization Device"] = "",
 ---Legion
      --传送卷
      [141013] = "",     --城镇传送卷轴:沙拉尼尔"] = "", 
      [141015] = "",     --城镇传送卷轴:卡德拉尔"] = "",
      [141016] = "",     --城镇传送卷轴:法罗纳尔"] = "",
--Wod
------- Armor
      [120301] = "",     --Armor Enhancement Token"] = "",
      [114745] = "",     --Braced Armor Enhancement"] = "",
      [114808] = "",     --Fortified Armor Enhancement"] = "",
      [114822] = "",     --Heavily Reinforced Armor Enhancement"] = "",
      [114807] = "",     --War Ravaged Armor Set"] = "",
      [114806] = "",     --Blackrock Armor Set"] = "",
      [114746] = "",     --Goredrenched Armor Set"] = "",
      ------- Weapon
      [120302] = "",     --Weapon Enhancement Token"] = "",
      [114128] = "",     --Balanced Weapon Enhancement"] = "",
      [114129] = "",     --Striking Weapon Enhancement"] = "",
      [114131] = "",     --Power Overrun Weapon Enhancement"] = "",
      [114616] = "",     --War Ravaged Weaponry"] = "",
      [114081] = "",     --Blackrock Weaponry"] = "",
      [114622] = "",     --Goredrenched Weaponry"] = "",
      ------- Armor & Weapon 
      [120313] = "",     --Sanketsu"] = "",
      [128314] = "",     --Frozen Arms of a Hero"] = "",
      ------- Blueprints dropped by rare mobs in Tanaan Jungle
      [126950] = "",     --Equipment Blueprint: Bilge Pump"] = "",
      [128258] = "",     --Equipment Blueprint: Felsmoke Launchers"] = "",
      [128232] = "",     --Equipment Blueprint: High Intensity Fog Lights"] = "",
      [128255] = "",     --Equipment Blueprint: Ice Cutter"] = "",
      [128231] = "",     --Equipment Blueprint: Trained Shark Tank"] = "",
      [128252] = "",     --Equipment Blueprint: True Iron Rudder"] = "",
      [128257] = "",     --Equipment Blueprint: Ghostly Spyglass"] = "",
      ------- Other blueprints
      [128256] = "",     --Equipment Blueprint: Gyroscopic Internal Stabilizer"] = "",
      [128250] = "",     --Equipment Blueprint: Unsinkable"] = "",
      [128251] = "",     --Equipment Blueprint: Tuskarr Fishing Net"] = "",
      [128260] = "",     --Equipment Blueprint: Blast Furnace"] = "",
      [128490] = "",     --Blueprint: Oil Rig"] = "",
      [128444] = "",     --Blueprint: Oil Rig"] = "",
      ------- Sea
      [127883] = "",     --真铁船舵  应对：机动规避"] = "",   
      [127880] = "",     --破冰器  应对：冰封水域"] = "",
      [125787] = "",     --舱底水泵  应对：风暴天气"] = "",
      [127662] = "",     --超大功率雾灯  应对：浓雾"] = "",
      [127884] = "",     --邪能烟幕发射器  应对：先发打击"] = "",
      [127881] = "",     --陀螺稳定仪  应对：漩涡乱流"] = "",
      [127882] = "",     --高能炉  应对：紧急任务"] = "",
      [127663] = "",     --鲨鱼水箱  应对：布雷舰"] = "", 
      [127894] = "",     --海象人渔网  可在任务成功后额外提供一批渔获。"] = "", 
      [127886] = "",     --防沉护盾  挽救舰船。触发一次后损毁。"] = "", 
      [127895] = "",     --幽灵望远镜  一支长长的望远镜，但你透过它却什么都看不到，或许会派上用场。"] = "", 
 ---Legion 
      --随从装备
      [140571] = "",     --能量药水"] = "", 
      [140572] = "",     --加速怀表"] = "", 
      [113258] = "",     --5000"] = "", 
};

--## Thanks Adibags
local arrZoneItems = {
-- Tinkering Parts
--local parts = {
	[166846] = "",  --Spare Parts
	[166970] = "",  --Energy Cell
	[166971] = "",  --Empty Energy Cell
	[167562] = "",  --Ionized Minnow
	[168215] = "",  --Machined Gear Assembly
	[168216] = "",  --Tempered Plating
	[168217] = "",  --Hardened Spring
	[168262] = "",  --Sentry Fish
	[168327] = "",  --Chain Ignitercoil
	[168832] = "",  --Galvanic Oscillator
	[168946] = "",  --Bundle of Recyclable Parts
	[169610] = "",  --S.P.A.R.E. Crate
--}
-- Mechagon Boxes
--local boxes = {
	[167744] = "",  --Aspirant's Equipment Cache
	[168264] = "",  --Recycling Requisition
	[168266] = "",  --Strange Recycling Requisition
	[169471] = "",  --Cogfrenzy's Construction Toolkit
	[169838] = "",  --Azeroth Mini: Starter Pack
	[170061] = "",  --Rustbolt Supplies
	[298140] = "",  --Rustbolt Requisitions
--}
-- Item blueprints
--local blueprints = {
	[167042] = "",  --Blueprint: Scrap Trap
	[167652] = "",  --Blueprint: Hundred-Fathom Lure
	[167787] = "",  --Blueprint: Mechanocat Laser Pointer
	[167836] = "",  --Blueprint: Canned Minnows
	[167843] = "",  --Blueprint: Vaultbot Key
	[167844] = "",  --Blueprint: Emergency Repair Kit
	[167845] = "",  --Blueprint: Emergency Powerpack
	[167846] = "",  --Blueprint: Mechano-Treat
	[167847] = "",  --Blueprint: Ultrasafe Transporter: Mechagon
	[167871] = "",  --Blueprint: G99.99 Landshark
	[168062] = "",  --Blueprint: Rustbolt Gramophone
	[168063] = "",  --Blueprint: Rustbolt Kegerator
	[168219] = "",  --Blueprint: Beastbot Powerpack
	[168220] = "",  --Blueprint: Re-Procedurally Generated Punchcard
	[168248] = "",  --Blueprint: BAWLD-371
	[168490] = "",  --Blueprint: Protocol Transference Device
	[168491] = "",  --Blueprint: Personal Time Displacer
	[168492] = "",  --Blueprint: Emergency Rocket Chicken
	[168493] = "",  --Blueprint: Battle Box
	[168494] = "",  --Blueprint: Rustbolt Resistance Insignia
	[168495] = "",  --Blueprint: Rustbolt Requisitions	
	[168906] = "",  --Blueprint: Holographic Digitalization Relay
	[168908] = "",  --Blueprint: Experimental Adventurer Augment
	[169112] = "",  --Blueprint: Advanced Adventurer Augment
	[169134] = "",  --Blueprint: Extraodinary Adventurer Augment
	[169167] = "",  --Blueprint: Orange Spraybot
	[169168] = "",  --Blueprint: Green Spraybot
	[169169] = "",  --Blueprint: Blue Spraybot
	[169170] = "",  --Blueprint: Utility Mechanoclaw
	[169171] = "",  --Blueprint: Microbot XD
	[169172] = "",  --Blueprint: Perfectly Timed Differential
	[169173] = "",  --Blueprint: Anti-Gravity Pack
	[169174] = "",  --Blueprint: Rustbolt Pocket Turret
	[169175] = "",  --Blueprint: Annoy-o-Tron Gang
	[169176] = "",  --Blueprint: Encrypted Black Market Radio
	[169190] = "",  --Blueprint: Mega-Sized Spare Parts
--}
-- Mount Paints
--local paint = {
	[167796] = "",  --Paint Vial: Mechagon Gold
	[167790] = "",  --Paint Vial: Fireball Red
	[167791] = "",  --Paint Vial: Battletorn Blue
	[167792] = "",  --Paint Vial: Fel Mint Green
	[167793] = "",  --Paint Vial: Overload Orange
	[167794] = "",  --Paint Vial: Lemonade Steel
	[167795] = "",  --Paint Vial: Copper Trim
	[168001] = "",  --Paint Vial: Big-ol Bronze
	[170146] = "",  --Paint Bottle: Nukular Red
	[170147] = "",  --Paint Bottle: Goblin Green
	[170148] = "",  --Paint Bottle: Electric Blue
--}
-- Mechagon Minis
--local minis = {
	[169794] = "",  --Azeroth Mini: Izira Gearsworn
	[169795] = "",  --Azeroth Mini: Bondo Bigblock
	[169796] = "",  --Azeroth Mini Collection: Mechagon
	[169797] = "",  --Azeroth Mini: Wrenchbot
	[169840] = "",  --Azeroth Mini: Gazlowe
	[169841] = "",  --Azeroth Mini: Erazmin
	[169842] = "",  --Azeroth Mini: Roadtrogg
	[169843] = "",  --Azeroth Mini: Cork Stuttguard
	[169844] = "",  --Azeroth Mini: Overspark
	[169845] = "",  --Azeroth Mini: HK-8
	[169846] = "",  --Azeroth Mini: King Mechagon
	[169849] = "",  --Azeroth Mini: Naeno Megacrash
	[169851] = "",  --Azeroth Mini: Cogstar
	[169852] = "",  --Azeroth Mini: Blastatron
	[169876] = "",  --Azeroth Mini: Sapphronetta
	[169895] = "",  --Azeroth Mini: Beastbot
	[169896] = "",  --Azeroth Mini: Pascal-K1N6
--}
-- Mechagon Misc = {
	[168497] = "",    --Rustbolt Resistance Insignia
	[169107] = "",    --T.A.R.G.E.T. Device
	[169688] = "",    --Vinyl: Gnomeregan Forever
	[169689] = "",    --Vinyl: Mimiron's Brainstorm
	[169690] = "",    --Vinyl: Battle of Gnomeregan
	[169691] = "",    --Vinyl: Depths of Ulduar
	[169692] = "",    --Vinyl: Triumph of Gnomeregan
--}  
--addon.ZONE_ITEMS = {
  [169478] = "",   --^BfA^Benthic^Benthic Bracers", 
  [169480] = "",   --^BfA^Benthic^Benthic Chestguard", 
  [169481] = "",   --^BfA^Benthic^Benthic Cloak", 
  [169477] = "",   --^BfA^Benthic^Benthic Girdle", 
  [169485] = "",   --^BfA^Benthic^Benthic Guantlets", 
  [169479] = "",   --^BfA^Benthic^Benthic Helm", 
  [169482] = "",   --^BfA^Benthic^Benthic Leggings", 
  [169484] = "",   --^BfA^Benthic^Benthic Spaulders", 
  [169483] = "",   --^BfA^Benthic^Benthic Treads", 
  [169868] = "",   --^Mechagon^^Anti-Gravity Pack", 
  [167062] = "",   --^Mechagon^^Armored Vaultbot Key", 
  [168233] = "",   --^Mechagon^^Bawld-371", 
  [168045] = "",   --^Mechagon^^Beastbot Power Pack", 
  [168327] = "",   --^Mechagon^^Chain Ignitercoil", 
  [166972] = "",   --^Mechagon^^Emergency Powerpack", 
  [166973] = "",   --^Mechagon^^Emergency Repair Kit", 
  [166971] = "",   --^Mechagon^^Empty Energy Cell", 
  [166970] = "",   --^Mechagon^^Energy Cell", 
  [168961] = "",   --^Mechagon^^Exothermic Evaporator Coil", 
  [168832] = "",   --^Mechagon^^Galvanic Oscillator", 
  [168217] = "",   --^Mechagon^^Hardened Spring", 
  [168952] = "",   --^Mechagon^^Hardened Spring", 
  [167649] = "",   --^Mechagon^^Hundred-Fathom Lure", 
  [167562] = "",   --^Mechagon^^Ionized Minnow", 
  [169872] = "",   --^Mechagon^^Irontide Lockbox Key", 
  [169878] = "",   --^Mechagon^^Irradiated Undercoat", 
  [168215] = "",   --^Mechagon^^Machined Gear Assembly", 
  [168950] = "",   --^Mechagon^^Machined Gear Assembly", 
  [169873] = "",   --^Mechagon^^Mechanized Supply Key", 
  [167071] = "",   --^Mechagon^^Mechano-Treat", 
  [169218] = "",   --^Mechagon^^Old Rusty Key", 
  [169675] = "",   --^Mechagon^^Orange Paint Filled Bladder", 
  [169114] = "",   --^Mechagon^^Personal Time Displacer", 
  [169470] = "",   --^Mechagon^^Pressure Relief Valve", 
  [169610] = "",   --^Mechagon^^S.P.A.R.E. Crate", 
  [168262] = "",   --^Mechagon^^Sentry Fish", 
  [166846] = "",   --^Mechagon^^Spare Parts", 
  [168216] = "",   --^Mechagon^^Tempered Plating", 
  [168951] = "",   --^Mechagon^^Tempered Plating", 
  [168213] = "",   --^Mechagon^^Tensile Driveshaft", 
  [167075] = "",   --^Mechagon^^Ultrasafe Transporter: Mechagon", 
  [170186] = "",   --^Nazjatar^^Abyss Pearl", 
  [170079] = "",   --^Nazjatar^Reputation^Abyssal Conch", 
  [170184] = "",   --^Nazjatar^Reputation^Ancient Reefwalker Bark", 
  [167910] = "",   --^Nazjatar^^Bag of Who-Knows-What", 
  [169782] = "",   --^Nazjatar^^Beckoner's Rosetta Stone", 
  [170189] = "",   --^Nazjatar^^Blind Eye", 
  [167012] = "",   --^Nazjatar^^Brinestone Pickaxe", 
  [168081] = "",   --^Nazjatar^^Brinestone Pickaxe", 
  [167059] = "",   --^Nazjatar^^Chum", 
  [167060] = "",   --^Nazjatar^^Chum", 
  [168155] = "",   --^Nazjatar^^Chum", 
  [168159] = "",   --^Nazjatar^^Chum", 
  [167923] = "",   --^Nazjatar^^Clean Murloc Sock", 
  [169783] = "",   --^Nazjatar^^Cultist Pinky Finger", 
  [167905] = "",   --^Nazjatar^^Curious Murloc Horn", 
  [167916] = "",   --^Nazjatar^^Dirty Murloc Sock", 
  [167903] = "",   --^Nazjatar^^Disintegrating Sand Sculpture", 
  [170167] = "",   --^Nazjatar^Reputation^Eel Fillet", 
  [170472] = "",   --^Nazjatar^^Encrusted Coin", 
  [167907] = "",   --^Nazjatar^^Extra-Slimy Snail", 
  [168094] = "",   --^Nazjatar^^Faintly Humming Sea Stones", 
  [170176] = "",   --^Nazjatar^Reputation^Fathom Ray Wing", 
  [167906] = "",   --^Nazjatar^^Flatulent Fish", 
  [166888] = "",   --^Nazjatar^^Germinating Seed", 
  [167786] = "",   --^Nazjatar^^Germinating Seed", 
  [167909] = "",   --^Nazjatar^^Ghost Food", 
  [170171] = "",   --^Nazjatar^Reputation^Giant Crab Leg", 
  [167913] = "",   --^Nazjatar^^Healthy Murloc Lunch", 
  [170100] = "",   --^Nazjatar^^Hungry Herald's Tentacle Taco", 
  [167914] = "",   --^Nazjatar^^Jar of Fish Faces", 
  [167911] = "",   --^Nazjatar^^Just Regular Butter", 
  [170512] = "",   --^Nazjatar^^Lesser Benthic Arcanocrystal", 
  [170547] = "",   --^Nazjatar^^Mardivas's Arcane Cache Key", 
  [168161] = "",   --^Nazjatar^^Molted Shell", 
  [170085] = "",   --^Nazjatar^Reputation^Naga Deployment Orders", 
  [170153] = "",   --^Nazjatar^^Ominous Looking Tome", 
  [169781] = "",   --^Nazjatar^^Overwhelmingly-Alluring Idol", 
  [167902] = "",   --^Nazjatar^^Particularly Dense Rock", 
  [168097] = "",   --^Nazjatar^^Pilfered Armor Crate", 
  [167893] = "",   --^Nazjatar^^Prismatic Crystal", 
  [169780] = "",   --^Nazjatar^^Pulsating Blood Stone", 
  [170180] = "",   --^Nazjatar^^Razorshell", 
  [168261] = "",   --^Nazjatar^^Reinforced Cache Key", 
  [167077] = "",   --^Nazjatar^^Scrying Stone", 
  [167908] = "",   --^Nazjatar^^Sea Giant Foot Dust", 
  [170191] = "",   --^Nazjatar^^Skeletal Hand", 
  [167896] = "",   --^Nazjatar^^Slimy Naga Eyeball", 
  [167904] = "",   --^Nazjatar^^Smelly Pile of Gloop", 
  [169332] = "",   --^Nazjatar^^Strange Mineralized Water", 
  [169334] = "",   --^Nazjatar^^Strange Oceanic Sediment", 
  [169333] = "",   --^Nazjatar^^Strange Volcanic Rock", 
  [167915] = "",   --^Nazjatar^^Sweet Sea Vegetable", 
  [170181] = "",   --^Nazjatar^^Tidal Guard", 
  [167912] = "",   --^Nazjatar^^Unidentified Mass", 
  [170158] = "",   --^Nazjatar^^Unspeakable Pearl Idol", 
  [168053] = "",   --^Nazjatar^^Unusually Wise Hermit Crab", 
  [170161] = "",   --^Nazjatar^Reputation^Unusually Wise Hermit Crab", 
  [169942] = "",   --^Nazjatar^Reputation^Vibrant Sea Blossom", 
  [170162] = "",   --^Nazjatar^^Waterlogged Toolbox", 
  [170502] = "",   --^Nazjatar^^Waterlogged Toolbox", 
  [167832] = "",   --^Mechagon^Zone Specific Food^Canned Minnows", 
  [168232] = "",   --^Nazjatar^Zone Specific Food^Murloco's 'Fish' Tacos", 
  [170183] = "",   --^Nazjatar^Reputation^Reefwalker Bark", 
  [168666] = "",   --^Nazjatar^^Hefty Glimmershell", 
  [174325] = "",   --^Patch8_3^^Fire Bomb", 
  [172072] = "",   --^Patch8_3^^Experimental Vial", 
  [174351] = "",   --^Patch8_3^^K'Bab", 
  [174041] = "",   --^Patch8_3^^Eyeball Jelly", 
  [174348] = "",   --^Patch8_3^^Grilled Gnasher", 
  [174349] = "",   --^Patch8_3^^Ghastly Goulash", 
  [174352] = "",   --^Patch8_3^^Baked Voidfin", 
  [174350] = "",   --^Patch8_3^^Dubious Delight", 
  [174768] = "",   --^Patch8_3^^Cursed Relic", 
  [173937] = "",   --^Patch8_3^^Severed Oculus", 
  [174765] = "",   --^Patch8_3^^Tol'vir Relic", 
  [174761] = "",   --^Patch8_3^^Aqir Relic", 
  [174767] = "",   --^Patch8_3^^Mogu Relic", 
  [174766] = "",   --^Patch8_3^^Mantid Relic", 
  [174756] = "",   --^Patch8_3^^Aqir Relic Fragment", 
  [174858] = "",   --^Patch8_3^^Gersahl Greens", 
  [174758] = "",   --^Patch8_3^^Voidwarped Relic Fragment", 
  [174760] = "",   --^Patch8_3^^Mantid Relic Fragment", 
  [174764] = "",   --^Patch8_3^^Tol'vir Relic Fragment", 
  [168160] = "",   --^Patch8_3^^Jeweled Scarab Figurine", 
  [174020] = "",   --^Patch8_3^^N'lyeth, Sliver of N'Zoth", 
  [174759] = "",   --^Patch8_3^^Mogu Relic Fragment", 
  [174867] = "",   --^Patch8_3^^Shard of Corruption", 
  [174046] = "",   --^Patch8_3^^Orb of Visions", 
  [171334] = "",   --^Patch8_3^^Void-Touched Cloth", 
  [174045] = "",   --^Patch8_3^^Orb of Dark Portents", 
  [171347] = "",   --^Patch8_3^^Corrupted Bone Fragment", 
  [168267] = "",   --^Patch8_3^^Suntouched Figurine", 
  [168271] = "",   --^Patch8_3^^Stolen Ramkahen Banner", 
  [172947] = "",   --^Patch8_3^^Faceless Mask of Dark Imagination", 
  [171212] = "",   --^Patch8_3^^Sanity Restoration Orb", 
  [169294] = "",   --^Patch8_3^^Resilient Soul", 
  [173293] = "",   --^Patch8_3^^Vial of Self Preservation", 
  [172494] = "",   --^Patch8_3^^Baruk Idol", 
  [167788] = "",   --^Patch8_3^^Detoxifying Vial", 
  [173888] = "",   --^Patch8_3^^Shard of Self Sacrifice", 
  [175150] = "",   --^Patch8_3^^Self-Shaping Amber", 
  [167027] = "",   --^Patch8_3^^Portable Clarity Beam"
--}
}
-----------------------------------------------------------------------------------------------------------------------------------------
function Open(player, bag, slot, bagInfo, itemInfo)
    if not itemInfo then return false end
    if not itemInfo.link then return false end
	local ItemID = itemInfo.link:match('item:(%d+)')
	if not ItemID then return false end
	return OpenItems[tonumber(ItemID)];
end
function Garrison(player, bag, slot, bagInfo, itemInfo)
    if not itemInfo then return false end
    if not itemInfo.link then return false end
	local ItemID = itemInfo.link:match('item:(%d+)')
	if not ItemID then return false end
	return GarrisonItems[tonumber(ItemID)];
end
function BFA(player, bag, slot, bagInfo, itemInfo)
    if not itemInfo then return false end
    if not itemInfo.link then return false end
	local ItemID = itemInfo.link:match('item:(%d+)')
	if not ItemID then return false end
	return arrZoneItems[tonumber(ItemID)];
end
local function ShiGuang(...)
	return (Open(...) or Garrison(...) or BFA(...));
end
-----------------------------------------------------------------------------------------------------------------------------------------
Combuctor.Rules:New("ShiGuang", "ShiGuang", "Interface/AddOns/_ShiGuang/Media/2UI", ShiGuang);
Combuctor.Rules:New("ShiGuang/Open", "Open", nil, Open);
Combuctor.Rules:New("ShiGuang/Garrison", "Garrison", nil, Garrison);
Combuctor.Rules:New('ShiGuang/BFA', "BFA", nil, BFA)  --'Interface/Icons/INV_HeartOfAzeroth'