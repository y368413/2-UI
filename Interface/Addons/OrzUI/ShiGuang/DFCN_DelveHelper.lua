--## Title: |c000EEE00地下堡助手|r|cFFFFA500 By|r|c000EEEEE DFCN ## Notes: DFCN的地下堡助手，提供自动选择层数，自动进入地下堡，宿敌及藏宝图监控等功能。 ## Author: DFCN
local DFCNL = {}
if GetLocale() == "zhCN" then
    DFCNL["SCOREBOARD_TITLE"] = "地下堡监控"
    DFCNL["SCENARIO"] = "场景"
    DFCNL["DIFFICULTY_LEVEL"] = "难度等级"
    DFCNL["REMAINING_LIVES"] = "剩余生命"
    DFCNL["REMAINING_ENEMIES"] = "剩余宿敌"
    DFCNL["TOTAL_TIME"] = "总用时"
    DFCNL["FLASHING_DOOR"] = "闪烁之门"
    DFCNL["BIGWIGS_FLASHING_DOOR_SPAWN"] = "一扇闪烁之门出现在其中"
    DFCNL["BIGWIGS_FLASHING_DOOR_COMPLETE"] = "完成地下堡会出现"
    DFCNL["FLASHING_DOOR_USED"] = "已使用"
    DFCNL["BRANN_ROLE"] = "铜须职责"
    DFCNL["COMBAT_TRINKET"] = "战斗珍玩"
    DFCNL["UTILITY_TRINKET"] = "效能珍玩"
    DFCNL["NOT_SET"] = "未设置"
    DFCNL["MAP"] = "地图"
    DFCNL["DELVE"] = "地下堡"
    DFCNL["SPECIAL_DELVE_NAME"] = "虚空之锋庇护所"
    DFCNL["STORY_VARIANT"] = "故事变种"
    DFCNL["STORY_VARIANT_PATTERN"] = "故事变种：%s*(.+)"
    DFCNL["GOLDEN_CREST_PATTERN"] = "鎏金.-纹章"
    DFCNL["SPECIAL_FOOTBOMB_TREASURE"] = "损坏的自动化足球炸弹分发器"
    DFCNL["UNKNOWN_MAP"] = "未知地图"
    DFCNL["UNKNOWN"] = "未知"
    DFCNL["DELVE_SCENARIO_NAME"] = "地下堡"
    DFCNL["BACKGROUND_TRANSPARENCY"] = "背景透明度"
    DFCNL["CLICK_TO_EXIT"] = "点击立刻离开地下堡"
    DFCNL["BANK_STATUS"] = "银行状态"
    DFCNL["BANK_AVAILABLE"] = "当前该角色可正常访问战团银行"
    DFCNL["BANK_UNAVAILABLE"] = "当前该角色无法访问战团银行，请勿使用战团银行技能！"
    DFCNL["DWARVEN_MEDICINE"] = "矮人药品"
    DFCNL["STACKS"] = "层"
    DFCNL["ENABLED"] = "开启"
    DFCNL["DISABLED"] = "关闭"
    DFCNL["SETTINGS_TITLE"] = "助手设置"
    DFCNL["AUTO_ENTER"] = "自动进入地下堡"
    DFCNL["AUTO_ACTIVATE"] = "自动与NPC对话"
    DFCNL["SHOW_SCOREBOARD"] = "显示地下堡监控"
    DFCNL["TREASURE_MAP_ALERT"] = "自动检测藏宝图"
    DFCNL["AUTO_PET_CAGE"] = "自动打包战斗宠物"
    DFCNL["AUTO_TOKEN_EXCHANGE"] = "自动确认兑换纹章"
    DFCNL["DIFFICULTY_LABEL"] = "难度："
    DFCNL["FAST_EXIT_MODE"] = "速刷模式"
    DFCNL["VIEW_MERCHANT"] = "查看地下堡商人"
    DFCNL["VIEW_DELVE_INFO"] = "查看地下堡信息"
    DFCNL["CLOSE"] = "关闭"
    DFCNL["DIFFICULTY_LEVEL_FORMAT"] = "难度 %d"
    DFCNL["SPECIAL_DIFFICULTY_PATTERN"] = "难度 %？"
    DFCNL["SELECT_BUTTON_PATTERN"] = "选择"
    DFCNL["REMAINING_ENEMIES_PATTERN"] = "剩余敌群"
    DFCNL["ENCHANTED_ITEM_PATTERN"] = "附魔"
    DFCNL["MATRIX_ITEM_PATTERN"] = "矩阵"
    DFCNL["CREST_PATTERN"] = "纹章"
    DFCNL["INFO"] = "信息"
    DFCNL["WARNING"] = "警告"
    DFCNL["NOTICE"] = "注意"
    DFCNL["SETTING_CHANGED"] = "设置修改"
    DFCNL["AUTO_ENTER_ENABLED"] = "自动进入地下堡功能已启用"
    DFCNL["AUTO_ENTER_DISABLED"] = "自动进入地下堡功能已禁用"
    DFCNL["FAST_EXIT_ENABLED"] = "速刷模式已启用，现在进出地下堡无CD"
    DFCNL["FAST_EXIT_DISABLED"] = "速刷模式已禁用，离开地下堡5秒后才再次触发自动进入"
    DFCNL["DIFFICULTY_SET"] = "已设置自动选择难度等级为 %d"
    DFCNL["DIFFICULTY_UNSET"] = "已关闭自动选择难度等级，自动进入地下堡功能已禁用"
    DFCNL["SCOREBOARD_ENABLED"] = "地下堡监控已启用，进入地下堡后自动显示监控面板"
    DFCNL["SCOREBOARD_DISABLED"] = "地下堡监控功能已禁用"
    DFCNL["TREASURE_MAP_ENABLED"] = "自动检测藏宝图功能已启用"
    DFCNL["TREASURE_MAP_DISABLED"] = "自动检测藏宝图功能已禁用"
    DFCNL["AUTO_ACTIVATE_ENABLED"] = "自动与NPC对话功能已启用"
    DFCNL["AUTO_ACTIVATE_DISABLED"] = "自动与NPC对话功能已禁用"
    DFCNL["AUTO_PET_CAGE_ENABLED"] = "自动打包战斗宠物功能已启用"
    DFCNL["AUTO_PET_CAGE_DISABLED"] = "自动打包战斗宠物功能已禁用"
    DFCNL["AUTO_TOKEN_EXCHANGE_ENABLED"] = "自动确认兑换纹章功能已启用，仅自动确认45低级纹章换15高级纹章。"
    DFCNL["AUTO_TOKEN_EXCHANGE_DISABLED"] = "自动确认兑换纹章功能已禁用"
    DFCNL["SPECIAL_DELVE_WARNING"] = "当前为特殊地下堡，自动进入已取消"
    DFCNL["AUTO_ENTER_MESSAGE"] = "自动进入地下堡：%s（%d层）"
    DFCNL["SELECT_DIFFICULTY_WARNING"] = "请先在设置中选择自动进入的难度等级"
    DFCNL["TOKEN_EXCHANGE_CONFIRMED"] = "自动确认纹章兑换"
    DFCNL["ADVANCED_TOKEN_WARNING"] = "你正在使用高级纹章兑换低级纹章，请谨慎操作！"
    DFCNL["PET_CAGED"] = "已自动打包，请再次使用该宠物以加入宠物手册"
    DFCNL["PET_NOT_FOUND"] = "未找到打包的战斗宠物，请手动打包"
    DFCNL["PET_CAGE_ERROR"] = "宠物自动打包遇到未知错误，请手动打包"
    DFCNL["NPC_MARKED"] = "已自动标记需救助的NPC"
    DFCNL["BRANN_CONFIG_UPDATED"] = "布莱恩·铜须配置已更新"
    DFCNL["MINIMAP_SHOWN"] = "小地图图标已显示"
    DFCNL["MINIMAP_HIDDEN"] = "小地图图标已隐藏"
    DFCNL["ADDON_DESCRIPTION"] = "|cff33ff99[便捷]|r地下堡"
    DFCNL["TOOLTIP_LEFT_CLICK"] = "左键: 打开/关闭设置面板"
    DFCNL["TOOLTIP_COMMAND"] = "宏命令: /dfcndelve"
    DFCNL["TOOLTIP_MINIMAP"] = "小地图图标: /dfcndelve minimap on/off"
    DFCNL["TOOLTIP_ESC"] = "面板打开时按ESC可关闭"
    DFCNL["AUTO_ENTER_TOOLTIP"] = "自动进入地下堡"
    DFCNL["AUTO_ENTER_TOOLTIP_DETAIL1"] = "靠近地下堡入口时，自动进入预设层数的地下堡"
    DFCNL["AUTO_ENTER_TOOLTIP_DETAIL2"] = "速刷模式关闭时，离开地下堡不会马上再次进入（5S CD）"
    DFCNL["FAST_EXIT_TOOLTIP"] = "速刷模式"
    DFCNL["FAST_EXIT_TOOLTIP_DETAIL1"] = "退出地下堡后立刻进入地下堡（0S CD）"
    DFCNL["FAST_EXIT_TOOLTIP_DETAIL2"] = "推荐仅在需要快速反复进出相同地下堡时才打开"
    DFCNL["SCOREBOARD_TOOLTIP"] = "显示地下堡监控"
    DFCNL["SCOREBOARD_TOOLTIP_DETAIL1"] = "进入地下堡后，会自动显示监控面板"
    DFCNL["SCOREBOARD_TOOLTIP_DETAIL2"] = "面板的U/L标识锁定和未锁定状态T为透明度调节"
    DFCNL["SCOREBOARD_TOOLTIP_DETAIL3"] = "离开地下堡后，监控面板会自动关闭"
    DFCNL["TREASURE_MAP_TOOLTIP"] = "自动检测藏宝图"
    DFCNL["TREASURE_MAP_TOOLTIP_DETAIL1"] = "当获取到地下堡藏宝图后自动提醒使用"
    DFCNL["TREASURE_MAP_TOOLTIP_DETAIL2"] = "非11层地下堡使用自动提醒地下堡层数错误"
    DFCNL["AUTO_ACTIVATE_TOOLTIP"] = "自动与NPC对话"
    DFCNL["AUTO_ACTIVATE_TOOLTIP_DETAIL1"] = "鼠标右键点击NPC或物品时"
    DFCNL["AUTO_ACTIVATE_TOOLTIP_DETAIL2"] = "会自动选择对话项推动地下堡进程"
    DFCNL["AUTO_PET_CAGE_TOOLTIP"] = "自动打包战斗宠物"
    DFCNL["AUTO_PET_CAGE_TOOLTIP_DETAIL1"] = "可直接鼠标右键使用战斗小宠物"
    DFCNL["AUTO_PET_CAGE_TOOLTIP_DETAIL2"] = "如果系统提示无法获取更多该类宠物，则自动打包该宠物"
    DFCNL["AUTO_PET_CAGE_TOOLTIP_DETAIL3"] = "由于游戏限制，自动打包后仍需再次手动使用该宠物加入宠物手册"
    DFCNL["AUTO_TOKEN_EXCHANGE_TOOLTIP"] = "自动确认兑换纹章"
    DFCNL["AUTO_TOKEN_EXCHANGE_TOOLTIP_DETAIL1"] = "45个低级纹章兑换15个高级纹章自动确认"
    DFCNL["AUTO_TOKEN_EXCHANGE_TOOLTIP_DETAIL2"] = "15个高级纹章兑换15个低级纹章提醒警告"
    DFCNL["GOLDEN_CACHE_WARNING"] = "注意：鎏金纹章尚未全部拾取！"
    DFCNL["TREASURE_BUFF_WRONG_LEVEL"] = "注意：藏宝图已激活，当前不是11层地下堡！"
    DFCNL["TREASURE_MAP_REMINDER"] = "注意：请使用背包中的地下堡藏宝图！"
    DFCNL["NGA_RECOMMENDED_STORY"] = "NGA地堡侠推荐故事"
    DFCNL["NGA_RECOMMENDED_DETAIL"] = "本故事变种难度简单适合速刷"
    DFCNL["BRANN_SAYS"] = "布莱恩·铜须说："
    DFCNL["BRANN_GOLDEN_CACHE_ALERT"] = "藏宝室里有鎏金纹章，你可瞅仔细啦！"
    DFCNL["BRANN_TREASURE_WARNING"] = "清醒一点，老兄！这里不是十一层地下堡，你确认要在这里使用藏宝图吗？"
    DFCNL["BRANN_TREASURE_REMINDER"] = "你包里是地下堡藏宝图吗？你可千万别忘记使用它。"
    DFCNL["BRANN_FLASHING_DOOR"] = "闪烁之门？让我们赶紧去探索吧！"
    DFCNL["BRANN_FOOTBOMB"] = "这真是好东西，炸弹足球！让我也来踢一脚。"
    DFCNL["BRANN_GOLDEN_CREST"] = "鎏金纹章都进了你的背包，这下我就放心了。"
    DFCNL["LEAVE_FOLLOWER_DIFFICULTY"] = "已自动退队离开破晨号（追随者难度）"
    DFCNL["DRILL_TO_ANDERMORE"] = "已自动搭乘钻机前往安德麦"
    DFCNL["DRILL_TO_NOISY_CAVERN"] = "已自动搭乘钻机前往喧鸣深窟"
    DFCNL["DRILL_TO_ZULDAZAR"] = "已自动搭乘钻机前往祖达萨"
    DFCNL["UNKNOWN_TREASURE"] = "未知珍玩"
    DFCNL["RETRY_COUNT"] = "重试：%d/3"
    DFCNL["ADDON_LOADED"] = "地下堡助手已加载"
    DFCNL["ADDON_STATUS"] = "自动进入: %s | 难度等级: %s | 速刷模式: %s"
    DFCNL["AUTO_NPC_INTERACTION"] = "自动与NPC对话: %s"
    DFCNL["AUTO_SELECT_TREASURE"] = "自动选择珍玩宝藏：%s"
    DFCNL["REFRESH_TIME"] = "7:00刷新"
    DFCNL["CURRENT_DATE"] = "当前：%02d-%02d"
    DFCNL["UNKNOWN_ITEM"] = "未知物品"
    DFCNL["UNKNOWN_DELVE"] = "未知地下堡"
    DFCNL["SLASH_COMMAND"] = "/dfcndelve - 打开设置面板"
    DFCNL["SLASH_MINIMAP_ON"] = "/dfcndelve minimap on - 显示小地图图标"
    DFCNL["SLASH_MINIMAP_OFF"] = "/dfcndelve minimap off - 隐藏小地图图标"
    DFCNL["MINIMAP_CHECKBOX"] = "显示小地图图标"
    DFCNL["OPEN_SETTINGS"] = "打开助手设置面板"
    DFCNL["CLOSE_SETTINGS"] = "关闭助手设置面板"
    DFCNL["COMMAND_TIP"] = "宏调用指令: /dfcndelve"
    DFCNL["DOWNLOAD_LABEL"] = "原始发布地址："
    DFCNL["COPY_TIP"] = "点击选中网址，按Ctrl+C复制"
    DFCNL["TIME_FORMAT_COMPLETED_HMS"] = "%d:%02d:%02d（已完成）"
    DFCNL["TIME_FORMAT_COMPLETED_MS"] = "%02d:%02d（已完成）";
elseif GetLocale() == "zhTW" then
    --This text has been translated by AI:DeepSeek
    DFCNL["SCOREBOARD_TITLE"] = "探究記分板"
    DFCNL["SCENARIO"] = "場景"
    DFCNL["DIFFICULTY_LEVEL"] = "難度級別"
    DFCNL["REMAINING_LIVES"] = "剩餘生命"
    DFCNL["REMAINING_ENEMIES"] = "剩餘敵群"
    DFCNL["TOTAL_TIME"] = "總用時"
    DFCNL["FLASHING_DOOR"] = "閃爍大門"
    DFCNL["BIGWIGS_FLASHING_DOOR_SPAWN"] = "閃爍大門在裡頭現形" 
    DFCNL["BIGWIGS_FLASHING_DOOR_COMPLETE"] = "探究通關後出現"
    DFCNL["FLASHING_DOOR_USED"] = "已使用"
    DFCNL["BRANN_ROLE"] = "戰鬥角色"
    DFCNL["COMBAT_TRINKET"] = "戰鬥珍品"
    DFCNL["UTILITY_TRINKET"] = "通用珍品"
    DFCNL["NOT_SET"] = "未設定"
    DFCNL["MAP"] = "地圖"
    DFCNL["DELVE"] = "探究"
    DFCNL["SPECIAL_DELVE_NAME"] = "虛無剃刀庇護所"
    DFCNL["STORY_VARIANT"] = "故事變化"
    DFCNL["STORY_VARIANT_PATTERN"] = "故事變化：%s*(.+)"
    DFCNL["GOLDEN_CREST_PATTERN"] = "鍍金.-紋章"
    DFCNL["SPECIAL_FOOTBOMB_TREASURE"] = "受損的足球炸彈自動發射器"
    DFCNL["UNKNOWN_MAP"] = "未知地圖"
    DFCNL["UNKNOWN"] = "未知"
    DFCNL["DELVE_SCENARIO_NAME"] = "探究"
    DFCNL["BACKGROUND_TRANSPARENCY"] = "背景透明度"
    DFCNL["CLICK_TO_EXIT"] = "點擊立刻離開探究"
    DFCNL["BANK_STATUS"] = "銀行狀態"
    DFCNL["BANK_AVAILABLE"] = "目前該角色可正常訪問戰隊銀行"
    DFCNL["BANK_UNAVAILABLE"] = "目前該角色無法訪問戰隊銀行，請勿使用戰隊銀行技能！"
    DFCNL["DWARVEN_MEDICINE"] = "矮人藥品"
    DFCNL["STACKS"] = "層"
    DFCNL["ENABLED"] = "開啟"
    DFCNL["DISABLED"] = "關閉"
    DFCNL["SETTINGS_TITLE"] = "助手設定"
    DFCNL["AUTO_ENTER"] = "自動進入探究"
    DFCNL["AUTO_ACTIVATE"] = "自動與NPC對話"
    DFCNL["SHOW_SCOREBOARD"] = "顯示探究記分板"
    DFCNL["TREASURE_MAP_ALERT"] = "自動檢測藏寶圖"
    DFCNL["AUTO_PET_CAGE"] = "自動裝籠戰鬥寵物"
    DFCNL["AUTO_TOKEN_EXCHANGE"] = "自動確認兌換紋章"
    DFCNL["DIFFICULTY_LABEL"] = "難度："
    DFCNL["FAST_EXIT_MODE"] = "速刷模式"
    DFCNL["VIEW_MERCHANT"] = "查看探究商人"
    DFCNL["VIEW_DELVE_INFO"] = "查看探究資訊"
    DFCNL["CLOSE"] = "關閉"
    DFCNL["DIFFICULTY_LEVEL_FORMAT"] = "難度 %d"
    DFCNL["SPECIAL_DIFFICULTY_PATTERN"] = "級別%?"
    DFCNL["SELECT_BUTTON_PATTERN"] = "選擇"
    DFCNL["REMAINING_ENEMIES_PATTERN"] = "剩餘敵群"
    DFCNL["ENCHANTED_ITEM_PATTERN"] = "附魔"
    DFCNL["MATRIX_ITEM_PATTERN"] = "矩陣"
    DFCNL["CREST_PATTERN"] = "紋章"
    DFCNL["INFO"] = "資訊"
    DFCNL["WARNING"] = "警告"
    DFCNL["NOTICE"] = "注意"
    DFCNL["SETTING_CHANGED"] = "設定修改"
    DFCNL["AUTO_ENTER_ENABLED"] = "自動進入探究功能已啟用"
    DFCNL["AUTO_ENTER_DISABLED"] = "自動進入探究功能已禁用"
    DFCNL["FAST_EXIT_ENABLED"] = "速刷模式模式已啟用，現在進出探究無CD"
    DFCNL["FAST_EXIT_DISABLED"] = "速刷模式已禁用，離開探究5秒後才再次觸發自動進入"
    DFCNL["DIFFICULTY_SET"] = "已設定自動選擇難度級別為 %d"
    DFCNL["DIFFICULTY_UNSET"] = "已關閉自動選擇難度級別，自動進入探究功能已禁用"
    DFCNL["SCOREBOARD_ENABLED"] = "探究記分板已啟用，進入探究後自動顯示記分板"
    DFCNL["SCOREBOARD_DISABLED"] = "探究記分板功能已禁用"
    DFCNL["TREASURE_MAP_ENABLED"] = "自動檢測藏寶圖功能已啟用"
    DFCNL["TREASURE_MAP_DISABLED"] = "自動檢測藏寶圖功能已禁用"
    DFCNL["AUTO_ACTIVATE_ENABLED"] = "自動與NPC對話功能已啟用"
    DFCNL["AUTO_ACTIVATE_DISABLED"] = "自動與NPC對話功能已禁用"
    DFCNL["AUTO_PET_CAGE_ENABLED"] = "自動裝籠戰鬥寵物功能已啟用"
    DFCNL["AUTO_PET_CAGE_DISABLED"] = "自動裝籠戰鬥寵物功能已禁用"
    DFCNL["AUTO_TOKEN_EXCHANGE_ENABLED"] = "自動確認兌換紋章功能已啟用，僅自動確認45低級紋章換15高級紋章。"
    DFCNL["AUTO_TOKEN_EXCHANGE_DISABLED"] = "自動確認兌換紋章功能已禁用"
    DFCNL["SPECIAL_DELVE_WARNING"] = "目前為特殊探究，自動進入已取消"
    DFCNL["AUTO_ENTER_MESSAGE"] = "自動進入探究：%s（級別%d）"
    DFCNL["SELECT_DIFFICULTY_WARNING"] = "請先在設定中選擇自動進入的難度級別"
    DFCNL["TOKEN_EXCHANGE_CONFIRMED"] = "自動確認紋章兌換"
    DFCNL["ADVANCED_TOKEN_WARNING"] = "你正在使用高級紋章兌換低級紋章，請謹慎操作！"
    DFCNL["PET_CAGED"] = "已自動裝籠，請再次使用該寵物以加入寵物手冊"
    DFCNL["PET_NOT_FOUND"] = "未找到裝籠的戰鬥寵物，請手動裝籠"
    DFCNL["PET_CAGE_ERROR"] = "寵物自動裝籠遇到未知錯誤，請手動裝籠"
    DFCNL["NPC_MARKED"] = "已自動標記需救助的NPC"
    DFCNL["BRANN_CONFIG_UPDATED"] = "布萊恩·銅鬚配置已更新"
    DFCNL["MINIMAP_SHOWN"] = "小地圖圖標已顯示"
    DFCNL["MINIMAP_HIDDEN"] = "小地圖圖標已隱藏"
    DFCNL["ADDON_DESCRIPTION"] = "|cff33ff99[便捷]|r探究助手"
    DFCNL["TOOLTIP_LEFT_CLICK"] = "左鍵: 打開/關閉設定面板"
    DFCNL["TOOLTIP_COMMAND"] = "巨集指令: /dfcndelve"
    DFCNL["TOOLTIP_MINIMAP"] = "小地圖圖標: /dfcndelve minimap on/off"
    DFCNL["TOOLTIP_ESC"] = "面板打開時按ESC可關閉"
    DFCNL["AUTO_ENTER_TOOLTIP"] = "自動進入探究"
    DFCNL["AUTO_ENTER_TOOLTIP_DETAIL1"] = "靠近探究入口時，自動進入預設級別的探究"
    DFCNL["AUTO_ENTER_TOOLTIP_DETAIL2"] = "速刷模式關閉時，離開探究不會馬上再次進入（5S CD）"
    DFCNL["FAST_EXIT_TOOLTIP"] = "速刷模式"
    DFCNL["FAST_EXIT_TOOLTIP_DETAIL1"] = "退出探究後立刻進入探究（0S CD）"
    DFCNL["FAST_EXIT_TOOLTIP_DETAIL2"] = "推薦僅在需要快速反復進出相同探究時才打開"
    DFCNL["SCOREBOARD_TOOLTIP"] = "顯示探究記分板"
    DFCNL["SCOREBOARD_TOOLTIP_DETAIL1"] = "進入探究後，會自動顯示記分板"
    DFCNL["SCOREBOARD_TOOLTIP_DETAIL2"] = "面板的U/L標識鎖定和未鎖定狀態T為透明度調節"
    DFCNL["SCOREBOARD_TOOLTIP_DETAIL3"] = "離開探究後，記分板會自動關閉"
    DFCNL["TREASURE_MAP_TOOLTIP"] = "自動檢測藏寶圖"
    DFCNL["TREASURE_MAP_TOOLTIP_DETAIL1"] = "當獲取到探究藏寶圖後自動提醒使用"
    DFCNL["TREASURE_MAP_TOOLTIP_DETAIL2"] = "非11級探究使用自動提醒探究級別錯誤"
    DFCNL["AUTO_ACTIVATE_TOOLTIP"] = "自動與NPC對話"
    DFCNL["AUTO_ACTIVATE_TOOLTIP_DETAIL1"] = "鼠標右鍵點擊NPC或物品時"
    DFCNL["AUTO_ACTIVATE_TOOLTIP_DETAIL2"] = "會自動選擇對話項推動探究進程"
    DFCNL["AUTO_PET_CAGE_TOOLTIP"] = "自動裝籠戰鬥寵物"
    DFCNL["AUTO_PET_CAGE_TOOLTIP_DETAIL1"] = "可直接鼠標右鍵使用戰鬥小寵物"
    DFCNL["AUTO_PET_CAGE_TOOLTIP_DETAIL2"] = "如果系統提示無法獲取更多該類寵物，則自動裝籠該寵物"
    DFCNL["AUTO_PET_CAGE_TOOLTIP_DETAIL3"] = "由於遊戲限制，自動裝籠後仍需再次手動使用該寵物加入寵物手冊"
    DFCNL["AUTO_TOKEN_EXCHANGE_TOOLTIP"] = "自動確認兌換紋章"
    DFCNL["AUTO_TOKEN_EXCHANGE_TOOLTIP_DETAIL1"] = "45個低級紋章兌換15個高級紋章自動確認"
    DFCNL["AUTO_TOKEN_EXCHANGE_TOOLTIP_DETAIL2"] = "15個高級紋章兌換15個低級紋章提醒警告"
    DFCNL["GOLDEN_CACHE_WARNING"] = "注意：鎏金紋章尚未全部拾取！"
    DFCNL["TREASURE_BUFF_WRONG_LEVEL"] = "注意：藏寶圖已激活，目前不是11級探究！"
    DFCNL["TREASURE_MAP_REMINDER"] = "注意：請使用背包中的探究藏寶圖！"
    DFCNL["NGA_RECOMMENDED_STORY"] = "NGA地堡俠推薦故事"
    DFCNL["NGA_RECOMMENDED_DETAIL"] = "本故事變化難度簡單適合速刷"
    DFCNL["BRANN_SAYS"] = "布萊恩·銅鬚說："
    DFCNL["BRANN_GOLDEN_CACHE_ALERT"] = "藏寶室裡有鎏金紋章，你可瞅仔細啦！"
    DFCNL["BRANN_TREASURE_WARNING"] = "清醒一點，老兄！這裡不是十一級探究，你確認要在這裡使用藏寶圖嗎？"
    DFCNL["BRANN_TREASURE_REMINDER"] = "你包裡是探究藏寶圖嗎？你可千萬別忘記使用它。"
    DFCNL["BRANN_FLASHING_DOOR"] = "閃爍之門？讓我們趕緊去探索吧！"
    DFCNL["BRANN_FOOTBOMB"] = "這真是好東西，炸彈足球！讓我也來踢一腳。"
    DFCNL["BRANN_GOLDEN_CREST"] = "鎏金紋章都進了你的背包，這下我就放心了。"
    DFCNL["LEAVE_FOLLOWER_DIFFICULTY"] = "已自動退隊離開破晨號（追隨者難度）"
    DFCNL["DRILL_TO_ANDERMORE"] = "已自動搭乘鑽機前往安德麥"
    DFCNL["DRILL_TO_NOISY_CAVERN"] = "已自動搭乘鑽機前往喧鳴深窟"
    DFCNL["DRILL_TO_ZULDAZAR"] = "已自動搭乘鑽機前往祖達薩"
    DFCNL["UNKNOWN_TREASURE"] = "未知珍品"
    DFCNL["RETRY_COUNT"] = "重試：%d/3"
    DFCNL["ADDON_LOADED"] = "探究助手已加載"
    DFCNL["ADDON_STATUS"] = "自動進入: %s | 難度級別: %s | 速刷模式: %s"
    DFCNL["AUTO_NPC_INTERACTION"] = "自動與NPC對話: %s"
    DFCNL["AUTO_SELECT_TREASURE"] = "自動選擇珍品寶藏：%s"
    DFCNL["REFRESH_TIME"] = "7:00刷新"
    DFCNL["CURRENT_DATE"] = "目前：%02d-%02d"
    DFCNL["UNKNOWN_ITEM"] = "未知物品"
    DFCNL["UNKNOWN_DELVE"] = "未知探究"
    DFCNL["SLASH_COMMAND"] = "/dfcndelve - 打開設定面板"
    DFCNL["SLASH_MINIMAP_ON"] = "/dfcndelve minimap on - 顯示小地圖圖標"
    DFCNL["SLASH_MINIMAP_OFF"] = "/dfcndelve minimap off - 隱藏小地圖圖標"
    DFCNL["MINIMAP_CHECKBOX"] = "顯示小地圖圖標"
    DFCNL["OPEN_SETTINGS"] = "打開助手設定面板"
    DFCNL["CLOSE_SETTINGS"] = "關閉助手設定面板"
    DFCNL["COMMAND_TIP"] = "巨集指令: /dfcndelve"
    DFCNL["DOWNLOAD_LABEL"] = "原始發布地址："
    DFCNL["COPY_TIP"] = "點擊選中網址，按Ctrl+C複製"
    DFCNL["TIME_FORMAT_COMPLETED_HMS"] = "%d:%02d:%02d（已完成）"
    DFCNL["TIME_FORMAT_COMPLETED_MS"] = "%02d:%02d（已完成）";
