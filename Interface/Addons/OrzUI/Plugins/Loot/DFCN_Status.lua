--## Notes: 自动记录所有68+级角色的商业技能专注、地下堡、装等及赛季货币等情况  ## Author: DFCN  ## Version: 1.47
local DFCNSL = {}
if GetLocale() == "zhCN" then
    DFCNSL["SECONDS"] = "秒"
    DFCNSL["MINUTES"] = "分钟"
    DFCNSL["HOURS"] = "小时"
    DFCNSL["DAYS"] = "天"
    DFCNSL["IN_BAG"] = "背包中"
    DFCNSL["USED"] = "已使用"
    DFCNSL["NOT_OBTAINED"] = "未获得"
    DFCNSL["NO_PROFESSION"] = "无专业"
    DFCNSL["PROFESSION_SLOT"] = "专业%d"
    DFCNSL["NOT_LEARNED"] = "未学习"
    DFCNSL["CHARACTER_NAME"] = "角色名称"
    DFCNSL["PROF_CONCENTRATION"] = "技能专注"
    DFCNSL["KEY_ACQUISITION"] = "钥匙获取"
    DFCNSL["SHARD_ACQUISITION"] = "裂片获取"
    DFCNSL["DELVE_COUNT"] = "低保数"
    DFCNSL["TREASURE_MAP"] = "藏宝图"
    DFCNSL["GOLDEN_CACHE"] = "鎏金纹章"
    DFCNSL["ITEM_LEVEL"] = "装等"
    DFCNSL["OVERALL_ITEM_LEVEL"] = "平均装等"
    DFCNSL["MANUAL_UPDATE"] = "手动更新"
    DFCNSL["SWITCH_TO_CURRENCY"] = "切换到货币显示"
    DFCNSL["SWITCH_TO_DELVES"] = "切换到地堡信息"
    DFCNSL["MULTI_CHAR_MANAGER"] = "|cff00ff00[角色]|r数据管理"
    DFCNSL["MULTI_CHAR_MANAGER_SHORT"] = "多角色管理器"
    DFCNSL["DELVES_STATS"] = "地下堡信息统计"
    DFCNSL["CURRENCY_STATS"] = "赛季货币统计"
    DFCNSL["FONT_SIZE"] = "字体"
    DFCNSL["CLICK_OR_SPACE"] = "点击或按空格键切换视图模式"
    DFCNSL["CHARACTER_RESET"] = "多角色管理器: 已为%d个角色重置本周数据！"
    DFCNSL["ADDON_LOADED"] = "多角色管理器已加载"
    DFCNSL["DATABASE_CREATED"] = "已创建新的插件角色数据库 (v%s)"
    DFCNSL["DATA_UPDATED"] = "当前角色数据已手动强制更新"
    DFCNSL["MINIMAP_SHOWN"] = "小地图图标已显示"
    DFCNSL["MINIMAP_HIDDEN"] = "小地图图标已隐藏"
    DFCNSL["CHARACTER_DELETED"] = "已删除角色: %s"
    DFCNSL["SHOW_MINIMAP_ICON"] = "显示小地图图标"
    DFCNSL["OPEN_PANEL"] = "打开角色管理面板"
    DFCNSL["CLOSE_PANEL"] = "关闭角色管理面板"
    DFCNSL["MACRO_COMMAND"] = "宏调用指令: /dfcnchar"
    DFCNSL["ORIGINAL_DOWNLOAD"] = "原始发布地址："
    DFCNSL["CLICK_TO_COPY"] = "点击选中网址，按Ctrl+C复制"
    DFCNSL["CURRENCY"] = "货币"
    DFCNSL["CURRENCY_VALOR"] = "神勇石"
    DFCNSL["CURRENCY_CATACLYSM"] = "晦幽铸币"
    DFCNSL["CURRENCY_WEATHERED"] = "风化纹章"
    DFCNSL["CURRENCY_ETCHED"] = "蚀刻纹章"
    DFCNSL["CURRENCY_RUNED"] = "符文纹章"
    DFCNSL["CURRENCY_GILDED"] = "鎏金纹章"
    DFCNSL["CURRENCY_STARLIGHT"] = "星光火花"
    DFCNSL["CURRENCY_FRAGMENT"] = "化生裂片"
    DFCNSL["TOOLTIP_CHARACTER_NAME"] = "角色名称 - 服务器"
    DFCNSL["TOOLTIP_PROF_CONCENTRATION"] = "商业技能(专注点)"
    DFCNSL["TOOLTIP_KEY_ACQUISITION"] = "钥匙总数量 | 本周获取数量/4"
    DFCNSL["TOOLTIP_SHARD_ACQUISITION"] = "碎片总数量 | 本周碎片数量/200"
    DFCNSL["TOOLTIP_DELVE_COUNT"] = "8层以上地下堡合计（<2次时显示为0）"
    DFCNSL["TOOLTIP_TREASURE_MAP"] = "地下堡藏宝图获取状态"
    DFCNSL["TOOLTIP_GOLDEN_CACHE"] = "地下堡鎏金藏匿物获取状态"
    DFCNSL["TOOLTIP_ITEM_LEVEL"] = "角色披风装等"
    DFCNSL["CURRENCY_MANA_CRYSTAL"] = "法力水晶"
    DFCNSL["TOOLTIP_MANA_CRYSTAL"] = "法力水晶货币数量"
    DFCNSL["TOOLTIP_OVERALL_ITEM_LEVEL"] = "角色全身平均装等"
    DFCNSL["LEFT_CLICK"] = "左键: 打开/关闭面板"
    DFCNSL["COMMAND_OPEN_CLOSE"] = "|cFFFFFF00/dfcnchar|r - 打开/关闭面板"
    DFCNSL["COMMAND_MINIMAP_ON"] = "|cFFFFFF00/dfcnchar minimap on|r - 显示小地图图标"
    DFCNSL["COMMAND_MINIMAP_OFF"] = "|cFFFFFF00/dfcnchar minimap off|r - 隐藏小地图图标"
    DFCNSL["MACRO_COMMAND"] = "宏命令: |cFFFFFF00/dfcnchar|r"
    DFCNSL["MINIMAP_ICON"] = "小地图图标: |cFFFFFF00/dfcnchar minimap on/off|r"
    DFCNSL["ESC_TO_CLOSE"] = "面板打开时按ESC可关闭"
    DFCNSL["CONCENTRATION_VALUE"] = "专注值"
    DFCNSL["NO_CONCENTRATION_TIP"] = "采集专业无专注值"
    DFCNSL["CONCENTRATION_FULL"] = "专注已满"
    DFCNSL["CURRENT_VALUE"] = "当前值"
    DFCNSL["TIME_TO_FULL"] = "专注回满还需"
    DFCNSL["ESTIMATED_FULL_TIME"] = "预计回满时间"
    DFCNSL["LAST_LOGIN_TIME"] = "最后上线时间"
    DFCNSL["CURRENCY_TOOLTIP_UNKNOWN"] = "尚未登录该角色，数据未知"
    DFCNSL["CURRENCY_TOOLTIP_LOGIN"] = "请登录该角色以自动获取最新数据"
    DFCNSL["UNKNOWN"] = "未知"
    DFCNSL["FONT_SIZE_SLIDER"] = "字体大小: %s"
    DFCNSL["FONT_SIZE_POSITIVE"] = "字体大小: +%d"
    DFCNSL["FONT_SIZE_NEGATIVE"] = "字体大小: %d"
    DFCNSL["FONT_SIZE_ZERO"] = "字体大小: 0"
    DFCNSL["DELETE_CHAR_CONFIRM"] = "确定要删除 |cFFFFD100%s|r 的数据吗？"
    DFCNSL["DELETE"] = "删除"
    DFCNSL["CANCEL"] = "取消"
    DFCNSL["DELETE_CHAR_TOOLTIP"] = "删除此角色数据"
    DFCNSL["GREAT_VAULT_NOT_COLLECTED"] = "宏伟宝库未领取"
    DFCNSL["QUANTITY_HELD"] = "持有数量"
    DFCNSL["SEASON_CAP"] = "赛季上限"
    DFCNSL["HOLDING_CAP"] = "持有上限"
    DFCNSL["SEASON_EARNED"] = "赛季获取"
    DFCNSL["REACHED_CAP"] = "已达上限"
    DFCNSL["NEED_MORE"] = "再获取 %d 达到赛季上限"
	DFCNSL["HOLD_MORE"] = "再获取 %d 达到持有上限"
	DFCNSL["WEEKLY_CAP"] = "每周上限"
	DFCNSL["REACHED_WEEKLY_CAP"] = "已达到每周上限"
	DFCNSL["NEED_MORE_WEEKLY"] = "再获取 %d 达到每周上限"
    DFCNSL["INFO"] = "信息"
    DFCNSL["UPGRADE"] = "升级"
    DFCNSL["RESET"] = "重置"
    DFCNSL["DATA_AUTO_UPDATED"] = "(数据已自动更新)"
    DFCNSL["DATA_MAY_BE_OUTDATED"] = "(数据可能已过期)"
    DFCNSL["VIEW_ONLY_SUPPORT"] = "(仅支持查看)"
    DFCNSL["CURRENT_REGION_FORMAT"] = "当前为%s，每%s7点自动重置数据"
    DFCNSL["CHARACTER_LEVEL_68_PLUS"] = "当前角色68級以上"
    DFCNSL["CHARACTER_LEVEL_BELOW_68"] = "当前角色不足68級"
    DFCNSL["REGION_US"] = "[美服]"
    DFCNSL["REGION_KR"] = "[韩服]"
    DFCNSL["REGION_EU"] = "[欧服]"
    DFCNSL["REGION_TW"] = "[台服]"
    DFCNSL["REGION_CN"] = "[国服]"
    DFCNSL["REGION_PTR"] = "[PTR]"
    DFCNSL["SUNDAY"] = "周日"
    DFCNSL["MONDAY"] = "周一"
    DFCNSL["TUESDAY"] = "周二"
    DFCNSL["WEDNESDAY"] = "周三"
    DFCNSL["THURSDAY"] = "周四"
    DFCNSL["FRIDAY"] = "周五"
    DFCNSL["SATURDAY"] = "周六"
