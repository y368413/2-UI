--## Author: Keyboardturner ## Version: 0.0.8 ## IconTexture: Interface/Icons/inv_glaive_1h_artifactazgalor_d_02dual.blp
local rat = {}
local RATL = {}

local ClassName = UnitClass("player")
local function GetRaceName(raceID)
	local raceData = C_CreatureInfo.GetRaceInfo(raceID)
	local raceName
	if raceData and raceData.raceName then
		raceName = raceData.raceName
	end
	return raceName
end

if GetLocale() == "zhCN" then
	-- Simplified Chinese translations go here
	RATL["Addon_Title"] = "Remix Artifact Tracker"
	RATL["Addon_Notes"] = "为军团重混的神器武器添加一个神器外观标签页。"
	RATL["SlashCmd1"] = "/rat"
	RATL["SlashCmd2"] = "/混搭神器"
	RATL["SlashCmd3"] = "/remixartifact"

	RATL["Traits"] = ARTIFACTS_PERK_TAB
	RATL["Appearances"] = ARTIFACTS_APPEARANCE_TAB
	RATL["ShowSecondary"] = "显示次要"
	RATL["ShowSecondaryTT"] = "显示与此套装关联的次要模型。"
	RATL["RaceNightElf"] = GetRaceName(4)
	RATL["RaceHaranir"] = GetRaceName(86)
	RATL["RaceTauren"] = GetRaceName(6)
	RATL["RaceHMTauren"] = GetRaceName(28)
	RATL["RaceTroll"] = GetRaceName(8)
	RATL["RaceZandalari"] = GetRaceName(31)
	RATL["RaceWorgen"] = GetRaceName(22)
	RATL["RaceKulTiran"] = GetRaceName(32)
	RATL["RaceGroup1"] = RATL["RaceNightElf"] -- .. ", " .. RATL["RaceHaranir"] -- (maybe for future?)
	RATL["RaceGroup2"] = RATL["RaceTauren"] .. "， " .. RATL["RaceHMTauren"]
	RATL["RaceGroup3"] = RATL["RaceTroll"] .. "， " .. RATL["RaceZandalari"]
	RATL["RaceGroup4"] = RATL["RaceWorgen"] .. "， " .. RATL["RaceKulTiran"]
	RATL["Artifact"] = ITEM_QUALITY6_DESC
	RATL["Unavailable"] = UNAVAILABLE
	RATL["NoLongerAvailable"] = NO_LONGER_AVAILABLE

	RATL["TraitRow1Temp_Classic"]		 = "经典"
	RATL["TraitRow2Temp_Upgraded"]		 = "进阶"
	RATL["TraitRow3Temp_Valorous"]		 = "勇猛"
	RATL["TraitRow4Temp_War-torn"]		 = "战火"
	RATL["TraitRow5Temp_Challenging"]	 = "挑战"
	RATL["TraitRow6Temp_Hidden"]		 = "隐藏"

	--classic
	RATL["TraitRow1Tint1Req"] = ""
	RATL["TraitRow1Tint2Req"] = "找回一个创世之柱。"
	RATL["TraitRow1Tint3Req"] = "找回圣光之心，并且把它安全带回你的职业大厅。"
	RATL["TraitRow1Tint4Req"] = "与你的部下一起完成第一个大型战役的行动。"

	--upgraded
	RATL["TraitRow2Tint1Req"] = string.format("完成%s职业大厅战役。", ClassName)
	RATL["TraitRow2Tint2Req"] = string.format("完成%s职业大厅战役。", ClassName)
	RATL["TraitRow2Tint3Req"] = string.format("完成%s职业大厅战役。", ClassName)
	RATL["TraitRow2Tint4Req"] = "完成成就“此面向上”。"

	--valorous
	RATL["TraitRow3Tint1Req"] = "完成任务线“能量的平衡”。"
	RATL["TraitRow3Tint2Req"] = "完成成就“怪兽出笼”。\n\n完成任务线“能量的平衡”。"
	RATL["TraitRow3Tint3Req"] = "使用一个5级钥石，完成一个史诗地下城。\n\n完成任务线“能量的平衡”。"
	RATL["TraitRow3Tint4Req"] = "完成成就“军团英雄的荣耀”。\n\n完成任务线“能量的平衡”。"

	--war-torn
	RATL["TraitRow4Tint1Req"] = "参与PvP战斗，荣誉等级达到10级。"
	RATL["TraitRow4Tint2Req"] = "荣誉等级达到30级。"
	RATL["TraitRow4Tint3Req"] = "荣誉等级达到50级。"
	RATL["TraitRow4Tint4Req"] = "荣誉等级达到80级。"

	--challenging (swapped with Hidden)
	RATL["TraitRow5Tint1Req_THR"] = "完成任务线“魔王归来”。"
	RATL["TraitRow5Tint2Req_THR"] = "解锁挑战神器外观后击败英雄难度的基尔加丹。\n\n完成任务线“魔王归来”。"
	RATL["TraitRow5Tint3Req_THR"] = "解锁挑战神器外观后赢得10场评级战场的胜利。\n\n完成任务线“魔王归来”。"
	RATL["TraitRow5Tint4Req_THR"] = "解锁挑战神器外观后完成10个不同的“军团再临”地下城。\n\n完成任务线“魔王归来”。"

	RATL["TraitRow5Tint1Req_XC"] = "完成任务线“克希雷姆挑战”。"
	RATL["TraitRow5Tint2Req_XC"] = "解锁挑战神器外观后击败英雄难度的基尔加丹。\n\n完成任务线“克希雷姆挑战”。"
	RATL["TraitRow5Tint3Req_XC"] = "解锁挑战神器外观后赢得10场评级战场的胜利。\n\n完成任务线“克希雷姆挑战”。"
	RATL["TraitRow5Tint4Req_XC"] = "解锁挑战神器外观后完成10个不同的“军团再临”地下城。\n\n完成任务线“克希雷姆挑战”。"

	RATL["TraitRow5Tint1Req_IMC"] = "完成任务线“鬼母挑战”。"
	RATL["TraitRow5Tint2Req_IMC"] = "解锁挑战神器外观后击败英雄难度的基尔加丹。\n\n完成任务线“鬼母挑战”。"
	RATL["TraitRow5Tint3Req_IMC"] = "解锁挑战神器外观后赢得10场评级战场的胜利。\n\n完成任务线“鬼母挑战”。"
	RATL["TraitRow5Tint4Req_IMC"] = "解锁挑战神器外观后完成10个不同的“军团再临”地下城。\n\n完成任务线“鬼母挑战”。"

	RATL["TraitRow5Tint1Req_TC"] = "完成任务线“双子挑战”。"
	RATL["TraitRow5Tint2Req_TC"] = "解锁挑战神器外观后击败英雄难度的基尔加丹。\n\n完成任务线“双子挑战”。"
	RATL["TraitRow5Tint3Req_TC"] = "解锁挑战神器外观后赢得10场评级战场的胜利。\n\n完成任务线“双子挑战”。"
	RATL["TraitRow5Tint4Req_TC"] = "解锁挑战神器外观后完成10个不同的“军团再临”地下城。\n\n完成任务线“双子挑战”。"

	RATL["TraitRow5Tint1Req_TBRT"] = "完成任务线“黑鸦堡垒的威胁”。"
	RATL["TraitRow5Tint2Req_TBRT"] = "解锁挑战神器外观后击败英雄难度的基尔加丹。\n\n完成任务线“黑鸦堡垒的威胁”。"
	RATL["TraitRow5Tint3Req_TBRT"] = "解锁挑战神器外观后赢得10场评级战场的胜利。\n\n完成任务线“黑鸦堡垒的威胁”。"
	RATL["TraitRow5Tint4Req_TBRT"] = "解锁挑战神器外观后完成10个不同的“军团再临”地下城。\n\n完成任务线“黑鸦堡垒的威胁”。"

	RATL["TraitRow5Tint1Req_TFWM"] = "完成任务线“邪能蠕虫之灾”。"
	RATL["TraitRow5Tint2Req_TFWM"] = "解锁挑战神器外观后击败英雄难度的基尔加丹。\n\n完成任务线“邪能蠕虫之灾”。"
	RATL["TraitRow5Tint3Req_TFWM"] = "解锁挑战神器外观后赢得10场评级战场的胜利。\n\n完成任务线“邪能蠕虫之灾”。"
	RATL["TraitRow5Tint4Req_TFWM"] = "解锁挑战神器外观后完成10个不同的“军团再临”地下城。\n\n完成任务线“邪能蠕虫之灾”。"

	RATL["TraitRow5Tint1Req_GQC"] = "完成任务线“神后挑战”。"
	RATL["TraitRow5Tint2Req_GQC"] = "解锁挑战神器外观后击败英雄难度的基尔加丹。\n\n完成任务线“神后挑战”。"
	RATL["TraitRow5Tint3Req_GQC"] = "解锁挑战神器外观后赢得10场评级战场的胜利。\n\n完成任务线“神后挑战”。"
	RATL["TraitRow5Tint4Req_GQC"] = "解锁挑战神器外观后完成10个不同的“军团再临”地下城。\n\n完成任务线“神后挑战”。"

	--hidden (swapped with Challenging)
	RATL["TraitRow6Tint1Req"] = ""
	RATL["TraitRow6Tint2Req"] = "解锁隐藏的神器外观后完成30个“军团再临”地下城。"
	RATL["TraitRow6Tint3Req"] = "解锁隐藏的神器外观后完成200个世界任务。"
	RATL["TraitRow6Tint4Req"] = "解锁隐藏的神器外观后击杀1,000个敌对玩家。"

	--Demon Hunter
	RATL["TraitRow1_DemonHunter_Havoc_Classic"]		 = "欺诈者的双刃"
	RATL["TraitRow2_DemonHunter_Havoc_Upgraded"]		 = "伊利达雷之手"
	RATL["TraitRow3_DemonHunter_Havoc_Valorous"]		 = "黯刃"
	RATL["TraitRow4_DemonHunter_Havoc_War-torn"]		 = "魔蚀"
	RATL["TraitRow5_DemonHunter_Havoc_Challenging"]	 = "斩炎"
	RATL["TraitRow6_DemonHunter_Havoc_Hidden"]			 = "死亡行者"

	RATL["TraitRow1_DemonHunter_Vengeance_Classic"]	 = "奥达奇战刃"
	RATL["TraitRow2_DemonHunter_Vengeance_Upgraded"]	 = "伊利达雷徽记"
	RATL["TraitRow3_DemonHunter_Vengeance_Valorous"]	 = "恐惧魔王之咬"
	RATL["TraitRow4_DemonHunter_Vengeance_War-torn"]	 = "恐怖白骨"
	RATL["TraitRow5_DemonHunter_Vengeance_Challenging"] = "棕红之翼"
	RATL["TraitRow6_DemonHunter_Vengeance_Hidden"]		 = "钢铁守望者"

	--Paladin
	RATL["TraitRow1_Paladin_Retribution_Classic"]		 = "灰烬使者"
	RATL["TraitRow2_Paladin_Retribution_Upgraded"]		 = "正义重剑"
	RATL["TraitRow3_Paladin_Retribution_Valorous"]		 = "燃烧的复仇"
	RATL["TraitRow4_Paladin_Retribution_War-torn"]		 = "陨落的希望"
	RATL["TraitRow5_Paladin_Retribution_Challenging"]	 = "破碎清算"
	RATL["TraitRow6_Paladin_Retribution_Hidden"]		 = "腐化之忆"

	RATL["TraitRow1_Paladin_Holy_Classic"]				 = "白银之手"
	RATL["TraitRow2_Paladin_Holy_Upgraded"]			 = "堕落守护者之拳"
	RATL["TraitRow3_Paladin_Holy_Valorous"]			 = "守护者的审判"
	RATL["TraitRow4_Paladin_Holy_War-torn"]			 = "古墓守卫"
	RATL["TraitRow5_Paladin_Holy_Challenging"]			 = "正义之火"
	RATL["TraitRow6_Paladin_Holy_Hidden"]				 = "守望者的武装"

	RATL["TraitRow1_Paladin_Protection_Classic"]		 = "真理守护者"
	RATL["TraitRow2_Paladin_Protection_Upgraded"]		 = "泰坦之光"
	RATL["TraitRow3_Paladin_Protection_Valorous"]		 = "神圣守护者"
	RATL["TraitRow4_Paladin_Protection_War-torn"]		 = "黑暗守护者的守护"
	RATL["TraitRow5_Paladin_Protection_Challenging"]	 = "圣火之徽"
	RATL["TraitRow6_Paladin_Protection_Hidden"]		 = "守备官的壁垒"

	--Warrior
	RATL["TraitRow1_Warrior_Arms_Classic"]				 = "斯多姆卡，灭战者"
	RATL["TraitRow2_Warrior_Arms_Upgraded"]			 = "亡者的复仇"
	RATL["TraitRow3_Warrior_Arms_Valorous"]			 = "掠火"
	RATL["TraitRow4_Warrior_Arms_War-torn"]			 = "愤怒之刃"
	RATL["TraitRow5_Warrior_Arms_Challenging"]			 = "天空勇士之刃"
	RATL["TraitRow6_Warrior_Arms_Hidden"]				 = "奥金破刃斧"

	RATL["TraitRow1_Warrior_Fury_Classic"]				 = "瓦拉加尔战剑"
	RATL["TraitRow2_Warrior_Fury_Upgraded"]			 = "龙骑兵之臂"
	RATL["TraitRow3_Warrior_Fury_Valorous"]			 = "勇气之喉"
	RATL["TraitRow4_Warrior_Fury_War-torn"]			 = "风暴之息"
	RATL["TraitRow5_Warrior_Fury_Challenging"]			 = "海拉的凝视"
	RATL["TraitRow6_Warrior_Fury_Hidden"]				 = "斩龙者之锋"

	RATL["TraitRow1_Warrior_Protection_Classic"]		 = "大地守护者之鳞"
	RATL["TraitRow2_Warrior_Protection_Upgraded"]		 = "堕落君王之臂"
	RATL["TraitRow3_Warrior_Protection_Valorous"]		 = "背水之战"
	RATL["TraitRow4_Warrior_Protection_War-torn"]		 = "亡灵卫士的凝视"
	RATL["TraitRow5_Warrior_Protection_Challenging"]	 = "军团粉碎者"
	RATL["TraitRow6_Warrior_Protection_Hidden"]		 = "灭世者的临终之息"

	--Death Knight
	RATL["TraitRow1_DeathKnight_Blood_Classic"]		 = "诅咒之喉"
	RATL["TraitRow2_DeathKnight_Blood_Upgraded"]		 = "血喉"
	RATL["TraitRow3_DeathKnight_Blood_Valorous"]		 = "斩灵"
	RATL["TraitRow4_DeathKnight_Blood_War-torn"]		 = "斩杀者"
	RATL["TraitRow5_DeathKnight_Blood_Challenging"]	 = "骨颚"
	RATL["TraitRow6_DeathKnight_Blood_Hidden"]			 = "不死之触"

	RATL["TraitRow1_DeathKnight_Frost_Classic"]		 = "堕落王子之剑"
	RATL["TraitRow2_DeathKnight_Frost_Upgraded"]		 = "霜之哀伤的遗产"
	RATL["TraitRow3_DeathKnight_Frost_Valorous"]		 = "辛达苟萨之怒"
	RATL["TraitRow4_DeathKnight_Frost_War-torn"]		 = "守墓人"
	RATL["TraitRow5_DeathKnight_Frost_Challenging"]	 = "集魂者"
	RATL["TraitRow6_DeathKnight_Frost_Hidden"]			 = "黑暗符文剑"

	RATL["TraitRow1_DeathKnight_Unholy_Classic"]		 = "天启"
	RATL["TraitRow2_DeathKnight_Unholy_Upgraded"]		 = "邪恶之战"
	RATL["TraitRow3_DeathKnight_Unholy_Valorous"]		 = "瘟疫使者"
	RATL["TraitRow4_DeathKnight_Unholy_War-torn"]		 = "饥荒使者"
	RATL["TraitRow5_DeathKnight_Unholy_Challenging"]	 = "死亡裁决"
	RATL["TraitRow6_DeathKnight_Unholy_Hidden"]		 = "白骨收割者"

	--Hunter
	RATL["TraitRow1_Hunter_BeastMastery_Classic"]		 = "泰坦之击"
	RATL["TraitRow2_Hunter_BeastMastery_Upgraded"]		 = "雄鹰之眼"
	RATL["TraitRow3_Hunter_BeastMastery_Valorous"]		 = "雷象之怒"
	RATL["TraitRow4_Hunter_BeastMastery_War-torn"]		 = "野猪火炮"
	RATL["TraitRow5_Hunter_BeastMastery_Challenging"]	 = "毒蛇之噬"
	RATL["TraitRow6_Hunter_BeastMastery_Hidden"]		 = "泰坦之触"

	RATL["TraitRow1_Hunter_Marksmanship_Classic"]		 = "萨斯多拉，风行者的遗产"
	RATL["TraitRow2_Hunter_Marksmanship_Upgraded"]		 = "姐妹的羁绊"
	RATL["TraitRow3_Hunter_Marksmanship_Valorous"]		 = "凤凰涅磐"
	RATL["TraitRow4_Hunter_Marksmanship_War-torn"]		 = "游侠将军的守护"
	RATL["TraitRow5_Hunter_Marksmanship_Challenging"]	 = "风行者"
	RATL["TraitRow6_Hunter_Marksmanship_Hidden"]		 = "乌鸦卫士"

	RATL["TraitRow1_Hunter_Survival_Classic"]			 = "雄鹰之爪"
	RATL["TraitRow2_Hunter_Survival_Upgraded"]			 = "猎鹰重生"
	RATL["TraitRow3_Hunter_Survival_Valorous"]			 = "头狼之矛"
	RATL["TraitRow4_Hunter_Survival_War-torn"]			 = "毒蛇之击"
	RATL["TraitRow5_Hunter_Survival_Challenging"]		 = "森林守护者"
	RATL["TraitRow6_Hunter_Survival_Hidden"]			 = "巨熊之韧"

	--Shaman
	RATL["TraitRow1_Shaman_Elemental_Classic"]			 = "莱登之拳"
	RATL["TraitRow2_Shaman_Elemental_Upgraded"]		 = "风暴守护者"
	RATL["TraitRow3_Shaman_Elemental_Valorous"]		 = "大地语者"
	RATL["TraitRow4_Shaman_Elemental_War-torn"]		 = "堕落萨满之拳"
	RATL["TraitRow5_Shaman_Elemental_Challenging"]		 = "雷加尔的传承"
	RATL["TraitRow6_Shaman_Elemental_Hidden"]			 = "阿曼尼的威严"

	RATL["TraitRow1_Shaman_Enhancement_Classic"]		 = "毁灭之锤"
	RATL["TraitRow2_Shaman_Enhancement_Upgraded"]		 = "风暴使者"
	RATL["TraitRow3_Shaman_Enhancement_Valorous"]		 = "军团的末日"
	RATL["TraitRow4_Shaman_Enhancement_War-torn"]		 = "黑手的命运"
	RATL["TraitRow5_Shaman_Enhancement_Challenging"]	 = "台风"
	RATL["TraitRow6_Shaman_Enhancement_Hidden"]		 = "赞达拉的勇士"

	RATL["TraitRow1_Shaman_Restoration_Classic"]		 = "莎拉达尔，潮汐权杖"
	RATL["TraitRow2_Shaman_Restoration_Upgraded"]		 = "深海权杖"
	RATL["TraitRow3_Shaman_Restoration_Valorous"]		 = "泰坦之子"
	RATL["TraitRow4_Shaman_Restoration_War-torn"]		 = "图腾传人"
	RATL["TraitRow5_Shaman_Restoration_Challenging"]	 = "冰封命运"
	RATL["TraitRow6_Shaman_Restoration_Hidden"]		 = "盘蛇权杖"

	--Druid
	RATL["TraitRow1_Druid_Balance_Classic"]			 = "月神镰刀"
	RATL["TraitRow2_Druid_Balance_Upgraded"]			 = "戈德林的使者"
	RATL["TraitRow3_Druid_Balance_Valorous"]			 = "唤月"
	RATL["TraitRow4_Druid_Balance_War-torn"]			 = "梦魇苦痛"
	RATL["TraitRow5_Druid_Balance_Challenging"]		 = "魔力之镰"
	RATL["TraitRow6_Druid_Balance_Hidden"]				 = "太阳卫士之触"

	RATL["TraitRow1_Druid_Feral_Classic"]				 = "阿莎曼之牙"
	RATL["TraitRow2_Druid_Feral_Upgraded"]				 = "自然之怒"
	RATL["TraitRow3_Druid_Feral_Valorous"]				 = "原初猎手"
	RATL["TraitRow4_Druid_Feral_War-torn"]				 = "梦魇化身"
	RATL["TraitRow5_Druid_Feral_Challenging"]			 = "豹母之魂"
	RATL["TraitRow6_Druid_Feral_Hidden"]				 = "月魂"

	RATL["TraitRow1_Druid_Guardian_Classic"]			 = "乌索克之爪"
	RATL["TraitRow2_Druid_Guardian_Upgraded"]			 = "顽石之爪"
	RATL["TraitRow3_Druid_Guardian_Valorous"]			 = "乌索尔的化身"
	RATL["TraitRow4_Druid_Guardian_War-torn"]			 = "沉沦梦魇"
	RATL["TraitRow5_Druid_Guardian_Challenging"]		 = "灰喉之力"
	RATL["TraitRow6_Druid_Guardian_Hidden"]			 = "林地守护者"

	RATL["TraitRow1_Druid_Restoration_Classic"]		 = "加尼尔，母亲之树"
	RATL["TraitRow2_Druid_Restoration_Upgraded"]		 = "上古之树"
	RATL["TraitRow3_Druid_Restoration_Valorous"]		 = "晶化觉醒"
	RATL["TraitRow4_Druid_Restoration_War-torn"]		 = "死木守护者"
	RATL["TraitRow5_Druid_Restoration_Challenging"]	 = "暗夜的警示"
	RATL["TraitRow6_Druid_Restoration_Hidden"]			 = "守望者之冠"

	--Rogue
	RATL["TraitRow1_Rogue_Assassination_Classic"]		 = "弑君者"
	RATL["TraitRow2_Rogue_Assassination_Upgraded"]		 = "诅咒之手"
	RATL["TraitRow3_Rogue_Assassination_Valorous"]		 = "剖心者"
	RATL["TraitRow4_Rogue_Assassination_War-torn"]		 = "法师杀手之刃"
	RATL["TraitRow5_Rogue_Assassination_Challenging"]	 = "幽灵之刃"
	RATL["TraitRow6_Rogue_Assassination_Hidden"]		 = "碎骨者"

	RATL["TraitRow1_Rogue_Outlaw_Classic"]				 = "恐惧之刃"
	RATL["TraitRow2_Rogue_Outlaw_Upgraded"]			 = "海上魔王的许诺"
	RATL["TraitRow3_Rogue_Outlaw_Valorous"]			 = "烈焰之吻"
	RATL["TraitRow4_Rogue_Outlaw_War-torn"]			 = "恶棍的遗言"
	RATL["TraitRow5_Rogue_Outlaw_Challenging"]			 = "剑士之手"
	RATL["TraitRow6_Rogue_Outlaw_Hidden"]				 = "雷霆之怒，风领主的神圣之刃"
	
	RATL["TraitRow1_Rogue_Subtlety_Classic"]			 = "吞噬者之牙"
	RATL["TraitRow2_Rogue_Subtlety_Upgraded"]			 = "暗影之刃"
	RATL["TraitRow3_Rogue_Subtlety_Valorous"]			 = "恶魔之拥"
	RATL["TraitRow4_Rogue_Subtlety_War-torn"]			 = "饮血者"
	RATL["TraitRow5_Rogue_Subtlety_Challenging"]		 = "冰寒之刃"
	RATL["TraitRow6_Rogue_Subtlety_Hidden"]			 = "剧毒之咬"

	--Monk
	RATL["TraitRow1_Monk_Brewmaster_Classic"]			 = "福枬，云游者之友"
	RATL["TraitRow2_Monk_Brewmaster_Upgraded"]			 = "美猴王的重担"
	RATL["TraitRow3_Monk_Brewmaster_Valorous"]			 = "玄牛之心"
	RATL["TraitRow4_Monk_Brewmaster_War-torn"]			 = "龙火之握"
	RATL["TraitRow5_Monk_Brewmaster_Challenging"]		 = "迷雾使者"
	RATL["TraitRow6_Monk_Brewmaster_Hidden"]			 = "远古陈酿守护者"

	RATL["TraitRow1_Monk_Mistweaver_Classic"]			 = "神龙，迷雾之杖"
	RATL["TraitRow2_Monk_Mistweaver_Upgraded"]			 = "浓雾之钟"
	RATL["TraitRow3_Monk_Mistweaver_Valorous"]			 = "赤精之魂"
	RATL["TraitRow4_Monk_Mistweaver_War-torn"]			 = "煞魔之殇"
	RATL["TraitRow5_Monk_Mistweaver_Challenging"]		 = "宁静之符"
	RATL["TraitRow6_Monk_Mistweaver_Hidden"]			 = "不朽龙息"

	RATL["TraitRow1_Monk_Windwalker_Classic"]			 = "诸天之拳"
	RATL["TraitRow2_Monk_Windwalker_Upgraded"]			 = "奥拉基尔之触"
	RATL["TraitRow3_Monk_Windwalker_Valorous"]			 = "灵魂之触"
	RATL["TraitRow4_Monk_Windwalker_War-torn"]			 = "影踪传承"
	RATL["TraitRow5_Monk_Windwalker_Challenging"]		 = "雪怒执行者"
	RATL["TraitRow6_Monk_Windwalker_Hidden"]			 = "风暴之拳"

	--Warlock
	RATL["TraitRow1_Warlock_Affliction_Classic"]		 = "逆风收割者"
	RATL["TraitRow2_Warlock_Affliction_Upgraded"]		 = "苦难之手"
	RATL["TraitRow3_Warlock_Affliction_Valorous"]		 = "灵魂虹吸"
	RATL["TraitRow4_Warlock_Affliction_War-torn"]		 = "死亡之手"
	RATL["TraitRow5_Warlock_Affliction_Challenging"]	 = "罪人之脊"
	RATL["TraitRow6_Warlock_Affliction_Hidden"]		 = "命途之末"

	RATL["TraitRow1_Warlock_Demonology_Classic"]		 = "堕落者之颅"
	RATL["TraitRow2_Warlock_Demonology_Upgraded"]		 = "首席召唤师的凝视"
	RATL["TraitRow3_Warlock_Demonology_Valorous"]		 = "深渊领主之傲"
	RATL["TraitRow4_Warlock_Demonology_War-torn"]		 = "炽燃残骸"
	RATL["TraitRow5_Warlock_Demonology_Challenging"]	 = "失落之魂"
	RATL["TraitRow6_Warlock_Demonology_Hidden"]		 = "萨奇尔之面"

	RATL["TraitRow1_Warlock_Destruction_Classic"]		 = "萨格拉斯权杖"
	RATL["TraitRow2_Warlock_Destruction_Upgraded"]		 = "黑暗泰坦的狂妄"
	RATL["TraitRow3_Warlock_Destruction_Valorous"]		 = "古尔丹的回响"
	RATL["TraitRow4_Warlock_Destruction_War-torn"]		 = "毁灭者之影"
	RATL["TraitRow5_Warlock_Destruction_Challenging"]	 = "亵渎者的伪装"
	RATL["TraitRow6_Warlock_Destruction_Hidden"]		 = "军团之灾"

	--Priest
	RATL["TraitRow1_Priest_Discipline_Classic"]		 = "圣光之怒"
	RATL["TraitRow2_Priest_Discipline_Upgraded"]		 = "救赎者纹章"
	RATL["TraitRow3_Priest_Discipline_Valorous"]		 = "圣光之杯"
	RATL["TraitRow4_Priest_Discipline_War-torn"]		 = "不懈警戒"
	RATL["TraitRow5_Priest_Discipline_Challenging"]	 = "英灵之眼"
	RATL["TraitRow6_Priest_Discipline_Hidden"]			 = "护卷者塔杖"

	RATL["TraitRow1_Priest_Holy_Classic"]				 = "图雷，纳鲁道标"
	RATL["TraitRow2_Priest_Holy_Upgraded"]				 = "纯洁旌旗"
	RATL["TraitRow3_Priest_Holy_Valorous"]				 = "圣光守护者"
	RATL["TraitRow4_Priest_Holy_War-torn"]				 = "虚空之拥"
	RATL["TraitRow5_Priest_Holy_Challenging"]			 = "阿古斯的回忆"
	RATL["TraitRow6_Priest_Holy_Hidden"]				 = "光之子纹章"

	RATL["TraitRow1_Priest_Shadow_Classic"]			 = "黑暗帝国之刃"
	RATL["TraitRow2_Priest_Shadow_Upgraded"]			 = "古神之拥"
	RATL["TraitRow3_Priest_Shadow_Valorous"]			 = "堕落之刃"
	RATL["TraitRow4_Priest_Shadow_War-torn"]			 = "疯狂幻象"
	RATL["TraitRow5_Priest_Shadow_Challenging"]		 = "扭曲镜像"
	RATL["TraitRow6_Priest_Shadow_Hidden"]				 = "恩佐斯之爪"

	--Mage
	RATL["TraitRow1_Mage_Arcane_Classic"]				 = "艾露尼斯"
	RATL["TraitRow2_Mage_Arcane_Upgraded"]				 = "守护者塔杖"
	RATL["TraitRow3_Mage_Arcane_Valorous"]				 = "自由护法者"
	RATL["TraitRow4_Mage_Arcane_War-torn"]				 = "艾格文之陨"
	RATL["TraitRow5_Mage_Arcane_Challenging"]			 = "不朽的魔导师"
	RATL["TraitRow6_Mage_Arcane_Hidden"]				 = "牧羊人的警示"

	RATL["TraitRow1_Mage_Fire_Classic"]				 = "烈焰之击"
	RATL["TraitRow2_Mage_Fire_Upgraded"]				 = "逐日者之傲"
	RATL["TraitRow3_Mage_Fire_Valorous"]				 = "凤凰涅槃"
	RATL["TraitRow4_Mage_Fire_War-torn"]				 = "火裔之刃"
	RATL["TraitRow5_Mage_Fire_Challenging"]			 = "缚时者之刃"
	RATL["TraitRow6_Mage_Fire_Hidden"]					 = "群星之图"

	RATL["TraitRow1_Mage_Frost_Classic"]				 = "黑檀之寒"
	RATL["TraitRow2_Mage_Frost_Upgraded"]				 = "守护者的焦镜"
	RATL["TraitRow3_Mage_Frost_Valorous"]				 = "原初之流"
	RATL["TraitRow4_Mage_Frost_War-torn"]				 = "大法师的意志"
	RATL["TraitRow5_Mage_Frost_Challenging"]			 = "精锐魔导师"
	RATL["TraitRow6_Mage_Frost_Hidden"]				 = "霜火之忆"

