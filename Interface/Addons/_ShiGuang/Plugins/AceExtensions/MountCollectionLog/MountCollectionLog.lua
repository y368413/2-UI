--------------------------------------------------------
-- Namespaces## Version: 2.3.8 ## Author: Discord: Cam#7332
--------------------------------------------------------
local MountCollectionlog = {}

MountCollectionlog.sectionNames = {}
MountCollectionlog.mountList = {}

MountCollectionlog.mountList[1] = {
	name = "暗影国度",
	categories = {
		Achievement = {
			name = "成就",
			mounts = {186654, 186637, 184183, 182596, 186653, 184166, 186655, 187673, "m1549", "m1576"},
			mountID = {"m15491", "m1549", "m1576"}
		},
		Vendor = {
			name = "商人",
			mounts = {180748},
			mountID = {}
		},
		Treasures = {
			name = "宝藏",
			mounts = {180731, 180772, 190766},
			mountID = {}
		},
		Adventures = {
			name = "冒险",
			mounts = {183052, 183617, 183615, 183618},
			mountID = {}
		},
		Riddles = {
			name = "解密",
			mounts = {184168,186713},
			mountID = {}
		},
		Tormentors = {
			name = "折磨者",
			mounts = {185973},
			mountID = {}
		},
		MawAssaults = {
			name = "噬渊突袭",
			mounts = {185996, 186000, 186103},
			mountID = {}
		},
		Reputation = {
			name = "声望",
			mounts = {180729, 182082, 183518, 183740, 186647, 186648, 187629, 187640},
			mountID = {}
		},
		ParagonReputation = {
			name = "巅峰声望",
			mounts = {182081, 183800, 186649, 186644, 186657, 186641},
			mountID = {}
		},
		DungeonDrop = {
			name = "地下城掉落",
			mounts = {181819, 186638, "m1445"},
			mountID = {1445}
		},
		RaidDrop = {
			name = "团本掉落",
			mounts = {186656, 186642, 190768},
			mountID = {}
		},
		Zone = {
			name = "区域",
			mounts = {181818},
			mountID = {}
		},
		DailyActivities = {
			name = "日常活动",
			mounts = {182614, 182589, 186643, 186651, 186646, 188808},
			mountID = {}
		},
		RareSpawn = {
			name = "稀有掉落",
			mounts = {180728, 180727, 180725, 182650, 180773, 182085, 184062, 182084, 182079, 180582, 183741, 184167, 187183, 186652 ,186645, 186659, 187676, 190765},
			mountID = {}
		},
		OozingNecrorayEgg = {
			name = "渗出粘液的通灵鳐之卵",
			mounts = {184160, 184161, 184162},
			mountID = {}
		},
		CovenantFeature = {
			name = "盟约特色",
			mounts = {180726, 181316, 181300, 181317},
			mountID = {}
		},
		NightFae = {
			name = "法夜",
			mounts = {180263, 180721, 183053, 180722, 180413, 180415, 180414, 180723, 183801, 180724, 180730, 186493, 186494, 186495, 186492},
			mountID = {}
		},
		Kyrian = {
			name = "格里恩",
			mounts = {180761, 180762, 180763, 180764, 180765, 180766, 180767, 180768, 186482, 186485, 186480, 186483},
			mountID = {}
		},
		Necrolords = {
			name = "通灵领主",
			mounts = {182078, 182077, 181822, 182076, 182075, 181821, 181815, 182074, 181820, 182080, 186487, 186488, 186490, 186489},
			mountID = {}
		},
		Venthyr = {
			name = "温西尔",
			mounts = {182954, 180581, 180948, 183715, 180945, 182209, 182332, 183798, 180461, 186476, 186478, 186477, 186479},
			mountID = {}				
		},
		ProtoformSynthesis = {
			name = "原生体合成",
			mounts = {187632, 187670, 187663, 187665, 187630, 187631, 187638, 187664, 187677, 187683, 190580, 187679, 187667, 187639, 188809, 187668, 188810, 187672, 187669, 187641, 187678, 187671, 187660, 187666},
			mountID = {}
		},
		Torghast = {
			name = "托加斯特",
			mounts = {188700, 188696, 188736},
			mountID = {}
		}
	}
}
MountCollectionlog.mountList[2] = {
	name = "争霸艾泽拉斯",
	categories = {
		Achievement = {
			name = "成就",
			mounts = {168056, 168055, 169162, 163577, 169194, 168329, 161215, 163216, 166539, 167171, 174861, 174654},
			mountID = {}
		},
		Vendor = {
			name = "商人",
			mounts = {163183, 166442, 166443, 163589, 169203, 169202, 174770},
			mountID = {}
		},
		Quest = {
			name = "任务",
			mounts = {159146, 168827, 168408, 169199, 174859, 174771, 169200, 170069},
			mountID = {}
		},
		Medals = {
			name = "服役勋章",
			mounts = {166464, 166436, 166469, 166465, 166463},
			mountID = {}
		},
		AlliedRaces = {
			name = "同盟种族",
			mounts = {155662, 156487, 161330, 157870, 174066, 156486, 155656, 161331, 164762, 174067},
			mountID = {}
		},
		Reputation = {
			name = "声望",
			mounts = {161773, 161774, 161665, 161666, 161667, 161664, 167167, 167170, 168829, 174754, 161911, 161912, 161910, 161879, 161909, 161908},
			mountID = {}
		},
		Riddle = {
			name = "解密",
			mounts = {156798},
			mountID = {}
		},
		Tinkering = {
			name = "制作",
			mounts = {167751},
			mountID = {}
		},
		Zone = {
			name = "区域",
			mounts = {163576, 163574, 163575, 163573},
			mountID = {}
		},
		RareSpawn = {
			name = "稀有掉落",
			mounts = {161479, 166433, 169201, 168370, 168823, 169163, 174860},
			mountID = {}
		},
		WorldBoss = {
			name = "世界首领",
			mounts = {174842},
			mountID = {}
		},
		WarfrontArathi = {
			name = "战争前线: 阿拉希",
			mounts = {163579, 163578, 163644, 163645, 163706, 163646},
			mountID = {}
		},
		WarfrontDarkshore = {
			name = "战争前线: 黑海岸",
			mounts = {166438, 166434, 166435, 166432},
			mountID = {}
		},
		AssaultVale = {
			name = "突袭: 锦绣谷",
			mounts = {173887, 174752, 174841, 174840, 174649},
			mountID = {}
		},
		AssaultUldum = {
			name = "突袭: 奥丹姆",
			mounts = {174769, 174641, 174753},
			mountID = {}
		},
		DungeonDrop = {
			name = "地下城掉落",
			mounts = {159921, 160829, 159842, 168826, 168830},
			mountID = {}
		},	
		RaidDrop = {
			name = "团本掉落",
			mounts = {166518, 166705, 174872},
			mountID = {}
		},	
		IslandExpedition = {
			name = "海岛探险",
			mounts = {163584, 163585, 163583, 163586, 163582, 166470, 166468, 166467, 166466},
			mountID = {}
		},	
		Dubloons = {
			name = "海员达布隆币",
			mounts = {166471, 166745},
			mountID = {}
		},
		Visions = {
			name = "惊魂幻象",
			mounts = {174653},
			mountID = {}
		},
		ParagonReputation = {
			name = "巅峰声望",
			mounts = {169198},
			mountID = {}
		}
	}
}
MountCollectionlog.mountList[3] = {
	name = "军团再临",
	categories = {
		Achievement = {
			name = "成就",
			mounts = {141216, 138387, 141217, 143864, 152815, 153041, 129280},
			mountID = {}
		},
		Vendor = {
			name = "商人",
			mounts = {138811, 141713, 137570},
			mountID = {}
		},
		Quest = {
			name = "任务",
			mounts = {137573, 142436, 137577, 137578, 137579, 137580},
			mountID = {}
		},
		Riddle = {
			name = "解密",
			mounts = {138201, 147835, 151623},
			mountID = {}
		},
		RareSpawn = {
			name = "稀有掉落",
			mounts = {138258, 152814, 152844, 152842, 152840, 152841, 152843, 152904, 152905, 152903, 152790},
			mountID = {}
		},
		DungeonDrop = {
			name = "地下城掉落",
			mounts = {142236, 142552},
			mountID = {}
		},
		RaidDrop = {
			name = "团本掉落",
			mounts = {137574, 143643, 152816, 137575, 152789},
			mountID = {}
		},
		Class = {
			name = "职业",
			mounts = {142231, 143502, 143503, 143505, 143504, 143493, 143492, 143490, 143491, 142225, 142232, 143489, 142227, 142228, 142226, 142233, 143637, "m868", "m860", "m861", "m898"},
			mountID = {868, 860, 861, 898}
		},
		ParagonReputation = {
			name = "巅峰声望",
			mounts = {147806, 147804, 147807, 147805, 143764, 153042, 153044, 153043},
			mountID = {}
		},
		Reputation = {
			name = "声望",
			mounts = {152788, 152797, 152793, 152795, 152794, 152796, 152791},
			mountID = {}
		}
	}																										
}
MountCollectionlog.mountList[4] = {
	name = "德拉诺之王",
	categories = {
		Achievement = {
			name = "成就",
			mounts = {116670, 116383, 127140, 128706},
			mountID = {}
		},
		Vendor = {
			name = "商人",
			mounts = {116664, 116785, 116776, 116775, 116772, 116672, 116768, 116671, 128480, 128526, 123974, 116667, 116655},
			mountID = {}
		},
		Garrison = {
			name = "要塞入侵",
			mounts = {116779, 116673, 116786, 116663},
			mountID = {}
		},
		Missions = {
			name = "要塞任务",
			mounts = {116769, 128311},
			mountID = {}
		},
		Stables = {
			name = "要塞兽栏",
			mounts = {116784, 116662, 116676, 116675, 116774, 116656, 116668, 116781},
			mountID = {}
		},
		TradingPost = {
			name = "要塞货栈",
			mounts = {116782, 116665},
			mountID = {}
		},
		RareSpawn = {
			name = "稀有掉落",
			mounts = {116674, 116659, 116661, 116792, 116767, 116773, 116794, 121815, 116780, 116669, 116658},
			mountID = {}
		},
		WorldBoss = {
			name = "世界首领",
			mounts = {116771},
			mountID = {}
		},
		RaidDrop = {
			name = "团本掉落",
			mounts = {116660, 123890},
			mountID = {}
		},
		FishingShack = {
			name = "要塞渔夫小屋",
			mounts = {87791},
			mountID = {}
		}		
	}		
}
MountCollectionlog.mountList[5] = {
	name = "熊猫人之谜",
	categories = {
		Achievement = {
			name = "成就",
			mounts = {87769, 87773, 81559, 93662, 104208, 89785},
			mountID = {}
		},
		GoldenLotus = {
			name = "金莲教",
			mounts = {87781, 87782, 87783},
			mountID = {}
		},
		CloudSerpent = {
			name = "云端翔龙骑士团",
			mounts = {85430, 85429, 79802},
			mountID = {}
		},
		ShadoPan = {
			name = "影踪派",
			mounts = {89305, 89306, 89307},
			mountID = {}
		},
		KunLai = {
			name = "昆莱山商人",
			mounts = {87788, 87789, 84101},
			mountID = {}
		},
		TheTillers = {
			name = "阡陌客",
			mounts = {89362, 89390, 89391},
			mountID = {}
		},
		PrimalEggs = {
			name = "原始恐龙蛋",
			mounts = {94291, 94292, 94293},
			mountID = {}
		},
		Quest = {
			name = "任务",
			mounts = {93386, 87768, 94290, 93385},
			mountID = {}
		},
		RaidDrop = {
			name = "团本掉落",
			mounts = {87777, 93666, 95059, 104253},
			mountID = {}
		},
		RareSpawn = {
			name = "稀有掉落",
			mounts = {90655, 94229, 94230, 94231, 104269},
			mountID = {}
		},
		WorldBoss = {
			name = "世界首领",
			mounts = {94228, 87771, 89783, 95057},
			mountID = {}
		},
		Reputation = {
			name = "声望",
			mounts = {93169, 95565, 81354, 89304, 85262, 89363, 87774, 93168, 95564},
			mountID = {}
		}
	}																																
}
MountCollectionlog.mountList[6] = {
	name = "大地的裂变",
	categories = {
		Achievement = {
			name = "成就",
			mounts = {62900, 62901, 69213, 69230, 77068},
			mountID = {}
		},
		Quest = {
			name = "任务",
			mounts = {54465},
			mountID = {}
		},
		Vendor = {
			name = "商人",
			mounts = {65356, 64999, 63044, 63045, 64998},
			mountID = {}
		},
		DungeonDrop = {
			name = "地下城掉落",
			mounts = {69747, 63040, 63043, 68823, 68824},
			mountID = {}
		},
		RaidDrop = {
			name = "团本掉落",
			mounts = {77067, 77069, 78919, 63041, 69224, 71665},
			mountID = {}
		},
		RareSpawn = {
			name = "稀有掉落",
			mounts = {67151, 63042, 63046},
			mountID = {}
		}		
	}										
}
MountCollectionlog.mountList[7] = {
	name = "巫妖王之怒",
	categories = {
		Achievement = {
			name = "成就",
			mounts = {44160, 45801, 45802, 51954, 51955},
			mountID = {}
		},
		Quest = {
			name = "任务",
			mounts = {43962, 52200},
			mountID = {}
		},
		Vendor = {
			name = "商人",
			mounts = {44690, 44231, 44234, 44226, 44689, 44230, 44235, 44225},
			mountID = {}
		},
		ArgentTournament = {
			name = "银色锦标赛",
			mounts = {46814, 45592, 45593, 45595, 45596, 45597, 46743, 46746, 46749, 46750, 46751, 46816, 47180, 45725, 45125, 45586, 45589, 45590, 45591, 46744, 46745, 46747, 46748, 46752, 46815, 46813},
			mountID = {}
		},
		Reputation = {
			name = "声望",
			mounts = {44080, 44086, 43955, 44707, 43958, 43961},
			mountID = {}
		},
		DungeonDrop = {
			name = "地下城掉落",
			mounts = {43951, 44151},
			mountID = {}
		},
		RaidDrop = {
			name = "团本掉落",
			mounts = {43952, 43953, 43954, 43986, 49636, 43959, 45693, 50818, 44083},
			mountID = {}
		},
		RareSpawn = {
			name = "稀有掉落",
			mounts = {44168},
			mountID = {}
		}			
	}																		
}
MountCollectionlog.mountList[8] = {
	name = "燃烧的远征",
	categories = {
		CenarionExpedition = {
			name = "塞纳里奥远征队",
			mounts = {33999},
			mountID = {}
		},
		Kurenai = {
			name = "库雷尼/玛格汉",
			mounts = {29227, 29231, 29229, 29230, 31830, 31832, 31834, 31836},
			mountID = {}
		},
		Netherwing = {
			name = "灵翼之龙",
			mounts = {32858, 32859, 32857, 32860, 32861, 32862},
			mountID = {}
		},
		Shatari = {
			name = "沙塔尔天空卫队",
			mounts = {32319, 32314, 32316, 32317, 32318},
			mountID = {}
		},
		Vendor = {
			name = "商人",
			mounts = {25473, 25527, 25528, 25529, 25470, 25471, 25472, 25477, 25531, 25532, 25533, 25474, 25475, 25476},
			mountID = {}
		},
		DungeonDrop = {
			name = "地下城掉落",
			mounts = {32768, 35513},
			mountID = {}
		},
		RaidDrop = {
			name = "团本掉落",
			mounts = {32458, 30480},
			mountID = {}
		}
	}
}
MountCollectionlog.mountList[9] = {
	name = "经典旧世",
	categories = {	
		Reputation = {
			name = "声望",
			mounts = {13086, 46102},
			mountID = {}
		},
		DungeonDrop = {
			name = "地下城掉落",
			mounts = {13335},
			mountID = {}
		},
		RaidDrop = {
			name = "团本掉落",
			mounts = {21218, 21321, 21323, 21324},
			mountID = {}
		}
	}						
}
MountCollectionlog.mountList[10] = {
	name = "联盟",
	categories = {	
		Human = {
			name = "人类",
			mounts = {18776, 18777, 18778, 5655, 2411, 2414, 5656},
			mountID = {}
		},
		NightElf = {
			name = "暗夜精灵",
			mounts = {18766, 18767, 18902, 8629, 8631, 8632, 47100},
			mountID = {}
		},
		Dwarf = {
			name = "矮人",
			mounts = {18785, 18786, 18787, 5864, 5872, 5873},
			mountID = {}
		},
		DarkIronDwarf = {
			name = "黑铁矮人",
			mounts = {191123},
			mountID = {}
		},
		Gnome = {
			name = "侏儒",
			mounts = {18772, 18773, 18774, 8563, 8595, 13322, 13321},
			mountID = {}
		},
		Draenei = {
			name = "德莱尼",
			mounts = {29745, 29746, 29747, 28481, 29743, 29744},
			mountID = {}
		},
		Worgen = {
			name = "狼人",
			mounts = {73839, 73838},
			mountID = {}
		},
		Pandaren = {
			name = "熊猫人",
			mounts = {91010, 91012, 91011, 91013, 91014, 91015, 91004, 91008, 91009, 91005, 91006, 91007},
			mountID = {}
		},
		Dracthyr = {
			name = "龙希尔",
			mounts = {201720, 201702, 201719, 201704, 198809, 198811, 198810, 198808},
			mountID = {},
		}		
	}				
}
MountCollectionlog.mountList[11] = {
	name = "部落",
	categories = {	
		Orc = {
			name = "兽人",
			mounts = {18796, 18798, 18797, 46099, 5668, 5665, 1132},
			mountID = {}
		},
		Undead = {
			name = "亡灵",
			mounts = {13334, 18791, 13331, 13332, 13333, 46308, 47101},
			mountID = {}
		},
		Tauren = {
			name = "牛头人",
			mounts = {18793, 18794, 18795, 15277, 15290, 46100},
			mountID = {}
		},
		Troll = {
			name = "巨魔",
			mounts = {18788, 18789, 18790, 8588, 8591, 8592},
			mountID = {}
		},
		Bloodelf = {
			name = "血精灵",
			mounts = {28936, 29223, 29224, 28927, 29220, 29221, 29222, 191566},
			mountID = {}
		},
		Goblin = {
			name = "地精",
			mounts = {62462, 62461},
			mountID = {}
		},			
		Pandaren = {
			name = "熊猫人",
			mounts = {91010, 91012, 91011, 91013, 91014, 91015, 91004, 91008, 91009, 91005, 91006, 91007},
			mountID = {}
		},
		Dracthyr = {
			name = "龙希尔",
			mounts = {201720, 201702, 201719, 201704, 198809, 198811, 198810, 198808},
			mountID = {},
		}
	}
}
MountCollectionlog.mountList[12] = {
	name = "专业技能",
	categories = {	
		Alchemy = {
			name = "炼金术",
			mounts = {65891},
			mountID = {}
		},
		Archeology = {
			name = "考古学",
			mounts = {60954, 64883, 131734},
			mountID = {}
		},
		Engineering = {
			name = "工程学",
			mounts = {34060, 41508, 34061, 44413, 87250, 87251, 95416, 161134, 153594},
			mountID = {}
		},
		Fishing = {
			name = "钓鱼",
			mounts = {46109, 23720, 152912, 163131},
			mountID = {}
		},
		Jewelcrafting = {
			name = "珠宝加工",
			mounts = {83088, 83087, 83090, 83089, 82453},
			mountID = {}
		},
		Tailoring = {
			name = "裁缝",
			mounts = {44554, 54797, 44558, 115363},
			mountID = {}
		},
		Leatherworking = {
			name = "制皮",
			mounts = {108883, 129962},
			mountID = {}
		},
		Blacksmith = {
			name = "锻造",
			mounts = {137686},
			mountID = {}
		}
	}
}
MountCollectionlog.mountList[13] = {
	name = "PVP",
	categories = {	
		Achievement = {
			name = "成就",
			mounts = {44223, 44224},
			mountID = {}
		},
		MarkHonor = {
			name = "荣耀印记",
			mounts = {19030, 29465, 29467, 29468, 29471, 35906, 43956, 29466, 29469, 29470, 29472, 19029, 34129, 44077},
			mountID = {}
		},
		Honor = {
			name = "荣誉",
			mounts = {140228, 140233, 140408, 140232, 140230, 140407, 164250},
			mountID = {}
		},
		ViciousSaddle = {
			name = "邪气鞍座",
			mounts = {102533, 70910, 116778, 124540, 140348, 140354, 143649, 142235, 142437, 152869, 163124, 165020, 163121, 173713, 184013,184014, 186179, 70909, 102514, 116777, 124089, 140353, 140350, 143648, 142234, 142237, 152870, 163123, 163122, 173714, 186178, 187681, 187680, 187642, 187644, 201788, 201789, 205245, 205246, 210070, 210069, 213439, 213440},
			mountID = {}
		},
		Gladiator = {
			name = "角斗士",
			mounts = {},
			mountID = {}
		},
		Halaa = {
			name = "哈兰",
			mounts = {28915, 29228},
			mountID = {}
		},
		TimelessIsle = {
			name = "永恒岛",
			mounts = {103638},
			mountID = {}
		},
		TalonsVengeance = {
			name = "复仇之爪",
			mounts = {142369},
			mountID = {}
		}
	}
}
MountCollectionlog.mountList[14] = {
	name = "世界事件",
	categories = {	
		Achievement = {
			name = "成就",
			mounts = {44177},
			mountID = {}
		},
		Brewfest = {
			name = "美酒节",
			mounts = {33977, 37828},
			mountID = {}
		},
		HallowsEnd = {
			name = "万圣节",
			mounts = {37012},
			mountID = {}
		},
		LoveAir = {
			name = "情人节",
			mounts = {72146, 50250, 210973},
			mountID = {}
		},
		NobleGarden = {
			name = "复活节",
			mounts = {72145, 212599},
			mountID = {}
		},
		WinterVeil = {
			name = "冬幕节",
			mounts = {128671},
			mountID = {}
		},
		Brawlers = {
			name = "搏击俱乐部",
			mounts = {98405, 142403, 166724},
			mountID = {}
		},
		DarkmoonFaire = {
			name = "暗月马戏团",
			mounts = {72140, 73766, 142398, 153485},
			mountID = {}
		},
		TimeWalking = {
			name = "时空漫游",
			mounts = {129923, 129922, 87775, 167894, 167895, 133543, 188674, 187595, 231374, 224398, 224399},
			mountID = {}
		}
	}
}
MountCollectionlog.mountList[15] = {
	name = "促销",
	categories = {	
		BlizzardStore = {
			name = "游戏商城",
			mounts = {54811, 69846, 78924, 95341, 97989, 107951, 112326, 122469, 147901, 156564, 160589, 166775, 166774, 166776, "m1266", "m1267", "m1290", "m1346", "m1291", "m1456", "m1330", "m1531", "m1581", "m1312", "m1662", 76755, "m1594", "m1583", "m1797", 203727, "m1795", "m1692", 212229, 228751, 229128, 219450, 224574, "m2237", 229418},
			mountID = {1266, 1267, 1290, 1346, 1291, 1456, 1330, 1531, 1581}
		},
		CollectorsEdition = {
			name = "典藏版",
			mounts = {85870, 109013, 128425, 153539, 153540, "m1289", "m1556", "m1792"},
			mountID = {1289, 1556}
		},
		WowClassic = {
			name = "魔兽世界: 经典怀旧服",
			mounts = {"m1444", "m1602", "m1812"},
			mountID = {1444, 1602}
		},
		anniversary = {
			name = "魔兽世界周年庆",
			mounts = {172022, 172023, 186469, 208572, 228760},
			mountID = {}
		},
		Hearthstone = {
			name = "炉石传说",
			mounts = {98618, "m1513", 163186, 212522},
			mountID = {1513}
		},
		WarcraftIII = {
			name = "魔兽争霸III: 重制版",
			mounts = {164571},
			mountID = {}
		},
		DiabloIV = {
			name = "暗黑破坏神IV",
			mounts = {"m1596"},
			mountID = {}
		},		
		RAF = {
			name = "战友招募",
			mounts = {173297, 173299, 204091},
			mountID = {}
		},
		AzerothChoppers = {
			name = "艾泽拉斯机车",
			mounts = {116789},
			mountID = {}
		},
		TCG = {
			name = "集换卡牌游戏",
			mounts = {49283, 49284, 49285, 49286, 49282, 49290, 54069, 54068, 68008, 69228, 68825, 71718, 72582, 72575, 79771, 93671},
			mountID = {}
		},
		AV = {
			name = "时空漫游: 奥特兰克山谷",
			mounts = {172023, 172022},
			mountID = {}
		},
		PlunderStorm = {
			name="强袭风暴",
			mounts = {"m1259","m994", "m2090"},
		},
		ProductPromotion = {
			name="Product Promotion",
			mounts = {"m1947", "m1946"}
		}
	}	
}
MountCollectionlog.mountList[16] = {
	name = "其他",
	categories = {	
		GuildVendor = {
			name = "公会商人",
			mounts = {63125, 62298, 67107, 85666, 116666},
			mountID = {}
		},
		BMAH = {
			name = "黑市拍卖行",
			mounts = {19872, 19902, 44175, 163042},
			mountID = {}
		},
		MountCollection = {
			name = "坐骑收集",
			mounts = {44178, 44843, 44842, 98104, 91802, 98259, 69226, 87776, 137614, 163981, 118676, 198654},
			mountID = {}
		},
		ExaltedReputations = {
			name = "声望崇拜",
			mounts = {163982},
			mountID = {}
		},
		Toy = {
			name = "玩具",
			mounts = {140500},
			mountID = {}
		},
		Heirlooms = {
			name = "传家宝",
			mounts = {120968, 122703},
			mountID = {}
		},
		Paladin = {
			name="圣骑士",
			mounts = {47179, "m2233", "m41", "m84", "m149", "m150", "m350", "m351", "m367", "m368", "m1046", "m1047", "m1568"},
			mountID = {}
		},
		Warlock = {
			name="术士",
			mounts = {"m17", "m83"},
			mountID = {17, 83},
		},
		DemonHunter = {
			name="恶魔猎手",
			mounts = {"m780"},
		},
		TradingPost = {
			name = "商栈",
			mounts = {190231, 190168, 190539, 190767, 190613, 206156, 137576, 208598, 211074, 210919, 212227, 212630, 212920, 192766, 226041, 226040, 226044, 226042, 226506, 223449, 223469, 187674},
		},		
	}
}
MountCollectionlog.mountList[17] = {
	name = "绝版",
	categories = {	
		MythicPlus = {
			name = "史诗钥石地下城",
			mounts = {182717, 187525, 174836, 187682, 192557, 199412, 204798, 209060, 213438},
			mountID = {}
		},
		ScrollOfResurrection = {
			name = "复活卷轴",
			mounts = {76902, 76889},
			mountID = {}
		},
		ChallengeMode = {
			name = "黄金挑战",
			mounts = {89154, 90710, 90711, 90712, 116791},
			mountID = {}
		},
		RAF = {
			name = "战友招募",
			mounts = {83086, 106246, 118515, 37719, "m382"},
			mountID = {}
		},
		AOTC = {
			name = "引领潮流",
			mounts = {104246, 128422, 152901, 174862, 190771},
			mountID = {}
		},
		Brawl = {
			name = "搏击俱乐部",
			mounts = {142403, 98405},
			mountID = {}
		},
		Arena = {
			name = "角斗士坐骑",
			mounts = {30609, 34092, 37676, 43516, 46708, 46171, 47840, 50435, 71339, 71954, 85785, 95041, 104325, 104326, 104327, 128277, 128281, 128282, 141843, 141844, 141845, 141846, 141847, 141848, 153493, 156879, 156880, 156881, 156884, 183937, 186177, 189507, 191290, 202086, 210345}, --210077
			mountID = {}
		},
		DCAzerothChopper = {
			name = "艾泽拉斯机车",
			mounts = {116788},
			mountID = {}
		},
		OriginalEpic = {
			name = "旧版史诗坐骑",
			mounts = {13328, 13329, 13327, 13326, 12354, 12353, 12302, 12303, 12351, 12330, 15292, 15293, 13317, 8586},
			mountID = {}
		},
		Promotion = {
			name = "旧版促销坐骑",
			mounts = {76755, 95341, 112327, 92724, 143631, 163128, 163127, 43599, 151618, "m1458"},
			mountID = {}
		},	
		RaidMounts = {
			name = "绝版团本坐骑",
			mounts = {49098, 49096, 49046, 49044, 44164, 33809, 21176, "m937"},
			mountID = {937}
		},
		BrewFest = {
			name = "美酒节",
			mounts = {33976},
			mountID = {}
		},
		Anniversary = {
			name="旧版庆典坐骑",
			mounts = {172012, 115484, "m1424"},
			mountID = {}
		},
		PreLaunchEvent = {
			name = "前夕事件",
			mounts = {163127, 163128, 217987, 217985},
			mountID = {}
		},
		RemixMOP = {
			name="幻境新生: 潘达利亚",
			mounts = {220766,220768,213582,213576,213584,213595,87784,213602,213603,213605,213606,213607,213604,213608,213609,213628,213627,87786,87787,84753,213626,213624,213625,213623,213622,213621,218111,213600,213601,213598,213597,213596},	
		}
	}
}
MountCollectionlog.mountList[18] = {
	name = "巨龙时代",
	categories = {
		DragonRiding = {
			name = "驭龙术",
			mounts = {194034, 194705, 194521, 194549, 204361, 210412}
		},
		Achievement = {
			name = "成就",
			mounts = {192806, 192791, 192784, 205205, 208152, 210060, 192774, 210142, "m1614", 198822, 192792, 192788, 211862, 192765, "m1733", 217340},
		},
		Treasures = {
			name = "宝藏",
			mounts = {201440, 198825, 192777, 192779,205204, 210059},
		},
		Quest = {
			name = "任务",
			mounts = {192799, 198870, 206567, 206566, "m1545", 210774, 211873},
		},
		Reputation = {		
			name = "声望",
			mounts = {192762, 198872, 192761, 192764, 200118, 201426, 201425, 205155, 205209, 205207, 210969, 210833, 210831, 210946, 210948, 210945, 209951, 209949},
		},
		Zone = {
			name = "区域",
			mounts = {192601, 198873, 198871, 192775, 201454, 192800, 204382, 192785, 192790, 192772, 191838, 205203, 205197,210775, 210769, 210058, 210057, 209947, 209950, 212645, "m1638", 192807, 198824},
		},
		Secret = {
			name = "解密",
			mounts = {192786}
		},
		Vendor = {
			name = "商人",
			mounts = {206673, 206680, 206676, 206678, 206674, 206679, 206675, 211084}
		},
		Raid = {
			name = "团队副本",
			mounts = {"m1818"}
		},
	}
}
MountCollectionlog.mountList[19] = {
	name = "地心之战",
	categories = {
		RareDrops = {
			name = "稀有掉落",
			mounts = {223315,223270,223501},
		},
		Raid = {
			name = "团队副本",
			mounts = {224147,224151},
		},
		Dungeon = {
			name = "地下城",
			mounts = {221765,225548},
		},
		Achievement = {
			name = "成就",
			mounts = {223266,224415,226357,223267,223286,223158},
		},
		Quest = {
			name = "任务",
			mounts = {219391,224150},
		},
		Reputation = {
			name = "声望",
			mounts = {223571,221753,223505,222989,223317,223314,223274,223264,223276,223278,223279},
		},
		Profession = {
			name = "专业技能",
			mounts = {221967},
		},
		Vendor = {
			name = "商人",
			mounts = {223153},
		},
		PVP = {
			name = "PVP",
			mounts = {223511,221813,223586},
		},
		Zone = {
			name = "区域",
			mounts = {223269, 223318},
		},			
	}
}

