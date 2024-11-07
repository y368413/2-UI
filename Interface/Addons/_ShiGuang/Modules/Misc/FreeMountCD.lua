-- 免费CD云分流终端 by 所有在宏名单的CD君们,插件提供：【徒手破九霄-格瑞姆巴托】  优化维护【郑矢娜-战歌】
local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")

function MISC:FreeMountCD()
	if (GetCVar("portal") ~= "CN") or (not R.db["Misc"]["FreeMountCD"]) then return end
	local Bee = "Interface\\AddOns\\_ShiGuang\\Media\\Hexagon"

-- Whisper Details --
	FreeMountCD_CopyrightMacro =   --'/click CD11M'
	'/E 请感谢以下CD君曾经的付出，他们怀着热情加入了我们，现已因故退役，请记住他们！'
	..'\n'..
	'/E  部落退役CD君：我爱小前台-白银之手、浅夏微涼-燃烧之刃、小新与风间-死亡之翼、大姐姐我们走-迦拉克隆、瓜呱呱瓜-奥斯里安、慕容晨-无尽之海'
	..'\n'..
	'/E  部落退役CD君：镭萧-亡语者、湛蓝呵呵-戈提克、叶果子-贫瘠之地、楚凡-霜之哀伤、娜芙雅丶薇薇-石爪峰、大舅-卡拉赞、九筱妖-布兰卡德、溟炎-洛丹伦'
	..'\n'..
	'/E  联盟退役CD君：我是小前台-白银之手、鱼戏江湖-织亡者、杨铁心-古加尔、兔子修炼成马-白银之手、昀萧-夏维安、第三仙-轻风之语、死神的黑羽翼-山丘之王、未闻君名-白银之手';
	
if UnitFactionGroup("player") == "Alliance" then
	FreeMountCD_GeneralMacro =   --'/click CD3M'
	'/script SetRaidDifficultyID(14)'
	..'\n'..
	'/script SetLegacyRaidDifficultyID(4)'
	..'\n'..
	'/run local M=function(a,b)SendChatMessage(b,"WHISPER",nil,a)end; M("永夜绽放之薇-艾森娜","9")M("LMCD-战歌","组")M("林荫下的乞丐-安苏","44296")M("波雅丶汉库克-埃雷达尔","1")M("聖殤-通灵学院","1")M("蚊飙-奥蕾莉亚","1")M("第三仙-轻风之语","1")M("子瓜-诺兹多姆","1")M("千山云影-雷霆号角","1")M("蛋总的徒弟-刺骨利刃","1")M("甜果冻-阿古斯","1")M("古南泉-白银之手","1")'
	..'\n'..
	'/run UIErrorsFrame:AddMessage("进本一定要点>>>清<<<按钮!")'
	..'\n'..
	'/E 已开始联盟【常规CD】的云分流排队，v1.409QX(2020-03-30)'
	..'\n'..
	'/E 欢迎加入免费CD联盟群【秘蓝玫瑰Ⅵ】，群号634966405'
	..'\n'..
	'/E 联动推荐其他免费CD交流群：365513777、576067091、948821001。' ;
	
	FreeMountCD_ExitMacro =   --'/click CD4M'
	'/W 永夜绽放之薇-艾森娜  0'
	..'\n'..
	'/W 永夜绽放之薇-艾森娜 版本1.409QX'
	..'\n'..
	'/W LMCD-战歌 0'
	..'\n'..
	'/W 林荫下的乞丐-安苏 0'
	..'\n'..
	'/W 波雅丶汉库克-埃雷达尔  0'
	..'\n'..
	'/W 聖殤-通灵学院  0'
	..'\n'..
	'/W 蚊飙-奥蕾莉亚 0'
	..'\n'..
	'/W 第三仙-轻风之语 0'
	..'\n'..
	'/W 子瓜-诺兹多姆 0'
	..'\n'..
	'/W 千山云影-雷霆号角 0'
	..'\n'..
	'/W 蛋总的徒弟-刺骨利刃 0'
	..'\n'..
	'/W 甜果冻-阿古斯 0'
	..'\n'..
	'/W 古南泉-白银之手 0'
	..'\n'..
	'/E 谁再组你都拒绝，祝红手！'
	..'\n'..
	'/run UIErrorsFrame:AddMessage("染冰冠堡垒的人，点 H 按钮切H难度！其他本严禁切H!")' ;
	  
	FreeMountCD_KLZMacro =   --'/click CD5M'
	'/script SetRaidDifficultyID(14)'
	..'\n'..
	'/script SetLegacyRaidDifficultyID(4)'
	..'\n'..
	'/run local M=function(a,b)SendChatMessage(b,"WHISPER",nil,a)end;M("永夜绽放之薇-艾森娜","9")M("LMCD-战歌","组")M("波雅丶汉库克-埃雷达尔","1")M("子瓜-诺兹多姆","1")M("古南泉-白银之手","1")M("第三仙-轻风之语","1")'
	..'\n'..
	'/run UIErrorsFrame:AddMessage("进本一定要点>>>清<<<按钮!")'
	..'\n'..
	'/E 已开始【史诗卡拉赞CD】的云分流排队' ;
	
  FreeMountCD_DanDaoMacro =     --'/click CD6M'
  '/script SetRaidDifficultyID(14)'
  ..'\n'..
  '/script SetLegacyRaidDifficultyID(4)'
  ..'\n'..
	'/run local M=function(a,b)SendChatMessage(b,"WHISPER",nil,a)end;M("永夜绽放之薇-艾森娜","9")M("LMCD-战歌","组")M("林荫下的乞丐-安苏","44296")M("波雅丶汉库克-埃雷达尔","1")M("聖殤-通灵学院","1")M("蚊飙-奥蕾莉亚","1")M("第三仙-轻风之语","1")M("子瓜-诺兹多姆","1")M("千山云影-雷霆号角","1")M("蛋总的徒弟-刺骨利刃","1")M("甜果冻-阿古斯","1")M("古南泉-白银之手","1")'
  ..'\n'..
  '/run UIErrorsFrame:AddMessage("进本一定要点>>>清<<<按钮!")'
  ..'\n'..
  '/E 已开始【蛋刀CD】云分流排队!,v1.409QX(2020-03-30)';
  
	FreeMountCD_AgdypxMacro =   --'/click CD7M'
	'/script SetRaidDifficultyID(14)'
	..'\n'..
	'/script SetLegacyRaidDifficultyID(4)'
	..'\n'..
	'/run local M=function(a,b)SendChatMessage(b,"WHISPER",nil,a)end;M("永夜绽放之薇-艾森娜","9")M("LMCD-战歌","组")M("林荫下的乞丐-安苏","44296")M("波雅丶汉库克-埃雷达尔","1")M("聖殤-通灵学院","1")M("蚊飙-奥蕾莉亚","1")M("第三仙-轻风之语","1")M("子瓜-诺兹多姆","1")M("千山云影-雷霆号角","1")M("蛋总的徒弟-刺骨利刃","1")M("甜果冻-阿古斯","1")M("古南泉-白银之手","1")'
	..'\n'..
	'/run UIErrorsFrame:AddMessage("CD君组你后一定要点 H 按钮，插件会自动为你切换10人英雄难度！看到切换提示后进本。")'
	..'\n'..
	'/E 已开始【决战奥格-小吼（H难度）】的CD云分流排队，v1.409QX(2020-03-30)' ;
	
	FreeMountCD_DingMacro =   --'/click CD12M'
	'/script SetRaidDifficultyID(14)'
	..'\n'..
	'/script SetLegacyRaidDifficultyID(4)'
	..'\n'..
	'/run local M=function(a,b)SendChatMessage(b,"WHISPER",nil,a)end;M("永夜绽放之薇-艾森娜","9")M("LMCD-战歌","组")M("林荫下的乞丐-安苏","44296")M("波雅丶汉库克-埃雷达尔","1")M("聖殤-通灵学院","1")M("蚊飙-奥蕾莉亚","1")M("子瓜-诺兹多姆","1")M("第三仙-轻风之语","1")'
	..'\n'..
	'/run UIErrorsFrame:AddMessage("如要染英雄难度请在被组后点 H 按钮，CD君切换10人英雄难度！看到切换提示后进本。")'
	..'\n'..
	'/E 已开始【定向CD（普通、H双难度）】的CD云分流排队，v1.409QX(2020-03-30)' ;
		
	FreeMountCD_CheckMacro =   --/click CD9M
	'/E 开始查询CD君在线状态……'
	..'\n'..
	'/W 永夜绽放之薇-艾森娜 检测是否处于营业状态……'
	..'\n'..
	'/W LMCD-战歌 在'
	..'\n'..
	'/W 林荫下的乞丐-安苏 在'
	..'\n'..
	'/W 波雅丶汉库克-埃雷达尔  在'
	..'\n'..
	'/W 聖殤-通灵学院  在'
	..'\n'..
	'/W 蚊飙-奥蕾莉亚 在'
	..'\n'..
	'/W 第三仙-轻风之语 在'
	..'\n'..
	'/W 子瓜-诺兹多姆 在'
	..'\n'..
	'/W 千山云影-雷霆号角 在'
	..'\n'..
	'/W 蛋总的徒弟-刺骨利刃 在'
	..'\n'..
	'/W 甜果冻-阿古斯 在'
	..'\n'..
	'/W 古南泉-白银之手 在';
	
