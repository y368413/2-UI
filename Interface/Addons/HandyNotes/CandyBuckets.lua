--## Author: Vladinator  ## Version: 8.1.5.190625

local CandyBuckets = {}

CandyBuckets.modules = CandyBuckets.modules or {}
CandyBuckets.modules["hallow"] = {
	event = "hallow",
	texture = {
		[1] = "Interface\\Icons\\Achievement_Halloween_Candy_01",
		[2] = "Interface\\Icons\\Spell_Shadow_Teleport",
		[3] = "Interface\\Icons\\Achievement_Halloween_Candy_01"
	},
	title = {
		[1] = "Candy Bucket",
		[2] = "Candy Bucket (Phased)",
		[3] = "Candy Bucket (Requires Reputation)"
	},
	quests = {
		{ quest = 12349, side = 1, [70] = {66.60, 45.30} },
		{ quest = 28960, side = 1, [17] = {60.70, 14.20} },
		{ quest = 28961, side = 1, [17] = {44.40, 87.70} },
		{ quest = 28959, side = 2, [17] = {40.50, 11.40} },
		{ quest = 12404, side = 3, extra = 3, [111] = {56.20, 81.80} },
		{ quest = 12409, side = 3, extra = 3, [104] = {56.30, 59.80} },
		{ quest = 12340, side = 1, extra = 2, [52] = {56.76, 47.31} },
		{ quest = 12340, side = 1, extra = 2, [52] = {52.90, 53.60} },
		{ quest = 12364, side = 2, [94] = {48.10, 47.80} },
		{ quest = 12369, side = 2, [110] = {79.60, 57.90} },
		{ quest = 12370, side = 2, [110] = {67.60, 73.20} },
		{ quest = 12383, side = 2, [70] = {36.80, 32.40} },
		{ quest = 12398, side = 3, [70] = {41.90, 74.10} },
		{ quest = 13463, side = 3, [125] = {48.30, 40.80} },
		{ quest = 13472, side = 3, [126] = {37.95, 59.99} },
		{ quest = 28973, side = 2, [241] = {53.40, 42.90} },
		{ quest = 28974, side = 2, [241] = {45.10, 76.70} },
		{ quest = 28975, side = 2, [241] = {75.30, 54.80} },
		{ quest = 28976, side = 2, [241] = {75.40, 16.50} },
		{ quest = 28977, side = 1, [241] = {60.40, 58.20} },
		{ quest = 28978, side = 1, [241] = {49.60, 30.40} },
		{ quest = 28979, side = 1, [241] = {43.60, 57.30} },
		{ quest = 28980, side = 1, [241] = {79.50, 78.50} },
		{ quest = 28999, side = 3, [198] = {63.00, 24.10} },
		{ quest = 29000, side = 3, [198] = {18.70, 37.30} },
		{ quest = 29001, side = 3, [198] = {42.70, 45.60} },
		{ quest = 29016, side = 3, [249] = {26.60, 7.30} },
		{ quest = 29017, side = 3, [249] = {54.70, 33.00} },
		{ quest = 32020, side = 2, [418] = {28.63, 47.90} },
		{ quest = 32022, side = 2, [392] = {58.30, 76.90} },
		{ quest = 32034, side = 3, [418] = {53.49, 76.50} },
		{ quest = 32036, side = 3, [418] = {79.81, 0.84} },
		{ quest = 32047, side = 2, [418] = {63.75, 20.32} },
		{ quest = 32052, side = 1, [393] = {37.30, 67.10} },
		{ quest = 29019, side = 2, [207] = {51.20, 50.00} },
		{ quest = 29020, side = 1, [207] = {47.40, 51.70} },
		{ quest = 12286, side = 1, [37] = {43.70, 66.00} },
		{ quest = 12332, side = 1, [27] = {54.50, 50.70} },
		{ quest = 12335, side = 1, [87] = {18.60, 51.30} },
		{ quest = 12336, side = 1, [84] = {60.50, 75.20} },
		{ quest = 12339, side = 1, [48] = {35.50, 48.40} },
		{ quest = 12342, side = 1, [49] = {26.40, 41.60} },
		{ quest = 12343, side = 1, [56] = {10.80, 60.90} },
		{ quest = 12344, side = 1, [47] = {73.90, 44.40} },
		{ quest = 12351, side = 1, [26] = {14.20, 44.70} },
		{ quest = 12363, side = 2, [18] = {60.90, 51.50} },
		{ quest = 12368, side = 2, [90] = {67.70, 37.90} },
		{ quest = 12371, side = 2, [21] = {46.40, 42.80} },
		{ quest = 12376, side = 2, [25] = {57.90, 47.30} },
		{ quest = 12380, side = 2, [14] = {69.00, 33.40} },
		{ quest = 12382, side = 2, [50] = {37.30, 51.70} },
		{ quest = 12384, side = 2, [51] = {46.90, 56.70} },
		{ quest = 12387, side = 2, [26] = {78.20, 81.40} },
		{ quest = 12397, side = 3, [210] = {40.90, 73.80} },
		{ quest = 12402, side = 3, [24] = {41.02, 90.77} },
		{ quest = 28954, side = 1, [14] = {40.10, 49.00} },
		{ quest = 28955, side = 3, [15] = {65.90, 35.80} },
		{ quest = 28956, side = 1, [15] = {20.90, 56.20} },
		{ quest = 28957, side = 2, [15] = {18.30, 42.80} },
		{ quest = 28962, side = 2, [25] = {60.30, 63.80} },
		{ quest = 28963, side = 1, [48] = {82.90, 63.60} },
		{ quest = 28964, side = 1, [50] = {53.10, 66.90} },
		{ quest = 28965, side = 3, [32] = {39.40, 66.10} },
		{ quest = 28966, side = 2, [21] = {44.30, 20.40} },
		{ quest = 28967, side = 3, [51] = {71.70, 14.00} },
		{ quest = 28968, side = 1, [51] = {29.00, 32.60} },
		{ quest = 28969, side = 2, [210] = {35.10, 27.20} },
		{ quest = 28970, side = 1, [26] = {66.20, 44.40} },
		{ quest = 28971, side = 2, [26] = {31.90, 57.90} },
		{ quest = 28972, side = 2, [18] = {83.00, 72.00} },
		{ quest = 28981, side = 3, [201] = {63.40, 60.20} },
		{ quest = 28982, side = 3, [205] = {49.20, 41.90} },
		{ quest = 28983, side = 1, [205] = {49.70, 57.40} },
		{ quest = 28984, side = 2, [205] = {51.50, 62.50} },
		{ quest = 28985, side = 1, [204] = {54.70, 72.20} },
		{ quest = 28986, side = 2, [204] = {51.30, 60.60} },
		{ quest = 28987, side = 2, [22] = {48.20, 63.70} },
		{ quest = 28988, side = 1, [22] = {43.40, 84.50} },
		{ quest = 28990, side = 1, [56] = {26.10, 25.90} },
		{ quest = 28991, side = 1, [56] = {58.10, 39.20} },
		{ quest = 12331, side = 1, [57] = {55.40, 52.30} },
		{ quest = 12334, side = 1, [89] = {62.20, 33.00} },
		{ quest = 12345, side = 1, [63] = {37.00, 49.30} },
		{ quest = 12347, side = 1, [65] = {40.60, 17.70} },
		{ quest = 12348, side = 1, [66] = {66.30, 6.70} },
		{ quest = 12350, side = 1, [69] = {46.30, 45.20} },
		{ quest = 12361, side = 2, [1] = {51.60, 41.70} },
		{ quest = 12362, side = 2, [7] = {46.80, 60.40} },
		{ quest = 12366, side = 2, [85] = {53.80, 78.80} },
		{ quest = 12367, side = 2, [88] = {45.70, 64.50} },
		{ quest = 12374, side = 2, [10] = {49.50, 58.00} },
		{ quest = 12377, side = 2, [63] = {73.90, 60.70} },
		{ quest = 12378, side = 2, [65] = {50.40, 63.80} },
		{ quest = 12381, side = 2, [66] = {24.10, 68.30} },
		{ quest = 12386, side = 2, [69] = {74.80, 45.10} },
		{ quest = 12396, side = 3, [10] = {67.30, 74.70} },
		{ quest = 12399, side = 3, [71] = {52.60, 27.10} },
		{ quest = 12400, side = 3, [83] = {59.80, 51.20} },
		{ quest = 12401, side = 3, [81] = {55.50, 36.70} },
		{ quest = 28951, side = 1, [62] = {50.80, 18.80} },
		{ quest = 28952, side = 1, [69] = {51.10, 17.80} },
		{ quest = 28953, side = 2, [63] = {50.20, 67.20} },
		{ quest = 28958, side = 2, [63] = {38.60, 42.40} },
		{ quest = 28989, side = 2, [63] = {13.00, 34.10} },
		{ quest = 28992, side = 2, [76] = {57.10, 50.20} },
		{ quest = 28993, side = 3, [66] = {56.80, 50.00} },
		{ quest = 28994, side = 3, [77] = {44.60, 28.90} },
		{ quest = 28995, side = 1, [77] = {61.80, 26.70} },
		{ quest = 28996, side = 2, [69] = {41.40, 15.60} },
		{ quest = 28998, side = 2, [69] = {52.00, 47.70} },
		{ quest = 29002, side = 2, [10] = {56.30, 40.10} },
		{ quest = 29003, side = 2, [10] = {62.50, 16.60} },
		{ quest = 29004, side = 2, [199] = {39.30, 20.10} },
		{ quest = 29005, side = 2, [199] = {40.70, 69.30} },
		{ quest = 29006, side = 1, [199] = {39.00, 11.00} },
		{ quest = 29007, side = 1, [199] = {65.60, 46.60} },
		{ quest = 29008, side = 1, [199] = {49.10, 68.50} },
		{ quest = 29009, side = 2, [65] = {66.50, 64.20} },
		{ quest = 29010, side = 1, [65] = {71.00, 79.10} },
		{ quest = 29011, side = 1, [65] = {59.10, 56.30} },
		{ quest = 29012, side = 1, [65] = {39.50, 32.80} },
		{ quest = 29013, side = 1, [65] = {31.50, 60.70} },
		{ quest = 29014, side = 3, [71] = {55.70, 60.90} },
		{ quest = 29018, side = 3, [78] = {55.20, 62.10} },
		{ quest = 12333, side = 1, [97] = {48.50, 49.10} },
		{ quest = 12337, side = 1, [103] = {59.30, 19.20} },
		{ quest = 12341, side = 1, [106] = {55.70, 59.90} },
		{ quest = 12352, side = 1, [100] = {54.30, 63.60} },
		{ quest = 12353, side = 1, [100] = {23.40, 36.50} },
		{ quest = 12354, side = 1, [102] = {67.20, 49.00} },
		{ quest = 12355, side = 1, [102] = {41.90, 26.20} },
		{ quest = 12356, side = 1, [108] = {56.60, 53.20} },
		{ quest = 12357, side = 1, [107] = {54.20, 75.80} },
		{ quest = 12358, side = 1, [105] = {35.80, 63.80} },
		{ quest = 12359, side = 1, [105] = {61.00, 68.10} },
		{ quest = 12360, side = 1, [104] = {37.10, 58.20} },
		{ quest = 12365, side = 2, [94] = {43.70, 71.10} },
		{ quest = 12373, side = 2, [95] = {48.60, 32.00} },
		{ quest = 12388, side = 2, [100] = {56.80, 37.50} },
		{ quest = 12389, side = 2, [100] = {26.90, 59.60} },
		{ quest = 12390, side = 2, [102] = {30.70, 50.90} },
		{ quest = 12391, side = 2, [108] = {48.80, 45.20} },
		{ quest = 12392, side = 2, [107] = {56.70, 34.60} },
		{ quest = 12393, side = 2, [105] = {53.40, 55.50} },
		{ quest = 12394, side = 2, [105] = {76.20, 60.40} },
		{ quest = 12395, side = 2, [104] = {30.30, 27.80} },
		{ quest = 12403, side = 3, [102] = {78.50, 62.90} },
		{ quest = 12406, side = 3, [105] = {62.90, 38.30} },
		{ quest = 12407, side = 3, [109] = {32.00, 64.40} },
		{ quest = 12408, side = 3, [109] = {43.40, 36.10} },
		{ quest = 12940, side = 3, [121] = {59.30, 57.20} },
		{ quest = 12941, side = 3, [121] = {40.80, 66.00} },
		{ quest = 12944, side = 1, [116] = {32.00, 60.20} },
		{ quest = 12945, side = 1, [116] = {59.60, 26.40} },
		{ quest = 12946, side = 2, [116] = {20.90, 64.70} },
		{ quest = 12947, side = 2, [116] = {65.40, 47.00} },
		{ quest = 12950, side = 3, [119] = {26.70, 59.20} },
		{ quest = 13433, side = 1, [117] = {58.40, 62.80} },
		{ quest = 13434, side = 1, [117] = {30.80, 41.50} },
		{ quest = 13435, side = 1, [117] = {60.50, 15.90} },
		{ quest = 13436, side = 1, [114] = {58.50, 67.90} },
		{ quest = 13437, side = 1, [114] = {57.10, 18.80} },
		{ quest = 13438, side = 1, [115] = {29.00, 56.20} },
		{ quest = 13439, side = 1, [115] = {77.50, 51.30} },
		{ quest = 13448, side = 1, [120] = {28.70, 74.30} },
		{ quest = 13452, side = 3, [117] = {25.40, 59.80} },
		{ quest = 13456, side = 3, [115] = {60.10, 53.50} },
		{ quest = 13459, side = 3, [115] = {48.20, 74.70} },
		{ quest = 13460, side = 3, [114] = {78.40, 49.20} },
		{ quest = 13461, side = 3, [120] = {41.10, 85.90} },
		{ quest = 13462, side = 3, [120] = {30.90, 37.20} },
		{ quest = 13464, side = 2, [117] = {49.50, 10.80} },
		{ quest = 13465, side = 2, [117] = {52.10, 66.20} },
		{ quest = 13466, side = 2, [117] = {79.20, 30.60} },
		{ quest = 13467, side = 2, [114] = {76.70, 37.40} },
		{ quest = 13468, side = 2, [114] = {41.80, 54.40} },
		{ quest = 13469, side = 2, [115] = {37.80, 46.40} },
		{ quest = 13470, side = 2, [115] = {76.80, 63.20} },
		{ quest = 13471, side = 2, [120] = {67.60, 50.60} },
		{ quest = 13473, side = 1, [125] = {42.50, 63.50} },
		{ quest = 13474, side = 2, [125] = {66.60, 30.10} },
		{ quest = 13501, side = 2, [114] = {49.70, 10.00} },
		{ quest = 13548, side = 2, [120] = {37.10, 49.60} },
		{ quest = 32021, side = 3, [371] = {41.60, 23.10} },
		{ quest = 32023, side = 3, [422] = {55.20, 71.10} },
		{ quest = 32024, side = 3, [422] = {55.90, 32.30} },
		{ quest = 32026, side = 3, [433] = {54.90, 72.30} },
		{ quest = 32027, side = 3, [371] = {45.70, 43.60} },
		{ quest = 32028, side = 2, [371] = {28.00, 47.40} },
		{ quest = 32029, side = 3, [371] = {48.00, 34.60} },
		{ quest = 32031, side = 3, [371] = {55.70, 24.40} },
		{ quest = 32032, side = 3, [371] = {54.60, 63.30} },
		{ quest = 32033, side = 1, [371] = {59.60, 83.20} },
		{ quest = 32037, side = 3, [379] = {57.40, 59.90} },
		{ quest = 32039, side = 3, [379] = {72.70, 92.20} },
		{ quest = 32040, side = 2, [379] = {62.70, 80.50} },
		{ quest = 32041, side = 3, [379] = {64.20, 61.20} },
		{ quest = 32042, side = 1, [379] = {54.10, 82.80} },
		{ quest = 32043, side = 3, [388] = {71.10, 57.80} },
		{ quest = 32044, side = 3, [390] = {35.10, 77.70} },
		{ quest = 32046, side = 3, [376] = {19.80, 55.70} },
		{ quest = 32048, side = 3, [376] = {83.60, 20.30} },
		{ quest = 32049, side = 1, [371] = {44.80, 84.40} },
		{ quest = 32050, side = 2, [371] = {28.50, 13.30} },
		{ quest = 32051, side = 3, [379] = {62.30, 29.00} },
		{ quest = 39657, side = 3, [582] = {44.00, 52.00}, [590] = {47.50, 37.80} },
		{ quest = 43055, side = 3, [627] = {48.10, 41.30} },
		{ quest = 43056, side = 1, [627] = {41.80, 64.20} },
		{ quest = 43057, side = 2, [627] = {66.80, 30.00} },
		{ quest = 12409, side = 3, extra = 3, [104] = {61.00, 28.20} },
		{ quest = 12404, side = 3, extra = 3, [111] = {28.10, 49.00} },
		{ quest = 54709, side = 2, [1163] = {50.71, 82.30} },
		{ quest = 54710, side = 1, [1161] = {73.66, 12.59} },
	},
	patterns = {
		"^%s*[Cc][Aa][Nn][Dd][Yy]%s+[Bb][Uu][Cc][Kk][Ee][Tt]%s*$",
		"^%s*[Ee][Ii][Mm][Ee][Rr]%s+[Mm][Ii][Tt]%s+[Ss][üü][??][Ii][Gg][Kk][Ee][Ii][Tt][Ee][Nn]%s*$",
		"^%s*[Cc][Uu][Bb][Oo]%s+[Dd][Ee]%s+[Cc][Aa][Rr][Aa][Mm][Ee][Ll][Oo][Ss]%s*$",
		"^%s*[Uu][Nn]%s+[Ss][Ee][Aa][Uu]%s+[Dd][Ee]%s+[Bb][Oo][Nn][Bb][Oo][Nn][Ss]%s*$",
		"^%s*[Ss][Ee][Aa][Uu]%s+[Dd][Ee]%s+[Bb][Oo][Nn][Bb][Oo][Nn][Ss]%s*$",
		"^%s*[Ss][Ee][Cc][Cc][Hh][Ii][Oo]%s+[Dd][Ee][Ll][Ll][Ee]%s+[Cc][Aa][Rr][Aa][Mm][Ee][Ll][Ll][Ee]%s*$",
		"^%s*[Bb][Aa][Ll][Dd][Ee]%s+[Dd][Ee]%s+[Dd][Oo][Cc][Ee][Ss]%s*$",
		"^%s*[Кк][Уу][Лл][Ее][Кк]%s+[Кк][Оо][Нн][Фф][Ее][Тт]%s*$",
		"^%s*??%s+???%s*$",
		"^%s*糖罐%s*$",
		"^%s*%[%s*[Cc][Aa][Nn][Dd][Yy]%s+[Bb][Uu][Cc][Kk][Ee][Tt]%s*%]%s*$",
	}
}

