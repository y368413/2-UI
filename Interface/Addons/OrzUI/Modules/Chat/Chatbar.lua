local _, ns = ...
local M, R, U, I = unpack(ns)
local module = M:GetModule("Chat")
local tinsert, pairs = tinsert, pairs
local C_GuildInfo_IsGuildOfficer = C_GuildInfo.IsGuildOfficer
local gsub, gmatch, ipairs, select= string.gsub, string.gmatch, ipairs, select

------------------------------------------------------------------------------------- 属性通报 ----------------------------------------
local function Talent()  -- 本地化专精
	local SpecName = GetSpecialization() and select(2, GetSpecializationInfo(GetSpecialization())) or "无" return SpecName
end

local function HealText()  -- 格式化血量
	if UnitHealthMax("player") > 1e4 then return format('%.2f万',UnitHealthMax("player")/1e4) else return UnitHealthMax("player") end
end

-- 神器等级
local function ArtifactLevel()
    local currentLevel = " "
    local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
    if azeriteItemLocation then
        currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
    end
    return currentLevel
end

local slotNames = {
    "HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot", "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot", "MainHandSlot", "SecondaryHandSlot", "AmmoSlot"
}

-- 特质装等级
local function AzeriteItemLevel(slotNum)
    local currentLevel = "0"
    local slotId = GetInventorySlotInfo(slotNames[slotNum])
    local itemLink = GetInventoryItemLink("player", slotId)
    if itemLink then
        local itemLoc
        if ItemLocation then
            itemLoc = ItemLocation:CreateFromEquipmentSlot(slotId)
        end
        if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItem(itemLoc) then
            return select(4, GetItemInfo(itemLink))
        end
    end
    return currentLevel
end

local function BaseInfo()  -- 基础属性
	local BaseStat = ""	
		BaseStat = BaseStat..("[%s] "):format(Talent())
		--BaseStat = BaseStat..("%s "):format(UnitClass("player"))
		BaseStat = BaseStat..("< %.1f/%.1f > "):format(GetAverageItemLevel())
		BaseStat = BaseStat..("血量:%s "):format(HealText())
		--BaseStat = BaseStat .. ("项链:%s "):format(ArtifactLevel())-- 项链等级
    --BaseStat = BaseStat .. ("头部:%s "):format(AzeriteItemLevel(1))-- 头部特质装等级
    --BaseStat = BaseStat .. ("肩部:%s "):format(AzeriteItemLevel(3))-- 肩部特质装等级
    --BaseStat = BaseStat .. ("胸部:%s "):format(AzeriteItemLevel(5))-- 胸部特质装等级
	return BaseStat
end

local function DpsInfo()  -- 输出属性 by 图图  (9 = 暴击 12 = 溅射 17 = 吸血 18 = 急速 21 = 闪避 26 = 精通 29 = 装备+自身全能 31 = 装备全能)
    local DpsStat={"", "", ""}
    local specAttr={
        --纯力敏智属性职业
        WARRIOR={1,1,1},
        DEATHKNIGHT={1,1,1},
        ROGUE={2,2,2},
        HUNTER={2,2,2},
        MAGE={3,3,3},
        WARLOCK={3,3,3},
        PRIEST={3,3,3},
        --混合力敏智属性职业
        SHAMAN={3,2,3},
        MONK={2,3,2},
        DRUID={3,2,2,3},
        PALADIN={3,1,1},
        DEMONHUNTER={2,1}
    }
	local classCN,classEnName = UnitClass("player")
    	DpsStat[1] = (SPEC_FRAME_PRIMARY_STAT_STRENGTH  ..":%s "):format(UnitStat("player", 1))
    	DpsStat[2] = (SPEC_FRAME_PRIMARY_STAT_AGILITY  ..":%s "):format(UnitStat("player", 2))
    	DpsStat[3] = (SPEC_FRAME_PRIMARY_STAT_INTELLECT  ..":%s "):format(UnitStat("player", 4))
	return DpsStat[specAttr[classEnName][GetSpecialization()]]
end

local function TankInfo() -- 坦克属性
	local TankStat = ""
		TankStat = TankStat..(STA_LCD ..":%s "):format(UnitStat("player", 3))
		TankStat = TankStat..(STAT_ARMOR ..":%s "):format(UnitArmor("player"))
		TankStat = TankStat..("闪避:%.2f%% "):format(GetDodgeChance())
		TankStat = TankStat..("招架:%.2f%% "):format(GetParryChance())
		TankStat = TankStat..("格挡:%.2f%% "):format(GetBlockChance())
	return TankStat
