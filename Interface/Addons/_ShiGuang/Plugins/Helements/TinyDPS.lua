--[[
Name: LibBossIDs-1.0
Revision: $Revision: 104 $
Author: Elsia
Website: http://www.wowace.com/addons/libbossids-1-0/
Documentation:
SVN: svn://svn.wowace.com/wow/libbossids-1-0/mainline/trunk
Description: Provide a table of mobIDs that belong to boss mobs (instance bosses, raid bosses, world bosses)
Dependencies: LibStub
License: Public Domain, Absolutely no Warranty.
]]

local BossIDs = {
	-------------------------------------------------------------------------------
	-- Abyssal Maw: Throne of the Tides
	-------------------------------------------------------------------------------
	[40586]	= true,	-- Lady Naz'jar
	[40765]	= true,	-- Commander Ulthok
	[40825]	= true,	-- Erunak Stonespeaker
	[40788]	= true,	-- Mindbender Ghur'sha
	[42172]	= true,	-- Ozumat? Not in heroic! /Mikk
	[44566]	= true,	-- Ozumat - confirmed in heroic! /Mikk

	-------------------------------------------------------------------------------
	-- Ahn'kahet: The Old Kingdom
	-------------------------------------------------------------------------------
	[29309]	= true,	-- Elder Nadox
	[29308]	= true,	-- Prince Taldaram (Ahn'kahet: The Old Kingdom)
	[29310]	= true,	-- Jedoga Shadowseeker
	[29311]	= true,	-- Herald Volazj
	[30258]	= true,	-- Amanitar (Heroic)

	-------------------------------------------------------------------------------
	-- Auchindoun
	-------------------------------------------------------------------------------
	[75839]	= true,	-- Vigilant Kaathar
	[76177]	= true,	-- Soulbinder Nyami
	[75927]	= true,	-- Azzakel
	[77734]	= true,	-- Teron'gor

	-------------------------------------------------------------------------------
	-- Auchindoun: Auchenai Crypts
	-------------------------------------------------------------------------------
	[18371]	= true,	-- Shirrak the Dead Watcher
	[18373]	= true,	-- Exarch Maladaar

	-------------------------------------------------------------------------------
	-- Auchindoun: Mana-Tombs
	-------------------------------------------------------------------------------
	[18341]	= true,	-- Pandemonius
	[18343]	= true,	-- Tavarok
	[22930]	= true,	-- Yor (Heroic)
	[18344]	= true,	-- Nexus-Prince Shaffar

	-------------------------------------------------------------------------------
	-- Auchindoun: Sethekk Halls
	-------------------------------------------------------------------------------
	[18472]	= true,	-- Darkweaver Syth
	[23035]	= true,	-- Anzu (Heroic)
	[18473]	= true,	-- Talon King Ikiss

	-------------------------------------------------------------------------------
	-- Auchindoun: Shadow Labyrinth
	-------------------------------------------------------------------------------
	[18731]	= true,	-- Ambassador Hellmaw
	[18667]	= true,	-- Blackheart the Inciter
	[18732]	= true,	-- Grandmaster Vorpil
	[18708]	= true,	-- Murmur

	-------------------------------------------------------------------------------
	-- Azjol-Nerub
	-------------------------------------------------------------------------------
	[28684]	= true,	-- Krik'thir the Gatewatcher
	[28921]	= true,	-- Hadronox
	[29120]	= true,	-- Anub'arak

	-------------------------------------------------------------------------------
	-- Azshara
	-------------------------------------------------------------------------------
	[14464]	= true,	-- Avalanchion
	[6109]	= true,	-- Azuregos

	-------------------------------------------------------------------------------
	-- Black Temple
	-------------------------------------------------------------------------------
	[22887]	= true,	-- High Warlord Naj'entus
	[22898]	= true,	-- Supremus
	[22841]	= true,	-- Shade of Akama
	[22871]	= true,	-- Teron Gorefiend
	[22948]	= true,	-- Gurtogg Bloodboil
	[23420]	= true,	-- Essence of Anger
	[23419]	= true,	-- Essence of Desire
	[23418]	= true,	-- Essence of Suffering
	[22947]	= true,	-- Mother Shahraz
	[23426]	= true,	-- Illidari Council
	[22917]	= true,	-- Illidan Stormrage	-- Not adding solo quest IDs for now
	[22949]	= true,	-- Gathios the Shatterer
	[22950]	= true,	-- High Nethermancer Zerevor
	[22951]	= true,	-- Lady Malande
	[22952]	= true,	-- Veras Darkshadow

	-------------------------------------------------------------------------------
	-- Baradin Hold
	-------------------------------------------------------------------------------
	[47120]	= true,	-- Argaloth
	[52363]	= true,	-- Occu'thar
	[55869]	= true,	-- Alizabal (4.3)

	-------------------------------------------------------------------------------
	-- Blackfathom Deeps
	-------------------------------------------------------------------------------
	[4829]	= true,	-- Aku'mai
	[4830]	= true,	-- Old Serra'kis
	[4831]	= true,	-- Lady Sarevess
	[4832]	= true,	-- Twilight Lord Kelris
	[4887]	= true,	-- Ghamoo-ra
	[6243]	= true,	-- Gelihast
	[12876]	= true,	-- Baron Aquanis
	[12902]	= true,	-- Lorgus Jett

	-------------------------------------------------------------------------------
	-- Blackrock Depths: Detention Block
	-------------------------------------------------------------------------------
	[9018]	= true,	-- High Interrogator Gerstahn

	-------------------------------------------------------------------------------
	-- Blackrock Depths: Grim Guzzler
	-------------------------------------------------------------------------------
	[9543]	= true,	-- Ribbly Screwspigot
	[9537]	= true,	-- Hurley Blackbreath
	[9502]	= true,	-- Phalanx
	[9499]	= true,	-- Plugger Spazzring
	[23872]	= true,	-- Coren Direbrew

	-------------------------------------------------------------------------------
	-- Blackrock Depths: Halls of the Law
	-------------------------------------------------------------------------------
	[9025]	= true,	-- Lord Roccor
	[9319]	= true,	-- Houndmaster Grebmar

	-------------------------------------------------------------------------------
	-- Blackrock Depths: Inner Blackrock Depths
	-------------------------------------------------------------------------------
	[9156]	= true,	-- Ambassador Flamelash
	[8923]	= true,	-- Panzor the Invincible
	[17808]	= true,	-- Anger'rel
	[9039]	= true,	-- Doom'rel
	[9040]	= true,	-- Dope'rel
	[9037]	= true,	-- Gloom'rel
	[9034]	= true,	-- Hate'rel
	[9038]	= true,	-- Seeth'rel
	[9036]	= true,	-- Vile'rel
	[9938]	= true,	-- Magmus
	[10076]	= true,	-- High Priestess of Thaurissan
	[8929]	= true,	-- Princess Moira Bronzebeard
	[9019]	= true,	-- Emperor Dagran Thaurissan

	-------------------------------------------------------------------------------
	-- Blackrock Depths: Outer Blackrock Depths
	-------------------------------------------------------------------------------
	[9024]	= true,	-- Pyromancer Loregrain
	[9041]	= true,	-- Warder Stilgiss
	[9042]	= true,	-- Verek
	[9476]	= true,	-- Watchman Doomgrip

	[9056]	= true,	-- Fineous Darkvire
	[9017]	= true,	-- Lord Incendius
	[9016]	= true,	-- Bael'Gar
	[9033]	= true,	-- General Angerforge
	[8983]	= true,	-- Golem Lord Argelmach
	-- Dark Keepers, 6 of em: http://www.wowpedia.org/Dark_Keeper

	-------------------------------------------------------------------------------
	-- Blackrock Depths: Ring of Law (Arena)
	-------------------------------------------------------------------------------
	[9031]	= true,	-- Anub'shiah
	[9029]	= true,	-- Eviscerator
	[9027]	= true,	-- Gorosh the Dervish
	[9028]	= true,	-- Grizzle
	[9032]	= true,	-- Hedrum the Creeper
	[9030]	= true,	-- Ok'thor the Breaker
	[16059]	= true,	-- Theldren

	-------------------------------------------------------------------------------
	-- Blackrock Foundry
	-------------------------------------------------------------------------------
	-- Slagworks
	[76877]	= true,	-- Gruul
	[77182]	= true,	-- Oregorger
	[76806]	= true,	-- Blast Furnace - Heart of the Mountain
	[76809]	= true,	-- Blast Furnace - Foreman Feldspar
	-- The Black Forge
	[76973]	= true,	-- Hans'gar & Franzok - Hans'gar
	[76974]	= true,	-- Hans'gar & Franzok - Franzok
	[76814]	= true,	-- Flamebender Ka'graz
	[77692]	= true,	-- Kromog
	-- Iron Assembly
	[76865]	= true,	-- Beastlord Darmac
	[76906]	= true,	-- Operator Thogar
	[77557]	= true,	-- Iron Maidens - Admiral Gar'an
	[77231]	= true,	-- Iron Maidens - Enforcer Sorka
	[77477]	= true,	-- Iron Maidens - Marak the Blooded
	-- Blackhand's Crucible
	[77325]	= true,	-- Blackhand

	-------------------------------------------------------------------------------
	-- Blackrock Mountain: Blackrock Caverns
	-------------------------------------------------------------------------------
	[39665]	= true,	-- Rom'ogg Bonecrusher
	[39679]	= true,	-- Corla, Herald of Twilight
	[39698]	= true,	-- Karsh Steelbender
	[39700]	= true,	-- Beauty
	[39705]	= true,	-- Ascendant Lord Obsidius

	-------------------------------------------------------------------------------
	-- Blackrock Mountain: Blackwing Descent
	-------------------------------------------------------------------------------
	[41570]	= true,	-- Magmaw
	[42166]	= true,	-- Arcanotron
	[42178]	= true,	-- Magmatron
	[42179]	= true,	-- Electron
	[42180]	= true,	-- Toxitron
	[41378]	= true,	-- Maloriak
	[41442]	= true,	-- Atramedes
	[43296]	= true,	-- Chimaeron
	[41376]	= true,	-- Nefarian

	-------------------------------------------------------------------------------
	-- Blackwing Lair
	-------------------------------------------------------------------------------
	[12435]	= true,	-- Razorgore the Untamed
	[13020]	= true,	-- Vaelastrasz the Corrupt
	[12017]	= true,	-- Broodlord Lashlayer
	[11983]	= true,	-- Firemaw
	[14601]	= true,	-- Ebonroc
	[11981]	= true,	-- Flamegor
	[14020]	= true,	-- Chromaggus
	[11583]	= true,	-- Nefarian
	[12557]	= true,	-- Grethok the Controller
	[10162]	= true,	-- Lord Victor Nefarius <Lord of Blackrock> (Also found in Blackrock Spire)

	-------------------------------------------------------------------------------
	-- Bloodmaul Slag Mines
	-------------------------------------------------------------------------------
	[74787]	= true,	-- Slave Watcher Crushto
	[74366]	= true,	-- Forgemaster Gog'duh
	[75786]	= true,	-- Roltall
	[74790]	= true,	-- Gug'rokk

	-------------------------------------------------------------------------------
	-- Black Rook Hold
	-------------------------------------------------------------------------------
	[98542] = true, -- The Amalgam of Souls
	[98696] = true, -- Illysanna Ravencrest
	[98949] = true, -- Smashspite the Hateful
	[98965] = true, -- Lord Kur'talos Ravencrest

	-------------------------------------------------------------------------------
	-- Caverns of Time: Battle for Mount Hyjal
	-------------------------------------------------------------------------------
	[17767]	= true,	-- Rage Winterchill
	[17808]	= true,	-- Anetheron
	[17888]	= true,	-- Kaz'rogal
	[17842]	= true,	-- Azgalor
	[17968]	= true,	-- Archimonde

	-------------------------------------------------------------------------------
	-- Caverns of Time: Culling of Stratholme
	-------------------------------------------------------------------------------
	[26529]	= true,	-- Meathook
	[26530]	= true,	-- Salramm the Fleshcrafter
	[26532]	= true,	-- Chrono-Lord Epoch
	[32273]	= true,	-- Infinite Corruptor
	[26533]	= true,	-- Mal'Ganis
	[29620]	= true,	-- Mal'Ganis

	-------------------------------------------------------------------------------
	-- Caverns of Time: Escape from Durnholde Keep
	-------------------------------------------------------------------------------
	[17848]	= true,	-- Lieutenant Drake
	[17862]	= true,	-- Captain Skarloc
	[18096]	= true,	-- Epoch Hunter
	[28132]	= true,	-- Don Carlos

	-------------------------------------------------------------------------------
	-- Caverns of Time: Opening the Dark Portal
	-------------------------------------------------------------------------------
	[17879]	= true,	-- Chrono Lord Deja
	[17880]	= true,	-- Temporus
	[17881]	= true,	-- Aeonus

	-------------------------------------------------------------------------------
	-- Coilfang Reservoir: Serpentshrine Cavern
	-------------------------------------------------------------------------------
	[21216]	= true,	-- Hydross the Unstable
	[21217]	= true,	-- The Lurker Below
	[21215]	= true,	-- Leotheras the Blind
	[21214]	= true,	-- Fathom-Lord Karathress
	[21213]	= true,	-- Morogrim Tidewalker
	[21212]	= true,	-- Lady Vashj
	[21875]	= true,	-- Shadow of Leotheras

	-------------------------------------------------------------------------------
	-- Coilfang Reservoir: Slave Pens
	-------------------------------------------------------------------------------
	[25740]	= true,	-- Ahune
	[17941]	= true,	-- Mennu the Betrayer
	[17991]	= true,	-- Rokmar the Crackler
	[17942]	= true,	-- Quagmirran

	-------------------------------------------------------------------------------
	-- Coilfang Reservoir: The Steamvault
	-------------------------------------------------------------------------------
	[17797]	= true,	-- Hydromancer Thespia
	[17796]	= true,	-- Mekgineer Steamrigger
	[17798]	= true,	-- Warlord Kalithresh

	-------------------------------------------------------------------------------
	-- Coilfang Reservoir: The Underbog
	-------------------------------------------------------------------------------
	[17770]	= true,	-- Hungarfen
	[18105]	= true,	-- Ghaz'an
	[17826]	= true,	-- Swamplord Musel'ek
	[17827]	= true,	-- Claw <Swamplord Musel'ek's Pet>
	[17882]	= true,	-- The Black Stalker

	-------------------------------------------------------------------------------
	-- Court of Stars
	-------------------------------------------------------------------------------
	[104215] = true, -- Patrol Captain Gerdo
	[104217] = true, -- Talixae Flamewreath
	[104218] = true, -- Advisor Melandrus

	-------------------------------------------------------------------------------
	-- Darkheart Thicket
	-------------------------------------------------------------------------------
	[ 96512] = true, -- Archdruid Glaidalis
	[103344] = true, -- Oakheart
	[ 99200] = true, -- Dresaron
	[ 99192] = true, -- Shade of Xavius

	-------------------------------------------------------------------------------
	-- Dire Maul: Arena
	-------------------------------------------------------------------------------
	[11447]	= true,	-- Mushgog
	[11498]	= true,	-- Skarr the Unbreakable
	[11497]	= true,	-- The Razza

	-------------------------------------------------------------------------------
	-- Dire Maul: East
	-------------------------------------------------------------------------------
	[14354]	= true,	-- Pusillin
	[14327]	= true,	-- Lethtendris
	[14349]	= true,	-- Pimgib
	[13280]	= true,	-- Hydrospawn
	[11490]	= true,	-- Zevrim Thornhoof
	[11492]	= true,	-- Alzzin the Wildshaper
	[16097]	= true,	-- Isalien

	-------------------------------------------------------------------------------
	-- Dire Maul: North
	-------------------------------------------------------------------------------
	[14326]	= true,	-- Guard Mol'dar
	[14322]	= true,	-- Stomper Kreeg
	[14321]	= true,	-- Guard Fengus
	[14323]	= true,	-- Guard Slip'kik
	[14325]	= true,	-- Captain Kromcrush
	[14324]	= true,	-- Cho'Rush the Observer
	[11501]	= true,	-- King Gordok

	-------------------------------------------------------------------------------
	-- Dire Maul: West
	-------------------------------------------------------------------------------
	[11489]	= true,	-- Tendris Warpwood
	[11487]	= true,	-- Magister Kalendris
	[11467]	= true,	-- Tsu'zee
	[11488]	= true,	-- Illyanna Ravenoak
	[14690]	= true,	-- Revanchion (Scourge Invasion)
	[11496]	= true,	-- Immol'thar
	[14506]	= true,	-- Lord Hel'nurath
	[11486]	= true,	-- Prince Tortheldrin

	-------------------------------------------------------------------------------
	-- Drak'Tharon Keep
	-------------------------------------------------------------------------------
	[26630]	= true,	-- Trollgore
	[26631]	= true,	-- Novos the Summoner
	[27483]	= true,	-- King Dred
	[26632]	= true,	-- The Prophet Tharon'ja
	[27696]	= true,	-- The Prophet Tharon'ja

	-------------------------------------------------------------------------------
	-- End Time 4.3
	-------------------------------------------------------------------------------
	[54431]	= true,	-- Echo of Baine
	[54445] = true,	-- Echo of Jaina
	[54123] = true,	-- Echo of Sylvanas
	[54544] = true,	-- Echo of Tyrande
	[54432] = true,	-- Murozond

	-------------------------------------------------------------------------------
	-- Eye of Azshara
	-------------------------------------------------------------------------------
	[91808] = true, -- Serpentrix
	[91784] = true, -- Warlord Parjesh
	[91789] = true, -- Lady Hatecoil
	[91797] = true, -- King Deepbeard
	[96028] = true, -- Wrath of Azshara

	-------------------------------------------------------------------------------
	-- Firelands 4.2 PTR
	-------------------------------------------------------------------------------
	[52530]	= true,	-- Alysrazor
	[53494]	= true,	-- Baleroc
	[52498]	= true,	-- Bethtilac
	[52571]	= true,	-- FandralStaghelm
	[52409]	= true,	-- Ragnaros
	[52558]	= true,	-- Rhyolith
	[53691]	= true,	-- Shannox

	-------------------------------------------------------------------------------
	-- Forge of Souls
	-------------------------------------------------------------------------------
	[36497]	= true,	-- Bronjahm
	[36502]	= true,	-- Devourer of Souls

	-------------------------------------------------------------------------------
	-- Gate of the Setting Sun (MoP-Dungeon 5.0.1)
	-------------------------------------------------------------------------------
	[54432]	= true,	-- Gadok
	[56636]	= true,	-- Rimok
	[56877]	= true,	-- Raigon
	[56906]	= true,	-- Kiptilak

	-------------------------------------------------------------------------------
	-- Gnomeregan
	-------------------------------------------------------------------------------
	[7800]	= true,	-- Mekgineer Thermaplugg
	[7079]	= true,	-- Viscous Fallout
	[7361]	= true,	-- Grubbis
	[6235]	= true,	-- Electrocutioner 6000
	[6229]	= true,	-- Crowd Pummeler 9-60
	[6228]	= true,	-- Dark Iron Ambassador
	[6231]	= true,	-- Techbot, outside

	-------------------------------------------------------------------------------
	-- Gorgrond
	-------------------------------------------------------------------------------
	[81252]	= true,	-- Drov the Ruiner
	[81535]	= true,	-- Tarlna the Ageless

	-------------------------------------------------------------------------------
	-- Grim Batol
	-------------------------------------------------------------------------------
	[39625]	= true,	-- General Umbriss
	[40177]	= true,	-- Forgemaster Throngus
	[40319]	= true,	-- Drahga Shadowburner
	[40484]	= true,	-- Erudax

	-------------------------------------------------------------------------------
	-- Grimrail Depot
	-------------------------------------------------------------------------------
	[77803]	= true,	-- Railmaster Rocketspark
	[77816]	= true,	-- Borka the Brute
	[79545]	= true,	-- Nitrogg Thundertower
	[80005]	= true,	-- Skylord Tovra

	-------------------------------------------------------------------------------
	-- Gruul's Lair
	-------------------------------------------------------------------------------
	[18831]	= true,	-- High King Maulgar
	[19044]	= true,	-- Gruul the Dragonkiller

	-- Gruul's Lair: Maulgar's Ogre Council
	[18835]	= true,	-- Kiggler the Crazed
	[18836]	= true,	-- Blindeye the Seer
	[18834]	= true,	-- Olm the Summoner
	[18832]	= true,	-- Krosh Firehand

	-------------------------------------------------------------------------------
	-- Gundrak
	-------------------------------------------------------------------------------
	[29304]	= true,	-- Slad'ran
	[29305]	= true,	-- Moorabi
	[29307]	= true,	-- Drakkari Colossus
	[29306]	= true,	-- Gal'darah
	[29932]	= true,	-- Eck the Ferocious (Heroic)

	-------------------------------------------------------------------------------
	-- Halls of Lightning
	-------------------------------------------------------------------------------
	[28586]	= true,	-- General Bjarngrim
	[28587]	= true,	-- Volkhan
	[28546]	= true,	-- Ionar
	[28923]	= true,	-- Loken

	-------------------------------------------------------------------------------
	-- Halls of Origination
	-------------------------------------------------------------------------------
	[39425]	= true,	-- Temple Guardian Anhuur
	[39428]	= true,	-- Earthrager Ptah
	[39788]	= true,	-- Anraphet
	[39587]	= true,	-- Isiset
	[39731]	= true,	-- Ammunae
	[39732]	= true,	-- Setesh
	[39378]	= true,	-- Rajh

	-------------------------------------------------------------------------------
	-- Halls of Reflection
	-------------------------------------------------------------------------------
	[38112]	= true,	-- Falric
	[38113]	= true,	-- Marwyn
	[37226]	= true,	-- The Lich King
	[38113]	= true,	-- Marvyn

	-------------------------------------------------------------------------------
	-- Halls of Stone
	-------------------------------------------------------------------------------
	[27977]	= true,	-- Krystallus
	[27975]	= true,	-- Maiden of Grief
	[28234]	= true,	-- The Tribunal of Ages
	[27978]	= true,	-- Sjonnir The Ironshaper

	-------------------------------------------------------------------------------
	-- Halls of Valor
	-------------------------------------------------------------------------------
	[94960] = true, -- Hymdall
	[95833] = true, -- Hyrja
	[95674] = true, -- Fenryr (Phase 1)
	[99868] = true, -- Fenryr (Phase 2)
	[95675] = true, -- God-King Skovald
	[95676] = true, -- Odyn

	-------------------------------------------------------------------------------
	-- Heart of Fear (MoP-Raid 5.0.1)
	-------------------------------------------------------------------------------
	[62837] = true,	-- Grand Empress Shek'zeer
	[62543]	= true,	-- Blade Lord Ta'yak
	[62511]	= true,	-- Amber-Shaper Un'sok
	[63191]	= true,	-- Garalon
	[62397]	= true,	-- Wind Lord Mel'jarak
	[62980]	= true,	-- Zorlok

	-------------------------------------------------------------------------------
	-- Hellfire Citadel (Draenor)
	-------------------------------------------------------------------------------
	-- Hellbreach
	[90019]	= true,	-- Hellfire Assault - Siegemaster Mar'tak
	[90284]	= true,	-- Iron Reaver
	[90435]	= true,	-- Kormrok
	-- Halls of Blood
	[90378]	= true,	-- Kilrogg Deadeye
	[92144]	= true,	-- Hellfire High Council - Dia Darkwhisper
	[92146]	= true,	-- Hellfire High Council - Gurtogg Bloodboil
	[92142]	= true,	-- Hellfire High Council - Blademaster Jubei'thos
	[90199]	= true,	-- Gorefiend
	-- Bastion of Shadows
	[90316]	= true,	-- Shadow-Lord Iskar
	[92330]	= true,	-- Socrethar the Eternal - Soulbound Construct
	[90269]	= true,	-- Tyrant Velhari
	-- Destructor’s Rise
	[89890]	= true,	-- Fel Lord Zakuun
	[93068]	= true,	-- Xhul'horac
	[91349]	= true,	-- Mannoroth
	-- The Black Gate
	[91331]	= true,	-- Archimonde

	-------------------------------------------------------------------------------
	-- Hellfire Citadel: Hellfire Ramparts
	-------------------------------------------------------------------------------
	[17306]	= true,	-- Watchkeeper Gargolmar
	[17308]	= true,	-- Omor the Unscarred
	[17537]	= true,	-- Vazruden
	[17307]	= true,	-- Vazruden the Herald
	[17536]	= true,	-- Nazan

	-------------------------------------------------------------------------------
	-- Hellfire Citadel: Magtheridon's Lair
	-------------------------------------------------------------------------------
	[17257]	= true,	-- Magtheridon

	-------------------------------------------------------------------------------
	-- Hellfire Citadel: Shattered Halls
	-------------------------------------------------------------------------------
	[16807]	= true,	-- Grand Warlock Nethekurse
	[20923]	= true,	-- Blood Guard Porung (Heroic)
	[16809]	= true,	-- Warbringer O'mrogg
	[16808]	= true,	-- Warchief Kargath Bladefist

	-------------------------------------------------------------------------------
	-- Hellfire Citadel: The Blood Furnace
	-------------------------------------------------------------------------------
	[17381]	= true,	-- The Maker
	[17380]	= true,	-- Broggok
	[17377]	= true,	-- Keli'dan the Breaker

	-------------------------------------------------------------------------------
	-- Hellfire Peninsula
	-------------------------------------------------------------------------------
	[18728]	= true,	-- Doom Lord Kazzak
	[12397]	= true,	-- Lord Kazzak

	-------------------------------------------------------------------------------
	-- Highmaul
	-------------------------------------------------------------------------------
	-- Walled City
	[78714]	= true,	-- Kargath Bladefist
	[77404]	= true,	-- The Butcher
	[78491]	= true,	-- Brackenspore
	-- Arcane Sanctum
	[78948]	= true,	-- Tectus
	[78238]	= true,	-- Twin Ogron - Pol
	[78237]	= true,	-- Twin Ogron - Phemos
	[79015]	= true,	-- Ko'ragh
	-- Imperator's Rise
	[77428]	= true,	-- Imperator Mar'gok

	-------------------------------------------------------------------------------
	-- Hour of Twilight 4.3
	-------------------------------------------------------------------------------
	[54590]	= true,	-- Arcurion
	[54968]	= true,	-- Asira Dawnslayer
	[54938]	= true,	-- Archbishop Benedictus

	-------------------------------------------------------------------------------
	-- Icecrown Citadel
	-------------------------------------------------------------------------------
	[36612]	= true,	-- Lord Marrowgar
	[36855]	= true,	-- Lady Deathwhisper

	-- Gunship Battle
	[37813]	= true,	-- Deathbringer Saurfang
	[36626]	= true,	-- Festergut
	[36627]	= true,	-- Rotface
	[36678]	= true,	-- Professor Putricide
	[37972]	= true,	-- Prince Keleseth (Icecrown Citadel)
	[37970]	= true,	-- Prince Valanar
	[37973]	= true,	-- Prince Taldaram (Icecrown Citadel)
	[37955]	= true,	-- Queen Lana'thel
	[36789]	= true,	-- Valithria Dreamwalker
	[37950]	= true,	-- Valithria Dreamwalker (Phased)
	[37868]	= true,	-- Risen Archmage, Valitrhia Add
	[36791]	= true,	-- Blazing Skeleton, Valithria Add
	[37934]	= true,	-- Blistering Zombie, Valithria Add
	[37886]	= true,	-- Gluttonous Abomination, Valithria Add
	[37985]	= true,	-- Dream Cloud , Valithria "Add"
	[36853]	= true,	-- Sindragosa
	[36597]	= true,	-- The Lich King (Icecrown Citadel)
	[37217]	= true,	-- Precious
	[37025]	= true,	-- Stinki
	[36661]	= true,	-- Rimefang <Drake of Tyrannus>

	-------------------------------------------------------------------------------
	-- Iron Docks
	-------------------------------------------------------------------------------
	[81305]	= true,	-- Fleshrender Nok'gar
	[81297]	= true,	-- Fleshrender Nok'gar - Dreadfang
	[80816]	= true,	-- Grimrail Enforcers - Ahri'ok Dugru
	[80805]	= true,	-- Grimrail Enforcers - Makogg Emberblade
	[80808]	= true,	-- Grimrail Enforcers - Neesa Nox
	[79852]	= true,	-- Oshir
	[83612]	= true,	-- Skulloc
	[83613]	= true,	-- Skulloc - Koramar
	[83616]	= true,	-- Skulloc - Zoggosh

	-------------------------------------------------------------------------------
	-- Isle of Giants
	-------------------------------------------------------------------------------
	[69161]	= true,	-- Oondasta

	-------------------------------------------------------------------------------
	-- Isle of Thunder
	-------------------------------------------------------------------------------
	[69099]	= true,	-- Nalak <The Storm Lord>

	-------------------------------------------------------------------------------
	-- Karazhan
	-------------------------------------------------------------------------------
	[15550]	= true,	-- Attumen the Huntsman
	[16151]	= true,	-- Midnight
	[28194]	= true,	-- Tenris Mirkblood (Scourge invasion)
	[15687]	= true,	-- Moroes
	[16457]	= true,	-- Maiden of Virtue
	[15691]	= true,	-- The Curator
	[15688]	= true,	-- Terestian Illhoof
	[16524]	= true,	-- Shade of Aran
	[15689]	= true,	-- Netherspite
	[15690]	= true,	-- Prince Malchezaar
	[17225]	= true,	-- Nightbane
	[17229]	= true,	-- Kil'rek
	-- Chess event

	-------------------------------------------------------------------------------
	-- Karazhan: Servants' Quarters Beasts
	-------------------------------------------------------------------------------
	[16179]	= true,	-- Hyakiss the Lurker
	[16181]	= true,	-- Rokad the Ravager
	[16180]	= true,	-- Shadikith the Glider

	-------------------------------------------------------------------------------
	-- Karazhan: Opera Event
	-------------------------------------------------------------------------------
	[17535]	= true,	-- Dorothee
	[17546]	= true,	-- Roar
	[17543]	= true,	-- Strawman
	[17547]	= true,	-- Tinhead
	[17548]	= true,	-- Tito
	[18168]	= true,	-- The Crone
	[17521]	= true,	-- The Big Bad Wolf
	[17533]	= true,	-- Romulo
	[17534]	= true,	-- Julianne

	-------------------------------------------------------------------------------
	-- Kun-Lai Summit: MoP World bosses
	-------------------------------------------------------------------------------
	[60491]	= true,	-- Sha of Anger
	[62346]	= true,	-- Galleon

	-------------------------------------------------------------------------------
	-- Lost City of the Tol'vir
	-------------------------------------------------------------------------------
	[44577]	= true,	-- General Husam
	[43612]	= true,	-- High Prophet Barim
	[43614]	= true,	-- Lockmaw
	[49045]	= true,	-- Augh
	[44819]	= true,	-- Siamat

	-------------------------------------------------------------------------------
	-- Lower Blackrock Spire
	-------------------------------------------------------------------------------
	[10263]	= true,	-- Burning Felguard
	[9218]	= true,	-- Spirestone Battle Lord
	[9219]	= true,	-- Spirestone Butcher
	[9217]	= true,	-- Spirestone Lord Magus
	[9196]	= true,	-- Highlord Omokk
	[9236]	= true,	-- Shadow Hunter Vosh'gajin
	[9237]	= true,	-- War Master Voone
	[16080]	= true,	-- Mor Grayhoof
	[9596]	= true,	-- Bannok Grimaxe
	[10596]	= true,	-- Mother Smolderweb
	[10376]	= true,	-- Crystal Fang
	[10584]	= true,	-- Urok Doomhowl
	[9736]	= true,	-- Quartermaster Zigris
	[10220]	= true,	-- Halycon
	[10268]	= true,	-- Gizrul the Slavener
	[9718]	= true,	-- Ghok Bashguud
	[9568]	= true,	-- Overlord Wyrmthalak

	-------------------------------------------------------------------------------
	-- Magisters' Terrace
	-------------------------------------------------------------------------------
	[24723]	= true,	-- Selin Fireheart
	[24744]	= true,	-- Vexallus
	[24560]	= true,	-- Priestess Delrissa
	[24664]	= true,	-- Kael'thas Sunstrider

	-------------------------------------------------------------------------------
	-- Maraudon
	-------------------------------------------------------------------------------
	-- [13718]	= true,	-- The Nameless Prophet (Pre-instance)
	[13742]	= true,	-- Kolk <The First Khan>
	[13741]	= true,	-- Gelk <The Second Khan>
	[13740]	= true,	-- Magra <The Third Khan>
	[13739]	= true,	-- Maraudos <The Fourth Khan>
	[12236]	= true,	-- Lord Vyletongue
	[13738]	= true,	-- Veng <The Fifth Khan>
	[13282]	= true,	-- Noxxion
	[12258]	= true,	-- Razorlash
	[12237]	= true,	-- Meshlok the Harvester
	[12225]	= true,	-- Celebras the Cursed
	[12203]	= true,	-- Landslide
	[13601]	= true,	-- Tinkerer Gizlock
	[13596]	= true,	-- Rotgrip
	[12201]	= true,	-- Princess Theradras

	-------------------------------------------------------------------------------
	-- Maw of Souls
	-------------------------------------------------------------------------------
	[96756] = true, -- Ymiron, the Fallen King
	[96754] = true, -- Harbaron
	[96759] = true, -- Helya

	-------------------------------------------------------------------------------
	-- Mogu'Shan Palace (MoP-Dungeon 5.0.1)
	-------------------------------------------------------------------------------
	[61442]	= true,	-- Kuai the Brute, Trial of the King
	[61444]	= true,	-- Ming the Cunning, Trial of the King
	[61445]	= true,	-- Haiyan the Unstoppable, Trial of the King
	[61243]	= true,	-- Gekkan
	[61398]	= true,	-- Xin the Weaponmaster

	-------------------------------------------------------------------------------
	-- Mogu'Shan Vault (MoP-Raid 5.0.1)
	-------------------------------------------------------------------------------
	[59915]	= true,	-- Jasper, Stone Guard
	[60009]	= true,	-- Feng the Accursed
	[60043]	= true,	-- Jade, Stone Guard
	[60047]	= true,	-- Amethyst, Stone Guard
	[60051]	= true,	-- Cobalt, Stone Guard
	[60143] = true,	-- Gara'jal the Spiritbinder
	[60399] = true,	-- Qin-xi
	[60400] = true,	-- Jan-xi
	[60410] = true,	-- Elegon
	[60701]	= true,	-- Zian of the Endless Shadow
	[60709]	= true,	-- Qiang the Merciless
	[60710]	= true,	-- Subetai the Swift
	[60708]	= true,	-- Meng the Demented

	-------------------------------------------------------------------------------
	-- Molten Core
	-------------------------------------------------------------------------------
	[12118]	= true,	-- Lucifron
	[11982]	= true,	-- Magmadar
	[12259]	= true,	-- Gehennas
	[12057]	= true,	-- Garr
	[12056]	= true,	-- Baron Geddon
	[12264]	= true,	-- Shazzrah
	[12098]	= true,	-- Sulfuron Harbinger
	[11988]	= true,	-- Golemagg the Incinerator
	[12018]	= true,	-- Majordomo Executus
	[11502]	= true,	-- Ragnaros

	-------------------------------------------------------------------------------
	-- Nagrand
	-------------------------------------------------------------------------------
	[18398]	= true,	-- Brokentoe
	[18069]	= true,	-- Mogor <Hero of the Warmaul>, friendly
	[18399]	= true,	-- Murkblood Twin
	[18400]	= true,	-- Rokdar the Sundered Lord
	[18401]	= true,	-- Skra'gath
	[18402]	= true,	-- Warmaul Champion

	-------------------------------------------------------------------------------
	-- Naxxramas
	-------------------------------------------------------------------------------
	[30549]	= true,	-- Baron Rivendare (Naxxramas)
	[16803]	= true,	-- Death Knight Understudy
	[15930]	= true,	-- Feugen
	[15929]	= true,	-- Stalagg

	-------------------------------------------------------------------------------
	-- Naxxramas: Abomination Wing
	-------------------------------------------------------------------------------
	[16028]	= true,	-- Patchwerk
	[15931]	= true,	-- Grobbulus
	[15932]	= true,	-- Gluth
	[15928]	= true,	-- Thaddius

	-------------------------------------------------------------------------------
	-- Naxxramas: Deathknight Wing
	-------------------------------------------------------------------------------
	[16061]	= true,	-- Instructor Razuvious
	[16060]	= true,	-- Gothik the Harvester

	-------------------------------------------------------------------------------
	-- Naxxramas: Frostwyrm Lair
	-------------------------------------------------------------------------------
	[15989]	= true,	-- Sapphiron
	[15990]	= true,	-- Kel'Thuzad
	[25465]	= true,	-- Kel'Thuzad

	-------------------------------------------------------------------------------
	-- Naxxramas: Plague Wing
	-------------------------------------------------------------------------------
	[15954]	= true,	-- Noth the Plaguebringer
	[15936]	= true,	-- Heigan the Unclean
	[16011]	= true,	-- Loatheb

	-------------------------------------------------------------------------------
	-- Naxxramas: Spider Wing
	-------------------------------------------------------------------------------
	[15956]	= true,	-- Anub'Rekhan
	[15953]	= true,	-- Grand Widow Faerlina
	[15952]	= true,	-- Maexxna

	-------------------------------------------------------------------------------
	-- Naxxramas: The Four Horsemen
	-------------------------------------------------------------------------------
	[16065]	= true,	-- Lady Blaumeux
	[16064]	= true,	-- Thane Korth'azz
	[16062]	= true,	-- Highlord Mograine
	[16063]	= true,	-- Sir Zeliek

	-------------------------------------------------------------------------------
	-- Neltharion's Lair
	-------------------------------------------------------------------------------
	[91003] = true, -- Rokmora
	[91004] = true, -- Ularogg Cragshaper
	[91005] = true, -- Naraxas
	[91007] = true, -- Dargrul the Underking

	-------------------------------------------------------------------------------
	-- Nizuao Temple (MoP-Dungeon 5.0.1)
	-------------------------------------------------------------------------------

	[61634]	= true,	-- Vojak
	[61567]	= true,	-- Jinbak
	[62205]	= true,	-- Neronok
	[61485]	= true,	-- Pavalak

	-------------------------------------------------------------------------------
	-- Obsidian Sanctum
	-------------------------------------------------------------------------------
	[30451]	= true,	-- Shadron
	[30452]	= true,	-- Tenebron
	[30449]	= true,	-- Vesperon
	[28860]	= true,	-- Sartharion

	-------------------------------------------------------------------------------
	-- Onyxia's Lair
	-------------------------------------------------------------------------------
	[10184]	= true,	-- Onyxia

	-------------------------------------------------------------------------------
	-- Pit of Saron
	-------------------------------------------------------------------------------
	[36494]	= true,	-- Forgemaster Garfrost
	[36477]	= true,	-- Krick
	[36476]	= true,	-- Ick <Krick's Minion>
	[36658]	= true,	-- Scourgelord Tyrannus

	-------------------------------------------------------------------------------
	-- Ragefire Chasm
	-------------------------------------------------------------------------------
	[11517]	= true,	-- Oggleflint
	[11518]	= true,	-- Jergosh the Invoker
	[11519]	= true,	-- Bazzalan
	[11520]	= true,	-- Taragaman the Hungerer
	[17830]	= true,	-- Zelemar the Wrathful

	-------------------------------------------------------------------------------
	-- Razorfen Downs
	-------------------------------------------------------------------------------
	[7355]	= true,	-- Tuten'kash
	[14686]	= true,	-- Lady Falther'ess (Scourge invasion only)
	[7356]	= true,	-- Plaguemaw the Rotting
	[7357]	= true,	-- Mordresh Fire Eye
	[8567]	= true,	-- Glutton
	[7354]	= true,	-- Ragglesnout
	[7358]	= true,	-- Amnennar the Coldbringer

	-------------------------------------------------------------------------------
	-- Razorfen Kraul
	-------------------------------------------------------------------------------
	[4421]	= true,	-- Charlga Razorflank
	[4420]	= true,	-- Overlord Ramtusk
	[4422]	= true,	-- Agathelos the Raging
	[4428]	= true,	-- Death Speaker Jargba
	[4424]	= true,	-- Aggem Thorncurse
	[6168]	= true,	-- Roogug
	[4425]	= true,	-- Blind Hunter
	[4842]	= true,	-- Earthcaller Halmgar

	-------------------------------------------------------------------------------
	-- Ruby Sanctum
	-------------------------------------------------------------------------------
	[39746]	= true,	-- Zarithrian
	[39747]	= true,	-- Saviana
	[39751]	= true,	-- Baltharus
	[39863]	= true,	-- Halion
	[39899]	= true,	-- Baltharus (Copy has an own id apparently)
	[40142]	= true,	-- Halion (twilight realm)

	-------------------------------------------------------------------------------
	-- Ruins of Ahn'Qiraj
	-------------------------------------------------------------------------------
	[15348]	= true,	-- Kurinnaxx
	[15341]	= true,	-- General Rajaxx
	[15340]	= true,	-- Moam
	[15370]	= true,	-- Buru the Gorger
	[15369]	= true,	-- Ayamiss the Hunter
	[15339]	= true,	-- Ossirian the Unscarred

	-------------------------------------------------------------------------------
	-- Scarlet Halls (MoP Dungeon)
	-------------------------------------------------------------------------------
	[58632] = true,	-- Armsmaster Harlan
	[59150] = true,	-- Flameweaver Koegler
	[59303] = true,	-- Houndmaster Braun

	-------------------------------------------------------------------------------
	-- Scarlet Monastery: Armory
	-------------------------------------------------------------------------------
	[3975] = true,	-- Herod

	-------------------------------------------------------------------------------
	-- Scarlet Monastery: Cathedral
	-------------------------------------------------------------------------------
	[4542]	= true,	-- High Inquisitor Fairbanks
	[3976]	= true,	-- Scarlet Commander Mograine
	[3977]	= true,	-- High Inquisitor Whitemane
	[59789]	= true,	-- Thalnos the Soulrender (MoP Heroic 5.0.1)
	[59223]	= true,	-- Brother Korlof (MoP Heroic 5.0.1)
	[60040]	= true,	-- Commander Durand (MoP Heroic 5.0.1)

	-------------------------------------------------------------------------------
	-- Scarlet Monastery: Graveyard
	-------------------------------------------------------------------------------
	[3983]	= true,	-- Interrogator Vishas
	[6488]	= true,	-- Fallen Champion
	[6490]	= true,	-- Azshir the Sleepless
	[6489]	= true,	-- Ironspine
	[14693]	= true,	-- Scorn (Scourge invasion only)
	[4543]	= true,	-- Bloodmage Thalnos
	[23682]	= true,	-- Headless Horseman
	[23800]	= true,	-- Headless Horseman

	-------------------------------------------------------------------------------
	-- Scarlet Monastery: Library
	-------------------------------------------------------------------------------
	[3974]	= true,	-- Houndmaster Loksey
	[6487]	= true,	-- Arcanist Doan

	-------------------------------------------------------------------------------
	-- Scholomance
	-------------------------------------------------------------------------------
	[14861]	= true,	-- Blood Steward of Kirtonos
	[10506]	= true,	-- Kirtonos the Herald
	[14695]	= true,	-- Lord Blackwood (Scourge Invasion)
	[10503]	= true,	-- Jandice Barov
	[11622]	= true,	-- Rattlegore
	[14516]	= true,	-- Death Knight Darkreaver
	[10433]	= true,	-- Marduk Blackpool
	[10432]	= true,	-- Vectus
	[16118]	= true,	-- Kormok
	[10508]	= true,	-- Ras Frostwhisper
	[10505]	= true,	-- Instructor Malicia
	[11261]	= true,	-- Doctor Theolen Krastinov
	[10901]	= true,	-- Lorekeeper Polkelt
	[10507]	= true,	-- The Ravenian
	[10504]	= true,	-- Lord Alexei Barov
	[10502]	= true,	-- Lady Illucia Barov
	[1853]	= true,	-- Darkmaster Gandling
	[58633] = true,	-- Instructor Chillheart (MoP Heroic)
	[59200] = true,	-- Lilian Voss (MoP Heroic)

	-------------------------------------------------------------------------------
	-- Searing Gorge
	-------------------------------------------------------------------------------
	[9026]	= true,	-- Overmaster Pyron

	-------------------------------------------------------------------------------
	-- Shado-Pan Monastery (MoP Dungeon)
	-------------------------------------------------------------------------------
	[56719] = true,	-- Sha of Violence
	[56747] = true,	-- Gu Cloudstrike
	[56884] = true,	-- Taran Zhu
	[64387] = true,	-- Master Snowdrift

	-------------------------------------------------------------------------------
	-- Shadowfang Keep
	-------------------------------------------------------------------------------
	[3914]	= true,	-- Rethilgore
	[3886]	= true,	-- Razorclaw the Butcher
	[4279]	= true,	-- Odo the Blindwatcher
	[3887]	= true,	-- Baron Silverlaine
	[4278]	= true,	-- Commander Springvale
	[4274]	= true,	-- Fenrus the Devourer
	[3927]	= true,	-- Wolf Master Nandos
	[14682]	= true,	-- Sever (Scourge invasion only)
	[4275]	= true,	-- Archmage Arugal
	[3872]	= true,	-- Deathsworn Captain
	[46962]	= true,	-- Baron Ashbury
	[46963]	= true,	-- Lord Walden
	[46964]	= true,	-- Lord Godfrey

	-------------------------------------------------------------------------------
	-- Shadowmoon Burial Grounds
	-------------------------------------------------------------------------------
	[75509]	= true,	-- Sadana Bloodfury
	[75829]	= true,	-- Nhallish
	[75452]	= true,	-- Bonemaw
	[76407]	= true,	-- Ner'zhul

	-------------------------------------------------------------------------------
	-- Shadowmoon Valley
	-------------------------------------------------------------------------------
	[17711]	= true,	-- Doomwalker

	-------------------------------------------------------------------------------
	-- Siege of Orgrimmar
	-------------------------------------------------------------------------------
	-- Vale of Eternal Sorrows
	[71543]	= true,	-- Immerseus
	[71475]	= true,	-- Rook Stonetoe, The Fallen Protectors
	[71479]	= true,	-- He Softfoot, The Fallen Protectors
	[71480]	= true,	-- Sun Tenderheart, The Fallen Protectors
	[72276]	= true,	-- Norushen, Amalgam of Corruption
	[71734]	= true,	-- Sha of Pride

	-- Gates of Retribution
	[72249]	= true,	-- Galakras
	[72311]	= true,	-- Varian (part of the Galakras encounter's trigger)
	[72560]	= true,	-- Lor'Themar (His hair triggers the Galakras encounter)
	[71466]	= true,	-- Iron Juggernaut
	[71859]	= true,	-- Haromm, his Darkness exceeded only by his Shamanism
	[71858]	= true,	-- Kardriss, his Shamanism exceeded only by his Darkness
	[71515]	= true,	-- General Nazgrim

	-- The Underhold
	[71454]	= true,	-- Malkorak
	[73720]	= true,	-- Mogu Spoils (Spoils of War)
	[71512]	= true,	-- Mantid Spoils (Spoils of War)
	[71529]	= true,	-- Thok the Bloodthirsty, her Thirst exceeded only by her Blood

	-- Downfall
	[71504]	= true,	-- Siegecrafter Blackfuse, his fuses exceeded only by his... wait...
	[71591]	= true,	-- Automated Shredder (Part of the Siegecrafter fight... not sure if this is the trigger or just him)
	[71152]	= true,	-- Skeer the Bloodseeker, <Paragon of the Klaxxi>
	[71153]	= true,	-- Hisek the Swarmkeeper, <Paragon of the Klaxxi>
	[71154]	= true,	-- Ka'roz the Locust, <Paragon of the Klaxxi>
	[71155]	= true,	-- Korven the Prime, <Paragon of the Klaxxi>
	[71156]	= true,	-- Kaz'tik the Manipulator, <Paragon of the Klaxxi>
	[71157]	= true,	-- Xaril The POisoned Mind, <Paragon of the Klaxxi>
	[71158]	= true,	-- Rik'kal the Dissector, <Paragon of the Klaxxi>
	[71160]	= true,	-- Iyyokuk the Lucid, <Paragon of the Klaxxi> (71159 is Ghazrooki, weird isn't it?)
	[71161]	= true,	-- Kil'ruk the Wind-Reaver, <Paragon of the Klaxxi>
	[71865]	= true,	-- Garrosh Starscream, That's right. He was a Decepticon all this time

	-------------------------------------------------------------------------------
	-- Silithus
	-------------------------------------------------------------------------------
	[15205]	= true,	-- Baron Kazum <Abyssal High Council>
	[15204]	= true,	-- High Marshal Whirlaxis <Abyssal High Council>
	[15305]	= true,	-- Lord Skwol <Abyssal High Council>
	[15203]	= true,	-- Prince Skaldrenox <Abyssal High Council>
	[14454]	= true,	-- The Windreaver

	-------------------------------------------------------------------------------
	-- Skyreach
	-------------------------------------------------------------------------------
	[75964]	= true,	-- Ranjit
	[76141]	= true,	-- Araknath
	[76379]	= true,	-- Rukhran
	[76266]	= true,	-- High Sage Viryx

	-------------------------------------------------------------------------------
	-- Spires of Arak
	-------------------------------------------------------------------------------
	[83746]	= true,	-- Rukhmar

	-------------------------------------------------------------------------------
	-- Stormstout Brewery (MoP Dungeon)
	-------------------------------------------------------------------------------
	[56717]	= true,	-- Hoptallus
	[57963]	= true,	-- Ook-Ook
	[59479]	= true,	-- Yan-Zhu the Unsacked

	-------------------------------------------------------------------------------
	-- Stormwind Stockade
	-------------------------------------------------------------------------------
	[1716]	= true,	-- Bazil Thredd
	[1663]	= true,	-- Dextren Ward
	[1717]	= true,	-- Hamhock
	[1666]	= true,	-- Kam Deepfury
	[1696]	= true,	-- Targorr the Dread
	[1720]	= true,	-- Bruegal Ironknuckle
	-- Cata:
	[46383]	= true,	-- Randolph Moloch
	[46264]	= true,	-- Lord Overheat
	[46254]	= true,	-- Hogger

	-------------------------------------------------------------------------------
	-- Stratholme: Scarlet Stratholme
	-------------------------------------------------------------------------------
	[10393]	= true,	-- Skul
	[14684]	= true,	-- Balzaphon (Scourge Invasion)
	-- [11082]	= true,	-- Stratholme Courier
	[11058]	= true,	-- Fras Siabi
	[10558]	= true,	-- Hearthsinger Forresten
	[10516]	= true,	-- The Unforgiven
	[16387]	= true,	-- Atiesh
	[11143]	= true,	-- Postmaster Malown
	[10808]	= true,	-- Timmy the Cruel
	[11032]	= true,	-- Malor the Zealous
	[11120]	= true,	-- Crimson Hammersmith
	[10997]	= true,	-- Cannon Master Willey
	[10811]	= true,	-- Archivist Galford
	[10813]	= true,	-- Balnazzar
	[16101]	= true,	-- Jarien
	[16102]	= true,	-- Sothos

	-------------------------------------------------------------------------------
	-- Stratholme: Defenders of the Chapel
	-------------------------------------------------------------------------------
	[17913]	= true,	-- Aelmar the Vanquisher
	[17911]	= true,	-- Cathela the Seeker
	[17910]	= true,	-- Gregor the Justiciar
	[17914]	= true,	-- Vicar Hieronymus
	[17912]	= true,	-- Nemas the Arbiter

	-------------------------------------------------------------------------------
	-- Stratholme: Undead Stratholme
	-------------------------------------------------------------------------------
	[10809]	= true,	-- Stonespine
	[10437]	= true,	-- Nerub'enkan
	[10436]	= true,	-- Baroness Anastari
	[11121]	= true,	-- Black Guard Swordsmith
	[10438]	= true,	-- Maleki the Pallid
	[10435]	= true,	-- Magistrate Barthilas
	[10439]	= true,	-- Ramstein the Gorger
	[10440]	= true,	-- Baron Rivendare (Stratholme)

	-------------------------------------------------------------------------------
	-- Sunwell Plateau
	-------------------------------------------------------------------------------
	[24891]	= true,	-- Kalecgos
	[25319]	= true,	-- Kalecgos
	[24850]	= true,	-- Kalecgos
	[24882]	= true,	-- Brutallus
	[25038]	= true,	-- Felmyst
	[25165]	= true,	-- Lady Sacrolash
	[25166]	= true,	-- Grand Warlock Alythess
	[25741]	= true,	-- M'uru
	[25315]	= true,	-- Kil'jaeden
	[25840]	= true,	-- Entropius
	[24892]	= true,	-- Sathrovarr the Corruptor

	-------------------------------------------------------------------------------
	-- Tanaan Jungle
	-------------------------------------------------------------------------------
	[94015]	= true,	-- Supreme Lord Kazzak

	-------------------------------------------------------------------------------
	-- Tempest Keep: The Arcatraz
	-------------------------------------------------------------------------------
	[20870]	= true,	-- Zereketh the Unbound
	[20886]	= true,	-- Wrath-Scryer Soccothrates
	[20885]	= true,	-- Dalliah the Doomsayer
	[20912]	= true,	-- Harbinger Skyriss
	[20904]	= true,	-- Warden Mellichar

	-------------------------------------------------------------------------------
	-- Tempest Keep: The Botanica
	-------------------------------------------------------------------------------
	[17976]	= true,	-- Commander Sarannis
	[17975]	= true,	-- High Botanist Freywinn
	[17978]	= true,	-- Thorngrin the Tender
	[17980]	= true,	-- Laj
	[17977]	= true,	-- Warp Splinter

	-------------------------------------------------------------------------------
	-- Tempest Keep: The Eye
	-------------------------------------------------------------------------------
	[19514]	= true,	-- Al'ar
	[19516]	= true,	-- Void Reaver
	[18805]	= true,	-- High Astromancer Solarian
	[19622]	= true,	-- Kael'thas Sunstrider
	[20064]	= true,	-- Thaladred the Darkener
	[20060]	= true,	-- Lord Sanguinar
	[20062]	= true,	-- Grand Astromancer Capernian
	[20063]	= true,	-- Master Engineer Telonicus
	[21270]	= true,	-- Cosmic Infuser
	[21269]	= true,	-- Devastation
	[21271]	= true,	-- Infinity Blades
	[21268]	= true,	-- Netherstrand Longbow
	[21273]	= true,	-- Phaseshift Bulwark
	[21274]	= true,	-- Staff of Disintegration
	[21272]	= true,	-- Warp Slicer

	-------------------------------------------------------------------------------
	-- Tempest Keep: The Mechanar
	-------------------------------------------------------------------------------
	[19218]	= true,	-- Gatewatcher Gyro-Kill
	[19710]	= true,	-- Gatewatcher Iron-Hand
	[19219]	= true,	-- Mechano-Lord Capacitus
	[19221]	= true,	-- Nethermancer Sepethrea
	[19220]	= true,	-- Pathaleon the Calculator

	-------------------------------------------------------------------------------
	-- Temple of Ahn'Qiraj
	-------------------------------------------------------------------------------
	[15263]	= true,	-- The Prophet Skeram
	[15511]	= true,	-- Lord Kri
	[15543]	= true,	-- Princess Yauj
	[15544]	= true,	-- Vem
	[15516]	= true,	-- Battleguard Sartura
	[15510]	= true,	-- Fankriss the Unyielding
	[15299]	= true,	-- Viscidus
	[15509]	= true,	-- Princess Huhuran
	[15276]	= true,	-- Emperor Vek'lor
	[15275]	= true,	-- Emperor Vek'nilash
	[15517]	= true,	-- Ouro
	[15727]	= true,	-- C'Thun
	[15589]	= true,	-- Eye of C'Thun

	-------------------------------------------------------------------------------
	-- Temple of Atal'Hakkar
	-------------------------------------------------------------------------------
	[1063]	= true,	-- Jade
	[5400]	= true,	-- Zekkis
	[5713]	= true,	-- Gasher
	[5715]	= true,	-- Hukku
	[5714]	= true,	-- Loro
	[5717]	= true,	-- Mijan
	[5712]	= true,	-- Zolo
	[5716]	= true,	-- Zul'Lor
	[5399]	= true,	-- Veyzhak the Cannibal
	[5401]	= true,	-- Kazkaz the Unholy
	[8580]	= true,	-- Atal'alarion
	[8443]	= true,	-- Avatar of Hakkar
	[5711]	= true,	-- Ogom the Wretched
	[5710]	= true,	-- Jammal'an the Prophet
	[5721]	= true,	-- Dreamscythe
	[5720]	= true,	-- Weaver
	[5719]	= true,	-- Morphaz
	[5722]	= true,	-- Hazzas
	[5709]	= true,	-- Shade of Eranikus

	-------------------------------------------------------------------------------
	-- Temple of the Jade Serpent (MoP-Dungeon 5.0.1)
	-------------------------------------------------------------------------------
	[56448]	= true,	-- Wise Mari
	[58826]	= true,	-- Zao Sunseeker /Library Event
	[59051]	= true,	-- (Strife) - Library Event
	[59726]	= true,	-- (Anger) - Library Event
	[56732]	= true,	-- Liu Flameheart
	[56439]	= true,	-- Sha of Doubt

	-------------------------------------------------------------------------------
	-- Terrace of Endless Spring (MoP Raid)
	-------------------------------------------------------------------------------
	[60583]	= true,	-- Protector Kaolan
	[60585]	= true,	-- Elder Regail
	[60586]	= true,	-- Elder Asani
	[60999]	= true,	-- Sha of Fear
	[62442]	= true,	-- Tsulong
	[63099]	= true,	-- Lei Shi

	-------------------------------------------------------------------------------
	-- The Arcway
	-------------------------------------------------------------------------------
	[98203] = true, -- Ivanyr
	[98205] = true, -- Corstilax
	[98206] = true, -- General Xakal
	[98207] = true, -- Nal'tira
	[98208] = true, -- Advisor Vandros

	-------------------------------------------------------------------------------
	-- The Bastion of Twilight
	-------------------------------------------------------------------------------
	[45992]	= true,	-- Valiona
	[45993]	= true,	-- Theralion
	[44600]	= true,	-- Halfus Wyrmbreaker
	[43686]	= true,	-- Ignacious
	[43687]	= true,	-- Feludius
	[43688]	= true,	-- Arion
	[43689]	= true,	-- Terrastra
	[43735]	= true,	-- Elementium Monstrosity
	[43324]	= true,	-- Cho'gall
	[45213]	= true,	-- Sinestra (Heroic) drycoded from http://db.mmo-champion.com/c/45213/sinestra/

	-------------------------------------------------------------------------------
	-- The Deadmines
	-------------------------------------------------------------------------------
	[642]	= true,	-- Sneed's Shredder
	[643]	= true,	-- Sneed
	[644]	= true,	-- Rhahk'Zor
	[645]	= true,	-- Cookie
	[646]	= true,	-- Mr. Smite
	[647]	= true,	-- Captain Greenskin
	[3586]	= true,	-- Miner Johnson
	[1763]	= true,	-- Gilnid
	[639]	= true,	-- Edwin VanCleef
	[596]	= true,	-- Brainwashed Noble, outside
	[626]	= true,	-- Foreman Thistlenettle, outside
	[599]	= true,	-- Marisa du'Paige, outside
	[47162]	= true,	-- Glubtok
	[47296]	= true,	-- Helix Gearbreaker
	[43778]	= true,	-- Foe Reaper 5000
	[47626]	= true,	-- Admiral Ripsnarl
	[47739]	= true,	-- "Captain" Cookie
	[49541]	= true,	-- Vanessa VanCleef

	-------------------------------------------------------------------------------
	-- Dragon Soul (4.3 Raid)
	-------------------------------------------------------------------------------
	[55265]	= true,	-- Morchok
	[55308]	= true,	-- Warlord Zonozz
	[55312]	= true,	-- Yor'sahj the Unsleeping
	[55689]	= true,	-- Hagara the Binder
	[55294]	= true,	-- Ultraxion
	[56427]	= true,	-- Warmaster Blackhorn
	[53879]	= true,	-- Spine Deathwing
	[56173]	= true,	-- Madness Deathwing

	-------------------------------------------------------------------------------
	-- The Emerald Nightmare
	-------------------------------------------------------------------------------
	-- Darkbough
	[102672] = true, -- Nythendra
	[105906] = true, -- Il'gynoth - Eye of Il'gynoth
	[105393] = true, -- Il'gynoth
	[106087] = true, -- Elerethe Renferal
	-- Tormented Guardians
	[100497] = true, -- Ursoc
	[102679] = true, -- The Dragons of Nightmare - Ysondre
	[102682] = true, -- The Dragons of Nightmare - Lethon
	[102681] = true, -- The Dragons of Nightmare - Taerar
	[102683] = true, -- The Dragons of Nightmare - Emeriss
	[104636] = true, -- Cenarius
	-- Rift of Aln
	[103769] = true, -- Xavius

	-------------------------------------------------------------------------------
	-- The Everbloom
	-------------------------------------------------------------------------------
	[81522]	= true,	-- Witherbark
	[83892]	= true,	-- Ancient Protectors - Life Warden Gola
	[83893]	= true,	-- Ancient Protectors - Earthshaper Telu
	[83894]	= true,	-- Ancient Protectors - Dulhu
	[84550]	= true,	-- Xeri'tac
	[82682]	= true,	-- Archmage Sol
	[83846]	= true,	-- Yalnu

	-------------------------------------------------------------------------------
	-- The Eye of Eternity
	-------------------------------------------------------------------------------
	[28859]	= true,	-- Malygos

	-------------------------------------------------------------------------------
	-- The Nexus
	-------------------------------------------------------------------------------
	[26798]	= true,	-- Commander Kolurg (Heroic)
	[26796]	= true,	-- Commander Stoutbeard (Heroic)
	[26731]	= true,	-- Grand Magus Telestra
	[26832]	= true,	-- Grand Magus Telestra
	[26928]	= true,	-- Grand Magus Telestra
	[26929]	= true,	-- Grand Magus Telestra
	[26930]	= true,	-- Grand Magus Telestra
	[26763]	= true,	-- Anomalus
	[26794]	= true,	-- Ormorok the Tree-Shaper
	[26723]	= true,	-- Keristrasza

	-------------------------------------------------------------------------------
	-- The Nighthold
	-------------------------------------------------------------------------------
	-- Arcing Aqueducts (W1)
	[102263] = true, -- Skorpyron
	[104415] = true, -- Chronomatic Anomaly
	[104288] = true, -- Trilliax

	-- Royal Athenaeum
	[107699] = true, -- Spellblade Aluriel
	[103758] = true, -- Star Augur Etraeus
	[104528] = true, -- High Botanist Tel'arn
	-- Nightspire
	[101002] = true, -- Krosus
	[103685] = true, -- Tichondrius
	[110965] = true, -- Elisande
	-- Betrayer’s Rise
	[105503] = true, -- Gul'dan

	-------------------------------------------------------------------------------
	-- The Oculus
	-------------------------------------------------------------------------------
	[27654]	= true,	-- Drakos the Interrogator
	[27447]	= true,	-- Varos Cloudstrider
	[27655]	= true,	-- Mage-Lord Urom
	[27656]	= true,	-- Ley-Guardian Eregos

	-------------------------------------------------------------------------------
	-- The Stonecore
	-------------------------------------------------------------------------------
	[43438]	= true,	-- Corborus
	[43214]	= true,	-- Slabhide
	[42188]	= true,	-- Ozruk
	[42333]	= true,	-- High Priestess Azil

	-------------------------------------------------------------------------------
	-- The Violet Hold (Northrend)
	-------------------------------------------------------------------------------
	[29315]	= true,	-- Erekem
	[29313]	= true,	-- Ichoron
	[29312]	= true,	-- Lavanthor
	[29316]	= true,	-- Moragg
	[29266]	= true,	-- Xevozz
	[29314]	= true,	-- Zuramat the Obliterator
	[31134]	= true,	-- Cyanigosa

	-------------------------------------------------------------------------------
	-- The Vortex Pinnacle
	-------------------------------------------------------------------------------
	[43878]	= true,	-- Grand Vizier Ertan
	[43873]	= true,	-- Altairus
	[43875]	= true,	-- Asaad

	-------------------------------------------------------------------------------
	-- Throne of the Four Winds
	-------------------------------------------------------------------------------
	[45871]	= true,	-- Nezir
	[46753]	= true,	-- Al'Akir

	-------------------------------------------------------------------------------
	-- Throne of Thunder
	-------------------------------------------------------------------------------
	-- Last Stand of the Zandalari
	[69465]	= true,	-- Jin'rokh the Breaker
	[68476]	= true,	-- Horridon
	[69134]	= true,	-- Kazra'jin, Council of Elders
	[69078]	= true,	-- Sul the Sandcrawler, Council of Elders
	[69131]	= true,	-- Frost King Malakk, Council of Elders
	[69132]	= true,	-- High Priestess Mar'li, Council of Elders

	-- Forgotten Depths
	[67977]	= true,	-- Tortos
	[70212]	= true,	-- Flaming Head <Head of Megaera>
	[70235]	= true,	-- Frozen Head <Head of Megaera>
	[70247]	= true,	-- Venomous Head <Head of Megaera>
	[69712]	= true,	-- Ji-Kun

	-- Halls of Flesh-Shaping
	[68036]	= true,	-- Durumu the Forgotten
	[69017]	= true,	-- Primordius
	[69427]	= true,	-- Dark Animus

	-- Pinnacle of Storms
	[68078]	= true,	-- Iron Qon <Master of Quilen>
	[68905]	= true,	-- Lu'lin <Mistress of Solitude>, Twin Consorts
	[68904]	= true,	-- Suen <Mistress of Anger>, Twin Consorts
	[68397]	= true,	-- Lei Shen <The Thunder King>
	[69473]	= true,	-- Ra-den <Fallen Keeper of Storms>

	-------------------------------------------------------------------------------
	-- Tomb of Sargeras 7.2.5
	-------------------------------------------------------------------------------
	-- The Gates of Hell
	[115844]	= true,	-- Goroth
	[116407]	= true,	-- Harjatan
	[115767]	= true,	-- Mistress Sassz'ine

	-- Wailing Halls
	[120996]	= true,	-- Demonic Inquisition (Atrigan only)
	[118523]	= true,	-- Sisters of the Moon (Kasparian only)
	[118460]	= true,	-- The Desolate Host (Engine of Souls only)

	-- Chamber of the Avatar
	[118289]	= true,	-- Maiden of Vigilance
	[120436]	= true,	-- Fallen Avatar

	-- Deceiver's Fall
	[117269]	= true,	-- Kil'jaeden

	-------------------------------------------------------------------------------
	-- Trial of the Champion
	-------------------------------------------------------------------------------
	-- Alliance
	[35617]	= true,	-- Deathstalker Visceri <Grand Champion of Undercity>
	[35569]	= true,	-- Eressea Dawnsinger <Grand Champion of Silvermoon>
	[35572]	= true,	-- Mokra the Skullcrusher <Grand Champion of Orgrimmar>
	[35571]	= true,	-- Runok Wildmane <Grand Champion of the Thunder Bluff>
	[35570]	= true,	-- Zul'tore <Grand Champion of Sen'jin>

	-- Horde
	[34702]	= true,	-- Ambrose Boltspark <Grand Champion of Gnomeregan>
	[34701]	= true,	-- Colosos <Grand Champion of the Exodar>
	[34705]	= true,	-- Marshal Jacob Alerius <Grand Champion of Stormwind>
	[34657]	= true,	-- Jaelyne Evensong <Grand Champion of Darnassus>
	[34703]	= true,	-- Lana Stouthammer <Grand Champion of Ironforge>

	-- Neutral
	[34928]	= true,	-- Argent Confessor Paletress
	[35119]	= true,	-- Eadric the Pure
	[35451]	= true,	-- The Black Knight

	-------------------------------------------------------------------------------
	-- Trial of the Crusader
	-------------------------------------------------------------------------------
	[34796]	= true,	-- Gormok
	[35144]	= true,	-- Acidmaw
	[34799]	= true,	-- Dreadscale
	[34797]	= true,	-- Icehowl

	[34780]	= true,	-- Jaraxxus

	[34461]	= true,	-- Tyrius Duskblade <Death Knight>
	[34460]	= true,	-- Kavina Grovesong <Druid>
	[34469]	= true,	-- Melador Valestrider <Druid>
	[34467]	= true,	-- Alyssia Moonstalker <Hunter>
	[34468]	= true,	-- Noozle Whizzlestick <Mage>
	[34465]	= true,	-- Velanaa <Paladin>
	[34471]	= true,	-- Baelnor Lightbearer <Paladin>
	[34466]	= true,	-- Anthar Forgemender <Priest>
	[34473]	= true,	-- Brienna Nightfell <Priest>
	[34472]	= true,	-- Irieth Shadowstep <Rogue>
	[34470]	= true,	-- Saamul <Shaman>
	[34463]	= true,	-- Shaabad <Shaman>
	[34474]	= true,	-- Serissa Grimdabbler <Warlock>
	[34475]	= true,	-- Shocuul <Warrior>

	[34458]	= true,	-- Gorgrim Shadowcleave <Death Knight>
	[34451]	= true,	-- Birana Stormhoof <Druid>
	[34459]	= true,	-- Erin Misthoof <Druid>
	[34448]	= true,	-- Ruj'kah <Hunter>
	[34449]	= true,	-- Ginselle Blightslinger <Mage>
	[34445]	= true,	-- Liandra Suncaller <Paladin>
	[34456]	= true,	-- Malithas Brightblade <Paladin>
	[34447]	= true,	-- Caiphus the Stern <Priest>
	[34441]	= true,	-- Vivienne Blackwhisper <Priest>
	[34454]	= true,	-- Maz'dinah <Rogue>
	[34444]	= true,	-- Thrakgar	<Shaman>
	[34455]	= true,	-- Broln Stouthorn <Shaman>
	[34450]	= true,	-- Harkzog <Warlock>
	[34453]	= true,	-- Narrhok Steelbreaker <Warrior>

	[35610]	= true,	-- Cat <Ruj'kah's Pet / Alyssia Moonstalker's Pet>
	[35465]	= true,	-- Zhaagrym <Harkzog's Minion / Serissa Grimdabbler's Minion>

	[34497]	= true,	-- Fjola Lightbane
	[34496]	= true,	-- Eydis Darkbane
	[34564]	= true,	-- Anub'arak (Trial of the Crusader)

	-------------------------------------------------------------------------------
	-- Trial of Valor 7.2
	-------------------------------------------------------------------------------
	[114263] = true, -- Odyn
	[114537] = true, -- Helya
	[114323] = true, -- Guarm

	-------------------------------------------------------------------------------
	-- Uldaman
	-------------------------------------------------------------------------------
	[7057]	= true,	-- Digmaster Shovelphlange
	-- [2932]	= true,	-- Magregan Deepshadow (Outside the instance, not elite)
	[6910]	= true,	-- Revelosh
	[7228]	= true,	-- Ironaya
	[7023]	= true,	-- Obsidian Sentinel
	[7206]	= true,	-- Ancient Stone Keeper
	[7291]	= true,	-- Galgann Firehammer
	[4854]	= true,	-- Grimlok
	[2748]	= true,	-- Archaedas
	[6906]	= true,	-- Baelog

	-------------------------------------------------------------------------------
	-- Ulduar: The Antechamber of Ulduar
	-------------------------------------------------------------------------------
	[32867]	= true,	-- Steelbreaker
	[32927]	= true,	-- Runemaster Molgeim
	[32857]	= true,	-- Stormcaller Brundir
	[32930]	= true,	-- Kologarn
	[33515]	= true,	-- Auriaya
	[34035]	= true,	-- Feral Defender
	[32933]	= true,	-- Left Arm
	[32934]	= true,	-- Right Arm
	[33524]	= true,	-- Saronite Animus

	-------------------------------------------------------------------------------
	-- Ulduar: The Celestial Planetarium
	-------------------------------------------------------------------------------
	[32871]	= true,	-- Algalon the Observer

	-------------------------------------------------------------------------------
	-- Ulduar: The Descent into Madness
	-------------------------------------------------------------------------------
	[33271]	= true,	-- General Vezax
	[33890]	= true,	-- Brain of Yogg-Saron
	[33136]	= true,	-- Guardian of Yogg-Saron
	[33288]	= true,	-- Yogg-Saron
	[32915]	= true,	-- Elder Brightleaf
	[32913]	= true,	-- Elder Ironbranch
	[32914]	= true,	-- Elder Stonebark
	[32882]	= true,	-- Jormungar Behemoth
	[33432]	= true,	-- Leviathan Mk II
	[34014]	= true,	-- Sanctum Sentry

	-------------------------------------------------------------------------------
	-- Ulduar: The Keepers of Ulduar
	-------------------------------------------------------------------------------
	[33350]	= true,	-- Mimiron
	[32906]	= true,	-- Freya
	[32865]	= true,	-- Thorim
	[32845]	= true,	-- Hodir

	-------------------------------------------------------------------------------
	-- Ulduar: The Siege of Ulduar
	-------------------------------------------------------------------------------
	[33113]	= true,	-- Flame Leviathan
	[33118]	= true,	-- Ignis the Furnace Master
	[33186]	= true,	-- Razorscale
	[33293]	= true,	-- XT-002 Deconstructor
	[33670]	= true,	-- Aerial Command Unit
	[33329]	= true,	-- Heart of the Deconstructor
	[33651]	= true,	-- VX-001

	-------------------------------------------------------------------------------
	-- Un'Goro Crater
	-------------------------------------------------------------------------------
	[14461]	= true,	-- Baron Charr

	-------------------------------------------------------------------------------
	-- Upper Blackrock Spire
	-------------------------------------------------------------------------------
	[76413]	= true,	-- Orebender Gor'ashan
	[76021]	= true,	-- Kyrak
	[79912]	= true,	-- Commander Tharbek
	[76585]	= true,	-- Ragewing the Untamed
	[77120]	= true,	-- Warlord Zaela

	-------------------------------------------------------------------------------
	-- Utgarde Keep: Main Bosses
	-------------------------------------------------------------------------------
	[23953]	= true,	-- Prince Keleseth (Utgarde Keep)
	[27390]	= true,	-- Skarvald the Constructor
	[24200]	= true,	-- Skarvald the Constructor
	[23954]	= true,	-- Ingvar the Plunderer
	[23980]	= true,	-- Ingvar the Plunderer

	-------------------------------------------------------------------------------
	-- Utgarde Keep: Secondary Bosses
	-------------------------------------------------------------------------------
	[27389]	= true,	-- Dalronn the Controller
	[24201]	= true,	-- Dalronn the Controller

	-------------------------------------------------------------------------------
	-- Utgarde Pinnacle
	-------------------------------------------------------------------------------
	[26668]	= true,	-- Svala Sorrowgrave
	[26687]	= true,	-- Gortok Palehoof
	[26693]	= true,	-- Skadi the Ruthless
	[26861]	= true,	-- King Ymiron

	-------------------------------------------------------------------------------
	-- Wailing Caverns
	-------------------------------------------------------------------------------
	[5775]	= true,	-- Verdan the Everliving
	[3670]	= true,	-- Lord Pythas
	[3673]	= true,	-- Lord Serpentis
	[3669]	= true,	-- Lord Cobrahn
	[3654]	= true,	-- Mutanus the Devourer
	[3674]	= true,	-- Skum
	[3653]	= true,	-- Kresh
	[3671]	= true,	-- Lady Anacondra
	[5912]	= true,	-- Deviate Faerie Dragon
	[3672]	= true,	-- Boahn, outside
	[3655]	= true,	-- Mad Magglish, outside
	[3652]	= true,	-- Trigore the Lasher, outside

	-------------------------------------------------------------------------------
	-- Vault of Archavon
	-------------------------------------------------------------------------------
	[31125]	= true,	-- Archavon the Stone Watcher
	[33993]	= true,	-- Emalon the Storm Watcher
	[35013]	= true,	-- Koralon the Flamewatcher
	[38433]	= true,	-- Toravon the Ice Watcher

	-------------------------------------------------------------------------------
	-- Vault of the Wardens
	-------------------------------------------------------------------------------
	[95885] = true, -- Tirathon Saltheril
	[95886] = true, -- Ash'golm
	[95887] = true, -- Glazer
	[95888] = true, -- Cordana Felsong
	[96015] = true, -- Inquisitor Tormentorum

	-------------------------------------------------------------------------------
	-- Violet Hold (Broken Isles)
	-------------------------------------------------------------------------------
	[101950] = true, -- Mindflayer Kaahrj
	[101976] = true, -- Millificent Manastorm
	[101995] = true, -- Festerface
	[101951] = true, -- Shivermaw
	[102246] = true, -- Anub'esset
	[102387] = true, -- Sael'orn
	[102431] = true, -- Blood-Princess Thal'ena
	[102446] = true, -- Fel Lord Betrug

	-------------------------------------------------------------------------------
	-- Well of Eternity 4.3
	-------------------------------------------------------------------------------

	[55085]	= true,	-- Peroth'arn
	[54853]	= true,	-- Queen Azshara
	[54969]	= true,	-- Mannoroth
	[55419]	= true,	-- Varo'then

	-------------------------------------------------------------------------------
	-- Winterspring
	-------------------------------------------------------------------------------
	[14457]	= true,	-- Princess Tempestria

	-------------------------------------------------------------------------------
	-- World Dragons
	-------------------------------------------------------------------------------
	[14889]	= true,	-- Emeriss
	[14888]	= true,	-- Lethon
	[14890]	= true,	-- Taerar
	[14887]	= true,	-- Ysondre

	-------------------------------------------------------------------------------
	-- Zul'Aman
	-------------------------------------------------------------------------------
	-- Animal Bosses
	[29024]	= true,	-- Nalorakk
	[28514]	= true,	-- Nalorakk
	[23576]	= true,	-- Nalorakk
	[23574]	= true,	-- Akil'zon
	[23578]	= true,	-- Jan'alai
	[28515]	= true,	-- Jan'alai
	[29023]	= true,	-- Jan'alai
	[23577]	= true,	-- Halazzi
	[28517]	= true,	-- Halazzi
	[29022]	= true,	-- Halazzi
	[24239]	= true,	-- Malacrass

	-- Final Bosses
	[24239]	= true,	-- Hex Lord Malacrass
	[23863]	= true,	-- Zul'jin

	-------------------------------------------------------------------------------
	-- Zul'Farrak
	-------------------------------------------------------------------------------
	[7267]	= true,	-- Chief Ukorz Sandscalp
	[7271]	= true,	-- Witch Doctor Zum'rah
	[7272]	= true,	-- Theka the Martyr
	[7273]	= true,	-- Gahz'rilla
	[7274]	= true,	-- Sandfury Executioner
	[7275]	= true,	-- Shadowpriest Sezz'ziz
	[7604]	= true,	-- Sergeant Bly
	[7605]	= true,	-- Raven
	[7606]	= true,	-- Oro Eyegouge
	[7608]	= true,	-- Murta Grimgut
	[7795]	= true,	-- Hydromancer Velratha
	[7796]	= true,	-- Nekrum Gutchewer
	[7797]	= true,	-- Ruuzlu
	[8127]	= true,	-- Antu'sul
	[10080]	= true,	-- Sandarr Dunereaver
	[10082]	= true,	-- Zerillis
	[10081]	= true,	-- Dustwraith

	-------------------------------------------------------------------------------
	-- Zul'Gurub - 4.1
	-------------------------------------------------------------------------------
	[52053]	= true,	-- Zanzil
	[52059]	= true,	-- High Priestess Kilnara
	[52148]	= true,	-- Jin'do the Godbreaker
	[52151]	= true,	-- Bloodlord Mandokir
	[52155]	= true,	-- High Priest Venoxis
	--[52157]	= true,	-- Ohgan (Mandokirs Raptor) disabled by Mikk- this is an add, not a boss.
	[52269]	= true,	-- Renataki
	[52258]	= true,	-- Gri'lek
	[52271]	= true,	-- Hazza'rah
	[52286]	= true,	-- Wushoolay
}


--[[--------------------------------------------------------------------------------------------------------------------
  TinyDPS - A lightweight damage and healing meter.
  Copyright © 2010-2019 Sideshow, Talyrius <contact@talyrius.net>. All rights reserved.
  See the accompanying LICENSE file for more information.

  Authorized distributions:
    https://github.com/Talyrius/TinyDPS
    https://www.curseforge.com/wow/addons/tinydps
    https://www.wowinterface.com/downloads/info16780-TinyDPS.html
--]]--------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- Localization --
------------------------------------------------------------------------------------------------------------------------
if IsAddOnLoaded('Skada') then return end

local tdpsL = {}

if GetLocale() == "zhCN" then
  tdpsL.fight = "战斗"
  tdpsL.allFight = "总体     所有战斗"
  tdpsL.current = "当前"
  tdpsL.resetAllData = "重置所有数据"
  tdpsL.showDamage = "显示伤害"
  tdpsL.showHealing = "显示治疗"

  tdpsL.report = "报告"
  tdpsL.top3 = "前 3"
  tdpsL.top5 = "前 5"
  tdpsL.top10 = "前 10"
  tdpsL.say = "说话"
  tdpsL.instance = "副本"
  tdpsL.raid = "团队"
  tdpsL.party = "队伍"
  tdpsL.guild = "公会"
  tdpsL.officer = "官员"
  tdpsL.whisper = "密语目标"
  tdpsL.whisper2 = "密语 <名字>"
  tdpsL.channel = "频道"

  tdpsL.options = "选项"
  tdpsL.text = "文字"
  tdpsL.size = "大小"
  tdpsL.increase = "增加"
  tdpsL.decrease = "减少"
  tdpsL.font = "字体"
  tdpsL.layout = "布局"
  tdpsL.outline = "描边"
  tdpsL.nudge = "微调"

  tdpsL.dps = "DPS"
  tdpsL.rank = "排名"
  tdpsL.percent = "百分比"
  tdpsL.amount = "总量"
  tdpsL.short = "缩略模式"
  tdpsL.none = "无"
  tdpsL.thin = "细"
  tdpsL.thick = "粗"
  tdpsL.shadow = "阴影"
  tdpsL.mono = "单色"

  tdpsL.bars = "计量条"
  tdpsL.height = "高"
  tdpsL.spacing = "间距"
  tdpsL.maximum = "最多显示"
  tdpsL.oneYourself = "1 (自己)"
  tdpsL.five = "5"
  tdpsL.ten = "10"
  tdpsL.fifteen = "15"
  tdpsL.twenty = "20"
  tdpsL.unlimited = "? (所有)"

  tdpsL.colors = "颜色"
  tdpsL.barBackdrop = "计量条背景"
  tdpsL.frameBorder = "框架边框"
  tdpsL.frameBackdrop = "框架背景"
  tdpsL.dimClassColors = "暗淡职业颜色"
  tdpsL.resetClassColors = "重置职业颜色"
  tdpsL.swapBarTextColor = "互换计量条/文字颜色"

  tdpsL.history = "      %i  历史战斗记录"
  tdpsL.keepOnlyBossFights = "只保留boss战斗记录"

  tdpsL.various = "个性化"
  tdpsL.hideAlways = "始终隐藏"
  tdpsL.hideInPvP = "PVP时隐藏"
  tdpsL.hideInBattle = "Hide In Pet Battle"
  tdpsL.hideWhenSolo = "Solo时隐藏"
  tdpsL.hideInCombat = "战斗中隐藏"
  tdpsL.hideOutOfCombat = "脱离战斗后隐藏"
  tdpsL.growUpwards = "计量条向上增长"
  tdpsL.minimapButton = "小地图按钮"
  tdpsL.trackSpellDetails = "显示法术详情"
  tdpsL.resetOnNewGroup = "新队伍时重置"
  tdpsL.refreshEverySecond = "每秒刷新"

  tdpsL.spells = "      前 %i 技能"
  tdpsL.targets = "      前 %i 目标"

  tdpsL.close = "关闭"
  tdpsL.empty = "<空>"

  tdpsL.helpVersion = "版本"
  tdpsL.helpMove = "移动: 按住 shift 鼠标左键拖动"
  tdpsL.helpResize = "宽: 右下角调整宽度"
  tdpsL.helpToggle = "输入: type /tdps 隐藏或显示"
  tdpsL.helpParameters1 = "/tdps help | reset | damage | healing | whisper <name>"
  tdpsL.helpParameters2 = "/tdps visiblebars <number> | reportlength <number>"

  tdpsL.allClear = "所有数据已被重置"
  tdpsL.personal = "玩家"
  tdpsL.byPets = "宠物(s)"
  tdpsL.topAbilities = "技能"
  tdpsL.topTargets = "目标"

  tdpsL.noTarget = "无效或没有目标选择"
  tdpsL.noData = "没有数据报告"

  tdpsL.tipPrefix = {
    d = "伤害为",
    h = "治疗为",
  }
  tdpsL.repPrefix = {
    d = "伤害输出为",
    h = "治疗量为",
  }
  tdpsL.overallData = "所有战斗"
  tdpsL.currentFight = "当前战斗"
  tdpsL.lastFight = "上次战斗"
  tdpsL.melee = "肉搏"
elseif GetLocale() == "zhTW" then
  tdpsL.fight = "战斗"
  tdpsL.allFight = "总体     所有战斗"
  tdpsL.current = "当前"
  tdpsL.resetAllData = "重置所有数据"
  tdpsL.showDamage = "显示伤害"
  tdpsL.showHealing = "显示治疗"

  tdpsL.report = "报告"
  tdpsL.top3 = "前 3"
  tdpsL.top5 = "前 5"
  tdpsL.top10 = "前 10"
  tdpsL.say = "说话"
  tdpsL.instance = "副本"
  tdpsL.raid = "团队"
  tdpsL.party = "队伍"
  tdpsL.guild = "公会"
  tdpsL.officer = "官员"
  tdpsL.whisper = "密语目标"
  tdpsL.whisper2 = "密语 <名字>"
  tdpsL.channel = "频道"

  tdpsL.options = "选项"
  tdpsL.text = "文字"
  tdpsL.size = "大小"
  tdpsL.increase = "增加"
  tdpsL.decrease = "减少"
  tdpsL.font = "字体"
  tdpsL.layout = "布局"
  tdpsL.outline = "描边"
  tdpsL.nudge = "微调"

  tdpsL.dps = "DPS"
  tdpsL.rank = "排名"
  tdpsL.percent = "百分比"
  tdpsL.amount = "总量"
  tdpsL.short = "缩略模式"
  tdpsL.none = "无"
  tdpsL.thin = "细"
  tdpsL.thick = "粗"
  tdpsL.shadow = "阴影"
  tdpsL.mono = "单色"

  tdpsL.bars = "计量条"
  tdpsL.height = "高"
  tdpsL.spacing = "间距"
  tdpsL.maximum = "最多显示"
  tdpsL.oneYourself = "1 (自己)"
  tdpsL.five = "5"
  tdpsL.ten = "10"
  tdpsL.fifteen = "15"
  tdpsL.twenty = "20"
  tdpsL.unlimited = "? (所有)"

  tdpsL.colors = "颜色"
  tdpsL.barBackdrop = "计量条背景"
  tdpsL.frameBorder = "框架边框"
  tdpsL.frameBackdrop = "框架背景"
  tdpsL.dimClassColors = "暗淡职业颜色"
  tdpsL.resetClassColors = "重置职业颜色"
  tdpsL.swapBarTextColor = "互换计量条/文字颜色"

  tdpsL.history = "      %i  历史战斗记录"
  tdpsL.keepOnlyBossFights = "只保留boss战斗记录"

  tdpsL.various = "个性化"
  tdpsL.hideAlways = "始终隐藏"
  tdpsL.hideInPvP = "PVP时隐藏"
  tdpsL.hideWhenSolo = "Solo时隐藏"
  tdpsL.hideInCombat = "战斗中隐藏"
  tdpsL.hideOutOfCombat = "脱离战斗后隐藏"
  tdpsL.growUpwards = "计量条向上增长"
  tdpsL.minimapButton = "小地图按钮"
  tdpsL.trackSpellDetails = "显示法术详情"
  tdpsL.resetOnNewGroup = "新队伍时重置"
  tdpsL.refreshEverySecond = "每秒刷新"

  tdpsL.spells = "      前 %i 技能"
  tdpsL.targets = "      前 %i 目标"

  tdpsL.close = "关闭"
  tdpsL.empty = "<空>"

  tdpsL.helpVersion = "版本"
  tdpsL.helpMove = "移动: 按住 shift 鼠标左键拖动"
  tdpsL.helpResize = "宽: 右下角调整宽度"
  tdpsL.helpToggle = "输入: type /tdps 隐藏或显示"
  tdpsL.helpParameters1 = "/tdps help | reset | damage | healing | whisper <name>"
  tdpsL.helpParameters2 = "/tdps visiblebars <number> | reportlength <number>"

  tdpsL.allClear = "所有数据已被重置"
  tdpsL.personal = "玩家"
  tdpsL.byPets = "宠物(s)"
  tdpsL.topAbilities = "技能"
  tdpsL.topTargets = "目标"

  tdpsL.noTarget = "无效或没有目标选择"
  tdpsL.noData = "没有数据报告"

  tdpsL.tipPrefix = {
    d = "伤害为",
    h = "治疗为",
  }
  tdpsL.repPrefix = {
    d = "伤害输出为",
    h = "治疗量为",
  }
  tdpsL.overallData = "所有战斗"
  tdpsL.currentFight = "当前战斗"
  tdpsL.lastFight = "上次战斗"
  tdpsL.melee = "肉搏"
else
  tdpsL.fight = "Fight"
  tdpsL.allFight = "Overall     All Fights"
  tdpsL.current = "Current"
  tdpsL.resetAllData = "Reset All Data"
  tdpsL.showDamage = "Show Damage"
  tdpsL.showHealing = "Show Healing"

  tdpsL.report = "Report"
  tdpsL.top3 = "Top 3"
  tdpsL.top5 = "Top 5"
  tdpsL.top10 = "Top 10"
  tdpsL.say = "Say"
  tdpsL.instance = "Instance"
  tdpsL.raid = "Raid"
  tdpsL.party = "Party"
  tdpsL.guild = "Guild"
  tdpsL.officer = "Officer"
  tdpsL.whisper = "Whisper Target"
  tdpsL.whisper2 = "Whisper <Name>"
  tdpsL.channel = "Channel"

  tdpsL.options = "Options"
  tdpsL.text = "Text"
  tdpsL.size = "Size"
  tdpsL.increase = "Increase"
  tdpsL.decrease = "Decrease"
  tdpsL.font = "Font"
  tdpsL.layout = "Layout"
  tdpsL.outline = "Outline"
  tdpsL.nudge = "Nudge"

  tdpsL.dps = "DPS"
  tdpsL.rank = "Rank"
  tdpsL.percent = "Percent"
  tdpsL.amount = "Amount"
  tdpsL.short = "Short Format"
  tdpsL.none = "None"
  tdpsL.thin = "Thin"
  tdpsL.thick = "Thick"
  tdpsL.shadow = "Shadow"
  tdpsL.mono = "Monochrome"

  tdpsL.bars = "Bars"
  tdpsL.height = "Height"
  tdpsL.spacing = "Spacing"
  tdpsL.maximum = "Visible bars"
  tdpsL.oneYourself = "1 (Yourself)"
  tdpsL.five = "5"
  tdpsL.ten = "10"
  tdpsL.fifteen = "15"
  tdpsL.twenty = "20"
  tdpsL.unlimited = "? (Unlimited)"

  tdpsL.colors = "Colors"
  tdpsL.barBackdrop = "Bar Backdrop"
  tdpsL.frameBorder = "Frame Border"
  tdpsL.frameBackdrop = "Frame Backdrop"
  tdpsL.dimClassColors = "Dim Class Colors"
  tdpsL.resetClassColors = "Reset Class Colors"
  tdpsL.swapBarTextColor = "Swap Bar/Text Color"

  tdpsL.history = "      %i  Historic Fights"
  tdpsL.keepOnlyBossFights = "Keep Only Boss Fights"

  tdpsL.various = "Various"
  tdpsL.hideAlways = "Hide Always"
  tdpsL.hideInPvP = "Hide In PvP"
  tdpsL.hideInBattle = "Hide In Pet Battle"
  tdpsL.hideWhenSolo = "Hide When Solo"
  tdpsL.hideInCombat = "Hide In Combat"
  tdpsL.hideOutOfCombat = "Hide Out Of Combat"
  tdpsL.growUpwards = "Grow Upwards"
  tdpsL.minimapButton = "Minimap Button"
  tdpsL.trackSpellDetails = "Track Spell Details"
  tdpsL.resetOnNewGroup = "Reset On New Group"
  tdpsL.refreshEverySecond = "Refresh Every Second"

  tdpsL.spells = "      %i  Spells in Tooltips"
  tdpsL.targets = "      %i  Targets in Tooltips"

  tdpsL.close = "Cancel"
  tdpsL.empty = "<Empty>"

  tdpsL.helpVersion = "Version"
  tdpsL.helpMove = "move: hold shift and drag the frame"
  tdpsL.helpResize = "resize: drag the bottom right corner"
  tdpsL.helpToggle = "toggle: type /tdps to hide or show"
  tdpsL.helpParameters1 = "/tdps help | reset | damage | healing | whisper <name>"
  tdpsL.helpParameters2 = "/tdps visiblebars <number> | reportlength <number>"

  tdpsL.allClear = "All data has been reset"
  tdpsL.personal = "Personal"
  tdpsL.byPets = "By Pet(s)"
  tdpsL.topAbilities = "Top Abilities"
  tdpsL.topTargets = "Top Targets"

  tdpsL.noTarget = "Invalid or no target selected"
  tdpsL.noData = "No data to report"

  tdpsL.tipPrefix = {
    d = "Damage for",
    h = "Healing for",
  }
  tdpsL.repPrefix = {
    d = "Damage Done for",
    h = "Healing Done for",
  }
  tdpsL.overallData = "Overall Data"
  tdpsL.currentFight = "Current Fight"
  tdpsL.lastFight = "Last Fight"
  tdpsL.melee = "Melee"
end

------------------------------------------------------------------------------------------------------------------------
-- Variables --
------------------------------------------------------------------------------------------------------------------------

local bu, bar = {}, {}
local px, com
local maxValue, barsWithValue
local scrollPos, isMovingOrSizing = 1, false
local ttSpellMerge, ttMobMerge, ttSort = {}, {}, {}
local cColor

--local isBoss = LibStub("LibBossIDs-1.0").BossIDs
local isHeal = {
  SPELL_ABSORBED = true,
  SPELL_HEAL = true,
  SPELL_PERIODIC_HEAL = true,
}
local isMiss = {
  SWING_MISSED = true,
  RANGE_MISSED = true,
  SPELL_MISSED = true,
  SPELL_PERIODIC_MISSED = true,
  DAMAGE_SHIELD_MISSED = true,
}
local isDamage = {
  SWING_DAMAGE = true,
  RANGE_DAMAGE = true,
  SPELL_DAMAGE = true,
  SPELL_PERIODIC_DAMAGE = true,
  DAMAGE_SHIELD = true,
  DAMAGE_SPLIT = true,
}
local isValidEvent = {
  SWING_DAMAGE = true,
  SWING_MISSED = true,
  RANGE_DAMAGE = true,
  RANGE_MISSED = true,
  SPELL_ABSORBED = true,
  SPELL_DAMAGE = true,
  SPELL_HEAL = true,
  SPELL_MISSED = true,
  SPELL_SUMMON = true,
  SPELL_PERIODIC_DAMAGE = true,
  SPELL_PERIODIC_HEAL = true,
  SPELL_PERIODIC_MISSED = true,
  SPELL_EXTRA_ATTACKS = true,
  DAMAGE_SHIELD = true,
  DAMAGE_SHIELD_MISSED = true,
  DAMAGE_SPLIT = true,
}
local isExcludedAbsorb = {
  [ 20711] = true, -- Spirit of Redemption
  [114556] = true, -- Purgatory
  [115069] = true, -- Stagger
  [184553] = true, -- Spirit Shift
}
local isExcludedNPC = {
  [ "76933"] = true, -- Prismatic Crystal
  ["103679"] = true, -- Soul Effigy
}
local isExcludedPet = {
  -- Totems
  [ "2630"] = true, -- Earthbind Totem
  [ "5913"] = true, -- Tremor Totem
  ["10467"] = true, -- Mana Tide Totem
  ["53006"] = true, -- Spirit Link Totem
  ["59717"] = true, -- Windwalk Totem
  ["60561"] = true, -- Earthgrab Totem
  ["61245"] = true, -- Capacitor Totem
  ["62002"] = true, -- Stormlash Totem
  -- Miscellaneous
  ["29742"] = true, -- Snake Wrap
  ["36619"] = true, -- Bone Spike
  ["38163"] = true, -- Swarming Shadows
  ["38711"] = true, -- Bone Spike
  ["38712"] = true, -- Bone Spike
}

local function initialiseSavedVariables()
  tdps = {
    speed = 1,
    width = 280,
    --version = -1,
    autoReset = true,
    swapColor = true,
    tooltipSpells = 10,
    tooltipTargets = 6,
    anchor = "BOTTOMLEFT",
    layout = 11,
    showRank = true,
    onlyBossSegments = false,
    showMinimapButton = false,
    spacing = 8,
    barHeight = 8,
    bar = {0.9, 0.9, 0.9, 1},
    barbackdrop = {1, 1, 1, 0.05},
    border = {0, 0, 0, 0},
    backdrop = {0, 0, 0, 0},
  }

  tdpsTextOffset = 6
  tdpsVisibleBars = 10
  tdpsReportLength = 25

  if GameFontNormal then
    tdpsFont = {
      name = GameFontNormal:GetFont(),
      size = 12,
      outline = "OUTLINE",
      shadow = 1,
    }
  else
    tdpsFont = {
      name = [[Interface\AddOns\_ShiGuang\Media\Fonts\Pixel.ttf]],
      size = 13,
      outline = "OUTLINE, MONOCHROME",
      shadow = 0,
    }
  end

  tdpsColorAlpha = .95
end

tdpsPosition = {
  x = 0,
  y = 0,
}

local function initialiseSavedVariablesPerCharacter()
  --tdpsVersion = -1
  tdpsPet, tdpsPlayer, tdpsLink = {}, {}, {}
  tdpsFight = {{
      name = tdpsL.overallData,
      d = 0, h = 0
    }, {
      name = nil,
      boss = nil,
      d = 0,
      h = 0
    },
  }
  tdpsF = 2
  tdpsV = "d"
  tdpsNumberOfFights = 2
end

initialiseSavedVariables()
initialiseSavedVariablesPerCharacter()

------------------------------------------------------------------------------------------------------------------------
-- Frames --
------------------------------------------------------------------------------------------------------------------------

-- anchor frame
CreateFrame("Frame", "tdpsAnchor", UIParent)
tdpsAnchor:SetWidth(3)
tdpsAnchor:SetHeight(3)
tdpsAnchor:SetMovable(true)
tdpsAnchor:SetPoint("bottomright", UIParent, "bottomright", 0, 21)
tdpsAnchor:SetFrameStrata("BACKGROUND")
tdpsAnchor:SetBackdrop({
  bgFile = [[Interface\AddOns\_ShiGuang\Media\Modules\UI-StatusBar.tga]],
  edgeFile = [[Interface\AddOns\_ShiGuang\Media\Modules\UI-StatusBar.tga]],
  tile = false,
  tileSize = 1,
  edgeSize = 1,
  insets = {
    left = 1,
    right = 1,
    top = 1,
    bottom = 1,
  },
})
tdpsAnchor:SetBackdropColor(0, 0, 0, 0)
tdpsAnchor:SetBackdropBorderColor(0, 0, 0, 0)

-- main window
CreateFrame("Frame", "tdpsFrame", UIParent)
tdpsFrame:SetWidth(265)
tdpsFrame:SetHeight(tdps.barHeight / 2)
tdpsFrame:SetClampedToScreen(true)
tdpsFrame:EnableMouse(true)
tdpsFrame:EnableMouseWheel(true)
tdpsFrame:SetResizable(true)
tdpsFrame:SetPoint("TOPLEFT", tdpsAnchor, "TOPLEFT", 0, 0)
tdpsFrame:SetFrameStrata("MEDIUM")
tdpsFrame:SetFrameLevel(1)
tdpsFrame:SetBackdrop({
  bgFile = [[Interface\AddOns\_ShiGuang\Media\Modules\UI-StatusBar.tga]],
  edgeFile = [[Interface\AddOns\_ShiGuang\Media\Modules\UI-StatusBar.tga]],
  tile = false,
  tileSize = 1,
  edgeSize = 1,
  insets = {
    left = 1,
    right = 1,
    top = 1,
    bottom = 1,
  },
})

-- main window animation
local tdpsAnimationGroup = tdpsFrame:CreateAnimationGroup()
local tdpsAnimation = tdpsAnimationGroup:CreateAnimation("Alpha")
tdpsAnimation:SetFromAlpha(1)
tdpsAnimation:SetToAlpha(0)
tdpsAnimation:SetDuration(.2)
tdpsAnimation:SetScript("OnFinished", function(self, requested)
  tdpsRefresh()
end)

-- title font string
tdpsFrame:CreateFontString("noData", "OVERLAY")
noData:SetPoint("bottomright", UIParent, "bottomright", -2, 21)
noData:SetJustifyH("CENTER")
noData:SetFont(tdpsFont.name, tdpsFont.size)
noData:SetShadowColor(.1, .1, .1, 1)
noData:SetShadowOffset(tdpsFont.shadow, tdpsFont.shadow * -1)
noData:SetTextColor(1, 1, 1, .07)
noData:SetText("")

-- resize frame
CreateFrame("Frame", "tdpsResizeFrame", tdpsFrame)
tdpsResizeFrame:SetFrameStrata("MEDIUM")
tdpsResizeFrame:SetFrameLevel(3)
tdpsResizeFrame:SetWidth(6)
tdpsResizeFrame:SetHeight(6)
tdpsResizeFrame:SetPoint("BOTTOMRIGHT", tdpsFrame, "BOTTOMRIGHT", 0, 0)
tdpsResizeFrame:EnableMouse(true)
tdpsResizeFrame:CreateTexture("tdpsResizeTexture")
tdpsResizeTexture:SetTexture([[Interface\Buttons\UI-AutoCastableOverlay]])
tdpsResizeTexture:SetTexCoord(.619, .760, .612, .762)
tdpsResizeTexture:SetDesaturated(true)
tdpsResizeTexture:SetAlpha(0)
tdpsResizeTexture:ClearAllPoints()
tdpsResizeTexture:SetPoint("TOPLEFT", tdpsResizeFrame)
tdpsResizeTexture:SetPoint("BOTTOMRIGHT", tdpsResizeFrame, "BOTTOMRIGHT", 0, 0)
tdpsResizeFrame:SetScale(1.3)

-- minimap button frame
CreateFrame("Button", "tdpsButtonFrame", Minimap)
tdpsButtonFrame:SetHeight(30)
tdpsButtonFrame:SetWidth(30)
tdpsButtonFrame:SetMovable(true)
tdpsButtonFrame:SetClampedToScreen(true)
tdpsButtonFrame:SetUserPlaced(true)
tdpsButtonFrame:EnableMouse(true)
tdpsButtonFrame:RegisterForDrag("LeftButton")
tdpsButtonFrame:SetFrameStrata("MEDIUM")
tdpsButtonFrame:SetPoint("CENTER", Minimap:GetWidth() / 2 * -1, Minimap:GetHeight() / 2 * -1)
tdpsButtonFrame:CreateTexture("tdpsButtonTexture", "BACKGROUND")
tdpsButtonTexture:SetWidth(24)
tdpsButtonTexture:SetHeight(24)
tdpsButtonTexture:SetTexture([[Interface\AddOns\_ShiGuang\Media\Modules\minimapbutton.blp]])
tdpsButtonTexture:SetPoint("CENTER")
tdpsButtonFrame:SetNormalTexture(tdpsButtonTexture)
tdpsButtonFrame:CreateTexture("tdpsButtonTexturePushed", "BACKGROUND")
tdpsButtonTexturePushed:SetWidth(24)
tdpsButtonTexturePushed:SetHeight(24)
tdpsButtonTexturePushed:SetTexture([[Interface\AddOns\_ShiGuang\Media\Modules\minimapbutton.blp]])
tdpsButtonTexturePushed:SetPoint("CENTER", 1, -1)
tdpsButtonFrame:SetPushedTexture(tdpsButtonTexturePushed)
tdpsButtonFrame:SetHighlightTexture([[Interface\Minimap\UI-Minimap-ZoomButton-Highlight]])
tdpsButtonFrame:CreateTexture("tdpsButtonOverlay", "OVERLAY")
tdpsButtonOverlay:SetWidth(53)
tdpsButtonOverlay:SetHeight(53)
tdpsButtonOverlay:SetTexture([[Interface\Minimap\MiniMap-TrackingBorder]])
tdpsButtonOverlay:SetPoint("TOPLEFT")

-- dropdown frame
CreateFrame("Frame", "tdpsDropDown")
tdpsDropDown.displayMode = "MENU"

------------------------------------------------------------------------------------------------------------------------
-- Functions --
------------------------------------------------------------------------------------------------------------------------

-- make local references to globals (faster)
local tonumber, band = tonumber, bit.band
local floor, abs = floor, abs
local sort, tremove, tinsert, wipe = sort, tremove, tinsert, wipe
local pairs, ipairs, type = pairs, ipairs, type
local strsplit, format = strsplit, format
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local UnitName, UnitGUID, UnitClass, UnitIsPlayer, UnitAffectingCombat = UnitName, UnitGUID, UnitClass, UnitIsPlayer,
UnitAffectingCombat
local IsInInstance, IsInRaid, IsInGroup, InCombatLockdown, IsInBattle = IsInInstance, IsInRaid, IsInGroup,
InCombatLockdown, C_PetBattles.IsInBattle
local GetNumGroupMembers, GetWorldPVPAreaInfo, GetBestMapForUnit = GetNumGroupMembers, GetWorldPVPAreaInfo,
C_Map.GetBestMapForUnit

-- some random functions
local function round(num, idp)
  return floor(num * (10 ^ (idp or 0)) + .5) / (10 ^ (idp or 0))
end

local function echo(str)
  print("|cfffef00fTinyDPS |cff82e2eb"..(str or ""))
end

local function getClass(name)
  local _, class = UnitClass(name)
  return class or "UNKNOWN"
end

local function isPvPZone()
  local uiMapID = GetBestMapForUnit("player")
  local _, instanceType = IsInInstance()
  local _, _, isActiveWintergrasp = GetWorldPVPAreaInfo(1)
  local _, _, isActiveTolBarad = GetWorldPVPAreaInfo(2)
  local _, _, isActiveAshran = GetWorldPVPAreaInfo(3)
  if instanceType == "pvp"
  or instanceType == "arena"
  or (uiMapID == 123 and isActiveWintergrasp)
  or (uiMapID == 244 and isActiveTolBarad)
  or (uiMapID == 588 and isActiveAshran) then
    return true
  end
end

local function nudgeText()
  if tdpsTextOffset == 8 then
    tdpsTextOffset = 4
  else
    tdpsTextOffset = tdpsTextOffset + 1
  end
  for i = 1, #bar do
    bar[i].fontStringLeft:ClearAllPoints()
    bar[i].fontStringRight:ClearAllPoints()
    bar[i].fontStringRight:SetPoint("RIGHT", -1, tdpsTextOffset)
    bar[i].fontStringLeft:SetPoint("LEFT", 1, tdpsTextOffset)
    bar[i].fontStringLeft:SetPoint("RIGHT", bar[i].fontStringRight, "LEFT", -2, 1)
  end
end

local function report(button, channel, playerName)
  if type(channel) == "number" then
    destination = channel
    channel = "CHANNEL"
  end

  if channel == "WHISPER" then
    if not playerName then
      if UnitIsPlayer("target") and UnitCanCooperate("player", "target") then
        destination = GetUnitName("target", true)
      else
        echo(tdpsL.noTarget)
        return
      end
    else
      destination = playerName
    end
  end

  -- make table for sorting
  local report = {}
  for k, v in pairs(tdpsPlayer) do
    local reportPlayer = {
      name = strsplit("-", tdpsPlayer[k].name),
      n = tdpsPlayer[k].fight[tdpsF][tdpsV],
      t = tdpsPlayer[k].fight[tdpsF].t,
    }
    local pet = tdpsPlayer[k].pet
    for i = 1, #pet do
      -- add pet number
      reportPlayer.n = reportPlayer.n + tdpsPet[pet[i]].fight[tdpsF][tdpsV]
      -- check time
      if tdpsPet[pet[i]].fight[tdpsF].t > reportPlayer.t then
        reportPlayer.t = tdpsPet[pet[i]].fight[tdpsF].t
      end
    end
    tinsert(report, reportPlayer)
  end
  sort(report, function(x, y)
    return x.n > y.n
  end)

  -- check if there is any data
  if not report[1] or report[1].n == 0 then
    echo(tdpsL.noData)
    return
  end

  -- output report title
  if tdpsF == 2 then
    SendChatMessage(format("%s %s", tdpsL.repPrefix[tdpsV], tdpsL.lastFight), channel, nil, destination)
  else
    SendChatMessage(format("%s %s", tdpsL.repPrefix[tdpsV], tdpsFight[tdpsF].name or "?"), channel, nil, destination)
  end

  -- output the text lines
  for i = 1, math.min(#report, tdpsReportLength) do
    if report[i].n > 0 then
      SendChatMessage(format("%i. %s    %i    %i%%    (%i)", i, report[i].name, report[i].n, report[i].n /
      tdpsFight[tdpsF][tdpsV] * 100, report[i].n / report[i].t), channel, nil, destination)
    end
  end
end

local function visibilityEvent()
  if (tdps.hidePvP and isPvPZone())
  or (tdps.hideBattle and IsInBattle())
  or (tdps.hideSolo and not IsInGroup())
  or (tdps.hideOOC and not UnitAffectingCombat("player"))
  or (tdps.hideIC and UnitAffectingCombat("player")) then
    tdpsFrame:Hide()
  else
    tdpsFrame:Show()
    tdpsRefresh()
  end
end

local function deleteSpellData()
  for _, v in pairs(tdpsPlayer) do
    for i = 1, #v.fight do
      v.fight[i].ds, v.fight[i].hs = {}, {}
    end
  end
  for _, v in pairs(tdpsPet) do
    for i = 1, #v.fight do
      v.fight[i].ds, v.fight[i].hs = {}, {}
    end
  end
  -- cleanup memory
  if not InCombatLockdown() then
    collectgarbage()
  end
end

local function short(n)
  if n > 9999999 then
    return format("%.2f千万", n / 10000000)
  elseif n > 9999 then
    return format("%.1f万", n / 10000)
  --elseif n > 9999 then
    --return format("%.1fK", n / 10000)
  else
    return format("%i", n)
  end
end

local textLayout = {
  -- bits: 8 = dps, 4 = percentage, 2 = amount, 1 = short format. Example: 13 = 1101 = percentage and dps (short)
  [0] = function(i, n, t)
    bar[i].fontStringRight:SetText("")
  end,
  [1] = function(i, n, t)
    bar[i].fontStringRight:SetText("")
  end,
  [2] = function(i, n, t)
    bar[i].fontStringRight:SetFormattedText("%i", n)
  end,
  [3] = function(i, n, t)
    bar[i].fontStringRight:SetText(short(n))
  end,
  [4] = function(i, n, t)
    bar[i].fontStringRight:SetFormattedText("|cff70C0F5%i%%|r", n / tdpsFight[tdpsF][tdpsV] * 100)
  end,
  [5] = function(i, n, t)
    bar[i].fontStringRight:SetFormattedText("|cff70C0F5%i%%|r", n / tdpsFight[tdpsF][tdpsV] * 100)
  end,
  [6] = function(i, n, t)
    bar[i].fontStringRight:SetFormattedText("|cff70C0F5%i%%|r    [%i]", n / tdpsFight[tdpsF][tdpsV] * 100, n / t)
  end,
  [7] = function(i, n, t)
    bar[i].fontStringRight:SetFormattedText("|cff70C0F5%i%%|r    [%s]", n / tdpsFight[tdpsF][tdpsV] * 100, short(n))
  end,
  [8] = function(i, n, t)
    bar[i].fontStringRight:SetFormattedText("%i", n / t)
  end,
  [9] = function(i, n, t)
    bar[i].fontStringRight:SetText(short(n / t))
  end,
  [10] = function(i, n, t)
    bar[i].fontStringRight:SetFormattedText("%i [%i]", n, n / t)
  end,
  [11] = function(i, n, t)
    bar[i].fontStringRight:SetFormattedText("%s [%s]", short(n), short(n / t))
  end,
  [12] = function(i, n, t)
    bar[i].fontStringRight:SetFormattedText("|cff70C0F5%i%%|r    [%i]", n / tdpsFight[tdpsF][tdpsV] * 100, n / t)
  end,
  [13] = function(i, n, t)
    bar[i].fontStringRight:SetFormattedText("|cff70C0F5%i%%|r    [%s]", n / tdpsFight[tdpsF][tdpsV] * 100, short(n / t))
  end,
  [14] = function(i, n, t)
    bar[i].fontStringRight:SetFormattedText("|cff70C0F5%i%%|r    %i [%i]", n / tdpsFight[tdpsF][tdpsV] * 100, n, n / t)
  end,
  [15] = function(i, n, t)
    bar[i].fontStringRight:SetFormattedText("|cff70C0F5%i%%|r    %s [%s]", n / tdpsFight[tdpsF][tdpsV] * 100, short(n), short(n / t))
  end
}

function tdpsRefresh()
  maxValue, barsWithValue = 0, 0
  -- amount, time, height, pet, text, guid
  local n, t, h, p, g

  -- update all bar values
  for i = 1, #bar do
    bar[i]:Hide()
    g = bar[i].guid
    n, t, p = tdpsPlayer[g].fight[tdpsF][tdpsV], tdpsPlayer[g].fight[tdpsF].t, tdpsPlayer[g].pet
    for i = 1, #p do
      n = n + tdpsPet[p[i]].fight[tdpsF][tdpsV]
      if tdpsPet[p[i]].fight[tdpsF].t > t then
        t = tdpsPet[p[i]].fight[tdpsF].t
      end
    end
    -- update bar values
    if n > 0 then
      barsWithValue = barsWithValue + 1
      if n > maxValue then
        maxValue = n
      end
      textLayout[tdps.layout](i, n, t)
    end
    bar[i].n = n
  end

  -- sort all bars
  sort(bar, function(x, y)
    return x.n > y.n
  end)

  -- layout the bars
  px = -2
  if tdpsVisibleBars == 1 then
    for i = 1, #bar do
      if bar[i].name == UnitName("player") and bar[i].n > 0 then
        bar[i]:SetMinMaxValues(0, maxValue)
        bar[i]:SetValue(bar[i].n)
        bar[i]:SetPoint("TOPLEFT", tdpsFrame, "TOPLEFT", 2, px)
        if tdps.showRank then
          bar[i].fontStringLeft:SetFormattedText("%i%s%s", i, ". ", bar[i].name)
        else
          bar[i].fontStringLeft:SetText(bar[i].name)
        end
        px = px - tdps.barHeight - tdps.spacing
        bar[i]:Show()
      end
    end
  else
    local to
    if barsWithValue < tdpsVisibleBars + scrollPos - 1 then
      to = barsWithValue
    else
      to = tdpsVisibleBars + scrollPos - 1
    end
    for i = scrollPos, to do
      bar[i]:SetWidth(tdpsFrame:GetWidth() - 4)
      bar[i]:SetMinMaxValues(0, maxValue)
      bar[i]:SetValue(bar[i].n)
      bar[i]:SetPoint("TOPLEFT", tdpsFrame, "TOPLEFT", 2, px)
      if tdps.showRank then
        bar[i].fontStringLeft:SetFormattedText("%i%s%s", i, ". ", bar[i].name)
      else
        bar[i].fontStringLeft:SetText(bar[i].name)
      end
      px = px - tdps.barHeight - tdps.spacing
      bar[i]:Show()
    end
  end

  -- set the frame height
  h = abs(px) + 2 - tdps.spacing
  if h < tdps.barHeight then
    tdpsFrame:SetHeight(tdps.barHeight + 4) noData:Show()
  else
    tdpsFrame:SetHeight(h) noData:Hide()
  end
end

--[[
local function tdpsShowStatus()
  ACTION_STATUS_FADETIME = 3
  if tdpsF == 2 then
    ActionStatus_DisplayMessage(format("%s for Current Fight", viewTitle[tdpsV]), true)
  else
    ActionStatus_DisplayMessage(format("%s for %s", viewTitle[tdpsV], tdpsFight[tdpsF].name), true)
  end
end
--]]

local function changeView(button, v)
  if tdpsV == v then
    return
  end
  tdpsV = v scrollPos = 1 CloseDropDownMenus() tdpsAnimationGroup:Play()
end

local function checkView(v)
  if tdpsV == v then
    return true
  end
end

local function changeFight(button, f)
  if tdpsF == f then
    return
  else
    tdpsF = f scrollPos = 1 CloseDropDownMenus() tdpsAnimationGroup:Play()
  end
end

local function checkFight(f)
  if tdpsF == f then
    return true
  end
end

local function changeTextLayout(button, bit)
  if band(tdps.layout, bit) > 0 then
    tdps.layout = tdps.layout - bit
  else
    tdps.layout = tdps.layout + bit
  end
  tdpsRefresh()
end

local function changeNumberOfFights(button)
  if tdpsNumberOfFights == 11 then
    tdpsNumberOfFights = 2
  else
    tdpsNumberOfFights = tdpsNumberOfFights + 1
  end
  if button then
    button:SetFormattedText(tdpsL.history, tdpsNumberOfFights - 2)
  end

  -- make or delete entries for global fight data
  while #tdpsFight > tdpsNumberOfFights do
    tremove(tdpsFight)
  end
  while #tdpsFight < tdpsNumberOfFights do
    tinsert(tdpsFight, {
      name = nil,
      boss = nil,
      d = 0,
      h = 0,
    })
  end

  -- make or delete entries for combatants data
  for _, v in pairs(tdpsPlayer) do
    while #v.fight > tdpsNumberOfFights do
      tremove(v.fight)
    end
    while #v.fight < tdpsNumberOfFights do
      tinsert(v.fight, {
        d = 0,
        ds = {},
        h = 0,
        hs = {},
        t = 0,
      })
    end
  end
  for _, v in pairs(tdpsPet) do
    while #v.fight > tdpsNumberOfFights do
      tremove(v.fight)
    end
    while #v.fight < tdpsNumberOfFights do
      tinsert(v.fight, {
        d = 0,
        ds = {},
        h = 0,
        hs = {},
        t = 0,
      })
    end
  end

  --[[ adjust the current selected fight
  example: selected fight is 5; user disables fight history; we now have only 2 fights (overall and current); the new
  selected fight has to be 2 --]]
  while not tdpsFight[tdpsF] do
    tdpsF = tdpsF - 1
  end

  -- cleanup memory
  if not InCombatLockdown() then
    collectgarbage()
  end
end

local function changeBarSpacing(button)
  if tdps.spacing + 1 > 8 then
    tdps.spacing = 0
  else
    tdps.spacing = tdps.spacing + 1
  end
  button:SetText(tdpsL.spacing..": "..tdps.spacing)
  tdpsRefresh()
end

local function changeBarHeight(button, d)
  if tdps.barHeight + d < 2 then
    tdps.barHeight = 2
  elseif tdps.barHeight + d > 40 then
    tdps.barHeight = 40
  else
    tdps.barHeight = tdps.barHeight + d
  end
  for i = 1, #bar do
    bar[i]:SetHeight(tdps.barHeight)
  end
  tdpsRefresh()
end

local function changeFont(button, change, arg)
  -- check arg
  if change == "font" then
    tdpsFont.name = arg
  end
  if change == "size" then
    if tdpsFont.size + arg < 4 then
      tdpsFont.size = 4
    elseif tdpsFont.size + arg > 30 then
      tdpsFont.size = 30
    else
      tdpsFont.size = tdpsFont.size + arg
    end
  end
  if change == "outline" then
    tdpsFont.outline, tdpsFont.shadow = arg, 0
  end
  if change == "shadow" then
    tdpsFont.outline, tdpsFont.shadow = "", arg
  end
  -- set the font
  noData:SetFont(tdpsFont.name, tdpsFont.size, tdpsFont.outline)
  noData:SetShadowOffset(tdpsFont.shadow, tdpsFont.shadow * -1)
  for i = 1, #bar do
    bar[i].fontStringLeft:SetFont(tdpsFont.name, tdpsFont.size, tdpsFont.outline)
    bar[i].fontStringRight:SetFont(tdpsFont.name, tdpsFont.size, tdpsFont.outline)
    bar[i].fontStringLeft:SetShadowOffset(tdpsFont.shadow, tdpsFont.shadow * -1)
    bar[i].fontStringRight:SetShadowOffset(tdpsFont.shadow, tdpsFont.shadow * -1)
  end
end

local function changeBarColor()
  if tdps.swapColor then
    for i = 1, #bar do
      bar[i]:SetStatusBarColor(cColor[tdpsPlayer[bar[i].guid].class].r, cColor[tdpsPlayer[bar[i].guid].class].g,
      cColor[tdpsPlayer[bar[i].guid].class].b, tdpsColorAlpha)
      bar[i].fontStringLeft:SetTextColor(tdps.bar[1], tdps.bar[2], tdps.bar[3], tdps.bar[4])
      bar[i].fontStringRight:SetTextColor(tdps.bar[1], tdps.bar[2], tdps.bar[3], tdps.bar[4])
    end
  else
    for i = 1, #bar do
      bar[i]:SetStatusBarColor(tdps.bar[1], tdps.bar[2], tdps.bar[3], tdps.bar[4])
      bar[i].fontStringLeft:SetTextColor(cColor[tdpsPlayer[bar[i].guid].class].r,
      cColor[tdpsPlayer[bar[i].guid].class].g, cColor[tdpsPlayer[bar[i].guid].class].b, tdpsColorAlpha)
      bar[i].fontStringRight:SetTextColor(cColor[tdpsPlayer[bar[i].guid].class].r,
      cColor[tdpsPlayer[bar[i].guid].class].g, cColor[tdpsPlayer[bar[i].guid].class].b, tdpsColorAlpha)
    end
  end
end

local function changeBarBackdropColor()
  for i = 1, #bar do
    bar[i]:SetBackdropColor(tdps.barbackdrop[1], tdps.barbackdrop[2], tdps.barbackdrop[3], tdps.barbackdrop[4])
  end
end

local function startNewFight(target, GUID)
  local _, _, _, _, _, id = strsplit("-", GUID)
  tdpsStartNewFight = false
  tdpsInCombat = true
  if tdpsF ~= 1 then
    scrollPos = 1
  end

  -- insert a new fight at position 2
  if tdpsFight[2].d + tdpsFight[2].h > 0 and ((tdps.onlyBossSegments and tdpsFight[2].boss) or not
  tdps.onlyBossSegments) then
    tinsert(tdpsFight, 2, {
      name = target or "?",
      boss = BossIDs[tonumber(id)],  --isBoss[tonumber(id)]
      d = 0,
      h = 0,
    })
    tremove(tdpsFight)
    for _, v in pairs(tdpsPlayer) do
      tinsert(v.fight, 2, {
        d = 0,
        ds = {},
        h = 0,
        hs = {},
        t = 0,
      })
      tremove(v.fight)
    end
    for _, v in pairs(tdpsPet) do
      tinsert(v.fight, 2, {
        d = 0,
        ds = {},
        h = 0,
        hs = {},
        t = 0,
      })
      tremove(v.fight)
    end
  -- reset current fight
  else
    tdpsFight[2] = {
      name = target or "?",
      boss = BossIDs[tonumber(id)],  --isBoss[tonumber(id)],
      d = 0,
      h = 0,
    }
    for _, v in pairs(tdpsPlayer) do
      v.fight[2] = {
        d = 0,
        ds = {},
        h = 0,
        hs = {},
        t = 0,
      }
    end
    for _, v in pairs(tdpsPet) do
      v.fight[2] = {
        d = 0,
        ds = {},
        h = 0,
        hs = {},
        t = 0,
      }
    end
  end
end

local function checkCombat()
  if tdpsStartNewFight then
    return
  end
  if UnitAffectingCombat("player") or UnitAffectingCombat("pet") then
    tdpsInCombat = true
    return
  end
  for i = 1, GetNumGroupMembers() do
    if IsInRaid() then
      if UnitAffectingCombat(format("raid%i", i)) or UnitAffectingCombat(format("raidpet%i", i)) then
        tdpsInCombat = true
        return
      end
    else
      if UnitAffectingCombat(format("party%i", i)) or UnitAffectingCombat(format("partypet%i", i)) then
        tdpsInCombat = true
        return
      end
    end
  end
  tdpsInCombat = false
end

local function getPetOwnerName(petGUID)
  local n, s
  if petGUID == UnitGUID("pet") then
    n, s = UnitName("player")
    if s then
      return n.."-"..s
    else
      return n
    end
  else
    for i = 1, GetNumGroupMembers() do
      if IsInRaid() then
        if petGUID == UnitGUID(format("raidpet%i", i)) then
          n, s = UnitName(format("raid%i", i))
          if s then
            return n.."-"..s
          else
            return n
          end
        end
      else
        if petGUID == UnitGUID(format("partypet%i", i)) then
          n, s = UnitName(format("party%i", i))
          if s then
            return n.."-"..s
          else
            return n
          end
        end
      end
    end
  end
end

local function getPetOwnerGUID(petGUID)
  if petGUID == UnitGUID("pet") then
    return UnitGUID("player")
  else
    for i = 1, GetNumGroupMembers() do
      if IsInRaid() then
        if petGUID == UnitGUID(format("raidpet%i", i)) then
          return UnitGUID(format("raid%i", i))
        end
      else
        if petGUID == UnitGUID(format("partypet%i", i)) then
          return UnitGUID(format("party%i", i))
        end
      end
    end
  end
end

local function isPartyPet(petGUID)
  if petGUID == UnitGUID("pet") then
    return true
  else
    for i = 1, GetNumGroupMembers() do
      if IsInRaid() then
        if petGUID == UnitGUID(format("raidpet%i", i)) then
          return true
        end
      else
        if petGUID == UnitGUID(format("partypet%i", i)) then
          return true
        end
      end
    end
  end
end

local function toggleMinimapButton()
  tdps.showMinimapButton = not tdps.showMinimapButton
  if tdps.showMinimapButton then
    tdpsRefresh()
    tdpsButtonFrame:Show()
  else
    tdpsButtonFrame:Hide()
  end
end

--local function ver()
  --echo(tdpsL.helpVersion.." "..GetAddOnMetadata("TinyDPS", "Version").." by Sideshow (formerly) and Talyrius")
--end

local function slashhelp()
  echo(tdpsL.helpParameters1)
  echo(tdpsL.helpParameters2)
end

local function help()
  ver()
  echo("- "..tdpsL.helpMove)
  echo("- "..tdpsL.helpResize)
  echo("- "..tdpsL.helpToggle)
  slashhelp()
end

local function reset()
  -- hide all bars in the GUI
  for i = 1, #bar do
    bar[i]:ClearAllPoints()
    bar[i]:Hide()
  end
  -- delete data
  tdpsPlayer, tdpsPet, tdpsLink, tdpsFight, bar = {}, {}, {}, {}, {}
  -- make new fight data
  tinsert(tdpsFight, {
    name = tdpsL.overallData,
    d = 0,
    h = 0,
  })
  while #tdpsFight < tdpsNumberOfFights do
    tinsert(tdpsFight, 2, {
      name = nil,
      boss = false,
      d = 0,
      h = 0,
    })
  end
  -- reset scroll position
  scrollPos = 1
  -- return to current fight if needed
  if tdpsF > 2 then
    tdpsF = 2
  end
  -- reset the window
  tdpsFrame:SetHeight(tdps.barHeight + 4)
  noData:Show()
  -- output message
  echo(tdpsL.allClear)
  CloseDropDownMenus()
  -- cleanup memory
  if not InCombatLockdown() then
    collectgarbage()
  end
end

local function toggle()
  if tdpsFrame:IsVisible() then
    CloseDropDownMenus()
    tdps.hidePvP, tdps.hideBattle, tdps.hideSolo, tdps.hideIC, tdps.hideOOC = true, true, true, true, true
    tdpsFrame:Hide()
  else
    CloseDropDownMenus()
    tdps.hidePvP, tdps.hideBattle, tdps.hideSolo, tdps.hideIC, tdps.hideOOC = nil, nil, nil, nil, nil
    tdpsRefresh()
    tdpsFrame:Show()
  end
  PlaySound(SOUNDKIT.GS_TITLE_OPTION_EXIT)
end

SLASH_TINYDPS1, SLASH_TINYDPS2 = "/tinydps", "/tdps"
function SlashCmdList.TINYDPS(msg, editbox)
  local cmd, arg = strsplit(" ", strlower(msg))
  if cmd == "reset" or cmd == "r" then
    reset()
  elseif cmd == "damage" or cmd == "d" then
    changeView(nil, "d")
  elseif cmd == "healing" or cmd == "h" then
    changeView(nil, "h")
  elseif cmd == "reportlength" and tonumber(arg) then
    tdpsReportLength = min(40, max(1, tonumber(arg)))
  elseif cmd == "visiblebars" and tonumber(arg) then
    tdpsVisibleBars = min(40, max(1, tonumber(arg))) scrollPos = 1 tdpsRefresh()
  elseif cmd == "whisper" and arg then
    report(nil, "WHISPER", arg)
  elseif cmd == "help" or cmd == "?" then
    help()
  elseif cmd == "" then
    toggle()
  else
    slashhelp()
  end
end

local function scroll(d)
  if bar[1] and bar[1].n > 0 and scrollPos - d > 0 and scrollPos - d + tdpsVisibleBars <= barsWithValue + 1 and
  tdpsVisibleBars > 1 then
    scrollPos = scrollPos - d
    tdpsRefresh()
  end
end

-- function for adding buttons in the context menu
local function newBu(...)
  --[[ level, text, title, notCheckable, hasArrow, value, keepShownOnClick, func, arg1, arg2, checked, disabled,
  isNotRadio, hasColorSwatch, swatchFunc, hasOpacity, opacityFunc, r, g, b, opacity, notClickable --]]
  level, bu.text, bu.isTitle, bu.notCheckable, bu.hasArrow, bu.value, bu.keepShownOnClick, bu.func, bu.arg1, bu.arg2,
  bu.checked, bu.disabled, bu.isNotRadio, bu.hasColorSwatch, bu.swatchFunc, bu.hasOpacity, bu.opacityFunc, bu.r, bu.g,
  bu.b, bu.opacity, bu.notClickable = ...
  UIDropDownMenu_AddButton(bu, level)
  wipe(bu)
end

tdpsDropDown.initialize = function(self, level)
  if level == 1 then
    PlaySound(SOUNDKIT.GS_TITLE_OPTION_EXIT)
    newBu(level, "TinyDPS       ", 1, 1)
    newBu(level, tdpsL.fight, nil, 1, 1, "fight", 1)
    newBu(level, tdpsL.report, nil, 1, 1, "report", 1)
    newBu(level, tdpsL.options, nil, 1, 1, "options", 1)
    newBu(level, tdpsL.close, nil, 1)
  elseif level == 2 and UIDROPDOWNMENU_MENU_VALUE == "fight" then
    newBu(level, tdpsL.allFight, nil, nil, nil, nil, nil, changeFight, 1, nil, checkFight(1))
    newBu(level, tdpsL.current.."    "..(tdpsFight[2].name or tdpsL.empty), nil, nil, nil, nil, nil, changeFight, 2,
    nil, checkFight(2))
    if tdpsNumberOfFights > 2 then
      newBu(level, "", nil, 1, nil, nil, nil, nil, nil, nil, nil, 1)
    end
    for i = 3, tdpsNumberOfFights do
      newBu(level, format("%s %i     %s", tdpsL.fight, i - 2, (tdpsFight[i].name or tdpsL.empty)), nil, nil, nil, nil,
      nil, changeFight, i, nil, checkFight(i))
    end
    newBu(level, "", nil, 1, nil, nil, nil, nil, nil, nil, nil, 1)
    newBu(level, tdpsL.showDamage, nil, nil, nil, nil, nil, changeView, "d", nil, checkView("d"))
    newBu(level, tdpsL.showHealing, nil, nil, nil, nil, nil, changeView, "h", nil, checkView("h"))
    newBu(level, "", nil, 1, nil, nil, nil, nil, nil, nil, nil, 1)
    newBu(level, "     "..tdpsL.resetAllData, nil, 1, nil, nil, nil, reset)
  elseif level == 2 and UIDROPDOWNMENU_MENU_VALUE == "report" then
    newBu(level, tdpsL.say, nil, 1, nil, nil, nil, report, "SAY")
    newBu(level, tdpsL.instance, nil, 1, nil, nil, nil, report, "INSTANCE_CHAT")
    newBu(level, tdpsL.raid, nil, 1, nil, nil, nil, report, "RAID")
    newBu(level, tdpsL.party, nil, 1, nil, nil, nil, report, "PARTY")
    newBu(level, tdpsL.guild, nil, 1, nil, nil, nil, report, "GUILD")
    newBu(level, tdpsL.officer, nil, 1, nil, nil, nil, report, "OFFICER")
    newBu(level, tdpsL.whisper, nil, 1, nil, nil, nil, report, "WHISPER")
    newBu(level, tdpsL.whisper2, nil, 1, nil, nil, nil, function()
      ChatEdit_ActivateChat(DEFAULT_CHAT_FRAME.editBox)
      DEFAULT_CHAT_FRAME.editBox:SetText("/tdps whisper ")
    end)
    for i = 1, 20 do
      local _, name = GetChannelName(i)
      if name then
        newBu(level, name.."     ", nil, 1, nil, nil, nil, report, i)
      end
    end
    newBu(level, "", nil, 1, nil, nil, nil, nil, nil, nil, nil, 1)
    newBu(level, "Report Length: "..tdpsReportLength, nil, 1, nil, nil, nil, function()
      ChatEdit_ActivateChat(DEFAULT_CHAT_FRAME.editBox)
      DEFAULT_CHAT_FRAME.editBox:SetText("/tdps reportlength "..tdpsReportLength)
    end)
  elseif level == 2 and UIDROPDOWNMENU_MENU_VALUE == "options" then
    newBu(level, tdpsL.text, nil, 1, 1, "text", 1)
    newBu(level, tdpsL.bars, nil, 1, 1, "bars", 1)
    newBu(level, tdpsL.colors, nil, 1, 1, "colors", 1)
    newBu(level, tdpsL.various, nil, 1, 1, "various", 1)
  elseif level == 3 and UIDROPDOWNMENU_MENU_VALUE == "text" then
    newBu(level, tdpsL.size, nil, 1, 1, "size", 1)
    newBu(level, tdpsL.font, nil, 1, 1, "font", 1)
    newBu(level, tdpsL.layout, nil, 1, 1, "layout", 1)
    newBu(level, tdpsL.outline, nil, 1, 1, "outline", 1)
    newBu(level, format(tdpsL.nudge, tdpsTextOffset), nil, 1, nil, nil, 1, nudgeText)
  elseif level == 3 and UIDROPDOWNMENU_MENU_VALUE == "bars" then
    newBu(level, tdpsL.height, nil, 1, 1, "height", 1)
    newBu(level, tdpsL.spacing..": "..tdps.spacing, nil, 1, nil, nil, 1, changeBarSpacing)
    newBu(level, tdpsL.maximum..": "..tdpsVisibleBars, nil, 1, nil, nil, nil, function()
      ChatEdit_ActivateChat(DEFAULT_CHAT_FRAME.editBox)
      DEFAULT_CHAT_FRAME.editBox:SetText("/tdps visiblebars "..tdpsVisibleBars)
    end)
  elseif level == 3 and UIDROPDOWNMENU_MENU_VALUE == "colors" then
    local st
    if tdps.swapColor then
      st = tdpsL.text
    else
      st = tdpsL.bars
    end
    newBu(level, st, nil, 1, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1, function()
      ColorPickerOkayButton:Hide()
      ColorPickerCancelButton:SetText("Close")
      local red, green, blue = ColorPickerFrame:GetColorRGB()
      local alpha = 1 - OpacitySliderFrame:GetValue()
      tdps.bar[1], tdps.bar[2], tdps.bar[3], tdps.bar[4] = red, green, blue, alpha
      changeBarColor()
    end, 1, function()
      local red, green, blue = ColorPickerFrame:GetColorRGB()
      local alpha = 1 - OpacitySliderFrame:GetValue()
      tdps.bar[1], tdps.bar[2], tdps.bar[3], tdps.bar[4] = red, green, blue, alpha
      changeBarColor()
    end, tdps.bar[1], tdps.bar[2], tdps.bar[3], 1 - tdps.bar[4], 1)
    newBu(level, tdpsL.barBackdrop, nil, 1, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1, function()
      ColorPickerOkayButton:Hide()
      ColorPickerCancelButton:SetText("Close")
      local red, green, blue = ColorPickerFrame:GetColorRGB()
      local alpha = 1 - OpacitySliderFrame:GetValue()
      tdps.barbackdrop[1], tdps.barbackdrop[2], tdps.barbackdrop[3], tdps.barbackdrop[4] = red, green, blue, alpha
      changeBarBackdropColor()
    end, 1, function()
      local red, green, blue = ColorPickerFrame:GetColorRGB()
      local alpha = 1 - OpacitySliderFrame:GetValue()
      tdps.barbackdrop[1], tdps.barbackdrop[2], tdps.barbackdrop[3], tdps.barbackdrop[4] = red, green, blue, alpha
      changeBarBackdropColor()
    end, tdps.barbackdrop[1], tdps.barbackdrop[2], tdps.barbackdrop[3], 1 - tdps.barbackdrop[4], 1)
    newBu(level, tdpsL.frameBorder, nil, 1, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1, function()
      ColorPickerOkayButton:Hide()
      ColorPickerCancelButton:SetText("Close")
      local red, green, blue = ColorPickerFrame:GetColorRGB()
      local alpha = 1 - OpacitySliderFrame:GetValue()
      tdpsFrame:SetBackdropBorderColor(red, green, blue, alpha)
      tdps.border[1], tdps.border[2], tdps.border[3], tdps.border[4] = red, green, blue, alpha
    end, 1, function()
      local red, green, blue = ColorPickerFrame:GetColorRGB()
      local alpha = 1 - OpacitySliderFrame:GetValue()
      tdpsFrame:SetBackdropBorderColor(red, green, blue, alpha)
      tdps.border[1], tdps.border[2], tdps.border[3], tdps.border[4] = red, green, blue, alpha
    end, tdps.border[1], tdps.border[2], tdps.border[3], 1 - tdps.border[4], 1)
    newBu(level, tdpsL.frameBackdrop, nil, 1, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1, function()
      ColorPickerOkayButton:Hide()
      ColorPickerCancelButton:SetText("Close")
      local red, green, blue = ColorPickerFrame:GetColorRGB()
      local alpha = 1 - OpacitySliderFrame:GetValue()
      tdpsFrame:SetBackdropColor(red, green, blue, alpha)
      tdps.backdrop[1], tdps.backdrop[2], tdps.backdrop[3], tdps.backdrop[4] = red, green, blue, alpha
    end, 1, function()
      local red, green, blue = ColorPickerFrame:GetColorRGB()
      local alpha = 1 - OpacitySliderFrame:GetValue()
      tdpsFrame:SetBackdropColor(red, green, blue, alpha)
      tdps.backdrop[1], tdps.backdrop[2], tdps.backdrop[3], tdps.backdrop[4] = red, green, blue, alpha
    end, tdps.backdrop[1], tdps.backdrop[2], tdps.backdrop[3], 1 - tdps.backdrop[4], 1)
    newBu(level, tdpsL.dimClassColors, nil, 1, nil, nil, 1, function()
      if tdpsColorAlpha - .1 < 0 then
        tdpsColorAlpha = 0
      else
        tdpsColorAlpha = tdpsColorAlpha - .1
      end
      changeBarColor()
    end)
    newBu(level, tdpsL.resetClassColors, nil, 1, nil, nil, 1, function()
      tdpsColorAlpha = 1
      changeBarColor()
    end)
    newBu(level, tdpsL.swapBarTextColor.."     ", nil, 1, nil, nil, 1, function()
      tdps.swapColor = not tdps.swapColor
      if tdps.swapColor then
        DropDownList3Button1:SetText(tdpsL.text)
      else
        DropDownList3Button1:SetText(tdpsL.bars)
      end
      changeBarColor()
    end)
  elseif level == 3 and UIDROPDOWNMENU_MENU_VALUE == "various" then
    newBu(level, tdpsL.hideInPvP, nil, nil, nil, nil, 1, function()
      tdps.hidePvP = not tdps.hidePvP
      visibilityEvent()
    end, nil, nil, tdps.hidePvP, nil, 1)
    newBu(level, tdpsL.hideInBattle, nil, nil, nil, nil, 1, function()
      tdps.hideBattle = not tdps.hideBattle
      visibilityEvent()
    end, nil, nil, tdps.hideBattle, nil, 1)
    newBu(level, tdpsL.hideWhenSolo, nil, nil, nil, nil, 1, function()
      tdps.hideSolo = not tdps.hideSolo
      visibilityEvent()
    end, nil, nil, tdps.hideSolo, nil, 1)
    newBu(level, tdpsL.hideInCombat, nil, nil, nil, nil, 1, function(self)
      tdps.hideIC = not tdps.hideIC
      if tdps.hideIC and tdps.hideOOC then
        _G[gsub(self:GetName(), "%d$", strmatch(self:GetName(), "%d$") + 1)]:Click()
      end
      visibilityEvent()
    end, nil, nil, tdps.hideIC, nil, 1)
    newBu(level, tdpsL.hideOutOfCombat, nil, nil, nil, nil, 1, function(self)
      tdps.hideOOC = not tdps.hideOOC
      if tdps.hideOOC and tdps.hideIC then
        _G[gsub(self:GetName(), "%d$", strmatch(self:GetName(), "%d$") - 1)]:Click()
      end
      visibilityEvent()
    end, nil, nil, tdps.hideOOC, nil, 1)
    newBu(level, "", nil, 1, nil, nil, nil, nil, nil, nil, nil, 1)
    newBu(level, tdpsL.growUpwards, nil, nil, nil, nil, 1, function()
      if tdps.anchor == "TOPLEFT" then
        tdps.anchor = "BOTTOMLEFT"
      else
        tdps.anchor = "TOPLEFT"
      end
      tdpsFrame:ClearAllPoints()
      tdpsFrame:SetPoint(tdps.anchor, tdpsAnchor, tdps.anchor)
    end, nil, nil, function()
      if tdps.anchor == "BOTTOMLEFT" then
        return true
      end
    end, nil, 1)
    newBu(level, tdpsL.minimapButton, nil, nil, nil, nil, 1, toggleMinimapButton, nil, nil, tdps.showMinimapButton, nil,
    1)
    newBu(level, tdpsL.resetOnNewGroup, nil, nil, nil, nil, 1, function()
      tdps.autoReset = not tdps.autoReset
    end, nil, nil, tdps.autoReset, nil, 1)
    newBu(level, tdpsL.refreshEverySecond, nil, nil, nil, nil, 1, function()
      if tdps.speed == 2 then
        tdps.speed = 1
      else
        tdps.speed = 2
      end
    end, nil, nil, function()
      if tdps.speed == 1 then
        return true
      end
    end, nil, 1)
    newBu(level, "", nil, 1, nil, nil, nil, nil, nil, nil, nil, 1)
    newBu(level, tdpsL.trackSpellDetails, nil, nil, nil, nil, 1, function()
      tdps.trackSpells = not tdps.trackSpells
      if not tdps.trackSpells then
        deleteSpellData()
      end
    end, nil, nil, tdps.trackSpells, nil, 1)
    newBu(level, format(tdpsL.spells, tdps.tooltipSpells), nil, 1, nil, nil, 1, function()
      if tdps.tooltipSpells == 10 then
        tdps.tooltipSpells = 0
      else
        tdps.tooltipSpells = tdps.tooltipSpells + 1
      end
      DropDownList3Button12:SetFormattedText(tdpsL.spells, tdps.tooltipSpells)
    end)
    newBu(level, format(tdpsL.targets, tdps.tooltipTargets), nil, 1, nil, nil, 1, function()
      if tdps.tooltipTargets == 10 then
        tdps.tooltipTargets = 0
      else
        tdps.tooltipTargets = tdps.tooltipTargets + 1
      end
      DropDownList3Button13:SetFormattedText(tdpsL.targets, tdps.tooltipTargets)
    end)
    newBu(level, "", nil, 1, nil, nil, nil, nil, nil, nil, nil, 1)
    newBu(level, tdpsL.keepOnlyBossFights, nil, nil, nil, nil, 1, function()
      tdps.onlyBossSegments = not tdps.onlyBossSegments
    end, nil, nil, tdps.onlyBossSegments, nil, 1)
    newBu(level, format(tdpsL.history, tdpsNumberOfFights - 2), nil, 1, nil, nil, 1, changeNumberOfFights)
  elseif level == 4 and UIDROPDOWNMENU_MENU_VALUE == "size" then
    newBu(level, tdpsL.increase, nil, 1, nil, nil, 1, changeFont, "size", 1)
    newBu(level, tdpsL.decrease, nil, 1, nil, nil, 1, changeFont, "size", -1)
  elseif level == 4 and UIDROPDOWNMENU_MENU_VALUE == "font" then
    if GetLocale() == "zhCN" then
      newBu(level, "默认", nil, nil, nil, nil, nil, changeFont, "font", [[Fonts\ZYKai_T.TTF]], function()
        if tdpsFont.name == [[Fonts\ZYKai_T.TTF]] then
          return true
        end
      end, nil, nil)
      newBu(level, "聊天", nil, nil, nil, nil, nil, changeFont, "font", [[Fonts\ZYHei.TTF]], function()
        if tdpsFont.name == [[Fonts\ZYHei.TTF]] then
          return true
        end
      end, nil, nil)
      newBu(level, "伤害数字", nil, nil, nil, nil, nil, changeFont, "font", [[Fonts\ZYKai_C.TTF]], function()
        if tdpsFont.name == [[Fonts\ZYKai_C.TTF]] then
          return true
        end
      end, nil, nil)
    elseif GetLocale() == "zhTW" then
      newBu(level, "預設", nil, nil, nil, nil, nil, changeFont, "font", [[Fonts\bLEI00D.TTF]], function()
        if tdpsFont.name == [[Fonts\bLEI00D.TTF]] then
          return true
        end
      end, nil, nil)
      newBu(level, "聊天", nil, nil, nil, nil, nil, changeFont, "font", [[Fonts\bHEI01B.TTF]], function()
        if tdpsFont.name == [[Fonts\bHEI01B.TTF]] then
          return true
        end
      end, nil, nil)
      newBu(level, "傷害數字", nil, nil, nil, nil, nil, changeFont, "font", [[Fonts\bKAI00M.TTF]], function()
        if tdpsFont.name == [[Fonts\bKAI00M.TTF]] then
          return true
        end
      end, nil, nil)
      newBu(level, "提示訊息", nil, nil, nil, nil, nil, changeFont, "font", [[Fonts\bHEI00M.TTF]], function()
        if tdpsFont.name == [[Fonts\bHEI00M.TTF]] then
          return true
        end
      end, nil, nil)
    else
      newBu(level, "Skurri", nil, nil, nil, nil, nil, changeFont, "font", [[Fonts\SKURRI.TTF]], function()
        if tdpsFont.name == [[Fonts\SKURRI.TTF]] then
          return true
        end
      end, nil, nil)
      newBu(level, "Visitor", nil, nil, nil, nil, nil, changeFont, "font",
      [[Interface\AddOns\_ShiGuang\Media\Fonts\Pixel.ttf]], function()
        if tdpsFont.name == [[Interface\AddOns\_ShiGuang\Media\Fonts\Pixel.ttf]] then
          return true
        end
      end, nil, nil)
      newBu(level, "Morpheus", nil, nil, nil, nil, nil, changeFont, "font", [[Fonts\MORPHEUS.TTF]], function()
        if tdpsFont.name == [[Fonts\MORPHEUS.TTF]] then
          return true
        end
      end, nil, nil)
      newBu(level, "Arial Narrow", nil, nil, nil, nil, nil, changeFont, "font", [[Fonts\ARIALN.TTF]], function()
        if tdpsFont.name == [[Fonts\ARIALN.TTF]] then
          return true
        end
      end, nil, nil)
      newBu(level, "Friz Quadrata TT", nil, nil, nil, nil, nil, changeFont, "font", [[Fonts\FRIZQT__.TTF]], function()
        if tdpsFont.name == [[Fonts\FRIZQT__.TTF]] then
          return true
        end
      end, nil, nil)
    end
  elseif level == 4 and UIDROPDOWNMENU_MENU_VALUE == "layout" then
    newBu(level, tdpsL.dps, nil, nil, nil, nil, 1, changeTextLayout, 8, nil, function()
      if band(tdps.layout, 8) > 0 then
        return true
      end
    end, nil, 1)
    newBu(level, tdpsL.rank, nil, nil, nil, nil, 1, function()
      tdps.showRank = not
      tdps.showRank
      tdpsRefresh()
    end, nil, nil, tdps.showRank, nil, 1)
    newBu(level, tdpsL.percent, nil, nil, nil, nil, 1, changeTextLayout, 4, nil, function()
      if band(tdps.layout, 4) > 0 then
        return true
      end
    end, nil, 1)
    newBu(level, tdpsL.amount, nil, nil, nil, nil, 1, changeTextLayout, 2, nil, function()
      if band(tdps.layout, 2) > 0 then
        return true
      end
    end, nil, 1)
    newBu(level, tdpsL.short, nil, nil, nil, nil, 1, changeTextLayout, 1, nil, function()
      if band(tdps.layout, 1) > 0 then
        return true
      end
    end, nil, 1)
  elseif level == 4 and UIDROPDOWNMENU_MENU_VALUE == "outline" then
    newBu(level, tdpsL.none, nil, nil, nil, nil, nil, changeFont, "outline", "", function()
      if tdpsFont.outline == "" and tdpsFont.shadow == 0 then
        return true
      end
    end)
    newBu(level, tdpsL.thin, nil, nil, nil, nil, nil, changeFont, "outline", "OUTLINE", function()
      if tdpsFont.outline == "OUTLINE" and tdpsFont.shadow == 0 then
        return true
      end
    end)
    newBu(level, tdpsL.thick, nil, nil, nil, nil, nil, changeFont, "outline", "THICKOUTLINE", function()
      if tdpsFont.outline == "THICKOUTLINE" and tdpsFont.shadow == 0 then
        return true
      end
    end)
    newBu(level, tdpsL.shadow, nil, nil, nil, nil, nil, changeFont, "shadow", 1, function()
      if tdpsFont.outline == "" and tdpsFont.shadow > 0 then
        return true
      end
    end)
    newBu(level, tdpsL.mono, nil, nil, nil, nil, nil, changeFont, "outline", "OUTLINE, MONOCHROME", function()
      if tdpsFont.outline == "OUTLINE, MONOCHROME" and tdpsFont.shadow == 0 then
        return true
      end
    end)
  elseif level == 4 and UIDROPDOWNMENU_MENU_VALUE == "height" then
    newBu(level, tdpsL.increase, nil, 1, nil, nil, 1, changeBarHeight, 1)
    newBu(level, tdpsL.decrease, nil, 1, nil, nil, 1, changeBarHeight, -1)
  elseif level == 4 and UIDROPDOWNMENU_MENU_VALUE == "spacing" then
    newBu(level, tdpsL.increase, nil, 1, nil, nil, 1, changeBarSpacing, 1)
    newBu(level, tdpsL.decrease, nil, 1, nil, nil, 1, changeBarSpacing, -1)
  end
end

local function tdpsSpellSort(x, y)
  if ttSpellMerge[x] > ttSpellMerge[y] then
    return true
  end
end

local function tdpsMobSort(x, y)
  if ttMobMerge[x] > ttMobMerge[y] then
    return true
  end
end

local function newBar(g)
  local dummybar = CreateFrame("Statusbar", "tdpsStatusBar", tdpsFrame)
  dummybar:SetFrameStrata("MEDIUM")
  dummybar:SetFrameLevel(2)
  dummybar:SetOrientation("HORIZONTAL")
  dummybar:EnableMouse(true)
  dummybar:EnableMouseWheel(true)
  dummybar:SetWidth(tdpsFrame:GetWidth() - 4)
  dummybar:SetHeight(tdps.barHeight)
  dummybar:Hide()
  --dummybar:SetPoint("RIGHT", tdpsFrame, "RIGHT", -2, 0)
  --dummybar:SetBackdrop({
    --bgFile = [[Interface\AddOns\_ShiGuang\Media\Modules\Skada\YaSkada05.blp]],
    --edgeFile = [[Interface\AddOns\_ShiGuang\Media\Modules\UI-StatusBar.tga]],
    --tile = false,
    --tileSize = 1,
    --edgeSize = 1,
    --insets = {
      --left = 0,
      --right = 0,
      --top = 0,
      --bottom = 0,
    --}
  --})
  dummybar:SetStatusBarTexture([[Interface\AddOns\_ShiGuang\Media\Modules\UI-StatusBar.blp]])

  -- bar info
  dummybar.name, dummybar.guid, dummybar.n = strsplit("-", tdpsPlayer[g]["name"]), g, 0

  -- scripts
  dummybar:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self)
    GameTooltip:SetText(tdpsPlayer[g].name)

    -- tooltip title
    if tdpsF == 2 then
      GameTooltip:AddLine(format("%s %s", tdpsL.tipPrefix[tdpsV], tdpsL.currentFight), 1, .85, 0)
    else
      GameTooltip:AddLine(format("%s %s", tdpsL.tipPrefix[tdpsV], tdpsFight[tdpsF].name or "?"), 1, .85, 0)
    end

    -- own amount
    GameTooltip:AddDoubleLine(tdpsL.personal, tdpsPlayer[self.guid].fight[tdpsF][tdpsV].." (" ..
    round(tdpsPlayer[self.guid].fight[tdpsF][tdpsV] / (self.n) * 100, 0).."%)", 1, 1, 1, 1, 1, 1)

    -- pet amount
    local pet, petAmount = tdpsPlayer[g].pet, 0
    for i = 1, #pet do
      petAmount = petAmount + tdpsPet[pet[i]].fight[tdpsF][tdpsV]
    end
    if petAmount > 0 then
      GameTooltip:AddDoubleLine(tdpsL.byPets, petAmount.." ("..round(petAmount / (self.n) * 100, 0).."%)", 1, 1, 1, 1,
      1, 1)
    end

    -- spell details
    if tdps.trackSpells then
      -- merge the data of this player
      for k, v in pairs(tdpsPlayer[g].fight[tdpsF][tdpsV.."s"]) do
        for kk, vv in pairs(v) do
          ttSpellMerge[k] = (ttSpellMerge[k] or 0) + vv ttMobMerge[kk] = (ttMobMerge[kk] or 0) + vv
        end
      end
      for i = 1, #pet do
        for k, v in pairs(tdpsPet[pet[i]].fight[tdpsF][tdpsV.."s"]) do
          for kk, vv in pairs(v) do
            ttSpellMerge[k] = (ttSpellMerge[k] or 0) + vv ttMobMerge[kk] = (ttMobMerge[kk] or 0) + vv
          end
        end
      end

      -- display spells
      if tdps.tooltipSpells > 0 then
        GameTooltip:AddLine(tdpsL.topAbilities, 1, .85, 0)
      end
      for k, v in pairs(ttSpellMerge) do
        tinsert(ttSort, k)
      end
      sort(ttSort, tdpsSpellSort)
      for i = 1, tdps.tooltipSpells do
        if ttSort[i] then
          GameTooltip:AddDoubleLine(i..". "..ttSort[i], ttSpellMerge[ttSort[i]].." (" ..
          round(ttSpellMerge[ttSort[i]] / (self.n) * 100, 0).."%)", 1, 1, 1, 1, 1, 1)
        end
      end
      wipe(ttSort)

      -- display targets
      if tdps.tooltipTargets > 0 then
        GameTooltip:AddLine(tdpsL.topTargets, 1, .85, 0)
      end
      for k, v in pairs(ttMobMerge) do
        tinsert(ttSort, k)
      end
      sort(ttSort, tdpsMobSort)
      for i = 1, tdps.tooltipTargets do
        if ttSort[i] then
          GameTooltip:AddDoubleLine(i..". "..ttSort[i], ttMobMerge[ttSort[i]].." ("..round(ttMobMerge[ttSort[i]] /
          (self.n) * 100, 0).."%)", 1, 1, 1, 1, 1, 1)
        end
      end
      wipe(ttSort)
      wipe(ttSpellMerge)
      wipe(ttMobMerge)
    end

    -- display the tooltip
    GameTooltip:Show()
  end)

  dummybar:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
  end)

  dummybar:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" and IsShiftKeyDown() then
      CloseDropDownMenus()
      GameTooltip:Hide()
      isMovingOrSizing = true
      tdpsAnchor:StartMoving()
    elseif button == "RightButton" then
      ToggleDropDownMenu(1, nil, tdpsDropDown, "cursor", 0, 0)
    elseif button == "MiddleButton" then
      reset()
    elseif button == "Button4" then
      changeFight(nil, 1)
    elseif button == "Button5" then
      changeFight(nil, 2)
    end
  end)

  dummybar:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
      tdpsAnchor:StopMovingOrSizing()
      isMovingOrSizing = nil
      -- set position of frame
      tdpsFrame:ClearAllPoints()
      tdpsFrame:SetPoint(tdps.anchor, tdpsAnchor, tdps.anchor, 0, 0)
      -- save position of anchor
      local xOfs, yOfs = tdpsAnchor:GetCenter()
      local scale = tdpsAnchor:GetEffectiveScale()
      local uis = UIParent:GetScale()
      xOfs = xOfs * scale - GetScreenWidth() * uis / 2
      yOfs = yOfs * scale - GetScreenHeight() * uis / 2
      tdpsPosition.x = xOfs / uis
      tdpsPosition.y = yOfs / uis
    end
  end)

  dummybar:SetScript("OnMouseWheel", function(self, direction)
    scroll(direction)
  end)

  -- number fontstring
  dummybar.fontStringRight = dummybar:CreateFontString(nil, "OVERLAY")
  dummybar.fontStringRight:SetPoint("RIGHT", -1, tdpsTextOffset)
  dummybar.fontStringRight:SetJustifyH("RIGHT")
  dummybar.fontStringRight:SetWordWrap(false)
  dummybar.fontStringRight:SetFont(tdpsFont.name, tdpsFont.size, tdpsFont.outline)
  dummybar.fontStringRight:SetShadowColor(.05, .05, .05, 1)
  dummybar.fontStringRight:SetShadowOffset(tdpsFont.shadow, tdpsFont.shadow * -1)

  -- name fontstring
  dummybar.fontStringLeft = dummybar:CreateFontString(nil, "OVERLAY")
  dummybar.fontStringLeft:SetPoint("LEFT", 1, tdpsTextOffset)
  dummybar.fontStringLeft:SetPoint("RIGHT", dummybar.fontStringRight, "LEFT", -2, 1)
  dummybar.fontStringLeft:SetJustifyH("LEFT")
  dummybar.fontStringLeft:SetWordWrap(false)
  dummybar.fontStringLeft:SetFont(tdpsFont.name, tdpsFont.size, tdpsFont.outline)
  dummybar.fontStringLeft:SetShadowColor(.05, .05, .05, 1)
  dummybar.fontStringLeft:SetShadowOffset(tdpsFont.shadow, tdpsFont.shadow * -1)

  -- colors
  local classR, classG, classB, classA = cColor[tdpsPlayer[g].class].r, cColor[tdpsPlayer[g].class].g,
  cColor[tdpsPlayer[g].class].b, tdpsColorAlpha
  if tdps.swapColor then
    dummybar:SetStatusBarColor(classR, classG, classB, classA)
    dummybar.fontStringRight:SetTextColor(tdps.bar[1], tdps.bar[2], tdps.bar[3], tdps.bar[4])
    dummybar.fontStringLeft:SetTextColor(tdps.bar[1], tdps.bar[2], tdps.bar[3], tdps.bar[4])
  else
    dummybar:SetStatusBarColor(tdps.bar[1], tdps.bar[2], tdps.bar[3], tdps.bar[4])
    dummybar.fontStringRight:SetTextColor(classR, classG, classB, classA)
    dummybar.fontStringLeft:SetTextColor(classR, classG, classB, classA)
  end
  dummybar:SetBackdropColor(tdps.barbackdrop[1], tdps.barbackdrop[2], tdps.barbackdrop[3], tdps.barbackdrop[4])
  dummybar:SetBackdropBorderColor(0, 0, 0, 0)

  -- save bar
  tinsert(bar, dummybar)
