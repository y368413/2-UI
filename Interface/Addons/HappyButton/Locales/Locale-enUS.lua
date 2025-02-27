local L = LibStub("AceLocale-3.0"):NewLocale("HappyButton", "enUS", true)

L["Version"] = true
L["Welcome to use HappyButton."] = true
L["Can not register Bar: must be a callback function."] = true
L["You cannot use this in combat."] = true
L["Settings"] = true
L["Teleport"] = true
L["Class"] = true
L["Profession"] = true
L["Mail"] = true
L["Bank"] = true
L["Merchant"] = true
L["Others"] = true
L["Yes"] = true
L["No"] = true
L["Please copy the configuration to the clipboard."] = true
L["Items Bar"] = true
L["Default"] = true
L["Title"] = true
L["Icon"] = true
L["New"] = true
L["Delete"] = true
L["Mode"] = true
L["Select items to display"] = true
L["Macro"] = true
L["Export"] = true
L["Import Configuration"] = true
L["Configuration string"] = true
L["Whether to overwrite the existing configuration."]= true
L["Whether to import keybind settings."] = true
L["Import failed: Invalid configuration string."] = true
L["Wheter to use element title to replace item name."] = true
L["Add Item"] = true
L["Item Type"] = true
L["Alias"] = true
L["Item name or item id"] = true
L["Please select item type."] = true
L["Unable to get the id, please check the input."] = true
L["Unable to get the name, please check the input."] = true
L["Unable to get the icon, please check the input."] = true
L["ID"] = true
L["Name"] = true
L["Type"] = true
L["Configuration String Edit Box"] = true
L["Import/Export Configuration"] = true
L["General Settings"] = true
L["Window Position X"] = true
L["Window Position Y"] = true
L["Display one item, randomly selected."] = true
L["Display one item, selected sequentially."] = true
L["Item"] = true
L["Equipment"] = true
L["Toy"] = true
L["Spell"] = true
L["Mount"] = true
L["Pet"] = true
L["Display"] = true
L["ITEM_GROUP"] = "ItemsGroup"
L["Whether to display text."] = true
L["Illegal value."] = true
L["Whether to display item name."] = true
L["Whether to show the bar menu when the mouse enter."] = true
L["Illegal script."] = true
L["Hidden"] = true
L["Display as alone items bar"] = true
L["Append to the main frame"] = true
L["Toggle Edit Mode"] = true
L["Main frame"] = true
L["Left-click to drag and move, right-click to exit edit mode."] = true
L["Element Settings"] = true
L["Bar"] = true
L["ItemGroup"] = true
L["Script"] = true
L["New Bar"] = true
L["New ItemGroup"] = true
L["New Item"] = true
L["New Script"] = true
L["New Macro"] = true
L["Select type"] = true
L["Element Title"] = true
L["Element Icon ID or Path"] = true
L["Grid Layout"] = true
L["Drawer Layout"] = true
L["Direction of elements growth"] = true
L["Horizontal"] = true
L["Vertical"] = true
L["Icon Width"] = true
L["Icon Height"] = true
L["Show Item Quality Color"] = true
L["Display Rule"] = true
L["Load"] = true
L["Load Rule"] = true
L["Add Child Elements"] = true
L["Edit Child Elements"] = true
L["Select Item"] = true

-- 宏设置
L["Macro Statement Settings"] = true
L["Temporary Targeting"] = true
L["Boolean Conditions"] = true

-- 位置
L["TOPLEFT"] = true
L["TOPRIGHT"] = true
L["BOTTOMLEFT"] = true
L["BOTTOMRIGHT"] = true
L["LEFTTOP"] = true
L["LEFTBOTTOM"] = true
L["RIGHTTOP"] = true
L["RIGHTBOTTOM"] = true
L["TOP"] = true
L["BOTTOM"] = true
L["LEFT"] = true
L["RIGHT"] = true
L["CENTER"] = true
L["Relative X-Offset"] = true
L["Relative Y-Offset"] = true
-- 依附框体
L["UIParent"] = true  -- 主屏幕
L["GameMenuFrame"] = true  -- 游戏菜单
L["Minimap"] = true  -- 小地图
L["ProfessionsBookFrame"] = true  -- 专业
L["WorldMapFrame"] = true  -- 世界地图
L["CollectionsJournal"] = true  -- 收集箱
L["PVEFrame"] = true -- 地下城和团队副本
L["CharacterFrame"] = true -- 角色框体


