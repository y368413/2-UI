local addonName, _ = ...


---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class Utils: AceModule
local U = addon:GetModule('Utils')

---@class E: AceModule
local E = addon:NewModule("Element")

---@class Item: AceModule
local Item = addon:GetModule("Item")

---@class Trigger: AceModule
local Trigger = addon:GetModule("Trigger")

---@class AuraCache: AceModule
local AuraCache = addon:GetModule("AuraCache")

---@return ElementConfig
---@param title string
---@param type ElementType
function E:New(title, type)
    ---@type ElementConfig
    local config = {
        id = U.String.GenerateID(),
        isDisplayMouseEnter = false,
        title = title,
        type = type,
        icon = 134400,
        elements = {{
            ["elements"] = {
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729829496_VK8DtkVy",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 122117,
            ["type"] = 3,
            ["name"] = "伊克赞的诅咒之羽",
            ["icon"] = 1029736,
            },
            ["isLoad"] = true,
            ["title"] = "物品",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729829505_OpeUy6Il",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 120276,
            ["type"] = 3,
            ["name"] = "侦察骑兵的缰绳",
            ["icon"] = 971291,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [1]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729829513_iRM0v0k4",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 118937,
            ["type"] = 3,
            ["name"] = "加摩尔的发辫",
            ["icon"] = 878263,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [2]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729829521_SXgmiUYJ",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 183847,
            ["type"] = 3,
            ["name"] = "助祭的伪装",
            ["icon"] = 3601556,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [3]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729829529_asccygIH",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 128462,
            ["type"] = 3,
            ["name"] = "卡拉波议员礼服",
            ["icon"] = 921904,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [4]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729829538_KNFDSGt5",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 68806,
            ["type"] = 3,
            ["name"] = "卡莱莎的魂萦坠饰",
            ["icon"] = 348284,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [5]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838640_EJtLverm",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 139337,
            ["type"] = 3,
            ["name"] = "即抛型冬幕节服装",
            ["icon"] = 1339669,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [6]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838647_9iiU6tZ4",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 190457,
            ["type"] = 3,
            ["name"] = "原型拓扑方块",
            ["icon"] = 4254892,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [7]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838654_7RfUIaik",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 224783,
            ["type"] = 3,
            ["name"] = "君主华服之箱",
            ["icon"] = 4203076,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [8]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838662_WWbq2tlM",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 191891,
            ["type"] = 3,
            ["name"] = "啾讽教授完美得无可置喙的鹰身人伪装",
            ["icon"] = 2103802,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [9]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838674_zi2cOTtT",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 141862,
            ["type"] = 3,
            ["name"] = "圣光微粒",
            ["icon"] = 237435,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [10]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838681_POSSi5YZ",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 127668,
            ["type"] = 3,
            ["name"] = "地狱火珠宝",
            ["icon"] = 1020381,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [11]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838693_R7yaTsuD",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 128807,
            ["type"] = 3,
            ["name"] = "多面硬币",
            ["icon"] = 133799,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [12]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838701_ypBbBtip",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 103685,
            ["type"] = 3,
            ["name"] = "天神防御者的奖章",
            ["icon"] = 645227,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [13]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838710_b7NiA0xC",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 64651,
            ["type"] = 3,
            ["name"] = "小精灵护符",
            ["icon"] = 458258,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [14]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838721_HEiuX2tY",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 166779,
            ["type"] = 3,
            ["name"] = "幻变者道标",
            ["icon"] = 2823166,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [15]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838730_BPeYYq3t",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 225641,
            ["type"] = 3,
            ["name"] = "幻象蜃鱼人诱饵",
            ["icon"] = 5372523,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [16]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838739_rFNVot9Z",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 127659,
            ["type"] = 3,
            ["name"] = "幽灵钢铁海盗帽",
            ["icon"] = 133168,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [17]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838749_ZtlCspow",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 133511,
            ["type"] = 3,
            ["name"] = "戈博格的闪光宝贝",
            ["icon"] = 463858,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [18]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838759_txL3OHD1",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 187155,
            ["type"] = 3,
            ["name"] = "拟态者的伪装",
            ["icon"] = 1354189,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [19]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838770_y4PAnGwy",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 134831,
            ["type"] = 3,
            ["name"] = "末日预言者长袍",
            ["icon"] = 132666,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [20]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838787_Y9XQB0oV",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 119215,
            ["type"] = 3,
            ["name"] = "机械仿真侏儒",
            ["icon"] = 892830,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [21]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838797_fenC3tRR",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 1973,
            ["type"] = 3,
            ["name"] = "欺诈宝珠",
            ["icon"] = 134334,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [22]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838811_RnHjjRIy",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 142452,
            ["type"] = 3,
            ["name"] = "残余的虫语精华",
            ["icon"] = 967528,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [23]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838936_tuijF69U",
            ["attachFrameAnchorPos"] = "CENTER",
            ["isDisplayMouseEnter"] = false,
            ["icon"] = 134400,
            ["isLoad"] = true,
            ["title"] = "物品 [24]",
            ["attachFrame"] = "UIParent",
            ["isDisplayText"] = false,
            ["anchorPos"] = "CENTER",
            ["extraAttr"] = {
            ["id"] = 118938,
            ["type"] = 3,
            ["name"] = "法力风暴的复印机",
            ["icon"] = 443374,
            },
            ["combatLoadCond"] = 2,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838943_BSFj2d1h",
            ["attachFrameAnchorPos"] = "CENTER",
            ["isDisplayMouseEnter"] = false,
            ["icon"] = 134400,
            ["isLoad"] = true,
            ["title"] = "物品 [25]",
            ["attachFrame"] = "UIParent",
            ["isDisplayText"] = false,
            ["anchorPos"] = "CENTER",
            ["extraAttr"] = {
            ["id"] = 140780,
            ["type"] = 3,
            ["name"] = "法多雷蛛卵",
            ["icon"] = 443378,
            },
            ["combatLoadCond"] = 2,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838952_zdhYt353",
            ["attachFrameAnchorPos"] = "CENTER",
            ["isDisplayMouseEnter"] = false,
            ["icon"] = 134400,
            ["isLoad"] = true,
            ["title"] = "物品 [26]",
            ["attachFrame"] = "UIParent",
            ["isDisplayText"] = false,
            ["anchorPos"] = "CENTER",
            ["extraAttr"] = {
            ["id"] = 129926,
            ["type"] = 3,
            ["name"] = "灰舌印记",
            ["icon"] = 236691,
            },
            ["combatLoadCond"] = 2,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838962_hph4V5VL",
            ["attachFrameAnchorPos"] = "CENTER",
            ["isDisplayMouseEnter"] = false,
            ["icon"] = 134400,
            ["isLoad"] = true,
            ["title"] = "物品 [27]",
            ["attachFrame"] = "UIParent",
            ["isDisplayText"] = false,
            ["anchorPos"] = "CENTER",
            ["extraAttr"] = {
            ["id"] = 66888,
            ["type"] = 3,
            ["name"] = "熊怪变形棒",
            ["icon"] = 135463,
            },
            ["combatLoadCond"] = 2,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838972_5c3ax9Cu",
            ["attachFrameAnchorPos"] = "CENTER",
            ["isDisplayMouseEnter"] = false,
            ["icon"] = 134400,
            ["isLoad"] = true,
            ["title"] = "物品 [28]",
            ["attachFrame"] = "UIParent",
            ["isDisplayText"] = false,
            ["anchorPos"] = "CENTER",
            ["extraAttr"] = {
            ["id"] = 52201,
            ["type"] = 3,
            ["name"] = "穆拉丁的礼物",
            ["icon"] = 135850,
            },
            ["combatLoadCond"] = 2,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838982_YYWLoZYS",
            ["attachFrameAnchorPos"] = "CENTER",
            ["isDisplayMouseEnter"] = false,
            ["icon"] = 134400,
            ["isLoad"] = true,
            ["title"] = "物品 [29]",
            ["attachFrame"] = "UIParent",
            ["isDisplayText"] = false,
            ["anchorPos"] = "CENTER",
            ["extraAttr"] = {
            ["id"] = 163750,
            ["type"] = 3,
            ["name"] = "考沃克装束",
            ["icon"] = 529881,
            },
            ["combatLoadCond"] = 2,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729838991_Mq7hGizM",
            ["attachFrameAnchorPos"] = "CENTER",
            ["isDisplayMouseEnter"] = false,
            ["icon"] = 134400,
            ["isLoad"] = true,
            ["title"] = "物品 [30]",
            ["attachFrame"] = "UIParent",
            ["isDisplayText"] = false,
            ["anchorPos"] = "CENTER",
            ["extraAttr"] = {
            ["id"] = 127709,
            ["type"] = 3,
            ["name"] = "脉动的鲜血宝珠",
            ["icon"] = 538040,
            },
            ["combatLoadCond"] = 2,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729839001_IPn0NDkq",
            ["attachFrameAnchorPos"] = "CENTER",
            ["isDisplayMouseEnter"] = false,
            ["icon"] = 134400,
            ["isLoad"] = true,
            ["title"] = "物品 [31]",
            ["attachFrame"] = "UIParent",
            ["isDisplayText"] = false,
            ["anchorPos"] = "CENTER",
            ["extraAttr"] = {
            ["id"] = 200857,
            ["type"] = 3,
            ["name"] = "莎尔佳护符",
            ["icon"] = 897090,
            },
            ["combatLoadCond"] = 2,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729839012_oxW2qJzo",
            ["attachFrameAnchorPos"] = "CENTER",
            ["isDisplayMouseEnter"] = false,
            ["icon"] = 134400,
            ["isLoad"] = true,
            ["title"] = "物品 [32]",
            ["attachFrame"] = "UIParent",
            ["isDisplayText"] = false,
            ["anchorPos"] = "CENTER",
            ["extraAttr"] = {
            ["id"] = 71259,
            ["type"] = 3,
            ["name"] = "莱雅娜的坠饰",
            ["icon"] = 514925,
            },
            ["combatLoadCond"] = 2,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729839023_5DrXlkH3",
            ["attachFrameAnchorPos"] = "CENTER",
            ["isDisplayMouseEnter"] = false,
            ["icon"] = 134400,
            ["isLoad"] = true,
            ["title"] = "物品 [33]",
            ["attachFrame"] = "UIParent",
            ["isDisplayText"] = false,
            ["anchorPos"] = "CENTER",
            ["extraAttr"] = {
            ["id"] = 119134,
            ["type"] = 3,
            ["name"] = "萨格雷伪装",
            ["icon"] = 841221,
            },
            ["combatLoadCond"] = 2,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729839036_vgPWG0yx",
            ["attachFrameAnchorPos"] = "CENTER",
            ["isDisplayMouseEnter"] = false,
            ["icon"] = 134400,
            ["isLoad"] = true,
            ["title"] = "物品 [34]",
            ["attachFrame"] = "UIParent",
            ["isDisplayText"] = false,
            ["anchorPos"] = "CENTER",
            ["extraAttr"] = {
            ["id"] = 130147,
            ["type"] = 3,
            ["name"] = "蓟叶树枝",
            ["icon"] = 960682,
            },
            ["combatLoadCond"] = 2,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729839049_LzJBPl4Q",
            ["attachFrameAnchorPos"] = "CENTER",
            ["isDisplayMouseEnter"] = false,
            ["icon"] = 134400,
            ["isLoad"] = true,
            ["title"] = "物品 [35]",
            ["attachFrame"] = "UIParent",
            ["isDisplayText"] = false,
            ["anchorPos"] = "CENTER",
            ["extraAttr"] = {
            ["id"] = 184223,
            ["type"] = 3,
            ["name"] = "被统御者的头盔",
            ["icon"] = 3555135,
            },
            ["combatLoadCond"] = 2,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729839061_R3xp2JzB",
            ["attachFrameAnchorPos"] = "CENTER",
            ["isDisplayMouseEnter"] = false,
            ["icon"] = 134400,
            ["isLoad"] = true,
            ["title"] = "物品 [36]",
            ["attachFrame"] = "UIParent",
            ["isDisplayText"] = false,
            ["anchorPos"] = "CENTER",
            ["extraAttr"] = {
            ["id"] = 129938,
            ["type"] = 3,
            ["name"] = "诺森德的意志",
            ["icon"] = 338784,
            },
            ["combatLoadCond"] = 2,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729839070_DsWAtxJF",
            ["attachFrameAnchorPos"] = "CENTER",
            ["isDisplayMouseEnter"] = false,
            ["icon"] = 134400,
            ["isLoad"] = true,
            ["title"] = "物品 [37]",
            ["attachFrame"] = "UIParent",
            ["isDisplayText"] = false,
            ["anchorPos"] = "CENTER",
            ["extraAttr"] = {
            ["id"] = 147843,
            ["type"] = 3,
            ["name"] = "赛拉的备用斗篷",
            ["icon"] = 1447613,
            },
            ["combatLoadCond"] = 2,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729839080_C1zPgDkB",
            ["attachFrameAnchorPos"] = "CENTER",
            ["isDisplayMouseEnter"] = false,
            ["icon"] = 134400,
            ["isLoad"] = true,
            ["title"] = "物品 [38]",
            ["attachFrame"] = "UIParent",
            ["isDisplayText"] = false,
            ["anchorPos"] = "CENTER",
            ["extraAttr"] = {
            ["id"] = 35275,
            ["type"] = 3,
            ["name"] = "辛多雷宝珠",
            ["icon"] = 134334,
            },
            ["combatLoadCond"] = 2,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841253_2b4qUWfm",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 116067,
            ["type"] = 3,
            ["name"] = "违誓之戒",
            ["icon"] = 1022162,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [39]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841271_5xqjiKKe",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 104294,
            ["type"] = 3,
            ["name"] = "迷时水手结晶",
            ["icon"] = 463286,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [40]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841280_0e4517PK",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 86568,
            ["type"] = 3,
            ["name"] = "重拳先生的铜罗盘",
            ["icon"] = 443379,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [41]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841288_1QapmtbW",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 118244,
            ["type"] = 3,
            ["name"] = "钢铁海盗帽",
            ["icon"] = 133168,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [42]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841298_xRUvQGqL",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 43499,
            ["type"] = 3,
            ["name"] = "铁靴烈酒",
            ["icon"] = 132788,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [43]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841311_HWvszaBZ",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 128471,
            ["type"] = 3,
            ["name"] = "霜狼蛮兵战甲",
            ["icon"] = 1044793,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [44]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841323_FknG2DCE",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 118716,
            ["type"] = 3,
            ["name"] = "鬣蜥人伪装",
            ["icon"] = 134460,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [45]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841337_if5dQ3dU",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 72159,
            ["type"] = 3,
            ["name"] = "魔法食人魔玩偶",
            ["icon"] = 134230,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [46]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841354_Mzok2ARO",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 127394,
            ["type"] = 3,
            ["name"] = "魔荚人伪装",
            ["icon"] = 1044495,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [47]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841365_l3J1ub6N",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 122283,
            ["type"] = 3,
            ["name"] = "鲁克玛的神圣回忆",
            ["icon"] = 648540,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [48]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841389_Bml8jNxz",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 129093,
            ["type"] = 3,
            ["name"] = "鸦熊伪装",
            ["icon"] = 454039,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [49]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841401_fxtKk07x",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 166544,
            ["type"] = 3,
            ["name"] = "黑暗游侠的备用罩帽",
            ["icon"] = 458226,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [50]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841413_z68xC819",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 164374,
            ["type"] = 3,
            ["name"] = "魔法猴子香蕉",
            ["icon"] = 132159,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [51]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841423_WrgZEWgn",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 164373,
            ["type"] = 3,
            ["name"] = "魔法汤石",
            ["icon"] = 135237,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [52]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841433_D6VcWBn9",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 174873,
            ["type"] = 3,
            ["name"] = "魔古变身器",
            ["icon"] = 801008,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [53]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841443_nbTId210",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 140160,
            ["type"] = 3,
            ["name"] = "雷铸维库号角",
            ["icon"] = 237378,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [54]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841452_qiLNBiez",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 32782,
            ["type"] = 3,
            ["name"] = "迷时雕像",
            ["icon"] = 134911,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [55]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841464_JQ9QvrL5",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 37254,
            ["type"] = 3,
            ["name"] = "超级猴子球",
            ["icon"] = 134335,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [56]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841477_cIi9pTFz",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 208658,
            ["type"] = 3,
            ["name"] = "谦逊之镜",
            ["icon"] = 1003591,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [57]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841494_HALpDkC8",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 113096,
            ["type"] = 3,
            ["name"] = "血鬃符咒",
            ["icon"] = 132122,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [58]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841513_cOXE3cAm",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 228705,
            ["type"] = 3,
            ["name"] = "蛛类血清",
            ["icon"] = 1385268,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [59]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841524_n1Bf8unJ",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 202253,
            ["type"] = 3,
            ["name"] = "爪皮原始手杖",
            ["icon"] = 4901296,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [60]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841535_SEVIHQBA",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 116440,
            ["type"] = 3,
            ["name"] = "炽燃防御者的勋章",
            ["icon"] = 512473,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [61]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841546_dqaj5OhN",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 119421,
            ["type"] = 3,
            ["name"] = "沙塔尔防御者勋章",
            ["icon"] = 442731,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [62]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841568_SPUYlcRI",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 105898,
            ["type"] = 3,
            ["name"] = "月牙的爪子",
            ["icon"] = 132936,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [63]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841579_ywBLJ4OL",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 208421,
            ["type"] = 3,
            ["name"] = "新月纲要",
            ["icon"] = 133739,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [64]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841590_bNpSYRCf",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 200960,
            ["type"] = 3,
            ["name"] = "新生灵魂之种",
            ["icon"] = 3586268,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [65]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841603_p7OhY6sk",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 86573,
            ["type"] = 3,
            ["name"] = "拱石碎片",
            ["icon"] = 135241,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [66]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841614_qc1LpHOa",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 79769,
            ["type"] = 3,
            ["name"] = "恶魔猎手的守护",
            ["icon"] = 236415,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [67]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841624_uu170QP4",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 200636,
            ["type"] = 3,
            ["name"] = "原始祈咒精华",
            ["icon"] = 4631364,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [68]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841634_UCYPlhwm",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 164375,
            ["type"] = 3,
            ["name"] = "劣质魔精香蕉",
            ["icon"] = 458252,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [69]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841644_uoQESLEa",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 205904,
            ["type"] = 3,
            ["name"] = "充满活力的啪嗒作响之爪",
            ["icon"] = 1508491,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [70]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841654_VLigORkn",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 163795,
            ["type"] = 3,
            ["name"] = "乌古特仪祭之鼓",
            ["icon"] = 526523,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [71]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841664_RB8KHsNJ",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 166308,
            ["type"] = 3,
            ["name"] = "为了血神！",
            ["icon"] = 1726347,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [72]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841673_q2HQVcNF",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 200178,
            ["type"] = 3,
            ["name"] = "僵化药水",
            ["icon"] = 136145,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [73]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841685_NIZh0vMM",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 203852,
            ["type"] = 3,
            ["name"] = "孢缚精华",
            ["icon"] = 134052,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [74]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            {
            ["type"] = 1,
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["id"] = "1729841694_prbmo2Im",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["id"] = 64646,
            ["type"] = 3,
            ["name"] = "扭曲骸骨",
            ["icon"] = 458236,
            },
            ["isLoad"] = true,
            ["title"] = "物品 [75]",
            ["anchorPos"] = "CENTER",
            ["isDisplayText"] = false,
            ["attachFrame"] = "UIParent",
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["isLoad"] = true,
            ["icon"] = "Interface\\AddOns\\HappyButton\\Media\\Logo64.blp",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 2,
            ["anchorPos"] = "BOTTOMRIGHT",
            ["id"] = "1729829440_DPbgqsUq",
            ["attachFrameAnchorPos"] = "TOPRIGHT",
            ["isShowQualityBorder"] = true,
            ["iconWidth"] = 43,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "GameMenuFrame",
            ["title"] = "随机变身玩具",
            ["iconHeight"] = 43,
            ["isDisplayText"] = false,
            ["combatLoadCond"] = 2,
            ["extraAttr"] = {
            ["mode"] = 1,
            ["configSelectedItemIndex"] = 15,
            ["displayUnLearned"] = false,
            },
            ["texts"] = {
            {
            ["text"] = "%n",
            },
            {
            ["text"] = "%s",
            },
            },
            },
            {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730515980_qQ1nkBiC",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730515980_qQ1nkBiC",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730515980_aBwgnWcL",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [9]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730515980_qQ1nkBiC",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["extraAttr"] = {
            ["id"] = 888,
            ["type"] = 5,
            ["name"] = "先知的狂怒风暴",
            ["icon"] = 1530549,
            },
            ["texts"] = {
            },
            },
            ["elements"] = {
            {
            ["elements"] = {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474204_j27NLZx4",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474204_j27NLZx4",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474204_hgavIse6",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474204_j27NLZx4",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 255661,
            ["type"] = 4,
            ["name"] = "戏法",
            ["icon"] = 1723988,
            },
            ["texts"] = {
            {
            ["text"] = "%n",
            },
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474236_RSp1SsE9",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474236_RSp1SsE9",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474236_q8M8WarO",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [1]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474236_RSp1SsE9",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 156833,
            ["type"] = 3,
            ["icon"] = 443375,
            ["name"] = "凯蒂的印哨",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474251_mFyIhWR7",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474251_mFyIhWR7",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474251_yx5EwhCE",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [2]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474251_mFyIhWR7",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 194885,
            ["type"] = 3,
            ["icon"] = 1029578,
            ["name"] = "欧胡纳栖枝",
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "Interface\\AddOns\\HappyButton\\Media\\Logo64.blp",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474171_asne7zIC",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "邮箱",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474326_gPB2FIwb",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474326_gPB2FIwb",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474326_1Xx6qBJK",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474326_gPB2FIwb",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 69046,
            ["type"] = 4,
            ["name"] = "呼叫大胖",
            ["icon"] = 370211,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474339_1AZdLhWa",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474339_1AZdLhWa",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474339_uumZpkx9",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [1]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474339_1AZdLhWa",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 83958,
            ["type"] = 4,
            ["name"] = "移动银行",
            ["icon"] = 413587,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474356_jLfy1fRi",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474356_jLfy1fRi",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474356_zualOZeT",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [2]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474356_jLfy1fRi",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 460905,
            ["type"] = 4,
            ["name"] = "战团银行距离抑制器",
            ["icon"] = 4914670,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474365_KhVmvLwq",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474365_KhVmvLwq",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474365_6dPH0USO",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [3]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474365_KhVmvLwq",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 214,
            ["type"] = 6,
            ["name"] = "银色侍从",
            ["icon"] = 236689,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474379_auEmF1N2",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474379_auEmF1N2",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474379_XszSG0gL",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [4]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474379_auEmF1N2",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 144341,
            ["type"] = 1,
            ["icon"] = 1405815,
            ["name"] = "可充电的里弗斯电池",
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "Interface\\AddOns\\HappyButton\\Media\\Logo64.blp",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474294_UrFahEvH",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "银行",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730520007_wWxYPGhQ",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730520007_wWxYPGhQ",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730520007_fFkoJ2Zf",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [11]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730520007_wWxYPGhQ",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 1589,
            ["type"] = 5,
            ["name"] = "复苏始祖幼龙",
            ["icon"] = 4622499,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730516478_jFj0Pa6f",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730516478_jFj0Pa6f",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730516478_s8pzdzYa",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [10]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730516478_jFj0Pa6f",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 352,
            ["type"] = 5,
            ["name"] = "X-45偷心火箭",
            ["icon"] = 4254090,
            },
            ["texts"] = {
            },
            },
            ["elements"] = {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474417_CAC6G7bG",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474417_CAC6G7bG",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474417_xLiFLVNw",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474417_CAC6G7bG",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 280,
            ["type"] = 5,
            ["name"] = "旅行者的苔原猛犸象",
            ["icon"] = 236240,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474429_owNvkSgF",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474429_owNvkSgF",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474429_UR2jAIo4",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [1]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474429_owNvkSgF",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 460,
            ["type"] = 5,
            ["name"] = "雄壮远足牦牛",
            ["icon"] = 616692,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474437_IOH8irsJ",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474437_IOH8irsJ",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474437_v4T9EeSt",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [2]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474437_IOH8irsJ",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 2237,
            ["type"] = 5,
            ["name"] = "灰熊丘陵魁熊",
            ["icon"] = 5907364,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474444_2zGrUgmv",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474444_2zGrUgmv",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474444_g39FGFe1",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [3]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474444_2zGrUgmv",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 1039,
            ["type"] = 5,
            ["name"] = "雄壮商队雷龙",
            ["icon"] = 1881827,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730529628_nqCEWmZN",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730529628_nqCEWmZN",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730529628_jmPBk7Fp",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [9]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730529628_nqCEWmZN",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["extraAttr"] = {
            ["id"] = 2265,
            ["type"] = 5,
            ["name"] = "鎏金雷龙",
            ["icon"] = 6075464,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474451_6q6D1PFL",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474451_6q6D1PFL",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474451_1O48oq63",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [4]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474451_6q6D1PFL",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 282,
            ["type"] = 6,
            ["name"] = "公会使者",
            ["icon"] = 413585,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474465_dCYuimTQ",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474465_dCYuimTQ",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474465_IQuA1pYh",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [5]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474465_dCYuimTQ",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 280,
            ["type"] = 6,
            ["name"] = "公会侍从",
            ["icon"] = 413584,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474479_lk4FF3yY",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474479_lk4FF3yY",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474479_qeopqUnv",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [6]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474479_lk4FF3yY",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 49040,
            ["type"] = 1,
            ["icon"] = 254097,
            ["name"] = "基维斯",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474494_5IM1TlLZ",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474494_5IM1TlLZ",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474494_Vv6rOAbX",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [7]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474494_5IM1TlLZ",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 132523,
            ["type"] = 1,
            ["icon"] = 1405815,
            ["name"] = "里弗斯电池",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474509_Z8PqBUec",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730474509_Z8PqBUec",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474509_MAznSxfv",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [8]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730474509_Z8PqBUec",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 221957,
            ["type"] = 1,
            ["icon"] = 254109,
            ["name"] = "阿加修理机器人11O",
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "Interface\\AddOns\\HappyButton\\Media\\Logo64.blp",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730474402_YNXD2j9l",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "商人",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "TOPRIGHT",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "Interface\\AddOns\\HappyButton\\Media\\Logo64.blp",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["iconWidth"] = 36,
            ["anchorPos"] = "BOTTOMRIGHT",
            ["id"] = "1730474024_1702XOdM",
            ["attachFrameAnchorPos"] = "BOTTOMLEFT",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "GameMenuFrame",
            ["title"] = "实用工具",
            ["iconHeight"] = 36,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            },
            ["texts"] = {
            {
            ["text"] = "%s",
            },
            },
            },
            {
            ["elements"] = {
            {
            ["elements"] = {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360557_Nf3azueK",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360557_Nf3azueK",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftVal"] = "remainingTime",
            ["rightValue"] = 300,
            ["leftTriggerId"] = "1730362444_7v5Blhp1",
            ["operator"] = "<",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "borderGlow",
            ["status"] = true,
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360557_vCpXkAFx",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 3,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730360557_Nf3azueK",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            {
            ["id"] = "1730362444_7v5Blhp1",
            ["type"] = "aura",
            ["confine"] = {
            ["target"] = "player",
            ["type"] = "buff",
            ["spellId"] = 1459,
            },
            ["condition"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 2,
            ["extraAttr"] = {
            ["id"] = 1459,
            ["type"] = 4,
            ["name"] = "奥术智慧",
            ["icon"] = 135932,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360585_oNKldwju",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360585_oNKldwju",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360585_J07hs0hu",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 2,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [1]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730360585_oNKldwju",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 190336,
            ["type"] = 4,
            ["name"] = "造餐术",
            ["icon"] = 134029,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360596_udrM1iam",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360596_udrM1iam",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360596_kW5z5OyM",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 2,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [2]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730360596_udrM1iam",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 130,
            ["type"] = 4,
            ["name"] = "缓落术",
            ["icon"] = 135992,
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "626001",
            ["isDisplayMouseEnter"] = false,
            ["configSelectedTriggerIndex"] = 1,
            ["type"] = 4,
            ["attachFrame"] = "UIParent",
            ["anchorPos"] = "CENTER",
            ["id"] = "1730282446_NR2ciXuC",
            ["attachFrameAnchorPos"] = "CENTER",
            ["combatLoadCond"] = 2,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["ClassCond"] = {
            8,
            },
            },
            ["isUseRootTexts"] = true,
            ["isDisplayUnLearned"] = false,
            ["title"] = "法师",
            ["triggers"] = {
            {
            ["id"] = "1730282446_UjCoFpdC",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedCondIndex"] = 1,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730347466_unHZP9mL",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730347466_unHZP9mL",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftVal"] = "remainingTime",
            ["rightValue"] = 300,
            ["leftTriggerId"] = "1730453940_CLT0kSS4",
            ["operator"] = "<=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            },
            {
            ["attr"] = {
            },
            ["type"] = "borderGlow",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730347466_G9lHgVTs",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 3,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["configSelectedTriggerIndex"] = 2,
            ["title"] = "物品",
            ["triggers"] = {
            {
            ["id"] = "1730347466_unHZP9mL",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            {
            ["id"] = "1730453940_CLT0kSS4",
            ["type"] = "aura",
            ["confine"] = {
            ["target"] = "player",
            ["type"] = "buff",
            ["spellId"] = 6673,
            },
            ["condition"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 6673,
            ["type"] = 4,
            ["name"] = "战斗怒吼",
            ["icon"] = 132333,
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "626008",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730347457_c12wuUNo",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["ClassCond"] = {
            1,
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "战士",
            ["triggers"] = {
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358065_GI3SpmmR",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358065_GI3SpmmR",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730358065_YiIumgtS",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 2,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品",
            ["triggers"] = {
            {
            ["id"] = "1730358065_GI3SpmmR",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 1804,
            ["type"] = 4,
            ["name"] = "开锁",
            ["icon"] = 136058,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358086_R87UX9AO",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358086_R87UX9AO",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730358086_wKDbROae",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 2,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品 [1]",
            ["triggers"] = {
            {
            ["id"] = "1730358086_R87UX9AO",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 315584,
            ["type"] = 4,
            ["name"] = "速效药膏",
            ["icon"] = 132273,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358093_amsukPpU",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358093_amsukPpU",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730358093_TLW87MQR",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品 [2]",
            ["triggers"] = {
            {
            ["id"] = "1730358093_amsukPpU",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 8679,
            ["type"] = 4,
            ["name"] = "致伤药膏",
            ["icon"] = 134197,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358105_U3rpOKTf",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358105_U3rpOKTf",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730358105_GHbykSmp",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品 [3]",
            ["triggers"] = {
            {
            ["id"] = "1730358105_U3rpOKTf",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 3408,
            ["type"] = 4,
            ["name"] = "减速药膏",
            ["icon"] = 132274,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358127_gypUwtY7",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358127_gypUwtY7",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730358127_ar2QnuDY",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品 [4]",
            ["triggers"] = {
            {
            ["id"] = "1730358127_gypUwtY7",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 381637,
            ["type"] = 4,
            ["name"] = "萎缩药膏",
            ["icon"] = 132300,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358172_MblS61kg",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358172_MblS61kg",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730358172_cGkvZVmQ",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品 [5]",
            ["triggers"] = {
            {
            ["id"] = "1730358172_MblS61kg",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 114018,
            ["type"] = 4,
            ["name"] = "潜伏帷幕",
            ["icon"] = 635350,
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "626005",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730358029_ekXYaoHM",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["ClassCond"] = {
            4,
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "盗贼",
            ["triggers"] = {
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730357728_O7nfoA0S",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730357728_O7nfoA0S",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftVal"] = "remainingTime",
            ["rightValue"] = 300,
            ["leftTriggerId"] = "1730368581_jlHhQZzw",
            ["operator"] = "<=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "borderGlow",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730357728_9UM82fB3",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 3,
            ["loadCond"] = {
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [1]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730357728_O7nfoA0S",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            {
            ["id"] = "1730368581_jlHhQZzw",
            ["type"] = "aura",
            ["confine"] = {
            ["target"] = "player",
            ["type"] = "buff",
            ["spellId"] = 381748,
            },
            ["condition"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 2,
            ["extraAttr"] = {
            ["id"] = 364342,
            ["type"] = 4,
            ["name"] = "青铜龙的祝福",
            ["icon"] = 4622448,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730357738_CILaPpGG",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730357738_CILaPpGG",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730357738_0d0OTMah",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 2,
            ["loadCond"] = {
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [2]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730357738_CILaPpGG",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 369459,
            ["type"] = 4,
            ["name"] = "魔力之源",
            ["icon"] = 4630412,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730357802_J5NKjlK0",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730357802_J5NKjlK0",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730357802_VDFSD8Lw",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 2,
            ["loadCond"] = {
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [3]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730357802_J5NKjlK0",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 361227,
            ["type"] = 4,
            ["name"] = "生还",
            ["icon"] = 4622472,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730357823_sOY8hQ7I",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730357823_sOY8hQ7I",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730357823_kFxkOY3Z",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 2,
            ["loadCond"] = {
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [4]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730357823_sOY8hQ7I",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 361178,
            ["type"] = 4,
            ["name"] = "群体生还",
            ["icon"] = 4622473,
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "4574311",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730357681_aXNpyXoC",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["ClassCond"] = {
            13,
            },
            },
            ["isUseRootTexts"] = true,
            ["title"] = "唤魔师",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358726_W4AXJweQ",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358726_W4AXJweQ",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftVal"] = "remainingTime",
            ["rightValue"] = 300,
            ["leftTriggerId"] = "1730454208_tMbnwsfo",
            ["operator"] = "<=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "borderGlow",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730358726_gNTlEz8N",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 3,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 2,
            ["title"] = "物品",
            ["triggers"] = {
            {
            ["id"] = "1730358726_W4AXJweQ",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            {
            ["id"] = "1730454208_tMbnwsfo",
            ["type"] = "aura",
            ["confine"] = {
            ["target"] = "player",
            ["type"] = "buff",
            ["spellId"] = 1126,
            },
            ["condition"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 1126,
            ["type"] = 4,
            ["name"] = "野性印记",
            ["icon"] = 136078,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358822_eIYjXMMk",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358822_eIYjXMMk",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730358822_T2Uvn6AY",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品 [1]",
            ["triggers"] = {
            {
            ["id"] = "1730358822_eIYjXMMk",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 212040,
            ["type"] = 4,
            ["name"] = "新生",
            ["icon"] = 132125,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358853_19SptgSO",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730358853_19SptgSO",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730358853_Y1YqDI6Q",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品 [2]",
            ["triggers"] = {
            {
            ["id"] = "1730358853_19SptgSO",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 50769,
            ["type"] = 4,
            ["name"] = "起死回生",
            ["icon"] = 132132,
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "625999",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730358699_iV4a5Q1e",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["ClassCond"] = {
            11,
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "德鲁伊",
            ["triggers"] = {
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359037_uxndfuqJ",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359037_uxndfuqJ",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359037_vBn5yKWZ",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 2,
            ["loadCond"] = {
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730359037_uxndfuqJ",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 465,
            ["type"] = 4,
            ["name"] = "虔诚光环",
            ["icon"] = 135893,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359072_7MCAMSf5",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359072_7MCAMSf5",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359072_CK299NvN",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [1]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730359072_7MCAMSf5",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 317920,
            ["type"] = 4,
            ["name"] = "专注光环",
            ["icon"] = 135933,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359104_WGeMXy57",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359104_WGeMXy57",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359104_hD8e1DH1",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [2]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730359104_WGeMXy57",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 32223,
            ["type"] = 4,
            ["name"] = "十字军光环",
            ["icon"] = 135890,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359121_qN4Tlzyd",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359121_qN4Tlzyd",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359121_ZpuZ2f2I",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [3]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730359121_qN4Tlzyd",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 53563,
            ["type"] = 4,
            ["name"] = "圣光道标",
            ["icon"] = 236247,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359128_00RyRQxa",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359128_00RyRQxa",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359128_vnhq9eNj",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [4]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730359128_00RyRQxa",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 156910,
            ["type"] = 4,
            ["name"] = "信仰道标",
            ["icon"] = 1030095,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359143_alIixzzF",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359143_alIixzzF",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359143_SkBtLa55",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [5]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730359143_alIixzzF",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 7328,
            ["type"] = 4,
            ["name"] = "救赎",
            ["icon"] = 135955,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359182_kbVaT7Sj",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359182_kbVaT7Sj",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359182_wzr3ZP6y",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [6]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730359182_kbVaT7Sj",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 212056,
            ["type"] = 4,
            ["name"] = "宽恕",
            ["icon"] = 1030102,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359199_fp6MdQEx",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359199_fp6MdQEx",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359199_f2IIYKKk",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [7]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730359199_fp6MdQEx",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 10326,
            ["type"] = 4,
            ["name"] = "超度邪恶",
            ["icon"] = 571559,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359224_ihROoVc4",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359224_ihROoVc4",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359224_ZuB99Znp",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [8]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730359224_ihROoVc4",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 5502,
            ["type"] = 4,
            ["name"] = "感知亡灵",
            ["icon"] = 135974,
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "626003",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359022_Om0w4ElE",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["ClassCond"] = {
            2,
            },
            },
            ["isUseRootTexts"] = true,
            ["title"] = "骑士",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359522_DPcKDYFl",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359522_DPcKDYFl",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359522_NgY6SUO2",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品",
            ["triggers"] = {
            {
            ["id"] = "1730359522_DPcKDYFl",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 6201,
            ["type"] = 4,
            ["name"] = "制造治疗石",
            ["icon"] = 538745,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359554_OzbCxngq",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359554_OzbCxngq",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359554_V6Uy151L",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品 [1]",
            ["triggers"] = {
            {
            ["id"] = "1730359554_OzbCxngq",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 29893,
            ["type"] = 4,
            ["name"] = "制造灵魂之井",
            ["icon"] = 136194,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359569_Nwj5zwW1",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359569_Nwj5zwW1",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359569_toKVDrLb",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品 [2]",
            ["triggers"] = {
            {
            ["id"] = "1730359569_Nwj5zwW1",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 698,
            ["type"] = 4,
            ["name"] = "召唤仪式",
            ["icon"] = 136223,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359588_IYbKoXUb",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359588_IYbKoXUb",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359588_esp5PwFi",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品 [3]",
            ["triggers"] = {
            {
            ["id"] = "1730359588_IYbKoXUb",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 5697,
            ["type"] = 4,
            ["name"] = "无尽呼吸",
            ["icon"] = 136148,
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "626007",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359502_lnlTU9SA",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["ClassCond"] = {
            9,
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "术士",
            ["triggers"] = {
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359969_qD2OieZf",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730359969_qD2OieZf",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftVal"] = "remainingTime",
            ["rightValue"] = 300,
            ["leftTriggerId"] = "1730448805_EpXzF6Ts",
            ["operator"] = "<=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "borderGlow",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359969_kB4DG9fT",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 3,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730359969_qD2OieZf",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            {
            ["id"] = "1730448805_EpXzF6Ts",
            ["type"] = "aura",
            ["confine"] = {
            ["target"] = "player",
            ["type"] = "buff",
            ["spellId"] = 52127,
            },
            ["condition"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 2,
            ["extraAttr"] = {
            ["id"] = 52127,
            ["type"] = 4,
            ["name"] = "水之护盾",
            ["icon"] = 132315,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360016_detMXXfX",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360016_detMXXfX",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360016_u64C3Pto",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [1]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730360016_detMXXfX",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 382021,
            ["type"] = 4,
            ["name"] = "大地生命武器",
            ["icon"] = 237578,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360029_91Kox07d",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360029_91Kox07d",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "borderGlow",
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftVal"] = "remainingTime",
            ["rightValue"] = 300,
            ["leftTriggerId"] = "1730442604_BylE2ph5",
            ["operator"] = "<=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "borderGlow",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360029_MbbFiDeJ",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 3,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [2]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730360029_91Kox07d",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            {
            ["id"] = "1730442604_BylE2ph5",
            ["type"] = "aura",
            ["confine"] = {
            ["target"] = "player",
            ["type"] = "buff",
            ["spellId"] = 462854,
            },
            ["condition"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 2,
            ["extraAttr"] = {
            ["id"] = 462854,
            ["type"] = 4,
            ["name"] = "天怒",
            ["icon"] = 4630367,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360043_dzmNMrkh",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360043_dzmNMrkh",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360043_YXLDkowt",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [3]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730360043_dzmNMrkh",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 2008,
            ["type"] = 4,
            ["name"] = "先祖之魂",
            ["icon"] = 136077,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360073_VhPBRE7z",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360073_VhPBRE7z",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360073_SkcpqMud",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品 [4]",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            {
            ["id"] = "1730360073_VhPBRE7z",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 212048,
            ["type"] = 4,
            ["name"] = "先祖视界",
            ["icon"] = 237576,
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "626006",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730359954_EzySfKUs",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            ["ClassCond"] = {
            7,
            },
            },
            ["isUseRootTexts"] = true,
            ["title"] = "萨满",
            ["attachFrame"] = "UIParent",
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360252_JFdlSGYb",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360252_JFdlSGYb",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftVal"] = "remainingTime",
            ["rightValue"] = 300,
            ["leftTriggerId"] = "1730702898_ng54ymuY",
            ["operator"] = "<=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "borderGlow",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360252_NNnk6gth",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 3,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 2,
            ["title"] = "物品",
            ["triggers"] = {
            {
            ["id"] = "1730360252_JFdlSGYb",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            {
            ["id"] = "1730702898_ng54ymuY",
            ["type"] = "aura",
            ["confine"] = {
            ["target"] = "player",
            ["type"] = "buff",
            ["spellId"] = 21562,
            },
            ["condition"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 21562,
            ["type"] = 4,
            ["name"] = "真言术：韧",
            ["icon"] = 135987,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360279_i7TpBDxz",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360279_i7TpBDxz",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360279_oPp6YxOR",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品 [1]",
            ["triggers"] = {
            {
            ["id"] = "1730360279_i7TpBDxz",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 212036,
            ["type"] = 4,
            ["name"] = "群体复活",
            ["icon"] = 413586,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360305_ipJ0ULbN",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360305_ipJ0ULbN",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360305_JL8H1Hxj",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品 [2]",
            ["triggers"] = {
            {
            ["id"] = "1730360305_ipJ0ULbN",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 2006,
            ["type"] = 4,
            ["name"] = "复活术",
            ["icon"] = 135955,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360315_W8fk44Oo",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360315_W8fk44Oo",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360315_UuU8Ad0P",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品 [3]",
            ["triggers"] = {
            {
            ["id"] = "1730360315_W8fk44Oo",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 1706,
            ["type"] = 4,
            ["name"] = "漂浮术",
            ["icon"] = 135928,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730702976_Uwf3adaU",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730702976_Uwf3adaU",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730702976_s91kXm54",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [4]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730702976_Uwf3adaU",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["extraAttr"] = {
            ["id"] = 453,
            ["type"] = 4,
            ["name"] = "安抚心灵",
            ["icon"] = 135933,
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "626004",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360219_5XeYvgSy",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["ClassCond"] = {
            5,
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "牧师",
            ["triggers"] = {
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360902_dw8NLDy9",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360902_dw8NLDy9",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360902_eXv16ro6",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品",
            ["triggers"] = {
            {
            ["id"] = "1730360902_dw8NLDy9",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 115178,
            ["type"] = 4,
            ["name"] = "轮回转世",
            ["icon"] = 132132,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360920_EIZjjvl3",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730360920_EIZjjvl3",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnDesaturate",
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360920_m8GY8fJG",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "物品 [1]",
            ["triggers"] = {
            {
            ["id"] = "1730360920_EIZjjvl3",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            ["id"] = 212051,
            ["type"] = 4,
            ["name"] = "死而复生",
            ["icon"] = 1056569,
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "626002",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360804_uJZLvpEO",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["ClassCond"] = {
            10,
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "武僧",
            ["triggers"] = {
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "135771",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360827_ye3OVXMV",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["ClassCond"] = {
            6,
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "死亡骑士",
            ["triggers"] = {
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "1260827",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360856_lzKDDf6W",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["ClassCond"] = {
            12,
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "恶魔猎手",
            ["triggers"] = {
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isLoad"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "626000",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["combatLoadCond"] = 2,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730360875_BnZg6TZs",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["ClassCond"] = {
            3,
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["title"] = "猎人",
            ["triggers"] = {
            },
            ["attachFrame"] = "UIParent",
            ["isUseRootTexts"] = true,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730454965_78VaZ9EK",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730454965_78VaZ9EK",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["attachFrame"] = "UIParent",
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730454965_RiipKU2L",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["isUseRootTexts"] = false,
            ["title"] = "物品",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730454965_78VaZ9EK",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 113509,
            ["type"] = 1,
            ["icon"] = 134029,
            ["name"] = "魔法汉堡",
            },
            ["texts"] = {
            {
            ["text"] = "%s",
            },
            },
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["attachFrame"] = "UIParent",
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "Interface\\AddOns\\HappyButton\\Media\\Logo64.blp",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 4,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730454957_LiHrlwO8",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["isUseRootTexts"] = true,
            ["title"] = "常用物品",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "RIGHTTOP",
            ["condGroups"] = {
            },
            ["isLoad"] = true,
            ["posX"] = 0,
            ["icon"] = "Interface\\AddOns\\HappyButton\\Media\\Logo64.blp",
            ["configSelectedTextIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["isDisplayMouseEnter"] = false,
            ["attachFrame"] = "CharacterFrame",
            ["type"] = 4,
            ["posY"] = 0,
            ["anchorPos"] = "BOTTOMLEFT",
            ["id"] = "1730282426_uvxa3BSu",
            ["attachFrameAnchorPos"] = "BOTTOMRIGHT",
            ["combatLoadCond"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["isUseRootTexts"] = true,
            ["isDisplayUnLearned"] = false,
            ["title"] = "全职业技能",
            ["triggers"] = {
            {
            ["id"] = "1730282426_70Xtfisl",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedCondIndex"] = 1,
            ["extraAttr"] = {
            },
            ["texts"] = {
            {
            ["text"] = "%n",
            },
            {
            ["text"] = "%s",
            },
            },
            },
            {
            ["elements"] = {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730529739_mhkahhdh",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730529739_mhkahhdh",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730529739_i4qfTxjS",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [1]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730529739_mhkahhdh",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["extraAttr"] = {
            ["id"] = 64488,
            ["type"] = 3,
            ["icon"] = 458254,
            ["name"] = "旅店老板的女儿",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730529748_dvFWvLny",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730529748_dvFWvLny",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730529748_Unud7nfe",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [2]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730529748_dvFWvLny",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["extraAttr"] = {
            ["id"] = 168907,
            ["type"] = 3,
            ["icon"] = 2491049,
            ["name"] = "全息数字化炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730529759_hnxx2orQ",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730529759_hnxx2orQ",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730529759_zjI54AJt",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [3]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730529759_hnxx2orQ",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["extraAttr"] = {
            ["id"] = 172179,
            ["type"] = 3,
            ["icon"] = 3084684,
            ["name"] = "永恒旅者的炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730529775_FaBeT9Sj",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730529775_FaBeT9Sj",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730529775_tOMQJSQB",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [4]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730529775_FaBeT9Sj",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["extraAttr"] = {
            ["id"] = 184353,
            ["type"] = 3,
            ["icon"] = 3257748,
            ["name"] = "格里恩炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730529789_ZxhCxvEt",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730529789_ZxhCxvEt",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730529789_OwYKTH36",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [5]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730529789_ZxhCxvEt",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["extraAttr"] = {
            ["id"] = 180290,
            ["type"] = 3,
            ["icon"] = 3489827,
            ["name"] = "法夜炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730529806_iif59kxL",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730529806_iif59kxL",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730529806_bgQlTbr9",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [6]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730529806_iif59kxL",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["extraAttr"] = {
            ["id"] = 182773,
            ["type"] = 3,
            ["icon"] = 3716927,
            ["name"] = "通灵领主炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730530603_JMRN9av4",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730530603_JMRN9av4",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730530603_aAeTNOXA",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [7]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730530603_JMRN9av4",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 188952,
            ["type"] = 3,
            ["name"] = "被统御的炉石",
            ["icon"] = 3528303,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730530617_NFCWW5jk",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730530617_NFCWW5jk",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730530617_wICUjMke",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [8]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730530617_NFCWW5jk",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 183716,
            ["type"] = 3,
            ["name"] = "温西尔罪碑",
            ["icon"] = 3514225,
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532125_AZXq6j8G",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532125_AZXq6j8G",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730532125_BSP6Hizg",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [9]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730532125_AZXq6j8G",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 190237,
            ["type"] = 3,
            ["icon"] = 3954409,
            ["name"] = "掮灵传送矩阵",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532143_FPvSvjDX",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532143_FPvSvjDX",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730532143_iZyC2bNu",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [10]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730532143_FPvSvjDX",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 193588,
            ["type"] = 3,
            ["icon"] = 4571434,
            ["name"] = "时光旅行者的炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532151_Ov2yJry4",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532151_Ov2yJry4",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730532151_exGC01vE",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [11]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730532151_Ov2yJry4",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 200630,
            ["type"] = 3,
            ["icon"] = 4080564,
            ["name"] = "欧恩伊尔轻风贤者的炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532165_uJn4TvX8",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532165_uJn4TvX8",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730532165_Ix1Ki9pn",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [12]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730532165_uJn4TvX8",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 208704,
            ["type"] = 3,
            ["icon"] = 5333528,
            ["name"] = "幽邃住民的土灵炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532177_nbRfBZs8",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532177_nbRfBZs8",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730532177_70pK0HUD",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [13]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730532177_nbRfBZs8",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 209035,
            ["type"] = 3,
            ["icon"] = 2491064,
            ["name"] = "烈焰炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532191_A8fhTLBS",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532191_A8fhTLBS",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730532191_TaGpGcR0",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [14]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730532191_A8fhTLBS",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 162973,
            ["type"] = 3,
            ["icon"] = 2124576,
            ["name"] = "冬天爷爷的炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532200_Hq1bUX3R",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532200_Hq1bUX3R",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730532200_ulKd5dF9",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [15]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730532200_Hq1bUX3R",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 166746,
            ["type"] = 3,
            ["icon"] = 2491064,
            ["name"] = "吞火者的炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532212_LnYZ22YR",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532212_LnYZ22YR",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730532212_w1borxre",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [16]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730532212_LnYZ22YR",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 165802,
            ["type"] = 3,
            ["icon"] = 2491065,
            ["name"] = "复活节的炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532222_OL5k9EGY",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532222_OL5k9EGY",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730532222_kexnW37R",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [17]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730532222_OL5k9EGY",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 165670,
            ["type"] = 3,
            ["icon"] = 2491048,
            ["name"] = "小匹德菲特的可爱炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532234_8J2bIfVY",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532234_8J2bIfVY",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730532234_hu06lEQb",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [18]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730532234_8J2bIfVY",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 163045,
            ["type"] = 3,
            ["icon"] = 2124575,
            ["name"] = "无头骑士的炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532245_274lElvr",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532245_274lElvr",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730532245_MfzbsAHA",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [19]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730532245_274lElvr",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 165669,
            ["type"] = 3,
            ["icon"] = 2491049,
            ["name"] = "春节长者的炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532253_cutzlKeG",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532253_cutzlKeG",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730532253_3APnrV2K",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [20]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730532253_cutzlKeG",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 166747,
            ["type"] = 3,
            ["icon"] = 2491063,
            ["name"] = "美酒节狂欢者的炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532277_naJXKTGm",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532277_naJXKTGm",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730532277_FiK3QEze",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [22]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730532277_naJXKTGm",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 212337,
            ["type"] = 3,
            ["icon"] = 5524923,
            ["name"] = "炉之石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532266_CjOh7INx",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1730532266_CjOh7INx",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1730532266_FbBtpU8I",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [21]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1730532266_CjOh7INx",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 228940,
            ["type"] = 3,
            ["icon"] = 5891370,
            ["name"] = "恶名丝线炉石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1731126038_toXv0xuJ",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1731126038_toXv0xuJ",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            ["expression"] = "%cond.1",
            },
            },
            ["attachFrame"] = "UIParent",
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1731126038_FOLLzMf0",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["isUseRootTexts"] = true,
            ["title"] = "物品",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1731126038_toXv0xuJ",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["extraAttr"] = {
            ["id"] = 6948,
            ["type"] = 1,
            ["icon"] = 134414,
            ["name"] = "炉石",
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "134414",
            ["isDisplayMouseEnter"] = false,
            ["isShowQualityBorder"] = true,
            ["type"] = 2,
            ["iconWidth"] = 43,
            ["anchorPos"] = "BOTTOMLEFT",
            ["id"] = "1730529332_DvGVXzUo",
            ["attachFrameAnchorPos"] = "TOPLEFT",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 0,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "GameMenuFrame",
            ["title"] = "随机炉石",
            ["iconHeight"] = 43,
            ["configSelectedTriggerIndex"] = 0,
            ["triggers"] = {
            },
            ["extraAttr"] = {
            ["configSelectedItemIndex"] = 23,
            ["mode"] = 1,
            },
            ["texts"] = {
            {
            ["text"] = "%n",
            },
            {
            ["text"] = "%s",
            },
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1731547969_labceIaC",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "borderGlow",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1731547969_labceIaC",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["attachFrame"] = "CharacterFrame",
            ["isShowQualityBorder"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "Interface\\AddOns\\HappyButton\\Media\\Logo64.blp",
            ["isDisplayMouseEnter"] = false,
            ["configSelectedCondIndex"] = 1,
            ["type"] = 3,
            ["triggers"] = {
            {
            ["id"] = "1731547969_labceIaC",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["anchorPos"] = "TOPLEFT",
            ["id"] = "1731547969_bgmTgY4t",
            ["listenEvents"] = {
            ["BAG_UPDATE"] = {
            },
            },
            ["configSelectedTriggerIndex"] = 1,
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["isUseRootTexts"] = true,
            ["title"] = "消耗品",
            ["iconHeight"] = 36,
            ["attachFrameAnchorPos"] = "TOPRIGHT",
            ["iconWidth"] = 36,
            ["extraAttr"] = {
            ["script"] = "----------------------------------\n-- 根据物品类型查找物品列表\n----------------------------------\nreturn function()\n    local function isInArray(array, element)\n        for i = 1, #array do\n            if array[i] == element then\n                return true\n            end\n        end\n        return false\n    end\n\n    local function GetItemsByclassId(classId, subclassIds)\n        local GetItemInfo = (C_Item and C_Item.GetItemInfo) and C_Item.GetItemInfo or GetItemInfo\n        local items = {} ---@type table[]\n        local itemIds = {} ---@type table<number, true>\n        for bag = 0, NUM_BAG_SLOTS do\n            local size = C_Container.GetContainerNumSlots(bag)\n            for slot = 1, size do\n                local itemID = C_Container.GetContainerItemID(bag, slot)\n                if itemID then\n                    local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expansionID, setID, isCraftingReagent = GetItemInfo(itemID)\n                    local isClassIdItem = (classID and classID == classId)\n                    if isClassIdItem and itemIds[itemID] == nil then\n                        if subclassIds == nil or isInArray(subclassIds, subclassID) then\n                            table.insert(items, {\n                                icon = itemTexture,\n                                text = itemName,\n                                item = {\n                                    id = itemID,\n                                    icon = itemTexture,\n                                    name = itemName,\n                                    type = 1\n                                }\n                            })\n                            itemIds[itemID] = true\n                        end\n                    end\n                end\n            end\n        end\n        return items\n    end\n    return GetItemsByclassId(0) -- 消耗品\nend",
            },
            ["texts"] = {
            {
            ["text"] = "%s",
            },
            {
            ["text"] = "%n",
            },
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "TOPRIGHT",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1731547969_labceIaC",
            ["rightValue"] = false,
            ["leftVal"] = "isLearned",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "borderGlow",
            ["status"] = true,
            },
            },
            },
            {
            ["conditions"] = {
            {
            ["leftTriggerId"] = "1731547969_labceIaC",
            ["rightValue"] = false,
            ["leftVal"] = "isUsable",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnVertexColor",
            ["status"] = true,
            },
            },
            },
            },
            ["attachFrame"] = "GameMenuFrame",
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "Interface\\AddOns\\HappyButton\\Media\\Logo64.blp",
            ["isDisplayMouseEnter"] = false,
            ["triggers"] = {
            {
            ["id"] = "1731547969_labceIaC",
            ["type"] = "self",
            ["confine"] = {
            },
            },
            },
            ["type"] = 3,
            ["iconWidth"] = 36,
            ["anchorPos"] = "BOTTOMLEFT",
            ["id"] = "1736391761_yf5Rx2gK",
            ["attachFrameAnchorPos"] = "BOTTOMRIGHT",
            ["listenEvents"] = {
            ["BAG_UPDATE"] = {
            },
            },
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["isUseRootTexts"] = true,
            ["title"] = "Food & Drink",
            ["iconHeight"] = 36,
            ["configSelectedTriggerIndex"] = 1,
            ["configSelectedCondIndex"] = 1,
            ["extraAttr"] = {
            ["script"] = "----------------------------------\n-- 根据物品类型查找物品列表\n----------------------------------\nreturn function()\n    local function isInArray(array, element)\n        for i = 1, #array do\n            if array[i] == element then\n                return true\n            end\n        end\n        return false\n    end\n\n    local GetItemInfo = (C_Item and C_Item.GetItemInfo) and C_Item.GetItemInfo or GetItemInfo\n    local IsUsableItem = (C_Item and C_Item.IsUsableItem) and C_Item.IsUsableItem or IsUsableItem\n\n    ---@param classId number 物品类别\n    ---@param subclassIds table || nil 物品子类别\n    ---@param isUsable boolean || nil 是否可使用\n    local function GetItems(classId, subclassIds, isUsable)\n        local items = {} ---@type table[]\n        local itemIds = {} ---@type table<number, true>\n        for bag = 0, NUM_BAG_SLOTS do\n            local size = C_Container.GetContainerNumSlots(bag)\n            for slot = 1, size do\n                local itemID = C_Container.GetContainerItemID(bag, slot)\n                if itemID then\n                    local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expansionID, setID, isCraftingReagent = GetItemInfo(itemID)\n                    local isClassIdItem = (classID and classID == classId)\n                    if isClassIdItem and itemIds[itemID] == nil then\n                        if subclassIds == nil or isInArray(subclassIds, subclassID) then\n                            if isUsable == nil or select(1, IsUsableItem(itemID) == isUsable) then\n                                table.insert(items, {\n                                    icon = itemTexture,\n                                    text = itemName,\n                                    item = {\n                                        id = itemID,\n                                        icon = itemTexture,\n                                        name = itemName,\n                                        type = 1\n                                    }\n                                })\n                                itemIds[itemID] = true\n                            end\n                        end\n                    end\n                end\n            end\n        end\n        return items\n    end\n    return GetItems(0, {5}) -- 消耗品\nend\n",
            },
            ["texts"] = {
            {
            ["text"] = "%s",
            },
            {
            ["text"] = "%n",
            },
            },
            },
            {
            ["elements"] = {
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155233_yFW3N0ZC",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 228773,
            ["type"] = 1,
            ["icon"] = 3615513,
            ["name"] = "阿加炼金师的笔记本",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155246_AzIWRp25",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [1]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 225234,
            ["type"] = 1,
            ["icon"] = 134386,
            ["name"] = "炼金沉淀物",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155251_Ds8H0C2H",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [2]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 225235,
            ["type"] = 1,
            ["icon"] = 1017866,
            ["name"] = "深石熔炉",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155264_VwPSAevw",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [3]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 228724,
            ["type"] = 1,
            ["icon"] = 4914670,
            ["name"] = "炼金知识烁光",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155292_qC8jaa5o",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [4]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 228725,
            ["type"] = 1,
            ["icon"] = 5976939,
            ["name"] = "炼金知识闪光",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155368_OIsJSki7",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [5]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 228774,
            ["type"] = 1,
            ["icon"] = 4624659,
            ["name"] = "阿加铁匠日志",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155381_Kgg9Xkrm",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [6]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 225232,
            ["type"] = 1,
            ["icon"] = 237047,
            ["name"] = "心核隧途坯料",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155384_kBKJLV8i",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [7]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 225233,
            ["type"] = 1,
            ["icon"] = 135252,
            ["name"] = "致密刀石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155399_JzBP9aiq",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [8]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 228726,
            ["type"] = 1,
            ["icon"] = 4914670,
            ["name"] = "锻造知识烁光",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155406_Y1nTDmoo",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [9]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 228727,
            ["type"] = 1,
            ["icon"] = 5976939,
            ["name"] = "锻造知识闪光",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155429_VEn4Ci58",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [10]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 227667,
            ["type"] = 1,
            ["icon"] = 3615911,
            ["name"] = "阿加附魔师对开纸",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155439_CjwDo1T5",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [11]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 227659,
            ["type"] = 1,
            ["icon"] = 5929585,
            ["name"] = "瞬息奥术具象",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155447_QE61kl3i",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [12]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 227661,
            ["type"] = 1,
            ["icon"] = 4549100,
            ["name"] = "流光陆生水晶",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155454_CAHw58yg",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [13]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 225231,
            ["type"] = 1,
            ["icon"] = 1003595,
            ["name"] = "粉尘之耀",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155462_fQFHs2WP",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [14]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 225230,
            ["type"] = 1,
            ["icon"] = 133242,
            ["name"] = "晶化储存器",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155469_VC6lJ4LK",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [15]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 227662,
            ["type"] = 1,
            ["icon"] = 5929577,
            ["name"] = "荧光粉",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155485_6wqj09L5",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [16]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 228775,
            ["type"] = 1,
            ["icon"] = 4624728,
            ["name"] = "阿加工程师的记事本",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155495_In794atA",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [17]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 225228,
            ["type"] = 1,
            ["icon"] = 133872,
            ["name"] = "被锈蚀封住的机关",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155502_u5b2LSWD",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [18]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 225229,
            ["type"] = 1,
            ["icon"] = 134065,
            ["name"] = "土灵感应线圈",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155510_nsQqaaYB",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [19]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 228730,
            ["type"] = 1,
            ["icon"] = 4914670,
            ["name"] = "工程学知识烁光",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155517_xvZgSlVr",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [20]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 228731,
            ["type"] = 1,
            ["icon"] = 5976939,
            ["name"] = "工程学知识闪光",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155616_DdHPEqBV",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [21]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            },
            ["extraAttr"] = {
            ["id"] = 224817,
            ["type"] = 1,
            ["icon"] = 4624733,
            ["name"] = "阿加草药师笔记",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155626_lrfgJvLX",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [22]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            },
            ["extraAttr"] = {
            ["id"] = 224264,
            ["type"] = 1,
            ["icon"] = 3502462,
            ["name"] = "深林花瓣",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155634_fRoxAP86",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [23]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            },
            ["extraAttr"] = {
            ["id"] = 224265,
            ["type"] = 1,
            ["icon"] = 339292,
            ["name"] = "深林玫瑰",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155642_YihOuilV",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [24]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            },
            ["extraAttr"] = {
            ["id"] = 224835,
            ["type"] = 1,
            ["icon"] = 960689,
            ["name"] = "深林根须",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155678_yjsbTl4l",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [25]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            },
            ["extraAttr"] = {
            ["id"] = 228776,
            ["type"] = 1,
            ["icon"] = 4624734,
            ["name"] = "阿加铭文师日志",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155688_2BN5eDBN",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [26]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            },
            ["extraAttr"] = {
            ["id"] = 225226,
            ["type"] = 1,
            ["icon"] = 3764220,
            ["name"] = "条纹墨石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155692_o6dnukqz",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [27]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            },
            ["extraAttr"] = {
            ["id"] = 225227,
            ["type"] = 1,
            ["icon"] = 133458,
            ["name"] = "蜡封记录",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155702_LvyVKRk3",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [28]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            },
            ["extraAttr"] = {
            ["id"] = 228732,
            ["type"] = 1,
            ["icon"] = 4914670,
            ["name"] = "铭文知识烁光",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155714_KVGzjOrx",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [29]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            },
            ["extraAttr"] = {
            ["id"] = 228733,
            ["type"] = 1,
            ["icon"] = 5976939,
            ["name"] = "铭文知识闪光",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155739_tcyPqJQ0",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [30]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            },
            ["extraAttr"] = {
            ["id"] = 228777,
            ["type"] = 1,
            ["icon"] = 3615519,
            ["name"] = "阿加珠宝匠的笔记本",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155748_BFT7A01L",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [31]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            },
            ["extraAttr"] = {
            ["id"] = 225224,
            ["type"] = 1,
            ["icon"] = 1379187,
            ["name"] = "透光宝石碎块",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155751_SihddJsZ",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [32]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            },
            ["extraAttr"] = {
            ["id"] = 225225,
            ["type"] = 1,
            ["icon"] = 628559,
            ["name"] = "深海之石碎片",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155760_uRXpudjm",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [33]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            },
            ["extraAttr"] = {
            ["id"] = 228734,
            ["type"] = 1,
            ["icon"] = 4914670,
            ["name"] = "珠宝加工知识烁光",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155765_l5qWMFmQ",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [34]",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            },
            ["extraAttr"] = {
            ["id"] = 228735,
            ["type"] = 1,
            ["icon"] = 5976939,
            ["name"] = "珠宝加工知识闪光",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155840_642W4Vhu",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [35]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 228778,
            ["type"] = 1,
            ["icon"] = 3615520,
            ["name"] = "阿加制皮匠日志",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155848_Et1Eh9fY",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [36]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 225222,
            ["type"] = 1,
            ["icon"] = 4631327,
            ["name"] = "石革样品",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155851_cgLIcpw8",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [37]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 225223,
            ["type"] = 1,
            ["icon"] = 135035,
            ["name"] = "坚固蛛魔甲壳",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155863_YEe2SfzY",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [38]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 228736,
            ["type"] = 1,
            ["icon"] = 4914670,
            ["name"] = "制皮知识烁光",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155869_YQVG8gfF",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [39]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 228737,
            ["type"] = 1,
            ["icon"] = 5976939,
            ["name"] = "制皮知识闪光",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155880_nXmIHcS3",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [40]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 224818,
            ["type"] = 1,
            ["icon"] = 4625027,
            ["name"] = "阿加矿工笔记",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155896_3fKGeJN6",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [41]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 224583,
            ["type"] = 1,
            ["icon"] = 134562,
            ["name"] = "板岩之石",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155903_WvE63rJD",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [42]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 224584,
            ["type"] = 1,
            ["icon"] = 134564,
            ["name"] = "因侵蚀而抛光的板岩",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155912_SHfwefAn",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [43]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 224838,
            ["type"] = 1,
            ["icon"] = 4549118,
            ["name"] = "虚无裂片",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155925_TwOWmtWp",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [44]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 224807,
            ["type"] = 1,
            ["icon"] = 4625106,
            ["name"] = "阿加剥皮师笔记",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155938_ILQNDi3e",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [45]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 224780,
            ["type"] = 1,
            ["icon"] = 5931379,
            ["name"] = "韧化的风暴毛皮",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155941_TkwrccNw",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [46]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 224781,
            ["type"] = 1,
            ["icon"] = 237420,
            ["name"] = "深渊毛皮",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155949_vw3w73aQ",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [47]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 224782,
            ["type"] = 1,
            ["icon"] = 1508520,
            ["name"] = "锋利之爪",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155960_9yISi6Fb",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [48]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 228779,
            ["type"] = 1,
            ["icon"] = 3615520,
            ["name"] = "阿加裁缝的笔记本",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155968_D0LWOJ4A",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [49]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 225220,
            ["type"] = 1,
            ["icon"] = 4549274,
            ["name"] = "几丁质骨针",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155971_OBWyzbN4",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [50]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 225221,
            ["type"] = 1,
            ["icon"] = 134479,
            ["name"] = "网纹纺锤",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155980_YY1GsACB",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [51]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 228738,
            ["type"] = 1,
            ["icon"] = 4914670,
            ["name"] = "裁缝知识烁光",
            },
            ["texts"] = {
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = 134400,
            ["isDisplayMouseEnter"] = false,
            ["type"] = 1,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734155985_RlvFFeqd",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "物品 [52]",
            ["configSelectedCondIndex"] = 1,
            ["triggers"] = {
            },
            ["configSelectedTriggerIndex"] = 1,
            ["extraAttr"] = {
            ["id"] = 228739,
            ["type"] = 1,
            ["icon"] = 5976939,
            ["name"] = "裁缝知识闪光",
            },
            ["texts"] = {
            },
            },
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            {
            ["conditions"] = {
            {
            ["leftVal"] = "isLearned",
            ["rightValue"] = false,
            ["leftTriggerId"] = "1734158358_OQgNUKOZ",
            ["operator"] = "=",
            },
            },
            ["expression"] = "%cond.1",
            ["effects"] = {
            {
            ["attr"] = {
            },
            ["type"] = "btnHide",
            ["status"] = true,
            },
            {
            ["attr"] = {
            },
            ["type"] = "borderGlow",
            ["status"] = true,
            },
            },
            },
            },
            ["attachFrame"] = "CharacterFrame",
            ["posX"] = 0,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "Interface\\AddOns\\HappyButton\\Media\\Logo64.blp",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 2,
            ["posY"] = 0,
            ["anchorPos"] = "LEFT",
            ["id"] = "1734154932_8Z1kmXPi",
            ["attachFrameAnchorPos"] = "RIGHT",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["isUseRootTexts"] = true,
            ["title"] = "专业物品",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            {
            ["id"] = "1734158358_OQgNUKOZ",
            ["type"] = "self",
            ["confine"] = {
            },
            ["condition"] = {
            },
            },
            },
            ["extraAttr"] = {
            ["configSelectedItemIndex"] = 53,
            ["mode"] = 1,
            },
            ["texts"] = {
            {
            ["text"] = "%s",
            },
            {
            ["text"] = "%n",
            },
            },
            },
            {
            ["elements"] = {
            },
            ["elesGrowth"] = "RIGHTBOTTOM",
            ["condGroups"] = {
            },
            ["isUseRootTexts"] = true,
            ["posX"] = -18,
            ["configSelectedTextIndex"] = 1,
            ["icon"] = "Interface\\AddOns\\HappyButton\\Media\\Logo64.blp",
            ["isDisplayMouseEnter"] = false,
            ["type"] = 3,
            ["posY"] = -347,
            ["anchorPos"] = "CENTER",
            ["id"] = "1734681853_dKaIJtC8",
            ["attachFrameAnchorPos"] = "CENTER",
            ["configSelectedCondGroupIndex"] = 1,
            ["loadCond"] = {
            ["LoadCond"] = true,
            },
            ["attachFrame"] = "UIParent",
            ["title"] = "可点击任务物品",
            ["configSelectedCondIndex"] = 1,
            ["configSelectedTriggerIndex"] = 1,
            ["triggers"] = {
            },
            ["extraAttr"] = {
            ["script"] = "----------------------------------\n-- 获取可以点击的任务物品\n----------------------------------\nreturn function()\n    local function GetQuestItems()\n        ---@diagnostic disable-next-line: deprecated\n        local GetItemInfo = (C_Item and C_Item.GetItemInfo) and C_Item.GetItemInfo or GetItemInfo\n        ---@diagnostic disable-next-line: deprecated\n        local IsUsableItem = (C_Item and C_Item.IsUsableItem) and C_Item.IsUsableItem or IsUsableItem\n        local items = {} ---@type table[]\n        local itemIds = {} ---@type table<number, true>\n        for bag = 0, NUM_BAG_SLOTS do\n            local size = C_Container.GetContainerNumSlots(bag)\n            for slot = 1, size do\n                local itemID = C_Container.GetContainerItemID(bag, slot)\n                if itemID then\n                    local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expansionID, setID, isCraftingReagent = GetItemInfo(itemID)\n                    if bindType == 4 and itemIds[itemID] == nil then\n                        local usable, _ = IsUsableItem(itemID)\n                        if usable then\n                            table.insert(items, {\n                                icon = itemTexture,\n                                text = itemName,\n                                item = {\n                                    id = itemID,\n                                    icon = itemTexture,\n                                    name = itemName,\n                                    type = 1\n                                }\n                            })\n                            itemIds[itemID] = true\n                        end\n                    end\n                end\n            end\n        end\n        return items\n    end\n    return GetQuestItems()\nend",
            },
            ["texts"] = {
            },
            },
            },
        elesGrowth = const.GROWTH.RIGHTBOTTOM,
        attachFrame = const.ATTACH_FRAME.UIParent,
        anchorPos = const.ANCHOR_POS.CENTER,
        attachFrameAnchorPos = const.ANCHOR_POS.CENTER,
        loadCond = {
            LoadCond = true,
        },
        isUseRootTexts = true,
        texts = {},
        configSelectedTextIndex = 1,
        triggers = {},
        configSelectedTriggerIndex = 1,
        condGroups = {},
        configSelectedCondGroupIndex = 1,
        configSelectedCondIndex = 1,
    }
    return config
end

---@private
---@param config ElementConfig
---@return ElementConfig
function E:InitExtraAttr(config)
    if config.extraAttr == nil then
        config.extraAttr = {}
    end
    return config
end

---@param config ElementConfig
---@return ScriptConfig
function E:ToScript(config)
    return E:InitExtraAttr(config) ---@type ScriptConfig
end

---@param config ElementConfig
---@return MacroConfig
function E:ToMacro(config)
    return E:InitExtraAttr(config) ---@type MacroConfig
end

---@param config ElementConfig
---@return ItemGroupConfig
function E:ToItemGroup(config)
    return E:InitExtraAttr(config) ---@type ItemGroupConfig
end

---@param config ElementConfig
---@return ItemConfig
function E:ToItem(config)
    return E:InitExtraAttr(config) ---@type ItemConfig
end

---@param title string
---@return ItemGroupConfig
function E:NewItemGroup(title)
    local e = E:New(title, const.ELEMENT_TYPE.ITEM_GROUP)
    e = E:ToItemGroup(e)
    e.extraAttr.mode = const.ITEMS_GROUP_MODE.RANDOM
    e.extraAttr.configSelectedItemIndex = 1
    return e
end

---@param config ElementConfig
---@return BarConfig
function E:ToBar(config)
    return E:InitExtraAttr(config) ---@type BarConfig
end

-- 是否是叶子节点
---@param config ElementConfig
---@return boolean
function E:IsLeaf(config)
    if config.type == const.ELEMENT_TYPE.ITEM or config.type == const.ELEMENT_TYPE.ITEM_GROUP or config.type == const.ELEMENT_TYPE.SCRIPT or config.type == const.ELEMENT_TYPE.MACRO then
        return true
    end
    return false
end

-- 是否是单一图标
---@param config ElementConfig
---@return boolean
function E:IsSingleIconConfig(config)
    if config.type == const.ELEMENT_TYPE.BAR or config.type == const.ELEMENT_TYPE.SCRIPT then
        return false
    else
        return true
    end
end


--- 获取config带图标的标题，使用在配置功能中
---@param config ElementConfig
---@return string
function E:GetTitleWithIcon(config)
    local icon = config.icon or 134400
    local iconPath = "|T" .. icon .. ":16|t"
    return iconPath .. config.title
end

--- 获取ItemAttr的Event列表
---@param itemAttr ItemAttr
---@return table<EventString, any[][]>
function E:GetItemAttrEvents(itemAttr)
    ---@type table<string, any[]>
    local events = {}
    if itemAttr == nil then
        return events
    end
    if itemAttr.type == const.ITEM_TYPE.ITEM then
        events["BAG_UPDATE"] = {}
        events["UNIT_SPELLCAST_SUCCEEDED"] = {{"player"}, }
        return events
    end
    if itemAttr.type == const.ITEM_TYPE.EQUIPMENT then
        events["BAG_UPDATE"] = {}
        events["PLAYER_EQUIPMENT_CHANGED"] = {}
        events["UNIT_SPELLCAST_SUCCEEDED"] = {{"player"}, }
        return events
    end
    if itemAttr.type == const.ITEM_TYPE.TOY then
        events["NEW_TOY_ADDED"] = {}
        events["UNIT_SPELLCAST_SUCCEEDED"] = {{"player"}, }
        return events
    end
    if itemAttr.type == const.ITEM_TYPE.SPELL then
        events["SPELLS_CHANGED"] = {}
        events["UNIT_SPELLCAST_SUCCEEDED"] = {{"player"}, }
        events["SPELL_UPDATE_CHARGES"] = {}
        events[const.EVENT.HB_GCD_UPDATE] = {}
        return events
    end
    if itemAttr.type == const.ITEM_TYPE.MOUNT then
        events["MOUNT_JOURNAL_USABILITY_CHANGED"] = {}
        events["NEW_MOUNT_ADDED"] = {}
        return events
    end
    if itemAttr.type == const.ITEM_TYPE.PET then
        events["PET_BAR_UPDATE_COOLDOWN"] = {}
        events["NEW_PET_ADDED"] = {}
        events["UNIT_SPELLCAST_SUCCEEDED"] = {{"player"}, }
        return events
    end
    return events
end

--- 获取Macro的event列表
---@param macroAttr MacroAttr
---@return table<EventString, any[][]>
function E:GetMacroEvents(macroAttr)
    local events = {}
    if macroAttr.ast == nil then
        return events
    end
    if macroAttr.ast.tooltip ~= nil then
        E:MergeEvents(events, E:GetItemAttrEvents(macroAttr.ast.tooltip))
    end
    if macroAttr.ast.commands == nil then
        return events
    end
    for _, command in ipairs(macroAttr.ast.commands) do
        if command.conds then
            for _, cond in ipairs(command.conds) do
                if cond and cond.booleanConds then
                    for _, booleanCond in ipairs(cond.booleanConds) do
                        if booleanCond.type == "mod" then
                            E:MergeEvents(events, {["MODIFIER_STATE_CHANGED"] = {}})
                        end
                        if booleanCond.isTarget == true then
                            E:MergeEvents(events, {["PLAYER_TARGET_CHANGED"] = {}})
                        end
                    end
                end
                if cond and cond.targetConds then
                    for _, targetCond in ipairs(cond.targetConds) do
                        if targetCond.type == "mouseover" then
                            E:MergeEvents(events, {["UPDATE_MOUSEOVER_UNIT"] = {}})
                        end
                    end
                end
            end
        end
        if command.cmd == "use" then
            if command.param and command.param.items then
                for _, item in ipairs(command.param.items) do
                    if item then
                        E:MergeEvents(events, E:GetItemAttrEvents(item))
                    end
                end
            end
        end
    end
    return events
end

--- 合并events列表
---@param events table<EventString, any[][]> 合并后的events列表
---@param mergedEvents table<EventString, any[][]>  被合并的events列表
function E:MergeEvents(events, mergedEvents)
    for k, tt in pairs(mergedEvents) do
        if events[k] == nil then
            events[k] = U.Table.DeepCopy(tt)
        else
            for _, t in ipairs(tt) do
                local hasSame = false
                for _, _t in ipairs(events[k]) do
                    if U.Table.Equal(t, _t) then
                        hasSame = true
                        break
                    end
                end
                if hasSame == false then
                    table.insert(events[k], t)
                end
                hasSame = false
            end
        end
    end
    
end

--- 获取config的监听事件
--- @param config ElementConfig
--- @param rootConfig ElementConfig | nil 祖先元素，如果为nil表示config本身就是祖先元素
--- @return table<EventString, any[][]> -- key为事件名称，value为一个二维数组，每一个数组表示一组事件参数。当数组为空的时候表示不限制
function E:GetEvents(config, rootConfig)
    ---@type table<string, any[]>
    local events = {
        ["PLAYER_ENTERING_WORLD"] = {},  -- 读蓝条
        ["PLAYER_REGEN_DISABLED"] = {},  -- 进入战斗
        ["PLAYER_REGEN_ENABLED"] = {}, -- 退出战斗
    }
    -- 如果有按键绑定设置且关系到依附框体状态，则需要监听依附框体改变事件
    if config.bindKey ~= nil and config.bindKey.attachFrame ~= nil then
        local attachFrame = (rootConfig and rootConfig.attachFrame) or config.attachFrame
         -- 判断是否有依附框体,如果有依附框体，需要监听依附框体的改变
        if attachFrame ~= nil and attachFrame ~= const.ATTACH_FRAME.UIParent then
            events[const.EVENT.HB_FRAME_CHANGE] = {{attachFrame}, }
        end
    end
    if config.listenEvents ~= nil then
        for event, _ in pairs(config.listenEvents) do
            events[event] = {}
        end
    end
    if config.type == const.ELEMENT_TYPE.ITEM then
        local item = E:ToItem(config)
        if item.extraAttr then
            E:MergeEvents(events, E:GetItemAttrEvents(item.extraAttr))
        end
    end
    if config.type == const.ELEMENT_TYPE.MACRO then
        local macro = E:ToMacro(config)
        E:MergeEvents(events, E:GetMacroEvents(macro.extraAttr))
    end
    if config.type == const.ELEMENT_TYPE.SCRIPT then
        -- 脚本类型自动增加玩家施法完成事件
        E:MergeEvents(events, {["UNIT_SPELLCAST_SUCCEEDED"] = {{"player", }, }})
    end
    if config.triggers and #config.triggers > 0 then
        for _, trigger in ipairs(config.triggers) do
            if trigger.type == "aura" then
                local confine = Trigger:ToAuraConfine(trigger.confine)
                ---@type table<EventString, any[][]>
                local e = {}
                e[const.EVENT.HB_UNIT_AURA] = {{confine.target, confine.spellId}, }
                E:MergeEvents(events, e)
            end
            if trigger.type == "item" then
                local confine = Trigger:ToItemConfine(trigger.confine)
                local item = confine.item
                E:MergeEvents(events, E:GetItemAttrEvents(item))
            end
        end
    end
    -- 递归查找，并且合并去除重复的参数列表
    if config.elements and #config.elements then
        for _, childEle in ipairs(config.elements) do
            E:MergeEvents(events, E:GetEvents(childEle, rootConfig or config))
        end
    end
    return events
end


--- 获取config的是否加载监听事件
--- @param config ElementConfig
--- @return table<EventString, any[][]> -- key为事件名称，value为一个二维数组，每一个数组表示一组事件参数。当数组为空的时候表示不限制
function E:GetLoadCondEvents(config)
    ---@type table<string, any[]>
    local events = {
        [const.EVENT.HB_UPDATE_CONFIG] = {},  -- 自定义事件
        ["PLAYER_ENTERING_WORLD"] = {},  -- 读蓝条
    }
    if config.loadCond == nil then
        return events
    end
    -- 开启战斗检查
    if config.loadCond.CombatCond ~= nil then
        events["PLAYER_REGEN_DISABLED"] = {}
        events["PLAYER_REGEN_ENABLED"] = {}
    end
    return events
end


--- 比较元素的events对象参数和事件参数，如果能够匹配返回true
---@param elementEventParams any[][]
---@param eventParam any[]
---@return boolean
function E:CompareEventParam(elementEventParams, eventParam)
    -- 如果元素参数二维数据为空，表示不设置条件
    if #elementEventParams == 0 then
        return true
    end
    for _, elementEventParam in ipairs(elementEventParams) do
        local met = true
        for k, param in ipairs(elementEventParam) do
            -- 当元素参数为-1的时候，表示这个参数不比较
            if param ~= -1 and param ~= eventParam[k] then
                met = false
                break
            end
        end
        if met == true then
            return true
        end
    end
    return false
end

-- 更新config的ItemAttr
function E:CompleteItemAttr(config)
    if config.type == const.ELEMENT_TYPE.BAR then
        if config.elements then
            for _, ele in ipairs(config.elements) do
                E:CompleteItemAttr(ele)
            end
        end
    end
    if config.type == const.ELEMENT_TYPE.MACRO then
        local macro = E:ToMacro(config)
        if macro.extraAttr.ast then
            if macro.extraAttr.ast.tooltip then
                Item:CompleteItemAttr(macro.extraAttr.ast.tooltip)
            end
            if macro.extraAttr.ast.commands then
                for _, command in ipairs(macro.extraAttr.ast.commands) do
                    if command.param and command.param.items then
                        for _, item in ipairs(command.param.items) do
                            Item:CompleteItemAttr(item)
                        end
                    end
                end
            end
        end
    end
end
