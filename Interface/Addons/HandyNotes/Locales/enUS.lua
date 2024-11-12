local L = LibStub("AceLocale-3.0"):NewLocale("HandyNotes", "enUS", true, true)
L["HandyNotes"] = true

L["Enable HandyNotes"] = true
L["Enable or disable HandyNotes"] = true

L["Overall settings"] = true
L["Overall settings that affect every database"] = true
L["These settings control the look and feel of HandyNotes globally. The icon's scale and alpha here are multiplied with the plugin's scale and alpha."] = true
L["World Map Icon Scale"] = true
L["The overall scale of the icons on the World Map"] = true
L["World Map Icon Alpha"] = true
L["The overall alpha transparency of the icons on the World Map"] = true
L["Minimap Icon Scale"] = true
L["The overall scale of the icons on the Minimap"] = true
L["Minimap Icon Alpha"] = true
L["The overall alpha transparency of the icons on the Minimap"] = true

L["Plugins"] = true
L["Plugin databases"] = true
L["Configuration for each individual plugin database."] = true
L["Show the following plugins on the map"] = true

L["Add Handy Note"] = true
L["Edit Handy Note"] = true
L["Delete Handy Note"] = true
L["Title"] = true
L["Description/Notes:"] = true
L["Show on continent map"] = true
L["Add this location to TomTom waypoints"] = true
L["|cFF00FF00Hint: |cffeda55fCtrl+Shift+LeftDrag|cFF00FF00 to move a note"] = true

L["These settings control the look and feel of the HandyNotes icons."] = true
L["Icon Scale"] = true
L["The scale of the icons"] = true
L["Icon Alpha"] = true
L["The alpha transparency of the icons"] = true

L["\nAlt+Right Click To Add a HandyNote"] = true
L["ERROR_CREATE_NOTE1"] = "HandyNotes cannot create a note here as it is unable to obtain your current location. Usually this is because there is no map for the zone you are in."
L["Syntax:"] = true

L["Portal"] = true
L["(No Title)"] = true

-- vim: ts=4 noexpandtab
-------------------------------------------------------------------------------BC
------------------------------ SHADOWMOON VALLEY ------------------------------
-------------------------------------------------------------------------------

L['netherwing_egg'] = '{item:32506}'
L['options_icons_netherwing_eggs'] = '{achievement:898}'
L['options_icons_netherwing_eggs_desc'] = 'Display the location of {item:32506} for {achievement:898} achievement.'

L['options_icons_safari'] = '{achievement:6587}'
L['options_icons_safari_desc'] = 'Display battle pet locations for the {achievement:6587} achievement.'

L['options_icons_crazyforcats'] = '{achievement:8397}'
L['options_icons_crazyforcats_desc'] = 'Display battle pet locations for the {achievement:8397} achievement.'


-------------------------------------------------------------------------------CTM
----------------------------------- COMMON ------------------------------------
-------------------------------------------------------------------------------

L['change_map'] = 'Change map'

L['options_icons_safari'] = 'Kalimdor / Eastern Kingdoms Safari'
L['options_icons_safari_desc'] = 'Display battle pet locations for the {achievement:6585} and {achievement:6586} achievements.'

-------------------------------------------------------------------------------
--------------------------------- MOUNT HYJAL ---------------------------------
-------------------------------------------------------------------------------

L['hyjal_phase0'] = 'Phase 0 - Pre Invasion'
L['hyjal_phase1'] = 'Phase 1 - Invasion'
L['hyjal_phase2'] = 'Phase 2 - The Sanctuary of Malorne'
L['hyjal_phase3'] = 'Phase 3 - The Molten Front'
L['hyjal_phase4a'] = 'Phase 4a - The Druids of the Talon Area'
L['hyjal_phase4b'] = 'Phase 4b - The Shadow Wardens Area'
L['hyjal_phase5'] = 'Phase 5 - The Regrowth'

L['hyjal_phase1_note'] = 'Complete Quests in {location:Mount Hyjal} until you get {quest:29389}. This questline will start the Invasion Phase.'
L['hyjal_phase2_note'] = 'To advance into Phase 2 you need 10 {currency:416} for {quest:29198}.\n\nYou earn {currency:416} from daily quests.'
L['hyjal_phase3_note'] = 'To advance into Phase 3 you need 15 {currency:416} for {quest:29201}.\n\nYou earn {currency:416} from daily quests.'
L['hyjal_phase4_note'] = [[
Phase 4 is split into 2 parts.

To advance into Phase 4a you need 150 {currency:416} for {quest:29181}.
To advance into Phase 4b you need 150 {currency:416} for {quest:29214}.

You earn {currency:416} from daily quests.
]]
L['hyjal_phase5_note'] = 'To advance into Phase 5 you need to complete {quest:29215} and {quest:29182}.' -- review

L['portal_molten_front'] = 'Portal to the Molten Front'
L['portal_mount_hyjal'] = 'Portal to Mount Hyjal'

L['spider_hill_note'] = [[
Reach the highest point in the {location:Widow's Clutch}.

To reach the top you have to aggro the {npc:52981} without killing them. They will cast {spell:97959} and pull you up.
Recommended methods for max level characters:

{item:46725}
Demon Hunter: {spell:185245}
Druid: {spell:2908}
Hunter: {spell:1513}
Mage: {spell:241178}
Paladin: {spell:62124}
Priest: {spell:528}
Rogue: {spell:36554}
Shaman: {spell:52870}
Warrior: {spell:355}
]]

L['fiery_lords_note'] = 'Only one {title:Lord} is up at a time, after killing it the next will spawn immediately.'
L['have_we_met_note'] = [[
An elite group of fighters will assist you at the daily quest as you arrive in {location:Sethria's Roost}.

Use the emote {emote:/wave} to wave to the required NPC.
]]

L['ludicrous_speed_note'] = [[
While on the quest {daily:29147}, obtain 65 stacks of {spell:100957}.

{npc:52594} gives 15 stacks
{npc:52596} gives 5 stacks
{npc:52595} gives 1 stack
]]

L['angry_little_squirrel_note'] = 'Pull an enemy to the tree and an {npc:52195} will bonk on its head.'
L['hyjal_bear_cub_note'] = 'While on the quest {daily:29161}, throw a {npc:52688} on a {npc:52795}' -- review
L['child_of_tortolla_note'] = 'While on the quest {daily:29101}, instead of punting a turtle into the water, punt it at a {npc:52219}.' -- review
L['ready_for_raiding_2_note'] = 'Slay the following {title:Lieutenant of Flame} in {location:Ragnaros\' Reach} without getting hit by their special attacks.'
L['flawless_victory_note'] = 'Solo kill a {npc:52552} without taking any damage from {spell:97243} or {spell:96688}.'
L['gang_war_note'] = 'Win a duel in {location:Sethria\'s Roost} while on the quest {daily:29128}.'
L['death_from_above_note'] = [[
Bomb the {title:<Firelord>} while you are on the quest {daily:29290}.

{note:Only 3 {title:Firelord}s are active at a time. To complete the achievement faster dont turn in the quest and come back tomorrow.}
]]
L['flamewaker_sentinel_note'] = 'Use {item:137663} to lower his health and so he cast {spell:98369}. Dodge all shots and then kill him.'
L['flamewaker_shaman_note'] = 'Use {item:137663} to get him to low health. Wait until he kills himself.'

L['options_icons_spider_hill_desc'] = 'Displays the location for the {achievement:5872} achievement.'
L['options_icons_fiery_lords_desc'] = 'Displays the locations of the elementals for the {achievement:5861} achievement.'
L['options_icons_have_we_met_desc'] = 'Displays the quest location for the {achievement:5865} achievement.'
L['options_icons_unbeatable_pterodactyl_desc'] = 'Displays the quest location for the {achievement:5860} achievement.'
L['options_icons_ludicrous_speed_desc'] = 'Displays the location for the {achievement:5862} achievement.'
L['options_icons_critter_revenge_desc'] = 'Displays the locations of the critters for the {achievement:5868} achievement.'
L['options_icons_r4r_2_desc'] = 'Displays the location for the {achievement:5873} achievement.'
L['options_icons_flawless_victory_desc'] = 'Displays the location for the {achievement:5873} achievement.'
L['options_icons_gang_war_desc'] = 'Display the location for the {achievement:5864} achievement.'
L['options_icons_death_from_above_desc'] = 'Displays the locations for the {achievement:5874} achievement.'
L['options_icons_infernal_ambassadors_desc'] = 'Displays the locations for the {achievement:5869} achievement.'
L['options_icons_fireside_chat_desc'] = 'Displays the locations of NPCs for the {achievement:5870} achievement.'
L['options_icons_molten_flow_master_desc'] = 'Displays the locations for the {achievement:5871} achievement.'

-------------------------------------------------------------------------------
---------------------------------- DEEPHOLM -----------------------------------
-------------------------------------------------------------------------------

L['portal_to_therazane'] = 'Portal to Therazane\'s Throne'
L['portal_to_earth_temple'] = 'Portal to Temple of Earth'

L['fungal_frenzy_note'] = [[
Suffer the effects of a {spell:83803}, {spell:83805}, {spell:83747} and {spell:83804} simultaneously.

{dot:Bronze} {spell:83747}
Redish-brown mushroom with white border.
Makes you shrink.

{dot:Red} {spell:83803}
Large red mushroom, near water.
Surrounds you with a red mist, increases damage dealt.

{dot:Blue} {spell:83805}
Blue mushroom with white border.
Makes you run faster.

{dot:LightBlue} {spell:83804}
Purple mushroom with pink dots.
Collect this mushroom last, it will only throw you in the air, you won't get any buff.

{note:The mushrooms can only be found if you are on the quest {daily:27050}.
All mushrooms are displayed as {object:Sprouting Crimson Mushroom}.}
]]
L['rock_lover_note'] = 'Stay away from {npc:44258}.'

L['options_icons_broodmother_desc'] = 'Displays the quest location for the {achievement:5447} achievement.'
L['options_icons_fungal_frenzy_desc'] = 'Displays the mushroom locations for the {achievement:5450} achievement.'
L['options_icons_fungalophobia_desc'] = 'Displays the quest location for the {achievement:5445} achievement.'
L['options_icons_glop_family_desc'] = 'Displays the quest location for the {achievement:5446} achievement.'
L['options_icons_rock_lover_desc'] = 'Displays the location and path to {npc:49956} for the {achievement:5449} achievement.'

-------------------------------------------------------------------------------
----------------------------------- VASHJIR -----------------------------------
-------------------------------------------------------------------------------

L['options_icons_whale_shark_desc'] = 'Displays the location of {npc:40728} for the {achievement:4975} achievement.'

-------------------------------------------------------------------------------
----------------------------- TWILIGHT HIGHLANDS ------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
------------------------------------ ULDUM ------------------------------------
-------------------------------------------------------------------------------

--WLK
L['area_spawn'] = 'Spawns in the surrounding area.'

L['squirrels_note'] = 'You must use the emote {emote:/love} on critters not battle pets.'
L['options_icons_squirrels'] = '{achievement:2557}'
L['options_icons_squirrels_desc'] = 'Display the locations of critters for {achievement:2557} achievement.'

L['achievement_friend_or_fowl_desc'] = 'Slay 15 {npc:62648s} in 3 minutes.'
L['note_devouring_maggot'] = 'Deep down in the {location:Utgarde Catacombs}.'
L['dalaran_sewers'] = 'In the {location:Dalaran Sewers}.'
L['in_nexus'] = 'Inside {location:The Nexus} at the {location:Hall of Stasis}.'

L['higher_learning_1'] = 'On the floor on the right side of the bookshelf.'
L['higher_learning_2'] = 'On the floor beside the small table.'
L['higher_learning_3'] = 'In the bookshelf.'
L['higher_learning_4'] = 'On the floor between the bookshelfes.'
L['higher_learning_5'] = 'Up on a crate on the balcony.'
L['higher_learning_6'] = 'Up on the crate in the corner.'
L['higher_learning_7'] = 'Upstairs in the bookshelf.'
L['higher_learning_8'] = 'Downstairs in the bookshelf.'
L['higher_learning_vargoth'] = 'After reading all 8 books, you will receive {item:43824} by mail to teleport to {location:Archmage Vargoth\'s Retreat}.\nTalk to {npc:90430} to get the pet.'

L['coinmaster_note'] = 'Fish up all coins from the Dalaran fountain.'

--MOP

-------------------------------------------------------------------------------
-------------------------------- TIMELESS ISLE --------------------------------
-------------------------------------------------------------------------------

L['cavern_of_lost_spirits'] = 'Inside the {location:Cavern of Lost Spirits}.'
L['looted_twice'] = 'You\'ve never killed this rare on this character. It can be looted twice today.'
L['neverending_spritewood'] = 'Neverending Spritewood'
L['neverending_spritewood_note'] = 'After breaking the {object:Neverending Spritewood}, kill as many {npc:71824s} as you can while you have the {spell:144052} debuff!'
L['zarhym_note'] = 'Once a day you can talk to {npc:71876} to enter the {spell:144145} and attempt to retrieve his body.'

L['archiereus_note'] = 'Purchase a {item:103684} from {npc:73306} to summon this rare.'
L['chelon_note'] = 'Click the {object:Conspicuously Empty Shell} to spawn the rare.'
L['cranegnasher_note'] = 'Kite a {npc:72095} from the south on top of the crane corpse.'
L['dread_ship_note'] = 'Loot the {item:104115} from {npc:73279} and use it at the {object:Cursed Gravestone} to summon the rare.'
L['emerald_gander_note'] = 'Kill {npc:72762s} around the {location:Celestial Court} until {npc:73158} spawns.'
L['evermaw_note'] = 'Swims clockwise around the entire island.'
L['great_turtle_furyshell_note'] = 'Kill {npc:72764s} or {npc:72763s} until {npc:73161} spawns.'
L['imperial_python_note'] = 'Kill {npc:72841s} around the {location:Celestial Court} until {npc:73163} spawns.'
L['ironfur_steelhorn_note'] = 'Kill {npc:72844s} around the {location:Celestial Court} until {npc:73160} spawns.'
L['karkanos_note'] = 'Talk to {npc:72151} to reel in the rare. What a catch!'
L['monstrous_spineclaw_note'] = 'Kill {npc:72766s} all around the island until {npc:73166} spawns.'
L['rattleskew_note'] = 'Kill waves of {npc:72033s} until the rare appears.'
L['spelurk_cave'] = 'Inside {npc:71864}\'s cave.'
L['spelurk_note'] = [[
To break into {npc:71864}'s cave, find one of the lost artifacts scattered around the island and use its ability on the rocks blocking the entrance.

• {spell:147278}
• {spell:149333}
• {spell:149345}
• {spell:149350}

If you cannot find an artifact, you can use {item:70161} (or other sitting toys) right in front of the rocks. Sit, then stand and walk straight in.
]]
L['zhugon_note'] = 'When the brew event is active, kill {npc:71908s} and break barrels until the rare appears.'

L['blazing_chest'] = 'Blazing Chest'
L['moss_covered_chest'] = 'Moss-Covered Chest'
L['skull_covered_chest'] = 'Skull-Covered Chest'
L['smoldering_chest'] = 'Smoldering Chest'
L['sturdy_chest'] = 'Sturdy Chest'
L['sturdy_chest_note'] = 'Hit a {npc:73531} to get carried here.'

L['gleaming_treasure_satchel_note'] = 'Walk on the ropes of the ship then jump on the pole where the satchel is hanging from.'
L['gleaming_treasure_chest_note'] = 'Jump on the pillars to the treasure.'
L['mist_covered_treasure_chest_note'] = [[
Requires {object:Gleaming Treasure Chest} and {object:Rope-Bound Treasure Chest} to be looted first.

Click the {object:Gleaming Crane Statue} to fly up to the treasure.
]]
L['ropebound_treasure_chest_note'] = 'Walk on the ropes to the treasure.'
L['sunken_treasure_note'] = 'Kill elites on the sunken ship for the key.'

-------------------------------------------------------------------------------
--------------------------------- ACROSS ZONES --------------------------------
-------------------------------------------------------------------------------

L['zandalari_warbringer_note'] = [[
Can be looted multiple times a day.

The color of the {npc:69842} mount will determine the dropped mount's color.
]]
L['zandalari_warbringer_killed'] = 'Zandalari Warbringer killed.'

L['squirrels_note'] = 'You must use the emote {emote:/love} on critters not battle pets.'
L['options_icons_squirrels'] = '{achievement:6350}'
L['options_icons_squirrels_desc'] = 'Display the locations of critters for {achievement:6350} achievement.'

L['options_icons_lorewalker'] = '{achievement:6548}'
L['options_icons_lorewalker_desc'] = 'Display the locations for {achievement:6548} achievement.'

-------------------------------------------------------------------------------
--------------------------------- Jade Forest ---------------------------------
-------------------------------------------------------------------------------

L['ancient_pick'] = '{item:85777} is inside the {location:Greenstone Quarry} on the lower level.'
L['ships_locker'] = 'Ship\'s Locker'
L['ships_locker_note'] = 'in the sunken ship. Contains about 96 Gold.'
L['chest_of_supplies'] = 'Chest of Supplies'
L['chest_of_supplies_note'] = 'Contains about 10 Gold.'
L['offering_of_rememberance'] = 'Offering of Rememberance'
L['offering_of_rememberance_note'] = 'Contains about 30 Gold.'
L['stash_of_gems'] = 'Stash of Gems'
L['stash_of_gems_note'] = 'Contains about 7 Gold and Gems.'

-------------------------------------------------------------------------------
-------------------------------- Krasarang Wilds ------------------------------
-------------------------------------------------------------------------------

L['equipment_locker'] = 'Equipment Locker'

-------------------------------------------------------------------------------
------------------------------- The Veiled Stair ------------------------------
-------------------------------------------------------------------------------

L['forgotten_lockbox'] = 'Forgotten Lockbox'
L['forgotten_lockbox_note'] = 'In the tavern on the second floor.\nContains about 10 Gold.'

-------------------------------------------------------------------------------
-------------------------- Vale of Eternal Blossoms ---------------------------
-------------------------------------------------------------------------------

L['guolai_halls'] = 'In the {location:Guo-Lai Halls}'
L['guolai_cache'] = 'Find a {item:87779} and open an {object:Ancient Guo-Lai Cache}.'

-------------------------------------------------------------------------------
------------------------------- Kun Lai Summit --------------------------------
-------------------------------------------------------------------------------

L['lost_adventurers_belongings'] = 'Lost Adventurer\'s Belongings' -- wowhead.com/object=213774
L['lost_adventurers_belongings_note'] = 'Contains about 97 Gold.'
L['momos_treasure_chest'] = 'Mo-Mo\'s Treasure Chest' -- wowhead.com/object=214407
L['momos_treasure_chest_note'] = 'Contains about 10 Gold.'
L['hozen_treasure_cache'] = 'Hozen Treasure Cache' -- wowhead.com/object=213769
L['hozen_treasure_cache_note'] = 'Contains about 99 Gold.'
L['rikktiks_tick_remover'] = 'Rikktik\'s Tiny Chest' -- wowhead.com/object=213793
L['stolen_sprite_treasure'] = 'Stolen Sprite Treasure' -- wowhead.com/object=213770
L['stolen_sprite_treasure_note'] = 'Contains about 104 Gold.'
L['sturdy_yaungol_spear'] = 'Stash of Yaungol Weapons' -- wowhead.com/object=213842
L['sprites_cloth_chest'] = 'Sprite\'s Cloth Chest' -- wowhead.com/object=213751

-------------------------------------------------------------------------------
------------------------------- Townlong Steppes ------------------------------
-------------------------------------------------------------------------------

L['abandoned_crate_of_goods'] = 'Abandoned Crate of Goods' -- wowhead.com/object=213961
L['abandoned_crate_of_goods_note'] = 'Contains about 103 Gold.'

-------------------------------------------------------------------------------
----------------------------- Valley of Four Winds ----------------------------
-------------------------------------------------------------------------------

L['cache_of_pilfered_goods'] = 'Cache of Pilfered Goods'
L['virmen_treasure_cache'] = 'Virmen Treasure Cache'
L['mysterious_fruit_pile'] = 'Mysterious Fruit Pile'

-------------------------------------------------------------------------------
------------------------------- Isle of Thunder -------------------------------
-------------------------------------------------------------------------------

L['options_icons_kroshik'] = '{achievement:8108}'
L['options_icons_kroshik_desc'] = 'Display the locations for {achievement:8108} achievement.'

L['iot_portal'] = 'Portal'
L['ritualstone_needed'] = 'You need 3 {item:94221} to summon the rare.'
L['kroshik_bow'] = '{emote:/bow}'
L['kroshik_adult'] = 'Runs around the lake.\n{emote:/bow}'
L['kroshik_baby'] = 'Runs around in the area.\n{emote:/bow}'

--WOD

-------------------------------------------------------------------------------
-------------------------------- ACROSS ZONES ---------------------------------
-------------------------------------------------------------------------------

L['edge_of_reality'] = 'Edge of Reality'
L['edge_of_reality_note'] = '{object:Edge of Reality} portal will take you to a scenario, where you can loot {item:121815}.'
L['treasures_discovered'] = 'treasures discovered'
L['strange_spore_treasure'] = 'Strange Spore'
L['burning_blade_cache_treasure'] = 'Burning Blade Cache'
L['multiple_spawn_note'] = 'Can spawn in multiple locations.'

L['options_icons_pepe'] = '{achievement:10053}'
L['options_icons_pepe_desc'] = 'Display costume locations for {achievement:10053} achievement.'

L['squirrels_note'] = 'You must use the emote {emote:/love} on critters not battle pets.'
L['options_icons_squirrels'] = '{achievement:14728}'
L['options_icons_squirrels_desc'] = 'Display the locations of critters for {achievement:14728} achievement.'

L['options_icons_GarrFollower'] = 'Garrison Follower'
L['options_icons_GarrFollower_desc'] = 'Display the locations of Followers.'

-------------------------------------------------------------------------------
------------------------------------ ASHRAN -----------------------------------
-------------------------------------------------------------------------------

L['fen_tao_follower_note'] = 'Talk to him to recruit him as a follower.'

-------------------------------------------------------------------------------
------------------------------- FROSTFIRE RIDGE -------------------------------
-------------------------------------------------------------------------------

L['borrok_the_devourer_note'] = '{note:Do not kill!}\n\nInstead, kill nearby ogres and feed them to {npc:72156}. After 10 ogres he will cough up a lootable {object:Devourer\'s Gutstone}.'
L['gibblette_the_cowardly_note'] = 'Interrupt {spell:175415} or he will run from battle and despawn'

L['arena_masters_war_horn_treasure'] = 'Arena Master\'s War Horn'
L['burning_pearl_treasure'] = 'Burning Pearl'
L['crag_leapers_cache_treasure'] = 'Crag-Leaper\'s Cache'
L['cragmaul_cache_treasure'] = 'Cragmaul Cache'
L['doorogs_secret_stash_treasure'] = 'Doorog\'s Secret Stash'
L['envoys_satchel_treasure'] = 'Envoy\'s Satchel'
L['forgotten_supplies_treasure'] = 'Forgotten Supplies'
L['frozen_frostwolf_axe_treasure'] = 'Frozen Frostwolf Axe'
L['frozen_orc_skeleton_treasure'] = 'Frozen Orc Skeleton'
L['gnawed_bone_treasure'] = 'Gnawed Bone'
L['goren_leftovers_treasure'] = 'Goren Leftovers'
L['gorrthoggs_personal_reserve_treasure'] = 'Gorr\'thogg\'s Personal Reserve'
L['grimfrost_treasure_treasure'] = 'Grimfrost Treasure'
L['iron_horde_munitions_treasure'] = 'Iron Horde Munitions'
L['iron_horde_supplies_treasure'] = 'Iron Horde Supplies'
L['lady_senas_materials_stash_treasure'] = 'Lady Sena\'s Materials Stash'
L['lady_senas_other_materials_stash_treasure'] = 'Lady Sena\'s Other Materials Stash'
L['lagoon_pool_treasure'] = 'Lagoon Pool'
L['lagoon_pool_treasure_note'] = 'Fish in the Lagoon Pool.'
L['lucky_coin_treasure'] = 'Lucky Coin'
L['obsidian_petroglyph_treasure'] = 'Obsidian Petroglyph'
L['ogre_booty_treasure'] = 'Ogre Booty'
L['pale_loot_sack_treasure'] = 'Pale Loot Sack'
L['raided_loot_treasure'] = 'Raided Loot'
L['sealed_jug_treasure'] = 'Sealed Jug'
L['slaves_stash_treasure'] = 'Slave\'s Stash'
L['snow_covered_strongbox_treasure'] = 'Snow-Covered Strongbox'
L['spectators_chest_treasure'] = 'Spectator\'s Chest'
L['supply_dump_treasure'] = 'Supply Dump'
L['survivalists_cache_treasure'] = 'Survivalist\'s Cache'
L['thunderlord_cache_treasure'] = 'Thunderlord Cache'
L['time_warped_tower_treasure'] = 'Time-Warped Tower'
L['time_warped_tower_note'] = 'Loot the Ogers inside the tower.'
L['wiggling_egg_treasure'] = 'Wiggling Egg'
L['young_orc_traveler_note'] = 'Combine with {item:107272}'
L['young_orc_traveler_treasure'] = 'Young Orc Traveler'
L['young_orc_woman_note'] = 'Combine with {item:107273}'
L['young_orc_woman_treasure'] = 'Young Orc Woman'
L['smoldering_true_iron_deposit_treasure'] = 'Smoldering True Iron Deposit'
L['up_some_crates_note'] = 'Up some crates.'
L['wiggling_egg_note'] = 'On top of the building in a nest.'
L['cragmaul_cache_note'] = 'Under the stairs.'

L['prisoner_cage_label'] = 'Prisoner Cage'
L['slaves_freed'] = 'slaves freed'

L['delectable_ogre_delicacies_label'] = '{achievement:9534}'
L['delectable_ogre_delicacies_note'] = [[
{npc:82801}, {npc:82822}, and {npc:82823} can spawn in any location

{spell:166684} lasts 5 minutes
{spell:166686} lasts 2 minutes
{spell:166687} lasts 2 minutes
]]

L['weaponsmith_na_shra_follower_note'] = 'Complete {quest:33838} to recruit her as a follower.'
L['dagg_follower_note'] = 'Rescue {npc:79607} from his first cage then rescue him again from his second cage. Find him outside your garrison to recruit him as a follower.'
L['shadow_hunter_rala_follower_note'] = 'Complete {quest:34348} to recruit him as a follower.'
L['gronnstalker_rokash_follower_note'] = 'Complete {quest:32981} to recruit him as a follower.'

L['options_icons_writing_in_the_snow'] = '{achievement:9531}'
L['options_icons_writing_in_the_snow_desc'] = 'Display the locations of {object:Tattered Journal Page} for {achievement:9531} achievement.'
L['options_icons_breaker_of_chains'] = '{achievement:9533}'
L['options_icons_breaker_of_chains_desc'] = 'Display the locations of {npc:82680} and {object:Prisoner Cage} for {achievement:9533} achievement.'
L['options_icons_delectable_ogre_delicacies'] = '{achievement:9534}'
L['options_icons_delectable_ogre_delicacies_desc'] = 'Display the locations of delicacies for {achievement:9534} achievement.'

-------------------------------------------------------------------------------
----------------------------------- GORGROND ----------------------------------
-------------------------------------------------------------------------------

L['poundfist_note'] = 'Has really long respawn between 50 and 90 hours.'
L['trophy_of_glory_note'] = 'You must finish building up your {location:Gorgrond} {location:Garrison Outpost} to get quest items to drop.'
L['roardan_sky_terror_note'] = 'Flies around {location:Tangleheart} and {location:Beastwatch} and makes 3 stops on the way.'

L['attack_plans_treasure'] = 'Iron Horde Attack Orders'
L['brokors_sack_treasure'] = 'Brokor\'s Sack'
L['discarded_pack_treasure'] = 'Discarded Pack'
L['evermorn_supply_cache_treasure'] = 'Evermorn Supply Cache'
L['explorer_canister_treasure'] = 'Explorer Canister'
L['femur_of_improbability_treasure'] = 'Femur of Improbability'
L['harvestable_precious_crystal_treasure'] = 'Harvestable Precious Crystal'
L['horned_skull_treasure'] = 'Horned Skull'
L['iron_supply_chest_treasure'] = 'Iron Supply Chest'
L['laughing_skull_cache_treasure'] = 'Laughing Skull Cache'
L['laughing_skull_note'] = 'Up in the tree.'
L['ockbars_pack_treasure'] = 'Ockbar\'s Pack'
L['odd_skull_treasure'] = 'Odd Skull'
L['petrified_rylak_egg_treasure'] = 'Petrified Rylak Egg'
L['pile_of_rubble_treasure'] = 'Pile of Rubble'
L['remains_if_balldir_deeprock_treasure'] = 'Remains of Balldir Deeprock'
L['remains_of_balik_orecrusher_treasure'] = 'Remains of Balik Orecrusher'
L['sashas_secret_stash_treasure'] = 'Sasha\'s Secret Stash'
L['snipers_crossbow_trerasure'] = 'Sniper\'s Crossbow'
L['stashed_emergency_rucksack_treasure'] = 'Stashed Emergency Rucksack'
L['strange_looking_dagger_treasure'] = 'Strange Looking Dagger'
L['suntouched_spear_treasure'] = 'Suntouched Spear'
L['vindicators_hammer_treasure'] = 'Vindicator\'s Hammer'
L['warm_goren_egg_note'] = '{item:118705} incubates in 7 days into {item:118716}.'
L['warm_goren_egg_treasure'] = 'Warm Goren Egg'
L['weapons_cache_treasure'] = 'Weapons Cache'

L['ninja_pepe_note'] = 'Inside the hut sitting on a chair.'
L['ninja_pepe_treasure'] = 'Ninja Pepe'

L['protectors_of_the_grove_sublabel'] = '{npc:86259}, {npc:86258}, and {npc:86257} form the {npc:Protectors of the Grove}.'

L['prove_your_strength_note'] = 'Requires {spell:164012} garrison ability to be active. To enable {location:The Sparring Arena} visit your faction outpost.'
L['prove_your_strength_drop_single'] = 'Dropped by %s.'
L['prove_your_strength_drop_double'] = 'Dropped by %s or %s.'

L['tormmok_follower_note'] = 'First appears as ' .. '|cFFFF0000Hostile|r' .. '. Assist with killing waves of mobs until you defeat {npc:83871}. When he appears ' .. '|cFF00FF00Friendly|r' .. ' talk to him to recruit him as a follower.'
L['blook_follower_note'] = 'Talk to him, fight him, beat him, then talk to him again to recruit him as a follower'

L['options_icons_attack_plans'] = '{achievement:9656}'
L['options_icons_attack_plans_desc'] = 'Display the locations of {object:Iron Horde Attack Orders} for {achievement:9656} achievement.'
L['options_icons_ancient_no_more'] = '{achievement:9678}'
L['options_icons_ancient_no_more_desc'] = 'Display rare locations for {achievement:9678} achievement.'
L['options_icons_fight_the_power'] = '{achievement:9655}'
L['options_icons_fight_the_power_desc'] = 'Display rare locations for {achievement:9655} achievement.'
L['options_icons_prove_your_strength'] = '{achievement:9402}'
L['options_icons_prove_your_strength_desc'] = 'Display drop locations for {achievement:9402} achievement.'

-------------------------------------------------------------------------------
------------------------------------ NAGRAND ----------------------------------
-------------------------------------------------------------------------------

L['fangler_note'] = 'Use the fishing rod.'
L['berserk_t_300_series_mark_ii_note'] = 'Use the switch.'
L['graveltooth_note'] = 'Kill {npc:84255} until {npc:84263} spawns.'
L['gorepetal_note'] = 'In a cave.\n\nDoes not show up on the minimap. Click on the {object:Pristine Lily} to spawn {npc:83509}.'
L['sean_whitesea_note'] = 'Open the {object:Abandoned Chest} so that {npc:83542} appears.'

L['a_pile_of_dirt_treasure'] = 'A Pile of Dirt'
L['abandoned_cargo_treasure'] = 'Abandoned Cargo'
L['adventurers_mace_treasure'] = 'Adventurer\'s Mace'
L['adventurers_pack_treasure'] = 'Adventurer\'s Pack'
L['adventurers_pouch_treasure'] = 'Adventurer\'s Pouch'
L['adventurers_sack_treasure'] = 'Adventurer\'s Sack'
L['adventurers_staff_treasure'] = 'Adventurer\'s Staff'
L['appropriated_warsong_supplies_treasure'] = 'Appropriated Warsong Supplies'
L['bag_of_herbs_treasure'] = 'Bag of Herbs'
L['bone_carved_dagger_treasure'] = 'Bone-Carved Dagger'
L['bounty_of_the_elements_note'] = 'Click the Totems in the following order:\n 1. {npc:84307}\n 2. {npc:84343}\n 3. {npc:84345}\n 4. {npc:84347}'
L['bounty_of_the_elements_treasure'] = 'Bounty of the Elements'
L['brilliant_dreampetal_treasure'] = 'Brilliant Dreampetal'
L['elemental_offering_treasure'] = 'Elemental Offering'
L['elemental_shackles_treasure'] = 'Elemental Shackles'
L['fragment_of_oshugun_treasure'] = 'Fragment of Oshu\'gun'
L['freshwater_clam_treasure'] = 'Freshwater Clam'
L['fungus_covered_chest_treasure'] = 'Fungus-Covered Chest'
L['gamblers_purse_treasure'] = 'Gambler\'s Purse'
L['genedar_debris_treasure'] = 'Genedar Debris'
L['goblin_pack_treasure'] = 'Goblin Pack'
L['golden_kaliri_egg_treasure'] = 'Golden Kaliri Egg'
L['goldtoes_plunder_note'] = 'Parrot has the key'
L['goldtoes_plunder_treasure'] = 'Goldtoe\'s Plunder'
L['grizzlemaws_bonepile_treasure'] = 'Grizzlemaw\'s Bonepile'
L['hidden_stash_treasure'] = 'Hidden Stash'
L['highmaul_sledge_treasure'] = 'Highmaul Sledge'
L['important_exploration_supplies_treasure'] = 'Important Exploration Supplies'
L['lost_pendant_treasure'] = 'Lost Pendant'
L['mountain_climbers_pack_treasure'] = 'Mountain Climber\'s Pack'
L['ogre_beads_treasure'] = 'Ogre Beads'
L['pale_elixir_treasure'] = 'Pale Elixir'
L['pokkars_thirteenth_axe_treasure'] = 'Pokkar\'s Thirteenth Axe'
L['polished_saberon_skull_treasure'] = 'Polished Saberon Skull'
L['saberon_stash_treasure'] = 'Saberon Stash'
L['smugglers_cache_note'] = 'Dodge the tripwires'
L['smugglers_cache_treasure'] = 'Smuggler\'s Cache'
L['steamwheedle_supplies_treasure'] = 'Steamwheedle Supplies'
L['telaar_defender_shield_treasure'] = 'Telaar Defender Shield'
L['treasure_of_kullkrosh_treasure'] = 'Treasure of Kull\'krosh'
L['void_infused_crystal_treasure'] = 'Void-Infused Crystal'
L['warsong_cache_treasure'] = 'Warsong Cache'
L['warsong_helm_treasure'] = 'Warsong Helm'
L['warsong_lockbox_treasure'] = 'Warsong Lockbox'
L['warsong_spear_treasure'] = 'Warsong Spear'
L['warsong_spoils_treasure'] = 'Warsong Spoils'
L['warsong_supplies_treasure'] = 'Warsong Supplies'
L['watertight_bag_treasure'] = 'Watertight Bag'
L['spirit_coffer_treasure'] = 'Spirit Coffer'
L['spirits_gift_treasure'] = 'Spirit\'s Gift'
L['spirits_gift_treasure_note'] = 'Light all 6 forgotten braziers to make the treasure appear.'

L['viking_pepe_note'] = 'Sitting on a crate behind some goblins with a Disco Ball'
L['viking_pepe_treasure'] = 'Viking Pepe'

L['highmaul_farm_path'] = [[
Farming Path
1. Start at the front gate and go right into {location:The Underbelly}.
2. Go left through the gladiator pit area. Be sure to tag the ogre overlooking on the upper left.
3. Continue up the stairs and past the pond with the {npc:87227}.
4. Turn left and up into the {location:Path of Victors}.
5. Go up to the fork in the path. Be sure to tag the ogre to the right.
6. Turn left into {location:The Market District} and clear the entire thing out moving counterclockwise.
7. Go left into {location:The Imperator's Favor}, continue following the path and clear it all.
8. To Left again, down the path, and back into {location:The Path of Victors}.
9. Mount up and fly up, over, and into {location:The Coliseum}. Don't try to use the front door, it's locked.

Fly out to the right and back to the front gate. One single run takes just under 4 minutes and by the time you're back at the front gate everything will have already respawned.
]]

L['steamwheedle_note'] = 'Farm {item:118099} and {item:118100} from {npc:87223} and {npc:87222} around {location:Highmaul}. Turn items into {npc:87393} for reputation.'

L['finding_your_waystones_label'] = '{achievement:9497}'
L['finding_your_waystones_note'] = 'Farm {item:117491} from {npc:87223} and {npc:87222} around {location:Highmaul}'
L['ogre_waystones'] = 'ogre waystones looted'

L['signal_horn_note'] = 'Obtain {item:120290} from nearby {npc:86658} then use the {npc:87361} to summon {npc:87239} and {npc:87344}.'

L['garroshs_shackles'] = 'Inside hut'
L['warsong_relics'] = 'Against a fence outside a hut'
L['stolen_draenei_tome'] = 'Can spawn in multiple locations on top of towers'
L['dirt_mound'] = 'Kill {npc:86659} to spawn a {npc:87280} on the floor nearby. Click the totem to receive {spell:174572}. You can now dig up nearby {npc:87530} to find items.'

L['stable_master_note'] = 'Talk to {npc:Stablemaster} to receive a mount-in-training whistle.\n\n{item:119441}\n{item:119442}\n{item:119443}\n{item:119444}\n{item:119445}\n{item:119446}\n\nUse the whistle to summon your mount-in-training and kill the target.\n\n{achievement:9539} achievement requires {item:118469} from a {location:Level 2 Stables}.\n{achievement:9540} achievement requires {item:118470} from a {location:Level 3 Stables}.'

L['making_the_cut_note'] = 'While {npc:88210} is available kill 15 {npc:88207} around {location:The Ring of Blood}. Once 15 have been killed {npc:88210} will become targetable.\n\n{yell:Not bad for a bunch of worthless pukes! Come face Krud when you ready to die!}'

L['goldmane_follower_note'] = 'Kill {npc:80080} nearby to loot {item:111863} and unlock the cage to recruit {npc:80083} as a follower'
L['abugar_follower_note'] = [[
Deliver 3 fishing items found around {location:Nagrand} and then speak to him to recruit him as a follower.

{item:114245}
{item:114242}
{item:114243}

You can gather the items before going to him.
]]

L['options_icons_broke_back_precipice'] = '{achievement:9571}'
L['options_icons_broke_back_precipice_desc'] = 'Display rare locations for {achievement:9571} achievement.'
L['options_icons_steamwheedle'] = '{achievement:9472}'
L['options_icons_steamwheedle_desc'] = 'Display farm location for {achievement:9472} achievement.'
L['options_icons_finding_your_waystones'] = '{achievement:9497}'
L['options_icons_finding_your_waystones_desc'] = 'Display farm location for {achievement:9497} achievement.'
L['options_icons_song_of_silence'] = '{achievement:9541}'
L['options_icons_song_of_silence_desc'] = 'Display rare locations for {achievement:9541} achievement.'
L['options_icons_buried_treasures'] = '{achievement:9548}'
L['options_icons_buried_treasures_desc'] = 'Display item locations for {achievement:9548} achievement.'
L['options_icons_the_stable_master'] = '{achievement:9539} and {achievement:9540}'
L['options_icons_the_stable_master_desc'] = 'Display target locations for {achievement:9539} and {achievement:9540} achievements.'
L['options_icons_making_the_cut'] = '{achievement:9617}'
L['options_icons_making_the_cut_desc'] = 'Display {npc:88207} locations for {achievement:9617} achievement.'

-------------------------------------------------------------------------------
------------------------------ SHADOWMOON VALLEY ------------------------------
-------------------------------------------------------------------------------

L['voidseer_kalurg_note'] = 'Kill all {npc:78135}.'

L['alchemists_satchel_treasure'] = 'Alchemist\'s Satchel'
L['ancestral_greataxe_treasure'] = 'Ancestral Greataxe'
L['armored_elekk_tusk_treasure'] = 'Armored Elekk Tusk'
L['astrologers_box_treasure'] = 'Astrologer\'s Box'
L['beloveds_offering_treasure'] = 'Beloved\'s Offering'
L['bubbling_cauldron_treasure'] = 'Bubbling Cauldron'
L['cargo_of_the_raven_queen_treasure'] = 'Cargo of the Raven Queen'
L['carved_drinking_horn_treasure'] = 'Carved Drinking Horn'
L['demonic_cache_treasure'] = 'Demonic Cache'
L['dusty_lockbox_treasure'] = 'Dusty Lockbox'
L['false_bottomed_jar_treasure'] = 'False-Bottomed Jar'
L['fantastic_fish_treasure'] = 'Fantastic Fish'
L['giant_moonwillow_cone_treasure'] = 'Giant Moonwillow Cone'
L['glowing_cave_mushroom_treasure'] = 'Glowing Cave Mushroom'
L['grekas_urn_treasure'] = 'Greka\'s Urn'
L['hanging_satchel_treasure'] = 'Hanging Satchel'
L['iron_horde_cargo_shipment_treasure'] = 'Iron Horde Cargo Shipment'
L['iron_horde_tribute_treasure'] = 'Iron Horde Tribute'
L['kaliri_egg_treasure'] = 'Kaliri Egg'
L['lunarfall_egg_note'] = 'Moves to your garrison once built.'
L['lunarfall_egg_treasure'] = 'Lunarfall Egg'
L['mikkals_chest_treasure'] = 'Mikkal\'s Chest'
L['mushroom_covered_chest_treasure'] = 'Mushroom-Covered Chest'
L['orc_skeleton_treasure'] = 'Orc Skeleton'
L['peaceful_offering_treasure'] = 'Peaceful Offering'
L['ronokks_belongings_treasure'] = 'Ronokk\'s Belongings'
L['rotting_basket_treasure'] = 'Rotting Basket'
L['rovos_dagger_treasure'] = 'Rovo\'s Dagger'
L['scaly_rylak_egg_treasure'] = 'Scaly Rylak Egg'
L['shadowmoon_exile_treasure_note'] = 'In a cave below {location:Exile\'s Rise}'
L['shadowmoon_exile_treasure_treasure'] = 'Shadowmoon Exile Treasure'
L['shadowmoon_sacrificial_dagger_treasure'] = 'Shadowmoon Sacrificial Dagger'
L['shadowmoon_treasure_treasure'] = 'Shadowmoon Treasure'
L['stolen_treasure_treasure'] = 'Stolen Treasure'
L['sunken_fishing_boat_treasure'] = 'Sunken Fishing Boat'
L['swamplighter_hive_treasure'] = 'Swamplighter Hive'
L['uzkos_knickknacks_treasure'] = 'Uzko\'s Knickknacks'
L['veemas_herb_bag_treasure'] = 'Veema\'s Herb Bag'
L['vindicators_cache_treasure'] = 'Vindicator\'s Cache'
L['waterlogged_chest_treasure'] = 'Waterlogged Chest'

L['you_have_been_rylakinated_note'] = 'Must complete {quest:34355}.\n\nCollect {item:116978} from {npc:78999} nearby to control {npc:86085}.'

L['artificer_romuul_follower_note'] = 'Complete the crystal defense event to recruit him as a follower'

L['options_icons_you_have_been_rylakinated'] = '{achievement:9481}'
L['options_icons_you_have_been_rylakinated_desc'] = 'Display {npc:85357} locations for {achievement:9481} achievement.'

-------------------------------------------------------------------------------
------------------------------- SPIRES OF ARAK --------------------------------
-------------------------------------------------------------------------------

L['abandoned_mining_pick_treasure'] = 'Abandoned Mining Pick'
L['admiral_taylors_coffer_note'] = 'Use the {item:116020} to unlock {object:Admiral Taylor\'s Coffer} in {location:Admiral Taylor\'s Garrison Town Hall}'
L['admiral_taylors_coffer_treasure'] = 'Admiral Taylor\'s Coffer'
L['assassins_spear_treasure'] = 'Assassin\'s Spear'
L['campaign_contributions_treasure'] = 'Campaign Contributions'
L['coinbenders_payment_treasure'] = 'Coinbender\'s Payment'
L['coinbenders_payment_treasure_note'] = 'At the bottom of the sea.'
L['egg_of_varasha_treasure'] = 'Egg of Varasha'
L['ephials_dark_grimoire_treasure'] = 'Ephial\'s Dark Grimoire'
L['fractured_sunstone_note'] = 'Hidden in the water'
L['fractured_sunstone_treasure'] = 'Fractured Sunstone'
L['garrison_supplies_treasure'] = 'Garrison Supplies'
L['garrison_workmans_hammer_treasure'] = 'Garrison Workman\'s Hammer'
L['iron_horde_explosives_treasure'] = 'Iron Horde Explosives'
L['lost_herb_satchel_treasure'] = 'Lost Herb Satchel'
L['lost_ring_treasure'] = 'Lost Ring'
L['mysterious_mushrooms_treasure'] = 'Mysterious Mushrooms'
L['ogron_plunder_treasure'] = 'Ogron Plunder'
L['orcish_signaling_horn_treasure'] = 'Orcish Signaling Horn'
L['outcasts_belongings_treasure'] = 'Outcast\'s Belongings'
L['outcasts_pouch_treasure'] = 'Outcast\'s Pouch'
L['rooby_roos_ruby_collar_note'] = 'Buy 3 {item:114835} from {npc:82432} in the basement of {location:The Briny Barnacle}. Follow and feed {npc:84332} until he leaves a "treasure" on the floor.'
L['rooby_roos_ruby_rollar_treasure'] = 'Rooby\'s Roo'
L['rukhmars_image_treasure'] = 'Rukhmar\'s Image'
L['sailor_zazzuks_180_proof_rum_note'] = 'In the control room'
L['sailor_zazzuks_180_proof_rum_treasure'] = 'Sailor Zazzuk\'s 180-Proof Rum'
L['sethekk_idol_treasure'] = 'Sethekk Idol'
L['sethekk_ritual_brew_treasure'] = 'Sethekk Ritual Brew'
L['shattered_hand_cache_treasure'] = 'Shattered Hand Cache'
L['shattered_hand_lockbox_treasure'] = 'Shattered Hand Lockbox'
L['shredder_parts_treasure'] = 'Shredder Parts'
L['spray_o_matic_5000_xt_treasure'] = 'Spray-O-Matic 5000 XT'
L['sun_touched_cache_treasure'] = 'Sun-Touched Cache'
L['toxicfang_venom_treasure'] = 'Toxicfang Venom'
L['waterlogged_satchel_treasure'] = 'Waterlogged Satchel'
L['nizzixs_chest_treasure'] = 'Nizzix\'s Chest'
L['nizzixs_chest_treasure_note'] = 'Click on the {object:Escape Pod} floating nearby in the water.'

L['misplaced_scroll_treasure'] = 'Misplaced Scroll'
L['relics_of_the_outcasts_treasure'] = 'Relics of the Outcasts'
L['smuggled_apexis_artifacts_treasure'] = 'Smuggled Apexis Artifacts'

L['offering_to_the_raven_mother_treasure'] = 'Offering to the Raven Mother'

L['elixir_of_shadow_sight_treasure'] = 'Elixir of Shadow Sight'
L['elixir_pre_note'] = 'Take to a {object:Shrine to Terokk}.'
L['elixir_01_note'] = 'Next to a small hut in a hanging basket.'
L['elixir_02_note'] = 'In a basket within the back of a burning hut.'
L['elixir_03_note'] = 'Within a basket between a tree and a broken wall.'
L['elixir_04_note'] = 'Inside a Saberon cave.'
L['elixir_05_note'] = 'Up the mountain, next to the dead body of a {npc:83633}. After you go up the large mountain path, look for another {npc:83633} hanging from chains between two trees. The elixir is behind the hills, next to the tree on the right.'
L['elixir_06_note'] = 'In the water, at the end of a smaller, broken wall.'

L['gift_of_anzu_treasure'] = 'Gift of Anzu'

L['pirate_pepe_note'] = 'Sitting on a rock at the base on the inside of the rock wall'
L['pirate_pepe_treasure'] = 'Pirate Pepe'

L['forbidden_tome_note'] = [[
Requires {quest:36682} daily quest to be active or use {item:122409}.

Interact with {npc:85992} to randomly receive one of three buffs.

{spell:171783}
{spell:171787}
{spell:171768}
]]

L['leorajh_follower_note'] = 'Talk to him to recruit him as a follower.'

L['options_icons_archaeology_treasure'] = 'Archaeology Treasures'
L['options_icons_archaeology_treasure_desc'] = 'Display locations for archaeology treasures.'
L['options_icons_offering'] = 'Offering to the Raven Mother'
L['options_icons_offering_desc'] = 'Display item locations of {object:Offering to the Raven Mother}.'
L['options_icons_shrines_of_terokk'] = 'Shrines of Terokk'
L['options_icons_shrines_of_terokk_desc'] = 'Display locations for {object:Shrines of Terokk}.'
L['options_icons_would_you_like_a_pamplet'] = '{achievement:9432}'
L['options_icons_would_you_like_a_pamplet_desc'] = 'Display item locations for {achievement:9432} achievement.'
L['options_icons_king_of_the_monsters'] = '{achievement:9601}'
L['options_icons_king_of_the_monsters_desc'] = 'Display rare locations for {achievement:9601} achievement.'

-------------------------------------------------------------------------------
------------------------------------ TALADOR ----------------------------------
-------------------------------------------------------------------------------

L['wandering_vindicator_note'] = 'After defeating him, you need to loot his sword from the stone.'
L['legion_vanguard_note'] = '{npc:88494} is summoned from portal. Kill {npc:83023} around portal and any other, that comes out to summon him.'
L['taladorantula_note'] = 'Squish eggs sacks and kill {npc:75258} around to summon {npc:77634}. Takes around 3 to 5 minutes of squishing.'
L['shirzir_note'] = 'In underground tomb.'
L['kharazos_galzomar_sikthiss_note'] = '{npc:78710}, {npc:78713} and {npc:78715} share the same drop, spawn and path.'
L['orumo_the_observer_note'] = [[
{npc:87668} requires 5 people standing on runes before him to be able to kill him.

Alternatively, Warlocks can use {spell:48020} and Monks {spell:119996} to teleport on runes, which decreases number of required people to 3.

Another option is to use 5 of your own characters, move them one by one to runes and logout them there.

Last option is to use only one character. Go to rune, lit it up, teleport out and repeat for each rune. Best way is to set up {item:6948} somewhere close.

You can combine any of methods above to summon {npc:87668}.
]]

L['aarkos_family_treasure_treasure'] = 'Aarko\'s Family Treasure'
L['aarkos_family_treasure_treasure_note'] = 'Speak to {npc:77664} some enemies will appear. After you killed {npc:77677} the treasure will appear.'
L['amethyl_crystal_treasure'] = 'Amethyl Crystal'
L['aruuna_mining_cart_treasure'] = 'Aruuna Mining Cart'
L['barrel_of_fish_treasure'] = 'Barrel of Fish'
L['bonechewer_remnants_treasure'] = 'Bonechewer Remnants'
L['bonechewer_spear_treasure'] = 'Bonechewer Spear'
L['bright_coin_treasure'] = 'Bright Coin'
L['charred_sword_treasure'] = 'Charred Sword'
L['curious_deathweb_egg_treasure'] = 'Curious Deathweb Egg'
L['deceptias_smoldering_boots_treasure'] = 'Deceptia\'s Smoldering Boots'
L['draenei_weapons_treasure'] = 'Draenei Weapons'
L['farmers_bounty_treasure'] = 'Farmer\'s Bounty'
L['foremans_lunchbox_treasure'] = 'Foreman\'s Lunchbox'
L['iron_box_treasure'] = 'Iron Box'
L['isaaris_cache_note'] = 'Rescue 4 draenei trapped in spider webs, then {object:Isaari\'s Cache} will spawn here'
L['isarris_cache_treasure'] = 'Isaari\'s Cache'
L['jug_of_aged_ironwine_treasure'] = 'Jug of Aged Ironwine'
L['keluus_belongings_treasure'] = 'Keluu\'s Belongings'
L['ketyas_stash_treasure'] = 'Ketya\'s Stash'
L['light_of_the_sea_treasure'] = 'Light of the Sea'
L['lightbearer_treasure'] = 'Lightbearer'
L['luminous_shell_treasure'] = 'Luminous Shell'
L['noranas_cache_note'] = 'Rescue 4 adventurers trapped in spider webs, then {object:Norana\'s Cache} will spawn here'
L['noranas_cache_treasure'] = 'Norana\'s Cache'
L['pure_crystal_dust_note'] = 'Upper level of the mine'
L['pure_crystal_dust_treasure'] = 'Pure Crystal Dust'
L['relic_of_aruuna_treasure'] = 'Relic of Aruuna'
L['relic_of_telmor_treasure'] = 'Relic of Telmor'
L['rooks_tacklebox_treasure'] = 'Rook\'s Tacklebox'
L['rusted_lockbox_treasure'] = 'Rusted Lockbox'
L['rusted_lockbox_treasure_note'] = 'In a cave.\nWay down in the water.'
L['soulbinders_reliquary_treasure'] = 'Soulbinder\'s Reliquary'
L['teroclaw_nest_treasure'] = 'Teroclaw Nest'
L['treasure_of_angorosh_treasure'] = 'Treasure of Ango\'rosh'
L['webbed_sac_treasure'] = 'Webbed Sac'
L['yuuris_gift_treasure'] = 'Yuuri\'s Gift'
L['gift_of_the_ancients_treasure'] = 'Gift of the Ancients'
L['gift_of_the_ancients_treasure_note'] = 'In a cave.\n\nTurn the statues so that all three are facing the center.'

L['knight_pepe_treasure'] = 'Knight Pepe'
L['knight_pepe_note'] = 'Sitting in the tent sitting on a chest'

L['wingmen_note'] = 'Kill the endless streams of {npc:78433}, {npc:76883}, and {npc:78432} for 10 reputation each.\n\nLarge demons such as {npc:78715} and {npc:78713} do not provide additional reputation.'
L['fel_portal'] = 'Fel Portal'

L['aeda_brightdawn_follower_note'] = 'Complete {quest:34776} to recruit her as a follower.'
L['ahm_follower_note'] = 'Complete {quest:33973} then meet him at your garrison to recruit him as a follower.'
L['defender_illona_follower_note'] = 'Complete {quest:34777} to recruit her as a follower.'
L['pleasure_bot_8000_follower_note'] = 'Complete {quest:34761} to recruit it as a follower.'
L['image_of_archmage_vargoth_follower_note'] = [[
Find 4 mysterious objects around {location:Draenor}.

{quest:34463} is found in {location:Gorgrond}
{quest:34464} is found in {location:Frostfire Ridge}
{quest:34465} is found in {location:Talador}
{quest:34466} is found in {location:Nagrand}

Turn each quest into {npc:86949} at {location:Khadgar's Tower} in {location:Talador} who will then have {quest:34472}. Complete the quest and then speak to {npc:77853} to recruit him as a follower.
]]

L['options_icons_cut_off_the_head'] = '{achievement:9633}'
L['options_icons_cut_off_the_head_desc'] = 'Display rare locations for {achievement:9633} achievement.'
L['options_icons_wingmen'] = '{achievement:9499}'
L['options_icons_wingmen_desc'] = 'Display farm locations for {achievement:9499} achievement.'

-------------------------------------------------------------------------------
--------------------------------- TANAAN JUNGLE -------------------------------
-------------------------------------------------------------------------------

L['deathtalon_note'] = '{yell:Shadow Lord Iskar yells: Behind the veil, all you find is death!}'
L['doomroller_note'] = '{yell:Siegemaster Mar\'tak yells: Hah-ha! Trample their corpses!}'
L['terrorfist_note'] = '{yell:Frogan yells: A massive gronnling is heading for Rangari Refuge! We are going to require some assistance!}'
L['vengeance_note'] = '{yell:Tyrant Velhari yells: Insects deserve to be crushed!}'
L['iron_armada_note'] = 'This toy is also buyable on AH and is required for {achievement:10353} achievement.'
L['commander_kraggoth_note'] = 'At the top of the north-east tower.'
L['grannok_note'] = 'At the top of the south-east tower.'
L['szirek_the_twisted_note'] = 'Capture the East Strongpoint to summon this rare.'
L['the_iron_houndmaster_note'] = 'Capture the West Strongpoint to summon this rare.'
L['belgork_thromma_note'] = 'This cave has 2 entrances.'
L['driss_vile_note'] = 'On top of the tower.'
L['overlord_magruth_note'] = 'Kill orcs around camp to spawn it.'
L['mistress_thavra_note'] = 'In a cave on upper floor.'
L['dorg_the_bloody_note'] = 'Kill {npc:89706} and other enemies at spawn location.'
L['grand_warlock_netherkurse_note'] = 'Kill enemies around spawn point.'
L['ceraxas_note'] = 'Spawns {npc:90426} with quest {quest:38428} for pet after killing it.'
L['commander_orgmok_note'] = 'Rides around on {npc:89676}.'
L['rendrak_note'] = 'Collect 10 {item:124045} from {npc:89788} around bog. Combine them to summon rare.'
L['akrrilo_note'] = 'Buy {item:124093} from {npc:92805} and use it at {location:Blackfang Challenge Arena}.'
L['rendarr_note'] = 'Buy {item:124094} from {npc:92805} and use it at {location:Blackfang Challenge Arena}.'
L['eyepiercer_note'] = 'Buy {item:124095} from {npc:92805} and use it at {location:Blackfang Challenge Arena}.'
L['the_night_haunter_note'] = [[
Collect 10 stacks of {spell:183612} debuff.

You can get debuff by using {npc:92651} or by finding {npc:92645} (100% chance).
]]
L['xemirkol_note'] = [[
Buy {item:128502} or {item:128503} from {npc:95424} and use it at spawn point to get teleported to {npc:96235}.

Crystals teleport you to random rare in vicinity, so best chance is to kill {npc:92887} and use {item:128502}.

{npc:96235} has long respawn timer (around a day) and best way to get it is after realm restart or by using server jump.
]]
L['cindral_note'] = 'Inside the Building.\nKill all {npc:90522} to make {npc:90519} appear.'

L['axe_of_the_weeping_wolf_treasure'] = 'Axe of the Weeping Wolf'
L['bejeweled_egg_treasure'] = 'Bejeweled Egg'
L['blackfang_island_cache_treasure'] = 'Blackfang Island Cache'
L['bleeding_hollow_mushroom_stash_treasure'] = 'Bleeding Hollow Mushroom Stash'
L['bleeding_hollow_warchest_treasure'] = 'Bleeding Hollow Warchest'
L['book_of_zyzzix_treasure'] = 'Book of Zyzzix'
L['borrowed_enchanted_spyglass_treasure'] = '\'Borrowed\' Enchanted Spyglass'
L['brazier_of_awakening_treasure'] = 'Brazier of Awakening'
L['censer_of_torment_treasure'] = 'Censer of Torment'
L['crystallized_essence_of_the_elements_treasure'] = 'Crystallized Essence of the Elements'
L['crystallized_fel_spike_treasure'] = 'Crystallized Fel Spike'
L['dazzling_rod_treasure'] = 'Dazzling Rod'
L['dead_mans_chest_treasure'] = 'Dead Man\'s Chest'
L['discarded_helm_treasure'] = 'Discarded Helm'
L['fel_drenched_satchel_treasure'] = 'Fel-Drenched Satchel'
L['fel_tainted_apexis_formation_treasure'] = 'Fel-Tainted Apexis Formation'
L['forgotten_champions_blade_treasure'] = 'Forgotten Champion\'s Blade'
L['forgotten_iron_horde_supplies_treasure'] = 'Forgotten Iron Horde Supplies'
L['forgotten_sack_treasure'] = 'Forgotten Sack'
L['forgotten_shard_of_the_cipher_treasure'] = 'Forgotten Shard of the Cipher'
L['ironbeards_treasure_treasure'] = 'Ironbeard\'s Treasure'
L['jewel_of_hellfire_treasure'] = 'Jewel of Hellfire'
L['jewel_of_the_fallen_star_treasure'] = 'Jewel of the Fallen Star'
L['jeweled_arakkoa_effigy_treasure'] = 'Jeweled Arakkoa Effigy'
L['lodged_hunting_spear_treasure'] = 'Lodged Hunting Spear'
L['looted_bleeding_hollow_treasure_treasure'] = 'Looted Bleeding Hollow Treasure'
L['looted_mystical_staff_treasure'] = 'Looted Mystical Staff'
L['mysterious_corrupted_obelist_treasure'] = 'Mysterious Corrupted Obelisk'
L['overgrown_relic_treasure'] = 'Overgrown Relic'
L['pale_removal_equipment_treasure'] = 'Pale Removal Equipment'
L['partially_mined_apexis_crystal_treasure'] = 'Partially Mined Apexis Crystal'
L['polished_crystal_treasure'] = 'Polished Crystal'
L['rune_etched_femur_treasure'] = 'Rune Etched Femur'
L['sacrificial_blade_treasure'] = 'Sacrificial Blade'
L['scouts_belongings_treasure'] = 'Scout\'s Belongings'
L['skull_of_the_mad_chief_treasure'] = 'Skull of the Mad Chief'
L['snake_charmers_flute_treasure'] = 'Snake Charmer\'s Flute'
L['spoils_of_war_note'] = 'Inside the hut.'
L['spoils_of_war_treasure'] = 'Spoils of War'
L['stashed_bleeding_hollow_loot_treasure'] = 'Stashed Bleeding Hollow Loot'
L['stashed_iron_sea_booty_treasure'] = 'Stashed Iron Sea Booty'
L['stolen_captains_chest_treasure'] = 'Stolen Captain\'s Chest'
L['strange_fruit_note'] = '{item:127396} incubates in 14 days into {item:127394}.'
L['strange_fruit_treasure'] = 'Strange Fruit'
L['strange_sapphire_treasure'] = 'Strange Sapphire'
L['the_blade_of_kranak_treasure'] = 'The Blade of Kra\'nak'
L['the_commanders_shield_note'] = 'Inside building.'
L['the_commanders_shield_treasure'] = 'The Commander\'s Shield'
L['the_eye_of_grannok_note'] = 'On the second floor of tower near the stairs.'
L['the_eye_of_grannok_treasure'] = 'The Eye of Grannok'
L['the_perfect_blossom_treasure'] = 'The Perfect Blossom'
L['tome_of_secrets_treasure'] = 'Tome of Secrets'
L['tower_chest_note'] = 'At the top of a tower.'
L['weathered_axe_treasure'] = 'Weathered Axe'

--LEG
-------------------------------------------------------------------------------
------------------------------- ANTORAN WASTES --------------------------------
-------------------------------------------------------------------------------

L['commander_texlaz_note'] = 'No longer requires {quest:48831} world quest to be active. Take the green portal.'
L['doomcaster_suprax_note'] = 'No longer requires three players. Simply step on a rune to summon {npc:127703}.'
L['mother_rosula_note'] = 'Collect 100 {item:152999} from {npc:126073} and combine them to make a {item:153013}. Use the {item:153013} on her fel pool.'
L['reziera_the_seer_note'] = 'While buffed with {spell:254174} collect 500 {item:153021} to purchase {item:153226} from {npc:128134}. Use the {item:153226} to send you (and your party) to {npc:127706}.'
L['squadron_commander_vishax_note'] = 'Collect {item:152890} from {npc:127598}.\n\nCollect {item:152941}, {item:152940}, and {item:152891} from {npc:127597} and {npc:127596}.\n\nUse {item:152890} to get {quest:49007}.\n\n{note:This quest is sharable.}'
L['ven_orn_note'] = 'Enter the cave of spiders, take a right, and go down into another small cave. She is in this 2nd chamber at the rear.'

L['the_many_faced_devourer_note'] = 'Collect {item:152786} from {npc:126193} and {npc:126171} in {location:Scavenger\'s Boneyard}.\n\nCollect {item:152991}, {item:152992}, and {item:152993}.\n\nSummon {npc:127581} at the {npc:127442}.\n\n{note:If you can\'t see the {npc:127442} you may need to relog.}'
L['the_many_faced_devourer_checklist'] = '|cFFFFD700Item Checklist (in bags or bank):|r'

L['orix_the_all_seer_note'] = 'Sells collectibles in exchange for {item:153021}.'

L['legion_war_supplies'] = 'Legion War Supplies'
L['legion_war_supplies_note'] = 'There are 9 unique {object:Legion War Supplies} that can each appear at set locations.'

L['options_icons_legion_war_supplies'] = 'Legion War Supplies'
L['options_icons_legion_war_supplies_desc'] = 'Display possible locations for {object:Legion War Supplies} (daily chests).'

-------------------------------------------------------------------------------
------------------------------------ ARGUS ------------------------------------
-------------------------------------------------------------------------------

L['drops_fel_spotted_egg'] = 'Drops {item:153190}'
L['fel_spotted_egg_contains'] = '{item:153190} can contain'

L['goblin_glider_treasure_note'] = 'Use {item:109076} to glide to the treasure.'
L['lightforged_warframe_treasure_note'] = 'Activate {item:152098} at the {npc:121365} aboard the {npc:126426}.\n\nUse {item:152098} and {spell:250434} to melt the rocks and find the treasure.'
L['lights_judgement_treasure_note'] = 'Activate {item:151830} at the {npc:121365} aboard the {npc:126426}.\n\nUse {item:151830} to explode the rocks and find the treasure.'
L['shroud_of_arcane_echoes_treasures_note'] = 'Activate {item:151912} at the {npc:121365} aboard the {npc:126426}.\n\nUse {item:151912} unlock the treasure.\n\n{note:"Will only open to one wielding the power that echoes that of the Augari."}'

-------------------------------------------------------------------------------
----------------------------------- AZSUNA ------------------------------------
-------------------------------------------------------------------------------

L['arcavellus_note'] = 'Kill {npc:90242s} and {npc:90243s} until the rare appears.'
L['beacher_note'] = 'Not available when the {wq:Helarjar Landing: Grey Shoals} world quest is active.'
L['brogozog_note'] = 'Speak with {npc:91097}.'
L['chief_bitterbrine_note'] = 'In the ship on the lower deck.'
L['devious_sunrunner_note'] = 'Use the {object:Ley Portal} in a small cave. Don\'t forget to loot the chest.'
L['doomlord_kazrok_note'] = 'Speak with {npc:91580}.'
L['felwing_note'] = 'Speak with {npc:105913} and then kill {npc:105919s} until the rare appears.'
L['golza_note'] = 'Blow the {object:Horn of the Siren}, then kill {npc:90774s} and {npc:90778s} until the rare appears.'
L['infernal_lord_note'] = 'Click the {object:Cache of Infernals} and kill {npc:90797s} until the rare appears.'
L['inquisitor_tivos_note'] = 'Use the {object:Legion Portal}. He is on a lower floor.'
L['shaliman_note'] = 'Walks around the pool.'

L['disputed_treasure'] = 'Disputed Treasure'
L['in_academy'] = 'Inside {location:Nar\'thalas Academy}.'
L['in_oceanus_cove'] = 'Inside the {location:Oceanus Cove}.'
L['seemingly_unguarded_treasure'] = 'Seemingly Unguarded Treasure'
L['seemingly_unguarded_treasure_note'] = 'Try to loot the {object:Seemingly Unguarded Treasure} and then kill a few waves of {npc:94167s}.'
L['treasure_37958'] = 'On a lower level of the building.'
L['treasure_37980'] = 'Use the {object:Ley Portal} on the broken bridge.'
L['treasure_40711'] = 'Use the {object:Ley Portal} inside the tower.'
L['treasure_42282'] = 'On the balcony in a corner.'
L['treasure_42283'] = 'On the second floor.'
L['treasure_42287'] = 'Under water.'
L['treasure_42339'] = 'Don\'t wake up the bears.'

L['nightwatcher_merayl_note'] = 'Formations!'

L['book_1'] = 'Book 1 (Sunday)'
L['book_2'] = 'Book 2 (Monday)'
L['book_3'] = 'Book 3 (Tuesday)'
L['book_4'] = 'Book 4 (Wednesday)'
L['book_5'] = 'Book 5 (Thursday)'
L['book_6'] = 'Book 6 (Friday)'
L['book_7'] = 'Book 7 (Saturday)'

L['higher_dimensional_learning_location'] = 'Located at the top of the tower.'
L['higher_dimensional_learning_note'] = 'Purchase {item:129276} from {npc:107376} at {location:Crumbled Palace}. Use {item:129276} each day to be teleported to a different book location.\n\nBook 1: Sunday\nBook 2: Monday\nBook 3: Tuesday\nBook 4: Wednesday\nBook 5: Thursday\nBook 6: Friday\nBook 7: Saturday'
L['higher_dimensional_learning_disclaimer'] = '{note:Teleporting to a book location does not guarentee the book will spawn. You may need to wait or check back later.}'

L['options_icons_higher_dimensional_learning'] = '{achievement:11175}'
L['options_icons_higher_dimensional_learning_desc'] = 'Display book locations for {achievement:11175} achievement.'

-------------------------------------------------------------------------------
-------------------------------- BROKEN SHORE ---------------------------------
-------------------------------------------------------------------------------

L['bringing_home_the_beacon_note'] = 'While under {npc:127264}, you will be buffed with {spell:240640}.\n\nKill demons to loot various |cFFFFFD00Sentinax Beacons|r.'

L['options_icons_bringing_home_the_beacon'] = '{achievement:11802}'
L['options_icons_bringing_home_the_beacon_desc'] = 'Display {npc:127264} locations for {achievement:11802} achievement.'

L['hidden_wyrmtongue_cache_label'] = 'Hidden Wyrmtongue Cache'
L['in_horde_ship'] = 'In the crashed Horde airship.'
L['broken_shore_worldboss_note'] = 'Will only spawn when the {location:The Nether Disruptor} is up. Only one Worldboss will spawn per cycle.'
L['sentinax_rare_note'] = [[
To spawn the bosses you need to farm the mobs and use beacons to open portals under {npc:127264} while you have the {spell:240640} buff.

{npc:%d} requires
{item:%d}
->
{item:%d}
->
{item:%d}

When the {location:The Nether Disruptor} is up, {npc:120898} will sell {item:147775} that can be used on {npc:120751s} up to 50 time per day.
The Portals will then spawn Elite Mobs that have a higher chance of dropping {item:%d}.
]]

-------------------------------------------------------------------------------
---------------------------------- DALARAN ------------------------------------
-------------------------------------------------------------------------------

-- Midnight tz per region: US=>PST, KR=>KST, EU=>CET, TW=>CST, CN=>CST
local tz = ({'PST', 'KST', 'CET', 'CST', 'CST'})[GetCurrentRegion()] or UNKNOWN

L['sheddles_chest'] = 'Sheddle\'s Chest'
L['shoe_shine_kit_note'] = 'Every Saturday night at midnight (' .. tz .. ') {npc:97003} will drop his chest on the ground for a couple hours and leave.'
L['wand_simulated_life_note'] = 'Upstairs on the table.'

L['sir_galveston_note'] = 'Are you ready Sir Murkeston? Fight gallantly!'
L['amalia_note'] = 'You\'re all bark and no bite.'
L['tiffany_nelson_note'] = 'Bring it on!'
L['bohdi_sunwayver_note'] = 'Sun\'s out! Pets out!'

-------------------------------------------------------------------------------
----------------------------------- EREDATH -----------------------------------
-------------------------------------------------------------------------------

L['kaara_the_pale_note'] = '{npc:126860} no longer drops {item:153190}'
L['turek_the_lucid_note'] = 'In the {location:Oronaar Collapse}'

L['ancient_eredar_cache'] = 'Ancient Eredar Cache'
L['ancient_eredar_cache_note'] = 'There are 6 unique {object:Ancient Eredar Caches} that can each appear at set locations.'
L['void_seeped_cache'] = 'Void-Seeped Cache'
L['void_seeped_cache_note'] = 'There are 2 unique {object:Void-Seeped Caches} that can each appear at set locations. {note:These do not contain transmogs.}'

L['options_icons_ancient_eredar_cache'] = 'Ancient Eredar Cache'
L['options_icons_ancient_eredar_cache_desc'] = 'Display possible locations for {object:Ancient Eredar Caches} (daily chests).'
L['options_icons_void_seeped_cache'] = 'Void-Seeped Cache'
L['options_icons_void_seeped_cache_desc'] = 'Display possible locations for {object:Void-Seeped Caches} (daily chests).'

-------------------------------------------------------------------------------
-------------------------------- HIGHMOUNTAIN ---------------------------------
-------------------------------------------------------------------------------

L['odrogg_note'] = 'You think you can best my snails?'
L['grixis_tinypop_note'] = 'This\'ll be easy!'
L['bredda_tenderhide_note'] = 'Let the bravest prove victorious!'
L['unethical_adventurers'] = 'Unethical Adventurers'
L['unethical_adventurers_note'] = 'Click on the {object:Seemingly Unguarded Treasure} to summon the {npc:Unethical Adventurers}.'
L['taurson_note'] = 'Talk to {npc:97653} and challange him to fight.\nWhen you defeat him, {object:Taurson\'s Prize} will spawn.'
L['arru_note'] = 'Talk to {npc:97215} to start the encounter with {npc:97220}.\n\nWhen {npc:97215} has tamed the bear, {object:Thunder Totem Stolen Goods} will spawn in the back of the small cave.'
L['tt_hoc'] = 'Down in the {location:Hall of Chieftains}.'
L['steamy_jewelry_box'] = 'A Steamy Jewelry Box'
L['flamescale_note'] = 'Use the {object:Abandoned Fishing Pole} to summon {npc:97793}.'
L['amateur_hunters_note'] = 'After defeating the three {npc:Amateur Hunters} the {object:Battered Chest} will spawn in the back of the small cave.'
L['treasure_40482'] = 'On the nose of the huge statue.'
L['mrrklr_note'] = 'Free {npc:98754} to spawn {npc:98311}.'
L['mytna_talonscreech_note'] = 'Talk to {npc:97579} to start the fight against {npc:97593}.'
L['devouring_darkness_note'] = 'Extinguish all {npc:97543s} to summon {npc:100495}.'
L['totally_safe_treasure_chest'] = 'Totally Safe Treasure Chest'
L['rocfeather_kite_note'] = 'Combine {item:131809}, {item:131926} and {item:131927} with {item:131810}, to get the {item:131811}.'

-------------------------------------------------------------------------------
-------------------------------- KROKUUN --------------------------------------
-------------------------------------------------------------------------------

L['eredar_war_supplies'] = 'Eredar War Supplies'
L['eredar_war_supplies_note'] = 'There are 7 unique {object:Eredar War Supplies} that can each appear at set locations.'

L['options_icons_eredar_war_supplies'] = 'Eredar War Supplies'
L['options_icons_eredar_war_supplies_desc'] = 'Display possible locations for {object:Eredar War Supplies} (daily chests).'

-------------------------------------------------------------------------------
--------------------------------- STORMHEIM -----------------------------------
-------------------------------------------------------------------------------
L['to_stormheim'] = 'Portal to Stormheim'
L['to_helheim'] = 'Portal to Helheim'

L['trapper_jarrun_note'] = 'Muster your defenses mortal.'
L['robert_craig_note'] = 'Sic \'em!'
L['stormtalon_note'] = 'Try not to One-Shot him or you won\'t be able to mount him.'
L['going_up_note'] = 'Ascend to the top of {location:Nashal\'s Watch} in {location:Stormheim}.' -- wowhead.com/achievement=10627
L['nameless_king_note'] = 'Use the {object:Offering Shrine} to summon {npc:92763}.'
L['captain_brvet_note'] = 'Use the {object:Horn of the Helmouth} to summon {npc:92685}.'
L['mother_clacker_note'] = 'Speak to {npc:92343} and kill the {npc:92349s} to summon {npc:91780}.'
L['thane_irglov_note'] = 'Defeat the champions to make him attackable.'

L['hook_and_sinker'] = '{npc:92590} & {npc:92591}'
L['forsaken_deathsquad'] = 'Forsaken Deathsquad'
L['worgen_stalkers'] = 'Worgen Stalkers'

-------------------------------------------------------------------------------
---------------------------------- SURAMAR ------------------------------------
-------------------------------------------------------------------------------

L['varenne_note'] = 'I must get back to my cooking!'
L['master_tamer_flummox_note'] = 'Flummox no need pets! Flummox eats them NOW!'
L['aulier_note'] = 'Let\'s begin your lesson in humility.'
L['myonix_note'] = '{bug:Currently bugged, needs a relog to show the credit towards {achievement:11265} achievement.}'
L['arcanist_lylandre_note'] = 'To attack her you must remove the barriers by clicking on the crystals.'
L['gorgroth_note'] = 'Use the {object:Portal Key} to summon {npc:110832}.'
L['inside_temple_of_faladora'] = 'Inside the {location:Temple of Fal\'adora}.'
L['inside_falanaar_tunnels'] = 'Inside the {location:Falanaar Tunnels}.'
L['ancient_mana_chunk'] = 'Ancient Mana Chunk'
L['dusty_coffer'] = 'Dusty Coffer'
L['protected_treasure_chest'] = 'Protected Treasure Chest'

-------------------------------------------------------------------------------
--------------------------------- VAL'SHARA -----------------------------------
-------------------------------------------------------------------------------

L['anthydas_note'] = 'Loot the treasure chest on the second floor of the building next to the sink.'
L['elandris_note'] = 'Not available when the legion invasion world quest {wq:The Vale of Dread} is active.'
L['gathenak_note'] = 'Speak with {npc:112472}.'
L['gorebeak_note'] = 'Speak with {npc:92111}.'
L['jinikki_note'] = 'Speak with {npc:93677} and kill {npc:93684s} until the rare appears.'
L['kiranys_note'] = 'Click the {object:Vibrating Arcane Trap}.'
L['mad_henryk_note'] = 'Step into the {npc:109602}.'
L['skulvrax_note'] = 'Resuscitate {npc:92334} and follow her.'
L['theryssia_note'] = 'Read {npc:94194}\'s nameplate on the gravestone.'
L['unguarded_thistleleaf_treasure'] = 'Unguarded Thistleleaf Treasure'

L['in_darkpens'] = 'Inside the {location:Darkpens}.'
L['treasure_38366'] = 'Under the tree roots.'
L['treasure_38386'] = 'On the balcony on the second floor.'
L['treasure_38387'] = 'In an small cave under the inn. The entrance is behind the building.'
L['treasure_38391'] = 'Hidden behind a tree.'
L['treasure_38943'] = 'Go up the right stairs.'
L['treasure_39069'] = 'On the second floor balcony.'
L['treasure_39074'] = 'Under the tree.'
L['treasure_39080'] = 'In the basement. You need to start a questline beginning with {quest:38643} from {npc:92688} followed by {quest:38644} from {npc:92683}.'
L['treasure_39083'] = 'Hidden in a tree.'
L['treasure_39088'] = 'Hidden in the lake between some roots.'
L['treasure_39093'] = 'On the river under the roots.'

L['grumpy_note'] = 'Upstairs in the burning building.'

L['xorvasc_note'] = 'I\'m your worst nightmare.'
L['durian_strongfruit_note'] = 'If we must...'

-------------------------------------------------------------------------------
--------------------------------- ACROSS ZONES --------------------------------
-------------------------------------------------------------------------------

L['in_house'] = 'Inside the house.'
L['in_small_cottage'] = 'In a small cottage.'

L['glimmering_treasure_chest'] = 'Glimmering Treasure Chest'
L['small_treasure_chest'] = 'Small Treasure Chest'
L['treasure_chest'] = 'Treasure Chest'
L['treasures_discovered'] = 'treasures discovered'

L['general_pet_tamer_note'] = '{note:Only appears when the corresponding world quest is active.}'

L['options_icons_safari'] = '{achievement:11233}'
L['options_icons_safari_desc'] = 'Display battle pet locations for the {achievement:11233} achievement.'

L['change_map'] = 'Change map'

--BFA

-------------------------------------------------------------------------------
----------------------------------- DRUSTVAR ----------------------------------
-------------------------------------------------------------------------------

L['ancient_sarco_note'] = 'Open the {object:Ancient Sarcophagus} to summon waves of {npc:128181}.'
L['beshol_note'] = 'Open the {object:Obviously Safe Chest} to summon the rare.'
L['cottontail_matron_note'] = 'Study the {object:Beastly Ritual Skull} to summon the rare.'
L['gluttonous_yeti_note'] = 'This {npc:127979} is doomed ...'
L['idej_note'] = 'Stun his {spell:274005} cast or he may kill {npc:139380}!'
L['seething_cache_note'] = 'Open the {object:Seething Cache} to summon waves of {npc:129031}.'
L['the_caterer_note'] = 'Study the {object:Ruined Wedding Cake} to activate.'
L['vicemaul_note'] = 'Click the {npc:127652} to reel in the rare.'

L['merchants_chest_note'] = 'Kill the nearby {npc:137468} that is holding a keyring to acquire {item:163710}'
L['wicker_pup_note'] = [[
Light the inactive {npc:143609es} to activate the chest. Combine the items from all four chests to create a {npc:143189}.

• Bespelled: {item:163790}
• Enchanted: {item:163796}
• Ensorcelled: {item:163791}
• Hexed: {item:163789}
]]

local runebound = 'Activate the {npc:143688s} in the order shown on the metal plates behind the chest:\n\n'
L['runebound_cache_note'] = runebound .. 'Left -> Bottom -> Top -> Right'
L['runebound_chest_note'] = runebound .. 'Left -> Right -> Bottom -> Top'
L['runebound_coffer_note'] = runebound .. 'Right -> Top -> Left -> Bottom'

-- NOTE: These quotes (and for trainers in other zones) were taken from the quotes
-- for this NPC on Wowhead. If no quotes were listed, I started a battle with the NPC
-- and jotted down the opening line. Adds a little flavor to the tooltips.
L['captain_hermes_note'] = 'Yeah! Crustacean power!'
L['dilbert_mcclint_note'] = 'Hey there, name\'s {npc:140461}, Infestation Management. Always nice to battle a fellow arachnoid enthusiast.'
L['fizzie_spark_note'] = 'You think your pets have a chance against my Azerite infused team? You wish!'
L['michael_skarn_note'] = 'Just remember as we start this battle, you asked for this.'

L['cursed_hunter_label'] = 'Cursed Animals'
L['cursed_hunter_note'] = 'Kill one of every type of cursed animal to earn the achievement.'
L['options_icons_cursed_hunter_desc'] = 'Display animal locations for the {achievement:13094} achievement.'
L['options_icons_cursed_hunter'] = '{achievement:13094}'

L['drust_facts_note'] = 'Read all of the steles to earn the achievement.'
L['stele_forest_note'] = 'Inside {location:Ulfar\'s Den}.'
L['options_icons_drust_facts_desc'] = 'Display stele locations for the {achievement:13064} achievement.'
L['options_icons_drust_facts'] = '{achievement:13064}'

L['embers_crossbow_note'] = 'Loot the {item:163749} on the ground between two trees, then return it to the ruins of {location:Gol Var}.'
L['embers_flask_note'] = 'Loot the {item:163746} in the water between two rocks, then return it to the ruins of {location:Gol Var}.'
L['embers_hat_note'] = 'Loot the {item:163748} from the pile of bones, then return it to the ruins of {location:Gol Var}.'
L['embers_knife_note'] = 'Pull the {item:163747} from the trunk of the tree, then return it to the ruins of {location:Gol Var}.'
L['embers_golvar_note'] = 'Return each relic to the ruins of {location:Gol Var} to complete the achievement.'
L['golvar_ruins'] = 'Ruins of {location:Gol Var}'
L['options_icons_ember_relics_desc'] = 'Display relic locations for the {achievement:13082} achievement.'
L['options_icons_ember_relics'] = '{achievement:13082}'

L['linda_deepwater_note'] = 'To gain access, you must complete {npc:136458}\'s quest line just outside of {location:Anyport}.'

-------------------------------------------------------------------------------
----------------------------------- MECHAGON ----------------------------------
-------------------------------------------------------------------------------

L['avenger_note'] = 'When {npc:155254} is in {location:Rustbolt}, kill the {npc:151159} (runs all over the zone) to spawn.'
L['beastbot_note'] = 'Craft a {item:168045} at {npc:150359} to activate.'
L['cogstar_note'] = 'Kill {npc:150667} mobs anywhere in the zone until he teleports in to reinforce them.'
L['crazed_trogg_note'] = 'Use a spraybot, paint filled bladder or the bots in {location:Bondo\'s Yard} to coat yourself in the color he yells.'
L['deepwater_note'] = 'Craft a {item:167649} at {npc:150359} to summon.'
L['doppel_note'] = 'Along with two other players, use a {item:169470} from {daily:56405} to activate.'
L['foul_manifest_note'] = 'Connect all three circuit breakers to the pylons in the water.'
L['furor_note'] = 'During {daily:55463}, click the small blue mushrooms until he spawns.'
L['killsaw_note'] = 'Spawns anywhere in the {location:Fleeting Forest}, likely in response to killing {npc:151871s}. Does not spawn on days when the Venture Company is in the forest and Clearcutters are not available.'
L['leachbeast_note'] = 'Shares a spawn with {npc:151745s} in {location:Junkwatt Depot}, which only spawn while the area is raining. Use an {item:168961} to activate the {object:Weather Alteration Machine}.'
L['nullifier_note'] = [[
Hack the {npc:152174} using either:

• A {item:168435} punch card from {npc:151625}.

• A {item:168023} from minions that attack the JD41 and JD99 drill rigs.
]]
L['scrapclaw_note'] = 'Off the shore in the water.'
L['sparkqueen_note'] = 'Spawns only when {daily:55765} is active.'
L['rusty_note'] = 'Craft a {item:169114} at {npc:150359} to enter the alternate future. Only spawns when {npc:153993} is NOT present in {location:Rustbolt}.'
L['vaultbot_note'] = 'Kite to the {npc:151482} in {location:Bondo\'s Yard} or craft a {item:167062} at {npc:150359} to break him open.'

L['iron_chest'] = 'Irontide Lockbox'
L['mech_chest'] = 'Mechanized Chest'
L['msup_chest'] = 'Mechanized Supply Chest'
L['rust_chest'] = 'Old Rusty Chest'
L['iron_chest_note'] = 'Open with an {item:169872} dropped from mobs in the {location:Western Spray}.'
L['msup_chest_note'] = 'Open with a {item:169873} dropped from mobs in the {location:Western Spray}.'
L['rust_chest_note'] = 'Open with an {item:169218} dropped from mobs in the {location:Western Spray}.'

L['rec_rig_note'] = 'To activate hard-mode, use the {spell:292352} weapon to convert all {npc:150825s} into {npc:151049s}. Pets are obtainable on both difficulties.'

L['grease_bot_note'] = 'Click the bot to gain 5% haste and 10% movement speed for 2 hours.'
L['shock_bot_note'] = 'Click the bot to gain a chain lightning damage proc for 2 hours.'
L['welding_bot_note'] = 'Click the bot to increase health and healing received by 10% for 2 hours.'

L['options_icons_mech_buffs'] = 'Buff Bots'
L['options_icons_mech_buffs_desc'] = 'Display locations of {npc:155911}, {npc:155909} and {npc:155910} on the map inside the dungeon.'
L['options_icons_mech_chest'] = 'Mechanized Chest'
L['options_icons_mech_chest_desc'] = 'Display locations of {object:Mechanized Chest}. There are 10 unique chests that can be looted once a day and each chest has 4-5 spawn locations. Locations are grouped by color.'
L['options_icons_locked_chest'] = 'Locked Chest'
L['options_icons_locked_chest_desc'] = 'Display locations of locked chests in the {location:Western Spray}.'
L['options_icons_recrig'] = '{npc:150448}'
L['options_icons_recrig_desc'] = 'Display the location of the {npc:150448} and its rewards.'

L['mechagon_snooter_note'] = '{npc:154769} (pretty rare) and {npc:154767} share the same spawn points.'
L['battlepet_secondary_only_note'] = 'Can be found only as secondary pet.'
L['mechagon_explode_note'] = '{note:Beware, it can {spell:90096}, which will kill it and you won\'t be able to catch it.}'

-------------------------------------------------------------------------------
----------------------------------- NAZJATAR ----------------------------------
-------------------------------------------------------------------------------

L['naz_intro_note'] = 'Complete the introductory quest chain to unlock rares, treasures, and world quests on {location:Nazjatar}.'

L['alga_note'] = 'CAUTION: Cloaked with four adds!'
L['allseer_note'] = 'Spawns anywhere in lower {location:Kal\'methir}.'
L['anemonar_note'] = 'Kill the {npc:150467} on top of him to activate.'
L['avarius_note'] = 'Use a {item:167012} to collect and place the colored crystals on the pedestals. You do not have to be a miner!'
L['banescale_note'] = 'Small chance to spawn immediately after killing {npc:152359}.'
L['elderunu_note'] = 'Spawns anywhere in upper {location:Kal\'methir}.'
L['gakula_note'] = 'Shoo away {npc:152275s} until he spawns.'
L['glimmershell_note'] = 'Small chance to spawn in place of {npc:152426s}.'
L['kelpwillow_note'] = 'Bring a {npc:154725} using a {item:167893} to activate.'
L['lasher_note'] = 'Plant a {item:166888} in the soil and and feed it with nearby {npc:Seafly}.'
L['matriarch_note'] = 'Shares a respawn timer with the other two Scale Matriarchs.'
L['needle_note'] = 'Usually spawns in the {location:Gate of the Queen} area.'
L['oronu_note'] = 'Summon a {npc:154849} pet to activate.'
L['rockweed_note'] = 'Kill {npc:152549} and {npc:151166} all over the zone until he spawns. A raid group is recommended as this can be a long grind.'
L['sandcastle_note'] = 'Use a {item:167077} to reveal chests anywhere in the zone until he spawns.'
L['tidelord_note'] = 'Kill the three {npc:145326s} and the summoned {npc:153999} until the Tidelord is summoned.'
L['tidemistress_note'] = 'Click {object:Undisturbed Specimen} until she spawns.'
L['urduu_note'] = 'Kill a {npc:152563} in front of him to activate.'
L['voice_deeps_notes'] = 'Use a {item:168161} to break the rocks.'
L['vorkoth_note'] = 'Toss {item:167059} into the pool until it spawns.'
L['area_spawn'] = 'Spawns in the surrounding area.'
L['cora_spawn'] = 'Spawns anywhere in the {location:Coral Forest}.'
L['cave_spawn'] = 'Spawns in a cave.'
L['east_spawn'] = 'Spawns anywhere in the eastern half of the zone.'
L['ucav_spawn'] = 'Spawns in an underwater cave.'
L['zone_spawn'] = 'Spawns all over the zone.'

L['assassin_looted'] = 'looted while an assassin.'

L['arcane_chest'] = 'Arcane Chest'
L['glowing_chest'] = 'Glowing Arcane Trunk'
L['arcane_chest_01'] = 'Under some seaweed.'
L['arcane_chest_02'] = 'Inside the building upstairs.'
L['arcane_chest_03'] = 'On the second level.'
L['arcane_chest_04'] = 'In the water above the waterfall.'
L['arcane_chest_05'] = 'In the ruins.'
L['arcane_chest_06'] = '' -- in the open
L['arcane_chest_07'] = 'In the back of a cave. Entrance in {location:Zanj\'ir Wash} to the east.'
L['arcane_chest_08'] = 'Hidden under some starfish.'
L['arcane_chest_09'] = 'In a cave behind {npc:154914}.'
L['arcane_chest_10'] = 'Under a molted shell.'
L['arcane_chest_11'] = 'At the top of the hill.'
L['arcane_chest_12'] = 'At the top of the waterfall.'
L['arcane_chest_13'] = 'At the top of the cliff, behind a tree.'
L['arcane_chest_14'] = 'Inside {location:Elun\'alor Temple}.'
L['arcane_chest_15'] = 'In the right side of the building.'
L['arcane_chest_16'] = 'In an underwater cave. Entrance to the south.'
L['arcane_chest_17'] = 'At the top of the waterfall.'
L['arcane_chest_18'] = 'In a cave just below the path.'
L['arcane_chest_19'] = 'On top of the rock archway. Use a glider.'
L['arcane_chest_20'] = 'On top of the mountain.'
L['glowing_chest_1'] = 'In the back of an underwater cave. Defend the pylon.'
L['glowing_chest_2'] = 'Uncross the wires.'
L['glowing_chest_3'] = 'In the back of a cave. Defend the pylon.'
L['glowing_chest_4'] = 'Match 3 red runes.'
L['glowing_chest_5'] = 'In a cave. Defend the pylon.'
L['glowing_chest_6'] = 'Uncross the wires.'
L['glowing_chest_7'] = 'Match 4 blue runes.'
L['glowing_chest_8'] = 'On top of the roof. Defend the pylon.'

L['prismatic_crystal_note'] = 'Use these to feed critters to {npc:151782s} in {location:Nazjatar}.'
L['strange_crystal'] = 'Strange Crystal'
L['strange_crystal_note'] = 'To unlock {item:167893} spawns, you must first loot the {item:169778} at this location and then turn in {quest:56560}.'
L['options_icons_prismatics'] = '{item:167893s}'
L['options_icons_prismatics_desc'] = 'Display {item:167893} locations for feeding {npc:151782s}.'

L['slimy_cocoon'] = 'Slimy Cocoon'
L['ravenous_slime_note'] = 'Feed the slime a critter using a {item:167893}. Repeat five days until it spawns an egg with a pet inside. The slime will stay gone until the next weekly reset.'
L['slimy_cocoon_note'] = 'A pet is ready to be collected from the cocoon! If it does not appear for you, the egg in on cooldown in your phase. Change phases or check back later.'

L['cat_figurine'] = 'Crystalline Cat Figurine'
L['cat_figurine_01'] = 'In an underwater cave. Figurine is on the floor in the open. Entrance to the east.'
L['cat_figurine_02'] = 'In a cave under the nearby waterfall. Figurine is under a starfish on the wall.'
L['cat_figurine_03'] = 'In an underwater cave. Figurine is hidden under some broken shells.'
L['cat_figurine_04'] = 'In an underwater cave. Figurine is on the floor in the open.'
L['cat_figurine_05'] = 'In a small cave. Figurine is hidden behind plant on the floor.'
L['cat_figurine_06'] = 'In an underwater cave filled with hostile Reefwalkers. Figurine is up on the wall. Entrance to the north.'
L['cat_figurine_07'] = 'In a small cave. Figurine is on the wall in some coral.'
L['cat_figurine_08'] = 'In a small cave. Dodge the arcane circles. Figurine is on a tall rock in the back.'
L['cat_figurine_09'] = 'In an underwater cave. Figurine is on the rock archway by the ceiling.'
L['cat_figurine_10'] = 'In a cave just below the path. Figurine is between three barrels.'
L['figurines_found'] = 'Crystalline Figurines Found'

L['fabious_desc'] = 'Take a "selfie" picture with {npc:65090} using either the {item:122637} or {item:122674} toy. Long time spawn in random locations and exist for a short time.'

L['mardivas_lab'] = 'Mardivas\'s Laboratory'
L['no_reagent'] = 'No reagents'
L['swater'] = 'Small Water'
L['gwater'] = 'Greater Water'
L['sfire'] = 'Small Fire'
L['gfire'] = 'Greater Fire'
L['searth'] = 'Small Earth'
L['gearth'] = 'Greater Earth'
L['Arcane'] = nil
L['Watery'] = nil
L['Burning'] = nil
L['Dusty'] = nil
L['Zomera'] = nil
L['Omus'] = nil
L['Osgen'] = nil
L['Moghiea'] = nil
L['Xue'] = nil
L['Ungormath'] = nil
L['Spawn'] = nil
L['Herald'] = nil
L['Salgos'] = nil
L['tentacle_taco'] = 'Sells {item:170100} if you are wearing the Benthic {item:169489}.'

L['options_icons_slimes_nazj'] = '{npc:151782s}'
L['options_icons_slimes_nazj_desc'] = 'Display locations of the four {npc:151782s} that produce pets once fed.'
L['options_icons_cats_nazj'] = '{achievement:13836}'
L['options_icons_cats_nazj_desc'] = 'Display locations of the cat figurines for the {achievement:13836} achievement.'
L['options_icons_misc_nazj'] = 'Miscellaneous'
L['options_icons_misc_nazj_desc'] = 'Display the location of {location:Murloco\'s Hideaway} and {location:Mardivas\'s Laboratory}.'
L['options_icons_fabious'] = '{npc:65090}'
L['options_icons_fabious_desc'] = 'Display possible locations of {npc:65090} for the {item:169201} mount.'

-------------------------------------------------------------------------------
------------------------------------ NAZMIR -----------------------------------
-------------------------------------------------------------------------------

L['captain_mukala_note'] = 'Attempt to loot the {object:Cursed Chest} to summon the {npc:125232}.'
L['enraged_water_note'] = 'Examine the {npc:134295} to summon the elemental.'
L['lucille_note'] = 'Talk to {npc:134297} to summon the rare.'
L['offering_to_bwonsamdi_note'] = 'Run up the nearby tree and jump into the broken structure.'
L['shambling_ambusher_note'] = 'Attempt to loot the {npc:124473} to activate the rare.'
L['zaamar_note'] = 'Inside the {location:Necropolis Catacombs}, entrance to the south.'

L['grady_prett_note'] = 'Time to get down and battle! Lets do this!'
L['korval_dark_note'] = 'This place is spooky, lets make this a quick battle.'
L['lozu_note'] = 'Lets fight with honor, stranger.'

L['tales_bwonsamdi_note'] = 'At the destroyed pillar.'
L['tales_hireek_note'] = 'A Scroll on the table.'
L['tales_kragwa_note'] = 'At the destroyed wall.'
L['tales_torga_note'] = 'Underwater at a destroyed pillar.'

L['carved_in_stone_41860'] = 'Inside a destroyed building near the mountain.'
L['carved_in_stone_41861'] = 'At the destroyed pillar.'
L['carved_in_stone_41862'] = 'At the destroyed wall, in front of the huge pillar.'
L['carved_in_stone_42116'] = 'At a pillar next to {npc:126126}.'
L['options_icons_carved_in_stone'] = '{achievement:13024}'
L['options_icons_carved_in_stone_desc'] = 'Display pictograph locations for {achievement:13024} achievement.'

L['hoppin_sad_53419'] = 'Behind two trees under a huge root.'
L['hoppin_sad_53420'] = 'In the ruins.'
L['hoppin_sad_53424'] = 'On a cliff.'
L['hoppin_sad_53425'] = 'On the tree near the waterfall.'
L['hoppin_sad_53426'] = 'Under a few roots.'

L['options_icons_hoppin_sad'] = '{achievement:13028}'
L['options_icons_hoppin_sad_desc'] = 'Display {npc:143317} locations for the {achievement:13028} achievement.'

-------------------------------------------------------------------------------
------------------------------- STORMSONG VALLEY ------------------------------
-------------------------------------------------------------------------------

L['in_basement'] = 'In the basement.'
L['jakala_note'] = 'Talk to {npc:140925}.'
L['nestmother_acada_note'] = 'Inspect {object:Acada\'s Nest} to spawn the rare.'
L['sabertron_note'] = 'Kill the {npc:139334} to activate one of the {npc:139328s}.'
L['whiplash_note'] = 'Only spawns when {wq:Whiplash} is active.'

L['discarded_lunchbox_note'] = 'In the building on top of the bookshelf.'
L['hidden_scholars_chest_note'] = 'On the roof of the building.'
L['honey_vat'] = 'Honey Vat'
L['smugglers_stash_note'] = 'In the water under the platform.'
L['sunken_strongbox_note'] = 'In the water under the ship.'
L['venture_co_supply_chest_note'] = 'Climb up the ladder on the ship.'
L['weathered_treasure_chest_note'] = 'In a hidden cave. There are three entrances, each hidden behind a cluster of trees.'

L['curious_grain_sack'] = 'Curious Grain Sack'
L['small_treasure_chest'] = 'Small Treasure Chest'
L['small_treasure_51927'] = 'In the building under the stairs.'
L['small_treasure_51940'] = 'In the building.'

L['eddie_fixit_note'] = 'Prepare to face my unbeatable team of highly modified and customized robots!'
L['ellie_vern_note'] = 'I\'ve found the toughest sea creatures around to battle for me, you don\'t stand a chance.'
L['leana_darkwind_note'] = 'Strange creatures on this island will make for a strange battle I suspect.'

L['honeyback_harvester_note'] = 'Talk to the {npc:155193} to begin the event. {object:The Fresh Jelly Deposit} can be looted once an hour and resets on the hour.'
L['options_icons_honeybacks'] = '{npc:155193s}'
L['options_icons_honeybacks_desc'] = 'Display {npc:155193} event locations for farming {faction:2395} reputation.'

L['lets_bee_friends_note'] = 'Complete {daily:53371} seven times to earn the achievement and pet. To unlock the daily:'
L['lets_bee_friends_step_1'] = 'Complete the {location:Mildenhall Meadery} questline through {quest:50553}.'
L['lets_bee_friends_step_2'] = 'Kill {npc:133429s} and {npc:131663s} at {location:Mildenhall Meadery} until you find an {item:163699}.'
L['lets_bee_friends_step_3'] = 'Bring {item:163699} to {npc:143128} in {location:Boralus}.'
L['lets_bee_friends_step_4'] = 'Bring {item:163702} to {npc:133907} at {location:Mildenhall Meadery}.'
L['lets_bee_friends_step_5'] = 'Complete {quest:53347} for {npc:133907}.'

local luncheon = (UnitFactionGroup('player') == 'Alliance') and '{npc:138221} in {location:Brennadam}' or '{npc:138096} in {location:Warfang Hold}'
L['these_hills_sing_note'] = 'Open {item:160485} here. Buy one from ' .. luncheon .. ' or loot one from the {object:Discarded Lunchbox} treasure in {location:Brennadam}.'

L['ancient_tidesage_scroll'] = 'Ancient Tidesage Scroll'
L['ancient_tidesage_scroll_note'] = 'Read all 8 {object:Ancient Tidesage Scroll} to earn the achievement.'
L['options_icons_tidesage_legends'] = '{achievement:13051}'
L['options_icons_tidesage_legends_desc'] = 'Display ancient scroll locations for the {achievement:13051} achievement.'

L['long_forgotten_rum_note'] = 'To enter the cave, {quest:50697} must be completed from {npc:134710} in {location:Deadwash}. Also sold by {npc:137040} in {location:Drustvar}.'

-------------------------------------------------------------------------------
------------------------------- TIRAGARDE SOUND -------------------------------
-------------------------------------------------------------------------------

L['honey_slitherer_note'] = 'Talk to {npc:137176} to summon the rare.'
L['tempestria_note'] = 'Inspect the {object:Suspicious Pile of Meat} to summon the rare.'
L['twin_hearted_note'] = 'Disturb the {object:Ritual Effigy} to activate the construct.'
L['wintersail_note'] = 'Destroy the {object:Smuggler\'s Cache} to summon the captain.'

L['hay_covered_chest_note'] = 'Ride the {npc:130350} down the road to {npc:131453} to spawn the treasure.'
L['pirate_treasure_note'] = [[
Requires the corresponding treasure map.

The maps drop from any pirate mobs in {location:Kul Tiras}. {location:Freehold} (open world) is a good place to farm pirates.
]]

local damp_note = '\n\nRead all five scrolls to gain access to the treasure.'

L['damp_scroll'] = 'A Damp Scroll'
L['damp_scroll_note_1'] = 'Entrance in {location:Stormsong Monastery}.' .. damp_note
L['damp_scroll_note_2'] = 'On the floor in a basement behind a {npc:136343}.' .. damp_note
L['damp_scroll_note_3'] = 'On the floor upstairs next to a {npc:136343}.' .. damp_note
L['damp_scroll_note_4'] = 'On the floor in a basement next to a {npc:136343}.' .. damp_note
L['damp_scroll_note_5'] = 'In a corner under the boardwalk.' .. damp_note
L['ominous_altar'] = 'Ominous Altar'
L['ominous_altar_note'] = 'Talk to the {object:Ominous Altar} to be teleported to the treasure.'
L['secret_of_the_depths_note'] = 'Read all five {object:Damp Scroll}, then talk to the {object:Ominous Altar} to teleport to the treasure.'

L['burly_note'] = 'These little guys are pretty strange, but they sure pack a punch. Are you sure you want this fight?'
L['delia_hanako_note'] = 'Before we start, I just want to remind you to not feel too bad when my team annihilates yours.'
L['kwint_note'] = 'One person against one shark, maybe an even fight. One person against three? You\'re insane.'

L['shanty_fruit_note'] = 'Loot the {object:Dusty Songbook}, found on the floor in a small cave.'
L['shanty_horse_note'] = 'Loot the {object:Scoundrel\'s Songbook}, found on the bar inside the tavern.'
L['shanty_inebriation_note'] = 'Loot {object:Jay\'s Songbook}, found on the floor behind {npc:141066}.'
L['shanty_lively_note'] = 'Loot {object:Russel\'s Songbook}, found on top of the fireplace mantel.'
L['options_icons_shanty_raid'] = '{achievement:13057}'
L['options_icons_shanty_raid_desc'] = 'Display sea shanty locations for the {achievement:13057} achievement.'

L['upright_citizens_node'] = [[
One of the three NPCs below will appear each time the {wq:Not Too Sober Citizens Brigade} assault quest is active.

• {npc:146295}
• {npc:145107}
• {npc:145101}

Recruit each one to complete the achievement. You will need to check the zone many times for the assault, world quest and correct NPCs to be active.
]]
L['options_icons_upright_citizens'] = '{achievement:13285}'
L['options_icons_upright_citizens_desc'] = 'Display NPC locations for the {achievement:13285} achievement.'

-------------------------------------------------------------------------------
------------------------------------ ULDUM ------------------------------------
-------------------------------------------------------------------------------

L['uldum_intro_note'] = 'Complete the introductory quest chain to unlock rares, treasures and assault quests in {location:Uldum}.'

L['aqir_flayer'] = 'Shares a spawn with {npc:163114s} and {npc:154365s}.'
L['aqir_titanus'] = 'Shares a spawn with {npc:154353s}.'
L['aqir_warcaster'] = 'Shares a spawn with {npc:154352s}.'
L['atekhramun'] = 'Squish nearby {npc:152765s} until he spawns.'
L['chamber_of_the_moon'] = 'Underground in the {location:Chamber of the Moon}.'
L['chamber_of_the_stars'] = 'Underground in the {location:Chamber of the Stars}.'
L['chamber_of_the_sun'] = 'Inside the {location:Chamber of the Sun}.'
L['dunewalker'] = 'Click the {object:Essence of the Sun} on the platform above to release him.'
L['friendly_alpaca'] = 'Feed the alpaca {item:174858} seven times to learn it as a mount. Appears for 10 minutes in one location, then a long respawn.'
L['gaze_of_nzoth'] = 'Shares a spawn with {npc:156890s}.'
L['gersahl_note'] = 'Feed to the {npc:162765} seven times for a mount. Does not require Herbalism.'
L['hmiasma'] = 'Feed it the surrounding oozes until it activates.'
L['kanebti'] = 'Collect a {item:168160} from a {npc:152427}, which shares a spawn with regular {npc:151859s}. Insert the figurine into the {object:Scarab Shrine} to summon the rare.'
L['neferset_rare'] = 'These six rares share the same three spawn locations in Neferset. After a number of Summoning Ritual events have been completed, a random set of three will spawn.'
L['platform'] = 'Spawns on top of the floating platform.'
L['right_eye'] = 'Drops the right half of the {item:175140} toy.'
L['single_chest'] = 'This chest spawns in only one location! If it is not there, wait a bit and it will respawn.'
L['tomb_widow'] = 'When the white egg-sacs are present by the pillars, kill the invisible spiders to summon.'
L['uatka'] = 'Along with two other players, click each Mysterious Device. Requires a {item:171208} from an {object:Amathet Reliquary}.'
L['wastewander'] = 'Shares a spawn with {npc:154369s}.'

L['amathet_cache'] = 'Amathet Cache'
L['black_empire_cache'] = 'Black Empire Cache'
L['black_empire_coffer'] = 'Black Empire Coffer'
L['infested_cache'] = 'Infested Cache'
L['infested_strongbox'] = 'Infested Strongbox'
L['amathet_reliquary'] = 'Amathet Reliquary'

L['options_icons_assault_events'] = 'Assault Events'
L['options_icons_assault_events_desc'] = 'Display locations for possible assault events.'
L['options_icons_coffers'] = 'Locked Coffers'
L['options_icons_coffers_desc'] = 'Display locations of locked coffers (lootable once per assault).'

L['ambush_settlers'] = 'Defeat waves of mobs until the event ends.'
L['burrowing_terrors'] = 'Jump on the {npc:162073s} to squish them.'
L['call_of_void'] = 'Cleanse the Ritual Pylon.'
L['combust_cocoon'] = 'Throw the makeshift firebombs at the cocoons on the ceiling.'
L['dormant_destroyer'] = 'Click all the void conduit crystals.'
L['executor_nzoth'] = 'Kill the {npc:157680}, then destroy the {object:Executor Anchor}.'
L['hardened_hive'] = 'Pick up the {spell:317550} and burn all of the egg sacs.'
L['in_flames'] = 'Grab water buckets and douse the flames.'
L['monstrous_summon'] = 'Kill all of the {npc:160914s} to stop the summoning.'
L['obsidian_extract'] = 'Destroy every crystal of voidformed obsidian.'
L['purging_flames'] = 'Pick up the bodies and toss them into the fire.'
L['pyre_amalgamated'] = 'Cleanse the pyre, then kill all amalgamations until the rare spawns.'
L['ritual_ascension'] = 'Kill the {npc:152233s}.'
L['solar_collector'] = 'Enable all five cells on all sides of the collector. Clicking a cell also toggles all cells touching that cell.'
L['summoning_ritual'] = 'Kill the acolytes then close the summoning portal. After the event is completed a number of times, a set of three rares will spawn around {location:Neferset}.'
L['titanus_egg'] = 'Destroy the {npc:163257}, then defeat the {npc:163268}.'
L['unearthed_keeper'] = 'Destroy the {npc:156849}.'
L['virnall_front'] = 'Defeat waves of mobs until {npc:152163} spawns.'
L['voidflame_ritual'] = 'Extinguish all of the voidtouched candles.'

L['beacon_of_sun_king'] = 'Rotate all three statues inward.'
L['engine_of_ascen'] = 'Move all four statues into the beams.'
L['lightblade_training'] = 'Kill instructors and unprovens until {npc:152197} spawns.'
L['raiding_fleet'] = 'Burn all of the boats using the quest item.'
L['slave_camp'] = 'Open all of the nearby cages.'
L['unsealed_tomb'] = 'Protect {npc:152439} from waves of mobs.'

-------------------------------------------------------------------------------
------------------------------------ VALE -------------------------------------
-------------------------------------------------------------------------------

L['vale_intro_note'] = 'Complete the introductory quest chain to unlock rares, treasures and assault quests in the {location:Vale of Eternal Blossoms}.'

L['big_blossom_mine'] = 'Inside the {location:Big Blossom Mine}. Entrance to the north-east.'
L['guolai'] = 'Inside {location:Guo-Lai Halls}.'
L['guolai_left'] = 'Inside {location:Guo-Lai Halls} (left passage).'
L['guolai_center'] = 'Inside {location:Guo-Lai Halls} (center passage).'
L['guolai_right'] = 'Inside {location:Guo-Lai Halls} (right passage).'
L['left_eye'] = 'Drops the left half of the {item:175140} toy.'
L['pools_of_power'] = 'Inside the {location:Pools of Power}. Entrance at {location:The Golden Pagoda}.'
L['tisiphon'] = 'Click on {object:Danielle\'s Lucky Fishing Rod}.'

L['ambered_cache'] = 'Ambered Cache'
L['ambered_coffer'] = 'Ambered Coffer'
L['mogu_plunder'] = 'Mogu Plunder'
L['mogu_strongbox'] = 'Mogu Strongbox'

L['abyssal_ritual'] = 'Kill the {npc:153179s} and then the {npc:153171}.'
L['bound_guardian'] = 'Kill the three {npc:154329s} to free the {npc:154328}.'
L['colored_flames'] = 'Collect the colored flames from their torches and bring them to the matching runes.'
L['construction_ritual'] = 'Push the tiger statue into the beam.'
L['consuming_maw'] = 'Purify growths and tentacles until kicked out.'
L['corruption_tear'] = 'Grab the {spell:305470} and close the tear without letting the whirling eyes hit you.'
L['electric_empower'] = 'Kill the {npc:153095s}, then {npc:156549}.'
L['empowered_demo'] = 'Close all of the spirit reliquaries.'
L['empowered_wagon'] = 'Pick up {npc:156300} and place them under the wagon.'
L['feeding_grounds'] = 'Destroy the amber vessels and suspension chambers.'
L['font_corruption'] = 'Rotate the mogu statues until both beams reach the back, then click the console.'
L['goldbough_guardian'] = 'Protect {npc:156623} from waves of mobs.'
L['infested_statue'] = 'Pull all the twitching eyes off the statue.'
L['kunchong_incubator'] = 'Destroy all the field generators.'
L['mantid_hatch'] = 'Pick up the {spell:305301} and destroy the larva incubators.'
L['mending_monstro'] = 'Destroy all the {npc:157552} crystals.'
L['mystery_sacro'] = 'Destroy all the Suspicious Headstones, then kill the {npc:157298}.'
L['noodle_cart'] = 'Defend {npc:157615} while he repairs his cart.'
L['protect_stout'] = 'Protect the cave from waves of mobs.'
L['pulse_mound'] = 'Kill the surrounding mobs, then the {npc:157529}.'
L['ravager_hive'] = 'Destroy all of the hives on the tree.'
L['ritual_wakening'] = 'Kill the {npc:157942s}.'
L['serpent_binding'] = 'Kill the {npc:157345s}, then {npc:157341}.'
L['stormchosen_arena'] = 'Clear all mobs in the arena, then kill the Clan General.'
L['swarm_caller'] = 'Destroy the {npc:157719} pylon.'
L['vault_of_souls'] = 'Open the vault and destroy all the statues.'
L['void_conduit'] = 'Click the Void Conduit and squish the watching eyes.'
L['war_banner'] = 'Burn the banners and kill waves of mobs until the commander appears.'
L['weighted_artifact'] = 'Pick up the {object:Oddly Heavy Vase} and navigate the maze back to the pedestal. Getting stunned by a statue drops the vase.'

-------------------------------------------------------------------------------
----------------------------------- VISIONS -----------------------------------
-------------------------------------------------------------------------------

L['colored_potion'] = 'Colored Potion'
L['colored_potion_note'] = [[
The potion next to the corpse of %s always indicates color of the negative-effect potion for the run.

The color of the +100 sanity potion can be determined by the color of this potion (|cFFFF0000bad|r => |cFF00FF00good|r):

Black => Green
Blue => Purple
Green => Red
Purple => Black
Red => Blue
]]

L['bear_spirit_note'] = 'Kill the {npc:160404} and all waves of mobs to gain a 10% haste buff.'
L['buffs_change'] = 'Available buffs change each run. If the building is closed or the NPC/object is missing, that buff is not up this run.'
L['clear_sight'] = 'Requires {spell:307519} rank %d.'
L['craggle'] = 'Drop a toy on the ground (such as the {item:44606}) to distract him. Pull his bots away and kill them first.'
L['empowered_note'] = 'Go through the maze of mines and stand on the {npc:161324} upstairs for a 10% damage buff.'
L['enriched_note'] = 'Kill the {npc:161293} for a 10% crit buff.'
L['ethereal_essence_note'] = 'Kill {npc:161198} for a 10% crit buff.'
L['ethereal_note'] = 'Collect orange crystals hidden throughout the vision and return them to {npc:162358} for extra momentos. There are ten cystals total, two in each area.\n\n{note:Don\'t forget to loot the chest!}'
L['heroes_bulwark_note'] = 'Kill {npc:158588} inside the inn for a 10% health buff.'
L['inside_building'] = 'Inside a building.'
L['mailbox'] = 'Mailbox'
L['mail_muncher'] = 'When opened, the {npc:160708} has a chance to spawn.'
L['odd_crystal'] = 'Odd Crystal'
L['requited_bulwark_note'] = 'Kill {npc:157700} to gain a 7% versatility buff.'
L['shave_kit_note'] = 'Inside the barber shop. Loot the crate on the table.'
L['smiths_strength_note'] = 'Kill {npc:158565} in the blacksmith hut for a 10% damage buff.'
L['spirit_of_wind_note'] = 'Kill {npc:161140} for a 10% haste and movement speed buff.'
L['void_skull_note'] = 'Click the skull on the ground to loot the toy.'

L['c_alley_corner'] = 'In a corner in the alleyway.'
L['c_bar_upper'] = 'In the bar on the upper level.'
L['c_behind_bank_counter'] = 'In the bank behind the counter in the back.'
L['c_behind_boss'] = 'In the refugee building behind the boss.'
L['c_behind_boxes'] = 'In the corner behind some boxes.'
L['c_behind_cart'] = 'Behind a destroyed cart.'
L['c_behind_house_counter'] = 'In the house behind the counter.'
L['c_behind_mailbox'] = 'Behind the mailbox.'
L['c_behind_pillar'] = 'Hidden behind a pillar behind the embassy building.'
L['c_behind_rexxar'] = 'Hidden to the right behind {npc:155098}\'s building.'
L['c_behind_stables'] = 'Behind the stables by {npc:158157}.'
L['c_by_pillar_boxes'] = 'By the wall between a pillar and some boxes.'
L['c_center_building'] = 'On the bottom floor of the center building.'
L['c_forge_corner'] = 'In the corner by a forge.'
L['c_hidden_boxes'] = 'Hidden behind some boxes behind {npc:152089}\'s building.'
L['c_inside_auction'] = 'Inside the auction house on the right.'
L['c_inside_big_tent'] = 'To the left inside the big tent.'
L['c_inside_cacti'] = 'Inside the cactus patch around the corner.'
L['c_inside_hut'] = 'Inside the first hut on the right.'
L['c_inside_leatherwork'] = 'Inside the leatherworking building.'
L['c_inside_orphanage'] = 'Inside the orphanage.'
L['c_inside_transmog'] = 'Inside the transmog hut.'
L['c_left_cathedral'] = 'Hidden left of the cathedral entrance.'
L['c_left_inquisitor'] = 'Behind the inquisitor miniboss to the left of the stairs.'
L['c_on_small_hill'] = 'On top of a small hill.'
L['c_top_building'] = 'On the top floor of the building.'
L['c_underneath_bridge'] = 'Underneath the bridge.'
L['c_walkway_corner'] = 'On the upper walkway in a corner.'
L['c_walkway_platform'] = 'On a platform above the upper walkway.'

L['options_icons_visions_buffs'] = 'Buffs'
L['options_icons_visions_buffs_desc'] = 'Display locations of events that grant 1 hour damage buffs.'
L['options_icons_visions_chest'] = 'Chests'
L['options_icons_visions_chest_desc'] = 'Display possible chest locations inside horrific visions.'
L['options_icons_visions_crystals'] = 'Odd Crystals'
L['options_icons_visions_crystals_desc'] = 'Display possible odd crystal locations inside horrific visions.'
L['options_icons_visions_mail'] = 'Mailboxes'
L['options_icons_visions_mail_desc'] = 'Display mailbox locations for the {item:174653} mount.'
L['options_icons_visions_misc'] = 'Miscellaneous'
L['options_icons_visions_misc_desc'] = 'Display rare, toy, potion and ethereal locations inside horrific visions.'

-------------------------------------------------------------------------------
----------------------------------- VOLDUN ------------------------------------
-------------------------------------------------------------------------------

L['bloodwing_bonepicker_note'] = 'Collect the {npc:136390} at the summit to summon the vulture.'
L['nezara_note'] = 'Cut the ropes attached to all four {npc:128952s} to release the rare.'
L['vathikur_note'] = 'Kill the {npc:126894s} to summon the rare.'
L['zunashi_note'] = 'Entrance to the north in the mouth of a large skull.'

L['ashvane_spoils_note'] = 'Ride the {npc:132662} down the hill to spawn the treasure at the bottom.'
L['excavators_greed_note'] = 'Inside a collapsed tunnel.'
L['grayals_offering_note'] = 'After completing {quest:50702}, enter {location:Atul\'Aman} and click the {object:Ancient Altar} to spawn the treasure.'
L['kimbul_offerings_note'] = 'On the hill above the {location:Temple of Kimbul}.'
L['sandsunken_note'] = 'Click the {object:Abandoned Bobber} to pull the treasure out of the sand.'

L['keeyo_note'] = 'Time for a great adventure!'
L['kusa_note'] = 'I\'m on a winning streak, you have no chance against me and my team.'
L['sizzik_note'] = 'I always appreciate a good battle with a new challenger.'

L['tales_akunda_note'] = 'In the pond.'
L['tales_kimbul_note'] = 'Next to the withered tree.'
L['tales_sethraliss_note'] = 'On the ground next to the table.'

L['plank_1'] = 'Where the sand ends at the top of the hill.'
L['plank_2'] = 'Next to a broken building.'
L['plank_3'] = 'On the side of the pyramid. Path starts at the other nearby plank.'
L['plank_4'] = 'At the top of a sand dune along the side of the pyramid.'
L['plank_5'] = 'Follow the serpent\'s tail to find the plank.'
L['planks_ridden'] = 'rickety planks ridden'
L['options_icons_dune_rider'] = '{achievement:13018}'
L['options_icons_dune_rider_desc'] = 'Display rickety plank locations for the {achievement:13018} achievement.'

L['options_icons_scavenger_of_the_sands'] = '{achievement:13016}'
L['options_icons_scavenger_of_the_sands_desc'] = 'Show junk item locations for the {achievement:13016} achievement.'

L['elusive_alpaca'] = 'Feed {item:161128} to the {npc:162681} to learn it as a mount. Appears for 10 minutes in one location, then a long respawn.'

-------------------------------------------------------------------------------
---------------------------------- WARFRONTS ----------------------------------
-------------------------------------------------------------------------------

L['boulderfist_outpost'] = 'Inside {location:Boulderfist Outpost} (a large cave). Entrance to the northeast.'
L['burning_goliath_note'] = 'When defeated, a {npc:141663} will spawn near {npc:141668}.'
L['cresting_goliath_note'] = 'When defeated, a {npc:141658} will spawn near {npc:141668}.'
L['rumbling_goliath_note'] = 'When defeated, a {npc:141659} will spawn near {npc:141668}.'
L['thundering_goliath_note'] = 'When defeated, a {npc:141648} will spawn near {npc:141668}.'
L['echo_of_myzrael_note'] = 'Once all four elemental goliaths are defeated, {npc:141668} will appear.'
L['frightened_kodo_note'] = 'Despawns after a few minutes. Guaranteed to spawn after a server restart.'

-------------------------------------------------------------------------------
----------------------------------- ZULDAZAR ----------------------------------
-------------------------------------------------------------------------------

L['murderbeak_note'] = 'Toss the chum into the sea, then kill {npc:134780s} until {npc:134782} spawns.'
L['vukuba_note'] = 'Investigate the {npc:134049}, then kill waves of {npc:134047s} until {npc:134048} spawns.'

L['cache_of_secrets_note'] = 'Held by an {npc:137234} in a cave behind a waterfall.'
L['da_white_shark_note'] = 'Stand near {npc:133208} until she becomes hostile.'
L['dazars_forgotten_chest_note'] = 'Path begins near {npc:134738}.'
L['gift_of_the_brokenhearted_note'] = 'Place the incense to spawn the chest.'
L['offerings_of_the_chosen_note'] = 'On the second level of {location:Zanchul}.'
L['riches_of_tornowa_note'] = 'On the side of a cliff.'
L['spoils_of_pandaria_note'] = 'On the lowest deck of the ship.'
L['tiny_voodoo_mask_note'] = 'Sitting on the hut above {npc:141617}.'
L['warlords_cache_note'] = 'On top at the helm of the ship.'

L['karaga_note'] = 'I have not battled in a long while, I hope I am still a good challenge to you.'
L['talia_spark_note'] = 'The critters in this land are vicious, I hope you\'re ready for this.'
L['zujai_note'] = 'You come to face me in my own home? Good luck.'

L['kuafon_note'] = [[
Loot a {item:157782} from any {npc:Pterrordax} in {location:Zandalar} to begin the quest line. Some quests will take multiple days to complete.

The best mobs to farm are {npc:126618} in {location:Zanchul} or {npc:122113s} at {location:Skyrender Eyrie} south of {location:Tal'gurub}.
]]
L['torcali_note'] = 'Complete quests at {location:Warbeast Kraal} until {quest:47261} becomes available. Some quests will take multiple days to complete.'

L['totem_of_paku_note'] = 'Speak to {npc:137510} north of the {location:Great Seal} to select Pa\'ku as your loa in {location:Zuldazar}.'
L['options_icons_paku_totems'] = 'Totems of Pa\'ku'
L['options_icons_paku_totems_desc'] = 'Display {npc:131154} locations and their travel paths in {location:Dazar\'alor}.'

L['tales_gonk_note'] = 'Lies on the blanket.'
L['tales_gral_note'] = 'At the roots of the tree.'
L['tales_jani_note'] = 'At the destroyed pillar.'
L['tales_paku_note'] = 'On top of the building, on a rock near the water.'
L['tales_rezan_note'] = 'Above the cave of {npc:136428}.'
L['tales_shadra_note'] = 'Next to the entrance, behind a torch.'
L['tales_torcali_note'] = 'Between a couple of barrels and the stairs.'
L['tales_zandalar_note'] = 'Behind {npc:132989}.'

local shared_dinos = 'The {daily:50860} daily must be active (one of four possible dailies) from the {npc:133680} quest line for them to appear. Anyone can see them on those days.'
L['azuresail_note'] = 'Shares a short respawn timer with {npc:135512} and {npc:135508}.\n\n' .. shared_dinos
L['thunderfoot_note'] = 'Shares a short respawn timer with {npc:135510} and {npc:135508}.\n\n' .. shared_dinos
L['options_icons_life_finds_a_way'] = '{achievement:13048}'
L['options_icons_life_finds_a_way_desc'] = 'Display fearsome dinosaur locations for the {achievement:13048} achievement.'

-------------------------------------------------------------------------------
--------------------------------- ACROSS ZONES --------------------------------
-------------------------------------------------------------------------------

L['goramor_note'] = 'Purchase a {item:163563} from {npc:126833} and feed it to {npc:143644}. {npc:126833} is located in a small cave near the {location:Terrace of Sorrows}.'
L['makafon_note'] = 'Purchase an {item:163564} from {npc:124034} in {location:Scaletrader Post} and feed it to {npc:130922}.'
L['stompy_note'] = 'Purchase a {item:163567} from {npc:133833} north of the {location:Whistlebloom Oasis} and feed it to {npc:143332}.'
L['options_icons_brutosaurs'] = '{achievement:13029}'
L['options_icons_brutosaurs_desc'] = 'Display brutosaur locations for the {achievement:13029} achievement.'

local hekd_note = '\n\nTo gain access to {npc:126334}, you need to complete %s.'
if UnitFactionGroup('player') == 'Horde' then
    hekd_note = hekd_note:format('{quest:47441} from {npc:127665} in {location:Dazar\'alor} followed by {quest:47442} from {npc:126334}')
else
    hekd_note = hekd_note:format('{quest:51142} from {npc:136562} in {location:Voldun} followed by {quest:51145} from {npc:136559}')
end
local hekd_quest = 'Complete the quest %s from {npc:126334}.' .. '|FFFF8C00'.. hekd_note ..'|r'
local hekd_item = 'Loot a %s from %s near the trashpile and bring it to {npc:126334}.' .. '|FFFF8C00'.. hekd_note ..'|r'

L['charged_junk_note'] = format(hekd_item, '{item:158910}', '{npc:135727s}')
L['feathered_junk_note'] = format(hekd_item, '{item:157794}', '{npc:132410s}')
L['golden_junk_note'] = format(hekd_item, '{item:156963}', '{npc:122504s}')
L['great_hat_junk_note'] = format(hekd_quest, '{quest:50381}')
L['hunter_junk_note'] = format(hekd_quest, '{quest:50332}')
L['loa_road_junk_note'] = format(hekd_quest, '{quest:50444}')
L['nazwathan_junk_note'] = format(hekd_item, '{item:157802}', '{npc:131155s}')
L['redrock_junk_note'] = format(hekd_item, '{item:158916}', '{npc:134718s}')
L['ringhorn_junk_note'] = format(hekd_item, '{item:158915}', '{npc:130316s}')
L['saurid_junk_note'] = format(hekd_quest, '{quest:50901}')
L['snapjaw_junk_note'] = format(hekd_item, '{item:157801}', '{npc:126723s}')
L['vilescale_junk_note'] = format(hekd_item, '{item:157797}', '{npc:125393s}')
L['options_icons_get_hekd'] = '{achievement:12482}'
L['options_icons_get_hekd_desc'] = 'Display tasks for {npc:126334} locations for the {achievement:12482} achievement.'

L['options_icons_mushroom_harvest'] = '{achievement:13027}'
L['options_icons_mushroom_harvest_desc'] = 'Display fungarian villain locations for the {achievement:13027} achievement.'

L['options_icons_tales_of_de_loa'] = '{achievement:13036}'
L['options_icons_tales_of_de_loa_desc'] = 'Display tablet locations for the {achievement:13036} achievement.'

L['jani_note'] = 'Click on the {object:Mysterious Trashpile} to reveal {npc:126334}.'
L['rezan_note'] = '{note:Inside the {location:Atal\'Dazar} dungeon.}'
L['bow_to_your_masters_note'] = 'Bow to the loa of {location:Zandalar} ({emote:/bow}).'
L['options_icons_bow_to_your_masters'] = '{achievement:13020}'
L['options_icons_bow_to_your_masters_desc'] = 'Display loa locations for the {achievement:13020} achievement.'

L['alisha_note'] = 'This vendor requires quest progress in {location:Drustvar}.'
L['elijah_note'] = 'This vendor requires quest progress in {location:Drustvar}. He begins selling sausage after {quest:47945}.'
L['raal_note'] = '{note:Inside the {location:Waycrest Manor} dungeon.}'
L['sausage_sampler_note'] = 'Eat one of every sausage to earn the achievement.'
L['options_icons_sausage_sampler'] = '{achievement:13087}'
L['options_icons_sausage_sampler_desc'] = 'Display vendor locations for the {achievement:13087} achievement.'

-- For Horde, include a note about drinks that must be purchased on the AH
local horde_sheets = (UnitFactionGroup('player') == 'Horde') and [[ The following drinks are unavailable to Horde and must be purchased on the auction house:

• {item:163639}
• {item:163638}
• {item:158927}
• {item:162026}
• {item:162560}
• {item:163098}
]] or ''
L['three_sheets_note'] = 'Acquire one of every drink to earn the achievement.' .. horde_sheets
L['options_icons_three_sheets'] = '{achievement:13061}'
L['options_icons_three_sheets_desc'] = 'Display vendor locations for the {achievement:13061} achievement.'

L['options_icons_daily_chests_desc'] = 'Display locations of chests (lootable daily).'
L['options_icons_daily_chests'] = 'Chests'

L['supply_chest'] = 'War Supply Chest'
L['supply_chest_note'] = 'A {npc:135181} or {npc:138694} will fly overhead once every 45 minutes and drop a {npc:135238} at one of three potential drop locations.'
L['supply_single_drop'] = '{note:This flight path always drops the supply crate at this location.}'
L['options_icons_supplies_desc'] = 'Display {npc:135238} drop locations.'
L['options_icons_supplies'] = '{npc:135238s}'

L['secret_supply_chest'] = 'Secret Supply Chest'
L['secret_supply_chest_note'] = 'When a faction assault is active, a {object:Secret Supply Chest} can appear at one of these locations for a short time.'
L['options_icons_secret_supplies'] = 'Secret Supply Chests'
L['options_icons_secret_supplies_desc'] = 'Display {object:Secret Supply Chest} locations for the {achievement:13317} achievement.'

L['squirrels_note'] = 'You must use the emote {emote:/love} on critters not battle pets.'
L['options_icons_squirrels'] = '{achievement:14730}'
L['options_icons_squirrels_desc'] = 'Display the locations of critters for {achievement:14730} achievement.'

L['options_icons_battle_safari'] = '{achievement:12930}'
L['options_icons_battle_safari_desc'] = 'Display battle pet locations for the {achievement:12930} achievement.'
L['options_icons_mecha_safari'] = '{achievement:13693}'
L['options_icons_mecha_safari_desc'] = 'Display battle pet locations for the {achievement:13693} achievement.'
L['options_icons_nazja_safari'] = '{achievement:13694}'
L['options_icons_nazja_safari_desc'] = 'Display battle pet locations for the {achievement:13694} achievement.'

--SL
----------------------------------------------------------------------------
---------------------------------- COVENANTS ----------------------------------
-------------------------------------------------------------------------------

L['covenant_required'] = 'Requires a member of the %s covenant.'
L['anima_channeled'] = 'anima channeled to %s.'

-------------------------------------------------------------------------------
--------------------------------- SHADOWLANDS ---------------------------------
-------------------------------------------------------------------------------

L['squirrels_note'] = 'You must use the emote {emote:/love} on critters not battle pets.'
L['options_icons_squirrels'] = '{achievement:14731}'
L['options_icons_squirrels_desc'] = 'Display the locations of critters for {achievement:14731} achievement.'

L['options_icons_safari'] = '{achievement:14867}'
L['options_icons_safari_desc'] = 'Display battle pet locations for the {achievement:14867} achievement.'

-------------------------------------------------------------------------------
--------------------------------- ARDENWEALD ----------------------------------
-------------------------------------------------------------------------------

L['deifir_note'] = 'Ride the rare around in a circle and use {spell:319566} and {spell:319575} to slow and stun him.'
L['faeflayer_note'] = 'In a small cave hidden behind a waterfall.'
L['gormbore_note'] = 'Kill {npc:165420s} over the rumbling ground to spawn the rare.'
L['gormtamer_tizo_note'] = 'Kill {npc:Bristlecone Sprites} in the {location:Mistveil Tangle} until {npc:164110} spawns.'
L['humongozz_note'] = 'Plant an {item:175247} in the {object:Damp Loam} to spawn a {npc:164122}. The mushroom drops from numerous mobs in the zone.'
L['lehgo_note'] = 'Destroy {object:Quivering Gorm Eggs} and kill {npc:171827} until he spawns. In a cave (entrance to the south-east in the {location:Dusty Burrows}).'
L['macabre_note'] = [[
Spawns in multiple locations. To summon, stand in the {object:Mysterious Mushroom Ring} with 2 other players and dance with each other.

• Player 1 dances with Player 2
• Player 2 dances with Player 3
• Player 3 dances with Player 1
]]
L['mymaen_note'] = 'Kill {npc:Rotbriar sprites} in the area until he emotes and spawns.'
L['rainbowhorn_note'] = [[
Find and click the {object:Great Horn of the Runestag} to summon the rare. The horn can spawn in multiple places across {location:Ardenweald}.

He will always spawn north of {location:Tirna Vaal}, so set your {item:6948} there and watch for the zone emote.

|cffff5400T|r|cffffaa00A|r|cffffff00S|r|cffaaff00T|r|cff54ff00E|r |cff00ff55T|r|cff00ffa9H|r|cff00ffffE|r |cff0055ffR|r|cff0000ffA|r|cff5400ffI|r|cffaa00ffN|r|cffff00ffB|r|cffff00aaO|r|cffff0054W|r|cffff0000!|r
]]
L['rootwrithe_note'] = 'Poke the {npc:167928s} until the rare appears.'
L['rotbriar_note'] = 'Talk to {npc:171684} nearby to summon the rare after some dialog.'
L['slumbering_note'] = 'Running into the fog will stun and port you out. Use a flare or a pet with AOE to knock him out of the fog.'
L['skuld_vit_note'] = 'In a cave blocked by a barrier. A Night Fae must use {spell:310143} to enter the cave. Once he is pulled, the barrier will disappear.'
L['valfir_note'] = 'Click the {object:Sparkling Animaseed} midway down the path and use {spell:338045} to remove his {spell:338038} buff.'
L['wrigglemortis_note'] = 'Pull the {npc:164179} to spawn the rare.'

L['night_mare_note'] = [[
Travel to {location:Tirna Scithe} and follow the root path on the northwest cliff to a broken cart. There you can loot a {item:181243} on the ground.

Take this item to {npc:165704} at {location:Glitterfall Basin}. She will give you a {item:181242} in exchange for 10 {item:173204}. {note:If she is not there, you must complete the |cFFFFFD00Trouble at the Gormling Corral|r and |cFFFFFD00Tricky Spriggans|r quest lines.}

Next, talk to {npc:160262} in the {location:Heart of the Forest} to exchange the {item:181242} for a {item:178675}. Talk to the guards to have her come outside if you are not a Night Fae. Use this item to get {spell:327083} buff, allowing you to see the {npc:168135}.
]]

L['star_lake'] = 'Star Lake Amphitheater'
L['star_lake_note'] = [[
Talk to {npc:171743}, the Stage Director, to start one of the special encounters. The encounter changes each day.

Participate in all seven encounters to unlock {item:180748} from {npc:163714}.
]]

L['cache_of_the_moon'] = 'Collect {npc:171360}\'s five missing tools in the {location:Garden of Night} and combine them to create {item:180753}. Return her toolkit and she will cast {spell:334353} on you, allowing you to see the cache.'
L['cache_of_the_night'] = 'Collect {item:180656}, {item:180654} and {item:180655} from across the zone and combine them to create {item:180652}.'
L['darkreach_supplies'] = 'Jump on the {npc:169995} and glide southwest into the hollowed spire directly above the {object:Cache of the Night} treasure.'
L['desiccated_moth'] = 'Jump on the {npc:169997} northwest of the tree to float onto a branch. Burn {item:180784} in the {object:Incense Burner} to collect the treasure.'
L['dreamsong_heart'] = 'Use the {npc:169997} beneath the tree to get launched into the tree.'
L['elusive_faerie_cache'] = 'Pick up the {spell:333923} in the northeast corner of {location:Eventide Grove} and use it to loot the chest.'
L['enchanted_dreamcatcher'] = 'Hanging from the top of the roots. Easiest to jump up on the west side.'
L['faerie_trove'] = 'Located underneath the platform.'
L['harmonic_chest'] = 'Requires two people. One person plays the harp and the other plays the drum to unlock the chest.'
L['hearty_dragon_plume'] = 'Click {spell:333554} at the top of the nearby waterfalls and use it to float down onto the branch.'
L['old_ardeite_note'] = 'Kill {npc:160747} and {npc:160748} in {location:Shimmerbough} to the southeast for {item:174042}. Use this item to fly up near the rare and tag it.'
L['swollen_anima_seed'] = 'A large seed sitting inside a tree trunk.'

L['playful_vulpin_note'] = [[
Find and use the correct emote on the {npc:171206} five times to obtain the pet.

• begins to dig curiously = {emote:/curious}
• wanders around unable to sit still = {emote:/sit}
• sings all alone = {emote:/sing}
• dances with joy = {emote:/dance}
• sits down lonely and sad = {emote:/pet}
]]

L['tame_gladerunner'] = 'Tame Gladerunner'
L['tame_gladerunner_note'] = [[
Read the {object:Tale of the Tangle} and then follow the blue lamps through the path until you reach {npc:171767}. Kill him and then loot the {npc:171699}.

If you take a wrong path and {npc:171699} disappears when you reach the end, go back to the start and read {object:Tale of the Tangle} once more before trying again. If {npc:171767} is not there, you will have to wait for him to respawn.
]]

L['faryl_note'] = 'Let Ardenweald\'s defense be lead by the creatures in the sky.'
L['glitterdust_note'] = 'The creatures of Ardenweald may look docile, but they will defend their territory with the strength and courage of the mightiest champions ever known. Do you have what it takes?'

L['lost_book_note'] = 'Return this lost book to {npc:165867} in the {location:Grove of Memory}.'
L['options_icons_faerie_tales'] = '{achievement:14788}'
L['options_icons_faerie_tales_desc'] = 'Display lost books locations for the {achievement:14788} achievement.'

L['options_icons_wild_hunting'] = '{achievement:14779}'
L['options_icons_wild_hunting_desc'] = 'Ardenweald beasts locations for {achievement:14779} achievement.'

L['options_icons_wildseed_spirits'] = 'Wildseed Spirits'
L['options_icons_wildseed_spirits_desc'] = 'Rewards from wildseed spirits'

L['divine_martial_spirit'] = 'Divine Martial Spirit'
L['divine_dutiful_spirit'] = 'Divine Dutiful Spirit'
L['divine_prideful_spirit'] = 'Divine Prideful Spirit'
L['divine_untamed_spirit'] = 'Divine Untamed Spirit'

L['martial_spirit_label'] = '{item:178874}'
L['dutiful_spirit_label'] = '{item:178881}'
L['prideful_spirit_label'] = '{item:178882}'
L['untamed_spirit_label'] = '{item:177698}'

L['0x_wildseed_root_grain'] = '0x {item:176832}'
L['1x_wildseed_root_grain'] = '1x {item:176832}'
L['2x_wildseed_root_grain'] = '2x or 3x {item:176832}'
L['4x_wildseed_root_grain'] = '4x {item:176832}'

L['soulshape_cat_note'] = [[
Target {npc:181694} and /soothe

Can appear at the center of the top of the 6 Great Trees around {location:Ardenweald}:

• {location:Dreamsong Fenn}
• {location:Glitterfall Basin}
• {location:Tirna Vaal}
• {location:Hibernal Hollow}
• {location:Heartwood Grove}
• {location:Claw's Edge}
]]
L['soulshape_corgi_note'] = [[
Target {npc:174608} and {emote:/pet}

A Corgi option will immediately become available when talking with {npc:181582}
]]
L['soulshape_well_fed_cat_note'] = [[
1. Collect {item:187811} from {location:Darkhaven}
2. Target {npc:182093} and {emote:/meow}
3. {emote:Ma'oh meows at you hungrily.}
4. Target {npc:182093} and use {item:187811}

A Cat Soul (Well Fed) option will immediately become available when talking with {npc:181582}
]]

-------------------------------------------------------------------------------
----------------------------------- BASTION -----------------------------------
-------------------------------------------------------------------------------

L['aegeon_note'] = 'Kill enemies in the surrounding area until {npc:171009} spawns as a reinforcement.'
L['ascended_council_note'] = 'With four other players, click the five temple {object:Vesper} at the same time to summon the {npc:170899} at {location:Aspirant\'s Crucible}.'
L['aspirant_eolis_note'] = 'Loot a nearby {item:180613} and read it with the NPC targeted to activate him.'
L['baedos_note'] = 'Carry {object:Cask of Fermenting Purian Fruit} from the surrounding area to {npc:161536} until he activates.'
L['basilofos_note'] = 'Move around the rock until a purple fixate marker appears over your head. Stand still and wait for four emotes to appear, then he will spawn.'
L['beasts_of_bastion'] = 'Beasts of Bastion'
L['beasts_of_bastion_note'] = 'Talk to {npc:161441} to summon one of the four beasts.'
L['bookkeeper_mnemis_note'] = 'Has a chance to spawn in place of the {npc:166867} units in the area.'
L['cloudfeather_patriarch_note'] = 'Kill {npc:158110s} in the area until the guardian engages you.'
L['collector_astor_note'] = 'Read all six chapters of {object:Mercia\'s Legacy} scattered around the room, then talk to {npc:157979} to receive {spell:333779}. Find the hidden {item:180569} in the surrounding area and return it to spawn the rare.'
L['corrupted_clawguard_note'] = 'Loot a {item:180651} in the room or in {location:Forgefire Outpost} up the hill and use it to repair the {npc:171300}.'
L['dark_watcher_note'] = 'Can only be seen while dead. Talk to her and she will cast {spell:332830} on you before attacking.'
L['demi_hoarder_note'] = 'Starts with 99 stacks of {spell:333874}, reducing damage taken. Stacks are slowly removed with damage. The rare will follow a path and despawn if it reaches the end.'
L['dionae_note'] = 'When she becomes immune, click the four {npc:163747} to break her shield.'
L['herculon_note'] = [[
Collect {item:172451} and use them to give {npc:158659} stacks of {spell:343531}. At 10 stacks, he will activate.

Motes can be collected from nearby {object:Depleted Anima Canisters} located in the room or just outside.

{note:Cannot be defeated during the {wq:Assault on the Vestibule} world quest.}
]]
L['reekmonger_note'] = 'Kill enemies in the {location:Temple of Courage} until {npc:171327} emotes and lands.'
L['repair_note'] = 'With two other players, click the {object:Ancient Incense} to summon.'
L['sotiros_orstus_note'] = 'Click the {object:Black Bell} to summon the rares.'
L['sundancer_note'] = 'Click the statue to obtain the {spell:332309} buff, then use a {item:180445} to glide to the rare and mount it.'
L['swelling_tear_note'] = 'Click the {npc:171012} to summon one of three rares. Tears can appear in multiple locations in the zone.'
L['unstable_memory_note'] = 'Can be spawned when {npc:171018s} are present. Drag one {npc:171018} into others to give it 10 stacks of {spell:333558}, turning it into the rare.'
L['wingflayer_note'] = 'To summon, click the {object:Horn of Courage} on the nearby table (southeast, up the stairs).'

L['broken_flute'] = 'Kill nearby {npc:170009} until they drop the {item:180536}, then use the tools to repair it.'
L['cloudwalkers_coffer'] = 'Cloudwalker\'s Coffer'
L['cloudwalkers_coffer_note'] = 'Use the large purple flowers to bounce up to the platform.'
L['experimental_construct_part'] = 'Loot a nearby {item:180534} and use it to repair the part. The anima has multiple spawn locations.'
L['larion_harness'] = 'Located inside the {location:Hall of Beasts}.'
L['memorial_offering'] = 'Find {npc:171526} at one of his locations across {location:Bastion} and purchase a {item:180788}. Place it in the drink tray near the chest to obtain the {item:180797}.'
L['scroll_of_aeons'] = 'Loot 2 {item:173973} in the center area and place them on the nearby {object:Tribute} platters to reveal the treasure.'
L['vesper_of_silver_wind'] = 'Vesper of the Silver Wind'
L['vesper_of_silver_wind_note'] = 'Complete the {achievement:14339} achievement and then talk to {npc:171732} near the {location:Spires of Ascension} entrance to forge a {item:180858}.'

L['gift_of_agthia'] = 'Click the lit torch near the broken bridge to the northwest and carry {spell:333320} from torch to torch until you reach the chest. Lighting the final torch will grant you {spell:333063}.'
L['gift_of_chyrus'] = 'Kneel in front of the chest to be granted {spell:333045}.'
L['gift_of_devos'] = [[
Southwest of the chest is a torch where you can pick up the {spell:333912}. Mounting, entering combat or taking damage will drop the flame. You must make your way back to the chest and place the flame in the {object:Brazier of Devotion} to be granted {spell:333070}.

Before picking up the flame, clear all mobs in front of the chest. While running the flame, click any {npc:156571} along the way for a {spell:335012} debuff that increases movement speed.
]]
L['gift_of_thenios'] = [[
Behind the chest is a flight pad called {object:Path of Wisdom}. This leads to a sequence of platforms with different incenses you can commune with:

• {object:Incense of Knowledge}
• {object:Incense of Patience}
• {object:Incense of Insight}
• {object:Incense of Judgement}

Commune with them in the order Patience => Knowledge => Insight. On the Judgement platform an orb called the {object:Path of Judgement} will appear.

The orb will take you to the true {object:Incense of Judgment}. Commune with it and the final flight pad will grant you {spell:333068} to open the chest.
]]
L['gift_of_vesiphone'] = 'Ring one of the bells to spawn a {npc:170849} and kill it to receive the {spell:333239} debuff. The falling water opposite the chest will cleanse this debuff and grant you {spell:332785}.'

L['count_your_blessings_note'] = 'Place a {item:178915} in the {object:Tribute} bowl to receive the blessing.'
L['options_icons_blessings'] = '{achievement:14767}'
L['options_icons_blessings_desc'] = 'Display {object:Tributes} locations for the {achievement:14767} achievement.'

L['vesper_of_courage'] = 'Vesper of Courage'
L['vesper_of_humility'] = 'Vesper of Humility'
L['vesper_of_loyalty'] = 'Vesper of Loyalty'
L['vesper_of_purity'] = 'Vesper of Purity'
L['vesper_of_wisdom'] = 'Vesper of Wisdom'
L['vespers_ascended_note'] = 'Click this vesper at the same time as the other four vespers to summon the {npc:170899} at {location:Aspirant\'s Crucible}.'
L['options_icons_vespers'] = '{achievement:14734}'
L['options_icons_vespers_desc'] = 'Display vesper locations for the {achievement:14734} achievement.'

L['anima_shard'] = 'Anima Crystal Shard'
L['anima_shard_61225'] = 'On a lower platform below the bridge.'
L['anima_shard_61235'] = 'On a ledge above the waterfall.'
L['anima_shard_61236'] = 'On top of an arch halfway up the main structure.'
L['anima_shard_61237'] = 'On a ledge just above the water.'
L['anima_shard_61238'] = 'In the water beneath a small bridge.'
L['anima_shard_61239'] = 'On top of a thin stone column.'
L['anima_shard_61241'] = 'Above the entrance to the {location:Chamber of First Reflection}.'
L['anima_shard_61244'] = 'On a rock in the side of the cliff.'
L['anima_shard_61245'] = 'On a rock above a small waterfall.'
L['anima_shard_61247'] = 'On the wall above a small water fixture.'
L['anima_shard_61249'] = 'Hidden behind a stone column on the upper level of {location:Purity\'s Pinnacle}.'
L['anima_shard_61250'] = 'Sitting behind a staircase.'
L['anima_shard_61251'] = 'Sitting beneath a small bell.'
L['anima_shard_61253'] = 'On top of a fallen stone archway.'
L['anima_shard_61254'] = 'On top of a small wooden structure.'
L['anima_shard_61257'] = 'On a small ledge directly beneath {npc:162523}.'
L['anima_shard_61258'] = 'On a small ledge on the underside of {location:Hero\'s Rest}.'
L['anima_shard_61260'] = 'On the ground under the platform.'
L['anima_shard_61261'] = 'On a ledge above {npc:163460}\'s cave.'
L['anima_shard_61263'] = 'On top of a stone pillar.'
L['anima_shard_61264'] = 'On top of a tilted structure.'
L['anima_shard_61270'] = 'Sitting at the base of a tree.'
L['anima_shard_61271'] = 'In a bookcase on the upper platform.'
L['anima_shard_61273'] = 'On a ledge directly below the jutting cliff.'
L['anima_shard_61274'] = 'Hidden beneath the platform.'
L['anima_shard_61275'] = 'In the {location:Hall of Beasts} behind some barrels.'
L['anima_shard_61277'] = 'On top of a thin stone column.'
L['anima_shard_61278'] = 'Underneath the bridge on a rock.'
L['anima_shard_61279'] = 'On top of a thin stone column.'
L['anima_shard_61280'] = 'On the corner of the table.'
L['anima_shard_61281'] = 'On a ledge above the {object:Memorial Offerings} treasure.'
L['anima_shard_61282'] = 'On a ledge below the cliff top.'
L['anima_shard_61283'] = 'In a cave under {location:Miri\'s Chapel}, behind some barrels.'
L['anima_shard_61284'] = 'On a ledge under a rocky overhang, path to the south.'
L['anima_shard_61285'] = 'At the end of a small rock ledge.'
L['anima_shard_61286'] = 'On a ledge overlooking the path.'
L['anima_shard_61287'] = 'On a ledge above the small waterfall.'
L['anima_shard_61288'] = 'On the tip of a small ledge.'
L['anima_shard_61289'] = 'On top of the gazebo.'
L['anima_shard_61290'] = 'At the end of a narrow rock ledge.'
L['anima_shard_61291'] = 'At the bottom of the pond by the feet of a statue.'
L['anima_shard_61292'] = 'On top of the stone archway.'
L['anima_shard_61293'] = 'On top of a thin stone column on the lower level.'
L['anima_shard_61294'] = 'Hidden behind a stack of barrels.'
L['anima_shard_61295'] = 'Behind {npc:156889} in a bookshelf.'
L['anima_shard_61296'] = 'Behind the large fallen bell.\n\n{note:Inside the {location:Necrotic Wake} dungeon.}'
L['anima_shard_61297'] = 'Behind a stone pillar.\n\n{note:Inside the {location:Necrotic Wake} dungeon.}'
L['anima_shard_61298'] = 'Sitting behind a lounge chair.'
L['anima_shard_61299'] = 'Hidden behind a large torch.'
L['anima_shard_61300'] = 'On a ledge hanging over the central font.'
L['anima_shard_spires'] = 'Three shards are located in the {location:Spires of Ascension} dungeon.'
L['options_icons_anima_shard'] = '{achievement:14339}'
L['options_icons_anima_shard_desc'] = 'Display the locations of all 50x {object:Anima Crystal Shard} for the {achievement:14339} achievement.'

L['hymn_note'] = 'Locate {object:Hymns} at each of the temples and acquire their buffs to earn the achievement.'
L['options_icons_hymns'] = '{achievement:14768}'
L['options_icons_hymns_desc'] = 'Display {object:Hymns} locations for the {achievement:14768} achievement.'

L['stratios_note'] = 'Even the smallest battles should be fought with honor and care. Present your team when you are ready.'
L['thenia_note'] = 'Such magnificent open plains here. A glorious place to battle. Are you prepared?'
L['zolla_note'] = 'We take our defenses very seriously. Whether small or large, we are fully committed to maintain and train the resources that keep Bastion strong.'

L['soulshape_otter_soul'] = 'Target {npc:181682} and {emote:/hug}'

-------------------------------------------------------------------------------
----------------------------------- KORTHIA -----------------------------------
-------------------------------------------------------------------------------

L['carriage_crusher_note'] = 'Follow the {npc:180182} into {location:The Maw} and defend it until the {npc:180246} attacks.'
L['chamber_note'] = 'Use a {item:186718} from {npc:178257} on the {object:Ancient Teleporter} to access the chamber.'
L['consumption_note'] = [[
This rare will not drop loot until after it consumes 40x {npc:179758} to transform into its blue-shaded form (Rare).

This rare will drop extra research items after it consumes *another* 40x {npc:179758} to transform into its green-shaded form (Rare Elite).

{note:The rare will not spawn {npc:179758} to consume while in combat.}
]]
L['darkmaul_note'] = 'Collect {item:187153} from {object:Invasive Mawshroom} and feed them to {npc:180063}. You must complete the event 10 times to obtain the mount.'
L['dislodged_nest_note'] = 'Click on a nearby {object:Noxious Moth} to gain {spell:355181}. Use the {spell:355131} extra action button on {npc:178547} to gain control and ride it into the tree the nest is in.'
L['escaped_wilderling_note'] = 'Click on the {npc:180014} to start the taming event.'
L['flayedwing_transporter_note'] = 'Click on {npc:178633} to fly to or from the {location:Vault of Secrets}.'
L['fleshwing_note'] = 'Talk to {npc:180079} to start the collection event.'
L['forgotten_feather_note'] = 'Floating on a small island accessed by jumping down from {location:Keeper\'s Respite}.'
L['konthrogz_note'] = 'Spawns from a devourer\'s portal event. The event can appear in many places throughout {location:Korthia}.'
L['sl_limited_rare'] = '{note:This rare is not available on some days.}'
L['krelva_note'] = 'Moves to another platform at 80%, then moves to the mainland at 60%. {note:You must tag the rare after 60% to get kill credit!}'
L['kroke_note'] = 'Slay {npc:179029s} in the area until he appears. Cannot spawn on days when {npc:179029s} are missing.'
L['maelie_wanderer'] = '{npc:179912} will spawn in a set location for the day. Once you have used {spell:355862} on her 6 different days return to {npc:179930} to earn the mount.'
L['malbog_note'] = 'Talk to {npc:179729} to gain {spell:355078} and follow the foot prints until you find the {object:Fleshy Remains}.'
L['offering_box_note'] = 'Requires {item:187033} which can be found on the top of the west side wall of the near by ruins.'
L['pop_quiz_note'] = 'The Pop Quiz event will spawn randomly on the map. Click on the {object:Abandoned Veilstaff} and answer the questions from {npc:180162}.'
L['razorwing_note'] = 'Hand in 10x {item:187054} dropped by {npc:Devourer} in the area.'
L['reliwik_note'] = 'Click on the {object:Uncorrupted Razorwing Egg} to pull him down.'
L['spectral_bound_chest'] = 'Spectral Bound Chest'
L['spectral_bound_note'] = 'Click on 3 nearby {object:Spectral Key} to unlock the chest.'
L['stonecrusher_note'] = 'Talk to {npc:179974} to start the event.'
L['towering_exterminator_note'] = 'Spawns from a mawsworn portal event. The event can appear in many places throughout {location:Korthia}.'
L['worldcracker_note'] = 'Talk to {npc:180028} to trigger the escort event.'

L['archivist_key_note'] = 'Purchase %s from {npc:178257} to unlock.'
L['korthian_shrine_note'] = 'Click on the shrine to gain {spell:352367} to see the hidden path to the altar.'
L['num_research'] = '%d Research'
L['plus_research'] = '+Research'
L['options_icons_relic'] = '{achievement:15066}'
L['options_icons_relic_desc'] = 'Display the locations of all 20 relics for {achievement:15066} achievement.'

L['rift_portal_note'] = [[
Enter {location:The Rift}, an alternate phase of {location:Korthia} and {location:The Maw} with additional rares, relics and caches.

Requires a {item:186731}, which can be purchased from {npc:178257} once you reach tier 4 with {faction:2472}. The keys also have a low chance to drop from rares and caches in the zone.

{note:Not all rift portals are active at any given time.}
]]
L['rift_rare_only_note'] = 'This rare can only be seen and killed inside {location:The Rift} phase.'
L['rift_rare_exit_note'] = [[
This rare will exit {location:The Rift} phase once interacted with inside {location:The Rift}.

{location:The Rift} three rares typically spawn in a set order at about a 20 minute interval:

  1. {npc:179913}
  2. {npc:179608}
  3. {npc:179911}
]]
L['options_icons_rift_portal'] = '{npc:179595s}'
L['options_icons_rift_portal_desc'] = 'Display the locations of {npc:179595s} used to enter {location:The Rift}.'

L['riftbound_cache'] = 'Riftbound Cache'
L['riftbound_cache_note'] = 'There are 4 unique caches that can each appear at set locations inside {location:The Rift}.'
L['options_icons_riftbound_cache'] = 'Riftbound Caches'
L['options_icons_riftbound_cache_desc'] = 'Display the locations of {object:Riftbound Caches} inside {location:The Rift}.'

L['invasive_mawshroom'] = 'Invasive Mawshroom'
L['invasive_mawshroom_note'] = 'There are 5 unique mawshrooms that can each appear at set locations.'
L['mawsworn_cache'] = 'Mawsworn Cache'
L['mawsworn_cache_note'] = 'There are 3 unique caches that can each appear at set locations.'
L['pile_of_bones'] = 'Pile of Bones'
L['relic_cache'] = 'Relic Cache'
L['shardhide_stash'] = 'Shardhide Stash'
L['korthia_shared_chest_note'] = 'Can be looted 5 times for relics. Progress resets every 30 minutes, making them effectively unlimited.'
L['unusual_nest'] = 'Nest of Unusual Materials'
L['unusual_nest_note'] = 'All 5 nest locations can be looted each day.'

L['options_icons_invasive_mawshroom_desc'] = 'Display the locations of {object:Invasive Mawshrooms}.'
L['options_icons_invasive_mawshroom'] = 'Invasive Mawshrooms'
L['options_icons_korthia_dailies_desc'] = 'Display the locations of unmarked {object:Relic Caches}.'
L['options_icons_korthia_dailies'] = 'Relic Caches'
L['options_icons_mawsworn_cache_desc'] = 'Display the locations of {object:Mawsworn Caches}.'
L['options_icons_mawsworn_cache'] = 'Mawsworn Caches'
L['options_icons_nest_materials_desc'] = 'Display the locations of {object:Nest of Unusual Materials}.'
L['options_icons_nest_materials'] = 'Nest of Unusual Materials'

-------------------------------------------------------------------------------
--------------------------------- MALDRAXXUS ----------------------------------
-------------------------------------------------------------------------------

L['chelicerae_note'] = 'Destroy the {npc:159885} to activate the rare.'
L['deepscar_note'] = 'Can appear in multiple entrances to the {location:Theater of Pain}.'
L['forgotten_mementos'] = 'Pull the {object:Vault Portcullis Chain} in the chamber west of the treasure to open the gate.'
L['gieger_note'] = 'Pull the {npc:162815} to activate the rare.'
L['gristlebeak_note'] = 'Break all nearby {npc:162761} to engage the rare.'
L['leeda_note'] = 'Kill the two {npc:162220s} until the rare spawns.'
L['nirvaska_note'] = 'Only appears when the {wq:Deadly Reminder} world quest is active.'
L['ravenomous_note'] = 'Squash {npc:159901s} in the area until the rare spawns.'
L['sabriel_note'] = 'Can appear as one of the champions in the {location:Theater of Pain}.'
L['schmitd_note'] = 'Use nearby {spell:313451} to break his shield.'
L['tahonta_note'] = 'The mount only drops if you have {npc:159239} with you!'
L['taskmaster_xox_note'] = 'Shares a spawn with {npc:160204}, {npc:160230} and {npc:160226}.'
L['theater_of_pain_note'] = 'Your first boss kill each day has a chance to drop the mount.'
L['zargox_the_reborn_note'] = [[
Use {item:175841} on top of the {npc:157124}. To obtain the orb, you must complete the quest {quest:57245} from {npc:157076} and talk to him again.

If the {npc:157124} is not up, reanimate {npc:157132} in the area until it appears.
]]
L['mixed_pool_note'] = [[
Gather ingredients from the surrounding mobs and toss them into the pool. Once 30 ingredients have been added, one of seven rares will spawn depending on the combination used.

• Collect {spell:306713} from {npc:167923} and {npc:167948} to the north.

• Collect {spell:306719} from {npc:165015} and {npc:171142} to the south.

• Collect {spell:306722} from {npc:165027} and {npc:166438} to the south.

Kill each rare once to earn the {item:183903} toy.
]]

L['blackhound_cache'] = 'Blackhound Cache'
L['blackhound_cache_note'] = 'Summon {npc:157843} at the {location:Abomination Factory}, then escort him to the {location:Blackhound Outpost}.'
L['bladesworn_supply_cache'] = 'Bladesworn Supply Cache'
L['cache_of_eyes'] = 'Cache of Eyes'
L['cache_of_eyes_note'] = 'Spawns at multiple locations within the {location:Sightless Hold}.'

L['glutharns_note'] = 'In a cave behind the waterfall of slime. Kill {npc:172485} and both {npc:172479} to unlock the chest.'
L['kyrian_keepsake_note'] = 'Inspect the {npc:169664} to loot the treasure.'
L['misplaced_supplies'] = 'On top of the giant mushroom. Run up the hill and jump onto the smaller brown mushroom, then run up the larger hill and jump onto the giant mushroom.'
L['necro_tome_note'] = 'To get access to the tower, you have to start a small quest line from {npc:166657}. In a bookcase on the top floor.'
L['plaguefallen_chest_note'] = [[
Stand in the green slime (requires healing!) to get 10 stacks of {spell:330069} and be transformed into a {spell:330092}.

Once transformed, visit the cave underneath {npc:158406}'s platform (entrance on the east side) and click the pipe to transport to the chest.
]]
L['ritualists_cache_note'] = 'Pick up the {item:181558} on the floor and use them to complete the {object:Book of Binding Rituals}.'
L['runespeakers_trove_note'] = 'Find {npc:170563} to the east and kill him to obtain the {item:181777}.'
L['stolen_jar_note'] = 'Spawns in multiple different caves.'
L['strange_growth_note'] = 'Pull on the {npc:165037} to reveal the treasure.'
L['vat_of_slime_note'] = 'Click the bottle on the table and then click on the vat of slime.'

L['giant_cache_of_epic_treasure'] = 'Giant Cache of Epic Treasure'
L['spinebug_note'] = [[
Oh look! A {spell:343124}! Approach it brave adventurer, this is surely not a ruse. Wait, is that the music from Karazhan? What is this {npc:174663} doing here ...?

{spell:343163}!
]]

L['oonar_sorrowbane_note'] = [[
In the {location:Theater of Pain}, you will find {item:180273} stuck in the ground and {item:181164} attached to it. To pull them free:

• Purchase a {item:182163} from {npc:171808} in {location:Revendreth}.
• Purchase a {item:180771} from {npc:166640} in {location:Maldraxxus}.
• Purchase a {item:181163} from {npc:169964} in {location:Maldraxxus}.
• Get 2 stacks of {spell:306272} from the {wq:A Few Bumps Along the Way} world quest to the west.
• Eat 4x {spell:327367} in {location:Glutharn's Decay}.
• Quickly use {item:181163}, drink both potions and pull on the arm and sword.

To pull just the arm, only the 4x {spell:327367} are needed.
]]

L['pet_cat'] = 'Pet the damn cat!'
L['hairball'] = '{note:Only appears in the {location:Festering Sanctum} inside the {location:Plaguefall dungeon}!}'
L['lime'] = 'Sitting on top of the large bone arch.'
L['moldstopheles'] = 'Run around the back of the stalk and jump up the mushroom platforms. For the final platform, use a mount and jump at the corner where it meets the stalk.'
L['pus_in_boots'] = 'Located under the bridge.'

L['options_icons_slime_cat'] = '{achievement:14634}'
L['options_icons_slime_cat_desc'] = 'Display locations of kittens for the {achievement:14634} achievement.'

L['dundley_note'] = 'I\'ll battle my way to victory and gain the respect I finally deserve. The only downside is everything I own is now sticky. Everything.'
L['maximillian_note'] = 'I have waited dozens of years for a worthy opponent. To the victor go the spoils!'
L['rotgut_note'] = 'Rotgut. Leftovers. Extra pieces. You fight.'

L['ashen_ink_label'] = '{item:183690}'
L['ashen_ink_note'] = 'Random drop from {npc:157125}'

L['jagged_bonesaw_label'] = '{item:183692}'
L['jagged_bonesaw_note'] = 'Random drop from {npc:159105}'

L['discarded_grimoire_label'] = '{item:183394}'
L['discarded_grimoire_note'] = 'Complete {quest:62297} given by {npc:174020}'

L['sorcerers_blade_label'] = '{item:183397}'
L['sorcerers_blade_note'] = 'Complete {quest:62317} given by {object:Sorcerer\'s Note} inside the {location:Vault of Souls}. Down the stairs and to the left on the bookcase.'

L['mucosal_pigment_label'] = '{item:183691}'
L['mucosal_pigment_note'] = 'Drops from any slime, droplet, ooze, rare, or giant near the {location:House of Plagues} or the area around {npc:162727}'

L['amethystine_dye_label'] = '{item:183401}'
L['amethystine_dye_note'] = 'Complete {quest:62320} given by {npc:174120}'

L['ritualists_mantle_label'] = '{item:183399}'
L['ritualists_mantle_note'] = 'Complete {quest:62308} given by {npc:172813}. Requires 3 people to summon {npc:174127}.'

L['options_icons_crypt_couture'] = '{achievement:14763}'
L['options_icons_crypt_couture_desc'] = 'Necrotic Acolyte disguise customization locations for {achievement:14763} achievement.'

L['soulshape_saurid_note'] = 'In a small cave. Target the {npc:182105} and {emote:/bow}'

-------------------------------------------------------------------------------
--------------------------------- REVENDRETH ----------------------------------
-------------------------------------------------------------------------------

L['amalgamation_of_filth_note'] = 'When the world quest {wq:Dirty Job: Demolition Detail} is available click on a {object:Rubbish Box} and use {spell:324115} into the water.'
L['amalgamation_of_light_note'] = 'Move all three {object:Mirror Trap} to release the rare.'
L['amalgamation_of_sin_note'] = 'During the {wq:Summon Your Sins} world quest, pick the {object:Catalyst of Power} for a chance to obtain {item:180376}, then use the item to summon the rare.'
L['bog_beast_note'] = 'Has a chance to spawn during the world quest {wq:Muck It Up} after using {item:177880} on a {npc:166206}.'
L['endlurker_note'] = 'Click {object:Anima Stake} near {npc:165229} corpse and use {spell:321826} on top of the {location:Shimmering Rift}.'
L['executioner_aatron_note'] = 'Kill the three nearby {npc:166715} to remove {spell:324872}.'
L['executioner_adrastia_note'] = 'Free {npc:161299s} in the surrounding area and escort them until they despawn. {npc:161310} will eventually spawn to squash the insurrection.'
L['famu_note'] = 'Talk to {npc:166483} to trigger the event.'
L['grand_arcanist_dimitri_note'] = 'Kill the four {npc:167467} to release the rare.'
L['harika_note'] = 'In {location:Dredhollow} to the west, loot the {item:176397}, then turn the bolt into {npc:165327} and tell him to bring down the rare.'
L['innervus_note'] = 'Kill nearby {npc:160375s} to obtain a {item:177223} and unlock the crypt.'
L['leeched_soul_note'] = 'Inside the nearby crypt. Walk near {npc:165151} to start the event.'
L['lord_mortegore_note'] = 'Kill surrounding mobs to obtain {item:174378} and use it to empower a {npc:161870}. The rare will spawn once all four sigils are empowered.'
L['madalav_note'] = 'Click {object:Madalav\'s Hammer} on the nearby anvil to summon him.'
L['manifestation_of_wrath_note'] = 'Has a chance to spawn when a {npc:169916} is recovered during the {wq:Swarming Souls} world quest.'
L['scrivener_lenua_note'] = 'Return {npc:160753} to the {location:Forbidden Library}.'
L['sinstone_hoarder_note'] = 'Attempt to loot the {npc:162503} and the rare will reveal itself.'
L['sire_ladinas_note'] = 'Pick up a {object:Remnant of Light} nearby and use {spell:313065} on {npc:157733}.'
L['soulstalker_doina_note'] = 'Follow downstairs and through the mirror when she runs away.'
L['tomb_burster_note'] = 'Can be spawned if {npc:155777} is trapped in a web. Kill nearby {npc:155769s} and waves of {npc:155795s} until the rare spawns.'
L['worldedge_gorger_note'] = [[
Obtain an {item:173939} from {npc:World Reavers}, {npc:Devourers} and {npc:Mites} in the {location:Banewood} and the {location:Endmire}. Use it to light the {object:Worldedge Brazier} and summon the rare.

Has a chance to drop an {item:180583}, which begins a 7 day quest line to obtain the {spell:333027} mount.
]]

L['dredglaive_note'] = 'Under the bridge in the {npc:173671} corpse.'
L['forbidden_chamber_note'] = 'Loot a {object:Discarded Anima Canister} in front of the locked door and learn {spell:340701}. Use it to drain five of the nearby {npc:173838s}, then use {spell:340866} in front of the {npc:173786}.'
L['gilded_plum_chest_note'] = 'Kill the {npc:166680} wandering up and down the road.'
L['lost_quill_note'] = 'Loot the {item:182475} from the bottle on the table in the {location:Forbidden Library}, then give it to the {npc:173449} on top of the archway outside.'
L['rapier_fearless_note'] = 'Click the {object:Rapier of the Fearless} on the ground, then defeat {npc:173603}.'
L['remlates_cache_note'] = 'On the outer wall of {location:Darkhaven} behind the crypt.'
L['smuggled_cache_note'] = '{bug:BEFORE YOU LOOT}: Make sure you have completed {quest:60480} side quest or you will miss out on 40 {currency:1820} from the treasure and quest.'
L['taskmaster_trove_note'] = 'Read the {object:Ingress and Egress Rites} then carefully make your way to the chest.'
L['the_count_note'] = 'Farm 99 {currency:1820} in the {location:Endmire} and then bring them to {npc:173488}.'

L['forgotten_anglers_rod'] = 'Forgotten Angler\'s Rod'

L['loyal_gorger_note'] = 'Visit the {location:Endmire} and complete a daily offered by your {npc:173498} 7 times to obtain him as a mount.'

L['sinrunner_note'] = 'Bring food and supplies to {npc:173468} for six days to obtain her reins. She only appears for a few minutes at a time.'
L['sinrunner_note_day1'] = 'Offer {npc:173468} 8x {item:182581} from farm areas in {location:Westfall}.'
L['sinrunner_note_day2'] = 'Obtain a {item:182585} from {npc:173570} in {location:Darkhaven} and use it to clean {npc:173468}.'
L['sinrunner_note_day3'] = 'Equip {npc:173468} with 4 {item:182595} found on the roads surrounding {location:Darkhaven}.'
L['sinrunner_note_day4'] = 'Pick up the {item:182620} near {npc:173570} and fill it with water from {location:Bastion} or {location:Ardenweald}. Return the {item:182599} to {npc:173468}.'
L['sinrunner_note_day5'] = 'Equip {npc:173468} with a {item:182597}, sold by {npc:171808} near the {location:Night Market} in exchange for assorted meats.'
L['sinrunner_note_day6'] = 'Feed {npc:173468} 3 {item:179271}, sold by {npc:167815} by the {location:Hole in the Wall}.'

L['options_icons_carriages'] = 'Carriages'
L['options_icons_carriages_desc'] = 'Display locations and paths of rideable carriages.'
L['options_icons_dredbats'] = '{npc:161015s}'
L['options_icons_dredbats_desc'] = 'Display locations and paths of {npc:161015s}.'
L['options_icons_sinrunners'] = '{npc:174032s}'
L['options_icons_sinrunners_desc'] = 'Display locations and paths of {npc:174032s}.'

L['addius_note'] = 'Weak minded beings should not waste my time, but if you insist, I will show you real pain.'
L['eyegor_note'] = 'Eyegor ready for battle!'
L['sylla_note'] = 'One can never expect to have a distinguished battle out here in this awful area, but alas here we are. Do not waste my time.'

L['avowed_ritualist_note'] = 'Bring nearby {npc:160149s} here to absolve them.'
L['fugitive_soul_note'] = 'Bring this {npc:160149} to a nearby {npc:166150} to begin a ritual of absolution.'
L['souls_absolved'] = 'souls absolved'
L['options_icons_fugitives'] = '{achievement:14274}'
L['options_icons_fugitives_desc'] = 'Display {npc:160149} locations for the {achievement:14274} achievement.'

L['grand_inquisitor_note'] = 'Turn in 10x {item:180451} to {npc:160248} for a chance at this sinstone.'
L['high_inquisitor_note'] = 'Turn in 250x {currency:1816} to {npc:160248} for a chance at this sinstone.'
L['inquisitor_note'] = 'Turn in 100x {currency:1816} to {npc:160248} for a chance at this sinstone.'
L['options_icons_inquisitors'] = 'Inquisitors'
L['options_icons_inquisitors_desc'] = 'Display inquisitors locations for the {achievement:14276} achievement.'

L['bell_of_shame_note'] = 'Every 30 minutes a random ghost will spawn next to {npc:176006}.\n\nRepair the {npc:176056} for 30 {currency:1820} and then ring the bell to receive a buff from the active ghost.\n\nOne of the ghosts, {npc:176043}, gives {spell:346708} which provides an increased {item:172957} drop rate within the surrounding {location:Halls of Atonement} area.'
L['atonement_crypt_label'] = 'Atonement Crypt'
L['atonement_crypt_note'] = 'Open an {object:Crypt Door} using an {item:172957}.'
L['atonement_crypts_opened'] = 'Atonement Crypts opened'
L['atonement_crypt_key_label'] = '{item:172957}'
L['atonement_crypt_key_note'] = [[
{item:172957} can drop from most mobs in the {location:Halls of Atonement} area.

{npc:158902}
{npc:176109}
{npc:158894}
{npc:156911}
{npc:158910}
{npc:176121}
{npc:176114}
{npc:156909}
{npc:156256}
{npc:176124}
{npc:156260}
{npc:159027}
{npc:158897}
{npc:176116}
{npc:158908}
{npc:176122}

The highest drop rate is from {npc:158892}.
]]
L['options_icons_crypt_kicker'] = '{achievement:14273}'
L['options_icons_crypt_kicker_desc'] = 'Display farming locations for the {achievement:14273} achievement.'

L['broken_mirror'] = 'Broken Mirror'
L['broken_mirror_note'] = 'A group of three {object:Broken Mirror} will be active each day. Use a {item:181363} to repair each mirror and open the {object:Forgotten Chest} inside.'
L['broken_mirror_crypt'] = 'Inside a crypt.'
L['broken_mirror_elite'] = 'In a small room with elite mobs.'
L['broken_mirror_group'] = 'Group'
L['broken_mirror_house'] = 'Inside the house.'
L['broken_mirror_61818'] = 'In a small room with {npc:173699}.'
L['broken_mirror_61819'] = 'In a small room on the ground floor.'
L['broken_mirror_61827'] = 'In a small room.'
L['options_icons_broken_mirror'] = 'Broken Mirrors'
L['options_icons_broken_mirror_desc'] = 'Display the locations of {object:Broken Mirrors}.'

L['soulshape_chicken_note'] = [[
1. Collect {item:187811} from {location:Darkhaven}
2. Target {npc:181660} and {emote:/chicken}
3. {emote:Lost Soul clucks at you hungrily.}
4. Target {npc:181660} and use {item:187811}
]]
L['spectral_feed_label'] = '{item:187811}'
L['spectral_feed_note'] = [[
{item:187811} is used to feed {npc:181660} in {location:Revendreth} for {item:187813}

{item:187811} is used to feed {npc:182093} in {location:Ardenweald} for |cFF00FF00[Well Fed Cat Soul]|r

{note:{item:187811} has a 10 minute timer and 60 minute respawn.}
]]

-------------------------------------------------------------------------------
----------------------------------- THE MAW -----------------------------------
-------------------------------------------------------------------------------

L['return_to_the_maw'] = 'Return to {location:The Maw}'
L['maw_intro_note'] = 'Begin the introductory quest chain from {npc:162804} to unlock rares and events in {location:The Maw}.'

L['apholeias_note'] = 'With 3 other players, stand on the corners of the platform and cast {spell:331783} to summon the rare.'
L['dekaris_note'] = 'On top of a large jutting rock.'
L['deomen_note'] = 'To open his cage, enter the chamber to the south and activate both lock controls on either side of the room.'
L['drifting_sorrow_note'] = 'Kill {npc:175246s} near the hovering orb to activate the boss.'
L['ekphoras_note'] = 'With 3 other players, stand on the corners of the platform and cast {spell:330650} to summon the rare.'
L['etherwyrm_note'] = 'Requires the Night Fae assault to be active. Kill an {npc:179030} while in {location:The Rift} to gain the {item:186190}. Use the key on the {object:Etherwyrm Cage} (outside {location:The Rift}) in the {location:Desolate Hollow cavern} (where {npc:175821} resides when the assault is not active).'
L['fallen_charger_note'] = 'After the zone-wide yell it will take either of the two paths until it reaches {location:Korthia} where it will despawn.'
L['ikras_note'] = 'Flies around {location:Perdition Hold}. This is a good place to pull him.'
L['lilabom_note'] = [[
Collect all 5 parts to complete the pet. Some parts may appear in multiple locations.

• {item:186183}
• {item:186184}
• {item:186185}
• {item:186186}
• {item:186187}
]]
L['orophea_note'] = 'Pick up {spell:337143} to the southeast and offer it to {npc:172577} to activate.'
L['sanngror_note'] = 'If he is not attackable, wait until he is not experimenting on souls.'
L['sly_note'] = 'Talk to {npc:179068} to get the buff {spell:353322} and find {npc:179096} on 3 different kyrian assaults.'
L['talaporas_note'] = 'With 3 other players, stand on the corners of the platform and cast {spell:331800} to summon the rare.'
L['valis_note'] = 'Click the three {npc:174810} in the correct order to summon the rare. The order changes each time and clicking the wrong rune deals damage and debuffs you with {spell:343636}.'
L['yero_note'] = 'Approach {npc:172862} and then follow him down into a nearby cave where he becomes hostile.'

L['exos_note'] = [[
Kill the other three Heralds of Grief, Pain and Loss to collect their etchings.

• {item:182328}
• {item:182326}
• {item:182327}

Combine all three etchings to create the {item:182329}, which can be used to summon the rare at the {location:Altar of Domination}. Use the {npc:173892} to reach the upper level.
]]

L['animaflow_teleporter_note'] = 'Activate to travel directly to other locations in {location:The Maw}.'
L['chaotic_riftstone_note'] = 'Activate to {spell:344157} quickly across {location:The Maw}.'
L['venari_note'] = [[
Use {currency:1767} to purchase {location:The Maw} and {location:Torghast} upgrades.

{note:Account-wide {location:Torghast} upgrades will show as incomplete on alts!}
]]
L['venari_upgrade'] = '{npc:162804} Upgrade'
L['torghast'] = 'Torghast'
L['Ambivalent'] = nil
L['Appreciative'] = nil
L['Apprehensive'] = nil
L['Cordial'] = nil
L['Tentative'] = nil

L['stygian_cache'] = 'Stygian Cache'
L['stygian_cache_note'] = 'Only one person can loot the cache each time it spawns!'

L['box_of_torments_note'] = 'Open the {npc:173837} under the {location:Tremaculum}.'
L['tormentors_notes_note'] = 'Loot the corpse of {npc:173811}.'
L['words_of_warden_note'] = 'Examine the {object:Paper Scrap} on a rock behind some pots.'

-- Locations given relative to a map area name
L['nexus_area_calcis_branch'] = 'Up on a crystal branch in {location:Calcis} (use grapple point)'
L['nexus_area_calcis_crystals'] = 'Behind some teal crystals in {location:Calcis}'
L['nexus_area_cradle_bridge'] = 'Beneath the bridge in {location:Ruin\'s Cradle}'
L['nexus_area_domination_bridge'] = 'On a bridge south of the {location:Altar of Domination}'
L['nexus_area_domination_edge'] = 'On the edge atop the {location:Altar of Domination}'
L['nexus_area_domination_room'] = 'In a small room atop the {location:Altar of Domination}'
L['nexus_area_domination_stairs'] = 'Atop the {location:Altar of Domination} next to the {npc:173904}'
L['nexus_area_gorgoa_bank'] = 'On the bank of the {location:Gorgoa, River of Souls}'
L['nexus_area_gorgoa_middle'] = 'Right in the middle of the river yo!'
L['nexus_area_gorgoa_mouth'] = 'At the mouth of the {location:Gorgoa, River of Souls}'
L['nexus_area_perdition_wall'] = 'Along the outer wall of {location:Perdition Hold}'
L['nexus_area_torment_rock'] = 'On a rock in the {location:Planes of Torment}'
L['nexus_area_zone_edge'] = 'Along the edge of the zone'
L['nexus_area_zovaal_edge'] = 'Along the edge of {location:Zovaal\'s Cauldron}'
L['nexus_area_zovaal_wall'] = 'Along the wall below {location:Zovaal\'s Cauldron}'
-- Locations given relative to a named cave/cavern
L['nexus_cave_anguish_lower'] = 'In the {location:Pit of Anguish} (lower level)'
L['nexus_cave_anguish_outside'] = 'Outside the {location:Pit of Anguish}'
L['nexus_cave_anguish_upper'] = 'In the {location:Pit of Anguish} (upper level)'
L['nexus_cave_desmotaeron'] = 'In a small cave outside the {location:Desmotaeron}'
L['nexus_cave_echoing_outside'] = 'Outside the {location:Echoing Caverns}'
L['nexus_cave_forlorn'] = 'Inside the {location:Forlorn Respite} cavern'
L['nexus_cave_howl_outside'] = 'On the ground outside the {location:Death\'s Howl} cavern'
L['nexus_cave_howl'] = 'Inside the {location:Death\'s Howl} cavern'
L['nexus_cave_roar'] = 'Inside the {location:Death\'s Roar} cavern'
L['nexus_cave_roar_outside'] = 'Outside the {location:Death\'s Roar} cavern'
L['nexus_cave_ledge'] = 'In a small cave below a ledge'
L['nexus_cave_prodigum'] = 'In a small cave in the {location:Prodigum}'
L['nexus_cave_soulstained'] = 'In a small cave in the {location:Soulstained Fields}'
L['nexus_cave_torturer'] = 'Inside the {location:Torturer\'s Hovel}'
-- Locations given relative to a named NPC
L['nexus_npc_akros'] = 'Atop the stairs next to {npc:170787}'
L['nexus_npc_dekaris'] = 'At the top of the peak where {npc:157964} resides'
L['nexus_npc_dolos'] = 'On the ground behind {npc:170711}'
L['nexus_npc_ekphoras'] = 'Next to {npc:169827}\'s platform'
L['nexus_npc_eternas'] = 'On the ground behind {npc:154330}'
L['nexus_npc_incinerator'] = 'On a small ledge below {npc:156203}'
L['nexus_npc_orophea'] = 'On the ground next to {npc:172577}'
L['nexus_npc_orrholyn'] = 'Found below {npc:162845}\'s platform'
L['nexus_npc_portal'] = 'On a small rock behind the {npc:167531}'
L['nexus_npc_talaporas'] = 'By the staircase to {npc:170302}\'s platform'
L['nexus_npc_thanassos'] = 'On the back of {npc:170731}\'s platform'
L['nexus_npc_willbreaker'] = 'In the corner behind a {npc:168233}'
-- Locations given relative to the main path/road nearby
L['nexus_road_below'] = 'On the ground below the main road'
L['nexus_road_cave'] = 'In a small cave below the road'
L['nexus_road_mawrats'] = 'In a pack of mawrats beside the road'
L['nexus_road_next'] = 'Next to the main path'
L['nexus_room_ramparts'] = 'In a small room below the ramparts'
-- Random locations described as best as possible
L['nexus_misc_crystal_ledge'] = 'On a rock ledge by some teal crystals'
L['nexus_misc_floating_cage'] = 'On a floating cage (use grapple points)'
L['nexus_misc_below_ramparts'] = 'Along the bottom of the ramparts'
L['nexus_misc_grapple_ramparts'] = 'On top of the ramparts (use grapple point)'
L['nexus_misc_grapple_rock'] = 'By a grapple point on a rock'
L['nexus_misc_ledge_below'] = 'On the ground under a ledge'
L['nexus_misc_three_chains'] = 'On the ground by three chains'

L['stolen_anima_vessel'] = 'Stolen Anima Vessel'
L['hidden_anima_cache'] = 'Hidden Anima Cache'
L['options_icons_anima_vessel'] = 'Stolen Anima Vessels'
L['options_icons_anima_vessel_desc'] = 'Display the locations of {object:Stolen Anima Vessels} during assaults and inside {location:The Rift}.'

L['rift_hidden_cache'] = 'Rift Hidden Cache'
L['options_icons_rift_hidden_cache'] = 'Rift Hidden Caches'
L['options_icons_rift_hidden_cache_desc'] = 'Display the locations of {object:Rift Hidden Caches} inside {location:The Rift}.'

L['options_icons_bonus_boss'] = 'Bonus Elites'
L['options_icons_bonus_boss_desc'] = 'Display locations of bonus elites.'
L['options_icons_riftstone'] = '{npc:174962s}'
L['options_icons_riftstone_desc'] = 'Display the locations of {object:Chaotic Riftstones} teleporters.'
L['options_icons_grapples'] = '{npc:176308s}'
L['options_icons_grapples_desc'] = 'Display {npc:176308s} locations for the {item:184653} upgrade.'
L['options_icons_stygia_nexus'] = 'Stygia Nexus'
L['options_icons_stygia_nexus_desc'] = 'Display {object:Stygia Nexus} locations needed for the {item:184168} mount.'
L['options_icons_stygian_caches'] = 'Stygian Caches'
L['options_icons_stygian_caches_desc'] = 'Display {object:Stygian Caches} locations containing extra Stygia.'

L['cov_assault_only'] = 'Only available during the %s assault.'

L['helgarde_supply'] = 'Helgarde Supply Cache'
L['helgarde_supply_note'] = 'Spawns throughout the {location:Desmotaeron} area. Your {npc:180598} can help you locate them.'
L['options_icons_helgarde_cache'] = 'Helgarde Supply Caches'
L['options_icons_helgarde_cache_desc'] = 'Display possible locations for {object:Helgarde Supply Caches} in the {location:Desmotaeron} area.'

L['mawsworn_cache_ramparts_note'] = 'This cache is on top of the ramparts. Use the grapple points or a {npc:177093} to reach them.'
L['mawsworn_cache_tower_note'] = 'This cache is on top of the tower and requires a {npc:177093} to reach. Use the {spell:349853} ability to climb up.'
L['mawsworn_cache_quest_note'] = 'The {item:186573} will only drop after you have completed the {quest:63545} quest!'

L['nilg_silver_ring_note'] = 'Collect 4 {item:186727} in the {location:Desmotaeron} and use them to open the {object:Domination Sealed Chest}.'
L['nilg_silver_ring_note1'] = 'Kill {npc:177444} and open the {item:186970}.'
L['nilg_silver_ring_note2'] = 'Loot the {object:Harrower\'s Key Ring}, located on the wall in an underground room next to {npc:178311}.'
L['nilg_silver_ring_note3'] = 'Open {object:Helgarde Supply Cache} in the {location:Desmotaeron} area. Your {npc:180598} can help you locate them.'
L['nilg_silver_ring_note4'] = 'Farm {npc:177134s} in the {location:Desmotaeron} area (low drop rate).'
L['nilg_stone_ring_note'] = 'Collect four {item:186600} during the Necrolord assault and combine them at any {npc:171492} in {location:Zovaal\'s Cauldron}.'
L['nilg_stone_ring_note1'] = 'Found in certain {object:Mawsworn Cache} (yellow icon) on top of the ramparts in {location:Perdition Hold}.'
L['nilg_stone_ring_note2'] = 'Complete the {quest:63545} quest, then loot {object:Mawsworn Cache} until you find the quest item {item:186573}. This quest is shareable!'
L['nilg_stone_ring_note3'] = 'Looted from {npc:179601} in the center area of {location:Perdition Hold}.'
L['nilg_stone_ring_note4'] = 'Found on the ground in {location:Perdition Hold} near {npc:170634}. Your {npc:180598} can help you locate it.'
L['nilg_gold_band_note'] = 'Use the grapple point and follow the path up to the top of the mountain.'
L['nilganihmaht_note'] = 'You must collect the 5 rings and bring them to {npc:179572} in  {location:The Rift}.'
L['calcis'] = 'Calcis'
L['desmotaeron'] = 'Desmotaeron'

L['zovault_note'] = 'Drag {npc:179883} to {npc:179904} once a day for guaranteed riftstones.'
L['options_icons_zovault'] = '{npc:179883}'
L['options_icons_zovault_desc'] = 'Display possible locations for {npc:179883}.'

L['tormentors'] = 'Tormentors of Torghast'
L['tormentors_note'] = [[
A tormentor event spawns every 2 hours on the hour. The bosses will always spawn in the order listed below.

The {item:185972} can be looted once a week and contains 50x {currency:1906}.
]]

L['options_icons_mawsworn_blackguard'] = '{achievement:14742}'
L['options_icons_mawsworn_blackguard_desc'] = '{npc:183173s} locations for {achievement:14742} achievement.'

L['mawsworn_blackguard'] = 'Mawsworn Blackguard'
L['mawsworn_blackguard_note'] = 'Easily target a stealthed {npc:183173}:'

L['options_icons_covenant_assaults'] = 'Covenant Assaults'
L['options_icons_covenant_assaults_desc'] = 'Rewards for covenant assaults'

L['assault_sublabel_US'] = 'Assaults change on Tuesday at 8 AM PDT and Friday at 8 PM PDT'
L['assault_sublabel_EU'] = 'Assaults change on Wednesday at 8 AM CET and Saturday at 8 PM CET'
L['assault_sublabel_CN'] = 'Assaults change on Thursday at 7 AM CST and Sunday at 7 PM CST'
L['assault_sublabel_AS'] = 'Assaults change on Thursday at 8 AM KST and Sunday at 8 PM KST'

L['necrolord_assault'] = '{quest:63543}'
L['necrolord_assault_note'] = 'The {item:185992} can be looted once per assault'
L['necrolord_assault_quantity_note'] = '{object:Mawsworn Caches} opened'
L['venthyr_assault'] = '{quest:63822}'
L['venthyr_assault_note'] = 'The {item:185990} can be looted once per assault'
L['venthyr_assault_quantity_note'] = 'Items used'
L['night_fae_assault'] = '{quest:63823}'
L['night_fae_assault_note'] = 'The {item:185991} can be looted once per assault'
L['night_fae_assault_quantity_note'] = '{object:Rift Hidden Caches} opened'
L['kyrian_assault'] = '{quest:63824}'
L['kyrian_assault_note'] = 'The {item:185993} can be looted once per assault'
L['kyrian_assault_quantity_note1'] = '{npc:179096} found'
L['kyrian_assault_quantity_note2'] = '{emote:/dance} near forges'

-------------------------------------------------------------------------------
---------------------- TORGHAST, THE TOWER OF THE DAMNED ----------------------
-------------------------------------------------------------------------------

L['torghast_the_tower_of_the_damned'] = 'Torghast, the Tower of the Damned'
L['torghast_reward_sublabel'] = '{note:Rewards shared between most wings}'
L['torghast_boss_note'] = 'Dropped by various bosses throughout {location:Torghast, the Tower of the Damned} '
L['torghast_vendor_note'] = 'Sold by vendors {npc:152594} and {npc:170257} for 300x {currency:1728} or 1,000x {currency:1728}.'
L['torghast_reward_note'] = 'Earned throughout {location:Torghast, the Tower of the Damned} '
L['torghast_soulshape_note'] = 'Layer 12+'
L['colossal_umbrahide_mawrat_note'] = 'Layer 13+'

L['skoldus_hall'] = 'Skoldus Hall'
L['fracture_chambers'] = 'Fracture Chambers'
L['the_soulforges'] = 'Soulforges'
L['coldheart_interstitia'] = 'Coldheart Interstitia'
L['mortregar'] = 'Mort\'regar'
L['the_upper_reaches'] = 'The Upper Reaches'
L['adamant_vaults'] = 'Adamant Vaults'
L['twisting_corridors'] = 'Twisting Corridors'
L['the_jailers_gauntlet'] = 'The Jailer\'s Gauntlet'

L['torghast_layer1'] = 'Complete Layer 1'
L['torghast_layer2'] = 'Complete Layer 2'
L['torghast_layer3'] = 'Complete Layer 3'
L['torghast_layer4'] = 'Complete Layer 4'
L['torghast_layer6'] = 'Complete Layer 6'
L['torghast_layer8'] = 'Complete Layer 8'

L['phantasma_note'] = 'Phantasma'
L['bloating_fodder_note'] = 'Bloating Fodder burst'
L['flawless_master_note'] = 'Complete |cffffff00[{achievement:15322}]|r achievement.' -- |cffffff00 coloring obsolete or on purpose?
L['tower_ranger_note'] = 'Complete |cffffff00[{achievement:15324}]|r achievement.'

L['the_jailers_gauntlet_note'] = '{note:Bosses do not count towards} |cffffff00{achievement:14498}|r achievement.'

L['the_box_of_many_things'] = 'The Box of Many Things'
L['the_box_of_many_things_note'] = 'Unlock additional powers with {currency:1904}'
L['many_many_things_section'] = 'Complete |cffffff00[{achievement:15079}]|r achievement.'

L['the_runecarver'] = '{npc:164937}'
L['clearing_the_fog_suffix'] = 'Memories unlocked'

-------------------------------------------------------------------------------
-------------------------------- ZERETH MORTIS --------------------------------
-------------------------------------------------------------------------------

local HIDDEN_ALCOVE = [[
To access the {location:%s Alcove}:

1. Complete chapter 6 of the {location:Zereth Mortis} campaign.
2. Find the {object:%s Alcove Arrangement} %s.
3. In the {location:Resonant Peaks}, Kill the mobs who have {spell:362651} or stand in white pool to got 60 stacks of {npc:183569}.
4. Use the {npc:184329} inside the {location:Gravid Repose} to access the {location:Inner Chamber}. (Requires 30x {npc:183569})
5. Use {npc:184485} to access the {location:%s Alcove}. (Requires 30x {npc:183569})
]]

L['camber_alcove_note'] = string.format(HIDDEN_ALCOVE, 'Camber', 'Camber', 'behind the building at the {location:Ultimus Locus}', 'Camber')
L['dormant_alcove_note'] = string.format(HIDDEN_ALCOVE, 'Dormant', 'Dormant', 'in the {location:Resonant Peaks}', 'Dormant')
L['fulgor_alcove_note'] = string.format(HIDDEN_ALCOVE, 'Fulgor', 'Fulgor', 'in the {location:Resonant Peaks}', 'Fulgor')
L['rondure_alcove_note'] = string.format(HIDDEN_ALCOVE, 'Rondure', 'Rondure', 'on the {location:Tertius Locus} platform', 'Rondure')
L['repertory_alcove_note'] = string.format(HIDDEN_ALCOVE, 'Repertory', 'Repertory', 'inside the {location:Terrestial Cache} cave', 'Repertory')

L['corrupted_architect_note'] = 'Engage {npc:183958} and {npc:183961} to activate the rare.'
L['dune_dominance_note'] = 'All three rare elites for the {achievement:15392} achievement spawn at this location.'
L['feasting_note'] = 'Will sometimes circle the area before returning to this spot.'
L['furidian_note'] = 'Activate three {object:Empowered Key} in the area, then unlock the {object:Suspiciously Angry Vault}.'
L['garudeon_note'] = 'Collect {npc:183562s} from the surrounding area and use {spell:362655} to feed the {npc:183554s}. Once all three are fed, {npc:180924} will activate.'
L['gluttonous_overgrowth_note'] = 'Break all nearby {npc:184048s} to activate the rare.'
L['helmix_note'] = [[
Kill {npc:179005s} in the area until they emotes and spawns.

{emote:The ground vibrates... something burrows beneath the surface!}
]]
L['hirukon_note'] = [[
To entice {npc:180978} to the surface, an {item:187923} must be created.

1. Fish up a {item:187662} from the nearby waters.

2. Fish up a {item:187915} from the {object:Pungent Blobfish Cluster} inside {location:Coilfang Reservoir} in {location:Zangarmarsh}.

3. Fish up a {item:187922} from the {object:Flipper Fish School} near the {location:Kelya's Grave flight point} in {location:Nazjatar}.

4. Loot a (very well hidden) {item:187916} from a balcony on the second level of {location:Nar'shola Terrace} in the {location:Shimmering Expanse} (34.7, 75.0).

5. Locate {npc:182194} at the pond south of the {location:Seat of the Primus} in {location:Maldraxxus}. Ask her to craft the finished {item:187923}.

6. Use the {item:187923}, allowing you to see the {object:Aurelid Cluster} fishing pool near {npc:180978} for 15min. Fish in it to summon {npc:180978} to the surface.
]] -- Breaking my rule of no coords in the notes for this one
L['orixal_note'] = 'Shares a spawn with the {npc:185487} patrolling the area.'
L['protector_first_ones_note'] = 'Requires two people. Bring the matching runes to each console (found in the surrounding area) to open the barrier.'
L['the_engulfer_note'] = 'Defend {npc:183505} until {npc:183516} jumps out of the rift.'
L['zatojin_note'] = 'Pull nearby {npc:183721s} and let you apply 20 stacks of {spell:362976} until you are {spell:362983}. You must be standing over the {npc:183774} corpses when you are paralyzed for {npc:183764} to notice you.'

L['architects_reserve_note'] = 'Complete the {quest:64829} questline from {npc:180630} in {location:Pilgrim\'s Grace} to unlock the treasure.'
L['bushel_of_produce_note'] = 'Kill a {npc:182368} to the north while it is buffed with {spell:360945} to gain the buff yourself. Kill more {npc:182368s} (they do not need the buff) until you are at 5 stacks, then break down the door to the treasure.'
L['crushed_crate_note'] = 'Loot the {item:189767} sitting on the fallen pillar above the treasure. Give it to {npc:185151} in exchange for the {item:189768} which can break the fallen rocks.'
L['domination_cache_note'] = 'The {item:189704} has a low chance to drop from {npc:181403s} and {npc:182426s} in the area.'
L['drowned_broker_supplies_note'] = 'Tell {npc:181059} to take control of the nearby {npc:185282}.'
L['forgotten_protovault_note'] = 'Only available during the {wq:Frog\'it} world quest.'
L['grateful_boon_note'] = 'Difficult to reach without flying; use {spell:300728} or {spell:111771} to ascend the mountain. Soothe all 12 creatures in the area and {npc:185293} will spawn the treasure.'
L['library_vault_note'] = 'Click tablets in the {location:Lexical Grotto} until you find the correct {spell:362062} buff to open the vault.'
L['mistaken_ovoid_note'] = 'Inside {location:Dimensional Falls} cavern. You must collect 5x {item:190239} and bring them to the {npc:185280}.'
L['ripened_protopear_note'] = 'Begin the {quest:64641} quest chain to gain access to the {location:Blooming Foundry}. Collect 5 {spell:367180} (green clouds) inside and bring them one by one to the {npc:185416} to pollinate it. Once it has grown 5 times, it will fall.'
L['sphere_treasure_note'] = 'Carefully jump up the spheres until you reach the treasure.'
L['submerged_chest_note'] = 'Absorb the {object:Dangerous Orb of Power} to the south, then interact with the {object:Forgotten Pump} near the treasure.'
L['symphonic_vault_note'] = 'Examine the {npc:183998} to hear a sequence of four sounds. Each {npc:183950} in the room plays a single sound. Interact with them in the matching order to unlock the treasure.'
L['syntactic_vault_note'] = 'To unlock the treasure, you must gain 6 stacks of {spell:367499} by interacting with {object:Runic Syllables} in the {location:Sepulcher of the First Ones} area.'
L['template_archive_note'] = 'Push the {npc:183339} in the room into the {npc:183337} blocking the path to the treasure.'
L['undulating_foliage_note'] = [[
Press the four {npc:185390s} to activate the teleporter in the center room of the {location:Catalyst Wards}.

• Outside behind the {object:Catalyst Wards Lock}
• In the south-west room of the wards
• In the southern room with {npc:181652}
• In the south-east room of the wards
]]

L['provis_cache'] = 'Locked Provis Cache'
L['provis_cache_note'] = [[
Complete the {quest:64717} daily quest from {npc:177958} at least once.

Use {item:187516} at forges across the zone to collect 15 {item:187728} and combine them into an {item:187787}. This orb has a chance to contain the key.
]]
L['prying_eye_discovery'] = 'Prying Eye Discovery'
L['prying_eye_discovery_note'] = 'Easier to reach once flying is unlocked.'
L['pulp_covered_relic'] = 'Pulp-Covered Relic'
L['requisites_originator_note'] = [[
A machine that will give you different rewards once a week:

• {spell:366667} = Enchanting mats + gold
• {spell:366668} = Anima
• {spell:366669} = Cyphers
• {spell:366670} = Genesis Motes + {item:189179} (chance)
• {spell:366671} = Cyphers/Motes/Anima
• {spell:366672} = Cypher Equipment
]]
L['rondure_cache'] = 'Rondure Cache'
L['rondure_cache_note'] = 'An interactable forge at the top of a jumping puzzle inside the {location:Rondure Alcove}.'
L['sandworn_chest'] = 'Sandworn Chest'
L['sandworn_chest_note'] = 'Loot 5x {item:190198} from mobs in the area to construct the {item:190197}.'
L['sand_piles'] = 'Sand Piles'
L['sand_piles_note'] = [[
All sand piles are found in the hidden {location:Dormant Alcove} chamber. Each pile requires a {item:189863}, which can be found in other treasures in the zone:

• Domination Cache
• Fallen Vault
• Filched Artifact
• Stolen Scroll
• Submerged Chest
• Symphonic Vault
• Undulating Foliage
]]
L['torn_ethereal_drape'] = 'Torn Ethereal Drape'
L['torn_ethereal_drape_note'] = 'Found inside the {location:Fulgor Alcove}. Activate the {object:Automa Consoles}, then ride the {npc:183565s} to reach the ceiling.'

L['cache_avian_nest'] = 'Avian Nest'
L['cache_cypher_bound'] = 'Cypher Bound Chest'
L['cache_discarded_automa'] = 'Discarded Automa Scrap'
L['cache_forgotten_vault'] = 'Forgotten Treasure Vault'
L['cache_mawsworn_supply'] = 'Mawsworn Supply Chest'
L['cache_tarachnid_eggs'] = 'Tarachnid Eggs'
L['cache_shrouded_cypher'] = 'Shrouded Cypher Cache'
L['cache_shrouded_cypher_note'] = [[
These caches can only be seen while having {spell:361917} buff and wearing an appropriate Cypher Equipment item:

{note:Enhances {npc:181059} perception, allowing it to discover additional hidden caches.}
]]

L['cache_cantaric'] = 'Cantaric Cache'
L['cache_fugueal'] = 'Fugueal Cache'
L['cache_glissandian'] = 'Glissandian Cache'
L['cache_mezzonic'] = 'Mezzonic Cache'
L['cache_toccatian'] = 'Toccatian Cache'

L['schematic_treasure_note'] = '{note:This treasure will not contain the protoform schematic if you have not yet unlocked the synthesizer. If you have already looted the treasure, you will find the schematic on the ground nearby.}'
L['schematic_treasure_mount_note'] = '{note:This schematic is found in a nearby one-time treasure. If the treasure is opened prior to unlocking the mount synthesizer, the schematic can be found here.}'
L['schematic_treasure_pet_note'] = '{note:This schematic is found in a nearby one-time treasure. If the treasure is opened prior to unlocking the pet synthesizer, the schematic can be found here.}'
L['schematic_bronze_helicid_note'] = 'Chance to be found in the {item:190610} from the weekly quest {quest:65324}.'
L['schematic_ambystan_darter_note'] = 'Hidden under the water next to the {npc:185312}.'
L['schematic_bronzewing_vespoid_note'] = 'Inside the {location:Gravid Repose}.'
L['schematic_buzz_note'] = 'Chance to be found in a {npc:185265}.'
L['schematic_curious_crystalsniffer_note'] = 'Available for a short time after {npc:184915} is defeated inside the {location:Sepulcher of the First Ones} raid.'
L['schematic_darkened_vombata_note'] = 'Inside a floating cage.'
L['schematic_deathrunner_note'] = 'Obtained as part of the {spell:366367} unlock quest chain.'
L['schematic_desertwing_hunter_note'] = 'Located on top of the pillar.'
L['schematic_fierce_scarabid_note'] = 'Hidden under the platform the {npc:181870} is standing on.'
L['schematic_forged_spiteflyer_note'] = 'Sticking out of a vespoid hive cluster.'
L['schematic_genesis_crawler_note'] = 'Found on top of the entrance to the {location:Genesis Alcove}.'
L['schematic_goldplate_bufonid_note'] = 'Small chance to drop from {npc:178803s}.'
L['schematic_heartbond_lupine_note'] = 'Small chance to drop from the {npc:179939}.'
L['schematic_ineffable_skitterer_note'] = 'Kill yourself! No, really ... you can only see the {npc:185092} in {location:Exile\'s Hollow} when you are a ghost.'
L['schematic_leaping_leporid_note'] = 'Found on top of a floating tree.'
L['schematic_mawdapted_raptora_note'] = 'Small chance to drop from {npc:181412s} in the {location:Endless Sands}.'
L['schematic_microlicid_note'] = 'On the lowest branch of the floating tree, underneath some foliage.'
L['schematic_omnipotential_core_note'] = 'Found in the {location:Rondure Alcove}. The schematic is hidden behind the upper lip of the archway on the south-west side of the room.'
L['schematic_prototickles_note'] = 'Attached to a floating chain inside the vines above the {npc:180978} rare.'
L['schematic_prototype_fleetpod_note'] = 'Found inside the {location:Camber Alcove}. Interact with the {npc:184900} to start a minigame. Guide the snail through 5 rings without touching {npc:185455s} to win the schematic.'
L['schematic_raptora_swooper_note'] = 'Found inside the {location:Chamber of Shaping}.'
L['schematic_resonant_echo_note'] = 'Chance to be found inside a {object:Crystallized Echo of the First Song}.'
L['schematic_russet_bufonid_note'] = 'Chance to be found in the {item:187780} paragon cache.'
L['schematic_scarlet_helicid_note'] = 'Found on top of the arch structure.'
L['schematic_serenade_note'] = 'Located in a chain underneath a floating platform in the {location:Immortal Hearth} area of the raid.'
L['schematic_shelly_note'] = 'Located on the back side of a shelf in the {location:Lexical Grotto}. Requires a teleport ability to climb the shelf.'
L['schematic_stabilized_geomental_note'] = 'Chance to be dropped by {npc:182169} inside the {location:Sepulcher of the First Ones} raid.'
L['schematic_tarachnid_creeper_note'] = 'Inside a small structure in the {location:Endless Sands}. Requires chapter 5 campaign progress to clear the boulders.'
L['schematic_terror_jelly_note'] = 'On top of the square pylon next to the ramp.'
L['schematic_tunneling_vombata_note'] = 'Next to some rubble in a blocked tunnel inside the {location:Locrian Esper} complex.'
L['schematic_vespoid_flutterer_note'] = 'Sticking out of a pile of sand on the {location:Primus Locus} tier of the {location:Resonant Peaks}.'
L['schematic_violent_poultrid_note'] = 'Chance to drop from the {daily:65256} daily quest.'

L['concordance_excitable'] = 'Excitable Concordance'
L['concordance_mercurial'] = 'Mercurial Concordance'
L['concordance_tranquil'] = 'Tranquil Concordance'
L['concordance_note'] = 'Read each concordance to unlock entries at the {object:Lore Console} in {location:Exile\'s Hollow}.'

L['echoed_jiro_note'] = 'Spend {npc:181059} energy to gain temporary buffs. Requires {object:Creatian} research at the {npc:181397}.'

L['bygone_elemental_note'] = 'A {npc:181221} can spawn in place of any {npc:179007} in the area.'
L['dominated_irregular_note'] = 'A {npc:184819} can spawn in place of any {npc:183184} in the area.'
L['gaiagantic_note'] = 'Only spawns when {npc:177958} offers the {daily:64785} daily quest.'
L['misaligned_enforcer_note'] = 'Spawns here. Patrols the area and then despawns at the end of his route.'
L['overcharged_vespoid_note'] = 'Can spawn as part of any swarm pack in the area.'
L['runethief_xylora_note'] = 'Spawns stealthed in the {location:Pilgrim\'s Grace} area.'

local proto_area = 'Chance to be found in forges around the {object:%s}.'
L['proto_material_zone_chance'] = 'Chance to be found in select forges across the zone.'
L['anima_charged_yolk_note'] = 'Collect {item:187728} from any forge and combine them into an {item:187787}, which has a chance to contain an {item:187890}.'
L['energized_firmament_note'] = string.format(proto_area, 'Resonant Peaks')
L['honeycombed_lattice_note'] = string.format(proto_area, 'Droning Precipice')
L['incorporeal_sand_note'] = 'Chance to be found in forges in the desert areas of the zone.'
L['pollinated_extraction_note'] = string.format(proto_area, 'Untamed Verdure')
L['serene_pigment_note'] = 'In a forge above the entrance to {location:Exile\'s Hollow}. May require multiple tries.'
L['volatile_precursor_note'] = 'Found in the smaller forge on top. May require multiple tries.'
L['wayward_essence_note'] = 'In a floating forge behind {location:Exile\'s Hollow}. Stand in the indent to tap the forge.'

L['patient_bufonid_note'] = 'Progress in the {location:Zereth Mortis} story until {npc:180950} offers {quest:65727}. Complete the quests each day to lure the {npc:185798} out of the pond.'
L['patient_bufonid_note_day1'] = 'Collect 15x {item:190852} from {npc:Vespoid} in the zone.'
L['patient_bufonid_note_day2'] = 'Purchase 30x {item:172053} from the Auction House.'
L['patient_bufonid_note_day3'] = 'Purchase 200x {item:173202} from the Auction House.'
L['patient_bufonid_note_day4'] = 'Purchase 10x {item:173037} from the Auction House.'
L['patient_bufonid_note_day5'] = 'Collect 5x {item:187704} from mobs in the zone.'
L['patient_bufonid_note_day6'] = 'Purchase 5x {item:190880} from {npc:185748} near {location:Pilgrim\'s Grace}.'
L['patient_bufonid_note_day7'] = 'Purchase 1x {item:187171} from the {npc:180114} in the {location:Tazavesh} dungeon.'

L['lost_comb'] = 'Lost Comb'
L['soulshape_penguin_note'] = 'Located on top of the floating forge.'

L['coreless_automa'] = 'wildlife automas'
L['coreless_automa_note'] = 'Equipping an item with {spell:364480} will grant {npc:181059} the ability to take over creatures without consuming energy and will make earning this achievement faster.'
L['coreless_automa_warning'] = '{note:Wait for the automa to actually start following you before telling {npc:181059} to leave to avoid causing a bug that requires you to relog.}'

L['olea_manu'] = 'Sells collectibles and recipes in exchange for {currency:1979}.'

L['venaris_fate_sublabel'] = 'Located in the {location:Creation Catalyst}'
L['venaris_fate_note'] = [[
1. Speak with incorporeal {npc:162804} at {location:Ve'nari's Refuge} in {location:The Maw}.
2. If she is not incorporeal, additional 9.2 story progress is required.
3. Interact with the corpse of {npc:162804} in the {location:Creation Catalyst} in {location:Zereth Mortis}.
4. 5 days later you will receive a letter in the mail from {npc:162804} along with the {item:192485}.
]]

L['options_icons_code_creature'] = '{achievement:15211}'
L['options_icons_code_creature_desc'] = 'Display creature locations for the {achievement:15211} achievement.'
L['options_icons_concordances'] = 'Lore Concordances'
L['options_icons_concordances_desc'] = 'Display locations of {object:Lore Concordance Consoles}.'
L['options_icons_echoed_jiros'] = 'Echoed Jiros'
L['options_icons_echoed_jiros_desc'] = 'Display locations of {npc:Echoed Jiros} offering buffs.'
L['options_icons_exile_tales'] = '{achievement:15509}'
L['options_icons_exile_tales_desc'] = 'Display tale locations for the {achievement:15509} achievement.'
L['options_icons_proto_materials'] = '{achievement:15229}'
L['options_icons_proto_materials_desc'] = 'Display rare protoform material locations for the {achievement:15229} achievement.'
L['options_icons_protoform_schematics'] = 'Protoform Schematics'
L['options_icons_protoform_schematics_desc'] = 'Display locations of mount and pet schematics.'
L['options_icons_puzzle_caches'] = 'Puzzle Caches'
L['options_icons_puzzle_caches_desc'] = 'Display possible locations of {object:Puzzle Caches}.'
L['options_icons_zereth_caches'] = 'Cypher Caches'
L['options_icons_zereth_caches_desc'] = 'Display possible locations for {object:Cypher Caches}.'
L['options_icons_shrouded_cyphers'] = 'Shrouded Cypher Caches'
L['options_icons_shrouded_cyphers_desc'] = 'Display possible locations for hidden {object:Shrouded Cypher Caches}.'
L['options_icons_mawsworn_supply_cache'] = 'Mawsworn Supply Caches'
L['options_icons_mawsworn_supply_cache_desc'] = 'Display possible locations for {object:Mawsworn Supply Caches}.'
L['options_icons_coreless_automa'] = '{achievement:15542}'
L['options_icons_coreless_automa_desc'] = 'Coreless automa locations for the {achievement:15542} achievement.'

L['ponderers_portal_label'] = 'Ponderer\'s Portal'
L['ponderers_portal_note'] = [[The {item:190196} can be found with the help of the {item:190177}, which can be looted from the {item:187780}, the Paragon cache for the {faction:The Enlightened} reputation.

{note:The portal can be looted by any player once the zone-wide emote is seen, not just those who opened the portal.}

To open the portal, six players will need to sit on top of the hexagon pillars surrounding the pool of water under the {location:Forge of Afterlives} in the center of {location:Zereth Mortis} and use the {item:190177}. There needs to be one player at each pillar.]]

--DF

-------------------------------------------------------------------------------
-------------------------------- DRAGON ISLES ---------------------------------
-------------------------------------------------------------------------------

L['elite_loot_higher_ilvl'] = '{note:This rare can drop higher ilvl loot!}'
L['gem_cluster_note'] = 'The required item can be found at Renown 21 with the {faction:2507} in {object:Expedition Scout\'s Pack} and {object:Disturbed Dirt}.'

L['options_icons_bonus_boss'] = 'Bonus Elites'
L['options_icons_bonus_boss_desc'] = 'Display locations of bonus elites.'

L['options_icons_profession_treasures'] = 'Profession Treasures'
L['options_icons_profession_treasures_desc'] = 'Display locations of treasures which grant profession knowledge.'

L['dragon_glyph'] = 'Dragon Glyph'
L['options_icons_dragon_glyph'] = 'Dragon Glyphs'
L['options_icons_dragon_glyph_desc'] = 'Display the location of all 64 dragon glyphs.'

L['dragonscale_expedition_flag'] = 'Dragonscale Expedition Flag'
L['flags_placed'] = 'flags placed'
L['options_icons_flag'] = '{achievement:15890}'
L['options_icons_flag_desc'] = 'Display the location of all 20 flags for the {achievement:15890} achievement.'

L['broken_banding_note'] = 'On the statue\'s right foot\'s ankle.'
L['chunk_of_sculpture_note'] = 'On the ground, from the dragon statue on the left.'
L['dislodged_dragoneye_note'] = 'On a rock under the dragon statue\'s chest.'
L['finely_carved_wing_note'] = 'Under the dragon statue\'s right knee.'
L['fragment_requirement_note'] = '{note:Before you can collect loose pieces, you need to ask {npc:193915} in {location:Wingrest Embassy} at the dragon statue what she is doing here.}'
L['golden_claw_note'] = 'At the dragon statue\'s rear right claw.'
L['precious_stone_fragment_note'] = 'Under the statue\'s right foot.'
L['stone_dragontooth_note'] = 'On the ground next to the pedestal of the dragon statue.'
L['tail_fragment_note'] = 'On the tail of the dragon statue.'
L['wrapped_gold_band_note'] = 'Under the dragon statue\'s rear left claw.'
L['options_icons_fragment'] = '{achievement:16323}'
L['options_icons_fragment_desc'] = 'Display the location of loose pieces for the {achievement:16323} achievement.'

L['options_icons_kite'] = '{achievement:16584}'
L['options_icons_kite_desc'] = 'Display the location of {npc:198118s} for the {achievement:16584} achievement.'

L['disturbed_dirt'] = 'Disturbed Dirt'
L['options_icons_disturbed_dirt'] = 'Disturbed Dirt'
L['options_icons_disturbed_dirt_desc'] = 'Display possible locations of {object:Disturbed Dirt}.'

L['scout_pack'] = 'Expedition Scout\'s Pack'
L['options_icons_scout_pack'] = 'Expedition Scout\'s Packs'
L['options_icons_scout_pack_desc'] = 'Display possible locations of {object:Expedition Scout\'s Packs}.'

L['magicbound_chest'] = 'Magic-Bound Chest'
L['options_icons_magicbound_chest'] = 'Magic-Bound Chests'
L['options_icons_magicbound_chest_desc'] = 'Display possible locations of {object:Magic-Bound Chests}.'
L['ice_bound_chest'] = 'Ice Bound Chest'

L['tuskarr_tacklebox'] = 'Tuskarr Tacklebox'
L['options_icons_tuskarr_tacklebox'] = 'Tuskarr Tackleboxes'
L['options_icons_tuskarr_tacklebox_desc'] = 'Display possible locations of {object:Tuskarr Tackleboxes}.'

L['squirrels_note'] = 'You must use the emote {emote:/love} on critters, not battle pets.'
L['options_icons_squirrels'] = '{achievement:16729}'
L['options_icons_squirrels_desc'] = 'Display critter locations for {achievement:16729} achievement.'
L['options_icons_zaralek_squirrels'] = '{achievement:18361}'
L['options_icons_zaralek_squirrels_desc'] = 'Display critter locations for {achievement:18361} achievement.'

L['hnj_sublabel'] = 'Requires local Shikaar Grand Hunt'
L['hnj_western_azure_span_hunt'] = 'On top of the dead tree.'
L['hnj_northern_thaldraszus_hunt'] = '{note:He may be killed by nearby mobs so find him quickly!}'
L['options_icons_hemet_nesingwary_jr'] = '{achievement:16542}'
L['options_icons_hemet_nesingwary_jr_desc'] = 'Display {npc:194590} locations for the {achievement:16542} achievement.'

L['pretty_neat_note'] = 'Take a picture with the S.E.L.F.I.E. camera.'
L['pretty_neat_note_blazewing'] = 'Can be found during the {npc:189901} boss encounter in the {location:Neltharus} dungeon.'
L['options_icons_pretty_neat'] = '{achievement:16446}'
L['options_icons_pretty_neat_desc'] = 'Display bird locations for the {achievement:16446} achievement.'

L['large_lunker_sighting'] = 'Large Lunker Sighting'
L['large_lunker_sighting_note'] = 'Use 5x {item:194701} to summon either a {npc:192919} or a rare.'

L['options_icons_legendary_album'] = '{achievement:16570}'
L['options_icons_legendary_album_desc'] = 'Display legendary character locations for {achievement:16570} achievement.'

L['signal_transmitter_label'] = 'Wyrmhole Generator Signal Transmitter'
L['signal_transmitter_note'] = '{note:Requires 10 points in Mechanical Mind\nRequires 30 points in Novelties.}\n\nInteract with the {object:Deactivated Signal Transmitter} to allow for teleportation to this location.'
L['options_icons_signal_transmitter'] = 'Wyrmhole Generator Signal Transmitters'
L['options_icons_signal_transmitter_desc'] = 'Display {object:Deactivated Signal Transmitters} locations for the {item:198156}.'

L['rare_14h'] = 'This rare is on a 14 hour rotation with other rares with one rare spawning every 30 minutes.\n\nNext spawn in: {note:%s}'
L['spawns_at_night'] = '{note:Spawns only at night. (After 18:30 server time)}'

L['elemental_storm'] = 'Elemental Storm'
L['elemental_storm_thunderstorm'] = 'Thunderstorm'
L['elemental_storm_sandstorm'] = 'Sandstorm'
L['elemental_storm_firestorm'] = 'Firestorm'
L['elemental_storm_snowstorm'] = 'Snowstorm'

L['elemental_storm_brakenhide_hollow'] = 'Brackenhide Hollow'
L['elemental_storm_cobalt_assembly'] = 'Cobalt Assembly'
L['elemental_storm_imbu'] = 'Imbu'
L['elemental_storm_nokhudon_hold'] = 'Nokhudon Hold'
L['elemental_storm_ohniri_springs'] = 'Ohn\'iri Springs'
L['elemental_storm_primalist_future'] = 'Primalist Future'
L['elemental_storm_primalist_tomorrow'] = 'Primalist Tomorrow'
L['elemental_storm_scalecracker_keep'] = 'Scalecracker Keep'
L['elemental_storm_slagmire'] = 'Slagmire'
L['elemental_storm_tyrhold'] = 'Tyrhold'

L['elemental_overflow_obtained_suffix'] = 'Elemental Overflow obtained'
L['empowered_mobs_killed_suffix'] = 'Empowered mobs killed'

L['elemental_storm_mythressa_note_start'] = 'Exchange for {currency:2118} for gear, pets, and a mount.'
L['elemental_storm_mythressa_note_end'] = 'You currently have %s {currency:2118}.'

L['options_icons_elemental_storm'] = 'Elemental Storms'
L['options_icons_elemental_storm_desc'] = 'Display rewards for Elemental Storms.'

L['elusive_creature_note'] = '{object:Mastery Rank 40/40} in {object:Bait Crafter} enables you to create {item:193906} which can be used to summon and skin each creature once a day.'
L['options_icons_elusive_creature'] = '{item:193906}'
L['options_icons_elusive_creature_desc'] = 'Display locations for elusive creatures summoned with {item:193906}.'

L['grand_hunts_label'] = 'Grand Hunts'
L['longhunter_suffix'] = 'hunt steps completed'
L['the_best_at_what_i_do_suffix'] = 'bosses killed'

L['options_icons_grand_hunts'] = 'Grand Hunts'
L['options_icons_grand_hunts_desc'] = 'Display locations and rewards for {object:Grand Hunts}.'

L['ancient_stone_label'] = 'Ancient Stone'
L['options_icons_ancient_stones'] = '{achievement:17560}'
L['options_icons_ancient_stones_desc'] = 'Display {object:Ancient Stone} locations for {achievement:17560} achievement.'

L['reed_chest'] = 'Reed Chest'
L['options_icons_reed_chest'] = 'Reed Chest'
L['options_icons_reed_chest_desc'] = 'Display possible locations of {object:Reed Chests}.'

L['dracthyr_supply_chest'] = 'Dracthyr Supply Chest'
L['options_icons_dracthyr_supply_chest'] = 'Dracthyr Supply Chest'
L['options_icons_dracthyr_supply_chest_desc'] = 'Display possible locations of {object:Dracthyr Supply Chests}.'

L['simmering_chest'] = 'Simmering Chest'
L['options_icons_simmering_chest'] = 'Simmering Chest'
L['options_icons_simmering_chest_desc'] = 'Display possible locations of {object:Simmering Chests}.'

L['frostbound_chest'] = 'Frostbound Chest'
L['options_icons_frostbound_chest'] = 'Frostbound Chest'
L['options_icons_frostbound_chest_desc'] = 'Display possible locations of {object:Frostbound Chests}.'

L['war_supply_chest_note'] = 'A {npc:135181} will fly overhead once every 45 minutes and drop a {npc:135238} at one of these potential drop locations.'
L['options_icons_war_supplies_desc'] = 'Display {npc:135238} drop locations.'
L['options_icons_war_supplies'] = '{npc:135238}'

L['fyrakk_assault_label'] = 'Fyrakk Assault'
L['fyrakk_secured_shipment'] = 'Secured Shipment'

L['shadowflame_forge_label'] = 'Shadowflame Forge'
L['shadowflame_forge_note'] = 'Required when crafting this recipe:\n{spell:408282}'
L['shadowflame_blacksmithing_anvil_label'] = 'Shadowflame Blacksmithing Anvil'
L['shadowflame_blacksmithing_anvil_note'] = 'Required when crafting these recipes:\n{spell:408288}\n{spell:408326}\n{spell:408283}\n{spell:408052}'
L['shadowflame_leatherworking_table_label'] = 'Shadowflame Leatherworking Table'
L['shadowflame_leatherworking_table_note'] = 'Required when crafting this recipe:\n{spell:406275}'
L['shadowflame_incantation_table_label'] = 'Shadowflame Incantation Table'
L['shadowflame_incantation_table_note'] = 'Required when crafting this recipe:\n{spell:405076}'
L['altar_of_decay_label'] = 'The Altar of Decay'
L['altar_of_decay_note'] = 'Required when crafting these recipes:\n{spell:110423}: \nDecayed Patterns\nDecay-Infused reagents\n\n{spell:264211}: \nToxic potions\nToxic phials\n{spell:405879}'
L['azure_loom_label'] = 'Azure Loom'
L['azure_loom_note'] = 'Required when crafting this recipe:\n{spell:376556}'
L['temporal_loom_label'] = 'Temporal Loom'
L['temporal_loom_note'] = 'Required when crafting this recipe:\n{spell:376557}'
L['earthwarders_forge_label'] = 'The Earth-Warder\'s Forge'
L['earthwarders_forge_note'] = 'Required when crafting this recipe:\n{spell:367713}'

L['dreamsurge_sublabel'] = '{note:Only available while a {location:Dreamsurge} is active in this zone.}'
L['celestine_vendor_note'] = 'Exchange {item:207026} for a mount, toys, pets, and transmog.'
L['renewed_magmammoth_note'] = 'Collect 20x {item:209419} from the final boss of a {location:Dreamsurge} and combine to create {item:192807}.'

L['dragon_pepe_label'] = 'Dragon Pepe'
L['dragon_pepe_note'] = 'Perched on the pillar to the left of the stairs leading to the {location:Seat of the Aspects}.'
L['explorer_pepe_label'] = 'Explorer Pepe'
L['explorer_pepe_note'] = 'Perched on top of the large tent at {location:Dragonscale Basecamp}.'
L['tuskarr_pepe_label'] = 'Tuskarr Pepe'
L['tuskarr_pepe_note'] = 'Perched on the building near {npc:196544} and {npc:187680}.'

L['end_of_august'] = '{note:Only available before end of August.}'

L['rich_soil_label'] = 'Rich Soil'
L['rich_soil_note'] = 'Plant various seedlings in a patch of {object:Rich Soil} on the {location:Dragon Isles} to sprout random rewards.\n\n{item:200506} - Grow random standard {location:Dragon Isles} herbs\n\n{item:200508} - Grow random Rousing Essences\n\n{item:200507} - Grow random decayed herbs\n\n{item:200509} - Spawn {npc:198571} for various random herbs and essences'
L['options_icons_rich_soil'] = 'Rich Soil'
L['options_icons_rich_soil_desc'] = 'Display locations for {object:Rich Soil}.'

L['information_stuffed_clue'] = 'Information-Stuffed Clue'
L['clued_in_note'] = 'The {npc:210079} spawn during {note:the Big Dig} event and the world quests {wq:Research: ...}.'
L['options_icons_clued_in'] = '{achievement:19787}'
L['options_icons_clued_in_desc'] = 'Display {npc:210079} locations for {achievement:19787} achievement.'

L['goggle_wobble_note'] = '{emote:/dance} with {npc:207763} during the intro quest line or the world quests {wq:Technoscrying: ...} while wearing {item:202247}.'
L['options_icons_goggle_wobble'] = '{achievement:19791}'
L['options_icons_goggle_wobble_desc'] = 'Display {npc:207763} locations for {achievement:19791} achievement.'

L['just_one_more_thing_note'] = 'Have to complete any world quest {wq:Research: ...} three times.'
L['options_icons_just_one_more_thing'] = '{achievement:19792}'
L['options_icons_just_one_more_thing_desc'] = 'Display progress for each criteria for {achievement:19792} achievement.'

-------------------------------------------------------------------------------
------------------------------- THE AZURE SPAN --------------------------------
-------------------------------------------------------------------------------

L['bisquis_note'] = 'Cook Legendary soup at the Community Feast in {location:Iskaara}, then defeat {npc:197557}.\n\nNext Feast: {note:%s}'
L['blightfur_note'] = 'Talk to {npc:193633} to summon the rare.'
L['brackenhide_rare_note'] = 'These rares spawn in a set rotation of {npc:197344} > {npc:197353} > {npc:197354} > {npc:197356} on a 10 minute timer.\n\nNext possible spawn: {note:%s}'
L['fisherman_tinnak_note'] = 'Collect {object:Broken Fishing Pole}, {object:Torn Fishing Net} and {object:Old Harpoon} to spawn the rare.'
L['frostpaw_note'] = 'After taking the {object:Wooden Hammer}, you have 20 seconds to hit the {object:Whack a Gnoll} on the {object:Tree Stump}, and spawn the rare.'
L['sharpfang_note'] = 'Help {npc:192747} defeat {npc:192748s} to spawn the rare.'
L['spellwrought_snowman_note'] = 'Collect 10x {npc:193424} and bring them to {npc:193242}.'
L['trilvarus_loreweaver_note'] = 'Collect a {object:Singing Fragment} to get {spell:382076} and use the {object:Uncharded Focus} to spawn the rare.'

L['breezebiter_note'] = 'Flies around in the sky. Fly close to him to pull him down. Spawn point at right side cave.'

L['forgotten_jewel_box_note'] = '{item:199065} can be found in {object:Expedition Scout\'s Packs} and {object:Disturbed Dirts}.'
L['gnoll_fiend_flail_note'] = '{item:199066} can be found in {object:Expedition Scout\'s Packs} and {object:Disturbed Dirts}.'
L['pepper_hammer_note'] = 'Collect {object:Tree Sap} and then use the {object:Stick} to lure the {npc:195373}.\n\n{bug:(BUG: To click on the stick a reload might be necessary)}'
L['snow_covered_scroll'] = 'Snow Covered Scroll'

L['pm_engi_frizz_buzzcrank'] = 'Stands next to a shrine.'
L['pm_jewel_pluutar'] = 'Inside the building.'
L['pm_script_lydiara_whisperfeather'] = 'Sits on a bench.'
L['pt_alch_experimental_decay_sample_note'] = 'Inside a large green cauldron.'
L['pt_alch_firewater_powder_sample_note'] = 'Outside log house next to vase.'
L['pt_ench_enriched_earthen_shard_note'] = 'On a pile of rocks.'
L['pt_ench_faintly_enchanted_remains_note'] = 'Click the {object:Mana-Starved Crystal Cluster} to spawn and kill a mob. Then loot the crystal that spawns.'
L['pt_ench_forgotten_arcane_tome_note'] = 'Lying on the floor to the right of the entrance to a tomb.'
L['pt_jewel_crystalline_overgrowth_note'] = 'Next to a small pond.'
L['pt_jewel_harmonic_crystal_harmonizer_note'] = 'Click the {object:Resonant Key} to receive a buff {spell:384802}, then click the 3 {object:Humming Crystal} in the lake to open the chest.'
L['pt_leath_decay_infused_tanning_oil_note'] = 'In the barrel.'
L['pt_leath_treated_hides_note'] = 'At {location:Snowhide Camp}.'
L['pt_leath_well_danced_drum_note'] = 'In an underground building with {npc:186446} and {npc:186448}. Fix the drum next to {npc:194862}. Once he dances on it you can loot the item.'
L['pt_script_dusty_darkmoon_card_note'] = 'Inside a building on an upper level.'
L['pt_script_frosted_parchment_note'] = 'Behind an {npc:190776}.'
L['pt_smith_spelltouched_tongs_note'] = 'Inside a small blocked cave.'
L['pt_tailor_decaying_brackenhide_blanket_note'] = 'Hanging on a tree within a makeshift tent.'
L['pt_tailor_intriguing_bolt_of_blue_cloth_note'] = 'Follow the stairs to the left.'

L['leyline_note'] = 'Realign the ley line.'
L['options_icons_leyline'] = '{achievement:16638}'
L['options_icons_leyline_desc'] = 'Display ley line locations for the {achievement:16638} achievement.'

L['river_rapids_wrangler_note'] = 'Talk to {npc:186157} and select "I\'d like to take your River Rapids Ride again". You have 60 seconds to collect get 40x stacks of {spell:373490}.'
L['seeing_blue_note'] = 'Fly from the top of the {location:Azure Archives} to the {location:Cobalt Assembly} without landing.'
L['snowman_note'] = 'There are three {npc:197599s} laying in the area (might have been moved by other players). Roll them to the two kids {npc:197838} and {npc:197839}.\nYou get the achievement when the snowballs have the right sizes.'

L['snowclaw_cub_note_start'] = 'You must complete the {quest:67094} quest chain offered by {npc:192522} in {location:Valdrakken} to obtain the {title:Honorary Dryad} title.\n\nGather the following items:'
L['snowclaw_cub_note_item1'] = 'Loot 3x {item:197744} from various {npc:182559s} around {location:The Waking Shores}.'
L['snowclaw_cub_note_item2'] = 'Purchase 1x {item:198356} from {npc:193310} in {location:The Waking Shores}.'
L['snowclaw_cub_note_end'] = [[
{note:All items can be purchased from the auction house. This is especially helpful if you do not easily have access to a {item:199215} which is required to purchase items from {npc:193310}.}

Once you have the {title:Honorary Dryad} title equipped offer all 4 items to {npc:196768} to receive your pet.

{note:If you lose the title prematurely you can repeat the quest to acquire it again. Try again tomorrow or after the next weekly reset.}
]]

L['tome_of_polymoph_duck'] = 'Use {spell:1953} to enter the cave and interact with the {object:Manastorming For Beginners} book to complete the quest.'

L['temperamental_skyclaw_note_start'] = 'Collect (or buy in the auction house):'
L['temperamental_skyclaw_note_end'] = 'Ask about the saddled slyvern and present {npc:190892} the collected "dishes".'

L['elder_poa_note'] = 'Exchange {item:200071} for {faction:2511} reputation.'

L['artists_easel_note_step1'] = '{quest:70166}\n{npc:194415}, at the top of the tower in the {location:Ancient Outlook}, will ask you to deliver his painting to {npc:194323}, the greatest painter who ever lived.'
L['artists_easel_note_step2'] = '{quest:70168}\n{npc:194425} will ask you to collect paintings from {location:Ruby Life Pools}, {location:Nokhud Offensive}, and {location:Brackenhide Hollow}.'
L['artists_easel_note_step3'] = '{quest:70170}\n{npc:194425} will ask you to collect paintings from {location:Halls of Infusion}, {location:Algeth\'ar Academy}, {location:The Azure Vault}, and {location:Neltharus}.'
L['artists_easel_note_step4'] = 'Deliver the final paintings to {npc:194323} and recieve your toy!\n\n{note:Paintings do not drop from Mythic or Mythic+ dungeons.}'

L['somewhat_stabilized_arcana_note'] = 'Located at the top of the tower.\n\nComplete the small questline starting at {npc:197100} to obtain the toy.'

L['stranded_soul_note'] = [[
After killing {npc:196900} he explodes into 4 {npc:196901s}.
You need to activate them to melt the ice wall (two players are recommended).

Kill {npc:197183} inside and you will recieve {item:200528}.
]]

L['gethdazr_note'] = [[
Spawns as part of an event in {location:Imbu} that starts by blowing the {object:Great Horn of Imbu} {dot:Blue}.
The horn will only become clickable after killing the {npc:196155} which has about 30-60 minutes of respawn time.

{npc:191143} {dot:Green} and other NPCs will then fight their way from the north east entrance of {location:Imbu} up to the cliff where {npc:196165} will then spawn.
The NPCs can die without help, which then will fail the event.

This can be done solo but 2-3 players are recommended.
]]

L['tuskarr_chest'] = 'Tuskarr Chest'
L['options_icons_tuskarr_chest'] = 'Tuskarr Chests'
L['options_icons_tuskarr_chest_desc'] = 'Display possible locations of {object:Tuskarr Chests}.'

L['community_feast_label'] = 'Community Feast'
L['tasks_completed_suffix'] = 'cooking tasks completed'
L['options_icons_community_feast'] = 'Community Feast'
L['options_icons_community_feast_desc'] = 'Display location and rewards for the Community Feast.'

L['decay_covered_chest'] = 'Decay Covered Chest'
L['options_icons_decay_covered_chest'] = 'Decay Covered Chest'
L['options_icons_decay_covered_chest_desc'] = 'Display possible locations of {object:Decay Covered Chests}.'

L['icemaw_storage_cache'] = 'Icemaw Storage Cache'
L['options_icons_icemaw_storage_cache'] = 'Icemaw Storage Cache'
L['options_icons_icemaw_storage_cache_desc'] = 'Display possible locations of {object:Icemaw Storage Caches}.'

L['kazzi_note_start'] = 'Exchange {item:202017} and {item:202018} for transmog, drake customization, a pet, and more.'
L['kazzi_note_item'] = 'You currently have %s {item:%s}.'
L['kazzi_achievement_suffix'] = 'rank in the Winterpelt language'

L['naszuro_vakthros'] = 'In the top of the tower.'
L['naszuro_imbu'] = 'On the tree stump.'
L['naszuro_azure_archives'] = 'On the side of the mountain, on a small rock.'
L['naszuro_hudsons_rock'] = 'On top of the small rocky hill.'

L['ferry_to_iskaara'] = 'Boat to Iskaara'

L['options_icons_vegetarian_diet'] = '{achievement:16762}'
L['options_icons_vegetarian_diet_desc'] = 'Display {object:Meat Storage} locations for {achievement:16762} achievement.'

L['meat_storage_label'] = 'Meat Storage'
L['meat_storage_note'] = 'After freeing all 12 {npc:186766} from {object:Meat Storage} inside of {location:Brackenhide Hollow} you will recieve mail from {npc:196267} containing the {item:200631}.'

L['meat_storage_location_a'] = 'On the beach surrounded by {npc:96239s}.'
L['meat_storage_location_b'] = 'Near a cave behind {npc:187192}.'
L['meat_storage_location_c'] = 'In a small cave behind the {npc:197130} and {npc:186226}.'

-------------------------------------------------------------------------------
------------------ FORBIDDEN REACH (DRACTHYR STARTING ZONE) -------------------
-------------------------------------------------------------------------------

L['bag_of_enchanted_wind'] = 'Bag of Enchanted Wind'
L['bag_of_enchanted_wind_note'] = 'Located up in the tower.'
L['hessethiash_treasure'] = 'Hessethiash\'s Poorly Hidden Treasure'
L['lost_draconic_hourglass'] = 'Lost Draconic Hourglass'
L['suspicious_bottle_treasure'] = 'Suspicious Bottle'
L['mysterious_wand'] = 'Mysterious Wand'
L['mysterious_wand_note'] = 'Pick up the {object:Crystal Key} and place it into the {object:Crystal Focus}.'

-------------------------------------------------------------------------------
------------------------- FORBIDDEN REACH (MAIN ZONE) -------------------------
-------------------------------------------------------------------------------

L['in_dragonskull_island'] = 'Within {location:Dragonskull Island}.'
L['in_froststone_vault'] = 'Within {location:Froststone Vault}.'
L['in_the_high_creche'] = 'Within {location:The High Creche}'
L['in_the_lost_atheneum'] = 'Within {location:The Lost Atheneum}.'
L['in_the_siege_creche'] = 'Within {location:The Siege Creche}.'
L['in_the_support_creche'] = 'Within {location:The Support Creche}.'
L['in_the_war_creche'] = 'Deep within {location:The War Creche}'
L['in_zskera_vaults'] = 'Within {location:Zskera Vaults}.'

L['duzalgor_note'] = 'Collect a bottle of {spell:400751} {dot:Green} to heal from the poisonous gas within {location:The Support Creche}.'
L['mad_eye_carrey_note'] = '{npc:201181} is in a group with {npc:201184} and {npc:201182}'
L['wymslayer_angvardi_note'] = '{npc:201013} is partnered with {npc:201310}'
L['loot_specialist_note'] = '{npc:203353} spawns with both {spell:406143} and {spell:132653} and will run away when attacked.\n\n{note:Kill him quickly before he finishes casting {spell:406141}.}'

L['profession_required'] = '{note:Requires a player with the %s profession.}'
L['pr_crafting_note'] = 'Craft {item:%s} with {item:%s} and interact with {object:%s} to summon the rare.'
L['pr_gathering_note'] = 'Use {item:%s} to interact with {object:%s} to summon the rare.'
L['pr_recipe_note'] = 'The recipe {item:%s} can be purchased from {npc:202445} for 10 {item:190456}.'
L['pr_summoning_note'] = 'The player who summons the rare will get {spell:405161} and bonus loot.'

L['pr_awakened_soil'] = 'Awakened Soil'
L['pr_book_of_arcane_entities'] = 'Book of Arcane Entities'
L['pr_damaged_buzzspire'] = 'Damaged Buzzspire 505'
L['pr_empty_crab_trap'] = 'Empty Crab Trap'
L['pr_farescale_shrine'] = 'Farscale Shrine'
L['pr_raw_argali_pelts'] = 'Raw Argali Pelts'
L['pr_resonant_crystal'] = 'Resonant Crystal'
L['pr_rumbling_deposit'] = 'Rumbling Deposit'
L['pr_spellsworn_ward'] = 'Spellsworn Ward'
L['pr_spiceless_stew'] = 'Spiceless Stew'
L['pr_tuskarr_kite_post'] = 'Tuskarr Kite Post'
L['pr_tuskarr_tanning_rack'] = 'Tuskarr Tanning Rack'
L['pr_volatile_brazier'] = 'Volatile Brazier'

L['options_icons_profession_rares'] = 'Profession Rares'
L['options_icons_profession_rares_desc'] = 'Display locations of Profession Rares.'

L['storm_bound_chest_label'] = 'Storm-Bound Chest'

L['hoarder_of_the_forbidden_reach_suffix'] = 'small treasures opened'
L['forbidden_spoils_suffix'] = 'Forbidden Hoards opened'
L['forbidden_hoard_label'] = 'Forbidden Hoard'

L['options_icons_forbidden_hoard'] = 'Forbidden Hoard'
L['options_icons_forbidden_hoard_desc'] = 'Display possible locations of {object:Forbidden Hoard} chests.'

L['froststone_vault_storm_label'] = 'Froststone Vault Primal Storm'
L['gooey_snailemental_note'] = 'Combine 50x {item:204352} collected from {object:Froststone Vault Primal Storm} bosses to create {item:192785}.'

L['options_icons_froststone_vault_storm'] = 'Froststone Vault Primal Storm'
L['options_icons_froststone_vault_storm_desc'] = 'Display location and rewards for {object:Froststone Vault Primal Storm}'

L['small_treasures_label'] = 'Small Treasure'
L['small_treasures_note'] = 'Small treasures are shared between spawn points.\n\nPurchase {item:204558} from {npc:200566} at {location:Morqut Village} to receive the {spell:405637} buff which allows you to see small treasures on the minimap for 60 minutes.'

L['options_icons_small_treasures'] = 'Small Treasures'
L['options_icons_small_treasures_desc'] = 'Display possible locations for small treasures.'

L['zskera_vaults_label'] = 'Zskera Vaults'
L['zskera_vaults_note'] = 'Collect {item:202196} from various rares and chests to open doors within the {location:Zskera Vaults}.'
L['door_buster_suffix'] = 'Doors unlocked using Zskera Vault keys'

L['broken_waygate_label'] = 'Broken Waygate'
L['neltharions_toolkit_note'] = [[1. Collect {item:204278} which spawns randomly inside {location:Zskera Vaults}.

2. Travel to {location:Smoldering Perch} in {location:The Waking Shores}.

3. Find the {object:Broken Waygate} inside the cave next to {npc:193310}.

4. Repair the {object:Broken Waygate}. {note:This may require a few clicks.}

5. Teleport to the hidden room within {location:Zskera Vaults}. Kill the {npc:200375} and {npc:203639} then open the {object:Obsidian Grand Cache} to claim your loot!]]

L['recipe_rat_note_1'] = 'Speak to the {npc:202982} within {location:Zskera Vault} and {item:202252} will enter your bags.'
L['recipe_rat_note_2'] = 'Interact with {item:202252} to receive {item:204340}. {note:(5 minute cooldown)}'
L['recipe_rat_note_3'] = 'Once you have 30x {item:204340} combine the scraps to receive the recipe.'
L['recipe_rat_note_4'] = '{note:This rat loves cheese and will consume one {item:3927} roughly every three minutes. Plan accordingly!}'

L['mm_start_note'] = 'Collect and combine various items found within {location:Zskera Vaults}.'
L['mm_status_note'] = 'Combine the following items:\n{item:%s}\n{item:%s}'

L['options_icons_zskera_vaults'] = 'Zskera Vaults'
L['options_icons_zskera_vaults_desc'] = 'Display rewards for {location:Zskera Vaults}.'

L['confiscated_journal_label'] = 'Confiscated Journal'
L['farscale_manifesto_label'] = 'Farscale Manifesto'
L['lost_expeditions_notes_label'] = 'Lost Expedition Notes'
L['pirate_proclamation_label'] = 'Pirate Proclamation'
L['spellsworn_missive_label'] = 'Spellsworn Missive'
L['vrykul_tome_label'] = 'Vrykul Tome'

L['library_note'] = 'Open the {object:%s} and loot the {item:%s}.'

L['options_icons_librarian_of_the_reach'] = '{achievement:17530}'
L['options_icons_librarian_of_the_reach_desc'] = 'Display book locations for {achievement:17530} achievement. {note:Some books are in {location:Zskera Vaults}}.'

L['dracthyr_runestone_label'] = 'Dracthyr Runestone'
L['scroll_hunter_suffix'] = 'treasures found from Sealed Scrolls'
L['scroll_hunter_note'] = 'Collect sealed scrolls from various rares and treasured around {location:The Forbidden Reach}.\n\nBreaking open a {item:%s} will reveal an X on the map which will offer a {item:%s} which provides reputation for {faction:%s}.'

L['options_icons_scroll_hunter'] = '{achievement:17532}'
L['options_icons_scroll_hunter_desc'] = 'Display scroll reward locations for {achievement:17532} achievement.'

L['options_icons_scalecommander_item'] = '{achievement:17315}'
L['options_icons_scalecommander_item_desc'] = 'Display item locations for {achievement:17315} achievement. {note:Some item are in {location:Zskera Vaults}}.'

L['spellsworn_gateway'] = 'Spellsworn Gateway'
L['gemstone_of_return'] = 'Gemstone of Return'

L['treysh_note'] = 'Exchange {currency:2118} or gold for transmog, gear and mounts.'
L['renown_envoy_label'] = 'Renown Envoys'
L['renown_envoy_note'] = 'Exchange {currency:2118} or gold for mounts, pets, transmog, drake customization, recipes and other useful items.\n\nPurchase {item:204383} from {npc:200566} for 2000x {currency:2118} for a chance at {item:191915}.'
L['trader_hagarth_note'] = 'Exchange {item:190456} for Artisan Curio recipes.'

L['naszuro_caldera_of_the_menders'] = 'On top of the tower.'

L['sun_bleached_vase'] = 'Sun-Bleached Vase'
L['untranslated_tome'] = 'Untranslated Tome'
L['untranslated_tome_note'] = 'In the building with the entrance below the bridge.'
L['mysterious_boot'] = 'Mysterious Boot'
L['mysterious_boot_note'] = 'Upper floor.'
L['decaying_fishing_bucket'] = 'Decaying Fishing Bucket'
L['decaying_fishing_bucket_note'] = 'On the top floor of the tower.'
L['forgotten_fishing_pole'] = 'Forgotten Fishing Pole'
L['forgotten_fishing_pole_note'] = 'On the ground level.'
L['overgrown_fishing_bench'] = 'Overgrown Fishing Bench'
L['overgrown_fishing_bench_note'] = 'An overgrown rock, hard to see.'

-------------------------------------------------------------------------------
------------------------------ OHN'AHRAN PLAINS -------------------------------
-------------------------------------------------------------------------------

L['eaglemaster_niraak_note'] = 'Kill nearby {npc:186295s} and {npc:186299s} to spawn the rare.'
L['hunter_of_the_deep_note'] = 'Click on the weapon rack and shoot fish until the rare spawns.'
L['porta_the_overgrown_note'] = 'Find 5x {item:194426} at the bottom of the {location:Mirror of the Sky} on the west, then spread the soil at {npc:191953} to spawn the rare.'
L['scaleseeker_mezeri_note'] = 'Offer {item:194681} to {npc:193224} and follow her until she reveals the rare.\n\n{note:{npc:190315} at {location:Three-Falls Lookout} in {location:The Azure Span} is the nearest vendor.}'
L['shade_of_grief_note'] = 'Click the {npc:193166} to spawn the rare.'
L['windscale_the_stormborn_note'] = 'Kill the {npc:192367s} channeling into the {npc:192357}.'
L['windseeker_avash_note'] = 'Kill nearby {npc:195742s} and {npc:187916s} to spawn the rare.'
L['zarizz_note'] = 'Click and {emote:/hiss} at the four {npc:193169s} to summon the rare.'

L['aylaag_outpost_note'] = '{note:This rare only spawns when {faction:Clan Aylaag} Camp in {location:Aylaag Outpost}.}'
L['eaglewatch_outpost_note'] = '{note:This rare only spawns when {faction:Clan Aylaag} Camp in {location:Eaglewatch Outpost}.}'
L['river_camp_note'] = '{note:This rare only spawns when {faction:Clan Aylaag} Camp in {location:River Camp}.}'

L['defend_clan_aylaag'] = 'Defend Clan Aylaag'
L['defend_clan_aylaag_note'] = '{note:Only spawns when defending the {faction:Clan Aylaag} Camp moving events, not loot.}'

L['gold_swong_coin_note'] = 'Inside the cave with {npc:191608} to his right side.'
L['nokhud_warspear_note'] = '{item:194540} can be found in {object:Expedition Scout\'s Packs} and {object:Disturbed Dirts}.'
L['slightly_chewed_duck_egg_note'] = 'Find and pet {npc:192997} to get {item:195453}, then use it. {item:199171} incubates in 3 days into {item:199172}.'
L['yennus_boat'] = 'Tuskarr Toy Boat'
L['yennus_boat_note'] = 'Loot the {object:Tuskarr Toy Boat} to get {item:200876}. This starts the quest {quest:72063} which can be turned in at {npc:195252}.'

L['forgotten_dragon_treasure_label'] = 'Forgotten Dragon Treasure'
L['forgotten_dragon_treasure_step1'] = '1. Collect 5x {item:195884} from {object:Crystalline Flower} {dot:Green} in western {location:Ohn\'ahran Plains}.'
L['forgotten_dragon_treasure_step2'] = '2. Combine petals to create {item:195542} and visit the {object:Ancient Stone} {dot:Yellow}.'
L['forgotten_dragon_treasure_step3'] = '3. Use the {item:195542} near the {object:Ancient Stone} to gain {spell:378935} which is a 20 second buff that allows you to follow the flower path to a cave {dot:Blue}. Running over flowers increases the buff time to get to the {object:Emerald Chest} {dot:Blue} and loot the {item:195041}.'
L['forgotten_dragon_treasure_step4'] = 'Once you have the key, head to the {object:Forgotten Dragon Treasure} to open it and receive your Drakewatcher Manuscript.'
L['fdt_crystalline_flower'] = 'Crystalline Flower'
L['fdt_ancient_stone'] = 'Ancient Stone'
L['fdt_emerald_chest'] = 'Emerald Chest'

L['pm_ench_shalasar_glimmerdusk'] = 'On the second floor of the broken tower.'
L['pm_herb_hua_greenpaw'] = 'Kneels next to a tree.'
L['pm_leath_erden'] = 'Standing next to a dead {npc:193092} by the river.'
L['pt_alch_canteen_of_suspicious_water_note'] = 'Deep inside cave near a dead {npc:194887}.'
L['pt_ench_stormbound_horn_note'] = 'In {location:Windsong Rise}.'
L['pt_jewel_fragmented_key_note'] = 'Under the tree roots in a crumbled building.'
L['pt_jewel_lofty_malygite_note'] = 'Floating in the air in a cave.'
L['pt_leath_wind_blessed_hide_note'] = 'Inside {location:Shikaar Highlands} Centaur camp.'
L['pt_script_sign_language_reference_sheet_note'] = 'Hanging on the tent entrance.'
L['pt_smith_ancient_spear_shards_note'] = 'Inside a cave west of {location:Rusza\'thar Reach}.'
L['pt_smith_falconer_gauntlet_drawings_note'] = 'Island in the sea, inside a hut.'
L['pt_tailor_noteworthy_scrap_of_carpet_note'] = 'Sitting in a small hut. {note:3 elites in the hut}.'
L['pt_tailor_silky_surprise_note'] = 'Find and loot a {object:Catnip Frond}.'

L['lizi_note'] = 'Complete the daily Initiate\'s Day Out storyline starting with {quest:65901}.'
L['lizi_note_day1'] = 'Collect 20x {item:192615} from insect mobs in the {location:Dragon Isles}.'
L['lizi_note_day2'] = 'Collect 20x {item:192658} from plant mobs in the {location:Dragon Isles}.'
L['lizi_note_day3'] = 'Collect 10x {item:194966} fished from any waters in the {location:Dragon Isles}. Most commonly found in inland {location:Ohn\'ahran Plains}.'
L['lizi_note_day4'] = 'Collect 20x {item:192636} from mammoths in {location:Ohn\'ahran Plains}.'
L['lizi_note_day5'] = 'Accept {quest:71195} from {npc:190014} and get 1x {item:200598} from {npc:190015} in a tent south of {location:Ohn\'iri Springs}.'

L['ohnahra_note_start'] = 'Complete the daily questline {quest:71196} for {item:192799} in {location:Ohn\'iri Springs}. Accept the quest {quest:72512} from {npc:190022} behind a Windsage hut in {location:Ohn\'iri Springs}.\n\nGather the following materials:'
L['ohnahra_note_item1'] = 'Collect 3x {item:201929} from {npc:186151}, the final boss of the {location:Nokhud Offensive} dungeon. Not a 100% drop.'
L['ohnahra_note_item2'] = 'Purchase 1x {item:201323} from {npc:196707} for 50x {currency:2003} and 1x {item:194562}.\n{item:194562} can be looted from Time-Lost mobs in {location:Thaldrazsus}.'
L['ohnahra_note_item3'] = 'Purchase 1x {item:191507} from the Auction House. (Alchemists can purchase {item:191588} from {npc:196707} starting at Renown 22)'
L['ohnahra_note_end'] = 'Once you have all materials, turn in the quest at {npc:194796} and receive your mount.'

L['bakar_note'] = 'Pet the dog!'
L['bakar_ellam_note'] = 'If enough players pet this dog, she will lead you to her treasure.'
L['bakar_hugo_note'] = 'Travels with the Aylaag Camp.'
L['options_icons_bakar'] = '{achievement:16424}'
L['options_icons_bakar_desc'] = 'Display bakar locations for the {achievement:16424} achievement.'

L['ancestor_note'] = 'Get the {spell:369277} buff (1 hour) in a tent at the {location:Timberstep Outpost} from {object:Essence of Awakening} to see the ancestor and offer him the required item.'
L['options_icons_ancestor'] = '{achievement:16423}'
L['options_icons_ancestor_desc'] = 'Display ancestor locations for the {achievement:16423} achievement.'

L['dreamguard_note'] = 'Target the Dreamguard and {emote:/sleep}'
L['options_icons_dreamguard'] = '{achievement:16574}'
L['options_icons_dreamguard_desc'] = 'Display dreamguard locations for the {achievement:16574} achievement.'

L['khadin_note'] = 'Exchange {item:191784} for profession knowledge.'
L['khadin_prof_note'] = 'Earn %d more {currency:%d}s to max out {spell:%d} profession tree.'
L['the_great_swog_note'] = 'Exchange {item:199338}, {item:199339} and {item:199340} for {item:202102}.'
L['hunt_instructor_basku_note'] = 'Exchange {item:200093} for {faction:2503} reputation.'
L['elder_yusa_note'] = 'Target {npc:192818} and {emote:/hungry} to obtain the cooking recipe.'
L['initiate_kittileg_note'] = 'Complete {quest:66226} to obtain the toy!'

L['quackers_duck_trap_kit'] = 'To summon {npc:192557} you first need the {item:194740} which you can find in a nearby Clan Aylaag camp {dot:Blue}.\n\nTo make a {item:194712} you need the following materials:'
L['quackers_spawn'] = 'Next you need to catch a duck near the nest with the {item:194712}. Use the {item:194739} at the {npc:192581} to summon {npc:192557}.'

L['knew_you_nokhud_do_it_note'] = '{note:All 3 items are unique and have a 30 minute timer.}\n\nCollect {item:200184}, {item:200194}, and {item:200196} from various {npc:185357s}, {npc:185353s}, and {npc:185168s} around {location:Nokhudon Hold}.\n\nCombine them to create {item:200201} and use it to speak with {npc:197884} to begin the training course.\n\nUse your |cFFFFFD00Extra Action Button|r to complete it and earn your achievement.\n\n{note:Completing the achievement while in a raid during an Elemental Storm makes farming the items much easier.}'
L['options_icons_nokhud_do_it'] = '{achievement:16583}'
L['options_icons_nokhud_do_it_desc'] = 'Display helpful information for completing {achievement:16583} achievement.'

L['chest_of_the_flood'] = 'Chest of the Flood'

L['aylaag_camp_note'] = '{faction:Clan Aylaag} moves on to another camp every 3 days and 3 hours (75 hours), follow them and defend them on their way.\n\nNext move: {note:%s}'

L['clan_chest'] = 'Clan Chest'
L['options_icons_clan_chest'] = 'Clan Chests'
L['options_icons_clan_chest_desc'] = 'Display possible locations of {object:Clan Chests}.'

L['lightning_bound_chest'] = 'Lightning Bound Chest'
L['options_icons_lightning_bound_chest'] = 'Lightning Bound Chest'
L['options_icons_lightning_bound_chest_desc'] = 'Display possible locations of {object:Lightning Bound Chests}.'

L['bloodgullet_note'] = 'Get the {spell:369277} buff (1 hour) in a tent at the {location:Timberstep Outpost} from {object:Essence of Awakening} to see this Spirit Beast.\n\n{note:Only appears to Beast Mastery Hunters.}'

L['naszuro_windsong_rise'] = 'On top of the rock pillar.'
L['naszuro_emerald_gardens'] = 'On the grass besides the waterfall.'

L['prismatic_leaper_school_label'] = 'Prismatic Leaper School'
L['prismatic_leaper_school_note'] = 'Speak with {npc:195935} in {location:Iskaara} to make your upgrades.\n\nFish up the following items from {object:Prismatic Leaper Schools} throughout the {location:Ohn\'ahran Plains}:\n\n{item:%d}\n{item:%d}\n{item:%d}\n{item:%d}\n{item:%d}'

L['aylaag_spear'] = 'Aylaag Spear'
L['dedication_plaquard'] = 'Dedication Plaquard'

-------------------------------------------------------------------------------
--------------------------------- THALDRASZUS ---------------------------------
-------------------------------------------------------------------------------

L['ancient_protector_note'] = 'Kill nearby {npc:193244} to get {item:197708}. Combine 5 {item:197708} to create a {item:197733} and use it to activate nearby {object:Titanic Reactors}.'
L['blightpaw_note'] = 'Talk to {npc:193222} nearby and agree to help him.'
L['corrupted_proto_dragon_note'] = 'Inspect the {object:Corrupted Dragon Egg} to spawn the rare.'
L['lord_epochbrgl_note'] = 'Click {npc:193257} to spawn the rare.'
L['the_great_shellkhan_note'] = 'Collect {item:200949} from {location:Kauriq Gleamlet} in {location:The Azure Span}, go back to {npc:191416} within 3 minutes to return the item to activate the rare and get the achievement.\n\n{note:Make sure {npc:191416} and {npc:191305} are acutally there before you start. Only one character can pick up and return the item once a week to activate the rare, after which {npc:191416} will only thank you.}'
L['weeping_vilomah_note'] = 'Talk to {npc:193206} to summon the rare.'
L['woofang_note'] = 'Pet {npc:193156} to spawn the rare.'

L['acorn_harvester_note'] = 'Collect an {object:Acorn} from the ground nearby to get {spell:388485} and then interact with {npc:196172}.\n\n{bug:(BUG: To click on {npc:196172} a reload might be necessary)}'
L['cracked_hourglass_note'] = '{item:199068} can be found in {object:Expedition Scout\'s Packs} and {object:Disturbed Dirts}.'
L['sandy_wooden_duck_note'] = 'Collect {item:199069} and use it.'

L['tasty_hatchling_treat_note'] = 'In a barrel behind the bookshelf.'

L['pm_mining_bridgette_holdug'] = 'On top of a grassy rock pillar.'
L['pm_tailor_elysa_raywinder'] = 'On a ledge halfway up the tower.'
L['pt_alch_contraband_concoction_note'] = 'Hidden in bushes. {note:Difficult to see}.'
L['pt_alch_tasty_candy_note'] = 'Drop a nearby {object:Discarded Toy} into each cauldron.'
L['pt_ench_fractured_titanic_sphere_note'] = 'South of {location:Tyrhold}.'
L['pt_jewel_alexstraszite_cluster_note'] = 'In {location:Tyrhold}.'
L['pt_jewel_painters_pretty_jewel_note'] = 'Inside a lantern.'
L['pt_leath_decayed_scales_note'] = 'Inside a basket.'
L['pt_script_counterfeit_darkmoon_deck_note'] = 'Speak to {npc:194856} and offer to help her with the {object:Darkmoon Deck} scattered at her feet. Click the cards in the correct order (Ace through 8) then speak to her again.'
L['pt_script_forgetful_apprentices_tome_note'] = 'On a table near a big telescope.'
L['pt_script_forgetful_apprentices_tome_algethera_note'] = 'Click on the {object:Curious Glyph} to get the buff {spell:384818}. Cross the bridge and loot {item:198672} from {npc:194880} and bring it back to the Glyph.'
L['pt_script_how_to_train_your_whelpling_note'] = 'Little brown book lying in the sandbox.'
L['pt_smith_draconic_flux_note'] = 'Inside a building.'
L['pt_tailor_ancient_dragonweave_bolt_note'] = 'Click on the {object:Ancient Dragonweave Loom} to complete a minigame where you connect the spools of thread to the center gem.'
L['pt_tailor_miniature_bronze_dragonflight_banner_note'] = 'Small banner inside a pile of sand.'

L['picante_pomfruit_cake_note'] = '{item:200904} is not always available so check back daily. While you are there, be sure to sample the 3 available dishes to complete {achievement:16556} achievement as well.'
L['icecrown_bleu_note'] = 'Purchase from {npc:196729} {title:<Cheesemonger>} in {location:The Artisan\'s Market}.'
L['dreamwarding_dripbrew_note'] = 'Purchase from {npc:197872} {title:<Caffeinomancer>} at {location:The Late Night Lab}.'
L['arcanostabilized_provisions_note'] = 'Purchase from {npc:198831} {title:<Head Chef>} at the {location:Temporal Conflux} in the {location:Primalist Future}.'
L['steamed_scarab_steak_note'] = 'Purchase from {npc:197586} {title:<Spa Bartender>} at {location:Serene Dreams Spa}.'
L['craft_creche_crowler_note'] = 'Purchase from {npc:187444} {title:<Traveling Dragonbrew Vendor>} at random map place per day: {location:Ruby Lifeshrine}, {location:Dragonscale Basecamp}, {location:Camp Nowhere}, {location:Missing Hinge Inn}, {location:Temporal Conflux}, {location:Gelikyr Post} and {location:Greenscale Inn}.'
L['bivigosas_blood_sausages_note'] = 'Purchase from {npc:188895} {title:<Food & Drink>} at {location:Gelikyr Post}.'
L['rumiastrasza_note'] = '{note:Complete the daily questline starting at {quest:71238} from {location:Valdrakken}, otherwise the achievement cannot be completed.}'
L['options_icons_specialties'] = '{achievement:16621}'
L['options_icons_specialties_desc'] = 'Display food and drink locations for the {achievement:16621} achievement.'

L['new_perspective_note'] = 'Take a picture with the S.E.L.F.I.E. camera at the vista. The location will be marked by a purple light circle as soon as you are in camera mode.\n\nIf you dont get credit towards the achievement, change your angle.'
L['options_icons_new_perspective'] = '{achievement:16634}'
L['options_icons_new_perspective_desc'] = 'Display vista locations for the {achievement:16634} achievement.'

L['fringe_benefits_note'] = 'Complete 8 of the daily quests to earn the achievement.'
L['options_icons_fringe_benefits'] = '{achievement:19507}'
L['options_icons_fringe_benefits_desc'] = 'Display the location where the daily quests for the {achievement:19507} achievement can be accepted.'

L['little_scales_daycare_note'] = 'You have to do a questline over multiple days, starting with {quest:72664} from {npc:197478}, to earn this achievement and the pet.'
L['options_icons_whelp'] = '{achievement:18384}'
L['options_icons_whelp_desc'] = 'Display the location where the daily quests for the {achievement:18384} achievement can be accepted.'

L['ruby_feast_gourmand'] = 'Every day, a random guest chef serves up different dishes and drinks.'
L['options_icons_ruby_feast_gourmand'] = '{achievement:16556}'
L['options_icons_ruby_feast_gourmand_desc'] = 'Display the location where the daily quests for the {achievement:16556} achievement can be accepted.'

L['sorotis_note'] = 'Exchange {item:199906} for {faction:2510} reputation.'
L['lillian_brightmoon_note'] = 'Exchange {item:201412} for {faction:2507} reputation.'

L['chest_of_the_elements'] = 'Chest of the Elements'

L['hoard_of_draconic_delicacies_note_start'] = 'Complete the following 7 quests provided by {npc:189479}:'
L['hoard_of_draconic_delicacies_note_end'] = 'After all quests have been completed {npc:189479} will provide {quest:67071} to receive your recipe.\n\n{note:Quests are based on the active guest chef at {location:The Ruby Enclave} and may not match the order listed above.}'

L['brendormi_note_start'] = 'Exchange {item:202039} and {currency:2118} for gear, a pet, a toy, and a mount.'
L['brendormi_note_item'] = 'You currently have %s {item:202039}.'
L['brendormi_note_currency'] = 'You currently have %s {currency:2118}.'

L['titan_chest'] = 'Titan Chest'
L['options_icons_titan_chest'] = 'Titan Chest'
L['options_icons_titan_chest_desc'] = 'Display possible locations of {object:Titan Chest}.'

L['living_mud_mask_note'] = [[
{npc:197346} will drop the {item:200586} which give you the {quest:70377} quest. This will take you over to {npc:198062} to turn them in.

After that you have to speak with {npc:198062} again and ask him for a better reward. He will take a glider over to the VIP area so you can 'enjoy his company further as a reward'.

When you arrive at the floating island {npc:198062} will be on the floor. Speak with him again, saying that he looks dead.

A small slime called {npc:198590} will spawn and run away to a branch behind {npc:197232}. Once you get close enough the slime will offer you the quest {quest:72060}.

Go back to {npc:198062}, sitting on a bench, and turn in the quest for your {item:200872}.
]]

L['naszuro_veiled_ossuary'] = 'Besides the small shrine.'
L['naszuro_algethar_academy'] = 'On the ledge of the tower top.'
L['naszuro_vault_of_the_incarnates'] = 'At the foot of the statue.'
L['naszuro_thaldraszus_peak'] = 'On a secondary peak of the mountain.'
L['naszuro_temporal_conflux'] = 'On the head of the dragon statue.'

L['revival_catalyst_label'] = 'Revival Catalyst'
L['revival_catalyst_note'] = 'Convert non-tier gear into an equivalent item level and gear slot Tier piece.\n\n{currency:2912}: %d/%d'

L['provisioner_aristta_note'] = 'Exchange {currency:2657} for transmogs and a mount.'

L['investigators_pocketwatch_note_a'] = '1. Borrow {item:208449} from {npc:204990} ({dot:Green}) upstairs in {location:Everywhen Inn} in {location:Eon\'s Fringe}.\n\n{note:You must have previously completed her quest chain.}'
L['investigators_pocketwatch_note_b'] = '2. Use {item:208449} near {npc:203769} ({dot:Blue}) downstairs in {location:Everywhen Inn} in {location:Eon\'s Fringe} and purchase {item:208448} from {npc:207463}.\n\n{note:{item:208448} has a 30 second duration. Be quick!}'
L['investigators_pocketwatch_note_c'] = '3. Quickly get to the waterfall and drink the {item:208448}. Interact with the newly visible {object:Time-Soaked Clock} to spawn the {npc:201664}.'

L['ominous_portal_label'] = 'Ominous Portal'
L['ominous_portal_note'] = 'Every 30 minutes an {object:Ominous Portal} will spawn.\n\n5 minutes later {npc:214984} will spawn several bosses. Defeat {npc:215141}, {npc:215147}, and {npc:215146} for your chance at the rewards.\n\n{note:There is no daily loot lockout.}'

-------------------------------------------------------------------------------
------------------------------ THE WAKING SHORE -------------------------------
-------------------------------------------------------------------------------

L['brundin_the_dragonbane_note'] = 'The Qalashi War Party travels on their {npc:192737} to this tower.'
L['captain_lancer_note'] = 'Spawns immediately after completing the {spell:388945} event.'
L['enkine_note'] = 'Kill {npc:193137}, {npc:193138} or {npc:193139} along the lava river to get {item:201092}, use it and fish near {npc:191866} in the lava.'
L['lepidoralia_note'] = 'Located in the {location:Fluttering Cavern}. Help {npc:193342} catch {npc:193274s} until the rare spawns.'
L['obsidian_citadel_rare_note'] = 'You and other players have to return a total of %dx {item:191264} to %s. To craft a key you need to combine 30x {item:191251} and 3x {item:193201}, you can get these items from {location:Obsidian Citadel} mobs.'
L['shadeslash_note'] = 'Click the {object:Pilfered Globe}, {object:Pilfered Telescope} and {object:Pilfered Focus} to summon the rare.'
L['obsidian_throne_rare_note'] = 'Inside the {location:Obsidian Throne}.'
L['slurpo_snail_note'] = 'Loot a {item:201033} from {object:Salt Crystal} in {location:The Azure Span} cave (11, 41) and use it in {location:The Waking Shores} cave to summon him.'
L['worldcarver_atir_note'] = 'Collect 3x {item:191211} from {npc:187366} nearby and place them at {npc:197395} to spawn the rare.'

L['bubble_drifter_note'] = '{item:199061} can be found in {object:Expedition Scout\'s Packs} and {object:Disturbed Dirts}.\n\nTo interact with the fish you need to get {spell:388331} from the {object:Fragrant Plant} nearby.'
L['dead_mans_chestplate_note'] = 'Inside the tower on the middle floor.'
L['fullsails_supply_chest_note'] = 'The key drops from {npc:187971s} and {npc:187320s} south of {location:Wingrest Embassy}.'
L['golden_dragon_goblet_note'] = 'Loot {item:202081} from {npc:190056} on the {location:Wild Coast} and complete the small quest line.'
L['lost_obsidian_cache'] = 'Lost Obsidian Cache'
L['lost_obsidian_cache_step1'] = '1. Collect {item:194122} at the foot of {npc:186763}.'
L['lost_obsidian_cache_step2'] = '2. Use {item:194122} on {npc:191851}, then ride it to the cave entrance.'
L['lost_obsidian_cache_step3'] = '3. Collect {item:198085} from {object:Lost Cache Key} in the cave, then open {object:Lost Obsidian Cache} to obtain the toy.'
L['misty_treasure_chest_note'] = 'Stand on the {npc:185485} that sticks out of the waterfall to enter the cave.'
L['onyx_gem_cluster_note'] = 'At Renown 21 with the {faction:2507} you can complete the quest {quest:70833} to get an {item:200738} as a reward (one time per account). Otherwise you can buy the map from {npc:189065} for 3 {item:192863} and 500 {currency:2003}.'
L['torn_riding_pack_note'] = 'Located at the top of the waterfall.'
L['yennus_kite_note'] = 'Stuck in a branch at the top of the tree.'

L['fullsails_supply_chest'] = 'Fullsails Supply Chest'
L['hidden_hornswog_hoard_note'] = [[
Collect three different items and combine them at the {object:"Observant Riddles: A Field Guide"} near the {npc:192362} to get {item:200063} and feed it. He will then move out of the way so you can loot his treasure.

{item:200064} {dot:Yellow}
{item:200065} {dot:Blue}
{item:200066} {dot:White}
]]

L['pm_alch_grigori_vialtry'] = 'On a ledge overlooking {location:Flashfrost Assault}.'
L['pm_skin_zenzi'] = 'Sits next to the river.'
L['pm_smith_grekka_anvilsmash'] = 'Sits in the grass next to the ruined tower.'
L['pt_alch_frostforged_potion_note'] = 'In the middle of the icy crater.'
L['pt_alch_well_insulated_mug_note'] = 'In {location:Dragonbane Keep} between a number of elite mobs.'
L['pt_ench_enchanted_debris_note'] = 'Use and follow the {npc:194872} to loot the debris at the end.'
L['pt_ench_flashfrozen_scroll_note'] = 'Inside the {location:Flashfrost Enclave} cave system.'
L['pt_ench_lava_infused_seed_note'] = 'In a flower in {location:Scalecracker Keep}.'
L['pt_engi_boomthyr_rocket_note'] = 'Collect the items listed in the {object:Boomthyr Rocket Notes}:\n\n{item:198815}\n{item:198817}\n{item:198816}\n{item:198814}\n\nOnce gathered, bring them back to the rocket to receive the treasure.'
L['pt_engi_intact_coil_capacitor_note'] = 'Interact with the three {object:Exposed Wire} to fix and loot the {object:Overcharged Tesla Coil}.'
L['pt_jewel_closely_guarded_shiny_note'] = 'Blue gem underneath a tree next to a nest.'
L['pt_jewel_igneous_gem_note'] = 'Quickly click the 3 crystals on small islands inside the magma.'
L['pt_leath_poachers_pack_note'] = 'Next to a dead Vulpera beside the riverbed.'
L['pt_leath_spare_djaradin_tools_note'] = 'Next to dead red dragon.'
L['pt_script_pulsing_earth_rune_note'] = 'Behind a table inside the crumbled building.'
L['pt_smith_ancient_monument_note'] = 'Defeat the 4 {npc:188648} surrounding a sword on a pedestal.\n\n{bug:(BUG: Currently you don\'t get the item after clicking the sword. Instead it will be sent to your mailbox after some time.)}'
L['pt_smith_curious_ingots_note'] = 'Small ingot on the ground in {location:Scalecracker Keep}.'
L['pt_smith_glimmer_of_blacksmithing_wisdom_note'] = 'Craft a {item:189541} near the {object:Dim Forge} and the item in the {object:Slack Tub} will become lootable.'
L['pt_smith_molten_ingot_note'] = 'Kick 3 ingots into the lava to spawn a mob. Loot the chest after the mob is defeated.'
L['pt_smith_qalashi_weapon_diagram_note'] = 'On top of an anvil.'
L['pt_tailor_itinerant_singed_fabric_note'] = 'A piece of fabric hanging on a tree just outside the cave where the end boss spawns. {note:Requires precision dragonriding or a warlock portal}.'
L['pt_tailor_mysterious_banner_note'] = 'Fluttering on top of the buildings.'

L['quack_week_1'] = 'Week 1'
L['quack_week_2'] = 'Week 2'
L['quack_week_3'] = 'Week 3'
L['quack_week_4'] = 'Week 4'
L['quack_week_5'] = 'Week 5'
L['lets_get_quacking'] = 'You can only rescue a single {npc:187863} per week.'

L['complaint_to_scalepiercer_note'] = 'Click on the {object:Stone Tablet} inside the hut (on the left side at the back).'
L['grand_flames_journal_note'] = 'Click on the {object:Stone Tablet} outside behind the hut.'
L['wyrmeaters_recipe_note'] = 'Click on the {object:Stone Tablet} inside the hut (on the left side).'

L['options_icons_ducklings'] = '{achievement:16409}'
L['options_icons_ducklings_desc'] = 'Display duckling locations for the {achievement:16409} achievement.'
L['options_icons_chiseled_record'] = '{achievement:16412}'
L['options_icons_chiseled_record_desc'] = 'Display tablet locations for the {achievement:16412} achievement.'

L['grand_theft_mammoth_note'] = 'Ride the {npc:194625} to {npc:198163}.\n\n{bug:(BUG: If you can\'t interact with {npc:194625} try /reload.)}'
L['options_icons_grand_theft_mammoth'] = '{achievement:16493}'
L['options_icons_grand_theft_mammoth_desc'] = 'Display {npc:194625} locations for the {achievement:16493} achievement.'

L['options_icons_stories'] = '{achievement:16406}'
L['options_icons_stories_desc'] = 'Quest locations for the {achievement:16406} achievement.'
L['all_sides_of_the_story_garrick_and_shuja_note'] = 'Start the questline and listen to the story of {npc:184449} and {npc:184451}.'
L['all_sides_of_the_story_duroz_and_kolgar_note'] = 'In a small room underneath the platform.\n\nStart the questline and listen to the story of {npc:194800} and {npc:194801}. More quests will be unlocked in the next two weeks.'
L['all_sides_of_the_story_tarjin_note'] = 'Start the questline with {quest:70779}.\n{npc:196214} will tell you another story every week.'
L['all_sides_of_the_story_veritistrasz_note'] = 'Start the quest {quest:70132} and listen to all the stories of {npc:194076}.\nAfter that you will unlock {quest:70134} followed by {quest:70268}.\n\nFor the last quest you will need {item:198661} which is found inside {location:Dragonbane Keep}.'

L['slumbering_worldsnail_note1'] = [[
1. Loot 3x {item:193201} and 30x {item:191251} from mobs around {location:Obsidian Citadel} to form a {item:191264}.

2. Exchange the {item:191264} for a {item:200069} from {npc:187275}.

3. There is a 30% chance the chest will contain a {item:199215}.

4. Using the membership will give you the {spell:386848} debuff which allows you to farm {item:202173} around the {location:Obsidian Citadel}.

5. Collect 1000x {item:202173} to purchase {item:192786}.
]]

L['slumbering_worldsnail_note2'] = '{note:If you die you will lose your membership debuff. Either purchase a new membership from {npc:193310} for 20x {item:202173} before you die or turn in more keys for a chance at a new membership.}'

L['magmashell_note'] = 'Loot {item:201883} from {npc:193138} around {location:Obsidian Citadel} and bring it to the {npc:199010}.\n\n{note:There is a 20 second spell channel while in the lava to obtain the mount so bringing a healer or something like {item:200116} is recommended}.}'

L['otto_note_start1'] = 'Purchase an {item:202102} from {npc:191608} in the {location:Ohn\'ahran Plains} to collect a pair of {item:202042}. The bag requires 75x {item:199338} which you can fish up or loot from {title:<Lunker>} mobs near fishing holes.'
L['otto_note_start2'] = 'Head over to {location:The Bubble Bath} dive bar in the {location:Hissing Grotto}, use the shades and find a dancing mat. Stand on it until you pass out, then loot the {item:202061}.'
L['otto_note_item1'] = 'Collect 100x {item:202072} from open waters near {location:Iskaara} in {location:Azure Span}. Use the barrel to get a {item:202066}.'
L['otto_note_item2'] = 'Collect 25x {item:202073} from the lava around the {location:Obsidian Citadel} in {location:The Waking Shores}. Use the barrel to get a {item:202068}.'
L['otto_note_item3'] = 'Collect 1x {item:202074} from the waters by {location:Algeth\'ar Academy} in {location:Thaldraszus}. Use the barrel to get an {item:202069}.'
L['otto_note_end'] = 'Return to the {location:Hissing Grotto} and leave the barrel where you found it to summon {npc:199563} and receive your mount!'

L['options_icons_safari'] = '{achievement:16519}'
L['options_icons_safari_desc'] = 'Display battle pet locations for the {achievement:16519} achievement.'
L['shyfly_note'] = 'You have to be on the quest {quest:70853} to see the {npc:189102}.'

L['cataloger_jakes_note'] = 'Exchange {item:192055} for {faction:2507} reputation.'

L['snack_attack_suffix'] = 'snacks fed to Beef'
L['snack_attack_note'] = 'Collect {npc:195806s} and feed {npc:194922} 20 times.\n\n{note:This does not need to be completed during a single siege.}'
L['options_icons_snack_attack'] = '{achievement:16410}'
L['options_icons_snack_attack_desc'] = 'Display {npc:195806} locations for the {achievement:16410} achievement.'

L['loyal_magmammoth_step_1'] = 'Step 1'
L['loyal_magmammoth_step_2'] = 'Step 2'
L['loyal_magmammoth_step_3'] = 'Step 3'
L['loyal_magmammoth_true_friend'] = 'True Friend'
L['loyal_magmammoth_wrathion_quatermaster_note'] = 'Purchase {item:201840} ' .. '|cFFFFD700(800 gold)|r' .. ' from either {npc:199020} or {npc:188625}.'
L['loyal_magmammoth_sabellian_quatermaster_note'] = 'Purchase {item:201839} ' .. '|cFFFFD700(800 gold)|r' .. ' from either {npc:199036} or {npc:188623}.'
L['loyal_magmammoth_harness_note'] = 'Purchase {item:201837} from {npc:191135}.'
L['loyal_magmammoth_taming_note'] = 'Use the {item:201837} while riding a {npc:198150} to obtain your mount!\n\n{note:Reports indicate you may only be able to harness the {npc:198150} found in the {location:Burning Ascent}.}'

L['djaradin_cache'] = 'Djaradin Cache'
L['options_icons_djaradin_cache'] = 'Djaradin Cache'
L['options_icons_djaradin_cache_desc'] = 'Display possible locations of {object:Djaradin Cache}.'

L['dragonbane_siege_label'] = '{spell:388945}'
L['options_icons_dragonbane_siege'] = '{spell:388945}'
L['options_icons_dragonbane_siege_desc'] = 'Display locations and rewards for the {spell:388945}.'

L['phoenix_wishwing_note'] = [[
After obtaining the {item:199203}, {npc:196214} will offer a turn-in quest which rewards {item:193373}.
To finish the quest, you will need following items (you can get these in any order):
]]
L['phoenix_wishwing_talisman'] = [[
%s {item:199203}

This is sold by {npc:88045} {dot:Gold} in {location:Spires of Arak}. If {npc:88045} is not present, complete the quest {quest:35010} to be able to see him.
You need following Items to buy it:]]
L['phoenix_wishwing_phoenix_ember'] = '%s {item:199099}\nDrops from {npc:52530} in {location:Firelands Timewalking}'
L['phoenix_wishwing_sacred_ash'] = '%s {item:199097}\nCan be found within {object:Cookpots}, located around {location:Spires of Arak}.'
L['phoenix_wishwing_inert_ash'] = '%s {item:199092}\nDrops rarely from {npc:6520} and {npc:6521} at the center of {location:Un\'Goro Crater} {dot:Gray}'
L['phoenix_wishwing_smoldering_ash'] = [[
%s {item:199080}

Farm the various {npc:Phoenixes} {dot:Yellow} such as {npc:181764} or {npc:195448} found on the {location:Dragon Isles}.
These can mostly be found around the {location:Obsidian Citadel} in {location:The Waking Shores}.
]]
L['phoenix_wishwing_ash_feather'] = [[
%s {item:202062}

To see the {object:Feathers} you need to purchase the {item:199177} from {npc:189207} {dot:Green} in {location:The Waking Shores} at the {location:Obsidian Throne}.
Use this necklace and pick up {item:202062} {dot:Red} found within the {location:Burning Ascent} and {location:The Slagmire}, which are areas surrounding the {location:Obsidian Citadel}.
]]
L['phoenix_wishwing_info'] = 'This is part of the {item:193373} Collectible located in {location:The Waking Shore} on the {location:Dragon Isles}.'

L['bugbiter_tortoise_note'] = 'Collect {item:202082}({dot:Red}) and {item:202084}({dot:Green}) and exchange it at {npc:187077} for your {item:202085}.\n\n{npc:187077} requires the world quest {wq:Brightblade\'s Bones} to be active.'

L['naszuro_apex_canopy'] = 'On a small pillar of the stair.'
L['naszuro_obsidian_throne'] = 'On the left side of the throne where {npc:185894} and {npc:187495} are.'
L['naszuro_ruby_lifeshrine'] = 'Under the claw of the dragon statue.'
L['naszuro_dragonheart_outpost'] = 'In the branches of the tree.'

L['box_of_rocks_label'] = 'Box of Rocks'
L['box_of_rocks_note'] = '{object:Box of Rocks} can be found around {location:The Waking Shore}, within {location:Zskera Vaults}, or purchased from the auction house.'
L['options_icons_many_boxes'] = '{achievement:18559}'
L['options_icons_many_boxes_desc'] = 'Show possible {object:Box of Rocks} locations for {achievement:18559} achievement.'

L['drakonid_painting'] = 'Drakonid Painting'
L['emptied_hourglass'] = 'Emptied Hourglass'
L['rusted_signal_horn'] = 'Rusted Signal Horn'
L['rusted_signal_horn_note'] = 'On the top floor.'

-------------------------------------------------------------------------------
------------------------------- Zaralek Cavern --------------------------------
-------------------------------------------------------------------------------

L['in_deepflayer_nest'] = 'Within {location:Deepflayer Nest}'

L['brulsef_the_stronk_note'] = 'Loot your rewards from the {object:Chest of Massive Gains}.\n\n{bug:Don\'t defeat him while he\'s channeling {spell:412495} or casting {spell:412492}, otherwise there will be no chest after defeating him.}'

L['ancient_zaqali_chest_note'] = 'Use a nearby {object:Bottled Magma} to open the chest.'
L['blazing_shadowflame_chest_note'] = 'Equip the {item:15138}, which can be bought from the auction house or crafted by a leatherworker, to loot the chest.'
L['crystal_encased_chest_note'] = 'Interact with both the blue {object:Attunement Crystal} ({dot:Blue}) and red {object:Attunement Crystal} ({dot:Red}) to open the chest.'
L['old_trunk_note'] = 'Find and collect the {npc:204277} 5 times, to get the {item:204323}. {note:The first mouse is next to the chest.}'
L['well_chewed_chest_note'] = 'The {item:202869}({dot:Green}) is hidden underneath the {npc:199962} within the cave.'

L['molten_hoard_label'] = 'Molten Hoard'
L['fealtys_reward_label'] = 'Fealty\'s Reward'
L['fealtys_reward_note'] = 'Kneel {emote:/kneel} in front of the dragon statue in the southwest until it breathes fire to be able to open the chest.'
L['dreamers_bounty_label'] = 'Dreamer\'s Bounty'
L['dreamers_bounty_note'] = 'The {object:Dreamers\'s Bounty} can only be looted while you have the {spell:400066} debuff on you which you get from {npc:201068} nearby.'
L['moth_pilfered_pouch_label'] = 'Moth-Pilfered Pouch'
L['moth_pilfered_pouch_note'] = 'Help the {npc:203225} to fly by "juggling" it until it has five stacks of {spell:405358}.\n\nIt will then fly to the pouch and reveal it to you.'
L['waterlogged_bundle_label'] = 'Waterlogged Bundle'

L['stolen_stash_label'] = 'Stolen Stash'
L['ritual_offering_label'] = 'Ritual Offering'
L['options_icons_ritual_offering'] = 'Ritual Offering'
L['options_icons_ritual_offering_desc'] = 'Display possible locations of {object:Ritual Offerings}.'
L['nal_kskol_reliquary_label'] = 'Nal ks\'kol Reliquary'
L['nal_kskol_reliquary_note'] = 'Use the {object:Reliquary Access Console} and solve the puzzle to open the {object:Nal ks\'kol Reliquary}.'

L['busted_wyrmhole_generator_note'] = '{item:205954} also looted from {object:Busted Wyrmhole Generator}.\nOn use to unlock {location:Zaralek Cavern} wormhole option for {item:198156}.'
L['molten_scoutbot_note'] = 'Open the {object:Molten Scoutbot} and loot the {item:204855}.'
L['bolts_and_brass_note'] = 'Open the {object:Bolts and Brass} and loot the {item:204850}.'

L['sniffen_sage_suffix'] = 'special items found'
L['sniffen_digs_suffix'] = 'Sniffenseek digs completed'

L['big_slick_note'] = 'Complete daily quests from {npc:201752} to reach the reputation level "Professional" (total 2800 reputation) at the faction {faction:2568} to get your mount.\n\nOr show him the following snails (pets) at level 25 to get 100 reputation for each:'
L['grogul_note'] = 'Talk to {npc:204672} and choose a treat that you can use to encourage this snail to move faster.\n{note:The achievement can be obtained before Renown 7.}'

L['saccratos_note'] = 'Exchange {item:204727} for a pet, mount, and more.'
L['ponzo_note'] = 'Exchange {item:204985} for drake customizations, pet, mount, and more.'

L['smelly_trash_pile_label'] = 'Smelly Trash Pile'
L['options_icons_smelly_trash_pile'] = 'Smelly Trash Pile'
L['options_icons_smelly_trash_pile_desc'] = 'Display possible locations of {object:Smelly Trash Pile}.'

L['smelly_treasure_chest_label'] = 'Smelly Treasure Chest'
L['options_icons_smelly_treasure_chest'] = 'Smelly Treasure Chest'
L['options_icons_smelly_treasure_chest_desc'] = 'Display possible locations of {object:Smelly Treasure Chest}.'

L['seething_cache_treasure_note'] = 'To be able to see the {object:Seething Cache} and loot the {item:192779} you\'ll need to pick up 3x stacks of a {spell:399342} debuff from {object:Seething Orbs} located in the {location:Zaqali Caldera} area in {location:Zaralek Cavern}.'
L['chest_of_the_flights_treasure_note'] = 'To open the treasure chest you need to click on the {object:Empowered Gems} in the order {note:Red > Black > Blue > Yellow > Green}.'
L['curious_top_hat_note'] = 'Interact with {npc:205010} while you have the {spell:410288} Buff to recieve {item:205021}. If you dont have the Buff and go near him he will run away.'

L['the_gift_of_cheese_note_1'] = 'Click the {object:Squeaking Swiss} within {location:Obsidian Rest} and {item:204871} will enter your bags.'
L['the_gift_of_cheese_note_2'] = 'Interact with {item:204871} to receive {item:204872}. {note:(5 minute cooldown)}'
L['the_gift_of_cheese_note_3'] = 'Once you have 30x {item:204872} combine the scraps to receive the recipe.'
L['the_gift_of_cheese_note_4'] = '{note:This rat loves cheese and will consume one {item:3927} roughly every three minutes. Plan accordingly!}'
L['the_gift_of_cheese_note_5'] = 'Once you can can craft {item:204848} simply feed 50 {npc:4075} found around Azeroth to complete the achievement.'

L['zaralek_rare_active'] = '|cFF0066FFThis Rare can spawn today.|r'
L['zaralek_rare_inactive'] = '|cFFFF8C00This Rare will not spawn today, come back tomorrow.|r'
L['zaralek_event_active'] = '|cFF0066FFThis Zone Event can start today.|r'
L['zaralek_event_inactive'] = '|cFFFF8C00This Zone Event will not start today, come back tomorrow.|r'

L['options_icons_zone_event'] = 'Zone Event'
L['options_icons_zone_event_desc'] = 'Display locations for zone events.'

L['djaradin_scroll'] = 'Djaradin Scroll'
L['forgotten_incense'] = 'Forgotten Incense'
L['forgotten_incense_note'] = '{note:Hard to reach due to the quest boundaries.}'
L['historied_heirloom'] = 'Historied Heirloom'
L['rusted_dirt_pale'] = 'Rusted Dirt Pale'
L['rusted_dirt_pale_note'] = '{note:Dispearing after clicking the other {object:Information-Stuffed Clues} objects in this site.}'
L['niffen_pickaxe'] = 'Niffen Pickaxe'
L['chipped_grub_pot'] = 'Chipped Grub Pot'
L['chipped_grub_pot_note'] = 'On the top of the tower.'

-------------------------------------------------------------------------------
------------------------------- Emerald Dream ---------------------------------
-------------------------------------------------------------------------------

L['options_icons_emerald_dream_safari'] = '{achievement:19401}'
L['options_icons_emerald_dream_safari_desc'] = 'Display battle pet locations for the {achievement:19401} achievement.'

L['envoy_of_winter_note'] = 'Gather {item:208881} and use {spell:421658} near the well until {npc:209929} spawns.'
L['fruitface_note'] = 'Offer {npc:209950} {dot:Pink} your help to get {spell:421446}, then {item:208837s} become visible on the ground. Pick them up to let {npc:209980} {dot:Yellow} appear. Attack and follow him until he jumps in the water {dot:Red} and summons {npc:209966} and {npc:209913}.'
L['greedy_gessie_note'] = 'You need to collect {object:Wild Greens}, {object:Rubyscale Melon} and {object:Orangeroot} from the surrounding area and put them in the baskets near the {npc:210285s} to start the encounter.'
L['nuoberon_note'] = 'Chase turtles, throw food at monkeys, or fight dream monsters to help {npc:209101} have a fun Dream!'
L['reefbreaker_moruud_note'] = 'Connect all 6 of the nearby {npc:210089} to attack {npc:209898}.'
L['splinterlimb_note'] = 'Becomes hostile after 8 stacks of the {spell:420009} debuff. The debuff stacks per completed round. Kill the mobs that attack him so that he can complete his round faster.'
L['surging_lasher_note'] = 'Can spawn during the {location:Emerald Frenzy} event in this area.'
L['talthonei_ashwisper_note'] = 'Kill mobs in the surrounding area until the killed mob says "I will be avenged" to spawn the rare.'
L['talthonei_ashwisper_wq_note'] = '{note:Can only spawn here if the world quest {wq:Portal Panic} is active.}'

L['in_a_tree'] = 'Up in a tree.'
L['inside_building'] = 'In the building.'

L['hidden_moonkin_stash_label'] = 'Hidden Moonkin Stash'
L['magical_bloom_note'] = 'Chase the {npc:210544} until he reveals the treasure.'
L['pineshrew_cache_note'] = 'Next to a few rocks.'
L['reliquary_of_ashamane_note'] = '{note:If the world quest {wq:Dryad Fire Drill} is active you need to complete it before you can see the treasure.}\n\nFind a {object:Mark of Ashamane} {dot:Green} nearby to get the buff {spell:425426} and go to the {npc:212009}.'
L['reliquary_of_aviana_note'] = 'Find a {object:Mark of Aviana} {dot:Green} nearby to get the buff {spell:425432} and go to the {npc:212011}.'
L['reliquary_of_goldrinn_note'] = 'Find a {object:Mark of Goldrinn} {dot:Green} nearby to get the buff {spell:425408} and go to the {npc:212012}.'
L['reliquary_of_ursol_note'] = 'Find a {object:Mark of Ursol} {dot:Green} nearby to get the buff {spell:423306} and go to the {npc:210732}.'
L['triflesnatchs_roving_trove_note'] = 'Follow the {npc:210060} as it flys from branch to branch.'

L['unwaking_echo_label'] = 'Unwaking Echo'
L['unwaking_echo_note'] = '{note:You can only open this chest in your dreams.}\n\nSleep {emote:/sleep} next to the chest to open it.'

L['amirdrassil_defenders_shield_note'] = 'On the table next to {npc:211328}.'
L['dreamtalon_claw_note'] = 'At the bottom of the tree trunk.'
L['essence_of_dreams_note'] = 'Up in a floating, circular tree branch.'
L['exceedingly_soft_wildercloth_note'] = 'Inside the building behind a chair.'
L['experimental_dreamcatcher_note'] = 'In the floating tree.'
L['grove_keepers_pillar_note'] = 'In front of the cave entrance.'
L['handful_of_pebbles_note'] = 'On the statue\'s right shoulder.'
L['molted_faerie_dragon_scales_note'] = 'On the ground in some flowers.'
L['petrified_hope_note'] = 'Up in the tree stump.'
L['plush_pillow_note'] = 'Inside the little hut on a table.'
L['snuggle_buddy_note'] = 'Inside a small boat.'

L['dreamseed_soil_label'] = 'Dreamseed Soil'
L['dreamseed_soil_note'] = [[
The quality of the {object:Emerald Bloom Rewards} and the chances of finding {item:210059} in the {object:Dreamseed Cache} depend on how much {currency:2650} you contribute.

{item:210224} (Contribute {currency:2650} at least once)
{item:210225} (Progress: 50%)
{item:210226} (Progress: 100%)

Quality of the contributed {object:Dreamseed} defines the kind of reward:
{item:208066}: A transmog or crafting materials.
{item:208067}: A pet or crafting materials.
{item:208047}: A mount or crafting materials.

{note:For a list of rewards take a look at {npc:211265} on the island in the north, she also sells most of the rewards.}
]]
L['dreamseed_cache'] = 'Dreamseed Cache'
L['options_icons_dream_of_seeds'] = '{achievement:19013}'
L['options_icons_dream_of_seeds_desc'] = 'Display {object:Dreamseed Soil} locations for {achievement:19013} achievement.'
L['the_seeds_i_sow_suffix'] = 'seeds to the Emerald Bounty contributed'

L['bloom_man_group_suffix'] = 'times the Feral Overflow power used'
L['dream_chaser_suffix'] = 'errant Dreams gathered'
L['dreamfruit_label'] = 'Dreamfruit'
L['dreamfruit_note_1'] = 'Appears when the {location:Superbloom} event begins. The event start on every full hour.'
L['dreamfruit_note_2'] = 'Appears after the first stop of the {location:Superbloom} event. The event start on every full hour near {location:Amirdrassil}.'
L['options_icons_dreamfruit'] = '{achievement:19310}'
L['options_icons_dreamfruit_desc'] = 'Display Dreamfruit locations for {achievement:19310} achievement.'

L['options_icons_moonkin_hatchling'] = '{achievement:19293}'
L['options_icons_moonkin_hatchling_desc'] = 'Display moonkin hatchling locations for {achievement:19293} achievement.'
L['moonkin_hatchling_note'] = 'Requires Worldquest {wq:Claws for Concern} to be active.'

L['druid_glyphs_label'] = 'Druid Glyphs'
L['druid_glyphs_sublabel'] = '{note:This is NOT a Druid Glyph. Just a checklist!}'
L['druid_glyphs_note'] = 'Collect {note:Druid Glyphs} from various activities around the {location:Emerald Dream}.'
L['druid_glyphs_checklist_note'] = 'Track daily kills for rares in the {location:Emerald Dream}. Only {npc:NPCs} with needed loot will appear in the list.\n\nDaily kills will be marked as ' .. '|cFF00FF00Completed|r' .. '.'

L['pollenfused_bristlebruin_fur_sample_note'] = 'Loot the {object:Pollenfused Bristlebruin Fur Sample} found near the bottom of the tree in {location:The Char}.'

L['mbc_note_start'] = 'Loot the {object:Small Box of Vials} to recieve the {item:210991}.\n\nYou will recieve 6x {item:210839} that need to be filled with moonwell water from each continent.'
L['mbc_note_end'] = 'Combine all 6x {item:210876} to create {item:210977} and bring it to the {object:Feral Dreamstone} near {location:Amirdrassil}.\n\nUse the {item:210977} and loot the {object:Moon-Blessed Claw} to receive the {item:210728}.'

L['mbc_vial_b'] = 'B'
L['mbc_vial_d'] = 'D'
L['mbc_vial_e'] = 'E'
L['mbc_vial_k'] = 'K'
L['mbc_vial_n'] = 'N'
L['mbc_vial_o'] = 'O'

L['mbc_vial_b_location'] = 'Thas\'talah Basin'
L['mbc_vial_d_location'] = 'Starfall Outpost'
L['mbc_vial_e_location'] = 'Twilight Grove'
L['mbc_vial_k_location'] = 'Stormrage Barrow Den'
L['mbc_vial_n_location'] = 'Star\'s Rest'
L['mbc_vial_o_location'] = 'Cenarion Refuge'

L['mbc_vial_location'] = 'Fill the {item:%d} with water from the moonwell in {location:%s} in {location:%s} in {location:%s} to recieve {item:%d}.'

L['mbc_moonwell_label'] = 'Moonwell'
L['mbc_feral_dreamstone_label'] = 'Feral Dreamstone'

L['azure_somnowl_note'] = 'Complete the short quest chain which starts with {quest:78065} given by {npc:209318} to receive the {item:210645}.'

L['slumbering_somnowl_note_a'] = 'Collect 5x {item:210565} by putting various {npc:Somnowl} to sleep with {spell:2637} throughout the {location:Emerald Dream}.'
L['slumbering_somnowl_note_b'] = 'Purchase 1x {item:4291} from any trade supplies vendor.'
L['slumbering_somnowl_note_c'] = 'Combine 5x {item:210565} and 1x {item:4291} to create {item:210566}.'
L['slumbering_somnowl_note_d'] = 'Collect 1x {item:194864}.'
L['slumbering_somnowl_note_e'] = 'Combine 1x {item:210566} and 1x {item:194864} to create {item:210535}.'

L['thaelishar_vendor_note'] = 'Exchange gold for Druid glyphs.'
L['silent_mark_label'] = 'Lushdream Crags'
L['silent_mark_note'] = 'Target the correct animal and channel the matching item until {spell:426910} appears. {note:You must attune with 10+ animals.}\n\nChannel {item:210764} onto {npc:210892}.\n\nChannel {item:210767} onto {npc:211347}, {npc:211283}, or {npc:210894}.\n\nChannel {item:210755} onto {npc:210594}.\n\nChannel {item:210766} onto {npc:209494}, {npc:212028}, or {npc:212024}.'

L['amirdrassil'] = 'Amirdrassil, the Dream\'s Hope'
L['prismatic_location'] = 'Inside {location:Amirdrassil, the Dream\'s Hope} raid.'
L['prismatic_note_1'] = '1. Fish up 10x {item:210782} from the pools in the {location:Wellspring Atrium}.'
L['prismatic_note_2'] = '2. Fish up 10x {item:210783} from the lava pools in {location:The Scorched Hall}.'
L['prismatic_note_3'] = '3. Throw all 20x fish into the largest pool in the {location:Wellspring Atrium} to receive the {spell:427145} buff for 30 minutes.'
L['prismatic_note_4'] = '4. Fish from the {object:Prismatic Whiskerfish} fishing pool in the {location:Wellspring Atrium} until you catch {item:210784}.'
L['prismatic_note_5'] = '5. Release {npc:Xena} back into the water in the {location:Wellspring Atrium} to receive {item:210753}.'

L['options_icons_druid_glyph'] = 'Druid Glyphs'
L['options_icons_druid_glyph_desc'] = 'Display locations for {note:Druid Glyphs}.'

L['elianna_vendor_note'] = 'Completing activities around the {location:Emerald Dream} will reward %s (a hidden currency).\n\nEarning 7,000 %s will unlock {quest:78598} from {npc:211209} which rewards 1x {currency:2777}.\n\nExchange {currency:2777} for pets and mounts.'
L['dream_energy_name'] = 'Dream Energy'
L['dream_energy_info'] = '%s: %d/%d (%.1f%%)'

L['sylvia_vendor_note'] = 'Exchange {currency:2651} for pets, mounts, and transmog. You can also get them from Dreemseeds.'

L['somnut'] = 'Somnut'
L['options_icons_somnut'] = 'Somnut'
L['options_icons_somnut_desc'] = 'Display possible locations of {object:Somnuts}.'

L['improvised_leafbed_note'] = 'Complete the quest chain beginning with {quest:77896} to receive the {item:210864} from {npc:210164}.'
L['kalandu_note'] = 'Complete the quest chain beginning with {quest:77948} to receive {item:210633} from {npc:210196}.'

L['ochre_note'] = 'Talk to {npc:209253} to begin the quest line, {npc:209571} will offer the next stages.'
L['ochre_note_stage1'] = '{quest:77677}. {note:5 days to grow.}'
L['ochre_note_stage2'] = '{quest:78398}. {note:5 days to grow.}'
L['ochre_note_stage3'] = '{npc:209571} will let you to collect 5x {item:4537} {dot:Yellow}, 3x {item:209416} {dot:Green}, and 5x {item:208644} {dot:Red}, combine them into {item:208646}. {note:Wait 3 days} for it to become {item:208647}, before finishing {quest:77697}. {note:5 days to grow.}'
L['ochre_note_stage4'] = '{quest:77711}. {note:5 days to grow.}'
L['ochre_note_stage5'] = '{quest:77762}.'

L['thorn_beast_stag'] = '{item:%d} ({npc:Stag})'
L['thorn_beast_saber'] = '{item:%d} ({npc:Saber})'
L['thorn_beast_bear'] = '{item:%d} ({npc:Bear})'

L['thornbeast_disclaimer'] = '{note:Reminder, each beast type has a unique {item:%s} and will lead to a matching thornbeast.}'

L['thorn_laden_heart_note_1'] = 'Loot a {item:209860} from any {npc:stag}, {npc:saber}, or {npc:bear} in the {location:Emerald Dream}.'
L['thorn_laden_heart_note_2'] = 'Once you have a {item:209860}, go and find a doe named {npc:140044} in {location:Drustvar} in {location:Kul Tiras}.'

L['athainne_note_1'] = '{note:{npc:140044} walks with {npc:129771} at night, and rests in {location:Ulfar\'s Den} during the day.}\n\nAsk {npc:140044} to use {item:209860} to create {item:209863}.'
L['athainne_note_2'] = 'Once you have spoken to {npc:140044} and received the {item:209863}, go to {location:Ulfar\'s Den} for {npc:141159} help.'

L['ulfar_note_1'] = 'Ask {npc:149386} to use {item:209863} to create {item:209866}.'
L['ulfar_note_2'] = 'Once you have the {item:209866}, go back to the {location:Emerald Dream} to find a suitable target for the transformation ritual.'

L['thorn_stag_note'] = '1. Kill {npc:210976}, then use {item:209866} on the corpse. The stag will respawn as {npc:210984} {npc:<Thornborn Spirit>}.\n\n2. Cast {spell:1515} on it.\n\n3. Three color are available for {npc:210984}: black, brown, and green.'
L['thorn_saber_note'] = '1. Kill {npc:210975}, then use {item:209867} on the corpse. The saber will respawn as {npc:210981} {npc:<Thornborn Spirit>}.\n\n2. Cast {spell:1515} on it.\n\n3. Three color are available for {npc:210981}: black, green, and pale.'
L['thorn_bear_note'] = '1. Kill {npc:210977}, then use {item:209868} on the corpse. The bear will respawn as {npc:210988} {npc:<Thornborn Spirit>}.\n\n2. Cast {spell:1515} on it.\n\n3. Three color are available for {npc:210988}: brown, dark, and green.'

L['nahqi_note'] = 'It requires the {item:211314} to use {spell:1515} with {npc:210908}, that is obtained from the mount {item:210061}.\n\n{npc:210908}{npc:<Ember of Regrowth>} flies in the sky around {location:Amirdrassil} in a {note:counter clockwise} route, taking 17:30 minutes to complete a lap.\nIt has a minimum respawn timer of 30 minutes.\n\n{note:It is a {npc:Spirit Beast}. Only Beast Mastery Hunters can tame it.}'

L['sulraka_note'] = '{npc:210868}{npc:<Daughter of Kimbul>} patrols the area to the east of {location:Amirdrassil} in a {note:counter clockwise} route, taking 17 minutes to complete a lap.\nIt has a minimum respawn timer of 30 minutes.\n\nIt leaves behind {object:Heavy Tracks} while walking which lasts 3 minutes.\nWalks always in stealth, so you will need to use {spell:1543} in front of a freshly {object:Heavy Tracks} to reveal her.\nCast {spell:257284} and/or {spell:187650} and attempt to {spell:1515}.\n\n{note:It is important to trap it or to reveal her because {npc:210868} will not stop moving, even when attacked. Can get out of range of the {spell:1543} cancelling the skill.}\n\n{note:It is a {npc:Spirit Beast}. Only Beast Mastery Hunters can tame it.}'

L['alarashinu_note'] = '{item:210961}, a hidden fel-tinged nature warglaive.\n\n{note:Special Visual Effects:}\nYou leave behind a trail of flowers when using {spell:195072}/ {spell:189110}/ {spell:198793} with Alara\'shinu equipped or transmogged!'
L['alarashinu_note_stage1'] = 'Speak with {npc:213029} at {location:Central Encampment} in {location:Emerald Dream}.'
L['alarashinu_note_stage2'] = 'Head to {location:The Lost Temple} in {location:Broken Shore}, witness a {npc:213114}.'
L['alarashinu_note_stage3'] = 'Head to {location:Temple of Elune} in {location:Val\'sharah}, witness another {npc:213186}.'
L['alarashinu_note_stage4'] = 'After the memory plays out, a {npc:213248} will appear carrying his Warlgiave.'
L['alarashinu_note_stage5'] = 'Imbue {npc:213308} with your fel flame.'
L['alarashinu_note_stage6'] = 'Loot {npc:213381} and receive {item:210961}.'
L['alarashinu_note_end'] = 'Return to {npc:213029}, and he has a bonus dialog after you get this warglaive.'

-------------------------------------------------------------------------------
----------------------------- SECRETS OF AZEROTH ------------------------------
-------------------------------------------------------------------------------

-- Secrets of Azeroth: Clue 1
L['soa_01_rlabel'] = '(Clue 1)'
L['soa_01_golden_chalice_note'] = 'Place the {item:208056} in the {location:Valdrakken Treasury Hoard} in {location:Valdrakken}.'

-- Secrets of Azeroth: Clue 2
L['soa_02_rlabel'] = '(Clue 2)'
L['soa_02_kathos_note'] = 'Speak to {npc:206864} to receive {item:207105}.\n\nTake the {item:207105} to {npc:186448} in {location:Iskaara} in {location:The Azure Span}.'
L['soa_02_shomko_note_a'] = 'Speak to {npc:186448} to receive {item:207580}.'
L['soa_02_shomko_note_b'] = 'Place {item:207580} at {object:Ceremonial Spear} in {location:Riplash Strand} in the {location:Borean Tundra} in {location:Northrend}.'
L['soa_02_shomko_note_c'] = '{note:Be sure to stick around and kill {npc:208182} to receive {item:207594}.}'

-- Secrets of Azeroth: Clue 3
L['soa_03_rlabel'] = '(Clue 3)'
L['soa_03_fangli_hoot_note_a'] = 'Speak with {npc:207696} to recieve {item:207802}. You\'ll need to build {item:207827} by collecting various pieces:'
L['soa_03_fangli_hoot_note_b'] = 'Trade 5x {item:207956} with {npc:185548} for {item:207814} in {location:Valdrakken}.'
L['soa_03_fangli_hoot_note_c'] = 'Trade 1x {item:207812} with {npc:197781} for {item:207813} in {location:Valdrakken}.'
L['soa_03_fangli_hoot_note_d'] = 'Receive 1x {item:207816} from {npc:198586} after paying his bar tab in {location:Valdrakken}.'
L['soa_03_fangli_hoot_note_e'] = 'Combine the pieces to recieve {item:207827} and begin {quest:77237} for {npc:207697} in {location:Valdrakken}.'
L['soa_03_fangli_clue_label'] = 'Fangli\'s Clue'
L['soa_03_fangli_clue'] = 'Near a waterfall by the {location:Emerald Enclave}.'
L['soa_03_erugosa_note_a'] = 'Speak with {npc:185556} to receive {item:208416}. You\'ll need to collect the following items for her:'
L['soa_03_erugosa_note_b'] = 'Purchase 5x {item:198441} from {npc:194152} in {location:Timberstep Outpost} in {location:Ohn\'ahran Plains}.'
L['soa_03_erugosa_note_c'] = 'Purchase 5x {item:201419} from {npc:196729} in {location:Valdrakken} in {location:Thaldraszus}.'
L['soa_03_erugosa_note_d'] = 'Purchase 5x {item:205693} from {npc:204371} in {location:Loamm} in {location:Zaralek Cavern}.'
L['soa_03_clinkyclick_note_a'] = 'Speak with {npc:185548} to receive {item:207814}. You\'ll need:'
L['soa_03_clinkyclick_note_b'] = 'Receive 10x {item:207956} from {npc:185556} in {location:The Roasted Ram} in {location:Valdrakken}.'
L['soa_03_gryffin_note_a'] = 'Speak with {npc:197781} to receive {item:207813}. You\'ll need to collect:'
L['soa_03_gryffin_note_b'] = 'Loot 1x {item:207812} by killing {npc:191451} in {location:Cascade\'s Edge} in {location:Valdrakken}.'
L['soa_03_shakey_note_a'] = 'Speak with {npc:198586} to receive {item:207816}.'
L['soa_03_shakey_note_b'] = 'Pay {npc:198586}\'s bar tab of %s at {location:The Dragon\'s Hoard} in {location:Valdrakken}.'
L['soa_03_shakey_note_c'] = 'Enter {location:The Dragon\'s Hoard} through the secret entrance by {emote:/bow} at the {object:Odd Statue} at the back of {location:The Roasted Ram}.'

-- Secrets of Azeroth: Clue 4
L['soa_04_rlabel'] = '(Clue 4)'
L['soa_04_locker_label'] = 'Preservationist\'s Locker'
L['soa_04_sazsel_note_a'] = 'Loot the {item:208130} from within the {object:Preservationist\'s Locker} on the top floor of {location:The Roasted Ram} and bring to {npc:208620} in {location:Valdrakken}.'
L['soa_04_sazsel_note_b'] = 'Once appraised return the banner back to the chest and return to {npc:207697}.'

-- Secrets of Azeroth: Clue 5
L['soa_05_rlabel'] = '(Clue 5)'
L['soa_05_torch_of_pyrreth_note_a'] = 'Activate the 3 {object:Ancient Lever} found around {location:Life-Binder Conservatory} in {location:The Waking Shores} to reveal the {item:208135}.'
L['soa_05_torch_of_pyrreth_note_b'] = 'Once collected return to {npc:206864} at {location:The Roasted Ram} in {location:Valdrakken}.'
L['soa_05_torch_of_pyrreth_note_c'] = 'Use your {item:208092} to recieve the {spell:419127} buff. You can now reveal the {npc:209011} which spawns an {object:Enchanted Box}.'
L['soa_05_ancient_lever_label'] = 'Ancient Lever'
L['soa_05_ancient_lever_note_a'] = 'At the back of the ruined building behind {npc:195915}.'
L['soa_05_ancient_lever_note_b'] = 'Inside the ruined tower.'
L['soa_05_ancient_lever_note_c'] = 'Inside the building near {npc:186823} and {npc:186825}.'
L['soa_05_enchanted_box_label'] = 'Enchanted Box'

-- Secrets of Azeroth: Clue 6
L['soa_06_rlabel'] = '(Clue 6)'
L['soa_06_unvieled_tablet_label'] = 'Unveiled Tablet'
L['soa_06_unvieled_tablet_note_a'] = 'Talk to {npc:207696} to complete the quest {quest:77284} and to obtain {item:208137}.\n\nThen travel to {location:Vakthros} in {location:The Azure Span}.'
L['soa_06_unvieled_tablet_note_b'] = 'Use the {item:208092} at the base of the pylon in {location:Vakthros} in {location:The Azure Span} to reveal the {object:Unveiled Tablet}.'
L['soa_06_unvieled_tablet_note_c'] = 'Loot the {item:208143} and return to {npc:207696} in {location:Valdrakken} to complete the secret.'

-- Secrets of Azeroth: Clue 7
L['soa_07_rlabel'] = '(Clue 7)'
L['soa_07_brazier_label'] = 'Ancient Incense Brazier'
L['soa_07_brazier_note_a'] = 'Talk to {npc:185562} to complete the quest {quest:77303} and to obtain {item:208144}.\n\nHead to the {location:Ohn\'ahran Plains} by {location:The Eternal Kurgans}.'
L['soa_07_brazier_note_b'] = 'Use the {item:208135} to ignite the {object:Ancient Incense Brazier} within the ancient burial mound.'
L['soa_07_idol_note'] = 'Loot the revealed {item:207730} next to the {object:Ancient Incense Brazier} and return to {location:Valdrakken}.'

-- Secrets of Azeroth: Clue 8
L['soa_08_rlabel'] = '(Clue 8)'
L['soa_08_kathos_note'] = 'Speak to {npc:206864} to receive {item:206948}.\n\nFly into the {location:Shifting Sands} in {location:Thaldraszus} and use the {item:207730} to find 3x {item:208191}.'
L['soa_08_time_lost_fragment_note'] = 'Use the {item:207730} to find 3x {item:208191} in the {location:Shifting Sands} in {location:Thaldraszus}.\n\nCombine all 3x to create {item:208146} and return to {npc:206864} in {location:Valdrakken}.'
L['soa_08_tl_fragment_location_a'] = 'Under a small tree.'
L['soa_08_tl_fragment_location_b'] = 'Between two large boulders.'
L['soa_08_tl_fragment_location_c'] = 'At the bottom of the small river.'

-- Secrets of Azeroth: Clue 9
L['soa_09_rlabel'] = '(Clue 9)'
L['soa_09_bobby_note'] = 'Speak to {npc:207696} to start the quest {quest:77653}. Turn in the quest at {npc:195769} to receive {item:208486}.\n\nThen travel to {location:Sylvan Glade} in {location:Ohn\'ahran Plains}.'
L['soa_09_hastily_scrawled_stone_label'] = 'Hastily Scrawled Stone'
L['soa_09_hastily_scrawled_stone_note'] = 'Use the {item:208092} to reveal the {object:Hastily Scrawled Stone} then go to the near by {object:Ancient Key Mold}.'
L['soa_09_ancient_key_mold_label'] = 'Ancient Key Mold'
L['soa_09_ancient_key_mold_note'] = 'Loot the {object:Ancient Key Mold} to receive {item:208827} to start the quest {quest:77822}.\n\nReturn to {npc:195769} in {location:Valdrakken}.'

-- Secrets of Azeroth: Clue 10
L['soa_10_rlabel'] = '(Clue 10)'
L['soa_10_tyrs_titan_key_note'] = 'Pick up the quest {quest:77829} from {npc:207696} and go to {npc:210837} to obtain {item:208829}.\n\nCollect {item:208835} and {item:208836} in the {location:Waking Shores} to reforge the key at the {location:Obsidian Citadel}.'
L['soa_10_rose_gold_dust_note'] = 'Collect 50x {item:208835}, use your {item:207730} to find the small red pebbles on the floor.\n\nGo to {npc:210837} at the {location:Obsidian Citadel} after you found 50x {item:208835} and 8x {item:208836}.'
L['soa_10_igneous_flux_note'] = 'Collect 8x {item:208836} at various locations in the {location:Waking Shores} where lava meets salt water.\n\nGo to {npc:210837} at the {location:Obsidian Citadel} after you found 50x {item:208835} and 8x {item:208836}.'
L['soa_10_weaponsmith_koref_note'] = 'Speak to {npc:210837} and start the quest {quest:77831} to help him reforge {item:208831} with the ingredients and your {item:208092}.'

-- Secrets of Azeroth: Clue 11
L['soa_11_rlabel'] = '(Clue 11)'
L['soa_11_rlabel_optional'] = '(Clue 11 - Optional)'
L['soa_11_kathos_note'] = 'Talk to {npc:206864}, you will receiving {item:208852}. Head to {npc:195543} in {location:Ohn\'ahran Plains} to ask him about the Banner.'
L['soa_11_sansok_khan_note'] = 'Ask {npc:195543} how to properly bury {npc:Ishtar Rethon}, the hunter whom the banner belongs to.\n\nYou will receive {item:209061} and be requested to find {npc:191391} in {location:Pinewood Post}.'
L['soa_11_jhara_note'] = 'Talk to {npc:191391}, the innkeeper. She will give you {item:208857}, the clue for this secret.'
L['soa_11_marker_1_label'] = 'First Marker'
L['soa_11_marker_2_label'] = 'Second Marker'
L['soa_11_marker_3_label'] = 'Third Marker'
L['soa_11_marker_4_label'] = 'Fourth Marker'
L['soa_11_marker_4_note'] = 'Inside the burial mound.'
L['soa_11_marker_5_label'] = 'Fifth Marker'
L['soa_11_marker_5_note'] = 'If {wq:Web Victims} quest is active it must be completed before using the {item:208092} to burn away the webs and reveal the clue.'
L['soa_11_burial_banner_note'] = 'Venture deep in the cave and get to the top floor once you encounter a ramp, at the end of the top floor you will find a place to deposit the {item:208852}.'

-- Secrets of Azeroth: Clue 12
L['soa_12_rlabel'] = '(Clue 12)'
L['soa_12_bobby_note'] = 'Talk with {npc:207696} to receive {item:208888}.\n\nGo to {location:Old Karazhan} and clear your way till after {npc:15691}, to make your way into the {location:Guardian\'s Library}. You will need to find a tome there, use your {item:207730} to track it down.'
L['soa_12_ancient_tome_note'] = 'Search for tomes with your {item:207730} until you find {item:208889} and bring it back to {npc:207696} in {location:Valdrakken}.'

-- Secrets of Azeroth: Clue 13
L['soa_13_rlabel'] = '(Clue 13)'
L['soa_13_bobby_note'] = 'Talk to {npc:207696} to start the quest {quest:77928}.'
L['soa_13_great_place_a_label'] = 'Auction House Bill of Sale'
L['soa_13_great_place_a_note'] = 'On a stack of boxes inside the entrance to the {location:Auction House}.'
L['soa_13_great_place_b_label'] = 'Void Storage Receipt'
L['soa_13_great_place_b_note'] = 'On a stack of crates in the Transmogrifier and Void Storage building.'
L['soa_13_great_place_c_label'] = 'Garden Supply Receipt'
L['soa_13_great_place_c_note'] = 'In a small building with two {npc:197035} arguing.'
L['soa_13_great_place_d_label'] = 'Researcher\'s Note'
L['soa_13_great_place_d_note'] = 'Inside a small building near some books.'
L['soa_13_great_place_e_label'] = 'Hastily Scrawled Note'
L['soa_13_great_place_e_note'] = 'Behind the vendor stand in {location:The Artisan\'s Market}.'
L['soa_13_great_place_f_label'] = 'Note to Kritha'
L['soa_13_great_place_f_note'] = 'On a crate inside {location:The Dragon\'s Hoard}.\n\nYou need to {emote:/bow} to the {npc:189827} in {location:The Roasted Ram} to enter the secret bar.'

-- Secrets of Azeroth: Clue 14
L['soa_14_rlabel'] = '(Clue 14)'
L['soa_14_tithris_note'] = 'Speak to {npc:185562}, he will give you {item:208942}. Afterwards go to {location:Stormshroud Peak} in {location:Thaldraszus}.'
L['soa_14_buried_object_label'] = 'Buried Object (%d)'
L['soa_14_tablet_label'] = 'Titan-Inscribed Tablet (%d)'
L['soa_14_tablet_note'] = 'Use the {item:208092} to reveal the {object:Titan-Inscribed Tablet}. Follow the {item:206696} coordinates to the {object:Buried Object} and dig up the {item:209795}.'

-- Secrets of Azeroth: Clue 15
L['soa_15_rlabel'] = '(Clue 15)'
L['soa_15_kathos_note'] = 'Speak with {npc:206864} to complete the quest {quest:77959} to obtain {item:208958}. Then Fly to {location:Tyrhold} and complete a series of tasks.'
L['soa_15_tyrhold_statue_label'] = 'Tyrhold Statue'
L['soa_15_tyrhold_statue_note'] = 'Approach the Tyrhold Statue with the {item:208092} and channel until the orb glows bright red.'
L['soa_15_tyrhold_forge_label'] = 'Tyrhold Forge'
L['soa_15_tyrhold_forge_note'] = 'Approach the forge in the center of {location:Tyrhold} to receive the {spell:423792} buff.'
L['soa_15_broken_urn_note'] = 'Loot the {object:Broken Urn} to receive the {item:%d}.'
L['soa_15_broken_urn_location'] = 'Located on level %d of {location:Tyrhold}.'
L['soa_15_titan_power_relay_label'] = 'Titan Power Relay'
L['soa_15_tpr_note'] = 'Insert the {item:%d} into the {object:Titan Power Relay}.'
L['soa_15_orb_label'] = 'Orb Location'
L['soa_15_orb_location'] = 'Atop {location:Tyrhold}.'
L['soa_15_orb_note'] = [[
Accept the Quest {quest:77977} and inspect the Orb to summon {npc:210674} and {npc:210675}, defeat them to receive the {item:209555}.

Place the {item:209555} in the console to reveal the {item:208980}.
Loot the Cache and return the {item:209555} to {npc:206864} who spawned nearby after you revealed the {item:208980}.
]]

-- Community Rumor Mill
L['buried_satchel_note'] = 'Loot the {item:208142} from the {object:Loose Dirt Mound}.'
L['buried_satchel_sublabel'] = '{note:This is NOT a {item:208142} location.}'

L['bs_epl_location'] = 'Behind the building in {location:Corin\'s Crossing}.'
L['bs_fel_location'] = 'Underwater in the center of {location:Bloodvenom Falls}.'
L['bs_tho_location'] = 'In an underwater cave called {location:Splithoof Hold}.'
L['bs_smv_location'] = 'Inside the hollow tree in {location:Moonwillow Peak}.'
L['bs_net_location'] = 'In {location:Manaforge B\'naar} in {location:Netherstorm} in {location:Outland}.\n\n{note:You will need 3 players to channel {item:208092} on the nearby crystals to spawn the {object:Loose Dirt Mound}.}'
L['bs_vfw_location'] = 'At the top of the golden waterfall within the mouth of the {npc:129151} statue.'
L['bs_tas_location'] = 'Use the {item:208135} to melt the {npc:96438} and reveal the {object:Loose Dirt Mound}.'
L['bs_dbt_location'] = 'Under the large skeleton claw in the {location:%s}.'
L['bs_bar_location'] = 'On top of the mountain.'
L['bs_nag_location'] = 'On a floating island high above {location:Skysong Lake}.'
L['bs_gri_location'] = 'Speak to {npc:%s} to take a log ride from {location:Blue Sky Logging Grounds} to {location:Venture Bay}. Once you start the ride you will recieve the {spell:423942} buff.\n\n{note:You must have the {spell:423942} buff in order to see the satchel.}'
L['bs_hmt_location'] = 'Atop {location:Highmountain Peak} near the {object:Weathered Parchment}.'
L['bs_wpl_location'] = 'Between the cart and the keep in {location:Caer Darrow}.'
L['bs_tli_location'] = 'On the floor, in the center of the arena.'
L['bs_tir_location'] = 'Atop the mountain overlooking {location:Freehold}.'

L['bs_emerald_dragonshrine'] = 'Emerald Dragonshrine'
L['bs_bronze_dragonshrine'] = 'Bronze Dragonshrine'

L['options_icons_secrets_of_azeroth'] = 'Secrets of Azeroth'
L['options_icons_secrets_of_azeroth_desc'] = 'Display clue locations for {location:Secrets of Azeroth}.'

-- Mimiron's Jumpjets Mount
L['soa_mjj_list_note'] = 'Collect all 3 parts  and assemble them at the {object:Empowered Arcane Forge} to recieve {item:210022}:'
L['soa_mjj_part1_note'] = 'Have 3 players channeling the braziers with their {item:208092} to summon the {npc:210398}. He will drop the {item:208984}.'
L['soa_mjj_part2_note'] = [[{note:You will need at least 4 people around you for this part.}

In {location:Irontree Woods}, you will find a giant {npc:210417} and a {object:Mimiron's Booster Part} next to use. You can either use the {object:Mimiron's Booster Part} to mount on the elemental and use its ability {spell:423412} to suck people in, or run close to the elemental (but not close enough to get on its aoe, as it knocks you back) so the person piloting it can suck you in.

Once the elemental sucks 4 people in, it will explode and drop {item:209781}! Anyone in the area can loot it.]]
L['soa_mjj_part3_note'] = '{item:209055} will be waiting for you right in front of the {object:Dark Portal} in the {location:Blasted Lands}! Be careful of {npc:23082} and NPCs in the area, as it does take a 12-second cast to loot the part.'

-------------------------------------------------------------------------------
------------------------------- WARCRAFT RUMBLE -------------------------------
-------------------------------------------------------------------------------

L['rumble_coin_bag'] = 'Rumble Coin Bag'
L['rumble_foil_bag'] = 'Rumble Foil Bag'
L['rumble_both_bags'] = 'Rumble Coin and Foil Bag'
L['warcraft_rumble_machine'] = 'Warcraft Rumble Machine'

L['wr_ohn_both_01'] = 'Inside of a ruined building in {location:Lunedane}.'
L['wr_ohn_foil_02'] = 'By a rock near the waterfall.'
L['wr_sto_coin_01'] = 'Behind the storage crate.'
L['wr_sto_foil_01'] = 'Near a pile of cannonballs.'
L['wr_sto_foil_02'] = 'Near the ramp down to the docks.'
L['wr_tas_both_01'] = 'Behind a tree overlooking {location:Whaler\'s Nook}.'
L['wr_tas_foil_01'] = 'Near a massive broken tree.'
L['wr_tha_both_01'] = 'On a floating island near {location:Tyrhold Reservoir}.'
L['wr_tha_foil_01'] = 'On top of a giant plant vase.'
L['wr_tws_both_01'] = 'At the top of the stone tower overlooking the water.'
L['wr_tws_foil_01'] = 'On the mountain overlooking the lava.'
L['wr_tws_foil_02'] = 'On a small stone tower overlooking the water.'
L['wr_val_coin_01'] = 'On the first floor of {location:The Roasted Ram} near the {object:Cooking Oven}.'
L['wr_val_foil_01'] = 'On the second floor of {location:The Roasted Ram} on the bed.'
L['wr_val_machine'] = 'On the second floor of {location:The Roasted Ram}.'
L['wr_org_coin_01'] = 'On the second floor of {location:The Broken Tusk}.'
L['wr_org_foil_01'] = 'Behind the {location:Auction House}.'
L['wr_dur_foil_01'] = 'Behind some supply crates.'

L['options_icons_warcraft_rumble'] = 'Warcraft Rumble'
L['options_icons_warcraft_rumble_desc'] = 'Display {object:Rumble Coin Bag} and {object:Rumble Foil Bag} locations for the {object:Warcraft Rumble} crossover promotion.'

-------------------------------------------------------------------------------
--------------------------------- AMIRDRASSIL ---------------------------------
-------------------------------------------------------------------------------

L['kaldorei_backpack_label'] = 'Kaldorei Backpack'
L['kaldorei_bag_label'] = 'Kaldorei Bag'
L['kaldorei_bedroll_label'] = 'Kaldorei Bedroll'
L['kaldorei_dagger_label'] = 'Kaldorei Dagger'
L['kaldorei_horn_label'] = 'Kaldorei Horn'
L['kaldorei_moon_bow_label'] = 'Kaldorei Moon Bow'
L['kaldorei_shield_label'] = 'Kaldorei Shield'
L['kaldorei_spear_label'] = 'Kaldorei Spear'
L['kaldorei_spyglass_label'] = 'Kaldorei Spyglass'

L['blue_kaldorei_backpack_note'] = 'On top of a crate in the harbor shop at {location:Belanaar}.'
L['blue_kaldorei_bedroll_note'] = 'Behind the table near the moonwell.'
L['blue_kaldorei_pouch_note'] = 'On a barrel outside the building filled with portals.'
L['kaldorei_bow_carver_note'] = 'On a table at the top of the {location:Twilight Watchtower} near {npc:216731}.'
L['kaldorei_sentinels_spyglass_note'] = 'On top of a crate at the end of the dock in {location:Belanaar}.'
L['night_elven_bow_note'] = 'Leaning against the weapon rack in {location:Arlithrien Lodge}.'
L['night_elven_horn_note'] = 'On a crate at the top of the {location:Dawning Watchtower} near {npc:216752}.'
L['night_elven_shield_note'] = 'Leaning against a crate near {npc:216269} the mining trainer.'
L['night_elven_signal_note'] = 'Hanging on a brazier atop the steps.'
L['night_elven_spear_note'] = 'Leaning against the wall of the {location:Keen-Edge Hall}.'
L['violet_kaldorei_pouch_note'] = 'Near the bottom of the arch behind the moonwell.'

L['moon_priestess_lasara_note'] = 'Exchange {currency:2003} for transmog.'


--wow

-------------------------------------------------------------------------------
--------------------------------- KHAZ ALGAR ----------------------------------
-------------------------------------------------------------------------------

L['options_icons_delve_rewards'] = 'Delve Rewards'
L['options_icons_delve_rewards_desc'] = 'Display {location:Delve} rewards on tooltips.'

L['skyriding_glyph'] = 'Skyriding Glyph'
L['options_icons_skyriding_glyph'] = 'Skyriding Glyphs'
L['options_icons_skyriding_glyph_desc'] = 'Display the location of all skyriding glyphs.'

L['options_icons_profession_treasures'] = 'Profession Treasures'
L['options_icons_profession_treasures_desc'] = 'Display locations of treasures which grant profession knowledge.'

L['options_icons_khaz_algar_lore_hunter'] = '{achievement:40762}'
L['options_icons_khaz_algar_lore_hunter_desc'] = 'Display lore object locations for {achievement:40762} achievement.'

L['options_icons_flight_master'] = '{achievement:40430}'
L['options_icons_flight_master_desc'] = 'Display {npc:Flight Master} locations for {achievement:40430}.'

-------------------------------------------------------------------------------
-------------------------------- ISLE OF DORN ---------------------------------
-------------------------------------------------------------------------------

L['alunira_note'] = 'Collect 10x {item:224025} from mobs on the {location:Isle of Dorn} and combine them into a {item:224026} to remove her {spell:451570}.'
L['violet_hold_prisoner'] = 'Violet Hold Prisoner'

L['elemental_geode_label'] = 'Elemental Geode'
L['magical_treasure_chest_note'] = 'Push {npc:223104} back into the water then collect 5x {npc:223159s} nearby.'
L['mosswool_flower_note'] = 'Click on the {npc:222956} and follow him.'
L['mushroom_cap_note'] = 'Collect a {object:Boskroot Cap} in the nearby forest and bring it back to {npc:222894}.'
L['mysterious_orb_note'] = 'Bring the {object:Elemental Pearl} back to the {npc:222847}.'
L['thaks_treasure_note'] = 'Speak with {npc:223227} and follow him.'
L['trees_treasure_note'] = 'Speak with {npc:222940} to get a {item:224185}. Guide 6x {npc:224548s} ({dot:Green}) around the {location:Isle of Dorn} back to {npc:222940}. When you have guided all the crabs back, go back in the cave to {npc:222940} and speak with her.'
L['trees_treasure_crab_1_note'] = 'Under the tree.'
L['trees_treasure_crab_2_note'] = 'On a branch in the tree.'
L['trees_treasure_crab_3_note'] = 'Under the tree.'
L['trees_treasure_crab_4_note'] = 'Under a root of the tree.'
L['trees_treasure_crab_5_note'] = 'On a ledge.'
L['trees_treasure_crab_6_note'] = 'On a root of the tree.'
L['turtles_thanks_1_note'] = 'Hand in 5x {item:220143} (can be fished from {object:Calm Surfacing Ripple} pools or bought from the auction house). {note:Leave the area and return immediately to hand in the next fish.}'
L['turtles_thanks_2_note'] = 'Hand in 1x {item:222533} (can be fished from {object:Glimmerpool}, {object:Festering Rotpool}, {object:Infused Ichor Spill} pool or bought from the auction house).'
L['turtles_thanks_3_note'] = 'Meet the {npc:223338} in {location:Dornogal} and speak with her to reveal the treasure.'
L['web_wrapped_axe_note'] = 'On the first floor.\n\n{note:Have 1-2 Hours spawn time.}'
L['faithful_dog_note'] = [[
1. Find the {npc:59533} in {location:The Heartland} in {map:376} in {map:424} and complete {quest:30526}.
2. Build the {object:Herb Garden} in your {area:7490} in {map:572}.
3. Find a {item:147420} in the {map:619} {map:627} then talk with {npc:87553} in your {area:7490} {object:Herb Garden}.
The {npc:87553} will now be at the {location:Magical Menagerie} in {map:627}
4. Interact with the {object:Half-Buried Dog Bowl} in {map:2248} then pet the {npc:87553} to receive the pet.
]]

L['cendvin_note'] = 'Farm 900x {item:225557} in {location:Cinderwold} from elite mobs to purchase the {item:223153} mount from {npc:226205}.'

L['options_icons_flat_earthen'] = '{achievement:40606}'
L['options_icons_flat_earthen_desc'] = 'Display location for {achievement:40606} achievement.'

L['tome_of_polymorph_mosswool'] = 'Enter the tunnel and continue to {location:The Kindling Parlor}.\n\nAccept {quest:84438} from {npc:229128} to receive the {item:227710}.'

L['aradan_note_start'] = '{npc:213428} can be found in the dungeon {location:The Rookery} in {location:Dornogal} in the {location:Isle of Dorn}.\n\n{note:{npc:213428} can be tamed while in Follower Dungeon mode.}'
L['aradan_note_step_1'] = '1. Collect {item:220770} from the deep in the water outside of {location:Isle of Dorn.}'
L['aradan_note_step_2'] = '2. ({dot:Blue}) Enter {location:The Rookery} and defeat {npc:209230}.'
L['aradan_note_step_3'] = '3. ({dot:Red}) Jump down the shaft then run up the stairs from where {npc:215967} spawns.'
L['aradan_note_step_4'] = '4. ({dot:Green}) Run to the edge of the cliff and use the {item:220770} while targeting {npc:213428}.'
L['aradan_note_step_5'] = '5. {npc:213428} will recognize the hammer and fly down, allowing you to tame him.'
L['aradan_note_end'] = '{note:{item:220770} is not consumed on use so you can tame all 5 model variations or help a fellow hunter.}'

-------------------------------------------------------------------------------
-------------------------------- RINGING DEEPS --------------------------------
-------------------------------------------------------------------------------

L['forgotten_treasure_note'] = 'Open {object:Buried Treasure}s nearby to get the {item:217960}.'
L['kaja_cola_machine_note'] = 'Purchase drinks in the following order: {item:223741} > {item:223743} > {item:223744} > {item:223742}.'

L['options_icons_i_only_need_one_trip'] = '{achievement:40623}'
L['options_icons_i_only_need_one_trip_desc'] = 'Display location for the {achievement:40623} achievement.'
L['i_only_need_one_trip_note'] = 'Deposit all 10 ore at once in the {wq:Courier Mission: Ore Recovery} world quest.'

L['options_icons_not_so_quick_fix'] = '{achievement:40473}'
L['options_icons_not_so_quick_fix_desc'] = 'Display console locations for {achievement:40473} achievement.'

L['not_so_quick_fix_note'] = 'Repair the busted earthen console.'
L['water_console_location'] = 'Next to the stairs.'
L['abyssal_console_location'] = 'In an alcove.'
L['taelloch_console_location'] = 'On a bridge between the barrels.'
L['lost_console_location'] = 'In an alcove.'

L['options_icons_notable_machines'] = '{achievement:40628}'
L['options_icons_notable_machines_desc'] = 'Display note locations for {achievement:40628} achievement.'

L['notable_machines_note'] = 'Read the note.'
L['fragment_I_location'] = 'On the ground.'
L['fragment_II_location'] = 'On a ledge.'
L['fragment_III_location'] = 'On top of the building.'
L['fragment_IV_location'] = 'High up on the wooden tower (Steady Flying is recommended to get this).'
L['fragment_V_location'] = 'On the archway at the top of the stairs.'
L['fragment_VI_location'] = 'On the ground, next to the street light.'

L['options_icons_rocked_to_sleep'] = '{achievement:40504}'
L['options_icons_rocked_to_sleep_desc'] = 'Display plaque locations for {achievement:40504} achievement.'

L['rocked_to_sleep_note'] = 'Read the plaque of the inert earthen.'
L['attwogaz_location'] = 'On a ledge.'
L['halthaz_location'] = 'On a ledge at the base of the pillar.'
L['krattdaz_location'] = 'On a ledge between two waterfalls.'
L['uisgaz_location'] = 'On a ledge.'
L['venedaz_location'] = 'On a platform next to the pipe.'
L['merunth_location'] = 'On the pipe above the stairs.'
L['varerko_location'] = 'On a ledge.'
L['alfritha_location'] = 'Sitting on the edge of the cliff.'
L['gundrig_location'] = 'Sitting on top of a ledge.'
L['sathilga_location'] = 'On a ledge near an Earthen mining machine building.'

L['trungal_note'] = 'Kill the {npc:220615} that spawn around the entrance and down in the cave to spawn.'
L['disturbed_earthgorger_note'] = 'Use the extra action spell to {spell:437003} the ground 3 times to spawn.'
L['deepflayer_broodmother_note'] = 'Flies around high up.'
L['lurker_note'] = '{note:Requires 5 players to spawn}\n\nActivate the 5 {dot:Red}{object:Inconspicuous Lever} within 10 seconds of each other to spawn.\nYou will see a zone wide message when successfully triggered.'

L['gnawbles_ruby_vendor_note'] = [[Gather {item:212493} from {object:Disturbed Earth} and bring it to {npc:225166}.

Once you've done 10 contributions or contributed a total of 50x {item:212493} you will receive 1x {item:224642}.

Each item costs 1x {item:224642}.]]
L['options_icons_disturbed_earth'] = 'Disturbed Earth'
L['options_icons_disturbed_earth_desc'] = 'Display locations of {object:Disturbed Earth}.'

L['options_icons_gobblin_with_glublurp'] = '{achievement:40614}'
L['options_icons_gobblin_with_glublurp_desc'] = 'Display locations for {achievement:40614} achievement.'
L['gobblin_with_glublurp_note'] = 'Click on a {dot:Red}{object:Glimmering Crystal} to gain {spell:456739}. Catch a {npc:227138} flying in the ' .. '|cFFFF8C00Orange Circle|r' .. ' and bring it to {npc:227132}.\n\n(Steady Flying is recommended to get this).'

L['critter_love_note'] = 'You must use the emote {emote:/love} on critters, not battle pets.'
L['options_icons_critter_love'] = '{achievement:40475}'
L['options_icons_critter_love_desc'] = 'Display critter locations for {achievement:40475} achievement.'

L['for_the_collective_note'] = 'Requires {wq:Courier Mission: Ore Recovery}\n\nContribute up to 20x {npc:224281} at each {npc:228056}.\n\n{note:Contribution progress is realm-wide and resets after 2 hours.}'
L['for_the_collective_suffix'] = 'ore contributed'
L['for_the_collective_location'] = 'On top of the building. Use the nearby {object:Wooden Plank} to build a ramp.'
L['options_icons_for_the_collective'] = '{achievement:40630}'
L['options_icons_for_the_collective_desc'] = 'Display {npc:228056} locations for {achievement:40630}.'

-------------------------------------------------------------------------------
--------------------------------- HALLOWFALL ----------------------------------
-------------------------------------------------------------------------------

L['arathi_loremaster_note'] = 'Speak with {npc:221630} within {location:Mereldar} and answer several questions correctly to receive {item:225659}.\n\nAnswers can be found within books located around {location:Hallowfall}.'
L['caesper_note'] = 'Purchase {item:225238} from ({dot:Blue}) {npc:217645} in {location:Dunelle\'s Kindness}, {location:Hallowfall}.\n\nFeed it to {npc:225948} and follow him to the treasure.'
L['dark_ritual_note'] = 'Interact with the {object:Dark Ritual} and defeat all the {npc:226059}, {npc:226052}, and {npc:226062} to loot the {object:Shadowed Essence}.'
L['illuminated_footlocker_note'] = 'Catch 5x falling {spell:442389} from the {npc:220703} to receive {spell:442529} and reveal the {object:Illuminated Footlocker}.'
L['illusive_kobyss_lure_note'] = 'Combine all 4 items to create {item:225641}:'
L['sunless_lure_location'] = 'Dropped by {npc:215653} on the {location:Sunless Strand}. They are camouflaged and use an {npc:215623} as bait.'
L['sky_captains_sunken_cache_note'] = [[
Speak with four different Sky-Captains on their airships to reveal the treasure.

{npc:222333} ({dot:Green}) flies counterclockwise.
{npc:222311} ({dot:Yellow}) flies counterclockwise.
{npc:222323} ({dot:Red}) flies clockwise.
{npc:222337} ({dot:Orange}) flies counterclockwise.
]]
L['murkfin_lure_location'] = 'Dropped by {npc:213622} on {location:Velhan\'s Claim}. They are camouflaged and use an {npc:215623} as bait.'
L['hungering_shimmerfin_location'] = 'Dropped by {npc:215243} in {location:The Hungering Pool}. They are camouflaged and use an {npc:219210} as bait.'
L['ragefin_necrostaff_location'] = 'Dropped by {npc:213406} at the {location:Veneration Grounds}.'
L['jewel_of_the_cliffs_location'] = 'Extremely high up in the stone wall.'
L['lost_necklace_note'] = 'Loot the {object:Lost Momento} on the edge of the shrine.'
L['priory_satchel_location'] = 'Loot the {object:Windswept Satchel} hanging from the corner of the {location:Priory of the Sacred Flame} cathedral.'
L['smugglers_treasure_note'] = 'Loot the required {item:225335} from the ({dot:Blue}) {npc:226025} below the cliff.'
L['smugglers_treasure_location'] = 'High on the cliff between several rocks.'
L['coral_fused_clam'] = 'Coral-Fused Clam'
L['coral_fused_clam_note'] = 'Loot {item:218354} from the {object:Clammer\'s Kit} to open the Clam.'

L['options_icons_biblo_archivist'] = '{achievement:40622}'
L['options_icons_biblo_archivist_desc'] = 'Display book locations for {achievement:40622} achievement.'

L['biblo_book_01_location'] = 'Inside the building on the table behind {npc:222811}.'
L['biblo_book_02_location'] = 'Inside the building on a table by the door.'
L['biblo_book_03_location'] = 'In the stable with all of the {npc:217606}.'
L['biblo_book_04_location'] = 'On the center of the bridge.'
L['biblo_book_05_location'] = 'On the beach below the airship.'
L['biblo_book_06_location'] = 'Inside the building in a bookshelf on the back wall.'
L['biblo_book_07_location'] = 'Inside the building on the table behind the {npc:206096}.'
L['biblo_book_08_location'] = 'Inside the ruins.'
L['biblo_book_09_location'] = 'Inside the large tent on the table.'
L['biblo_book_10_location'] = 'In the captain\'s quarters aboard {location:The Dawnbreaker}.'
L['biblo_book_11_location'] = 'Inside the building on a table.'

L['options_icons_lost_and_found'] = '{achievement:40618}'
L['options_icons_lost_and_found_desc'] = 'Display memento locations for {achievement:40618} achievement.'

L['lost_and_found_note'] = 'Progress the Memories of the Sky storyline starting with the quest {quest:80673} from ({dot:Red}) {npc:220718}. {note:The quests unlock weekly}.\n\n3 mementos can be completed each week, until complete the quest {quest:82813}.'
L['broken_bracelet_location'] = 'Hand in the item {item:219810} to {npc:215527}.'
L['stuffed_lynx_toy_location'] = 'Hand in the item {item:219809} to {npc:218486}.'
L['tarnished_compass_location'] = 'Hand in the item {item:219524} to {object:Grave Offering Location}.'
L['sturdy_locket_location'] = 'Hand in the item {item:224274} to {npc:220859}.'
L['wooden_figure_location'] = 'Hand in the item {item:224273} to {npc:217609}.'
L['calcified_journal_location'] = 'Hand in the item {item:224272} to {npc:222813}.'
L['ivory_tinderbox_location'] = 'Hand in the item {item:224266} to {npc:226051}.'
L['dented_spear_location'] = 'Hand in the item {item:224267} to {npc:213145}.'
L['filigreed_cleric_location'] = 'Hand in the item {item:224268} to {npc:217813}.'

L['options_icons_missing_lynx'] = '{achievement:40625}'
L['options_icons_missing_lynx_desc'] = 'Display lynx locations for {achievement:40625} achievement.'

L['missing_lynx_note'] = 'Pet the ferocious warcat.'
L['magpie_location'] = 'On the ground next to the banner.'
L['nightclaw_location'] = 'Light the {object:Lesser Keyflame} nearby.'
L['purrlock_location'] = 'Light the {object:Light\'s Blooming Keyflame} nearby.'
L['shadowpouncer_location'] = 'Light the {object:Light\'s Blooming Keyflame} nearby.'
L['miral_murder_mittens_location'] = 'Outside.'
L['fuzzy_location'] = 'On the ground near the {object:Lesser Keyflame}.'
L['furball_location'] = 'Inside the ruined building.'
L['dander_location'] = 'Outside.'
L['gobbo_location'] = 'Inside the building on the bed.'

L['beledars_spawn_note'] = 'This rare spawns at one of several locations at a fixed interval.\n\nNext spawn in:\n{note:%s (%s)}'
L['croakit_note'] = 'Fish up 10x {item:211474} from a nearby {object:Shadowblind Grouper School} (or purchase from the auction house) and throw them to him to make the rare attackable.'
L['deathtide_note'] = 'Collect an {item:220122} {dot:Red} and a {item:220124} {dot:Green}. Combine them to {item:220123} to summon the rare at the {object:Ominous Altar}.'
L['murkshade_note'] = 'Interact with the {npc:218455}.'
L['spreading_the_light_rares_note'] = 'Rare spawns after the lit {object:Keyflame} at the current location is extinguished.'

L['options_icons_mereldar_menace'] = '{achievement:40151}'
L['options_icons_mereldar_menace_desc'] = 'Display target locations for {achievement:40151} achievement.'

L['mereldar_menace_note'] = 'Interact with {object:Throwing Stone} and throw it at the targets.'
L['light_and_flame_location'] = 'Aim towards the {npc:218472} east of the {object:Throwing Stone}.'
L['lamplighter_doorway_location'] = 'Aim at the doorway of the building to the east.'
L['barracks_doorway_location'] = 'Aim at the doorway of the red and gold tent to the west.'

L['options_icons_beacon_of_hope'] = '{achievement:40308}'
L['options_icons_beacon_of_hope_desc'] = 'Display lesser keyflame locations for the {achievement:40308} achievement.'

L['beacon_of_hope_note'] = 'Contribute {item:206350} to light lesser keyflames and complete the following quests.'

L['parasidious_note'] = 'Purchase 1x {item:206670} from {npc:206533} (light up the {object:Lesser Keyflame} to spawn him) then go to the {location:Duskrise Acreage} and pull {npc:206870} until the rare spawns. {note: Only spawns if the {npc:206978} is in this location}.'

L['options_icons_flamegards_hope'] = '{achievement:20594}'
L['options_icons_flamegards_hope_desc'] = 'Display location for the {achievement:20594} achievement.'
L['flamegards_hope_note'] = 'Help out {npc:213319} for 20 Days healing the {npc:220225s}.\n\nYou can also use a {spell:372009} or {item:211878} if your class can\'t heal.'

L['hallowfall_sparkfly_label'] = 'Hallowfall Sparkfly'
L['hallowfall_sparkfly_note'] = 'Use 3x {item:206350} at the {object:Lesser Keyflame} in {location:Stillstone Pond} to summon {npc:215956}.\n\nPurchase {item:218107} for 2x {item:206350} and use it to reveal {npc:222308} nearby until {object:Hallowfall Sparkfly} appears.'

L['nightfarm_growthling_note'] = 'Use 3x {item:206350} at the {object:Lesser Keyflame} in {location:The Whirring Field} to summon {npc:208186}.\n\nPurchase {item:219148} for 2x {item:206350} and use it to reveal {item:221546}.'

L['thunder_lynx_note'] = '1. Use 3x {item:206350} at the {object:Lesser Keyflame} in {location:Torchlight Mine} to summon {npc:212419}.\n\n2. Speak with {npc:212419} and follow all extra dialog prompts to reveal {quest:82007}.\n\n3. Locate each baby lynx: {npc:222373} ({dot:Blue}), {npc:222372} ({dot:Green}), {npc:222375} ({dot:Orange}), and {npc:222374} ({dot:Red}).\n\n{note:Be sure to start {quest:76169} at the same to to receive {item:219198} or use a similar item such as {item:219148}. You\'ll need a light to reveal {npc:222373} within {location:Coldshadow Cave}.}\n\n4. Rescue each lynx kitten and return to {npc:212419}.'

-------------------------------------------------------------------------------
---------------------------------- AZJ-KAHET ----------------------------------
-------------------------------------------------------------------------------

L['options_icons_itsy_bitsy_spider'] = '{achievement:40624}'
L['options_icons_itsy_bitsy_spider_desc'] = 'Display weave-rat locations for {achievement:40624} achievement.'

L['itsy_bitsy_spider_note'] = '{emote:/wave} to the {npc:weave-rat}.'

L['options_icons_bookworm'] = '{achievement:40629}'
L['options_icons_bookworm_desc'] = 'Display book locations for the {achievement:40629} achievement.'

L['nerubian_potion_note'] = 'Purchase a {item:225784} ({note:buff lasts 10 minutes}) from {npc:218192} for 33x {currency:3056}.'
L['bookworm_note'] = '{note:You can also complete the achievement {achievement:40542} with the {item:225784}.}'
L['bookworm_1_location'] = 'At the entrance of the small cave.'

L['options_icons_smelling_history'] = '{achievement:40542}'
L['options_icons_smelling_history_desc'] = 'Display book locations for {achievement:40542} achievement.'

L['smelling_history_note'] = '{note:You can also complete the achievement {achievement:40629} with the {item:225784}.}'
L['smelling_history_1_location'] = 'Inside the building on the counter.'
L['smelling_history_2_location'] = 'The scroll is on a chest.'
L['smelling_history_3_location'] = 'The scroll is on a table.'
L['smelling_history_4_location'] = 'Inside the building on a table.'
L['smelling_history_5_location'] = 'Inside the building on a table.'
L['smelling_history_6_location'] = 'On the bed on the south side of the room.'
L['smelling_history_7_location'] = 'On top of a pile of books.'
L['smelling_history_8_location'] = 'On the table next to the bed on the north side of the room.'
L['smelling_history_9_location'] = 'Behind the desk leaning against it right next to {npc:226024}.'
L['smelling_history_10_location'] = 'On a bench.'
L['smelling_history_11_location'] = 'Book is on a table next to the bed. Entrance is above the fountain.'
L['smelling_history_12_location'] = 'Inside the building on a table.'

L['options_icons_skittershaw_spin'] = '{achievement:40727}'
L['options_icons_skittershaw_spin_desc'] = 'Display Skittershaw route locations for {achievement:40727} achievement.'
L['skittershaw_spin_note'] = 'Ride the {npc:224973} for a full lap around the district.\n\nThe {npc:224973} will stop at the {dot:Red} points along the route.'

L['options_icons_no_harm_from_reading'] = '{achievement:40632}'
L['options_icons_no_harm_from_reading_desc'] = 'Display {npc:227421} locations for {achievement:40632} achievement.'
L['no_harm_from_reading_note'] = [[
Enter the ({dot:Yellow}) Cave, and head to the ({dot:Red}) and climb the wall where the 3 spiders are located and enter the hole behind the spider at the top.

Once you have fallen through interact with the nearby {object:Fleshy Grimoire} to spawn the 4 {npc:227421}.

The {npc:227421} will then disappear and reappear around the map.

Track down each {npc:227421} and interact with them to return them back to the {object:Fleshy Grimoire}.

Once you have found all 4 {npc:227421}, head back to the {object:Fleshy Grimoire} and talk to the {npc:227421}.
]]
L['another_you_4_note'] = 'Patrols along the marked path.'

L['concealed_contraband_note'] = 'Remove the {object:Web Cocoon} from the Treasure to reveal it.'
L['memory_cache_note'] = 'Get {spell:420847} from a nearby ({dot:Red}) {object:Extractor Storage}. After kill the {npc:223908} to get the {item:223870} to open the {object:Memory Cache}.'
L['niffen_stash_note'] = 'Located under the bridge.'
L['trapped_trove_note'] = 'In a building that hangs from the ceiling. Avoid the spiderwebs on the floor.'
L['weaving_supplies_note'] = 'Collect silk scraps from the nearby platform to open the treasure.\n\n{item:223901} ({dot:Purple})\n{item:223903} ({dot:Yellow})\n{item:223902} ({dot:Red})'

L['tkaktath_note'] = 'Starts a quest chain to get the {item:224150} mount.'

L['options_icons_the_unseeming'] = '{achievement:40633}'
L['options_icons_the_unseeming_desc'] = 'Display location for the {achievement:40633} achievement.'
L['the_unseeming_note'] = 'Stand in the pool until you have 100x stacks {spell:420847}.'

L['options_icons_you_cant_hang_with_us'] = '{achievement:40634}'
L['options_icons_you_cant_hang_with_us_desc'] = 'Display locations for the {achievement:40634} achievement.'
L['you_cant_hang_with_us_note'] = 'Find a {npc:211816} with the {spell:434734} buff and attack him, to get the {spell:443190} debuff (1 minute). A {npc:225408} ({note:Do not kill him!}) will interfere and stack the {spell:454666} debuff on you. At 10 stacks, you will be forcibly removed from the City.'

L['kej_pet_vendor_note'] = 'Each pet has a limited stock and costs 2,250x {currency:3056}.\n\n{note:Estimated respawn time is 3-4 hours for each pet item at any vendor.}'

L['options_icons_back_to_the_wall'] = '{achievement:40620}'
L['options_icons_back_to_the_wall_desc'] = 'Display {npc:222119} locations for {achievement:40620}.'
L['arathi_prisoner_suffix'] = 'Arathi prisoners saved'
L['arathi_prisoner_note'] = 'Free webbed-wrapped {npc:222119} during the {wq:Special Assignment: A Pound of Cure}.'

-------------------------------------------------------------------------------
----------------------------------- DELVES ------------------------------------
-------------------------------------------------------------------------------

L['sturdy_chest'] = 'Sturdy Chest'
L['sturdy_chest_suffix'] = 'Sturdy Chest found'

L['ecm_chest_3_location'] = 'On the crane. Jump from the upper level.'
L['fol_chest_1_location'] = 'On the rock under the mushrooms in the bushes.'
L['fol_chest_3_location'] = 'At the bottom of the waterfall.'
L['fol_use_mushrooms'] = 'Jump on the mushrooms along the path.'
L['kvr_chest_2_location'] = 'On top of the wooden scaffold.'
L['nfs_chest_2_location'] = 'On the plant.'
L['nfs_chest_3_location'] = 'Inside the building.'
L['nfs_chest_4_location'] = 'Jump down from the skyship.'
L['ski_chest_3_location'] = 'On a ledge.'
L['tra_chest_2_location'] = 'On top of the coral.'
L['tsw_chest_2_location'] = 'High up on the beam.'
L['tsw_chest_2_note'] = '{note:Only available in the "From the Weaver with Love" story variant.}'
L['tsw_chest_3_location'] = 'High up on a pillar near the dropdown to the treasure room.'
L['tsw_chest_4_location'] = 'High up on a beam. Drop down from the pillar near the other chest.'
L['tuk_chest_1_note'] = 'Behind the Statue.'
L['tuk_chest_2_note'] = '{note:Only available in the "Runaway Evolution" and "Torture Victims" story variants.}'
L['tuk_chest_3_note'] = '{note:Only available in the "Runaway Evolution" and "Weaver Rescue" story variants.}'

-------------------------------------------------------------------------------
----------------------------- SECRETS OF AZEROTH ------------------------------
-------------------------------------------------------------------------------

L['options_icons_secrets_of_azeroth'] = 'Secrets of Azeroth'
L['options_icons_secrets_of_azeroth_desc'] = 'Display clue locations for {location:Secrets of Azeroth}.'

L['alyx_kickoff_note'] = 'Speak with {npc:226683} to enable the new Secrets of Azeroth puzzles.'

L['celebration_crates_label'] = 'Celebration Crates'
L['celebration_crates_note'] = 'Find and return all {object:Celebration Crates} hidden throughout {location:Azeroth}.'

L['1_soggy_celebration_crate_note'] = 'Purchase a {item:225996} from {npc:143029} ({dot:Blue}) at {location:The Dive Bar} and give it to {npc:189119} to reveal the {item:226200}.'
L['2_hazy_celebration_crate_note'] = 'While alive, look for the area with glowing green light. {note:However, you must be dead to reveal the {item:232263}.}'
L['3_dirt_caked_celebration_crate_note'] = '{note:You do NOT need to collect the {item:228321} from the call board near {npc:226683} for this crate.}\n\n1. Enter the {location:Forgotten Crypt} behind {location:Karazhan}.\n\n2. Walk down the stairs, through the {location:Well of the Forgotten}, down the ramp of {location:Pauper\'s Walk}, and into the next level of the {location:Forgotten Crypt}.\n\n3. Turn right and follow the tunnel through {location:Pauper\'s Walk}.\n\n4. Cross the large room diagonally towards {location:The Upside-down Sinners}.\n\n5. Go straight across the water into {location:The Slough of Dispair} to grab the {item:228322}.'
L['4_sandy_celebration_crate'] = '1. Collect the {item:228768} from the {location:Sunken Dig Site} in {location:Thousand Needles} in {location:Kalimdor}.\n\n2. Find {npc:91079} wandering along the eastern road in {location:Azsuna}.\n\n3. Purchase {item:228767} for %s.'
L['5_battered_celebration_crate'] = 'Against the rocks of the cave near the {npc:24026}.'
L['6_waterlogged_celebration_crate'] = 'Underwater on the second floor of the Gnomish building.\n\n{note:Do not touch the elevator. Currently it will crash your game.}'

L['water_resistant_receipt_note'] = '1. Enter the tunnel filled with {npc:47390}, turn right, and collect the {item:228768} from the {object:Water-Resistant Receipt of Sale} behind the pipe.\n\n2. Find {npc:91079} in {location:Azsuna} in the {location:Broken Isles}.'


--Core

-------------------------------------------------------------------------------
------------------------------------ GEAR -------------------------------------
-------------------------------------------------------------------------------

L['bag'] = 'Bag'
L['cloth'] = 'Cloth'
L['leather'] = 'Leather'
L['mail'] = 'Mail'
L['plate'] = 'Plate'
L['cosmetic'] = 'Cosmetic'
L['tabard'] = 'Tabard'

L['1h_mace'] = '1h Mace'
L['1h_sword'] = '1h Sword'
L['1h_axe'] = '1h Axe'
L['2h_mace'] = '2h Mace'
L['2h_axe'] = '2h Axe'
L['2h_sword'] = '2h Sword'
L['shield'] = 'Shield'
L['dagger'] = 'Dagger'
L['staff'] = 'Staff'
L['fist'] = 'Fist'
L['polearm'] = 'Polearm'
L['bow'] = 'Bow'
L['gun'] = 'Gun'
L['wand'] = 'Wand'
L['crossbow'] = 'Crossbow'
L['offhand'] = 'Off Hand'
L['warglaive'] = 'Warglaive'

L['ring'] = 'Ring'
L['neck'] = 'Neck'
L['cloak'] = 'Cloak'
L['trinket'] = 'Trinket'

-------------------------------------------------------------------------------
---------------------------------- TOOLTIPS -----------------------------------
-------------------------------------------------------------------------------

L['activation_unknown'] = 'Activation unknown!'
L['requirement_not_found'] = 'Requirement location unknown!'
L['multiple_spawns'] = 'Can appear in multiple locations.'
L['shared_drops'] = 'Shared Drops'
L['zone_drops_label'] = 'Zone Drops'
L['zone_drops_note'] = 'The items listed below can be dropped by several mobs in this zone.'

L['poi_entrance_label'] = 'Entrance'

L['requires'] = 'Requires'
L['ranked_research'] = '%s (Rank %d/%d)'

L['focus'] = 'Focus'
L['retrieving'] = 'Retrieving item link ...'

L['normal'] = 'Normal'
L['hard'] = 'Hard'

L['completed'] = 'Completed'
L['incomplete'] = 'Incomplete'
L['claimed'] = 'Claimed'
L['unclaimed'] = 'Unclaimed'
L['known'] = 'Known'
L['missing'] = 'Missing'
L['unobtainable'] = 'Unobtainable'
L['unlearnable'] = 'Unlearnable'
L['defeated'] = 'Defeated'
L['undefeated'] = 'Undefeated'
L['elite'] = 'Elite'
L['quest'] = 'Quest'
L['quest_repeatable'] = 'Repeatable Quest'
L['achievement'] = 'Achievement'

---------------------------------- LOCATION -----------------------------------
L['in_cave'] = 'In a cave.'
L['in_small_cave'] = 'In a small cave.'
L['in_water_cave'] = 'In an underwater cave.'
L['in_waterfall_cave'] = 'In a cave behind a waterfall.'
L['in_water'] = 'In the water.'
L['in_building'] = 'In the building.'

------------------------------------ TIME -------------------------------------
L['now'] = 'Now'
L['hourly'] = 'Hourly'
L['daily'] = 'Daily'
L['weekly'] = 'Weekly'

L['time_format_12hrs'] = '%B %d - %I:%M %p local time'
L['time_format_24hrs'] = '%B %d - %H:%M local time'

----------------------------------- REWARDS -----------------------------------
L['heirloom'] = 'Heirloom'
L['item'] = 'Item'
L['mount'] = 'Mount'
L['pet'] = 'Pet'
L['recipe'] = 'Recipe'
L['spell'] = 'Spell'
L['title'] = 'Title'
L['toy'] = 'Toy'
L['currency'] = 'Currency'
L['rep'] = 'Rep'

---------------------------------- FOLLOWERS ----------------------------------
L['follower_type_follower'] = 'Follower'
L['follower_type_champion'] = 'Champion'
L['follower_type_companion'] = 'Companion'

--------------------------------- REPUTATION ----------------------------------
L['rep_honored'] = 'Honored'
L['rep_revered'] = 'Revered'
L['rep_exalted'] = 'Exalted'

-------------------------------------------------------------------------------
--------------------------------- DRAGONRACES ---------------------------------
-------------------------------------------------------------------------------

L['dr_your_best_time'] = 'Your best time:'
L['dr_your_target_time'] = 'Target time:'
L['dr_best_time'] = ' - %s: %.3fs'
L['dr_target_time'] = ' - %s: %ss / %ss'
L['dr_normal'] = 'Normal'
L['dr_advanced'] = 'Advanced'
L['dr_reverse'] = 'Reverse'
L['dr_challenge'] = 'Challenge'
L['dr_reverse_challenge'] = 'Reverse Challenge'
L['dr_storm_race'] = 'Storm Race'
L['dr_bronze'] = 'Finish the race to get ' .. '|cFFCD7F32Bronze|r' .. '.'
L['dr_vendor_note'] = 'Exchange {currency:2588} for drakewatcher manuscripts and transmog.'
L['options_icons_dragonrace'] = 'Dragonriding Races'
L['options_icons_dragonrace_desc'] = 'Display all race locations for the zone.'

-------------------------------------------------------------------------------
--------------------------------- CONTEXT MENU --------------------------------
-------------------------------------------------------------------------------

L['context_menu_set_waypoint'] = 'Set map waypoint'
L['context_menu_add_tomtom'] = 'Add to TomTom'
L['context_menu_add_group_tomtom'] = 'Add group to TomTom'
L['context_menu_add_focus_group_tomtom'] = 'Add related nodes to TomTom'
L['context_menu_hide_node'] = 'Hide this node'
L['context_menu_restore_hidden_nodes'] = 'Restore all hidden nodes'

L['map_button_text'] = 'Adjust icon display, alpha and scaling for this map.'

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

L['options_global'] = 'Global'
L['options_zones'] = 'Zones'

L['options_general_description'] = 'Settings that control the behavior of nodes and their rewards.'
L['options_global_description'] = 'Settings that control the display of all nodes in all zones.'
L['options_zones_description'] = 'Settings that control the display of nodes in each individual zone.'

L['options_open_settings_panel'] = 'Open Settings Panel ...'
L['options_open_world_map'] = 'Open World Map'
L['options_open_world_map_desc'] = 'Open this zone in the world map.'

------------------------------------ ICONS ------------------------------------

L['options_icon_settings'] = 'Icon Settings'
L['options_scale'] = 'Scale'
L['options_scale_desc'] = '1 = 100%'
L['options_opacity'] = 'Opacity'
L['options_opacity_desc'] = '0 = transparent, 1 = opaque'

---------------------------------- VISIBILITY ---------------------------------

L['options_show_worldmap_button'] = 'Show world map button'
L['options_show_worldmap_button_desc'] = 'Add a quick-toggle dropdown menu to the top-right corner of the world map.'

L['options_visibility_settings'] = 'Visibility'
L['options_general_settings'] = 'General'
L['options_show_completed_nodes'] = 'Show completed'
L['options_show_completed_nodes_desc'] = 'Show all nodes even if they have already been looted or completed today.'
L['options_toggle_hide_done_rare'] = 'Hide rare if all rewards known'
L['options_toggle_hide_done_rare_desc'] = 'Hide all rares for which all loot is known.'
L['options_toggle_hide_done_treasure'] = 'Hide treasure if all rewards known'
L['options_toggle_hide_done_treasure_desc'] = 'Hide all treasures for which all loot is known.'
L['options_toggle_hide_minimap'] = 'Hide all icons on the minimap'
L['options_toggle_hide_minimap_desc'] = 'Hides all icons from this addon on the minimap and displays them only on the main map.'
L['options_toggle_maximized_enlarged'] = 'Enlarge icons on maximized world map'
L['options_toggle_maximized_enlarged_desc'] = 'When the world map is maximized, enlarge all icons.'
L['options_toggle_use_char_achieves'] = 'Use character achievements'
L['options_toggle_use_char_achieves_desc'] = 'Display achievement progress for this character instead of the overall account.'
L['options_toggle_per_map_settings'] = 'Use zone-specific settings'
L['options_toggle_per_map_settings_desc'] = 'Apply toggle, scale and opacity settings to each zone individually.'
L['options_restore_hidden_nodes'] = 'Restore hidden nodes'
L['options_restore_hidden_nodes_desc'] = 'Restore all nodes hidden using the right-click context menu.'

L['ignore_class_restrictions'] = 'Ignore class restrictions'
L['ignore_class_restrictions_desc'] = 'Show groups, nodes and rewards that require a different class than the active character.'
L['ignore_faction_restrictions'] = 'Ignore faction restrictions'
L['ignore_faction_restrictions_desc'] = 'Show groups, nodes and rewards that require the opposite faction.'

L['options_rewards_settings'] = 'Rewards'
L['options_reward_behaviors_settings'] = 'Reward Behaviors'
L['options_reward_types'] = 'Show reward types'
L['options_manuscript_rewards'] = 'Show drakewatcher manuscript rewards'
L['options_manuscript_rewards_desc'] = 'Display drakewatcher manuscript rewards in tooltips and track their collected status.'
L['options_mount_rewards'] = 'Show mount rewards'
L['options_mount_rewards_desc'] = 'Display mount rewards in tooltips and track their collected status.'
L['options_pet_rewards'] = 'Show pet rewards'
L['options_pet_rewards_desc'] = 'Display pet rewards in tooltips and track their collected status.'
L['options_recipe_rewards'] = 'Show recipe rewards'
L['options_recipe_rewards_desc'] = 'Display recipe rewards in tooltips and track their collected status.'
L['options_toy_rewards'] = 'Show toy rewards'
L['options_toy_rewards_desc'] = 'Display toy rewards in tooltips and track their collected status.'
L['options_transmog_rewards'] = 'Show transmog rewards'
L['options_transmog_rewards_desc'] = 'Display transmog rewards in tooltips and track their collected status.'
L['options_all_transmog_rewards'] = 'Show unobtainable transmog rewards'
L['options_all_transmog_rewards_desc'] = 'Display transmog rewards obtainable by other classes.'
L['options_rep_rewards'] = 'Show reputation rewards'
L['options_rep_rewards_desc'] = 'Display reputation rewards in tooltips and track their collected status.'
L['options_claimed_rep_rewards'] = 'Show claimed reputation rewards'
L['options_claimed_rep_rewards_desc'] = 'Show reputation rewards which have already been claimed by your warband.'

L['options_icons_misc_desc'] = 'Display locations of other miscellaneous nodes.'
L['options_icons_misc'] = 'Miscellaneous'
L['options_icons_pet_battles_desc'] = 'Display locations of battle pet trainers and NPCs.'
L['options_icons_pet_battles'] = 'Pet Battles'
L['options_icons_rares_desc'] = 'Display locations of rare NPCs.'
L['options_icons_rares'] = 'Rares'
L['options_icons_treasures_desc'] = 'Display locations of hidden treasures.'
L['options_icons_treasures'] = 'Treasures'
L['options_icons_vendors_desc'] = 'Display locations for vendors.'
L['options_icons_vendors'] = 'Vendors'

------------------------------------ FOCUS ------------------------------------

L['options_focus_settings'] = 'Points of Interest'
L['options_poi_color'] = 'POI color'
L['options_poi_color_desc'] = 'Sets the color for points of interest when an icon is in focus.'
L['options_path_color'] = 'Path color'
L['options_path_color_desc'] = 'Sets the color for the paths when an icon is in focus.'
L['options_reset_poi_colors'] = 'Reset colors'
L['options_reset_poi_colors_desc'] = 'Reset the above colors to their defaults.'

----------------------------------- TOOLTIP -----------------------------------

L['options_tooltip_settings'] = 'Tooltip'
L['options_toggle_show_loot'] = 'Show Loot'
L['options_toggle_show_loot_desc'] = 'Add loot information to the tooltip'
L['options_toggle_show_notes'] = 'Show Notes'
L['options_toggle_show_notes_desc'] = 'Add helpful notes to the tooltip where available'
L['options_toggle_use_standard_time'] = 'Use 12-Hour Clock'
L['options_toggle_use_standard_time_desc'] = 'Use 12-hour clock (ex: 8:00 PM) instead of 24-hour clock (ex: 20:00) in tooltips.'
L['options_toggle_show_npc_id'] = 'Show NPC ID'
L['options_toggle_show_npc_id_desc'] = 'Show the NPC\'s ID for use in rare-scanning addons.'

--------------------------------- DEVELOPMENT ---------------------------------

L['options_dev_settings'] = 'Development'
L['options_toggle_show_debug_currency'] = 'Debug Currency IDs'
L['options_toggle_show_debug_currency_desc'] = 'Show debug info for currency changes (reload required)'
L['options_toggle_show_debug_map'] = 'Debug Map IDs'
L['options_toggle_show_debug_map_desc'] = 'Show debug information for maps'
L['options_toggle_show_debug_quest'] = 'Debug Quest IDs'
L['options_toggle_show_debug_quest_desc'] = 'Show debug info for quest changes (reload required)'
L['options_toggle_force_nodes'] = 'Force Nodes'
L['options_toggle_force_nodes_desc'] = 'Force display all nodes'



----------------------------------------------------------------------------------------------------
-----------------------------------------------CONFIG-----------------------------------------------
----------------------------------------------------------------------------------------------------

L["config_plugin_name"] = "TravelGuide"
L["config_plugin_desc"] = "Displays the portal, zeppelin and boat locations on the world map and minimap."

L["config_tab_general"] = "General"
L["config_tab_scale_alpha"] = "Scale / Alpha"
--L["config_scale_alpha_desc"] = "PH"
L["config_icon_scale"] = "Icon Scale"
L["config_icon_scale_desc"] = "The scale of the icons"
L["config_icon_alpha"] = "Icon Alpha"
L["config_icon_alpha_desc"] = "The alpha transparency of the icons"
L["config_what_to_display"] = "What to display?"
L["config_what_to_display_desc"] = "These settings control what type of icons to be displayed."

L["config_portal"] = "Portal"
L["config_portal_desc"] = "Show the portal locations."

L["config_order_hall_portal"] = "Order Hall Portal"
L["config_order_hall_portal_desc"] = "Show the Order Hall portal locations."

L["config_warfront_portal"] = "Warfront Portal"
L["config_warfront_portal_desc"] = "Show the Warfront portal locations."

L["config_petbattle_portal"] = "Petbattle Portal"
L["config_petbattle_portal_desc"] = "Show the Petbattle portal locations."

L["config_ogreWaygate"] = "Ogre Waygate"
L["config_ogreWaygate_desc"] = "Show the Ogre Waygat portal locations."

L["config_show_reflectivePortal"] = "Reflective Portal"
L["config_show_reflectivePortal_desc"] = "Show the Reflective Portal locations."

L["config_boat"] = "Boat"
L["config_boat_desc"] = "Show the boat locations."
L["config_boat_alliance"] = "Alliance Boat"
L["config_boat_alliance_desc"] = "Show the Alliance boat locations."

L["config_zeppelin"] = "Zeppelin"
L["config_zeppelin_desc"] = "Show the Zeppelin locations."
L["config_zeppelin_horde"] = "Horde Zeppelin"
L["config_zeppelin_horde_desc"] = "Show the Horde Zeppelin locations."

L["config_tram"] = "Deerun Tram"
L["config_tram_desc"] = "Show the Deeprun Tram locations in Stormwind and Ironforge."

L["config_molemachine"] = "Mole Machine"
L["config_molemachine_desc"] = "Show destinations for the Mole Machine."

L["config_note"] = "Note"
L["config_note_desc"] = "Show the node's additional notes when it's available."

L["config_remove_unknown"] = "Remove unknown destinations"
L["config_remove_unknown_desc"] = "This will hide destinations with unfulfilled requirements on the world map."

L["config_remove_AreaPois"] = "Remove Blizzard's POIs for destinations"
L["config_remove_AreaPois_desc"] = "This will remove the Points of Interest (POIs) set by Blizzard for destinations on the world map."

L["config_easy_waypoints"] = "Easy Waypoints"
L["config_easy_waypoints_desc"] = "Activates simplified waypoint creation. \nAllows you to set a waypoint by right-clicking and access to more options by CTRL + right-clicking."
L["config_waypoint_dropdown"] = "Choose"
L["config_waypoint_dropdown_desc"] = "Choose how the waypoint should be created."
L["Blizzard"] = true
L["TomTom"] = true
L["Both"] = true

L["config_teleportPlatform"] = "Teleport platforms in Oribos"
L["config_teleportPlatform_desc"] = "Show the teleport plattform locations in Oribos."

L["config_animaGateway"] = "Anima Gateways in Bastion"
L["config_animaGateway_desc"] = "Show the anima gateway locations in Bastion."

L["config_others"] = "Others"
L["config_others_desc"] = "Show all the other POIs."

L["config_restore_nodes"] = "Restore hidden nodes"
L["config_restore_nodes_desc"] = "Restore all nodes that were hidden via the context menu."
L["config_restore_nodes_print"] = "All hidden nodes have been restored"

----------------------------------------------------------------------------------------------------
-------------------------------------------------DEV------------------------------------------------
----------------------------------------------------------------------------------------------------

L["dev_config_tab"] = "DEV"

L["dev_config_force_nodes"] = "Force Nodes"
L["dev_config_force_nodes_desc"] = "Force the display of all nodes regardless of class, faction or covenant."

L["dev_config_show_prints"] = "Show print()"
L["dev_config_show_prints_desc"] = "Show print() messages in the chat window."

----------------------------------------------------------------------------------------------------
-----------------------------------------------HANDLER----------------------------------------------
----------------------------------------------------------------------------------------------------

--==========================================CONTEXT_MENU==========================================--

L["handler_context_menu_addon_name"] = "HandyNotes: TravelGuide"
L["handler_context_menu_add_tomtom"] = "Add to TomTom"
L["handler_context_menu_add_map_pin"] = "Set map waypoint"
L["handler_context_menu_hide_node"] = "Hide this node"

--============================================TOOLTIPS============================================--

L["handler_tooltip_requires"] = "Requires"
L["handler_tooltip_sanctum_feature"] = "a Sanctum Upgrade"
L["handler_tooltip_data"] = "RETRIEVING DATA..."
L["handler_tooltip_quest"] = "Unlocked with quest"
L["handler_tooltip_rep"] = "Requires reputation with"
L["handler_tooltip_toy"] = "Requires the toy"
L["handler_tooltip_requires_level"] = "Requires at least player level"
L["handler_tooltip_TNTIER"] = "Tier %s of the travel network."
L["handler_tooltip_not_available"] = "currently NOT available"
--L["handler_tooltip_available"] = "currently available"
L["handler_tooltip_not_discovered"] = "not yet discovered"

----------------------------------------------------------------------------------------------------
----------------------------------------------DATABASE----------------------------------------------
----------------------------------------------------------------------------------------------------

-------------------------------------------------TWW------------------------------------------------

L["Portal to Dragonblight"] = true
L["Portal to Dustwallow Marsh"] = true
L["Portal to Searing Gorge"] = true
L["Portal to Dornogal"] = true
L["Portal to Azj-Kahet"] = true
L["Elevator to Isle of Dorn"] = true
L["Elevator to Ringing Deeps"] = true
L["Portal to Ardenweald"] = true
L["Portal to Bastion"] = true
L["Portal to Tiragarde Sound"] = true
L["Portal to Twilight Highlands"] = true

--==========================================DRAGONFLIGHT==========================================--

L["Portal to Valdrakken"] = true
L["Boat to Dragon Isle"] = true
L["Zeppelin to Dragon Isle"] = true
L["Teleport to Seat of the Aspects"] = true
L["Portal to Badlands"] = true
L["Portal to Emerald Dream"] = true
L["Portal to Ohn'ahran Plains"] = true
L["Portal to Central Encampment"] = true
L["Portal to The Timeways"] = true
L["Portal to Bel'ameth"] = true
L["Portal to Feathermoon Stronghold"] = true
L["Portal to Mount Hyjal"] = true
L["Boat to Belanaar"] = true
L["Boat to Stormglen"] = true
L["Portal to The Nighthold"] = true
L["Portal to Shal'Aran"] = true
L["Rift to Dalaran"] = true
L["Rift to Telogrus"] = true
L["Portal to Thunder Totem"] = true

--==========================================SHADOWLANDS===========================================--

L["Portal to Oribos"] = true
L["Waystone to Oribos"] = true
L["To Ring of Transference"] = true
L["To Ring of Fates"] = true
L["Into the Maw"] = true
L["To Keeper's Respite"] = true
L["Portal to Torghast"] = true
L["Portal to Zereth Mortis"] = true

--============================================Bastion=============================================--

L["Anima Gateway to Hero's rest"] = true

-------------------------------------------------BfA------------------------------------------------

L["Portal to Zuldazar"] = true
L["Boat to Zuldazar"] = true
L["Return to Zuldazar"] = true
L["Boat to Vol'dun"] = true
L["Boat to Nazmir"] = true
L["Portal to Nazjatar"] = true
L["Submarine to Mechagon"] = true
L["Portal to Silithus"] = true

L["Portal to Boralus"] = true
L["Boat to Boralus"] = true
L["Return to Boralus"] = true
L["Boat to Drustvar"] = true
L["Boat to Stormsong Valley"] = true
L["Boat to Tiragarde Sound"] = true

L["Portal to Arathi Highlands"] = true
L["Portal to Port of Zandalar"] = true
L["Portal to Darkshore"] = true
L["Portal to Port of Boralus"] = true
L["Boat to Echo Isles"] = true

-----------------------------------------------LEGION-----------------------------------------------

L["Portal to Stormheim"] = true
L["Portal to Helheim"] = true
L["Portal to Dalaran"] = true
L["Portal to Azsuna"] = true
L["Portal to Val'sharah"] = true
L["Portal to Emerald Dreamway"] = true
L["Portal to Suramar"] = true
L["Portal to Highmountain"] = true
L["Great Eagle to Trueshot Lodge"] = true
L["Jump to Skyhold"] = true
L["Portal to Duskwood"] = true
L["Portal to Feralas"] = true
L["Portal to Grizzly Hills"] = true
L["Portal to Hinterlands"] = true
L["Portal to Moonglade"] = true
L["Portal to Dreamgrove"] = true
L["Portal to Wyrmrest Temple"] = true
L["Portal to Karazhan"] = true

-------------------------------------------------WoD------------------------------------------------

L["Portal to Warspear"] = true
L["Portal to Stormshield"] = true
L["Portal to Vol'mar"] = true
L["Portal to Lion's watch"] = true
L["Ogre Waygate"] = true
L["Reflective Portal"] = true

-------------------------------------------------MoP------------------------------------------------

L["Portal to Jade Forest"] = true
L["Portal to Pandaria"] = true
L["Portal to Isle of Thunder"] = true
L["Portal to Shado-Pan Garrison"] = true
L["Portal to Peak of Serenity"]= true

-------------------------------------------------CATA-----------------------------------------------

L["Portal to Deepholm"] = true
L["Portal to Temple of Earth"] = true
L["Portal to Therazane's Throne"] = true
L["Portal to Twilight Highlands"] = true
L["Portal to Tol Barad"] = true
L["Portal to Uldum"] = true
L["Portal to Vashj'ir"] = true
L["Portal to Hyjal"] = true
L["Portal to the Firelands"] = true

------------------------------------------------WotLK-----------------------------------------------

L["Portal to the Purple Parlor"] = true
L["Boat to Howling Fjord"] = true
L["Boat to Kamagua"] = true
L["Portal to Howling Fjord"] = true
L["Boat to Borean Tundra"] = true
L["Boat to Unu'pe"] = true
L["Zeppelin to Borean Tundra"] = true
L["Boat to Moa'ki Harbor"] = true
L["Waygate to Sholazar Basin"] = true

-------------------------------------------------BC-------------------------------------------------

L["Portal to Hellfire Peninsula"] = true
L["Portal to Shattrath"] = true
L["Portal to Isle of Quel'Danas"] = true
L["Portal to Exodar"] = true
L["in Exodar"] = true
L["Boat to Exodar"] = true
L["Speak with Zephyr"] = true

-----------------------------------------------VANILLA----------------------------------------------

L["Boat to Menethil Harbor"] = true

L["Portal to Silvermoon"] = true

L["Portal to Undercity"] = true
L["Orb of translocation"] = true
L["in Undercity Magic Quarter"] = true

L["Zeppelin to Stranglethorn Vale"] = true
L["Portal to Stranglethorn Vale"] = true
L["Boat to Booty Bay"] = true

L["Portal to Stormwind"] = true
L["Boat to Stormwind"] = true
L["Deeprun Tram to Stormwind"] = true

L["Portal to Ironforge"] = true
L["Deeprun Tram to Ironforge"] = true

L["Portal to Orgrimmar"] = true
L["Zeppelin to Orgrimmar"] = true

L["Portal to Thunder Bluff"] = true
L["Zeppelin to Thunder Bluff"] = true

L["Portal to Darnassus"] = true

L["Boat to Ratchet"] = true

L["Boat to Theramore Isle"] = true

L["Portal to Caverns of Time"] = true

L["Portal to Dalaran Crater"] = true
L["Portal to the Sepulcher"] = true

L["Waygate to Un'Goro Crater"] = true
L["The Masonary"] = true
L["inside the Blackrock Mountain"] = true


L["config_plugin_name"] = "Oribos"
L["config_plugin_desc"] = "Displays the NPC and POI locations in Oribos on the world map and minimap."

L["config_tab_general"] = "General"
L["config_tab_scale_alpha"] = "Scale / Alpha"
--L["config_scale_alpha_desc"] = "PH"
L["config_icon_scale"] = "Icon Scale"
L["config_icon_scale_desc"] = "The scale of the icons"
L["config_icon_alpha"] = "Icon Alpha"
L["config_icon_alpha_desc"] = "The alpha transparency of the icons"
L["config_what_to_display"] = "What to display?"
L["config_what_to_display_desc"] = "These settings control what type of icons to be displayed."

L["config_auctioneer"] = "Auctioneer"
L["config_auctioneer_desc"] = "Show the auctioneer location."

L["config_banker"] = "Banker"
L["config_banker_desc"] = "Show the banker locations."

L["config_barber"] = "Barber"
L["config_barber_desc"] = "Show the barber location."

L["config_guildvault"] = "Guild Vault"
L["config_guildvault_desc"] = "Show the guild vault location."

L["config_innkeeper"] = "Innkeeper"
L["config_innkeeper_desc"] = "Show the innkeeper location."

L["config_mail"] = "Mailbox"
L["config_mail_desc"] = "Show the mailbox locations."

L["config_portal"] = "Portal"
L["config_portal_desc"] = "Show the portal locations."

L["config_portaltrainer"] = "Portal Trainer"
L["config_portaltrainer_desc"] = "Show the Mage portal trainer location."

L["config_tpplatform"] = "Teleport Platform"
L["config_tpplatform_desc"] = "Show the teleport platform locations."

L["config_travelguide_note"] = "|cFFFF0000*Already active through HandyNotes: TravelGuide.|r"

L["config_reforge"] = "Armor Enhancer"
L["config_reforge_desc"] = "Show the armor enhancer location."

L["config_stablemaster"] = "Stable Master"
L["config_stablemaster_desc"] = "Show the stable master location."

L["config_trainer"] = "Profession Trainer"
L["config_trainer_desc"] = "Show the profession trainer locations."

L["config_transmogrifier"] = "Transmogrifier"
L["config_transmogrifier_desc"] = "Show the transmogrifier location."

L["config_vendor"] = "Vendor"
L["config_vendor_desc"] = "Show the vendor locations."

L["config_void"] = "Void Storage"
L["config_void_desc"] = "Show the void storage location."

L["config_zonegateway"] = "Zone Gateways"
L["config_zonegateway_desc"] = "Show the zone gateway locations."

L["config_others"] = "Others"
L["config_others_desc"] = "Show all the other POIs."

L["config_onlymytrainers"] = "Show only the trainers and vendors for my professions"
L["config_onlymytrainers_desc"] = [[
Only affects the trainer and vendor of main professions.

|cFFFF0000NOTE: Only affects when two main professions are learned.|r
]]

L["config_fmaster_waypoint"] = "Flightmaster Waypoint"
L["config_fmaster_waypoint_desc"] = "Sets automatically a waypoint to the flightmaster if you enter the Ring of Transference."

L["config_easy_waypoints"] = "Easy Waypoints"
L["config_easy_waypoints_desc"] = "Activates simplified waypoint creation. \nAllows you to set a waypoint by right-clicking and access to more options by CTRL + right-clicking."

L["config_waypoint_dropdown"] = "Choose"
L["config_waypoint_dropdown_desc"] = "Choose how the waypoint should be created."
L["Blizzard"] = true
L["TomTom"] = true
L["Both"] = true

L["config_picons"] = "Show profession icons for:"
L["config_picons_vendor_desc"] = "Show profession icons for vendors instead of the vendor icons."
L["config_picons_trainer_desc"] = "Show profession icons for trainers instead of the trainer icons."
L["config_use_old_picons"] = "Show the old profession symbols"
L["config_use_old_picons_desc"] = "Show the old profession icons again instead of the new ones (before Dragonflight)."

L["config_restore_nodes"] = "Restore hidden nodes"
L["config_restore_nodes_desc"] = "Restore all nodes that were hidden via the context menu."
L["config_restore_nodes_print"] = "All hidden nodes have been restored"

----------------------------------------------------------------------------------------------------
-------------------------------------------------DEV------------------------------------------------
----------------------------------------------------------------------------------------------------

L["dev_config_tab"] = "DEV"

L["dev_config_force_nodes"] = "Force Nodes"
L["dev_config_force_nodes_desc"] = "Force the display of all nodes regardless of class, faction or covenant."

L["dev_config_show_prints"] = "Show print()"
L["dev_config_show_prints_desc"] = "Show print() messages in the chat window."

----------------------------------------------------------------------------------------------------
-----------------------------------------------HANDLER----------------------------------------------
----------------------------------------------------------------------------------------------------

--==========================================CONTEXT_MENU==========================================--

L["handler_context_menu_addon_name"] = "HandyNotes: Oribos"
L["handler_context_menu_add_tomtom"] = "Add to TomTom"
L["handler_context_menu_add_map_pin"] = "Set map waypoint"
L["handler_context_menu_hide_node"] = "Hide this node"

--============================================TOOLTIPS============================================--

L["handler_tooltip_requires"] = "Requires"
L["handler_tooltip_data"] = "RETRIEVING DATA..."
L["handler_tooltip_quest"] = "Unlocked with quest"

----------------------------------------------------------------------------------------------------
----------------------------------------------DATABASE----------------------------------------------
----------------------------------------------------------------------------------------------------

L["Portal to Orgrimmar"] = true
L["Portal to Stormwind"] = true
L["To Ring of Transference"] = true
L["To Ring of Fates"] = true
L["Into the Maw"] = true
L["To Keeper's Respite"] = true
L["Portal to Zereth Mortis"] = true
L["Mailbox"] = true