end

local function makeCombatant(k, n, pgl, c)
  if c == "PET" then
    tdpsPet[k] = {
      name = n,
      guid = pgl,
      class = c,
      stamp = 0,
      fight = {},
    }
    while #tdpsPet[k].fight < tdpsNumberOfFights do
      tinsert(tdpsPet[k].fight, {
        d = 0,
        ds = {},
        h = 0,
        hs = {},
        t = 0,
      })
    end
  else
    tdpsPlayer[k] = {
      name = n,
      pet = pgl,
      class = c,
      stamp = 0,
      fight = {},
    }
    while #tdpsPlayer[k].fight < tdpsNumberOfFights do
      tinsert(tdpsPlayer[k].fight, {
        d = 0,
        ds = {},
        h = 0,
        hs = {},
        t = 0,
      })
    end
    newBar(k)
  end
end

local function trackSpell(amount, target, spell, dh)
  if tdps.trackSpells then
    dh = dh.."s"
    if not com.fight[1][dh][spell] then
      -- make the spell
      com.fight[1][dh][spell] = {}
    end
    if not com.fight[2][dh][spell] then
      com.fight[2][dh][spell] = {}
    end
    -- record the amount
    com.fight[1][dh][spell][target] = (com.fight[1][dh][spell][target] or 0) + amount
    com.fight[2][dh][spell][target] = (com.fight[2][dh][spell][target] or 0) + amount
  end