elseif GetLocale() == "zhTW" then
	-- Traditional Chinese translations go here
	RATL["Addon_Title"] = "Remix Artifact Tracker"
	RATL["Addon_Notes"] = "為軍團重混的神器武器新增一個神器外觀分頁。"
	RATL["SlashCmd1"] = "/rat"
	RATL["SlashCmd2"] = "/混搭神器"
	RATL["SlashCmd3"] = "/remixartifact"

	RATL["Traits"] = ARTIFACTS_PERK_TAB
	RATL["Appearances"] = ARTIFACTS_APPEARANCE_TAB
	RATL["ShowSecondary"] = "顯示次要"
	RATL["ShowSecondaryTT"] = "顯示與此套裝關聯的次要模型。"
	RATL["RaceNightElf"] = GetRaceName(4)
	RATL["RaceHaranir"] = GetRaceName(86)
	RATL["RaceTauren"] = GetRaceName(6)
	RATL["RaceHMTauren"] = GetRaceName(28)
	RATL["RaceTroll"] = GetRaceName(8)
	RATL["RaceZandalari"] = GetRaceName(31)
	RATL["RaceWorgen"] = GetRaceName(22)
	RATL["RaceKulTiran"] = GetRaceName(32)
	RATL["RaceGroup1"] = RATL["RaceNightElf"] -- .. ", " .. RATL["RaceHaranir"] -- (maybe for future?)
	RATL["RaceGroup2"] = RATL["RaceTauren"] .. "， " .. RATL["RaceHMTauren"]
	RATL["RaceGroup3"] = RATL["RaceTroll"] .. "， " .. RATL["RaceZandalari"]
	RATL["RaceGroup4"] = RATL["RaceWorgen"] .. "， " .. RATL["RaceKulTiran"]
	RATL["Artifact"] = ITEM_QUALITY6_DESC
	RATL["Unavailable"] = UNAVAILABLE
	RATL["NoLongerAvailable"] = NO_LONGER_AVAILABLE

	RATL["TraitRow1Temp_Classic"]		 = "經典"
	RATL["TraitRow2Temp_Upgraded"]		 = "進階"
	RATL["TraitRow3Temp_Valorous"]		 = "英勇"
	RATL["TraitRow4Temp_War-torn"]		 = "兵禍"
	RATL["TraitRow5Temp_Challenging"]	 = "挑戰"
	RATL["TraitRow6Temp_Hidden"]		 = "隱藏版"

	--classic
	RATL["TraitRow1Tint1Req"] = ""
	RATL["TraitRow1Tint2Req"] = "取得其中一個創世之柱。"
	RATL["TraitRow1Tint3Req"] = "取得聖光之心並安全將其送回你的職業大廳。"
	RATL["TraitRow1Tint4Req"] = "完成你職業的第一個主要劇情戰役。"

	--upgraded
	RATL["TraitRow2Tint1Req"] = string.format("完成%s的職業大廳劇情戰役。", ClassName)
	RATL["TraitRow2Tint2Req"] = string.format("完成%s的職業大廳劇情戰役。", ClassName)
	RATL["TraitRow2Tint3Req"] = string.format("完成%s的職業大廳劇情戰役。", ClassName)
	RATL["TraitRow2Tint4Req"] = "完成「此面向上」成就。"

	--valorous
	RATL["TraitRow3Tint1Req"] = "完成「足以抗衡的力量」任務線。"
	RATL["TraitRow3Tint2Req"] = "完成「怪獸大學」成就。\n\n完成「足以抗衡的力量」任務線。"
	RATL["TraitRow3Tint3Req"] = "使用等級5的鑰石完成一個傳奇地城。\n\n完成「足以抗衡的力量」任務線。"
	RATL["TraitRow3Tint4Req"] = "完成「軍團英雄的榮耀」成就。完成「足以抗衡的力量」任務線。"

	--war-torn
	RATL["TraitRow4Tint1Req"] = "參與玩家對玩家戰鬥並達到榮譽等級10。"
	RATL["TraitRow4Tint2Req"] = "達到榮譽等級30。"
	RATL["TraitRow4Tint3Req"] = "達到榮譽等級50。"
	RATL["TraitRow4Tint4Req"] = "達到榮譽等級80。"

	--challenging (swapped with Hidden)
	RATL["TraitRow5Tint1Req_THR"] = "完成「卡魯歐歸來」任務線。"
	RATL["TraitRow5Tint2Req_THR"] = "在解鎖挑戰任務神兵武器外觀後在英雄難度擊敗基爾加丹。\n\n完成「卡魯歐歸來」任務線。"
	RATL["TraitRow5Tint3Req_THR"] = "在解鎖挑戰任務神兵武器外觀後，贏得10場積分戰場。\n\n完成「卡魯歐歸來」任務線。"
	RATL["TraitRow5Tint4Req_THR"] = "在解鎖挑戰任務神兵武器外觀後，完成10個不同的軍團地城。\n\n完成「卡魯歐歸來」任務。"

	RATL["TraitRow5Tint1Req_XC"] = "完成「賽倫挑戰」任務線。"
	RATL["TraitRow5Tint2Req_XC"] = "在解鎖挑戰任務神兵武器外觀後在英雄難度擊敗基爾加丹。\n\n完成「賽倫挑戰」任務線。"
	RATL["TraitRow5Tint3Req_XC"] = "在解鎖挑戰任務神兵武器外觀後，贏得10場積分戰場。\n\n完成「賽倫挑戰」任務線。"
	RATL["TraitRow5Tint4Req_XC"] = "在解鎖挑戰任務神兵武器外觀後，完成10個不同的軍團地城。\n\n完成「賽倫挑戰」任務。"

	RATL["TraitRow5Tint1Req_IMC"] = "完成「鬼母挑戰」任務線。"
	RATL["TraitRow5Tint2Req_IMC"] = "在解鎖挑戰任務神兵武器外觀後在英雄難度擊敗基爾加丹。\n\n完成「鬼母挑戰」任務線。"
	RATL["TraitRow5Tint3Req_IMC"] = "在解鎖挑戰任務神兵武器外觀後，贏得10場積分戰場。\n\n完成「鬼母挑戰」任務線。"
	RATL["TraitRow5Tint4Req_IMC"] = "在解鎖挑戰任務神兵武器外觀後，完成10個不同的軍團地城。\n\n完成「鬼母挑戰」任務。"

	RATL["TraitRow5Tint1Req_TC"] = "完成「雙子挑戰」任務線。"
	RATL["TraitRow5Tint2Req_TC"] = "在解鎖挑戰任務神兵武器外觀後在英雄難度擊敗基爾加丹。\n\n完成「雙子挑戰」任務線。"
	RATL["TraitRow5Tint3Req_TC"] = "在解鎖挑戰任務神兵武器外觀後，贏得10場積分戰場。\n\n完成「雙子挑戰」任務線。"
	RATL["TraitRow5Tint4Req_TC"] = "在解鎖挑戰任務神兵武器外觀後，完成10個不同的軍團地城。\n\n完成「雙子挑戰」任務。"

	RATL["TraitRow5Tint1Req_TBRT"] = "完成「玄鴉危機」任務線。"
	RATL["TraitRow5Tint2Req_TBRT"] = "在解鎖挑戰任務神兵武器外觀後在英雄難度擊敗基爾加丹。\n\n完成「玄鴉危機」任務線。"
	RATL["TraitRow5Tint3Req_TBRT"] = "在解鎖挑戰任務神兵武器外觀後，贏得10場積分戰場。\n\n完成「玄鴉危機」任務線。"
	RATL["TraitRow5Tint4Req_TBRT"] = "在解鎖挑戰任務神兵武器外觀後，完成10個不同的軍團地城。\n\n完成「玄鴉危機」任務。"

	RATL["TraitRow5Tint1Req_TFWM"] = "完成「魔化蟲威脅」任務線。"
	RATL["TraitRow5Tint2Req_TFWM"] = "在解鎖挑戰任務神兵武器外觀後在英雄難度擊敗基爾加丹。\n\n完成「魔化蟲威脅」任務線。"
	RATL["TraitRow5Tint3Req_TFWM"] = "在解鎖挑戰任務神兵武器外觀後，贏得10場積分戰場。\n\n完成「魔化蟲威脅」任務線。"
	RATL["TraitRow5Tint4Req_TFWM"] = "在解鎖挑戰任務神兵武器外觀後，完成10個不同的軍團地城。\n\n完成「魔化蟲威脅」任務。"

	RATL["TraitRow5Tint1Req_GQC"] = "完成「神御女王挑戰」任務線。"
	RATL["TraitRow5Tint2Req_GQC"] = "在解鎖挑戰任務神兵武器外觀後在英雄難度擊敗基爾加丹。\n\n完成「神御女王挑戰」任務線。"
	RATL["TraitRow5Tint3Req_GQC"] = "在解鎖挑戰任務神兵武器外觀後，贏得10場積分戰場。\n\n完成「神御女王挑戰」任務線。"
	RATL["TraitRow5Tint4Req_GQC"] = "在解鎖挑戰任務神兵武器外觀後，完成10個不同的軍團地城。\n\n完成「神御女王挑戰」任務。"

	--hidden (swapped with Challenging)
	RATL["TraitRow6Tint1Req"] = ""
	RATL["TraitRow6Tint2Req"] = "在解鎖隱藏版神兵武器外觀後完成30座軍臨天下地城。"
	RATL["TraitRow6Tint3Req"] = "在解鎖隱藏版神兵武器外觀後完成200個世界任務。"
	RATL["TraitRow6Tint4Req"] = "在解鎖隱藏版神兵武器外觀後殺死1,000名敵方玩家。"

	--Demon Hunter
	RATL["TraitRow1_DemonHunter_Havoc_Classic"]		 = "欺詐者雙刃"
	RATL["TraitRow2_DemonHunter_Havoc_Upgraded"]		 = "伊利達瑞之手"
	RATL["TraitRow3_DemonHunter_Havoc_Valorous"]		 = "晦暗之刃"
	RATL["TraitRow4_DemonHunter_Havoc_War-torn"]		 = "惡魔之觸"
	RATL["TraitRow5_DemonHunter_Havoc_Challenging"]	 = "奪焰者"
	RATL["TraitRow6_DemonHunter_Havoc_Hidden"]			 = "死亡行者"

	RATL["TraitRow1_DemonHunter_Vengeance_Classic"]	 = "奧達奇戰刃"
	RATL["TraitRow2_DemonHunter_Vengeance_Upgraded"]	 = "伊利達瑞紋章"
	RATL["TraitRow3_DemonHunter_Vengeance_Valorous"]	 = "驚懼領主之噬"
	RATL["TraitRow4_DemonHunter_Vengeance_War-torn"]	 = "恐懼之骨"
	RATL["TraitRow5_DemonHunter_Vengeance_Challenging"] = "幽暗之翼"
	RATL["TraitRow6_DemonHunter_Vengeance_Hidden"]		 = "鋼鐵看守者"

	--Paladin
	RATL["TraitRow1_Paladin_Retribution_Classic"]		 = "灰燼使者"
	RATL["TraitRow2_Paladin_Retribution_Upgraded"]		 = "正義巨劍"
	RATL["TraitRow3_Paladin_Retribution_Valorous"]		 = "燃燒報復"
	RATL["TraitRow4_Paladin_Retribution_War-torn"]		 = "殞落希望"
	RATL["TraitRow5_Paladin_Retribution_Challenging"]	 = "碎破清算"
	RATL["TraitRow6_Paladin_Retribution_Hidden"]		 = "腐化的回憶"

	RATL["TraitRow1_Paladin_Holy_Classic"]				 = "白銀之手"
	RATL["TraitRow2_Paladin_Holy_Upgraded"]			 = "墮落看守者之拳"
	RATL["TraitRow3_Paladin_Holy_Valorous"]			 = "守護者的審判"
	RATL["TraitRow4_Paladin_Holy_War-torn"]			 = "守墓者"
	RATL["TraitRow5_Paladin_Holy_Challenging"]			 = "正義之火"
	RATL["TraitRow6_Paladin_Holy_Hidden"]				 = "看守者的武裝"

	RATL["TraitRow1_Paladin_Protection_Classic"]		 = "真理之盾"
	RATL["TraitRow2_Paladin_Protection_Upgraded"]		 = "泰坦之光"
	RATL["TraitRow3_Paladin_Protection_Valorous"]		 = "神性保衛者"
	RATL["TraitRow4_Paladin_Protection_War-torn"]		 = "黑暗守衛者"
	RATL["TraitRow5_Paladin_Protection_Challenging"]	 = "聖火紋章"
	RATL["TraitRow6_Paladin_Protection_Hidden"]		 = "復仇者的壁壘"

	--Warrior
	RATL["TraitRow1_Warrior_Arms_Classic"]				 = "斯托姆卡，破戰巨劍"
	RATL["TraitRow2_Warrior_Arms_Upgraded"]			 = "亡者的復仇"
	RATL["TraitRow3_Warrior_Arms_Valorous"]			 = "奪焰者"
	RATL["TraitRow4_Warrior_Arms_War-torn"]			 = "憤怒之刃"
	RATL["TraitRow5_Warrior_Arms_Challenging"]			 = "天空勇者之劍"
	RATL["TraitRow6_Warrior_Arms_Hidden"]				 = "奧金破刃斧"

	RATL["TraitRow1_Warrior_Fury_Classic"]				 = "華爾拉亞戰劍"
	RATL["TraitRow2_Warrior_Fury_Upgraded"]			 = "龍騎兵武裝"
	RATL["TraitRow3_Warrior_Fury_Valorous"]			 = "勇氣之喉"
	RATL["TraitRow4_Warrior_Fury_War-torn"]			 = "風暴吐息"
	RATL["TraitRow5_Warrior_Fury_Challenging"]			 = "黑爾雅之視"
	RATL["TraitRow6_Warrior_Fury_Hidden"]				 = "屠龍者的斬斧"

	RATL["TraitRow1_Warrior_Protection_Classic"]		 = "大地守護者之鱗"
	RATL["TraitRow2_Warrior_Protection_Upgraded"]		 = "墮王武裝"
	RATL["TraitRow3_Warrior_Protection_Valorous"]		 = "無畏不屈"
	RATL["TraitRow4_Warrior_Protection_War-torn"]		 = "亡靈守衛的凝視"
	RATL["TraitRow5_Warrior_Protection_Challenging"]	 = "軍團破壞者"
	RATL["TraitRow6_Warrior_Protection_Hidden"]		 = "碎界者的臨終之息"

	--Death Knight
	RATL["TraitRow1_DeathKnight_Blood_Classic"]		 = "遭譴者之顎"
	RATL["TraitRow2_DeathKnight_Blood_Upgraded"]		 = "血喉"
	RATL["TraitRow3_DeathKnight_Blood_Valorous"]		 = "噬靈者"
	RATL["TraitRow4_DeathKnight_Blood_War-torn"]		 = "處決者"
	RATL["TraitRow5_DeathKnight_Blood_Challenging"]	 = "骨顎"
	RATL["TraitRow6_DeathKnight_Blood_Hidden"]			 = "不死之觸"

	RATL["TraitRow1_DeathKnight_Frost_Classic"]		 = "墮落王子之刃"
	RATL["TraitRow2_DeathKnight_Frost_Upgraded"]		 = "霜之哀傷的遺物"
	RATL["TraitRow3_DeathKnight_Frost_Valorous"]		 = "辛德拉苟莎之怒"
	RATL["TraitRow4_DeathKnight_Frost_War-torn"]		 = "守墓者"
	RATL["TraitRow5_DeathKnight_Frost_Challenging"]	 = "收魂者"
	RATL["TraitRow6_DeathKnight_Frost_Hidden"]			 = "黑暗符文刃"

	RATL["TraitRow1_DeathKnight_Unholy_Classic"]		 = "天啟"
	RATL["TraitRow2_DeathKnight_Unholy_Upgraded"]		 = "穢邪之戰"
	RATL["TraitRow3_DeathKnight_Unholy_Valorous"]		 = "疫病信使"
	RATL["TraitRow4_DeathKnight_Unholy_War-torn"]		 = "饑荒使者"
	RATL["TraitRow5_DeathKnight_Unholy_Challenging"]	 = "死亡判決"
	RATL["TraitRow6_DeathKnight_Unholy_Hidden"]		 = "亡骨鉤鐮"

	--Hunter
	RATL["TraitRow1_Hunter_BeastMastery_Classic"]		 = "泰坦之擊"
	RATL["TraitRow2_Hunter_BeastMastery_Upgraded"]		 = "鷹眼絕射"
	RATL["TraitRow3_Hunter_BeastMastery_Valorous"]		 = "伊萊克之雷"
	RATL["TraitRow4_Hunter_BeastMastery_War-torn"]		 = "野豬火砲"
	RATL["TraitRow5_Hunter_BeastMastery_Challenging"]	 = "毒蛇之噬"
	RATL["TraitRow6_Hunter_BeastMastery_Hidden"]		 = "泰坦機弓"

	RATL["TraitRow1_Hunter_Marksmanship_Classic"]		 = "薩斯朵拉 風行者之遺"
	RATL["TraitRow2_Hunter_Marksmanship_Upgraded"]		 = "姊妹情深"
	RATL["TraitRow3_Hunter_Marksmanship_Valorous"]		 = "鳳凰重生"
	RATL["TraitRow4_Hunter_Marksmanship_War-torn"]		 = "遊俠將軍的護衛"
	RATL["TraitRow5_Hunter_Marksmanship_Challenging"]	 = "野地行者"
	RATL["TraitRow6_Hunter_Marksmanship_Hidden"]		 = "烏鴉守衛"

	RATL["TraitRow1_Hunter_Survival_Classic"]			 = "猛禽之爪"
	RATL["TraitRow2_Hunter_Survival_Upgraded"]			 = "神鷹重生"
	RATL["TraitRow3_Hunter_Survival_Valorous"]			 = "狼王之矛"
	RATL["TraitRow4_Hunter_Survival_War-torn"]			 = "毒蛇之擊"
	RATL["TraitRow5_Hunter_Survival_Challenging"]		 = "森林守護者"
	RATL["TraitRow6_Hunter_Survival_Hidden"]			 = "巨熊之韌"

	--Shaman
	RATL["TraitRow1_Shaman_Elemental_Classic"]			 = "萊公之拳"
	RATL["TraitRow2_Shaman_Elemental_Upgraded"]		 = "風暴守護者"
	RATL["TraitRow3_Shaman_Elemental_Valorous"]		 = "語地者"
	RATL["TraitRow4_Shaman_Elemental_War-torn"]		 = "墮落薩滿之拳"
	RATL["TraitRow5_Shaman_Elemental_Challenging"]		 = "雷加的傳承"
	RATL["TraitRow6_Shaman_Elemental_Hidden"]			 = "阿曼尼的尊榮"

	RATL["TraitRow1_Shaman_Enhancement_Classic"]		 = "末日錘"
	RATL["TraitRow2_Shaman_Enhancement_Upgraded"]		 = "風暴使者"
	RATL["TraitRow3_Shaman_Enhancement_Valorous"]		 = "燃燒軍團的末日"
	RATL["TraitRow4_Shaman_Enhancement_War-torn"]		 = "黑手的命運"
	RATL["TraitRow5_Shaman_Enhancement_Challenging"]	 = "颱風"
	RATL["TraitRow6_Shaman_Enhancement_Hidden"]		 = "贊達拉勇士"

	RATL["TraitRow1_Shaman_Restoration_Classic"]		 = "薩拉達爾，海潮權杖"
	RATL["TraitRow2_Shaman_Restoration_Upgraded"]		 = "深淵權杖"
	RATL["TraitRow3_Shaman_Restoration_Valorous"]		 = "泰坦後裔"
	RATL["TraitRow4_Shaman_Restoration_War-torn"]		 = "圖騰使者"
	RATL["TraitRow5_Shaman_Restoration_Challenging"]	 = "冰封運命"
	RATL["TraitRow6_Shaman_Restoration_Hidden"]		 = "盤蛇"

	--Druid
	RATL["TraitRow1_Druid_Balance_Classic"]			 = "伊露恩之鐮"
	RATL["TraitRow2_Druid_Balance_Upgraded"]			 = "戈德林使者"
	RATL["TraitRow3_Druid_Balance_Valorous"]			 = "月喚"
	RATL["TraitRow4_Druid_Balance_War-torn"]			 = "夢魘腐化"
	RATL["TraitRow5_Druid_Balance_Challenging"]		 = "法力鐮刀"
	RATL["TraitRow6_Druid_Balance_Hidden"]				 = "守日者之擊"

	RATL["TraitRow1_Druid_Feral_Classic"]				 = "亞夏曼之牙"
	RATL["TraitRow2_Druid_Feral_Upgraded"]				 = "自然之怒"
	RATL["TraitRow3_Druid_Feral_Valorous"]				 = "原始潛獵者"
	RATL["TraitRow4_Druid_Feral_War-torn"]				 = "夢魘化身"
	RATL["TraitRow5_Druid_Feral_Challenging"]			 = "獸母之魂"
	RATL["TraitRow6_Druid_Feral_Hidden"]				 = "月梟之靈"

	RATL["TraitRow1_Druid_Guardian_Classic"]			 = "厄索克之爪"
	RATL["TraitRow2_Druid_Guardian_Upgraded"]			 = "石爪"
	RATL["TraitRow3_Druid_Guardian_Valorous"]			 = "厄索爾的化身"
	RATL["TraitRow4_Druid_Guardian_War-torn"]			 = "臣服夢魘"
	RATL["TraitRow5_Druid_Guardian_Challenging"]		 = "灰喉之力"
	RATL["TraitRow6_Druid_Guardian_Hidden"]			 = "林地守護者"

	RATL["TraitRow1_Druid_Restoration_Classic"]		 = "格哈尼爾，始祖之樹"
	RATL["TraitRow2_Druid_Restoration_Upgraded"]		 = "長者之樹"
	RATL["TraitRow3_Druid_Restoration_Valorous"]		 = "水晶覺醒"
	RATL["TraitRow4_Druid_Restoration_War-torn"]		 = "死木守衛者"
	RATL["TraitRow5_Druid_Restoration_Challenging"]	 = "長夜警醒"
	RATL["TraitRow6_Druid_Restoration_Hidden"]			 = "看守者之冠"

	--Rogue
	RATL["TraitRow1_Rogue_Assassination_Classic"]		 = "弒君之刃"
	RATL["TraitRow2_Rogue_Assassination_Upgraded"]		 = "詛咒之手"
	RATL["TraitRow3_Rogue_Assassination_Valorous"]		 = "絕心者"
	RATL["TraitRow4_Rogue_Assassination_War-torn"]		 = "屠法者之刃"
	RATL["TraitRow5_Rogue_Assassination_Challenging"]	 = "幽魂刃"
	RATL["TraitRow6_Rogue_Assassination_Hidden"]		 = "斷骨者"

	RATL["TraitRow1_Rogue_Outlaw_Classic"]				 = "驚懼雙刀"
	RATL["TraitRow2_Rogue_Outlaw_Upgraded"]			 = "海上煞星的承諾"
	RATL["TraitRow3_Rogue_Outlaw_Valorous"]			 = "火吻"
	RATL["TraitRow4_Rogue_Outlaw_War-torn"]			 = "惡棍遺言"
	RATL["TraitRow5_Rogue_Outlaw_Challenging"]			 = "劍士之擊"
	RATL["TraitRow6_Rogue_Outlaw_Hidden"]				 = "雷霆之怒 馭風者的神聖之刃"
	
	RATL["TraitRow1_Rogue_Subtlety_Classic"]			 = "吞噬者之牙"
	RATL["TraitRow2_Rogue_Subtlety_Upgraded"]			 = "影刃"
	RATL["TraitRow3_Rogue_Subtlety_Valorous"]			 = "魔擁"
	RATL["TraitRow4_Rogue_Subtlety_War-torn"]			 = "血飲"
	RATL["TraitRow5_Rogue_Subtlety_Challenging"]		 = "冰剪"
	RATL["TraitRow6_Rogue_Subtlety_Hidden"]			 = "毒噬"

	--Monk
	RATL["TraitRow1_Monk_Brewmaster_Classic"]			 = "福山之杖 漫行者之伴"
	RATL["TraitRow2_Monk_Brewmaster_Upgraded"]			 = "美猴王的重擔"
	RATL["TraitRow3_Monk_Brewmaster_Valorous"]			 = "玄牛之心"
	RATL["TraitRow4_Monk_Brewmaster_War-torn"]			 = "龍焰之握"
	RATL["TraitRow5_Monk_Brewmaster_Challenging"]		 = "迷霧使者"
	RATL["TraitRow6_Monk_Brewmaster_Hidden"]			 = "遠古釀酒大師"

	RATL["TraitRow1_Monk_Mistweaver_Classic"]			 = "雪崙，迷霧之杖"
	RATL["TraitRow2_Monk_Mistweaver_Upgraded"]			 = "濛霧響鐘"
	RATL["TraitRow3_Monk_Mistweaver_Valorous"]			 = "赤吉之靈"
	RATL["TraitRow4_Monk_Mistweaver_War-torn"]			 = "煞化絕刑"
	RATL["TraitRow5_Monk_Mistweaver_Challenging"]		 = "寧神之華"
	RATL["TraitRow6_Monk_Mistweaver_Hidden"]			 = "不朽龍息"

	RATL["TraitRow1_Monk_Windwalker_Classic"]			 = "蒼天之拳"
	RATL["TraitRow2_Monk_Windwalker_Upgraded"]			 = "奧拉基爾之觸"
	RATL["TraitRow3_Monk_Windwalker_Valorous"]			 = "魂靈之擊"
	RATL["TraitRow4_Monk_Windwalker_War-torn"]			 = "影潘傳承"
	RATL["TraitRow5_Monk_Windwalker_Challenging"]		 = "雪怒執法者"
	RATL["TraitRow6_Monk_Windwalker_Hidden"]			 = "風暴之拳"

	--Warlock
	RATL["TraitRow1_Warlock_Affliction_Classic"]		 = "逆風收割者"
	RATL["TraitRow2_Warlock_Affliction_Upgraded"]		 = "苦難之手"
	RATL["TraitRow3_Warlock_Affliction_Valorous"]		 = "靈魂虹吸"
	RATL["TraitRow4_Warlock_Affliction_War-torn"]		 = "死神之手"
	RATL["TraitRow5_Warlock_Affliction_Challenging"]	 = "罪人脊骨"
	RATL["TraitRow6_Warlock_Affliction_Hidden"]		 = "命運終結"

	RATL["TraitRow1_Warlock_Demonology_Classic"]		 = "曼那瑞之顱"
	RATL["TraitRow2_Warlock_Demonology_Upgraded"]		 = "初代召喚師的凝視"
	RATL["TraitRow3_Warlock_Demonology_Valorous"]		 = "深淵領主之傲"
	RATL["TraitRow4_Warlock_Demonology_War-torn"]		 = "燃燒殘怨"
	RATL["TraitRow5_Warlock_Demonology_Challenging"]	 = "遺忘之魂"
	RATL["TraitRow6_Warlock_Demonology_Hidden"]		 = "薩奇爾的面容"

	RATL["TraitRow1_Warlock_Destruction_Classic"]		 = "薩格拉斯權杖"
	RATL["TraitRow2_Warlock_Destruction_Upgraded"]		 = "黑暗泰坦的傲慢"
	RATL["TraitRow3_Warlock_Destruction_Valorous"]		 = "古爾丹的回聲"
	RATL["TraitRow4_Warlock_Destruction_War-torn"]		 = "毀滅者之影"
	RATL["TraitRow5_Warlock_Destruction_Challenging"]	 = "晦暗者的偽裝"
	RATL["TraitRow6_Warlock_Destruction_Hidden"]		 = "軍團之懼"

	--Priest
	RATL["TraitRow1_Priest_Discipline_Classic"]		 = "聖光之怒"
	RATL["TraitRow2_Priest_Discipline_Upgraded"]		 = "救贖紋章"
	RATL["TraitRow3_Priest_Discipline_Valorous"]		 = "聖光之杯"
	RATL["TraitRow4_Priest_Discipline_War-torn"]		 = "永恆之惕"
	RATL["TraitRow5_Priest_Discipline_Challenging"]	 = "昇靈守望"
	RATL["TraitRow6_Priest_Discipline_Hidden"]			 = "聖典守衛者之杖"

	RATL["TraitRow1_Priest_Holy_Classic"]				 = "杜爾，那魯光杖"
	RATL["TraitRow2_Priest_Holy_Upgraded"]				 = "純淨旌旗"
	RATL["TraitRow3_Priest_Holy_Valorous"]				 = "光之守衛者"
	RATL["TraitRow4_Priest_Holy_War-torn"]				 = "虛無之擁"
	RATL["TraitRow5_Priest_Holy_Challenging"]			 = "阿古斯的記憶"
	RATL["TraitRow6_Priest_Holy_Hidden"]				 = "光育紋章"

	RATL["TraitRow1_Priest_Shadow_Classic"]			 = "黑暗帝國之刃"
	RATL["TraitRow2_Priest_Shadow_Upgraded"]			 = "上古之神的擁抱"
	RATL["TraitRow3_Priest_Shadow_Valorous"]			 = "墮落之刃"
	RATL["TraitRow4_Priest_Shadow_War-torn"]			 = "瘋狂異象"
	RATL["TraitRow5_Priest_Shadow_Challenging"]		 = "曲折鏡像"
	RATL["TraitRow6_Priest_Shadow_Hidden"]				 = "恩若司之爪"

	--Mage
	RATL["TraitRow1_Mage_Arcane_Classic"]				 = "亞魯涅斯"
	RATL["TraitRow2_Mage_Arcane_Upgraded"]				 = "守護者之塔"
	RATL["TraitRow3_Mage_Arcane_Valorous"]				 = "尊者降世"
	RATL["TraitRow4_Mage_Arcane_War-torn"]				 = "艾格文之殞"
	RATL["TraitRow5_Mage_Arcane_Challenging"]			 = "不朽魔導師"
	RATL["TraitRow6_Mage_Arcane_Hidden"]				 = "毛卜師之杖"

	RATL["TraitRow1_Mage_Fire_Classic"]				 = "費羅米隆"
	RATL["TraitRow2_Mage_Fire_Upgraded"]				 = "逐日者之傲"
	RATL["TraitRow3_Mage_Fire_Valorous"]				 = "鳳凰重生"
	RATL["TraitRow4_Mage_Fire_War-torn"]				 = "熔岩火刃"
	RATL["TraitRow5_Mage_Fire_Challenging"]			 = "曲時之劍"
	RATL["TraitRow6_Mage_Fire_Hidden"]					 = "星辰圖譜"

	RATL["TraitRow1_Mage_Frost_Classic"]				 = "黯凜"
	RATL["TraitRow2_Mage_Frost_Upgraded"]				 = "守護者的聚能"
	RATL["TraitRow3_Mage_Frost_Valorous"]				 = "原初之流"
	RATL["TraitRow4_Mage_Frost_War-torn"]				 = "大法師的意志"
	RATL["TraitRow5_Mage_Frost_Challenging"]			 = "精英魔導師"
	RATL["TraitRow6_Mage_Frost_Hidden"]				 = "霜火回憶"