else
    --This text has been translated by AI:DeepSeek
    DFCNL["SCOREBOARD_TITLE"] = "Dashboard"
    DFCNL["SCENARIO"] = "Scenario"
    DFCNL["DIFFICULTY_LEVEL"] = "Tier"
    DFCNL["REMAINING_LIVES"] = "Lives Remaining"
    DFCNL["REMAINING_ENEMIES"] = "Enemy Groups"
    DFCNL["TOTAL_TIME"] = "Total Time"
    DFCNL["FLASHING_DOOR"] = "Flickergate"
    DFCNL["BIGWIGS_FLASHING_DOOR_SPAWN"] = "A Flickergate Has Manifested Within"
    DFCNL["BIGWIGS_FLASHING_DOOR_COMPLETE"] = "Flickering Spoils Will Manifest Upon Delve Completion"
    DFCNL["FLASHING_DOOR_USED"] = "Used"
    DFCNL["BRANN_ROLE"] = "Brann's Role"
    DFCNL["COMBAT_TRINKET"] = "Combat Curio"
    DFCNL["UTILITY_TRINKET"] = "Utility Curio"
    DFCNL["NOT_SET"] = "Not Set"
    DFCNL["MAP"] = "Map"
    DFCNL["DELVE"] = "Delve"
    DFCNL["SPECIAL_DELVE_NAME"] = "Voidrazor Sanctuary"
    DFCNL["STORY_VARIANT"] = "Story Variant"
    DFCNL["STORY_VARIANT_PATTERN"] = "Story Variant:%s*(.+)"
    DFCNL["GOLDEN_CREST_PATTERN"] = "Gilded.-Crest"
    DFCNL["SPECIAL_FOOTBOMB_TREASURE"] = "Damaged Automatic Footbomb Dispenser"
    DFCNL["UNKNOWN_MAP"] = "Unknown Map"
    DFCNL["UNKNOWN"] = "Unknown"
    DFCNL["DELVE_SCENARIO_NAME"] = "Delves"
    DFCNL["BACKGROUND_TRANSPARENCY"] = "Background Transparency"
    DFCNL["CLICK_TO_EXIT"] = "Click to exit delve immediately"
    DFCNL["BANK_STATUS"] = "Warband Bank Status"
    DFCNL["BANK_AVAILABLE"] = "Warband Bank access available"
    DFCNL["BANK_UNAVAILABLE"] = "Warband Bank unavailable - do not use Warband Bank skills!"
    DFCNL["DWARVEN_MEDICINE"] = "Dwarven Medicine"
    DFCNL["STACKS"] = "Stacks"
    DFCNL["ENABLED"] = "Enabled"
    DFCNL["DISABLED"] = "Disabled"
    DFCNL["SETTINGS_TITLE"] = "Settings"
    DFCNL["AUTO_ENTER"] = "Auto-Enter Delves"
    DFCNL["AUTO_ACTIVATE"] = "Auto-Interact"
    DFCNL["SHOW_SCOREBOARD"] = "Delves Dashboard"
    DFCNL["TREASURE_MAP_ALERT"] = "Bounty Monitoring"
    DFCNL["AUTO_PET_CAGE"] = "Auto-Cage Battle Pets"
    DFCNL["AUTO_TOKEN_EXCHANGE"] = "Crest Conversion"
    DFCNL["DIFFICULTY_LABEL"] = "Tier:"
    DFCNL["FAST_EXIT_MODE"] = "Rush Mode"
    DFCNL["VIEW_MERCHANT"] = "View Delves Merchant"
    DFCNL["VIEW_DELVE_INFO"] = "View Delves Info"
    DFCNL["CLOSE"] = "Close"
    DFCNL["DIFFICULTY_LEVEL_FORMAT"] = "Tier %d"
    DFCNL["SPECIAL_DIFFICULTY_PATTERN"] = "Tier %?"
    DFCNL["SELECT_BUTTON_PATTERN"] = "Choose"
    DFCNL["REMAINING_ENEMIES_PATTERN"] = "Enemy groups remaining"
    DFCNL["ENCHANTED_ITEM_PATTERN"] = "Enchanted"
    DFCNL["MATRIX_ITEM_PATTERN"] = "Matrix"
    DFCNL["CREST_PATTERN"] = "Crest"
    DFCNL["INFO"] = "Info"
    DFCNL["WARNING"] = "Warning"
    DFCNL["NOTICE"] = "Notice"
    DFCNL["SETTING_CHANGED"] = "Setting Updated"
    DFCNL["AUTO_ENTER_ENABLED"] = "Auto-enter delves enabled"
    DFCNL["AUTO_ENTER_DISABLED"] = "Auto-enter delves disabled"
    DFCNL["FAST_EXIT_ENABLED"] = "Rush Mode enabled: No cooldown when entering/exiting delve"
    DFCNL["FAST_EXIT_DISABLED"] = "Rush Mode disabled: 5s cooldown before auto-reentering"
    DFCNL["DIFFICULTY_SET"] = "Auto-select tier set to %d"
    DFCNL["DIFFICULTY_UNSET"] = "Auto-select tier disabled - auto-enter disabled"
    DFCNL["SCOREBOARD_ENABLED"] = "Delves dashboard enabled - will automatically show when entering delves"
    DFCNL["SCOREBOARD_DISABLED"] = "Delves dashboard disabled"
    DFCNL["TREASURE_MAP_ENABLED"] = "Bounty monitoring enabled"
    DFCNL["TREASURE_MAP_DISABLED"] = "Bounty monitoring disabled"
    DFCNL["AUTO_ACTIVATE_ENABLED"] = "Auto-interact enabled"
    DFCNL["AUTO_ACTIVATE_DISABLED"] = "Auto-interact disabled"
    DFCNL["AUTO_PET_CAGE_ENABLED"] = "Auto-cage battle pets enabled"
    DFCNL["AUTO_PET_CAGE_DISABLED"] = "Auto-cage battle pets disabled"
    DFCNL["AUTO_TOKEN_EXCHANGE_ENABLED"] = "Crest conversion enabled (45 low-level -> 15 high-level crests only)"
    DFCNL["AUTO_TOKEN_EXCHANGE_DISABLED"] = "Crest conversion disabled"
    DFCNL["SPECIAL_DELVE_WARNING"] = "Special delve detected - auto-enter cancelled"
    DFCNL["AUTO_ENTER_MESSAGE"] = "Auto-entering: %s (Tier %d)"
    DFCNL["SELECT_DIFFICULTY_WARNING"] = "Please set auto-enter tier in settings first"
    DFCNL["TOKEN_EXCHANGE_CONFIRMED"] = "Crest exchange auto-confirmed"
    DFCNL["ADVANCED_TOKEN_WARNING"] = "Warning: Exchanging advanced crests for lower-tier crests!"
    DFCNL["PET_CAGED"] = "has been caged - use again to add to journal"
    DFCNL["PET_NOT_FOUND"] = "Battle pet not found - please cage manually"
    DFCNL["PET_CAGE_ERROR"] = "Auto-cage error - please cage manually"
    DFCNL["NPC_MARKED"] = "Auto-marked rescue target"
    DFCNL["BRANN_CONFIG_UPDATED"] = "Brann Bronzebeard configuration updated"
    DFCNL["MINIMAP_SHOWN"] = "Minimap icon shown"
    DFCNL["MINIMAP_HIDDEN"] = "Minimap icon hidden"
    DFCNL["ADDON_DESCRIPTION"] = "Delves Helper"
    DFCNL["TOOLTIP_LEFT_CLICK"] = "Left Click: Open/Close Settings"
    DFCNL["TOOLTIP_COMMAND"] = "Macro: /dfcndelve"
    DFCNL["TOOLTIP_MINIMAP"] = "Minimap: /dfcndelve minimap on/off"
    DFCNL["TOOLTIP_ESC"] = "ESC: Close Panel"
    DFCNL["AUTO_ENTER_TOOLTIP"] = "Auto-Enter Delves"
    DFCNL["AUTO_ENTER_TOOLTIP_DETAIL1"] = "Automatically enter delves at preset tier when approaching entrance"
    DFCNL["AUTO_ENTER_TOOLTIP_DETAIL2"] = "Without Rush Mode: 5s cooldown after leaving delve"
    DFCNL["FAST_EXIT_TOOLTIP"] = "Rush Mode"
    DFCNL["FAST_EXIT_TOOLTIP_DETAIL1"] = "Instantly re-enter delves after exiting (no cooldown)"
    DFCNL["FAST_EXIT_TOOLTIP_DETAIL2"] = "Recommended for farming the same delve repeatedly"
    DFCNL["SCOREBOARD_TOOLTIP"] = "Delves Dashboard"
    DFCNL["SCOREBOARD_TOOLTIP_DETAIL1"] = "Show dashboard when entering delves"
    DFCNL["SCOREBOARD_TOOLTIP_DETAIL2"] = "U/L: Lock/Unlock | T: Adjust transparency"
    DFCNL["SCOREBOARD_TOOLTIP_DETAIL3"] = "Panel auto-closes when leaving delves"
    DFCNL["TREASURE_MAP_TOOLTIP"] = "Bounty Monitoring"
    DFCNL["TREASURE_MAP_TOOLTIP_DETAIL1"] = "Auto-remind to use Delver's Bounty when obtained"
    DFCNL["TREASURE_MAP_TOOLTIP_DETAIL2"] = "Warn if used in non-Tier 11 delves"
    DFCNL["AUTO_ACTIVATE_TOOLTIP"] = "Auto-Interact"
    DFCNL["AUTO_ACTIVATE_TOOLTIP_DETAIL1"] = "When right-clicking NPCs or objects"
    DFCNL["AUTO_ACTIVATE_TOOLTIP_DETAIL2"] = "Automatically select dialogue options to advance delve progress"
    DFCNL["AUTO_PET_CAGE_TOOLTIP"] = "Auto-Cage Battle Pets"
    DFCNL["AUTO_PET_CAGE_TOOLTIP_DETAIL1"] = "Right-click to use battle pets directly"
    DFCNL["AUTO_PET_CAGE_TOOLTIP_DETAIL2"] = "Auto-cage pets when system indicates maximum capacity"
    DFCNL["AUTO_PET_CAGE_TOOLTIP_DETAIL3"] = "Note: After auto-caging manually reuse pet to add to journal"
    DFCNL["AUTO_TOKEN_EXCHANGE_TOOLTIP"] = "Crest Conversion"
    DFCNL["AUTO_TOKEN_EXCHANGE_TOOLTIP_DETAIL1"] = "Auto-confirm 45 low-level -> 15 high-level crest exchange"
    DFCNL["AUTO_TOKEN_EXCHANGE_TOOLTIP_DETAIL2"] = "Warns against exchanging 15 high-level -> 15 low-level crests"
    DFCNL["GOLDEN_CACHE_WARNING"] = "Notice: Gilded Crests remaining!"
    DFCNL["TREASURE_BUFF_WRONG_LEVEL"] = "Notice: Delver's Bounty active but this is not Tier 11!"
    DFCNL["TREASURE_MAP_REMINDER"] = "Notice: Use the Delver's Bounty in your bags!"
    DFCNL["NGA_RECOMMENDED_STORY"] = "NGACN Presents: Delves Defender's Picks"
    DFCNL["NGA_RECOMMENDED_DETAIL"] = "Simple difficulty - ideal for speed running"
    DFCNL["BRANN_SAYS"] = "Brann Bronzebeard says:"
    DFCNL["BRANN_GOLDEN_CACHE_ALERT"] = " Gilded Crests in the treasure room! Keep your eyes peeled lad!"
    DFCNL["BRANN_TREASURE_WARNING"] = " By my beard! This isn't Tier 11! You sure you want to waste that Delver's Bounty here?"
    DFCNL["BRANN_TREASURE_REMINDER"] = " You've got a Delver's Bounty in your pack! Don't let it gather dust!"
    DFCNL["BRANN_FLASHING_DOOR"] = " A Flickergate! Let's see where this leads quickly now!"
    DFCNL["BRANN_FOOTBOMB"] = " By my beard! Only goblins would make football explosive! Magnificent! Let me have a boot at it!"
    DFCNL["BRANN_GOLDEN_CREST"] = " All Gilded Crests accounted for! That's a weight off my mind."
    DFCNL["LEAVE_FOLLOWER_DIFFICULTY"] = "Auto-left party and The Dawnbreaker (Follower Dungeons)"
    DFCNL["DRILL_TO_ANDERMORE"] = "Took drill to Undermine"
    DFCNL["DRILL_TO_NOISY_CAVERN"] = "Took drill to Ringing Deeps"
    DFCNL["DRILL_TO_ZULDAZAR"] = "Took drill to Zuldazar"
    DFCNL["UNKNOWN_TREASURE"] = "Unknown Treasure"
    DFCNL["RETRY_COUNT"] = "Retry: %d/3"
    DFCNL["ADDON_LOADED"] = "Delves Helper loaded"
    DFCNL["ADDON_STATUS"] = "Auto-Enter: %s | Tier: %s | Rush Mode: %s"
    DFCNL["AUTO_NPC_INTERACTION"] = "Auto NPC interaction: %s"
    DFCNL["AUTO_SELECT_TREASURE"] = "Auto select treasure: %s"
    DFCNL["REFRESH_TIME"] = "7:00 reset"
    DFCNL["CURRENT_DATE"] = "Current: %02d-%02d"
    DFCNL["UNKNOWN_ITEM"] = "Unknown Item"
    DFCNL["UNKNOWN_DELVE"] = "Unknown Delve"
    DFCNL["SLASH_COMMAND"] = "/dfcndelve - Open settings"
    DFCNL["SLASH_MINIMAP_ON"] = "/dfcndelve minimap on - Show minimap icon"
    DFCNL["SLASH_MINIMAP_OFF"] = "/dfcndelve minimap off - Hide minimap icon"
    DFCNL["MINIMAP_CHECKBOX"] = "Show Minimap Icon"
    DFCNL["OPEN_SETTINGS"] = "Open Settings"
    DFCNL["CLOSE_SETTINGS"] = "Close Settings"
    DFCNL["COMMAND_TIP"] = "Macro: /dfcndelve"
    DFCNL["DOWNLOAD_LABEL"] = "Original Release:"
    DFCNL["COPY_TIP"] = "Click to select Ctrl+C to copy"
    DFCNL["TIME_FORMAT_COMPLETED_HMS"] = "%d:%02d:%02d (Completed)"
    DFCNL["TIME_FORMAT_COMPLETED_MS"] = "%02d:%02d (Completed)";
end
local DFCN =  {
    version = "1.65",
    scoreboardUpdateTimer = nil,
    isAbundant = nil,
    delveTimer = nil,
    delveStartServerTime = nil,
    delveCompleted = false,
    delveCompletionTime = nil,
    showScoreboardTimer = nil,
    treasureMapAlert = nil,
    inDelveWithMap = false,
    checkTreasureMapPending = false,
    treasureBuffAlert = nil,
    lastTreasureBuffState = nil,
    medicineBar = nil,
    medicineUpdateTimer = nil,
    playerChoiceUpdateTimer = nil,
    expectingCinematic = false,
    cinematicTimer = nil,
    playerChoiceTicker = nil,
    periodicUpdateTimer = nil,
    flashingDoorCheckTimer = nil,
    flashingDoorActivated = nil,
    lastBrannSetup = nil,
    merchantFrame = nil,
    goldenCacheStatus = nil,
    goldenPickupCount = 0,
    requireTwoPickups = false,
    brannConfigID = nil,
    targetNPCs = {219718},
    mouseoverFrame = nil,
    lastUsedMark = 0,
}

DFCN_DelveHelperDB = DFCN_DelveHelperDB or {
    autoEnter = true,
    autoActivateDelve = true,
    difficultyLevel = 11,
    scoreboardEnabled = true,
    treasureMapAlertEnabled = true,
    scoreboardLocked = false,
    scoreboardPosition = nil,
    minimapIcon = {},
    minimapIconShown = true,
    characters = {},
    goldenCacheAlertShown = false,
    exitCooldown = false,
    exitTime = 0,
    fastExitMode = false,
    backgroundAlpha = 0.4,
    autoTokenExchange = true,
    autoPetCage = true,
}

local AUTO_CONFIRM_NPC_IDS = {
    [223594] = {
        gossipOptionID = 124142,
        checkInstance = true,
        difficultyID = 205,
        leaveParty = true,
        printText = string.format("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[%s] %s|r", DFCNL["INFO"], DFCNL["LEAVE_FOLLOWER_DIFFICULTY"])
    },
    [229022] = {
        gossipOptionID = 125434,
        checkInstance = false,
        printText = string.format("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[%s] %s|r", DFCNL["INFO"], DFCNL["DRILL_TO_ANDERMORE"])
    },
    [233626] = {
        gossipOptionID = 125433,
        checkInstance = false,
        printText = string.format("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[%s] %s|r", DFCNL["INFO"], DFCNL["DRILL_TO_NOISY_CAVERN"])
    },
    [233719] = {
        gossipOptionID = 125429,
        checkInstance = false,
        printText = string.format("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[%s] %s|r", DFCNL["INFO"], DFCNL["DRILL_TO_ANDERMORE"])
    },
    [233625] = {
        gossipOptionID = 125409,
        checkInstance = false,
        printText = string.format("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[%s] %s|r", DFCNL["INFO"], DFCNL["DRILL_TO_ZULDAZAR"])
    }
}

