--[[FACTION_BAR_COLORS = {
	[1] = { r= .54, g= 0,   b= 0   }, -- hated      {r = 0.63, g = 0, b = 0},
	[2] = { r= 1,   g= .1,  b= .1  }, -- hostile    {r = 0.63, g = 0, b = 0},
	[3] = { r= 1,   g= .55, b= 0   }, -- unfriendly {r = 0.63, g = 0, b = 0},
	[4] = { r= .87, g= .87, b= .87 }, -- neutral    {r = 0.82, g = 0.67, b = 0},
	[5] = { r= 1,   g= 1,   b= 0   }, -- friendly   {r = 0.32, g = 0.67, b = 0},
	[6] = { r= .1,  g= .9,  b= .1  }, -- honored    {r = 0.32, g = 0.67, b = 0},
	[7] = { r= .25, g= .41, b= .88 }, -- revered    {r = 0.32, g = 0.67, b = 0},
	[8] = { r= .6,  g= .2,  b= .8  }, -- exalted    {r = 0, g = 0.75, b = 0.44},
	[9] = { r= .4,  g= 0,   b= .6  }, -- past exalted
};]]

GOLD_AMOUNT = "|c00ffd700%d●|r";--GOLD_AMOUNT = "%d\124TInterface\\MoneyFrame\\UI-GoldIcon:0:0:2:0\124t"
SILVER_AMOUNT = "|c00c7c7cf%d●|r";--SILVER_AMOUNT = "%d\124TInterface\\MoneyFrame\\UI-SilverIcon:0:0:2:0\124t"
COPPER_AMOUNT = "|c00eda55f%d●|r";--COPPER_AMOUNT = "%d\124TInterface\\MoneyFrame\\UI-CopperIcon:0:0:2:0\124t"
ENTERING_COMBAT = "";
LEAVING_COMBAT = "";

CHAT_WHISPER_INFORM_GET = "<<%s:";
CHAT_WHISPER_GET = ">>%s:";
CHAT_BN_WHISPER_INFORM_GET = "<<%s:";
CHAT_BN_WHISPER_GET = ">>%s:";
CHAT_SAY_GET = "%s:";
CHAT_YELL_GET = "%s:"  ;
CHAT_FLAG_AFK = "[AFK]";
CHAT_FLAG_DND = "[Busy]";
CHAT_FLAG_GM = "[GM]";
  
----------------------------------------------- ## Title: Better Loot Message ## Author: Atila00 / Atiloa ## Version: 1.04
--ITEM_CREATED_BY="|cFF00DDFF<Thanks For Using 2 UI>|r";
CHAT_YOU_CHANGED_NOTICE = "=|Hchannel:%d|h[%s]|h";
CHAT_YOU_CHANGED_NOTICE_BN = "=|Hchannel:CHANNEL:%d|h[%s]|h";
CHAT_YOU_JOINED_NOTICE = "+|Hchannel:%d|h[%s]|h";
CHAT_YOU_JOINED_NOTICE_BN = "+|Hchannel:CHANNEL:%d|h[%s]|h";
CHAT_YOU_LEFT_NOTICE = "-|Hchannel:%d|h[%s]|h";
CHAT_YOU_LEFT_NOTICE_BN = "-|Hchannel:CHANNEL:%d|h[%s]|h";

--Self Loot
LOOT_ITEM_SELF = SHIGUANG_Loot.." %s";
LOOT_ITEM_SELF_MULTIPLE = SHIGUANG_Loot.." %sx%d";
LOOT_ITEM_BONUS_ROLL_SELF = "["..BONUS_REWARDS.."]: %s  ["..SCENARIO_BONUS_OBJECTIVES.."]";
LOOT_ITEM_BONUS_ROLL_SELF_MULTIPLE = "["..BONUS_REWARDS.."]: %sx%d ["..SCENARIO_BONUS_OBJECTIVES.."]";
LOOT_ITEM_CREATED_SELF = "["..CREATE_PROFESSION.."]: %s ["..SHIGUANG_Craft.."]";
LOOT_ITEM_CREATED_SELF_MULTIPLE = "["..CREATE_PROFESSION.."]: %sx%d ["..SHIGUANG_Craft.."]";

LOOT_ITEM_PUSHED_SELF = SHIGUANG_Loot.." %s";
LOOT_ITEM_PUSHED_SELF_MULTIPLE = SHIGUANG_Loot.." %sx%d";
LOOT_ITEM_REFUND = SHIGUANG_Refund.." %s";
LOOT_ITEM_REFUND_MULTIPLE = SHIGUANG_Refund.." %sx%d";