end

------------------------------------------------------------------------------------------------------------------------
-- Combat Event Handler --
------------------------------------------------------------------------------------------------------------------------

local function tdpsCombatEvent(self, event, ...)
  local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName,
  destFlags, destRaidFlags, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22 = ...
  local _, _, _, _, _, destID = strsplit("-", destGUID)

  -- ignore events directed towards these
  if isExcludedNPC[destID] then
    return
  end

  -- reorganize these return args for consistency
  local amount, spellName
  if event == "SPELL_ABSORBED" then
    if type(arg12) == "number" then
      -- triggered by a spell
      if isExcludedAbsorb[arg19] then
        return
      end
      sourceGUID = arg15
      sourceName = arg16
      sourceFlags = arg17
      sourceRaidFlags = arg18
      spellName = arg20
      amount = arg22
    else
      -- triggered by a swing
      if isExcludedAbsorb[arg16] then
        return
      end
      sourceGUID = arg12
      sourceName = arg13
      sourceFlags = arg14
      sourceRaidFlags = arg15
      spellName = arg17
      amount = arg19
    end
  end

  -- return when source is an outsider
  if sourceFlags % 8 == 0 then
    return
  end

  -- give units a name if they don't have one to prevent errors
  if not destName then
    destName = NONE
  end

  -- return on invalid event, vehicle, friendly fire, hostile healing, evaded
  if not isValidEvent[event] or strsplit("-", sourceGUID) == "Vehicle" or (band(destFlags, 16) > 0 and isDamage[event])
  or (band(destFlags, 16) == 0 and isHeal[event]) or arg15 == "EVADE" then
    return
  end

  -- create summoned pets
  if event == "SPELL_SUMMON" then
    -- add pet when player summons
    if UnitIsPlayer(sourceName) and not isExcludedPet[destID] then
      -- make owner if necessary
      if not tdpsPlayer[sourceGUID] then
        makeCombatant(sourceGUID, sourceName, {sourceName..": "..destName}, getClass(sourceName))
      end
      -- make pointer
      tdpsLink[destGUID] = sourceName..": "..destName
      -- make pet if it does not exist yet
      if not tdpsPet[sourceName..": "..destName] then
        makeCombatant(sourceName..": "..destName, destName, destGUID, "PET")
      end
      -- add pet to owner if it's not there yet
      local found = false
      for i = 1, #tdpsPlayer[sourceGUID].pet do
        if tdpsPlayer[sourceGUID].pet[i] == sourceName..": "..destName then
          found = true
          break
        end
      end
      if not found then
        tinsert(tdpsPlayer[sourceGUID].pet, sourceName..": "..destName)
      end
    -- the summoner is also a pet (example: totems can summon elementals)
    elseif tdpsLink[sourceGUID] then
      -- owner's owner name
      local ownersOwnerName = strsplit(":", tdpsLink[sourceGUID])
      -- make pointer
      tdpsLink[destGUID] = ownersOwnerName..": "..destName
      -- make pet
      makeCombatant(ownersOwnerName..": "..destName, destName, destGUID, "PET")
      -- add pet to owner if it's not there yet
      local found = false
      for i = 1, #tdpsPlayer[UnitGUID(ownersOwnerName)].pet do
        if tdpsPlayer[UnitGUID(ownersOwnerName)].pet[i] == ownersOwnerName..": "..destName then
          found = true
          break
        end
      end
      if not found then
        tinsert(tdpsPlayer[UnitGUID(ownersOwnerName)].pet, ownersOwnerName..": "..destName)
      end
    end
    return
  end

  -- select or create combatant
  if tdpsPlayer[sourceGUID] then
    com = tdpsPlayer[sourceGUID]
  elseif tdpsPet[tdpsLink[sourceGUID]] then
    com = tdpsPet[tdpsLink[sourceGUID]]
  elseif UnitIsPlayer(sourceName) then
    makeCombatant(sourceGUID, sourceName, {}, getClass(sourceName))
    tdpsCombatEvent(self, event, ...)
    return
  elseif isPartyPet(sourceGUID) then
    -- get owner
    local ownerGUID, ownerName = getPetOwnerGUID(sourceGUID), getPetOwnerName(sourceGUID)
    -- make owner if it does not exist yet
    if not tdpsPlayer[ownerGUID] then
      makeCombatant(ownerGUID, ownerName, {ownerName..": "..sourceName}, getClass(ownerName))
    end
    -- make pointer
    tdpsLink[sourceGUID] = ownerName..": "..sourceName
    -- make pet if it does not exist yet
    if not tdpsPet[ownerName..": "..sourceName] then
      makeCombatant(ownerName..": "..sourceName, sourceName, sourceGUID, "PET")
    end
    -- add pet to owner if it's not there yet
    local found = false
    for i = 1, #tdpsPlayer[ownerGUID].pet do
      if tdpsPlayer[ownerGUID].pet[i] == ownerName..": "..sourceName then
        found = true
        break
      end
    end
    if not found then
      tinsert(tdpsPlayer[ownerGUID].pet, ownerName..": "..sourceName)
    end
    -- event
    tdpsCombatEvent(self, event, ...)
    return
  else
    return
  end

  -- track numbers
  if isMiss[event] then
    if tdpsStartNewFight then
      startNewFight(destName, destGUID)
    end
    if event == "SWING_MISSED" and arg12 == "ABSORB" then
      amount = floor(arg14 + .5)
      trackSpell(amount, destName, tdpsL.melee, "d")
    elseif arg15 == "ABSORB" then
      amount = floor(arg17 + .5)
      trackSpell(amount, destName, arg13, "d")
    else
      return
    end
    tdpsFight[1].d, tdpsFight[2].d = tdpsFight[1].d + amount, tdpsFight[2].d + amount
    com.fight[1].d, com.fight[2].d = com.fight[1].d + amount, com.fight[2].d + amount
  elseif isDamage[event] then
    if tdpsStartNewFight then
      startNewFight(destName, destGUID)
    end
    if event == "SWING_DAMAGE" then
      amount = floor(arg12 + (arg17 or 0) + .5)
      trackSpell(amount, destName, tdpsL.melee, "d")
    else
      amount = floor(arg15 + (arg20 or 0) + .5)
      trackSpell(amount, destName, arg13, "d")
    end
    tdpsFight[1].d, tdpsFight[2].d = tdpsFight[1].d + amount, tdpsFight[2].d + amount
    com.fight[1].d, com.fight[2].d = com.fight[1].d + amount, com.fight[2].d + amount
  elseif isHeal[event] then
    if event ~= "SPELL_ABSORBED" then
      -- effective healing
      amount = arg15 - arg16
    end
    amount = floor(amount + .5)
    if amount < 1 or not tdpsInCombat then
      -- stop on complete overheal or out of combat; heals will never start a new fight
      return
    end
    trackSpell(amount, destName, spellName or arg13, "h")
    tdpsFight[1].h, tdpsFight[2].h = tdpsFight[1].h + amount, tdpsFight[2].h + amount
    com.fight[1].h, com.fight[2].h = com.fight[1].h + amount, com.fight[2].h + amount
  end

  -- add combat time
  amount = timestamp - com.stamp
  if amount < 3.5 then
    com.fight[1].t = com.fight[1].t + amount
  else
    com.fight[1].t = com.fight[1].t + 3.5
  end
  if amount < 3.5 then
    com.fight[2].t = com.fight[2].t + amount
  else
    com.fight[2].t = com.fight[2].t + 3.5
  end

  -- save timestamp
  com.stamp = timestamp

  -- set onupdate
  tdpsAnchor:SetScript("OnUpdate", tdpsOnUpdate)
