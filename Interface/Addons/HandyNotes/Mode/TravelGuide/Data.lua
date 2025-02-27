----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------
local _, TravelGuide = ...
local L = TravelGuide.locale
----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local _, TravelGuide = ...
local L = TravelGuide.locale
----------------------------------------------------------------------------------------------------
-----------------------------------------------LOCALS-----------------------------------------------
----------------------------------------------------------------------------------------------------

local function GetMapNames(id1, id2, id3)
    local name1 = id1 and C_Map.GetMapInfo(id1).name or ''
    local name2 = id2 and ", " .. C_Map.GetMapInfo(id2).name or ''
    local name3 = id3 and ", " .. C_Map.GetAreaInfo(id3) or ''

    return format("%s%s%s", name1, name2, name3)
end

local GetAreaInfo = C_Map.GetAreaInfo

-------------------------------------------THE WAR WITHIN-------------------------------------------

local KhazAlgar = GetMapNames(2274)
local IsleOfDorn = GetMapNames(2274, 2248)
local RingingDeeps = GetMapNames(2274, 2214)
-- local AzjKahet = GetMapNames(2274, 2255)
local WeaversLair = GetMapNames(2274, nil, 14755)
local PtoDornogal = L["Portal to Dornogal"]

--------------------------------------------DRAGONFLIGHT--------------------------------------------

local PtoValdrakken = L["Portal to Valdrakken"]
local Thaldraszus = GetMapNames(1978, 2025)
local BtoDI = L["Boat to Dragon Isle"]
local ZtoDI = L["Zeppelin to Dragon Isle"]
local WakingShores = GetMapNames(2022)
local PtoBadlands = L["Portal to Badlands"]
local PtoEmeraldDream = L["Portal to Emerald Dream"]
local EmeraldDream = GetMapNames(2200)
local PtoOhnahranPlains = L["Portal to Ohn'ahran Plains"]
local DragonIsle = GetMapNames(1978)
-- local PtoTimeways = L["Portal to The Timeways"]
local PtoBelameth = L["Portal to Bel'ameth"]
local PtoMountHyjal = L["Portal to Mount Hyjal"]
local BtoBelanaar = L["Boat to Belanaar"]
local Amirdrassil = GetMapNames(1978, 2239)
local BtoStormglen = L["Boat to Stormglen"]
local Gilneas = GetMapNames(13, 217)

----------------------------------------------COVENANT----------------------------------------------

local Kyrian    = 1
local Venthyr   = 2
local Nightfae  = 3
local Necrolord = 4

--------------------------------------------SHADOWLANDS---------------------------------------------

local Shadowlands = GetMapNames(1550)
local PtoOribos = L["Portal to Oribos"]
local WstoOribos = L["Waystone to Oribos"]
local RingTransference = L["To Ring of Transference"]
local RingFates = L["To Ring of Fates"]
local IntoTheMaw = L["Into the Maw"]
local PtoTorghast = L["Portal to Torghast"]
local Korthia = GetMapNames(1543, 1961)
local KeepersRespite = L["To Keeper's Respite"]
local PtoZerethMortis = L["Portal to Zereth Mortis"]

local AGtoHerosrest = L["Anima Gateway to Hero's rest"]

-------------------------------------------------BfA------------------------------------------------

local Zandalar = GetMapNames(875)
local Zuldazar = GetMapNames(875, 862)
local PtoZuldazar = L["Portal to Zuldazar"]
local BtoZuldazar = L["Boat to Zuldazar"]
local returntoZuldazar = L["Return to Zuldazar"]
local BtoVolDun = L["Boat to Vol'dun"]
local BtoNazmir = L["Boat to Nazmir"]
local PtoNazjatar = L["Portal to Nazjatar"]
local StoMechagon = L["Submarine to Mechagon"]
local PtoSilithus = L["Portal to Silithus"]

local KulTiras = GetMapNames(876)
local TiragardeSound = GetMapNames(876, 895)
local PtoBoralus = L["Portal to Boralus"]
local BtoBoralus = L["Boat to Boralus"]
local returntoBoralus = L["Return to Boralus"]
local BtoDrustvar = L["Boat to Drustvar"]
local BtoStormsongValley = L["Boat to Stormsong Valley"]
local BtoTiragardeSound = L["Boat to Tiragarde Sound"]

local PtoArathiHighlands = L["Portal to Arathi Highlands"]
local PtoPortofZandalar = L["Portal to Port of Zandalar"]
local PtoDarkshore = L["Portal to Darkshore"]
local PtoPortofBoralus = L["Portal to Port of Boralus"]
local BtoEchoIsles = L["Boat to Echo Isles"]
local EchoIsles = GetMapNames(12, 1)

-----------------------------------------------LEGION-----------------------------------------------

local BrokenIsles = GetMapNames(619)
local Stormheim = GetMapNames(619, 634)
local PtoStormheim = L["Portal to Stormheim"]
local PtoHelheim = L["Portal to Helheim"]
local PtoDala = L["Portal to Dalaran"]
local PtoAzsuna = L["Portal to Azsuna"]
local PtoValsharah = L["Portal to Val'sharah"]
local PtoEmeraldDreamway = L["Portal to Emerald Dreamway"]
local PtoSuramar = L["Portal to Suramar"]
local PtoHighmountain = L["Portal to Highmountain"]
local GEtoTrueshotLodge = L["Great Eagle to Trueshot Lodge"]
local JtoSkyhold = L["Jump to Skyhold"]
local PtoDuskwood = L["Portal to Duskwood"]
local PtoFeralas = L["Portal to Feralas"]
local PtoGrizzlyHills = L["Portal to Grizzly Hills"]
local PtoHinterlands = L["Portal to Hinterlands"]
local PtoMoonglade = L["Portal to Moonglade"]
local PtoDreamgrove = L["Portal to Dreamgrove"]
local dalaran = GetMapNames(627)
local azsuna = GetMapNames(630)
local valsharah = GetMapNames(641)
local valsharahBrokenIsles = GetMapNames(619, 641)
local suramar = GetMapNames(680)
local Suramar = GetMapNames(619, 680)
local highmountain = GetMapNames(650)
local Highmountain = GetMapNames(619, 650)
local stormheim = GetMapNames(634)
local brokenshore = GetMapNames(646)
local Meredil = GetMapNames(680, nil, 7840)
local PtoKarazhan = L["Portal to Karazhan"]
local PtoWyrmrestTemple = L["Portal to Wyrmrest Temple"]

-------------------------------------------------WoD------------------------------------------------

local PtoStormshield = L["Portal to Stormshield"]
local PtoLionswatch = L["Portal to Lion's watch"]
local PtoWarspear = L["Portal to Warspear"]
local PtoVolmar = L["Portal to Vol'mar"]
local Ashran = GetMapNames(572, 588)
local TanaanJungle = GetMapNames(572, 534)
local OgreWaygate = L["Ogre Waygate"]
local ReflectivePortal = L["Reflective Portal"]

-------------------------------------------------MoP------------------------------------------------

local Pandaria = GetMapNames(424)
local TownlongSteppes = GetMapNames(424, 388)
local PtoIofT = L["Portal to Isle of Thunder"]
local PtoSPG = L["Portal to Shado-Pan Garrison"]
local PtoJadeForest = L["Portal to Jade Forest"]
local KunLaiSummit = GetMapNames(424, 379)
local PtoPeakofSerenity = L["Portal to Peak of Serenity"]

-------------------------------------------------CATA-----------------------------------------------

local Maelstrom = GetMapNames(948)
local Deepholm = GetMapNames(948, 207)
local MoltenFront = GetMapNames(12, 338)
local PtoTolBarad = L["Portal to Tol Barad"]
local PtoUldum = L["Portal to Uldum"]
local PtoDeepholm = L["Portal to Deepholm"]
local PtoVashjir = L["Portal to Vashj'ir"]
local PtoHyjal = L["Portal to Hyjal"]
local PtoTwilightHighlands = L["Portal to Twilight Highlands"]
local PtoTempleofEarth = L["Portal to Temple of Earth"]
local PtoTherazanesThrone = L["Portal to Therazane's Throne"]

------------------------------------------------WotLK-----------------------------------------------

local CrystalsongForest = GetMapNames(113, 127)
local PtotPurpleParlor = L["Portal to the Purple Parlor"]
local BoreanTundra = GetMapNames(113, 114)
local ZtoBoreanTundra = L["Zeppelin to Borean Tundra"]
local BtoBoreanTundra = L["Boat to Borean Tundra"]
local WarsongHold = GetMapNames(113, nil, 4129)
local ValianceKeep = GetMapNames(113, nil, 4032)
local BtoUnuPe = L["Boat to Unu'pe"]
local Dragonblight = GetMapNames(113, 115)
local BtoMoaKiHarbor = L["Boat to Moa'ki Harbor"]
local HowlingFjord = GetMapNames(113, 117)
local PtoHowlingFjord = L["Portal to Howling Fjord"]
local VengeanceLanding = GetMapNames(113, nil, 4000)
local BtoHowlingFjord = L["Boat to Howling Fjord"]
local Valgarde = GetMapNames(113, nil, 3981)
local BtoKamagua = L["Boat to Kamagua"]
local Northrend = GetMapNames(113)
local WtoSholazarBasin = L["Waygate to Sholazar Basin"]

-------------------------------------------------BC-------------------------------------------------

local AzuremystIsle = GetMapNames(12, 97)
local PtoExodar = L["Portal to Exodar"]
local inExodar = L["in Exodar"]
local Outland = GetMapNames(101)
local PtoHellfirePeninsula = L["Portal to Hellfire Peninsula"]
local PtoIofQD = L["Portal to Isle of Quel'Danas"]
local PtoShattrath = L["Portal to Shattrath"]
local TerokkarForest = GetMapNames(101, 108)

-----------------------------------------------VANILLA----------------------------------------------

local Durotar = GetMapNames(12, 1)
local PtoOG = L["Portal to Orgrimmar"]
local ZtoOG = L["Zeppelin to Orgrimmar"]
local Mulgore = GetMapNames(12, 7)
local PtoTB = L["Portal to Thunder Bluff"]
local ZtoTB = L["Zeppelin to Thunder Bluff"]
local Tirisfal = GetMapNames(13, 18)
local PtoUC = L["Portal to Undercity"]
local inUCMq = L["in Undercity Magic Quarter"]
local Orboftranslocation = L["Orb of translocation"]
local EversongWoods = GetMapNames(13, 94)
local PtoSM = L["Portal to Silvermoon"]
local NorthernBarrens = GetMapNames(12, 10)
local BtoRatchet = L["Boat to Ratchet"]
local ElwynnForest = GetMapNames(13, 37)
local PtoSW = L["Portal to Stormwind"]
local BtoSW = L["Boat to Stormwind"]
local DrTtoSW = L["Deeprun Tram to Stormwind"]
local Teldrassil = GetMapNames(12, 57)
local PtoDarnassus = L["Portal to Darnassus"]
local DunMorogh = GetMapNames(13, 27)
local PtoIF = L["Portal to Ironforge"]
local DrTtoIF = L["Deeprun Tram to Ironforge"]
local BtoMenethilHarbor = L["Boat to Menethil Harbor"]
local EasternKingdoms = GetMapNames(13)
local Wetlands = GetMapNames(13, 56)
local ZtoStranglethornVale = L["Zeppelin to Stranglethorn Vale"]
local PtoStranglethornVale = L["Portal to Stranglethorn Vale"]
-- local StranglethornVale = GetMapNames(13, 224)
local StranglethornCape = GetMapNames(13, 210)
local BtoBootyBay = L["Boat to Booty Bay"]
local GromgolBaseCamp = GetMapNames(13, nil, 117)
local Kalimdor = GetMapNames(12)
local DustwallowMarsh = GetMapNames(12, 70)
local BtoTheramore = L["Boat to Theramore Isle"]
local PtoCavernsofTime = L["Portal to Caverns of Time"]
local Tanaris = GetMapNames(12, 71)
-- local ArathiHighlands = GetMapNames(13, 14)
-- local Darkshore = GetMapNames(12, 62)
local PtoDalaCrater = L["Portal to Dalaran Crater"]
local HillsbradFoothills = GetMapNames(13, 25)
local PtoSepulcher = L["Portal to the Sepulcher"]
local SilverpineForest = GetMapNames(13, 21)
local EasternPlaguelands = GetMapNames(13, 23)
local Westfall = GetMapNames(13, 52)
local BurningSteppes = GetMapNames(13, 36)
local WtoUngoroCrater = L["Waygate to Un'Goro Crater"]
local TheMasonary = L["The Masonary"]
local inBRM = L["inside the Blackrock Mountain"]
local Feralas = GetMapNames(12, 69)
local DeadwindPass = GetMapNames(13, 42)

----------------------------------------------------------------------------------------------------
----------------------------------------------DATABASE----------------------------------------------
----------------------------------------------------------------------------------------------------

local DB = {}
TravelGuide.DB = DB