L["Position Settings"] = true
L["Element Anchor Position"] = true
L["AttachFrame"] = true
L["AttachFrame Anchor Position"] = true


L["Combat Load Condition"] = true
L["Load when out of combat"] = true
L["Load when in combat"] = true

L["AttachFrame Load Condition"] = true
L["Load when attach frame hide"] = true
L["Load when attach frame show"] = true
L["Not working when in combat"] = true

L["Text Settings"] = true
L["Use root element settings"] = true
L["Item Name"] = true
L["Item Count"] = true
L["Add Text"] = true
L["Select Text"] = true

L["Trigger"] = true
L["Trigger Settings"] = true
L["New Trigger"] = true
L["Trigger Title"] = true
L["Select Trigger"] = true
L["Select Target"] = true
L["Select Trigger Type"] = true

L["Self Trigger"] = true
L["Count/Charge"] = true
L["Is Learned"] = true
L["Is Cooldown"] = true

L["Aura Trigger"] = true
L["Aura ID"] = true
L["Aura Remaining Time"] = true
L["Select Aura Type"] = true
L["Player"] = true
L["Target"] = true
L["Buff"] = true
L["Debuff"] = true

L["Item Trigger"] = true
L["Select Item"] = true

L["Condition Group Settings"] = true
L["Condition Settings"] = true
L["Condition Group"] = true
L["Condition"] = true
L["New Condition Group"] = true
L["New Condition"] = true
L["No Trigger"] = true
L["Left Value Settings"] = true
L["Operate"] = true
L["Right Value Settings"] = true
L["True"] = true
L["False"] = true
L["Expression Settings"] = true
L["Effect Settings"] = true

-- 触发器表达式
L["Cond1"] = true
L["Cond1 and Cond2"] = true
L["Cond1 or Cond2"] = true
L["Cond1 and Cond2 and Cond3"] = true
L["Cond1 or Cond2 or Cond3"] = true
L["(Cond1 and Cond2) or Cond3"] = true
L["(Cond1 or Cond2) and Cond3"] = true


-- 触发器条件列表
L["count"] = "Count"
L["isLearned"] = "Is Learned"
L["isUsable"] = "Is Usable"
L["isCooldown"] = "Is Cooldown"
L["remainingTime"] = "Remaining Time"
L["targetIsEnemy"] = "Target Is Enemy"
L["targetCanAttack"] = "target Can Attack"
L["exist"] = true

-- 触发器效果
L["Border Glow"] = true
L["Btn Hide"] = true
L["Btn Desaturate"] = true
L["Btn Vertex Red Color"] = true
L["Btn Alpha"] = true

L["Open"] = true
L["Close"] = true

L["Move Up"] = true
L["Move Down"] = true
L["Move Top Level"] = true
L["Move Down Level"] = true

-- 事件监听设置
L["Event Settings"] = true
L["Enable Event Listening"] = true

-- 职业
L["Enable Class Settings"] = true
L["Warrior"] = true
L["Paladin"] = true
L["Hunter"] = true
L["Rogue"] = true
L["Priest"] = true
L["Death Knight"] = true
L["Shaman"] = true
L["Mage"] = true
L["Warlock"] = true
L["Monk"] = true
L["Druid"] = true
L["Demon Hunter"] = true
L["Evoker"] = true

-- 按键绑定设置
L["Bindkey Settings"] = true
L["Bindkey"] = true
L["Bind For Account"] = true
L["Bind For Current Character"] = true
L["Bind For Current Class"] = true
L["The newly created button do not immediately respond to key bindings and require executing the /reload command."] = true

-- 宏错误提示
L["Macro Error"] = true
L["Macro Error: Invalid equipment slot: %s"] = true
L["Macro Error: Can not find this identifier: %s"] = true