end

local function HealInfo()  -- 治疗属性
	local HealStat = ""
		--HealStat = HealStat..("精神:%s "):format(UnitStat("player", 5))
		HealStat = HealStat..("法力回复:%d "):format(GetManaRegen()*5)
	return HealStat
end

local function MoreInfo()  -- 增强属性
	local MoreStat = ""
		MoreStat = MoreStat..(STAT_HASTE ..":%.2f%% "):format(GetHaste())  --GetMeleeHaste
		MoreStat = MoreStat..(STAT_CRITICAL_STRIKE  ..":%.2f%% "):format(GetCritChance())
		MoreStat = MoreStat..(STAT_MASTERY ..":%.2f%% "):format(GetMasteryEffect())
		--MoreStat = MoreStat..("溅射:%.2f%% "):format(GetMultistrike()) -- GetCombatRating(12)
		--MoreStat = MoreStat..(STAT_LIFESTEAL..":%.2f%% "):format(GetLifesteal())
		-- MoreStat = MoreStat .. ("吸血:%.0f%% "):format(GetCombatRating(17) / 230)
		MoreStat = MoreStat..(STAT_VERSATILITY ..":%.2f%% "):format(GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE))  --GetVersatility()
	return MoreStat
end

function StatReport()  -- 属性收集
	if UnitLevel("player") < 10 then return BaseInfo() end
	local StatInfo = ""
	local Role = GetSpecializationRole(GetSpecialization())
	if Role == "HEALER" then StatInfo = StatInfo..BaseInfo()..DpsInfo()..HealInfo()..MoreInfo()
	elseif Role == "TANK" then StatInfo = StatInfo..BaseInfo()..DpsInfo()..TankInfo()..MoreInfo()
	else StatInfo = StatInfo..BaseInfo()..DpsInfo()..MoreInfo()
	end
	return StatInfo