local MERCHANT_ITEMS = {
    {itemID = 238386, schedule = {2, 3}, offset = 0, suffix = "::::::::80:66::110:4:6652:12355:1582:10255:1:28:2462:::::"},
    {itemID = 238390, schedule = {2, 3}, offset = 2, suffix = "::::::::80:66::110:4:6652:12355:1582:10255:1:28:2462:::::"},
    {itemID = 240213, schedule = {3, 2}, offset = 1, suffix = "::::::::80:66::110:4:6652:12355:3239:10255:1:28:2462:::::"},
    {itemID = 242867, schedule = {3, 2}, offset = 1, suffix = "::::::::80:66::110:4:6652:12355:1572:10255:1:28:2462:::::"},
    {itemID = 246824, schedule = {1}, offset = 0, suffix = "::::::::80:66::110:4:6652:12355:1572:10255:1:28:2462:::::"},
    {itemID = 246825, schedule = {1}, offset = 0, suffix = "::::::::80:66::110:4:6652:12355:1572:10255:1:28:2462:::::"},
    {itemID = 246939, schedule = {3, 2}, offset = 0, suffix = "::::::::80:66::110:4:6652:12355:1572:10255:1:28:2462:::::"},
    {itemID = 246940, schedule = {3, 2}, offset = 1, suffix = "::::::::80:66::110:4:6652:12355:1572:10255:1:28:2462:::::"},
    {itemID = 246941, schedule = {3, 2}, offset = 0, suffix = "::::::::80:66::110:4:6652:12355:1572:10255:1:28:2462:::::"},
    {itemID = 246944, schedule = {3, 2}, offset = 0, suffix = "::::::::80:66::110:4:6652:12355:1572:10255:1:28:2462:::::"},
    {itemID = 246945, schedule = {2, 3}, offset = 1, suffix = "::::::::80:66::110:4:6652:12355:1572:10255:1:28:2462:::::"},
    {itemID = 246947, schedule = {3, 2}, offset = 0, suffix = "::::::::80:66::110:4:6652:12355:1572:10255:1:28:2462:::::"}
}

local function GetLocalizedDate(day, month)
    local locale = GetLocale()
    if locale == "zhCN" or locale == "zhTW" then
        return format("%02d-%02d", month, day)
    else
        return format("%02d-%02d", day, month)
    end
end

local function IsInDelvesScenario()
    local scenarioName = select(1, C_Scenario.GetInfo())
    return scenarioName == DFCNL["DELVE_SCENARIO_NAME"]
end

local function GetCharacterKey()
    local realm = GetRealmName()
    local name = UnitName("player")
    return realm .. "-" .. name
end

function DFCN.GetGoldenCacheStatus()
    local widgetInfo = C_UIWidgetManager.GetSpellDisplayVisualizationInfo(6659)
    
    if widgetInfo and widgetInfo.spellInfo and widgetInfo.spellInfo.tooltip then
        local tooltipText = widgetInfo.spellInfo.tooltip
        local currentCount = tonumber(string.match(tooltipText, "(%d)/3"))
        
        if currentCount then
            return currentCount .. "/3"
        end
    end
    
    return nil
end

function DFCN.BrannSay(message)
    local fullMessage = DFCNL["BRANN_SAYS"] .. message
    local color = { r = 1.0, g = 1.0, b = 0.62 }
    DEFAULT_CHAT_FRAME:AddMessage(fullMessage, color.r, color.g, color.b)
end

function DFCN.CheckGoldenCacheStatus()
    local key = GetCharacterKey()
    DFCN_DelveHelperDB.characters[key] = DFCN_DelveHelperDB.characters[key] or {}
    local charData = DFCN_DelveHelperDB.characters[key]
    
    local status = DFCN.GetGoldenCacheStatus()
    if status then
        charData.goldenCacheStatus = status
		charData.goldenCacheStatusTime = time()
        DFCN.goldenCacheStatus = status
		DFCN.goldenCacheStatusTime = charData.goldenCacheStatusTime 
    else
        DFCN.goldenCacheStatus = charData.goldenCacheStatus or "3/3"
		DFCN.goldenCacheStatusTime = charData.goldenCacheStatusTime
    end
end

function DFCN.PlayCustomSound(filename)
    local filePath = "Interface\\AddOns\\OrzUI\\ShiGuang\\Sounds\\"..filename
    
    if DFCN.currentSoundHandle then
        StopSound(DFCN.currentSoundHandle)
        DFCN.currentSoundHandle = nil
    end
    
    local willPlay, soundHandle = PlaySoundFile(filePath, "Master")
    if willPlay and soundHandle then
        DFCN.currentSoundHandle = soundHandle
    end
end

function DFCN.ShowGoldenCacheAlert()
    local key = GetCharacterKey()
    DFCN_DelveHelperDB.characters[key] = DFCN_DelveHelperDB.characters[key] or {}
    local charData = DFCN_DelveHelperDB.characters[key]
    if charData.goldenCacheAlertShown then
        return
    end
    charData.goldenCacheAlertShown = true
    
    if not DFCN.goldenCacheAlert then
        local alert = CreateFrame("Frame", nil, UIParent)
        alert:SetSize(600, 100)
        alert:SetPoint("CENTER", 0, 300)
        alert:SetFrameStrata("FULLSCREEN_DIALOG")
        
        alert.text = alert:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        alert.text:SetPoint("CENTER")
        alert.text:SetText("|T5872049:14:14|t |cFFFF0000" .. DFCNL["GOLDEN_CACHE_WARNING"] .. "|r")
        
        alert:Hide()
        DFCN.goldenCacheAlert = alert
        
        local originalShow = alert.Show
        alert.Show = function(self, ...)
            originalShow(self, ...)
            DFCN.goldenCacheAlertTimer = C_Timer.NewTimer(12, function()
                DFCN.goldenCacheAlertTimer = nil
                DFCN.PlayCustomSound("goldenCacheAlert.ogg")
                DFCN.BrannSay(DFCNL["BRANN_GOLDEN_CACHE_ALERT"])
            end)
        end
    end
    
    DFCN.goldenCacheAlert:Show()
end

function DFCN.HideGoldenCacheAlert()
    local key = GetCharacterKey()
    local charData = DFCN_DelveHelperDB.characters[key]
    if charData then
        charData.goldenCacheAlertShown = false
    end

    if DFCN.goldenCacheAlertTimer then
        DFCN.goldenCacheAlertTimer:Cancel()
        DFCN.goldenCacheAlertTimer = nil
    end

    if DFCN.goldenCacheAlert then
        DFCN.goldenCacheAlert:Hide()
    end
end

local function GetMerchantItemsForDate(targetDate)
    local nowTime = time(targetDate)
    
    local refreshHour = 7
    local isBeforeRefresh = (targetDate.hour < refreshHour)
    
    local lastRefreshTime
    if isBeforeRefresh then
        lastRefreshTime = nowTime - (targetDate.hour * 3600 + targetDate.min * 60 + targetDate.sec) - (24 - refreshHour) * 3600
    else
        lastRefreshTime = nowTime - ((targetDate.hour - refreshHour) * 3600 + targetDate.min * 60 + targetDate.sec)
    end

    local baseDate = time({year=2025, month=8, day=16, hour=7, min=0, sec=0})
    local daysDiff = floor((lastRefreshTime - baseDate) / 86400)
    
    local availableItems = {}
    
    for _, item in ipairs(MERCHANT_ITEMS) do
        local adjustedDaysDiff = daysDiff - item.offset
        if adjustedDaysDiff >= 0 then
            local totalDays = 0
            for _, days in ipairs(item.schedule) do
                totalDays = totalDays + days
            end
            
            if totalDays > 0 then
                local cyclePosition = adjustedDaysDiff % totalDays
                local cumulativeDays = 0
                local isAvailable = false
                
                if cyclePosition == 0 then
                    isAvailable = true
                else
                    for i, days in ipairs(item.schedule) do
                        cumulativeDays = cumulativeDays + days
                        if cyclePosition == cumulativeDays then
                            isAvailable = true
                            break
                        end
                        if cyclePosition < cumulativeDays then
                            break
                        end
                    end
                end
                
                if isAvailable then
                    table.insert(availableItems, item)
                end
            else
                table.insert(availableItems, item)
            end
        end
    end
    
    return availableItems
end

local function UpdateExitCooldownDuration()
    DFCN.exitCooldownDuration = DFCN_DelveHelperDB.fastExitMode and 0 or 15
end

local function FormatTime(seconds, completed)
    local hours = floor(seconds / 3600)
    local minutes = floor((seconds % 3600) / 60)
    local seconds = seconds % 60
    
    if hours > 0 then
        if completed then
            return format(DFCNL["TIME_FORMAT_COMPLETED_HMS"], hours, minutes, seconds)
        else
            return format("%d:%02d:%02d", hours, minutes, seconds)
        end
    else
        if completed then
            return format(DFCNL["TIME_FORMAT_COMPLETED_MS"], minutes, seconds)
        else
            return format("%02d:%02d", minutes, seconds)
        end
    end
end

local function GetDelveInfo()
    local widgetInfo = C_UIWidgetManager and C_UIWidgetManager.GetScenarioHeaderDelvesWidgetVisualizationInfo(6183)
    if not widgetInfo then
        return nil, nil, nil, nil
    end

    local info = widgetInfo
    local difficultyLevel = tonumber(info.tierText)
    local remainingLives = nil
    
    if info.currencies and info.currencies[1] then
        remainingLives = tonumber(info.currencies[1].text)
    end
    
    local delveName = info.headerText
    local isSpecialDelve = delveName == DFCNL["SPECIAL_DELVE_NAME"]
    
    local isAbundant = false
    if info.spells then
        for _, spell in ipairs(info.spells) do
            if spell.spellID == 462940 then
                isAbundant = true
                break
            end
        end
    end
    
    return difficultyLevel, remainingLives, isAbundant, delveName, isSpecialDelve
end

local function StripColorCodes(text)
    if not text then return "" end
    return text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
end

function DFCN.UpdateBankIconVisibility()
    if not DFCN.scoreboardFrame or not DFCN.scoreboardFrame.bankIcon then return end
    
    local bankStatus = C_Bank and C_Bank.FetchBankLockedReason(2)
    local isBankAvailable = false
    
    if bankStatus == nil then
        isBankAvailable = true
    elseif type(bankStatus) == "table" then
        isBankAvailable = #bankStatus == 0
    elseif type(bankStatus) == "number" then
        isBankAvailable = bankStatus == 0
    else
        isBankAvailable = false
    end
    
    if isBankAvailable then
        DFCN.scoreboardFrame.bankIcon.icon:SetTexture("Interface\\MINIMAP\\TRACKING\\Banker")
        DFCN.scoreboardFrame.bankIcon:Show()
        DFCN.scoreboardFrame.bankIcon.tooltipText = "|cFF00FF00" .. DFCNL["BANK_AVAILABLE"] .. "|r"
    else
        DFCN.scoreboardFrame.bankIcon.icon:SetTexture("Interface\\Common\\Icon-noloot")
        DFCN.scoreboardFrame.bankIcon:Show()
        DFCN.scoreboardFrame.bankIcon.tooltipText = "|cFFFF0000" .. DFCNL["BANK_UNAVAILABLE"] .. "|r"
    end
end

function DFCN.CreateScoreboard()
    if DFCN.scoreboardFrame then
        return DFCN.scoreboardFrame
    end

    local frame = CreateFrame("Frame", "DFCN_DelveHelperScoreboard", UIParent, "BackdropTemplate")
    frame:SetSize(260, 185)
    
    if DFCN_DelveHelperDB.scoreboardPosition then
        frame:SetPoint(
            DFCN_DelveHelperDB.scoreboardPosition.point,
            UIParent,
            DFCN_DelveHelperDB.scoreboardPosition.relativePoint,
            DFCN_DelveHelperDB.scoreboardPosition.x,
            DFCN_DelveHelperDB.scoreboardPosition.y
        )
    else
        frame:SetPoint("CENTER", 0, 150)
    end
    
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    
    frame:SetScript("OnDragStart", function(self)
        if not DFCN_DelveHelperDB.scoreboardLocked then
            self:StartMoving()
        end
    end)
    
    frame:SetScript("OnDragStop", function(self)
        if not DFCN_DelveHelperDB.scoreboardLocked then
            self:StopMovingOrSizing()
            
            local point, _, relativePoint, x, y = self:GetPoint()
            
            DFCN_DelveHelperDB.scoreboardPosition = {
                x = x, 
                y = y,
                point = point,
                relativePoint = relativePoint
            }
        end
    end)
    
    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, 
        tileSize = 16, 
        edgeSize = 4,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.title:SetPoint("TOP", 0, -15)
	frame.title:SetFont(GameFontNormal:GetFont(), 16)
    frame.title:SetText(DFCNL["SCOREBOARD_TITLE"])
    frame.title:SetTextColor(0.95, 0.95, 0.32)
    
    frame.lockBtn = CreateFrame("Button", nil, frame)
    frame.lockBtn:SetPoint("TOPRIGHT", -20, -3)
    frame.lockBtn:SetSize(20, 20)
    
    frame.lockBtn.text = frame.lockBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.lockBtn.text:SetPoint("CENTER")
	frame.lockBtn.text:SetFont(GameFontNormal:GetFont(), 14)
    frame.closeBtn = CreateFrame("Button", nil, frame)
    frame.closeBtn:SetPoint("TOPRIGHT", -2, -2)
    frame.closeBtn:SetSize(20, 20)
    
    frame.closeBtn.text = frame.closeBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.closeBtn.text:SetPoint("CENTER")
	frame.closeBtn.text:SetFont(GameFontNormal:GetFont(), 16)
    frame.closeBtn.text:SetText("x")
    frame.closeBtn.text:SetTextColor(1, 1, 1)
    
    frame.closeBtn:SetScript("OnEnter", function(self)
        self.text:SetTextColor(1, 0.82, 0) 
    end)
    
    frame.closeBtn:SetScript("OnLeave", function(self)
        self.text:SetTextColor(1, 1, 1) 
    end)
    
    frame.closeBtn:SetScript("OnClick", function() 
        DFCN_DelveHelperDB.scoreboardEnabled = false
        frame:Hide() 
    end)

    local bgAlpha = DFCN_DelveHelperDB.backgroundAlpha or 0.4

    frame:SetBackdropColor(0.1, 0.1, 0.1, bgAlpha)
    frame:SetBackdropBorderColor(0.4, 0.4, 0.4, bgAlpha)

    frame.transparencyBtn = CreateFrame("Button", nil, frame)
    frame.transparencyBtn:SetPoint("TOPRIGHT", frame.lockBtn, "TOPLEFT", 0, 0)
    frame.transparencyBtn:SetSize(20, 20)
    
    frame.transparencyBtn.text = frame.transparencyBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.transparencyBtn.text:SetPoint("CENTER")
	frame.transparencyBtn.text:SetFont(GameFontNormal:GetFont(), 13)
    frame.transparencyBtn.text:SetText("T")
    frame.transparencyBtn.text:SetTextColor(1, 1, 1)

    frame.bgAlphaSlider = CreateFrame("Slider", "DFCN_DelveHelperScoreboardBgAlphaSlider", frame, "OptionsSliderTemplate")
    frame.bgAlphaSlider:SetPoint("TOP", frame, "TOP", 0, 30)
    frame.bgAlphaSlider:SetSize(250, 20)
    frame.bgAlphaSlider:SetMinMaxValues(0, 1)
    frame.bgAlphaSlider:SetValueStep(0.1)
    frame.bgAlphaSlider:SetObeyStepOnDrag(true)
    frame.bgAlphaSlider:SetValue(bgAlpha)
    frame.bgAlphaSlider:Hide()
    
    frame.bgAlphaSlider.Low = _G[frame.bgAlphaSlider:GetName().."Low"]
    frame.bgAlphaSlider.High = _G[frame.bgAlphaSlider:GetName().."High"]
    frame.bgAlphaSlider.Text = _G[frame.bgAlphaSlider:GetName().."Text"]
    
    frame.bgAlphaSlider.Low:SetText("0")
    frame.bgAlphaSlider.High:SetText("1")
    frame.bgAlphaSlider.Text:SetText(DFCNL["BACKGROUND_TRANSPARENCY"])
    
    frame.transparencyBtn:SetScript("OnClick", function()
        if frame.bgAlphaSlider:IsShown() then
            frame.bgAlphaSlider:Hide()
        else
            frame.bgAlphaSlider:Show()
        end
    end)

    frame.bgAlphaSlider:SetScript("OnValueChanged", function(self, value)
        value = tonumber(string.format("%.1f", value))
        frame:SetBackdropColor(0.1, 0.1, 0.1, value)
        frame:SetBackdropBorderColor(0.4, 0.4, 0.4, value)        
        frame:Show()        
        DFCN_DelveHelperDB.backgroundAlpha = value
    end)

    frame:SetScript("OnHide", function()
        if frame.bgAlphaSlider and frame.bgAlphaSlider:IsShown() then
            frame.bgAlphaSlider:Hide()
        end
    end)
    
    frame.exitBtn = CreateFrame("Button", nil, frame)
    frame.exitBtn:SetPoint("TOPLEFT", 5, -5)
    frame.exitBtn:SetSize(24, 24)
    
    frame.exitBtn.icon = frame.exitBtn:CreateTexture(nil, "ARTWORK")
    frame.exitBtn.icon:SetAllPoints()
    frame.exitBtn.icon:SetTexture("interface\\vehicles\\ui-vehicles-button-exit-up")    
    frame.exitBtn.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    frame.exitBtn.tooltipText = DFCNL["CLICK_TO_EXIT"]

    frame.exitBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(self.tooltipText, 1, 0, 0)
        GameTooltip:Show()
    end)
    
    frame.exitBtn:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
    
    frame.exitBtn:SetScript("OnClick", function() 
        C_PartyInfo.DelveTeleportOut()
    end)

	frame.bankIcon = CreateFrame("Button", nil, frame)
	frame.bankIcon:SetPoint("LEFT", frame.exitBtn, "RIGHT", 5, 0)
	frame.bankIcon:SetSize(16, 16)
	frame.bankIcon:Hide()

	frame.bankIcon.icon = frame.bankIcon:CreateTexture(nil, "ARTWORK")
	frame.bankIcon.icon:SetAllPoints()
	frame.bankIcon.icon:SetTexture("Interface\\MINIMAP\\TRACKING\\Banker")
	frame.bankIcon.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	frame.bankIcon:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:SetText(self.tooltipText or DFCNL["BANK_STATUS"], 0, 1, 0)
		GameTooltip:Show()
	end)

	frame.bankIcon:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
    
    local function UpdateLockState()
        if DFCN_DelveHelperDB.scoreboardLocked then
            frame.lockBtn.text:SetText("L")
            frame.lockBtn.text:SetTextColor(1, 0.2, 0.2)

            frame:EnableMouse(false)
            frame.lockBtn:EnableMouse(true)
            frame.closeBtn:EnableMouse(true)
            frame.exitBtn:EnableMouse(true)
        else
            frame.lockBtn.text:SetText("U")
            frame.lockBtn.text:SetTextColor(0.2, 1, 0.2)
            
            frame:EnableMouse(true)
        end
    end
    
    frame.lockBtn:SetScript("OnClick", function()
        DFCN_DelveHelperDB.scoreboardLocked = not DFCN_DelveHelperDB.scoreboardLocked
        UpdateLockState()
    end)
    
    UpdateLockState()
      
    local function CreateInfoLineWithIcon(parent, yOffset, label, iconPath)
        local line = CreateFrame("Frame", nil, parent)
        line:SetSize(230, 20)
        line:SetPoint("TOPLEFT", 10, yOffset)
        
        line.icon = line:CreateTexture(nil, "ARTWORK")
        line.icon:SetTexture(iconPath)
        line.icon:SetSize(18, 18)
        line.icon:SetPoint("LEFT", 10, 0)

        line.label = line:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        line.label:SetPoint("LEFT", line.icon, "RIGHT", 5, 0)
		line.label:SetFont(GameFontNormal:GetFont(), 13)
        line.label:SetText(label.."")
        line.label:SetTextColor(1, 1, 0.8)
        
        line.value = line:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        line.value:SetPoint("RIGHT", line, "RIGHT", 0, 0)
		line.value:SetFont(GameFontNormal:GetFont(), 13)
        line.value:SetText("Loading...")
        
        return line
    end

	frame.delveName = CreateInfoLineWithIcon(frame, -65, " " .. DFCNL["SCENARIO"], "Interface\\icons\\ui_delves")
	frame.difficultyLevel = CreateInfoLineWithIcon(frame, -87, " " .. DFCNL["DIFFICULTY_LEVEL"], "Interface\\icons\\achievement_garrisonfollower_levelup")
	frame.remainingLives = CreateInfoLineWithIcon(frame, -109, " " .. DFCNL["REMAINING_LIVES"], "Interface\\icons\\delves-scenario-heart-icon")
	frame.remainingEnemies = CreateInfoLineWithIcon(frame, -131, " " .. DFCNL["REMAINING_ENEMIES"], "Interface\\delves\\delves-scenario-treasure-available")
	frame.duration = CreateInfoLineWithIcon(frame, -153, " " .. DFCNL["TOTAL_TIME"], "Interface\\icons\\spell_holy_borrowedtime")

    frame.companionIcons = CreateFrame("Frame", nil, frame)
    frame.companionIcons:SetSize(80, 22)
    frame.companionIcons:SetPoint("TOPLEFT", 18, -40)
    
    frame.roleIcon = frame.companionIcons:CreateTexture(nil, "ARTWORK")
    frame.roleIcon:SetSize(22, 22)
    frame.roleIcon:SetPoint("LEFT", 0, 0)
    
    frame.combatIcon = frame.companionIcons:CreateTexture(nil, "ARTWORK")
    frame.combatIcon:SetSize(18, 18)
    frame.combatIcon:SetPoint("LEFT", frame.roleIcon, "RIGHT", 4, 0)
    
    frame.utilityIcon = frame.companionIcons:CreateTexture(nil, "ARTWORK")
    frame.utilityIcon:SetSize(18, 18)
    frame.utilityIcon:SetPoint("LEFT", frame.combatIcon, "RIGHT", 4, 0)   
    
    frame.flashingDoorText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.flashingDoorText:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -20, -45)
    frame.flashingDoorText:SetFont(GameFontNormal:GetFont(), 14)
    frame.flashingDoorText:SetText(" " .. DFCNL["FLASHING_DOOR"])
    frame.flashingDoorText:Hide()

    frame.flashingDoorIcon = frame:CreateTexture(nil, "OVERLAY")
    frame.flashingDoorIcon:SetTexture("Interface\\Icons\\INV_112_RaidTrinkets_BlobOfSwirlingVoid_purple")
    frame.flashingDoorIcon:SetSize(18, 18)
    frame.flashingDoorIcon:SetPoint("RIGHT", frame.flashingDoorText, "LEFT", -3, 0)
    frame.flashingDoorIcon:Hide()
    
    local key = GetCharacterKey()
    local charData = DFCN_DelveHelperDB.characters[key] or {}
    
    if charData.flashingDoorDetected then
        frame.flashingDoorIcon:Show()
        frame.flashingDoorText:Show()
        
        if charData.flashingDoorActivated then
            frame.flashingDoorText:SetText(" " .. DFCNL["FLASHING_DOOR_USED"])
            frame.flashingDoorText:SetTextColor(0.5, 0.5, 0.5)
            frame.flashingDoorIcon:SetTexture("Interface\\Icons\\INV_112_Achievement_Zone_Karesh")
        else
            frame.flashingDoorText:SetText(" " .. DFCNL["FLASHING_DOOR"])
            frame.flashingDoorText:SetTextColor(0.1, 0.4, 0.9)
            frame.flashingDoorIcon:SetTexture("Interface\\Icons\\INV_112_RaidTrinkets_BlobOfSwirlingVoid_purple")
        end
    else
        frame.flashingDoorIcon:Hide()
        frame.flashingDoorText:Hide()
    end
    
    DFCN.CreatemedicineBar(frame)	
    frame:Hide()
    DFCN.scoreboardFrame = frame
    DFCN.UpdateBankIconVisibility()

    if IsInDelvesScenario() then
        DFCN.DelayedScoreboardRefresh(0.5)
        DFCN.StartPeriodicUpdateTimer()
        DFCN.UpdateCompanionIcons(true)

        local key = GetCharacterKey()
        local charData = DFCN_DelveHelperDB.characters[key] or {}
        
        if charData.flashingDoorDetected then
            frame.flashingDoorIcon:Show()
            frame.flashingDoorText:Show()
            
            if charData.flashingDoorActivated then
                frame.flashingDoorText:SetText(" " .. DFCNL["FLASHING_DOOR_USED"])
                frame.flashingDoorText:SetTextColor(0.5, 0.5, 0.5)
                frame.flashingDoorIcon:SetTexture("Interface\\Icons\\INV_112_Achievement_Zone_Karesh")
            else
                frame.flashingDoorText:SetText(" " .. DFCNL["FLASHING_DOOR"])
                frame.flashingDoorText:SetTextColor(0.1, 0.4, 0.9)
                frame.flashingDoorIcon:SetTexture("Interface\\Icons\\INV_112_RaidTrinkets_BlobOfSwirlingVoid_purple")
            end
        else
            frame.flashingDoorIcon:Hide()
            frame.flashingDoorText:Hide()
        end
    end
	
    return frame