MountCollectionlog.sectionNames[11] = {
	name = "经典旧世",
	mounts = MountCollectionlog.mountList[9],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\classic.blp",
}
MountCollectionlog.sectionNames[10] = {
	name = "燃烧的远征",
	mounts = MountCollectionlog.mountList[8],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\bc.blp",
}
MountCollectionlog.sectionNames[9] = {
	name = "巫妖王之怒",
	mounts = MountCollectionlog.mountList[7],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\wrath.blp",
}
MountCollectionlog.sectionNames[8] = {
	name = "大地的裂变",
	mounts = MountCollectionlog.mountList[6],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\cata.blp",
}
MountCollectionlog.sectionNames[7] = {
	name = "熊猫人之谜",
	mounts = MountCollectionlog.mountList[5],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\mists.blp",
}
MountCollectionlog.sectionNames[6] = {
	name = "德拉诺之王",
	mounts = MountCollectionlog.mountList[4],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\wod.blp",
}
MountCollectionlog.sectionNames[5] = {
	name = "军团再临",
	mounts = MountCollectionlog.mountList[3],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\legion.blp",
}
MountCollectionlog.sectionNames[4] = {
	name = "争霸艾泽拉斯",
	mounts = MountCollectionlog.mountList[2],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\bfa.blp",
}
MountCollectionlog.sectionNames[3] = {
	name = "暗影国度",
	mounts = MountCollectionlog.mountList[1],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\sl.blp",
}
MountCollectionlog.sectionNames[2] = {
	name = "巨龙时代",
	mounts = MountCollectionlog.mountList[18],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\df.blp",
}
MountCollectionlog.sectionNames[1] = {
	name = "地心之战",
	mounts = MountCollectionlog.mountList[19],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\tww.blp",
}
MountCollectionlog.sectionNames[12] = {
	name = "部落",
	mounts = MountCollectionlog.mountList[11],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\horde.blp",
}
MountCollectionlog.sectionNames[13] = {
	name = "联盟",
	mounts = MountCollectionlog.mountList[10],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\alliance.blp",
}
MountCollectionlog.sectionNames[14] = {
	name = "专业技能",
	mounts = MountCollectionlog.mountList[12],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\professions.blp",
}
MountCollectionlog.sectionNames[15] = {
	name = "PVP",
	mounts = MountCollectionlog.mountList[13],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\pvp.blp",
}
MountCollectionlog.sectionNames[16] = {
	name = "世界事件",
	mounts = MountCollectionlog.mountList[14],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\holiday.blp",
}
MountCollectionlog.sectionNames[17] = {
	name = "促销",
	mounts = MountCollectionlog.mountList[15],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\promotion.blp",
}
MountCollectionlog.sectionNames[18] = {
	name = "其他",
	mounts = MountCollectionlog.mountList[16],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\other.blp",
}
MountCollectionlog.sectionNames[19] = {
	name = "绝版",
	mounts = MountCollectionlog.mountList[17],
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\unobtainable.blp",
}
MountCollectionlog.sectionNames[20] = {
	name = "标记",
	mounts = {MCL_PINNED},
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\pin.blp",	
}
MountCollectionlog.sectionNames[21] = {
	name = "总览",
	mounts = {},
	icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\mcl.blp",	
}

