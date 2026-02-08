--[[## Version: 12.0.3 ## Author: Updated for Midnight Pre-Patch (12.0) by Osiris the Kiwi / Discord: osirisnz / Original authors: mkp_tv / Hayato2846 / Thainii
	FriendGroups - FULL ORIGINAL CODE + SECURE ARCHITECTURE
    - Uses the exact original logic for groups, menus, and sorting.
    - Adds "Lazy Loading" to prevent VisitHouse() taint.
    - Adds Safety Shield to the House List.
]] --
-- [[ REALM FLAGS DATABASE ]] --
-- Categorized by RegionID: 1=US/OC, 2=KR, 3=EU/RU, 4=TW, 5=CN
-- Keys must have NO SPACES.

-- [[ REGION 1: AMERICAS & OCEANIA ]] --
FriendGroups_RealmData = {
    -- Australia / Oceania (FlagAU.tga)
    ["Aman'Thul"] = {icon = "FlagAU.tga", region = "Oceania"},
    ["Barthilas"] = {icon = "FlagAU.tga", region = "Oceania"},
    ["Caelestrasz"] = {icon = "FlagAU.tga", region = "Oceania"},
    ["Dath'Remar"] = {icon = "FlagAU.tga", region = "Oceania"},
    ["Dreadmaul"] = {icon = "FlagAU.tga", region = "Oceania"},
    ["Frostmourne"] = {icon = "FlagAU.tga", region = "Oceania"},
    ["Gundrak"] = {icon = "FlagAU.tga", region = "Oceania"},
    ["Jubei'Thos"] = {icon = "FlagAU.tga", region = "Oceania"},
    ["Khaz'goroth"] = {icon = "FlagAU.tga", region = "Oceania"},
    ["Nagrand"] = {icon = "FlagAU.tga", region = "Oceania"},
    ["Saurfang"] = {icon = "FlagAU.tga", region = "Oceania"},
    ["Thaurissan"] = {icon = "FlagAU.tga", region = "Oceania"},

    -- Brazil (FlagBR.tga)
    ["Azralon"] = {icon = "FlagBR.tga", region = "Brazil"},
    ["Gallywix"] = {icon = "FlagBR.tga", region = "Brazil"},
    ["Goldrinn"] = {icon = "FlagBR.tga", region = "Brazil"},
    ["Nemesis"] = {icon = "FlagBR.tga", region = "Brazil"},
    ["TolBarad"] = {icon = "FlagBR.tga", region = "Brazil"},

    -- Mexico / Latin America (FlagMX.tga)
    ["Drakkari"] = {icon = "FlagMX.tga", region = "Mexico"},
    ["Quel'Thalas"] = {icon = "FlagMX.tga", region = "Mexico"},
    ["Ragnaros"] = {icon = "FlagMX.tga", region = "Mexico"},

    -- North America (FlagUS.tga)
    ["Aegwynn"] = {icon = "FlagUS.tga", region = "US"},
    ["AeriePeak"] = {icon = "FlagUS.tga", region = "US"},
    ["Agamaggan"] = {icon = "FlagUS.tga", region = "US"},
    ["Aggramar"] = {icon = "FlagUS.tga", region = "US"},
    ["Akama"] = {icon = "FlagUS.tga", region = "US"},
    ["Alexstrasza"] = {icon = "FlagUS.tga", region = "US"},
    ["Alleria"] = {icon = "FlagUS.tga", region = "US"},
    ["AltarofStorms"] = {icon = "FlagUS.tga", region = "US"},
    ["AlteracMountains"] = {icon = "FlagUS.tga", region = "US"},
    ["Andorhal"] = {icon = "FlagUS.tga", region = "US"},
    ["Anetheron"] = {icon = "FlagUS.tga", region = "US"},
    ["Antonidas"] = {icon = "FlagUS.tga", region = "US"},
    ["Anub'arak"] = {icon = "FlagUS.tga", region = "US"},
    ["Anvilmar"] = {icon = "FlagUS.tga", region = "US"},
    ["Arathor"] = {icon = "FlagUS.tga", region = "US"},
    ["Archimonde"] = {icon = "FlagUS.tga", region = "US"},
    ["Area52"] = {icon = "FlagUS.tga", region = "US"},
    ["ArgentDawn"] = {icon = "FlagUS.tga", region = "US"},
    ["Arthas"] = {icon = "FlagUS.tga", region = "US"},
    ["Arygos"] = {icon = "FlagUS.tga", region = "US"},
    ["Auchindoun"] = {icon = "FlagUS.tga", region = "US"},
    ["Azgalor"] = {icon = "FlagUS.tga", region = "US"},
    ["AzjolNerub"] = {icon = "FlagUS.tga", region = "US"},
    ["Azshara"] = {icon = "FlagUS.tga", region = "US"},
    ["Azuremyst"] = {icon = "FlagUS.tga", region = "US"},
    ["Baelgun"] = {icon = "FlagUS.tga", region = "US"},
    ["Balnazzar"] = {icon = "FlagUS.tga", region = "US"},
    ["BlackDragonflight"] = {icon = "FlagUS.tga", region = "US"},
    ["Blackhand"] = {icon = "FlagUS.tga", region = "US"},
    ["Blackrock"] = {icon = "FlagUS.tga", region = "US"},
    ["BlackwaterRaiders"] = {icon = "FlagUS.tga", region = "US"},
    ["BlackwingLair"] = {icon = "FlagUS.tga", region = "US"},
    ["Blade'sEdge"] = {icon = "FlagUS.tga", region = "US"},
    ["Bladefist"] = {icon = "FlagUS.tga", region = "US"},
    ["BleedingHollow"] = {icon = "FlagUS.tga", region = "US"},
    ["BloodFurnace"] = {icon = "FlagUS.tga", region = "US"},
    ["Bloodhoof"] = {icon = "FlagUS.tga", region = "US"},
    ["Bloodscalp"] = {icon = "FlagUS.tga", region = "US"},
    ["Bonechewer"] = {icon = "FlagUS.tga", region = "US"},
    ["BoreanTundra"] = {icon = "FlagUS.tga", region = "US"},
    ["Boulderfist"] = {icon = "FlagUS.tga", region = "US"},
    ["Bronzebeard"] = {icon = "FlagUS.tga", region = "US"},
    ["BurningBlade"] = {icon = "FlagUS.tga", region = "US"},
    ["BurningLegion"] = {icon = "FlagUS.tga", region = "US"},
    ["Cairne"] = {icon = "FlagUS.tga", region = "US"},
    ["CenarionCircle"] = {icon = "FlagUS.tga", region = "US"},
    ["Cenarius"] = {icon = "FlagUS.tga", region = "US"},
    ["Cho'gall"] = {icon = "FlagUS.tga", region = "US"},
    ["Chromaggus"] = {icon = "FlagUS.tga", region = "US"},
    ["Coilfang"] = {icon = "FlagUS.tga", region = "US"},
    ["Crushridge"] = {icon = "FlagUS.tga", region = "US"},
    ["Daggerspine"] = {icon = "FlagUS.tga", region = "US"},
    ["Dalaran"] = {icon = "FlagUS.tga", region = "US"},
    ["Dalvengyr"] = {icon = "FlagUS.tga", region = "US"},
    ["DarkIron"] = {icon = "FlagUS.tga", region = "US"},
    ["Darkspear"] = {icon = "FlagUS.tga", region = "US"},
    ["Darrowmere"] = {icon = "FlagUS.tga", region = "US"},
    ["Dawnbringer"] = {icon = "FlagUS.tga", region = "US"},
    ["Deathwing"] = {icon = "FlagUS.tga", region = "US"},
    ["DemonSoul"] = {icon = "FlagUS.tga", region = "US"},
    ["Dentarg"] = {icon = "FlagUS.tga", region = "US"},
    ["Destromath"] = {icon = "FlagUS.tga", region = "US"},
    ["Dethecus"] = {icon = "FlagUS.tga", region = "US"},
    ["Detheroc"] = {icon = "FlagUS.tga", region = "US"},
    ["Doomhammer"] = {icon = "FlagUS.tga", region = "US"},
    ["Draenor"] = {icon = "FlagUS.tga", region = "US"},
    ["Dragonblight"] = {icon = "FlagUS.tga", region = "US"},
    ["Dragonmaw"] = {icon = "FlagUS.tga", region = "US"},
    ["Drenden"] = {icon = "FlagUS.tga", region = "US"},
    ["Dunemaul"] = {icon = "FlagUS.tga", region = "US"},
    ["Durotan"] = {icon = "FlagUS.tga", region = "US"},
    ["Duskwood"] = {icon = "FlagUS.tga", region = "US"},
    ["EarthenRing"] = {icon = "FlagUS.tga", region = "US"},
    ["EchoIsles"] = {icon = "FlagUS.tga", region = "US"},
    ["Eitrigg"] = {icon = "FlagUS.tga", region = "US"},
    ["Eldre'Thalas"] = {icon = "FlagUS.tga", region = "US"},
    ["Elune"] = {icon = "FlagUS.tga", region = "US"},
    ["EmeraldDream"] = {icon = "FlagUS.tga", region = "US"},
    ["Eonar"] = {icon = "FlagUS.tga", region = "US"},
    ["Eredar"] = {icon = "FlagUS.tga", region = "US"},
    ["Executus"] = {icon = "FlagUS.tga", region = "US"},
    ["Exodar"] = {icon = "FlagUS.tga", region = "US"},
    ["Farstriders"] = {icon = "FlagUS.tga", region = "US"},
    ["Feathermoon"] = {icon = "FlagUS.tga", region = "US"},
    ["Fenris"] = {icon = "FlagUS.tga", region = "US"},
    ["Firetree"] = {icon = "FlagUS.tga", region = "US"},
    ["Fizzcrank"] = {icon = "FlagUS.tga", region = "US"},
    ["Frostmane"] = {icon = "FlagUS.tga", region = "US"},
    ["Frostwolf"] = {icon = "FlagUS.tga", region = "US"},
    ["Galakrond"] = {icon = "FlagUS.tga", region = "US"},
    ["Garithos"] = {icon = "FlagUS.tga", region = "US"},
    ["Garona"] = {icon = "FlagUS.tga", region = "US"},
    ["Garrosh"] = {icon = "FlagUS.tga", region = "US"},
    ["Ghostlands"] = {icon = "FlagUS.tga", region = "US"},
    ["Gilneas"] = {icon = "FlagUS.tga", region = "US"},
    ["Gnomeregan"] = {icon = "FlagUS.tga", region = "US"},
    ["Gorefiend"] = {icon = "FlagUS.tga", region = "US"},
    ["Gorgonnash"] = {icon = "FlagUS.tga", region = "US"},
    ["Greymane"] = {icon = "FlagUS.tga", region = "US"},
    ["GrizzlyHills"] = {icon = "FlagUS.tga", region = "US"},
    ["Gul'dan"] = {icon = "FlagUS.tga", region = "US"},
    ["Gurubashi"] = {icon = "FlagUS.tga", region = "US"},
    ["Hakkar"] = {icon = "FlagUS.tga", region = "US"},
    ["Haomarush"] = {icon = "FlagUS.tga", region = "US"},
    ["Hellscream"] = {icon = "FlagUS.tga", region = "US"},
    ["Hydraxis"] = {icon = "FlagUS.tga", region = "US"},
    ["Hyjal"] = {icon = "FlagUS.tga", region = "US"},
    ["Icecrown"] = {icon = "FlagUS.tga", region = "US"},
    ["Illidan"] = {icon = "FlagUS.tga", region = "US"},
    ["Jaedenar"] = {icon = "FlagUS.tga", region = "US"},
    ["Kael'thas"] = {icon = "FlagUS.tga", region = "US"},
    ["Kalecgos"] = {icon = "FlagUS.tga", region = "US"},
    ["Kargath"] = {icon = "FlagUS.tga", region = "US"},
    ["Kel'Thuzad"] = {icon = "FlagUS.tga", region = "US"},
    ["Khadgar"] = {icon = "FlagUS.tga", region = "US"},
    ["KhazModan"] = {icon = "FlagUS.tga", region = "US"},
    ["Kil'jaeden"] = {icon = "FlagUS.tga", region = "US"},
    ["Kilrogg"] = {icon = "FlagUS.tga", region = "US"},
    ["KirinTor"] = {icon = "FlagUS.tga", region = "US"},
    ["Korgath"] = {icon = "FlagUS.tga", region = "US"},
    ["Korialstrasz"] = {icon = "FlagUS.tga", region = "US"},
    ["KulTiras"] = {icon = "FlagUS.tga", region = "US"},
    ["LaughingSkull"] = {icon = "FlagUS.tga", region = "US"},
    ["Lethon"] = {icon = "FlagUS.tga", region = "US"},
    ["Lightbringer"] = {icon = "FlagUS.tga", region = "US"},
    ["Lightning'sBlade"] = {icon = "FlagUS.tga", region = "US"},
    ["Lightninghoof"] = {icon = "FlagUS.tga", region = "US"},
    ["Llane"] = {icon = "FlagUS.tga", region = "US"},
    ["Lothar"] = {icon = "FlagUS.tga", region = "US"},
    ["Madoran"] = {icon = "FlagUS.tga", region = "US"},
    ["Maelstrom"] = {icon = "FlagUS.tga", region = "US"},
    ["Magtheridon"] = {icon = "FlagUS.tga", region = "US"},
    ["Maiev"] = {icon = "FlagUS.tga", region = "US"},
    ["Mal'Ganis"] = {icon = "FlagUS.tga", region = "US"},
    ["Malfurion"] = {icon = "FlagUS.tga", region = "US"},
    ["Malorne"] = {icon = "FlagUS.tga", region = "US"},
    ["Malygos"] = {icon = "FlagUS.tga", region = "US"},
    ["Mannoroth"] = {icon = "FlagUS.tga", region = "US"},
    ["Medivh"] = {icon = "FlagUS.tga", region = "US"},
    ["Misha"] = {icon = "FlagUS.tga", region = "US"},
    ["Mok'Nathal"] = {icon = "FlagUS.tga", region = "US"},
    ["MoonGuard"] = {icon = "FlagUS.tga", region = "US"},
    ["Moonrunner"] = {icon = "FlagUS.tga", region = "US"},
    ["Mug'thol"] = {icon = "FlagUS.tga", region = "US"},
    ["Muradin"] = {icon = "FlagUS.tga", region = "US"},
    ["Nathrezim"] = {icon = "FlagUS.tga", region = "US"},
    ["Nazgrel"] = {icon = "FlagUS.tga", region = "US"},
    ["Nazjatar"] = {icon = "FlagUS.tga", region = "US"},
    ["Ner'zhul"] = {icon = "FlagUS.tga", region = "US"},
    ["Nesingwary"] = {icon = "FlagUS.tga", region = "US"},
    ["Nordrassil"] = {icon = "FlagUS.tga", region = "US"},
    ["Norgannon"] = {icon = "FlagUS.tga", region = "US"},
    ["Onyxia"] = {icon = "FlagUS.tga", region = "US"},
    ["Perenolde"] = {icon = "FlagUS.tga", region = "US"},
    ["Proudmoore"] = {icon = "FlagUS.tga", region = "US"},
    ["Quel'dorei"] = {icon = "FlagUS.tga", region = "US"},
    ["Ravencrest"] = {icon = "FlagUS.tga", region = "US"},
    ["Ravenholdt"] = {icon = "FlagUS.tga", region = "US"},
    ["Rexxar"] = {icon = "FlagUS.tga", region = "US"},
    ["Rivendare"] = {icon = "FlagUS.tga", region = "US"},
    ["Runetotem"] = {icon = "FlagUS.tga", region = "US"},
    ["Sargeras"] = {icon = "FlagUS.tga", region = "US"},
    ["ScarletCrusade"] = {icon = "FlagUS.tga", region = "US"},
    ["Scilla"] = {icon = "FlagUS.tga", region = "US"},
    ["Sen'jin"] = {icon = "FlagUS.tga", region = "US"},
    ["Sentinels"] = {icon = "FlagUS.tga", region = "US"},
    ["ShadowCouncil"] = {icon = "FlagUS.tga", region = "US"},
    ["Shadowmoon"] = {icon = "FlagUS.tga", region = "US"},
    ["Shadowsong"] = {icon = "FlagUS.tga", region = "US"},
    ["Shandris"] = {icon = "FlagUS.tga", region = "US"},
    ["ShatteredHalls"] = {icon = "FlagUS.tga", region = "US"},
    ["ShatteredHand"] = {icon = "FlagUS.tga", region = "US"},
    ["Shu'halo"] = {icon = "FlagUS.tga", region = "US"},
    ["SilverHand"] = {icon = "FlagUS.tga", region = "US"},
    ["Silvermoon"] = {icon = "FlagUS.tga", region = "US"},
    ["SistersofElune"] = {icon = "FlagUS.tga", region = "US"},
    ["Skullcrusher"] = {icon = "FlagUS.tga", region = "US"},
    ["Skywall"] = {icon = "FlagUS.tga", region = "US"},
    ["Smolderthorn"] = {icon = "FlagUS.tga", region = "US"},
    ["Spinebreaker"] = {icon = "FlagUS.tga", region = "US"},
    ["Spirestone"] = {icon = "FlagUS.tga", region = "US"},
    ["Staghelm"] = {icon = "FlagUS.tga", region = "US"},
    ["SteamwheedleCartel"] = {icon = "FlagUS.tga", region = "US"},
    ["Stonemaul"] = {icon = "FlagUS.tga", region = "US"},
    ["Stormrage"] = {icon = "FlagUS.tga", region = "US"},
    ["Stormreaver"] = {icon = "FlagUS.tga", region = "US"},
    ["Stormscale"] = {icon = "FlagUS.tga", region = "US"},
    ["Suramar"] = {icon = "FlagUS.tga", region = "US"},
    ["Tanaris"] = {icon = "FlagUS.tga", region = "US"},
    ["Terenas"] = {icon = "FlagUS.tga", region = "US"},
    ["Terokkar"] = {icon = "FlagUS.tga", region = "US"},
    ["TheForgottenCoast"] = {icon = "FlagUS.tga", region = "US"},
    ["TheScryers"] = {icon = "FlagUS.tga", region = "US"},
    ["TheUnderbog"] = {icon = "FlagUS.tga", region = "US"},
    ["TheVentureCo"] = {icon = "FlagUS.tga", region = "US"},
    ["ThoriumBrotherhood"] = {icon = "FlagUS.tga", region = "US"},
    ["Thrall"] = {icon = "FlagUS.tga", region = "US"},
    ["Thunderhorn"] = {icon = "FlagUS.tga", region = "US"},
    ["Thunderlord"] = {icon = "FlagUS.tga", region = "US"},
    ["Tichondrius"] = {icon = "FlagUS.tga", region = "US"},
    ["Tortheldrin"] = {icon = "FlagUS.tga", region = "US"},
    ["Trollbane"] = {icon = "FlagUS.tga", region = "US"},
    ["Turalyon"] = {icon = "FlagUS.tga", region = "US"},
    ["TwistingNether"] = {icon = "FlagUS.tga", region = "US"},
    ["Uldaman"] = {icon = "FlagUS.tga", region = "US"},
    ["Uldum"] = {icon = "FlagUS.tga", region = "US"},
    ["Undermine"] = {icon = "FlagUS.tga", region = "US"},
    ["Ursin"] = {icon = "FlagUS.tga", region = "US"},
    ["Uther"] = {icon = "FlagUS.tga", region = "US"},
    ["Vashj"] = {icon = "FlagUS.tga", region = "US"},
    ["Vek'nilash"] = {icon = "FlagUS.tga", region = "US"},
    ["Velen"] = {icon = "FlagUS.tga", region = "US"},
    ["Warsong"] = {icon = "FlagUS.tga", region = "US"},
    ["Whisperwind"] = {icon = "FlagUS.tga", region = "US"},
    ["Wildhammer"] = {icon = "FlagUS.tga", region = "US"},
    ["Windrunner"] = {icon = "FlagUS.tga", region = "US"},
    ["Winterhoof"] = {icon = "FlagUS.tga", region = "US"},
    ["WyrmrestAccord"] = {icon = "FlagUS.tga", region = "US"},
    ["Ysera"] = {icon = "FlagUS.tga", region = "US"},
    ["Ysondre"] = {icon = "FlagUS.tga", region = "US"},
    ["Zangarmarsh"] = {icon = "FlagUS.tga", region = "US"},
    ["Zul'jin"] = {icon = "FlagUS.tga", region = "US"},
    ["Zuluhed"] = {icon = "FlagUS.tga", region = "US"},

    -- Classic / Era Hubs (FlagUS.tga)
    ["Ashkandi"] = {icon = "FlagUS.tga", region = "US"},
    ["Atiesh"] = {icon = "FlagUS.tga", region = "US"},
    ["Benediction"] = {icon = "FlagUS.tga", region = "US"},
    ["BloodsailBuccaneers"] = {icon = "FlagUS.tga", region = "US"},
    ["Faerlina"] = {icon = "FlagUS.tga", region = "US"},
    ["Grobbulus"] = {icon = "FlagUS.tga", region = "US"},
    ["Mankrik"] = {icon = "FlagUS.tga", region = "US"},
    ["OldBlanchy"] = {icon = "FlagUS.tga", region = "US"},
    ["Westfall"] = {icon = "FlagUS.tga", region = "US"},
    ["Whitemane"] = {icon = "FlagUS.tga", region = "US"},

-- 2026 Anniversary / Fresh
    ["ChaosBolt"] = {icon = "FlagUS.tga", region = "US"},
    ["CrusaderStrike"] = {icon = "FlagUS.tga", region = "US"},
    ["DefiasPillager"] = {icon = "FlagUS.tga", region = "US"},
    ["Doomhowl"] = {icon = "FlagUS.tga", region = "US"}, -- Hardcore Anniversary
    ["Dreamscythe"] = {icon = "FlagUS.tga", region = "US"}, -- Normal Anniversary
    ["LavaLash"] = {icon = "FlagUS.tga", region = "US"},
    ["LivingFlame"] = {icon = "FlagUS.tga", region = "US"},
    ["LoneWolf"] = {icon = "FlagUS.tga", region = "US"},
    ["Maladath"] = {icon = "FlagAU.tga", region = "Oceania"}, -- OC Anniversary Hub
    ["Nightslayer"] = {icon = "FlagUS.tga", region = "US"}, -- PvP Anniversary
    ["Pagle"] = {icon = "FlagUS.tga", region = "US"},
    ["SkullRock"] = {icon = "FlagUS.tga", region = "US"},
    ["WildGrowth"] = {icon = "FlagUS.tga", region = "US"},

}