end

function GetBrannCurrentSetup()
    local companionInfoID = C_DelvesUI.GetCompanionInfoForActivePlayer()    
    local treeID = C_DelvesUI.GetTraitTreeForCompanion(companionInfoID)    
    local configID = C_Traits.GetConfigIDByTreeID(treeID)
    local roleNodeID = C_DelvesUI.GetRoleNodeForCompanion(companionInfoID)    
    local roleName = DFCNL["NOT_SET"]
    local roleIcon = "Interface\\Icons\\INV_Misc_QuestionMark"

    if roleNodeID then
        local roleNodeInfo = C_Traits.GetNodeInfo(configID, roleNodeID)
        if roleNodeInfo and roleNodeInfo.activeEntry then
            local entryInfo = C_Traits.GetEntryInfo(configID, roleNodeInfo.activeEntry.entryID)
            if entryInfo then
                local subTreeInfo = C_Traits.GetSubTreeInfo(configID, entryInfo.subTreeID)
                if subTreeInfo then
                    roleName = subTreeInfo.name
                    roleIcon = subTreeInfo.iconElementID and CreateAtlasMarkup(subTreeInfo.iconElementID, 20, 20) or roleIcon
                end
            end
        end
    end

    local combatNodeID = C_DelvesUI.GetCurioNodeForCompanion(Enum.CurioType.Combat, companionInfoID)
    local utilityNodeID = C_DelvesUI.GetCurioNodeForCompanion(Enum.CurioType.Utility, companionInfoID)    
    local combatNodeInfo = combatNodeID and C_Traits.GetNodeInfo(configID, combatNodeID)
    local utilityNodeInfo = utilityNodeID and C_Traits.GetNodeInfo(configID, utilityNodeID)
    
    local function ProcessTrinketNode(nodeInfo)
        if not nodeInfo or not nodeInfo.activeEntry then
            return DFCNL["NOT_SET"], "Interface\\Icons\\INV_Misc_QuestionMark", nil
        end
        
        local entryInfo = C_Traits.GetEntryInfo(configID, nodeInfo.activeEntry.entryID)
        if not entryInfo then
            return DFCNL["NOT_SET"], "Interface\\Icons\\INV_Misc_QuestionMark", nil
        end
        
        local definitionInfo = C_Traits.GetDefinitionInfo(entryInfo.definitionID)
        if not definitionInfo then
            return DFCNL["NOT_SET"], "Interface\\Icons\\INV_Misc_QuestionMark", nil
        end
        
        local spellID = definitionInfo.overriddenSpellID or definitionInfo.spellID
        local spellInfo = C_Spell.GetSpellInfo(spellID)
        if not spellInfo then
            return DFCNL["NOT_SET"], "Interface\\Icons\\INV_Misc_QuestionMark", nil
        end
        
        return C_Spell.GetSpellLink(spellID) or spellInfo.name, spellInfo.iconID, spellID
    end

    local combatTrinket, combatIcon, combatSpellID = ProcessTrinketNode(combatNodeInfo)
    local utilityTrinket, utilityIcon, utilitySpellID = ProcessTrinketNode(utilityNodeInfo)
    
    return {
        role = {name = roleName, icon = roleIcon},
        combat = {name = combatTrinket, icon = combatIcon, spellID = combatSpellID},
        utility = {name = utilityTrinket, icon = utilityIcon, spellID = utilitySpellID},
        hash = tostring(roleName) .. "|" .. tostring(combatSpellID) .. "|" .. tostring(utilitySpellID),
        configID = configID
    }
end

function DFCN.UpdateCompanionIcons(forceUpdate)
    if not DFCN.scoreboardFrame or not DFCN.scoreboardFrame:IsShown() then 
        return 
    end
    
    local setup = GetBrannCurrentSetup()
    DFCN.brannConfigID = setup.configID
    local shouldUpdate = forceUpdate or not DFCN.lastBrannSetup or DFCN.lastBrannSetup.hash ~= setup.hash

    if not shouldUpdate then
        return
    end

    DFCN.lastBrannSetup = setup
    
     if type(setup.role.icon) == "string" and setup.role.icon:match("^|A:") then
        local atlasName = setup.role.icon:match("|A:([^:]+)")
        if atlasName then
            DFCN.scoreboardFrame.roleIcon:SetAtlas(atlasName)
            DFCN.scoreboardFrame.roleIcon:SetTexCoord(0, 1, 0, 1)
        else
            DFCN.scoreboardFrame.roleIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
        end
    else
        DFCN.scoreboardFrame.roleIcon:SetTexture(setup.role.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
    end

    if type(setup.combat.icon) == "number" then
        DFCN.scoreboardFrame.combatIcon:SetTexture(setup.combat.icon)
        DFCN.scoreboardFrame.combatIcon:SetTexCoord(0, 1, 0, 1)
    elseif type(setup.combat.icon) == "string" then
        DFCN.scoreboardFrame.combatIcon:SetTexture(setup.combat.icon)
    else
        DFCN.scoreboardFrame.combatIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    end

    if type(setup.utility.icon) == "number" then
        DFCN.scoreboardFrame.utilityIcon:SetTexture(setup.utility.icon)
        DFCN.scoreboardFrame.utilityIcon:SetTexCoord(0, 1, 0, 1)
    elseif type(setup.utility.icon) == "string" then
        DFCN.scoreboardFrame.utilityIcon:SetTexture(setup.utility.icon)
    else
        DFCN.scoreboardFrame.utilityIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    end
    
    DFCN.scoreboardFrame.roleIcon:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(DFCNL["BRANN_ROLE"] .. ": "..setup.role.name, 1, 1, 1)
        GameTooltip:Show()
    end)
    DFCN.scoreboardFrame.roleIcon:SetScript("OnLeave", GameTooltip_Hide)
    
	DFCN.scoreboardFrame.combatIcon:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		if setup.combat.spellID then
			GameTooltip:SetSpellByID(setup.combat.spellID)
		else
			GameTooltip:SetText(DFCNL["COMBAT_TRINKET"] .. ": "..setup.combat.name, 1, 1, 1)
		end
		GameTooltip:Show()
	end)
	DFCN.scoreboardFrame.combatIcon:SetScript("OnLeave", GameTooltip_Hide)
	DFCN.scoreboardFrame.utilityIcon:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		if setup.utility.spellID then
			GameTooltip:SetSpellByID(setup.utility.spellID)
		else
			GameTooltip:SetText(DFCNL["UTILITY_TRINKET"] .. ": "..setup.utility.name, 1, 1, 1)
		end
		GameTooltip:Show()
	end)
	DFCN.scoreboardFrame.utilityIcon:SetScript("OnLeave", GameTooltip_Hide)

    DFCN.scoreboardFrame.roleIcon:Show()
    DFCN.scoreboardFrame.combatIcon:Show()
    DFCN.scoreboardFrame.utilityIcon:Show()
end


function DFCN.CreatemedicineBar(parent)
    if DFCN.medicineBar then return end
    
    local bar = CreateFrame("Frame", nil, parent)
    bar:SetSize(parent:GetWidth(), 24)
    bar:SetPoint("TOP", parent, "BOTTOM", 0, -2)
    bar:Hide()
    
    bar.icon = bar:CreateTexture(nil, "ARTWORK")
    bar.icon:SetSize(24, 24)
    bar.icon:SetPoint("LEFT", bar, "LEFT", 0, 0)
    bar.icon:SetTexture(C_Spell.GetSpellTexture(416224) or "Interface\\Icons\\INV_Misc_QuestionMark")

    bar.nameText = bar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	bar.nameText:SetFont(GameFontNormal:GetFont(), 14)
    bar.nameText:SetPoint("LEFT", bar.icon, "RIGHT", 5, 0)
    bar.nameText:SetText("")
    bar.nameText:SetTextColor(1, 1, 1)
    
    bar.background = bar:CreateTexture(nil, "BACKGROUND")
    bar.background:SetColorTexture(0.2, 0.2, 0.2, 0.2)
    bar.background:SetPoint("LEFT", bar.icon, "RIGHT", 2, 0)
    bar.background:SetPoint("RIGHT", bar, "RIGHT", 0, 0)
    bar.background:SetHeight(20)
    
    bar.statusBar = bar:CreateTexture(nil, "ARTWORK")
    bar.statusBar:SetColorTexture(0.8, 0.2, 0.8, 0.8)
    bar.statusBar:SetPoint("LEFT", bar.background, "LEFT")
    bar.statusBar:SetHeight(25)
    bar.statusBar:SetWidth(0)

    bar.timeText = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    bar.timeText:SetPoint("CENTER", bar.background, "CENTER")
    bar.timeText:SetText("0.0s")
    bar.timeText:SetTextColor(1, 1, 1)
    
    bar.stackText = bar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	bar.stackText:SetFont(GameFontNormal:GetFont(), 14)
    bar.stackText:SetPoint("BOTTOMRIGHT", bar.background, "BOTTOMRIGHT", -2, 2)
    bar.stackText:SetTextColor(1, 1, 1)
    
    DFCN.medicineBar = bar
end

function DFCN:UpdatemedicineBar()
    local auraInfo = C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID(416224)
    local bar = DFCN.medicineBar
    if not bar then return end
    if auraInfo then
        bar:Show()
        local applications = auraInfo.applications or 1
        bar.stackText:SetText(applications .. DFCNL["STACKS"])
        bar.nameText:SetText(auraInfo.name or DFCNL["DWARVEN_MEDICINE"])
        bar.duration = auraInfo.duration or 10
        bar.expirationTime = auraInfo.expirationTime or 0
        if not bar:GetScript("OnUpdate") then
            bar:SetScript("OnUpdate", DFCN.MedicineBarOnUpdate)
        end
    else
        bar:Hide()
        bar:SetScript("OnUpdate", nil)
    end
end

function DFCN:MedicineBarOnUpdate(elapsed)
    local bar = DFCN.medicineBar
    if not bar or not bar.expirationTime then return end
    local remaining = bar.expirationTime - GetTime()
    if remaining <= 0 then
        bar:Hide()
        bar:SetScript("OnUpdate", nil)
        return
    end

    local remainingText = string.format("%.1fs", remaining)
    bar.timeText:SetText(remainingText)
    if remaining >= 6 then
        bar.timeText:SetTextColor(0, 1, 0)
        bar.statusBar:SetColorTexture(0, 0.7, 0, 0.7)
    elseif remaining >= 2 then
        bar.timeText:SetTextColor(1, 0.65, 0)
        bar.statusBar:SetColorTexture(1, 0.4, 0, 0.7)
    else
        bar.timeText:SetTextColor(1, 0, 0)
        bar.statusBar:SetColorTexture(0.7, 0, 0, 0.7)
    end
    local width = bar.background:GetWidth() * (remaining / bar.duration)
    bar.statusBar:SetWidth(width)
end

function DFCN.StartDelveTimer()
    if DFCN.delveCompleted then return end
    if DFCN.delveTimer then
        DFCN.delveTimer:Cancel()
        DFCN.delveTimer = nil
    end
    DFCN.delveStartServerTime = GetServerTime()
    
    local key = GetCharacterKey()
    DFCN_DelveHelperDB.characters[key] = DFCN_DelveHelperDB.characters[key] or {}
    DFCN_DelveHelperDB.characters[key].delveStartTime = DFCN.delveStartServerTime
    DFCN_DelveHelperDB.characters[key].delveCompleted = false
    
    DFCN.delveTimer = C_Timer.NewTicker(1, function()
        if not DFCN.scoreboardFrame or not DFCN.scoreboardFrame:IsShown() then return end
        
        local now = GetServerTime()
        local duration = now - DFCN.delveStartServerTime
        
        DFCN.scoreboardFrame.duration.value:SetText(FormatTime(duration, false))
    end)
end

function DFCN.PauseDelveTimer()
    if DFCN.delveTimer then
        DFCN.delveTimer:Cancel()
        DFCN.delveTimer = nil
    end
    
    if DFCN.delveStartServerTime and not DFCN.delveCompletionTime then
        DFCN.delveCompletionTime = GetServerTime() - DFCN.delveStartServerTime
    end
end

function DFCN.ResetDelveTimer()
    DFCN.PauseDelveTimer()
    
    DFCN.delveStartServerTime = nil
    DFCN.delveCompleted = false
    DFCN.delveCompletionTime = nil
    
    local key = GetCharacterKey()
    if DFCN_DelveHelperDB.characters[key] then
        DFCN_DelveHelperDB.characters[key].delveStartTime = nil
        DFCN_DelveHelperDB.characters[key].delveCompleted = false
    end
    
    if DFCN.scoreboardFrame and DFCN.scoreboardFrame:IsShown() then
        DFCN.scoreboardFrame.duration.value:SetText("00:00")
        DFCN.scoreboardFrame.duration.value:SetTextColor(0, 1, 0)
    end
end

local function ExtractEnemiesFromTooltip()
    local tooltipData = C_TooltipInfo and C_TooltipInfo.GetSpellByID(1239535)
    if not tooltipData then
        return nil
    end

    for _, line in ipairs(tooltipData.lines) do
        local leftText = line.leftText or ""
        
        if leftText and leftText:find(DFCNL["REMAINING_ENEMIES_PATTERN"]) then
            local lineText = leftText
            local lineNumbers = {}
            for num in lineText:gmatch("%d+") do
                table.insert(lineNumbers, tonumber(num))
            end
            
            if #lineNumbers >= 2 then
                return lineNumbers[1].." / "..lineNumbers[2]
            end
            break
        end
    end
    
    return nil
end

function DFCN.UpdateScoreboard()
    if not IsInDelvesScenario() then
        if DFCN.scoreboardFrame and DFCN.scoreboardFrame:IsShown() then
            DFCN.scoreboardFrame:Hide()
        end
        DFCN.StopPeriodicUpdateTimer()
        return
    end
    if not DFCN.scoreboardFrame or not DFCN.scoreboardFrame:IsShown() then return end

    local key = GetCharacterKey()
    local charDB = DFCN_DelveHelperDB.characters[key] or {}
    local delveCompleted = DFCN.delveCompleted or charDB.delveCompleted
    local delveCompletionTime = DFCN.delveCompletionTime or charDB.delveCompletionTime

	if DFCN.delveCompleted and DFCN.delveCompletionTime then
		local duration = DFCN.delveCompletionTime
		
		local minutes = floor(duration / 60)
		if minutes < 10 then
			DFCN.scoreboardFrame.duration.value:SetTextColor(0, 1, 0)
		elseif minutes <= 15 then
			DFCN.scoreboardFrame.duration.value:SetTextColor(1, 1, 0)
		elseif minutes <= 20 then
			DFCN.scoreboardFrame.duration.value:SetTextColor(1, 0.5, 0)
		else
			DFCN.scoreboardFrame.duration.value:SetTextColor(1, 0, 0)
		end
		
		DFCN.scoreboardFrame.duration.value:SetText(FormatTime(duration, true))
	elseif DFCN.delveStartServerTime then
		local now = GetServerTime()
		local duration = now - DFCN.delveStartServerTime

		local minutes = floor(duration / 60)
		if minutes < 10 then
			DFCN.scoreboardFrame.duration.value:SetTextColor(0, 1, 0)
		elseif minutes <= 15 then
			DFCN.scoreboardFrame.duration.value:SetTextColor(1, 1, 0)
		elseif minutes <= 20 then
			DFCN.scoreboardFrame.duration.value:SetTextColor(1, 0.5, 0)
		else
			DFCN.scoreboardFrame.duration.value:SetTextColor(1, 0, 0)
		end
		
		DFCN.scoreboardFrame.duration.value:SetText(FormatTime(duration, false))
	else
		DFCN.scoreboardFrame.duration.value:SetText("00:00")
		DFCN.scoreboardFrame.duration.value:SetTextColor(0, 1, 0)
	end

		local difficultyLevel, remainingLives, isAbundant, delveName, isSpecialDelve = GetDelveInfo()
		DFCN.currentDifficultyLevel = difficultyLevel or 0
		DFCN.isAbundant = isAbundant or false

    if isSpecialDelve then
        DFCN.scoreboardFrame.delveName.value:SetText(delveName)
        DFCN.scoreboardFrame.delveName.value:SetTextColor(1, 0, 0)
        
        if difficultyLevel == 8 then
            DFCN.scoreboardFrame.difficultyLevel.value:SetText("？")
            DFCN.scoreboardFrame.difficultyLevel.value:SetTextColor(1, 0, 0)
        elseif difficultyLevel == 11 then
            DFCN.scoreboardFrame.difficultyLevel.value:SetText("？？")
            DFCN.scoreboardFrame.difficultyLevel.value:SetTextColor(1, 0, 0)
        else
            DFCN.scoreboardFrame.difficultyLevel.value:SetText(tostring(difficultyLevel))
            DFCN.scoreboardFrame.difficultyLevel.value:SetTextColor(1, 0, 0)
        end
        
        DFCN.scoreboardFrame.remainingLives.value:SetText("N/A")
        DFCN.scoreboardFrame.remainingLives.value:SetTextColor(1, 1, 1)
        
        DFCN.scoreboardFrame.remainingEnemies.value:SetText("N/A")
        DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(1, 1, 1)
        
        return
    end
    
	if delveName then
		if isAbundant then
			local displayText = "|A:delves-bountiful:18:18|a " .. delveName
			DFCN.scoreboardFrame.delveName.value:SetText(displayText)
			DFCN.scoreboardFrame.delveName.value:SetTextColor(0, 1, 0)
		else
			DFCN.scoreboardFrame.delveName.value:SetText(delveName)
			DFCN.scoreboardFrame.delveName.value:SetTextColor(1, 1, 1)
		end
	else
		DFCN.scoreboardFrame.delveName.value:SetText("N/A")
		DFCN.scoreboardFrame.delveName.value:SetTextColor(1, 1, 1)
	end
    
    if difficultyLevel then
        local hasTreasureBuff = false
        if DFCN_DelveHelperDB.treasureMapAlertEnabled then
            hasTreasureBuff = C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID(1246363) ~= nil
        end

        local difficultyText = tostring(difficultyLevel)
		if hasTreasureBuff then
			if difficultyLevel == 11 then
				difficultyText = "|T1064187:14:14|t " .. difficultyText
			else
				if DFCN_DelveHelperDB.treasureMapAlertEnabled then
					if not DFCN.treasureBuffAlert then
						DFCN.CreateTreasureBuffAlert()
					end
					DFCN.treasureBuffAlert:Show()
				else
					if DFCN.treasureBuffAlert then
						DFCN.treasureBuffAlert:Hide()
					end
				end
			end
		else
			if DFCN.treasureBuffAlert then
				DFCN.treasureBuffAlert:Hide()
			end
		end

        DFCN.scoreboardFrame.difficultyLevel.value:SetText(difficultyText)
        
		if difficultyLevel <= 7 then
			DFCN.scoreboardFrame.difficultyLevel.value:SetTextColor(1, 0, 0)
		else
			DFCN.scoreboardFrame.difficultyLevel.value:SetTextColor(0, 1, 0)
		end
	else
		DFCN.scoreboardFrame.difficultyLevel.value:SetText(DFCNL["UNKNOWN"])
		DFCN.scoreboardFrame.difficultyLevel.value:SetTextColor(1, 1, 1)
	end

    if difficultyLevel and difficultyLevel < 4 then
        DFCN.scoreboardFrame.remainingLives.value:SetText("N/A")
        DFCN.scoreboardFrame.remainingLives.value:SetTextColor(0, 1, 0.5)
    else
        if remainingLives == nil then
            DFCN.scoreboardFrame.remainingLives.value:SetText(DFCNL["UNKNOWN"])
            DFCN.scoreboardFrame.remainingLives.value:SetTextColor(1, 1, 1)
        else
            DFCN.scoreboardFrame.remainingLives.value:SetText(tostring(remainingLives))
            
            if remainingLives == 0 then
                DFCN.scoreboardFrame.remainingLives.value:SetTextColor(0.5, 0.5, 0.5)
            elseif remainingLives == 1 then
                DFCN.scoreboardFrame.remainingLives.value:SetTextColor(1, 0, 0)
            elseif remainingLives == 2 then
                DFCN.scoreboardFrame.remainingLives.value:SetTextColor(1, 0.5, 0)
            else
                DFCN.scoreboardFrame.remainingLives.value:SetTextColor(0, 1, 0)
            end
        end
    end

    local enemiesText = "0/0"
    if difficultyLevel and difficultyLevel >= 4 then
        local retryCount = 0
        local maxRetries = 3
        local success = false
        
        local function TryGetEnemies()
            local text = ExtractEnemiesFromTooltip()
            if text then
                enemiesText = text
                success = true
                DFCN.scoreboardFrame.remainingEnemies.value:SetText(text)

                local current, total = text:match("(%d+)[^%d]*(%d+)")
                if current and total then
                    current = tonumber(current)
                    total = tonumber(total)

                    if total == 1 then
                        if current == 1 then
                            DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(1, 0, 0)
                        else
                            DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(0, 1, 0)
                        end
                    elseif total == 2 then
                        if current == 2 then
                            DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(1, 0, 0)
                        elseif current == 1 then
                            DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(1, 1, 0)
                        else
                            DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(0, 1, 0)
                        end
                    elseif total == 3 then
                        if current == 3 then
                            DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(1, 0, 0)
                        elseif current == 2 then
                            DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(1, 0.5, 0)
                        elseif current == 1 then
                            DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(1, 1, 0)
                        else
                            DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(0, 1, 0)
                        end
                    elseif total >= 4 then
                        if current == total then
                            DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(1, 0, 0)
                        elseif current == total - 1 or current == total - 2 then
                            DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(1, 0.5, 0)
                        elseif current == total - 3 then
                            DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(1, 1, 0)
                        else
                            DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(0, 1, 0)
                        end
                    end
                else
                     DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(1, 1, 1)
                end
            elseif retryCount < maxRetries then
                retryCount = retryCount + 1
                DFCN.scoreboardFrame.remainingEnemies.value:SetText(string.format(DFCNL["RETRY_COUNT"], retryCount))
                DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(1, 1, 1)
                C_Timer.After(2, TryGetEnemies)
                return
            else
                enemiesText = "N/A"
                success = true
                DFCN.scoreboardFrame.remainingEnemies.value:SetText(enemiesText)
                DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(1, 1, 1)
            end
        end
        
        TryGetEnemies()
    else
        DFCN.scoreboardFrame.remainingEnemies.value:SetText("N/A")
        DFCN.scoreboardFrame.remainingEnemies.value:SetTextColor(0, 1, 0)
    end

    if DFCN.scoreboardFrame and DFCN.scoreboardFrame.flashingDoorIcon then
        local key = GetCharacterKey()
        local charData = DFCN_DelveHelperDB.characters[key] or {}
        
        if charData.flashingDoorDetected then
            DFCN.scoreboardFrame.flashingDoorIcon:Show()
            DFCN.scoreboardFrame.flashingDoorText:Show()
            
            if charData.flashingDoorActivated then
                DFCN.scoreboardFrame.flashingDoorText:SetText(" " .. DFCNL["FLASHING_DOOR_USED"])
                DFCN.scoreboardFrame.flashingDoorText:SetTextColor(0.5, 0.5, 0.5)
                DFCN.scoreboardFrame.flashingDoorIcon:SetTexture("Interface\\Icons\\INV_112_Achievement_Zone_Karesh")
            else
                DFCN.scoreboardFrame.flashingDoorText:SetText(" " .. DFCNL["FLASHING_DOOR"])
                DFCN.scoreboardFrame.flashingDoorText:SetTextColor(0.1, 0.4, 0.9)
                DFCN.scoreboardFrame.flashingDoorIcon:SetTexture("Interface\\Icons\\INV_112_RaidTrinkets_BlobOfSwirlingVoid_purple")
            end
        else
            DFCN.scoreboardFrame.flashingDoorIcon:Hide()
            DFCN.scoreboardFrame.flashingDoorText:Hide()
        end
    end

    if DFCN.scoreboardFrame and DFCN.scoreboardFrame.bankIcon then
        DFCN.UpdateBankIconVisibility()
    end
    
    DFCN.UpdatemedicineBar()