CURRENCY_GAINED = "["..BONUS_ROLL_REWARD_CURRENCY.."]: %s";
CURRENCY_GAINED_MULTIPLE = "["..BONUS_ROLL_REWARD_CURRENCY.."]: %sx%d";
CURRENCY_GAINED_MULTIPLE_BONUS = "["..BONUS_ROLL_REWARD_CURRENCY.."]: %sx%d ["..SCENARIO_BONUS_OBJECTIVES.."]"; 
CURRENCY_LOST_FROM_DEATH = SHIGUANG_Lost.." %sx%d";
BATTLE_PET_LOOT_RECEIVED = SHIGUANG_Gets.."";
LOOT_CURRENCY_REFUND = "["..BONUS_ROLL_REWARD_CURRENCY.."] %sx%d";
LOOT_DISENCHANT_CREDIT = SHIGUANG_Lost.."%s→%s ["..ROLL_DISENCHANT.."]";

--Other People's Loot
LOOT_ITEM = SHIGUANG_Gets.." %s→%s";
LOOT_ITEM_MULTIPLE = SHIGUANG_Gets.." %s %sx%d";
LOOT_ITEM_BONUS_ROLL = SHIGUANG_Gets.." %s→%s ["..SCENARIO_BONUS_OBJECTIVES.."]";
LOOT_ITEM_BONUS_ROLL_MULTIPLE = SHIGUANG_Gets.." %s %sx%d ["..SCENARIO_BONUS_OBJECTIVES.."]";
LOOT_ITEM_PUSHED = SHIGUANG_Gets.." %s %s";
LOOT_ITEM_PUSHED_MULTIPLE = SHIGUANG_Gets.." %s %sx%d";

LOOT_ITEM_WHILE_PLAYER_INELIGIBLE = SHIGUANG_Gets.." %s→|TInterface\\Common\\Icon-NoLoot:13:13:0:0|t%s"; 
CREATED_ITEM = SHIGUANG_Made.." %s→%s ["..SHIGUANG_Craft.."]";
CREATED_ITEM_MULTIPLE = SHIGUANG_Made.." %s→%sx%d ["..SHIGUANG_Craft.."]";
YOU_LOOT_MONEY = SHIGUANG_Loot.." %s";
YOU_LOOT_MONEY_GUILD = SHIGUANG_Loot.." %s [%s Guild]";
YOU_LOOT_MONEY_MOD = SHIGUANG_Loot.."%s（+%s）";
TRADESKILL_LOG_FIRSTPERSON = SHIGUANG_Made.." %s";
TRADESKILL_LOG_THIRDPERSON = SHIGUANG_Made.." %s→%s";

--[[COMBATLOG_XPGAIN_EXHAUSTION1 = "%s : +%d xp (%s bonus %s)";
COMBATLOG_XPGAIN_EXHAUSTION1_GROUP = "%s : +%d xp (%s bonus %s, +%d group)";
COMBATLOG_XPGAIN_EXHAUSTION1_RAID = "%s : +%d xp (%s bonus %s, -%d raid)";
COMBATLOG_XPGAIN_EXHAUSTION2 = "%s : +%d xp (%s bonus %s)";
COMBATLOG_XPGAIN_EXHAUSTION2_GROUP = "%s : +%d xp (%s bonus %s, +%d group)";
COMBATLOG_XPGAIN_EXHAUSTION2_RAID = "%s : +%d xp (%s bonus %s, -%d raid)";
COMBATLOG_XPGAIN_EXHAUSTION4 = "%s : +%d xp (%s penalty %s)";
COMBATLOG_XPGAIN_EXHAUSTION4_GROUP = "%s : +%d xp (%s penalty %s, +%d group)";
COMBATLOG_XPGAIN_EXHAUSTION4_RAID = "%s : +%d xp (%s xp %s, -%d raid)";
COMBATLOG_XPGAIN_EXHAUSTION5 = "%s : +%d xp (%s penalty %s)";
COMBATLOG_XPGAIN_EXHAUSTION5_GROUP = "%s : +%d xp (%s penalty %s, +%d group)";
COMBATLOG_XPGAIN_EXHAUSTION5_RAID = "%s : +%d xp (%s penalty %s, -%d raid)";
COMBATLOG_XPGAIN_FIRSTPERSON = "%s : +%d xp.";
COMBATLOG_XPGAIN_FIRSTPERSON_GROUP = "%s : +%d xp (+%d group)";
COMBATLOG_XPGAIN_FIRSTPERSON_RAID = "%s : +%d xp (-%d raid)";]]
