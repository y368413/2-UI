--## Author: Justwait ## Version: v11.0-2-g18e7a0f
local TML = {}
if GetLocale() == "zhCN" then
TML["AddonNamePrint"] = "\124cFFFF0000传送菜单：\124r " -- 1 space after the :
TML["Common:Loading"] = "LOADING"
TML["Not In Combat Tooltip"] = "\124cFFFF0000<战斗中不可用>\124r"
TML["Random Hearthstone"] = "随机炉石"
TML["Random Hearthstone Tooltip"] = "\124cFF34B7EB点击后，会随机使用一个炉石。\n当你重新打开主菜单时，它会选择一个新炉石。\124r"
TML["Random Hearthstone Location"] = "\n\124cFF34B7EB炉石位置：\124r \124cFF1EFF0C%s\124r"
TML["No Hearthtone In Bags"] = "你背包里没有炉石，也没有设置自定义炉石，请使用 /tpm 命令设置一个炉石。"
TML["Hearthone Reset Error"] = "我们已将你的炉石重置为默认状态，因为你的收藏中没有物品ID：%s  的炉石玩具。"

-- dungeons abreviated Text
TML["The Vortex Pinnacle"] = "旋云"
TML["Throne of the Tides"] = "潮汐"
TML["Grim Batol"] = "格瑞姆"
TML["Temple of the Jade Serpentl"] = "青龙"
TML["Stormstout Brewery"] = "风暴"
TML["Shado-Pan Monastery"] = "影踪"
TML["Mogu'shan Palace"] = "魔古山"
TML["Gate of the Setting Sun"] = "残阳关"
TML["Siege of Niuzao Temple"] = "砮皂寺"
TML["Scarlet Monastery"] = "修道院"
TML["Scarlet Halls"] = "大厅"
TML["Scholomance"] = "通灵"
TML["The Everblooml"] = "永茂"
TML["Shadowmoon Burial Grounds"] = "影月"
TML["Grimrail Depot"] = "恐轨"
TML["Iron Docks"] = "钢铁"
TML["Bloodmaul Slag Mines"] = "血槌矿"
TML["Auchindoun"] = "奥金顿"
TML["Skyreach"] = "通天峰"
TML["Upper Blackrock Spire"] = "黑石上"
TML["Halls of Valor"] = "英灵殿"
TML["Neltharion's Lair"] = "巢穴"
TML["Court of Stars"] = "群星"
TML["Karazhan"] = "卡拉赞"
TML["Black Rook Hold"] = "黑鸦"
TML["Darkheart Thicket"] = "黑心"
TML["Freehold"] = "自由镇"
TML["The Underrot"] = "地渊"
TML["Mechagon"] = "麦卡贡"
TML["The MOTHERLODE!!"] = "暴富"
TML["Waycrest Manor"] = "庄园"
TML["Atal'Dazar"] = "阿塔"
TML["Siege of Boralus"] = "围攻"
TML["The Necrotic Wake"] = "通灵"
TML["Plaguefall"] = "凋魂"
TML["Mists of Tirna Scithe"] = "仙林"
TML["Halls of Atonement"] = "赎罪"
TML["Bastion"] = "晋升"
TML["Theater of Pain"] = "伤逝"
TML["De Other Side"] = "彼界"
TML["Sanguine Depths"] = "赤红"
TML["Tazavesh, the Veiled Market"] = "集市"
TML["Castle Nathria"] = "纳堡"
TML["Sanctum of Domination"] = "统御"
TML["Sepulcher of the First Ones"] = "初诞"
TML["Ruby Life Pools"] = "红玉"
TML["The Nokhud Offensive"] = "诺库德"
TML["Brackenhide Hollow"] = "蕨皮"
TML["Algeth'ar Academy"] = "学院"
TML["Neltharus"] = "奈萨"
TML["The Azure Vault"] = "碧蓝"
TML["Halls of Infusion"] = "注能"
TML["Uldaman"] = "奥达曼"
TML["Dawn of the Infinite"] = "永恒"
TML["Vault of the Incarnates"] = "牢窟"
TML["Aberrus, the Shadowed Crucible"] = "亚贝鲁"
TML["Amirdrassil, the Dream's Hope"] = "阿梅达"
TML["City of Threads"] = "千丝"
TML["The Dawnbreaker"] = "破晨号"
TML["The Stonevault"] = "矶石"
TML["The Rookery"] = "驭雷"
TML["Cinderbrew Meadery"] = "燧酿"
TML["Priory of the Sacred Flame"] = "圣焰"
TML["Ara-Kara, City of Echoes"] = "艾拉"
TML["Darkflame Cleft"] = "暗焰"
TML["Operation: Floodgate"] = "水闸"
TML["Liberation of Undermine"] = "安德麦"
TML["Eco-Dome Al'dani"] = "圆顶"  --奥尔达尼生态圆顶用“生态”因为以前有副本“生态船”

-- expansion abreviated Text
TML["Cataclysm"] = "大裂变"
TML["Mists of Pandaria"] = "熊猫人"
TML["Warlords of Draenor"] = "德拉诺"
TML["Legion"] = "军团"
TML["Battle for Azeroth"] = "争霸"
TML["Shadowlands"] = "暗影"
TML["Shadowlands Raids"] = "暗影-团"
TML["Dragonflight"] = "巨龙"
TML["Dragonflight Raids"] = "巨龙-团"
TML["The War Within"] = "地心"
TML["The War Within Raids"] = "地心-团"
TML["Season 1"] = "1赛季"
TML["Season 2"] = "2赛季"
TML["Season 3"] = "3赛季"
TML["Season 4"] = "4赛季"

-- Mage teleport/portal abreviated text
-- Alliance
TML["Stormwind"] = "暴风城"
TML["Ironforge"] = "铁炉堡"
TML["Darnassus"] = "达纳"
TML["Exodar"] = "埃索达"
TML["Theramore"] = "塞拉摩"
TML["Stormshield"] = "暴风盾"
TML["Boralus"] = "伯拉勒"

-- Horde
TML["Orgrimmar"] = "奥格"
TML["Undercity"] = "幽暗城"
TML["Thunder Bluff"] = "雷霆崖"
TML["Silvermoon"] = "银月城"
TML["Stonard"] = "斯通"
TML["Warspear"] = "战争矛"
TML["Dazar'alor"] = "达萨罗"

-- Shared
TML["Shattrath"] = "沙塔斯"
TML["Dalaran - Northrend"] = "达-诺森"
TML["Tol Barad"] = "托尔巴"
TML["Vale of Eternal Blossoms"] = "锦绣谷"
TML["Dalaran - Broken Isles"] = "达-破碎"
TML["Oribos"] = "奥利"
TML["Valdrakken"] = "瓦德拉"
TML["Dalaran - Ancient"] = "达-远古"
TML["Hall of the Guardian"] = "守-圣殿"
TML["Dornogal"] = "多恩"

-- Options
TML["Opening Options Menu"] = "打开选项菜单"
TML["Enabled"] = "启用"
TML["Enable Tooltip"] = "启用/禁用传送菜单"
TML["Hearthstone Toy"] = "炉石玩具"
TML["Hearthstone Toy Tooltip"] = "设置首选的炉石\n\n如果设置为随机，每次打开游戏菜单都会随机选择一个炉石玩具。"
TML["None"] = "无"
TML["Random"] = "随机"
TML["ButtonText"] = "显示传送缩写"
TML["ButtonText Tooltip"] = "启用后，地下城的缩写名被添加到地下城传送阵上。"
TML["Reverse Mage Flyouts"] = "法师传送顺序"
TML["Reverse Mage Flyouts Tooltip"] = "反转法师的传送技能弹出顺序，使最新的资料片传送先出现"
TML["Seasonal Teleports"] = "赛季传送"
TML["Seasonal Teleports Tooltip"] = "\124cFF34B7EB这些传送适用于当前钥石+赛季地下城。\124r"
TML["Seasonal Teleports Toggle Tooltip"] = "启用/禁用 仅显示当前赛季传送。"
TML["Icon Size"] = "图标大小"
TML["Icon Size Tooltip"] = "选择显示图标大小。"
TML["%s px"] = "%s 像素"
TML["Icons Per Flyout Row"] = "每行显示图标"
TML["Icons Per Flyout Row Tooltip"] = "选择每行显示的最大图标数。"
TML["%s icons"] = "%s 个图标"
TML["Item Teleports"] = "传送物品"
TML["Item Teleports Tooltip"] = "\124cFF34B7EB所有具有传送功能的物品\124r\n\n\124cFFFF0000阵营传送披风需要点击两次！\124r"
TML["Teleports:Items:Filters:Held_Items"] = "你拥有的物品"
TML["Teleports:Items:Filters:Items_To_Be_Obtained"] = "不可用的物品"

-- Settings
TML["ADDON_NAME"] = "|cff33ff99[便捷]|r传送菜单"
TML["TITLE"] = "传送菜单设置"
TML["GENERAL"] = "通用设置"
TML["BUTTON_SETTINGS"] = "按键设置"
TML["TELEPORT_SETTINGS"] = "传送设置"
TML["HEARTHSTONE_SETTINGS"] = "炉石设置"
TML["BUTTON_FONT_SIZE"] = "按键字体大小"
TML["BUTTON_FONT_SIZE_TOOLTIP"] = "选择传送缩写的大小"
TML["Teleports:Items:Filters"] = "物品过滤器"
TML["ABOUT_ADDON"] = "|CFFFFFFFF此插件将您可用的炉石和传送功能添加到游戏菜单中（按ESC键）。\n\n您可以通过在游戏中输入 /tpm 并按照命令更改使用的炉石。\n\n如果有问题或疑问，或者缺少传送/炉石，请随时在Github上联系我。\n\n支持的物品：\n\n 炉石\n 法师传送门/传送\n 工程虫洞\n 英雄之路\n 所有职业传送（禅宗朝圣、黑锋之门、梦境行者等）\n\n \n\n未来计划支持：\n\n背包中的传送物品（使用、装备）。|r"
TML["ABOUT_CONTRIBUTORS"] = "活跃贡献者：|CFFFFFFFF\n\n%s\n\n|r"
elseif GetLocale() == "zhTW" then

TML["AddonNamePrint"] = "\124cFFFF0000傳送選單：\124r " -- 1 space after the :
TML["Common:Loading"] = "載入中"
TML["Not In Combat Tooltip"] = "\124cFFFF0000<戰鬥中不可用>\124r"
TML["Random Hearthstone"] = "隨機爐石"
TML["Random Hearthstone Tooltip"] = "\124cFF34B7EB點擊後，會隨機使用一個爐石。\n當你重新打開主選單時，它會選擇一個新爐石。\124r"
TML["Random Hearthstone Location"] = "\n\124cFF34B7EB爐石所在地：\124r \124cFF1EFF0C%s\124r"
TML["No Hearthtone In Bags"] = "您的背包中沒有爐石或自訂的設置。請使用 /tpm指令以設置一個。"
TML["Hearthone Reset Error"] = "我們已將你的爐石重置為預設狀態，因為此物品ID：%s的玩具並不在您的收藏中。"

-- dungeons abreviated Text
TML["The Vortex Pinnacle"] = "漩渦"
TML["Throne of the Tides"] = "海潮"
TML["Grim Batol"] = "格瑞"
TML["Temple of the Jade Serpentl"] = "玉蛟"
TML["Stormstout Brewery"] = "風暴"
TML["Shado-Pan Monastery"] = "影潘"
TML["Mogu'shan Palace"] = "魔古"
TML["Gate of the Setting Sun"] = "落陽"
TML["Siege of Niuzao Temple"] = "怒兆"
TML["Scarlet Monastery"] = "修道院"
TML["Scarlet Halls"] = "血色"
TML["Scholomance"] = "通靈"
TML["The Everblooml"] = "永茂"
TML["Shadowmoon Burial Grounds"] = "影月"
TML["Grimrail Depot"] = "車站"
TML["Iron Docks"] = "碼頭"
TML["Bloodmaul Slag Mines"] = "血槌"
TML["Auchindoun"] = "奧齊頓"
TML["Skyreach"] = "擎天"
TML["Upper Blackrock Spire"] = "黑石上"
TML["Halls of Valor"] = "英靈"
TML["Neltharion's Lair"] = "巢穴"
TML["Court of Stars"] = "眾星"
TML["Karazhan"] = "卡拉贊"
TML["Black Rook Hold"] = "玄鴉"
TML["Darkheart Thicket"] = "暗心"
TML["Freehold"] = "自由"
TML["The Underrot"] = "幽腐"
TML["Mechagon"] = "機械"
TML["The MOTHERLODE!!"] = "晶喜"
TML["Waycrest Manor"] = "莊園"
TML["Atal'Dazar"] = "阿塔"
TML["Siege of Boralus"] = "圍城"
TML["The Necrotic Wake"] = "死靈"
TML["Plaguefall"] = "瘟疫"
TML["Mists of Tirna Scithe"] = "迷霧"
TML["Halls of Atonement"] = "贖罪"
TML["Bastion"] = "晉升"
TML["Theater of Pain"] = "苦痛"
TML["De Other Side"] = "彼界"
TML["Sanguine Depths"] = "血紅"
TML["Tazavesh, the Veiled Market"] = "市集"
TML["Castle Nathria"] = "納堡"
TML["Sanctum of Domination"] = "統御"
TML["Sepulcher of the First Ones"] = "首創"
TML["Ruby Life Pools"] = "晶紅"
TML["The Nokhud Offensive"] = "進攻"
TML["Brackenhide Hollow"] = "蕨皮"
TML["Algeth'ar Academy"] = "學院"
TML["Neltharus"] = "奈堡"
TML["The Azure Vault"] = "蒼藍"
TML["Halls of Infusion"] = "灌注"
TML["Uldaman"] = "奧達曼"
TML["Dawn of the Infinite"] = "恆龍"
TML["Vault of the Incarnates"] = "洪荒"
TML["Aberrus, the Shadowed Crucible"] = "亞貝"
TML["Amirdrassil, the Dream's Hope"] = "夢境"
TML["City of Threads"] = "蛛絲"
TML["The Dawnbreaker"] = "破曉"
TML["The Stonevault"] = "石庫"
TML["The Rookery"] = "培育"
TML["Cinderbrew Meadery"] = "酒莊"
TML["Priory of the Sacred Flame"] = "聖焰"
TML["Ara-Kara, City of Echoes"] = "回音"
TML["Darkflame Cleft"] = "暗焰"
TML["Operation: Floodgate"] = "水閘"
TML["Liberation of Undermine"] = "幽坑城"
--TML["Eco-Dome Al'dani"] = "EDA"