end

local LDB, LibDBIcon
local ldbLoaded = false

local function LoadLibraries()
    LDB = LibStub("LibDataBroker-1.1", true)
    LibDBIcon = LibStub("LibDBIcon-1.0", true)    
    if LDB and LibDBIcon then
        ldbLoaded = true
    end
end

local function CreateLDBObject()
    if not ldbLoaded then return nil end
    
    local ldb = LDB:NewDataObject("DFCN_DelveHelper", {
        type = "data source",
        text = DFCNL["ADDON_DESCRIPTION"],
        icon = "Interface\\ICONS\\UI_Delves",
        OnClick = function(self, button)
            if button == "LeftButton" then
                DFCN.ToggleSettingsFrame()
            end
        end,
        OnTooltipShow = function(tooltip)
            tooltip:AddLine("|c000EEE00" .. DFCNL["ADDON_DESCRIPTION"] .. "|r|cFFFFA500 By|r|c000EEEEE DFCN")
            tooltip:AddLine(" ")
			tooltip:AddLine(DFCNL["TOOLTIP_LEFT_CLICK"], 1, 1, 1)
			tooltip:AddLine(DFCNL["TOOLTIP_COMMAND"], 0.5, 1, 1)
			tooltip:AddLine(DFCNL["TOOLTIP_MINIMAP"], 0.5, 1, 1)
			tooltip:AddLine(DFCNL["TOOLTIP_ESC"], 0.8, 0.8, 0.8)
        end,
    })
    
    return ldb
end

function DFCN.InitMinimapIcon()   
    local ldb = CreateLDBObject()
    if not ldb then return end
    
    DFCN_DelveHelperDB.minimapIcon = DFCN_DelveHelperDB.minimapIcon or {}    
    LibDBIcon:Register("DFCN_DelveHelper", ldb, DFCN_DelveHelperDB.minimapIcon)
    
    if DFCN_DelveHelperDB.minimapIconShown then
        LibDBIcon:Show("DFCN_DelveHelper")
    else
        LibDBIcon:Hide("DFCN_DelveHelper")
    end
    
    if not DFCN_DelveHelperDB.minimapIcon.position then
        DFCN_DelveHelperDB.minimapIcon.position = 150
        LibDBIcon:Refresh("DFCN_DelveHelper", DFCN_DelveHelperDB.minimapIcon)
    end
end

function DFCN.ToggleSettingsFrame()
    if not DFCN.settingsFrame then
        DFCN.CreateSettingsFrame()
    end

    if not DFCN.merchantFrame then
        DFCN.CreateMerchantFrame()
    end
    
    if not DFCN.delveInfoFrame then
        DFCN.CreateDelveInfoFrame()
    end
    
    if DFCN.settingsFrame:IsShown() then
        DFCN.settingsFrame:Hide()
    else
        DFCN.settingsFrame:Show()        
        DFCN.merchantFrame:Show()        
        DFCN.delveInfoFrame:Show()
        DFCN.UpdateDelveInfo()
    end
end

function DFCN.CreateDelveInfoFrame()
    if DFCN.delveInfoFrame then return end
    
    local parent = DFCN.settingsFrame
    local frame = CreateFrame("Frame", "DFCN_DelveHelperDelveInfoFrame", UIParent, "BackdropTemplate")
    frame:SetSize(420, 380)
    frame:SetFrameStrata("DIALOG")
    frame:SetPoint("LEFT", parent, "RIGHT", -2, 0)
    frame:SetFrameLevel(parent:GetFrameLevel() + 10)
    
    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, 
        tileSize = 16, 
        edgeSize = 4,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    frame:SetBackdropColor(0.1, 0.1, 0.1, 0.7)
    frame:SetBackdropBorderColor(0.4, 0.4, 0.4)

    frame.header = CreateFrame("Frame", nil, frame)
    frame.header:SetSize(380, 25)
    frame.header:SetPoint("TOP", 0, -10)

    frame.header.mapText = frame.header:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.header.mapText:SetPoint("LEFT", 0, 0)
    frame.header.mapText:SetText(DFCNL["MAP"])
    frame.header.mapText:SetTextColor(1, 1, 0.8)
    frame.header.mapText:SetFont(GameFontNormal:GetFont(), 14)

    frame.header.nameText = frame.header:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.header.nameText:SetPoint("LEFT", 110, 0)
    frame.header.nameText:SetText(DFCNL["DELVE"])
    frame.header.nameText:SetTextColor(1, 1, 0.8)
    frame.header.nameText:SetFont(GameFontNormal:GetFont(), 14)
    
    frame.header.variantText = frame.header:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.header.variantText:SetPoint("LEFT", 240, 0)
    frame.header.variantText:SetText(DFCNL["STORY_VARIANT"])
    frame.header.variantText:SetTextColor(1, 1, 0.8)
    frame.header.variantText:SetFont(GameFontNormal:GetFont(), 14)

    frame.scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    frame.scrollFrame:SetPoint("TOPLEFT", 10, -35)
    frame.scrollFrame:SetPoint("BOTTOMRIGHT", -30, 10)
    
    frame.scrollChild = CreateFrame("Frame")
    frame.scrollChild:SetSize(380, 330)
    frame.scrollFrame:SetScrollChild(frame.scrollChild)
    
    frame.rows = {}
    tinsert(UISpecialFrames, frame:GetName())
    
    frame:Hide()
    DFCN.delveInfoFrame = frame
end

local function GetMapName(uiMapID)
    local mapInfo = C_Map.GetMapInfo(uiMapID)
    return mapInfo and mapInfo.name or DFCNL["UNKNOWN_MAP"]
end

if not tContains then
    function tContains(table, item)
        if not table or type(table) ~= "table" then
            return false
        end
        for _, value in ipairs(table) do
            if value == item then
                return true
            end
        end
        return false
    end
end

local function ParseStoryVariant(widgetSetID)
    local widgets = C_UIWidgetManager.GetAllWidgetsBySetID(widgetSetID)
    if not widgets or #widgets == 0 then
        return DFCNL["UNKNOWN"], false
    end
    
    for _, widgetData in ipairs(widgets) do
        if widgetData.widgetType == 8 then
            local widgetInfo = C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo(widgetData.widgetID)
            if widgetInfo and widgetInfo.text then
                local text = StripColorCodes(widgetInfo.text)                
                local variant = text:match(DFCNL["STORY_VARIANT_PATTERN"])
                if variant then
                    local starWidgetIDs = {6902, 6905, 6907, 6909, 6912, 6913, 6915, 6916, 6917, 6927, 6939, 6943, 6947, 6948, 6950, 6951, 6953, 6964, 6965, 6966, 6968, 6969, 6971}
                    local hasStar = false
                    for _, starID in ipairs(starWidgetIDs) do
                        if widgetData.widgetID == starID then
                            hasStar = true
                            break
                        end
                    end
                    
                    local displayVariant = variant
                    if hasStar then
                        displayVariant = "|A:CampCollection-icon-star:16:16|a" .. variant
                    end

                    displayVariant = displayVariant:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|cn[%w_]+:", "")                    
                    return displayVariant, hasStar
                end
            end
        end
    end
    
    return DFCNL["UNKNOWN"], false
end

local CORRECT_DELVE_MAPPING = {
    [2248] = {7787, 7779, 7781, 7863, 7864, 7865},
    [2215] = {7785, 7780, 7783, 7789, 7868, 7869, 7870, 7871},
    [2214] = {7782, 7788, 8181, 7866, 7867, 8143},
    [2255] = {7786, 7784, 7790, 7872, 7873, 7874},
    [2346] = {8246, 8140},
    [2371] = {8273, 8274}
}

function DFCN.UpdateDelveInfo()
    if not DFCN.delveInfoFrame then
        DFCN.CreateDelveInfoFrame()
    end
    
    local frame = DFCN.delveInfoFrame
    local scrollChild = frame.scrollChild
    
    if frame.rows then
        for _, row in ipairs(frame.rows) do
            if row then
                row:Hide()
            end
        end
    end
    frame.rows = {}
    
    local mapIDs = {2248, 2215, 2214, 2255, 2346, 2371}
    local rowIndex = 0
    
    local delves = {}
    
	for _, uiMapID in ipairs(mapIDs) do
		local delveIDs = C_AreaPoiInfo.GetDelvesForMap(uiMapID)
		if delveIDs and type(delveIDs) == "table" and #delveIDs > 0 then
			for _, delveID in ipairs(delveIDs) do
				local correctDelves = CORRECT_DELVE_MAPPING[uiMapID]
				if correctDelves and tContains(correctDelves, delveID) then
					local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(uiMapID, delveID)
					if poiInfo and poiInfo.name then
						local storyVariant, hasStar = DFCNL["UNKNOWN"], false
						if poiInfo.tooltipWidgetSet then
							storyVariant, hasStar = ParseStoryVariant(poiInfo.tooltipWidgetSet)
						end
						
						table.insert(delves, {
							uiMapID = uiMapID,
							delveID = delveID,
							poiInfo = poiInfo,
							isBountiful = poiInfo.atlasName == "delves-bountiful",
							storyVariant = storyVariant,
							hasStar = hasStar
						})
					end
				end
			end
		end
	end
    
	table.sort(delves, function(a, b)
		if a.isBountiful and not b.isBountiful then
			return true
		elseif not a.isBountiful and b.isBountiful then
			return false
		else
			if a.hasStar and not b.hasStar then
				return true
			elseif not a.hasStar and b.hasStar then
				return false
			else
				if a.uiMapID ~= b.uiMapID then
					return a.uiMapID < b.uiMapID
				else
					return a.poiInfo.name < b.poiInfo.name
				end
			end
		end
	end)
    
    for _, delve in ipairs(delves) do
        rowIndex = rowIndex + 1
        
        local row = CreateFrame("Frame", nil, scrollChild)
        row:SetSize(380, 20)
        row:SetPoint("TOPLEFT", 0, -((rowIndex-1) * 22))
        
        row.mapText = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.mapText:SetPoint("LEFT", 10, 0)
        row.mapText:SetFont(GameFontNormal:GetFont(), 12)
        row.mapText:SetText(GetMapName(delve.uiMapID))
        
        row.nameText = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.nameText:SetPoint("LEFT", 120, 0)
        row.nameText:SetFont(GameFontNormal:GetFont(), 12)
        if delve.isBountiful then
            row.nameText:SetText("|A:delves-bountiful:18:18|a" .. delve.poiInfo.name)
            row.nameText:SetTextColor(0, 1, 0)
        else
            row.nameText:SetText(delve.poiInfo.name)
            row.nameText:SetTextColor(0.8, 0.8, 0.8)
        end
        
        row.variantText = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.variantText:SetPoint("LEFT", 250, 0)
        row.variantText:SetFont(GameFontNormal:GetFont(), 12)
        row.variantText:SetText(delve.storyVariant)
        
        if delve.isBountiful then
            row.variantText:SetTextColor(0, 1, 0)
        else
            row.variantText:SetTextColor(0.8, 0.8, 0.8)
        end
        if delve.hasStar then
            row:EnableMouse(true)
            
			row:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:ClearLines()
				GameTooltip:AddLine(DFCNL["NGA_RECOMMENDED_STORY"], 0.5, 0.5, 1)
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(DFCNL["NGA_RECOMMENDED_DETAIL"], 1, 1, 1)
				GameTooltip:Show()
			end)

			row:SetScript("OnLeave", function(self)
				GameTooltip:Hide()
			end)
        end
        frame.rows[rowIndex] = row
    end
    
    scrollChild:SetHeight(math.max(380, rowIndex * 22))
end

function DFCN.ToggleDelveInfoFrame()
    if not DFCN.delveInfoFrame then
        DFCN.CreateDelveInfoFrame()
    end
    
    if DFCN.delveInfoFrame:IsShown() then
        DFCN.delveInfoFrame:Hide()
    else
        DFCN.delveInfoFrame:Show()
        DFCN.UpdateDelveInfo()
    end
end

function DFCN.RefreshSettingsFrame()
    if not DFCN.settingsFrame then return end    
    DFCN.autoEnterCheckbox:Show()
    DFCN.autoEnterCheckbox:SetEnabled(true)
    DFCN.autoEnterCheckbox.text:SetTextColor(1, 1, 1)
end