DB.nodes = {
--[[ structure:
    [UiMapID] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            icon          = ["STRING"],         -- specific icon for nodes
            label         = ["STRING"],         -- label for singel destination nodes
            multilabel    = {TABLE},            -- label for multi destination nodes
            note          = ["STRING"],         -- additional destination notes
            multinote     = {TABLE},            -- additional notes for multi destination nodes
            requirements  = {                   -- additional notes for requirements
                TABLE FOR:
                quest         = [ID],           -- additional notes for a required quest
                accquest      = boolean         -- if the quest unlock is account wide
                item          = {ID, QUANTITY}  -- additional notes for a required item with quantity
                hideQuestName = [BOOLEAN],      -- hides quest name for a required quest
                multiquest    = {TABLE},        -- additional notes for multi required quests
                spell         = [ID],           -- additional notes for a required spell
                level         = [PLAYERLEVEL],  -- additional notes for a required player level
                multilevel    = {TABLE},        -- additional notes for a multi required player levels
                reputation    = {ID, standing}, -- additional notes for a required reputation
                sanctumtalent = [ID],           -- additional notes for a required sanctum upgrade
                warfront      = [ID],           -- additional notes for warfront nodes
                timetravel    = {               -- additional requirement for nodes
                TABLE FOR:
                    quest = [ID],               -- hidden quest id to track the timezone from Zidormi
                    spell = [ID],               -- time travel spell id
                    turn = [BOOLEAN]            -- to turn the timezone in Sillithus
                },
            },
            faction       = ["FACTION"],        -- shows only for selected faction
            class         = [CLASS NAME],       -- shows only for selected class
            covenant      = [COVENAT NAME],     -- shows only for selected covenant
        },
    },
]]
-----------------------------------------------------------------------------------------THE WAR WITHIN----------------------------------------------------------------------------------------

    [2274] = { -- Khaz Algar
        [72691965] = { icon="portal", label=L["Portal to The Timeways"], requirements={level=80} },
        [70961840] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [71291790] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        -- [54925688] = { icon="portal", label=L["Elevator to Isle of Dorn"], note=KhazAlgar, requirements={quest=82195, accquest=true} },
        -- [80161483] = { icon="portal", label=L["Elevator to Ringing Deeps"], note=KhazAlgar, requirements={quest=82195, accquest=true} },
        [46877124] = { icon="portal", label=PtoDornogal, note=IsleOfDorn, requirements={quest=78248, accquest=true} },
        [73752119] = { icon="portal", label=L["Portal to Azj-Kahet"], note=WeaversLair, requirements={quest=78248, accquest=true} },
        [74851599] = { icon="zeppelin", label=L["Zeppelin to Siren Isle"], requirements={quest=84720, accquest=true} },
        [52435200] = { icon="molemachine", label=L["Mole Machine to Siren Isle"], requirements={quest=84720, accquest=true} },
        [62946654] = { icon="molemachine", label=L["Rocket Drill to Undermine"], requirements={quest=83151, accquest=true} },
        [72522094] = { icon="portal", label=L["Teleporter to Undermine"], note=RingingDeeps, requirements={quest=86535, accquest=true} }
        },
    [2339] = { -- Dornogal
        [53963872] = { icon="portal", label=L["Portal to The Timeways"], requirements={level=80} },
        [38162723] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [41182266] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [63595278] = { icon="portal", label=L["Portal to Azj-Kahet"], note=WeaversLair, requirements={quest=78248, accquest=true} },
        [73570529] = { icon="zeppelin", label=L["Zeppelin to Siren Isle"], requirements={quest=84720, accquest=true} },
        [52465045] = { icon="portal", label=L["Teleporter to Undermine"], note=RingingDeeps, requirements={quest=86535, accquest=true} }
        },
    [2248] = { -- Isle of Dorn
        [50654183] = { icon="portal", label=L["Portal to The Timeways"], requirements={level=80} },
        [46773901] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [47523789] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        -- [67333101] = { icon="portal", label=L["Elevator to Ringing Deeps"], note=KhazAlgar, requirements={quest=82195, accquest=true} },
        [53024529] = { icon="portal", label=L["Portal to Azj-Kahet"], note=WeaversLair, requirements={quest=78248, accquest=true} },
        [55473362] = { icon="zeppelin", label=L["Zeppelin to Siren Isle"], requirements={quest=84720, accquest=true} },
        [50284471] = { icon="portal", label=L["Teleporter to Undermine"], note=RingingDeeps, requirements={quest=86535, accquest=true} }
        },
    [2214] = { -- Ringing Deeps
        -- [53374459] = { icon="portal", label=L["Elevator to Isle of Dorn"], note=KhazAlgar, requirements={quest=82195, accquest=true} }
        [25418709] = { icon="portal", label=PtoDornogal, note=IsleOfDorn, requirements={quest=78248, accquest=true} },
        [41873015] = { icon="molemachine", label=L["Mole Machine to Siren Isle"], requirements={quest=84720, accquest=true} },
        [72957319] = { icon="molemachine", label=L["Rocket Drill to Undermine"], requirements={quest=83151, accquest=true} }
        },
    [2215] = { -- Hallowfall
        [70869574] = { icon="portal", label=PtoDornogal, note=IsleOfDorn, requirements={quest=78248, accquest=true} },
        [85164624] = { icon="molemachine", label=L["Mole Machine to Siren Isle"], requirements={quest=84720, accquest=true} }
        },
    [2255] = { -- Azj-Kahet
        [57494159] = { icon="portal", label=PtoDornogal, note=IsleOfDorn, requirements={quest=78248, accquest=true} }
        },
    [2266] = { -- Millenia's Threshold
        [43584988] = { icon="portal", label=PtoDornogal, note=IsleOfDorn },
        [64534374] = { icon="portal", label=L["Portal to Ardenweald"], note=Shadowlands },
        [74424709] = { icon="portal", label=L["Portal to Bastion"], note=Shadowlands },
        [70457272] = { icon="portal", label=L["Portal to Tiragarde Sound"], note=KulTiras },
        [60576931] = { icon="portal", label=L["Portal to Twilight Highlands"], note=EasternKingdoms }
        },
    [2369] = { -- Siren Isle
        [70695347] = { icon="zeppelin", label=L["Zeppelin to Dornogal"], note=IsleOfDorn, requirements={quest=84720, accquest=true} },
        [67893859] = { icon="molemachine", label=L["Mole Machine to Gundargaz"], note=RingingDeeps, requirements={quest=84720, accquest=true} }
        },
    [2346] = { -- Undermine
        [17295074] = { icon="molemachine", label=L["Rocket Drill to Ringing Deeps"], note=KhazAlgar, requirements={quest=83151, accquest=true} },
        [27825401] = { icon="portal", label=L["Teleporter to Dornogal"], note=IsleOfDorn, requirements={quest=86535, accquest=true} }
        },

------------------------------------------------------------------------------------------DRAGONFLIGHT-----------------------------------------------------------------------------------------

    [2239] = { -- Amirdrassil
        [89633797] = { icon="portal", label=PtoEmeraldDream, note=EmeraldDream, requirements={quest=76318, accquest=true, level=70} },
        [55466364] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [51391836] = { icon="portal", label=L["Portal to Feathermoon Stronghold"], note=Feralas, faction="Alliance" },
        [55316473] = { icon="portal", multilabel={PtoDarkshore, PtoMountHyjal, PtoValsharah}, multinote={Kalimdor, Kalimdor, BrokenIsles}, faction="Alliance" },
        [58588498] = { icon="orderhall", label=PtoEmeraldDreamway, note=valsharahBrokenIsles, class="DRUID" },
        [49020100] = { icon="boat", label=BtoStormglen, note=Gilneas }
        },
    [2200] = { -- Emerald Dream
        [73085242] = { icon="portal", label=PtoOhnahranPlains, note=DragonIsle, requirements={quest=76318, accquest=true, level=70} }
        },
    [1978] = { -- Dragon Isles
        -- [56364797] = { icon="portal", multilabel={PtoOG, L["Teleport to Seat of the Aspects"]}, multinote={Durotar}, faction="Horde" },
        -- [56574817] = { icon="portal", multilabel={PtoSW, L["Teleport to Seat of the Aspects"]}, multinote={ElwynnForest}, faction="Alliance" },
        [56364797] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" }, -- quest=?, level=?
        [56574817] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" }, -- quest=?, level=?
        [59682678] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [59682677] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" },
        [59832764] = { icon="aboat", label=BtoSW, note=ElwynnForest, faction="Horde" },
        [59832765] = { icon="boat", label=BtoSW, note=ElwynnForest, faction="Alliance" },
        -- [56694766] = { icon="portal", label=L["Teleport to Seat of the Aspects"], requirements={level=64} }
        [31055686] = { icon="portal", label=PtoEmeraldDream, note=EmeraldDream, requirements={quest=76318, accquest=true, level=70} },
        [56724911] = { icon="portal", label=L["Portal to Central Encampment"], note=EmeraldDream, requirements={quest=76326, accquest=true, level=70} },
        [24795365] = { icon="portal", label=L["Portal to Feathermoon Stronghold"], note=Feralas, faction="Alliance" },
        [25466105] = { icon="portal", multilabel={PtoSW, PtoDarkshore, PtoMountHyjal, PtoValsharah}, multinote={ElwynnForest, Kalimdor, Kalimdor, BrokenIsles}, faction="Alliance" },
        [25976454] = { icon="orderhall", label=PtoEmeraldDreamway, note=valsharahBrokenIsles, class="DRUID" },
        [24415081] = { icon="boat", label=BtoStormglen, note=Gilneas },
        [44223523] = { icon="molemachine", label=GetAreaInfo(14012), requirements={quest=80107, hideQuestName=true}, race="DarkIronDwarf" }, -- The Slagmire
        [65037178] = { icon="molemachine", label=GetAreaInfo(14017), requirements={quest=80108, hideQuestName=true}, race="DarkIronDwarf" }, -- Vakthros Summit
        [87987773] = { icon="molemachine", label=GetAreaInfo(14655), requirements={quest=80109, hideQuestName=true}, race="DarkIronDwarf" } -- Obsidian Rest
        },
    [2112] = { -- Valdrakken
        [56603821] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" }, -- quest=?, level=?
        [59834172] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" }, -- quest=?, level=?
        -- [53565538] = { icon="portal", label=PtoTimeways, requirements={level=70} },
        [61963208] = { icon="teleportPlatform", label=L["Teleport to Seat of the Aspects"], requirements={level=64} },
        [26094099] = { icon="portal", label=PtoBadlands, note=EasternKingdoms },
        [62675730] = { icon="portal", label=L["Portal to Central Encampment"], note=EmeraldDream, requirements={quest=76326, accquest=true, level=70} }
        },
    [2022] = { -- The Waking Shores
        [81692794] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [81692795] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" },
        [82183069] = { icon="aboat", label=BtoSW, note=ElwynnForest, faction="Horde" },
        [82183068] = { icon="boat", label=BtoSW, note=ElwynnForest, faction="Alliance" },
        [32365490] = { icon="molemachine", label=GetAreaInfo(14012), requirements={quest=80107, hideQuestName=true}, race="DarkIronDwarf" } -- The Slagmire
        },
    [2023] = { -- Ohn'ahran Plains
        [18405234] = { icon="portal", label=PtoEmeraldDream, note=EmeraldDream, requirements={quest=76318, accquest=true, level=70} }
        },
    [2024] = { -- The Azure Span
        [80093896] = { icon="molemachine", label=GetAreaInfo(14017), requirements={quest=80108, hideQuestName=true}, race="DarkIronDwarf" } -- Vakthros Summit
        },
    [2025] = { -- Thaldraszus
        [40895817] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [41355868] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        -- [41665728] = { icon="portal", label=L["Teleport to Seat of the Aspects"], requirements={level=64} },
        [49210474] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [49210475] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" },
        [49590691] = { icon="aboat", label=BtoSW, note=ElwynnForest, faction="Horde" },
        [49590692] = { icon="boat", label=BtoSW, note=ElwynnForest, faction="Alliance" },
        [41766093] = { icon="portal", label=L["Portal to Central Encampment"], note=EmeraldDream, requirements={quest=76326, accquest=true, level=70} }
        },
    [2133] = { -- Zaralek Cavern
        [52732767] = { icon="molemachine", label=GetAreaInfo(14655), requirements={quest=80109, hideQuestName=true}, race="DarkIronDwarf" } -- Obsidian Rest
        },

------------------------------------------------------------------------------------------SHADOWLANDS------------------------------------------------------------------------------------------

    [1550] = { -- Shadowlands
        [45665085] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde", requirements={quest=60151, accquest=true} },
        [45665054] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance", requirements={quest=60151, accquest=true} },
        [23411094] = { icon="portal", label=WstoOribos },
        [62772775] = { icon="portal", label=PtoOribos, covenant=Necrolord, requirements={sanctumtalent=1052} },
        [76015007] = { icon="portal", label=PtoOribos, covenant=Kyrian, requirements={sanctumtalent=1058} },
        [47928153] = { icon="portal", label=PtoOribos, covenant=Nightfae, requirements={sanctumtalent=1055} },
        [20535087] = { icon="portal", label=PtoOribos, covenant=Venthyr, requirements={sanctumtalent=1049} },
        [63392500] = { icon="molemachine", label=GetAreaInfo(13406), requirements={quest=80103, hideQuestName=true}, race="DarkIronDwarf" }, -- Valley of a Thousand Legs
        [17695049] = { icon="molemachine", label=GetAreaInfo(11438), requirements={quest=80104, hideQuestName=true}, race="DarkIronDwarf" }, -- Scorched Crypt
        [72204830] = { icon="molemachine", label=GetAreaInfo(11412), requirements={quest=80105, hideQuestName=true}, race="DarkIronDwarf" }, -- The Eternal Forge
        [53808132] = { icon="molemachine", label=GetAreaInfo(13455), requirements={quest=80106, hideQuestName=true}, race="DarkIronDwarf" } -- Soryn's Meadow
        },
    [1670] = { -- Oribos - Ring of Fates
        [20835477] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde", requirements={quest=60151, accquest=true} },
        [20894567] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance", requirements={quest=60151, accquest=true} },
        [52094278] = { icon="teleportPlatform", label=RingTransference },
        [57145040] = { icon="teleportPlatform", label=RingTransference },
        [52095784] = { icon="teleportPlatform", label=RingTransference },
        [47055029] = { icon="teleportPlatform", label=RingTransference }
        },
    [1671] = { -- Oribos - Ring of Transference
        [49525107] = { icon="portal", label=IntoTheMaw },
        [49504243] = { icon="teleportPlatform", label=RingFates },
        [55735162] = { icon="teleportPlatform", label=RingFates },
        [49506073] = { icon="teleportPlatform", label=RingFates },
        [43375150] = { icon="teleportPlatform", label=RingFates },
        [30702319] = { icon="portal", label=KeepersRespite, note=Korthia, requirements={quest=63665} },
        [49562609] = { icon="portal", label=PtoZerethMortis, requirements={quest=64957} }
        },
    [1536] = { -- Maldraxxus
        [51147034] = { icon="portal", label=PtoOribos, covenant=Necrolord, requirements={sanctumtalent=1052} },
        [53495979] = { icon="molemachine", label=GetAreaInfo(13406), requirements={quest=80103, hideQuestName=true}, race="DarkIronDwarf" } -- Valley of a Thousand Legs
        },
    [1698] = { -- Seat of the Primus
        [56373149] = { icon="portal", label=PtoOribos, covenant=Necrolord, requirements={sanctumtalent=1052} }
        },
    [1533] = { -- Bastion
        [55985276] = { icon="animaGateway", label=AGtoHerosrest }, --1 --Blizzard marked
        [46964891] = { icon="animaGateway", label=AGtoHerosrest }, --2 --Blizzard marked
        [52983802] = { icon="animaGateway", label=AGtoHerosrest }, --3 --Blizzard marked
        [65581959] = { icon="portal", label=PtoOribos, covenant=Kyrian, requirements={sanctumtalent=1058} },
        [51751314] = { icon="molemachine", label=GetAreaInfo(11412), requirements={quest=80105, hideQuestName=true}, race="DarkIronDwarf" } -- The Eternal Forge
        },
    [1707] = { -- Elysian Hold
        [48816478] = { icon="portal", label=PtoOribos, covenant=Kyrian, requirements={sanctumtalent=1058} }
        },
    [1565] = { -- Ardenweald
        [46605126] = { icon="portal", label=PtoOribos, covenant=Nightfae, requirements={sanctumtalent=1055} },
        [66475055] = { icon="molemachine", label=GetAreaInfo(13455), requirements={quest=80106, hideQuestName=true}, race="DarkIronDwarf" } -- Soryn's Meadow
        },
    [1702] = { -- Hearth of the Forest - The Roots
        [59972842] = { icon="portal", label=PtoOribos, covenant=Nightfae, requirements={sanctumtalent=1055} }
        },
    [1525] = { -- Revendreth
        [32134043] = { icon="portal", label=PtoOribos, covenant=Venthyr, requirements={sanctumtalent=1049} },
        [19923881] = { icon="molemachine", label=GetAreaInfo(11438), requirements={quest=80104, hideQuestName=true}, race="DarkIronDwarf" } -- Scorched Crypt
        },
    [1699] = { -- Sinfall Reaches
        [62052630] = { icon="portal", label=PtoOribos, covenant=Venthyr, requirements={sanctumtalent=1049} }
        },
    [1543] = { -- The Maw
        [42374215] = { icon="portal", label=WstoOribos },
        [48183943] = { icon="portal", label=PtoTorghast, requirements={level=60} },
        [70268933] = { icon="portal", label=WstoOribos, requirements={quest=63665} }
        },
    [1961] = { -- Korthia
        [64472406] = { icon="portal", label=WstoOribos, requirements={quest=63665} }
        },
    [1970] = { -- Zereth Mortis
        [32956974] = { icon="portal", label=WstoOribos, requirements={quest=64957} }
        },