end

------------------------------------------------------------------------------------------------------------------------
-- Addon Scripts --
------------------------------------------------------------------------------------------------------------------------

tdpsFrame:RegisterEvent("ADDON_LOADED")
tdpsFrame:SetScript("OnEvent", function(self, event)
  --local addonVer = GetAddOnMetadata("TinyDPS", "Version")

  -- global version mismatch
  --if curVer ~= tdps.version and tonumber(tdps.version) < 0.935 then
    --initialiseSavedVariables()
    --echo("Global variables have been reset to version "..addonVer)
  --end

  -- character version mismatch
  --if curVer ~= tdpsVersion and tonumber(tdpsVersion) < 0.935 then
    --initialiseSavedVariablesPerCharacter()
    --echo("Character variables have been reset to version "..addonVer)
    --tdpsFrame:SetHeight(tdps.barHeight + 4)
  --end

  -- save current version
  --tdps.version = curVer
  --tdpsVersion = curVer

  -- set position of anchor
  tdpsAnchor:ClearAllPoints()
  local scale = tdpsAnchor:GetEffectiveScale()
  local uis = UIParent:GetScale()
  --tdpsAnchor:SetPoint("CENTER", UIParent, "CENTER", tdpsPosition.x * uis / scale, tdpsPosition.y * uis / scale)
  tdpsAnchor:SetPoint("bottomright", UIParent, "bottomright", -2, 21)

  -- set position of frame
  tdpsFrame:ClearAllPoints()
  tdpsFrame:SetPoint(tdps.anchor, tdpsAnchor, tdps.anchor)
  --tdpsFrame:SetPoint("bottomright", UIParent, "bottomright", -2, 26)

  -- set width
  tdpsFrame:SetWidth(tdps.width)

  -- check for custom class colors
  cColor = {
    UNKNOWN = {
      r = .5,
      g = .5,
      b = .5,
      colorStr = "ff7f7f7f0",
    },
  }
  cColor = setmetatable(cColor, {__index = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS})

  -- make bars if any
  for k in pairs(tdpsPlayer) do
    newBar(k)
  end

  -- set font and colors
  noData:SetFont(tdpsFont.name, tdpsFont.size, tdpsFont.outline)
  noData:SetShadowOffset(tdpsFont.shadow, tdpsFont.shadow * -1)
  tdpsFrame:SetBackdropBorderColor(tdps.border[1], tdps.border[2], tdps.border[3], tdps.border[4])
  tdpsFrame:SetBackdropColor(tdps.backdrop[1], tdps.backdrop[2], tdps.backdrop[3], tdps.backdrop[4])

  -- hide when necessary
  visibilityEvent()

  -- minimap button
  if tdps.showMinimapButton then
    tdpsButtonFrame:Show()
  else
    tdpsButtonFrame:Hide()
  end

  -- reset events
  tdpsFrame:UnregisterEvent("ADDON_LOADED")
  tdpsFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
  tdpsFrame:SetScript("OnEvent", function(self, event, ...)
    tdpsCombatEvent(self, event, CombatLogGetCurrentEventInfo())
  end)
end)

