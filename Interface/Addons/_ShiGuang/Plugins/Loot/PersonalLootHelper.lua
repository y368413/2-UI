--## Author: cardinalm1, Elvenbane
-- Slash command
SLASH_PLHCommand1 = '/plh'

-- Keys for the PLH_STATS saved variable array
PLH_ITEMS_REQUESTED					= 'PLH_ITEMS_REQUESTED'
PLH_ITEMS_RECEIVED					= 'PLH_ITEMS_RECEIVED'
PLH_ITEMS_OFFERED					= 'PLH_ITEMS_OFFERED'
PLH_ITEMS_GIVEN_AWAY				= 'PLH_ITEMS_GIVEN_AWAY'

-- Keys for the PLH_META saved variable array
PLH_SHOW_WHISPER_WARNING			= 'PLH_SHOW_WHISPER_WARNING'
PLH_LAST_SEEN_MESSAGE_VERSION		= 'PLH_LAST_SEEN_MESSAGE_VERSION'
PLH_LOOTED_ITEMS_FRAME_X			= 'PLH_LOOTED_ITEMS_FRAME_X'
PLH_LOOTED_ITEMS_FRAME_Y			= 'PLH_LOOTED_ITEMS_FRAME_Y'
PLH_LOOTED_ITEMS_FRAME_WIDTH		= 'PLH_LOOTED_ITEMS_FRAME_WIDTH'
PLH_LOOTED_ITEMS_FRAME_HEIGHT		= 'PLH_LOOTED_ITEMS_FRAME_HEIGHT'

-- Keys for the PLH_PREFS saved variable array
PLH_PREFS_DEBUG							= 'PLH_DEBUG'
PLH_PREFS_AUTO_HIDE						= 'PLH_AUTO_HIDE'
PLH_PREFS_SKIP_CONFIRMATION				= 'PLH_SKIP_CONFIRMATION'
PLH_PREFS_ONLY_OFFER_IF_UPGRADE			= 'PLH_ONLY_OFFER_IF_UPGRADE'
PLH_PREFS_NEVER_OFFER_BOE				= 'PLH_NEVER_OFFER_BOE'
PLH_PREFS_CURRENT_SPEC_ONLY				= 'PLH_CURRENT_SPEC_ONLY'
PLH_PREFS_ILVL_THRESHOLD				= 'PLH_ILVL_THRESHOLD'
PLH_PREFS_INCLUDE_XMOG					= 'PLH_INCLUDE_XMOG'
PLH_PREFS_WHISPER_MESSAGE				= 'PLH_WHISPER_MESSAGE'
PLH_PREFS_SHOW_TRADEABLE_ALERT			= 'PLH_SHOW_TRADEABLE_ALERT'
PLH_PREFS_ANNOUNCE_TRADES				= 'PLH_ANNOUNCE_TRADES'

-- Default values for PLH_PREFS saved variable array
PLH_DEFAULT_PREFS = {
	[PLH_PREFS_DEBUG]					= false,
	[PLH_PREFS_AUTO_HIDE]				= true,
	[PLH_PREFS_SKIP_CONFIRMATION]		= false,
	[PLH_PREFS_ONLY_OFFER_IF_UPGRADE]	= false,
	[PLH_PREFS_NEVER_OFFER_BOE]			= false,
	[PLH_PREFS_CURRENT_SPEC_ONLY]		= false,
	[PLH_PREFS_ILVL_THRESHOLD]			= 0,
	[PLH_PREFS_INCLUDE_XMOG]			= true,
	[PLH_PREFS_WHISPER_MESSAGE]			= "[2UI]你好!这件装备  %item  如果你不要,能否惠赠给我呢?非常感谢!!!",
	[PLH_PREFS_SHOW_TRADEABLE_ALERT]	= true,
	[PLH_PREFS_ANNOUNCE_TRADES]			= false
}

-- Roles
PLH_ROLE_AGILITY_DPS				= 'AGILITY_DPS'
PLH_ROLE_INTELLECT_DPS				= 'INTELLECT_DPS'
PLH_ROLE_STRENGTH_DPS				= 'STRENGTH_DPS'
PLH_ROLE_HEALER						= 'HEALER'
PLH_ROLE_TANK						= 'TANK'
PLH_ROLE_UNKNOWN					= 'UNKNOWN'


--[[
to easily populate these arrays:
	wowhead search item -> armor -> trinkets ->
		usable by = whichever role
		added in expansion/patch = whichever expansion/patch
		obtained through looting = yes
		ID > 0
		quality = rare or epic
	sort by ID descending
	paste into OpenOffice
	=concatenate("[";b1;"] = true, -- ";d1)
	ensure curly quotes are off in tools -> autocorrect options -> localized options
]]--

local TRINKET_AGILITY_DPS = {

	-- 8.3 trinkets
	[173943] = true, -- Torment in a Jar
	[173946] = true, -- Writhing Segment of Drest'agath
	[174044] = true, -- Humming Black Dragonscale
	[174277] = true, -- Lingering Psychic Shell
	[173940] = true, -- Sigil of Warding

	-- 8.1.5 and 8.2 trinkets
	[167866] = true, -- Lurker's Insidious Gift
	[167868] = true, -- Idol of Indiscriminate Consumption
	[168965] = true, -- Modular Platinum Plating
	[169307] = true, -- Vision of Demise
	[169308] = true, -- Chain of Suffering
	[169310] = true, -- Bloodthirsty Urchin
	[169311] = true, -- Ashvane's Razor Coral
	[169313] = true, -- Phial of the Arcane Tempest
	[169315] = true, -- Edicts of the Faithless
	[169318] = true, -- Shockbiter's Fang
	[169319] = true, -- Dribbling Inkpod
	[169769] = true, -- Remote Guidance Device
	
	-- 8.1 trinkets
	[165572] = true, -- Variable Intensity Gigavolt Oscillating Reactor
	[165579] = true, -- Kimbul's Razor Claw
	[165568] = true, -- Invocation of Yu'lon
	[166794] = true, -- Forest Lord's Razorleaf
	[165573] = true, -- Diamond-Laced Refracting Prism
	[165577] = true, -- Bwonsamdi's Bargain
	
	-- 8.0 Trinkets
	[161412] = true, -- Spiritbound Voodoo Burl
	[161125] = true, -- Kaja-fied Banana
	[161119] = true, -- Ravasaur Skull Bijou
	[161113] = true, -- Incessantly Ticking Clock
	[160653] = true, -- Xalzaix's Veiled Eye
	[160652] = true, -- Construct Overcharger
	[160648] = true, -- Frenetic Corpuscle
	[160263] = true, -- Snowpelt Mangler
	[159628] = true, -- Kul Tiran Cannonball Runner
	[159626] = true, -- Lingering Sporepods
	[159623] = true, -- Dead-Eye Spyglass
	[159618] = true, -- Mchimba's Ritual Bandages
	[159617] = true, -- Lustrous Golden Plumage
	[159614] = true, -- Galecaller's Boon
	[158556] = true, -- Siren's Tongue
	[158555] = true, -- Doom Shroom
	[158374] = true, -- Tiny Electromental in a Jar
	[158319] = true, -- My'das Talisman
	[158224] = true, -- Vial of Storms
	[158218] = true, -- Dadalea's Wing
	[158216] = true, -- Living Oil Cannister
	[155881] = true, -- Harlan's Loaded Dice
	[155568] = true, -- Galewind Chimes
	
	-- Legion Trinkets
	[154174] = true, -- Golganneth's Vitality
	[154173] = true, -- Aggramar's Conviction
	[153544] = true, -- Eye of F'harg
	[151977] = true, -- Diima's Glacial Aegis
	[151312] = true, -- Ampoule of Pure Void
	[151307] = true, -- Void Stalker's Contract
	[151190] = true, -- Specter of Betrayal
	[150527] = true, -- Madness of the Betrayer
	[150526] = true, -- Shadowmoon Insignia
	[147022] = true, -- Feverish Carapace
	[147019] = true, -- Tome of Unraveling Sanity
	[147011] = true, -- Vial of Ceaseless Toxins
	[144477] = true, -- Splinters of Agronox
	[144113] = true, -- Windswept Pages
	[142506] = true, -- Eye of Guarm
	[142167] = true, -- Eye of Command
	[142166] = true, -- Ethereal Urn
	[142165] = true, -- Deteriorated Construct Core
	[142159] = true, -- Bloodstained Handkerchief
	[141585] = true, -- Six-Feather Fan
	[141537] = true, -- Thrice-Accursed Compass
	[140806] = true, -- Convergence of Fates
	[140802] = true, -- Nightblooming Frond
	[140797] = true, -- Fang of Tichondrius
	[140796] = true, -- Entwined Elemental Foci
	[140794] = true, -- Arcanogolem Digit
	[139630] = true, -- Etching of SargerasDemon Hunter
	[139329] = true, -- Bloodthirsty Instinct
	[139324] = true, -- Goblet of Nightmarish Ichor
	[139323] = true, -- Twisting Wind
	[137537] = true, -- Tirathon's Betrayal
	[137419] = true, -- Chrono Shard
	[137373] = true, -- Tempered Egg of Serpentrix
	[137367] = true, -- Stormsinger Fulmination Charge
	[137338] = true, -- Shard of Rokmora
	[137312] = true, -- Nightmare Egg Shell
	[136978] = true, -- Ember of Nullification
	[136975] = true, -- Hunger of the Pack
	[133647] = true, -- Gift of Radiance
	[133644] = true, -- Memento of Angerboda
	[129091] = true, -- Golza's Iron Fin
	[121808] = true  -- Nether Conductors
}

local TRINKET_INTELLECT_DPS = {

	-- 8.3 trinkets
	[174060] = true, -- Psyche Shredder
	[174103] = true, -- Manifesto of Madness
	[173944] = true, -- Forbidden Obsidian Claw
	[174044] = true, -- Humming Black Dragonscale
	[174180] = true, -- Oozing Coagulum
	
	
	-- 8.1.5 and 8.2 trinkets
	[169344] = true, -- Ingenious Mana Battery
	[169318] = true, -- Shockbiter's Fang
	[169316] = true, -- Deferred Sentence
	[169312] = true, -- Luminous Jellyweed
	[169309] = true, -- Zoatroid Egg Sac
	[169305] = true, -- Aquipotent Nautilus
	[169304] = true, -- Leviathan's Lure
	[168905] = true, -- Shiver Venom Relic
	[167867] = true, -- Harbinger's Inscrutable Will
	[167865] = true, -- Void Stone
	
	-- 8.1 trinkets
	[165569] = true, -- Ward of Envelopment
	[165576] = true, -- Tidestorm Codex
	[165578] = true, -- Mirror of Entwined Fate
	[165571] = true, -- Incandescent Sliver
	[165581] = true, -- Crest of Pa'ku
	[166418] = true, -- Crest of Pa'ku
	[166793] = true, -- Ancient Knot of Wisdom
	
	-- 8.0 Trinkets
	[161472] = true, -- Lion's Grace
	[161461] = true, -- Doom's Hatred
	[161411] = true, -- T'zane's Barkspines
	[161377] = true, -- Azurethos' Singed Plumage
	[161125] = true, -- Kaja-fied Banana
	[161119] = true, -- Ravasaur Skull Bijou
	[161113] = true, -- Incessantly Ticking Clock
	[160651] = true, -- Vigilant's Bloodshaper
	[160649] = true, -- Inoculating Extract
	[160263] = true, -- Snowpelt Mangler
	[159631] = true, -- Lady Waycrest's Music Box
	[159624] = true, -- Rotcrusted Voodoo Doll
	[159622] = true, -- Hadal's Nautilus
	[159620] = true, -- Conch of Dark Whispers
	[159615] = true, -- Ignition Mage's Fuse
	[159610] = true, -- Vessel of Skittering Shadows
	[158556] = true, -- Siren's Tongue
	[158555] = true, -- Doom Shroom
	[158368] = true, -- Fangs of Intertwined Essence
	[158320] = true, -- Revitalizing Voodoo Totem
	[158224] = true, -- Vial of Storms
	[158218] = true, -- Dadalea's Wing
	[158216] = true, -- Living Oil Cannister
	[155568] = true, -- Galewind Chimes
	
	-- Legion Trinkets
	[156288] = true, -- Elemental Focus Stone
	[156245] = true, -- Show of Faith
	[156021] = true, -- Energy Siphon
	[154175] = true, -- Eonar's Compassion
	[151971] = true, -- Sheath of Asara
	[151960] = true, -- Carafe of Searing Light
	[151958] = true, -- Tarratus Keystone
	[151956] = true, -- Garothi Feedback Conduit
	[151955] = true, -- Acrid Catalyst Injector
	[151340] = true, -- Echo of L'ura
	[151310] = true, -- Reality Breacher
	[150523] = true, -- Memento of Tyrande
	[150522] = true, -- The Skull of Gul'dan
	[147019] = true, -- Tome of Unraveling Sanity
	[147005] = true, -- Chalice of Moonlight
	[147003] = true, -- Barbaric Mindslaver
	[147002] = true, -- Charm of the Rising Tide
	[144480] = true, -- Dreadstone of Endless Shadows
	[144159] = true, -- Price of Progress
	[144157] = true, -- Vial of Ichorous Blood
	[144136] = true, -- Vision of the Predator
	[142166] = true, -- Ethereal Urn
	[142165] = true, -- Deteriorated Construct Core
	[142162] = true, -- Fluctuating Energy
	[141584] = true, -- Eyasu's Mulligan
	[141536] = true, -- Padawsen's Unlucky Charm
	[140809] = true, -- Whispers in the Dark
	[140805] = true, -- Ephemeral Paradox
	[140804] = true, -- Star Gate
	[140803] = true, -- Etraeus' Celestial Map
	[140792] = true, -- Erratic Metronome
	[139323] = true, -- Twisting Wind
	[139322] = true, -- Cocoon of Enforced Solitude
	[137485] = true, -- Infernal Writ
	[137484] = true, -- Flask of the Solemn Night
	[137462] = true, -- Jewel of Insatiable Desire
	[137452] = true, -- Thrumming Gossamer
	[137419] = true, -- Chrono Shard
	[137398] = true, -- Portable Manacracker
	[137367] = true, -- Stormsinger Fulmination Charge
	[136714] = true, -- Amalgam's Seventh Spine
	[129056] = true  -- Dreadlord's Hamstring
}

local TRINKET_STRENGTH_DPS = {

	-- 8.3 trinkets
	[173943] = true, -- Torment in a Jar
	[173946] = true, -- Writhing Segment of Drest'agath
	[174044] = true, -- Humming Black Dragonscale
	[174277] = true, -- Lingering Psychic Shell
	[173940] = true, -- Sigil of Warding


	-- 8.1.5 and 8.2 trinkets
	[169769] = true, -- Remote Guidance Device
	[169319] = true, -- Dribbling Inkpod
	[169318] = true, -- Shockbiter's Fang
	[169315] = true, -- Edicts of the Faithless
	[169313] = true, -- Phial of the Arcane Tempest
	[169311] = true, -- Ashvane's Razor Coral
	[169310] = true, -- Bloodthirsty Urchin
	[169308] = true, -- Chain of Suffering
	[169307] = true, -- Vision of Demise
	[168965] = true, -- Modular Platinum Plating
	[167868] = true, -- Idol of Indiscriminate Consumption
	[167866] = true, -- Lurker's Insidious Gift
	
	-- 8.1 trinkets
	[165580] = true, -- Ramping Amplitude Gigavolt Engine
	[166795] = true, -- Knot of Ancient Fury
	[165574] = true, -- Grong's Primal Rage
	[165570] = true, -- Everchill Anchor
	[165573] = true, -- Diamond-Laced Refracting Prism
	[165577] = true, -- Bwonsamdi's Bargain
	
	-- 8.0 Trinkets
	[161474] = true, -- Lion's Strength
	[161463] = true, -- Doom's Fury
	[161379] = true, -- Galecaller's Beak
	[161125] = true, -- Kaja-fied Banana
	[161119] = true, -- Ravasaur Skull Bijou
	[161113] = true, -- Incessantly Ticking Clock
	[160655] = true, -- Syringe of Bloodborne Infirmity
	[160653] = true, -- Xalzaix's Veiled Eye
	[160650] = true, -- Disc of Systematic Regression
	[160263] = true, -- Snowpelt Mangler
	[159627] = true, -- Jes' Howler
	[159626] = true, -- Lingering Sporepods
	[159619] = true, -- Briny Barnacle
	[159618] = true, -- Mchimba's Ritual Bandages
	[159616] = true, -- Gore-Crusted Butcher's Block
	[159611] = true, -- Razdunk's Big Red Button
	[158712] = true, -- Rezan's Gleaming Eye
	[158556] = true, -- Siren's Tongue
	[158555] = true, -- Doom Shroom
	[158367] = true, -- Merektha's Fang
	[158224] = true, -- Vial of Storms
	[158218] = true, -- Dadalea's Wing
	[158216] = true, -- Living Oil Cannister
	[155568] = true, -- Galewind Chimes
	
	-- Legion Trinkets
	[154176] = true, -- Khaz'goroth's Courage
	[154173] = true, -- Aggramar's Conviction
	[153544] = true, -- Eye of F'harg
	[151977] = true, -- Diima's Glacial Aegis
	[151312] = true, -- Ampoule of Pure Void
	[151307] = true, -- Void Stalker's Contract
	[151190] = true, -- Specter of Betrayal
	[150527] = true, -- Madness of the Betrayer
	[150526] = true, -- Shadowmoon Insignia
	[147022] = true, -- Feverish Carapace
	[147011] = true, -- Vial of Ceaseless Toxins
	[144482] = true, -- Fel-Oiled Infernal Machine
	[144122] = true, -- Carbonic Carbuncle
	[142508] = true, -- Chains of the Valorous
	[142167] = true, -- Eye of Command
	[142166] = true, -- Ethereal Urn
	[142159] = true, -- Bloodstained Handkerchief
	[141586] = true, -- Marfisi's Giant Censer
	[141535] = true, -- Ettin Fingernail
	[140806] = true, -- Convergence of Fates
	[140799] = true, -- Might of Krosus
	[140797] = true, -- Fang of Tichondrius
	[140796] = true, -- Entwined Elemental Foci
	[140790] = true, -- Claw of the Crystalline Scorpid
	[139328] = true, -- Ursoc's Rending Paw
	[139324] = true, -- Goblet of Nightmarish Ichor
	[137419] = true, -- Chrono Shard
	[137338] = true, -- Shard of Rokmora
	[137312] = true, -- Nightmare Egg Shell
	[136978] = true, -- Ember of Nullification
	[136975] = true, -- Hunger of the Pack
	[133647] = true, -- Gift of Radiance
	[133644] = true, -- Memento of Angerboda
	[131799] = true, -- Zugdug's Piece of Paradise
	[130126] = true, -- Iron Branch
	[129163] = true  -- Lost Etin's Strength
}

local TRINKET_HEALER = {

	-- 8.3 trinkets
	[174060] = true, -- Psyche Shredder
	[174103] = true, -- Manifesto of Madness
	[173944] = true, -- Forbidden Obsidian Claw
	[174044] = true, -- Humming Black Dragonscale
	[174180] = true, -- Oozing Coagulum


	-- 8.1.5 and 8.2 trinkets
	[169344] = true, -- Ingenious Mana Battery
	[169318] = true, -- Shockbiter's Fang
	[169316] = true, -- Deferred Sentence
	[169312] = true, -- Luminous Jellyweed
	[169309] = true, -- Zoatroid Egg Sac
	[169305] = true, -- Aquipotent Nautilus
	[169304] = true, -- Leviathan's Lure
	[168905] = true, -- Shiver Venom Relic
	[167867] = true, -- Harbinger's Inscrutable Will
	[167865] = true, -- Void Stone
	
	-- 8.1 trinkets
	[165569] = true, -- Ward of Envelopment
	[165576] = true, -- Tidestorm Codex
	[165578] = true, -- Mirror of Entwined Fate
	[165571] = true, -- Incandescent Sliver
	[165581] = true, -- Crest of Pa'ku
	[166418] = true, -- Crest of Pa'ku
	[166793] = true, -- Ancient Knot of Wisdom
	
	-- 8.0 Trinkets
	[161472] = true, -- Lion's Grace
	[161461] = true, -- Doom's Hatred
	[161411] = true, -- T'zane's Barkspines
	[161377] = true, -- Azurethos' Singed Plumage
	[161125] = true, -- Kaja-fied Banana
	[161119] = true, -- Ravasaur Skull Bijou
	[161113] = true, -- Incessantly Ticking Clock
	[160651] = true, -- Vigilant's Bloodshaper
	[160649] = true, -- Inoculating Extract
	[160263] = true, -- Snowpelt Mangler
	[159631] = true, -- Lady Waycrest's Music Box
	[159624] = true, -- Rotcrusted Voodoo Doll
	[159622] = true, -- Hadal's Nautilus
	[159620] = true, -- Conch of Dark Whispers
	[159615] = true, -- Ignition Mage's Fuse
	[159610] = true, -- Vessel of Skittering Shadows
	[158556] = true, -- Siren's Tongue
	[158555] = true, -- Doom Shroom
	[158368] = true, -- Fangs of Intertwined Essence
	[158320] = true, -- Revitalizing Voodoo Totem
	[158224] = true, -- Vial of Storms
	[158218] = true, -- Dadalea's Wing
	[158216] = true, -- Living Oil Cannister
	[155568] = true, -- Galewind Chimes

	-- Legion Trinkets
	[156288] = true, -- Elemental Focus Stone
	[156245] = true, -- Show of Faith
	[156021] = true, -- Energy Siphon
	[154175] = true, -- Eonar's Compassion
	[151971] = true, -- Sheath of Asara
	[151960] = true, -- Carafe of Searing Light
	[151958] = true, -- Tarratus Keystone
	[151956] = true, -- Garothi Feedback Conduit
	[151955] = true, -- Acrid Catalyst Injector
	[151340] = true, -- Echo of L'ura
	[151310] = true, -- Reality Breacher
	[150523] = true, -- Memento of Tyrande
	[150522] = true, -- The Skull of Gul'dan
	[147019] = true, -- Tome of Unraveling Sanity
	[147005] = true, -- Chalice of Moonlight
	[147003] = true, -- Barbaric Mindslaver
	[147002] = true, -- Charm of the Rising Tide
	[144480] = true, -- Dreadstone of Endless Shadows
	[144159] = true, -- Price of Progress
	[144157] = true, -- Vial of Ichorous Blood
	[144136] = true, -- Vision of the Predator
	[142166] = true, -- Ethereal Urn
	[142165] = true, -- Deteriorated Construct Core
	[142162] = true, -- Fluctuating Energy
	[141584] = true, -- Eyasu's Mulligan
	[141536] = true, -- Padawsen's Unlucky Charm
	[140809] = true, -- Whispers in the Dark
	[140805] = true, -- Ephemeral Paradox
	[140804] = true, -- Star Gate
	[140803] = true, -- Etraeus' Celestial Map
	[140792] = true, -- Erratic Metronome
	[139323] = true, -- Twisting Wind
	[139322] = true, -- Cocoon of Enforced Solitude
	[137485] = true, -- Infernal Writ
	[137484] = true, -- Flask of the Solemn Night
	[137462] = true, -- Jewel of Insatiable Desire
	[137452] = true, -- Thrumming Gossamer
	[137419] = true, -- Chrono Shard
	[137398] = true, -- Portable Manacracker
	[137367] = true, -- Stormsinger Fulmination Charge
	[136714] = true, -- Amalgam's Seventh Spine
	[129056] = true  -- Dreadlord's Hamstring
}

local TRINKET_TANK = {

	-- 8.3 trinkets
	[173943] = true, -- Torment in a Jar
	[173946] = true, -- Writhing Segment of Drest'agath
	[174044] = true, -- Humming Black Dragonscale
	[174277] = true, -- Lingering Psychic Shell
	[173940] = true, -- Sigil of Warding


	-- 8.1.5 and 8.2 trinkets
	[169769] = true, -- Remote Guidance Device
	[169319] = true, -- Dribbling Inkpod
	[169318] = true, -- Shockbiter's Fang
	[169315] = true, -- Edicts of the Faithless
	[169313] = true, -- Phial of the Arcane Tempest
	[169311] = true, -- Ashvane's Razor Coral
	[169310] = true, -- Bloodthirsty Urchin
	[169308] = true, -- Chain of Suffering
	[169307] = true, -- Vision of Demise
	[168965] = true, -- Modular Platinum Plating
	[167868] = true, -- Idol of Indiscriminate Consumption
	[167866] = true, -- Lurker's Insidious Gift
	
	-- 8.1 trinkets
	[165572] = true, -- Variable Intensity Gigavolt Oscillating Reactor
	[165580] = true, -- Ramping Amplitude Gigavolt Engine
	[166795] = true, -- Knot of Ancient Fury
	[165579] = true, -- Kimbul's Razor Claw
	[165568] = true, -- Invocation of Yu'lon
	[165574] = true, -- Grong's Primal Rage
	[166794] = true, -- Forest Lord's Razorleaf
	[165570] = true, -- Everchill Anchor
	[165573] = true, -- Diamond-Laced Refracting Prism
	[165577] = true, -- Bwonsamdi's Bargain
	
	-- 8.0 Trinkets
	[161474] = true, -- Lion's Strength
	[161463] = true, -- Doom's Fury
	[161412] = true, -- Spiritbound Voodoo Burl
	[161379] = true, -- Galecaller's Beak
	[161125] = true, -- Kaja-fied Banana
	[161119] = true, -- Ravasaur Skull Bijou
	[161113] = true, -- Incessantly Ticking Clock
	[160655] = true, -- Syringe of Bloodborne Infirmity
	[160653] = true, -- Xalzaix's Veiled Eye
	[160652] = true, -- Construct Overcharger
	[160650] = true, -- Disc of Systematic Regression
	[160648] = true, -- Frenetic Corpuscle
	[160263] = true, -- Snowpelt Mangler
	[159628] = true, -- Kul Tiran Cannonball Runner
	[159627] = true, -- Jes' Howler
	[159626] = true, -- Lingering Sporepods
	[159623] = true, -- Dead-Eye Spyglass
	[159619] = true, -- Briny Barnacle
	[159618] = true, -- Mchimba's Ritual Bandages
	[159617] = true, -- Lustrous Golden Plumage
	[159616] = true, -- Gore-Crusted Butcher's Block
	[159614] = true, -- Galecaller's Boon
	[159611] = true, -- Razdunk's Big Red Button
	[158712] = true, -- Rezan's Gleaming Eye
	[158556] = true, -- Siren's Tongue
	[158555] = true, -- Doom Shroom
	[158374] = true, -- Tiny Electromental in a Jar
	[158367] = true, -- Merektha's Fang
	[158319] = true, -- My'das Talisman
	[158224] = true, -- Vial of Storms
	[158218] = true, -- Dadalea's Wing
	[158216] = true, -- Living Oil Cannister
	[155881] = true, -- Harlan's Loaded Dice
	[155568] = true, -- Galewind Chimes
	
	-- Legion Trinkets
	[154176] = true, -- Khaz'goroth's Courage
	[154174] = true, -- Golganneth's Vitality
	[154173] = true, -- Aggramar's Conviction
	[153544] = true, -- Eye of F'harg
	[151977] = true, -- Diima's Glacial Aegis
	[151312] = true, -- Ampoule of Pure Void
	[151307] = true, -- Void Stalker's Contract
	[151190] = true, -- Specter of Betrayal
	[150527] = true, -- Madness of the Betrayer
	[150526] = true, -- Shadowmoon Insignia
	[147022] = true, -- Feverish Carapace
	[147019] = true, -- Tome of Unraveling Sanity
	[147011] = true, -- Vial of Ceaseless Toxins
	[144482] = true, -- Fel-Oiled Infernal Machine
	[144477] = true, -- Splinters of Agronox
	[144122] = true, -- Carbonic Carbuncle
	[144113] = true, -- Windswept Pages
	[142508] = true, -- Chains of the Valorous
	[142506] = true, -- Eye of Guarm
	[142167] = true, -- Eye of Command
	[142166] = true, -- Ethereal Urn
	[142165] = true, -- Deteriorated Construct Core
	[142159] = true, -- Bloodstained Handkerchief
	[141586] = true, -- Marfisi's Giant Censer
	[141585] = true, -- Six-Feather Fan
	[141537] = true, -- Thrice-Accursed Compass
	[141535] = true, -- Ettin Fingernail
	[140806] = true, -- Convergence of Fates
	[140802] = true, -- Nightblooming Frond
	[140799] = true, -- Might of Krosus
	[140797] = true, -- Fang of Tichondrius
	[140796] = true, -- Entwined Elemental Foci
	[140794] = true, -- Arcanogolem Digit
	[140790] = true, -- Claw of the Crystalline Scorpid
	[139630] = true, -- Etching of SargerasDemon Hunter
	[139329] = true, -- Bloodthirsty Instinct
	[139328] = true, -- Ursoc's Rending Paw
	[139324] = true, -- Goblet of Nightmarish Ichor
	[139323] = true, -- Twisting Wind
	[137537] = true, -- Tirathon's Betrayal
	[137419] = true, -- Chrono Shard
	[137373] = true, -- Tempered Egg of Serpentrix
	[137367] = true, -- Stormsinger Fulmination Charge
	[137338] = true, -- Shard of Rokmora
	[137312] = true, -- Nightmare Egg Shell
	[136978] = true, -- Ember of Nullification
	[136975] = true, -- Hunger of the Pack
	[133647] = true, -- Gift of Radiance
	[133644] = true, -- Memento of Angerboda
	[131799] = true, -- Zugdug's Piece of Paradise
	[130126] = true, -- Iron Branch
	[129163] = true, -- Lost Etin's Strength
	[129091] = true, -- Golza's Iron Fin
	[121808] = true  -- Nether Conductors
}