----------------------------------------------------------------------------------------------BfA----------------------------------------------------------------------------------------------

    [875] = { -- Zandalar
        [58206200] = { icon="portal", multilabel={PtoSM, PtoOG, PtoTB, PtoSilithus, PtoNazjatar}, multinote={EversongWoods, Durotar, Mulgore, Kalimdor}, requirements={multiquest={[2]=46931, [4]=46931, [5]=55053}, multiaccquest={[2]=true}, multilevel={10, 10, 10, 50, 50}}, faction="Horde" },
        [56307065] = { icon="boat", label=StoMechagon, note=KulTiras, requirements={quest=55651}, faction="Horde" },
        [33201921] = { icon="boat", label=returntoBoralus, note=TiragardeSound, requirements={quest=51229}, faction="Alliance" }, -- Vol'dun Barnard "The Smasher" Baysworth
        [62492642] = { icon="boat", label=returntoBoralus, note=TiragardeSound, requirements={quest=51088}, faction="Alliance" }, -- Nazmir Desha Stormwallow
        [47137856] = { icon="boat", label=returntoBoralus, note=TiragardeSound, requirements={quest=51359}, faction="Alliance" }, -- Zuldazar Daria Smithson
        [58287358] = { icon="boat", multilabel={BtoDrustvar, BtoStormsongValley, BtoTiragardeSound}, multinote={KulTiras, KulTiras, KulTiras}, requirements={multiquest={51340, 51532, 51421}}, faction="Horde" },
        [58367208] = { icon="portal_mixed", multilabel={PtoArathiHighlands, PtoDarkshore}, multinote={EasternKingdoms, Kalimdor}, requirements={level=50}, faction="Horde" },
        [59285897] = { icon="petBattlePortal", multilabel={244506, 244502, 286079, 301941, 314215}, multinote={NorthernBarrens, Westfall, DunMorogh, EasternPlaguelands, BurningSteppes}, requirements={multiquest={45423, 46291, 54185, 56491, 58457}}, faction="Horde" },
        [58007502] = { icon="boat", label=BtoEchoIsles, note=EchoIsles, faction="Horde" },
        [58007501] = { icon="boat", label=BtoEchoIsles, note=EchoIsles, faction="Alliance" },
        [51852837] = { icon="molemachine", label=GetAreaInfo(8966), requirements={quest=80099, hideQuestName=true}, race="DarkIronDwarf" }, -- Zalamar
        [45777939] = { icon="molemachine", label=GetAreaInfo(8965), requirements={quest=80100, hideQuestName=true}, race="DarkIronDwarf" } -- Xibala
        },
    [862] = { -- Zuldazar
        [58304450] = { icon="portal", multilabel={PtoSM, PtoOG, PtoTB, PtoSilithus, PtoNazjatar}, multinote={EversongWoods, Durotar, Mulgore, Kalimdor}, requirements={multiquest={[2]=46931, [4]=46931, [5]=55053}, multiaccquest={[2]=true}, multilevel={10, 10, 10, 50, 50}}, faction="Horde" },
        [55255824] = { icon="boat", label=StoMechagon, note=KulTiras, requirements={quest=55651}, faction="Horde" },
        [58456298] = { icon="boat", multilabel={BtoDrustvar, BtoStormsongValley, BtoTiragardeSound}, multinote={KulTiras, KulTiras, KulTiras}, requirements={multiquest={51340, 51532, 51421}}, faction="Horde" },
        [58596055] = { icon="portal_mixed", multilabel={PtoArathiHighlands, PtoDarkshore}, multinote={EasternKingdoms, Kalimdor}, requirements={level=50}, faction="Horde" },
        [60073938] = { icon="petBattlePortal", multilabel={244506, 244502, 286079, 301941, 314215}, multinote={NorthernBarrens, Westfall, DunMorogh, EasternPlaguelands, BurningSteppes}, requirements={multiquest={45423, 46291, 54185, 56491, 58457}}, faction="Horde" },
        [40457102] = { icon="boat", label=returntoBoralus, note=TiragardeSound, requirements={quest=51359}, faction="Alliance" },
        [58006531] = { icon="boat", label=BtoEchoIsles, note=EchoIsles, faction="Horde" },
        [58006532] = { icon="boat", label=BtoEchoIsles, note=EchoIsles, faction="Alliance" },
        [38247238] = { icon="molemachine", label=GetAreaInfo(8965), requirements={quest=80100, hideQuestName=true}, race="DarkIronDwarf" } -- Xibala
        },
    [863] = { -- Nazmir
        [62054007] = { icon="boat", label=returntoBoralus, note=TiragardeSound, requirements={quest=51088}, faction="Alliance" },
        [34344515] = { icon="molemachine", label=GetAreaInfo(8966), requirements={quest=80099, hideQuestName=true}, race="DarkIronDwarf" } -- Zalamar
        },
    [864] = { -- Vol'dun
        [36683427] = { icon="boat", label=returntoBoralus, note=TiragardeSound, requirements={quest=51229}, faction="Alliance" }
        },
    [1165] = { -- Dazar'alor
        [51004600] = { icon="portal", multilabel={PtoSM, PtoOG, PtoTB, PtoSilithus, PtoNazjatar}, multinote={EversongWoods, Durotar, Mulgore, Kalimdor}, requirements={multiquest={[2]=46931, [4]=46931, [5]=55053}, multiaccquest={[2]=true}, multilevel={10, 10, 10, 50, 50}}, faction="Horde" },
        [41808760] = { icon="boat", label=StoMechagon, note=KulTiras, requirements={quest=55651}, faction="Horde" },
        [51859453] = { icon="portal_mixed", multilabel={PtoArathiHighlands, PtoDarkshore}, multinote={EasternKingdoms, Kalimdor}, requirements={level=50}, faction="Horde" },
        [56323090] = { icon="petBattlePortal", multilabel={244506, 244502, 286079, 301941, 314215}, multinote={NorthernBarrens, Westfall, DunMorogh, EasternPlaguelands, BurningSteppes}, requirements={multiquest={45423, 46291, 54185, 56491, 58457}}, faction="Horde" }
        },
    [1163] = { -- Dazar'alor - The Great Seal
        [73706210] = { icon="portal", label=PtoSM, note=EversongWoods, requirements={level=10}, faction="Horde" },
        [73706980] = { icon="portal", label=PtoOG, note=Durotar, requirements={quest=46931, accquest=true, level=10}, faction="Horde" },
        [73707730] = { icon="portal", label=PtoTB, note=Mulgore, requirements={level=10}, faction="Horde" },
        [73708530] = { icon="portal", label=PtoSilithus, note=Kalimdor, requirements={quest=46931, level=50}, faction="Horde" },
        [63008530] = { icon="portal", label=PtoNazjatar, requirements={quest=55053, level=50}, faction="Horde" }
        },
    [1355] = { -- Nazjatar
        [47286278] = { icon="portal", label=PtoZuldazar, note=Zandalar, requirements={quest=55053, level=50}, faction="Horde" },
        [40005260] = { icon="portal", label=PtoBoralus, note=KulTiras, requirements={quest=54972, level=50}, faction="Alliance" }
        },
    [876] = { -- Kul Tiras
        [61404950] = { icon="portal", multilabel={PtoSW, PtoIF, PtoExodar, PtoSilithus, PtoNazjatar}, multinote={ElwynnForest, DunMorogh, AzuremystIsle, Kalimdor}, requirements={multiquest={47186, 47186, 47186, 47186, 54972}, multiaccquest={true, true, true}, multilevel={10, 10, 10, 50, 50}}, faction="Alliance" },
        [69046516] = { icon="boat", label=returntoZuldazar, note=Zandalar, requirements={quest=51438}, faction="Horde" }, -- Tiragarde Sound speak: Erul Dawnbrook
        [25936716] = { icon="boat", label=returntoZuldazar, note=Zandalar, requirements={quest=51340}, faction="Horde" }, -- Drustvar
        [54371416] = { icon="boat", label=returntoZuldazar, note=Zandalar, requirements={quest=51696}, faction="Horde" }, -- Stormsong Valley 51902450 boat Grok Seahandler
        [54141818] = { icon="boat", label=returntoZuldazar, note=Zandalar, requirements={quest=51696}, faction="Horde" }, -- Stormsong Valley 51403370 Flightmaster Muka Stormbreaker
        [20332457] = { icon="boat", label=returntoZuldazar, note=Zandalar, requirements={quest=55651}, faction="Horde" }, -- Mechagon
--noboat        [20742783] = { icon="boat", label=returntoBoralus, note=TiragardeSound, quest=54992, faction="Alliance" }, --Mechagon --quest=54992,
        [62095274] = { icon="boat", multilabel={BtoVolDun, BtoNazmir, BtoZuldazar}, multinote={Zandalar, Zandalar, Zandalar}, requirements={multiquest={51283, 51088, 51308}}, faction="Alliance" },
        [60855074] = { icon="portal_mixed", multilabel={PtoArathiHighlands, PtoDarkshore}, multinote={EasternKingdoms, Kalimdor}, requirements={level=50}, faction="Alliance" },
        [58635379] = { icon="petBattlePortal", multilabel={244506, 244502, 286079, 301941, 314215}, multinote={NorthernBarrens, Westfall, DunMorogh, EasternPlaguelands, BurningSteppes}, requirements={multiquest={45423, 46291, 54185, 56491, 58457}}, faction="Alliance" },
        [62485111] = { icon="aboat", label=BtoSW, note=ElwynnForest, faction="Horde" },
        [62485112] = { icon="boat", label=BtoSW, note=ElwynnForest, faction="Alliance" },
        [69257667] = { icon="molemachine", label=GetAreaInfo(9135), requirements={quest=80101, hideQuestName=true}, race="DarkIronDwarf" }, -- The Wailing Tideway
        [59691632] = { icon="molemachine", label=GetAreaInfo(9623), requirements={quest=80102, hideQuestName=true}, race="DarkIronDwarf" } -- Tidebreak Summit
        },
    [895] = { -- Tiragarde Sound
        [74302350] = { icon="portal", multilabel={PtoSW, PtoIF, PtoExodar, PtoSilithus, PtoNazjatar}, multinote={ElwynnForest, DunMorogh, AzuremystIsle, Kalimdor}, requirements={multiquest={47186, 47186, 47186, 47186, 54972}, multiaccquest={true, true, true}, multilevel={10, 10, 10, 50, 50}}, faction="Alliance" },
        [73692628] = { icon="boat", multilabel={BtoVolDun, BtoNazmir, BtoZuldazar}, multinote={Zandalar, Zandalar, Zandalar}, faction="Alliance" },
        [73362568] = { icon="portal_mixed", multilabel={PtoArathiHighlands, PtoDarkshore}, multinote={EasternKingdoms, Kalimdor}, requirements={level=50}, faction="Alliance" },
        [69453107] = { icon="petBattlePortal", multilabel={244506, 244502, 286079, 301941, 314215}, multinote={NorthernBarrens, Westfall, DunMorogh, EasternPlaguelands, BurningSteppes}, requirements={multiquest={45423, 46291, 54185, 56491, 58457}}, faction="Alliance" },
        [87845118] = { icon="boat", label=returntoZuldazar, note=Zandalar, requirements={quest=51438}, faction="Horde" },
        [76252633] = { icon="aboat", label=BtoSW, note=ElwynnForest, faction="Horde" },
        [76252634] = { icon="boat", label=BtoSW, note=ElwynnForest, faction="Alliance" },
        [88227153] = { icon="molemachine", label=GetAreaInfo(9135), requirements={quest=80101, hideQuestName=true}, race="DarkIronDwarf" } -- The Wailing Tideway
        },
    [896] = { -- Drustvar
        [20604334] = { icon="boat", label=returntoZuldazar, note=Zandalar, requirements={quest=51340}, faction="Horde" }
        },
    [942] = { -- Stormsong Valley
        [51902450] = { icon="boat", label=returntoZuldazar, note=Zandalar, requirements={quest=51696}, faction="Horde" }, --Stormsong valley 51902450 boat Grok Seahandler
        [51403370] = { icon="boat", label=returntoZuldazar, note=Zandalar, requirements={quest=51696}, faction="Horde" }, --Stormsong Valley 51403370 Flightmaster Muka Stormbreaker
        [64212944] = { icon="molemachine", label=GetAreaInfo(9623), requirements={quest=80102, hideQuestName=true}, race="DarkIronDwarf" } -- Tidebreak Summit
        },
    [1161] = { -- Boralus
        [70401600] = { icon="portal", multilabel={PtoSW, PtoIF, PtoExodar, PtoSilithus, PtoNazjatar}, multinote={ElwynnForest, DunMorogh, AzuremystIsle, Kalimdor}, requirements={multiquest={47186, 47186, 47186, 47186, 54972}, multiaccquest={true, true, true}, multilevel={10, 10, 10, 50, 50}}, faction="Alliance" },
        [67952669] = { icon="boat", multilabel={BtoVolDun, BtoNazmir, BtoZuldazar}, multinote={Zandalar, Zandalar, Zandalar}, faction="Alliance" },
        [66352486] = { icon="portal_mixed", multilabel={PtoArathiHighlands, PtoDarkshore}, multinote={EasternKingdoms, Kalimdor}, requirements={level=50}, faction="Alliance" }, --quest=53194,
        [50044669] = { icon="petBattlePortal", multilabel={244506, 244502, 286079, 301941, 314215}, multinote={NorthernBarrens, Westfall, DunMorogh, EasternPlaguelands, BurningSteppes}, requirements={multiquest={45423, 46291, 54185, 56491, 58457}}, faction="Alliance" },
        [78142708] = { icon="aboat", label=BtoSW, note=ElwynnForest, faction="Horde" },
        [78142709] = { icon="boat", label=BtoSW, note=ElwynnForest, faction="Alliance" }
        },
    [1462] = { -- Mechagon
        [75492266] = { icon="boat", label=returntoZuldazar, note=Zandalar, requirements={quest=55651}, faction="Horde" }
        },

