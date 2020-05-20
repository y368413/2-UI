local _, ns = ...
local M, R, U, I = unpack(ns)
local module = M:GetModule("AurasTable")

-- 角标的相关法术 [spellID] = {anchor, {r, g, b}}
R.CornerBuffs = {
	["PRIEST"] = {
		[194384] = {"TOPRIGHT", {1, 1, .66}},			-- 救赎
		[214206] = {"TOPRIGHT", {1, 1, .66}},			-- 救赎(PvP)
		[41635]  = {"BOTTOMRIGHT", {.2, .7, .2}},		-- 愈合导言
		[193065] = {"BOTTOMRIGHT", {.54, .21, .78}},	-- 忍辱负重
		[139]    = {"TOPLEFT", {.4, .7, .2}},			-- 恢复
		[17]     = {"TOPLEFT", {.7, .7, .7}},			-- 真言术盾
		[47788]  = {"LEFT", {.86, .45, 0}, true},		-- 守护之魂
		[33206]  = {"LEFT", {.47, .35, .74}, true},		-- 痛苦压制
		[6788]  = {"TOP", {.86, .11, .11}, true},		-- 虚弱灵魂
	},
	["DRUID"] = {
		[774]    = {"TOPRIGHT", {.8, .4, .8}},			-- 回春
		[155777] = {"RIGHT", {.8, .4, .8}},				-- 萌芽
		[8936]   = {"BOTTOMLEFT", {.2, .8, .2}},		-- 愈合
		[33763]  = {"TOPLEFT", {.4, .8, .2}},			-- 生命绽放
		[48438]  = {"BOTTOMRIGHT", {.8, .4, 0}},		-- 野性成长
		[207386] = {"TOP", {.4, .2, .8}},				-- 春暖花开
		[102351] = {"LEFT", {.2, .8, .8}},				-- 结界
		[102352] = {"LEFT", {.2, .8, .8}},				-- 结界(HoT)
		[200389] = {"BOTTOM", {1, 1, .4}},				-- 栽培
	},
	["PALADIN"] = {
		[287280]  = {"TOPLEFT", {1, .8, 0}},			-- 圣光闪烁
		[53563]  = {"TOPRIGHT", {.7, .3, .7}},			-- 道标
		[156910] = {"TOPRIGHT", {.7, .3, .7}},			-- 信仰道标
		[200025] = {"TOPRIGHT", {.7, .3, .7}},			-- 美德道标
		[1022]   = {"BOTTOMRIGHT", {.2, .2, 1}, true},	-- 保护
		[1044]   = {"BOTTOMRIGHT", {.89, .45, 0}, true},-- 自由
		[6940]   = {"BOTTOMRIGHT", {.89, .1, .1}, true},-- 牺牲
		[223306] = {"BOTTOMLEFT", {.7, .7, .3}},		-- 赋予信仰
		[25771]  = {"TOP", {.86, .11, .11}, true},		-- 自律
	},
	["SHAMAN"] = {
		[61295]  = {"TOPRIGHT", {.2, .8, .8}},			-- 激流
		[974]    = {"BOTTOMRIGHT", {1, .8, 0}},			-- 大地之盾
		[207400] = {"BOTTOMLEFT", {.6, .8, 1}},			-- 先祖活力
	},
	["MONK"] = {
		[119611] = {"TOPLEFT", {.3, .8, .6}},			-- 复苏之雾
		[116849] = {"TOPRIGHT", {.2, .8, .2}, true},	-- 作茧缚命
		[124682] = {"BOTTOMLEFT", {.8, .8, .25}},		-- 氤氲之雾
		[191840] = {"BOTTOMRIGHT", {.27, .62, .7}},		-- 精华之泉
	},
	["ROGUE"] = {
		[57934]  = {"BOTTOMRIGHT", {.9, .1, .1}},		-- 嫁祸
	},
	["WARRIOR"] = {
		[114030] = {"TOPLEFT", {.2, .2, 1}},			-- 警戒
	},
	["HUNTER"] = {
		[34477]  = {"BOTTOMRIGHT", {.9, .1, .1}},		-- 误导
		[90361]  = {"TOPLEFT", {.4, .8, .2}},			-- 灵魂治愈
	},
	["WARLOCK"] = {
		[20707]  = {"BOTTOMRIGHT", {.8, .4, .8}, true},	-- 灵魂石
	},
	["DEMONHUNTER"] = {},
	["MAGE"] = {},
	["DEATHKNIGHT"] = {},
}