elseif GetLocale() == "zhTW" then
	--This text has been translated by AI:DeepSeek
    DFCNSL["SECONDS"] = "秒"
    DFCNSL["MINUTES"] = "分鐘"
    DFCNSL["HOURS"] = "小時"
    DFCNSL["DAYS"] = "天"
    DFCNSL["IN_BAG"] = "背包中"
    DFCNSL["USED"] = "已使用"
    DFCNSL["NOT_OBTAINED"] = "未獲得"
    DFCNSL["NO_PROFESSION"] = "無專業"
    DFCNSL["PROFESSION_SLOT"] = "專業%d"
    DFCNSL["NOT_LEARNED"] = "未學習"
    DFCNSL["CHARACTER_NAME"] = "角色名稱"
    DFCNSL["PROF_CONCENTRATION"] = "技能專注"
    DFCNSL["KEY_ACQUISITION"] = "鑰匙獲取"
    DFCNSL["SHARD_ACQUISITION"] = "裂片獲取"
    DFCNSL["DELVE_COUNT"] = "探究计數"
    DFCNSL["TREASURE_MAP"] = "藏寶圖"
    DFCNSL["GOLDEN_CACHE"] = "鍍金紋章"
    DFCNSL["ITEM_LEVEL"] = "物等"
    DFCNSL["OVERALL_ITEM_LEVEL"] = "平均物等"
    DFCNSL["MANUAL_UPDATE"] = "手動更新"
    DFCNSL["SWITCH_TO_CURRENCY"] = "切換到通貨資訊"
    DFCNSL["SWITCH_TO_DELVES"] = "切換到探究資訊"
    DFCNSL["MULTI_CHAR_MANAGER"] = "|cff00ff00[角色]|r数据管理"
    DFCNSL["MULTI_CHAR_MANAGER_SHORT"] = "多角色管理器"
    DFCNSL["DELVES_STATS"] = "探究資訊統計"
    DFCNSL["CURRENCY_STATS"] = "賽季通貨統計"
    DFCNSL["FONT_SIZE"] = "字體"
    DFCNSL["CLICK_OR_SPACE"] = "點擊或按空格鍵切換視圖模式"
    DFCNSL["CHARACTER_RESET"] = "多角色管理器: 已為%d個角色重置本週資料！"
    DFCNSL["ADDON_LOADED"] = "多角色管理器已加載"
    DFCNSL["DATABASE_CREATED"] = "已建立新的插件角色資料庫 (v%s)"
    DFCNSL["DATA_UPDATED"] = "當前角色資料已手動強制更新"
    DFCNSL["MINIMAP_SHOWN"] = "小地圖圖示已顯示"
    DFCNSL["MINIMAP_HIDDEN"] = "小地圖圖示已隱藏"
    DFCNSL["CHARACTER_DELETED"] = "已刪除角色: %s"
    DFCNSL["SHOW_MINIMAP_ICON"] = "顯示小地圖圖示"
    DFCNSL["OPEN_PANEL"] = "打開角色管理面板"
    DFCNSL["CLOSE_PANEL"] = "關閉角色管理面板"
    DFCNSL["MACRO_COMMAND"] = "巨集調用指令: /dfcnchar"
    DFCNSL["ORIGINAL_DOWNLOAD"] = "原始發布網址："
    DFCNSL["CLICK_TO_COPY"] = "點擊選中網址，按Ctrl+C複製"
    DFCNSL["CURRENCY"] = "通貨"
    DFCNSL["CURRENCY_VALOR"] = "勇氣石"
    DFCNSL["CURRENCY_CATACLYSM"] = "地底幣"
    DFCNSL["CURRENCY_WEATHERED"] = "陳舊紋章"
    DFCNSL["CURRENCY_ETCHED"] = "雕刻紋章"
    DFCNSL["CURRENCY_RUNED"] = "符文紋章"
    DFCNSL["CURRENCY_GILDED"] = "鍍金紋章"
    DFCNSL["CURRENCY_STARLIGHT"] = "星輝火花"
    DFCNSL["CURRENCY_FRAGMENT"] = "以太裂片"
    DFCNSL["TOOLTIP_CHARACTER_NAME"] = "角色名稱 - 伺服器"
    DFCNSL["TOOLTIP_PROF_CONCENTRATION"] = "商業技能(專注點)"
    DFCNSL["TOOLTIP_KEY_ACQUISITION"] = "鑰匙總數量 | 本週獲取數量/4"
    DFCNSL["TOOLTIP_SHARD_ACQUISITION"] = "裂片總數量 | 本週裂片數量/200"
    DFCNSL["TOOLTIP_DELVE_COUNT"] = "8層以上探究合計（<2次時顯示為0）"
    DFCNSL["TOOLTIP_TREASURE_MAP"] = "探究藏寶圖獲取狀態"
    DFCNSL["TOOLTIP_GOLDEN_CACHE"] = "探究鍍金儲物箱獲取狀態"
    DFCNSL["TOOLTIP_ITEM_LEVEL"] = "角色披風裝等"
    DFCNSL["CURRENCY_MANA_CRYSTAL"] = "法力水晶"
    DFCNSL["TOOLTIP_MANA_CRYSTAL"] = "法力水晶貨幣數量"
    DFCNSL["TOOLTIP_OVERALL_ITEM_LEVEL"] = "角色全身裝等"
    DFCNSL["LEFT_CLICK"] = "左鍵: 打開/關閉面板"
    DFCNSL["COMMAND_OPEN_CLOSE"] = "|cFFFFFF00/dfcnchar|r - 開啟/關閉面板"
    DFCNSL["COMMAND_MINIMAP_ON"] = "|cFFFFFF00/dfcnchar minimap on|r - 顯示小地圖圖示"
    DFCNSL["COMMAND_MINIMAP_OFF"] = "|cFFFFFF00/dfcnchar minimap off|r - 隱藏小地圖圖示"
    DFCNSL["MACRO_COMMAND"] = "巨集命令: |cFFFFFF00/dfcnchar|r"
    DFCNSL["MINIMAP_ICON"] = "小地圖圖示: |cFFFFFF00/dfcnchar minimap on/off|r"
    DFCNSL["ESC_TO_CLOSE"] = "面板打開時按ESC可關閉"
    DFCNSL["CONCENTRATION_VALUE"] = "專注值"
    DFCNSL["NO_CONCENTRATION_TIP"] = "採集專業無專注值"
    DFCNSL["CONCENTRATION_FULL"] = "專注已滿"
    DFCNSL["CURRENT_VALUE"] = "當前值"
    DFCNSL["TIME_TO_FULL"] = "專注回滿還需"
    DFCNSL["ESTIMATED_FULL_TIME"] = "預計回滿時間"
    DFCNSL["LAST_LOGIN_TIME"] = "最後上線時間"
    DFCNSL["CURRENCY_TOOLTIP_UNKNOWN"] = "尚未登入該角色，資料未知"
    DFCNSL["CURRENCY_TOOLTIP_LOGIN"] = "請登錄該角色以自動獲取最新資料"
    DFCNSL["UNKNOWN"] = "未知"
    DFCNSL["FONT_SIZE_SLIDER"] = "字體大小: %s"
    DFCNSL["FONT_SIZE_POSITIVE"] = "字體大小: +%d"
    DFCNSL["FONT_SIZE_NEGATIVE"] = "字體大小: %d"
    DFCNSL["FONT_SIZE_ZERO"] = "字體大小: 0"
    DFCNSL["DELETE_CHAR_CONFIRM"] = "確定要刪除 |cFFFFD100%s|r 的資料嗎？"
    DFCNSL["DELETE"] = "刪除"
    DFCNSL["CANCEL"] = "取消"
    DFCNSL["DELETE_CHAR_TOOLTIP"] = "刪除此角色資料"
    DFCNSL["GREAT_VAULT_NOT_COLLECTED"] = "偉業寶庫未領取"
    DFCNSL["QUANTITY_HELD"] = "持有數量"
    DFCNSL["SEASON_CAP"] = "賽季上限"
    DFCNSL["HOLDING_CAP"] = "持有上限"
    DFCNSL["SEASON_EARNED"] = "賽季獲取"
    DFCNSL["REACHED_CAP"] = "已達上限"
    DFCNSL["NEED_MORE"] = "再獲取 %d 達到賽季上限"
    DFCNSL["HOLD_MORE"] = "再獲取 %d 達到持有上限"
	DFCNSL["WEEKLY_CAP"] = "每周上限"
	DFCNSL["REACHED_WEEKLY_CAP"] = "已達到每周上限"
	DFCNSL["NEED_MORE_WEEKLY"] = "再獲取 %d 達到每周上限"
    DFCNSL["INFO"] = "資訊"
    DFCNSL["UPGRADE"] = "升級"
    DFCNSL["RESET"] = "重置"
    DFCNSL["DATA_AUTO_UPDATED"] = "(資料已自動更新)"
    DFCNSL["DATA_MAY_BE_OUTDATED"] = "(資料可能已過期)"
    DFCNSL["VIEW_ONLY_SUPPORT"] = "(僅支援檢視)"
    DFCNSL["CURRENT_REGION_FORMAT"] = "目前為%s，每%s7點自動重置資料"
	DFCNSL["CHARACTER_LEVEL_68_PLUS"] = "目前角色68級以上"
	DFCNSL["CHARACTER_LEVEL_BELOW_68"] = "目前角色不足68級"
    DFCNSL["REGION_US"] = "[美服]"
    DFCNSL["REGION_KR"] = "[韓服]"
    DFCNSL["REGION_EU"] = "[歐服]"
    DFCNSL["REGION_TW"] = "[台服]"
    DFCNSL["REGION_CN"] = "[陸服]"
    DFCNSL["REGION_PTR"] = "[PTR]"
    DFCNSL["SUNDAY"] = "週日"
    DFCNSL["MONDAY"] = "週一"
    DFCNSL["TUESDAY"] = "週二"
    DFCNSL["WEDNESDAY"] = "週三"
    DFCNSL["THURSDAY"] = "週四"
    DFCNSL["FRIDAY"] = "週五"
    DFCNSL["SATURDAY"] = "週六"
else
	--This text has been translated by AI:DeepSeek
    DFCNSL["SECONDS"] = "s"
    DFCNSL["MINUTES"] = "min"
    DFCNSL["HOURS"] = "h"
    DFCNSL["DAYS"] = "d"
    DFCNSL["IN_BAG"] = "In Bag"
    DFCNSL["USED"] = "Used"
    DFCNSL["NOT_OBTAINED"] = "Not Obtained"
    DFCNSL["NO_PROFESSION"] = "No Profession"
    DFCNSL["PROFESSION_SLOT"] = "Profession %d"
    DFCNSL["NOT_LEARNED"] = "Not Learned"
    DFCNSL["CHARACTER_NAME"] = "Character"
    DFCNSL["PROF_CONCENTRATION"] = "Conc"
    DFCNSL["KEY_ACQUISITION"] = "Coffer Key"
    DFCNSL["SHARD_ACQUISITION"] = "Key Shard"
    DFCNSL["DELVE_COUNT"] = "Delves"
    DFCNSL["TREASURE_MAP"] = "Bounty"
    DFCNSL["GOLDEN_CACHE"] = "Stash"
    DFCNSL["ITEM_LEVEL"] = "ilvl"
    DFCNSL["OVERALL_ITEM_LEVEL"] = "avg ilvl"
    DFCNSL["MANUAL_UPDATE"] = "Manual Update"
    DFCNSL["SWITCH_TO_CURRENCY"] = "to Currency Statistics"
    DFCNSL["SWITCH_TO_DELVES"] = "to Delves Statistics"
    DFCNSL["MULTI_CHAR_MANAGER"] = "Multi-Character Dashboard"
    DFCNSL["MULTI_CHAR_MANAGER_SHORT"] = "MCD Manager"
    DFCNSL["DELVES_STATS"] = "Delves Statistics"
    DFCNSL["CURRENCY_STATS"] = "Season Currency Statistics"
    DFCNSL["FONT_SIZE"] = "Font"
    DFCNSL["CLICK_OR_SPACE"] = "Click or press SPACE to switch view mode"
    DFCNSL["CHARACTER_RESET"] = "Multi-Character Dashboard: Reset weekly data for %d characters!"
    DFCNSL["ADDON_LOADED"] = "Multi-Character Dashboard loaded"
    DFCNSL["DATABASE_CREATED"] = "Created new addon character database (v%s)"
    DFCNSL["DATA_UPDATED"] = "Current character data manually updated"
    DFCNSL["MINIMAP_SHOWN"] = "Minimap icon shown"
    DFCNSL["MINIMAP_HIDDEN"] = "Minimap icon hidden"
    DFCNSL["CHARACTER_DELETED"] = "Deleted character: %s"
    DFCNSL["SHOW_MINIMAP_ICON"] = "Show Minimap Icon"
    DFCNSL["OPEN_PANEL"] = "Open Panel"
    DFCNSL["CLOSE_PANEL"] = "Close Panel"
    DFCNSL["MACRO_COMMAND"] = "Macro: /dfcnchar"
    DFCNSL["ORIGINAL_DOWNLOAD"] = "Original Release:"
    DFCNSL["CLICK_TO_COPY"] = "Click to select, Ctrl+C to copy"
    DFCNSL["CURRENCY"] = "Currency"
    DFCNSL["CURRENCY_VALOR"] = "Valorstones"
    DFCNSL["CURRENCY_CATACLYSM"] = "Undercoin"
    DFCNSL["CURRENCY_WEATHERED"] = "Weathered"
    DFCNSL["CURRENCY_ETCHED"] = "Carved"
    DFCNSL["CURRENCY_RUNED"] = "Runed"
    DFCNSL["CURRENCY_GILDED"] = "Gilded"
    DFCNSL["CURRENCY_STARLIGHT"] = "Starlight"
    DFCNSL["CURRENCY_FRAGMENT"] = "Voidsplinter"
    DFCNSL["TOOLTIP_CHARACTER_NAME"] = "Character Name - Server"
    DFCNSL["TOOLTIP_PROF_CONCENTRATION"] = "Profession (Concentration)"
    DFCNSL["TOOLTIP_KEY_ACQUISITION"] = "Total Keys | Weekly Keys/4"
    DFCNSL["TOOLTIP_SHARD_ACQUISITION"] = "Total Shards | Weekly Shards/200"
    DFCNSL["TOOLTIP_DELVE_COUNT"] = "Level 8+ Delves completed (0 if <2)"
    DFCNSL["TOOLTIP_TREASURE_MAP"] = "Delver's Bounty status"
    DFCNSL["TOOLTIP_GOLDEN_CACHE"] = "Gilded Stash status"
    DFCNSL["TOOLTIP_ITEM_LEVEL"] = "Character belt item level"
    DFCNSL["CURRENCY_MANA_CRYSTAL"] = "Crystals"
    DFCNSL["TOOLTIP_MANA_CRYSTAL"] = "Mana-Crystals held"
    DFCNSL["TOOLTIP_OVERALL_ITEM_LEVEL"] = "Character overall item level"
    DFCNSL["LEFT_CLICK"] = "Left Click: Open/Close panel"
    DFCNSL["COMMAND_OPEN_CLOSE"] = "|cFFFFFF00/dfcnchar|r - Open/Close panel"
    DFCNSL["COMMAND_MINIMAP_ON"] = "|cFFFFFF00/dfcnchar minimap on|r - Show minimap icon"
    DFCNSL["COMMAND_MINIMAP_OFF"] = "|cFFFFFF00/dfcnchar minimap off|r - Hide minimap icon"
    DFCNSL["MACRO_COMMAND"] = "Macro: |cFFFFFF00/dfcnchar|r"
    DFCNSL["MINIMAP_ICON"] = "Minimap icon: |cFFFFFF00/dfcnchar minimap on/off|r"
    DFCNSL["ESC_TO_CLOSE"] = "ESC:Close Panel"
    DFCNSL["CONCENTRATION_VALUE"] = "Concentration"
    DFCNSL["NO_CONCENTRATION_TIP"] = "Gathering professions have no concentration"
    DFCNSL["CONCENTRATION_FULL"] = "Concentration Full"
    DFCNSL["CURRENT_VALUE"] = "Current Value"
    DFCNSL["TIME_TO_FULL"] = "Time to Full"
    DFCNSL["ESTIMATED_FULL_TIME"] = "Estimated Full Time"
    DFCNSL["LAST_LOGIN_TIME"] = "Last Login Time"
    DFCNSL["CURRENCY_TOOLTIP_UNKNOWN"] = "Haven't logged in this character data unknown"
    DFCNSL["CURRENCY_TOOLTIP_LOGIN"] = "Please log in this character to get the latest data automatically"
    DFCNSL["UNKNOWN"] = "Unknown"
    DFCNSL["FONT_SIZE_SLIDER"] = "Font Size: %s"
    DFCNSL["FONT_SIZE_POSITIVE"] = "Font Size: +%d"
    DFCNSL["FONT_SIZE_NEGATIVE"] = "Font Size: %d"
    DFCNSL["FONT_SIZE_ZERO"] = "Font Size: 0"
    DFCNSL["DELETE_CHAR_CONFIRM"] = "Are you sure you want to delete data for |cFFFFD100%s|r?"
    DFCNSL["DELETE"] = "Delete"
    DFCNSL["CANCEL"] = "Cancel"
    DFCNSL["DELETE_CHAR_TOOLTIP"] = "Delete this character data"
    DFCNSL["GREAT_VAULT_NOT_COLLECTED"] = "Great Vault not collected"
    DFCNSL["QUANTITY_HELD"] = "Quantity Held"
    DFCNSL["SEASON_CAP"] = "Season Cap"
    DFCNSL["HOLDING_CAP"] = "Holding Cap"
	DFCNSL["WEEKLY_CAP"] = "Weekly Cap"
    DFCNSL["SEASON_EARNED"] = "Season Earned"
    DFCNSL["REACHED_CAP"] = "Reached Cap"
    DFCNSL["NEED_MORE"] = "Need %d more for season cap"
    DFCNSL["HOLD_MORE"] = "Need %d more for holding cap"
	DFCNSL["REACHED_WEEKLY_CAP"] = "Reached weekly cap"
	DFCNSL["NEED_MORE_WEEKLY"] = "Need %d more to reach weekly cap"
    DFCNSL["INFO"] = "Info"
    DFCNSL["UPGRADE"] = "Upgrade"
    DFCNSL["RESET"] = "Reset"
    DFCNSL["DATA_AUTO_UPDATED"] = "(Data auto updated)"
    DFCNSL["DATA_MAY_BE_OUTDATED"] = "(Data may be outdated)"
    DFCNSL["VIEW_ONLY_SUPPORT"] = "(View only)"
    DFCNSL["CURRENT_REGION_FORMAT"] = "Currently in %s data resets automatically at 7:00 every %s"
	DFCNSL["CHARACTER_LEVEL_68_PLUS"] = "Current character level 68 or above"
	DFCNSL["CHARACTER_LEVEL_BELOW_68"] = "Current character below level 68"
    DFCNSL["REGION_US"] = "[US]"
    DFCNSL["REGION_KR"] = "[KR]"
    DFCNSL["REGION_EU"] = "[EU]"
    DFCNSL["REGION_TW"] = "[TW]"
    DFCNSL["REGION_CN"] = "[CN]"
    DFCNSL["REGION_PTR"] = "[PTR]"
    DFCNSL["SUNDAY"] = "Sunday"
    DFCNSL["MONDAY"] = "Monday"
    DFCNSL["TUESDAY"] = "Tuesday"
    DFCNSL["WEDNESDAY"] = "Wednesday"
    DFCNSL["THURSDAY"] = "Thursday"
    DFCNSL["FRIDAY"] = "Friday"
    DFCNSL["SATURDAY"] = "Saturday"
end

local DFCN_Status = {}
DFCN_Status.db = {}
DFCN_Status.VERSION = "v1.47"
local dbVersion = 3
local function GetResetWeekday()
    local region = GetCurrentRegion()    
    if region == 1 then
        return 3
    elseif region == 3 then
        return 4
    else
        return 5
    end