-- all events that can show or hide the main window
tdpsAnchor:RegisterEvent("PLAYER_REGEN_ENABLED")
tdpsAnchor:RegisterEvent("PLAYER_REGEN_DISABLED")
tdpsAnchor:RegisterEvent("GROUP_ROSTER_UPDATE")
tdpsAnchor:RegisterEvent("PLAYER_ENTERING_WORLD")
tdpsAnchor:RegisterEvent("ZONE_CHANGED_NEW_AREA")
tdpsAnchor:RegisterEvent("UPDATE_UI_WIDGET")
tdpsAnchor:RegisterEvent("PET_BATTLE_OPENING_START")
tdpsAnchor:RegisterEvent("PET_BATTLE_CLOSE")

local wasInGroup
tdpsAnchor:SetScript("OnEvent", function(self, event, ...)
  visibilityEvent()
  if event == "GROUP_ROSTER_UPDATE" then
    if tdps.autoReset and IsInGroup() and wasInGroup == false then
      reset()
    end
    wasInGroup = not not IsInGroup()
  end
end)

-- onupdate
local sec = 2
function tdpsOnUpdate(self, elapsed)
  sec = sec + elapsed
  if sec > tdps.speed then
    checkCombat()
    if not tdpsInCombat then
      tdpsStartNewFight = true
      -- halted out of combat and restarted with combat (see function tdpsCombatEvent)
      tdpsAnchor:SetScript("OnUpdate", nil)
    end
    -- conditional refresh of the main window
    if tdpsFrame:IsVisible() and not isMovingOrSizing and not tdpsAnimationGroup:IsPlaying() then
      tdpsRefresh()
    end
    sec = 0
  end
