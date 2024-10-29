--------------------------------------------------------------------------------------------------------------------------------------------
-- INIT
--------------------------------------------------------------------------------------------------------------------------------------------
local NS = select( 2, ... );
--------------------------------------------------------------------------------------------------------------------------------------------
NS.localization = setmetatable( {}, { __index = function( self, key )
	self[key] = key; -- Use original phrase for undefined keys
	return key;
end } );
--
local L = NS.localization;
-- enUS, enGB
if GetLocale() == "enUS" or GetLocale() == "enGB" then
-- deDE
elseif GetLocale() == "deDE" then
-- esES
elseif GetLocale() == "esES" then
-- frFR
elseif GetLocale() == "frFR" then
-- itIT
elseif GetLocale() == "itIT" then
-- koKR
elseif GetLocale() == "koKR" then
-- ptBR
elseif GetLocale() == "ptBR" then
-- ruRU
elseif GetLocale() == "ruRU" then
-- zhCN
elseif GetLocale() == "zhCN" then
L["%d : Missing crafting profession spell."] = "%d : 缺少制作专业法术。"
L["%d : Missing riding spell."] = "%d : 缺少骑乘法术。"
L["Select an auction to buy or click \"Buy All\""] = "选择一个拍卖进行购买或点击 \"购买全部\""
L["%sEach result is the lowest buyout auction for an|r %s"] = "%s每个结果是一个|r %s的最低一口价拍卖"
L["Appearance"] = "外观"
L["Appearance Source"] = "外观来源"
L["Remember when leaving %s to equip or use auctions won to update your Collections for future Shop results."] = "离开%s时请记得装备或使用赢得的拍卖，以更新您的收藏以便未来商店结果。"
L["Max Item Price: %s"] = "最大物品价格: %s"
L["None"] = "无"
L["Ready"] = "准备好"
L["Auction House data required"] = "需要拍卖行数据"
L["Press \"Scan\" to perform a GetAll scan"] = "按下 \"扫描\" 进行全局扫描"
L["Press \"Shop\""] = "按下 \"商店\""
L["Choose Collection Mode"] = "选择收藏模式"
L["Not Collected"] = "未收集"
L["Collected"] = "已收集"
L["Requires Level"] = "需要等级"
L["Requires Profession"] = "需要职业"
L["Crafted by a Profession"] = "由某职业制作"
L["Requires Riding Skill"] = "需要骑乘技能"
L["Include"] = "包含"
L["Collected (1-2/3)"] = "已收集 (1-2/3)"
L["Collected (3/3)"] = "已收集 (3/3)"
L["Level 1-10"] = "等级 1-10"
L["Level 11-15"] = "等级 11-15"
L["Level 16-20"] = "等级 16-20"
L["Level 21-24"] = "等级 21-24"
L["Level 25"] = "等级 25"
L["Group By Species"] = "按物种分组"
L["Collected - Unknown Sources"] = "已收集 - 未知来源"
L["Collected - Known Sources"] = "已收集 - 已知来源"
L["Level 1-25"] = "等级 1-25"
L["Level 25-27"] = "等级 25-27"
L["Level 27-30"] = "等级 27-30"
L["Level 30-32"] = "等级 30-32"
L["Level 32-35"] = "等级 32-35"
L["Level 35-40"] = "等级 35-40"
L["Level 40-45"] = "等级 40-45"
L["Level 45-50"] = "等级 45-50"
L["Level 50-60"] = "等级 50-60"
L["Level 60-70"] = "等级 60-70"
L["Level 70-80"] = "等级 70-80"
L["Non-set Items"] = "非套装物品"
L["Requires Profession Specialization"] = "需要职业专精"
L["Requires Profession Level"] = "需要职业等级"
L["Toggle Pet Families"] = "切换宠物种类"
L["Toggle Categories"] = "切换类别"
L["Live"] = "实时"
L["Never"] = "从不"
L["Time since last scan: %s"] = "上次扫描时间: %s"
L["Appearance Sources"] = "外观来源"
L["Buyout"] = "一口价"
L["Buyouts"] = "一口价"
L["Selection ignored, buying"] = "选择被忽略，正在购买"
L["Selection ignored, scanning"] = "选择被忽略，正在扫描"
L["No additional auctions matched your settings"] = "没有其他拍卖符合您的设置"
L["Selecting %s for %s, same %s."] = "选择%s用于%s，价格相同%s。"
L["Selecting %s for %s, next cheapest."] = "选择%s用于%s，下一个最便宜的。"
L["source"] = "来源"
L["Filter failed at %s for %s"] = "在%s处过滤失败，原因%s"
L["Scanning Auction House"] = "正在扫描拍卖行"
L["Request sent, waiting on auction data... This can take a minute, please wait..."] = "请求已发送，等待拍卖数据... 这可能需要一分钟，请稍候..."
L["Abort"] = "中止"
L["Shopping"] = "购物"
L["You must check at least one rarity filter"] = "您必须至少选择一个稀有度过滤器"
L["You must have a primary profession or Cooking"] = "您必须拥有一个主职业或烹饪"
L["You must check at least one %s filter"] = "您必须至少选择一个%s过滤器"
L["Pet Family"] = "宠物种类"
L["Auction Category"] = "拍卖类别"
L["Appearance Category"] = "外观类别"
L["Recipe Category"] = "配方类别"
L["You must check at least one Collected filter"] = "您必须至少选择一个已收集过滤器"
L["You must check at least one Level filter"] = "您必须至少选择一个等级过滤器"
L["Could not query Auction House after several attempts. Please try again later."] = "经过多次尝试后无法查询拍卖行。请稍后再试。"
L["Blizzard allows a GetAll scan once per 20 minutes or per game client launch. Please try again later."] = "暴雪允许每20分钟或每次游戏客户端启动进行一次GetAll扫描。请稍后再试。"
L["Scanning %s: No matches"] = "扫描%s: 没有匹配项"
L["Scanning %s: %d results so far..."] = "扫描%s: 到目前为止%d个结果..."
L["%s remaining auctions...\n\nCollecting auction item links for all modes."] = "%s剩余拍卖...\n\n正在收集所有模式的拍卖物品链接。"
L["Updating Collection"] = "更新收藏"
L["%s items remaining..."] = "%s个物品剩余..."
L["%s remaining items..."] = "%s个剩余物品..."
L["Filtering, one moment please..."] = "正在过滤，请稍候..."
L["%s for %s is no longer available and has been removed"] = "%s用于%s不再可用，已被移除"
L["Unknown"] = "未知"
L["No auctions were found that matched your settings"] = "没有找到符合您设置的拍卖"
L["Auction House scan complete. Ready"] = "拍卖行扫描完成。准备就绪"
L["Blizzard allows a GetAll scan once every %s. Press \"Shop\""] = "暴雪允许每%s进行一次全局扫描。按下 \"商店\""
L["15 min"] = "15分钟"
L["That auction is no longer available and has been removed"] = "该拍卖不再可用，已被移除"
L["That auction belonged to a character on your account and has been removed"] = "该拍卖属于您账户上的角色，已被移除"
L["Realm: %s, UniqueItemIds: %d, Auctions: %d, Appearance Sources: %d"] = "服务器: %s, 唯一物品ID: %d, 拍卖: %d, 外观来源: %d"
L["Realm: %s, No data"] = "服务器: %s, 无数据"
L["%s auction house tab must be shown."] = "%s拍卖行标签必须显示。"
L["%s, item not found"] = "%s, 物品未找到"
L["%s, invType missing"] = "%s, invType缺失"
L["%s, slotId missing"] = "%s, slotId缺失"
L["%s, appearanceID or sourceID missing"] = "%s, appearanceID或sourceID缺失"
L["%s, model malfunction, data mismatch"] = "%s, 模型故障，数据不匹配"
L["ItemID: %s, invType: %s, slotId: %s"] = "物品ID: %s, invType: %s, slotId: %s"
L["AppearanceID: %s, SourceID: %s, |T%s:32|t %s"] = "外观ID: %s, 来源ID: %s, |T%s:32|t %s"
L["Unknown command, opening Help"] = "未知命令，打开帮助"
L["Use either slash command, /cs or /collectionshop"] = "使用斜杠命令，/cs 或 /collectionshop"
L["Warning: This addon is incompatible with Auctioneer."] = "警告：此插件与Auctioneer不兼容。"
L["Undress Character"] = "脱下角色装备"
L["Show character with\nselected item only"] = "仅显示选中物品的角色"
L["Lvl"] = "等级"
L["Category"] = "分类"
L["Item Price"] = "物品价格"
L["% Item Value"] = "物品价值百分比"
L["N/A"] = "不适用"
L["Seller:"] = "卖家："
L["Try reselecting the auction\nto load the seller's name."] = "尝试重新选择拍卖\n以加载卖家的名字。"
L["Buy All"] = "全部购买"
L["Automatically selects the next (first) auction and\ncontinues to do so after every confirmed buyout."] = "自动选择下一个（第一个）拍卖，并在每次确认一口价后继续这样做。"
L["Buy All has been stopped. %s"] = "全部购买已停止。%s"
L["Stop"] = "停止"
L["Scanning..."] = "正在扫描..."
L["Shop"] = "商店"
L["Scan"] = "扫描"
L["Selection ignored, busy scanning or buying an auction"] = "选择被忽略，忙于扫描或购买拍卖"
L["Scan Auction House live when\npressing \"Shop\" instead of\nusing GetAll scan data.\n\nLive scans only search\nthe pages required for the\nfilters you checked and may\nbe faster in certain modes or\nwhen using a low max price."] = "按下 \"商店\" 时实时扫描拍卖行，\n而不是使用全局扫描数据。\n\n实时扫描仅搜索您检查的过滤器所需的页面，\n可能在某些模式下或使用较低的最高价格时速度更快。"
L["Options"] = "选项"
L["Shop Filters"] = "商店过滤器"
L["Item Name"] = "物品名称"
L["Uncheck All"] = "全部取消勾选"
L["Check All"] = "全部勾选"

