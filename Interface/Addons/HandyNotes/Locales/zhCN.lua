local L = LibStub("AceLocale-3.0"):NewLocale("HandyNotes", "zhCN")
if not L then return end
-- File = HandyNotes
L[ [=[
Alt+Right Click To Add a HandyNote]=] ] = "Alt+右击添加随记"
L["(No Title)"] = "（无标题）"
L["|cFF00FF00Hint: |cffeda55fCtrl+Shift+LeftDrag|cFF00FF00 to move a note"] = "|cFF00FF00提示：|cffeda55fCtrl+Shift+左键拖拽|cFF00FF00可以移动一个随记"
L["Add Handy Note"] = "添加随记"
L["Add this location to TomTom waypoints"] = "在 TomTom 中添加此位置"
L["Configuration for each individual plugin database."] = "为每个插件数据库单独配置"
L["Delete Handy Note"] = "删除随记"
L["Description/Notes:"] = "描述/注释："
L["Edit Handy Note"] = "编辑随记"
L["Enable HandyNotes"] = "启用 HandyNotes"
L["Enable or disable HandyNotes"] = "启用或者禁用 HandyNotes"
L["ERROR_CREATE_NOTE1"] = "HandyNotes 不能创建注释，因为它无法获得您当前所在的位置。这通常是因为您所在的区域没有地图。"
L["HandyNotes"] = "|cff0080ff[地图]|r宝藏稀有"
L["Icon Alpha"] = "图标透明度"
L["Icon Scale"] = "图标缩放"
L["Minimap Icon Alpha"] = "小地图图标透明度"
L["Minimap Icon Scale"] = "小地图图标缩放"
L["Overall settings"] = "全局设置"
L["Overall settings that affect every database"] = "作用于所有数据库的全局设置"
L["Plugin databases"] = "插件数据库"
L["Plugins"] = "插件"
L["Portal"] = "传送门"
L["Show on continent map"] = "在大陆地图上显示"
L["Show the following plugins on the map"] = "在地图上显示下列插件"
L["Syntax:"] = "参数："
L["The alpha transparency of the icons"] = "图标的透明度"
L["The overall alpha transparency of the icons on the Minimap"] = "小地图上图标的全局透明度值"
L["The overall alpha transparency of the icons on the World Map"] = "世界地图上图标的全局透明度值"
L["The overall scale of the icons on the Minimap"] = "小地图上图标的全局缩放值"
L["The overall scale of the icons on the World Map"] = "世界地图上图标的全局缩放值"
L["The scale of the icons"] = "图标的缩放值"
L["These settings control the look and feel of HandyNotes globally. The icon's scale and alpha here are multiplied with the plugin's scale and alpha."] = "这些设置可以全局控制 HandyNotes 的外观及风格。这里的图标的缩放和透明度会乘以插件的缩放及透明度。"
L["These settings control the look and feel of the HandyNotes icons."] = "这些设置控制 HandyNotes 图标的外观及风格。"
L["Title"] = "标题"
L["World Map Icon Alpha"] = "世界地图图标透明度"
L["World Map Icon Scale"] = "世界地图图标缩放"

-------------------------------------------------------------------------------BC
------------------------------ SHADOWMOON VALLEY ------------------------------
-------------------------------------------------------------------------------

L['netherwing_egg'] = '{item:32506}'
L['options_icons_netherwing_eggs'] = '{achievement:898}'
L['options_icons_netherwing_eggs_desc'] = '显示 {achievement:898} 成就中 {item:32506} 的位置。'

L['options_icons_safari'] = '{achievement:6587}'
L['options_icons_safari_desc'] = '显示 {achievement:6587} 成就中战斗宠物的位置。'

L['options_icons_crazyforcats'] = '{achievement:8397}'
L['options_icons_crazyforcats_desc'] = '显示 {achievement:8397} 成就中战斗宠物的位置。'

-------------------------------------------------------------------------------CTM
----------------------------------- COMMON ------------------------------------
-------------------------------------------------------------------------------

L['change_map'] = '更改地图'

L['options_icons_safari'] = '{achievement:6585} / {achievement:6586}'
L['options_icons_safari_desc'] = '显示 {achievement:6585} 和 {achievement:6586} 成就中战斗宠物的位置。'

-------------------------------------------------------------------------------
--------------------------------- MOUNT HYJAL ---------------------------------
-------------------------------------------------------------------------------

L['hyjal_phase0'] = '阶段0 - 进攻之前'
L['hyjal_phase1'] = '阶段1 - 进攻'
L['hyjal_phase2'] = '阶段2 - 玛洛恩庇护所'
L['hyjal_phase3'] = '阶段3 - 熔火前线'
L['hyjal_phase4a'] = '阶段4A - 猛禽德鲁伊区域'
L['hyjal_phase4b'] = '阶段4B - 暗影守望者区域'
L['hyjal_phase5'] = '阶段5 - 复苏之地'

L['hyjal_phase1_note'] = '在 {location:海加尔山} 完成任务直到获得 {quest:29389}，此任务线将开启进攻阶段。'
L['hyjal_phase2_note'] = '要进入阶段2，需要10个 {currency:416} 才能完成 {quest:29198}。\n\n可以通过日常任务赚取 {currency:416}。'
L['hyjal_phase3_note'] = '要进入阶段3，需要15个 {currency:416} 才能完成 {quest:29201}。\n\n可以通过日常任务赚取 {currency:416}。'
L['hyjal_phase4_note'] = [[
阶段4分为2个部分。

要进入阶段4A，需要150个 {currency:416} 给 {quest:29181}。
要进入阶段4B，需要150个 {currency:416} 给 {quest:29214}。

通过日常任务赚取 {currency:416}。
]]
L['hyjal_phase5_note'] = '要进入阶段5，需要完成 {quest:29215} 和 {quest:29182}。' -- review

L['portal_molten_front'] = '熔火前线传送门'
L['portal_mount_hyjal'] = '海加尔山传送门'

L['spider_hill_note'] = [[
到达 {location:寡妇之巢} 的最高点。

要到达顶部，必须在不杀死 {npc:52981} 的情况下激怒他们。他们会施放 {spell:97959} 并把你拉起来。
满级角色推荐方法：

{item:46725}
恶魔猎手：{spell:185245}
德鲁伊：{spell:2908}
猎人：{spell:1513}
法师：{spell:241178}
圣骑士：{spell:62124}
牧师：{spell:528}
潜行者：{spell:36554}
萨满祭司：{spell:52870}
战士：{spell:355}
]]

L['fiery_lords_note'] = '一次只有一个 {title:领主} 出现，杀死它后下一个会立即出现。'
L['have_we_met_note'] = [[
当到达 {location:塞西莉亚的栖地}时，一群精英战士将协助完成日常任务。

使用表情 {emote:/招手}，{emote:/wave} 向所需的 NPC 挥手。
]]

L['ludicrous_speed_note'] = [[
在任务 {daily:29147} 中，获得65层 {spell:100957}。

{npc:52594} 给予15层
{npc:52596} 给予5层
{npc:52595} 给予1层
]]

L['angry_little_squirrel_note'] = '将一个敌人拉到树上，一个 {npc:52195} 会撞到它的头上。'
L['hyjal_bear_cub_note'] = '在任务 {daily:29161} 时，向 {npc:52795} 投掷 {npc:52688}。' -- review
L['child_of_tortolla_note'] = '在任务 {daily:29101} 时，不要将乌龟踢入水中，而是将其踢向 {npc:52219}。' -- review
L['ready_for_raiding_2_note'] = '在 {location:拉格纳罗斯的领域} 击败下列 {title:烈焰副官}，并且不被他们的特殊攻击命中。'
L['flawless_victory_note'] = '单独击杀一个 {npc:52552} 而且没有受到 {spell:97243} 或 {spell:96688} 的任何伤害。'
L['gang_war_note'] = '在 {location:塞西莉亚的栖地} 的 {daily:29128} 任务中赢得决斗。'
L['death_from_above_note'] = [[
当 {daily:29290} 时轰炸 {title:<火焰领主>}。

{note:一次只有3个 {title:火焰领主} 处于激活状态。为了更快地完成成就，请不要交任务，明天再来。}
]]
L['flamewaker_sentinel_note'] = '使用 {item:137663} 降低他的生命值后其施放 {spell:98369}。躲开所有的射击后击杀他。'
L['flamewaker_shaman_note'] = '使用 {item:137663} 让其低血量。等他自杀。'

L['options_icons_spider_hill_desc'] = '显示 {achievement:5872} 成就中的位置。'
L['options_icons_fiery_lords_desc'] = '显示 {achievement:5861} 成就中元素的位置。'
L['options_icons_have_we_met_desc'] = '显示 {achievement:5865} 成就中任务的位置。'
L['options_icons_unbeatable_pterodactyl_desc'] = '显示 {achievement:5860} 成就中任务的位置。'
L['options_icons_ludicrous_speed_desc'] = '显示 {achievement:5862} 成就中的位置。'
L['options_icons_critter_revenge_desc'] = '显示 {achievement:5868} 成就中小动物的位置。'
L['options_icons_r4r_2_desc'] = '显示 {achievement:5873} 成就中的位置。'
L['options_icons_flawless_victory_desc'] = '显示 {achievement:5873} 成就中的位置。'
L['options_icons_gang_war_desc'] = '显示 {achievement:5864} 成就中的位置。'
L['options_icons_death_from_above_desc'] = '显示 {achievement:5874} 成就中的位置。'
L['options_icons_infernal_ambassadors_desc'] = '显示 {achievement:5869} 成就中的位置。'
L['options_icons_fireside_chat_desc'] = '显示 {achievement:5870} 成就中 NPC 的位置。'
L['options_icons_molten_flow_master_desc'] = '显示 {achievement:5871} 成就中的位置。'

-------------------------------------------------------------------------------
---------------------------------- DEEPHOLM -----------------------------------
-------------------------------------------------------------------------------

L['portal_to_therazane'] = '通往塞拉赞恩王座的传送门'
L['portal_to_earth_temple'] = '通往大地神殿的传送门'

L['fungal_frenzy_note'] = [[
同时经受住 {spell:83803}、{spell:83805}、{spell:83747} 和 {spell:83804} 的效果。

{dot:Bronze} {spell:83747}
带白边的红棕色蘑菇。
让你缩小。

{dot:Red} {spell:83803}
大红色蘑菇，水边附近。
用红色的雾气包围你，增加造成的伤害。

{dot:Blue} {spell:83805}
带白边的蓝色蘑菇。
让你跑得更快。

{dot:LightBlue} {spell:83804}
带粉红色圆点的紫色蘑菇。
最后收集这个蘑菇，它只会把你扔到空中，不会得到任何增益。

{note:只有在 {daily:27050} 任务中才能找到蘑菇。
所有蘑菇都显示为 {object:萌芽的赤红蘑菇}。}
]]
L['rock_lover_note'] = '远离 {npc:44258}。'

L['options_icons_broodmother_desc'] = '显示 {achievement:5447} 成就中任务的位置。'
L['options_icons_fungal_frenzy_desc'] = '显示 {achievement:5450} 成就中蘑菇的位置。'
L['options_icons_fungalophobia_desc'] = '显示 {achievement:5445} 成就中任务的位置。'
L['options_icons_glop_family_desc'] = '显示 {achievement:5446} 成就中任务的位置。'
L['options_icons_rock_lover_desc'] = '显示 {achievement:5449} 成就中 {npc:49956} 的位置。'

-------------------------------------------------------------------------------
----------------------------------- VASHJIR -----------------------------------
-------------------------------------------------------------------------------

L['options_icons_whale_shark_desc'] = '显示 {achievement:4975} 成就中 {npc:40728} 的位置。'

-------------------------------------------------------------------------------
----------------------------- TWILIGHT HIGHLANDS ------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
------------------------------------ ULDUM ------------------------------------
-------------------------------------------------------------------------------

--WLK
L['area_spawn'] = '在周围地区出现。'

L['squirrels_note'] = '必须使用表情 {emote:/爱}，{emote:/love} 给非战斗宠物的小动物。'
L['options_icons_squirrels'] = '{achievement:2557}'
L['options_icons_squirrels_desc'] = '显示 {achievement:2557} 成就中小动物的位置。'

L['achievement_friend_or_fowl_desc'] = '在3分钟内击杀15只 {npc:62648}。'
L['note_devouring_maggot'] = '{location:乌特加德墓穴} 下面深处。'
L['dalaran_sewers'] = '{location:达拉然下水道} 内。'
L['in_nexus'] = '{location:魔枢} 的 {location:停滞大厅} 内。'

L['higher_learning_1'] = '在书架右侧的地面上。'
L['higher_learning_2'] = '在小桌子旁边的地面上。'
L['higher_learning_3'] = '在书架上。'
L['higher_learning_4'] = '在书架之间的地面上。'
L['higher_learning_5'] = '在阳台的箱子上。'
L['higher_learning_6'] = '在角落的箱子上。'
L['higher_learning_7'] = '在楼上的书架上。'
L['higher_learning_8'] = '在楼下的书架上。'
L['higher_learning_vargoth'] = '读完所有8本书后，将通过邮件收到 {item:43824}，使用后传送到 {location:大法师瓦格斯的居所}。\n与 {npc:90430} 交谈获得宠物。'

L['coinmaster_note'] = '从达拉然的喷泉钓起所有硬币。'

--MOP

-------------------------------------------------------------------------------
-------------------------------- TIMELESS ISLE --------------------------------
-------------------------------------------------------------------------------

L['cavern_of_lost_spirits'] = '在 {location:孤魂岩洞} 内。'
L['looted_twice'] = '此角色从未击杀此稀有。今天它可以拾取两次。'
L['neverending_spritewood'] = '无宁魂木'
L['neverending_spritewood_note'] = '打破 {object:无宁魂木} 之后，获得 {spell:144052} 负面效果，尽你所能击杀许多 {npc:71824}！'
L['zarhym_note'] = '每天可以和 {npc:71876} 交谈进入 {spell:144145} 并尝试找回他的身体。'

L['archiereus_note'] = '从 {npc:73306} 购买一个 {item:103684} 来召唤此稀有。'
L['chelon_note'] = '点击 {object:显眼的空壳} 来出现稀有。'
L['cranegnasher_note'] = '从南侧风筝一个 {npc:72095} 到顶上鹤的尸体。'
L['dread_ship_note'] = '从 {npc:73279} 拾取 {item:104115} 并在 {object:被诅咒的墓碑} 使用来召唤稀有。'
L['emerald_gander_note'] = '击杀 {location:天神庭院} 周围的 {npc:72762} 直到 {npc:73158} 出现。'
L['evermaw_note'] = '绕着整个岛屿顺时针游泳。'
L['great_turtle_furyshell_note'] = '击杀 {npc:72764} 或 {npc:72763} 直到 {npc:73161} 出现。'
L['imperial_python_note'] = '击杀 {location:天神庭院} 周围的 {npc:72841} 直到 {npc:73163} 出现。'
L['ironfur_steelhorn_note'] = '击杀 {location:天神庭院} 周围的 {npc:72844} 直到 {npc:73160} 出现。'
L['karkanos_note'] = '和 {npc:72151} 交谈来钓出稀有。实在太难了！'
L['monstrous_spineclaw_note'] = '击杀岛屿周围的 {npc:72766} 直到 {npc:73166} 出现。'
L['rattleskew_note'] = '击杀数波 {npc:72033} 直到稀有出现。'
L['spelurk_cave'] = '{npc:71864} 的洞穴内。'
L['spelurk_note'] = [[
打破进入 {npc:71864} 洞穴，找到一个找到散布在岛上的丢失的文物之一，并使用技能在在阻挡入口的岩石上。

· {spell:147278}
· {spell:149333}
· {spell:149345}
· {spell:149350}

如果找不到文物，可以使用 {item:70161}（或坐垫类玩具）在岩石前面。坐下，然后站起来直走进入。
]]
L['zhugon_note'] = '当酿酒事件激活，击杀 {npc:71908} 并打破酒桶直到稀有出现。'

L['blazing_chest'] = '炽燃宝箱'
L['moss_covered_chest'] = '覆苔宝箱'
L['skull_covered_chest'] = '嵌颅宝箱'
L['smoldering_chest'] = '阴燃宝箱'
L['sturdy_chest'] = '坚固宝箱'
L['sturdy_chest_note'] = '攻击 {npc:73531} 被带到这里。'

L['gleaming_treasure_satchel_note'] = '沿着船上的绳索行走，然后跳到挎包悬挂的那根杆子上。'
L['gleaming_treasure_chest_note'] = '跳上柱子到达宝藏。'
L['mist_covered_treasure_chest_note'] = [[
需要先拾取 {object:闪闪发光的宝箱} 和 {object:绳索捆扎的宝箱}。

点击 {object:发光的仙鹤雕像} 飞上到宝藏。
]]
L['ropebound_treasure_chest_note'] = '走绳子到达宝藏。'
L['sunken_treasure_note'] = '杀死沉船上的精英以获取钥匙。'

-------------------------------------------------------------------------------
--------------------------------- ACROSS ZONES --------------------------------
-------------------------------------------------------------------------------

L['zandalari_warbringer_note'] = [[
每日可以多次拾取。

{npc:69842} 坐骑的颜色决定了掉落坐骑的颜色。
]]
L['zandalari_warbringer_killed'] = '赞达拉战争使者已击杀。'

L['squirrels_note'] = '必须使用表情 {emote:/爱}，{emote:/love} 给非战斗宠物的小动物。'
L['options_icons_squirrels'] = '{achievement:6350}'
L['options_icons_squirrels_desc'] = '显示 {achievement:6350} 成就中小动物的位置。'

L['options_icons_lorewalker'] = '{achievement:6548}'
L['options_icons_lorewalker_desc'] = '显示 {achievement:6548} 成就中的位置。'

-------------------------------------------------------------------------------
--------------------------------- Jade Forest ---------------------------------
-------------------------------------------------------------------------------

L['ancient_pick'] = '{item:85777} 位于 {location:绿石采掘场} 下层。'
L['ships_locker'] = '船载储物箱'
L['ships_locker_note'] = '在沉船中。包含约96金币。'
L['chest_of_supplies'] = '一箱补给'
L['chest_of_supplies_note'] = '包含约10金币。'
L['offering_of_rememberance'] = '追忆供品'
L['offering_of_rememberance_note'] = '包含约30金币。'
L['stash_of_gems'] = '秘藏的宝石'
L['stash_of_gems_note'] = '包含约7金币和宝石。'

-------------------------------------------------------------------------------
-------------------------------- Krasarang Wilds ------------------------------
-------------------------------------------------------------------------------

L['equipment_locker'] = '装备箱'

-------------------------------------------------------------------------------
------------------------------- The Veiled Stair ------------------------------
-------------------------------------------------------------------------------

L['forgotten_lockbox'] = '被遗忘的锁箱'
L['forgotten_lockbox_note'] = '二楼的酒馆里。\n包含约10金币。'

-------------------------------------------------------------------------------
-------------------------- Vale of Eternal Blossoms ---------------------------
-------------------------------------------------------------------------------

L['guolai_halls'] = '{location:郭莱古厅} 内。'
L['guolai_cache'] = '找到一个 {item:87779} 并打开 {object:远古郭莱储物箱}。'

-------------------------------------------------------------------------------
------------------------------- Kun Lai Summit --------------------------------
-------------------------------------------------------------------------------

L['lost_adventurers_belongings'] = '失踪探险者的随身物品' -- wowhead.com/object=213774
L['lost_adventurers_belongings_note'] = '包含约97金币。'
L['momos_treasure_chest'] = '墨墨的宝箱' -- wowhead.com/object=214407
L['momos_treasure_chest_note'] = '包含约10金币。'
L['hozen_treasure_cache'] = '猢狲宝箱' -- wowhead.com/object=213769
L['hozen_treasure_cache_note'] = '包含约99金币。'
L['rikktiks_tick_remover'] = '里克提克的小箱子' -- wowhead.com/object=213793
L['stolen_sprite_treasure'] = '失窃的林精宝藏' -- wowhead.com/object=213770
L['stolen_sprite_treasure_note'] = '包含约104金币。'
L['sturdy_yaungol_spear'] = '野牛人武器箱' -- wowhead.com/object=213842
L['sprites_cloth_chest'] = '林精的衣箱' -- wowhead.com/object=213751

-------------------------------------------------------------------------------
------------------------------- Townlong Steppes ------------------------------
-------------------------------------------------------------------------------

L['abandoned_crate_of_goods'] = '一箱被丢弃的货物' -- wowhead.com/object=213961
L['abandoned_crate_of_goods_note'] = '包含约103金币。'

-------------------------------------------------------------------------------
----------------------------- Valley of Four Winds ----------------------------
-------------------------------------------------------------------------------

L['cache_of_pilfered_goods'] = '一箱被偷的货物'
L['virmen_treasure_cache'] = '兔妖宝箱'
L['mysterious_fruit_pile'] = '神秘水果盆'

-------------------------------------------------------------------------------
------------------------------- Isle of Thunder -------------------------------
-------------------------------------------------------------------------------

L['options_icons_kroshik'] = '{achievement:8108}'
L['options_icons_kroshik_desc'] = '显示 {achievement:8108} 成就中的位置。'

L['iot_portal'] = '传送门'
L['ritualstone_needed'] = '需要3个 {item:94221} 来召唤稀有。'
L['kroshik_bow'] = '{emote:/鞠躬}，{emote:/bow}'
L['kroshik_adult'] = '绕湖跑。\n{emote:/鞠躬}，{emote:/bow}'
L['kroshik_baby'] = '在区域内跑。\n{emote:/鞠躬}，{emote:/bow}'

--WOD

-------------------------------------------------------------------------------
-------------------------------- ACROSS ZONES ---------------------------------
-------------------------------------------------------------------------------

L['edge_of_reality'] = '现世边界'
L['edge_of_reality_note'] = '{object:现世边界} 传送门将你带到一个场景，可以拾取 {item:121815}。'
L['treasures_discovered'] = '宝藏已发现'
L['strange_spore_treasure'] = '奇异孢子'
L['burning_blade_cache_treasure'] = '火刃宝箱'
L['multiple_spawn_note'] = '在多个位置出现。'

L['options_icons_pepe'] = '{achievement:10053}'
L['options_icons_pepe_desc'] = '显示 {achievement:10053} 成就中服装的位置。'

L['squirrels_note'] = '必须使用表情 {emote:/爱}，{emote:/love} 给非战斗宠物的小动物。'
L['options_icons_squirrels'] = '{achievement:14728}'
L['options_icons_squirrels_desc'] = '显示 {achievement:14728} 成就中小动物的位置。'

L['options_icons_GarrFollower'] = '要塞追随者'
L['options_icons_GarrFollower_desc'] = '显示要塞追随者的位置。'

-------------------------------------------------------------------------------
------------------------------------ ASHRAN -----------------------------------
-------------------------------------------------------------------------------

L['fen_tao_follower_note'] = '与他交谈招募为追随者。'

-------------------------------------------------------------------------------
------------------------------- FROSTFIRE RIDGE -------------------------------
-------------------------------------------------------------------------------

L['borrok_the_devourer_note'] = '{note:不要杀死！}\n\n相反，杀死附近的食人魔并将它们喂给 {npc:72156}。在10个食人魔之后他会咳出一个可拾取的 {object:吞噬者的结石}。'
L['gibblette_the_cowardly_note'] = '打断 {spell:175415} 否则他会逃离战斗并消失。'

L['arena_masters_war_horn_treasure'] = '竞技场大师的作战号角'
L['burning_pearl_treasure'] = '燃烧的珍珠'
L['crag_leapers_cache_treasure'] = '攀岩者的宝箱'
L['cragmaul_cache_treasure'] = '库拉戈莫的箱子'
L['doorogs_secret_stash_treasure'] = '多罗戈的秘密宝箱'
L['envoys_satchel_treasure'] = '特使的袋子'
L['forgotten_supplies_treasure'] = '被遗忘的补给品'
L['frozen_frostwolf_axe_treasure'] = '冰封的霜狼战斧'
L['frozen_orc_skeleton_treasure'] = '冰封的兽人骷髅'
L['gnawed_bone_treasure'] = '啃过的骨头'
L['goren_leftovers_treasure'] = '鬣蜥人残渣'
L['gorrthoggs_personal_reserve_treasure'] = '戈尔索格的私人金库'
L['grimfrost_treasure_treasure'] = '肃霜宝箱'
L['iron_horde_munitions_treasure'] = '钢铁部落军需品'
L['iron_horde_supplies_treasure'] = '钢铁部落补给品'
L['lady_senas_materials_stash_treasure'] = '塞娜小姐的物资'
L['lady_senas_other_materials_stash_treasure'] = '塞娜小姐的备用物资'
L['lagoon_pool_treasure'] = '环礁池塘'
L['lagoon_pool_treasure_note'] = '在环礁池塘内钓鱼。'
L['lucky_coin_treasure'] = '幸运硬币'
L['obsidian_petroglyph_treasure'] = '黑曜石岩画'
L['ogre_booty_treasure'] = '食人魔战利品'
L['pale_loot_sack_treasure'] = '一袋白鬼战利品'
L['raided_loot_treasure'] = '抢来的战利品'
L['sealed_jug_treasure'] = '密封的罐子'
L['slaves_stash_treasure'] = '奴隶的宝贝'
L['snow_covered_strongbox_treasure'] = '积雪覆盖的保险箱'
L['spectators_chest_treasure'] = '观众的箱子'
L['supply_dump_treasure'] = '遗弃的补给品'
L['survivalists_cache_treasure'] = '生存专家的宝箱'
L['thunderlord_cache_treasure'] = '雷神储备点'
L['time_warped_tower_treasure'] = '时光扭曲之塔'
L['time_warped_tower_note'] = '拾取塔内的食人魔。'
L['wiggling_egg_treasure'] = '震动的蛋'
L['young_orc_traveler_note'] = '组合 {item:107272}'
L['young_orc_traveler_treasure'] = '年轻的兽人旅行者'
L['young_orc_woman_note'] = '组合 {item:107273}'
L['young_orc_woman_treasure'] = '年轻的女兽人'
L['smoldering_true_iron_deposit_treasure'] = '阴燃的真铁矿脉'
L['up_some_crates_note'] = '一些板条箱上。'
L['wiggling_egg_note'] = '在建筑物的顶部巢上。'
L['cragmaul_cache_note'] = '楼梯下。'

L['prisoner_cage_label'] = '囚笼'
L['slaves_freed'] = '解救奴隶'

L['delectable_ogre_delicacies_label'] = '{achievement:9534}'
L['delectable_ogre_delicacies_note'] = [[
{npc:82801}，{npc:82822}，和 {npc:82823} 可能在任意位置出现

{spell:166684} 持续5分钟
{spell:166686} 持续2分钟
{spell:166687} 持续2分钟
]]

L['weaponsmith_na_shra_follower_note'] = '完成 {quest:33838} 后招募她为追随者。'
L['dagg_follower_note'] = '将 {npc:79607} 从他的第一个笼子中救出，然后再次将他从第二个笼子中救出。在要塞外找到他以招募他为追随者。'
L['shadow_hunter_rala_follower_note'] = '完成 {quest:34348} 后招募他为追随者。'
L['gronnstalker_rokash_follower_note'] = '完成 {quest:32981} 后招募他为追随者。'

L['options_icons_writing_in_the_snow'] = '{achievement:9531}'
L['options_icons_writing_in_the_snow_desc'] = '显示 {achievement:9531} 成就中 {object:散落的日志书页} 的位置。'
L['options_icons_breaker_of_chains'] = '{achievement:9533}'
L['options_icons_breaker_of_chains_desc'] = '显示 {achievement:9533} 成就中 {npc:82680} 和 {object:囚笼} 的位置。'
L['options_icons_delectable_ogre_delicacies'] = '{achievement:9534}'
L['options_icons_delectable_ogre_delicacies_desc'] = '显示 {achievement:9534} 成就中美食的位置。'

-------------------------------------------------------------------------------
----------------------------------- GORGROND ----------------------------------
-------------------------------------------------------------------------------

L['poundfist_note'] = '刷新时间非常长，在50到90小时之间。'
L['trophy_of_glory_note'] = '必须完成建造 {location:戈尔隆德} {location:要塞哨站} 让任务物品掉落。'
L['roardan_sky_terror_note'] = '在 {location:丛林之心} 和 {location:蛮兽岗哨} 范围飞行并在途中3个位置停留。'

L['attack_plans_treasure'] = '钢铁部落攻击指令'
L['brokors_sack_treasure'] = '波尔卡的袋子'
L['discarded_pack_treasure'] = '被遗弃的包裹'
L['evermorn_supply_cache_treasure'] = '永晨补给篮'
L['explorer_canister_treasure'] = '探险家罐子'
L['femur_of_improbability_treasure'] = '稀有腿骨'
L['harvestable_precious_crystal_treasure'] = '可收获的珍贵水晶'
L['horned_skull_treasure'] = '长角的颅骨'
L['iron_supply_chest_treasure'] = '钢铁补给箱'
L['laughing_skull_cache_treasure'] = '嘲颅包裹'
L['laughing_skull_note'] = '在树上。'
L['ockbars_pack_treasure'] = '奥卡巴的包裹'
L['odd_skull_treasure'] = '奇怪的颅骨'
L['petrified_rylak_egg_treasure'] = '石化的双头飞龙蛋'
L['pile_of_rubble_treasure'] = '一堆碎石'
L['remains_if_balldir_deeprock_treasure'] = '波迪尔·深岩的遗物'
L['remains_of_balik_orecrusher_treasure'] = '巴里克·碎矿的遗骸'
L['sashas_secret_stash_treasure'] = '萨莎的秘密包裹'
L['snipers_crossbow_trerasure'] = '狙击手的强弩'
L['stashed_emergency_rucksack_treasure'] = '隐秘的急救背包'
L['strange_looking_dagger_treasure'] = '样子古怪的匕首'
L['suntouched_spear_treasure'] = '日灼之矛'
L['vindicators_hammer_treasure'] = '守备官的战锤'
L['warm_goren_egg_note'] = '{item:118705} 7天后孵化为 {item:118716}。'
L['warm_goren_egg_treasure'] = '热乎乎的鬣蜥人蛋'
L['weapons_cache_treasure'] = '武器架'

L['ninja_pepe_note'] = '小屋内椅子上。'
L['ninja_pepe_treasure'] = '忍者佩佩'

L['protectors_of_the_grove_sublabel'] = '{npc:86259}，{npc:86258}，和 {npc:86257} 来自 {npc:丛林守护者}。'

L['prove_your_strength_note'] = '需要 {spell:164012} 要塞技能来激活。访问你的阵营哨站启用 {location:格斗竞技场}。'
L['prove_your_strength_drop_single'] = '%s 掉落。'
L['prove_your_strength_drop_double'] = '%s 或 %s 掉落。'

L['tormmok_follower_note'] = '第一次出现时 ' .. '|cFFFF0000敌对|r' .. '。协助杀死多波小怪，直到你击败 {npc:83871}。当他变为 ' .. '|cFF00FF00友善|r' .. ' 后与他交谈以招募为追随者。'
L['blook_follower_note'] = '与他交谈后战斗击败他，然后再次与他交谈招募为追随者。'

L['options_icons_attack_plans'] = '{achievement:9656}'
L['options_icons_attack_plans_desc'] = '显示 {achievement:9656} 成就中 {object:钢铁部落攻击指令} 的位置。'
L['options_icons_ancient_no_more'] = '{achievement:9678}'
L['options_icons_ancient_no_more_desc'] = '显示 {achievement:9678} 成就中稀有的位置。'
L['options_icons_fight_the_power'] = '{achievement:9655}'
L['options_icons_fight_the_power_desc'] = '显示 {achievement:9655} 成就中稀有的位置。'
L['options_icons_prove_your_strength'] = '{achievement:9402}'
L['options_icons_prove_your_strength_desc'] = '显示 {achievement:9402} 成就中掉落的位置。'

-------------------------------------------------------------------------------
------------------------------------ NAGRAND ----------------------------------
-------------------------------------------------------------------------------

L['fangler_note'] = '使用钓鱼竿。'
L['berserk_t_300_series_mark_ii_note'] = '使用开关。'
L['graveltooth_note'] = '击杀 {npc:84255} 直到 {npc:84263} 出现。'
L['gorepetal_note'] = '洞穴内。\n\n不在迷你地图上显示。点击 {object:原始百合} 后 {npc:83509} 出现。'
L['sean_whitesea_note'] = '打开被 {object:遗弃的箱子} 后 {npc:83542} 出现。'

L['a_pile_of_dirt_treasure'] = '一堆泥土'
L['abandoned_cargo_treasure'] = '被遗弃的货箱'
L['adventurers_mace_treasure'] = '冒险者的钉锤'
L['adventurers_pack_treasure'] = '冒险者的包裹'
L['adventurers_pouch_treasure'] = '冒险者的钱袋'
L['adventurers_sack_treasure'] = '冒险者的袋子'
L['adventurers_staff_treasure'] = '冒险者的法杖'
L['appropriated_warsong_supplies_treasure'] = '偷来的战歌补给品'
L['bag_of_herbs_treasure'] = '一袋草药'
L['bone_carved_dagger_treasure'] = '骨质匕首'
L['bounty_of_the_elements_note'] = '按以下顺序点击图腾：\n 1. {npc:84307}\n 2. {npc:84343}\n 3. {npc:84345}\n 4. {npc:84347}'
L['bounty_of_the_elements_treasure'] = '元素的宝藏'
L['brilliant_dreampetal_treasure'] = '闪亮的梦境花瓣'
L['elemental_offering_treasure'] = '元素祭品'
L['elemental_shackles_treasure'] = '元素镣铐'
L['fragment_of_oshugun_treasure'] = '沃舒古碎片'
L['freshwater_clam_treasure'] = '淡水蛤蜊'
L['fungus_covered_chest_treasure'] = '长满真菌的宝箱'
L['gamblers_purse_treasure'] = '赌徒的钱袋'
L['genedar_debris_treasure'] = '吉尼达尔残骸'
L['goblin_pack_treasure'] = '地精包裹'
L['golden_kaliri_egg_treasure'] = '金色卡利鸟蛋'
L['goldtoes_plunder_note'] = '鹦鹉有钥匙。'
L['goldtoes_plunder_treasure'] = '金趾的战利品'
L['grizzlemaws_bonepile_treasure'] = '灰喉的骨头堆'
L['hidden_stash_treasure'] = '藏匿物'
L['highmaul_sledge_treasure'] = '悬槌大锤'
L['important_exploration_supplies_treasure'] = '重要的探索补给'
L['lost_pendant_treasure'] = '遗失的吊坠'
L['mountain_climbers_pack_treasure'] = '登山者的包裹'
L['ogre_beads_treasure'] = '食人魔念珠'
L['pale_elixir_treasure'] = '白鬼药剂'
L['pokkars_thirteenth_axe_treasure'] = '波卡尔的第十三把斧子'
L['polished_saberon_skull_treasure'] = '抛光的刃牙虎人颅骨'
L['saberon_stash_treasure'] = '刃牙虎人储物箱'
L['smugglers_cache_note'] = '躲避绊线。'
L['smugglers_cache_treasure'] = '走私者的箱子'
L['steamwheedle_supplies_treasure'] = '热砂补给品'
L['telaar_defender_shield_treasure'] = '塔拉防御护盾'
L['treasure_of_kullkrosh_treasure'] = '库尔克罗什的宝藏'
L['void_infused_crystal_treasure'] = '注灵水晶'
L['warsong_cache_treasure'] = '战歌宝箱'
L['warsong_helm_treasure'] = '战歌头盔'
L['warsong_lockbox_treasure'] = '战歌保险箱'
L['warsong_spear_treasure'] = '战歌长矛'
L['warsong_spoils_treasure'] = '战歌战利品'
L['warsong_supplies_treasure'] = '战歌补给品'
L['watertight_bag_treasure'] = '防水袋'
L['spirit_coffer_treasure'] = '幽灵宝箱'
L['spirits_gift_treasure'] = '幽灵的礼物'
L['spirits_gift_treasure_note'] = '点燃所有6个被遗忘的火盆后宝藏出现。'

L['viking_pepe_note'] = '地精和迪斯科球身后的板条箱上。'
L['viking_pepe_treasure'] = '维京佩佩'

L['highmaul_farm_path'] = [[
刷怪路径
1. 从前门开始，向右进入 {location:下水道}。
2. 左转穿过角斗场区域。请务必在左上方标记俯瞰的食人魔。
3. 继续上楼梯，经过 {npc:87227} 的池塘。
4. 左转并向上进入 {location:凯旋之路}。
5. 走到岔路口。请务必将食人魔标记到右侧。
6. 左转进入 {location:市场区} 并逆时针方向清除所有。
7. 向左进入 {location:元首之赐}，继续沿着路径清除所有。
8. 再次向左，沿着小路，回到 {location:凯旋之路}。
9. 上坐骑飞过去，进入 {location:角斗场}。不要试图使用前门，它是锁着的。

向右飞出并返回前门。一波只需不到4分钟，当你回到前门时，一切都已经刷新了。
]]

L['steamwheedle_note'] = '从 {location:悬槌堡} 周围的 {npc:87223} 和 {npc:87222} 刷 {item:118099} 和 {item:118100}。交付物品给 {npc:87393} 获得声望。'

L['finding_your_waystones_label'] = '{achievement:9497}'
L['finding_your_waystones_note'] = '从 {location:悬槌堡} 周围的 {npc:87223} 和 {npc:87222} 刷 {item:117491}。'
L['ogre_waystones'] = '拾取食人魔道标石'

L['signal_horn_note'] = '从附近的 {npc:86658} 获得 {item:120290} 然后使用 {npc:87361} 来召唤 {npc:87239} 和 {npc:87344}。'

L['garroshs_shackles'] = '小屋内'
L['warsong_relics'] = '靠在小屋外的栅栏上'
L['stolen_draenei_tome'] = '可以在塔顶的多个位置出现'
L['dirt_mound'] = '在附近击杀 {npc:86659} 来出现 {npc:87280}。点击图腾获得 {spell:174572}。现在可以挖掘附近的 {npc:87530} 来寻找物品。'

L['stable_master_note'] = '和 {npc:兽栏管理员} 交谈获得一个训练中的坐骑哨。\n\n{item:119441}\n{item:119442}\n{item:119443}\n{item:119444}\n{item:119445}\n{item:119446}\n\n使用哨子召唤你的坐骑并杀死目标。\n\n{achievement:9539} 需要 {item:118469} 来自 {location:二级兽栏}。\n{achievement:9540} 需要 {item:118470} 来自 {location:三级兽栏}。'

L['making_the_cut_note'] = '当 {npc:88210} 可用时，在 {location:鲜血竞技场} 附近杀死15个 {npc:88207}。一旦15个被杀死 {npc:88210} 将可成为目标。\n\n{yell:对一群废物来说还算不错！等你们准备好送死，就来面对克鲁德吧！}'

L['goldmane_follower_note'] = '击杀附近的 {npc:80080} 以拾取 {item:111863} 并解锁笼子招募 {npc:80083} 作为追随者。'
L['abugar_follower_note'] = [[
交付在 {location:纳格兰} 周围找到的3件钓鱼物品，然后与他交谈招募为追随者。

{item:114245}
{item:114242}
{item:114243}

可以在去找他之前收集物品。
]]

L['options_icons_broke_back_precipice'] = '{achievement:9571}'
L['options_icons_broke_back_precipice_desc'] = '显示 {achievement:9571} 成就中稀有的位置。'
L['options_icons_steamwheedle'] = '{achievement:9472}'
L['options_icons_steamwheedle_desc'] = '显示 {achievement:9472} 成就中刷怪的位置。'
L['options_icons_finding_your_waystones'] = '{achievement:9497}'
L['options_icons_finding_your_waystones_desc'] = '显示 {achievement:9497} 成就中刷怪的位置。'
L['options_icons_song_of_silence'] = '{achievement:9541}'
L['options_icons_song_of_silence_desc'] = '显示 {achievement:9541} 成就中稀有的位置。'
L['options_icons_buried_treasures'] = '{achievement:9548}'
L['options_icons_buried_treasures_desc'] = '显示 {achievement:9548} 成就中物品的位置。'
L['options_icons_the_stable_master'] = '{achievement:9539} 和 {achievement:9540}'
L['options_icons_the_stable_master_desc'] = '显示 {achievement:9539} 和 {achievement:9540} 成就中目标的位置。'
L['options_icons_making_the_cut'] = '{achievement:9617}'
L['options_icons_making_the_cut_desc'] = '显示 {achievement:9617} 成就中 {npc:88207} 的位置。'

-------------------------------------------------------------------------------
------------------------------ SHADOWMOON VALLEY ------------------------------
-------------------------------------------------------------------------------

L['voidseer_kalurg_note'] = '击杀全部 {npc:78135}。'

L['alchemists_satchel_treasure'] = '炼金师的包裹'
L['ancestral_greataxe_treasure'] = '先祖巨斧'
L['armored_elekk_tusk_treasure'] = '装甲雷象獠牙'
L['astrologers_box_treasure'] = '占星家的盒子'
L['beloveds_offering_treasure'] = '爱人的祭品'
L['bubbling_cauldron_treasure'] = '冒泡的大锅'
L['cargo_of_the_raven_queen_treasure'] = '渡鸦女皇的货物'
L['carved_drinking_horn_treasure'] = '雕饰饮水角'
L['demonic_cache_treasure'] = '恶魔宝箱'
L['dusty_lockbox_treasure'] = '尘封的宝箱'
L['false_bottomed_jar_treasure'] = '带夹层的罐子'
L['fantastic_fish_treasure'] = '神奇鱼'
L['giant_moonwillow_cone_treasure'] = '巨型月柳球果'
L['glowing_cave_mushroom_treasure'] = '发光的洞穴蘑菇'
L['grekas_urn_treasure'] = '格瑞卡的坛子'
L['hanging_satchel_treasure'] = '挂起的背包'
L['iron_horde_cargo_shipment_treasure'] = '钢铁部落货箱'
L['iron_horde_tribute_treasure'] = '钢铁部落贡品'
L['kaliri_egg_treasure'] = '卡利鸟蛋'
L['lunarfall_egg_note'] = '建好后移动到你的要塞。'
L['lunarfall_egg_treasure'] = '坠月鸟蛋'
L['mikkals_chest_treasure'] = '米卡尔的箱子'
L['mushroom_covered_chest_treasure'] = '长满蘑菇的宝箱'
L['orc_skeleton_treasure'] = '兽人骷髅'
L['peaceful_offering_treasure'] = '和平祭礼'
L['ronokks_belongings_treasure'] = '罗诺克的物品'
L['rotting_basket_treasure'] = '腐朽的篮子'
L['rovos_dagger_treasure'] = '罗沃的匕首'
L['scaly_rylak_egg_treasure'] = '带鳞片的双头飞龙蛋'
L['shadowmoon_exile_treasure_note'] = '{location:流亡者高地} 下面洞穴内。'
L['shadowmoon_exile_treasure_treasure'] = '影月流亡者宝箱'
L['shadowmoon_sacrificial_dagger_treasure'] = '影月祭祀匕首'
L['shadowmoon_treasure_treasure'] = '影月宝藏'
L['stolen_treasure_treasure'] = '失窃的宝藏'
L['sunken_fishing_boat_treasure'] = '沉没的渔船'
L['swamplighter_hive_treasure'] = '沼泽荧光虫蜂巢'
L['uzkos_knickknacks_treasure'] = '乌兹克的小玩意儿'
L['veemas_herb_bag_treasure'] = '威玛的草药包'
L['vindicators_cache_treasure'] = '守备官宝箱'
L['waterlogged_chest_treasure'] = '进水的宝箱'

L['you_have_been_rylakinated_note'] = '必须完成 {quest:34355}。\n\n从附近的 {npc:78999} 收集 {item:116978} 并控制 {npc:86085}。'

L['artificer_romuul_follower_note'] = '完成水晶防御事件招募他为随从。'

L['options_icons_you_have_been_rylakinated'] = '{achievement:9481}'
L['options_icons_you_have_been_rylakinated_desc'] = '显示 {achievement:9481} 成就中 {npc:85357} 的位置。'

-------------------------------------------------------------------------------
------------------------------- SPIRES OF ARAK --------------------------------
-------------------------------------------------------------------------------

L['abandoned_mining_pick_treasure'] = '被遗弃的采矿锄'
L['admiral_taylors_coffer_note'] = '使用 {item:116020} 解锁 {location:海军上将泰勒的要塞议政厅} 的 {object:海军上将泰勒的保险箱}。'
L['admiral_taylors_coffer_treasure'] = '海军上将泰勒的保险箱'
L['assassins_spear_treasure'] = '刺客的长矛'
L['campaign_contributions_treasure'] = '战争捐赠物资'
L['coinbenders_payment_treasure'] = '折币的报酬'
L['coinbenders_payment_treasure_note'] = '在海底。'
L['egg_of_varasha_treasure'] = '瓦拉沙的蛋'
L['ephials_dark_grimoire_treasure'] = '厄菲阿尔的黑暗魔典'
L['fractured_sunstone_note'] = '隐藏在水下。'
L['fractured_sunstone_treasure'] = '龟裂的太阳石'
L['garrison_supplies_treasure'] = '要塞补给品'
L['garrison_workmans_hammer_treasure'] = '要塞工匠的锤子'
L['iron_horde_explosives_treasure'] = '钢铁部落炸药'
L['lost_herb_satchel_treasure'] = '失落的草药袋'
L['lost_ring_treasure'] = '失落的戒指'
L['mysterious_mushrooms_treasure'] = '神秘菌菇'
L['ogron_plunder_treasure'] = '独眼魔战利品'
L['orcish_signaling_horn_treasure'] = '兽人信号号角'
L['outcasts_belongings_treasure'] = '流亡者财物'
L['outcasts_pouch_treasure'] = '流亡者袋子'
L['rooby_roos_ruby_collar_note'] = '在 {location:咸水藤壶} 的地窖从 {npc:82432} 购买3个 {item:114835}。跟随并喂食 {npc:84332} 直到他在地板上留下一个“宝藏”。'
L['rooby_roos_ruby_rollar_treasure'] = '鲁比的洛洛'
L['rukhmars_image_treasure'] = '鲁克玛的影像'
L['sailor_zazzuks_180_proof_rum_note'] = '控制室内。'
L['sailor_zazzuks_180_proof_rum_treasure'] = '水手扎祖克的高纯度朗姆酒'
L['sethekk_idol_treasure'] = '塞泰克神像'
L['sethekk_ritual_brew_treasure'] = '塞泰克仪式用酒'
L['shattered_hand_cache_treasure'] = '碎手宝箱'
L['shattered_hand_lockbox_treasure'] = '碎手保险箱'
L['shredder_parts_treasure'] = '切割机零件'
L['spray_o_matic_5000_xt_treasure'] = '自动喷洒机5000XT型'
L['sun_touched_cache_treasure'] = '烈日宝箱'
L['toxicfang_venom_treasure'] = '毒牙毒液'
L['waterlogged_satchel_treasure'] = '浸水的背包'
L['nizzixs_chest_treasure'] = '尼兹克西的宝箱'
L['nizzixs_chest_treasure_note'] = '单击漂浮在水中附近的 {object:逃生舱}。'

L['misplaced_scroll_treasure'] = '遗失的卷轴'
L['relics_of_the_outcasts_treasure'] = '流亡者圣物'
L['smuggled_apexis_artifacts_treasure'] = '走私的埃匹希斯遗物'

L['offering_to_the_raven_mother_treasure'] = '鸦母的供品'

L['elixir_of_shadow_sight_treasure'] = '暗影视觉药剂'
L['elixir_pre_note'] = '带到 {object:泰罗克圣坛}。'
L['elixir_01_note'] = '小木屋旁边的一个吊篮内。'
L['elixir_02_note'] = '在燃烧的小屋后面的篮子里。'
L['elixir_03_note'] = '在一棵树和一堵破墙之间的篮子里。'
L['elixir_04_note'] = '刃牙虎人洞穴内。'
L['elixir_05_note'] = '山上，旁边是一个 {npc:83633} 的尸体。走上大山路后，寻找另一个 {npc:83633} 挂在两棵树之间的链子上。药剂在山后右边的树旁。'
L['elixir_06_note'] = '在水中，在一堵较小的破墙的尽头。'

L['gift_of_anzu_treasure'] = '安苏之赐'

L['pirate_pepe_note'] = '坐在岩壁内侧底部的一块岩石上。'
L['pirate_pepe_treasure'] = '海盗佩佩'

L['forbidden_tome_note'] = [[
需要 {quest:36682} 日常任务才能激活或使用 {item:122409}。

与 {npc:85992} 互动以随机获得三个增益之一。

{spell:171783}
{spell:171787}
{spell:171768}
]]

L['leorajh_follower_note'] = '交谈招募他为追随者。'

L['options_icons_archaeology_treasure'] = '考古宝藏'
L['options_icons_archaeology_treasure_desc'] = '显示考古宝藏的位置。'
L['options_icons_offering'] = '鸦母的供品'
L['options_icons_offering_desc'] = '显示 {object:鸦母的供品} 的物品位置。'
L['options_icons_shrines_of_terokk'] = '泰罗克圣坛'
L['options_icons_shrines_of_terokk_desc'] = '显示 {object:泰罗克圣坛} 的位置。'
L['options_icons_would_you_like_a_pamplet'] = '{achievement:9432}'
L['options_icons_would_you_like_a_pamplet_desc'] = '显示 {achievement:9432} 成就中物品的位置。'
L['options_icons_king_of_the_monsters'] = '{achievement:9601}'
L['options_icons_king_of_the_monsters_desc'] = '显示 {achievement:9601} 成就中稀有的位置。'

-------------------------------------------------------------------------------
------------------------------------ TALADOR ----------------------------------
-------------------------------------------------------------------------------

L['wandering_vindicator_note'] = '击败他后，需要从石头中拾取宝剑。'
L['legion_vanguard_note'] = '从传送门中召唤 {npc:88494}。击杀传送门周围 {npc:83023} 及其它，会把他召唤出来。'
L['taladorantula_note'] = '踩踏卵巢并击杀周围的 {npc:75258} 来召唤 {npc:77634}。大约需要3到5分钟的踩踏时间。'
L['shirzir_note'] = '在地下墓穴。'
L['kharazos_galzomar_sikthiss_note'] = '{npc:78710}、{npc:78713} 和 {npc:78715} 共享掉落、出现和路径。'
L['orumo_the_observer_note'] = [[
{npc:87668} 需要5人站在符文上直到他可被击杀。

或者，术士的 {spell:48020} 和武僧的 {spell:119996} 可用于传送到符文，这将所需人数减少到3个。

另一种选择是使用您自己的5个角色，将它们一个一个地移动到符文并在那里登出。

最后一个选择是只使用一个角色。站到符文，点亮它，传送出去并为每个符文重复。最好的方法是在附近设置 {item:6948}。

可以结合上述任何一种方法召唤 {npc:87668}。
]]

L['aarkos_family_treasure_treasure'] = '阿尔克的传家宝'
L['aarkos_family_treasure_treasure_note'] = '和 {npc:77664} 交谈后敌人会出现。击杀 {npc:77677} 之后宝箱会出现。'
L['amethyl_crystal_treasure'] = '艾米瑟尔水晶'
L['aruuna_mining_cart_treasure'] = '阿鲁纳矿车'
L['barrel_of_fish_treasure'] = '一桶鱼'
L['bonechewer_remnants_treasure'] = '噬骨遗物'
L['bonechewer_spear_treasure'] = '噬骨长矛'
L['bright_coin_treasure'] = '闪亮硬币'
L['charred_sword_treasure'] = '烧焦的长剑'
L['curious_deathweb_egg_treasure'] = '古怪的逝网蛛卵'
L['deceptias_smoldering_boots_treasure'] = '德塞普提亚的冒烟靴子'
L['draenei_weapons_treasure'] = '德莱尼武器'
L['farmers_bounty_treasure'] = '农夫的宝贝'
L['foremans_lunchbox_treasure'] = '工头的午餐盒'
L['iron_box_treasure'] = '铁盒子'
L['isaaris_cache_note'] = '营救4名被困在蜘蛛网中的德莱尼，然后 {object:伊萨莉宝箱} 将在这里出现。'
L['isarris_cache_treasure'] = '伊萨莉宝箱'
L['jug_of_aged_ironwine_treasure'] = '一大壶陈年黑铁佳酿'
L['keluus_belongings_treasure'] = '克鲁的物品'
L['ketyas_stash_treasure'] = '凯特娅的宝箱'
L['light_of_the_sea_treasure'] = '海洋之光'
L['lightbearer_treasure'] = '圣光使者'
L['luminous_shell_treasure'] = '微光贝壳'
L['noranas_cache_note'] = '营救4名被困在蜘蛛网中的冒险者，然后 {object:诺拉纳的宝箱} 将在这里出现。'
L['noranas_cache_treasure'] = '诺拉纳的宝箱'
L['pure_crystal_dust_note'] = '矿井上层。'
L['pure_crystal_dust_treasure'] = '纯净水晶尘'
L['relic_of_aruuna_treasure'] = '阿鲁纳遗物'
L['relic_of_telmor_treasure'] = '泰尔莫遗物'
L['rooks_tacklebox_treasure'] = '鲁克的工具盒'
L['rusted_lockbox_treasure'] = '生锈宝箱'
L['rusted_lockbox_treasure_note'] = '洞穴内。\n沉入水中。'
L['soulbinders_reliquary_treasure'] = '缚魂者的圣物箱'
L['teroclaw_nest_treasure'] = '恐爪鸟巢穴'
L['treasure_of_angorosh_treasure'] = '安葛洛什宝藏'
L['webbed_sac_treasure'] = '结网的囊袋'
L['yuuris_gift_treasure'] = '尤里的礼物'
L['gift_of_the_ancients_treasure'] = '古树的礼物'
L['gift_of_the_ancients_treasure_note'] = '洞穴内。\n\n转动雕像，使所有三个都背对中心。'

L['knight_pepe_treasure'] = '骑士佩佩'
L['knight_pepe_note'] = '帐篷里坐在箱子上。'

L['wingmen_note'] = '杀死无限出现的 {npc:78433}、{npc:76883} 和 {npc:78432}，每怪获得10点声望。\n\n大型恶魔，如 {npc:78715} 和 {npc:78713} 不提供额外的声望。'
L['fel_portal'] = '邪能传送门'

L['aeda_brightdawn_follower_note'] = '完成 {quest:34776} 招募她为追随者。'
L['ahm_follower_note'] = '完成 {quest:33973} 然后在要塞与他会面招募他为追随者。'
L['defender_illona_follower_note'] = '完成 {quest:34777} 招募她为追随者。'
L['pleasure_bot_8000_follower_note'] = '完成 {quest:34761} 招募其为追随者。'
L['image_of_archmage_vargoth_follower_note'] = [[
在 {location:德拉诺} 范围找到4个神秘物体。

{quest:34463} 位于 {location:戈尔隆德}
{quest:34464} 位于 {location:霜火岭}
{quest:34465} 位于 {location:塔拉多}
{quest:34466} 位于 {location:纳格兰}

在 {location:塔拉多} 的 {location:卡德加的法师塔} 将每个任务交给 {npc:86949}，然后他们将有 {quest:34472}。完成任务，然后与 {npc:77853} 交谈招募他为追随者。
]]

L['options_icons_cut_off_the_head'] = '{achievement:9633}'
L['options_icons_cut_off_the_head_desc'] = '显示 {achievement:9633} 成就中稀有的位置。'
L['options_icons_wingmen'] = '{achievement:9499}'
L['options_icons_wingmen_desc'] = '显示 {achievement:9499} 成就中刷怪的位置。'

-------------------------------------------------------------------------------
--------------------------------- TANAAN JUNGLE -------------------------------
-------------------------------------------------------------------------------

L['deathtalon_note'] = '{yell:暗影领主艾斯卡喊道：在彼岸，你能找到的只有死亡！}'
L['doomroller_note'] = '{yell:攻城大师玛塔克喊道：哈哈！狠狠践踏他们的尸体吧！}'
L['terrorfist_note'] = '{yell:弗甘喊道：一头巨型小戈隆正冲向游侠避难所！我们需要援助！}'
L['vengeance_note'] = '{yell:暴君维哈里喊道：爬虫只配被碾死！}'
L['iron_armada_note'] = '此玩具也可在拍卖行购买并需要成就 {achievement:10353}。'
L['commander_kraggoth_note'] = '在东北塔顶上。'
L['grannok_note'] = '在东南塔顶上。'
L['szirek_the_twisted_note'] = '占领东侧据点召唤此稀有。'
L['the_iron_houndmaster_note'] = '占领西侧据点召唤此稀有。'
L['belgork_thromma_note'] = '此洞穴有2个入口。'
L['driss_vile_note'] = '在塔顶上。'
L['overlord_magruth_note'] = '击杀营地附近兽人让他出现。'
L['mistress_thavra_note'] = '在洞穴上层。'
L['dorg_the_bloody_note'] = '在出现点击杀 {npc:89706} 和其他敌人。'
L['grand_warlock_netherkurse_note'] = '击杀出现点附近的敌人。'
L['ceraxas_note'] = '击杀后出现的 {npc:90426} 有任务 {quest:38428} 获得宠物。'
L['commander_orgmok_note'] = '骑着 {npc:89676} 巡逻。'
L['rendrak_note'] = '从沼泽周围的 {npc:89788} 收集10个 {item:124045}。将它们结合起来召唤稀有。'
L['akrrilo_note'] = '从 {npc:92805} 购买 {item:124093} 并在 {location:黑齿挑战竞技场} 使用它。'
L['rendarr_note'] = '从 {npc:92805} 购买 {item:124094} 并在 {location:黑齿挑战竞技场} 使用它。'
L['eyepiercer_note'] = '从 {npc:92805} 购买 {item:124095} 并在 {location:黑齿挑战竞技场} 使用它。'
L['the_night_haunter_note'] = [[
收集10层 {spell:183612} 负面效果。

使用 {npc:92651} 或找到 {npc:92645}（100%几率）可以获得负面效果。
]]
L['xemirkol_note'] = [[
从 {npc:95424} 购买 {item:128502} 或 {item:128503} 并在出现点使用它传送到 {npc:96235}。

水晶将你传送到附近的随机稀有地点，所以最好在击杀 {npc:92887} 并使用 {item:128502}。

{npc:96235} 有很长的重生计时器（大约一天），最好的方法是在服务器重启后或使用跨服务器。
]]
L['cindral_note'] = '建筑物内。\n击杀全部 {npc:90522} 后 {npc:90519} 出现。'

L['axe_of_the_weeping_wolf_treasure'] = '哀狼之斧'
L['bejeweled_egg_treasure'] = '珠玉彩蛋'
L['blackfang_island_cache_treasure'] = '黑齿岛宝箱'
L['bleeding_hollow_mushroom_stash_treasure'] = '血环蘑菇桶'
L['bleeding_hollow_warchest_treasure'] = '血环战场储物箱'
L['book_of_zyzzix_treasure'] = '茨兹克的书'
L['borrowed_enchanted_spyglass_treasure'] = '“借来”的魔法望远镜'
L['brazier_of_awakening_treasure'] = '觉醒火盆'
L['censer_of_torment_treasure'] = '苦难熏炉'
L['crystallized_essence_of_the_elements_treasure'] = '晶化元素精华'
L['crystallized_fel_spike_treasure'] = '晶化邪能尖刺'
L['dazzling_rod_treasure'] = '炫目之杖'
L['dead_mans_chest_treasure'] = '亡灵宝藏'
L['discarded_helm_treasure'] = '被遗弃的头盔'
L['fel_drenched_satchel_treasure'] = '被邪能侵蚀的背包'
L['fel_tainted_apexis_formation_treasure'] = '被邪能污染的埃匹希斯晶体'
L['forgotten_champions_blade_treasure'] = '被遗忘的勇士之剑'
L['forgotten_iron_horde_supplies_treasure'] = '被遗忘的钢铁部落补给品'
L['forgotten_sack_treasure'] = '被遗忘的袋子'
L['forgotten_shard_of_the_cipher_treasure'] = '被遗忘的秘文碎片'
L['ironbeards_treasure_treasure'] = '铁须的宝藏'
L['jewel_of_hellfire_treasure'] = '地狱火珠宝'
L['jewel_of_the_fallen_star_treasure'] = '坠星珠宝'
L['jeweled_arakkoa_effigy_treasure'] = '鸦人嵌宝雕像'
L['lodged_hunting_spear_treasure'] = '倒伏的狩猎长矛'
L['looted_bleeding_hollow_treasure_treasure'] = '抢来的血环宝藏'
L['looted_mystical_staff_treasure'] = '抢来的神秘法杖'
L['mysterious_corrupted_obelist_treasure'] = '神秘的腐化方尖碑'
L['overgrown_relic_treasure'] = '巨型遗物'
L['pale_removal_equipment_treasure'] = '反白鬼设备'
L['partially_mined_apexis_crystal_treasure'] = '挖过的埃匹希斯水晶'
L['polished_crystal_treasure'] = '抛光水晶'
L['rune_etched_femur_treasure'] = '铭文腿骨'
L['sacrificial_blade_treasure'] = '献祭之刃'
L['scouts_belongings_treasure'] = '斥候的财物'
L['skull_of_the_mad_chief_treasure'] = '疯狂酋长之颅'
L['snake_charmers_flute_treasure'] = '驯蛇人的笛子'
L['spoils_of_war_note'] = '在小屋内。'
L['spoils_of_war_treasure'] = '战争横财'
L['stashed_bleeding_hollow_loot_treasure'] = '抢来的血环宝藏'
L['stashed_iron_sea_booty_treasure'] = '隐藏的铁海宝藏'
L['stolen_captains_chest_treasure'] = '失窃的船长宝箱'
L['strange_fruit_note'] = '{item:127396} 14天后孵化为 {item:127394}。'
L['strange_fruit_treasure'] = '奇怪水果'
L['strange_sapphire_treasure'] = '古怪的蓝宝石'
L['the_blade_of_kranak_treasure'] = '卡纳克之刃'
L['the_commanders_shield_note'] = '建筑物内。'
L['the_commanders_shield_treasure'] = '指挥官的盾牌'
L['the_eye_of_grannok_note'] = '在塔二层楼梯附近。'
L['the_eye_of_grannok_treasure'] = '格兰诺克之眼'
L['the_perfect_blossom_treasure'] = '完美之花'
L['tome_of_secrets_treasure'] = '隐秘之书'
L['tower_chest_note'] = '在塔顶上。'
L['weathered_axe_treasure'] = '风化的斧子'

--LEG
-------------------------------------------------------------------------------
------------------------------- ANTORAN WASTES --------------------------------
-------------------------------------------------------------------------------

L['commander_texlaz_note'] = '不再需要 {quest:48831} 世界任务来激活。使用绿色传送门。'
L['doomcaster_suprax_note'] = '不再需要三名玩家。只要站到符文上召唤 {npc:127703}。'
L['mother_rosula_note'] = '从 {npc:126073} 收集100个 {item:152999} 并组合成为 {item:153013}。在她的邪能池子使用 {item:153013}。'
L['reziera_the_seer_note'] = '有 {spell:254174} 增益时收集500个 {item:153021} 用来从 {npc:128134} 购买 {item:153226}。使用 {item:153226} 用于传送你（和队伍）到 {npc:127706}。'
L['squadron_commander_vishax_note'] = '从 {npc:127598} 收集 {item:152890}。\n\n从 {npc:127597} 和 {npc:127596} 收集 {item:152941}，{item:152940} 和 {item:152891}。\n\n使用 {item:152890} 获得 {quest:49007}。\n\n{note:此任务可共享}'
L['ven_orn_note'] = '进入蜘蛛洞穴，向右并向下到另一个小洞穴。她在后面的第二个房间里。'

L['the_many_faced_devourer_note'] = '从位于 {location:食腐者废料场} 的 {npc:126193} 和 {npc:126171} 收集 {item:152786}。\n\n收集 {item:152991}，{item:152992} 和 {item:152993}。\n\n在 {npc:127442} 召唤 {npc:127581}。\n\n{note:如不能看到 {npc:127442} 则需要重新登录。}'
L['the_many_faced_devourer_checklist'] = '|cFFFFD700物品检查表（背包或银行）：|r'

L['orix_the_all_seer_note'] = '出售收藏品换取 {item:153021}。'

L['legion_war_supplies'] = '军团战争物资'
L['legion_war_supplies_note'] = '有9个独特的 {object:军团战争物资} 可以出现位置组中。'

L['options_icons_legion_war_supplies'] = '军团战争物资'
L['options_icons_legion_war_supplies_desc'] = '显示 {object:军团战争物资} 的可能位置（每日宝箱）。'

-------------------------------------------------------------------------------
------------------------------------ ARGUS ------------------------------------
-------------------------------------------------------------------------------

L['drops_fel_spotted_egg'] = '掉落 {item:153190}'
L['fel_spotted_egg_contains'] = '{item:153190} 可包含'

L['goblin_glider_treasure_note'] = '使用 {item:109076} 滑翔到宝藏。'
L['lightforged_warframe_treasure_note'] = '登上 {npc:126426} 在 {npc:121365} 激活 {item:152098}。\n\n使用 {item:152098} 和 {spell:250434} 融化岩石并找到宝藏。'
L['lights_judgement_treasure_note'] = '登上 {npc:126426} 在 {npc:121365} 激活 {item:151830}。\n\n使用 {item:151830} 炸开岩石并找到宝藏。'
L['shroud_of_arcane_echoes_treasures_note'] = '登上 {npc:126426} 在 {npc:121365} 激活 {item:151912}。\n\n使用 {item:151912} 解锁宝藏。\n\n{note:“只对拥有与奥古雷相呼应的力量的人开放。”}'

-------------------------------------------------------------------------------
----------------------------------- AZSUNA ------------------------------------
-------------------------------------------------------------------------------

L['arcavellus_note'] = '击杀 {npc:90242} 和 {npc:90243} 直到稀有出现。'
L['beacher_note'] = '当世界任务 {wq:海拉加尔登陆战：灰色浅滩} 激活时不出现。'
L['brogozog_note'] = '和 {npc:91097} 交谈。'
L['chief_bitterbrine_note'] = '位于船下层甲板。'
L['devious_sunrunner_note'] = '使用小洞穴内的 {object:魔网传送门}。别忘了拾取宝箱。'
L['doomlord_kazrok_note'] = '和 {npc:91580} 交谈。'
L['felwing_note'] = '和 {npc:105913} 交谈并击杀 {npc:105919} 直到稀有出现。'
L['golza_note'] = '吹响 {object:海妖号角} 并击杀 {npc:90774} 和 {npc:90778} 直到稀有出现。'
L['infernal_lord_note'] = '点击 {object:地狱火宝箱} 并击杀 {npc:90797} 直到稀有出现。'
L['inquisitor_tivos_note'] = '使用 {object:军团传送门}。他在下层。'
L['shaliman_note'] = '在池塘边。'

L['disputed_treasure'] = '有争议的宝藏'
L['in_academy'] = '{location:纳萨拉斯学院} 内。'
L['in_oceanus_cove'] = '{location:欧逊努斯海窟} 内。'
L['seemingly_unguarded_treasure'] = '看似无人看守的宝藏'
L['seemingly_unguarded_treasure_note'] = '尝试拾取 {object:看似无人看守的宝藏} 并击杀随后出现的数波 {npc:94167}。'
L['treasure_37958'] = '位于建筑物下层。'
L['treasure_37980'] = '使用断桥上的 {object:魔网传送门}。'
L['treasure_40711'] = '使用塔内的 {object:魔网传送门}。'
L['treasure_42282'] = '在阳台的角落。'
L['treasure_42283'] = '位于第二层。'
L['treasure_42287'] = '水下。'
L['treasure_42339'] = '别吵醒熊。'

L['nightwatcher_merayl_note'] = '列队！'

L['book_1'] = '第一章（周日）'
L['book_2'] = '第二章（周一）'
L['book_3'] = '第三章（周二）'
L['book_4'] = '第四章（周三）'
L['book_5'] = '第五章（周四）'
L['book_6'] = '第六章（周五）'
L['book_7'] = '第七章（周六）'

L['higher_dimensional_learning_location'] = '位于塔顶。'
L['higher_dimensional_learning_note'] = '从 {location:倾颓王宫} 的 {npc:107376} 购买 {item:129276}。每天使用 {item:129276} 将传送到不同书的位置。\n\n第一章（周日）\n第二章（周一）\n第三章（周二）\n第四章（周三）\n第五章（周四）\n第六章（周五）\n第七章（周六）'
L['higher_dimensional_learning_disclaimer'] = '{note:传送到书本位置并不能保证这本书会出现。可能需要等待或稍后再回来查看。}'

L['options_icons_higher_dimensional_learning'] = '{achievement:11175}'
L['options_icons_higher_dimensional_learning_desc'] = '显示 {achievement:11175} 成就中书的位置。'

-------------------------------------------------------------------------------
-------------------------------- BROKEN SHORE ---------------------------------
-------------------------------------------------------------------------------

L['bringing_home_the_beacon_note'] = '{npc:127264} 下面，你将有 {spell:240640} 增益。\n\n击杀恶魔拾取各种 |cFFFFFD00森提纳克斯信标|r。'

L['options_icons_bringing_home_the_beacon'] = '{achievement:11802}'
L['options_icons_bringing_home_the_beacon_desc'] = '显示 {achievement:11802} 成就中 {npc:127264} 的位置。'

L['hidden_wyrmtongue_cache_label'] = '隐藏的虫语者箱子'
L['in_horde_ship'] = '在坠毁的部落飞艇中。'
L['broken_shore_worldboss_note'] = '只在 {location:虚空干扰器} 建成时出现。每个周期只会产生一个世界首领。'
L['sentinax_rare_note'] = [[
要首领出现，需要在 {npc:127264} 下有 {spell:240640} 增益时刷怪并开启传送门。

{npc:%d} 需要
{item:%d}
->
{item:%d}
->
{item:%d}

当 {location:虚空干扰器} 建成时，{npc:120898} 将出售 {item:147775}，每天最多可以在 {npc:120751} 上使用50次。
传送门随后会出现精英怪物有更高几率掉落 {item:%d}。
]]

-------------------------------------------------------------------------------
---------------------------------- DALARAN ------------------------------------
-------------------------------------------------------------------------------

-- Midnight tz per region: US=>PST, KR=>KST, EU=>CET, TW=>CST, CN=>CST
local tz = ({
    '太平洋标准时间', '韩国标准时间', '欧洲中部时间',
    '中国标准时间', '中国标准时间'
})[GetCurrentRegion()] or UNKNOWN

L['sheddles_chest'] = '西德尔的箱子'
L['shoe_shine_kit_note'] = '每个星期六晚上的午夜零时（' .. tz .. '）{npc:97003} 将他的箱子丢在地上几小时并离开。'
L['wand_simulated_life_note'] = '楼上的桌子上。'

L['sir_galveston_note'] = '你准备好了吗，奔波尔斯顿爵士？勇敢地战斗吧！'
L['amalia_note'] = '你别光说不练啊。'
L['tiffany_nelson_note'] = '放马过来吧！'
L['bohdi_sunwayver_note'] = '太阳出来啦！宠物们，出击吧！'

-------------------------------------------------------------------------------
----------------------------------- EREDATH -----------------------------------
-------------------------------------------------------------------------------

L['kaara_the_pale_note'] = '{npc:126860} 不再掉落 {item:153190}'
L['turek_the_lucid_note'] = '在 {location:奥罗纳尔陷坑} 内'

L['ancient_eredar_cache'] = '上古艾瑞达宝箱'
L['ancient_eredar_cache_note'] = '有6个独特的 {object:上古艾瑞达宝箱} 可以出现位置组中。'
L['void_seeped_cache'] = '浸透虚空的宝箱'
L['void_seeped_cache_note'] = '有2个独特的 {object:浸透虚空的宝箱} 可以出现位置组中。{note:这些不包含幻化。}'

L['options_icons_ancient_eredar_cache'] = '上古艾瑞达宝箱'
L['options_icons_ancient_eredar_cache_desc'] = '显示 {object:上古艾瑞达宝箱} 的可能位置（每日宝箱）。'
L['options_icons_void_seeped_cache'] = '浸透虚空的宝箱'
L['options_icons_void_seeped_cache_desc'] = '显示 {object:浸透虚空的宝箱} 的可能位置（每日宝箱）。'

-------------------------------------------------------------------------------
-------------------------------- HIGHMOUNTAIN ---------------------------------
-------------------------------------------------------------------------------

L['odrogg_note'] = '你以为你能击败我的蜗牛？'
L['grixis_tinypop_note'] = '这完全是小菜一碟！'
L['bredda_tenderhide_note'] = '狭路相逢勇者胜！'
L['unethical_adventurers'] = '卑鄙的冒险者'
L['unethical_adventurers_note'] = '点击 {object:看似无人看守的宝藏} 召唤 {npc:卑鄙的冒险者}。'
L['taurson_note'] = '与 {npc:97653} 交谈并向他发起挑战。\n当击败他时，{object:陶森的奖品} 会出现。'
L['arru_note'] = '与 {npc:97215} 交谈以开始与 {npc:97220} 的战斗。\n\n当 {npc:97215} 驯服了熊时，{object:雷霆图腾失窃货物} 将在小洞穴的后面出现。'
L['tt_hoc'] = '{location:酋长大厅} 下面。'
L['steamy_jewelry_box'] = '潮湿的珠宝盒'
L['flamescale_note'] = '使用 {object:被遗弃的鱼竿} 召唤 {npc:97793}。'
L['amateur_hunters_note'] = '在击败三个 {npc:业余猎手} 后，{object:破损的箱子} 会在小洞穴的后面出现。'
L['treasure_40482'] = '在巨大雕像的鼻子上。'
L['mrrklr_note'] = '解救 {npc:98754} 后 {npc:98311} 出现。'
L['mytna_talonscreech_note'] = '与 {npc:97579} 交谈开始与 {npc:97593} 的战斗。'
L['devouring_darkness_note'] = '熄灭所有 {npc:97543} 以召唤 {npc:100495}。'
L['totally_safe_treasure_chest'] = '完全安全的宝箱'
L['rocfeather_kite_note'] = '将 {item:131809}，{item:131926}，{item:131927}，{item:131810} 组合得到 {item:131811}。'

-------------------------------------------------------------------------------
-------------------------------- KROKUUN --------------------------------------
-------------------------------------------------------------------------------

L['eredar_war_supplies'] = '艾瑞达战争物资'
L['eredar_war_supplies_note'] = '有7个独特的 {object:艾瑞达战争物资} 可以出现位置组中。'

L['options_icons_eredar_war_supplies'] = '艾瑞达战争物资'
L['options_icons_eredar_war_supplies_desc'] = '显示 {object:艾瑞达战争物资} 的可能位置（每日宝箱）。'

-------------------------------------------------------------------------------
--------------------------------- STORMHEIM -----------------------------------
-------------------------------------------------------------------------------
L['to_stormheim'] = '传送到风暴峡湾'
L['to_helheim'] = '传送到冥狱深渊'

L['trapper_jarrun_note'] = '保护好你自己吧，凡人。'
L['robert_craig_note'] = '消灭他们！'
L['stormtalon_note'] = '尽量不要一击必杀，否则将无法骑上他。'
L['going_up_note'] = '登上位于 {location:风暴峡湾} 的 {location:纳沙尔岗哨} 的顶端。' -- wowhead.com/achievement=10627
L['nameless_king_note'] = '使用 {object:祭坛} 召唤 {npc:92763}。'
L['captain_brvet_note'] = '使用 {object:冥口号角} 召唤 {npc:92685}。'
L['mother_clacker_note'] = '与 {npc:92343} 交谈并击杀 {npc:92349} 召唤 {npc:91780}。'
L['thane_irglov_note'] = '击败勇士使他可被攻击。'

L['hook_and_sinker'] = '{npc:92590} 与 {npc:92591}'
L['forsaken_deathsquad'] = '被遗忘者敢死队'
L['worgen_stalkers'] = '狼人追猎者'

-------------------------------------------------------------------------------
---------------------------------- SURAMAR ------------------------------------
-------------------------------------------------------------------------------

L['varenne_note'] = '我必须回去做菜了！'
L['master_tamer_flummox_note'] = '弗鲁莫斯不需要宠物！弗鲁莫斯要吃了它们！'
L['aulier_note'] = '我就先教教你什么叫谦虚吧。'
L['myonix_note'] = '{bug:目前有问题，需要重新登录以显示 {achievement:11265} 中的条件。}'
L['arcanist_lylandre_note'] = '要攻击她必须通过点击水晶来移除障碍。'
L['gorgroth_note'] = '使用 {object:传送门钥匙} 召唤 {npc:110832}。'
L['inside_temple_of_faladora'] = '{location:法尔多拉神殿} 内。'
L['inside_falanaar_tunnels'] = '{location:法兰纳尔隧道} 内。'
L['ancient_mana_chunk'] = '远古魔力碎块'
L['dusty_coffer'] = '尘封的保险箱'
L['protected_treasure_chest'] = '受保护的宝箱'

-------------------------------------------------------------------------------
--------------------------------- VAL'SHARA -----------------------------------
-------------------------------------------------------------------------------

L['anthydas_note'] = '建筑物二楼的水槽旁边拾取宝箱。'
L['elandris_note'] = '当军团入侵世界任务 {wq:恐惧之谷} 激活时不出现。'
L['gathenak_note'] = '和 {npc:112472} 交谈。'
L['gorebeak_note'] = '和 {npc:92111} 交谈。'
L['jinikki_note'] = '和 {npc:93677} 交谈并击杀 {npc:93684} 直到稀有出现。'
L['kiranys_note'] = '点击 {object:魔力震荡陷阱}。'
L['mad_henryk_note'] = '靠近 {npc:109602}。'
L['skulvrax_note'] = '复苏 {npc:92334} 并跟随她。'
L['theryssia_note'] = '阅读墓碑上 {npc:94194} 的姓名板。'
L['unguarded_thistleleaf_treasure'] = '无人看守的蓟叶宝藏'

L['in_darkpens'] = '{location:黑暗围栏} 内。'
L['treasure_38366'] = '树根下。'
L['treasure_38386'] = '二层阳台上。'
L['treasure_38387'] = '旅店下面小洞穴内。入口位于建筑物后面。'
L['treasure_38391'] = '隐藏在树后。'
L['treasure_38943'] = '上右侧楼梯。'
L['treasure_39069'] = '二层阳台上。'
L['treasure_39074'] = '树下。'
L['treasure_39080'] = '地下室内。需要开始任务线开始于 {npc:92688} 的 {quest:38643} 任务然后是 {npc:92683} 的 {quest:38644}。'
L['treasure_39083'] = '藏在树内。'
L['treasure_39088'] = '隐藏在一些树根之间的湖中。'
L['treasure_39093'] = '河里树根下。'

L['grumpy_note'] = '燃烧的建筑物楼上。'

L['xorvasc_note'] = '我就是你最可怕的梦魇。'
L['durian_strongfruit_note'] = '那好吧……'

-------------------------------------------------------------------------------
--------------------------------- ACROSS ZONES --------------------------------
-------------------------------------------------------------------------------

L['in_house'] = '房屋内。'
L['in_small_cottage'] = '小木屋内。'

L['glimmering_treasure_chest'] = '闪闪发光的宝箱'
L['small_treasure_chest'] = '小宝箱'
L['treasure_chest'] = '宝箱'
L['treasures_discovered'] = '已发现宝箱'

L['general_pet_tamer_note'] = '{note:相对应的世界任务激活时才会出现。}'

L['options_icons_safari'] = '{achievement:11233}'
L['options_icons_safari_desc'] = '显示 {achievement:11233} 成就中战斗宠物的位置。'

L['change_map'] = '更改地图'

--BFA

-------------------------------------------------------------------------------
----------------------------------- DRUSTVAR ----------------------------------
-------------------------------------------------------------------------------

L['ancient_sarco_note'] = '打开 {object:古代石棺} 来召唤数波 {npc:128181}。'
L['beshol_note'] = '打开 {object:显然很安全的宝箱} 来召唤稀有。'
L['cottontail_matron_note'] = '研究 {object:骇人的仪式颅骨} 来召唤稀有。'
L['gluttonous_yeti_note'] = '此 {npc:127979} 注定…'
L['idej_note'] = '昏迷他施放的 {spell:274005} 否则他会杀了 {npc:139380}！'
L['seething_cache_note'] = '打开 {object:沸燃之箱} 来召唤数波 {npc:129031}。'
L['the_caterer_note'] = '研究 {object:被砸烂的婚礼蛋糕} 来激活。'
L['vicemaul_note'] = '点击 {npc:127652} 来钓出稀有。'

L['merchants_chest_note'] = '击杀附近持有钥匙的 {npc:137468} 以获得 {item:163710}。'
L['wicker_pup_note'] = [[
点亮未激活的 {npc:143609} 来激活宝箱。组合所有四个箱子中的物品创建一个 {npc:143189}。

· 咒蛊：{item:163790}
· 附魔：{item:163796}
· 迷惑：{item:163791}
· 妖术：{item:163789}
]]

local runebound = '激活 {npc:143688} 按照宝箱后面金属板上显示的顺序：\n\n'
L['runebound_cache_note'] = runebound .. '左 -> 下 -> 上 -> 右'
L['runebound_chest_note'] = runebound .. '左 -> 右 -> 下 -> 上'
L['runebound_coffer_note'] = runebound .. '右 -> 上 -> 左 -> 下'

L['captain_hermes_note'] = '耶！尝尝甲壳之力！'
L['dilbert_mcclint_note'] = '嗨，害虫防治专家呆伯特·麦克林特向您报道。非常高兴能和一位像我一样的蜘蛛爱好者一较高下。'
L['fizzie_spark_note'] = '你觉得你的宠物有机会打败我注入了艾泽里特的队伍？想得美！'
L['michael_skarn_note'] = '一旦我们开始战斗，你得记住这是你自找的。'

L['cursed_hunter_label'] = '被诅咒的动物'
L['cursed_hunter_note'] = '击杀每种类型的被诅咒动物一次即可获得成就。'
L['options_icons_cursed_hunter_desc'] = '显示 {achievement:13094} 成就中被诅咒的动物的位置。'
L['options_icons_cursed_hunter'] = '{achievement:13094}'

L['drust_facts_note'] = '阅读全部石碑获得成就。'
L['stele_forest_note'] = '{location:奥尔法的兽穴} 内。'
L['options_icons_drust_facts_desc'] = '显示 {achievement:13064} 成就中石碑的位置。'
L['options_icons_drust_facts'] = '{achievement:13064}'

L['embers_crossbow_note'] = '两棵树中间的地上拾取 {item:163749}，然后把它带回 {location:戈尔瓦} 遗迹。'
L['embers_flask_note'] = '两块岩石中间的水里拾取 {item:163746}，然后把它带回 {location:戈尔瓦} 遗迹。'
L['embers_hat_note'] = '一堆骨头中拾取 {item:163748}，然后把它带回 {location:戈尔瓦} 遗迹。'
L['embers_knife_note'] = '从树干中拉出 {item:163747}，然后把它带回 {location:戈尔瓦} 遗迹。'
L['embers_golvar_note'] = '把每个古物放回 {location:戈尔瓦} 遗迹后完成成就。'
L['golvar_ruins'] = '{location:戈尔瓦} 遗迹'
L['options_icons_ember_relics_desc'] = '显示 {achievement:13082} 成就中古物的位置。'
L['options_icons_ember_relics'] = '{achievement:13082}'

L['linda_deepwater_note'] = '要获得访问权限，必须完成就在 {location:安利港} 外面 {npc:136458} 的任务线。'

-------------------------------------------------------------------------------
----------------------------------- MECHAGON ----------------------------------
-------------------------------------------------------------------------------

L['avenger_note'] = '当 {npc:155254} 在 {location:锈栓镇}，击杀 {npc:151159}（在全地图跑）来出现。'
L['beastbot_note'] = '在 {npc:150359} 制作一个 {item:168045} 来激活。'
L['cogstar_note'] = '在任意区域内击 {npc:150667} 直到他传送来加强它们。'
L['crazed_trogg_note'] = '在 {location:邦多的大杂院} 使用 {npc:154573} 或颜料囊袋，把自己染色成他大喊的颜色然后去找他。'
L['deepwater_note'] = '在 {npc:150359} 制作一个 {item:167649} 来召唤。'
L['doppel_note'] = '与其他两名玩家，使用 {daily:56405} 获得的 {item:169470} 来激活。'
L['foul_manifest_note'] = '连接三个断路器到水中的能量塔。'
L['furor_note'] = '在 {daily:55463} 期间，点击蓝色小 {npc:135497} 直到它出现。'
L['killsaw_note'] = '在 {location:瀑溪森林} 任何地方出现，似乎因为击杀 {npc:151871} 后比较容易出现。不会在风险投资公司在森林里时出现，那时候没有 {npc:151871}。'
L['leachbeast_note'] = '在 {location:电屑运输站} 与 {npc:151745} 共享一个出现点，它只在该地区下雨时出现。使用 {item:168961} 激活 {object:天气更迭器}。'
L['nullifier_note'] = [[
侵入 {npc:152174} 使用其一：

· {npc:151625} 掉落的 {item:168435}。

· 攻击钻机JD41与JD99的小怪掉落的 {item:168023} 。
]]
L['scrapclaw_note'] = '远离岸边的水中。'
L['sparkqueen_note'] = '只在 {daily:55765} 期间出现。'
L['rusty_note'] = '在 {npc:150359} 制作一个 {item:169114} 进入平行未来时空。只在 {npc:153993} *不在* {location:锈栓镇} 期间才会出现。'
L['vaultbot_note'] = '风筝到 {location:邦多的大杂院} 的 {npc:151482} 或在 {npc:150359} 制作一个 {item:167062} 来打开它。'

L['iron_chest'] = '铁潮保险箱'
L['mech_chest'] = '机械化的宝箱'
L['msup_chest'] = '机械补给箱'
L['rust_chest'] = '生锈的旧箱子'
L['iron_chest_note'] = '{location:西浪岩} 的怪物掉落 {item:169872}。'
L['msup_chest_note'] = '{location:西浪岩} 的怪物掉落 {item:169873}。'
L['rust_chest_note'] = '{location:西浪岩} 的怪物掉落 {item:169218}。'

L['rec_rig_note'] = '要激活困难模式，使用 {spell:292352} 武器將所有 {npc:150825} 转换为 {npc:151049}。宠物可以在两种难度获得。'

L['grease_bot_note'] = '点击 {npc:155911} 获取急速提高5%，移动速度提高10%持续2小时。'
L['shock_bot_note'] = '点击 {npc:155909} 获取闪电链伤害持续2小时。'
L['welding_bot_note'] = '点击 {npc:155910} 增加生命值和承受治疗效果提高10%持续2小时。'

L['options_icons_mech_buffs'] = '增益机器人'
L['options_icons_mech_buffs_desc'] = '显示 {npc:155911}、{npc:155909} 和 {npc:155910} 在地下城内地图上的位置。'
L['options_icons_mech_chest'] = '机械补给箱'
L['options_icons_mech_chest_desc'] = '显示 {object:机械补给箱} 的位置。有10个独立的箱子可以每日拾取一次，每个箱子有4-5个出现位置。位置按颜色分组。'
L['options_icons_locked_chest'] = '锁住的箱子'
L['options_icons_locked_chest_desc'] = '在 {location:西浪岩} 显示锁住的箱子的位置。'
L['options_icons_recrig'] = '{npc:150448}'
L['options_icons_recrig_desc'] = '显示 {npc:150448} 的位置和奖励。'

L['mechagon_snooter_note'] = '{npc:154769}（非常稀有）和 {npc:154767} 共享出现点。'
L['battlepet_secondary_only_note'] = '只能作为次要宠物找到。'
L['mechagon_explode_note'] = '{note:当心，它可以 {spell:90096}，这会杀死它，将无法抓住它。}'

-------------------------------------------------------------------------------
----------------------------------- NAZJATAR ----------------------------------
-------------------------------------------------------------------------------

L['naz_intro_note'] = '完成 {location:纳沙塔尔} 引导任务解锁稀有、宝藏及世界任务！'

L['alga_note'] = '注意：隐形并有四个增援！'
L['allseer_note'] = '在 {location:卡梅希尔} 低层的任何地方出现。'
L['anemonar_note'] = '在它上方击杀 {npc:150467} 来激活。'
L['avarius_note'] = '使用 {item:167012} 收集并将彩色水晶放在基座上。你不必是一个矿工！'
L['banescale_note'] = '有很小的几率在击杀 {npc:152359} 后立即出现。'
L['elderunu_note'] = '在 {location:卡梅希尔} 高层的任何地方出现。'
L['gakula_note'] = '驱赶 {npc:152275} 直到它出现。'
L['glimmershell_note'] = '有小几率在 {npc:152426} 的位置出现。'
L['kelpwillow_note'] = '使用 {item:167893} 魅惑 {npc:154725} 到它身边来激活。'
L['lasher_note'] = '在土壤中种植 {item:166888} 并用周围的 {npc:海萤} 喂它。'
L['matriarch_note'] = '与另外两个鳞母共享刷新计时器。'
L['needle_note'] = '通常在 {location:女王之扉} 区域出现。'
L['oronu_note'] = '召唤 {npc:154849} 来激活。'
L['rockweed_note'] = '击杀整个区域的 {npc:152549} 和 {npc:151166} 直到它出现。建议组团，因为这可能需要很长时间。'
L['sandcastle_note'] = '使用 {item:167077} 在区域内任何地方探测宝箱直到它出现。'
L['tidelord_note'] = '击杀三个 {npc:145326} 和被召唤的 {npc:153999} 直到海潮领主被召唤出来。'
L['tidemistress_note'] = '点击 {object:原状标本} 直到她出现。'
L['urduu_note'] = '击杀一个 {npc:152563} 在它面前来激活。'
L['voice_deeps_notes'] = '使用一个 {item:168161} 来打碎岩石。'
L['vorkoth_note'] = '丢出 {item:167059} 到水池直到它出现。'
L['area_spawn'] = '在周围地区出现。'
L['cora_spawn'] = '在 {location:赤珊森林} 任意地方出现。'
L['cave_spawn'] = '在洞穴中出现。'
L['east_spawn'] = '在任何区域的东半部分出现。'
L['ucav_spawn'] = '在水下的洞穴出现。'
L['zone_spawn'] = '在整个区域出现。'

L['assassin_looted'] = '充当刺客时拾取。'

L['arcane_chest'] = '奥术宝箱'
L['glowing_chest'] = '发光的奥能宝箱'
L['arcane_chest_01'] = '在一些海藻下。'
L['arcane_chest_02'] = '在建筑內部的上层。'
L['arcane_chest_03'] = '在第二层。'
L['arcane_chest_04'] = '在瀑布上方的水中。'
L['arcane_chest_05'] = '在废墟中。'
L['arcane_chest_06'] = '' -- in the open
L['arcane_chest_07'] = '在洞穴的后面。入口位于 {location:赞齐尔海床} 东侧。'
L['arcane_chest_08'] = '藏在一些海星下面。'
L['arcane_chest_09'] = '在珠躯爬蟹后面一个洞穴里。'
L['arcane_chest_10'] = '在一个蜕下的壳下面。'
L['arcane_chest_11'] = '在山顶。'
L['arcane_chest_12'] = '在瀑布顶部。'
L['arcane_chest_13'] = '在悬崖顶部，树后面。'
L['arcane_chest_14'] = '在 {location:艾露罗神殿} 內部。'
L['arcane_chest_15'] = '在建筑物右侧。'
L['arcane_chest_16'] = '在水下的洞穴。入口在南边。'
L['arcane_chest_17'] = '在瀑布顶部。'
L['arcane_chest_18'] = '在路径下方的一个洞穴里。'
L['arcane_chest_19'] = '在岩石拱门顶部。使用滑翔器。'
L['arcane_chest_20'] = '在山顶。'
L['glowing_chest_1'] = '在水下洞穴的后面，保护塔。'
L['glowing_chest_2'] = '解开连线。'
L['glowing_chest_3'] = '在洞穴的后面。保护塔。'
L['glowing_chest_4'] = '消掉三个红色符文。'
L['glowing_chest_5'] = '在洞穴内，保护塔。'
L['glowing_chest_6'] = '解开连线。'
L['glowing_chest_7'] = '消掉四个蓝色符文。'
L['glowing_chest_8'] = '在屋顶。保护塔。'

L['prismatic_crystal_note'] = '用它喂食小动物给 {location:纳沙塔尔} 的 {npc:151782}。'
L['strange_crystal'] = '奇怪的水晶'
L['strange_crystal_note'] = '解锁 {item:167893} 出现，必须在此位置先拾取 {item:169778} 并把它上交 {quest:56560}。'
L['options_icons_prismatics'] = '{item:167893}'
L['options_icons_prismatics_desc'] = '显示喂食 {npc:151782} 的 {item:167893} 的位置。'

L['slimy_cocoon'] = '粘糊糊的茧'
L['ravenous_slime_note'] = '使用 {item:167893} 魅惑小动物喂养茧。重复五天直到它出现一个宠物的蛋。茧会消失直到下周重置。'
L['slimy_cocoon_note'] = '一只宠物可以从茧中收集！如果它没有出现，茧在这个位面正在冷却，更换位面或稍后再来检查。'

L['cat_figurine'] = '水晶猫咪雕像'
L['cat_figurine_01'] = '在一个水下洞穴。雕像在露天的地板上。入口在东侧。'
L['cat_figurine_02'] = '在附近瀑布下的一个洞穴里。雕像在墙上的海星下面。'
L['cat_figurine_03'] = '在一个水下洞穴。雕像被藏在某些破碎的贝壳下。'
L['cat_figurine_04'] = '在一个水下洞穴。雕像在露天的地板上。'
L['cat_figurine_05'] = '在一个小洞穴。雕像隐藏在地板上的植物后面。'
L['cat_figurine_06'] = '在一个充满敌对的礁石行者的水下洞穴中。小雕像在墙上。入口在北侧。'
L['cat_figurine_07'] = '在一个小洞穴。雕像在一些珊瑚的墙上。'
L['cat_figurine_08'] = '在一个小洞穴。躲避奥术陷阱。雕像在后面的高大的岩石上。'
L['cat_figurine_09'] = '在一个水下洞穴。雕像位于天花板的岩石拱门上。'
L['cat_figurine_10'] = '在路径下方的一个洞穴里。雕像在三个桶之间。'
L['figurines_found'] = '已找到水晶猫咪雕像'

L['fabious_desc'] = '使用 {item:122637} 或 {item:122674} 玩具与 {npc:65090} 拍摄“自拍”照片。长时间在随机位置出现并存在很短的时间。'

L['mardivas_lab'] = '马蒂瓦斯的实验室'
L['no_reagent'] = '不使用材料'
L['swater'] = '小水'
L['gwater'] = '大水'
L['sfire'] = '小火'
L['gfire'] = '大火'
L['searth'] = '小土'
L['gearth'] = '大土'
L['Arcane'] = '奥术融合体'
L['Watery'] = '水色融合体'
L['Burning'] = '燃炎融合体'
L['Dusty'] = '尘土融合体'
L['Zomera'] = '卓梅拉'
L['Omus'] = '奥姆斯'
L['Osgen'] = '奥斯吉恩'
L['Moghiea'] = '莫基艾'
L['Xue'] = '祖厄'
L['Ungormath'] = '安戈马斯'
L['Spawn'] = '索尔苟斯之嗣'
L['Herald'] = '索尔苟斯的使徒'
L['Salgos'] = '永恒的索尔苟斯'
L['tentacle_taco'] = '出售 {item:170100}，如果你穿着底栖 {item:169489}。'

L['options_icons_slimes_nazj'] = '{npc:151782}'
L['options_icons_slimes_nazj_desc'] = '显示四个喂食一次可获得宠物的 {npc:151782} 位置。'
L['options_icons_cats_nazj'] = '{achievement:13836}'
L['options_icons_cats_nazj_desc'] = '显示 {achievement:13836} 成就水晶猫咪雕像位置。'
L['options_icons_misc_nazj'] = '杂项'
L['options_icons_misc_nazj_desc'] = '显示 {location:莫洛戈藏身处} 以及 {location:马蒂瓦斯的实验室} 的位置。'
L['options_icons_fabious'] = '{npc:65090}'
L['options_icons_fabious_desc'] = '显示 {item:169201} 坐骑的 {npc:65090} 可能的位置。'

-------------------------------------------------------------------------------
------------------------------------ NAZMIR -----------------------------------
-------------------------------------------------------------------------------

L['captain_mukala_note'] = '尝试拾取 {object:诅咒宝箱} 来召唤 {npc:125232}。'
L['enraged_water_note'] = '检查 {npc:134295} 来召唤 {npc:134294}。'
L['lucille_note'] = '和 {npc:134297} 交谈来召唤稀有。'
L['offering_to_bwonsamdi_note'] = '跑到附近的树上然后跳进损坏的建筑中。'
L['shambling_ambusher_note'] = '尝试拾取 {npc:124473} 来激活稀有。'
L['zaamar_note'] = '在 {location:冥宫古墓} 内，入口在南侧。'

L['grady_prett_note'] = '是时候下场战斗了！来吧！'
L['korval_dark_note'] = '这地方真吓人，我们快点打完吧。'
L['lozu_note'] = '我们来荣耀地战斗吧，陌生人。'

L['tales_bwonsamdi_note'] = '在被毁的柱子上。'
L['tales_hireek_note'] = '桌子上的卷轴。'
L['tales_kragwa_note'] = '在被毁的墙上。'
L['tales_torga_note'] = '水下被毁的柱子上。'

L['carved_in_stone_41860'] = '在山附近一栋被毁的建筑物内。'
L['carved_in_stone_41861'] = '在被毁的柱子上。'
L['carved_in_stone_41862'] = '在被毁的墙上，在巨大的柱子前面。'
L['carved_in_stone_42116'] = '{npc:126126} 旁边的柱子上。'
L['options_icons_carved_in_stone'] = '{achievement:13024}'
L['options_icons_carved_in_stone_desc'] = '显示 {achievement:13024} 成就中象形图画的位置。'

L['hoppin_sad_53419'] = '两棵树后面巨大树根下面。'
L['hoppin_sad_53420'] = '废墟内。'
L['hoppin_sad_53424'] = '悬崖上。'
L['hoppin_sad_53425'] = '瀑布旁边的树上。'
L['hoppin_sad_53426'] = '一些树根下。'

L['options_icons_hoppin_sad'] = '{achievement:13028}'
L['options_icons_hoppin_sad_desc'] = '显示 {achievement:13028} 成就中 {npc:143317} 的位置。'

-------------------------------------------------------------------------------
------------------------------- STORMSONG VALLEY ------------------------------
-------------------------------------------------------------------------------

L['in_basement'] = '在地下室。'
L['jakala_note'] = '和 {npc:140925} 交谈。'
L['nestmother_acada_note'] = '点击 {object:阿卡达之巢} 稀有出现。'
L['sabertron_note'] = '击杀 {npc:139334} 来激活 {npc:139328} 其中之一。'
L['whiplash_note'] = '只在 {wq:食肉笞} 激活时出现。'

L['discarded_lunchbox_note'] = '建筑物内书架顶上。'
L['hidden_scholars_chest_note'] = '建筑物屋顶上。'
L['honey_vat'] = '蜂蜜大桶'
L['smugglers_stash_note'] = '平台下面水中。'
L['sunken_strongbox_note'] = '船下面水中。'
L['venture_co_supply_chest_note'] = '爬上船上的梯子。'
L['weathered_treasure_chest_note'] = '此洞穴藏在一群树后面。'

L['curious_grain_sack'] = '奇怪的谷物袋'
L['small_treasure_chest'] = '小宝箱'
L['small_treasure_51927'] = '建筑物内楼梯下。'
L['small_treasure_51940'] = '建筑物内。'

L['eddie_fixit_note'] = '准备面对我的高度定制版改装机器人小队吧！'
L['ellie_vern_note'] = '但我有海洋中最强的生物为我而战，你根本不可能赢。'
L['leana_darkwind_note'] = '我怀疑这片大陆的奇怪生物也会带来奇怪的战斗。'

L['honeyback_harvester_note'] = '和 {npc:155193} 交谈开始事件。{object:新鲜的蜜胶块} 每小时可以拾取一次，一小时后重置。'
L['options_icons_honeybacks'] = '{npc:155193}'
L['options_icons_honeybacks_desc'] = '显示 {faction:2395} 声望的 {npc:155193} 事件位置。'

L['lets_bee_friends_note'] = '完成 {daily:53371} 七次后获得成就和宠物。并解锁日常：'
L['lets_bee_friends_step_1'] = '完成 {location:米登霍尔蜜酒庄} 任务线直到 {quest:50553}。'
L['lets_bee_friends_step_2'] = '在 {location:米登霍尔蜜酒庄} 击杀 {npc:133429} 和 {npc:131663} 直到找到 {item:163699}。'
L['lets_bee_friends_step_3'] = '把 {item:163699} 交给位于 {location:伯拉勒斯} 的 {npc:143128}。'
L['lets_bee_friends_step_4'] = '把 {item:163702} 交给位于 {location:米登霍尔蜜酒庄} 的 {npc:133907}。'
L['lets_bee_friends_step_5'] = '完成 {npc:133907} 的 {quest:53347}。'

local luncheon = (UnitFactionGroup('player') == 'Alliance') and '{npc:138221} 位于 {location:布伦纳丹}' or '{npc:138096} 位于 {location:战牙要塞}'
L['these_hills_sing_note'] = '在这里打开 {item:160485}。从' .. luncheon .. '购买或者从 {location:布伦纳丹} 的 {object:被丢弃的午餐盒} 拾取宝藏。'

L['ancient_tidesage_scroll'] = '古代海潮贤者卷轴'
L['ancient_tidesage_scroll_note'] = '阅读全部8个 {object:海潮贤者卷轴} 获得成就。'
L['options_icons_tidesage_legends'] = '{achievement:13051}'
L['options_icons_tidesage_legends_desc'] = '显示 {achievement:13051} 成就中古代卷轴的位置。'

L['long_forgotten_rum_note'] = '要进入洞穴，必须完成位于 {location:死亡浅滩} 的 {npc:134710} 的 {quest:50697}。{location:德鲁斯瓦} 的 {npc:137040} 也出售。'

-------------------------------------------------------------------------------
------------------------------- TIRAGARDE SOUND -------------------------------
-------------------------------------------------------------------------------

L['honey_slitherer_note'] = '和 {npc:137176} 交谈来召唤稀有。'
L['tempestria_note'] = '检查 {object:可疑的肉堆} 来召唤稀有。'
L['twin_hearted_note'] = '惊动 {object:仪式雕像} 来激活构造体。'
L['wintersail_note'] = '摧毁 {object:走私者的箱子} 来召唤船长。'

L['hay_covered_chest_note'] = '骑上 {npc:130350} 沿路往下走到达 {npc:131453} 来出现宝藏。'
L['pirate_treasure_note'] = [[
需要对应的藏宝图。

地图从任意的 {location:库尔提拉斯} 的海盗怪物掉落。{location:自由镇}（开放世界）是个海盗刷怪的好地点。
]]

local damp_note = '\n\n阅读全部五个卷轴以获得宝藏权限。'

L['damp_scroll'] = '受潮的卷轴'
L['damp_scroll_note_1'] = '入口在 {location:斯托颂修道院}。' .. damp_note
L['damp_scroll_note_2'] = '地下室 {npc:136343}后面的地上。' .. damp_note
L['damp_scroll_note_3'] = '楼上 {npc:136343} 旁边的地上。' .. damp_note
L['damp_scroll_note_4'] = '地下室 {npc:136343}旁边的地上。' .. damp_note
L['damp_scroll_note_5'] = '在木板路下的一个角落。' .. damp_note
L['ominous_altar'] = '不祥祭坛'
L['ominous_altar_note'] = '和 {object:不祥祭坛} 交谈会被传送到宝藏。'
L['secret_of_the_depths_note'] = '阅读全部五个 {object:受潮的卷轴}，然后和 {object:不祥祭坛} 交谈会被传送到宝藏。'

L['burly_note'] = '这些小家伙很奇怪，但确实强而有力。你确定要进行战斗？'
L['delia_hanako_note'] = '在我们开始之前，我想要提醒你，当我的队伍把你的碾压了之后，可不要哭鼻子。'
L['kwint_note'] = '一个人对一头鲨鱼，可能还算是一场公平的较量。但是一对三？你可真是疯了。'

L['shanty_fruit_note'] = '拾取 {object:布满灰尘的歌谱}，在小洞穴内的地面上。'
L['shanty_horse_note'] = '拾取 {object:痞子的歌谱}，在酒馆内的吧台上。'
L['shanty_inebriation_note'] = '拾取 {object:杰伊的歌谱}，在 {npc:141066} 后面地面上。'
L['shanty_lively_note'] = '拾取 {object:罗素的歌谱}，在壁炉架顶上。'
L['options_icons_shanty_raid'] = '{achievement:13057}'
L['options_icons_shanty_raid_desc'] = '显示 {achievement:13057} 成就中禁忌船歌的位置。'

L['upright_citizens_node'] = [[
每当 {wq:烂醉市民旅团} 突袭任务激活时，以下三个 NPC 之一就会出现。

· {npc:146295}
· {npc:145107}
· {npc:145101}

招募每个人来完成成就。突袭时期需要多次检查区域，世界任务和准确的 NPC 处于激活状态。
]]
L['options_icons_upright_citizens'] = '{achievement:13285}'
L['options_icons_upright_citizens_desc'] = '显示 {achievement:13285} 成就中 NPC 的位置。'

-------------------------------------------------------------------------------
------------------------------------ ULDUM ------------------------------------
-------------------------------------------------------------------------------

L['uldum_intro_note'] = '完成 {location:奥丹姆} 引导任务解锁稀有、宝藏及突袭任务！'

L['aqir_flayer'] = '与 {npc:163114} 和 {npc:154365} 共享出现点。'
L['aqir_titanus'] = '与 {npc:154353} 共享出现点。'
L['aqir_warcaster'] = '与 {npc:154352} 共享出现点。'
L['atekhramun'] = '踩死周围的 {npc:152765} 直到稀有出现。'
L['chamber_of_the_moon'] = '在 {location:月亮密室} 下面。'
L['chamber_of_the_stars'] = '在 {location:群星密室} 下面。'
L['chamber_of_the_sun'] = '在 {location:太阳密室} 里面。'
L['dunewalker'] = '点击平台上方的 {object:太阳精华} 释放它。'
L['friendly_alpaca'] = '每天可以喂食 {npc:162765} 一个 {item:174858}，7天(次)后会获得坐骑。在一个位置只出现10分钟，然后有一个较长的刷新时间。'
L['gaze_of_nzoth'] = '与 {npc:156890} 共享出现。'
L['gersahl_note'] = '用于喂食 {npc:162765} 七次后可以获得坐骑。不需要草药学。'
L['hmiasma'] = '喂食它周围的软泥直到激活。'
L['kanebti'] = '从 {npc:152427} 身上收集 {item:168160}，与一般的 {npc:151859} 共享出现。把雕像插入 {objcet:甲虫神龛} 召唤稀有。'
L['neferset_rare'] = '这六个稀有在尼斐塞特具有共享三个出现点。 完成召唤仪式事件后，将随机出现三个。'
L['platform'] = '出现在浮空平台顶部。'
L['right_eye'] = '掉落 {item:175140} 玩具的 {item:175142}。'
L['single_chest'] = '此宝箱只在一处出现！如果没有在这没有发现，等待一会儿将会刷新。'
L['tomb_widow'] = '当柱子上出现白色卵囊时，杀死看不见的蜘蛛召唤。'
L['uatka'] = '需要三个人分别同时点击 {npc:152777}，消耗一个 {item:171208} 出自 {object:阿玛塞特圣箱}。'
L['wastewander'] = '与 {npc:154369} 共享出现点。'

L['amathet_cache'] = '阿玛赛特之箱'
L['black_empire_cache'] = '黑暗帝国宝箱'
L['black_empire_coffer'] = '黑暗帝国宝匣'
L['infested_cache'] = '感染宝箱'
L['infested_strongbox'] = '感染的保险箱'
L['amathet_reliquary'] = '阿玛赛特圣箱'

L['options_icons_assault_events'] = '突袭事件'
L['options_icons_assault_events_desc'] = '显示可能的突袭事件的位置。'
L['options_icons_coffers'] = '上锁的箱子'
L['options_icons_coffers_desc'] = '显示上锁的箱子（每次突袭拾取一次）。'

L['ambush_settlers'] = '击败几波怪物直到事件结束。'
L['burrowing_terrors'] = '踩死 {npc:162073}。'
L['call_of_void'] = '净化仪式晶塔。'
L['combust_cocoon'] = '捡起自制火焰炸弹，然后丢到空中的卵上。'
L['dormant_destroyer'] = '点击全部虚空浮石水晶。'
L['executor_nzoth'] = '击杀 {npc:157680}，然后 摧毁 {object:执行者之锚}。'
L['hardened_hive'] = '拾取 {spell:317550} 然后烧毁所有的虫卵。'
L['in_flames'] = '拿起水桶扑灭火焰。'
L['monstrous_summon'] = '击杀全部 {npc:160914} 停止召唤。'
L['obsidian_extract'] = '摧毁所有虚化黑曜石水晶。'
L['purging_flames'] = '捡起尸体，丢进火里。'
L['pyre_amalgamated'] = '地上有个融合者的火堆，点击之后击杀小怪直到稀有出现。'
L['ritual_ascension'] = '击杀 {npc:152233}。'
L['solar_collector'] = '使收集器开启所有周边的全部5个模块。点击一个模块也会切换与它相邻的模块。'
L['summoning_ritual'] = '击杀侍战者后传送门关闭。几次事件完成后，{location:尼斐塞特} 周围将出现一组三种稀有怪。'
L['titanus_egg'] = '摧毁 {npc:163257}，然后击杀 {npc:163268}。'
L['unearthed_keeper'] = '摧毁 {npc:156849}。'
L['virnall_front'] = '击败几波怪物之后 {npc:152163} 出现。'
L['voidflame_ritual'] = '扑灭所有虚触蜡烛。'

L['beacon_of_sun_king'] = '向内旋转三个雕像。'
L['engine_of_ascen'] = '将四个雕像分别挡住激光。'
L['lightblade_training'] = '击杀导师和学徒直到 {npc:152197} 出现。'
L['raiding_fleet'] = '使用任务物品烧掉所有船只。'
L['slave_camp'] = '打开周围所有奴隶笼子。'
L['unsealed_tomb'] = '在几波怪中保护 {npc:152439}。'

-------------------------------------------------------------------------------
------------------------------------ VALE -------------------------------------
-------------------------------------------------------------------------------

L['vale_intro_note'] = '完成 {location:锦绣谷} 引导任务解锁稀有、宝藏及突袭任务！'

L['big_blossom_mine'] = '在 {location:繁盛矿洞} 里面，入口在东北方向。'
L['guolai'] = '在 {location:郭莱古厅} 里面。'
L['guolai_left'] = '进入 {location:郭莱古厅}（左侧通道）。'
L['guolai_center'] = '进入 {location:郭莱古厅}（中间通道）。'
L['guolai_right'] = '进入 {location:郭莱古厅}（右侧通道）。'
L['left_eye'] = '掉落 {item:175140} 玩具的 {item:175141}。'
L['pools_of_power'] = '在 {location:能量池} 中，入口在 {location:鎏金亭}。'
L['tisiphon'] = '点击 {object:丹妮尔的好运鱼竿}。'

L['ambered_cache'] = '琥珀宝箱'
L['ambered_coffer'] = '琥珀制成的箱子'
L['mogu_plunder'] = '魔古掠夺品'
L['mogu_strongbox'] = '魔古保险箱'

L['abyssal_ritual'] = '击杀 {npc:153179} 之后再杀 {npc:153171}。'
L['bound_guardian'] = '击杀3个 {npc:154329} 解救 {npc:154328}。'
L['colored_flames'] = '从火把上收集彩色火焰，并带到相符的符文上。'
L['construction_ritual'] = '将老虎雕像推入光线中。'
L['consuming_maw'] = '净化生长物和触须，直到被踢出。'
L['corruption_tear'] = '抓住 {spell:305470}，在不让旋转的眼睛撞到你的情况下关闭眼泪。'
L['electric_empower'] = '击杀 {npc:153095}，然后击杀 {npc:156549}。'
L['empowered_demo'] = '关闭所有精神补给品。'
L['empowered_wagon'] = '捡起 {npc:156300} 然后放在强化的战车下面。'
L['feeding_grounds'] = '销毁琥珀容器和静滞容器。'
L['font_corruption'] = '旋转魔古雕像将光束连接到泰坦控制台左右两边的小圆柱上，然后点击泰坦控制台。'
L['goldbough_guardian'] = '从多波怪中保护 {npc:156623}。'
L['infested_statue'] = '把眼睛从雕像上拽开。'
L['kunchong_incubator'] = '摧毁所有力场生成器。'
L['mantid_hatch'] = '拾取 {spell:305301} 烧毁所有螳螂妖虫卵。'
L['mending_monstro'] = '摧毁所有愈疗琥珀。'
L['mystery_sacro'] = '摧毁全部可疑的墓碑，然后击杀 {npc:157298}。'
L['noodle_cart'] = '在 {npc:157615} 修理购物车时保卫他。'
L['protect_stout'] = '从多波怪物中保护洞穴。'
L['pulse_mound'] = '击杀周围全部怪物，然后击杀 {npc:157529}。'
L['ravager_hive'] = '摧毁树上全部蜂巢。'
L['ritual_wakening'] = '击杀 {npc:157942}。'
L['serpent_binding'] = '击杀 {npc:157345}，然后击杀 {npc:157341}。'
L['stormchosen_arena'] = '清除竞技场全部怪物，然后击杀氏族将军。'
L['swarm_caller'] = '销毁虫群召唤器。'
L['vault_of_souls'] = '打开宝库，摧毁所有雕像。'
L['void_conduit'] = '点击虚空浮石后去踩眼睛。'
L['war_banner'] = '燃烧战旗然后杀怪，直到指挥官出现。'
L['weighted_artifact'] = '拾取 {object:沉得出奇的花瓶} 并迷宫返回到基座。被雕像晕住花瓶会掉。'

-------------------------------------------------------------------------------
----------------------------------- VISIONS -----------------------------------
-------------------------------------------------------------------------------

L['colored_potion'] = '彩色药水'
L['colored_potion_note'] = [[
%s尸体旁边的药水始终暗示进程中负面效果药水的颜色。

+100理智药水的颜色可以由该药水的颜色确定（|cFFFF0000坏|r => |cFF00FF00好|r）：

黑 => 绿
蓝 => 紫
绿 => 红
紫 => 黑
红 => 蓝
]]

L['bear_spirit_note'] = '击杀 {npc:160404} 和全部波数怪物获得10%急速增益。'
L['buffs_change'] = '可用增益每次更换。如果建筑物关闭或没有 NPC 与物体，则本次没有此增益。'
L['clear_sight'] = '需要 {spell:307519} 等级%d。'
L['craggle'] = '丢下一个玩具到地上（比如 {item:44606}）分散他的注意力。拉开并优先击杀机器人。'
L['empowered_note'] = '穿过地雷阵并站在楼上的 {npc:161324} 获得10%伤害增益。'
L['enriched_note'] = '击杀 {npc:161293} 获得10%爆击率增益。'
L['ethereal_essence_note'] = '击杀 {npc:161198} 获得10%爆击率增益。'
L['ethereal_note'] = '收集隐藏在整个视野中的橙色水晶，并将其交还给 {npc:162358} 以获取额外的纪念品。总共有10个水晶，每个区域2个。\n\n{note:别忘了拾取宝箱！}'
L['heroes_bulwark_note'] = '击杀旅店的 {npc:158588} 获得10%生命值增益。'
L['inside_building'] = '建筑物内。'
L['mailbox'] = '邮箱'
L['mail_muncher'] = '打开时，几率出现 {npc:160708}。'
L['odd_crystal'] = '怪异水晶'
L['requited_bulwark_note'] = '击杀 {npc:157700} 获得7%全能增益。'
L['shave_kit_note'] = '理发店内。拾取桌子上的箱子。'
L['smiths_strength_note'] = '击杀铁匠小屋的 {npc:158565} 获得10%伤害增益。'
L['spirit_of_wind_note'] = '击杀 {npc:161140} 获得10%急速和移动速度增益。'
L['void_skull_note'] = '点击地面上的骷髅拾取玩具。'

L['c_alley_corner'] = '在小巷的一个角落。'
L['c_bar_upper'] = '在酒吧内上层。'
L['c_behind_bank_counter'] = '在银行柜台后面的后面。'
L['c_behind_boss'] = '在难民建筑首领的后面。'
L['c_behind_boxes'] = '在一些箱子后面角落。'
L['c_behind_cart'] = '在一辆被毁的车后面。'
L['c_behind_house_counter'] = '在房子里的柜台后面。'
L['c_behind_mailbox'] = '在邮箱后面。'
L['c_behind_pillar'] = '隐藏在使馆建筑后面的柱子后面。'
L['c_behind_rexxar'] = '隐藏在 {npc:155098} 建筑后面的右侧。'
L['c_behind_stables'] = '在 {npc:158157} 马厩的后面。'
L['c_by_pillar_boxes'] = '在柱子和一些箱子之间的墙上。'
L['c_center_building'] = '在中心建筑的底层。'
L['c_forge_corner'] = '在锻造的角落。'
L['c_hidden_boxes'] = '隐藏在 {npc:152089} 建筑后面的一些箱子后面。'
L['c_inside_auction'] = '在拍卖行内右侧。'
L['c_inside_big_tent'] = '在大帐篷里的左边。'
L['c_inside_cacti'] = '在仙人掌叶片内附近角落。'
L['c_inside_hut'] = '在右边的第一个小屋内。'
L['c_inside_leatherwork'] = '在制皮建筑内。'
L['c_inside_orphanage'] = '在孤儿院里。'
L['c_inside_transmog'] = '在幻化小屋内。'
L['c_left_cathedral'] = '隐藏在大教堂入口左侧。'
L['c_left_inquisitor'] = '在审讯官小首领的后面阶梯左侧。'
L['c_on_small_hill'] = '在小山顶上。'
L['c_top_building'] = '在建筑物顶层。'
L['c_underneath_bridge'] = '在桥下。'
L['c_walkway_corner'] = '在上层行道的角落。'
L['c_walkway_platform'] = '在行道上面的平台上。'

L['options_icons_visions_buffs'] = '增益'
L['options_icons_visions_buffs_desc'] = '显示获得1小时伤害增益的事件位置。'
L['options_icons_visions_chest'] = '宝箱'
L['options_icons_visions_chest_desc'] = '显示惊魂幻象内可能的宝箱位置。'
L['options_icons_visions_crystals'] = '怪异水晶'
L['options_icons_visions_crystals_desc'] = '显示惊魂幻象内怪异水晶可能的位置。'
L['options_icons_visions_mail'] = '邮箱'
L['options_icons_visions_mail_desc'] = '显示 {item:174653} 坐骑的邮箱位置。'
L['options_icons_visions_misc'] = '杂项'
L['options_icons_visions_misc_desc'] = '显示惊魂幻象内稀有，玩具，药水和虚灵的位置。'

-------------------------------------------------------------------------------
----------------------------------- VOLDUN ------------------------------------
-------------------------------------------------------------------------------

L['bloodwing_bonepicker_note'] = '拾取山顶的 {npc:136390} 来召唤秃鹫。'
L['nezara_note'] = '切断拴在 {npc:128952} 上的绳子释放稀有。'
L['vathikur_note'] = '击杀 {npc:126894} 召唤稀有。'
L['zunashi_note'] = '入口在北方巨大头骨的嘴里。'

L['ashvane_spoils_note'] = '坐上 {npc:132662} 下山来出现下面的宝箱。'
L['excavators_greed_note'] = '在倒塌的隧道内。'
L['grayals_offering_note'] = '完成 {quest:50702} 后，进入 {location:阿图阿曼} 并点击 {object:上古祭坛} 宝箱出现。'
L['kimbul_offerings_note'] = '在 {location:吉布尔神殿} 上方的山上。'
L['sandsunken_note'] = '点击 {object:被遗弃的浮标} 把宝箱从沙子里拉出来。'

L['keeyo_note'] = '是时候开始一场精彩的冒险了！'
L['kusa_note'] = '我正保持连胜，你不可能战胜我和我的队伍。'
L['sizzik_note'] = '我一直很欣赏能和新的挑战者来一场精彩的战斗。'

L['tales_akunda_note'] = '在池塘里。'
L['tales_kimbul_note'] = '在枯树旁。'
L['tales_sethraliss_note'] = '在桌子旁边的地面上。'

L['plank_1'] = '沙漠边缘的山顶。'
L['plank_2'] = '损坏的建筑物旁边。'
L['plank_3'] = '在金字塔的一侧。路径从附近的另一个木板开始。'
L['plank_4'] = '在金字塔侧面的沙丘顶部。'
L['plank_5'] = '沿着蛇的尾巴找到木板。'
L['planks_ridden'] = '骑上摇晃的木板'
L['options_icons_dune_rider'] = '{achievement:13018}'
L['options_icons_dune_rider_desc'] = '显示 {achievement:13018} 成就中摇晃的木板的位置。'

L['options_icons_scavenger_of_the_sands'] = '{achievement:13016}'
L['options_icons_scavenger_of_the_sands_desc'] = '显示 {achievement:13016} 成就中垃圾物品的位置。'

L['elusive_alpaca'] = '将 {item:161128} 喂给 {npc:162681} 以获得坐骑。一个位置存在10分钟，很长时间出现。'

-------------------------------------------------------------------------------
---------------------------------- WARFRONTS ----------------------------------
-------------------------------------------------------------------------------

L['boulderfist_outpost'] = '进入 {location:石拳岗哨}（一个大洞穴）。入口在东北方。'
L['burning_goliath_note'] = '击杀后，一个 {npc:141663} 将在 {npc:141668} 附近出现。'
L['cresting_goliath_note'] = '击杀后，一个 {npc:141658} 将在 {npc:141668} 附近出现。'
L['rumbling_goliath_note'] = '击杀后，一个 {npc:141659} 将在 {npc:141668} 附近出现。'
L['thundering_goliath_note'] = '击杀后，一个 {npc:141648} 将在 {npc:141668} 附近出现。'
L['echo_of_myzrael_note'] = '一旦四个元素巨怪被击杀后，{npc:141668} 将出现。'
L['frightened_kodo_note'] = '几分钟后会消失。服务器重启后肯定出现。'

-------------------------------------------------------------------------------
----------------------------------- ZULDAZAR ----------------------------------
-------------------------------------------------------------------------------

L['murderbeak_note'] = '把鱼饵扔进海里，然后击杀数只 {npc:134780} 直到 {npc:134782} 出现。'
L['vukuba_note'] = '调查 {npc:134049}，然后击杀数波 {npc:134047} 直到 {npc:134048} 出现。'

L['cache_of_secrets_note'] = '瀑布后面的洞穴内一个 {npc:137234} 拿着。'
L['da_white_shark_note'] = '站在 {npc:133208} 附近直到她变为敌对。'
L['dazars_forgotten_chest_note'] = '路径开始于 {npc:134738} 附近。'
L['gift_of_the_brokenhearted_note'] = '放置熏香出现宝箱。'
L['offerings_of_the_chosen_note'] = '位于 {location:赞枢尔} 第二层。'
L['riches_of_tornowa_note'] = '在悬崖边上。'
L['spoils_of_pandaria_note'] = '在船的下层甲板。'
L['tiny_voodoo_mask_note'] = '在 {npc:141617} 棚子的上方。'
L['warlords_cache_note'] = '在船舵顶层。'

L['karaga_note'] = '我已经很久没战斗过了，不过我仍然很有机会战胜你。'
L['talia_spark_note'] = '这片大陆上的小动物很凶猛，我希望你准备好了。'
L['zujai_note'] = '你居然到我家来找我战斗？祝你好运。'

L['kuafon_note'] = [[
从 {location:赞达拉} 的任意 {npc:翼手龙} 拾取一个 {item:157782} 开始任务线。一些任务将花费数天来完成。

最好刷怪是 {location:赞枢尔} 的 {npc:126618} 或位于 {location:塔尔格拉布} 南侧 {location:裂天者林地} 的 {npc:122113}。
]]
L['torcali_note'] = '在 {location:战兽栏} 完成任务直到 {quest:47261} 变为可用。一些任务将花费数天来完成。'

L['totem_of_paku_note'] = '和 {location:巨擘封印} 北侧的 {npc:137510} 交谈选择帕库为你的祖达萨洛阿神灵。'
L['options_icons_paku_totems'] = '帕库图腾'
L['options_icons_paku_totems_desc'] = '显示 {location:达萨罗} 的 {npc:131154} 和他的旅行路径。'

L['tales_gonk_note'] = '在毯子上。'
L['tales_gral_note'] = '在树的根部。'
L['tales_jani_note'] = '在被毁的柱子上。'
L['tales_paku_note'] = '建筑物顶上，水旁边的岩石上。'
L['tales_rezan_note'] = '{npc:136428} 洞穴的上面。'
L['tales_shadra_note'] = '入口旁边，火炬后面。'
L['tales_torcali_note'] = '在几个桶和楼梯之间。'
L['tales_zandalar_note'] = '{npc:132989} 后面。'

local shared_dinos = '从 {npc:133680} 的任务线 {daily:50860} 日常必须激活（四个可能的日常之一）让他们出现，任何人可以在这些天看到他们。'
L['azuresail_note'] = '与 {npc:135512} 和 {npc:135508} 共享短刷新计时器。\n\n' .. shared_dinos
L['thunderfoot_note'] = '与 {npc:135510} 和 {npc:135508} 共享短刷新计时器。\n\n' .. shared_dinos
L['options_icons_life_finds_a_way'] = '{achievement:13048}'
L['options_icons_life_finds_a_way_desc'] = '显示 {achievement:13048} 成就中可怕恐龙的位置。'

-------------------------------------------------------------------------------
--------------------------------- ACROSS ZONES --------------------------------
-------------------------------------------------------------------------------

L['goramor_note'] = '从位于 {location:悲伤之地} 附近的小洞穴内的 {npc:126833} 购买一个 {item:163563} 并喂给 {npc:143644}。'
L['makafon_note'] = '从位于 {location:鳞商驿站} 的 {npc:124034} 购买一个 {item:163564} 并喂给 {npc:130922}。'
L['stompy_note'] = '从位于 {location:风花绿洲} 北侧的 {npc:133833} 购买一个 {item:163567} 并喂给 {npc:143332}。'
L['options_icons_brutosaurs'] = '{achievement:13029}'
L['options_icons_brutosaurs_desc'] = '显示 {achievement:13029} 成就中雷龙的位置。'

local hekd_note = '\n\n要获得 {npc:126334} 访问权限，必须完成任务 %s。'
if UnitFactionGroup('player') == 'Horde' then
    hekd_note = hekd_note:format('位于 {location:达萨罗} 的 {npc:127665} 的 {quest:47441} 然后是 {npc:126334} 的 {quest:47442}')
else
    hekd_note = hekd_note:format('位于 {location:沃顿} 的 {npc:136562} 的 {quest:51142} 然后是 {npc:136559} 的 {quest:51145}')
end
local hekd_quest = '从 {npc:126334} 完成任务 %s。' .. '|FFFF8C00'.. hekd_note ..'|r'
local hekd_item = '从垃圾堆附近的 %s 拾取 %s 并带给 {npc:126334}。' .. '|FFFF8C00'.. hekd_note ..'|r'

L['charged_junk_note'] = format(hekd_item, '{npc:135727}', '{item:158910}')
L['feathered_junk_note'] = format(hekd_item, '{npc:132410}', '{item:157794}')
L['golden_junk_note'] = format(hekd_item, '{npc:122504}', '{item:156963}')
L['great_hat_junk_note'] = format(hekd_quest, '{quest:50381}')
L['hunter_junk_note'] = format(hekd_quest, '{quest:50332}')
L['loa_road_junk_note'] = format(hekd_quest, '{quest:50444}')
L['nazwathan_junk_note'] = format(hekd_item, '{npc:131155}', '{item:157802}')
L['redrock_junk_note'] = format(hekd_item, '{npc:134718}', '{item:158916}')
L['ringhorn_junk_note'] = format(hekd_item, '{npc:130316}', '{item:158915}')
L['saurid_junk_note'] = format(hekd_quest, '{quest:50901}')
L['snapjaw_junk_note'] = format(hekd_item, '{npc:126723}', '{item:157801}')
L['vilescale_junk_note'] = format(hekd_item, '{npc:125393}', '{item:157797}')
L['options_icons_get_hekd'] = '{achievement:12482}'
L['options_icons_get_hekd_desc'] = '显示 {achievement:12482} 成就中 {npc:126334} 任务的位置。'

L['options_icons_mushroom_harvest'] = '{achievement:13027}'
L['options_icons_mushroom_harvest_desc'] = '显示 {achievement:13027} 成就中真菌人的位置。'

L['options_icons_tales_of_de_loa'] = '{achievement:13036}'
L['options_icons_tales_of_de_loa_desc'] = '显示 {achievement:13036} 成就中洛阿神灵传说的位置。'

L['jani_note'] = '点击 {object:神秘垃圾堆} 显露 {npc:126334}。'
L['rezan_note'] = '{note:位于 {location:阿塔达萨} 地下城。}'
L['bow_to_your_masters_note'] = '向 {location:赞达拉} 洛阿神灵 {emote:/鞠躬}，{emote:/bow}。'
L['options_icons_bow_to_your_masters'] = '{achievement:13020}'
L['options_icons_bow_to_your_masters_desc'] = '显示 {achievement:13020} 成就中洛阿神灵的位置。'

L['alisha_note'] = '此供应商需要 {location:德鲁斯瓦} 的任务进度。'
L['elijah_note'] = '此供应商需要 {location:德鲁斯瓦} 的任务进度。完成 {quest:47945} 后他开始出售香肠。'
L['raal_note'] = '{note:{location:维克雷斯庄园} 地下城内。}'
L['sausage_sampler_note'] = '品尝每种香肠获得成就。'
L['options_icons_sausage_sampler'] = '{achievement:13087}'
L['options_icons_sausage_sampler_desc'] = '显示 {achievement:13087} 成就中供应商的位置。'

-- For Horde, include a note about drinks that must be purchased on the AH
local horde_sheets = (UnitFactionGroup('player') == 'Horde') and [[ 以下饮料部落不提供，必须在拍卖行购买：

· {item:163639}
· {item:163638}
· {item:158927}
· {item:162026}
· {item:162560}
· {item:163098}
]] or ''
L['three_sheets_note'] = '获得所有饮料中的每一种获得成就。' .. horde_sheets
L['options_icons_three_sheets'] = '{achievement:13061}'
L['options_icons_three_sheets_desc'] = '显示 {achievement:13061} 成就中供应商的位置。'

L['options_icons_daily_chests_desc'] = '显示宝箱位置（每日可拾取）。'
L['options_icons_daily_chests'] = '宝箱'

L['supply_chest'] = '战争补给箱'
L['supply_chest_note'] = '一个 {npc:135181} 或 {npc:138694} 每隔45分钟就会在头顶飞过一次，并空投一个 {npc:135238} 到潜在可能的三个位置之一。'
L['supply_single_drop'] = '{note:该飞行路线总是将补给箱空投到此位置。}'
L['options_icons_supplies_desc'] = '显示 {npc:135238} 的空投位置。'
L['options_icons_supplies'] = '{npc:135238}'

L['secret_supply_chest'] = '秘密补给箱'
L['secret_supply_chest_note'] = '当阵营入侵激活时，{object:秘密补给箱} 可能短时间出现在这些位置之一。'
L['options_icons_secret_supplies'] = '秘密补给箱'
L['options_icons_secret_supplies_desc'] = '显示 {achievement:13317} 成就中 {object:秘密补给箱} 的位置。'

L['squirrels_note'] = '必须使用表情 {emote:/爱}，{emote:/love} 给非战斗宠物的小动物。'
L['options_icons_squirrels'] = '{achievement:14730}'
L['options_icons_squirrels_desc'] = '显示 {achievement:14730} 成就中小动物的位置。'

L['options_icons_battle_safari'] = '{achievement:12930}'
L['options_icons_battle_safari_desc'] = '显示 {achievement:12930} 成就中战斗宠物的位置。'
L['options_icons_mecha_safari'] = '{achievement:13693}'
L['options_icons_mecha_safari_desc'] = '显示 {achievement:13693} 成就中战斗宠物的位置。'
L['options_icons_nazja_safari'] = '{achievement:13694}'
L['options_icons_nazja_safari_desc'] = '显示 {achievement:13694} 成就中战斗宠物的位置。'

--SL

-------------------------------------------------------------------------------
---------------------------------- COVENANTS ----------------------------------
-------------------------------------------------------------------------------

L['covenant_required'] = '需要%s盟约成员。'
L['anima_channeled'] = '心能连接到%s。'

-------------------------------------------------------------------------------
--------------------------------- SHADOWLANDS ---------------------------------
-------------------------------------------------------------------------------

L['squirrels_note'] = '必须使用表情 {emote:/爱}，{emote:/love} 给非战斗宠物的小动物。'
L['options_icons_squirrels'] = '{achievement:14731}'
L['options_icons_squirrels_desc'] = '显示 {achievement:14731} 成就中小动物的位置。'

L['options_icons_safari'] = '{achievement:14867}'
L['options_icons_safari_desc'] = '显示 {achievement:14867} 成就中战斗宠物的位置。'

-------------------------------------------------------------------------------
--------------------------------- ARDENWEALD ----------------------------------
-------------------------------------------------------------------------------

L['deifir_note'] = '骑上圈内的稀有并使用 {spell:319566} 和 {spell:319575} 使其减速和昏迷。'
L['faeflayer_note'] = '瀑布后面隐藏的小洞穴内。'
L['gormbore_note'] = '在颤动地面上击杀 {npc:165420} 稀有出现。'
L['gormtamer_tizo_note'] = '在 {location:纱雾迷结} 击杀 {npc:蓟果精灵} 直到 {npc:164110} 出现。'
L['humongozz_note'] = '种植一个 {item:175247} 在 {object:潮湿的沃土} 将出现 {npc:164122}。区域内的许多怪物都掉落蘑菇。'
L['lehgo_note'] = '摧毁 {object:颤动的戈姆之卵} 并击杀 {npc:171827} 直到他出现。在洞穴内（入口在东南 {location:尘泥地穴} 内）。'
L['macabre_note'] = [[
有多个出现点。要召唤，和其他两名玩家站在 {object:神秘的蘑菇环} 上并相互跳舞。

· 玩家1与玩家2跳舞
· 玩家2与玩家3跳舞
· 玩家3与玩家1跳舞
]]
L['mymaen_note'] = '击杀区域内的 {npc:腐楠精灵} 直到他做出表情并出现。'
L['rainbowhorn_note'] = [[
找到并点击 {object:符文牡鹿的巨角} 来召唤稀有。角可以在 {location:炽蓝仙野} 多个地点出现。

他总是在 {location:瓦尔仙林} 北侧出现，所以设定 {item:6948} 到这里并留意区域的表情。

|cffff5400品|r|cffffaa00尝|r|cffffff00绝|r|cffaaff00妙|r|cff54ff00的|r |cff00ff55美|r|cff00ffa9丽|r|cff00ffff的|r |cff0055ff七|r|cff0000ff彩|r|cff5400ff之|r|cffaa00ff虹|r|cffff00ff好|r|cffff00aa味|r|cffff0054道|r|cffff0000！|r
]]
L['rootwrithe_note'] = '触碰 {npc:167928} 直到稀有出现。'
L['rotbriar_note'] = '和 {npc:171684} 交谈对话后在附近召唤稀有。'
L['slumbering_note'] = '跑到迷雾中将昏迷并被带出。使用信号弹或带 AOE 的宠物把他击出迷雾。'
L['skuld_vit_note'] = '在被障碍物阻挡的山洞中。法夜必须使用 {spell:310143} 进入洞穴。他进入战斗后，障碍物将消失。'
L['valfir_note'] = '在路径中途下坡点击 {object:闪光的心能之种} 并使用 {spell:338045} 移除他的 {spell:338038} 增益。'
L['wrigglemortis_note'] = '拉动 {npc:164179} 稀有出现。'

L['night_mare_note'] = [[
前往 {location:塞兹仙林}，并沿着西北悬崖的树根路前往破损的车。在那可以在地面上拾取 {item:181243}。

把此物品带给位于 {location:闪瀑盆地} 的 {npc:165704}。用10个 {item:173204} 和她交换一个 {item:181242}。{note:如果她不在这里，你必须完成 |cFFFFFD00戈姆蛴围栏的麻烦|r 和 |cFFFFFD00捣蛋的林鬼|r 任务线。}

接下来，和 {location:森林之心} 的 {npc:160262} 交谈兑换 {item:181242} 为 {item:178675}。如果你不是法夜的话，与守卫交谈让她出来。使用此物品得到 {spell:327083} 增益，可以让你看见 {npc:168135}。
]]

L['star_lake'] = '泊星剧场'
L['star_lake_note'] = [[
与舞台导演 {npc:171743} 交谈，会开启一场特殊的战斗。战斗每天会更换。

参加全部七场战斗会从 {npc:163714} 解锁 {item:180748}。
]]

L['cache_of_the_moon'] = '在 {location:魅夜花园} 收集 {npc:171360} 的五个遗失工具并组合它们制造 {item:180753}。交给她工具包后会施放 {spell:334353} 给你，可以让你看到宝箱。'
L['cache_of_the_night'] = '在整个区域收集 {item:180656}，{item:180654} 和 {item:180655} 组合它们制造 {item:180652}。'
L['darkreach_supplies'] = '跳上 {npc:169995} 并滑翔到西南方进入空心山峰到达 {object:魅夜宝箱} 宝藏上面。'
L['desiccated_moth'] = '跳上 {npc:169997} 滑翔到西北方的树的树枝上。在 {object:焚香炉} 燃烧 {item:180784} 后收集宝藏。'
L['dreamsong_heart'] = '使用 {npc:169997} 滑翔到东北方的树上。'
L['elusive_faerie_cache'] = '拾取 {spell:333923} 在 {location:暮辉林地} 的东北角并使用拾取宝箱。'
L['enchanted_dreamcatcher'] = '悬挂在树根顶上。从西侧往上跳最容易。'
L['faerie_trove'] = '位于平台下方。'
L['harmonic_chest'] = '需要两名玩家。一名玩家弹琴另一名玩家击鼓来解锁宝箱。'
L['hearty_dragon_plume'] = '在附近瀑布的顶部点击 {spell:333554}，然后用它向下漂浮到树枝上。'
L['old_ardeite_note'] = '在 {location:烁光林枝} 东南方击杀 {npc:160747} 和 {npc:160748} 得到 {item:174042}。使用此物品飞到附近稀有上面并标记它。'
L['swollen_anima_seed'] = '在树干里面的一颗大种子。'

L['playful_vulpin_note'] = [[
在 {npc:171206} 找到并使用正确的表情五次后获得宠物。

· 开始好奇的挖掘 = {emote:/好奇}，{emote:/curious}
· 仍然徘徊在无法坐下的地方 = {emote:/坐下}，{emote:/sit}
· 独自一人唱歌 = {emote:/唱歌} {emote:/sing}
· 欢乐地跳舞 = {emote:/跳舞}，{emote:/dance}
· 孤独悲伤的坐着 = {emote:/亲昵}，{emote:/pet}
]]

L['tame_gladerunner'] = '驯服的巡林者'
L['tame_gladerunner_note'] = [[
阅读 {object:缠结传说} 并跟随蓝色的灯穿过小径到达 {npc:171767}。击杀他并拾取 {npc:171699}。

如果走错路并且 {npc:171699} 消失当你到达最后，返回开始位置并再次阅读 {object:缠结传说} 尝试。如果 {npc:171767} 不在，需要等待它刷新。
]]

L['faryl_note'] = '让空中的生物来引领炽蓝仙野的防御。'
L['glitterdust_note'] = '炽蓝仙野的生物看起来可能很温顺，但他们会以有史以来最强勇士的力量和勇气来保卫自己的领地。你有那个实力吗？'

L['lost_book_note'] = '把失落的书籍交给 {location:伤忆林地} 的 {npc:165867}。'
L['options_icons_faerie_tales'] = '{achievement:14788}'
L['options_icons_faerie_tales_desc'] = '显示 {achievement:14788} 成就中失落的书籍的位置。'

L['options_icons_wild_hunting'] = '{achievement:14779}'
L['options_icons_wild_hunting_desc'] = '显示 {achievement:14779} 成就中炽蓝仙野的野兽的位置。'

L['options_icons_wildseed_spirits'] = '灵种精魂'
L['options_icons_wildseed_spirits_desc'] = '灵种精魂的奖励'

L['divine_martial_spirit'] = '神圣尚武精魂'
L['divine_dutiful_spirit'] = '神圣尽职精魂'
L['divine_prideful_spirit'] = '神圣骄傲精魂'
L['divine_untamed_spirit'] = '神圣狂野精魂'

L['martial_spirit_label'] = '{item:178874}'
L['dutiful_spirit_label'] = '{item:178881}'
L['prideful_spirit_label'] = '{item:178882}'
L['untamed_spirit_label'] = '{item:177698}'

L['0x_wildseed_root_grain'] = '0个 {item:176832}'
L['1x_wildseed_root_grain'] = '1个 {item:176832}'
L['2x_wildseed_root_grain'] = '2个 或 3个 {item:176832}'
L['4x_wildseed_root_grain'] = '4个 {item:176832}'

L['soulshape_cat_note'] = [[
目标为 {npc:181694} 并使用表情 {emote:/安抚}，{emote:/soothe}

可以出现在 {location:炽蓝仙野} 周围6棵大树顶端的中央：

· {location:梦歌沼泽}
· {location:闪瀑盆地}
· {location:瓦尔仙林}
· {location:冬日林谷}
· {location:心木林}
· {location:利爪之缘}
]]
L['soulshape_corgi_note'] = [[
目标为 {npc:174608} 并使用表情 {emote:/安抚}，{emote:/pet}

与 {npc:181582} 交谈时将立即可用柯基选项。
]]
L['soulshape_well_fed_cat_note'] = [[
1. 从 {location:暗湾镇} 收集 {item:187811}
2. 目标为 {npc:182093} 并使用表情 {emote:/喵}，{emote:/meow}
3. {emote:玛欧冲着你喵喵叫，显得很饿。}
4. 目标为 {npc:182093} 并使用 {item:187811}

与 {npc:181582} 交谈时将立即可用吃饱的猫之魂选项。
]]

-------------------------------------------------------------------------------
----------------------------------- BASTION -----------------------------------
-------------------------------------------------------------------------------

L['aegeon_note'] = '杀死周围地区的敌人，直到 {npc:171009} 作为增援出现。'
L['ascended_council_note'] = '与其他四名玩家，同时点击五个神庙的 {object:暮钟} 召唤 {location:候选者试练场} 的 {npc:170899}。'
L['aspirant_eolis_note'] = '拾取附近的 {item:180613} 并与 NPC 目标阅读激活他。'
L['baedos_note'] = '从周围地区带一桶 {object:发酵的莲榴果} 给 {npc:161536} 直到她激活。'
L['basilofos_note'] = '在岩石上移动，直到紫色的追踪标记出现在你的头顶。站着不动，等待四种表情出现，然后他会出现。'
L['beasts_of_bastion'] = '晋升堡垒之兽'
L['beasts_of_bastion_note'] = '和 {npc:161441} 交谈召唤四个野兽中的一个。'
L['bookkeeper_mnemis_note'] = '在地区有几率出现代替 {npc:166867} 单位。'
L['cloudfeather_patriarch_note'] = '在地区击杀 {npc:158110} 直到守护者与你作战。'
L['collector_astor_note'] = '阅读散落在房间里的全部六章 {object:梅希娅的传承}，之后和 {npc:157979} 交谈会得到 {spell:333779}。在西北周围地区找到隐藏的 {item:180569} 并交还稀有出现。'
L['corrupted_clawguard_note'] = '在屋内或 {location:炉火岗哨} 山上拾取 {item:180651} 并使用它修理 {npc:171300}。'
L['dark_watcher_note'] = '只在死亡后可以看到。和她交谈会在攻击前对你施展 {spell:332830}。'
L['demi_hoarder_note'] = '开始时堆叠99层 {spell:333874}，降低承受伤害。伤害后堆叠缓慢消失。稀有将沿着路径前进，如果到达终点则将消失。'
L['dionae_note'] = '当她变为免疫时，点击四个 {npc:163747} 打破她的护盾。'
L['herculon_note'] = [[
收集 {item:172451} 并使用给 {npc:158659} 堆叠 {spell:343531}。10层时，他将激活。

可以从房间内或室外的 {object:枯竭的心能之罐} 中收集微粒。

{note:不能在世界任务 {wq:突袭前庭} 期间击败。}
]]
L['reekmonger_note'] = '在 {location:勇气神庙} 击杀敌人直到 {npc:171327} 做出表情并降落。'
L['repair_note'] = '和两名其他玩家，点击 {object:上古熏香} 来召唤。'
L['sotiros_orstus_note'] = '点击 {object:黑色钟铃} 召唤稀有。'
L['sundancer_note'] = '点击雕像获得 {spell:332309} 增益，然后使用 {item:180445} 滑翔到稀有并骑上它。'
L['swelling_tear_note'] = '点击 {npc:171012} 召唤三个稀有中的一个。裂隙可以在区域内的多个位置出现。'
L['unstable_memory_note'] = '当 {npc:171018} 存在时可以出现。拉一个 {npc:171018} 到其它会给它10层堆叠 {spell:333558}，把它变成稀有。'
L['wingflayer_note'] = '点击附近桌上的 {object:勇气号角} 召唤（东南方，楼梯上）。'

L['broken_flute'] = '击杀附近的 {npc:170009} 直到掉落 {item:180536}，使用此工具修理它。'
L['cloudwalkers_coffer'] = '云行者的宝匣'
L['cloudwalkers_coffer_note'] = '使用大型紫色花弹跳到平台上。'
L['experimental_construct_part'] = '拾取附近 {item:180534} 并使用修理部件。心能有多个出现地点。'
L['larion_harness'] = '位于 {location:野兽大厅} 内。'
L['memorial_offering'] = '在 {location:晋升堡垒} 多个位置之一找到 {npc:171526} 并购买 {item:180788}。将其放在靠近宝箱的饮料托盘中以获取 {item:180797}。'
L['scroll_of_aeons'] = '在中心地区拾取2个 {item:173973} 并将它们放在附近的 {object:贡品} 盘上显出宝藏。'
L['vesper_of_silver_wind'] = '银风暮钟'
L['vesper_of_silver_wind_note'] = '完成 {achievement:14339} 成就并和 {location:晋升高塔} 入口的 {npc:171732} 交谈铸造 {item:180858}。'

L['gift_of_agthia'] = '点击通往西北方断桥的火炬并携带 {spell:333320} 从火炬到火炬直到到达宝箱。点亮最后的火炬你会受益 {spell:333063}。'
L['gift_of_chyrus'] = '在宝箱前面跪下将被授予 {spell:333045}。'
L['gift_of_devos'] = [[
宝箱西南方一个火炬可以拾取获得 {spell:333912}。上坐骑，参加战斗或受到伤害将火焰会掉落。必须回到宝箱并将火焰放在 {object:虔诚的火盆} 以获取 {spell:333070}。

拾取火焰之前，清除宝箱前面的全部怪物。在运送火焰时，点击任意路上的 {npc:156571} 获得 {spell:335012} 负面效果提高移动速度。
]]
L['gift_of_thenios'] = [[
宝箱后面称为 {object:智慧之路}。这会指引一系列平台上不同的熏香进行沟通：

· {object:学识熏香}
· {object:耐心熏香}
· {object:洞察熏香}
· {object:审判熏香}

按耐心 => 学识 => 洞察的顺序沟通。在审判平台会出现 {object:审判之路} 的宝珠。

这个宝珠将把你带到真正的 {object:审判熏香}。与它沟通后最终飞行平台让你获得 {spell:333068} 打开宝箱。
]]
L['gift_of_vesiphone'] = '敲钟出现一个 {npc:170849} 并击杀获得 {spell:333239} 负面效果。宝箱正对面的流水将清洁此负面效果，并获得 {spell:332785}。'

L['count_your_blessings_note'] = '放置一个 {item:178915} 在 {object:贡品} 碗内获得祝福。'
L['options_icons_blessings'] = '{achievement:14767}'
L['options_icons_blessings_desc'] = '显示 {achievement:14767} 成就中 {object:贡品} 的位置。'

L['vesper_of_courage'] = '勇气暮钟'
L['vesper_of_humility'] = '谦逊暮钟'
L['vesper_of_loyalty'] = '忠诚暮钟'
L['vesper_of_purity'] = '纯洁暮钟'
L['vesper_of_wisdom'] = '历史暮钟'
L['vespers_ascended_note'] = '与其它四个暮钟同时点击此暮钟召唤 {location:候选者试练场} 的 {npc:170899}。'
L['options_icons_vespers'] = '{achievement:14734}'
L['options_icons_vespers_desc'] = '显示 {achievement:14734} 成就中暮钟的位置。'

L['anima_shard'] = '心能水晶碎片'
L['anima_shard_61225'] = '在桥下的较低平台上。'
L['anima_shard_61235'] = '在瀑布上方的壁架上。'
L['anima_shard_61236'] = '在主体结构中间的拱顶上。'
L['anima_shard_61237'] = '在水面上方的壁架上。'
L['anima_shard_61238'] = '在水中的一座小桥下。'
L['anima_shard_61239'] = '在小石柱上。'
L['anima_shard_61241'] = '在 {location:初思之厅} 入口上方。'
L['anima_shard_61244'] = '在悬崖边的一块岩石上。'
L['anima_shard_61245'] = '在小瀑布上方的岩石上。'
L['anima_shard_61247'] = '在墙上的小水装置上方。'
L['anima_shard_61249'] = '隐藏在 {location:纯洁之巅} 上层的石柱后面。'
L['anima_shard_61250'] = '位于在楼梯后面。'
L['anima_shard_61251'] = '位于在小铃铛下面。'
L['anima_shard_61253'] = '在一个下落的石拱道顶部。'
L['anima_shard_61254'] = '在一个小的木结构上。'
L['anima_shard_61257'] = '在正下方 {npc:162523} 的小壁架上。'
L['anima_shard_61258'] = '在 {location:英雄之眠} 下面的小壁架上。'
L['anima_shard_61260'] = '在平台下的地面上。'
L['anima_shard_61261'] = '在 {npc:163460} 洞穴上面的壁架上。'
L['anima_shard_61263'] = '在石柱上。'
L['anima_shard_61264'] = '在倾斜结构的顶部。'
L['anima_shard_61270'] = '位于在树的底部。'
L['anima_shard_61271'] = '在上层平台的一个书柜中。'
L['anima_shard_61273'] = '在突出悬崖正下方的壁架上。'
L['anima_shard_61274'] = '隐藏在平台下方。'
L['anima_shard_61275'] = '在 {location:野兽大厅} 一些桶的后面。'
L['anima_shard_61277'] = '在小石柱上。'
L['anima_shard_61278'] = '在岩石下的桥下。'
L['anima_shard_61279'] = '在小石柱上。'
L['anima_shard_61280'] = '在桌子的一角。'
L['anima_shard_61281'] = '在 {object:祭品} 宝藏上方的壁架上。'
L['anima_shard_61282'] = '在悬崖顶下的壁架上。'
L['anima_shard_61283'] = '{location:米莉的礼拜堂} 下面洞穴内，在桶后面。'
L['anima_shard_61284'] = '在岩石悬突下的壁架上，向南行。'
L['anima_shard_61285'] = '在一个小的岩石壁架的尽头。'
L['anima_shard_61286'] = '在俯瞰道路的壁架上。'
L['anima_shard_61287'] = '在小瀑布上方的壁架上。'
L['anima_shard_61288'] = '在小壁架的顶端。'
L['anima_shard_61289'] = '在凉亭上。'
L['anima_shard_61290'] = '在狭窄的岩石壁架的尽头。'
L['anima_shard_61291'] = '在的池塘底部雕像脚下。'
L['anima_shard_61292'] = '在石牌坊的顶部。'
L['anima_shard_61293'] = '在较低水平的细石柱上。'
L['anima_shard_61294'] = '隐藏在一堆桶后面。'
L['anima_shard_61295'] = '在书架上 {npc:156889} 后面。'
L['anima_shard_61296'] = '在倒下的大钟后面。\n\n{note:{location:通灵战潮} 地下城内。}'
L['anima_shard_61297'] = '在石柱后面。\n\n{note:{location:通灵战潮} 地下城内。}'
L['anima_shard_61298'] = '位于在躺椅后面。'
L['anima_shard_61299'] = '隐藏在大火炬的后面。'
L['anima_shard_61300'] = '挂在中央字体的壁架上。'
L['anima_shard_spires'] = '三个碎片位于 {location:晋升高塔} 地下城。'
L['options_icons_anima_shard'] = '{achievement:14339}'
L['options_icons_anima_shard_desc'] = '显示 {achievement:14339} 成就中全部50个 {object:心能水晶碎片}的位置。'

L['hymn_note'] = '在每个神庙中找到 {object:赞美诗} 并获得它的增益来获得成就。'
L['options_icons_hymns'] = '{achievement:14768}'
L['options_icons_hymns_desc'] = '显示 {achievement:14768} 成就中 {object:赞美诗} 的位置。'

L['stratios_note'] = '即便是最小规模的战斗也应该带着荣誉和谨慎而战。准备好以后就展示出你的队伍。'
L['thenia_note'] = '如此壮丽而开阔的平原。多么光荣的战场。你准备好了吗？'
L['zolla_note'] = '我们非常重视自身的防御。无论规模大小，我们都将全力维护和训练让晋升堡垒得以稳固的资源。'

L['soulshape_otter_soul'] = '目标为 {npc:181682} 并使用表情 {emote:/拥抱}，{emote:/hug}'

-------------------------------------------------------------------------------
----------------------------------- KORTHIA -----------------------------------
-------------------------------------------------------------------------------

L['carriage_crusher_note'] = '跟随 {npc:180182} 到 {location:噬渊} 并击败直到 {npc:180246} 进攻。'
L['chamber_note'] = '在 {object:远古传送器} 使用从 {npc:178257} 得到的 {item:186718} 到达宝箱。'
L['consumption_note'] = [[
此稀有吞噬40个 {npc:179758} 后变为蓝色阴影形态（稀有）后才会有掉落。

此稀有*继续*吞噬40个 {npc:179758} 后变为绿色阴影形态（稀有精英）将掉落额外的研究物品。

{note:{npc:179758} 在此稀有战斗中将不会出现并被吞噬。}
]]
L['darkmaul_note'] = '从 {object:入侵的渊菇} 收集 {item:187153} 并喂食给 {npc:180063}。必须完成事件10次获得坐骑。'
L['dislodged_nest_note'] = '点击附近的 {object:剧毒之蛾} 获得 {spell:355181}。给 {npc:178547} 使用额外动作按钮 {spell:355131} 获得控制并骑上它让其撞击巢穴所在的树干。'
L['escaped_wilderling_note'] = '点击 {npc:180014} 开始驯服事件。'
L['flayedwing_transporter_note'] = '点击 {npc:178633} 飞向和飞离 {location:绝密宝库}。'
L['fleshwing_note'] = '和 {npc:180079} 交谈开始收集事件。'
L['forgotten_feather_note'] = '从 {location:守护者的休憩} 跳下来到漂浮的一个小岛上。'
L['konthrogz_note'] = '在吞噬者的传送门事件中出现。事件可能在 {location:刻希亚} 许多地方出现。'
L['sl_limited_rare'] = '{note:此稀有某些天不可用。}'
L['krelva_note'] = '80% 血量会移动到其它平台，60% 血量会移动到主陆地。{note:你必须击杀稀有 60% 血量才能获得奖励！}'
L['kroke_note'] = '击杀区域内 {npc:179029} 直到他出现。{npc:179029} 不在的天内不会出现。'
L['maelie_wanderer'] = '{npc:179912} 将在当天固定位置出现。使用 {spell:355862} 他，需要6天交互，然后回到 {npc:179930} 获得坐骑。'
L['malbog_note'] = '和 {npc:179729} 交谈获得 {spell:355078} 并跟随脚印直到你找到 {object:血肉遗骸}。'
L['offering_box_note'] = '需要 {item:187033}，可以在附近废墟的西侧墙顶部找到。'
L['pop_quiz_note'] = '突击测验事件将在地图上随机出现。点击 {object:废弃的帷幕之杖} 并回答 {npc:180162} 的问题。'
L['razorwing_note'] = '交付区域内 {npc:吞噬者} 掉落的10个 {item:187054}。'
L['reliwik_note'] = '点击 {object:纯净的的刀翼兽之卵} 并击杀它。'
L['spectral_bound_chest'] = '幽魂束缚宝箱'
L['spectral_bound_note'] = '点击附近的3个 {object:幽魂钥匙} 解锁宝箱。'
L['stonecrusher_note'] = '和 {npc:179974} 交谈开始事件。'
L['towering_exterminator_note'] = '在渊誓传送门事件出现。事件可能在 {location:刻希亚} 许多地方出现。'
L['worldcracker_note'] = '和 {npc:180028} 交谈触发护送事件。'

L['archivist_key_note'] = '从 {npc:178257} 购买 %s 解锁。'
L['korthian_shrine_note'] = '点击神龛获得 {spell:352367} 可以看到隐藏的路径到达祭坛。'
L['num_research'] = '%d 研究'
L['plus_research'] = '+ 研究'
L['options_icons_relic'] = '{achievement:15066}'
L['options_icons_relic_desc'] = '显示成就中全部20个圣物的位置。'

L['rift_portal_note'] = [[
进入 {location:裂隙}，一个临时的 {location:刻希亚} 和 {location:噬渊} 位面内有额外的稀有，圣物和宝箱。

需要一个 {item:186731}，当你到达4级 {faction:2472} 可以在 {npc:178257} 处购买。钥匙也会有低概率从区域内稀有和宝箱中掉落。

{note:并非所有裂隙传送门在任何时间都处于激活状态。}
]]
L['rift_rare_only_note'] = '此稀有只在 {location:裂隙} 位面内可以见到和击杀。'
L['rift_rare_exit_note'] = [[
在 {location:裂隙} 位面内和此稀有互动将使其离开 {location:裂隙}。

三个 {location:裂隙} 稀有通常以大约20分钟的间隔按固定顺序出现：

  1. {npc:179913}
  2. {npc:179608}
  3. {npc:179911}
]]
L['options_icons_rift_portal'] = '{npc:179595}'
L['options_icons_rift_portal_desc'] = '显示 {npc:179595} 的位置可以进入 {location:裂隙}。'

L['riftbound_cache'] = '隙缚宝箱'
L['riftbound_cache_note'] = '这4个独立宝箱每个都可以出现在 {location:裂隙} 内的特定位置。'
L['options_icons_riftbound_cache'] = '隙缚宝箱'
L['options_icons_riftbound_cache_desc'] = '显示 {location:裂隙} 内 {object:隙缚宝箱} 的位置。'

L['invasive_mawshroom'] = '入侵的渊菇'
L['invasive_mawshroom_note'] = '这5个独立蘑菇每个都可以出现在特定位置。'
L['mawsworn_cache'] = '渊誓之箱'
L['mawsworn_cache_note'] = '这3个独立宝箱每个都可以出现在特定位置。'
L['pile_of_bones'] = '骨堆'
L['relic_cache'] = '圣物宝箱'
L['shardhide_stash'] = '碎皮贮藏'
L['korthia_shared_chest_note'] = '可以拾取5次获得圣物。进度每30分钟重置，使它们有效地不受限制。'
L['unusual_nest'] = '异常材料之巢'
L['unusual_nest_note'] = '全部5个巢每天都可以拾取。'

L['options_icons_invasive_mawshroom_desc'] = '显示 {object:入侵的渊菇} 的位置。'
L['options_icons_invasive_mawshroom'] = '入侵的渊菇'
L['options_icons_korthia_dailies_desc'] = '显示未标记 {object:圣物宝箱} 的位置。'
L['options_icons_korthia_dailies'] = '圣物宝箱'
L['options_icons_mawsworn_cache_desc'] = '显示 {object:渊誓之箱} 的位置。'
L['options_icons_mawsworn_cache'] = '渊誓之箱'
L['options_icons_nest_materials_desc'] = '显示 {object:异常材料之巢} 的位置。'
L['options_icons_nest_materials'] = '异常材料之巢'

-------------------------------------------------------------------------------
--------------------------------- MALDRAXXUS ----------------------------------
-------------------------------------------------------------------------------

L['chelicerae_note'] = '摧毁 {npc:159885} 后激活稀有。'
L['deepscar_note'] = '可能出现在 {location:伤逝剧场} 的多个入口。'
L['forgotten_mementos'] = '在宝藏西侧的房间拖拽宝库 {object:闸门之链} 打开大门。'
L['gieger_note'] = '攻击 {npc:162815} 后激活稀有。'
L['gristlebeak_note'] = '破坏附近的 {npc:162761} 后激活稀有。'
L['leeda_note'] = '击杀两个 {npc:162220} 直到稀有出现。'
L['nirvaska_note'] = '只在世界任务 {wq:致命提醒} 出现时激活。'
L['ravenomous_note'] = '踩死区域内 {npc:159901} 直到稀有出现。'
L['sabriel_note'] = '可以作为 {location:伤逝剧场} 的冠军之一出现。'
L['schmitd_note'] = '使用附近的 {spell:313451} 破坏他的护盾。'
L['tahonta_note'] = '此坐骑只会在 {npc:159239} 和你在一起时候才会掉落！'
L['taskmaster_xox_note'] = '与 {npc:160204}，{npc:160230} 和 {npc:160226} 共享出现。'
L['theater_of_pain_note'] = '每天第一次击杀首领有几率掉落坐骑。'
L['zargox_the_reborn_note'] = [[
使用 {item:175841} 位于 {npc:157124} 顶上。获得宝珠，你必须完成 {npc:157076} 的任务 {quest:57245} 之后再与他交谈。

假如 {npc:157124} 不在，复活区域内的 {npc:157132} 直到它出现。
]]
L['mixed_pool_note'] = [[
从周围怪物收集材料并扔进池中。每30个材料，根据所使用的组合，将出现七个稀有中的一个。

· 从北侧的 {npc:167923} 和 {npc:167948} 收集 {spell:306713}。

· 从南侧的 {npc:165015} 和 {npc:171142} 收集 {spell:306719}。

· 从南侧的 {npc:165027} 和 {npc:166438} 收集 {spell:306722}。

击杀每种稀有一次后获得 {item:183903} 玩具。
]]

L['blackhound_cache'] = '黑犬宝箱'
L['blackhound_cache_note'] = '在 {location:憎恶工厂} 召唤 {npc:157843}，然后护送他到 {location:黑犬岗哨}。'
L['bladesworn_supply_cache'] = '刃誓补给箱'
L['cache_of_eyes'] = '锐眼宝箱'
L['cache_of_eyes_note'] = '在 {location:盲眼堡垒} 有多个出现点。'

L['glutharns_note'] = '在软泥瀑布后面的一个山洞里。击杀 {npc:172485} 和 {npc:172479} 解锁宝箱。'
L['kyrian_keepsake_note'] = '检查 {npc:169664} 拾取宝藏。'
L['misplaced_supplies'] = '在巨大的蘑菇顶上。上山后跳上较小的棕色蘑菇，然后上山跳上巨大的蘑菇。'
L['necro_tome_note'] = '要进入塔楼，必须完成一个 {npc:166657} 的小任务线。在顶层的书柜里。'
L['plaguefallen_chest_note'] = [[
站在绿色软泥中（需要治疗！）获得10层 {spell:330069} 并会转化为 {spell:330092}。

转化后，到 {npc:158406} 平台（入口在东侧）下面洞穴并点击管道传送宝箱。
]]
L['ritualists_cache_note'] = '在地面上拾取 {item:181558} 并使用它完成 {object:装订仪式书}。'
L['runespeakers_trove_note'] = '东侧找到 {npc:170563} 并击杀他获得 {item:181777}。'
L['stolen_jar_note'] = '在多个不同的洞穴出现。'
L['strange_growth_note'] = '攻击 {npc:165037} 获得宝藏。'
L['vat_of_slime_note'] = '点击桌上的瓶子，然后点击软泥桶。'

L['giant_cache_of_epic_treasure'] = '巨大的史诗财宝箱'
L['spinebug_note'] = [[
快看！{spell:343124}！勇敢的冒险家快过去，这肯定不是诡计。等一下，那是卡拉赞的音乐吗？{npc:174663} 在这里干嘛…？

{spell:343163}!
]]

L['oonar_sorrowbane_note'] = [[
在 {location:伤逝剧场}，可以找到和 {item:181164} 附在一起的 {item:180273} 插在地上。拔出它们：

· 从 {location:雷文德斯} 的 {npc:171808} 购买一个 {item:182163}。
· 从 {location:玛卓克萨斯} 的 {npc:166640} 购买一个 {item:180771}。
· 从 {location:玛卓克萨斯} 的 {npc:169964} 购买一个 {item:181163}。
· 从西侧的世界任务 {wq:一路磕磕绊绊} 得到2层 {spell:306272}。
· 在 {location:格拉萨恩之腐} 吃4层 {spell:327367}。
· 迅速使用 {item:181163}，喝下两种药水并拉出大宝剑。

只拉出 {item:181164}，只需要4层 {spell:327367}。
]]

L['pet_cat'] = '亲昵该死的猫！'
L['hairball'] = '{note:只在 {location:凋魂之殇} 地下城内的 {location:腐烂圣所} 出现！}'
L['lime'] = '位于在大骨头拱顶上。'
L['moldstopheles'] = '绕到茎秆后面并跳上蘑菇平台。到达最后的平台，使用坐骑并在茎秆上跳来跳去到达。'
L['pus_in_boots'] = '在桥的下面。'

L['options_icons_slime_cat'] = '{achievement:14634}'
L['options_icons_slime_cat_desc'] = '显示 {achievement:14634} 成就中猫咪的位置。'

L['dundley_note'] = '我会一直战斗至胜利，并最终获得我应得的尊重！唯一的缺点就是我现在的东西都很黏。所有东西都黏糊糊的。'
L['maximillian_note'] = '为了一名配得上的对手，我已经等了几十年了。战利品全归胜利者所有！'
L['rotgut_note'] = '腐肠、残躯、更多碎块。来战吧。'

L['ashen_ink_label'] = '{item:183690}'
L['ashen_ink_note'] = '{npc:157125} 随机掉落。'

L['jagged_bonesaw_label'] = '{item:183692}'
L['jagged_bonesaw_note'] = '{npc:159105} 随机掉落。'

L['discarded_grimoire_label'] = '{item:183394}'
L['discarded_grimoire_note'] = '完成 {quest:62297} 后 {npc:174020} 给予。'

L['sorcerers_blade_label'] = '{item:183397}'
L['sorcerers_blade_note'] = '完成 {quest:62317} 后 {location:千魂窖} 内的 {object:巫师的笔记} 给予。下楼梯，在书柜的左边。'

L['mucosal_pigment_label'] = '{item:183691}'
L['mucosal_pigment_note'] = '任意软泥怪，小水滴，污泥，稀有，{location:凋零密院} 或 {npc:162727} 附近的巨怪周围掉落。'

L['amethystine_dye_label'] = '{item:183401}'
L['amethystine_dye_note'] = '完成 {quest:62320} 后 {npc:174120} 给予。'

L['ritualists_mantle_label'] = '{item:183399}'
L['ritualists_mantle_note'] = '完成 {quest:62308} 后 {npc:172813} 给予。需要3人召唤 {npc:174127}。'

L['options_icons_crypt_couture'] = '{achievement:14763}'
L['options_icons_crypt_couture_desc'] = '{achievement:14763} 成就中通灵助祭伪装定制的位置。'

L['soulshape_saurid_note'] = '小洞穴内。目标为 {npc:182105} 并使用表情 {emote:/鞠躬，{emote:/bow}'

-------------------------------------------------------------------------------
--------------------------------- REVENDRETH ----------------------------------
-------------------------------------------------------------------------------

L['amalgamation_of_filth_note'] = '当世界任务 {wq:脏活累活：爆破计划} 可做时点击一个 {object:垃圾箱} 并使用 {spell:324115} 进入水里。'
L['amalgamation_of_light_note'] = '移动全部三个 {object:镜子陷阱} 释放稀有。'
L['amalgamation_of_sin_note'] = '在世界任务 {wq:唤起罪业} 期间，拾取 {object:能量催化剂} 有机会获得 {item:180376} 并使用它召唤稀有。'
L['bog_beast_note'] = '世界任务 {wq:又脏又乱} 期间有几率出现后给 {npc:166206} 使用 {item:177880}。'
L['endlurker_note'] = '在 {location:微光裂隙} 顶上点击 {npc:165229} 尸体附近的 {object:心能之桩} 并使用 {spell:321826}。'
L['executioner_aatron_note'] = '击杀三个附近的 {npc:166715} 移除 {spell:324872}。'
L['executioner_adrastia_note'] = '解救周围地区 {npc:161299} 并保护他们直到消失。{npc:161310} 将最后出现并压制反叛。'
L['famu_note'] = '和 {npc:166483} 交谈触发事件。'
L['grand_arcanist_dimitri_note'] = '击杀四个 {npc:167467} 释放稀有。'
L['harika_note'] = '在 {location:惧谷镇} 西侧，拾取 {item:176397}，然后把箭交给 {npc:165327} 后和他交谈击落稀有。'
L['innervus_note'] = '击杀附近的 {npc:160375} 获得 {item:177223} 并打开墓穴。'
L['leeched_soul_note'] = '进入附近的墓穴。走到 {npc:165151} 附近开始事件。'
L['lord_mortegore_note'] = '击杀周围的怪物获得 {item:174378} 并使用它强化 {npc:161870}。所有四个徽记获得强化，稀有就会出现。'
L['madalav_note'] = '点击铁砧附近的 {object:马达拉夫的锤子} 召唤他。'
L['manifestation_of_wrath_note'] = '世界任务 {wq:蜂拥之魂} 的 {npc:169916} 恢复有几率出现稀有。'
L['scrivener_lenua_note'] = '返还 {location:禁忌图书馆} 的 {npc:160753}。'
L['sinstone_hoarder_note'] = '尝试拾取 {npc:162503} 后稀有会出现。'
L['sire_ladinas_note'] = '拾取附近的 {object:圣光残余} 并使用 {spell:313065} 给 {npc:157733}。'
L['soulstalker_doina_note'] = '跟随下楼并当她逃跑时穿过镜子。'
L['tomb_burster_note'] = '如果 {npc:155777} 被网困住会出现。击杀附近 {npc:155769} 和几波 {npc:155795} 直到稀有出现。'
L['worldedge_gorger_note'] = [[
从 {location:灾厄林} 和 {location:末日迷沼} 的 {npc:世界掠夺者}、{npc:吞噬者} 和 {npc:幼虫} 获得一个 {item:173939}。使用它点着 {object:界缘火盆} 召唤稀有。

有几率掉落一个 {item:180583}，然后开始七天任务线获得 {spell:333027} 坐骑。
]]

L['dredglaive_note'] = '在 {npc:173671} 尸体的桥下。'
L['forbidden_chamber_note'] = '在锁着的门前拾取一个 {object:被抛弃的心能之罐} 学习 {spell:340701}。使用它吸取五个附近的 {npc:173838}，然后在 {npc:173786} 前使用 {spell:340866}。'
L['gilded_plum_chest_note'] = '击杀在路上徘徊的 {npc:166680}。'
L['lost_quill_note'] = '从 {location:禁忌图书馆} 的桌上瓶子拾取 {item:182475}，然后把它交给外面拱门顶上的 {npc:173449}。'
L['rapier_fearless_note'] = '点击地上的 {object:无畏者的利剑}，然后击败 {npc:173603}。'
L['remlates_cache_note'] = '在 {location:暗湾镇} 墓穴后面的外墙上。'
L['smuggled_cache_note'] = '{bug:在拾取之前}：确认已完成 {quest:60480} 分支任务否则宝藏和任务将缺少40个 {currency:1820}。'
L['taskmaster_trove_note'] = '阅读 {object:出入口仪式} 然后小心地走到宝箱。'
L['the_count_note'] = '在 {location:末日迷沼} 获得99个 {currency:1820} 然后把它带给 {npc:173488}。'

L['forgotten_anglers_rod'] = '被遗忘的渔翁之竿'

L['loyal_gorger_note'] = '到 {location:末日迷沼} 完成 {npc:173498} 的每日任务七次将获得他的坐骑。'

L['sinrunner_note'] = '将食物和补给品给 {npc:173468} 共六天获得她的缰绳。她一次只出现几分钟。'
L['sinrunner_note_day1'] = '带 {location:西部荒野} 农场的8个 {item:182581} 给 {npc:173468}。'
L['sinrunner_note_day2'] = '从 {location:暗湾镇} 的 {npc:173570} 获得 {item:182585} 并梳理 {npc:173468}。'
L['sinrunner_note_day3'] = '在 {location:暗湾镇} 道路周围找到4个 {item:182595} 给 {npc:173468} 装配上。'
L['sinrunner_note_day4'] = '在 {npc:173570} 处拾取 {item:182620} 并填满 {location:晋升堡垒} 或 {location:炽蓝仙野} 的水。把 {item:182599} 给 {npc:173468}。'
L['sinrunner_note_day5'] = '从 {location:午夜集市} 的 {npc:171808} 用不同的肉换取 {item:182597}，给 {npc:173468} 装配上。'
L['sinrunner_note_day6'] = '从 {location:城墙巨洞} 的 {npc:167815} 购买3个 {item:179271}，喂食 {npc:173468}。'

L['options_icons_carriages'] = '马车'
L['options_icons_carriages_desc'] = '显示可骑乘马车的位置和路径。'
L['options_icons_dredbats'] = '{npc:161015}'
L['options_icons_dredbats_desc'] = '显示 {npc:161015} 的位置和路径。'
L['options_icons_sinrunners'] = '{npc:174032}'
L['options_icons_sinrunners_desc'] = '显示 {npc:174032} 的位置和路径。'

L['addius_note'] = '意志薄弱的生灵不该来浪费我的时间，不过如果你坚持的话，我会让你见识下真正的痛苦。'
L['eyegor_note'] = '艾戈尔准备战斗！'
L['sylla_note'] = '在这可怕的地方，谁也别指望能打出一场出色的战斗。但是，唉，我们就是在这么个地方。别再浪费我的时间了。'

L['avowed_ritualist_note'] = '把 {npc:160149} 带到这里赦免它们。'
L['fugitive_soul_note'] = '把此 {npc:160149} 带到 {npc:166150} 附近开始赦罪仪式。'
L['souls_absolved'] = '灵魂已赦免'
L['options_icons_fugitives'] = '{achievement:14274}'
L['options_icons_fugitives_desc'] = '显示 {achievement:14274} 成就中 {npc:160149} 的位置。'

L['grand_inquisitor_note'] = '把10个 {item:180451} 交给 {npc:160248} 有机会获得此罪碑。'
L['high_inquisitor_note'] = '把250个 {currency:1816} 交给 {npc:160248} 有机会获得此罪碑。'
L['inquisitor_note'] = '把100个 {currency:1816} 交给 {npc:160248} 有机会获得此罪碑。'
L['options_icons_inquisitors'] = '审判官'
L['options_icons_inquisitors_desc'] = '显示 {achievement:14276} 成就中审判官的位置。'

L['bell_of_shame_note'] = '每30分钟，{npc:176006} 旁边会随机生成一个幽灵。\n\n使用30个 {currency:1820} 修复 {npc:176056} 然后敲钟从激活的幽灵那里获得一个增益。\n\n幽灵其中之一，{npc:176043} 给予 {spell:346708} 提供增加 {location:赎罪大厅} 区域范围内 {item:172957} 掉率。'
L['atonement_crypt_label'] = '赎罪地穴'
L['atonement_crypt_note'] = '使用一个 {item:172957} 打开 {object:地穴之门}。'
L['atonement_crypts_opened'] = '赎罪地穴已打开'
L['atonement_crypt_key_label'] = '{item:172957}'
L['atonement_crypt_key_note'] = [[
{location:赎罪大厅} 区域范围内怪物掉落 {item:172957}。

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

最高掉率的是 {npc:158892}。
]]
L['options_icons_crypt_kicker'] = '{achievement:14273}'
L['options_icons_crypt_kicker_desc'] = '显示 {achievement:14273} 成就中刷怪的位置。'

L['broken_mirror'] = '残破的镜子'
L['broken_mirror_note'] = '每天将会激活一组3个 {object:残破的镜子}。使用一个 {item:181363} 修复每个镜子并打开其中的 {object:被遗忘的宝箱}。'
L['broken_mirror_crypt'] = '墓穴内。'
L['broken_mirror_elite'] = '有精英怪的小房间内。'
L['broken_mirror_group'] = '组'
L['broken_mirror_house'] = '房屋内。'
L['broken_mirror_61818'] = '有 {npc:173699} 的小房间内。'
L['broken_mirror_61819'] = '小房间内的一层。'
L['broken_mirror_61827'] = '小房间内。'
L['options_icons_broken_mirror'] = '残破的镜子'
L['options_icons_broken_mirror_desc'] = '显示 {object:残破的镜子} 的位置。'

L['soulshape_chicken_note'] = [[
1. 从 {location:暗湾镇} 收集 {item:187811}
2. 目标为 {npc:181660} 并使用表情 {emote:/小鸡}，{emote:/chicken}
3. {emote:失落之魂冲着你咯咯叫，显得很饿。}
4. 目标为 {npc:181660} 并使用 {item:187811}
]]
L['spectral_feed_label'] = '{item:187811}'
L['spectral_feed_note'] = [[
{item:187811} 用于喂食 {location:雷文德斯} 的 {npc:181660} 获得 {item:187813}

{item:187811} 用于喂食 {location:炽蓝仙野} 的 {npc:182093} 获得 |cFF00FF00[吃饱的猫之魂]|r

{note:{item:187811} 显示10分钟并需60分钟刷新。}
]]

-------------------------------------------------------------------------------
----------------------------------- THE MAW -----------------------------------
-------------------------------------------------------------------------------

L['return_to_the_maw'] = '重返 {location:噬渊}'
L['maw_intro_note'] = '从 {npc:162804} 开始指引任务线以解锁 {location:噬渊} 的稀有和事件。'

L['apholeias_note'] = '和3名其他玩家，站在平台的角落并施放 {spell:331783} 召唤稀有。'
L['dekaris_note'] = '在一块凸起的大岩石上。'
L['deomen_note'] = '进入密室南边的房间并激活锁控制以接近他。'
L['drifting_sorrow_note'] = '在悬浮宝珠附近击杀 {npc:175246} 激活首领。'
L['ekphoras_note'] = '和3名其他玩家，站在平台的角落并施放 {spell:330650} 召唤稀有。'
L['etherwyrm_note'] = '需要法夜突袭激活。击杀位于 {location:裂隙} 的 {npc:179030} 获得 {item:186190}。在 {location:荒芜洞窟} 洞穴（{location:裂隙} 以外）（当突袭未激活时在 {npc:175821} 处）的 {object:以太浮蛇囚笼} 使用钥匙。'
L['fallen_charger_note'] = '在区域范围内的大喊之后，它会选择两条路径中的任何一条，直到它到达 {location:刻希亚} 并在那里消失。'
L['ikras_note'] = '在 {location:破灭堡} 飞来飞去。这里是攻击他的好位置。'
L['lilabom_note'] = [[
收集全部5个部分完成宠物。一些部分可能在多个位置出现。

· {item:186183}
· {item:186184}
· {item:186185}
· {item:186186}
· {item:186187}
]]
L['orophea_note'] = '从东南方的拾取 {spell:337143} 并提供给 {npc:172577} 激活。'
L['sanngror_note'] = '如果他是不可攻击，等待直到他不再灵魂实验。'
L['sly_note'] = '和 {npc:179068} 交谈获得 {spell:353322} 增益并在3个不同的格里恩突袭找到 {npc:179096}。'
L['talaporas_note'] = '和3名其他玩家，站在平台的角落并施放 {spell:331800} 召唤稀有。'
L['valis_note'] = '按正确顺序点击三个 {npc:174810} 召唤稀有。顺序每次点击都会更换并且错误点击符文会受到伤害和负面效果 {spell:343636}。'
L['yero_note'] = '靠近 {npc:172862} 然后跟着他进入附近的一个山洞，在那里他变为敌对。'

L['exos_note'] = [[
击杀其他三个悲伤、痛苦和失落先驱收集他们的铭刻。

· {item:182328}
· {item:182326}
· {item:182327}

组合全部三个铭刻制造 {item:182329}，可以用来在 {location:统御祭坛} 召唤稀有。使用 {npc:173892} 到达上层。
]]

L['animaflow_teleporter_note'] = '激活即可直接前往 {location:噬渊} 其他位置。'
L['chaotic_riftstone_note'] = '激活 {spell:344157} 快速穿过 {location:噬渊}。'
L['venari_note'] = [[
使用 {currency:1767} 购买 {location:噬渊} 和 {location:托加斯特} 升级。

{note:帐号通用 {location:托加斯特} 升级在小号上显示不完整！}
]]
L['venari_upgrade'] = '{npc:162804} 升级'
L['torghast'] = '托加斯特'
L['Ambivalent'] = '纠结'
L['Appreciative'] = '欣赏'
L['Apprehensive'] = '防备'
L['Cordial'] = '和善'
L['Tentative'] = '犹豫'

L['stygian_cache'] = '冥殇宝箱'
L['stygian_cache_note'] = '每次出现只有一人可以拾取宝箱！'

L['box_of_torments_note'] = '在 {location:特玛库伦} 下面打开 {npc:173837}。'
L['tormentors_notes_note'] = '拾取 {npc:173811} 的尸体。'
L['words_of_warden_note'] = '检查一些罐子后面岩石上的 {object:碎纸}。'

-- Locations given relative to a map area name
L['nexus_area_calcis_branch'] = '位于 {location:白垩之地} 的水晶分叉上（使用锚点）'
L['nexus_area_calcis_crystals'] = '在 {location:白垩之地} 的一些青色水晶后面'
L['nexus_area_cradle_bridge'] = '{location:毁灭之源} 的桥下'
L['nexus_area_domination_bridge'] = '{location:统御祭坛} 南方的桥上'
L['nexus_area_domination_edge'] = '{location:统御祭坛} 的边上'
L['nexus_area_domination_room'] = '{location:统御祭坛} 楼顶的一个小房间里'
L['nexus_area_domination_stairs'] = '{location:统御祭坛} 的 {npc:173904} 旁边'
L['nexus_area_gorgoa_bank'] = '{location:戈尔格亚，聚魂之河} 河边'
L['nexus_area_gorgoa_middle'] = '就在河中央哟！'
L['nexus_area_gorgoa_mouth'] = '{location:戈尔格亚，聚魂之河} 河口'
L['nexus_area_perdition_wall'] = '{location:破灭堡} 的外墙边'
L['nexus_area_torment_rock'] = '{location:折磨平原} 的岩石上'
L['nexus_area_zone_edge'] = '沿着区域的边缘'
L['nexus_area_zovaal_edge'] = '{location:佐瓦尔的坩埚} 的边缘'
L['nexus_area_zovaal_wall'] = '{location:佐瓦尔的坩埚} 下面墙边'
-- Locations given relative to a named cave/cavern
L['nexus_cave_anguish_lower'] = '{location:苦楚之洞} 内（下层）'
L['nexus_cave_anguish_outside'] = '{location:苦楚之洞} 外'
L['nexus_cave_anguish_upper'] = '{location:苦楚之洞} 内（上层）'
L['nexus_cave_desmotaeron'] = '{location:渊狱} 外的小洞穴内'
L['nexus_cave_echoing_outside'] = '{location:回音之洞} 外'
L['nexus_cave_forlorn'] = '{location:荒弃之息} 洞穴内'
L['nexus_cave_howl_outside'] = '{location:死亡之嚎} 洞穴外的地面上'
L['nexus_cave_howl'] = '{location:死亡之嚎} 洞穴内'
L['nexus_cave_roar'] = '{location:死亡之哮} 洞穴内'
L['nexus_cave_roar_outside'] = '{location:死亡之哮} 洞穴外'
L['nexus_cave_ledge'] = '在壁架下方的一个小洞穴中'
L['nexus_cave_prodigum'] = '{location:浪骸之所} 的小洞穴内'
L['nexus_cave_soulstained'] = '{location:魂渍原野} 的小洞穴内'
L['nexus_cave_torturer'] = '{location:折磨者陋居} 内'
-- Locations given relative to a named NPC
L['nexus_npc_akros'] = '{npc:170787} 旁边的楼梯上'
L['nexus_npc_dekaris'] = '{npc:157964} 处山峰顶上'
L['nexus_npc_dolos'] = '{npc:170711} 后面的地面上'
L['nexus_npc_ekphoras'] = '{npc:169827} 的平台边上'
L['nexus_npc_eternas'] = '{npc:154330} 后面的地面上'
L['nexus_npc_incinerator'] = '{npc:156203} 下面的一个小窗台上'
L['nexus_npc_orophea'] = '{npc:172577} 旁边地面上'
L['nexus_npc_orrholyn'] = '{npc:162845} 的平台下面找到'
L['nexus_npc_portal'] = '{npc:167531} 后面的小石头上'
L['nexus_npc_talaporas'] = '{npc:170302} 的平台楼梯上'
L['nexus_npc_thanassos'] = '{npc:170731} 的平台后面'
L['nexus_npc_willbreaker'] = '{npc:168233} 后面的角落'
-- Locations given relative to the main path/road nearby
L['nexus_road_below'] = '在主干道下方的地面上'
L['nexus_road_cave'] = '在路下面的一个小山洞里'
L['nexus_road_mawrats'] = '在路边的一群噬渊鼠'
L['nexus_road_next'] = '主路旁'
L['nexus_room_ramparts'] = '在城墙下的一个小房间里'
-- Random locations described as best as possible
L['nexus_misc_crystal_ledge'] = '在一些青色水晶的岩石壁架上'
L['nexus_misc_floating_cage'] = '再漂浮的笼子上（使用锚点）'
L['nexus_misc_below_ramparts'] = '沿着城墙的底部'
L['nexus_misc_grapple_ramparts'] = '在城墙之上（使用锚点）'
L['nexus_misc_grapple_rock'] = '通过锚点到岩石上'
L['nexus_misc_ledge_below'] = '在窗台下的地面上'
L['nexus_misc_three_chains'] = '在地上的三个铁链'

L['stolen_anima_vessel'] = '失窃的心能容器'
L['hidden_anima_cache'] = '隐藏心能宝箱'
L['options_icons_anima_vessel'] = '失窃的心能容器'
L['options_icons_anima_vessel_desc'] = '显示突袭期间 {location:裂隙} 中 {object:失窃的心能容器} 位置。'

L['rift_hidden_cache'] = '隙隐宝箱'
L['options_icons_rift_hidden_cache'] = '隙隐宝箱'
L['options_icons_rift_hidden_cache_desc'] = '显示 {location:裂隙} 内 {object:隙隐宝箱} 的位置。'

L['options_icons_bonus_boss'] = '奖励精英'
L['options_icons_bonus_boss_desc'] = '显示奖励精英位置。'
L['options_icons_riftstone'] = '{npc:174962}'
L['options_icons_riftstone_desc'] = '显示 {object:混沌裂隙石} 传送位置。'
L['options_icons_grapples'] = '{npc:176308}'
L['options_icons_grapples_desc'] = '显示 {item:184653} 升级 {npc:176308} 的位置。'
L['options_icons_stygia_nexus'] = '冥殇枢纽'
L['options_icons_stygia_nexus_desc'] = '显示 {item:184168} 坐骑所需 {object:冥殇枢纽} 的位置。'
L['options_icons_stygian_caches'] = '冥殇宝箱'
L['options_icons_stygian_caches_desc'] = '显示获取额外冥殇的 {object:冥殇宝箱} 的位置。'

L['cov_assault_only'] = '只在%s突袭期间可用。'

L['helgarde_supply'] = '冥锋补给箱'
L['helgarde_supply_note'] = '在 {location:渊狱} 区域各处出现。你的 {npc:180598} 可以帮助你找到它们。'
L['options_icons_helgarde_cache'] = '冥锋补给箱'
L['options_icons_helgarde_cache_desc'] = '显示 {object:冥锋补给箱} 在 {location:渊狱} 区域可能出现的位置。'

L['mawsworn_cache_ramparts_note'] = '此宝箱在城墙顶上。使用锚点或 {npc:177093} 到它们那里。'
L['mawsworn_cache_tower_note'] = '此宝箱位于塔上并需要 {npc:177093} 到达。使用 {spell:349853} 技能爬上去。'
L['mawsworn_cache_quest_note'] = '{item:186573} 将只在你完成 {quest:63545} 任务后掉落！'

L['nilg_silver_ring_note'] = '在 {location:渊狱} 收集4个 {item:186727} 并使用它们打开 {object:统御封印之箱}。'
L['nilg_silver_ring_note1'] = '击杀 {npc:177444} 并打开 {item:186970}。'
L['nilg_silver_ring_note2'] = '拾取 {object:掠心者的钥匙链}，位于地下室房间 {npc:178311} 旁边的墙上。'
L['nilg_silver_ring_note3'] = '打 {location:渊狱} 区域内的 {object:冥锋补给箱}。你的 {npc:180598} 可以帮助你找到它们。'
L['nilg_silver_ring_note4'] = '反复击杀 {location:渊狱} 区域的 {npc:177134}（低掉率）。'
L['nilg_stone_ring_note'] = '在通灵领主突袭收集4个 {item:186600} 并在 {location:佐瓦尔的坩埚} 的任意 {npc:171492} 组合它们。'
L['nilg_stone_ring_note1'] = '在 {location:破灭堡} 城墙顶上的{object:渊誓之箱}（黄图标）内找到。'
L['nilg_stone_ring_note2'] = '完成 {quest:63545} 任务，然后拾取 {object:渊誓之箱} 直到你找到任务物品 {item:186573}。此任务可以共享！'
L['nilg_stone_ring_note3'] = '从 {location:破灭堡} 中央区域的 {npc:179601} 拾取。'
L['nilg_stone_ring_note4'] = '{location:破灭堡} 的 {npc:170634} 旁的地面上找到。你的 {npc:180598} 可以帮助你找到它们。'
L['nilg_gold_band_note'] = '使用锚点并跟着路径爬到山顶上。'
L['nilganihmaht_note'] = '你必须收集5个戒指带给位于 {location:裂隙} 的 {npc:179572}。'
L['calcis'] = '白垩之地'
L['desmotaeron'] = '渊狱'

L['zovault_note'] = '每天拖拽 {npc:179883} 到 {npc:179904} 必给裂隙石。'
L['options_icons_zovault'] = '{npc:179883}'
L['options_icons_zovault_desc'] = '显示 {npc:179883} 可能的位置。'

L['tormentors'] = '托加斯特折磨者'
L['tormentors_note'] = [[
折磨者事件每隔2小时整点出现。首领将总是按照下面列表顺序出现。

{item:185972} 每周只可以拾取一次，其中包含50个 {currency:1906}。
]]

L['options_icons_mawsworn_blackguard'] = '{achievement:14742}'
L['options_icons_mawsworn_blackguard_desc'] = '显示 for {achievement:14742} 成就中 {npc:183173} 的位置。'

L['mawsworn_blackguard'] = '渊誓黑衣卫士'
L['mawsworn_blackguard_note'] = '很容易切换目标为潜行的 {npc:183173}：'

L['options_icons_covenant_assaults'] = '盟约突袭'
L['options_icons_covenant_assaults_desc'] = '盟约突袭奖励'

L['assault_sublabel_US'] = '突袭更换于太平洋夏令时间周二上午8点和周五下午20点'
L['assault_sublabel_EU'] = '突袭更换于欧洲中部时间周二上午8点和周五下午20点'
L['assault_sublabel_CN'] = '突袭更换于中国标准时间周四上午7点和周日下午19点'
L['assault_sublabel_AS'] = '突袭更换于韩国标准时间周四上午8点和周日下午20点'

L['necrolord_assault'] = '{quest:63543}'
L['necrolord_assault_note'] = '{item:185992} 可在突袭期间拾取'
L['necrolord_assault_quantity_note'] = '打开 {object:渊誓之箱}'
L['venthyr_assault'] = '{quest:63822}'
L['venthyr_assault_note'] = '{item:185990} 可在突袭期间拾取'
L['venthyr_assault_quantity_note'] = '使用物品'
L['night_fae_assault'] = '{quest:63823}'
L['night_fae_assault_note'] = '{item:185991} 可在突袭期间拾取'
L['night_fae_assault_quantity_note'] = '打开 {object:隙隐宝箱}'
L['kyrian_assault'] = '{quest:63824}'
L['kyrian_assault_note'] = '{item:185993} 可在突袭期间拾取'
L['kyrian_assault_quantity_note1'] = '找到 {npc:179096}'
L['kyrian_assault_quantity_note2'] = '熔炉附近 {emote:/跳舞}，{emote:/dance}'

-------------------------------------------------------------------------------
---------------------- TORGHAST, THE TOWER OF THE DAMNED ----------------------
-------------------------------------------------------------------------------

L['torghast_the_tower_of_the_damned'] = '托加斯特，罪魂之塔'
L['torghast_reward_sublabel'] = '{note:大多数区域共享奖励}'
L['torghast_boss_note'] = '{location:托加斯特，罪魂之塔} 各种首领掉落。'
L['torghast_vendor_note'] = '供应商 {npc:152594} 和 {npc:170257} 出售，售价 300个 {currency:1728} 或 1,000个 {currency:1728}。'
L['torghast_reward_note'] = '{location:托加斯特，罪魂之塔} 全程获取'
L['torghast_soulshape_note'] = '12层以上'
L['colossal_umbrahide_mawrat_note'] = '13层以上'

L['skoldus_hall'] = '斯科杜斯之厅'
L['fracture_chambers'] = '断骨密室'
L['the_soulforges'] = '灵魂熔炉'
L['coldheart_interstitia'] = '凇心间隙'
L['mortregar'] = '莫尔特雷加'
L['the_upper_reaches'] = '上层区域'
L['adamant_vaults'] = '坚钢宝库'
L['twisting_corridors'] = '扭曲回廊'
L['the_jailers_gauntlet'] = '典狱长的挑战'

L['torghast_layer1'] = '完成1层'
L['torghast_layer2'] = '完成2层'
L['torghast_layer3'] = '完成3层'
L['torghast_layer4'] = '完成4层'
L['torghast_layer6'] = '完成6层'
L['torghast_layer8'] = '完成8层'

L['phantasma_note'] = '幻灭心能'
L['bloating_fodder_note'] = '鼓胀饲料爆裂'
L['flawless_master_note'] = '完成 |cffffff00[{achievement:15322}]|r'
L['tower_ranger_note'] = '完成 |cffffff00[{achievement:15324}]|r'

L['the_jailers_gauntlet_note'] = '{note:首领不计入} |cffffff00{achievement:14498}|r'

L['the_box_of_many_things'] = '万物之盒'
L['the_box_of_many_things_note'] = '{currency:1904} 解锁额外的能力'
L['many_many_things_section'] = '完成 |cffffff00[{achievement:15079}]|r'

L['the_runecarver'] = '{npc:164937}'
L['clearing_the_fog_suffix'] = '已解锁记忆'

-------------------------------------------------------------------------------
-------------------------------- ZERETH MORTIS --------------------------------
-------------------------------------------------------------------------------

local HIDDEN_ALCOVE = [[
访问 {location:%s凹室}：

1. 完成第6章 {location:扎雷殁提斯} 战役。
2. 找到 {object:%s凹室指向} %s。
3. 在 {location:共振群山}，击杀有 {spell:362651} 的怪物或站在白池中获得60层 {npc:183569}。
4. 使用 {location:孕育栖地} 内的 {npc:184329} 访问 {location:内室}。（需要30个 {npc:183569}）
5. 使用 {npc:184485} 访问 {location:%s凹室}。（需要30 {npc:183569}）
]]

L['camber_alcove_note'] = string.format(HIDDEN_ALCOVE, '拱曲', '拱曲', '在 {location:最终位点} 建筑物后面', '拱曲')
L['dormant_alcove_note'] = string.format(HIDDEN_ALCOVE, '休眠', '休眠', '位于 {location:共振群山}', '休眠')
L['fulgor_alcove_note'] = string.format(HIDDEN_ALCOVE, '灿烂', '灿烂', '位于 {location:共振群山}', '灿烂')
L['rondure_alcove_note'] = string.format(HIDDEN_ALCOVE, '圆弧', '圆弧', '在 {location:第三位点} 平台上', '圆弧')
L['repertory_alcove_note'] = string.format(HIDDEN_ALCOVE, '储备', '储备', '在 {location:陆相宝窟} 洞穴内', '储备')

L['corrupted_architect_note'] = '攻击 {npc:183958} 和 {npc:183961} 激活稀有。'
L['dune_dominance_note'] = '{achievement:15392} 成就中全部3个稀有精英在此位置出现。'
L['feasting_note'] = '有时会在返回该地点之前巡逻该区域。'
L['furidian_note'] = '激活区域内三个 {object:强化钥匙}，然后解锁 {object:可疑之怒宝箱}。'
L['garudeon_note'] = '从周围地区收集 {npc:183562} 并使用 {spell:362655} 喂食给 {npc:183554}。三个吃饱后，{npc:180924} 将激活。'
L['gluttonous_overgrowth_note'] = '摧毁周围全部 {npc:184048} 激活此稀有。'
L['helmix_note'] = [[
击杀区域内的 {npc:179005} 直到它做出表情并出现。

{emote:大地在震颤……有什么东西潜藏在地表之下！}
]]
L['hirukon_note'] = [[
引诱 {npc:180978} 到上面，需要制造一个 {item:187923}。

1. 在周围水域钓一个 {item:187662}。

2. 从 {location:赞加沼泽} 的盘牙水库 {object:刺鼻的团豚群} 内钓一个 {item:187915}。

3. 从 {location:纳沙塔尔} 的 {location:凯尔雅之墓} 飞行点附近的 {object:跳跳鱼群} 内钓一个 {item:187922}。

4. 从 {location:烁光海床} 的 {location:纳舒拉平台}（34.7, 75.0）二楼的平台拾取一个 {item:187916}（非常隐蔽）。

5. {npc:182194} 位于 {location:玛卓克萨斯} 的 {location:兵主之座} 的南边池塘。问她制作完成 {item:187923}。

6. 使用 {item:187923}，可以让你在 {npc:180978} 附近看到 {object:元水母群} 渔点15分钟。在此钓鱼会召唤 {npc:180978} 到上面。
]] -- Breaking my rule of no coords in the notes for this one
L['orixal_note'] = '与在该区域巡逻的 {npc:185487} 共享出现。'
L['protector_first_ones_note'] = '需要两名玩家。将匹配的符文带到每个控制台（在周围区域找到）来打开屏障。'
L['the_engulfer_note'] = '保护 {npc:183505} 直到 {npc:183516} 从裂隙中跳出。'
L['zatojin_note'] = '吸引附近的 {npc:183721} 并让你获得20层 {spell:362976} 直到你有 {spell:362983}。当你瘫痪时必须站在 {npc:183774} 尸体上，{npc:183764} 会注意你。'

L['architects_reserve_note'] = '完成位于 {location:朝圣者的恩典} {npc:180630} 的 {quest:64829} 任务线解锁宝藏。'
L['bushel_of_produce_note'] = '击杀1个 {npc:182368} 到北边它会被 {spell:360945} 获得自身增益。击杀更多 {npc:182368}（无需增益）直到你获得5层，然后击破门获得宝藏。'
L['crushed_crate_note'] = '拾取在宝藏上方倒下的柱子上的 {item:189767}。把它交给 {npc:185151} 换取 {item:189768} 可以打破坠落的岩石。'
L['domination_cache_note'] = '区域内的 {npc:181403} 和 {npc:182426} 有低几率掉落 {item:189704}。'
L['drowned_broker_supplies_note'] = '和 {npc:181059} 交谈控制附近的 {npc:185282}。'
L['forgotten_protovault_note'] = '只在 {wq:呱了} 世界任务期间可用。'
L['grateful_boon_note'] = '不能飞很难到达；使用 {spell:300728} 或 {spell:111771} 上山。安抚全部12个区域内生物和 {npc:185293} 将出现宝藏。'
L['library_vault_note'] = '在 {location:词汇岩窟} 点击石板直到找到正确的 {spell:362062} 增益来打开宝藏。'
L['mistaken_ovoid_note'] = '{location:维度瀑布} 洞穴内，需要收集5个 {item:190239} 然后带给 {npc:185280}。'
L['ripened_protopear_note'] = '开始 {quest:64641} 任务线获得 {location:繁花铸造厂} 访问权限。收集其中的5个 {spell:367180}（绿色云雾）并把它们给 {npc:185416} 授粉。'
L['sphere_treasure_note'] = '小心地跳上球体，直到到达宝藏。'
L['submerged_chest_note'] = '吸收南侧的 {object:危险的能量宝珠}，然后与宝藏附近的 {object:被遗忘的水泵} 互动。'
L['symphonic_vault_note'] = '检查 {npc:183998} 听到四个声音的序列。每个 {npc:183950} 在房间里播放单一的声音。按照匹配顺序与他们互动解锁宝藏。'
L['syntactic_vault_note'] = '解锁此宝藏，需要与 {location:初诞者圣墓} 区域的 {object:符文音节} 互动获得6层 {spell:367499}。'
L['template_archive_note'] = '推动房间内 {npc:183339} 到 {npc:183337} 打开路径到达宝藏。'
L['undulating_foliage_note'] = [[
按下四个 {npc:185390} 激活 {location:化生之庭} 中央房间的传送器。

· {object:化生之庭的锁} 外面的后边
· 庭院西南侧房间内
· {npc:181652} 南边的房间内
· 在庭院的东南房间内
]]

L['provis_cache'] = '锁住的供给扇区宝箱'
L['provis_cache_note'] = [[
完成 {npc:177958} 的 {quest:64717} 日常任务至少一次。

在各处的锻炉使用 {item:187516} 收集15个 {item:187728} 并组合为 {item:187787}。宝珠中可能包含钥匙。
]]
L['prying_eye_discovery'] = '窥探之眼的发现'
L['prying_eye_discovery_note'] = '飞行解锁后容易到达。'
L['pulp_covered_relic'] = '被粘浆覆盖的圣物'
L['requisites_originator_note'] = [[
一台每周会给你不同奖励的机器：

· {spell:366667} = 附魔材料和金币
· {spell:366668} = 心能
· {spell:366669} = 密文
· {spell:366670} = 源生微粒和 {item:189179} （几率）
· {spell:366671} = 密文/微粒/心能
· {spell:366672} = 密文装备
]]
L['rondure_cache'] = '圆弧宝箱'
L['rondure_cache_note'] = '位于 {location:圆弧凹室} 内跳跃迷宫到顶部的可交互锻炉。'
L['sandworn_chest'] = '沙蚀宝箱'
L['sandworn_chest_note'] = '从区域内怪物拾取5个 {item:190198} 组合成 {item:190197}。'
L['sand_piles'] = '沙堆'
L['sand_piles_note'] = [[
全部沙堆在隐藏的 {location:休眠凹室} 内找到。每个沙堆需要一个 {item:189863}，可以在该区域的其它宝藏中找到：

· 统御之箱
· 陨落宝箱
· 被窃的神器
· 被盗的卷轴
· 水下的宝箱
· 交响宝箱
· 波动植物
]]
L['torn_ethereal_drape'] = '破旧的虚渺披风'
L['torn_ethereal_drape_note'] = '在 {location:灿烂凹室} 内找到。激活 {object:自动体控制台}，然后骑上 {npc:183565} 到达天花板。'

L['cache_avian_nest'] = '元鸟之巢'
L['cache_cypher_bound'] = '密文束缚的宝箱'
L['cache_discarded_automa'] = '被抛弃的自动体残片'
L['cache_forgotten_vault'] = '被遗忘的宝库'
L['cache_mawsworn_supply'] = '渊誓补给宝箱'
L['cache_tarachnid_eggs'] = '元蛛卵'
L['cache_shrouded_cypher'] = '氤氲密文宝箱'
L['cache_shrouded_cypher_note'] = [[
这些宝箱只在有 {spell:361917} 增益和装备一件适当的密文装备物品时能看到：

{note:强化 {npc:181059} 的观察力，使其可以发现额外的隐藏宝箱。}
]]

L['cache_cantaric'] = '声乐宝箱'
L['cache_fugueal'] = '赋格宝箱'
L['cache_glissandian'] = '滑音宝箱'
L['cache_mezzonic'] = '中音宝箱'
L['cache_toccatian'] = '弹奏宝箱'

L['schematic_treasure_note'] = '{note:如果尚未解锁合成，此宝藏将不包含原生体结构图。如果您已经拾取了宝藏，会在附近的地面上找到结构图。}'
L['schematic_treasure_mount_note'] = '{note:此结构图在附近的一次性宝藏中找到。如果在解锁坐骑合成之前打开宝藏，结构图会在这里找到。}'
L['schematic_treasure_pet_note'] = '{note:此结构图在附近的一次性宝藏中找到。如果在解锁宠物合成之前打开宝藏，结构图会在这里找到。}'
L['schematic_bronze_helicid_note'] = '每周任务 {quest:65324} 的 {item:190610} 内几率发现。'
L['schematic_ambystan_darter_note'] = '隐藏在 {npc:185312} 旁边的水下。'
L['schematic_bronzewing_vespoid_note'] = '{location:孕育栖地} 内。'
L['schematic_buzz_note'] = '{npc:185265} 内有几率发现。'
L['schematic_curious_crystalsniffer_note'] = '击败位于 {location:初诞者圣墓} 团队中的 {npc:184915} 后短时间可用。'
L['schematic_darkened_vombata_note'] = '浮空笼子内。'
L['schematic_deathrunner_note'] = '获得作为一部分 {spell:366367} 解锁任务线。'
L['schematic_desertwing_hunter_note'] = '位于柱顶。'
L['schematic_fierce_scarabid_note'] = '藏在 {npc:181870} 站立的平台下面。'
L['schematic_forged_spiteflyer_note'] = '元蜂蜂巢群上延伸。'
L['schematic_genesis_crawler_note'] = '{location:源生凹室} 入口顶上发现。'
L['schematic_goldplate_bufonid_note'] = '{npc:178803} 小几率掉落。'
L['schematic_heartbond_lupine_note'] = '{npc:179939} 小几率掉落。'
L['schematic_ineffable_skitterer_note'] = '自杀！不，确实需要灵魂状态可以看到位于 {location:流亡洞穴} 内的 {npc:185092}。'
L['schematic_leaping_leporid_note'] = '在一棵漂浮的树上发现。'
L['schematic_mawdapted_raptora_note'] = '位于 {location:无尽流沙} 的 {npc:181412} 小几率掉落。'
L['schematic_microlicid_note'] = '在浮空树最低的树枝上，在一些树叶下面。'
L['schematic_omnipotential_core_note'] = '{location:圆弧凹室} 内找到。结构图隐藏在房间西南侧拱门的上沿后面。'
L['schematic_prototickles_note'] = '附在 {npc:180978} 稀有上方藤蔓内的浮动链上。'
L['schematic_prototype_fleetpod_note'] = '{location:拱曲凹室} 内找到。和 {npc:184900} 互动开启小游戏。指引蜗牛穿过5个环而不接触 {npc:185455} 赢得结构图。'
L['schematic_raptora_swooper_note'] = '{location:塑形之厅} 内发现。'
L['schematic_resonant_echo_note'] = '{object:原初之歌的晶化回响} 内几率发现。'
L['schematic_russet_bufonid_note'] = '{item:187780} 巅峰宝箱内几率发现。'
L['schematic_scarlet_helicid_note'] = '在拱形建筑物顶上发现。'
L['schematic_serenade_note'] = '位于团队区域 {location:不朽休憩所} 一个浮动平台下方的链条上。'
L['schematic_shelly_note'] = '位于 {location:词汇岩窟} 书架的背面。需要传送技能才能爬上书架。'
L['schematic_stabilized_geomental_note'] = '{location:初诞者圣墓} 团队内 {npc:182169} 有几率掉落。'
L['schematic_tarachnid_creeper_note'] = '{location:无尽流沙} 的小型建筑物内。需要第5章战役进度清除巨石。'
L['schematic_terror_jelly_note'] = '位于坡道旁边的方形塔顶上。'
L['schematic_tunneling_vombata_note'] = '{location:魂灵音室} 建筑群内一条堵塞的隧道中的一些瓦砾旁边。'
L['schematic_vespoid_flutterer_note'] = '{location:共振群山} 的 {location:第一位点} 层一堆沙子上延伸。'
L['schematic_violent_poultrid_note'] = '{daily:65256} 日常任务有几率掉落。'

L['concordance_excitable'] = '可激发的索引台'
L['concordance_mercurial'] = '善变索引台'
L['concordance_tranquil'] = '宁静索引台'
L['concordance_note'] = '阅读每个索引解锁位于 {location:流亡洞穴} 的 {object:知识控制台} 条目。'

L['echoed_jiro_note'] = '耗费 {npc:181059} 能量获得临时增益。需要 {npc:181397} 的 {object:创音词} 研究。'

L['bygone_elemental_note'] = '{npc:181221} 可以代替区域内的任何 {npc:179007} 位置出现。'
L['dominated_irregular_note'] = '{npc:184819} 可以代替该区域内的任何 {npc:183184} 出现。'
L['gaiagantic_note'] = '只在 {npc:177958} 提供 {quest:64785} 日常任务时出现。'
L['misaligned_enforcer_note'] = '在此出现，巡逻该地区，然后在路线尽头消失。'
L['overcharged_vespoid_note'] = '可以代替区域内任何群体的一部分出现。'
L['runethief_xylora_note'] = '{location:朝圣者的恩典} 区域内潜伏出现。'

local proto_area = '有机会在周围的锻炉中找到 {object:%s}。'
L['proto_material_zone_chance'] = '有机会在该区域的精选锻炉中找到。'
L['anima_charged_yolk_note'] = '收集 {item:187728} 从任意锻炉并组合它们为一个 {item:187787}，有机会包含一个 {item:187890}。'
L['energized_firmament_note'] = string.format(proto_area, '共振群山')
L['honeycombed_lattice_note'] = string.format(proto_area, '蜂鸣悬崖')
L['incorporeal_sand_note'] = '有机会在该地区的沙漠区域的锻炉中找到。'
L['pollinated_extraction_note'] = string.format(proto_area, '不羁芳绿')
L['serene_pigment_note'] = '在 {location:流亡洞穴} 入口上方的锻炉中。可能需要多次尝试。'
L['volatile_precursor_note'] = '在顶部的较小锻炉中找到。可能需要多次尝试。'
L['wayward_essence_note'] = '{location:流亡洞穴} 后面浮空锻炉中。需站在锻炉凹处。'

L['patient_bufonid_note'] = '{location:扎雷殁提斯} 故事的进展直到 {npc:180950} 提供 {quest:65727}。每天完成任务，将 {npc:185798} 引出池塘。'
L['patient_bufonid_note_day1'] = '从区域内的元蜂收集15个 {item:190852}。'
L['patient_bufonid_note_day2'] = '从拍卖行购买30个 {item:172053}。'
L['patient_bufonid_note_day3'] = '从拍卖行购买200个 {item:173202}。'
L['patient_bufonid_note_day4'] = '从拍卖行购买10个 {item:173037}。'
L['patient_bufonid_note_day5'] = '从区域内的怪物收集5个 {item:187704}。'
L['patient_bufonid_note_day6'] = '从 {location:朝圣者的恩典} 附近的 {npc:185748} 购买5个 {item:190880}。'
L['patient_bufonid_note_day7'] = '从 {location:塔扎维什} 地下城的 {npc:180114} 购买1个 {item:187171}。'

L['lost_comb'] = '失落的蜂巢'
L['soulshape_penguin_note'] = '位于浮空锻炉顶部。'

L['coreless_automa'] = '无核自动体'
L['coreless_automa_note'] = '装备一个 {spell:364480} 物品将赋予 {npc:181059} 不消耗能量就能控制生物的能力，这将会获得成就更加快速。'
L['coreless_automa_warning'] = '{note:等待自动机真正开始跟随你然后让 {npc:181059} 离开，以避免导致需要你重新登录的错误。}'

L['olea_manu'] = '用 {currency:1979} 换取出售的收藏和食谱。'

L['venaris_fate_sublabel'] = '位于 {location:造物化生台}'
L['venaris_fate_note'] = [[
1. 在 {location:噬渊} 的 {location:威·娜莉的庇护所} 的虚体化 {npc:162804} 对话。
2. 如果她不是虚体，则需要额外的9.2故事进度。
3. 在 {location:扎雷殁提斯} 的 {location:造物化生台} 和 {npc:162804} 的尸体互动。
4. 5天后，将收到一封来自 {npc:162804} 的邮件以及 {item:192485}。
]]

L['options_icons_code_creature'] = '{achievement:15211}'
L['options_icons_code_creature_desc'] = '显示 {achievement:15211} 成就中生物的位置。'
L['options_icons_concordances'] = '知识索引'
L['options_icons_concordances_desc'] = '显示 {object:知识索引控制台} 的位置。'
L['options_icons_echoed_jiros'] = '回声机若'
L['options_icons_echoed_jiros_desc'] = '显示 {npc:回声机若} 提供增益的位置。'
L['options_icons_exile_tales'] = '{achievement:15509}'
L['options_icons_exile_tales_desc'] = '显示 {achievement:15509} 成就中传说的位置。'
L['options_icons_proto_materials'] = '{achievement:15229}'
L['options_icons_proto_materials_desc'] = '显示 {achievement:15229} 成就中稀有的原型材料的位置。'
L['options_icons_protoform_schematics'] = '原生体结构图'
L['options_icons_protoform_schematics_desc'] = '显示坐骑和宠物结构图的位置。'
L['options_icons_puzzle_caches'] = '谜题宝箱'
L['options_icons_puzzle_caches_desc'] = '显示 {object:谜题宝箱} 可能的位置。'
L['options_icons_zereth_caches'] = '密文宝箱'
L['options_icons_zereth_caches_desc'] = '显示 {object:密文宝箱} 可能的位置。'
L['options_icons_shrouded_cyphers'] = '氤氲密文宝箱'
L['options_icons_shrouded_cyphers_desc'] = '显示隐藏的 {object:氤氲密文宝箱} 可能的位置。'
L['options_icons_mawsworn_supply_cache'] = '渊誓补给宝箱'
L['options_icons_mawsworn_supply_cache_desc'] = '显示 {object:渊誓补给宝箱} 可能的位置。'
L['options_icons_coreless_automa'] = '{achievement:15542}'
L['options_icons_coreless_automa_desc'] = '显示 {achievement:15542} 成就中无核自动体的位置。'

L['ponderers_portal_label'] = '沉思者的传送门'
L['ponderers_portal_note'] = [[{item:190196} 可以在 {item:190177} 的帮助下找到，而 {item:190177} 可以从 {faction:开悟者} 声望的巅峰宝箱 {item:187780} 中拾取。

{note:一旦看到区域范围的表情，任何玩家都可以拾取传送门，而不仅仅是打开传送门的玩家。}

要打开传送门，六名玩家需要坐在 {location:扎雷殁提斯} 中心的 {location:冥世锻炉} 下水池周围的六角柱上并使用 {item:190177}。每个支柱都需要有一名玩家。]]

--DF

-------------------------------------------------------------------------------
-------------------------------- DRAGON ISLES ---------------------------------
-------------------------------------------------------------------------------

L['elite_loot_higher_ilvl'] = '{note:此稀有可以掉落高物品等级战利品！}'
L['gem_cluster_note'] = '所需物品需要 {faction:2507} 声望到达21级可以从 {object:探险队斥候的背包} 和 {object:翻动过的泥土} 中找到。'

L['options_icons_bonus_boss'] = '奖励精英'
L['options_icons_bonus_boss_desc'] = '显示奖励精英位置。'

L['options_icons_profession_treasures'] = '专业宝藏'
L['options_icons_profession_treasures_desc'] = '显示给予专业知识的宝藏位置。'

L['dragon_glyph'] = '巨龙魔符'
L['options_icons_dragon_glyph'] = '巨龙魔符'
L['options_icons_dragon_glyph_desc'] = '显示全部64个巨龙魔符的位置。'

L['dragonscale_expedition_flag'] = '龙鳞探险队旗帜'
L['flags_placed'] = '已插旗帜'
L['options_icons_flag'] = '{achievement:15890}'
L['options_icons_flag_desc'] = '显示 {achievement:15890} 成就中全部20个旗帜的位置。'

L['broken_banding_note'] = '在雕像的右脚脚踝上。'
L['chunk_of_sculpture_note'] = '巨龙雕像左侧地面上。'
L['dislodged_dragoneye_note'] = '在巨龙雕像胸口下的一块岩石上。'
L['finely_carved_wing_note'] = '巨龙雕像右膝下。'
L['fragment_requirement_note'] = '{note:在收集散落碎片之前，需要在 {location:翼眠大使馆} 的巨龙雕像询问 {npc:193915} 她在这里做什么。}'
L['golden_claw_note'] = '在巨龙雕像右后爪上。'
L['precious_stone_fragment_note'] = '在雕像的右脚下。'
L['stone_dragontooth_note'] = '巨龙雕像基座旁边的地面上。'
L['tail_fragment_note'] = '巨龙雕像的尾巴上。'
L['wrapped_gold_band_note'] = '巨龙雕像左后爪下。'
L['options_icons_fragment'] = '{achievement:16323}'
L['options_icons_fragment_desc'] = '显示 {achievement:16323} 成就中散落碎片的位置。'

L['options_icons_kite'] = '{achievement:16584}'
L['options_icons_kite_desc'] = '显示 {achievement:16584} 成就中 {npc:198118} 的位置。'

L['disturbed_dirt'] = '翻动过的泥土'
L['options_icons_disturbed_dirt'] = '翻动过的泥土'
L['options_icons_disturbed_dirt_desc'] = '显示 {object:翻动过的泥土} 可能的位置。'

L['scout_pack'] = '探险队斥候的背包'
L['options_icons_scout_pack'] = '探险队斥候的背包'
L['options_icons_scout_pack_desc'] = '显示 {object:探险队斥候的背包} 可能的位置。'

L['magicbound_chest'] = '魔缚宝箱'
L['options_icons_magicbound_chest'] = '魔缚宝箱'
L['options_icons_magicbound_chest_desc'] = '显示 {object:魔缚宝箱} 可能的位置。'
L['ice_bound_chest'] = '冰缚储物箱'

L['tuskarr_tacklebox'] = '海象人工具盒'
L['options_icons_tuskarr_tacklebox'] = '海象人工具盒'
L['options_icons_tuskarr_tacklebox_desc'] = '显示 {object:海象人工具盒} 可能的位置。'

L['squirrels_note'] = '必须使用表情 {emote:/爱}，{emote:/love} 给非战斗宠物的小动物。'
L['options_icons_squirrels'] = '{achievement:16729}'
L['options_icons_squirrels_desc'] = '显示 {achievement:16729} 成就中小动物的位置。'
L['options_icons_zaralek_squirrels'] = '{achievement:18361}'
L['options_icons_zaralek_squirrels_desc'] = '显示 {achievement:18361} 成就中小动物的位置。'

L['hnj_sublabel'] = '需要本地席卡尔洪荒狩猎'
L['hnj_western_azure_span_hunt'] = '死树顶上。'
L['hnj_northern_thaldraszus_hunt'] = '{note:需要快速过去，去晚了他会被野怪击杀！}'
L['options_icons_hemet_nesingwary_jr'] = '{achievement:16542}'
L['options_icons_hemet_nesingwary_jr_desc'] = '显示 {achievement:16542} 成就中 {npc:194590} 的位置。'

L['pretty_neat_note'] = '用自拍神器照相。'
L['pretty_neat_note_blazewing'] = '可以在 {location:奈萨鲁斯} 地下城中的 {npc:189901} 首领战斗中找到。'
L['options_icons_pretty_neat'] = '{achievement:16446}'
L['options_icons_pretty_neat_desc'] = '显示 {achievement:16446} 成就中鸟类的位置。'

L['large_lunker_sighting'] = '大家伙目击点'
L['large_lunker_sighting_note'] = '使用5个 {item:194701} 召唤 {npc:192919} 或稀有。'

L['options_icons_legendary_album'] = '{achievement:16570}'
L['options_icons_legendary_album_desc'] = '显示 {achievement:16570} 成就中传奇角色的位置。'

L['signal_transmitter_label'] = '龙洞发生器信号发射机'
L['signal_transmitter_note'] = '{note:需要10点机械头脑\n需要30点新奇玩物}\n\n与 {object:关闭的信号发射机} 互动后可以传送到此位置。'
L['options_icons_signal_transmitter'] = '龙洞发生器信号发射机'
L['options_icons_signal_transmitter_desc'] = '显示 {item:198156} 的 {object:关闭的信号发射机} 的位置。'

L['rare_14h'] = '此稀有与其他稀有构成14小时的循环，每30分钟出现一个稀有。\n\n下次出现：{note:%s}'
L['spawns_at_night'] = '{note:只可能在夜间出现。（服务器时间18:30之后）}'

L['elemental_storm'] = '元素风暴'
L['elemental_storm_thunderstorm'] = '雷暴'
L['elemental_storm_sandstorm'] = '沙暴'
L['elemental_storm_firestorm'] = '火焰风暴'
L['elemental_storm_snowstorm'] = '雪暴'

L['elemental_storm_brakenhide_hollow'] = '蕨皮山谷'
L['elemental_storm_cobalt_assembly'] = '钴蓝集所'
L['elemental_storm_imbu'] = '伊姆布'
L['elemental_storm_nokhudon_hold'] = '诺库顿要塞'
L['elemental_storm_ohniri_springs'] = '欧恩伊尔清泉'
L['elemental_storm_primalist_future'] = '拜荒者的未来'
L['elemental_storm_primalist_tomorrow'] = '拜荒者的未来'
L['elemental_storm_scalecracker_keep'] = '碎鳞要塞'
L['elemental_storm_slagmire'] = '熔渣沼泽'
L['elemental_storm_tyrhold'] = '提尔要塞'

L['elemental_overflow_obtained_suffix'] = '元素涌流已获得'
L['empowered_mobs_killed_suffix'] = '强化怪物已击杀'

L['elemental_storm_mythressa_note_start'] = '用 {currency:2118} 换取装备、宠物和坐骑。'
L['elemental_storm_mythressa_note_end'] = '当前有 %s {currency:2118}。'

L['options_icons_elemental_storm'] = '元素风暴'
L['options_icons_elemental_storm_desc'] = '显示元素风暴奖励。'

L['elusive_creature_note'] = '{object:制皮律法} 中 {object:精通等级 40/40} 将能够制造 {item:193906} 可以用来每天召唤和剥皮每个生物一次。'
L['options_icons_elusive_creature'] = '{item:193906}'
L['options_icons_elusive_creature_desc'] = '显示 {item:193906} 召唤的隐秘生物位置。'

L['grand_hunts_label'] = '洪荒狩猎'
L['longhunter_suffix'] = '狩猎进度已完成'
L['the_best_at_what_i_do_suffix'] = '首领已击杀'

L['options_icons_grand_hunts'] = '洪荒狩猎'
L['options_icons_grand_hunts_desc'] = '显示 {object:洪荒狩猎} 的位置和奖励。'

L['ancient_stone_label'] = '远古之石'
L['options_icons_ancient_stones'] = '{achievement:17560}'
L['options_icons_ancient_stones_desc'] = '显示 {achievement:17560} 成就中 {object:远古之石} 的位置。'

L['reed_chest'] = '苇草宝箱'
L['options_icons_reed_chest'] = '苇草宝箱'
L['options_icons_reed_chest_desc'] = '显示 {object:苇草宝箱} 可能的位置。'

L['dracthyr_supply_chest'] = '龙希尔补给箱'
L['options_icons_dracthyr_supply_chest'] = '龙希尔补给箱'
L['options_icons_dracthyr_supply_chest_desc'] = '显示 {object:龙希尔补给箱} 可能的位置。'

L['simmering_chest'] = '沸腾宝箱'
L['options_icons_simmering_chest'] = '沸腾宝箱'
L['options_icons_simmering_chest_desc'] = '显示 {object:沸腾宝箱} 可能的位置。'

L['frostbound_chest'] = '霜缚宝箱'
L['options_icons_frostbound_chest'] = '霜缚宝箱'
L['options_icons_frostbound_chest_desc'] = '显示 {object:霜缚宝箱} 可能的位置。'

L['war_supply_chest_note'] = '一个 {npc:135181} 每隔45分钟就会在头顶飞过一次，并空投一个 {npc:135238} 到潜在可能的几个位置之一。'
L['options_icons_war_supplies_desc'] = '显示 {npc:135238} 的空投位置。'
L['options_icons_war_supplies'] = '{npc:135238}'

L['fyrakk_assault_label'] = '菲莱克突袭'
L['fyrakk_secured_shipment'] = '夺得的货物'

L['shadowflame_forge_label'] = '暗影烈焰熔炉'
L['shadowflame_forge_note'] = '制作如下配方时需要:\n{spell:408282}'
L['shadowflame_blacksmithing_anvil_label'] = '暗影烈焰锻造铁砧'
L['shadowflame_blacksmithing_anvil_note'] = '制作如下配方时需要:\n{spell:408288}\n{spell:408326}\n{spell:408283}\n{spell:408052}'
L['shadowflame_leatherworking_table_label'] = '暗影烈焰制皮桌'
L['shadowflame_leatherworking_table_note'] = '制作如下配方时需要:\n{spell:406275}'
L['shadowflame_incantation_table_label'] = '暗影烈焰法咒桌'
L['shadowflame_incantation_table_note'] = '制作如下配方时需要:\n{spell:405076}'
L['altar_of_decay_label'] = '腐朽祭坛'
L['altar_of_decay_note'] = '制作如下配方时需要:\n{spell:110423}: \n腐朽图样\n腐朽注能材料\n\n{spell:264211}: \n毒素药水\n毒素瓶剂\n{spell:405879}'
L['azure_loom_label'] = '碧蓝织布机'
L['azure_loom_note'] = '制作如下配方时需要:\n{spell:376556}'
L['temporal_loom_label'] = '时光织布机'
L['temporal_loom_note'] = '制作如下配方时需要:\n{spell:376557}'
L['earthwarders_forge_label'] = '大地守护者的熔炉'
L['earthwarders_forge_note'] = '制作如下配方时需要:\n{spell:367713}'

L['dreamsurge_sublabel'] = '{note:只在 {location:梦涌} 在此区域处于活动状态时可用。}'
L['celestine_vendor_note'] = '用 {item:207026} 兑换坐骑，玩具，宠物和幻化装备。'
L['renewed_magmammoth_note'] = '从 {location:梦涌} 的最终首领收集20个 {item:209419} 并组合起来制造 {item:192807}。'

L['dragon_pepe_label'] = '巨龙佩佩'
L['dragon_pepe_note'] = '栖息在通往 {location:守护巨龙之座} 的楼梯左侧的柱子上。'
L['explorer_pepe_label'] = '探险家佩佩'
L['explorer_pepe_note'] = '栖息在 {location:龙鳞先遣营地} 的大帐篷顶部。'
L['tuskarr_pepe_label'] = '海象人佩佩'
L['tuskarr_pepe_note'] = '栖息在 {npc:196544} 和 {npc:187680} 附近的建筑物上。'

L['end_of_august'] = '{note:仅在八月底之前提供。}'

L['rich_soil_label'] = '肥沃的土壤'
L['rich_soil_note'] = '在 {location:巨龙群岛} 的 {object:肥沃的土壤} 中种植各种幼苗，发芽随机奖励。\n\n{item:200506} - 种植随机标准的 {location:巨龙群岛} 草药\n\n{item:200508} - 种植随机活力精华\n\n{item:200507} - 种植随机腐烂草药\n\n{item:200509} - 出现 {npc:198571} 以获得各种随机草药和精华'
L['options_icons_rich_soil'] = '肥沃的土壤'
L['options_icons_rich_soil_desc'] = '显示 {object:肥沃的土壤} 的位置。'

L['information_stuffed_clue'] = '满载信息的线索'
L['clued_in_note'] = '{npc:210079} 于事件 {note:盛大发掘}，以及世界任务 {wq:研究：……} 期间刷新。'
L['options_icons_clued_in'] = '{achievement:19787}'
L['options_icons_clued_in_desc'] = '显示成就 {achievement:19787} 中 {npc:210079} 的位置。'

L['goggle_wobble_note'] = '在引导任务线或世界任务 {wq:科技占卜：……} 期间，穿戴 {item:202247} 的同时与 {npc:207763} {emote:/跳舞}({emote:/dance})。'
L['options_icons_goggle_wobble'] = '{achievement:19791}'
L['options_icons_goggle_wobble_desc'] = '显示成就 {achievement:19791} 中 {npc:207763} 的位置。'

L['just_one_more_thing_note'] = '需要完成任一世界任务 {wq:研究：……} 3次。'
L['options_icons_just_one_more_thing'] = '{achievement:19792}'
L['options_icons_just_one_more_thing_desc'] = '显示 {achievement:19792} 的成就子项进度。'

-------------------------------------------------------------------------------
------------------------------- THE AZURE SPAN --------------------------------
-------------------------------------------------------------------------------

L['bisquis_note'] = '在 {location:伊斯卡拉} 的社区盛宴烹饪出传说品质的汤，然后击败 {npc:197557}。\n\n下次宴会：{note:%s}'
L['blightfur_note'] = '和 {npc:193633} 交谈开始召唤稀有。'
L['brackenhide_rare_note'] = '这些稀有以10分钟计时按固定轮次 {npc:197344} > {npc:197353} > {npc:197354} > {npc:197356} 出现。\n\n下次可能出现：{note:%s}'
L['fisherman_tinnak_note'] = '收集 {object:破损的鱼竿}，{object:扯烂的渔网} 和 {object:旧鱼叉} 后稀有出现。'
L['frostpaw_note'] = '拿上 {object:木槌} 后有20秒的时间去打 {object:树桩} 上的 {object:打豺狼人}，之后稀有出现。'
L['sharpfang_note'] = '帮助 {npc:192747} 击败 {npc:192748} 后稀有出现。'
L['spellwrought_snowman_note'] = '收集10个 {npc:193424} 并将它们带到 {npc:193242}。'
L['trilvarus_loreweaver_note'] = '收集 {object:吟歌碎片} 即可获得 {spell:382076} 并使用 {object:未充能的法器} 后稀有出现。'

L['breezebiter_note'] = '在周围天上盘旋，飞到他身边把他拉下来。出现点位于右侧洞穴。'

L['forgotten_jewel_box_note'] = '{item:199065} 可以从 {object:探险队斥候的背包} 和 {object:翻动过的泥土} 中找到。'
L['gnoll_fiend_flail_note'] = '{item:199066} 可以从 {object:探险队斥候的背包} 和 {object:翻动过的泥土} 中找到。'
L['pepper_hammer_note'] = '收集 {object:树液} 后使用 {object:棍子} 来引诱 {npc:195373}。\n\n{bug:（臭虫：点击棍子可能需要重新加载）}'
L['snow_covered_scroll'] = '积雪覆盖的卷轴'

L['pm_engi_frizz_buzzcrank'] = '站在神龛旁边。'
L['pm_jewel_pluutar'] = '建筑物内。'
L['pm_script_lydiara_whisperfeather'] = '坐在长凳上。'
L['pt_alch_experimental_decay_sample_note'] = '在一个绿色大锅里面。'
L['pt_alch_firewater_powder_sample_note'] = '在木屋外面花瓶旁边。'
L['pt_ench_enriched_earthen_shard_note'] = '在一堆石头上。'
L['pt_ench_faintly_enchanted_remains_note'] = '点击 {object:缺魔水晶簇} 出现并杀死一个怪物。然后拾取出现的水晶。'
L['pt_ench_forgotten_arcane_tome_note'] = '在坟墓入口右侧的地板上。'
L['pt_jewel_crystalline_overgrowth_note'] = '在一个小池塘旁边。'
L['pt_jewel_harmonic_crystal_harmonizer_note'] = '点击 {object:共鸣钥匙} 获得 {spell:384802} 增益，然后点击湖中3个 {object:嗡鸣水晶} 打开宝箱。'
L['pt_leath_decay_infused_tanning_oil_note'] = '在桶里。'
L['pt_leath_treated_hides_note'] = '在 {location:雪皮营地}。'
L['pt_leath_well_danced_drum_note'] = '在有 {npc:186446} 和 {npc:186448} 的地下建筑中。修复 {npc:194862} 旁边的鼓。一旦他在上面跳舞，您就可以拾取该物品。'
L['pt_script_dusty_darkmoon_card_note'] = '在上层的建筑物内。'
L['pt_script_frosted_parchment_note'] = '一个 {npc:190776} 后面。'
L['pt_smith_spelltouched_tongs_note'] = '在一个封闭的小洞穴内。'
L['pt_tailor_decaying_brackenhide_blanket_note'] = '挂在临时帐篷内的树上。'
L['pt_tailor_intriguing_bolt_of_blue_cloth_note'] = '沿着左边的楼梯。'

L['leyline_note'] = '重新排列魔网。'
L['options_icons_leyline'] = '{achievement:16638}'
L['options_icons_leyline_desc'] = '显示 {achievement:16638} 成就中全部重新排列魔网的位置。'

L['river_rapids_wrangler_note'] = '与 {npc:186157} 交谈并选择“我想再坐一次激流勇进。”。有60秒的时间收集40层 {spell:373490}。'
L['seeing_blue_note'] = '从 {location:碧蓝档案馆} 的顶端飞到 {location:钴蓝集所}，当中不落地。'
L['snowman_note'] = '该区域有三个 {npc:197599}（可能已被其他玩家移动），将它们滚给两个孩子 {npc:197838} 和 {npc:197839}。\n当雪球有合适的尺寸时获得成就。'

L['snowclaw_cub_note_start'] = '必须在 {location:瓦德拉肯} 中完成 {npc:192522} 提供的 {quest:67094} 任务线才能获得 {title:荣誉树妖} 头衔。\n\n收集以下物品：'
L['snowclaw_cub_note_item1'] = '从 {location:觉醒海岸} 周围的各种 {npc:182559} 拾取3个 {item:197744}。'
L['snowclaw_cub_note_item2'] = '从 {location:觉醒海岸} 的 {npc:193310} 购买1个 {item:198356}。'
L['snowclaw_cub_note_end'] = [[
{note:所有物品都可以从拍卖行购买。如果获得从 {npc:193310} 购买物品所需的 {item:199215} 有难度，这将特别有用。}

获得 {title:荣誉树妖} 后带上头衔，将所有4件物品提供给 {npc:196768} 以获得的宠物。

{note:如果过早地失去了头衔，可以重复任务以再次获得。明天或在下一次每周重置后重试。}
]]

L['tome_of_polymoph_duck'] = '使用 {spell:1953} 进入洞穴并与 {object:法力风暴初学指南} 书互动以完成任务。'

L['temperamental_skyclaw_note_start'] = '收集（或在拍卖行购买）：'
L['temperamental_skyclaw_note_end'] = '询问带鞍的狐龙并展示 {npc:190892} 收集的“菜肴”。'

L['elder_poa_note'] = '用 {item:200071} 换取 {faction:2511} 声望。'

L['artists_easel_note_step1'] = '{quest:70166}\n{npc:194415} 在 {location:远古瞭望台} 的塔顶，会要求把他的画交给 {npc:194323}，有史以来最伟大的画家。'
L['artists_easel_note_step2'] = '{quest:70168}\n{npc:194425} 会要求从 {location:红玉新生法池}、{location:诺库德阻击战} 和 {location:蕨皮山谷} 收集画作。'
L['artists_easel_note_step3'] = '{quest:70170}\n{npc:194425} 会要求从 {location:注能大厅}、{location:艾杰斯亚学院}、{location:碧蓝魔馆} 和 {location:奈萨鲁斯} 收集画作。'
L['artists_easel_note_step4'] = '将最后的画作交给 {npc:194323} 并收到玩具！\n\n{note:画作不会从史诗或史诗+地下城中掉落。}'

L['somewhat_stabilized_arcana_note'] = '位于塔顶。\n\n完成从 {npc:197100} 开始的小任务线获得玩具。'

L['stranded_soul_note'] = [[
击杀 {npc:196900} 后它会爆炸成4个 {npc:196901}。
需要激活它们来融化冰墙（推荐两个玩家）。

击杀里面的 {npc:197183}，会得到 {item:200528}。
]]

L['gethdazr_note'] = [[
作为 {location:伊姆布} 事件的一部分出现，该事件以吹响 {object:伊姆布巨角} {dot:Blue} 开始。
只有在击杀大约30-60分钟刷新时间的 {npc:196155} 后，巨角才会变得可点击。

{npc:191143} {dot:Green} 和其他 NPC 将从 {location:伊姆布} 的东北入口杀出一条血路，直到 {npc:196165} 在悬崖出现。
NPC 可以在没有帮助的情况下死亡，这将使事件失败。

这可以单独完成，但建议2-3名玩家。
]]

L['tuskarr_chest'] = '海象人宝箱'
L['options_icons_tuskarr_chest'] = '海象人宝箱'
L['options_icons_tuskarr_chest_desc'] = '显示 {object:海象人宝箱} 可能的位置。'

L['community_feast_label'] = '社区盛宴'
L['tasks_completed_suffix'] = '烹饪任务已完成'
L['options_icons_community_feast'] = '社区盛宴'
L['options_icons_community_feast_desc'] = '显示社区盛宴的位置和奖励。'

L['decay_covered_chest'] = '腐朽覆盖的宝箱'
L['options_icons_decay_covered_chest'] = '腐朽覆盖的宝箱'
L['options_icons_decay_covered_chest_desc'] = '显示 {object:腐朽覆盖的宝箱} 可能的位置。'

L['icemaw_storage_cache'] = '冰喉储存箱'
L['options_icons_icemaw_storage_cache'] = '冰喉储存箱'
L['options_icons_icemaw_storage_cache_desc'] = '显示 {object:冰喉储存箱} 可能的位置。'

L['kazzi_note_start'] = '用 {item:202017} 和 {item:202018} 换取幻化、幼龙定制、宠物等。'
L['kazzi_note_item'] = '当前有 %s {item:%s}。'
L['kazzi_achievement_suffix'] = '冬裘语言等级'

L['naszuro_vakthros'] = '在塔顶。'
L['naszuro_imbu'] = '在树桩上。'
L['naszuro_azure_archives'] = '山的一侧，一块小石头上。'
L['naszuro_hudsons_rock'] = '小石山顶上。'

L['ferry_to_iskaara'] = '乘船前往伊斯卡拉'

L['options_icons_vegetarian_diet'] = '{achievement:16762}'
L['options_icons_vegetarian_diet_desc'] = '显示 {achievement:16762} 成就中 {object:肉类仓库} 的位置。'

L['meat_storage_label'] = '肉类仓库'
L['meat_storage_note'] = '从 {location:蕨皮山谷} 内的 {object:肉类仓库} 解救所有12个 {npc:186766} 后，将收到来自 {npc:196267} 的邮件，其中包含 {item:200631}。'

L['meat_storage_location_a'] = '在被 {npc:96239} 包围的海滩上。'
L['meat_storage_location_b'] = '靠近 {npc:187192} 后面的一个洞穴。'
L['meat_storage_location_c'] = '在 {npc:197130} 和 {npc:186226} 后面的一个小洞穴里。'

-------------------------------------------------------------------------------
------------------ FORBIDDEN REACH (DRACTHYR STARTING ZONE) -------------------
-------------------------------------------------------------------------------

L['bag_of_enchanted_wind'] = '魔风之袋'
L['bag_of_enchanted_wind_note'] = '位于塔顶。'
L['hessethiash_treasure'] = '赫瑟赛亚什拙劣地隐藏起来的宝藏'
L['lost_draconic_hourglass'] = '失落的巨龙沙漏'
L['suspicious_bottle_treasure'] = '可疑的瓶子'
L['mysterious_wand'] = '神秘的魔杖'
L['mysterious_wand_note'] = '拾取 {object:水晶钥匙} 并将其放入 {object:水晶法器}。'

-------------------------------------------------------------------------------
------------------------- FORBIDDEN REACH (MAIN ZONE) -------------------------
-------------------------------------------------------------------------------

L['in_dragonskull_island'] = '位于 {location:龙颅岛}。'
L['in_froststone_vault'] = '位于 {location:霜石宝库}。'
L['in_the_high_creche'] = '位于 {location:至高育幼所}。'
L['in_the_lost_atheneum'] = '位于 {location:失落图书馆}。'
L['in_the_siege_creche'] = '位于 {location:攻城育幼所}。'
L['in_the_support_creche'] = '位于 {location:支援育幼所}。'
L['in_the_war_creche'] = '位于 {location:至高育幼所} 深处。'
L['in_zskera_vaults'] = '位于 {location:兹斯克拉宝库}。'

L['duzalgor_note'] = '收集一瓶 {spell:400751} {dot:Green} 来治疗 {location:支援育幼所} 内的有毒气体。'
L['mad_eye_carrey_note'] = '{npc:201181} 与 {npc:201184} 和 {npc:201182} 在一组。'
L['wymslayer_angvardi_note'] = '{npc:201013} 和 {npc:201310} 为伴。'
L['loot_specialist_note'] = '{npc:203353} 出现时有 {spell:406143} 和 {spell:132653} 并且会在受到攻击时逃跑。\n\n{note:在他施放 {spell:406141} 完之前快速击杀他。}'

L['profession_required'] = '{note:需要玩家为 %s 专业。}'
L['pr_crafting_note'] = '用 {item:%2$s} 制作 {item:%1$s} 并与 {object:%3$s} 互动召唤稀有。'
L['pr_gathering_note'] = '使用 {item:%s} 与 {object:%s} 互动召唤稀有。'
L['pr_recipe_note'] = '配方 {item:%s} 可以用10个 {item:190456} 从 {npc:202445} 购买。'
L['pr_summoning_note'] = '召唤稀有的玩家将获得 {spell:405161} 和额外拾取。'

L['pr_awakened_soil'] = '觉醒之油'
L['pr_book_of_arcane_entities'] = '奥术实体之书'
L['pr_damaged_buzzspire'] = '受损的鸣塔505型'
L['pr_empty_crab_trap'] = '空荡荡的捕蟹笼'
L['pr_farescale_shrine'] = '远鳞神龛'
L['pr_raw_argali_pelts'] = '未处理的绒羊毛皮'
L['pr_resonant_crystal'] = '共鸣水晶'
L['pr_rumbling_deposit'] = '轰鸣的矿脉'
L['pr_spellsworn_ward'] = '法誓结界'
L['pr_spiceless_stew'] = '无香料的炖煮'
L['pr_tuskarr_kite_post'] = '海象人风筝柱'
L['pr_tuskarr_tanning_rack'] = '海象人的制皮架'
L['pr_volatile_brazier'] = '不稳定的火盆'

L['options_icons_profession_rares'] = '专业稀有'
L['options_icons_profession_rares_desc'] = '显示专业稀有的位置。'

L['storm_bound_chest_label'] = '雷缚储物箱'

L['hoarder_of_the_forbidden_reach_suffix'] = '已打开小宝箱'
L['forbidden_spoils_suffix'] = '已打开禁忌宝藏'
L['forbidden_hoard_label'] = '禁忌宝藏'

L['options_icons_forbidden_hoard'] = '禁忌宝藏'
L['options_icons_forbidden_hoard_desc'] = '显示 {object:禁忌宝藏} 宝箱可能的位置。'

L['froststone_vault_storm_label'] = '霜石宝库原始风暴'
L['gooey_snailemental_note'] = '从 {object:霜石宝库原始风暴} 首领收集50个 {item:204352} 组合制作 {item:192785}。'

L['options_icons_froststone_vault_storm'] = '霜石宝库原始风暴'
L['options_icons_froststone_vault_storm_desc'] = '显示 {object:霜石宝库原始风暴} 的位置和奖励。'

L['small_treasures_label'] = '小宝箱'
L['small_treasures_note'] = '刷新点之间共享小宝箱。\n\n从 {location:莫库特村} 的 {npc:200566} 购买 {item:204558} 以获得{spell:405637} 增益，可以在小地图上看到小宝箱60分钟。'

L['options_icons_small_treasures'] = '小宝箱'
L['options_icons_small_treasures_desc'] = '显示小宝箱可能的位置。'

L['zskera_vaults_label'] = '兹斯克拉宝库'
L['zskera_vaults_note'] = '从各种稀有物品和宝箱中收集 {item:202196}，打开 {location:兹斯克拉宝库} 内的大门。'
L['door_buster_suffix'] = '使用兹斯克拉宝库钥匙解锁的门'

L['broken_waygate_label'] = '损坏的界门'
L['neltharions_toolkit_note'] = [[1. 从 {location:兹斯克拉宝库} 中收集随机出现的 {item:204278}。

2. 前往{location:觉醒海岸} 的 {location:焖燃栖地}。

3. 在 {npc:193310} 旁边的洞穴中找到 {object:坏掉的界门}。

4. 修复 {object:坏掉的界门}。{note:这可能需要点击几下。}

5. 传送到 {location:兹斯克拉宝库} 内的隐藏房间。击杀 {npc:200375} 和 {npc:203639} 然后打开 {object:辉煌的黑曜石宝箱} 领取战利品！]]

L['recipe_rat_note_1'] = '与 {location:兹斯克拉宝库} 中的 {npc:202982} 交谈，{item:202252} 会进入包内。'
L['recipe_rat_note_2'] = '与 {item:202252} 互动以收到 {item:204340}。{note:（5分钟冷却时间）}'
L['recipe_rat_note_3'] = '一旦有30个 {item:204340} 组合废料来收到配方。'
L['recipe_rat_note_4'] = '{note:这只老鼠喜欢奶酪并且大约每三分钟就会吃掉一个 {item:3927}。做好计划！}'

L['mm_start_note'] = '收集并组合从 {location:兹斯克拉宝库} 中找到的各种物品。'
L['mm_status_note'] = '组合以下物品：\n{item:%s}\n{item:%s}'

L['options_icons_zskera_vaults'] = '兹斯克拉宝库'
L['options_icons_zskera_vaults_desc'] = '显示 {location:兹斯克拉宝库} 的奖励。'

L['confiscated_journal_label'] = '缴获的日志'
L['farscale_manifesto_label'] = '远鳞宣言'
L['lost_expeditions_notes_label'] = '探险笔记'
L['pirate_proclamation_label'] = '海盗公告'
L['spellsworn_missive_label'] = '法誓公函'
L['vrykul_tome_label'] = '维库魔典'

L['library_note'] = '打开 {object:%s} 并拾取 {item:%s}。'

L['options_icons_librarian_of_the_reach'] = '{achievement:17530}'
L['options_icons_librarian_of_the_reach_desc'] = '显示 {achievement:17530} 成就中书籍的位置。{note:有些书籍在 {location:兹斯克拉宝库}}。'

L['dracthyr_runestone_label'] = '龙希尔符文石'
L['scroll_hunter_suffix'] = '来自密封卷轴的宝藏'
L['scroll_hunter_note'] = '在 {location:禁忌离岛} 附近收集各种稀有和珍藏的密封卷轴。\n\n打开一个 {item:%s} 会在地图上显示一个 X，会提供一个 {item:%s}，为 {faction:%s} 提供声望。'

L['options_icons_scroll_hunter'] = '{achievement:17532}'
L['options_icons_scroll_hunter_desc'] = '显示 {achievement:17532} 的卷轴奖励的位置。'

L['options_icons_scalecommander_item'] = '{achievement:17315}'
L['options_icons_scalecommander_item_desc'] = '显示 {achievement:17315} 成就中物品的位置。{note:有些物品在 {location:兹斯克拉宝库}}。'

L['spellsworn_gateway'] = '法誓传送门'
L['gemstone_of_return'] = '返回宝石'

L['treysh_note'] = '用 {currency:2118} 或金币兑换幻化装备和坐骑。'
L['renown_envoy_label'] = '名望特使'
L['renown_envoy_note'] = '用 {currency:2118} 或金币换取坐骑、宠物、幻化、幼龙定制、配方和其他有用的物品。\n\n从 {npc:200566} 以2000 {currency:2118} 的价格购买 {item:204383} 就有机会获得 {item:191915}。'
L['trader_hagarth_note'] = '将 {item:190456} 换成匠人珍玩配方。'

L['naszuro_caldera_of_the_menders'] = '在塔顶。'

L['sun_bleached_vase'] = '久经日晒的花瓶'
L['untranslated_tome'] = '未翻译的魔典'
L['untranslated_tome_note'] = '在建筑里，入口位于桥下。'
L['mysterious_boot'] = '神秘的靴子'
L['mysterious_boot_note'] = '在上层。'
L['decaying_fishing_bucket'] = '腐烂鱼桶'
L['decaying_fishing_bucket_note'] = '在塔的最顶层。'
L['forgotten_fishing_pole'] = '被遗忘的鱼竿'
L['forgotten_fishing_pole_note'] = '在最底层。'
L['overgrown_fishing_bench'] = '长满杂草的钓鱼椅'
L['overgrown_fishing_bench_note'] = '覆满青苔的岩石，不大显眼。'

-------------------------------------------------------------------------------
------------------------------ OHN'AHRAN PLAINS -------------------------------
-------------------------------------------------------------------------------

L['eaglemaster_niraak_note'] = '击杀附近的 {npc:186295} 和 {npc:186299} 直到稀有出现。'
L['hunter_of_the_deep_note'] = '单击武器架并射击鱼直到稀有出现。'
L['porta_the_overgrown_note'] = '从西侧的 {location:镜天湖} 湖底找到5个 {item:194426}，然后撒在 {npc:191953} 后稀有出现。'
L['scaleseeker_mezeri_note'] = '向 {npc:193224} 提供一个 {item:194681}，并跟着她，直到她揭示稀有。\n\n{note:位于 {location:碧蓝林海} 的 {location:三瀑勘查点} 的 {npc:190315} 是最近的供应商。}'
L['shade_of_grief_note'] = '点击 {npc:193166} 稀有出现。'
L['windscale_the_stormborn_note'] = '击杀引导 {npc:192357} 的 {npc:192367}。'
L['windseeker_avash_note'] = '击杀附近的 {npc:195742} 和 {npc:187916} 直到稀有出现。'
L['zarizz_note'] = '点击并 {emote:/鄙视}，{emote:/hiss} 在四个 {npc:193169} 处召唤稀有。'

L['aylaag_outpost_note'] = '{note:只有 {faction:艾拉格氏族} 营地在 {location:艾拉格岗哨} 时此稀有会出现。}'
L['eaglewatch_outpost_note'] = '{note:只有 {faction:艾拉格氏族} 营地在 {location:雄鹰之眼哨站} 时此稀有会出现。}'
L['river_camp_note'] = '{note:只有 {faction:艾拉格氏族} 营地在 {location:河畔营地} 时此稀有会出现。}'

L['defend_clan_aylaag'] = '保护艾拉格氏族'
L['defend_clan_aylaag_note'] = '{note:只在保护 {faction:艾拉格氏族} 营地移动事件时出现，没有拾取。}'

L['gold_swong_coin_note'] = '在洞穴内，{npc:191608} 在他的右侧。'
L['nokhud_warspear_note'] = '{item:194540} 可以从 {object:探险队斥候的背包} 和 {object:翻动过的泥土} 中找到。'
L['slightly_chewed_duck_egg_note'] = '找到并拍打 {npc:192997} 获得 {item:195453} 并使用它。{item:199171} 3天后孵化为 {item:199172}。'
L['yennus_boat'] = '海象人玩具船'
L['yennus_boat_note'] = '拾取 {object:海象人玩具船} 后获得 {item:200876}，开始任务 {quest:72063} 将其交还给 {npc:195252}。'

L['forgotten_dragon_treasure_label'] = '被遗忘的巨龙宝藏'
L['forgotten_dragon_treasure_step1'] = '1. 从 {location:欧恩哈拉平原} 西部的 {object:水晶花} {dot:Green} 收集5个 {item:195884}。'
L['forgotten_dragon_treasure_step2'] = '2. 组合花瓣来做成 {item:195542} 并到 {object:远古之石} {dot:Yellow}。'
L['forgotten_dragon_treasure_step3'] = '3. 在 {object:远古之石} 附近使用 {item:195542} 获得一个20秒的增益 {spell:378935}，允许沿着花路充能到达洞穴 {dot:Blue}。从鲜花上奔跑会增加到达 {object:翡翠宝箱} {dot:Blue} 和拾取 {item:195041} 的增益时间。'
L['forgotten_dragon_treasure_step4'] = '拿到钥匙后，前往 {object:被遗忘的巨龙宝藏} 打开获得观龙者手稿。'
L['fdt_crystalline_flower'] = '水晶花'
L['fdt_ancient_stone'] = '远古之石'
L['fdt_emerald_chest'] = '翡翠宝箱'

L['pm_ench_shalasar_glimmerdusk'] = '破塔二楼。'
L['pm_herb_hua_greenpaw'] = '跪在树旁。'
L['pm_leath_erden'] = '站在河边死去的 {npc:193092} 旁边。'
L['pt_alch_canteen_of_suspicious_water_note'] = '洞穴深处一个死掉的 {object:探险队斥候} 旁边。'
L['pt_ench_stormbound_horn_note'] = '在 {location:风歌高地}。'
L['pt_jewel_fragmented_key_note'] = '在倒塌建筑的树根下。'
L['pt_jewel_lofty_malygite_note'] = '在洞穴中漂浮在空中。'
L['pt_leath_wind_blessed_hide_note'] = '在 {location:席卡尔高地} 半人马营地。'
L['pt_script_sign_language_reference_sheet_note'] = '敲打帐篷入口。'
L['pt_smith_ancient_spear_shards_note'] = '在 {location:鲁萨扎尔高台} 西侧洞穴。'
L['pt_smith_falconer_gauntlet_drawings_note'] = '海中小岛，小屋内。'
L['pt_tailor_noteworthy_scrap_of_carpet_note'] = '在一间小屋里。{note:3个精英在屋里。}'
L['pt_tailor_silky_surprise_note'] = '找到拾取一个 {object:猫薄荷复叶}。'

L['lizi_note'] = '完成从 {quest:65901} 开始的新兵一日游日常任务线。'
L['lizi_note_day1'] = '从 {location:巨龙群岛} 的昆虫怪物收集20个 {item:192615}。'
L['lizi_note_day2'] = '从 {location:巨龙群岛} 的植物怪物收集20个 {item:192658}。'
L['lizi_note_day3'] = '从 {location:巨龙群岛} 的任意水域钓鱼收集10个 {item:194966}。常见于 {location:欧恩哈拉平原} 内陆。'
L['lizi_note_day4'] = '从 {location:欧恩哈拉平原} 的猛犸象收集20个 {item:192636}。'
L['lizi_note_day5'] = '从 {npc:190014} 接 {quest:71195} 并在 {location:欧恩伊尔清泉} 南部的帐篷中从 {npc:190015} 获得1个 {item:200598}。'

L['ohnahra_note_start'] = '在 {location:欧恩伊尔清泉} 完成日常任务线 {quest:71196} 获得 {item:192799}。从位于 {location:欧恩伊尔清泉} 轻风贤者小屋的 {npc:190022} 领取任务 {quest:72512}。\n\n收集以下材料：'
L['ohnahra_note_item1'] = '从 {location:诺库德阻击战} 地下城的最终首领 {npc:186151} 收集3个 {item:201929}，不是 100% 掉落。'
L['ohnahra_note_item2'] = '50个 {currency:2003} 和1个 {item:194562} 从 {npc:196707} 购买1个 {item:201323}。\n{item:194562} 可以从 {location:索德拉苏斯} 中从迷时怪物身上拾取。'
L['ohnahra_note_item3'] = '从拍卖行购买1个 {item:191507}。（炼金师可以从 {npc:196707} 购买 {item:191588}，需要声望22）'
L['ohnahra_note_end'] = '获得所有材料后，前往 {npc:194796} 交任务获得的坐骑。'

L['bakar_note'] = '抚摸獒犬！'
L['bakar_ellam_note'] = '如果有足够多的玩家抚摸这只獒犬，会带着去寻找她的宝藏。'
L['bakar_hugo_note'] = '跟随艾拉格营地旅行。'
L['options_icons_bakar'] = '{achievement:16424}'
L['options_icons_bakar_desc'] = '显示 {achievement:16424} 成就中獒犬的位置。'

L['ancestor_note'] = '在 {location:森步岗哨} 的帐篷中获得 {spell:369277} 增益（1小时）来自{object:觉醒精华} 以见到先祖并向他提供所需的物品。'
L['options_icons_ancestor'] = '{achievement:16423}'
L['options_icons_ancestor_desc'] = '显示 {achievement:16423} 成就中先祖的位置。'

L['dreamguard_note'] = '目标为梦境防御者并 {emote:/睡觉}，{emote:/sleep}'
L['options_icons_dreamguard'] = '{achievement:16574}'
L['options_icons_dreamguard_desc'] = '显示 {achievement:16574} 成就中梦境防御者的位置。'

L['khadin_note'] = '将 {item:191784} 换成专业知识。'
L['khadin_prof_note'] = '还需投入 %d 点 {currency:%d} 才能点满 {spell:%d} 专业树。'
L['the_great_swog_note'] = '将 {item:199338}、{item:199339} 和 {item:199340} 换成 {item:202102}。'
L['hunt_instructor_basku_note'] = '用 {item:200093} 换取 {faction:2503} 声望。'
L['elder_yusa_note'] = '目标为 {npc:192818} 并 {emote:/饿}，{emote:/hungry} 获得烹饪配方。'
L['initiate_kittileg_note'] = '完成 {quest:66226} 获得玩具！'

L['quackers_duck_trap_kit'] = '要召唤 {npc:192557} 首先需要附近艾拉格氏族营地 {dot:Blue} 找到 {item:194740}。\n\n做成 {item:194712} 需要以下材料：'
L['quackers_spawn'] = '接下来需要用 {item:194712} 在巢穴附近抓一只鸭子。在 {npc:192581} 处使用 {item:194739} 来召唤 {npc:192557}。'

L['knew_you_nokhud_do_it_note'] = '{note:所有3个物品都是唯一的，并且有30分钟的计时。}\n\n从 {location:诺库顿要塞} 附近的各种 {npc:185357}、{npc:185353} 和 {npc:185168} 收集 {item:200184}，{item:200194} 和 {item:200196}。\n\n将它们组合起来制造 {item:200201} 并使用它之后与 {npc:197884} 交谈以开始训练课程。\n\n使用 |cFFFFFD00额外的动作按钮|r 完成它并获得成就。\n\n{note:在元素风暴期间团队中完成成就可以更容易地刷物品。}'
L['options_icons_nokhud_do_it'] = '{achievement:16583}'
L['options_icons_nokhud_do_it_desc'] = '显示 {achievement:16583} 成就中有用的完成信息。'

L['chest_of_the_flood'] = '洪水宝箱'

L['aylaag_camp_note'] = '{faction:艾拉格氏族} 每3天3小时（75小时）移动到另一个营地，跟随并在途中保护他们。\n\n下次移动：{note:%s}'

L['clan_chest'] = '氏族宝箱'
L['options_icons_clan_chest'] = '氏族宝箱'
L['options_icons_clan_chest_desc'] = '显示 {object:氏族宝箱} 可能的位置。'

L['lightning_bound_chest'] = '雷缚宝箱'
L['options_icons_lightning_bound_chest'] = '雷缚宝箱'
L['options_icons_lightning_bound_chest_desc'] = '显示 {object:雷缚宝箱} 可能的位置。'

L['bloodgullet_note'] = '在 {location:森步岗哨} 的帐篷中从 {object:觉醒精华} 获得 {spell:369277} 增益（1小时）可以看到这只灵魂兽。\n\n{note:只对野兽控制猎人可见。}'

L['naszuro_windsong_rise'] = '石柱上。'
L['naszuro_emerald_gardens'] = '瀑布旁的草地上。'

L['prismatic_leaper_school_label'] = '棱光跃鲑鱼群'
L['prismatic_leaper_school_note'] = '与 {location:伊斯卡拉} 的 {npc:195935} 交谈以进行升级。\n\n从整个 {location:欧恩哈拉平原} 的 {object:棱光跃鲑鱼群} 中钓取以下物品：\n\n{item:%d}\n{item:%d}\n{item:%d}\n{item:%d}\n{item:%d}'

L['aylaag_spear'] = '艾拉格长矛'
L['dedication_plaquard'] = '奉献壁橱'

-------------------------------------------------------------------------------
--------------------------------- THALDRASZUS ---------------------------------
-------------------------------------------------------------------------------

L['ancient_protector_note'] = '击杀附近的 {npc:193244} 以获得 {item:197708}。将5个 {item:197708} 组合成一个 {item:197733} 并用它来激活附近的 {object:泰坦反应堆}。'
L['blightpaw_note'] = '与附近的 {npc:193222} 交谈并同意帮助他。'
L['corrupted_proto_dragon_note'] = '调查 {object:腐化的龙蛋} 后稀有出现。'
L['lord_epochbrgl_note'] = '点击 {npc:193257} 后稀有出现。'
L['the_great_shellkhan_note'] = '从 {location:碧蓝林海} 的 {location:考里克闪光河湾} 拾取 {item:200949}，3分钟内回到 {npc:191416} 交还物品激活稀有并获得成就。\n\n{note:在开始前确保 {npc:191416} 和 {npc:191305} 确实存在。一个角色每周只能拾取并交还一次物品，之后 {npc:191416} 只会表示感谢。}'
L['weeping_vilomah_note'] = '和 {npc:193206} 对话召唤稀有。'
L['woofang_note'] = '抚摸 {npc:193156} 稀有出现。'

L['acorn_harvester_note'] = '从附近地面收集1个 {object:橡果} 获得 {spell:388485} 并与 {npc:196172} 互动。\n\n{bug:（错误：点击 {npc:196172} 可能需要重新加载）}'
L['cracked_hourglass_note'] = '{item:199068} 可以从 {object:探险队斥候的背包} 和 {object:翻动过的泥土} 中找到。'
L['sandy_wooden_duck_note'] = '收集 {item:199069} 并使用它。'

L['tasty_hatchling_treat_note'] = '在书架后面的一个桶里。'

L['pm_mining_bridgette_holdug'] = '在长满草的石柱上。'
L['pm_tailor_elysa_raywinder'] = '在塔的中间的一个壁架上。'
L['pt_alch_contraband_concoction_note'] = '隐藏在灌木丛中。{note:很难发现。}'
L['pt_alch_tasty_candy_note'] = '将附近的 {object:丢弃的玩具} 放入每个大锅中。'
L['pt_ench_fractured_titanic_sphere_note'] = '{location:提尔要塞} 南侧。'
L['pt_jewel_alexstraszite_cluster_note'] = '{location:提尔要塞} 内。'
L['pt_jewel_painters_pretty_jewel_note'] = '一盏灯内。'
L['pt_leath_decayed_scales_note'] = '篮子内。'
L['pt_script_counterfeit_darkmoon_deck_note'] = '与 {npc:194856} 交谈并提出帮助阻止她的 {object:暗月套牌} 散落在她的脚下。按正确的顺序（A 到 8）点击卡片，然后再次与她交谈。'
L['pt_script_forgetful_apprentices_tome_note'] = '在靠近大望远镜的桌子上。'
L['pt_script_forgetful_apprentices_tome_algethera_note'] = '点击 {object:奇特的雕文} 来获得增益 {spell:384818}。过桥并从 {npc:194880} 拾取 {item:198672} 并将其带回雕文。'
L['pt_script_how_to_train_your_whelpling_note'] = '躺在沙盒里的棕色小书。'
L['pt_smith_draconic_flux_note'] = '建筑物内。'
L['pt_tailor_ancient_dragonweave_bolt_note'] = '点击 {object:上古龙纹织布机} 以完成一个小游戏，将线轴连接到中心宝石。'
L['pt_tailor_miniature_bronze_dragonflight_banner_note'] = '一堆沙子里的小旗帜。'

L['picante_pomfruit_cake_note'] = '{item:200904} 并非每天都可用，因此请返回查看。当在那里时，一定要品尝3种可用的菜肴来完成 {achievement:16556}。'
L['icecrown_bleu_note'] = '从 {location:匠人集市} 的 {npc:196729} {title:<奶酪商贩>} 购买。'
L['dreamwarding_dripbrew_note'] = '从 {location:熬夜实验室} 的 {npc:197872} {title:<咖啡因操控师>} 购买。'
L['arcanostabilized_provisions_note'] = '从 {location:拜荒者的未来} 内的 {location:时光流汇} 的 {npc:198831} {title:<厨师长>} 购买。'
L['steamed_scarab_steak_note'] = '从 {location:宁梦温泉} 的 {npc:197586} {title:<温泉调酒师>} 购买。'
L['craft_creche_crowler_note'] = '从每日随机地图位置的 {npc:187444} {title:<旅行的巨龙陈酿商人>} 位于：{location:红玉新生圣地}、{location:龙鳞先遣营地}、{location:时光流汇}、{location:格利基尔岗哨}、{location:僻壤营地}、{location:掉链旅店} 和 {location:绿鳞旅店} 购买。'
L['bivigosas_blood_sausages_note'] = '从 {location:格利基尔岗哨} 的 {npc:188895} {title:<食物和饮料>} 购买。'
L['rumiastrasza_note'] = '{note:完成从 {location:瓦德拉肯} {quest:71238} 开始的日常任务线，否则无法完成成就。}'
L['options_icons_specialties'] = '{achievement:16621}'
L['options_icons_specialties_desc'] = '显示 {achievement:16621} 成就中食物和饮料的位置。'

L['new_perspective_note'] = '用自拍神器与景点合影。一旦进入相机模式，该位置就会用紫色光圈标记。\n\n如果没有获得成就，请改变视角。'
L['options_icons_new_perspective'] = '{achievement:16634}'
L['options_icons_new_perspective_desc'] = '显示 {achievement:16634} 成就中景点的位置。'

L['fringe_benefits_note'] = '完成8个日常任务即可获得成就。'
L['options_icons_fringe_benefits'] = '{achievement:19507}'
L['options_icons_fringe_benefits_desc'] = '显示 {achievement:19507} 成就中可以接受日常任务的位置。'

L['little_scales_daycare_note'] = '必须在多天内完成任务线，从 {npc:197478} 的 {quest:72664} 开始，才能获得此成就和宠物。'
L['options_icons_whelp'] = '{achievement:18384}'
L['options_icons_whelp_desc'] = '显示 {achievement:18384} 成就中可以接受日常任务的位置。'

L['ruby_feast_gourmand'] = '每天，一位随机的客座厨师都会提供不同的食品和饮料。'
L['options_icons_ruby_feast_gourmand'] = '{achievement:16556}'
L['options_icons_ruby_feast_gourmand_desc'] = '显示 {achievement:16556} 成就中可以接受日常任务的位置。'

L['sorotis_note'] = '用 {item:199906} 换取 {faction:2510} 声望。'
L['lillian_brightmoon_note'] = '用 {item:201412} 换取 {faction:2507} 声望。'

L['chest_of_the_elements'] = '元素宝箱'

L['hoard_of_draconic_delicacies_note_start'] = '完成 {npc:189479} 提供的7个以下任务：'
L['hoard_of_draconic_delicacies_note_end'] = '完成所有任务后，{npc:189479} 将提供 {quest:67071} 以接收食谱。\n\n{note:任务基于 {location:红玉飞地} 的活跃客座厨师，可能不匹配上面列出的顺序。}'

L['brendormi_note_start'] = '用 {item:202039} 和 {currency:2118} 换取装备，宠物和坐骑。'
L['brendormi_note_item'] = '当前有 %s {item:202039}。'
L['brendormi_note_currency'] = '当前有 %s {currency:2118}。'

L['titan_chest'] = '泰坦箱子'
L['options_icons_titan_chest'] = '泰坦箱子'
L['options_icons_titan_chest_desc'] = '显示 {object:泰坦箱子} 可能的位置。'

L['living_mud_mask_note'] = [[
{npc:197346} 会掉落 {item:200586} 给 {quest:70377} 任务。将此带回交给 {npc:198062}。

之后必须再次与 {npc:198062} 交谈并向他索取更好的奖励。他将乘坐滑翔机前往贵宾区，这样就可以“进一步享受他的陪伴作为奖励”。

当到达浮岛时，{npc:198062} 会在地板上。再次与他交谈，说他看起来死了。

一个叫做 {npc:198590} 的软泥怪会出现并跑到 {npc:197232} 后面的树枝上。一旦离得足够近，软泥怪会给任务 {quest:72060}。

回到 {npc:198062}，坐在长椅上，交付 {item:200872} 的任务。
]]

L['naszuro_veiled_ossuary'] = '神龛边上。'
L['naszuro_algethar_academy'] = '在塔顶的壁架上。'
L['naszuro_vault_of_the_incarnates'] = '雕像脚下。'
L['naszuro_thaldraszus_peak'] = '第二高的山峰上。'
L['naszuro_temporal_conflux'] = '在龙雕像的头上。'

L['revival_catalyst_label'] = '复苏化生'
L['revival_catalyst_note'] = '将非套装装备转换为同等物品等级和装备槽套装装备。\n\n{currency:2912}: %d/%d'

L['provisioner_aristta_note'] = '用 {currency:2657} 兑换幻化和坐骑。'

L['investigators_pocketwatch_note_a'] = '1. 从 {location:纪元边界} 的 {location:万时旅店} 楼上的 {npc:204990} ({dot:Green}) 借用 {item:208449}。\n\n{note:必须之前已完成她的任务链。}'
L['investigators_pocketwatch_note_b'] = '2. 在 {location:纪元边界} 的 {location:万时旅店} 楼下的 {npc:203769} ({dot:Blue}) 附近使用 {item:208449} 并从 {npc:207463} 购买 {item:208448}。\n\n{note:{item:208448} 的持续时间为30秒。快点！}'
L['investigators_pocketwatch_note_c'] = '3. 快速到达瀑布并喝 {item:208448}。与新可见的 {object:时润时钟} 交互以出现 {npc:201664}。'

L['ominous_portal_label'] = '{npc:214985}'
L['ominous_portal_note'] = '每30分钟就会出现一个 {npc:214985}。\n\n5分钟后 {npc:214984} 将出现多个首领。击败 {npc:215141}、{npc:215147} 和 {npc:215146}，就有机会获得奖励。\n\n{note:没有每日拾取锁定。}'

-------------------------------------------------------------------------------
------------------------------ THE WAKING SHORE -------------------------------
-------------------------------------------------------------------------------

L['brundin_the_dragonbane_note'] = '卡拉希战队乘坐他们的 {npc:192737} 前往这座塔。'
L['captain_lancer_note'] = '完成 {spell:388945} 事件之后立刻出现。'
L['enkine_note'] = '沿着熔岩河击杀 {npc:193137}、{npc:193138} 或 {npc:193139} 以获得 {item:201092}，使用它并在熔岩中的 {npc:191866} 附近钓鱼。'
L['lepidoralia_note'] = '位于 {location:翩翼洞窟}。帮助 {npc:193342} 抓住 {npc:193274} 直到稀有出现。'
L['obsidian_citadel_rare_note'] = '和其他玩家必须总共上缴%d个 {item:191264} %s。要制作钥匙，需要组合30个 {item:191251} 和3个 {item:193201}，可以从 {location:黑曜堡垒} 怪物获得这些物品。'
L['shadeslash_note'] = '点击 {object:失窃的球}、{object:偷来的望远镜} 和 {object:失窃的法器} 召唤稀有。'
L['obsidian_throne_rare_note'] = '{location:黑曜王座} 内。'
L['slurpo_snail_note'] = '从 {location:碧蓝林海}（11, 41）的一个洞穴中从 {object:盐晶} 拾取1个 {item:201033} 并在 {location:觉醒海岸} 的洞穴中使用来召唤他。'
L['worldcarver_atir_note'] = '从附近的 {npc:187366} 收集3个 {item:191211} 并将它们放置在 {npc:197395} 后稀有出现。'

L['bubble_drifter_note'] = '{item:199061} 可以从 {object:探险队斥候的背包} 和 {object:翻动过的泥土} 中找到。\n\n要与鱼互动，需要从附近的 {object:芳香的植物} 获得 {spell:388331}。'
L['dead_mans_chestplate_note'] = '塔内中层。'
L['fullsails_supply_chest_note'] = '钥匙从 {location:翼眠大使馆} 以南的 {npc:187971} 和 {npc:187320} 掉落。'
L['golden_dragon_goblet_note'] = '在完成 {location:狂野海滩} 小任务线上从 {npc:190056} 拾取 {item:202081}。'
L['lost_obsidian_cache'] = '失落的黑曜石宝箱'
L['lost_obsidian_cache_step1'] = '1. 在 {npc:186763} 脚下拾取 {item:194122}。'
L['lost_obsidian_cache_step2'] = '2. 对 {npc:191851} 使用 {item:194122}，然后骑乘它到达洞穴门口。'
L['lost_obsidian_cache_step3'] = '3. 在洞穴内的 {object:失落宝箱钥匙} 拾取 {item:198085}，然后打开 {object:失落的黑曜石宝箱} 获得玩具。'
L['misty_treasure_chest_note'] = '站在从瀑布延伸出的 {npc:185485} 上进入洞穴。'
L['onyx_gem_cluster_note'] = '{faction:2507} 声望到达21级可以完成任务 {quest:70833} 获得 {item:200738} 奖励（帐号一次性）。另外可以从 {npc:189065} 以3个 {item:192863} 和500的 {currency:2003} 购买地图。'
L['torn_riding_pack_note'] = '位于瀑布顶端。'
L['yennus_kite_note'] = '卡在树顶的树枝上。'

L['fullsails_supply_chest'] = '满帆补给箱'
L['hidden_hornswog_hoard_note'] = [[
收集3种不同的物品并在 {npc:192362} 附近的 {object:“观察谜题：实地指南”} 处组合它们以获得 {item:200063} 然后喂它。然后它会离开就可以拾取它的宝藏。

{item:200064} {dot:Yellow}
{item:200065} {dot:Blue}
{item:200066} {dot:White}
]]

L['pm_alch_grigori_vialtry'] = '在俯瞰 {location:闪霜战地} 的平台上。'
L['pm_skin_zenzi'] = '站在河边。'
L['pm_smith_grekka_anvilsmash'] = '在废墟塔旁的草丛中。'
L['pt_alch_frostforged_potion_note'] = '在冰坑中间。'
L['pt_alch_well_insulated_mug_note'] = '在 {location:灭龙要塞} 一些精英怪物之间。'
L['pt_ench_enchanted_debris_note'] = '使用并跟随 {npc:194872} 在最后拾取残骸。'
L['pt_ench_flashfrozen_scroll_note'] = '{location:闪霜飞地} 洞穴系统内部。'
L['pt_ench_lava_infused_seed_note'] = '{location:碎鳞要塞} 一朵花里。'
L['pt_engi_boomthyr_rocket_note'] = '收集 {object:轰希尔火箭笔记} 中列出的物品：\n\n{item:198815}\n{item:198817}\n{item:198816}\n{item:198814}\n\n收集后，带上它们回到火箭去领取宝藏。'
L['pt_engi_intact_coil_capacitor_note'] = '与三个 {object:裸露的电线} 互动以修复和拾取 {object:超载的电磁圈}。'
L['pt_jewel_closely_guarded_shiny_note'] = '鸟巢旁边一棵树下的蓝色宝石。'
L['pt_jewel_igneous_gem_note'] = '快速点击岩浆内小岛上的3个水晶。'
L['pt_leath_poachers_pack_note'] = '在河床旁死去的狐人旁边。'
L['pt_leath_spare_djaradin_tools_note'] = '在死去的红龙旁边。'
L['pt_script_pulsing_earth_rune_note'] = '在倒塌的建筑物内的一张桌子后面。'
L['pt_smith_ancient_monument_note'] = '在基座上击败4个围着一把剑的 {npc:188648}。\n\n{bug:（错误：目前点击剑后不会获得物品，而是会在一段时间后发送到邮箱。）}'
L['pt_smith_curious_ingots_note'] = '{location:碎鳞要塞} 地面上的锭。'
L['pt_smith_glimmer_of_blacksmithing_wisdom_note'] = '在 {object:暗淡的熔炉} 附近制造一个 {item:189541} 后物品将变为可以在 {object:煤渣盆} 拾取。'
L['pt_smith_molten_ingot_note'] = '将3个锭踢入熔岩以出现怪物。打败怪物后拾取箱子。'
L['pt_smith_qalashi_weapon_diagram_note'] = '在铁砧之上。'
L['pt_tailor_itinerant_singed_fabric_note'] = '一块布料挂在树上，就在最终首领出现的洞穴外。{note:需要精准驭龙术或术士传送门。}'
L['pt_tailor_mysterious_banner_note'] = '在建筑物的顶部飘扬。'

L['quack_week_1'] = '第1周'
L['quack_week_2'] = '第2周'
L['quack_week_3'] = '第3周'
L['quack_week_4'] = '第4周'
L['quack_week_5'] = '第5周'
L['lets_get_quacking'] = '每周只能解救一名 {npc:187863}。'

L['complaint_to_scalepiercer_note'] = '点击小屋内的{object:石板}（在后面的左侧）。'
L['grand_flames_journal_note'] = '点击小屋后面的 {object:石板}。'
L['wyrmeaters_recipe_note'] = '点击小屋内的 {object:石板}（在左侧）。'

L['options_icons_ducklings'] = '{achievement:16409}'
L['options_icons_ducklings_desc'] = '显示 {achievement:16409} 成就中鸭子的位置。'
L['options_icons_chiseled_record'] = '{achievement:16412}'
L['options_icons_chiseled_record_desc'] = '显示 {achievement:16412} 成就中石板的位置。'

L['grand_theft_mammoth_note'] = '骑乘 {npc:194625} 到 {npc:198163}。\n\n{bug:（错误：如果不能与 {npc:194625} 互动，请使用 /reload。）}'
L['options_icons_grand_theft_mammoth'] = '{achievement:16493}'
L['options_icons_grand_theft_mammoth_desc'] = '显示 {achievement:16493} 成就中 {npc:194625} 的位置。'

L['options_icons_stories'] = '{achievement:16406}'
L['options_icons_stories_desc'] = '显示 {achievement:16406} 成就中任务的位置。'
L['all_sides_of_the_story_garrick_and_shuja_note'] = '开启任务线，聆听 {npc:184449} 和 {npc:184451} 的故事。'
L['all_sides_of_the_story_duroz_and_kolgar_note'] = '在平台下方的一个小房间里。\n\n启动任务线并聆听 {npc:194800} 和 {npc:194801} 的故事。更多任务将在接下来的两周内解锁。'
L['all_sides_of_the_story_tarjin_note'] = '从 {quest:70779} 开始任务线。\n{npc:196214} 每周都会告诉另一个故事。'
L['all_sides_of_the_story_veritistrasz_note'] = '开始任务 {quest:70132} 以听取 {npc:194076} 的所有故事。\n之后将解锁 {quest:70134}，然后解锁 {quest:70268}。\n\n对于最后一个任务，需要 {item:198661} 在 {location:灭龙要塞} 中找到。'

L['slumbering_worldsnail_note1'] = [[
1. 从 {location:黑曜堡垒} 周围的怪物中拾取3个 {item:193201} 和30个 {item:191251} 以组合成 {item:191264}。

2. 从 {npc:187275} 那用 {item:191264} 换成 {item:200069}。

3. 箱子有30%的几率会包含 {item:199215}。

4. 使用会员资格会给 {spell:386848} 负面效果，可以在 {location:黑曜堡垒} 周围刷 {item:202173}。

5. 收集1000个 {item:202173} 以购买 {item:192786}。
]]

L['slumbering_worldsnail_note2'] = '{note:注意：如果死了，将失去会员负面效果。要么在死之前以20个 {item:202173} 的价格从 {npc:193310} 购买新会员资格，要么交出更多钥匙，就有机会从宝箱中获得新会员资格。}'

L['magmashell_note'] = '从 {location:黑曜堡垒} 周围的 {npc:193138} 拾取 {item:201883} 并将其带给 {npc:199010}。\n\n{note:在熔岩中用一个20秒的引导法术来获得坐骑，因此建议带上治疗或类似 {item:200116} 的物品。}'

L['otto_note_start1'] = '从 {location:欧恩哈拉平原} 的 {npc:191608} 处购买的 {item:202102} 收集一副 {item:202042}。这个包需要75个 {item:199338}，可以从钓鱼洞附近的 {title:<大家伙>} 怪物那里钓鱼或拾取。'
L['otto_note_start2'] = '一旦有了一副 {item:202042}，就可以前往位于 {location:嘶鸣海湾} 的 {location:泡泡浴} 深水酒吧找到一个跳舞垫，然后站在上面获得负面效果 {spell:396539}。一旦负面效果结束，就会昏倒并在桶旁醒来。与它互动以拾取 {item:202061}。现在需要在桶里装满鱼来喂给 {npc:199563}。'
L['otto_note_item1'] = '收集100个 {item:202072}，一种高掉率鱼类，可以在 {location:碧蓝林海} 的 {location:伊斯卡拉} 的开阔水域钓到。将桶与鱼一起使用可获得 {item:202066}。'
L['otto_note_item2'] = '收集25个 {item:202073}，一种低掉率鱼类，可以在 {location:觉醒海岸} 的 {location:黑曜堡垒} 周围的熔岩中钓到。将桶与鱼一起使用可获得 {item:202068}。'
L['otto_note_item3'] = '收集1个 {item:202074}，一种稀有掉率鱼类，可以在 {location:索德拉苏斯} 的 {location:艾杰斯亚学院} 的水域中钓到。将桶与鱼一起使用可获得 {item:202069}。'
L['otto_note_end'] = '返回 {location:嘶鸣海湾} 并将桶放在找到它的地方以召唤 {npc:199563} 并领取坐骑！'

L['options_icons_safari'] = '{achievement:16519}'
L['options_icons_safari_desc'] = '显示 {achievement:16519} 成就中战斗宠物的位置。'
L['shyfly_note'] = '必须在任务 {quest:70853} 中才能看到 {npc:189102}。'

L['cataloger_jakes_note'] = '用 {item:192055} 换取 {faction:2507} 声望。'

L['snack_attack_suffix'] = '零食喂给“牛肉”'
L['snack_attack_note'] = '收集 {npc:195806} 并喂食给 {npc:194922} 20次。\n\n{note:不需要在一次围攻中完成。}'
L['options_icons_snack_attack'] = '{achievement:16410}'
L['options_icons_snack_attack_desc'] = '显示 {achievement:16410} 成就中 {npc:195806} 的位置。'

L['loyal_magmammoth_step_1'] = '第1步'
L['loyal_magmammoth_step_2'] = '第2步'
L['loyal_magmammoth_step_3'] = '第3步'
L['loyal_magmammoth_true_friend'] = '挚友'
L['loyal_magmammoth_wrathion_quatermaster_note'] = '从 {npc:199020} 或 {npc:188625} 购买 {item:201840} ' .. '|cFFFFD700(800 gold)|r' .. '。'
L['loyal_magmammoth_sabellian_quatermaster_note'] = '从 {npc:199036} 或 {npc:188623} 购买 {item:201839} ' .. '|cFFFFD700(800 gold)|r' .. '。'
L['loyal_magmammoth_harness_note'] = '从 {npc:191135} 购买 {item:201837}。'
L['loyal_magmammoth_taming_note'] = '在骑乘 {npc:198150} 时使用 {item:201837} 获得坐骑！\n\n{note:报告表明可能只能驾驭在 {location:燃烧高地} 中找到的 {npc:198150}。}'

L['djaradin_cache'] = '贾拉丁宝箱'
L['options_icons_djaradin_cache'] = '贾拉丁宝箱'
L['options_icons_djaradin_cache_desc'] = '显示 {object:贾拉丁宝箱} 可能的位置。'

L['dragonbane_siege_label'] = '{spell:388945}'
L['options_icons_dragonbane_siege'] = '{spell:388945}'
L['options_icons_dragonbane_siege_desc'] = '显示 {spell:388945} 的位置和奖励。'

L['phoenix_wishwing_note'] = [[
在获得 {item:199203} 后，{npc:196214} 将提供一个上缴任务，奖励 {item:193373}。
要完成任务，将需要以下物品（可以按任何顺序获得这些物品）：
]]
L['phoenix_wishwing_talisman'] = [[
%s {item:199203}

这是位于 {location:阿兰卡峰林} 的 {npc:88045} {dot:Gold} 出售。如果 {npc:88045} 不在，完成任务 {quest:35010} 就能见到他。
需要以下物品才能购买：]]
L['phoenix_wishwing_phoenix_ember'] = '%s {item:199099}\n从 {location:火焰之地时光漫游} 的 {npc:52530} 掉落'
L['phoenix_wishwing_sacred_ash'] = '%s {item:199097}\n可以在 {object:烹锅} 中找到，位于 {location:阿兰卡峰林} 附近。'
L['phoenix_wishwing_inert_ash'] = '%s {item:199092}\n位于 {location:安戈洛环形山} {dot:Gray} 中心的 {npc:6520} 和 {npc:6521} 少量掉落。'
L['phoenix_wishwing_smoldering_ash'] = [[
%s {item:199080}

在 {location:巨龙群岛} 刷各种 {npc:凤凰} {dot:Yellow}，例如 {npc:181764} 或 {npc:195448}。
这些大多位 于{location:觉醒海岸} 的 {location:黑曜堡垒} 周围。
]]
L['phoenix_wishwing_ash_feather'] = [[
%s {item:202062}

要查看 {object:羽毛}，需要从 {location:觉醒海岸} 的 {location:黑曜王座} 的 {npc:189207} {dot:Green} 处购买 {item:199177}。
使用这条项链并捡起位于 {location:燃烧高地} 和 {location:熔渣沼泽} 中的 {item:202062} {dot:Red}，它们在 {location:黑曜王座} 周围的区域。
]]
L['phoenix_wishwing_info'] = '这是位于 {location:巨龙群岛} 的 {location:觉醒海岸} 的 {item:193373} 收藏品的一部分。'

L['bugbiter_tortoise_note'] = '收集 {item:202082} {dot:Red} 和 {item:202084} {dot:Green} 并在 {npc:187077} 兑换 {item:202085}。\n\n{npc:187077} 需要世界任务 {wq:辉刃之骨} 激活。'

L['naszuro_apex_canopy'] = '在楼梯的一根小柱子上。'
L['naszuro_obsidian_throne'] = '在宝座的左侧，{npc:185894} 和 {npc:187495} 所在的位置。'
L['naszuro_ruby_lifeshrine'] = '龙雕像爪子的下面。'
L['naszuro_dragonheart_outpost'] = '在树的树枝上。'

L['box_of_rocks_label'] = '一箱岩石'
L['box_of_rocks_note'] = '{object:一箱岩石} 可以在 {location:觉醒海岸} 整个地区，或者{location:禁忌离岛} 的 {location:兹斯克拉宝库} 内找到，也可以从拍卖行购买。'
L['options_icons_many_boxes'] = '{achievement:18559}'
L['options_icons_many_boxes_desc'] = '显示 {achievement:18559} 成就中 {object:一箱岩石} 可能的位置。'

L['drakonid_painting'] = '龙人绘画'
L['emptied_hourglass'] = '空荡荡的沙漏'
L['rusted_signal_horn'] = '生锈的传信号角'
L['rusted_signal_horn_note'] = '在顶层。'

-------------------------------------------------------------------------------
------------------------------- Zaralek Cavern --------------------------------
-------------------------------------------------------------------------------

L['in_deepflayer_nest'] = '位于 {location:深岩剥石者之巢}'

L['brulsef_the_stronk_note'] = '从 {object:丰盛收获宝箱} 拾取奖励。\n\n{bug:当他引导 {spell:412495} 或施放 {spell:412492} 时不要击败他，否则打败他没有宝箱。}'

L['ancient_zaqali_chest_note'] = '使用附近的 {object:瓶装岩浆} 打开宝箱。'
L['blazing_shadowflame_chest_note'] = '装备 {item:15138}，可以从拍卖行购买或由制皮制作，以拾取宝箱。'
L['crystal_encased_chest_note'] = '与蓝色 {object:调和水晶} {dot:Blue} 和红色 {object:调和水晶} {dot:Red} 一起互动打开宝箱。'
L['old_trunk_note'] = '寻找并收集 {npc:204277} 5次，获得 {item:204323}。{note:第一只老鼠在箱子旁边。}'
L['well_chewed_chest_note'] = '{item:202869} {dot:Green} 在洞穴内隐藏在 {npc:199962} 下面。'

L['molten_hoard_label'] = '熔火宝藏'
L['fealtys_reward_label'] = '忠诚的奖赏'
L['fealtys_reward_note'] = '跪 {emote:/下跪}，{emote:/kneel} 在西南的龙雕像前，直到它喷火才能打开宝箱。'
L['dreamers_bounty_label'] = '沉睡者的奖赏'
L['dreamers_bounty_note'] = '{object:沉睡者的奖赏} 只能在身上有来自附近 {npc:201068} 的 {spell:400066} 负面效果时被拾取。'
L['moth_pilfered_pouch_label'] = '蛾子窃取的袋子'
L['moth_pilfered_pouch_note'] = '帮助 {npc:203225} 通过“杂耍”飞行，直到它有5层 {spell:405358}。\n\n然后它会飞到袋子上展示。'
L['waterlogged_bundle_label'] = '浸水的包裹'

L['stolen_stash_label'] = '失窃的货物'
L['ritual_offering_label'] = '仪式供品'
L['options_icons_ritual_offering'] = '仪式供品'
L['options_icons_ritual_offering_desc'] = '显示 {object:仪式供品} 可能的位置。'
L['nal_kskol_reliquary_label'] = '纳·克斯寇圣物匣'
L['nal_kskol_reliquary_note'] = '使用 {object:圣物匣开启控制台} 并解开拼图以打开 {object:纳·克斯寇圣物匣}。'

L['busted_wyrmhole_generator_note'] = '从 {object:坏掉的龙洞发生器} 一起拾取的 {item:205954}。\n使用后为 {item:198156} 解锁 {location:查拉雷克洞窟} 的虫洞选项。'
L['molten_scoutbot_note'] = '打开 {object:熔火斥候机器人} 并拾取 {item:204855}.'
L['bolts_and_brass_note'] = '打开 {object:螺栓和黄铜} 并拾取 {item:204850}。'

L['sniffen_sage_suffix'] = '找到特殊物品'
L['sniffen_digs_suffix'] = '嗅味探寻已完成'

L['big_slick_note'] = '从 {npc:201752} 完成的每日任务达到 {faction:2568} 阵营的声望等级“专业”（总计2800声望），以获得坐骑。\n\n或者向他展示以下25级的蜗牛（宠物）以获得100声望：'
L['grogul_note'] = '与 {npc:204672} 交谈并选择一种可以用来鼓励这只蜗牛移动得更快的食物。\n{note:该成就可以在名望7之前获得。}'

L['saccratos_note'] = '用 {item:204727} 换取宠物，坐骑和其他。'
L['ponzo_note'] = '用 {item:204985} 换取幼龙定制，宠物，坐骑和其他。'

L['smelly_trash_pile_label'] = '臭垃圾堆'
L['options_icons_smelly_trash_pile'] = '臭垃圾堆'
L['options_icons_smelly_trash_pile_desc'] = '显示 {object:臭垃圾堆} 可能的位置。'

L['smelly_treasure_chest_label'] = '臭垃圾箱'
L['options_icons_smelly_treasure_chest'] = '臭垃圾箱'
L['options_icons_smelly_treasure_chest_desc'] = '显示 {object:臭垃圾箱} 可能的位置。'

L['seething_cache_treasure_note'] = '为了能够看到 {object:沸燃之箱} 并拾取 {item:192779}，需要从位于 {location:查拉雷克洞窟} 的 {location:扎卡利喷口} 区域的 {object:沸燃宝珠} 获得3层 {spell:399342} 负面效果。'
L['chest_of_the_flights_treasure_note'] = '要打开宝箱，需要按 {note:红 > 黑 > 蓝 > 黄 > 绿} 的顺序点击 {object:强化宝石}。'
L['curious_top_hat_note'] = '在拥有 {spell:410288} 增益时与 {npc:205010} 互动并得到 {item:205021}。如果没有增益并靠近他，他就会逃跑。'

L['the_gift_of_cheese_note_1'] = '点击 {location:黑曜之巢} 内的 {object:吱吱叫的奶酪}，{item:204871} 将进入你的背包。'
L['the_gift_of_cheese_note_2'] = '与 {item:204871} 互动得到 {item:204872}。 {note:（5分钟冷却时间）}'
L['the_gift_of_cheese_note_3'] = '当拥有30个 {item:204872} 后，将残页合并即可获得食谱。'
L['the_gift_of_cheese_note_4'] = '{note:这只老鼠喜欢奶酪，大约每三分钟就会吃掉一个 {item:3927}。合理应对！}'
L['the_gift_of_cheese_note_5'] = '一旦可以制作 {item:204848}，只需在全艾泽拉斯找到并喂食50个 {npc:4075} 即可完成成就。'

L['zaralek_rare_active'] = '|cFF0066FF此稀有今日出现。|r'
L['zaralek_rare_inactive'] = '|cFFFF8C00此稀有今日不出现，明日再来。|r'
L['zaralek_event_active'] = '|cFF0066FF此区域事件今日开始。|r'
L['zaralek_event_inactive'] = '|cFFFF8C00此区域事件今日不开始，明日再来。|r'

L['options_icons_zone_event'] = '区域事件'
L['options_icons_zone_event_desc'] = '显示区域事件的位置。'

L['djaradin_scroll'] = '贾拉丁卷轴'
L['forgotten_incense'] = '被遗忘的熏香'
L['forgotten_incense_note'] = '{note:由于任务边界的问题难以到达。}'
L['historied_heirloom'] = '历史传家宝'
L['rusted_dirt_pale'] = '灰色锈尘'
L['rusted_dirt_pale_note'] = '{note:在点击本区域的其他 {object:满载信息的线索} 后会消失。}'
L['niffen_pickaxe'] = '鼹鼠人矿锄'
L['chipped_grub_pot'] = '有缺口的虫锅'
L['chipped_grub_pot_note'] = '在塔顶。'

-------------------------------------------------------------------------------
------------------------------- Emerald Dream ---------------------------------
-------------------------------------------------------------------------------

L['options_icons_emerald_dream_safari'] = '{achievement:19401}'
L['options_icons_emerald_dream_safari_desc'] = '显示 {achievement:19401} 成就中战斗宠物的位置。'

L['envoy_of_winter_note'] = '收集 {item:208881}，并在井附近使用 {spell:421658}，直到 {npc:209929} 出现。'
L['fruitface_note'] = '请求 {npc:209950} {dot:Pink} 帮你获得 {spell:421446}，然后让地上的 {item:208837} 显形。捡起它们使得 {npc:209980} {dot:Yellow} 现身。攻击然后跟随他直至他跳入水中 {dot:Red} 并且召唤 {npc:209966} 和 {npc:209913}。'
L['greedy_gessie_note'] = '需要收集 {object:野生青菜}，{object:红玉之鳞甜瓜} 和 {object:橙根}，并将其放置在 {npc:210285} 旁的篮子，以开启战斗。'
L['nuoberon_note'] = '追逐乌龟，对猴子扔食物，或与梦境野兽战斗来帮助 {npc:209101} 做个有趣的梦！'
L['reefbreaker_moruud_note'] = '利用附近全部6个 {npc:210089} 来攻击 {npc:209898}。'
L['splinterlimb_note'] = '在叠加8层 {spell:420009} 负面效果后变为敌对。每完成一轮负面效果都会叠加。击杀攻击他的怪物，以便他可以更快地完成轮数。'
L['surging_lasher_note'] = '当这片区域的 {location:翡翠狂乱} 事件激活时，会在此刷新。'
L['talthonei_ashwisper_note'] = '击杀周围区域的怪物，直到被击杀的怪物说“我会报仇”后稀有出现。'
L['talthonei_ashwisper_wq_note'] = '{note:仅在世界任务 {wq:传送门恐慌} 处于活动状态时才能在此出现。}'

L['in_a_tree'] = '在树上。'
L['inside_building'] = '在建筑里面。'

L['hidden_moonkin_stash_label'] = '隐秘的枭兽藏匿物'
L['magical_bloom_note'] = '追逐 {npc:210544} 直至他揭示宝藏。'
L['pineshrew_cache_note'] = '在一些石块旁。'
L['reliquary_of_ashamane_note'] = '{note:如果世界任务 {wq:树妖消防演习} 激活时，需要先完成任务才能看见宝藏。}\n\n在 {dot:Green} 附近找到并触摸 {object:阿莎曼的印记}，在有 {spell:425426} 陪同时回 {npc:212009} 处。'
L['reliquary_of_aviana_note'] = '在 {dot:Green} 附近找到并触摸 {object:艾维娜的印记}，在有 {spell:425432} 陪同时回 {npc:212011} 处。'
L['reliquary_of_goldrinn_note'] = '在 {dot:Green} 附近找到并触摸 {object:戈德林的印记}，在有 {spell:425408} 陪同时回 {npc:212012} 处。'
L['reliquary_of_ursol_note'] = '在 {dot:Green} 附近找到并触摸 {object:乌索尔印记}，在有 {spell:423306} 陪同时回 {npc:210732} 处。'
L['triflesnatchs_roving_trove_note'] = '追随 {npc:210060} 在枝头间的飞翔路线。'

L['unwaking_echo_label'] = '酣梦回响'
L['unwaking_echo_note'] = '{note:只能在梦中打开这个箱子。}\n\n在旁边使用表情 {emote:/睡觉}，{emote:/sleep} 进入梦中开启箱子。'

L['amirdrassil_defenders_shield_note'] = '在{npc:211328}旁边的桌上。'
L['dreamtalon_claw_note'] = '在树干的底部。'
L['essence_of_dreams_note'] = '在浮空的圆形树枝上。'
L['exceedingly_soft_wildercloth_note'] = '建筑物内的一把椅子后面。'
L['experimental_dreamcatcher_note'] = '在浮空树上。'
L['grove_keepers_pillar_note'] = '就在洞穴入口前。'
L['handful_of_pebbles_note'] = '在雕像的右肩上。'
L['molted_faerie_dragon_scales_note'] = '花丛之中。'
L['petrified_hope_note'] = '在树桩上。'
L['plush_pillow_note'] = '小屋内的一张桌子上。'
L['snuggle_buddy_note'] = '在一艘小船里。'

L['dreamseed_soil_label'] = '梦境之种壤土'
L['dreamseed_soil_note'] = [[
{currency:2650} 的捐献进度, 决定了在 {object:梦境之种秘宝} 中 {object:翡翠花蕾奖励} 的品质和找到 {item:210059} 的几率。

{item:210224}（捐献 {currency:2650} 至少1次）
{item:210225}（进度50%）
{item:210226}（进度100%）

{object:梦境之种} 的品质决定了奖励的类型：
{item:208066}：一个装饰品或专业材料。
{item:208067}：一个宠物或专业材料。
{item:208047}：一个坐骑或专业材料。

{note:奖励列表请查看岛屿北部的 {npc:211265}，她也出售大部分奖励。}
]]
L['dreamseed_cache'] = '梦境之种秘宝'
L['options_icons_dream_of_seeds'] = '{achievement:19013}'
L['options_icons_dream_of_seeds_desc'] = '显示 {achievement:19013} 成就中 {object:梦境之种壤土} 的位置。'
L['the_seeds_i_sow_suffix'] = '翡翠奖赏种子已捐献'

L['bloom_man_group_suffix'] = '野性漫溢能量已用次数'
L['dream_chaser_suffix'] = '迷途之梦已收集'
L['dreamfruit_label'] = '美梦果'
L['dreamfruit_note_1'] = '{location:超然盛放} 事件开始时显现。事件每整点钟开始。'
L['dreamfruit_note_2'] = '{location:超然盛放} 事件开始后的第一站显现。事件在 {location:阿梅达希尔} 周围，每整点钟开始。'
L['options_icons_dreamfruit'] = '{achievement:19310}'
L['options_icons_dreamfruit_desc'] = '显示 {achievement:19310} 成就中美梦果的位置。'

L['options_icons_moonkin_hatchling'] = '{achievement:19293}'
L['options_icons_moonkin_hatchling_desc'] = '显示 {achievement:19293} 成就中枭兽宝宝的位置。'
L['moonkin_hatchling_note'] = '需要 {wq:关切利爪} 世界任务激活。'

L['druid_glyphs_label'] = '德鲁伊印记'
L['druid_glyphs_sublabel'] = '{note:这不是一个德鲁伊印记，而是清单！}'
L['druid_glyphs_note'] = '在 {location:翡翠梦境} 中，通过各种途径，收集 {note:德鲁伊印记}。'
L['druid_glyphs_checklist_note'] = '追踪 {location:翡翠梦境} 中稀有物品的每日击杀数。只有具有所需拾取的 {npc:NPC} 才会出现在列表中。\n\n每日击杀数将标记为 ' .. '|cFF00FF00已完成|r' .. '。'

L['pollenfused_bristlebruin_fur_sample_note'] = '在 {location:焦烬之壤} 的一颗树根处拾取 {object:花粉灌注的鬃罴毛皮样本}。'

L['mbc_note_start'] = '拾取 {object:一箱小瓶子}，得到{item:210991}。\n\n你得到6个 {item:210839}，需要用来自各大陆的月亮井水来装满。'
L['mbc_note_end'] = '混合6个 {item:210876} 制造{item:210977}，然后来到 {location:阿梅达希尔} 的 {object:野性梦境石}。\n\n使用 {item:210977} 并拾取 {object:月福之爪}，得到 {item:210728}。'

L['mbc_vial_b'] = '破碎群岛'
L['mbc_vial_d'] = '德拉诺'
L['mbc_vial_e'] = '东部王国'
L['mbc_vial_k'] = '卡利姆多'
L['mbc_vial_n'] = '诺森德'
L['mbc_vial_o'] = '外域'

L['mbc_vial_b_location'] = '萨斯塔拉盆地'
L['mbc_vial_d_location'] = '星落哨站'
L['mbc_vial_e_location'] = '黎明森林'
L['mbc_vial_k_location'] = '怒风兽穴'
L['mbc_vial_n_location'] = '群星之墓'
L['mbc_vial_o_location'] = '塞纳里奥避难所'

L['mbc_vial_location'] = '携带 {item:%d} 到 {location:%s} 的月亮井（{location:%s}，{location:%s}），灌满井水，得到 {item:%d}。'

L['mbc_moonwell_label'] = '月亮井'
L['mbc_feral_dreamstone_label'] = '野性梦境石'

L['azure_somnowl_note'] = '完成一个从 {npc:209318} 领取的 {quest:78065} 作为开始的简短任务线，奖励 {item:210645}。'

L['slumbering_somnowl_note_a'] = '对 {location:翡翠梦境} 里各种 {npc:寐枭} 施放 {spell:2637} 然后 {spell:426183}，收集5个 {item:210565}。'
L['slumbering_somnowl_note_b'] = '从商人处购买一个 {item:4291}。'
L['slumbering_somnowl_note_c'] = '将5个 {item:210565} 和1个 {item:4291} 组成 {item:210566}。'
L['slumbering_somnowl_note_d'] = '获得一个 {item:194864}。'
L['slumbering_somnowl_note_e'] = '将 {item:210566} 和 {item:194864} 组成 {item:210535}。'

L['thaelishar_vendor_note'] = '用金币来购买德鲁伊印记。'
L['silent_mark_label'] = '繁梦峭壁'
L['silent_mark_note'] = '对目标动物引导，使印记与其形态协调，直至获得 {spell:426910}。{note:需要协调10多只动物。}\n\n用 {item:210764} 引导 {npc:210892}。\n\n用 {item:210767} 引导 {npc:211347}、{npc:211283} 或 {npc:210894}。\n\n用 {item:210755} 引导 {npc:210594}。\n\n用 {item:210766} 引导 {npc:209494}，{npc:212028}，或 {npc:212024}。'

L['amirdrassil'] = '阿梅达希尔，梦境之愿'
L['prismatic_location'] = '在团队副本 {location:阿梅达希尔，梦境之愿} 内。'
L['prismatic_note_1'] = '1. 从 {location:圣泉中庭} 的水池中钓10条 {item:210782}'
L['prismatic_note_2'] = '2. 从 {location:焰灼大厅} 的岩浆中钓10条 {item:210783}。'
L['prismatic_note_3'] = '3. 把10条鱼扔进 {location:圣泉中庭} 最大的水池中，得到30分钟的增益 {spell:427145}。'
L['prismatic_note_4'] = '4. {location:圣泉中庭} 的水池中显现 {object:棱光腮须鱼群}，从中可以钓到 {item:210784}。'
L['prismatic_note_5'] = '5. 将 {npc:奇娜} 放生回 {location:圣泉中庭} 的水池中，会得到{item:210753}。'

L['options_icons_druid_glyph'] = '德鲁伊印记'
L['options_icons_druid_glyph_desc'] = '显示 {note:德鲁伊印记} 的位置。'

L['elianna_vendor_note'] = '完成 {location:翡翠梦境} 中的各项活动会奖励 %s (隐藏货币)。\n\n%s 达到7,000时可以从 {npc:211209} 处，解锁任务 {quest:78598}，奖励1个 {currency:2777}。\n\n用 {currency:2777} 来购买宠物和坐骑。'
L['dream_energy_name'] = '梦境能量'
L['dream_energy_info'] = '%s：%d/%d (%.1f%%)'

L['sylvia_vendor_note'] = '用 {currency:2651} 来购买宠物，坐骑，幻化，也可从梦种中获得。'

L['somnut'] = '眠果'
L['options_icons_somnut'] = '眠果'
L['options_icons_somnut_desc'] = '显示 {object:眠果} 可能的位置。'

L['improvised_leafbed_note'] = '完成从 {quest:77896} 起始的任务线，从 {npc:210164} 得到奖励 {item:210864}。'
L['kalandu_note'] = '完成从 {quest:77948} 起始的任务线，从 {npc:210196} 得到奖励 {item:210633}。'

L['ochre_note'] = '和 {npc:209253} 对话开始任务线，{npc:209571} 会布置接下来的任务。'
L['ochre_note_stage1'] = '{quest:77677}。{note:生长期5天。}'
L['ochre_note_stage2'] = '{quest:78398}。{note:生长期5天。}'
L['ochre_note_stage3'] = '{npc:209571} 让你收集5个 {item:4537} {dot:Yellow}，3个 {item:209416} {dot:Green}，5个 {item:208644} {dot:Red}，将它们合成 {item:208646}。{note:需要等待3天} 形成 {item:208647} 后，才能完成 {quest:77697}。{note:生长期5天。}'
L['ochre_note_stage4'] = '{quest:77711}。{note:生长期5天。}'
L['ochre_note_stage5'] = '{quest:77762}。'

L['thorn_beast_stag'] = '{item:%d}（{npc:鹿}）'
L['thorn_beast_saber'] = '{item:%d}（{npc:豹}）'
L['thorn_beast_bear'] = '{item:%d}（{npc:熊}）'

L['thornbeast_disclaimer'] = '{note:注意：每种野兽的 {item:%s} 虽同名但不一样。}'

L['thorn_laden_heart_note_1'] = '从 {location:翡翠梦境} 的任意 {npc:梦麋}、{npc:梦刃豹} 或 {npc:鬃罴} 三类野兽身上拾取到3种不同的 {item:209860}。'
L['thorn_laden_heart_note_2'] = '获得一种野兽的 {item:209860} 之后, 去 {location:库尔提拉斯} 的 {location:德鲁斯瓦}, 找一只名唤 {npc:140044} 的母鹿。'

L['athainne_note_1'] = '{note:{npc:140044} 夜晚与 {npc:129771} 一起漫步，白天在 {location:奥尔法的兽穴} 休憩。}\n\n请求 {npc:140044} 祝福 {item:209860} 来制造 {item:209863}。'
L['athainne_note_2'] = '得到 {item:209863} 之后, 去 {location:奥尔法的兽穴} 向 {npc:141159}求助。'

L['ulfar_note_1'] = '请求 {npc:149386} 使用 {item:209863} 来制作 {item:209866}。'
L['ulfar_note_2'] = '获得 {item:209866} 之后，回 {location:翡翠梦境}，为转化仪式找到合适的目标。'

L['thorn_stag_note'] = '1. 杀死 {npc:210976}，对尸体使用 {item:209866}。梦麋重生为 {npc:210984} {npc:<荆生幽魂>}。\n\n2. 对其施放 {spell:1515}。\n\n3. {npc:210984} 有三种颜色(黑, 褐, 绿)。'
L['thorn_saber_note'] = '1. 杀死 {npc:210975}，对尸体使用 {item:209867}。梦刃豹重生为 {npc:210981} {npc:<荆生幽魂>}。\n\n2. 对其施放 {spell:1515}。\n\n3. {npc:210981} 有三种颜色(黑, 绿, 灰)。'
L['thorn_bear_note'] = '1. 杀死 {npc:210977}，对尸体使用 {item:209868}。鬃罴重生为 {npc:210988} {npc:<荆生幽魂>}。\n\n2. 对其施放 {spell:1515}。\n\n3. {npc:210988} 有三种颜色(褐, 暗, 绿)。'

L['nahqi_note'] = '要对 {npc:210908} 施放 {spell:1515}，需要 {item:211314}。这来自于 {item:210061}。\n\n{npc:210908} {npc:<愈合余烬>} 围绕在 {location:阿梅达希尔} 高空 {note:逆时针} 绕圈缓慢飞翔，一圈下来耗时 17:30。 \n它的刷新时间最少30分钟。\n\n{note:这是只{npc:灵魂兽}。只有兽王猎人能驯服。}'

L['sulraka_note'] = '{npc:210868} {npc:<吉布尔之女>} 在 {location:阿梅达希尔} 东方以 {note:逆时针} 路线巡游，大约17分钟绕一周。\n它的刷新时间最少30分钟。\n\n当它行进时会在身后留下 {object:笨重的踪迹}，持续3分钟。\n由于一直潜行状态，需要在一个刚刚刷新的 {object:笨重的踪迹} 前面使用 {spell:1543} 来让其显形。\n先施放 {spell:257284} 和（或）{spell:187650}，再尝试 {spell:1515}。\n\n{note:注意：{npc:210868} 即使受到攻击也不会停止前行，所以一定要使用陷阱或照明。否则 {spell:1543} 会在超距后取消施法。}\n\n{note:这是只 {npc:灵魂兽}。只有兽王猎人能驯服。}'

L['alarashinu_note'] = '{item:210961}，一把隐藏的带有邪色的自然战刃。\n\n{note:特殊视觉效果：}\n装备或幻化阿莱纳希努使用 {spell:195072} / {spell:189110} / {spell:198793} 时会留下一串花迹！'
L['alarashinu_note_stage1'] = '与 {location:翡翠梦境} 的 {location:中心营地} 的 {npc:213029} 交谈。'
L['alarashinu_note_stage2'] = '前往 {location:破碎海滩 } 的 {location:失落的神殿}，见 {npc:213114}。'
L['alarashinu_note_stage3'] = '前往 {location:瓦尔莎拉 } 的 {location:月神殿}，见 {npc:213186}。'
L['alarashinu_note_stage4'] = '记忆结束后，一个 {npc:213248} 会带着他的战刃出现。'
L['alarashinu_note_stage5'] = '用邪能火焰灌注 {npc:213308}。'
L['alarashinu_note_stage6'] = '拾取 {npc:213381} 并获得 {item:210961}。'
L['alarashinu_note_end'] = '返回 {npc:213029}，在获得这把战刃后，他会出现一个奖励对话框。'

-------------------------------------------------------------------------------
----------------------------- SECRETS OF AZEROTH ------------------------------
-------------------------------------------------------------------------------

-- Secrets of Azeroth: Clue 1
L['soa_01_rlabel'] = '（线索一）'
L['soa_01_golden_chalice_note'] = '将 {item:208056} 放入 {location:瓦德拉肯} 的 {location:瓦德拉肯藏宝库} 中。'

-- Secrets of Azeroth: Clue 2
L['soa_02_rlabel'] = '（线索二）'
L['soa_02_kathos_note'] = '与 {npc:206864} 交谈得到 {item:207105}。\n\n将 {item:207105} 带给 {location:碧蓝林海} {location:伊斯卡拉} 的 {npc:186448}。'
L['soa_02_shomko_note_a'] = '与 {npc:186448} 交谈得到 {item:207580}。'
L['soa_02_shomko_note_b'] = '将 {item:207580} 放置在 {location:诺森德} {location:北风苔原} 的 {location:裂鞭海岸} 的 {object:仪式长矛} 处。'
L['soa_02_shomko_note_c'] = '{note:一定要留下来并击杀 {npc:208182} 以获得 {item:207594}。}'

-- Secrets of Azeroth: Clue 3
L['soa_03_rlabel'] = '（线索三）'
L['soa_03_fangli_hoot_note_a'] = '与 {npc:207696} 交谈得到 {item:207802}。需要通过收集各种部件来合成 {item:207827}：'
L['soa_03_fangli_hoot_note_b'] = '在 {location:瓦德拉肯} 用5个 {item:207956} 与 {npc:185548} 换取 {item:207814}。'
L['soa_03_fangli_hoot_note_c'] = '在 {location:瓦德拉肯} 用1个 {item:207812} 与 {npc:197781} 换取 {item:207813}。'
L['soa_03_fangli_hoot_note_d'] = '支付 {location:瓦德拉肯} 酒吧费用后，从 {npc:198586} 得到1个 {item:207816}。'
L['soa_03_fangli_hoot_note_e'] = '将部件组合起来即可获得 {item:207827} 并开始 {location:瓦德拉肯} 的 {npc:207697} 的 {quest:77237}。'
L['soa_03_fangli_clue_label'] = '方利的线索'
L['soa_03_fangli_clue'] = '靠近 {location:翡翠飞地} 的瀑布。'
L['soa_03_erugosa_note_a'] = '与 {npc:185556} 交谈得到 {item:208416}。需要为她收集以下物品：'
L['soa_03_erugosa_note_b'] = '从 {location:欧恩哈拉平原} 的 {location:森步岗哨} 的 {npc:194152} 购买5个 {item:198441}。'
L['soa_03_erugosa_note_c'] = '从 {location:索德拉苏斯} 的 {location:瓦德拉肯} 的 {npc:196729} 购买5个 {item:201419}。'
L['soa_03_erugosa_note_d'] = '从 {location:查拉雷克洞窟} 的 {location:峈姆} 的 {npc:204371} 购买5个 {item:205693}。'
L['soa_03_clinkyclick_note_a'] = '与 {npc:185548} 交谈得到 {item:207814}。需要：'
L['soa_03_clinkyclick_note_b'] = '从 {location:瓦德拉肯} 的 {location:脆烤山羊旅店} 中的 {npc:185556} 处获得10个 {item:207956}。'
L['soa_03_gryffin_note_a'] = '与 {npc:197781} 交谈得到 {item:207813}。需要收集：'
L['soa_03_gryffin_note_b'] = '通过击杀 {location:瓦德拉肯} 的 {location:飞瀑之缘} 中的 {npc:191451} 来拾取1个 {item:207812}。' -- cascades
L['soa_03_shakey_note_a'] = '与 {npc:198586} 交谈得到 {item:207816}。'
L['soa_03_shakey_note_b'] = '在 {location:瓦德拉肯} 的 {location:巨龙宝藏} 支付 {npc:198586} 的酒吧费用。'
L['soa_03_shakey_note_c'] = '通过 {location:脆烤山羊旅店} 后面的 {object:奇怪的雕像} 秘密入口处使用表情 {emote:/鞠躬}，{emote:/bow} 进入 {location:The 巨龙宝藏}。'

-- Secrets of Azeroth: Clue 4
L['soa_04_rlabel'] = '（线索四）'
L['soa_04_locker_label'] = '捍卫者的柜子'
L['soa_04_sazsel_note_a'] = '从 {location:脆烤山羊旅店} 顶层的 {object:捍卫者的柜子} 中拾取 {item:208130} 并将其带给 {location:瓦德拉肯} 的 {npc:208620}。'
L['soa_04_sazsel_note_b'] = '鉴定完毕后，将旗子放回箱子并返回 {npc:207697}。'

-- Secrets of Azeroth: Clue 5
L['soa_05_rlabel'] = '（线索五）'
L['soa_05_torch_of_pyrreth_note_a'] = '激活在 {location:觉醒海岸} {location:生命缚誓者花园} 附近发现的3个 {object:古老的拉杆} 来揭示 {item:208135}。'
L['soa_05_torch_of_pyrreth_note_b'] = '收集完毕后返回 {location:瓦德拉肯} {location:脆烤山羊旅店} 的 {npc:206864}。'
L['soa_05_torch_of_pyrreth_note_c'] = '使用 {item:208092} 获得 {spell:419127} 增益。现在可以显示 {npc:209011}，会出现一个 {object:魔法之箱}。'
L['soa_05_ancient_lever_label'] = '古老的拉杆'
L['soa_05_ancient_lever_note_a'] = '在废墟建筑后面 {npc:195915} 的后面。'
L['soa_05_ancient_lever_note_b'] = '废墟塔内。'
L['soa_05_ancient_lever_note_c'] = '在 {npc:186823} 和 {npc:186825} 附近的建筑物内。'
L['soa_05_enchanted_box_label'] = '魔法之箱'

-- Secrets of Azeroth: Clue 6
L['soa_06_rlabel'] = '（线索六）'
L['soa_06_unvieled_tablet_label'] = '现世的石板'
L['soa_06_unvieled_tablet_note_a'] = '与 {npc:207696} 交谈完成任务 {quest:77284} 并得到 {item:208137}。\n\n然后前往 {location:碧蓝林海} 的 {location:瓦克索斯}。'
L['soa_06_unvieled_tablet_note_b'] = '在 {location:碧蓝林海} {location:瓦克索斯} 塔底部的使用 {item:208092} 来揭示 {object:现世的石板}。'
L['soa_06_unvieled_tablet_note_c'] = '拾取 {item:208143} 并返回 {location:瓦德拉肯} 的 {npc:207696} 以完成秘密。'

-- Secrets of Azeroth: Clue 7
L['soa_07_rlabel'] = '（线索七）'
L['soa_07_brazier_label'] = '上古熏香火盆'
L['soa_07_brazier_note_a'] = '与 {npc:185562} 交谈完成任务 {quest:77303} 并获得 {item:208144}。\n\n前往 {location:欧恩哈拉平原} 附近的 {location:永恒库尔干}。'
L['soa_07_brazier_note_b'] = '在上古坟墓内使用 {item:208135} 点燃 {object:上古熏香火盆}。'
L['soa_07_idol_note'] = '拾取 {object:上古熏香火盆} 旁边被揭示的 {item:207730} 并返回 {location:瓦德拉肯}。'

-- Secrets of Azeroth: Clue 8
L['soa_08_rlabel'] = '（线索八）'
L['soa_08_kathos_note'] = '与 {npc:206864} 交谈得到 {item:206948}。\n\n飞到 {location:索德拉苏斯} 的 {location:变换流沙} 并使用 {item:207730} 找到3个 {item:208191}。'
L['soa_08_time_lost_fragment_note'] = '在 {location:索德拉苏斯} 的 {location:变换流沙} 使用 {item:208135} 找到3个 {item:208191}。\n\n将所有3个组合起来创建 {item:208146} 并返回 {location:瓦德拉肯} 的 {npc:206864}。'
L['soa_08_tl_fragment_location_a'] = '小树下。'
L['soa_08_tl_fragment_location_b'] = '两块大石头之间。'
L['soa_08_tl_fragment_location_c'] = '在小河的底部。'

-- Secrets of Azeroth: Clue 9
L['soa_09_rlabel'] = '（线索九）'
L['soa_09_bobby_note'] = '与 {npc:207696} 交谈以开始任务 {quest:77653}。在 {npc:195769} 交任务得到 {item:208486}。\n\n然后前往 {location:欧恩哈拉平原} 的 {location:林荫之森}。'
L['soa_09_hastily_scrawled_stone_label'] = '有潦草字迹的石头'
L['soa_09_hastily_scrawled_stone_note'] = '使用 {item:208092} 来揭示{object:有潦草字迹的石头}，然后是附近的 {object:古老的钥匙模具}。'
L['soa_09_ancient_key_mold_label'] = '古老的钥匙模具'
L['soa_09_ancient_key_mold_note'] = '拾取 {object:古老的钥匙模具} 得到 {item:208827} 以开始任务 {quest:77822}。\n\n返回 {location:瓦德拉肯} 的 {npc:195769}。'

-- Secrets of Azeroth: Clue 10
L['soa_10_rlabel'] = '（线索十）'
L['soa_10_tyrs_titan_key_note'] = '从 {npc:207696} 领取任务 {quest:77829} 并前往 {npc:210837} 得到 {item:208829}。\n\n在 {location:觉醒海岸} 收集 {item:208835} 和 {item:208836} 并在 {location:黑曜堡垒} 重铸钥匙。'
L['soa_10_rose_gold_dust_note'] = '收集50个 {item:208835}，使用 {item:207730} 找到地板上的红色小石子。\n\n找到50个 {item:208835} 和8个 {item:208836} 后前往 {location:黑曜堡垒} 的 {npc:210837}。'
L['soa_10_igneous_flux_note'] = '在熔岩与盐水相遇的 {location:觉醒海岸} 的各个位置收集8个 {item:208836}。\n\n找到50个 {item:208835} 和8个 {item:208836} 后前往 {location:黑曜堡垒} 的 {npc:210837}。'
L['soa_10_weaponsmith_koref_note'] = '与 {npc:210837} 交谈并开始任务 {quest:77831}，帮助他用材料和 {item:208092} 重铸 {item:208831}。'

-- Secrets of Azeroth: Clue 11
L['soa_11_rlabel'] = '（线索十一）'
L['soa_11_rlabel_optional'] = '（线索十一 - 可选）'
L['soa_11_kathos_note'] = '与 {npc:206864} 交谈，将得到 {item:208852}。前往 {location:欧恩哈拉平原} 的 {npc:195543} 向他询问有关旗帜的事情。'
L['soa_11_sansok_khan_note'] = '询问 {npc:195543} 如何正确埋葬旗帜所属的猎人 {npc:艾什塔尔·雷森}。\n\n将得到 {item:209061} 并被要求在 {location:松木哨站} 找到 {npc:191391}。'
L['soa_11_jhara_note'] = '与旅店老板 {npc:191391} 交谈。她会给这个秘密的线索 {item:208857}。'
L['soa_11_marker_1_label'] = '第一标记'
L['soa_11_marker_2_label'] = '第二标记'
L['soa_11_marker_3_label'] = '第三标记'
L['soa_11_marker_4_label'] = '第四标记'
L['soa_11_marker_4_note'] = '坟堆中。'
L['soa_11_marker_5_label'] = '第五标记'
L['soa_11_marker_5_note'] = '如果 {wq:网中受害者} 任务处于活动状态，则必须在使用 {item:208092} 烧毁蜘蛛网并揭示线索之前完成它。'
L['soa_11_burial_banner_note'] = '深入洞穴，遇到坡道后到达顶层，在顶层的尽头，会找到一个存放 {item:208852} 的地方。'

-- Secrets of Azeroth: Clue 12
L['soa_12_rlabel'] = '（线索十二）'
L['soa_12_bobby_note'] = '与 {npc:207696} 交谈得到 {item:208888}。\n\n前往 {location:老卡拉赞} 并在 {npc:15691} 之后清理道路，然后进入 {location:守护者的图书馆}。需要在那里找到一本书，使用 {item:207730} 来追踪它。'
L['soa_12_ancient_tome_note'] = '使用 {item:207730} 搜索书籍，直到找到 {item:208889} 并将其带回位于 {location:瓦德拉肯} 的 {npc:207696}。'

-- Secrets of Azeroth: Clue 13
L['soa_13_rlabel'] = '（线索十三）'
L['soa_13_bobby_note'] = '与 {npc:207696} 交谈开始任务 {quest:77928}。'
L['soa_13_great_place_a_label'] = '拍卖行卖据'
L['soa_13_great_place_a_note'] = '{location:拍卖行} 入口处的一堆盒子上。'
L['soa_13_great_place_b_label'] = '虚空仓库收据'
L['soa_13_great_place_b_note'] = '幻化和虚空仓库建筑的一堆板条箱上。'
L['soa_13_great_place_c_label'] = '花园补给收据'
L['soa_13_great_place_c_note'] = '在一座小建筑里，两个 {npc:197035} 正在争论。'
L['soa_13_great_place_d_label'] = '研究员的笔记'
L['soa_13_great_place_d_note'] = '在一栋小建筑内，一些书旁边。'
L['soa_13_great_place_e_label'] = '字迹潦草的字条'
L['soa_13_great_place_e_note'] = '在 {ocation:匠人集市} 的供应商摊位后面。'
L['soa_13_great_place_f_label'] = '给克里沙的便条'
L['soa_13_great_place_f_note'] = '在 {location:巨龙宝藏} 内的一个箱子上。\n\n需要对 {location:脆烤山羊旅店} 中的 {npc:189827} 进行表情 {emote:/鞠躬}，{emote:/bow} 才能进入秘密酒吧。'

-- Secrets of Azeroth: Clue 14
L['soa_14_rlabel'] = '（线索十四）'
L['soa_14_tithris_note'] = '与 {npc:185562} 交谈会给 {item:208942}。然后前往 {location:索德拉苏斯} 的 {location:雷暴峰}。'
L['soa_14_buried_object_label'] = '埋藏的物品（%d）'
L['soa_14_tablet_label'] = '泰坦铭刻的石板（%d）'
L['soa_14_tablet_note'] = '使用 {item:208092} 来揭示 {object:泰坦铭刻的石板}。沿着 {item:206696} 坐标到达 {object:埋藏的物品} 并挖掘 {item:209795}。'

-- Secrets of Azeroth: Clue 15
L['soa_15_rlabel'] = '（线索十五）'
L['soa_15_kathos_note'] = '与 {npc:206864} 交谈完成任务 {quest:77959} 获得 {item:208958}。然后飞往 {location:提尔要塞} 并完成一系列任务。'
L['soa_15_tyrhold_statue_label'] = '提尔要塞雕像'
L['soa_15_tyrhold_statue_note'] = '使用 {item:208092} 接近提尔要塞雕像并进行引导，直到球体发出亮红色的光。'
L['soa_15_tyrhold_forge_label'] = '提尔要塞熔炉'
L['soa_15_tyrhold_forge_note'] = '接近 {location:提尔要塞} 中心的熔炉获得 {spell:423792} 增益。'
L['soa_15_broken_urn_note'] = '掠夺 {object:破损的瓮} 获得 {item:%d}。'
L['soa_15_broken_urn_location'] = '位于 {location:提尔要塞} %d 层。'
L['soa_15_titan_power_relay_label'] = '泰坦能量中继器'
L['soa_15_tpr_note'] = '将 {item:%d} 插入 {object:泰坦能量中继器}。'
L['soa_15_orb_label'] = '宝珠位置'
L['soa_15_orb_location'] = '{location:提尔要塞} 顶部。'
L['soa_15_orb_note'] = [[
接受任务 {quest:77977} 并检查球体以召唤 {npc:210674} 和{npc:210675}，击败他们以获得 {item:209555}。

将 {item:209555} 放入控制台以揭示 {item:208980}。
拾取宝箱并将 {item:209555} 返回揭示 {item:208980} 后在附近出现的 {npc:206864}。
]]

-- Community Rumor Mill
L['buried_satchel_note'] = '从 {object:松软的泥土堆} 中拾取 {item:208142}。'
L['buried_satchel_sublabel'] = '{note:这*不是* {item:208142} 的位置。}'

L['bs_epl_location'] = '在 {location:考林路口} 的建筑物后面。'
L['bs_fel_location'] = '在 {location:血毒瀑布} 水下中央。'
L['bs_tho_location'] = '在 {location:裂蹄堡} 的水下洞穴中。'
L['bs_smv_location'] = '在 {location:月柳山} 附近的空心树内。'
L['bs_net_location'] = '在 {location:外域} {location:虚空风暴} 的 {location:法力熔炉：布纳尔} 中。\n\n{note:需要3名玩家在附近的水晶上引导 {item:208092} 来生成 {object:松软的泥土堆}。}'
L['bs_vfw_location'] = '在金色瀑布顶部的 {npc:129151} 雕像口内。'
L['bs_tas_location'] = '使用 {item:208135} 融化 {npc:96438} 并露出 {object:松软的泥土堆}。'
L['bs_dbt_location'] = '在 {location:翡翠巨龙圣地} 的大型骷髅爪下。'
L['bs_bar_location'] = '山顶上。'
L['bs_nag_location'] = '在 {location:%s} 上方的一座浮岛上。'
L['bs_gri_location'] = '与 {npc:%s} 交谈，乘坐圆木从 {location:蓝天伐木场} 前往 {location:风险湾}。开始骑行后，将获得 {spell:423942} 增益。\n\n{note:必须拥有 {spell:423942} 增益才能看到小包。}'
L['bs_hmt_location'] = '在 {object:老化的羊皮纸} 附近的 {location:高岭之巅} 顶部。'
L['bs_wpl_location'] = '在 {location:凯尔达隆} 的马车和要塞之间。'
L['bs_tli_location'] = '在竞技场的中央地板上。'
L['bs_tir_location'] = '在山顶俯瞰 {location:自由镇}。'

L['bs_emerald_dragonshrine'] = '翡翠巨龙圣地'
L['bs_bronze_dragonshrine'] = '青铜巨龙圣地'

L['options_icons_secrets_of_azeroth'] = '艾泽拉斯之秘'
L['options_icons_secrets_of_azeroth_desc'] = '显示 {location:艾泽拉斯之秘} 线索的位置。'

-- Mimiron's Jumpjets Mount
L['soa_mjj_list_note'] = '收集所有3个零件并在 {object:已强化的奥术熔炉} 组装它们得到 {item:210022}：'
L['soa_mjj_part1_note'] = '让3名玩家用 {item:208092} 引导火盆来召唤 {npc:210398}。他会掉落 {item:208984}。'
L['soa_mjj_part2_note'] = [[{note:完成此部分，周围至少需要4人。}

在 {location:铁木森林} 中，会发现一个巨大的 {npc:210417} 和一个可以使用的 {object:米米尔隆的助推器零件}。可以使用 {object:米米尔隆的助推器零件} 来骑上元素并使用其能力 {spell:423412} 来吸人，或者跑到元素附近（但不足以接近它的范围攻击，因为它会把你击退），这样驾驶它的人就能把你吸进去。

一旦元素吸入4个人，它就会爆炸并掉落 {item:209781}！该地区的任何人都可以拾取它。]]
L['soa_mjj_part3_note'] = '{item:209055} 在 {location:诅咒之地} 的 {object:黑暗之门} 前面等你！小心该区域的 {npc:23082} 和 NPC，因为需要12秒的施法才能拾取该零件。'

-------------------------------------------------------------------------------
------------------------------- WARCRAFT RUMBLE -------------------------------
-------------------------------------------------------------------------------

L['rumble_coin_bag'] = '魔兽游戏币袋'
L['rumble_foil_bag'] = '魔兽游戏箔纸袋'
L['rumble_both_bags'] = '魔兽游戏币袋和箔纸袋'
L['warcraft_rumble_machine'] = '魔兽游戏机'

L['wr_ohn_both_01'] = '在 {location:露恩黛} 一座废弃建筑内。'
L['wr_ohn_foil_02'] = '在瀑布附近的一块岩石旁边。'
L['wr_sto_coin_01'] = '在储物箱后面。'
L['wr_sto_foil_01'] = '在一堆炮弹旁。'
L['wr_sto_foil_02'] = '在靠近通往码头的坡道。'
L['wr_tas_both_01'] = '在俯瞰 {location:捕鲸者海角} 的一棵树后面。'
L['wr_tas_foil_01'] = '在一棵巨大的断树旁边。'
L['wr_tha_both_01'] = '在 {location:提尔要塞水库} 附近的一个浮岛上。'
L['wr_tha_foil_01'] = '在一个巨大的植物花盆上。'
L['wr_tws_both_01'] = '在俯瞰水面的石塔顶。'
L['wr_tws_foil_01'] = '在俯瞰熔岩的山上。'
L['wr_tws_foil_02'] = '在俯瞰水面的小石塔上。'
L['wr_val_coin_01'] = '在 {location:脆烤山羊旅店} 一楼，{object:烹饪烤箱} 旁边。'
L['wr_val_foil_01'] = '在 {location:脆烤山羊旅店} 二楼的床上。'
L['wr_val_machine'] = '在 {location:脆烤山羊旅店} 二楼。'
L['wr_org_coin_01'] = '在 {location:破裂的獠牙} 二楼。'
L['wr_org_foil_01'] = '在 {location:拍卖行} 后面。'
L['wr_dur_foil_01'] = '在一些补给箱后面。'

L['options_icons_warcraft_rumble'] = '魔兽游戏机'
L['options_icons_warcraft_rumble_desc'] = '显示 {object:魔兽游戏币袋} 和 {object:魔兽游戏箔纸袋} 的位置以进行 {object:魔兽游戏机} 跨界促销。'

-------------------------------------------------------------------------------
--------------------------------- AMIRDRASSIL ---------------------------------
-------------------------------------------------------------------------------

L['kaldorei_backpack_label'] = '卡多雷背包'
L['kaldorei_bag_label'] = '卡多雷袋子'
L['kaldorei_bedroll_label'] = '卡多雷铺盖'
L['kaldorei_dagger_label'] = '卡多雷匕首'
L['kaldorei_horn_label'] = '卡多雷号角'
L['kaldorei_moon_bow_label'] = '卡多雷月弓'
L['kaldorei_shield_label'] = '卡多雷战盾'
L['kaldorei_spear_label'] = '卡多雷战矛'
L['kaldorei_spyglass_label'] = '卡多雷望远镜'

L['blue_kaldorei_backpack_note'] = '在 {location:贝拉纳尔} 港口商店的一个箱子上。'
L['blue_kaldorei_bedroll_note'] = '靠近月亮井的桌子后面。'
L['blue_kaldorei_pouch_note'] = '在建筑物外的一个装满液体的桶上。'
L['kaldorei_bow_carver_note'] = '在 {npc:216731} 附近的 {location:暮光瞭望塔} 顶部的桌子上。'
L['kaldorei_sentinels_spyglass_note'] = '在 {location:贝拉纳尔} 码头尽头的一个箱子上。'
L['night_elven_bow_note'] = '靠在 {location:阿里斯瑞恩基地} 的武器架上。'
L['night_elven_horn_note'] = '在 {npc:216752} 附近的 {location:暮光瞭望塔} 顶部的一个箱子上。'
L['night_elven_shield_note'] = '靠在采矿训练师 {npc:216269} 附近的一个箱子上。'
L['night_elven_signal_note'] = '挂在台阶顶上的火盆上。'
L['night_elven_spear_note'] = '靠在 {location:锋刃大厅} 的墙上。'
L['violet_kaldorei_pouch_note'] = '靠近月亮井后面的拱门底部。'

L['moon_priestess_lasara_note'] = '将 {currency:2003} 兑换成幻化。'

--wow

-------------------------------------------------------------------------------
--------------------------------- KHAZ ALGAR ----------------------------------
-------------------------------------------------------------------------------

L['options_icons_delve_rewards'] = '地下堡奖励'
L['options_icons_delve_rewards_desc'] = '在提示中显示 {location:地下堡} 的奖励。'

L['skyriding_glyph'] = '驭空术魔符'
L['options_icons_skyriding_glyph'] = '驭空术魔符'
L['options_icons_skyriding_glyph_desc'] = '显示全部驭空术魔符的位置。'

L['options_icons_profession_treasures'] = '专业宝藏'
L['options_icons_profession_treasures_desc'] = '显示给予专业知识的宝藏位置。'

L['options_icons_khaz_algar_lore_hunter'] = '{achievement:40762}'
L['options_icons_khaz_algar_lore_hunter_desc'] = '显示 {achievement:40762} 成就中剧情物品的位置。'

L['options_icons_flight_master'] = '{achievement:40430}'
L['options_icons_flight_master_desc'] = '显示 {achievement:40430} 成就中 {npc:飞行管理员} 的位置。'

L['options_icons_worldsoul_memories'] = '世界之魂的回忆'
L['options_icons_worldsoul_memories_desc'] = '显示 {object:世界之魂的回忆} 的奖励。'

-------------------------------------------------------------------------------
-------------------------------- ISLE OF DORN ---------------------------------
-------------------------------------------------------------------------------

L['alunira_note'] = '从 {location:多恩岛} 的怪物收集10个 {item:224025} 并组合成 {item:224026} 以移除她的 {spell:451570}。'
L['violet_hold_prisoner'] = '紫罗兰监狱囚犯'

L['elemental_geode_label'] = '元素晶簇'
L['magical_treasure_chest_note'] = '将 {npc:223104} 推回水中然后在附近收集5个 {npc:223159}。'
L['mosswool_flower_note'] = '点击 {npc:222956} 并跟随他。'
L['mushroom_cap_note'] = '在附近的森林中收集一个 {object:薮根伞菇} 并将其带回给 {npc:222894}。'
L['mysterious_orb_note'] = '将 {object:元素珍珠} 带回给 {npc:222847}。'
L['thaks_treasure_note'] = '与 {npc:223227} 交谈并跟随他。'
L['trees_treasure_note'] = '与 {npc:222940} 交谈，获得 {item:224185}。引导6个 {npc:224548}（{dot:Green}）绕过 {location:多恩岛} 返回 {npc:222940}。将所有螃蟹引导回来后，返回洞穴中的 {npc:222940} 并与她交谈。'
L['trees_treasure_crab_1_note'] = '在树下。'
L['trees_treasure_crab_2_note'] = '在树枝上。'
L['trees_treasure_crab_3_note'] = '在树下。'
L['trees_treasure_crab_4_note'] = '在树根下。'
L['trees_treasure_crab_5_note'] = '在崖边。'
L['trees_treasure_crab_6_note'] = '在树根下。'
L['turtles_thanks_1_note'] = '交出5个 {item:220143}（可从 {object:平静的浮面涟漪} 渔点钓鱼或从拍卖行购买）。{note:离开该区域并立即返回交出下一条鱼。}'
L['turtles_thanks_2_note'] = '交出1个 {item:222533}（可从 {object:浮光之池}，{object:溃烂的腐臭之池}，{object:飞溅的注能脓液} 渔点钓鱼或从拍卖行购买）。'
L['turtles_thanks_3_note'] = '在 {location:多恩诺嘉尔} 与 {npc:223338} 会面并与她交谈以揭示宝藏。'
L['web_wrapped_axe_note'] = '在一楼。\n\n{note:有1-2小时的刷新时间。}'
L['faithful_dog_note'] = [[
1. 在 {map:424} 的 {map:376} 的 {location:汇风岭} 处找到 {npc:59533} 并完成 {quest:30526}。
2. 在 {map:572} 的 {area:7490} 中建造 {object:药圃}。
3. 在 {map:619} {map:627} 中找到 {item:147420}，然后与 {area:7490} {object:药圃} 中的 {npc:87553} 交谈。
{npc:87553} 现在位于 {map:627} 的 {location:魔法动物店}
4. 与 {map:2248} 中的 {object:半埋的狗碗} 互动，然后抚摸 {npc:87553} 获取宠物。
]]

L['cendvin_note'] = '在 {location:烬燧荒原} 从精英怪物那里获得900个 {item:225557} 之后从 {npc:226205} 购买 {item:223153} 坐骑。'

L['options_icons_flat_earthen'] = '{achievement:40606}'
L['options_icons_flat_earthen_desc'] = '显示 {achievement:40606} 成就中的位置。'

L['tome_of_polymorph_mosswool'] = '进入隧道并继续前往 {location:燃火之厅}。\n\n接受来自 {npc:229128} 的 {quest:84438} 获得 {item:227710}。'

L['aradan_note_start'] = '{npc:213428} 可以在 {location:多恩岛} 的 {location:多恩诺嘉尔} 地下城 {location:驭雷栖巢} 中找到。\n\n{note:{npc:213428} 可以在追随者地下城模式下被驯服。}'
L['aradan_note_step_1'] = '1. 从 {location:多恩岛} 外的深水中收集 {item:220770}。'
L['aradan_note_step_2'] = '2.（{dot:Blue}）进入 {location:驭雷栖巢} 并击败 {npc:209230}。'
L['aradan_note_step_3'] = '3.（{dot:Red}）跳下竖井然后跑上 {npc:215967} 出现处的楼梯。'
L['aradan_note_step_4'] = '4.（{dot:Green}）跑到悬崖边并使用 {item:220770}，同时瞄准 {npc:213428}。'
L['aradan_note_step_5'] = '5. {npc:213428} 会认出锤子并飞下来，让你驯服它。'
L['aradan_note_end'] = '{note:{item:220770} 在使用时不会被消耗，因此可以驯服所有5种模型变体或帮助同伴猎人。}'

-------------------------------------------------------------------------------
-------------------------------- RINGING DEEPS --------------------------------
-------------------------------------------------------------------------------

L['forgotten_treasure_note'] = '打开附近 {object:埋藏的宝藏} 获得 {item:217960}。'
L['kaja_cola_machine_note'] = '按以下顺序购买饮品：{item:223741} > {item:223743} > {item:223744} > {item:223742}。'

L['options_icons_i_only_need_one_trip'] = '{achievement:40623}'
L['options_icons_i_only_need_one_trip_desc'] = '显示 {achievement:40623} 成就中的位置。'
L['i_only_need_one_trip_note'] = '在{wq:信使任务：矿石回收} 世界任务中一次性存放全部10个矿石。'

L['options_icons_not_so_quick_fix'] = '{achievement:40473}'
L['options_icons_not_so_quick_fix_desc'] = '显示 {achievement:40473} 成就中控制台位置。'

L['not_so_quick_fix_note'] = '修复坏掉的土灵控制台。'
L['water_console_location'] = '在楼梯旁边。'
L['abyssal_console_location'] = '在小屋里。'
L['taelloch_console_location'] = '在桥上的桶之间。'
L['lost_console_location'] = '在小屋里。'

L['options_icons_notable_machines'] = '{achievement:40628}'
L['options_icons_notable_machines_desc'] = '显示 {achievement:40628} 成就中记事的位置。'

L['notable_machines_note'] = '阅读记事。'
L['fragment_I_location'] = '在地面上。'
L['fragment_II_location'] = '在崖边上。'
L['fragment_III_location'] = '在建筑物顶上。'
L['fragment_IV_location'] = '在高高的木塔上（建议使用稳定飞行来获得）。'
L['fragment_V_location'] = '在楼梯顶端的拱门上。'
L['fragment_VI_location'] = '在地面上，路灯旁边。'

L['options_icons_rocked_to_sleep'] = '{achievement:40504}'
L['options_icons_rocked_to_sleep_desc'] = '显示 {achievement:40504} 成就中铭牌的位置。'

L['rocked_to_sleep_note'] = '阅读下列失能土灵的铭牌。'
L['attwogaz_location'] = '在崖边上。'
L['halthaz_location'] = '在柱子底部的崖边上。'
L['krattdaz_location'] = '在两座瀑布之间的崖边上。'
L['uisgaz_location'] = '在崖边上。'
L['venedaz_location'] = '在管道旁边的平台上。'
L['merunth_location'] = '在楼梯上方的管道上。'
L['varerko_location'] = '在崖边上。'
L['alfritha_location'] = '在悬崖边上。'
L['gundrig_location'] = '在崖边上。'
L['sathilga_location'] = '在土灵采矿机械建筑物附近的崖边上。'

L['trungal_note'] = '击杀在入口周围和洞穴下方出现的 {npc:220615} 后出现。'
L['disturbed_earthgorger_note'] = '使用额外动作法术 {spell:437003} 对地面使用3次后出现。'
L['deepflayer_broodmother_note'] = '在高空飞来飞去。'
L['lurker_note'] = '{note:需要5名玩家才能出现。}\n\n在10秒内激活5个 {dot:Red}{object:细小的控制杆} 即可出现。\n成功触发后，将看到区域范围的消息。'

L['gnawbles_ruby_vendor_note'] = [[从 {object:翻动过的土地} 收集 {item:212493} 并将其带给 {npc:225166}。

一旦完成了10次贡献或总共贡献了50次 {item:212493}，将收到 {item:224642}。

每件物品花费1个 {item:224642}。]]
L['options_icons_disturbed_earth'] = '翻动过的土地'
L['options_icons_disturbed_earth_desc'] = '显示 {object:翻动过的土地} 的位置。'

L['options_icons_gobblin_with_glublurp'] = '{achievement:40614}'
L['options_icons_gobblin_with_glublurp_desc'] = '显示 {achievement:40614} 成就中的位置。'
L['gobblin_with_glublurp_note'] = '点击一个 {dot:Red}{object:烁光水晶} 来获得 {spell:456739}。抓获一个飞在 ' .. '|cFFFF8C00橙圈|r' .. ' 的 {npc:227138} 并把它带回给 {npc:227132}。\n\n（建议使用稳定飞行来获得）。'

L['critter_love_note'] = '必须对小动物使用表情 {emote:/爱}、{emote:/love}，而不是战斗宠物。'
L['options_icons_critter_love'] = '{achievement:40475}'
L['options_icons_critter_love_desc'] = '显示 {achievement:40475} 成就中小动物的位置。'

L['for_the_collective_note'] = '需要 {wq:信使任务：矿石回收}\n\n捐赠总计20个 {npc:224281} 给每个 {npc:228056}。\n\n{note:捐赠进度服务器共享并2小时之后重置。}'
L['for_the_collective_suffix'] = '捐赠矿石'
L['for_the_collective_location'] = '在建筑物顶部。使用附近的 {object:木板} 造一个斜坡。'
L['options_icons_for_the_collective'] = '{achievement:40630}'
L['options_icons_for_the_collective_desc'] = '显示 {achievement:40630} 成就中 {npc:228056} 的位置。'

-------------------------------------------------------------------------------
--------------------------------- HALLOWFALL ----------------------------------
-------------------------------------------------------------------------------

L['arathi_loremaster_note'] = '与 {location:米雷达尔} 内的 {npc:221630} 交谈并正确回答几个问题即可获得 {item:225659}。\n\n可以在 {location:陨圣峪} 周围的书籍中找到答案。'
L['caesper_note'] = '从 {location:陨圣峪} {location:度耐尔之仁} 的（{dot:Blue}）{npc:217645} 购买 {item:225238}。\n\n将其喂给 {npc:225948} 并跟随他找到宝藏。'
L['dark_ritual_note'] = '与 {object:黑暗仪式} 互动并击败所有 {npc:226059}、{npc:226052} 和 {npc:226062} 以拾取 {object:缀影精华}。'
L['illuminated_footlocker_note'] = '从 {npc:220703} 处接住5个掉落的 {spell:442389} 以获得 {spell:442529} 并发现 {object:光耀提箱}。'
L['illusive_kobyss_lure_note'] = '组合全部4个物品制造 {item:225641}：'
L['sunless_lure_location'] = '由 {location:无晖之滨} 的 {npc:215653} 掉落。它们伪装起来并使用 {npc:215623} 作为诱饵。'
L['sky_captains_sunken_cache_note'] = [[
与四位不同的天空船长在他们的飞艇上交谈以揭示宝藏。

{npc:222333}（{dot:Green}）逆时针飞行。
{npc:222311}（{dot:Yellow}）逆时针飞行。
{npc:222323}（{dot:Red}）顺时针飞行。
{npc:222337}（{dot:Orange}）逆时针飞行。
]]
L['murkfin_lure_location'] = '由 {location:威尔汉之征} 的 {npc:213622} 掉落。它们伪装起来并使用 {npc:215623} 作为诱饵。'
L['hungering_shimmerfin_location'] = '由 {location:饥寒之池} 的 {npc:215243} 掉落。它们伪装起来并使用 {npc:219210} 作为诱饵。'
L['ragefin_necrostaff_location'] = '由 {location:崇圣之地} 的 {npc:213406} 掉落。'
L['jewel_of_the_cliffs_location'] = '在石墙上极高的地方。'
L['lost_necklace_note'] = '拾取神龛边缘的 {object:失落的纪念物}。'
L['priory_satchel_location'] = '拾取悬挂在 {location:圣焰隐修院} 教堂角落的 {object:啸风之袋}。'
L['smugglers_treasure_note'] = '从悬崖下方的（{dot:Blue}）{npc:226025} 拾取所需的 {item:225335}。'
L['smugglers_treasure_location'] = '在悬崖高处几块岩石之间。'
L['coral_fused_clam'] = '被珊瑚包裹的蛤蜊'
L['coral_fused_clam_note'] = '从 {object:捕蛤者的工具} 中拾取 {item:218354} 来打开蛤蜊。'

L['options_icons_biblo_archivist'] = '{achievement:40622}'
L['options_icons_biblo_archivist_desc'] = '显示 {achievement:40622} 成就中书籍的位置。'

L['biblo_book_01_location'] = '在建筑物内 {npc:222811} 后面的桌子上。'
L['biblo_book_02_location'] = '在建筑物内门边的桌子上。'
L['biblo_book_03_location'] = '在全是 {npc:217606} 的马厩里。'
L['biblo_book_04_location'] = '在桥的中央。'
L['biblo_book_05_location'] = '在飞艇下面的海滩上。'
L['biblo_book_06_location'] = '在建筑物内后墙的书架上。'
L['biblo_book_07_location'] = '在建筑物内 {npc:206096} 后面的桌子上。'
L['biblo_book_08_location'] = '在废墟内。'
L['biblo_book_09_location'] = '在大帐篷内桌子上。'
L['biblo_book_10_location'] = '在 {location:破晨号} 上的船长舱内。'
L['biblo_book_11_location'] = '在建筑物内的桌子上。'

L['options_icons_lost_and_found'] = '{achievement:40618}'
L['options_icons_lost_and_found_desc'] = '显示 {achievement:40618} 成就中纪念物的位置。'

L['lost_and_found_note'] = '从（{dot:Red}）{npc:220718} 的任务 {quest:80673} 开始推进苍穹之忆故事线。{note:任务每周解锁}。\n\n每周可以完成3个纪念物，直到完成任务 {quest:82813}。'
L['broken_bracelet_location'] = '将物品 {item:219810} 交给 {npc:215527}。'
L['stuffed_lynx_toy_location'] = '将物品 {item:219809} 交给 {npc:218486}。'
L['tarnished_compass_location'] = '将物品 {item:219524} 交给 {object:墓祭地点}。'
L['sturdy_locket_location'] = '将物品 {item:224274} 交给 {npc:220859}。'
L['wooden_figure_location'] = '将物品 {item:224273} 交给 {npc:217609}。'
L['calcified_journal_location'] = '将物品 {item:224272} 交给 {npc:222813}。'
L['ivory_tinderbox_location'] = '将物品 {item:224266} 交给 {npc:226051}。'
L['dented_spear_location'] = '将物品 {item:224267} 交给 {npc:213145}。'
L['filigreed_cleric_location'] = '将物品 {item:224268} 交给 {npc:217813}。'

L['options_icons_missing_lynx'] = '{achievement:40625}'
L['options_icons_missing_lynx_desc'] = '显示 {achievement:40625} 成就中山猫的位置。'

L['missing_lynx_note'] = '抚摸凶猛的作战大猫。'
L['magpie_location'] = '在牌子旁边的地面上。'
L['nightclaw_location'] = '点亮附近的 {object:小型钥焰}。'
L['purrlock_location'] = '点亮附近的 {object:圣光之荣钥焰}。'
L['shadowpouncer_location'] = '点亮附近的 {object:圣光之荣钥焰}。'
L['miral_murder_mittens_location'] = '在外面。'
L['fuzzy_location'] = '在 {object:小型钥焰} 附近的地面上。'
L['furball_location'] = '在废墟建筑内。'
L['dander_location'] = '在外面。'
L['gobbo_location'] = '在建筑内的床上。'

L['beledars_spawn_note'] = '此稀有会以固定的时间间隔在多个位置之一出现。\n\n下次出现：\n{note:%s（%s）}'
L['croakit_note'] = '从附近的 {object:影盲石斑鱼群} 钓起10个 {item:211474}（或者从拍卖行购买）然后把它们扔给它，使稀有可被攻击。'
L['deathtide_note'] = '收集一个 {item:220122} {dot:Red} 和一个 {item:220124} {dot:Green}。将它们组合成 {item:220123}，在 {object:不祥祭坛} 召唤稀有。'
L['murkshade_note'] = '与 {npc:218455} 互动。'
L['spreading_the_light_rares_note'] = '当前位置点燃的 {object:钥焰} 熄灭后稀有出现。'

L['options_icons_mereldar_menace'] = '{achievement:40151}'
L['options_icons_mereldar_menace_desc'] = '显示 {achievement:40151} 成就中的目标位置。'

L['mereldar_menace_note'] = '与 {object:飞掷之石} 互动并将其扔向目标。'
L['light_and_flame_location'] = '{object:飞掷之石} 瞄准东边的 {npc:218472}。'
L['lamplighter_doorway_location'] = '瞄准东边建筑物的门口。'
L['barracks_doorway_location'] = '瞄准西边红色和金色帐篷的门口。'

L['options_icons_beacon_of_hope'] = '{achievement:40308}'
L['options_icons_beacon_of_hope_desc'] = '显示 {achievement:40308} 成就中小型钥焰的位置。'

L['beacon_of_hope_note'] = '捐献 {item:206350} 来点亮小型钥焰并完成接下来的任务。'

L['parasidious_note'] = '从 {npc:206533} 购买 {item:206670}（激活 {object:小型钥焰} 使其出现），然后前往 {location:暮升辽原} 并拉动 {npc:206870}。当拉动它们时，一根藤蔓会从身上射出并到达 {npc:206978}，它会生长/变化，直到稀有最终出现。'

L['options_icons_flamegards_hope'] = '{achievement:20594}'
L['options_icons_flamegards_hope_desc'] = '显示 {achievement:20594} 成就中的位置。'
L['flamegards_hope_note'] = '帮助 {npc:213319} 治疗 {npc:220225} 20天。\n\n如果当前职业无法治疗，可以使用 {spell:372009} 或 {item:211878}。'

L['hallowfall_sparkfly_label'] = '陨圣峪火萤'
L['hallowfall_sparkfly_note'] = '在 {location:静石之池} 的 {object:小型钥焰} 使用3个 {item:206350} 召唤 {npc:215956}。\n\n以2个 {item:206350} 购买 {item:218107} 并使用它来揭示附近的 {npc:222308} 直到出现 {object:陨圣峪火萤}。'

L['nightfarm_growthling_note'] = '在 {location:旋辉田野} 的 {object:小型钥焰} 使用3个 {item:206350} 召唤 {npc:208186}。\n\n以2个 {item:206350} 购买 {item:219148} 并使用它来揭示 {item:221546}。'

L['thunder_lynx_note'] = '1. 在 {location:炬光矿脉} 的 {object:小型钥焰} 使用3个 {item:206350} 召唤 {npc:212419}。\n\n2. 与 {npc:212419} 交谈并按照所有额外的对话框提示找到 {quest:82007}。\n\n3. 找到每只小山猫：{npc:222373}（{dot:Blue}）、{npc:222372}（{dot:Green}）、{npc:222375}（{dot:Orange}）和 {npc:222374}（{dot:Red}）。\n\n{note:请确保同时开始 {quest:76169} 以接收 {item:219198} 或使用类似物品，例如 {item:219148}。需要一盏灯来照亮 {location:霜影洞穴} 内的 {npc:222373}。}\n\n4. 拯救每一只山猫幼崽并返回 {npc:212419}。'

-------------------------------------------------------------------------------
---------------------------------- AZJ-KAHET ----------------------------------
-------------------------------------------------------------------------------

L['options_icons_itsy_bitsy_spider'] = '{achievement:40624}'
L['options_icons_itsy_bitsy_spider_desc'] = '显示 {achievement:40624} 成就中纺崽的位置。'

L['itsy_bitsy_spider_note'] = '向 {npc:纺崽} 招手（{emote:/招手}、{emote:/wave}）。'

L['options_icons_bookworm'] = '{achievement:40629}'
L['options_icons_bookworm_desc'] = '显示 {achievement:40629} 成就中书籍的位置。'

L['nerubian_potion_note'] = '以33个 {currency:3056} 从 {npc:218192} 购买 {item:225784}。'
L['bookworm_note'] = '{note:还可以使用 {item:225784} 完成 {achievement:40542} 成就。}'
L['bookworm_1_location'] = '在小洞窟入口处。'

L['options_icons_smelling_history'] = '{achievement:40542}'
L['options_icons_smelling_history_desc'] = '显示 {achievement:40542} 成就中书籍的位置。'

L['smelling_history_note'] = '{note:还可以使用 {item:225784} 完成 {achievement:40629} 成就。}'
L['smelling_history_1_location'] = '在建筑物内的柜台上。'
L['smelling_history_2_location'] = '卷轴在一个箱子上。'
L['smelling_history_3_location'] = '卷轴在桌子上。'
L['smelling_history_4_location'] = '在建筑物内的桌子上。'
L['smelling_history_5_location'] = '在建筑物内的桌子上。'
L['smelling_history_6_location'] = '在房间南侧的床上。'
L['smelling_history_7_location'] = '在一堆书的上面。'
L['smelling_history_8_location'] = '在房间北边床边的桌子上。'
L['smelling_history_9_location'] = '在桌子后面，在 {npc:226024} 旁边。'
L['smelling_history_10_location'] = '在长凳上。'
L['smelling_history_11_location'] = '书在床边的桌子上。入口在喷泉上方。'
L['smelling_history_12_location'] = '在建筑物内的桌子上。'

L['options_icons_skittershaw_spin'] = '{achievement:40727}'
L['options_icons_skittershaw_spin_desc'] = '显示 {achievement:40727} 成就中虫车路线位置。'
L['skittershaw_spin_note'] = '骑乘 {npc:224973} 绕区域一圈。\n\n{npc:224973} 将在路线上的 {dot:Red} 点处停止。'

L['options_icons_no_harm_from_reading'] = '{achievement:40632}'
L['options_icons_no_harm_from_reading_desc'] = '显示 {achievement:40632} 成就中 NPC {npc:227421} 的位置。'
L['no_harm_from_reading_note'] = [[
进入（{dot:Yellow}）洞穴，前往（{dot:Red}），爬上3只蜘蛛所在的墙壁，然后进入顶部蜘蛛后面的洞。

掉下去后，与附近的 {object:血肉魔典} 互动，出现4个 {npc:227421}。

{npc:227421} 随后会消失，然后重新出现在地图周围。

追踪每个 {npc:227421} 并与他们互动，将他们送回 {object:血肉魔典}。

找到所有4个 {npc:227421} 后，返回 {object:血肉魔典} 并与 {npc:227421} 交谈。
]]
L['another_you_4_note'] = '沿着标记的路径巡逻。'

L['concealed_contraband_note'] = '移除 {object:网茧} 后揭示宝藏。'
L['memory_cache_note'] = '从附近的（{dot:Red}）{object:提取器存储} 获取 {spell:420847}。击杀 {npc:223908} 后获取 {item:223870} 以打开 {object:记忆箱子}。'
L['niffen_stash_note'] = '在桥下。'
L['trapped_trove_note'] = '在从天花板垂下的建筑物中。避开地板上的蜘蛛网。'
L['weaving_supplies_note'] = '从附近的平台收集丝绸碎片来打开宝藏。\n\n{item:223901}（{dot:Purple}）\n{item:223903}（{dot:Yellow}）\n{item:223902}（{dot:Red}）'

L['tkaktath_note'] = '开始任务链以获取 {item:224150} 坐骑。'

L['options_icons_the_unseeming'] = '{achievement:40633}'
L['options_icons_the_unseeming_desc'] = '显示 {achievement:40633} 成就中的位置。'
L['the_unseeming_note'] = '站在池子里直到有100层堆叠 {spell:420847}。'

L['options_icons_you_cant_hang_with_us'] = '{achievement:40634}'
L['options_icons_you_cant_hang_with_us_desc'] = '显示 {achievement:40634} 成就中的位置。'
L['you_cant_hang_with_us_note'] = '找到一个带有 {spell:434734} 增益效果的 {npc:211816} 并攻击他，会给你 {spell:443190} 负面效果（1分钟）。（{note:不要击杀他！}）会干扰并叠加 {spell:454666} 负面效果在身上。叠加至10层时，将被强制驱逐出城。'

L['kej_pet_vendor_note'] = '每只宠物的库存有限，价格为2,250个 {currency:3056}。\n\n{note:任意商人的每个宠物物品的预计刷新时间为3-4小时。}'

L['options_icons_back_to_the_wall'] = '{achievement:40620}'
L['options_icons_back_to_the_wall_desc'] = '显示 {achievement:40620} 成就中 {npc:222119} 的位置。'
L['arathi_prisoner_suffix'] = '已营救阿拉希囚犯'
L['arathi_prisoner_note'] = '在 {wq:特别任务：些许治愈} 期间释放被蛛网包裹的 {npc:222119}。'

-------------------------------------------------------------------------------
----------------------------------- DELVES ------------------------------------
-------------------------------------------------------------------------------

L['sturdy_chest'] = '坚固宝箱'
L['sturdy_chest_suffix'] = '已找到坚固宝箱'

L['ecm_chest_3_location'] = '在起重机上。从上层跳下。'
L['fol_chest_1_location'] = '在灌木丛中蘑菇下的岩石上。'
L['fol_chest_3_location'] = '在瀑布底部。'
L['fol_use_mushrooms'] = '跳上小路旁的蘑菇。'
L['kvr_chest_2_location'] = '在木制脚手架顶部。'
L['nfs_chest_2_location'] = '在植物上。'
L['nfs_chest_3_location'] = '在建筑物内。'
L['nfs_chest_4_location'] = '从飞船上跳下。'
L['ski_chest_3_location'] = '在崖边上。'
L['tra_chest_2_location'] = '在珊瑚的顶部。'
L['tsw_chest_2_location'] = '在横梁上。'
L['tsw_chest_2_note'] = '{note:仅在“纺丝者爱的问候”故事变种。}'
L['tsw_chest_3_location'] = '在通往宝藏室的下拉栏附近的柱子上。'
L['tsw_chest_4_location'] = '在横梁上。从另一个宝箱附近的柱子上掉下来。'
L['tuk_chest_1_note'] = '雕像后面。'
L['tuk_chest_2_note'] = '{note:仅在“逃亡的进化体”和“煎熬受害者”故事变种。}'
L['tuk_chest_3_note'] = '{note:仅在“逃亡的进化体”和“纺丝者救援”故事变种。}'
L['sss_chest_2_location'] = '穿过金属梁。'

-------------------------------------------------------------------------------
--------------------------------- SIREN ISLE ----------------------------------
-------------------------------------------------------------------------------

L['the_drowned_lair_note'] = '向 {object:海妖岛指挥图} 上的 {location:沉沦之巢} 捐献 {currency:3090} 来打开这个洞穴并将出现稀有物品。'
L['the_drain_note'] = '向 {object:海妖岛指挥图} 上的 {location:排水道} 捐献 {currency:3090} 来打开这个洞穴并将出现稀有物品。'
L['shuddering_hollow_note'] = '向 {object:海妖岛指挥图} 上的 {location:战栗窟} 捐献 {currency:3090} 来打开这个洞穴并将出现稀有物品。'

L['vrykul_sublabel'] = '{note:仅在岛上有 {npc:赤潮维库人} 时可用。}'
L['naga_sublabel'] = '{note:仅在岛上有 {npc:娜迦} 时可用。}'
L['pirate_sublabel'] = '{note:仅在岛上有 {npc:海盗} 时可用。}'

L['storm_required'] = '需要在 {location:海妖岛} 上激活 %s 风暴。' -- %s becomes "(icon) [Seafury Tempest]"
L['slaughtershell_location'] = '在整个 {location:海妖岛} 游荡。'

L['within_the_forgotten_vault'] = '使用 {location:圣礼窟} 内的 {object:歌唱石板} 进入宝库。\n\n宝库包含宝藏、玩具、坐骑以及 {npc:231368}。'

L['options_icons_runed_storm_chest'] = '{achievement:41131}'
L['options_icons_runed_storm_chest_desc'] = '显示 {achievement:41131} 成就中 {object:符文风暴宝箱} 的位置。'

L['runed_storm_chest_label'] = '符文风暴宝箱'
L['runed_storm_chest_suffix'] = '宝箱已打开'
L['runed_storm_chest_note'] = '跟随风找到一个隐藏的 {object:符文风暴宝箱}，并用 {spell:472051} 揭示它。'

L['flame_blessed_iron_item'] = '带回此商品可获得奖励 {currency:3090}。'

L['barnacle_encrusted_chest'] = '长满藤壶的宝箱'
L['pilfered_earthen_chest'] = '掠夺的土灵宝箱'

L['soweezi_note'] = '用 {currency:3090} 换取坐骑、玩具、宠物和幻化。'

L['thrayir_note_start'] = '从 {location:海妖岛} 周围收集5个符石钥匙，并完成 {location:被遗忘的宝库} 内的仪式以获得 {item:232639}：'

L['whirling_runekey_note'] = '风暴期间 {location:被遗忘的宝库} 的 {npc:231368} 掉落。'
L['torrential_runekey_note'] = '需要7个 {item:234328}，在 {spell:458069} 期间从 {location:海妖岛} 上的 {note:任意} 怪物（普通、精英、或稀有）掉落。'
L['thunderous_runekey_note'] = '需要5个 {item:232605}，在 {location:海妖岛} 上的 {note:任意} 箱子中找到。{note:不需要 {spell:458069}}。'
L['cyclonic_runekey_note'] = '风暴期间 {location:海妖岛} 的 {location:亡鳍沼地} 中的 {npc:231357} 掉落。或者从周围钓鱼获得。'
L['turbulent_runekey_note'] = '需要在风暴期间 {location:海妖岛} 周围发现3个 {item:234327}。'

L['turbulent_fragment_a'] = '隐藏在 {location:海歌船屋} 旅馆后面 {npc:库尔提拉斯人} 幽灵挖掘 {object:泥土堆} 附近。'
L['turbulent_fragment_b'] = '在 {location:腐烂坑洞} 的洞穴中，拾取畏缩的 {npc:库尔提拉斯人} 幽灵前的 {npc:234934}。'
L['turbulent_fragment_c'] = '拾取 {location:魂裂洞穴} 内的 {npc:库尔提拉斯人} 幽灵所持有的 {npc:234934}。'

L['prismatic_snapdragon_note_start'] = '在10天的时间里，帮助拯救 {location:漂流浅滩} 中的 {npc:235216} 以获得 {item:233489}。\n\n{note:可以错过，但没有追赶机制}。'
L['prismatic_day'] = '第%d天' -- "Day 1" or "Day 4" or "Day 7"

L['pris_quest_1'] = '生命线' -- 86482
L['pris_quest_2'] = '速战速决' -- 86483
L['pris_quest_3'] = '风卷残云' -- 86484
L['pris_quest_4'] = '忠诚伙伴' -- 86485

L['unsolved_amethyst_runelock'] = '未破解的紫晶符文锁'
L['bilge_rat_supply_chest'] = '水鼠帮补给箱'
L['bilge_rat_supply_chest_note'] = '从附近的 {npc:228582} 收集 {item:228621} 来打开宝箱。'

L['stone_carvers_scamseax_note'] = '收集 {object:光耀黄水晶}（{dot:Yellow}）以获得 {spell:1216785} 增益，持续2分钟，可以拾取 {item:233834}。'

L['marmaduke_note'] = '1. 从 {location:海歌船屋} 旅馆顶层收集 {item:233027} 并将其带给 {npc:234365}。\n\n{note:{npc:234365} 在悬崖和 {location:漂流浅滩} 之间巡逻。}\n\n2. 将玩具交给它后，返回 {location:漂流浅滩} 并完成 {quest:86261} 得到 {item:233056}。'

-------------------------------------------------------------------------------
----------------------------- SECRETS OF AZEROTH ------------------------------
-------------------------------------------------------------------------------

L['options_icons_secrets_of_azeroth'] = '艾泽拉斯之秘'
L['options_icons_secrets_of_azeroth_desc'] = '显示 {location:艾泽拉斯之秘} 线索的位置。'

L['alyx_kickoff_note'] = '与 {npc:226683} 交谈以启用新的艾泽拉斯之秘谜题。'

-- L['celebration_crates_label'] = '庆典箱子'
L['celebration_crates_note'] = '找到并交还隐藏在 {location:艾泽拉斯} 中的所有 {object:庆典箱子}。'

L['1_soggy_celebration_crate_note'] = '从 {location:深潜酒吧} 的 {npc:143029}（{dot:Blue}）购买 {item:225996} 并将其交给 {npc:189119} 以揭示 {item:226200}。'
L['2_hazy_celebration_crate_note'] = '活着的时候，寻找发出绿光的区域。{note:但是，必须死了才能揭示 {item:232263}。}'
L['3_dirt_caked_celebration_crate_note'] = '{note:无需从 {npc:226683} 附近的公告板上收集此箱子的 {item:228321}。}\n\n1. 进入 {location:卡拉赞} 后面的 {location:被遗忘的墓穴}。\n\n2. 走下楼梯，穿过 {location:遗忘之井}，走下 {location:乞丐行道} 的斜坡，进入 {location:被遗忘的墓穴} 的下一层。\n\n3. 右转并沿着隧道穿过 {location:乞丐行道}。\n\n4. 穿过大房间，朝着 {location:倒吊深渊} 走去。\n\n5. 径直穿过水面，进入 {location:绝望泥沼} 拿取 {item:228322}。'
L['4_sandy_celebration_crate'] = '1. 从 {location:卡利姆多} 的 {location:千针石林} {location:沉没的挖掘场} 收集 {item:228768}。\n\n2. 在 {location:阿苏纳} 的东边道路上找到游荡的 {npc:91079}。\n\n3. 花费 %s 购买 {item:228767}。'
L['5_battered_celebration_crate'] = '靠在 {npc:24026} 附近洞穴的岩石上。'
L['6_waterlogged_celebration_crate'] = '位于侏儒建筑二楼的水下。\n\n{note:不要触碰电梯。当前它会导致游戏崩溃。}'
L['7_charred_celebration_crate'] = '藏在 {location:呼啸林地} 的蹦床底部。'
L['8_mildewed_celebration_crate'] = '1. 在 {location:灰谷} 的 {location:雷鸣峰} 顶部的 {npc:34295} 后面找到并喝下 {object:真相药水}。\n\n2. 在 {location:菲拉斯} 的 {location:厄运之槌} 中拾取 {object:发霉的庆典箱子}。\n\n{note:{spell:463368} 仅持续30分钟。必须手动飞往 {location:菲拉斯}。更改大陆、使用传送门或使用 {item:6948} 将移除该增益效果。}'
L['9_crystalized_celebration_crate'] = '在 {location:纳格兰} 的 {location:沃舒古} 内。'
L['10_surprisingly_pristine_celebration_crate'] = '1. 从 {location:卡利姆多} 的 {location:安其拉} 洞穴中收集 {item:228772}。\n\n2. 将 {item:228772} 放置在 {location:破碎群岛} 的 {location:风暴峡湾} 的 {object:无标记的坟墓} 处。'
L['11_ghostly_celebration_crate'] = '位于 {location:兵主之座} 顶部传送门右侧。'

L['water_resistant_receipt_note'] = '1. 进入充满 {npc:47390} 的隧道，右转从管道后面的 {object:防水的销售收据} 中收集 {item:228768}。\n\n2. 在 {location:破碎群岛} 的 {location:阿苏纳} 找到 {npc:91079}。'
L['mysterious_bones_note'] = '收集洞穴中隐藏在 {npc:71533} 后面的 {item:228772}。\n\n使用狗类战斗宠物（例如 {item:136925} 或 {item:49912}）挖出骨头。'

L['crates_found'] = '已找到箱子'

-------------------------------------------------------------------------------
------------------------------- RATT'S REVENGE --------------------------------
-------------------------------------------------------------------------------

L['options_icons_ratts_revenge'] = '{achievement:40967}'
L['options_icons_ratts_revenge_desc'] = '显示 {achievement:40967} 成就中秘密的位置。'

-- INERT PECULIAR KEY
L['inert_peculiar_key_note'] = '藏在巨大的中空树干里板条箱后面。\n\n{note:下一个位置：}\n如果 {bug:*没有*} {item:228938}，请前往 {location:卡兹阿加} 的 {location:多恩诺加尔}。\n\n如果 |cFF00FF00*有*|r {item:228938}，请前往 {location:东部王国} 的 {location:逆风小径}。'

-- PECULIAR GEM
L['carefully_penned_note'] = '佩戴 {title:侦探} 头衔与 {npc:230042} 交谈以接受 {quest:84684}。\n\n{note:下一个位置：}{location:艾基-卡赫特}'
L['unfinished_note'] = '在 {location:渊行者小径} 的一个小洞穴中，周围是一圈 {npc:229596}。\n\n{note:下一个位置：}{location:千丝之城}'
L['hastily_scrawled_note'] = '在能高高俯瞰 {location:千丝之城} 的岩壁上。\n\n{note:下一个位置：}{location:陨圣峪}'
L['water_resistant_note'] = '在 {location:艾基-卡赫特} 和 {location:陨圣峪} 之间悬崖高处的隐秘湖泊中心。\n\n{note:下一个位置：}{location:艾基-卡赫特} 的 {location:菲琳之迈}'
L['peculiar_gem_note'] = '到达 {location:沃什柱巢}，穿过山洞内隐藏的洞口。\n\n{note:洞口隐藏在墙壁上，需要巧妙跳跃。}\n\n接近 {npc:233550}，她会逃跑并丢下 {item:228938}。\n\n{note:下一个位置：}\n如果 {bug:*没有*} {item:228941}，请前往 {location:卡利姆多} 的 {location:安戈洛环形山}。\n\n如果 |cFF00FF00有|r {item:228941}，请前往 {location:东部王国} 的 {location:逆风小径}。'

-- KARAZHAN CATACOMBS
L['karazhan_catacombs_label'] = '卡拉赞墓穴'
L['karazhan_catacombs_entrance_note'] = '从 {location:卡利姆多} 的 {location:安格洛环形山} 开始收集 {item:44124}\n\n从 {location:卡兹阿加} 的 {location:多恩诺加尔} 开始收集 {item:228938}\n\n将宝石和钥匙组合成 {item:44124}。\n\n将 {item:44124} 放入包中并激活 {item:208092}，接近大门即可看到一个红色的副本入口。'

-- ORB 1
L['orb_1_label'] = '1号球'
L['orb_1_note'] = '在每个涉及 {npc:228249} 的位置使用 {item:208092}，获得3层 {spell:153715} 中的1层。'
L['orb_1_locations'] = '1. {location:卡利姆多} 的 {location:北贫瘠之地}\n2. {location:德拉诺} 的 {location:纳格兰}\n3. {location:暗影界} 的 {location:玛卓克萨斯}'
L['humble_monument'] = '不起眼的纪念碑'
L['olgra_location'] = '{note:位置根据 {quest:35170} 的完成情况而改变。}'

-- ORB 2
L['orb_2_label'] = '2号球'
L['orb_2_note'] = '站在 {npc:153297} 旁边，使用 {npc:147393} 的以下礼物任意一个：\n\n{item:168123}\n{item:175140}\n{item:168004}\n\n召唤 {item:49912} 并使用以下服装任意一个：\n\n{item:229413}\n{item:116812}\n\n输入 {emote:/祈祷}、{emote:/pray} 表情并等待得到 {item:53156}。\n\n{note:周围的其他玩家完成以上步骤也可获得 {item:53156}。}\n\n返回 {location:卡拉赞墓穴} 并使用钥匙打开带有喷泉的房间的两扇门。'

-- ORB 3
L['orb_3_label'] = '3号球'

L['astral_soup_label'] = '星界暖汤'
L['astral_chest_label'] = '星界宝箱'
L['astral_rewards_note'] = '在 {object:星界暖汤} 钓鱼获得 {item:228965}。\n\n使用 {item:228965} 打开 {object:星界宝箱} 并获得 {item:228966}。\n\n现在可以从 {location:卡拉赞墓穴} 周围的机器收集 {item:228967}。'

L['decryption_machine_label'] = '解码机器'
L['decryption_console_label'] = '解码控制台'
L['rubensteins_console'] = '鲁布斯坦的控制台'

L['code_machine_note_1'] = '输入代码并打开 {object:“长者库纳尼的财物”} 得到 {item:228967}。\n\n{object:代码}：88224646'
L['code_machine_note_2'] = '输入代码并打开 {object:加密的宝箱} 获得 {item:228967}。\n\n{object:代码}：10638'
L['code_machine_note_3'] = '输入代码并打开 {object:加密的宝箱} 获得 {item:228967}。\n\n{object:代码}：5661'
L['code_machine_note_4'] = '输入代码并打开 {object:鲁布斯坦的保险箱} 获得 {item:228967}。\n\n{object:代码}：52233'
L['code_machine_note_5'] = '输入代码并打开 {object:加密的宝箱} 获得 {item:228967}。\n\n{object:代码}：51567'
L['code_machine_note_6'] = '输入代码并打开 {object:加密的宝箱} 获得 {item:228967}。\n\n{object:代码}：115'
L['code_machine_note_7'] = '输入代码并打开 {object:加密机关盒} 获得 {item:228967}。\n\n{object:代码}：17112317'
L['code_machine_note_8'] = '输入代码并打开 {object:加密的宝箱} 获得 {item:228967}。\n\n{object:代码}：19019'

L['slot_machine_label'] = '“试试手气！”游戏机'
L['slot_machine_note_a'] = '收集五个幸运物品然后输入代码：\n\n'
L['slot_machine_note_b'] = '{location:暴风城} 的 {npc:2795}：\n'
L['slot_machine_note_c'] = '{location:多恩诺加尔} 的 {npc:219197}：\n'
L['slot_machine_note_d'] = '{location:欧恩哈拉平原} 的 {npc:186650}\n'
L['slot_machine_note_e'] = '{object:代码}：777、77777 或 7777777'
L['slot_machine_vendor_note'] = '为 {object:“试试手气！”游戏机} 购买这些物品。'

-- ORB 4
L['orb_4_label'] = '4号球'
L['vashti_note'] = '从 {npc:91079} 购买 {item:228987}，花费 %s。'
L['uthers_tomb_label'] = '乌瑟尔之墓'
L['uthers_tomb_note'] = '在 {location:西瘟疫之地} 的 {location:乌瑟尔之墓} 召唤一个 {npc:11859}。\n\n使用 {location:阿苏纳} 的 {npc:91079} 出售的 {item:228987} 或让术士使用 {spell:342601}。\n\n一旦你死亡并复活，请阅读隐藏的涂鸦。\n\n{note:只要 {npc:11859} 活着，涂鸦就会一直存在，所以不要杀死它！}'

-- ORB 5
L['orb_5_label'] = '5号球'
L['jeremy_feasel_note'] = '{npc:232048} 隐藏在 {location:永恒岛} 的 {location:孤魂岩洞} 中。\n\n仅使用来自过去解密的战斗宠物在宠物战斗中击败 {npc:232048}。%s\n\n获胜后，完成 {quest:84781} 以获得 {item:228995}。\n\n现在可以去找 {location:藏宝海湾} 的 {npc:230310}。'
L['zarhym_note'] = '与洞穴内的 {npc:71876} 交谈，进入灵魂位面。'
L['pointless_treasure_salesman_location'] = '隐藏于 {location:加尼罗哨站} 的地精雕像内。'
L['pointless_treasure_salesman_note'] = '购买 {item:228996}：'

-- ORB 6
L['orb_6_label'] = '6号球'
L['blood_altar_label'] = '鲜血祭坛'
L['corrupt_altar_label'] = '腐蚀祭坛'
L['lust_altar_label'] = '欲望祭坛'
L['sin_altar_label'] = '原罪祭坛'
L['void_altar_label'] = '虚空祭坛'

L['altar_note'] = '使用 {item:208092} 召唤灵魂。装备某些坐骑、宠物、玩具或幻化来安抚它：'
L['blood_altar_note'] = '{object:%s}：名称中带有“血”的任何坐骑。\n\n{object:%s}：名称中带有“血”的任何宠物。\n\n{object:%s}：{item:127709}'
L['corrupt_altar_note'] = '{object:%s}：任何名称中带有“堕落或腐化”的坐骑。\n\n{object:%s}：任何名称中带有“堕落或腐化”的宠物。\n\n{object:%s}：{item:116067}\n\n{object:%s}：任何与 {item:86316} 外观相同的披风。'
L['lust_altar_note'] = '{object:%s}：{pet:1628}\n\n{object:%s}：{item:129211}\n\n{object:%s}：完全赤裸或受到 {item:119092} 的影响'
L['sin_altar_note'] = '{object:%s}：{pet:2966}\n\n{object:%s}：{item:183986}\n\n{object:%s}：任意温西尔罪碑披风幻化'
L['void_altar_note'] = '{object:%s}：{pet:1234}，{pet:2434}，或 {pet:4543}\n\n{object:%s}：{item:119003} 和 {item:174830}\n\n{object:%s}：任何与 {item:24252} 外观相同的披风'

L['chest_of_acquisitions_label'] = '收获宝箱'
L['chest_of_acquisitions_note'] = '1. 安抚 {location:北荆棘谷} 的 {location:祖尔格拉布} 祭坛上的所有灵魂。\n\n2. 装备 {item:228966} 并拾取 {object:收藏品宝箱} 以获得 {item:229007}。'

-- Orb 7
L['orb_7_label'] = '7号球'
L['orb_7_summary'] = '1. 从 {location:阿苏纳} 的 {location:守望岛} 开始。\n\n2. 使用岛上各式各样的 {object:看守者猫头鹰} 雕像增强您的 {pet:1716} 的能力。\n\n3. 进入 {location:守望者地窟} 并击败首领以揭开秘密 {item:229046}。\n\n4. 使用 {item:229046} 开始具有挑战性的逻辑谜题并最终揭开一个装有 {item:229054} 的宝箱。'

L['marin_bladewing_note'] = '与 {faction:1894} 到达 %2$s 后，从 {npc:107379} 处以 %1$s 购买 {pet:1716}，或者从 {location:拍卖行} 购买。'
L['owl_of_the_watchers_label'] = '看守者猫头鹰'
L['owl_of_the_watchers_note'] = '{note:每次只能激活3个雕像。}\n\n站在激活的雕像附近，召唤出 {pet:1716} 来收集全部4个增益：\n\n{spell:225049}\n{spell:225038}\n{spell:223160}\n{spell:225059}。\n\n一旦 {pet:1716} 获得强化，\n\n{note:{pet:1716} 被白色烟雾跟随}\n\n即可进入 {location:守望者地窟} 地下城。'

L['sentry_statue_note'] = '1. 击败 {npc:95885} 以打开 {location:暗夜大厅} 内的秘密房间。\n\n2. 击败其余首领，包括 {npc:95888}。\n\n3. 将 {spell:204481} 和 {pet:1716} 带回秘密房间将出现 {item:229046}。\n\n4. 将 {item:229046} 带到 {npc:95887} 房间。'
L['sentry_note'] = '1. 将 {item:229046} 放在入口处将出现 {npc:109300}。\n\n2. 与 {npc:109300} 互动以开始解谜。目标是将所有 {npc:98082} 放入地板。\n\n3. 完成后，拾取 {object:守望者的珍宝} 获得 {item:229054}。'

-- Orb 8
L['orb_8_label'] = '8号球'

L['enigma_machine_label'] = '谜之机械'
L['enigma_machine_note'] = '1. 将 {item:229007} 和 {item:229054} 插入 {object:谜之机械}。\n\n2. 单击“开始”，然后单击“提交”。现在必须解锁3个隐藏的锁。\n\n3. 通过计算副本中的每个 {npc:230596}、将正确数量的雕像拖到正确的平台上并再次单击“提交”来解锁。\n\n{note:建议杀死每个 {npc:230599}，但不计算，以防止它们站在平台上。}'

L['lock_statue_note'] = '拖拽此雕像到一个平台。'
L['lock_platform_note'] = '拖拽雕像到此平台。'

L['platform_1_label'] = '平台1'
L['platform_2_label'] = '平台2'
L['platform_3_label'] = '平台3'
L['platform_4_label'] = '平台4'
L['platform_5_label'] = '平台5'
L['platform_6_label'] = '平台6'
L['platform_7_label'] = '平台7'

L['rats_label'] = '老鼠'
L['lock_label'] = '锁定 %d'
L['code_label'] = '将 %d 个雕像置于 %s'

-- Orb 9
L['orb_9_label'] = '9号球'

L['ak_decryption_console_note'] = '回到隐藏的洞穴，入口位于 {location:艾基-卡赫特} 的 {location:沃什柱巢} 洞穴内。\n\n装备 {item:228966} 将揭示一个隐藏的平台。\n\n目标为 {npc:230383} 并使用 {item:228996} 到达那里。输入密码解锁并打开 {object:加密的宝箱} 从中获得 {item:229348}。\n\n{object:密码}：84847078'
L['orb_10_label'] = '10号球'

-- Orb 11
L['orb_11_label'] = '11号球'

-- Orb 12
L['orb_12_label'] = '12号球'
-------------------------------------------------------------------------------
---------------------------------- UNDERMINE ----------------------------------
-------------------------------------------------------------------------------

L['requires_ally'] = nil
L['complete_event'] = nil
L['in_sewer'] = '在下水道内。使用附近的 {object:下水道栅栏} 进入。'
L['and_slimesby'] = '和 {npc:230947}'

L['inert_plunger_label'] = '无力的马桶搋子？'
L['exploded_plunger_label'] = '爆炸的马桶搋子'

L['unexploded_fireworks_location'] = '在 {location:尾门公园} 的屋顶上。'
L['suspicious_book_note'] = '1. {dot:Red} 隐藏在一楼的书架上。尝试收集它，它会飞到楼上的新书架上。\n\n2. {dot:Green} 隐藏在二楼的书架后面。尝试收集它，它会飞到楼上的桌子上。\n\n3. 在三楼的桌子上。最后，收集这本书！'
L['fireworks_hat_note'] = '尝试抓住帽子，导致它从屋顶飞到这里。'
L['blackened_dice_note'] = '转动附近的 {object:管道阀门} 以释放骰子。'
L['lonely_tub_note'] = '拿起附近的 {object:灭火器}（{dot:Blue}）来扑灭 {object:孤独浴缸} 上的火焰。'
L['impotent_potable_location'] = '在码头下方，靠近 {location:掠夺派对}'
L['abandoned_toolbox_location'] = '在 {location:废品店} 的屋顶高处。\n\n跟随楼梯到顶部。'
L['trick_deck_of_cards_location'] = '在 {location:大陆酒店} 内 {npc:231045} 旁边的桌子上。'

L['ditty_fuzeboy_note'] = '用 {item:234741} 交换宠物。'
L['angelo_rustbin_note'] = '用 {currency:3220} 交换宠物和 {object:G-99 极速} 自定义选项。'

L['options_icons_nine_tenths'] = '{achievement:40948}'
L['options_icons_nine_tenths_desc'] = '显示 {achievement:40948} 的所有 {object:马夫的自锁箱} 位置。'
L['muffs_auto_locker_label'] = '马夫的自锁箱'
L['muffs_auto_locker_note'] = '收集所有 5 个 Gorillion 部件并完成 {quest:87406} 以制作 {item:232843}。'
L['muffs_auto_locker_suffix'] = '马夫的自锁箱已打开'

L['options_icons_between_the_lines'] = '{achievement:41588}'
L['options_icons_between_the_lines_desc'] = '显示 {achievement:41588} 的书籍位置。'
L['a_threatening_letter_location'] = '在 {location:蒸汽轮实验室} 的底层楼梯下。'
L['gallywixs_notes_location'] = '在 {location:藏宝室} 后面的桌子上。'

L['options_icons_can_do_attitude'] = '{achievement:41589}'
L['options_icons_can_do_attitude_desc'] = '显示 {achievement:41589} 的 {npc:237103} 位置。'
L['discarded_can_label'] = '{npc:237103}'
L['discarded_can_note'] = '踢几次 {npc:237103}。'
L['discarded_can_suffix'] = '罐头被踢'

L['options_icons_scrap_rewards'] = 'S.C.R.A.P. 堆'
L['options_icons_scrap_rewards_desc'] = '显示 {object:S.C.R.A.P. 堆} 的奖励。'
L['scrap_heap_suffix'] = 'S.C.R.A.P. 任务完成'


--Core

-------------------------------------------------------------------------------
------------------------------------ GEAR -------------------------------------
-------------------------------------------------------------------------------

L['bag'] = '背包'
L['cloth'] = '布甲'
L['leather'] = '皮甲'
L['mail'] = '锁甲'
L['plate'] = '板甲'
L['cosmetic'] = '装饰品'
L['tabard'] = '战袍'

L['1h_mace'] = '单手锤'
L['1h_sword'] = '单手剑'
L['1h_axe'] = '单手斧'
L['2h_mace'] = '双手锤'
L['2h_axe'] = '双手斧'
L['2h_sword'] = '双手剑'
L['shield'] = '盾牌'
L['dagger'] = '匕首'
L['staff'] = '法杖'
L['fist'] = '拳套'
L['polearm'] = '长柄武器'
L['bow'] = '弓'
L['gun'] = '枪'
L['wand'] = '魔杖'
L['crossbow'] = '弩'
L['offhand'] = '副手'
L['warglaive'] = '战刃'

L['ring'] = '戒指'
L['neck'] = '项链'
L['cloak'] = '披风'
L['trinket'] = '饰品'

-------------------------------------------------------------------------------
---------------------------------- TOOLTIPS -----------------------------------
-------------------------------------------------------------------------------

L['activation_unknown'] = '激活未知！'
L['requirement_not_found'] = '所需位置未知！'
L['multiple_spawns'] = '可能出现在多个位置。'
L['shared_drops'] = '共享掉落'
L['zone_drops_label'] = '区域掉落'
L['zone_drops_note'] = '下面列出的物品可以由该区域中的多个怪物掉落。'

L['poi_entrance_label'] = '入口'

L['requires'] = '需要'
L['ranked_research'] = '%s（等级 %d/%d）'

L['focus'] = '焦点'
L['retrieving'] = '正在获取物品链接…'

L['normal'] = '普通'
L['hard'] = '困难'

L['completed'] = '已完成'
L['incomplete'] = '未完成'
L['claimed'] = '已获得'
L['unclaimed'] = '未获得'
L['known'] = '✓'
L['missing'] = '缺少'
L['unobtainable'] = '无法获得'
L['unlearnable'] = '无法解锁'
L['defeated'] = '已击杀'
L['undefeated'] = '未击杀'
L['elite'] = '精英'
L['quest'] = '任务'
L['quest_repeatable'] = '可重复任务'
L['achievement'] = '成就'

---------------------------------- LOCATION -----------------------------------
L['in_cave'] = '在洞穴。'
L['in_small_cave'] = '在小洞穴。'
L['in_water_cave'] = '在水下洞穴。'
L['in_waterfall_cave'] = '瀑布后面洞穴中。'
L['in_water'] = '在水中。'
L['in_building'] = '在建筑里面。'

------------------------------------ TIME -------------------------------------
L['now'] = '现在'
L['hourly'] = '每小时'
L['daily'] = '每日'
L['weekly'] = '每周'

L['time_format_12hrs'] = '%m/%d - %I:%M %p 本地时间'
L['time_format_24hrs'] = '%m/%d - %H:%M 本地时间'

----------------------------------- REWARDS -----------------------------------
L['heirloom'] = '传家宝'
L['item'] = '物品'
L['mount'] = '坐骑'
L['pet'] = '宠物'
L['recipe'] = '配方'
L['spell'] = '法术'
L['title'] = '头衔'
L['toy'] = '玩具'
L['currency'] = '货币'
L['rep'] = '声望'

---------------------------------- FOLLOWERS ----------------------------------
L['follower_type_follower'] = '追随者'
L['follower_type_champion'] = '勇士'
L['follower_type_companion'] = '伙伴'

--------------------------------- REPUTATION ----------------------------------
L['rep_honored'] = '尊敬'
L['rep_revered'] = '崇敬'
L['rep_exalted'] = '崇拜'

-------------------------------------------------------------------------------
--------------------------------- DRAGONRACES ---------------------------------
-------------------------------------------------------------------------------

L['dr_your_best_time'] = '最快时间：'
L['dr_your_target_time'] = '目标时间：'
L['dr_best_time'] = ' - %s：%.3f秒'
L['dr_target_time'] = ' - %s：%s秒 / %s秒'
L['dr_normal'] = '普通'
L['dr_advanced'] = '进阶'
L['dr_reverse'] = '反向'
L['dr_challenge'] = '挑战'
L['dr_reverse_challenge'] = '反向挑战'
L['dr_storm_race'] = '风雷之速'
L['dr_bronze'] = '完成竞速获得 ' .. '|cFFCD7F32青铜|r' .. '。'
L['dr_vendor_note'] = '用 {currency:2588} 兑换观龙者手稿和幻化。'
L['options_icons_dragonrace'] = '驭龙竞速'
L['options_icons_dragonrace_desc'] = '显示区域内全部驭龙竞速的位置。'

-------------------------------------------------------------------------------
--------------------------------- CONTEXT MENU --------------------------------
-------------------------------------------------------------------------------

L['context_menu_set_waypoint'] = '设置地图路径点'
L['context_menu_add_tomtom'] = '添加到 TomTom'
L['context_menu_add_group_tomtom'] = '添加组到 TomTom'
L['context_menu_add_focus_group_tomtom'] = '添加相关项到 TomTom'
L['context_menu_hide_node'] = '隐藏此项'
L['context_menu_restore_hidden_nodes'] = '恢复所有隐藏项'

L['map_button_text'] = '调整此地图上的图标显示，透明度和缩放。'

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

L['options_global'] = '全局'
L['options_zones'] = '区域'

L['options_general_description'] = '控制该项的特性及其奖励的设置。'
L['options_global_description'] = '控制全部区域中全部的项显示的设置。'
L['options_zones_description'] = '控制每个单独区域中的项显示的设置。'

L['options_open_settings_panel'] = '打开设置面板…'
L['options_open_world_map'] = '打开世界地图'
L['options_open_world_map_desc'] = '打开此区域世界地图。'

------------------------------------ ICONS ------------------------------------

L['options_icon_settings'] = '图标设置'
L['options_scale'] = '缩放'
L['options_scale_desc'] = '1 = 100%'
L['options_opacity'] = '透明度'
L['options_opacity_desc'] = '0 = 透明, 1 = 不透明'

---------------------------------- VISIBILITY ---------------------------------

L['options_show_worldmap_button'] = '显示世界地图按钮'
L['options_show_worldmap_button_desc'] = '在世界地图右上角添加一个快速切换下拉菜单。'

L['options_visibility_settings'] = '可见性'
L['options_general_settings'] = '通用'
L['options_show_completed_nodes'] = '显示已完成'
L['options_show_completed_nodes_desc'] = '显示全部项即使它们今天已被拾取或完成。'
L['options_toggle_hide_done_rare'] = '隐藏所有拾取已知的稀有'
L['options_toggle_hide_done_rare_desc'] = '隐藏所有拾取已知的稀有。'
L['options_toggle_hide_done_treasure'] = '隐藏所有拾取已知的宝藏'
L['options_toggle_hide_done_treasure_desc'] = '隐藏所有拾取已知的宝藏。'
L['options_toggle_hide_minimap'] = '隐藏小地图上的所有图标'
L['options_toggle_hide_minimap_desc'] = '在小地图上隐藏此插件的所有图标，只会在世界地图上显示。'
L['options_toggle_maximized_enlarged'] = '世界地图最大化时图标放大'
L['options_toggle_maximized_enlarged_desc'] = '当世界地图最大化，放大全部图标。'
L['options_toggle_use_char_achieves'] = '使用角色成就'
L['options_toggle_use_char_achieves_desc'] = '显示成就进度为此角色而不是全部账号。'
L['options_toggle_per_map_settings'] = '使用区域特定设置'
L['options_toggle_per_map_settings_desc'] = '应用切换，缩放和透明度设置到每个区域。'
L['options_restore_hidden_nodes'] = '恢复隐藏项'
L['options_restore_hidden_nodes_desc'] = '使用右击菜单恢复全部隐藏项。'

L['ignore_class_restrictions'] = '忽略职业限制'
L['ignore_class_restrictions_desc'] = '显示需要与当前角色不同职业的组、项和奖励。'
L['ignore_faction_restrictions'] = '忽略阵营限制'
L['ignore_faction_restrictions_desc'] = '显示需要对立阵营的组、项和奖励。'

L['options_rewards_settings'] = '奖励'
L['options_reward_behaviors_settings'] = '奖励行为'
L['options_reward_types'] = '显示奖励类型'
L['options_manuscript_rewards'] = '显示观龙者手稿奖励'
L['options_manuscript_rewards_desc'] = '在提示中显示龙观察者手稿奖励并跟踪其收集状态。'
L['options_mount_rewards'] = '显示坐骑奖励'
L['options_mount_rewards_desc'] = '在提示中显示坐骑奖励并跟踪其收集状态。'
L['options_pet_rewards'] = '显示宠物奖励'
L['options_pet_rewards_desc'] = '在提示中显示宠物奖励并跟踪其收集状态。'
L['options_recipe_rewards'] = '显示配方奖励'
L['options_recipe_rewards_desc'] = '在提示中显示配方奖励并跟踪其收集状态。'
L['options_toy_rewards'] = '显示玩具奖励'
L['options_toy_rewards_desc'] = '在提示中显示玩具奖励并跟踪其收集状态。'
L['options_transmog_rewards'] = '显示幻化奖励'
L['options_transmog_rewards_desc'] = '在提示中显示幻化奖励并跟踪其收集状态。'
L['options_all_transmog_rewards'] = '显示无法获取的幻化奖励'
L['options_all_transmog_rewards_desc'] = '显示其它职业可以获取的幻化奖励。'
L['options_rep_rewards'] = '显示声望奖励'
L['options_rep_rewards_desc'] = '在提示中显示声望奖励并跟踪其收集状态。'
L['options_claimed_rep_rewards'] = '显示以已获得声望奖励'
L['options_claimed_rep_rewards_desc'] = '在提示中显示获得战团已获得声望奖励。'

L['options_icons_misc_desc'] = '显示其它未分类项的位置。'
L['options_icons_misc'] = '杂项'
L['options_icons_pet_battles_desc'] = '显示宠物训练师和 NPC 的位置。'
L['options_icons_pet_battles'] = '战斗宠物'
L['options_icons_rares_desc'] = '显示稀有 NPC 的位置。'
L['options_icons_rares'] = '稀有'
L['options_icons_treasures_desc'] = '显示隐藏宝藏的位置。'
L['options_icons_treasures'] = '宝藏'
L['options_icons_vendors_desc'] = '显示供应商位置。'
L['options_icons_vendors'] = '供应商'

------------------------------------ FOCUS ------------------------------------

L['options_focus_settings'] = '兴趣点'
L['options_poi_color'] = '兴趣点颜色'
L['options_poi_color_desc'] = '图标为焦点时设定兴趣点颜色。'
L['options_path_color'] = '路径颜色'
L['options_path_color_desc'] = '图标为焦点时设定路径颜色。'
L['options_reset_poi_colors'] = '颜色重置'
L['options_reset_poi_colors_desc'] = '重置上面的颜色为预设。'

----------------------------------- TOOLTIP -----------------------------------

L['options_tooltip_settings'] = '提示'
L['options_toggle_show_loot'] = '显示拾取'
L['options_toggle_show_loot_desc'] = '在提示中加入拾取信息'
L['options_toggle_show_notes'] = '显示注释'
L['options_toggle_show_notes_desc'] = '在提示中添加注释'
L['options_toggle_use_standard_time'] = '使用12小时时钟'
L['options_toggle_use_standard_time_desc'] = '在提示中使用12小时时钟（如：8:00 PM）而不是24小时时钟（如：20:00）。'
L['options_toggle_show_npc_id'] = '显示 NPC ID'
L['options_toggle_show_npc_id_desc'] = '显示 NPC ID 以供稀有扫描插件使用。'

--------------------------------- DEVELOPMENT ---------------------------------

L['options_dev_settings'] = '开发'
L['options_toggle_show_debug_currency'] = '除错货币 ID'
L['options_toggle_show_debug_currency_desc'] = '显示货币除错更改信息（需要重载）'
L['options_toggle_show_debug_map'] = '除错地图 ID'
L['options_toggle_show_debug_map_desc'] = '显示地图除错信息'
L['options_toggle_show_debug_quest'] = '除错任务 ID'
L['options_toggle_show_debug_quest_desc'] = '显示任务除错更改信息（需要重载）'
L['options_toggle_force_nodes'] = '强制显示项'
L['options_toggle_force_nodes_desc'] = '强制显示所有项'


L["TravelGuide_plugin_name"] = "旅行指南"
L["TravelGuide_plugin_desc"] = "在世界地图和小地图上显示传送门、飞艇、港口图标。"

L["config_tab_general"] = "通用"
L["config_tab_scale_alpha"] = "缩放/透明度"
--L["config_scale_alpha_desc"] = "PH"
L["config_icon_scale"] = "图标大小"
L["config_icon_scale_desc"] = "调整图标的大小"
L["config_icon_alpha"] = "图标透明度"
L["config_icon_alpha_desc"] = "修改图标透明度"
L["config_what_to_display"] = "显示什么？"
L["config_what_to_display_desc"] = "在这里设置显示哪些类型的图标。"

L["config_portal"] = "传送门"
L["config_portal_desc"] = "显示传送门的位置。"

L["config_order_hall_portal"] = "职业大厅"
L["config_order_hall_portal_desc"] = "显示职业大厅传送门的位置。"

L["config_warfront_portal"] = "战争前线传送门"
L["config_warfront_portal_desc"] = "显示战争前线传送门的位置。"

L["config_petbattle_portal"] = "宠物对战传送门"
L["config_petbattle_portal_desc"] = "显示宠物对战传送门的位置。"

L["config_ogreWaygate"] = "食人魔传送门"
L["config_ogreWaygate_desc"] = "显示食人魔传送门的位置。"

L["config_show_reflectivePortal"] = "反射传送门"
L["config_show_reflectivePortal_desc"] = "显示反射传送门的位置，需要玩具：[百变之镜]。"

L["config_boat"] = "船"
L["config_boat_desc"] = "显示船的位置。"
L["config_boat_alliance"] = "船-联盟"
L["config_boat_alliance_desc"] = "显示所有联盟船只的位置。"

L["config_zeppelin"] = "飞艇"
L["config_zeppelin_desc"] = "显示飞艇位置。"
L["config_zeppelin_horde"] = "飞艇-部落"
L["config_zeppelin_horde_desc"] = "显示所有部落飞艇的位置。"

L["config_tram"] = "矿道地铁"
L["config_tram_desc"] = "显示暴风城和铁炉堡的矿道地铁位置。"

L["config_molemachine"] = "钻探机[黑铁矮人]"
L["config_molemachine_desc"] = "显示钻探机[黑铁矮人]目的地。"

L["config_note"] = "图标"
L["config_note_desc"] = "当图标（船/传送点）可用时，显示相关的注释。"

L["config_remove_unknown"] = "屏蔽未知的目的地标注"
L["config_remove_unknown_desc"] = "这将屏蔽在世界地图上没有满足要求的目的地标注。"

L["config_remove_AreaPois"] = "屏蔽暴雪目的地标注"
L["config_remove_AreaPois_desc"] = "这将屏蔽暴雪在世界地图上设置的目的地的标注点（POI）。"

L["config_easy_waypoints"] = "简易导航点"
L["config_easy_waypoints_desc"] = "创建简易导航点。\n右键点击设置导航，CTRL + 右键更多选项。"
L["config_waypoint_dropdown"] = "选择"
L["config_waypoint_dropdown_desc"] = "选择如何建立导航点"
L["Blizzard"] = "暴雪原生"
L["TomTom"] = true
L["Both"] = "同时显示"

L["config_teleportPlatform"] = "奥利波斯传送平台"
L["config_teleportPlatform_desc"] = "显示奥利波斯传送平台位置."

L["config_animaGateway"] = "显示心能传送门"
L["config_animaGateway_desc"] = "显示心能传送门位置。"

L["config_others"] = "其它"
L["config_others_desc"] = "显示所有其它POI。"

L["config_restore_nodes"] = "恢复所有隐藏图标"
L["config_restore_nodes_desc"] = "显示所有被你隐藏的图标。"
L["config_restore_nodes_print"] = "所有隐藏图标已还原"

----------------------------------------------------------------------------------------------------
-------------------------------------------------DEV------------------------------------------------
----------------------------------------------------------------------------------------------------

L["dev_config_tab"] = "DEV"

L["dev_config_force_nodes"] = "强制显示"
L["dev_config_force_nodes_desc"] = "无论你的职业或阵营, 强制显示所有的点."

L["dev_config_show_prints"] = "显示标记()"
L["dev_config_show_prints_desc"] = "在聊天窗口中显示标记() 的信息."

----------------------------------------------------------------------------------------------------
-----------------------------------------------HANDLER----------------------------------------------
----------------------------------------------------------------------------------------------------

--==========================================CONTEXT_MENU==========================================--

L["handler_context_menu_addon_name"] = "HandyNotes: 旅行指南"
L["handler_context_menu_add_tomtom"] = "添加到TomTom"
L["handler_context_menu_add_map_pin"] = "设置航点"
L["handler_context_menu_hide_node"] = "隐藏图标"

--============================================TOOLTIPS============================================--

L["handler_tooltip_requires"] = "需要"
L["handler_tooltip_sanctum_feature"] = "圣所升级"
L["handler_tooltip_data"] = "接收数据中..."
L["handler_tooltip_quest"] = "需要解锁任务"
L["handler_tooltip_requires_level"] = "需要玩家等级"
L["handler_tooltip_rep"] = "需要声望"
L["handler_tooltip_toy"] = "需要玩具"
L["handler_tooltip_TNTIER"] = "旅行网络的第 %s 层."
L["handler_tooltip_not_available"] = "当前不可用"
-- L["currently available"] = "目前可用"
L["handler_tooltip_not_discovered"] = "尚未发现"

----------------------------------------------------------------------------------------------------
----------------------------------------------DATABASE----------------------------------------------
----------------------------------------------------------------------------------------------------

-------------------------------------------------TWW------------------------------------------------

L["Portal to Dragonblight"] = "通往龙骨荒野的传送门"
L["Portal to Dustwallow Marsh"] = "通往尘泥沼泽的传送门"
L["Portal to Searing Gorge"] = "通往灼热峡谷的传送门"
L["Portal to Dornogal"] = "通往多恩诺嘉尔的传送门"
L["Portal to Azj-Kahet"] = "通往艾基-卡赫特的传送门"
L["Elevator to Isle of Dorn"] = "通往多恩岛的电梯"
L["Elevator to Ringing Deeps"] = "通往喧鸣深窟的电梯"
L["Portal to Ardenweald"] = "通往炽蓝仙野的传送门"
L["Portal to Bastion"] = "通往晋升堡垒的传送门"
L["Portal to Tiragarde Sound"] = "通往提拉加德海峡的传送门"
L["Portal to Twilight Highlands"] = "通往暮光高地的传送门"
L["Zeppelin to Siren Isle"] = "前往海妖岛的船（飞艇）"
L["Zeppelin to Dornogal"] = "返回多恩诺嘉尔的船（飞艇）"
L["Mole Machine to Siren Isle"] = "前往海妖岛的钻探机"
L["Mole Machine to Gundargaz"] = "前往冈达加兹的钻探机"
-- L["Rocket Drill to Undermine"] = ""
-- L["Rocket Drill to Ringing Deeps"] = ""
L["Teleporter to Undermine"] = "前往安德麦的传送器"
L["Teleporter to Dornogal"] = "前往多恩诺嘉尔的传送器"

--==========================================DRAGONFLIGHT==========================================--

L["Portal to Valdrakken"] = "通往瓦德拉肯的传送门"
L["Boat to Dragon Isle"] = "前往巨龙群岛的船"
L["Zeppelin to Dragon Isle"] = "前往巨龙群岛的飞艇"
L["Teleport to Seat of the Aspects"] = "传送到守护巨龙之座"
L["Portal to Badlands"] = "通往荒芜之地的传送门"
L["Portal to Emerald Dream"] = "通往翡翠梦境的传送门"
L["Portal to Ohn'ahran Plains"] = "通往欧恩哈拉平原的传送门"
L["Portal to Central Encampment"] = "通往中心营地的传送门"
L["Portal to The Timeways"] = "通往时间流的传送门"
L["Portal to Bel'ameth"] = "通往贝拉梅斯的传送门"
L["Portal to Feathermoon Stronghold"] = "通往羽月要塞的传送门"
L["Portal to Mount Hyjal"] = "通往海加尔山的传送门"
L["Boat to Belanaar"] = "前往贝拉纳尔（贝拉梅斯）的船"
L["Boat to Stormglen"] = "前往风谷村（吉尔尼斯）的船"
L["Portal to The Nighthold"] = "通往暗夜要塞的传送门"
L["Portal to Shal'Aran"] = "通往沙尔艾兰的传送门"
L["Rift to Dalaran"] = "通往达拉然的裂隙"
L["Rift to Telogrus"] = "前往泰洛古斯的裂隙"
L["Portal to Thunder Totem"] = "通往雷霆图腾的传送门"

--==========================================SHADOWLANDS===========================================--

L["Portal to Oribos"] = "通往奥利波斯的传送门"
L["Waystone to Oribos"] = "前往奥利波斯的道标石"
L["To Ring of Transference"] = "前往转移之环"
L["To Ring of Fates"] = "前往命运之环"
L["Into the Maw"] = "进入噬渊"
L["To Keeper's Respite"] = "前往刻希亚的传送门"
L["Portal to Torghast"] = "通往托加斯特的传送门"
L["Portal to Zereth Mortis"] = "前往扎雷殁提斯的传送门"

--============================================Bastion=============================================--

L["Anima Gateway to Hero's rest"] = "心能传送门"

-------------------------------------------------BfA------------------------------------------------

L["Portal to Zuldazar"] = "通往祖达萨的传送门"
L["Boat to Zuldazar"] = "前往达萨罗（祖达萨）的船"
L["Return to Zuldazar"] = "返回祖达萨"
L["Boat to Vol'dun"] = "前往沃顿的船"
L["Boat to Nazmir"] = "前往纳兹米尔的船"
L["Portal to Nazjatar"] = "通往纳沙塔尔的传送门"
L["Submarine to Mechagon"] = "前往麦卡贡的潜艇"
L["Portal to Silithus"] = "通往希利苏斯的传送门"
L["Boat to Echo Isles"] = "前往回声群岛（杜隆塔尔）的船"

L["Portal to Boralus"] = "通往伯拉勒斯的传送门"
L["Boat to Boralus"] = "前往伯拉勒斯（提拉加德海峡）的船"
L["Return to Boralus"] = "返回伯拉勒斯"
L["Boat to Drustvar"] = "前往德鲁斯瓦的船"
L["Boat to Stormsong Valley"] = "前往斯托颂谷地的船"
L["Boat to Tiragarde Sound"] = "前往提拉加德海峡的船"

L["Portal to Arathi Highlands"] = "通往阿拉希高地的传送门"
L["Portal to Port of Zandalar"] = "通往赞达拉港的传送门"
L["Portal to Darkshore"] = "通往黑海岸的传送门"
L["Portal to Port of Boralus"] = "通往伯拉勒斯的传送门"

-----------------------------------------------LEGION-----------------------------------------------

L["Portal to Stormheim"] = "通往风暴峡湾的传送门"
L["Portal to Helheim"] = "通往冥狱深渊的传送门"
L["Portal to Dalaran"] = "通往达拉然（晶歌森林）的传送门"
L["Portal to Azsuna"] = "通往阿苏纳的传送门"
L["Portal to Val'sharah"] = "通往瓦尔莎拉的传送门"
L["Portal to Emerald Dreamway"] = "通往翡翠梦境的传送门"
L["Portal to Suramar"] = "通往苏拉玛的传送门"
L["Portal to Highmountain"] = "通往至高岭的传送门"
L["Great Eagle to Trueshot Lodge"] = "前往神射手营地的巨鹰"
L["Jump to Skyhold"] = "前往苍穹要塞，跳！"
L["Portal to Duskwood"] = "通往暮色森林的传送门"
L["Portal to Feralas"] = "通往菲拉斯的传送门"
L["Portal to Grizzly Hills"] = "通往灰熊丘陵的传送门"
L["Portal to Hinterlands"] = "通往辛特兰的传送门"
L["Portal to Moonglade"] = "通往月光林地的传送门"
L["Portal to Dreamgrove"] = "通往梦境林地的传送门"
L["Portal to Wyrmrest Temple"] = "通往龙眠神殿的传送门"
L["Portal to Karazhan"] = "通往卡拉赞的传送门"

-------------------------------------------------WoD------------------------------------------------

L["Portal to Warspear"] = "通往战争之矛（阿什兰）的传送门"
L["Portal to Stormshield"] = "通往暴风之盾（阿什兰）的传送门"
L["Portal to Vol'mar"] = "通往沃马尔的传送门"
L["Portal to Lion's watch"] = "通往雄狮岗哨的传送门"
L["Ogre Waygate"] = "食人魔传送门"
L["Reflective Portal"] = "反射传送门[百变之镜]"

-------------------------------------------------MoP------------------------------------------------

L["Portal to Jade Forest"] = "通往翡翠林的传送门"
L["Portal to Pandaria"] = "通往潘达利亚的传送门"
L["Portal to Isle of Thunder"] = "通往雷神岛的传送门"
L["Portal to Shado-Pan Garrison"] = "通往影踪卫戍营的传送门"
L["Portal to Peak of Serenity"] = "通往晴日峰（昆莱山）的传送门"

-------------------------------------------------CATA-----------------------------------------------

L["Portal to Deepholm"] = "通往深岩之洲的传送门"
L["Portal to Temple of Earth"] = "通往大地神殿的传送门"
L["Portal to Therazane's Throne"] = "通往塞拉赞恩的王座的传送门"
L["Portal to Twilight Highlands"] = "通往暮光高地的传送门"
L["Portal to Tol Barad"] = "通往托尔巴拉德的传送门"
L["Portal to Uldum"] = "通往奥丹姆的传送门"
L["Portal to Vashj'ir"] = "通往瓦丝琪尔的传送门"
L["Portal to Hyjal"] = "通往海加尔的传送门"
L["Portal to the Firelands"] = "到火焰之地的传送门"

------------------------------------------------WotLK-----------------------------------------------

L["Portal to the Purple Parlor"] = "通往紫色天台的传送门"
L["Boat to Howling Fjord"] = "前往匕鞘湾（嚎风峡湾）的船"
L["Boat to Kamagua"] = "前往卡玛古（嚎风峡湾）的船"
L["Portal to Howling Fjord"] = "通往嚎风峡湾的传送门"
L["Boat to Borean Tundra"] = "前往无畏要塞（北风苔原）的船"
L["Boat to Unu'pe"] = "前往乌努比（北风苔原）的船"
L["Zeppelin to Borean Tundra"] = "前往战歌要塞（北风苔原）的飞艇"
L["Boat to Moa'ki Harbor"] = "前往莫亚基港口（龙骨荒野）的船"
L["Waygate to Sholazar Basin"] = "通往索拉查盆地"

-------------------------------------------------BC-------------------------------------------------

L["Portal to Hellfire Peninsula"] = "通往地狱火半岛的传送门"
L["Portal to Shattrath"] = "通往沙塔斯的传送门"
L["Portal to Isle of Quel'Danas"] = "通往奎尔丹纳斯岛的传送门"
L["Portal to Exodar"] = "通往埃索达的传送门"
L["in Exodar"] = "埃索达内部"
L["Boat to Exodar"] = "前往埃索达的船"
L["Speak with Zephyr"] = "和塞菲尔对话-传送"

-----------------------------------------------VANILLA----------------------------------------------

L["Boat to Menethil Harbor"] = "前往米奈希尔港（湿地）的船"

L["Portal to Silvermoon"] = "通往银月城的传送门"

L["Portal to Undercity"] = "通往幽暗城的传送门"
L["Orb of translocation"] = "传送宝珠"
L["in Undercity Magic Quarter"] = "幽暗城魔法区内部"

L["Zeppelin to Stranglethorn Vale"] = "前往格罗姆高（荆棘谷）的飞艇"
L["Portal to Stranglethorn Vale"] = "通往荆棘谷的传送门"
L["Boat to Booty Bay"] = "前往藏宝海湾（荆棘谷）的船"

L["Portal to Stormwind"] = "通往暴风城的传送门"
L["Boat to Stormwind"] = "前往暴风城的船"
L["Deeprun Tram to Stormwind"] = "前往暴风城的矿道地铁"

L["Portal to Ironforge"] = "通往铁炉堡的传送门"
L["Deeprun Tram to Ironforge"] = "前往铁炉堡的矿道地铁"

L["Portal to Orgrimmar"] = "通往奥格瑞玛的传送门"
L["Zeppelin to Orgrimmar"] = "前往奥格瑞玛的飞艇"

L["Portal to Thunder Bluff"] = "通往雷霆崖的传送门"
L["Zeppelin to Thunder Bluff"] = "前往雷霆崖的飞艇"

L["Portal to Darnassus"] = "通往达纳苏斯的传送门"

L["Boat to Ratchet"] = "前往棘齿城（北贫瘠之地）的船"

L["Boat to Theramore Isle"] = "前往塞拉摩岛（尘泥沼泽）的船"

L["Portal to Caverns of Time"] = "通往时光之穴的传送门"

L["Portal to Dalaran Crater"] = "通往达拉然巨坑的传送门"
L["Portal to the Sepulcher"] = "通往墓地的传送门"

L["Waygate to Un'Goro Crater"] = "通往安戈洛环形山"
L["The Masonary"] = "石匠区"
L["inside the Blackrock Mountain"] = "在黑石山内部"


L["config_plugin_name"] = "奥利波斯"
L["config_plugin_desc"] = "在世界地图和小地图中提示奥利波斯的各种NPC"

L["config_tab_general"] = "通用"
L["config_tab_scale_alpha"] = "缩放/透明度"
--L["config_scale_alpha_desc"] = "PH"
L["config_icon_scale"] = "图标大小"
L["config_icon_scale_desc"] = "调整图标的大小"
L["config_icon_alpha"] = "图标透明度"
L["config_icon_alpha_desc"] = "修改图标透明度"
L["config_what_to_display"] = "选择要显示的图标"
L["config_what_to_display_desc"] = "根据你的需要在下面调整所显示的图标"

L["config_auctioneer"] = "拍卖行"
L["config_auctioneer_desc"] = "显示拍卖行的位置"

L["config_banker"] = "银行"
L["config_banker_desc"] = "显示拍卖行的位置"

L["config_barber"] = "美容师"
L["config_barber_desc"] = "显示美容师的位置"

L["config_guildvault"] = "公会银行"
L["config_guildvault_desc"] = "显示公会银行图标"

L["config_innkeeper"] = "旅店"
L["config_innkeeper_desc"] = "显示旅店的位置"

L["config_mail"] = "邮箱"
L["config_mail_desc"] = "显示邮箱的位置"

L["config_portal"] = "传送门"
L["config_portal_desc"] = "显示传送门的位置。"

L["config_portaltrainer"] = "传送门训练师"
L["config_portaltrainer_desc"] = "显示传送门训练师图标"

L["config_tpplatform"] = "传送平台"
L["config_tpplatform_desc"] = "显示传送平台的位置"

L["config_travelguide_note"] = "|cFFFF0000* 由于 TravelGuide 的存在, 本模块不会启用 |r"

L["config_reforge"] = "物品升级"
L["config_reforge_desc"] = "显示物品升级NPC的位置"

L["config_stablemaster"] = "兽栏管理员"
L["config_stablemaster_desc"] = "显示兽栏管理员的位置"

L["config_trainer"] = "专业训练师"
L["config_trainer_desc"] = "显示专业训练师的位置"

L["config_transmogrifier"] = "幻化师"
L["config_transmogrifier_desc"] = "显示幻化师的位置"

L["config_vendor"] = "商人"
L["config_vendor_desc"] = "显示商人的位置"

L["config_void"] = "虚空仓库"
L["config_void_desc"] = "显示虚空仓库的位置"

L["config_zonegateway"] = "各地图通道"
L["config_zonegateway_desc"] = "在转移之环中显示各地图的通道"

L["config_others"] = "其他"
L["config_others_desc"] = "显示其他的点"

L["config_onlymytrainers"] = "只显示与我专业相关的训练师和商人"
L["config_onlymytrainers_desc"] = [[
只显示与我专业相关的训练师和商人

|cFFFF0000 注意:只有学习了两个专业后该功能才有效果 |r
]]

L["config_fmaster_waypoint"] = "飞行点导航"
L["config_fmaster_waypoint_desc"] = "当你进入转移之环时, 自动在飞行点建立导航点."

L["config_easy_waypoints"] = "便捷导航"
L["config_easy_waypoints_desc"] = "使你可以更简单的建立导航路线, 你可以通过右键单击设定导航点或者使用CTRL+右键单击获得更多选项."

L["config_waypoint_dropdown"] = "选择"
L["config_waypoint_dropdown_desc"] = "选择如何建立导航点"
L["Blizzard"] = "暴雪原生"
L["TomTom"] = true
L["Both"] = "同时显示"

L["config_picons"] = "显示专业图标"
L["config_picons_vendor_desc"] = "显示专业图标而不是商人图标"
L["config_picons_trainer_desc"] = "显示专业图标而不是训练师图标"
L["config_use_old_picons"] = "显示旧职业图标"
L["config_use_old_picons_desc"] = "显示旧职业图标而不是新的图标 (巨龙时代之前的)."

L["config_restore_nodes"] = "恢复被隐藏的图标"
L["config_restore_nodes_desc"] = "恢复被你隐藏掉的图标"
L["config_restore_nodes_print"] = "所有隐藏的图标已被恢复"

----------------------------------------------------------------------------------------------------
-------------------------------------------------DEV------------------------------------------------
----------------------------------------------------------------------------------------------------

L["dev_config_tab"] = "DEV"

L["dev_config_force_nodes"] = "强制显示"
L["dev_config_force_nodes_desc"] = "无论你的职业或阵营, 强制显示所有的点."

L["dev_config_show_prints"] = "显示标记()"
L["dev_config_show_prints_desc"] = "在聊天窗口中显示标记()的信息"

----------------------------------------------------------------------------------------------------
-----------------------------------------------HANDLER----------------------------------------------
----------------------------------------------------------------------------------------------------

--==========================================CONTEXT_MENU==========================================--

L["handler_context_menu_addon_name"] = "HandyNotes: 奥利波斯"
L["handler_context_menu_add_tomtom"] = "添加到 TomTom"
L["handler_context_menu_add_map_pin"] = "设置地图航点"
L["handler_context_menu_hide_node"] = "隐藏这个图标"

--============================================TOOLTIPS============================================--

L["handler_tooltip_requires"] = "需要"
L["handler_tooltip_data"] = "检索数据中..."
L["handler_tooltip_quest"] = "解锁任务"

----------------------------------------------------------------------------------------------------
----------------------------------------------DATABASE----------------------------------------------
----------------------------------------------------------------------------------------------------

L["Portal to Orgrimmar"] = "通往奥格瑞玛"
L["Portal to Stormwind"] = "通往暴风城"
L["To Ring of Transference"] = "前往转移之环"
L["To Ring of Fates"] = "前往命运之环"
L["Into the Maw"] = "进入噬渊"
L["To Keeper's Respite"] = "前往守护者的休憩"
L["Portal to Zereth Mortis"] = "通往扎雷殁提斯"
L["Mailbox"] = "邮箱"