local TRINKET_UNKNOWN = {
	-- 8.0 Trinkets
	[163703] = true, -- Crawg Gnawed Femur
	[161473] = true, -- Lion's Guile
	[161462] = true, -- Doom's Wake
	[161419] = true, -- Kraulok's Claw
	[161381] = true, -- Permafrost-Encrusted Heart
	[161380] = true, -- Drust-Runed Icicle
	[161378] = true, -- Plume of the Seaborne Avian
	[161376] = true, -- Prism of Dark Intensity
	[160656] = true, -- Twitching Tentacle of Xalzaix
	[160654] = true, -- Vanquished Tendril of G'huun
	[159630] = true, -- Balefire Branch
	[159625] = true, -- Vial of Animated Blood
	[159612] = true, -- Azerokk's Resonating Heart
	[158215] = true, -- Whirlwing's Plumage
	
	-- Legion Trinkets
	[156458] = true, -- Vanquished Clutches of Yogg-Saron
	[156345] = true, -- Royal Seal of King Llane
	[156234] = true, -- Blood of the Old God
	[156230] = true, -- Flare of the Heavens
	[156221] = true, -- The General's Heart
	[156041] = true, -- Furnace Stone
	[156036] = true, -- Eye of the Broodmother
	[156016] = true, -- Pyrite Infuser
	[155952] = true, -- Heart of Iron
	[155947] = true, -- Living Flame
	[154177] = true, -- Norgannon's Prowess
	[152645] = true, -- Eye of Shatug
	[152289] = true, -- Highfather's Machination
	[152093] = true, -- Gorshalach's Legacy
	[151978] = true, -- Smoldering Titanguard
	[151976] = true, -- Riftworld Codex
	[151975] = true, -- Apocalypse Drive
	[151974] = true, -- Eye of
	[151970] = true, -- Vitality Resonator
	[151969] = true, -- Terminus Signaling Beacon
	[151968] = true, -- Shadow-Singed Fang
	[151964] = true, -- Seeping Scourgewing
	[151963] = true, -- Forgefiend's Fabricator
	[151962] = true, -- Prototype Personnel Decimator
	[151957] = true, -- Ishkar's Felshield Emitter
	[150388] = true, -- Hibernation Crystal
	[147026] = true, -- Shifting Cosmic Sliver
	[147025] = true, -- Recompiled Guardian Module
	[147024] = true, -- Reliquary of the Damned
	[147023] = true, -- Leviathan's Hunger
	[147018] = true, -- Spectral Thurible
	[147017] = true, -- Tarnished Sentinel Medallion
	[147016] = true, -- Terror From Below
	[147015] = true, -- Engine of Eradication
	[147012] = true, -- Umbral Moonglaives
	[147010] = true, -- Cradle of Anguish
	[147009] = true, -- Infernal Cinders
	[147007] = true, -- The Deceiver's Grand Design
	[147006] = true, -- Archive of Faith
	[147004] = true, -- Sea Star of the Depthmother
	[144161] = true, -- Lessons of the Darkmaster
	[144160] = true, -- Searing Words
	[144158] = true, -- Flashing Steel Talisman
	[144156] = true, -- Flashfrozen Resin Globule
	[144119] = true, -- Empty Fruit Barrel
	[142169] = true, -- Raven Eidolon
	[142168] = true, -- Majordomo's Dinner Bell
	[142164] = true, -- Toe Knee's Promise
	[142161] = true, -- Inescapable Dread
	[142160] = true, -- Mrrgria's Favor
	[142158] = true, -- Faith's Crucible
	[142157] = true, -- Aran's Relaxing Ruby
	[141482] = true, -- Unstable Arcanocrystal
	[140808] = true, -- Draught of Souls
	[140807] = true, -- Infernal Contract
	[140801] = true, -- Fury of the Burning Sky
	[140800] = true, -- Pharamere's Forbidden Grimoire
	[140798] = true, -- Icon of Rot
	[140795] = true, -- Aluriel's Mirror
	[140793] = true, -- Perfectly Preserved Cake
	[140791] = true, -- Royal Dagger Haft
	[140789] = true, -- Animated Exoskeleton
	[140533] = true, -- Huntmaster's Injector
	[139336] = true, -- Bough of Corruption
	[139335] = true, -- Grotesque Statuette
	[139330] = true, -- Heightened Senses
	[139327] = true, -- Unbridled Fury
	[139326] = true, -- Wriggling Sinew
	[139325] = true, -- Spontaneous Appendages
	[139321] = true, -- Swarming Plaguehive
	[139320] = true, -- Ravaged Seed Pod
	[138225] = true, -- Phantasmal Echo
	[138224] = true, -- Unstable Horrorslime
	[138222] = true, -- Vial of Nightmare Fog
	[137541] = true, -- Moonlit Prism
	[137540] = true, -- Concave Reflecting Lens
	[137539] = true, -- Faulty Countermeasure
	[137538] = true, -- Orb of Torment
	[137486] = true, -- Windscar Whetstone
	[137459] = true, -- Chaos Talisman
	[137446] = true, -- Elementium Bomb Squirrel Generator
	[137440] = true, -- Shivermaw's Jawbone
	[137439] = true, -- Tiny Oozeling in a Jar
	[137433] = true, -- Obelisk of the Void
	[137430] = true, -- Impenetrable Nerubian Husk
	[137406] = true, -- Terrorbound Nexus
	[137400] = true, -- Coagulated Nightwell Residue
	[137378] = true, -- Bottled Hurricane
	[137369] = true, -- Giant Ornamental Pearl
	[137362] = true, -- Parjesh's Medallion
	[137357] = true, -- Mark of Dargrul
	[137344] = true, -- Talisman of the Cragshaper
	[137329] = true, -- Figurehead of the Naglfar
	[137315] = true, -- Writhing Heart of Darkness
	[137306] = true, -- Oakheart's Gnarled Root
	[137301] = true, -- Corrupted Starlight
	[136716] = true, -- Caged Horror
	[136715] = true, -- Spiked Counterweight
	[133766] = true, -- Nether Anti-Toxin
	[133646] = true, -- Mote of Sanctification
	[133645] = true, -- Naglfar Fare
	[133641] = true, -- Eye of Skovald
	[133580] = true, -- Brutarg's Sword TipDemon Hunter
	[132895] = true, -- The Watcher's Divine Inspiration
	[129101] = true, -- Alpha's Paw
	[129044] = true, -- Frothing Helhound's Fury
	[128958] = true, -- Lekos' LeashDemon Hunter
	[121810] = true, -- Pocket Void Portal
	[121806] = true  -- Mountain Rage Shaker
}

function PLH_GetTrinketList(role)
	trinketList = nil
	if role == PLH_ROLE_AGILITY_DPS then
		trinketList = TRINKET_AGILITY_DPS
	elseif role == PLH_ROLE_INTELLECT_DPS then
		trinketList = TRINKET_INTELLECT_DPS
	elseif role == PLH_ROLE_STRENGTH_DPS then
		trinketList = TRINKET_STRENGTH_DPS
	elseif role == PLH_ROLE_HEALER then
		trinketList = TRINKET_HEALER
	elseif role == PLH_ROLE_TANK then
		trinketList = TRINKET_TANK
	elseif role == PLH_ROLE_UNKNOWN then
		trinketList = TRINKET_UNKNOWN
	end
	return trinketList
end


-- Keys for the waitFrames and waitTables arrays
PLH_WAIT_FOR_ENABLE_OR_DISABLE = 1
PLH_WAIT_FOR_INSPECT = 2

local waitFrames = {}
local waitTables = {}

--[[
informational - possible tooltip item type row arrangements

Ranged				Bow
Ranged				Crossbow
Ranged				Gun
Ranged				Wand

One-Hand			Dagger
One-Hand			Fist Weapon
One-Hand			Axe
One-Hand			Mace
One-Hand			Sword

Two-Hand			Polearm
Two-Hand			Staff
Two-Hand			Axe
Two-Hand			Mace
Two-Hand			Sword

Off Hand			Shield

Held In Off-hand	nil

Head				[Cloth/Leather/Mail/Plate]
Neck				nil
Shoulder			[Cloth/Leather/Mail/Plate]
Back				nil
Chest				[Cloth/Leather/Mail/Plate]
ALSO SHIRT AND TABARAD
Wrist				[Cloth/Leather/Mail/Plate]
Hands				[Cloth/Leather/Mail/Plate]
Waist				[Cloth/Leather/Mail/Plate]
Legs				[Cloth/Leather/Mail/Plate]
Feet				[Cloth/Leather/Mail/Plate]
Finger				nil
Trinket				nil
]]--


local function GetNameWithoutSpacesInRealm(name)
	if name == nil or string.find(name, '-') == nil then
		return name
	else
		local shortname, realm = name:match('(.+)-(.+)')
		realm = realm:gsub("%s+","")
		return shortname .. '-' .. realm
	end
end

function PLH_GetFullName(name)
	if name == nil then
		return nil
	elseif string.find(name, '-') ~= nil then
		return GetNameWithoutSpacesInRealm(name)
	else
		local guid = UnitGUID(name)
		if guid ~= nil then
			local _, _, _, _, _, shortname, realm = GetPlayerInfoByGUID(guid)
			if not realm or realm == '' then
				realm = GetRealmName()
			end
			if shortname == nil then
				return nil
			elseif realm == nil then
				return shortname
			else
				return GetNameWithoutSpacesInRealm(shortname .. '-' .. realm)
			end
		else
			return name
		end
	end
end

local function CanUseRaidWarning()
	return UnitIsGroupLeader('player') or UnitIsRaidOfficer('player')
end

local function GetBroadcastChannel(isHighPriority)
	local channel
	if IsInGroup() then
		if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
			if CanUseRaidWarning() and isHighPriority then 
				channel = 'RAID_WARNING'
			else
				channel = 'INSTANCE_CHAT'
			end
		elseif IsInRaid() then
			if CanUseRaidWarning() and isHighPriority then 
				channel = 'RAID_WARNING'
			else
				channel = 'RAID'
			end
		else	
			channel = 'PARTY'
		end
	else
		channel = 'EMOTE'  -- for testing purposes
	end
	return channel
end

local function GetColoredMessage(message, color)
	if message ~= nil then
		message = color .. message   							-- set desired color at the start
		message = string.gsub(message, '|r', '|r' .. color)		-- set to our color if the message sets color to default (ex: end of an item link)
		message = message .. _G.FONT_COLOR_CODE_CLOSE			-- set color back to default
	end
	return message
end

function PLH_SendBroadcast(message, isHighPriority)
	SendChatMessage('<2UI> ' .. message, GetBroadcastChannel(isHighPriority))
end	

function PLH_SendWhisper(message, person)
	SendChatMessage('<2UI> ' .. message, 'WHISPER', nil, person)
end

function PLH_SendAlert(message)
	print(GetColoredMessage('<2UI> ', _G.YELLOW_FONT_COLOR_CODE) .. GetColoredMessage(message, _G.GREEN_FONT_COLOR_CODE))
end	

function PLH_SendUserMessage(message)
	print(GetColoredMessage('<2UI> ', _G.YELLOW_FONT_COLOR_CODE) .. GetColoredMessage(message, _G.LIGHTYELLOW_FONT_COLOR_CODE))
end	

function PLH_SendDebugMessage(message)
	if PLH_PREFS[PLH_PREFS_DEBUG] then
		print(GetColoredMessage('<2UI> ', _G.YELLOW_FONT_COLOR_CODE) .. GetColoredMessage(message, _G.GRAY_FONT_COLOR_CODE))
	end		
end	

-- Returns the message that would be whispered when player requests an item
function PLH_GetWhisperMessage(itemLink, message)
	if message == nil then
		message = PLH_PREFS[PLH_PREFS_WHISPER_MESSAGE]
	end
	return message:gsub('%%item', itemLink)
end

-- Waits for delay seconds before executing func
-- the waitType parameter allows us to have multiple wait loops going on at once; pass in a unique ID for each possible type of wait loop
function PLH_wait(waitType, delay, func, ...)
	if (type(delay) == 'number' and type(func) == 'function') then
		if waitTables[waitType] == nil then
			waitTables[waitType] = {}
		end
		if waitFrames[waitType] == nil then
			waitFrames[waitType] = CreateFrame('Frame', 'PLH_WaitFrame' .. waitType, UIParent)
			waitFrames[waitType]:SetScript('onUpdate', function (self, elapse)
				local count = #waitTables[waitType]
				local i = 1
				while i <= count do
					local waitRecord = tremove(waitTables[waitType], i)
					local d = tremove(waitRecord, 1)
					local f = tremove(waitRecord, 1)
					local p = tremove(waitRecord, 1)
					if d > elapse then
						tinsert(waitTables[waitType], i, {d - elapse, f, p})
						i = i + 1
					else
						count = count - 1
						f(unpack(p))
					end
				end
			end);
		end
		tinsert(waitTables[waitType], {delay, func, {...}});
	else
		print('PLH_wait中的错误类型')
	end
end

function PLH_PreemptWait(waitType)
	local waiting = #waitTables[waitType] ~= nil and #waitTables[waitType] > 0
	waitTables[waitType] = {}
	return waiting
end

--[[
-- not used, but keeping for educational purposes
function GetEscapedItemLink(item)
	return string.gsub(item, '|', '||')
end
]]--

if GetLocale() == "zhCN" then
  PersonalLootHelperLocal = "|cffC69B6D[拾取]|r求装助手";
elseif GetLocale() == "zhTW" then
  PersonalLootHelperLocal = "|cffC69B6D[拾取]|r求装助手";
else
  PersonalLootHelperLocal = "|cffC69B6DPersonal Loot Helper|r";
end

function PLH_CreateOptionsPanel()

	--[[ Main Panel ]]--
	local configFrame = CreateFrame('Frame', 'PLHConfigFrame', InterfaceOptionsFramePanelContainer)
	configFrame:Hide()
	configFrame.name = PersonalLootHelperLocal
	local category, layout = Settings.RegisterCanvasLayoutCategory(configFrame, configFrame.name, configFrame.name);
	category.ID = configFrame.name;
	Settings.RegisterAddOnCategory(category);

	--[[ Title ]]--
	local titleLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
	titleLabel:SetPoint('TOPLEFT', configFrame, 'TOPLEFT', 16, -16)
	titleLabel:SetText('求装助手 (PLH)')

	-- [[ Version ]] --
	local versionLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
	local metaVersion = 'v2.38'
	versionLabel:SetPoint('BOTTOMLEFT', titleLabel, 'BOTTOMRIGHT', 8, 0)
	--versionLabel:SetText(((metaVersion:find("^v") ~= nil) and "" or "v") .. metaVersion)

	--[[ Author ]]--
	local authorLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
	authorLabel:SetPoint('TOPRIGHT', configFrame, 'TOPRIGHT', -16, -24)
	authorLabel:SetText('cardinalm1, Elvenbane')

	--[[ Display Options ]]--
	local displayLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	displayLabel:SetPoint('TOPLEFT', titleLabel, 'BOTTOMLEFT', 0, -20)
	displayLabel:SetText("显示设置")
	
	--[[ PLH_PREFS_AUTO_HIDE ]]--
--[[
	local autoHideCheckbox = CreateFrame('CheckButton', nil, configFrame, 'InterfaceOptionsCheckButtonTemplate')
	autoHideCheckbox:SetPoint('TOPLEFT', displayLabel, 'BOTTOMLEFT', 20, -5)
	autoHideCheckbox:SetChecked(PLH_PREFS[PLH_PREFS_AUTO_HIDE])

	local autoHideLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	autoHideLabel:SetPoint('LEFT', autoHideCheckbox, 'RIGHT', 0, 0)
	autoHideLabel:SetText("Automatically hide PLH when there is no loot to trade")
]]--

	--[[ PLH_PREFS_SKIP_CONFIRMATION ]]--
	local skipConfirmationCheckbox = CreateFrame('CheckButton', nil, configFrame, 'InterfaceOptionsCheckButtonTemplate')
	skipConfirmationCheckbox:SetPoint('TOPLEFT', displayLabel, 'BOTTOMLEFT', 20, -5)
	skipConfirmationCheckbox:SetChecked(PLH_PREFS[PLH_PREFS_SKIP_CONFIRMATION])
	skipConfirmationCheckbox:SetScript("OnClick", CheckBox_OnClick)


	local skipConfirmationLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	skipConfirmationLabel:SetPoint('LEFT', skipConfirmationCheckbox, 'RIGHT', 0, 0)
	skipConfirmationLabel:SetText("在提供或请求战利品时自动跳过确认步骤")

	--[[ PLH_PREFS_ANNOUNCE_TRADES ]]--
	local announceTradesCheckbox = CreateFrame('CheckButton', nil, configFrame, 'InterfaceOptionsCheckButtonTemplate')
	announceTradesCheckbox:SetPoint('TOPLEFT', skipConfirmationCheckbox, 'BOTTOMLEFT', 0, -5)
	announceTradesCheckbox:SetChecked(PLH_PREFS[PLH_PREFS_ANNOUNCE_TRADES])
	announceTradesCheckbox:SetScript("OnClick", CheckBox_OnClick)

	local announceTradeLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	announceTradeLabel:SetPoint('LEFT', announceTradesCheckbox, 'RIGHT', 0, 0)
	announceTradeLabel:SetText("通告完成的交易（仅在公会队伍中）")
	
	--[[ Looter Options ]]--
	local looterLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	looterLabel:SetPoint('TOPLEFT', announceTradesCheckbox, 'BOTTOMLEFT', -20, -15)
	looterLabel:SetText("当你获得可交易的战利品时……")
	
	--[[ PLH_PREFS_ONLY_OFFER_IF_UPGRADE ]]
	local onlyOfferIfUpgradeCheckbox = CreateFrame('CheckButton', nil, configFrame, 'InterfaceOptionsCheckButtonTemplate')
	onlyOfferIfUpgradeCheckbox:SetPoint('TOPLEFT', looterLabel, 'BOTTOMLEFT', 20, -5)
	onlyOfferIfUpgradeCheckbox:SetChecked(PLH_PREFS[PLH_PREFS_ONLY_OFFER_IF_UPGRADE])
	onlyOfferIfUpgradeCheckbox:SetScript("OnClick", CheckBox_OnClick)

	local onlyOfferIfUpgradeLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	onlyOfferIfUpgradeLabel:SetPoint('LEFT', onlyOfferIfUpgradeCheckbox, 'RIGHT', 0, 0)
	onlyOfferIfUpgradeLabel:SetText("只有当战利品能够提升其他玩家的装等时，才提示我进行交易")

	--[[ PLH_PREFS_NEVER_OFFER_BOE ]]--
	local neverOfferBOECheckbox = CreateFrame('CheckButton', nil, configFrame, 'InterfaceOptionsCheckButtonTemplate')
	neverOfferBOECheckbox:SetPoint('TOPLEFT', onlyOfferIfUpgradeCheckbox, 'BOTTOMLEFT', 0, -5)
	neverOfferBOECheckbox:SetChecked(PLH_PREFS[PLH_PREFS_NEVER_OFFER_BOE])
	neverOfferBOECheckbox:SetScript("OnClick", CheckBox_OnClick)

	local neverOfferBOELabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	neverOfferBOELabel:SetPoint('LEFT', neverOfferBOECheckbox, 'RIGHT', 0, 0)
	neverOfferBOELabel:SetText("不要提示我交易灵魂绑定的战利品")

	-- [[ PLH_PREFS_SHOW_TRADEABLE_ALERT ]] --
	local showTradeableAlertCheckbox = CreateFrame('CheckButton', nil, configFrame, 'InterfaceOptionsCheckButtonTemplate')
	showTradeableAlertCheckbox:SetPoint('TOPLEFT', neverOfferBOECheckbox, 'BOTTOMLEFT', 0, -5)
	showTradeableAlertCheckbox:SetChecked(PLH_PREFS[PLH_PREFS_SHOW_TRADEABLE_ALERT])
	showTradeableAlertCheckbox:SetScript("OnClick", CheckBox_OnClick)

	local showTradeableAlertLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	showTradeableAlertLabel:SetPoint('LEFT', showTradeableAlertCheckbox, 'RIGHT', 0, 0)
	showTradeableAlertLabel:SetText("显示可以使用战利品的人员列表")
	
	--[[ Non-looter Options ]]--
	local nonLooterLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	nonLooterLabel:SetPoint('TOPLEFT', showTradeableAlertCheckbox, 'BOTTOMLEFT', -20, -15)
	nonLooterLabel:SetText("当其他人获得可交易的战利品时……")

	--[[ PLH_PREFS_CURRENT_SPEC_ONLY ]]--
	local currentSpecOnlyCheckbox = CreateFrame('CheckButton', nil, configFrame, 'InterfaceOptionsCheckButtonTemplate')
	currentSpecOnlyCheckbox:SetPoint('TOPLEFT', nonLooterLabel, 'BOTTOMLEFT', 20, -5)
	currentSpecOnlyCheckbox:SetChecked(PLH_PREFS[PLH_PREFS_CURRENT_SPEC_ONLY])
	currentSpecOnlyCheckbox:SetScript("OnClick", CheckBox_OnClick)

	local currentSpecOnlyLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	currentSpecOnlyLabel:SetPoint('LEFT', currentSpecOnlyCheckbox, 'RIGHT', 0, 0)
	currentSpecOnlyLabel:SetText("只有在我当前专精可以装备的情况下才提醒我")

	--[[ PLH_PREFS_ILVL_THRESHOLD ]]--

	local ilvlThresholdLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	ilvlThresholdLabel:SetPoint('TOPLEFT', currentSpecOnlyCheckbox, 'BOTTOMLEFT', 5, -10)
	ilvlThresholdLabel:SetText("只在以下情况提醒我：")

	local ilvlThresholdValue = {
		0,
		-1,
		-6,
		-11,
		-16,
		-21,
		-26,
		-31,
		-9999
	}