end

local itemInfoRetryAttempts = 0
local MAX_RETRY_ATTEMPTS = 3
local craftUpdateThrottle = 0
local function ShortenProfName(name)
    if not name then return "" end
    local shortName = string.sub(name, 1, 6)
    return shortName
end

local function FormatTime(seconds)
    if seconds < 60 then
        return string.format("%d" .. DFCNSL["SECONDS"], seconds)
    elseif seconds < 3600 then
        return string.format("%d" .. DFCNSL["MINUTES"], seconds / 60)
    elseif seconds < 86400 then
        return string.format("%d" .. DFCNSL["HOURS"] .. "%d" .. DFCNSL["MINUTES"], seconds / 3600, (seconds % 3600) / 60)
    else
        return string.format("%d" .. DFCNSL["DAYS"] .. "%d" .. DFCNSL["HOURS"], seconds / 86400, (seconds % 86400) / 3600)
    end
end

local function tContains(t, value)
    for _, v in ipairs(t) do
        if v == value then
            return true
        end
    end
    return false
end

local function GetPreciseTime()
    return time() + (DFCN_Status.serverTimeOffset or 0)
end

DFCN_Status.concentrationTracker = {
    values = {},
    lastUpdated = 0
}

local miniMapButton = nil
local miniMapIcon = "Interface\\Icons\\spell_magic_lesserinvisibilty"
local CURRENCY_UPDATE_DELAY = 2
local lastCurrencyUpdate = 0
local COLORS = {
    BACKGROUND = {r = 0.1, g = 0.1, b = 0.1, a = 0.9},
    TEXT_WHITE = {r = 1.0, g = 1.0, b = 1.0},
    TEXT_HIGHLIGHT = {r = 1.0, g = 0.82, b = 0},
    TEXT_PURPLE = {r = 0.63, g = 0.21, b = 0.93},
    TEXT_RED = {r = 1.0, g = 0.25, b = 0.25},
    TEXT_GREEN = {r = 0.25, g = 1.0, b = 0.25},
    TEXT_YELLOW = {r = 1.0, g = 1.0, b = 0},
    TEXT_GRAY = {r = 0.5, g = 0.5, b = 0.5}
}

local CONCENTRATION_COLORS = {
    HIGH = {r = 1.0, g = 0.25, b = 0.25},
    LOW = {r = 0.25, g = 1.0, b = 0.25},
    BACKGROUND = {r = 0.1, g = 0.1, b = 0.1, a = 0.8}
}

local function GetConcentrationColor(value)
    if value < 856 then
        return CONCENTRATION_COLORS.LOW
    else
        return CONCENTRATION_COLORS.HIGH
    end
end

local CLASS_COLORS = {
    WARRIOR = {r = 0.78, g = 0.61, b = 0.43},
    PALADIN = {r = 0.96, g = 0.55, b = 0.73},
    HUNTER = {r = 0.67, g = 0.83, b = 0.45},
    ROGUE = {r = 1.00, g = 0.96, b = 0.41},
    PRIEST = {r = 1.00, g = 1.00, b = 1.00},
    DEATHKNIGHT = {r = 0.77, g = 0.12, b = 0.23},
    SHAMAN = {r = 0.00, g = 0.44, b = 0.87},
    MAGE = {r = 0.25, g = 0.78, b = 0.92},
    WARLOCK = {r = 0.53, g = 0.53, b = 0.93},
    MONK = {r = 0.00, g = 1.00, b = 0.59},
    DRUID = {r = 1.00, g = 0.49, b = 0.04},
    DEMONHUNTER = {r = 0.64, g = 0.19, b = 0.79},
    EVOKER = {r = 0.20, g = 0.58, b = 0.50}
}

local ENHANCED_CLASS_COLORS = {}
for class, color in pairs(CLASS_COLORS) do
    ENHANCED_CLASS_COLORS[class] = {
        r = math.min(color.r * 1.0, 1.0),
        g = math.min(color.g * 1.0, 1.0),
        b = math.min(color.b * 1.0, 1.0)
    }
end

local CURRENCY_IDS = {3008, 2803, 3284, 3286, 3288, 3290, 3141, 3269}

local CURRENCY_NAMES = {
    [3008] = DFCNSL["CURRENCY_VALOR"],
    [2803] = DFCNSL["CURRENCY_CATACLYSM"],
    [3284] = DFCNSL["CURRENCY_WEATHERED"],
    [3286] = DFCNSL["CURRENCY_ETCHED"],
    [3288] = DFCNSL["CURRENCY_RUNED"],
    [3290] = DFCNSL["CURRENCY_GILDED"],
    [3141] = DFCNSL["CURRENCY_STARLIGHT"],
    [3269] = DFCNSL["CURRENCY_FRAGMENT"],
    [3356] = DFCNSL["CURRENCY_MANA_CRYSTAL"]
}

local DELVES_COLUMN_LAYOUT = {
    {name = "|T236544:14:14|t" .. DFCNSL["CHARACTER_NAME"], width = 230, align = "LEFT", color = true, sortable = true, sortKey = "name"},
    {name = "|T5747318:14:14|t" .. DFCNSL["PROF_CONCENTRATION"], width = 100, align = "LEFT", color = true, sortable = true, sortKey = "prof1Concentration"},
    {name = "|T5747318:14:14|t" .. DFCNSL["PROF_CONCENTRATION"], width = 100, align = "LEFT", color = true, sortable = true, sortKey = "prof2Concentration"},
    {name = "|T4622270:14:14|t" .. DFCNSL["KEY_ACQUISITION"], width = 100, align = "CENTER", color = true, sortable = true, sortKey = "keyStatus"},
    {name = "|T133016:14:14|t" .. DFCNSL["SHARD_ACQUISITION"], width = 110, align = "CENTER", color = true, sortable = true, sortKey = "shardStatus"},
    {name = DFCNSL["DELVE_COUNT"], width = 80, align = "CENTER", color = true, sortable = true, sortKey = "delveCount"},
    {name = "|T1064187:14:14|t" .. DFCNSL["TREASURE_MAP"], width = 85, align = "CENTER", color = true, sortable = true, sortKey = "treasureStatus"},
    {name = "|T5872049:14:14|t" .. DFCNSL["GOLDEN_CACHE"], width = 95, align = "CENTER", color = true, sortable = true, sortKey = "goldenCacheStatus"}, 
    {name = "|T132849:14:14|t" .. DFCNSL["CURRENCY_MANA_CRYSTAL"], width = 95, align = "CENTER", color = true, sortable = true, sortKey = "currency_3356"},
    {name = DFCNSL["OVERALL_ITEM_LEVEL"], width = 85, align = "CENTER", color = false, sortable = true, sortKey = "overallItemLevel"},
    {name = "", width = 15, align = "CENTER", color = false, sortable = false} 
}

local CURRENCY_COLUMN_LAYOUT = {
    {name = "|T236544:14:14|t" .. DFCNSL["CHARACTER_NAME"], width = 230, align = "LEFT", color = true, sortable = true, sortKey = "name"}
}

for _, currencyID in ipairs(CURRENCY_IDS) do
    local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(currencyID)
    if currencyInfo then
        local displayName = CURRENCY_NAMES[currencyID] or currencyInfo.name
        
        table.insert(CURRENCY_COLUMN_LAYOUT, {
            name = "|T" .. currencyInfo.iconFileID .. ":14:14|t" .. displayName,
            width = 106,
            align = "CENTER",
            color = true,
            sortable = true,
            sortKey = "currency_" .. currencyID,
            currencyID = currencyID
        })
    end
end

table.insert(CURRENCY_COLUMN_LAYOUT, {name = "", width = 15, align = "CENTER", color = false, sortable = false})

local COLUMN_TOOLTIPS = {
    ["|T236544:14:14|t" .. DFCNSL["CHARACTER_NAME"]] = DFCNSL["TOOLTIP_CHARACTER_NAME"],
    ["|T5747318:14:14|t" .. DFCNSL["PROF_CONCENTRATION"]] = DFCNSL["TOOLTIP_PROF_CONCENTRATION"],
    ["|T4622270:14:14|t" .. DFCNSL["KEY_ACQUISITION"]] = DFCNSL["TOOLTIP_KEY_ACQUISITION"],
    ["|T133016:14:14|t" .. DFCNSL["SHARD_ACQUISITION"]] = DFCNSL["TOOLTIP_SHARD_ACQUISITION"],
    [DFCNSL["DELVE_COUNT"]] = DFCNSL["TOOLTIP_DELVE_COUNT"],
    ["|T1064187:14:14|t" .. DFCNSL["TREASURE_MAP"]] = DFCNSL["TOOLTIP_TREASURE_MAP"],
    ["|T5872049:14:14|t" .. DFCNSL["GOLDEN_CACHE"]] = DFCNSL["TOOLTIP_GOLDEN_CACHE"],
    ["|T132849:14:14|t" .. DFCNSL["CURRENCY_MANA_CRYSTAL"]] = DFCNSL["TOOLTIP_MANA_CRYSTAL"],
    [DFCNSL["OVERALL_ITEM_LEVEL"]] = DFCNSL["TOOLTIP_OVERALL_ITEM_LEVEL"]
}

for _, currencyID in ipairs(CURRENCY_IDS) do
    local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(currencyID)
    if currencyInfo then
        local displayName = CURRENCY_NAMES[currencyID] or currencyInfo.name
        COLUMN_TOOLTIPS["|T" .. currencyInfo.iconFileID .. ":14:14|t" .. displayName] = currencyInfo.description
    end
end

local CONCENTRATION_MAX = 1000
local CONCENTRATION_RECOVERY_RATE = 345

local CONCENTRATION_CURRENCY_IDS = {
    [164] = 3040,
    [171] = 3045,
    [202] = 3044,
    [197] = 3041,
    [333] = 3046,
    [165] = 3042,
    [755] = 3013,
    [773] = 3043
}

local NO_CONCENTRATION_PROFESSIONS = {
    [393] = true,
    [186] = true,
    [182] = true
}

local isUpdateLevel = false

local function TreasureStatusToValue(status)
    if status == DFCNSL["IN_BAG"] then
        return 2
    elseif status == DFCNSL["USED"] then
        return 1
    else
        return 0
    end
end

function DFCN_Status:GetLastResetTime()
    local currentTime = GetPreciseTime()
    local t = date("*t", currentTime)
    
    local resetWeekday = GetResetWeekday()
    
    local daysToReset
    if t.wday <= resetWeekday then
        daysToReset = resetWeekday - t.wday
    else
        daysToReset = resetWeekday - t.wday + 7
    end
    
    local resetTime = time({
        year = t.year, 
        month = t.month, 
        day = t.day + daysToReset,
        hour = 7,
        min = 0,
        sec = 0
    })
    
    if currentTime >= resetTime then
        return resetTime
    end
    
    return resetTime - 7 * 86400
end

function DFCN_Status:CheckAllCharactersReset()
    local resetTime = self:GetLastResetTime()
    local resetCount = 0
    
    for charKey, charData in pairs(DFCN_Status.db.characters) do
        if charData.lastUpdated and charData.level and charData.level >= 68 then
            if charData.lastUpdated < resetTime then
                charData.treasureStatus = DFCNSL["NOT_OBTAINED"]
                charData.goldenCacheStatus = "0/3"
                charData.delveCount = 0
                charData.keyStatus.completedQuests = 0
                charData.shardStatus.shardsFromBoxes = 0             
                resetCount = resetCount + 1                
                charData.lastUpdated = resetTime
            end
        end
    end
    
    if resetCount > 0 then
        print("|T135994:14:14|t |cFF00BFFF[" .. DFCNSL["INFO"] .. "]|r |c000EEEEE" .. DFCNSL["CHARACTER_RESET"], resetCount)
    end
end

function DFCN_Status:UpdateConcentrationTracker()
    local now = GetPreciseTime()
    local elapsed = now - self.concentrationTracker.lastUpdated
    
    for profKey, profData in pairs(self.concentrationTracker.values) do
        if profData.hasConcentration then
            local newValue = profData.value + (elapsed / CONCENTRATION_RECOVERY_RATE)
            if newValue > CONCENTRATION_MAX then
                newValue = CONCENTRATION_MAX
            end
            
            profData.value = newValue
        end
    end
    
    self.concentrationTracker.lastUpdated = now
end

function DFCN_Status:GetCharacterKey()
    local name, realm = UnitFullName("player")
    if not realm then
        realm = GetRealmName()
    end
    return name .. "-" .. realm
end

function DFCN_Status:SaveOnLogout()
    self:UpdateConcentrationTracker()
    
    local charKey = self:GetCharacterKey()
    if not DFCN_Status.db.characters[charKey] then 
        return 
    end
    
    DFCN_Status.db.characters[charKey].concentration = {
        prof1 = CopyTable(self.concentrationTracker.values.prof1 or {value = 0.0, name = DFCNSL["NO_PROFESSION"], hasConcentration = false}),
        prof2 = CopyTable(self.concentrationTracker.values.prof2 or {value = 0.0, name = DFCNSL["NO_PROFESSION"], hasConcentration = false}),
        lastUpdated = GetPreciseTime()
    }
end

function DFCN_Status:GetOverallItemLevel()
    local overall, equipped = GetAverageItemLevel()
    return tonumber(string.format("%.2f", equipped or overall))
end

function DFCN_Status:GetBeltItemLevel()
    local slotID = 15
    local beltLink = GetInventoryItemLink("player", slotID)
    
    local currentAttempt = itemInfoRetryAttempts
    
    if not beltLink then
        if currentAttempt < MAX_RETRY_ATTEMPTS then
            itemInfoRetryAttempts = itemInfoRetryAttempts + 1
            C_Timer.After(1, function() 
                DFCN_Status:GetBeltItemLevel() 
            end)
        end
        return 0
    end

    itemInfoRetryAttempts = 0
    
    local name, _, quality, itemLevel = GetItemInfo(beltLink)
    if itemLevel and itemLevel > 0 then
        return math.floor(itemLevel + 0.5)
    end
    
    local itemString = beltLink:match("item[%-?%d:]+")
    if itemString then
        local parts = {strsplit(":", itemString)}
        if #parts >= 12 then
            local ilvl = tonumber(parts[12])
            if ilvl and ilvl > 0 then
                return ilvl
            end
        end
    end
    
    local itemQuality = GetInventoryItemQuality("player", slotID)
    if itemQuality then
        return itemQuality
    end
    
    return 0
end

function DFCN_Status:GetTreasureStatus()
    local hasItem = GetItemCount(248142) > 0
    local questDone = C_QuestLog.IsQuestFlaggedCompleted(86371)
    
    if hasItem then
        return DFCNSL["IN_BAG"]
    elseif questDone then
        return DFCNSL["USED"]
    else
        return DFCNSL["NOT_OBTAINED"]
    end
end

function DFCN_Status:GetGoldenCacheStatus(charData)
    local widgetInfo = C_UIWidgetManager.GetSpellDisplayVisualizationInfo(6659)
    
    if widgetInfo and widgetInfo.spellInfo and widgetInfo.spellInfo.tooltip then
        local tooltipText = widgetInfo.spellInfo.tooltip
        local currentCount = tonumber(string.match(tooltipText, "(%d)/3"))
        
        if currentCount then
            return currentCount .. "/3"
        end
    end
    
    return charData and charData.goldenCacheStatus or "0/3"