MountCollectionlog.Function = {};
local MCL_functions = MountCollectionlog.Function;

if GetLocale() == "zhCN" then
  MountCollectionlogLocal = "|cff69ccf0[藏品]|r坐骑收集";
elseif GetLocale() == "zhTW" then
  MountCollectionlogLocal = "|cff69ccf0[藏品]|r坐骑收集";
else
  MountCollectionlogLocal = "Mount Collection log";
end

MountCollectionlog.mounts = {}
MountCollectionlog.stats= {}
MountCollectionlog.overviewStats = {}
MountCollectionlog.overviewFrames = {}
MountCollectionlog.mountFrames = {}
MountCollectionlog.mountCheck = {}
--MountCollectionlog.addon_name = "Mount Collection Log | MCL"


function MCL_functions:getFaction()
    -- * --------------------------------
    -- * Get's player faction
    -- * --------------------------------
	if UnitFactionGroup("player") == "Alliance" then
		return "部落" -- Inverse
	else
		return "联盟" -- Inverse
	end
end

-- local function IsMountFactionSpecific(id)
--     if string.sub(id, 1, 1) == "m" then
--         mount_Id = string.sub(id, 2, -1)
--         local mountName, spellID, icon, _, _, _, _, isFactionSpecific, faction, _, isCollected, mountID, _ = C_MountJournal.GetMountInfoByID(mount_Id)
--         return faction, isFactionSpecific
--     else
--         mount_Id = C_MountJournal.GetMountFromItem(id)
--         local mountName, spellID, icon, _, _, _, _, isFactionSpecific, faction, _, isCollected, mountID, _ = C_MountJournal.GetMountInfoByID(mount_Id)
--         return faction, isFactionSpecific
--     end
-- end

local function GetMountInfoByIDChecked(mount_Id)
    local mountName, spellID, icon, _, _, _, _, isFactionSpecific, faction, _, isCollected, mountID, _ = C_MountJournal.GetMountInfoByID(mount_Id)
    return faction, isFactionSpecific
end

local function IsMountFactionSpecific(id)
    local mount_Id, ok, faction, isFactionSpecific

    if string.sub(id, 1, 1) == "m" then
        mount_Id = string.sub(id, 2, -1)
    else
        mount_Id = C_MountJournal.GetMountFromItem(id)
    end

    -- Use pcall to execute GetMountInfoByIDChecked and capture any error
    ok, faction, isFactionSpecific = pcall(GetMountInfoByIDChecked, mount_Id)

    -- If an error occurred, print the error message along with the id that caused the error
    if not ok then
        return nil, nil
    else
        return faction, isFactionSpecific
    end
end

function MCL_functions:resetToDefault(setting)
    if setting == nil then
        MCL_SETTINGS = {}        
        MCL_SETTINGS.unobtainable = false
    end
    if setting == "Opacity" or setting == nil then
        MCL_SETTINGS.opacity = 0.95
    end
    if setting == "Texture" or setting == nil then
        MCL_SETTINGS.statusBarTexture = nil
    end
    if setting == "Colors" or setting == nil then
        MCL_SETTINGS.progressColors = {
            low = {
                ["a"] = 1,
                ["r"] = 0.929,
                ["g"] = 0.007,
                ["b"] = 0.019,
            },
            high = {
                ["a"] = 1,
                ["r"] = 0.1,
                ["g"] = 0.9,
                ["b"] = 0.1,
            },
            medium = {
                ["a"] = 1,
                ["r"] = 0.941,
                ["g"] = 0.658,
                ["b"] = 0.019,
            },
            complete = {
                ["a"] = 1,
                ["r"] = 0,
                ["g"] = 0.5,
                ["b"] = 0.9,
            },
        }
    end

end

if MCL_SETTINGS == nil then
    MountCollectionlog.Function:resetToDefault()
end

-- Tables Mounts into Global List
function MCL_functions:TableMounts(id, frame, section, category)
    local mount = {
        id = id,
        frame = frame,
        section =  section,
        category = category,
    }
    table.insert(MountCollectionlog.mounts, mount)
end

function MCL_functions:simplearmoryLink()
    local region = GetCVar("portal")

    local realmName = GetRealmName()

    local playerName = UnitName("player")

    local string = "https://simplearmory.com/#/"..region.."/"..realmName.."/"..playerName

    KethoEditBox_Show(string)

end

function MCL_functions:dfaLink()
    local region = GetCVar("portal")

    local realmName = GetRealmName()

    local playerName = UnitName("player")

    local string = "https://www.dataforazeroth.com/characters/"..region.."/"..realmName.."/"..playerName

    KethoEditBox_Show(string)