end

tdpsAnchor:SetScript("OnUpdate", tdpsOnUpdate)

tdpsFrame:SetScript("OnMouseDown", function(self, button)
  if button == "LeftButton" and IsShiftKeyDown() then
    CloseDropDownMenus()
    GameTooltip:Hide()
    isMovingOrSizing = true
    tdpsAnchor:StartMoving()
  elseif button == "RightButton" then
    ToggleDropDownMenu(1, nil, tdpsDropDown, "cursor", 0, 0)
  elseif button == "MiddleButton" then
    reset()
  elseif button == "Button4" then
    changeFight(nil, 1)
  elseif button == "Button5" then
    changeFight(nil, 2)
  end
end)

tdpsFrame:SetScript("OnMouseUp", function(self, button)
  if button == "LeftButton" then
    tdpsAnchor:StopMovingOrSizing()
    isMovingOrSizing = nil
    -- set position of frame
    tdpsFrame:ClearAllPoints()
    --tdpsFrame:SetPoint(tdps.anchor, tdpsAnchor, tdps.anchor, 0, 0)
    tdpsFrame:SetPoint("bottomright", UIParent, "bottomright", -2, 21)
    -- save position of anchor
    local xOfs, yOfs = tdpsAnchor:GetCenter()
    local scale = tdpsAnchor:GetEffectiveScale()
    local uis = UIParent:GetScale()
    xOfs = xOfs * scale - GetScreenWidth() * uis / 2
    yOfs = yOfs * scale - GetScreenHeight() * uis / 2
    tdpsPosition.x = xOfs / uis
    tdpsPosition.y = yOfs / uis
  end
end)

