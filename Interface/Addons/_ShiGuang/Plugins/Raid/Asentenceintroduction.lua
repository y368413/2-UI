--插件作者：janyroo  插件版本：v1.0.2
if GetLocale() == "zhCN" then
	Raiders_List = {
			["怪物"] = {
				{name = "测试：被诅咒的黑暗犬", raiders = "测试：提前和队伍商量好是一起顺时针跑还是用技能往回传送。"},
			},
			["技能"] = {
				{name = "测试：邪能冲撞", raiders = "测试：敌人正在施放邪能冲撞"},
			},
			["阿塔达萨"] = {
				{name = "邪灵劣魔", raiders = "为了部落。你的敌人很弱小，快碾碎它"},
				{name = "沃卡尔", raiders = "3个图腾必须一起死，图腾死了再打Boss。"},
				{name = "莱赞", raiders = "卡视角躲恐惧，被点名跑河道，别踩土堆。"},
				{name = "女祭司阿伦扎", raiders = "秒ADD，Boss吸血前，血水一人一滩。"},
				{name = "亚兹玛", raiders = "除坦克其他人出分身前集中。"},
			},
			["地渊孢林"] = {
				{name = "长者莉娅克萨", raiders = "打断、Boss冲锋位置远离。"},
				{name = "被感染的岩喉", raiders = "8秒内踩掉小虫子，躲喷吐和冲锋。"},
				{name = "孢子召唤者赞查", raiders = "利用顺劈和点名清蘑菇，躲球。"},
				{name = "不羁畸变怪", raiders = "集体移动，利用清理光圈消debuff，全力输出Boss，输出越高能量越快小怪出得越快Boss死得越快。"},
			},
			["自由镇"]	= {
				{name = "尤朵拉船长", raiders = "音量开大听着夏一可小姐姐的声音嗨起来。"},
				{name = "乔里船长", raiders = "音量开大听着夏一可小姐姐的声音嗨起来。"},
				{name = "拉乌尔船长", raiders = "音量开大听着夏一可小姐姐的声音嗨起来。"},
				{name = "天空上尉库拉格", raiders = "冲锋前有旋涡，看到就躲开，分散点站，中了绿水，跑出范围。"},
				{name = "托萨克", raiders = "远程治疗看到血池就先站到边上去，一般鲨鱼刚扔出来都是点远程，确认丢自己了跑进血池去等鲨鱼追过来。"},
				{name = "哈兰·斯威提", raiders = "出小怪控一下，远程能点就点掉，点不掉或者是进战队，就看清楚只要不是点自己，就冲过去先干掉，省得自爆。"},
			},
			["诸王之眠"]	= {
				{name = "征服者阿卡阿里", raiders = "最早被打死的那个Boss会时不时出现，智者(毒性新星)一定要打断，征服者的翻滚记得直线分担。"},
				{name = "智者扎纳扎尔", raiders = "最早被打死的那个Boss会时不时出现，智者(毒性新星)一定要打断，征服者的翻滚记得直线分担。"},
				{name = "屠夫库拉", raiders = "最早被打死的那个Boss会时不时出现，智者(毒性新星)一定要打断，征服者的翻滚记得直线分担。"},
				{name = "黄金风蛇", raiders = "吐金是直线方向AOE，旋风斩躲开就好，出小怪能打掉就打能控就控。"},
				{name = "殓尸者姆沁巴", raiders = "重点是不要开错棺材，有队友的那个会抖动。"},
				{name = "达萨大王", raiders = "提前和队伍商量好是一起顺时针跑还是用技能往回传送。"},
			},
			["风暴神殿"]	= {
				{name = "阿库希尔", raiders = "点名出人群，驱散或到时间后所有人躲海浪、躲冲锋。"},
				{name = "铁舟修士", raiders = "先女人，急速圈第一时间吃。"},
				{name = "唤风者菲伊", raiders = "先女人，急速圈第一时间吃。"},
				{name = "斯托颂勋爵", raiders = "被点名的抓紧时间撞球，其他人攻击救人。"},
				{name = "低语者沃尔兹斯", raiders = "躲拍地面的触须，打断，转阶段先集火打一边。"},
			},
			["围攻伯拉勒斯"]	= {
				{name = "拜恩比吉中士", raiders = "点名带着风筝，把Boss风筝到炸弹和轰炸区里去。"},
				{name = "恐怖船长洛克伍德", raiders = "躲AOE，秒ADD，捡道具把Boss打下船。"},
				{name = "哈达尔·黑渊", raiders = "躲正面，雕像附近别放白圈。"},
				{name = "维克戈斯", raiders = "t拉住攻城触须dps救人开炮，躲地面技能。"},
			},
			["塞塔里斯神庙"]	= {
				{name = "阿德里斯", raiders = "打身上没电的那个，躲正面，近战范围分散。"},
				{name = "阿斯匹克斯", raiders = "打身上没电的那个，躲正面，近战范围分散。"},
				{name = "米利克萨", raiders = "定身/控制技能救队友，路径躲开。"},
				{name = "加瓦兹特", raiders = "挡好电，挡1个塔等buff消掉了再去挡。"},
				{name = "萨塔里斯的化身", raiders = "驱散、在没有层数的时候治疗Boss/用球，蛤蟆第一时间打掉不然别怪奶不动。"},
			},
			["托尔达戈"]	= {
				{name = "泥沙女王", raiders = "躲陷阱，小虫治疗OT杀。"},
				{name = "杰斯·豪里斯", raiders = "提前开牢房清怪，打断恐惧，飞刀卡视野，P2集火Boss。"},
				{name = "骑士队长瓦莱莉", raiders = "留一个安全角落就行。"},
				{name = "科古斯狱长", raiders = "靠墙分散，用最少的移动躲技能，1层点名自己吃，2层开始坦克/其他职业帮挡。"},
			},
			["维克雷斯庄园"]	= {
				{name = "贪食的拉尔", raiders = "躲正面技能，躲地上绿水，杀ADD。"},
				{name = "魂缚巨像", raiders = "层数过高时把boss带到野火上烤一下，其他人躲灵魂。"},
				{name = "女巫布里亚", raiders = "输出变大的Boss，打断，队友被控制晕着打。"},
				{name = "女巫马拉迪", raiders = "输出变大的Boss，打断，队友被控制晕着打。"},
				{name = "女巫索林娜", raiders = "输出变大的Boss，打断，队友被控制晕着打。"},
				{name = "维克雷斯勋爵和夫人", raiders = "中毒出人群，躲漩涡。"},
				{name = "维克雷斯夫人", raiders = "中毒出人群，躲漩涡。"},
				{name = "高莱克·图尔", raiders = "先杀奴隶主，捡瓶子烧尸体。"},
			},
			["暴富矿区！！"]	= {
				{name = "投币式群体打击者", raiders = "躲正面、把球踢还给Boss。"},
				{name = "艾泽洛克", raiders = "躲正面、先杀小怪。"},
				{name = "瑞克莎·流火", raiders = "保证身后没有黄水和即将喷发的管子。"},
				{name = "商业大亨拉兹敦克", raiders = "P1留心直升机轰炸，点名出人群，P2被点名跑到钻头下面。"},
			},
			["奥迪尔"]	= {
				{name = "塔罗克", raiders = ""},
				{name = "噬魂者", raiders = "男人脸注意打断\"魅影冲击\"技能,红色连线出现时立即停止攻击;胖子脸远离鬼魂;女人脸躲开正面\"哀嚎之魂\"技能的扫射范围。"},
			},		
	}