-- 小队框体的技能监控CD [spellID] = duration in seconds
R.PartysSpells = {
	[57994]  = 12,	-- 风剪
	[1766]   = 15,	-- 脚踢
	[6552]   = 15,	-- 拳击
	[47528]  = 15,	-- 心灵冰冻
	[96231]  = 15,	-- 责难
	[106839] = 15,	-- 迎头痛击
	[116705] = 15,	-- 切喉手
	[183752] = 15,	-- 瓦解
	[187707] = 15,	-- 压制
	[2139]   = 24,	-- 法术反制
	[147362] = 24,	-- 反制射击
	[15487]  = 45,	-- 沉默
	[109248] = 45,	-- 束缚射击
	[78675]  = 60,	-- 日光术

	[8143]	 = 60,	-- 战栗图腾
	[102342] = 60,	-- 铁木树皮
	[102793] = 60,	-- 乌索尔旋风
	[119381] = 60,	-- 扫堂腿
	[179057] = 60,	-- 混乱新星
	[205636] = 60,	-- 树人
	[31224]  = 120,	-- 暗影斗篷
	[25046]  = 120,	-- 奥术洪流
	[28730]  = 120,
	[50613]  = 120,
	[69179]  = 120,
	[80483]  = 120,
	[129597] = 120,
	[155145] = 120,
	[202719] = 120,
	[232633] = 120,
    --["DEATHKNIGHT"] = { -- 250(Blood), 251(Frost), 252(Unholy)
        [47482] = 30,  --type = "interrupt", spec = { 252 } },
        [47528] = 15,  --type = "interrupt"               },
        [108194] = 45,  --type = "cc",        spec = true  },
        [221562] = 45,  --type = "cc",        spec = { 250 } },
        [207167] = 60,  --type = "cc",        spec = true  },
        --[49576] = { default = 25, [250] = 15 }, --type = "cc" },
        [108199] = 120, --type = "cc",        spec = { 250 } },
        [47481] = 90,  --type = "cc",        spec = { 252 } },
        [287250] = 45,  --type = "cc",        spec = true, parent = 196770 },
        [47476] = 60,  --type = "cc",        spec = true  },
        [48707] = 60,  --type = "defensive", default = true },
        [51052] = 120, --type = "defensive", spec = true, default = true },
        [194844] = 60,  --type = "defensive", spec = true  },
        [274156] = 45,  --type = "defensive", spec = true  },
        [49028] = 120, --type = "defensive", spec = { 250 } },
        [48743] = 120, --type = "defensive", spec = true  },
        [48792] = 180, --type = "defensive", default = true },
        [287081] = 60,  --type = "defensive", spec = true, default = true, parent = 48792 },
        [114556] = 240, --type = "defensive", spec = true  },
        [219809] = 60,  --type = "defensive", spec = true  },
        [55233] = 90,  --type = "defensive", spec = { 250 } },
        [275699] = 90,  --type = "offensive", spec = { 252 } },
        [42650] = 480, --type = "offensive", spec = { 252 } },
        [288853] = 90,  --type = "offensive", spec = true, parent = 42650 },
        [152279] = 120, --type = "offensive", spec = true  },
        [63560] = 60,  --type = "offensive", spec = { 252 } },
        [47568] = 120, --type = "offensive", spec = { 251 } },
        [279302] = 180, --type = "offensive", spec = true  },
        [51271] = 45,  --type = "offensive", spec = { 251 } },
        [130736] = 45,  --type = "offensive", spec = true  },
        [49206] = 180, --type = "offensive", spec = true  },
        [207289] = 75,  --type = "offensive", spec = true  },
        [77606] = 20,  --type = "others",    spec = true  },
        [48265] = 45,  --type = "others"                  },
        [196770] = 20,  --type = "others",    spec = { 251 } },
        [212552] = 60,  --type = "others",    spec = true  },
    --},
    --["DEMONHUNTER"] = { -- 577(Havoc), 581(Vengeance)
        [183752] = 15,  --type = "interrupt" },
        [179057] = 60,  --type = "cc",        spec = { 577 } },
        [211881] = 30,  --type = "cc",        spec = true  },
        [205630] = 60,  --type = "cc",        spec = true  },
        [217832] = 45,  --type = "cc"                      },
        [205596] = 60,  --type = "cc",        spec = true, parent = 217832 },
        [202138] = 90,  --type = "cc",        spec = true  },
        [207684] = 90,  --type = "cc",        spec = { 581 } },
        [202137] = 60,  --type = "cc",        spec = { 581 } },
        [196555] = 120, --type = "immunity",  spec = true, default = true },
        [198589] = 60,  --type = "defensive", spec = { 577 }, default = true },
        [196718] = 180, --type = "defensive", spec = { 577 } },
        [227635] = 180, --type = "defensive", spec = true, parent = 196718, default = true },
        [204021] = 60,  --type = "defensive", spec = { 581 } },
        [209258] = 480, --type = "defensive", spec = true  },
        [206803] = 60,  --type = "defensive", spec = true  },
        [206649] = 45,  --type = "offensive", spec = true  },
        [258925] = 60,  --type = "offensive", spec = true  },
        [203704] = 60,  --type = "offensive", spec = true  },
        [200166] = 240, --type = "offensive", spec = { 577 } },
        [187827] = 180, --type = "defensive", spec = { 581 } },
        [206491] = 120, --type = "offensive", spec = true  },
        [205629] = 20,  --type = "others",    spec = true, charges = 2 },
        [205604] = 60,  --type = "others",    spec = true, default = true },
    --},
    --["DRUID"] = { -- 102(Bal), 103(Feral), 104(Guardian), 105(Resto)
        [106839] = 15,  --type = "interrupt", spec = { 103, 104 } },
        [78675] = 60,  --type = "interrupt", spec = { 102 }, default = true },
        [88423] = 8,   --type = "interrupt", spec = { 105 } },
        [99] = 30,  --type = "cc",        spec = { 104 } },
        [102359] = 30,  --type = "cc",        spec = true  },
        [5211] = 50,  --type = "cc",        spec = true  },
        [202246] = 25,  --type = "cc",        spec = true  },
        [132469] = 30,  --type = "cc",        spec = true  },
        [102793] = 60,  --type = "cc",        spec = { 105 } },
        [102793] = 60,  --type = "cc",        spec = true  },
        --[22812] = { default = 60, [104] = 90 }, --type = "defensive", spec = { 102, 104, 105 }, default = true },
        [201664] = 30,  --type = "defensive", spec = true  },
        [209749] = 30,  --type = "defensive", spec = true  },
        [197491] = 30,  --type = "defensive", spec = true  },
        [217615] = 30,  --type = "defensive", spec = true  },
        [22842] = 30,  --type = "defensive", spec = { 104 }, charges = 2 },
        [102342] = 60,  --type = "defensive", spec = { 105 }, default = true },
        [108238] = 90,  --type = "defensive", spec = true, default = true },
        --[61336] = { default = 120, [104] = 240 }, --type = "defensive", spec = { 103, 104 }, charges = 2, default = true },
        [305497] = 45,  --type = "defensive", spec = true  },
        [106951] = 180, --type = "offensive", spec = { 103 } },
        [194223] = 180, --type = "offensive", spec = { 102 } },
        [202770] = 60,  --type = "offensive", spec = true  },
        [102560] = 180, --type = "offensive", spec = true, parent = 194223 },
        [102558] = 180, --type = "offensive", spec = true  },
        [102543] = 180, --type = "offensive", spec = true, parent = 106951 },
        [33891] = 180, --type = "offensive", spec = true, default = true },
        [203651] = 45,  --type = "offensive", spec = true  },
        [5217] = 30,  --type = "offensive", spec = { 103 } },
        [740] = 180, --type = "offensive", spec = { 105 } },
        [202425] = 45,  --type = "offensive", spec = true  },
        [1850] = 120, --type = "others"                  },
        [252216] = 45,  --type = "others",    spec = true, parent = 1850 },
        [205636] = 60,  --type = "others",    spec = true  },
        [29166] = 180, --type = "others",    spec = { 102, 105 } },
        --[77761] = { default = 120, [104] = 60 }, --type = "others", spec = { 103, 104 } },
    --},
    --["HUNTER"] = { -- 253(BM), 254(MM), 255(SV)
        [147362] = 24,  --type = "interrupt", spec = { 253, 254 } },
        [187707] = 15,  --type = "interrupt", spec = { 255 } },
        [109248] = 45,  --type = "cc",        spec = true  },
        [186387] = 30,  --type = "cc",        spec = { 254 } },
        [187650] = 30,  --type = "cc", default = true },
        [203340] = 30,  --type = "cc", default = true, spec = true, parent = 187650 },
        [236776] = 40,  --type = "cc",        spec = true  },
        [19577] = 60,  --type = "cc",        spec = { 253, 255 } },
        [213691] = 30,  --type = "cc",        spec = true  },
        [202914] = 45,  --type = "cc",        spec = true  },
        [186265] = 180, --type = "immunity", default = true },
        [109304] = 120, --type = "defensive", default = true },
        [248518] = 45,  --type = "defensive", spec = true, parent = 34477 },
        [212640] = 25,  --type = "defensive", spec = true  },
        [53480] = 60,  --type = "defensive", spec = true  },
        [131894] = 60,  --type = "offensive", spec = true  },
        [186289] = 90,  --type = "offensive", spec = { 255 } },
        [193530] = 120, --type = "offensive", spec = { 253 } },
        [19574] = 90,  --type = "offensive", spec = { 253 } },
        [266779] = 120, --type = "offensive", spec = { 255 } },
        [205691] = 120, --type = "offensive", spec = true  },
        [260402] = 60,  --type = "offensive", spec = true  },
        [194407] = 90,  --type = "offensive", spec = true  },
        [288613] = 120, --type = "offensive", spec = { 254 } },
        [186257] = 180, --type = "others"                  },
        [199483] = 60,  --type = "others",    spec = true  },
        [272651] = 45,  --type = "others"                  },
        [34477] = 30,  --type = "others",    spec = {253, 254} },
    --},
    --["MAGE"] = { -- 62(Arcane), 63(Fire), 64(Frost)
        [2139] = 24,  --type = "interrupt"              },
        [31661] = 20,  --type = "cc",        spec = { 63 } },
        [113724] = 45,  --type = "cc",        spec = true },
        [45438] = 240, --type = "immunity", default = true },
        [86949] = 300, --type = "defensive", spec = { 63 } },
        [235219] = 300, --type = "defensive", spec = { 64 }, default = true },
        [110960] = 120, --type = "defensive", spec = { 62 } },
        [198158] = 60,  --type = "defensive", spec = true },
        [198111] = 45,  --type = "defensive", spec = true, default = true },
        [153626] = 20,  --type = "offensive", spec = true },
        [12042] = 90,  --type = "offensive", spec = { 62 } },
        [205032] = 40,  --type = "offensive", spec = true },
        [190319] = 120, --type = "offensive", spec = { 63 } },
        [153595] = 30,  --type = "offensive", spec = true },
        [257537] = 45,  --type = "offensive", spec = true },
        [84714] = 60,  --type = "offensive", spec = { 64 } },
        [12472] = 180, --type = "offensive", spec = { 64 } },
        [198144] = 60,  --type = "offensive", spec = true, parent = 12472 },
        [153561] = 45,  --type = "offensive", spec = true },
        [55342] = 120, --type = "offensive", spec = true },
        [205025] = 60,  --type = "offensive", spec = { 62 } },
        [205021] = 75,  --type = "offensive", spec = true },
        [116011] = 40,  --type = "offensive", spec = true, charges = 2 },
        [80353] = 300, --type = "offensive", pve = true },
        [1953] = 15,  --type = "others"                 },
        [212653] = 20,  --type = "others",    spec = true, charges = 2, parent = 1953 },
        [33395] = 25,  --type = "others",    spec = { 64 } },
        [122] = 30,  --type = "others"                 },
        [108839] = 20,  --type = "others",    spec = true, charges = 3 },
        [198100] = 30,  --type = "others",    spec = true },
        [205024] = 0,   --type = "others",    spec = true, parent = 33395, hide = true },
    --},
    --["MONK"] = { -- 268(BM), 269(WW), 270(MW)
        [116705] = 15,  --type = "interrupt", spec = { 268, 269 } },
        [115450] = 8,   --type = "interrupt", spec = { 270 } },
        [202335] = 45,  --type = "cc",        spec = true  },
        [119381] = 60,  --type = "cc"                      },
        [202370] = 30,  --type = "cc",        spec = true  },
        [115078] = 45,  --type = "cc"                      },
        [116844] = 45,  --type = "cc",        spec = true  },
        [198898] = 30,  --type = "cc",        spec = true  },
        [116849] = 120, --type = "immunity",  spec = { 270 }, default = true },
        [122470] = 90,  --type = "immunity",  spec = { 269 }, default = true },
        [202162] = 45,  --type = "defensive", spec = true  },
        [115399] = 120, --type = "defensive", spec = true  },
        [122278] = 120, --type = "defensive", spec = true  },
        [122783] = 90,  --type = "defensive", spec = true, default = true },
        [115203] = 420, --type = "defensive", spec = { 268 } },
        [243435] = 90,  --type = "defensive", spec = { 270 } },
        [201318] = 90,  --type = "defensive", spec = true  },
        [233759] = 45,  --type = "defensive", spec = true  },
        [132578] = 180, --type = "defensive", spec = true  },
        [119996] = 45,  --type = "defensive"               },
        [115176] = 300, --type = "defensive", spec = { 268 } },
        [123904] = 120, --type = "offensive", spec = true  },
        [198664] = 180, --type = "offensive", spec = true  },
        [115310] = 180, --type = "offensive", spec = { 270 } },
        [137639] = 90,  --type = "offensive", spec = { 269 }, charges = 2 },
        [152173] = 90,  --type = "offensive", spec = true, parent = 137639 },
        [115080] = 120, --type = "offensive", spec = { 269 } },
        [216113] = 60,  --type = "offensive", spec = true, default = true },
        [101545] = 25,  --type = "others",    spec = { 269 } },
        [109132] = 20,  --type = "others", charges = 2 },
        [115008] = 20,  --type = "others",    spec = true, charges = 2, parent = 109132 },
        [116841] = 30,  --type = "others",    spec = true  },
        [209584] = 45,  --type = "others",    spec = true  },
    --},
    --["PALADIN"] = { -- 65(Holy), 66(Prot), 70(Ret)
        [96231] = 15,  --type = "interrupt", spec = { 66, 70 } },
        [215652] = 45,  --type = "interrupt", spec = true },
        [4987] = 8,   --type = "interrupt", spec = { 65 } },
        [115750] = 90,  --type = "cc",        spec = true },
        [853] = 60,  --type = "cc"                     },
        [20066] = 15,  --type = "cc",         spec = true },
        [642] = 300, --type = "immunity", default = true },
        [204150] = 180, --type = "defensive", spec = true },
        [31850] = 85,  --type = "defensive", spec = { 66 } },
        [31821] = 180, --type = "defensive", spec = { 65 } },
        [1022] = 300, --type = "defensive"              },
        [204018] = 180, --type = "defensive", spec = true, parent = 1022 },
        [6940] = 120, --type = "defensive", spec = { 65, 66 } },
        [199452] = 120, --type = "immunity",  spec = true, default = true, parent = 6940 },
        [498] = 60,  --type = "defensive", spec = { 65 } },
        [205191] = 60,  --type = "defensive", spec = true },
        [86659] = 300, --type = "defensive", spec = { 66 } },
        [228049] = 180, --type = "immunity",  spec = true, parent = 86659 },
        [184662] = 120, --type = "defensive", spec = { 70 } },
        [31884] = 120, --type = "offensive"              },
        [216331] = 120, --type = "offensive", spec = true, parent = 31884 },
        [231895] = 120, --type = "offensive", spec = true, parent = 31884 },
        [105809] = 90,  --type = "offensive", spec = true },
        [255937] = 45,  --type = "offensive", spec = true },
        [1044] = 25,  --type = "others"                 },
        [210256] = 45,  --type = "others",    spec = true, default = true },
        [210294] = 25,  --type = "others",    spec = true },
        [190784] = 45,  --type = "others"                 },
    --},
    --["PRIEST"] = { -- 256(Disc), 257(Holy), 258(Shadow)
        [527] = 8,   --type = "interrupt", spec = { 256, 257 } },
        [88625] = 60,  --type = "cc",        spec = { 257 } },
        [64044] = 45,  --type = "cc",        spec = true  },
        [8122] = 60,  --type = "cc", default = true },
        [205369] = 30,  --type = "cc",        spec = true, parent = 8122 },
        [204263] = 45,  --type = "cc",        spec = true  },
        [15487] = 45,  --type = "cc",        spec = { 258 } },
        [213602] = 45,  --type = "immunity",  spec = true  },
        [197268] = 60,  --type = "immunity",  spec = true, default = true },
        [47585] = 120, --type = "defensive", spec = { 258 }, default = true },
        [47788] = 180, --type = "defensive", spec = { 257 }, default = true },
        [33206] = 180, --type = "defensive", spec = { 256 }, default = true },
        [62618] = 180, --type = "defensive", spec = { 256 } },
        [271466] = 180, --type = "defensive", spec = true, parent = 62618 },
        [197590] = 90,  --type = "defensive", spec = true, parent = 62618, parent2 = 271466, default = true },
        [15286] = 120, --type = "defensive", spec = { 258 } },
        [108968] = 300, --type = "defensive", spec = true, default = true },
        [200183] = 120, --type = "offensive", spec = true  },
        [197862] = 60,  --type = "offensive", spec = true  },
        [197871] = 60,  --type = "offensive", spec = true  },
        [280711] = 60,  --type = "offensive", spec = true  },
        [19236] = 90,  --type = "offensive", spec = { 256, 257} },
        [64843] = 180, --type = "offensive", spec = { 257 } },
        [265202] = 720, --type = "offensive", spec = true  },
        [34861] = 60,  --type = "offensive", spec = { 257 } },
        [2050] = 60,  --type = "offensive", spec = { 257 } },
        [211522] = 45,  --type = "offensive", spec = true  },
        [47536] = 90,  --type = "offensive", spec = { 256 } },
        [215982] = 180, --type = "offensive", spec = true  },
        [193223] = 180, --type = "offensive", spec = true  },
        [263165] = 45,  --type = "offensive", spec = true  },
        [213610] = 30,  --type = "others",    spec = true  },
        [289657] = 44,  --type = "others",    spec = true  },
        [73325] = 90,  --type = "others"                  },
        [32375] = 45,  --type = "others"                  },
        [305498] = 12,  --type = "others",    spec = true  },
        [64901] = 300, --type = "others",    spec = { 257 } },
    --},
    --["ROGUE"] = { -- 259(Assa), 260(Combat), 261(Sub)
        [1766] = 15,  --type = "interrupt"               },
        [199804] = 30,  --type = "cc",        spec = { 260 } },
        [2094] = 120, --type = "cc"                      },
        [408] = 20,  --type = "cc",        spec = { 259, 261 } },
        [207736] = 120, --type = "cc",        spec = true  },
        [212182] = 180, --type = "cc",        spec = true  },
        [31230] = 360, --type = "defensive", spec = true  },
        [31224] = 120, --type = "defensive", default = true },
        [207777] = 45,  --type = "defensive", spec = true  },
        [5277] = 120, --type = "defensive", spec = { 259, 261 }, default = true },
        [199754] = 120, --type = "defensive", spec = { 260 }, default = true },
        [1856] = 120, --type = "defensive"               },
        [13750] = 180, --type = "offensive", spec = { 260 } },
        [213981] = 60,  --type = "offensive", spec = true  },
        [200806] = 45,  --type = "offensive", spec = true  },
        [51690] = 120, --type = "offensive", spec = true  },
        --[137619] = { default = 30, [260] = 60 }, --type = "offensive", spec = true },
        [198529] = 120, --type = "offensive", spec = true  },
        [121471] = 180, --type = "offensive", spec = { 261 } },
        [185313] = 60,  --type = "offensive", spec = { 261 }, charges = 2 },
        [221622] = 30,  --type = "offensive", spec = true, parent = 57934 },
        [79140] = 120, --type = "offensive", spec = { 259 } },
        [195457] = 60,  --type = "others",    spec = { 260 } },
        [36554] = 30,  --type = "others",    spec = { 259, 261 }, charges = { [261] = 2, default = 1 } },
        [114018] = 360, --type = "others"                  },
        [2983] = 60,  --type = "others"                  },
        [57934] = 30,  --type = "others"                  },
    --},
    --["SHAMAN"] = { -- 262(Ele), 263(Enh), 264(Resto)
        [57994] = 12,  --type = "interrupt"               },
        [77130] = 8,   --type = "interrupt", spec = { 264 } },
        [192058] = 60,  --type = "cc"                      },
        [51514] = 30,  --type = "cc"                      },
        [305483] = 30,  --type = "cc",        spec = true  },
        [197214] = 40,  --type = "cc",        spec = true  },
        [51490] = 45,  --type = "cc",        spec = { 262 } },
        [204403] = 30,  --type = "cc",        spec = true, parent = 51490 },
        [108281] = 120, --type = "defensive", spec = { 262 } },
        [207399] = 300, --type = "defensive", spec = true  },
        [108271] = 90,  --type = "defensive",              default = true },
        [198838] = 60,  --type = "defensive", spec = true, default = true },
        [210918] = 60,  --type = "defensive", spec = true, default = true, parent = 108271 },
        [98008] = 180, --type = "defensive", spec = { 264 }, default = true },
        [114050] = 180, --type = "offensive", spec = true  },
        [114051] = 180, --type = "offensive", spec = true  },
        [114052] = 180, --type = "offensive", spec = true  },
        [2825] = 300, --type = "offensive",              pve = true },
        [193876] = 60,  --type = "offensive", spec = true, parent = 2825 },
        [51533] = 120, --type = "offensive", spec = { 263 } },
        [108280] = 180, --type = "offensive", spec = { 264 } },
        [210714] = 30,  --type = "offensive", spec = true  },
        [204330] = 40,  --type = "offensive", spec = true  },
        [191634] = 60,  --type = "offensive", spec = true  },
        [204331] = 45,  --type = "others",    spec = true  },
        [198103] = 300, --type = "others"                  },
        [2484] = 30,  --type = "others"                  },
        [51485] = 30,  --type = "others",    spec = true  },
        [198067] = 150, --type = "others",    spec = { 262 } },
        [196884] = 30,  --type = "others",    spec = true  },
        [204336] = 30,  --type = "others",    spec = true, default = true },
        [79206] = 120, --type = "others",    spec = { 264 } },
        [58875] = 60,  --type = "others",    spec = { 263 } },
        [8143] = 60,  --type = "others"                  },
        [192077] = 120, --type = "others",    spec = true  },
    --},
    --["WARLOCK"] = { -- 265(Aff), 266(Demo), 267(Dest)
        [119898] = 24,  --type = "interrupt"               },
        [212619] = 24,  --type = "interrupt", spec = true  },
        [111898] = 90,  --type = "cc",        spec = true  },
        [6789] = 45,  --type = "cc",        spec = true  },
        [30283] = 60,  --type = "cc"                      },
        [108416] = 60,  --type = "defensive", spec = true  },
        [268358] = 30,  --type = "defensive", spec = true, default = true },
        [104773] = 180, --type = "defensive", default = true },
        [201996] = 90,  --type = "offensive", spec = true  },
        [212459] = 90,  --type = "offensive", spec = true  },
        [113860] = 120, --type = "offensive", spec = true  },
        [113858] = 120, --type = "offensive", spec = true  },
        [267171] = 60,  --type = "offensive", spec = true  },
        [267217] = 180, --type = "offensive", spec = true  },
        [205180] = 180, --type = "offensive", spec = { 265 } },
        [265187] = 90,  --type = "offensive", spec = { 266 } },
        [1122] = 180, --type = "offensive", spec = { 267 } },
        [264119] = 45,  --type = "offensive", spec = true  },
        [221703] = 60,  --type = "others",    spec = true  },
        [199954] = 45,  --type = "others",    spec = true  },
        [80240] = 30,  --type = "others",    spec = { 267 } },
        [200546] = 45,  --type = "others",    spec = true, parent = 80240 },
        [212295] = 45,  --type = "others",    spec = true  },
    --},
    --["WARRIOR"] = { -- 71(Arms), 72(Fury), 73(Prot)
        [6552] = 15,  --type = "interrupt"              },
        [5246] = 90,  --type = "cc", default = true },
        [46968] = 40,  --type = "cc",        spec = { 73 } },
        [107570] = 30,  --type = "cc",        spec = true },
        [1160] = 45,  --type = "defensive", spec = { 73 } },
        [118038] = 180, --type = "defensive", spec = { 71 }, default = true },
        [236077] = 45,  --type = "defensive", spec = true },
        [184364] = 120, --type = "defensive", spec = { 72 }, default = true },
        [12975] = 120, --type = "defensive", spec = { 73 } },
        [97462] = 180, --type = "defensive"              },
        [871] = 240, --type = "defensive", spec = { 73 } },
        [107574] = 90,  --type = "offensive", spec = { 73 } },
        [107574] = 90,  --type = "offensive", spec = true },
        [227847] = 90,  --type = "offensive", spec = { 71 } },
        [46924] = 60,  --type = "offensive", spec = true },
        [152277] = 60,  --type = "offensive", spec = true, parent = 227847 },
        [228920] = 60,  --type = "offensive", spec = true },
        [167105] = 45,  --type = "offensive", spec = { 71 } },
        [262161] = 45,  --type = "offensive", spec = true, parent = 167105 },
        [118000] = 35,  --type = "offensive", spec = true },
        [1719] = 90,  --type = "offensive", spec = { 72 } },
        [198817] = 25,  --type = "offensive", spec = true },
        [280772] = 30,  --type = "offensive", spec = true },
        [18499] = 60,  --type = "others"                 },
        [236273] = 60,  --type = "others",    spec = true },
        [6544] = 45,  --type = "others"                 },
        [216890] = 25,  --type = "others",    spec = true },
        [23920] = 25,  --type = "others",    spec = { 73 } },
        [213915] = 30,  --type = "others",    spec = true, parent = 23920 },
        [236320] = 90,  --type = "others",    spec = true, default = true },
    --},
    --["TRINKET"] = {
        [208683] = 120, --type = "trinket",   spec = true, default = true },
        [214027] = 60,  --type = "trinket",   spec = true, default = true },
        [196029] = 0,   --type = "trinket",   spec = true, default = true },
        [195710] = 180, --type = "trinket",                default = true },
    --},
    --["RACIAL"] = {
        [59752] = 180, --type = "racial",    race =  1 },
        [20572] = 120, --type = "racial",    race =  2 },
        [20594] = 120, --type = "racial",    race =  3 },
        [58984] = 120, --type = "racial",    race =  4 },
        [7744] = 120, --type = "racial",    race =  5 },
        [20549] = 90,  --type = "racial",    race =  6 },
        [20589] = 60,  --type = "racial",    race =  7 },
        [26297] = 180, --type = "racial",    race =  8 },
        [69070] = 90,  --type = "racial",    race =  9 },
        [129597] = 120, --type = "racial",    race = 10 },
        [59542] = 180, --type = "racial",    race = 11 },
        [68992] = 120, --type = "racial",    race = 22 },
        [107079] = 120, --type = "racial",    race = 25 },
        [260364] = 180, --type = "racial",    race = 27 },
        [255654] = 120, --type = "racial",    race = 28 },
        [256948] = 180, --type = "racial",    race = 29 },
        [255647] = 150, --type = "racial",    race = 30 },
        [291944] = 150, --type = "racial",    race = 31 },
        [287712] = 150, --type = "racial",    race = 32 },
        [265221] = 120, --type = "racial",    race = 34 },
        [312411] = 90,  --type = "racial",    race = 35 },
        [274738] = 120, --type = "racial",    race = 36 },
        [312924] = 180, --type = "racial",    race = 37 },
    --},
    --["ALL"] = {
        [305252] = 120, --type = "all",       item = 172672, item2 = 165806 },
        [286342] = 180, --type = "all",       item = 172673, item2 = 165807 },
        [315362] = 60,  --type = "all",       item = 174472 },
        [314517] = 120, --type = "all",       item = 174276 },    -- Corrupted Gladiator's Breach
        [313148] = 120, --type = "all",       item = 173944 },    -- Forbidden Obsidian Claw (trinket textureID = 1508487)
        [313113] = 80,  --type = "all",       item = 173946 },    -- Writhing Segment of Drest'agath
    --},
    --["ESSENCES"] = {
        [295373] = 30,  --type = "essence",   item = 295373 },
        [295186] = 60,  --type = "essence",   item = 295186 },
        [302731] = 60,  --type = "essence",   item = 302731 },
        [298357] = 120, --type = "essence",   item = 298357 },
        [293019] = 60,  --type = "essence",   item = 293019 },
        [294926] = 150, --type = "essence",   item = 294926 },
        [298168] = 120, --type = "essence",   item = 298168 },
        [295746] = 180, --type = "essence",   item = 295746 },
        [293031] = 60,  --type = "essence",   item = 293031 },
        [296197] = 15,  --type = "essence",   item = 296197 },
        [296094] = 180, --type = "essence",   item = 296094 },
        [293032] = 120, --type = "essence",   item = 293032 },
        [296072] = 30,  --type = "essence",   item = 296072 },
        [296230] = 60,  --type = "essence",   item = 296230 },
        [295258] = 90,  --type = "essence",   item = 295258 },
        [295840] = 180, --type = "essence",   item = 295840 },
        [297108] = 120, --type = "essence",   item = 297108 },
        [295337] = 60,  --type = "essence",   item = 295337 },
        [298452] = 60,  --type = "essence",   item = 298452 },
        [293030] = 180, --type = "essence",   item = 293030 },
        [297375] = 60,  --type = "essence",   item = 297375 },
        [295046] = 600, --type = "essence",   item = 295046 },
        [310592] = 120, --type = "essence",   item = 310592 },
        [310690] = 45,  --type = "essence",   item = 310690 },
        [311203] = 60,  --type = "essence",   item = 311203 },
    --},
}