CandyBuckets.modules["lunar"] = {
	event = "lunar",
	texture = {
		[1] = "Interface\\Icons\\INV_Misc_ElvenCoins",
		[2] = "Interface\\Icons\\Spell_Shadow_Teleport"
	},
	title = {
		[1] = "Elder",
		[2] = "Elder (Instance)"
	},
	quests = {
		{ quest = 29735, side = 3, [207] = {49.60, 54.80} },
		{ quest = 29734, side = 3, [207] = {27.60, 69.20} },
		{ quest = 8647, side = 3, [17] = {54.20, 49.40} },
		{ quest = 8652, side = 3, [18] = {61.80, 54.00} },
		{ quest = 8645, side = 3, [21] = {45.00, 41.20} },
		{ quest = 8714, side = 3, [22] = {69.20, 73.40} },
		{ quest = 8722, side = 3, [22] = {63.40, 36.20} },
		{ quest = 8688, side = 3, [23] = {35.40, 68.80} },
		{ quest = 8650, side = 3, [23] = {75.60, 54.40} },
		{ quest = 8727, side = 3, [317] = {79.00, 21.80} },
		{ quest = 8643, side = 3, [26] = {50.00, 48.00} },
		{ quest = 8653, side = 3, [27] = {53.80, 49.80} },
		{ quest = 8651, side = 3, [32] = {21.20, 79.00} },
		{ quest = 8683, side = 3, [36] = {52.40, 24.00} },
		{ quest = 8644, side = 3, [252] = {61.90, 40.50} },
		{ quest = 8619, side = 3, [242] = {50.60, 63.20} },
		{ quest = 8636, side = 3, [36] = {70.00, 45.40} },
		{ quest = 8646, side = 3, [37] = {34.40, 50.40} },
		{ quest = 8649, side = 3, [37] = {39.80, 63.60} },
		{ quest = 8642, side = 3, [48] = {33.20, 46.60} },
		{ quest = 8716, side = 3, [50] = {71.00, 34.20} },
		{ quest = 8713, side = 3, [220] = {62.40, 34.40} },
		{ quest = 8675, side = 3, [52] = {56.60, 47.00} },
		{ quest = 8866, side = 3, [87] = {29.40, 17.20} },
		{ quest = 8648, side = 3, [998] = {66.60, 38.00} },
		{ quest = 29738, side = 3, [205] = {57.20, 86.20} },
		{ quest = 8674, side = 3, [210] = {40.00, 72.40} },
		{ quest = 29737, side = 3, [241] = {50.80, 70.40} },
		{ quest = 29736, side = 3, [241] = {51.80, 33.00} },
		{ quest = 8670, side = 3, [1] = {53.20, 43.60} },
		{ quest = 8673, side = 3, [7] = {48.40, 53.20} },
		{ quest = 8717, side = 3, [10] = {48.40, 59.20} },
		{ quest = 8680, side = 3, [10] = {68.40, 70.00} },
		{ quest = 8715, side = 3, [57] = {56.80, 53.00} },
		{ quest = 8721, side = 3, [62] = {49.40, 18.80} },
		{ quest = 8725, side = 3, [63] = {35.40, 49.00} },
		{ quest = 8724, side = 3, [64] = {77.00, 75.60} },
		{ quest = 8682, side = 3, [64] = {46.40, 51.00} },
		{ quest = 8635, side = 3, [281] = {51.50, 93.70} },
		{ quest = 8685, side = 3, [69] = {62.60, 31.00} },
		{ quest = 8679, side = 3, [69] = {76.60, 37.80} },
		{ quest = 8676, side = 3, [219] = {34.40, 39.60} },
		{ quest = 8684, side = 3, [71] = {51.40, 28.80} },
		{ quest = 8671, side = 3, [71] = {37.20, 79.00} },
		{ quest = 8720, side = 3, [76] = {64.60, 79.20} },
		{ quest = 8723, side = 3, [77] = {38.40, 52.80} },
		{ quest = 8681, side = 3, [78] = {50.40, 76.20} },
		{ quest = 8719, side = 3, [81] = {53.00, 35.40} },
		{ quest = 8654, side = 3, [81] = {30.80, 13.40} },
		{ quest = 8672, side = 3, [83] = {59.80, 49.80} },
		{ quest = 8726, side = 3, [83] = {53.20, 56.60} },
		{ quest = 8677, side = 3, [85] = {52.20, 59.80} },
		{ quest = 8678, side = 3, [88] = {73.00, 23.80} },
		{ quest = 8718, side = 3, [89] = {39.20, 32.00} },
		{ quest = 29740, side = 3, [198] = {62.60, 22.80} },
		{ quest = 29739, side = 3, [198] = {26.60, 62.00} },
		{ quest = 8686, side = 3, [199] = {41.60, 47.40} },
		{ quest = 29742, side = 3, [249] = {65.40, 18.60} },
		{ quest = 29741, side = 3, [249] = {31.60, 63.00} },
		{ quest = 13012, side = 3, [114] = {59.00, 65.60} },
		{ quest = 13029, side = 3, [114] = {42.80, 49.60} },
		{ quest = 13033, side = 3, [114] = {57.40, 43.60} },
		{ quest = 13021, side = 3, [129] = {55.40, 64.80} },
		{ quest = 13016, side = 3, [114] = {33.80, 34.20} },
		{ quest = 13014, side = 3, [115] = {29.80, 55.80} },
		{ quest = 13022, side = 3, [157] = {22.00, 44.00} },
		{ quest = 13031, side = 3, [115] = {35.00, 48.40} },
		{ quest = 13019, side = 3, [115] = {48.80, 78.00} },
		{ quest = 13030, side = 3, [116] = {64.20, 47.00} },
		{ quest = 13025, side = 3, [116] = {80.40, 37.00} },
		{ quest = 13013, side = 3, [116] = {60.40, 27.60} },
		{ quest = 13017, side = 3, [133] = {47.40, 70.00} },
		{ quest = 13067, side = 3, [136] = {48.60, 22.20} },
		{ quest = 13024, side = 3, [119] = {63.80, 49.00} },
		{ quest = 13018, side = 3, [119] = {49.80, 63.60} },
		{ quest = 13015, side = 3, [120] = {28.80, 73.60} },
		{ quest = 13066, side = 3, [140] = {29.60, 61.60} },
		{ quest = 13028, side = 3, [120] = {41.00, 84.60} },
		{ quest = 13020, side = 3, [120] = {31.20, 37.60} },
		{ quest = 13032, side = 3, [120] = {64.60, 51.20} },
		{ quest = 13065, side = 3, [154] = {45.80, 62.00} },
		{ quest = 13027, side = 3, [121] = {58.80, 56.00} },
		{ quest = 13023, side = 3, [160] = {68.20, 78.80} },
		{ quest = 13026, side = 3, [123] = {49.00, 14.00} },
		{ quest = 8676, side = 3, extra = 2, [71] = {39.60, 21.10} },
		{ quest = 8635, side = 3, extra = 2, [66] = {30.10, 62.70} },
		{ quest = 8619, side = 3, extra = 2, [32] = {35.30, 85.20}, [36] = {20.50, 35.60} },
		{ quest = 13017, side = 3, extra = 2, [117] = {59.00, 50.40} },
		{ quest = 13022, side = 3, extra = 2, [115] = {26.80, 47.50} },
		{ quest = 13065, side = 3, extra = 2, [121] = {78.40, 25.00} },
		{ quest = 13067, side = 3, extra = 2, [117] = {57.90, 39.80} },
		{ quest = 8713, side = 3, extra = 2, [51] = {69.60, 54.50} },
		{ quest = 8644, side = 3, extra = 2, [32] = {35.30, 87.20}, [36] = {20.50, 37.60} },
		{ quest = 8727, side = 3, extra = 2, [23] = {26.90, 14.90} },
		{ quest = 13021, side = 3, extra = 2, [114] = {27.00, 28.70} },
		{ quest = 13023, side = 3, extra = 2, [116] = {17.70, 25.60}, [121] = {28.20, 89.10} },
		{ quest = 13066, side = 3, extra = 2, [120] = {37.50, 24.20} },
	},
	patterns = {
		"%s+[Tt][Hh][Ee]%s+[Ee][Ll][Dd][Ee][Rr]%s*$",
		"^%s*[Uu][Rr][Aa][Hh][Nn][Ee]%s+",
		"%s+[Ee][Ll]%s+[Aa][Nn][Cc][Ee][Ss][Tt][Rr][Oo]%s*$",
		"^%s*[Ll]'[Aa][Nn][Cc][Ii][Ee][Nn]%s+",
		"%s+[Ll]'[Aa][Nn][Zz][Ii][Aa][Nn][oO]%s*$",
		",%s+[Oo]%s+[Aa][Nn][Cc][Ii][??][Oo]%s*$",
		"^%s*[Пп][Рр][Ее][Дд][Оо][Кк]%s+",
	}
}