else
	RATL["Addon_Title"] = "Remix Artifact Tracker"
	RATL["Addon_Notes"] = "Adds an artifact appearance tab to the artifact weapons for Legion Remix"
	RATL["SlashCmd1"] = "/rat"
	RATL["SlashCmd2"] = "/rat"
	RATL["SlashCmd3"] = "/remixartifact"

	RATL["Traits"] = ARTIFACTS_PERK_TAB
	RATL["Appearances"] = ARTIFACTS_APPEARANCE_TAB
	RATL["ShowSecondary"] = "Show Secondary"
	RATL["ShowSecondaryTT"] = "Display the secondary model tied to this set."
	RATL["RaceNightElf"] = GetRaceName(4)
	RATL["RaceHaranir"] = GetRaceName(86)
	RATL["RaceTauren"] = GetRaceName(6)
	RATL["RaceHMTauren"] = GetRaceName(28)
	RATL["RaceTroll"] = GetRaceName(8)
	RATL["RaceZandalari"] = GetRaceName(31)
	RATL["RaceWorgen"] = GetRaceName(22)
	RATL["RaceKulTiran"] = GetRaceName(32)
	RATL["RaceGroup1"] = RATL["RaceNightElf"] -- .. ", " .. RATL["RaceHaranir"] -- (maybe for future?)
	RATL["RaceGroup2"] = RATL["RaceTauren"] .. ", " .. RATL["RaceHMTauren"]
	RATL["RaceGroup3"] = RATL["RaceTroll"] .. ", " .. RATL["RaceZandalari"]
	RATL["RaceGroup4"] = RATL["RaceWorgen"] .. ", " .. RATL["RaceKulTiran"]
	RATL["Artifact"] = ITEM_QUALITY6_DESC
	RATL["Unavailable"] = UNAVAILABLE
	RATL["NoLongerAvailable"] = NO_LONGER_AVAILABLE

	RATL["TraitRow1Temp_Classic"]		 = "Classic"
	RATL["TraitRow2Temp_Upgraded"]		 = "Upgraded"
	RATL["TraitRow3Temp_Valorous"]		 = "Valorous"
	RATL["TraitRow4Temp_War-torn"]		 = "War-torn"
	RATL["TraitRow5Temp_Challenging"]	 = "Challenging"
	RATL["TraitRow6Temp_Hidden"]		 = "Hidden"

	--classic
	RATL["TraitRow1Tint1Req"] = ""
	RATL["TraitRow1Tint2Req"] = "Recover one of the Pillars of Creation."
	RATL["TraitRow1Tint3Req"] = "Recover Light's Heart and bring it to the safety of your Order Hall."
	RATL["TraitRow1Tint4Req"] = "Complete the first major campaign effort with your order."

	--upgraded
	RATL["TraitRow2Tint1Req"] = string.format("Complete the %s class hall campaign.", ClassName)
	RATL["TraitRow2Tint2Req"] = string.format("Complete the %s class hall campaign.", ClassName)
	RATL["TraitRow2Tint3Req"] = string.format("Complete the %s class hall campaign.", ClassName)
	RATL["TraitRow2Tint4Req"] = "Complete the achievement, \"This Side Up.\""

	--valorous
	RATL["TraitRow3Tint1Req"] = "Complete the quest line, \"Balance of Power.\""
	RATL["TraitRow3Tint2Req"] = "Complete the achievement, \"Unleashed Monstrosities.\"\n\nComplete the quest line, \"Balance of Power.\""
	RATL["TraitRow3Tint3Req"] = "Complete a Mythic Mode Dungeon using a level 5 keystone.\n\nComplete the quest line, \"Balance of Power.\""
	RATL["TraitRow3Tint4Req"] = "Complete the achievement, \"Glory of the Legion Hero.\"\n\nComplete the quest line, \"Balance of Power.\""

	--war-torn
	RATL["TraitRow4Tint1Req"] = "Participate in Player vs. Player combat and reach Honor Level 10."
	RATL["TraitRow4Tint2Req"] = "Reach Honor Level 30."
	RATL["TraitRow4Tint3Req"] = "Reach Honor Level 50."
	RATL["TraitRow4Tint4Req"] = "Reach Honor Level 80."

	--challenging (swapped with Hidden)
	RATL["TraitRow5Tint1Req_THR"] = "Complete the quest line, \"The Highlord's Return.\""
	RATL["TraitRow5Tint2Req_THR"] = "Defeat Heroic Kil'jaeden after unlocking a challenge artifact appearance.\n\nComplete the quest line, \"The Highlord's Return.\""
	RATL["TraitRow5Tint3Req_THR"] = "Win 10 rated battlegrounds after unlocking a challenge artifact appearance.\n\nComplete the quest line, \"The Highlord's Return.\""
	RATL["TraitRow5Tint4Req_THR"] = "Complete 10 different Legion dungeons after unlocking a challenge appearance.\n\nComplete the quest line, \"The Highlord's Return.\""

	RATL["TraitRow5Tint1Req_XC"] = "Complete the quest line, \"Xylem Challenge.\""
	RATL["TraitRow5Tint2Req_XC"] = "Defeat Heroic Kil'jaeden after unlocking a challenge artifact appearance.\n\nComplete the quest line, \"Xylem Challenge.\""
	RATL["TraitRow5Tint3Req_XC"] = "Win 10 rated battlegrounds after unlocking a challenge artifact appearance.\n\nComplete the quest line, \"Xylem Challenge.\""
	RATL["TraitRow5Tint4Req_XC"] = "Complete 10 different Legion dungeons after unlocking a challenge appearance.\n\nComplete the quest line, \"Xylem Challenge.\""

	RATL["TraitRow5Tint1Req_IMC"] = "Complete the quest line, \"Imp Mother Challenge.\""
	RATL["TraitRow5Tint2Req_IMC"] = "Defeat Heroic Kil'jaeden after unlocking a challenge artifact appearance.\n\nComplete the quest line, \"Imp Mother Challenge.\""
	RATL["TraitRow5Tint3Req_IMC"] = "Win 10 rated battlegrounds after unlocking a challenge artifact appearance.\n\nComplete the quest line, \"Imp Mother Challenge.\""
	RATL["TraitRow5Tint4Req_IMC"] = "Complete 10 different Legion dungeons after unlocking a challenge appearance.\n\nComplete the quest line, \"Imp Mother Challenge.\""

	RATL["TraitRow5Tint1Req_TC"] = "Complete the quest line, \"Twins Challenge.\""
	RATL["TraitRow5Tint2Req_TC"] = "Defeat Heroic Kil'jaeden after unlocking a challenge artifact appearance.\n\nComplete the quest line, \"Twins Challenge.\""
	RATL["TraitRow5Tint3Req_TC"] = "Win 10 rated battlegrounds after unlocking a challenge artifact appearance.\n\nComplete the quest line, \"Twins Challenge.\""
	RATL["TraitRow5Tint4Req_TC"] = "Complete 10 different Legion dungeons after unlocking a challenge appearance.\n\nComplete the quest line, \"Twins Challenge.\""

	RATL["TraitRow5Tint1Req_TBRT"] = "Complete the quest line, \"The Black Rook Threat.\""
	RATL["TraitRow5Tint2Req_TBRT"] = "Defeat Heroic Kil'jaeden after unlocking a challenge artifact appearance.\n\nComplete the quest line, \"The Black Rook Threat.\""
	RATL["TraitRow5Tint3Req_TBRT"] = "Win 10 rated battlegrounds after unlocking a challenge artifact appearance.\n\nComplete the quest line, \"The Black Rook Threat.\""
	RATL["TraitRow5Tint4Req_TBRT"] = "Complete 10 different Legion dungeons after unlocking a challenge appearance.\n\nComplete the quest line, \"The Black Rook Threat.\""

	RATL["TraitRow5Tint1Req_TFWM"] = "Complete the quest line, \"The Fel Worm Menace.\""
	RATL["TraitRow5Tint2Req_TFWM"] = "Defeat Heroic Kil'jaeden after unlocking a challenge artifact appearance.\n\nComplete the quest line, \"The Fel Worm Menace.\""
	RATL["TraitRow5Tint3Req_TFWM"] = "Win 10 rated battlegrounds after unlocking a challenge artifact appearance.\n\nComplete the quest line, \"The Fel Worm Menace.\""
	RATL["TraitRow5Tint4Req_TFWM"] = "Complete 10 different Legion dungeons after unlocking a challenge appearance.\n\nComplete the quest line, \"The Fel Worm Menace.\""

	RATL["TraitRow5Tint1Req_GQC"] = "Complete the quest line, \"God-Queen Challenge.\""
	RATL["TraitRow5Tint2Req_GQC"] = "Defeat Heroic Kil'jaeden after unlocking a challenge artifact appearance.\n\nComplete the quest line, \"God-Queen Challenge.\""
	RATL["TraitRow5Tint3Req_GQC"] = "Win 10 rated battlegrounds after unlocking a challenge artifact appearance.\n\nComplete the quest line, \"God-Queen Challenge.\""
	RATL["TraitRow5Tint4Req_GQC"] = "Complete 10 different Legion dungeons after unlocking a challenge appearance.\n\nComplete the quest line, \"God-Queen Challenge.\""

	--hidden (swapped with Challenging)
	RATL["TraitRow6Tint1Req"] = ""
	RATL["TraitRow6Tint2Req"] = "Complete 30 Legion dungeons after unlocking a hidden artifact appearance."
	RATL["TraitRow6Tint3Req"] = "Complete 200 World Quests after unlocking a hidden artifact appearance."
	RATL["TraitRow6Tint4Req"] = "Kill 1,000 enemy players after unlocking a hidden artifact appearance."

	--Demon Hunter
	RATL["TraitRow1_DemonHunter_Havoc_Classic"]		 = "Twinblades of the Deceiver"
	RATL["TraitRow2_DemonHunter_Havoc_Upgraded"]		 = "Hand of the Illidari"
	RATL["TraitRow3_DemonHunter_Havoc_Valorous"]		 = "Darkenblade"
	RATL["TraitRow4_DemonHunter_Havoc_War-torn"]		 = "Demon's Touch"
	RATL["TraitRow5_DemonHunter_Havoc_Challenging"]	 = "Flamereaper"
	RATL["TraitRow6_DemonHunter_Havoc_Hidden"]			 = "Deathwalker"

	RATL["TraitRow1_DemonHunter_Vengeance_Classic"]	 = "Aldrachi Warblades"
	RATL["TraitRow2_DemonHunter_Vengeance_Upgraded"]	 = "Illidari Crest"
	RATL["TraitRow3_DemonHunter_Vengeance_Valorous"]	 = "Dreadlord's Bite"
	RATL["TraitRow4_DemonHunter_Vengeance_War-torn"]	 = "Boneterror"
	RATL["TraitRow5_DemonHunter_Vengeance_Challenging"] = "Umberwing"
	RATL["TraitRow6_DemonHunter_Vengeance_Hidden"]		 = "Iron Warden"

	--Paladin
	RATL["TraitRow1_Paladin_Retribution_Classic"]		 = "Ashbringer"
	RATL["TraitRow2_Paladin_Retribution_Upgraded"]		 = "Greatsword of the Righteous"
	RATL["TraitRow3_Paladin_Retribution_Valorous"]		 = "Burning Reprisal"
	RATL["TraitRow4_Paladin_Retribution_War-torn"]		 = "Fallen Hope"
	RATL["TraitRow5_Paladin_Retribution_Challenging"]	 = "Shattered Reckoning"
	RATL["TraitRow6_Paladin_Retribution_Hidden"]		 = "Corrupted Remembrance"

	RATL["TraitRow1_Paladin_Holy_Classic"]				 = "The Silver Hand"
	RATL["TraitRow2_Paladin_Holy_Upgraded"]			 = "Fist of the Fallen Watcher"
	RATL["TraitRow3_Paladin_Holy_Valorous"]			 = "Protector's Judgment"
	RATL["TraitRow4_Paladin_Holy_War-torn"]			 = "Gravewarder"
	RATL["TraitRow5_Paladin_Holy_Challenging"]			 = "Justice's Flame"
	RATL["TraitRow6_Paladin_Holy_Hidden"]				 = "Watcher's Armament"

	RATL["TraitRow1_Paladin_Protection_Classic"]		 = "Truthguard"
	RATL["TraitRow2_Paladin_Protection_Upgraded"]		 = "Light of the Titans"
	RATL["TraitRow3_Paladin_Protection_Valorous"]		 = "Divine Protector"
	RATL["TraitRow4_Paladin_Protection_War-torn"]		 = "Dark Keeper's Ward"
	RATL["TraitRow5_Paladin_Protection_Challenging"]	 = "Crest of Holy Fire"
	RATL["TraitRow6_Paladin_Protection_Hidden"]		 = "Vindicator's Bulwark"

	--Warrior
	RATL["TraitRow1_Warrior_Arms_Classic"]				 = "Stromkar, the Warbreaker"
	RATL["TraitRow2_Warrior_Arms_Upgraded"]			 = "Vengeance of the Fallen"
	RATL["TraitRow3_Warrior_Arms_Valorous"]			 = "Flamereaper"
	RATL["TraitRow4_Warrior_Arms_War-torn"]			 = "Wrath's Edge"
	RATL["TraitRow5_Warrior_Arms_Challenging"]			 = "Blade of the Sky Champion"
	RATL["TraitRow6_Warrior_Arms_Hidden"]				 = "Arcanite Bladebreaker"

	RATL["TraitRow1_Warrior_Fury_Classic"]				 = "Warswords of the Valarjar"
	RATL["TraitRow2_Warrior_Fury_Upgraded"]			 = "Arm of the Dragonrider"
	RATL["TraitRow3_Warrior_Fury_Valorous"]			 = "Valormaw"
	RATL["TraitRow4_Warrior_Fury_War-torn"]			 = "Stormbreath"
	RATL["TraitRow5_Warrior_Fury_Challenging"]			 = "Helya's Gaze"
	RATL["TraitRow6_Warrior_Fury_Hidden"]				 = "Dragonslayer's Edge"

	RATL["TraitRow1_Warrior_Protection_Classic"]		 = "Scale of the Earth-Warder"
	RATL["TraitRow2_Warrior_Protection_Upgraded"]		 = "Arm of the Fallen King"
	RATL["TraitRow3_Warrior_Protection_Valorous"]		 = "Unbroken Stand"
	RATL["TraitRow4_Warrior_Protection_War-torn"]		 = "Deathguard's Gaze"
	RATL["TraitRow5_Warrior_Protection_Challenging"]	 = "Legionbreaker"
	RATL["TraitRow6_Warrior_Protection_Hidden"]		 = "Last Breath of the Worldbreaker"

	--Death Knight
	RATL["TraitRow1_DeathKnight_Blood_Classic"]		 = "Maw of the Damned"
	RATL["TraitRow2_DeathKnight_Blood_Upgraded"]		 = "Bloodmaw"
	RATL["TraitRow3_DeathKnight_Blood_Valorous"]		 = "Soulreaper"
	RATL["TraitRow4_DeathKnight_Blood_War-torn"]		 = "Executioner"
	RATL["TraitRow5_DeathKnight_Blood_Challenging"]	 = "Bonejaw"
	RATL["TraitRow6_DeathKnight_Blood_Hidden"]			 = "Touch of Undeath"

	RATL["TraitRow1_DeathKnight_Frost_Classic"]		 = "Blades of the Fallen Prince"
	RATL["TraitRow2_DeathKnight_Frost_Upgraded"]		 = "Frostmourne's Legacy"
	RATL["TraitRow3_DeathKnight_Frost_Valorous"]		 = "Sindragosa's Fury"
	RATL["TraitRow4_DeathKnight_Frost_War-torn"]		 = "Gravekeeper"
	RATL["TraitRow5_DeathKnight_Frost_Challenging"]	 = "Soul Collector"
	RATL["TraitRow6_DeathKnight_Frost_Hidden"]			 = "Dark Runeblade"

	RATL["TraitRow1_DeathKnight_Unholy_Classic"]		 = "Apocalypse"
	RATL["TraitRow2_DeathKnight_Unholy_Upgraded"]		 = "Unholy War"
	RATL["TraitRow3_DeathKnight_Unholy_Valorous"]		 = "Herald of Pestilence"
	RATL["TraitRow4_DeathKnight_Unholy_War-torn"]		 = "Faminebearer"
	RATL["TraitRow5_DeathKnight_Unholy_Challenging"]	 = "Death's Deliverance"
	RATL["TraitRow6_DeathKnight_Unholy_Hidden"]		 = "Bone Reaper"

	--Hunter
	RATL["TraitRow1_Hunter_BeastMastery_Classic"]		 = "Titanstrike"
	RATL["TraitRow2_Hunter_BeastMastery_Upgraded"]		 = "Eaglewatch"
	RATL["TraitRow3_Hunter_BeastMastery_Valorous"]		 = "Elekk's Thunder"
	RATL["TraitRow4_Hunter_BeastMastery_War-torn"]		 = "Boarshot Cannon"
	RATL["TraitRow5_Hunter_BeastMastery_Challenging"]	 = "Serpentbite"
	RATL["TraitRow6_Hunter_BeastMastery_Hidden"]		 = "Titan's Reach"

	RATL["TraitRow1_Hunter_Marksmanship_Classic"]		 = "Thas'dorah, Legacy of the Windrunners"
	RATL["TraitRow2_Hunter_Marksmanship_Upgraded"]		 = "A Sister's Bond"
	RATL["TraitRow3_Hunter_Marksmanship_Valorous"]		 = "Phoenix's Rebirth"
	RATL["TraitRow4_Hunter_Marksmanship_War-torn"]		 = "Ranger-General's Guard"
	RATL["TraitRow5_Hunter_Marksmanship_Challenging"]	 = "Wildrunner"
	RATL["TraitRow6_Hunter_Marksmanship_Hidden"]		 = "Ravenguard"

	RATL["TraitRow1_Hunter_Survival_Classic"]			 = "Talonclaw"
	RATL["TraitRow2_Hunter_Survival_Upgraded"]			 = "Eagle's Rebirth"
	RATL["TraitRow3_Hunter_Survival_Valorous"]			 = "Spear of the Alpha"
	RATL["TraitRow4_Hunter_Survival_War-torn"]			 = "Serpentstrike"
	RATL["TraitRow5_Hunter_Survival_Challenging"]		 = "Forests' Guardian"
	RATL["TraitRow6_Hunter_Survival_Hidden"]			 = "Bear's Fortitude"

	--Shaman
	RATL["TraitRow1_Shaman_Elemental_Classic"]			 = "The Fist of Ra-den"
	RATL["TraitRow2_Shaman_Elemental_Upgraded"]		 = "Stormkeeper"
	RATL["TraitRow3_Shaman_Elemental_Valorous"]		 = "Earthspeaker"
	RATL["TraitRow4_Shaman_Elemental_War-torn"]		 = "Fist of the Fallen Shaman"
	RATL["TraitRow5_Shaman_Elemental_Challenging"]		 = "Rehgar's Legacy"
	RATL["TraitRow6_Shaman_Elemental_Hidden"]			 = "Prestige of the Amani"

	RATL["TraitRow1_Shaman_Enhancement_Classic"]		 = "Doomhammer"
	RATL["TraitRow2_Shaman_Enhancement_Upgraded"]		 = "Stormbringer"
	RATL["TraitRow3_Shaman_Enhancement_Valorous"]		 = "Legion's Doom"
	RATL["TraitRow4_Shaman_Enhancement_War-torn"]		 = "Blackhand's Fate"
	RATL["TraitRow5_Shaman_Enhancement_Challenging"]	 = "Typhoon"
	RATL["TraitRow6_Shaman_Enhancement_Hidden"]		 = "Zandalar Champion"

	RATL["TraitRow1_Shaman_Restoration_Classic"]		 = "Sharas'dal, Scepter of Tides"
	RATL["TraitRow2_Shaman_Restoration_Upgraded"]		 = "Scepter of the Deep"
	RATL["TraitRow3_Shaman_Restoration_Valorous"]		 = "Titanborn"
	RATL["TraitRow4_Shaman_Restoration_War-torn"]		 = "Totembearer"
	RATL["TraitRow5_Shaman_Restoration_Challenging"]	 = "Frozen Fate"
	RATL["TraitRow6_Shaman_Restoration_Hidden"]		 = "Serpent's Coil"

	--Druid
	RATL["TraitRow1_Druid_Balance_Classic"]			 = "Scythe of Elune"
	RATL["TraitRow2_Druid_Balance_Upgraded"]			 = "Envoy of Goldrinn"
	RATL["TraitRow3_Druid_Balance_Valorous"]			 = "Lunarcall"
	RATL["TraitRow4_Druid_Balance_War-torn"]			 = "Nightmare's Affliction"
	RATL["TraitRow5_Druid_Balance_Challenging"]		 = "Manascythe"
	RATL["TraitRow6_Druid_Balance_Hidden"]				 = "Sunkeeper's Reach"

	RATL["TraitRow1_Druid_Feral_Classic"]				 = "Fangs of Ashamane"
	RATL["TraitRow2_Druid_Feral_Upgraded"]				 = "Nature's Fury"
	RATL["TraitRow3_Druid_Feral_Valorous"]				 = "Primal Stalker"
	RATL["TraitRow4_Druid_Feral_War-torn"]				 = "Incarnation of Nightmare"
	RATL["TraitRow5_Druid_Feral_Challenging"]			 = "Ghost of the Pridemother"
	RATL["TraitRow6_Druid_Feral_Hidden"]				 = "Moonspirit"

	RATL["TraitRow1_Druid_Guardian_Classic"]			 = "Claws of Ursoc"
	RATL["TraitRow2_Druid_Guardian_Upgraded"]			 = "Stonepaw"
	RATL["TraitRow3_Druid_Guardian_Valorous"]			 = "Avatar of Ursol"
	RATL["TraitRow4_Druid_Guardian_War-torn"]			 = "Fallen to Nightmare"
	RATL["TraitRow5_Druid_Guardian_Challenging"]		 = "Might of the Grizzlemaw"
	RATL["TraitRow6_Druid_Guardian_Hidden"]			 = "Guardian of the Glade"

	RATL["TraitRow1_Druid_Restoration_Classic"]		 = "G'Hanir, the Mother Tree"
	RATL["TraitRow2_Druid_Restoration_Upgraded"]		 = "Eldertree"
	RATL["TraitRow3_Druid_Restoration_Valorous"]		 = "Crystalline Awakening"
	RATL["TraitRow4_Druid_Restoration_War-torn"]		 = "Deadwood Keeper"
	RATL["TraitRow5_Druid_Restoration_Challenging"]	 = "Night's Vigilance"
	RATL["TraitRow6_Druid_Restoration_Hidden"]			 = "Warden's Crown"

	--Rogue
	RATL["TraitRow1_Rogue_Assassination_Classic"]		 = "The Kingslayers"
	RATL["TraitRow2_Rogue_Assassination_Upgraded"]		 = "Cursed Hand"
	RATL["TraitRow3_Rogue_Assassination_Valorous"]		 = "Heartstopper"
	RATL["TraitRow4_Rogue_Assassination_War-torn"]		 = "Magekiller's Edge"
	RATL["TraitRow5_Rogue_Assassination_Challenging"]	 = "Ghostblade"
	RATL["TraitRow6_Rogue_Assassination_Hidden"]		 = "Bonebreaker"

	RATL["TraitRow1_Rogue_Outlaw_Classic"]				 = "The Dreadblades"
	RATL["TraitRow2_Rogue_Outlaw_Upgraded"]			 = "Promise of the Seascourge"
	RATL["TraitRow3_Rogue_Outlaw_Valorous"]			 = "Flame's Kiss"
	RATL["TraitRow4_Rogue_Outlaw_War-torn"]			 = "Scoundrel's Last Word"
	RATL["TraitRow5_Rogue_Outlaw_Challenging"]			 = "Fencer's Reach"
	RATL["TraitRow6_Rogue_Outlaw_Hidden"]				 = "Thunderfury, Hallowed Blade of the Windlord"
	
	RATL["TraitRow1_Rogue_Subtlety_Classic"]			 = "Fangs of the Devourer"
	RATL["TraitRow2_Rogue_Subtlety_Upgraded"]			 = "Shadowblade"
	RATL["TraitRow3_Rogue_Subtlety_Valorous"]			 = "Demon's Embrace"
	RATL["TraitRow4_Rogue_Subtlety_War-torn"]			 = "Bloodfeaster"
	RATL["TraitRow5_Rogue_Subtlety_Challenging"]		 = "Iceshear"
	RATL["TraitRow6_Rogue_Subtlety_Hidden"]			 = "Venombite"

	--Monk
	RATL["TraitRow1_Monk_Brewmaster_Classic"]			 = "Fu Zan, the Wanderer's Companion"
	RATL["TraitRow2_Monk_Brewmaster_Upgraded"]			 = "The Monkey King's Burden"
	RATL["TraitRow3_Monk_Brewmaster_Valorous"]			 = "Heart of the Ox"
	RATL["TraitRow4_Monk_Brewmaster_War-torn"]			 = "Dragonfire's Grasp"
	RATL["TraitRow5_Monk_Brewmaster_Challenging"]		 = "Bearer of the Mist"
	RATL["TraitRow6_Monk_Brewmaster_Hidden"]			 = "Ancient Brewkeeper"

	RATL["TraitRow1_Monk_Mistweaver_Classic"]			 = "Sheilun, Staff of the Mists"
	RATL["TraitRow2_Monk_Mistweaver_Upgraded"]			 = "Toll of the Deep Mist"
	RATL["TraitRow3_Monk_Mistweaver_Valorous"]			 = "Chi-Ji's Spirit"
	RATL["TraitRow4_Monk_Mistweaver_War-torn"]			 = "Sha's Torment"
	RATL["TraitRow5_Monk_Mistweaver_Challenging"]		 = "Essence of Calm"
	RATL["TraitRow6_Monk_Mistweaver_Hidden"]			 = "Breath of the Undying Serpent"

	RATL["TraitRow1_Monk_Windwalker_Classic"]			 = "Fists of the Heavens"
	RATL["TraitRow2_Monk_Windwalker_Upgraded"]			 = "Al'Akir's Touch"
	RATL["TraitRow3_Monk_Windwalker_Valorous"]			 = "Spirit's Reach"
	RATL["TraitRow4_Monk_Windwalker_War-torn"]			 = "Shado-Pan Legacy"
	RATL["TraitRow5_Monk_Windwalker_Challenging"]		 = "Xuen's Enforcer"
	RATL["TraitRow6_Monk_Windwalker_Hidden"]			 = "Stormfist"

	--Warlock
	RATL["TraitRow1_Warlock_Affliction_Classic"]		 = "Deadwind Harvester"
	RATL["TraitRow2_Warlock_Affliction_Upgraded"]		 = "Hand of the Afflicted"
	RATL["TraitRow3_Warlock_Affliction_Valorous"]		 = "Soul Siphon"
	RATL["TraitRow4_Warlock_Affliction_War-torn"]		 = "Death's Hand"
	RATL["TraitRow5_Warlock_Affliction_Challenging"]	 = "Spine of the Condemned"
	RATL["TraitRow6_Warlock_Affliction_Hidden"]		 = "Fate's End"

	RATL["TraitRow1_Warlock_Demonology_Classic"]		 = "Skull of the Man'ari"
	RATL["TraitRow2_Warlock_Demonology_Upgraded"]		 = "Gaze of the First Summoner"
	RATL["TraitRow3_Warlock_Demonology_Valorous"]		 = "Pride of the Pit Lord"
	RATL["TraitRow4_Warlock_Demonology_War-torn"]		 = "Burning Remnant"
	RATL["TraitRow5_Warlock_Demonology_Challenging"]	 = "Soul of the Forgotten"
	RATL["TraitRow6_Warlock_Demonology_Hidden"]		 = "Thal'kiel's Visage"

	RATL["TraitRow1_Warlock_Destruction_Classic"]		 = "Scepter of Sargeras"
	RATL["TraitRow2_Warlock_Destruction_Upgraded"]		 = "Hubris of the Dark Titan"
	RATL["TraitRow3_Warlock_Destruction_Valorous"]		 = "Echo of Gul'dan"
	RATL["TraitRow4_Warlock_Destruction_War-torn"]		 = "Shadow of the Destroyer"
	RATL["TraitRow5_Warlock_Destruction_Challenging"]	 = "Guise of the Darkener"
	RATL["TraitRow6_Warlock_Destruction_Hidden"]		 = "Legionterror"

	--Priest
	RATL["TraitRow1_Priest_Discipline_Classic"]		 = "Light's Wrath"
	RATL["TraitRow2_Priest_Discipline_Upgraded"]		 = "Crest of the Redeemed"
	RATL["TraitRow3_Priest_Discipline_Valorous"]		 = "Chalice of Light"
	RATL["TraitRow4_Priest_Discipline_War-torn"]		 = "Eternal Vigil"
	RATL["TraitRow5_Priest_Discipline_Challenging"]	 = "Ascended Watch"
	RATL["TraitRow6_Priest_Discipline_Hidden"]			 = "Tomekeeper's Spire"

	RATL["TraitRow1_Priest_Holy_Classic"]				 = "T'uure, Beacon of the Naaru"
	RATL["TraitRow2_Priest_Holy_Upgraded"]				 = "Banner of Purity"
	RATL["TraitRow3_Priest_Holy_Valorous"]				 = "Keeper of Light"
	RATL["TraitRow4_Priest_Holy_War-torn"]				 = "Embrace of the Void"
	RATL["TraitRow5_Priest_Holy_Challenging"]			 = "Memory of Argus"
	RATL["TraitRow6_Priest_Holy_Hidden"]				 = "Crest of the Lightborn"

	RATL["TraitRow1_Priest_Shadow_Classic"]			 = "Blade of the Black Empire"
	RATL["TraitRow2_Priest_Shadow_Upgraded"]			 = "Embrace of the Old Gods"
	RATL["TraitRow3_Priest_Shadow_Valorous"]			 = "The Fallen Blade"
	RATL["TraitRow4_Priest_Shadow_War-torn"]			 = "Vision of Madness"
	RATL["TraitRow5_Priest_Shadow_Challenging"]		 = "Twisted Reflection"
	RATL["TraitRow6_Priest_Shadow_Hidden"]				 = "Claw of N'Zoth"

	--Mage
	RATL["TraitRow1_Mage_Arcane_Classic"]				 = "Aluneth"
	RATL["TraitRow2_Mage_Arcane_Upgraded"]				 = "Guardian Spire"
	RATL["TraitRow3_Mage_Arcane_Valorous"]				 = "Magna Unleashed"
	RATL["TraitRow4_Mage_Arcane_War-torn"]				 = "Aegwynn's Fall"
	RATL["TraitRow5_Mage_Arcane_Challenging"]			 = "Eternal Magus"
	RATL["TraitRow6_Mage_Arcane_Hidden"]				 = "Woolomancer's Charge"

	RATL["TraitRow1_Mage_Fire_Classic"]				 = "Felo'melorn"
	RATL["TraitRow2_Mage_Fire_Upgraded"]				 = "Pride of the Sunstriders"
	RATL["TraitRow3_Mage_Fire_Valorous"]				 = "Phoenix's Rebirth"
	RATL["TraitRow4_Mage_Fire_War-torn"]				 = "Lavaborn Edge"
	RATL["TraitRow5_Mage_Fire_Challenging"]			 = "Timebender's Blade"
	RATL["TraitRow6_Mage_Fire_Hidden"]					 = "The Stars' Design"

	RATL["TraitRow1_Mage_Frost_Classic"]				 = "Ebonchill"
	RATL["TraitRow2_Mage_Frost_Upgraded"]				 = "Guardian's Focus"
	RATL["TraitRow3_Mage_Frost_Valorous"]				 = "Flow of the First"
	RATL["TraitRow4_Mage_Frost_War-torn"]				 = "Archmagi's Will"
	RATL["TraitRow5_Mage_Frost_Challenging"]			 = "Elite Magus"
	RATL["TraitRow6_Mage_Frost_Hidden"]				 = "Frostfire Remembrance"
 end