elseif GetLocale() == "zhTW" then
	Raiders_List = {
			["阿塔達薩"] = {
				{name = "沃卡爾", raiders = "3個圖騰必須一起死，圖騰死了再打Boss。"},
				{name = "萊贊", raiders = "卡視角躲恐懼，被點名跑河道，別踩土堆。"},
				{name = "女祭司阿倫紮", raiders = "秒ADD，Boss吸血前，血水一人一灘。"},
				{name = "亞茲瑪", raiders = "除坦克其他人出分身前集中。"},
			},
			["地淵孢林"] = {
				{name = "長者莉婭克薩", raiders = "打斷、Boss衝鋒位置遠離。"},
				{name = "被感染的岩喉", raiders = "8秒內踩掉小蟲子，躲噴吐和衝鋒。"},
				{name = "孢子召喚者贊查", raiders = "利用順劈和點名清蘑菇，躲球。"},
				{name = "不羈畸變怪", raiders = "集體移動，利用清理光圈消debuff，全力輸出Boss，輸出越高能量越快小怪出得越快Boss死得越快。"},
			},
			["自由鎮"]	= {
				{name = "天空上尉庫拉格", raiders = "衝鋒前有旋渦，看到就躲開，衝鋒前有旋渦，看到就躲開，分散點站，中了綠水，跑出範圍。"},
				{name = "托薩克", raiders = "遠程治療看到血池就先站到邊上去，一般鯊魚剛扔出來都是點遠程，確認丟自己了跑進血池去等鯊魚追過來。"},
				{name = "哈蘭·斯威提", raiders = "出小怪控一下，遠程能點就點掉，點不掉或者是進戰隊，就看清楚只要不是點自己，就沖過去先幹掉，省得自爆。"},
			},
			["諸王之眠"]	= {
				{name = "黃金風蛇", raiders = "吐金是直線方向AOE，旋風斬躲開就好，出小怪能打掉就打能控就控。"},
				{name = "殮屍者姆沁巴", raiders = "重點是不要開錯棺材，有隊友的那個會抖動。"},
				{name = "始皇達薩", raiders = "提前和隊伍商量好是一起順時針跑還是用技能往回傳送。"},
			},
			["風暴神殿"]	= {
				{name = "阿庫希爾", raiders = "點名出人群，驅散或到時間後所有人躲海浪、躲衝鋒。"},
				{name = "鐵舟修士", raiders = "先女人，急速圈第一時間吃。"},
				{name = "喚風者菲伊", raiders = "先女人，急速圈第一時間吃。"},
				{name = "斯托頌勳爵", raiders = "被點名的抓緊時間撞球，其他人攻擊救人。"},
				{name = "低語者沃爾茲斯", raiders = "躲拍地面的觸鬚，打斷，轉階段先集火打一邊。"},
			},
			["圍攻伯拉勒斯"]	= {
				{name = "拜恩比吉中士", raiders = "點名帶著風箏，把Boss風箏到炸彈和轟炸區裏去。"},
				{name = "恐怖船長洛克伍德", raiders = "躲AOE，秒ADD，撿道具把Boss打下船。"},
				{name = "哈達爾·黑淵", raiders = "躲正面，雕像附近別放白圈。"},
				{name = "維克戈斯", raiders = "先集火殺攻城觸鬚再救人開炮，躲地面技能，轉場時不要被木板什麼的卡住。"},
			},
			["塞塔裏斯神廟"]	= {
				{name = "阿德裏斯", raiders = "打身上沒電的那個，躲正面，近戰範圍分散。"},
				{name = "阿斯匹克斯", raiders = "打身上沒電的那個，躲正面，近戰範圍分散。"},
				{name = "米利克薩", raiders = "定身/控制技能救隊友，路徑躲開。"},
				{name = "加瓦茲特", raiders = "擋好電，擋1個塔等buff消掉了再去擋。"},
				{name = "薩塔裏斯的化身", raiders = "驅散、在沒有層數的時候治療Boss/用球，蛤蟆第一時間打掉不然別怪奶不動。"},
			},
			["托爾達戈"]	= {
				{name = "泥沙女王", raiders = "躲陷阱，小蟲治療OT殺。"},
				{name = "傑斯·豪裏斯", raiders = "提前開牢房清怪，打斷恐懼，飛刀卡視野，P2集火Boss。"},
				{name = "騎士隊長瓦萊莉", raiders = "留一個安全角落就行。"},
				{name = "科古斯獄長", raiders = "靠牆分散，用最少的移動躲技能，1層點名自己吃，2層開始坦克/其他職業幫擋。"},
			},
			["維克雷斯莊園"]	= {
				{name = "貪食的拉爾", raiders = "躲正面技能，躲地上綠水，殺ADD。"},
				{name = "魂縛巨像", raiders = "層數過高時把boss帶到野火上烤一下，其他人躲靈魂。"},
				{name = "女巫布裏亞", raiders = "輸出變大的Boss，打斷，隊友被控制暈著打。"},
				{name = "維克雷斯勳爵和夫人", raiders = "中毒出人群，躲漩渦。"},
				{name = "維克雷斯夫人", raiders = "中毒出人群，躲漩渦。"},
				{name = "高萊克·圖爾", raiders = "先殺奴隸主，撿瓶子燒屍體。"},
			},
			["暴富礦區！！"]	= {
				{name = "投幣式群體打擊者", raiders = "躲正面、把球踢還給Boss。"},
				{name = "艾澤洛克", raiders = "躲正面、先殺小怪。"},
				{name = "瑞克莎·流火", raiders = "保證身後沒有黃水和即將噴發的管子。"},
				{name = "商業大亨拉茲敦克", raiders = "P1留心直升機轟炸，點名出人群，P2被點名跑到鑽頭下麵。"},
			},
		["眾魂熔爐"]	= {
			{name = "布隆亚姆", raiders = "P1被点名远离Boss,DPS集火紫色灵魂球,球吃控制;P2靠近Boss,被恐惧进入风暴者迅速返回中心,治疗加好被恐惧者。"},
			{name = "噬魂者", raiders = "男人脸注意打断\"魅影冲击\"技能,红色连线出现时立即停止攻击;胖子脸远离鬼魂;女人脸躲开正面\"哀嚎之魂\"技能的扫射范围。"},
		},
	}