-- [[ REGION 3: EUROPE & RUSSIA ]] --
FriendGroups_RealmDataEU = {
    -- European English / UK (FlagGB.tga)
    ["AeriePeak"] = {icon = "FlagGB.tga", region = "EU"},
    ["Agamaggan"] = {icon = "FlagGB.tga", region = "EU"},
    ["Aggramar"] = {icon = "FlagGB.tga", region = "EU"},
    ["Ahn'Qiraj"] = {icon = "FlagGB.tga", region = "EU"},
    ["Al'Akir"] = {icon = "FlagGB.tga", region = "EU"},
    ["Alonsus"] = {icon = "FlagGB.tga", region = "EU"},
    ["Anachronos"] = {icon = "FlagGB.tga", region = "EU"},
    ["Arathor"] = {icon = "FlagGB.tga", region = "EU"},
    ["ArgentDawn"] = {icon = "FlagGB.tga", region = "EU"},
    ["Aszune"] = {icon = "FlagGB.tga", region = "EU"},
    ["Auchindoun"] = {icon = "FlagGB.tga", region = "EU"},
    ["AzjolNerub"] = {icon = "FlagGB.tga", region = "EU"},
    ["Azuremyst"] = {icon = "FlagGB.tga", region = "EU"},
    ["Balnazzar"] = {icon = "FlagGB.tga", region = "EU"},
    ["Blade'sEdge"] = {icon = "FlagGB.tga", region = "EU"},
    ["Bladefist"] = {icon = "FlagGB.tga", region = "EU"},
    ["Bloodfeather"] = {icon = "FlagGB.tga", region = "EU"},
    ["Bloodhoof"] = {icon = "FlagGB.tga", region = "EU"},
    ["Bloodscalp"] = {icon = "FlagGB.tga", region = "EU"},
    ["Boulderfist"] = {icon = "FlagGB.tga", region = "EU"},
    ["Bronzebeard"] = {icon = "FlagGB.tga", region = "EU"},
    ["BronzeDragonflight"] = {icon = "FlagGB.tga", region = "EU"},
    ["BurningBlade"] = {icon = "FlagGB.tga", region = "EU"},
    ["BurningLegion"] = {icon = "FlagGB.tga", region = "EU"},
    ["BurningSteppes"] = {icon = "FlagGB.tga", region = "EU"},
    ["ChamberofAspects"] = {icon = "FlagGB.tga", region = "EU"},
    ["Chromaggus"] = {icon = "FlagGB.tga", region = "EU"},
    ["Crushridge"] = {icon = "FlagGB.tga", region = "EU"},
    ["Daggerspine"] = {icon = "FlagGB.tga", region = "EU"},
    ["DarkmoonFaire"] = {icon = "FlagGB.tga", region = "EU"},
    ["Darksorrow"] = {icon = "FlagGB.tga", region = "EU"},
    ["Darkspear"] = {icon = "FlagGB.tga", region = "EU"},
    ["Deathwing"] = {icon = "FlagGB.tga", region = "EU"},
    ["DefiasBrotherhood"] = {icon = "FlagGB.tga", region = "EU"},
    ["Dentarg"] = {icon = "FlagGB.tga", region = "EU"},
    ["Doomhammer"] = {icon = "FlagGB.tga", region = "EU"},
    ["Draenor"] = {icon = "FlagGB.tga", region = "EU"},
    ["Dragonblight"] = {icon = "FlagGB.tga", region = "EU"},
    ["Dragonmaw"] = {icon = "FlagGB.tga", region = "EU"},
    ["Drak'thul"] = {icon = "FlagGB.tga", region = "EU"},
    ["Dunemaul"] = {icon = "FlagGB.tga", region = "EU"},
    ["EarthenRing"] = {icon = "FlagGB.tga", region = "EU"},
    ["EmeraldDream"] = {icon = "FlagGB.tga", region = "EU"},
    ["Emeriss"] = {icon = "FlagGB.tga", region = "EU"},
    ["Eonar"] = {icon = "FlagGB.tga", region = "EU"},
    ["Executus"] = {icon = "FlagGB.tga", region = "EU"},
    ["Frostmane"] = {icon = "FlagGB.tga", region = "EU"},
    ["Frostwhisper"] = {icon = "FlagGB.tga", region = "EU"},
    ["Genjuros"] = {icon = "FlagGB.tga", region = "EU"},
    ["Ghostlands"] = {icon = "FlagGB.tga", region = "EU"},
    ["GrimBatol"] = {icon = "FlagGB.tga", region = "EU"},
    ["Hakkar"] = {icon = "FlagGB.tga", region = "EU"},
    ["Haomarush"] = {icon = "FlagGB.tga", region = "EU"},
    ["Hellfire"] = {icon = "FlagGB.tga", region = "EU"},
    ["Hellscream"] = {icon = "FlagGB.tga", region = "EU"},
    ["Jaedenar"] = {icon = "FlagGB.tga", region = "EU"},
    ["Karazhan"] = {icon = "FlagGB.tga", region = "EU"},
    ["Kazzak"] = {icon = "FlagGB.tga", region = "EU"},
    ["Khadgar"] = {icon = "FlagGB.tga", region = "EU"},
    ["Kilrogg"] = {icon = "FlagGB.tga", region = "EU"},
    ["Kor'gall"] = {icon = "FlagGB.tga", region = "EU"},
    ["KulTiras"] = {icon = "FlagGB.tga", region = "EU"},
    ["LaughingSkull"] = {icon = "FlagGB.tga", region = "EU"},
    ["Lightbringer"] = {icon = "FlagGB.tga", region = "EU"},
    ["Lightning'sBlade"] = {icon = "FlagGB.tga", region = "EU"},
    ["Magtheridon"] = {icon = "FlagGB.tga", region = "EU"},
    ["Mazrigos"] = {icon = "FlagGB.tga", region = "EU"},
    ["Moonglade"] = {icon = "FlagGB.tga", region = "EU"},
    ["Nagrand"] = {icon = "FlagGB.tga", region = "EU"},
    ["Neptulon"] = {icon = "FlagGB.tga", region = "EU"},
    ["Nordrassil"] = {icon = "FlagGB.tga", region = "EU"},
    ["Outland"] = {icon = "FlagGB.tga", region = "EU"},
    ["Quel'Thalas"] = {icon = "FlagGB.tga", region = "EU"},
    ["Ragnaros"] = {icon = "FlagGB.tga", region = "EU"},
    ["Ravencrest"] = {icon = "FlagGB.tga", region = "EU"},
    ["Ravenholdt"] = {icon = "FlagGB.tga", region = "EU"},
    ["Runetotem"] = {icon = "FlagGB.tga", region = "EU"},
    ["Saurfang"] = {icon = "FlagGB.tga", region = "EU"},
    ["ScarshieldLegion"] = {icon = "FlagGB.tga", region = "EU"},
    ["Shadowsong"] = {icon = "FlagGB.tga", region = "EU"},
    ["ShatteredHalls"] = {icon = "FlagGB.tga", region = "EU"},
    ["ShatteredHand"] = {icon = "FlagGB.tga", region = "EU"},
    ["Silvermoon"] = {icon = "FlagGB.tga", region = "EU"},
    ["Skullcrusher"] = {icon = "FlagGB.tga", region = "EU"},
    ["Spinebreaker"] = {icon = "FlagGB.tga", region = "EU"},
    ["Sporeggar"] = {icon = "FlagGB.tga", region = "EU"},
    ["SteamwheedleCartel"] = {icon = "FlagGB.tga", region = "EU"},
    ["Stormrage"] = {icon = "FlagGB.tga", region = "EU"},
    ["Stormreaver"] = {icon = "FlagGB.tga", region = "EU"},
    ["Stormscale"] = {icon = "FlagGB.tga", region = "EU"},
    ["Sunstrider"] = {icon = "FlagGB.tga", region = "EU"},
    ["Sylvanas"] = {icon = "FlagGB.tga", region = "EU"},
    ["Talnivarr"] = {icon = "FlagGB.tga", region = "EU"},
    ["TarrenMill"] = {icon = "FlagGB.tga", region = "EU"},
    ["Terenas"] = {icon = "FlagGB.tga", region = "EU"},
    ["Terokkar"] = {icon = "FlagGB.tga", region = "EU"},
    ["TheMaelstrom"] = {icon = "FlagGB.tga", region = "EU"},
    ["TheSha'tar"] = {icon = "FlagGB.tga", region = "EU"},
    ["TheVentureCo"] = {icon = "FlagGB.tga", region = "EU"},
    ["Thunderhorn"] = {icon = "FlagGB.tga", region = "EU"},
    ["Trollbane"] = {icon = "FlagGB.tga", region = "EU"},
    ["Turalyon"] = {icon = "FlagGB.tga", region = "EU"},
    ["Twilight'sHammer"] = {icon = "FlagGB.tga", region = "EU"},
    ["TwistingNether"] = {icon = "FlagGB.tga", region = "EU"},
    ["Vashj"] = {icon = "FlagGB.tga", region = "EU"},
    ["Vek'nilash"] = {icon = "FlagGB.tga", region = "EU"},
    ["Wildhammer"] = {icon = "FlagGB.tga", region = "EU"},
    ["Xavius"] = {icon = "FlagGB.tga", region = "EU"},
    ["Zenedar"] = {icon = "FlagGB.tga", region = "EU"},

    -- [[ GERMAN (FlagDE.tga) ]] --
    ["Aegwynn"] = {icon = "FlagDE.tga", region = "Germany"},
    ["Alexstrasza"] = {icon = "FlagDE.tga", region = "Germany"},
    ["Alleria"] = {icon = "FlagDE.tga", region = "Germany"},
    ["Ambossar"] = {icon = "FlagDE.tga", region = "Germany"},
    ["Antonidas"] = {icon = "FlagDE.tga", region = "Germany"},
    ["Blackhand"] = {icon = "FlagDE.tga", region = "Germany"},
    ["Blackrock"] = {icon = "FlagDE.tga", region = "Germany"},
    ["DieAldor"] = {icon = "FlagDE.tga", region = "Germany"},
    ["Everlook"] = {icon = "FlagDE.tga", region = "Germany"},
    ["Thrall"] = {icon = "FlagDE.tga", region = "Germany"},
    ["Venoxis"] = {icon = "FlagDE.tga", region = "Germany"},

    -- [[ FRENCH (FlagFR.tga) ]] --
    ["Auberdine"] = {icon = "FlagFR.tga", region = "France"},
    ["Chantséternels"] = {icon = "FlagFR.tga", region = "France"},
    ["Dalaran"] = {icon = "FlagFR.tga", region = "France"},
    ["Hyjal"] = {icon = "FlagFR.tga", region = "France"},
    ["Suramar"] = {icon = "FlagFR.tga", region = "France"},
    ["Ysondre"] = {icon = "FlagFR.tga", region = "France"},

    -- [[ SPANISH (FlagES.tga) ]] --
    ["C'Thun"] = {icon = "FlagES.tga", region = "Spain"},
    ["ColinasPardas"] = {icon = "FlagES.tga", region = "Spain"},
    ["DunModr"] = {icon = "FlagES.tga", region = "Spain"},
    ["Exodar"] = {icon = "FlagES.tga", region = "Spain"},
    ["Mandokir"] = {icon = "FlagES.tga", region = "Spain"},
    ["Sanguino"] = {icon = "FlagES.tga", region = "Spain"},
    ["Tyrande"] = {icon = "FlagES.tga", region = "Spain"},

    -- [[ ITALIAN (FlagIT.tga) ]] --
    ["Nemesis"] = {icon = "FlagIT.tga", region = "Italy"},
    ["Pozzodell'Eternità"] = {icon = "FlagIT.tga", region = "Italy"},

    -- [[ PORTUGUESE (FlagPT.tga) ]] --
    ["Aggra"] = {icon = "FlagPT.tga", region = "Portugal"},

    -- Russian (FlagRU.tga)
    ["Ashenvale"] = {icon = "FlagRU.tga", region = "Russia"},
    ["Azuregos"] = {icon = "FlagRU.tga", region = "Russia"},
    ["BootyBay"] = {icon = "FlagRU.tga", region = "Russia"},
    ["Deathguard"] = {icon = "FlagRU.tga", region = "Russia"},
    ["Deepholm"] = {icon = "FlagRU.tga", region = "Russia"},
    ["Eversong"] = {icon = "FlagRU.tga", region = "Russia"},
    ["Galakrond"] = {icon = "FlagRU.tga", region = "Russia"},
    ["Goldrinn"] = {icon = "FlagRU.tga", region = "Russia"},
    ["Gordunni"] = {icon = "FlagRU.tga", region = "Russia"},
    ["HowlingFjord"] = {icon = "FlagRU.tga", region = "Russia"},
    ["LichKing"] = {icon = "FlagRU.tga", region = "Russia"},
    ["Razuvious"] = {icon = "FlagRU.tga", region = "Russia"},
    ["Soulflayer"] = {icon = "FlagRU.tga", region = "Russia"},
    ["Theradras"] = {icon = "FlagRU.tga", region = "Russia"},

    -- Anniversary / Classic EU Hubs
    ["Firemaw"] = {icon = "FlagGB.tga", region = "EU"},
    ["Gehennas"] = {icon = "FlagGB.tga", region = "EU"},
    ["Golemagg"] = {icon = "FlagGB.tga", region = "EU"},
    ["MirageRaceway"] = {icon = "FlagGB.tga", region = "EU"},
    ["Mograine"] = {icon = "FlagGB.tga", region = "EU"},
    ["Nek'Rosh"] = {icon = "FlagGB.tga", region = "EU"},
    ["PyrewoodVillage"] = {icon = "FlagGB.tga", region = "EU"},
    ["Soulseeker"] = {icon = "FlagGB.tga", region = "EU"},
    ["Spineshatter"] = {icon = "FlagGB.tga", region = "EU"},
    ["Stitches"] = {icon = "FlagGB.tga", region = "EU"},
    ["Thunderstrike"] = {icon = "FlagGB.tga", region = "EU"},
    ["WildGrowth"] = {icon = "FlagGB.tga", region = "EU"},
    ["ZandalarTribe"] = {icon = "FlagGB.tga", region = "EU"},

    -- Fallback
    ["DEFAULT_EU"] = {icon = "FlagGB.tga", region = "EU"}
}