function DFCN.CreateSettingsFrame()
    local frame = CreateFrame("Frame", "DFCN_DelveHelperSettingsFrame", UIParent, "BackdropTemplate")
	frame:SetFrameStrata("DIALOG")
    frame:SetSize(230, 380)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    tinsert(UISpecialFrames, frame:GetName())
	frame:SetScript("OnShow", function(self)
		if not DFCN.merchantFrame then
			DFCN.CreateMerchantFrame()
		end
		DFCN.merchantFrame:Show()
		
		if not DFCN.delveInfoFrame then
			DFCN.CreateDelveInfoFrame()
		end
		DFCN.delveInfoFrame:Show()
		DFCN.UpdateDelveInfo()
	end)
    frame:SetScript("OnHide", function(self)
        if DFCN.merchantFrame and DFCN.merchantFrame:IsShown() then
            DFCN.merchantFrame:Hide()
		end
		if DFCN.delveInfoFrame and DFCN.delveInfoFrame:IsShown() then
			DFCN.delveInfoFrame:Hide()
		end
			collectgarbage("collect")
    end)

    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, 
        tileSize = 16, 
        edgeSize = 4,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    frame:SetBackdropColor(0.1, 0.1, 0.1, 0.7)
    frame:SetBackdropBorderColor(0.4, 0.4, 0.4)
    
    local titleBg = frame:CreateTexture(nil, "BACKGROUND")
    titleBg:SetColorTexture(0.3, 0.3, 0.3, 0)
    titleBg:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
    titleBg:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -2)
    titleBg:SetHeight(24)
    
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.title:SetPoint("TOP", 0, -18)
	frame.title:SetFont(GameFontNormal:GetFont(), 16)
    frame.title:SetText("|TInterface\\icons\\ui_delves:16:16|t  " .. DFCNL["SETTINGS_TITLE"])
    frame.title:SetTextColor(0.95, 0.95, 0.32) 

    frame.versionText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.versionText:SetPoint("LEFT", frame.title, "RIGHT", 5, -3)
    frame.versionText:SetFont(GameFontNormal:GetFont(), 10)
    frame.versionText:SetText("v" .. DFCN.version)
    frame.versionText:SetTextColor(0.7, 0.7, 0.7)
    
    local closeButton = CreateFrame("Button", nil, frame)
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -2)
    closeButton:SetSize(24, 24)

    local closeText = closeButton:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    closeText:SetPoint("CENTER", closeButton, "CENTER")
	closeText:SetFont(GameFontNormal:GetFont(), 16)
    closeText:SetText("x")
    closeText:SetTextColor(1, 1, 1)

    closeButton:SetScript("OnEnter", function(self)
        closeText:SetTextColor(1, 0.82, 0)
    end)

    closeButton:SetScript("OnLeave", function(self)
        closeText:SetTextColor(1, 1, 1)
    end)

    closeButton:SetScript("OnClick", function()
        if DFCN.merchantFrame and DFCN.merchantFrame:IsShown() then
            DFCN.merchantFrame:Hide()
			collectgarbage("collect")
        end
        frame:Hide()
    end)


    local autoEnterCheckbox = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
    autoEnterCheckbox:SetPoint("TOPLEFT", 30, -45)
    autoEnterCheckbox:SetChecked(DFCN_DelveHelperDB.autoEnter)
    autoEnterCheckbox:SetScript("OnClick", function(self)
        if not self:IsEnabled() then return end
        
        DFCN_DelveHelperDB.autoEnter = self:GetChecked()
        
        if DFCN_DelveHelperDB.autoEnter then
            print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["SETTING_CHANGED"] .. "] " .. DFCNL["AUTO_ENTER_ENABLED"] .. "|r")
        else
            print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["SETTING_CHANGED"] .. "] " .. DFCNL["AUTO_ENTER_DISABLED"] .. "|r")
        end
    end)

	autoEnterCheckbox:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(DFCNL["AUTO_ENTER"])
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(DFCNL["AUTO_ENTER_TOOLTIP_DETAIL1"])
		GameTooltip:AddLine(DFCNL["AUTO_ENTER_TOOLTIP_DETAIL2"])
		GameTooltip:Show()
	end)

	autoEnterCheckbox:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
    
    autoEnterCheckbox.text = autoEnterCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    autoEnterCheckbox.text:SetPoint("LEFT", autoEnterCheckbox, "RIGHT", 5, 0)
	autoEnterCheckbox.text:SetFont(GameFontNormal:GetFont(), 14)
    autoEnterCheckbox.text:SetText(DFCNL["AUTO_ENTER"])
    autoEnterCheckbox.text:SetTextColor(1, 1, 1) 
    
    DFCN.autoEnterCheckbox = autoEnterCheckbox    

    local difficultyLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    difficultyLabel:SetPoint("TOPLEFT", 35, -85)
	difficultyLabel:SetFont(GameFontNormal:GetFont(), 14)
    difficultyLabel:SetText(DFCNL["DIFFICULTY_LABEL"])
    difficultyLabel:SetTextColor(1, 1, 1) 

    local fastExitCheckbox = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
    fastExitCheckbox:SetPoint("LEFT", difficultyLabel, "RIGHT", 15, 0)
    fastExitCheckbox:SetChecked(DFCN_DelveHelperDB.fastExitMode)
    fastExitCheckbox:SetScript("OnClick", function(self)
        DFCN_DelveHelperDB.fastExitMode = self:GetChecked()
        UpdateExitCooldownDuration()
        
        if self:GetChecked() then
            print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["SETTING_CHANGED"] .. "] " .. DFCNL["FAST_EXIT_ENABLED"] .. "|r")
        else
            print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["SETTING_CHANGED"] .. "] " .. DFCNL["FAST_EXIT_DISABLED"] .. "|r")
        end
    end)

	fastExitCheckbox:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(DFCNL["FAST_EXIT_MODE"])
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(DFCNL["FAST_EXIT_TOOLTIP_DETAIL1"])
		GameTooltip:AddLine(DFCNL["FAST_EXIT_TOOLTIP_DETAIL2"], 1, 0, 0)
		GameTooltip:Show()
	end)

	fastExitCheckbox:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	fastExitCheckbox.text = fastExitCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	fastExitCheckbox.text:SetPoint("LEFT", fastExitCheckbox, "RIGHT", 5, 0)
	fastExitCheckbox.text:SetFont(GameFontNormal:GetFont(), 13, "")
	fastExitCheckbox.text:SetText(DFCNL["FAST_EXIT_MODE"])
	fastExitCheckbox.text:SetTextColor(1, 1, 1)

	local font13 = CreateFont("DFCN_DelveHelperDifficultyFont13")
	font13:SetFont(GameFontNormal:GetFont(), 13, "")

	local dropdown = CreateFrame("Frame", "DFCN_DelveHelperDifficultyDropdown", frame, "UIDropDownMenuTemplate")
	dropdown:SetPoint("TOPLEFT", difficultyLabel, "BOTTOMLEFT", -20, -10)
	UIDropDownMenu_SetWidth(dropdown, 140) 
	UIDropDownMenu_SetText(dropdown, DFCN_DelveHelperDB.difficultyLevel and string.format(DFCNL["DIFFICULTY_LEVEL_FORMAT"], DFCN_DelveHelperDB.difficultyLevel) or DFCNL["CLOSE"])
	dropdown.Text:SetFontObject(font13)

	local function Difficulty_OnClick(self, arg1, arg2, checked)
		DFCN_DelveHelperDB.difficultyLevel = arg1
		UIDropDownMenu_SetText(dropdown, arg1 and string.format(DFCNL["DIFFICULTY_LEVEL_FORMAT"], arg1) or DFCNL["CLOSE"])
		
		if arg1 then
			print(string.format("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["SETTING_CHANGED"] .. "] " .. DFCNL["DIFFICULTY_SET"] .. "|r", arg1))
		else
			print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["SETTING_CHANGED"] .. "] " .. DFCNL["DIFFICULTY_UNSET"] .. "|r")
		end
	end

	UIDropDownMenu_Initialize(dropdown, function(self, level)
		UIDropDownMenu_SetWidth(self, 140)
		
		local info = UIDropDownMenu_CreateInfo()
		info.text = DFCNL["CLOSE"]
		info.arg1 = nil
		info.func = Difficulty_OnClick
		info.minWidth = 130
		info.notCheckable = true
		info.leftPadding = 10
		info.fontObject = font13
		UIDropDownMenu_AddButton(info)
		
		for i = 1, 11 do
			info = UIDropDownMenu_CreateInfo()
			info.text = string.format(DFCNL["DIFFICULTY_LEVEL_FORMAT"], i)
			info.arg1 = i
			info.func = Difficulty_OnClick
			info.minWidth = 130
			info.notCheckable = true
			info.leftPadding = 10
			info.fontObject = font13
			UIDropDownMenu_AddButton(info)
		end
		
		local listFrame = _G[self:GetName().."List"]
		if listFrame then
			listFrame:SetWidth(150)
		end
	end)

    local scoreboardCheckbox = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
	scoreboardCheckbox:SetPoint("TOPLEFT", dropdown, "BOTTOMLEFT", 15, 0)
	scoreboardCheckbox:SetChecked(DFCN_DelveHelperDB.scoreboardEnabled)
	scoreboardCheckbox:SetScript("OnClick", function(self)
		DFCN_DelveHelperDB.scoreboardEnabled = self:GetChecked()
		if self:GetChecked() then
            DFCN.CreateScoreboard()
            print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["SETTING_CHANGED"] .. "] " .. DFCNL["SCOREBOARD_ENABLED"] .. "|r")
			if IsInDelvesScenario() then
				DFCN.scoreboardFrame:Show()
			end
		else
            if DFCN.scoreboardFrame then
                DFCN.scoreboardFrame:Hide()
            end
			print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["SETTING_CHANGED"] .. "] " .. DFCNL["SCOREBOARD_DISABLED"] .. "|r")
		end
	end)

	scoreboardCheckbox:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(DFCNL["SHOW_SCOREBOARD"])
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(DFCNL["SCOREBOARD_TOOLTIP_DETAIL1"])
		GameTooltip:AddLine(DFCNL["SCOREBOARD_TOOLTIP_DETAIL2"])
		GameTooltip:AddLine(DFCNL["SCOREBOARD_TOOLTIP_DETAIL3"])
		GameTooltip:Show()
	end)

	scoreboardCheckbox:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	scoreboardCheckbox.text = scoreboardCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	scoreboardCheckbox.text:SetPoint("LEFT", scoreboardCheckbox, "RIGHT", 5, 0)
	scoreboardCheckbox.text:SetFont(GameFontNormal:GetFont(), 14)
	scoreboardCheckbox.text:SetText(DFCNL["SHOW_SCOREBOARD"])
	scoreboardCheckbox.text:SetTextColor(1, 1, 1)

    local treasureMapCheckbox = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
    treasureMapCheckbox:SetPoint("TOPLEFT", scoreboardCheckbox, "BOTTOMLEFT", 0, 0) 
    treasureMapCheckbox:SetChecked(DFCN_DelveHelperDB.treasureMapAlertEnabled)
    treasureMapCheckbox:SetScript("OnClick", function(self)
        DFCN_DelveHelperDB.treasureMapAlertEnabled = self:GetChecked()
        if self:GetChecked() then
            print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["SETTING_CHANGED"] .. "] " .. DFCNL["TREASURE_MAP_ENABLED"] .. "|r")
        else
            print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["SETTING_CHANGED"] .. "] " .. DFCNL["TREASURE_MAP_DISABLED"] .. "|r")
        end
    end)

	treasureMapCheckbox:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(DFCNL["TREASURE_MAP_ALERT"])
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(DFCNL["TREASURE_MAP_TOOLTIP_DETAIL1"])
		GameTooltip:AddLine(DFCNL["TREASURE_MAP_TOOLTIP_DETAIL2"])
		GameTooltip:Show()
	end)

	treasureMapCheckbox:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

    treasureMapCheckbox.text = treasureMapCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    treasureMapCheckbox.text:SetPoint("LEFT", treasureMapCheckbox, "RIGHT", 5, 0)
	treasureMapCheckbox.text:SetFont(GameFontNormal:GetFont(), 14)
    treasureMapCheckbox.text:SetText(DFCNL["TREASURE_MAP_ALERT"])
    treasureMapCheckbox.text:SetTextColor(1, 1, 1)

    local autoActivateCheckbox = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
    autoActivateCheckbox:SetPoint("TOPLEFT", treasureMapCheckbox, "BOTTOMLEFT", 0, 0)
    autoActivateCheckbox:SetChecked(DFCN_DelveHelperDB.autoActivateDelve)
    autoActivateCheckbox:SetScript("OnClick", function(self)
        DFCN_DelveHelperDB.autoActivateDelve = self:GetChecked()
        if self:GetChecked() then
            print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["SETTING_CHANGED"] .. "] " .. DFCNL["AUTO_ACTIVATE_ENABLED"] .. "|r")
        else
            print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["SETTING_CHANGED"] .. "] " .. DFCNL["AUTO_ACTIVATE_DISABLED"] .. "|r")
        end
    end)

	autoActivateCheckbox:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(DFCNL["AUTO_ACTIVATE"])
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(DFCNL["AUTO_ACTIVATE_TOOLTIP_DETAIL1"])
		GameTooltip:AddLine(DFCNL["AUTO_ACTIVATE_TOOLTIP_DETAIL2"])
		GameTooltip:Show()
	end)

	autoActivateCheckbox:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

    autoActivateCheckbox.text = autoActivateCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    autoActivateCheckbox.text:SetPoint("LEFT", autoActivateCheckbox, "RIGHT", 5, 0)
	autoActivateCheckbox.text:SetFont(GameFontNormal:GetFont(), 14)
    autoActivateCheckbox.text:SetText(DFCNL["AUTO_ACTIVATE"])
    autoActivateCheckbox.text:SetTextColor(1, 1, 1)
    
	local autoPetCageCheckbox = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
	autoPetCageCheckbox:SetPoint("TOPLEFT", autoActivateCheckbox, "BOTTOMLEFT", 0, 0)
	autoPetCageCheckbox:SetChecked(DFCN_DelveHelperDB.autoPetCage)
	autoPetCageCheckbox:SetScript("OnClick", function(self)
		DFCN_DelveHelperDB.autoPetCage = self:GetChecked()
		if self:GetChecked() then
			print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["SETTING_CHANGED"] .. "] " .. DFCNL["AUTO_PET_CAGE_ENABLED"] .. "|r")
			DFCN.InitPetAutoCage()
		else
			print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["SETTING_CHANGED"] .. "] " .. DFCNL["AUTO_PET_CAGE_DISABLED"] .. "|r")
		end
	end)

	autoPetCageCheckbox:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(DFCNL["AUTO_PET_CAGE"])
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(DFCNL["AUTO_PET_CAGE_TOOLTIP_DETAIL1"])
		GameTooltip:AddLine(DFCNL["AUTO_PET_CAGE_TOOLTIP_DETAIL2"])
		GameTooltip:AddLine(DFCNL["AUTO_PET_CAGE_TOOLTIP_DETAIL3"])
		GameTooltip:Show()
	end)

	autoPetCageCheckbox:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	autoPetCageCheckbox.text = autoPetCageCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	autoPetCageCheckbox.text:SetPoint("LEFT", autoPetCageCheckbox, "RIGHT", 5, 0)
	autoPetCageCheckbox.text:SetFont(GameFontNormal:GetFont(), 14)
	autoPetCageCheckbox.text:SetText(DFCNL["AUTO_PET_CAGE"])
	autoPetCageCheckbox.text:SetTextColor(1, 1, 1)

    local autoTokenConfirmCheckbox = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
    autoTokenConfirmCheckbox:SetPoint("TOPLEFT", autoPetCageCheckbox, "BOTTOMLEFT", 0, 0)
    autoTokenConfirmCheckbox:SetChecked(DFCN_DelveHelperDB.autoTokenExchange)
    autoTokenConfirmCheckbox:SetScript("OnClick", function(self)
        DFCN_DelveHelperDB.autoTokenExchange = self:GetChecked()
        if self:GetChecked() then
            print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["SETTING_CHANGED"] .. "] " .. DFCNL["AUTO_TOKEN_EXCHANGE_ENABLED"] .. "|r")
        else
            print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["SETTING_CHANGED"] .. "] " .. DFCNL["AUTO_TOKEN_EXCHANGE_DISABLED"] .. "|r")
        end
    end)

	autoTokenConfirmCheckbox:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(DFCNL["AUTO_TOKEN_EXCHANGE"])
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(DFCNL["AUTO_TOKEN_EXCHANGE_TOOLTIP_DETAIL1"])
		GameTooltip:AddLine(DFCNL["AUTO_TOKEN_EXCHANGE_TOOLTIP_DETAIL2"])
		GameTooltip:Show()
	end)

	autoTokenConfirmCheckbox:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

    autoTokenConfirmCheckbox.text = autoTokenConfirmCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    autoTokenConfirmCheckbox.text:SetPoint("LEFT", autoTokenConfirmCheckbox, "RIGHT", 5, 0)
	autoTokenConfirmCheckbox.text:SetFont(GameFontNormal:GetFont(), 14)
    autoTokenConfirmCheckbox.text:SetText(DFCNL["AUTO_TOKEN_EXCHANGE"])
    autoTokenConfirmCheckbox.text:SetTextColor(1, 1, 1)

    local merchantBtn = CreateFrame("Button", nil, frame)
    merchantBtn:SetSize(150, 24	)
    merchantBtn:SetPoint("BOTTOM", 0, 50)

    merchantBtn.BorderTop = merchantBtn:CreateTexture(nil, "BORDER")
    merchantBtn.BorderTop:SetPoint("TOPLEFT", 0, 0)
    merchantBtn.BorderTop:SetPoint("TOPRIGHT", 0, 0)
    merchantBtn.BorderTop:SetHeight(1)
    merchantBtn.BorderTop:SetColorTexture(1, 1, 1, 0.7)
    
    merchantBtn.BorderBottom = merchantBtn:CreateTexture(nil, "BORDER")
    merchantBtn.BorderBottom:SetPoint("BOTTOMLEFT", 0, 0)
    merchantBtn.BorderBottom:SetPoint("BOTTOMRIGHT", 0, 0)
    merchantBtn.BorderBottom:SetHeight(1)
    merchantBtn.BorderBottom:SetColorTexture(1, 1, 1, 0.7)
    
    merchantBtn.BorderLeft = merchantBtn:CreateTexture(nil, "BORDER")
    merchantBtn.BorderLeft:SetPoint("TOPLEFT", 0, 0)
    merchantBtn.BorderLeft:SetPoint("BOTTOMLEFT", 0, 0)
    merchantBtn.BorderLeft:SetWidth(1)
    merchantBtn.BorderLeft:SetColorTexture(1, 1, 1, 0.7)
    
    merchantBtn.BorderRight = merchantBtn:CreateTexture(nil, "BORDER")
    merchantBtn.BorderRight:SetPoint("TOPRIGHT", 0, 0)
    merchantBtn.BorderRight:SetPoint("BOTTOMRIGHT", 0, 0)
    merchantBtn.BorderRight:SetWidth(1)
    merchantBtn.BorderRight:SetColorTexture(1, 1, 1, 0.7)
    
    merchantBtn.text = merchantBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    merchantBtn.text:SetPoint("CENTER")
	merchantBtn.text:SetFont(GameFontNormal:GetFont(), 13)
    merchantBtn.text:SetText(DFCNL["VIEW_MERCHANT"])
    merchantBtn.text:SetTextColor(1, 1, 1)

    merchantBtn:SetScript("OnMouseDown", function(self)
        self.text:SetPoint("CENTER", 1, -1)
    end)
    
    merchantBtn:SetScript("OnMouseUp", function(self)
        self.text:SetPoint("CENTER", 0, 0)
    end)
    
	merchantBtn:SetScript("OnEnter", function(self)
		self.BorderTop:SetColorTexture(1, 0.8, 0)
		self.BorderBottom:SetColorTexture(1, 0.8, 0)
		self.BorderLeft:SetColorTexture(1, 0.8, 0)
		self.BorderRight:SetColorTexture(1, 0.8, 0)
		self.text:SetTextColor(1, 0.8, 0)
	end)
    
	merchantBtn:SetScript("OnLeave", function(self)
		self.BorderTop:SetColorTexture(1, 1, 1, 0.7)
		self.BorderBottom:SetColorTexture(1, 1, 1, 0.7)
		self.BorderLeft:SetColorTexture(1, 1, 1, 0.7)
		self.BorderRight:SetColorTexture(1, 1, 1, 0.7)
		self.text:SetTextColor(1, 1, 1)
	end)
    
	merchantBtn:SetScript("OnClick", function()
		DFCN.ToggleMerchantFrame()
		
		if DFCN.merchantFrame and DFCN.merchantFrame:IsShown() then
			C_Timer.After(0, function()
				DFCN.UpdateMerchantItems(DFCN.merchantFrame.currentDate or date("*t"))
			end)
		end
	end)

	local delveInfoBtn = CreateFrame("Button", nil, frame)
	delveInfoBtn:SetSize(150, 24)
	delveInfoBtn:SetPoint("TOP", merchantBtn, "BOTTOM", 0, -10)

	delveInfoBtn.BorderTop = delveInfoBtn:CreateTexture(nil, "BORDER")
	delveInfoBtn.BorderTop:SetPoint("TOPLEFT", 0, 0)
	delveInfoBtn.BorderTop:SetPoint("TOPRIGHT", 0, 0)
	delveInfoBtn.BorderTop:SetHeight(1)
	delveInfoBtn.BorderTop:SetColorTexture(1, 1, 1, 0.7)

	delveInfoBtn.BorderBottom = delveInfoBtn:CreateTexture(nil, "BORDER")
	delveInfoBtn.BorderBottom:SetPoint("BOTTOMLEFT", 0, 0)
	delveInfoBtn.BorderBottom:SetPoint("BOTTOMRIGHT", 0, 0)
	delveInfoBtn.BorderBottom:SetHeight(1)
	delveInfoBtn.BorderBottom:SetColorTexture(1, 1, 1, 0.7)

	delveInfoBtn.BorderLeft = delveInfoBtn:CreateTexture(nil, "BORDER")
	delveInfoBtn.BorderLeft:SetPoint("TOPLEFT", 0, 0)
	delveInfoBtn.BorderLeft:SetPoint("BOTTOMLEFT", 0, 0)
	delveInfoBtn.BorderLeft:SetWidth(1)
	delveInfoBtn.BorderLeft:SetColorTexture(1, 1, 1, 0.7)

	delveInfoBtn.BorderRight = delveInfoBtn:CreateTexture(nil, "BORDER")
	delveInfoBtn.BorderRight:SetPoint("TOPRIGHT", 0, 0)
	delveInfoBtn.BorderRight:SetPoint("BOTTOMRIGHT", 0, 0)
	delveInfoBtn.BorderRight:SetWidth(1)
	delveInfoBtn.BorderRight:SetColorTexture(1, 1, 1, 0.7)

	delveInfoBtn.text = delveInfoBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	delveInfoBtn.text:SetPoint("CENTER")
	delveInfoBtn.text:SetFont(GameFontNormal:GetFont(), 13)
	delveInfoBtn.text:SetText(DFCNL["VIEW_DELVE_INFO"])
	delveInfoBtn.text:SetTextColor(1, 1, 1)

	delveInfoBtn:SetScript("OnMouseDown", function(self)
		self.text:SetPoint("CENTER", 1, -1)
	end)

	delveInfoBtn:SetScript("OnMouseUp", function(self)
		self.text:SetPoint("CENTER", 0, 0)
	end)

	delveInfoBtn:SetScript("OnEnter", function(self)
		self.BorderTop:SetColorTexture(1, 0.8, 0)
		self.BorderBottom:SetColorTexture(1, 0.8, 0)
		self.BorderLeft:SetColorTexture(1, 0.8, 0)
		self.BorderRight:SetColorTexture(1, 0.8, 0)
		self.text:SetTextColor(1, 0.8, 0)
	end)
	delveInfoBtn:SetScript("OnLeave", function(self)
		self.BorderTop:SetColorTexture(1, 1, 1, 0.7)
		self.BorderBottom:SetColorTexture(1, 1, 1, 0.7)
		self.BorderLeft:SetColorTexture(1, 1, 1, 0.7)
		self.BorderRight:SetColorTexture(1, 1, 1, 0.7)
		self.text:SetTextColor(1, 1, 1)
	end)
	delveInfoBtn:SetScript("OnClick", function()
		DFCN.ToggleDelveInfoFrame()
		
		if DFCN.delveInfoFrame and DFCN.delveInfoFrame:IsShown() then
			C_Timer.After(0, function()
				DFCN.UpdateDelveInfo()
			end)
		end
	end)

	frame:Hide()
    DFCN.settingsFrame = frame
    DFCN.RefreshSettingsFrame()
end

function DFCN.CreateMerchantFrame()
    if DFCN.merchantFrame then return end
    
    local parent = DFCN.settingsFrame
    local frame = CreateFrame("Frame", "DFCN_DelveHelperMerchantFrame", UIParent, "BackdropTemplate")
    frame:SetSize(270, 380)
	frame:SetFrameStrata("DIALOG")
    frame:SetPoint("RIGHT", parent, "LEFT", 2, 0)
    frame:SetFrameLevel(parent:GetFrameLevel() + 10)
    
    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, 
        tileSize = 16, 
        edgeSize = 4,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
	frame:SetBackdropColor(0.1, 0.1, 0.1, 0.7)
	frame:SetBackdropBorderColor(0.4, 0.4, 0.4)
	frame.dateLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.dateLabel:SetPoint("TOPLEFT", 10, -18)
	frame.dateLabel:SetFont(GameFontNormal:GetFont(), 14)
	frame.dateLabel:SetText(DFCNL["REFRESH_TIME"])
	frame.dateLabel:SetTextColor(1, 1, 1)

	frame.datePicker = CreateFrame("Frame", "DFCN_DelveHelperMerchantDatePicker", frame, "UIDropDownMenuTemplate")
	frame.datePicker:SetPoint("LEFT", frame.dateLabel, "RIGHT", 0, -1)
	UIDropDownMenu_SetWidth(frame.datePicker, 120)

	local font13 = CreateFont("DFCN_DelveHelperDropDownFont13")
	font13:SetFont(GameFontNormal:GetFont(), 13, "")

	UIDropDownMenu_Initialize(frame.datePicker, function(self, level)
		local today = date("*t")
		local info = UIDropDownMenu_CreateInfo()
		
		local todayText = format(DFCNL["CURRENT_DATE"], today.month, today.day)
		info.text = todayText
		info.arg1 = today
		info.fontObject = font13
		info.func = function(_, arg) 
			UIDropDownMenu_SetText(frame.datePicker, todayText)
			DFCN.UpdateMerchantItems(arg)
			C_Timer.After(0, function()
				DFCN.UpdateMerchantItems(arg)
			end)
		end
		UIDropDownMenu_AddButton(info)
		
		for i = 1, 4 do
			local dateInfo = date("*t", time() + 86400 * i)
			local dateStr = GetLocalizedDate(dateInfo.day, dateInfo.month)
			
			local info = UIDropDownMenu_CreateInfo()
			info.text = dateStr
			info.arg1 = dateInfo
			info.fontObject = font13
			
			info.func = (function(dateText)
				return function(_, arg)
					UIDropDownMenu_SetText(frame.datePicker, dateText)
					DFCN.UpdateMerchantItems(arg)
				end
			end)(dateStr)
			
			UIDropDownMenu_AddButton(info)
		end
	end)

	local today = date("*t")
	UIDropDownMenu_SetText(frame.datePicker, format(DFCNL["CURRENT_DATE"], today.month, today.day))
	frame.datePicker.Text:SetFontObject(font13)
	frame.itemsFrame = CreateFrame("Frame", nil, frame)
	frame.itemsFrame:SetPoint("TOPLEFT", 10, -40)
	frame.itemsFrame:SetPoint("BOTTOMRIGHT", -10, 10)

	frame.items = {}
	for i = 1, 7 do
		local item = CreateFrame("Button", "DFCN_DelveHelperMerchantItem"..i, frame.itemsFrame)
		item:SetSize(260, 42)
		item:SetPoint("TOPLEFT", 0, -((i-1) * 42))
		item.icon = item:CreateTexture(nil, "ARTWORK")
		item.icon:SetSize(32, 32)
		item.icon:SetPoint("LEFT", 5, 0)
		
		item.name = item:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		item.name:SetPoint("LEFT", item.icon, "RIGHT", 8, 0)
		item.name:SetSize(210, 36)
		item.name:SetFont(GameFontNormal:GetFont(), 14)
		item.name:SetTextColor(1, 1, 1)
		item.name:SetJustifyH("LEFT")
		
		item.bg = item:CreateTexture(nil, "BACKGROUND")
		if i % 2 == 1 then
			item.bg:SetColorTexture(0.15, 0.15, 0.15, 0.3)
		else
			item.bg:SetColorTexture(0.2, 0.2, 0.2, 0.3)
		end
		item.bg:SetAllPoints()
		
		frame.items[i] = item
	end
    
    frame:Hide()
    DFCN.merchantFrame = frame
    
    DFCN.UpdateMerchantItems(today)
end

local function CreateFullItemLink(itemID, suffix)
    local itemName = C_Item.GetItemInfo(itemID) or DFCNL["UNKNOWN_ITEM"]
    return format("|cnIQ4:|Hitem:%d%s|h[%s]|h|r", 
                 itemID, 
                 suffix, 
                 itemName)
end

function DFCN.UpdateMerchantItems(dateTable)
    if not DFCN.merchantFrame then return end
    
    local availableItems = GetMerchantItemsForDate(dateTable)
    
    for _, itemFrame in ipairs(DFCN.merchantFrame.items) do
        itemFrame:Hide()
    end

    for i, item in ipairs(availableItems) do
        if i > 8 then break end
        
        local itemFrame = DFCN.merchantFrame.items[i]        
        local fullLink = CreateFullItemLink(item.itemID, item.suffix)
        itemFrame.name:SetText(fullLink)
        itemFrame.name:SetFont(GameFontNormal:GetFont(), 14)
        local icon = select(10, C_Item.GetItemInfo(item.itemID))
        itemFrame.icon:SetTexture(icon or "Interface\\Icons\\INV_Misc_QuestionMark")

        itemFrame:SetScript("OnClick", function(self, button)
            if IsShiftKeyDown() then
                HandleModifiedItemClick(fullLink)
            end
        end)
        
        itemFrame:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(fullLink)
            GameTooltip:Show()
        end)
        
        itemFrame:SetScript("OnLeave", GameTooltip_Hide)
        
        itemFrame:Show()
    end
    
    C_Timer.After(0, function()
        for i, item in ipairs(availableItems) do
            if i > 8 then break end
            
            local itemFrame = DFCN.merchantFrame.items[i]
            local updatedLink = CreateFullItemLink(item.itemID, item.suffix)
            itemFrame.name:SetText(updatedLink)
            
            local icon = select(10, C_Item.GetItemInfo(item.itemID))
            if icon then
                itemFrame.icon:SetTexture(icon)
            end
        end
    end)
end

function DFCN.ToggleMerchantFrame()
    if not DFCN.merchantFrame then
        DFCN.CreateMerchantFrame()
    end
    
    if DFCN.merchantFrame:IsShown() then
        DFCN.merchantFrame:Hide()
    else
        DFCN.merchantFrame:Show()
    end
end

local function FindAndClickSelectButton()
    local function FindButtonRecursive(frame)
	if not frame or frame:IsForbidden() then return false end
        
        if frame:GetObjectType() == "Button" and frame:IsVisible() and frame:IsEnabled() and frame.GetText then
            local text = frame:GetText()
            if text and text:find(DFCNL["SELECT_BUTTON_PATTERN"]) then
                frame:Click()

                if PlayerChoiceFrame and PlayerChoiceFrame:IsShown() then
                    PlayerChoiceFrame:Hide()
                end

                return true
            end
        end
        
        if frame.GetNumChildren then
            local children = {frame:GetChildren()}
            for _, child in ipairs(children) do
                if FindButtonRecursive(child) then
                    return true
                end
            end
        end
        
        return false
    end
    
    return FindButtonRecursive(PlayerChoiceFrame)
end

local function ShouldAutoEnter()
    return DFCN_DelveHelperDB.autoEnter
end