-------- OptionsConfig.lua --------
L["These options apply to all characters on your account.\nMaking changes will interupt or reset %s Auction House scans."] = "这些选项适用于您账户中的所有角色。\n进行更改将中断或重置%s拍卖行扫描。"
L["Auctions Won Reminder"] = "赢得拍卖提醒"
L["Remind me to use or\nequip auctions I've won\nafter leaving %s."] = "提醒我在离开%s后使用或\n装备我赢得的拍卖物品。"
L["Max Item Prices"] = "物品最高价格"
L["Hide auctions above this Item Price, 0 to show all."] = "隐藏高于此物品价格的拍卖，设置为0则显示全部。"
L["Item Value Source"] = "物品价值来源"
L["TradeSkillMaster price source or custom price source. For a list of price sources type /tsm sources."] = "TradeSkillMaster价格来源或自定义价格来源。输入/tsm sources获取价格来源列表。"
L["Not a valid price source or custom price source."] = "不是有效的价格来源或自定义价格来源。"
L["(adds Item Value % column to results, leave blank to disable)"] = "（在结果中添加物品价值百分比列，留空以禁用）"
L["Auto-select After Auction Unavailable"] = "拍卖不可用时自动选择"
L["When not using BuyAll, this\noption will auto-select and scroll\nto the next cheapest auction of the\nsame appearance, same pet, etc.\n\nWhen using BuyAll, this option is\nignored because the next (first)\nauction is always auto-selected."] = "当不使用BuyAll时，此选项将自动选择并滚动到下一个最便宜的拍卖，\n具有相同的外观、相同的宠物等。\n\n当使用BuyAll时，此选项被忽略，因为下一个（第一个）\n拍卖总是自动被选择。"
L["Buyouts"] = "一口价"
L["Mode"] = "模式"
L["Item Price"] = "物品价格"
L["Refresh"] = "刷新"
L["Buyouts Refreshed"] = "一口价已刷新"
L["%s\n%sBuyout tracking is reset when %s is closed|r"] = "%s\n%s当%s关闭时，一口价跟踪将被重置|r"
L["Buyout"] = "一口价"
L["Buyouts"] = "一口价"
L["GetAll Scan Data"] = "全局扫描数据"
L["No GetAll scan data for any realms."] = "没有任何领域的全局扫描数据。"
L["Realm:"] = "领域:"
L["ago"] = "前"
L["Delete Data"] = "删除数据"
L["Delete GetAll scan data? %s\n\nThis will interupt or reset %s Auction House scans"] = "删除全局扫描数据？%s\n\n这将中断或重置%s拍卖行扫描"
L["GetAll scan data deleted: %s"] = "全局扫描数据已删除：%s"
L["%s version %s for patch %s"] = "%s版本%s，适用于补丁%s"
L["%sSlash Commands|r"] = "%s斜杠命令|r"
L["%sNeed More Help?|r"] = "%s需要更多帮助？|r"
-- zhTW
elseif GetLocale() == "zhTW" then
end