-- [[ REGIONS 2, 4, 5: ASIA & CHINA ]] --
FriendGroups_RealmDataAsia = {
    -- China (RegionID: 5)
    ["AbyssalMaw"] = {icon = "FlagCN.tga", region = "China"},
    ["AeriePeakCN"] = {icon = "FlagCN.tga", region = "China"},
    ["Akil'zon"] = {icon = "FlagCN.tga", region = "China"},
    ["Algalon"] = {icon = "FlagCN.tga", region = "China"},
    ["Chronos"] = {icon = "FlagCN.tga", region = "China"},
    ["Goldshire"] = {icon = "FlagCN.tga", region = "China"},
    ["LichKing"] = {icon = "FlagCN.tga", region = "China"},
    ["Onyxia"] = {icon = "FlagCN.tga", region = "China"},
    ["SilverHand"] = {icon = "FlagCN.tga", region = "China"},
    ["SilvermoonCN"] = {icon = "FlagCN.tga", region = "China"},
    ["TitanReforged"] = {icon = "FlagCN.tga", region = "China"},

    -- Korea (RegionID: 2)
    ["Azshara"] = {icon = "FlagKR.tga", region = "Korea"},
    ["BurningLegion"] = {icon = "FlagKR.tga", region = "Korea"},
    ["Cenarius"] = {icon = "FlagKR.tga", region = "Korea"},
    ["Deathwing"] = {icon = "FlagKR.tga", region = "Korea"},
    ["Durotan"] = {icon = "FlagKR.tga", region = "Korea"},
    ["Frostmourne"] = {icon = "FlagKR.tga", region = "Korea"},
    ["Hellscream"] = {icon = "FlagKR.tga", region = "Korea"},
    ["Hyjal"] = {icon = "FlagKR.tga", region = "Korea"},
    ["Ragnaros"] = {icon = "FlagKR.tga", region = "Korea"},
    ["Windrunner"] = {icon = "FlagKR.tga", region = "Korea"},
    ["Zul'jin"] = {icon = "FlagKR.tga", region = "Korea"},

    -- Taiwan (RegionID: 4)
    ["Arthas"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["Arygos"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["BleedingHollow"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["ChillwindPoint"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["CrystalpineStinger"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["DemonFallCanyon"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["Dragonmaw"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["Frostmane"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["Global"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["Icecrown"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["KrolBlade"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["Light'sHope"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["Menethil"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["Nightsong"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["OldBlanchy"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["OrderoftheCloudSerpent"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["Quel'dorei"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["Shadowmoon"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["Skywall"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["Spirestone"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["Stormscale"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["WorldTree"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["Whisperwind"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["Wrathbringer"] = {icon = "FlagTW.tga", region = "Taiwan"},
    ["ZealotBlade"] = {icon = "FlagTW.tga", region = "Taiwan"}
}

local FGL = {}

-- [[ GUARD CLAUSE: STOP IF NOT CN ]] --
if GetLocale() == "zhCN" then
-- ============================================================================
-- [[ SETTINGS MENU HEADERS ]]
-- ============================================================================
FGL["SETTINGS_SIZE"]       = "列表大小"
FGL["SETTINGS_FILTER"]     = "过滤器"
FGL["SETTINGS_APPEARANCE"] = "外观"
FGL["SETTINGS_BEHAVIOR"]   = "行为"
FGL["SETTINGS_AUTOMATION"] = "自动化"
FGL["SETTINGS_RESET"]      = "|cffff0000重置为默认|r"

-- ============================================================================
-- [[ SETTINGS: SIZE ]]
-- ============================================================================
FGL["SET_SIZE_SMALL"]      = "小 (默认)"
FGL["SET_SIZE_MEDIUM"]     = "中"
FGL["SET_SIZE_LARGE"]      = "大"

-- ============================================================================
-- [[ SETTINGS: FILTERS ]]
-- ============================================================================
FGL["SET_HIDE_OFFLINE"]    = "隐藏离线"
FGL["SET_HIDE_AFK"]        = "隐藏暂离 (AFK)"
FGL["SET_MOBILE_AFK"]      = "将移动端标记为暂离"
FGL["SET_HIDE_EMPTY"]      = "隐藏空分组"
FGL["SET_INGAME_ONLY"]     = "仅显示游戏内好友"
FGL["SET_RETAIL_ONLY"]     = "仅显示正式服好友"

-- ============================================================================
-- [[ SETTINGS: APPEARANCE ]]
-- ============================================================================
FGL["SET_SHOW_FLAGS"]      = "显示服务器旗帜"
FGL["SET_SHOW_REALM"]      = "显示服务器名称"
FGL["SET_CLASS_COLOR"]     = "使用职业颜色"
FGL["SET_FACTION_ICONS"]   = "显示阵营图标"
FGL["SET_GRAY_FACTION"]    = "灰显对立阵营"
FGL["SET_SHOW_BTAG"]       = "仅显示战网昵称"
FGL["SET_HIDE_MAX_LEVEL"]  = "隐藏满级等级"

-- ============================================================================
-- [[ SETTINGS: BEHAVIOR ]]
-- ============================================================================
FGL["SET_FAV_GROUP"]       = "启用特别关注分组"
FGL["SET_COLLAPSE"]        = "自动折叠分组"

-- ============================================================================
-- [[ SETTINGS: AUTOMATION ]]
-- ============================================================================
FGL["SET_AUTO_ACCEPT"]     = "自动接受组队邀请"
FGL["SET_AUTO_PARTY_SYNC"] = "自动接受队伍同步"

-- ============================================================================
-- [[ CONTEXT MENUS ]]
-- ============================================================================
-- Group Header Right-Click
FGL["MENU_RENAME"]         = "重命名分组"
FGL["MENU_REMOVE"]         = "删除分组"
FGL["MENU_INVITE"]         = "邀请分组"
FGL["MENU_MAX_40"]         = " (最多 40)"

-- Friend Button Right-Click
FGL["DROP_TITLE"]          = "[好友分组]"
FGL["DROP_COPY_NAME"]      = "复制 名字-服务器"
FGL["DROP_COPY_BTAG"]      = "复制 战网昵称"
FGL["DROP_CREATE"]         = "新建分组"
FGL["DROP_ADD"]            = "添加到分组"
FGL["DROP_REMOVE"]         = "移出分组"
FGL["DROP_CANCEL"]         = "取消"

-- ============================================================================
-- [[ POPUPS & SYSTEM ]]
-- ============================================================================
FGL["POPUP_ENTER_NAME"]    = "输入新分组名称"
FGL["POPUP_COPY"]          = "按 Ctrl+C 复制:"

FGL["SEARCH_PLACEHOLDER"]  = "好友分组 搜索"
FGL["SEARCH_TOOLTIP"]      = "好友分组: 搜索任何人！名字、服务器、职业甚至备注"

FGL["MSG_WELCOME"]         = "版本 %s 已由 Osiris the Kiwi 为补丁 12.0 更新"
FGL["MSG_RESET"]           = "|cFF33FF99[好友分组]|r: 设置已重置为默认。"
FGL["MSG_BUG_WARNING"]     = "|cFF33FF99[好友分组]|r: 检测到 Bnet API 错误。好友列表为空是魔兽客户端的 Bug 导致的。请尝试重启游戏。(无法保证修复)"

-- ============================================================================
-- [[ SPECIAL GROUP NAMES ]]
-- ============================================================================
FGL["GROUP_FAVORITES"]     = "[特别关注]"
FGL["GROUP_NONE"]          = "[2ui]"
FGL["GROUP_EMPTY"]         = "好友列表为空"
FGL["STATUS_MOBILE"]       = "移动端"

-- ============================================================================
-- [[ HOUSING / SAFE MODE ]]
-- ============================================================================
FGL["RELOAD_BTN_TEXT"]      = "重载 [好友分组]"
FGL["RELOAD_TOOLTIP_TITLE"] = "重载 [好友分组]"
FGL["RELOAD_TOOLTIP_DESC"]  = "重载界面以恢复 [好友分组]。"

FGL["SHIELD_MSG"]           = "|cffFF0000[好友分组] 已激活|r\n\n由于暴雪安全框架限制，\n你需要重载界面才能查看房屋。"
FGL["SHIELD_BTN_TEXT"]      = "重载以查看房屋"
FGL["SAFE_MODE_WARNING"]    = "|cffFF0000房屋:|r [好友分组] 已禁用以查看房屋。重载以启用。"


-- [[ GUARD CLAUSE: STOP IF NOT TW ]] --
elseif GetLocale() == "zhTW" then

-- ============================================================================
-- [[ SETTINGS MENU HEADERS ]]
-- ============================================================================
FGL["SETTINGS_SIZE"]       = "列表大小"
FGL["SETTINGS_FILTER"]     = "過濾"
FGL["SETTINGS_APPEARANCE"] = "外觀"
FGL["SETTINGS_BEHAVIOR"]   = "行為"
FGL["SETTINGS_AUTOMATION"] = "自動化"
FGL["SETTINGS_RESET"]      = "|cffff0000重置為預設值|r"

-- ============================================================================
-- [[ SETTINGS: SIZE ]]
-- ============================================================================
FGL["SET_SIZE_SMALL"]      = "小 (預設)"
FGL["SET_SIZE_MEDIUM"]     = "中"
FGL["SET_SIZE_LARGE"]      = "大"

-- ============================================================================
-- [[ SETTINGS: FILTERS ]]
-- ============================================================================
FGL["SET_HIDE_OFFLINE"]    = "隱藏離線"
FGL["SET_HIDE_AFK"]        = "隱藏暫離 (AFK)"
FGL["SET_MOBILE_AFK"]      = "標記手機為暫離"
FGL["SET_HIDE_EMPTY"]      = "隱藏空群組"
FGL["SET_INGAME_ONLY"]     = "僅顯示遊戲內好友"
FGL["SET_RETAIL_ONLY"]     = "僅顯示正式服好友"

-- ============================================================================
-- [[ SETTINGS: APPEARANCE ]]
-- ============================================================================
FGL["SET_SHOW_FLAGS"]      = "顯示伺服器旗幟"
FGL["SET_SHOW_REALM"]      = "顯示伺服器名稱"
FGL["SET_CLASS_COLOR"]     = "使用職業顏色"
FGL["SET_FACTION_ICONS"]   = "顯示陣營圖示"
FGL["SET_GRAY_FACTION"]    = "灰顯對立陣營"
FGL["SET_SHOW_BTAG"]       = "僅顯示 BattleTag"
FGL["SET_HIDE_MAX_LEVEL"]  = "隱藏滿級等級"

-- ============================================================================
-- [[ SETTINGS: BEHAVIOR ]]
-- ============================================================================
FGL["SET_FAV_GROUP"]       = "啟用最愛群組"
FGL["SET_COLLAPSE"]        = "自動折疊群組"

-- ============================================================================
-- [[ SETTINGS: AUTOMATION ]]
-- ============================================================================
FGL["SET_AUTO_ACCEPT"]     = "自動接受組隊邀請"
FGL["SET_AUTO_PARTY_SYNC"] = "自動接受隊伍同步"

-- ============================================================================
-- [[ CONTEXT MENUS ]]
-- ============================================================================
-- Group Header Right-Click
FGL["MENU_RENAME"]         = "重新命名群組"
FGL["MENU_REMOVE"]         = "移除群組"
FGL["MENU_INVITE"]         = "邀請群組"
FGL["MENU_MAX_40"]         = " (上限 40)"

-- Friend Button Right-Click
FGL["DROP_TITLE"]          = "FriendGroups"
FGL["DROP_COPY_NAME"]      = "複製 名字-伺服器"
FGL["DROP_COPY_BTAG"]      = "複製 BattleTag"
FGL["DROP_CREATE"]         = "建立新群組"
FGL["DROP_ADD"]            = "加入群組"
FGL["DROP_REMOVE"]         = "移出群組"
FGL["DROP_CANCEL"]         = "取消"

-- ============================================================================
-- [[ POPUPS & SYSTEM ]]
-- ============================================================================
FGL["POPUP_ENTER_NAME"]    = "輸入新群組名稱"
FGL["POPUP_COPY"]          = "按 Ctrl+C 複製:"

FGL["SEARCH_PLACEHOLDER"]  = "搜尋 FriendGroups"
FGL["SEARCH_TOOLTIP"]      = "FriendGroups: 搜尋任何人！名字、伺服器、職業甚至備註"

FGL["MSG_WELCOME"]         = "版本 %s 已由 Osiris the Kiwi 為更新檔 12.0 更新"
FGL["MSG_RESET"]           = "|cFF33FF99FriendGroups|r: 設定已重置為預設值。"
FGL["MSG_BUG_WARNING"]     = "|cFF33FF99FriendGroups|r: 偵測到 Bnet API 錯誤。好友列表是空的可能是魔獸客戶端錯誤導致。請嘗試重新啟動遊戲。(無法保證修復)"

-- ============================================================================
-- [[ SPECIAL GROUP NAMES ]]
-- ============================================================================
FGL["GROUP_FAVORITES"]     = "[最愛]"
FGL["GROUP_NONE"]          = "[2ui]"
FGL["GROUP_EMPTY"]         = "好友列表是空的"
FGL["STATUS_MOBILE"]       = "手機"

-- ============================================================================
-- [[ HOUSING / SAFE MODE ]]
-- ============================================================================
FGL["RELOAD_BTN_TEXT"]      = "重載 FriendGroups"
FGL["RELOAD_TOOLTIP_TITLE"] = "重載 FriendGroups"
FGL["RELOAD_TOOLTIP_DESC"]  = "重載介面以還原 FriendGroups。"

FGL["SHIELD_MSG"]           = "|cffFF0000FriendGroups 已啟用|r\n\n由於暴雪安全框架限制，\n你需要重載介面才能檢視房屋。"
FGL["SHIELD_BTN_TEXT"]      = "重載以檢視房屋"
FGL["SAFE_MODE_WARNING"]    = "|cffFF0000房屋:|r FriendGroups 已停用以檢視房屋。重載以啟用。"

else
-- ============================================================================
-- [[ SETTINGS MENU HEADERS ]]
-- ============================================================================
FGL["SETTINGS_SIZE"]       = "Contact List Size"
FGL["SETTINGS_FILTER"]     = "Filter"
FGL["SETTINGS_APPEARANCE"] = "Appearance"
FGL["SETTINGS_BEHAVIOR"]   = "Group Behavior"
FGL["SETTINGS_AUTOMATION"] = "Automation"
FGL["SETTINGS_RESET"]      = "|cffff0000Reset to Default|r"

-- ============================================================================
-- [[ SETTINGS: SIZE ]]
-- ============================================================================
FGL["SET_SIZE_SMALL"]      = "Small (WoW Default)"
FGL["SET_SIZE_MEDIUM"]     = "Medium"
FGL["SET_SIZE_LARGE"]      = "Large"

-- ============================================================================
-- [[ SETTINGS: FILTERS ]]
-- ============================================================================
FGL["SET_HIDE_OFFLINE"]    = "Hide All Offline"
FGL["SET_HIDE_AFK"]        = "Hide All AFK"
FGL["SET_MOBILE_AFK"]      = "Mark Mobile As AFK"
FGL["SET_HIDE_EMPTY"]      = "Hide Empty Groups"
FGL["SET_INGAME_ONLY"]     = "Show Only In-Game Friends"
FGL["SET_RETAIL_ONLY"]     = "Show Only Retail Friends"

-- ============================================================================
-- [[ SETTINGS: APPEARANCE ]]
-- ============================================================================
FGL["SET_SHOW_FLAGS"]      = "Show Realm Flags"
FGL["SET_SHOW_REALM"]      = "Show Realm Names"
FGL["SET_CLASS_COLOR"]     = "Use Class Color Names"
FGL["SET_FACTION_ICONS"]   = "Show Faction Icons"
FGL["SET_GRAY_FACTION"]    = "Dim Opposing Faction"
FGL["SET_SHOW_BTAG"]       = "Show Only BattleTag"
FGL["SET_HIDE_MAX_LEVEL"]  = "Hide Max Level"

-- ============================================================================
-- [[ SETTINGS: BEHAVIOR ]]
-- ============================================================================
FGL["SET_FAV_GROUP"]       = "Enable Favorite Friends Group"
FGL["SET_COLLAPSE"]        = "Auto Collapse Groups"

-- ============================================================================
-- [[ SETTINGS: AUTOMATION ]]
-- ============================================================================
FGL["SET_AUTO_ACCEPT"]     = "Auto Accept Group Invite"
FGL["SET_AUTO_PARTY_SYNC"] = "Auto Accept Party Sync"

-- ============================================================================
-- [[ CONTEXT MENUS ]]
-- ============================================================================
-- Group Header Right-Click
FGL["MENU_RENAME"]         = "Rename Group"
FGL["MENU_REMOVE"]         = "Remove Group"
FGL["MENU_INVITE"]         = "Invite Group to Party"
FGL["MENU_MAX_40"]         = " (Max 40)"

-- Friend Button Right-Click
FGL["DROP_TITLE"]          = "FriendGroups"
FGL["DROP_COPY_NAME"]      = "Copy Name-Realm"
FGL["DROP_COPY_BTAG"]      = "Copy BattleTag"
FGL["DROP_CREATE"]         = "Create New Group"
FGL["DROP_ADD"]            = "Add to Group"
FGL["DROP_REMOVE"]         = "Remove from Group"
FGL["DROP_CANCEL"]         = "Cancel"

-- ============================================================================
-- [[ POPUPS & SYSTEM ]]
-- ============================================================================
FGL["POPUP_ENTER_NAME"]    = "Enter new group name"
FGL["POPUP_COPY"]          = "Press Ctrl+C to copy:"

FGL["SEARCH_PLACEHOLDER"]  = "FriendGroups Search"
FGL["SEARCH_TOOLTIP"]      = "FriendGroups: Search for anyone! Name, Realm, Class and even Notes"

FGL["MSG_WELCOME"]         = "Version %s updated for patch 12.0 by Osiris the Kiwi"
FGL["MSG_RESET"]           = "|cFF33FF99FriendGroups|r: Settings reset to default."
FGL["MSG_BUG_WARNING"]     = "|cFF33FF99FriendGroups|r: Bnet API Bug detected. Your empty Friends List is caused by a WoW Client Bug. Please try to restart your game. (no guaranteed fix)"

-- ============================================================================
-- [[ SPECIAL GROUP NAMES ]]
-- ============================================================================
FGL["GROUP_FAVORITES"]     = "[Favorites]"
FGL["GROUP_NONE"]          = "[2ui]"
FGL["GROUP_EMPTY"]         = "Friends List is empty"
FGL["STATUS_MOBILE"]       = "Mobile"

-- ============================================================================
-- [[ HOUSING / SAFE MODE ]]
-- ============================================================================
FGL["RELOAD_BTN_TEXT"]      = "Reload FriendGroups"
FGL["RELOAD_TOOLTIP_TITLE"] = "Reload FriendGroups"
FGL["RELOAD_TOOLTIP_DESC"]  = "Reloads the UI to restore FriendGroups."

FGL["SHIELD_MSG"]           = "|cffFF0000FriendGroups is Active|r\n\nDue to Blizzard Secure Frame restrictions,\nyou must reload to View Houses."
FGL["SHIELD_BTN_TEXT"]      = "Reload to View Houses"
FGL["SAFE_MODE_WARNING"]    = "|cffFF0000VIEW HOUSES:|r FriendGroups disabled to View Houses. Reload to enable."
end

-- [[ STATE MANAGEMENT ]] --
local FriendGroups_Loaded = false 

-- [[ FORWARD DECLARATIONS ]] --
local EnableFriendGroups
local FriendGroups_FriendsListUpdate
local FriendGroups_FriendsListUpdateFriendButton
local FriendGroups_FriendsListButtonTemplateClick

local ADDON_CHAT_PREFIX = "|cffFFE400[|r|cff3AFF00" .. "FriendGroups" .. "|r|cffFFE400]|r"
local function Print(...)
    local str = ADDON_CHAT_PREFIX .. "|cff00F7FF "
    local count = select("#", ...)
    for i = 1, count do
        str = str .. tostring(select(i, ...))
        if i < count then
            str = str .. " "
        end
    end
    DEFAULT_CHAT_FRAME:AddMessage(str .. "|r")
end

local playerRealmID = GetRealmID();
local playerFactionGroup = UnitFactionGroup("player");
local INVITE_RESTRICTION_NONE = 9
local groupsTotal = {}
local groupsSorted = {}
local groupsCount = {}
local expansionMaxLevel = {}
local friendsListEmpty = false
local searchBoxInit = false
local lastFriendsListEmptyWarning = 0
local currentExpansionMaxLevel, FriendGroups_Menu, FriendGroupsFrame, searchOpened
local searchValue = ""
local FriendGroups_SearchBox

-- Data for the Custom Menu
local FriendGroups_ClickedData = {}

local groupMenuItems = {
    { text = "",         notCheckable = true, isTitle = true },
    {
        text = FGL["MENU_RENAME"],
        notCheckable = true,
        func = function(self, groupName)
            StaticPopup_Show("FRIENDGROUPS_RENAME", nil, nil, groupName)
        end
    },
    {
        text = FGL["MENU_REMOVE"],
        notCheckable = true,
        func = function(self, groupName)
            FriendGroups_InviteOrGroup(groupName, false)
        end
    },
    {
        text = FGL["MENU_INVITE"],
        notCheckable = true,
        func = function(self, groupName)
            FriendGroups_InviteOrGroup(groupName, true)
        end
    },
}

local settingsMenuItems = {
    -- SECTION 0: SIZE
    { text = FGL["SETTINGS_SIZE"], notCheckable = true, isTitle = true },
    {
        text = FGL["SET_SIZE_SMALL"],
        checked = function() return (ShiGuangDB.FriendGroupsextra_height or 0) == 0 end,
        func = function()
            ShiGuangDB.FriendGroupsextra_height = 0
            FriendGroups_UpdateSize()
        end
    },
    {
        text = FGL["SET_SIZE_MEDIUM"],
        checked = function() return (ShiGuangDB.FriendGroupsextra_height or 0) == 190 end,
        func = function()
            ShiGuangDB.FriendGroupsextra_height = 190
            FriendGroups_UpdateSize()
        end
    },
    {
        text = FGL["SET_SIZE_LARGE"],
        checked = function() return (ShiGuangDB.FriendGroupsextra_height or 0) == 380 end,
        func = function()
            ShiGuangDB.FriendGroupsextra_height = 380
            FriendGroups_UpdateSize()
        end
    },

    -- SECTION 1: FILTERS
    { text = FGL["SETTINGS_FILTER"],    notCheckable = true, isTitle = true },
    {
        text = FGL["SET_HIDE_OFFLINE"],
        keepShownOnClick = true, 
        checked = function() return ShiGuangDB.FriendGroupshide_offline end,
        func = function()
            ShiGuangDB.FriendGroupshide_offline = not ShiGuangDB.FriendGroupshide_offline
            FriendGroups_FriendsListUpdate()
        end
    },
    {
        text = FGL["SET_HIDE_AFK"],
        keepShownOnClick = true,
        checked = function() return ShiGuangDB.FriendGroupshide_afk end,
        func = function()
            ShiGuangDB.FriendGroupshide_afk = not ShiGuangDB.FriendGroupshide_afk
            FriendGroups_FriendsListUpdate()
        end
    },
    -- [[ MOVED HERE: Mobile AFK ]] --
    {
        text = FGL["SET_MOBILE_AFK"],
        keepShownOnClick = true,
        checked = function() return ShiGuangDB.FriendGroupsshow_mobile_afk end,
        func = function()
            ShiGuangDB.FriendGroupsshow_mobile_afk = not ShiGuangDB.FriendGroupsshow_mobile_afk
            FriendGroups_FriendsListUpdate()
        end
    },
    {
        text = FGL["SET_HIDE_EMPTY"],
        keepShownOnClick = true,
        checked = function() return ShiGuangDB.FriendGroupshide_empty_groups end,
        func = function()
            ShiGuangDB.FriendGroupshide_empty_groups = not ShiGuangDB.FriendGroupshide_empty_groups
            FriendGroups_FriendsListUpdate()
        end
    },
    {
        text = FGL["SET_INGAME_ONLY"],
        keepShownOnClick = true,
        checked = function() return ShiGuangDB.FriendGroupsingame_only end,
        func = function()
            ShiGuangDB.FriendGroupsingame_only = not ShiGuangDB.FriendGroupsingame_only
            FriendGroups_FriendsListUpdate()
        end
    },
    {
        text = FGL["SET_RETAIL_ONLY"],
        keepShownOnClick = true,
        checked = function() return ShiGuangDB.FriendGroupsshow_retail end,
        func = function()
            ShiGuangDB.FriendGroupsshow_retail = not ShiGuangDB.FriendGroupsshow_retail
            FriendGroups_FriendsListUpdate()
        end
    },

    -- SECTION 2: APPEARANCE
    { text = FGL["SETTINGS_APPEARANCE"], notCheckable = true, isTitle = true },
    {
        text = FGL["SET_SHOW_FLAGS"],
        keepShownOnClick = true,
        checked = function() return ShiGuangDB.FriendGroupsshow_flags end,
        func = function()
            ShiGuangDB.FriendGroupsshow_flags = not ShiGuangDB.FriendGroupsshow_flags
            FriendGroups_FriendsListUpdate()
        end
    },
    {
        text = FGL["SET_SHOW_REALM"],
        keepShownOnClick = true,
        checked = function() return ShiGuangDB.FriendGroupsshow_realm end,
        func = function()
            ShiGuangDB.FriendGroupsshow_realm = not ShiGuangDB.FriendGroupsshow_realm
            FriendGroups_FriendsListUpdate()
        end
    },
    {
        text = FGL["SET_CLASS_COLOR"],
        keepShownOnClick = true,
        checked = function() return ShiGuangDB.FriendGroupscolour_classes end,
        func = function()
            ShiGuangDB.FriendGroupscolour_classes = not ShiGuangDB.FriendGroupscolour_classes
            FriendGroups_FriendsListUpdate()
        end
    },
    {
        text = FGL["SET_FACTION_ICONS"],
        keepShownOnClick = true,
        checked = function() return ShiGuangDB.FriendGroupsshow_faction_icons end,
        func = function()
            ShiGuangDB.FriendGroupsshow_faction_icons = not ShiGuangDB.FriendGroupsshow_faction_icons
            FriendGroups_FriendsListUpdate()
        end
    },
    {
        text = FGL["SET_GRAY_FACTION"],
        keepShownOnClick = true,
        checked = function() return ShiGuangDB.FriendGroupsgray_faction end,
        func = function()
            ShiGuangDB.FriendGroupsgray_faction = not ShiGuangDB.FriendGroupsgray_faction
            FriendGroups_FriendsListUpdate()
        end
    },
    {
        text = FGL["SET_SHOW_BTAG"],
        keepShownOnClick = true,
        checked = function() return ShiGuangDB.FriendGroupsshow_btag end,
        func = function()
            ShiGuangDB.FriendGroupsshow_btag = not ShiGuangDB.FriendGroupsshow_btag
            FriendGroups_FriendsListUpdate()
        end
    },
    {
        text = FGL["SET_HIDE_MAX_LEVEL"],
        keepShownOnClick = true,
        checked = function() return ShiGuangDB.FriendGroupshide_high_level end,
        func = function()
            ShiGuangDB.FriendGroupshide_high_level = not ShiGuangDB.FriendGroupshide_high_level
            FriendGroups_FriendsListUpdate()
        end
    },

    -- SECTION 3: GROUP SETTINGS
    { text = FGL["SETTINGS_BEHAVIOR"], notCheckable = true, isTitle = true },
    {
        text = FGL["SET_FAV_GROUP"],
        keepShownOnClick = true,
        checked = function() return ShiGuangDB.FriendGroupsadd_favorite_group end,
        func = function()
            ShiGuangDB.FriendGroupsadd_favorite_group = not ShiGuangDB.FriendGroupsadd_favorite_group
            FriendGroups_FriendsListUpdate()
        end
    },
    {
        text = FGL["SET_COLLAPSE"],
        keepShownOnClick = true,
        checked = function() return ShiGuangDB.FriendGroupsopen_one_group end,
        func = function()
            ShiGuangDB.FriendGroupsopen_one_group = not ShiGuangDB.FriendGroupsopen_one_group
            FriendGroups_FriendsListUpdate()
        end
    },

    -- SECTION 4: AUTOMATION
    { text = FGL["SETTINGS_AUTOMATION"], notCheckable = true, isTitle = true },
    {
        text = FGL["SET_AUTO_ACCEPT"],
        keepShownOnClick = true,
        checked = function() return ShiGuangDB.FriendGroupsauto_accept_invite end,
        func = function()
            ShiGuangDB.FriendGroupsauto_accept_invite = not ShiGuangDB.FriendGroupsauto_accept_invite
            FriendGroups_FriendsListUpdate()
        end
    },
    {
        text = FGL["SET_AUTO_PARTY_SYNC"],
        keepShownOnClick = true,
        checked = function() return ShiGuangDB.FriendGroupsauto_accept_sync end,
        func = function()
            ShiGuangDB.FriendGroupsauto_accept_sync = not ShiGuangDB.FriendGroupsauto_accept_sync
            FriendGroups_FriendsListUpdate()
        end
    },

    -- SECTION 5: RESET
    { text = "", notCheckable = true, isTitle = true },
    {
        text = FGL["SETTINGS_RESET"],
        notCheckable = true,
        func = function()
            CloseDropDownMenus()
            -- 1. Reset all variables to the default
		
            ShiGuangDB.FriendGroupshide_offline = true
            ShiGuangDB.FriendGroupscolour_classes = true
            ShiGuangDB.FriendGroupsshow_faction_icons = true
            ShiGuangDB.FriendGroupsshow_realm = true
            ShiGuangDB.FriendGroupshide_high_level = false
            ShiGuangDB.FriendGroupsadd_favorite_group = true
            ShiGuangDB.FriendGroupssort_by_status = true
            ShiGuangDB.FriendGroupsshow_flags = true
            
            ShiGuangDB.FriendGroupsgray_faction = false
            ShiGuangDB.FriendGroupsshow_mobile_afk = false
            ShiGuangDB.FriendGroupsadd_mobile_text = true
            ShiGuangDB.FriendGroupsingame_only = false
            ShiGuangDB.FriendGroupsingame_retail = false
            ShiGuangDB.FriendGroupsshow_btag = false
            ShiGuangDB.FriendGroupsshow_retail = false
            ShiGuangDB.FriendGroupsshow_search = false
            ShiGuangDB.FriendGroupshide_empty_groups = true
            ShiGuangDB.FriendGroupshide_afk = false
            ShiGuangDB.FriendGroupsopen_one_group = false
            
            ShiGuangDB.FriendGroupsauto_accept_invite = false
            ShiGuangDB.FriendGroupsauto_accept_sync = false
            
            ShiGuangDB.FriendGroupsextra_height = 190 
            ShiGuangDB.FriendGroupscollapsed = {}
            
            -- Apply Reset
            FriendGroups_UpdateSize()
            FriendGroups_FriendsListUpdate()
            
            print(FGL["MSG_RESET"])
        end
    },
}

--[[
	Init Values
]] --

-- Expansion Max Level
expansionMaxLevel[LE_EXPANSION_CLASSIC] = 60
expansionMaxLevel[LE_EXPANSION_BURNING_CRUSADE] = 70
expansionMaxLevel[LE_EXPANSION_WRATH_OF_THE_LICH_KING] = 80
expansionMaxLevel[LE_EXPANSION_CATACLYSM] = 85
expansionMaxLevel[LE_EXPANSION_MISTS_OF_PANDARIA] = 90
expansionMaxLevel[LE_EXPANSION_WARLORDS_OF_DRAENOR] = 100
expansionMaxLevel[LE_EXPANSION_LEGION] = 110
expansionMaxLevel[LE_EXPANSION_BATTLE_FOR_AZEROTH] = 120
expansionMaxLevel[LE_EXPANSION_SHADOWLANDS] = 60
expansionMaxLevel[LE_EXPANSION_DRAGONFLIGHT] = 70
expansionMaxLevel[LE_EXPANSION_WAR_WITHIN] = 80
expansionMaxLevel[LE_EXPANSION_WAR_WITHIN + 1] = 90 -- Midnight Pre-Patch Support

currentExpansionMaxLevel = expansionMaxLevel[GetExpansionLevel()]

--[[
	Helper Functions
]] --

local FriendGroups_OriginalHeight = nil
local FriendGroupsList_OriginalHeight = nil

function FriendGroups_UpdateSize()
    -- 1. Store the original Blizzard defaults the very first time we run
    if not FriendGroups_OriginalHeight then
        FriendGroups_OriginalHeight = FriendsFrame:GetHeight()
        FriendGroupsList_OriginalHeight = FriendsListFrame:GetHeight()
    end

    -- 2. Determine target height based on saved variable
    local extra = ShiGuangDB.FriendGroupsextra_height or 0

    -- 3. Apply
    FriendsFrame:SetHeight(FriendGroups_OriginalHeight + extra)
    FriendsListFrame:SetHeight(FriendGroupsList_OriginalHeight + extra)

    -- 4. Re-anchor ScrollBox to fill the new space
    FriendsListFrame.ScrollBox:ClearAllPoints()
    FriendsListFrame.ScrollBox:SetPoint("TOPLEFT", FriendsListFrame, "TOPLEFT", 7, -115)
    FriendsListFrame.ScrollBox:SetPoint("BOTTOMRIGHT", FriendsListFrame, "BOTTOMRIGHT", -28, 35)
end

function FriendGroups_Rename(self, oldGroup)
	local input = self:GetEditBox():GetText()
    
    -- Safety Check
	if input == "" or not oldGroup then
		return
	end

	local groups = {}
	for i = 1, BNGetNumFriends() do
		local presenceID = C_BattleNet.GetFriendAccountInfo(i).bnetAccountID
		local noteText = C_BattleNet.GetFriendAccountInfo(i).note
		local note = FriendGroups_NoteAndGroups(noteText, groups)
		if groups[oldGroup] then
			groups[oldGroup] = nil
			groups[input] = true
			note = FriendGroups_CreateNote(note, groups)
			BNSetFriendNote(presenceID, note)
		end
	end
	for i = 1, C_FriendList.GetNumFriends() do
		local note = C_FriendList.GetFriendInfoByIndex(i).notes
		local name = C_FriendList.GetFriendInfoByIndex(i).name
		note = FriendGroups_NoteAndGroups(note, groups)

		if groups[oldGroup] then
			groups[oldGroup] = nil
			groups[input] = true
			note = FriendGroups_CreateNote(note, groups)
			C_FriendList.SetFriendNotes(name, note)
		end
	end
	FriendGroups_FriendsListUpdate()
end

function FriendGroups_InviteOrGroup(groupName, invite)
	local groups = {}

	for i = 1, BNGetNumFriends() do
		local friendAccountInfo = C_BattleNet.GetFriendAccountInfo(i)
		local gameAccountInfo = friendAccountInfo.gameAccountInfo
		local presenceID = friendAccountInfo.bnetAccountID
		local noteText = friendAccountInfo.note
		local note = FriendGroups_NoteAndGroups(noteText, groups)
		if groups[groupName] then
			if invite and gameAccountInfo and gameAccountInfo.gameAccountID then
				BNInviteFriend(gameAccountInfo.gameAccountID)
			elseif not invite then
				groups[groupName] = nil
				note = FriendGroups_CreateNote(note, groups)
				BNSetFriendNote(presenceID, note)
			end
		end
	end
	for i = 1, C_FriendList.GetNumFriends() do
		local friend_info = C_FriendList.GetFriendInfoByIndex(i)
		local name = friend_info.name
		local connected = friend_info.connected
		local noteText = friend_info.notes
		local note = FriendGroups_NoteAndGroups(noteText, groups)

		if groups[groupName] then
			if invite and connected then
				C_PartyInfo.InviteUnit(name)
			elseif not invite then
				groups[groupName] = nil
				note = FriendGroups_CreateNote(note, groups)
				C_FriendList.SetFriendNotes(name, note)
			end
		end
	end
end

function FriendGroups_AddGroup(note, group)
	local groups = {}
	note = FriendGroups_NoteAndGroups(note, groups)
	groups[""] = nil
	groups[group] = true
	return FriendGroups_CreateNote(note, groups)
end

function FriendGroups_Create(self, data)
	local input = self:GetEditBox():GetText()
	if input == "" then
		return
	end
	local note = FriendGroups_AddGroup(data.note, input)
	if data.name then
		data.set(data.name, note)
	else
		data.set(data.id, note)

		ShiGuangDB.FriendGroupscollapsed[input] = true
	end
end

function FriendGroups_NoteAndGroups(note, groups)
	if not note then
		return FriendGroups_FillGroups(groups, "")
	end
	if groups then
		return FriendGroups_FillGroups(groups, strsplit("#", note))
	end
	return strsplit("#", note)
end

function FriendGroups_RemoveGroup(note, group)
	local groups = {}
	note = FriendGroups_NoteAndGroups(note, groups)
	groups[""] = nil
	groups[group] = nil

	return FriendGroups_CreateNote(note, groups)
end

function FriendGroups_CreateNote(note, groups)
	local value = ""
	if note then
		value = note
	end
	for group in pairs(groups) do
		value = value .. "#" .. group
	end
	return value
end

function FriendGroups_FillGroups(groups, note, ...)
	wipe(groups)
	local n = select('#', ...)
	for i = 1, n do
		local v = select(i, ...)
		v = strtrim(v)
		groups[v] = true
	end
	if n == 0 then
		groups[""] = true
	end
	return note
end

function FriendGroups_HasValue(tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

function FriendGroups_AddDropDownNew(ownerRegion, rootDescription, contextData)
	local bnetfriend = nil
	local note = ""

	if contextData.which == "BN_FRIEND" or contextData.which == "BN_FRIEND_OFFLINE" then
		bnetfriend = true
	else
		bnetfriend = false
	end

	local accountInfo = FriendGroups_GetInfoByName(contextData.name, bnetfriend)
	
	if accountInfo then
	
		if bnetfriend then
			note = accountInfo.note
		else
			note = accountInfo.notes
		end

		local groups = FriendGroups_GetPlayerGroups(note)

		rootDescription:CreateDivider()
		--rootDescription:CreateTitle(FGL["DROP_TITLE"])

		-- [[ OPTION 1: Copy Name-Realm ]] --
		rootDescription:CreateButton(FGL["DROP_COPY_NAME"], function(data)
			local textToCopy = ""
			if data.bnetfriend then
				local info = C_BattleNet.GetAccountInfoByID(accountInfo.bnetAccountID)
				if info and info.gameAccountInfo and info.gameAccountInfo.characterName then
					local char = info.gameAccountInfo.characterName
					local realm = info.gameAccountInfo.realmName
					local richPresence = info.gameAccountInfo.richPresence
					local friendProject = info.gameAccountInfo.wowProjectID
					local myProject = WOW_PROJECT_ID

					-- 1. Try standard realm display name
					if not realm or realm == "" then
						realm = info.gameAccountInfo.realmDisplayName
					end

					-- 2. Try parsing Rich Presence (Critical for Classic friends viewed from Retail)
					if (not realm or realm == "") and richPresence then
						local extraction = richPresence:match("%s%-%s(.+)")
						if extraction then
							realm = extraction
						end
					end

					-- 3. Fallback: Use Player's Realm ONLY if they are on the SAME Project
					if (not realm or realm == "") and info.gameAccountInfo.clientProgram == BNET_CLIENT_WOW then
						if friendProject == myProject then
							realm = GetRealmName()
						end
					end

					if realm and realm ~= "" then
						realm = realm:gsub("%s+", "") 
						textToCopy = char .. "-" .. realm
					else
						textToCopy = char
					end
				elseif info and info.battleTag then
					-- Fallback to BTag if no character found (e.g. Offline)
					textToCopy = info.battleTag
				end
			else
				-- Standard WoW Friend
				textToCopy = contextData.name
				if textToCopy and textToCopy ~= "" and not string.find(textToCopy, "-") then
					local myRealm = GetRealmName()
					if myRealm then
						textToCopy = textToCopy .. "-" .. myRealm:gsub("%s+", "")
					end
				end
			end

			if textToCopy and textToCopy ~= "" then
				local dialog = StaticPopup_Show("FRIENDGROUPS_COPY_POPUP")
				if dialog and dialog.EditBox then
					dialog.EditBox:SetText(textToCopy)
					dialog.EditBox:HighlightText()
					dialog.EditBox:SetFocus()
				end
			end
		end, { name = contextData.name, bnetfriend = bnetfriend })

		-- [[ OPTION 2: Copy BattleTag (NEW) ]] --
		if bnetfriend then
			rootDescription:CreateButton(FGL["DROP_COPY_BTAG"], function(data)
				local info = C_BattleNet.GetAccountInfoByID(accountInfo.bnetAccountID)
				if info and info.battleTag then
					local dialog = StaticPopup_Show("FRIENDGROUPS_COPY_POPUP")
					if dialog and dialog.EditBox then
						dialog.EditBox:SetText(info.battleTag)
						dialog.EditBox:HighlightText()
						dialog.EditBox:SetFocus()
					end
				end
			end)
		end

		-- [[ OPTION 3: Create New Group ]] --
		rootDescription:CreateButton(FGL["DROP_CREATE"], function(data)
			FriendGroups_CreateNewGroup(data.name, data.bnetfriend)
		end, { name = contextData.name, bnetfriend = bnetfriend })

		-- [[ OPTION 4: Add to Group ]] --
		local add = rootDescription:CreateButton(FGL["DROP_ADD"])

		for _, group in ipairs(groupsSorted) do
			if not FriendGroups_HasValue(groups, group) and not (group == "") and not (group == FGL["GROUP_FAVORITES"]) and not (group == FGL["GROUP_EMPTY"]) and not (group == FGL["GROUP_NONE"]) then
				add:CreateButton(group, function(data)
					local note = data.note
					local group = data.group

					note = FriendGroups_AddGroup(note, group)
					if bnetfriend then
						BNSetFriendNote(accountInfo.bnetAccountID, note)
					else
						C_FriendList.SetFriendNotes(contextData.name, note)
					end
				end, { group = group, note = note })
			end
		end

		-- [[ OPTION 5: Remove from Group ]] --
		local remove = rootDescription:CreateButton(FGL["DROP_REMOVE"])

		for _, group in ipairs(groupsSorted) do
			if FriendGroups_HasValue(groups, group) then
				remove:CreateButton(group, function(data)
					note = FriendGroups_RemoveGroup(data.note, data.group)
					if bnetfriend then
						BNSetFriendNote(accountInfo.bnetAccountID, note)
					else
						C_FriendList.SetFriendNotes(contextData.name, note)
					end
				end, { group = group, note = note })
			end
		end
	end
end

function FriendGroups_GetInfoByName(name, bnetfriend)
	if bnetfriend then
		local accountID = 0
		for i = 1, BNGetNumFriends() do
			local acc = C_BattleNet.GetFriendAccountInfo(i)
			if acc.accountName == name then
				accountID = acc.bnetAccountID
			end
		end

		return C_BattleNet.GetAccountInfoByID(accountID)
	else
		local info = C_FriendList.GetFriendInfo(name)
		return info
	end
end

function FriendGroups_CreateNewGroup(name, bnetfriend)
	if bnetfriend then
		local accountInfo = FriendGroups_GetInfoByName(name, bnetfriend)
		StaticPopup_Show("FRIENDGROUPS_CREATE", nil, nil,
			{ id = accountInfo.bnetAccountID, note = accountInfo.note, set = BNSetFriendNote })
	else
		local FriendInfo = C_FriendList.GetFriendInfo(name)
		StaticPopup_Show("FRIENDGROUPS_CREATE", nil, nil,
			{ name = name, note = FriendInfo.notes, set = C_FriendList.SetFriendNotes })
	end
end

function FriendGroups_SplitBattleTag(battleTag)
	local sep = "#"

	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(battleTag, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t[1]
end

function FriendGroups_GetClassColorCode(class, returnTable)
	if not class then
		return returnTable and FRIENDS_GRAY_COLOR or
			string.format("|cFF%02x%02x%02x", FRIENDS_GRAY_COLOR.r * 255, FRIENDS_GRAY_COLOR.g * 255,
				FRIENDS_GRAY_COLOR.b * 255)
	end

	local initialClass = class
	for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
		if class == v then
			class = k
			break
		end
	end

	if class == initialClass then
		for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
			if class == v then
				class = k
				break
			end
		end
	end

	local color = class ~= "" and RAID_CLASS_COLORS[class] or FRIENDS_GRAY_COLOR
	if returnTable then
		return color
	else
		return string.format("|cFF%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)
	end
end

function FriendGroups_GetBNetButtonNameText(accountName, client, canCoop, characterName, class, level, battleTag,
											timerunningSeasonID, realmName)
	local nameText

	-- set up player name and character name
	if accountName then
		if ShiGuangDB.FriendGroupsshow_btag and battleTag then
			nameText = FriendGroups_SplitBattleTag(battleTag)
		else
			nameText = accountName
		end
	else
		nameText = UNKNOWN
	end

	-- append character name
	if characterName then
		if timerunningSeasonID then
			characterName = TimerunningUtil.AddSmallIcon(characterName)
		end

		local characterNameSuffix
		if (not level) or (ShiGuangDB.FriendGroupshide_high_level and level == currentExpansionMaxLevel) or level == 0 then
			characterNameSuffix = ""
		else
			characterNameSuffix = level .. " "  --" | " .. level
		end

		if client == BNET_CLIENT_WOW then
			if characterName ~= "" and level ~= 0 then
				if not canCoop and ShiGuangDB.FriendGroupsgray_faction then
					nameText = "|CFF949694" .. nameText .. " " .. "[" .. characterNameSuffix .. characterName ..
						"}" .. "|r"
				elseif ShiGuangDB.FriendGroupscolour_classes then
					local nameColor = FriendGroups_GetClassColorCode(class)
					nameText = nameText .. " " .. nameColor .. "[" .. characterNameSuffix .. characterName .. "]" .. FONT_COLOR_CODE_CLOSE
				else
					nameText = nameText .. " " .. "[" .. characterNameSuffix .. characterName .. "]" .. FONT_COLOR_CODE_CLOSE
				end
			end
		else
			if ENABLE_COLORBLIND_MODE == "1" then
				characterName = characterName
			end
			local characterNameAndLevel = characterNameSuffix .. characterName
			nameText = nameText ..
				" " .. FRIENDS_OTHER_NAME_COLOR_CODE .. "[" .. characterNameAndLevel .. "]" .. FONT_COLOR_CODE_CLOSE
		end
	end

	return nameText
end

function FriendGroups_GetPlayerGroups(note)
	if note then
		local groups = {}
		local formattedNote = string.match(note, "#.*")

		if formattedNote then
			for s in string.gmatch(formattedNote, "[^#]+") do
				table.insert(groups, s)
			end
		end

		return groups
	else
		return {}
	end
end

function FriendGroups_GetPlayerData(friendsListData, playerId, playerType)
	for _, playerData in pairs(friendsListData) do
		if playerData and playerData.id and playerData.id == playerId and playerData.buttonType and playerData.buttonType == playerType then
			return playerData
		end
	end

	return nil
end

function FriendGroups_ShowRichPresenceOnly(client, wowProjectID, faction, realmID, areaName)
	if (client ~= BNET_CLIENT_WOW) or (wowProjectID ~= WOW_PROJECT_ID) then
		-- If they are not in wow or in a different version of wow, always show rich presence only
		return true;
	elseif (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) and ((faction ~= playerFactionGroup) or (realmID ~= playerRealmID)) then
		-- If we are both in wow classic and our factions or realms don't match, show rich presence only
		return true;
	else
		-- Otherwise show more detailed info about them

		-- Plunderstorm
		if (client == BNET_CLIENT_WOW) and (wowProjectID == WOW_PROJECT_ID) and not areaName then
			return true;
		end

		return false;
	end;
end

function FriendGroups_GetOnlineInfoText(client, isMobile, rafLinkType, locationText, realmText)
	if not locationText then
		return UNKNOWN;
	end

	if isMobile then
		return LOCATION_MOBILE_APP;
	end
	if (client == BNET_CLIENT_WOW) and (rafLinkType ~= Enum.RafLinkType.None) and not isMobile then
		if rafLinkType == Enum.RafLinkType.Recruit then
			return RAF_RECRUIT_FRIEND:format(locationText);
		else
			return RAF_RECRUITER_FRIEND:format(locationText);
		end
	end

	if ShiGuangDB.FriendGroupsshow_realm and realmText and realmText ~= "" then
		locationText = locationText .. " - " .. realmText
	end

	return locationText;
end

function FriendGroups_GetFriendInfoById(id)
	local accountName, characterName, class, level, isFavoriteFriend, isOnline,
	bnetAccountId, client, canCoop, wowProjectID, lastOnline,
	isAFK, isGameAFK, isDND, isGameBusy, mobile, zoneName, battleTag, factionName,
	gameText, realmName, timerunningSeasonID

	if C_BattleNet and C_BattleNet.GetFriendAccountInfo then
		local accountInfo = C_BattleNet.GetFriendAccountInfo(id)
		if accountInfo then
			accountName = accountInfo.accountName
			isFavoriteFriend = accountInfo.isFavorite
			bnetAccountId = accountInfo.bnetAccountID
			isAFK = accountInfo.isAFK
			isDND = accountInfo.isDND
			lastOnline = accountInfo.lastOnlineTime
			battleTag = accountInfo.battleTag

			local gameAccountInfo = accountInfo.gameAccountInfo
			if gameAccountInfo then
				isOnline = gameAccountInfo.isOnline
				isGameAFK = gameAccountInfo.isGameAFK
				isGameBusy = gameAccountInfo.isGameBusy
				mobile = gameAccountInfo.isWowMobile
				characterName = gameAccountInfo.characterName
				class = gameAccountInfo.className
				level = gameAccountInfo.characterLevel
				client = gameAccountInfo.clientProgram
				wowProjectID = gameAccountInfo.wowProjectID
				gameText = gameAccountInfo.richPresence
				zoneName = gameAccountInfo.areaName
				realmName = gameAccountInfo.realmName
				factionName = gameAccountInfo.factionName
				timerunningSeasonID = gameAccountInfo.timerunningSeasonID
			end

			canCoop = CanCooperateWithGameAccount(accountInfo)
		end
	else
		_, accountName, _, _, characterName, bnetAccountId, client,
		isOnline, lastOnline, isAFK, isDND, _, _, _, _, wowProjectID, _, _,
		_, mobile = BNetAccountInfo(id)


		if isOnline then
			_, _, _, realmName, _, factionName, _, class, _, zoneName, level,
			gameText, _, _, _, _, _, isGameAFK, isGameBusy, _,
			wowProjectID, mobile = BNGetGameAccountInfo(bnetAccountId)
		end

		canCoop = CanCooperateWithGameAccount(bnetAccountId)
	end

	if realmName and realmName ~= "" then
		if zoneName then
			zoneName = zoneName .. " - " .. realmName
		end
	end

	return accountName, characterName, class, level, isFavoriteFriend, isOnline,
		bnetAccountId, client, canCoop, wowProjectID, lastOnline,
		isAFK, isGameAFK, isDND, isGameBusy, mobile, zoneName, gameText, battleTag, factionName, timerunningSeasonID
end

function FriendGroups_GetFactionIcon(factionGroup)
	if (factionGroup and factionGroup ~= "Neutral") then
		return "Interface\\FriendsFrame\\PlusManz-" .. factionGroup;
	else
		return ""
	end
end

function FriendGroups_GetStatusString(playerData)
	local status = "Offline"

	if playerData.buttonType == FRIENDS_BUTTON_TYPE_BNET then
		local friendAccountInfo = C_BattleNet.GetFriendAccountInfo(playerData.id)

		if friendAccountInfo then
			local gameAccountInfo = friendAccountInfo.gameAccountInfo

			if friendAccountInfo.isAFK and gameAccountInfo and gameAccountInfo.isOnline then
				status = "AFK"
			end

			if friendAccountInfo.isDND and gameAccountInfo and gameAccountInfo.isOnline then
				status = "DND"
			end

			if not friendAccountInfo.isAFK and not friendAccountInfo.isDND then
				if gameAccountInfo.isOnline then
					status = "Online"

					if gameAccountInfo.isGameBusy then
						status = "DND"
					end

					if gameAccountInfo.isGameAFK then
						status = "AFK"
					end

					if gameAccountInfo.clientProgram == "BSAp" then
						status = status .. "Mobile"
					end

					if gameAccountInfo.clientProgram == BNET_CLIENT_WOW then
						status = status .. "InGame"
					end
				end
			end
		end
	elseif playerData.buttonType == FRIENDS_BUTTON_TYPE_WOW then
		local friendInfo = C_FriendList.GetFriendInfoByIndex(playerData.id)

		if friendInfo.connected then
			status = "OnlineInGame"

			if friendInfo.dnd then
				status = "DNDInGame"
			end

			if friendInfo.afk then
				status = "AFKInGame"
			end
		end
	end

	return status
end

function FriendGroups_SortTableByStatus(playerA, playerB)
	local statusSort = {}

	statusSort["OnlineInGame"] = 1
	statusSort["DNDInGame"] = 2
	statusSort["AFKInGame"] = 3
	statusSort["Online"] = 4
	statusSort["OnlineMobile"] = 5
	statusSort["DND"] = 6
	statusSort["AFK"] = 7
	statusSort["AFKMobile"] = 8
	statusSort["Offline"] = 9

	if not playerA then
		playerA = {}
		playerA.statusText = "Offline"
	end

	if not playerB then
		playerB = {}
		playerB.statusText = "Offline"
	end

	return statusSort[playerA.statusText] < statusSort[playerB.statusText]
end

function FriendGroups_SortGroupsCustom(groupA, groupB)
	if groupA == FGL["GROUP_FAVORITES"] then
		return true
	end

	if groupA == FGL["GROUP_NONE"] then
		return false
	end

	if groupB == FGL["GROUP_NONE"] then
		return true
	end

	if groupB == FGL["GROUP_FAVORITES"] then
		return false
	end

	return groupA < groupB
end

function FriendGroups_GetFriendNote(id, buttonType)
	local noteText = ""

	if buttonType == FRIENDS_BUTTON_TYPE_BNET then
		local accountInfo = C_BattleNet.GetFriendAccountInfo(id)

		if accountInfo then
			noteText = accountInfo.note
		end
	elseif buttonType == FRIENDS_BUTTON_TYPE_WOW then
		noteText = C_FriendList.GetFriendInfoByIndex(id) and C_FriendList.GetFriendInfoByIndex(id).notes
	end

	return noteText
end

function FriendGroups_GetFriendFavorite(id, buttonType)
	local isFavorite = false

	if buttonType == FRIENDS_BUTTON_TYPE_BNET then
		local accountInfo = C_BattleNet.GetFriendAccountInfo(id)

		if accountInfo then
			isFavorite = accountInfo.isFavorite
		end
	end

	return isFavorite
end

function FriendGroups_SetGroupsCount()
	for groupName, groupData in pairs(groupsTotal) do
		if not groupsCount[groupName] then
			groupsCount[groupName] = {}
		end

		groupsCount[groupName].Total = 0
		groupsCount[groupName].Online = 0

		for _, playerData in ipairs(groupData) do
			local statusText = FriendGroups_GetStatusString(playerData)

			groupsCount[groupName].Total = groupsCount[groupName].Total + 1
			if statusText ~= "Offline" then
				groupsCount[groupName].Online = groupsCount[groupName].Online + 1
			end
		end
	end
end

function FriendGroups_SetGroups(id, buttonType)
	local noteText = FriendGroups_GetFriendNote(id, buttonType)
	local groups = FriendGroups_GetPlayerGroups(noteText)
	local statusText = FriendGroups_GetStatusString({ id = id, buttonType = buttonType })
	local favorite = FriendGroups_GetFriendFavorite(id, buttonType)

	if ShiGuangDB.FriendGroupsadd_favorite_group and favorite then
		table.insert(groups, FGL["GROUP_FAVORITES"])
	end

	if next(groups) == nil then
		table.insert(groups, FGL["GROUP_NONE"])
	end

	for _, groupName in ipairs(groups) do
		local isOnline, client, isRetail
		local addToTable = false

		if not groupsTotal[groupName] then
			groupsTotal[groupName] = {}
			groupsCount[groupName] = {}
			groupsCount[groupName].Total = 0
			groupsCount[groupName].Online = 0
			table.insert(groupsSorted, groupName)
		end

		if buttonType == FRIENDS_BUTTON_TYPE_BNET then
			local friendAccountInfo = C_BattleNet.GetFriendAccountInfo(id)
			if not friendAccountInfo then
				friendsListEmpty = true
			else
				isOnline = friendAccountInfo.gameAccountInfo.isOnline
				client = friendAccountInfo.gameAccountInfo.clientProgram
				isRetail = (friendAccountInfo.gameAccountInfo.wowProjectID == WOW_PROJECT_MAINLINE)
			end
		elseif buttonType == FRIENDS_BUTTON_TYPE_WOW then
			isOnline = C_FriendList.GetFriendInfoByIndex(id).connected
			client = BNET_CLIENT_WOW
		end

		if isOnline then
			if (ShiGuangDB.FriendGroupshide_afk and statusText ~= "AFK" and statusText ~= "AFKMobile") or not ShiGuangDB.FriendGroupshide_afk then
				if (ShiGuangDB.FriendGroupsingame_only and client == BNET_CLIENT_WOW) or not ShiGuangDB.FriendGroupsingame_only then
					if ShiGuangDB.FriendGroupsshow_retail and client == BNET_CLIENT_WOW then
						if isRetail then
							addToTable = true
						end
					else
						addToTable = true
					end
				end
			end
		else
			if not ShiGuangDB.FriendGroupshide_offline and ((ShiGuangDB.FriendGroupsingame_only and client == BNET_CLIENT_WOW) or not ShiGuangDB.FriendGroupsingame_only) then
				addToTable = true
			end
		end

        -- FIX: Always allow search logic since search is always on
		if searchValue ~= "" then
			addToTable = FriendGroups_Search(id, buttonType)
		end

		if addToTable then
			groupsCount[groupName].Total = groupsCount[groupName].Total + 1
			if statusText ~= "Offline" then
				groupsCount[groupName].Online = groupsCount[groupName].Online + 1
			end
			table.insert(groupsTotal[groupName], { id = id, buttonType = buttonType, statusText = statusText })
		end
	end
end

-- ============================================================================
-- [[ MENU INITIALIZATION ]]
-- ============================================================================

-- 1. Create the Frame object first
FriendGroups_Menu = CreateFrame("Frame", "FriendGroups_Menu", UIParent, "UIDropDownMenuTemplate")
FriendGroups_Menu.displayMode = "MENU"

-- 2. Define the behavior (Right-Click on Group Header)
FriendGroups_Menu.initialize = function(self, level)
    if level ~= 1 then return end
    
    local groupName = UIDROPDOWNMENU_MENU_VALUE
    if not groupName then return end

    -- Add Group Name Title 
    local titleInfo = UIDropDownMenu_CreateInfo()
    titleInfo.text = groupName
    titleInfo.isTitle = true
    titleInfo.notCheckable = true
    UIDropDownMenu_AddButton(titleInfo, level)

    -- Add Action Buttons (Rename, Remove, Invite) 
    for i = 2, #groupMenuItems do
        local item = groupMenuItems[i]
        local info = UIDropDownMenu_CreateInfo()
        info.text = item.text
        info.notCheckable = true
        info.func = item.func
        info.arg1 = groupName 

        -- RESTORED LOGIC: PROTECT SPECIAL GROUPS 
        if groupName == FGL["GROUP_NONE"] or groupName == FGL["GROUP_FAVORITES"] or groupName == FGL["GROUP_EMPTY"] or groupName == "" then
            if item.text == FGL["MENU_RENAME"] or item.text == FGL["MENU_REMOVE"] then
                info.disabled = true
            end
            if item.text == FGL["MENU_INVITE"] and groupName == FGL["GROUP_EMPTY"] then
                info.disabled = true
            end
        end
        
        -- RESTORED LOGIC: 40 PLAYER LIMIT 
        if item.text == FGL["MENU_INVITE"] then
            if groupsCount[groupName] and groupsCount[groupName].Total > 40 then
                info.disabled = true
                info.text = item.text .. FGL["MENU_MAX_40"]
            end
        end

        UIDropDownMenu_AddButton(info, level)
    end
end

-- 3. Also initialize the Settings Menu to prevent similar errors
FriendGroups_SettingsMenu = CreateFrame("Frame", "FriendGroups_SettingsMenu", UIParent, "UIDropDownMenuTemplate")
FriendGroups_SettingsMenu.displayMode = "MENU"

FriendGroups_SettingsMenu.initialize = function(self, level)
    if level ~= 1 then return end
    
    for _, items in ipairs(settingsMenuItems) do
        local info = UIDropDownMenu_CreateInfo()
        for prop, value in pairs(items) do
            info[prop] = value
        end
        UIDropDownMenu_AddButton(info, level)
    end
end

--[[
	FriendGroupsFrame
]] --
FriendGroupsFrame = CreateFrame("Frame", "FriendGroupsFrame")
FriendGroupsFrame.displayMode = "MENU"
FriendGroupsFrame.info = {}
FriendGroupsFrame.UncheckHack = function(dropdownbutton)
	_G[dropdownbutton:GetName() .. "Check"]:Hide()
end
FriendGroupsFrame.HideMenu = function()
	if UIDROPDOWNMENU_OPEN_MENU == FriendGroupsFrame then
		CloseDropDownMenus()
	end
end
FriendGroupsFrame.initialize = function(self, level)
    -- This was used for the old system. Keeping empty structure to prevent Lua errors if something calls it.
end

-- Popups
StaticPopupDialogs["FRIENDGROUPS_CREATE"] = {
	text = FGL["POPUP_ENTER_NAME"],
	button1 = ACCEPT,
	button2 = CANCEL,
	hasEditBox = 1,
	OnAccept = function(self)
		local parent = self:GetEditBox():GetParent()
		FriendGroups_Create(parent, parent.data)
		parent:Hide()
	end,
	EditBoxOnEnterPressed = function(self)
		local parent = self:GetParent()
		FriendGroups_Create(parent, parent.data)
		parent:Hide()
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
}
StaticPopupDialogs["FRIENDGROUPS_RENAME"] = {
	text = FGL["POPUP_ENTER_NAME"],
	button1 = ACCEPT,
	button2 = CANCEL,
	hasEditBox = 1,
	OnAccept = function(self)
		local parent = self:GetEditBox():GetParent()
		FriendGroups_Rename(parent, parent.data)
		parent:Hide()
	end,
	EditBoxOnEnterPressed = function(self)
		local parent = self:GetParent()
		FriendGroups_Rename(parent, parent.data)
		parent:Hide()
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
}

-- [[ NEW POPUP: COPY TEXT ]] --
StaticPopupDialogs["FRIENDGROUPS_COPY_POPUP"] = {
	text = FGL["POPUP_COPY"],
	button1 = OKAY,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
	hasEditBox = 1,
	preferredIndex = 3,
	OnShow = function(self)
        -- FIX: Use .EditBox (Capital E)
		if self.EditBox then
			self.EditBox:SetFocus()
			self.EditBox:HighlightText()
		end
	end,
	EditBoxOnEnterPressed = function(self)
		self:GetParent():Hide()
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end,
}

--[[
	Functions
]] --

-- [[ CORE ACTIVATOR ]] --
EnableFriendGroups = function()
    if FriendGroups_Loaded then return end
    FriendGroups_Loaded = true
    
		if ShiGuangDB["FriendGroupscollapsed"] == nil then ShiGuangDB["FriendGroupscollapsed"] = {} end
		if ShiGuangDB["FriendGroupshide_offline"] == nil then ShiGuangDB["FriendGroupshide_offline"] = true end
		if ShiGuangDB["FriendGroupscolour_classes"] == nil then ShiGuangDB["FriendGroupscolour_classes"] = true end
		if ShiGuangDB["FriendGroupsgray_faction"] == nil then ShiGuangDB["FriendGroupsgray_faction"] = false end
		if ShiGuangDB["FriendGroupshide_high_level"] == nil then ShiGuangDB["FriendGroupshide_high_level"] = false end
		if ShiGuangDB["FriendGroupsshow_mobile_afk"] == nil then ShiGuangDB["FriendGroupsshow_mobile_afk"] = false end
		if ShiGuangDB["FriendGroupsadd_mobile_text"] == nil then ShiGuangDB["FriendGroupsadd_mobile_text"] = true end
		if ShiGuangDB["FriendGroupsingame_only"] == nil then ShiGuangDB["FriendGroupsingame_only"] = false end
		if ShiGuangDB["FriendGroupsingame_retail"] == nil then ShiGuangDB["FriendGroupsingame_retail"] = false end
		if ShiGuangDB["FriendGroupsshow_btag"] == nil then ShiGuangDB["FriendGroupsshow_btag"] = false end
		if ShiGuangDB["FriendGroupssort_by_status"] == nil then ShiGuangDB["FriendGroupssort_by_status"] = true end
		if ShiGuangDB["FriendGroupsshow_retail"] == nil then ShiGuangDB["FriendGroupsshow_retail"] = false end
		if ShiGuangDB["FriendGroupsshow_faction_icons"] == nil then ShiGuangDB["FriendGroupsshow_faction_icons"] = true end
		if ShiGuangDB["FriendGroupsshow_search"] == nil then ShiGuangDB["FriendGroupsshow_search"] = false end
		if ShiGuangDB["FriendGroupshide_empty_groups"] == nil then ShiGuangDB["FriendGroupshide_empty_groups"] = true end
		if ShiGuangDB["FriendGroupsshow_realm"] == nil then ShiGuangDB["FriendGroupsshow_realm"] = true end
		if ShiGuangDB["FriendGroupshide_afk"] == nil then ShiGuangDB["FriendGroupshide_afk"] = false end
		if ShiGuangDB["FriendGroupadd_favorite_group"] == nil then ShiGuangDB["FriendGroupadd_favorite_group"] = true end
		if ShiGuangDB["FriendGroupsshow_flags"] == nil then ShiGuangDB["FriendGroupsshow_flags"] = true end
		if ShiGuangDB["FriendGroupsauto_accept_invite"] == nil then ShiGuangDB["FriendGroupsauto_accept_invite"] = false end
		if ShiGuangDB["FriendGroupsauto_accept_sync"] == nil then ShiGuangDB["FriendGroupsauto_accept_sync"] = false end

    -- 1. Create Search Box
    FriendGroups_SearchBox = CreateFrame("EditBox", "FriendGroupsGlobalSearch", FriendsListFrame, "SearchBoxTemplate")
    FriendGroups_SearchBox:SetSize(200, 20)
    FriendGroups_SearchBox:SetPoint("TOPLEFT", FriendsListFrame, "TOPLEFT", 15, -85) 
    FriendGroups_SearchBox:SetPoint("TOPRIGHT", FriendsListFrame, "TOPRIGHT", -30, -85) 
    FriendGroups_SearchBox:SetAutoFocus(false)
    FriendGroups_SearchBox.Instructions:SetText(FGL["SEARCH_PLACEHOLDER"])
    
    FriendGroups_SearchBox:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(SEARCH, 1, 1, 1) 
        GameTooltip:AddLine(FGL["SEARCH_TOOLTIP"], nil, nil, nil, true) 
        GameTooltip:Show()
    end)

    FriendGroups_SearchBox:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    FriendGroups_SearchBox:SetScript("OnTextChanged", function(self)
        SearchBoxTemplate_OnTextChanged(self)
        local text = self:GetText()
        if text ~= searchValue then
            searchValue = text
            FriendGroups_FriendsListUpdate(true)
        end
    end)

    -- 2. Create Settings Button
    local settingsBtn = CreateFrame("Button", "FriendGroupsGlobalSettings", FriendGroups_SearchBox)
    settingsBtn:SetSize(20, 20)
    settingsBtn:SetPoint("LEFT", FriendGroups_SearchBox, "RIGHT", 1, 0)
    settingsBtn:SetNormalTexture("Interface\\Buttons\\UI-OptionsButton")
    settingsBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    
    settingsBtn:SetScript("OnClick", function()
        ToggleDropDownMenu(1, nil, FriendGroups_SettingsMenu, "cursor", 0, 0)
    end)
    
    settingsBtn:SetScript("OnEnter", function(self) 
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(FGL["SETTINGS_TITLE"] or "Settings", 1, 1, 1)
        GameTooltip:Show()
    end)
    settingsBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -- 3. Apply Hooks
    hooksecurefunc("FriendsList_Update", FriendGroups_FriendsListUpdate)
    hooksecurefunc("FriendsFrame_UpdateFriendButton", FriendGroups_FriendsListUpdateFriendButton)
    Menu.ModifyMenu("MENU_UNIT_GLUE_FRIEND", FriendGroups_AddDropDownNew)
    Menu.ModifyMenu("MENU_UNIT_FRIEND", FriendGroups_AddDropDownNew)
    Menu.ModifyMenu("MENU_UNIT_FRIEND_OFFLINE", FriendGroups_AddDropDownNew)
    Menu.ModifyMenu("MENU_UNIT_BN_FRIEND", FriendGroups_AddDropDownNew)
    Menu.ModifyMenu("MENU_UNIT_BN_FRIEND_OFFLINE", FriendGroups_AddDropDownNew)
    hooksecurefunc(FriendsListButtonMixin, "OnClick", FriendGroups_FriendsListButtonTemplateClick)

    -- 4. Setup Scroll View
    SetupGroupedView()
    
    -- [[ UPDATED DEFAULT: Set to 380 (Large) ]] --
    if not ShiGuangDB.FriendGroupsextra_height then
        ShiGuangDB.FriendGroupsextra_height = 190
    end
    FriendGroups_UpdateSize()

    FriendGroups_FriendsListUpdate(true)
end

SetupGroupedView = function()
    local view = CreateScrollBoxListLinearView()
    view:SetElementFactory(function(factory, elementData)
        local buttonType = elementData.buttonType;
        if buttonType == FRIENDS_BUTTON_TYPE_DIVIDER then
            factory("FriendGroupsFrameFriendDividerTemplate", FriendGroups_FriendsListUpdateDividerTemplate);
        elseif buttonType == FRIENDS_BUTTON_TYPE_INVITE_HEADER then
            factory("FriendsPendingInviteHeaderButtonTemplate",
                FriendGroups_FriendsFrameUpdateFriendInviteHeaderButton);
        elseif buttonType == FRIENDS_BUTTON_TYPE_INVITE then
            factory("FriendsFrameFriendInviteTemplate", FriendGroups_FriendsFrameUpdateFriendInviteButton);
        else
            factory("FriendGroupsFriendsListButtonTemplate", FriendGroups_FriendsListUpdateFriendButton);
        end
    end);
    ScrollUtil.InitScrollBoxListWithScrollBar(FriendsListFrame.ScrollBox, FriendsListFrame.ScrollBar, view);
end

-- [[ HELPER: Scans Text to find Realm & Region ]] --
function FriendGroups_GetRealmInfo(gameAccountInfo)
    if not gameAccountInfo then return nil, nil end

    local rawRealm = gameAccountInfo.realmName
    local richPresence = gameAccountInfo.richPresence or ""
    local cleanBlob = (richPresence .. (rawRealm or "")):gsub("%p", ""):gsub("%s+", "") 

    -- [[ 1. DETECT PLAYER REGION ]] --
    -- Region 1 = Americas/Oceania, Region 3 = Europe
    local myRegion = GetCurrentRegion() 
    local primaryTable = (myRegion == 3) and FriendGroups_RealmDataEU or FriendGroups_RealmData
    local secondaryTable = (myRegion == 3) and FriendGroups_RealmData or FriendGroups_RealmDataEU

    -- [[ 2. REORGANIZED CLASSIC PRIORITY (Region-Sensitive) ]] --
    local classicPriority = {
        -- US/Oceanic Classic Hubs
        ["Nightslayer"] = { icon="FlagUS.tga", region="US" },
        ["Dreamscythe"] = { icon="FlagUS.tga", region="US" },
        ["Doomhowl"] = { icon="FlagUS.tga", region="US" },
        ["Whitemane"] = { icon="FlagUS.tga", region="US" },
        ["Mankrik"] = { icon="FlagUS.tga", region="US" },
        ["Maladath"] = { icon="FlagAU.tga", region="Oceania" },
        ["Shadowstrike"] = { icon="FlagAU.tga", region="Oceania" },

        -- EU Classic Hubs (Fixed to FlagGB)
        ["Thunderstrike"] = { icon="FlagGB.tga", region="EU" },
        ["Spineshatter"] = { icon="FlagGB.tga", region="EU" },
        ["Soulseeker"] = { icon="FlagGB.tga", region="EU" },
        ["Firemaw"] = { icon="FlagGB.tga", region="EU" },
        ["Gehennas"] = { icon="FlagGB.tga", region="EU" },
        ["Stitches"] = { icon="FlagGB.tga", region="EU" }
    }

    for name, data in pairs(classicPriority) do
        if cleanBlob:find(name, 1, true) then
            return "Interface\\AddOns\\OrzUI\\Media\\Modules\\FriendGroups\\" .. data.icon, data.region
        end
    end

    -- [[ 3. SMART LOOKUP ]] --
    if rawRealm and rawRealm ~= "" then
        local cleanRealm = rawRealm:gsub("%s+", "")
        
        -- Check Local Region Table First (Solves Blackhand overlap)
        local data = primaryTable[cleanRealm] or secondaryTable[cleanRealm]
        
        if data then
            return "Interface\\AddOns\\OrzUI\\Media\\Modules\\FriendGroups\\" .. data.icon, data.region
        end
    end

    -- 4. Final Fallback (Extraction)
    local extraction = richPresence:match("%s%-%s(.+)$")
    if extraction then
        local cleanEx = extraction:gsub("%s+", "")
        local data = primaryTable[cleanEx] or secondaryTable[cleanEx]
        if data then
            return "Interface\\AddOns\\OrzUI\\Media\\Modules\\FriendGroups\\" .. data.icon, data.region
        end
    end

    return nil, nil
end

FriendGroups_FriendsListUpdateFriendButton = function(button, elementData)
    if not FriendGroups_Loaded then return end

    -- Safe Parent Check
    local isFriendFrame = false
    if button and button.GetParent and FriendsListFrame then
        local current = button:GetParent()
        for i = 1, 15 do
            if not current then break end
            if current == FriendsListFrame then isFriendFrame = true break end
            current = current.GetParent and current:GetParent()
        end
    end
    if not isFriendFrame then return end

	local id = elementData.id;
	local buttonType = elementData.buttonType;
	button.buttonType = buttonType;
	button.id = id;

	if button.facIcon then button.facIcon:Hide() end
    if button.realmFlag then button.realmFlag:Hide() end 

	local nameText, nameColor, infoText, isFavoriteFriend, statusTexture;
	local hasTravelPassButton = false;
	local isCrossFactionInvite = false;
	local inviteFaction = nil;

	if button.buttonType == FRIENDS_BUTTON_TYPE_WOW then
		local info = C_FriendList.GetFriendInfoByIndex(id);
		if (info.connected) then
			button.background:SetColorTexture(FRIENDS_WOW_BACKGROUND_COLOR.r, FRIENDS_WOW_BACKGROUND_COLOR.g, FRIENDS_WOW_BACKGROUND_COLOR.b, FRIENDS_WOW_BACKGROUND_COLOR.a);
			if (info.afk) then button.status:SetTexture(FRIENDS_TEXTURE_AFK);
			elseif (info.dnd) then button.status:SetTexture(FRIENDS_TEXTURE_DND);
			else button.status:SetTexture(FRIENDS_TEXTURE_ONLINE); end
			nameText = info.name .. ", " .. format(FRIENDS_LEVEL_TEMPLATE, info.level, info.className);
			nameColor = FRIENDS_WOW_NAME_COLOR;
			infoText = FriendGroups_GetOnlineInfoText(BNET_CLIENT_WOW, info.mobile, info.rafLinkType, info.area);
		else
			button.background:SetColorTexture(FRIENDS_OFFLINE_BACKGROUND_COLOR.r, FRIENDS_OFFLINE_BACKGROUND_COLOR.g, FRIENDS_OFFLINE_BACKGROUND_COLOR.b, FRIENDS_OFFLINE_BACKGROUND_COLOR.a);
			button.status:SetTexture(FRIENDS_TEXTURE_OFFLINE);
			nameText = info.name;
			nameColor = FRIENDS_GRAY_COLOR;
			infoText = FRIENDS_LIST_OFFLINE;
		end
		button.gameIcon:Hide();
		button.summonButton:ClearAllPoints();
		button.summonButton:SetPoint("TOPRIGHT", button, "TOPRIGHT", 1, -1);
		FriendsFrame_SummonButton_Update(button.summonButton);

	elseif button.buttonType == FRIENDS_BUTTON_TYPE_BNET then
		local accountInfo = C_BattleNet.GetFriendAccountInfo(id);
		if accountInfo then
			nameText, nameColor, statusTexture = FriendsFrame_GetBNetAccountNameAndStatus(accountInfo);
			local accountName, characterName, class, level, _, _, _, client, canCoop, _, _, _, isGameAFK, isDND, isGameBusy, mobile, zoneName, gameText, battleTag, factionName, timerunningSeasonID = FriendGroups_GetFriendInfoById(button.id)

			if ShiGuangDB.FriendGroupsshow_mobile_afk and client == 'BSAp' then statusTexture = FRIENDS_TEXTURE_AFK end

			nameText = FriendGroups_GetBNetButtonNameText(accountName, client, canCoop, characterName, class, level, battleTag, timerunningSeasonID, realmName)
			isFavoriteFriend = accountInfo.isFavorite;
			button.status:SetTexture(statusTexture);
			isCrossFactionInvite = accountInfo.gameAccountInfo.factionName ~= playerFactionGroup;
			inviteFaction = accountInfo.gameAccountInfo.factionName;

			if accountInfo.gameAccountInfo.isOnline then
				button.background:SetColorTexture(FRIENDS_BNET_BACKGROUND_COLOR.r, FRIENDS_BNET_BACKGROUND_COLOR.g, FRIENDS_BNET_BACKGROUND_COLOR.b, FRIENDS_BNET_BACKGROUND_COLOR.a);

				if FriendGroups_ShowRichPresenceOnly(accountInfo.gameAccountInfo.clientProgram, accountInfo.gameAccountInfo.wowProjectID, accountInfo.gameAccountInfo.factionName, accountInfo.gameAccountInfo.realmID, accountInfo.gameAccountInfo.areaName) then
					infoText = FriendGroups_GetOnlineInfoText(accountInfo.gameAccountInfo.clientProgram, accountInfo.gameAccountInfo.isWowMobile, accountInfo.rafLinkType, accountInfo.gameAccountInfo.richPresence);
				else
					infoText = FriendGroups_GetOnlineInfoText(accountInfo.gameAccountInfo.clientProgram, accountInfo.gameAccountInfo.isWowMobile, accountInfo.rafLinkType, accountInfo.gameAccountInfo.areaName, accountInfo.gameAccountInfo.realmName);
				end

				C_Texture.SetTitleIconTexture(button.gameIcon, accountInfo.gameAccountInfo.clientProgram, Enum.TitleIconVersion.Medium);
				local fadeIcon = (accountInfo.gameAccountInfo.clientProgram == BNET_CLIENT_WOW) and (accountInfo.gameAccountInfo.wowProjectID ~= WOW_PROJECT_ID);
				if fadeIcon then button.gameIcon:SetAlpha(0.6); else button.gameIcon:SetAlpha(1); end

				local shouldShowSummonButton = FriendsFrame_ShouldShowSummonButton(button.summonButton);
				button.gameIcon:SetShown(not shouldShowSummonButton);

				hasTravelPassButton = true;
				local restriction = FriendsFrame_GetInviteRestriction(button.id);
				if restriction == INVITE_RESTRICTION_NONE then button.travelPassButton:Enable(); else button.travelPassButton:Disable(); end

-- [[ 1. SWAPPED ICON LOGIC: FACTION THEN FLAG ]] --
                local factionShown = false
                if ShiGuangDB.FriendGroupsshow_faction_icons then
                    if not button.facIcon then
                        button.facIcon = button:CreateTexture("facIcon")
                        button.facIcon:SetSize(button.gameIcon:GetWidth(), button.gameIcon:GetHeight())
                    end
                    
                    button.facIcon:ClearAllPoints()
                    -- Anchor Faction Icon to the LEFT of the Game Icon
                    button.facIcon:SetPoint("RIGHT", button.gameIcon, "LEFT", 0, 0)
                    button.facIcon:SetTexture(FriendGroups_GetFactionIcon(accountInfo.gameAccountInfo.factionName))
                    button.facIcon:Show()
                    factionShown = true

                    -- Faction background coloring
                    if accountInfo.gameAccountInfo.factionName == "Horde" then
                        button.background:SetColorTexture(0.7, 0.2, 0.2, 0.2)
                    elseif accountInfo.gameAccountInfo.factionName == "Alliance" then
                        button.background:SetColorTexture(0.2, 0.2, 0.7, 0.2)
                    end
                else
                    if button.facIcon then button.facIcon:Hide() end
                end

                -- [[ 2. FLAG LOGIC: ANCHORED TO FACTION ]] --
                if ShiGuangDB.FriendGroupsshow_flags then
                    if not button.realmFlag then
                        button.realmFlag = button:CreateTexture("realmFlag")
                        button.realmFlag:SetSize(button.gameIcon:GetWidth() * 0.75, button.gameIcon:GetHeight() * 0.75)
                    end
                    
                    local flagTexture, _ = FriendGroups_GetRealmInfo(accountInfo.gameAccountInfo)

                    if flagTexture then
                        button.realmFlag:SetTexture(flagTexture)
                        button.realmFlag:Show()
                        button.realmFlag:ClearAllPoints()
                        
                        -- Anchor Flag to the LEFT of the Faction Icon (or Game Icon if faction is hidden)
                        if factionShown then
                            button.realmFlag:SetPoint("RIGHT", button.facIcon, "LEFT", -1, 0)
                        else
                            button.realmFlag:SetPoint("RIGHT", button.gameIcon, "LEFT", 0, 0)
                        end
                    else
                        button.realmFlag:Hide()
                    end
                else
                    if button.realmFlag then button.realmFlag:Hide() end
                end

			else
				button.background:SetColorTexture(FRIENDS_OFFLINE_BACKGROUND_COLOR.r, FRIENDS_OFFLINE_BACKGROUND_COLOR.g, FRIENDS_OFFLINE_BACKGROUND_COLOR.b, FRIENDS_OFFLINE_BACKGROUND_COLOR.a);
				button.gameIcon:Hide();
				infoText = FriendsFrame_GetLastOnlineText(accountInfo);
			end

			if ShiGuangDB.FriendGroupsadd_mobile_text and infoText == '' and client == 'BSAp' then infoText = FGL["STATUS_MOBILE"] end

			button.summonButton:ClearAllPoints();
			button.summonButton:SetPoint("CENTER", button.gameIcon, "CENTER", 1, 0);
			FriendsFrame_SummonButton_Update(button.summonButton);
		end
	end

	if hasTravelPassButton then button.travelPassButton:Show(); else button.travelPassButton:Hide(); end

	local selected = (FriendsFrame.selectedFriendType == buttonType) and (FriendsFrame.selectedFriend == id);
	FriendsFrame_FriendButtonSetSelection(button, selected);

	if nameText then
		button.name:SetText(nameText);
		button.name:SetTextColor(nameColor.r, nameColor.g, nameColor.b);
		button.info:SetText(infoText);
		button:Show();
		if isFavoriteFriend then
			button.Favorite:Show();
			button.Favorite:ClearAllPoints()
			button.Favorite:SetPoint("TOPLEFT", button.name, "TOPLEFT", button.name:GetStringWidth(), 0);
		else
			button.Favorite:Hide();
		end
	else
		button:Hide();
	end
	
	if (FriendsTooltip.button == button) or (button:IsMouseMotionFocus()) then button:OnEnter() end

	if hasTravelPassButton and isCrossFactionInvite and not GetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_CROSS_FACTION_INVITE) then
		local helpTipInfo = {
			text = CROSS_FACTION_INVITE_HELPTIP,
			buttonStyle = HelpTip.ButtonStyle.Close,
			cvarBitfield = "closedInfoFrames",
			bitfieldFlag = LE_FRAME_TUTORIAL_CROSS_FACTION_INVITE,
			targetPoint = HelpTip.Point.RightEdgeCenter,
			alignment = HelpTip.Alignment.Left,
		};
		crossFactionHelpTipInfo = helpTipInfo;
		crossFactionHelpTipButton = button;
		HelpTip:Show(FriendsFrame, helpTipInfo, button.travelPassButton);
	end

	if hasTravelPassButton then
		if isCrossFactionInvite and inviteFaction == "Horde" then
			button.travelPassButton.NormalTexture:SetAtlas("friendslist-invitebutton-horde-normal");
			button.travelPassButton.PushedTexture:SetAtlas("friendslist-invitebutton-horde-pressed");
			button.travelPassButton.DisabledTexture:SetAtlas("friendslist-invitebutton-horde-disabled");
		elseif isCrossFactionInvite and inviteFaction == "Alliance" then
			button.travelPassButton.NormalTexture:SetAtlas("friendslist-invitebutton-alliance-normal");
			button.travelPassButton.PushedTexture:SetAtlas("friendslist-invitebutton-alliance-pressed");
			button.travelPassButton.DisabledTexture:SetAtlas("friendslist-invitebutton-alliance-disabled");
		else
			button.travelPassButton.NormalTexture:SetAtlas("friendslist-invitebutton-default-normal");
			button.travelPassButton.PushedTexture:SetAtlas("friendslist-invitebutton-default-pressed");
			button.travelPassButton.DisabledTexture:SetAtlas("friendslist-invitebutton-default-disabled");
		end
	end

	return nil;
end

FriendGroups_FriendsListUpdate = function(forceUpdate)
    -- GUARD: Only run if Enabled
    if not FriendGroups_Loaded then return end

	local numBNetTotal, numBNetOnline, numBNetFavorite, numBNetFavoriteOnline = BNGetNumFriends()
	local numBNetOffline = numBNetTotal - numBNetOnline
	local numBNetFavoriteOffline = numBNetFavorite - numBNetFavoriteOnline
	local numWoWTotal = C_FriendList.GetNumFriends()
	local numWoWOnline = C_FriendList.GetNumOnlineFriends()
	local numWoWOffline = numWoWTotal - numWoWOnline
	local retainScrollPosition = not forceUpdate
    
    -- FIX: Always assume search is enabled for filtering empty groups
	local hideGroups = ShiGuangDB.FriendGroupshide_empty_groups or
		(searchValue ~= "")

	local dataProvider = CreateDataProvider()

	if (not FriendsListFrame:IsShown() and not forceUpdate) then
		return
	end

	wipe(groupsTotal)
	wipe(groupsSorted)

	-- invites
	local numInvites = BNGetNumFriendInvites()
	if (numInvites > 0) then
		if (not GetCVarBool("friendInvitesCollapsed")) then
			for i = 1, numInvites do
				dataProvider:Insert({ id = i, buttonType = FRIENDS_BUTTON_TYPE_INVITE })
			end
		end
	end

	local bnetFriendIndex = 0;
	-- favorite friends, online and offline
	for i = 1, numBNetFavorite do
		bnetFriendIndex = bnetFriendIndex + 1;
		FriendGroups_SetGroups(bnetFriendIndex, FRIENDS_BUTTON_TYPE_BNET)
	end

	-- online Battlenet friends
	for i = 1, numBNetOnline - numBNetFavoriteOnline do
		bnetFriendIndex = bnetFriendIndex + 1
		FriendGroups_SetGroups(bnetFriendIndex, FRIENDS_BUTTON_TYPE_BNET)
	end
	-- online WoW friends
	for i = 1, numWoWOnline do
		FriendGroups_SetGroups(i, FRIENDS_BUTTON_TYPE_WOW)
	end

	-- offline Battlenet friends
	for i = 1, numBNetOffline - numBNetFavoriteOffline do
		bnetFriendIndex = bnetFriendIndex + 1
		FriendGroups_SetGroups(bnetFriendIndex, FRIENDS_BUTTON_TYPE_BNET)
	end
	-- offline WoW friends
	for i = 1, numWoWOffline do
		FriendGroups_SetGroups(i + numWoWOnline, FRIENDS_BUTTON_TYPE_WOW)
	end

	table.sort(groupsSorted, FriendGroups_SortGroupsCustom)

	for _, groupName in ipairs(groupsSorted) do
		if (not hideGroups or (hideGroups and #groupsTotal[groupName] > 0)) then
            -- [[ CHANGE START: Set default to FALSE (Expanded) ]] --
			if ShiGuangDB.FriendGroupscollapsed[groupName] == nil then
				ShiGuangDB.FriendGroupscollapsed[groupName] = false
			end
            -- [[ CHANGE END ]] --

			dataProvider:Insert({ buttonType = FRIENDS_BUTTON_TYPE_DIVIDER, groupName = groupName })

			if not ShiGuangDB.FriendGroupscollapsed[groupName] then
                -- FIX: Removed "Sort by Status" logic block here
				for _, playerData in ipairs(groupsTotal[groupName]) do
					if playerData.buttonType and playerData.id then
						dataProvider:Insert({ id = playerData.id, buttonType = playerData.buttonType })
					end
				end
			end
		end
	end

	-- Empty fallback
	if dataProvider:GetSize() == 0 or (dataProvider:GetSize() == 1) then
		dataProvider:Insert({ buttonType = FRIENDS_BUTTON_TYPE_DIVIDER, groupName = FGL["GROUP_EMPTY"] })
	end

	-- Prevent the game from auto-selecting the first friend
	-- If the selection is locked (user hasn't clicked yet), force clear it.
	if FriendGroupsFrame.selectionLocked then
		FriendsFrame.selectedFriend = nil
		FriendsFrame.selectedFriendType = nil
	elseif not retainScrollPosition then
		FriendsFrame.selectedFriend = nil
		FriendsFrame.selectedFriendType = nil
	end

	FriendsListFrame.ScrollBox:SetDataProvider(dataProvider, retainScrollPosition)

	-- Double ensure after setting provider to catch any auto-select artifacts
	if FriendGroupsFrame.selectionLocked then
		FriendsFrame.selectedFriend = nil
		FriendsFrame.selectedFriendType = nil
	elseif not retainScrollPosition then
		FriendsFrame.selectedFriend = nil
		FriendsFrame.selectedFriendType = nil
	end

	-- Cleanup
	for groupName, _ in pairs(ShiGuangDB.FriendGroupscollapsed) do
		if not groupsTotal[groupName] then
			ShiGuangDB.FriendGroupscollapsed[groupName] = nil
		end
	end

	if friendsListEmpty and (lastFriendsListEmptyWarning + 60) <= (math.floor(GetTime() + 0.5)) then
		lastFriendsListEmptyWarning = math.floor(GetTime() + 0.5)
		print(FGL["MSG_BUG_WARNING"])
	end
end

function FriendGroups_FilterTable(tableData, filterFunction)
	local returnTable = {}

	for key, value in pairs(tableData) do
		if filterFunction(value, key, tableData) then table.insert(returnTable, value) end
	end

	return returnTable
end

function FriendGroups_ToggleSearch(searchBox, frame)
    -- If the user has the search mode open, do NOT hide the box 
    -- even if the text is currently empty.
    if searchOpened then return end

    if searchValue == "" then
        searchBox:Hide()
        frame.name:Show()
    end
end

-- [[ UPDATED SEARCH: Supports Region AND Faction Keywords ]] --
-- [[ UPDATED SEARCH: Filters by Specific Region Names in Realms.lua ]] --
function FriendGroups_Search(playerId, playerButtonType)
    if searchValue == "" then return true end

    local characterName, bnetAccountName, battleTag, noteText, realmName, className, richPresence, regionSearchText, factionSearchText = "", "", "", "", "", "", "", "", ""
    local classMatch = false
    local searchLower = searchValue:lower()
    local searchLen = #searchLower

    if playerButtonType == FRIENDS_BUTTON_TYPE_BNET then
        local accountInfo = C_BattleNet.GetFriendAccountInfo(playerId)
        if accountInfo and accountInfo.gameAccountInfo then
            bnetAccountName = accountInfo.accountName or ""
            battleTag = accountInfo.battleTag or ""
            noteText = accountInfo.note or ""
            characterName = accountInfo.gameAccountInfo.characterName or ""
            realmName = accountInfo.gameAccountInfo.realmName or ""
            className = accountInfo.gameAccountInfo.className or ""
            richPresence = accountInfo.gameAccountInfo.richPresence or ""
            factionSearchText = accountInfo.gameAccountInfo.factionName or ""

            -- [[ 1. DATABASE LOOKUP FOR REGION NAME ]] --
            local rid = accountInfo.gameAccountInfo.regionID
            local database = (rid == 3) and FriendGroups_RealmDataEU or FriendGroups_RealmData
            
            if realmName ~= "" then
                local cleanRealm = realmName:gsub("%s+", "")
                local data = database[cleanRealm]
                if data and data.region then
                    regionSearchText = data.region -- This captures "Oceania", "Brazil", etc.
                end
            end
        end
    elseif playerButtonType == FRIENDS_BUTTON_TYPE_WOW then
        local info = C_FriendList.GetFriendInfoByIndex(playerId)
        if info then
            characterName = info.name or ""
            noteText = info.notes or ""
            className = info.className or ""
            factionSearchText = playerFactionGroup or ""
            regionSearchText = "Local" -- Standard WoW friends are always local
        end
    end

    -- Match Class
    if className ~= "" and className:lower():sub(1, searchLen) == searchLower then classMatch = true end

    -- [[ 2. MASTER SEARCH LOGIC ]] --
    if (bnetAccountName:lower():find(searchLower, 1, true)) or 
       (battleTag:lower():find(searchLower, 1, true)) or 
       (characterName:lower():find(searchLower, 1, true)) or
       (noteText:lower():find(searchLower, 1, true)) or
       (realmName:lower():find(searchLower, 1, true)) or
       (richPresence:lower():find(searchLower, 1, true)) or 
       (regionSearchText:lower():find(searchLower, 1, true)) or -- Matches against "Oceania", "Germany", etc.
       (factionSearchText:lower():find(searchLower, 1, true)) or 
       classMatch then
        return true
    end
    return false
end

-- [[ REALM INFO: Using RegionID to prevent table overlap ]] --
function FriendGroups_GetRealmInfo(gameAccountInfo)
    if not gameAccountInfo then return nil, nil end

    -- Detect regionID: 1=US, 2=KR, 3=EU, 4=TW, 5=CN
    local rid = gameAccountInfo.regionID
    local database = FriendGroups_RealmData -- Default Region 1
    
    if rid == 3 then 
        database = FriendGroups_RealmDataEU 
    elseif rid == 2 or rid == 4 or rid == 5 then 
        database = FriendGroups_RealmDataAsia
    end
    
    local rawRealm = gameAccountInfo.realmName
    if rawRealm and rawRealm ~= "" then
        local cleanRealm = rawRealm:gsub("%s+", "")
        local data = database[cleanRealm]
        
        if data then
            return "Interface\\AddOns\\OrzUI\\Media\\Modules\\FriendGroups\\" .. data.icon, data.region
        end
    end
    
    -- Final Fallback: Parse Rich Presence
    local richPresence = gameAccountInfo.richPresence or ""
    local extraction = richPresence:match("%s%-%s(.+)$")
    if extraction then
        local cleanEx = extraction:gsub("%s+", "")
        local data = database[cleanEx]
        if data then
            return "Interface\\AddOns\\OrzUI\\Media\\Modules\\FriendGroups\\" .. data.icon, data.region
        end
    end

    return nil, nil
end

function FriendGroups_FriendsListUpdateDividerTemplate(frame, elementData)
    local groupName = elementData.groupName
    local groupOnline = groupsCount[groupName] and groupsCount[groupName]["Online"] or 0
    local groupTotal = groupsCount[groupName] and groupsCount[groupName]["Total"] or 0

    if groupName and frame.name then
        -- Cleanup any old search/settings items if they exist on this recycled frame
        if _G["FriendGroupsSearch"] and _G["FriendGroupsSearch"]:GetParent() == frame then
             _G["FriendGroupsSearch"]:Hide()
        end
        local settingsBtn = _G["FriendGroupsSettingsBtn"]
        if settingsBtn and settingsBtn:GetParent() == frame then 
            settingsBtn:Hide() 
        end
        
        -- Standard Header Setup
        frame.name:Show()
        frame.name:SetText(groupName)
        frame.collapseButton:Show()
        if frame.info then frame.info:Show() end

        if groupName ~= FGL["GROUP_EMPTY"] then
            local groupInfo = string.format("%d/%d", groupOnline, groupTotal)
            if frame.info then frame.info:SetText(groupInfo) end
            if ShiGuangDB.FriendGroupscollapsed[groupName] then
                frame.collapseButton:SetNormalAtlas("Campaign_HeaderIcon_Closed")
            else
                frame.collapseButton:SetNormalAtlas("Campaign_HeaderIcon_Open")
            end
        else
            frame.collapseButton:Hide()
            if frame.info then frame.info:SetText("") end
        end

        frame:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
        frame:GetHighlightTexture():SetAlpha(0.2)
    end
end

function FriendGroups_FrameFriendDividerTemplateCollapseClick(self, button, down)
    -- FIX: Determine if 'self' is the Header (has .name) or the Button (needs .GetParent)
    local frame = self
    if not frame.name then
        frame = self:GetParent()
    end

    -- Safety check: If we still can't find the name, stop to prevent crash
    if not frame or not frame.name then return end

    local groupName = frame.name:GetText()
    
    if groupName then
        -- Toggle the collapsed state
        if ShiGuangDB.FriendGroupscollapsed[groupName] then
            ShiGuangDB.FriendGroupscollapsed[groupName] = false
        else
            ShiGuangDB.FriendGroupscollapsed[groupName] = true
        end
        
        -- Handle "Open only one group" setting
        if ShiGuangDB.FriendGroupsopen_one_group and not ShiGuangDB.FriendGroupscollapsed[groupName] then
            for key, _ in pairs(ShiGuangDB.FriendGroupscollapsed) do
                if key ~= groupName then
                    ShiGuangDB.FriendGroupscollapsed[key] = true
                end
            end
        end
        
        -- Refresh the list
        FriendGroups_FriendsListUpdate()
    end
end

function FriendGroups_FrameFriendDividerTemplateHeaderClick(self, button, down)
    local groupName = self and self:GetParent() and self:GetParent().name and self:GetParent().name:GetText() or
        self.name and self.name:GetText()

    -- Focus the search box if the user clicks the search bar area
    if groupName == "Search..." then
        if _G["FriendGroupsSearch"] then
            _G["FriendGroupsSearch"]:SetFocus()
        end
    elseif button == "RightButton" then
        -- [[ CHANGE START ]] --
        -- Fix: Pass 'groupName' as the value, not 'self'
        if groupName then
            ToggleDropDownMenu(1, groupName, FriendGroups_Menu, "cursor", 0, 0)
        end
        -- [[ CHANGE END ]] --
    else
        FriendGroups_FrameFriendDividerTemplateCollapseClick(self, button, down)
    end
end

FriendGroups_FriendsListButtonTemplateClick = function(self, button, down)
    if not FriendGroups_Loaded then return end -- Let Blizzard handle click if disabled
    
    if button == "LeftButton" and IsShiftKeyDown() then
        -- Handle Shift+Click for Custom Menu (Prevents Taint)
        local id = self.id
        local buttonType = self.buttonType
        local name = nil
        local bnetfriend = false

        if buttonType == FRIENDS_BUTTON_TYPE_WOW then
            local info = C_FriendList.GetFriendInfoByIndex(id)
            if info then name = info.name end
        elseif buttonType == FRIENDS_BUTTON_TYPE_BNET then
            local info = C_BattleNet.GetFriendAccountInfo(id)
            if info then 
                name = info.accountName 
                bnetfriend = true
            end
        end

        if name then
            FriendGroups_ClickedData = { name = name, bnetfriend = bnetfriend, id = id }
            ToggleDropDownMenu(1, nil, FriendGroups_ContextDropdown, "cursor", 0, 0)
        end
        
        return -- Stop here so we don't select the friend in the UI
    end

    -- Normal Click Behavior (Standard Selection)
    FriendGroupsFrame.selectionLocked = false
	FriendGroups_FriendsListUpdate()
end

function FriendGroups_FriendsFrameUpdateFriendInviteHeaderButton(button, elementData)
	button:SetFormattedText(FRIEND_REQUESTS, BNGetNumFriendInvites());
	local collapsed = GetCVarBool("friendInvitesCollapsed");
	if (collapsed) then
		button.DownArrow:Hide();
		button.RightArrow:Show();
	else
		button.DownArrow:Show();
		button.RightArrow:Hide();
	end
end

function FriendGroups_FriendsFrameUpdateFriendInviteButton(button, elementData)
	local id = elementData.id;
	button.buttonType = elementData.buttonType;
	button.id = id;

	local inviteID, accountName = BNGetFriendInviteInfo(id);
	button.Name:SetText(accountName);
	button.inviteID = inviteID;
	button.inviteIndex = button.id;
end

-- [[ MAIN INITIALIZATION ]] --
local frame = CreateFrame("frame", "FriendGroups")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PARTY_INVITE_REQUEST")
frame:RegisterEvent("QUEST_SESSION_CREATED")

frame:SetScript("OnEvent", function(self, event, arg1, ...)
if event == "ADDON_LOADED" and arg1 == "OrzUI" then
        local version = "12.0.3" or "Unknown"
        --Print(string.format(FGL["MSG_WELCOME"], version))
        
        -- [[[ DELETE OR COMMENT OUT THIS LINE ]]] --
        -- self:UnregisterEvent("ADDON_LOADED") 
        -- [[[ END CHANGE ]]] --

    elseif event == "PARTY_INVITE_REQUEST" then
        if FriendGroups_SavedVars and ShiGuangDB.FriendGroupsauto_accept_invite then
            AcceptGroup()
            StaticPopup_Hide("PARTY_INVITE")
            StaticPopup_Hide("PARTY_INVITE_REQUEST")
            StaticPopup_Hide("PARTY_INVITE_XREALM")
        end

    -- [[ SMART FIX: Auto Accept Party Sync ]] --
    elseif event == "QUEST_SESSION_CREATED" then
        if FriendGroups_SavedVars and ShiGuangDB.FriendGroupsauto_accept_sync then
            
            -- DEFINITION: A recursive function that tries to click, catches crashes, and retries.
            local function AttemptSyncAccept()
                -- 1. Stop if the dialog is gone (User closed it, or we already accepted)
                if not (QuestSessionManager and QuestSessionManager.StartDialog and QuestSessionManager.StartDialog:IsShown()) then
                    return 
                end

                -- 2. "Protected Call" (pcall). This wraps the click in a safety bubble.
                -- success = true if it clicked okay. 
                -- success = false if Blizzard's code crashed (nil table error).
                local success, err = pcall(function()
                    QuestSessionManager.StartDialog:Confirm()
                end)

                if success then
                    -- It worked! Clean up the UI.
                    QuestSessionManager.StartDialog:Hide()
                else
                    -- It crashed (Race Condition). 
                    -- We ignore the crash and try again in 0.5 seconds.
                    C_Timer.After(0.5, AttemptSyncAccept)
                end
            end

            -- START the loop
            AttemptSyncAccept()
        end

    elseif event == "PLAYER_LOGIN" then
        -- Default Saved Vars
        if not FriendGroups_SavedVars then
            FriendGroups_SavedVars = { collapsed = {}, hide_offline = true, colour_classes = true, show_faction_icons = true, show_realm = true, hide_high_level = true, add_favorite_group = true, add_mobile_text = true, show_search = true, auto_accept_invite = false, housing_mode_active = false, auto_accept_sync = false }
        end

        -- 1. Capture the current mode
        local isHousingMode = ShiGuangDB.FriendGroupshousing_mode_active

        -- 2. AUTO-RESET: Immediately flip the saved var to false.
        if isHousingMode then
            ShiGuangDB.FriendGroupshousing_mode_active = false
        end

        if isHousingMode then
            -- [[ SAFE MODE (HOUSING) ACTIVE ]] --
            local masterBtn = CreateFrame("Button", "FriendGroupsMasterControl", FriendsListFrame, "UIPanelButtonTemplate")
            
            masterBtn:SetFrameStrata("FULLSCREEN_DIALOG") 
            masterBtn:SetFrameLevel(9999)                 
            
            masterBtn:SetSize(374, 28)
            masterBtn:SetPoint("TOP", FriendsListFrame, "TOP", 0, -57)
            
            masterBtn:SetText("|cff3AFF00" .. FGL["RELOAD_BTN_TEXT"] .. "|r")
            
            masterBtn:SetScript("OnClick", function()
                ReloadUI()
            end)

            masterBtn:SetScript("OnEnter", function(s) 
                GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
                GameTooltip:SetText(FGL["RELOAD_TOOLTIP_TITLE"])
                GameTooltip:AddLine(FGL["RELOAD_TOOLTIP_DESC"], 1, 1, 1)
                GameTooltip:Show()
            end)
            masterBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

            Print(FGL["SAFE_MODE_WARNING"])
        else
            -- [[ NORMAL MODE ]] --
            EnableFriendGroups()
        end

        FriendsFrame:HookScript("OnHide", function()
            FriendsFrame.selectedFriend = nil
            FriendsFrame.selectedFriendType = nil
            FriendGroupsFrame.selectionLocked = true
        end)

        FriendsFrame:HookScript("OnShow", function()
            FriendsFrame.selectedFriend = nil
            FriendsFrame.selectedFriendType = nil
            FriendGroupsFrame.selectionLocked = true 
            FriendGroups_FriendsListUpdate(true)
        end)
    end
    
-- [[ HOUSING SAFETY SHIELD ]] --
    if event == "ADDON_LOADED" and arg1 == "Blizzard_HouseList" then
        if FriendGroups_Loaded then
            local w = CreateFrame("Frame", nil, HouseListFrame)
            w:SetFrameStrata("DIALOG")
            w:SetAllPoints(HouseListFrame)
            w:EnableMouse(true)
            
            local bg = w:CreateTexture(nil, "BACKGROUND")
            bg:SetAllPoints()
            bg:SetColorTexture(0, 0, 0, 0.9)
            
            local msg = w:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
            msg:SetPoint("CENTER", 0, 30)
            msg:SetText(FGL["SHIELD_MSG"])
            
            local b = CreateFrame("Button", nil, w, "UIPanelButtonTemplate")
            b:SetSize(200, 30)
            b:SetPoint("CENTER", 0, -50)
            b:SetText(FGL["SHIELD_BTN_TEXT"])
            b:SetScript("OnClick", function()
                ShiGuangDB.FriendGroupshousing_mode_active = true
                ReloadUI()
            end)
        end
    end
end)