end

function MCL_functions:compareLink()
    local region = GetCVar("portal")

    local realmName = GetRealmName()

    local playerName = UnitName("player")
    local targetName, targetRealm
    if UnitIsPlayer("target") then
        targetName, targetRealm = UnitName("target")
        if targetRealm == nil then
            targetRealm = realmName
        end
    else
        KethoEditBox_Show("挂载需要目标")
        return
    end
    
    local string = "https://wow-mcl.herokuapp.com/?realma="..region.."."..realmName.."&charactera="..playerName.."&realmb="..region.."."..targetRealm.."&characterb="..targetName
    
    KethoEditBox_Show(string)
end


function KethoEditBox_Show(text)
    if not KethoEditBox then
        local f = CreateFrame("Frame", "KethoEditBox", UIParent, "DialogBoxFrame")
        f:SetPoint("CENTER")
        f:SetSize(700, 100)
        
        f:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\PVPFrame\\UI-Character-PVP-Highlight", -- this one is neat
            edgeSize = 16,
            insets = { left = 8, right = 6, top = 8, bottom = 8 },
        })
        f:SetBackdropBorderColor(0, .44, .87, 0.5) -- darkblue
        
        -- Movable
        f:SetMovable(true)
        f:SetClampedToScreen(true)
        f:SetScript("OnMouseDown", function(self, button)
            if button == "LeftButton" then
                self:StartMoving()
            end
        end)
        f:SetScript("OnMouseUp", f.StopMovingOrSizing)
        
        -- ScrollFrame
        local sf = CreateFrame("ScrollFrame", "KethoEditBoxScrollFrame", KethoEditBox, "UIPanelScrollFrameTemplate")
        sf:SetPoint("LEFT", 16, 0)
        sf:SetPoint("RIGHT", -32, 0)
        sf:SetPoint("TOP", 0, -16)
        sf:SetPoint("BOTTOM", KethoEditBoxButton, "TOP", 0, 0)
        
        -- EditBox
        local eb = CreateFrame("EditBox", "KethoEditBoxEditBox", KethoEditBoxScrollFrame)
        eb:SetSize(sf:GetSize())
        eb:SetMultiLine(true)
        eb:SetAutoFocus(false) -- dont automatically focus
        eb:SetFontObject("ChatFontNormal")
        eb:SetScript("OnEscapePressed", function() f:Hide() end)
        sf:SetScrollChild(eb)
        
        -- Resizable
        f:SetResizable(true)
        f:SetFrameStrata("HIGH")
        
        f:Show()
    end
    
    if text then
        KethoEditBoxEditBox:SetText(text)
    end
    KethoEditBox:Show()
    MountCollectionlog.MCL_MF:Hide()
end

function MCL_functions:initSections()
    -- * --------------------------------
    -- * Create variables and assign strings to each section.
    -- * --------------------------------

    local faction = MCL_functions:getFaction()
    MountCollectionlog.sections = {}

    for i, v in ipairs(MountCollectionlog.sectionNames) do
        local success, err = pcall(function()
            if v.name ~= faction then
                local t = {
                    name = v.name,
                    icon = v.icon
                }
                table.insert(MountCollectionlog.sections, t)
            else
                -- Skip opposite faction
            end
        end)

        -- if not success then
        --     print("分类名迭代错误 "..v.name..": "..err)
        -- end
    end

    MountCollectionlog.MCL_MF_Nav = MountCollectionlog.Frames:createNavFrame(MountCollectionlog.MCL_MF, 'Sections')

    local tabFrames, numTabs = MountCollectionlog.Frames:SetTabs() 

    local function OverviewStats(relativeFrame)
        MountCollectionlog.Frames:createOverviewCategory(MountCollectionlog.sections, relativeFrame)
        -- MountCollectionlog.Frames:createCategoryFrame(MountCollectionlog.sections, relativeFrame)
    end

    MountCollectionlog.sectionFrames = {}
    for i=1, numTabs do
        local success, err = pcall(function()
            local section_frame = MountCollectionlog.Frames:createContentFrame(tabFrames[i], MountCollectionlog.sections[i].name)
            table.insert(MountCollectionlog.sectionFrames, section_frame)

            for ii,v in ipairs(MountCollectionlog.sectionNames) do
                if v.name == "总览" then
                    MountCollectionlog.overview = section_frame        
                elseif v.name == MountCollectionlog.sections[i].name then
                    if v.name == "标记" then
                        local category = CreateFrame("Frame", "PinnedFrame", section_frame, "BackdropTemplate");
                        category:SetWidth(60);
                        category:SetHeight(60);
                        category:SetPoint("TOPLEFT", section_frame, "TOPLEFT", 0, 0);
                        local overflow, mountFrame = MountCollectionlog.Function:CreateMountsForCategory(MCL_PINNED, category, 30, tabFrames[i], true, true)
                        table.insert(MountCollectionlog.mountFrames, mountFrame)
                        category.info = category:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                        category.info:SetPoint("TOP", 450, -0)
                        category.info:SetText("Ctrl + 右键 标记未收集的坐骑")
                    end                   
                    -- ! Create Frame for each category
                    if v.mounts then
                        for k,val in pairs(v.mounts) do
                            if k == 'categories' then
                                local section = MountCollectionlog.Frames:createCategoryFrame(val, section_frame)
                                table.insert(MountCollectionlog.stats, section)
                            end
                        end
                    end 
                end            
            end
        end)
        
        if not success then
            --print("迭代错误 "..i..": "..err)
        end
    end    

    OverviewStats(MountCollectionlog.overview)


end


function MCL_functions:GetCollectedMounts()
    local mounts = {}
    for k,v in pairs(C_MountJournal.GetMountIDs()) do
        local mountName, spellID, icon, _, isUsable, _, _, isFactionSpecific, faction, _, isCollected, mountID = C_MountJournal.GetMountInfoByID(v)
        if isCollected then
            if faction then
                if faction == 1 then
                    faction = "Alliance"
                else
                    faction = "Horde"
                end
            end
            if (isFactionSpecific == false) or (isFactionSpecific == true and faction == UnitFactionGroup("player")) then                     
                table.insert(mounts, mountID)
            end   
        end
    end
    for k,v in pairs(mounts) do
        local exists = false
        for kk,vv in pairs(MountCollectionlog.mountCheck) do
            if v == vv then
                exists = true
            end
        end
        if exists == false then
            print(v)
        end
    end
end

function MCL_functions:CreateBorder(frame, side)
    frame.borders = frame:CreateLine(nil, "BACKGROUND", nil, 0)
    local l = frame.borders
    l:SetThickness(1)
    l:SetColorTexture(1, 1, 1, 0.4)
	l:SetStartPoint("BOTTOM"..side)
	l:SetEndPoint("TOP"..side)
    return frame
end


function MCL_functions:CreateFullBorder(self)
    if not self.borders then
        self.borders = {}
        for i=1, 4 do
            self.borders[i] = self:CreateLine(nil, "BACKGROUND", nil, 0)
            local l = self.borders[i]
            l:SetThickness(2)
            l:SetColorTexture(0, 0, 0, 0.7)
            if i==1 then
                l:SetStartPoint("TOPLEFT", 0, 1)
                l:SetEndPoint("TOPRIGHT", 0, 1)
            elseif i==2 then
                l:SetStartPoint("TOPRIGHT", 0, 1)
                l:SetEndPoint("BOTTOMRIGHT", 0, 2)
            elseif i==3 then
                l:SetStartPoint("BOTTOMRIGHT", 0, 2)
                l:SetEndPoint("BOTTOMLEFT", 0, 2)
            else
                l:SetStartPoint("BOTTOMLEFT", 0, 2)
                l:SetEndPoint("TOPLEFT", 0, 1)
            end
        end
    end
end

function MCL_functions:getTableLength(set)
    local i = 1
    for k,v in pairs(set) do
        i = i+1
    end
    return i
end

function MCL_functions:SetMouseClickFunctionalityPin(frame, mountID, mountName, itemLink, spellID, isSteadyFlight)
    frame:SetScript("OnMouseDown", function(self, button)
        if IsControlKeyDown() then
            if button == 'LeftButton' then
                DressUpMount(mountID)
            elseif button == 'RightButton' then
                if IsMountCollected(mountID) == false then
                    local pin = false
                    local pin_count = table.getn(MCL_PINNED)
                    if pin_count ~= nil then                     
                        for i=1, pin_count do                      
                            if MCL_PINNED[i].mountID == "m"..mountID then
                                pin = i
                            end
                        end
                    end
                                          
                    table.remove(MCL_PINNED, pin)
                    local index = 0
                    for k,v in pairs(MountCollectionlog.mountFrames[1]) do
                        index = index + 1
                        if tostring(v.mountID) == tostring(mountID) then
                            table.remove(MountCollectionlog.mountFrames[1],  index)
                            for kk,vv in ipairs(MountCollectionlog.mountFrames[1]) do
                                if kk == 1 then
                                    vv:SetParent(_G["PinnedFrame"])
                                else
                                    vv:SetParent(MountCollectionlog.mountFrames[1][kk-1])
                                end
                            end
                            frame:Hide()
                            MountCollectionlog.Function:UpdateCollection()
                        end
                    end
                end
            end               
        elseif button=='LeftButton' then
            if (itemLink) then
                frame:SetScript("OnHyperlinkClick", ChatFrame_OnHyperlinkShow(_, itemLink, itemLink, _))
            elseif (spellID) then
                frame:SetScript("OnHyperlinkClick", ChatFrame_OnHyperlinkShow(_, GetSpellLink(spellID), GetSpellLink(spellID), _))
            end
        end
        if button == 'RightButton' then
            CastSpellByName(mountName);
        end
    end)
end

function MCL_functions:SetMouseClickFunctionality(frame, mountID, mountName, itemLink, spellID, isSteadyFlight) -- * Mount Frames

    frame:SetScript("OnMouseDown", function(self, button)
        if IsControlKeyDown() then
            if button == 'LeftButton' then
                DressUpMount(mountID)
            elseif button == 'RightButton' then
                if IsMountCollected(mountID) == false then
                    local pin = false
                    local pin_count = table.getn(MCL_PINNED)
                    if pin_count ~= nil then                     
                        for i=1, pin_count do                      
                            if MCL_PINNED[i].mountID == "m"..mountID then
                                pin = i
                            end
                        end
                    end
                    if pin ~= false then
                        frame.pin:SetAlpha(0)
                        table.remove(MCL_PINNED, pin)
                        local index = 0
                        for k,v in pairs(MountCollectionlog.mountFrames[1]) do
                            index = index + 1
                            if tostring(v.mountID) == tostring(mountID) then
                                MountCollectionlog.mountFrames[1][index]:Hide()                                
                                table.remove(MountCollectionlog.mountFrames[1],  index)
                                for kk,vv in ipairs(MountCollectionlog.mountFrames[1]) do
                                    if kk == 1 then
                                        vv:SetParent(_G["PinnedFrame"])
                                        vv:Show()
                                    else
                                        vv:SetParent(MountCollectionlog.mountFrames[1][kk-1])
                                        vv:Show()
                                    end
                                end                                
                            end
                        end
                    else	                            
                        frame.pin:SetAlpha(1)
                        local t = {
                            mountID = "m"..mountID,
                            category = frame.category,
                            section = frame.section
                        }
                        if pin_count == nil then
                            MCL_PINNED[1] = t
                        else
                            MCL_PINNED[pin_count+1] = t
                        end
                        MountCollectionlog.Function:CreatePinnedMount(mountID, frame.category, frame.section)

                    end
                end
            end               
        elseif button=='LeftButton' then
            if isSteadyFlight then
                if frame.pop and frame.pop:IsShown() then 
                    frame.pop:Hide()
                elseif frame.pop then
                    frame.pop:Show()
                end
            else
                if (itemLink) then
                    frame:SetScript("OnHyperlinkClick", function()
                        ChatFrame_OnHyperlinkShow(nil, itemLink, "LeftButton")
                    end)
                elseif (spellID) then
                    frame:SetScript("OnHyperlinkClick", ChatFrame_OnHyperlinkShow(_, GetSpellLink(spellID), GetSpellLink(spellID), _))
                end
            end
        end
        if button == 'RightButton' then
            CastSpellByName(mountName);
        end
    end)
end