--------------------------------------------------------------------------------------------LEGION---------------------------------------------------------------------------------------------

    [619] = { -- Broken Isles
        [30712543] = { icon="orderhall", multilabel={PtoDala, PtoEmeraldDreamway}, multinote={BrokenIsles}, class="DRUID" },
        [63326940] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="DEATHKNIGHT" },
        [45406523] = { icon="portal", multilabel={PtoSW, PtoKarazhan, PtoDalaCrater, PtoWyrmrestTemple, L["Rift to Telogrus"]}, multinote={Durotar, DeadwindPass, HillsbradFoothills, Dragonblight, BrokenIsles}, requirements={multiquest={[5]=79010}, multilevel={10, 10, 10, 10}}, faction="Alliance" },
        [46086351] = { icon="portal", multilabel={PtoOG, PtoKarazhan, PtoDalaCrater, PtoWyrmrestTemple, L["Rift to Telogrus"]}, multinote={Durotar, DeadwindPass, HillsbradFoothills, Dragonblight, BrokenIsles}, requirements={multiquest={[5]=79010}, multilevel={10, 10, 10, 10}}, faction="Horde" },
        [33675793] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [33675788] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [52082914] = { icon="portal", label=PtoDala, note=BrokenIsles },
        [65492873] = { icon="portal", label=PtoHelheim, note=Stormheim },
        [41702157] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="HUNTER" }, -- quest=40953, ????
        [52597039] = { icon="worderhall", label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Broken Shore
        [61353269] = { icon="worderhall", label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Stormheim
        [34544019] = { icon="worderhall", label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Val'sharah
        [46022488] = { icon="worderhall", label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Highmountain
        [33995326] = { icon="worderhall", label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Azsuna
        [43944460] = { icon="worderhall", label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }, -- Suramar
        [58096766] = { icon="molemachine", label=GetAreaInfo(7543), requirements={quest=53589, hideQuestName=true}, race="DarkIronDwarf" }, -- The Broken Shore, Broken Shore
        [45482973] = { icon="molemachine", label=GetAreaInfo(7806), requirements={quest=53593, hideQuestName=true}, race="DarkIronDwarf" }, -- Highmountain, Neltharion's Vault
        [46102532] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [34593931] = { icon="portal", label=PtoBelameth, note=Amirdrassil },
        [51345613] = { icon="portal", multilabel={PtoOG, L["Portal to Shal'Aran"]}, multinote={Durotar, Meredil}, faction="Horde" }
        -- [51485622] = { icon="portal", multilabel={PtoSW, L["Portal to Shal'Aran"]}, multinote={ElwynnForest, Meredil}, faction="Alliance" } -- BUGGED FOR ALLIANCE?
        },
    [627] = { -- Dalaran Broken Isles
        [39506320] = { icon="portal", label=PtoSW, note=ElwynnForest, requirements={level=10}, faction="Alliance" },
        [55302400] = { icon="portal", label=PtoOG, note=Durotar, requirements={level=10}, faction="Horde" },
        [58613934] = { icon="petBattlePortal", multilabel={244506, 244502, 286079, 301941, 314215}, multinote={NorthernBarrens, Westfall, DunMorogh, EasternPlaguelands, BurningSteppes}, requirements={multiquest={45423, 46291, 54185, 56491, 58457}} },
        [72854121] = { icon="flightMaster", label=GEtoTrueshotLodge, note=BrokenIsles..", "..highmountain, class="HUNTER" }, --quest=40953, ????
        [49254759] = { icon="portal", multilabel={PtoKarazhan, PtoDalaCrater, PtoWyrmrestTemple, L["Rift to Telogrus"]}, multinote={DeadwindPass, HillsbradFoothills, Dragonblight, BrokenIsles}, requirements={multiquest={[4]=79010}, multilevel={10, 10, 10}} }
        },
    [629] = { -- Dalaran - Aegwynn's Gallery
        [33717878] = { icon="portal", label=L["Rift to Telogrus"], note=BrokenIsles, requirements={quest=79010}},
        [30808431] = { icon="portal", label=PtoWyrmrestTemple, note=Dragonblight, requirements={level=10} },
        [28717736] = { icon="portal", label=PtoDalaCrater, note=HillsbradFoothills, requirements={level=10} },
        [32027144] = { icon="portal", label=PtoKarazhan, note=DeadwindPass, requirements={level=10} }
        },
    [630] = { -- Azsuna
        [46664141] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [80176227] = { icon="portal", label=PtoSW, note=ElwynnForest, requirements={level=10}, faction="Alliance" },
        [46644121] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [82135737] = { icon="portal", label=PtoOG, note=Durotar, requirements={level=10}, faction="Horde" },
        [47582809] = { icon="worderhall", label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
        [97173626] = { icon="portal", multilabel={PtoOG, L["Portal to Shal'Aran"]}, multinote={Durotar, Meredil}, requirements={multilevel={1, 45}}, faction="Horde" }
        -- [97203635] = { icon="portal", multilabel={PtoSW, L["Portal to Shal'Aran"]}, multinote={ElwynnForest, Meredil}, faction="Alliance" } -- BUGGED FOR ALLIANCE?
        },
    [634] = { -- Stormheim
        [30084070] = { icon="portal", label=PtoDala, note=BrokenIsles },
        [73633938] = { icon="portal", label=PtoHelheim, note=Stormheim },
        [60175223] = { icon="worderhall", label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }
        },
    [649] = { -- Stormheim - Helheim
        [66584793] = { icon="portal", label=PtoStormheim, note=Stormheim }
        },
    [650] = { -- Highmountain
        [62247129] = { icon="portal", label=PtoDala, note=BrokenIsles },
        [34585114] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="HUNTER" }, --quest=40953, ????
        [46115996] = { icon="worderhall", label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
        [44667290] = { icon="molemachine", label=GetAreaInfo(7806), requirements={quest=53593, hideQuestName=true}, race="DarkIronDwarf" }, -- Highmountain, Neltharion's Vault
        [46326113] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" }
        },
    [652] = { -- Thunder Totem
        [46006386] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" }
        },
    [750] = { -- Highmountain - Thunder Totem
        [39834206] = { icon="worderhall", label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" }
        },
    [641] = { -- Val'sharah
        [41742385] = { icon="orderhall", multilabel={PtoDala, PtoEmeraldDreamway}, multinote={BrokenIsles}, class="DRUID" },
        [54707490] = { icon="worderhall", label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
        [54847186] = { icon="portal", label=PtoBelameth, note=Amirdrassil }
        },
    [680] = { -- Suramar
        [33094822] = { icon="worderhall", label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
        [58178733] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        -- [58678763] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" } -- BUGGED FOR ALLIANCE?
        [57988660] = { icon="portal", label=L["Portal to Shal'Aran"], note=Meredil, faction="Horde" } -- BUGGED FOR ALLIANCE?
        },
    [646] = { -- Broken Shore
        [44816132] = { icon="worderhall", label=JtoSkyhold, note=BrokenIsles, class="WARRIOR" },
        [71694799] = { icon="molemachine", label=GetAreaInfo(7543), requirements={quest=53589, hideQuestName=true}, race="DarkIronDwarf" } -- The Broken Shore, Broken Shore
        },
    [830] = { -- Krokuun
        [62008694] = { icon="portal", label=PtoDala, note=BrokenIsles }
        },
    [832] = { -- Krokuun Vindikaar
        [43272508] = { icon="portal", label=PtoDala, note=BrokenIsles }
        },
    [882] = { -- Eredath
        [51668722] = { icon="portal", label=PtoDala, note=BrokenIsles }
        },
    [884] = { -- Eredath Vindikaar
        [49332529] = { icon="portal", label=PtoDala, note=BrokenIsles }
        },
    [885] = { -- Antoran Wastes
        [75893732] = { icon="portal", label=PtoDala, note=BrokenIsles }
        },
    [887] = { -- Antoran Wastes Vindikaar
        [33785600] = { icon="portal", label=PtoDala, note=BrokenIsles }
        },
    [971] = { -- Telogrus Rift
        [24932791] = { icon="portal", label=L["Rift to Dalaran"], note=BrokenIsles }
        },

-------------------------------------------------------------------------------------------ORDERHALL-------------------------------------------------------------------------------------------

    [747] = { -- The Dreamgrove *DRUID*
        [56604310] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="DRUID" },
        [55502200] = { icon="orderhall", label=PtoEmeraldDreamway, class="DRUID" }
        },
    [715] = { -- Emerald Dreamway *DRUID*
        [39916966] = { icon="orderhall", label=PtoDuskwood, note=EasternKingdoms, class="DRUID" },
        [23023836] = { icon="orderhall", label=PtoFeralas, note=Kalimdor, class="DRUID" },
        [31532414] = { icon="orderhall", label=PtoGrizzlyHills, note=Northrend, class="DRUID" },
        [50756608] = { icon="orderhall", label=PtoHinterlands, note=EasternKingdoms, class="DRUID" },
        [25848036] = { icon="orderhall", label=PtoMoonglade, note=Kalimdor, class="DRUID" },
        [53725295] = { icon="orderhall", label=PtoHyjal, note=Kalimdor, class="DRUID" },
        [45562372] = { icon="orderhall", label=PtoDreamgrove, note=valsharahBrokenIsles, class="DRUID" },
        [18995997] = { icon="orderhall", label=PtoBelameth, note=Amirdrassil, class="DRUID" }
        },
    [648] = { -- Acherus: The Ebon Hold - Hall of Command *DEATHKNIGHT*
        [24703370] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="DEATHKNIGHT" }
        },
    [720] = { -- Mardum, the Shattered Abyss - Upper Command Center *DEMONHUNTER*
        [59269182] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="DEMONHUNTER" }, --quest=42872, access to orderhall
        [58361658] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="DEMONHUNTER" }
        },
    [734] = { -- Hall of the Guardian *MAGE*
        [57299056] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="MAGE" },
        [66784670] = { icon="orderhall", requirements={spell=223413}, label=PtoValsharah, note=BrokenIsles, class="MAGE" },
        [67214172] = { icon="orderhall", requirements={spell=223413}, label=PtoStormheim, note=BrokenIsles, class="MAGE" },
        [60235191] = { icon="orderhall", requirements={spell=223413}, label=PtoSuramar, note=BrokenIsles, class="MAGE" },
        [54684456] = { icon="orderhall", requirements={spell=223413}, label=PtoHighmountain, note=BrokenIsles, class="MAGE" },
        [54993963] = { icon="orderhall", requirements={spell=223413}, label=PtoAzsuna, note=BrokenIsles, class="MAGE" }
        },
    [726] = { -- The Maelstrom *SHAMAN*
        [29835200] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="SHAMAN" }
        },
    [24] = { -- Light's Hope Chapel *PALADIN*
        [37646407] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="PALADIN" }
--      in Eastern Plaguelands and Eastern Kingdoms another portal POI
        },
    [717] = { -- Dreadscar Rift *WARLOCK*
        [74333750] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="WARLOCK" }
        },
    [702] = { -- Netherlight Temple *PRIEST*
        [49798075] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="PRIEST" }
        },
    [695] = { -- Skyhold *WARRIOR*
--      [58322500] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="WARRIOR" },
        [58322500] = { icon="worderhall", multilabel={dalaran, stormheim, azsuna, valsharah, highmountain, suramar, brokenshore}, note=BrokenIsles, class="WARRIOR" }
        },
    [709] = { -- The Wandering Isle *MONK*
        [52405714] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="MONK" },
        [50055441] = { icon="orderhall", label=PtoPeakofSerenity, note=KunLaiSummit, class="MONK" }
        },
    [739] = { -- Trueshotlodge *HUNTER*
        [48634352] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="HUNTER" } --quest=40953, access to orderhall ???
        },