elseif UnitFactionGroup("player") == "Horde" then
	FreeMountCD_GeneralMacro =   --'/click CD1M'
	'/script SetRaidDifficultyID(14)'
	..'\n'..
	'/script SetLegacyRaidDifficultyID(4)'
	..'\n'..
	'/run local M=function(a,b)SendChatMessage(b,"WHISPER",nil,a)end;M("郑矢娜-战歌","9")M("BLCDX-战歌","组")M("月色下的乞丐-辛达苟萨","44296")M("阿焦大做饭-希尔瓦娜斯","1")M("月娜-战歌","1")M("哞哞呜呜-瓦里安","1")M("假中医-死亡之翼","1")M("Lau-太阳之井","1")M("红了眼眶-血色十字军","1")M("罐子-冬寒","1")M("噬魔者-图拉扬","1")M("丿长空-凤凰之神","1")M("演员壹号-影之哀伤","1")M("想静静-贫瘠之地","1")M("亻壬忄生-安苏","1")M("王权富贵-海加尔","1")M("颜老师-风暴之鳞","1")M("肥肥鱼-沃金","1")M("时丶光-地狱咆哮","1")M("随心而遇-战歌","1")M("谎言-加尔","1")'
	..'\n'..
	'/run UIErrorsFrame:AddMessage("进本要点>>>清<<<按钮!")'
	..'\n'..
	'/E v1.409QX(2020-03-30)'
	..'\n'..
	'/E 免费CD群 819754629【嫣红蔷薇Ⅷ】欢迎您！'
	..'\n'..
	'/E 友群：365513777、805832208、948821001。';
	
	FreeMountCD_ExitMacro = --'/click CD2M'
	'/W 郑矢娜-战歌 0'
	..'\n'..
	'/W 郑矢娜-战歌 版本1.409QX'
	..'\n'..
	'/W BLCDX-战歌 0'
	..'\n'..
	'/W 月色下的乞丐-辛达苟萨 0'
	..'\n'..
	'/W 阿焦大做饭-希尔瓦娜斯 0'
	..'\n'..
	'/W 月娜-战歌 0'
	..'\n'..
	'/W 哞哞呜呜-瓦里安 0'
	..'\n'..
	'/W 假中医-死亡之翼 0'
	..'\n'..
	'/W Lau-太阳之井 0'
	..'\n'..
	'/W 红了眼眶-血色十字军 0'
	..'\n'..
	'/W 罐子-冬寒 0'
	..'\n'..
	'/W 噬魔者-图拉扬 0'
	..'\n'..
	'/W 丿长空-凤凰之神 0'
	..'\n'..
	'/W 演员壹号-影之哀伤 0'
	..'\n'..
	'/W 想静静-贫瘠之地 0'
	..'\n'..
	'/W 亻壬忄生-安苏 0'
	..'\n'..
	'/W 王权富贵-海加尔 0'
	..'\n'..
	'/W 颜老师-风暴之鳞 0'
	..'\n'..
	'/W 肥肥鱼-沃金 0'
	..'\n'..
	'/W 时丶光-地狱咆哮 0'
	..'\n'..
	'/W 随心而遇-战歌 0'
	..'\n'..
	'/W 谎言-加尔 0'
	..'\n'..
	'/E 谁再组你都拒绝，祝红手！'
	..'\n'..
	'/run UIErrorsFrame:AddMessage("染冰冠堡垒的人，点 H 按钮切H难度！其他本严禁切H!")';
	
	FreeMountCD_KLZMacro =   --'/click CD5M'
	'/script SetRaidDifficultyID(14)'
	..'\n'..
	'/script SetLegacyRaidDifficultyID(4)'
	..'\n'..
	'/run local M=function(a,b)SendChatMessage(b,"WHISPER",nil,a)end;M("郑矢娜-战歌","9")M("BLCDX-战歌","组")M("月色下的乞丐-辛达苟萨","44296")M("假中医-死亡之翼","1")M("Lau-太阳之井","1")M("噬魔者-图拉扬","1")M("想静静-贫瘠之地","1")M("亻壬忄生-安苏","1")M("时丶光-地狱咆哮","1")M("随心而遇-战歌","1")M("谎言-加尔","1")M("哞哞呜呜-瓦里安","1")'
	..'\n'..
	'/run UIErrorsFrame:AddMessage("进本一定要点>>>清<<<按钮!")'
	..'\n'..
	'/E 已开始【史诗卡拉赞CD】的云分流排队';
	
	FreeMountCD_DanDaoMacro =   --'/click CD6M'
	 '/script SetRaidDifficultyID(14)'
	 ..'\n'..
	 '/script SetLegacyRaidDifficultyID(4)'
	 ..'\n'..
	'/run local M=function(a,b)SendChatMessage(b,"WHISPER",nil,a)end;M("郑矢娜-战歌","9")M("BLCDX-战歌","组")M("月色下的乞丐-辛达苟萨","44296")M("阿焦大做饭-希尔瓦娜斯","1")M("月娜-战歌","1")M("哞哞呜呜-瓦里安","1")M("假中医-死亡之翼","1")M("Lau-太阳之井","1")M("红了眼眶-血色十字军","1")M("罐子-冬寒","1")M("噬魔者-图拉扬","1")M("丿长空-凤凰之神","1")M("演员壹号-影之哀伤","1")M("想静静-贫瘠之地","1")M("亻壬忄生-安苏","1")M("王权富贵-海加尔","1")M("颜老师-风暴之鳞","1")M("肥肥鱼-沃金","1")M("时丶光-地狱咆哮","1")M("随心而遇-战歌","1")M("谎言-加尔","1")'
	 ..'\n'..
	 '/run UIErrorsFrame:AddMessage("进本一定要点>>>清<<<按钮!")'
	 ..'\n'..
	 '/E 已开始【蛋刀CD】云分流排队，v1.409QX(2020-03-30)';
	
	FreeMountCD_AgdypxMacro =   --'/click CD7M'
	'/script SetRaidDifficultyID(14)'
	..'\n'..
	'/script SetLegacyRaidDifficultyID(4)'
	..'\n'..
	'/run local M=function(a,b)SendChatMessage(b,"WHISPER",nil,a)end;M("郑矢娜-战歌","9")M("BLCDX-战歌","组")M("月色下的乞丐-辛达苟萨","44296")M("阿焦大做饭-希尔瓦娜斯","1")M("月娜-战歌","1")M("哞哞呜呜-瓦里安","1")M("假中医-死亡之翼","1")M("Lau-太阳之井","1")M("红了眼眶-血色十字军","1")M("罐子-冬寒","1")M("噬魔者-图拉扬","1")M("丿长空-凤凰之神","1")M("演员壹号-影之哀伤","1")M("想静静-贫瘠之地","1")M("亻壬忄生-安苏","1")M("王权富贵-海加尔","1")M("颜老师-风暴之鳞","1")M("肥肥鱼-沃金","1")M("时丶光-地狱咆哮","1")M("随心而遇-战歌","1")M("谎言-加尔","1")'
	..'\n'..
	'/run UIErrorsFrame:AddMessage("CD君组你后一定要点 H 按钮，插件会自动为你切换10人英雄难度！看到切换提示后进本。")'
	..'\n'..
	'/E 已开始【决战奥格-小吼（H难度）】的CD云分流排队，版本1.409QX(2020-03-30))';
	
	FreeMountCD_DingMacro =   --'/click CD12M'
	'/script SetRaidDifficultyID(14)'
	..'\n'..
	'/script SetLegacyRaidDifficultyID(4)'
	..'\n'..
	'/run local M=function(a,b)SendChatMessage(b,"WHISPER",nil,a)end;M("郑矢娜-战歌","9")M("BLCDX-战歌","组")M("月色下的乞丐-辛达苟萨","44296")M("月娜-战歌","1")M("噬魔者-图拉扬","1")M("亻壬忄生-安苏","1")M("肥肥鱼-沃金","1")M("时丶光-地狱咆哮","1")M("随心而遇-战歌","1")M("谎言-加尔","1")M("哞哞呜呜-瓦里安","1")'
	..'\n'..
	'/run UIErrorsFrame:AddMessage("如要染英雄难度请在被组后点 H 按钮，CD君切换10人英雄难度！看到切换提示后进本。")'
	..'\n'..
	'/E 已开始【定向CD（普通、H双难度）】的CD云分流排队，版本1.409QX(2020-03-30))' ;
	
	FreeMountCD_CheckMacro =   --/click CD9M
	'/E 开始查询CD君在线状态……'
	..'\n'..
	'/W 郑矢娜-战歌 检测是否处于营业状态……'
	..'\n'..
	'/W BLCDX-战歌 在'
	..'\n'..
	'/W 月色下的乞丐-辛达苟萨 在'
	..'\n'..
	'/W 阿焦大做饭-希尔瓦娜斯 在'
	..'\n'..
	'/W 月娜-战歌 在'
	..'\n'..
	'/W 哞哞呜呜-瓦里安 在'
	..'\n'..
	'/W 假中医-死亡之翼 在'
	..'\n'..
	'/W Lau-太阳之井 在'
	..'\n'..
	'/W 红了眼眶-血色十字军 在'
	..'\n'..
	'/W 罐子-冬寒 在'
	..'\n'..
	'/W 噬魔者-图拉扬 在'
	..'\n'..
	'/W 丿长空-凤凰之神 在'
	..'\n'..
	'/W 演员壹号-影之哀伤 在'
	..'\n'..
	'/W 想静静-贫瘠之地 在'
	..'\n'..
	'/W 亻壬忄生-安苏 在'
	..'\n'..
	'/W 王权富贵-海加尔 在'
	..'\n'..
	'/W 颜老师-风暴之鳞 在'
	..'\n'..
	'/W 肥肥鱼-沃金 在'
	..'\n'..
	'/W 时丶光-地狱咆哮 在'
	..'\n'..
	'/W 随心而遇-战歌 在'
	..'\n'..
	'/W 谎言-加尔 在';