-- expansion abreviated Text
TML["Cataclysm"] = "浩劫重生"
TML["Mists of Pandaria"] = "潘達利亞"
TML["Warlords of Draenor"] = "德拉諾"
TML["Legion"] = "軍臨"
TML["Battle for Azeroth"] = "決戰"
TML["Shadowlands"] = "暗影"
TML["Shadowlands Raids"] = "暗影 團"
TML["Dragonflight"] = "巨龍"
TML["Dragonflight Raids"] = "巨龍 團"
TML["The War Within"] = "地心"
TML["The War Within Raids"] = "地心 團"
TML["Season 1"] = "賽季1"
TML["Season 2"] = "賽季2"
TML["Season 3"] = "賽季3"
TML["Season 4"] = "賽季4"

-- Mage teleport/portal abreviated text
-- Alliance
TML["Stormwind"] = "暴風"
TML["Ironforge"] = "鐵爐堡"
TML["Darnassus"] = "達納"
TML["Exodar"] = "艾克"
TML["Theramore"] = "賽拉摩"
TML["Stormshield"] = "風暴盾"
TML["Boralus"] = "波拉勒斯"

-- Horde
TML["Orgrimmar"] = "奧格瑪"
TML["Undercity"] = "幽暗"
TML["Thunder Bluff"] = "雷霆"
TML["Silvermoon"] = "銀月"
TML["Stonard"] = "斯通"
TML["Warspear"] = "戰矛"
TML["Dazar'alor"] = "達薩"

-- Shared
TML["Shattrath"] = "撒塔斯"
TML["Dalaran - Northrend"] = "達拉-北"
TML["Tol Barad"] = "托巴"
TML["Vale of Eternal Blossoms"] = "恆春谷"
TML["Dalaran - Broken Isles"] = "達拉-破"
TML["Oribos"] = "奧睿博司"
TML["Valdrakken"] = "沃卓肯"
TML["Dalaran - Ancient"] = "達拉-古"
TML["Hall of the Guardian"] = "守衛廳"
TML["Dornogal"] = "多恩"

-- Options
TML["Opening Options Menu"] = "開啟設定選單"
TML["Enabled"] = "啟用"
TML["Enable Tooltip"] = "啟用/停用 此傳送選單。"
TML["Hearthstone Toy"] = "爐石玩具"
TML["Hearthstone Toy Tooltip"] = "設置首選的爐石玩具。\n\n如果設置為隨機，則每次打開遊戲選單時都會選擇一個隨機的爐石玩具。"
TML["None"] = "無"
TML["Random"] = "隨機"
TML["ButtonText"] = "顯示傳送縮寫"
TML["ButtonText Tooltip"] = "啟用後，地下城的縮寫名被添加到地下城傳送陣上。"
TML["Reverse Mage Flyouts"] = "法師傳送順序"
TML["Reverse Mage Flyouts Tooltip"] = "反轉法師的傳送技能彈出順序，使最新的資料片傳送先出現"
TML["Seasonal Teleports"] = "賽季傳送"
TML["Seasonal Teleports Tooltip"] = "\124cFF34B7EB這些傳送適用於當前鑰石+賽季地下城。\124r"
TML["Seasonal Teleports Toggle Tooltip"] = "啟用/禁用 僅顯示當前賽季傳送。"
TML["Icon Size"] = "圖示大小"
TML["Icon Size Tooltip"] = "提示圖示的大小。"
TML["%s px"] = "%s 像素"
TML["Icons Per Flyout Row"] = "每行彈出選單的圖示數"
TML["Icons Per Flyout Row Tooltip"] = "在建立新行前，最大的彈出圖示數量。"
TML["%s icons"] = "%s 圖示"
TML["Item Teleports"] = "物品傳送"
TML["Item Teleports Tooltip"] = "\124cFF34B7EB所有您擁有的傳送的物品\124r\n\n\124cFFFF0000陣營披風等物品需要點擊兩次！\124r"
TML["Teleports:Items:Filters:Held_Items"] = "您擁有的物品"
TML["Teleports:Items:Filters:Items_To_Be_Obtained"] = "不可用的物品"

-- Settings
TML["ADDON_NAME"] = "|cff33ff99[便捷]|r傳送選單"
TML["TITLE"] = "傳送選單設定"
TML["GENERAL"] = "一般設定"
TML["BUTTON_SETTINGS"] = "按鈕設定"
TML["TELEPORT_SETTINGS"] = "傳送設定"
TML["HEARTHSTONE_SETTINGS"] = "爐石設定"
TML["BUTTON_FONT_SIZE"] = "按鈕文字尺寸"
TML["BUTTON_FONT_SIZE_TOOLTIP"] = "更改此設置控制縮寫傳送名稱的大小"
TML["Teleports:Items:Filters"] = "物品過濾"
TML["ABOUT_ADDON"] = "|CFFFFFFFF此插件將您可用的爐石和傳送添加到遊戲選單（ESC）。\n\n您可以通過鍵入 /tpm gngame和以下命令來更改其使用的爐石。\n\n如果存在問題或疑問，或者缺少傳送/爐石，請隨時在Github上與我聯繫。\n\n支援的物品:\n\n 爐石\n 法師傳送門/傳送門\n 工程學蟲洞\n 英雄之路傳送\n 所有職業傳送 (Zen Pilgramige, Death Gate, Astral Recall etc.)  \n\n \n\n未來計畫支援:  \n\n背包中的傳送物品 (使用、裝備)。|r"
TML["ABOUT_CONTRIBUTORS"] = "活耀貢獻者: |CFFFFFFFF\n\n%s\n\n|r"
else

TML["AddonNamePrint"] = "\124cFFFF0000TeleportMenu:\124r " -- 1 space after the :
TML["Common:Loading"] = "LOADING"
TML["Not In Combat Tooltip"] = "\124cFFFF0000<Not available in combat>\124r"
TML["Random Hearthstone"] = "Random Hearthstone"
TML["Random Hearthstone Tooltip"] = "\124cFF34B7EBClick to cast a random hearthstone.\nIt will pick a new hearthstone when you re-open the menu.\124r"
TML["Random Hearthstone Location"] = "\n\124cFF34B7EBHearthstone Location:\124r \124cFF1EFF0C%s\124r"
TML["No Hearthtone In Bags"] = "You don't have a hearthstone in your bags or set a custom one. Please use /tpm for the commands to set one."
TML["Hearthone Reset Error"] = "We reset your heartstone to default because the toy with itemID: %s is not in your collection."

-- dungeons abreviated Text
TML["The Vortex Pinnacle"] = "VP"
TML["Throne of the Tides"] = "ToTT"
TML["Grim Batol"] = "GB"
TML["Temple of the Jade Serpentl"] = "TJS"
TML["Stormstout Brewery"] = "SB"
TML["Shado-Pan Monastery"] = "SPM"
TML["Mogu'shan Palace"] = "MP"
TML["Gate of the Setting Sun"] = "GATE"
TML["Siege of Niuzao Temple"] = "SoN"
TML["Scarlet Monastery"] = "SM"
TML["Scarlet Halls"] = "SH"
TML["Scholomance"] = "SCHL"
TML["The Everblooml"] = "EB"
TML["Shadowmoon Burial Grounds"] = "SBG"
TML["Grimrail Depot"] = "GD"
TML["Iron Docks"] = "ID"
TML["Bloodmaul Slag Mines"] = "BSM"
TML["Auchindoun"] = "AUCH"
TML["Skyreach"] = "SKY"
TML["Upper Blackrock Spire"] = "UBRS"
TML["Halls of Valor"] = "HoV"
TML["Neltharion's Lair"] = "NL"
TML["Court of Stars"] = "CoS"
TML["Karazhan"] = "KARA"
TML["Black Rook Hold"] = "BRH"
TML["Darkheart Thicket"] = "DHT"
TML["Freehold"] = "FH"
TML["The Underrot"] = "UR"
TML["Mechagon"] = "MECH"
TML["The MOTHERLODE!!"] = "ML"
TML["Waycrest Manor"] = "WM"
TML["Atal'Dazar"] = "AD"
TML["Siege of Boralus"] = "SoB"
TML["The Necrotic Wake"] = "NW"
TML["Plaguefall"] = "PF"
TML["Mists of Tirna Scithe"] = "MoTS"
TML["Halls of Atonement"] = "HoA"
TML["Bastion"] = "SoA"
TML["Theater of Pain"] = "ToP"
TML["De Other Side"] = "DOS"
TML["Sanguine Depths"] = "SD"
TML["Tazavesh, the Veiled Market"] = "TAZ"
TML["Castle Nathria"] = "CN"
TML["Sanctum of Domination"] = "SoD"
TML["Sepulcher of the First Ones"] = "SoFO"
TML["Ruby Life Pools"] = "RLP"
TML["The Nokhud Offensive"] = "NO"
TML["Brackenhide Hollow"] = "BH"
TML["Algeth'ar Academy"] = "AA"
TML["Neltharus"] = "NELT"
TML["The Azure Vault"] = "AV"
TML["Halls of Infusion"] = "HoI"
TML["Uldaman"] = "ULD"
TML["Dawn of the Infinite"] = "DotI"
TML["Vault of the Incarnates"] = "VotI"
TML["Aberrus, the Shadowed Crucible"] = "Abb"
TML["Amirdrassil, the Dream's Hope"] = "Amir"
TML["City of Threads"] = "CoT"
TML["The Dawnbreaker"] = "DB"
TML["The Stonevault"] = "SV"
TML["The Rookery"] = "ROOK"
TML["Cinderbrew Meadery"] = "CBM"
TML["Priory of the Sacred Flame"] = "PoSF"
TML["Ara-Kara, City of Echoes"] = "AK"
TML["Darkflame Cleft"] = "DFC"
TML["Operation: Floodgate"] = "FL"
TML["Liberation of Undermine"] = "LOU"
TML["Eco-Dome Al'dani"] = "EDA"

-- expansion abreviated Text
TML["Cataclysm"] = "CATA"
TML["Mists of Pandaria"] = "MoP"
TML["Warlords of Draenor"] = "WoD"
TML["Legion"] = "LEGN"
TML["Battle for Azeroth"] = "BFA"
TML["Shadowlands"] = "SL"
TML["Shadowlands Raids"] = "SL R"
TML["Dragonflight"] = "DF"
TML["Dragonflight Raids"] = "DF R"
TML["The War Within"] = "TWW"
TML["The War Within Raids"] = "TWW R"
TML["Season 1"] = "S1"
TML["Season 2"] = "S2"
TML["Season 3"] = "S3"
TML["Season 4"] = "S4"

-- Mage teleport/portal abreviated text
-- Alliance
TML["Stormwind"] = "SW"
TML["Ironforge"] = "IF"
TML["Darnassus"] = "DS"
TML["Exodar"] = "EX"
TML["Theramore"] = "TH"
TML["Stormshield"] = "SS"
TML["Boralus"] = "BO"

-- Horde
TML["Orgrimmar"] = "ORG"
TML["Undercity"] = "UC"
TML["Thunder Bluff"] = "TB"
TML["Silvermoon"] = "SM"
TML["Stonard"] = "STO"
TML["Warspear"] = "WS"
TML["Dazar'alor"] = "DAZ"

-- Shared
TML["Shattrath"] = "SH"
TML["Dalaran - Northrend"] = "D-N"
TML["Tol Barad"] = "TOL"
TML["Vale of Eternal Blossoms"] = "VALE"
TML["Dalaran - Broken Isles"] = "D-BI"
TML["Oribos"] = "ORI"
TML["Valdrakken"] = "VALD"
TML["Dalaran - Ancient"] = "D-AP"
TML["Hall of the Guardian"] = "HotG"
TML["Dornogal"] = "DG"