function MCL_functions:LinkMountItem(id, frame, pin, dragonriding)
	--Adding a tooltip for mounts
    if string.sub(id, 1, 1) == "m" then
        id = string.sub(id, 2, -1)
        local mountName, spellID, icon, _, _, _, _, isFactionSpecific, faction, _, isCollected, mountID, isSteadyFlight = C_MountJournal.GetMountInfoByID(id)

        frame:HookScript("OnEnter", function()
            GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT")
            if (spellID) then
                _, description, source, _, mountTypeID, _, _, _, _ = C_MountJournal.GetMountInfoExtraByID(id) 

                GameTooltip:SetSpellByID(spellID)
                GameTooltip:AddLine(source) 
                GameTooltip:Show()
                frame:SetHyperlinksEnabled(true)
            end
        end)
        frame:HookScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        if pin == true then
            MountCollectionlog.Function:SetMouseClickFunctionalityPin(frame, mountID, mountName, itemLink, spellID, isSteadyFlight)
        else
            MountCollectionlog.Function:SetMouseClickFunctionality(frame, mountID, mountName, itemLink, spellID, isSteadyFlight)
        end  
    else
        local item, itemLink = GetItemInfo(id);
        if dragonriding then
            frame:HookScript("OnEnter", function()
                GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT")
                if (id) then
                    GameTooltip:SetItemByID(id)
                    GameTooltip:AddLine(frame.source)
                    GameTooltip:Show()
                    frame:SetHyperlinksEnabled(true)
                end
            end)
            frame:HookScript("OnLeave", function()
                GameTooltip:Hide()
            end)

        else
            local mountID = C_MountJournal.GetMountFromItem(id)
            local mountName, spellID, icon, _, _, _, _, isFactionSpecific, faction, _, isCollected, mountID, isSteadyFlight = C_MountJournal.GetMountInfoByID(mountID)
        
            frame:HookScript("OnEnter", function()
                GameTooltip:SetOwner(frame, "ANCHOR_TOP")
                if (itemLink) then
                    frame:SetHyperlinksEnabled(true)
                    _, description, source, _, mountTypeID, _, _, _, _ = C_MountJournal.GetMountInfoExtraByID(mountID)                     
                    GameTooltip:SetHyperlink(itemLink)
                    GameTooltip:AddLine(source)
                    GameTooltip:Show()
                end
            end)
            frame:HookScript("OnLeave", function()
                GameTooltip:Hide()
            end)
            if pin == true then
                MountCollectionlog.Function:SetMouseClickFunctionalityPin(frame, mountID, mountName, itemLink, _, isSteadyFlight)
            else
                MountCollectionlog.Function:SetMouseClickFunctionality(frame, mountID, mountName, itemLink, _, isSteadyFlight)
            end
        end
    end
     
end


function MCL_functions:CompareMountJournal()
    print("正在与坐骑收藏比较")
    local mounts = {}
    local i = 1
    for k,v in pairs(C_MountJournal.GetMountIDs()) do
        mounts[i] = v
        for kk,vv in pairs(MountCollectionlog.mounts) do
            if vv.id == mounts[i] then
                mounts[i] = nil
            end
        end
    end
    for x,y in ipairs(mounts) do
        if y ~= nil then
            local mountName, spellID, icon, _, _, _, _, isFactionSpecific, faction, _, isCollected, mountID, _ = C_MountJournal.GetMountInfoByID(y)
            print(mountName, mountID)
        end
    end
end


function MCL_functions:CheckIfPinned(mountID)
    if MCL_PINNED == nil then
        MCL_PINNED = {}
    end
    for k,v in pairs(MCL_PINNED) do
        if v.mountID == mountID then
            return true, k
        end
    end
    return false, nil
end


function MCL_functions:CreateMountsForCategory(set, relativeFrame, frame_size, tab, skip_total, pin)

    local category = relativeFrame
    local previous_frame = relativeFrame
    local count = 0
    local first_frame
    local overflow = 0
    local mountFrames = {}
    local val
    local mountName, spellID, icon, _, _, sourceType, _, isFactionSpecific, faction, _, isCollected, mountID, sourceText, isSteadyFlight

    for kk,vv in pairs(set) do
        local mount_Id
        if pin then
            val = vv.mountID
        else
            val = vv
        end
        if string.sub(val, 1, 1) == "m" then
            mount_Id = string.sub(val, 2, -1)
            mountName, spellID, icon, _, _, sourceType, _, isFactionSpecific, faction, _, isCollected, mountID, isSteadyFlight = C_MountJournal.GetMountInfoByID(mount_Id)
            _,_, sourceText =  C_MountJournal.GetMountInfoExtraByID(mount_Id)
        else
            mount_Id = C_MountJournal.GetMountFromItem(val)
            mountName, spellID, icon, _, _, sourceType, _, isFactionSpecific, faction, _, isCollected, mountID, isSteadyFlight = C_MountJournal.GetMountInfoByID(mount_Id)
        end        
        local faction, faction_specific = IsMountFactionSpecific(val)
        if faction then
            if faction == 1 then
                faction = "Alliance"
            else
                faction = "Horde"
            end
        end
        if (faction_specific == false) or (faction_specific == true and faction == UnitFactionGroup("player")) then
            if count == 12 then
                overflow = overflow + frame_size + 10
            end            
            local frame = CreateFrame("Button", nil, relativeFrame, "BackdropTemplate");
            frame:SetWidth(frame_size);
            frame:SetHeight(frame_size);
            frame:SetBackdrop({
                edgeFile = [[Interface\Buttons\WHITE8x8]],
                edgeSize = frame_size + 2,
                bgFile = [[Interface\Buttons\WHITE8x8]],              
            })

            frame.pin = frame:CreateTexture()
            frame.pin:SetWidth(24)
            frame.pin:SetHeight(24)
            frame.pin:SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\pin.blp")
            frame.pin:SetPoint("TOPLEFT", frame, "TOPLEFT", 20,12)
            frame.pin:SetAlpha(0)

            frame.category = category.category
            frame.section = category.section

            frame.dragonRidable = isSteadyFlight


            frame:SetBackdropBorderColor(1, 0, 0, 0.03)
            frame:SetBackdropColor(0, 0, 0, MCL_SETTINGS.opacity)


            frame.tex = frame:CreateTexture()
            frame.tex:SetSize(frame_size, frame_size)
            frame.tex:SetPoint("LEFT")

            if string.sub(val, 1, 1) == "m" then
                frame.tex:SetTexture(icon)
            else
                frame.tex:SetTexture(GetItemIcon(val))
            end
        
            frame.tex:SetVertexColor(0.75, 0.75, 0.75, 0.3);

            frame.mountID = mount_Id
            frame.itemID = val            

            local pin_check = MountCollectionlog.Function:CheckIfPinned("m"..frame.mountID)
            if pin_check == true then
                frame.pin:SetAlpha(1)
            else
                frame.pin:SetAlpha(0)
            end              

            if pin then
                local y = 30
                if previous_frame == category then
                    y = 0
                end

                frame.sectionName = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                frame.sectionName:SetPoint("LEFT", 650, 0)
                frame.sectionName:SetText(vv.section)

                frame.categoryName = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                frame.categoryName:SetPoint("LEFT", 850, 0)
                frame.categoryName:SetText(vv.category)  
                
                frame.mountName = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                frame.mountName:SetPoint("LEFT", 50, 0)
                frame.mountName:SetText(mountName)  
                
                frame.sourceText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                frame.sourceText:SetPoint("LEFT", 250, 0)
                frame.sourceText:SetText(sourceText)  
                
                frame.border = frame:CreateLine(nil, "BACKGROUND", nil, 0)
                frame.border:SetThickness(3)
                frame.border:SetColorTexture(1, 1, 1, 0.3)
                frame.border:SetStartPoint("BOTTOMLEFT")
                frame.border:SetEndPoint("BOTTOMRIGHT")
                frame:SetWidth(1000)
                frame:SetHeight(frame.sourceText:GetStringHeight()+20)
                
                frame:SetBackdrop({
                    bgFile = [[Interface\Buttons\WHITE8x8]],              
                })

                frame:SetBackdropBorderColor(0, 0, 0, MCL_SETTINGS.opacity)
                frame:SetBackdropColor(0, 0, 0, MCL_SETTINGS.opacity)
                frame.tex:SetVertexColor(1, 1, 1, 1)

                frame.pin:SetAlpha(0)

                frame:SetPoint("BOTTOMLEFT", previous_frame, "BOTTOMLEFT", 0, -frame.sourceText:GetStringHeight()-y);
                
                frame.sourceText:SetJustifyH("LEFT")              
                
                previous_frame = frame
            elseif count == 12 then
                frame:SetPoint("BOTTOMLEFT", first_frame, "BOTTOMLEFT", 0, -overflow);
                count = 0           
            elseif relativeFrame == category then
                frame:SetPoint("BOTTOMLEFT", category, "BOTTOMLEFT", 0, -35);
                first_frame = frame
            else
                frame:SetPoint("RIGHT", relativeFrame, "RIGHT", frame_size+10, 0);
            end          

            MountCollectionlog.Function:LinkMountItem(val, frame, pin)

            relativeFrame = frame
            count = count + 1
            if skip_total == true then
            else
                if tab then
                    MCL_functions:TableMounts(mount_Id, frame, tab, category)
                end
            end
            table.insert(mountFrames, frame)
        end  
    end   
    return overflow, mountFrames
end


function MCL_functions:CreatePinnedMount(mount_Id, category, section)

    local frame_size = 30
    local mountFrames = {}
    local total_pinned = table.getn(MountCollectionlog.mountFrames[1])
    if total_pinned == 0 then
        local overflow, mountFrame = MountCollectionlog.Function:CreateMountsForCategory(MCL_PINNED, _G["PinnedFrame"], 30, _G["PinnedTab"], true, true)
        MountCollectionlog.mountFrames[1] = mountFrame
    else
        local relativeFrame = MountCollectionlog.mountFrames[1][total_pinned]

        local mountName, spellID, icon, _, _, sourceType, _, isFactionSpecific, faction, _, isCollected, mountID, _ = C_MountJournal.GetMountInfoByID(mount_Id)
        _,_, sourceText =  C_MountJournal.GetMountInfoExtraByID(mount_Id)

        local frame = CreateFrame("Button", nil, relativeFrame, "BackdropTemplate");
        frame:SetWidth(frame_size);
        frame:SetHeight(frame_size);
        frame:SetBackdrop({
            -- edgeFile = [[Interface\Buttons\WHITE8x8]],
            -- edgeSize = frame_size + 2,
            bgFile = [[Interface\Buttons\WHITE8x8]],
            tileSize = frame_size + 2,    
        })

        frame.pin = frame:CreateTexture()
        frame.pin:SetWidth(24)
        frame.pin:SetHeight(24)
        frame.pin:SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\pin.blp")
        frame.pin:SetPoint("TOPLEFT", frame, "TOPLEFT", 20,12)
        frame.pin:SetAlpha(1)

        frame.tex = frame:CreateTexture()
        frame.tex:SetSize(frame_size, frame_size)
        frame.tex:SetPoint("LEFT")
        local mountName, spellID, icon, _, _, _, _, isFactionSpecific, faction, _, isCollected, mountID, _ = C_MountJournal.GetMountInfoByID(mount_Id)
        frame.tex:SetTexture(icon)

        frame.tex:SetVertexColor(0.75, 0.75, 0.75, 0.3);        

        frame.category = category
        frame.section = section

        frame.sectionName = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        frame.sectionName:SetPoint("LEFT", 650, 0)
        frame.sectionName:SetText(section)

        frame.categoryName = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        frame.categoryName:SetPoint("LEFT", 850, 0)
        frame.categoryName:SetText(category)
        
        frame.mountName = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        frame.mountName:SetPoint("LEFT", 50, 0)
        frame.mountName:SetText(mountName)  
        
        frame.sourceText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        frame.sourceText:SetPoint("LEFT", 250, 0)
        frame.sourceText:SetText(sourceText)          

        frame.border = frame:CreateLine(nil, "BACKGROUND", nil, 0)
        frame.border:SetThickness(1)
        frame.border:SetColorTexture(1, 1, 1, 0.8)
        frame.border:SetStartPoint("BOTTOMLEFT")
        frame.border:SetEndPoint("BOTTOMRIGHT")
        frame:SetWidth(1000)
        frame:SetHeight(frame.sourceText:GetStringHeight()+20)
        frame:SetBackdropBorderColor(0, 0, 0, MCL_SETTINGS.opacity)
        frame:SetBackdropColor(0, 0, 0, MCL_SETTINGS.opacity)
        frame.tex:SetVertexColor(1, 1, 1, 1)

        frame.pin:SetAlpha(0)

        frame:SetPoint("BOTTOMLEFT", relativeFrame, "BOTTOMLEFT", 0, -frame.sourceText:GetStringHeight()-30);

        frame.sourceText:SetJustifyH("LEFT") 

        frame.mountID = mount_Id

        MountCollectionlog.Function:LinkMountItem("m"..tostring(mount_Id), frame, true)

        table.insert(MountCollectionlog.mountFrames[1], frame)
  
    end
end


function MCL_functions:GetMountID(id)
    if string.sub(id, 1, 1) == "m" then
        mount_Id = string.sub(id, 2, -1)
    else
        mount_Id = C_MountJournal.GetMountFromItem(id)
    end
    return mount_Id
end

function IsMountCollected(id)
    local mountName, spellID, icon, _, _, _, _, isFactionSpecific, faction, _, isCollected, mountID = C_MountJournal.GetMountInfoByID(id)
    return isCollected
end

function UpdateBackground(frame)
    local pinned, pin = MountCollectionlog.Function:CheckIfPinned(frame.mountID)
    if pinned == true then
        table.remove(MCL_PINNED, pin)
    end
    frame:SetBackdropBorderColor(0, 0.45, 0, 0.4)
    frame.tex:SetVertexColor(1, 1, 1, 1);	
end