local ilvlThresholdDescription = {
	"战利品装等|cffff7fff高于|r当前装备装等",
	"战利品装等|cffff7fff至少等于|r当前装备装等",
	"战利品装等|cffff7fff不低于|r当前装备装等|cffff00005级|r",
	"战利品装等|cffff7fff不低于|r当前装备装等|cffff000010级|r",
	"战利品装等|cffff7fff不低于|r当前装备装等|cffff000015级|r",
	"战利品装等|cffff7fff不低于|r当前装备装等|cffff000020级|r",
	"战利品装等|cffff7fff不低于|r当前装备装等|cffff000025级|r",
	"战利品装等|cffff7fff不低于|r当前装备装等|cffff000030级|r",
	"总是显示所有物品"
}
	local ilvlThresholdMenu = CreateFrame("Frame", 'ilvlThresholdMenu', configFrame, "UIDropDownMenuTemplate")  --MSA_DropDownMenu_Create('ilvlThresholdMenu', configFrame)
	ilvlThresholdMenu:SetPoint('LEFT', ilvlThresholdLabel, 'RIGHT', -5, 0)

	local function ilvlThresholdMenu_OnClick(self, arg1, arg2, checked)
		UIDropDownMenu_SetText(ilvlThresholdMenu, ilvlThresholdDescription[arg1])
	end

	local function ilvlThresholdMenu_Initialize(self, level)
		local info = UIDropDownMenu_CreateInfo()
		info.func = ilvlThresholdMenu_OnClick
		for i = 1, #ilvlThresholdValue do
			info.arg1 = i
			info.text = ilvlThresholdDescription[i]
			UIDropDownMenu_AddButton(info)
		end
	end

	UIDropDownMenu_Initialize(ilvlThresholdMenu, ilvlThresholdMenu_Initialize)
	UIDropDownMenu_SetWidth(ilvlThresholdMenu, 300);
	UIDropDownMenu_JustifyText(ilvlThresholdMenu, 'LEFT')

	local function GetILVLThresholdDescription(ilvlThreshold)
		for i = 1, #ilvlThresholdValue do
			if ilvlThresholdValue[i] == ilvlThreshold then
				return ilvlThresholdDescription[i]
			end
		end
		return ilvlThresholdDescription[2]  -- we couldn't find a match, so return default
	end

	local function GetILVLThresholdValue(description)
		for i = 1, #ilvlThresholdDescription do
			if ilvlThresholdDescription[i] == description then
				return ilvlThresholdValue[i]
			end
		end
		return ilvlThresholdValue[2]  -- we couldn't find a match, so return default
	end

	UIDropDownMenu_SetText(ilvlThresholdMenu, GetILVLThresholdDescription(PLH_PREFS[PLH_PREFS_ILVL_THRESHOLD]))
	
	--[[ PLH_PREFS_INCLUDE_XMOG ]]--
	
	local includeXMOGCheckbox = CreateFrame('CheckButton', nil, configFrame, 'InterfaceOptionsCheckButtonTemplate')
	includeXMOGCheckbox:SetPoint('TOPLEFT', neverOfferBOECheckbox, 'BOTTOMLEFT', 0, -120)
	includeXMOGCheckbox:SetChecked(PLH_PREFS[PLH_PREFS_INCLUDE_XMOG])
	includeXMOGCheckbox:SetScript("OnClick", CheckBox_OnClick)

	local includeXMOGLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	includeXMOGLabel:SetPoint('LEFT', includeXMOGCheckbox, 'RIGHT', 0, 0)
	includeXMOGLabel:SetText("即使物品不能提升装等，也提示我可以幻化")

	-- [[ PLH_PREFS_WHISPER_MESSAGE ]]--
	
	local sampleItem = '\124cffa335ee\124Hitem:151981::::::::110::::2:1522:3610:\124h[Life-Bearing Footpads]\124h\124r'
	local whisperMessageLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	whisperMessageLabel:SetPoint('TOPLEFT', includeXMOGCheckbox, 'BOTTOMLEFT', -25, -15)
	whisperMessageLabel:SetText("当你想向没有使用[拾取助手]的玩家请求他的战利品时，请输入密语的信息。\n" ..
		"你可以使用 %item 来包含被需求的物品。例如：\n" ..
		--"      \"" .. PLH_DEFAULT_PREFS[PLH_PREFS_WHISPER_MESSAGE] .. "\" 会被显示为\n" ..
		"      \"" .. PLH_GetWhisperMessage(sampleItem, PLH_DEFAULT_PREFS[PLH_PREFS_WHISPER_MESSAGE]) .. "\"\n")
	whisperMessageLabel:SetWordWrap(true)
	whisperMessageLabel:SetJustifyH('LEFT')
	whisperMessageLabel:SetWidth(500)
	whisperMessageLabel:SetSpacing(3)

	local whisperMessageEditBox = CreateFrame('EditBox', nil, configFrame)
	whisperMessageEditBox:SetWidth(450)
	whisperMessageEditBox:SetHeight(30)
	whisperMessageEditBox:SetTextInsets(4, 4, 4, 4)
	whisperMessageEditBox:SetMaxLetters(100)
	whisperMessageEditBox:SetAutoFocus(false)
	whisperMessageEditBox:SetFont('Fonts\\FRIZQT__.TTF', 13, "")
	whisperMessageEditBox:SetPoint('TOPLEFT', whisperMessageLabel, 'BOTTOMLEFT', 20, -10)
	whisperMessageEditBox:SetText(PLH_PREFS[PLH_PREFS_WHISPER_MESSAGE])
	
	local whisperMessageEditBoxBackdrop = {
		bgFile = nil, 
		edgeFile = 'Interface/Tooltips/UI-Tooltip-Border',
		tile = false,
		tileSize = 8,
		edgeSize = 8,
		insets = { left = 4, right = 4, top = 4, bottom = 4 }
	}

	local whisperMessageEditBoxBorder = CreateFrame('Frame', nil, whisperMessageEditBox, BackdropTemplateMixin and "BackdropTemplate");
	whisperMessageEditBoxBorder:SetWidth(whisperMessageEditBox:GetWidth() + 5)
	whisperMessageEditBoxBorder:SetHeight(whisperMessageEditBox:GetHeight() + 5)
	whisperMessageEditBoxBorder:SetPoint('CENTER', whisperMessageEditBox, 'CENTER')
	whisperMessageEditBoxBorder:SetBackdrop(whisperMessageEditBoxBackdrop)

	--[[ Thank You Message ]] --
	local thankYouLabel = configFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	thankYouLabel:SetPoint('BOTTOM', configFrame, 'BOTTOM', 0, 24)
	thankYouLabel:SetSpacing(5)
	thankYouLabel:SetWidth(500)
	thankYouLabel:SetWordWrap(true)
	
	local function UpdateThankYouLabel()
		local text = ''
--		if PLH_STATS[PLH_ITEMS_REQUESTED] > 0 or PLH_STATS[PLH_ITEMS_RECEIVED] > 0 then
--			text = text .. "You have requested " .. PLH_STATS[PLH_ITEMS_REQUESTED] .. " and received " .. PLH_STATS[PLH_ITEMS_RECEIVED] .. " item(s) through PLH\n"
--		end
--		if PLH_STATS[PLH_ITEMS_OFFERED] > 0 or PLH_STATS[PLH_ITEMS_GIVEN_AWAY] > 0 then
--			text = text .. "You have offered " .. PLH_STATS[PLH_ITEMS_OFFERED] .. " and given away " .. PLH_STATS[PLH_ITEMS_GIVEN_AWAY] .. " item(s) through PLH\n"
--		end
--		if PLH_GetNumberOfPLHUsers() > 0 then
--			text = text .. PLH_GetNumberOfPLHUsers() .. " of " .. GetNumGroupMembers() .. " group members are running PLH\n"
--		end
		text = text .. "如果你觉得 [PersonalLootHelper] 和 2UI 很有用，请告诉你的朋友和公会成员！"
		thankYouLabel:SetText(text)
	end
	
	--[[ OnShow Event]]
	configFrame:SetScript('OnShow', function(frame)
		-- autoHideCheckbox:SetChecked(PLH_PREFS[PLH_PREFS_AUTO_HIDE])
		skipConfirmationCheckbox:SetChecked(PLH_PREFS[PLH_PREFS_SKIP_CONFIRMATION])
		announceTradesCheckbox:SetChecked(PLH_PREFS[PLH_PREFS_ANNOUNCE_TRADES])
		onlyOfferIfUpgradeCheckbox:SetChecked(PLH_PREFS[PLH_PREFS_ONLY_OFFER_IF_UPGRADE])
		neverOfferBOECheckbox:SetChecked(PLH_PREFS[PLH_PREFS_NEVER_OFFER_BOE])
		showTradeableAlertCheckbox:SetChecked(PLH_PREFS[PLH_PREFS_SHOW_TRADEABLE_ALERT])
		currentSpecOnlyCheckbox:SetChecked(PLH_PREFS[PLH_PREFS_CURRENT_SPEC_ONLY])
		UIDropDownMenu_SetText(ilvlThresholdMenu, GetILVLThresholdDescription(PLH_PREFS[PLH_PREFS_ILVL_THRESHOLD]))
		includeXMOGCheckbox:SetChecked(PLH_PREFS[PLH_PREFS_INCLUDE_XMOG])
		whisperMessageEditBox:SetText(PLH_PREFS[PLH_PREFS_WHISPER_MESSAGE])
		UpdateThankYouLabel()
	end)

	--[[ Save config ]]--
    configFrame:SetScript("OnHide", function()
		-- PLH_PREFS[PLH_PREFS_AUTO_HIDE] = autoHideCheckbox:GetChecked()
		PLH_PREFS[PLH_PREFS_SKIP_CONFIRMATION] = skipConfirmationCheckbox:GetChecked()
		PLH_PREFS[PLH_PREFS_ANNOUNCE_TRADES] = announceTradesCheckbox:GetChecked()
		PLH_PREFS[PLH_PREFS_ONLY_OFFER_IF_UPGRADE] = onlyOfferIfUpgradeCheckbox:GetChecked()
		PLH_PREFS[PLH_PREFS_NEVER_OFFER_BOE] = neverOfferBOECheckbox:GetChecked()
		PLH_PREFS[PLH_PREFS_SHOW_TRADEABLE_ALERT] = showTradeableAlertCheckbox:GetChecked()
		PLH_PREFS[PLH_PREFS_CURRENT_SPEC_ONLY] = currentSpecOnlyCheckbox:GetChecked()
		PLH_PREFS[PLH_PREFS_ILVL_THRESHOLD] = GetILVLThresholdValue(UIDropDownMenu_GetText(ilvlThresholdMenu))
		PLH_PREFS[PLH_PREFS_INCLUDE_XMOG] = includeXMOGCheckbox:GetChecked()
		if PLH_PREFS[PLH_PREFS_WHISPER_MESSAGE] ~= whisperMessageEditBox:GetText() then
			PLH_PREFS[PLH_PREFS_WHISPER_MESSAGE] = whisperMessageEditBox:GetText()
			PLH_META[PLH_SHOW_WHISPER_WARNING] = true
		end
	end)

end


--[[

TODOs:
	Add legacy mode to show system alerts only?
	Add legacy coordinate rolls mode back?
	Remove whisper/ms/os/xmog prompts right away when players leave group?  (ex: end of lfr)
	When offering loot, show how many people are eligible and keep track of who still may roll?
	Bug - whisper message doesn't allow special characters
	Don't show PLH UI if group is using RCLootCouncil
	Do something special when multiple of same item drop?  i.e. tell looter that [name] offered a duplicate of this item to [name]?
	Localization

Known Limitations:
	PLH assumes everyone in the group is eligible to receive tradeable loot; it doesn't check whether everyone
		tagged the mob or whether anyone was already loot-locked
	PLH assumes that any loot received is part of the Personal Loot system, if Personal Loot is enabled.  However,
	   items can be obtained other ways - for example, someone using a baleful token to create a baleful item.  Those
	   items are not part of the Personal Loot system, but PLH cannot distinguish them from regular loot.
	PLH determines whether an item is tradeable by comparing against the equipped item's ilvl, but the actual logic
		for personal loot determines this based on the highest ilvl ever equipped in that slot.  If you want to trade
		an item that is tradeable, but for which PLH did not notify you, you can do "/plh trade [item]".
		Ways I've tried to determine true tradeability:
			Look for _G.BIND_TRADE_TIME_REMAINING in tooltips for the itemlinks generated by CHAT_MSG_LOOT and for tooltips
				found by GetContainerItemInfo() and GetContainerItemLink()...none of those links show this text
			Check attributes of SHOW_LOOT_TOAST event...lessAwesome attribute sounded promising, but was always false
			Created https://us.battle.net/forums/en/wow/topic/20764076267#1 to discuss

Known Bugs:
	Taint issues on ACTIVE_CHAT_EDIT_BOX and LAST_ACTIVE_CHAT_EDIT_BOX when doing /plh repeatedly...however, this
		issue is also reproducable by doing /dbm repeatedly, so it's not specific to PLH.  I'm not going to worry about it.
		Created https://us.battle.net/forums/en/wow/topic/20764046364#1 to discuss
	Sometimes when clicking resize, window will double in size
		
CHANGELOG:

20210316 - 2.27
	9.0.5 version update
	Fix checkboxes on config screen
	Fix saving of "announce trades" configuration option
	
20201117 - 2.25
    Fix issue of PLH not prompting when items can be traded.  Thank you to RubioTwitch for identifying the fix!!
	
20181214 - 2.19
    8.1 version update
	
20181211 - 2.18
	Added patch 8.1 trinkets
	
20180903 - 2.17
	Fixed issue that caused PLH to not work for players whose realms have spaces in their names
	
20180902 - 2.16
	Fixed several more bugs that affected loot trading
	
20180830 - 2.15
	Fixed issue some player were having where they were shown pass/whisper buttons instead of keep/offer buttons for their own loot
	
20180828 - 2.14
	Fixed notifications for rings and trinkets where the loot is an upgrade for one slot but not the other
	Fixed trinket recommendations to pay attention to primary attributes
	
20180828 - 2.13
	Fixed version notification
	
20180828 - 2.12
    Added azerite armor back into evaluations since Blizzard is allowing Azerite armor to be traded
	
20180826 - 2.11
	Fixed announce trades to work when traded item is not something the group leader could have used
	
20180826 - 2.10
	Added option to announce trades in guild groups

20180825 - 2.09
	Fixed item caching issue that was resulting in missed or incorrect recommendations
	Added alert to show when a new version of PLH is available
	Fixed a few taint issues:
		function GetItemInfoReceivedEvent()
		variables inside RestoreMainWindowPosition()

20180725 - 2.08
	Increased time between inspections for slower computers & connections

20180724 - 2.07
	Removed "Automatically hide PLH when there is no loot to trade" as an option; instead, PLH is always auto-hidden
	Updated to never show Azerite armor as being tradeable
	Added BfA trinkets
	Fixed LUA error in IsAnUpgradeForCharacter
	Changed button back from "OFFER TO PLH USERS" to "OFFER TO GROUP".  I can't decide on the best way to label this button - I'm open
		to suggestions!
		
20180723 - 2.06
	Fixed bug that could cause upgrades to not be identified if player's items weren't cached
		(Added player items to cache instead of using GetInventoryItemLink() since player items are guaranteed to be cached post-8.0)
	Fixed bug that could cause users to not be prompted for items if items weren't cached
		(in PLH_ProcessTradeItemMessage)
	Fixed bug that could cause trinkets with primary stats to not be evaluated correctly
		(Removed trinkets from isEquippableItemForCharacter primary attribute check)
	Changed groupInfoCache to cache FullItemInfo(s) instead of items
	
20180720 - 2.05
	Fixed bug that was causing some gear to not be identified as equippable (leather gear looted by int-specced druid not identified as
		equippable by rogues, for example)
	
20180719 - 2.04
	Added option to notify individual of loot they can trade to others in the group (instead of only notifying in UI for other PLH users).
	Renamed "offer to group" button to "offer to plh users" to make it clearer; if you want to offer an item to non-PLH users,
		do so manually via whispers or instance chat.
	Made ilvl descriptions in options clearer
	Fixed bug that prevented requests from working cross-realm
	Fixed bug that caused prior items to be shown when doing "/plh show" (by moving ClearLootedItemsDisplay() earlier in UpdateLootedItemsDisplay())
	Increased time between inspections to allow cache to populate correctly
	Default whisper message if it is ''
	Removed some debug statements
	
20180718 - 2.03
	Hopefully fixed bug reported by many players of preferences not saving (config was only setting values in OnShow, not during creation)

20180718 - 2.02
	Fixed bug in which whisper message was incorrectly showing %item
	
20180718 - 2.01
	Updated to WoW version 8.0
	Fixed bug reported by many players of preferences not saving (issue was same name used for prior version preferences)
	Fixed bug reported by pro100tehb re: wrong buttons shown for looted item (I think problem was SHOW_LOOT_TOAST event)
	
20180427 - 2.00
	Updated for Battle for Azeroth - First revision to include a window for trading loot!
	Removed all relic logic since relics are being removed with BfA
	Removed Coordinate Rolls mode
	Removed chat notifications
	Removed raid frame highlight
	
]]--

local GetItemInfo = GetItemInfo or C_Item.GetItemInfo

-- Constants to control inspection process
local DELAY_BETWEEN_INSPECTIONS_LONG	= 12	-- in seconds
local DELAY_BETWEEN_INSPECTIONS_SHORT	= 0.2	-- in seconds
local MIN_DELAY_BETWEEN_CACHE_REFRESHES	= 10	-- in seconds
local MAX_INSPECT_LOOPS 				= 4    	-- maximum # of times to retry calling NotifyInspect on all members in the roster for whom we've cached fewer than the expected number of items

-- Colors for display in the looted items frame
local COLOR_PLAYER_LOOTED_ITEM		= _G.LIGHTYELLOW_FONT_COLOR_CODE
local COLOR_NON_PLAYER_LOOTED_ITEM	= _G.YELLOW_FONT_COLOR_CODE
local COLOR_HIGHER_ILVL 			= _G.GREEN_FONT_COLOR_CODE
local COLOR_LOWER_ILVL 				= _G.RED_FONT_COLOR_CODE
local COLOR_BOE						= _G.ORANGE_FONT_COLOR_CODE
local COLOR_BUTTON_TEXT				= _G.YELLOW_FONT_COLOR_CODE

-- Keys for the array returned by GetFullItemInfo()
local FII_ITEM						= 'ITEM'						-- item link
--local FII_NAME					= 'NAME'						-- return value 1 of Blizzard API call GetItemInfo()
--local FII_LINK					= 'LINK'						-- return value 2 of Blizzard API call GetItemInfo()
local FII_QUALITY					= 'QUALITY'						-- return value 3 of Blizzard API call GetItemInfo()
local FII_BASE_ILVL					= 'BASE_ILVL'					-- return value 4 of Blizzard API call GetItemInfo()
local FII_REQUIRED_LEVEL			= 'REQUIRED_LEVEL'				-- return value 5 of Blizzard API call GetItemInfo()
--local FII_TYPE					= 'TYPE'						-- return value 6 of Blizzard API call GetItemInfo()
--local FII_SUB_TYPE				= 'SUB_TYPE'					-- return value 7 of Blizzard API call GetItemInfo()
--local FII_MAX_STACK				= 'MAX_STACK'					-- return value 8 of Blizzard API call GetItemInfo()
local FII_ITEM_EQUIP_LOC			= 'ITEM_EQUIP_LOC'				-- return value 9 of Blizzard API call GetItemInfo()
--local FII_TEXTURE					= 'TEXTURE'						-- return value 10 of Blizzard API call GetItemInfo()
--local FII_VENDOR_PRICE			= 'VENDOR_PRICE'				-- return value 11 of Blizzard API call GetItemInfo()
local FII_CLASS						= 'CLASS'						-- return value 12 of Blizzard API call GetItemInfo()
local FII_SUB_CLASS					= 'SUB_CLASS'					-- return value 13 of Blizzard API call GetItemInfo()
local FII_BIND_TYPE					= 'BIND_TYPE'					-- return value 14 of Blizzard API call GetItemInfo()
--local FII_EXPAC_ID				= 'EXPAC_ID'					-- return value 15 of Blizzard API call GetItemInfo()
--local FII_ITEM_SET_ID				= 'ITEM_SET_ID'					-- return value 16 of Blizzard API call GetItemInfo()
--local FII_IS_CRAFTING_REAGENT		= 'IS_CRAFTING_REAGENT'			-- return value 17 of Blizzard API call GetItemInfo()
local FII_IS_EQUIPPABLE				= 'IS_EQUIPPABLE'				-- true if the item is equippable, false otherwise
local FII_REAL_ILVL					= 'REAL_ILVL'					-- real ilvl, derived from tooltip
local FII_CLASSES					= 'CLASSES'						-- uppercase string of classes that can use the item (ex: tier); nil if item is not class-restricted
local FII_TRADE_TIME_WARNING_SHOWN  = 'TRADE_TIME_WARNING_SHOWN'	-- true if the 'You may trade this item...' text is in the tooltip
local FII_HAS_SOCKET				= 'HAS_SOCKET'					-- true if the item has a socket
local FII_HAS_AVOIDANCE				= 'HAS_AVOIDANCE'				-- true if the item has avoidance
local FII_HAS_INDESTRUCTIBLE		= 'HAS_INDESTRUCTIBLE'			-- true if the item has indestructible
local FII_HAS_LEECH					= 'HAS_LEECH'					-- true if the item has leech
local FII_HAS_SPEED					= 'HAS_SPEED'					-- true if the item has speed
local FII_XMOGGABLE					= 'XMOGGABLE'					-- true if the player needs this item for xmog
local FII_IS_AZERITE_ITEM			= 'IS_AZERITE_ITEM'				-- true if the item is an Azerite item

-- Keys for the groupInfoCache
local CLASS_NAME					= 'CLASS_NAME'
local SPEC							= 'SPEC'
local LEVEL							= 'LEVEL'
local FORCE_REFRESH					= 'FORCE_REFRESH'

-- Keys for the lootedItems array
local LOOTER_NAME					= 'LOOTER_NAME'
local FULL_ITEM_INFO				= 'FULL_ITEM_INFO'
local STATUS						= 'STATUS'
local SELECTED_REQUESTOR_INDEX		= 'SELECTED_REQUESTOR_INDEX'
local DEFAULT_REQUESTOR_INDEX		= 'DEFAULT_REQUESTOR_INDEX'
local CONFIRMATION_MESSAGE			= 'CONFIRMATION_MESSAGE'
local REQUESTORS					= 'REQUESTORS'
local REQUESTOR_NAME				= 'REQUESTOR_NAME'
local REQUESTOR_ROLL				= 'REQUESTOR_ROLL'
local REQUESTOR_REQUEST_TYPE		= 'REQUESTOR_REQUEST_TYPE'
local REQUESTOR_SORT_ORDER			= 'REQUESTOR_SORT_ORDER'

-- Allowed values for lootedItems[STATUS]
local STATUS_DEFAULT				= 'STATUS_DEFAULT'
local STATUS_HIDDEN					= 'STATUS_HIDDEN'
local STATUS_OFFERED				= 'STATUS_OFFERED'
local STATUS_AVAILABLE				= 'STATUS_AVAILABLE'
local STATUS_KEPT					= 'STATUS_KEPT'
local STATUS_REQUESTED				= 'STATUS_REQUESTED'
local STATUS_REQUESTED_VIA_WHISPER	= 'STATUS_REQUESTED_VIA_WHISPER'

-- Allowed values for lootedItems[REQUESTORS][requestorIndex][REQUESTOR_REQUEST_TYPE]
local REQUEST_TYPE_MAIN_SPEC		= 'MAIN SPEC'
local REQUEST_TYPE_OFF_SPEC			= 'OFF SPEC'
local REQUEST_TYPE_XMOG				= 'XMOG'
local REQUEST_TYPE_SHARD			= 'SHARD'

-- Localization-independent class names

local DEATH_KNIGHT					= select(2, GetClassInfo(6))
local DEMON_HUNTER					= select(2, GetClassInfo(12))
local DRUID							= select(2, GetClassInfo(11))
local EVOKER						= select(2, GetClassInfo(13))
local HUNTER						= select(2, GetClassInfo(3))
local MAGE							= select(2, GetClassInfo(8))
local MONK							= select(2, GetClassInfo(10))
local PALADIN						= select(2, GetClassInfo(2))
local PRIEST						= select(2, GetClassInfo(5))
local ROGUE							= select(2, GetClassInfo(4))
local SHAMAN						= select(2, GetClassInfo(7))
local WARLOCK						= select(2, GetClassInfo(9))
local WARRIOR						= select(2, GetClassInfo(1))

-- Specialization IDs from http://wow.gamepedia.com/API_GetInspectSpecialization
local SPECS = {
	DK_BLOOD						= 250,
	DK_FROST						= 251,
	DK_UNHOLY						= 252,
	DH_HAVOC						= 577,
	DH_VENGEANCE					= 581,
	DRUID_BALANCE					= 102,
	DRUID_FERAL						= 103,
	DRUID_GUARDIAN					= 104,
	DRUID_RESTO						= 105,
	EVOKER_DEVA						= 1467,
	EVOKER_PRES						= 1468,
	EVOKER_AUG						= 1473,
	HUNTER_BM						= 253,
	HUNTER_MARKS					= 254,
	HUNTER_SURVIVAL					= 255,
	MAGE_ARCANE						= 62,
	MAGE_FIRE						= 63,
	MAGE_FROST						= 64,
	MONK_BM							= 268,
	MONK_MW							= 270,
	MONK_WW							= 269,
	PALADIN_HOLY					= 65,
	PALADIN_PROT					= 66,
	PALADIN_RET						= 70,
	PRIEST_DISC						= 256,
	PRIEST_HOLY						= 257,
	PRIEST_SHADOW					= 258,
	ROGUE_ASS						= 259,
	ROGUE_OUTLAW					= 260,
	ROGUE_SUB						= 261,
	SHAMAN_ELE						= 262,
	SHAMAN_ENH						= 263,
	SHAMAN_RESTO					= 264,
	WARLOCK_AFF						= 256,
	WARLOCK_DEMO					= 266,
	WARLOCK_DESTRO					= 267,
	WARRIOR_ARMS					= 71,
	WARRIOR_FURY					= 72,
	WARRIOR_PROT					= 73
}

local SPEC_BY_CLASS = {
	[DEATH_KNIGHT]					= { SPECS.DK_BLOOD, SPECS.DK_FROST, SPECS.DK_UNHOLY },
	[DEMON_HUNTER]					= { SPECS.DH_HAVOC, SPECS.DH_VENGEANCE },
	[DRUID]							= { SPECS.DRUID_BALANCE, SPECS.DRUID_FERAL, SPECS.DRUID_GUARDIAN, SPECS.DRUID_RESTO },
	[EVOKER]						= { SPECS.EVOKER_DEVA, SPECS.EVOKER_PRES, SPECS.EVOKER_AUG },
	[HUNTER]						= { SPECS.HUNTER_BM, SPECS.HUNTER_MARKS, SPECS.HUNTER_SURVIVAL },
	[MAGE]							= { SPECS.MAGE_ARCANE, SPECS.MAGE_FIRE, SPECS.MAGE_FROST },
	[MONK]							= { SPECS.MONK_BM, SPECS.MONK_MW, SPECS.MONK_WW },
	[PALADIN]						= { SPECS.PALADIN_HOLY, SPECS.PALADIN_PROT, SPECS.PALADIN_RET },
	[PRIEST]						= { SPECS.PRIEST_DISC, SPECS.PRIEST_HOLY, SPECS.PRIEST_SHADOW },
	[ROGUE]							= { SPECS.ROGUE_ASS, SPECS.ROGUE_OUTLAW, SPECS.ROGUE_SUB },
	[SHAMAN]						= { SPECS.SHAMAN_ELE, SPECS.SHAMAN_ENH, SPECS.SHAMAN_RESTO },
	[WARLOCK]						= { SPECS.WARLOCK_AFF, SPECS.WARLOCK_DEMO, SPECS.WARLOCK_DESTRO },
	[WARRIOR]						= { SPECS.WARRIOR_ARMS, SPECS.WARRIOR_FURY, SPECS.WARRIOR_PROT }
}