-- Options
TML["Opening Options Menu"] = "Opening Options Menu"
TML["Enabled"] = "Enabled"
TML["Enable Tooltip"] = "Enable/Disable the Teleport Menu."
TML["Hearthstone Toy"] = "Hearthstone Toy"
TML["Hearthstone Toy Tooltip"] = "Sets the preferred hearthstone toy to use.\n\nIf set to Random, a random hearthstone toy will be choosen every time you open the game menu."
TML["None"] = "None"
TML["Random"] = "Random"
TML["ButtonText"] = "Show Teleport Icon Text"
TML["ButtonText Tooltip"] = "When enabled, an abbreviated name of the dungeon will be added to dungeon teleports."
TML["Reverse Mage Flyouts"] = "Reverse Mage Flyouts"
TML["Reverse Mage Flyouts Tooltip"] = "Reverse order of flyouts for mage abilities to make most recent expansion teleports appear first"
TML["Seasonal Teleports"] = "Seasonal Teleports"
TML["Seasonal Teleports Tooltip"] = "\124cFF34B7EBThese Teleports are for the current Mythic Keystone Season.\124r"
TML["Seasonal Teleports Toggle Tooltip"] = "Enable/Disable to only show the Seasonal Teleports."
TML["Icon Size"] = "Icon Size"
TML["Icon Size Tooltip"] = "Increase or decrease the size of the icons."
TML["%s px"] = "%s px"
TML["Icons Per Flyout Row"] = "Icons Per Flyout Row"
TML["Icons Per Flyout Row Tooltip"] = "Set the maximum amount of flyout icons before a new row will be created."
TML["%s icons"] = "%s icons"
TML["Item Teleports"] = "Item Teleports"
TML["Item Teleports Tooltip"] = "\124cFF34B7EBAll items that have a teleport that are in your possession\124r\n\n\124cFFFF0000Items such as faction cloaks require clicking twice!\124r"
TML["Teleports:Items:Filters:Held_Items"] = "Items you have"
TML["Teleports:Items:Filters:Items_To_Be_Obtained"] = "Unavailable items"

-- Settings
TML["ADDON_NAME"] = "|cff33ff99[Cool]|rTeleport Menu"
TML["TITLE"] = "Teleport Menu Settings"
TML["GENERAL"] = "General Settings"
TML["BUTTON_SETTINGS"] = "Button Settings"
TML["TELEPORT_SETTINGS"] = "Teleport Settings"
TML["HEARTHSTONE_SETTINGS"] = "Hearthstone Settings"
TML["BUTTON_FONT_SIZE"] = "Button Font Size"
TML["BUTTON_FONT_SIZE_TOOLTIP"] = "Changing this setting controls the size of the abbreviated teleport names"
TML["Teleports:Items:Filters"] = "Item Filters"
TML["ABOUT_ADDON"] =
	"|CFFFFFFFFThis addon adds your available hearthstones and teleports to the game menu (esc). \n\nYou can change the hearthstone it uses by typing /tpm ingame and following the commands. \n\nIf there are issues or questions, or missing teleports/stones, feel free to contact me on Github.  \n\nSupported Items:\n\n Hearthstones\n Mage Teleports/Portals\n Engineering Wormholes\n Hero's Path teleports\n All class teleports (Zen Pilgramige, Death Gate, Astral Recall etc..)|r"
TML["ABOUT_CONTRIBUTORS"] = "Active Contributors: |CFFFFFFFF\n\n%s\n\n|r"

end

local tpm = {}

local push, sort = table.insert, sort

--- @alias Item { id: integer, name: string, icon: integer }
--- @class Player
--- @field items_in_possession Item[]
--- @field items_to_be_obtained Item[]
tpm.player = {
	items_in_possession = {},
	items_to_be_obtained = {},
}

--- @param item_id integer
function tpm:AddItemToPossession(item_id)
	for key, item in pairs(tpm.player.items_to_be_obtained) do
		if item.id == item_id then
			push(tpm.player.items_in_possession, item)
			if #tpm.player.items_in_possession > 1 then
				sort(tpm.player.items_in_possession, function(a, b)
					if not a or not b or not a.name or not b.name then
						return false
					end
					return a.name < b.name
				end)
			end

			tpm.player.items_to_be_obtained[key] = nil
			tpm.settings.scroll_box_views["items_to_be_obtained"]:SetDataProvider(CreateDataProvider(tpm.player.items_to_be_obtained))
			tpm.settings.scroll_box_views["items_in_possession"]:SetDataProvider(CreateDataProvider(tpm.player.items_in_possession))
			tpm:UpdateAvailableItemTeleports()
			tpm:ReloadFrames()
		end
	end
end

--- @param item_id integer
function tpm:RemoveItemFromPossession(item_id)
	for key, item in pairs(tpm.player.items_in_possession) do
		if item.id == item_id then
			push(tpm.player.items_to_be_obtained, item)
			if #tpm.player.items_to_be_obtained > 1 then
				sort(tpm.player.items_to_be_obtained, function(a, b)
					if not a or not b or not a.name or not b.name then
						return false
					end
					return a.name < b.name
				end)
			end

			tpm.player.items_in_possession[key] = nil
			tpm.settings.scroll_box_views["items_to_be_obtained"]:SetDataProvider(CreateDataProvider(tpm.player.items_to_be_obtained))
			tpm.settings.scroll_box_views["items_in_possession"]:SetDataProvider(CreateDataProvider(tpm.player.items_in_possession))
			tpm:UpdateAvailableItemTeleports()
			tpm:ReloadFrames()
		end
	end
end


AvailableHearthstones = {}
local covenantsMaxed = nil
local function GetCovenantData(id) -- the id is the achievement criteria index from Re-Re-Re-Renowned
	if covenantsMaxed then
		return covenantsMaxed[id]
	end
	covenantsMaxed = {}
	for i = 1, 4 do
		local _, _, completed = GetAchievementCriteriaInfo(15646, i)
		covenantsMaxed[i] = completed
	end
end

--- @type { [integer]: boolean|fun(): boolean|nil }
tpm.Hearthstones = {
	[54452] = true, -- Ethereal Portal
	[64488] = true, -- The Innkeeper's Daughter
	[93672] = true, -- Dark Portal
	[142542] = true, -- Tome of Town Portal
	[162973] = true, -- Greatfather Winter's Hearthstone
	[163045] = true, -- Headless Horseman's Hearthstone
	[163206] = true, -- Weary Spirit Binding
	[165669] = true, -- Lunar Elder's Hearthstone
	[165670] = true, -- Peddlefeet's Lovely Hearthstone
	[165802] = true, -- Noble Gardener's Hearthstone
	[166746] = true, -- Fire Eater's Hearthstone
	[166747] = true, -- Brewfest Reveler's Hearthstone
	[168907] = true, -- Holographic Digitalization Hearthstone
	[172179] = true, -- Eternal Traveler's Hearthstone
	[180290] = function()
		-- Night Fae Hearthstone
		if GetCovenantData(3) then
			return true
		end
		local covenantID = C_Covenants.GetActiveCovenantID()
		if covenantID == 3 then
			return true
		end
	end,
	[182773] = function()
		-- Necrolord Hearthstone
		if GetCovenantData(2) then
			return true
		end
		local covenantID = C_Covenants.GetActiveCovenantID()
		if covenantID == 4 then
			return true
		end
	end,
	[183716] = function()
		-- Venthyr Sinstone
		if GetCovenantData(4) then
			return true
		end
		local covenantID = C_Covenants.GetActiveCovenantID()
		if covenantID == 2 then
			return true
		end
	end,
	[184353] = function()
		-- Kyrian Hearthstone
		if GetCovenantData(1) then
			return true
		end
		local covenantID = C_Covenants.GetActiveCovenantID()
		if covenantID == 1 then
			return true
		end
	end,
	[188952] = true, -- Dominated Hearthstone
	[190196] = true, -- Enlightened Hearthstone
	[190237] = true, -- Broker Translocation Matrix
	[193588] = true, -- Timewalker's Hearthstone
	[200630] = true, -- Ohnir Windsage's Hearthstone
	[206195] = true, -- Path of the Naaru
	[208704] = true, -- Deepdweller's Earthen Hearthstone
	[209035] = true, -- Hearthstone of the Flame
	[210455] = function()
		-- Draenic Hologem (Draenei and Lightforged Draenei only)
		local _, _, raceId = UnitRace("player")
		if raceId == 11 or raceId == 30 then
			return true
		end
	end,
	[212337] = true, -- Stone of the Hearth
	[228940] = true, -- Notorious Thread's Hearthstone
	[236687] = true, -- Explosive Hearthstone
	[235016] = true, -- Redeployment Module
}

function tpm:GetAvailableHearthstoneToys()
	local hearthstoneNames = {}
	for _, toyId in pairs(AvailableHearthstones) do
		--- @type unknown, string, string | integer
		local _, name, texture = C_ToyBox.GetToyInfo(toyId)
		if not texture then
			texture = "Interface\\Icons\\inv_hearthstonepet"
		end
		if not name then
			name = tostring(toyId)
		end
		hearthstoneNames[toyId] = { name = name, texture = texture }
	end
	return hearthstoneNames
end

function tpm:UpdateAvailableHearthstones()
	AvailableHearthstones = {}
	for id, usable in pairs(tpm.Hearthstones) do
		if PlayerHasToy(id) then
			if type(usable) == "function" and usable() then
				table.insert(AvailableHearthstones, id)
			elseif usable == true then
				table.insert(AvailableHearthstones, id)
			end
		end
	end
	tpm.AvailableHearthstones = AvailableHearthstones
end