CandyBuckets.modules["midsummer"] = {
	event = "midsummer",
	texture = {
		[1] = "Interface\\Icons\\Spell_Fire_MasterOfElements",
		[2] = "Interface\\Icons\\INV_SummerFest_FireSpirit",
		[3] = "Interface\\Icons\\Spell_Shadow_Teleport"
	},
	title = {
		[1] = "Bonfire (Desecrate)",
		[2] = "Bonfire (Honor)",
		[3] = "Bonfire (Phased)"
	},
	quests = {
		{ quest = 11737, side = 2, extra = 1, [17] = {55.20, 15.30} },
		{ quest = 11808, side = 1, extra = 2, [17] = {55.54, 14.89} },
		{ quest = 28917, side = 1, extra = 1, [17] = {46.29, 14.02} },
		{ quest = 28930, side = 2, extra = 2, [17] = {46.00, 14.00} },
		{ quest = 29036, side = 3, extra = 2, [207] = {49.40, 51.40} },
		{ quest = 11580, side = 1, extra = 1, [21] = {49.60, 38.70} },
		{ quest = 11581, side = 2, extra = 1, [52] = {45.20, 62.30} },
		{ quest = 11583, side = 1, extra = 2, [52] = {45.00, 62.00} },
		{ quest = 11584, side = 2, extra = 2, [21] = {50.00, 38.00} },
		{ quest = 11732, side = 2, extra = 1, [14] = {44.58, 46.05} },
		{ quest = 11739, side = 2, extra = 1, [36] = {68.60, 59.90} },
		{ quest = 11742, side = 2, extra = 1, [27] = {53.80, 44.70} },
		{ quest = 11743, side = 2, extra = 1, [47] = {73.20, 54.90} },
		{ quest = 11745, side = 2, extra = 1, [37] = {43.20, 63.00} },
		{ quest = 11749, side = 2, extra = 1, [48] = {32.30, 40.40} },
		{ quest = 11751, side = 2, extra = 1, [49] = {24.40, 53.90} },
		{ quest = 11755, side = 2, extra = 1, [26] = {14.53, 49.80} },
		{ quest = 11756, side = 2, extra = 1, [22] = {43.60, 82.50} },
		{ quest = 11757, side = 2, extra = 1, [56] = {13.30, 47.30} },
		{ quest = 11761, side = 2, extra = 1, [210] = {51.70, 67.30} },
		{ quest = 11764, side = 1, extra = 1, [14] = {69.23, 42.89} },
		{ quest = 11766, side = 1, extra = 1, [15] = {24.20, 37.30} },
		{ quest = 11768, side = 1, extra = 1, [36] = {51.50, 29.30} },
		{ quest = 11776, side = 1, extra = 1, [25] = {54.50, 50.00} },
		{ quest = 11781, side = 1, extra = 1, [51] = {76.62, 14.14} },
		{ quest = 11784, side = 1, extra = 1, [26] = {76.63, 74.63} },
		{ quest = 11786, side = 1, extra = 1, [18] = {56.90, 51.80} },
		{ quest = 11801, side = 1, extra = 1, [210] = {50.60, 70.70} },
		{ quest = 11804, side = 1, extra = 2, [14] = {44.30, 46.02} },
		{ quest = 11810, side = 1, extra = 2, [36] = {68.00, 60.00} },
		{ quest = 11813, side = 1, extra = 2, [27] = {54.00, 45.00} },
		{ quest = 11814, side = 1, extra = 2, [47] = {73.00, 55.00} },
		{ quest = 11816, side = 1, extra = 2, [37] = {43.47, 62.60} },
		{ quest = 11820, side = 1, extra = 2, [48] = {32.00, 40.00} },
		{ quest = 11822, side = 1, extra = 2, [49] = {24.00, 53.00} },
		{ quest = 11826, side = 1, extra = 2, [26] = {14.34, 50.08} },
		{ quest = 11827, side = 1, extra = 2, [22] = {43.00, 82.00} },
		{ quest = 11828, side = 1, extra = 2, [56] = {13.00, 47.00} },
		{ quest = 11832, side = 1, extra = 2, [210] = {51.00, 67.00} },
		{ quest = 11837, side = 2, extra = 2, [210] = {50.00, 70.00} },
		{ quest = 11840, side = 2, extra = 2, [14] = {69.36, 42.58} },
		{ quest = 11842, side = 2, extra = 2, [15] = {23.17, 37.58} },
		{ quest = 11844, side = 2, extra = 2, [36] = {51.00, 29.00} },
		{ quest = 11853, side = 2, extra = 2, [25] = {55.00, 50.00} },
		{ quest = 11857, side = 2, extra = 2, [51] = {76.00, 14.00} },
		{ quest = 11860, side = 2, extra = 2, [26] = {76.63, 74.95} },
		{ quest = 11862, side = 2, extra = 2, [18] = {57.00, 52.00} },
		{ quest = 28910, side = 2, extra = 1, [50] = {51.60, 63.30} },
		{ quest = 28911, side = 1, extra = 1, [50] = {40.70, 52.00} },
		{ quest = 28912, side = 2, extra = 1, [15] = {18.50, 56.10} },
		{ quest = 28916, side = 2, extra = 1, [51] = {70.10, 14.80} },
		{ quest = 28918, side = 1, extra = 1, [22] = {29.10, 56.40} },
		{ quest = 28922, side = 1, extra = 2, [50] = {52.00, 63.60} },
		{ quest = 28924, side = 2, extra = 2, [50] = {40.00, 51.00} },
		{ quest = 28925, side = 1, extra = 2, [15] = {19.00, 56.00} },
		{ quest = 28929, side = 1, extra = 2, [51] = {70.25, 15.74} },
		{ quest = 28931, side = 2, extra = 2, [22] = {29.00, 57.00} },
		{ quest = 28943, side = 2, extra = 1, [241] = {47.00, 28.30} },
		{ quest = 28944, side = 1, extra = 1, [241] = {53.30, 46.50} },
		{ quest = 28945, side = 1, extra = 2, [241] = {47.00, 28.00} },
		{ quest = 28946, side = 2, extra = 2, [241] = {53.00, 46.00} },
		{ quest = 29031, side = 3, extra = 2, [205] = {49.30, 42.00} },
		{ quest = 11734, side = 2, extra = 1, [63] = {86.70, 41.40} },
		{ quest = 11740, side = 2, extra = 1, [62] = {49.00, 22.50} },
		{ quest = 11741, side = 2, extra = 1, [66] = {65.80, 17.00} },
		{ quest = 11744, side = 2, extra = 1, [70] = {62.10, 40.30} },
		{ quest = 11746, side = 2, extra = 1, [69] = {46.60, 43.80} },
		{ quest = 11753, side = 2, extra = 1, [57] = {54.70, 52.70} },
		{ quest = 11760, side = 2, extra = 1, [81] = {60.50, 33.40} },
		{ quest = 11762, side = 2, extra = 1, [71] = {52.70, 30.00} },
		{ quest = 11763, side = 2, extra = 1, [83] = {61.30, 47.10} },
		{ quest = 11765, side = 1, extra = 1, [63] = {51.60, 66.80} },
		{ quest = 11769, side = 1, extra = 1, [66] = {26.10, 77.40} },
		{ quest = 11770, side = 1, extra = 1, [1] = {52.00, 47.00} },
		{ quest = 11771, side = 1, extra = 1, [70] = {33.20, 30.80} },
		{ quest = 11773, side = 1, extra = 1, [69] = {72.50, 47.60} },
		{ quest = 11777, side = 1, extra = 1, [7] = {52.00, 59.30} },
		{ quest = 11780, side = 1, extra = 1, [65] = {53.00, 62.40} },
		{ quest = 11783, side = 1, extra = 1, [10] = {49.90, 54.20} },
		{ quest = 11800, side = 1, extra = 1, [81] = {50.80, 41.60} },
		{ quest = 11802, side = 1, extra = 1, [71] = {49.80, 28.07} },
		{ quest = 11803, side = 1, extra = 1, [83] = {58.13, 47.29} },
		{ quest = 11805, side = 1, extra = 2, [63] = {87.00, 42.00} },
		{ quest = 11811, side = 1, extra = 2, [62] = {49.00, 23.00} },
		{ quest = 11812, side = 1, extra = 2, [66] = {65.00, 17.00} },
		{ quest = 11815, side = 1, extra = 2, [70] = {62.00, 40.00} },
		{ quest = 11817, side = 1, extra = 2, [69] = {47.00, 44.00} },
		{ quest = 11824, side = 1, extra = 2, [57] = {54.80, 52.90} },
		{ quest = 11831, side = 1, extra = 2, [81] = {60.30, 33.50} },
		{ quest = 11833, side = 1, extra = 2, [71] = {52.64, 30.26} },
		{ quest = 11834, side = 1, extra = 2, [83] = {61.24, 47.25} },
		{ quest = 11836, side = 2, extra = 2, [81] = {51.00, 41.00} },
		{ quest = 11838, side = 2, extra = 2, [71] = {49.00, 27.00} },
		{ quest = 11839, side = 2, extra = 2, [83] = {58.22, 47.53} },
		{ quest = 11841, side = 2, extra = 2, [63] = {51.00, 66.00} },
		{ quest = 11845, side = 2, extra = 2, [66] = {26.00, 76.00} },
		{ quest = 11846, side = 2, extra = 2, [1] = {52.00, 47.00} },
		{ quest = 11847, side = 2, extra = 2, [70] = {33.00, 30.00} },
		{ quest = 11849, side = 2, extra = 2, [69] = {72.00, 47.00} },
		{ quest = 11852, side = 2, extra = 2, [7] = {51.00, 59.00} },
		{ quest = 11856, side = 2, extra = 2, [65] = {53.00, 62.00} },
		{ quest = 11859, side = 2, extra = 2, [10] = {50.00, 55.00} },
		{ quest = 28913, side = 2, extra = 1, [199] = {48.20, 72.40} },
		{ quest = 28914, side = 1, extra = 1, [199] = {40.70, 67.20} },
		{ quest = 28915, side = 2, extra = 1, [65] = {49.60, 51.10} },
		{ quest = 28919, side = 1, extra = 1, [76] = {60.40, 53.50} },
		{ quest = 28920, side = 1, extra = 1, [78] = {56.30, 65.80} },
		{ quest = 28921, side = 2, extra = 1, [78] = {60.00, 62.90} },
		{ quest = 28923, side = 2, extra = 2, [76] = {60.78, 53.48} },
		{ quest = 28926, side = 1, extra = 2, [199] = {48.00, 72.00} },
		{ quest = 28927, side = 2, extra = 2, [199] = {41.00, 68.00} },
		{ quest = 28928, side = 1, extra = 2, [65] = {49.00, 51.00} },
		{ quest = 28932, side = 1, extra = 2, [78] = {60.00, 63.00} },
		{ quest = 28933, side = 2, extra = 2, [78] = {56.00, 66.00} },
		{ quest = 28947, side = 2, extra = 1, [249] = {53.40, 32.00} },
		{ quest = 28948, side = 1, extra = 1, [249] = {53.00, 34.40} },
		{ quest = 28949, side = 2, extra = 2, [249] = {53.00, 34.00} },
		{ quest = 28950, side = 1, extra = 2, [249] = {53.00, 32.00} },
		{ quest = 29030, side = 3, extra = 2, [198] = {62.84, 22.69} },
		{ quest = 11735, side = 2, extra = 1, [97] = {44.70, 52.50} },
		{ quest = 11736, side = 2, extra = 1, [105] = {41.80, 65.90} },
		{ quest = 11738, side = 2, extra = 1, [106] = {56.00, 68.50} },
		{ quest = 11747, side = 2, extra = 1, [100] = {61.90, 58.50} },
		{ quest = 11750, side = 2, extra = 1, [107] = {49.70, 69.66} },
		{ quest = 11752, side = 2, extra = 1, [104] = {39.60, 54.30} },
		{ quest = 11754, side = 2, extra = 1, [108] = {54.20, 55.40} },
		{ quest = 11758, side = 2, extra = 1, [102] = {68.69, 52.11} },
		{ quest = 11759, side = 2, extra = 1, [109] = {31.10, 62.70} },
		{ quest = 11767, side = 1, extra = 1, [105] = {49.90, 59.00} },
		{ quest = 11772, side = 1, extra = 1, [94] = {46.30, 50.30} },
		{ quest = 11774, side = 1, extra = 1, [95] = {47.00, 25.90} },
		{ quest = 11775, side = 1, extra = 1, [100] = {57.30, 41.80} },
		{ quest = 11778, side = 1, extra = 1, [107] = {51.12, 34.02} },
		{ quest = 11779, side = 1, extra = 1, [104] = {33.60, 30.30} },
		{ quest = 11782, side = 1, extra = 1, [108] = {51.90, 43.30} },
		{ quest = 11787, side = 1, extra = 1, [102] = {35.60, 51.90} },
		{ quest = 11799, side = 1, extra = 1, [109] = {32.30, 68.40} },
		{ quest = 11806, side = 1, extra = 2, [97] = {44.00, 53.00} },
		{ quest = 11807, side = 1, extra = 2, [105] = {42.00, 66.00} },
		{ quest = 11809, side = 1, extra = 2, [106] = {55.00, 69.00} },
		{ quest = 11818, side = 1, extra = 2, [100] = {62.00, 58.00} },
		{ quest = 11854, side = 2, extra = 2, [107] = {50.91, 34.15} },
		{ quest = 11821, side = 1, extra = 2, [107] = {49.61, 69.47} },
		{ quest = 11823, side = 1, extra = 2, [104] = {40.00, 55.00} },
		{ quest = 11825, side = 1, extra = 2, [108] = {55.00, 55.00} },
		{ quest = 11829, side = 1, extra = 2, [102] = {69.00, 52.00} },
		{ quest = 11830, side = 1, extra = 2, [109] = {31.00, 63.00} },
		{ quest = 11835, side = 2, extra = 2, [109] = {32.00, 68.00} },
		{ quest = 11843, side = 2, extra = 2, [105] = {50.00, 59.00} },
		{ quest = 11848, side = 2, extra = 2, [94] = {46.40, 50.60} },
		{ quest = 11850, side = 2, extra = 2, [95] = {46.00, 26.00} },
		{ quest = 11851, side = 2, extra = 2, [100] = {57.11, 42.05} },
		{ quest = 11855, side = 2, extra = 2, [104] = {33.00, 30.00} },
		{ quest = 11858, side = 2, extra = 2, [108] = {52.00, 43.00} },
		{ quest = 11863, side = 2, extra = 2, [102] = {35.44, 51.61} },
		{ quest = 13440, side = 2, extra = 1, [114] = {55.10, 20.20} },
		{ quest = 13441, side = 1, extra = 1, [114] = {51.10, 11.90} },
		{ quest = 13442, side = 2, extra = 1, [119] = {47.90, 66.00} },
		{ quest = 13443, side = 2, extra = 1, [115] = {75.10, 43.70} },
		{ quest = 13444, side = 2, extra = 1, [117] = {57.70, 15.70} },
		{ quest = 13445, side = 2, extra = 1, [116] = {34.10, 60.70} },
		{ quest = 13446, side = 2, extra = 1, [120] = {41.40, 87.00} },
		{ quest = 13447, side = 2, extra = 1, [127] = {77.70, 74.90} },
		{ quest = 13449, side = 2, extra = 1, [121] = {40.40, 61.00} },
		{ quest = 13450, side = 1, extra = 1, [119] = {47.30, 61.70} },
		{ quest = 13451, side = 1, extra = 1, [115] = {38.50, 48.40} },
		{ quest = 13453, side = 1, extra = 1, [117] = {48.40, 13.50} },
		{ quest = 13454, side = 1, extra = 1, [116] = {19.10, 61.30} },
		{ quest = 13455, side = 1, extra = 1, [120] = {40.30, 85.60} },
		{ quest = 13457, side = 1, extra = 1, [127] = {80.50, 53.00} },
		{ quest = 13458, side = 1, extra = 1, [121] = {43.20, 71.40} },
		{ quest = 13485, side = 1, extra = 2, [114] = {55.00, 20.00} },
		{ quest = 13486, side = 1, extra = 2, [119] = {47.00, 66.00} },
		{ quest = 13487, side = 1, extra = 2, [115] = {75.00, 44.00} },
		{ quest = 13488, side = 1, extra = 2, [117] = {58.00, 16.00} },
		{ quest = 13489, side = 1, extra = 2, [116] = {34.00, 61.00} },
		{ quest = 13490, side = 1, extra = 2, [120] = {42.00, 87.00} },
		{ quest = 13491, side = 1, extra = 2, [127] = {78.00, 75.00} },
		{ quest = 13492, side = 1, extra = 2, [121] = {41.00, 61.00} },
		{ quest = 13493, side = 2, extra = 2, [114] = {51.00, 12.00} },
		{ quest = 13494, side = 2, extra = 2, [119] = {47.00, 62.00} },
		{ quest = 13495, side = 2, extra = 2, [115] = {39.00, 48.00} },
		{ quest = 13496, side = 2, extra = 2, [117] = {48.00, 13.00} },
		{ quest = 13497, side = 2, extra = 2, [116] = {19.00, 61.00} },
		{ quest = 13498, side = 2, extra = 2, [120] = {40.00, 86.00} },
		{ quest = 13499, side = 2, extra = 2, [127] = {80.00, 53.00} },
		{ quest = 13500, side = 2, extra = 2, [121] = {43.00, 71.00} },
		{ quest = 32496, side = 1, extra = 1, [390] = {77.90, 33.90} },
		{ quest = 32497, side = 3, extra = 2, [422] = {56.07, 69.58} },
		{ quest = 32498, side = 3, extra = 2, [371] = {47.20, 47.20} },
		{ quest = 32499, side = 3, extra = 2, [418] = {77.75, 03.53} },
		{ quest = 32500, side = 3, extra = 2, [379] = {71.10, 90.90} },
		{ quest = 32501, side = 3, extra = 2, [388] = {71.50, 56.30} },
		{ quest = 32502, side = 3, extra = 2, [376] = {51.81, 51.32} },
		{ quest = 32503, side = 2, extra = 1, [390] = {79.80, 37.00} },
		{ quest = 32509, side = 2, extra = 2, [390] = {77.80, 33.10} },
		{ quest = 32510, side = 1, extra = 2, [390] = {79.60, 37.20} },
		{ quest = 44570, side = 3, extra = 2, [542] = {48.00, 44.70} },
		{ quest = 44571, side = 3, extra = 2, [535] = {43.50, 71.80} },
		{ quest = 44572, side = 3, extra = 2, [550] = {80.50, 47.70} },
		{ quest = 44573, side = 3, extra = 2, [543] = {43.90, 93.80} },
		{ quest = 44579, side = 1, extra = 2, [539] = {42.60, 36.00} },
		{ quest = 44580, side = 2, extra = 2, [525] = {72.60, 65.00} },
		{ quest = 44583, side = 1, extra = 1, [525] = {72.80, 65.20} },
		{ quest = 44582, side = 2, extra = 1, [539] = {42.80, 35.90} },
		{ quest = 44574, side = 3, extra = 2, [630] = {48.30, 29.70} },
		{ quest = 44575, side = 3, extra = 2, [641] = {44.90, 58.00} },
		{ quest = 44576, side = 3, extra = 2, [650] = {55.50, 84.50} },
		{ quest = 44577, side = 3, extra = 2, [634] = {32.50, 42.10} },
		{ quest = 44613, side = 1, extra = 2, [680] = {23.00, 58.40} },
		{ quest = 44614, side = 2, extra = 2, [680] = {30.40, 45.40} },
		{ quest = 44627, side = 1, extra = 1, [680] = {30.30, 45.40} },
		{ quest = 44624, side = 2, extra = 1, [680] = {22.80, 58.20} },
		{ quest = 54737, side = 1, extra = 2, [895] = {76.35, 49.88} },
		{ quest = 54741, side = 1, extra = 2, [942] = {35.85, 51.33} },
		{ quest = 54743, side = 1, extra = 2, [896] = {40.22, 47.60} },
		{ quest = 54736, side = 2, extra = 1, [895] = {76.33, 49.77} },
		{ quest = 54739, side = 2, extra = 1, [942] = {35.90, 51.42} },
		{ quest = 54742, side = 2, extra = 1, [896] = {40.18, 47.49} },
		{ quest = 54746, side = 1, extra = 1, [863] = {40.09, 74.21} },
		{ quest = 54749, side = 1, extra = 1, [864] = {55.97, 47.70} },
		{ quest = 54744, side = 1, extra = 1, [862] = {53.35, 48.07} },
		{ quest = 54747, side = 2, extra = 2, [863] = {40.03, 74.30} },
		{ quest = 54750, side = 2, extra = 2, [864] = {56.01, 47.76} },
		{ quest = 54745, side = 2, extra = 2, [862] = {53.31, 48.11} },
	},
	patterns = {
		"^%s*[Hh][Oo][Nn][Oo][Rr]%s+[Tt][Hh][Ee]%s+[Ff][Ll][Aa][Mm][Ee]%s*$",
		"^%s*[Ee][Hh][Rr][Tt]%s+[Dd][Ii][Ee]%s+[Ff][Ll][Aa][Mm][Mm][Ee]%s*$",
		"^%s*[Hh][Oo][Nn][Rr][Aa][Rr]%s+[Ll][Aa]%s+[Ll][Ll][Aa][Mm][Aa]%s*$",
		"^%s*[Hh][Oo][Nn][Oo][Rr][Ee][Rr]%s+[Ll][Aa]%s+[Ff][Ll][Aa][Mm][Mm][Ee]%s*$",
		"^%s*[Oo][Nn][Oo][Rr][Aa]%s+[Ii][Ll]%s+[Ff][Aa][Ll][òò]%s*$",
		"^%s*[Rr][Ee][Vv][Ee][Rr][Ee][Nn][Cc][Ii][Ee]%s+[Aa]%s+[Cc][Hh][Aa][Mm][Aa]%s*$",
		"^%s*[Пп][Оо][Кк][Лл][Оо][Нн][Ее][Нн][Ии][Ее]%s+[Оо][Гг][Нн][Юю]%s*$",
		"^%s*???%s+???%s*$",
		"^%s*祭拜这团火焰%s*$",
		"^%s*[Dd][Ee][Ss][Ee][Cc][Rr][Aa][Tt][Ee]%s+[Tt][Hh][Ii][Ss]%s+[Ff][Ii][Rr][Ee]%s*%!%s*$",
		"^%s*[Ee][Nn][Tt][Ww][Ee][Ii][Hh][Tt]%s+[Dd][Ii][Ee][Ss][Ee][Ss]%s+[Ff][Ee][Uu][Ee][Rr]%s*%!%s*$",
		"^%s*%?%s*[Pp][Rr][Oo][Ff][Aa][Nn][Aa]%s+[Ee][Ss][Tt][Ee]%s+[Ff][Uu][Ee][Gg][Oo]%s*%!%s*$",
		"^%s*[Dd][éé][Ss][Aa][Cc][Rr][Aa][Ll][Ii][Ss][Ee][Zz]%s+[Cc][Ee]%s+[Ff][Ee][Uu]%s*%!%s*$",
		"^%s*[Dd][Ii][Ss][Ss][Aa][Cc][Rr][Aa]%s+[Qq][Uu][Ee][Ss][Tt][Oo]%s+[Ff][Aa][Ll][òò]%s*%!%s*$",
		"^%s*[Pp][Rr][Oo][Ff][Aa][Nn][Ee]%s+[Oo]%s+[Ff][Oo][Gg][Oo]%s*%!%s*$",
		"^%s*[Оо][Сс][Кк][Вв][Ее][Рр][Нн][Ее][Нн][Ии][Ее]%s+[Оо][Гг][Нн][Яя]%s*$",
		"^%s*???%s+??%s*%!%s*$",
		"^%s*亵渎这团火焰%s*%！%s*$",
	}
}