end

function DFCN_Status:GetLevel8DelvesDoneCount()
    local worldActivities = C_WeeklyRewards.GetActivities(Enum.WeeklyRewardChestThresholdType.World)
    
    if not worldActivities or #worldActivities == 0 then
        return 0
    end
    
    for i = #worldActivities, 1, -1 do 
        local activity = worldActivities[i]
        
        if activity ~= nil and activity.level >= 8 then
            return activity.progress
        end
    end
    
    return 0
end

function DFCN_Status:IsItemDataReady()
    return GetItemInfo(6948) ~= nil
end

function DFCN_Status:GetConcentrationData()
    self:UpdateConcentrationTracker()
    
    local concentrationData = {
        lastUpdated = GetPreciseTime(),
        prof1 = CopyTable(self.concentrationTracker.values.prof1 or {value = 0.0, name = DFCNSL["NO_PROFESSION"], hasConcentration = false}),
        prof2 = CopyTable(self.concentrationTracker.values.prof2 or {value = 0.0, name = DFCNSL["NO_PROFESSION"], hasConcentration = false})
    }
    
    return concentrationData
end

function DFCN_Status:SyncProfessionData()
    local prof1, prof2 = GetProfessions()
    local professions = {prof1, prof2}
    
    for i, slot in ipairs(professions) do
        if slot then
            local name, _, _, _, _, _, skillLine = GetProfessionInfo(slot)
            local currencyId = CONCENTRATION_CURRENCY_IDS[skillLine]
            local hasConcentration = currencyId and not NO_CONCENTRATION_PROFESSIONS[skillLine]
            
            if hasConcentration then
                local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(currencyId)
                if currencyInfo then
                    local profKey = "prof" .. i
                    local apiValue = currencyInfo.quantity
                    
                    self.concentrationTracker.values[profKey] = {
                        value = apiValue + 0.0,
                        name = name,
                        currencyId = currencyId,
                        skillLine = skillLine,
                        hasConcentration = true
                    }
                end
            else
                self.concentrationTracker.values["prof"..i] = {
                    value = 0.0,
                    name = name or string.format(DFCNSL["PROFESSION_SLOT"], i),
                    hasConcentration = false
                }
            end
        end
    end
    
    self.concentrationTracker.lastUpdated = GetPreciseTime()
end

function DFCN_Status:GetCurrencyData()
    local currencyData = {}
    
    for _, currencyID in ipairs(CURRENCY_IDS) do
        local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(currencyID)
        if currencyInfo then
            currencyData[currencyID] = {
                quantity = currencyInfo.quantity,
                totalEarned = currencyInfo.totalEarned or 0,
                name = currencyInfo.name,
                iconFileID = currencyInfo.iconFileID
            }
        end
    end

    local manaCrystalInfo = C_CurrencyInfo.GetCurrencyInfo(3356)
    if manaCrystalInfo then
        currencyData[3356] = {
            quantity = manaCrystalInfo.quantity,
            totalEarned = manaCrystalInfo.totalEarned or 0,
            name = manaCrystalInfo.name,
            iconFileID = manaCrystalInfo.iconFileID
        }
    end
    
    return currencyData
end

function DFCN_Status:UpdateCharacterData(silent)
    local playerLevel = UnitLevel("player")
    if playerLevel < 68 then 
        return 
    end
    
    if not self:IsItemDataReady() then
        C_Timer.After(1, function()
            DFCN_Status:UpdateCharacterData(silent)
        end)
        return
    end
    
    local charKey = self:GetCharacterKey()
    if not DFCN_Status.db.characters[charKey] then
        DFCN_Status.db.characters[charKey] = {}
        DFCN_Status.db.characters[charKey].keyStatus = {
            totalKeys = 0,
            completedQuests = 0
        }
        DFCN_Status.db.characters[charKey].shardStatus = {
            totalShards = 0,
            shardsFromBoxes = 0
        }
        DFCN_Status.db.characters[charKey].currencies = {}
    end

    local charData = DFCN_Status.db.characters[charKey]

    local keyStatus = self:GetKeyStatus()
    charData.keyStatus = keyStatus

    local shardStatus = self:GetShardStatus()
    charData.shardStatus = shardStatus
    
    self:SyncProfessionData()
    
    charData.overallItemLevel = self:GetOverallItemLevel()
    charData.beltItemLevel = self:GetBeltItemLevel()
    charData.treasureStatus = self:GetTreasureStatus()
    charData.goldenCacheStatus = self:GetGoldenCacheStatus(charData)
    charData.class = select(2, UnitClass("player"))
    charData.lastUpdated = GetPreciseTime()
    charData.name = UnitName("player")
    charData.realm = GetRealmName()
    charData.delveCount = self:GetLevel8DelvesDoneCount()
    charData.level = playerLevel    
    charData.concentration = self:GetConcentrationData()    
    charData.currencies = self:GetCurrencyData()
    if charKey == self:GetCharacterKey() then
        charData.hasWeeklyRewards = C_WeeklyRewards.HasAvailableRewards()
    end
end

function DFCN_Status:GetCurrentConcentration(profData, lastUpdated)
    if not profData or not profData.hasConcentration then 
        return nil, false
    end
    
    local currentTime = GetPreciseTime()
    local elapsed = currentTime - lastUpdated
    
    local current = math.min(CONCENTRATION_MAX, profData.value + (elapsed / CONCENTRATION_RECOVERY_RATE))
    
    return current, true
end

function DFCN_Status:GetKeyStatus()
    local keyInfo = C_CurrencyInfo.GetCurrencyInfo(3028)
    local totalKeys = keyInfo and keyInfo.quantity or 0
    
    local WEEKLY_QUEST_IDS = {91175, 91176, 91177, 91178}
    local completedQuests = 0
    for _, questID in ipairs(WEEKLY_QUEST_IDS) do
        if C_QuestLog.IsQuestFlaggedCompleted(questID) then
            completedQuests = completedQuests + 1
        end
    end
    
    return {
        totalKeys = totalKeys,
        completedQuests = completedQuests
    }
end

function DFCN_Status:GetShardStatus()
    local SHARD_ITEM_ID = 245653
    local totalShards = GetItemCount(SHARD_ITEM_ID, true) or 0
    
    local BOX_QUEST_IDS = {84736, 84737, 84738, 84739}
    local completedBoxes = 0
    for _, questID in ipairs(BOX_QUEST_IDS) do
        if C_QuestLog.IsQuestFlaggedCompleted(questID) then
            completedBoxes = completedBoxes + 1
        end
    end
    local shardsFromBoxes = completedBoxes * 50
    
    return {
        totalShards = totalShards,
        shardsFromBoxes = shardsFromBoxes
    }
end

function DFCN_Status:CreateMiniMapButton()
    if not DFCN_Status.db.minimap then
        DFCN_Status.db.minimap = {
            hide = false,
            position = nil
        }
    end
    
    local LDB = LibStub and LibStub:GetLibrary("LibDataBroker-1.1", true)
    if LDB then
        local minimapData = LDB:NewDataObject("DFCN_CharacterStatus", {
            type = "data source",
            text = DFCNSL["MULTI_CHAR_MANAGER"],
            icon = miniMapIcon,
            OnClick = function(_, button)
                if button == "LeftButton" then
                    if DFCN_Status.uiFrame and DFCN_Status.uiFrame:IsVisible() then
                        DFCN_Status.uiFrame:Hide()
                    else
                        DFCN_Status:ShowUI()
                    end
                end
            end,
            OnTooltipShow = function(tooltip)
                tooltip:SetText("|c000EEE00" .. DFCNSL["MULTI_CHAR_MANAGER"] .. "|r|cFFFFA500 By|r|c000EEEEE DFCN")
				tooltip:AddLine(" ")
                tooltip:AddLine(DFCNSL["LEFT_CLICK"], 1, 1, 1)
                tooltip:AddLine(DFCNSL["MACRO_COMMAND"], 0.5, 1, 1)
                tooltip:AddLine(DFCNSL["MINIMAP_ICON"], 0.5, 1, 1)
                tooltip:AddLine(DFCNSL["ESC_TO_CLOSE"], 0.8, 0.8, 0.8)
            end
        })
        
        local LibDBIcon = LibStub and LibStub:GetLibrary("LibDBIcon-1.0", true)
        if LibDBIcon then
            LibDBIcon:Register("DFCN_CharacterStatus", minimapData, DFCN_Status.db.minimap)
            if DFCN_Status.db.minimap.hide then
                LibDBIcon:Hide("DFCN_CharacterStatus")
            else
                LibDBIcon:Show("DFCN_CharacterStatus")
            end
        end
    end
end