function UpdateProgressBar(frame, total, collected)
    if not frame then
        return
    end    
    if total == nil and collected == nil then
    else
        if total == 0 then
            return
        end
        frame.collected = collected
        frame.total = total
        frame:SetValue((collected/total)*100)
        frame.Text:SetText(collected.."/"..total.." ("..math.floor(((collected/total)*100)).."%)")
        frame.val = (collected/total)*100
    end
    if frame.val == nil then
        return frame
    end
        if frame.val < 33 then
            frame:SetStatusBarColor(MCL_SETTINGS.progressColors.low.r, MCL_SETTINGS.progressColors.low.g, MCL_SETTINGS.progressColors.low.b)
        elseif frame.val < 66 then
            frame:SetStatusBarColor(MCL_SETTINGS.progressColors.medium.r, MCL_SETTINGS.progressColors.medium.g, MCL_SETTINGS.progressColors.medium.b) -- orange
        elseif frame.val < 100 then
            frame:SetStatusBarColor(MCL_SETTINGS.progressColors.high.r, MCL_SETTINGS.progressColors.high.g, MCL_SETTINGS.progressColors.high.b) -- green
        elseif frame.val == 100 then frame:SetStatusBarColor(MCL_SETTINGS.progressColors.complete.r, MCL_SETTINGS.progressColors.complete.g, MCL_SETTINGS.progressColors.complete.b)--blue
        end
    return frame
end

function UpdateProgressBarColor(frame)
	frame:SetStatusBarColor(0, 0.5, 0.9)
end

local function clearOverviewStats()
    for k in pairs (MountCollectionlog.overviewStats) do
        MountCollectionlog.overviewStats[k] = nil
    end
end

local function IsMountPinned(id)
    for k,v in pairs(MountCollectionlog.mountFrames[1]) do
        if v.mountID == id then
            return true 
        end
    end
end

local function UpdatePin(frame)
    local pinned, pin = MountCollectionlog.Function:CheckIfPinned("m"..tostring(frame.mountID))
    if pinned == true then
        frame.pin:SetAlpha(1)
    else
        frame.pin:SetAlpha(0)
    end
end   


function MCL_functions:UpdateCollection()
    clearOverviewStats()
    MountCollectionlog.MCL_MF.Bg:SetVertexColor(0,0,0,MCL_SETTINGS.opacity)
    MountCollectionlog.total = 0
    MountCollectionlog.collected = 0
    for k,v in pairs(MountCollectionlog.mounts) do
        MountCollectionlog.total = MountCollectionlog.total + 1
        if IsMountCollected(v.id) then
            table.insert(MountCollectionlog.mountCheck, v.id)
            UpdateBackground(v.frame)
            MountCollectionlog.collected = MountCollectionlog.collected + 1
            local pin = false
            local pin_count = table.getn(MCL_PINNED)
            if pin_count ~= nil then                     
                for i=1, pin_count do                      
                    if MCL_PINNED[i].mountID == "m"..v.frame.mountID then
                        table.remove(MCL_PINNED, i)
                    end
                end
            end
            UpdatePin(v.frame)                
            local index = 0
            for kk,vv in pairs(MountCollectionlog.mountFrames[1]) do
                index = index + 1
                if tostring(vv.mountID) == tostring(v.frame.mountID) then
                    local f = MountCollectionlog.mountFrames[1][index]
                    table.remove(MountCollectionlog.mountFrames[1],  index)
                    for kkk,vvv in ipairs(MountCollectionlog.mountFrames[1]) do
                        if kkk == 1 then
                            vvv:SetParent(_G["PinnedFrame"])
                        else
                            vvv:SetParent(MountCollectionlog.mountFrames[1][kkk-1])
                        end
                    end
                    f:Hide()
                end
            end            

        else
            UpdatePin(v.frame)
        end
    end
    for k,v in pairs(MountCollectionlog.stats) do
        local section_total = 0
        local section_collected = 0
        local section_name
        -- if (type(v) == "table") then
        for kk,vv in pairs(v) do
            local collected = 0
            local total = 0
            local isCollected

            if (type(vv) == "table") then
                if vv["mounts"] then
                    for kkk, vvv in pairs(vv.mounts) do
                        local faction, faction_specific = IsMountFactionSpecific(vvv)
                        if faction then
                            if faction == 1 then
                                faction = "Alliance"
                            else
                                faction = "Horde"
                            end
                        end
                        if (faction_specific == false) or (faction_specific == true and faction == UnitFactionGroup("player")) then                     
                            if string.sub(vvv, 1, 1 ) == "m" then
                                isCollected = IsMountCollected(string.sub(vvv, 2, -1))
                            else
                                local id = MountCollectionlog.Function:GetMountID(vvv)
                                isCollected = IsMountCollected(id)
                            end
                            if isCollected then
                                collected = collected +1
                            end
                            total = total +1
                        end
                    end
                    vv.pBar = UpdateProgressBar(vv.pBar, total, collected)
                    section_total = section_total + total
                    section_collected = section_collected + collected
                else
                    vv.pBar = UpdateProgressBar(vv.pBar, section_total, section_collected)
                end
                if vv["rel"] then
                    for q,e in pairs(MountCollectionlog.overviewFrames) do
                        if e.name == vv.rel.title:GetText() then                       
                            e.frame = UpdateProgressBar(e.frame, section_total, section_collected)
                            section_name = vv.rel.title:GetText()
                        end
                    end                     
                end               
            end            
        end
        if section_name == "绝版" then
            MountCollectionlog.total = MountCollectionlog.total + section_collected - section_total
        end
    end
    MountCollectionlog.overview.pBar = UpdateProgressBar(MountCollectionlog.overview.pBar, MountCollectionlog.total, MountCollectionlog.collected)
end


function MCL_functions:updateFromSettings(setting, val)
    for k,v in pairs(MountCollectionlog.statusBarFrames) do
        if setting == "texture" then
            v:SetStatusBarTexture(MountCollectionlog.media:Fetch("statusbar", MCL_SETTINGS.statusBarTexture))
        elseif setting == "progressColor" then
            v = UpdateProgressBar(v)
        end
    end
    if setting == "opacity" then
        MountCollectionlog.MCL_MF.Bg:SetVertexColor(0,0,0,MCL_SETTINGS.opacity)
    elseif setting:lower() == "unobtainable" then
        for k,v in pairs(MountCollectionlog.overviewFrames) do
            if v.name:lower() == setting:lower() then
                if val == true then
                    v.frame:GetParent():Hide()
                    v.frame.unobtainable = true
                else 
                    v.frame.unobtainable = false
                    v.frame:GetParent():Show()
                end
            end
        end
    end
end

--------------------------------------------------
-- Minimap Icon
--------------------------------------------------

function MCL_functions:test()
    print("Test")
end


local MCL_MM = LibStub("AceAddon-3.0"):NewAddon("MCL_MM", "AceConsole-3.0")
local MCL_LDB = LibStub("LibDataBroker-1.1"):NewDataObject("MCL!", {
type = "data source",
text = "MCL!",
icon = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\mcl-logo-32",
--OnTooltipShow = function(tooltip)
    --tooltip:SetText("MCL")
    --tooltip:AddLine("Mount Collection Log", 1, 1, 1)
    --tooltip:Show()
--end,
OnClick = function(_, button) 
	MountCollectionlog.Main:Toggle() 
end,
})
local icon = LibStub("LibDBIcon-1.0")

function MCL_MM:OnInitialize() -- Obviously you'll need a ## SavedVariables: BunniesDB line in your TOC, duh!
	self.db = LibStub("AceDB-3.0"):New("MCL_DB", { profile = { minimap = { hide = false, }, }, }) icon:Register("MCL!", MCL_LDB, self.db.profile.minimap) self:RegisterChatCommand("mcl", "UpdateMinimapButton")
end

function MCL_MM:MCL_MM()
	self.db.profile.minimap.hide = not self.db.profile.minimap.hide
	if self.db.profile.minimap.hide then
		icon:Hide("MCL!")
	else
		icon:Show("MCL!")
	end
end

function MCL_functions:MCL_MM()
	MCL_MM:MCL_MM()
end


function MCL_functions:updateFromDefaults(setting)
    MountCollectionlog.Function:resetToDefault(setting)
    MountCollectionlog.Function:updateFromSettings("opacity")
    MountCollectionlog.Function:updateFromSettings("texture")
    MountCollectionlog.Function:updateFromSettings("progressColor")
    MountCollectionlog.Function:updateFromSettings("unobtainable", false)
end

function MCL_functions:AddonSettings()
    local AceConfig = LibStub("AceConfig-3.0");
    local media = LibStub("LibSharedMedia-3.0")
    MountCollectionlog.media = media
    local options = {
        type = "group",
        name = "Mount Collection Log 设置",
        order = 1,
        args = {
            headerone = {             
                order = 1,
                name = "主界面选项",
                type = "header",
                width = "full",
            },            
            mainWindow = {             
                order = 2,
                name = "主界面透明度",
                desc = "更改主界面透明度",
                type = "range",
                width = "normal",
                min = 0,
                max = 1,
                softMin = 0,
                softMax = 1,
                bigStep = 0.05,
                isPercent = false,
                set = function(info, val) MCL_SETTINGS.opacity = val; MountCollectionlog.Function:updateFromSettings("opacity"); end,
                get = function(info) return MCL_SETTINGS.opacity; end,
            },
            spacer1 = {
                order = 2.5,
                cmdHidden = true,
                name = "",
                type = "description",
                width = "half",
            },
            defaultOpacity = {
                order = 3,
                name = "重置透明度",
                desc = "重置为默认透明度",
                width = "normal",
                type = "execute",
                func = function()
                    MountCollectionlog.Function:updateFromDefaults("Opacity")
                end
            },              
            headertwo = {             
                order = 4,
                name = "进度条设置",
                type = "header",
                width = "normal",
            },             
            texture = {              
                order = 5,
                type = "select",
                name = "进度条材质",
                width = "normal",
                desc = "设置进度条材质.",
                values = media:HashTable("statusbar"),
                -- Removed dialogControl = "LSM30_Statusbar",
                set = function(info, val) MCL_SETTINGS.statusBarTexture = val; MountCollectionlog.Function:updateFromSettings("texture"); end,
                get = function(info) return MCL_SETTINGS.statusBarTexture; end,
                style = "dropdown", -- This ensures it uses a dropdown menu for selection
            },
            spacer2 = {
                order = 5.5,
                cmdHidden = true,
                name = "",
                type = "description",
                width = "half",
            },            
            defaultTexture = {
                order = 6,
                name = "重置材质",
                desc = "重置为默认材质",
                width = "normal",
                type = "execute",
                func = function()
                    MountCollectionlog.Function:updateFromDefaults("Texture")
                end
            },
            spacer3 = {
                order = 6.5,
                cmdHidden = true,
                name = "",
                type = "description",
                width = "full",
            },
            spacer3large = {
                order = 6.6,
                cmdHidden = true,
                name = "",
                type = "description",
                width = "full",
            },                                  
            progressColorLow = {
                order = 7,
                type = "color",
                name = "进度条 (<33%)",
                width = "normal",
                desc = "设置进度条颜色 (收集进度<33%)",
                set = function(info, r, g, b) MCL_SETTINGS.progressColors.low.r = r; MCL_SETTINGS.progressColors.low.g = g; MCL_SETTINGS.progressColors.low.b = b; MountCollectionlog.Function:updateFromSettings("progressColor"); end,
                get = function(info) return MCL_SETTINGS.progressColors.low.r, MCL_SETTINGS.progressColors.low.g, MCL_SETTINGS.progressColors.low.b; end,                
            },
            spacer4 = {
                order = 7.5,
                cmdHidden = true,
                name = "",
                type = "description",
                width = "half",
            },            
            progressColorMedium = {
                order = 8,
                type = "color",
                name = "进度条 (<66%)",
                width = "normal",
                desc = "设置进度条颜色 (收集进度<66%)",
                set = function(info, r, g, b) MCL_SETTINGS.progressColors.medium.r = r; MCL_SETTINGS.progressColors.medium.g = g; MCL_SETTINGS.progressColors.medium.b = b; MountCollectionlog.Function:updateFromSettings("progressColor"); end,
                get = function(info) return MCL_SETTINGS.progressColors.medium.r, MCL_SETTINGS.progressColors.medium.g, MCL_SETTINGS.progressColors.medium.b; end,                
            },
            spacer5 = {
                order = 8.5,
                cmdHidden = true,
                name = "",
                type = "description",
                width = "half",
            },             
            progressColorHigh = {
                order = 9,
                type = "color",
                name = "进度条 (<100%)",
                width = "normal",
                desc = "设置进度条颜色 (收集进度<100%)",
                set = function(info, r, g, b) MCL_SETTINGS.progressColors.high.r = r; MCL_SETTINGS.progressColors.high.g = g; MCL_SETTINGS.progressColors.high.b = b; MountCollectionlog.Function:updateFromSettings("progressColor"); end,
                get = function(info) return MCL_SETTINGS.progressColors.high.r, MCL_SETTINGS.progressColors.high.g, MCL_SETTINGS.progressColors.high.b; end,                
            },
            spacer6 = {
                order = 9.5,
                cmdHidden = true,
                name = "",
                type = "description",
                width = "half",
            },             
            progressColorComplete = {
                order = 10,
                type = "color",
                name = "进度条 (=100%)",
                width = "normal",
                desc = "设置进度条颜色 (收集所有坐骑)",
                set = function(info, r, g, b) MCL_SETTINGS.progressColors.complete.r = r; MCL_SETTINGS.progressColors.complete.g = g; MCL_SETTINGS.progressColors.complete.b = b; MountCollectionlog.Function:updateFromSettings("progressColor"); end,
                get = function(info) return MCL_SETTINGS.progressColors.complete.r, MCL_SETTINGS.progressColors.complete.g, MCL_SETTINGS.progressColors.complete.b; end,                
            },
            defaultColor = {
                order = 11,
                name = "重置颜色",
                desc = "重置为默认颜色",
                width = "normal",
                type = "execute",
                func = function()
                    MountCollectionlog.Function:updateFromDefaults("Colors")
                end
            },              
            headerthree = {             
                order = 12,
                name = "绝版设置",
                type = "header",
                width = "full",
            },            
            unobtainable = {             
                order = 13,
                name = "隐藏绝版",
                desc = "在总览中隐藏绝版坐骑.",
                type = "toggle",
                width = "full",
                set = function(info, val) MCL_SETTINGS.unobtainable = val; MountCollectionlog.Function:updateFromSettings("unobtainable", val); end,
                get = function(info) return MCL_SETTINGS.unobtainable; end,
            },
            minimapIconToggle = {
                order = 14,
                name = "显示小地图按钮",
                desc = "切换显示小地图按钮.",
                type = "toggle",
                width = "full",
                set = function(info, val)
                    MCL_MM.db.profile.minimap.hide = not val
                    if val then
                        icon:Show("MCL!")
                    else
                        icon:Hide("MCL!")
                    end
                end,
                get = function(info)
                    return not MCL_MM.db.profile.minimap.hide
                end,
            },            
            headerfour = {             
                order = 14,
                name = "重置设置",
                type = "header",
                width = "full",
            },             
            defaults = {
                order = 15,
                name = "重置设置",
                desc = "重置为默认设置",
                width = "normal",
                type = "execute",
                func = function()
                    MountCollectionlog.Function:updateFromDefaults()
                end
            }                                                                                                       
        }
    }                                                        


    AceConfig:RegisterOptionsTable(MountCollectionlogLocal, options, {});
    MountCollectionlog.AceConfigDialog = LibStub("AceConfigDialog-3.0");
    MountCollectionlog.AceConfigDialog:AddToBlizOptions(MountCollectionlogLocal, MountCollectionlogLocal, nil);
