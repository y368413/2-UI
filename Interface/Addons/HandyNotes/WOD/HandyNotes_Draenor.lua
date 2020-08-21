HandyNotes_Draenor = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_Draenor", "AceBucket-3.0", "AceConsole-3.0", "AceEvent-3.0")
HandyNotes_Draenor.nodes = { nil }

HandyNotes_Draenor.DefaultIcons = {
    Icon_Treasure_Default = "Interface\\Icons\\TRADE_ARCHAEOLOGY_CHESTOFTINYGLASSANIMALS",
    Icon_Glider = "Interface\\Icons\\inv_feather_04",
    Icon_Rocket = "Interface\\Icons\\ability_mount_rocketmount",
    Icon_Skull_Blue = "Interface\\Worldmap\\Skull_64Blue",
    Icon_Skull_Green = "Interface\\Worldmap\\Skull_64Green.blp",
    Icon_Skull_Grey = "Interface\\MINIMAP\\Minimap_skull_normal",  --Interface\\Worldmap\\Skull_64Grey.tga
    Icon_Skull_Orange = "Interface\\MINIMAP\\Minimap_skull_elite.blp",
    Icon_Skull_Purple = "Interface\\Worldmap\\Skull_64Purple.blp",
    Icon_Skull_Red = "Interface\\Worldmap\\Skull_64Red.blp",
    Icon_Skull_Yellow = "Interface\\MINIMAP\\Minimap_skull_normal.blp",
    Icon_Fossil_Snail = "Interface\\Icons\\Trade_Archaeology_Fossil_SnailShell",
}

function HandyNotes_Draenor:OnInitialize()

    local Defaults = {
        profile = {
            Settings = {
                General = {
                    ShowNotes = true,
                },
                Treasures = {
                    ShowAlreadyCollected = false,
                    IconScale = 1.0,
                    IconAlpha = 1.0,
                },
                Rares = {
                    ShowAlreadyKilled = false,
                    IconScale = 1.0,
                    IconAlpha = 1.0,
                },
            },
            Zones = {
                FrostfireRidge = {
                    Rares = true,
                    Treasures = true,
                },
                ShadowmoonValley = {
                    Rares = true,
                    Treasures = true,
                },
                Nagrand = {
                    Rares = true,
                    Treasures = true,
                },
                Gorgrond = {
                    Rares = true,
                    Treasures = true,
                },
                SpiresOfArak = {
                    Rares = true,
                    Treasures = true,
                },
                Talador = {
                    Rares = true,
                    Treasures = true,
                },
                TanaanJungle = {
                    Rares = true,
                    Treasures = true,
                },
            },
            Mounts = {
                Mount_VoidTalon = true,
                Mount_Pathrunner = true,
                Mount_Terrorfist = true,
                Mount_Deathtalon = true,
                Mount_Vengeance = true,
                Mount_Doomroller = true,
                Mount_Silthide = true,
                Mount_Lukhok = true,
                Mount_NakkTheThunderer = true,
                Mount_Poundfist = true,
                Mount_Gorok = true,
                Mount_NokKarosh = true,
            },
            Integration = {
                DBM = {
                    Loaded = false,
                    ArrowCreated = false,
                    ArrowNote = nil,
                },
                TomTom = {
                    Loaded = true,
                },
            },
        },
    }

    self.db = LibStub("AceDB-3.0"):New("HandyNotes_DraenorDB", Defaults, "Default")

    --if HandyNotes then 
        self:RegisterEvent("PLAYER_ENTERING_WORLD", "WorldEnter")
    --else
        --return 
    --end

end

HandyNotes_Draenor.options = {
    type = "group",
    name = "Draenor",
    desc = "Locations of Rares and Treasures in Draenor",
    args = {

        IconSettingsGroup = {
            type = "group",
            order = 1,
            name = "Icon Settings:",
            inline = true,
            args = {
                Icon_Scale_Treasures = {
                    type = "range",
                    name = "Icon Scale for Treasures",
                    desc = "The scale of the icons",
                    min = 0.25, max = 3, step = 0.01,
                    order = 1,

                    get = function(info) return HandyNotes_Draenor.db.profile.Settings.Treasures.IconScale end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Settings.Treasures.IconScale = value; HandyNotes_Draenor:Refresh() end,
                },
                Icon_Scale_Rares = {
                    type = "range",
                    name = "Icon Scale for Rares",
                    desc = "The scale of the icons",
                    min = 0.25, max = 3, step = 0.01,
                    order = 2,

                    get = function(info) return HandyNotes_Draenor.db.profile.Settings.Rares.IconScale end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Settings.Rares.IconScale = value; HandyNotes_Draenor:Refresh() end,
                },
                Icon_Alpha_Treasures = {
                    type = "range",
                    name = "Icon Alpha for Treasures",
                    desc = "The alpha transparency of the icons",
                    min = 0, max = 1, step = 0.01,
                    order = 3,

                    get = function(info) return HandyNotes_Draenor.db.profile.Settings.Treasures.IconAlpha end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Settings.Treasures.IconAlpha = value; HandyNotes_Draenor:Refresh() end,
                },
                Icon_Alpha_Rares = {
                    type = "range",
                    name = "Icon Alpha for Rares",
                    desc = "The alpha transparency of the icons",
                    min = 0, max = 1, step = 0.01,
                    order = 4,

                    get = function(info) return HandyNotes_Draenor.db.profile.Settings.Rares.IconAlpha end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Settings.Rares.IconAlpha = value; HandyNotes_Draenor:Refresh() end,
                },
            },
        },
        VisibilityGroup = {
            type = "group",
            order = 2,
            name = "Visibility:",
            inline = true,
            args = {
                ShadowmoonValleyGroup = {
                    type = "header",
                    name = "Shadowmoon Valley",
                    desc = "Shadowmoon Valley",
                    order = 0,
                },
                ShadowmoonValleyTreasures = {
                    type = "toggle",
                    arg = "treasure_smv",
                    name = "Treasures",
                    desc = "Treasures that give various items",
                    order = 1,

                    get = function(info) return HandyNotes_Draenor.db.profile.Zones.ShadowmoonValley.Treasures end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Zones.ShadowmoonValley.Treasures = value; HandyNotes_Draenor:Refresh() end,
                },
                ShadowmoonValleyRares = {
                    type = "toggle",
                    arg = "rare_smv",
                    name = "Rares",
                    desc = "Rare spawns for leveling players",
                    order = 2,

                    get = function(info) return HandyNotes_Draenor.db.profile.Zones.ShadowmoonValley.Rares end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Zones.ShadowmoonValley.Rares = value; HandyNotes_Draenor:Refresh() end,
                },
                FrostfireRidgeGroup = {
                    type = "header",
                    name = "Frostfire Ridge",
                    desc = "Frostfire Ridge",
                    order = 10,
                },  
                FrostfireRidgeTreasures = {
                    type = "toggle",
                    name = "Treasures",
                    desc = "Treasures that give various items",
                    order = 11,

                    get = function(info) return HandyNotes_Draenor.db.profile.Zones.FrostfireRidge.Treasures end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Zones.FrostfireRidge.Treasures = value; HandyNotes_Draenor:Refresh() end,
                },
                FrostfireRidgeRares = {
                    type = "toggle",
                    name = "Rares",
                    desc = "Rare spawns for leveling players",
                    order = 12,

                    get = function(info) return HandyNotes_Draenor.db.profile.Zones.FrostfireRidge.Rares end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Zones.FrostfireRidge.Rares = value; HandyNotes_Draenor:Refresh() end,
                },
                GorgrondGroup = {
                    type = "header",
                    name = "Gorgrond",
                    desc = "Gorgrond",
                    order = 20,
                },  
                GorgrondTreasures = {
                    type = "toggle",
                    name = "Treasures",
                    desc = "Treasures that give various items",
                    order = 21,

                    get = function(info) return HandyNotes_Draenor.db.profile.Zones.Gorgrond.Treasures end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Zones.Gorgrond.Treasures = value; HandyNotes_Draenor:Refresh() end,
                },
                GorgrondRare = {
                    type = "toggle",
                    name = "Rares",
                    desc = "Rare spawns for leveling players",
                    order = 22,

                    get = function(info) return HandyNotes_Draenor.db.profile.Zones.Gorgrond.Rares end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Zones.Gorgrond.Rares = value; HandyNotes_Draenor:Refresh() end,
                },  
                TaladorGroup = {
                    type = "header",
                    name = "Talador",
                    desc = "Talador",
                    order = 30,
                },  
                TaladorTreasures = {
                    type = "toggle",
                    name = "Treasures",
                    desc = "Treasures that give various items",
                    order = 31,

                    get = function(info) return HandyNotes_Draenor.db.profile.Zones.Talador.Treasures end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Zones.Talador.Treasures = value; HandyNotes_Draenor:Refresh() end,
                },
                TaladorRares = {
                    type = "toggle",
                    name = "Rares",
                    desc = "Rare spawns for leveling players",
                    order = 32,

                    get = function(info) return HandyNotes_Draenor.db.profile.Zones.Talador.Rares end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Zones.Talador.Rares = value; HandyNotes_Draenor:Refresh() end,
                },  
                SpiresOfArakGroup = {
                    type = "header",
                    name = "Spires of Arak",
                    desc = "Spires of Arak",
                    order = 40,
                },    
                SpiresOfArakTreasures = {
                    type = "toggle",
                    name = "Treasures",
                    desc = "Treasures that give various items",
                    order = 41,

                    get = function(info) return HandyNotes_Draenor.db.profile.Zones.SpiresOfArak.Treasures end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Zones.SpiresOfArak.Treasures = value; HandyNotes_Draenor:Refresh() end,
                },
                SpiresOfArakRares = {
                    type = "toggle",
                    arg = "rare_soa",
                    name = "Rares",
                    desc = "Rare spawns for leveling players",
                    order = 42,

                    get = function(info) return HandyNotes_Draenor.db.profile.Zones.SpiresOfArak.Rares end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Zones.SpiresOfArak.Rares = value; HandyNotes_Draenor:Refresh() end,
                }, 
                NagrandGroup = {
                    type = "header",
                    name = "Nagrand",
                    desc = "Nagrand",
                    order = 50,
                },      
                NagrandTreasures = {
                    type = "toggle",
                    arg = "treasure_ng",
                    name = "Treasures",
                    desc = "Treasures that give various items",
                    order = 51,

                    get = function(info) return HandyNotes_Draenor.db.profile.Zones.Nagrand.Treasures end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Zones.Nagrand.Treasures = value; HandyNotes_Draenor:Refresh() end,
                },
                NagrandRares = {
                    type = "toggle",
                    name = "Rares",
                    desc = "Rare spawns for leveling players",
                    order = 52,

                    get = function(info) return HandyNotes_Draenor.db.profile.Zones.Nagrand.Rares end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Zones.Nagrand.Rares = value; HandyNotes_Draenor:Refresh() end,
                },
                TanaanJungleGroup = {
                    type = "header",
                    name = "Tanaan Jungle",
                    desc = "Tanaan Jungle",
                    order = 60,
                },
                TanaanJungleTreasures = {
                    type = "toggle",
                    name = "Treasures",
                    desc = "Treasures that give various items",
                    order = 61,

                    get = function(info) return HandyNotes_Draenor.db.profile.Zones.TanaanJungle.Treasures end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Zones.TanaanJungle.Treasures = value; HandyNotes_Draenor:Refresh() end,
                },
                TanaanJungleRares = {
                    type = "toggle",
                    name = "Rares",
                    desc = "Rare spawns for level 100 players",
                    order = 62,

                    get = function(info) return HandyNotes_Draenor.db.profile.Zones.TanaanJungle.Rares end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Zones.TanaanJungle.Rares = value; HandyNotes_Draenor:Refresh() end,
                },
                groupMount = {
                    type = "header",
                    name = "Mounts",
                    desc = "Mounts",
                    order = 70,
                },
                Mount_VoidTalon = {
                    type = "toggle",
                    name = "Void Talon",
                    desc = "Show Mount Void Talon",
                    order = 71,

                    get = function(info) return HandyNotes_Draenor.db.profile.Mounts.Mount_VoidTalon end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Mounts.Mount_VoidTalon = value; HandyNotes_Draenor:Refresh() end,
                },
                Mount_Pathrunner = {
                    type = "toggle",
                    name = "Pathrunner",
                    desc = "Show Mount Pathrunner",
                    order = 72,

                    get = function(info) return HandyNotes_Draenor.db.profile.Mounts.Mount_Pathrunner end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Mounts.Mount_Pathrunner = value; HandyNotes_Draenor:Refresh() end,
                },
                Mount_Terrorfist = {
                    type = "toggle",
                    name = "Terrorfist",
                    desc = "Show Mount Terrorfist",
                    order = 73,

                    get = function(info) return HandyNotes_Draenor.db.profile.Mounts.Mount_Terrorfist end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Mounts.Mount_Terrorfist = value; HandyNotes_Draenor:Refresh() end,
                },
                Mount_Deathtalon = {
                    type = "toggle",
                    name = "Deathtalon",
                    desc = "Show Mount Deathtalon",
                    order = 74,

                    get = function(info) return HandyNotes_Draenor.db.profile.Mounts.Mount_Deathtalon end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Mounts.Mount_Deathtalon = value; HandyNotes_Draenor:Refresh() end,
                },
                Mount_Doomroller = {
                    type = "toggle",
                    name = "Doomroller",
                    desc = "Show Mount Doomroller",
                    order = 75,

                    get = function(info) return HandyNotes_Draenor.db.profile.Mounts.Mount_Doomroller end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Mounts.Mount_Doomroller = value; HandyNotes_Draenor:Refresh() end,
                },
                Mount_Silthide = {
                    type = "toggle",
                    name = "Silthide",
                    desc = "Show Mount Silthide",
                    order = 76,

                    get = function(info) return HandyNotes_Draenor.db.profile.Mounts.Mount_Silthide end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Mounts.Mount_Silthide = value; HandyNotes_Draenor:Refresh() end,
                },
                Mount_Lukhok = {
                    type = "toggle",
                    name = "Luk Hok",
                    desc = "Show Mount Luk Hok",
                    order = 77,

                    get = function(info) return HandyNotes_Draenor.db.profile.Mounts.Mount_Lukhok end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Mounts.Mount_Lukhok = value; HandyNotes_Draenor:Refresh() end,
                },
                Mount_NakkTheThunderer = {
                    type = "toggle",
                    name = "Nakk the Thunderer",
                    desc = "Show Mount Nakk the Thunderer",
                    order = 78,

                    get = function(info) return HandyNotes_Draenor.db.profile.Mounts.Mount_NakkTheThunderer end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Mounts.Mount_NakkTheThunderer = value; HandyNotes_Draenor:Refresh() end,
                },
                Mount_Poundfist = {
                    type = "toggle",
                    name = "Poundfist",
                    desc = "Show Mount Poundfist",
                    order = 79,

                    get = function(info) return HandyNotes_Draenor.db.profile.Mounts.Mount_Poundfist end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Mounts.Mount_Poundfist = value; HandyNotes_Draenor:Refresh() end,
                },
                Mount_Gorok = {
                    type = "toggle",
                    name = "Gorok",
                    desc = "Show Mount Gorok",
                    order = 80,

                    get = function(info) return HandyNotes_Draenor.db.profile.Mounts.Mount_Gorok end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Mounts.Mount_Gorok = value; HandyNotes_Draenor:Refresh() end,
                },
                Mount_NokKarosh = {
                    type = "toggle",
                    name = "Nok Karosh",
                    desc = "Show Mount Nok Karosh",
                    order = 80,

                    get = function(info) return HandyNotes_Draenor.db.profile.Mounts.Mount_NokKarosh end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Mounts.Mount_NokKarosh = value; HandyNotes_Draenor:Refresh() end,
                },
            },
        },
        TooltipSettingsGroup = {
            type = "group",
            order = 3,
            name = "Tooltip Settings:",
            inline = true,
            args = {
                ShowNotes = {
                    type = "toggle",
                    name = "Show Notes",
                    desc = "Display Notes for some POI's",
                    order = 2,

                    get = function(info) return HandyNotes_Draenor.db.profile.Settings.General.ShowNotes end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Settings.General.ShowNotes = value; HandyNotes_Draenor:Refresh() end,
                },
            },
        },
        GeneralGroup = {
            type = "group",
            order = 4,
            name = "General Settings:",
            inline = true,
            args = {
                ShowAlreadyKilledRares = {
                    type = "toggle",
                    name = "Already killed Rares",
                    desc = "Show already killed Rares",
                    order = 1,

                    get = function(info) return HandyNotes_Draenor.db.profile.Settings.Rares.ShowAlreadyKilled end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Settings.Rares.ShowAlreadyKilled = value; HandyNotes_Draenor:Refresh() end,
                },
                ShowAlreadyCollectedTreasures = {
                    type = "toggle",
                    name = "Already looted Treasures",
                    desc = "Show already looted Treasures",
                    order = 2,

                    get = function(info) return HandyNotes_Draenor.db.profile.Settings.Treasures.ShowAlreadyCollected end,
                    set = function(info, value) HandyNotes_Draenor.db.profile.Settings.Treasures.ShowAlreadyCollected = value; HandyNotes_Draenor:Refresh() end,
                },
            },
        },
    },
}