-- 天赋/特质影响下的冷却时间
R.TalentCDFix = {
	[740]	 = 120,	-- 宁静
	[2094]   = 90,	-- 致盲
	[15286]  = 75,	-- 吸血鬼的拥抱
	[15487]  = 30,	-- 沉默
	[22812]  = 40,	-- 树皮术
	[30283]  = 30,	-- 暗怒
	[48792]  = 165,	-- 冰封之韧
	[79206]  = 60,	-- 灵魂行者的恩赐
	[102342] = 45,	-- 铁木树皮
	[108199] = 90,	-- 血魔之握
	[109304] = 105,	-- 意气风发
	[116849] = 100,	-- 作茧缚命
	[119381] = 40,	-- 扫堂腿
	[179057] = 40,	-- 混乱新星
}

-- 团队框体职业相关Buffs
local list = {
	["ALL"] = {			-- 全职业
		[642] = true,		-- 圣盾术
		[871] = true,		-- 盾墙
		[1022] = true,		-- 保护祝福
		[27827] = true,		-- 救赎之魂
		[31224] = true,		-- 暗影斗篷
		[33206] = true,		-- 痛苦压制
		[45438] = true,		-- 冰箱
		[47585] = true,		-- 消散
		[47788] = true,		-- 守护之魂
		[48792] = true,		-- 冰封之韧
		[86659] = true,		-- 远古列王守卫
		[102342] = true,	-- 铁木树皮
		[104773] = true,	-- 不灭决心
		[108271] = true,	-- 星界转移
		[115203] = true,	-- 壮胆酒
		[116849] = true,	-- 作茧缚命
		[118038] = true,	-- 剑在人在
		[160029] = true,	-- 正在复活
		[186265] = true,	-- 灵龟守护
		[196555] = true,	-- 虚空行走
		[204018] = true,	-- 破咒祝福
		[204150] = true,	-- 圣光护盾
	},
	["WARNING"] = {
		[87023] = true,		-- 灸灼
		[95809] = true,		-- 疯狂
		[123981] = true,	-- 永劫不复
		[209261] = true,	-- 未被污染的邪能
    [283167] = true,
    [286342] = true,
	},
}

module:AddClassSpells(list)