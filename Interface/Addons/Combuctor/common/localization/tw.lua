--[[
	Chinese Traditional Localization
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'zhTW')
if not L then return end

--keybindings
L.ToggleBags = '切換 背包'
L.ToggleBank = '切換 銀行'
L.ToggleGuild = '切換 公會銀行'
L.ToggleVault = '切換 虛空倉庫'

--terminal
L.Commands = '命令：'
L.CmdShowInventory = '切換背包'
L.CmdShowBank = '切換銀行'
L.CmdShowGuild = '切換公會銀行'
L.CmdShowVault = '切換虛空倉庫'
L.CmdShowVersion = '顯示目前版本'
L.Updated = '已更新到 v%s'

--frames
L.TitleBags = '%s的背包'
L.TitleBank = '%s的銀行'
L.TitleVault = '%s的虛空倉庫'
--interactions
L.Click = '點擊'
L.Drag = '<拖動>'
L.LeftClick = '<右鍵點擊>'
L.RightClick = '<右鍵點擊>'
L.DoubleClick = '<連按兩下>'
L.ShiftClick = '<shift鍵+點擊>'

--tooltips
L.TipBags = '背包'
L.TipChangePlayer = '點擊檢視其他角色的物品。'
L.TipCleanBags = '|CFF00FFFF<左鍵點擊>|r整理背包(|CFFD74DE1正序|r).|CFF00FFFF<右鍵點擊>|r(|CFFD74DE1逆序|r)。'
L.TipCleanBank = '<右鍵點擊>整理銀行。'
L.TipDepositReagents = '<左鍵點擊>全部存放到材料銀行。'
L.TipFrameToggle = '<右鍵點擊>切換其它視窗。'
L.TipGoldOnRealm = '%s上的總資產'
L.TipHideBag = '點擊隱藏背包。'
L.TipHideBags = '<左鍵點擊>隱藏背包顯示。'
L.TipHideSearch = '點擊隱藏搜尋介面。'
L.TipManageBank = '管理銀行'
L.PurchaseBag = '點擊購買銀行槽。'
L.TipShowBag = '點擊顯示背包。'
L.TipShowBags = '<左鍵點擊>顯示背包顯示。'
L.TipShowMenu = '<右鍵點擊>設定視窗。'
L.TipShowFrameConfig = '開啟設定視窗。'
L.TipDoubleClickSearch = '<拖動>移動。\n<右鍵點擊>設定。\n<兩次點擊>搜尋。'
L.Total = '總共'
L.TipResetPlayer = '%s返回現時角色'
L.TipCleanItems = '%s整理物品'
L.TipMove = '%s移動'
L.TipShowSearch = '%s搜尋'
L.TipConfigure = '%s設定這框架'

L.GuildFunds = '工會資金'
L.NumWithdraw = '%d 提款'
L.NumDeposit = '%d 存款'
L.NumRemainingWithdrawals = '%d 剩餘提款'

--itemcount tooltips
L.TipCountEquip = '已裝備: %d'
L.TipCountBags = '背包: %d'
L.TipCountBank = '銀行: %d'
L.TipCountVault = '虛空倉庫: %d'
L.TipCountGuild = '工會銀行: %d'
L.TipDelimiter = '|'

--databroker plugin tooltips
L.TipShowInventory = '<左鍵點擊>切換背包。'
L.TipShowBank = '<右鍵點擊>切換銀行。'
L.TipShowOptions = '<Shift-左鍵點擊>開啟設定選單。'


-- general
L.GeneralOptionsDesc = '根據你的喜好來切換一般功能設定。'
L.Locked = '鎖定框架'
L.Fading = '框架淡化'
L.TipCount = '物品統計提示'
L.CountGuild = '包括工會銀行'
L.FlashFind = '閃爍找到'
L.EmptySlots = '在空的槽位顯示背景顏色'
L.DisplayBlizzard = '隱藏的背包顯示為內建框架'

-- frame
L.FrameOptions = '框架設定'
L.FrameOptionsDesc = '設定%s框架。'
L.Frame = '框架'
L.Enabled = '啟用框架'
L.CharacterSpecific = '角色個別設定'
L.ExclusiveReagent = '分離材料銀行'


L.BagToggle = '背包列表'
L.Money = '金錢'
L.Broker = 'Databroker外掛'
L.Sort = '排序按鈕'
L.Search = '切換搜尋'
L.Options = '設定按鈕'


L.Appearance = '外觀'
L.Layer = '階層'
L.BagBreak = '根據背包顯示'
L.ReverseBags = '反轉背包順序'
L.ReverseSlots = '反轉槽位順序'

L.Color = '背景顏色'
L.BorderColor = '邊框顏色'

L.Strata = '框架層級'
L.Columns = '列'
L.Scale = '縮放'
L.ItemScale = '物品縮放'
L.Spacing = '間距'
L.Alpha = '透明度'

-- auto display
L.DisplayOptions = '自動顯示'
L.DisplayOptionsDesc = '讓你設定在遊戲事件中背包自動開啟或關閉。'
L.DisplayInventory = '顯示背包'
L.CloseInventory = '關閉背包'

L.DisplayBank = '訪問銀行'
L.DisplayAuction = '訪問拍賣行'
L.DisplayTrade = '交易物品'
L.DisplayScrapping = '銷毀裝備'
L.DisplayCraft = '製造'
L.DisplayMail = '檢查信箱'
L.DisplayGuildbank = '訪問公會銀行'
L.DisplayPlayer = '開啟角色資訊'
L.DisplayGems = '鑲崁寶石'

L.CloseCombat = '進入戰鬥'
L.CloseVehicle = '進入載具'
L.CloseBank = '離開銀行'
L.CloseVendor = '離開商人'
L.CloseMap = '打開世界地圖'

-- colors
L.ColorOptions = '顏色設定'
L.ColorOptionsDesc = '讓你設定在%s框架裡較簡單辨識物品槽位。'
L.GlowQuality = '根據品質高亮物品'
L.GlowNew = '高亮新物品'
L.GlowQuest = '高亮任務物品'
L.GlowUnusable = '高亮無法使用的物品'
L.GlowSets = '高亮裝備設定物品'
L.ColorSlots = '根據背包類型高亮空的槽'


L.NormalColor = '一般背包槽顏色'
L.LeatherColor = '製皮包槽顏色'
L.InscribeColor = '銘文包槽顏色'
L.HerbColor = '草藥包槽顏色'
L.EnchantColor = '附魔包槽顏色'
L.EngineerColor = '工程箱槽顏色'
L.GemColor = '寶石包顏色'
L.MineColor = '礦石包顏色'
L.TackleColor = '工具箱顏色'
L.RefrigeColor = '冰箱顏色'
L.ReagentColor = '材料銀行顏色'
L.GlowAlpha = '高亮亮度'
L.QuiverColor = '箭袋顏色'
L.SoulColor = '靈魂碎片包顏色'