----------------------------------------------------------------------------------------------WoD----------------------------------------------------------------------------------------------

    [572] = { -- Draenor
        [71633894] = { icon="portal", multilabel={PtoOG, PtoVolmar}, multinote={Durotar, TanaanJungle}, requirements={multiquest={[2]=37935}}, faction="Horde" },
        [71324929] = { icon="portal", multilabel={PtoSW, PtoLionswatch}, multinote={ElwynnForest, TanaanJungle}, requirements={multiquest={[2]=38445}}, faction="Alliance" },
        [34683698] = { icon="portal", label=PtoWarspear, note=Ashran, requirements={quest=36614}, faction="Horde" },
        [53556087] = { icon="portal", label=PtoStormshield, note=Ashran, requirements={quest=36615}, faction="Alliance" },
        [60424563] = { icon="portal", label=PtoWarspear, note=Ashran, requirements={quest=37935}, faction="Horde" },
        [59594867] = { icon="portal", label=PtoStormshield, note=Ashran, requirements={quest=38445}, faction="Alliance" },
        [36843203] = { icon="ogreWaygate", label=OgreWaygate, requirements={quest=36904, item={117491, 25}, hideQuestName=true, spell=178777} }, -- Frostfire Ridge
        [58736681] = { icon="ogreWaygate", label=OgreWaygate, requirements={quest=36903, item={117491, 25}, hideQuestName=true, spell=178777} }, -- Shadowmoon Valley
        [58684818] = { icon="ogreWaygate", label=OgreWaygate, requirements={quest=39497, item={117491, 25}, hideQuestName=true, spell=178777} }, -- Tanaan Jungle
        [52432296] = { icon="ogreWaygate", label=OgreWaygate, requirements={quest=36886, item={117491, 25}, hideQuestName=true, spell=178777} }, -- Gorgrond
        [20935290] = { icon="ogreWaygate", label=OgreWaygate, requirements={quest=36906, item={117491, 25}, hideQuestName=true, spell=178777} }, -- Nagrand
        [47817847] = { icon="ogreWaygate", label=OgreWaygate, requirements={quest=36885, item={117491, 25}, hideQuestName=true, spell=178777} }, -- Spires of Arak
        [42635724] = { icon="ogreWaygate", label=OgreWaygate, requirements={quest=36905, item={117491, 25}, hideQuestName=true, spell=178777} }, -- Talador
        [48352451] = { icon="molemachine", label=GetAreaInfo(6967), requirements={quest=53588, hideQuestName=true}, race="DarkIronDwarf" }, -- Gorgrond, Blackrock Foundry Overlook
        [29324342] = { icon="molemachine", label=GetAreaInfo(3636), requirements={quest=53590, hideQuestName=true}, race="DarkIronDwarf" }, -- Nagrand, Elemental Plateau
        [26703144] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 105, 3824), requirements={toy=129929} }, -- Bloodmaul Ravine
        [30923558] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 105, 3824), requirements={toy=129929} }, -- Bloodmaul Ravine
        [53396476] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 104, 3743), requirements={toy=129929} }, -- Legion Hold
        [61557054] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 104), requirements={toy=129929} }, -- near The Black Temple
        [49333706] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 105, 3833), requirements={toy=129929} }, -- Razor Ridge
        [49842188] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 105, 3618), requirements={toy=129929} }, -- Gruul's Lair
        [25475564] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 107), requirements={toy=129929} }, -- near Oshu'gun
        [30734684] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 107, 3615), requirements={toy=129929} }, -- Throne of the Elements
        [33184361] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 102, 3720), requirements={toy=129929} }, -- Twin Spire Ruins
        [34944706] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 102), requirements={toy=129929} }, --
        [45896803] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 108, 3679), requirements={toy=129929} }, -- Skettis
        [57774641] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 100, 3545), requirements={toy=129929} }, -- The Path of Glory (near Hellfire Citadel)
        [62564729] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 100, 3706), requirements={toy=129929} }, -- The Path of Glory (near The Dark Portal)
        [41415385] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 108), requirements={toy=129929} }, -- near Shattrath
        [43366574] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 108, 3697), requirements={toy=129929} } -- The Bone Wastes
        },
    [588] = { -- Ashran
        [43921380] = { icon="portal", multilabel={PtoOG, PtoVolmar}, multinote={Durotar, TanaanJungle}, requirements={multiquest={[2]=37935}}, faction="Horde" },
        [41678913] = { icon="portal", multilabel={PtoSW, PtoLionswatch}, multinote={ElwynnForest, TanaanJungle}, requirements={multiquest={[2]=38445}}, faction="Alliance" }
        },
    [590] = { -- Frostwall (Garrison)
        [75104890] = { icon="portal", label=PtoWarspear, note=Ashran, requirements={quest=36614}, faction="Horde" }
        },
    [525] = { -- Frostfire Ridge
        [51496593] = { icon="portal", label=PtoWarspear, note=Ashran, requirements={quest=36614}, faction="Horde" },
        [59544752] = { icon="ogreWaygate", label=OgreWaygate, requirements={quest=36904, item={117491, 25}, hideQuestName=true, spell=178777} }, -- 36843203
        [21814531] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 105, 3824), requirements={toy=129929} }, -- Bloodmaul Ravine
        [37536071] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 105, 3824), requirements={toy=129929} } -- Bloodmaul Ravine
        },
    [582] = { -- Lunarfall (Garrison)
        [70102750] = { icon="portal", label=PtoStormshield, note=Ashran, requirements={quest=36615}, faction="Alliance" }
        },
    [539] = { -- Shadowmoon Valley
        [32871553] = { icon="portal", label=PtoStormshield, note=Ashran, requirements={quest=36615}, faction="Alliance" },
        [50463569] = { icon="ogreWaygate", label=OgreWaygate, requirements={quest=36903, item={117491, 25}, hideQuestName=true, spell=178777} }, -- 58736681
        [32332876] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 104, 3743), requirements={toy=129929} }, -- Legion Hold
        [60024837] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 104), requirements={toy=129929} } -- near The Black Temple
        },
    [534] = { -- Tanaan Jungle
        [61004734] = { icon="portal", label=PtoWarspear, note=Ashran, requirements={quest=37935}, faction="Horde" },
        [57446050] = { icon="portal", label=PtoStormshield, note=Ashran, requirements={quest=38445}, faction="Alliance" },
        [53495838] = { icon="ogreWaygate", label=OgreWaygate, requirements={quest=39497, item={117491, 25}, hideQuestName=true, spell=178777} }, -- 58684818
        [49565073] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 100, 3545), requirements={toy=129929} }, -- The Path of Glory (near Hellfire Citadel)
        [70305453] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 100, 3706), requirements={toy=129929} } -- The Path of Glory (near The Dark Portal)
        },
    [624] = { -- Warspear (Ashran)
        [60705160] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [53104390] = { icon="portal", label=PtoVolmar, note=TanaanJungle, requirements={quest=37935}, faction="Horde" }
        },
    [622] = { -- Stormshield (Ashran)
        [60903800] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [36314116] = { icon="portal", label=PtoLionswatch, note=TanaanJungle, requirements={quest=38445}, faction="Alliance" }
        },
    [543] = { -- Gorgrond
        [58033443] = { icon="ogreWaygate", label=OgreWaygate, requirements={quest=36886, item={117491, 25}, hideQuestName=true, spell=178777} }, -- 52432296
        [46683876] = { icon="molemachine", label=GetAreaInfo(6967), requirements={quest=53588, hideQuestName=true}, race="DarkIronDwarf" }, -- Gorgrond, Blackrock Foundry Overlook
        [49417366] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 105, 3833), requirements={toy=129929} }, -- Razor Ridge
        [50823143] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 105, 3618), requirements={toy=129929} } -- Gruul's Lair
        },
    [550] = { -- Nagrand
        [32164623] = { icon="ogreWaygate", label=OgreWaygate, requirements={quest=36906, item={117491, 25}, hideQuestName=true, spell=178777} }, -- 20935290
        [65750825] = { icon="molemachine", label=GetAreaInfo(3636), requirements={quest=53590, hideQuestName=true}, race="DarkIronDwarf" }, -- Nagrand, Elemental Plateau
        [50355721] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 107), requirements={toy=129929} }, -- near Oshu'gun
        [71412194] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 107, 3615), requirements={toy=129929} }, -- Throne of the Elements
        [81240898] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 102, 3720), requirements={toy=129929} }, -- Twin Spire Ruins
        [88302284] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 102), requirements={toy=129929} } --
        },
    [542] = { -- Spires of Arak
        [54625163] = { icon="ogreWaygate", label=OgreWaygate, requirements={quest=36885, item={117491, 25}, hideQuestName=true, spell=178777} }, -- 47817847
        [47391245] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 108, 3679), requirements={toy=129929} } -- Skettis
        },
    [535] = { -- Talador
        [55074812] = { icon="ogreWaygate", label=OgreWaygate, requirements={quest=36905, item={117491, 25}, hideQuestName=true, spell=178777} }, -- 42635724
        [50413519] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 108) }, -- near Shattrath
        [57858053] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(101, 108, 3697), requirements={toy=129929} } -- The Bone Wastes
        },

----------------------------------------------------------------------------------------------MoP----------------------------------------------------------------------------------------------

    [424] = { -- Pandaria
        [29534767] = { icon="portal", label=PtoIofT, note=Pandaria, requirements={quest=32680}, faction="Horde" },
        [29144595] = { icon="portal", label=PtoIofT, note=Pandaria, requirements={quest=32681}, faction="Alliance" },
        [19100943] = { icon="portal", label=PtoSPG, note=TownlongSteppes, requirements={quest=32212}, faction="Horde" },
        [24331611] = { icon="portal", label=PtoSPG, note=TownlongSteppes, requirements={quest=32644}, faction="Alliance" },
        [55215658] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [67816760] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [59883557] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [50784779] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [44792782] = { icon="orderhall", label=PtoOG, note=Durotar, class="MONK", faction="Horde" },
        [44972774] = { icon="orderhall", label=PtoSW, note=ElwynnForest, class="MONK", faction="Alliance" },
        [47117259] = { icon="molemachine", label=GetAreaInfo(5963), requirements={quest=53598, hideQuestName=true}, race="DarkIronDwarf" }, -- Valley of the Four Winds, Stormstout Brewery
        [48483559] = { icon="molemachine", label=GetAreaInfo(6085), requirements={quest=53595, hideQuestName=true}, race="DarkIronDwarf" } -- Kun-Lai Summit, One Keg
        },
    [390] = { -- Vale of Eternal Blossoms
        [90876620] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [63461261] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" }
        },
    [1530] = { -- Vale of Eternal Blossoms BFA Vision of N'Zoth
        [91606427] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [63720988] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" }
        },
    [392] = { -- Shrine of Two Moons - The Imperial Mercantile
        [73304270] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" }
        },
    [394] = { -- Shrine of Seven Stars - The Imperial Exchange
        [71703570] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" }
        },
    [388] = { -- Townlong Steppes
        [49746867] = { icon="portal", label=PtoIofT, note=Pandaria, requirements={quest=32681}, faction="Alliance" },
        [50607340] = { icon="portal", label=PtoIofT, note=Pandaria, requirements={quest=32680}, faction="Horde" }
        },
    [376] = { -- Valley of the Four Winds
        [31517359] = { icon="molemachine", label=GetAreaInfo(5963), requirements={quest=53598, hideQuestName=true}, race="DarkIronDwarf" } -- Valley of the Four Winds, Stormstout Brewery
        },
    [379] = { -- Kun-Lai Summit
        [48534357] = { icon="orderhall", label=PtoOG, note=Durotar, class="MONK", faction="Horde" },
        [48964336] = { icon="orderhall", label=PtoSW, note=ElwynnForest, class="MONK", faction="Alliance" },
        [57686281] = { icon="molemachine", label=GetAreaInfo(6085), requirements={quest=53595, hideQuestName=true}, race="DarkIronDwarf" } -- Kun-Lai Summit, One Keg
        },
    [371] = { -- The Jade Forest
        [28501401] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [46238516] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" }
        },
    [504] = { -- Isle of Thunder
        [64707348] = { icon="portal", label=PtoSPG, note=TownlongSteppes, requirements={quest=32644}, faction="Alliance" },
        [33213269] = { icon="portal", label=PtoSPG, note=TownlongSteppes, requirements={quest=32212}, faction="Horde" }
        },

---------------------------------------------------------------------------------------------CATA----------------------------------------------------------------------------------------------

    [198] = { -- Mount Hyjal
        [62602310] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [63492444] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [58992623] = { icon="orderhall", label=PtoEmeraldDreamway, note=valsharahBrokenIsles, class="DRUID" },
        [57187711] = { icon="molemachine", label=GetAreaInfo(5040), requirements={quest=53601, hideQuestName=true}, race="DarkIronDwarf" }, -- Mount Hyjal, Throne of Flame
        [62442272] = { icon="portal", label=PtoBelameth, note=Amirdrassil },
        [27495639] = { icon="portal", label=L["Portal to the Firelands"], note=MoltenFront, requirements={quest=29201} }
        },
    [338] = { -- Molten Front
        [53118370] = { icon="portal", label=PtoHyjal, note=Kalimdor }
        },
    [207] = { -- Deepholm
        [48515381] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [50935310] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [49325034] = { icon="portal", label=PtoTherazanesThrone, note=Deepholm, requirements={quest=26709} },
        [57211352] = { icon="portal", label=PtoTempleofEarth, note=Deepholm, requirements={quest=26971} }
        },
    [948] = { -- Maelstrom
        [51182842] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [51172840] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" }
        },
    [241] = { -- Twilight Highlands
        [79517782] = { icon="portal", label=PtoSW, note=ElwynnForest, requirements={quest=27537}, faction="Alliance" },
        [73625351] = { icon="portal", label=PtoOG, note=Durotar, requirements={quest=26798}, faction="Horde" }
        },
    [244] = { -- Tol Barad
        [47115193] = { icon="portal", label=PtoSW, note=ElwynnForest, requirements={level=30}, faction="Alliance" },
        [47115192] = { icon="portal", label=PtoOG, note=Durotar, requirements={level=30}, faction="Horde" }
        },
    [245] = { -- Tol Barad Peninsula
        [75255887] = { icon="portal", label=PtoSW, note=ElwynnForest, requirements={level=30}, faction="Alliance" },
        [56277966] = { icon="portal", label=PtoOG, note=Durotar, requirements={level=30}, faction="Horde" }
        },
    [217] = {
        [63629649] = { icon="boat", label=BtoBelanaar, note=Amirdrassil }
        },