tdpsFrame:SetScript("OnMouseWheel", function(self, direction)
  scroll(direction)
end)

------------------------------------------------------------------------------------------------------------------------
-- Minimap Button Scripts --
------------------------------------------------------------------------------------------------------------------------

tdpsButtonFrame:SetScript("OnMouseDown", function(self, button)
  if button == "RightButton" then
    ToggleDropDownMenu(1, nil, tdpsDropDown, "cursor", 0, 0)
  end
  if button == "MiddleButton" then
    reset()
  end
end)

tdpsButtonFrame:SetScript("OnMouseUp", function(self, button)
  if button == "LeftButton" then
    toggle()
  end
end)

tdpsButtonFrame:SetScript("OnDragStart", function(self, button)
  tdpsButtonFrame:SetScript("OnUpdate", function(self, elapsed)
    local x, y = Minimap:GetCenter()
    local cx, cy = GetCursorPosition()
    x, y = cx / self:GetEffectiveScale() - x, cy / self:GetEffectiveScale() - y
    if x > Minimap:GetWidth() / 2 + tdpsButtonFrame:GetWidth() / 2 then
      x = Minimap:GetWidth() / 2 + tdpsButtonFrame:GetWidth() / 2
    end
    if x < Minimap:GetWidth() / 2 * -1 - tdpsButtonFrame:GetWidth() / 2 then
      x = Minimap:GetWidth() / 2 * -1 - tdpsButtonFrame:GetWidth() / 2
    end
    if y > Minimap:GetHeight() / 2 + tdpsButtonFrame:GetHeight() / 2 then
      y = Minimap:GetHeight() / 2 + tdpsButtonFrame:GetHeight() / 2
    end
    if y < Minimap:GetHeight() / 2 * -1 - tdpsButtonFrame:GetHeight() / 2 then
      y = Minimap:GetHeight() / 2 * -1 - tdpsButtonFrame:GetHeight() / 2
    end
    tdpsButtonFrame:ClearAllPoints()
    tdpsButtonFrame:SetPoint("CENTER", x, y)
  end)
end)