rat.AppSwatchData = {
	-- Paladin
	[242555] = { -- Retribution
		itemID = 120978,
		appearances = {
			[1] = { -- Classic
				-- camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, }, -- default settings
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 10,	color = 12207429,	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 9,	color = 13946667,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 2777830,	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 7194424,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 5.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 14,	color = 14170168,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = 13753664,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = 4341749,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = 2400311,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 17,	color = 15636775,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 26,	color = -16753230,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 27,	color = -7941557,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 28,	color = -203,		tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 18,	color = 9769406,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 19,	color = 5384685,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = 46171,		tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 21,	color = 2918886,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 24,	color = 4385004,	tooltip = RATL["TraitRow5Tint1Req_GQC"],	req = { quests = {45526}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 23,	color = 16250871,	tooltip = RATL["TraitRow5Tint2Req_GQC"],	req = { quests = {45526}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 22,	color = 15526961,	tooltip = RATL["TraitRow5Tint3Req_GQC"],	req = { quests = {45526}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 25,	color = 5054922,	tooltip = RATL["TraitRow5Tint4Req_GQC"],	req = { quests = {45526}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 29,	color = -14423239,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43666} }, },
					{ modifiedID = 30,	color = -7197721,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 31,	color = -1367775,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 32,	color = -1577950,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	[242571] = { -- Holy
		itemID = 128823,
		secondary = 128824, -- dummy offhand item
		appearances = {
			[1] = { -- Classic
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 2, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = 5*math.pi / 6, pitch = 0, },
				tints = {
					{ modifiedID = 9,	color = 16120349,	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 1959674,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 9584105,	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 16257561,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 2, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = 5*math.pi / 6, pitch = 0, },
				tints = {
					{ modifiedID = 16,	color = -656866,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = 46079,		tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = 9253870,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = -2352602,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 2, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = 5*math.pi / 6, pitch = 0, },
				tints = {
					{ modifiedID = 21,	color = 3324917,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 24,	color = -8124,	 	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 22,	color = -6081340,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 23,	color = -4443328,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 2, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = 5*math.pi / 6, pitch = 0, },
				tints = {
					{ modifiedID = 25,	color = 46079,		tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 26,	color = 3404714,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 27,	color = 8207285,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 28,	color = 13312069,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 2, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = 5*math.pi / 6, pitch = 0, },
				tints = {
					{ modifiedID = 19,	color = -2734822,	tooltip = RATL["TraitRow5Tint1Req_TBRT"],	req = { quests = {46035}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 18,	color = 8923843,	tooltip = RATL["TraitRow5Tint2Req_TBRT"],	req = { quests = {46035}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 17,	color = 46079,		tooltip = RATL["TraitRow5Tint3Req_TBRT"],	req = { quests = {46035}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 20,	color = -12652954,	tooltip = RATL["TraitRow5Tint4Req_TBRT"],	req = { quests = {46035}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 2, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = 5*math.pi / 6, pitch = 0, },
				tints = {
					{ modifiedID = 29,	color = 15582755,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43664} }, },
					{ modifiedID = 30,	color = 15857826,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 31,	color = 8724213,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 32,	color = 15990784,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Paladin
	[242583] = { -- Protection
		itemID = 128866,
		secondary = 128867,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = 3*math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = -12849686,	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = -2722739,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = -7721028,	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = -160,		tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = 3*math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 13,	color = -7078146,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = -1684683,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = -1776583,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = -197404,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = 3*math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 32,	color = -2102506,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 30,	color = -14840534,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 31,	color = -2608076,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 29,	color = -13023499,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = 3*math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 18,	color = -13307997,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 17,	color = -14079515,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 19,	color = -3200705,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = -1249462,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = 3*math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 24,	color = -927427,	tooltip = RATL["TraitRow5Tint1Req_THR"],	req = { quests = {45416}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 22,	color = -6473020,	tooltip = RATL["TraitRow5Tint2Req_THR"],	req = { quests = {45416}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 23,	color = -2014423,	tooltip = RATL["TraitRow5Tint3Req_THR"],	req = { quests = {45416}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 21,	color = -12944144,	tooltip = RATL["TraitRow5Tint4Req_THR"],	req = { quests = {45416}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 26,	color = -6146097,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43665} }, },
					{ modifiedID = 25,	color = -9641147,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 27,	color = -3729643,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 28,	color = -8892,		tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},


	-- Demon Hunter
	[242556] = { -- Havoc
		itemID = 127829,
		secondary = 127830,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 10,	color = 6870528,	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 9,	color = 3666175,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 9845974,	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 15477542,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 14,	color = 9627184,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = 4433378,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = 9980106,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = 14958913,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 20,	color = 16064287,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 18,	color = 9231422,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 19,	color = 10767320,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 17,	color = 8200995,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 3.7, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 27,	color = 7223739,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 26,	color = 3657332,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 25,	color = 4626395,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 28,	color = 15857465,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 23,	color = 15311409,	tooltip = RATL["TraitRow5Tint1Req_XC"],	req = { quests = {44925}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 22,	color = 11200571,	tooltip = RATL["TraitRow5Tint2Req_XC"],	req = { quests = {44925}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 21,	color = 13127224,	tooltip = RATL["TraitRow5Tint3Req_XC"],	req = { quests = {44925}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 24,	color = 12598501,	tooltip = RATL["TraitRow5Tint4Req_XC"],	req = { quests = {44925}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 30,	color = 12313145,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43649} }, },
					{ modifiedID = 29,	color = 3595433,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 31,	color = 10438369,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 32,	color = 15485771,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Demon Hunter
	[242577] = { -- Vengeance
		itemID = 128832,
		secondary = 128831,
		appearances = {
			[1] = { -- Classic
				tints = {
					{ modifiedID = 9,	color = 16765254, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 4619282,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 7801775, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 11776947,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				tints = {
					{ modifiedID = 14,	color = -2396893,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = -11213384,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = -13835203,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = -4512805,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				tints = {
					{ modifiedID = 18,	color = -7998908,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 17,	color = -12913687,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 19,	color = -2606084,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = -2475488,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				tints = {
					{ modifiedID = 22,	color = -1652091,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 21,	color = -7432515,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 23,	color = -10123675,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = -9808299,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				tints = {
					{ modifiedID = 29,	color = -3030212,	tooltip = RATL["TraitRow5Tint1Req_THR"],	req = { quests = {45416}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 30,	color = -7612101,	tooltip = RATL["TraitRow5Tint2Req_THR"],	req = { quests = {45416}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 31,	color = -5982477,	tooltip = RATL["TraitRow5Tint3Req_THR"],	req = { quests = {45416}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 32,	color = -6252392,	tooltip = RATL["TraitRow5Tint4Req_THR"],	req = { quests = {45416}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				tints = {
					{ modifiedID = 26,	color = -7812810,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43650} }, },
					{ modifiedID = 25,	color = -13123135,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 27,	color = -8641594,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 28,	color = -1692130,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},

	-- Druid
	[242561] = { -- Restoration
		itemID = 128306,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = -12527023, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 14759167,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = -14496857, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = -131226,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 13,	color = -12858266,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = -8716125,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = -9044232,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = -1443782,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 18,	color = -2621457,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 17,	color = -5955107,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 19,	color = 42719,		tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = 2621373,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 22,	color = 7995557,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 21,	color = 1834826,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 23,	color = 12910592,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = -12486401,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 31,	color = -6920642,	tooltip = RATL["TraitRow5Tint1Req_TBRT"],	req = { quests = {46035}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 30,	color = 3687024,	tooltip = RATL["TraitRow5Tint2Req_TBRT"],	req = { quests = {46035}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 29,	color = -9077053,	tooltip = RATL["TraitRow5Tint3Req_TBRT"],	req = { quests = {46035}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 32,	color = -1583684,	tooltip = RATL["TraitRow5Tint4Req_TBRT"],	req = { quests = {46035}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 26,	color = -10008885,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43654} }, },
					{ modifiedID = 25,	color = 3800902,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 27,	color = 13369344,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 28,	color = -13534254,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Druid
	[242580] = { -- Feral (these appearances are based on shapeshift, so something else will have to be devised later)
		itemID = 128860, -- gets overwritten by displayID
		secondary = 128860,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .5, facing = 7*math.pi / 4, pitch = 0, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = .75, },
				animation = 0,
				tints = {
					{ displayID = 66779,	modifiedID = 9,		color = 4112989, 	tooltip = RATL["TraitRow1Tint1Req"]..RATL["RaceGroup3"],	req = { quests = {}, achievements = {} },	raceIDs = {8, 31} }, -- Troll, Zandalari Troll
					{ displayID = 66777,	modifiedID = 9,		color = 10319436,	tooltip = RATL["TraitRow1Tint1Req"]..RATL["RaceGroup2"],	req = { quests = {}, achievements = {} },	raceIDs = {6, 28} }, -- Tauren, HM Tauren
					{ displayID = 66778,	modifiedID = 9,		color = 14274424, 	tooltip = RATL["TraitRow1Tint1Req"]..RATL["RaceGroup4"],	req = { quests = {}, achievements = {} },	raceIDs = {23, 22, 32} }, -- Gilnean, Worgen, Kul Tiran
					{ displayID = 66780,	modifiedID = 9,		color = 9321405,	tooltip = RATL["TraitRow1Tint1Req"]..RATL["RaceGroup1"],	req = { quests = {}, achievements = {} },	raceIDs = {4, 86} }, -- Night Elf, Haranir
					{ displayID = 66775,	modifiedID = 10,	color = 5052011,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ displayID = 66776,	modifiedID = 11,	color = 2983883,	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ displayID = 66781,	modifiedID = 12,	color = 13822955,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .5, facing = 7*math.pi / 4, pitch = 0, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = .75, },
				animation = 0,
				tints = {
					{ displayID = 66787,	modifiedID = 13,	color = 13465931,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ displayID = 66786,	modifiedID = 14,	color = 2876068,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ displayID = 66788,	modifiedID = 15,	color = 15580434,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ displayID = 66789,	modifiedID = 16,	color = 14161390,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .5, facing = 7*math.pi / 4, pitch = 0, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = .75, },
				animation = 0,
				tints = {
					{ displayID = 66790,	modifiedID = 17,	color = 2352725,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ displayID = 66791,	modifiedID = 18,	color = 15581735,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ displayID = 66792,	modifiedID = 19,	color = 9779671,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ displayID = 66793,	modifiedID = 20,	color = 8517880,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .5, facing = 7*math.pi / 4, pitch = 0, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = .75, },
				animation = 0,
				tints = {
					{ displayID = 66794,	modifiedID = 21,	color = 9057236,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ displayID = 66795,	modifiedID = 22,	color = 3332826,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ displayID = 66796,	modifiedID = 23,	color = 14362155,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ displayID = 66797,	modifiedID = 24,	color = 13184910,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .5, facing = 7*math.pi / 4, pitch = 0, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = .75, },
				animation = 0,
				tints = {
					{ displayID = 66782,	modifiedID = 25,	color = 3653887,	tooltip = RATL["TraitRow5Tint1Req_IMC"],	req = { quests = {46065}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ displayID = 66783,	modifiedID = 26,	color = 10354500,	tooltip = RATL["TraitRow5Tint2Req_IMC"],	req = { quests = {46065}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ displayID = 66784,	modifiedID = 27,	color = 14953215,	tooltip = RATL["TraitRow5Tint3Req_IMC"],	req = { quests = {46065}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ displayID = 66785,	modifiedID = 28,	color = 16587541,	tooltip = RATL["TraitRow5Tint4Req_IMC"],	req = { quests = {46065}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .5, facing = 7*math.pi / 4, pitch = 0, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = .75, },
				animation = 0,
				tints = {
					{ displayID = 69834,	modifiedID = 29,	color = 9460011,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43652} }, },
					{ displayID = 69835,	modifiedID = 30,	color = 0,			tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ displayID = 69833,	modifiedID = 31,	color = 14804457,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ displayID = 69832,	modifiedID = 32,	color = 5590868,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Druid
	[242569] = { -- Guardian (these appearances are based on shapeshift, so something else will have to be devised later)
		itemID = 128821,
		secondary = 128821,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .7, facing = 7*math.pi / 4, pitch = 0, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi/2, pitch = .75, },
				tints = {
					{ displayID = 66686,	modifiedID = 9,		color = 7878111, 	tooltip = RATL["TraitRow1Tint1Req"]..RATL["RaceGroup1"],	req = { quests = {}, achievements = {} }, raceIDs = {4, 86} }, -- Night Elf, Haranir
					{ displayID = 66693,	modifiedID = 9,		color = 6233864, 	tooltip = RATL["TraitRow1Tint1Req"]..RATL["RaceGroup2"],	req = { quests = {}, achievements = {} }, raceIDs = {6, 28} }, -- Tauren, HM Tauren
					{ displayID = 66683,	modifiedID = 9,		color = 4840150, 	tooltip = RATL["TraitRow1Tint1Req"]..RATL["RaceGroup3"],	req = { quests = {}, achievements = {} }, raceIDs = {8, 31} }, -- Troll, Zandalari Troll
					{ displayID = 66685,	modifiedID = 9,		color = 12137809, 	tooltip = RATL["TraitRow1Tint1Req"]..RATL["RaceGroup4"],	req = { quests = {}, achievements = {} }, raceIDs = {23, 22, 32} }, -- Gilnean, Worgen, Kul Tiran
					{ displayID = 66687,	modifiedID = 10,	color = 13541153,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ displayID = 66688,	modifiedID = 11,	color = 14079702, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ displayID = 66682,	modifiedID = 12,	color = 1525299,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .7, facing = 7*math.pi / 4, pitch = 0, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi/2, pitch = .75, },
				tints = {
					{ displayID = 66697,	modifiedID = 13,	color = 5992620,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ displayID = 66696,	modifiedID = 14,	color = 5675392,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ displayID = 66698,	modifiedID = 15,	color = 5029219,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ displayID = 66699,	modifiedID = 16,	color = 14042838,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .7, facing = 7*math.pi / 4, pitch = 0, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi/2, pitch = .75, },
				tints = {
					{ displayID = 66705,	modifiedID = 17,	color = 7926557,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ displayID = 66704,	modifiedID = 18,	color = 3064568,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ displayID = 66706,	modifiedID = 19,	color = 12071158,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ displayID = 66707,	modifiedID = 20,	color = 16189962,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .7, facing = 7*math.pi / 4, pitch = 0, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi/2, pitch = .75, },
				tints = {
					{ displayID = 66719,	modifiedID = 21,	color = 4646628,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ displayID = 66718,	modifiedID = 22,	color = 16094250,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ displayID = 66717,	modifiedID = 23,	color = 4511604,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ displayID = 66716,	modifiedID = 24,	color = 15737376,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 7, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 1.2, facing = 7*math.pi / 4, pitch = 0, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi/2, pitch = .75, },
				tints = {
					{ displayID = 74269,	modifiedID = 25,	color = 16645629,	tooltip = RATL["TraitRow5Tint1Req_THR"],	req = { quests = {45416}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ displayID = 74270,	modifiedID = 26,	color = 11701531,	tooltip = RATL["TraitRow5Tint2Req_THR"],	req = { quests = {45416}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ displayID = 74271,	modifiedID = 27,	color = 4602940,	tooltip = RATL["TraitRow5Tint3Req_THR"],	req = { quests = {45416}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ displayID = 74272,	modifiedID = 28,	color = 8874265,	tooltip = RATL["TraitRow5Tint4Req_THR"],	req = { quests = {45416}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .7, facing = 7*math.pi / 4, pitch = 0, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi/2, pitch = .75, },
				tints = {
					{ displayID = 66721,	modifiedID = 29,	color = 8346917,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43653} }, },
					{ displayID = 66720,	modifiedID = 30,	color = 4948674,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ displayID = 66722,	modifiedID = 31,	color = 14826299,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ displayID = 66723,	modifiedID = 32,	color = 16777215,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Druid
	[242578] = { -- Balance
		itemID = 128858,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 4.8, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = -12526923, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = -8459948,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = -5941542, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = -1721312,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 4.8, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 13,	color = -12526909,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = -12527023,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = -6666286,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = -282090,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 4.8, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 20,	color = -1,			tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 18,	color = -12527023,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 19,	color = -6603316,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 17,	color = -13326639,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 4.8, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 23,	color = -32382,		tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 22,	color = -524416,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 21,	color = -12526894,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = -2909614,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 4.8, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 29,	color = -2549276,	tooltip = RATL["TraitRow5Tint1Req_TC"],	req = { quests = {46127}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 30,	color = -970190,	tooltip = RATL["TraitRow5Tint2Req_TC"],	req = { quests = {46127}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 31,	color = -6225921,	tooltip = RATL["TraitRow5Tint3Req_TC"],	req = { quests = {46127}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 32,	color = -1456592,	tooltip = RATL["TraitRow5Tint4Req_TC"],	req = { quests = {46127}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 4.8, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 28,	color = -664011,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43651} }, },
					{ modifiedID = 26,	color = -4037147,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 27,	color = -1621953,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 25,	color = -11569184,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},

	-- Warrior
	[237749] = { -- Protection
		itemID = 128289,
		secondary = 128288,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = 3*math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 12,	color = 13256731, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 6542710,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 9,	color = 3635402, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 11,	color = 9056925,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = 3*math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 4.7, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 16,	color = 10822946,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = 13153068,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = 2588395,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = 12330987,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 28,	color = 16314894,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 26,	color = 2616127,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 25,	color = 2588395,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 27,	color = 8265410,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 18,	color = 4577901,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 17,	color = 5011930,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 19,	color = 10629571,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = 15410986,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 29,	color = 15568151,	tooltip = RATL["TraitRow5Tint1Req_THR"],	req = { quests = {45416}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 30,	color = 3507690,	tooltip = RATL["TraitRow5Tint2Req_THR"],	req = { quests = {45416}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 31,	color = 4778037,	tooltip = RATL["TraitRow5Tint3Req_THR"],	req = { quests = {45416}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 32,	color = 14884382,	tooltip = RATL["TraitRow5Tint4Req_THR"],	req = { quests = {45416}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 23,	color = 15378707,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43681} }, },
					{ modifiedID = 21,	color = 4626147,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 22,	color = 8975941,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 24,	color = 11216875,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Warrior
	[236772] = { -- Arms
		itemID = 128910,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = -15823458, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = -7150773,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = -9162650, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = -4967641,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 13,	color = -14434121,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = -15532254,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = -8838011,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = -4910587,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 24,	color = -3510016,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 22,	color = -933326,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 23,	color = -3137509,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 21,	color = -7871957,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 18,	color = -11887068,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 17,	color = -16399122,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 19,	color = -3191821,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = -1067224,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 25,	color = -11604033,	tooltip = RATL["TraitRow5Tint1Req_XC"],	req = { quests = {44925}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 26,	color = -9573303,	tooltip = RATL["TraitRow5Tint2Req_XC"],	req = { quests = {44925}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 27,	color = -8703020,	tooltip = RATL["TraitRow5Tint3Req_XC"],	req = { quests = {44925}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 28,	color = -1327329,	tooltip = RATL["TraitRow5Tint4Req_XC"],	req = { quests = {44925}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 32,	color = -912107,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43679} }, },
					{ modifiedID = 30,	color = -801193,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 31,	color = -8393915,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 29,	color = -8446177,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Warrior
	[237746] = { -- Fury
		itemID = 128908,
		secondary = 134553,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = -16354, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = -2280887,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = -7854972, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = -12471975,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 13,	color = -16354,		tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = -1302013,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = -7857532,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = -15484360,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 25,	color = -2238150,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 26,	color = -14367683,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 27,	color = -5692496,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 28,	color = -7134908,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 17,	color = -13054222,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 18,	color = -13969592,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 19,	color = -285430,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = -5367786,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 5.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 21,	color = -10961472,	tooltip = RATL["TraitRow5Tint1Req_IMC"],	req = { quests = {46065}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 22,	color = -12996050,	tooltip = RATL["TraitRow5Tint2Req_IMC"],	req = { quests = {46065}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 23,	color = -6209335,	tooltip = RATL["TraitRow5Tint3Req_IMC"],	req = { quests = {46065}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 24,	color = -7261642,	tooltip = RATL["TraitRow5Tint4Req_IMC"],	req = { quests = {46065}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 32,	color = -593911,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43680} }, },
					{ modifiedID = 30,	color = -947406,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 29,	color = -13455920,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 31,	color = -908952,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},

	-- Rogue
	[242564] = { -- Subtlety
		itemID = 128476,
		secondary = 128479,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 8187704, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 4099302,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 7359174, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 3857118,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				tints = {
					{ modifiedID = 19,	color = 7749083,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 18,	color = 4287200,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 17,	color = 7266609,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 20,	color = 3989733,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 13,	color = 8708667,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 14,	color = 4647141,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 15,	color = 8009433,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 16,	color = 15199526,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				tints = {
					{ modifiedID = 23,	color = 15277084,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 22,	color = 5577646,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 21,	color = 2152008,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = 3117446,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				tints = {
					{ modifiedID = 26,	color = 8037362,	tooltip = RATL["TraitRow5Tint1Req_XC"],	req = { quests = {44925}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 25,	color = 4780008,	tooltip = RATL["TraitRow5Tint2Req_XC"],	req = { quests = {44925}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 27,	color = 8207315,	tooltip = RATL["TraitRow5Tint3Req_XC"],	req = { quests = {44925}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 28,	color = 15332339,	tooltip = RATL["TraitRow5Tint4Req_XC"],	req = { quests = {44925}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 31,	color = 15237920,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43672} }, },
					{ modifiedID = 30,	color = 7068985,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 29,	color = 3399656,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 32,	color = 15470865,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Rogue
	[242587] = { -- Assassination
		itemID = 128870,
		secondary = 128869,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 2.7, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 10,	color = 16711680, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 9,	color = 7280536,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 5368054, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 16776960,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -0.1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 15,	color = 16711680,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = 10433269,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = 16107805,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = 4320243,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -0.1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 18,	color = 65280,		tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 17,	color = 255,		tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 19,	color = 16711680,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = 4127224,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 3.2, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -0.1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 22,	color = 16036875,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 21,	color = 255,		tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 23,	color = 4913390,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = 16776960,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 29,	color = 11070454,	tooltip = RATL["TraitRow5Tint1Req_GQC"],	req = { quests = {45526}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 30,	color = 9890629,	tooltip = RATL["TraitRow5Tint2Req_GQC"],	req = { quests = {45526}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 31,	color = 10375915,	tooltip = RATL["TraitRow5Tint3Req_GQC"],	req = { quests = {45526}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 32,	color = 15080733,	tooltip = RATL["TraitRow5Tint4Req_GQC"],	req = { quests = {45526}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 3.2, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -0.1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 27,	color = 4252894,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43670} }, },
					{ modifiedID = 26,	color = 15671585,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 25,	color = 4153830,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 28,	color = 15724561,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Rogue
	[242588] = { -- Outlaw
		itemID = 128872,
		secondary = 134552,
		appearances = {
			[1] = { -- Classic
				tints = {
					{ modifiedID = 9,	color = -5371382, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = -11782950,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = -8186187, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = -4289730,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				tints = {
					{ modifiedID = 15,	color = -14279134,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = -9815124,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = -1465295,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = -7237265,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				tints = {
					{ modifiedID = 22,	color = -1794761,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 21,	color = -11766293,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 23,	color = -11670549,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = -722965,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				tints = {
					{ modifiedID = 26,	color = -6365130,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 25,	color = -12557083,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 27,	color = -647927,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 28,	color = -13964577,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 19,	color = -949116,	tooltip = RATL["TraitRow5Tint1Req_IMC"],	req = { quests = {46065}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 18,	color = -7579710,	tooltip = RATL["TraitRow5Tint2Req_IMC"],	req = { quests = {46065}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 17,	color = -12889880,	tooltip = RATL["TraitRow5Tint3Req_IMC"],	req = { quests = {46065}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 20,	color = -1247714,	tooltip = RATL["TraitRow5Tint4Req_IMC"],	req = { quests = {46065}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 29,	color = -12876564,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43671} }, },
					{ modifiedID = 30,	color = -12197728,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 31,	color = -1726161,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 32,	color = -7522082,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},


	-- Death Knight
	[242562] = { -- Blood
		itemID = 128402,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 16723502, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 12390339,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 9370663, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 3793407,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 13,	color = 16717848,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = 13763805,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = 9502534,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = 3070207,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 23,	color = 16730549,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 22,	color = 3866564,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 21,	color = 4313599,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = 14482943,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 25,	color = -10290945,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 26,	color = -7602357,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 27,	color = -2014465,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 28,	color = -61,		tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 18,	color = 16715535,	tooltip = RATL["TraitRow5Tint1Req_THR"],	req = { quests = {45416}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 17,	color = 10223425,	tooltip = RATL["TraitRow5Tint2Req_THR"],	req = { quests = {45416}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 19,	color = 3669950,	tooltip = RATL["TraitRow5Tint3Req_THR"],	req = { quests = {45416}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 20,	color = 14876159,	tooltip = RATL["TraitRow5Tint4Req_THR"],	req = { quests = {45416}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 29,	color = -12721948,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43646} }, },
					{ modifiedID = 30,	color = -8591536,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 31,	color = -9487678,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 32,	color = -2274742,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Death Knight
	[242563] = { -- Unholy
		itemID = 128403,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 3138349, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 2941171,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 11678188, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 15554105,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 14,	color = 5565489,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = 3254508,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = 16730401,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = 16777215,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 24,	color = 15723566,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 22,	color = 16736568,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 23,	color = 3538903,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 21,	color = 3199231,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 19,	color = 16752945,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 18,	color = 7859249,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = 15220778,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 17,	color = 5165052,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 31,	color = 15346986,	tooltip = RATL["TraitRow5Tint1Req_IMC"],	req = { quests = {46065}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 30,	color = 9955666,	tooltip = RATL["TraitRow5Tint2Req_IMC"],	req = { quests = {46065}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 29,	color = 4233163,	tooltip = RATL["TraitRow5Tint3Req_IMC"],	req = { quests = {46065}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 32,	color = 15592754,	tooltip = RATL["TraitRow5Tint4Req_IMC"],	req = { quests = {46065}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 26,	color = 9318892,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43648} }, },
					{ modifiedID = 25,	color = 3256556,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 27,	color = 16342826,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 28,	color = 2359283,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Death Knight
	[242559] = { -- Frost
		itemID = 128292,
		secondary = 128293,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 3256556, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 189775,		tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 15516721, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 3271908,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 13,	color = 5884671,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = 3271788,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = 16425258,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = 3269100,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 17,	color = 3256556,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 18,	color = 3140633,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 19,	color = 16756275,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = 16182072,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 25,	color = 3256556,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 26,	color = 3271758,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 27,	color = 12923372,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 28,	color = 16758311,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 22,	color = 3997653,	tooltip = RATL["TraitRow5Tint1Req_XC"],	req = { quests = {44925}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 21,	color = 3256556,	tooltip = RATL["TraitRow5Tint2Req_XC"],	req = { quests = {44925}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 23,	color = 12726271,	tooltip = RATL["TraitRow5Tint3Req_XC"],	req = { quests = {44925}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 24,	color = 15482929,	tooltip = RATL["TraitRow5Tint4Req_XC"],	req = { quests = {44925}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 30,	color = 11005024,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43647} }, },
					{ modifiedID = 29,	color = 5632492,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 31,	color = 10506186,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 32,	color = 14303810,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},

	-- Shaman
	[242593] = { -- Elemental
		itemID = 128935,
		secondary = 128936,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 2.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 2, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 5682687, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = -44545,		tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = -1, 		tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = -128,		tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 2.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 2, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 13,	color = -16515073,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = -14155830,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = -6126520,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = -217,		tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 2.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 2, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 19,	color = -628222,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 18,	color = -11288576,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 17,	color = -16089158,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = -8687122,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 2, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 27,	color = -8628494,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 26,	color = -8323250,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 25,	color = -13648403,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 28,	color = -573127,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 2, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 21,	color = -10892545,	tooltip = RATL["TraitRow5Tint1Req_IMC"],	req = { quests = {46065}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 22,	color = -14876673,	tooltip = RATL["TraitRow5Tint2Req_IMC"],	req = { quests = {46065}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 23,	color = -40356,		tooltip = RATL["TraitRow5Tint3Req_IMC"],	req = { quests = {46065}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 24,	color = -160,		tooltip = RATL["TraitRow5Tint4Req_IMC"],	req = { quests = {46065}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 32,	color = -14095125,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43673} }, },
					{ modifiedID = 30,	color = -6687949,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 31,	color = -616140,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 29,	color = -13155356,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Shaman
	[242591] = { -- Restoration
		itemID = 128911,
		secondary = 128934,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.1, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = -14700624, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = -8395722,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = -2448068, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = -11788838,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.1, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 13,	color = -12862549,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = -10438095,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = -11197228,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = -2111655,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 19,	color = -1052887,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 18,	color = -12259786,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 17,	color = -9572366,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = -3072213,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 23,	color = -12287533,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 22,	color = -1141728,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 21,	color = -8920007,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = -2634730,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 25,	color = -13583893,	tooltip = RATL["TraitRow5Tint1Req_TBRT"],	req = { quests = {46035}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 26,	color = -9633860,	tooltip = RATL["TraitRow5Tint2Req_TBRT"],	req = { quests = {46035}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 27,	color = -1684917,	tooltip = RATL["TraitRow5Tint3Req_TBRT"],	req = { quests = {46035}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 28,	color = -1727978,	tooltip = RATL["TraitRow5Tint4Req_TBRT"],	req = { quests = {46035}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 30,	color = -11741379,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43675} }, },
					{ modifiedID = 29,	color = -13091353,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 31,	color = -6999868,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 32,	color = -3002834,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Shaman
	[242567] = { -- Enhancement
		itemID = 128819,
		secondary = 128873,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 11190488, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 9511943,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 16769633, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 14844592,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 13,	color = 8052479,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = 16768861,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = 5963633,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = 16738109,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 22,	color = 9895754,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 21,	color = 4456425,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 23,	color = 16762196,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = 13648383,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 17,	color = 16745493,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 18,	color = 4259817,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 19,	color = 3075386,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = 16726646,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 25,	color = 5042943,	tooltip = RATL["TraitRow5Tint1Req_GQC"],	req = { quests = {45526}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 26,	color = -9069901,	tooltip = RATL["TraitRow5Tint2Req_GQC"],	req = { quests = {45526}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 27,	color = 2621326,	tooltip = RATL["TraitRow5Tint3Req_GQC"],	req = { quests = {45526}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 28,	color = 13168634,	tooltip = RATL["TraitRow5Tint4Req_GQC"],	req = { quests = {45526}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 32,	color = 3271909,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43674} }, },
					{ modifiedID = 30,	color = 15433770,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 31,	color = 8533229,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 29,	color = 4488680,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},

	-- Hunter
	[246013] = { -- Marksmanship --246013 or 242574
		itemID = 128826,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 4186327, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 7140935,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 4496584, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 13916219,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 24,	color = -7579995,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 22,	color = 4957916,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 23,	color = 13382965,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 21,	color = 11641009,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = 3*math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 20,	color = 14726704,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 18,	color = 9103712,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 19,	color = 9189825,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 17,	color = 4251876,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 16,	color = 7868432,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 13,	color = 4964577,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 15,	color = 14631490,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 14,	color = 14282300,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 3.7, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 29,	color = 3260727,	tooltip = RATL["TraitRow5Tint1Req_TC"],	req = { quests = {46127}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 30,	color = 14830773,	tooltip = RATL["TraitRow5Tint2Req_TC"],	req = { quests = {46127}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 31,	color = 5148636,	tooltip = RATL["TraitRow5Tint3Req_TC"],	req = { quests = {46127}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 32,	color = 14377273,	tooltip = RATL["TraitRow5Tint4Req_TC"],	req = { quests = {46127}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = 5*math.pi/4, pitch = -0.75, },
				tints = {
					{ modifiedID = 25,	color = 2459070,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43656} }, },
					{ modifiedID = 26,	color = 10483279,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 27,	color = 15539999,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 28,	color = 3204308,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Hunter
	[242566] = { -- Survival
		itemID = 128808,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 15876397, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 12470239,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 3335367, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 14018379,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 15,	color = 14699836,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = 7488970,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = -16711681,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = 9040429,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 19,	color = 15876397,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 18,	color = 3063335,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 17,	color = 3094245,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = 3007454,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 21,	color = 3468770,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 22,	color = 8183624,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 23,	color = 4149992,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = 15876397,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 29,	color = 2412074,	tooltip = RATL["TraitRow5Tint1Req_XC"],	req = { quests = {44925}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 30,	color = 13849839,	tooltip = RATL["TraitRow5Tint2Req_XC"],	req = { quests = {44925}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 31,	color = 6563771,	tooltip = RATL["TraitRow5Tint3Req_XC"],	req = { quests = {44925}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 32,	color = 15507519,	tooltip = RATL["TraitRow5Tint4Req_XC"],	req = { quests = {44925}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 25,	color = 14512207,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43657} }, },
					{ modifiedID = 26,	color = 12749187,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 27,	color = 10895581,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 28,	color = 15614997,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Hunter
	[242581] = { -- Beast Mastery
		itemID = 128861,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 3176653, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 9981390,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 13972532, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 14542138,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 13,	color = 5998826,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = 13251538,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = 15287107,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = 10939987,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 23,	color = 10304702,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 22,	color = 7138880,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 21,	color = 4907719,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = 15397434,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 20,	color = 14410551,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 18,	color = 3272816,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 19,	color = 14959941,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 17,	color = 3986919,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 28,	color = 14235190,	tooltip = RATL["TraitRow5Tint1Req_TFWM"],	req = { quests = {45627}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 27,	color = 9257932,	tooltip = RATL["TraitRow5Tint2Req_TFWM"],	req = { quests = {45627}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 25,	color = 4039121,	tooltip = RATL["TraitRow5Tint3Req_TFWM"],	req = { quests = {45627}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 26,	color = 8967744,	tooltip = RATL["TraitRow5Tint4Req_TFWM"],	req = { quests = {45627}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = 3*math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 30,	color = 15906095,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43655} },  },
					{ modifiedID = 29,	color = 3647438,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 31,	color = 13772326,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 32,	color = 7293000,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},

	-- Priest
	[242573] = { -- Holy
		itemID = 128825,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 4.9, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 2267886, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = -10581453,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = -8181081, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = -2150877,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 4.9, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 13,	color = -14642254,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = -6795078,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = -8513998,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = -2031828,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 4.9, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 18,	color = -1059740,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 17,	color = -6762780,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 19,	color = -8957506,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = -41117,		tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 4.9, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 28,	color = -7063326,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 26,	color = -2324181,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 27,	color = -14919093,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 25,	color = -4256744,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 5.2, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 23,	color = -16735511,	tooltip = RATL["TraitRow5Tint1Req_TBRT"],	req = { quests = {46035}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 22,	color = -9959933,	tooltip = RATL["TraitRow5Tint2Req_TBRT"],	req = { quests = {46035}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 21,	color = -8225281,	tooltip = RATL["TraitRow5Tint3Req_TBRT"],	req = { quests = {46035}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 24,	color = -9392,		tooltip = RATL["TraitRow5Tint4Req_TBRT"],	req = { quests = {46035}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 6.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 30,	color = -1268449,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43668} }, },
					{ modifiedID = 29,	color = -9214362,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 31,	color = -6363950,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 32,	color = -9654287,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Priest
	[242575] = { -- Shadow
		itemID = 128827,
		secondary = 133958,
		appearances = {
			[1] = { -- Classic
				tints = {
					{ modifiedID = 9,	color = 6004187, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 9778147,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 4775111, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 15463408,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				tints = {
					{ modifiedID = 15,	color = 7023546,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = 7463221,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = -6183280,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = 3531476,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				tints = {
					{ modifiedID = 20,	color = 15144984,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 18,	color = 2986533,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 19,	color = 6960054,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 17,	color = 9518140,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				tints = {
					{ modifiedID = 22,	color = 8929508,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 21,	color = 7262259,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 23,	color = 4382149,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = 16777215,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				tints = {
					{ modifiedID = 26,	color = -12714089,	tooltip = RATL["TraitRow5Tint1Req_TC"],	req = { quests = {46127}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 25,	color = -5505025,	tooltip = RATL["TraitRow5Tint2Req_TC"],	req = { quests = {46127}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 27,	color = 9450975,	tooltip = RATL["TraitRow5Tint3Req_TC"],	req = { quests = {46127}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 28,	color = 14804548,	tooltip = RATL["TraitRow5Tint4Req_TC"],	req = { quests = {46127}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 30,	color = 16160515,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43669} }, },
					{ modifiedID = 29,	color = 11855925,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 31,	color = 7736308,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 32,	color = 16711680,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Priest
	[242585] = { -- Discipline
		itemID = 128868,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = -8467201, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = -4835073,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = -59102, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = -1647284,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 16,	color = -1643226,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = -13640357,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = -2723555,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = -5513756,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 4.8, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 27,	color = -7259484,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 26,	color = -14584816,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 25,	color = -11759397,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 28,	color = -2054101,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 19,	color = -5752895,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 18,	color = -13078481,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 17,	color = -7620370,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = -6315899,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 4.8, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 32,	color = -207,		tooltip = RATL["TraitRow5Tint1Req_TFWM"],	req = { quests = {45627}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 30,	color = -9439249,	tooltip = RATL["TraitRow5Tint2Req_TFWM"],	req = { quests = {45627}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 31,	color = -2594874,	tooltip = RATL["TraitRow5Tint3Req_TFWM"],	req = { quests = {45627}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 29,	color = -25,		tooltip = RATL["TraitRow5Tint4Req_TFWM"],	req = { quests = {45627}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 22,	color = -6195025,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43667} }, },
					{ modifiedID = 21,	color = -14523614,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 23,	color = -9167598,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 24,	color = -2916814,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},

	-- Warlock
	[242598] = { -- Destruction
		itemID = 128941,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 7614128, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 4870381,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 2745662, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 16711680,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 15,	color = 2745662,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = 4870381,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = 7614128,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = 16711680,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 19,	color = 15725596,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 18,	color = 1172800,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 17,	color = 7614128,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = 16711680,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 21,	color = 7614128,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 22,	color = 4870381,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 23,	color = 2745662,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = 16711680,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 31,	color = 15730953,	tooltip = RATL["TraitRow5Tint1Req_TFWM"],	req = { quests = {45627}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 30,	color = 8338136,	tooltip = RATL["TraitRow5Tint2Req_TFWM"],	req = { quests = {45627}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 29,	color = 6417702,	tooltip = RATL["TraitRow5Tint3Req_TFWM"],	req = { quests = {45627}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 32,	color = 14935330,	tooltip = RATL["TraitRow5Tint4Req_TFWM"],	req = { quests = {45627}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 5.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 28,	color = 16711680,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43678} }, },
					{ modifiedID = 26,	color = 4907757,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 27,	color = 2745662,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 25,	color = 7614128,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Warlock
	[242599] = { -- Affliction
		itemID = 128942,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 16439925, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 4439624,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 10829783, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 13118749,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 16,	color = 14161945,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = 3532867,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = 10234844,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = -1585294,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 18,	color = 6089290,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 17,	color = 16769676,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 19,	color = 10106346,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = 13835035,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 25,	color = 2024822,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 26,	color = 15568426,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 27,	color = 6433946,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true }, -- BLIZZ SWAPPED THIS THIS 28
					{ modifiedID = 28,	color = 16124176,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true }, -- BLIZZ SWAPPED THIS THIS 27
				},
			},
			[5] = { -- Challenging
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 32,	color = 12457494,	tooltip = RATL["TraitRow5Tint1Req_TC"],	req = { quests = {46127}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 30,	color = 15839020,	tooltip = RATL["TraitRow5Tint2Req_TC"],	req = { quests = {46127}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 31,	color = 8401638,	tooltip = RATL["TraitRow5Tint3Req_TC"],	req = { quests = {46127}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 29,	color = 1828374,	tooltip = RATL["TraitRow5Tint4Req_TC"],	req = { quests = {46127}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 24,	color = 12074983,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43676} }, },
					{ modifiedID = 22,	color = 4519215,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 21,	color = 2238949,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 23,	color = 15740205,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Warlock
	[242600] = { -- Demonology
		itemID = 128943,
		secondary = 137246,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 8, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.05, facing = 0, pitch = 0, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				animation = 213,
				tints = {
					{ modifiedID = 10,	color = -12506481, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 9,	color = -13834423,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = -837594, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = -3801296,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 8, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.05, facing = 0, pitch = 0, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				animation = 213,
				tints = {
					{ modifiedID = 14,	color = -3334417,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = -10762693,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = -53451,		tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = -1183588,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 8, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.05, facing = 0, pitch = 0, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi / 2, pitch = -0.75, },
				animation = 213,
				tints = {
					{ modifiedID = 17,	color = -5181882,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 18,	color = -1821185,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 19,	color = -31947,		tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = -399040,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 8, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.05, facing = 0, pitch = 0, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				animation = 213,
				tints = {
					{ modifiedID = 23,	color = -1087187,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 22,	color = -6951661,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 21,	color = -8589065,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = -4975894,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 8, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.05, facing = 0, pitch = 0, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				animation = 213,
				tints = {
					{ modifiedID = 27,	color = -3211264,	tooltip = RATL["TraitRow5Tint1Req_GQC"],	req = { quests = {45526}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 26,	color = -8639745,	tooltip = RATL["TraitRow5Tint2Req_GQC"],	req = { quests = {45526}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 25,	color = -13589341,	tooltip = RATL["TraitRow5Tint3Req_GQC"],	req = { quests = {45526}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 28,	color = -262370,	tooltip = RATL["TraitRow5Tint4Req_GQC"],	req = { quests = {45526}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 8, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.05, facing = 0, pitch = 0, },
				secondaryCamera = { posX = 3.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				animation = 213,
				tints = {
					{ modifiedID = 29,	color = -10433586,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43677} }, },
					{ modifiedID = 30,	color = -5196074,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 31,	color = -10385949,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 32,	color = -1934476,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},

	-- Monk
	[242595] = { -- Mistweaver
		itemID = 128937,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 1493233, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 5038232,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 15801366, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 15593750,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 14,	color = 1503655,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = 1493233,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = 15806742,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = 15397142,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 20,	color = 15807510,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 18,	color = 8319254,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 19,	color = 11885769,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 17,	color = 1493233,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ =0, facing = math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 25,	color = 1493233,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 26,	color = 1503543,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 27,	color = 8984305,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 28,	color = 4675056,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 29,	color = 3729879,	tooltip = RATL["TraitRow5Tint1Req_TBRT"],	req = { quests = {46035}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 30,	color = 2552102,	tooltip = RATL["TraitRow5Tint2Req_TBRT"],	req = { quests = {46035}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 31,	color = 15511324,	tooltip = RATL["TraitRow5Tint3Req_TBRT"],	req = { quests = {46035}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 32,	color = 16447479,	tooltip = RATL["TraitRow5Tint4Req_TBRT"],	req = { quests = {46035}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 4, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 23,	color = 2075252,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43662} }, },
					{ modifiedID = 22,	color = 15828300,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 21,	color = 1455345,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 24,	color = 16716288,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Monk
	[242596] = { -- Brewmaster
		itemID = 128938,
		appearances = {
			[1] = { -- Classic
				tints = {
					{ modifiedID = 9,	color = 1370755, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 5424127,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 15082532, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 15651405,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				tints = {
					{ modifiedID = 13,	color = 4707946,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = 6789609,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = 13970990,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = 13820224,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				tints = {
					{ modifiedID = 20,	color = 14343983,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 18,	color = 4492232,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 19,	color = 14559529,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 17,	color = 3855469,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 23,	color = 15283252,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 22,	color = 7249636,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 21,	color = 4381060,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = 14673484,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 3.7, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 26,	color = 5809634,	tooltip = RATL["TraitRow5Tint1Req_THR"],	req = { quests = {45416}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 25,	color = 6677627,	tooltip = RATL["TraitRow5Tint2Req_THR"],	req = { quests = {45416}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 27,	color = 14628149,	tooltip = RATL["TraitRow5Tint3Req_THR"],	req = { quests = {45416}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 28,	color = 15001147,	tooltip = RATL["TraitRow5Tint4Req_THR"],	req = { quests = {45416}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 3.6, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.3, facing = math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 31,	color = -1678775,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43661} }, },
					{ modifiedID = 30,	color = 5102690,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 29,	color = 4544235,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 32,	color = 6174372,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Monk
	[242597] = { -- Windwalker
		itemID = 128940,
		secondary = 133948,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 3977706, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 4710975,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 16728353, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 16771663,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 16,	color = 16449363,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = 7143264,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = 16734003,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = 4176098,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 17,	color = 3466495,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 18,	color = 16398113,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 19,	color = 15066623,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = 4186724,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 23,	color = 14828607,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 22,	color = 6487878,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 21,	color = 5128162,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = 16773195,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 29,	color = 2552749,	tooltip = RATL["TraitRow5Tint1Req_TFWM"],	req = { quests = {45627}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 30,	color = 16711680,	tooltip = RATL["TraitRow5Tint2Req_TFWM"],	req = { quests = {45627}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 31,	color = 12648447,	tooltip = RATL["TraitRow5Tint3Req_TFWM"],	req = { quests = {45627}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 32,	color = 16765184,	tooltip = RATL["TraitRow5Tint4Req_TFWM"],	req = { quests = {45627}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = -.1, facing = math.pi/2, pitch = -0.75, },
				tints = {
					{ modifiedID = 25,	color = 4170722,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43673} }, },
					{ modifiedID = 26,	color = 5634632,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 27,	color = 16728898,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 28,	color = 13954047,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},

	-- Mage
	[242568] = { -- Fire
		itemID = 128820,
		secondary = 133959,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .05, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 15950399, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 8470515,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 5419819, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 9802991,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 16,	color = 15950399,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = 6147118,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = 9642695,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = 4284145,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 22,	color = 4780859,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 21,	color = 4575473,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 23,	color = 13524967,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 24,	color = 16728085,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .05, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 20,	color = 15950399,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 18,	color = 2417512,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 19,	color = 10303436,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 17,	color = 3751385,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .05, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 25,	color = 4191186,	tooltip = RATL["TraitRow5Tint1Req_IMC"],	req = { quests = {46065}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 26,	color = 9240352,	tooltip = RATL["TraitRow5Tint2Req_IMC"],	req = { quests = {46065}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 27,	color = 12407793,	tooltip = RATL["TraitRow5Tint3Req_IMC"],	req = { quests = {46065}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 28,	color = 15950399,	tooltip = RATL["TraitRow5Tint4Req_IMC"],	req = { quests = {46065}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 4.8, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				secondaryCamera = { posX = 3, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = .1, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 29,	color = 7327470,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43659} }, },
					{ modifiedID = 30,	color = 7874729,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 31,	color = 15090499,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 32,	color = 15724491,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Mage
	[242558] = { -- Arcane
		itemID = 127857,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 10432187, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 12,	color = 4439023,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 10,	color = 16645629, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 11,	color = 4711769,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 5.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 15,	color = 10564273,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 13,	color = 4439023,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = 16777215,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = 3207005,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 17,	color = 2320618,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 19,	color = 10692572,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 20,	color = 16777215,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 18,	color = 3666734,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 24,	color = 11680943,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 21,	color = 5143016,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 23,	color = 15767278,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 22,	color = 5630030,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 27,	color = 15267596,	tooltip = RATL["TraitRow5Tint1Req_GQC"],	req = { quests = {45526}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 26,	color = 11948839,	tooltip = RATL["TraitRow5Tint2Req_GQC"],	req = { quests = {45526}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 28,	color = 6382171,	tooltip = RATL["TraitRow5Tint3Req_GQC"],	req = { quests = {45526}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 25,	color = 5143016,	tooltip = RATL["TraitRow5Tint4Req_GQC"],	req = { quests = {45526}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 29,	color = 9523675,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43658} }, },
					{ modifiedID = 30,	color = 15217459,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 31,	color = 4624867,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 32,	color = 14935620,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},
	-- Mage
	[242582] = { -- Frost
		itemID = 128862,
		appearances = {
			[1] = { -- Classic
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 2697697, 	tooltip = RATL["TraitRow1Tint1Req"],	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 5099863,	tooltip = RATL["TraitRow1Tint2Req"],	req = { quests = {43349, 42213, 40890, 42454}, achievements = {}, any = true } },
					{ modifiedID = 11,	color = 10174674, 	tooltip = RATL["TraitRow1Tint3Req"],	req = { quests = {44153}, achievements = {} } },
					{ modifiedID = 12,	color = 16711685,	tooltip = RATL["TraitRow1Tint4Req"],	req = { quests = {42116}, achievements = {} } },
				},
			},
			[2] = { -- Upgraded
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 13,	color = 3881451,	tooltip = RATL["TraitRow2Tint1Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 14,	color = 5099863,	tooltip = RATL["TraitRow2Tint2Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 15,	color = 10174674,	tooltip = RATL["TraitRow2Tint3Req"],	req = { quests = {}, achievements = {10746}, charspecific = true } },
					{ modifiedID = 16,	color = 16711685,	tooltip = RATL["TraitRow2Tint4Req"],	req = { quests = {}, achievements = {10602} },	unobtainableRemix = true },
				},
			},
			[3] = { -- Valorous
				camera = { posX = 4.8, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 25,	color = 2744738,	tooltip = RATL["TraitRow3Tint1Req"],	req = { quests = {}, achievements = {10459} } },
					{ modifiedID = 26,	color = 3187001,	tooltip = RATL["TraitRow3Tint2Req"],	req = { quests = {}, achievements = {10459, 40018} } },
					{ modifiedID = 27,	color = 10174674,	tooltip = RATL["TraitRow3Tint3Req"],	req = { quests = {}, achievements = {10459, 11184} },	unobtainableRemix = true },
					{ modifiedID = 28,	color = 15584394,	tooltip = RATL["TraitRow3Tint4Req"],	req = { quests = {}, achievements = {10459, 11163} } },
				},
			},
			[4] = { -- War-torn
				camera = { posX = 4.7, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 18,	color = 2487336,	tooltip = RATL["TraitRow4Tint1Req"],	req = { quests = {}, achievements = {12894} },	unobtainableRemix = true },
					{ modifiedID = 17,	color = 2697697,	tooltip = RATL["TraitRow4Tint2Req"],	req = { quests = {}, achievements = {12902} },	unobtainableRemix = true },
					{ modifiedID = 19,	color = 10174674,	tooltip = RATL["TraitRow4Tint3Req"],	req = { quests = {}, achievements = {12904} },	unobtainableRemix = true },
					{ modifiedID = 20,	color = 16711685,	tooltip = RATL["TraitRow4Tint4Req"],	req = { quests = {}, achievements = {12907} },	unobtainableRemix = true },
				},
			},
			[5] = { -- Challenging
				camera = { posX = 4.5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 29,	color = 6478062,	tooltip = RATL["TraitRow5Tint1Req_TC"],	req = { quests = {46127}, achievements = {}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 30,	color = 3066535,	tooltip = RATL["TraitRow5Tint2Req_TC"],	req = { quests = {46127}, achievements = {11657, 11658, 11659, 11660}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 31,	color = 2446066,	tooltip = RATL["TraitRow5Tint3Req_TC"],	req = { quests = {46127}, achievements = {11661, 11662, 11663, 11664}, charspecific = true, any = true },	unobtainable = true, },
					{ modifiedID = 32,	color = 16052207,	tooltip = RATL["TraitRow5Tint4Req_TC"],	req = { quests = {46127}, achievements = {11665, 11666, 11667, 11668}, charspecific = true, any = true },	unobtainable = true, },
				},
			},
			[6] = { -- Hidden
				camera = { posX = 4.7, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 21,	color = 14517529,	tooltip = RATL["TraitRow6Tint1Req"],	req = { quests = {43660} }, },
					{ modifiedID = 22,	color = 11999467,	tooltip = RATL["TraitRow6Tint2Req"],	req = { quests = {}, achievements = {11152}, charspecific = true }, },
					{ modifiedID = 23,	color = 11006016,	tooltip = RATL["TraitRow6Tint3Req"],	req = { quests = {}, achievements = {11153}, charspecific = true }, },
					{ modifiedID = 24,	color = 2663653,	tooltip = RATL["TraitRow6Tint4Req"],	req = { quests = {}, achievements = {11154}, charspecific = true },	unobtainableRemix = true },
				},
			},
		},
	},

	-- Fishing
	[133755] = {
		itemID = 133755,
		appearances = {
			[1] = {
				camera = { posX = 5, posY = 0, posZ = 0, targetX = 0, targetY = 0, targetZ = 0, facing = math.pi / 2, pitch = -0.75, },
				tints = {
					{ modifiedID = 9,	color = 16714752, 	tooltip = "[PH] Fishes",	req = { quests = {}, achievements = {} } },
					{ modifiedID = 10,	color = 2088470,	tooltip = "[PH] Complete the achievement, \"Fisherfriend of the Isles.\"",	req = { quests = {48546}, achievements = {} } },
					{ modifiedID = 11,	color = 3361410, 	tooltip = "[PH] Complete the achievement, \"Fisherfriend of the Isles.\"",	req = { quests = {48546}, achievements = {} } },
				},
			},
		},
	},
};

-- artifact appearance row names
rat.ArtifactAppearanceNames = {
	[242556] = {
		class = "DEMONHUNTER",
		spec = "Havoc",
		appearances = {
			[1] = RATL["TraitRow1_DemonHunter_Havoc_Classic"],
			[2] = RATL["TraitRow2_DemonHunter_Havoc_Upgraded"],
			[3] = RATL["TraitRow3_DemonHunter_Havoc_Valorous"],
			[4] = RATL["TraitRow4_DemonHunter_Havoc_War-torn"],
			[5] = RATL["TraitRow5_DemonHunter_Havoc_Challenging"],
			[6] = RATL["TraitRow6_DemonHunter_Havoc_Hidden"],
		},
		icon = "Artifacts-DemonHunter-BG-rune",
		background = "Artifacts-DemonHunter-BG",
	},
	[242577] = {
		class = "DEMONHUNTER",
		spec = "Vengeance",
		appearances = {
			[1] = RATL["TraitRow1_DemonHunter_Vengeance_Classic"],
			[2] = RATL["TraitRow2_DemonHunter_Vengeance_Upgraded"],
			[3] = RATL["TraitRow3_DemonHunter_Vengeance_Valorous"],
			[4] = RATL["TraitRow4_DemonHunter_Vengeance_War-torn"],
			[5] = RATL["TraitRow5_DemonHunter_Vengeance_Challenging"],
			[6] = RATL["TraitRow6_DemonHunter_Vengeance_Hidden"],
		},
		icon = "Artifacts-DemonHunter-BG-rune",
		background = "Artifacts-DemonHunter-BG",
	},

	[242555] = {
		class = "PALADIN",
		spec = "Retribution",
		appearances = {
			[1] = RATL["TraitRow1_Paladin_Retribution_Classic"],
			[2] = RATL["TraitRow2_Paladin_Retribution_Upgraded"],
			[3] = RATL["TraitRow3_Paladin_Retribution_Valorous"],
			[4] = RATL["TraitRow4_Paladin_Retribution_War-torn"],
			[5] = RATL["TraitRow5_Paladin_Retribution_Challenging"],
			[6] = RATL["TraitRow6_Paladin_Retribution_Hidden"],
		},
		icon = "Artifacts-Paladin-BG-rune",
		background = "Artifacts-Paladin-BG",
	},
	[242571] = {
		class = "PALADIN",
		spec = "Holy",
		appearances = {
			[1] = RATL["TraitRow1_Paladin_Holy_Classic"],
			[2] = RATL["TraitRow2_Paladin_Holy_Upgraded"],
			[3] = RATL["TraitRow3_Paladin_Holy_Valorous"],
			[4] = RATL["TraitRow4_Paladin_Holy_War-torn"],
			[5] = RATL["TraitRow5_Paladin_Holy_Challenging"],
			[6] = RATL["TraitRow6_Paladin_Holy_Hidden"],
		},
		icon = "Artifacts-Paladin-BG-rune",
		background = "Artifacts-Paladin-BG",
	},
	[242583] = {
		class = "PALADIN",
		spec = "Protection",
		appearances = {
			[1] = RATL["TraitRow1_Paladin_Protection_Classic"],
			[2] = RATL["TraitRow2_Paladin_Protection_Upgraded"],
			[3] = RATL["TraitRow3_Paladin_Protection_Valorous"],
			[4] = RATL["TraitRow4_Paladin_Protection_War-torn"],
			[5] = RATL["TraitRow5_Paladin_Protection_Challenging"],
			[6] = RATL["TraitRow6_Paladin_Protection_Hidden"],
		},
		icon = "Artifacts-Paladin-BG-rune",
		background = "Artifacts-Paladin-BG",
	},

	--Death Knight
	[242562] = {
		class = "DEATHKNIGHT",
		spec = "Blood",
		appearances = {
			[1] = RATL["TraitRow1_DeathKnight_Blood_Classic"],
			[2] = RATL["TraitRow2_DeathKnight_Blood_Upgraded"],
			[3] = RATL["TraitRow3_DeathKnight_Blood_Valorous"],
			[4] = RATL["TraitRow4_DeathKnight_Blood_War-torn"],
			[5] = RATL["TraitRow5_DeathKnight_Blood_Challenging"],
			[6] = RATL["TraitRow6_DeathKnight_Blood_Hidden"],
		},
		icon = "Artifacts-DeathKnightFrost-BG-rune",
		background = "Artifacts-DeathKnightFrost-BG",
	},
	[242559] = {
		class = "DEATHKNIGHT",
		spec = "Frost",
		appearances = {
			[1] = RATL["TraitRow1_DeathKnight_Frost_Classic"],
			[2] = RATL["TraitRow2_DeathKnight_Frost_Upgraded"],
			[3] = RATL["TraitRow3_DeathKnight_Frost_Valorous"],
			[4] = RATL["TraitRow4_DeathKnight_Frost_War-torn"],
			[5] = RATL["TraitRow5_DeathKnight_Frost_Challenging"],
			[6] = RATL["TraitRow6_DeathKnight_Frost_Hidden"],
		},
		icon = "Artifacts-DeathKnightFrost-BG-rune",
		background = "Artifacts-DeathKnightFrost-BG",
	},
	[242563] = {
		class = "DEATHKNIGHT",
		spec = "Unholy",
		appearances = {
			[1] = RATL["TraitRow1_DeathKnight_Unholy_Classic"],
			[2] = RATL["TraitRow2_DeathKnight_Unholy_Upgraded"],
			[3] = RATL["TraitRow3_DeathKnight_Unholy_Valorous"],
			[4] = RATL["TraitRow4_DeathKnight_Unholy_War-torn"],
			[5] = RATL["TraitRow5_DeathKnight_Unholy_Challenging"],
			[6] = RATL["TraitRow6_DeathKnight_Unholy_Hidden"],
		},
		icon = "Artifacts-DeathKnightFrost-BG-rune",
		background = "Artifacts-DeathKnightFrost-BG",
	},

	--Warrior
	[236772] = {
		class = "WARRIOR",
		spec = "Arms",
		appearances = {
			[1] = RATL["TraitRow1_Warrior_Arms_Classic"],
			[2] = RATL["TraitRow2_Warrior_Arms_Upgraded"],
			[3] = RATL["TraitRow3_Warrior_Arms_Valorous"],
			[4] = RATL["TraitRow4_Warrior_Arms_War-torn"],
			[5] = RATL["TraitRow5_Warrior_Arms_Challenging"],
			[6] = RATL["TraitRow6_Warrior_Arms_Hidden"],
		},
		icon = "Artifacts-Warrior-BG-rune",
		background = "Artifacts-Warrior-BG",
	},
	[237746] = {
		class = "WARRIOR",
		spec = "Fury",
		appearances = {
			[1] = RATL["TraitRow1_Warrior_Fury_Classic"],
			[2] = RATL["TraitRow2_Warrior_Fury_Upgraded"],
			[3] = RATL["TraitRow3_Warrior_Fury_Valorous"],
			[4] = RATL["TraitRow4_Warrior_Fury_War-torn"],
			[5] = RATL["TraitRow5_Warrior_Fury_Challenging"],
			[6] = RATL["TraitRow6_Warrior_Fury_Hidden"],
		},
		icon = "Artifacts-Warrior-BG-rune",
		background = "Artifacts-Warrior-BG",
	},
	[237749] = {
		class = "WARRIOR",
		spec = "Protection",
		appearances = {
			[1] = RATL["TraitRow1_Warrior_Protection_Classic"],
			[2] = RATL["TraitRow2_Warrior_Protection_Upgraded"],
			[3] = RATL["TraitRow3_Warrior_Protection_Valorous"],
			[4] = RATL["TraitRow4_Warrior_Protection_War-torn"],
			[5] = RATL["TraitRow5_Warrior_Protection_Challenging"],
			[6] = RATL["TraitRow6_Warrior_Protection_Hidden"],
		},
		icon = "Artifacts-Warrior-BG-rune",
		background = "Artifacts-Warrior-BG",
	},

	--Hunter
	[242581] = {
		class = "HUNTER",
		spec = "BeastMastery",
		appearances = {
			[1] = RATL["TraitRow1_Hunter_BeastMastery_Classic"],
			[2] = RATL["TraitRow2_Hunter_BeastMastery_Upgraded"],
			[3] = RATL["TraitRow3_Hunter_BeastMastery_Valorous"],
			[4] = RATL["TraitRow4_Hunter_BeastMastery_War-torn"],
			[5] = RATL["TraitRow5_Hunter_BeastMastery_Challenging"],
			[6] = RATL["TraitRow6_Hunter_BeastMastery_Hidden"],
		},
		icon = "Artifacts-Hunter-BG-rune",
		background = "Artifacts-Hunter-BG",
	},
	[246013] = {
		class = "HUNTER",
		spec = "Marksmanship",
		appearances = {
			[1] =RATL["TraitRow1_Hunter_Marksmanship_Classic"],
			[2] =RATL["TraitRow2_Hunter_Marksmanship_Upgraded"],
			[3] =RATL["TraitRow3_Hunter_Marksmanship_Valorous"],
			[4] =RATL["TraitRow4_Hunter_Marksmanship_War-torn"],
			[5] =RATL["TraitRow5_Hunter_Marksmanship_Challenging"],
			[6] =RATL["TraitRow6_Hunter_Marksmanship_Hidden"],
		},
		icon = "Artifacts-Hunter-BG-rune",
		background = "Artifacts-Hunter-BG",
	},
	[242566] = {
		class = "HUNTER",
		spec = "Survival",
		appearances = {
			[1] = RATL["TraitRow1_Hunter_Survival_Classic"],
			[2] = RATL["TraitRow2_Hunter_Survival_Upgraded"],
			[3] = RATL["TraitRow3_Hunter_Survival_Valorous"],
			[4] = RATL["TraitRow4_Hunter_Survival_War-torn"],
			[5] = RATL["TraitRow5_Hunter_Survival_Challenging"],
			[6] = RATL["TraitRow6_Hunter_Survival_Hidden"],
		},
		icon = "Artifacts-Hunter-BG-rune",
		background = "Artifacts-Hunter-BG",
	},

	--Shaman
	[242593] = {
		class = "SHAMAN",
		spec = "Elemental",
		appearances = {
			[1] = RATL["TraitRow1_Shaman_Elemental_Classic"],
			[2] = RATL["TraitRow2_Shaman_Elemental_Upgraded"],
			[3] = RATL["TraitRow3_Shaman_Elemental_Valorous"],
			[4] = RATL["TraitRow4_Shaman_Elemental_War-torn"],
			[5] = RATL["TraitRow5_Shaman_Elemental_Challenging"],
			[6] = RATL["TraitRow6_Shaman_Elemental_Hidden"],
		},
		icon = "Artifacts-Shaman-BG-rune",
		background = "Artifacts-Shaman-BG",
	},
	[242567] = {
		class = "SHAMAN",
		spec = "Enhancement",
		appearances = {
			[1] = RATL["TraitRow1_Shaman_Enhancement_Classic"],
			[2] = RATL["TraitRow2_Shaman_Enhancement_Upgraded"],
			[3] = RATL["TraitRow3_Shaman_Enhancement_Valorous"],
			[4] = RATL["TraitRow4_Shaman_Enhancement_War-torn"],
			[5] = RATL["TraitRow5_Shaman_Enhancement_Challenging"],
			[6] = RATL["TraitRow6_Shaman_Enhancement_Hidden"],
		},
		icon = "Artifacts-Shaman-BG-rune",
		background = "Artifacts-Shaman-BG",
	},
	[242591] = {
		class = "SHAMAN",
		spec = "Restoration",
		appearances = {
			[1] =RATL["TraitRow1_Shaman_Restoration_Classic"],
			[2] =RATL["TraitRow2_Shaman_Restoration_Upgraded"],
			[3] =RATL["TraitRow3_Shaman_Restoration_Valorous"],
			[4] =RATL["TraitRow4_Shaman_Restoration_War-torn"],
			[5] =RATL["TraitRow5_Shaman_Restoration_Challenging"],
			[6] =RATL["TraitRow6_Shaman_Restoration_Hidden"],
		},
		icon = "Artifacts-Shaman-BG-rune",
		background = "Artifacts-Shaman-BG",
	},

	--Druid
	[242578] = {
		class = "DRUID",
		spec = "Balance",
		appearances = {
			[1] = RATL["TraitRow1_Druid_Balance_Classic"],
			[2] = RATL["TraitRow2_Druid_Balance_Upgraded"],
			[3] = RATL["TraitRow3_Druid_Balance_Valorous"],
			[4] = RATL["TraitRow4_Druid_Balance_War-torn"],
			[5] = RATL["TraitRow5_Druid_Balance_Challenging"],
			[6] = RATL["TraitRow6_Druid_Balance_Hidden"],
		},
		icon = "Artifacts-Druid-BG-rune",
		background = "Artifacts-Druid-BG",
	},
	[242580] = {
		class = "DRUID",
		spec = "Feral",
		appearances = {
			[1] = RATL["TraitRow1_Druid_Feral_Classic"],
			[2] = RATL["TraitRow2_Druid_Feral_Upgraded"],
			[3] = RATL["TraitRow3_Druid_Feral_Valorous"],
			[4] = RATL["TraitRow4_Druid_Feral_War-torn"],
			[5] = RATL["TraitRow5_Druid_Feral_Challenging"],
			[6] = RATL["TraitRow6_Druid_Feral_Hidden"],
		},
		icon = "Artifacts-Druid-BG-rune",
		background = "Artifacts-Druid-BG",
	},
	[242569] = {
		class = "DRUID",
		spec = "Guardian",
		appearances = {
			[1] = RATL["TraitRow1_Druid_Guardian_Classic"],
			[2] = RATL["TraitRow2_Druid_Guardian_Upgraded"],
			[3] = RATL["TraitRow3_Druid_Guardian_Valorous"],
			[4] = RATL["TraitRow4_Druid_Guardian_War-torn"],
			[5] = RATL["TraitRow5_Druid_Guardian_Challenging"],
			[6] = RATL["TraitRow6_Druid_Guardian_Hidden"],
		},
		icon = "Artifacts-Druid-BG-rune",
		background = "Artifacts-Druid-BG",
	},
	[242561] = {
		class = "DRUID",
		spec = "Restoration",
		appearances = {
			[1] = RATL["TraitRow1_Druid_Restoration_Classic"],
			[2] = RATL["TraitRow2_Druid_Restoration_Upgraded"],
			[3] = RATL["TraitRow3_Druid_Restoration_Valorous"],
			[4] = RATL["TraitRow4_Druid_Restoration_War-torn"],
			[5] = RATL["TraitRow5_Druid_Restoration_Challenging"],
			[6] = RATL["TraitRow6_Druid_Restoration_Hidden"],
		},
		icon = "Artifacts-Druid-BG-rune",
		background = "Artifacts-Druid-BG",
	},

	--Monk
	[242596] = {
		class = "MONK",
		spec = "Brewmaster",
		appearances = {
			[1] = RATL["TraitRow1_Monk_Brewmaster_Classic"],
			[2] = RATL["TraitRow2_Monk_Brewmaster_Upgraded"],
			[3] = RATL["TraitRow3_Monk_Brewmaster_Valorous"],
			[4] = RATL["TraitRow4_Monk_Brewmaster_War-torn"],
			[5] = RATL["TraitRow5_Monk_Brewmaster_Challenging"],
			[6] = RATL["TraitRow6_Monk_Brewmaster_Hidden"],
		},
		icon = "Artifacts-Monk-BG-rune",
		background = "Artifacts-Monk-BG",
	},
	[242595] = {
		class = "MONK",
		spec = "Mistweaver",
		appearances = {
			[1] = RATL["TraitRow1_Monk_Mistweaver_Classic"],
			[2] = RATL["TraitRow2_Monk_Mistweaver_Upgraded"],
			[3] = RATL["TraitRow3_Monk_Mistweaver_Valorous"],
			[4] = RATL["TraitRow4_Monk_Mistweaver_War-torn"],
			[5] = RATL["TraitRow5_Monk_Mistweaver_Challenging"],
			[6] = RATL["TraitRow6_Monk_Mistweaver_Hidden"],
		},
		icon = "Artifacts-Monk-BG-rune",
		background = "Artifacts-Monk-BG",
	},
	[242597] = {
		class = "MONK",
		spec = "Windwalker",
		appearances = {
			[1] = RATL["TraitRow1_Monk_Windwalker_Classic"],
			[2] = RATL["TraitRow2_Monk_Windwalker_Upgraded"],
			[3] = RATL["TraitRow3_Monk_Windwalker_Valorous"],
			[4] = RATL["TraitRow4_Monk_Windwalker_War-torn"],
			[5] = RATL["TraitRow5_Monk_Windwalker_Challenging"],
			[6] = RATL["TraitRow6_Monk_Windwalker_Hidden"],
		},
		icon = "Artifacts-Monk-BG-rune",
		background = "Artifacts-Monk-BG",
	},

	--Rogue
	[242587] = {
		class = "ROGUE",
		spec = "Assassination",
		appearances = {
			[1] = RATL["TraitRow1_Rogue_Assassination_Classic"],
			[2] = RATL["TraitRow2_Rogue_Assassination_Upgraded"],
			[3] = RATL["TraitRow3_Rogue_Assassination_Valorous"],
			[4] = RATL["TraitRow4_Rogue_Assassination_War-torn"],
			[5] = RATL["TraitRow5_Rogue_Assassination_Challenging"],
			[6] = RATL["TraitRow6_Rogue_Assassination_Hidden"],
		},
		icon = "Artifacts-Rogue-BG-rune",
		background = "Artifacts-Rogue-BG",
	},
	[242588] = {
		class = "ROGUE",
		spec = "Outlaw",
		appearances = {
			[1] = RATL["TraitRow1_Rogue_Outlaw_Classic"],
			[2] = RATL["TraitRow2_Rogue_Outlaw_Upgraded"],
			[3] = RATL["TraitRow3_Rogue_Outlaw_Valorous"],
			[4] = RATL["TraitRow4_Rogue_Outlaw_War-torn"],
			[5] = RATL["TraitRow5_Rogue_Outlaw_Challenging"],
			[6] = RATL["TraitRow6_Rogue_Outlaw_Hidden"],
		},
		icon = "Artifacts-Rogue-BG-rune",
		background = "Artifacts-Rogue-BG",
	},
	[242564] = {
		class = "ROGUE",
		spec = "Subtlety",
		appearances = {
			[1] = RATL["TraitRow1_Rogue_Subtlety_Classic"],
			[2] = RATL["TraitRow2_Rogue_Subtlety_Upgraded"],
			[3] = RATL["TraitRow3_Rogue_Subtlety_Valorous"],
			[4] = RATL["TraitRow4_Rogue_Subtlety_War-torn"],
			[5] = RATL["TraitRow5_Rogue_Subtlety_Challenging"],
			[6] = RATL["TraitRow6_Rogue_Subtlety_Hidden"],
		},
		icon = "Artifacts-Rogue-BG-rune",
		background = "Artifacts-Rogue-BG",
	},

	--Warlock
	[242599] = {
		class = "WARLOCK",
		spec = "Affliction",
		appearances = {
			[1] = RATL["TraitRow1_Warlock_Affliction_Classic"],
			[2] = RATL["TraitRow2_Warlock_Affliction_Upgraded"],
			[3] = RATL["TraitRow3_Warlock_Affliction_Valorous"],
			[4] = RATL["TraitRow4_Warlock_Affliction_War-torn"],
			[5] = RATL["TraitRow5_Warlock_Affliction_Challenging"],
			[6] = RATL["TraitRow6_Warlock_Affliction_Hidden"],
		},
		icon = "Artifacts-Warlock-BG-rune",
		background = "Artifacts-Warlock-BG",
	},
	[242600] = {
		class = "WARLOCK",
		spec = "Demonology",
		appearances = {
			[1] = RATL["TraitRow1_Warlock_Demonology_Classic"],
			[2] = RATL["TraitRow2_Warlock_Demonology_Upgraded"],
			[3] = RATL["TraitRow3_Warlock_Demonology_Valorous"],
			[4] = RATL["TraitRow4_Warlock_Demonology_War-torn"],
			[5] = RATL["TraitRow5_Warlock_Demonology_Challenging"],
			[6] = RATL["TraitRow6_Warlock_Demonology_Hidden"],
		},
		icon = "Artifacts-Warlock-BG-rune",
		background = "Artifacts-Warlock-BG",
	},
	[242598] = {
		class = "WARLOCK",
		spec = "Destruction",
		appearances = {
			[1] = RATL["TraitRow1_Warlock_Destruction_Classic"],
			[2] = RATL["TraitRow2_Warlock_Destruction_Upgraded"],
			[3] = RATL["TraitRow3_Warlock_Destruction_Valorous"],
			[4] = RATL["TraitRow4_Warlock_Destruction_War-torn"],
			[5] = RATL["TraitRow5_Warlock_Destruction_Challenging"],
			[6] = RATL["TraitRow6_Warlock_Destruction_Hidden"],
		},
		icon = "Artifacts-Warlock-BG-rune",
		background = "Artifacts-Warlock-BG",
	},

	--Priest
	[242585] = {
		class = "PRIEST",
		spec = "Discipline",
		appearances = {
			[1] = RATL["TraitRow1_Priest_Discipline_Classic"],
			[2] = RATL["TraitRow2_Priest_Discipline_Upgraded"],
			[3] = RATL["TraitRow3_Priest_Discipline_Valorous"],
			[4] = RATL["TraitRow4_Priest_Discipline_War-torn"],
			[5] = RATL["TraitRow5_Priest_Discipline_Challenging"],
			[6] = RATL["TraitRow6_Priest_Discipline_Hidden"],
		},
		icon = "Artifacts-Priest-BG-rune",
		background = "Artifacts-Priest-BG",
	},
	[242573] = {
		class = "PRIEST",
		spec = "Holy",
		appearances = {
			[1] = RATL["TraitRow1_Priest_Holy_Classic"],
			[2] = RATL["TraitRow2_Priest_Holy_Upgraded"],
			[3] = RATL["TraitRow3_Priest_Holy_Valorous"],
			[4] = RATL["TraitRow4_Priest_Holy_War-torn"],
			[5] = RATL["TraitRow5_Priest_Holy_Challenging"],
			[6] = RATL["TraitRow6_Priest_Holy_Hidden"],
		},
		icon = "Artifacts-Priest-BG-rune",
		background = "Artifacts-Priest-BG",
	},
	[242575] = {
		class = "PRIEST",
		spec = "Shadow",
		appearances = {
			[1] = RATL["TraitRow1_Priest_Shadow_Classic"],
			[2] = RATL["TraitRow2_Priest_Shadow_Upgraded"],
			[3] = RATL["TraitRow3_Priest_Shadow_Valorous"],
			[4] = RATL["TraitRow4_Priest_Shadow_War-torn"],
			[5] = RATL["TraitRow5_Priest_Shadow_Challenging"],
			[6] = RATL["TraitRow6_Priest_Shadow_Hidden"],
		},
		icon = "Artifacts-PriestShadow-BG-rune",
		background = "Artifacts-PriestShadow-BG",
	},

	--Mage
	[242558] = {
		class = "MAGE",
		spec = "Arcane",
		appearances = {
			[1] = RATL["TraitRow1_Mage_Arcane_Classic"],
			[2] = RATL["TraitRow2_Mage_Arcane_Upgraded"],
			[3] = RATL["TraitRow3_Mage_Arcane_Valorous"],
			[4] = RATL["TraitRow4_Mage_Arcane_War-torn"],
			[5] = RATL["TraitRow5_Mage_Arcane_Challenging"],
			[6] = RATL["TraitRow6_Mage_Arcane_Hidden"],
		},
		icon = "Artifacts-MageArcane-BG-rune",
		background = "Artifacts-MageArcane-BG",
	},
	[242568] = {
		class = "MAGE",
		spec = "Fire",
		appearances = {
			[1] = RATL["TraitRow1_Mage_Fire_Classic"],
			[2] = RATL["TraitRow2_Mage_Fire_Upgraded"],
			[3] = RATL["TraitRow3_Mage_Fire_Valorous"],
			[4] = RATL["TraitRow4_Mage_Fire_War-torn"],
			[5] = RATL["TraitRow5_Mage_Fire_Challenging"],
			[6] = RATL["TraitRow6_Mage_Fire_Hidden"],
		},
		icon = "Artifacts-MageArcane-BG-rune",
		background = "Artifacts-MageArcane-BG",
	},
	[242582] = {
		class = "MAGE",
		spec = "Frost",
		appearances = {
			[1] = RATL["TraitRow1_Mage_Frost_Classic"],
			[2] = RATL["TraitRow2_Mage_Frost_Upgraded"],
			[3] = RATL["TraitRow3_Mage_Frost_Valorous"],
			[4] = RATL["TraitRow4_Mage_Frost_War-torn"],
			[5] = RATL["TraitRow5_Mage_Frost_Challenging"],
			[6] = RATL["TraitRow6_Mage_Frost_Hidden"],
		},
		icon = "Artifacts-MageArcane-BG-rune",
		background = "Artifacts-MageArcane-BG",
	},
	[133755] = {
		class = "Adventurer",
		spec = "Fishing",
		appearances = {
			[1] = "[PH] Underlight Angler",
		},
		icon = "Mobile-Fishing",
		background = "Professions-Specializations-Background-Fishing",
	},
};

rat.ClassArtifacts = {
	["WARRIOR"]		 = { 236772, 237746, 237749 },
	["PALADIN"]		 = { 242555, 242571, 242583 },
	["HUNTER"]		 = { 242581, 246013, 242566 },
	["ROGUE"]		 = { 242587, 242588, 242564 },
	["PRIEST"]		 = { 242585, 242573, 242575 },
	["DEATHKNIGHT"]	 = { 242562, 242559, 242563 },
	["SHAMAN"]		 = { 242593, 242567, 242591 },
	["MAGE"]		 = { 242558, 242568, 242582 },
	["WARLOCK"]		 = { 242599, 242600, 242598 },
	["MONK"]		 = { 242596, 242595, 242597 },
	["DRUID"]		 = { 242578, 242580, 242569, 242561 },
	["DEMONHUNTER"]	 = { 242556, 242577 },
	["EVOKER"]		 = { 133755 },
	["Adventurer"]	 = { 133755 }, -- Fishing

	["DEBUG"]		 = { -- debug, includes all above IDs
		236772, 237746, 237749,
		242555, 242571, 242583,
		242581, 246013, 242566,
		242587, 242588, 242564,
		242585, 242573, 242575,
		242562, 242559, 242563,
		242593, 242567, 242591,
		242558, 242568, 242582,
		242599, 242600, 242598,
		242596, 242595, 242597,
		242578, 242580, 242569, 242561,
		242556, 242577,
		133755,
	}
};

--rat.ClassArtifacts.DEMONHUNTER = rat.ClassArtifacts.DEBUG -- (for testing, do not add to final version)

local RefreshPanel, SelectSwatch, RefreshSwatches, SetupCustomPanel, SelectRemixTab

local RemixStandaloneFrame

local function RATFrame_OnShow()
	if RemixArtifactFrame then
		if RemixArtifactFrame.Model then
			RemixArtifactFrame.Model:SetAlpha(0)
		end
		if RemixArtifactFrame.Model then
			RemixArtifactFrame.AltModel:SetAlpha(0)
		end
	end
	if RemixStandaloneFrame and RemixStandaloneFrame:GetParent() == UIParent then
		PlaySound(SOUNDKIT.UI_CLASS_TALENT_OPEN_WINDOW);
	end
end
local function RATFrame_OnHide()
	if RemixArtifactFrame then
		if RemixArtifactFrame.Model then
			RemixArtifactFrame.Model:SetAlpha(1)
		end
		if RemixArtifactFrame.Model then
			RemixArtifactFrame.AltModel:SetAlpha(1)
		end
	end
	if RemixStandaloneFrame and RemixStandaloneFrame:GetParent() == UIParent then
		PlaySound(SOUNDKIT.UI_CLASS_TALENT_CLOSE_WINDOW);
	end
end

local function ToggleStandaloneFrame()
	if not RemixStandaloneFrame then
		RemixStandaloneFrame = CreateFrame("Frame", "RAT_RemixStandaloneFrame", UIParent)
		RemixStandaloneFrame:SetSize(1618, 883)
		RemixStandaloneFrame:SetPoint("TOP", 0, -116)
		RemixStandaloneFrame:SetToplevel(true)
		--RemixStandaloneFrame:SetMovable(true)
		RemixStandaloneFrame:EnableMouse(true)

		tinsert(UISpecialFrames, RemixStandaloneFrame:GetName())
		--RemixStandaloneFrame:RegisterForDrag("LeftButton")
		--RemixStandaloneFrame:SetScript("OnDragStart", RemixStandaloneFrame.StartMoving)
		--RemixStandaloneFrame:SetScript("OnDragStop", RemixStandaloneFrame.StopMovingOrSizing)

		RemixStandaloneFrame.tex = RemixStandaloneFrame:CreateTexture()
		RemixStandaloneFrame.tex:SetAllPoints()

		--local title = RemixStandaloneFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		--title:SetPoint("TOP", 0, -16)
		--title:SetText(RATL["Addon_Title"])

		SetupCustomPanel(RemixStandaloneFrame);
		RemixStandaloneFrame.customPanel:Show();

		local _, classToken = UnitClass("player");
		local classArtifacts = rat.ClassArtifacts and rat.ClassArtifacts[classToken]
		if classArtifacts and #classArtifacts > 0 then
			RemixStandaloneFrame.attachedItemID = classArtifacts[1];
		end
		
		RemixStandaloneFrame:Show();
		RefreshPanel(RemixStandaloneFrame);
	else
		RemixStandaloneFrame:SetShown(not RemixStandaloneFrame:IsShown());
		if RemixStandaloneFrame:IsShown() then
			RefreshPanel(RemixStandaloneFrame);
		end
	end
end

local function RAT_SlashHandler(msg)
		-- if the main artifact frame is open, treat the slash command as a shortcut to the appearance tab
	if RemixArtifactFrame and RemixArtifactFrame:IsShown() then
		SelectRemixTab(2)
	else
		-- if the main artifact frame is closed, use the standalone frame
		if RemixStandaloneFrame and RemixStandaloneFrame:GetParent() ~= UIParent then
			RemixStandaloneFrame:SetParent(UIParent)
			RemixStandaloneFrame:ClearAllPoints()
			RemixStandaloneFrame:SetPoint("TOP", 0, -116)
			RemixStandaloneFrame:SetSize(1618, 883) -- re-apply size for standalone mode
		end

		ToggleStandaloneFrame()
	end
end
SLASH_REMIXARTIFACTTRACKER1 = RATL["SlashCmd1"];
SLASH_REMIXARTIFACTTRACKER2 = RATL["SlashCmd2"];
SLASH_REMIXARTIFACTTRACKER3 = RATL["SlashCmd3"];
SlashCmdList["REMIXARTIFACTTRACKER"] = RAT_SlashHandler;

local function SetModelCamera(modelFrame, cameraData)
	modelFrame.lastCamera = cameraData;
	modelFrame:MakeCurrentCameraCustom();

	if cameraData then
		modelFrame:SetCameraPosition(cameraData.posX or 3.5, cameraData.posY or 0, cameraData.posZ or 0);
		modelFrame:SetCameraTarget(cameraData.targetX or 0, cameraData.targetY or 0, cameraData.targetZ or 0.1);
		modelFrame:SetFacing(cameraData.facing or math.pi / 2);
		modelFrame:SetPitch(cameraData.pitch or -0.75);
	else
		-- default cam if cameraData nil
		modelFrame:SetCameraPosition(3.5, 0, 0);
		modelFrame:SetCameraTarget(0, 0, 0.1);
		modelFrame:SetFacing(math.pi / 2);
		modelFrame:SetPitch(-0.75);
	end
end

local function AreRequirementsMet(req)
	-- check quests
	if req.quests then
		if req.any then
			local anyComplete = false;
			for _, questID in ipairs(req.quests) do
				if C_QuestLog.IsQuestFlaggedCompleted(questID) then
					anyComplete = true;
					break; -- the "collect 1 of the pillars" thing
				end
			end
			if not anyComplete then
				return false;
			end
		else
			for _, questID in ipairs(req.quests) do
				if not C_QuestLog.IsQuestFlaggedCompleted(questID) then
					return false;
				end
			end
		end
	end

	-- check achievements
	if req.achievements then
		for _, achID in ipairs(req.achievements) do
			local _, _, _, completed, _, _, _, _, _, _, _, _, wasEarnedByMe = GetAchievementInfo(achID)

			if (req.charspecific and not wasEarnedByMe) or (not req.charspecific and not completed) then -- some achieves aren't really warbound and tints want the char-specific ones
				return false;
			end
		end
	end
	return true;
end

local function GetAchievementProgress(achievementID)
	local currentProgress, requiredProgress = 0, 0
	local numCriteria = GetAchievementNumCriteria(achievementID)
	if numCriteria == 0 then return nil, nil end

	for i = 1, numCriteria do
		local _, _, _, quantity, totalQuantity = GetAchievementCriteriaInfo(achievementID, i)
		currentProgress = currentProgress + quantity
		requiredProgress = totalQuantity
	end

	return currentProgress, requiredProgress
end

function UISwatchColorToRGB(colorInt)
	if not colorInt then
		return 1, 1, 1;
	end
	local b = bit.band(colorInt, 0xFF) / 255;
	local g = bit.band(bit.rshift(colorInt, 8), 0xFF) / 255;
	local r = bit.band(bit.rshift(colorInt, 16), 0xFF) / 255;
	return r, g, b;
end

-- handles all logic for selecting a swatch button
SelectSwatch = function(swatchButton)
	local frame = swatchButton.parentFrame
	if not frame then return end
	local panel = frame.customPanel
	if not panel or not panel.swatchRows then return end

	panel.selectedSwatch = swatchButton

	-- hide all selection highlights
	for _, row in ipairs(panel.swatchRows) do
		for _, btn in ipairs(row) do
			btn.selection:Hide();
		end
	end

	swatchButton.selection:Show(); -- show selection on the target button

	-- update the model and camera
	local specID = frame.attachedItemID
	local specData = rat.AppSwatchData[specID]
	if not specData then return end

	local appearanceData = specData.appearances[swatchButton.rowIndex]
	local tintData = swatchButton.swatchData -- selected tint data

	if tintData and appearanceData then
		local cameraToUse = appearanceData.camera; -- default to the main model camera

		if panel.showSecondary and specData.secondary then
			panel.modelFrame:SetItem(specData.secondary, tintData.modifiedID);

			if appearanceData.secondaryCamera then
				cameraToUse = appearanceData.secondaryCamera; -- use secondaryCamera if defined
			end
		elseif tintData.displayID then
			panel.modelFrame:SetDisplayInfo(tintData.displayID); -- use displayID over default but not secondary
		else
			panel.modelFrame:SetItem(specData.itemID, tintData.modifiedID); -- use default itemID
		end

		SetModelCamera(panel.modelFrame, cameraToUse);
		panel.modelFrame:SetAnimation(appearanceData.animation or 0); -- handles the funni demo lock artifact + druid shapeshifts
	end
end

-- combined refresh function for colors, tooltips, and locks
RefreshSwatches = function(frame)
	local panel = frame and frame.customPanel
	if not panel or not panel.swatchRows then return end
	local specID = frame.attachedItemID
	local specData = rat.AppSwatchData[specID]
	if not specData then return end

	local _, _, playerRaceID = UnitRace("player")
	local isTimerunner = PlayerGetTimerunningSeasonID() ~= nil
	
	local trackableAchievements = {
		[11152] = true, -- Dungeons
		[11153] = true, -- World Quests
		[11154] = true, -- Player Kills
	}

	for i, row in ipairs(panel.swatchRows) do
		-- check if tint exists
		local appearanceData = specData.appearances[i]
		local tintsToDisplay

		if appearanceData and appearanceData.tints then
			-- check if racial (druid)
			local hasRacialTints = false
			for _, tint in ipairs(appearanceData.tints) do
				if tint.raceIDs then
					hasRacialTints = true
					break
				end
			end

			if hasRacialTints then
				tintsToDisplay = {}
				-- add the matching racial tint
				for _, tint in ipairs(appearanceData.tints) do
					if tint.raceIDs then
						for _, raceID in ipairs(tint.raceIDs) do
							if raceID == playerRaceID then
								table.insert(tintsToDisplay, tint)
								break -- only add one
							end
						end
					end
				end
				-- add all non-racial tints
				for _, tint in ipairs(appearanceData.tints) do
					if not tint.raceIDs then
						table.insert(tintsToDisplay, tint)
					end
				end
			else
				-- no racial tints, use all of them
				tintsToDisplay = appearanceData.tints
			end
		else
			tintsToDisplay = {}
		end

		local isRowUnobtainable = false
		if tintsToDisplay[1] and tintsToDisplay[1].unobtainable and tintsToDisplay[1].req and not AreRequirementsMet(tintsToDisplay[1].req) then
			isRowUnobtainable = true
		end


		for k, swatchButton in ipairs(row) do
			local tintData = tintsToDisplay[k]

			swatchButton:SetShown(tintData ~= nil)

			if tintData then
				-- set the swatch data for the button
				swatchButton.swatchData = tintData;

				-- tint swatch color
				swatchButton.swatch:SetVertexColor(UISwatchColorToRGB(tintData.color));

				-- swatch locked
				local isUnobtainable = isRowUnobtainable or (isTimerunner and tintData.unobtainableRemix)
				swatchButton.unobtainable:SetShown(isUnobtainable)
				swatchButton.locked:SetShown(not isUnobtainable and tintData.req and not AreRequirementsMet(tintData.req))

				-- swatch tooltip
				if tintData.tooltip then
					swatchButton:SetScript("OnEnter", function(self)
						GameTooltip:SetOwner(self, "ANCHOR_TOP");
						if isTimerunner and tintData.unobtainableRemix then
							GameTooltip_AddErrorLine(GameTooltip, RATL["Unavailable"]);
						end
						if isRowUnobtainable then
							GameTooltip_AddErrorLine(GameTooltip, RATL["NoLongerAvailable"]);
						end
						GameTooltip_AddNormalLine(GameTooltip, tintData.tooltip);

						-- hidden artifact progress
						if tintData.req and tintData.req.achievements then
							local achID = tintData.req.achievements[1]
							if achID and trackableAchievements[achID] then
								-- check if the base appearance has been unlocked
								local baseTintUnlocked = false
								if tintsToDisplay[1] and tintsToDisplay[1].req then
									baseTintUnlocked = AreRequirementsMet(tintsToDisplay[1].req)
								else
									baseTintUnlocked = true
								end
								
								if baseTintUnlocked then
									local current, total = GetAchievementProgress(achID)
									if current and total then
										local progressText = string.format("\n(%d / %d)", current, total)
										GameTooltip:AddLine(progressText)
										GameTooltip:Show() -- refresh the tooltip to show the new line
									end
								end
							end
						end

						GameTooltip:Show();
					end)
					swatchButton:SetScript("OnLeave", GameTooltip_Hide);
				else
					swatchButton:SetScript("OnEnter", nil);
					swatchButton:SetScript("OnLeave", nil);
				end

				-- transmog collected
				if specData.itemID and tintData.modifiedID then
					local hasTransmog = C_TransmogCollection.PlayerHasTransmog(specData.itemID, tintData.modifiedID)
					
					if hasTransmog then
						-- appearance is learned
						swatchButton.transmogIcon:SetDesaturated(false)
						swatchButton.transmogIcon:Show()
					elseif not swatchButton.locked:IsShown() and not swatchButton.unobtainable:IsShown() then -- otherwise tons of false icons
						-- tint is unlocked, but not collected
						swatchButton.transmogIcon:SetDesaturated(true) -- trigger "requires relog" tooltip
						swatchButton.transmogIcon:Show()
					else
						-- not unlocked and not collected
						swatchButton.transmogIcon:Hide()
					end
				else
					swatchButton.transmogIcon:Hide()
				end
			end
		end
	end
end

-- combined refresh function for panel, including swatches
RefreshPanel = function(frame)
	if not frame or not frame.customPanel then return end

	-- sync with the main RemixArtifactFrame if not manually overridden by the dropdown
	if not frame.isOverridden and RemixArtifactFrame and RemixArtifactFrame.attachedItemID then
		frame.attachedItemID = RemixArtifactFrame.attachedItemID
	end
	
	if not frame.attachedItemID then return end
	
	local panel = frame.customPanel
	local specID = frame.attachedItemID
	local specData = rat.AppSwatchData[specID]
	if not specData then return end

	-- appearance row names
	if rat.ArtifactAppearanceNames[specID] then
		local appInfo = rat.ArtifactAppearanceNames[specID]
		for i, appnameFS in ipairs(panel.appNameFontStrings or {}) do
			appnameFS:SetText(WrapTextInColorCode(appInfo.appearances[i] or "", "FFE6CC80"));
		end
		if frame.tex then frame.tex:SetAtlas(appInfo.background or "Artifacts-DemonHunter-BG") end
		if panel.classicon then panel.classicon:SetAtlas(appInfo.icon or "Artifacts-DemonHunter-BG-rune") end
	end

	if panel.secondaryCheckbox then
		if specData.secondary then
			panel.secondaryCheckbox:Show();
		else
			panel.secondaryCheckbox:Hide();
			panel.showSecondary = false;
			panel.secondaryCheckbox:SetChecked(false);
		end
	end

	if panel.artifactSelectorDropdown then
		panel.artifactSelectorDropdown:GenerateMenu();
	end

	RefreshSwatches(frame);

	-- select the first swatch of the first row when opened
	if panel.swatchRows and panel.swatchRows[1] and panel.swatchRows[1][1] then
		SelectSwatch(panel.swatchRows[1][1]);
	end
end

-- setup the custom panel elements
SetupCustomPanel = function(frame)
	if frame.customPanel then return end
	local panel = CreateFrame("Frame", nil, frame);

	panel:SetScript("OnShow", RATFrame_OnShow);
	panel:SetScript("OnHide", RATFrame_OnHide);

	panel:SetAllPoints(true);
	panel:Hide();
	frame.customPanel = panel

	if frame == RemixStandaloneFrame then
		local closeButton = CreateFrame("Button", nil, panel, "UIPanelCloseButtonNoScripts");
		closeButton:SetPoint("TOPRIGHT", -8, -10);
		closeButton:SetScript("OnClick", function()
			frame:Hide();
			if RemixArtifactFrame then
				RemixArtifactFrame:Hide();
			end
		end);
	end

	panel.appNameFontStrings, panel.swatchRows = {}, {};
	panel:SetFrameLevel(frame:GetFrameLevel() + 10);

	-- 9-slice border + vignette
	local border = panel:CreateTexture(nil, "BORDER", nil, 7);
	border:SetPoint("TOPLEFT", -6, 6);
	border:SetPoint("BOTTOMRIGHT", 6, -6);
	border:SetAtlas("ui-frame-legionartifact-border");
	border:SetTextureSliceMargins(166, 166, 166, 166);
	border:SetTextureSliceMode(Enum.UITextureSliceMode.Tiled);

	local vignette = panel:CreateTexture(nil, "BACKGROUND", nil, 1);
	vignette:SetAllPoints();
	vignette:SetAtlas("Artifacts-BG-Shadow");

	local classicon = panel:CreateTexture(nil, "BACKGROUND", nil, 1);
	classicon:SetPoint("CENTER", -125, -200);
	classicon:SetSize(270, 270);
	classicon:SetAtlas("Artifacts-DemonHunter-BG-rune");
	panel.classicon = classicon;

	-- model
	panel.modelFrame = CreateFrame("PlayerModel", nil, panel);
	panel.modelFrame:SetPoint("TOPLEFT", panel, "TOP", -(frame:GetWidth()/6), -16);
	panel.modelFrame:SetPoint("BOTTOMRIGHT", -16, 16);
	panel.modelFrame:SetScript("OnModelLoaded", function(self)
		SetModelCamera(self, self.lastCamera);
	end);
	panel.modelFrame:SetScript("OnUpdate", function(self, elapsed)
		if not self.isSpinning then
			return
		end
		self.spinAngle = (self.spinAngle or 0) + (elapsed * 0.5);
		self:SetFacing(self.spinAngle);
	end);
	panel.modelFrame.isSpinning = true;

	local spinButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate");
	spinButton:SetSize(40, 40);
	spinButton:SetPoint("BOTTOM", 0, 50);
	spinButton.tex = spinButton:CreateTexture(nil, "ARTWORK");
	spinButton.tex:SetPoint("TOPLEFT", spinButton, "TOPLEFT", 7, -7);
	spinButton.tex:SetPoint("BOTTOMRIGHT", spinButton, "BOTTOMRIGHT", -7, 7);
	spinButton.tex:SetAtlas("CreditsScreen-Assets-Buttons-Pause");
	spinButton:SetScript("OnClick", function(self)
		panel.modelFrame.isSpinning = not panel.modelFrame.isSpinning;
		self.tex:SetAtlas(panel.modelFrame.isSpinning and "CreditsScreen-Assets-Buttons-Pause" or "CreditsScreen-Assets-Buttons-Play");
	end);

	-- displays secondary models ie druid weapons instead of shapeshift, offhands, etc.
	local secondaryCheckbox = CreateFrame("CheckButton", nil, panel, "UICheckButtonTemplate");
	secondaryCheckbox:SetPoint("LEFT", spinButton, "RIGHT", 10, 0);
	secondaryCheckbox.Text:SetText(RATL["ShowSecondary"]);
	panel.secondaryCheckbox = secondaryCheckbox;
	panel.showSecondary = false;
	secondaryCheckbox:SetScript("OnClick", function(self)
		panel.showSecondary = self:GetChecked();
		if panel.selectedSwatch then
			SelectSwatch(panel.selectedSwatch); -- refresh model
		end
	end);
	secondaryCheckbox:Hide();

	-- forge frame
	local forgebg = panel:CreateTexture(nil, "BACKGROUND", nil, 0);
	forgebg:SetPoint("TOPLEFT", 50, -100);
	forgebg:SetPoint("BOTTOMLEFT", 50, 100);
	forgebg:SetWidth(460);
	forgebg:SetAtlas("Forge-Background");

	-- forge border
	local borderFrame = CreateFrame("Frame", nil, panel)
	borderFrame:SetPoint("TOPLEFT", forgebg, -4, 4)
	borderFrame:SetPoint("BOTTOMRIGHT", forgebg, 4, -4)

	local bordercornersize = 64

	local bordertop = borderFrame:CreateTexture(nil, "ARTWORK", nil, 2)
	bordertop:SetPoint("TOPLEFT", 16, 0)
	bordertop:SetPoint("TOPRIGHT", -16, 0)
	bordertop:SetHeight(16)
	bordertop:SetAtlas("_ForgeBorder-Top", true)

	local borderbottom = borderFrame:CreateTexture(nil, "ARTWORK", nil, 2)
	borderbottom:SetPoint("BOTTOMLEFT", 16, 0)
	borderbottom:SetPoint("BOTTOMRIGHT", -16, 0)
	borderbottom:SetHeight(16)
	borderbottom:SetAtlas("_ForgeBorder-Top", true)
	borderbottom:SetTexCoord(0, 1, 1, 0) -- flip vertically

	local borderleft = borderFrame:CreateTexture(nil, "ARTWORK", nil, 2)
	borderleft:SetPoint("TOPLEFT", 0, -16)
	borderleft:SetPoint("BOTTOMLEFT", 0, 16)
	borderleft:SetWidth(16)
	borderleft:SetAtlas("!ForgeBorder-Right", true)
	borderleft:SetTexCoord(1, 0, 0, 1) -- flip horizontally

	local borderright = borderFrame:CreateTexture(nil, "ARTWORK", nil, 2)
	borderright:SetPoint("TOPRIGHT", 0, -16)
	borderright:SetPoint("BOTTOMRIGHT", 0, 16)
	borderright:SetWidth(16)
	borderright:SetAtlas("!ForgeBorder-Right", true)

	local bordertopleft = borderFrame:CreateTexture(nil, "ARTWORK", nil, 3)
	bordertopleft:SetPoint("TOPLEFT")
	bordertopleft:SetSize(bordercornersize, bordercornersize)
	bordertopleft:SetAtlas("ForgeBorder-CornerBottomLeft")
	bordertopleft:SetTexCoord(0, 1, 1, 0)

	local borderbottomleft = borderFrame:CreateTexture(nil, "ARTWORK", nil, 3)
	borderbottomleft:SetPoint("BOTTOMLEFT")
	borderbottomleft:SetSize(bordercornersize, bordercornersize)
	borderbottomleft:SetAtlas("ForgeBorder-CornerBottomLeft")

	local bordertopright = borderFrame:CreateTexture(nil, "ARTWORK", nil, 3)
	bordertopright:SetPoint("TOPRIGHT")
	bordertopright:SetSize(bordercornersize, bordercornersize)
	bordertopright:SetAtlas("ForgeBorder-CornerBottomRight")
	bordertopright:SetTexCoord(0, 1, 1, 0)

	local borderbottomright = borderFrame:CreateTexture(nil, "ARTWORK", nil, 3)
	borderbottomright:SetPoint("BOTTOMRIGHT")
	borderbottomright:SetSize(bordercornersize, bordercornersize)
	borderbottomright:SetAtlas("ForgeBorder-CornerBottomRight")
	
	local forgeTitle = panel:CreateFontString(nil, "OVERLAY", "Fancy24Font");
	forgeTitle:SetPoint("CENTER", forgebg, "TOP", 0, -60);
	forgeTitle:SetText(WrapTextInColorCode(ARTIFACTS_APPEARANCE_TAB_TITLE, "fff0b837"));

	-- appearance rows and swatches
	local MaxRows = 6;
	--if PlayerGetTimerunningSeasonID() then -- BLIZZORD LETS US COLLECT HIDDEN APPEARANCES
	--	MaxRows = 3;
	--end
	for i = 1, MaxRows do
		local appstrip = panel:CreateTexture(nil, "ARTWORK", nil, 1);
		local HeightSpacer = 150;
		if MaxRows == 6 then
			HeightSpacer = 95;
		end
		appstrip:SetPoint("TOPLEFT", forgebg, "TOPLEFT", 15, i*-HeightSpacer);
		appstrip:SetPoint("TOPRIGHT", forgebg, "TOPRIGHT", -15, i*-HeightSpacer);
		appstrip:SetHeight(103);
		appstrip:SetAtlas("Forge-AppearanceStrip");

		local appname = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge");
		appname:SetPoint("CENTER", forgebg, "TOPLEFT", 125, i*-HeightSpacer - 50);
		appname:SetSize(150, 100);
		appname:SetJustifyH("CENTER");
		appname:SetJustifyV("MIDDLE");
		appname:SetWordWrap(true);
		panel.appNameFontStrings[i] = appname;

		panel.swatchRows[i] = {};

		for k = 1, 4 do
			local apptint = CreateFrame("Button", nil, panel);
			apptint:SetSize(40, 40);
			apptint:SetPoint("CENTER", forgebg, "TOP", (k - 0.5) * 50, i*-HeightSpacer-50);

			apptint.rowIndex, apptint.tintIndex, apptint.parentFrame = i, k, frame;

			apptint.bg = apptint:CreateTexture(nil, "BACKGROUND", nil, 0);
			apptint.bg:SetAllPoints();
			apptint.bg:SetAtlas("Forge-ColorSwatchBackground");
			apptint.swatch = apptint:CreateTexture(nil, "ARTWORK", nil, 1);
			apptint.swatch:SetAllPoints();
			apptint.swatch:SetAtlas("Forge-ColorSwatch");
			apptint.border = apptint:CreateTexture(nil, "OVERLAY", nil, 2);
			apptint.border:SetAllPoints();
			apptint.border:SetAtlas("Forge-ColorSwatchBorder");
			apptint.highlight = apptint:CreateTexture(nil, "HIGHLIGHT", nil, 3);
			apptint.highlight:SetAllPoints();
			apptint.highlight:SetAtlas("Forge-ColorSwatchHighlight");
			apptint.selection = apptint:CreateTexture(nil, "OVERLAY", nil, 4);
			apptint.selection:SetAllPoints();
			apptint.selection:SetAtlas("Forge-ColorSwatchSelection");
			apptint.selection:Hide();
			apptint.locked = apptint:CreateTexture(nil, "OVERLAY", nil, 5);
			apptint.locked:SetAllPoints();
			apptint.locked:SetAtlas("Forge-Lock");
			apptint.locked:Hide();
			apptint.unobtainable = apptint:CreateTexture(nil, "OVERLAY", nil, 6);
			apptint.unobtainable:SetAllPoints();
			apptint.unobtainable:SetAtlas("Forge-UnobtainableCover");
			apptint.unobtainable:Hide();
			

			-- transmog collected icon
			apptint.transmogIcon = apptint:CreateTexture(nil, "OVERLAY", nil, 7);
			apptint.transmogIcon:SetSize(20, 20);
			apptint.transmogIcon:SetPoint("TOPRIGHT", 5, 5);
			apptint.transmogIcon:SetAtlas("Crosshair_Transmogrify_32");
			apptint.transmogIcon:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_TOP");
				if self:IsDesaturated() then -- transmog takes a relog for it to learn after tint is unlocked
					GameTooltip_AddErrorLine(GameTooltip, OPTION_LOGOUT_REQUIREMENT);
				else
					GameTooltip:SetText(TRANSMOGRIFY_TOOLTIP_APPEARANCE_KNOWN);
				end
				GameTooltip:Show();
			end);
			apptint.transmogIcon:SetScript("OnLeave", GameTooltip_Hide);
			apptint.transmogIcon:Hide();

			apptint:SetScript("OnClick", function(self)
				if self.selection:IsShown() and not self.locked:IsShown() then
					return;
				end
				SelectSwatch(self);
				PlaySound((self.locked:IsShown() or self.unobtainable:IsShown()) and SOUNDKIT.UI_70_ARTIFACT_FORGE_APPEARANCE_LOCKED or SOUNDKIT.UI_70_ARTIFACT_FORGE_APPEARANCE_COLOR_SELECT); -- 54131 or 54130
			end);
			panel.swatchRows[i][k] = apptint;
		end
	end
	if frame == RemixStandaloneFrame or isDebug then

		-- artifact select dropdown (might not be added to release version - instead filter to only current class)
		local function ArtifactSelector_GenerateMenu(_, rootDescription)
			local function SetSelected(data)
				frame.attachedItemID = data;
				-- set the override flag to true when user manually selects from dropdown
				frame.isOverridden = true;
				RefreshPanel(frame);
			end

			local function IsSelected(data)
				return data == frame.attachedItemID;
			end

			rootDescription:CreateTitle(RATL["Artifact"])

			local _, classToken = UnitClass("player")
			local classArtifacts = rat.ClassArtifacts and rat.ClassArtifacts[classToken]

			if classArtifacts and #classArtifacts > 0 then
				table.sort(classArtifacts);

				for _, specID in ipairs(classArtifacts) do
					local OldWeaponName = rat.AppSwatchData[specID].itemID
					local itemName = C_Item.GetItemNameByID(OldWeaponName) or ("Item " .. OldWeaponName);
					rootDescription:CreateRadio(itemName, IsSelected, SetSelected, specID);
				end
			else
				rootDescription:CreateTitle(RATL["Unavailable"]);
			end
		end

		-- artifact select dropdown (might not be added to release version - instead filter to only current class)
		local dropdown = CreateFrame("DropdownButton", nil, panel, "WowStyle1DropdownTemplate");
		dropdown:SetPoint("TOP", forgebg, "TOP", 0, -10);
		dropdown:SetWidth(300);
		dropdown:SetDefaultText(RATL["Artifact"]);
		dropdown:SetupMenu(ArtifactSelector_GenerateMenu);
		panel.artifactSelectorDropdown = dropdown;
		
		-- update the dropdown text once the item name is loaded from the server
		if not panel.itemInfoListener then
			local listener = CreateFrame("Frame")
			listener:RegisterEvent("GET_ITEM_INFO_RECEIVED")
			listener:SetScript("OnEvent", function(self, event, itemID)
				if not dropdown or not frame.attachedItemID then return end

				local currentArtifactData = rat.AppSwatchData[frame.attachedItemID]
				if currentArtifactData and currentArtifactData.itemID == itemID then
					local itemName = C_Item.GetItemNameByID(itemID)
					if itemName then
						dropdown:SetText(itemName)
					end
				end
			end)
			panel.itemInfoListener = listener
		end
	end
end
	
-- Tabs stuff
SelectRemixTab = function(tabID)
	PanelTemplates_SetTab(RemixArtifactFrame, tabID*2)
	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)

	if tabID == 1 then -- traits
		if RemixStandaloneFrame and RemixStandaloneFrame:IsShown() then
			RemixStandaloneFrame:Hide()
			RemixArtifactFrame:SetToplevel(true)
		end
	elseif tabID == 2 then -- appearances
		if not RemixStandaloneFrame then
			ToggleStandaloneFrame()
		end
		if not RemixArtifactFrame then return end

		RemixStandaloneFrame:ClearAllPoints()
		RemixStandaloneFrame:SetParent(RemixArtifactFrame)
		RemixStandaloneFrame:SetPoint("TOPLEFT", RemixArtifactFrame, "TOPLEFT")
		RemixStandaloneFrame:SetPoint("BOTTOMRIGHT", RemixArtifactFrame, "BOTTOMRIGHT")
		RemixArtifactFrame:SetToplevel(false)
		if RemixArtifactFrame.BorderContainer then
			RemixStandaloneFrame:SetFrameLevel(RemixArtifactFrame.BorderContainer:GetFrameLevel()+1)
		end
		RemixStandaloneFrame:Show()
	end
end

local function SetupRemixTabs()
	if not RemixArtifactFrame or RemixArtifactFrame.numTabs then
		return
	end

	RemixArtifactFrame.Tabs = {}
	local frameName = RemixArtifactFrame:GetName()

	-- traits
	local tab1 = CreateFrame("Button", frameName.."Tab1", RemixArtifactFrame, "PanelTabButtonTemplate")
	tab1:SetID(1)
	tab1:SetText(RATL["Traits"])
	tab1:SetPoint("TOPLEFT", RemixArtifactFrame, "BOTTOMLEFT", 20, 2)
	tab1:SetScript("OnClick", function(self) SelectRemixTab(self:GetID()) end)
	table.insert(RemixArtifactFrame.Tabs, tab1)

	-- appearances
	local tab2 = CreateFrame("Button", frameName.."Tab2", RemixArtifactFrame, "PanelTabButtonTemplate")
	tab2:SetID(2)
	tab2:SetText(RATL["Appearances"])
	tab2:SetPoint("TOPLEFT", tab1, "TOPRIGHT", 3, 0)
	tab2:SetScript("OnClick", function(self) SelectRemixTab(self:GetID()) end)
	table.insert(RemixArtifactFrame.Tabs, tab2)

	RemixArtifactFrame.numTabs = #RemixArtifactFrame.Tabs

	PanelTemplates_TabResize(tab1)
	PanelTemplates_TabResize(tab2)

	RemixArtifactFrame:HookScript("OnHide", function()
		if RemixStandaloneFrame and RemixStandaloneFrame:IsShown() then
			RemixStandaloneFrame:Hide()
		end
	end)
	
	SelectRemixTab(1)
end

local function OnSetTreeID()
	SetupRemixTabs()
	SelectRemixTab(1)
end

-- This function handles live updates when the artifact is changed in the main Remix frame.
local function OnArtifactTreeChanged()
	if RemixStandaloneFrame then
		-- An external change occurred, so we must disable the dropdown's override.
		RemixStandaloneFrame.isOverridden = false;
		-- Refresh the panel to sync with the new attachedItemID.
		RefreshPanel(RemixStandaloneFrame);
	end
end

EventRegistry:RegisterCallback("RemixArtifactFrame.SetTreeID", OnSetTreeID)
-- Register our new callback to listen for changes.
EventRegistry:RegisterCallback("RemixArtifactFrame.SetTreeID", OnArtifactTreeChanged)