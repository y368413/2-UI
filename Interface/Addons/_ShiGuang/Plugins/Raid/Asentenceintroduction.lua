--插件作者：janyroo  插件版本：v1.0.2 updata for11.0.5 by y368413 and 糊涂
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
    ["千丝之城"] = {
        -- BOSS部分
        {name = "演说者基克斯威兹克", raiders = "{rt8}演说者基克斯威兹克{rt8}||开打以BOSS为中心身边出个圈，所有人保持自己在boss圈内，并躲开头前||两个疑之影点名，让开先驱散一个||喧神教化AOE时所有人提前跑位到BOSS头前||||BOSS定期砸地板放黑水需要坦克拉开||圈只会跟BOSS走，坦克不拉走大家只好硬踩黑水了！"},
        {name = "女王之牙", raiders = "{rt8}女王之牙{rt8}||打正在攻击的BOSS||P1: 恩格斯攻击，躲各种地板，维克斯释放寒冰镰刀时，两两分散，不要站一条直线，并开减伤应对之后的DEBUFF||P2: 维克斯攻击，点T白圈集中踩，避免倒T；点名紫圈原来人群。"},
        {name = "凝结聚合体", raiders = "{rt8}凝结聚合体{rt8}||BOSS召唤黑球从场地边缘飞向BOSS||需要去接球别让BOSS吃球回血||吃到球的队友会染一个DEBUFF需要奶妈刷爆他。"},
        {name = "大捻接师艾佐", raiders = "{rt8}大捻接师艾佐{rt8}||BOSS会点名所有人几秒后脚下出软泥||在打死软泥之前无限定身||需要所有人在点名时集合方便速度AOE掉软泥||如果能自己解定身的职业可以无视||否则会一直定身影响后续需要跑位技能的躲避。"},
        -- 小怪部分
        {name = "苏雷吉缚丝者", raiders = "{rt8}苏雷吉缚丝者{rt8}||{rt1}流丝缠缚{rt1}必须打断"},
        {name = "皇家虫群卫士", raiders = "{rt8}皇家虫群卫士{rt8}||{rt1}贪婪之虫{rt1}需要全员减伤"},
        {name = "安苏雷克的传令官", raiders = "{rt8}安苏雷克的传令官{rt8}||{rt1}扭曲思绪{rt1}必须打断"},
        {name = "隐秘网士", raiders = "{rt8}隐秘网士{rt8}||主目标优先击杀。阴织冲击、愈合之网必须打断"},
        {name = "苏雷吉反自然者", raiders = "{rt8}苏雷吉反自然者{rt8}||{rt1}虚空之波{rt1}，尽量群控，尽量打断"},
        {name = "长者织影", raiders = "{rt8}长者织影{rt8}||{rt1}晦幽纺纱{rt1}需要集中站位，A掉限制移动的网"},
    },
    ["驭雷栖巢"] = {
        -- BOSS部分
        {name = "凯里欧斯", raiders = "{rt8}凯里欧斯{rt8}||没什么特别需要注意的机制||就是BOSS有个技能是飞到场地中间一道射线扫射半场||被扫到昏迷8秒，注意躲避！"},
        {name = "雷卫戈伦", raiders = "{rt8}雷卫戈伦{rt8}||BOSS大跳跃击||落地后产生四道往四面方向飞行的黑光柱，注意躲避。"},
        {name = "虚空石畸体", raiders = "{rt8}虚空石畸体{rt8}||别站坦克背后！BOSS召唤出来的水晶速度转火打掉！"},
        -- 小怪部分
    },
    ["破晨号"] = {
        -- BOSS部分
        {name = "代言人夏多克朗", raiders = "{rt8}代言人夏多克朗{rt8}||打断暗影箭，不要被光束碰到（P1三条P2四条），提前站位||治疗第一时间驱散燃烧之影DEBUFF，然后刷血刷爆吸收盾||中塌缩第一时间去场边放水（点名最远的2个人，看见读条就用位移技能跑）||BOSS放完黑水T注意打断并拉离黑水||BOSS 50% 1%上鸟远离飞船，1%那次可以直接飞往老2小怪"},
        {name = "阿努布伊卡斯", raiders = "{rt8}阿努布伊卡斯{rt8}||T卡墙，出现黑圈所有人躲开||对着空旷处放球，避开球正面，球飞得越远伤害越低,治疗注意被球撞的人||出现小怪群控AOE掉||BOSS AOE会越来越痛，规划好减伤和治疗。"},
        {name = "拉夏南", raiders = "{rt8}拉夏南{rt8}||P1：躲开地上白圈，绿色点名推波注意人群方向，治疗在AOE时注意抬血，不要猛捶BOSS，第一时间捡炸弹丢BOSS，捡炸弹时注意开减伤，治疗注意抬血||P2转场:直接飞到BOSS场地等，或者吃球跟着BOSS飞||P2:P2增加白圈点名技能，中白圈的跑场地边缘放圈再位移回来，全程BOSS点名非坦队友放绿线||被点名人自己改变站位让毒浪出现在边缘不影响其他队友||场地上出倒计时火药桶需要捡桶丢BOSS脸上炸它||否则桶会爆炸全团AOE||二阶段BOSS离开飞船的时候利用战斗中上鸟功能沿着NPC点亮的悬浮光球追击。"},
        -- 小怪部分
        {name = "夜幕祭师", raiders = "{rt8}夜幕祭师{rt8}||钢条{rt1}折磨光束{rt1}，尽量晕断。{rt1}钢条冥河之种{rt1}别驱散，躲开人群"},
        {name = "夜幕影法师", raiders = "{rt8}夜幕影法师{rt8}||{rt1}诱捕暗影{rt1}，必须打断"},
        {name = "夜幕司令官", raiders = "{rt8}夜幕司令官{rt8}||{rt1}深渊嚎叫{rt1}必须打断"},
        {name = "夜幕黑暗建筑师", raiders = "{rt8}夜幕黑暗建筑师{rt8}||{rt1}折磨喷发{rt1}，中圈离开人群开好减伤，招引增援迅速转火，小怪刚出开非常弱"},
    },
    ["圣焰隐修院"] = {
        -- BOSS部分
        {name = "戴尔克莱上尉", raiders = "{rt8}戴尔克莱上尉{rt8}||被点名离开人群，boss的长矛会对路径上的所有人造成伤害||打断boss读条，不然会全队AOE，并且给buff小怪||BOSS找队友贴贴会带套，要打破这个套！"},
        {name = "布朗派克男爵", raiders = "{rt8}布朗派克男爵{rt8}||远程不要站在近战区域||点名远程的转转锤自己看着躲。"},
        {name = "隐修院长穆普雷", raiders = "{rt8}隐修院长穆普雷{rt8}||Boss会点名，地上会有一只黄圈点谁追谁||并且黄圈还会放黑水，注意要远离人群，保持移动||BOSS半血会上楼，大伙跑楼梯追上去打掉BOSS护盾打断读条即可。"},
        -- 小怪部分
    },
    ["艾拉-卡拉，回响之城"] = {
        -- BOSS部分
        {name = "阿瓦诺克斯", raiders = "{rt8}阿瓦诺克斯{rt8}||躲开地板，偶尔可以踩一下||三连击时，T注意覆盖减伤||治疗注意留技能给群体AOE||群控减速，并转火小怪||定期召唤小蜘蛛无仇恨追人，需要控住清理。"},
        {name = "阿努布泽克特", raiders = "{rt8}阿努布泽克特{rt8}||躲开地上头前地板和会移动的虫群。Boss二阶段会放全场AOE虫群之眼||注意站到boss前面的圈圈里，躲好技能，出去就是死||点名一名队友几秒后会出现一圈小虫群AOE需要离开人群放圈||BOSS读条钻地冲击时，近战远离，躲开戳刺方向，躲开点名留下的蓝圈。"},
        {name = "收割者吉卡塔尔", raiders = "{rt8}收割者吉卡塔尔{rt8}||冲击波不友好对人群放||出啥躲啥，被网住就昏迷6秒，不能驱散的||场地边缘出现的小软泥打死会留下黑水||人踩上去会被定身并身下出现一只小软需要打掉才能解除||BOSS引导大招全场吸人时所有人需要主动去踩黑水定身避免被吸入。"},
        -- 小怪部分
        {name = "充血的爬行者", raiders = "{rt8}充血的爬行者{rt8}||充血的爬行者 残血之后控制，或者走开"},
        {name = "颤声侍从", raiders = "{rt8}颤声侍从{rt8}||{rt1}共振弹幕{rt1}必须打断"},
        {name = "伊可辛", raiders = "{rt8}伊可辛{rt8}||{rt1}惊惧尖鸣{rt1}必须打断"},
        {name = "沾血的网法师", raiders = "{rt8}沾血的网法师{rt8}||{rt1}恶臭齐射{rt1}必须打断"},
        {name = "哨兵鹿壳虫", raiders = "{rt8}哨兵鹿壳虫{rt8}||{rt1}预警尖鸣{rt1}必须打断，优先击杀"},

        {name = "鲜血监督者", raiders = "{rt8}鲜血监督者{rt8}||{rt1}毒液箭雨{rt1}必须打断"},
    },
    ["矶石宝库"] = {
        -- BOSS部分
        {name = "E.D.N.A", raiders = "{rt8}E.D.N.A{rt8}||躲开地刺，BOSS读红条时分散，不要中2根，每次打掉2根地刺||T开大减伤吃第一个震地猛击，治疗注意刷T，并在第二个震地猛击前2秒驱散T DEBUFF||BOSS点名三个人放射线,会有箭头指引方向||被点名的人自己调整利用射线把场地上的石头炸掉。"},
        {name = "斯卡莫拉克", raiders = "{rt8}斯卡莫拉克{rt8}||安排人逐步每波打1到2个小怪，所有DPS吃球||虚空魔像，场地上召唤的水晶需要打掉||否则BOSS会定期吃掉水晶给自己上很厚的吸收盾||BOSS上盾AOE时开爆发打破盾。"},
        {name = "机械大师", raiders = "{rt8}机械大师{rt8}||全场放火阶段有一个方向固定没有火，站在没有火的通风口||打断矮子BOSS所有的熔铁之水||躲开机器人BOSS头前大火球（ZS可以盾反）大火球可以清地上的水||离开中间铁轨，躲开中间的泥头车||在机器人释放解体时，躲冲击波并开技能抬血||其中一人死掉另一人会开始全场持续AOE||需要平衡血量尽量一起死。"},
        {name = "虚空代言人艾里克", raiders = "{rt8}虚空代言人艾里克{rt8}||BOSS身边的两个虚空黑门，碰到就秒杀||被BOSS点名持续时间DOT||需要跑去黑门附近就会消失但别碰到黑门||BOSS点名放黑水尽量放边缘免得后期没地方站。"},
        -- 小怪部分
        {name = "阴森的虚空之魂", raiders = "{rt8}阴森的虚空之魂{rt8}||{rt1}咆哮恐惧{rt1}必须打断"},
        {name = "炉铸愈疗者", raiders = "{rt8}炉铸愈疗者{rt8}||{rt1}愈合{rt1}和{rt1}合金箭矢{rt1}尽量断，没有优先级"},
        {name = "熔炉装货工", raiders = "{rt8}熔炉装货工{rt8}||需要躲开头前，被点名开减伤"},
        {name = "咒炉塑石者", raiders = "{rt8}咒炉塑石者{rt8}||{rt1}爆地图腾{rt1}需要第一时间转火打掉"},
    },
    ["燧酿酒庄"] = {
        -- BOSS部分
        {name = "酿造大师阿德里尔", raiders = "{rt8}酿造大师阿德里尔{rt8}||打到半血会去柜台进入无敌状态||需要有人去场地边缘给暴怒顾客送酒安抚解除无敌。"},
        {name = "艾帕", raiders = "{rt8}艾帕{rt8}||会召唤三只小软一直试图碰到BOSS||如果碰到会给BOSS一个非常厚的吸收盾||需要坦克拉着BOSS风筝小软||其他人尽快击杀掉小软。"},
        {name = "本克·鸣蜂", raiders = "{rt8}本克·鸣蜂{rt8}||蜜蜂骑手，没什么特别在意的||召唤小蜂蜜控住杀掉即可。"},
        {name = "戈尔迪·底爵", raiders = "{rt8}戈尔迪·底爵{rt8}||场地上很多爆炸酒桶||BOSS点名坦克的击飞和点名非坦克的红圈都会引爆酒桶||产生四个方向爆炸波||利用这两个技能处理掉酒桶||否则BOSS后续大招AOE||会把所有剩余酒桶引爆造成全场伤害和满地火浪。"},
        -- 小怪部分
    },
    ["暗焰裂口"] = {
        -- BOSS部分
        {name = "老蜡须", raiders = "{rt8}老蜡须{rt8}||场地上很多小狗头人无仇恨追人||引到轨道上用矿车撞死||发红的轨道马上会来矿车。"},
        {name = "布雷炙孔", raiders = "{rt8}布雷炙孔{rt8}||被点名放火的人去场地边缘点亮蜡烛||BOSS的大招AOE跑到之前点亮的蜡烛一侧就能躲掉！"},
        {name = "蜡烛之王", raiders = "{rt8}蜡烛之王{rt8}||被BOSS点名飞刀了跑去蜡像后面档飞刀||被BOSS点名放黑圈了跑去蜡像旁边用黑圈炸掉蜡像||每轮五个蜡像尽量全部在本轮内处理完毕。"},
        {name = "黑暗之主", raiders = "{rt8}黑暗之主{rt8}||需要有人去场地边缘捡油给灯添燃料||BOSS点名黑圈的人要跑远几步避免黑圈炸灯||BOSS读条吹灯需要一个人把灯捡起来拿开别被吹到||BOSS读条召唤小怪可打断需要秒断。"},
        -- 小怪部分
    },

    ["塞兹仙林的迷雾"] = {
        -- BOSS 部分
        {name = "英格拉·马洛克", raiders = "{rt8}英格拉·马洛克{rt8}||起手先打大个子不要开爆发||DPS 保留爆到大个子变绿||躲开地板技能||注意打断小个子技能。"},
        {name = "唤雾者", raiders = "{rt8}唤雾者{rt8}||BOSS 在 70%/40%/10%血量时召唤小怪头顶有类似迷宫的机制。必须找到与众不同的那个并击杀它||分身有AOE技能，没找到正确的分身不要打，打错死了全图爆炸 AOE||躲开闪避球，秒人的||T 注意打断拍拍手技能，只有 T 能断||鬼抓人目标使用位移技能远离狐狸，全队有控制技能减速技能的帮忙控制狐狸，不能羊。"},
        {name = "特雷德奥瓦", raiders = "{rt8}特雷德奥瓦{rt8}||70/40BOSS 有护盾，打破护盾并打断 BOSS||躲开旋涡，击杀小怪||如果被连线，彼此远离||酸蚀排放技能开始时不要大距离移动，防止最后满地图绿圈。||被点名向 T 跑，把小怪拉到 T 跟前接怪。"},
        -- 小怪部分
        {name = "纱雾防御者", raiders = "{rt8}纱雾防御者{rt8}||迷宫区域。每个区域有四个出口，只有一个出口是正确的，进入错误出口会被强制遣返初始地||每个出口会有一个迷雾覆盖的柱子，站人会显示图案||图案属性分为有圈叶子、无圈叶子、有圈实心花、无圈实心花、有圈空心花、无圈空心花||需要从这六种元素中找到那个与其他图案不相同的一个图案||比如三个都是没圈的，一个有圈的，那么带圈的那个就是正确路线||三个都是花，一个是叶子，那么叶子就是正确的路线。||不会走的跟着别人走，自己不要乱进门"},
        {name = "纱雾守护者", raiders = "{rt8}纱雾守护者{rt8}||{rt1}心能挥砍{rt1}，点 T 高伤。需要覆盖大减伤，拉出蓝圈，晕断飞踢"},
        {name = "纱雾钉刺蛾", raiders = "{rt8}纱雾钉刺蛾{rt8}||{rt1}心能注入{rt1}，需要做为主目标击杀，奶注意驱散，没驱散开减伤离开人群"},
        {name = "纱雾照看者", raiders = "{rt8}纱雾照看者{rt8}||{rt1}滋养森林{rt1}必须打断"},
        {name = "纱雾塑形者", raiders = "{rt8}纱雾塑形者{rt8}||{rt1}木棘外壳{rt1}必须打断"},
        {name = "锥喉酸咽者", raiders = "{rt8}锥喉酸咽者{rt8}||打断{rt1}模拟抗性{rt1}和{rt1}再生鼓舞{rt1}两个技能||躲玩家绿圈和地板绿圈||{rt1}酸性新星{rt1} AOE 技能注意开减伤。"},
        {name = "锥喉鹿角巨虫", raiders = "{rt8}锥喉鹿角巨虫{rt8}||打断{rt1}模拟抗性{rt1}和{rt1}再生鼓舞{rt1}两个技能||躲玩家绿圈和地板绿圈||{rt1}酸性新星{rt1} AOE 技能注意开减伤。"},
        {name = "德鲁斯特收割者", raiders = "{rt8}德鲁斯特收割者{rt8}||{rt1}收割精魂{rt1}必须打断。"},
        {name = "德鲁斯特暗爪者", raiders = "{rt8}德鲁斯特暗爪者{rt8}||死亡全队易伤，强韧高层需分拨处理。"},
        {name = "德鲁斯特碎枝者", raiders = "{rt8}德鲁斯特碎枝者{rt8}||躲开{rt1}荆棘爆发{rt1}50%全队 AOE，分开集火打死，不要平均修血"},
    },
    ["通灵战潮"] = {
        -- BOSS 部分
        {name = "凋骨", raiders = "{rt8}凋骨{rt8}||将呕吐物对准远离团队的方向||远离被点吐息的目标||杀小怪||躲开地板技能。"},
        {name = "阿玛厄斯", raiders = "{rt8}阿玛厄斯{rt8}||打断 BOSS||打断 FS 小怪，聚好小怪快速杀掉||躲避亡者领域||BOSS 定期会吐息冰旋转，DPS N 提前躲避到 BOSS 身后。"},
        {name = "外科医生缝肉", raiders = "{rt8}外科医生缝肉{rt8}||中肉钩点名的，站到小怪和 BOSS 中间，让箭头对准 BOSS，读条到 1 的时候闪开||BOSS 被拉下来开爆发||即时 BOSS 不在台上也要用肉钩对准 BOSS 来打断凝视||BOSS 快上台子时中肉钩可提前瞄准台子||上矛。嗜血打 BOSS。"},
        {name = "缚霜者纳尔佐", raiders = "{rt8}缚霜者纳尔佐{rt8}|| 躲避漩涡。||如果有人被冰冻，尽快离开他们的圆圈。在大圆圈为空之前不要驱散。圈内有人驱散会传染||如果被传送走，尽快跑下通道开位移技能躲避地图白圈并击杀怪物||完成后点 NPC 上来加 100%暴击 40 秒，50 秒后没上来直接秒杀||当你回来时，站在边缘放置冰块。"},
        -- 小怪部分
        {name = "尸体收割者", raiders = "{rt8}尸体收割者{rt8}||{rt1}排干液体{rt1}必须打断"},
        {name = "缝合先锋", raiders = "{rt8}缝合先锋{rt8}||攻击叠加攻速需要优先击杀。入口两边有盾，开安抚拿，第一波怪后面有矛，留着打 BOSS"},
        {name = "凋零之袋", raiders = "{rt8}凋零之袋{rt8}||{rt1}死亡爆炸{rt1}稍微躲开治疗抬血。"},
        {name = "佐尔拉姆斯通灵师", raiders = "{rt8}佐尔拉姆斯通灵师{rt8}||{rt1}严酷命运{rt1}随机点名，需要开减伤远离人群放绿水"},
        {name = "骷髅劫掠者", raiders = "{rt8}骷髅劫掠者{rt8}||{rt1}恐怖顺劈{rt1}躲开头前，刺耳尖啸是群控加 AOE 技能，必须打断"},
        {name = "佐尔拉姆斯愈骨者", raiders = "{rt8}佐尔拉姆斯愈骨者{rt8}||{rt1}最终交易{rt1}接骨{rt1}尽量打断控制||上桥之前左边盾右边球，安抚拿。重要的 3 根矛一定要顺路拿到。留者打老三用。"},
        {name = "忠诚的造物", raiders = "{rt8}忠诚的造物{rt8}||{rt1}脊锤重压{rt1}需躲开地板否则秒杀"},
    },
    ["格瑞姆巴托"] = {
        -- BOSS 部分
        {name = "乌比斯将军", raiders = "{rt8}乌比斯将军{rt8}||避开地面上的橙色圆圈。||当房间变成紫色时，寻找安全通道。总共 4 条通道。||放土圈注意不要封路，尽量放边上||三连斩 T 覆盖好减伤"},
        {name = "铸炉之主索朗格斯", raiders = "{rt8}铸炉之主索朗格斯{rt8}||拉着靠墙，其他人靠外，中点名注意移动放岩浆||boss 更换武器时，他会造成大量的范围伤害。||第 1 阶段是斧头，所有人把锥形地板火引在一起。||第 2 阶段是双持，坦克克星，对坦克进行大治疗||第 3 阶段是双手锤 - 风筝阶段。||重复。"},
        {name = "达加·燃影者", raiders = "{rt8}达加·燃影者{rt8}||第 1 阶段杀死小怪||第 2 阶段杀死小怪并避开旋风（这可能会变得很疯狂，帮助你的治疗，避开障碍物）||暗影烈焰箭尽量断，熵能诅咒能驱就驱||被点名的远离火人，其他人转火减速击杀||P1 平伤，P2 爆发，躲风||Boss 50%倒地"},
        {name = "埃鲁达克", raiders = "{rt8}埃鲁达克,地狱公爵{rt8}||避开触手||当房间开始缩小时收缩，但在我们拥有的狭小圆圈内尽可能保持分散。||被点名紫色圈的三个人不要吃二重圈||DK 绿罩，ZS 盾反踩触手，进风眼后被点名的贴边||等 BOSS AOE 结束后，A 掉小怪。"},
        -- 小怪部分
        {name = "暮光唤地者", raiders = "{rt8}暮光唤地者{rt8}||{rt1}剧烈震颤{rt1}必须打断"},
        {name = "暮光毁灭者", raiders = "{rt8}暮光毁灭者{rt8}||{rt1}晦暗之风{rt1}是钢条 AOE+击飞，注意卡墙"},
        {name = "受伤的红色幼龙", raiders = "{rt8}受伤的红色幼龙{rt8}||炸弹丢给巡逻加龙和 BOSS 前面双监督者波次"},
        {name = "暮光欺诈者", raiders = "{rt8}暮光欺诈者{rt8}||暮光欺诈者的灼烧心智必须打断"},
        {name = "暮光烈焰粉碎者", raiders = "{rt8}暮光烈焰粉碎者{rt8}||躲开头前，T 注意覆盖减伤"},
        {name = "暮光执行者", raiders = "{rt8}暮光执行者{rt8}||叠加攻速，叠几层以后晕怪清层数"},
        {name = "暮光熔岩操纵使", raiders = "{rt8}暮光熔岩操纵使{rt8}||躲地板，圈不互套，变身远离，治疗抬血||最好跳过这个怪。"},
        {name = "暮光术士", raiders = "{rt8}暮光术士{rt8}||{rt1}暗影烈焰笼罩{rt1}必须打断"},
        {name = "无面腐蚀者", raiders = "{rt8}无面腐蚀者{rt8}||{rt1}腐蚀{rt1}需要中点名的人开减伤"},
    },
    ["围攻伯拉勒斯"] = {
        {name = "“屠夫”血钩", raiders = "{rt8}“屠夫”血钩{rt8}||迅速解决自带的小怪后转火 BOSS||撞军火。||避开地板技能。"},
        {name = "恐怖船长洛克伍德", raiders = "{rt8}恐怖船长洛克伍德{rt8}||避开地面上的东西。||击杀小怪。||注意给 BOSS 上高额的减速 Dot||当大炮掉落时捡起来并向 boss 开火。"},
        {name = "哈达尔·黑渊", raiders = "{rt8}哈达尔·黑渊{rt8}||避开漩涡。||放[潮汐涌动]时，站在雕像的另一侧。坦克被点头前不要面对人群！继续第二波潮水，躲好||近战放水记得给远程留位置，贴雕像放水，躲连续两波海潮，循环到死。"},
        {name = "维克戈斯", raiders = "{rt8}维克戈斯{rt8}||先杀攫握恐魔，再杀攻城恐魔。||避开水圈，治疗驱散时要注意！圈里不能有别人。||当触手在平台上被杀死时，跳进大炮并射击 Boss。||在第二个平台上重复此操作。||在船平台上重复此操作。||狐人、地精、侏儒等使用变身玩具，否则桥上会游泳"},
        -- 小怪部分
        {name = "铁潮塑浪者", raiders = "{rt8}铁潮塑浪者{rt8}||防水甲壳必须打断"},
        {name = "水鼠帮劫掠者", raiders = "{rt8}水鼠帮劫掠者{rt8}||恶臭喷吐必须打断"},
        {name = "水鼠帮唤风者", raiders = "{rt8}水鼠帮唤风者{rt8}||窒息止水必须打断"},
        {name = "水鼠帮海盗", raiders = "{rt8}水鼠帮海盗{rt8}||钢条香蕉风暴尽可能晕断，注意躲避地上香蕉"},
        {name = "艾什凡指挥官", raiders = "{rt8}艾什凡指挥官{rt8}||强化怒吼必须打断||艾泽里特炸药，中白圈的出人群"},
    },
    ["尼鲁巴尔王宫"] = {
        {name = "噬灭者乌格拉克斯", raiders = "{rt8}噬灭者乌格拉克斯{rt8}||被大圈标记的玩家找人分摊伤害||吃了分摊的要逃离 boss，避免被拖到 boss 下方||躲避网状物，并用绿色酸液圆圈清除它们||当能量降到 0 时，BOSS 会跳到平台中央，将所有人击退并消失进 P2||躲避 boss 冲锋，打出现的小怪||boss 出现后送它吃小怪尸体回能量进 P1"},
        {name = "血缚恐魔", raiders = "{rt8}血缚恐魔{rt8}||单阶段战斗，分内外场||没事不要去血池游泳，会死||受到 Boss 吐息的可以进内场杀小怪||分两队轮流进内场||内场小怪注意打断||被 boss 点名放圈的要边跑边放||能量 100 了会大圈炸人全团跑开"},
        {name = "席克兰", raiders = "{rt8}席克兰{rt8}||单阶段纯单体战斗||BOSS 会穿过玩家留下幽灵，放幽灵尽量靠近，节约场地||BOSS 点名几个玩家射光，就用光消除场地上的幽灵||幽灵消除了会留个圈，别踩"},
        {name = "拉夏南", raiders = "{rt8}拉夏南{rt8}||单阶段，boss 会两边飞||BOSS 点名放绿线，看好方向躲避||绿线会变成波浪，被点名的放到边边上去||小怪拉一起打，近战位不能没人，没人会 AOE"},
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
   ["千絲之城"] = {
        -- BOSS部分
        {name = "演說者基克斯威茲克", raiders = "{rt8}演說者基克斯威茲克{rt8}||開打以BOSS為中心身邊出個圈，所有人保持自己在boss圈內，並躲開頭前||兩個疑之影點名，讓開先驅散一個||喧神教化AOE時所有人提前跑位到BOSS頭前||||BOSS定期砸地板放黑水需要坦克拉開||圈只會跟BOSS走，坦克不拉走大家只好硬踩黑水了！"},
        {name = "女王之牙", raiders = "{rt8}女王之牙{rt8}||打正在攻擊的BOSS||P1: 恩格斯攻擊，躲各種地板，維克斯釋放寒冰鐮刀時，兩兩分散，不要站一條直線，並開減傷應對之後的DEBUFF||P2: 維克斯攻擊，點T白圈集中踩，避免倒T；點名紫圈原來人群。"},
        {name = "凝結聚合體", raiders = "{rt8}凝結聚合體{rt8}||BOSS召喚黑球從場地邊緣飛向BOSS||需要去接球別讓BOSS吃球回血||吃到球的隊友會染一個DEBUFF需要奶媽刷爆他。"},
        {name = "大撚接師艾佐", raiders = "{rt8}大撚接師艾佐{rt8}||BOSS會點名所有人幾秒後腳下出軟泥||在打死軟泥之前無限定身||需要所有人在點名時集合方便速度AOE掉軟泥||如果能自己解定身的職業可以無視||否則會一直定身影響後續需要跑位元技能的躲避。"},
        -- 小怪部分
        {name = "蘇雷吉縛絲者", raiders = "{rt8}蘇雷吉縛絲者{rt8}||{rt1}流絲纏縛{rt1}必須打斷"},
        {name = "皇家蟲群衛士", raiders = "{rt8}皇家蟲群衛士{rt8}||{rt1}貪婪之蟲{rt1}需要全員減傷"},
        {name = "安蘇雷克的傳令官", raiders = "{rt8}安蘇雷克的傳令官{rt8}||{rt1}扭曲思緒{rt1}必須打斷"},
        {name = "隱秘網士", raiders = "{rt8}隱秘網士{rt8}||主目標優先擊殺。陰織衝擊、癒合之網必須打斷"},
        {name = "蘇雷吉反自然者", raiders = "{rt8}蘇雷吉反自然者{rt8}||{rt1}虛空之波{rt1}，儘量群控，儘量打斷"},
        {name = "長者織影", raiders = "{rt8}長者織影{rt8}||{rt1}晦幽紡紗{rt1}需要集中站位元，A掉限制移動的網"},
    },
    ["馭雷棲巢"] = {
        -- BOSS部分
        {name = "凱裡歐斯", raiders = "{rt8}凱裡歐斯{rt8}||沒什麼特別需要注意的機制||就是BOSS有個技能是飛到場地中間一道射線掃射半場||被掃到昏迷8秒，注意躲避！"},
        {name = "雷衛戈倫", raiders = "{rt8}雷衛戈倫{rt8}||BOSS大跳躍擊||落地後產生四道往四面方向飛行的黑光柱，注意躲避。"},
        {name = "虛空石畸體", raiders = "{rt8}虛空石畸體{rt8}||別站坦克背後！BOSS召喚出來的水晶速度轉火打掉！"},
        -- 小怪部分
    },
    ["破晨號"] = {
        -- BOSS部分
        {name = "代言人夏多克朗", raiders = "{rt8}代言人夏多克朗{rt8}||打斷暗影箭，不要被光束碰到（P1三條P2四條），提前站位||治療第一時間驅散燃燒之影DEBUFF，然後刷血刷爆吸收盾||中塌縮第一時間去場邊放水（點名最遠的2個人，看見讀條就用位移技能跑）||BOSS放完黑水T注意打斷並拉離黑水||BOSS 50% 1%上鳥遠離飛船，1%那次可以直接飛往老2小怪"},
        {name = "阿努布伊卡斯", raiders = "{rt8}阿努布伊卡斯{rt8}||T卡牆，出現黑圈所有人躲開||對著空曠處放球，避開球正面，球飛得越遠傷害越低,治療注意被球撞的人||出現小怪群控AOE掉||BOSS AOE會越來越痛，規劃好減傷和治療。"},
        {name = "拉夏南", raiders = "{rt8}拉夏南{rt8}||P1：躲開地上白圈，綠色點名推波注意人群方向，治療在AOE時注意抬血，不要猛捶BOSS，第一時間撿炸彈丟BOSS，撿炸彈時注意開減傷，治療注意抬血||P2轉場:直接飛到BOSS場地等，或者吃球跟著BOSS飛||P2:P2增加白圈點名技能，中白圈的跑場地邊緣放圈再位移回來，全程BOSS點名非坦隊友放綠線||被點名人自己改變站位讓毒浪出現在邊緣不影響其他隊友||場地上出倒計時火藥桶需要撿桶丟BOSS臉上炸它||否則桶會爆炸全團AOE||二階段BOSS離開飛船的時候利用戰鬥中上鳥功能沿著NPC點亮的懸浮光球追擊。"},
        -- 小怪部分
        {name = "夜幕祭師", raiders = "{rt8}夜幕祭師{rt8}||鋼條{rt1}折磨光束{rt1}，儘量暈斷。{rt1}鋼條冥河之種{rt1}別驅散，躲開人群"},
        {name = "夜幕影法師", raiders = "{rt8}夜幕影法師{rt8}||{rt1}誘捕暗影{rt1}，必須打斷"},
        {name = "夜幕司令官", raiders = "{rt8}夜幕司令官{rt8}||{rt1}深淵嚎叫{rt1}必須打斷"},
        {name = "夜幕黑暗建築師", raiders = "{rt8}夜幕黑暗建築師{rt8}||{rt1}折磨噴發{rt1}，中圈離開人群開好減傷，招引增援迅速轉火，小怪剛出開非常弱"},
    },
    ["聖焰隱修院"] = {
        -- BOSS部分
        {name = "戴爾克萊上尉", raiders = "{rt8}戴爾克萊上尉{rt8}||被點名離開人群，boss的長矛會對路徑上的所有人造成傷害||打斷boss讀條，不然會全隊AOE，並且給buff小怪||BOSS找隊友貼貼會帶套，要打破這個套！"},
        {name = "布朗派克男爵", raiders = "{rt8}布朗派克男爵{rt8}||遠程不要站在近戰區域||點名遠端的轉轉錘自己看著躲。"},
        {name = "隱修院長穆普雷", raiders = "{rt8}隱修院長穆普雷{rt8}||Boss會點名，地上會有一隻黃圈點誰追誰||並且黃圈還會放黑水，注意要遠離人群，保持移動||BOSS半血會上樓，大夥跑樓梯追上去打掉BOSS護盾打斷讀條即可。"},
        -- 小怪部分
    },
    ["艾拉-卡拉，迴響之城"] = {
        -- BOSS部分
        {name = "阿瓦諾克斯", raiders = "{rt8}阿瓦諾克斯{rt8}||躲開地板，偶爾可以踩一下||三連擊時，T注意覆蓋減傷||治療注意留技能給群體AOE||群控減速，並轉火小怪||定期召喚小蜘蛛無仇恨追人，需要控住清理。"},
        {name = "阿努布澤克特", raiders = "{rt8}阿努布澤克特{rt8}||躲開地上頭前地板和會移動的蟲群。Boss二階段會放全場AOE蟲群之眼||注意站到boss前面的圈圈裡，躲好技能，出去就是死||點名一名隊友幾秒後會出現一圈小蟲群AOE需要離開人群放圈||BOSS讀條鑽地衝擊時，近戰遠離，躲開戳刺方向，躲開點名留下的藍圈。"},
        {name = "收割者吉卡達", raiders = "{rt8}收割者吉卡達{rt8}||衝擊波不友好對人群放||出啥躲啥，被網住就昏迷6秒，不能驅散的||場地邊緣出現的小軟泥打死會留下黑水||人踩上去會被定身並身下出現一隻小軟需要打掉才能解除||BOSS引導大招全場吸人時所有人需要主動去踩黑水定身避免被吸入。"},
        -- 小怪部分
        {name = "充血的爬行者", raiders = "{rt8}充血的爬行者{rt8}||充血的爬行者 殘血之後控制，或者走開"},
        {name = "顫聲侍從", raiders = "{rt8}顫聲侍從{rt8}||{rt1}共振彈幕{rt1}必須打斷"},
        {name = "伊可辛", raiders = "{rt8}伊可辛{rt8}||{rt1}驚懼尖鳴{rt1}必須打斷"},
        {name = "沾血的網法師", raiders = "{rt8}沾血的網法師{rt8}||{rt1}惡臭齊射{rt1}必須打斷"},
        {name = "哨兵鹿殼蟲", raiders = "{rt8}哨兵鹿殼蟲{rt8}||{rt1}預警尖鳴{rt1}必須打斷，優先擊殺"},

        {name = "鮮血監督者", raiders = "{rt8}鮮血監督者{rt8}||{rt1}毒液箭雨{rt1}必須打斷"},
    },
    ["磯石寶庫"] = {
        -- BOSS部分
        {name = "E.D.N.A", raiders = "{rt8}E.D.N.A{rt8}||躲開地刺，BOSS讀紅條時分散，不要中2根，每次打掉2根地刺||T開大減傷吃第一個震地猛擊，治療注意刷T，並在第二個震地猛擊前2秒驅散T DEBUFF||BOSS點名三個人放射線,會有箭頭指引方向||被點名的人自己調整利用射線把場地上的石頭炸掉。"},
        {name = "斯卡莫拉克", raiders = "{rt8}斯卡莫拉克{rt8}||安排人逐步每波打1到2個小怪，所有DPS吃球||虛空魔像，場地上召喚的水晶需要打掉||否則BOSS會定期吃掉水晶給自己上很厚的吸收盾||BOSS上盾AOE時開爆發打破盾。"},
        {name = "機械大師", raiders = "{rt8}機械大師{rt8}||全場放火階段有一個方向固定沒有火，站在沒有火的通風口||打斷矮子BOSS所有的熔鐵之水||躲開機器人BOSS頭前大火球（ZS可以盾反）大火球可以清地上的水||離開中間鐵軌，躲開中間的泥頭車||在機器人釋放解體時，躲衝擊波並開技能抬血||其中一人死掉另一人會開始全場持續AOE||需要平衡血量儘量一起死。"},
        {name = "虛空代言人艾裡克", raiders = "{rt8}虛空代言人艾裡克{rt8}||BOSS身邊的兩個虛空黑門，碰到就秒殺||被BOSS點名持續時間DOT||需要跑去黑門附近就會消失但別碰到黑門||BOSS點名放黑水儘量放邊緣免得後期沒地方站。"},
        -- 小怪部分
        {name = "陰森的虛空之魂", raiders = "{rt8}陰森的虛空之魂{rt8}||{rt1}咆哮恐懼{rt1}必須打斷"},
        {name = "爐鑄愈療者", raiders = "{rt8}爐鑄愈療者{rt8}||{rt1}癒合{rt1}和{rt1}合金箭矢{rt1}儘量斷，沒有優先順序"},
        {name = "熔爐裝貨工", raiders = "{rt8}熔爐裝貨工{rt8}||需要躲開頭前，被點名開減傷"},
        {name = "咒爐塑石者", raiders = "{rt8}咒爐塑石者{rt8}||{rt1}爆地圖騰{rt1}需要第一時間轉火打掉"},
    },
    ["燧釀酒莊"] = {
        -- BOSS部分
        {name = "釀造大師阿德里爾", raiders = "{rt8}釀造大師阿德里爾{rt8}||打到半血會去櫃檯進入無敵狀態||需要有人去場地邊緣給暴怒顧客送酒安撫解除無敵。"},
        {name = "艾帕", raiders = "{rt8}艾帕{rt8}||會召喚三隻小軟一直試圖碰到BOSS||如果碰到會給BOSS一個非常厚的吸收盾||需要坦克拉著BOSS風箏小軟||其他人儘快擊殺掉小軟。"},
        {name = "本克·鳴蜂", raiders = "{rt8}本克·鳴蜂{rt8}||蜜蜂騎手，沒什麼特別在意的||召喚小蜂蜜控住殺掉即可。"},
        {name = "戈爾迪·底爵", raiders = "{rt8}戈爾迪·底爵{rt8}||場地上很多爆炸酒桶||BOSS點名坦克的擊飛和點名非坦克的紅圈都會引爆酒桶||產生四個方向爆炸波||利用這兩個技能處理掉酒桶||否則BOSS後續大招AOE||會把所有剩餘酒桶引爆造成全場傷害和滿地火浪。"},
        -- 小怪部分
    },
    ["暗焰裂口"] = {
        -- BOSS部分
        {name = "老蠟須", raiders = "{rt8}老蠟須{rt8}||場地上很多小狗頭人無仇恨追人||引到軌道上用礦車撞死||發紅的軌道馬上會來礦車。"},
        {name = "佈雷炙孔", raiders = "{rt8}佈雷炙孔{rt8}||被點名放火的人去場地邊緣點亮蠟燭||BOSS的大招AOE跑到之前點亮的蠟燭一側就能躲掉！"},
        {name = "蠟燭之王", raiders = "{rt8}蠟燭之王{rt8}||被BOSS點名飛刀了跑去蠟像後面檔飛刀||被BOSS點名放黑圈了跑去蠟像旁邊用黑圈炸掉蠟像||每輪五個蠟像儘量全部在本輪內處理完畢。"},
        {name = "黑暗之主", raiders = "{rt8}黑暗之主{rt8}||需要有人去場地邊緣撿油給燈添燃料||BOSS點名黑圈的人要跑遠幾步避免黑圈炸燈||BOSS讀條吹燈需要一個人把燈撿起來拿開別被吹到||BOSS讀條召喚小怪可打斷需要秒斷。"},
        -- 小怪部分
    },

    ["塞茲仙林的迷霧"] = {
        -- BOSS 部分
        {name = "英格拉·馬婁克", raiders = "{rt8}英格拉·馬婁克{rt8}||起手先打大個子不要開爆發||DPS 保留爆到大個子變綠||躲開地板技能||注意打斷小個子技能。"},
        {name = "喚霧者", raiders = "{rt8}喚霧者{rt8}||BOSS 在 70%/40%/10%血量時召喚小怪頭頂有類似迷宮的機制。必須找到與眾不同的那個並擊殺它||分身有AOE技能，沒找到正確的分身不要打，打錯死了全圖爆炸 AOE||躲開閃避球，秒人的||T 注意打斷拍拍手技能，只有 T 能斷||鬼抓人目標使用位移技能遠離狐狸，全隊有控制技能減速技能的幫忙控制狐狸，不能羊。"},
        {name = "特雷德奧瓦", raiders = "{rt8}特雷德奧瓦{rt8}||70/40BOSS 有護盾，打破護盾並打斷 BOSS||躲開旋渦，擊殺小怪||如果被連線，彼此遠離||酸蝕排放技能開始時不要大距離移動，防止最後滿地圖綠圈。||被點名向 T 跑，把小怪拉到 T 跟前接怪。"},
        -- 小怪部分
        {name = "紗霧防禦者", raiders = "{rt8}紗霧防禦者{rt8}||迷宮區域。每個區域有四個出口，只有一個出口是正確的，進入錯誤出口會被強制遣返初始地||每個出口會有一個迷霧覆蓋的柱子，站人會顯示圖案||圖案屬性分為有圈葉子、無圈葉子、有圈實心花、無圈實心花、有圈空心花、無圈空心花||需要從這六種元素中找到那個與其他圖案不相同的一個圖案||比如三個都是沒圈的，一個有圈的，那麼帶圈的那個就是正確路線||三個都是花，一個是葉子，那麼葉子就是正確的路線。||不會走的跟著別人走，自己不要亂進門"},
        {name = "紗霧守護者", raiders = "{rt8}紗霧守護者{rt8}||{rt1}心能揮砍{rt1}，點 T 高傷。需要覆蓋大減傷，拉出藍圈，暈斷飛踢"},
        {name = "紗霧釘刺蛾", raiders = "{rt8}紗霧釘刺蛾{rt8}||{rt1}心能注入{rt1}，需要做為主目標擊殺，奶注意驅散，沒驅散開減傷離開人群"},
        {name = "紗霧照看者", raiders = "{rt8}紗霧照看者{rt8}||{rt1}滋養森林{rt1}必須打斷"},
        {name = "紗霧塑形者", raiders = "{rt8}紗霧塑形者{rt8}||{rt1}木棘外殼{rt1}必須打斷"},
        {name = "錐喉酸咽者", raiders = "{rt8}錐喉酸咽者{rt8}||打斷{rt1}模擬抗性{rt1}和{rt1}再生鼓舞{rt1}兩個技能||躲玩家綠圈和地板綠圈||{rt1}酸性新星{rt1} AOE 技能注意開減傷。"},
        {name = "錐喉鹿角巨蟲", raiders = "{rt8}錐喉鹿角巨蟲{rt8}||打斷{rt1}模擬抗性{rt1}和{rt1}再生鼓舞{rt1}兩個技能||躲玩家綠圈和地板綠圈||{rt1}酸性新星{rt1} AOE 技能注意開減傷。"},
        {name = "德魯斯特收割者", raiders = "{rt8}德魯斯特收割者{rt8}||{rt1}收割精魂{rt1}必須打斷。"},
        {name = "德魯斯特暗爪者", raiders = "{rt8}德魯斯特暗爪者{rt8}||死亡全隊易傷，強韌高層需分撥處理。"},
        {name = "德魯斯特碎枝者", raiders = "{rt8}德魯斯特碎枝者{rt8}||躲開{rt1}荊棘爆發{rt1}50%全隊 AOE，分開集火打死，不要平均修血"},
    },
    ["通靈戰潮"] = {
        -- BOSS 部分
        {name = "凋骨", raiders = "{rt8}凋骨{rt8}||將嘔吐物對準遠離團隊的方向||遠離被點吐息的目標||殺小怪||躲開地板技能。"},
        {name = "阿瑪厄斯", raiders = "{rt8}阿瑪厄斯{rt8}||打斷 BOSS||打斷 FS 小怪，聚好小怪快速殺掉||躲避亡者領域||BOSS 定期會吐息冰旋轉，DPS N 提前躲避到 BOSS 身後。"},
        {name = "外科醫生縫肉", raiders = "{rt8}外科醫生縫肉{rt8}||中肉鉤點名的，站到小怪和 BOSS 中間，讓箭頭對準 BOSS，讀條到 1 的時候閃開||BOSS 被拉下來開爆發||即時 BOSS 不在臺上也要用肉鉤對準 BOSS 來打斷凝視||BOSS 快上臺子時中肉鉤可提前瞄準檯子||上矛。嗜血打 BOSS。"},
        {name = "縛霜者納爾佐", raiders = "{rt8}縛霜者納爾佐{rt8}|| 躲避漩渦。||如果有人被冰凍，儘快離開他們的圓圈。在大圓圈為空之前不要驅散。圈內有人驅散會傳染||如果被傳送走，儘快跑下通道開位移技能躲避地圖白圈並擊殺怪物||完成後點 NPC 上來加 100%暴擊 40 秒，50 秒後沒上來直接秒殺||當你回來時，站在邊緣放置冰塊。"},
        -- 小怪部分
        {name = "屍體收割者", raiders = "{rt8}屍體收割者{rt8}||{rt1}排幹液體{rt1}必須打斷"},
        {name = "縫合先鋒", raiders = "{rt8}縫合先鋒{rt8}||攻擊疊加攻速需要優先擊殺。入口兩邊有盾，開安撫拿，第一波怪後面有矛，留著打 BOSS"},
        {name = "凋零之袋", raiders = "{rt8}凋零之袋{rt8}||{rt1}死亡爆炸{rt1}稍微躲開治療抬血。"},
        {name = "佐爾拉姆斯通靈師", raiders = "{rt8}佐爾拉姆斯通靈師{rt8}||{rt1}嚴酷命運{rt1}隨機點名，需要開減傷遠離人群放綠水"},
        {name = "骷髏劫掠者", raiders = "{rt8}骷髏劫掠者{rt8}||{rt1}恐怖順劈{rt1}躲開頭前，刺耳尖嘯是群控加 AOE 技能，必須打斷"},
        {name = "佐爾拉姆斯愈骨者", raiders = "{rt8}佐爾拉姆斯愈骨者{rt8}||{rt1}最終交易{rt1}接骨{rt1}儘量打斷控制||上橋之前左邊盾右邊球，安撫拿。重要的 3 根矛一定要順路拿到。留者打老三用。"},
        {name = "忠誠的造物", raiders = "{rt8}忠誠的造物{rt8}||{rt1}脊錘重壓{rt1}需躲開地板否則秒殺"},
    },
    ["格瑞姆巴托"] = {
        -- BOSS 部分
        {name = "烏比斯將軍", raiders = "{rt8}烏比斯將軍{rt8}||避開地面上的橙色圓圈。||當房間變成紫色時，尋找秘密頻道。總共 4 條通道。||放土圈注意不要封路，儘量放邊上||三連斬 T 覆蓋好減傷"},
        {name = "鑄爐之主索朗格斯", raiders = "{rt8}鑄爐之主索朗格斯{rt8}||拉著靠牆，其他人靠外，中點名注意移動放岩漿||boss 更換武器時，他會造成大量的範圍傷害。||第 1 階段是斧頭，所有人把錐形地板火引在一起。||第 2 階段是雙持，坦克剋星，對坦克進行大治療||第 3 階段是雙手錘 - 風箏階段。||重複。"},
        {name = "達加·燃影者", raiders = "{rt8}達加·燃影者{rt8}||第 1 階段殺死小怪||第 2 階段殺死小怪並避開旋風（這可能會變得很瘋狂，幫助你的治療，避開障礙物）||暗影烈焰箭儘量斷，熵能詛咒能驅就驅||被點名的遠離火人，其他人轉火減速擊殺||P1 平傷，P2 爆發，躲風||Boss 50%倒地"},
        {name = "埃魯達克", raiders = "{rt8}埃魯達克,地獄公爵{rt8}||避開觸手||當房間開始縮小時收縮，但在我們擁有的狹小圓圈內盡可能保持分散。||被點名紫色圈的三個人不要吃二重圈||DK 綠罩，ZS 盾反踩觸手，進風眼後被點名的貼邊||等 BOSS AOE 結束後，A 掉小怪。"},
        -- 小怪部分
        {name = "暮光喚地者", raiders = "{rt8}暮光喚地者{rt8}||{rt1}劇烈震顫{rt1}必須打斷"},
        {name = "暮光毀滅者", raiders = "{rt8}暮光毀滅者{rt8}||{rt1}晦暗之風{rt1}是鋼條 AOE+擊飛，注意卡牆"},
        {name = "受傷的紅色幼龍", raiders = "{rt8}受傷的紅色幼龍{rt8}||炸彈丟給巡邏加龍和 BOSS 前面雙監督者波次"},
        {name = "暮光欺詐者", raiders = "{rt8}暮光欺詐者{rt8}||暮光欺詐者的灼燒心智必須打斷"},
        {name = "暮光烈焰粉碎者", raiders = "{rt8}暮光烈焰粉碎者{rt8}||躲開頭前，T 注意覆蓋減傷"},
        {name = "暮光執行者", raiders = "{rt8}暮光執行者{rt8}||疊加攻速，疊幾層以後暈怪清層數"},
        {name = "暮光熔岩操縱使", raiders = "{rt8}暮光熔岩操縱使{rt8}||躲地板，圈不互套，變身遠離，治療抬血||最好跳過這個怪。"},
        {name = "暮光術士", raiders = "{rt8}暮光術士{rt8}||{rt1}暗影烈焰籠罩{rt1}必須打斷"},
        {name = "無面腐蝕者", raiders = "{rt8}無面腐蝕者{rt8}||{rt1}腐蝕{rt1}需要中點名的人開減傷"},
    },
    ["圍攻伯拉勒斯"] = {
        {name = "“屠夫”血鉤", raiders = "{rt8}“屠夫”血鉤{rt8}||迅速解決自帶的小怪後轉火 BOSS||撞軍火。||避開地板技能。"},
        {name = "恐怖船長洛克伍德", raiders = "{rt8}恐怖船長洛克伍德{rt8}||避開地面上的東西。||擊殺小怪。||注意給 BOSS 上高額的減速 Dot||當大炮掉落時撿起來並向 boss 開火。"},
        {name = "哈達爾·黑淵", raiders = "{rt8}哈達爾·黑淵{rt8}||避開漩渦。||放[潮汐湧動]時，站在雕像的另一側。坦克被點頭前不要面對人群！繼續第二波潮水，躲好||近戰放水記得給遠程留位置，貼雕像放水，躲連續兩波海潮，迴圈到死。"},
        {name = "維克戈斯", raiders = "{rt8}維克戈斯{rt8}||先殺攫握恐魔，再殺攻城恐魔。||避開水圈，治療驅散時要注意！圈裡不能有別人。||當觸手在平臺上被殺死時，跳進大炮並射擊 Boss。||在第二個平臺上重複此操作。||在船平臺上重複此操作。||狐人、地精、侏儒等使用變身玩具，否則橋上會游泳"},
        -- 小怪部分
        {name = "鐵潮塑浪者", raiders = "{rt8}鐵潮塑浪者{rt8}||防水甲殼必須打斷"},
        {name = "水鼠幫劫掠者", raiders = "{rt8}水鼠幫劫掠者{rt8}||惡臭噴吐必須打斷"},
        {name = "水鼠幫喚風者", raiders = "{rt8}水鼠幫喚風者{rt8}||窒息止水必須打斷"},
        {name = "水鼠幫海盜", raiders = "{rt8}水鼠幫海盜{rt8}||鋼條香蕉風暴盡可能暈斷，注意躲避地上香蕉"},
        {name = "艾什凡指揮官", raiders = "{rt8}艾什凡指揮官{rt8}||強化怒吼必須打斷||艾澤裡特炸藥，中白圈的出人群"},
    },
    ["尼魯巴爾王宮"] = {
        {name = "噬滅者烏格拉克斯", raiders = "{rt8}噬滅者烏格拉克斯{rt8}||被大圈標記的玩家找人分攤傷害||吃了分攤的要逃離 boss，避免被拖到 boss 下方||躲避網狀物，並用綠色酸液圓圈清除它們||當能量降到 0 時，BOSS 會跳到平臺中央，將所有人擊退並消失進 P2||躲避 boss 衝鋒，打出現的小怪||boss 出現後送它吃小怪屍體回能量進 P1"},
        {name = "血縛恐魔", raiders = "{rt8}血縛恐魔{rt8}||單階段戰鬥，分內外場||沒事不要去血池游泳，會死||受到 Boss 吐息的可以進內場殺小怪||分兩隊輪流進內場||內場小怪注意打斷||被 boss 點名放圈的要邊跑邊放||能量 100 了會大圈炸人全團跑開"},
        {name = "席克蘭", raiders = "{rt8}席克蘭{rt8}||單階段純單體戰鬥||BOSS 會穿過玩家留下幽靈，放幽靈儘量靠近，節約場地||BOSS 點名幾個玩家射光，就用光消除場地上的幽靈||幽靈消除了會留個圈，別踩"},
        {name = "拉夏南", raiders = "{rt8}拉夏南{rt8}||單階段，boss 會兩邊飛||BOSS 點名放綠線，看好方向躲避||綠線會變成波浪，被點名的放到邊邊上去||小怪拉一起打，近戰位不能沒人，沒人會 AOE"},
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