do
	local lastRandomHearthstone = nil
	function tpm:GetRandomHearthstone(retry)
		if #tpm.AvailableHearthstones == 0 then
			return
		end
		if #tpm.AvailableHearthstones == 1 then
			return tpm.AvailableHearthstones[1]
		end -- Don't even bother
		local randomHs = tpm.AvailableHearthstones[math.random(#tpm.AvailableHearthstones)]
		if lastRandomHearthstone == randomHs then -- Don't fully randomize, always a new one
			randomHs = self:GetRandomHearthstone(true) --[[@as integer]]
		end
		if not retry then
			lastRandomHearthstone = randomHs
		end
		return randomHs
	end
end


--- @type { [integer]: boolean }
tpm.ItemTeleports = {
	-- Kirin Tor rings
	-- Slight note on these, it is technically possible to have ALL of them, but that'd cost too much inventory space if you ask me.
	[32757] = true, -- Blessed Medallion of Karabor
	[37863] = true, -- Direbrew's Remote
	[40586] = true, -- Band of the Kirin Tor
	[44935] = true, -- Ring of the Kirin Tor
	[40585] = true, -- Signet of the Kirin Tor
	[44934] = true, -- Loop of the Kirin Tor
	[45688] = true, -- Inscribed Band of the Kirin Tor
	[45690] = true, -- Inscribed Ring of the Kirin Tor
	[45691] = true, -- Inscibed Signet of the Kirin Tor
	[45689] = true, -- Inscribed Loop of the Kirin Tor
	[48954] = true, -- Etched Band of the Kirin Tor
	[48955] = true, -- Etched Loop of the Kirin Tor
	[48956] = true, -- Etched Ring of the Kirin Tor
	[48957] = true, -- Etched Signet of the Kirin Tor
	[51557] = true, -- Runed Signet of the Kirin Tor
	[51558] = true, -- Runed Loop of the Kirin Tor
	[51559] = true, -- Runed Ring of the Kirin Tor
	[51560] = true, -- Runed Band of the Kirin Tor
	[52251] = true, -- Jaina's Locket
	-- Faction Cloaks
	[63206] = UnitFactionGroup("player") == "Alliance", -- Wrap of Unity: Stormwind
	[63207] = UnitFactionGroup("player") == "Horde", -- Wrap of Unity: Orgrimmar
	[63352] = UnitFactionGroup("player") == "Alliance", -- Shroud of Cooperation: Stormwind
	[63353] = UnitFactionGroup("player") == "Horde", -- Shroud of Cooperation: Orgrimmar
	[65274] = UnitFactionGroup("player") == "Horde", -- Cloak of Coordination: Orgrimmar
	[65360] = UnitFactionGroup("player") == "Alliance", -- Cloak of Coordination: Stormwind
	-- Other items
	[46874] = true, -- Argent Crusader's Tabard
	[50287] = true, -- Boots of the Bay
	[58487] = true, -- Potion of Deepholm
	[61379] = true, -- Gidwin's Hearthstone
	[63378] = true, -- Hellscream's Reach Tabard
	[63379] = true, -- Baradin's Wardens Tabard
	[64457] = true, -- The Last Relic of Argus
	[68808] = true, -- Hero's Hearthstone
	[68809] = true, -- Veteran's Hearthstone
	[87548] = true, -- Lorewalker's Lodestone
	[92510] = true, -- Vol'jin's Hearthstone
	[95050] = UnitFactionGroup("player") == "Horde", -- The Brassiest Knuckle (Brawl'gar Arena)
	[95051] = UnitFactionGroup("player") == "Alliance", -- The Brassiest Knuckle (Bizmo's Brawlpub)
	[95567] = UnitFactionGroup("player") == "Alliance", -- Kirin Tor Beacon
	[95568] = UnitFactionGroup("player") == "Horde", -- Sunreaver Beacon
	[103678] = true, -- Time-Lost Artifact
	[117389] = true, -- Draenor Archaeologist's Lodestone
	[118662] = true, -- Bladespire Relic
	[118663] = true, -- Relic of Karabor
	[118907] = UnitFactionGroup("player") == "Alliance", -- Pit Fighter's Punching Ring (Bizmo's Brawlpub)
	[118908] = UnitFactionGroup("player") == "Horde", -- Pit Fighter's Punching Ring (Brawl'gar Arena)
	[119183] = true, -- Scroll of Risky Recall
	[128353] = true, -- Admiral's Compass
	[128502] = true, -- Hunter's Seeking Crystal
	[128503] = true, -- Master Hunter's Seeking Crystal
	[129276] = true, -- Beginner's Guide to Dimensional Rifting
	[132119] = UnitFactionGroup("player") == "Horde", -- Orgrimmar Portal Stone
	[132120] = UnitFactionGroup("player") == "Alliance", -- Stormwind Portal Stone
	[132517] = true, -- Intra-Dalaran Wormhole Generator
	[132523] = true, -- Reaves Battery
	[138448] = true, -- Emblem of Margoss
	[139590] = true, -- Scroll of Teleport: Ravenholdt
	[139599] = true, -- Empowered Ring of the Kirin Tor
	[140493] = true, -- Adept's Guide to Dimensional Rifting
	[141013] = true, -- Scroll of Town Portal: Shala'nir
	[141014] = true, -- Scroll of Town Portal: Sashj'tar
	[141015] = true, -- Scroll of Town Portal: Kal'delar
	[141016] = true, -- Scroll of Town Portal: Faronaar
	[141017] = true, -- Scroll of Town Portal: Lian'tril
	[141324] = true, -- Talisman of the Shal'dorei
	[141605] = true, -- Flight Master's Whistle
	[142298] = true, -- Astonishingly Scarlet Slippers
	[142469] = true, -- Violet Seal of the Grand Magus
	[142543] = true, -- Scroll of Town Portal (Diablo 3 event)
	[144341] = true, -- Rechargeable Reaves Battery
	[144391] = UnitFactionGroup("player") == "Alliance", -- Pugilist's Powerful Punching Ring (Alliance)
	[144392] = UnitFactionGroup("player") == "Horde", -- Pugilist's Powerful Punching Ring (Horde)
	[150733] = true, -- Scroll of Town Portal (Ar'gorok in Arathi)
	[151016] = true, -- Fractured Necrolyte Skull
	[159224] = true, -- Zuldazar Hearthstone
	[160219] = true, -- Scroll of Town Portal (Stromgarde in Arathi)
	[163694] = true, -- Scroll of Luxurious Recall
	[166559] = true, -- Commander's Signet of Battle
	[166560] = true, -- Captain's Signet of Command
	[167075] = true, -- Ultrasafe Transporter: Mechagon
	[168862] = true, -- G.E.A.R. Tracking Beacon
	[169064] = true, -- Montebank's Colorful Cloak
	[169297] = UnitFactionGroup("player") == "Alliance", -- Stormpike Insignia
	[172203] = true, -- Cracked Hearthstone
	[173373] = true, -- Faol's Hearthstone
	[173430] = true, -- Nexus Teleport Scroll
	[173528] = true, -- Gilded Hearthstone
	[173532] = true, -- Tirisfal Camp Scroll
	[173537] = true, -- Glowing Hearthstone
	[173716] = true, -- Mossy Hearthstone
	[180817] = true, -- Cypher of Relocation (Ve'nari's Refuge)
	[181163] = true, -- Scroll of Teleport: Theater of Pain
	[184500] = true, -- Attendant's Pocket Portal: Bastion
	[184501] = true, -- Attendant's Pocket Portal: Revendreth
	[184502] = true, -- Attendant's Pocket Portal: Maldraxxus
	[184503] = true, -- Attendant's Pocket Portal: Ardenweald
	[184504] = true, -- Attendant's Pocket Portal: Oribos
	[189827] = true, -- Cartel Xy's Proof of Initiation
	[191029] = true, -- Lilian's Hearthstone
	[193000] = true, -- Ring-Bound Hourglass
	[200613] = true, -- Aylaag Windstone Fragment
	[201957] = true, -- Thrall's Hearthstone
	[202046] = true, -- Lucky Tortollan Charm
	[204481] = true, -- Morqut Hearth Totem
	[205255] = true, -- Niffen Diggin' Mitts
	[205456] = true, -- Lost Dragonscale (1)
	[205458] = true, -- Lost Dragonscale (2)
	[211788] = UnitRace("player") == "Worgen", -- Tess's Peacebloom
	[230850] = true, -- Delve-O-Bot 7001
	[234389] = true, -- Gallagio Loyalty Rewards Card: Silver
	[234390] = true, -- Gallagio Loyalty Rewards Card: Gold
	[234391] = true, -- Gallagio Loyalty Rewards Card: Platinum
	[234392] = true, -- Gallagio Loyalty Rewards Card: Black
	[234393] = true, -- Gallagio Loyalty Rewards Card: Diamond
	[234394] = true, -- Gallagio Loyalty Rewards Card: Legendary
	[156833] = true,		-- 邮箱凯蒂
	[40768] = true,			-- 邮箱工程
	[49040] = true,			-- 基维斯
	[144341] = true, 		-- 里弗斯
	[83958] = true,			-- 工会银行
	[460905] = true,		-- 战团银行
	[259930] = true,		-- 光德的圣光熔炉
}

function tpm:GetAvailableItemTeleports()
	return tpm.AvailableItemTeleports
end

local cachedToys = {}
function tpm:IsToyTeleport(id)
	return cachedToys[id] or false
end

function tpm:UpdateAvailableItemTeleports()
	local AvailableItemTeleports = {}

	for id, _ in pairs(tpm.ItemTeleports) do
		local hasItem = (C_Item.GetItemCount(id) or 0) > 0
		local isToy = select(1, C_ToyBox.GetToyInfo(id)) ~= nil
		local usableToy = isToy and PlayerHasToy(id)
		if (hasItem or usableToy) and TeleportMenuDB[id] == true then
			cachedToys[id] = isToy
			table.insert(AvailableItemTeleports, id)
		end
	end
	tpm.AvailableItemTeleports = AvailableItemTeleports
end

local push = table.insert

--- @type { [integer]: boolean }
tpm.Wormholes = {
	[30542] = true, -- Dimensional Ripper - Area 52
	[18984] = true, -- Dimensional Ripper - Everlook
	[18986] = true, -- Ultrasafe Transporter: Gadgetzan
	[30544] = true, -- Ultrasafe Transporter: Toshley's Station
	[48933] = true, -- Wormhole Generator: Northrend
	[87215] = true, -- Wormhole Generator: Pandaria
	[112059] = true, -- Wormhole Centrifuge (Dreanor) 6
	[151652] = true, -- Wormhole Generator: Argus
	[168807] = true, -- Wormhole Generator: Kul Tiras 5
	[168808] = true, -- Wormhole Generator: Zandalar
	[172924] = true, -- Wormhole Generator: Shadowlands 3
	[198156] = true, -- Wyrmhole Generator: Dragon Isles 4
	[221966] = true, -- Wormhole Generator: Khaz Algar
}

function tpm:UpdateAvailableWormholes()
	local availableWormholes = {}
	for id, _ in pairs(tpm.Wormholes) do
		if PlayerHasToy(id) then
			push(availableWormholes, id)
		end
	end

	tpm.AvailableWormholes = availableWormholes
	tpm.AvailableWormholes.GetUsable = function()
		if #tpm.AvailableWormholes == 0 then
			return {}
		end

		local usableWormholes = {}
		for _, wormholeId in ipairs(availableWormholes) do
			if C_ToyBox.IsToyUsable(wormholeId) then
				table.insert(usableWormholes, wormholeId)
			end
		end
		return usableWormholes
	end
end

local GetItemCount, GetItemNameByID, GetItemIconByID, sort, push = C_Item.GetItemCount, C_Item.GetItemNameByID, C_Item.GetItemIconByID, sort, table.insert

--- @type { [string|integer]: boolean|string|integer }
tpm.SettingsBase = {
	["Enabled"] = true,
	["Teleports:Seasonal:Only"] = false,
	["Teleports:Mage:Reverse"] = false,
	["Teleports:Hearthstone"] = "rng",
	["Button:Size"] = 36,
	["Button:Text:Size"] = 12,
	["Button:Text:Show"] = true,
	["Flyout:Max_Per_Row"] = 12,
}

tpm.settings = {
	scroll_box_views = {
		items_in_possession_view = nil,
		items_to_be_obtained = nil,
	},
	current_season = 1,
}

local function pack(...)
	local num = select("#", ...)
	return setmetatable({ ... }, {
		__len = function()
			return num
		end,
	})
end

local function merge(...)
	local all_teleports = {}
	local arg = pack(...)
	for i = 1, #arg do
		for k, v in pairs(arg[i]) do
			if all_teleports[k] then
				error("\n\n" .. TML["AddonNamePrint"] .. "Duplicate key found\n\124cFF34B7EBKey:\124r " .. k .. "\n")
			end
			all_teleports[k] = v
		end
	end
	return all_teleports
end

function tpm:SourceItemTeleportScrollBoxes(onSourceComplete)
	local ContinuableContainer = ContinuableContainer:Create()
	local items_in_possession, items_to_be_obtained = tpm.player.items_in_possession, tpm.player.items_to_be_obtained
	for id, _ in pairs(tpm.ItemTeleports) do
		local item = Item:CreateFromItemID(id)
		ContinuableContainer:AddContinuable(item)
	end

	ContinuableContainer:ContinueOnLoad(function()
		for id, _ in pairs(tpm.ItemTeleports) do
			local items = (GetItemCount(id) > 0 and items_in_possession) or items_to_be_obtained
			push(items, {
				id = id,
				name = GetItemNameByID(id),
				icon = GetItemIconByID(id),
			})

			if #items > 1 then
				sort(items, function(a, b)
					return a.name < b.name
				end)
			end
		end
	end)

	if onSourceComplete then
		onSourceComplete()
	end
end

tpm.SettingsBase = setmetatable(tpm.SettingsBase, {
	__index = merge(tpm.ItemTeleports, tpm.Wormholes, tpm.Hearthstones),
})


-------------------------------------
-- Locales
--------------------------------------

function tpm:ConvertOldSettings()
	if not TeleportMenuDB then return end

	local mappedKeysToNewFormat = {
		enabled = "Enabled",
		debug = "Developers:Debug_Mode:Enabled",
		iconSize = "Button:Size",
		hearthstone = "Teleports:Hearthstone",
		buttonText = "Button:Text:Show",
		maxFlyoutIcons = "Flyout:Max_Per_Row",
		reverseMageFlyouts = "Teleports:Mage:Reverse",
		showOnlySeasonalHerosPath = "Teleports:Seasonal:Only"
	}

	for oldKey, newKey in pairs(mappedKeysToNewFormat) do
		if TeleportMenuDB[oldKey] ~= nil then
			TeleportMenuDB[newKey] = TeleportMenuDB[oldKey]
			TeleportMenuDB[oldKey] = nil
		end
	end

	TeleportMenuDB = setmetatable(TeleportMenuDB, {
		__index = tpm.SettingsBase
	})
end

-- Get all options and verify them
local RawSettings
function tpm:GetOptions()
	if not TeleportMenuDB then TeleportMenuDB = {} end
	tpm:ConvertOldSettings()
	RawSettings = TeleportMenuDB
	return RawSettings
end

local function OnSettingChanged(_, setting, value)
	local variable = setting:GetVariable()
	TeleportMenuDB[variable] = value
	tpm:ReloadFrames()
end

local root = CreateFrame("Frame", ADDON_NAME, InterfaceOptionsFramePanelContainer)
root.title = root:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
root.title:SetPoint("TOPLEFT", 7, -22)
root.title:SetText(TML["ADDON_NAME"])
root.divider = root:CreateTexture(nil, "ARTWORK")
root.divider:SetAtlas("Options_HorizontalDivider", true)
root.divider:SetPoint("TOP", 0, -50)
root.logo = root:CreateTexture(nil, "ARTWORK")
root.logo:SetPoint("TOPRIGHT", root, "TOPRIGHT", -8, -14)
root.logo:SetTexture("Interface\\Icons\\inv_hearthstonepet")
root.logo:SetSize(30, 30)
root.logo:Show()

local rootCategory = Settings.RegisterCanvasLayoutCategory(root, TML["ADDON_NAME"])
local generalOptions = Settings.RegisterVerticalLayoutSubcategory(rootCategory, TML["GENERAL"])
local buttonOptions = Settings.RegisterVerticalLayoutSubcategory(rootCategory, TML["BUTTON_SETTINGS"])
local teleportsOptions = Settings.RegisterVerticalLayoutSubcategory(rootCategory, TML["TELEPORT_SETTINGS"])
local teleportFiltersFrame = CreateFrame("Frame", "TeleportFiltersFramePanel", InterfaceOptionsFramePanelContainer)
teleportFiltersFrame.title = teleportFiltersFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
teleportFiltersFrame.title:SetPoint("TOPLEFT", 7, -22)
teleportFiltersFrame.title:SetText(TML["Teleports:Items:Filters"])
teleportFiltersFrame.divider = teleportFiltersFrame:CreateTexture(nil, "ARTWORK")
teleportFiltersFrame.divider:SetAtlas("Options_HorizontalDivider", true)
teleportFiltersFrame.divider:SetPoint("TOP", 0, -50)

local teleportFilters = Settings.RegisterCanvasLayoutSubcategory(teleportsOptions, teleportFiltersFrame, TML["Teleports:Items:Filters"])
function tpm:GetOptionsCategory(category)
	if not category or category == "root" then
		return rootCategory:GetID()
	elseif category == "filters" then
		return teleportFilters:GetID()
	end
end

function tpm:LoadOptions()
	local db = tpm:GetOptions()
	local defaults = tpm.SettingsBase
	local ACTIVE_CONTRIBUTORS = { "Creator: Justw8", "Contributor(s): Mythi" }

	do -- Settings Landing Page
		local text = root:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		text:SetJustifyH("LEFT")
		text:SetText(TML["ABOUT_ADDON"])
		text:SetWidth(640)
		text:SetPoint("TOPLEFT", root.divider, "BOTTOMLEFT", 0, -20)
		text:Show()

		local contributors = root:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		contributors:SetJustifyH("LEFT")
		contributors:SetText(TML["ABOUT_CONTRIBUTORS"]:format(table.concat(ACTIVE_CONTRIBUTORS, "\n")))
		contributors:SetWidth(640)
		contributors:SetPoint("BOTTOMLEFT", root, 12, 20)
	end

	do
		local optionsKey = "Enabled"
		local tooltip = TML["Enable Tooltip"]
		local setting = Settings.RegisterAddOnSetting(generalOptions, optionsKey, optionsKey, db, type(defaults[optionsKey]), TML["Enabled"], defaults[optionsKey])
		Settings.SetOnValueChangedCallback(optionsKey, OnSettingChanged)
		Settings.CreateCheckbox(generalOptions, setting, tooltip)
	end

	do
		local optionsKey = "Teleports:Hearthstone"
		local tooltip = TML["Hearthstone Toy Tooltip"]

		local function GetOptions()
			local container = Settings.CreateControlTextContainer()
			container:Add("none", TML["None"])
			container:Add("rng", "|T1669494:16:16:0:0:64:64:4:60:4:60|t " .. TML["Random"])
			local hearthstones = tpm:GetAvailableHearthstoneToys()
			for id, hearthstoneInfo in pairs(hearthstones) do
				container:Add(tostring(id), "|T" .. hearthstoneInfo.texture .. ":16:16:0:0:64:64:4:60:4:60|t " .. hearthstoneInfo.name)
			end
			return container:GetData()
		end

		local setting = Settings.RegisterAddOnSetting(teleportsOptions, optionsKey, optionsKey, db, type(defaults[optionsKey]), TML["Hearthstone Toy"], defaults[optionsKey])
		Settings.CreateDropdown(teleportsOptions, setting, GetOptions, tooltip)
		Settings.SetOnValueChangedCallback(optionsKey, OnSettingChanged)
	end

	do -- ButtonText  Checkbox
		local optionsKey = "Button:Text:Show"
		local buttonText = TML["ButtonText Tooltip"]
		local setting = Settings.RegisterAddOnSetting(buttonOptions, optionsKey, optionsKey, db, type(defaults[optionsKey]), TML["ButtonText"], defaults[optionsKey])
		Settings.SetOnValueChangedCallback(optionsKey, OnSettingChanged)
		Settings.CreateCheckbox(buttonOptions, setting, buttonText)
	end

	do -- Font Size Slider
		local optionsKey = "Button:Text:Size"
		local text = TML["BUTTON_FONT_SIZE"]
		local tooltip = TML["BUTTON_FONT_SIZE_TOOLTIP"]
		local options = Settings.CreateSliderOptions(6, 40, 1)
		local label = TML["%s px"]

		local function GetValue()
			return TeleportMenuDB[optionsKey] or defaults[optionsKey]
		end

		local function SetValue(value)
			TeleportMenuDB[optionsKey] = value
			tpm:ReloadFrames()
		end

		local setting = Settings.RegisterProxySetting(buttonOptions, optionsKey, type(defaults[optionsKey]), text, defaults[optionsKey], GetValue, SetValue)

		local function Formatter(value)
			return label:format(value)
		end
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, Formatter)

		Settings.CreateSlider(buttonOptions, setting, options, tooltip)
	end

	do -- Icon Size Slider
		local optionsKey = "Button:Size"
		local text = TML["Icon Size"]
		local tooltip = TML["Icon Size Tooltip"]
		local options = Settings.CreateSliderOptions(10, 75, 1)
		local label = TML["%s px"]

		local function GetValue()
			return TeleportMenuDB[optionsKey] or defaults[optionsKey]
		end

		local function SetValue(value)
			TeleportMenuDB[optionsKey] = value
			tpm:ReloadFrames()
		end

		local setting = Settings.RegisterProxySetting(buttonOptions, optionsKey, type(defaults[optionsKey]), text, defaults[optionsKey], GetValue, SetValue)

		local function Formatter(value)
			return label:format(value)
		end
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, Formatter)

		Settings.CreateSlider(buttonOptions, setting, options, tooltip)
	end

	do -- Max Flyout Icons
		local optionsKey = "Flyout:Max_Per_Row"
		local text = TML["Icons Per Flyout Row"]
		local tooltip = TML["Icons Per Flyout Row Tooltip"]
		local options = Settings.CreateSliderOptions(1, 20, 1)
		local label = TML["%s icons"]

		local function GetValue()
			return TeleportMenuDB[optionsKey] or defaults[optionsKey]
		end

		local function SetValue(value)
			TeleportMenuDB[optionsKey] = value
			tpm:ReloadFrames()
		end

		local setting = Settings.RegisterProxySetting(buttonOptions, optionsKey, type(defaults[optionsKey]), text, defaults[optionsKey], GetValue, SetValue)

		local function Formatter(value)
			return label:format(value)
		end
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, Formatter)

		Settings.CreateSlider(buttonOptions, setting, options, tooltip)
	end

	do -- Reverse the mage teleport flyouts
		local optionsKey = "Teleports:Mage:Reverse"
		local tooltip = TML["Reverse Mage Flyouts Tooltip"]
		local setting = Settings.RegisterAddOnSetting(generalOptions, optionsKey, optionsKey, db, type(defaults[optionsKey]), TML["Reverse Mage Flyouts"], defaults[optionsKey])
		Settings.SetOnValueChangedCallback(optionsKey, OnSettingChanged)
		Settings.CreateCheckbox(generalOptions, setting, tooltip)
	end

	do -- Seasonal Teleports Only
		local optionsKey = "Teleports:Seasonal:Only"
		local tooltip = TML["Seasonal Teleports Toggle Tooltip"]
		local setting =
			Settings.RegisterAddOnSetting(generalOptions, optionsKey, optionsKey, db, type(defaults[optionsKey]), TML["Seasonal Teleports"], defaults[optionsKey])
		Settings.SetOnValueChangedCallback(optionsKey, OnSettingChanged)
		Settings.CreateCheckbox(generalOptions, setting, tooltip)
	end

	do
		local loader = CreateFrame("Frame", nil, teleportFiltersFrame, "SpinnerTemplate")
		loader:SetWidth(100)
		loader:SetHeight(100)
		loader:SetPoint("CENTER")
		loader.text = loader:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge4")
		loader.text:SetText(string.upper(TML["Common:Loading"]))
		loader.text:SetPoint("BOTTOM", loader, "TOP", 0, 10)

		local container = CreateFrame("Frame", nil, teleportFiltersFrame)
		container:SetPoint("TOPLEFT", teleportFiltersFrame.divider, "BOTTOMLEFT", 0, -4)
		container:SetPoint("BOTTOMRIGHT", teleportFiltersFrame, nil, -4, 0)
		container:Hide()

		tpm:SourceItemTeleportScrollBoxes(function()
			loader:Hide()
			container:Show()
		end)

		local function SetItemIcon(frame)
			frame.ItemIcon = frame:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
			frame.ItemIcon:SetSize(15, 15)
			frame.ItemIcon:SetPoint("TOPLEFT", 23, -2.5)
		end

		local function SetEnabledIndicator(frame)
			frame.EnabledIndicator = frame:CreateTexture()
			frame.EnabledIndicator:SetSize(15, 15)
			frame.EnabledIndicator:SetPoint("TOPLEFT", 4, -2.5)
		end

		local function InitializeScrollBoxElement(frame, elementData)
			local function SetValue(value)
				TeleportMenuDB[elementData.id] = value
				tpm:UpdateAvailableItemTeleports()
				tpm:ReloadFrames()
			end
			if not frame.ItemIcon then
				SetItemIcon(frame)
				SetEnabledIndicator(frame)
			end

			if elementData.icon and elementData.icon ~= nil then
				frame.ItemIcon:SetText("|T" .. elementData.icon .. ":13:13|t ")
			else
				frame.ItemIcon:SetText("")
			end

			frame:SetPushedTextOffset(0, 0)
			frame:SetHighlightAtlas("search-highlight")
			frame:SetNormalFontObject(GameFontHighlight)
			frame.fullName = elementData.name
			frame:SetText(frame.fullName)

			frame:GetFontString():SetTextColor(1, 1, 1, 1)
			frame:GetFontString():SetPoint("LEFT", 42, 0)
			frame:GetFontString():SetPoint("RIGHT", -20, 0)
			frame:GetFontString():SetJustifyH("LEFT")
			frame:SetScript("OnClick", function()
				if db[elementData.id] == true then
					SetValue(false)
				else
					SetValue(true)
				end
				frame.UpdateVisual()
			end)
			frame:SetScript("OnEnter", function(s)
				GameTooltip:SetOwner(s, "ANCHOR_CURSOR")
				GameTooltip:SetItemByID(elementData.id)
			end)
			frame:SetScript("OnLeave", function()
				GameTooltip:Hide()
			end)
			frame.UpdateVisual = function()
				if db[elementData.id] == true then
					frame.EnabledIndicator:SetAtlas("common-icon-checkmark-yellow")
				else
					frame.EnabledIndicator:SetAtlas("common-icon-redx")
				end
			end
			frame:UpdateVisual()
		end

		local function CreateScrollBox(parent, items_key, title)
			local ScrollBoxContainer = CreateFrame("Frame", nil, parent)

			local ScrollBoxTitle = ScrollBoxContainer:CreateFontString(nil, "ARTWORK", "GameFontHighlightMedium")
			ScrollBoxTitle:SetPoint("TOPLEFT", ScrollBoxContainer, 2, -8)
			ScrollBoxTitle:SetText(title)

			local ScrollBar = CreateFrame("EventFrame", nil, ScrollBoxContainer, "MinimalScrollBar")
			ScrollBar:SetPoint("TOPRIGHT", ScrollBoxContainer, -10, -12)
			ScrollBar:SetPoint("BOTTOMRIGHT", ScrollBoxContainer, -10, 5)

			local ScrollBox = CreateFrame("Frame", nil, ScrollBoxContainer, "WowScrollBoxList")
			ScrollBox:SetPoint("TOPLEFT", ScrollBoxTitle, "BOTTOMLEFT", -8, -4)
			ScrollBox:SetPoint("BOTTOMRIGHT", ScrollBar, "BOTTOMRIGHT", -3, 0)

			local view = CreateScrollBoxListLinearView()
			view:SetElementExtent(20)
			view:SetElementInitializer("Button", InitializeScrollBoxElement)
			ScrollUtil.InitScrollBoxListWithScrollBar(ScrollBox, ScrollBar, view)

			ScrollBoxContainer:SetScript("OnShow", function()
				ScrollBox:SetDataProvider(CreateDataProvider(tpm.player[items_key]))
			end)

			tpm.settings.scroll_box_views[items_key] = view

			return ScrollBoxContainer
		end

		local HeldItemsScrollBoxContainer = CreateScrollBox(container, "items_in_possession", TML["Teleports:Items:Filters:Held_Items"])
		HeldItemsScrollBoxContainer:SetPoint("TOPLEFT", container)
		HeldItemsScrollBoxContainer:SetPoint("BOTTOMRIGHT", container, "BOTTOM")

		local ItemsToBeObtainedScrollBoxContainer = CreateScrollBox(container, "items_to_be_obtained", TML["Teleports:Items:Filters:Items_To_Be_Obtained"])
		ItemsToBeObtainedScrollBoxContainer:SetPoint("TOPLEFT", HeldItemsScrollBoxContainer, "TOPRIGHT")
		ItemsToBeObtainedScrollBoxContainer:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT")
	end


	Settings.RegisterAddOnCategory(rootCategory)
	Settings.RegisterAddOnCategory(generalOptions)
	Settings.RegisterAddOnCategory(buttonOptions)
	Settings.RegisterAddOnCategory(teleportsOptions)
	Settings.RegisterAddOnCategory(teleportFilters)