-- Mapping of specs to roles
local ROLE_BY_SPEC = {
	[SPECS.DK_BLOOD]				= PLH_ROLE_TANK,
	[SPECS.DK_FROST]				= PLH_ROLE_STRENGTH_DPS,
	[SPECS.DK_UNHOLY]				= PLH_ROLE_STRENGTH_DPS,
	[SPECS.DH_HAVOC]				= PLH_ROLE_AGILITY_DPS,
	[SPECS.DH_VENGEANCE]			= PLH_ROLE_TANK,
	[SPECS.DRUID_BALANCE]			= PLH_ROLE_INTELLECT_DPS,
	[SPECS.DRUID_FERAL]				= PLH_ROLE_AGILITY_DPS,
	[SPECS.DRUID_GUARDIAN]			= PLH_ROLE_TANK,
	[SPECS.DRUID_RESTO]				= PLH_ROLE_HEALER,
	[SPECS.EVOKER_DEVA]				= PLH_ROLE_INTELLECT_DPS,
	[SPECS.EVOKER_PRES]				= PLH_ROLE_HEALER,
	[SPECS.EVOKER_AUG]				= PLH_ROLE_INTELLECT_DPS,
	[SPECS.HUNTER_BM]				= PLH_ROLE_AGILITY_DPS,
	[SPECS.HUNTER_MARKS]			= PLH_ROLE_AGILITY_DPS,
	[SPECS.HUNTER_SURVIVAL]			= PLH_ROLE_AGILITY_DPS,
	[SPECS.MAGE_ARCANE]				= PLH_ROLE_INTELLECT_DPS,
	[SPECS.MAGE_FIRE]				= PLH_ROLE_INTELLECT_DPS,
	[SPECS.MAGE_FROST]				= PLH_ROLE_INTELLECT_DPS,
	[SPECS.MONK_BM]					= PLH_ROLE_TANK,
	[SPECS.MONK_MW]					= PLH_ROLE_HEALER,
	[SPECS.MONK_WW]					= PLH_ROLE_AGILITY_DPS,
	[SPECS.PALADIN_HOLY]			= PLH_ROLE_HEALER,
	[SPECS.PALADIN_PROT]			= PLH_ROLE_TANK,
	[SPECS.PALADIN_RET]				= PLH_ROLE_STRENGTH_DPS,
	[SPECS.PRIEST_DISC]				= PLH_ROLE_HEALER,
	[SPECS.PRIEST_HOLY]				= PLH_ROLE_HEALER,
	[SPECS.PRIEST_SHADOW]			= PLH_ROLE_INTELLECT_DPS,
	[SPECS.ROGUE_ASS]				= PLH_ROLE_AGILITY_DPS,
	[SPECS.ROGUE_OUTLAW]			= PLH_ROLE_AGILITY_DPS,
	[SPECS.ROGUE_SUB]				= PLH_ROLE_AGILITY_DPS,
	[SPECS.SHAMAN_ELE]				= PLH_ROLE_INTELLECT_DPS,
	[SPECS.SHAMAN_ENH]				= PLH_ROLE_AGILITY_DPS,
	[SPECS.SHAMAN_RESTO]			= PLH_ROLE_HEALER,
	[SPECS.WARLOCK_AFF]				= PLH_ROLE_INTELLECT_DPS,
	[SPECS.WARLOCK_DEMO]			= PLH_ROLE_INTELLECT_DPS,
	[SPECS.WARLOCK_DESTRO]			= PLH_ROLE_INTELLECT_DPS,
	[SPECS.WARRIOR_ARMS]			= PLH_ROLE_STRENGTH_DPS,
	[SPECS.WARRIOR_FURY]			= PLH_ROLE_STRENGTH_DPS,
	[SPECS.WARRIOR_PROT]			= PLH_ROLE_TANK
}

local PRIMARY_ATTRIBUTE_BY_SPEC = {
	[SPECS.DK_BLOOD]				= ITEM_MOD_STRENGTH_SHORT,
	[SPECS.DK_FROST]				= ITEM_MOD_STRENGTH_SHORT,
	[SPECS.DK_UNHOLY]				= ITEM_MOD_STRENGTH_SHORT,
	[SPECS.DH_HAVOC]				= ITEM_MOD_AGILITY_SHORT,
	[SPECS.DH_VENGEANCE]			= ITEM_MOD_AGILITY_SHORT,
	[SPECS.DRUID_BALANCE]			= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.DRUID_FERAL]				= ITEM_MOD_AGILITY_SHORT,
	[SPECS.DRUID_GUARDIAN]			= ITEM_MOD_AGILITY_SHORT,
	[SPECS.DRUID_RESTO]				= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.EVOKER_DEVA]				= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.EVOKER_PRES]				= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.EVOKER_AUG]				= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.HUNTER_BM]				= ITEM_MOD_AGILITY_SHORT,
	[SPECS.HUNTER_MARKS]			= ITEM_MOD_AGILITY_SHORT,
	[SPECS.HUNTER_SURVIVAL]			= ITEM_MOD_AGILITY_SHORT,
	[SPECS.MAGE_ARCANE]				= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.MAGE_FIRE]				= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.MAGE_FROST]				= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.MONK_BM]					= ITEM_MOD_AGILITY_SHORT,
	[SPECS.MONK_MW]					= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.MONK_WW]					= ITEM_MOD_AGILITY_SHORT,
	[SPECS.PALADIN_HOLY]			= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.PALADIN_PROT]			= ITEM_MOD_STRENGTH_SHORT,
	[SPECS.PALADIN_RET]				= ITEM_MOD_STRENGTH_SHORT,
	[SPECS.PRIEST_DISC]				= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.PRIEST_HOLY]				= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.PRIEST_SHADOW]			= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.ROGUE_ASS]				= ITEM_MOD_AGILITY_SHORT,
	[SPECS.ROGUE_OUTLAW]			= ITEM_MOD_AGILITY_SHORT,
	[SPECS.ROGUE_SUB]				= ITEM_MOD_AGILITY_SHORT,
	[SPECS.SHAMAN_ELE]				= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.SHAMAN_ENH]				= ITEM_MOD_AGILITY_SHORT,
	[SPECS.SHAMAN_RESTO]			= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.WARLOCK_AFF]				= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.WARLOCK_DEMO]			= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.WARLOCK_DESTRO]			= ITEM_MOD_INTELLECT_SHORT,
	[SPECS.WARRIOR_ARMS]			= ITEM_MOD_STRENGTH_SHORT,
	[SPECS.WARRIOR_FURY]			= ITEM_MOD_STRENGTH_SHORT,
	[SPECS.WARRIOR_PROT]			= ITEM_MOD_STRENGTH_SHORT
}

local ItemClass = Enum.ItemClass
local ItemArmorSubclass = Enum.ItemArmorSubclass
local ItemWeaponSubclass = Enum.ItemWeaponSubclass
local EQUIPPABLE_ARMOR_BY_SPEC = {
	[SPECS.DK_BLOOD]				= { ItemArmorSubclass.Plate },
	[SPECS.DK_FROST]				= { ItemArmorSubclass.Plate },
	[SPECS.DK_UNHOLY]				= { ItemArmorSubclass.Plate },
	[SPECS.DH_HAVOC]				= { ItemArmorSubclass.Leather },
	[SPECS.DH_VENGEANCE]			= { ItemArmorSubclass.Leather },
	[SPECS.DRUID_BALANCE]			= { ItemArmorSubclass.Leather, ItemArmorSubclass.Generic },
	[SPECS.DRUID_FERAL]				= { ItemArmorSubclass.Leather },
	[SPECS.DRUID_GUARDIAN]			= { ItemArmorSubclass.Leather },
	[SPECS.DRUID_RESTO]				= { ItemArmorSubclass.Leather, ItemArmorSubclass.Generic },
	[SPECS.EVOKER_DEVA]				= { ItemArmorSubclass.Mail, ItemArmorSubclass.Generic },
	[SPECS.EVOKER_PRES]				= { ItemArmorSubclass.Mail, ItemArmorSubclass.Generic },
	[SPECS.EVOKER_AUG]				= { ItemArmorSubclass.Mail, ItemArmorSubclass.Generic },
	[SPECS.HUNTER_BM]				= { ItemArmorSubclass.Mail },
	[SPECS.HUNTER_MARKS]			= { ItemArmorSubclass.Mail },
	[SPECS.HUNTER_SURVIVAL]			= { ItemArmorSubclass.Mail },
	[SPECS.MAGE_ARCANE]				= { ItemArmorSubclass.Cloth, ItemArmorSubclass.Generic },
	[SPECS.MAGE_FIRE]				= { ItemArmorSubclass.Cloth, ItemArmorSubclass.Generic },
	[SPECS.MAGE_FROST]				= { ItemArmorSubclass.Cloth, ItemArmorSubclass.Generic },
	[SPECS.MONK_BM]					= { ItemArmorSubclass.Leather },
	[SPECS.MONK_MW]					= { ItemArmorSubclass.Leather, ItemArmorSubclass.Generic },
	[SPECS.MONK_WW]					= { ItemArmorSubclass.Leather },
	[SPECS.PALADIN_HOLY]			= { ItemArmorSubclass.Plate, ItemArmorSubclass.Generic, ItemArmorSubclass.Shield },
	[SPECS.PALADIN_PROT]			= { ItemArmorSubclass.Plate, ItemArmorSubclass.Shield },
	[SPECS.PALADIN_RET]				= { ItemArmorSubclass.Plate },
	[SPECS.PRIEST_DISC]				= { ItemArmorSubclass.Cloth, ItemArmorSubclass.Generic },
	[SPECS.PRIEST_HOLY]				= { ItemArmorSubclass.Cloth, ItemArmorSubclass.Generic },
	[SPECS.PRIEST_SHADOW]			= { ItemArmorSubclass.Cloth, ItemArmorSubclass.Generic },
	[SPECS.ROGUE_ASS]				= { ItemArmorSubclass.Leather },
	[SPECS.ROGUE_OUTLAW]			= { ItemArmorSubclass.Leather },
	[SPECS.ROGUE_SUB]				= { ItemArmorSubclass.Leather },
	[SPECS.SHAMAN_ELE]				= { ItemArmorSubclass.Mail, ItemArmorSubclass.Generic, ItemArmorSubclass.Shield },
	[SPECS.SHAMAN_ENH]				= { ItemArmorSubclass.Mail },
	[SPECS.SHAMAN_RESTO]			= { ItemArmorSubclass.Mail, ItemArmorSubclass.Generic, ItemArmorSubclass.Shield },
	[SPECS.WARLOCK_AFF]				= { ItemArmorSubclass.Cloth, ItemArmorSubclass.Generic },
	[SPECS.WARLOCK_DEMO]			= { ItemArmorSubclass.Cloth, ItemArmorSubclass.Generic },
	[SPECS.WARLOCK_DESTRO]			= { ItemArmorSubclass.Cloth, ItemArmorSubclass.Generic },
	[SPECS.WARRIOR_ARMS]			= { ItemArmorSubclass.Plate },
	[SPECS.WARRIOR_FURY]			= { ItemArmorSubclass.Plate },
	[SPECS.WARRIOR_PROT]			= { ItemArmorSubclass.Plate, ItemArmorSubclass.Shield }
}

local EQUIPPABLE_WEAPON_BY_SPEC = {
	[SPECS.DK_BLOOD]				= { ItemWeaponSubclass.Axe2H, ItemWeaponSubclass.Mace2H, ItemWeaponSubclass.Polearm, ItemWeaponSubclass.Sword2H },
	[SPECS.DK_FROST]				= { ItemWeaponSubclass.Axe1H, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Sword1H },
	[SPECS.DK_UNHOLY]				= { ItemWeaponSubclass.Axe2H, ItemWeaponSubclass.Mace2H, ItemWeaponSubclass.Polearm, ItemWeaponSubclass.Sword2H },
	[SPECS.DH_HAVOC]				= { ItemWeaponSubclass.Axe1H, ItemWeaponSubclass.Sword1H, ItemWeaponSubclass.Unarmed, ItemWeaponSubclass.Warglaive },
	[SPECS.DH_VENGEANCE]			= { ItemWeaponSubclass.Axe1H, ItemWeaponSubclass.Sword1H, ItemWeaponSubclass.Unarmed, ItemWeaponSubclass.Warglaive },
	[SPECS.DRUID_BALANCE]			= { ItemWeaponSubclass.Dagger, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Mace2H, ItemWeaponSubclass.Polearm, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Unarmed },
	[SPECS.DRUID_FERAL]				= { ItemWeaponSubclass.Mace2H, ItemWeaponSubclass.Polearm, ItemWeaponSubclass.Staff },
	[SPECS.DRUID_GUARDIAN]			= { ItemWeaponSubclass.Mace2H, ItemWeaponSubclass.Polearm, ItemWeaponSubclass.Staff },
	[SPECS.DRUID_RESTO]				= { ItemWeaponSubclass.Dagger, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Mace2H, ItemWeaponSubclass.Polearm, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Unarmed },
	[SPECS.EVOKER_DEVA]				= { ItemWeaponSubclass.Dagger, ItemWeaponSubclass.Axe1H, ItemWeaponSubclass.Axe2H, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Mace2H, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Sword1H, ItemWeaponSubclass.Sword2H, ItemWeaponSubclass.Unarmed },
	[SPECS.EVOKER_PRES]				= { ItemWeaponSubclass.Dagger, ItemWeaponSubclass.Axe1H, ItemWeaponSubclass.Axe2H, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Mace2H, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Sword1H, ItemWeaponSubclass.Sword2H, ItemWeaponSubclass.Unarmed },
	[SPECS.EVOKER_AUG]				= { ItemWeaponSubclass.Dagger, ItemWeaponSubclass.Axe1H, ItemWeaponSubclass.Axe2H, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Mace2H, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Sword1H, ItemWeaponSubclass.Sword2H, ItemWeaponSubclass.Unarmed },
	[SPECS.HUNTER_BM]				= { ItemWeaponSubclass.Bows, ItemWeaponSubclass.Crossbow, ItemWeaponSubclass.Guns },
	[SPECS.HUNTER_MARKS]			= { ItemWeaponSubclass.Bows, ItemWeaponSubclass.Crossbow, ItemWeaponSubclass.Guns },
	[SPECS.HUNTER_SURVIVAL]			= { ItemWeaponSubclass.Polearm, ItemWeaponSubclass.Staff },
	[SPECS.MAGE_ARCANE]				= { ItemWeaponSubclass.Dagger, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Sword1H, ItemWeaponSubclass.Wand },
	[SPECS.MAGE_FIRE]				= { ItemWeaponSubclass.Dagger, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Sword1H, ItemWeaponSubclass.Wand },
	[SPECS.MAGE_FROST]				= { ItemWeaponSubclass.Dagger, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Sword1H, ItemWeaponSubclass.Wand },
	[SPECS.MONK_BM]					= { ItemWeaponSubclass.Polearm, ItemWeaponSubclass.Staff },
	[SPECS.MONK_MW]					= { ItemWeaponSubclass.Axe1H, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Polearm, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Sword1H, ItemWeaponSubclass.Unarmed },
	[SPECS.MONK_WW]					= { ItemWeaponSubclass.Axe1H, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Sword1H, ItemWeaponSubclass.Unarmed },
	[SPECS.PALADIN_HOLY]			= { ItemWeaponSubclass.Axe1H, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Mace2H, ItemWeaponSubclass.Polearm, ItemWeaponSubclass.Sword1H, ItemWeaponSubclass.Sword2H },
	[SPECS.PALADIN_PROT]			= { ItemWeaponSubclass.Axe1H, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Sword1H },
	[SPECS.PALADIN_RET]				= { ItemWeaponSubclass.Axe2H, ItemWeaponSubclass.Mace2H, ItemWeaponSubclass.Polearm, ItemWeaponSubclass.Sword2H },
	[SPECS.PRIEST_DISC]				= { ItemWeaponSubclass.Dagger, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Wand },
	[SPECS.PRIEST_HOLY]				= { ItemWeaponSubclass.Dagger, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Wand },
	[SPECS.PRIEST_SHADOW]			= { ItemWeaponSubclass.Dagger, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Wand },
	[SPECS.ROGUE_ASS]				= { ItemWeaponSubclass.Dagger },
	[SPECS.ROGUE_OUTLAW]			= { ItemWeaponSubclass.Axe1H, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Sword1H, ItemWeaponSubclass.Unarmed },
	[SPECS.ROGUE_SUB]				= { ItemWeaponSubclass.Dagger },
	[SPECS.SHAMAN_ELE]				= { ItemWeaponSubclass.Dagger, ItemWeaponSubclass.Axe1H, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Mace2H, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Unarmed },
	[SPECS.SHAMAN_ENH]				= { ItemWeaponSubclass.Axe1H, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Unarmed },
	[SPECS.SHAMAN_RESTO]			= { ItemWeaponSubclass.Dagger, ItemWeaponSubclass.Axe1H, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Mace2H, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Unarmed },
	[SPECS.WARLOCK_AFF]				= { ItemWeaponSubclass.Dagger, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Sword1H, ItemWeaponSubclass.Wand },
	[SPECS.WARLOCK_DEMO]			= { ItemWeaponSubclass.Dagger, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Sword1H, ItemWeaponSubclass.Wand },
	[SPECS.WARLOCK_DESTRO]			= { ItemWeaponSubclass.Dagger, ItemWeaponSubclass.Staff, ItemWeaponSubclass.Sword1H, ItemWeaponSubclass.Wand },
	[SPECS.WARRIOR_ARMS]			= { ItemWeaponSubclass.Axe2H, ItemWeaponSubclass.Mace2H, ItemWeaponSubclass.Polearm, ItemWeaponSubclass.Sword2H },
	[SPECS.WARRIOR_FURY]			= { ItemWeaponSubclass.Axe2H, ItemWeaponSubclass.Mace2H, ItemWeaponSubclass.Polearm, ItemWeaponSubclass.Sword2H },
	[SPECS.WARRIOR_PROT]			= { ItemWeaponSubclass.Axe1H, ItemWeaponSubclass.Mace1H, ItemWeaponSubclass.Sword1H }
}

local SPECS_EXPECTED_TO_HAVE_OFFHAND = {
	[SPECS.DK_FROST] 				= true,
	[SPECS.DH_VENGEANCE]			= true,
	[SPECS.DH_HAVOC] 				= true,
	[SPECS.MONK_WW] 				= true,
	[SPECS.PALADIN_PROT] 			= true,
	[SPECS.ROGUE_ASS] 				= true,
	[SPECS.ROGUE_OUTLAW] 			= true,
	[SPECS.ROGUE_SUB] 				= true,
	[SPECS.SHAMAN_ENH] 				= true,
	[SPECS.WARRIOR_PROT] 			= true
}

-- Event listener frames
local eventHandlerFrame
local enableOrDisableEventFrame

-- Variables to control addon's status
local isEnabled = false
local priorCacheRefreshTime = 0
local showedVersionAlert = false

-- Variables to control inspection process
local inspectLoop = 0
local inspectIndex = 0						-- index of the character we're currently inspecting
local maxInspectIndex = 0  					-- the index of the last character in GetRaidRosterInfo()
local notifyInspectName = nil 				-- valued if we sent a request to inspect someone, nil otherwise

-- Display widgets
local lootedItemsFrame
local scrollFrame
local scrollbar
local contentFrame							-- content frame for dislaying looted items
local welcomeLabel

local radioButtons = {}						-- indexed by lootedItemID and requestorIndex
local labels = {}
local labelIndex = 0						-- index of the mos recently created label
local buttons = {}
local buttonIndex = 0						-- index of the most recently created button
local itemFrames = {}
local itemFrameIndex = 0					-- index of the most recently created item frame

local tooltipLong 							-- tooltip with the first 30 lines of the tooltip (for getting ilvl)

local plhUsers = {}							-- array of PLH users; keyed by name-realm of user, valued with version

local itemCache = {}						-- keeps track of items that we're waiting to be loaded into the cache so they can be processed
local playerItemCache = {}					-- contains FullItemInfos of the players' items

local groupInfoCache = {}  					-- array of items equipped by group members; keyed by name-realm of group member
	--[[									   structure is as follows, for each group member:
		groupInfoCache[name-realm][CLASS_NAME]			group member's class name from UnitClass(), in english
		groupInfoCache[name-realm][SPEC]				group member's spec from GetInspectSpecialization()
		groupInfoCache[name-realm][LEVEL]				group member's character level
		groupInfoCache[name-realm][FORCE_REFRESH]		boolean for whether to force a refresh of this member's data during next cache refresh
		groupInfoCache[name-realm][INVSLOT_HEAD]		item equipped in this slot
		groupInfoCache[name-realm][INVSLOT_NECK]		item equipped in this slot
		groupInfoCache[name-realm][INVSLOT_SHOULDER]	item equipped in this slot
		groupInfoCache[name-realm][INVSLOT_BACK]		item equipped in this slot
		groupInfoCache[name-realm][INVSLOT_CHEST]		item equipped in this slot
		groupInfoCache[name-realm][INVSLOT_WRIST]		item equipped in this slot
		groupInfoCache[name-realm][INVSLOT_HAND]		item equipped in this slot
		groupInfoCache[name-realm][INVSLOT_WAIST]		item equipped in this slot
		groupInfoCache[name-realm][INVSLOT_LEGS]		item equipped in this slot
		groupInfoCache[name-realm][INVSLOT_FEET]		item equipped in this slot
		groupInfoCache[name-realm][INVSLOT_FINGER1]		item equipped in this slot
		groupInfoCache[name-realm][INVSLOT_FINGER2]		item equipped in this slot
		groupInfoCache[name-realm][INVSLOT_TRINKET1]	item equipped in this slot
		groupInfoCache[name-realm][INVSLOT_TRINKET2]	item equipped in this slot
		groupInfoCache[name-realm][INVSLOT_MAINHAND]	item equipped in this slot
		groupInfoCache[name-realm][INVSLOT_OFFHAND]		item equipped in this slot
	]]--

local lootedItems = {}  					-- array of items looted by player; keyed by name-realm of looter
	--[[									   structure is as follows, for each looted item:
		lootedItems[lootedItemIndex][LOOTER_NAME] 				looter's full name (name-realm)
		lootedItems[lootedItemIndex][FULL_ITEM_INFO] 			full item info
		lootedItems[lootedItemIndex][STATUS] 					one of the STATUS_ options from below
		lootedItems[lootedItemIndex][SELECTED_REQUESTOR_INDEX]	which requestor has been selected via radio button
		lootedItems[lootedItemIndex][DEFAULT_REQUESTOR_INDEX]	which requestor is default if player hasn't clicked a radio button yet
		lootedItems[lootedItemIndex][CONFIRMATION_MESSAGE]		confirmation message to show after users hits OFFER TO GROUP or REQUEST
		lootedItems[lootedItemIndex][REQUESTORS][requestorIndex][REQUESTOR_NAME]			requestor's full name (name-realm)
		lootedItems[lootedItemIndex][REQUESTORS][requestorIndex][REQUESTOR_ROLL] 			1-100 roll result
		lootedItems[lootedItemIndex][REQUESTORS][requestorIndex][REQUESTOR_REQUEST_TYPE]	one of the REQUEST_TYPE_ options from below
		lootedItems[lootedItemIndex][REQUESTORS][requestorIndex][REQUESTOR_SORT_ORDER] 		order to be displayed

		lootedItems[STATUS] values are as follows:
			If you are the looter:
				STATUS_DEFAULT					default value for items you looted
				STATUS_HIDDEN 					you clicked OK (after OFFERing the item to someone) or KEEP
				STATUS_OFFERED 					you clicked OFFER TO SELECTED PLAYER to offer the item to the person identified by lootedItem[SELECTED_REQUESTOR_INDEX]
				STATUS_AVAILABLE 				you clicked OFFER TO GROUP to make the item available for requests
				STATUS_KEPT 					N/A
				STATUS_REQUESTED 				at least one person has requested this item
				STATUS_REQUESTED_VIA_WHISPER 	N/A
				
			If you are not the looter:
				STATUS_DEFAULT					default value for items looted by other players
				STATUS_HIDDEN 					you clicked OK (after the item was OFFERed or KEEPed) or PASS
				STATUS_OFFERED 					the looter clicked OFFER TO SELECTED PLAYER to offer the item to someone; if lootedItem[SELECTED_REQUESTOR_INDEX] == 1 then the winner is you!
				STATUS_AVAILABLE 				the looter clicked OFFER TO GROUP to make the item available for requests
				STATUS_KEPT 					the looter clicked KEEP
				STATUS_REQUESTED 				you clicked MS/OS/XMOG/SHARD to request this item from a looter who uses PLH
				STATUS_REQUESTED_VIA_WHISPER 	you clicked WHISPER to whisper the looter to request this item from a looter who does not use PLH
	]]--

--[[ UTILITY FUNCTIONS ]]--

local function GetItemPrimaryAttribute(item)
	local stats = C_Item.GetItemStats(item)
	if stats ~= nil then
		for stat, value in pairs(stats) do
			if _G[stat] == ITEM_MOD_STRENGTH_SHORT or _G[stat] == ITEM_MOD_INTELLECT_SHORT or _G[stat] == ITEM_MOD_AGILITY_SHORT then
				return _G[stat]
			end
		end
	end
	return nil
end

local function IsPlayer(characterName)
	return characterName == 'player'
		or characterName == PLH_GetFullName('player')
		or characterName == UnitName('player')
end

local function hasBonus(fullItemInfo)
	return fullItemInfo[FII_HAS_SOCKET]
		or fullItemInfo[FII_HAS_SPEED]
		or fullItemInfo[FII_HAS_LEECH]
		or fullItemInfo[FII_HAS_AVOIDANCE]
		or fullItemInfo[FII_HAS_INDESTRUCTIBLE]
end

local function GetILVLFromTooltip(tooltip)
	local ITEM_LEVEL_PATTERN				= _G.ITEM_LEVEL:gsub('%%d', '(%%d+)')  				-- Item Level (%d+)
	local ilvl = nil
	local text = tooltip.leftside[2]:GetText()
	if text ~= nil then
		ilvl = text:match(ITEM_LEVEL_PATTERN)
	end
	if ilvl == nil then  -- ilvl can be in the 2nd or 3rd line dependng on the tooltip; if we didn't find it in 2nd, try 3rd
		text = tooltip.leftside[3]:GetText()
		if text ~= nil then
			ilvl = text:match(ITEM_LEVEL_PATTERN)
		end
	end
	return ilvl
end