else return end
	
	
  FreeMountCD = M:CreatStyleButton("FreeMountCD", UIParent, 36, 36, "TOPLEFT", UIParent, "TOPLEFT", 121, -16, 1, 1, Bee, I.r, I.g, I.b)  --MMMMHIDE
  FreeMountCD:RegisterForClicks("LeftButtonUp")
	FreeMountCD:SetAttribute("type","macro")
  FreeMountCDText = M:CreatStyleText(FreeMountCD, STANDARD_TEXT_FONT, 11, "OUTLINE", "CD", "CENTER",FreeMountCD,"CENTER", 1, 0, 1, 1, 0)
  FreeMountCD:SetScript("OnClick", function(self) FreeMountCD_Main:Show() FreeMountCD:Hide() end)	
  
  FreeMountCD_Main = M:CreatStyleButton("FreeMountCD_Main", UIParent, 65, 65, "TOPLEFT", UIParent, "TOPLEFT", 268, -43, 1, 1, Bee, I.r, I.g, I.b)  --MMMM
  FreeMountCD_Main:RegisterForClicks("LeftButtonUp")
	FreeMountCD_Main:SetAttribute("type","macro")
  FreeMountCD_Main:SetMovable(true)
  FreeMountCD_Main:SetClampedToScreen(true)
  FreeMountCD_Main:RegisterForDrag("LeftButton", "RightButton")
  FreeMountCD_Main:SetScript("OnDragStart", function(self) self:StartMoving() end)
  FreeMountCD_Main:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  FreeMountCD_Main:Hide()
  FreeMountCD_MainText = M:CreatStyleText(FreeMountCD_Main, STANDARD_TEXT_FONT, 14, "OUTLINE", "CD", "CENTER", FreeMountCD_Main, "CENTER", 2, 0, 1, 1, 0)
  FreeMountCD_Main:SetScript("OnEnter", function(self)
  	GameTooltip:SetOwner(FreeMountCD_Main, "ANCHOR_TOP")
  	GameTooltip:AddLine("                【《魔兽世界》免费CD云分流终端】", 1, 2, 0)
  	GameTooltip:AddLine("                              【观星者】（国服）", 1, 0, 1)
  	GameTooltip:AddLine("  【版本1.409QX 群内三轨疾速版.（8.3.0）】", 0,6,6)
  	GameTooltip:AddLine("  【本终端是提供《魔兽世界》免费低级本进度功能的小工具插件】", 1, 0.4,0.8)
		GameTooltip:AddLine("  【此插件及其提供的服务永久免费，不收取任何形式的费用！】", 1, 0,0)
		GameTooltip:AddLine("  【任何人不得冒充插件版权拥有者、以有偿形式分享本插件！】", 1, 0,0)
		GameTooltip:AddLine("                                           ", 1, 0.4,0.8)
  	GameTooltip:AddLine("  _______________★【 使用方法 】★_______________", 1, 1, 1)
  	GameTooltip:AddLine("                   ", 1, 0.4,0.8)
  	GameTooltip:AddLine("               需求者必须仔细阅读各按钮所列的详细内容！ ", 1, 2, 0)
  	GameTooltip:AddLine("                                           ", 1, 0.4,0.8)
  	GameTooltip:AddLine("    先前往副本入口，在入口处点击获取CD，并进行下一步操作。", 0,6,6)
  	GameTooltip:AddLine("                ", 1, 0, 0)
  	GameTooltip:AddLine("  _______________★【 按钮简介 】★_______________", 1, 1, 1)
  	GameTooltip:AddLine("         ", 1, 0, 0)
  	GameTooltip:AddLine(" ●【BL/LM 按钮】", 1, 2,0)
  	GameTooltip:AddLine(" 提供常规免费CD，详见按钮里的说明。", I.r, I.g, I.b)
  	GameTooltip:AddLine("         ", 1, 0, 0)
  	GameTooltip:AddLine(" ●【 D C K 按钮】", 1, 2,0)
  	GameTooltip:AddLine(" 提供多向性CD，详见按钮里的说明。", I.r, I.g, I.b)
  	GameTooltip:AddLine("         ", 1, 0, 0)
  	GameTooltip:AddLine(" ●【 清   按钮】", 1, 2,0)
  	GameTooltip:AddLine(" CD君退队是自动的，这个按钮提供清除队列功能，进本后一定要点击！", I.r, I.g, I.b)
  	GameTooltip:AddLine("         ", 1, 0, 0)
  	GameTooltip:AddLine(" ●【 H 、10 按钮】", 1, 2,0)
  	GameTooltip:AddLine(" 提供冰冠堡垒、决战奥格小吼、定向类CD切H、切换10人难度的快捷键。", I.r, I.g, I.b)
  	GameTooltip:AddLine("         ", 1, 0, 0)
  	GameTooltip:AddLine(" ●【 S 、 L 按钮】", 1, 2,0)
  	GameTooltip:AddLine(" 插件用户手册、查询在线CD君按钮 。", I.r, I.g, I.b)
  	GameTooltip:AddLine("         ", 1, 0, 0)
  	GameTooltip:AddLine(">>★【点击“CD”按钮可最小化界面，鼠标拖拽可改变位置】★<< ", 0, 1,0)
  	GameTooltip:Show()
  	end)
  FreeMountCD_Main:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
  FreeMountCD_Main:SetScript("OnClick", function(self) FreeMountCD_Main:Hide() FreeMountCD:Show() end)

    FreeMountCD_General = M:CreatStyleButton("FreeMountCD_General", FreeMountCD_Main, 46, 46, "LEFT",FreeMountCD_Main,"RIGHT",0,0, 1, 1, Bee, 255/255, 215/255, 1/255)  --CDONE 255/255,106/255,106/255
    FreeMountCD_General:RegisterForClicks("LeftButtonUp")
	  FreeMountCD_General:SetAttribute("type","macro")
    FreeMountCD_GeneralText = M:CreatStyleText(FreeMountCD_General, STANDARD_TEXT_FONT, 14, "OUTLINE", "Go", "CENTER", FreeMountCD_General, "CENTER", 0, 0, 1, 1, 0)
    FreeMountCD_General:SetScript("OnEnter", function(self)
    	GameTooltip:SetOwner(FreeMountCD_General, "ANCHOR_TOP")
    	GameTooltip:AddLine(" >>>>>>>>>★【点击开始 常规CD 云分流】★<<<<<<<< ", 0, 1,0)
    	GameTooltip:AddLine("         ", 1, 0, 0)	
    	GameTooltip:AddLine("______________________【 CD清单 】______________________", 1, 2, 0)
    	GameTooltip:AddLine("         ", 1, 0, 0)	
    	GameTooltip:AddLine(" ▼—冰冠堡垒[无敌](必须25普通难度进本，再点 H 切英雄）", 0, 1,0)
    	GameTooltip:AddLine(" ▼—奥杜尔[飞机头](10人难度即可掉落，不要与守护者对话）", 0, 1,0)
    	GameTooltip:AddLine(" ▼—风神王座[南风幼龙]（不能切H）", 0, 1,0)
    	GameTooltip:AddLine(" ▼—火焰之地[纯血火鹰](火乌鸦、鹿盔、大螺丝)(不能切h)", 0, 1,0)
    	GameTooltip:AddLine(" ▼—黑翼血环[能量洪流](不能切h)", 0, 1,0)
    	GameTooltip:AddLine(" ▼—决战奥格  [谜语人坐骑任务]（傲之煞已死，进去拿书）", 0, 1,0)
    	GameTooltip:AddLine(" ▼—安其拉神殿[清醒的梦魇步骤] (克苏恩已死)", 0, 1,0)
    	GameTooltip:AddLine(" ▼—黑石铸造厂：[黑石之印](10号{黑手} 不能切m刷坐骑)", 0, 1,0)
    	GameTooltip:AddLine(" ▼—地狱火堡垒：[血环之印]( 5号{死眼} 不能切m刷坐骑)", 0, 1,0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine(" ▼请注意：由于7.35有BUG，巨龙之魂、魔古山宝库、雷神王座、永春台 的CD不能染 ", 1, 0,0)
    	GameTooltip:AddLine("            且目前都没有修复迹象，因此发布适应版，暂停供应此4个副本的CD！ ", 1, 0,0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine("______________________【！注意！】______________________", 1, 0,0)
    	GameTooltip:AddLine("          ", 1, 0, 0)
    	GameTooltip:AddLine("                                   ★进组之后尽快进本！ ", 1, 0.4,0.8)
    	GameTooltip:AddLine("          ", 1, 0, 0)
    	GameTooltip:AddLine("                  ★进本后必须点右侧【 “清”按钮 】★ ", 1, 2, 0)
    	GameTooltip:AddLine("          ", 1, 0, 0)
    	GameTooltip:AddLine("              ★染[冰冠堡垒]拿到队长后点【 H 】按钮！ ★", 1, 0.4,0.8)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine(" 如需染10人难度，进队后点击【 10 】按钮，将自动切10人 ", 1, 2, 0)
    	GameTooltip:AddLine("          ", 1, 0, 0)
    	GameTooltip:Show()
    	FreeMountCD_General:SetBackdropColor(0,0,0)
    	end)
    FreeMountCD_General:SetScript("OnLeave", function(self) GameTooltip:Hide() FreeMountCD_General:SetBackdropColor(255/255,106/255,106/255) end)	
    FreeMountCD_General:SetAttribute("macrotext",	FreeMountCD_GeneralMacro)

    FreeMountCD_Agdypx = M:CreatStyleButton("FreeMountCD_Agdypx", FreeMountCD_Main, 32, 32, "LEFT",FreeMountCD_General,"RIGHT",-32,-30, 1, 1, Bee, 255/255, 215/255, 1/255)
    FreeMountCD_Agdypx:RegisterForClicks("LeftButtonUp")
	  FreeMountCD_Agdypx:SetAttribute("type","macro")
    FreeMountCD_AgdypxText = M:CreatStyleText(FreeMountCD_Agdypx, STANDARD_TEXT_FONT, 12, "OUTLINE", "吼", "CENTER", FreeMountCD_Agdypx, "CENTER", 0, 0, 0,6,6)
    FreeMountCD_Agdypx:SetScript("OnEnter", function(self)
    	GameTooltip:SetOwner(FreeMountCD_Agdypx, "ANCHOR_TOP")
    	GameTooltip:AddLine(" >>★【点击开始 小吼CD（H难度）云分流】★<<", 0, 1,0)
    	GameTooltip:AddLine("         ", 1, 0, 0)	
    	GameTooltip:AddLine("_____________________【 CD清单 】____________________", 1, 2, 0)
    	GameTooltip:AddLine("         ", 1, 0, 0)	
    	GameTooltip:AddLine("                    ▼—决战奥格[小吼]（H难度）", 0, 1,0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine("                   动态CD，系统强制切10人难度！", 1, 2, 0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine("_____________________【！注意！】____________________", 1, 0,0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine("     ★此CD特殊，进组后点击后面的 H 按钮，再进本！", 0, 1,0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine("             ★提示已调整为10（英雄），即可进本！ ", 1, 2, 0)
    	GameTooltip:AddLine("          ", 1, 0, 0)
    	GameTooltip:AddLine("             ★进本后必须点右侧的【 “清”按钮 】★ ", 1, 2, 0)
    	GameTooltip:Show()
    	FreeMountCD_Agdypx:SetBackdropColor(0,0,0)
    	end)
    FreeMountCD_Agdypx:SetScript("OnLeave", function(self) GameTooltip:Hide() FreeMountCD_Agdypx:SetBackdropColor(255/255, 215/255, 1/255) end)
    FreeMountCD_Agdypx:SetAttribute("macrotext", FreeMountCD_AgdypxMacro)
    
    FreeMountCD_KLZ = M:CreatStyleButton("FreeMountCD_KLZ", FreeMountCD_Main, 46, 46, "LEFT",FreeMountCD_General,"RIGHT",-26,30, 1, 1, Bee, 255/255, 215/255, 1/255)
    FreeMountCD_KLZ:RegisterForClicks("LeftButtonUp")
	  FreeMountCD_KLZ:SetAttribute("type","macro")
    FreeMountCD_KLZText = M:CreatStyleText(FreeMountCD_KLZ, STANDARD_TEXT_FONT, 12, "OUTLINE", "赞", "CENTER", FreeMountCD_KLZ, "CENTER", 0, 0, 0, 6, 6)
    FreeMountCD_KLZ:SetScript("OnEnter", function(self)
    	GameTooltip:SetOwner(FreeMountCD_KLZ, "ANCHOR_TOP")
    	GameTooltip:AddLine("      >>>★【点击开始 重返卡拉赞CD 云分流】★<<< ", 0, 1,0)
    	GameTooltip:AddLine("         ", 1, 0, 0)	
    	GameTooltip:AddLine("__________________【 本CD为5人史诗难度 】__________________", 1, 2, 0)
    	GameTooltip:AddLine("         ", 1, 0, 0)	
    	GameTooltip:AddLine(" ▼—进入副本后穿过歌剧院，无视圣女和管家", 0, 1,0)
    	GameTooltip:AddLine(" ▼—直接击杀阿图门", 0, 1,0)
    	GameTooltip:AddLine(" ", 0, 1,0)
    	GameTooltip:AddLine(" ▼—本CD非24小时供应，如无CD君响应报名，请换时间染。", 0, 1,0)
    	GameTooltip:AddLine(" ▼—本CD不需要你进行任何操作，CD君的5人本难度已调整为史诗", 0, 1,0)
    	GameTooltip:AddLine(" ", 0, 1,0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine("_______________________【！注意！】______________________", 1, 0,0)
    	GameTooltip:AddLine("          ", 1, 0, 0)
    	GameTooltip:AddLine("                            ★进组之后尽快进本！ ", 1, 0.4,0.8)
    	GameTooltip:AddLine("          ", 1, 0, 0)
    	GameTooltip:AddLine("               ★进本后必须点右侧的【 “清”按钮 】★ ", 1, 2, 0)
    	GameTooltip:Show()
    	FreeMountCD_KLZ:SetBackdropColor(0,0,0)
    	end)
    FreeMountCD_KLZ:SetScript("OnLeave", function(self) GameTooltip:Hide() FreeMountCD_KLZ:SetBackdropColor(255/255, 215/255, 1/255) end)
    FreeMountCD_KLZ:SetAttribute("macrotext", FreeMountCD_KLZMacro)
    
    FreeMountCD_DanDao = M:CreatStyleButton("FreeMountCD_DanDao", FreeMountCD_Main, 32, 32, "LEFT",FreeMountCD_General,"RIGHT",-6,-30, 1, 1, Bee, 255/255, 215/255, 1/255)
    FreeMountCD_DanDao:RegisterForClicks("LeftButtonUp")
	  FreeMountCD_DanDao:SetAttribute("type","macro")
    FreeMountCD_DanDaoText = M:CreatStyleText(FreeMountCD_DanDao, STANDARD_TEXT_FONT, 12, "OUTLINE", "蛋", "CENTER", FreeMountCD_DanDao, "CENTER", 0, 0, 0, 6, 6)  
    FreeMountCD_DanDao:SetScript("OnEnter", function(self)
    	GameTooltip:SetOwner(FreeMountCD_DanDao, "ANCHOR_TOP")
    	GameTooltip:AddLine("            >>>★【点击开始 蛋刀CD 云分流】★<<< ", 0, 1,0)
    	GameTooltip:AddLine("         ", 1, 0, 0)	
    	GameTooltip:AddLine("__________【 本CD依靠时光BUG，不能保证永久有效 】__________", 1, 2, 0)
    	GameTooltip:AddLine("         ", 1, 0, 0)	
    	GameTooltip:AddLine(" ▼—进入副本后往里走一点，左手边有个破碎者NPC，对话传送", 0, 1,0)
    	GameTooltip:AddLine(" ▼—选择传送：命令大厅，一定不要自己往里跑，楼顶门打不开！", 0, 1,0)
    	GameTooltip:AddLine(" ▼—与阿卡玛对话，你会被卡在BOSS房间外，不用着急", 0, 1,0)
    	GameTooltip:AddLine(" ▼—在BOSS战围栏外耐心等脱战", 0, 1,0)
    	GameTooltip:AddLine(" ▼—脱战后再次与阿卡玛对话，就能正常打BOSS了！", 0, 1,0)
    	GameTooltip:AddLine(" ▼—如果蛋总跑出来了，直接打BOSS就行了！", 0, 1,0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine("_______________________【！注意！】______________________", 1, 0,0)
    	GameTooltip:AddLine("          ", 1, 0, 0)
    	GameTooltip:AddLine("                            ★进组之后尽快进本！ ", 1, 0.4,0.8)
    	GameTooltip:AddLine("          ", 1, 0, 0)
    	GameTooltip:AddLine("               ★进本后必须点右侧的【 “清”按钮 】★ ", 1, 2, 0)
    	GameTooltip:Show()
    	FreeMountCD_DanDao:SetBackdropColor(0,0,0)
    	end)
    FreeMountCD_DanDao:SetScript("OnLeave", function(self) GameTooltip:Hide() FreeMountCD_DanDao:SetBackdropColor(255/255, 215/255, 1/255) end)
    FreeMountCD_DanDao:SetAttribute("macrotext",FreeMountCD_DanDaoMacro)

    FreeMountCD_Ding = M:CreatStyleButton("FreeMountCD_Ding", FreeMountCD_Main, 46, 46, "LEFT",FreeMountCD_General,"RIGHT",-6,0, 1, 1, Bee, 255/255, 215/255, 1/255)
    FreeMountCD_Ding:RegisterForClicks("LeftButtonUp")
	  FreeMountCD_Ding:SetAttribute("type","macro")
    FreeMountCD_DingText = M:CreatStyleText(FreeMountCD_Ding, STANDARD_TEXT_FONT, 12, "OUTLINE", "定", "CENTER", FreeMountCD_Ding, "CENTER", 0, 0, 0, 1, 0)  
    FreeMountCD_Ding:SetScript("OnEnter", function(self)
    	GameTooltip:SetOwner(FreeMountCD_Ding, "ANCHOR_TOP")
		GameTooltip:AddLine(" >>★【点击开始 定向CD（普通、H双难度）云分流】★<<", 0, 1,0)
		GameTooltip:AddLine("         ", 1, 0, 0)	
		GameTooltip:AddLine("_____________________【 CD清单 】____________________", 1, 2, 0)
		GameTooltip:AddLine("         ", 1, 0, 0)	
		GameTooltip:AddLine("                    ▼—翡翠梦魇[萨维斯]", 0, 1,0)
		GameTooltip:AddLine("                    ▼—暗夜要塞[时空畸体、艾利桑德]", 0, 1,0)
		GameTooltip:AddLine("                    ▼—萨格拉斯之墓[主母]", 0, 1,0)
		GameTooltip:AddLine("                    ▼—燃烧王座[恶犬]", 0, 1,0)
		GameTooltip:AddLine("                       ", 1, 2, 0)
		GameTooltip:AddLine("                   动态CD，系统强制切10人难度！", 1, 2, 0)
		GameTooltip:AddLine("                       ", 1, 2, 0)
		GameTooltip:AddLine("_____________________【！注意！】____________________", 1, 0,0)
		GameTooltip:AddLine("                       ", 1, 2, 0)
		GameTooltip:AddLine("         ★本按钮CD为双难度CD，普通难度可直接进本！", 0, 1,0)
		GameTooltip:AddLine("         ★英雄难度，进组后点击后面的 H 按钮，再进本！", 0, 1,0)
		GameTooltip:AddLine("                       ", 1, 2, 0)
		GameTooltip:AddLine("         ★染英雄难度的，提示已调整为10（英雄），即可进本！ ", 1, 2, 0)
		GameTooltip:AddLine("          ", 1, 0, 0)
		GameTooltip:AddLine("             ★进本后必须点右侧的【 “清”按钮 】★ ", 1, 2, 0)
    	GameTooltip:Show()
    	FreeMountCD_Ding:SetBackdropColor(0,0,0)
    	end)
    FreeMountCD_Ding:SetScript("OnLeave", function(self) GameTooltip:Hide() FreeMountCD_Ding:SetBackdropColor(255/255, 215/255, 1/255) end)
    FreeMountCD_Ding:SetAttribute("macrotext",FreeMountCD_DingMacro)
    
    FreeMountCD_Exit = M:CreatStyleButton("FreeMountCD_Exit", FreeMountCD_Main, 65, 65, "LEFT",FreeMountCD_General,"RIGHT",36,0, 1, 1, Bee, I.r, I.g, I.b)
    FreeMountCD_Exit:RegisterForClicks("LeftButtonUp")
	  FreeMountCD_Exit:SetAttribute("type","macro")
    FreeMountCD_ExitText = M:CreatStyleText(FreeMountCD_Exit, STANDARD_TEXT_FONT, 13, "OUTLINE", "清", "CENTER", FreeMountCD_Exit, "CENTER", 2, 0, 1, 1, 0)
    FreeMountCD_Exit:SetScript("OnEnter", function(self)
    	GameTooltip:SetOwner(FreeMountCD_Exit, "ANCHOR_TOP")
    	GameTooltip:AddLine("       >>>>>>>★【点击清除 多余队列】★<<<<<<<",  0, 1,0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine("            请进本后一定要点击此按钮，清除多余的队列！", 1, 2,0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine("                           可避免您进入云分流死循环！", 1, 1,0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine(" 这个按钮不是让CD君退队用的，是清除其他CD君报名序列的", 1, 2,0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine("★染免费CD，做素质玩家！为他人让路，等于为自己让路！★", 1, 0.4,0.8)
    	GameTooltip:Show()
    	FreeMountCD_Exit:SetBackdropColor(0,0,0)
    	end)
    FreeMountCD_Exit:SetScript("OnLeave", function(self) GameTooltip:Hide() FreeMountCD_Exit:SetBackdropColor(I.r, I.g, I.b) end)	
    FreeMountCD_Exit:SetAttribute("macrotext", FreeMountCD_ExitMacro)
    
    FreeMountCD_TurnH = M:CreatStyleButton("FreeMountCD_TurnH", FreeMountCD_Main, 56, 56, "LEFT",FreeMountCD_General,"RIGHT",26,38, 1, 1, Bee, 0,6,6)
    FreeMountCD_TurnH:RegisterForClicks("LeftButtonUp")
	  FreeMountCD_TurnH:SetAttribute("type","macro")
    FreeMountCD_TurnHText = M:CreatStyleText(FreeMountCD_TurnH, STANDARD_TEXT_FONT, 12, "OUTLINE", "H", "CENTER", FreeMountCD_TurnH, "CENTER", 0, 0, 1,1,0)
    FreeMountCD_TurnH:SetScript("OnEnter", function(self)
    	GameTooltip:SetOwner(FreeMountCD_TurnH, "ANCHOR_TOP")
    	GameTooltip:AddLine(">>>>>>>>>>>>★【点击切换 英雄 模式】★<<<<<<<<<<<<",0, 1,0)
    	GameTooltip:AddLine("         ", 1, 0, 0)	
    	GameTooltip:AddLine("       染 冰冠堡垒  请进本后点击此按钮，切换  H  难度", 1, 2,0)
    	GameTooltip:AddLine("   ", 0, 1,0)
    	GameTooltip:AddLine("染 决战奥格[H小吼]，请进队后点此按钮，提示切换10H后进本", 1, 2,0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine("_______________________【！注意！】______________________", 1, 0,0)
    	GameTooltip:AddLine("         ", 1, 0, 0)	
    	GameTooltip:AddLine("             此按钮仅用于冰冠堡垒和决战奥格H小吼CD", 1, 0.4,0.8)
    	GameTooltip:AddLine("         ", 1, 0, 0)	
    	GameTooltip:AddLine("             染其他进度严禁使用此按钮，避免损失进度！", 1, 0,0)
    	GameTooltip:Show()
    	FreeMountCD_TurnH:SetBackdropColor(0,0,0)
    	end)
    FreeMountCD_TurnH:SetScript("OnLeave", function(self) GameTooltip:Hide() FreeMountCD_TurnH:SetBackdropColor(0,6,6) end)
    FreeMountCD_TurnH:SetAttribute("macrotext", '/run SelectGossipOption(1)StaticPopup1Button1:Click()SetRaidDifficultyID(15)' ..'\n'.. '/P YX10' ..'\n'.. '/E 切换副本难度为【英雄模式】！')

    FreeMountCD_TurnTen = M:CreatStyleButton("FreeMountCD_TurnTen", FreeMountCD_Main, 56, 56, "LEFT",FreeMountCD_General,"RIGHT",26,-38, 1, 1, Bee, 0,6,6)
    FreeMountCD_TurnTen:RegisterForClicks("LeftButtonUp")
	  FreeMountCD_TurnTen:SetAttribute("type","macro")
    FreeMountCD_TurnTenText = M:CreatStyleText(FreeMountCD_TurnTen, STANDARD_TEXT_FONT, 12, "OUTLINE", "10", "CENTER", FreeMountCD_TurnTen, "CENTER", 0, 0, 1,1,0)
    FreeMountCD_TurnTen:SetScript("OnEnter", function(self)
    	GameTooltip:SetOwner(FreeMountCD_TurnTen, "ANCHOR_TOP")
    	GameTooltip:AddLine(">>>>>>>>>>>>★【点击切换 10人 模式】★<<<<<<<<<<<<",0, 1,0)
    	GameTooltip:AddLine("         ", 1, 0, 0)	
    	GameTooltip:AddLine(" 小号想染10人难度，请进队后点此按钮，提示切换10人后进本", 1, 2,0)
    	GameTooltip:AddLine("      坐骑和幻象都是特殊掉率，人数不会影响坐骑掉率", 1, 2,0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine("_______________________【！注意！】______________________", 1, 0,0)
    	GameTooltip:AddLine("         ", 1, 0, 0)	
    	GameTooltip:AddLine("                       此按钮严禁用于冰冠堡垒！", 1, 0.4,0.8)
    	GameTooltip:AddLine("         ", 1, 0, 0)	
    	GameTooltip:AddLine("                       这个本的10人难度不给坐骑！", 1, 0.4,0.8)
    	GameTooltip:Show()
    	FreeMountCD_TurnTen:SetBackdropColor(0,0,0)
    	end)
    FreeMountCD_TurnTen:SetScript("OnLeave", function(self) GameTooltip:Hide() FreeMountCD_TurnTen:SetBackdropColor(0,6,6) end)
    FreeMountCD_TurnTen:SetAttribute("macrotext", '/E 切换为10人难度,请勿在此难度下进入【冰冠堡垒】！' ..'\n'.. '/P 10')	
    
    FreeMountCD_Copyright = M:CreatStyleButton("FreeMountCD_Copyright", FreeMountCD_Main, 56, 56, "LEFT",FreeMountCD_Main,"RIGHT",-35,38, 1, 1, Bee, 0,6,6)
    FreeMountCD_Copyright:RegisterForClicks("LeftButtonUp")
	  FreeMountCD_Copyright:SetAttribute("type","macro")
    FreeMountCD_CopyrightText = M:CreatStyleText(FreeMountCD_Copyright, STANDARD_TEXT_FONT, 12, "OUTLINE", "S", "CENTER", FreeMountCD_Copyright, "CENTER", 0, 0, 1,1,0)
    FreeMountCD_Copyright:SetScript("OnEnter", function(self)
    	GameTooltip:SetOwner(FreeMountCD_Copyright, "ANCHOR_TOP")
    	GameTooltip:AddLine("                                                                                      【免费CD云分流终端用户协议】", 1, 2, 0)
    	GameTooltip:AddLine("                ", I.r, I.g, I.b)
    	GameTooltip:AddLine("                   ____________________________________________________★【 插件守则 】★___________________________________________________", 1, 1, 1)
    	GameTooltip:AddLine("    本插件提供的功能来自于魔兽世界游戏内，由自愿参与此项公益的志愿者，以个人在线方式共享的方式提供，我们自称CD君或CD姬。", 1, 0.4,0.8)
    	GameTooltip:AddLine("    我们所做的免费共享，并非针对收费CD的抵制行为，也不是别有用心，单纯公益，请不要对我们做的事做不负责任的揣测和诽谤。", 1, 0.4,0.8)
    	GameTooltip:AddLine("    此名单内的CD君，仅因志同道合而集中在一起，互相之间没有隶属关系和管辖权限，仅由我代为做一定的支持性协调与调度。", 1, 0.4,0.8)
    	GameTooltip:AddLine("    由于每位志愿者的条件和能力有限，我们提供的服务也是公益性质，非义务和盈利目的，因此我们提供的免费CD行为，不承担因此对使用者产生的任", 1, 0.4,0.8)
    	GameTooltip:AddLine("何可能后果的责任，包括但不限于服务中断、服务拒绝、使用者进度受损、封号等，我们不承诺提供的公益服务能够完美、不间断、高效，一切量力而行。", 1, 0.4,0.8)
    	GameTooltip:AddLine("                                                        我们能承诺的，只有会尽自己所能，去做想做的公益，不忘初心。", 1, 2, 0)
    	GameTooltip:AddLine("※请使用本插件的用户，在官方渠道获取本插件，如在非官方途径获取盗版插件而产生任何诸如账号丢失、财物受损等后果，我方不承担法律及道德责任！", 1, 0,0)
    	GameTooltip:AddLine("         ※严禁任何人私自修改插件内容，包括且不限于数据、指令、名单、结构、代码、声明、文字等，自行改装，恶意篡改，均后果自负", 1, 0,0)
    	GameTooltip:AddLine("我们希望在此基础上，能够为魔兽世界国服玩家，提供一个有爱共享的免费CD公益，也请所有享受此福利的玩家，共同维护使用环境，拒绝自私与低素质。", 1, 0.4,0.8)
    	GameTooltip:AddLine("                   如您无法认同及接受以上观点，请彻底删除本插件，拒绝使用；使用本插件即意味着您本插件及插件涉及的行为不存在异议。", 1, 2, 0)
    	GameTooltip:AddLine("                ", I.r, I.g, I.b)
    	GameTooltip:AddLine("      _____________________________________________________________★【 版权声明 】★__________________________________________________________", 1, 1, 1)
    	GameTooltip:AddLine("    此插件的所有权利，包括历届版权、修改、使用、定义、共享、终止、最终解释权等，均归属郑矢娜、徒手破九霄与所有在该插件名单内的CD君", 1, 2, 0)
    	GameTooltip:AddLine("任何人不得将此插件以及其中的内容、可能产生的效果和衍生事物，用于商业盈利、非法获利、不当用途及其他我方不可接受的行为。", 1, 2, 0)
    	GameTooltip:AddLine("                                                            此插件的提供者和维护者，有权并保留追究此类行为相关责任的权利！", 1, 2, 0)
    	GameTooltip:AddLine("                                                        ※插件设计和提供：【徒手破九霄-格瑞姆巴托】  优化与维护：【郑矢娜-战歌】", 1, 2, 0)
    	GameTooltip:AddLine("                                                              所使用音乐的版权，属于演唱者——我最喜欢的歌手之一：西国の海妖。            ", I.r, I.g, I.b)
    	GameTooltip:AddLine("                ", I.r, I.g, I.b)
    	GameTooltip:Show()
    	FreeMountCD_Copyright:SetBackdropColor(0,0,0)
    	end)
    FreeMountCD_Copyright:SetScript("OnLeave", function(self) GameTooltip:Hide() FreeMountCD_Copyright:SetBackdropColor(0,6,6) end)
    FreeMountCD_Copyright:SetAttribute("macrotext", FreeMountCD_CopyrightMacro)
    
    FreeMountCD_Check = M:CreatStyleButton("FreeMountCD_Check", FreeMountCD_Main, 56, 56, "LEFT",FreeMountCD_Main,"RIGHT",-35,-38, 1, 1, Bee, 0,6,6)
    FreeMountCD_Check:RegisterForClicks("LeftButtonUp")
	  FreeMountCD_Check:SetAttribute("type","macro")
    FreeMountCD_CheckText = M:CreatStyleText(FreeMountCD_Check, STANDARD_TEXT_FONT, 12, "OUTLINE", "L", "CENTER", FreeMountCD_Check, "CENTER", 0, 0, 1,1,0)
    FreeMountCD_Check:SetScript("OnEnter", function(self)
    	GameTooltip:SetOwner(FreeMountCD_Check, "ANCHOR_TOP")
    	GameTooltip:AddLine("      >>>★【点击开始 查看CD君是否在线？】★<<<", 0, 1,0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine(" 多数CD君非24小时在线值守，本按钮用于查询在线CD君人数", 1, 2, 0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine("                 点击该按钮，可以看到CD君是否在线！", 0, 1,0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine("                  【未显示的CD君即未上线或未营业】", 1, 2, 0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine("  _____________________【！注意！】____________________", 1, 0,0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:AddLine(" 如果在每周的高峰日，发现CD君在线少，建议换个时间段染CD ", 1, 2, 0)
    	GameTooltip:AddLine("                       ", 1, 2, 0)
    	GameTooltip:Show()
    	FreeMountCD_Check:SetBackdropColor(0,0,0)
    	end)
    FreeMountCD_Check:SetScript("OnLeave", function(self) GameTooltip:Hide() FreeMountCD_Check:SetBackdropColor(0,6,6) end)
    FreeMountCD_Check:SetAttribute("macrotext", FreeMountCD_CheckMacro)	
    
--声音按钮，，主要是懒,全复制粘贴。所以写成下面这样。上面用宏调用这些按钮	
CD1M = M:CreatStyleButton("CD1M", UIParent, 0, 0, "LEFT",FreeMountCD_Main,"RIGHT",0,0,0,0,6,6)
CD1M:SetScript("OnClick", function() PlaySoundFile(tostring("Interface\\AddOns\\_ShiGuang\\Media\\Sounds\\FreeMountCD\\1.mp3")) end)
CD2M = M:CreatStyleButton("CD2M", UIParent, 0, 0, "LEFT",FreeMountCD_Main,"RIGHT",0,0,0,0,6,6)
CD2M:SetScript("OnClick", function() PlaySoundFile(tostring("Interface\\AddOns\\_ShiGuang\\Media\\Sounds\\FreeMountCD\\2.mp3")) end)
CD3M = M:CreatStyleButton("CD3M", UIParent, 0, 0, "LEFT",FreeMountCD_Main,"RIGHT",0,0,0,0,6,6)
CD3M:SetScript("OnClick", function() PlaySoundFile(tostring("Interface\\AddOns\\_ShiGuang\\Media\\Sounds\\FreeMountCD\\3.mp3")) end)
CD4M = M:CreatStyleButton("CD4M", UIParent, 0, 0, "LEFT",FreeMountCD_Main,"RIGHT",0,0,0,0,6,6)
CD4M:SetScript("OnClick", function() PlaySoundFile(tostring("Interface\\AddOns\\_ShiGuang\\Media\\Sounds\\FreeMountCD\\4.mp3")) end)
CD5M = M:CreatStyleButton("CD5M", UIParent, 0, 0, "LEFT",FreeMountCD_Main,"RIGHT",0,0,0,0,6,6)
CD5M:SetScript("OnClick", function() PlaySoundFile(tostring("Interface\\AddOns\\_ShiGuang\\Media\\Sounds\\FreeMountCD\\5.mp3")) end)
CD6M = M:CreatStyleButton("CD6M", UIParent, 0, 0, "LEFT",FreeMountCD_Main,"RIGHT",0,0,0,0,6,6)
CD6M:SetScript("OnClick", function() PlaySoundFile(tostring("Interface\\AddOns\\_ShiGuang\\Media\\Sounds\\FreeMountCD\\6.mp3")) end)
CD7M = M:CreatStyleButton("CD7M", UIParent, 0, 0, "LEFT",FreeMountCD_Main,"RIGHT",0,0,0,0,6,6)
CD7M:SetScript("OnClick", function() PlaySoundFile(tostring("Interface\\AddOns\\_ShiGuang\\Media\\Sounds\\FreeMountCD\\7.mp3")) end)
CD8M = M:CreatStyleButton("CD8M", UIParent, 0, 0, "LEFT",FreeMountCD_Main,"RIGHT",0,0,0,0,6,6)
CD8M:SetScript("OnClick", function() PlaySoundFile(tostring("Interface\\AddOns\\_ShiGuang\\Media\\Sounds\\FreeMountCD\\8.mp3")) end)
CD9M = M:CreatStyleButton("CD9M", UIParent, 0, 0, "LEFT",FreeMountCD_Main,"RIGHT",0,0,0,0,6,6)
CD9M:SetScript("OnClick", function() PlaySoundFile(tostring("Interface\\AddOns\\_ShiGuang\\Media\\Sounds\\FreeMountCD\\9.mp3")) end)
CD10M = M:CreatStyleButton("CD10M", UIParent, 0, 0, "LEFT",FreeMountCD_Main,"RIGHT",0,0,0,0,6,6)
CD10M:SetScript("OnClick", function() PlaySoundFile(tostring("Interface\\AddOns\\_ShiGuang\\Media\\Sounds\\FreeMountCD\\10.mp3")) end)
CD11M = M:CreatStyleButton("CD11M", UIParent, 0, 0, "LEFT",FreeMountCD_Main,"RIGHT",0,0,0,0,6,6)
CD11M:SetScript("OnClick", function() StopMusic();PlayMusic(tostring("Interface\\AddOns\\_ShiGuang\\Media\\Sounds\\FreeMountCD\\11.mp3")); end)
end