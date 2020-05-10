local _, ns = ...
local M, R, U, I = unpack(ns)
if I.Client ~= "zhCN" then return end

local strsplit, pairs = string.split, pairs

local UIQuestsandHelp = {
   "更多设置请|cFF00DDFF右键小地图|r",
 	 "任何你不喜欢的，请你控制台关了它.|cff3399FF        自己去下载自己喜欢的",
 	 "|cff3399FF头像样式一就仅只有你看到这些.    无任何施法条、连击点和更多其它",
 	 "聊天框怎样回到最新消息而不是一直滚轮.|cff3399FF        Shift+鼠标滚轮下",
 	 "我不想要技能栏上的白圈.|cff3399FF                ESC-插件-别打勾[输出]MaxDps",
	 "我找不到在哪关闭自动交接任务. |cff3399FF            左上任务追踪栏上 框里的勾",
	 "我缩放完了UI，系统头像位置变了.|cff3399FF          右键解锁挪回去",
	 "我用的简易头像,右键解锁挪不动啊.|cff3399FF         /bht m",
	 "为何没有Buff或者Debuff ID显示啊.|cff3399FF         按着你的Shift再看",
	 "点击聊天框角色名称可实现:|cff3399FF     Shift-密语 Ctrl-邀请工会 Alt-组队邀请",
   "|cFF00DDFF如需改进和反馈，可以回帖或者在讨论组(n9PnFl0o)告诉我，谢谢。",
   "-------------------------------"..GetAddOnMetadata("_ShiGuang", "X-StatsVersion").."----[正式]",
   "|cFFFF0000[注意]控制台设置后的 红色齿轮 可以点击后设置更多|r",
   "|cFFFF0000[注意]使用多功能团框的话，记得控制台别勾选“简易模式框体”|r",
   "[修复]修复Npc对话框文字越来越小的bug",
   "[修复]大家提到的一些小问题",
   "[调整]更加直观显示腐蚀等级和腐蚀值",
   "[调整]聊天框上一条已发消息改为默认的Alt+⬆",
   "[更新]常规维护和优化",
   "[移除]Boss一句话攻略",
   "[插件]版本号升级为v "..GetAddOnMetadata("_ShiGuang", "Version"),
   "--------------------------over",
}
local story = {
  "1、|cFF00DDFF我见过一个指挥，在午夜11点钟在教授面前的时候，他说我们休息一下吧，有人问为什么，他说：<你们记不得了？昨天这个时候，MT的小孩要睡觉了>",
  "2、|cFF00DDFF我听说过一个矿工，AFK前一周，他每天挖8小时的矿，最后很潇洒地放在公会银行。那以后他再也没上线，那一天公会银行多了3万金。|r",
  "3、|cFF00DDFF我见过一个RL，中午2点钟的时候她强制踢了一个奶德，我们问她为什么，她说：<奶德是个学生，2点半他要上课>",
  "4、|cFF00DDFF还有一个盗贼，拿到了双刀之后他每天6个小时在线打工，我只知道他的主手是一个朋友帮他飙到6万。|r",
  "5、|cFF00DDFF我见过一个放弃了橙弓的猎人，那天他和另一个猎人ROLL，点数低的是他，可是另一个猎人掉线了，他等了5分钟，他给那个猎人打了8个电话，",
  "|cFF00DDFF他始终没有把橙弓捡起来。然后他也掉线了，所有人都掉线了。",
  "6、|cFF00DDFF我还见过，一个小白没人陪他做怒炎的任务，他只是在综合说了一句，我看到了十多个人说：组我。|r",
  "7、|cFF00DDFF我70级的FS带血色的时候，一个小号说：boss的装备你捡去修装备吧，谢谢你。我带他刷了一个通宵。",
  "8、|cFF00DDFF或许是巧合，一个小德对我说，我卖了3张卡，只有你不骗我。我默然，只是淡淡地在世界频道说，这个小德是个新手，不要让他灰心。|r", 
  "|cFF00DDFF1个人密我，<对不起，我不知道是新手，已经U给他了>另一个人没有动静，我宁愿相信他是下了。|r",
  "9、|cFF00DDFF有人在带SL刷刷，说黑旗子，结果出的黑心，那个QS自己给自己了，同队的DK哑口无言，法师问他，你不是要旗子吗？我帮DK买吧，我给你卖店价。", 
  "|cFF00DDFF骑士没回答，只是说你们要不要我带的。说完这句话，4个小号不约而同，直接退队。",
  "10、|cFF00DDFF剑柄，听说鬼雾锋的剑柄是贪婪，但是我们是需求。于是那次鬼雾锋的人贪婪以后打了几个句号。拿到剑柄的T 没说话。开箱子，|r",  
  "|cFF00DDFFT没选贪婪也没选分解和需求。他说，奶妈，我们重新roll一次。奶妈还是没有roll到。不过这次，奶妈说，我们继续排！|r",
  "11、|cFF00DDFF我带着小号，跑到风行者之塔打项链。然后我带着他们去听女王唱歌。我告诉他们，这是个可以成为经典的游戏。这是wow，你们要玩下去。",
  "12、|cFF00DDFF一个小法师路过血色门口的时候，给一个80术士拍了智慧。然后，他就被邀请，获得了4个包和200金。他不过是拍了个智慧。他觉得这很正常啊。|r",
  "|cFF00DDFF殊不知术士已经内牛满面。|r",
  "",
  "#有些人让我写点感动的事，于是我写了这些没头没脑的东西，他又说他要催泪，我说，何必呢，你玩的是魔兽，你还少感动吗。",
  "他说，现在这个魔兽太蛋疼了。",
  "#我告诉他，这所有的东西都是我在<现在这个>魔兽里面遇到的，总会有毛人，总会有毛事和毛会，但是魔兽还是魔兽，",
  "能够进入这个游戏的玩家，大部分都不会是脑残。",
  "#魔兽没什么不同，一样讲装备，一样有野外杀小号，玩或者不玩，wow就在那里，我玩wow其实不是优越，只是对自己选择的一种庆幸。",
  "#魔兽也有很多不同，我们需要放下那些一直以来养成的思维定式来观察这个游戏，这个世界，带给我们的，是很多难以察觉也难以发觉的东西。",  
  "#至少，你拥有的关于这个世界的记忆，那是在别的地方任何方法也无法获得的。",
}
local function Helplist()
	if f then f:Show() return end
	local f = CreateFrame("Frame", "Helplist", UIParent)
	local bgTexture = f:CreateTexture("name", "BACKGROUND")
    bgTexture:SetTexture("Interface\\PETBATTLES\\Weather-StaticField");
    bgTexture:SetAllPoints();
    bgTexture:SetAlpha(.6)
	f:SetPoint("TOPLEFT", 260, -60)
	f:SetScale(1.1)
	f:SetFrameStrata("HIGH")
	M.CreateMF(f)
	M.SetBD(f)
	M.CreateFS(f, 30, "2 UI", true, "TOPLEFT", 43, 16)
	M.CreateFS(f, 16, I.Version, true, "TOPLEFT", 112, 6)
	local offset = 0
	for n, t in pairs(UIQuestsandHelp) do
		M.CreateFS(f, 14, n..": "..t, false, "TOPLEFT", 21, -(21 + offset))
		offset = offset + 21
	end
	f:SetSize(520, 36 + offset)
	local close = M.CreateButton(f, 21, 21, "X")
	close:SetPoint("TOPRIGHT", -8, 8)
	close:SetScript("OnClick", function() f:Hide() end)