local function GetFullItemInfo(item)
	local ITEM_CLASSES_ALLOWED_PATTERN									= _G.ITEM_CLASSES_ALLOWED:gsub('%%s', '(.+)')		-- Classes: (.+)
	local BIND_TRADE_TIME_REMAINING_PATTERN 							= _G.BIND_TRADE_TIME_REMAINING:gsub('%%s', '(.+)')  -- You may trade this item with players that were also eligible to loot this item for the next (.+).
	local TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN_PATTERN 				= _G.TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN:gsub('%%s', '(.+)')			-- You haven't collected this appearance
	local TRANSMOGRIFY_TOOLTIP_ITEM_UNKNOWN_APPEARANCE_KNOWN_PATTERN 	= _G.TRANSMOGRIFY_TOOLTIP_ITEM_UNKNOWN_APPEARANCE_KNOWN:gsub('%%s', '(.+)')	-- You've collected this appearance, but not from this item
	local TOOLTIP_AZERITE_UNLOCK_LEVELS_PATTERN							= _G.TOOLTIP_AZERITE_UNLOCK_LEVELS:gsub('%(0/%%d%)', '%%(0/%%d%%)')  		-- Azerite Powers (0/%d):
	local CURRENTLY_SELECTED_AZERITE_POWERS_PATTERN						= _G.CURRENTLY_SELECTED_AZERITE_POWERS:gsub('%(%%d/%%d%)', '%%(%%d/%%d%%)')	-- Active Azerite Powers (%d/%d):
	local fullItemInfo = {}

	if item ~= nil then
		fullItemInfo[FII_ITEM] = item
		
		-- determine the basic values from the Blizzard GetItemInfo() API call
		_, _, fullItemInfo[FII_QUALITY], fullItemInfo[FII_BASE_ILVL], fullItemInfo[FII_REQUIRED_LEVEL], _, _, _, fullItemInfo[FII_ITEM_EQUIP_LOC], _, _, fullItemInfo[FII_CLASS], fullItemInfo[FII_SUB_CLASS], fullItemInfo[FII_BIND_TYPE], _, _, _ = GetItemInfo(item)

		-- determine whether the item is equippable
		fullItemInfo[FII_IS_EQUIPPABLE] = IsEquippableItem(item)

		if fullItemInfo[FII_IS_EQUIPPABLE] then

			-- set up the tooltip to determine values that aren't returned via GetItemInfo()
			tooltipLong = tooltipLong or CreateFrame("GameTooltip", "PLHScanTooltip", nil, "GameTooltipTemplate")
			tooltipLong:SetOwner(WorldFrame, "ANCHOR_NONE")
			tooltipLong:ClearLines()
			tooltipLong:SetHyperlink(item)
			tooltipLong.leftside = {}
			local i=1
			while _G["PLHScanTooltipTextLeft" .. i] do
				tooltipLong.leftside[i] = _G["PLHScanTooltipTextLeft" .. i]
				i = i + 1
			end

			-- determine the real iLVL
			local realILVL = GetILVLFromTooltip(tooltipLong)
			if realILVL == nil then  -- if we still couldn't find it (shouldn't happen), just use the base ilvl we got from GetItemInfo()
				realILVL = fullItemInfo[FII_BASE_ILVL]
			end
			fullItemInfo[FII_REAL_ILVL] = tonumber(realILVL)

			local classes = nil
			local hasBindTradeTimeWarning = nil
			local hasSocket = false
			local hasAvoidance = false
			local hasIndestructible = false
			local hasLeech = false
			local hasSpeed = false
			local xmoggable = false
			local isAzeriteItem = false
			local text

			local index = 6 -- the elements we're looking for are all further down in the tooltip
			while tooltipLong.leftside[index] do
				text = tooltipLong.leftside[index]:GetText()
				if text ~= nil then
					hasBindTradeTimeWarning = hasBindTradeTimeWarning or text:match(BIND_TRADE_TIME_REMAINING_PATTERN)
					classes = classes or text:match(ITEM_CLASSES_ALLOWED_PATTERN)
					hasSocket = hasSocket or text:find(_G.EMPTY_SOCKET_PRISMATIC) == 1
					hasAvoidance = hasAvoidance or text:find(_G.STAT_AVOIDANCE) ~= nil
					hasIndestructible = hasIndestructible or text:find(_G.STAT_STURDINESS) == 1
					hasLeech = hasLeech or text:find(_G.STAT_LIFESTEAL) ~= nil
					hasSpeed = hasSpeed or text:find(_G.STAT_SPEED) ~= nil
					xmoggable = xmoggable or text:find(TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN_PATTERN) ~= nil or text:find(TRANSMOGRIFY_TOOLTIP_ITEM_UNKNOWN_APPEARANCE_KNOWN_PATTERN) ~= nil
					isAzeriteItem = isAzeriteItem or text:match(TOOLTIP_AZERITE_UNLOCK_LEVELS_PATTERN) ~= nil or text:match(CURRENTLY_SELECTED_AZERITE_POWERS_PATTERN) ~= nil
				end
				index = index + 1
			end

			if classes ~= nil then
				classes = string.upper(classes)
				classes = string.gsub(classes, ' ', '')  -- remove space for DEMON HUNTER, DEATH KNIGHT
			end