---------------------------------------------------------------------------------------------WotLK---------------------------------------------------------------------------------------------

    [125] = { -- Dalaran Northrend
        [40086282] = { icon="portal", label=PtoSW, note=ElwynnForest, requirements={level=10}, faction="Alliance" },
        [55302542] = { icon="portal", label=PtoOG, note=Durotar, requirements={level=10}, faction="Horde" },
        [25634785] = { icon="portal", label=PtotPurpleParlor, requirements={level=10} }
        },
    [127] = { -- Crystalsong Forest
        [26194278] = { icon="portal", label=PtoSW, note=ElwynnForest, requirements={level=10}, faction="Alliance" },
        [31223174] = { icon="portal", label=PtoOG, note=Durotar, requirements={level=10}, faction="Horde" }
        },
    [113] = { -- Northrend
        [47874119] = { icon="portal", label=PtoSW, note=ElwynnForest, requirements={level=10}, faction="Alliance" },
        [48664124] = { icon="portal", label=PtoOG, note=Durotar, requirements={level=10}, faction="Horde" },
        [78858355] = { icon="aboat", label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        [78858356] = { icon="boat", label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
        [24607066] = { icon="aboat", label=BtoSW, note=ElwynnForest, faction="Horde" },
        [24607065] = { icon="boat", label=BtoSW, note=ElwynnForest, faction="Alliance" },
        [47106782] = { icon="boat", multilabel={BtoUnuPe, BtoKamagua}, multinote={BoreanTundra, HowlingFjord} },
        [30506590] = { icon="boat", label=BtoMoaKiHarbor, note=Dragonblight },
        [66408188] = { icon="boat", label=BtoMoaKiHarbor, note=Dragonblight },
        [17556488] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [17556489] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" },
        -- [84057266] = { icon="portal", label=PtoUC, note=Tirisfal, faction="Horde" },
        [24364962] = { icon="portal", label=WtoUngoroCrater, note=Kalimdor, requirements={quest=12613} },
        [71735264] = { icon="orderhall", label=PtoEmeraldDreamway, note=valsharahBrokenIsles, class="DRUID" },
        [46065889] = { icon="molemachine", label=GetAreaInfo(4168), requirements={quest=53596, hideQuestName=true}, race="DarkIronDwarf" }, -- Dragonblight, Ruby Dragonshrine
        [48541958] = { icon="molemachine", label=GetAreaInfo(4658), requirements={quest=53586, hideQuestName=true}, race="DarkIronDwarf" } -- Icecrown, Argent Tournament Grounds
        },
    [115] = { -- Dragonblight
        [47797887] = { icon="boat", label=BtoUnuPe, note=BoreanTundra },
        [49847853] = { icon="boat", label=BtoKamagua, note=HowlingFjord },
        [45354992] = { icon="molemachine", label=GetAreaInfo(4168), requirements={quest=53596, hideQuestName=true}, race="DarkIronDwarf" } -- Dragonblight, Ruby Dragonshrine
        },
    [114] = { -- Borean Tundra
        [79015410] = { icon="boat", label=BtoMoaKiHarbor, note=Dragonblight },
        [59946947] = { icon="aboat", label=BtoSW, note=ElwynnForest, faction="Horde" },
        [59946948] = { icon="boat", label=BtoSW, note=ElwynnForest, faction="Alliance" },
        [41255344] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [41255345] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" }
        },
    [116] = { -- Grizzly Hills
        [50322923] = { icon="orderhall", label=PtoEmeraldDreamway, note=valsharahBrokenIsles, class="DRUID" }
        },
    [117] = { -- Howling Fjord
        [23295769] = { icon="boat", label=BtoMoaKiHarbor, note=Dragonblight },
        [61506270] = { icon="aboat", label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        [61506271] = { icon="boat", label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
        -- [77612813] = { icon="portal", label=PtoUC, note=Tirisfal, faction="Horde" } -- https://us.forums.blizzard.com/en/wow/t/portal-from-vengeance-landing-to-tirisfal-glades-is-missing
        },
    [118] = { -- Icecrown
        [76971866] = { icon="molemachine", label=GetAreaInfo(4658), requirements={quest=53586, hideQuestName=true}, race="DarkIronDwarf" } -- Icecrown, Argent Tournament Grounds
        },
    [119] = { -- Sholazar Basin
        [40348312] = { icon="portal", label=WtoUngoroCrater, note=Kalimdor, requirements={quest=12613} }
        },
    [120] = { -- The Storm Peaks
        [17223271] = { icon="molemachine", label=GetAreaInfo(4658), requirements={quest=53586, hideQuestName=true}, race="DarkIronDwarf" } -- Icecrown, Argent Tournament Grounds
        },

----------------------------------------------------------------------------------------------BC-----------------------------------------------------------------------------------------------

    [100] = { -- Hellfire Peninsula
        [89225101] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [89234946] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [53156489] = { icon="molemachine", label=GetAreaInfo(3538), requirements={quest=53592, hideQuestName=true}, race="DarkIronDwarf" }, -- Hellfire Peninsula, Honor Hold
        [54974890] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 534, 7716), requirements={toy=129929} }, -- near Hellfire Citadel
        [80385160] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 534, 7037), requirements={toy=129929} } -- near The Dark Portal
        },
    [111] = { -- Shattrath City
        [57224827] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [48594200] = { icon="portal", label=PtoIofQD, note=EasternKingdoms },
        [56834888] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [74803160] = { icon="portal", label=PtoCavernsofTime, note=Tanaris..")\n("..L["Speak with Zephyr"], requirements={reputation={989,7} } }
        },
    [101] = { -- Outland
        [43886598] = { icon="portal", multilabel={PtoSW, PtoIofQD}, multinote={ElwynnForest, EasternKingdoms}, faction="Alliance" },
        [43886599] = { icon="portal", multilabel={PtoOG, PtoIofQD}, multinote={Durotar, EasternKingdoms}, faction="Horde" },
        [44876501] = { icon="portal", label=PtoCavernsofTime, note=Tanaris..")\n("..L["Speak with Zephyr"], requirements={reputation={989,7} } },
        [69075236] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [69075190] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [66217784] = { icon="molemachine", label=GetAreaInfo(3747), requirements={quest=53599, hideQuestName=true}, race="DarkIronDwarf" }, -- Shadowmoon Valley, Fel Pits
        [58415647] = { icon="molemachine", label=GetAreaInfo(3538), requirements={quest=53592, hideQuestName=true}, race="DarkIronDwarf" }, -- Hellfire Peninsula, Honor Hold
        [46251761] = { icon="molemachine", label=GetAreaInfo(3866), requirements={quest=53597, hideQuestName=true}, race="DarkIronDwarf" }, -- Blade's Edge Mountains, Skald
        [36073617] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 525, 7062), requirements={toy=129929} }, -- The Burning Glacier
        [38173202] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 525, 6905), requirements={toy=129929} }, -- Gormaul Tower
        [44322031] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 543, 6892), requirements={toy=129929} }, -- The Pit
        [42123440] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 543, 6935), requirements={toy=129929} }, -- Razorbloom
        [34314931] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 550, 7255), requirements={toy=129929} }, -- Zangar Sea
        [39795884] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 550, 7385), requirements={toy=129929} }, -- Zangar Shore
        [28516832] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 550, 7151), requirements={toy=129929} }, -- Spirit Woods
        [34555772] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 550, 7280), requirements={toy=129929} }, -- Throne of the Elements
        [44756245] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 535, 7141), requirements={toy=129929} }, -- Arch of Sha'tar
        [47887328] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 535, 6918), requirements={toy=129929} }, -- Deathweb Hollow
        [55738205] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 535, 7031), requirements={toy=129929} }, -- Skettis
        [58757723] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 539, 6922), requirements={toy=129929} }, -- Moonflower Valley
        [69598124] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 539, 6931), requirements={toy=129929} }, -- Path of the Light
        [58945174] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 534, 7716), requirements={toy=129929} }, -- near Hellfire Citadel
        [66465254] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 534, 7037), requirements={toy=129929} } -- near The Dark Portal
        },
    [102] = { -- Zangarmarsh
        [49195537] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 550, 7255), requirements={toy=129929} }, -- Zangar Sea
        [68208846] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 550, 7385), requirements={toy=129929} } -- Zangar Shore
        },
     [107] = { -- Nagrand
        [88065172] = { icon="portal", multilabel={PtoOG, PtoIofQD}, multinote={Durotar, EasternKingdoms}, faction="Horde" },
        [88065173] = { icon="portal", multilabel={PtoSW, PtoIofQD}, multinote={ElwynnForest, EasternKingdoms}, faction="Alliance" },
        [92964857] = { icon="portal", label=PtoCavernsofTime, note=Tanaris..")\n("..L["Speak with Zephyr"], requirements={reputation={989,7} } },
        [41275904] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 550, 7151), requirements={toy=129929} }, -- Spirit Woods
        [60362556] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 550, 7280), requirements={toy=129929} } -- Throne of the Elements
        },
    [108] = { -- Terokkar Forest
        [30252350] = { icon="portal", multilabel={PtoSW, PtoIofQD}, multinote={ElwynnForest, EasternKingdoms}, faction="Alliance" },
        [30252351] = { icon="portal", multilabel={PtoOG, PtoIofQD}, multinote={Durotar, EasternKingdoms}, faction="Horde" },
        [35622076] = { icon="portal", label=PtoCavernsofTime, note=Tanaris..")\n("..L["Speak with Zephyr"], requirements={reputation={989,7} } },
        [35271251] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 535, 7141), requirements={toy=129929} }, -- Arch of Sha'tar
        [45374753] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 535, 6918), requirements={toy=129929} }, -- Deathweb Hollow
        [70787588] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 535, 7031), requirements={toy=129929} } -- Skettis
        },
    [103] = { -- Exodar
        [48306290] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" }
        },
    [104] = { -- Shadowmoon Valley
        [50773530] = { icon="molemachine", label=GetAreaInfo(3747), requirements={quest=53599, hideQuestName=true}, race="DarkIronDwarf" }, -- Shadowmoon Valley, Fel Pits
        [27103336] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 539, 6922), requirements={toy=129929} }, -- Moonflower Valley
        [61534607] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 539, 6931), requirements={toy=129929} } -- Path of the Light
        },
    [105] = { -- Blade's Edge Mountains
        [72421764] = { icon="molemachine", label=GetAreaInfo(3866), requirements={quest=53597, hideQuestName=true}, race="DarkIronDwarf" }, -- Blade's Edge Mountains, Skald
        [39637739] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 525, 7062), requirements={toy=129929} }, -- The Burning Glacier
        [46406404] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 525, 6905), requirements={toy=129929} }, -- Gormaul Tower
        [66192633] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 543, 6892), requirements={toy=129929} }, -- The Pit
        [59117169] = { icon="portal_purple", label=ReflectivePortal, note=GetMapNames(572, 543, 6935), requirements={toy=129929} } -- Razorbloom
        },
    [97] = { -- Azuremyst Isle
        [20335407] = { icon="portal", requirements={timetravel={quest=54411, spell=290245}}, label=PtoDarnassus, note=Teldrassil },
        [26364616] = { icon="portal", label=PtoSW, note=ElwynnForest..")\n("..inExodar.."", faction="Alliance" }
        },
    [110] = { -- Silvermoon City
        [49401510] = { icon="portal", label=PtoUC, note=Tirisfal..")\n("..Orboftranslocation.."", faction="Horde" },
        [58501890] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" }
        },
    [94] = { -- Eversong Woods
        [52803270] = { icon="portal", multilabel={PtoUC, PtoOG}, multinote={Tirisfal, Durotar}, faction="Horde"}
        },