end

--------------------------------------
-- Locales
--------------------------------------

local db = {}
local APPEND = TML["AddonNamePrint"]
local DEFAULT_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"
local globalWidth, globalHeight = 40, 40 -- defaults

--------------------------------------
-- Teleport Tables
--------------------------------------

local availableSeasonalTeleports = {}

local shortNames = {
	-- CATA
	[410080] = TML["The Vortex Pinnacle"],
	[424142] = TML["Throne of the Tides"],
	[445424] = TML["Grim Batol"],
	-- MoP
	[131204] = TML["Temple of the Jade Serpentl"],
	[131205] = TML["Stormstout Brewery"],
	[131206] = TML["Shado-Pan Monastery"],
	[131222] = TML["Mogu'shan Palace"],
	[131225] = TML["Gate of the Setting Sun"],
	[131228] = TML["Siege of Niuzao Temple"],
	[131229] = TML["Scarlet Monastery"],
	[131231] = TML["Scarlet Halls"],
	[131232] = TML["Scholomance"],
	-- WoD
	[159901] = TML["The Everblooml"],
	[159899] = TML["Shadowmoon Burial Grounds"],
	[159900] = TML["Grimrail Depot"],
	[159896] = TML["Iron Docks"],
	[159895] = TML["Bloodmaul Slag Mines"],
	[159897] = TML["Auchindoun"],
	[159898] = TML["Skyreach"],
	[159902] = TML["Upper Blackrock Spire"],
	-- Legion
	[393764] = TML["Halls of Valor"],
	[410078] = TML["Neltharion's Lair"],
	[393766] = TML["Court of Stars"],
	[373262] = TML["Karazhan"],
	[424153] = TML["Black Rook Hold"],
	[424163] = TML["Darkheart Thicket"],
	-- BFA
	[410071] = TML["Freehold"],
	[410074] = TML["The Underrot"],
	[373274] = TML["Mechagon"],
	[424167] = TML["Waycrest Manor"],
	[424187] = TML["Atal'Dazar"],
	[445418] = TML["Siege of Boralus"],
	[464256] = TML["Siege of Boralus"],
	[467553] = TML["The MOTHERLODE!!"],
	[467555] = TML["The MOTHERLODE!!"],
	-- SL
	[354462] = TML["The Necrotic Wake"],
	[354463] = TML["Plaguefall"],
	[354464] = TML["Mists of Tirna Scithe"],
	[354465] = TML["Halls of Atonement"],
	[354466] = TML["Bastion"],
	[354467] = TML["Theater of Pain"],
	[354468] = TML["De Other Side"],
	[354469] = TML["Sanguine Depths"],
	[367416] = TML["Tazavesh, the Veiled Market"],
	-- SL R
	[373190] = TML["Castle Nathria"],
	[373191] = TML["Sanctum of Domination"],
	[373192] = TML["Sepulcher of the First Ones"],
	-- DF
	[393256] = TML["Ruby Life Pools"],
	[393262] = TML["The Nokhud Offensive"],
	[393267] = TML["Brackenhide Hollow"],
	[393273] = TML["Algeth'ar Academy"],
	[393276] = TML["Neltharus"],
	[393279] = TML["The Azure Vault"],
	[393283] = TML["Halls of Infusion"],
	[393222] = TML["Uldaman"],
	[424197] = TML["Dawn of the Infinite"],
	-- DF R
	[432254] = TML["Vault of the Incarnates"],
	[432257] = TML["Aberrus, the Shadowed Crucible"],
	[432258] = TML["Amirdrassil, the Dream's Hope"],
	-- TWW
	[445416] = TML["City of Threads"],
	[445414] = TML["The Dawnbreaker"],
	[445269] = TML["The Stonevault"],
	[445443] = TML["The Rookery"],
	[445440] = TML["Cinderbrew Meadery"],
	[445444] = TML["Priory of the Sacred Flame"],
	[445417] = TML["Ara-Kara, City of Echoes"],
	[445441] = TML["Darkflame Cleft"],
	[1216786] = TML["Operation: Floodgate"],
	[1237215] = TML["Eco-Dome Al'dani"],
	-- TWW R
	[1226482] = TML["Liberation of Undermine"],
	-- Mage teleports
	[3561] = TML["Stormwind"],
	[3562] = TML["Ironforge"],
	[3563] = TML["Undercity"],
	[3565] = TML["Darnassus"],
	[3566] = TML["Thunder Bluff"],
	[3567] = TML["Orgrimmar"],
	[32271] = TML["Exodar"],
	[32272] = TML["Silvermoon"],
	[33690] = TML["Shattrath"],
	[35715] = TML["Shattrath"],
	[49358] = TML["Stonard"],
	[49359] = TML["Theramore"],
	[53140] = TML["Dalaran - Northrend"],
	[88342] = TML["Tol Barad"], -- Alliance
	[88344] = TML["Tol Barad"], -- Horde
	[120145] = TML["Dalaran - Ancient"],
	[132621] = TML["Vale of Eternal Blossoms"], -- Alliance
	[132627] = TML["Vale of Eternal Blossoms"], -- Horde
	[176242] = TML["Warspear"],
	[176248] = TML["Stormshield"],
	[193759] = TML["Hall of the Guardian"],
	[224869] = TML["Dalaran - Broken Isles"],
	[281403] = TML["Boralus"],
	[281404] = TML["Dazar'alor"],
	[344587] = TML["Oribos"],
	[395277] = TML["Valdrakken"],
	[446540] = TML["Dornogal"],
	-- Mage portals
	[10059] = TML["Stormwind"],
	[11416] = TML["Ironforge"],
	[11417] = TML["Orgrimmar"],
	[11418] = TML["Undercity"],
	[11419] = TML["Darnassus"],
	[11420] = TML["Thunder Bluff"],
	[32266] = TML["Exodar"],
	[32267] = TML["Silvermoon"],
	[33691] = TML["Shattrath"],
	[35717] = TML["Shattrath"],
	[49360] = TML["Theramore"],
	[49361] = TML["Stonard"],
	[53142] = TML["Dalaran - Northrend"],
	[88345] = TML["Tol Barad"], -- Alliance
	[88346] = TML["Tol Barad"], -- Horde
	[120146] = TML["Dalaran - Ancient"],
	[132620] = TML["Vale of Eternal Blossoms"], -- Alliance
	[132626] = TML["Vale of Eternal Blossoms"], -- Horde
	[176244] = TML["Warspear"],
	[176246] = TML["Stormshield"],
	[224871] = TML["Dalaran - Broken Isles"],
	[281400] = TML["Boralus"],
	[281402] = TML["Dazar'alor"],
	[344597] = TML["Oribos"],
	[395289] = TML["Valdrakken"],
	[446534] = TML["Dornogal"],
}