tdpsButtonFrame:SetScript("OnDragStop", function(self, button)
  tdpsButtonFrame:SetScript("OnUpdate", nil)
end)

tdpsButtonFrame:SetScript("OnEnter", function(self)
  GameTooltip:SetOwner(tdpsButtonFrame)
  GameTooltip:SetText("TinyDPS")

  if tdpsF == 2 then
    GameTooltip:AddLine(format("%s %s", tdpsL.tipPrefix[tdpsV], tdpsL.currentFight), 1, .85, 0)
  else
    GameTooltip:AddLine(format("%s %s", tdpsL.tipPrefix[tdpsV], tdpsFight[tdpsF].name), 1, .85, 0)
  end

  -- personal amount
  local ownAmount, ownTime, pet = 0, 0
  if tdpsPlayer[UnitGUID("player")] then
    pet, ownAmount, ownTime = tdpsPlayer[UnitGUID("player")].pet, tdpsPlayer[UnitGUID("player")].fight[tdpsF][tdpsV],
    tdpsPlayer[UnitGUID("player")].fight[tdpsF].t
    for i = 1, #pet do
      ownAmount = ownAmount + tdpsPet[pet[i]].fight[tdpsF][tdpsV]
      if tdpsPet[pet[i]].fight[tdpsF].t > ownTime then
        ownTime = tdpsPet[pet[i]].fight[tdpsF].t
      end
    end
    if ownAmount > 0 then
      if (band(tdps.layout, 1) == 1) then -- short format bit active
        GameTooltip:AddDoubleLine(UnitName("player"), format("%s (%s)", short(ownAmount), short(ownAmount / ownTime)),
        1, 1, 1, 1, 1, 1)
      else
        GameTooltip:AddDoubleLine(UnitName("player"), format("%i (%i)", ownAmount, ownAmount / ownTime), 1, 1, 1, 1, 1,
        1)
      end
    end
  end

  -- raid amount
  local partyAmount, partyTime = 0, 0
  for k, v in pairs(tdpsPlayer) do
    partyAmount = partyAmount + v.fight[tdpsF][tdpsV]
    if v.fight[tdpsF].t > partyTime then
      partyTime = v.fight[tdpsF].t
    end
  end
  for k, v in pairs(tdpsPet) do
    partyAmount = partyAmount + v.fight[tdpsF][tdpsV]
    if v.fight[tdpsF].t > partyTime then
      partyTime = v.fight[tdpsF].t
    end
  end

  if partyAmount > ownAmount then
    if (band(tdps.layout, 1) == 1) then -- short format bit active
      GameTooltip:AddDoubleLine(tdpsL.raid, format("%s (%s)", short(partyAmount), short(partyAmount / partyTime)), 1, 1,
      1, 1, 1, 1)
    else
      GameTooltip:AddDoubleLine(tdpsL.raid, format("%i (%i)", partyAmount, partyAmount / partyTime), 1, 1, 1, 1, 1, 1)
    end
  end

  GameTooltip:Show()
end)

tdpsButtonFrame:SetScript("OnLeave", function(self)
  GameTooltip:Hide()
end)

------------------------------------------------------------------------------------------------------------------------
-- Resizing Scripts --
------------------------------------------------------------------------------------------------------------------------

tdpsResizeFrame:SetScript("OnEnter", function()
  tdpsResizeTexture:SetDesaturated(false)
  tdpsResizeTexture:SetAlpha(1)
end)

tdpsResizeFrame:SetScript("OnLeave", function()
  tdpsResizeTexture:SetDesaturated(true)
  tdpsResizeTexture:SetAlpha(0)
end)

tdpsResizeFrame:SetScript("OnMouseDown", function()
  isMovingOrSizing = true
  tdpsFrame:SetMinResize(60, tdpsFrame:GetHeight())
  tdpsFrame:SetMaxResize(400, tdpsFrame:GetHeight())
  tdpsFrame:StartSizing()
end)

tdpsResizeFrame:SetScript("OnMouseUp", function()
  tdpsFrame:StopMovingOrSizing()
  tdpsFrame:ClearAllPoints()
  tdpsFrame:SetPoint(tdps.anchor, tdpsAnchor, tdps.anchor)
  isMovingOrSizing = nil
  tdps.width = tdpsFrame:GetWidth()
  for i = 1, #bar do
    bar[i]:SetWidth(tdpsFrame:GetWidth() - 4)
    bar[i]:SetValue(0)
  end
  tdpsRefresh()
end)