end
local function lovewow()
	local f = CreateFrame("Frame", "welovewow", UIParent)
		 local bgTexture = f:CreateTexture("name", "BACKGROUND")
    bgTexture:SetTexture("Interface\\PETBATTLES\\Weather-StaticField");
    bgTexture:SetAllPoints();
    bgTexture:SetAlpha(.9)
	f:SetPoint("CENTER")
	f:SetScale(1.1)
	f:SetFrameStrata("HIGH")
	M.CreateMF(f)
	M.SetBD(f)
	M.CreateFS(f, 30, "总会有毛人", true, "TOPLEFT", 21, 16)
	M.CreateFS(f, 16, "We Love WOW", true, "TOPLEFT", 180, 9)
	local offset = 0
	for n, t in pairs(story) do
		M.CreateFS(f, 14, t, false, "TOPLEFT", 21, -(21 + offset))
		offset = offset + 21
	end
	f:SetSize(1024, 43 + offset)
	local close = M.CreateButton(f, 21, 21, "X")
	close:SetPoint("TOPRIGHT", -8, 8)
	close:SetScript("OnClick", function() f:Hide() end)
end

local function compareToShow(event)
	if UI_Tutorial then return end

	local old1, old2 = strsplit(".", MaoRUIDB["Changelog"].Version or "")
	local cur1, cur2 = strsplit(".", I.Version)
	if old1 ~= cur1 or old2 ~= cur2 then
		Helplist()
		MaoRUIDB["Changelog"].Version = I.Version
	end

	M:UnregisterEvent(event, compareToShow)
end
M:RegisterEvent("PLAYER_ENTERING_WORLD", compareToShow)

SlashCmdList["HELPLIST"] = Helplist
SLASH_HELPLIST1 = '/MrHelp'
SlashCmdList["WELOVEWOW"] = lovewow
SLASH_WELOVEWOW1 = '/welovewow'