local tpTable = {
	-- Hearthstones
	{ id = 6948, type = "item", hearthstone = true }, -- Hearthstone
	{ id = 556, type = "spell" }, -- Astral Recall (Shaman)
	{ id = 110560, type = "toy", quest = { 34378, 34586 } }, -- Garrison Hearthstone
	{ id = 140192, type = "toy", quest = { 44184, 44663 } }, -- Dalaran Hearthstone
	-- Engineering
	{ type = "wormholes", iconId = 4620673 }, -- Engineering Wormholes
	{ type = "item_teleports", iconId = 133655 }, -- Item Teleports
	-- Class Teleports
	{ id = 1, type = "flyout", iconId = 237509, subtype = "mage" }, -- Teleport (Mage) (Horde)
	{ id = 8, type = "flyout", iconId = 237509, subtype = "mage" }, -- Teleport (Mage) (Alliance)
	{ id = 11, type = "flyout", iconId = 135744, subtype = "mage" }, -- Portals (Mage) (Horde)
	{ id = 12, type = "flyout", iconId = 135748, subtype = "mage" }, -- Portals (Mage) (Alliance)
	{ id = 126892, type = "spell" }, -- Zen Pilgrimage (Monk)
	{ id = 50977, type = "spell" }, -- Death Gate (Death Knight)
	{ id = 18960, type = "spell" }, -- Teleport: Moonglade (Druid)
	{ id = 193753, type = "spell" }, -- Dreamwalk (Druid) (replaces Teleport: Moonglade)
	-- Racials
	{ id = 312370, type = "spell" }, -- Make Camp (Vulpera)
	{ id = 312372, type = "spell" }, -- Return to Camp (Vulpera)
	{ id = 265225, type = "spell" }, -- Mole Machine (Dark Iron Dwarf)

	-- Dungeon/Raid Teleports
	{ id = 230, type = "flyout", iconId = 574788, name = TML["Cataclysm"], subtype = "path" }, -- Hero's Path: Cataclysm
	{ id = 84, type = "flyout", iconId = 328269, name = TML["Mists of Pandaria"], subtype = "path" }, -- Hero's Path: Mists of Pandaria
	{ id = 96, type = "flyout", iconId = 1413856, name = TML["Warlords of Draenor"], subtype = "path" }, -- Hero's Path: Warlords of Draenor
	{ id = 224, type = "flyout", iconId = 1260827, name = TML["Legion"], subtype = "path" }, -- Hero's Path: Legion
	{ id = 223, type = "flyout", iconId = 1869493, name = TML["Battle for Azeroth"], subtype = "path" }, -- Hero's Path: Battle for Azeroth
	{ id = 220, type = "flyout", iconId = 236798, name = TML["Shadowlands"], subtype = "path" }, -- Hero's Path: Shadowlands
	{ id = 222, type = "flyout", iconId = 4062765, name = TML["Shadowlands Raids"], subtype = "path" }, -- Hero's Path: Shadowlands Raids
	{ id = 227, type = "flyout", iconId = 4640496, name = TML["Dragonflight"], subtype = "path" }, -- Hero's Path: Dragonflight
	{ id = 231, type = "flyout", iconId = 5342925, name = TML["Dragonflight Raids"], subtype = "path" }, -- Hero's Path: Dragonflight Raids
	{ id = 232, type = "flyout", iconId = 5872031, name = TML["The War Within"], subtype = "path" }, -- Hero's Path: The War Within
	{ id = 242, type = "flyout", iconId = 6392630, name = TML["The War Within Raids"], subtype = "path", currentExpansion=true }, -- Hero's Path: The War Within Raids
}

local GetItemCount = C_Item.GetItemCount

--------------------------------------
-- Texture Stuff
--------------------------------------

local function SetTextureByItemId(frame, itemId)
	frame:SetNormalTexture(DEFAULT_ICON) -- Temp while loading
	local item = Item:CreateFromItemID(tonumber(itemId))
	item:ContinueOnItemLoad(function()
		local icon = item:GetItemIcon()
		frame:SetNormalTexture(icon)
	end)
end

-- local function retrySetNormalTexture(button, itemId, attempt)
-- 	local attempts = attempt or 1
-- 	local _, _, _, _, _, _, _, _, _, itemTexture = C_Item.GetItemInfo(itemId)
-- 	if itemTexture then
-- 		button:SetNormalTexture(itemTexture)
-- 		return
-- 	end
-- 	if attempts < 5 then
-- 		C_Timer.After(1, function()
-- 			retrySetNormalTexture(button, itemId, attempts + 1)
-- 		end)
-- 	else
-- 		print(APPEND .. TML["Missing Texture %s"]:format(itemId))
-- 	end
-- end

-- local function retryGetToyTexture(toyId, attempt)
-- 	local attempts = attempt or 1
-- 	local _, name, texture = C_ToyBox.GetToyInfo(toyId)
-- 	if attempts < 5 then
-- 		C_Timer.After(0.1, function()
-- 			retryGetToyTexture(toyId, attempts + 1)
-- 		end)
-- 	end
-- end

--------------------------------------
--- Tooltip
--------------------------------------

local function setCombatTooltip(self)
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	local yOffset = globalHeight / 2
	GameTooltip:SetPoint("BOTTOMLEFT", TeleportMeButtonsFrame, "TOPRIGHT", 0, yOffset)
	GameTooltip:SetText(TML["Not In Combat Tooltip"], 1, 1, 1)
	GameTooltip:Show()
end

local function setToolTip(self, type, id, hs)
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	local yOffset = globalHeight / 2
	GameTooltip:SetPoint("BOTTOMLEFT", TeleportMeButtonsFrame, "TOPRIGHT", 0, yOffset)
	if hs and db["Teleports:Hearthstone"] and db["Teleports:Hearthstone"] == "rng" then
		local bindLocation = GetBindLocation()
		GameTooltip:SetText(TML["Random Hearthstone"], 1, 1, 1)
		GameTooltip:AddLine(TML["Random Hearthstone Tooltip"], 1, 1, 1)
		GameTooltip:AddLine(TML["Random Hearthstone Location"]:format(bindLocation), 1, 1, 1)
	elseif type == "item" then
		GameTooltip:SetItemByID(id)
	elseif type == "item_teleports" then
		GameTooltip:SetText(TML["Item Teleports"] .. "\n" .. TML["Item Teleports Tooltip"], 1, 1, 1)
	elseif type == "toy" then
		GameTooltip:SetToyByItemID(id)
	elseif type == "spell" then
		GameTooltip:SetSpellByID(id)
	elseif type == "flyout" then
		local name = GetFlyoutInfo(id)
		GameTooltip:SetText(name, 1, 1, 1)
	elseif type == "profession" then
		local professionInfo = C_TradeSkillUI.GetProfessionInfoBySkillLineID(id)
		if professionInfo then
			GameTooltip:SetText(professionInfo.professionName, 1, 1, 1)
		end
	elseif type == "seasonalteleport" then
		local currExpID = GetExpansionLevel()
		local expName = _G["EXPANSION_NAME" .. currExpID]
		local title = MYTHIC_DUNGEON_SEASON:format(expName, tpm.settings.current_season)
		GameTooltip:SetText(title, 1, 1, 1)
		GameTooltip:AddLine(TML["Seasonal Teleports Tooltip"], 1, 1, 1)
	end
	GameTooltip:Show()
end

--------------------------------------
-- Frames
--------------------------------------

local flyOutButtons = {}
local flyOutButtonsPool = {}
local flyOutFrames = {}
local flyOutFramesPool = {}
local secureButtons = {}
local secureButtonsPool = {}

local function createCooldownFrame(frame)
	if frame.cooldownFrame then
		return frame.cooldownFrame
	end
	local cooldownFrame = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
	cooldownFrame:SetAllPoints()

	function cooldownFrame:CheckCooldown(id, type)
		if not id then
			return
		end
		local start, duration, enabled
		if type == "toy" or type == "item" then
			start, duration, enabled = C_Item.GetItemCooldown(id)
		else
			local cooldown = C_Spell.GetSpellCooldown(id)
			start = cooldown.startTime
			duration = cooldown.duration
			enabled = true
		end
		if enabled and duration > 0 then
			self:SetCooldown(start, duration)
		else
			self:Clear()
		end
	end

	return cooldownFrame