end



local MCL_Load = MountCollectionlog.Main;

MountCollectionlog.Frames = {};
local MCL_frames = MountCollectionlog.Frames;

MountCollectionlog.TabTable = {}
MountCollectionlog.statusBarFrames  = {}

local nav_width = 180
local main_frame_width = 1250
local main_frame_height = 640

local r,g,b,a


local function ScrollFrame_OnMouseWheel(self, delta)
	local newValue = self:GetVerticalScroll() - (delta * 50);
	
	if (newValue < 0) then
		newValue = 0;
	elseif (newValue > self:GetVerticalScrollRange()) then
		newValue = self:GetVerticalScrollRange();
	end
	
	self:SetVerticalScroll(newValue);
end


function MCL_frames:openSettings()
	Settings.OpenToCategory(MountCollectionlogLocal)
end

function MCL_frames:CreateMainFrame()
    MCL_mainFrame = CreateFrame("Frame", "MCLFrame", UIParent, "MCLFrameTemplateWithInset");
    MCL_mainFrame.Bg:SetVertexColor(0,0,0,MCL_SETTINGS.opacity)
    MCL_mainFrame.TitleBg:SetVertexColor(0.1,0.1,0.1,0.95)
    MCL_mainFrame:Show()
	
	MCL_mainFrame.settings = CreateFrame("Button", nil, MCL_mainFrame);
	MCL_mainFrame.settings:SetSize(15, 15)
	MCL_mainFrame.settings:SetPoint("TOPRIGHT", MCL_mainFrame, "TOPRIGHT", -30, 0)
	MCL_mainFrame.settings.tex = MCL_mainFrame.settings:CreateTexture()
	MCL_mainFrame.settings.tex:SetAllPoints(MCL_mainFrame.settings)
	MCL_mainFrame.settings.tex:SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\Modules\\MountCollectionLog\\settings.blp")
	MCL_mainFrame.settings:SetScript("OnClick", function()MCL_frames:openSettings()end)


	MCL_mainFrame.sa = CreateFrame("Button", nil, MCL_mainFrame);
	MCL_mainFrame.sa:SetSize(60, 15)
	MCL_mainFrame.sa:SetPoint("TOPRIGHT", MCL_mainFrame, "TOPRIGHT", -60, -1)
	MCL_mainFrame.sa.tex = MCL_mainFrame.sa:CreateTexture()
	MCL_mainFrame.sa.tex:SetAllPoints(MCL_mainFrame.sa)
	MCL_mainFrame.sa.tex:SetTexture("Interface\\Buttons\\WHITE8x8")
	MCL_mainFrame.sa.tex:SetVertexColor(0.1,0.1,0.1,0.95, MCL_SETTINGS.opacity)
	MCL_mainFrame.sa.text = MCL_mainFrame.sa:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
	MCL_mainFrame.sa.text:SetPoint("CENTER", MCL_mainFrame.sa, "CENTER", 0, 0);
	MCL_mainFrame.sa.text:SetText("SA")
	MCL_mainFrame.sa.text:SetTextColor(0, 0.7, 0.85)	
	MCL_mainFrame.sa:SetScript("OnClick", function()MountCollectionlog.Function:simplearmoryLink()end)	
	
	MCL_mainFrame.dfa = CreateFrame("Button", nil, MCL_mainFrame);
	MCL_mainFrame.dfa:SetSize(60, 15)
	MCL_mainFrame.dfa:SetPoint("TOPRIGHT", MCL_mainFrame, "TOPRIGHT", -125, -1)
	MCL_mainFrame.dfa.tex = MCL_mainFrame.dfa:CreateTexture()
	MCL_mainFrame.dfa.tex:SetAllPoints(MCL_mainFrame.dfa)
	MCL_mainFrame.dfa.tex:SetTexture("Interface\\Buttons\\WHITE8x8")
	MCL_mainFrame.dfa.tex:SetVertexColor(0.1,0.1,0.1,0.95, MCL_SETTINGS.opacity)
	MCL_mainFrame.dfa.text = MCL_mainFrame.dfa:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
	MCL_mainFrame.dfa.text:SetPoint("CENTER", MCL_mainFrame.dfa, "CENTER", 0, 0);
	MCL_mainFrame.dfa.text:SetText("DFA")
	MCL_mainFrame.dfa.text:SetTextColor(0, 0.7, 0.85)	
	MCL_mainFrame.dfa:SetScript("OnClick", function()MountCollectionlog.Function:dfaLink()end)		


	--MCL Frame settings
	MCL_mainFrame:SetSize(main_frame_width, main_frame_height); -- width, height
	MCL_mainFrame:SetPoint("CENTER", UIParent, "CENTER"); -- point, relativeFrame, relativePoint, xOffset, yOffset
	MCL_mainFrame:SetHyperlinksEnabled(true)
	MCL_mainFrame:SetScript("OnHyperlinkClick", ChatFrame_OnHyperlinkShow)

	MCL_mainFrame:SetMovable(true)
	MCL_mainFrame:EnableMouse(true)
	MCL_mainFrame:RegisterForDrag("LeftButton")
	MCL_mainFrame:SetScript("OnDragStart", MCL_mainFrame.StartMoving)
	MCL_mainFrame:SetScript("OnDragStop", MCL_mainFrame.StopMovingOrSizing)    

	--Creating title for frame
	MCL_mainFrame.title = MCL_mainFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
	MCL_mainFrame.title:SetPoint("LEFT", MCL_mainFrame.TitleBg, "LEFT", 5, 2);
	MCL_mainFrame.title:SetText("Mount Collection Log");
	MCL_mainFrame.title:SetTextColor(0, 0.7, 0.85)
    
    -- Scroll Frame for Main Window
	MCL_mainFrame.ScrollFrame = CreateFrame("ScrollFrame", nil, MCL_mainFrame, "MinimalScrollFrameTemplate");
	MCL_mainFrame.ScrollFrame:SetPoint("TOPLEFT", MCL_mainFrame.Bg, "TOPLEFT", 4, -7);
	MCL_mainFrame.ScrollFrame:SetPoint("BOTTOMRIGHT", MCL_mainFrame.Bg, "BOTTOMRIGHT", -3, 6);
	MCL_mainFrame.ScrollFrame:SetClipsChildren(true);
	MCL_mainFrame.ScrollFrame:SetScript("OnMouseWheel", ScrollFrame_OnMouseWheel);
	MCL_mainFrame.ScrollFrame:EnableMouse(true)
    
	MCL_mainFrame.ScrollFrame.ScrollBar:ClearAllPoints();
	MCL_mainFrame.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", MCL_mainFrame.ScrollFrame, "TOPRIGHT", -8, -19);
	MCL_mainFrame.ScrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", MCL_mainFrame.ScrollFrame, "BOTTOMRIGHT", -8, 17);

	MCL_mainFrame:SetFrameStrata("HIGH")

	MountCollectionlog.Function:CreateFullBorder(MCL_mainFrame)

    tinsert(UISpecialFrames, "MCLFrame")
    return MCL_mainFrame
end


local function Tab_OnClick(self)
	PanelTemplates_SetTab(self:GetParent(), self:GetID());

	local scrollChild = MCL_mainFrame.ScrollFrame:GetScrollChild();
	if(scrollChild) then
		scrollChild:Hide();
	end

	MCL_mainFrame.ScrollFrame:SetScrollChild(self.content);
	self.content:Show();
	MCL_mainFrame.ScrollFrame:SetVerticalScroll(0);
end


function MCL_frames:SetTabs()
    local tabFrame = MountCollectionlog.MCL_MF_Nav
    numTabs = 0
    for k,v in pairs(MountCollectionlog.sections) do
        numTabs = numTabs + 1
    end
	local contents = {};
	local frameName = tabFrame:GetName();
    local i = 1
    tabFrame.numTabs = numTabs;  
	for k,v in pairs(MountCollectionlog.sections) do
		local tab = CreateFrame("Button", frameName.."Tab"..k, tabFrame, "MCLTabButtonTemplate");
        tab:SetID(k);
        tab.title = tab:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        tab.title:SetPoint("LEFT", 0, 0)       

		tab.title:SetText(tostring(v.name));
		if v.icon ~= nil then
			tab.icon = CreateFrame("Frame", nil, tab);
			tab.icon:SetSize(32, 32)
			tab.icon:SetPoint("RIGHT", tab, "RIGHT", 0, 0)
			tab.icon.tex = tab.icon:CreateTexture()
			tab.icon.tex:SetAllPoints(tab.icon)
			tab.icon.tex:SetTexture(v.icon)
		end
		tab:SetScript("OnClick", Tab_OnClick);
        tab:SetWidth(nav_width)
		if v.name == "标记" then
			tab.content = CreateFrame("Frame", "PinnedTab", tabFrame.ScrollFrame);
		else
			tab.content = CreateFrame("Frame", nil, tabFrame.ScrollFrame);
		end
		tab.content:SetSize(1100, 550);
		tab.content:Hide();		

		table.insert(contents, tab.content);

		if tab.title:GetText() == "总览" then
			tab:SetPoint("TOPLEFT", tabFrame, "TOPLEFT", 0, 20);
		elseif (i == 1) or tab.title:GetText() == "总览" then
			tab:SetPoint("TOPLEFT", tabFrame, "TOPLEFT", 0, -10);
		else
			tab:SetPoint("BOTTOM", _G[frameName.."Tab"..(i-1)], "BOTTOM", 0, -30);
		end
		MountCollectionlog.TabTable[i] = v.name

        i = i+1
	end

	Tab_OnClick(_G[frameName.."Tab20"]);

	return contents, numTabs;
end


function MCL_frames:createNavFrame(relativeFrame, title)
	--Creating a frame to place expansion content in.
	local frame = CreateFrame("Frame", "Nav", relativeFrame, "BackdropTemplate");
	frame:SetWidth(nav_width)
	frame:SetHeight(main_frame_height)
	frame:SetPoint("TOPLEFT", relativeFrame, 5, -38);
    frame:SetBackdropColor(1, 1, 1)
	frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	frame.title:SetPoint("LEFT", 0, 0)	
	return frame;
end