end
------------------------------------------------------------------------------------- 属性通报 End ----------------------------------------
 --[[------------------------------------- 聊天表情-- Author:M-------------------------------------
-- key為圖片名
local emotes = {
        --表情
  { key = "angel",    zhTW="天使",      zhCN="天使" },
	{ key = "angry",    zhTW="生氣",      zhCN="生气" },
	{ key = "biglaugh", zhTW="大笑",      zhCN="大笑" },
	{ key = "clap",     zhTW="鼓掌",      zhCN="鼓掌" },
	{ key = "cool",     zhTW="酷",        zhCN="酷" },
	{ key = "cry",      zhTW="哭",        zhCN="哭" },
	{ key = "cutie",    zhTW="可愛",      zhCN="可爱" },
	{ key = "despise",  zhTW="鄙視",      zhCN="鄙视" },
	{ key = "dreamsmile", zhTW="美夢",    zhCN="美梦" },
	{ key = "embarrass", zhTW="尷尬",     zhCN="尴尬" },
	{ key = "evil",     zhTW="邪惡",      zhCN="邪恶" },
	{ key = "excited",  zhTW="興奮",      zhCN="兴奋" },
	{ key = "faint",    zhTW="暈",        zhCN="晕" },
	{ key = "fight",    zhTW="打架",      zhCN="打架" },
	{ key = "flu",      zhTW="流感",      zhCN="流感" },
	{ key = "freeze",   zhTW="呆",        zhCN="呆" },
	{ key = "frown",    zhTW="皺眉",      zhCN="皱眉" },
	{ key = "greet",    zhTW="致敬",      zhCN="致敬" },
	{ key = "grimace",  zhTW="鬼臉",      zhCN="鬼脸" },
	{ key = "growl",    zhTW="齜牙",      zhCN="龇牙" },
	{ key = "happy",    zhTW="開心",      zhCN="开心" },
	{ key = "heart",    zhTW="心",        zhCN="心" },
	{ key = "horror",   zhTW="恐懼",      zhCN="恐惧" },
	{ key = "ill",      zhTW="生病",      zhCN="生病" },
	{ key = "innocent", zhTW="無辜",      zhCN="无辜" },
	{ key = "kongfu",   zhTW="功夫",      zhCN="功夫" },
	{ key = "love",     zhTW="花痴",      zhCN="花痴" },
	{ key = "mail",     zhTW="郵件",      zhCN="邮件" },
	{ key = "makeup",   zhTW="化妝",      zhCN="化妆" },
    { key = "mario",    zhTW="馬里奧",    zhCN="马里奥" },
	{ key = "meditate", zhTW="沉思",      zhCN="沉思" },
	{ key = "miserable", zhTW="可憐",     zhCN="可怜" },
	{ key = "okay",     zhTW="好",        zhCN="好" },
	{ key = "pretty",   zhTW="漂亮",      zhCN="漂亮" },
	{ key = "puke",     zhTW="吐",        zhCN="吐" },
	{ key = "shake",    zhTW="握手",      zhCN="握手" },
	{ key = "shout",    zhTW="喊",        zhCN="喊" },
	{ key = "shuuuu",   zhTW="閉嘴",      zhCN="闭嘴" },
	{ key = "shy",      zhTW="害羞",      zhCN="害羞" },
	{ key = "sleep",    zhTW="睡覺",      zhCN="睡觉" },
	{ key = "smile",    zhTW="微笑",      zhCN="微笑" },
	{ key = "suprise",  zhTW="吃驚",      zhCN="吃惊" },
	{ key = "surrender", zhTW="失敗",     zhCN="失败" },
	{ key = "sweat",    zhTW="流汗",      zhCN="流汗" },
	{ key = "tear",     zhTW="流淚",      zhCN="流泪" },
	{ key = "tears",    zhTW="悲劇",      zhCN="悲剧" },
	{ key = "think",    zhTW="想",        zhCN="想" },
	{ key = "Bloodtrail",    zhTW="布拉德特羅爾",    zhCN="布拉德特羅爾" },
	{ key = "titter",   zhTW="偷笑",      zhCN="偷笑" },
	{ key = "ugly",     zhTW="猥瑣",      zhCN="猥琐" },
	{ key = "victory",  zhTW="勝利",      zhCN="胜利" },
	{ key = "volunteer", zhTW="雷鋒",     zhCN="雷锋" },
	{ key = "wronged",  zhTW="委屈",      zhCN="委屈" },   
	    --2022.6.2添加45个新表情 感谢 高频变压器@NGA
    { key = "right",  zhTW="对",      zhCN="对" },
    { key = "worry",  zhTW="错",      zhCN="错" },
    { key = "doubt",  zhTW="疑问",      zhCN="疑问" },
    { key = "speechless",  zhTW="无语",      zhCN="无语" },
    { key = "666",  zhTW="666",      zhCN="666" },
    { key = "kiss",  zhTW="kiss",      zhCN="kiss" },
    { key = "ILoveYou",  zhTW="ILoveYou",      zhCN="ILoveYou" },
    { key = "2333",  zhTW="2333",      zhCN="2333" },
    { key = "emm",  zhTW="emm",      zhCN="emm" },
    { key = "lurk",  zhTW="暗中观察",      zhCN="暗中观察" },
    { key = "fingerheart",  zhTW="比心",      zhCN="比心" },
    { key = "V5",  zhTW="V5",      zhCN="V5" },
    { key = "Call",  zhTW="打Call",      zhCN="打Call" },
    { key = "awesome",  zhTW="给力",      zhCN="给力" },
    { key = "cake",  zhTW="蛋糕",      zhCN="蛋糕" },
    { key = "exhausted",  zhTW="绝",      zhCN="绝" },
    { key = "comeon",  zhTW="加油",      zhCN="加油" },
    { key = "‌tip",  zhTW="打赏",      zhCN="打赏" },
    { key = "seered",  zhTW="发怒",      zhCN="发怒" },
    { key = "Buddhistlike",  zhTW="佛系",      zhCN="佛系" },
    { key = "Restricted",  zhTW="禁",      zhCN="禁" },
    { key = "impressed",  zhTW="服了",      zhCN="服了" },
    { key = "gobbler",  zhTW="干饭人",      zhCN="干饭人" },
    { key = "Representative",  zhTW="课代表",      zhCN="课代表" },
    { key = "hurteyes",  zhTW="辣眼睛",      zhCN="辣眼睛" },
    { key = "slap",  zhTW="打脸",      zhCN="打脸" },
    { key = "control",  zhTW="拿捏",      zhCN="拿捏" },
    { key = "cow",  zhTW="牛",      zhCN="牛" },
    { key = "prayer",  zhTW="祈祷",      zhCN="祈祷" },
    { key = "chou",  zhTW="屎",      zhCN="屎" },
    { key = "slackoff",  zhTW="摸鱼",      zhCN="摸鱼" },
    { key = "envy",  zhTW="酸了",      zhCN="酸了" },
    { key = "however",  zhTW="摊手",      zhCN="摊手" },
    { key = "lacrimaleyes",  zhTW="泪目",      zhCN="泪目" },
    { key = "thinkabout",  zhTW="托腮",      zhCN="托腮" },
    { key = "ohno",  zhTW="捂脸",      zhCN="捂脸" },
    { key = "bequiet",  zhTW="我想静静",      zhCN="我想静静" },
    { key = "heartbroken",  zhTW="心碎",      zhCN="心碎" },
    { key = "bored",  zhTW="无聊",      zhCN="无聊" },
    { key = "nowords",  zhTW="笑哭",      zhCN="笑哭" },
    { key = "respect",  zhTW="瑞思拜",      zhCN="瑞思拜" },
    { key = "yyds",  zhTW="yyds",      zhCN="yyds" },
    { key = "Better",  zhTW="很棒",      zhCN="很棒" },
    { key = "u1s1",  zhTW="有一说一",      zhCN="有一说一" },
    { key = "nice",  zhTW="点赞",      zhCN="点赞" },
        --指定了texture一般用於BLIZ自帶的素材
    { key = "wrong",    zhTW="錯",        zhCN="错",    texture = "Interface\\RaidFrame\\ReadyCheck-NotReady" },
    { key = "right",    zhTW="對",        zhCN="对",    texture = "Interface\\RaidFrame\\ReadyCheck-Ready" },
    { key = "question", zhTW="疑問",      zhCN="疑问",  texture = "Interface\\RaidFrame\\ReadyCheck-Waiting" },
    { key = "skull",    zhTW="骷髏",      zhCN="骷髅",  texture = "Interface\\TargetingFrame\\UI-TargetingFrame-Skull" },
    { key = "sheep",    zhTW="羊",        zhCN="羊",    texture = "Interface\\TargetingFrame\\UI-TargetingFrame-Sheep" },
        --原版暴雪提供的8个图标
    { key = "rt1",    zhTW="rt1",        zhCN="rt1",    texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_1" },
    { key = "rt2",    zhTW="rt2",        zhCN="rt2",    texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_2" },
    { key = "rt3",    zhTW="rt3",        zhCN="rt3",    texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_3" },
    { key = "rt4",    zhTW="rt4",        zhCN="rt4",    texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_4" },
    { key = "rt5",    zhTW="rt5",        zhCN="rt5",    texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_5" },
    { key = "rt6",    zhTW="rt6",        zhCN="rt6",    texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_6" },
    { key = "rt7",    zhTW="rt7",        zhCN="rt7",    texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_7" },
    { key = "rt8",    zhTW="rt8",        zhCN="rt8",    texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_8" },
}

local function ReplaceEmote(value)
    local emote = value:gsub("[%{%}]", "")
    for _, v in ipairs(emotes) do
        if (emote == v.key or emote == v.zhCN or emote == v.zhTW) then
            return "|T".. (v.texture or "Interface\\AddOns\\OrzUI\\Media\\Emotes\\".. v.key) ..":16|t"
        end
    end
    return value
end

local function Chatemotefilter(self, event, msg, ...)
    msg = msg:gsub("%{.-%}", ReplaceEmote)
    return false, msg, ...
end

local chatEvents = {
	"CHAT_MSG_BN",
	"CHAT_MSG_BN_CONVERSATION",
	"CHAT_MSG_BN_WHISPER",
	"CHAT_MSG_BN_WHISPER_INFORM",
	"CHAT_MSG_CHANNEL",
	"CHAT_MSG_GUILD",
	"CHAT_MSG_INSTANCE_CHAT",
	"CHAT_MSG_INSTANCE_CHAT_LEADER",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_PARTY_GUIDE",
	"CHAT_MSG_PARTY_LEADER",
	"CHAT_MSG_RAID",
	"CHAT_MSG_RAID_LEADER",
	"CHAT_MSG_RAID_WARNING",
	"CHAT_MSG_SAY",
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_WHISPER_INFORM",
	"CHAT_MSG_YELL",
	"CHAT_MSG_BATTLEGROUND",
	"CHAT_MSG_BATTLEGROUND_LEADER"	
}

  local function EmoteButton_OnClick(self, button)
    local editBox = ChatEdit_ChooseBoxForSend()
    ChatEdit_ActivateChat(editBox)
    editBox:SetText(editBox:GetText():gsub("{$","") .. self.emote)
    if (button == "LeftButton") then self:GetParent():Hide() end
  end]]
 --------------------------------------- 聊天表情-- Author:M  end -------------------------------------
local chatSwitchInfo = {
	text = U["ChatSwitchHelp"],
	buttonStyle = HelpTip.ButtonStyle.GotIt,
	targetPoint = HelpTip.Point.TopEdgeCenter,
	offsetY = 50,
	onAcknowledgeCallback = M.HelpInfoAcknowledge,
	callbackArg = "ChatSwitch",
}

local function chatSwitchTip()
	if not OrzUISetDB["Help"]["ChatSwitch"] then
		HelpTip:Show(ChatFrame1, chatSwitchInfo)
	end
end

local function ResetChatAlertJustify(frame)
	frame:SetJustification("LEFT")
end

function module:Chatbar()
	if not R.db["Chat"]["Chatbar"] then return end

	local chatFrame = SELECTED_DOCK_FRAME
	local editBox = chatFrame.editBox
	local width, height, padding, buttonList = 16, 18, 6, {}

	local Chatbar = CreateFrame("Frame", "OrzUI_ChatBar", UIParent)
	Chatbar:SetSize(width, height)

	local function AddButton(r, g, b, text, func)
		local bu = CreateFrame("Button", nil, Chatbar, "SecureActionButtonTemplate, BackdropTemplate")
		bu:SetSize(width, height)
		M.CreateFS(bu, 15, text, "Chatbar", "CENTER", 0, 0, r, g, b)
		bu:SetHitRectInsets(0, 0, -8, -8)
		bu:RegisterForClicks("AnyUp")
		--if text then M.AddTooltip(bu, "ANCHOR_TOP", M.HexRGB(r, g, b)..text) end
		if func then
			bu:SetScript("OnClick", func)
			bu:HookScript("OnClick", chatSwitchTip)
		end
		tinsert(buttonList, bu)
		return bu
	end

	-- Create Chatbars
	local buttonInfo = {
		{255/255,255/255,255/255, Chatbar_ChannelSay, function() ChatFrame_OpenChat("/s ", chatFrame) end},  --SAY.."/"..YELL
		{255/255, 64/255, 64/255, Chatbar_ChannelYell, function() ChatFrame_OpenChat("/y ", chatFrame) end},
		{170/255, 170/255, 255/255, Chatbar_ChannelParty, function() ChatFrame_OpenChat("/p ", chatFrame) end},   --PARTY
		{255/255, 127/255, 0, Chatbar_ChannelBattleGround, function() ChatFrame_OpenChat("/i ", chatFrame) end},  --INSTANCE.."/"..RAID
		{255/255, 127/255, 0, Chatbar_ChannelRaid, function() ChatFrame_OpenChat("/raid ", chatFrame) end},
		{255/255, 69/255, 0, Chatbar_ChannelRaidWarns, function() ChatFrame_OpenChat("/rw ", chatFrame) end},
		{64/255, 255/255, 64/255, Chatbar_ChannelGuild, function() ChatFrame_OpenChat("/g ", chatFrame) end},    --GUILD.."/"..OFFICER
		--{170/255, 170/255, 255/255, Chatbar_ChannelOfficer, function() ChatFrame_OpenChat("/o ", chatFrame) end},
		--{0.8, 255/255, 0.6, Chatbar_rollText, function() ChatFrame_OpenChat("/roll", chatFrame) end},
		{0.1, 0.6, 255/255, Chatbar_StatReport, function() ChatFrame_OpenChat(StatReport(), chatFrame) end},
	}
	for _, info in pairs(buttonInfo) do AddButton(unpack(info)) end

	-- ROLL
	local roll = AddButton(.8, 1, .6, Chatbar_rollText)  --LOOT_ROLL
	roll:SetAttribute("type", "macro")
	roll:SetAttribute("macrotext", "/roll")
	roll:RegisterForClicks("AnyUp", "AnyDown")

	-- COMBATLOG
	local combat = AddButton(1, 1, 0, Chatbar_CombatLogText) --BINDING_NAME_TOGGLECOMBATLOG
	combat:SetAttribute("type", "macro")
	combat:SetAttribute("macrotext", "/combatlog")
	combat:RegisterForClicks("AnyUp", "AnyDown")

	-- WORLD CHANNEL
	if GetCVar("portal") == "CN" then
		local channelName = WORLD_CHANNEL_NAME
		local wcButton = AddButton(255/255, 200/255, 150/255, "世")  --U["World Channel"]

		local function updateChannelInfo()
			local id = GetChannelName(channelName)
			if not id or id == 0 then
				module.InWorldChannel = false
				module.WorldChannelID = nil
				--wcButton.Icon:SetVertexColor(1, .1, .1)
			else
				module.InWorldChannel = true
				module.WorldChannelID = id
				--wcButton.Icon:SetVertexColor(0, .8, 1)
			end
		end

		local function checkChannelStatus()
			C_Timer.After(.2, updateChannelInfo)
		end
		checkChannelStatus()
		M:RegisterEvent("CHANNEL_UI_UPDATE", checkChannelStatus)
		hooksecurefunc("ChatConfigChannelSettings_UpdateCheckboxes", checkChannelStatus) -- toggle in chatconfig

		wcButton:SetScript("OnClick", function(_, btn)
			if module.InWorldChannel then
				if btn == "RightButton" then
					LeaveChannelByName(channelName)
					print("<<<|cffFF7F50"..QUIT.."|r "..I.InfoColor..U["World Channel"])
					module.InWorldChannel = false
				elseif module.WorldChannelID then
					ChatFrame_OpenChat("/"..module.WorldChannelID, chatFrame)
				end
			else
				JoinPermanentChannel(channelName, nil, 1)
				ChatFrame_AddChannel(ChatFrame1, channelName)
				print(">>>|cff00C957"..JOIN.."|r "..I.InfoColor..U["World Channel"])
				module.InWorldChannel = true
			end
		end)
	end

	-- Order Postions
	for i = 1, #buttonList do
		if i == 1 then
			buttonList[i]:SetPoint("LEFT")  --, Emote_CallButton, "RIGHT", 6, -2
		else
			buttonList[i]:SetPoint("LEFT", buttonList[i-1], "RIGHT", padding, 0)
		end
	end
	
	-- Mover
	local width = (#buttonList-1)*(padding+width) + width
	local mover = M.Mover(Chatbar, U["Chatbar"], "Chatbar", {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 0}, width, 20)
	Chatbar:ClearAllPoints()
	Chatbar:SetPoint("BOTTOMLEFT", mover, 0, 0)

	module:ChatBarBackground()
end

function module:ChatBarBackground()
	if not R.db["Skins"]["ChatbarLine"] then return end

	local cr, cg, cb = 0, 0, 0
	if R.db["Skins"]["ClassLine"] then cr, cg, cb = I.r, I.g, I.b end

	local parent = _G["Orzui_ChatBar"]
	local width, height, alpha = 450, 18, .5
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetPoint("LEFT", parent, "LEFT", -5, 0)
	frame:SetSize(width, height)

	local tex = M.SetGradient(frame, "H", 0, 0, 0, alpha, 0, width, height)
	tex:SetPoint("CENTER")
	local bottomLine = M.SetGradient(frame, "H", cr, cg, cb, alpha, 0, width, R.mult)
	bottomLine:SetPoint("TOP", frame, "BOTTOM")
	local topLine = M.SetGradient(frame, "H", cr, cg, cb, alpha, 0, width, R.mult)
	topLine:SetPoint("BOTTOM", frame, "TOP")
end

----------------------------------------------------------------------------------------
--[[	Play sound files system(by Tukz)
----------------------------------------------------------------------------------------
local SoundSys = CreateFrame("Frame")
SoundSys:RegisterEvent("CHAT_MSG_WHISPER")
SoundSys:RegisterEvent("CHAT_MSG_BN_WHISPER")
SoundSys:HookScript("OnEvent", function(_, event)
	if event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_BN_WHISPER" then
		PlaySoundFile("Interface\\AddOns\\OrzUI\\Media\\Sounds\\Whisper.ogg", "Master")
	end
end)]]