end

local function CloseAllFlyouts()
	for _, frame in ipairs(flyOutFrames) do
		frame:Hide()
	end
end

local function createFlyOutButton(flyOutFrame, flyoutData, tooltipData) -- Flyout Data needs: id, name, iconId
	local flyOutButton
	if next(flyOutButtonsPool) then
		flyOutButton = table.remove(flyOutButtonsPool)
	else
		flyOutButton = CreateFrame("Button", nil, TeleportMeButtonsFrame, "SecureActionButtonTemplate")
		flyOutButton.text = flyOutButton:CreateFontString(nil, "OVERLAY")
		flyOutButton.text:SetPoint("BOTTOM", flyOutButton, "BOTTOM", 0, 5)

		table.insert(flyOutButtons, flyOutButton)
	end

	-- Functions
	function flyOutButton:SetFlyOutFrame(frame)
		flyOutButton.flyoutFrame = frame
	end

	flyOutButton:SetFlyOutFrame(flyOutFrame)

	function flyOutButton:Recycle()
		self:ClearAllPoints()
		self:SetFlyOutFrame(nil)
		self:Hide()
		table.insert(flyOutButtonsPool, self)
	end

	-- Mouse Interaction
	flyOutButton:EnableMouse(true)
	flyOutButton:RegisterForClicks("AnyDown", "AnyUp")

	-- Tooltips
	local tooltipType = "flyout"
	local tooltipId = flyoutData.id
	if tooltipData then
		tooltipType = tooltipData.type
		tooltipId = tooltipData.id
	end
	flyOutButton:SetScript("OnEnter", function(self)
		if InCombatLockdown() then
			setCombatTooltip(self)
			return
		end
		CloseAllFlyouts()
		setToolTip(self, tooltipType, tooltipId)
		self.flyoutFrame:Show()
	end)
	flyOutButton:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	-- Text
	flyOutButton.text:SetFont(STANDARD_TEXT_FONT, db["Button:Text:Size"], "OUTLINE")
	flyOutButton.text:SetTextColor(1, 1, 1, 1)
	flyOutButton.text:Hide()
	if db["Button:Text:Show"] == true and flyoutData.name then
		flyOutButton.text:SetText(flyoutData.name)
		flyOutButton.text:Show()
	end

	-- Texture
	flyOutButton:SetNormalTexture(flyoutData.iconId)

	-- Positioning/Size
	flyOutButton:SetFrameStrata("HIGH")
	flyOutButton:SetFrameLevel(101)
	flyOutButton:SetSize(globalWidth, globalHeight)

	flyOutButton:Show()
	return flyOutButton
end

local function createFlyOutFrame()
	local flyOutFrame
	if next(flyOutFramesPool) then
		flyOutFrame = table.remove(flyOutFramesPool)
	else
		flyOutFrame = CreateFrame("Frame", "FlyOutFrame" .. #flyOutFrames + 1, TeleportMeButtonsFrame)
		table.insert(flyOutFrames, flyOutFrame)
	end

	function flyOutFrame:Recycle()
		self:ClearAllPoints()
		self:Hide()
		table.insert(flyOutFramesPool, self)
	end

	flyOutFrame:SetFrameStrata("HIGH")
	flyOutFrame:SetFrameLevel(103)
	flyOutFrame:SetPropagateMouseClicks(true)
	flyOutFrame:SetPropagateMouseMotion(true)
	flyOutFrame:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
		if not InCombatLockdown() then -- XXX Needed?
			self:Hide()
		end
	end)

	flyOutFrame:Hide()
	return flyOutFrame
end

---@param id ItemInfo
---@return boolean
local function IsItemEquipped(id)
	return C_Item.IsEquippableItem(id) and C_Item.IsEquippedItem(id)
end

local function ClearAllInvalidHighlights()
	for _, button in pairs(secureButtons) do
		button:ClearHighlightTexture()

		if button:GetAttribute("item") ~= nil then
			local id = string.match(button:GetAttribute("item"), "%d+")
			if IsItemEquipped(id) then
				button:Highlight()
			end
		end
	end
end

---@param frame Frame
---@param type string
---@param text string|nil
---@param id integer
---@param hearthstone? boolean
---@return Frame
local function CreateSecureButton(frame, type, text, id, hearthstone)
	local button
	if next(secureButtonsPool) then
		button = table.remove(secureButtonsPool)
	else
		button = CreateFrame("Button", nil, nil, "SecureActionButtonTemplate")
		button.cooldownFrame = createCooldownFrame(button)
		button.text = button:CreateFontString(nil, "OVERLAY")
		button:LockHighlight()
		button.text:SetPoint("BOTTOM", button, "BOTTOM", 0, 5)
		table.insert(secureButtons, button)
	end

	function button:Recycle()
		self:SetParent(nil)
		self:ClearAllPoints()
		self:Hide()
		if type == "item" and not C_Item.IsEquippedItem(id) then
			self:ClearHighlightTexture()
		end
		table.insert(secureButtonsPool, self)
	end

	function button:Highlight()
		self:SetHighlightAtlas("talents-node-choiceflyout-square-green")
	end

	button:EnableMouse(true)
	button:RegisterForClicks("AnyDown", "AnyUp")

	-- Text
	button.text:SetFont(STANDARD_TEXT_FONT, db["Button:Text:Size"], "OUTLINE")
	button.text:SetTextColor(1, 1, 1, 1)
	button.text:Hide()
	if db["Button:Text:Show"] == true and text then
		button.text:SetText(text)
		button.text:Show()
	end

	-- Scripts
	button:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	button:SetScript("OnEnter", function(self)
		setToolTip(self, type, id, hearthstone)
	end)
	button:SetScript("OnShow", function(self)
		self.cooldownFrame:CheckCooldown(id, type)
	end)
	button:SetScript("PostClick", function(self)
		if type == "item" and C_Item.IsEquippableItem(id) then
			C_Timer.After(0.25, function() -- Slight delay due to equipping the item not being instant.
				if IsItemEquipped(id) then
					ClearAllInvalidHighlights()
					self:Highlight()
				end
			end)
		end
	end)
	button.cooldownFrame:CheckCooldown(id, type)

	-- Textures
	if type == "spell" then
		local spellTexture = C_Spell.GetSpellTexture(id)
		button:SetNormalTexture(spellTexture)
	else -- item or toy
		SetTextureByItemId(button, id)
	end

	-- Attributes
	button:SetAttribute("type", type)
	if type == "item" then
		button:SetAttribute(type, "item:" .. id)
		if C_Item.IsEquippableItem(id) and IsItemEquipped(id) then
			button:Highlight()
		end
	else
		button:SetAttribute(type, id)
	end

	-- Positioning/Size
	button:SetParent(frame)
	button:SetSize(globalWidth, globalHeight)
	button:SetFrameStrata("HIGH")
	button:SetFrameLevel(102) -- This needs to be lower than the flyout frame

	button:Show()
	return button
end

--------------------------------------
-- Functions
--------------------------------------

function tpm:GetIconText(spellId)
	local text = shortNames[spellId]
	if text then
		return text
	end
	print(APPEND .. "No short name found for spellID " .. spellId .. ", please report this on GitHub")
end

function tpm:UpdateAvailableSeasonalTeleports()
	availableSeasonalTeleports = {}

	local factionTeleports = {
		Alliance = { siegeOfBoralus = 445418, motherlode = 467553 },
		Horde = { siegeOfBoralus = 464256, motherlode = 467555 }
	}
	local playerFaction = UnitFactionGroup("player")
	local factionData = factionTeleports[playerFaction] or {}
	local siegeOfBoralus = factionData.siegeOfBoralus
	local motherlode = factionData.motherlode

	local seasonalTeleports = {
		-- TWW S1
		[1] = {
			[353] = siegeOfBoralus, -- Siege of Boralus has two spells one for alliance and one for horde
			[375] = 354464, -- Mists
			[376] = 354462, -- Necrotic Wake
			[501] = 445269, -- Stonevault
			[502] = 445416, -- City of Threads
			[503] = 445417, -- Ara Ara
			[505] = 445414, -- The Dawnbreaker
			[507] = 445424, -- Grim Batol
		},
		-- TWW S2
		[2] = {
			[247] = motherlode, -- The MOTHERLODE!!
			[370] = 373274, -- Operation: Mechagon - Workshop
			[382] = 354467, -- Theater of Pain
			[499] = 445444, -- Priory of the Sacred Flame
			[500] = 445443, -- The Rookery
			[504] = 445441, -- Darkflame Cleft
			[506] = 445440, -- Cinderbrew Meadery
			[525] = 1216786, -- Operation: Floodgate
		},
		-- TWW S3
		[3] = {
			[499] = 445444, -- Priory of the Sacred Flame
			[542] = 1237215, -- Eco-Dome Al'dani
			[378] = 354465, -- Halls of Atonement
			[525] = 1216786, -- Operation: Floodgate
			[503] = 445417, -- Ara-Kara, City of Echoes
			[392] = 367416, -- Tazavesh: So'leah's Gambit
			-- [391] = 367416, -- Tazavesh: Streets of Wonder
			[505] = 445414, -- The Dawnbreaker
		},
	}

	for _, mapId in ipairs(C_ChallengeMode.GetMapTable()) do
		local spellID = seasonalTeleports[tpm.settings.current_season][mapId]
		if spellID and IsSpellKnown(spellID) then
			table.insert(availableSeasonalTeleports, spellID)
		end
	end
end

function tpm:checkQuestCompletion(quest)
	if type(quest) == "table" then
		for _, questID in ipairs(quest) do
			if C_QuestLog.IsQuestFlaggedCompleted(questID) then
				return true
			end
		end
	else
		return C_QuestLog.IsQuestFlaggedCompleted(quest)
	end
end

function tpm:CreateFlyout(flyoutData)
	if db["Teleports:Seasonal:Only"] and (flyoutData.subtype == "path" and not flyoutData.currentExpansion) then
		return
	end
	local _, _, spells, flyoutKnown = GetFlyoutInfo(flyoutData.id)
	if not flyoutKnown then
		return
	end

	local yOffset = -globalHeight * TeleportMeButtonsFrame:GetButtonAmount()
	local flyOutFrame = createFlyOutFrame()
	flyOutFrame:SetPoint("LEFT", TeleportMeButtonsFrame, "TOPRIGHT", 0, yOffset)

	-- Flyout Main Button
	local button = createFlyOutButton(flyOutFrame, flyoutData)
	button:SetPoint("LEFT", TeleportMeButtonsFrame, "TOPRIGHT", 0, yOffset)

	local childButtons = {}
	local flyoutsCreated = 0
	local rowNr = 1
	local inverse = db["Teleports:Mage:Reverse"] and flyoutData.subtype == "mage"
	local start, endLoop, step = 1, spells, 1
	if inverse then -- Inverse loop params
		start, endLoop, step = spells, 1, -1
	end
	for i = start, endLoop, step do
		local spellId = select(1, GetFlyoutSlotInfo(flyoutData.id, i))
		if IsSpellKnown(spellId) then
			if flyoutsCreated == db["Flyout:Max_Per_Row"] then
				flyoutsCreated = 0
				rowNr = rowNr + 1
			end
			flyoutsCreated = flyoutsCreated + 1
			local flyOutButton = CreateSecureButton(flyOutFrame, "spell", shortNames[spellId], spellId)
			flyOutButton:SetPoint("TOPLEFT", flyOutFrame, "TOPLEFT", globalWidth * flyoutsCreated, (rowNr - 1) * - globalHeight)
			table.insert(childButtons, flyOutButton)
		end
	end

	local frameWidth = rowNr > 1 and globalWidth * (db["Flyout:Max_Per_Row"] + 1) or globalWidth * (flyoutsCreated + 1)
	flyOutFrame:SetSize(frameWidth, globalHeight * rowNr)
	button.childButtons = childButtons
	return button
end

function tpm:CreateSeasonalTeleportFlyout()
	if #availableSeasonalTeleports == 0 then
		return
	end

	local tooltipData = { type = "seasonalteleport" }
	local seasonalFlyOutData = { id = -1, name = TML["Season " .. tpm.settings.current_season], iconId = 5927657 }
	local yOffset = -globalHeight * TeleportMeButtonsFrame:GetButtonAmount()

	local flyOutFrame = createFlyOutFrame()
	flyOutFrame:SetPoint("LEFT", TeleportMeButtonsFrame, "TOPRIGHT", 0, yOffset)

	local button = createFlyOutButton(flyOutFrame, seasonalFlyOutData, tooltipData)
	button:SetPoint("LEFT", TeleportMeButtonsFrame, "TOPRIGHT", 0, yOffset)

	local flyoutsCreated = 0
	local rowNr = 1
	for _, spellId in ipairs(availableSeasonalTeleports) do
		if IsSpellKnown(spellId) then
			if flyoutsCreated == db["Flyout:Max_Per_Row"] then
				flyoutsCreated = 0
				rowNr = rowNr + 1
			end
			flyoutsCreated = flyoutsCreated + 1
			local text = tpm:GetIconText(spellId)
			local flyOutButton = CreateSecureButton(flyOutFrame, "spell", text, spellId)
			flyOutButton:SetPoint("TOPLEFT", flyOutFrame, "TOPLEFT", globalWidth * flyoutsCreated, (rowNr - 1) * - globalHeight)
		end
	end
	local frameWidth = rowNr > 1 and globalWidth * (db["Flyout:Max_Per_Row"] + 1) or globalWidth * (flyoutsCreated + 1)
	flyOutFrame:SetSize(frameWidth, globalHeight * rowNr)

	return button