else
	Raiders_List = {}
end

--JANY核对信息
local function getRaidersByEncounterName(name)
for i,k in pairs(Raiders_List) do
	for i,v in pairs(k) do
		if v.name == name then return v.raiders end
	end
end
end

--JANY-- 发信息
function SendBossNotes(bossname)
	local raidersText
	local encounterName
	if EncounterJournal and EncounterJournal.encounterID then
		encounterName = EJ_GetEncounterInfo(EncounterJournal.encounterID)
	end
	if bossname then
		raidersText = getRaidersByEncounterName(bossname) or "无此BOSS数据"
	elseif encounterName then
		raidersText = getRaidersByEncounterName(encounterName) or "无此BOSS数据"
		bossname = encounterName
	end
	if raidersText and bossname and raidersText~="无此BOSS数据" then
		--if IsInRaid() then
			--SendChatMessage(bossname .. raidersText, (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT") or "raid");
		--elseif IsInGroup() then
			--SendChatMessage(bossname .. raidersText, (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT") or "party");
		--else
			--SendChatMessage(bossname .. raidersText, "say");
		--end
		DEFAULT_CHAT_FRAME:AddMessage("--------[攻略]-------------------------------",1,0,0)
		DEFAULT_CHAT_FRAME:AddMessage(bossname .. "-" .. raidersText)
		DEFAULT_CHAT_FRAME:AddMessage("-------------------------------[攻略]--------",1,0,0)
	--else
		--DEFAULT_CHAT_FRAME:AddMessage("测试：数据库无此数据",1,0,0)
	end
end

local Bossnote=CreateFrame("Frame","Bossnote",UIParent)--JANY
Bossnote:RegisterEvent("PLAYER_TARGET_CHANGED")
Bossnote:SetScript("OnEvent", function (self,event)
	if event == "PLAYER_TARGET_CHANGED" then
		if UnitName("target") == nil then return end
		SendBossNotes(UnitName("target"));
	end	
end);