local function IsDelvesGossip()
    if DelvesDifficultyPickerFrame and DelvesDifficultyPickerFrame:IsShown() then
        return true
    end    
    return false
end

local function AutoSelectAndEnter()
    if not ShouldAutoEnter() then return end
    
    local gossipOptions = C_GossipInfo.GetOptions()
    local gossipText = C_GossipInfo.GetText()
    local DelvesName = DFCNL["UNKNOWN_DELVE"]
    
    if gossipText and gossipText ~= "" then
        DelvesName = gossipText
    end
    
    local hasSpecialDifficulty = false
    
    if gossipOptions then
        for _, option in ipairs(gossipOptions) do
            local optionText = StripColorCodes(option.name or "")
            if optionText:find(DFCNL["SPECIAL_DIFFICULTY_PATTERN"]) then
                hasSpecialDifficulty = true
                break
            end
        end
    end
    
    if hasSpecialDifficulty then
        print("|TInterface\\icons\\ui_delves:14:14|t |cFFFFA500[" .. DFCNL["WARNING"] .. "] " .. DFCNL["SPECIAL_DELVE_WARNING"] .. "|r")
        return
    end
    
    local level = DFCN_DelveHelperDB.difficultyLevel
    if level and level >= 1 and level <= 11 then
        local targetOrderIndex = level - 1        
        C_GossipInfo.SelectOptionByIndex(targetOrderIndex)
		
        print(string.format("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["INFO"] .. "] " .. DFCNL["AUTO_ENTER_MESSAGE"] .. "|r", DelvesName, level))
    else
        print("|TInterface\\icons\\ui_delves:14:14|t |cFFFFA500[" .. DFCNL["WARNING"] .. "] " .. DFCNL["SELECT_DIFFICULTY_WARNING"] .. "|r")
    end
end

function DFCN.DelayedScoreboardRefresh(delay)
    if DFCN.scoreboardUpdateTimer then
        DFCN.scoreboardUpdateTimer:Cancel()
    end
    
    DFCN.scoreboardUpdateTimer = C_Timer.NewTimer(delay, function()
        DFCN.scoreboardUpdateTimer = nil
        DFCN.UpdateScoreboard()	
		DFCN.UpdateCompanionIcons()
    end)
end

function DFCN.StartPeriodicUpdateTimer()
    if DFCN.periodicUpdateTimer then
        DFCN.periodicUpdateTimer:Cancel()
    end
    
    DFCN.periodicUpdateTimer = C_Timer.NewTicker(30, function()
        if not DFCN.scoreboardFrame or not DFCN.scoreboardFrame:IsShown() then return end
        DFCN.UpdateScoreboard()
    end)
end

function DFCN.StopPeriodicUpdateTimer()
    if DFCN.periodicUpdateTimer then
        DFCN.periodicUpdateTimer:Cancel()
        DFCN.periodicUpdateTimer = nil
    end
end

function CheckForExistingDelveTimer()
    if IsInDelvesScenario() then
        local key = GetCharacterKey()
        local charDB = DFCN_DelveHelperDB.characters[key]
        
        if charDB then
            if charDB.delveCompleted ~= nil then
                DFCN.delveCompleted = charDB.delveCompleted
            end

            if DFCN.delveCompleted then
                if charDB.delveStartTime then
                    DFCN.delveStartServerTime = charDB.delveStartTime
                    DFCN.delveCompletionTime = charDB.delveCompletionTime
                end
                
                if DFCN_DelveHelperDB.scoreboardEnabled then
                    local frame = DFCN.CreateScoreboard()
                    frame:Show()
                    DFCN.UpdateScoreboard()
                end
            else
                if charDB.delveStartTime and not DFCN.delveCompleted then
                    local now = GetServerTime()
                    local timeDiff = now - charDB.delveStartTime
                    local maxDuration = 120 * 60
                    
                    if timeDiff > maxDuration then
                        DFCN.delveStartServerTime = now
                        charDB.delveStartTime = now
                    else
                        DFCN.delveStartServerTime = charDB.delveStartTime
                    end
                    
                    if DFCN.delveTimer then
                        DFCN.delveTimer:Cancel()
                    end
                    
                    DFCN.delveTimer = C_Timer.NewTicker(1, function()
                        if not DFCN.scoreboardFrame or not DFCN.scoreboardFrame:IsShown() then return end
                        
                        local now = GetServerTime()
                        local duration = now - DFCN.delveStartServerTime
                        
                        DFCN.scoreboardFrame.duration.value:SetText(FormatTime(duration, false))
                    end)
                    
                    if DFCN_DelveHelperDB.scoreboardEnabled then
                        local frame = DFCN.CreateScoreboard()
                        frame:Show()
                        DFCN.UpdateScoreboard()
                    end
                end
            end
        end
    end
end

function DFCN.CreateTreasureBuffAlert()
    if not DFCN_DelveHelperDB.treasureMapAlertEnabled then
        return
    end
    
    if DFCN.treasureBuffAlert then return end
    
    local alert = CreateFrame("Frame", nil, UIParent)
    alert:SetSize(800, 120)
    alert:SetPoint("CENTER", 0, 350)
    alert:SetFrameStrata("FULLSCREEN_DIALOG")
    
    alert.text = alert:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    alert.text:SetPoint("CENTER")
    alert.text:SetText("|T1064187:14:14|t |cFFFF0000" .. DFCNL["TREASURE_BUFF_WRONG_LEVEL"] .. "|r")
       
    alert:Hide()
    DFCN.treasureBuffAlert = alert
    
    local originalShow = alert.Show
    alert.Show = function(self, ...)
        if not DFCN_DelveHelperDB.treasureMapAlertEnabled then
            return
        end
        originalShow(self, ...)
        C_Timer.After(3, function()
            DFCN.PlayCustomSound("TreasureBuffAlert.ogg")
            DFCN.BrannSay(DFCNL["BRANN_TREASURE_WARNING"])
        end)        
    end
end

local function HandleTokenExchange(popupName, ...)
    local n = select('#', ...)
    local argParts = {}
    
    for i = 1, n do
        local arg = select(i, ...)
        local argType = type(arg)
        
        if argType == "table" then
            table.insert(argParts, "table")
        else
            table.insert(argParts, tostring(arg))
        end
    end
    
    local argStr = table.concat(argParts, ", ")    
    
    if popupName ~= "CONFIRM_PURCHASE_NONREFUNDABLE_ITEM" then
        return
    end
    
    local itemName = select(1, ...) or ""    
    local itemInfo = select(3, ...)
    local actualItemName = ""
    if type(itemInfo) == "table" and type(itemInfo.name) == "string" then
        actualItemName = itemInfo.name
    end
    
    if actualItemName:find(DFCNL["ENCHANTED_ITEM_PATTERN"]) or actualItemName:find(DFCNL["MATRIX_ITEM_PATTERN"]) then
        return
    end
    
    local isTokenExchange = itemName:find(DFCNL["CREST_PATTERN"]) ~= nil
    
    if not isTokenExchange then
        return
    end
    
    if not DFCN_DelveHelperDB.autoTokenExchange then
        return
    end
    
    if itemName:match("45") then
        local confirmButton = _G["StaticPopup1Button1"]
        if confirmButton and confirmButton:IsEnabled() then
            confirmButton:Click()
            print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["INFO"] .. "] " .. DFCNL["TOKEN_EXCHANGE_CONFIRMED"] .. "|r")
        end
    elseif itemName:match("15") then
        print("|TInterface\\icons\\ui_delves:14:14|t |cFFFFA500[" .. DFCNL["WARNING"] .. "] " .. DFCNL["ADVANCED_TOKEN_WARNING"] .. "|r")      
    end
end

function DFCN.CheckAndShowTreasureMapAlert()
    if not DFCN_DelveHelperDB.treasureMapAlertEnabled then
        if DFCN.treasureMapAlert and DFCN.treasureMapAlert:IsShown() then
            DFCN.treasureMapAlert:Hide()
        end
        DFCN.inDelveWithMap = false
        return
    end
    if not DFCN.treasureMapAlert then
        if not DFCN_DelveHelperDB.treasureMapAlertEnabled then
            return
        end
        DFCN.treasureMapAlert = CreateFrame("Frame", nil, UIParent)
        DFCN.treasureMapAlert:SetSize(800, 120)
        DFCN.treasureMapAlert:SetPoint("CENTER", 0, 350)
        DFCN.treasureMapAlert:SetFrameStrata("FULLSCREEN_DIALOG")
        
        DFCN.treasureMapAlert.text = DFCN.treasureMapAlert:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        DFCN.treasureMapAlert.text:SetPoint("CENTER")
        DFCN.treasureMapAlert.text:SetText("|T1064187:14:14|t |cFFFF0000" .. DFCNL["TREASURE_MAP_REMINDER"] .. "|r") 
        
        DFCN.treasureMapAlert:Hide()
    end
    if IsInDelvesScenario() then
        local mapCount = GetItemCount(248142)
        local difficultyLevel, _, isAbundant = GetDelveInfo()
        difficultyLevel = difficultyLevel or 0
        
        if mapCount > 0 and not DFCN.inDelveWithMap and difficultyLevel == 11 then
            DFCN.treasureMapAlert:Show()
            DFCN.inDelveWithMap = true
            C_Timer.After(2, function()
                DFCN.PlayCustomSound("TreasureMapAlert.ogg")
                DFCN.BrannSay(DFCNL["BRANN_TREASURE_REMINDER"])
            end)            
        elseif (mapCount == 0 and DFCN.inDelveWithMap) or (difficultyLevel ~= 11 and DFCN.inDelveWithMap) then
            DFCN.treasureMapAlert:Hide()
            DFCN.inDelveWithMap = false
        end
    else
        DFCN.treasureMapAlert:Hide()
        DFCN.inDelveWithMap = false
    end
end

local function SetupBigWigsMessageListener()
    if not _G.BigWigsLoader then
        return
    end

    BigWigsLoader.RegisterMessage(DFCN, "BigWigs_Message", function(event, sender, nilParam, message, color, icon, nilParam2, duration, ...)
        if message and message:find(DFCNL["BIGWIGS_FLASHING_DOOR_SPAWN"]) then
            local key = GetCharacterKey()
            DFCN_DelveHelperDB.characters[key] = DFCN_DelveHelperDB.characters[key] or {}            

            if DFCN_DelveHelperDB.characters[key].flashingDoorActivated == nil then
                DFCN_DelveHelperDB.characters[key].flashingDoorActivated = false
            end
           
            if DFCN_DelveHelperDB.scoreboardEnabled then
				if not DFCN.scoreboardFrame then
					DFCN.CreateScoreboard()
				end
				DFCN.scoreboardFrame:Show()
                DFCN.scoreboardFrame.flashingDoorIcon:Show()
                DFCN.scoreboardFrame.flashingDoorText:Show()
				DFCN.scoreboardFrame.flashingDoorText:SetText(" " .. DFCNL["FLASHING_DOOR"])
                DFCN.scoreboardFrame.flashingDoorText:SetTextColor(0.1, 0.4, 0.9)
                DFCN.scoreboardFrame.flashingDoorIcon:SetTexture("Interface\\Icons\\INV_112_RaidTrinkets_BlobOfSwirlingVoid_purple")
            end
            
            local _, _, isAbundant = GetDelveInfo()
            DFCN.isAbundant = isAbundant
            
            if not DFCN_DelveHelperDB.characters[key].flashingDoorDetected and not DFCN.isAbundant then
                DFCN.PlayCustomSound("flashingdoor.ogg")
                DFCN.BrannSay(DFCNL["BRANN_FLASHING_DOOR"])
            end

			DFCN_DelveHelperDB.characters[key].flashingDoorDetected = true
            
        elseif message and message:find(DFCNL["BIGWIGS_FLASHING_DOOR_COMPLETE"]) then
            local key = GetCharacterKey()
            DFCN_DelveHelperDB.characters[key] = DFCN_DelveHelperDB.characters[key] or {}
            DFCN_DelveHelperDB.characters[key].flashingDoorDetected = true
            DFCN_DelveHelperDB.characters[key].flashingDoorActivated = true
            
            if DFCN_DelveHelperDB.scoreboardEnabled and DFCN.scoreboardFrame then
                DFCN.scoreboardFrame.flashingDoorIcon:Show()
                DFCN.scoreboardFrame.flashingDoorText:Show()
                DFCN.scoreboardFrame.flashingDoorText:SetText(" " .. DFCNL["FLASHING_DOOR_USED"])
                DFCN.scoreboardFrame.flashingDoorText:SetTextColor(0.5, 0.5, 0.5)
                DFCN.scoreboardFrame.flashingDoorIcon:SetTexture("Interface\\Icons\\INV_112_Achievement_Zone_Karesh")
            end
        end
    end)
end

function DFCN.InitPetAutoCage()
    if not DFCN_DelveHelperDB.autoPetCage then
        return
    end
    
    if DFCN.PetAutoCageInitialized then
        return
    end

    DFCN.PetAutoCageInitialized = true
    
    local function ExtractPetNameFromLink(itemLink)
        if not itemLink then return nil end
        local petName = itemLink:match("%[(.-)%]")
        return petName
    end
    
    hooksecurefunc(C_Container, "UseContainerItem", function(containerIndex, slotIndex, ...)
		if not DFCN_DelveHelperDB.autoPetCage then
			DFCN_LastRightClickItem = nil
			return
		end
        local itemID = C_Container.GetContainerItemID(containerIndex, slotIndex)
        if itemID then
            local itemLink = C_Container.GetContainerItemLink(containerIndex, slotIndex)
            local _, _, _, _, _, _, _, _, _, _, _, itemClassID, _ = C_Item.GetItemInfo(itemID)
            local petNameFromLink = ExtractPetNameFromLink(itemLink)
            local petInfo = C_PetJournal.GetPetInfoByItemID(itemID)
            local isPetItem = false
            local petName = nil
			
            if petInfo then
                petName = tostring(petInfo)
                isPetItem = true
            elseif petNameFromLink then
                petName = petNameFromLink
                isPetItem = true
            elseif itemClassID == 17 and petNameFromLink then
                petName = petNameFromLink
                isPetItem = true
            end
            
            if isPetItem and petName then
                DFCN_LastRightClickItem = {
                    petName = petName,
                    itemID = itemID,
                    itemLink = itemLink
                }
            end
        end
    end)
    
    local eventFrame = CreateFrame("Frame")
    eventFrame:RegisterEvent("UI_ERROR_MESSAGE")
    eventFrame:SetScript("OnEvent", function(self, event, errorType, message)
		if not DFCN_DelveHelperDB.autoPetCage then
			return
		end
        if event == "UI_ERROR_MESSAGE" and errorType == 980 then
            if DFCN_LastRightClickItem and DFCN_LastRightClickItem.petName then
                local petName = DFCN_LastRightClickItem.petName
                local itemLink = DFCN_LastRightClickItem.itemLink
                local speciesID, petGUID = C_PetJournal.FindPetIDByName(petName)
                
                if petGUID then
                    C_PetJournal.CagePetByID(petGUID)
                    print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["INFO"] .. "] " .. itemLink .. " " .. DFCNL["PET_CAGED"] .. "|r")
                else
                    print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["INFO"] .. "] " .. itemLink .. " " .. DFCNL["PET_NOT_FOUND"] .. "|r")
                end
            else
                print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["INFO"] .. "] " .. DFCNL["PET_CAGE_ERROR"] .. "|r")
            end
            
            DFCN_LastRightClickItem = nil
        end
    end)
end

function DFCN.CheckDelvesAndInit()
    if IsInDelvesScenario() then
        if not DFCN.mouseoverFrame then
            DFCN.InitMouseoverDetection()
        end
    end
end

function DFCN.InitMouseoverDetection()
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")    
    frame:SetScript("OnEvent", function(self, event, ...)
        if not IsInDelvesScenario() then 
            return 
        end        
        if event == "UPDATE_MOUSEOVER_UNIT" then
            DFCN.CheckMouseoverNPC()
        end
    end)    
    DFCN.mouseoverFrame = frame
end

function DFCN.IsTargetNPC(npcID)
    for _, id in ipairs(DFCN.targetNPCs) do
        if tostring(id) == npcID then
            return true
        end
    end
    return false
end

function DFCN.CheckMouseoverNPC()
    local unitToken = "mouseover"    
    if not UnitExists(unitToken) then return end    
    local npcID = DFCN.GetNPCID(unitToken)    
    if npcID and DFCN.IsTargetNPC(npcID) then
        if not GetRaidTargetIndex(unitToken) then
            DFCN.lastUsedMark = (DFCN.lastUsedMark % 8) + 1
            SetRaidTarget(unitToken, DFCN.lastUsedMark)
            print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["INFO"] .. "] " .. DFCNL["NPC_MARKED"] .. "|r")
        end
    end
end