HandyNotes_Draenor.nodes["SpiresOfArak"] = {
    [40595497] = { "SpiresOfArak", "36458", "Abandoned Mining Pick", "i578 Strength 1H Axe", "Allows faster Mining in Draenor", "Icon_Treasure_Default", "Treasure", "116913" },
    [36195446] = { "SpiresOfArak", "36462", "Admiral Taylor's Coffer", "Garrison Resources", "Requires An Old Key", "Icon_Treasure_Default", "Treasure", "824" },
    [37705640] = { "SpiresOfArak", "36462", "An Old Key", "Key for a Chest in Admiral Taylors Garrison", "nil", "Icon_Treasure_Default", "Treasure", "116020" },
    [49203721] = { "SpiresOfArak", "36445", "Assassin's Spear", "i580 Agility Polearm", "nil", "Icon_Treasure_Default", "Treasure", "116835" },
    [55539086] = { "SpiresOfArak", "36367", "Campaign Contributions", "Gold", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [68428898] = { "SpiresOfArak", "36453", "Coinbender's Payment", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [36585791] = { "SpiresOfArak", "36418", "Ephial's Dark Grimoire", "i579 Offhand", "nil", "Icon_Treasure_Default", "Treasure", "116914" },
    [50502210] = { "SpiresOfArak", "36246", "Fractured Sunstone", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "116919" },
    [37154750] = { "SpiresOfArak", "36420", "Garrison Supplies", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [41855042] = { "SpiresOfArak", "36451", "Garrison Workman's Hammer", "i580 Strength 1H Mace", "nil", "Icon_Treasure_Default", "Treasure", "116918" },
    [48604450] = { "SpiresOfArak", "36386", "Gift of Anzu", "i585 Crossbow", "Drink an Elixir of Shadow Sight near the Shrine to get the Gift of Anzu", "Icon_Treasure_Default", "Treasure", "118237" },
    [57007900] = { "SpiresOfArak", "36390", "Gift of Anzu", "i585 Caster 1H Sword", "Drink an Elixir of Shadow Sight near the Shrine to get the Gift of Anzu", "Icon_Treasure_Default", "Treasure", "118241" },
    [46954044] = { "SpiresOfArak", "36389", "Gift of Anzu", "i585 Agility/Strength Polearm", "Drink an Elixir of Shadow Sight near the Shrine to get the Gift of Anzu", "Icon_Treasure_Default", "Treasure", "118238" },
    [52031958] = { "SpiresOfArak", "36392", "Gift of Anzu", "i585 Caster Staff", "Drink an Elixir of Shadow Sight near the Shrine to get the Gift of Anzu", "Icon_Treasure_Default", "Treasure", "118239" },
    [42402670] = { "SpiresOfArak", "36388", "Gift of Anzu", "i585 Wand", "Drink an Elixir of Shadow Sight near the Shrine to get the Gift of Anzu", "Icon_Treasure_Default", "Treasure", "118242" },
    [61105537] = { "SpiresOfArak", "36381", "Gift of Anzu", "i585 Agility/Strength 1H Sword", "Drink an Elixir of Shadow Sight near the Shrine to get the Gift of Anzu", "Icon_Treasure_Default", "Treasure", "118240" },
    [50332579] = { "SpiresOfArak", "36444", "Iron Horde Explosives", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "118691" },
    [50782874] = { "SpiresOfArak", "36247", "Lost Herb Satchel", "Herbs", "nil", "Icon_Treasure_Default", "Treasure", "109124" },
    [47773612] = { "SpiresOfArak", "36411", "Lost Ring", "i578 Intellect Ring", "nil", "Icon_Treasure_Default", "Treasure", "116911" },
    [52474280] = { "SpiresOfArak", "36416", "Misplaced Scroll", "Archaeology Fragments", "Requires Archaeology and possibly a little bit of jumping", "Icon_Treasure_Default", "Treasure", "nil" },
    [42691832] = { "SpiresOfArak", "36244", "Misplaced Scrolls", "Archaeology Fragments", "Requires Archaeology and possibly a little bit of jumping", "Icon_Treasure_Default", "Treasure", "nil" },
    [63586737] = { "SpiresOfArak", "36454", "Mysterious Mushrooms", "Herbs", "nil", "Icon_Treasure_Default", "Treasure", "109127" },
    [60808780] = { "SpiresOfArak", "35481", "Nizzix's Chest", "Garrison Resources", "Click on Nizzix's Escape Pod at 60.9 88.0 and follow him to the shore", "Icon_Treasure_Default", "Treasure", "824" },
    [53315552] = { "SpiresOfArak", "36403", "Offering to the Raven Mother 1", "Consumable for 5% rested XP", "nil", "Icon_Treasure_Default", "Treasure", "118267" },
    [48355261] = { "SpiresOfArak", "36405", "Offering to the Raven Mother 2", "Consumable for 5% rested XP", "nil", "Icon_Treasure_Default", "Treasure", "118267" },
    [48905470] = { "SpiresOfArak", "36406", "Offering to the Raven Mother 3", "Consumable for 5% rested XP", "nil", "Icon_Treasure_Default", "Treasure", "118267" },
    [51886465] = { "SpiresOfArak", "36407", "Offering to the Raven Mother 4", "Consumable for 5% rested XP", "nil", "Icon_Treasure_Default", "Treasure", "118267" },
    [60976387] = { "SpiresOfArak", "36410", "Offering to the Raven Mother 5", "Consumable for 5% rested XP", "nil", "Icon_Treasure_Default", "Treasure", "118267" },
    [58706024] = { "SpiresOfArak", "36340", "Ogron Plunder", "Trash Items", "nil", "Icon_Treasure_Default", "Treasure", "116921" },
    [36283934] = { "SpiresOfArak", "36402", "Orcish Signaling Horn", "i577 Trinket Multistrike + Strength Proc", "nil", "Icon_Treasure_Default", "Treasure", "120337" },
    [36821716] = { "SpiresOfArak", "36243", "Outcast's Belongings 1", "Gold + Random Green", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [42172168] = { "SpiresOfArak", "36447", "Outcast's Belongings 2", "Gold + Random Green", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [46903406] = { "SpiresOfArak", "36446", "Outcast's Pouch", "Gold + Random Green", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [42961637] = { "SpiresOfArak", "36245", "Relics of the Outcasts 1", "Archaeology Fragments", "Requires Archaeology and possibly a little bit of jumping", "Icon_Treasure_Default", "Treasure", "nil" },
    [45964415] = { "SpiresOfArak", "36354", "Relics of the Outcasts 2", "Archaeology Fragments", "Requires Archaeology and possibly a little bit of jumping", "Icon_Treasure_Default", "Treasure", "nil" },
    [43162726] = { "SpiresOfArak", "36355", "Relics of the Outcasts 3", "Archaeology Fragments", "Requires Archaeology and possibly a little bit of jumping", "Icon_Treasure_Default", "Treasure", "nil" },
    [67373983] = { "SpiresOfArak", "36356", "Relics of the Outcasts 4", "Archaeology Fragments", "Requires Archaeology and possibly a little bit of jumping", "Icon_Treasure_Default", "Treasure", "nil" },
    [60215391] = { "SpiresOfArak", "36359", "Relics of the Outcasts 5", "Archaeology Fragments", "Requires Archaeology and possibly a little bit of jumping", "Icon_Treasure_Default", "Treasure", "nil" },
    [51894892] = { "SpiresOfArak", "36360", "Relics of the Outcasts 6", "Archaeology Fragments", "Requires Archaeology and possibly a little bit of jumping", "Icon_Treasure_Default", "Treasure", "nil" },
    [37375056] = { "SpiresOfArak", "36657", "Rooby's Roo", "i581 Strength Neck", "You need to feed the dog with Rooby Reat from the chef in the cellar", "Icon_Treasure_Default", "Treasure", "116887" },
    [44331204] = { "SpiresOfArak", "36377", "Rukhmar's Image", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "118693" },
    [59179064] = { "SpiresOfArak", "36366", "Sailor Zazzuk's 180-Proof Rum", "Alcoholic Beverages", "nil", "Icon_Treasure_Default", "Treasure", "116917" },
    [68333893] = { "SpiresOfArak", "36375", "Sethekk Idol", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "118692" },
    [71644859] = { "SpiresOfArak", "36450", "Sethekk Ritual Brew", "Healing Potions + Alcoholic Beverages", "nil", "Icon_Treasure_Default", "Treasure", "109223" },
    [56232881] = { "SpiresOfArak", "36362", "Shattered Hand Cache", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [47923065] = { "SpiresOfArak", "36361", "Shattered Hand Lockbox", "True Steel Lockbox", "nil", "Icon_Treasure_Default", "Treasure", "116920" },
    [60868461] = { "SpiresOfArak", "36456", "Shredder Parts", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [56294531] = { "SpiresOfArak", "36433", "Smuggled Apexis Artifacts", "Archaeology Fragments", "Requires Archaeology and possibly a little bit of jumping", "Icon_Treasure_Default", "Treasure", "nil" },
    [59638134] = { "SpiresOfArak", "36365", "Spray-O-Matic 5000 XT", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [34142751] = { "SpiresOfArak", "36421", "Sun-Touched Cache 1", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [33292727] = { "SpiresOfArak", "36422", "Sun-Touched Cache 2", "Archaeology Fragments", "Requires Archaeology and possibly a little bit of jumping", "Icon_Treasure_Default", "Treasure", "nil" },
    [54353255] = { "SpiresOfArak", "36364", "Toxicfang Venom", "100 Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "118695" },
    [66475653] = { "SpiresOfArak", "36455", "Waterlogged Satchel", "Gold + Random Green", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [57802220] = { "SpiresOfArak", "36374", "Statue of Anzu", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "118694" },

    [58208460] = { "SpiresOfArak", "36291", "Betsi Boombasket", "i583 Gun", "nil", "Icon_Skull_Grey", "Rare", "116907" },
    [46802300] = { "SpiresOfArak", "35599", "Blade-Dancer Aeryx", "Trash Item", "nil", "Icon_Skull_Grey", "Rare", "116839" },
    [64006480] = { "SpiresOfArak", "36283", "Blightglow", "i586 Agility/Intellect Leather Shoulders", "nil", "Icon_Skull_Grey", "Rare", "118205" },
    [46402860] = { "SpiresOfArak", "36267", "Durkath Steelmaw", "i586 Agility/Intellect Mail Boots", "nil", "Icon_Skull_Grey", "Rare", "118198" },
    [69005400] = { "SpiresOfArak", "37406", "Echidna", "unknown", "Level 100", "Icon_Skull_Blue", "Rare", "nil" },
    [54803960] = { "SpiresOfArak", "36297", "Festerbloom", "i584 Offhand", "nil", "Icon_Skull_Grey", "Rare", "118200" },
    [25202420] = { "SpiresOfArak", "36943", "Gaze", "Garrison Resources", "nil", "Icon_Skull_Grey", "Rare", "824" },
    [74404280] = { "SpiresOfArak", "37390", "Gluttonous Giant", "i620 Wand", "Level 100", "Icon_Skull_Blue", "Rare", "119404" },
    [33005900] = { "SpiresOfArak", "36305", "Gobblefin", "Trash Item", "nil", "Icon_Skull_Grey", "Rare", "116836" },
    [59201500] = { "SpiresOfArak", "36887", "Hermit Palefur", "i582 Cloth Helm", "nil", "Icon_Skull_Grey", "Rare", "118279" },
    [56609460] = { "SpiresOfArak", "36306", "Jiasska the Sporegorger", "i589 Trinket Haste + Int Proc", "nil", "Icon_Skull_Grey", "Rare", "118202" },
    [62603740] = { "SpiresOfArak", "36268", "Kalos the Bloodbathed", "i588 Cloth Body", "nil", "Icon_Skull_Grey", "Rare", "118735" },
    [53208900] = { "SpiresOfArak", "36396", "Mutafen", "i589 Strength 2H Mace", "nil", "Icon_Skull_Grey", "Rare", "118206" },
    [36405240] = { "SpiresOfArak", "36129", "Nas Dunberlin", "i578 Agility/Strength Polearm", "nil", "Icon_Skull_Grey", "Rare", "116837" },
    [66005500] = { "SpiresOfArak", "36288", "Oskiira the Vengeful", "i589 Agility Dagger", "nil", "Icon_Skull_Grey", "Rare", "118204" },
    [59403740] = { "SpiresOfArak", "36279", "Poisonmaster Bortusk", "i583 Trinket Multistrike + DMG on Use", "nil", "Icon_Skull_Grey", "Rare", "118199" },
    [38402780] = { "SpiresOfArak", "36470", "Rotcap", "Pet", "nil", "Icon_Skull_Green", "Rare", "118107" },
    [69004880] = { "SpiresOfArak", "36276", "Sangrikrass", "i589 Agility/Intellect Leather Body", "nil", "Icon_Skull_Grey", "Rare", "118203" },
    [71203380] = { "SpiresOfArak", "37392", "Shadow Hulk", "i620 Agility/Intellect Leather Pants", "Level 100", "Icon_Skull_Blue", "Rare", "119363" },
    [52003540] = { "SpiresOfArak", "36478", "Shadowbark", "i579 Caster Shield", "nil", "Icon_Skull_Grey", "Rare", "118201" },
    [51800720] = { "SpiresOfArak", "37394", "Solar Magnifier", "i620 Intellect Polearm", "Level 100", "Icon_Skull_Blue", "Rare", "119407" },
    [33402200] = { "SpiresOfArak", "36265", "Stonespite", "i577 Agility/Intellect Mail Pants", "nil", "Icon_Skull_Grey", "Rare", "116858" },
    [58604520] = { "SpiresOfArak", "36298", "Sunderthorn", "i578 Agility 1H Sword", "nil", "Icon_Skull_Grey", "Rare", "116855" },
    [52805480] = { "SpiresOfArak", "36472", "Swarmleaf", "i582 Caster Staff", "nil", "Icon_Skull_Grey", "Rare", "116857" },
    [54606320] = { "SpiresOfArak", "36278", "Talonbreaker", "i578 Agility Neck", "nil", "Icon_Skull_Grey", "Rare", "116838" },
    [57407400] = { "SpiresOfArak", "36254", "Tesska the Broken", "i578 Intellect Neck", "nil", "Icon_Skull_Grey", "Rare", "116852" },
    [71702010] = { "SpiresOfArak", "37360", "Formless Nightmare", "i620 Agility/Intellect Mail Bracer", "Level 100  Located inside Void Portal phase", "Icon_Skull_Blue", "Rare", "119373" },
    [71404500] = { "SpiresOfArak", "37393", "Giga Sentinel", "i620 Agility 1H Sword", "Level 100", "Icon_Skull_Blue", "Rare", "119401" },
    [70402380] = { "SpiresOfArak", "37361", "Kenos the Unraveler", "i620 Cloth Helm", "Level 100  Located inside Void Portal phase; requires 3 players to click objects to summon", "Icon_Skull_Blue", "Rare", "119354" },
    [74413864] = { "SpiresOfArak", "37391", "Mecha Plunderer", "i620 Agility 1H Mace", "Level 100", "Icon_Skull_Blue", "Rare", "119398" },
    [72401940] = { "SpiresOfArak", "37358", "Soul-Twister Torek", "Toy + i620 Caster Staff", "Level 100", "Icon_Skull_Green", "Rare", "119410" },
    [72903090] = { "SpiresOfArak", "37359", "Voidreaver Urnae", "i620 Agility 1H Axe", "Level 100", "Icon_Skull_Blue", "Rare", "119392" },

    [47002000] = { "SpiresOfArak", "99999909", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [50400610] = { "SpiresOfArak", "99999909", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [36551820] = { "SpiresOfArak", "99999909", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [60801120] = { "SpiresOfArak", "99999909", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
}

HandyNotes_Draenor.nodes["FrostfireRidge"] = {
    [23172495] = { "FrostfireRidge", "33916", "Arena Master's War Horn", "Toy", "Up in the stands above the arena", "Icon_Treasure_Default", "Treasure", "108735" },
    [24242712] = { "FrostfireRidge", "33501", "Arena Spectator's Chest", "Alcoholic Beverages", "On top of the stone arch; jump to it from the top of the nearby tower", "Icon_Treasure_Default", "Treasure", "63293" },
    [61904254] = { "FrostfireRidge", "33511", "Borrok the Devourer", "i516 Intellect Shield", "Feed him 20 Ogres to get the loot", "Icon_Treasure_Default", "Treasure", "112110" },
    [42161930] = { "FrostfireRidge", "34520", "Burning Pearl", "i525 Trinket Multistrike + Mastery Proc", "Level 100", "Icon_Treasure_Default", "Treasure", "120341" },
    [50161870] = { "FrostfireRidge", "33531", "Clumsy Cragmaul Brute", "i516 Agility/Intellect Mail Helm", "Level 100  On lower cliff ledge", "Icon_Treasure_Default", "Treasure", "112096" },
    [42663175] = { "FrostfireRidge", "33940", "Crag-Leaper's Cache", "i516 Agility/Intellect Mail Boots", "Jump on the spears in the wall to reach it", "Icon_Treasure_Default", "Treasure", "112187" },
    [40902010] = { "FrostfireRidge", "34473", "Envoy's Satchel", "Trash Item", "Level 100", "Icon_Treasure_Default", "Treasure", "110536" },
    [43665562] = { "FrostfireRidge", "34841", "Forgotten Supplies", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [24184860] = { "FrostfireRidge", "34507", "Frozen Frostwolf Axe", "i516 Spellpower Axe", "in a cave", "Icon_Treasure_Default", "Treasure", "110689" },
    [57175216] = { "FrostfireRidge", "34476", "Frozen Orc Skeleton", "i516 Trinket Mastery + Pet Proc", "nil", "Icon_Treasure_Default", "Treasure", "111554" },
    [25522050] = { "FrostfireRidge", "34648", "Gnawed Bone", "i516 Agility Dagger", "nil", "Icon_Treasure_Default", "Treasure", "111415" },
    [66712640] = { "FrostfireRidge", "33948", "Goren Leftovers", "25 Garrison Resources", "Level 100  In a cave on top of a mountain, path upwards starts at 69.3, 24", "Icon_Treasure_Default", "Treasure", "111543" },
    [68124586] = { "FrostfireRidge", "33947", "Grimfrost Treasure", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [56727186] = { "FrostfireRidge", "36863", "Iron Horde Munitions", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [68906910] = { "FrostfireRidge", "33017", "Iron Horde Supplies", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [21890963] = { "FrostfireRidge", "33926", "Lagoon Pool", "Toy", "Requires Fishing", "Icon_Treasure_Default", "Treasure", "108739" },
    [19211202] = { "FrostfireRidge", "34642", "Lucky Coin", "Flavor Item - Gold Coin", "Sells for 25g", "Icon_Treasure_Default", "Treasure", "111408" },
    [38303782] = { "FrostfireRidge", "33502", "Obsidian Petroglyph", "Consumable for 5% rested XP", "On a mountain; ramp starts up the mountain at 39, 42.5", "Icon_Treasure_Default", "Treasure", "112087" },
    [28296663] = { "FrostfireRidge", "34470", "Pale Fishmonger", "Fish", "nil", "Icon_Treasure_Default", "Treasure", "111666" },
    [21685076] = { "FrostfireRidge", "34931", "Pale Loot Sack", "Garrison Resources", "In a cave", "Icon_Treasure_Default", "Treasure", "824" },
    [37265914] = { "FrostfireRidge", "34967", "Raided Loot", "Garrison Resources", "On top of the tower", "Icon_Treasure_Default", "Treasure", "824" },
    [09834533] = { "FrostfireRidge", "34641", "Sealed Jug", "Flavor Item - Lore", "nil", "Icon_Treasure_Default", "Treasure", "111407" },
    [27654280] = { "FrostfireRidge", "33500", "Slave's Stash", "Alcoholic Beverages", "nil", "Icon_Treasure_Default", "Treasure", "43696" },
    [23971291] = { "FrostfireRidge", "34647", "Snow-Covered Strongbox", "Gold", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [16124972] = { "FrostfireRidge", "33942", "Supply Dump", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [64722573] = { "FrostfireRidge", "33946", "Survivalist's Cache", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [34192348] = { "FrostfireRidge", "32803", "Thunderlord Cache", "i516 Agility/Strength Polearm", "nil", "Icon_Treasure_Default", "Treasure", "107658" },
    [64406586] = { "FrostfireRidge", "33505", "Wiggling Egg", "Pet", "nil", "Icon_Treasure_Default", "Treasure", "112107" },
    [54843545] = { "FrostfireRidge", "33525", "Young Orc Traveler", "Unknown", "You need to Collect Parts from Young Orc Woman and Young Orc Traveler to finish this", "Icon_Treasure_Default", "Treasure", "112206" },
    [63401470] = { "FrostfireRidge", "33525", "Young Orc Woman", "Unknown", "You need to Collect Parts from Young Orc Woman and Young Orc Traveler to finish this", "Icon_Treasure_Default", "Treasure", "112206" },
    [39661718] = { "FrostfireRidge", "33532", "Cragmaul Cache", "Primal Spirit + Apexis Crystals", "Level 100", "Icon_Treasure_Default", "Treasure", "120945" },
    [45365034] = { "FrostfireRidge", "33011", "Grizzled Frostwolf Veteran", "i516 Trinket Stamina + 2% Heal on Kill", "Loot contained in Dusty Chest after talking to NPC and defeating waves of orcs", "Icon_Treasure_Default", "Treasure", "106899" },

    [88605740] = { "FrostfireRidge", "37525", "Ak'ox the Slaughterer", "i620 Agility/Intellect Leather Waist", "Level 100", "Icon_Skull_Blue", "Rare", "119365" },
    [27405000] = { "FrostfireRidge", "34497", "Breathless", "Toy", "nil", "Icon_Skull_Green", "Rare", "111476" },
    [66403140] = { "FrostfireRidge", "33843", "Broodmother Reeg'ak", "i516 Trinket Intellect + Multistrike Proc", "nil", "Icon_Skull_Grey", "Rare", "111533" },
    [34002320] = { "FrostfireRidge", "32941", "Canyon Icemother", "25 Garrison Resources", "nil", "Icon_Skull_Grey", "Rare", "101436" },
    [41206820] = { "FrostfireRidge", "34843", "Chillfang", "i513 Agility/Intellect Leather Pants", "nil", "Icon_Skull_Grey", "Rare", "111953" },
    [40404700] = { "FrostfireRidge", "33014", "Cindermaw", "i516 Caster Dagger", "nil", "Icon_Skull_Grey", "Rare", "111490" },
    [25405500] = { "FrostfireRidge", "34129", "Coldstomp the Griever", "i516 Intellect Neck", "nil", "Icon_Skull_Grey", "Rare", "112066" },
    [54606940] = { "FrostfireRidge", "34131", "Coldtusk", "i516 Agility/Strength 1H Sword", "nil", "Icon_Skull_Grey", "Rare", "111484" },
    [67407820] = { "FrostfireRidge", "34477", "Cyclonic Fury", "i516 Cloth Shoulders", "nil", "Icon_Skull_Grey", "Rare", "112086" },
    [71404680] = { "FrostfireRidge", "33504", "Firefury Giant", "i516 Offhand", "nil", "Icon_Skull_Grey", "Rare", "107661" },
    [54602220] = { "FrostfireRidge", "32918", "Giant-Slayer Kul", "i516 Trinket Versatility + Agility Proc", "nil", "Icon_Skull_Grey", "Rare", "111530" },
    [70003600] = { "FrostfireRidge", "37562", "Gorg'ak the Lava Guzzler", "i620 Strength Fistweapon", "Level 100", "Icon_Skull_Blue", "Rare", "111545" },
    [70003600] = { "FrostfireRidge", "37388", "Gorivax", "i620 Intellect Cloth Bracer", "nil", "Icon_Skull_Blue", "Rare", "119358" },
    [38606300] = { "FrostfireRidge", "34865", "Grutush the Pillager", "i513 Agility/Intellect Mail Pants", "nil", "Icon_Skull_Grey", "Rare", "112077" },
    [50305260] = { "FrostfireRidge", "34825", "Gruuk", "i513 Trinket Haste + Critical Strike", "nil", "Icon_Skull_Grey", "Rare", "111948" },
    [47005520] = { "FrostfireRidge", "34839", "Gurun", "i513 Strength Cloak", "nil", "Icon_Skull_Grey", "Rare", "111955" },
    [68801940] = { "FrostfireRidge", "37382", "Hoarfrost", "i620 Intellect Spirit Ring", "Level 101", "Icon_Skull_Blue", "Rare", "119415" },
    [58603420] = { "FrostfireRidge", "34130", "Huntmaster Kuang", "Garrison Resources", "nil", "Icon_Skull_Grey", "Rare", "824" },
    [48202340] = { "FrostfireRidge", "37386", "Jabberjaw", "i620 Caster Shield", "Level 101", "Icon_Skull_Blue", "Rare", "119390" },
    [61602640] = { "FrostfireRidge", "34708", "Jehil the Climber", "i516 Agility/Intellect Leather Boots", "nil", "Icon_Skull_Grey", "Rare", "112078" },
    [43002100] = { "FrostfireRidge", "37387", "Moltnoma", "i620 Cloth Shoulders", "Level 101", "Icon_Skull_Blue", "Rare", "119356" },
    [70002700] = { "FrostfireRidge", "37381", "Mother of Goren", "i620 Strength Neck", "Level 101", "Icon_Skull_Blue", "Rare", "119376" },
    [83604720] = { "FrostfireRidge", "37402", "Ogom the Mangler", "i620 Agility/Intellect Leather Bracer", "Level 100", "Icon_Skull_Blue", "Rare", "119366" },
    [36803400] = { "FrostfireRidge", "33938", "Primalist Mur'og", "i516 Cloth Pants", "nil", "Icon_Skull_Grey", "Rare", "111576" },
    [86604880] = { "FrostfireRidge", "37401", "Ragore Driftstalker", "i620 Agility/Intellect Leather Chest", "Level 100", "Icon_Skull_Blue", "Rare", "119359" },
    [76406340] = { "FrostfireRidge", "34132", "Scout Goreseeker", "i516 Agility/Intellect Leather Body", "nil", "Icon_Skull_Grey", "Rare", "112094" },
    [45001500] = { "FrostfireRidge", "37385", "Slogtusk the Corpse-Eater", "i620 Agility/Intellect Leather Helm", "Level 101", "Icon_Skull_Blue", "Rare", "119362" },
    [38201600] = { "FrostfireRidge", "37383", "Son of Goramal", "i620 Caster Mace", "Level 101", "Icon_Skull_Blue", "Rare", "119399" },
    [26803160] = { "FrostfireRidge", "34133", "The Beater", "i516 Strength 2H Mace", "nil", "Icon_Skull_Grey", "Rare", "111475" },
    [72203300] = { "FrostfireRidge", "37361", "The Bone Crawler", "i620 Intellect/Strength Plate Chest", "Level 101", "Icon_Skull_Blue", "Rare", "111534" },
    [43600940] = { "FrostfireRidge", "37384", "Tor'goroth", "i620 Offhand + Flavor Item", "Level 101", "Icon_Skull_Blue", "Rare", "119379" },
    [40601240] = { "FrostfireRidge", "34522", "Ug'lok the Frozen", "i620 Intellect Staff", "Level 101", "Icon_Skull_Blue", "Rare", "119409" },
    [72402420] = { "FrostfireRidge", "37378", "Valkor", "100 Garrison Resources", "Level 101", "Icon_Skull_Blue", "Rare", "119416" },
    [70603900] = { "FrostfireRidge", "37379", "Vrok the Ancient", "100 Garrison Resources", "Level 101", "Icon_Skull_Blue", "Rare", "119416" },
    [40402780] = { "FrostfireRidge", "34559", "Yaga the Scarred", "i516 Agility/Intellect Leather Waist", "On the lower cliff ledge", "Icon_Skull_Grey", "Rare", "111477" },
    [84604680] = { "FrostfireRidge", "37403", "Earthshaker Holar", "i620 Agility Neck", "Level 100", "Icon_Skull_Blue", "Rare", "119374" },
    [66602540] = { "FrostfireRidge", "37380", "Gibblette the Cowardly", "i620 Agility Cloak + Flavor item", "Level 101  In a cave on top of a mountain, path upwards starts at 69.3, 24", "Icon_Skull_Blue", "Rare", "119349" },
    [86804500] = { "FrostfireRidge", "37404", "Kaga the Ironbender", "i620 Agility/Intellect Mail Waist", "Level 100", "Icon_Skull_Blue", "Rare", "119372" },

    [63407940] = { "FrostfireRidge", "99999902", "Gorok", "nil", "nil", "Icon_Skull_Orange", "Mount_Gorok", "116674" },
    [22806640] = { "FrostfireRidge", "99999902", "Gorok", "nil", "nil", "Icon_Skull_Orange", "Mount_Gorok", "116674" },
    [64806300] = { "FrostfireRidge", "99999902", "Gorok", "nil", "nil", "Icon_Skull_Orange", "Mount_Gorok", "116674" },
    [51805060] = { "FrostfireRidge", "99999902", "Gorok", "nil", "nil", "Icon_Skull_Orange", "Mount_Gorok", "116674" },
    [58001840] = { "FrostfireRidge", "99999902", "Gorok", "nil", "nil", "Icon_Skull_Orange", "Mount_Gorok", "116674" },
    [15804900] = { "FrostfireRidge", "99999903", "Nok-Karosh", "nil", "Location is approximate", "Icon_Skull_Yellow", "Mount_NokKarosh", "116794" },
    [51001990] = { "FrostfireRidge", "99999904", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [52501780] = { "FrostfireRidge", "99999904", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [53801730] = { "FrostfireRidge", "99999904", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [47702750] = { "FrostfireRidge", "99999904", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
}

HandyNotes_Draenor.nodes["garrisonsmvalliance_tier1"] = {
    [49604380] = { "35530", "Lunarfall Egg", "Garrison Resources", "on a wagon", "Icon_Treasure_Default", "treasure_smv", "824" },
    [42405436] = { "35381", "Pippers' Buried Supplies 1", "Garrison Resources", "nil", "Icon_Treasure_Default", "treasure_smv", "824" },
    [50704850] = { "35382", "Pippers' Buried Supplies 2", "Garrison Resources", "nil", "Icon_Treasure_Default", "treasure_smv", "824" },
    [30802830] = { "35383", "Pippers' Buried Supplies 3", "Garrison Resources", "nil", "Icon_Treasure_Default", "treasure_smv", "824" },
    [49197683] = { "35384", "Pippers' Buried Supplies 4", "Garrison Resources", "nil", "Icon_Treasure_Default", "treasure_smv", "824" },
    [51800110] = { "35289", "Spark's Stolen Supplies", "Garrison Resources", "in a cave in the lake", "Icon_Treasure_Default", "treasure_smv", "824" },
}

HandyNotes_Draenor.nodes["garrisonsmvalliance_tier2"] = {
    [37306590] = { "35530", "Lunarfall Egg", "Garrison Resources", "on a wagon", "Icon_Treasure_Default", "treasure_smv", "824" },
    [41685803] = { "35381", "Pippers' Buried Supplies 1", "Garrison Resources", "nil", "Icon_Treasure_Default", "treasure_smv", "824" },
    [51874545] = { "35382", "Pippers' Buried Supplies 2", "Garrison Resources", "nil", "Icon_Treasure_Default", "treasure_smv", "824" },
    [34972345] = { "35383", "Pippers' Buried Supplies 3", "Garrison Resources", "nil", "Icon_Treasure_Default", "treasure_smv", "824" },
    [46637608] = { "35384", "Pippers' Buried Supplies 4", "Garrison Resources", "nil", "Icon_Treasure_Default", "treasure_smv", "824" },
    [51800110] = { "35289", "Spark's Stolen Supplies", "Garrison Resources", "in a cave in the lake", "Icon_Treasure_Default", "treasure_smv", "824" },
}

HandyNotes_Draenor.nodes["garrisonsmvalliance_tier3"] = {
    [61277261] = { "35530", "Lunarfall Egg", "Garrison Resources", "in the tent", "Icon_Treasure_Default", "treasure_smv", "824" },
    [60575515] = { "35381", "Pippers' Buried Supplies 1", "Garrison Resources", "nil", "Icon_Treasure_Default", "treasure_smv", "824" },
    [37307491] = { "35382", "Pippers' Buried Supplies 2", "Garrison Resources", "nil", "Icon_Treasure_Default", "treasure_smv", "824" },
    [37864378] = { "35383", "Pippers' Buried Supplies 3", "Garrison Resources", "nil", "Icon_Treasure_Default", "treasure_smv", "824" },
    [61527154] = { "35384", "Pippers' Buried Supplies 4", "Garrison Resources", "nil", "Icon_Treasure_Default", "treasure_smv", "824" },
    [51800110] = { "35289", "Spark's Stolen Supplies", "Garrison Resources", "in a cave in the lake", "Icon_Treasure_Default", "treasure_smv", "824" },
}

HandyNotes_Draenor.nodes["garrisonffhorde_tier1"] = {
    [74505620] = { "34937", "Lady Sena's Other Materials Stash", "Garrison Resources", "nil", "Icon_Treasure_Default", "treasure_ffr", "824" },
}

HandyNotes_Draenor.nodes["garrisonffhorde_tier2"] = {
    [74505620] = { "34937", "Lady Sena's Other Materials Stash", "Garrison Resources", "nil", "Icon_Treasure_Default", "treasure_ffr", "824" },
}

HandyNotes_Draenor.nodes["garrisonffhorde_tier3"] = {
    [74505620] = { "34937", "Lady Sena's Other Materials Stash", "Garrison Resources", "nil", "Icon_Treasure_Default", "treasure_ffr", "824" },
}

HandyNotes_Draenor.nodes["Gorgrond"] = {
    [41735297] = { "Gorgrond", "36506", "Brokor's Sack", "i538 Caster Staff", "nil", "Icon_Treasure_Default", "Treasure", "118702" },
    [42368341] = { "Gorgrond", "36625", "Discarded Pack", "Gold + Random Green", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [41827802] = { "Gorgrond", "36658", "Evermorn Supply Cache", "Random Green", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [40367660] = { "Gorgrond", "36621", "Explorer Canister", "50 Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "118710" },
    [40047223] = { "Gorgrond", "36170", "Femur of Improbability", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "118715" },
    [46104999] = { "Gorgrond", "36651", "Harvestable Precious Crystal", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [42584685] = { "Gorgrond", "35056", "Horned Skull", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [43694248] = { "Gorgrond", "36618", "Iron Supply Chest", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [44207427] = { "Gorgrond", "35709", "Laughing Skull Cache", "Garrison Resources", "Up in a tree", "Icon_Treasure_Default", "Treasure", "824" },
    [43109290] = { "Gorgrond", "34241", "Ockbar's Pack", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "118227" },
    [52516696] = { "Gorgrond", "36509", "Odd Skull", "i535 Offhand", "nil", "Icon_Treasure_Default", "Treasure", "118717" },
    [46244295] = { "Gorgrond", "36521", "Petrified Rylak Egg", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "118707" },
    [43957055] = { "Gorgrond", "36118", "Pile of Rubble", "Random Green", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [53127449] = { "Gorgrond", "36654", "Remains of Balik Orecrusher", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "118714" },
    [57845597] = { "Gorgrond", "36605", "Remains of Balldir Deeprock", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "118703" },
    [39036805] = { "Gorgrond", "36631", "Sasha's Secret Stash", "Gold + Random Green", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [44954262] = { "Gorgrond", "36634", "Sniper's Crossbow", "i539 Crossbow", "nil", "Icon_Treasure_Default", "Treasure", "118713" },
    [48129337] = { "Gorgrond", "36604", "Stashed Emergency Rucksack", "Gold + Random Green", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [52977995] = { "Gorgrond", "34940", "Strange Looking Dagger", "i537 Agility Dagger", "nil", "Icon_Treasure_Default", "Treasure", "118718" },
    [57086530] = { "Gorgrond", "37249", "Strange Spore", "Pet", "On top of a mushroom slice sticking out of the cliff", "Icon_Treasure_Default", "Treasure", "118106" },
    [45694972] = { "Gorgrond", "36610", "Suntouched Spear", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "118708" },
    [59296379] = { "Gorgrond", "36628", "Vindicator's Hammer", "i539 Strength 2H Mace", "nil", "Icon_Treasure_Default", "Treasure", "118712" },
    [48944731] = { "Gorgrond", "36203", "Warm Goren Egg", "Egg which hatches into a Toy after 7 days", "nil", "Icon_Treasure_Default", "Treasure", "118705" },
    [49284363] = { "Gorgrond", "36596", "Weapons Cache", "100 Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "107645" },

    [58604120] = { "Gorgrond", "37371", "Alkali", "i620 Agility/Intellect Leather Gloves", "Level 100", "Icon_Skull_Blue", "Rare", "119361" },
    [40007900] = { "Gorgrond", "35335", "Bashiok", "Toy", "nil", "Icon_Skull_Green", "Rare", "118222" },
    [69204460] = { "Gorgrond", "37369", "Basten + Nultra + Valstil", "Toy + i620 Cloth Waist", "Level 100  All 3 together", "Icon_Skull_Green", "Rare", "119357" },
    [39407460] = { "Gorgrond", "36597", "Berthora", "i532 Agility/Intellect Mail Shoulders", "nil", "Icon_Skull_Grey", "Rare", "118232" },
    [46003360] = { "Gorgrond", "37368", "Blademaster Ro'gor", "i620 Cloth Boots", "Level 101", "Icon_Skull_Blue", "Rare", "119228" },
    [53404460] = { "Gorgrond", "35503", "Char the Burning", "i536 2H Caster Mace", "nil", "Icon_Skull_Grey", "Rare", "118212" },
    [48202100] = { "Gorgrond", "37362", "Defector Dazgo", "i620 Strength Polearm", "Level 101", "Icon_Skull_Blue", "Rare", "119224" },
    [57603580] = { "Gorgrond", "37370", "Depthroot", "i620 Agility Polearm", "Level 100  One of two possible Spawnpoints", "Icon_Skull_Blue", "Rare", "119406" },
    [72604040] = { "Gorgrond", "37370", "Depthroot", "i620 Agility Polearm", "Level 100  One of two possible Spawnpoints", "Icon_Skull_Blue", "Rare", "119406" },
    [50002380] = { "Gorgrond", "37366", "Durp the Hated", "i620 Agility Leather Waist", "Level 101", "Icon_Skull_Blue", "Rare", "119225" },
    [72803580] = { "Gorgrond", "37373", "Firestarter Grash", "i620 Strength/Intellect Plate Gloves", "Level 100  One of two possible Spawnpoints", "Icon_Skull_Blue", "Rare", "119381" },
    [58003640] = { "Gorgrond", "37373", "Firestarter Grash", "i620 Strength/Intellect Plate Gloves", "Level 100  One of two possible Spawnpoints", "Icon_Skull_Blue", "Rare", "119381" },
    [57406860] = { "Gorgrond", "36387", "Fossilwood the Petrified", "Toy", "nil", "Icon_Skull_Green", "Rare", "118221" },
    [41804540] = { "Gorgrond", "36391", "Gelgor of the Blue Flame", "i534 Trinket Versatility + Intellect Proc", "nil", "Icon_Skull_Grey", "Rare", "118230" },
    [46205080] = { "Gorgrond", "36204", "Glut", "i534 Trinket Agility + Multistrike Proc", "nil", "Icon_Skull_Grey", "Rare", "118229" },
    [52805360] = { "Gorgrond", "37413", "Gnarljaw", "i620 Intellect Fistweapon", "Level 100", "Icon_Skull_Blue", "Rare", "119397" },
    [46804320] = { "Gorgrond", "36186", "Greldrok the Cunning", "i534 Strength 1H Mace", "nil", "Icon_Skull_Grey", "Rare", "118210" },
    [59604300] = { "Gorgrond", "37375", "Grove Warden Yal", "i620 Intellect Cloak", "Level 100", "Icon_Skull_Blue", "Rare", "119414" },
    [52207020] = { "Gorgrond", "35908", "Hive Queen Skrikka", "i534 Spellpower Axe", "nil", "Icon_Skull_Grey", "Rare", "118209" },
    [47002380] = { "Gorgrond", "37365", "Horgg", "i620 Agility/Intellect Mail Chest", "Level 100", "Icon_Skull_Blue", "Rare", "119229" },
    [55004660] = { "Gorgrond", "37377", "Hunter Bal'ra", "i620 Bow", "Level 100", "Icon_Skull_Blue", "Rare", "119412" },
    [47603060] = { "Gorgrond", "37367", "Inventor Blammo", "i620 Agility Gun + Flavor Item", "Level 101", "Icon_Skull_Blue", "Rare", "119226" },
    [52205580] = { "Gorgrond", "37412", "King Slime", "i620 Strength Cloak", "Level 100", "Icon_Skull_Blue", "Rare", "119351" },
    [50605320] = { "Gorgrond", "36178", "Mandrakor", "Pet", "nil", "Icon_Skull_Green", "Rare", "118709" },
    [49003380] = { "Gorgrond", "37363", "Maniacal Madgard", "i620 Intellect Neck", "Level 101", "Icon_Skull_Blue", "Rare", "119230" },
    [61803930] = { "Gorgrond", "37376", "Mogamago", "i620 Strength Shield", "Level 100", "Icon_Skull_Blue", "Rare", "119391" },
    [47002580] = { "Gorgrond", "37364", "Morgo Kain", "i620 Strength/Intellect Plate Helm", "Level 100", "Icon_Skull_Blue", "Rare", "119227" },
    [53407820] = { "Gorgrond", "34726", "Mother Araneae", "i534 Agility Dagger", "nil", "Icon_Skull_Grey", "Rare", "118208" },
    [37608140] = { "Gorgrond", "36600", "Riptar", "i539 Caster Dagger", "nil", "Icon_Skull_Grey", "Rare", "118231" },
    [47804140] = { "Gorgrond", "36393", "Rolkor", "i539 Trinket Strength + Critical Strike Proc", "nil", "Icon_Skull_Grey", "Rare", "118211" },
    [54207240] = { "Gorgrond", "36837", "Stompalupagus", "i537 2H Agility/Strength Mace", "nil", "Icon_Skull_Grey", "Rare", "118228" },
    [38206620] = { "Gorgrond", "35910", "Stomper Kreego", "Ogre Brewing Kit", "Can create Alcoholic Beverages every 7 days", "Icon_Skull_Grey", "Rare", "118224" },
    [40205960] = { "Gorgrond", "36394", "Sulfurious", "Toy", "nil", "Icon_Skull_Green", "Rare", "114227" },
    [44609220] = { "Gorgrond", "36656", "Sunclaw", "i533 Agility Fistweapon", "nil", "Icon_Skull_Grey", "Rare", "118223" },
    [59903200] = { "Gorgrond", "37374", "Swift Onyx Flayer", "i620 Agility/Intellect Mail Boots", "Level 100", "Icon_Skull_Blue", "Rare", "119367" },
    [64006180] = { "Gorgrond", "36794", "Sylldross", "i540 Agility/Intellect Leather Boots", "nil", "Icon_Skull_Grey", "Rare", "118213" },
    [76004200] = { "Gorgrond", "37405", "Typhon", "Apexis Crystals", "Level 100", "Icon_Skull_Blue", "Rare", "823" },
    [63803160] = { "Gorgrond", "37372", "Venolasix", "i620 Agility Dagger", "Level 100", "Icon_Skull_Blue", "Rare", "119395" },
    
    [41402640] = { "Gorgrond", "99999905", "Poundfist", "nil", "nil", "Icon_Skull_Orange", "Mount_Poundfist", "116792" },
    [50404180] = { "Gorgrond", "99999905", "Poundfist", "nil", "nil", "Icon_Skull_Orange", "Mount_Poundfist", "116792" },
    [45404760] = { "Gorgrond", "99999905", "Poundfist", "nil", "nil", "Icon_Skull_Orange", "Mount_Poundfist", "116792" },
    [43205540] = { "Gorgrond", "99999905", "Poundfist", "nil", "nil", "Icon_Skull_Orange", "Mount_Poundfist", "116792" },
    [48805540] = { "Gorgrond", "99999905", "Poundfist", "nil", "nil", "Icon_Skull_Orange", "Mount_Poundfist", "116792" },
    [56004000] = { "Gorgrond", "99999906", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [51603880] = { "Gorgrond", "99999906", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [54004500] = { "Gorgrond", "99999906", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [43403440] = { "Gorgrond", "99999906", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
}

HandyNotes_Draenor.nodes["NagrandDraenor"] = {
    [73071080] = { "Nagrand", "35951", "A Pile of Dirt", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [67655971] = { "Nagrand", "35759", "Abandoned Cargo", "Random Greens", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [38404940] = { "Nagrand", "36711", "Abu'Gar's Favorite Lure", "Abu'Gar's Favorite Lure", "Combine with the other Abu'Gar Parts for a follower (just north of Telaar)", "Icon_Treasure_Default", "Treasure", "114245" },
    [85403870] = { "Nagrand", "36711", "Abu'gar's Missing Reel", "Abu'Gar's Finest Reel", "Combine with the other Abu'Gar Parts for a follower (just north of Telaar)", "Icon_Treasure_Default", "Treasure", "114243" },
    [65906120] = { "Nagrand", "36711", "Abu'gar's Vitality", "Abu'gar's Vitality", "Combine with the other Abu'Gar Parts for a follower (just north of Telaar)", "Icon_Treasure_Default", "Treasure", "114242" },
    [75816203] = { "Nagrand", "36077", "Adventurer's Mace", "Random Green Mace", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [82275660] = { "Nagrand", "35765", "Adventurer's Pack", "Random Green", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [45635200] = { "Nagrand", "35969", "Adventurer's Pack", "Random Green", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [69955244] = { "Nagrand", "35597", "Adventurer's Pack", "Random Green", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [56567294] = { "Nagrand", "36050", "Adventurer's Pouch", "Garrison Resources", "On a ledge below a cliff; you need to fall from the top to reach it", "Icon_Treasure_Default", "Treasure", "824" },
    [73931405] = { "Nagrand", "35955", "Adventurer's Sack", "Random Green", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [81461307] = { "Nagrand", "35953", "Adventurer's Staff", "i593 Caster Staff", "nil", "Icon_Treasure_Default", "Treasure", "116640" },
    [73057554] = { "Nagrand", "35673", "Appropriated Warsong Supplies", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [62546708] = { "Nagrand", "36116", "Bag of Herbs", "Herbs", "nil", "Icon_Treasure_Default", "Treasure", "109124" },
    [77312807] = { "Nagrand", "35986", "Bone-Carved Dagger", "i597 Agility Dagger", "nil", "Icon_Treasure_Default", "Treasure", "116760" },
    [77081662] = { "Nagrand", "36174", "Bounty of the Elements", "Garrison Resources", "Use the elemental Stones to access", "Icon_Treasure_Default", "Treasure", "824" },
    [81083725] = { "Nagrand", "35661", "Brilliant Dreampetal", "Manareg Potion", "Take Explorer Renzo's Glider to get there [north-east of here]", "Icon_Treasure_Default", "Treasure", "118262" },
    [85415347] = { "Nagrand", "35696", "Burning Blade Cache", "Random Green", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [66961949] = { "Nagrand", "35954", "Elemental Offering", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "118234" },
    [78901556] = { "Nagrand", "36036", "Elemental Shackles", "i605 Agility Ring", "nil", "Icon_Treasure_Default", "Treasure", "118251" },
    [53407320] = { "Nagrand", "900003", "Explorer Bibsi", "Nothing", "You need to use a rocket to get to her [south-east of her position]", "Icon_Glider", "Treasure", "nil" },
    [67601420] = { "Nagrand", "900004", "Explorer Dez", "Nothing", "You can reach him from the east starting at the elemental plateau", "Icon_Glider", "Treasure", "nil" },
    [87204100] = { "Nagrand", "900005", "Explorer Garix", "Nothing", "Is required for 2 Treasures [1 south, 1 south-east]", "Icon_Glider", "Treasure", "nil" },
    [75606460] = { "Nagrand", "900006", "Explorer Razzuk", "Nothing", "Is required for some other Treasures", "Icon_Glider", "Treasure", "nil" },
    [83803380] = { "Nagrand", "900007", "Explorer Renzo", "Nothing", "Is required for 3 Treasures [2 north-east, 1 south-west]", "Icon_Glider", "Treasure", "nil" },
    [45866629] = { "Nagrand", "36020", "Fragment of Oshu'gun", "i607 Intellect Shield", "nil", "Icon_Treasure_Default", "Treasure", "117981" },
    [73052153] = { "Nagrand", "35692", "Freshwater Clam", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "118233" },
    [88901824] = { "Nagrand", "35660", "Fungus-Covered Chest", "Garrison Resources", "Take Explorer Renzo's Glider to get there [south-west of here]", "Icon_Treasure_Default", "Treasure", "824" },
    [75374711] = { "Nagrand", "36074", "Gambler's Purse", "Flavor Item", "nil", "Icon_Treasure_Default", "Treasure", "118236" },
    [43225755] = { "Nagrand", "35987", "Genedar Debris", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [48066011] = { "Nagrand", "35999", "Genedar Debris", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [48587279] = { "Nagrand", "36008", "Genedar Debris", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [44696757] = { "Nagrand", "36002", "Genedar Debris", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [55356828] = { "Nagrand", "36011", "Genedar Debris", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [72976212] = { "Nagrand", "35590", "Goblin Pack", "Garrison Resources", "Take Explorer Razzuk's Glider to get there [south-east of here]", "Icon_Treasure_Default", "Treasure", "824" },
    [47207425] = { "Nagrand", "35576", "Goblin Pack", "Garrison Resources", "Take Explorer Bibsi's Glider to get there [east of here]", "Icon_Treasure_Default", "Treasure", "824" },
    [58285249] = { "Nagrand", "35694", "Golden Kaliri Egg", "Trash Item", "In the nest in the tree", "Icon_Treasure_Default", "Treasure", "118266" },
    [38345872] = { "Nagrand", "36109", "Goldtoe's Plunder", "Gold", "Key on the Parrot", "Icon_Treasure_Default", "Treasure", "nil" },
    [87107288] = { "Nagrand", "36051", "Grizzlemaw's Bonepile", "Pet Toy", "nil", "Icon_Treasure_Default", "Treasure", "118054" },
    [87624498] = { "Nagrand", "35622", "Hidden Stash", "Garrison Resources", "Take Explorer Garix's Glider to get there [north of here]", "Icon_Treasure_Default", "Treasure", "824" },
    [67384906] = { "Nagrand", "36039", "Highmaul Sledge", "i605 Strength Ring", "nil", "Icon_Treasure_Default", "Treasure", "118252" },
    [75236563] = { "Nagrand", "36099", "Important Exploration Supplies", "Alcoholic Beverages", "nil", "Icon_Treasure_Default", "Treasure", "61986" },
    [61765747] = { "Nagrand", "36082", "Lost Pendant", "i593 Green Amulet", "nil", "Icon_Treasure_Default", "Treasure", "116687" },
    [70531385] = { "Nagrand", "35643", "Mountain Climber's Pack", "Garrison Resources", "Take Explorer Dez's Glider to get there [west of here]", "Icon_Treasure_Default", "Treasure", "824" },
    [80967979] = { "Nagrand", "36049", "Ogre Beads", "i605 Str Ring", "nil", "Icon_Treasure_Default", "Treasure", "118255" },
    [57796205] = { "Nagrand", "36115", "Pale Elixir", "Manareg Potion", "nil", "Icon_Treasure_Default", "Treasure", "118278" },
    [58295931] = { "Nagrand", "36021", "Pokkar's Thirteenth Axe", "i605 1H Strength Axe", "nil", "Icon_Treasure_Default", "Treasure", "116688" },
    [72716092] = { "Nagrand", "36035", "Polished Saberon Skull", "i605 Agility/Strength Ring", "nil", "Icon_Treasure_Default", "Treasure", "118254" },
    [58507630] = { "Nagrand", "900008", "Rocket to Explorer Bibsi", "Nothing", "Is required to get to Explorer Bibsi", "Icon_Rocket", "Treasure", "nil" },
    [75186494] = { "Nagrand", "36102", "Saberon Stash", "Gold", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [89073313] = { "Nagrand", "36857", "Smuggler's Cache", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [40346864] = { "Nagrand", "37435", "Spirit Coffer", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [50128228] = { "Nagrand", "35577", "Steamwheedle Supplies", "Garrison Resources", "Take Explorer Bibsi's Glider to get there [north-east of here]", "Icon_Treasure_Default", "Treasure", "824" },
    [52678008] = { "Nagrand", "35583", "Steamwheedle Supplies", "Garrison Resources", "Take Explorer Bibsi's Glider to get there [north of here]", "Icon_Treasure_Default", "Treasure", "824" },
    [77835195] = { "Nagrand", "35591", "Steamwheedle Supplies", "Garrison Resources", "Take Explorer Razzuk's Glider to get there [south of here]", "Icon_Treasure_Default", "Treasure", "824" },
    [64591762] = { "Nagrand", "35648", "Steamwheedle Supplies", "Garrison Resources", "Take Explorer Dez's Glider to get there [north-east of here]", "Icon_Treasure_Default", "Treasure", "824" },
    [70601860] = { "Nagrand", "35646", "Steamwheedle Supplies", "Garrison Resources", "Take Explorer Dez's Glider to get there [north-west of here]", "Icon_Treasure_Default", "Treasure", "824" },
    [87602028] = { "Nagrand", "35662", "Steamwheedle Supplies", "Garrison Resources", "Take Explorer Renzo's Glider to get there [south-west of here]", "Icon_Treasure_Default", "Treasure", "824" },
    [88274262] = { "Nagrand", "35616", "Steamwheedle Supplies", "Garrison Resources", "Take Explorer Garix's Glider to get there [north-west of here]", "Icon_Treasure_Default", "Treasure", "824" },
    [64716583] = { "Nagrand", "36046", "Telaar Defender Shield", "i605 Agility/Intellect Ring", "nil", "Icon_Treasure_Default", "Treasure", "118253" },
    [37717065] = { "Nagrand", "34760", "Treasure of Kull'krosh", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [49976651] = { "Nagrand", "35579", "Void-Infused Crystal", "i613 2H Strength Sword", "Take Explorer Bibsi's Glider to get there [south-east of here]", "Icon_Treasure_Default", "Treasure", "118264" },
    [51726029] = { "Nagrand", "35695", "Warsong Cache", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [52414438] = { "Nagrand", "36073", "Warsong Helm", "i609 Agility/Intellect Mail Helm", "nil", "Icon_Treasure_Default", "Treasure", "118250" },
    [73047036] = { "Nagrand", "35678", "Warsong Lockbox", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [76066990] = { "Nagrand", "35682", "Warsong Spear", "Trash Item", "Take Explorer Razzuk's Glider to get there [north of here]", "Icon_Treasure_Default", "Treasure", "118678" },
    [80656054] = { "Nagrand", "35593", "Warsong Spoils", "Garrison Resources", "Take Explorer Razzuk's Glider to get there [west of here]", "Icon_Treasure_Default", "Treasure", "824" },
    [89406588] = { "Nagrand", "35976", "Warsong Supplies", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [64763573] = { "Nagrand", "36071", "Watertight Bag", "20 Slot Bag", "nil", "Icon_Treasure_Default", "Treasure", "118235" },
    [53386425] = { "Nagrand", "36088", "Adventurer's Pouch", "Random Green", "In a cave; entrance is to the east", "Icon_Treasure_Default", "Treasure", "824" },
    [35475725] = { "Nagrand", "36846", "Spirit's Gift", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    
    [84605340] = { "Nagrand", "35778", "Ancient Blademaster", "i598 Strength Neck", "nil", "Icon_Skull_Grey", "Rare", "116832" },
    [51001600] = { "Nagrand", "37210", "Aogexon", "Reputation Item for Steamwheedle Preservation Society", "nil", "Icon_Fossil_Snail", "Rare", "118654" },
    [62601680] = { "Nagrand", "37211", "Bergruu", "Reputation Item for Steamwheedle Preservation Society", "nil", "Icon_Fossil_Snail", "Rare", "118655" },
    [77006400] = { "Nagrand", "35735", "Berserk T-300 Series Mark II", "Garrison Resources", "In a cave, opened with a switch", "Icon_Skull_Grey", "Rare", "824" },
    [40001600] = { "Nagrand", "37396", "Bonebreaker", "i620 Agility/Intellect Mail Pants", "nil", "Icon_Skull_Blue", "Rare", "119370" },
    [43003640] = { "Nagrand", "37400", "Brutag Grimblade", "i620 Intellect/Strength Plate Boots", "nil", "Icon_Skull_Blue", "Rare", "119380" },
    [34607700] = { "Nagrand", "34727", "Captain Ironbeard", "Toy + i607 Gun", "nil", "Icon_Skull_Green", "Rare", "118244" },
    [64203000] = { "Nagrand", "37221", "Dekorhan", "Reputation Item for Steamwheedle Preservation Society", "nil", "Icon_Fossil_Snail", "Rare", "118656" },
    [60003800] = { "Nagrand", "37222", "Direhoof", "Reputation Item for Steamwheedle Preservation Society", "nil", "Icon_Fossil_Snail", "Rare", "118657" },
    [38602240] = { "Nagrand", "37395", "Durg Spinecrusher", "i620 Agility 2H Mace", "nil", "Icon_Skull_Blue", "Rare", "119405" },
    [89004120] = { "Nagrand", "35623", "Explorer Nozzand", "Trash Item", "nil", "Icon_Skull_Grey", "Rare", "118679" },
    [74801180] = { "Nagrand", "35836", "Fangler", "Trash Items", "nil", "Icon_Skull_Grey", "Rare", "116836" },
    [70004180] = { "Nagrand", "35893", "Flinthide", "i609 Strength Shield", "nil", "Icon_Skull_Grey", "Rare", "116807" },
    [48202220] = { "Nagrand", "37223", "Gagrog the Brutal", "Reputation Item for Steamwheedle Preservation Society", "nil", "Icon_Fossil_Snail", "Rare", "118658" },
    [52205580] = { "Nagrand", "35715", "Gar'lua", "i605 Trinket Multistrike + Wolf Proc", "nil", "Icon_Skull_Grey", "Rare", "118246" },
    [42207860] = { "Nagrand", "34725", "Gaz'orda", "i602 Intellect Ring", "In the cave", "Icon_Skull_Grey", "Rare", "116798" },
    [66605660] = { "Nagrand", "35717", "Gnarlhoof the Rabid", "i598 Trinket Multistrike + Agi Proc", "nil", "Icon_Skull_Grey", "Rare", "116824" },
    [93202820] = { "Nagrand", "35898", "Gorepetal", "i602 Agility/Intellect Leather Gloves", "The gloves let you gather herbs faster while in Draenor", "Icon_Skull_Grey", "Rare", "116916" },
    [42003680] = { "Nagrand", "37472", "Gortag Steelgrip", "Apexis Crystals", "Summoned by Signal Horn object using Secret Meeting Details item", "Icon_Skull_Blue", "Rare", "824" },
    [84603660] = { "Nagrand", "36159", "Graveltooth", "i609 Agility/Intellect Leather Bracer", "nil", "Icon_Skull_Grey", "Rare", "118689" },
    [66805120] = { "Nagrand", "35714", "Greatfeather", "i600 Cloth Body", "nil", "Icon_Skull_Grey", "Rare", "116795" },
    [86007160] = { "Nagrand", "35784", "Grizzlemaw", "i610 Strength Cloak", "nil", "Icon_Skull_Grey", "Rare", "118687" },
    [80603040] = { "Nagrand", "35923", "Hunter Blacktooth", "i609 Agility 2H Mace", "nil", "Icon_Skull_Grey", "Rare", "118245" },
    [87005500] = { "Nagrand", "34862", "Hyperious", "i597 Trinket Haste + Mastery Proc", "nil", "Icon_Skull_Grey", "Rare", "116799" },
    [45803480] = { "Nagrand", "37399", "Karosh Blackwind", "i620 Cloth Pants", "nil", "Icon_Skull_Blue", "Rare", "119355" },
    [43803440] = { "Nagrand", "37473", "Krahl Deadeye", "Apexis Crystals", "Summoned by Signal Horn object using Secret Meeting Details item", "Icon_Skull_Blue", "Rare", "nil" },
    [58201200] = { "Nagrand", "37398", "Krud the Eviscerator", "i620 Intellect/Strength Plate Waist + Achievement", "Kill 15 mobs near him to make him become attackable", "Icon_Skull_Blue", "Rare", "119384" },
    [52009000] = { "Nagrand", "37408", "Lernaea", "Unknown", "nil", "Icon_Skull_Blue", "Rare", "nil" },
    [81206000] = { "Nagrand", "35932", "Malroc Stonesunder", "i597 Agility Staff", "nil", "Icon_Skull_Grey", "Rare", "116796" },
    [45801520] = { "Nagrand", "36229", "Mr. Pinchy Sr.", "i616 Trinket Multistrike + Lobstrok Proc", "nil", "Icon_Skull_Grey", "Rare", "118690" },
    [34005100] = { "Nagrand", "37224", "Mu'gra", "Reputation Item for Steamwheedle Preservation Society", "nil", "Icon_Fossil_Snail", "Rare", "118659" },
    [47607080] = { "Nagrand", "35865", "Netherspawn", "Pet", "nil", "Icon_Skull_Green", "Rare", "116815" },
    [42804920] = { "Nagrand", "35875", "Ophiis", "i602 Cloth Pants", "nil", "Icon_Skull_Grey", "Rare", "116765" },
    [61806900] = { "Nagrand", "35943", "Outrider Duretha", "i598 Agility/Intellect Leather Boots", "nil", "Icon_Skull_Grey", "Rare", "116800" },
    [58201800] = { "Nagrand", "37637", "Pit Beast", "i620 Agility/Strength Tank Cloak", "nil", "Icon_Skull_Blue", "Rare", "120317" },
    [38001960] = { "Nagrand", "37397", "Pit Slayer", "i620 Strength Ring", "nil", "Icon_Skull_Blue", "Rare", "119389" },
    [73605780] = { "Nagrand", "35712", "Redclaw the Feral", "i604 Intellect Fistweapon", "nil", "Icon_Skull_Grey", "Rare", "118243" },
    [58008400] = { "Nagrand", "35900", "Ru'klaa", "i608 Intellect/Strength Plate Shoulder", "nil", "Icon_Skull_Grey", "Rare", "118688" },
    [54806120] = { "Nagrand", "35931", "Scout Pokhar", "i601 Strength 1H Axe", "nil", "Icon_Skull_Grey", "Rare", "116797" },
    [60934775] = { "Nagrand", "35912", "Sean Whitesea", "i600 Agility/Intellect Leather Waist", "Spawns when Abandoned Chest is looted", "Icon_Skull_Grey", "Rare", "116834" },
    [75606500] = { "Nagrand", "36128", "Soulfang", "i597 Intellect Sword", "nil", "Icon_Skull_Grey", "Rare", "116806" },
    [58403580] = { "Nagrand", "37225", "Thek'talon", "Reputation Item for Steamwheedle Preservation Society", "nil", "Icon_Fossil_Snail", "Rare", "118660" },
    [65003900] = { "Nagrand", "35920", "Tura'aka", "i609 Agility Cloak", "nil", "Icon_Skull_Grey", "Rare", "116814" },
    [37003800] = { "Nagrand", "37520", "Vileclaw", "Reputation Item for Steamwheedle Preservation Society", "nil", "Icon_Fossil_Snail", "Rare", "120172" },
    [82607620] = { "Nagrand", "34645", "Warmaster Blugthol", "i600 Strength/Intellect Plate Bracer", "nil", "Icon_Skull_Grey", "Rare", "116805" },
    [70602940] = { "Nagrand", "35877", "Windcaller Korast", "i598 Caster Staff", "nil", "Icon_Skull_Grey", "Rare", "116808" },
    [41004400] = { "Nagrand", "37226", "Xelganak", "Reputation Item for Steamwheedle Preservation Society", "nil", "Icon_Fossil_Snail", "Rare", "118661" },
    [26203420] = { "Nagrand", "98198", "Rukdug", "Pet Drop", "nil", "Icon_Skull_Green", "Rare", "129216" },
    [28503030] = { "Nagrand", "98199", "Pugg", "Pet Drop", "nil", "Icon_Skull_Green", "Rare", "129217" },
    [23803790] = { "Nagrand", "98200", "Guk", "Pet Drop", "nil", "Icon_Skull_Green", "Rare", "129218" },
    [51001600] = { "Nagrand", "37210", "Aogexon", "Reputation Item for Steamwheedle Preservation Society", "nil", "Icon_Fossil_Snail", "Rare", "118654" },

    [50003440] = { "Nagrand", "99999910", "Nakk the Thunderer", "nil", "nil", "Icon_Skull_Yellow", "Mount_NakkTheThunderer", "116659" },
    [55003500] = { "Nagrand", "99999910", "Nakk the Thunderer", "nil", "nil", "Icon_Skull_Yellow", "Mount_NakkTheThunderer", "116659" },
    [62801540] = { "Nagrand", "99999910", "Nakk the Thunderer", "nil", "nil", "Icon_Skull_Yellow", "Mount_NakkTheThunderer", "116659" },
    [64601980] = { "Nagrand", "99999910", "Nakk the Thunderer", "nil", "nil", "Icon_Skull_Yellow", "Mount_NakkTheThunderer", "116659" },
    [76203180] = { "Nagrand", "99999911", "Luk'hok", "nil", "nil", "Icon_Skull_Orange", "Mount_Lukhok", "116661" },
    [66604400] = { "Nagrand", "99999911", "Luk'hok", "nil", "nil", "Icon_Skull_Orange", "Mount_Lukhok", "116661" },
    [72805360] = { "Nagrand", "99999911", "Luk'hok", "nil", "nil", "Icon_Skull_Orange", "Mount_Lukhok", "116661" },
    [79205600] = { "Nagrand", "99999911", "Luk'hok", "nil", "nil", "Icon_Skull_Orange", "Mount_Lukhok", "116661" },
    [84206360] = { "Nagrand", "99999911", "Luk'hok", "nil", "nil", "Icon_Skull_Orange", "Mount_Lukhok", "116661" },
    [57302670] = { "Nagrand", "99999912", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [40504760] = { "Nagrand", "99999912", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [45903140] = { "Nagrand", "99999912", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
}

HandyNotes_Draenor.nodes["ShadowmoonValleyDR"] = {
    [54924501] = { "ShadowmoonValley", "35581", "Alchemist's Satchel", "Herbs", "nil", "Icon_Treasure_Default", "Treasure", "109124" },
    [52834837] = { "ShadowmoonValley", "35584", "Ancestral Greataxe", "i519 2H Strength Axe", "nil", "Icon_Treasure_Default", "Treasure", "113560" },
    [41422798] = { "ShadowmoonValley", "33869", "Armored Elekk Tusk", "i518 Trinket Bonus Armor + Mastery on use", "nil", "Icon_Treasure_Default", "Treasure", "108902" },
    [37784435] = { "ShadowmoonValley", "33584", "Ashes of A'kumbo", "Consumable for Rested XP", "nil", "Icon_Treasure_Default", "Treasure", "113531" },
    [49313760] = { "ShadowmoonValley", "33867", "Astrologer's Box", "Toy", "nil", "Icon_Treasure_Default", "Treasure", "109739" },
    [36774142] = { "ShadowmoonValley", "33046", "Beloved's Offering", "Flavor Item - Offhand", "nil", "Icon_Treasure_Default", "Treasure", "113547" },
    [37182313] = { "ShadowmoonValley", "33613", "Bubbling Cauldron", "i516 Caster Offhand", "In a cave; the entrance is slightly to the northeast, at 38, 22.3", "Icon_Treasure_Default", "Treasure", "108945" },
    [84564478] = { "ShadowmoonValley", "33885", "Cargo of the Raven Queen", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [33453961] = { "ShadowmoonValley", "33569", "Carved Drinking Horn", "Reusable Mana Potion", "nil", "Icon_Treasure_Default", "Treasure", "113545" },
    [61706790] = { "ShadowmoonValley", "34743", "Crystal Blade of Torvath", "Trash Item", "Interacting with the object causes three Silverleaf Ancients to spawn; you can only loot the item after they are dead", "Icon_Treasure_Default", "Treasure", "111636" },
    [20383065] = { "ShadowmoonValley", "33575", "Demonic Cache", "i550 Intellect Neck", "nil", "Icon_Treasure_Default", "Treasure", "108904" },
    [29853748] = { "ShadowmoonValley", "36879", "Dusty Lockbox", "Random Greens + Gold", "On top of a giant stone arch; to reach it, jump across the other stone arches, starting on a cliff ledge to the west", "Icon_Treasure_Default", "Treasure", "824" },
    [51753549] = { "ShadowmoonValley", "33037", "False-Bottomed Jar", "Gold", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [26530568] = { "ShadowmoonValley", "34174", "Fantastic Fish", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [34394623] = { "ShadowmoonValley", "33891", "Giant Moonwillow Cone", "i522 Wand", "nil", "Icon_Treasure_Default", "Treasure", "108901" },
    [48724753] = { "ShadowmoonValley", "35798", "Glowing Cave Mushroom", "Herbs", "nil", "Icon_Treasure_Default", "Treasure", "109127" },
    [38484308] = { "ShadowmoonValley", "33614", "Greka's Urn", "i528 Trinket Haste + Strength Proc", "nil", "Icon_Treasure_Default", "Treasure", "113408" },
    [47154603] = { "ShadowmoonValley", "33564", "Hanging Satchel", "i518 Agility/Intellect Leather Gloves", "nil", "Icon_Treasure_Default", "Treasure", "108900" },
    [42106130] = { "ShadowmoonValley", "33041", "Iron Horde Cargo Shipment", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [37515925] = { "ShadowmoonValley", "33567", "Iron Horde Tribute", "Trinket Multistrike + DMG on use", "nil", "Icon_Treasure_Default", "Treasure", "108903" },
    [57924531] = { "ShadowmoonValley", "33568", "Kaliri Egg", "25 Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "113271" },
    [58882193] = { "ShadowmoonValley", "35603", "Mikkal's Chest", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "113215" },
    [52882486] = { "ShadowmoonValley", "37254", "Mushroom-Covered Chest", "25 Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "113388" },
    [66963349] = { "ShadowmoonValley", "36507", "Orc Skeleton", "i526 Strength Ring", "nil", "Icon_Treasure_Default", "Treasure", "116875" },
    [43756062] = { "ShadowmoonValley", "33611", "Peaceful Offering 1", "Trash Items", "nil", "Icon_Treasure_Default", "Treasure", "107650" },
    [45226049] = { "ShadowmoonValley", "33610", "Peaceful Offering 2", "Trash Items", "nil", "Icon_Treasure_Default", "Treasure", "107650" },
    [44486357] = { "ShadowmoonValley", "33384", "Peaceful Offering 3", "Trash Items", "nil", "Icon_Treasure_Default", "Treasure", "107650" },
    [44495914] = { "ShadowmoonValley", "33612", "Peaceful Offering 4", "Trash Items", "nil", "Icon_Treasure_Default", "Treasure", "107650" },
    [31223905] = { "ShadowmoonValley", "33886", "Ronokk's Belongings", "i522 Strength Cloak", "nil", "Icon_Treasure_Default", "Treasure", "109081" },
    [22893385] = { "ShadowmoonValley", "33572", "Rotting Basket", "Trash Item", "Inside Bloodthorn Cave", "Icon_Treasure_Default", "Treasure", "113373" },
    [36684455] = { "ShadowmoonValley", "33573", "Rovo's Dagger", "i520 Agility Dagger", "nil", "Icon_Treasure_Default", "Treasure", "113378" },
    [67058418] = { "ShadowmoonValley", "33565", "Scaly Rylak Egg", "Trash Item", "Level 100 AREA", "Icon_Treasure_Default", "Treasure", "44722" },
    [45822458] = { "ShadowmoonValley", "33570", "Shadowmoon Exile Treasure", "25 Garrison Resources", "In a cave below Exile Rise", "Icon_Treasure_Default", "Treasure", "113388" },
    [29994536] = { "ShadowmoonValley", "35919", "Shadowmoon Sacrificial Dagger", "i524 Caster Dagger", "nil", "Icon_Treasure_Default", "Treasure", "113563" },
    [28233924] = { "ShadowmoonValley", "33883", "Shadowmoon Treasure", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [27050248] = { "ShadowmoonValley", "35280", "Stolen Treasure", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [55821997] = { "ShadowmoonValley", "35600", "Strange Spore", "Pet", "On top of the giant mushroom", "Icon_Treasure_Default", "Treasure", "118104" },
    [37192601] = { "ShadowmoonValley", "35677", "Sunken Fishing boat", "Fish", "nil", "Icon_Treasure_Default", "Treasure", "118414" },
    [28820720] = { "ShadowmoonValley", "35279", "Sunken Treasure", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [55297487] = { "ShadowmoonValley", "35580", "Swamplighter Hive", "Toy", "nil", "Icon_Treasure_Default", "Treasure", "117550" },
    [35854087] = { "ShadowmoonValley", "33540", "Uzko's Knickknacks", "i525 Agility/Intellect Leather Boots", "nil", "Icon_Treasure_Default", "Treasure", "113546" },
    [34214353] = { "ShadowmoonValley", "33866", "Veema's Herb Bag", "Herbs", "nil", "Icon_Treasure_Default", "Treasure", "109124" },
    [51147912] = { "ShadowmoonValley", "33574", "Vindicator's Cache", "Toy", "Level 100 AREA", "Icon_Treasure_Default", "Treasure", "113375" },
    [39208391] = { "ShadowmoonValley", "33566", "Waterlogged Chest", "i520 Strength Fist Weapon + Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "113372" },

    [37203640] = { "ShadowmoonValley", "33061", "Amaukwa", "i516 Agility/Intellect Mail Body", "Flies around a very large area", "Icon_Skull_Grey", "Rare", "109060" },
    [50807880] = { "ShadowmoonValley", "37356", "Aqualir", "i620 Intellect Ring", "Level 101", "Icon_Skull_Blue", "Rare", "119387" },
    [68208480] = { "ShadowmoonValley", "37410", "Avalanche", "i620 Strength 1H Mace", "Level 100", "Icon_Skull_Blue", "Rare", "119400" },
    [52801680] = { "ShadowmoonValley", "35731", "Ba'ruun", "Reusable Food without Buff", "nil", "Icon_Skull_Grey", "Rare", "113540" },
    [43807740] = { "ShadowmoonValley", "33383", "Brambleking Fili", "i620 Agility Staff", "Level 100", "Icon_Skull_Blue", "Rare", "117551" },
    [48604360] = { "ShadowmoonValley", "33064", "Dark Emanation", "i516 Intellect Fistweapon", "Inside a cave; kill cultists to make him attackable", "Icon_Skull_Grey", "Rare", "109075" },
    [41008300] = { "ShadowmoonValley", "35448", "Darkmaster Go'vid", "i525 Intellect Staff + Lobstrok Summon", "nil", "Icon_Skull_Grey", "Rare", "113548" },
    [49604200] = { "ShadowmoonValley", "35555", "Darktalon", "i520 Agility Cloak", "nil", "Icon_Skull_Grey", "Rare", "113541" },
    [46007160] = { "ShadowmoonValley", "37351", "Demidos", "i620 Agility/Strength Tank Neck + Pet + Achievement", "Level 102  To get to his plateau from Sorcethar's Rise, jump up on rocks on the east side", "Icon_Skull_Green", "Rare", "119377" },
    [67806380] = { "ShadowmoonValley", "35688", "Enavra", "i523 Intellect Neck", "Interacting with her corpse spawns her spirit to fight", "Icon_Skull_Grey", "Rare", "113556" },
    [61606180] = { "ShadowmoonValley", "35725", "Faebright", "i526 Agility/Intellect Leather Pants", "nil", "Icon_Skull_Grey", "Rare", "113557" },
    [37404880] = { "ShadowmoonValley", "35558", "Hypnocroak", "Toy", "nil", "Icon_Skull_Green", "Rare", "113631" },
    [57404840] = { "ShadowmoonValley", "35909", "Insha'tar", "i520 Agility/Intellect Mail Boots", "nil", "Icon_Skull_Grey", "Rare", "113571" },
    [40804440] = { "ShadowmoonValley", "33043", "Killmaw", "i516 Agility Dagger", "nil", "Icon_Skull_Grey", "Rare", "109078" },
    [32203500] = { "ShadowmoonValley", "33039", "Ku'targ the Voidseer", "i516 Agility/Intellect Mail Gloves", "nil", "Icon_Skull_Grey", "Rare", "109061" },
    [48007760] = { "ShadowmoonValley", "37355", "Lady Temptessa", "i620 Agility/Intellect Leather Boots", "Level 101", "Icon_Skull_Blue", "Rare", "119360" },
    [37601460] = { "ShadowmoonValley", "33055", "Leaf-Reader Kurri", "i518 Trinket Versatility + Heal Proc", "nil", "Icon_Skull_Grey", "Rare", "108907" },
    [44802080] = { "ShadowmoonValley", "35906", "Mad King Sporeon", "i519 Agility Staff", "nil", "Icon_Skull_Grey", "Rare", "113561" },
    [29605080] = { "ShadowmoonValley", "37357", "Malgosh Shadowkeeper", "i620 Agility/Intellect Mail Helm", "Level 100", "Icon_Skull_Blue", "Rare", "119369" },
    [51807920] = { "ShadowmoonValley", "37353", "Master Sergeant Milgra", "i620 Agility/Intellect Mail Gloves", "Level 101", "Icon_Skull_Blue", "Rare", "119368" },
    [38607020] = { "ShadowmoonValley", "35523", "Morva Soultwister", "i520 1H Caster Mace", "nil", "Icon_Skull_Grey", "Rare", "113559" },
    [44005760] = { "ShadowmoonValley", "33642", "Mother Om'ra", "i522 Trinket Int + Mastery Proc", "Kill cultists to make her attackable", "Icon_Skull_Grey", "Rare", "113527" },
    [58408680] = { "ShadowmoonValley", "37409", "Nagidna", "i620 Agility/Intellect Leather Shoulders", "Level 100  In a Cave - Entrance is at 59,89", "Icon_Skull_Blue", "Rare", "119364" },
    [50207240] = { "ShadowmoonValley", "37352", "Quartermaster Hershak", "i620 Strength/Intellect Plate Pants", "Level 101", "Icon_Skull_Blue", "Rare", "119382" },
    [48602260] = { "ShadowmoonValley", "35553", "Rai'vosh", "Reusable Slowfall Item", "nil", "Icon_Skull_Grey", "Rare", "113542" },
    [53005060] = { "ShadowmoonValley", "34068", "Rockhoof", "i516 Strength Shield", "nil", "Icon_Skull_Grey", "Rare", "109077" },
    [48208100] = { "ShadowmoonValley", "37354", "Shadowspeaker Niir", "i620 Caster Dagger", "Level 101", "Icon_Skull_Blue", "Rare", "119396" },
    [61005520] = { "ShadowmoonValley", "35732", "Shinri", "400% Ground Mount with Cooldown", "Roams in a large area - often evades and despawns", "Icon_Skull_Grey", "Rare", "113543" },
    [61408880] = { "ShadowmoonValley", "37411", "Slivermaw", "i620 Strength 2H Sword", "Level 100", "Icon_Skull_Blue", "Rare", "119411" },
    [27604360] = { "ShadowmoonValley", "36880", "Sneevel", "i519 Cloth Pants", "nil", "Icon_Skull_Grey", "Rare", "118734" },
    [21602100] = { "ShadowmoonValley", "33640", "Veloss", "i516 Intellect Ring", "nil", "Icon_Skull_Grey", "Rare", "108906" },
    [54607060] = { "ShadowmoonValley", "33643", "Venomshade", "i516 Agility/Intellect Leather Boots", "nil", "Icon_Skull_Grey", "Rare", "108957" },
    [31905720] = { "ShadowmoonValley", "37359", "Voidreaver Urnae", "i620 Agility 1H Axe", "Level 100", "Icon_Skull_Blue", "Rare", "119392" },
    [32604140] = { "ShadowmoonValley", "35847", "Voidseer Kalurg", "i516 Cloth Waist", "Kill cultists to make him attackable", "Icon_Skull_Grey", "Rare", "109074" },
    [48806640] = { "ShadowmoonValley", "33389", "Yggdrel", "Toy", "nil", "Icon_Skull_Green", "Rare", "113570" },
    [29405150] = { "ShadowmoonValley", "37357", "Malgosh Shadowkeeper", "i620 Agility/Intellect Mail Helm", "Level 100", "Icon_Skull_Blue", "Rare", "119369" },
    
    [54003040] = { "ShadowmoonValley", "99999900", "Pathrunner", "nil", "nil", "Icon_Skull_Orange", "Mount_Pathrunner", "116773" },
    [43003220] = { "ShadowmoonValley", "99999900", "Pathrunner", "nil", "nil", "Icon_Skull_Orange", "Mount_Pathrunner", "116773" },
    [39603660] = { "ShadowmoonValley", "99999900", "Pathrunner", "nil", "nil", "Icon_Skull_Orange", "Mount_Pathrunner", "116773" },
    [44604380] = { "ShadowmoonValley", "99999900", "Pathrunner", "nil", "nil", "Icon_Skull_Orange", "Mount_Pathrunner", "116773" },
    [56205240] = { "ShadowmoonValley", "99999900", "Pathrunner", "nil", "nil", "Icon_Skull_Orange", "Mount_Pathrunner", "116773" },
    [45806820] = { "ShadowmoonValley", "99999900", "Pathrunner", "nil", "nil", "Icon_Skull_Orange", "Mount_Pathrunner", "116773" },
    [50907250] = { "ShadowmoonValley", "99999901", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [49607160] = { "ShadowmoonValley", "99999901", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [41907570] = { "ShadowmoonValley", "99999901", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [48706990] = { "ShadowmoonValley", "99999901", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [43207100] = { "ShadowmoonValley", "99999901", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [46607000] = { "ShadowmoonValley", "99999901", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [50307130] = { "ShadowmoonValley", "99999901", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
}

HandyNotes_Draenor.nodes["Talador"] = {
    [36509610] = { "Talador", "34182", "Aarko's Family Treasure", "i557 Crossbow", "nil", "Icon_Treasure_Default", "Treasure", "117567" },
    [62083238] = { "Talador", "34236", "Amethyl Crystal", "100 Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "116131" },
    [81843494] = { "Talador", "34260", "Aruuna Mining Cart", "Ores", "nil", "Icon_Treasure_Default", "Treasure", "109118" },
    [62414797] = { "Talador", "34252", "Barrel of Fish", "Fish", "nil", "Icon_Treasure_Default", "Treasure", "110506" },
    [33297680] = { "Talador", "34259", "Bonechewer Remnants", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [37607490] = { "Talador", "34148", "Bonechewer Spear", "i566 Agility/Intellect Mail Gloves", "The spear spawns from the corpse of Viperlash", "Icon_Treasure_Default", "Treasure", "112371" },
    [73525137] = { "Talador", "34471", "Bright Coin", "i560 Trinket Versatility + Bonus Armor proc", "nil", "Icon_Treasure_Default", "Treasure", "116127" },
    [70100700] = { "Talador", "36937", "Burning Blade Cache", "Apexis Crystal", "nil", "Icon_Treasure_Default", "Treasure", "823" },
    [77044996] = { "Talador", "34248", "Charred Sword", "i563 2H Strength Sword", "nil", "Icon_Treasure_Default", "Treasure", "116116" },
    [66508694] = { "Talador", "34239", "Curious Deathweb Egg", "Toy", "nil", "Icon_Treasure_Default", "Treasure", "117569" },
    [58901200] = { "Talador", "33933", "Deceptia's Smoldering Boots", "Toy", "nil", "Icon_Treasure_Default", "Treasure", "108743" },
    [55256671] = { "Talador", "34253", "Draenei Weapons", "100 Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "116118" },
    [35419656] = { "Talador", "34249", "Farmer's Bounty", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [57362866] = { "Talador", "34238", "Foreman's Lunchbox", "Reusable Food/Drink", "nil", "Icon_Treasure_Default", "Treasure", "116120" },
    [64587920] = { "Talador", "34251", "Iron Box", "i554 1H Strength Mace", "nil", "Icon_Treasure_Default", "Treasure", "117571" },
    [75003600] = { "Talador", "33649", "Iron Scout", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [57207540] = { "Talador", "34134", "Isaari's Cache", "i564 Agility Neck", "nil", "Icon_Treasure_Default", "Treasure", "117563" },
    [65471137] = { "Talador", "34233", "Jug of Aged Ironwine", "Alcoholic Beverages", "nil", "Icon_Treasure_Default", "Treasure", "117568" },
    [75684140] = { "Talador", "34261", "Keluu's Belongings", "Gold", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [53972769] = { "Talador", "34290", "Ketya's Stash", "Pet", "nil", "Icon_Treasure_Default", "Treasure", "116402" },
    [38191242] = { "Talador", "34258", "Light of the Sea", "Gold", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [68805620] = { "Talador", "34101", "Lightbearer", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "109192" },
    [52562954] = { "Talador", "34235", "Luminous Shell", "i557 Intellect Neck", "nil", "Icon_Treasure_Default", "Treasure", "116132" },
    [78211471] = { "Talador", "34263", "Pure Crystal Dust", "i554 Agility Ring", "nil", "Icon_Treasure_Default", "Treasure", "117572" },
    [75784472] = { "Talador", "34250", "Relic of Aruuna", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "116128" },
    [46969174] = { "Talador", "34256", "Relic of Telmor", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "116128" },
    [64901330] = { "Talador", "34232", "Rook's Tacklebox", "+4 Fishing Line", "nil", "Icon_Treasure_Default", "Treasure", "116117" },
    [65968513] = { "Talador", "34276", "Rusted Lockbox", "Random Green", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [39505520] = { "Talador", "34254", "Soulbinder's Reliquary", "i558 Intellect Ring", "nil", "Icon_Treasure_Default", "Treasure", "117570" },
    [74602930] = { "Talador", "35162", "Teroclaw Nest 1", "Pet", "Only one Teroclaw Nest can be looted", "Icon_Treasure_Default", "Treasure", "112699" },
    [39307770] = { "Talador", "35162", "Teroclaw Nest 10", "Pet", "Only one Teroclaw Nest can be looted", "Icon_Treasure_Default", "Treasure", "112699" },
    [73503070] = { "Talador", "35162", "Teroclaw Nest 2", "Pet", "Only one Teroclaw Nest can be looted", "Icon_Treasure_Default", "Treasure", "112699" },
    [74303400] = { "Talador", "35162", "Teroclaw Nest 3", "Pet", "Only one Teroclaw Nest can be looted", "Icon_Treasure_Default", "Treasure", "112699" },
    [72803560] = { "Talador", "35162", "Teroclaw Nest 4", "Pet", "Only one Teroclaw Nest can be looted", "Icon_Treasure_Default", "Treasure", "112699" },
    [72403700] = { "Talador", "35162", "Teroclaw Nest 5", "Pet", "Only one Teroclaw Nest can be looted", "Icon_Treasure_Default", "Treasure", "112699" },
    [70903550] = { "Talador", "35162", "Teroclaw Nest 6", "Pet", "Only one Teroclaw Nest can be looted", "Icon_Treasure_Default", "Treasure", "112699" },
    [70803200] = { "Talador", "35162", "Teroclaw Nest 7", "Pet", "Only one Teroclaw Nest can be looted", "Icon_Treasure_Default", "Treasure", "112699" },
    [54105630] = { "Talador", "35162", "Teroclaw Nest 8", "Pet", "Only one Teroclaw Nest can be looted", "Icon_Treasure_Default", "Treasure", "112699" },
    [39807670] = { "Talador", "35162", "Teroclaw Nest 9", "Pet", "Only one Teroclaw Nest can be looted", "Icon_Treasure_Default", "Treasure", "112699" },
    [38338450] = { "Talador", "34257", "Treasure of Ango'rosh", "Flavor Item - Throwing Rock", "nil", "Icon_Treasure_Default", "Treasure", "116119" },
    [65448860] = { "Talador", "34255", "Webbed Sac", "Gold", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [40608950] = { "Talador", "34140", "Yuuri's Gift", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [28397419] = { "Talador", "36829", "Gift of the Ancients", "i563 Intellect Ring", "Inside a cave; turn all the three statues so they face away from the empty block in the middle to spawn the chest", "Icon_Treasure_Default", "Treasure", "118686" },
    [39304172] = { "Talador", "34207", "Sparkling Pool", "Garrison Resources + Fishing items", "Requires Fishing", "Icon_Treasure_Default", "Treasure", "112623" },
    [46603520] = { "Talador", "37338", "Avatar of Socrethar", "i620 Offhand", "Level 101", "Icon_Skull_Blue", "Rare", "119378" },
    [44003800] = { "Talador", "37339", "Bombardier Gu'gok", "i620 Crossbow", "Level 101", "Icon_Skull_Blue", "Rare", "119413" },
    [37607040] = { "Talador", "34165", "Cro Fleshrender", "i558 Strength 1H Mace", "nil", "Icon_Skull_Grey", "Rare", "116123" },
    [68201580] = { "Talador", "34142", "Dr. Gloom", "Flavor Item - Stink Bombs", "nil", "Icon_Skull_Grey", "Rare", "112499" },
    [34205700] = { "Talador", "34221", "Echo of Murmur", "Toy", "nil", "Icon_Skull_Green", "Rare", "113670" },
    [50808380] = { "Talador", "35018", "Felbark", "i554 Caster Shield", "nil", "Icon_Skull_Grey", "Rare", "112373" },
    [50203520] = { "Talador", "37341", "Felfire Consort", "i620 Agility Ring", "Level 101", "Icon_Skull_Blue", "Rare", "119386" },
    [46005500] = { "Talador", "34145", "Frenzied Golem", "i563 Agility/Strength 1H Sword or i563 Caster Dagger", "nil", "Icon_Skull_Grey", "Rare", "113287" },
    [67408060] = { "Talador", "34929", "Gennadian", "i558 Trinket Agility + Mastery Proc", "nil", "Icon_Skull_Grey", "Rare", "116075" },
    [31806380] = { "Talador", "34189", "Glimmerwing", "Shorttime Speedbuff with limited charges", "nil", "Icon_Skull_Grey", "Rare", "116113" },
    [22207400] = { "Talador", "36919", "Grrbrrgle", "i588 Agility/Intellect Leather Waist", "Click on the Restless Crate", "Icon_Skull_Grey", "Rare", "nil" },
    [47603900] = { "Talador", "37340", "Gug'tol", "i620 Caster Sword", "Level 101", "Icon_Skull_Blue", "Rare", "119402" },
    [48002500] = { "Talador", "37312", "Haakun the All-Consuming", "i620 Strength 1H Sword", "Level 100", "Icon_Skull_Blue", "Rare", "119403" },
    [62004600] = { "Talador", "34185", "Hammertooth", "i558 Agility/Intellect Mail Chest", "nil", "Icon_Skull_Grey", "Rare", "116124" },
    [78005040] = { "Talador", "34167", "Hen-Mother Hami", "i556 Intellect Cloak", "nil", "Icon_Skull_Grey", "Rare", "112369" },
    [56606360] = { "Talador", "35219", "Kharazos the Triumphant + Galzomar + Sikthiss", "Toy", "One of them - loot once", "Icon_Skull_Green", "Rare", "116122" },
    [66808540] = { "Talador", "34498", "Klikixx", "Toy", "nil", "Icon_Skull_Green", "Rare", "116125" },
    [37203760] = { "Talador", "37348", "Kurlosh Doomfang", "i620 Agility Dagger", "Level 102", "Icon_Skull_Blue", "Rare", "119394" },
    [33803780] = { "Talador", "37346", "Lady Demlash", "i620 Cloth Chest", "Level 102", "Icon_Skull_Blue", "Rare", "119352" },
    [37802140] = { "Talador", "37342", "Legion Vanguard", "i620 Strength/Intellect Plate Bracer", "Level 101", "Icon_Skull_Blue", "Rare", "119385" },
    [49009200] = { "Talador", "34208", "Lo'marg Jawcrusher", "i558 Strength Neck", "nil", "Icon_Skull_Grey", "Rare", "116070" },
    [30502640] = { "Talador", "37345", "Lord Korinak", "i620 Strength Ring", "Level 102", "Icon_Skull_Blue", "Rare", "119388" },
    [39004960] = { "Talador", "37349", "Matron of Sin", "i620 Cloth Gloves", "Level 102", "Icon_Skull_Blue", "Rare", "119353" },
    [86403040] = { "Talador", "34859", "No'losh", "i558 Trinket Versatility + Int Proc", "nil", "Icon_Skull_Grey", "Rare", "116077" },
    [31404750] = { "Talador", "37344", "Orumo the Observer", "i620 Intellect Neck + Pet", "Level 102  Requires 5 players to click objects to summon", "Icon_Skull_Green", "Rare", "119375" },
    [59505960] = { "Talador", "34196", "Ra'kahn", "i563 Agility Fistweapon", "nil", "Icon_Skull_Grey", "Rare", "116112" },
    [41004200] = { "Talador", "37347", "Shadowflame Terrorwalker", "i620 Strength 1H Axe", "Level 102", "Icon_Skull_Blue", "Rare", "119393" },
    [41805940] = { "Talador", "34671", "Shirzir", "i554 Agility/Intellect Leather Boots", "nil", "Icon_Skull_Grey", "Rare", "112370" },
    [67703550] = { "Talador", "36858", "Steeltusk", "i559 Agility Polearm", "nil", "Icon_Skull_Grey", "Rare", "117562" },
    [46002740] = { "Talador", "37337", "Strategist Ankor + Archmagus Tekar + Soulbinder Naylana", "i620 Intellect Cloak", "Level 101  All 3 together", "Icon_Skull_Blue", "Rare", "119350" },
    [59008800] = { "Talador", "34171", "Taladorantula", "i565 Agility Sword", "nil", "Icon_Skull_Grey", "Rare", "116126" },
    [53909100] = { "Talador", "34668", "Talonpriest Zorkra", "i560 Cloth Helm", "nil", "Icon_Skull_Grey", "Rare", "116110" },
    [63802070] = { "Talador", "34945", "Underseer Bloodmane", "i554 Strength Ring", "don't kill his Pet", "Icon_Skull_Grey", "Rare", "112475" },
    [36804100] = { "Talador", "37350", "Vigilant Paarthos", "i620 Intellect/Strength Plate Shoulders", "Level 102", "Icon_Skull_Blue", "Rare", "119383" },
    [69603340] = { "Talador", "34205", "Wandering Vindicator", "i554 Strength 1H Sword", "nil", "Icon_Skull_Grey", "Rare", "112261" },
    [38001460] = { "Talador", "37343", "Xothear the Destroyer", "i620 Agility/Intellect Mail Shoulders + Flavor Item", "Level 100", "Icon_Skull_Blue", "Rare", "119371" },
    [53802580] = { "Talador", "34135", "Yazheera the Incinerator", "i554 Agility/Intellect Mail Bracer", "nil", "Icon_Skull_Grey", "Rare", "112263" },

    [78805540] = { "Talador", "99999907", "Silthide", "nil", "nil", "Icon_Skull_Orange", "Mount_Silthide", "116767" },
    [67406000] = { "Talador", "99999907", "Silthide", "nil", "nil", "Icon_Skull_Orange", "Mount_Silthide", "116767" },
    [61803220] = { "Talador", "99999907", "Silthide", "nil", "nil", "Icon_Skull_Orange", "Mount_Silthide", "116767" },
    [62104500] = { "Talador", "99999907", "Silthide", "nil", "nil", "Icon_Skull_Orange", "Mount_Silthide", "116767" },
    [55608060] = { "Talador", "99999907", "Silthide", "nil", "nil", "Icon_Skull_Orange", "Mount_Silthide", "116767" },
    [47004800] = { "Talador", "99999908", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [39705540] = { "Talador", "99999908", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [52002600] = { "Talador", "99999908", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [46205260] = { "Talador", "99999908", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
    [51904120] = { "Talador", "99999908", "Void Talon", "Random Portal Spawn", "nil", "Icon_Skull_Purple", "Mount_VoidTalon", "121815" },
}

HandyNotes_Draenor.nodes["TanaanJungle"] = {
    [15005440] = { "TanaanJungle", "38754", "Axe of Weeping Wolf", "i650 Strength 2H Axe", "First floor of north-east tower", "Icon_Treasure_Default", "Treasure", "127325" },
    [15905930] = { "TanaanJungle", "38757", "The Eye of Grannok", "i650 Intellect/Haste/Multistrike Trinket", "Second floor of south-east tower", "Icon_Treasure_Default", "Treasure", "128220" },
    [17305690] = { "TanaanJungle", "38755", "Spoils of War", "500 Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [17005300] = { "TanaanJungle", "38283", "Stolen Captains Chest", "a little bit of gold", "nil", "Icon_Treasure_Default", "Treasure", "nil" },
    [15904980] = { "TanaanJungle", "38208", "Weathered Axe", "i650 Agility 1H Axe", "In the podling cave", "Icon_Treasure_Default", "Treasure", "127324" },
    [25305020] = { "TanaanJungle", "38735", "Borrowed Enchanted Spyglass", "i650 Intellect/Critical Trinket", "At the top of the east tower", "Icon_Treasure_Default", "Treasure", "128222" },
    [22004780] = { "TanaanJungle", "38678", "Bleeding Hollow Warchest", "100 Garrison Resources", ".", "Icon_Treasure_Default", "Treasure", "824" },
    [26804410] = { "TanaanJungle", "38683", "Looted Bleeding Hollow Treasure", "Transformation Item", "Tanaan campaign #3 completion is required to unlock", "Icon_Treasure_Default", "Treasure", "127709" },
    [19304090] = { "TanaanJungle", "38320", "The Blade of Kra'nak", "i650 Agility 1H Sword", "Underwater", "Icon_Treasure_Default", "Treasure", "127338" },
    [31403110] = { "TanaanJungle", "38732", "Jeweled Arakkoa Effigy", "WoD Gem", "Jump through the rocks", "Icon_Treasure_Default", "Treasure", "127413" },
    [28803460] = { "TanaanJungle", "38863", "Partially Mined Apexis Crystal", "Apexis Crystals", "Cave Entrance is at 29.2 / 31.1", "Icon_Treasure_Default", "Treasure", "823" },
    [34703460] = { "TanaanJungle", "38742", "Skull of the Mad Chief", "Item for Slow Fall/Water Walk", "Cave Entrance is at 32.5 / 37.4", "Icon_Treasure_Default", "Treasure", "127669" },
    [26506300] = { "TanaanJungle", "38741", "Looted Bleeding Hollow Treasure", "Apexis Crystals and Garrison Resources", "At the top of the tower", "Icon_Treasure_Default", "Treasure", "823" },
    [32407040] = { "TanaanJungle", "38426", "Tome of Secrets", "Toy", "nil", "Icon_Treasure_Default", "Treasure", "127670" },
    [30407200] = { "TanaanJungle", "38629", "Polished Crystal", "WoD Gem", "nil", "Icon_Treasure_Default", "Treasure", "127390" },
    [37004620] = { "TanaanJungle", "38640", "Pale Removal Equipment", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [36304350] = { "TanaanJungle", "37956", "Strange Sapphire", "i650 Stamina/Bonus Armor Trinket", "nil", "Icon_Treasure_Default", "Treasure", "127397" },
    [43203830] = { "TanaanJungle", "38821", "The Commanders Shield", "i650 Strength/Intellect Shield", "nil", "Icon_Treasure_Default", "Treasure", "127348" },
    [42803540] = { "TanaanJungle", "38822", "Dazzling Rod", "Toy", "At the top of the north-east tower", "Icon_Treasure_Default", "Treasure", "127859" },
    [46904210] = { "TanaanJungle", "38776", "Sacrificial Blade", "i650 Spellpower Dagger", "nil", "Icon_Treasure_Default", "Treasure", "127328" },
    [46904440] = { "TanaanJungle", "38773", "Fel-Drenched Satchel", "Cosmetic Headgear(Goggles)", "nil", "Icon_Treasure_Default", "Treasure", "128218" },
    [46903660] = { "TanaanJungle", "38771", "Book of Zyzzix", "i650 Caster Offhand", "nil", "Icon_Treasure_Default", "Treasure", "127347" },
    [50806490] = { "TanaanJungle", "38731", "Overgrown Relic", "i650 Agility/Strength Ring", "nil", "Icon_Treasure_Default", "Treasure", "127412" },
    [54806930] = { "TanaanJungle", "38593", "Lodged Hunting Spear", "i650 Agility Polearm", "nil", "Icon_Treasure_Default", "Treasure", "127334" },
    [47907040] = { "TanaanJungle", "38705", "Crystalized Essence of Elements", "i650 Caster Fist Weapon", "nil", "Icon_Treasure_Default", "Treasure", "127329" },
    [57006500] = { "TanaanJungle", "38591", "Forgotten Sack", "Flavour Item + Raw Beast Hides", "nil", "Icon_Treasure_Default", "Treasure", "110609" },
    [46207280] = { "TanaanJungle", "38739", "Mysterious Corrupted Obelisk", "Accessory", "Tanaan campaign #5 completion is required to unlock", "Icon_Treasure_Default", "Treasure", "128320" },
    [41607330] = { "TanaanJungle", "38657", "Forgotten Champions Blade", "i650 Strength 2H Sword", "nil", "Icon_Treasure_Default", "Treasure", "127339" },
    [40807550] = { "TanaanJungle", "38639", "The Perfect Blossom", "Toy", "Get the immunity buff from nearby Mysterious Fruits to prevent loot cast interruption.", "Icon_Treasure_Default", "Treasure", "127766" },
    [40607980] = { "TanaanJungle", "38638", "Snake Charmer Flute", "i650 Caster 2H Mace", "nil", "Icon_Treasure_Default", "Treasure", "127333" },
    [34407830] = { "TanaanJungle", "38762", "Stashed Iron Sea Booty #3", "Gold and Garrison Resources", "Cave Entrance is at 37.5 / 76.0", "Icon_Treasure_Default", "Treasure", "824" },
    [35007730] = { "TanaanJungle", "38761", "Stashed Iron Sea Booty #2", "Gold and Garrison Resources", "Cave Entrance is at 37.5 / 76.0", "Icon_Treasure_Default", "Treasure", "824" },
    [33907810] = { "TanaanJungle", "38760", "Stashed Iron Sea Booty #1", "Gold and Garrison Resources", "Cave Entrance is at 37.5 / 76.0", "Icon_Treasure_Default", "Treasure", "824" },
    [35907860] = { "TanaanJungle", "38758", "Ironbeards Treasure", "Gold and Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [37708070] = { "TanaanJungle", "38788", "Brazier of Awakening", "Ressurection Accessory", "nil", "Icon_Treasure_Default", "Treasure", "127770" },
    [48507520] = { "TanaanJungle", "38814", "Looted Mystical Staff", "i650 Caster Staff", "Cave Entrance is at 44.4 / 77.5", "Icon_Treasure_Default", "Treasure", "127337" },
    [49907680] = { "TanaanJungle", "38809", "Bleeding Hollow Mushroom Stash", "Food with Side effects", "Cave Entrance is at 44.4 / 77.5", "Icon_Treasure_Default", "Treasure", "128223" },
    [62107070] = { "TanaanJungle", "38602", "Crystalized Fel Spike", "i650 Intellect/Spirit Trinket", "nil", "Icon_Treasure_Default", "Treasure", "128217" },
    [61207580] = { "TanaanJungle", "38601", "Blackfang Isle Cache", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [49907960] = { "TanaanJungle", "38703", "Scouts Belongings", "i650 Agility Cloak", "Top of the cave", "Icon_Treasure_Default", "Treasure", "127354" },
    [49908120] = { "TanaanJungle", "38702", "Discarded Helm", "i650 Agility/Intellect Mail Helm", "Inside the cave", "Icon_Treasure_Default", "Treasure", "127312" },
    [64704280] = { "TanaanJungle", "38701", "Loose Soil", "Transformation Toy", "nil", "Icon_Treasure_Default", "Treasure", "127396" },
    [51702430] = { "TanaanJungle", "38686", "Rune Etched Femur", "i650 Wand", "nil", "Icon_Treasure_Default", "Treasure", "127341" },
    [58502520] = { "TanaanJungle", "38679", "Jewel of the Fallen Star", "WoD Gem", "nil", "Icon_Treasure_Default", "Treasure", "115524" },
    [62602050] = { "TanaanJungle", "38682", "Censer of Torment", "i650 Strength/Versatility Trinket", "nil", "Icon_Treasure_Default", "Treasure", "127401" },
    [51603270] = { "TanaanJungle", "39075", "Fel-Tainted Apexis Formation", "Apexis Crystals", "Hanging from the pillar's edge", "Icon_Treasure_Default", "Treasure", "823" },
    [28702330] = { "TanaanJungle", "38334", "Jewel of Hellfire", "Toy", "nil", "Icon_Treasure_Default", "Treasure", "127668" },
    [63402810] = { "TanaanJungle", "38740", "Forgotten Shard of the Cipher", "Pet", "Tanaan campaign #6 completion is required to unlock", "Icon_Treasure_Default", "Treasure", "128309" },
    [54909070] = { "TanaanJungle", "39470", "Dead Mans Chest", "Garrison Resource", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [65908500] = { "TanaanJungle", "39469", "Bejeweled Egg", "Trash Item", "nil", "Icon_Treasure_Default", "Treasure", "128386" },
    [69705600] = { "TanaanJungle", "38704", "Forgotten Iron Horde Supplies", "Garrison Resources", "nil", "Icon_Treasure_Default", "Treasure", "824" },
    [73604320] = { "TanaanJungle", "38779", "Stashed Bleeding Hollow Loot", "Gold + Trash Item", "First floor of north-east tower.", "Icon_Treasure_Default", "Treasure", "nil" },
    
    [13605680] = { "TanaanJungle", "38747", "Tho'gar Gorefist", "i655 Agility/Intellect Mail Boots", "nil", "Icon_Skull_Blue", "Rare", "127310", "28347" },
    [13005700] = { "TanaanJungle", "38751", "The Iron Houndmaster", "i655 Strength/Intellect Plate Shoulders", "Capture Strongpoint (west) to make him spawn. Iron Front event required", "Icon_Skull_Blue", "Rare", "127321", "28350" },
    [16005920] = { "TanaanJungle", "38750", "Grannok", "i655 Intellect Neck", "At the top of the south-east tower.", "Icon_Skull_Blue", "Rare", "127649", "28348" },
    [15005420] = { "TanaanJungle", "38746", "Commander Krag'goth", "i655 Strength/Intellect Plate Gloves", "At the top of the north-east tower", "Icon_Skull_Blue", "Rare", "127319", "28346" },
    [16005720] = { "TanaanJungle", "38752", "Szirek the Twisted", "i655 Cloth Gloves", "Capture Strongpoint (east) to make him spawn. Iron Front event required", "Icon_Skull_Blue", "Rare", "127296", "28349" },
    [16804860] = { "TanaanJungle", "38282", "Podlord Wakkawam", "i655 Agility Staff", "nil", "Icon_Skull_Blue", "Rare", "127336", "28329" },
    [23605200] = { "TanaanJungle", "38262", "Bilkor the Thrower", "i655 Agility/Intellect Leather Shoulder", "nil", "Icon_Skull_Blue", "Rare", "127307", "28351" },
    [20404980] = { "TanaanJungle", "38263", "Rogond the Tracker", "i655 Agility/Intellect Mail Shoulder", "nil", "Icon_Skull_Blue", "Rare", "127314", "28352" },
    [19805360] = { "TanaanJungle", "38736", "Driss Vile", "i655 Gun", "At the top of the south tower", "Icon_Skull_Blue", "Rare", "127331", "28369" },
    [25504620] = { "TanaanJungle", "38264", "Drivnul", "i655 Cloth Pants", "nil", "Icon_Skull_Blue", "Rare", "127298", "28354" },
    [23204840] = { "TanaanJungle", "38265", "Dorg the Bloody", "i655 Cloth Belt", "Killing mobs in the area will make him spawn somewhere in the area", "Icon_Skull_Blue", "Rare", "127301", "28353" },
    [22805120] = { "TanaanJungle", "38266", "Bloodhunter Zulk", "i655 Agility/Intellect Leather Boots", "Interrupting Bleeding Hollow activities will make him spawn", "Icon_Skull_Blue", "Rare", "127303", "28355" },
    [22205080] = { "TanaanJungle", "39159", "Remnant of the Blood Moon", "Toy", "Draining Blood Moon empty will make it spawn. Zeth'Gol event required", "Icon_Skull_Green", "Rare", "127666" },
    [16804340] = { "TanaanJungle", "38034", "Rasthe", "i655 Crit/Mastery/Multistrike Trinket", "nil", "Icon_Skull_Blue", "Rare", "127661", "28341" },
    [20404000] = { "TanaanJungle", "38028", "High Priest Ikzan", "Transformation Accessory", "Roams the whole camp", "Icon_Skull_Green", "Rare", "122117" },
    [27603280] = { "TanaanJungle", "37937", "Varyx the Damned", "i655 Intellect Ring", "Need 5 players to open his prison", "Icon_Skull_Blue", "Rare", "127351", "28340" },
    [26305420] = { "TanaanJungle", "38496", "Relgor", "i655 Agility Polearm", "nil", "Icon_Skull_Blue", "Rare", "127335", "28356" },
    [28605080] = { "TanaanJungle", "38775", "Felbore", "i655 Strength Ring", "Cave Entrance is at 31.3 / 53.5", "Icon_Skull_Blue", "Rare", "127350", "28372" },
    [31406800] = { "TanaanJungle", "38031", "Ceraxas", "Fel Pup - Pet", "doesn't actually drop the pet, but spawns the quest required to get it", "Icon_Skull_Green", "Rare", "nil", "28336" },
    [27607480] = { "TanaanJungle", "38030", "Jax'zor", "i655 Strength/Intellect Plate Belt", "Cave Entrance is at 29.6 / 70.6", "Icon_Skull_Blue", "Rare", "127322", "28335" },
    [25807900] = { "TanaanJungle", "38032", "Mistress Thavra", "i655 Cloth Shoulders", "Cave Entrance is at 29.6 / 70.6", "Icon_Skull_Blue", "Rare", "127300", "28337" },
    [25407720] = { "TanaanJungle", "38029", "Lady Oran", "i655 Agility/Intellect Mail Wrist", "Cave Entrance is at 29.6 / 70.6", "Icon_Skull_Blue", "Rare", "127316", "28334" },
    [31607280] = { "TanaanJungle", "38026", "Imp-Master Valessa", "Accessory", "nil", "Icon_Skull_Green", "Rare", "127655", "28333" },
    [35404680] = { "TanaanJungle", "38609", "Belgork", "i655 Strength/Intellect Shield", "nil", "Icon_Skull_Blue", "Rare", "127650", "28363" },
    [34004440] = { "TanaanJungle", "38620", "Thromma the Gutslicer", "i655 Agility Dagger", "nil", "Icon_Skull_Blue", "Rare", "127327", "28362" },
    [33003570] = { "TanaanJungle", "38709", "Gorabosh", "i655 Agility/Intellect Leather Gloves", "nil", "Icon_Skull_Blue", "Rare", "127304", "28368" },
    [37003280] = { "TanaanJungle", "39045", "Zoug the Heavy", "i655 Agility/Intellect Leather Belt", "nil", "Icon_Skull_Blue", "Rare", "127308", "28723" },
    [39603260] = { "TanaanJungle", "39046", "Harbormaster Korak", "i655 Agility/Intellect Mail Body", "nil", "Icon_Skull_Blue", "Rare", "127309", "28724" },
    [42403730] = { "TanaanJungle", "37953", "Sergeant Mor'grak", "i655 Strength/Intellect Plate Boots", "nil", "Icon_Skull_Blue", "Rare", "127318", "28339" },
    [44603760] = { "TanaanJungle", "37990", "Cindral the Wildfire", "i655 Versatility/Mastery/Multistrike Trinket", "Killing all Remnant of Cindral in the forge will make it spawn", "Icon_Skull_Blue", "Rare", "127660", "28338" },
    [45804700] = { "TanaanJungle", "38634", "Felsmith Damorka", "i655 Agility/Intellect Leather Body", "nil", "Icon_Skull_Blue", "Rare", "127302", "28726" },
    [50003600] = { "TanaanJungle", "38411", "Executor Riloth", "i655 Strength/Intellect Plate Bracer", "nil", "Icon_Skull_Blue", "Rare", "127323", "28380" },
    [46204240] = { "TanaanJungle", "38400", "Grand Warlock Nethekurse", "i655 Cloth Body", "nil", "Icon_Skull_Blue", "Rare", "127299", "28343" },
    [51004600] = { "TanaanJungle", "38749", "Commander Org'mok", "i655 Agility/Intellect Mail Pants", "Patrols around the area", "Icon_Skull_Blue", "Rare", "127313", "28731" },
    [48005720] = { "TanaanJungle", "38820", "Captain Grok'mar", "i655 Strength/Intellect Plate Pants", "nil", "Icon_Skull_Blue", "Rare", "127664", "28730" },
    [49706140] = { "TanaanJungle", "38812", "Shadowthrash", "i655 Agility/Intellect Leather Bracer", "nil", "Icon_Skull_Blue", "Rare", "127665", "28725" },
    [52206510] = { "TanaanJungle", "38726", "Magwia", "i655 Strength 1H Mace", "nil", "Icon_Skull_Blue", "Rare", "127332", "28345" },
    [40807000] = { "TanaanJungle", "38209", "Bramblefell", "Toy - Cooking Fire", "nil", "Icon_Skull_Green", "Rare", "127652", "28330" },
    [39606810] = { "TanaanJungle", "38825", "Kris'kar the Unredeemed", "i655 Strength 1H Sword", "Cave Entrance is at 42.5 / 68.9", "Icon_Skull_Blue", "Rare", "127653", "28377" },
    [34307250] = { "TanaanJungle", "38654", "The Goreclaw", "i655 Agility/Intellect Leather Helm", "Cave Entrance is at 36.2 / 72.4", "Icon_Skull_Blue", "Rare", "127305", "28367" },
    [39407380] = { "TanaanJungle", "38632", "The Night Haunter", "i655 Strength Cloak", "Collect 10 Stacks of his debuff to spawn him by finding 'copies' of him or by touching mutilated corpses", "Icon_Skull_Blue", "Rare", "127355", "28366" },
    [41007880] = { "TanaanJungle", "38628", "Sylissa", "i655 Agility/Intellect Mail Gloves", "nil", "Icon_Skull_Blue", "Rare", "127311", "28364" },
    [41807380] = { "TanaanJungle", "38631", "Rendrak", "i655 Intellect Cloak", "nil", "Icon_Skull_Blue", "Rare", "127356", "28365" },
    [36207970] = { "TanaanJungle", "38756", "Captain Ironbeard", "Toy", "Cave Entrance is at 37.5 / 76.0", "Icon_Skull_Green", "Rare", "127659", "28370" },
    [34607820] = { "TanaanJungle", "38764", "Glub'glok", "i655 Strength/Intellect Plate Body", "Cave Entrance is at 37.5 / 76.0. You need to open a chest to actually spawn him", "Icon_Skull_Blue", "Rare", "127317", "28371" },
    [51007440] = { "TanaanJungle", "38696", "Bleeding Hollow Horror", "i655 Stamina/Bonus Armor Trinket", "Cave Entrance is at 44.4 / 77.5", "Icon_Skull_Blue", "Rare", "127654", "28376" },
    [57606720] = { "TanaanJungle", "38589", "Broodlord Ixkor", "i655 Agility Ring", "nil", "Icon_Skull_Blue", "Rare", "127349", "28357" },
    [62607200] = { "TanaanJungle", "38600", "Soulslicer", "i655 Agility/Intellect Mail Belt", "nil", "Icon_Skull_Blue", "Rare", "127315", "28358" },
    [63608110] = { "TanaanJungle", "38604", "Gloomtalon", "i655 Agility/Intellect Leather Pants", "nil", "Icon_Skull_Blue", "Rare", "127306", "28359" },
    [52108390] = { "TanaanJungle", "38605", "Krell the Serene", "i655 Agility/Multistrike Trinket", "nil", "Icon_Skull_Blue", "Rare", "127418", "28360" },
    [48807280] = { "TanaanJungle", "38597", "The Blackfang", "i655 Agility Fist Weapon", "nil", "Icon_Skull_Blue", "Rare", "127330", "28361" },
    [48402850] = { "TanaanJungle", "38207", "Zeter'el", "i655 Strength 2H Sword", "Cave Entrance is at 48.1 / 33.0", "Icon_Skull_Blue", "Rare", "127340", "28331" },
    [52802560] = { "TanaanJungle", "38211", "Felspark", "i655 Cloth Bracer", "nil", "Icon_Skull_Blue", "Rare", "127656", "28332" },
    [53602170] = { "TanaanJungle", "38557", "Painmistress Selora", "i655 Cloth Helm", "Complete the event by killing mob waves to make her spawn", "Icon_Skull_Blue", "Rare", "127297", "28342" },
    [57102280] = { "TanaanJungle", "38457", "Putre'thar", "i655 Intellect/Spirit Trinket", "nil", "Icon_Skull_Blue", "Rare", "127657", "28727" },
    [53002000] = { "TanaanJungle", "38580", "Overlord Ma'gruth", "i655 Strength/Intellect Plate Helm", "nil", "Icon_Skull_Blue", "Rare", "127320", "28729" },
    [60202090] = { "TanaanJungle", "38579", "Xanzith the Everlasting", "i655 Intellect Offhand", "nil", "Icon_Skull_Blue", "Rare", "127658", "28728" },
    [65403660] = { "TanaanJungle", "38700", "Steelsnout", "i655 Agility/Strength Cloak", "nil", "Icon_Skull_Blue", "Rare", "127357", "28344" },
    [52604020] = { "TanaanJungle", "38430", "Argosh the Destroyer", "i655 Crossbow", "nil", "Icon_Skull_Blue", "Rare", "127326", "28722" },
    [41407960] = { "TanaanJungle", "37407", "Keravnos", "Unknown", "nil", "Icon_Skull_Blue", "Rare", "nil" },
    [88005550] = { "TanaanJungle", "40104", "Smashum Grabb", "Toy", "nil", "Icon_Skull_Green", "Rare", "108634" },
    [83504380] = { "TanaanJungle", "40105", "Drakum", "Toy", "nil", "Icon_Skull_Green", "Rare", "108631" },
    [80405680] = { "TanaanJungle", "40106", "Gondar", "Toy", "nil", "Icon_Skull_Green", "Rare", "108633" },
    [40705630] = { "TanaanJungle", "40107", "Fel Overseer Mudlump", "Dismounting item", "nil", "Icon_Skull_Green", "Rare", "129295" },
    
    [13505900] = { "TanaanJungle", "39288", "Terrorfist", "Mounts + Oil", "His spawn will be announced by Frogan: A massive gronnling is heading for Rangari Refuge! We are going to require some assistance!", "Icon_Skull_Red", "Mount_Terrorfist", "nil" },
    [23204040] = { "TanaanJungle", "39287", "Deathtalon", "Mounts + Oil", "His spawn will be announced by Shadow Lord Iskar: Behind the veil, all you find is death!", "Icon_Skull_Red", "Mount_Deathtalon", "nil" },
    [32407400] = { "TanaanJungle", "39290", "Vengeance", "Mounts + Oil", "His spawn will be announced by Tyrant Velhari: Insects deserve to be crushed!", "Icon_Skull_Red", "Mount_Vengeance", "nil" },
    [47005260] = { "TanaanJungle", "39289", "Doomroller", "Mounts + Oil", "His spawn will be announced by Siegemaster Mar'tak: Hah-ha! Trample their corpses!", "Icon_Skull_Red", "Mount_Doomroller", "nil" },
}

if (UnitFactionGroup("player") =="Alliance") then
    HandyNotes_Draenor.nodes["ShadowmoonValleyDR"][29600620] = { "ShadowmoonValley", "35281", "Bahameye", "Fire Ammonite", "nil", "Icon_Skull_Grey", "Rare", "111666" }
    HandyNotes_Draenor.nodes["Gorgrond"][60805400] = { "Gorgrond", "36502", "Biolante", "Quest Item for XP", "You must finish the quest before this element gets removed from the map", "Icon_Skull_Grey", "Rare", "116159" }
    HandyNotes_Draenor.nodes["Gorgrond"][46004680] = { "Gorgrond", "35816", "Charl Doomwing", "Quest Item for XP", "You must finish the quest before this element gets removed from the map", "Icon_Skull_Grey", "Rare", "113457" }
    HandyNotes_Draenor.nodes["Gorgrond"][42805920] = { "Gorgrond", "35812", "Crater Lord Igneous", "Quest Item for XP", "You must finish the quest before this element gets removed from the map", "Icon_Skull_Grey", "Rare", "113449" }
    HandyNotes_Draenor.nodes["Gorgrond"][40505100] = { "Gorgrond", "35809", "Dessicus of the Dead Pools", "Quest Item for XP", "You must finish the quest before this element gets removed from the map", "Icon_Skull_Grey", "Rare", "113446" }
    HandyNotes_Draenor.nodes["Gorgrond"][51804160] = { "Gorgrond", "35808", "Erosian the Violent", "Quest Item for XP", "You must finish the quest before this element gets removed from the map", "Icon_Skull_Grey", "Rare", "113445" }
    HandyNotes_Draenor.nodes["Gorgrond"][58006360] = { "Gorgrond", "35813", "Fungal Praetorian", "Quest Item for XP", "You must finish the quest before this element gets removed from the map", "Icon_Skull_Grey", "Rare", "113453" }
    HandyNotes_Draenor.nodes["ShadowmoonValleyDR"][21603300] = { "ShadowmoonValley", "33664", "Gorum", "i516 Agility/Intellect Ring", "Inside Bloodthorn Cave - Spawns at the Ceiling", "Icon_Skull_Grey", "Rare", "113082" }
    HandyNotes_Draenor.nodes["Gorgrond"][52406580] = { "Gorgrond", "35820", "Khargax the Devourer", "Quest Item for XP", "You must finish the quest before this element gets removed from the map", "Icon_Skull_Grey", "Rare", "113461" }
    HandyNotes_Draenor.nodes["ShadowmoonValleyDR"][30301990] = { "ShadowmoonValley", "35530", "Lunarfall Egg", "Garrison Resources", "Changes position to inside the garrison once it is built", "Icon_Treasure_Default", "Treasure", "824" }
    HandyNotes_Draenor.nodes["Gorgrond"][51206360] = { "Gorgrond", "35817", "Roardan the Sky Terror", "Quest Item for XP", "Flies around a lot, Coordinates are just somewhere on his route!You must finish the quest before this element gets removed from the map", "Icon_Skull_Grey", "Rare", "113458" }
    HandyNotes_Draenor.nodes["ShadowmoonValleyDR"][42804100] = { "ShadowmoonValley", "33038", "Windfang Matriarch", "i516 Agility/Strength 1H Sword", "Is part of the Embaari Crystal Defense Event", "Icon_Skull_Grey", "Rare", "113553" }

    HandyNotes_Draenor.nodes["Gorgrond"][45634931] = { "Gorgrond", "36722", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][43224574] = { "Gorgrond", "36723", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][41764527] = { "Gorgrond", "36726", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][48115516] = { "Gorgrond", "36730", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][51334055] = { "Gorgrond", "36734", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][46056305] = { "Gorgrond", "36736", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][58125146] = { "Gorgrond", "36739", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][59567275] = { "Gorgrond", "36781", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][45748821] = { "Gorgrond", "36784", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][45544298] = { "Gorgrond", "36733", "Ancient Ogre Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][45076993] = { "Gorgrond", "36737", "Ancient Ogre Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][61555855] = { "Gorgrond", "36740", "Ancient Ogre Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][54257313] = { "Gorgrond", "36782", "Ancient Ogre Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][42179308] = { "Gorgrond", "36787", "Ancient Ogre Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][41528652] = { "Gorgrond", "36789", "Ancient Ogre Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][49425084] = { "Gorgrond", "36710", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][42195203] = { "Gorgrond", "36727", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][43365169] = { "Gorgrond", "36731", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][47923998] = { "Gorgrond", "36735", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][50326658] = { "Gorgrond", "36738", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][49128248] = { "Gorgrond", "36783", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][48114638] = { "Gorgrond", "36721", "Obsidian Crystal Formation", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][41855889] = { "Gorgrond", "36728", "Obsidian Crystal Formation", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][42056429] = { "Gorgrond", "36729", "Obsidian Crystal Formation", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }
    HandyNotes_Draenor.nodes["Gorgrond"][44184665] = { "Gorgrond", "36732", "Obsidian Crystal Formation", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36251" }

    HandyNotes_Draenor.nodes["Gorgrond"][49074846] = { "Gorgrond", "35952", "Aged Stone Container", "nil", "QuestID is missing, will stay active until manually disabled", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][42345477] = { "Gorgrond", "36003", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][47514363] = { "Gorgrond", "36717", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][53354679] = { "Gorgrond", "35701", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][50155376] = { "Gorgrond", "35984", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][42084607] = { "Gorgrond", "36720", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][41988155] = { "Gorgrond", "35982", "Botani Essence Seed", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][49657883] = { "Gorgrond", "35968", "Forgotten Ogre Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][47016905] = { "Gorgrond", "35971", "Forgotten Skull Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][45808931] = { "Gorgrond", "36019", "Forgotten Skull Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][39335627] = { "Gorgrond", "36716", "Forgotten Skull Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][56745727] = { "Gorgrond", "35965", "Mysterious Petrified Pod", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][41147726] = { "Gorgrond", "35980", "Mysterious Petrified Pod", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][60507276] = { "Gorgrond", "36015", "Mysterious Petrified Pod", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][63285719] = { "Gorgrond", "36430", "Mysterious Petrified Pod", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][47647679] = { "Gorgrond", "36714", "Mysterious Petrified Pod", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][51756909] = { "Gorgrond", "36715", "Mysterious Petrified Pod", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][40956732] = { "Gorgrond", "35979", "Obsidian Crystal Formation", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][45969357] = { "Gorgrond", "35975", "Remains of Explorer Engineer Toldirk Ashlamp", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][51806148] = { "Gorgrond", "35966", "Remains of Grimnir Ashpick", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][51647226] = { "Gorgrond", "35967", "Unknown Petrified Egg", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][45318195] = { "Gorgrond", "35981", "Unknown Petrified Egg", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][42914350] = { "Gorgrond", "36001", "Unknown Petrified Egg", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][53007906] = { "Gorgrond", "36713", "Unknown Petrified Egg", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }
    HandyNotes_Draenor.nodes["Gorgrond"][47245180] = { "Gorgrond", "36718", "Unknown Petrified Egg", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36249" }

elseif (UnitFactionGroup("player") =="Horde") then
    HandyNotes_Draenor.nodes["Gorgrond"][60805400] = { "Gorgrond", "36503", "Biolante", "Quest Item for XP", "You must finish the quest before this element gets removed from the map", "Icon_Skull_Grey", "Rare", "116160" }
    HandyNotes_Draenor.nodes["Gorgrond"][46004680] = { "Gorgrond", "35815", "Charl Doomwing", "Quest Item for XP", "You must finish the quest before this element gets removed from the map", "Icon_Skull_Grey", "Rare", "113456" }
    HandyNotes_Draenor.nodes["Gorgrond"][42805920] = { "Gorgrond", "35811", "Crater Lord Igneous", "Quest Item for XP", "You must finish the quest before this element gets removed from the map", "Icon_Skull_Grey", "Rare", "113448" }
    HandyNotes_Draenor.nodes["Gorgrond"][40505100] = { "Gorgrond", "35810", "Dessicus of the Dead Pools", "Quest Item for XP", "You must finish the quest before this element gets removed from the map", "Icon_Skull_Grey", "Rare", "113447" }
    HandyNotes_Draenor.nodes["Gorgrond"][51804160] = { "Gorgrond", "35807", "Erosian the Violent", "Quest Item for XP", "You must finish the quest before this element gets removed from the map", "Icon_Skull_Grey", "Rare", "113444" }
    HandyNotes_Draenor.nodes["Gorgrond"][58006360] = { "Gorgrond", "35814", "Fungal Praetorian", "Quest Item for XP", "You must finish the quest before this element gets removed from the map", "Icon_Skull_Grey", "Rare", "113454" }
    HandyNotes_Draenor.nodes["Gorgrond"][52406580] = { "Gorgrond", "35819", "Khargax the Devourer", "Quest Item for XP", "You must finish the quest before this element gets removed from the map", "Icon_Skull_Grey", "Rare", "113460" }
    HandyNotes_Draenor.nodes["Talador"][61107170] = { "Talador", "34116", "Norana's Cache", "i564 Agility Neck", "nil", "Icon_Treasure_Default", "Icon_Treasure_Default", "117563" }
    HandyNotes_Draenor.nodes["Gorgrond"][51206360] = { "Gorgrond", "35818", "Roardan the Sky Terror", "Quest Item for XP", "Flies around a lot, Coordinates are just somewhere on his route!You must finish the quest before this element gets removed from the map", "Icon_Skull_Grey", "Rare", "113459" }

    HandyNotes_Draenor.nodes["Gorgrond"][45634931] = { "Gorgrond", "36722", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][43224574] = { "Gorgrond", "36723", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][41764527] = { "Gorgrond", "36726", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][48115516] = { "Gorgrond", "36730", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][51334055] = { "Gorgrond", "36734", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][46056305] = { "Gorgrond", "36736", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][58125146] = { "Gorgrond", "36739", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][59567275] = { "Gorgrond", "36781", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][45748821] = { "Gorgrond", "36784", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][45544298] = { "Gorgrond", "36733", "Ancient Ogre Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][45076993] = { "Gorgrond", "36737", "Ancient Ogre Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][61555855] = { "Gorgrond", "36740", "Ancient Ogre Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][54257313] = { "Gorgrond", "36782", "Ancient Ogre Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][42179308] = { "Gorgrond", "36787", "Ancient Ogre Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][41528652] = { "Gorgrond", "36789", "Ancient Ogre Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][49425084] = { "Gorgrond", "36710", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][42195203] = { "Gorgrond", "36727", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][43365169] = { "Gorgrond", "36731", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][47923998] = { "Gorgrond", "36735", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][50326658] = { "Gorgrond", "36738", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][49128248] = { "Gorgrond", "36783", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][48114638] = { "Gorgrond", "36721", "Obsidian Crystal Formation", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][41855889] = { "Gorgrond", "36728", "Obsidian Crystal Formation", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][42056429] = { "Gorgrond", "36729", "Obsidian Crystal Formation", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }
    HandyNotes_Draenor.nodes["Gorgrond"][44184665] = { "Gorgrond", "36732", "Obsidian Crystal Formation", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36252" }

    HandyNotes_Draenor.nodes["Gorgrond"][49074846] = { "Gorgrond", "35952", "Aged Stone Container", "nil", "QuestID is missing, will stay active until manually disabled", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][42345477] = { "Gorgrond", "36003", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][47514363] = { "Gorgrond", "36717", "Aged Stone Container", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][53354679] = { "Gorgrond", "35701", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][50155376] = { "Gorgrond", "35984", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][42084607] = { "Gorgrond", "36720", "Ancient Titan Chest", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][41988155] = { "Gorgrond", "35982", "Botani Essence Seed", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][49657883] = { "Gorgrond", "35968", "Forgotten Ogre Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][47016905] = { "Gorgrond", "35971", "Forgotten Skull Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][45808931] = { "Gorgrond", "36019", "Forgotten Skull Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][39335627] = { "Gorgrond", "36716", "Forgotten Skull Cache", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][56745727] = { "Gorgrond", "35965", "Mysterious Petrified Pod", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][41147726] = { "Gorgrond", "35980", "Mysterious Petrified Pod", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][60507276] = { "Gorgrond", "36015", "Mysterious Petrified Pod", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][63285719] = { "Gorgrond", "36430", "Mysterious Petrified Pod", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][47647679] = { "Gorgrond", "36714", "Mysterious Petrified Pod", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][51756909] = { "Gorgrond", "36715", "Mysterious Petrified Pod", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][40956732] = { "Gorgrond", "35979", "Obsidian Crystal Formation", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][45969357] = { "Gorgrond", "35975", "Remains of Explorer Engineer Toldirk Ashlamp", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][51806148] = { "Gorgrond", "35966", "Remains of Grimnir Ashpick", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][51647226] = { "Gorgrond", "35967", "Unknown Petrified Egg", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][45318195] = { "Gorgrond", "35981", "Unknown Petrified Egg", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][42914350] = { "Gorgrond", "36001", "Unknown Petrified Egg", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][53007906] = { "Gorgrond", "36713", "Unknown Petrified Egg", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
    HandyNotes_Draenor.nodes["Gorgrond"][47245180] = { "Gorgrond", "36718", "Unknown Petrified Egg", "nil", "nil", "Icon_Treasure_Default", "Treasure-Quest", "824", "36250" }
end

if ((IsQuestFlaggedCompleted(36386) == false) or (IsQuestFlaggedCompleted(36390) == false) or (IsQuestFlaggedCompleted(36389) == false) or (IsQuestFlaggedCompleted(36392) == false) or (IsQuestFlaggedCompleted(36388) == false) or (IsQuestFlaggedCompleted(36381) == false)) then
    HandyNotes_Draenor.nodes["SpiresOfArak"][43901500] = { "SpiresOfArak", "36395", "Elixir of Shadow Sight 1", "Elixir of Shadow Sight", "Elixir can be used at Shrine of Terrok for 1 of 6 i585 Weapons (see Gift of Anzu) Object will be removed as soon as you loot all Gifts of Anzu", "Icon_Treasure_Default", "Treasure", "115463" }
    HandyNotes_Draenor.nodes["SpiresOfArak"][43802470] = { "SpiresOfArak", "36397", "Elixir of Shadow Sight 2", "Elixir of Shadow Sight", "Elixir can be used at Shrine of Terrok for 1 of 6 i585 Weapons (see Gift of Anzu) Object will be removed as soon as you loot all Gifts of Anzu", "Icon_Treasure_Default", "Treasure", "115463" }
    HandyNotes_Draenor.nodes["SpiresOfArak"][69204330] = { "SpiresOfArak", "36398", "Elixir of Shadow Sight 3", "Elixir of Shadow Sight", "Elixir can be used at Shrine of Terrok for 1 of 6 i585 Weapons (see Gift of Anzu) Object will be removed as soon as you loot all Gifts of Anzu", "Icon_Treasure_Default", "Treasure", "115463" }
    HandyNotes_Draenor.nodes["SpiresOfArak"][48906250] = { "SpiresOfArak", "36399", "Elixir of Shadow Sight 4", "Elixir of Shadow Sight", "Elixir can be used at Shrine of Terrok for 1 of 6 i585 Weapons (see Gift of Anzu) Object will be removed as soon as you loot all Gifts of Anzu", "Icon_Treasure_Default", "Treasure", "115463" }
    HandyNotes_Draenor.nodes["SpiresOfArak"][55602200] = { "SpiresOfArak", "36400", "Elixir of Shadow Sight 5", "Elixir of Shadow Sight", "Elixir can be used at Shrine of Terrok for 1 of 6 i585 Weapons (see Gift of Anzu) Object will be removed as soon as you loot all Gifts of Anzu", "Icon_Treasure_Default", "Treasure", "115463" }
    HandyNotes_Draenor.nodes["SpiresOfArak"][53108450] = { "SpiresOfArak", "36401", "Elixir of Shadow Sight 6", "Elixir of Shadow Sight", "Elixir can be used at Shrine of Terrok for 1 of 6 i585 Weapons (see Gift of Anzu) Object will be removed as soon as you loot all Gifts of Anzu", "Icon_Treasure_Default", "Treasure", "115463" }
end


local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes", true)

local nodes = HandyNotes_Draenor.nodes
local info = {}
local ClickedMapFile = nil
local ClickedCoord = nil


local function GetRewardNameByID(ID)
    if ID == "824" or ID == "823" then
        local Reward = GetCurrencyInfo(ID)
        if Reward ~= nil then
            return Reward
        end
    else
       local Reward = GetItemInfo(ID)
       if Reward ~= nil then
            return Reward
        end
    end
    return nil
end

local function GetRewardLinkByID(ID)
    if ID == "824" or ID == "823" then
        local Reward = GetCurrencyInfo(ID)
        if Reward ~= nil then
            return Reward
        end
    else
       local _, Reward = GetItemInfo(ID)
       if Reward ~= nil then
            return Reward
        end
    end
    return nil
end

local function GetRewardIconByID(ID)
    if ID == "824" or ID == "823" then
         local _, _, Icon = GetCurrencyInfo(ID)
         if Icon ~= nil then
            return Icon
         end
    else
         local _, _, _, _, Icon = GetItemInfoInstant(ID)
         if Icon ~= nil then
            return Icon
         end
    end
    return "Interface\\Icons\\TRADE_ARCHAEOLOGY_CHESTOFTINYGLASSANIMALS"
end

local function generateMenu(button, level)
    if (level ~= nil) then 
        if (level == 1) then
            info.isTitle = 1
            info.text = "HandyNotes: Draenor"
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)
            
            info.disabled = nil
            info.isTitle = nil
            info.notCheckable = 0
            info.text = "Remove POI from Map"
            info.func = DisablePOI
            info.arg1 = ClickedMapFile
            info.arg2 = ClickedCoord
            UIDropDownMenu_AddButton(info, level)
            
            if HandyNotes_Draenor.db.profile.Integration.TomTom.Loaded == true then
                info.notCheckable = 0
                info.text = "Create TomTom Waypoint"
                info.func = TomTomCreateArrow
                info.arg1 = ClickedMapFile
                info.arg2 = ClickedCoord
                UIDropDownMenu_AddButton(info, level)
            end

            if HandyNotes_Draenor.db.profile.Integration.DBM.Loaded == true then
                if HandyNotes_Draenor.db.profile.Integration.DBM.ArrowCreated == false then
                    info.notCheckable = 0
                    info.text = "Create DBM-Arrow"
                    info.func = DBMCreateArrow
                    info.arg1 = ClickedMapFile
                    info.arg2 = ClickedCoord
                    UIDropDownMenu_AddButton(info, level)
                else
                    info.notCheckable = 0
                    info.text = "Hide DBM-Arrow"
                    info.func = DBMHideArrow
                    UIDropDownMenu_AddButton(info, level)
                end
            end

            info.text = "Restore removed POI's"
            info.func = ResetPOIDatabase
            info.arg1 = nil
            info.arg2 = nil
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)

            info.text = CLOSE
            info.func = function() CloseDropDownMenus() end
            info.arg1 = nil
            info.arg2 = nil
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)
            
        end
    end
end

function ResetPOIDatabase()
    wipe(HandyNotes_Draenor.db.char)
    HandyNotes_Draenor:Refresh()
end

function DisablePOI(button, mapFile, coord)
    local POI = nodes[mapFile][coord][2]
    if (POI ~= nil) then
        HandyNotes_Draenor.db.char[POI] = true;
    end
    HandyNotes_Draenor:Refresh()
end

function TomTomCreateArrow(button, mapFile, coord)
    if HandyNotes_Draenor.db.profile.Integration.TomTom.Loaded == true then
        local mapId = HandyNotes:GetMapFiletoMapID(mapFile)
        local x, y = HandyNotes:getXY(coord)

        local Zone = nodes[mapFile][coord][1]
        local ID = nodes[mapFile][coord][2]
        local Name = nodes[mapFile][coord][3]
        local Loot = nodes[mapFile][coord][4]
        local Note = nodes[mapFile][coord][5]
        local Icon = nodes[mapFile][coord][6]
        local Tag = nodes[mapFile][coord][7]
        local ItemID = nodes[mapFile][coord][8]
        local AchievementID = nodes[mapFile][coord][10]
        local AchievementCriteriaIndex = nodes[mapFile][coord][9]

        local ArrowDescription = ""

        if Name ~= nil then
            if Zone ~= nil then
                ArrowDescription = ArrowDescription.."\n"..Name;
                ArrowDescription = ArrowDescription.."\n"..Zone;

                if ItemID ~= nil and ItemID ~= "nil" then
                    ArrowDescription = ArrowDescription.."\n\n"
                    ArrowDescription = ArrowDescription..GetRewardLinkByID(ItemID)
                else
                    ArrowDescription = ArrowDescription.."\n\n"
                    ArrowDescription = ArrowDescription..Loot
                end

                if Note ~= nil and Note ~= "nil" then
                    ArrowDescription = ArrowDescription.."\n\n"
                    ArrowDescription = ArrowDescription.."\n"..Note
                end
            end
        end

        TomTom:AddMFWaypoint(mapId, nil, x, y, {
            title = ArrowDescription,
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

function DBMCreateArrow(button, mapFile, coord)
    if HandyNotes_Draenor.db.profile.Integration.DBM.Loaded == true then

        if HandyNotes_Draenor.db.profile.Integration.DBM.ArrowNote == nil then
        
            HandyNotes_Draenor.db.profile.Integration.DBM.ArrowNote = DBMArrow:CreateFontString(nil, "OVERLAY", "GameTooltipText")
            HandyNotes_Draenor.db.profile.Integration.DBM.ArrowNote:SetWidth(400)
            HandyNotes_Draenor.db.profile.Integration.DBM.ArrowNote:SetHeight(100)
            HandyNotes_Draenor.db.profile.Integration.DBM.ArrowNote:SetPoint("CENTER", DBMArrow, "CENTER", 0, -70)
            HandyNotes_Draenor.db.profile.Integration.DBM.ArrowNote:SetTextColor(1, 1, 1, 1)
            HandyNotes_Draenor.db.profile.Integration.DBM.ArrowNote:SetJustifyH("CENTER")
            DBMArrow.Desc = HandyNotes_Draenor.db.profile.Integration.DBM.ArrowNote

        end

        local x, y = HandyNotes:getXY(coord)

        local Zone = nodes[mapFile][coord][1]
        local ID = nodes[mapFile][coord][2]
        local Name = nodes[mapFile][coord][3]
        local Loot = nodes[mapFile][coord][4]
        local Note = nodes[mapFile][coord][5]
        local Icon = nodes[mapFile][coord][6]
        local Tag = nodes[mapFile][coord][7]
        local ItemID = nodes[mapFile][coord][8]
        local AchievementID = nodes[mapFile][coord][10]
        local AchievementCriteriaIndex = nodes[mapFile][coord][9]

        local ArrowDescription = ""

        if Name ~= nil then
            if Zone ~= nil then
                ArrowDescription = ArrowDescription.."\n"..Name;
                ArrowDescription = ArrowDescription.."\n"..Zone;

                if ItemID ~= nil and ItemID ~= "nil" then
                    ArrowDescription = ArrowDescription.."\n\n"
                    ArrowDescription = ArrowDescription..GetRewardLinkByID(ItemID)
                else
                    ArrowDescription = ArrowDescription.."\n\n"
                    ArrowDescription = ArrowDescription..Loot
                end

                if Note ~= nil and Note ~= "nil" then
                    ArrowDescription = ArrowDescription.."\n\n"
                    ArrowDescription = ArrowDescription.."\n"..Note
                end
            end
        end

		if not DBMArrow.Desc:IsShown() then
			DBMArrow.Desc:Show()
		end

		DBMArrow.Desc:SetText(ArrowDescription)
        DBM.Arrow:ShowRunTo(x * 100, y * 100, nil, nil, true)

        HandyNotes_Draenor.db.profile.Integration.DBM.ArrowCreated = true
    end
end

function DBMHideArrow()
    DBM.Arrow:Hide(true)
    HandyNotes_Draenor.db.profile.Integration.DBM.ArrowCreated = false
end

function HandyNotes_Draenor:OnEnter(mapFile, coord)

    local Zone = nodes[mapFile][coord][1]
    local ItemHeader = nodes[mapFile][coord][3]
    local ItemDescription = nodes[mapFile][coord][4]
    local ItemNote = nodes[mapFile][coord][5]
    local ItemID = nodes[mapFile][coord][8]

    local Reward = GetRewardLinkByID(ItemID)

    local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip

    if self:GetCenter() > UIParent:GetCenter() then
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end

    if Reward == nil and ItemID ~= "nil" then

        HandyNotes_Draenor:RegisterEvent("GET_ITEM_INFO_RECEIVED", function()

            Reward = GetRewardLinkByID(ItemID)

            tooltip:SetText(ItemHeader) 

            if ItemNote ~= "nil" and HandyNotes_Draenor.db.profile.Settings.General.ShowNotes == true then
                tooltip:AddLine(" ")
                tooltip:AddLine("Note")
                tooltip:AddLine(ItemNote, 1, 1, 1, 1)
            end

            tooltip:AddLine(" ")
            tooltip:AddLine("Reward")

            if Reward ~= nil then
                tooltip:AddLine(Reward, 1, 1, 1, 1)
            else
                tooltip:AddLine(ItemDescription, 1, 1, 1, 1)
            end

            HandyNotes_Draenor:UnregisterEvent("GET_ITEM_INFO_RECEIVED")

            tooltip:Show()

        end)

    else

        tooltip:SetText(ItemHeader)

        if ItemNote ~= "nil" and HandyNotes_Draenor.db.profile.Settings.General.ShowNotes == true then
            tooltip:AddLine(" ")
            tooltip:AddLine("Note")
            tooltip:AddLine(ItemNote, 1, 1, 1, 1)
        end

        tooltip:AddLine(" ")
        tooltip:AddLine("Reward")

        if Reward ~= nil then
            tooltip:AddLine(Reward, 1, 1, 1, 1)
        else
            tooltip:AddLine(ItemDescription, 1, 1, 1, 1)
        end

        tooltip:Show()

    end
end

function HandyNotes_Draenor:OnClick(button, down, mapFile, coord)
    if button == "RightButton" and down then
        ClickedMapFile = mapFile
        ClickedCoord = coord
        ToggleDropDownMenu(1, nil, HandyNotes_DraenorDropdownMenu, self, 0, 0)
    end
end

function HandyNotes_Draenor:OnLeave()
    if self:GetParent() == WorldMapButton then
        WorldMapTooltip:Hide()
    else
        GameTooltip:Hide()
    end
end

function HandyNotes_Draenor:WorldEnter()

    HandyNotes_Draenor.db.profile.Integration.DBM.Loaded = IsAddOnLoaded("DBM-Core")
    HandyNotes_Draenor.db.profile.Integration.TomTom.Loaded = IsAddOnLoaded("TomTom")
    
    local HandyNotes_DraenorDropdownMenu = CreateFrame("Frame", "HandyNotes_DraenorDropdownMenu")
    HandyNotes_DraenorDropdownMenu.displayMode = "MENU"
    HandyNotes_DraenorDropdownMenu.initialize = generateMenu
    
    self:RegisterWithHandyNotes()

    if HandyNotes.plugins["HandyNotes_Draenor"] == nil then
        HandyNotes:RegisterPluginDB("HandyNotes_Draenor", self, HandyNotes_Draenor.options)
    end

end

function HandyNotes_Draenor:RegisterWithHandyNotes()
    local function iter(t, prestate)

        if t ~= nil then

            local state, value = next(t, prestate)

            while state do

                local Zone = value[1]
                local ID = value[2]
                local Name = value[3]
                local Loot = value[4]
                local Note = value[5]
                local Icon = value[6]
                local Tag = value[7]
                local ItemID = value[8]
                local AchievementID = value[10]
                local AchievementCriteriaIndex = value[9]

                if ID then

                    if Tag == "Rare" then

                        if self.db.profile.Zones[Zone]["Rares"] then

                            if self.db.profile.Settings.Rares.ShowAlreadyKilled == true or not self.db.char[ID] then

                                if IsQuestFlaggedCompleted(ID) == false then

                                    if AchievementCriteriaIndex ~= nil and AchievementCriteriaIndex ~= "nil" then

                                        local _, _, Completed = GetAchievementCriteriaInfoByID(10070, AchievementCriteriaIndex)

                                        if Completed == false then
                                            return state, nil, self.DefaultIcons[Icon], self.db.profile.Settings.Rares.IconScale, self.db.profile.Settings.Rares.IconAlpha
                                        end

                                    else
                                        return state, nil, self.DefaultIcons[Icon], self.db.profile.Settings.Rares.IconScale, self.db.profile.Settings.Rares.IconAlpha
                                    end

                                end

                            end

                        end

                    elseif Tag == "Treasure" then

                        if self.db.profile.Zones[Zone]["Treasures"] then

                            if self.db.profile.Settings.Treasures.ShowAlreadyCollected == true or not self.db.char[ID] then

                                if IsQuestFlaggedCompleted(ID) == false then

                                    if ItemID ~= nil and ItemID ~= "nil" then
                                        return state, nil, GetRewardIconByID(ItemID), self.db.profile.Settings.Treasures.IconScale, self.db.profile.Settings.Treasures.IconAlpha
                                    else
                                        return state, nil, self.DefaultIcons[Icon], self.db.profile.Settings.Treasures.IconScale, self.db.profile.Settings.Treasures.IconAlpha
                                    end

                                end

                            end

                        end

                    elseif Tag == "Treasure-Quest" then

                        if self.db.profile.Zones[Zone]["Treasures"] then

                            if self.db.profile.Settings.Treasures.ShowAlreadyCollected == true or not self.db.char[ID] then

                                if self.db.profile.Settings.Treasures.ShowAlreadyCollected == false then

                                    if IsQuestFlaggedCompleted(AchievementCriteriaIndex) then

                                        if ItemID ~= nil and ItemID ~= "nil" then
                                            return state, nil, GetRewardIconByID(ItemID), self.db.profile.Settings.Treasures.IconScale, self.db.profile.Settings.Treasures.IconAlpha
                                        end

                                    end

                                else
                                    if ItemID ~= nil and ItemID ~= "nil" then
                                        return state, nil, GetRewardIconByID(ItemID), self.db.profile.Settings.Treasures.IconScale, self.db.profile.Settings.Treasures.IconAlpha
                                    end
                                end

                            end

                        end

                    elseif string.match(Tag, "Mount_") then

                        if self.db.profile.Mounts[Tag] then

                            return state, nil, self.DefaultIcons[Icon], self.db.profile.Settings.Rares.IconScale, self.db.profile.Settings.Rares.IconAlpha

                        end

                    end
                    
                end

                state, value = next(t, state)
            end
        end
    end

    function HandyNotes_Draenor:GetNodes(mapFile, isMinimapUpdate, dungeonLevel)
        return iter, nodes[mapFile], nil
    end

    self:RegisterBucketEvent({ "LOOT_CLOSED" }, 2, function()
        self:Refresh();
    end)

    self:Refresh()
end

function HandyNotes_Draenor:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_Draenor")
end