if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
	return
end

---- Session--
CandyBuckets.FACTION = 0
CandyBuckets.QUESTS = {}
CandyBuckets.PROVIDERS = {}

CandyBuckets.COMPLETED_QUESTS = setmetatable({}, {
	__index = function(self, questID)
		local isCompleted = IsQuestFlaggedCompleted(questID)
		if isCompleted then
			rawset(self, questID, isCompleted)
		end
		return isCompleted
	end
})

---- Map--

CandyBuckets.PARENT_MAP = {}
do
	local parentMapIDs = {
		12, -- Kalimdor
		13, -- Eastern Kingdoms
		101, -- Outland
		113, -- Northrend
		127, -- Crystalsong Forest
		203, -- Vashj'ir
		224, -- Stranglethorn Vale
		390, -- Vale of Eternal Blossoms
		424, -- Pandaria
		572, -- Draenor
		619, -- Broken Isles
		862, -- Zuldazar
		875, -- Zandalar
		876, -- Kul Tiras
		895, -- Tiragarde Sound
		947, -- Azeroth (CPU hog, but it's not too bad?)
		948, -- The Maelstrom
		1165, -- Dazar'alor
	}

	for i = 1, #parentMapIDs do
		local uiMapID = parentMapIDs[i]
		local children = C_Map.GetMapChildrenInfo(uiMapID, nil, true) -- Enum.UIMapType.Zone

		for _, child in pairs(children) do
			if not CandyBuckets.PARENT_MAP[uiMapID] then
				CandyBuckets.PARENT_MAP[uiMapID] = {}
			end

			CandyBuckets.PARENT_MAP[uiMapID][child.mapID] = true
		end
	end
end

local function GetLowestLevelMapFromMapID(uiMapID, x, y)
	if not uiMapID or not x or not y then
		return uiMapID, x, y
	end

	local child = C_Map.GetMapInfoAtPosition(uiMapID, x, y)
	if not child or not child.mapID then
		return uiMapID, x, y
	end

	local continentID, worldPos = C_Map.GetWorldPosFromMapPos(uiMapID, { x = x, y = y })
	if not continentID or not worldPos then
		return uiMapID, x, y
	end

	local _, mapPos = C_Map.GetMapPosFromWorldPos(continentID, worldPos, child.mapID)
	if mapPos and mapPos.x and mapPos.y then
		return child.mapID, mapPos.x, mapPos.y
	end

	return uiMapID, x, y
end

local function GetPlayerMapAndPosition()
	local unit = "player"

	local uiMapID = C_Map.GetBestMapForUnit(unit)
	if not uiMapID then
		return
	end

	local pos = C_Map.GetPlayerMapPosition(uiMapID, unit)
	if not pos or not pos.x or not pos.y then
		return uiMapID
	end

	return uiMapID, pos
end

---- Waypoint--

-- CandyBuckets:GetWaypointAddon()
-- CandyBuckets:AutoWaypoint(poi, wholeModule, silent)
do
	local waypointAddons = {}

	-- TomTom (v80001-1.0.2)
	table.insert(waypointAddons, {
		name = "TomTom",
		func = function(self, poi, wholeModule)
			if wholeModule then
				self:funcAll(poi.quest.module)
				TomTom:SetClosestWaypoint()
			else
				local uiMapID = poi:GetMap():GetMapID()
				local x, y = poi:GetPosition()
				local childUiMapID, childX, childY = GetLowestLevelMapFromMapID(uiMapID, x, y)
				local mapInfo = C_Map.GetMapInfo(childUiMapID)
				TomTom:AddWaypoint(childUiMapID, childX, childY, {
					title = string.format("%s (%s, %d)", poi.name, mapInfo.name or "Map " .. childUiMapID, poi.quest.quest),
					minimap = true,
					crazy = true,
				})
			end
			return true
		end,
		funcAll = function(self, module)
			for i = 1, #CandyBuckets.QUESTS do
				local quest = CandyBuckets.QUESTS[i]
				if quest.module == module then
					for uiMapID, coords in pairs(quest) do
						if type(uiMapID) == "number" and type(coords) == "table" then
							local name = module.title[quest.extra or 1]
							local mapInfo = C_Map.GetMapInfo(uiMapID)
							TomTom:AddWaypoint(uiMapID, coords[1]/100, coords[2]/100, {
								title = string.format("%s (%s, %d)", name, mapInfo.name or "Map " .. uiMapID, quest.quest),
								minimap = true,
								crazy = true,
							})
						end
					end
				end
			end
			return true
		end,
	})

	local supportedAddons = ""
	local supportedAddonsWarned = false
	for i = 1, #waypointAddons do
		supportedAddons = supportedAddons .. waypointAddons[i].name .. " "
	end

	function CandyBuckets:GetWaypointAddon()
		for i = 1, #waypointAddons do
			local waypoint = waypointAddons[i]
			if IsAddOnLoaded(waypoint.name) then
				return waypoint
			end
		end
	end

	function CandyBuckets:AutoWaypoint(poi, wholeModule, silent)
		local waypoint = CandyBuckets:GetWaypointAddon()
		if not waypoint then
			if not silent then
				if not supportedAddonsWarned and supportedAddons ~= "" then
					supportedAddonsWarned = true
					DEFAULT_CHAT_FRAME:AddMessage("You need to install one of these supported waypoint addons: " .. supportedAddons, 1, 1, 0)
				end
			end
			return false
		end
		local status, err = pcall(function() return waypoint:func(poi, wholeModule) end)
		if not status or err ~= true then
			if not silent then
				DEFAULT_CHAT_FRAME:AddMessage("Unable to set waypoint using " .. waypoint.name .. (type(err) == "string" and ": " .. err or ""), 1, 1, 0)
			end
			return false
		end
		return true
	end
end

---- Mixin--

CandyBucketsDataProviderMixin = CreateFromMixins(MapCanvasDataProviderMixin)

function CandyBucketsDataProviderMixin:OnShow()
end

function CandyBucketsDataProviderMixin:OnHide()
end

function CandyBucketsDataProviderMixin:OnEvent(event, ...)
	-- self:RefreshAllData()
end

function CandyBucketsDataProviderMixin:RemoveAllData()
	self:GetMap():RemoveAllPinsByTemplate("CandyBucketsPinTemplate")
end

function CandyBucketsDataProviderMixin:RefreshAllData(fromOnShow)
	self:RemoveAllData()

	local uiMapID = self:GetMap():GetMapID()
	local childUiMapIDs = CandyBuckets.PARENT_MAP[uiMapID]

	for i = 1, #CandyBuckets.QUESTS do
		local quest = CandyBuckets.QUESTS[i]
		local poi, poi2

		if not childUiMapIDs then
			poi = quest[uiMapID]

		else
			for childUiMapID, _ in pairs(childUiMapIDs) do
				poi = quest[childUiMapID]

				if poi then
					local translateKey = uiMapID .. "," .. childUiMapID

					if poi[translateKey] ~= nil then
						poi = poi[translateKey]

					else
						local continentID, worldPos = C_Map.GetWorldPosFromMapPos(childUiMapID, CreateVector2D(poi[1]/100, poi[2]/100)) -- TODO: replace with a table and xy properties?
						poi, poi2 = nil, poi

						if continentID and worldPos then
							local _, mapPos = C_Map.GetMapPosFromWorldPos(continentID, worldPos, uiMapID)

							if mapPos then
								poi = mapPos
								poi2[translateKey] = mapPos
							end
						end

						if not poi then
							poi2[translateKey] = false
						end
					end

					break
				end
			end
		end

		if poi then
			self:GetMap():AcquirePin("CandyBucketsPinTemplate", quest, poi)
		end
	end

	if uiMapID == 947 then
		-- TODO: Azeroth map overlay of sorts with statistics per continent?
	end
end

--
-- Pin
--

local PIN_BORDER_COLOR = {
	[0] = "Interface\\Buttons\\GREYSCALERAMP64",
	[1] = "Interface\\Buttons\\BLUEGRAD64",
	[2] = "Interface\\Buttons\\REDGRAD64",
	[3] = "Interface\\Buttons\\YELLOWORANGE64",
}

CandyBucketsPinMixin = CreateFromMixins(MapCanvasPinMixin)

function CandyBucketsPinMixin:OnLoad()
	self:SetScalingLimits(1.2, 1.0, 1.6)  --1, 1.0, 1.2
	self.HighlightTexture:Hide()
	--self.hasTooltip = true
	--self:EnableMouse(self.hasTooltip)
	self.Texture:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
	self.Texture:ClearAllPoints()
	self.Texture:SetAllPoints()
	self.Border:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
	self.Border:SetTexture(PIN_BORDER_COLOR[0])
end

function CandyBucketsPinMixin:OnAcquired(quest, poi)
	self.quest = quest
	self:UseFrameLevelType("PIN_FRAME_LEVEL_GOSSIP", self:GetMap():GetNumActivePinsByTemplate("CandyBucketsPinTemplate"))
	self:SetSize(12, 12)
	self.Texture:SetTexture(quest.module.texture[quest.extra or 1])
	self.Border:SetTexture(PIN_BORDER_COLOR[quest.side or 0])
	self.name = quest.module.title[quest.extra or 1]
	if poi.GetXY then
		self:SetPosition(poi:GetXY())
	else
		self:SetPosition(poi[1]/100, poi[2]/100)
	end
	local uiMapID = self:GetMap():GetMapID()
	if uiMapID then
		local x, y = self:GetPosition()
		local childUiMapID, childX, childY = GetLowestLevelMapFromMapID(uiMapID, x, y)
		local mapInfo = C_Map.GetMapInfo(childUiMapID)
		if mapInfo and mapInfo.name and childX and childY then
			self.description = string.format("%s (%.2f, %.2f)", mapInfo.name, childX * 100, childY * 100)
		end
	end
end

function CandyBucketsPinMixin:OnReleased()
	self.quest, self.name, self.description = nil
end


function CandyBucketsPinMixin:OnClick(button)
	if button ~= "LeftButton" then return end
	CandyBuckets:AutoWaypoint(self, IsModifierKeyDown())
end

---- Modules--

CandyBuckets.modules = CandyBuckets.modules or {}

local MODULE_FROM_TEXTURE = {
	[235461] = "hallow",
	[235462] = "hallow",
	[235460] = "hallow",
	[235470] = "lunar",
	[235471] = "lunar",
	[235469] = "lunar",
	[235473] = "midsummer",
	[235474] = "midsummer",
	[235472] = "midsummer",
}

---- Addon--

local addon = CreateFrame("Frame")
addon:SetScript("OnEvent", function(addon, event, ...) addon[event](addon, event, ...) end)
addon:RegisterEvent("ADDON_LOADED")
addon:RegisterEvent("PLAYER_LOGIN")

local InjectDataProvider do
	local function WorldMapMixin_OnLoad(self)
		local dataProvider = CreateFromMixins(CandyBucketsDataProviderMixin)
		CandyBuckets.PROVIDERS[dataProvider] = true
		self:AddDataProvider(dataProvider)
	end

	function InjectDataProvider()
		hooksecurefunc(WorldMapMixin, "OnLoad", WorldMapMixin_OnLoad)
		WorldMapMixin_OnLoad(WorldMapFrame)
	end
end

function addon:RefreshAllWorldMaps(onlyShownMaps, fromOnShow)
	for dataProvider, _ in pairs(CandyBuckets.PROVIDERS) do
		if not onlyShownMaps or dataProvider:GetMap():IsShown() then
			dataProvider:RefreshAllData(fromOnShow)
		end
	end
end

function addon:RemoveQuestPois(questID)
	local removed = 0

	for i = #CandyBuckets.QUESTS, 1, -1 do
		local quest = CandyBuckets.QUESTS[i]

		if quest.quest == questID then
			removed = removed + 1
			table.remove(CandyBuckets.QUESTS, i)
		end
	end

	return removed > 0
end

function addon:CanLoadModule(name)
	return type(CandyBuckets.modules[name]) == "table" and CandyBuckets.modules[name].loaded ~= true
end

function addon:CanUnloadModule(name)
	return type(CandyBuckets.modules[name]) == "table" and CandyBuckets.modules[name].loaded == true
end

function addon:LoadModule(name)
	local module = CandyBuckets.modules[name]
	module.loaded = true

	local i = #CandyBuckets.QUESTS
	for j = 1, #module.quests do
		local quest = module.quests[j]

		if (not quest.side or quest.side == 3 or quest.side == CandyBuckets.FACTION) and not CandyBuckets.COMPLETED_QUESTS[quest.quest] then
			quest.module = module
			i = i + 1
			CandyBuckets.QUESTS[i] = quest
		end
	end

	addon:RefreshAllWorldMaps(true)
end

function addon:UnloadModule(name)
	local module = CandyBuckets.modules[name]
	module.loaded = false

	for i = #CandyBuckets.QUESTS, 1, -1 do
		local quest = CandyBuckets.QUESTS[i]

		if quest.module.event == name then
			table.remove(CandyBuckets.QUESTS, i)
		end
	end

	addon:RefreshAllWorldMaps(true)
end

function addon:CheckCalendar()
	local curHour, curMinute = GetGameTime()
	local curDate = C_Calendar.GetDate()
	local calDate = C_Calendar.GetMonthInfo()
	local month, day, year = calDate.month, curDate.monthDay, calDate.year
	local curMonth, curYear = curDate.month, curDate.year
	local monthOffset = -12 * (curYear - year) + month - curMonth
	local numEvents = C_Calendar.GetNumDayEvents(monthOffset, day)
	local loadedEvents, numLoaded, numLoadedRightNow = {}, 0, 0

	if monthOffset ~= 0 then
		return -- we only care about the current events, so we need the view to be on the current month (otherwise we unload the ongoing events if we change the month manually...)
	end

	for i = 1, numEvents do
		local event = C_Calendar.GetDayEvent(monthOffset, day, i)

		if event and event.calendarType == "HOLIDAY" then
			local ongoing = event.sequenceType == "ONGOING" -- or event.sequenceType == "INFO"
			local moduleName = MODULE_FROM_TEXTURE[event.iconTexture]

			if event.sequenceType == "START" then
				ongoing = curHour >= event.startTime.hour and (curHour > event.startTime.hour or curMinute >= event.startTime.minute)
			elseif event.sequenceType == "END" then
				ongoing = curHour <= event.endTime.hour and (curHour < event.endTime.hour or curMinute <= event.endTime.minute)
				-- TODO: linger for 3 hours extra just in case event is active but not in the calendar
				if not ongoing then
					local paddingHour = max(0, curHour - 3)
					ongoing = paddingHour <= event.endTime.hour and (paddingHour < event.endTime.hour or curMinute <= event.endTime.minute)
				end
			end

			if ongoing and addon:CanLoadModule(moduleName) then
				--DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF[CandyBuckets]|r|cffFFFFFF " .. event.title .. "|r!", 1, 1, 0)
				addon:LoadModule(moduleName)
				numLoadedRightNow = numLoadedRightNow + 1
				DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF[CandyBuckets]|r " .. event.title .. " [" .. #CandyBuckets.QUESTS .. "]|r !", 1, 1, 0)
			elseif not ongoing and addon:CanUnloadModule(moduleName) then
				DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF[CandyBuckets]|r has unloaded the module for |cffFFFFFF" .. event.title .. "|r because the event has ended.", 1, 1, 0)
				addon:UnloadModule(moduleName)
			end

			if moduleName and ongoing then
				loadedEvents[moduleName] = true
			end
		end
	end

	for name, module in pairs(CandyBuckets.modules) do
		if addon:CanUnloadModule(name) and not loadedEvents[name] then
			DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF[CandyBuckets]|r couldn't find |cffFFFFFF" .. name .. "|r in the calendar so we consider the event expired.", 1, 1, 0)
			addon:UnloadModule(name)
		end
	end

	for name, module in pairs(CandyBuckets.modules) do
		if addon:CanUnloadModule(name) then
			numLoaded = numLoaded + 1
		end
	end

	if numLoaded > 0 then
		addon:RegisterEvent("QUEST_TURNED_IN")
	else
		addon:UnregisterEvent("QUEST_TURNED_IN")
	end

	--if numLoadedRightNow > 0 then
		--DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF[CandyBuckets]|r Go → (" .. #CandyBuckets.QUESTS .. ") |r!", 1, 1, 0)
	--end
end

function addon:QueryCalendar(check)
	local function DelayedUpdate()
		if type(CalendarFrame) ~= "table" or not CalendarFrame:IsShown() then
			local curDate = C_Calendar.GetDate()
			C_Calendar.SetAbsMonth(curDate.month, curDate.year)
			C_Calendar.OpenCalendar()
		end
	end

	addon:RegisterEvent("CALENDAR_UPDATE_EVENT")
	addon:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	addon:RegisterEvent("INITIAL_CLUBS_LOADED")
	addon:RegisterEvent("GUILD_ROSTER_UPDATE")
	addon:RegisterEvent("PLAYER_GUILD_UPDATE")
	addon:RegisterEvent("PLAYER_ENTERING_WORLD")

	DelayedUpdate()
	C_Timer.After(10, DelayedUpdate)

	if check then
		addon:CheckCalendar()
	end
end

function addon:IsDeliveryLocationExpected(questID)
	local questCollection = {}
	local questName

	for i = 1, #CandyBuckets.QUESTS do
		local quest = CandyBuckets.QUESTS[i]
		if quest.quest == questID then
			table.insert(questCollection, quest)
		end
	end

	if not questCollection[1] then
		questName = C_QuestLog.GetQuestInfo(questID)

		if questName then
			local missingFromModule

			for name, module in pairs(CandyBuckets.modules) do
				if module.loaded == true then
					for _, pattern in pairs(module.patterns) do
						if questName:match(pattern) then
							missingFromModule = module
							break
						end
					end
					if missingFromModule then
						break
					end
				end
			end

			if missingFromModule then
				table.insert(questCollection, { missing = true, module = missingFromModule, quest = questID, side = 3 })
			end
		end
	end

	if not questCollection[1] then
		return nil, nil, nil
	end

	local uiMapID, pos = GetPlayerMapAndPosition()
	if not uiMapID then
		return nil, nil, nil
	elseif not pos then
		return nil, nil, nil
	end

	if questCollection[1].missing then
		for i = 1, #questCollection do
			questCollection[i][uiMapID] = { pos.x * 100, pos.y * 100 }
		end
	end

	local returnCount = 0
	local returns = {}

	for i = 1, #questCollection do
		local quest = questCollection[i]
		local qpos = quest[uiMapID]

		local ret = {}
		returnCount = returnCount + 1
		returns[returnCount] = ret

		repeat
			if type(qpos) == "table" then
				local distance = quest.missing and 1 or 0
		
				if not quest.missing then
					local dx = qpos[1]/100 - pos.x
					local dy = qpos[2]/100 - pos.y
		
					local dd = dx*dx + dy*dy
					if dd < 0 then
						ret.has, ret.success, ret.data = true, nil, nil
						break
					end
		
					distance = sqrt(dd)
				end
		
				if distance > 0.02 then
					ret.has, ret.success, ret.data = true, false, { quest = quest, uiMapID = uiMapID, x = pos.x, y = pos.y, distance = distance }
				else
					ret.has, ret.success = true, true
				end
		
			elseif not quest.missing then
				ret.has, ret.success, ret.data = true, false, { quest = quest, uiMapID = uiMapID, x = pos.x, y = pos.y, distance = 1 }
			end
		until true
	end

	for i = 1, returnCount do
		local ret = returns[i]
		if ret.has and ret.success then
			return ret.success, ret.data, returnCount
		end
	end

	for i = 1, returnCount do
		local ret = returns[i]
		if ret.has then
			return ret.success, ret.data, returnCount
		end
	end

	return true, nil, returnCount
end

--
-- Events
--

function addon:ADDON_LOADED(event, name)
	if name == "HandyNotes" then
		addon:UnregisterEvent(event)
		InjectDataProvider()
	end
end

function addon:PLAYER_LOGIN(event)
	addon:UnregisterEvent(event)

	local faction = UnitFactionGroup("player")
	if faction == "Alliance" then
		CandyBuckets.FACTION = 1
	elseif faction == "Horde" then
		CandyBuckets.FACTION = 2
	else
		CandyBuckets.FACTION = 3
	end

	GetQuestsCompleted(CandyBuckets.COMPLETED_QUESTS)
	addon:QueryCalendar(true)
end

function addon:CALENDAR_UPDATE_EVENT()
	addon:CheckCalendar()
end

function addon:CALENDAR_UPDATE_EVENT_LIST()
	addon:CheckCalendar()
end

function addon:INITIAL_CLUBS_LOADED()
	addon:CheckCalendar()
end

function addon:GUILD_ROSTER_UPDATE()
	addon:CheckCalendar()
end

function addon:PLAYER_GUILD_UPDATE()
	addon:CheckCalendar()
end

function addon:PLAYER_ENTERING_WORLD()
	addon:CheckCalendar()
end

function addon:QUEST_TURNED_IN(event, questID)
	CandyBuckets.COMPLETED_QUESTS[questID] = true
	local success, info, checkedNumQuestPOIs = addon:IsDeliveryLocationExpected(questID)
	if success == false then
		DEFAULT_CHAT_FRAME:AddMessage(format("|cffFFFFFF%s|r quest |cffFFFFFF%s#%d|r turned in at the wrong location. You were at |cffFFFFFF%d/%d/%.2f/%.2f|r roughly |cffFFFFFF%.2f|r units away from the expected %s. Please screenshot/copy this message and report it to the author. Thanks!", addonName, info.quest.module.event, questID, CandyBuckets.FACTION, info.uiMapID, info.x * 100, info.y * 100, info.distance * 100, checkedNumQuestPOIs and checkedNumQuestPOIs > 1 and checkedNumQuestPOIs .. " locations" or "location"), 1, 1, 0)
	end
	if addon:RemoveQuestPois(questID) then
		addon:RefreshAllWorldMaps(true)
	end
end