function DFCN_Status:CreateUI()
    if DFCN_Status.uiFrame then 
        DFCN_Status.uiFrame:Show()
        return 
    end
    
    table.insert(UISpecialFrames, "CharacterStatusFrame")
    local f = CreateFrame("Frame", "CharacterStatusFrame", UIParent)
    f:SetSize(1250, 430)
    f:SetPoint("CENTER")
    f:SetFrameStrata("HIGH")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
	f:SetScript("OnKeyDown", function(self, key)
		if key == "SPACE" then
			DFCN_Status.db.viewMode = DFCN_Status.db.viewMode == "delves" and "currency" or "delves"
			DFCN_Status.titleText:SetText(DFCN_Status.db.viewMode == "delves" and 
				"|T135994:14:14|t " .. DFCNSL["MULTI_CHAR_MANAGER"] .. " - " .. DFCNSL["DELVES_STATS"] or 
				"|T135994:14:14|t " .. DFCNSL["MULTI_CHAR_MANAGER"] .. " - " .. DFCNSL["CURRENCY_STATS"])
			DFCN_Status.toggleViewBtn.text:SetText(DFCN_Status.db.viewMode == "delves" and DFCNSL["SWITCH_TO_CURRENCY"] or DFCNSL["SWITCH_TO_DELVES"])
			DFCN_Status:UpdateUI()
		elseif key == "ESCAPE" then
			self:Hide()
			collectgarbage("collect")
			self:SetPropagateKeyboardInput(false)
			return true
		end
		self:SetPropagateKeyboardInput(true)
	end)

	f:SetPropagateKeyboardInput(true)
	f:SetScript("OnHide", function()
		collectgarbage("collect")
		if fontOffsetSlider and fontOffsetSlider:IsShown() then
			fontOffsetSlider:Hide()
		end
	end)
    
    local bg = f:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints(true)
    bg:SetColorTexture(0, 0, 0, 0.8)
    
    local titleBar = CreateFrame("Frame", nil, f)
    titleBar:SetSize(1240, 24)
    titleBar:SetPoint("TOP", 0, -2)
    titleBar:EnableMouse(true)
    titleBar:RegisterForDrag("LeftButton")
    titleBar:SetScript("OnDragStart", function(self) 
        local x, y = GetCursorPosition()
        local scale = f:GetEffectiveScale()
        f:StartMoving()
        f.dragOffsetX = (x / scale) - f:GetLeft()
        f.dragOffsetY = f:GetTop() - (y / scale)
    end)
    
    titleBar:SetScript("OnDragStop", function(self)
        f:StopMovingOrSizing()
        f.dragOffsetX = nil
        f.dragOffsetY = nil
    end)
    
    f:SetScript("OnUpdate", function(self, elapsed)
        if self.dragOffsetX then
            local x, y = GetCursorPosition()
            local scale = self:GetEffectiveScale()
            local left = (x / scale) - self.dragOffsetX
            local top = (y / scale) + self.dragOffsetY
            left = math.max(0, math.min(left, GetScreenWidth() - self:GetWidth()))
            top = math.min(GetScreenHeight(), math.max(top, self:GetHeight()))            
            self:ClearAllPoints()
            self:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
        end
    end)
    
    local titleBarBg = titleBar:CreateTexture(nil, "BACKGROUND")
    titleBarBg:SetAllPoints(true)
    titleBarBg:SetColorTexture(0, 0, 0, 0.0)
    
    local titleText = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleText:SetFont(GameFontNormal:GetFont(), 16)
    titleText:SetPoint("CENTER", 0, -10)
    titleText:SetText(DFCN_Status.db.viewMode == "delves" and 
    "|T135994:14:14|t " .. DFCNSL["MULTI_CHAR_MANAGER"] .. " - " .. DFCNSL["DELVES_STATS"] or 
    "|T135994:14:14|t " .. DFCNSL["MULTI_CHAR_MANAGER"] .. " - " .. DFCNSL["CURRENCY_STATS"])
	DFCN_Status.titleText = titleText
    titleText:SetTextColor(1, 0.8, 0)

	titleText:EnableMouse(true)
	titleText:SetScript("OnMouseUp", function()
		DFCN_Status.db.viewMode = DFCN_Status.db.viewMode == "delves" and "currency" or "delves"		
		DFCN_Status.titleText:SetText(DFCN_Status.db.viewMode == "delves" and 
			"|T135994:14:14|t " .. DFCNSL["MULTI_CHAR_MANAGER"] .. " — " .. DFCNSL["DELVES_STATS"] or 
			"|T135994:14:14|t " .. DFCNSL["MULTI_CHAR_MANAGER"] .. " — " .. DFCNSL["CURRENCY_STATS"])
		DFCN_Status.toggleViewBtn.text:SetText(DFCN_Status.db.viewMode == "delves" and DFCNSL["SWITCH_TO_CURRENCY"] or DFCNSL["SWITCH_TO_DELVES"])
		DFCN_Status:UpdateUI()
	end)
	titleText:SetScript("OnEnter", function(self)
		self:SetTextColor(1, 0, 1)
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:SetText(DFCNSL["CLICK_OR_SPACE"], 1, 0, 1)
		GameTooltip:Show()
	end)

	titleText:SetScript("OnLeave", function(self)
		self:SetTextColor(1, 0.8, 0)
		GameTooltip_Hide()
	end)
   
    local toggleViewBtn = CreateFrame("Button", nil, titleBar)
    toggleViewBtn:SetSize(120, 24)
    toggleViewBtn:SetPoint("RIGHT", -30, -5)
    
    toggleViewBtn.text = toggleViewBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    toggleViewBtn.text:SetPoint("CENTER")
    toggleViewBtn.text:SetText(DFCN_Status.db.viewMode == "delves" and DFCNSL["SWITCH_TO_CURRENCY"] or DFCNSL["SWITCH_TO_DELVES"])
    toggleViewBtn.text:SetTextColor(1, 1, 1)
    
    local blankTex = toggleViewBtn:CreateTexture()
    blankTex:SetColorTexture(0, 0, 0, 0)
    blankTex:SetAllPoints()
    toggleViewBtn:SetNormalTexture(blankTex)
    toggleViewBtn:SetPushedTexture(blankTex)
    toggleViewBtn:SetHighlightTexture(blankTex)
    
    toggleViewBtn:SetScript("OnEnter", function(self)
        self.text:SetTextColor(1, 0.8, 0)
    end)
    
    toggleViewBtn:SetScript("OnLeave", function(self)
        self.text:SetTextColor(1, 1, 1)
    end)
    
	toggleViewBtn:SetScript("OnClick", function() 
		DFCN_Status.db.viewMode = DFCN_Status.db.viewMode == "delves" and "currency" or "delves"
		toggleViewBtn.text:SetText(DFCN_Status.db.viewMode == "delves" and DFCNSL["SWITCH_TO_CURRENCY"] or DFCNSL["SWITCH_TO_DELVES"])		
		DFCN_Status.titleText:SetText(DFCN_Status.db.viewMode == "delves" and 
			"|T135994:14:14|t " .. DFCNSL["MULTI_CHAR_MANAGER"] .. " - " .. DFCNSL["DELVES_STATS"] or 
			"|T135994:14:14|t " .. DFCNSL["MULTI_CHAR_MANAGER"] .. " - " .. DFCNSL["CURRENCY_STATS"])	
		DFCN_Status:UpdateUI()
	end)
    
    DFCN_Status.toggleViewBtn = toggleViewBtn

	local fontAdjustBtn = CreateFrame("Button", nil, titleBar)
	fontAdjustBtn:SetSize(40, 24)
	fontAdjustBtn:SetPoint("LEFT", 2, 0)
	fontAdjustBtn.text = fontAdjustBtn:CreateFontString(nil, "OVERLAY")
	fontAdjustBtn.text:SetFont(GameFontNormal:GetFont(), 12)
	fontAdjustBtn.text:SetText(DFCNSL["FONT_SIZE"])
	fontAdjustBtn.text:SetPoint("CENTER")
	fontAdjustBtn.text:SetTextColor(1, 1, 1)

	local blankTex = fontAdjustBtn:CreateTexture()
	blankTex:SetColorTexture(0, 0, 0, 0)
	blankTex:SetAllPoints()
	fontAdjustBtn:SetNormalTexture(blankTex)
	fontAdjustBtn:SetPushedTexture(blankTex)
	fontAdjustBtn:SetHighlightTexture(blankTex)

	fontAdjustBtn:SetScript("OnEnter", function(self)
		self.text:SetTextColor(0.2, 1, 0.2)
	end)

	fontAdjustBtn:SetScript("OnLeave", function(self)
		self.text:SetTextColor(1, 1, 1)
	end)

	local fontOffsetSlider = CreateFrame("Slider", "DFCN_StatusFontOffsetSlider", f, "OptionsSliderTemplate")
	fontOffsetSlider:SetPoint("BOTTOM", fontAdjustBtn, "TOP", 100, 15)
	fontOffsetSlider:SetSize(250, 15)
	fontOffsetSlider:SetMinMaxValues(-5, 10)
	fontOffsetSlider:SetValueStep(1)
	fontOffsetSlider:SetObeyStepOnDrag(true)
	fontOffsetSlider:SetValue(DFCN_Status.db.fontOffset or 0)
	fontOffsetSlider:Hide()

	fontOffsetSlider.Low = _G[fontOffsetSlider:GetName().."Low"]
	fontOffsetSlider.High = _G[fontOffsetSlider:GetName().."High"]
	fontOffsetSlider.Text = _G[fontOffsetSlider:GetName().."Text"]

	fontOffsetSlider.Low:SetText("-5")
	fontOffsetSlider.High:SetText("+10")
	fontOffsetSlider.Text:SetText(string.format(DFCNSL["FONT_SIZE_SLIDER"], DFCN_Status.db.fontOffset or 0))

	fontAdjustBtn:SetScript("OnClick", function()
		if fontOffsetSlider:IsShown() then
			fontOffsetSlider:Hide()
		else
			fontOffsetSlider:Show()
		end
	end)

	fontOffsetSlider:SetScript("OnValueChanged", function(self, value)
		value = math.floor(value + 0.5)
		
		local displayText
		if value > 0 then
			displayText = string.format(DFCNSL["FONT_SIZE_POSITIVE"], value)
		elseif value < 0 then
			displayText = string.format(DFCNSL["FONT_SIZE_NEGATIVE"], value)
		else
			displayText = DFCNSL["FONT_SIZE_ZERO"]
		end
		
		self.Text:SetText(displayText)
		DFCN_Status.db.fontOffset = value
		DFCN_Status:ApplyFontSettings()
	end)

	f:SetScript("OnHide", function()
		if fontOffsetSlider and fontOffsetSlider:IsShown() then
			fontOffsetSlider:Hide()
		end
	end)
    
    local closeButton = CreateFrame("Button", nil, titleBar)
    closeButton:SetSize(24, 24)
    closeButton:SetPoint("RIGHT", -2, -1)
    closeButton.text = closeButton:CreateFontString(nil, "OVERLAY")
    closeButton.text:SetFont(GameFontNormal:GetFont(), 20, "OUTLINE")
    closeButton.text:SetText("×")
    closeButton.text:SetPoint("CENTER")
    closeButton.text:SetTextColor(1, 1, 1)
    
    local blankTex = closeButton:CreateTexture()
    blankTex:SetColorTexture(0, 0, 0, 0)
    blankTex:SetAllPoints()
    closeButton:SetNormalTexture(blankTex)
    closeButton:SetPushedTexture(blankTex)
    closeButton:SetHighlightTexture(blankTex)
    
    closeButton:SetScript("OnEnter", function(self)
        self.text:SetTextColor(1, 0.2, 0.2)
    end)
    
    closeButton:SetScript("OnLeave", function(self)
        self.text:SetTextColor(1, 1, 1)
    end)
    
	closeButton:SetScript("OnClick", function() 
		DFCN_Status:SaveAllCharacters()
		f:Hide()
		collectgarbage("collect")
	end)
    
    local content = CreateFrame("Frame", nil, f)
    content:SetPoint("TOPLEFT", 10, -40)
    content:SetPoint("BOTTOMRIGHT", -10, 40)
    
    local contentBg = content:CreateTexture(nil, "BACKGROUND")
    contentBg:SetColorTexture(0, 0, 0, 0)
    contentBg:SetAllPoints()
    
    DFCN_Status.content = content

    local scrollFrame = CreateFrame("ScrollFrame", nil, content)
    scrollFrame:SetPoint("TOPLEFT", 0, -30)
    scrollFrame:SetPoint("BOTTOMRIGHT", 0, 5)
    scrollFrame:SetClipsChildren(true)
    
    local scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetSize(1330, 400)
    scrollFrame:SetScrollChild(scrollChild)
    
    local scrollBar = CreateFrame("Slider", nil, scrollFrame, "UIPanelScrollBarTemplate")
    scrollBar:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", -12, -16)
    scrollBar:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", -20, 16)
    scrollBar:SetMinMaxValues(0, 0)
    scrollBar:SetValue(0)
    scrollBar:SetValueStep(20)
    scrollBar:SetWidth(10)
    scrollBar:Hide()
    
    scrollBar:SetScript("OnValueChanged", function(self, value)
        scrollFrame:SetVerticalScroll(value)
    end)
    
    scrollFrame:EnableMouseWheel(true)
    scrollFrame:SetScript("OnMouseWheel", function(self, delta)
        local current = scrollBar:GetValue()
        local minVal, maxVal = scrollBar:GetMinMaxValues()
        
        if delta < 0 then
            current = math.min(maxVal, current + 60)
        else
            current = math.max(minVal, current - 60)
        end
        
        scrollBar:SetValue(current)
    end)
    
    DFCN_Status.uiFrame = f
    DFCN_Status.scrollFrame = scrollFrame
    DFCN_Status.scrollChild = scrollChild
    DFCN_Status.scrollBar = scrollBar
    
    local updateBtn = CreateFrame("Button", nil, f)
    updateBtn:SetSize(100, 25)
    updateBtn:SetPoint("BOTTOMRIGHT", -15, 10)
    
    updateBtn.BorderTop = updateBtn:CreateTexture(nil, "BORDER")
    updateBtn.BorderTop:SetPoint("TOPLEFT", 0, 0)
    updateBtn.BorderTop:SetPoint("TOPRIGHT", 0, 0)
    updateBtn.BorderTop:SetHeight(1)
    updateBtn.BorderTop:SetColorTexture(1, 1, 1, 0.7)
    
    updateBtn.BorderBottom = updateBtn:CreateTexture(nil, "BORDER")
    updateBtn.BorderBottom:SetPoint("BOTTOMLEFT", 0, 0)
    updateBtn.BorderBottom:SetPoint("BOTTOMRIGHT", 0, 0)
    updateBtn.BorderBottom:SetHeight(1)
    updateBtn.BorderBottom:SetColorTexture(1, 1, 1, 0.7)
    
    updateBtn.BorderLeft = updateBtn:CreateTexture(nil, "BORDER")
    updateBtn.BorderLeft:SetPoint("TOPLEFT", 0, 0)
    updateBtn.BorderLeft:SetPoint("BOTTOMLEFT", 0, 0)
    updateBtn.BorderLeft:SetWidth(1)
    updateBtn.BorderLeft:SetColorTexture(1, 1, 1, 0.7)
    
    updateBtn.BorderRight = updateBtn:CreateTexture(nil, "BORDER")
    updateBtn.BorderRight:SetPoint("TOPRIGHT", 0, 0)
    updateBtn.BorderRight:SetPoint("BOTTOMRIGHT", 0, 0)
    updateBtn.BorderRight:SetWidth(1)
    updateBtn.BorderRight:SetColorTexture(1, 1, 1, 0.7)
    
    updateBtn.text = updateBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    updateBtn.text:SetPoint("CENTER")
    updateBtn.text:SetText(DFCNSL["MANUAL_UPDATE"])
    updateBtn.text:SetTextColor(1, 1, 1)

    updateBtn:SetScript("OnMouseDown", function(self)
        self.text:SetPoint("CENTER", 1, -1)
    end)
    
    updateBtn:SetScript("OnMouseUp", function(self)
        self.text:SetPoint("CENTER", 0, 0)
    end)
    
    updateBtn:SetScript("OnClick", function()
        local now = GetTime()
        if now - lastUpdateTime < 1 then
            return
        end
        lastUpdateTime = now
        
        DFCN_Status:UpdateCharacterData()
        DFCN_Status:UpdateUI()
        print("|T135994:14:14|t |cFF00BFFF[" .. DFCNSL["INFO"] .. "] " .. DFCNSL["DATA_UPDATED"])
    end)
    
    updateBtn:SetScript("OnEnter", function(self)
        updateBtn.BorderTop:SetColorTexture(1, 1, 1, 0.9)
        updateBtn.BorderBottom:SetColorTexture(1, 1, 1, 0.9)
        updateBtn.BorderLeft:SetColorTexture(1, 1, 1, 0.9)
        updateBtn.BorderRight:SetColorTexture(1, 1, 1, 0.9)
        updateBtn.text:SetTextColor(1, 0.8, 0)
    end)
    
    updateBtn:SetScript("OnLeave", function(self)
        updateBtn.BorderTop:SetColorTexture(1, 1, 1, 0.7)
        updateBtn.BorderBottom:SetColorTexture(1, 1, 1, 0.7)
        updateBtn.BorderLeft:SetColorTexture(1, 1, 1, 0.7)
        updateBtn.BorderRight:SetColorTexture(1, 1, 1, 0.7)
        updateBtn.text:SetTextColor(1, 1, 1)
    end)
    
    DFCN_Status.updateBtn = updateBtn

    local playerLevel = UnitLevel("player")
    if playerLevel < 68 then
        updateBtn:Hide()
    end
    
    local lastUpdateTime = 0
    updateBtn:SetScript("OnClick", function()
        local now = GetTime()
        if now - lastUpdateTime < 1 then            
            return
        end
        lastUpdateTime = now
        
        DFCN_Status:UpdateCharacterData()
        DFCN_Status:UpdateUI()
        print("|T135994:14:14|t |cFF00BFFF[" .. DFCNSL["INFO"] .. "] " .. DFCNSL["DATA_UPDATED"])
    end)
    
    f.tipText = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    f.tipText:SetPoint("BOTTOM", 0, 25)
	self:ApplyFontSettings()
end

function DFCN_Status:ApplyFontSettings()
    local offset = self.db.fontOffset or 0
    
    if self.titleText then
        self.titleText:SetFont(GameFontNormal:GetFont(), 16 + offset)
    end
    
    for _, headerText in pairs(self.headerTexts or {}) do
        headerText:SetFont(GameFontNormal:GetFont(), 14 + offset)
    end
    
    if self.scrollChild and self.scrollChild.rows then
        for _, row in ipairs(self.scrollChild.rows) do
            for i = 1, #DELVES_COLUMN_LAYOUT do
                if row["col"..i] then
                    row["col"..i]:SetFont(GameFontNormal:GetFont(), 13 + offset)
                end
            end
        end
    end
    
    if self.toggleViewBtn and self.toggleViewBtn.text then
        self.toggleViewBtn.text:SetFont(GameFontNormal:GetFont(), 12 + offset)
    end
    
    if self.updateBtn and self.updateBtn.text then
        self.updateBtn.text:SetFont(GameFontNormal:GetFont(), 12 + offset)
    end
end

function DFCN_Status:UpdateHeaderTexts()
    if not DFCN_Status.headerTexts then
        DFCN_Status.headerTexts = {}
        return
    end
    
    local currentLayout = DFCN_Status.db.viewMode == "delves" and DELVES_COLUMN_LAYOUT or CURRENCY_COLUMN_LAYOUT
    
    for _, col in ipairs(currentLayout) do
        if col.sortable and DFCN_Status.headerTexts[col.sortKey] then
            local indicator = ""
            if DFCN_Status.db.sortBy == col.sortKey then
                indicator = DFCN_Status.db.ascending and "↑" or "↓"
            end
            DFCN_Status.headerTexts[col.sortKey]:SetText(col.name .. indicator)
        end
    end
end