function DFCN.GetNPCID(unitToken)
    local guid = UnitGUID(unitToken)
    if not guid then return nil end    
    local npcID = select(6, strsplit("-", guid))
    return npcID
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("SCENARIO_UPDATE")
frame:RegisterEvent("SCENARIO_COMPLETED")
frame:RegisterEvent("BAG_UPDATE")
frame:RegisterEvent("UNIT_AURA")
frame:RegisterEvent("PLAYER_CHOICE_UPDATE")
frame:RegisterEvent("PLAYER_CHOICE_CLOSE")
frame:RegisterEvent("CINEMATIC_START")
frame:RegisterEvent("CINEMATIC_STOP")
frame:RegisterEvent("TRAIT_CONFIG_UPDATED")
frame:RegisterEvent("CHAT_MSG_CURRENCY")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("GOSSIP_SHOW")
frame:RegisterEvent("DISPLAY_EVENT_TOASTS")
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addon = ...
        if addon == "OrzUI" then
            frame:UnregisterEvent("ADDON_LOADED")
            hooksecurefunc("StaticPopup_Show", HandleTokenExchange)
            LoadLibraries()
            DFCN_DelveHelperDB.characters = DFCN_DelveHelperDB.characters or {}
            UpdateExitCooldownDuration()
            DFCN.CheckGoldenCacheStatus()
			SetupBigWigsMessageListener()
			DFCN.CheckDelvesAndInit()
            if DFCN_DelveHelperDB.autoPetCage then
                DFCN.InitPetAutoCage()
            end
			if not IsInDelvesScenario() then
				DFCN.delveCompleted = false
			end
			if DFCN_DelveHelperDB.autoPetCage == nil then
				DFCN_DelveHelperDB.autoPetCage = true
			end
            CheckForExistingDelveTimer()
			DFCN.CreateOptionsPanel()
			local key = GetCharacterKey()
			DFCN_DelveHelperDB.characters[key] = DFCN_DelveHelperDB.characters[key] or {}
			local charData = DFCN_DelveHelperDB.characters[key]
			charData.goldenCacheAlertShown = charData.goldenCacheAlertShown or false

            local levelInfo = DFCN_DelveHelperDB.difficultyLevel and string.format("|cFF00FF00%d|r", DFCN_DelveHelperDB.difficultyLevel) or "|cFFFF0000" .. DFCNL["NOT_SET"] .. "|r"            
            local autoStatus = DFCN_DelveHelperDB.autoEnter and "|cFF00FF00" .. DFCNL["ENABLED"] .. "|r" or "|cFFFF0000" .. DFCNL["DISABLED"] .. "|r"
            local fastExitStatus = DFCN_DelveHelperDB.fastExitMode and "|cFF00FF00" .. DFCNL["ENABLED"] .. "|r" or "|cFFFF0000" .. DFCNL["DISABLED"] .. "|r"
            
            --print(string.format("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["INFO"] .. "]|r|cFF00FF00 " .. DFCNL["ADDON_DESCRIPTION"] .. "|cFFFFA500 By|r|c000EEEEE DFCN|r |c000EEE00" .. DFCNL["ADDON_LOADED"] .. "|r"))
            --print(string.format("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["INFO"] .. "]|r|cFF00FF00 " .. DFCNL["ADDON_STATUS"] .. "|r", autoStatus, levelInfo, fastExitStatus))
            DFCN.lastScenario = select(1, C_Scenario.GetInfo())
			if IsInDelvesScenario() then
				DFCN.checkTreasureMapPending = true
			end
			if IsInDelvesScenario() and DFCN_DelveHelperDB.scoreboardEnabled then
                local frame = DFCN.CreateScoreboard()
                frame:Show()
				DFCN.StartPeriodicUpdateTimer()
                DFCN.DelayedScoreboardRefresh(1)
			end
        end
    elseif event == "PLAYER_LOGIN" then
		if not IsInDelvesScenario() then
			DFCN.delveCompleted = false
		end
        DFCN.InitMinimapIcon()
        CheckForExistingDelveTimer()
		if IsInDelvesScenario() and DFCN_DelveHelperDB.scoreboardEnabled then
			local frame = DFCN.CreateScoreboard()
			frame:Show()
			DFCN.DelayedScoreboardRefresh(1)
		end
        if DFCN.checkTreasureMapPending then
            DFCN.checkTreasureMapPending = false
            C_Timer.After(1, function()
                DFCN.CheckAndShowTreasureMapAlert()
            end)
        end
    elseif event == "SCENARIO_UPDATE" then
		DFCN.CheckDelvesAndInit()
		if DFCN.lastScenario == DFCNL["DELVE_SCENARIO_NAME"] and not IsInDelvesScenario() then
			DFCN.exitCooldown = true
			DFCN.exitTime = GetTime()
			C_Timer.After(DFCN.exitCooldownDuration, function()
				DFCN.exitCooldown = false
			end)
		end
        C_Timer.After(1.5, function()
			CheckForExistingDelveTimer()
			if not DFCN.delveStartServerTime and not DFCN.delveCompleted then
				DFCN.StartDelveTimer()
			end
            local scenarioName = select(1, C_Scenario.GetInfo())
			local isInDelves = IsInDelvesScenario()

			if DFCN.delveCompleted and isInDelves then
				return
			end

            if DFCN.lastScenario == DFCNL["DELVE_SCENARIO_NAME"] and not isInDelves then
                DFCN.exitCooldown = true
                DFCN.exitTime = GetTime()
				local retryCount = 0
				local maxRetries = 5				
				local function TryCheckGoldenCache()
					retryCount = retryCount + 1
					if not IsInDelvesScenario() then
						DFCN.CheckGoldenCacheStatus()
						local key = GetCharacterKey()
						local charData = DFCN_DelveHelperDB.characters[key] or {}
						if charData.goldenCacheStatus ~= nil or retryCount >= maxRetries then
							return
						end
						C_Timer.After(1, TryCheckGoldenCache)
					end
				end
				C_Timer.After(1, TryCheckGoldenCache)                
                C_Timer.After(DFCN.exitCooldownDuration, function()
                    DFCN.exitCooldown = false
                end)
            end
            
            DFCN.lastScenario = scenarioName

			if not isInDelves then
                DFCN.HideGoldenCacheAlert()
				if DFCN.treasureMapAlert and DFCN.treasureMapAlert:IsShown() then
					DFCN.treasureMapAlert:Hide()
				end
				DFCN.inDelveWithMap = false
				if DFCN.showScoreboardTimer then
					DFCN.showScoreboardTimer:Cancel()
					DFCN.showScoreboardTimer = nil
				end
				DFCN.StopPeriodicUpdateTimer()
				if DFCN.treasureBuffAlert then
					DFCN.treasureBuffAlert:Hide()
				end
				DFCN.isAbundant = nil
				DFCN.ResetDelveTimer()
				if DFCN.scoreboardFrame and DFCN.scoreboardFrame:IsShown() then
					DFCN.scoreboardFrame:Hide()
				end
                
                local key = GetCharacterKey()
                if DFCN_DelveHelperDB.characters[key] then
                    DFCN_DelveHelperDB.characters[key].flashingDoorDetected = false
					DFCN_DelveHelperDB.characters[key].flashingDoorActivated = false
                end
                
                if DFCN.scoreboardFrame then
                    DFCN.scoreboardFrame.flashingDoorIcon:Hide()
                    DFCN.scoreboardFrame.flashingDoorText:Hide()
                end
				return
			end

			if DFCN.delveCompleted then
				if IsInDelvesScenario() then
					if DFCN.scoreboardFrame and DFCN.scoreboardFrame:IsShown() then
						DFCN.UpdateScoreboard()
					end
				else
					DFCN.delveCompleted = false
					DFCN.delveStartServerTime = nil
					DFCN.delveCompletionTime = nil
				end
				return
			end     

            DFCN.CheckAndShowTreasureMapAlert()
			
            if not DFCN.delveStartServerTime then
                DFCN.StartDelveTimer()
            end
                
            local _, _, isAbundant = GetDelveInfo()
            DFCN.isAbundant = isAbundant
                
            if DFCN_DelveHelperDB.scoreboardEnabled then
                DFCN.StartPeriodicUpdateTimer()
                if DFCN.showScoreboardTimer then
                    DFCN.showScoreboardTimer:Cancel()
                end                
                DFCN.showScoreboardTimer = C_Timer.NewTimer(0.5, function()
                    DFCN.showScoreboardTimer = nil
                    local frame = DFCN.CreateScoreboard()
                    frame:Show()
                    DFCN.DelayedScoreboardRefresh(0.5)
                end)
            end
        end)
	elseif event == "GOSSIP_SHOW" then
		if IsInDelvesScenario() then
			if DFCN_DelveHelperDB.autoActivateDelve and 
			   not IsShiftKeyDown() and 
			   not IsControlKeyDown() and 
			   not IsAltKeyDown() then
				
				local gossipOptions = C_GossipInfo.GetOptions()
				if gossipOptions and #gossipOptions > 0 then
					for _, option in ipairs(gossipOptions) do
						if option.name and option.name:find("^|cFF0000FF") then
							local success = pcall(C_GossipInfo.SelectOption, option.gossipOptionID)
							if success then
								print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["INFO"] .. "] " .. string.format(DFCNL["AUTO_NPC_INTERACTION"], StripColorCodes(option.name)) .. "|r")
								return
							end
						end
					end

					local taskOptionCount = 0
					local taskOptionID = nil
					for _, option in ipairs(gossipOptions) do
						if option.flags == 1 then
							taskOptionCount = taskOptionCount + 1
							taskOptionID = option.gossipOptionID
						end
					end
						
						if taskOptionCount == 1 then
							local success = pcall(C_GossipInfo.SelectOption, taskOptionID)
							if success then
								local optionName = ""
								for _, option in ipairs(gossipOptions) do
									if option.gossipOptionID == taskOptionID then
										optionName = option.name or ""
										break
									end
								end
								print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["INFO"] .. "] " .. string.format(DFCNL["AUTO_NPC_INTERACTION"], StripColorCodes(optionName)) .. "|r")
								return
							end
						end
					end
				end
			end
		if DFCN.exitCooldown then
			return
		end
		if IsDelvesGossip() then
			AutoSelectAndEnter()
		end
        local guid = UnitGUID("npc")
        if guid then
            local npcID = select(6, strsplit("-", guid))
            npcID = npcID and tonumber(npcID)
            
			if npcID and AUTO_CONFIRM_NPC_IDS[npcID] then
				local npcInfo = AUTO_CONFIRM_NPC_IDS[npcID]
				local shouldProceed = true
				
				if npcInfo.checkInstance then
					local _, _, difficultyID = GetInstanceInfo()
					shouldProceed = (difficultyID == npcInfo.difficultyID)
				end
				
				if shouldProceed then
					C_Timer.After(0, function()
						local options = C_GossipInfo.GetOptions()
						if options then
							for i, option in ipairs(options) do
								if option.gossipOptionID == npcInfo.gossipOptionID then
									C_GossipInfo.SelectOption(option.gossipOptionID)
									if npcInfo.printText then
										print(npcInfo.printText)
									end
									if npcInfo.leaveParty then
										C_PartyInfo.ConfirmLeaveParty(2)
									end
									DFCN.expectingCinematic = true
									if DFCN.cinematicTimer then
										DFCN.cinematicTimer:Cancel()
									end
									DFCN.cinematicTimer = C_Timer.After(3, function()
										DFCN.expectingCinematic = false
										DFCN.cinematicTimer = nil
									end)
									break
								end
							end
						end
					end)
				end
			end
        end
	elseif event == "BAG_UPDATE" then
		if DFCN_DelveHelperDB.treasureMapAlertEnabled then
			if IsInDelvesScenario() then
				local mapCount = GetItemCount(248142)				
				if mapCount > 0 and not DFCN.inDelveWithMap then
					DFCN.CheckAndShowTreasureMapAlert()
				elseif mapCount == 0 and DFCN.inDelveWithMap then
					DFCN.treasureMapAlert:Hide()
					DFCN.inDelveWithMap = false
				end
			end
		end
	elseif event == "PLAYER_CHOICE_UPDATE" then
		if PlayerChoiceFrame and PlayerChoiceFrame:IsShown() and IsInDelvesScenario() then
			if DFCN.playerChoiceTicker then
				DFCN.playerChoiceTicker:Cancel()
				DFCN.playerChoiceTicker = nil
			end
        
        local function GetRarityColor(rarity)
            if rarity == 4 then
                return "ffff8000"
            elseif rarity == 3 then
                return "ffa335ee"
            elseif rarity == 2 then
                return "ff0070dd"
            elseif rarity == 1 then
                return "ff1eff00"
            elseif rarity == 0 then
                return "ffffffff"
            else
                return "ffffffff"
            end
        end
        
        DFCN.playerChoiceTicker = C_Timer.NewTicker(0.1, function()
            local treasureName = DFCNL["UNKNOWN_TREASURE"]
            local treasureLink = treasureName
            local rarityColor = "ffffffff"
            local choiceInfo = C_PlayerChoice.GetCurrentPlayerChoiceInfo()
            
            if choiceInfo and choiceInfo.options and #choiceInfo.options > 0 then
                local option = choiceInfo.options[1]
                treasureName = option.header or treasureName
                treasureName = StripColorCodes(treasureName)
                
                if treasureName == DFCNL["SPECIAL_FOOTBOMB_TREASURE"] then
                    rarityColor = "ffff8000"
                else
                    if option.rarity then
                        rarityColor = GetRarityColor(option.rarity)
                    end
                end
                
                if option.spellID then
                    local spellLink = C_Spell.GetSpellLink(option.spellID)
                    if spellLink then
                        local _, _, plainName = string.find(spellLink, "|h%[(.-)%]|h")
                        if plainName then
                            treasureLink = "|c"..rarityColor.."|Hspell:"..option.spellID.."|h["..plainName.."]|h|r"
                        else
                            treasureLink = "|c"..rarityColor..treasureName.."|r"
                        end
                    else
                        treasureLink = "|c"..rarityColor..treasureName.."|r"
                    end
                else
                    treasureLink = "|c"..rarityColor..treasureName.."|r"
                end
            end

            if FindAndClickSelectButton() then
                if treasureName == DFCNL["SPECIAL_FOOTBOMB_TREASURE"] then
                    print("|TInterface\\icons\\ui_delves:14:14|t |cFFFF8000[" .. DFCNL["INFO"] .. "] " .. string.format(DFCNL["AUTO_SELECT_TREASURE"], treasureLink) .. "|r")
                    C_Timer.After(1.5, function()
                        DFCN.PlayCustomSound("boomfootball.ogg")
                        DFCN.BrannSay(DFCNL["BRANN_FOOTBOMB"])
                    end)						
                else
                    print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["INFO"] .. "] " .. string.format(DFCNL["AUTO_SELECT_TREASURE"], treasureLink) .. "|r")
                end
                return
            end
        end)
    end
	elseif event == "PLAYER_CHOICE_CLOSE" then
		if DFCN.playerChoiceTicker then
			DFCN.playerChoiceTicker:Cancel()
			DFCN.playerChoiceTicker = nil
		end
	elseif event == "CINEMATIC_START" then
		if DFCN.expectingCinematic then
			CinematicFrame_CancelCinematic()
			DFCN.expectingCinematic = false
			if DFCN.cinematicTimer then
				DFCN.cinematicTimer:Cancel()
				DFCN.cinematicTimer = nil
			end
		end
	elseif event == "CINEMATIC_STOP" then
		DFCN.expectingCinematic = false
		if DFCN.cinematicTimer then
			DFCN.cinematicTimer:Cancel()
			DFCN.cinematicTimer = nil
		end
	elseif event == "TRAIT_CONFIG_UPDATED" then
		local updatedConfigID = ...
		if DFCN.brannConfigID and updatedConfigID == DFCN.brannConfigID then
			if IsInDelvesScenario() then
				C_Timer.After(0.1, function()
					if IsInDelvesScenario() and DFCN.scoreboardFrame and DFCN.scoreboardFrame:IsShown() then
						DFCN.UpdateCompanionIcons(true)
						print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["INFO"] .. "] " .. DFCNL["BRANN_CONFIG_UPDATED"] .. "|r")
					end
				end)
			end
		end
	elseif event == "UNIT_AURA" and ... == "player" then
			if IsInDelvesScenario() then
				DFCN.UpdatemedicineBar()
				if DFCN_DelveHelperDB.treasureMapAlertEnabled then
					local currentBuffState = C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID(1246363) ~= nil
					if currentBuffState ~= DFCN.lastTreasureBuffState then
						DFCN.lastTreasureBuffState = currentBuffState
						C_Timer.After(1, function()
							DFCN.UpdateScoreboard()
						end)
					end
				end
			end       
	elseif event == "SCENARIO_COMPLETED" and IsInDelvesScenario() then
		DFCN.PauseDelveTimer()		
		DFCN.delveCompleted = true		
		local startTime = DFCN.delveStartServerTime or GetServerTime()
		DFCN.delveCompletionTime = GetServerTime() - startTime			
		
		local key = GetCharacterKey()
		DFCN_DelveHelperDB.characters[key] = DFCN_DelveHelperDB.characters[key] or {}
		local charData = DFCN_DelveHelperDB.characters[key]
		
		charData.delveCompleted = true
		charData.delveCompletionTime = DFCN.delveCompletionTime		
		
		DFCN.StopPeriodicUpdateTimer()
		C_Timer.After(2.0, function()
			if DFCN.scoreboardFrame and DFCN.scoreboardFrame:IsShown() then
				DFCN.UpdateScoreboard()
			end
		end)

		local widgetInfo = C_UIWidgetManager and C_UIWidgetManager.GetScenarioHeaderDelvesWidgetVisualizationInfo(6183)
		local difficultyLevel, isAbundant
		
		if widgetInfo then
			difficultyLevel = tonumber(widgetInfo.tierText) or 0
			
			isAbundant = false
			if widgetInfo.spells then
				for _, spell in ipairs(widgetInfo.spells) do
					if spell.spellID == 462940 then
						isAbundant = true
						break
					end
				end
			end
		else
			difficultyLevel = 0
			isAbundant = false
		end
		if difficultyLevel >= 8 then
			local goldenCacheStatus = charData.goldenCacheStatus or "3/3"
			local hasTreasureBuff = C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID(1246363) ~= nil
			local shouldAlertForAbundant = (difficultyLevel == 11 and isAbundant and goldenCacheStatus ~= "3/3")
			local shouldAlertForTreasureMap = hasTreasureBuff
			local currentTime = time()
			local statusTime = charData.goldenCacheStatusTime or 0
			local isStatusRecent = (currentTime - statusTime) <= 7200
			
			DFCN.goldenPickupCount = 0
			DFCN.requireTwoPickups = (shouldAlertForAbundant and shouldAlertForTreasureMap)
			
			if isStatusRecent and (shouldAlertForAbundant or shouldAlertForTreasureMap) then
				DFCN.ShowGoldenCacheAlert()
			end
		end
	elseif event == "ZONE_CHANGED_NEW_AREA" then
		C_Timer.After(1, function()
			DFCN.CheckGoldenCacheStatus()
		end)
	elseif event == "CHAT_MSG_CURRENCY" and IsInDelvesScenario() then
		local text = ...
		
		if text and (text:match(DFCNL["GOLDEN_CREST_PATTERN"])) then
			DFCN.goldenPickupCount = DFCN.goldenPickupCount + 1
			local shouldHide = false
			
			if DFCN.requireTwoPickups then
				if DFCN.goldenPickupCount >= 2 then
					shouldHide = true
				end
			else
				shouldHide = true
			end
			
			if shouldHide then
				DFCN.PlayCustomSound("lootover.ogg")
				DFCN.BrannSay(DFCNL["BRANN_GOLDEN_CREST"])
				DFCN.HideGoldenCacheAlert()
				DFCN.goldenPickupCount = 0
				DFCN.requireTwoPickups = false
			end
		end
	elseif event == "DISPLAY_EVENT_TOASTS" then
		if not IsInDelvesScenario() or DFCN.delveCompleted then
			if DFCN.flashingDoorCheckTimer then
				DFCN.flashingDoorCheckTimer:Cancel()
				DFCN.flashingDoorCheckTimer = nil
			end
			return
		end

		if DFCN.scoreboardFrame and DFCN.scoreboardFrame:IsShown() then
			DFCN.UpdateScoreboard()
		end

		if DFCN.flashingDoorCheckTimer then
			DFCN.flashingDoorCheckTimer:Cancel()
			DFCN.flashingDoorCheckTimer = nil
		end
		
		local checkCount = 0
		local maxChecks = 30
		
		local function CheckForFlashingDoor()
			if not IsInDelvesScenario() or DFCN.delveCompleted then
				if DFCN.flashingDoorCheckTimer then
					DFCN.flashingDoorCheckTimer:Cancel()
					DFCN.flashingDoorCheckTimer = nil
				end
				return
			end

			checkCount = checkCount + 1
			local toast = C_EventToastManager.GetNextToastToDisplay()
			
			if toast then
				if toast.eventToastID == 339 then
					local key = GetCharacterKey()
					DFCN_DelveHelperDB.characters[key] = DFCN_DelveHelperDB.characters[key] or {}					
					
					if DFCN_DelveHelperDB.characters[key].flashingDoorActivated == nil then
						DFCN_DelveHelperDB.characters[key].flashingDoorActivated = false
					end
					
					if DFCN_DelveHelperDB.scoreboardEnabled then
						if not DFCN.scoreboardFrame then
							DFCN.CreateScoreboard()
						end
						DFCN.scoreboardFrame:Show()
						DFCN.scoreboardFrame.flashingDoorIcon:Show()
						DFCN.scoreboardFrame.flashingDoorText:Show()
						
						if DFCN_DelveHelperDB.characters[key].flashingDoorActivated then
							DFCN.scoreboardFrame.flashingDoorText:SetText(" " .. DFCNL["FLASHING_DOOR_USED"])
							DFCN.scoreboardFrame.flashingDoorText:SetTextColor(0.5, 0.5, 0.5)
							DFCN.scoreboardFrame.flashingDoorIcon:SetTexture("Interface\\Icons\\INV_112_RaidTrinkets_BlobOfSwirlingVoid_terra")
						else
							DFCN.scoreboardFrame.flashingDoorText:SetText(" " .. DFCNL["FLASHING_DOOR"])
							DFCN.scoreboardFrame.flashingDoorText:SetTextColor(0.1, 0.4, 0.9)
							DFCN.scoreboardFrame.flashingDoorIcon:SetTexture("Interface\\Icons\\INV_112_RaidTrinkets_BlobOfSwirlingVoid_purple")
						end
					end

					local _, _, isAbundant = GetDelveInfo()
					DFCN.isAbundant = isAbundant
					
					if not DFCN_DelveHelperDB.characters[key].flashingDoorDetected and not DFCN.isAbundant then
						DFCN.PlayCustomSound("flashingdoor.ogg")
						DFCN.BrannSay(DFCNL["BRANN_FLASHING_DOOR"])
					end

					DFCN_DelveHelperDB.characters[key].flashingDoorDetected = true
					
					if DFCN.flashingDoorCheckTimer then
						DFCN.flashingDoorCheckTimer:Cancel()
						DFCN.flashingDoorCheckTimer = nil
					end
					return
				end
				
				if toast.eventToastID == 337 or toast.eventToastID == 338 then
					local key = GetCharacterKey()
					DFCN_DelveHelperDB.characters[key] = DFCN_DelveHelperDB.characters[key] or {}
					DFCN_DelveHelperDB.characters[key].flashingDoorDetected = true
					DFCN_DelveHelperDB.characters[key].flashingDoorActivated = true
					
					if DFCN_DelveHelperDB.scoreboardEnabled then
						if not DFCN.scoreboardFrame then
							DFCN.CreateScoreboard()
						end
						DFCN.scoreboardFrame:Show()
						DFCN.scoreboardFrame.flashingDoorIcon:Show()
						DFCN.scoreboardFrame.flashingDoorText:Show()
						DFCN.scoreboardFrame.flashingDoorText:SetText(" " .. DFCNL["FLASHING_DOOR_USED"])
						DFCN.scoreboardFrame.flashingDoorText:SetTextColor(0.5, 0.5, 0.5)
						DFCN.scoreboardFrame.flashingDoorIcon:SetTexture("Interface\\Icons\\INV_112_RaidTrinkets_BlobOfSwirlingVoid_terra")
					end                
				   
					if DFCN.flashingDoorCheckTimer then
						DFCN.flashingDoorCheckTimer:Cancel()
						DFCN.flashingDoorCheckTimer = nil
					end
					return
				end
			end
			
			if checkCount >= maxChecks then
				if DFCN.flashingDoorCheckTimer then
					DFCN.flashingDoorCheckTimer:Cancel()
					DFCN.flashingDoorCheckTimer = nil
				end
				return
			end
			
			DFCN.flashingDoorCheckTimer = C_Timer.After(1, CheckForFlashingDoor)
		end
		
		CheckForFlashingDoor()
    end
end)

SLASH_DFCN_DELVEHELPER1 = "/dfcndelve"
SlashCmdList["DFCN_DELVEHELPER"] = function(msg)
    msg = msg and strlower(msg:trim()) or ""
    
    if msg == "minimap on" then
        if LibDBIcon then
            LibDBIcon:Show("DFCN_DelveHelper")
            DFCN_DelveHelperDB.minimapIconShown = true
            print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["INFO"] .. "] " .. DFCNL["MINIMAP_SHOWN"] .. "|r")
        end
    elseif msg == "minimap off" then
        if LibDBIcon then
            LibDBIcon:Hide("DFCN_DelveHelper")
            DFCN_DelveHelperDB.minimapIconShown = false
            print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["INFO"] .. "] " .. DFCNL["MINIMAP_HIDDEN"] .. "|r")
        end
    elseif msg == "" then
        DFCN.ToggleSettingsFrame()
    else
		print(DFCNL["SLASH_COMMAND"])
		print(DFCNL["SLASH_MINIMAP_ON"])
		print(DFCNL["SLASH_MINIMAP_OFF"])
    end
end

function DFCN.CreateOptionsPanel()
    local panel = CreateFrame("Frame")
    panel.name = DFCNL["ADDON_DESCRIPTION"] .. "|TInterface\\icons\\ui_delves:16:16|t"

    local title = panel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
	title:SetFont(GameFontNormal:GetFont(), 16)
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("|TInterface\\icons\\ui_delves:18:18|t " .. DFCNL["ADDON_DESCRIPTION"] .. " |cFFFFA500DFCN|r")
    
    local minimapCheckbox = CreateFrame("CheckButton", nil, panel, "UICheckButtonTemplate")
    minimapCheckbox:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -30)
    minimapCheckbox:SetChecked(DFCN_DelveHelperDB.minimapIconShown)
    minimapCheckbox:SetScript("OnClick", function(self)
        DFCN_DelveHelperDB.minimapIconShown = self:GetChecked()
        if LibDBIcon then
            if self:GetChecked() then
                LibDBIcon:Show("DFCN_DelveHelper")
                print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["INFO"] .. "] " .. DFCNL["MINIMAP_SHOWN"] .. "|r")
            else
                LibDBIcon:Hide("DFCN_DelveHelper")
                print("|TInterface\\icons\\ui_delves:14:14|t |cFF00BFFF[" .. DFCNL["INFO"] .. "] " .. DFCNL["MINIMAP_HIDDEN"] .. "|r")
            end
        end
    end)
    
    minimapCheckbox.text = minimapCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    minimapCheckbox.text:SetPoint("LEFT", minimapCheckbox, "RIGHT", 5, 0)
	minimapCheckbox.text:SetFont(GameFontNormal:GetFont(), 16)
    minimapCheckbox.text:SetText(DFCNL["MINIMAP_CHECKBOX"])
    
    local openSettingsBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    openSettingsBtn:SetPoint("TOPLEFT", minimapCheckbox, "BOTTOMLEFT", 0, -20)
    openSettingsBtn:SetSize(200, 40)

    local function UpdateButtonText()
        if DFCN.settingsFrame and DFCN.settingsFrame:IsShown() then
            openSettingsBtn:SetText(DFCNL["CLOSE_SETTINGS"])
        else
            openSettingsBtn:SetText(DFCNL["OPEN_SETTINGS"])
        end
    end

    UpdateButtonText()
    
    openSettingsBtn:SetScript("OnClick", function()
		if DFCN.settingsFrame and DFCN.settingsFrame:IsShown() then
			DFCN.settingsFrame:Hide()
		else
			if not DFCN.settingsFrame then
				DFCN.CreateSettingsFrame()
			end
			DFCN.settingsFrame:Show()
			DFCN.RefreshSettingsFrame()
		end
        UpdateButtonText()
    end)

    panel:SetScript("OnShow", function()
        UpdateButtonText()
    end)

    local commandTip = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    commandTip:SetPoint("TOPLEFT", openSettingsBtn, "BOTTOMLEFT", 0, -10)
    commandTip:SetText(DFCNL["COMMAND_TIP"])
    commandTip:SetTextColor(0.8, 0.8, 0.8)

    local downloadLabel = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    downloadLabel:SetPoint("TOPLEFT", commandTip, "BOTTOMLEFT", 0, -20)
    downloadLabel:SetText(DFCNL["DOWNLOAD_LABEL"])
    downloadLabel:SetTextColor(1, 1, 1)
    
    local downloadEditBox = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
    downloadEditBox:SetPoint("TOPLEFT", downloadLabel, "BOTTOMLEFT", 0, -5)
    downloadEditBox:SetSize(300, 20)
    downloadEditBox:SetAutoFocus(false)
    downloadEditBox:SetText("https://bbs.nga.cn/read.php?tid=44921579")
    downloadEditBox:SetCursorPosition(0)
    
    local copyTip = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    copyTip:SetPoint("TOPLEFT", downloadEditBox, "BOTTOMLEFT", 0, -5)
    copyTip:SetText(DFCNL["COPY_TIP"])
    copyTip:SetTextColor(0.7, 0.7, 0.7)
    
    downloadEditBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)
    
    downloadEditBox:SetScript("OnEditFocusGained", function(self)
        self:HighlightText()
    end)
    
    downloadEditBox:SetScript("OnMouseUp", function(self)
        if not self:HasFocus() then
            self:SetFocus()
            self:HighlightText()
        end
    end)
    
    if InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(panel)
    elseif Settings and Settings.RegisterAddOnCategory and Settings.RegisterCanvasLayoutCategory then
        local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
        Settings.RegisterAddOnCategory(category)
    end
    
    return panel
end