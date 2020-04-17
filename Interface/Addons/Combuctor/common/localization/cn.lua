--[[
	Chinese Simplified Localization
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'zhCN')
if not L then return end

--keybindings
L.ToggleBags = '    切换背包'
L.ToggleBank = '    切换银行'
L.ToggleGuild = '切换公会银行'
L.ToggleVault = '切换虚空仓库'

--terminal
L.Commands = '命令列表'
L.CmdShowInventory = '切换背包'
L.CmdShowBank = '切换银行'
L.CmdShowGuild = '切换公会银行'
L.CmdShowVault = '切换虚空仓库'
L.CmdShowVersion = '列出当前版本'
L.CmdShowOptions = '打开配置菜单'
L.Updated = '已更新到 v%s'


--frame titles
L.TitleBags = '%s的背包'
L.TitleBank = '%s的银行'
L.TitleVault = '%s的虚空仓库'

--dropdowns
L.TitleFrames = '%s的框架'
L.SelectCharacter = '选择角色'
L.ConfirmDelete = '确定要删除 %s 的缓存数据？'

--interactions
L.Click = '点击'
L.Drag = '<拖动>'
L.LeftClick = '<左击>'
L.RightClick = '<右击>'
L.DoubleClick = '<双击>'
L.ShiftClick = '<Shift-点击>'

--tooltips
L.Total = '总共'
L.GuildFunds = '公会基金'
L.TipGoldOnRealm = '%s总资产'
L.NumWithdraw = '%d取出'
L.NumDeposit = '%d存入'
L.NumRemainingWithdrawals = '%d取出剩余'

--action tooltips
L.TipChangePlayer = '<点击>查看其他角色的物品。'
L.TipCleanItems = '|CFF00FFFF<左键点击>|r整理背包(|CFFD74DE1正序|r).|CFF00FFFF<右键点击>|r(|CFFD74DE1逆序|r)'
L.TipConfigure = '%s配置此窗口。'
L.TipDepositReagents = '|CFF00FFFFCtrl+|r%s存放材料到银行.'
L.TipDeposit = '%s存入。'
L.TipWithdraw = '%s取出（%s剩余）。'
L.TipFrameToggle = '%s切换其他窗口。'
L.TipHideBag = '%s隐藏此背包。'
L.TipHideBags = '%s隐藏背包显示。'
L.TipHideSearch = '%s停止搜索。'
L.TipMove = '%s移动。'
L.TipPurchaseBag = '%s购买此银行空位。'
L.TipResetPlayer = '%s返回到当前角色。'
L.TipShowBag = '%s显示此背包。'
L.TipShowBags = '%s显示背包显示。'
L.TipShowBank = '%s切换银行。'
L.TipShowInventory = '%s切换背包。'
L.TipShowOptions = '%s打开选项菜单。'
L.TipShowSearch = '%s搜索'

--item tooltips
L.TipCountEquip = '已装备：%d'
L.TipCountBags = '背包：%d'
L.TipCountBank = '银行：%d'
L.TipCountVault = '虚空仓库：%d'
L.TipCountGuild = '公会：%d'
L.TipDelimiter = '|'

--dialogs
L.AskMafia = '问问大佬'
L.ConfirmTransfer = '存入任一物品将移除全部修改并使其不可交易和不可退款。|n|n希望继续？'
L.CannotPurchaseVault = '没有足够的货币解锁虚空仓库服务|n|n|cffff2020花费：%s|r'
L.PurchaseVault = '希望解锁虚空仓库？|n|n|cffffd200花费：|r %s'

-- general
L.GeneralOptionsDesc = '这些通用功能可以依据配置切换。'
L.Locked = '锁定框架'
L.Fading = '渐隐效果'
L.TipCount = '提示物品数目'
L.CountGuild = '包含公会银行'
L.FlashFind = '闪烁搜索'
L.DisplayBlizzard = '显示暴雪框架隐藏背包'
L.DisplayBlizzardTip = '如果启用，隐藏背包或银行容器将显示默认暴雪用户界面背包面板。\n\n|cffff1919需要重载用户界面。|r'
L.ConfirmGlobals = '确定要禁用特定此角色的特定设置？所有特定设置将丢失。'
L.CharacterSpecific = '角色特定设置'

-- frame
L.FrameOptions = '框架设置'
L.FrameOptionsDesc = '此配置设置特定到一个%s框架。'
L.Frame = '框架'
L.Enabled = '启用框架'
L.EnabledTip = '如果禁用，默认暴雪用户界面不会替换此框架。\n\n|cffff1919需要重载用户界面。|r'
L.ActPanel = '作为标准面板'
L.ActPanelTip = [[
如启用，此面板将自动定位
像标准的一样，如同 |cffffffff法术书|r
或 |cffffffff团队查找器|r，并不能被移动。]]

L.BagToggle = '背包切换'
L.Money = '货币'
L.Broker = 'Databroker 插件'
L.Sort = '整理按钮'
L.Search = '切换搜索'
L.Options = '选项按钮'
L.ExclusiveReagent = '分离材料银行'
L.LeftTabs = '左侧规则'
L.LeftTabsTip = [[
如启用，边框标签将被
显示到左侧面板。]]

L.Appearance = '外观'
L.Layer = '层级'
L.BagBreak = '背包分散'
L.ReverseBags = '反向背包排列'
L.ReverseSlots = '反向物品排列'

L.Color = '背景颜色'
L.BorderColor = '边框颜色'

L.Strata = '框架层级'
L.Columns = '列数'
L.Scale = '缩放'
L.ItemScale = '物品缩放'
L.Spacing = '间距'
L.Alpha = '透明度'

-- auto display
L.DisplayOptions = '自动显示'
L.DisplayOptionsDesc = '此设置允许配置游戏事件时自动打开或关闭背包。'
L.DisplayInventory = '打开背包'
L.CloseInventory = '关闭背包'

L.DisplayBank = '打开银行时'
L.DisplayGuildbank = '打开公会银行时'
L.DisplayAuction = '打开拍卖行时'
L.DisplayMail = '打开邮箱时'
L.DisplayTrade = '交易时'
L.DisplayScrapping = '摧毁装备时'
L.DisplayGems = '镶嵌物品时'
L.DisplayCraft = '制作时'
L.DisplayPlayer = '打开角色信息时'

L.CloseCombat = '进入战斗时'
L.CloseVehicle = '进入载具时'
L.CloseBank = '离开银行时'
L.CloseVendor = '离开商人时'
L.CloseMap = '打开世界地图时'

-- colors
L.ColorOptions = '颜色设置'
L.ColorOptionsDesc = '此设置允许更改物品在%s框架上的染色以便于识别。'
L.GlowQuality = '按物品品质染色'
L.GlowQuest = '任务物品染色'
L.GlowUnusable = '无用品染色'
L.GlowSets = '套装染色'
L.GlowNew = '新物品发光'
L.GlowPoor = '标记垃圾物品'
L.GlowAlpha = '发光亮度'

L.EmptySlots = '显示空格背景材质'
L.ColorSlots = '按背包类型染色'
L.NormalColor = '一般颜色'
L.KeyColor = '钥匙颜色'
L.QuiverColor = '箭袋颜色'
L.SoulColor = '灵魂袋颜色'
L.ReagentColor = '材料银行颜色'
L.LeatherColor = '制皮颜色'
L.InscribeColor = '铭文颜色'
L.HerbColor = '草药颜色'
L.EnchantColor = '附魔颜色'
L.EngineerColor = '工程颜色'
L.GemColor = '宝石颜色'
L.MineColor = '矿石颜色'
L.TackleColor = '工具箱颜色'
L.FridgeColor = '烹饪颜色'

-- rulesets
L.RuleOptions = '物品规则'
L.RuleOptionsDesc = '这项设置允许选择按照类型显示和排列物品的规则。'