--------------------------------------------------------------------------------------------Vanilla--------------------------------------------------------------------------------------------

    [12] = { -- Kalimdor
        [59236650] = { icon="aboat", label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        [59246651] = { icon="boat", label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" },
        [56825425] = { icon="boat", label=BtoBootyBay, note=StranglethornCape },
        [43561640] = { icon="portal", requirements={timetravel={quest=54411, spell=290245}}, multilabel={PtoSW, PtoExodar}, multinote={ElwynnForest, AzuremystIsle},faction="Alliance" },
        [39401090] = { icon="portal", requirements={timetravel={quest=54411, spell=290245}}, multilabel={PtoExodar, PtoHellfirePeninsula}, multinote={AzuremystIsle, Outland}, faction="Alliance" },
        [43211616] = { icon="portal", requirements={timetravel={quest=54411, spell=290245}}, label=PtoExodar, note=Teldrassil, faction="Horde" },
        [29922620] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [59468340] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [59448340] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [56122758] = { icon="portal", multilabel={PtoSW, PtoBelameth}, multinote={ElwynnForest, Amirdrassil}, faction="Alliance" },
        [56222774] = { icon="portal", multilabel={PtoOG, PtoBelameth}, multinote={Durotar, Amirdrassil}, faction="Horde" },
        [29332713] = { icon="portal", requirements={timetravel={quest=54411, spell=290245}}, label=PtoDarnassus, note=Teldrassil },
        [45375437] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [45375436] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" },
        [58154245] = { icon="zeppelin", multilabel={ZtoTB, ZtoStranglethornVale, ZtoBoreanTundra}, multinote={Mulgore, GromgolBaseCamp, WarsongHold}, faction="Horde" },
        [58154246] = { icon="hzeppelin", multilabel={ZtoTB, ZtoStranglethornVale, ZtoBoreanTundra}, multinote={Mulgore, GromgolBaseCamp, WarsongHold}, faction="Alliance" },
        [42857909] = { icon="portal", requirements={quest=46931, accquest=true, level=50, timetravel={quest=50659, spell=255152, turn=true}}, label=PtoZuldazar, note=Zandalar, faction="Horde" },
        [42847905] = { icon="portal", requirements={level=50, timetravel={quest=50659, spell=255152, turn=true}}, label=PtoBoralus, note=TiragardeSound, faction="Alliance" },
        [59414237] = { icon="portal", multilabel={PtoTolBarad, PtoUldum, PtoDeepholm, PtoVashjir, PtoHyjal, PtoTwilightHighlands, PtoUC, PtoDala, PtoSM, PtoJadeForest, PtoZuldazar, PtoAzsuna, PtoWarspear, PtoShattrath, PtoCavernsofTime, PtoOribos, PtoValdrakken, PtoDornogal},
                                      multinote={EasternKingdoms, Kalimdor, Maelstrom, EasternKingdoms, Kalimdor, EasternKingdoms, Tirisfal, CrystalsongForest, EversongWoods, Pandaria, Zandalar, BrokenIsles, Ashran, TerokkarForest, Tanaris, Shadowlands, Thaldraszus, IsleOfDorn},
                                      requirements={multiquest={[4]=25924, [6]=26798, [11]=46931, [16]=60151}, multiaccquest={[6]=true, [11]=true, [16]=true}, multilevel={30, 30, 30, 30, 30, 30, [17]=10}}, faction="Horde" },
        [46612303] = { icon="portal", requirements={level=50, warfront=118, timetravel={quest=54411, spell=290245}}, label=PtoPortofBoralus, note=TiragardeSound, faction="Alliance" },
        [46302282] = { icon="portal", requirements={level=50, warfront=118, timetravel={quest=54411, spell=290245}}, label=PtoPortofZandalar, note=Zuldazar, faction="Horde" },
        [50007527] = { icon="portal", label=WtoSholazarBasin, note=Northrend, requirements={quest=12613} },
        [41286181] = { icon="orderhall", label=PtoEmeraldDreamway, note=valsharahBrokenIsles, class="DRUID" },
        [54391934] = { icon="orderhall", label=PtoEmeraldDreamway, note=valsharahBrokenIsles, class="DRUID" },
        [55702794] = { icon="orderhall", label=PtoEmeraldDreamway, note=valsharahBrokenIsles, class="DRUID" },
        [50248010] = { icon="molemachine", label=GetAreaInfo(537), requirements={quest=53591, hideQuestName=true}, race="DarkIronDwarf" }, -- Un'Goro Crater, Fire Plume Ridge
        [50565121] = { icon="molemachine", label=GetAreaInfo(5385), requirements={quest=53600, hideQuestName=true}, race="DarkIronDwarf" }, -- Southern Barrens, The Great Divide
        [55493381] = { icon="molemachine", label=GetAreaInfo(5040), requirements={quest=53601, hideQuestName=true}, race="DarkIronDwarf" }, -- Mount Hyjal, Throne of Flame
        [62105419] = { icon="boat", label=BtoZuldazar, note=Zandalar, faction="Horde" },
        [62105420] = { icon="boat", label=BtoZuldazar, note=Zandalar, faction="Alliance" },
        [59764474] = { icon="zeppelin", label=ZtoDI, note=WakingShores, faction="Horde" },
        [59764475] = { icon="hzeppelin", label=ZtoDI, note=WakingShores, faction="Alliance" },
        [40076789] = { icon="portal", label=PtoBelameth, note=Amirdrassil, faction="Alliance" },
        [47611994] = { icon="portal", label=PtoBelameth, note=Amirdrassil, faction="Alliance" },
        [57724362] = { icon="portal", multilabel={L["Portal to The Nighthold"], L["Portal to Thunder Totem"]}, multinote={Suramar, Highmountain}, requirements={multilevel={10, 10}}, faction="Horde" },
        [52073142] = { icon="portal", label=L["Portal to the Firelands"], note=MoltenFront, requirements={quest=29201} }
        },
    [7] = { -- Mulgore
        [33692368] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [33692369] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" }
        },
    [88] = { -- Thunder Bluff
        [14222574] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [14222575] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" }
        },
    [1] = { -- Durotar
        [48091027] = { icon="portal", multilabel={PtoDala, PtoSM, PtoJadeForest, PtoZuldazar, PtoAzsuna, PtoWarspear, PtoShattrath, PtoCavernsofTime, PtoOribos, PtoValdrakken, PtoDornogal},
                                    multinote={CrystalsongForest, EversongWoods, Pandaria, Zandalar, BrokenIsles, Ashran, TerokkarForest, Tanaris, Shadowlands, Thaldraszus, IsleOfDorn},
                                    requirements={multiquest={[4]=46931, [9]=60151}, multiaccquest={[4]=true, [9]=true}, multilevel={[10]=10}}, faction="Horde" },
        [45550380] = { icon="hzeppelin", multilabel={ZtoTB, ZtoStranglethornVale, ZtoBoreanTundra}, multinote={Mulgore, GromgolBaseCamp, WarsongHold}, faction="Alliance" },
        [45550381] = { icon="zeppelin", multilabel={ZtoTB, ZtoStranglethornVale, ZtoBoreanTundra}, multinote={Mulgore, GromgolBaseCamp, WarsongHold}, faction="Horde" },
        [46980375] = { icon="portal", multilabel={PtoTolBarad, PtoUldum, PtoDeepholm, PtoVashjir, PtoHyjal, PtoTwilightHighlands, PtoUC}, multinote={EasternKingdoms, Kalimdor, Maelstrom, EasternKingdoms, Kalimdor, EasternKingdoms, Tirisfal}, requirements={multiquest={[4]=25924, [6]=26798}, multiaccquest={[6]=true}, multilevel={30, 30, 30, 30, 30, 30}}, faction="Horde" },
        [72337930] = { icon="boat", label=BtoZuldazar, note=Zandalar, faction="Horde" },
        [72337931] = { icon="boat", label=BtoZuldazar, note=Zandalar, faction="Alliance" },
        [35587972] = { icon="boat", label=BtoBootyBay, note=StranglethornCape },
        [56041350] = { icon="zeppelin", label=ZtoDI, note=WakingShores, faction="Horde" },
        [56041351] = { icon="hzeppelin", label=ZtoDI, note=WakingShores, faction="Alliance" },
        [41890572] = { icon="portal", multilabel={L["Portal to The Nighthold"], L["Portal to Thunder Totem"]}, multinote={Suramar, Highmountain}, requirements={multilevel={10, 10}}, faction="Horde" },
        -- [46880595] = { icon="portal", label=PtoDala, note=BrokenIsles, faction="Horde" }
        },
    [463] = { -- Echo Isle
        [71713838] = { icon="boat", label=BtoZuldazar, note=Zandalar, faction="Horde" },
        [71713839] = { icon="boat", label=BtoZuldazar, note=Zandalar, faction="Alliance" }
        },
    [85] = { -- Orgrimmar
        [57438972] = { icon="portal", multilabel={PtoDala, PtoSM, PtoJadeForest, PtoZuldazar, PtoAzsuna, PtoWarspear, PtoShattrath, PtoCavernsofTime, PtoOribos, PtoValdrakken, PtoDornogal}, multinote={CrystalsongForest, EversongWoods, Pandaria, Zandalar, BrokenIsles, Ashran, TerokkarForest, Tanaris, Shadowlands, Thaldraszus, IsleOfDorn}, requirements={multiquest={[4]=46931, [9]=60151}, multiaccquest={[4]= true, [9]=true}, multilevel={[10]=10}}, faction="Horde" },
        [50725559] = { icon="portal", label=PtoUC, note=Tirisfal, faction="Horde" },
        [42866518] = { icon="zeppelin", label=ZtoTB, note=Mulgore, faction="Horde" },
        [42866517] = { icon="hzeppelin", label=ZtoTB, note=Mulgore, faction="Alliance" },
        [50103773] = { icon="portal", multilabel={PtoTolBarad, PtoUldum, PtoDeepholm, PtoVashjir, PtoHyjal, PtoTwilightHighlands}, multinote={EasternKingdoms, Kalimdor, Maelstrom, EasternKingdoms, Kalimdor, EasternKingdoms}, requirements={multiquest={[4]=25924, [6]=26798}, multiaccquest={[6]=true}, multilevel={30, 30, 30, 30, 30, 30}}, faction="Horde" },
                                    -- TolBarad at level 30
                                    -- other portals at level ?? Shadowlands
        [45306178] = { icon="hzeppelin", label=ZtoBoreanTundra, note=WarsongHold, faction="Alliance" },
        [45306179] = { icon="zeppelin", label=ZtoBoreanTundra, note=WarsongHold, faction="Horde" },
        [52885242] = { icon="hzeppelin", label=ZtoStranglethornVale, note=GromgolBaseCamp, faction="Alliance" },
        [52885243] = { icon="zeppelin", label=ZtoStranglethornVale, note=GromgolBaseCamp, faction="Horde" },
        [38587589] = { icon="portal", label=L["Portal to The Nighthold"], note=Suramar, requirements={level=10}, faction="Horde" },
        [38157528] = { icon="portal", label=L["Portal to Thunder Totem"], note=Highmountain, requirements={level=10}, faction="Horde" },
        -- [53747657] = { icon="portal", label=PtoDala, note=BrokenIsles, faction="Horde" }
        },
    [71] = { -- Tanaris
        [65794954] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [65924954] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [17660804] = { icon="portal", label=WtoSholazarBasin, note=Northrend, requirements={quest=12613} },
        [18873268] = { icon="molemachine", label=GetAreaInfo(537), requirements={quest=53591, hideQuestName=true}, race="DarkIronDwarf" } -- Un'Goro Crater, Fire Plume Ridge
        },
    [74] = { -- Cavern of Time
        [58202660] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde" },
        [59002670] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance" }
        },
    [81] = { -- Silithus
        [41604520] = { icon="portal", requirements={quest=46931, accquest=true, level=50, timetravel={quest=50659, spell=255152, turn=true}}, label=PtoZuldazar, note=Zandalar, faction="Horde" },
        [41474479] = { icon="portal", requirements={level=50, timetravel={quest=50659, spell=255152, turn=true}}, label=PtoBoralus, note=TiragardeSound, faction="Alliance" }
        },
    [70] = { -- Dustwallow Marsh
        [71625648] = { icon="aboat", label=BtoMenethilHarbor, note=Wetlands, faction="Horde" },
        [71625647] = { icon="boat", label=BtoMenethilHarbor, note=Wetlands, faction="Alliance" }
        },
    [62] = { -- Darkshore
        [48023627] = { icon="portal", requirements={level=50, warfront=118, timetravel={quest=54411, spell=290245}}, label=PtoPortofBoralus, note=TiragardeSound, faction="Alliance" },
        [46243511] = { icon="portal", requirements={level=50, warfront=118, timetravel={quest=54411, spell=290245}}, label=PtoPortofZandalar, note=Zuldazar, faction="Horde" },
        [53691871] = { icon="portal", label=PtoBelameth, note=Amirdrassil, faction="Alliance" }
        },
    [89] = { -- Darnassus
        [44247867] = { icon="portal", requirements={timetravel={quest=54411, spell=290245}}, multilabel={PtoExodar, PtoHellfirePeninsula}, multinote={AzuremystIsle, Outland}, faction="Alliance" }
        },
    [57] = { -- Teldrassil
        [29085646] = { icon="portal", requirements={timetravel={quest=54411, spell=290245}}, multilabel={PtoExodar, PtoHellfirePeninsula}, multinote={AzuremystIsle, Outland}, faction="Alliance" },
        [55009370] = { icon="portal", requirements={timetravel={quest=54411, spell=290245}}, label=PtoSW, note=ElwynnForest, faction="Alliance" },
        [52048951] = { icon="portal", requirements={timetravel={quest=54411, spell=290245}}, label=PtoExodar, note=AzuremystIsle }
        },
    [56] = { -- Wetlands
        [06216261] = { icon="aboat", label=BtoTheramore, note=DustwallowMarsh, faction="Horde" },
        [06216260] = { icon="boat", label=BtoTheramore, note=DustwallowMarsh, faction="Alliance" },
        [04415718] = { icon="aboat", label=BtoHowlingFjord, note=Valgarde, faction="Horde" },
        [04415717] = { icon="boat", label=BtoHowlingFjord, note=Valgarde, faction="Alliance" }
        },
    [78] = { -- Un'Goro Crater
        [50520774] = { icon="portal", label=WtoSholazarBasin, note=Northrend, requirements={quest=12613} },
        [52885576] = { icon="molemachine", label=GetAreaInfo(537), requirements={quest=53591, hideQuestName=true}, race="DarkIronDwarf" } -- Un'Goro Crater, Fire Plume Ridge
        },
    [64] = { -- Thousand Needles
        [20517469] = { icon="portal", label=WtoSholazarBasin, note=Northrend, requirements={quest=12613} }
        },
    [69] = { -- Feralas
        [51341058] = { icon="orderhall", label=PtoEmeraldDreamway, note=valsharahBrokenIsles, class="DRUID" },
        [44914274] = { icon="portal", label=PtoBelameth, note=Amirdrassil, faction="Alliance" }
        },
    [80] = { -- Moonglade
        [68006025] = { icon="orderhall", label=PtoEmeraldDreamway, note=valsharahBrokenIsles, class="DRUID" }
        },
    [199] = { -- Southern Barrens
        [39110930] = { icon="molemachine", label=GetAreaInfo(5385), requirements={quest=53600, hideQuestName=true}, race="DarkIronDwarf" }, -- Southern Barrens, The Great Divide
        [70152440] = { icon="boat", label=BtoBootyBay, note=StranglethornCape },
        [96362409] = { icon="boat", label=BtoZuldazar, note=Zandalar, faction="Horde" },
        [96362408] = { icon="boat", label=BtoZuldazar, note=Zandalar, faction="Alliance" }
        },
    [10] = { -- Northern Barrens
        [70417340] = { icon="boat", label=BtoBootyBay, note=StranglethornCape },
        [30365394] = { icon="molemachine", label=GetAreaInfo(5385), requirements={quest=53600, hideQuestName=true}, race="DarkIronDwarf" }, -- Southern Barrens, The Great Divide
        [89241247] = { icon="zeppelin", label=ZtoDI, note=WakingShores, faction="Horde" },
        [89241248] = { icon="hzeppelin", label=ZtoDI, note=WakingShores, faction="Alliance" }
        },
    [210] = { -- Cape of Stranglethorn
        [38736678] = { icon="boat", label=BtoRatchet, note=NorthernBarrens }
        },
    [13] = { -- Eastern Kingdom
        [44058706] = { icon="zeppelin", multilabel={ZtoOG, PtoUC}, multinote={Durotar, Tirisfal}, faction="Horde" },
        [44058707] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" },
        [41107209] = { icon="aboat", multilabel={BtoBoreanTundra, BtoBoralus, BtoDI}, multinote={ValianceKeep, TiragardeSound, WakingShores}, faction="Horde" },
        [41107210] = { icon="boat", multilabel={PtoDarnassus, BtoBoreanTundra, BtoBoralus, BtoDI }, multinote={Teldrassil, ValianceKeep, TiragardeSound, WakingShores }, faction="Alliance" },
        [45995488] = { icon="aboat", multilabel={BtoTheramore, BtoHowlingFjord}, multinote={DustwallowMarsh, Valgarde}, faction="Horde" },
        [45995482] = { icon="boat", multilabel={BtoTheramore, BtoHowlingFjord}, multinote={DustwallowMarsh, Valgarde}, faction="Alliance" },
        [43179373] = { icon="boat", label=BtoRatchet, note=NorthernBarrens },
        [56161316] = { icon="portal", multilabel={PtoOG, PtoUC}, multinote={Durotar, Tirisfal}, faction="Horde" },
        [43637155] = { icon="portal", multilabel={PtoTolBarad, PtoUldum, PtoDeepholm, PtoVashjir, PtoHyjal, PtoTwilightHighlands, DrTtoIF, PtoDarnassus, PtoDala, PtoJadeForest, PtoBoralus, PtoAzsuna, PtoStormshield, PtoShattrath, PtoExodar, PtoCavernsofTime, PtoOribos, PtoValdrakken, PtoBelameth, PtoDornogal},
                                    multinote={EasternKingdoms, Kalimdor, Maelstrom, EasternKingdoms, Kalimdor, EasternKingdoms, DunMorogh, Teldrassil, CrystalsongForest, Pandaria, TiragardeSound, BrokenIsles, Ashran, TerokkarForest, AzuremystIsle, Tanaris, Shadowlands, Thaldraszus, Amirdrassil, IsleOfDorn},
                                    requirements={multiquest={[4]=14482, [6]=26798, [11]=47186, [17]=60151}, multiaccquest={[6]=true, [11]=true, [17]=true}, multilevel={1, 30, 30, 30, 30, 30, [18]=10}},
                                    faction="Alliance" },
        [43337195] = { icon="tram", label=DrTtoIF, note=DunMorogh, faction="Horde" },
        [43863354] = { icon="portal", requirements={timetravel={quest=52758, spell=276824}, multilevel={[4]=10}}, multilabel={PtoOG, PtoSM, PtoStranglethornVale, PtoHellfirePeninsula, PtoHowlingFjord}, multinote={Durotar, EversongWoods..") ("..Orboftranslocation, GromgolBaseCamp, Outland, VengeanceLanding}, faction="Horde" },
        [47835898] = { icon="tram", label=DrTtoSW, note=ElwynnForest },
        [60875918] = { icon="portal", label=PtoSW, note=ElwynnForest, requirements={quest=27537}, faction="Alliance" },
        [35224839] = { icon="portal", label=PtoSW, note=ElwynnForest, requirements={level=30}, faction="Alliance" },
        [60115603] = { icon="portal", label=PtoOG, note=Durotar, requirements={quest=26798}, faction="Horde" },
        [34394957] = { icon="portal", label=PtoOG, note=Durotar, requirements={level=30}, faction="Horde" },
        [57663241] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="PALADIN" },
        [49714419] = { icon="portal", requirements={level=50, warfront=11, timetravel={quest=52781, spell=276950}}, label=PtoPortofZandalar, note=Zuldazar, faction="Horde" },
        [49244725] = { icon="portal", requirements={level=50, warfront=11, timetravel={quest=52781, spell=276950}}, label=PtoPortofBoralus, note=TiragardeSound, faction="Alliance" },
        [41003949] = { icon="portal", label=PtoDalaCrater, note=HillsbradFoothills, faction="Horde", requirements={quest=27478} },
        [43674008] = { icon="portal", label=PtoSepulcher, note=SilverpineForest, faction="Horde", requirements={quest=27478} },
        [45647931] = { icon="orderhall", label=PtoEmeraldDreamway, note=valsharahBrokenIsles, class="DRUID" },
        [54353790] = { icon="orderhall", label=PtoEmeraldDreamway, note=valsharahBrokenIsles, class="DRUID" },
        [43077220] = { icon="molemachine", label=GetAreaInfo(6816), race="DarkIronDwarf" }, -- Stormwind
        [46726015] = { icon="molemachine", label=GetAreaInfo(1537), race="DarkIronDwarf" }, -- Ironforge
        [49754018] = { icon="molemachine", label=GetAreaInfo(348), requirements={quest=53585, hideQuestName=true}, race="DarkIronDwarf" }, -- The Hinterlands, Aerie Peak
        [53108129] = { icon="molemachine", label=GetAreaInfo(1438), requirements={quest=53594, hideQuestName=true}, race="DarkIronDwarf" }, -- Blasted Lands, Nethergarde Keep
        [46766773] = { icon="molemachine", label=TheMasonary, requirements={quest=53587, hideQuestName=true}, race="DarkIronDwarf" }, -- Black Rock Mountains, The Masonary
        [54068459] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde", requirements={timetravel={quest=66560, spell=290245, turn=true, level=10}, level=10} },
        [53508266] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance", requirements={timetravel={quest=66560, spell=290245, turn=true, level=10}, level=10} },
        [41075058] = { icon="boat", label=BtoBelanaar, note=Amirdrassil }
        },
    [84] = { -- Stormwind City
        [74481841] = { icon="portal", multilabel={PtoTolBarad, PtoUldum, PtoDeepholm, PtoVashjir, PtoHyjal, PtoTwilightHighlands}, multinote={EasternKingdoms, Kalimdor, Maelstrom, EasternKingdoms, Kalimdor, EasternKingdoms}, requirements={multiquest={[4]=14482}, multilevel={1, 30, 30, 30, 30, 30}}, faction="Alliance" },
        [46419032] = { icon="portal", multilabel={PtoDala, PtoJadeForest, PtoBoralus, PtoAzsuna, PtoStormshield, PtoShattrath, PtoExodar, PtoCavernsofTime, PtoOribos, PtoValdrakken, PtoDornogal},
                                    multinote={CrystalsongForest, Pandaria, TiragardeSound, BrokenIsles, Ashran, TerokkarForest, AzuremystIsle, Tanaris, Shadowlands, Thaldraszus, IsleOfDorn},
                                    requirements={multiquest={[3]=47186, [9]=60151}, multiaccquest={[3]=true, [9]=true}, multilevel={[10]=10}},
                                    faction="Alliance" },
        [22015670] = { icon="aboat", multilabel={BtoBoralus, BtoDI}, multinote={TiragardeSound, WakingShores}, faction="Horde" },
        [22015671] = { icon="boat", multilabel={BtoBoralus, BtoDI}, multinote={TiragardeSound, WakingShores}, faction="Alliance" },
        [17592553] = { icon="aboat", label=BtoBoreanTundra, note=ValianceKeep, faction="Horde" },
        [17592554] = { icon="boat", label=BtoBoreanTundra, note=ValianceKeep, faction="Alliance" },
        [23805620] = { icon="portal", label=PtoDarnassus, note=Teldrassil, faction="Alliance" },
        [69403140] = { icon="tram", label=DrTtoIF, note=DunMorogh },
        [63333734] = { icon="molemachine", label=GetAreaInfo(6816), race="DarkIronDwarf" }, -- Stormwind
        [43289760] = { icon="portal", label=PtoBelameth, note=Amirdrassil, faction="Alliance" }
        },
    [499] = { -- Deeprun Tram
        [42554350] = { icon="tram", label=DrTtoIF, note=DunMorogh },
        [42556750] = { icon="tram", label=DrTtoIF, note=DunMorogh }
        },
    [37] = { -- Elwynn Forest
        [17804775] = { icon="portal", multilabel={PtoDala, PtoJadeForest, PtoBoralus, PtoAzsuna, PtoStormshield, PtoShattrath, PtoExodar, PtoCavernsofTime, PtoOribos, PtoValdrakken, PtoDornogal},
                                    multinote={CrystalsongForest, Pandaria, TiragardeSound, BrokenIsles, Ashran, TerokkarForest, AzuremystIsle, Tanaris, Shadowlands, Thaldraszus, IsleOfDorn},
                                    requirements={multiquest={[3]=47186, [9]=60151}, multiaccquest={[3]=true, [9]=true}, multilevel={[10]=10}},
                                    faction="Alliance" },
        [06003035] = { icon="aboat", multilabel={BtoBoralus, BtoDI}, multinote={TiragardeSound, WakingShores}, faction="Horde" },
        [06003036] = { icon="boat", multilabel={BtoBoralus, BtoDI}, multinote={TiragardeSound, WakingShores}, faction="Alliance" },
        [03631530] = { icon="aboat", label=BtoBoreanTundra, note=ValianceKeep, faction="Horde" },
        [03631531] = { icon="boat", label=BtoBoreanTundra, note=ValianceKeep, faction="Alliance" },
        [07253035] = { icon="portal", label=PtoDarnassus, note=Teldrassil, faction="Alliance" },
        [31801155] = { icon="portal", multilabel={PtoTolBarad, PtoUldum, PtoDeepholm, PtoVashjir, PtoHyjal, PtoTwilightHighlands}, multinote={EasternKingdoms, Kalimdor, Maelstrom, EasternKingdoms, Kalimdor, EasternKingdoms}, requirements={multiquest={[4]=14482}, multilevel={1, 30, 30, 30, 30, 30}}, faction="Alliance" },
        [29251812] = { icon="tram", label=DrTtoIF, note=DunMorogh },
        [26292111] = { icon="molemachine", label=GetAreaInfo(6816), race="DarkIronDwarf" }, -- Stormwind
        [46726015] = { icon="molemachine", label=GetAreaInfo(1537), race="DarkIronDwarf" } -- Ironforge
        },
    [90] = { -- Undercity
        [85301700] = { icon="portal", requirements={timetravel={quest=52758, spell=276824}, level=10}, label=PtoHellfirePeninsula, note=Outland, faction="Horde" }
        },
    [18] = { -- Tirisfal Glades
        [65906865] = { icon="portal", requirements={timetravel={quest=52758, spell=276824}, level=10}, label=PtoHellfirePeninsula, note=Outland..")\n("..inUCMq.."", faction="Horde" },
        [59416743] = { icon="portal", requirements={timetravel={quest=52758, spell=276824}}, label=PtoSM, note=EversongWoods..")\n("..Orboftranslocation.."", faction="Horde" },
        [60735867] = { icon="portal", requirements={timetravel={quest=52758, spell=276824}}, label=PtoOG, note=Durotar, faction="Horde" },
        [61885901] = { icon="portal", requirements={timetravel={quest=52758, spell=276824}}, label=PtoStranglethornVale, note=GromgolBaseCamp, faction="Horde" },
        [59085890] = { icon="portal", requirements={timetravel={quest=52758, spell=276824}}, label=PtoHowlingFjord, note=VengeanceLanding, faction="Horde" }
        },
    [2070] = { -- Tirisfal Glades - Ruins of Lordaeron
        [59856745] = { icon="portal", requirements={quest=65667}, multilabel={PtoOG, PtoSM, PtoStranglethornVale, PtoHowlingFjord}, multinote={Durotar, EversongWoods..") ("..Orboftranslocation, GromgolBaseCamp, VengeanceLanding}, faction="Horde" }
        },
    [21] = { -- Silverpine Forest
        [47254337] = { icon="portal", label=PtoDalaCrater, note=HillsbradFoothills, faction="Horde", requirements={quest=27478} }
        },
    [25] = { -- Hillsbrad Foothills
        [30293662] = { icon="portal", label=PtoSepulcher, note=SilverpineForest, faction="Horde", requirements={quest=27478} }
        },
    [14] = { -- Arathi Highlands
        [27432937] = { icon="portal", requirements={level=50, warfront=11, timetravel={quest=52781, spell=276950}}, label=PtoPortofZandalar, note=Zuldazar, faction="Horde" },
        [21956514] = { icon="portal", requirements={level=50, warfront=11, timetravel={quest=52781, spell=276950}}, label=PtoPortofBoralus, note=TiragardeSound, faction="Alliance" }
        },
    [50] = { -- Northern Stranglethorn
        [37045281] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" },
        [37045282] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [37545099] = { icon="portal", label=PtoUC, note=Tirisfal, faction="Horde" }
        },
    [224] = { -- Stranglethorn Vale
        [42003423] = { icon="hzeppelin", label=ZtoOG, note=Durotar, faction="Alliance" },
        [42003424] = { icon="zeppelin", label=ZtoOG, note=Durotar, faction="Horde" },
        [42313309] = { icon="portal", label=PtoUC, note=Tirisfal, faction="Horde" },
        [36577574] = { icon="boat", label=BtoRatchet, note=NorthernBarrens }
        },
    [23] = { -- Eastern Plaguelands
        [75234942] = { icon="orderhall", label=PtoDala, note=BrokenIsles, class="PALADIN" }
        },
    [27] = { -- Dun Morogh
        [70452731] = { icon="tram", label=DrTtoSW, note=ElwynnForest },
        [61293718] = { icon="molemachine", label=GetAreaInfo(1537), race="DarkIronDwarf" } -- Ironforge
        },
    [87] = { -- Ironforge
        [76205120] = { icon="tram", label=DrTtoSW, note=ElwynnForest }
        },
    [17] = { -- Blasted Lands
        [72654951] = { icon="portal", label=PtoOG, note=Durotar, faction="Horde", requirements={timetravel={quest=66560, spell=290245, turn=true, level=10}, level=10} },
        [66382798] = { icon="portal", label=PtoSW, note=ElwynnForest, faction="Alliance", requirements={timetravel={quest=66560, spell=290245, turn=true, level=10}, level=10} },
        [61971280] = { icon="molemachine", label=GetAreaInfo(1438), requirements={quest=53594, hideQuestName=true}, race="DarkIronDwarf" } -- Blasted Lands, Nethergarde Keep
        },
    [26] = { -- The Hinterlands
        [62272262] = { icon="orderhall", label=PtoEmeraldDreamway, note=valsharahBrokenIsles, class="DRUID" },
        [13534680] = { icon="molemachine", label=GetAreaInfo(348), requirements={quest=53585, hideQuestName=true}, race="DarkIronDwarf" } -- The Hinterlands, Aerie Peak
        },
    [47] = { -- Duskwood
        [46573561] = { icon="orderhall", label=PtoEmeraldDreamway, note=valsharahBrokenIsles, class="DRUID" }
        },
    [32] = { -- Searing Gorge
        [25017479] = { icon="molemachine", label=TheMasonary, requirements={quest=53587, hideQuestName=true}, race="DarkIronDwarf" } -- Black Rock Mountains, The Masonary
        },
    [35] = { -- Blackrock Mountain
        [33302480] = { icon="molemachine", label=TheMasonary, requirements={quest=53587, hideQuestName=true}, race="DarkIronDwarf" } -- Black Rock Mountains, The Masonary
        },
    [36] = { -- Burning Steppes
        [13211081] = { icon="molemachine", label=TheMasonary, note=inBRM, requirements={quest=53587, hideQuestName=true}, race="DarkIronDwarf" } -- Black Rock Mountains, The Masonary
        },
    [1186] = { -- Blackrock Depths
        [61432434] = { icon="molemachine", label=DUNGEON_FLOOR_BLACKROCKDEPTHS2, race="DarkIronDwarf" }, -- Shadowforge City
        [59322639] = { icon="molemachine", npc=143567, race="DarkIronDwarf" }
        },
    [947] = { -- Azeroth
        [84546356] = { icon="molemachine", label=GetAreaInfo(6816), race="DarkIronDwarf" }, -- Stormwind
        [86505711] = { icon="molemachine", label=GetAreaInfo(1537), race="DarkIronDwarf" }, -- Ironforge
        [88124642] = { icon="molemachine", label=GetAreaInfo(348), requirements={quest=53585, hideQuestName=true}, race="DarkIronDwarf" }, -- The Hinterlands, Aerie Peak
        [89916842] = { icon="molemachine", label=GetAreaInfo(1438), requirements={quest=53594, hideQuestName=true}, race="DarkIronDwarf" }, -- Blasted Lands, Nethergarde Keep
        [86526116] = { icon="molemachine", label=TheMasonary, requirements={quest=53587, hideQuestName=true}, race="DarkIronDwarf" }, -- Black Rock Mountains, The Masonary
        [17866821] = { icon="molemachine", label=GetAreaInfo(537), requirements={quest=53591, hideQuestName=true}, race="DarkIronDwarf" }, -- Un'Goro Crater, Fire Plume Ridge
        [18025454] = { icon="molemachine", label=GetAreaInfo(5385), requirements={quest=53600, hideQuestName=true}, race="DarkIronDwarf" }, -- Southern Barrens, The Great Divide
        [20364633] = { icon="molemachine", label=GetAreaInfo(5040), requirements={quest=53601, hideQuestName=true}, race="DarkIronDwarf" }, -- Mount Hyjal, Throne of Flame
        [47448610] = { icon="molemachine", label=GetAreaInfo(5963), requirements={quest=53598, hideQuestName=true}, race="DarkIronDwarf" }, -- Valley of the Four Winds, Stormstout Brewery
        [47757762] = { icon="molemachine", label=GetAreaInfo(6085), requirements={quest=53595, hideQuestName=true}, race="DarkIronDwarf" }, -- Kun-Lai Summit, One Keg
        [48931729] = { icon="molemachine", label=GetAreaInfo(4168), requirements={quest=53596, hideQuestName=true}, race="DarkIronDwarf" }, -- Dragonblight, Ruby Dragonshrine
        [49580743] = { icon="molemachine", label=GetAreaInfo(4658), requirements={quest=53586, hideQuestName=true}, race="DarkIronDwarf" }, -- Icecrown, Argent Tournament Grounds
        [61364663] = { icon="molemachine", label=GetAreaInfo(7543), requirements={quest=53589, hideQuestName=true}, race="DarkIronDwarf" }, -- The Broken Shore, Broken Shore
        [58493800] = { icon="molemachine", label=GetAreaInfo(7806), requirements={quest=53593, hideQuestName=true}, race="DarkIronDwarf" }, -- Highmountain, Neltharion's Vault
        [54695942] = { icon="molemachine", label=GetAreaInfo(8966), requirements={quest=80099, hideQuestName=true}, race="DarkIronDwarf" }, -- Zalamar
        [53626836] = { icon="molemachine", label=GetAreaInfo(8965), requirements={quest=80100, hideQuestName=true}, race="DarkIronDwarf" }, -- Xibala
        [74865326] = { icon="molemachine", label=GetAreaInfo(9135), requirements={quest=80101, hideQuestName=true}, race="DarkIronDwarf" }, -- The Wailing Tideway
        [73214285] = { icon="molemachine", label=GetAreaInfo(9623), requirements={quest=80102, hideQuestName=true}, race="DarkIronDwarf" }, -- Tidebreak Summit
        [75401781] = { icon="molemachine", label=GetAreaInfo(14012), requirements={quest=80107, hideQuestName=true}, race="DarkIronDwarf" }, -- The Slagmire
        [80162617] = { icon="molemachine", label=GetAreaInfo(14017), requirements={quest=80108, hideQuestName=true}, race="DarkIronDwarf" }, -- Vakthros Summit
        [77172118] = { icon="molemachine", label=GetAreaInfo(14655), requirements={quest=80109, hideQuestName=true}, race="DarkIronDwarf" } -- Obsidian Rest
        }
    -- https://de.wowhead.com/spell=265225/maulwurfmaschine#english-comments
}