function MCL_frames:progressBar(relativeFrame, top)
	MyStatusBar = CreateFrame("StatusBar", nil, relativeFrame, "BackdropTemplate")
	MyStatusBar:SetStatusBarTexture(MountCollectionlog.media:Fetch("statusbar", MCL_SETTINGS.statusBarTexture))
	MyStatusBar:GetStatusBarTexture():SetHorizTile(false)
	MyStatusBar:SetMinMaxValues(0, 100)
	MyStatusBar:SetValue(0)
	MyStatusBar:SetWidth(150)
	MyStatusBar:SetHeight(15)
	if top then
		MyStatusBar:SetPoint("BOTTOMLEFT", relativeFrame, "BOTTOMLEFT", 0, 10)
	else
		MyStatusBar:SetPoint("BOTTOMLEFT", relativeFrame, "BOTTOMLEFT", 0, 10)
	end

	MyStatusBar:SetStatusBarColor(0.1, 0.9, 0.1)

	MyStatusBar.bg = MyStatusBar:CreateTexture(nil, "BACKGROUND")
	MyStatusBar.bg:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
	MyStatusBar.bg:SetAllPoints(true)
	MyStatusBar.bg:SetVertexColor(0.843, 0.874, 0.898, 0.5)
	MyStatusBar.Text = MyStatusBar:CreateFontString()
	MyStatusBar.Text:SetFontObject(GameFontWhite)
	MyStatusBar.Text:SetPoint("CENTER")
	MyStatusBar.Text:SetJustifyH("CENTER")
	-- MyStatusBar.Text:SetJustifyV("CENTER")
	MyStatusBar.Text:SetText()

	table.insert(MountCollectionlog.statusBarFrames, MyStatusBar)

	return MyStatusBar
end

function MCL_frames:createContentFrame(relativeFrame, title)
	--Creating a frame to place expansion content in.
	local frame = CreateFrame("Frame", nil, relativeFrame, "BackdropTemplate");

	--category:SetSize(490, boxSize);
	frame:SetWidth(490)
	frame:SetHeight(30)
	frame:SetPoint("TOPLEFT", relativeFrame, nav_width+30, 0);
    frame:SetBackdropColor(0, 1, 0)
	frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	frame.title:SetPoint("LEFT", 0, 0)
	frame.title:SetText(title)


	if title ~= "标记" then
		frame.pBar = MountCollectionlog.Frames:progressBar(frame)
		frame.pBar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, -15)
		frame.pBar:SetWidth(880)
		frame.pBar:SetHeight(20)
	end

	return frame;
end



function MCL_frames:createOverviewCategory(set, relativeFrame)
    local first = true
    local col = 1
    local oddFrame, evenFrame = false, false
    local oddOverFlow, evenOverFlow = 0, 0

	for k,v in pairs(set) do
		if (v.name ~= "总览") and (v.name ~= "标记") then
			local frame = CreateFrame("Frame", nil, relativeFrame, "BackdropTemplate")
			frame:SetWidth(60);
			frame:SetHeight(60);

			if (first == true) then
				frame:SetPoint("TOPLEFT", relativeFrame, "TOPLEFT", 0, -80);
			elseif (col % 2 == 0) then
				if evenFrame then
					frame:SetPoint("TOPRIGHT", evenFrame, "TOPRIGHT", 0, -50);
				else
					frame:SetPoint("TOPRIGHT", oddFrame, "TOPRIGHT", 480, 0);
				end
			else
				frame:SetPoint("BOTTOMLEFT", oddFrame, "BOTTOMLEFT", 0, -50);
			end

			first = false
			frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
			frame.title:SetPoint("TOPLEFT", 0, 0)
			frame.title:SetText(v.name)
			
			local pBar = MountCollectionlog.Frames:progressBar(frame)
			pBar:SetWidth(400)
			pBar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 30)

			pBar:HookScript("OnEnter", function()
				r,g,b,a = pBar:GetStatusBarColor()
				local temp = pBar:SetStatusBarColor(0.8, 0.5, 0.9, 1)
			end)
			pBar:HookScript("OnLeave", function()
				pBar:SetStatusBarColor(r, g, b, a)
			end)
			if v.name == "绝版" then
				pBar.unobtainable = MCL_SETTINGS.unobtainable
				if MCL_SETTINGS.unobtainable == true then
					pBar:GetParent():Hide()
				end
			end

			pBar:SetScript("OnMouseDown", function(self, button)
				if button == 'LeftButton' then
					for i,tab in ipairs(MountCollectionlog.TabTable) do
						if tab == v.name then
							Tab_OnClick(_G["NavTab"..i]);
						end
					end
				end			
			end)

			if (col % 2 == 0) then
				evenFrame = frame
				evenOverFlow = overflow
			else
				oddFrame = frame
				oddOverFlow = overflow
			end
			col = col + 1

			local t = {
				name = v.name,
				frame = pBar
			}
	
			table.insert(MountCollectionlog.overviewFrames, t)			
		end	

	end


end


----------------------------------------------------------------
-- Creating a placeholder for each category, this is where we attach each mount to.
----------------------------------------------------------------

function MCL_frames:createCategoryFrame(set, relativeFrame)
	--Creating a frame to place expansion content in.
    local first = true
    local frame_size = 30
    local col = 1
    local oddFrame, evenFrame = false, false
    local oddOverFlow, evenOverFlow = 0, 0
    local section = {}
    local total_mounts = 0

    for k,v in pairs(set) do
        local category = CreateFrame("Frame", nil, relativeFrame, "BackdropTemplate");
        category:SetWidth(60);
        category:SetHeight(60);


        if (first == true) then
            category:SetPoint("TOPLEFT", relativeFrame, "TOPLEFT", 0, -60);
        elseif (col % 2 == 0) then
            if evenFrame then
                category:SetPoint("TOPRIGHT", evenFrame, "TOPRIGHT", 0, -(frame_size+evenOverFlow)-80);
            else
                category:SetPoint("TOPRIGHT", oddFrame, "TOPRIGHT", ((frame_size + 10) * 12) + 20, 0);
            end
        else
            category:SetPoint("BOTTOMLEFT", oddFrame, "BOTTOMLEFT", 0, -(frame_size+oddOverFlow)-80);
        end
        first = false
        category.title = category:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        category.title:SetPoint("TOPLEFT", 0, 0)
		category.title:SetText(v.name)

		category.section = relativeFrame.title:GetText()
		category.category = v.name

        local pBar = MountCollectionlog.Frames:progressBar(category) 
		local overflow = MountCollectionlog.Function:CreateMountsForCategory(v.mounts, category, frame_size, relativeFrame, category, false, false)

            
        category:SetSize(((frame_size + 10) * 12),45)

        if (col % 2 == 0) then
            evenFrame = category
            evenOverFlow = overflow
        else
            oddFrame = category
            oddOverFlow = overflow
        end
        col = col + 1

        -- ! Cosntruct Stats Here

        local stats = {
            frame = category,
            mounts = v.mounts,
            collected = 0,
            pBar = pBar,
			rel = relativeFrame
        }

        table.insert(section, stats)
        total_mounts = total_mounts + MountCollectionlog.Function:getTableLength(v.mounts)

    end
    table.insert(section, total_mounts)
    table.insert(section, relativeFrame)
    return section
end


-- * ------------------------------------------------------
-- *  Namespaces
-- * ------------------------------------------------------

-- * ------------------------------------------------------
-- * Variables
-- * ------------------------------------------------------
MountCollectionlog.Main = {};
local MCL_Load = MountCollectionlog.Main;
local init_load = true
local load_check = 0

-- * -------------------------------------------------
-- * Initialise Database
-- * Cycles through data.lua, checks if in game mount journal has an entry for mount. Restarts function if mount does is not loaded yet.
-- * Function is designed to check if the ingame mount journal has loaded correctly before loading our own database.
-- * -----------------------------------------------


function CountMounts()
    MountCollectionlog.mountList = MountCollectionlog.mountList or {}
    local count = 0
    for b, n in pairs(MountCollectionlog.mountList) do
        if type(n) == "table" then
            for h, j in pairs(n) do
                if type(j) == "table" then
                    for k, v in pairs(j) do
                        -- Ensure v.mounts is a table before attempting to iterate over it
                        if type(v.mounts) == "table" then
                            for kk, vv in pairs(v.mounts) do
                                count = count + 1
                            end
                        end
                    end
                end
            end
        end
    end
    return count
end

-- Global for Addon Compartment
MCL_OnAddonCompartmentClick = function()
    MCL_Load:Toggle()
end

-- Save total mount count
local totalMountCount = CountMounts()

local function InitMounts()
    load_check = 0
    totalMountCount = 0
    for b,n in pairs(MountCollectionlog.mountList) do
        for h,j in pairs(n) do
            if (type(j) == "table") then
                for k,v in pairs(j) do
                    for kk,vv in pairs(v.mounts) do
                        if not string.match(vv, "^m") then
                            totalMountCount = totalMountCount + 1
                            -- local mountName = C_MountJournal.GetMountFromItem(vv)
                            -- if mountName ~= nil then
                            --     load_check = load_check + 1
                            -- else
                            --     local mountName = C_Item.RequestLoadItemDataByID(vv)
                            --     if mountName ~= nil then
                            --         load_check = load_check + 1
                            --     end
                            -- end
                            C_Item.RequestLoadItemDataByID(vv)
                            local mountName = C_MountJournal.GetMountFromItem(vv)
                            if mountName ~= nil then
                                load_check = load_check + 1
                            end                            
                        end
                    end
                end
            end
        end
    end
end


-- * -----------------------------------------------------
-- * Toggle the main window
-- * -----------------------------------------------------


MountCollectionlog.dataLoaded = false

function MCL_Load:PreLoad()      
    if load_check >= totalMountCount then
        -- print("预载完成:", "坐骑总数", totalMountCount, "载入检查", load_check)
        MountCollectionlog.dataLoaded = true
        return true
    else   
        -- print("预载中:", "坐骑总数", totalMountCount, "载入检查", load_check)
        InitMounts()         
        return false
    end
end

-- Set a maximum number of initialization retries
local MAX_INIT_RETRIES = 3

-- Initialization function
function MCL_Load:Init(force)
    local function repeatCheck()
        local retries = 0
        if MCL_Load:PreLoad() then
            -- Initialization steps
            if MountCollectionlog.MCL_MF == nil then
                MountCollectionlog.MCL_MF = MountCollectionlog.Frames:CreateMainFrame()
                MountCollectionlog.MCL_MF:SetShown(false)
                MountCollectionlog.Function:initSections()
            end
            MountCollectionlog.Function:UpdateCollection()
            init_load = false -- Ensure that the initialization does not repeat unnecessarily.
        else
            retries = retries + 1
            if retries < MAX_INIT_RETRIES then
                -- Retry the initialization process after a delay
                C_Timer.After(1, repeatCheck)
            end
        end
    end

    -- Force reinitialization if specifically requested
    if force then
        load_check = 0
        MountCollectionlog.dataLoaded = false
    end

    -- Check if we need to attempt initialization
    if not MountCollectionlog.dataLoaded then
        init_load = true
        repeatCheck()
    end
end

-- Toggle function
function MCL_Load:Toggle()
    -- Check preload status and if false, prevent execution.
    if MountCollectionlog.dataLoaded == false then
        MCL_Load:Init()
        return
    end 
    if MountCollectionlog.MCL_MF == nil then
        return -- Immune to function calls before the initialization process is complete, as the frame doesn't exist yet.
    else
        MountCollectionlog.MCL_MF:SetShown(not MountCollectionlog.MCL_MF:IsShown()) -- The addon's frame exists and can be toggled.
    end
    MountCollectionlog.Function:UpdateCollection()
end

local f = CreateFrame("Frame")
local login = true



-- * -------------------------------------------------
-- * Loads addon once Blizzard_Collections has loaded in.
-- * -------------------------------------------------


local function onevent(self, event, arg1, ...)
    if(login and ((event == "ADDON_LOADED" and name == arg1) or (event == "PLAYER_LOGIN"))) then
        login = nil
        f:UnregisterEvent("ADDON_LOADED")
        f:UnregisterEvent("PLAYER_LOGIN")
	    if not C_AddOns.IsAddOnLoaded("Blizzard_Collections") then
	        C_AddOns.LoadAddOn("Blizzard_Collections")
	    end
        MountCollectionlog.Function:AddonSettings()
        
        -- Initiate the addon when the required addon is loaded
        MCL_Load:Init()
    end
end


-- function addon:MCL_MM() self.db.profile.minimap.hide = not self.db.profile.minimap.hide if self.db.profile.minimap.hide then icon:Hide("MCL-icon") else icon:Show("MCL-icon") end end
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", onevent)

local _, MountCollectionlog = ...;
local MCL_Load = MountCollectionlog.Main;

-- Namespace
-------------------------------------------------------------

SLASH_MCL1 = "/mcl";

SlashCmdList["MCL"] = function(msg)
    if msg:lower() == "help" then
        print("\n|cff00CCFFMount Collection Log\n指令:\n|cffFF0000Show:|cffFFFFFF 显示坐骑收藏\n|cffFF0000Icon:|cffFFFFFF 切换小地图按钮.\n|cffFF0000Config:|cffFFFFFF 打开设置..\n|cffFF0000Help:|cffFFFFFF 显示指令")
    end
    if msg:lower() == "show" then
        MountCollectionlog.Main.Toggle();
    end
    if msg:lower() == "icon" then
        MountCollectionlog.Function.MCL_MM();
    end        
    if msg:lower() == "" then
        MountCollectionlog.Main.Toggle();
    end
    if msg:lower() == "debug" then
        MountCollectionlog.Function:GetCollectedMounts();
    end
    if msg:lower() == "conifg" or msg == "settings" then
        MountCollectionlog.Frames:openSettings();
    end
    if msg:lower() == "refresh" then
        if MCL_Load and type(MCL_Load.Init) == "function" then
            MCL_Load:Init(true)  -- True to force re-initialization.
        else
            print("MCL: 无法刷新. 初始化功能不可用.")
        end
    end  
 end 