function DFCN_Status:UpdateUI()
    if DFCN_Status.header then
        for _, headerText in pairs(DFCN_Status.headerTexts or {}) do
            if headerText and headerText.SetScript then
                headerText:SetScript("OnEnter", nil)
                headerText:SetScript("OnLeave", nil)
                headerText:SetScript("OnMouseDown", nil)
            end
        end
        
        DFCN_Status.header:Hide()
        DFCN_Status.header:SetParent(nil)
        DFCN_Status.header = nil
        DFCN_Status.headerTexts = {}
    end
    
    if DFCN_Status.scrollChild.rows then
        for i, row in ipairs(DFCN_Status.scrollChild.rows) do
            if row.deleteBtn then
                row.deleteBtn:SetScript("OnClick", nil)
                row.deleteBtn:SetScript("OnEnter", nil)
                row.deleteBtn:SetScript("OnLeave", nil)
            end
            for j = 1, #CURRENCY_COLUMN_LAYOUT do
                if row["col"..j] then
                    row["col"..j]:SetScript("OnEnter", nil)
                    row["col"..j]:SetScript("OnLeave", nil)
                    row["col"..j]:SetScript("OnMouseDown", nil)
                end
            end
            
            row:Hide()
            row:SetParent(nil)
        end
        DFCN_Status.scrollChild.rows = {}
    end
    DFCN_Status.headerTexts = DFCN_Status.headerTexts or {}
    
    if DFCN_Status.header then
        DFCN_Status.header:Hide()
        DFCN_Status.header = nil
    end
    
    DFCN_Status.header = CreateFrame("Frame", nil, DFCN_Status.content)
    DFCN_Status.header:SetSize(1330, 25)
    DFCN_Status.header:SetPoint("TOPLEFT", 5, -5)
    
    local currentLayout = DFCN_Status.db.viewMode == "delves" and DELVES_COLUMN_LAYOUT or CURRENCY_COLUMN_LAYOUT
    local totalWidth = 0

    DFCN_Status.headerTexts = {}
    
    for i, col in ipairs(currentLayout) do
        local headerText = DFCN_Status.header:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        headerText:SetPoint("LEFT", DFCN_Status.header, "LEFT", totalWidth + (i == 1 and 0 or 10), 0)
        headerText:SetWidth(col.width)
        headerText:SetJustifyH(col.align)
        headerText:SetTextColor(COLORS.TEXT_HIGHLIGHT.r, COLORS.TEXT_HIGHLIGHT.g, COLORS.TEXT_HIGHLIGHT.b)
        headerText:SetText(col.name) 
        
        totalWidth = totalWidth + col.width + (i == 1 and 0 or 10)
        
        headerText:EnableMouse(true)
        headerText:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText(COLUMN_TOOLTIPS[col.name] or "N/A", 1, 1, 1)
            GameTooltip:Show()
        end)
        headerText:SetScript("OnLeave", GameTooltip_Hide)
        
        if col.sortable then
            headerText:SetScript("OnMouseDown", function()
                if DFCN_Status.db.sortBy == col.sortKey then
                    DFCN_Status.db.ascending = not DFCN_Status.db.ascending
                else
                    DFCN_Status.db.sortBy = col.sortKey
                    DFCN_Status.db.ascending = false
                end
                DFCN_Status:UpdateUI()
            end)
            
            DFCN_Status.headerTexts[col.sortKey] = headerText
        end
    end
    
    local line = DFCN_Status.header:CreateTexture(nil, "BACKGROUND")
    line:SetColorTexture(1, 1, 1, 0.3)
    line:SetSize(totalWidth, 1)
    line:SetPoint("BOTTOMLEFT", DFCN_Status.header, "BOTTOMLEFT", 0, 0)
    
    self:UpdateHeaderTexts()

    local playerLevel = UnitLevel("player")
    if playerLevel >= 68 then
        DFCN_Status.updateBtn:Show()
    else
        DFCN_Status.updateBtn:Hide()
    end

    if not DFCN_Status.uiFrame or not DFCN_Status.scrollChild then
        self:CreateUI()
    end
    
    if DFCN_Status.toggleViewBtn then
        DFCN_Status.toggleViewBtn.text:SetText(DFCN_Status.db.viewMode == "delves" and DFCNSL["SWITCH_TO_CURRENCY"] or DFCNSL["SWITCH_TO_DELVES"])
    end
    
    self:UpdateHeaderTexts()
    
	if DFCN_Status.scrollChild.rows then
		for i, row in ipairs(DFCN_Status.scrollChild.rows) do
			row:Hide()
			row:SetParent(nil)
		end
	end
	DFCN_Status.scrollChild.rows = {}
    
    local sortedChars = {}
    for charKey, charData in pairs(DFCN_Status.db.characters) do
        table.insert(sortedChars, {
            key = charKey,
            charData = charData
        })
    end
    
    local sortKey = DFCN_Status.db.sortBy
    for _, charInfo in ipairs(sortedChars) do
        local charData = charInfo.charData
        
        if sortKey == "prof1Concentration" then
            charInfo.sortValue = DFCN_Status:GetCurrentConcentration(charData.concentration.prof1, charData.concentration.lastUpdated) or 0
        elseif sortKey == "prof2Concentration" then
            charInfo.sortValue = DFCN_Status:GetCurrentConcentration(charData.concentration.prof2, charData.concentration.lastUpdated) or 0
        elseif sortKey == "goldenCacheStatus" then
            charInfo.sortValue = tonumber(charData.goldenCacheStatus:match("^(%d+)/")) or 0
        elseif sortKey == "name" then
            charInfo.sortValue = charData.class or ""
        elseif sortKey == "keyStatus" then
            charInfo.sortValue = charData.keyStatus and charData.keyStatus.completedQuests or 0
        elseif sortKey == "shardStatus" then
            charInfo.sortValue = charData.shardStatus and charData.shardStatus.shardsFromBoxes or 0
        elseif sortKey == "treasureStatus" then
            charInfo.sortValue = TreasureStatusToValue(charData.treasureStatus)
		elseif string.find(sortKey, "currency_") then
			local currencyID = tonumber(string.match(sortKey, "currency_(%d+)"))
			if currencyID and charData.currencies and charData.currencies[currencyID] then
				charInfo.sortValue = charData.currencies[currencyID].quantity or 0
			else
				charInfo.sortValue = -1
			end
		else
			charInfo.sortValue = charData[sortKey] or 0
		end
    end
    
	table.sort(sortedChars, function(a, b)
		local aHasVault = a.charData.hasWeeklyRewards and 1 or 0
		local bHasVault = b.charData.hasWeeklyRewards and 1 or 0

		if DFCN_Status.db.sortBy == "name" and not DFCN_Status.db.ascending then
			if aHasVault ~= bHasVault then
				return aHasVault > bHasVault
			end
		end
		
		if a.sortValue ~= b.sortValue then
			if DFCN_Status.db.ascending then
				return a.sortValue < b.sortValue
			else
				return a.sortValue > b.sortValue
			end
		end
		
		return a.key < b.key
	end)
    
    local rowIndex = 1
    local rowY = -5

	local function ShowProfConcentrationTooltip(self, profData, lastUpdated)
		if not profData or not profData.hasConcentration then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(profData.name .. DFCNSL["CONCENTRATION_VALUE"], 1, 1, 1)
			GameTooltip:AddLine(DFCNSL["NO_CONCENTRATION_TIP"], 1, 0, 0)
			GameTooltip:Show()
			return
		end
		
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(profData.name .. DFCNSL["CONCENTRATION_VALUE"], 1, 1, 1)
		GameTooltip:AddLine(" ")
		
		local current = DFCN_Status:GetCurrentConcentration(profData, lastUpdated)
		local timeToMax = DFCNSL["CONCENTRATION_FULL"]
		local fullTimeText = ""

		if current < CONCENTRATION_MAX then
			local pointsNeeded = CONCENTRATION_MAX - current
			local secondsNeeded = pointsNeeded * CONCENTRATION_RECOVERY_RATE
			timeToMax = FormatTime(secondsNeeded)
			
			local fullTimestamp = GetPreciseTime() + secondsNeeded
			if locale == "zhCN" or locale == "zhTW" then
				fullTimeText = date("%m-%d %H:%M", fullTimestamp)
			else
				fullTimeText = date("%d/%m %H:%M", fullTimestamp)
			end
		else
			fullTimeText = DFCNSL["CONCENTRATION_FULL"]
		end
		
		local r, g, b = GetConcentrationColor(current).r, GetConcentrationColor(current).g, GetConcentrationColor(current).b
		GameTooltip:AddDoubleLine(DFCNSL["CURRENT_VALUE"], string.format("%.2f/%d", current, CONCENTRATION_MAX), 1, 1, 1, r, g, b)
		GameTooltip:AddDoubleLine(DFCNSL["TIME_TO_FULL"], timeToMax, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8)        
		GameTooltip:AddDoubleLine(DFCNSL["ESTIMATED_FULL_TIME"], fullTimeText, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8)
		
		GameTooltip:AddLine(" ")
		local lastUpdatedFormat
		if locale == "zhCN" or locale == "zhTW" then
			lastUpdatedFormat = date("%m-%d %H:%M", lastUpdated)
		else
			lastUpdatedFormat = date("%d/%m %H:%M", lastUpdated)
		end
		GameTooltip:AddLine(DFCNSL["LAST_LOGIN_TIME"] .. ": " .. lastUpdatedFormat, 0.6, 0.6, 0.6)
		GameTooltip:Show()
	end
    
    local currentLayout = DFCN_Status.db.viewMode == "delves" and DELVES_COLUMN_LAYOUT or CURRENCY_COLUMN_LAYOUT
    
    for _, charInfo in ipairs(sortedChars) do
        local charData = charInfo.charData
        if charData then
            local row = DFCN_Status.scrollChild.rows[rowIndex]
            if not row then
                row = CreateFrame("Frame", nil, DFCN_Status.scrollChild)
                row:SetSize(1370, 20)
                DFCN_Status.scrollChild.rows[rowIndex] = row

                row.BorderTop = row:CreateTexture(nil, "BORDER")
                row.BorderTop:SetPoint("TOPLEFT", row, "TOPLEFT", 0, 0)
                row.BorderTop:SetPoint("TOPRIGHT", row, "TOPRIGHT", 0, 0)
                row.BorderTop:SetHeight(1)
                row.BorderTop:SetColorTexture(0, 0, 0, 0)
                
                row.BorderBottom = row:CreateTexture(nil, "BORDER")
                row.BorderBottom:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0, 0)
                row.BorderBottom:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)
                row.BorderBottom:SetHeight(1)
                row.BorderBottom:SetColorTexture(0, 0, 0, 0)
                
				local prevCol
				for i, col in ipairs(currentLayout) do
					local colText = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
					colText:SetWidth(col.width)
					colText:SetJustifyH(col.align)
					
					if i == 1 then
						colText:SetPoint("LEFT", row, "LEFT", 0, 0)
					else
						colText:SetPoint("LEFT", prevCol, "RIGHT", 10, 0)
					end
					
					row["col"..i] = colText
					prevCol = colText
				end
                
                local deleteBtn = CreateFrame("Button", nil, row)
                deleteBtn:SetSize(20, 20)
                deleteBtn:SetPoint("CENTER", row["col"..#currentLayout], "CENTER", 0, 0)
                
                deleteBtn.text = deleteBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                deleteBtn.text:SetPoint("CENTER")
                deleteBtn.text:SetText("x")
                deleteBtn.text:SetTextColor(1, 0.3, 0.3)
                deleteBtn.text:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE")
                
                deleteBtn:SetScript("OnEnter", function(self)
                    self.text:SetTextColor(1, 0.1, 0.1)
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetText(DFCNSL["DELETE_CHAR_TOOLTIP"], 1, 0.1, 0.1)
                    GameTooltip:Show()
                end)
                
                deleteBtn:SetScript("OnLeave", function(self)
                    self.text:SetTextColor(1, 0.3, 0.3)
                    GameTooltip_Hide()
                end)
                
                row.deleteBtn = deleteBtn
            end

            row:SetPoint("TOPLEFT", DFCN_Status.scrollChild, "TOPLEFT", 5, rowY)
            row:Show()
            
            row.deleteBtn:SetScript("OnClick", function()
                StaticPopupDialogs["DFCN_DELETE_CHARACTER"] = {
                    text = string.format(DFCNSL["DELETE_CHAR_CONFIRM"], charInfo.key),
                    button1 = DFCNSL["DELETE"],
                    button2 = DFCNSL["CANCEL"],
                    OnAccept = function()
                        DFCN_Status.db.characters[charInfo.key] = nil
                        DFCN_Status:UpdateUI()
                        print("|T135994:14:14|t |cFFFF0000[" .. DFCNSL["DELETE"] .. "] " .. string.format(DFCNSL["CHARACTER_DELETED"], charInfo.key) .. "|r")
                    end,
                    timeout = 0,
                    whileDead = true,
                    hideOnEescape = true,
                    preferredIndex = 3,
                    showAlert = true
                }
                StaticPopup_Show("DFCN_DELETE_CHARACTER")
            end)
            
			for i = 1, #currentLayout do
				if row["col"..i] then
					row["col"..i]:SetTextColor(1, 1, 1)
				end
			end

            local enhancedColor = ENHANCED_CLASS_COLORS[charData.class] or {r=1, g=1, b=1}
            local currentCharKey = DFCN_Status:GetCharacterKey()

            if charInfo.key == currentCharKey then
                row.BorderTop:SetColorTexture(1, 0.8, 0, 0.5)
                row.BorderBottom:SetColorTexture(1, 0.8, 0, 0.5)
            else
                row.BorderTop:SetColorTexture(0, 0, 0, 0)
                row.BorderBottom:SetColorTexture(0, 0, 0, 0)
            end

            local displayCharKey = string.gsub(charInfo.key, "-", " - ")
			if charData.hasWeeklyRewards then
				displayCharKey = "|A:GreatVault-32x32:18:18|a"..displayCharKey
			end
			row.col1:SetText(displayCharKey)
			row.col1:SetTextColor(enhancedColor.r, enhancedColor.g, enhancedColor.b)

			if charData.hasWeeklyRewards then
				row.col1:SetScript("OnEnter", function(self)
					GameTooltip:SetOwner(self, "ANCHOR_TOP")
					GameTooltip:SetText("|cFFFF0000" .. DFCNSL["GREAT_VAULT_NOT_COLLECTED"] .. "|r", 1, 1, 1)
					GameTooltip:Show()
				end)
				row.col1:SetScript("OnLeave", GameTooltip_Hide)
			end
            
            if DFCN_Status.db.viewMode == "delves" then
                local prof1Current, hasConcentration1 = DFCN_Status:GetCurrentConcentration(charData.concentration.prof1, charData.concentration.lastUpdated)
                local prof1Name = charData.concentration.prof1.name
                local prof1Text = ""
                if prof1Name == DFCNSL["NO_PROFESSION"] then
                    prof1Text = DFCNSL["NOT_LEARNED"]
                    row.col2:SetText(prof1Text)
                    row.col2:SetTextColor(COLORS.TEXT_GRAY.r, COLORS.TEXT_GRAY.g, COLORS.TEXT_GRAY.b) 
                elseif hasConcentration1 then
                    local displayValue = math.floor(prof1Current + 0.5)
                    prof1Text = string.format("%s (%d)", ShortenProfName(prof1Name), displayValue)
                    row.col2:SetText(prof1Text)
                    local color = GetConcentrationColor(prof1Current)
					row.col2:SetTextColor(color.r, color.g, color.b)
                else
                    prof1Text = ShortenProfName(prof1Name)
                    row.col2:SetText(prof1Text)
                    row.col2:SetTextColor(0.25, 1, 0.25)
                end
                
                local prof2Current, hasConcentration2 = DFCN_Status:GetCurrentConcentration(charData.concentration.prof2, charData.concentration.lastUpdated)
                local prof2Name = charData.concentration.prof2.name
                local prof2Text = ""
                if prof2Name == DFCNSL["NO_PROFESSION"] then
                    prof2Text = DFCNSL["NOT_LEARNED"]
                    row.col3:SetText(prof2Text)
                    row.col3:SetTextColor(COLORS.TEXT_GRAY.r, COLORS.TEXT_GRAY.g, COLORS.TEXT_GRAY.b) 
                elseif hasConcentration2 then
                    local displayValue = math.floor(prof2Current + 0.5)
                    prof2Text = string.format("%s (%d)", ShortenProfName(prof2Name), displayValue)
                    row.col3:SetText(prof2Text)
                    local color = GetConcentrationColor(prof2Current)
                    row.col3:SetTextColor(color.r, color.g, color.b)
                else
                    prof2Text = ShortenProfName(prof2Name)
                    row.col3:SetText(prof2Text)
                    row.col3:SetTextColor(0.25, 1, 0.25)
                end
                
                local keyStatus = charData.keyStatus or {totalKeys = 0, completedQuests = 0}
                local keyText = string.format("%d | %d/4", keyStatus.totalKeys, keyStatus.completedQuests)
                row.col4:SetText(keyText)
                
                if keyStatus.completedQuests == 4 then
                    row.col4:SetTextColor(COLORS.TEXT_GREEN.r, COLORS.TEXT_GREEN.g, COLORS.TEXT_GREEN.b)
                elseif keyStatus.completedQuests >= 2 then
                    row.col4:SetTextColor(COLORS.TEXT_YELLOW.r, COLORS.TEXT_YELLOW.g, COLORS.TEXT_YELLOW.b)
                elseif keyStatus.completedQuests >= 1 then
                    row.col4:SetTextColor(1, 0.65, 0)
                else
                    row.col4:SetTextColor(COLORS.TEXT_RED.r, COLORS.TEXT_RED.g, COLORS.TEXT_RED.b)
                end

                local shardStatus = charData.shardStatus or {totalShards = 0, shardsFromBoxes = 0}
                local shardText = string.format("%d | %d/200", shardStatus.totalShards, shardStatus.shardsFromBoxes)
                row.col5:SetText(shardText)
                
                if shardStatus.shardsFromBoxes == 200 then
                    row.col5:SetTextColor(COLORS.TEXT_GREEN.r, COLORS.TEXT_GREEN.g, COLORS.TEXT_GREEN.b)
                elseif shardStatus.shardsFromBoxes >= 150 then
                    row.col5:SetTextColor(COLORS.TEXT_YELLOW.r, COLORS.TEXT_YELLOW.g, COLORS.TEXT_YELLOW.b)
                elseif shardStatus.shardsFromBoxes >= 100 then
                    row.col5:SetTextColor(1, 0.65, 0) 
                else
                    row.col5:SetTextColor(COLORS.TEXT_RED.r, COLORS.TEXT_RED.g, COLORS.TEXT_RED.b)
                end

                row.col6:SetText(charData.delveCount or 0)
                local delveCount = charData.delveCount or 0
				if delveCount >= 8 then
					row.col6:SetTextColor(COLORS.TEXT_GREEN.r, COLORS.TEXT_GREEN.g, COLORS.TEXT_GREEN.b)
				elseif delveCount >= 4 then
					row.col6:SetTextColor(1, 1, 0)
				elseif delveCount >= 2 then
					row.col6:SetTextColor(1, 0.65, 0)
				else
					row.col6:SetTextColor(COLORS.TEXT_RED.r, COLORS.TEXT_RED.g, COLORS.TEXT_RED.b)
				end

                row.col7:SetText(charData.treasureStatus)
                if charData.treasureStatus == DFCNSL["IN_BAG"] then
                    row.col7:SetTextColor(COLORS.TEXT_HIGHLIGHT.r, COLORS.TEXT_HIGHLIGHT.g, COLORS.TEXT_HIGHLIGHT.b)
                elseif charData.treasureStatus == DFCNSL["USED"] then
                    row.col7:SetTextColor(COLORS.TEXT_GREEN.r, COLORS.TEXT_GREEN.g, COLORS.TEXT_GREEN.b)
                else
                    row.col7:SetTextColor(COLORS.TEXT_RED.r, COLORS.TEXT_RED.g, COLORS.TEXT_RED.b)
                end

                row.col8:SetText(charData.goldenCacheStatus)
                if charData.goldenCacheStatus == "3/3" then
                    row.col8:SetTextColor(COLORS.TEXT_GREEN.r, COLORS.TEXT_GREEN.g, COLORS.TEXT_GREEN.b)
                elseif charData.goldenCacheStatus == "2/3" then
                    row.col8:SetTextColor(COLORS.TEXT_YELLOW.r, COLORS.TEXT_YELLOW.g, COLORS.TEXT_YELLOW.b)
                elseif charData.goldenCacheStatus == "1/3" then
                    row.col8:SetTextColor(1, 0.65, 0)
                else
                    row.col8:SetTextColor(COLORS.TEXT_RED.r, COLORS.TEXT_RED.g, COLORS.TEXT_RED.b)
                end

				local manaCrystalData = charData.currencies and charData.currencies[3356]
				local manaCrystalQuantity = manaCrystalData and manaCrystalData.quantity or nil

				if manaCrystalQuantity == nil then
					row.col9:SetText("n/a")
					row.col9:SetTextColor(COLORS.TEXT_GRAY.r, COLORS.TEXT_GRAY.g, COLORS.TEXT_GRAY.b)
				else
					row.col9:SetText(manaCrystalQuantity)
					
					if manaCrystalQuantity >= 100 then
						row.col9:SetTextColor(COLORS.TEXT_GREEN.r, COLORS.TEXT_GREEN.g, COLORS.TEXT_GREEN.b)
					else
						row.col9:SetTextColor(COLORS.TEXT_RED.r, COLORS.TEXT_RED.g, COLORS.TEXT_RED.b)
					end
				end

				row.col9:SetScript("OnEnter", function(self)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
					GameTooltip:SetText(DFCNSL["CURRENCY_MANA_CRYSTAL"], 1, 1, 1)
					GameTooltip:AddLine(" ")
					
					if manaCrystalQuantity == nil then
						GameTooltip:AddLine(DFCNSL["CURRENCY_TOOLTIP_UNKNOWN"], 1, 0, 0)
						GameTooltip:AddLine(DFCNSL["CURRENCY_TOOLTIP_LOGIN"], 0.8, 0.8, 0.8)
					else
						GameTooltip:AddDoubleLine(DFCNSL["QUANTITY_HELD"], tostring(manaCrystalQuantity), 1, 1, 1, 1, 1, 1)
						
						local currentCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo(3356)
						if currentCurrencyInfo and currentCurrencyInfo.maxWeeklyQuantity and currentCurrencyInfo.maxWeeklyQuantity > 0 then
							GameTooltip:AddDoubleLine(DFCNSL["WEEKLY_CAP"], tostring(currentCurrencyInfo.maxWeeklyQuantity), 1, 1, 1, 1, 1, 1)
							if manaCrystalQuantity >= currentCurrencyInfo.maxWeeklyQuantity then
								GameTooltip:AddLine(DFCNSL["REACHED_WEEKLY_CAP"], 1, 0, 0)
							else
								local needed = currentCurrencyInfo.maxWeeklyQuantity - manaCrystalQuantity
								GameTooltip:AddLine(string.format(DFCNSL["NEED_MORE_WEEKLY"], needed), 0, 1, 0)
							end
						elseif currentCurrencyInfo and currentCurrencyInfo.maxQuantity and currentCurrencyInfo.maxQuantity > 0 then
							GameTooltip:AddDoubleLine(DFCNSL["SEASON_CAP"], tostring(currentCurrencyInfo.maxQuantity), 1, 1, 1, 1, 1, 1)
							if manaCrystalQuantity >= currentCurrencyInfo.maxQuantity then
								GameTooltip:AddLine(DFCNSL["REACHED_CAP"], 1, 0, 0)
							else
								local needed = currentCurrencyInfo.maxQuantity - manaCrystalQuantity
								GameTooltip:AddLine(string.format(DFCNSL["NEED_MORE"], needed), 0, 1, 0)
							end
						end
					end
					GameTooltip:Show()
				end)

				row.col9:SetScript("OnLeave", GameTooltip_Hide)
                
                row.col10:SetText(string.format("%.2f", charData.overallItemLevel))
                row.col10:SetTextColor(COLORS.TEXT_PURPLE.r, COLORS.TEXT_PURPLE.g, COLORS.TEXT_PURPLE.b)
                
                row.col2:SetScript("OnEnter", function(self)
                    ShowProfConcentrationTooltip(self, charData.concentration.prof1, charData.concentration.lastUpdated)
                end)
                
                row.col3:SetScript("OnEnter", function(self)
                    ShowProfConcentrationTooltip(self, charData.concentration.prof2, charData.concentration.lastUpdated)
                end)
                
                row.col2:SetScript("OnLeave", GameTooltip_Hide)
                row.col3:SetScript("OnLeave", GameTooltip_Hide)
            else
				for i = 2, #CURRENCY_COLUMN_LAYOUT - 1 do
					local col = CURRENCY_COLUMN_LAYOUT[i]
					if col.currencyID then
						local currencyData = charData.currencies and charData.currencies[col.currencyID]
						local quantity = currencyData and currencyData.quantity or 0
						local totalEarned = currencyData and currencyData.totalEarned or 0
						local currencyText = currencyData and tostring(quantity) or DFCNSL["UNKNOWN"]
						local textColor = COLORS.TEXT_GREEN
						
						local currentCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo(col.currencyID)
						if currentCurrencyInfo and currentCurrencyInfo.maxQuantity and currentCurrencyInfo.maxQuantity > 0 then
							if col.currencyID == 3008 or col.currencyID == 3141 then
								if quantity >= currentCurrencyInfo.maxQuantity then
									textColor = COLORS.TEXT_RED
								end
							else
								if totalEarned >= currentCurrencyInfo.maxQuantity then
									textColor = COLORS.TEXT_RED
								end
							end
						end
						
						row["col"..i]:SetText(currencyText)
						row["col"..i]:SetTextColor(textColor.r, textColor.g, textColor.b)
						
						row["col"..i]:SetScript("OnEnter", function(self)
							GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
							local currentCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo(col.currencyID)
							if currencyData then
								GameTooltip:SetText(CURRENCY_NAMES[col.currencyID] or currentCurrencyInfo.name, 1, 1, 1)
								GameTooltip:AddLine(" ")
								GameTooltip:AddDoubleLine(DFCNSL["QUANTITY_HELD"], tostring(quantity), 1, 1, 1, 1, 1, 1)

								if col.currencyID == 3269 then
									if currentCurrencyInfo.maxQuantity and currentCurrencyInfo.maxQuantity > 0 then
										GameTooltip:AddDoubleLine(DFCNSL["SEASON_CAP"], tostring(currentCurrencyInfo.maxQuantity), 1, 1, 1, 1, 1, 1)
										if quantity >= currentCurrencyInfo.maxQuantity then
											GameTooltip:AddLine(DFCNSL["REACHED_CAP"], 1, 0, 0)
										else
											local needed = currentCurrencyInfo.maxQuantity - quantity
											GameTooltip:AddLine(string.format(DFCNSL["NEED_MORE"], needed), 0, 1, 0)
										end
									end
								elseif col.currencyID == 3008 then
									if currentCurrencyInfo.maxQuantity and currentCurrencyInfo.maxQuantity > 0 then
										GameTooltip:AddDoubleLine(DFCNSL["HOLDING_CAP"], tostring(currentCurrencyInfo.maxQuantity), 1, 1, 1, 1, 1, 1)
										if quantity >= currentCurrencyInfo.maxQuantity then
											GameTooltip:AddLine(DFCNSL["REACHED_CAP"], 1, 0, 0)
										else
											local needed = currentCurrencyInfo.maxQuantity - quantity
											GameTooltip:AddLine(string.format(DFCNSL["HOLD_MORE"], needed), 0, 1, 0)
										end
									end
								else
									local specialCurrencies = {[2803] = true, [1166] = true}

									if not specialCurrencies[col.currencyID] then
										GameTooltip:AddDoubleLine(DFCNSL["SEASON_EARNED"], tostring(totalEarned), 1, 1, 1, 1, 1, 1)
									
									if currentCurrencyInfo.maxQuantity and currentCurrencyInfo.maxQuantity > 0 and 
									   not specialCurrencies[col.currencyID] then
										GameTooltip:AddDoubleLine(DFCNSL["SEASON_CAP"], tostring(currentCurrencyInfo.maxQuantity), 1, 1, 1, 1, 1, 1)
									end

										if currentCurrencyInfo.maxQuantity and currentCurrencyInfo.maxQuantity > 0 then
											if totalEarned >= currentCurrencyInfo.maxQuantity then
												GameTooltip:AddLine(DFCNSL["REACHED_CAP"], 1, 0, 0)
											else
												GameTooltip:AddLine(string.format(DFCNSL["NEED_MORE"], 
													currentCurrencyInfo.maxQuantity - totalEarned), 0, 1, 0)
											end
										end
									end
								end
							else
							GameTooltip:SetText(CURRENCY_NAMES[col.currencyID] or DFCNSL["CURRENCY"], 1, 1, 1)
							GameTooltip:AddLine(" ")
							GameTooltip:AddLine(DFCNSL["CURRENCY_TOOLTIP_UNKNOWN"], 1, 0, 0)
							GameTooltip:AddLine(DFCNSL["CURRENCY_TOOLTIP_LOGIN"], 0.8, 0.8, 0.8)
							end
							GameTooltip:Show()
						end)
						
						row["col"..i]:SetScript("OnLeave", GameTooltip_Hide)
					end
				end
            end
            
            rowIndex = rowIndex + 1
            rowY = rowY - 20
        end
    end
    
    local totalHeight = 20 * (#sortedChars)
    local visibleHeight = 280
    
    DFCN_Status.scrollChild:SetHeight(totalHeight)
    
    local maxScroll = math.max(0, totalHeight - visibleHeight)
    DFCN_Status.scrollBar:SetMinMaxValues(0, maxScroll)
    
    if maxScroll > 0 then
        DFCN_Status.scrollBar:Show()
        DFCN_Status.scrollBar:SetValue(0)
        
        DFCN_Status.scrollBar.ScrollUpButton:Enable()
        DFCN_Status.scrollBar.ScrollDownButton:Enable()
    else
        DFCN_Status.scrollBar:Hide()
    end
    
    if DFCN_Status.uiFrame and DFCN_Status.uiFrame.tipText then
        local charKey = self:GetCharacterKey()
        local charData = DFCN_Status.db.characters[charKey]
        local lastUpdate = charData and charData.lastUpdated or 0

		local region = GetCurrentRegion()
		local regionText = ""
		if region == 1 then
			regionText = DFCNSL["REGION_US"]
		elseif region == 2 then
			regionText = DFCNSL["REGION_KR"]
		elseif region == 3 then
			regionText = DFCNSL["REGION_EU"]
		elseif region == 4 then
			regionText = DFCNSL["REGION_TW"]
		elseif region == 5 then
			regionText = DFCNSL["REGION_CN"]
		else
			regionText = DFCNSL["REGION_PTR"]
		end
        
		local resetWeekday = GetResetWeekday()
		local resetDayText = ""
		if resetWeekday == 1 then
			resetDayText = DFCNSL["SUNDAY"]
		elseif resetWeekday == 2 then
			resetDayText = DFCNSL["MONDAY"]
		elseif resetWeekday == 3 then
			resetDayText = DFCNSL["TUESDAY"]
		elseif resetWeekday == 4 then
			resetDayText = DFCNSL["WEDNESDAY"]
		elseif resetWeekday == 5 then
			resetDayText = DFCNSL["THURSDAY"]
		elseif resetWeekday == 6 then
			resetDayText = DFCNSL["FRIDAY"]
		elseif resetWeekday == 7 then
			resetDayText = DFCNSL["SATURDAY"]
		else
			resetDayText = DFCNSL["UNKNOWN"]
		end
        
        local playerLevel = UnitLevel("player")
        if playerLevel >= 68 then
            if time() - lastUpdate < 60 then
                DFCN_Status.uiFrame.tipText:SetText(string.format(DFCNSL["CHARACTER_LEVEL_68_PLUS"] .. " |cFFFFFF00%s|r |cFF808080" .. DFCNSL["CURRENT_REGION_FORMAT"] .. "_" .. DFCN_Status.VERSION .. "|r", DFCNSL["DATA_AUTO_UPDATED"], regionText, resetDayText))
                DFCN_Status.uiFrame.tipText:SetTextColor(0, 1, 0)
            else
                DFCN_Status.uiFrame.tipText:SetText(string.format(DFCNSL["CHARACTER_LEVEL_68_PLUS"] .. " |cFFFF9900%s|r |cFF808080" .. DFCNSL["CURRENT_REGION_FORMAT"] .. "_" .. DFCN_Status.VERSION .. "|r", DFCNSL["DATA_MAY_BE_OUTDATED"], regionText, resetDayText))
                DFCN_Status.uiFrame.tipText:SetTextColor(1, 0.65, 0)
            end
        else
            DFCN_Status.uiFrame.tipText:SetText(string.format(DFCNSL["CHARACTER_LEVEL_BELOW_68"] .. " |cFFFF0000%s|r |cFF808080" .. DFCNSL["CURRENT_REGION_FORMAT"] .. "_" .. DFCN_Status.VERSION .. "|r", DFCNSL["VIEW_ONLY_SUPPORT"], regionText, resetDayText))
            DFCN_Status.uiFrame.tipText:SetTextColor(1, 0.5, 0)
        end
    end
    
    for i = rowIndex, #DFCN_Status.scrollChild.rows do
        if DFCN_Status.scrollChild.rows[i] then
            DFCN_Status.scrollChild.rows[i]:Hide()
            DFCN_Status.scrollChild.rows[i].deleteBtn:SetScript("OnClick", nil)
        end
    end
	self:ApplyFontSettings()
end

function DFCN_Status:ShowUI()
    local playerLevel = UnitLevel("player")
    isUpdateLevel = (playerLevel >= 68)
    
    if isUpdateLevel then
        self:UpdateCharacterData()
    end
    
    self:CreateUI()
    self:UpdateUI()
    DFCN_Status.uiFrame:Show()
end

function DFCN_Status:SaveAllCharacters()
    self:UpdateCharacterData(true)    
    for charKey, charData in pairs(DFCN_Status.db.characters) do
        if charData.concentration then
            if charKey == self:GetCharacterKey() then
                charData.concentration.lastUpdated = GetPreciseTime()
            end
        end
    end    
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_LOGOUT")
frame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
frame:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("WEEKLY_REWARDS_UPDATE")
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" and ... == "OrzUI" then
        --print("|T135994:14:14|t |cFF00BFFF[" .. DFCNSL["INFO"] .. "]|r|cFF00FF00 " .. DFCNSL["MULTI_CHAR_MANAGER"] .. " |cFFFFA500By|r|c000EEEEE DFCN|r |c000EEE00" .. DFCNSL["ADDON_LOADED"] .. "|r")
        if not DFCN_StatusDB then
            DFCN_StatusDB = {
                characters = {},
                version = dbVersion,
                sortBy = "overallItemLevel",
                ascending = false,
                viewMode = "delves",
				fontOffset = 0
            }
            --print("|T135994:14:14|t |cFF00BFFF[" .. DFCNSL["INFO"] .. "] " .. string.format(DFCNSL["DATABASE_CREATED"], dbVersion) .. "|r")
        else
			DFCN_StatusDB.fontOffset = DFCN_StatusDB.fontOffset or 0
            local oldVersion = DFCN_StatusDB.version or 1
            if oldVersion < dbVersion then 
                local savedCharacters = DFCN_StatusDB.characters
                local characterCount = 0                
                if savedCharacters then
                    for _ in pairs(savedCharacters) do
                        characterCount = characterCount + 1
                    end
                end
                for charKey, charData in pairs(savedCharacters) do
                    if not charData.currencies then
                        charData.currencies = {}
                    end                    
                    if not charData.keyStatus then
                        charData.keyStatus = {
                            totalKeys = 0,
                            completedQuests = 0
                        }
                    end
                    if not charData.shardStatus then
                        charData.shardStatus = {
                            totalShards = 0,
                            shardsFromBoxes = 0
                        }
                    end
                    if not charData.concentration then
                        charData.concentration = {
                            lastUpdated = GetPreciseTime(),
                            prof1 = {value = 0.0, name = DFCNSL["NO_PROFESSION"], hasConcentration = false},
                            prof2 = {value = 0.0, name = DFCNSL["NO_PROFESSION"], hasConcentration = false}
                        }
                    end
                    if charData.concentration and type(charData.concentration.prof1.value) == "number" then
                        charData.concentration.prof1.value = charData.concentration.prof1.value + 0.0
                        charData.concentration.prof2.value = charData.concentration.prof2.value + 0.0
                    end
                end
                DFCN_StatusDB.version = dbVersion
                --print(string.format("|T135994:14:14|t |cFF00BFFF[" .. DFCNSL["UPGRADE"] .. "]|r " .. DFCNSL["DATABASE_UPGRADED"], oldVersion, dbVersion, characterCount))
            end
            DFCN_StatusDB.sortBy = DFCN_StatusDB.sortBy or "overallItemLevel"
            DFCN_StatusDB.ascending = (DFCN_StatusDB.ascending == nil) and false or DFCN_StatusDB.ascending
            DFCN_StatusDB.viewMode = DFCN_StatusDB.viewMode or "delves"
            
            for _, charData in pairs(DFCN_StatusDB.characters or {}) do
                if not charData.keyStatus then
                    charData.keyStatus = {
                        totalKeys = 0,
                        completedQuests = 0
                    }
                end
                if not charData.shardStatus then
                    charData.shardStatus = {
                        totalShards = 0,
                        shardsFromBoxes = 0
                    }
                end
                if not charData.concentration then
                    charData.concentration = {
                        lastUpdated = GetPreciseTime(),
                        prof1 = {value = 0.0, name = DFCNSL["NO_PROFESSION"], hasConcentration = false},
                        prof2 = {value = 0.0, name = DFCNSL["NO_PROFESSION"], hasConcentration = false}
                    }
                end
                if not charData.currencies then
                    charData.currencies = {}
                end
            end
        end
        
        DFCN_Status.db = DFCN_StatusDB
        DFCN_Status:CheckAllCharactersReset()        
        DFCN_Status:CreateMiniMapButton()
		DFCN_Status:CreateOptionsPanel()
    elseif event == "PLAYER_LOGIN" then
        local serverTime = GetServerTime()
        local localTime = time()
        DFCN_Status.serverTimeOffset = serverTime - localTime
        
        local playerLevel = UnitLevel("player")
        isUpdateLevel = (playerLevel >= 68)
        
        DFCN_Status.concentrationTracker = {
            values = {},
            lastUpdated = GetPreciseTime()
        }
        
        if isUpdateLevel then
            C_Timer.After(5, function()
                DFCN_Status:UpdateCharacterData()
            end)
            
            DFCN_Status.updateTicker = C_Timer.NewTicker(60, function()
                DFCN_Status:UpdateCharacterData(true)
            end)

			DFCN_Status.saveTicker = C_Timer.NewTicker(65, function()
				DFCN_Status:SaveAllCharacters()
			end)
        end
    elseif event == "PLAYER_EQUIPMENT_CHANGED" and isUpdateLevel then
        C_Timer.After(2, function()
            DFCN_Status:UpdateCharacterData()
            if DFCN_Status.uiFrame and DFCN_Status.uiFrame:IsVisible() then
                DFCN_Status:UpdateUI()
            end
        end)   
    elseif event == "PLAYER_LOGOUT" then
        DFCN_Status:SaveOnLogout()
	elseif event == "WEEKLY_REWARDS_UPDATE" then
		if isUpdateLevel then
			C_Timer.After(0.5, function()
				DFCN_Status:UpdateCharacterData()
			end)
		end
    elseif event == "ZONE_CHANGED_NEW_AREA" then
        if isUpdateLevel then
            C_Timer.After(1, function()
                DFCN_Status:UpdateCharacterData()
            end)
        end
    elseif event == "CURRENCY_DISPLAY_UPDATE" then
        local currencyID = ...
        if tContains(CURRENCY_IDS, currencyID) then
            local now = GetTime()
            if now - lastCurrencyUpdate > CURRENCY_UPDATE_DELAY then
                lastCurrencyUpdate = now
                if isUpdateLevel then
                    C_Timer.After(0.5, function()
                        DFCN_Status:UpdateCharacterData()
                        if DFCN_Status.uiFrame and DFCN_Status.uiFrame:IsVisible() then
                            DFCN_Status:UpdateUI()
                        end
                    end)
                end
            end
        end
    end
end)

SLASH_CHARACTERSTATUS1 = "/dfcnchar"
SlashCmdList["CHARACTERSTATUS"] = function(msg)
    local command = strlower(msg or "")
    
    if command == "" then
        if DFCN_Status.uiFrame and DFCN_Status.uiFrame:IsVisible() then
            DFCN_Status.uiFrame:Hide()
        else
            DFCN_Status:ShowUI()
        end
    elseif command == "minimap on" then
        DFCN_Status.db.minimap.hide = false
        local LibDBIcon = LibStub and LibStub:GetLibrary("LibDBIcon-1.0", true)
        if LibDBIcon then
            LibDBIcon:Show("DFCN_CharacterStatus")
        end
        print("|T135994:14:14|t |cFF00BFFF[" .. DFCNSL["INFO"] .. "] " .. DFCNSL["MINIMAP_SHOWN"] .. "|r")
    elseif command == "minimap off" then
        DFCN_Status.db.minimap.hide = true
        local LibDBIcon = LibStub and LibStub:GetLibrary("LibDBIcon-1.0", true)
        if LibDBIcon then
            LibDBIcon:Hide("DFCN_CharacterStatus")
        end
        print("|T135994:14:14|t |cFF00BFFF[" .. DFCNSL["INFO"] .. "] " .. DFCNSL["MINIMAP_HIDDEN"] .. "|r")
    else
        print(DFCNSL["COMMAND_OPEN_CLOSE"])
        print(DFCNSL["COMMAND_MINIMAP_ON"])
        print(DFCNSL["COMMAND_MINIMAP_OFF"])
    end
end

function DFCN_Status:CreateOptionsPanel()
    if not DFCN_Status.db.minimap then
        DFCN_Status.db.minimap = {
            hide = false,
            position = nil
        }
    end
    
    local panel = CreateFrame("Frame")
    panel.name = DFCNSL["MULTI_CHAR_MANAGER"].."|T135994:14:14|t" 
    
    local title = panel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
	title:SetFont(GameFontNormal:GetFont(), 16)
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("|T135994:18:18|t " .. DFCNSL["MULTI_CHAR_MANAGER"] .. " |cFFFFA500DFCN|r")

    local minimapCheckbox = CreateFrame("CheckButton", nil, panel, "UICheckButtonTemplate")
    minimapCheckbox:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -30)   
    minimapCheckbox:SetScript("OnClick", function(self)
        DFCN_Status.db.minimap.hide = not self:GetChecked()
        local LibDBIcon = LibStub and LibStub:GetLibrary("LibDBIcon-1.0", true)
        if LibDBIcon then
            if self:GetChecked() then
                LibDBIcon:Show("DFCN_CharacterStatus")
                print("|T135994:14:14|t |cFF00BFFF[" .. DFCNSL["INFO"] .. "] " .. DFCNSL["MINIMAP_SHOWN"] .. "|r")
            else
                LibDBIcon:Hide("DFCN_CharacterStatus")
                print("|T135994:14:14|t |cFF00BFFF[" .. DFCNSL["INFO"] .. "] " .. DFCNSL["MINIMAP_HIDDEN"] .. "|r")
            end
        end
    end)
    
    minimapCheckbox.text = minimapCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    minimapCheckbox.text:SetPoint("LEFT", minimapCheckbox, "RIGHT", 5, 0)
	minimapCheckbox.text:SetFont(GameFontNormal:GetFont(), 16)
    minimapCheckbox.text:SetText(DFCNSL["SHOW_MINIMAP_ICON"])
    
    local togglePanelBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    togglePanelBtn:SetPoint("TOPLEFT", minimapCheckbox, "BOTTOMLEFT", 0, -20)
    togglePanelBtn:SetSize(200, 40)

    local function UpdateButtonText()
        if DFCN_Status.uiFrame and DFCN_Status.uiFrame:IsShown() then
            togglePanelBtn:SetText(DFCNSL["CLOSE_PANEL"])
        else
            togglePanelBtn:SetText(DFCNSL["OPEN_PANEL"])
        end
    end

    UpdateButtonText()
    
    togglePanelBtn:SetScript("OnClick", function()
        if DFCN_Status.uiFrame and DFCN_Status.uiFrame:IsShown() then
            DFCN_Status.uiFrame:Hide()
        else
            DFCN_Status:ShowUI()
        end
        UpdateButtonText()
    end)
    
    local function RefreshPanel()
        UpdateButtonText()
        minimapCheckbox:SetChecked(not DFCN_Status.db.minimap.hide)
    end
    
    panel:SetScript("OnShow", RefreshPanel)
    
	C_Timer.After(0, function()
		if panel:IsVisible() then
			RefreshPanel()
		end
	end)
    
    local commandTip = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    commandTip:SetPoint("TOPLEFT", togglePanelBtn, "BOTTOMLEFT", 0, -10)
    commandTip:SetText(DFCNSL["MACRO_COMMAND"])
    commandTip:SetTextColor(0.8, 0.8, 0.8)
    
    local downloadLabel = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    downloadLabel:SetPoint("TOPLEFT", commandTip, "BOTTOMLEFT", 0, -20)
    downloadLabel:SetText(DFCNSL["ORIGINAL_DOWNLOAD"])
    downloadLabel:SetTextColor(1, 1, 1)
    
    local downloadEditBox = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
    downloadEditBox:SetPoint("TOPLEFT", downloadLabel, "BOTTOMLEFT", 0, -5)
    downloadEditBox:SetSize(300, 20)
    downloadEditBox:SetAutoFocus(false)
    downloadEditBox:SetText("https://bbs.nga.cn/read.php?tid=44921579")
    downloadEditBox:SetCursorPosition(0)
    
    local copyTip = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    copyTip:SetPoint("TOPLEFT", downloadEditBox, "BOTTOMLEFT", 0, -5)
    copyTip:SetText(DFCNSL["CLICK_TO_COPY"])
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