--			if hasBindTradeTimeWarning then
--				print("SETTING FII_TRADE_TIME_WARNING_SHOWN TO TRUE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
--			end

			fullItemInfo[FII_CLASSES] = classes
			fullItemInfo[FII_TRADE_TIME_WARNING_SHOWN] = hasBindTradeTimeWarning
			fullItemInfo[FII_HAS_SOCKET] = hasSocket
			fullItemInfo[FII_HAS_AVOIDANCE] = hasAvoidance
			fullItemInfo[FII_HAS_INDESTRUCTIBLE] = hasIndestructible
			fullItemInfo[FII_HAS_LEECH] = hasLeech
			fullItemInfo[FII_HAS_SPEED] = hasSpeed
			fullItemInfo[FII_XMOGGABLE] = xmoggable
			fullItemInfo[FII_IS_AZERITE_ITEM] = isAzeriteItem
		end
	end

	return fullItemInfo
end

--[[ FUNCTIONS TO CHECK IF ITEM IS EQUIPPABLE ]]--

local function IsTrinketUsable(item, role)
	--[[
	local itemLink = select(2, GetItemInfo(item))
	local itemID = string.match(itemLink, 'item:(%d+):')

	local trinketList = PLH_GetTrinketList(role)

	if itemID ~= nil and trinketList ~= nil then
		return trinketList[tonumber(itemID)]
	else
		return false
	end
	]]--
	return true		-- trinkets are technically usable by any role; if a healer wants to use a dps trinket, a dps wants to use a tank trinket, or whatever, that's fine
end

-- Returns false if the character cannot use the item.
local function IsEquippableItemForCharacter(fullItemInfo, characterName)
	local characterClass
	local characterSpec
	local characterLevel
	if fullItemInfo ~= nil and characterName ~= nil and fullItemInfo[FII_IS_EQUIPPABLE] then
		if IsPlayer(characterName) then
			_, characterClass = UnitClass('player')
			characterSpec = GetSpecializationInfo(GetSpecialization())
			characterLevel = UnitLevel('player')
		elseif groupInfoCache[characterName] ~= nil then
			characterClass = groupInfoCache[characterName][CLASS_NAME]
			characterSpec = groupInfoCache[characterName][SPEC]
			characterLevel = groupInfoCache[characterName][LEVEL]
		else
			PLH_SendDebugMessage('Unable to determine class and spec in InEquippableItemForCharacter()!!!! for ' .. characterName)
			return true  -- should never reach here, but if we do it means we're not looking up the player or anyone in cache
		end

		if fullItemInfo[FII_REQUIRED_LEVEL] > characterLevel and not IsPlayer(characterName) then
			return false
		end
		
		if fullItemInfo[FII_CLASSES] ~= nil then	-- check whether to item is a class restricted item (ex: tier)
			if not string.find(characterClass, fullItemInfo[FII_CLASSES]) then
				return false
			end
		end
		
		if fullItemInfo[FII_ITEM_EQUIP_LOC] == 'INVTYPE_CLOAK' or fullItemInfo[FII_ITEM_EQUIP_LOC] == 'INVTYPE_FINGER' or fullItemInfo[FII_ITEM_EQUIP_LOC] == 'INVTYPE_NECK' then
			return true
		end

		if fullItemInfo[FII_ITEM_EQUIP_LOC] == 'INVTYPE_WEAPON' or
			fullItemInfo[FII_ITEM_EQUIP_LOC] == 'INVTYPE_SHIELD' or
			fullItemInfo[FII_ITEM_EQUIP_LOC] == 'INVTYPE_2HWEAPON' or
			fullItemInfo[FII_ITEM_EQUIP_LOC] == 'INVTYPE_WEAPONMAINHAND' or
			fullItemInfo[FII_ITEM_EQUIP_LOC] == 'INVTYPE_WEAPONOFFHAND' or
			fullItemInfo[FII_ITEM_EQUIP_LOC] == 'INVTYPE_HOLDABLE' or
			fullItemInfo[FII_ITEM_EQUIP_LOC] == 'INVTYPE_RANGED' or
			fullItemInfo[FII_ITEM_EQUIP_LOC] == 'INVTYPE_THROWN' or
			fullItemInfo[FII_ITEM_EQUIP_LOC] == 'INVTYPE_RANGEDRIGHT' or
			fullItemInfo[FII_ITEM_EQUIP_LOC] == 'INVTYPE_TRINKET' then
			
			local itemPrimaryAttribute = GetItemPrimaryAttribute(fullItemInfo[FII_ITEM])
			if itemPrimaryAttribute ~= nil then
				local isValidPrimaryAttribute = false
				for _, spec in pairs(SPEC_BY_CLASS[characterClass]) do
					if characterSpec == spec or not PLH_PREFS[PLH_PREFS_CURRENT_SPEC_ONLY] then
						if PRIMARY_ATTRIBUTE_BY_SPEC[spec] == itemPrimaryAttribute then
							isValidPrimaryAttribute = true
							break;
						end
					end
				end
				if not isValidPrimaryAttribute then
					return false
				end
			end
		end

		if fullItemInfo[FII_ITEM_EQUIP_LOC] == 'INVTYPE_TRINKET' then
			for _, spec in pairs(SPEC_BY_CLASS[characterClass]) do
				if characterSpec == spec or not PLH_PREFS[PLH_PREFS_CURRENT_SPEC_ONLY] then
					if IsTrinketUsable(fullItemInfo[FII_ITEM], ROLE_BY_SPEC[spec]) then
						return true
					end
				end
			end
			return IsTrinketUsable(fullItemInfo[FII_ITEM], PLH_ROLE_UNKNOWN) == true
		else
			local subClasses		
			for _, spec in pairs(SPEC_BY_CLASS[characterClass]) do
				if characterSpec == spec or not PLH_PREFS[PLH_PREFS_CURRENT_SPEC_ONLY] then
					if fullItemInfo[FII_CLASS] == ItemClass.Armor then
						subClasses = EQUIPPABLE_ARMOR_BY_SPEC[spec]
					else
						subClasses = EQUIPPABLE_WEAPON_BY_SPEC[spec]
					end
					for _, subClass in pairs(subClasses) do
						if subClass == fullItemInfo[FII_SUB_CLASS] then
							return true
						end
					end
				end
			end
		end
	end

	return false
end

--[[ FUNCTIONS TO CHECK IF ITEM IS AN UPGRADE ]]--

-- returns two variables:  true if the item is an upgrade over equippedItem (based on ilvl), equipped ilvl
local function IsAnUpgrade(itemILVL, equippedILVL, threshold)
	if equippedILVL == nil then  -- this means we couldn't find an equippedItem
		return false, 0
	else
		if threshold == nil then
			threshold = 1
		end
		return itemILVL > equippedILVL + threshold, equippedILVL
	end
end

-- Returns an appropriate SlotID for the given itemEquipLoc, or nil if it's not an item
--    if itemEquipLoc is a finger slot or trinket slot, we'll just return the first item
--    if itemEquipLoc is a weapon that can be in either slot (INVTYPE_WEAPON), we'll return the main hand
local function GetSlotID(itemEquipLoc)
	if itemEquipLoc == 'INVTYPE_HEAD' then return INVSLOT_HEAD
	elseif itemEquipLoc == 'INVTYPE_NECK' then return INVSLOT_NECK
	elseif itemEquipLoc == 'INVTYPE_SHOULDER' then return INVSLOT_SHOULDER
	elseif itemEquipLoc == 'BODY' then return INVSLOT_BODY
	elseif itemEquipLoc == 'INVTYPE_CHEST' then return INVSLOT_CHEST
	elseif itemEquipLoc == 'INVTYPE_ROBE' then return INVSLOT_CHEST
	elseif itemEquipLoc == 'INVTYPE_WAIST' then return INVSLOT_WAIST
	elseif itemEquipLoc == 'INVTYPE_LEGS' then return INVSLOT_LEGS
	elseif itemEquipLoc == 'INVTYPE_FEET' then return INVSLOT_FEET
	elseif itemEquipLoc == 'INVTYPE_WRIST' then return INVSLOT_WRIST
	elseif itemEquipLoc == 'INVTYPE_HAND' then return INVSLOT_HAND
	elseif itemEquipLoc == 'INVTYPE_FINGER' then return INVSLOT_FINGER1
	elseif itemEquipLoc == 'INVTYPE_TRINKET' then return INVSLOT_TRINKET1
	elseif itemEquipLoc == 'INVTYPE_CLOAK' then return INVSLOT_BACK
	elseif itemEquipLoc == 'INVTYPE_WEAPON' then return INVSLOT_MAINHAND
	elseif itemEquipLoc == 'INVTYPE_SHIELD' then return INVSLOT_OFFHAND
	elseif itemEquipLoc == 'INVTYPE_2HWEAPON' then return INVSLOT_MAINHAND
	elseif itemEquipLoc == 'INVTYPE_WEAPONMAINHAND' then return INVSLOT_MAINHAND
	elseif itemEquipLoc == 'INVTYPE_WEAPONOFFHAND' then return INVSLOT_OFFHAND
	elseif itemEquipLoc == 'INVTYPE_HOLDABLE' then return INVSLOT_OFFHAND
	elseif itemEquipLoc == 'INVTYPE_RANGED' then return INVSLOT_MAINHAND
	elseif itemEquipLoc == 'INVTYPE_THROWN' then return INVSLOT_MAINHAND
	elseif itemEquipLoc == 'INVTYPE_RANGEDRIGHT' then return INVSLOT_MAINHAND
	elseif itemEquipLoc == 'INVTYPE_TABARD' then return INVSLOT_TABARD
	else return nil
	end
end

-- Returns the FULL_ITEM_INFO that character has equipped in slotID
local function GetEquippedItem(characterName, slotID)
	local item = nil
	if IsPlayer(characterName) then
		item = playerItemCache[slotID]
-- 		item = GetInventoryItemLink('player', slotID)
--		if item ~= nil then
--			item = GetFullItemInfo(item)
--		end
	else
		local characterDetails = groupInfoCache[characterName]
		if characterDetails ~= nil then
			item = GetFullItemInfo(characterDetails[slotID])
		end
	end
	return item
end

local function LoadPlayerItems()
	PLH_SendDebugMessage("Loading Player Items")

	local item
	for slotID = 1, 17 do
		item = GetInventoryItemLink('player', slotID)
		if item ~= nil then
			playerItemCache[slotID] = GetFullItemInfo(item)
		else
			playerItemCache[slotID] = nil
		end
	end
end

-- returns two variables:  true if the item is an upgrade over equippedItem (based on ilvl), equipped ilvl
-- note: doesn't check if item is equippable, so make sure you do that check beforehand
-- both parameter:  if true, return true for rings/trinkets only if it's an upgrade for both slots
local function IsAnUpgradeForCharacter(fullItemInfo, characterName, threshold, both)
	local itemEquipLoc = fullItemInfo[FII_ITEM_EQUIP_LOC]
	local itemRealILVL = fullItemInfo[FII_REAL_ILVL]

	local equippedItem1 = nil
	local isAnUpgrade1 = false
	local equippedILVL1 = 0
	local equippedItem2 = nil
	local isAnUpgrade2 = false
	local equippedILVL2 = 0
	local slotID

	if itemEquipLoc ~= nil and itemEquipLoc ~= '' then
		if itemEquipLoc == 'INVTYPE_FINGER' then
			equippedItem1 = GetEquippedItem(characterName, INVSLOT_FINGER1)
			equippedItem2 = GetEquippedItem(characterName, INVSLOT_FINGER2)
		elseif itemEquipLoc == 'INVTYPE_TRINKET' then
			equippedItem1 = GetEquippedItem(characterName, INVSLOT_TRINKET1)
			equippedItem2 = GetEquippedItem(characterName, INVSLOT_TRINKET2)
		elseif itemEquipLoc == 'INVTYPE_WEAPON' then
			equippedItem1 = GetEquippedItem(characterName, INVSLOT_MAINHAND)
			equippedItem2 = GetEquippedItem(characterName, INVSLOT_OFFHAND)
			if equippedItem2 ~= nil and equippedItem2[FII_ITEM_EQUIP_LOC] == 'INVTYPE_SHIELD' then
				equippedItem2 = nil		-- ignore this slot if we have a shield equipped in offhand
			end
		else
			slotID = GetSlotID(itemEquipLoc)
			equippedItem1 = GetEquippedItem(characterName, slotID)
		end
		if equippedItem1 ~= nil then
			if equippedItem2 ~= nil then
				isAnUpgrade1, equippedILVL1 = IsAnUpgrade(itemRealILVL, equippedItem1[FII_REAL_ILVL], threshold)
				isAnUpgrade2, equippedILVL2 = IsAnUpgrade(itemRealILVL, equippedItem2[FII_REAL_ILVL], threshold)
				if both then
					isAnUpgrade1 = isAnUpgrade1 and isAnUpgrade2
				else
					isAnUpgrade1 = isAnUpgrade1 or isAnUpgrade2
				end
				equippedILVL1 = min(equippedILVL1, equippedILVL2)
			else
				isAnUpgrade1, equippedILVL1 = IsAnUpgrade(itemRealILVL, equippedItem1[FII_REAL_ILVL], threshold)
			end
		end
	end

	return isAnUpgrade1, equippedILVL1
end

-- returns two variables:  first is true or false, second is array of people for whom the item may is an upgrade (by ilvl)
local function IsAnUpgradeForAnyCharacter(fullItemInfo)
	local isAnUpgrade, equippedILVL
	local isAnUpgradeForAnyCharacterNames = {}

	local index = 1
	local characterName
	while GetRaidRosterInfo(index) ~= nil do
		characterName = PLH_GetFullName(select(1, GetRaidRosterInfo(index)))
		if IsEquippableItemForCharacter(fullItemInfo, characterName) then
			isAnUpgrade, equippedILVL = IsAnUpgradeForCharacter(fullItemInfo, characterName, 0)
			if isAnUpgrade then
				isAnUpgradeForAnyCharacterNames[#isAnUpgradeForAnyCharacterNames + 1] = Ambiguate(characterName, 'short') .. ' (' .. equippedILVL .. ')'
			end
		end
		index = index + 1
	end
	return #isAnUpgradeForAnyCharacterNames > 0, isAnUpgradeForAnyCharacterNames
end

--[[ FUNCTIONS FOR PLHUSERS ]]

function PLH_GetNumberOfPLHUsers()
	local count = 0
	for _ in pairs(plhUsers) do
		count = count + 1
	end
	return count
end

local function IsPLHUser(characterName)
	if plhUsers[characterName] ~= nil then
		return true
	else
		return false
	end
end

--[[ FUNCTIONS FOR DISPLAYING THE LOOTED ITEMS WINDOW ]]--

local function IsEnchanting(profession)
	if profession ~= nil then
		return select(7, GetProfessionInfo(profession)) == 333
	else
		return false
	end
end

local function IsEnchanter()
	local profession1, profession2 = GetProfessions()
	return IsEnchanting(profession1) or IsEnchanting(profession2)
end

--[[
local function CanBeXMogged(itemEquipLoc)
	return itemEquipLoc == 'INVTYPE_HEAD'
		or itemEquipLoc == 'INVTYPE_SHOULDER'
		or itemEquipLoc == 'INVTYPE_CLOAK'
		or itemEquipLoc == 'INVTYPE_CHEST'
		or itemEquipLoc == 'INVTYPE_ROBE'
		or itemEquipLoc == 'INVTYPE_WAIST'
		or itemEquipLoc == 'INVTYPE_LEGS'
		or itemEquipLoc == 'INVTYPE_FEET'
		or itemEquipLoc == 'INVTYPE_WRIST'
		or itemEquipLoc == 'INVTYPE_HAND'
		or itemEquipLoc == 'INVTYPE_WEAPON'
		or itemEquipLoc == 'INVTYPE_SHIELD'
		or itemEquipLoc == 'INVTYPE_2HWEAPON'
		or itemEquipLoc == 'INVTYPE_WEAPONMAINHAND'
		or itemEquipLoc == 'INVTYPE_WEAPONOFFHAND'
		or itemEquipLoc == 'INVTYPE_HOLDABLE'
		or itemEquipLoc == 'INVTYPE_RANGED'
		or itemEquipLoc == 'INVTYPE_THROWN'
		or itemEquipLoc == 'INVTYPE_RANGEDRIGHT'
end
]]--

-- This is a bit of a hack.  The user could still mouseover widgets that weren't within the visible area of
-- lootedItemsFrame, so lets only show the buttons/tooltips if the widget is really visible
local function IsWidgetVisible(widget, tolerance)
	if widget == nil then
		return false
	else
		if tolerance == nil then
			tolerance = 0
		end
		local widgetTop = widget:GetTop()
		local lootedItemFramesBottom = lootedItemsFrame:GetBottom()
		local widgetBottom = widget:GetBottom()
		local lootedItemFramesTop = lootedItemsFrame:GetTop()
		if widgetTop ~= nil and lootedItemFramesBottom ~= nil and widgetBottom ~= nil and lootedItemFramesTop ~= nil then
			return widgetTop > lootedItemFramesBottom + tolerance and widgetBottom < lootedItemFramesTop + tolerance
		else
			return false
		end
	end
end

-- Hides buttons and itemFrames outside the visibile area of contentFrame so they don't steal focus when moused over
local function HideOffScreenWidgets()
	if contentFrame ~= nil then
		for i = 1, buttonIndex do
			if IsWidgetVisible(buttons[i], 0) then
				buttons[i]:Show()
			else
				buttons[i]:Hide()
			end
		end	

		for i = 1, itemFrameIndex do
			if IsWidgetVisible(itemFrames[i], 0) then
				itemFrames[i]:Show()
			else
				itemFrames[i]:Hide()
			end
		end	
		
		for lootedItemIndex, requestors in pairs(radioButtons) do
			for requestorIndex, radioButton in pairs(requestors) do
				if IsWidgetVisible(radioButton, 0) and lootedItems[lootedItemIndex][STATUS] == STATUS_REQUESTED then
					radioButton:Show()
				else
					radioButton:Hide()
				end
			end
		end
	end
end

local function ClearLootedItemsDisplay()
	if welcomeLabel ~= nil and welcomeLabel:IsVisible() then
		scrollbar:SetValue(0)  -- in general we don't want to reset the scrollbar position, except when and item notification comes in while user is viewing welcome message
	end
	
	local kids = { contentFrame:GetRegions() };
	for _, child in ipairs(kids) do
		child:Hide()
	end	

	local kids = { contentFrame:GetChildren() };
	for _, child in ipairs(kids) do
		child:Hide()
	end	
end

local function GetILVLDifferenceString(lootedItem, characterName)
	local text = ''
	local isAnUpgrade, equippedILVL = IsAnUpgradeForCharacter(lootedItem[FULL_ITEM_INFO], characterName, 0)
	if equippedILVL ~= 0 and lootedItem[FULL_ITEM_INFO][FII_REAL_ILVL] ~= 0 then
		local ilvlDifference = lootedItem[FULL_ITEM_INFO][FII_REAL_ILVL] - equippedILVL
		if ilvlDifference >= 0 then
			text = COLOR_HIGHER_ILVL .. " +" .. ilvlDifference .. _G.FONT_COLOR_CODE_CLOSE
		else
			text = COLOR_LOWER_ILVL .. " " .. ilvlDifference .. _G.FONT_COLOR_CODE_CLOSE
		end
	end
	return text
end

local function ShouldShowLootedItem(lootedItem)
	local lootedItemStatus = lootedItem[STATUS]
	local isPlayer = IsPlayer(lootedItem[LOOTER_NAME])

	return (lootedItemStatus == STATUS_OFFERED)
		or (lootedItemStatus == STATUS_DEFAULT and isPlayer)
		or (lootedItemStatus == STATUS_REQUESTED and isPlayer)
		or (lootedItemStatus == STATUS_KEPT and not isPlayer)
		or (lootedItemStatus == STATUS_AVAILABLE and not isPlayer)
		or (lootedItemStatus == STATUS_AVAILABLE and isPlayer and lootedItem[CONFIRMATION_MESSAGE] ~= nil)
		or (lootedItemStatus == STATUS_REQUESTED and not isPlayer and lootedItem[CONFIRMATION_MESSAGE] ~= nil)
end

local function ShouldShowLootedItemsDisplay()
	for lootedItemIndex = 1, #lootedItems do
		if ShouldShowLootedItem(lootedItems[lootedItemIndex]) then
			return true
		end
	end
end

-- returns true if requestType is higher priority than priorRequestType
local function IsRequestTypeHigherPriority(requestType, priorRequestType)
	return (requestType == REQUEST_TYPE_MAIN_SPEC and (priorRequestType == REQUEST_TYPE_OFF_SPEC or priorRequestType == REQUEST_TYPE_XMOG or priorRequestType == REQUEST_TYPE_SHARD))
		or (requestType == REQUEST_TYPE_OFF_SPEC and (priorRequestType == REQUEST_TYPE_XMOG or priorRequestType == REQUEST_TYPE_SHARD))
		or (requestType == REQUEST_TYPE_XMOG and (priorRequestType == REQUEST_TYPE_SHARD))
end		

-- MS > OS > XMOG > SHARD, then by roll
local function SetRequestorSortOrder(requestors)
	local priorRequestType
	local priorRoll
	
	local requestType
	local roll

	local requestor
	local nextRequestorIndex = 0
	local sortOrder = 1

	for i = 1, #requestors do
		requestor = requestors[i]
		requestor[REQUESTOR_SORT_ORDER] = ''
	end
	
	for i = 1, #requestors do
		for j = 1, #requestors do
			requestor = requestors[j]
		
			if requestor[REQUESTOR_SORT_ORDER] == '' then
				requestType = requestor[REQUESTOR_REQUEST_TYPE]
				roll = requestor[REQUESTOR_ROLL]
		
				if (nextRequestorIndex == 0)
					or (IsRequestTypeHigherPriority(requestType, priorRequestType))
					or (not IsRequestTypeHigherPriority(priorRequestType, requestType) and roll > priorRoll) then
					
					nextRequestorIndex = j
					priorRequestType = requestType
					priorRoll = roll
				end
			end
		end

		requestors[nextRequestorIndex][REQUESTOR_SORT_ORDER] = sortOrder
		sortOrder = sortOrder + 1
		nextRequestorIndex = 0
	end
end

-- Returns a frame to display around the itemLabel, allowing users to see tooltips by hovering their mouse over the itemLabel
-- Creates a new Frame or reuses one from the itemFrames array if one is available.
-- Create item frames this way vs. creating a new Frame for each to save on memory utilization
local function CreateItemFrame(itemLabel, item, anchor)
	itemFrameIndex = itemFrameIndex + 1
	
	if itemFrames[itemFrameIndex] == nil then
		itemFrames[itemFrameIndex] = CreateFrame('Frame', nil, contentFrame)
		itemFrames[itemFrameIndex]:SetScript('OnLeave', function(self)
			self:SetScript('OnEvent', nil)
			self:UnregisterAllEvents()
			GameTooltip:Hide()
		end)
	else
		itemFrames[itemFrameIndex]:ClearAllPoints()
		itemFrames[itemFrameIndex]:SetScript('OnEnter', nil)
		itemFrames[itemFrameIndex]:SetScript('OnEvent', nil)
		itemFrames[itemFrameIndex]:UnregisterAllEvents()
		itemFrames[itemFrameIndex]:Show()
	end
	
	itemFrames[itemFrameIndex]:SetSize(itemLabel:GetWidth(), itemLabel:GetHeight())
	itemFrames[itemFrameIndex]:SetPoint('TOPLEFT', anchor, 'TOPRIGHT')
	itemFrames[itemFrameIndex]:SetScript('OnEnter', function(self)
		if IsWidgetVisible(self, 11) then
			GameTooltip:SetOwner(self, 'ANCHOR_CURSOR')
			GameTooltip:SetHyperlink(item)
			GameTooltip:Show()

			self:SetScript('OnEvent', function(self, event, arg, ...)
				if self:IsShown() and event == 'MODIFIER_STATE_CHANGED' and (arg == 'LSHIFT' or arg == 'RSHIFT') then
					GameTooltip:SetOwner(self, 'ANCHOR_CURSOR')
					GameTooltip:SetHyperlink(item)
					GameTooltip:Show()
				end
			end)
			self:RegisterEvent('MODIFIER_STATE_CHANGED')
		end
	end)
end

-- Returns a label to display by either creating a new FontString or reusing one from the labels array if one is available.
-- Create labels this way vs. creating a new FontString for each to save on memory utilization
local function CreateLabel(text, color, anchor, relativePoint, xOffset, yOffset)
	labelIndex = labelIndex + 1

	if labels[labelIndex] == nil then
		labels[labelIndex] = contentFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
		labels[labelIndex]:SetJustifyH('LEFT')
	else
		labels[labelIndex]:ClearAllPoints()
		labels[labelIndex]:Show()
	end

	if color ~= nil then
		text = color .. text .. _G.FONT_COLOR_CODE_CLOSE
	end
		
	labels[labelIndex]:SetText(text)
	labels[labelIndex]:SetPoint('TOPLEFT', anchor, relativePoint, xOffset, yOffset)

	return labels[labelIndex]
end

-- Returns a button to display by either creating a new button or reusing one from the buttons array if one is available.
-- Extra parameters are passed to the OnClickFunction
-- Create buttons this way vs. creating a new frame for each to save on memory utilization
local function CreateButton(text, width, xOffset, yOffset, onClickFunction, ...)
	buttonIndex = buttonIndex + 1

	if buttons[buttonIndex] == nil then
		buttons[buttonIndex] = CreateFrame('Button', nil, contentFrame, 'UIPanelButtonTemplate')
		buttons[buttonIndex]:SetNormalFontObject('GameFontNormalSmall')
	else
		buttons[buttonIndex]:ClearAllPoints()
		buttons[buttonIndex]:SetScript('OnClick', nil)
		buttons[buttonIndex]:SetScript('OnEnter', nil)
		buttons[buttonIndex]:Show()
	end

	buttons[buttonIndex]:SetSize(width, 15)
	buttons[buttonIndex]:SetText(COLOR_BUTTON_TEXT .. text .. _G.FONT_COLOR_CODE_CLOSE)
	buttons[buttonIndex]:SetPoint('TOPLEFT', contentFrame, 'TOPLEFT', xOffset, yOffset)

	if onClickFunction ~= nil then
		local param1, param2 = ...
		buttons[buttonIndex]:SetScript('OnClick', function(self, event, ...)
			onClickFunction(param1, param2)
		end)
	end
	
	return buttons[buttonIndex]
end
	
-- updates the display of looted items
local function UpdateLootedItemsDisplay()
	local lootedItem
	local lootedItemStatus
	local requestor

	local verticalOffset = -5
	local VERTICAL_SPACING = -15
	local INDENT = 15
	
	local text
	local color
	
	labelIndex = 0
	buttonIndex = 0
	itemFrameIndex = 0

	ClearLootedItemsDisplay()

	if ShouldShowLootedItemsDisplay() then

		for lootedItemIndex = 1, #lootedItems do
			lootedItem = lootedItems[lootedItemIndex]
			if ShouldShowLootedItem(lootedItem) then
				lootedItemStatus = lootedItem[STATUS]

				--[[ ITEM ]] --

				-- Looter Label
				
				if IsPlayer(lootedItem[LOOTER_NAME]) then
					color = COLOR_PLAYER_LOOTED_ITEM
					if lootedItemStatus == STATUS_REQUESTED or lootedItemStatus == STATUS_OFFERED or lootedItem[CONFIRMATION_MESSAGE] ~= nil then
						text = "You offered to trade " --.. lootedItem[FULL_ITEM_INFO][FII_ITEM]
					else
						text = "You may trade " --.. lootedItem[FULL_ITEM_INFO][FII_ITEM]
					end
				else
					color = COLOR_NON_PLAYER_LOOTED_ITEM
					if IsPLHUser(lootedItem[LOOTER_NAME]) then
						text = Ambiguate(lootedItem[LOOTER_NAME], 'all') .. " offered to trade " --.. lootedItem[FULL_ITEM_INFO][FII_ITEM]
					else
						text = Ambiguate(lootedItem[LOOTER_NAME], 'all') .. " may trade " --.. lootedItem[FULL_ITEM_INFO][FII_ITEM]
					end
				end
				CreateLabel(text, color, contentFrame, 'TOPLEFT', 0, verticalOffset)
				
				-- BoE Label
				
				if lootedItem[FULL_ITEM_INFO][FII_BIND_TYPE] == Enum.ItemBind.OnEquip then
					CreateLabel("BoE ", COLOR_BOE, labels[labelIndex], 'TOPRIGHT')
				end

				-- Item Label

				CreateLabel(lootedItem[FULL_ITEM_INFO][FII_ITEM], nil, labels[labelIndex], 'TOPRIGHT')
				CreateItemFrame(labels[labelIndex], lootedItems[lootedItemIndex][FULL_ITEM_INFO][FII_ITEM], labels[labelIndex - 1])
				
				-- Info Label - ilvl and tertiary stats

				text = ''
				if not IsPlayer(lootedItem[LOOTER_NAME]) then
					text = text .. GetILVLDifferenceString(lootedItem, PLH_GetFullName('player'))
				end
				if hasBonus(lootedItem[FULL_ITEM_INFO]) then
					text = text .. COLOR_HIGHER_ILVL
					if lootedItem[FULL_ITEM_INFO][FII_HAS_SOCKET] then
						text = text .. " Gem"
					end
					if lootedItem[FULL_ITEM_INFO][FII_HAS_SPEED] then
						text = text .. ' ' .. _G.STAT_SPEED
					end
					if lootedItem[FULL_ITEM_INFO][FII_HAS_LEECH] then
						text = text .. ' ' .. _G.STAT_LIFESTEAL
					end
					if lootedItem[FULL_ITEM_INFO][FII_HAS_AVOIDANCE] then
						text = text .. ' ' .. _G.STAT_AVOIDANCE
					end
					if lootedItem[FULL_ITEM_INFO][FII_HAS_INDESTRUCTIBLE] then
						text = text .. ' ' .. _G.STAT_STURDINESS
					end
				end
				if not IsPlayer(lootedItem[LOOTER_NAME]) and lootedItem[FULL_ITEM_INFO][FII_XMOGGABLE] then
					text = text .. ' XMOG'
				end

				if text ~= '' then
					text = text .. _G.FONT_COLOR_CODE_CLOSE
					CreateLabel(text, nil, labels[labelIndex], 'TOPRIGHT')
				end
				
				verticalOffset = verticalOffset + VERTICAL_SPACING

				--[[ ITEM STATUS ]] --

				text = ''
				if lootedItemStatus == STATUS_KEPT  then
					text = "Item is no longer available - it was kept or traded by the looter"
				elseif lootedItemStatus == STATUS_OFFERED then
					if IsPlayer(lootedItem[LOOTER_NAME]) then
						local selectedIndex = lootedItem[SELECTED_REQUESTOR_INDEX]
						local offeredName = lootedItem[REQUESTORS][selectedIndex][REQUESTOR_NAME]
						text = "Offered to " .. Ambiguate(offeredName, 'all') .. "!  *** OPEN TRADE TO GIVE ITEM AWAY ***"
					elseif lootedItem[SELECTED_REQUESTOR_INDEX] == 1 then
						text = Ambiguate(lootedItem[LOOTER_NAME], 'all') .. " offered this item to you!  *** OPEN TRADE TO RECEIVE ITEM ***"
					else
						text = "Item is no longer available - it was kept or traded by the looter"
					end
				elseif lootedItem[CONFIRMATION_MESSAGE] ~= nil then
					text = lootedItem[CONFIRMATION_MESSAGE]
--				elseif lootedItemStatus == STATUS_REQUESTED then
--					text = "You requested this item"
--				elseif lootedItemStatus == STATUS_REQUESTED_VIA_WHISPER then
--					text = "You whispered " .. Ambiguate(lootedItem[LOOTER_NAME], 'all') .. " to request this item"
				end

				if text ~= '' then
					CreateLabel(text, color, contentFrame, 'TOPLEFT', INDENT, verticalOffset)
					verticalOffset = verticalOffset + VERTICAL_SPACING
					if lootedItem[CONFIRMATION_MESSAGE] ~= nil then
						verticalOffset = verticalOffset + (VERTICAL_SPACING / 2)  -- confirmation messages are 2 lines long, so add an extra line
					end
				end
				
				--[[ REQUESTORS ]]--

				if IsPlayer(lootedItem[LOOTER_NAME]) and lootedItemStatus == STATUS_REQUESTED then
					radioButtons[lootedItemIndex] = {}
					SetRequestorSortOrder(lootedItem[REQUESTORS])
					for sortOrder = 1, #lootedItem[REQUESTORS] do
						for requestorIndex = 1, #lootedItem[REQUESTORS] do
							requestor = lootedItem[REQUESTORS][requestorIndex]
							if requestor[REQUESTOR_SORT_ORDER] == sortOrder then
								text = Ambiguate(requestor[REQUESTOR_NAME], 'all') .. " rolled " .. requestor[REQUESTOR_ROLL] .. " for " .. requestor[REQUESTOR_REQUEST_TYPE]
								if requestor[REQUESTOR_REQUEST_TYPE] == REQUEST_TYPE_MAIN_SPEC or requestor[REQUESTOR_REQUEST_TYPE] == REQUEST_TYPE_OFF_SPEC then
									text = text .. GetILVLDifferenceString(lootedItem, requestor[REQUESTOR_NAME])
								end
								CreateLabel(text, COLOR_PLAYER_LOOTED_ITEM, contentFrame, 'TOPLEFT', INDENT + 15, verticalOffset)
								
								radioButtons[lootedItemIndex][requestorIndex] = CreateFrame('CheckButton', nil, contentFrame, 'UIRadioButtonTemplate', requestorIndex)
								radioButtons[lootedItemIndex][requestorIndex]:SetHeight(15)
								radioButtons[lootedItemIndex][requestorIndex]:SetWidth(15)
								radioButtons[lootedItemIndex][requestorIndex]:ClearAllPoints()
								radioButtons[lootedItemIndex][requestorIndex]:SetPoint('TOPLEFT', contentFrame, 'TOPLEFT', INDENT, verticalOffset)
								if sortOrder == 1 and lootedItem[SELECTED_REQUESTOR_INDEX] == '' then
									lootedItem[DEFAULT_REQUESTOR_INDEX] = requestorIndex
									radioButtons[lootedItemIndex][requestorIndex]:SetChecked(true)
								elseif lootedItem[SELECTED_REQUESTOR_INDEX] == requestorIndex then
									radioButtons[lootedItemIndex][requestorIndex]:SetChecked(true)
								end
								radioButtons[lootedItemIndex][requestorIndex]:SetScript('OnClick', function ( self )
									for radioIndex = 1, #radioButtons[lootedItemIndex] do
										if radioIndex == self:GetID() then
											radioButtons[lootedItemIndex][radioIndex]:SetChecked(true)
										else
											radioButtons[lootedItemIndex][radioIndex]:SetChecked(false)
										end
									end
									lootedItems[lootedItemIndex][SELECTED_REQUESTOR_INDEX] = requestorIndex
								end)

								verticalOffset = verticalOffset + VERTICAL_SPACING
							end
						end
					end
				end
				
				--[[ BUTTONS ]]--

				if IsPlayer(lootedItem[LOOTER_NAME]) then
					if lootedItem[CONFIRMATION_MESSAGE] ~= nil then
						CreateButton("OK", 50, INDENT, verticalOffset, PLH_DoClearConfirmationMessage, lootedItemIndex)
					elseif lootedItemStatus == STATUS_OFFERED then
						CreateButton("OK", 50, INDENT, verticalOffset, PLH_DoHideItem, lootedItemIndex)
					else
						CreateButton("KEEP", 50, INDENT, verticalOffset, PLH_DoKeepItem, lootedItemIndex)
					end

					if lootedItemStatus == STATUS_DEFAULT then
						CreateButton("OFFER TO GROUP", 120, INDENT + 65, verticalOffset, PLH_DoTradeItem, lootedItemIndex)
					elseif lootedItemStatus == STATUS_REQUESTED then
						CreateButton("OFFER TO SELECTED PLAYER", 180, INDENT + 65, verticalOffset, PLH_DoOfferItem, lootedItemIndex)
					end
				else
					if lootedItem[CONFIRMATION_MESSAGE] ~= nil then
						CreateButton("OK", 50, INDENT, verticalOffset, PLH_DoClearConfirmationMessage, lootedItemIndex)
					elseif lootedItemStatus ~= STATUS_AVAILABLE then
						CreateButton("OK", 50, INDENT, verticalOffset, PLH_DoHideItem, lootedItemIndex)
					else
						CreateButton("PASS", 50, INDENT, verticalOffset, PLH_DoHideItem, lootedItemIndex)

						if IsPLHUser(lootedItem[LOOTER_NAME]) then
--							if IsAnUpgradeForCharacter(lootedItem[FULL_ITEM_INFO], PLH_GetFullName('player'), PLH_PREFS[PLH_PREFS_ILVL_THRESHOLD]) then
								CreateButton("MS", 50, INDENT + 65, verticalOffset, PLH_DoRequestItem, lootedItemIndex, REQUEST_TYPE_MAIN_SPEC)
								CreateButton("OS", 50, INDENT + 115, verticalOffset, PLH_DoRequestItem, lootedItemIndex, REQUEST_TYPE_OFF_SPEC)
--							end
							if lootedItem[FULL_ITEM_INFO][FII_XMOGGABLE] then
								CreateButton("XMOG", 50, INDENT + 165, verticalOffset, PLH_DoRequestItem, lootedItemIndex, REQUEST_TYPE_XMOG)
							end
							--if IsEnchanter() then
							--	CreateButton("SHARD", 50, INDENT + 215, verticalOffset, PLH_DoRequestItem, lootedItemIndex, REQUEST_TYPE_SHARD)
							--end
						else
							local button = CreateButton("WHISPER", 80, INDENT + 65, verticalOffset)
							button:SetScript('OnClick', function(self)
								if PLH_PREFS[PLH_PREFS_WHISPER_MESSAGE] == nil or PLH_PREFS[PLH_PREFS_WHISPER_MESSAGE] == '' then
									PLH_SendUserMessage("You must configure a personalized whisper message in PLH options [/plh] to whisper requests for loot.")
								else
									PLH_DoWhisper(lootedItemIndex)
								end
							end)
							button:SetScript('OnEnter', function(self)
								if IsWidgetVisible(self, 0) then
									if PLH_META[PLH_SHOW_WHISPER_WARNING] == nil or PLH_META[PLH_SHOW_WHISPER_WARNING] then
										local warning = "Whisper message will be: \"" .. PLH_GetWhisperMessage(lootedItems[lootedItemIndex][FULL_ITEM_INFO][FII_ITEM]) .. "\"\nYou can change this message by entering \"/plh\""
										PLH_SendUserMessage(warning)
										PLH_META[PLH_SHOW_WHISPER_WARNING] = false
									end
								end
							end)
						end
					end				
				end		

				verticalOffset = verticalOffset + (VERTICAL_SPACING * 2)
			end
		end

		if math.abs(verticalOffset) > lootedItemsFrame:GetHeight() then
			scrollbar:Show()
		else
			scrollbar:Hide()
		end

		HideOffScreenWidgets()

		lootedItemsFrame:Show()
	else
		lootedItemsFrame:Hide()
	end
end

-- modified from Recount
local function SaveMainWindowPosition()
	local xOfs, yOfs = lootedItemsFrame:GetCenter()
	local s = lootedItemsFrame:GetEffectiveScale()
	local uis = UIParent:GetScale()
	xOfs = xOfs * s - GetScreenWidth() * uis / 2
	yOfs = yOfs * s - GetScreenHeight() * uis / 2

	PLH_META[PLH_LOOTED_ITEMS_FRAME_X] = xOfs / uis
	PLH_META[PLH_LOOTED_ITEMS_FRAME_Y] = yOfs / uis
	PLH_META[PLH_LOOTED_ITEMS_FRAME_WIDTH] = lootedItemsFrame:GetWidth()
	PLH_META[PLH_LOOTED_ITEMS_FRAME_HEIGHT] = lootedItemsFrame:GetHeight()
end

-- modified from Recount
local function RestoreMainWindowPosition()
	local x = PLH_META[PLH_LOOTED_ITEMS_FRAME_X]
	local y = PLH_META[PLH_LOOTED_ITEMS_FRAME_Y]
	local width = PLH_META[PLH_LOOTED_ITEMS_FRAME_WIDTH]
	local height = PLH_META[PLH_LOOTED_ITEMS_FRAME_HEIGHT]

	local s = lootedItemsFrame:GetEffectiveScale()
	local uis = UIParent:GetScale()
	lootedItemsFrame:SetPoint("CENTER", UIParent, "CENTER", x * uis / s, y * uis / s)
	lootedItemsFrame:SetWidth(width)
	lootedItemsFrame:SetHeight(height)
end

local function CreateLootedItemsDisplay()
	--parent frame 
	lootedItemsFrame = CreateFrame('Frame', 'PLH_LootedItemsFrame', UIParent, 'InsetFrameTemplate3') 
	lootedItemsFrame:SetMovable(true)
	lootedItemsFrame:EnableMouse(true)
	lootedItemsFrame:EnableMouseWheel(true)
	lootedItemsFrame:RegisterForDrag('LeftButton')
	lootedItemsFrame:SetScript('OnDragStart', lootedItemsFrame.StartMoving)
	lootedItemsFrame:SetScript('OnDragStop', function(self)
		lootedItemsFrame:StopMovingOrSizing()
		SaveMainWindowPosition()
	end)
	lootedItemsFrame:SetResizable(true)
	lootedItemsFrame:SetResizeBounds(100, 50, 600, 300)

	if lootedItemsFrame:GetHeight() == nil or lootedItemsFrame:GetHeight() == 0 then  	-- first try repositioning/resizing from layout-local.txt
		if PLH_META[PLH_LOOTED_ITEMS_FRAME_X] ~= nil then								-- if we didn't have anything there (ex: after addon was disabled and renabled), try saved variables
			RestoreMainWindowPosition()
			lootedItemsFrame:SetUserPlaced(true)
		else																			-- if we still couldn't find saved info, just use defaults
			lootedItemsFrame:SetSize(400, 140) 
			lootedItemsFrame:SetPoint('CENTER', UIParent, 'CENTER') 
		end
	end
	
	lootedItemsFrame:SetScript('OnMouseWheel', function(self, delta)
		local cur_val = scrollbar:GetValue()
		local min_val, max_val = scrollbar:GetMinMaxValues()

		if delta < 0 and cur_val < max_val then
			cur_val = math.min(max_val, cur_val + 10)
			scrollbar:SetValue(cur_val)
		elseif delta > 0 and cur_val > min_val then
			cur_val = math.max(min_val, cur_val - 10)
			scrollbar:SetValue(cur_val)
		end
	end)

	lootedItemsFrame:SetScript('OnSizeChanged', function(self, width, height)
		HideOffScreenWidgets()
	end)
	
	--scrollFrame 
	scrollFrame = CreateFrame('ScrollFrame', nil, lootedItemsFrame) 
	scrollFrame:SetPoint('TOPLEFT', 10, -5) 
	scrollFrame:SetPoint('BOTTOMRIGHT', -10, 5)
	scrollFrame:SetScript("OnVerticalScroll", function(self, offset)
		HideOffScreenWidgets()
	end)
	scrollFrame:SetScript("OnShow", function(self)
		HideOffScreenWidgets()
	end)
	lootedItemsFrame.scrollframe = scrollFrame 

	--scrollbar 
	scrollbar = CreateFrame('Slider', nil, scrollFrame, 'UIPanelScrollBarTemplate')
	scrollbar:SetPoint('TOPLEFT', lootedItemsFrame, 'TOPRIGHT', -19, -38) 
	scrollbar:SetPoint('BOTTOMLEFT', lootedItemsFrame, 'BOTTOMRIGHT', -19, 34)
	scrollbar:SetMinMaxValues(1, 300) 
	scrollbar:SetValueStep(1) 
	scrollbar.scrollStep = 10 
	scrollbar:SetValue(0) 
	scrollbar:SetWidth(16) 
	scrollbar:SetScript('OnValueChanged', function (self, value) 
		self:GetParent():SetVerticalScroll(value) 
	end) 
	lootedItemsFrame.scrollbar = scrollbar 
	scrollbar:Hide()

	--content frame 
	contentFrame = CreateFrame('Frame', nil, scrollFrame) 
	contentFrame:SetSize(lootedItemsFrame:GetWidth(), lootedItemsFrame:GetHeight()) 
	scrollFrame.content = contentFrame
	scrollFrame:SetScrollChild(contentFrame)

	-- Close button
	local closeButton = CreateFrame('Button', nil, lootedItemsFrame, 'UIPanelCloseButton')
	closeButton:SetPoint('TOPRIGHT', 2, 0)
	closeButton:SetHeight(25)
	closeButton:SetWidth(25)
	closeButton:SetScript('OnClick', function(self)
		scrollbar:SetValue(0)
		HideParentPanel(self)
	end)
	lootedItemsFrame.closeButton = closeButton
	
	-- Resize button
	local resizeButton = CreateFrame('Button', nil, lootedItemsFrame)
	resizeButton:SetSize(16, 16)
	resizeButton:SetPoint('BOTTOMRIGHT')
	resizeButton:SetNormalTexture('Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up')
	resizeButton:SetHighlightTexture('Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight')
	resizeButton:SetPushedTexture('Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down')
	resizeButton:SetScript('OnMouseDown', function(self, button)
		lootedItemsFrame:StartSizing('BOTTOMRIGHT')
		lootedItemsFrame:SetUserPlaced(true)
	end)
	resizeButton:SetScript('OnMouseUp', function(self, button)
		lootedItemsFrame:StopMovingOrSizing()
		SaveMainWindowPosition()
		if welcomeLabel == nil or not welcomeLabel:IsVisible() then
			UpdateLootedItemsDisplay()		-- called so scrollbar can be shown/hidden as appropriate
			lootedItemsFrame:Show()			-- in case it was hidden by UpdateLootedItemsDisplay()
		end
	end)

	lootedItemsFrame:Hide()
	
	--[[ Welcome message
	if PLH_META[PLH_LAST_SEEN_MESSAGE_VERSION] and tonumber(PLH_META[PLH_LAST_SEEN_MESSAGE_VERSION]) and tonumber(PLH_META[PLH_LAST_SEEN_MESSAGE_VERSION]) < 2.0 then
		local welcomeText = "Welcome to Personal Loot Helper (PLH) 2.0!!\n\n" ..
			"This window will show tradeable loot!\n\n" ..
			"Move by dragging with left mouse button.\n" ..
			"Resize with icon in lower right-hand corner.\n" ..
			"Scroll with middle mouse button.\n\n" ..
			"When tradeable loot drops, window will automatically appear.\n" ..
			"Looters can KEEP or OFFER items. " ..
			"Other players can PASS or request for MAIN SPEC (MS), OFF SPEC (OS), or XMOG\n\n" ..
			"If looter is not using PLH, you can WHISPER them. Configure whisper message on options screen.\n\n" ..
			"Type \"/plh\" to view options screen."
		welcomeLabel = contentFrame:CreateFontString('PLHWelcomeLabel', 'ARTWORK', 'GameFontNormalSmall')
		welcomeLabel:SetPoint('TOPLEFT', contentFrame, 'TOPLEFT', 0, -5)
		welcomeLabel:SetWordWrap(true)
		welcomeLabel:SetJustifyH('LEFT')
		welcomeLabel:SetWidth(330)
		welcomeLabel:SetSpacing(2)
		welcomeLabel:SetText(welcomeText)
		scrollbar:Show()
		lootedItemsFrame:Show()
		PLH_META[PLH_LAST_SEEN_MESSAGE_VERSION] = "v2.38"
	elseif PLH_META[PLH_LAST_SEEN_MESSAGE_VERSION] and not tonumber(PLH_META[PLH_LAST_SEEN_MESSAGE_VERSION]) then
		PLH_META[PLH_LAST_SEEN_MESSAGE_VERSION] = 'v2.38'
	end]]

end

--[[ FUNCTIONS FOR SEARCHING AND MODIFYING LOOTEDITEMS ARRAY ]]

-- Returns the item ID of the lootedItem
local function GetLootedItemID(lootedItem)
	local lootedItemID = -1
	local lootedItemLink = lootedItem[FULL_ITEM_INFO][FII_ITEM]
	if lootedItemLink ~= nil then
		lootedItemID = string.match(lootedItemLink, 'item:(%d+):')
	end
	return lootedItemID
end

-- Returns index of the lootedItem within lootedItems array for the given name and itemID
local function FindLootedItemIndex(name, itemID)
	local lootedItem
	local lootedItemID

	itemID = '' .. itemID  -- convert to a String
	
	for i = 1, #lootedItems do
		lootedItem = lootedItems[i]
		lootedItemID = GetLootedItemID(lootedItem)
		if lootedItem[STATUS] ~= STATUS_HIDDEN and lootedItem[LOOTER_NAME] == name and lootedItemID == itemID then
			return i
		end
	end
	
	return nil
end

local function GetLootedItem(looterName, lootedItemID)
	local lootedItemIndex = FindLootedItemIndex(looterName, lootedItemID)
	if lootedItemIndex ~= nil then
		local lootedItem = lootedItems[lootedItemIndex]
		if lootedItem[STATUS] ~= STATUS_HIDDEN then
			return lootedItem
		end
	end
	PLH_SendDebugMessage('   No matching item found.')
	return nil
end

-- Adds the item to the lootedItems array; returns the index of the newly added item
local function AddLootedItem(fullItemInfo, characterName, status)
	local lootedItemIndex = #lootedItems + 1

	lootedItems[lootedItemIndex] = {}
	lootedItems[lootedItemIndex][LOOTER_NAME] = characterName
	lootedItems[lootedItemIndex][FULL_ITEM_INFO] = fullItemInfo
	lootedItems[lootedItemIndex][SELECTED_REQUESTOR_INDEX] = ''
	lootedItems[lootedItemIndex][DEFAULT_REQUESTOR_INDEX] = ''
	lootedItems[lootedItemIndex][REQUESTORS] = {}
	
	if status == nil then
		if IsPlayer(characterName) or IsPLHUser(characterName) then
			lootedItems[lootedItemIndex][STATUS] = STATUS_DEFAULT
		else
			lootedItems[lootedItemIndex][STATUS] = STATUS_AVAILABLE
		end

		if IsPlayer(characterName) then
			PlaySound(600)  -- 'GLUECREATECHARACTERBUTTON'
		else
			PlaySound(888)  -- 'LEVELUP'
		end
	else
		lootedItems[lootedItemIndex][STATUS] = status
	end
	
	return lootedItemIndex
end

local function ShouldAnnounceTrades()
	return PLH_PREFS[PLH_PREFS_ANNOUNCE_TRADES] and InGuildParty() and UnitIsGroupLeader('player')
end

local function shouldAddLootedItem(fullItemInfo)
	return IsEquippableItemForCharacter(fullItemInfo, PLH_GetFullName('player')) and
		((PLH_PREFS[PLH_PREFS_INCLUDE_XMOG] and fullItemInfo[FII_XMOGGABLE]) or IsAnUpgradeForCharacter(fullItemInfo, PLH_GetFullName('player'), PLH_PREFS[PLH_PREFS_ILVL_THRESHOLD]))
end

--[[ FUNCTIONS FOR SENDING ADDON MESSAGES TO OTHER PLAYERS ]]

local function CreateAddonTextString(process, lootedItem, options)
	local lootedItemID = GetLootedItemID(lootedItem)
	local looterName = lootedItem[LOOTER_NAME]
	
	local addonTextString = 
		process ..
		'~' ..
		lootedItemID ..
		'~' ..
		looterName
		
	if options ~= nil then
		addonTextString = addonTextString .. '~' .. options
	end
	
	return addonTextString
end

local function PLH_SendAddonMessage(addonTextString, characterName)
-- per documentation at https://wow.gamepedia.com/API_SendAddonMessage, whispers don't work cross-realm, so we'll have to broadcast requests to everyone
--	if characterName == nil then
		PLH_SendDebugMessage('Sending AddonMessage: ' .. addonTextString)
--	else
--		PLH_SendDebugMessage('Sending AddonMessage: ' .. addonTextString .. ' to ' .. characterName)
--	end

	if IsInGroup() then
--		if characterName ~= nil then
--			C_ChatInfo.SendAddonMessage('2UI', addonTextString, 'WHISPER', Ambiguate(characterName, 'mail'))
		if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() then
			C_ChatInfo.SendAddonMessage('2UI', addonTextString, 'INSTANCE_CHAT')
		elseif IsInRaid() then
			C_ChatInfo.SendAddonMessage('2UI', addonTextString, 'RAID')  -- TODO per DBM sendSync() comments this may be going away in 8.x?  Test in beta
		else
			C_ChatInfo.SendAddonMessage('2UI', addonTextString, 'PARTY')
		end
	else
		C_ChatInfo.SendAddonMessage('2UI', addonTextString, 'WHISPER', PLH_GetFullName('player'))  -- for testing purpose
	end
end

--[[ FUNCTIONS FIRED WHEN MESSAGE IS RECEIVED FROM OTHER PLAYERS ]]

function PLH_ProcessKeepItemMessage(looterName, lootedItemID)
--	PLH_SendDebugMessage('Entering PLH_ProcessKeepItemMessage (' .. looterName .. ', ' .. lootedItemID .. ')')

	if not IsPlayer(looterName) then
		local lootedItem = GetLootedItem(looterName, lootedItemID)
		if lootedItem ~= nil then
			lootedItem[CONFIRMATION_MESSAGE] = nil
			if lootedItem[STATUS] == STATUS_REQUESTED or lootedItem[STATUS] == STATUS_AVAILABLE then
				lootedItem[STATUS] = STATUS_KEPT
				UpdateLootedItemsDisplay()
			else
				lootedItem[STATUS] = STATUS_HIDDEN
			end
		end
	end
end

-- Event handler for GET_ITEM_INFO_RECEIVED event
local function GetItemInfoReceivedEvent(self, event, ...)
	for item, looterName in pairs(itemCache) do
		if GetItemInfo(item) then
			itemCache[item] = nil
			PLH_ProcessTradeItemMessage(looterName, item)
		end
	end
end

function PLH_ProcessTradeItemMessage(looterName, item)
--	PLH_SendDebugMessage('Entering PLH_ProcessTradeItemMessage (' .. looterName .. ', ' .. item .. ')')
	if not IsPlayer(looterName) then
		if GetItemInfo(item) == nil then
			-- we need to wait for the item to be loaded into the cache
			itemCache[item] = looterName
		else
			local fullItemInfo = GetFullItemInfo(item)
			if shouldAddLootedItem(fullItemInfo) then
				local lootedItemIndex = AddLootedItem(fullItemInfo, looterName)
				lootedItems[lootedItemIndex][STATUS] = STATUS_AVAILABLE
				UpdateLootedItemsDisplay()
			elseif ShouldAnnounceTrades() then
				AddLootedItem(fullItemInfo, looterName, STATUS_HIDDEN)
			end
		end
	end
end

function PLH_ProcessOfferItemMessage(looterName, lootedItemID, requestorName)
--	PLH_SendDebugMessage('Entering PLH_ProcessOfferItemMessage (' .. looterName .. ', ' .. lootedItemID .. ', ' .. requestorName .. ')')
	
	local lootedItem = GetLootedItem(looterName, lootedItemID)

	if not IsPlayer(looterName) then
		if lootedItem ~= nil then
			lootedItem[CONFIRMATION_MESSAGE] = nil
			if IsPlayer(requestorName) then
				lootedItem[SELECTED_REQUESTOR_INDEX] = 1
				PLH_STATS[PLH_ITEMS_RECEIVED] = PLH_STATS[PLH_ITEMS_RECEIVED] + 1
			end
			if lootedItem[STATUS] == STATUS_REQUESTED or lootedItem[STATUS] == STATUS_AVAILABLE then
				lootedItem[STATUS] = STATUS_OFFERED
				UpdateLootedItemsDisplay()
			else
				lootedItem[STATUS] = STATUS_HIDDEN
			end
		end
	end
	
	if lootedItem ~= nil and ShouldAnnounceTrades() then
		PLH_SendBroadcast(looterName .. ' offered ' .. lootedItem[FULL_ITEM_INFO][FII_ITEM] .. ' to ' .. requestorName, false)
	end
	
end

local function FindRequestorIndex(lootedItem, requestorName)
	local requestors = lootedItem[REQUESTORS]
	local requestor
	
	for i = 1, #requestors do
		requestor = requestors[i]
		if requestor[REQUESTOR_NAME] == requestorName then
			return i
		end
	end
	
	return nil
end

function PLH_ProcessRequestItemMessage(looterName, lootedItemID, requestorName, requestType)
--	PLH_SendDebugMessage('Entering PLH_ProcessRequestItemMessage (' .. looterName .. ', ' .. lootedItemID .. ', ' .. requestorName .. ', ' .. requestType .. ')')

	if IsPlayer(looterName) then
		local lootedItem = GetLootedItem(looterName, lootedItemID)
		if lootedItem ~= nil then
			if lootedItem[STATUS] == STATUS_AVAILABLE or lootedItem[STATUS] == STATUS_REQUESTED then
				local requestorIndex = FindRequestorIndex(lootedItem, requestorName)
				if requestorIndex == nil then
					lootedItem[STATUS] = STATUS_REQUESTED
					lootedItem[CONFIRMATION_MESSAGE] = nil
					
					requestorIndex = #lootedItem[REQUESTORS] + 1
					lootedItem[REQUESTORS][requestorIndex] = {}
					requestor = lootedItem[REQUESTORS][requestorIndex]
					requestor[REQUESTOR_NAME] = requestorName
					requestor[REQUESTOR_ROLL] = math.random(1, 100)
					requestor[REQUESTOR_REQUEST_TYPE] = requestType
					requestor[REQUESTOR_SORT_ORDER] = ''
					
					UpdateLootedItemsDisplay()
				else
					PLH_SendDebugMessage('Request already received for ' .. requestorName .. '; ignoring new request')
				end
			end
		end
	end
end

local function PLH_ProcessVersionMessage(plhUser, version)
--	PLH_SendDebugMessage('Entering PLH_ProcessVersionMessage (' .. plhUser .. ', ' .. version .. ')')

	if plhUsers[plhUser] == nil or plhUsers[plhUser] ~= version then
		plhUsers[plhUser] = version
		if ShouldShowLootedItemsDisplay() then
			UpdateLootedItemsDisplay()
		end
		if version > 'v2.38' and not showedVersionAlert then
			PLH_SendUserMessage("Your version of Personal Loot Helper is out-of-date. You can download version " .. version .. " from the Twitch app or by searching for PLH on curseforge.com")
			showedVersionAlert = true
		end
	end
end

local function PLH_ProcessIdentifyUsersMessage()
--	PLH_SendDebugMessage('Entering PLH_ProcessIdentifyUsersMessage()')

	PLH_SendAddonMessage('VERSION~ ~' .. PLH_GetFullName('player') .. '~' .. 'v2.38')
end	

-- Event handler for CHAT_MSG_ADDON event
local function AddonMessageReceivedEvent(self, event, ...)
	local prefix, message, _, sender = ...

	if prefix == '2UI' then
	
		sender = PLH_GetFullName(sender)
		
		PLH_SendDebugMessage('Received AddonMessage: ' .. message .. ' from ' .. sender)
		
		local process, lootedItemID, looterName, optional = message:match('(.+)~(.+)~(.+)~(.+)')
		if optional == nil then
			process, lootedItemID, looterName = message:match('(.+)~(.+)~(.+)')
		end
		looterName = PLH_GetFullName(looterName)

		if process == "KEEP" then
			PLH_ProcessKeepItemMessage(sender, lootedItemID)
		elseif process == "TRADE" then
			PLH_ProcessTradeItemMessage(sender, optional)
		elseif process == "OFFER" then
			PLH_ProcessOfferItemMessage(sender, lootedItemID, optional)
		elseif process == "REQUEST" then
			PLH_ProcessRequestItemMessage(looterName, lootedItemID, sender, optional)
		elseif process == 'VERSION' then
			PLH_ProcessVersionMessage(sender, optional)
		elseif process == 'IDENTIFY_USERS' then
			PLH_ProcessIdentifyUsersMessage()
		end
	end
end	

--[[ FUNCTIONS FIRED WHEN USER CLICKS BUTTON ON THE SCREEN ]]

-- called when the player clicks 'ok' for an item
function PLH_DoHideItem(lootedItemIndex)
	local lootedItem = lootedItems[lootedItemIndex]
	lootedItem[STATUS] = STATUS_HIDDEN
	UpdateLootedItemsDisplay()
end

-- called when the player clicks 'keep' for an item
function PLH_DoKeepItem(lootedItemIndex)
	local lootedItem = lootedItems[lootedItemIndex]

	if lootedItem[STATUS] ~= STATUS_DEFAULT then
		local addonTextString = CreateAddonTextString("KEEP", lootedItem)
		PLH_SendAddonMessage(addonTextString)
	end

	lootedItem[STATUS] = STATUS_HIDDEN
	UpdateLootedItemsDisplay()
end

function PLH_DoClearConfirmationMessage(lootedItemIndex)
	local lootedItem = lootedItems[lootedItemIndex]
	lootedItem[CONFIRMATION_MESSAGE] = nil
	UpdateLootedItemsDisplay()
end

-- called when the player clicks 'offer to group' to put an item up for trade
function PLH_DoTradeItem(lootedItemIndex)
	local lootedItem = lootedItems[lootedItemIndex]
	lootedItem[STATUS] = STATUS_AVAILABLE
	if not PLH_PREFS[PLH_PREFS_SKIP_CONFIRMATION] then
		lootedItem[CONFIRMATION_MESSAGE] = "Thank you! Other PLH users are being told this item is\navailable. If anyone requests the item, PLH will notify you."
	end
	UpdateLootedItemsDisplay()
	PLH_STATS[PLH_ITEMS_OFFERED] = PLH_STATS[PLH_ITEMS_OFFERED] + 1

	local addonTextString = CreateAddonTextString("TRADE", lootedItem, lootedItem[FULL_ITEM_INFO][FII_ITEM])
	PLH_SendAddonMessage(addonTextString)
end

-- called when the player clicks 'offer' to give an item to a specific player
function PLH_DoOfferItem(lootedItemIndex)
	local lootedItem = lootedItems[lootedItemIndex]
	if lootedItem[SELECTED_REQUESTOR_INDEX] == '' then
		lootedItem[SELECTED_REQUESTOR_INDEX] = lootedItem[DEFAULT_REQUESTOR_INDEX]
	end
	local requestorIndex = lootedItem[SELECTED_REQUESTOR_INDEX]
	local requestor = lootedItem[REQUESTORS][requestorIndex]
	lootedItem[STATUS] = STATUS_OFFERED
	UpdateLootedItemsDisplay()
	PLH_STATS[PLH_ITEMS_GIVEN_AWAY] = PLH_STATS[PLH_ITEMS_GIVEN_AWAY] + 1

	local addonTextString = CreateAddonTextString("OFFER", lootedItem, requestor[REQUESTOR_NAME])
	PLH_SendAddonMessage(addonTextString)
end

-- called when the player clicks to request an item that has been looted by another player
function PLH_DoRequestItem(lootedItemIndex, requestType)
	local lootedItem = lootedItems[lootedItemIndex]
	lootedItem[STATUS] = STATUS_REQUESTED
	if not PLH_PREFS[PLH_PREFS_SKIP_CONFIRMATION] then
		lootedItem[CONFIRMATION_MESSAGE] = "Your request is being sent to " .. Ambiguate(lootedItem[LOOTER_NAME], 'all') .. ".\nPLH will notify you when they make their decision."
	end
	UpdateLootedItemsDisplay()
	PLH_STATS[PLH_ITEMS_REQUESTED] = PLH_STATS[PLH_ITEMS_REQUESTED] + 1

	local addonTextString = CreateAddonTextString("REQUEST", lootedItem, requestType)
	PLH_SendAddonMessage(addonTextString, lootedItem[LOOTER_NAME])
end

function PLH_DoWhisper(lootedItemIndex)
	local lootedItem = lootedItems[lootedItemIndex]
	lootedItem[STATUS] = STATUS_REQUESTED_VIA_WHISPER
	UpdateLootedItemsDisplay()

	SendChatMessage(PLH_GetWhisperMessage(lootedItem[FULL_ITEM_INFO][FII_ITEM]), 'WHISPER', nil, Ambiguate(lootedItem[LOOTER_NAME], 'mail'))
end

--[[ FUNCTIONS FOR TAKING ACTION WHEN ITEMS ARE LOOTED ]]--

-- returns true if the item should be evaluated for potential trades based on the following criteria:
--   1. item is equippable
--   2. quality is rare or epic
--   3. item is BoP, or user specified to include BoE items in preferences
--   4. item does not have azerite armor slots
local function ShouldBeEvaluated(fullItemInfo)
	return fullItemInfo[FII_IS_EQUIPPABLE]
		and (fullItemInfo[FII_QUALITY] == Enum.ItemQuality.Rare or fullItemInfo[FII_QUALITY] == Enum.ItemQuality.Epic)
		and (fullItemInfo[FII_BIND_TYPE] == Enum.ItemBind.OnAcquire or (fullItemInfo[FII_BIND_TYPE] == Enum.ItemBind.OnEquip and not PLH_PREFS[PLH_PREFS_NEVER_OFFER_BOE]))
--		and (not fullItemInfo[FII_IS_AZERITE_ITEM])
end		

-- creates a copy of the table
local function ShallowCopy(t)
	local t2 = {}
	for k, v in pairs(t) do
		t2[k] = v
	end
	return t2
end

-- returns the names from the given array, with 'and others' if array size > limit
local function GetNames(namelist, limit)
	local names = ''
	if namelist ~= nil then
		if limit == nil then  -- no limit; show all names
			limit = #namelist
		end
		if namelist[1] ~= nil then
			-- sort the array by ilvl first
			local sortedNamelist = namelist
			if #namelist > 1 then
				local copiedNamelist = ShallowCopy(namelist)  -- we will destroy elements in the list while sorting, so copy it
				sortedNamelist = {}
				local lowestILVL
				local lowestIndex
				local ilvl
				local i = 1
				local size = #copiedNamelist
				while i <= size do
					lowestILVL = 1000000
					lowestIndex = 1  -- we could be sorting a list without ilvls, in which case just keep the same order
					for j = 1, #copiedNamelist do
						if copiedNamelist[j] ~= nil then
							ilvl = string.match(copiedNamelist[j], '(%d+)')
							if ilvl ~= nil then
								ilvl = tonumber(ilvl)
								if ilvl < lowestILVL then
									lowestILVL = ilvl
									lowestIndex = j
								end
							end
						end
					end
					table.insert(sortedNamelist, table.remove(copiedNamelist, lowestIndex))
					i = i + 1
				end
			end
		
			names = sortedNamelist[1]
			local maxnames = min(#sortedNamelist, limit)
			for i = 2, maxnames do
				if #sortedNamelist == 2 then
					names = names .. ' '
				else
					names = names .. ', '
				end
				if i == #sortedNamelist then -- last person
					names = names .. 'and '
				end
				names = names .. sortedNamelist[i]
			end
			if #sortedNamelist > limit then
				names = names .. ', and others'
			end
		end
	end
	return names
end

-- Checks whether or not the loot items should be added to the lootedItems array; adds item if it meets the criteria
local function PerformNotify(fullItemInfo, looterName)
	if ShouldBeEvaluated(fullItemInfo) then
		if IsPlayer(looterName) then
--			local isTradeable = fullItemInfo[FII_TRADE_TIME_WARNING_SHOWN] or not IsAnUpgradeForCharacter(fullItemInfo, looterName)
			local isTradeable = not IsAnUpgradeForCharacter(fullItemInfo, looterName, 0, true)
			if isTradeable then

				local isAnUpgradeForAnyCharacter, isAnUpgradeForAnyCharacterNames = IsAnUpgradeForAnyCharacter(fullItemInfo)

				if PLH_GetNumberOfPLHUsers() > 1 then
					if not PLH_PREFS[PLH_PREFS_ONLY_OFFER_IF_UPGRADE] or isAnUpgradeForAnyCharacter then
						AddLootedItem(fullItemInfo, looterName)
						UpdateLootedItemsDisplay()
					end
				end
				if PLH_PREFS[PLH_PREFS_SHOW_TRADEABLE_ALERT] then
					if isAnUpgradeForAnyCharacter then
						local names = GetNames(isAnUpgradeForAnyCharacterNames, 5)
						PLH_SendAlert('You can trade ' .. fullItemInfo[FII_ITEM] .. ', which is an ilvl upgrade for ' .. names)
						PlaySound(600)  -- 'GLUECREATECHARACTERBUTTON'
					end
				end			
			end
		elseif not IsPLHUser(looterName) and fullItemInfo[FII_BIND_TYPE] ~= Enum.ItemBind.OnEquip and not IsAnUpgradeForCharacter(fullItemInfo, looterName, 0, true) then
			if shouldAddLootedItem(fullItemInfo) then
				AddLootedItem(fullItemInfo, looterName)
				UpdateLootedItemsDisplay()
			elseif ShouldAnnounceTrades() then
				AddLootedItem(fullItemInfo, looterName, STATUS_HIDDEN)
			end
		end
	end
end

-- Event handler for CHAT_MSG_LOOT event
local function LootReceivedEvent(self, event, ...)
	PLH_SendDebugMessage('LootReceivedEvent')
	local LOOT_ITEM_SELF_PATTERN 			= _G.LOOT_ITEM_SELF:gsub('%%s', '(.+)')				-- You receive loot: (.+)
	local LOOT_ITEM_PATTERN					= _G.LOOT_ITEM:gsub('%%s', '(.+)')					-- (.+) receives loot: (.+)
--[[
	if event == 'SHOW_LOOT_TOAST' then
		local typeIdentifier, itemLink, quantity, specID, sex, personalLootToast, ITEM_TOAST_METHOD_LOOT, lessAwesome, upgraded = ...
		print('received SHOW_LOOT_TOAST event')
		print(typeIdentifier)
		print(itemLink)
		print(quantity)
		print(specID)
		print(sex)
		print(personalLootToast)
		print(ITEM_TOAST_METHOD_LOOT)
		print(lessAwesome)
		print(upgraded)
		return
	end
]]--	
--[[	
	sample from an epic that dropped during CoS run:
		event is SHOW_LOOT_TOAST
		item
		[item]
		1
		0
		2
		false
		3
		false
		true (item had socket)
		
	{ Name = "typeIdentifier", Type = "string", Nilable = false },
	{ Name = "itemLink", Type = "string", Nilable = false },
	{ Name = "quantity", Type = "number", Nilable = false },
	{ Name = "specID", Type = "number", Nilable = false },
	{ Name = "sex", Type = "number", Nilable = false },
	{ Name = "personalLootToast", Type = "bool", Nilable = false },
	{ Name = "ITEM_TOAST_METHOD_LOOT", Type = "number", Nilable = false },
	{ Name = "lessAwesome", Type = "bool", Nilable = false },
	{ Name = "upgraded", Type = "bool", Nilable = false },
]]--
	
	local message, _, _, _, looter = ...
	local lootedItem = message:match(LOOT_ITEM_SELF_PATTERN)
	if lootedItem == nil then
		_, lootedItem = message:match(LOOT_ITEM_PATTERN)
	end

	if lootedItem then
		PLH_SendDebugMessage('Looted Item: ' .. lootedItem)
		local fullItemInfo = GetFullItemInfo(lootedItem)
		PerformNotify(fullItemInfo, PLH_GetFullName(looter))
	end
end	

--[[ FUNCTIONS FOR POPULATING GROUPINFOCACHE ]]

local function GetExpectedItemCount(spec)
	if SPECS_EXPECTED_TO_HAVE_OFFHAND[spec] then
		return 16
	else
		return 15
	end
end

-- only returns count of equippable items from cache; excludes other cached info such as ClassName/Spec/Level
local function GetItemCountFromCache(name)
	local itemCount = 0
	if name ~= nil and groupInfoCache[name] ~= nil then
		for slotID, item in pairs(groupInfoCache[name]) do
			itemCount = itemCount + 1
		end
		itemCount = itemCount - 4 -- subtract 4 since everyone has CLASS_NAME, SPEC, LEVEL, and FORCE_REFRESH elements
	end
	return itemCount
end

-- The following uses GetInventoryItemLink() to look up unit's equipped items.
-- That method can only be called within the scope of an INSPECT_READY event.
local function UpdateGroupInfoCache(unit)
	local name = PLH_GetFullName(unit)
	
	PLH_SendDebugMessage('      Entering UpdateGroupInfoCache() for ' .. name)
	
	if name ~= nil then
		local characterDetails
		if groupInfoCache[name] == nil then
			characterDetails = {}
			local _, class = UnitClass(unit)
			characterDetails[CLASS_NAME] = class
			local spec = GetInspectSpecialization(unit)
			characterDetails[SPEC] = spec
			local level = UnitLevel(unit)
			characterDetails[LEVEL] = level
			characterDetails[FORCE_REFRESH] = false
		else
			characterDetails = groupInfoCache[name]
		end

		local updatedItemCount = 0
		local item
		for invslot = _G.INVSLOT_FIRST_EQUIPPED, _G.INVSLOT_LAST_EQUIPPED do
			if invslot ~= _G.INVSLOT_BODY and invslot ~= INVSLOT_TABARD then -- ignore shirt and tabard slots
				if unit ~= nil then
					item = GetInventoryItemLink(UnitName(unit), invslot)
					if item ~= nil and GetItemInfo(item) ~= nil then
						if characterDetails[invslot] == nil or characterDetails[invslot] ~= item then
							updatedItemCount = updatedItemCount + 1
	--						characterDetails[invslot] = GetFullItemInfo(item)
							characterDetails[invslot] = item
						end
					end
				end
			end
		end

		if updatedItemCount > 0 or groupInfoCache[name] == nil then
			groupInfoCache[name] = characterDetails
		end
		
		if groupInfoCache[name][FORCE_REFRESH] == true then
			groupInfoCache[name][FORCE_REFRESH] = false
		end
		
		PLH_SendDebugMessage('         Updated ' .. updatedItemCount .. ' items for ' .. name)
	end
end

-- returns true if the characterName is in the raid/party
local function IsCharacterInGroup(characterName)
	local index = 1
	local name = select(1, GetRaidRosterInfo(index))
	while name ~= nil do
		if name == characterName or PLH_GetFullName(name) == characterName then
			return true
		end
		index = index + 1
		name = select(1, GetRaidRosterInfo(index))
	end
	return false
end

-- Event handler for the INSPECT_READY event.  These events can be triggered by something other than PLH.
--   We make sure we're only processing the events that PLH triggered by comparing against notifyInspectName.
--   This is particularly important since we're calling ClearInspectPlayer(); if we tried doing that for an event
--   triggered by something other than PLH, we would cancel their event! (ex: resulting in a blank inspection screen in UI)
local function InspectReadyEvent(self, event, ...)
	local guid = select(1, ...)
	local name = select(6, GetPlayerInfoByGUID(guid))
	
	PLH_SendDebugMessage('   Entering InspectReadyEvent() for ' .. name)

	if notifyInspectName ~= nil and (notifyInspectName == name or notifyInspectName == PLH_GetFullName(name)) then
		UpdateGroupInfoCache(name)
		if not InspectFrame or not InspectFrame:IsShown() then
			ClearInspectPlayer()
		end
		notifyInspectName = nil
		
		if PLH_PreemptWait(PLH_WAIT_FOR_INSPECT) then
			PLH_wait(PLH_WAIT_FOR_INSPECT, DELAY_BETWEEN_INSPECTIONS_SHORT, PLH_InspectNextGroupMember)
		end
	end
end

-- Attempt to queue a group member for inspection.  Returns true if we were able to queue an inspection, false otherwise
local function InspectGroupMember(characterName)
	if characterName ~= nil and not IsPlayer(characterName) then   -- no need to inspect ourselves
		if CanInspect(characterName) and (not InspectFrame or not InspectFrame:IsShown()) then
			PLH_SendDebugMessage('Calling NotifyInspect for ' .. characterName .. ' (' .. inspectLoop .. ',' .. inspectIndex .. ')')
			notifyInspectName = characterName
			NotifyInspect(characterName)
			PLH_wait(PLH_WAIT_FOR_INSPECT, DELAY_BETWEEN_INSPECTIONS_LONG, PLH_InspectNextGroupMember)
			return true
		else
			PLH_SendDebugMessage('   Unable to inspect ' .. characterName)
		end
	end
	return false
end

-- An Inspect Loop (managed by inspectLoop) is a complete iteration of inspection for every member in the group.  
-- 		We will only attempt to inspect characters whose count of cached items is lower than expected.
--      The goal of this loop is to work around the limitation whereby the inspect API doesn't necessarily provide us
--      all items equipped by the character.
-- not local, because it is called by (and calls) InspectGroupMember(characterName), which is defined above
function PLH_InspectNextGroupMember()
	local characterName
	local queuedAnInspection = false
	local spec

	notifyInspectName = nil

	while inspectIndex <= maxInspectIndex  and not queuedAnInspection do
		characterName = select(1, GetRaidRosterInfo(inspectIndex))
		if characterName ~= nil then	-- safeguard; character may have left the roster between the time we started the call and now
			local fullname = PLH_GetFullName(characterName)	-- characterName may or may not have realm.  we want to preserve it the way it is for the call to InspectGroupMember,
															--    but need the name-realm version of the name to look up the element in the cache
			if fullname ~= nil then
				if groupInfoCache[fullname] ~= nil then
					spec = groupInfoCache[fullname][SPEC]
				end

				if GetItemCountFromCache(fullname) < GetExpectedItemCount(spec) or groupInfoCache[fullname][FORCE_REFRESH] then  -- if we've already cached 15 or more items, don't bother refreshing
					queuedAnInspection = InspectGroupMember(characterName)
				end
			end
		end
		inspectIndex = inspectIndex + 1
	end
	
	-- The following logic is meant to work around a limitation of the inspect API.  When you inspect a character, you're
	-- not guaranteed to actually receive all of their equipped items back!  To work around this limitation, we will
	-- perform additional loops of inspecting each character if the number of items we've cached for them is fewer than
	-- the expected number of items that someone would equip
	if inspectIndex > maxInspectIndex then				-- that means we just completed our current loop
		inspectLoop = inspectLoop + 1
		if inspectLoop <= MAX_INSPECT_LOOPS then		-- let's start the next loop
			inspectIndex = 1
			if not queuedAnInspection then				-- if we just queued someone for inspection, we don't need to do anything else to start the new loop since InspectGroupMember will call PLH_InspectNextGroupMember()
				PLH_InspectNextGroupMember()
			end
		elseif not queuedAnInspection then				-- we've finished all loops
			PLH_PrintCache()
		end
	end
	
end

local function PopulateGroupInfoCache()
	local now = time()
	
	if now - priorCacheRefreshTime > MIN_DELAY_BETWEEN_CACHE_REFRESHES then
		priorCacheRefreshTime = now
	
		-- remove characters from the cache if they're no long in the raid/party
		for name, details in pairs(groupInfoCache) do
			if not IsCharacterInGroup(name) then
--				PLH_SendDebugMessage('Removing entry for ' .. name .. ' from cache')
				groupInfoCache[name] = nil
			end
		end

		if IsInGroup() then
			-- If we're already doing an inspect loop, don't interupt it; just do nothing with the request to
			-- PopulateGroupInfoCache() and let the inspect loop continuue on its way!  If the inspectIndex > maxInspectIndex
			-- and inspectLoop > MAX_INSPECT_LOOPS, then we know we've finished all inspections for all loops, so
			-- we can start a brand new loop!
			if inspectLoop == 0 or (inspectIndex > maxInspectIndex and inspectLoop > MAX_INSPECT_LOOPS) then
--				PLH_SendDebugMessage('Refreshing groupInfoCache')
				inspectLoop = 1
				inspectIndex = 1
				maxInspectIndex = GetNumGroupMembers()
				PLH_InspectNextGroupMember()
			end
		end
	end
end

-- Event handler for PLAYER_SPECIALIZATION_CHANGED and UNIT_INVENTORY_CHANGED events
local function GroupMemberInfoChangedEvent(self, event, ...)
	local unit = ...
	local name = PLH_GetFullName(unit)
	if name ~= nil then
		if groupInfoCache[name] ~= nil then
			groupInfoCache[name][FORCE_REFRESH] = true
			PopulateGroupInfoCache()
		elseif IsPlayer(name) then
			LoadPlayerItems()
		end
	end
end

-- Event handler for PLAYER_REGEN_DISABLED event - triggered when the player enters combat, which is a good time
--    to refresh the cache since the people who will be eligible for loot should be close enough to be inspected
local function CombatStatusChangedEvent(self, event, ...)
	PopulateGroupInfoCache()
end

local function Enable()
	PLH_SendDebugMessage('Enabling PLH')
	isEnabled = true
	priorCacheRefreshTime = 0
	groupInfoCache = {}
	eventHandlerFrame:RegisterEvent('CHAT_MSG_LOOT')
--	eventHandlerFrame:RegisterEvent('SHOW_LOOT_TOAST')
	eventHandlerFrame:RegisterEvent('CHAT_MSG_ADDON')
	eventHandlerFrame:RegisterEvent('INSPECT_READY')
	eventHandlerFrame:RegisterEvent('PLAYER_REGEN_DISABLED')   -- player entered combat
	eventHandlerFrame:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED')
	eventHandlerFrame:RegisterEvent('UNIT_INVENTORY_CHANGED')
	eventHandlerFrame:RegisterEvent('GET_ITEM_INFO_RECEIVED')

	LoadPlayerItems()
	
	PLH_SendAddonMessage('IDENTIFY_USERS~ ~' .. PLH_GetFullName('player'))
end

local function Disable()
	PLH_SendDebugMessage('Disabling PLH')
	isEnabled = false
	priorCacheRefreshTime = 0
	groupInfoCache = {}
	eventHandlerFrame:UnregisterAllEvents()
end


local function EnableOrDisable()
	local inInstance, instanceType = IsInInstance()
	local isPersonalLoot = (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) or (IsInGroup() and GetLootMethod() == 'personalloot'))
		and (instanceType == "party" or instanceType == "raid")
	local shouldBeEnabled = isPersonalLoot

	if not isEnabled and shouldBeEnabled then	
		Enable()
	elseif isEnabled and shouldBeEnabled then	
		PLH_ProcessIdentifyUsersMessage()
	elseif isEnabled and not shouldBeEnabled then
		Disable()
	end
	
	if isEnabled then 
		PopulateGroupInfoCache()
	end
end

-- Event handler for GROUP_ROSTER_UPDATE, ZONE_CHANGED_NEW_AREA, and PLAYER_ENTERING_WORLD events
local function EnableOrDisableEvent(self, event, ...)
	-- the following is a bit of a hack to work around a Blizzard issue.  While the player is logging in, IsInGroup()
	-- is false.  If the user is already in a group (for example, logging back in after a disconnect or doing a /reload),
	-- A ROSTER_UPDATE event triggers.  However, IsInGroup() is not immediately set to true when the event fires!
	-- So if we get a ROSTER_UPDATE event and we're currently disabled, lets wait 2 seconds to make sure IsInGroup()
	-- gives us the correct value.  Similar behavoir occurred in LFR testing where people joining/leaving the group
	-- may not have been automatically available.  Hence the delay.
	PLH_wait(PLH_WAIT_FOR_ENABLE_OR_DISABLE, 2, EnableOrDisable)
end

-- Event handler for ADDON_LOADED event
local function AddonLoadedEvent(self, event, addonName, ...)
	--if addonName == 'PersonalLootHelper' then
		eventHandlerFrame:UnregisterEvent('ADDON_LOADED')

		if PLH_STATS == nil then
			PLH_STATS = {}
		end
		if PLH_META == nil then
			PLH_META = {}
		end
		if PLH_PREFS == nil then
			PLH_PREFS = {}
		end

		for key, value in pairs(PLH_DEFAULT_PREFS) do
			if PLH_PREFS[key] == nil or PLH_PREFS[key] == '' then
				PLH_PREFS[key] = value
			end
		end

		if PLH_STATS[PLH_ITEMS_REQUESTED] == nil then
			PLH_STATS[PLH_ITEMS_REQUESTED] = 0
		end
		if PLH_STATS[PLH_ITEMS_RECEIVED] == nil then
			PLH_STATS[PLH_ITEMS_RECEIVED] = 0
		end
		if PLH_STATS[PLH_ITEMS_OFFERED] == nil then
			PLH_STATS[PLH_ITEMS_OFFERED] = 0
		end
		if PLH_STATS[PLH_ITEMS_GIVEN_AWAY] == nil then
			PLH_STATS[PLH_ITEMS_GIVEN_AWAY] = 0
		end
		
		if enableOrDisableEventFrame == nil then
			enableOrDisableEventFrame = CreateFrame('Frame')
			enableOrDisableEventFrame:SetScript('OnEvent', EnableOrDisableEvent)
			enableOrDisableEventFrame:RegisterEvent('GROUP_ROSTER_UPDATE')
			enableOrDisableEventFrame:RegisterEvent('ZONE_CHANGED_NEW_AREA')
			enableOrDisableEventFrame:RegisterEvent('PLAYER_ENTERING_WORLD')
		end
		
		C_ChatInfo.RegisterAddonMessagePrefix('2UI')

		CreateLootedItemsDisplay()
		PLH_CreateOptionsPanel()		
	--end
end

local function ProcessEvent(self, event, ...)
	if event == 'ADDON_LOADED' then
		AddonLoadedEvent(self, event, ...)
--	elseif event == 'CHAT_MSG_LOOT' or event == 'SHOW_LOOT_TOAST' then
	elseif event == 'CHAT_MSG_LOOT' then
		LootReceivedEvent(self, event, ...)
	elseif event == 'CHAT_MSG_ADDON' then
		AddonMessageReceivedEvent(self, event, ...)
	elseif event == 'INSPECT_READY' then
		InspectReadyEvent(self, event, ...)
	elseif event == 'PLAYER_REGEN_DISABLED' then
		CombatStatusChangedEvent(self, event, ...)
	elseif event == 'PLAYER_SPECIALIZATION_CHANGED' or event == 'UNIT_INVENTORY_CHANGED' then
		GroupMemberInfoChangedEvent(self, event, ...)
	elseif event == 'GET_ITEM_INFO_RECEIVED' then
		GetItemInfoReceivedEvent(self, event, ...)
	end
end

function SlashCmdList.PLHCommand(msg)
--	if msg == nil or msg == '' then
--		if lootedItemsFrame:IsVisible() then
--			lootedItemsFrame:Hide()
--		else
--			lootedItemsFrame:Show()
--		end
	if msg == nil or msg == '' or string.upper(msg) == 'CONFIG' then
		Settings.OpenToCategory(PersonalLootHelperLocal)
	elseif string.upper(msg) == 'SHOW' then
		lootedItemsFrame:Show()
	elseif string.upper(msg) == 'HIDE' then
		lootedItemsFrame:Hide()
	elseif string.sub(string.upper(msg), 1, 5) == 'TRADE' or string.sub(string.upper(msg), 1, 5) == 'OFFER' then
		local itemInfo = nil
		local itemLink = string.match(string.sub(msg, 6), ' (.+)')
		if itemLink ~= nil then
			itemInfo = GetItemInfo(itemLink)  -- check to see if it's a properly formatted item link
		end
		if itemInfo ~= nil then
			local lootedItemIndex = AddLootedItem(GetFullItemInfo(itemLink), PLH_GetFullName('player'))
			PLH_DoTradeItem(lootedItemIndex)
			if PLH_PREFS[PLH_PREFS_SKIP_CONFIRMATION] then  -- show confirmation as chat since they won't see it in window
				PLH_SendUserMessage("Thank you! Other PLH users have been notified that " .. itemLink .. " is available.")
			end
		else
			PLH_SendUserMessage("Usage:  /plh trade [item]")
		end
	else
		PLH_SendUserMessage("Unknown parameter. Options are:\n" ..
			"/plh  :  open interface options\n" ..
			"/plh show  :  show loot window\n" ..
			"/plh hide  :  hide loot window\n" ..
--			"/plh config  :  open interface options\n" ..
			"/plh offer [item]  :  offer [item] to other PLH users in the group"
		)
	end
end

eventHandlerFrame = CreateFrame('Frame')
eventHandlerFrame:SetScript('OnEvent', ProcessEvent)
eventHandlerFrame:RegisterEvent('ADDON_LOADED')

--[[
*********************************************************
Debug/Testing functions
*********************************************************
]]--

-- pass in a non-character name (ex: 'test') to show counts for each member
function PLH_PrintCache(characterName)
	if PLH_PREFS[PLH_PREFS_DEBUG] then
		local num_characters = 0
		local item_msg = ''
		for name, characterDetails in pairs(groupInfoCache) do
			num_characters = num_characters + 1
			item_msg = item_msg .. GetItemCountFromCache(name) .. '/' 
		end
		PLH_SendDebugMessage('Cache contains ' .. num_characters .. ' member(s). Item count per member: ' .. item_msg)
		
		if (characterName ~= nil) then
			for name, details in pairs(groupInfoCache) do
				PLH_SendDebugMessage('   ' .. name .. ' ' .. GetItemCountFromCache(name) .. ' items')
				if name == PLH_GetFullName(characterName) then
					if details == nil then	
						PLH_SendDebugMessage('      details is nil')
					else
						for slotID, item in pairs(details) do
							PLH_SendDebugMessage('      ' .. slotID .. ' = ' .. tostring(GetFullItemInfo(item)[FII_ITEM]))
						end
					end
				end
			end
		end
	end
end

function PLH_PrintLootedItems()
	local requestor
	if PLH_PREFS[PLH_PREFS_DEBUG] then
		for lootedItemIndex = 1, #lootedItems do
			PLH_SendDebugMessage(lootedItems[lootedItemIndex][LOOTER_NAME] .. ' looted ' .. lootedItems[lootedItemIndex][FULL_ITEM_INFO][FII_ITEM])
			PLH_SendDebugMessage('   ' .. lootedItems[lootedItemIndex][STATUS] .. ' Req = ' .. lootedItems[lootedItemIndex][SELECTED_REQUESTOR_INDEX] .. ', Def = ' .. lootedItems[lootedItemIndex][DEFAULT_REQUESTOR_INDEX])
			if lootedItems[lootedItemIndex][CONFIRMATION_MESSAGE] ~= nil then
				PLH_SendDebugMessage('   Confirm = ' .. lootedItems[lootedItemIndex][CONFIRMATION_MESSAGE])
			end
			for requestorIndex = 1, #lootedItems[lootedItemIndex][REQUESTORS] do
				requestor = lootedItems[lootedItemIndex][REQUESTORS][requestorIndex]
				PLH_SendDebugMessage('      ' .. requestor[REQUESTOR_NAME] .. ' rolled ' .. requestor[REQUESTOR_ROLL] .. ' for ' .. requestor[REQUESTOR_REQUEST_TYPE])
				PLH_SendDebugMessage('         Requestor Sort Order = ' .. requestor[REQUESTOR_SORT_ORDER])
			end
		end
	end
end

function PLH_EnableDebug()
	PLH_PREFS[PLH_PREFS_DEBUG] = true
end

function PLH_DisableDebug()
	PLH_PREFS[PLH_PREFS_DEBUG] = false
end

function PLH_RefreshCache()
	priorCacheRefreshTime = 0
	groupInfoCache = {}
	PopulateGroupInfoCache()
end

function PLH_TestItems(characterIndex)
	if characterIndex == nil then
		PLH_SendDebugMessage('Usage: PLH_TestItems(characterIndex)')
	else
		characterName = select(1, GetRaidRosterInfo(characterIndex))
		if not string.find(characterName, '-') then
			characterName = PLH_GetFullName(characterName)
		end
		
		PLH_SendDebugMessage('Evaluating items equipped by ' .. characterName)

		local item
		for itemIndex = 1, 19 do
			if characterName == PLH_GetFullName('player') then
				item = GetInventoryItemLink('player', itemIndex)	
			else
				item = groupInfoCache[characterName][itemIndex]
			end

			if item ~= nil then
				PLH_SendDebugMessage('   evaluating ' .. item[FII_ITEM])
				
				local isEquippable
				for evalIndex = 1, GetNumGroupMembers() do
					evalName = select(1, GetRaidRosterInfo(evalIndex))
					if not string.find(evalName, '-') then
						evalName = PLH_GetFullName(evalName)
					end
				
					isEquippable = IsEquippableItemForCharacter(item[FII_ITEM], evalName)
					PLH_SendDebugMessage('      For ' .. evalName ..
						' equippable = ' .. tostring(isEquippable) ..
						'; upgrade = ' .. tostring(isEquippable and IsAnUpgradeForCharacter(item[FII_ITEM], evalName, 0))
						)
				end
			end
		end
	end
end

function PLH_TestItem(item)
	PLH_SendDebugMessage('Testing ' .. item)
	PLH_SendDebugMessage('   equippable for player = ' .. tostring(IsEquippableItemForCharacter(GetFullItemInfo(item), 'player')))
	PLH_SendDebugMessage('   upgrade for player = ' .. tostring(IsAnUpgradeForCharacter(GetFullItemInfo(item), 'player', 0)))
	PLH_SendDebugMessage('   upgrade for any character = ' .. tostring(select(1, IsAnUpgradeForAnyCharacter(GetFullItemInfo(item)))))
end

function PLH_Test()
	-- 930 Neck
	PLH_TEST_ITEM_1 = '\124cffa335ee\124Hitem:151973::::::::110::::2:3610:1472:\124h[Collar of Null-Flame]\124h\124r'

	-- 960 Ring
	PLH_TEST_ITEM_2 = '\124cffa335ee\124Hitem:152063::::::::110::::2:1502:3611:\124h[Seal of the Portalmaster]\124h\124r'

	-- 845 Ring
	PLH_TEST_ITEM_3 = '\124cff0070dd\124Hitem:137533::::::::110::::2:1826:1497:\124h[Ring of Minute Mirrors]\124h\124r'

	-- 985 Leather Belt
	PLH_TEST_ITEM_4 = '\124cffa335ee\124Hitem:151991::::::::110::::2:1527:3610:\124h[Belt of Fractured Sanity]\124h\124r'

	-- 985 Cloth Helm
	PLH_TEST_ITEM_5 = '\124cffa335ee\124Hitem:151943::::::::110::::2:1527:3610:\124h[Crown of Relentless Annihilation]\124h\124r'

	-- 980 Leather Feet
	PLH_TEST_ITEM_6 = '\124cffa335ee\124Hitem:151981::::::::110::::2:1522:3610:\124h[Life-Bearing Footpads]\124h\124r'	

	-- 985 BoE Leather Feet
	PLH_TEST_ITEM_7 = '\124cffa335ee\124Hitem:147424::::::::110::::2:1567:3561:\124h[Treads of Violent Intrusion]\124h\124r'

	-- 950 BoE Leater Feet
	PLH_TEST_ITEM_8 = '\124cffa335ee\124Hitem:128885::::::::110::::2:669:1572:\124h[Dreadleather Footpads]\124h\124r' -- 950 leather BoE boots

	-- 950 Leather Feet
	PLH_TEST_ITEM_9 = '\124cffa335ee\124Hitem:152412::::::::110::::2:1492:3610:\124h[Depraved Machinist\'s Footpads]\124h\124r' -- 950 leather BoP boots

	-- 985 BoE Leather Helm with sockets
	PLH_TEST_ITEM_10 = '\124cffa335ee\124Hitem:151588::::::::110::::2:1572:3598:\124h[Empyrial Deep Crown]\124h\124r'

	-- 950 BoE Leather Helm with sockets
	PLH_TEST_ITEM_11 = "\124cffa335ee\124Hitem:151588::::::::110::::2:1537:3609:\124h[Empyrial Deep Crown]\124h\124r"

	-- the test items from wowhead aren't fully formed, hence the strange looking call to GetItemInfo
	PLH_TEST_ITEM_1 = select(2, GetItemInfo(PLH_TEST_ITEM_1))
	PLH_TEST_ITEM_2 = select(2, GetItemInfo(PLH_TEST_ITEM_2))
	PLH_TEST_ITEM_3 = select(2, GetItemInfo(PLH_TEST_ITEM_3))
	PLH_TEST_ITEM_4 = select(2, GetItemInfo(PLH_TEST_ITEM_4))
	PLH_TEST_ITEM_5 = select(2, GetItemInfo(PLH_TEST_ITEM_5))
	PLH_TEST_ITEM_6 = select(2, GetItemInfo(PLH_TEST_ITEM_6))
	PLH_TEST_ITEM_7 = select(2, GetItemInfo(PLH_TEST_ITEM_7))
	PLH_TEST_ITEM_8 = select(2, GetItemInfo(PLH_TEST_ITEM_8))
	PLH_TEST_ITEM_9 = select(2, GetItemInfo(PLH_TEST_ITEM_9))
	PLH_TEST_ITEM_10 = select(2, GetItemInfo(PLH_TEST_ITEM_10))
	PLH_TEST_ITEM_11 = select(2, GetItemInfo(PLH_TEST_ITEM_11))

	--[[  DEMO step 1 ]]--
	--PLH_SendDebugMessage("Adding " .. PLH_TEST_ITEM_1)
	--PLH_SendDebugMessage("Adding " .. PLH_TEST_ITEM_7)
	--PLH_SendDebugMessage("Adding " .. PLH_TEST_ITEM_6)
	local playerName = UnitName('player') .. '-' .. GetRealmName()
	LootReceivedEvent(self, nil, UnitName('player') .. ' receives loot: ' .. PLH_TEST_ITEM_1 .. '.', nil, nil, nil, playerName)
	PLH_ProcessTradeItemMessage("Killindmice-Zul'jin", PLH_TEST_ITEM_7)
	PLH_ProcessTradeItemMessage("Boomerz-Zul'jin", PLH_TEST_ITEM_6)

--[[	
	PLH_SendDebugMessage("Adding test item " .. PLH_TEST_ITEM_1)
	local lootString = 'Madone receives loot: ' .. PLH_TEST_ITEM_1 .. '.'
	LootReceivedEvent(self, nil, lootString, nil, nil, nil, "Madone-Zul'jin")

	PLH_SendDebugMessage("Adding test item " .. PLH_TEST_ITEM_2)
	local lootString = 'Madone receives loot: ' .. PLH_TEST_ITEM_2 .. '.'
	LootReceivedEvent(self, nil, lootString, nil, nil, nil, "Madone-Zul'jin")

	PLH_SendDebugMessage("Adding test item " .. PLH_TEST_ITEM_3)
	local lootString = 'Madone receives loot: ' .. PLH_TEST_ITEM_3 .. '.'
	LootReceivedEvent(self, nil, lootString, nil, nil, nil, "Madone-Zul'jin")
	
	PLH_SendDebugMessage("Adding test item " .. PLH_TEST_ITEM_4)
	local lootString = 'Killindmice receives loot: ' .. PLH_TEST_ITEM_4 .. '.'
	LootReceivedEvent(self, nil, lootString, nil, nil, nil, "Killindmice-Zul'jin")
	
	PLH_SendDebugMessage("Adding test item " .. PLH_TEST_ITEM_5)
	local lootString = 'ClothTest receives loot: ' .. PLH_TEST_ITEM_5 .. '.'
	LootReceivedEvent(self, nil, lootString, nil, nil, nil, "ClothTest-Staghelm")
	
	PLH_SendDebugMessage("Adding test item " .. PLH_TEST_ITEM_6)
	local lootString = 'Roth receives loot: ' .. PLH_TEST_ITEM_6 .. '.'
	LootReceivedEvent(self, nil, lootString, nil, nil, nil, "Roth-Zul'jin")
	
	PLH_SendDebugMessage("Adding test item " .. PLH_TEST_ITEM_7)
	local lootString = 'Killindmice receives loot: ' .. PLH_TEST_ITEM_7 .. '.'
	LootReceivedEvent(self, nil, lootString, nil, nil, nil, "Killindmice-Zul'jin")

	PLH_SendDebugMessage("Adding test item " .. PLH_TEST_ITEM_8)
	local lootString = 'Killindmice receives loot: ' .. PLH_TEST_ITEM_8 .. '.'
	LootReceivedEvent(self, nil, lootString, nil, nil, nil, "Killindmice-Zul'jin")

	PLH_SendDebugMessage("Adding test item " .. PLH_TEST_ITEM_9)
	PLH_ProcessTradeItemMessage("PLHUser-Firetree", PLH_TEST_ITEM_9)

	PLH_SendDebugMessage("Adding test item " .. PLH_TEST_ITEM_10)
	local lootString = 'NonPLHUser receives loot: ' .. PLH_TEST_ITEM_10 .. '.'
	LootReceivedEvent(self, nil, lootString, nil, nil, nil, "NonPLHUser-Staghelm")
	PLH_ProcessTradeItemMessage("Killindmice-Zul'jin", PLH_TEST_ITEM_10)

	PLH_SendDebugMessage("Adding test item " .. PLH_TEST_ITEM_11)
	local lootString = 'Madone receives loot: ' .. PLH_TEST_ITEM_11 .. '.'
	LootReceivedEvent(self, nil, lootString, nil, nil, nil, "Madone-Zul'jin")
]]--	
end

function PLH_Test2()
	--[[ DEMO step 2 ]]--
	local playerName = UnitName('player') .. '-' .. GetRealmName()
	PLH_ProcessRequestItemMessage(playerName, 151973, "Venamis-Zul'jin", REQUEST_TYPE_MAIN_SPEC)
	PLH_ProcessRequestItemMessage(playerName, 151973, "Fockey-Zul'jin", REQUEST_TYPE_MAIN_SPEC)
	PLH_ProcessRequestItemMessage(playerName, 151973, "Vasimr-Zul'jin", REQUEST_TYPE_OFF_SPEC)
	PLH_ProcessKeepItemMessage("Killindmice-Zul'jin", 147424)
end

function PLH_TestInv()
	local item
	local fii
	
    for bag = 0, NUM_BAG_SLOTS do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
--          itemID = GetContainerItemID(bag, slot)
--			item = select(7, GetContainerItemInfo(bag, slot))
			item = C_Container.GetContainerItemLink(bag, slot)
			if IsEquippableItem(item) then
				print(item)
				fii = GetFullItemInfo(item)
				if fii[FII_TRADE_TIME_WARNING_SHOWN] ~= nil then
					print('   ' .. fii[FII_TRADE_TIME_WARNING_SHOWN])
				end
			end
        end
    end
end

function PLH_PrintFII(item)
	local fii = GetFullItemInfo(item)
	print("fii[FII_ITEM] = ", fii[FII_ITEM])
	print("   fii[FII_IS_AZERITE_ITEM] = ", fii[FII_IS_AZERITE_ITEM])
end
