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


 -- Food
local Shadowlands = {
--local FoodIDs = {
[172040] = "", --Butterscotch Marinated Ribs
[172041] = "", --Spinefin Souffle and Fries
[172042] = "", --Surprisingly Palatable Feast
[172043] = "", --Feast of Gluttonous Hedonism
[172044] = "", --Cinnamon Bonefish Stew
[172045] = "", --Tenebrous Crown Roast Aspic
[172046] = "", --Biscuits and Caviar
[172047] = "", --Candied Amberjack Cakes
[172048] = "", --Meaty Apple Dumplings
[172049] = "", --Iridescent Ravioli with Apple Sauce
[172050] = "", --Sweet Silvergill Sausages
[172051] = "", --Steak a la Mode
[172061] = "", --Seraph Tenders
[172062] = "", --Smothered Shank
[172063] = "", --Fried Bonefish
[172068] = "", --Pickled Meat Smoothie
[172069] = "", --Banana Beef Pudding
[184624] = "", --Extra Sugary Fish Feast
[184682] = "", --Extra Lemony Herb Filet
[184690] = "", --Extra Fancy Darkmoon Feast
[186704] = "", --Twilight Tea
[186725] = "", --Bonemeal Bread
[186726] = "", --Porous Rock Candy
[187648] = "", --Empty Kettle of Stone Soup
--}

 -- Rings
--local RingsIDs = {
[169806] = "", --Lucky Ring
[173131] = "", --Versatile Solenium Ring
[173132] = "", --Masterful Phaedrum Ring
[173133] = "", --Quick Oxxein Ring
[173134] = "", --Deadly Sinvyr Ring
[173135] = "", --Versatile Laestrite Band
[173136] = "", --Masterful Laestrite Band
[173137] = "", --Quick Laestrite Band
[173138] = "", --Deadly Laestrite Band
[173344] = "", --Band of Chronicled Deeds
[175244] = "", --Spider-Eye Ring
[175703] = "", --Silverspire Signet
[175704] = "", --Reverberating Silver Band
[175706] = "", --Mind-Torn Band
[175707] = "", --Signet of the Learned
[175710] = "", --Night Courtier's Ring
[175711] = "", --Slumberwood Band
[175712] = "", --Shimmerbough Loop
[175713] = "", --Sprigthistle Loop
[175714] = "", --The Chamberlain's Tarnished Signet
[175715] = "", --Gargon Eye Ring
[175716] = "", --Emberscorched Band
[175717] = "", --Inquisitor's Signet
[175879] = "", --Sinful Aspirant's Ring
[175916] = "", --Sinful Gladiator's Ring
[177145] = "", --Sea Sapphire Band
[177153] = "", --Beaten Copper Loop
[177164] = "", --Sea Sapphire Band
[177167] = "", --Beaten Copper Loop
[177290] = "", --Heart-Lesion Ring of Might
[177291] = "", --Heart-Lesion Band of Might
[177297] = "", --Heart-Lesion Ring of Stoicism
[177298] = "", --Heart-Lesion Band of Stoicism
[177303] = "", --Springrain Ring of Onslaught
[177304] = "", --Springrain Band of Onslaught
[177309] = "", --Springrain Band of Destruction
[177310] = "", --Springrain Ring of Destruction
[177316] = "", --Springrain Band of Wisdom
[177317] = "", --Springrain Ring of Wisdom
[177323] = "", --Springrain Ring of Durability
[177324] = "", --Springrain Band of Durability
[177329] = "", --Trailseeker Band of Onslaught
[177330] = "", --Trailseeker Ring of Onslaught
[177336] = "", --Mountainsage Band of Destruction
[177337] = "", --Mountainsage Ring of Destruction
[177342] = "", --Mistdancer Band of Stoicism
[177343] = "", --Mistdancer Ring of Stoicism
[177350] = "", --Mistdancer Ring of Wisdom
[177351] = "", --Mistdancer Band of Wisdom
[177357] = "", --Mistdancer Band of Onslaught
[177358] = "", --Mistdancer Ring of Onslaught
[177364] = "", --Sunsoul Ring of Wisdom
[177365] = "", --Sunsoul Band of Wisdom
[177373] = "", --Sunsoul Ring of Might
[177374] = "", --Sunsoul Band of Might
[177380] = "", --Sunsoul Ring of Stoicism
[177381] = "", --Sunsoul Band of Stoicism
[177385] = "", --Communal Band of Destruction
[177386] = "", --Communal Ring of Destruction
[177391] = "", --Communal Band of Wisdom
[177392] = "", --Communal Ring of Wisdom
[177399] = "", --Lightdrinker Band of Onslaught
[177400] = "", --Lightdrinker Ring of Onslaught
[177408] = "", --Streamtalker Band of Onslaught
[177409] = "", --Streamtalker Ring of Onslaught
[177413] = "", --Streamtalker Ring of Destruction
[177414] = "", --Streamtalker Band of Destruction
[177422] = "", --Streamtalker Ring of Wisdom
[177423] = "", --Streamtalker Band of Wisdom
[177577] = "", --Illidari Band
[177578] = "", --Illidari Ring
[177585] = "", --Felsoul Band of Destruction
[177586] = "", --Felsoul Ring of Destruction
[177597] = "", --Oathsworn Band of Stoicism
[177598] = "", --Oathsworn Ring of Stoicism
[177600] = "", --Oathsworn Ring of Might
[177601] = "", --Oathsworn Band of Might
[177811] = "", --Depraved Tutor's Signet
[177812] = "", --Redelv House Band
[178077] = "", --Briarbane Signet
[178171] = "", --Darkmaul Signet Ring
[178293] = "", --Sinful Aspirant's Band
[178329] = "", --Sinful Aspirant's Signet
[178381] = "", --Sinful Gladiator's Band
[178442] = "", --Sinful Gladiator's Signet
[178736] = "", --Stitchflesh's Misplaced Signet
[178781] = "", --Ritual Commander's Ring
[178824] = "", --Signet of the False Accuser
[178848] = "", --Entwined Gorger Tendril
[178869] = "", --Fleshfused Circle
[178870] = "", --Ritual Bone Band
[178871] = "", --Bloodoath Signet
[178872] = "", --Ring of Perpetual Conflict
[178926] = "", --Shadowghast Ring
[178933] = "", --Arachnid Cipher Ring
[179355] = "", --Death God's Signet
[180214] = "", --Venthyr Ring
[180349] = "", --Nethrezim Acolyte's Band
[180350] = "", --Simple Stone Loop
[180351] = "", --Worn Ring of Piety
[180352] = "", --Cracked Inquisitor's Band
[180855] = "", --Competitor's Signet
[181217] = "", --Dominance Guard's Band
[181218] = "", --Chalice Noble's Signet
[181626] = "", --Gorewrought Loop
[181702] = "", --Sanctified Guardian's Signet
[181708] = "", --Leafed Banewood Band
[181721] = "", --Ascendent Valor Signet
[183035] = "", --Ardent Sunstar Signet
[183036] = "", --Most Regal Signet of Sire Denathrius
[183037] = "", --Ritualist's Treasured Ring
[183038] = "", --Hyperlight Band
[183149] = "", --Heirloom Ring
[183159] = "", --Heirloom Ring
[183631] = "", --Ring of Carnelian and Sinew
[183659] = "", --Annhylde's Band
[183673] = "", --Nerubian Aegis Ring
[183676] = "", --Hailstone Loop
[183685] = "", --Phantasmic Seal of the Prophet
[184105] = "", --Gyre
[184106] = "", --Gimble
[184142] = "", --Twisted Witherroot Band
[184143] = "", --Band of the Risen Bonelord
[184165] = "", --Seal of Fordragon
[184174] = "", --Clasp of Death
[184744] = "", --Gnarled Boneloop
[184756] = "", --Smoothed Loop of Contemplation
[184783] = "", --Muirnne's Stormforged Signet
[184784] = "", --Punishing Loop
[185156] = "", --Unchained Aspirant's Ring
[185192] = "", --Unchained Gladiator's Ring
[185233] = "", --Unchained Aspirant's Band
[185241] = "", --Unchained Aspirant's Signet
[185273] = "", --Unchained Gladiator's Band
[185281] = "", --Unchained Gladiator's Signet
[185813] = "", --Signet of Collapsing Stars
[185840] = "", --Seal of the Panoply
[185894] = "", --Attendant's Loop
[185895] = "", --Lost Wayfarer's Band
[185903] = "", --Soul-Seeker's Ring
[185941] = "", --Korthian Scholar's Signet
[186145] = "", --Stygian Thorn Loop
[186153] = "", --Foresworn Seal
[186290] = "", --Sworn Oath of the Nine
[186375] = "", --Miniature Breaking Wheel
[186376] = "", --Oscillating Ouroboros
[186377] = "", --Tarnished Insignia of Quel'Thalas
[186450] = "", --Crude Stygian Fastener
[186629] = "", --Sanngor's Spiked Band
[186631] = "", --Emberfused Band
[186784] = "", --Cosmic Gladiator's Ring
[186785] = "", --Cosmic Gladiator's Band
[186786] = "", --Cosmic Gladiator's Signet
[186901] = "", --Cosmic Aspirant's Ring
[186937] = "", --Cosmic Aspirant's Band
[186945] = "", --Cosmic Aspirant's Signet
[187401] = "", --Band of the Shaded Rift
[187402] = "", --All-Consuming Loop
[187406] = "", --Band of Blinding Shadows
[188044] = "", --Discarded Cartel Al Signet
[188045] = "", --Salvaged Viperid Band
[188053] = "", --Abandoned Automa Loop
[188055] = "", --Impossibly Ancient Band
[188112] = "", --Cypher Attunement Ring
[188297] = "", --Signet of Repose
[188343] = "", --Ring of the Shadow Deeps
[188344] = "", --Weathered Band of the Swamplord
[188357] = "", --Ring of Fabled Hope
[188365] = "", --Eye of the Stalker
[188379] = "", --Ring of Umbral Doom
[188382] = "", --Arcane Netherband
[188408] = "", --Signet of Arachnathid Command
[188419] = "", --Ring of the Traitor King
[188446] = "", --Unsmashable Heavy Band
[188451] = "", --Annhylde's Ring
[188472] = "", --Spiteful Signet
[188494] = "", --Signet of Transformation
[188502] = "", --Kibble
[188505] = "", --Skullcracker Ring
[189772] = "", --Modified Defense Grid
[189802] = "", --Loquacious Keeper's Peridot
[189833] = "", --Taciturn Keeper's Lapis
[189839] = "", --Soulwarped Seal of Wrynn
[189841] = "", --Soulwarped Seal of Menethil
[189854] = "", --Rygelon's Heraldric Ring
[190632] = "", --Cypher-Etched Ring
[190633] = "", --Cypher-Etched Band
[190729] = "", --Vigorous Sentinel's Seal
[190730] = "", --Matriarch's Shell Band
[190731] = "", --Deceiver's Illusionary Signet
--}

 -- Trinkets
--local TrinketsIDs = {
[171323] = "", --Spiritual Alchemy Stone
[173069] = "", --Darkmoon Deck: Putrescence
[173078] = "", --Darkmoon Deck: Repose
[173087] = "", --Darkmoon Deck: Voracity
[173096] = "", --Darkmoon Deck: Indomitable
[173349] = "", --Misfiring Centurion Controller
[175718] = "", --Ascended Defender's Crest
[175719] = "", --Agitha's Void-Tinged Speartip
[175722] = "", --Vial of Caustic Liquid
[175723] = "", --Rejuvenating Serum
[175725] = "", --Newcomer's Gladiatorial Badge
[175726] = "", --Primalist's Kelpling
[175727] = "", --Elder's Stormseed
[175728] = "", --Soulsifter Root
[175729] = "", --Rotbriar Sprout
[175730] = "", --Master Duelist's Chit
[175731] = "", --Stolen Maw Badge
[175732] = "", --Tablet of Despair
[175733] = "", --Brimming Ember Shard
[175884] = "", --Sinful Aspirant's Badge of Ferocity
[175921] = "", --Sinful Gladiator's Badge of Ferocity
[175941] = "", --Spiritual Alchemy Stone
[175942] = "", --Spiritual Alchemy Stone
[175943] = "", --Spiritual Alchemy Stone
[177147] = "", --Seabeast Tusk
[177148] = "", --Lucky Braid
[177149] = "", --Shimmering Rune
[177150] = "", --Petrified Basilisk Scale
[177151] = "", --Oceanographer's Weather Log
[177152] = "", --Privateer's Spyglass
[177154] = "", --Seabeast Tusk
[177155] = "", --Shimmering Rune
[177156] = "", --Petrified Basilisk Scale
[177157] = "", --Bijou of the Golden City
[177158] = "", --Enchanted Devilsaur Claw
[177166] = "", --Lucky Braid
[177292] = "", --Heart-Lesion Stone of Battle
[177293] = "", --Heart-Lesion Idol of Battle
[177296] = "", --Heart-Lesion Defender Idol
[177299] = "", --Heart-Lesion Defender Stone
[177302] = "", --Springrain Idol of Rage
[177305] = "", --Springrain Stone of Rage
[177308] = "", --Springrain Idol of Destruction
[177311] = "", --Springrain Stone of Destruction
[177315] = "", --Springrain Idol of Wisdom
[177318] = "", --Springrain Stone of Wisdom
[177322] = "", --Springrain Idol of Durability
[177325] = "", --Springrain Stone of Durability
[177328] = "", --Trailseeker Idol of Rage
[177331] = "", --Trailseeker Stone of Rage
[177335] = "", --Mountainsage Idol of Destruction
[177338] = "", --Mountainsage Stone of Destruction
[177344] = "", --Mistdancer Defender Stone
[177346] = "", --Mistdancer Defender Idol
[177348] = "", --Mistdancer Idol of Wisdom
[177352] = "", --Mistdancer Stone of Wisdom
[177355] = "", --Mistdancer Idol of Rage
[177359] = "", --Mistdancer Stone of Rage
[177363] = "", --Sunsoul Idol of Wisdom
[177366] = "", --Sunsoul Stone of Wisdom
[177375] = "", --Sunsoul Stone of Battle
[177376] = "", --Sunsoul Idol of Battle
[177379] = "", --Sunsoul Defender Idol
[177382] = "", --Sunsoul Defender Stone
[177384] = "", --Communal Idol of Destruction
[177387] = "", --Communal Stone of Destruction
[177390] = "", --Communal Idol of Wisdom
[177393] = "", --Communal Stone of Wisdom
[177398] = "", --Lightdrinker Idol of Rage
[177401] = "", --Lightdrinker Stone of Rage
[177407] = "", --Streamtalker Idol of Rage
[177410] = "", --Streamtalker Stone of Rage
[177412] = "", --Streamtalker Idol of Destruction
[177415] = "", --Streamtalker Stone of Destruction
[177421] = "", --Streamtalker Idol of Wisdom
[177424] = "", --Streamtalker Stone of Wisdom
[177575] = "", --Demon Trophy
[177576] = "", --Charm of Demonic Fire
[177584] = "", --Felsoul Idol of Destruction
[177587] = "", --Felsoul Stone of Destruction
[177596] = "", --Oathsworn Defender Idol
[177599] = "", --Oathsworn Defender Stone
[177602] = "", --Oathsworn Idol of Battle
[177603] = "", --Oathsworn Stone of Battle
[177657] = "", --Overflowing Ember Mirror
[177813] = "", --Hopebreaker's Badge
[178168] = "", --Darkmaul Ritual Stone
[178298] = "", --Sinful Aspirant's Insignia of Alacrity
[178334] = "", --Sinful Aspirant's Emblem
[178386] = "", --Sinful Gladiator's Insignia of Alacrity
[178447] = "", --Sinful Gladiator's Emblem
[178708] = "", --Unbound Changeling
[178715] = "", --Mistcaller Ocarina
[178742] = "", --Bottled Flayedwing Toxin
[178751] = "", --Spare Meat Hook
[178769] = "", --Infinitely Divisible Ooze
[178770] = "", --Slimy Consumptive Organ
[178771] = "", --Phial of Putrefaction
[178772] = "", --Satchel of Misbegotten Minions
[178783] = "", --Siphoning Phylactery Shard
[178808] = "", --Viscera of Coalesced Hatred
[178809] = "", --Soulletting Ruby
[178810] = "", --Vial of Spectral Essence
[178811] = "", --Grim Codex
[178825] = "", --Pulsating Stoneheart
[178826] = "", --Sunblood Amethyst
[178849] = "", --Overflowing Anima Cage
[178850] = "", --Lingering Sunmote
[178861] = "", --Decanter of Anima-Charged Winds
[178862] = "", --Bladedancer's Armor Kit
[179331] = "", --Blood-Spattered Scale
[179342] = "", --Overwhelming Power Crystal
[179350] = "", --Inscrutable Quantum Device
[179356] = "", --Shadowgrasp Totem
[179927] = "", --Glowing Endmire Stinger
[180116] = "", --Overcharged Anima Battery
[180117] = "", --Empyreal Ordnance
[180118] = "", --Anima Field Emitter
[180119] = "", --Boon of the Archon
[180827] = "", --Maldraxxian Warhorn
[181333] = "", --Sinful Gladiator's Medallion
[181334] = "", --Essence Extractor
[181335] = "", --Sinful Gladiator's Relentless Brooch
[181357] = "", --Tablet of Despair
[181358] = "", --Master Duelist's Chit
[181359] = "", --Overflowing Ember Mirror
[181360] = "", --Brimming Ember Shard
[181457] = "", --Wakener's Frond
[181458] = "", --Queensguard's Vigil
[181459] = "", --Withergrove Shardling
[181501] = "", --Flame of Battle
[181502] = "", --Rejuvenating Serum
[181503] = "", --Vial of Caustic Liquid
[181507] = "", --Beating Abomination Core
[181816] = "", --Sinful Gladiator's Sigil of Adaptation
[182451] = "", --Glimmerdust's Grand Design
[182452] = "", --Everchill Brambles
[182453] = "", --Twilight Bloom
[182454] = "", --Murmurs in the Dark
[182455] = "", --Dreamer's Mending
[182682] = "", --Book-Borrower Identification
[183150] = "", --Heirloom Trinket
[183160] = "", --Heirloom Trinket
[183650] = "", --Miniscule Abomination in a Jar
[183849] = "", --Soulsifter Root
[183850] = "", --Wakener's Frond
[183851] = "", --Withergrove Shardling
[184016] = "", --Skulker's Wing
[184017] = "", --Bargast's Leash
[184018] = "", --Splintered Heart of Al'ar
[184019] = "", --Soul Igniter
[184020] = "", --Tuft of Smoldering Plumage
[184021] = "", --Glyph of Assimilation
[184022] = "", --Consumptive Infusion
[184023] = "", --Gluttonous Spike
[184024] = "", --Macabre Sheet Music
[184025] = "", --Memory of Past Sins
[184026] = "", --Hateful Chain
[184027] = "", --Stone Legion Heraldry
[184028] = "", --Cabalist's Hymnal
[184029] = "", --Manabound Mirror
[184030] = "", --Dreadfire Vessel
[184031] = "", --Sanguine Vintage
[184052] = "", --Sinful Aspirant's Medallion
[184053] = "", --Sinful Aspirant's Relentless Brooch
[184054] = "", --Sinful Aspirant's Sigil of Adaptation
[184055] = "", --Corrupted Gladiator's Medallion
[184056] = "", --Corrupted Gladiator's Relentless Brooch
[184057] = "", --Corrupted Gladiator's Sigil of Adaptation
[184058] = "", --Corrupted Aspirant's Medallion
[184059] = "", --Corrupted Aspirant's Relentless Brooch
[184060] = "", --Corrupted Aspirant's Sigil of Adaptation
[184268] = "", --Gladiator's Emblem
[184269] = "", --Gladiator's Medallion
[184279] = "", --Siphoning Blood-Drinker
[184807] = "", --Relic of the First Ones
[184839] = "", --Misfiring Centurion Controller
[184840] = "", --Hymnal of the Path
[184841] = "", --Lyre of Sacred Purpose
[184842] = "", --Instructor's Divine Bell
[184873] = "", --Soul Igniter (Test)
[185161] = "", --Unchained Aspirant's Badge of Ferocity
[185197] = "", --Unchained Gladiator's Badge of Ferocity
[185238] = "", --Unchained Aspirant's Insignia of Alacrity
[185242] = "", --Unchained Aspirant's Emblem
[185278] = "", --Unchained Gladiator's Insignia of Alacrity
[185282] = "", --Unchained Gladiator's Emblem
[185304] = "", --Unchained Gladiator's Medallion
[185305] = "", --Unchained Gladiator's Relentless Brooch
[185306] = "", --Unchained Gladiator's Sigil of Adaptation
[185309] = "", --Unchained Aspirant's Medallion
[185310] = "", --Unchained Aspirant's Relentless Brooch
[185311] = "", --Unchained Aspirant's Sigil of Adaptation
[185818] = "", --So'leah's Secret Technique
[185836] = "", --Codex of the First Technique
[185844] = "", --Ticking Sack of Terror
[185845] = "", --First Class Healing Distributor
[185846] = "", --Miniscule Mailemental in an Envelope
[185902] = "", --Iron Maiden's Toolkit
[186155] = "", --Harmonic Crowd Breaker
[186156] = "", --Tome of Insight
[186421] = "", --Forbidden Necromantic Tome
[186422] = "", --Tome of Monstrous Constructions
[186423] = "", --Titanic Ocular Gland
[186424] = "", --Shard of Annhylde's Aegis
[186425] = "", --Scrawled Word of Recall
[186427] = "", --Whispering Shard of Power
[186428] = "", --Shadowed Orb of Torment
[186429] = "", --Decanter of Endless Howling
[186430] = "", --Tormented Rack Fragment
[186431] = "", --Ebonsoul Vise
[186432] = "", --Salvaged Fusion Amplifier
[186433] = "", --Reactive Defense Matrix
[186434] = "", --Weave of Warped Fates
[186435] = "", --Carved Ivory Keepsake
[186436] = "", --Resonant Silver Bell
[186437] = "", --Relic of the Frozen Wastes
[186438] = "", --Old Warrior's Soul
[186866] = "", --Cosmic Gladiator's Badge of Ferocity
[186867] = "", --Cosmic Gladiator's Insignia of Alacrity
[186868] = "", --Cosmic Gladiator's Emblem
[186869] = "", --Cosmic Gladiator's Medallion
[186870] = "", --Cosmic Gladiator's Relentless Brooch
[186871] = "", --Cosmic Gladiator's Sigil of Adaptation
[186906] = "", --Cosmic Aspirant's Badge of Ferocity
[186942] = "", --Cosmic Aspirant's Insignia of Alacrity
[186946] = "", --Cosmic Aspirant's Emblem
[186966] = "", --Cosmic Aspirant's Medallion
[186967] = "", --Cosmic Aspirant's Relentless Brooch
[186968] = "", --Cosmic Aspirant's Sigil of Adaptation
[186976] = "", --Fine Razorwing Quill
[186980] = "", --Unchained Gladiator's Shackles
[187447] = "", --Soul Cage Fragment
[188252] = "", --Chains of Domination
[188253] = "", --Scars of Fraternal Strife
[188254] = "", --Grim Eclipse
[188255] = "", --Heart of the Swarm
[188261] = "", --Intrusive Thoughtcage
[188262] = "", --The Lion's Roar
[188263] = "", --Reclaimer's Intensity Core
[188264] = "", --Earthbreaker's Impact
[188265] = "", --Cache of Acquired Treasures
[188266] = "", --Pulsating Riftshard
[188267] = "", --Bells of the Endless Feast
[188268] = "", --Architect's Ingenuity Core
[188269] = "", --Pocket Protoforge
[188270] = "", --Elegy of the Eternals
[188271] = "", --The First Sigil
[188272] = "", --Resonant Reservoir
[188273] = "", --Auxillary Attendant Chime
[188282] = "", --Auslese's Light Channeler
[188309] = "", --Icon of Unyielding Courage
[188352] = "", --Argussian Compass
[188359] = "", --Alembic of Infernal Power
[188396] = "", --Bangle of Endless Blessings
[188415] = "", --Essence of Gossamer
[188478] = "", --Needle-Encrusted Scorpion
[188490] = "", --Grace of the Herald
[188514] = "", --Witching Hourglass
[188524] = "", --Cosmic Gladiator's Fastidious Resolve
[188691] = "", --Cosmic Gladiator's Echoing Resolve
[188766] = "", --Cosmic Gladiator's Resonator
[188775] = "", --Cosmic Gladiator's Eternal Aegis
[188778] = "", --Cosmic Gladiator's Devouring Malediction
[190374] = "", --Gemstone of Prismatic Brilliance
[190389] = "", --Broker's Lucky Coin
[190390] = "", --Protector's Diffusion Implement
[190582] = "", --Symbol of the Vombata
[190597] = "", --Symbol of the Lupine
[190602] = "", --Symbol of the Raptora
[190641] = "", --Instructor's Divine Bell
[190652] = "", --Ticking Sack of Terror
[190726] = "", --Extract of Prodigious Sands
[190958] = "", --So'leah's Secret Technique
--}


 -- Abominable Stitching
--local AbominableStitchingIDs = {
[178061] = "", --Malleable Flesh
[178594] = "", --Anima-bound Wraps
[181371] = "", --Spare Head
[181797] = "", --Strange Cloth
[181798] = "", --Stuffed Construct
[181799] = "", --Extra Large Hat
[183475] = "", --Indomitable Hide
[183519] = "", --Necromantic Oil
[183743] = "", --Malleable Flesh
[183744] = "", --Superior Parts
[183752] = "", --Empty Nightcap Cask
[183754] = "", --Stitchflesh's Design Notes
[183755] = "", --Ardenweald Wreath
[183756] = "", --Floating Circlet
[183759] = "", --Unusually Large Cranium
[183760] = "", --Venthyr Spectacles
[183786] = "", --Happiness Bird
[183789] = "", --Six-League Pack
[183824] = "", --Cache of Spare Weapons
[183825] = "", --Oversized Monocle
[183826] = "", --Big Floppy Hat
[183827] = "", --Blacksteel Backplate
[183828] = "", --Friendly Bugs
[183829] = "", --Slime Cat
[183830] = "", --Do It Yourself Flag Kit
[183831] = "", --Safe Fall Kit
[183833] = "", --Kash's Bag of Junk
[183873] = "", --Otherworldy Tea Set
[184036] = "", --Dundae's Hat
[184037] = "", --Maldraxxus Candles
[184038] = "", --Trained Corpselice
[184039] = "", --Clean White Hat
[184040] = "", --Broken Egg Shells
[184041] = "", --Festive Umbrella
[184203] = "", --Fungal Hair Tonic
[184204] = "", --Otherworld Hat
[184205] = "", --Long Lost Crown
[184224] = "", --Dapperling Seeds
[184225] = "", --Small Posable Skeleton
[184304] = "", --Anima-Touched Weapon Fragments
--}

 -- Anima
--local AnimaIDs = {
[181368] = "", --Centurion Power Core
[181377] = "", --Illustrated Combat Meditation Aid
[181477] = "", --Ardendew Pearl
[181478] = "", --Cornucopia of the Winter Court
[181479] = "", --Starlight Catcher
[181540] = "", --Animaflower Bud
[181541] = "", --Celestial Acorn
[181544] = "", --Confessions of Misdeed
[181545] = "", --Bloodbound Globule
[181546] = "", --Mature Cryptbloom
[181547] = "", --Noble's Draught
[181548] = "", --Darkhaven Soul Lantern
[181549] = "", --Timeworn Sinstone
[181550] = "", --Hopebreaker's Field Injector
[181551] = "", --Depleted Stoneborn Heart
[181552] = "", --Collected Tithe
[181642] = "", --Novice Principles of Plaguistry
[181643] = "", --Weeping Corpseshroom
[181644] = "", --Unlabled Culture Jars
[181645] = "", --Engorged Monstrosity's Heart
[181646] = "", --Bound Failsafe Phylactery
[181647] = "", --Stabilized Plague Strain
[181648] = "", --Ziggurat Focusing Crystal
[181649] = "", --Preserved Preternatural Braincase
[181650] = "", --Spellwarded Dissertation
[18743] = "", --Plume of the Archon
[181744] = "", --Forgelite Ember
[181745] = "", --Forgesmith's Coal
[183723] = "", --Brimming Anima Orb
[183727] = "", --Resonance of Conflict
[184146] = "", --Singed Soul Shackles
[184147] = "", --Agony Enrichment Device
[184148] = "", --Concealed Sinvyr Flask
[184149] = "", --Widowbloom-Infused Fragrance
[184150] = "", --Bonded Tallow Candles
[184151] = "", --Counterfeit Ruby Brooch
[184152] = "", --Bottle of Diluted Anima-Wine
[184286] = "", --Extinguished Soul Anima
[184293] = "", --Sanctified Skylight Leaf
[184294] = "", --Ethereal Ambrosia
[184305] = "", --Maldraxxi Champion's Armaments
[184306] = "", --Soulcatching Sludge
[184307] = "", --Maldraxxi Armor Scraps
[184315] = "", --Multi-Modal Anima Container
[184360] = "", --Musings on Repetition
[184362] = "", --Reflections on Purity
[184363] = "", --Considerations on Courage
[184371] = "", --Vivacity of Collaboration
[184373] = "", --Small Anima Globe
[184374] = "", --Cartel Exchange Vessel
[184378] = "", --Faeweald Amber
[184379] = "", --Queen's Frozen Tear
[184380] = "", --Starblossom Nectar
[184381] = "", --Astral Sapwood
[184382] = "", --Luminous Sylberry
[184383] = "", --Duskfall Tuber
[184384] = "", --Hibernal Sproutling
[184385] = "", --Fossilized Heartwood
[184386] = "", --Nascent Sporepod
[184387] = "", --Misty Shimmerleaf
[184388] = "", --Plump Glitterroot
[184389] = "", --Slumbering Starseed
[184519] = "", --Totem of Stolen Mojo
[184763] = "", --Mnemis Neural Network
[184764] = "", --Colossus Actuator
[184765] = "", --Vesper Strikehammer
[184766] = "", --Chronicles of the Paragons
[184767] = "", --Handheld Soul Mirror
[184768] = "", --Censer of Dried Gracepetals
[184769] = "", --Pressed Torchlily Blossom
[184770] = "", --Roster of the Forgotten
[184771] = "", --Remembrance Parchment Ash
[184772] = "", --Ritual Maldracite Crystal
[184773] = "", --Battle-Tested Armor Component
[184774] = "", --Juvenile Sporespindle
[184775] = "", --Necromancy for the Practical Ritualist
[184776] = "", --Urn of Arena Soil
[184777] = "", --Gravedredger's Shovel
[186200] = "", --Infused Dendrite
[186201] = "", --Ancient Anima Vessel
[186202] = "", --Wafting Koricone
[186203] = "", --Glowing Devourer Stomach
[186204] = "", --Anima-Stained Glass Shards
[186205] = "", --Scholarly Attendant's Bangle
[186206] = "", --Vault Emberstone
[186519] = "", --Compressed Anima Bubble
[187175] = "", --Runekeeper's Ingot
[187347] = "", --Concentrated Anima
[187349] = "", --Anima Laden Egg
[187432] = "", --Magifocus Heartwood
[187433] = "", --Windcrystal Chimes
[187434] = "", --Lightseed Sapling
[187517] = "", --Animaswell Prism
[189544] = "", --Anima Webbing
[189864] = "", --Anima Gossamer
[189865] = "", --Anima Matrix
--}

 -- Ascended Crafting
--local AscendedCraftingIDs = {
[178995] = "", --Soul Mirror Shard
[179008] = "", --Depleted Goliath Core
[179009] = "", --Tampered Anima Charger
[179378] = "", --Soul Mirror
[180477] = "", --Elysian Feathers
[180478] = "", --Champion's Pelt
[180594] = "", --Calloused Bone
[180595] = "", --Nightforged Steel
--}

 -- Cataloged Research
--local CatalogedResearchIDs = {
[186685] = "", --Relic Fragment
[187311] = "", --Azgoth's Tattered Maps
[187322] = "", --Crumbling Stone Tablet
[187323] = "", --Runic Diagram
[187324] = "", --Gnawed Ancient Idol
[187325] = "", --Faded Razorwing Anatomy Illustration
[187326] = "", --Half-Completed Runeforge Pattern
[187327] = "", --Encrypted Korthian Journal
[187328] = "", --Ripped Cosmology Chart
[187329] = "", --Old God Specimen Jar
[187330] = "", --Naaru Shard Fragment
[187331] = "", --Tattered Fae Designs
[187332] = "", --Recovered Page of Voices
[187333] = "", --Core of an Unknown Titan
[187334] = "", --Shattered Void Tablet
[187335] = "", --Maldraxxus Larva Shell
[187336] = "", --Forbidden Weapon Schematics
[187350] = "", --Displaced Relic
[187457] = "", --Engraved Glass Pane
[187458] = "", --Unearthed Teleporter Sigil
[187459] = "", --Vial of Mysterious Liquid
[187460] = "", --Strangely Intricate Key
[187462] = "", --Scroll of Shadowlands Fables
[187463] = "", --Enigmatic Map Fragments
[187465] = "", --Complicated Organism Harmonizer
[187466] = "", --Korthian Cypher Book
[187467] = "", --Perplexing Rune-Cube
[187478] = "", --White Razorwing Talon
--}

 -- Class Set Tokens
--local ClassSetTokensIDs = {
[191002] = "", --Mystic Helm Module
[191003] = "", --Venerated Helm Module
[191004] = "", --Zenith Helm Module
[191005] = "", --Dreadful Helm Module
[191006] = "", --Dreadful Shoulder Module
[191007] = "", --Mystic Shoulder Module
[191008] = "", --Venerated Shoulder Module
[191009] = "", --Zenith Shoulder Module
[191010] = "", --Dreadful Chest Module
[191011] = "", --Mystic Chest Module
[191012] = "", --Venerated Chest Module
[191013] = "", --Zenith Chest Module
[191014] = "", --Dreadful Hand Module
[191015] = "", --Mystic Hand Module
[191016] = "", --Venerated Hand Module
[191017] = "", --Zenith Hand Module
[191018] = "", --Dreadful Leg Module
[191019] = "", --Mystic Leg Module
[191020] = "", --Venerated Leg Module
[191021] = "", --Zenith Leg Module
--}

 -- Companion EXP
--local CompanionEXPIDs = {
[184684] = "", --Grimoire of Knowledge
[184685] = "", --Grimoire of Knowledge
[184686] = "", --Grimoire of Knowledge
[184687] = "", --Grimoire of Knowledge
[184688] = "", --Grimoire of Knowledge
[186472] = "", --Wisps of Memory
[187413] = "", --Crystalline Memory Repository
[187414] = "", --Fractal Thoughtbinder
[187415] = "", --Mind-Expanding Prism
[188650] = "", --Grimoire of Knowledge
[188651] = "", --Grimoire of Knowledge
[188652] = "", --Grimoire of Knowledge
[188653] = "", --Grimoire of Knowledge
[188654] = "", --Grimoire of Knowledge
[188655] = "", --Crystalline Memory Repository
[188656] = "", --Fractal Thoughtbinder
[188657] = "", --Mind-Expanding Prism
--}

 -- Conduits
--local ConduitsIDs = {
[180842] = "", --Stalwart Guardian
[180843] = "", --Template Conduit
[180844] = "", --Brutal Vitality
[180847] = "", --Inspiring Presence
[180896] = "", --Safeguard
[180932] = "", --Fueled by Violence
[180933] = "", --Ashen Juggernaut
[180935] = "", --Crash the Ramparts
[180943] = "", --Cacophonous Roar
[180944] = "", --Merciless Bonegrinder
[181373] = "", --Harm Denial
[181376] = "", --Inner Fury
[181383] = "", --Unrelenting Cold
[181389] = "", --Shivering Core
[181435] = "", --Calculated Strikes
[181455] = "", --Icy Propulsion
[181461] = "", --Ice Bite
[181462] = "", --Coordinated Offensive
[181464] = "", --Winter's Protection
[181465] = "", --Xuen's Bond
[181466] = "", --Grounding Breath
[181467] = "", --Flow of Time
[181469] = "", --Indelible Victory
[181495] = "", --Jade Bond
[181498] = "", --Grounding Surge
[181504] = "", --Infernal Cascade
[181505] = "", --Resplendent Mist
[181506] = "", --Master Flame
[181508] = "", --Fortifying Ingredients
[181509] = "", --Arcane Prodigy
[181510] = "", --Lingering Numbness
[181511] = "", --Nether Precision
[181512] = "", --Dizzying Tumble
[181539] = "", --Discipline of the Grove
[181553] = "", --Gift of the Lich
[181600] = "", --Ire of the Ascended
[181624] = "", --Swift Transference
[181639] = "", --Siphoned Malice
[181640] = "", --Tumbling Technique
[181641] = "", --Rising Sun Revival
[181698] = "", --Cryo-Freeze
[181700] = "", --Scalding Brew
[181705] = "", --Celestial Effervescence
[181707] = "", --Diverted Energy
[181709] = "", --Unnerving Focus
[181712] = "", --Depths of Insanity
[181734] = "", --Magi's Brand
[181735] = "", --Hack and Slash
[181736] = "", --Flame Accretion
[181737] = "", --Nourishing Chi
[181738] = "", --Artifice of the Archmage
[181740] = "", --Evasive Stride
[181742] = "", --Walk with the Ox
[181756] = "", --Incantation of Swiftness
[181759] = "", --Strike with Clarity
[181769] = "", --Tempest Barrier
[181770] = "", --Bone Marrow Hops
[181774] = "", --Imbued Reflections
[181775] = "", --Way of the Fae
[181776] = "", --Vicious Contempt
[181786] = "", --Eternal Hunger
[181826] = "", --Translucent Image
[181827] = "", --Move with Grace
[181834] = "", --Chilled Resilience
[181836] = "", --Spirit Drain
[181837] = "", --Clear Mind
[181838] = "", --Charitable Soul
[181840] = "", --Light's Inspiration
[181841] = "", --Reinforced Shell
[181842] = "", --Power Unto Others
[181843] = "", --Shining Radiance
[181844] = "", --Pain Transformation
[181845] = "", --Exaltation
[181847] = "", --Lasting Spirit
[181848] = "", --Accelerated Cold
[181866] = "", --Withering Plague
[181867] = "", --Swift Penitence
[181942] = "", --Focused Mending
[181943] = "", --Eradicating Blow
[181944] = "", --Resonant Words
[181962] = "", --Mental Recovery
[181963] = "", --Blood Bond
[181974] = "", --Courageous Ascension
[181975] = "", --Hardened Bones
[181980] = "", --Embrace Death
[181981] = "", --Festering Transfusion
[181982] = "", --Everfrost
[182105] = "", --Astral Protection
[182106] = "", --Refreshing Waters
[182107] = "", --Vital Accretion
[182108] = "", --Thunderous Paws
[182109] = "", --Totemic Surge
[182110] = "", --Crippling Hex
[182111] = "", --Spiritual Resonance
[182113] = "", --Fleeting Wind
[182125] = "", --Pyroclastic Shock
[182126] = "", --High Voltage
[182127] = "", --Shake the Foundations
[182128] = "", --Call of Flame
[182129] = "", --Fae Fermata
[182130] = "", --Shattered Perceptions
[182131] = "", --Haunting Apparitions
[182132] = "", --Unending Grip
[182133] = "", --Insatiable Appetite
[182134] = "", --Unruly Winds
[182135] = "", --Focused Lightning
[182136] = "", --Chilled to the Core
[182137] = "", --Magma Fist
[182138] = "", --Mind Devourer
[182139] = "", --Rabid Shadows
[182140] = "", --Dissonant Echoes
[182141] = "", --Holy Oration
[182142] = "", --Embrace of Earth
[182143] = "", --Swirling Currents
[182144] = "", --Nature's Reach
[182145] = "", --Heavy Rainfall
[182187] = "", --Meat Shield
[182201] = "", --Unleashed Frenzy
[182203] = "", --Debilitating Malady
[182206] = "", --Convocation of the Dead
[182208] = "", --Lingering Plague
[182288] = "", --Impenetrable Gloom
[182292] = "", --Brutal Grasp
[182295] = "", --Proliferation
[182304] = "", --Divine Call
[182307] = "", --Shielding Words
[182316] = "", --Fel Defender
[182317] = "", --Shattered Restoration
[182318] = "", --Viscous Ink
[182321] = "", --Enfeebled Mark
[182324] = "", --Felfire Haste
[182325] = "", --Ravenous Consumption
[182330] = "", --Demonic Parole
[182331] = "", --Empowered Release
[182335] = "", --Spirit Attunement
[182336] = "", --Golden Path
[182338] = "", --Pure Concentration
[182339] = "", --Necrotic Barrage
[182340] = "", --Fel Celerity
[182344] = "", --Lost in Darkness
[182345] = "", --Elysian Dirge
[182346] = "", --Tumbling Waves
[182347] = "", --Essential Extraction
[182348] = "", --Lavish Harvest
[182368] = "", --Relentless Onslaught
[182383] = "", --Dancing with Fate
[182384] = "", --Serrated Glaive
[182385] = "", --Growing Inferno
[182440] = "", --Piercing Verdict
[182441] = "", --Markman's Advantage
[182442] = "", --Veteran's Repute
[182448] = "", --Light's Barding
[182449] = "", --Resolute Barrier
[182456] = "", --Wrench Evil
[182460] = "", --Accrued Vitality
[182461] = "", --Echoing Blessings
[182462] = "", --Expurgation
[182463] = "", --Harrowing Punishment
[182464] = "", --Harmony of the Tortollan
[182465] = "", --Truth's Wake
[182466] = "", --Shade of Terror
[182468] = "", --Mortal Combo
[182469] = "", --Rejuvenating Wind
[182470] = "", --Demonic Momentum
[182471] = "", --Soul Furnace
[182476] = "", --Resilience of the Hunter
[182478] = "", --Corrupting Leer
[182480] = "", --Reversal of Fortune
[182559] = "", --Templar's Vindication
[182582] = "", --Enkindled Spirit
[182584] = "", --Cheetah's Vigor
[182598] = "", --Demon Muzzle
[182604] = "", --Roaring Fire
[182605] = "", --Tactical Retreat
[182608] = "", --Virtuous Command
[182610] = "", --Ferocious Appetite
[182621] = "", --One With the Beast
[182622] = "", --Resplendent Light
[182624] = "", --Show of Force
[182646] = "", --Repeat Decree
[182648] = "", --Sharpshooter's Focus
[182649] = "", --Brutal Projectiles
[182651] = "", --Destructive Reverberations
[182656] = "", --Disturb the Peace
[182657] = "", --Deadly Chain
[182667] = "", --Focused Light
[182675] = "", --Untempered Dedication
[182677] = "", --Punish the Guilty
[182681] = "", --Vengeful Shock
[182684] = "", --Resolute Defender
[182685] = "", --Increased Scrutiny
[182686] = "", --Powerful Precision
[182706] = "", --Brooding Pool
[182736] = "", --Rolling Agony
[182743] = "", --Focused Malignancy
[182747] = "", --Cold Embrace
[182748] = "", --Borne of Blood
[182750] = "", --Carnivorous Stalkers
[182751] = "", --Tyrant's Soul
[182752] = "", --Fel Commando
[182753] = "", --Royal Decree
[182754] = "", --Duplicitous Havoc
[182755] = "", --Ashen Remains
[182767] = "", --The Long Summer
[182769] = "", --Combusting Engine
[182770] = "", --Righteous Might
[182772] = "", --Infernal Brand
[182777] = "", --Hallowed Discernment
[182778] = "", --Ringing Clarity
[182960] = "", --Soul Tithe
[182961] = "", --Fatal Decimation
[182962] = "", --Catastrophic Origin
[182964] = "", --Soul Eater
[183044] = "", --Kilrogg's Cunning
[183076] = "", --Diabolic Bloodstone
[183132] = "", --Echoing Call
[183167] = "", --Strength of the Pack
[183184] = "", --Stinging Strike
[183197] = "", --Controlled Destruction
[183199] = "", --Withering Ground
[183202] = "", --Deadly Tandem
[183396] = "", --Flame Infusion
[183402] = "", --Bloodletting
[183463] = "", --Unnatural Malice
[183464] = "", --Tough as Bark
[183465] = "", --Ursine Vigor
[183466] = "", --Innate Resolve
[183467] = "", --Tireless Pursuit
[183468] = "", --Born Anew
[183469] = "", --Front of the Pack
[183470] = "", --Born of the Wilds
[183471] = "", --Deep Allegiance
[183472] = "", --Evolved Swarm
[183473] = "", --Conflux of Elements
[183474] = "", --Endless Thirst
[183476] = "", --Stellar Inspiration
[183477] = "", --Precise Alignment
[183478] = "", --Fury of the Skies
[183479] = "", --Umbral Intensity
[183480] = "", --Taste for Blood
[183481] = "", --Incessant Hunter
[183482] = "", --Sudden Ambush
[183483] = "", --Carnivorous Instinct
[183484] = "", --Unchecked Aggression
[183485] = "", --Savage Combatant
[183486] = "", --Well-Honed Instincts
[183487] = "", --Layered Mane
[183488] = "", --Unstoppable Growth
[183489] = "", --Flash of Clarity
[183490] = "", --Floral Recycling
[183491] = "", --Ready for Anything
[183492] = "", --Reverberation
[183493] = "", --Sudden Fractures
[183494] = "", --Septic Shock
[183495] = "", --Lashing Scars
[183496] = "", --Nimble Fingers
[183497] = "", --Recuperator
[183498] = "", --Cloaked in Shadows
[183499] = "", --Quick Decisions
[183500] = "", --Fade to Nothing
[183501] = "", --Rushed Setup
[183502] = "", --Prepared for All
[183503] = "", --Poisoned Katar
[183504] = "", --Well-Placed Steel
[183505] = "", --Maim, Mangle
[183506] = "", --Lethal Poisons
[183507] = "", --Triple Threat
[183508] = "", --Ambidexterity
[183509] = "", --Sleight of Hand
[183510] = "", --Count the Odds
[183511] = "", --Deeper Daggers
[183512] = "", --Planned Execution
[183513] = "", --Stiletto Staccato
[183514] = "", --Perforated Veins
[184359] = "", --Unbound Reality Fragment
[184587] = "", --Ambuscade
[187148] = "", --Death-Bound Shard
[187216] = "", --Soultwining Crescent
[187506] = "", --Condensed Anima Sphere
[187507] = "", --Adaptive Armor Fragment
--}

 -- Ember Court
--local EmberCourtIDs = {
[176058] = "", --RSVP: Baroness Vashj
[176081] = "", --Temel's Party Planning Book
[176090] = "", --RSVP: Lady Moonberry
[176091] = "", --RSVP: The Countess
[176092] = "", --RSVP: Mikanikos
[176093] = "", --RSVP: Alexandros Mograine
[176094] = "", --RSVP: Honor 6
[176097] = "", --RSVP: Baroness Vashj
[176112] = "", --RSVP: Lady Moonberry
[176113] = "", --RSVP: Mikanikos
[176114] = "", --RSVP: The Countess
[176115] = "", --RSVP: Alexandros Mograine
[176116] = "", --RSVP: Hunt-Captain Korayn
[176117] = "", --RSVP: Polemarch Adrestes
[176118] = "", --RSVP: Rendle and Cudgelface
[176119] = "", --RSVP: Choofa
[176120] = "", --RSVP: Cryptkeeper Kassir
[176121] = "", --RSVP: Droman Aliothe
[176122] = "", --RSVP: Grandmaster Vole
[176123] = "", --RSVP: Kleia and Pelagos
[176124] = "", --RSVP: Plague Deviser Marileth
[176125] = "", --RSVP: Sika
[176126] = "", --Contract: Traditional Theme
[176127] = "", --Contract: Mystery Mirrors
[176128] = "", --Contract: Mortal Reminders
[176129] = "", --Contract: Decoration 4
[176130] = "", --Contract: Atoning Rituals
[176131] = "", --Contract: Glimpse of the Wilds
[176132] = "", --Contract: Lost Chalice Band
[176133] = "", --Contract: Entertainment 4
[176134] = "", --Contract: Tubbins's Tea Party
[176135] = "", --Contract: Divine Desserts
[176136] = "", --Contract: Mushroom Surprise!
[176137] = "", --Contract: Refreshment 4
[176138] = "", --Contract: Venthyr Volunteers
[176139] = "", --Contract: Stoneborn Reserves
[176140] = "", --Contract: Maldraxxian Army
[176141] = "", --Contract: Security 4
[176850] = "", --Blank Invitation
[177230] = "", --Anima-Infused Water
[177231] = "", --Crown of Honor
[177232] = "", --Bewitched Wardrobe
[177233] = "", --Bounding Shroom Seeds
[177234] = "", --Rally Bell
[177235] = "", --Tubbins's Lucky Teapot
[177236] = "", --Dog Bone's Bone
[177237] = "", --Dredger Party Supplies
[177238] = "", --Generous Gift
[177239] = "", --Racing Permit
[177241] = "", --Necrolord Arsenal
[177242] = "", --Venthyr Arsenal
[177243] = "", --Kyrian Arsenal
[177244] = "", --Night Fae Arsenal
[177245] = "", --Maldraxxi Challenge Banner
[178686] = "", --RSVP: Stonehead
[178687] = "", --RSVP: VIP [17
[178688] = "", --RSVP: VIP [18
[178689] = "", --RSVP: VIP [19
[178690] = "", --RSVP: VIP 20
[179958] = "", --Ember Court Guest List
[180248] = "", --Ambassador's Reserve
[181436] = "", --Vanity Mirror
[181437] = "", --Training Dummies
[181438] = "", --The Wild Drum
[181439] = "", --Protective Braziers
[181440] = "", --Slippery Muck
[181441] = "", --Altar of Accomplishment
[181442] = "", --Perk 22
[181443] = "", --Perk 23
[181444] = "", --Perk 24
[181445] = "", --Perk 25
[181446] = "", --Perk 26
[181447] = "", --Perk 27
[181448] = "", --Perk 28
[181449] = "", --Perk 29
[181451] = "", --Perk 30
[181517] = "", --Building: Dredger Pool
[181518] = "", --Building: Guardhouse
[181519] = "", --Staff: Dredger Decorators
[181520] = "", --Staff: Stage Crew
[181521] = "", --Staff: Ambassador
[181522] = "", --Staff: Waiters
[181523] = "", --Staff: Bouncers
[181524] = "", --Staff: Ambassador
[181530] = "", --Stock: Greeting Kits
[181532] = "", --Stock: Appetizers
[181533] = "", --Stock: Anima Samples
[181535] = "", --Stock: Comfy Chairs
[181536] = "", --Guest List Page
[181537] = "", --Guest List Page
[181538] = "", --Guest List Page
[181715] = "", --Temel's Certificate of Completion
[182296] = "", --Letter of Note, Premier Party Planner
[182342] = "", --Staff: Ambassador
[182343] = "", --Staff: Ambassador
[183876] = "", --Quill of Correspondence
[183956] = "", --Invitation: Choofa
[183957] = "", --Invitation: Grandmaster Vole
[184626] = "", --Winter Veil Caroling Book
[184628] = "", --Elder's Sacrificial Moonstone
[184663] = "", --Building: Guardhouse
--}

 -- Legendary Powers
--local LegendaryPowersIDs = {
[182617] = "", --Memory of Death's Embrace
[182625] = "", --Memory of an Everlasting Grip
[182626] = "", --Memory of the Phearomones
[182627] = "", --Memory of Superstrain
[182628] = "", --Memory of Bryndaor
[182629] = "", --Memory of the Crimson Runes
[182630] = "", --Memory of Gorefiend's Domination
[182631] = "", --Memory of a Vampiric Aura
[182632] = "", --Memory of Absolute Zero
[182633] = "", --Memory of the Biting Cold
[182634] = "", --Memory of a Frozen Champion's Rage
[182635] = "", --Memory of Koltira
[182636] = "", --Memory of the Deadliest Coil
[182637] = "", --Memory of Death's Certainty
[182638] = "", --Memory of a Frenzied Monstrosity
[182640] = "", --Memory of a Reanimated Shambler
[183210] = "", --Memory of a Fel Bombardment
[183211] = "", --Memory of the Hour of Darkness
[183212] = "", --Memory of a Darkglare Medallion
[183213] = "", --Memory of the Anguish of the Collective
[183214] = "", --Memory of the Chaos Theory
[183215] = "", --Memory of an Erratic Fel Core
[183216] = "", --Memory of a Burning Wound
[183217] = "", --Memory of my Darker Nature
[183218] = "", --Memory of a Fortified Fel Flame
[183219] = "", --Memory of Soul of Fire
[183220] = "", --Memory of Razelikh's Defilement
[183221] = "", --Memory of the Dark Flame Spirit
[183222] = "", --Memory of the Elder Druid
[183223] = "", --Memory of the Circle of Life and Death
[183224] = "", --Memory of a Deep Focus Draught
[183225] = "", --Memory of Lycara
[183226] = "", --Memory of the Balance of All Things
[183227] = "", --Memory of Oneth
[183228] = "", --Memory of Arcane Pulsars
[183229] = "", --Memory of a Timeworn Dreambinder
[183230] = "", --Memory of the Apex Predator
[183231] = "", --Memory of a Cat-eye Curio
[183232] = "", --Memory of a Symmetrical Eye
[183233] = "", --Memory of the Frenzyband
[183234] = "", --Memory of a Luffa-Infused Embrace
[183235] = "", --Memory of the Natural Order
[183236] = "", --Memory of Ursoc
[183237] = "", --Memory of the Sleeper
[183238] = "", --Memory of the Verdant Infusion
[183239] = "", --Memory of an Unending Growth
[183240] = "", --Memory of the Mother Tree
[183241] = "", --Memory of the Dark Titan
[183242] = "", --Memory of Eonar
[183243] = "", --Memory of the Arbiter's Judgment
[183244] = "", --Memory of the Rattle of the Maw
[183245] = "", --Memory of Norgannon
[183246] = "", --Memory of Sephuz
[183247] = "", --Memory of a Stable Phantasma Lure
[183248] = "", --Memory of Jailer's Eye
[183249] = "", --Memory of a Vital Sacrifice
[183250] = "", --Memory of the Wild Call
[183251] = "", --Memory of a Craven Strategem
[183252] = "", --Memory of a Trapping Apparatus
[183253] = "", --Memory of the Soulforge Embers
[183254] = "", --Memory of a Dire Command
[183255] = "", --Memory of the Flamewaker
[183256] = "", --Memory of the Eredun War Order
[183257] = "", --Memory of the Rylakstalker's Fangs
[183258] = "", --Memory of Eagletalon's True Focus
[183259] = "", --Memory of the Unblinking Vigil
[183260] = "", --Memory of the Serpentstalker's Trickery
[183261] = "", --Memory of Surging Shots
[183262] = "", --Memory of the Butcher's Bone Fragments
[183263] = "", --Memory of Poisonous Injectors
[183264] = "", --Memory of the Rylakstalker's Strikes
[183265] = "", --Memory of a Wildfire Cluster
[183266] = "", --Memory of the Disciplinary Command
[183267] = "", --Memory of an Expanded Potential
[183268] = "", --Memory of a Grisly Icicle
[183269] = "", --Memory of the Triune Ward
[183270] = "", --Memory of an Arcane Bombardment
[183271] = "", --Memory of the Infinite Arcane
[183272] = "", --Memory of a Siphoning Storm
[183273] = "", --Memory of a Temporal Warp
[183274] = "", --Memory of a Fevered Incantation
[183275] = "", --Memory of the Firestorm
[183276] = "", --Memory of the Molten Sky
[183277] = "", --Memory of the Sun King
[183278] = "", --Memory of the Cold Front
[183279] = "", --Memory of the Freezing Winds
[183280] = "", --Memory of Fragments of Ice
[183281] = "", --Memory of Slick Ice
[183282] = "", --Memory of the Fatal Touch
[183283] = "", --Memory of the Invoker
[183284] = "", --Memory of Escaping from Reality
[183285] = "", --Memory of the Swiftsure Wraps
[183286] = "", --Memory of Shaohao
[183287] = "", --Memory of Charred Passions
[183288] = "", --Memory of a Celestial Infusion
[183289] = "", --Memory of Stormstout
[183290] = "", --Memory of Ancient Teachings
[183291] = "", --Memory of Yu'lon
[183292] = "", --Memory of Clouded Focus
[183293] = "", --Memory of the Morning's Tear
[183294] = "", --Memory of the Jade Ignition
[183295] = "", --Memory of Keefer
[183296] = "", --Memory of the Last Emperor
[183297] = "", --Memory of Xuen
[183298] = "", --Memory of the Mad Paragon
[183299] = "", --Memory of the Sun's Cycles
[183300] = "", --Memory of the Magistrate's Judgment
[183301] = "", --Memory of Uther
[183302] = "", --Memory of the Sunwell's Bloom
[183303] = "", --Memory of Maraad's Dying Breath
[183304] = "", --Memory of the Shadowbreaker
[183305] = "", --Memory of the Shock Barrier
[183306] = "", --Memory of the Righteous Bulwark
[183307] = "", --Memory of a Holy Sigil
[183308] = "", --Memory of the Endless Kings
[183309] = "", --Memory of the Ardent Protector
[183310] = "", --Memory of the Vanguard's Momentum
[183311] = "", --Memory of the Final Verdict
[183312] = "", --Memory of a Relentless Inquisitor
[183313] = "", --Memory of the Lightbringer's Tempest
[183314] = "", --Memory of Cauterizing Shadows
[183315] = "", --Memory of Measured Contemplation
[183316] = "", --Memory of the Twins of the Sun Priestess
[183317] = "", --Memory of a Heavenly Vault
[183318] = "", --Memory of a Clear Mind
[183319] = "", --Memory of my Crystalline Reflection
[183320] = "", --Memory of the Kiss of Death
[183321] = "", --Memory of the Penitent One
[183322] = "", --Memory of a Divine Image
[183323] = "", --Memory of Flash Concentration
[183324] = "", --Memory of a Harmonious Apparatus
[183325] = "", --Memory of Archbishop Benedictus
[183326] = "", --Memory of the Void's Eternal Call
[183327] = "", --Memory of the Painbreaker Psalm
[183328] = "", --Memory of Talbadar
[183329] = "", --Memory of a Prism of Shadow and Fire
[183330] = "", --Memory of Bloodfang's Essence
[183331] = "", --Memory of Invigorating Shadowdust
[183332] = "", --Memory of the Master Assassin's Mark
[183333] = "", --Memory of Tiny Toxic Blade
[183334] = "", --Memory of the Dashing Scoundrel
[183335] = "", --Memory of the Doomblade
[183336] = "", --Memory of the Duskwalker's Patch
[183337] = "", --Memory of the Zoldyck Insignia
[183338] = "", --Memory of Celerity
[183339] = "", --Memory of a Concealed Blunderbuss
[183340] = "", --Memory of Greenskin
[183341] = "", --Memory of a Guile Charm
[183342] = "", --Memory of Akaari's Soul Fragment
[183343] = "", --Memory of the Deathly Shadows
[183344] = "", --Memory of Finality
[183345] = "", --Memory of the Rotten
[183346] = "", --Memory of an Ancestral Reminder
[183347] = "", --Memory of Devastating Chains
[183348] = "", --Memory of Deeply Rooted Elements
[183349] = "", --Memory of the Deeptremor Stone
[183350] = "", --Memory of the Great Sundering
[183351] = "", --Memory of an Elemental Equilibrium
[183352] = "", --Memory of the Demise of Skybreaker
[183353] = "", --Memory of the Windspeaker's Lava Resurgence
[183354] = "", --Memory of the Doom Winds
[183355] = "", --Memory of the Frost Witch
[183356] = "", --Memory of the Primal Lava Actuators
[183357] = "", --Memory of the Witch Doctor
[183358] = "", --Memory of an Earthen Harmony
[183359] = "", --Memory of Jonat
[183360] = "", --Memory of the Primal Tide Core
[183361] = "", --Memory of the Spiritwalker's Tidal Totem
[183362] = "", --Memory of a Malefic Wrath
[183363] = "", --Memory of Azj'Aqir's Agony
[183364] = "", --Memory of Sacrolash's Dark Strike
[183365] = "", --Memory of the Consuming Wrath
[183366] = "", --Memory of the Claw of Endereth
[183367] = "", --Memory of Demonic Synergy
[183368] = "", --Memory of the Dark Portal
[183369] = "", --Memory of Wilfred's Sigil of Superior Summoning
[183370] = "", --Memory of the Core of the Balespider
[183371] = "", --Memory of the Horned Nightmare
[183372] = "", --Memory of the Grim Inquisitor
[183373] = "", --Memory of an Implosive Potential
[183374] = "", --Memory of Azj'Aqir's Cinders
[183375] = "", --Memory of the Diabolic Raiment
[183376] = "", --Memory of Azj'Aqir's Madness
[183377] = "", --Memory of the Ymirjar
[183378] = "", --Memory of the Leaper
[183379] = "", --Memory of the Misshapen Mirror
[183380] = "", --Memory of a Seismic Reverberation
[183381] = "", --Memory of the Tormented Kings
[183382] = "", --Memory of a Battlelord
[183383] = "", --Memory of an Enduring Blow
[183384] = "", --Memory of the Exploiter
[183385] = "", --Memory of the Unhinged
[183386] = "", --Memory of Fujieda
[183387] = "", --Memory of the Deathmaker
[183388] = "", --Memory of a Reckless Defense
[183389] = "", --Memory of the Berserker's Will
[183390] = "", --Memory of a Reprisal
[183391] = "", --Memory of the Wall
[183392] = "", --Memory of the Thunderlord
[183393] = "", --Memory of an Unbreakable Will
[184665] = "", --Chronicle of Lost Memories
[186565] = "", --Memory of Rampant Transference
[186566] = "", --Memory of the Final Sentence
[186567] = "", --Memory of Insatiable Hunger
[186568] = "", --Memory of an Abomination's Frenzy
[186570] = "", --Memory of Glory
[186572] = "", --Memory of the Sinful Surge
[186576] = "", --Memory of Nature's Fury
[186577] = "", --Memory of the Unbridled Swarm
[186591] = "", --Memory of the Harmonic Echo
[186609] = "", --Memory of Sinful Hysteria
[186621] = "", --Memory of Death's Fathom
[186635] = "", --Memory of Sinful Delight
[186673] = "", --Memory of Kindred Affinity
[186676] = "", --Memory of the Toxic Onslaught
[186687] = "", --Memory of Celestial Spirits
[186689] = "", --Memory of the Splintered Elements
[186710] = "", --Memory of the Obedient
[186712] = "", --Memory of the Deathspike
[186775] = "", --Memory of Resounding Clarity
[187105] = "", --Memory of the Agonizing Gaze
[187106] = "", --Memory of Divine Resonance
[187107] = "", --Memory of the Duty-Bound Gavel
[187109] = "", --Memory of a Blazing Slaughter
[187111] = "", --Memory of Blind Faith
[187118] = "", --Memory of the Demonic Oath
[187127] = "", --Memory of Radiant Embers
[187132] = "", --Memory of the Seasons of Plenty
[187160] = "", --Memory of Pallid Command
[187161] = "", --Memory of Bwonsamdi's Pact
[187162] = "", --Memory of Shadow Word: Manipulation
[187163] = "", --Memory of the Spheres' Harmony
[187217] = "", --Memory of the Bountiful Brew
[187223] = "", --Memory of the Seeds of Rampant Growth
[187224] = "", --Memory of the Elemental Conduit
[187225] = "", --Memory of the Languishing Soul Detritus
[187226] = "", --Memory of the Shards of Annihilation
[187227] = "", --Memory of the Decaying Soul Satchel
[187228] = "", --Memory of the Contained Perpetual Explosion
[187229] = "", --Memory of the Pact of the Soulstalkers
[187230] = "", --Memory of the Bag of Munitions
[187231] = "", --Memory of the Fragments of the Elder Antlers
[187232] = "", --Memory of the Pouch of Razor Fragments
[187237] = "", --Memory of a Call to Arms
[187258] = "", --Memory of the Faeline Harmony
[187259] = "", --Memory of the Raging Vesper Vortex
[187277] = "", --Memory of Sinister Teachings
[187280] = "", --Memory of the Fae Heart
[187511] = "", --Memory of Elysian Might
--}

 -- Outdoor Items
--local OutdoorItemsIDs = {
[173939] = "", --Enticing Anima
[178602] = "", --Thorny Loop
[178658] = "", --Restore Construct
[179392] = "", --Orb of Burgeoning Ambition
[179535] = "", --Crumbling Pride Extractors
[179613] = "", --Extra Sticky Spidey Webs
[179937] = "", --Sliver of Burgeoning Ambition
[179938] = "", --Crumbling Pride Extractors
[179939] = "", --Wriggling Spider Sac
[179977] = "", --Benevolent Gong
[179982] = "", --Kyrian Bell
[180008] = "", --Resonating Anima Core
[180009] = "", --Resonating Anima Mote
[180062] = "", --Heavenly Drum
[180063] = "", --Unearthly Chime
[180064] = "", --Ascended Flute
[180264] = "", --Abominable Backup
[180660] = "", --Darktower Parchments: Instant Polymorphist
[180661] = "", --Darktower Parchments: Affliction Most Foul
[180678] = "", --Peck Acorn
[180688] = "", --Infused Remnant of Light
[180689] = "", --Pocket Embers
[180690] = "", --Bottled Ash Cloud
[180692] = "", --Box of Stalker Traps
[180704] = "", --Infused Pet Biscuit
[180707] = "", --Sticky Muck
[180708] = "", --Mirror of Despair
[180713] = "", --Shrieker's Voicebox
[180874] = "", --Gargon Whistle
[182160] = "", --Bag of Twigin Treats
[182653] = "", --Larion Treats
[182749] = "", --Regurgitated Kyrian Wings
[183122] = "", --Death's Cloak
[183131] = "", --Stygic Grapnel
[183135] = "", --Summon the Fallen
[183136] = "", --Incendiary Mawrat
[183141] = "", --Stygic Magma
[183165] = "", --Mawsworn Crossbow
[183187] = "", --Shadeweaver Incantation
[183602] = "", --Sticky Webbing
[183718] = "", --Extra Gooey Gorm Gunk
[183787] = "", --Stygic Dampener
[183799] = "", --Shifting Catalyst
[183807] = "", --Stygic Coercion
[183811] = "", --Construct's Best Friend
[183902] = "", --A Faintly Glowing Seed
[184485] = "", --Mawforged Key
[184586] = "", --Sky Chain
[184719] = "", --Enchanted Map of Infused Ruby Network
[187865] = "", --Spiked Protomesh
[187866] = "", --Accelerating Tendons
[187867] = "", --Evolved Exo-mucus
--}

 -- Protoform Synthesis
--local ProtoformSynthesisIDs = {
[187633] = "", --Bufonid Lattice
[187634] = "", --Ambystan Lattice
[187635] = "", --Cervid Lattice
[187636] = "", --Aurelid Lattice
[188957] = "", --Genesis Mote
[189145] = "", --Helicid Lattice
[189146] = "", --Geomental Lattice
[189147] = "", --Leporid Lattice
[189148] = "", --Poultrid Lattice
[189149] = "", --Proto Avian Lattice
[189150] = "", --Raptora Lattice
[189151] = "", --Scarabid Lattice
[189152] = "", --Tarachnid Lattice
[189153] = "", --Unformed Lattice
[189154] = "", --Vespoid Lattice
[189155] = "", --Viperid Lattice
[189156] = "", --Vombata Lattice
[189157] = "", --Glimmer of Animation
[189159] = "", --Glimmer of Discovery
[189160] = "", --Glimmer of Focus
[189161] = "", --Glimmer of Malice
[189162] = "", --Glimmer of Metamorphosis
[189163] = "", --Glimmer of Motion
[189164] = "", --Glimmer of Multiplicity
[189165] = "", --Glimmer of Predation
[189166] = "", --Glimmer of Renewal
[189168] = "", --Glimmer of Serenity
[189169] = "", --Glimmer of Survival
[189170] = "", --Glimmer of Vigilance
[189172] = "", --Crystallized Echo of the First Song
[189173] = "", --Eternal Ragepearl
[189176] = "", --Protoform Sentience Crown
[189177] = "", --Revelation Key
[189180] = "", --Wind's Infinite Call
[189499] = "", --Protoform Catalyst
[189500] = "", --Cervid Lattice
[189501] = "", --Protoform Tool
[190388] = "", --Lupine Lattice
--}

 -- Queen's Conservatory
--local QueensConservatoryIDs = {
[176832] = "", --Wildseed Root Grain
[176921] = "", --Temporal Leaves
[176922] = "", --Wild Nightbloom
[177698] = "", --Untamed Spirit
[177699] = "", --Greater Untamed Spirit
[177700] = "", --Divine Untamed Spirit
[177953] = "", --Untamed Spirit
[178874] = "", --Martial Spirit
[178877] = "", --Greater Martial Spirit
[178878] = "", --Divine Martial Spirit
[178879] = "", --Divine Dutiful Spirit
[178880] = "", --Greater Dutiful Spirit
[178881] = "", --Dutiful Spirit
[178882] = "", --Prideful Spirit
[178883] = "", --Greater Prideful Spirit
[178884] = "", --Divine Prideful Spirit
[183520] = "", --Wild Nightbloom Seeds
[183521] = "", --Temporal Leaf Seeds
[183522] = "", --Wildseed Root Grain Seeds
[183704] = "", --Shifting Spirit of Knowledge
[183805] = "", --Tranquil Spirit of the Cosmos
[183806] = "", --Energetic Spirit of Curiosity
[184779] = "", --Temporal Leaves
--}

 -- Rare Proto-Material
--local RareProtoMaterialIDs = {
[187879] = "", --Pollinated Extraction
[187885] = "", --Honeycombed Lattice
[187889] = "", --Unstable Agitant
[187891] = "", --Empyrean Essence
[187892] = "", --Incorporeal Sand
[187893] = "", --Volatile Precursor
[187894] = "", --Energized Firmament
[190128] = "", --Wayward Essence
[190129] = "", --Serene Pigment
--}

 -- Roh-Suir
--local RohSuirIDs = {
[185636] = "", --The Archivists' Codex
[186648] = "", --Soaring Razorwing
[186714] = "", --Research Report: All-Seeing Crystal
[186716] = "", --Research Report: Ancient Shrines
[186717] = "", --Research Report: Adaptive Alloys
[186718] = "", --Teleporter Repair Kit
[186721] = "", --Treatise: Relics Abound in the Shadowlands
[186722] = "", --Treatise: The Study of Anima and Harnessing Every Drop
[186731] = "", --Repaired Riftkey
[186984] = "", --Korthite Crystal Key
[187134] = "", --Alloy-Warping Facetor
[187138] = "", --Research Report: First Alloys
[187145] = "", --Treatise: Recognizing Stygia and its Uses
[187148] = "", --Death-Bound Shard
[187508] = "", --Trained Gromit Carrier
[187612] = "", --Key of Flowing Waters
[187613] = "", --Key of the Inner Chambers
[187614] = "", --Key of Many Thoughts
--}

 -- Rune Vessel
--local RuneVesselIDs = {
[171412] = "", --Shadowghast Breastplate
[171413] = "", --Shadowghast Sabatons
[171414] = "", --Shadowghast Gauntlets
[171415] = "", --Shadowghast Helm
[171416] = "", --Shadowghast Greaves
[171417] = "", --Shadowghast Pauldrons
[171418] = "", --Shadowghast Waistguard
[171419] = "", --Shadowghast Armguards
[172314] = "", --Umbrahide Vest
[172315] = "", --Umbrahide Treads
[172316] = "", --Umbrahide Gauntlets
[172317] = "", --Umbrahide Helm
[172318] = "", --Umbrahide Leggings
[172319] = "", --Umbrahide Pauldrons
[172320] = "", --Umbrahide Waistguard
[172321] = "", --Umbrahide Armguards
[172322] = "", --Boneshatter Vest
[172323] = "", --Boneshatter Treads
[172324] = "", --Boneshatter Gauntlets
[172325] = "", --Boneshatter Helm
[172326] = "", --Boneshatter Greaves
[172327] = "", --Boneshatter Pauldrons
[172328] = "", --Boneshatter Waistguard
[172329] = "", --Boneshatter Armguards
[173241] = "", --Grim-Veiled Robe
[173242] = "", --Grim-Veiled Cape
[173243] = "", --Grim-Veiled Sandals
[173244] = "", --Grim-Veiled Mittens
[173245] = "", --Grim-Veiled Hood
[173246] = "", --Grim-Veiled Pants
[173247] = "", --Grim-Veiled Spaulders
[173248] = "", --Grim-Veiled Belt
[173249] = "", --Grim-Veiled Bracers
[178926] = "", --Shadowghast Ring
[178927] = "", --Shadowghast Necklace
--}

 -- Shards of Domination
--local ShardsofDominationIDs = {
[187057] = "", --Shard of Bek
[187059] = "", --Shard of Jas
[187061] = "", --Shard of Rev
[187063] = "", --Shard of Cor
[187065] = "", --Shard of Kyr
[187071] = "", --Shard of Tel
[187073] = "", --Shard of Dyz
[187076] = "", --Shard of Oth
[187079] = "", --Shard of Zed
[187120] = "", --Blood Healing Shard 1 - Rank 5
[187284] = "", --Ominous Shard of Bek
[187285] = "", --Ominous Shard of Jas
[187286] = "", --Ominous Shard of Rev
[187287] = "", --Ominous Shard of Cor
[187288] = "", --Ominous Shard of Kyr
[187289] = "", --Ominous Shard of Tel
[187290] = "", --Ominous Shard of Dyz
[187291] = "", --Ominous Shard of Oth
[187292] = "", --Ominous Shard of Zed
[187293] = "", --Desolate Shard of Bek
[187294] = "", --Desolate Shard of Jas
[187295] = "", --Desolate Shard of Rev
[187296] = "", --Desolate Shard of Cor
[187297] = "", --Desolate Shard of Kyr
[187298] = "", --Desolate Shard of Tel
[187299] = "", --Desolate Shard of Dyz
[187300] = "", --Desolate Shard of Oth
[187301] = "", --Desolate Shard of Zed
[187302] = "", --Foreboding Shard of Bek
[187303] = "", --Foreboding Shard of Jas
[187304] = "", --Foreboding Shard of Rev
[187305] = "", --Foreboding Shard of Cor
[187306] = "", --Foreboding Shard of Kyr
[187307] = "", --Foreboding Shard of Tel
[187308] = "", --Foreboding Shard of Dyz
[187309] = "", --Foreboding Shard of Oth
[187310] = "", --Foreboding Shard of Zed
[187312] = "", --Portentous Shard of Bek
[187313] = "", --Portentous Shard of Jas
[187314] = "", --Portentous Shard of Rev
[187315] = "", --Portentous Shard of Cor
[187316] = "", --Portentous Shard of Kyr
[187317] = "", --Portentous Shard of Tel
[187318] = "", --Portentous Shard of Dyz
[187319] = "", --Portentous Shard of Oth
[187320] = "", --Portentous Shard of Zed
[187532] = "", --Soulfire Chisel
--}

 -- Sinstones
--local SinstonesIDs = {
[172996] = "", --Inquisitor Sorin's Sinstone
[172997] = "", --Inquisitor Petre's Sinstone
[172998] = "", --Inquisitor Otilia's Sinstone
[172999] = "", --Inquisitor Traian's Sinstone
[173000] = "", --High Inquisitor Gabi's Sinstone
[173001] = "", --High Inquisitor Radu's Sinstone
[173005] = "", --High Inquisitor Magda's Sinstone
[173006] = "", --High Inquisitor Dacian's Sinstone
[173007] = "", --Grand Inquisitor Nicu's Sinstone
[173008] = "", --Grand Inquisitor Aurica's Sinstone
[180451] = "", --Grand Inquisitor's Sinstone Fragment
--}

 -- Ve'nari
--local VenariIDs = {
[180817] = "", --Cypher of Relocation
[180949] = "", --Animaflow Stabilizer
[180952] = "", --Possibility Matrix
[180953] = "", --Soultwinning Scepter
[181245] = "", --Oil of Ethereal Force
[184361] = "", --Spatial Realignment Apparatus
[184588] = "", --Soul-Stabilizing Talisman
[184605] = "", --Sigil of the Unseen
[184613] = "", --Encased Riftwalker Essence
[184615] = "", --Extradimensional Pockets
[184617] = "", --Bangle of Seniority
[184618] = "", --Rank Insignia: Acquisitionist
[184619] = "", --Loupe of Unusual Charm
[184620] = "", --Vessel of Unfortunate Spirits
[184621] = "", --Ritual Prism of Fortune
[184651] = "", --Maw-Touched Miasma
[184652] = "", --Phantasmic Infuser
[184653] = "", --Animated Levitating Chain
[184664] = "", --Sticky-Fingered Skeletal Hand
--}

 -- Zereth Mortis
--local ZerethMortisIDs = {
[187707] = "", --Progenitor Essentia
[187728] = "", --Ephemera Strands
[187790] = "", --Trace Enigmet
[187791] = "", --ERROR
[187908] = "", --Firim's Spare Forge-tap
[188787] = "", --Locked Broker Luggage
[189575] = "", --Firim in Exile, Part 1
[189576] = "", --Firim in Exile, Part 2
[189578] = "", --Firim in Exile, Part 3
[189579] = "", --Firim in Exile, Part 4
[189580] = "", --Firim in Exile, Part 5
[189581] = "", --Firim in Exile, Part 6
[189582] = "", --Firim in Exile, Part 7
[189704] = "", --Dominance Key
[189753] = "", --Firim in Exile, Epilogue
[189863] = "", --Spatial Opener
[190189] = "", --Sandworn Relic
[190197] = "", --Sandworn Chest Key
[190198] = "", --Sandworn Chest Key Fragment
[190738] = "", --Bouncing Bufonids
[190739] = "", --Provis Wax
}


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
function Shadowlands(player, bag, slot, bagInfo, itemInfo)
    if not itemInfo then return false end
    if not itemInfo.link then return false end
	local ItemID = itemInfo.link:match('item:(%d+)')
	if not ItemID then return false end
	return arrZoneItems[tonumber(ItemID)];
end
local function ShiGuang(...)
	return (Open(...) or Garrison(...) or BFA(...) or Shadowlands(...));
end
-----------------------------------------------------------------------------------------------------------------------------------------
Combuctor.Rules:New("ShiGuang", "ShiGuang", "Interface/AddOns/_ShiGuang/Media/2UI", ShiGuang);
Combuctor.Rules:New("ShiGuang/Open", "Open", nil, Open);
Combuctor.Rules:New("ShiGuang/Garrison", "Garrison", nil, Garrison);
Combuctor.Rules:New('ShiGuang/BFA', "BFA", nil, BFA)  --'Interface/Icons/INV_HeartOfAzeroth'
Combuctor.Rules:New('ShiGuang/Shadowlands', "SL", nil, Shadowlands)