end

function tpm:CreateWormholeFlyout(flyoutData)
	local usableWormholes = tpm.AvailableWormholes:GetUsable()
	if #usableWormholes == 0 then
		return
	end

	local yOffset = -globalHeight * TeleportMeButtonsFrame:GetButtonAmount()

	local flyOutFrame = createFlyOutFrame()
	flyOutFrame:SetPoint("LEFT", TeleportMeButtonsFrame, "TOPRIGHT", 0, yOffset)

	local button = createFlyOutButton(flyOutFrame, flyoutData, { type = "profession", id = 202 })
	button:SetPoint("LEFT", TeleportMeButtonsFrame, "TOPRIGHT", 0, yOffset)

	local flyoutsCreated = 0
	local rowNr = 1
	for _, wormholeId in ipairs(usableWormholes) do
		if flyoutsCreated == db["Flyout:Max_Per_Row"] then
			flyoutsCreated = 0
			rowNr = rowNr + 1
		end
		flyoutsCreated = flyoutsCreated + 1
		local flyOutButton = CreateSecureButton(flyOutFrame, "toy", nil, wormholeId)
		flyOutButton:SetPoint("TOPLEFT", flyOutFrame, "TOPLEFT", globalWidth * flyoutsCreated, (rowNr - 1) * - globalHeight)
	end
	local frameWidth = rowNr > 1 and globalWidth * (db["Flyout:Max_Per_Row"] + 1) or globalWidth * (flyoutsCreated + 1)
	flyOutFrame:SetSize(frameWidth, globalHeight * rowNr)

	return button
end

function tpm:CreateItemTeleportsFlyout(flyoutData)
	if #tpm.AvailableItemTeleports == 0 then
		return
	end

	local yOffset = -globalHeight * TeleportMeButtonsFrame:GetButtonAmount()

	local flyOutFrame = createFlyOutFrame()
	flyOutFrame:SetPoint("LEFT", TeleportMeButtonsFrame, "TOPRIGHT", 0, yOffset)

	local button = createFlyOutButton(flyOutFrame, flyoutData, { type = "item_teleports" })
	button:SetPoint("LEFT", TeleportMeButtonsFrame, "TOPRIGHT", 0, yOffset)

	local flyoutsCreated = 0
	local rowNr = 1
	for _, itemTeleportId in ipairs(tpm.AvailableItemTeleports) do
		if flyoutsCreated == db["Flyout:Max_Per_Row"] then
			flyoutsCreated = 0
			rowNr = rowNr + 1
		end
		flyoutsCreated = flyoutsCreated + 1
		local isToy = tpm:IsToyTeleport(itemTeleportId)
		local flyOutButton = CreateSecureButton(flyOutFrame, isToy and "toy" or "item", nil, itemTeleportId)
		flyOutButton:SetPoint("TOPLEFT", flyOutFrame, "TOPLEFT", globalWidth * flyoutsCreated, (rowNr - 1) * - globalHeight)
	end

	local frameWidth = rowNr > 1 and globalWidth * (db["Flyout:Max_Per_Row"] + 1) or globalWidth * (flyoutsCreated + 1)
	flyOutFrame:SetSize(frameWidth, globalHeight * rowNr)

	return button
end

function tpm:updateHearthstone()
	local hearthstoneButton = TeleportMeButtonsFrame.hearthstoneButton
	if not hearthstoneButton then
		return
	end

	if db["Teleports:Hearthstone"] == "rng" then
		local rng = math.random(#tpm.AvailableHearthstones)
		hearthstoneButton:SetNormalTexture(1669494) -- misc_rune_pvp_random
		hearthstoneButton:SetAttribute("type", "toy")
		hearthstoneButton:SetAttribute("toy", tpm.AvailableHearthstones[rng])
	elseif db["Teleports:Hearthstone"] ~= "none" then
		SetTextureByItemId(hearthstoneButton, db["Teleports:Hearthstone"])
		hearthstoneButton:SetAttribute("type", "toy")
		hearthstoneButton:SetAttribute("toy", db["Teleports:Hearthstone"])
		hearthstoneButton:SetScript("OnEnter", function(s)
			setToolTip(s, "toy", db["Teleports:Hearthstone"], true)
		end)
	else
		if C_Item.GetItemCount(6948) == 0 then
			print(APPEND .. TML["No Hearthtone In Bags"])
			hearthstoneButton:Hide()
			return
		end
		SetTextureByItemId(hearthstoneButton, 6948)
		hearthstoneButton:SetAttribute("type", "item")
		hearthstoneButton:SetAttribute("item", "item:6948")
		hearthstoneButton:SetScript("OnEnter", function(s)
			setToolTip(s, "item", 6948, true)
		end)
	end
	hearthstoneButton:Show()
end

local function createAnchors()
	if TeleportMeButtonsFrame and not TeleportMeButtonsFrame.reload then
		if not db["Enabled"] then
			TeleportMeButtonsFrame:Hide()
			return
		end
		if TeleportMeButtonsFrame:IsVisible() and db["Teleports:Hearthstone"] and db["Teleports:Hearthstone"] == "rng" then
			local rng = tpm:GetRandomHearthstone()
			TeleportMeButtonsFrame.hearthstoneButton:SetAttribute("toy", rng)
		end
		ClearAllInvalidHighlights()
		return
	end
	if not db["Enabled"] then
		return
	end
	local buttonsFrame = TeleportMeButtonsFrame or CreateFrame("Frame", "TeleportMeButtonsFrame", GameMenuFrame)
	buttonsFrame.reload = nil
	buttonsFrame:SetSize(1, 1)
	local buttonFrameYOffset = globalHeight / 2
	buttonsFrame:SetPoint("TOPLEFT", GameMenuFrame, "TOPRIGHT", 0, -buttonFrameYOffset)

	buttonsFrame.buttonAmount = 0
	function buttonsFrame:IncrementButtons()
		self.buttonAmount = self.buttonAmount + 1
	end

	function buttonsFrame:GetButtonAmount()
		return self.buttonAmount
	end

	for _, teleport in ipairs(tpTable) do
		local texture
		local known

		-- Checks and overwrites
		if teleport.hearthstone and db["Teleports:Hearthstone"] ~= "none" then -- Overwrite main HS with user set HS
			tpm:DebugPrint("Overwriting main HS with user set HS")
			teleport.type = "toy"
			known = true
			if db["Teleports:Hearthstone"] == "rng" then
				texture = 1669494 -- misc_rune_pvp_random
				teleport.id = tpm:GetRandomHearthstone()
			else
				teleport.id = db["Teleports:Hearthstone"]
			end
			tpm:DebugPrint("Overwrite Info:", known, teleport.id, teleport.type, texture)
		elseif teleport.type == "item" and C_Item.GetItemCount(teleport.id) > 0 then
			known = true
		elseif
			teleport.type == "toy" and PlayerHasToy(teleport.id --[[@as integer]])
		then
			if teleport.quest then
				known = tpm:checkQuestCompletion(teleport.quest)
			else
				known = true
			end
		elseif
			teleport.type == "spell" and IsSpellKnown(teleport.id --[[@as integer]])
		then
			known = true
		end

		if not known and teleport.hearthstone then -- Player has no HS in bags and not set a custom TP.
			print(APPEND .. TML["No Hearthtone In Bags"])
		end

		-- Create Stuff
		if known and (teleport.type == "toy" or teleport.type == "item" or teleport.type == "spell") then
			tpm:DebugPrint(teleport.hearthstone)
			local button = CreateSecureButton(buttonsFrame, teleport.type, nil, teleport.id --[[@as integer]], teleport.hearthstone)
			local yOffset = -globalHeight * buttonsFrame:GetButtonAmount()
			button:SetPoint("LEFT", buttonsFrame, "TOPRIGHT", 0, yOffset)
			if teleport.hearthstone then -- store to replace item later
				buttonsFrame.hearthstoneButton = button
			end
			buttonsFrame:IncrementButtons()
		elseif teleport.type == "wormholes" then
			local created = tpm:CreateWormholeFlyout(teleport)
			if created then
				buttonsFrame:IncrementButtons()
			end
		elseif teleport.type == "item_teleports" then
			local created = tpm:CreateItemTeleportsFlyout(teleport)
			if created then
				buttonsFrame:IncrementButtons()
			end
		elseif teleport.type == "flyout" then
			local created = tpm:CreateFlyout(teleport)
			if created then
				buttonsFrame:IncrementButtons()
			end
		end
	end

	local function CreateCurrentSeasonTeleports()
		local created = tpm:CreateSeasonalTeleportFlyout()
		if created then
			buttonsFrame:IncrementButtons()
		end
	end

	CreateCurrentSeasonTeleports()
	tpm:updateHearthstone() -- XXX Temp as this fixes the rng icon if it's selected
end

function tpm:ReloadFrames()
	if InCombatLockdown() then
		return
	end
	if db["Button:Size"] then
		globalWidth = db["Button:Size"]
		globalHeight = db["Button:Size"]
	end

	for _, button in ipairs(flyOutButtons) do
		button:Recycle()
	end
	for _, frame in ipairs(flyOutFrames) do
		frame:Recycle()
	end
	for _, secureButton in ipairs(secureButtons) do
		secureButton:Recycle()
	end

	if TeleportMeButtonsFrame then
		TeleportMeButtonsFrame.reload = true
	end

	createAnchors()
end

-- Slash Commands
SLASH_TPMENU1 = "/tpm"
SLASH_TPMENU2 = "/tpmenu"
SlashCmdList["TPMENU"] = function(msg)
	local args = { (" "):split(msg:lower()) }
	msg = args[1]

	if msg == "" then
		Settings.OpenToCategory(tpm:GetOptionsCategory())
	elseif msg == "filters" then
		Settings.OpenToCategory(tpm:GetOptionsCategory(msg))
	else
		print(APPEND .. " unknown command: " .. msg)
	end
end
--------------------------------------
-- Loading
--------------------------------------

local function checkItemsLoaded(self)
	if self.continuableContainer then
		self.continuableContainer:Cancel()
	end

	self.continuableContainer = ContinuableContainer:Create()

	local function LoadItems(itemTable)
		for id, _ in ipairs(itemTable) do
			self.continuableContainer:AddContinuable(Item:CreateFromItemID(id))
		end
	end

	LoadItems(tpm.Wormholes)
	LoadItems(tpm.Hearthstones)
	LoadItems(tpm.ItemTeleports)

	local allLoaded = true
	local function OnItemsLoaded()
		if allLoaded then
			tpm:Setup()
			tpm:LoadOptions()
			self:UnregisterEvent("ADDON_LOADED")
		else
			checkItemsLoaded(self)
		end
	end

	allLoaded = self.continuableContainer:ContinueOnLoad(OnItemsLoaded)
end

function tpm:Setup()
	if db["Button:Size"] then
		globalWidth = db["Button:Size"]
		globalHeight = db["Button:Size"]
	end

	tpm:UpdateAvailableHearthstones()
	tpm:UpdateAvailableWormholes()
	tpm:UpdateAvailableSeasonalTeleports()
	tpm:UpdateAvailableItemTeleports()

	if
		db["Teleports:Hearthstone"]
		and db["Teleports:Hearthstone"] ~= "rng"
		and db["Teleports:Hearthstone"] ~= "none"
		and not PlayerHasToy(db["Teleports:Hearthstone"] --[[@as integer]])
	then
		print(APPEND .. TML["Hearthone Reset Error"]:format(db["Teleports:Hearthstone"]))
		db["Teleports:Hearthstone"] = "none"
		tpm:updateHearthstone()
	end

	hooksecurefunc("ToggleGameMenu", tpm.ReloadFrames)
end

-- Event Handlers
local events = {}
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("BAG_UPDATE_DELAYED")
f:SetScript("OnEvent", function(self, event, ...)
	events[event](self, ...)
end)

function events:ADDON_LOADED(...)
	local addOnName = ...

	if addOnName == "OrzUI" then
		db = tpm:GetOptions()
		tpm.settings.current_season = 2

		db.debug = false
		f:UnregisterEvent("ADDON_LOADED")
	end
end

function events:PLAYER_LOGIN()
	checkItemsLoaded(f)
	f:UnregisterEvent("PLAYER_LOGIN")
end

function events:BAG_UPDATE_DELAYED()
	--- @type Item[]
	local items_in_possession = CopyTable(tpm.player.items_in_possession)

	--- @type Item[]
	local items_to_be_obtained = CopyTable(tpm.player.items_to_be_obtained)

	-- Scan bags for items supposedly in possession
	for _, item in pairs(items_in_possession) do
		if GetItemCount(item.id) == 0 then
			tpm:RemoveItemFromPossession(item.id)
		end
	end

	-- Scan bags for items supposedly NOT in possession
	for _, item in pairs(items_to_be_obtained) do
		if GetItemCount(item.id) > 0 then
			tpm:AddItemToPossession(item.id)
		end
	end
end

-- Debug Functions
function tpm:DebugPrint(...)
	if not db.debug then
		return
	end
	print(APPEND, ...)
end
