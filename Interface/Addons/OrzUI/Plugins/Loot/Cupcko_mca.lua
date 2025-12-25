--## Author: cupcko ## Version: 1.03
local externalMountData =                                            -- 新增坐骑SpellID -> itemID(默认为0)
{
    [458] = { itemID = 5656, versionID = 1, source = 171 },     -- 棕马
    [459] = { itemID = 0, versionID = 105, source = 25 },      -- 灰狼
    [468] = { itemID = 0, versionID = 105, source = 25 },     -- 白马
    [470] = { itemID = 2411, versionID = 1, source = 171 },     -- 黑马
    [472] = { itemID = 2414, versionID = 1, source = 171 },     -- 杂色马
    [578] = { itemID = 0, versionID = 105, source = 25 },      -- 黑狼
    [579] = { itemID = 0, versionID = 105, source = 25 },      -- 赤狼
    [580] = { itemID = 1132, versionID = 1, source = 150 },     -- 森林狼
    [581] = { itemID = 0, versionID = 105, source = 25 },      -- 冬狼
    [5784] = { itemID = 0, versionID = 104, source = 104 },     -- 地狱战马
    [6648] = { itemID = 5655, versionID = 1, source = 171 },    -- 栗色马
    [6653] = { itemID = 5665, versionID = 1, source = 150 },    -- 恐狼
    [6654] = { itemID = 5668, versionID = 1, source = 150 },    -- 棕狼
    [6777] = { itemID = 5864, versionID = 1, source = 170 },        -- 灰山羊
    [6896] = { itemID = 0, versionID = 105, source = 25 },        -- 黑山羊
    [6898] = { itemID = 0, versionID = 1, source = 170 },        -- 白山羊
    [6899] = { itemID = 0, versionID = 1, source = 170 },        -- 棕山羊
    [8394] = { itemID = 0, versionID = 1, source = 154 },        -- 条纹霜刃豹
    [8395] = { itemID = 0, versionID = 1, source = 153 },        -- 绿色迅猛龙
    [8980] = { itemID = 0, versionID = 105, source = 25 },        -- 骸骨军马
    [10789] = { itemID = 8632, versionID = 1, source = 154 },       -- 斑点霜刃豹
    [10790] = { itemID = 0, versionID = 105, source = 25 },       -- 丛林虎
    [10793] = { itemID = 8629, versionID = 1, source = 154 },       -- 条纹夜刃豹
    [10795] = { itemID = 0, versionID = 105, source = 25 },       -- 白色迅猛龙
    [10796] = { itemID = 8591, versionID = 1, source = 153 },       -- 青色迅猛龙
    [10799] = { itemID = 8592, versionID = 1, source = 153 },       -- 紫色迅猛龙
    [10873] = { itemID = 8563, versionID = 1, source = 172 },       -- 红色机械陆行鸟
    [10969] = { itemID = 8595, versionID = 1, source = 172 },       -- 蓝色机械陆行鸟
    [13819] = { itemID = 0, versionID = 104, source = 102 },       -- 战马
    [15779] = { itemID = 13326, versionID = 105, source = 25 },       -- 白色机械陆行鸟B型
    [15780] = { itemID = 0, versionID = 105, source = 25 },       -- 绿色机械陆行鸟
    [16055] = { itemID = 12303, versionID = 105, source = 25 },       -- 黑色夜刃豹
    [16056] = { itemID = 12302, versionID = 105, source = 25 },       -- 上古霜刃豹
    [16080] = { itemID = 12330, versionID = 105, source = 25 },       -- 赤狼
    [16081] = { itemID = 12351, versionID = 105, source = 25 },       -- 冰狼
    [16082] = { itemID = 12354, versionID = 105, source = 25 },       -- 褐色马
    [16083] = { itemID = 12353, versionID = 105, source = 25 },       -- 白马
    [16084] = { itemID = 8586, versionID = 105, source = 25 },       -- 杂斑红色迅猛龙
    [17229] = { itemID = 13086, versionID = 1, source = 10 },       -- 冬泉霜刃豹
    [17450] = { itemID = 13317, versionID = 105, source = 25 },       -- 白色迅猛龙
    [17453] = { itemID = 13321, versionID = 1, source = 172 },       -- 绿色机械陆行鸟
    [17454] = { itemID = 13322, versionID = 1, source = 172 },       -- 原色机械陆行鸟
    [17459] = { itemID = 13327, versionID = 105, source = 25 },       -- 冰蓝色机械陆行鸟A型
    [17460] = { itemID = 13329, versionID = 105, source = 25 },       -- 霜山羊
    [17461] = { itemID = 13328, versionID = 105, source = 25 }, -- 黑山羊
    [17462] = { itemID = 13331, versionID = 1, source = 152 },       -- 红色骸骨军马
    [17463] = { itemID = 13332, versionID = 1, source = 152 },       -- 蓝色骸骨军马
    [17464] = { itemID = 13333, versionID = 1, source = 152 },       -- 棕色骸骨军马
    [17465] = { itemID = 13334, versionID = 1, source = 152 },       -- 绿色骷髅战马
    [17481] = { itemID = 13335, versionID = 1, source = 3 },       -- 瑞文戴尔的死亡战马
    [18363] = { itemID = 0, versionID = 0, source = 43 },       -- 科多兽坐骑
    [18989] = { itemID = 15277, versionID = 1, source = 151 },       -- 灰色科多兽
    [18990] = { itemID = 15290, versionID = 1, source = 151 },       -- 棕色科多兽
    [18991] = { itemID = 15292, versionID = 105, source = 25 },       -- 绿色科多兽
    [18992] = { itemID = 15293, versionID = 105, source = 25 },       -- 蓝色科多兽
    [22717] = { itemID = 19468, versionID = 103, source = 6 },       -- 黑色战驹
    [22718] = { itemID = 29466, versionID = 103, source = 6 },       -- 黑色作战科多兽
    [22719] = { itemID = 29465, versionID = 103, source = 6 },       -- 黑色作战陆行鸟
    [22720] = { itemID = 29467, versionID = 103, source = 6 },       -- 黑色战羊
    [22721] = { itemID = 29472, versionID = 103, source = 6 },       -- 黑色作战迅猛龙
    [22722] = { itemID = 29470, versionID = 103, source = 6 },       -- 红色骷髅战马
    [22723] = { itemID = 29471, versionID = 103, source = 6 },       -- 黑色战虎
    [22724] = { itemID = 29469, versionID = 103, source = 6 },       -- 黑色战狼
    [23161] = { itemID = 0, versionID = 104, source = 104 },       -- 恐惧战马
    [23214] = { itemID = 0, versionID = 104, source = 102 },       -- 军马
    [23219] = { itemID = 18767, versionID = 1, source = 154 },  -- 迅捷雾刃豹
    [23221] = { itemID = 18766, versionID = 1, source = 154 },  -- 迅捷霜刃豹
    [23222] = { itemID = 18774, versionID = 1, source = 172 },       -- 迅捷黄色机械陆行鸟
    [23223] = { itemID = 18773, versionID = 1, source = 172 },       -- 迅捷白色机械陆行鸟
    [23225] = { itemID = 18772, versionID = 1, source = 172 },       -- 迅捷绿色机械陆行鸟
    [23227] = { itemID = 18776, versionID = 1, source = 171 },       -- 迅捷褐色马
    [23228] = { itemID = 18778, versionID = 1, source = 171 },       -- 迅捷白马
    [23229] = { itemID = 18777, versionID = 1, source = 171 },       -- 迅捷棕马
    [23238] = { itemID = 18786, versionID = 1, source = 170 },       -- 迅捷棕山羊
    [23239] = { itemID = 18787, versionID = 1, source = 170 },       -- 迅捷灰山羊
    [23240] = { itemID = 18785, versionID = 1, source = 170 },       -- 迅捷白山羊
    [23241] = { itemID = 18788, versionID = 1, source = 153 },       -- 迅捷蓝色迅猛龙
    [23242] = { itemID = 18789, versionID = 1, source = 153 },       -- 迅捷绿色迅猛龙
    [23243] = { itemID = 18790, versionID = 1, source = 153 },       -- 迅捷橙色迅猛龙
    [23246] = { itemID = 18791, versionID = 1, source = 152 },       -- 紫色骷髅战马
    [23247] = { itemID = 18793, versionID = 1, source = 151 },       -- 大型白色科多兽
    [23248] = { itemID = 18795, versionID = 1, source = 151 },       -- 大型灰色科多兽
    [23249] = { itemID = 18794, versionID = 1, source = 151 },  -- 大型棕色科多兽
    [23250] = { itemID = 18796, versionID = 1, source = 150 },  -- 迅捷棕狼
    [23251] = { itemID = 18797, versionID = 1, source = 150 },  -- 迅捷森林狼
    [23252] = { itemID = 18798, versionID = 1, source = 150 },       -- 迅捷灰狼
    [23338] = { itemID = 18902, versionID = 1, source = 154 },       -- 迅捷雷刃豹
    [23509] = { itemID = 19029, versionID = 103, source = 1028 },       -- 霜狼嗥叫者
    [23510] = { itemID = 19030, versionID = 103, source = 1028 },       -- 雷矛军用坐骑
    [24242] = { itemID = 19872, versionID = 105, source = 41 }, -- 拉扎什迅猛龙
    [24252] = { itemID = 19902, versionID = 105, source = 41 },       -- 迅捷祖利安猛虎
    [25863] = { itemID = 0, versionID = 105, source = 25 },       -- 黑色其拉作战坦克
    [25953] = { itemID = 21218, versionID = 1, source = 3 },       -- 蓝色其拉作战坦克
    [26054] = { itemID = 21321, versionID = 1, source = 3 },       -- 红色其拉作战坦克
    [26055] = { itemID = 21323, versionID = 1, source = 3 },       -- 黄色其拉作战坦克
    [26056] = { itemID = 21324, versionID = 1, source = 3 },       -- 绿色其拉作战坦克
    [26655] = { itemID = 0, versionID = 105, source = 25 },       -- 黑色其拉作战坦克
    [26656] = { itemID = 21176, versionID = 105, source = 25 },       -- 黑色其拉作战坦克
    [28828] = { itemID = 0, versionID = 0, source = 43 },       -- 虚空幼龙
    [30174] = { itemID = 23720, versionID = 6, source = 34 },       -- 乌龟坐骑
    [32235] = { itemID = 25470, versionID = 2, source = 6 },       -- 金色狮鹫
    [32239] = { itemID = 25471, versionID = 2, source = 6 },       -- 黑色狮鹫
    [32240] = { itemID = 25472, versionID = 2, source = 6 },       -- 雪色狮鹫
    [32242] = { itemID = 25473, versionID = 2, source = 6 },       -- 迅捷蓝色狮鹫
    [32243] = { itemID = 25474, versionID = 2, source = 6 },       -- 茶色驭风者
    [32244] = { itemID = 25475, versionID = 2, source = 6 },       -- 蓝色驭风者
    [32245] = { itemID = 25476, versionID = 2, source = 6 },       -- 绿色驭风者
    [32246] = { itemID = 25477, versionID = 2, source = 6 },       -- 迅捷红色驭风者
    [32289] = { itemID = 25527, versionID = 2, source = 6 },       -- 迅捷红色狮鹫
    [32290] = { itemID = 25528, versionID = 2, source = 6 },       -- 迅捷绿色狮鹫
    [32292] = { itemID = 25529, versionID = 2, source = 6 },       -- 迅捷紫色狮鹫
    [32295] = { itemID = 25531, versionID = 2, source = 6 },       -- 迅捷绿色驭风者
    [32296] = { itemID = 25532, versionID = 2, source = 6 },       -- 迅捷黄色驭风者
    [32297] = { itemID = 25533, versionID = 2, source = 6 },       -- 迅捷紫色驭风者
    [33630] = { itemID = 0, versionID = 105, source = 25 },       -- 蓝色机械陆行鸟
    [33660] = { itemID = 28936, versionID = 1, source = 167 },       -- 迅捷粉色陆行鸟
    [34406] = { itemID = 28481, versionID = 1, source = 174 },       -- 棕色雷象
    [34767] = { itemID = 0, versionID = 2, source = 106 },       -- 萨拉斯军马
    [34769] = { itemID = 0, versionID = 2, source = 106 },       -- 萨拉斯战马
    [34790] = { itemID = 29228, versionID = 103, source = 201 },       -- 暗色作战塔布羊
    [34795] = { itemID = 28927, versionID = 1, source = 167 },       -- 红色陆行鸟
    [34896] = { itemID = 29227, versionID = 2, source = 203 },       -- 蓝色作战塔布羊
    [34897] = { itemID = 29231, versionID = 2, source = 203 },       -- 白色作战塔布羊
    [34898] = { itemID = 29229, versionID = 2, source = 203 },       -- 银色作战塔布羊
    [34899] = { itemID = 29230, versionID = 2, source = 203 },       -- 褐色作战塔布羊
    [35018] = { itemID = 29222, versionID = 1, source = 167 },       -- 紫色陆行鸟
    [35020] = { itemID = 29220, versionID = 1, source = 167 },       -- 蓝色陆行鸟
    [35022] = { itemID = 29221, versionID = 1, source = 167 },       -- 黑色陆行鸟
    [35025] = { itemID = 29223, versionID = 1, source = 167 },       -- 迅捷绿色陆行鸟
    [35027] = { itemID = 29224, versionID = 1, source = 167 },       -- 迅捷紫色陆行鸟
    [35028] = { itemID = 34129, versionID = 103, source = 6 },       -- 迅捷作战陆行鸟
    [35710] = { itemID = 29744, versionID = 1, source = 174 },       -- 灰色雷象
    [35711] = { itemID = 29743, versionID = 1, source = 174 },       -- 紫色雷象
    [35712] = { itemID = 29746, versionID = 1, source = 174 },       -- 重型绿色雷象
    [35713] = { itemID = 29745, versionID = 1, source = 174 },       -- 重型蓝色雷象
    [35714] = { itemID = 29747, versionID = 1, source = 174 },       -- 重型紫色雷象
    [36702] = { itemID = 30480, versionID = 2, source = 5 },       -- 炽热战马
    [37015] = { itemID = 30609, versionID = 105, source = 42 }, -- 迅捷虚空幼龙
    [39315] = { itemID = 31830, versionID = 2, source = 203 },       -- 蓝色骑乘塔布羊
    [39316] = { itemID = 28915, versionID = 103, source = 201 },       -- 暗色骑乘塔布羊
    [39317] = { itemID = 31831, versionID = 2, source = 203 },   -- 银色骑乘塔布羊
    [39318] = { itemID = 31833, versionID = 2, source = 203 },   -- 褐色骑乘塔布羊
    [39319] = { itemID = 31835, versionID = 2, source = 203 },   -- 白色骑乘塔布羊
    [39798] = { itemID = 32314, versionID = 2, source = 203 },       -- 绿色骑乘虚空鳐
    [39800] = { itemID = 32317, versionID = 2, source = 203 },       -- 红色骑乘虚空鳐
    [39801] = { itemID = 32316, versionID = 2, source = 203 },       -- 紫色骑乘虚空鳐
    [39802] = { itemID = 32318, versionID = 2, source = 203 },       -- 银色骑乘虚空鳐
    [39803] = { itemID = 32319, versionID = 2, source = 203 },       -- 蓝色骑乘虚空鳐
    [40192] = { itemID = 32458, versionID = 2, source = 5 },       -- 奥的灰烬
    [41252] = { itemID = 32768, versionID = 2, source = 3 },       -- 乌鸦之神
    [41513] = { itemID = 32857, versionID = 2, source = 202 },       -- 黑色灵翼幼龙
    [41514] = { itemID = 32858, versionID = 2, source = 202 },       -- 青色灵翼幼龙
    [41515] = { itemID = 32859, versionID = 2, source = 202 },       -- 蓝色灵翼幼龙
    [41516] = { itemID = 32860, versionID = 2, source = 202 },       -- 紫色灵翼幼龙
    [41517] = { itemID = 32861, versionID = 2, source = 202 },       -- 绿色灵翼幼龙
    [41518] = { itemID = 32862, versionID = 2, source = 202 },       -- 红色灵翼幼龙
    [42776] = { itemID = 49283, versionID = 101, source = 48 },       -- 幽灵虎
    [42777] = { itemID = 49284, versionID = 101, source = 48 },       -- 迅捷幽灵虎
    [43688] = { itemID = 33809, versionID = 105, source = 3 },       -- 阿曼尼战熊
    [43899] = { itemID = 33976, versionID = 105, source = 47 },       -- 美酒节赛羊
    [43900] = { itemID = 33977, versionID = 100, source = 47 },       -- 迅捷美酒节赛羊
    [43927] = { itemID = 33999, versionID = 2, source = 2 },   -- 塞纳里奥作战角鹰兽
    [44151] = { itemID = 34061, versionID = 102, source = 27 },       -- 涡轮加速飞行器
    [44153] = { itemID = 34060, versionID = 102, source = 27 },       -- 飞行器
    [44317] = { itemID = 0, versionID = 105, source = 42 },       -- 残酷角斗士的虚空幼龙
    [44744] = { itemID = 34092, versionID = 105, source = 42 },       -- 残酷角斗士的虚空幼龙
    [46197] = { itemID = 49285, versionID = 101, source = 48 },       -- X-51虚空火箭
    [46199] = { itemID = 49286, versionID = 101, source = 48 },       -- X-51虚空火箭特别加强版
    [46628] = { itemID = 35513, versionID = 2, source = 3 },       -- 迅捷白色陆行鸟
    [48025] = { itemID = 37012, versionID = 100, source = 49 },       -- 无头骑士的坐骑
    [48027] = { itemID = 35906, versionID = 103, source = 6 },       -- 黑色作战雷象
    [48778] = { itemID = 0, versionID = 104, source = 101 },       -- 阿彻鲁斯死亡战马
    [48954] = { itemID = 0, versionID = 0, source = 43 },       -- 迅捷斑马
    [49193] = { itemID = 37676, versionID = 105, source = 42 },       -- 复仇角斗士的虚空幼龙
    [49322] = { itemID = 37719, versionID = 105, source = 19 },       -- 迅捷斑马
    [49378] = { itemID = 0, versionID = 0, source = 43 },       -- 美酒节科多兽
    [49379] = { itemID = 37828, versionID = 100, source = 47 },       -- 大型美酒节科多兽
    [51412] = { itemID = 49282, versionID = 101, source = 48 },       -- 大战熊
    [54729] = { itemID = 40775, versionID = 104, source = 101 },       -- 黑锋骸骨狮鹫
    [54753] = { itemID = 43962, versionID = 3, source = 2 },       -- 白色北极熊坐骑
    [55164] = { itemID = 0, versionID = 0, source = 43 },       -- 迅捷幽灵狮鹫
    [55531] = { itemID = 44413, versionID = 102, source = 27 },       -- 机械路霸
    [58615] = { itemID = 43516, versionID = 105, source = 42 },       -- 野蛮角斗士的虚空幼龙
    [58983] = { itemID = 43599, versionID = 101, source = 22 },       -- 暴雪巨熊
    [59567] = { itemID = 43952, versionID = 3, source = 5 },       -- 碧蓝幼龙
    [59568] = { itemID = 43953, versionID = 3, source = 5 },       -- 蓝色幼龙
    [59569] = { itemID = 43951, versionID = 3, source = 3 },       -- 青铜幼龙
    [59570] = { itemID = 43955, versionID = 3, source = 303 },       -- 红色幼龙
    [59571] = { itemID = 43954, versionID = 3, source = 5 },       -- 暮光幼龙
    [59572] = { itemID = 0, versionID = 0, source = 43 },       -- 黑色北极熊
    [59650] = { itemID = 43986, versionID = 3, source = 1 },       -- 黑色幼龙
    [59785] = { itemID = 43956, versionID = 103, source = 6 },       -- 黑色猛犸战象
    [59788] = { itemID = 44077, versionID = 103, source = 6 },       -- 黑色猛犸战象
    [59791] = { itemID = 44230, versionID = 3, source = 6 },       -- 长毛猛犸象
    [59793] = { itemID = 44231, versionID = 3, source = 6 },       -- 长毛猛犸象
    [59797] = { itemID = 44080, versionID = 3, source = 302 },       -- 冰雪猛犸象
    [59799] = { itemID = 43958, versionID = 3, source = 302 },       -- 冰雪猛犸象
    [59961] = { itemID = 44160, versionID = 3, source = 1 },       -- 红色始祖幼龙
    [59976] = { itemID = 44164, versionID = 105, source = 1 },       -- 黑色始祖幼龙
    [59996] = { itemID = 44151, versionID = 3, source = 3 },       -- 蓝色始祖幼龙
    [60002] = { itemID = 44168, versionID = 3, source = 4 },       -- 迷时始祖幼龙
    [60021] = { itemID = 44175, versionID = 105, source = 41 },       -- 被感染的始祖幼龙
    [60024] = { itemID = 44177, versionID = 100, source = 1 },       -- 紫色始祖幼龙
    [60025] = { itemID = 44178, versionID = 104, source = 1024 },       -- 白色幼龙
    [60114] = { itemID = 44225, versionID = 3, source = 6 },       -- 装甲棕熊
    [60116] = { itemID = 44226, versionID = 3, source = 6 },       -- 装甲棕熊
    [60118] = { itemID = 44223, versionID = 103, source = 1 },       -- 黑色战熊
    [60119] = { itemID = 44224, versionID = 103, source = 1 },       -- 黑色战熊
    [60136] = { itemID = 0, versionID = 0, source = 43 },       -- 重型旅行猛犸象
    [60140] = { itemID = 0, versionID = 0, source = 43 },       -- 重型旅行猛犸象
    [60424] = { itemID = 44413, versionID = 102, source = 27 },       -- 机械师的摩托车
    [61229] = { itemID = 44689, versionID = 3, source = 6 },       -- 装甲雪色狮鹫
    [61230] = { itemID = 44690, versionID = 3, source = 6 },       -- 装甲蓝色驭风者
    [61294] = { itemID = 44707, versionID = 3, source = 2 },       -- 绿色始祖幼龙
    [61309] = { itemID = 44558, versionID = 102, source = 31 },       -- 华丽的飞毯
    [61425] = { itemID = 44235, versionID = 3, source = 6 },       -- 旅行者的苔原猛犸象
    [61447] = { itemID = 44234, versionID = 3, source = 6 },       -- 旅行者的苔原猛犸象
    [61451] = { itemID = 44554, versionID = 102, source = 31 },  -- 飞毯
    [61465] = { itemID = 43959, versionID = 3, source = 5 },       -- 重型黑色猛犸战象
    [61467] = { itemID = 44083, versionID = 3, source = 5 },       -- 重型黑色猛犸战象
    [61469] = { itemID = 44086, versionID = 3, source = 302 },       -- 重型冰雪猛犸象
    [61470] = { itemID = 43961, versionID = 3, source = 302 },       -- 重型冰雪猛犸象
    [61996] = { itemID = 44843, versionID = 104, source = 1024 },       -- 蓝色龙鹰
    [61997] = { itemID = 44842, versionID = 104, source = 1024 },       -- 红色龙鹰
    [62048] = { itemID = 186469, versionID = 100, source = 26 },       -- 伊利达雷末日龙鹰
    [63232] = { itemID = 45125, versionID = 3, source = 301 },       -- 暴风城战马
    [63635] = { itemID = 45593, versionID = 3, source = 301 },       -- 暗矛迅猛龙
    [63636] = { itemID = 45586, versionID = 3, source = 301 },       -- 铁炉堡战羊
    [63637] = { itemID = 45591, versionID = 3, source = 301 },       -- 达纳苏斯夜刃豹
    [63638] = { itemID = 45589, versionID = 3, source = 301 },       -- 诺莫瑞根机械陆行鸟
    [63639] = { itemID = 45590, versionID = 3, source = 301 },       -- 埃索达雷象
    [63640] = { itemID = 45595, versionID = 3, source = 301 },       -- 奥格瑞玛战狼
    [63641] = { itemID = 45592, versionID = 3, source = 301 },       -- 雷霆崖科多兽
    [63642] = { itemID = 45596, versionID = 3, source = 301 },       -- 银月城陆行鸟
    [63643] = { itemID = 45597, versionID = 3, source = 301 },       -- 被遗忘者战马
    [63796] = { itemID = 45693, versionID = 3, source = 5 },       -- 米米尔隆的头部
    [63844] = { itemID = 45725, versionID = 3, source = 301 },       -- 银色角鹰兽
    [63956] = { itemID = 45801, versionID = 3, source = 1 },       -- 铁箍始祖幼龙
    [63963] = { itemID = 45802, versionID = 3, source = 1 },       -- 铁锈始祖幼龙
    [64656] = { itemID = 0, versionID = 0, source = 43 },       -- 蓝色骷髅战马
    [64657] = { itemID = 46100, versionID = 1, source = 151 },       -- 白色科多兽
    [64658] = { itemID = 46099, versionID = 1, source = 150 },       -- 黑狼
    [64659] = { itemID = 46102, versionID = 1, source = 10 },       -- 毒皮暴掠龙
    [64731] = { itemID = 46109, versionID = 6, source = 34 },       -- 海龟
    [64927] = { itemID = 46708, versionID = 105, source = 42 },       -- 致命角斗士的冰霜巨龙
    [64977] = { itemID = 46308, versionID = 1, source = 152 },       -- 黑色骸骨军马
    [65439] = { itemID = 46171, versionID = 105, source = 42 },       -- 狂怒角斗士的冰霜巨龙
    [65637] = { itemID = 46745, versionID = 3, source = 301 },       -- 重型红色雷象
    [65638] = { itemID = 46744, versionID = 3, source = 301 },       -- 迅捷月刃豹
    [65639] = { itemID = 46751, versionID = 3, source = 301 },       -- 迅捷红色陆行鸟
    [65640] = { itemID = 46752, versionID = 3, source = 301 },       -- 迅捷灰马
    [65641] = { itemID = 46750, versionID = 3, source = 301 },       -- 大型金色科多兽
    [65642] = { itemID = 46747, versionID = 3, source = 301 },       -- 涡轮机械陆行鸟
    [65643] = { itemID = 46748, versionID = 3, source = 301 },       -- 迅捷紫色战羊
    [65644] = { itemID = 46743, versionID = 3, source = 301 },       -- 迅捷紫色迅猛龙
    [65645] = { itemID = 46746, versionID = 3, source = 301 },       -- 白色骷髅战马
    [65646] = { itemID = 46749, versionID = 3, source = 301 },       -- 迅捷紫鬃战狼
    [65917] = { itemID = 49290, versionID = 101, source = 48 },       -- 魔法公鸡
    [66087] = { itemID = 46813, versionID = 3, source = 301 },       -- 银色盟约角鹰兽
    [66088] = { itemID = 46814, versionID = 3, source = 301 },       -- 夺日者龙鹰
    [66090] = { itemID = 46815, versionID = 3, source = 301 },       -- 奎尔多雷战马
    [66091] = { itemID = 46816, versionID = 3, source = 301 },       -- 夺日者陆行鸟
    [66122] = { itemID = 0, versionID = 0, source = 43 },       -- 魔法公鸡
    [66123] = { itemID = 0, versionID = 0, source = 43 },       -- 魔法公鸡
    [66124] = { itemID = 0, versionID = 0, source = 43 },       -- 魔法公鸡
    [66846] = { itemID = 47101, versionID = 1, source = 152 },       -- 赭色骷髅战马
    [66847] = { itemID = 47100, versionID = 1, source = 154 },       -- 条纹晨刃豹
    [66906] = { itemID = 47179, versionID = 3, source = 301 },       -- 银色军马
    [67336] = { itemID = 47840, versionID = 105, source = 42 },       -- 无情角斗士的冰霜巨龙
    [67466] = { itemID = 47180, versionID = 3, source = 301 },       -- 银色战马
    [68056] = { itemID = 49046, versionID = 105, source = 1 },       -- 迅捷部落战狼
    [68057] = { itemID = 49044, versionID = 105, source = 1 },       -- 迅捷联盟战马
    [68187] = { itemID = 49096, versionID = 105, source = 1 },       -- 十字军的白色战马
    [68188] = { itemID = 49098, versionID = 105, source = 1 },       -- 十字军的黑色战马
    [69395] = { itemID = 49636, versionID = 3, source = 5 },   -- 奥妮克希亚幼龙
    [69820] = { itemID = 0, versionID = 104, source = 102 },       -- 烈日行者科多兽
    [69826] = { itemID = 0, versionID = 104, source = 102 },       -- 巨型烈日行者科多兽
    [71342] = { itemID = 50250, versionID = 100, source = 50 },       -- X-45偷心火箭
    [71810] = { itemID = 50435, versionID = 105, source = 42 },       -- 暴怒角斗士的冰霜巨龙
    [72286] = { itemID = 50818, versionID = 3, source = 5 },       -- 无敌
    [72807] = { itemID = 51955, versionID = 3, source = 1 },       -- 缚寒冰霜征服者
    [72808] = { itemID = 51954, versionID = 3, source = 1 },       -- 浴血冰霜征服者
    [73313] = { itemID = 52200, versionID = 3, source = 10 },       -- 血色死亡战马
    [73629] = { itemID = 0, versionID = 104, source = 102 },       -- 主教的雷象
    [73630] = { itemID = 0, versionID = 104, source = 102 },       -- 大主教的雷象
    [74856] = { itemID = 54069, versionID = 101, source = 48 },       -- 炽焰角鹰兽
    [74918] = { itemID = 54068, versionID = 101, source = 48 },       -- 白毛犀牛
    [75207] = { itemID = 54465, versionID = 4, source = 10 },       -- 瓦丝琪尔海马
    [75596] = { itemID = 54797, versionID = 102, source = 31 },       -- 凝霜飞毯
    [75614] = { itemID = 54811, versionID = 101, source = 20 },       -- 星骓
    [75973] = { itemID = 54860, versionID = 106, source = 18 },       -- X-53型观光火箭
    [84751] = { itemID = 60954, versionID = 102, source = 35 },  -- 化石迅猛龙
    [87090] = { itemID = 0, versionID = 1, source = 173 },       -- 地精三轮摩托
    [87091] = { itemID = 0, versionID = 1, source = 173 },       -- 地精三轮摩托涡轮增压型
    [88331] = { itemID = 62900, versionID = 4, source = 1 },   -- 火山石幼龙
    [88335] = { itemID = 62901, versionID = 4, source = 1 },       -- 东风幼龙
    [88718] = { itemID = 63042, versionID = 4, source = 4 },       -- 磷光石幼龙
    [88741] = { itemID = 65356, versionID = 4, source = 401 },       -- 西风幼龙
    [88742] = { itemID = 63040, versionID = 4, source = 3 },       -- 北风幼龙
    [88744] = { itemID = 63041, versionID = 4, source = 5 },       -- 南风幼龙
    [88746] = { itemID = 63043, versionID = 4, source = 3 },       -- 琉璃石幼龙
    [88748] = { itemID = 63044, versionID = 4, source = 402 },       -- 棕色骑乘骆驼
    [88749] = { itemID = 63045, versionID = 4, source = 402 },       -- 褐色骑乘骆驼
    [88750] = { itemID = 63046, versionID = 4, source = 7 },       -- 灰色骑乘骆驼
    [88990] = { itemID = 63125, versionID = 104, source = 40 },       -- 暗色凤凰
    [90621] = { itemID = 62298, versionID = 104, source = 40 },       -- 黄金狮王
    [92155] = { itemID = 64883, versionID = 102, source = 35 },       -- 深蓝其拉作战坦克
    [92231] = { itemID = 64998, versionID = 4, source = 401 },       -- 鬼灵战马
    [92232] = { itemID = 64999, versionID = 4, source = 401 },       -- 鬼灵座狼
    [93326] = { itemID = 65891, versionID = 102, source = 33 },       -- 沙石幼龙
    [93623] = { itemID = 68008, versionID = 101, source = 48 },       -- 斑纹幼龙
    [93644] = { itemID = 67107, versionID = 104, source = 40 },       -- 库卡隆横扫者
    [96491] = { itemID = 68823, versionID = 4, source = 3 },       -- 装甲拉扎什迅猛龙
    [96499] = { itemID = 68824, versionID = 4, source = 3 },       -- 迅捷祖利安黑豹
    [96503] = { itemID = 68825, versionID = 101, source = 48 },       -- 阿曼尼龙鹰
    [97359] = { itemID = 69213, versionID = 4, source = 1 },       -- 浴火角鹰兽
    [97493] = { itemID = 69224, versionID = 4, source = 5 },       -- 纯血火鹰
    [97501] = { itemID = 69226, versionID = 104, source = 1024 },       -- 魔能火鹰
    [97560] = { itemID = 69230, versionID = 4, source = 1 },       -- 堕落火鹰
    [97581] = { itemID = 69228, versionID = 101, source = 48 },       -- 野蛮迅猛龙
    [98204] = { itemID = 69747, versionID = 4, source = 3 },       -- 阿曼尼斗熊
    [98718] = { itemID = 67151, versionID = 4, source = 4 },       -- 驯服的海马
    [98727] = { itemID = 69846, versionID = 101, source = 20 }, -- 飞翼守护者
    [100332] = { itemID = 70909, versionID = 103, source = 1 },      -- 勇猛的战驹
    [100333] = { itemID = 70910, versionID = 103, source = 1 },      -- 勇猛的战狼
    [101282] = { itemID = 71339, versionID = 105, source = 42 },      -- 残忍角斗士的暮光幼龙
    [101542] = { itemID = 71665, versionID = 4, source = 5 },      -- 奥利瑟拉佐尔的烈焰之爪
    [101573] = { itemID = 71718, versionID = 101, source = 48 },      -- 迅捷海滨陆行鸟
    [101821] = { itemID = 71954, versionID = 105, source = 42 },      -- 冷酷角斗士的暮光幼龙
    [102346] = { itemID = 72140, versionID = 100, source = 51 },      -- 迅捷森林陆行鸟
    [102349] = { itemID = 72145, versionID = 100, source = 52 },      -- 迅捷春日陆行鸟
    [102350] = { itemID = 72146, versionID = 100, source = 50 },      -- 迅捷爱情鸟
    [102488] = { itemID = 72575, versionID = 101, source = 48 },      -- 白色骑乘骆驼
    [102514] = { itemID = 72582, versionID = 101, source = 48 },      -- 堕落角鹰兽
    [103081] = { itemID = 73766, versionID = 100, source = 51 },      -- 暗月跳舞熊
    [103195] = { itemID = 73838, versionID = 1, source = 155 },      -- 高山马
    [103196] = { itemID = 73839, versionID = 1, source = 155 },      -- 迅捷高山马
    [107203] = { itemID = 0, versionID = 101, source = 20 },      -- 泰瑞尔的天使战马
    [107516] = { itemID = 76889, versionID = 106, source = 18 }, -- 幽灵狮鹫
    [107517] = { itemID = 76902, versionID = 106, source = 18 }, -- 幽灵驭风者
    [107842] = { itemID = 77067, versionID = 4, source = 5 },      -- 炽炎幼龙
    [107844] = { itemID = 77068, versionID = 4, source = 1 },      -- 暮光先驱者
    [107845] = { itemID = 77069, versionID = 4, source = 5 },      -- 生命缚誓者的仆从
    [110039] = { itemID = 78919, versionID = 4, source = 5 },      -- 实验体12-B
    [110051] = { itemID = 78924, versionID = 101, source = 20 },       -- 守护巨龙之心
    [113120] = { itemID = 79771, versionID = 101, source = 48 },      -- 邪能幼龙
    [113199] = { itemID = 79802, versionID = 5, source = 501 },      -- 翠绿云端翔龙
    [118089] = { itemID = 81354, versionID = 5, source = 2 },      -- 天蓝水黾
    [118737] = { itemID = 81559, versionID = 5, source = 1 },      -- 熊猫人风筝
    [120043] = { itemID = 82453, versionID = 102, source = 30 },      -- 宝石玛瑙猎豹
    [120395] = { itemID = 82765, versionID = 1, source = 156 },      -- 绿色龙龟
    [120822] = { itemID = 82811, versionID = 1, source = 156 },  -- 巨型红色龙龟
    [121820] = { itemID = 83086, versionID = 105, source = 19 },      -- 黑曜夜之翼
    [121836] = { itemID = 83090, versionID = 102, source = 30 },      -- 蓝宝石猎豹
    [121837] = { itemID = 83088, versionID = 102, source = 30 },      -- 翡翠猎豹
    [121838] = { itemID = 83087, versionID = 102, source = 30 },      -- 红宝石猎豹
    [121839] = { itemID = 83089, versionID = 102, source = 30 },      -- 日长石猎豹
    [122708] = { itemID = 84101, versionID = 5, source = 6 },      -- 雄壮远足牦牛
    [123182] = { itemID = 84753, versionID = 105, source = 1001 },      -- 咔啡牦牛
    [123886] = { itemID = 85262, versionID = 5, source = 1 },      -- 琥珀巨蝎
    [123992] = { itemID = 85430, versionID = 5, source = 501 },      -- 碧蓝云端翔龙
    [123993] = { itemID = 85429, versionID = 5, source = 501 },      -- 金色云端翔龙
    [124408] = { itemID = 85666, versionID = 104, source = 40 },  -- 雷霆翡翠云端翔龙
    [124550] = { itemID = 85785, versionID = 105, source = 42 },      -- 灾变角斗士暮光幼龙
    [124659] = { itemID = 85870, versionID = 101, source = 1007 }, -- 皇家魁麟
    [126507] = { itemID = 87250, versionID = 102, source = 27 },      -- 衰变凯帕铀火箭
    [126508] = { itemID = 87251, versionID = 102, source = 27 },      -- 对地同步世界旋转器
    [127154] = { itemID = 87768, versionID = 5, source = 10 },      -- 玛瑙云端翔龙
    [127156] = { itemID = 87769, versionID = 5, source = 1 },      -- 猩红云端翔龙
    [127158] = { itemID = 87771, versionID = 5, source = 8 },      -- 神圣玛瑙云端翔龙
    [127161] = { itemID = 87773, versionID = 5, source = 1 },      -- 神圣猩红云端翔龙
    [127164] = { itemID = 87774, versionID = 5, source = 2 },      -- 神圣金色云端翔龙
    [127165] = { itemID = 87775, versionID = 100, source = 1002 },      -- 玉蕾，青龙之女
    [127169] = { itemID = 87776, versionID = 104 , source = 1024 },      -- 神圣碧蓝云端翔龙
    [127170] = { itemID = 87777, versionID = 5, source = 5 },      -- 星光云端翔龙
    [127174] = { itemID = 87781, versionID = 5, source = 505 },      -- 天蓝骑乘仙鹤
    [127176] = { itemID = 87782, versionID = 5, source = 505 },      -- 金黄骑乘仙鹤
    [127177] = { itemID = 87783, versionID = 5, source = 505 },      -- 帝王骑乘仙鹤
    [127178] = { itemID = 87784, versionID = 105, source = 1001 },      -- 丛林骑乘仙鹤
    [127209] = { itemID = 87786, versionID = 105, source = 1001 },      -- 黑色骑乘牦牛
    [127213] = { itemID = 87787, versionID = 105, source = 1001 },      -- 谦逊远足牦牛
    [127216] = { itemID = 87788, versionID = 5, source = 6 },      -- 灰色骑乘牦牛
    [127220] = { itemID = 87789, versionID = 5, source = 6 },      -- 金色骑乘牦牛
    [127271] = { itemID = 87791, versionID = 102, source = 34 },      -- 猩红水黾
    [127286] = { itemID = 87795, versionID = 1, source = 156 },      -- 黑色龙龟
    [127287] = { itemID = 91008, versionID = 1, source = 156 },      -- 蓝色龙龟
    [127288] = { itemID = 91005, versionID = 1, source = 156 },      -- 棕色龙龟
    [127289] = { itemID = 91006, versionID = 1, source = 156 },      -- 紫色龙龟
    [127290] = { itemID = 91007, versionID = 1, source = 156 },      -- 红色龙龟
    [127293] = { itemID = 91012, versionID = 1, source = 156 },      -- 巨型绿色龙龟
    [127295] = { itemID = 91011, versionID = 1, source = 156 },      -- 巨型黑色龙龟
    [127302] = { itemID = 91013, versionID = 1, source = 156 },      -- 巨型蓝色龙龟
    [127308] = { itemID = 91014, versionID = 1, source = 156 },      -- 巨型棕色龙龟
    [127310] = { itemID = 91015, versionID = 1, source = 156 },      -- 巨型紫色龙龟
    [129552] = { itemID = 89154, versionID = 105, source = 1003 },      -- 赤红熊猫人凤凰
    [129918] = { itemID = 89304, versionID = 5, source = 2 },      -- 雷霆天神云端翔龙
    [129932] = { itemID = 89305, versionID = 5, source = 502 },      -- 绿色影踪派骑乘虎
    [129934] = { itemID = 89307, versionID = 5, source = 502 },      -- 蓝色影踪派骑乘虎
    [129935] = { itemID = 89306, versionID = 5, source = 502 },      -- 红色影踪派骑乘虎
    [130086] = { itemID = 89362, versionID = 5, source = 503 },      -- 棕色骑乘山羊
    [130092] = { itemID = 89363, versionID = 5, source = 2 },     -- 红色筋斗云
    [130137] = { itemID = 89390, versionID = 5, source = 503 },      -- 白色骑乘山羊
    [130138] = { itemID = 89391, versionID = 5, source = 503 },      -- 黑色骑乘山羊
    [130965] = { itemID = 89783, versionID = 5, source = 8 },      -- 炮舰之子
    [130985] = { itemID = 89785, versionID = 5, source = 1 },      -- 熊猫人风筝
    [132036] = { itemID = 90655, versionID = 5, source = 4 },      -- 雷霆红玉云端翔龙
    [132117] = { itemID = 90710, versionID = 105, source = 1003 },      -- 燃灰熊猫人凤凰
    [132118] = { itemID = 90711, versionID = 105, source = 1003 },      -- 翠绿熊猫人凤凰
    [132119] = { itemID = 90712, versionID = 105, source = 1003 },      -- 蓝紫熊猫人凤凰
    [133023] = { itemID = 91802, versionID = 104, source = 1024 },      -- 翠绿熊猫人风筝
    [134359] = { itemID = 95416, versionID = 102, source = 27 },      -- 飞天魔像
    [134573] = { itemID = 92724, versionID = 101, source = 20 },      -- 追风
    [135416] = { itemID = 93168, versionID = 5, source = 1 },      -- 重装狮鹫
    [135418] = { itemID = 93169, versionID = 5, source = 1 },      -- 重装双足飞龙
    [136163] = { itemID = 93385, versionID = 5, source = 10 },  -- 雄壮狮鹫
    [136164] = { itemID = 93386, versionID = 5, source = 10 },  -- 雄壮双足飞龙
    [136400] = { itemID = 93662, versionID = 5, source = 1 },      -- 装甲啸天龙
    [136471] = { itemID = 93666, versionID = 5, source = 5 },      -- 赫利东的子嗣
    [136505] = { itemID = 93671, versionID = 101, source = 48 },      -- 幽灵军马
    [138423] = { itemID = 94228, versionID = 5, source = 8 },      -- 冰蓝原始恐角龙
    [138424] = { itemID = 94230, versionID = 5, source = 4 },      -- 珀光原始恐角龙
    [138425] = { itemID = 94229, versionID = 5, source = 4 },      -- 岩灰原始恐角龙
    [138426] = { itemID = 94231, versionID = 5, source = 4 },      -- 翡翠原始恐角龙
    [138640] = { itemID = 94290, versionID = 5, source = 10 },      -- 白色原始迅猛龙
    [138641] = { itemID = 94291, versionID = 5, source = 4 },      -- 红色原始迅猛龙
    [138642] = { itemID = 94292, versionID = 5, source = 4 },      -- 黑色原始迅猛龙
    [138643] = { itemID = 94293, versionID = 5, source = 4 },      -- 绿色原始迅猛龙
    [139407] = { itemID = 95041, versionID = 105, source = 42 },      -- 恶毒角斗士云端翔龙
    [139442] = { itemID = 95057, versionID = 5, source = 8 },      -- 雷霆蓝晶云端翔龙
    [139448] = { itemID = 95059, versionID = 5, source = 5 },      -- 季鹍之嗣
    [139595] = { itemID = 95341, versionID = 101, source = 20 },      -- 装甲血翼蝠
    [140249] = { itemID = 95564, versionID = 5, source = 1 },      -- 黄金原始恐角龙
    [140250] = { itemID = 95565, versionID = 5, source = 1 },      -- 深红原始恐角龙
    [142073] = { itemID = 98618, versionID = 101, source = 1004 },      -- 炉石天马
    [142266] = { itemID = 98104, versionID = 104, source = 1024 },      -- 红色装甲龙鹰
    [142478] = { itemID = 98259, versionID = 104, source = 1024 },      -- 蓝色装甲龙鹰
    [142641] = { itemID = 98405, versionID = 105, source = 1005 },      -- 拳手的健壮穆山兽
    [142878] = { itemID = 97989, versionID = 101, source = 20 },      -- 魔法灵龙
    [142910] = { itemID = 129922, versionID = 100, source = 1002 },      -- 铁箍鬼灵战马
    [146615] = { itemID = 102514, versionID = 103, source = 1006 },      -- 勇猛卡多雷作战刃豹
    [146622] = { itemID = 102533, versionID = 103, source = 1006 },      -- 邪恶骷髅战马
    [148392] = { itemID = 104208, versionID = 5, source = 1 },      -- 迦拉卡斯的子嗣
    [148396] = { itemID = 104246, versionID = 105, source = 1 },      -- 库卡隆战狼
    [148417] = { itemID = 104253, versionID = 5, source = 5 },      -- 库卡隆战蝎
    [148428] = { itemID = 103638, versionID = 103, source = 504 },      -- 灰皮穆山兽
    [148476] = { itemID = 104269, versionID = 5, source = 4 },      -- 雷霆玛瑙云端翔龙
    [148618] = { itemID = 104325, versionID = 105, source = 42 },      -- 暴虐角斗士云端翔龙
    [148619] = { itemID = 104326, versionID = 105, source = 42 },      -- 恶孽角斗士云端翔龙
    [148620] = { itemID = 104327, versionID = 105, source = 42 },      -- 骄矜角斗士云端翔龙
    [149801] = { itemID = 106246, versionID = 105, source = 19 },      -- 翡翠角鹰兽
    [153489] = { itemID = 107951, versionID = 101, source = 20 },      -- 钢铁碎天兽
    [155741] = { itemID = 109013, versionID = 101, source = 1007 },      -- 恐惧渡鸦
    [163024] = { itemID = 112326, versionID = 101, source = 20 }, -- 战火梦魇兽
    [163025] = { itemID = 112327, versionID = 101, source = 20 }, -- 狞笑掠夺者
    [169952] = { itemID = 115363, versionID = 102, source = 31 },      -- 蠕行飞毯
    [170347] = { itemID = 115484, versionID = 106, source = 26 },      -- 熔火恶犬
    [171436] = { itemID = 116383, versionID = 6, source = 1 },      -- 踏血小戈隆
    [171616] = { itemID = 116655, versionID = 6, source = 6 },      -- 枯皮悬崖践踏者
    [171617] = { itemID = 116656, versionID = 6, source = 601 },      -- 驯养的冰蹄牛
    [171619] = { itemID = 116658, versionID = 6, source = 4 },      -- 苔原冰蹄牛
    [171620] = { itemID = 116659, versionID = 6, source = 4 },      -- 血蹄公牛
    [171621] = { itemID = 116660, versionID = 6, source = 5 },      -- 铁蹄毁灭者
    [171622] = { itemID = 116661, versionID = 6, source = 4 },      -- 斑点草地践踏者
    [171623] = { itemID = 116662, versionID = 6, source = 601 },      -- 驯养的草地践踏者
    [171624] = { itemID = 116663, versionID = 6, source = 602 },      -- 暗皮珠齿象
    [171625] = { itemID = 116664, versionID = 6, source = 2 },      -- 土色岩皮雷象
    [171626] = { itemID = 116665, versionID = 6, source = 18 },      -- 装甲铁牙践踏者
    [171627] = { itemID = 116666, versionID = 104, source = 40 },      -- 黑钢斗猪
    [171628] = { itemID = 116667, versionID = 6, source = 6 },      -- 石牙斗猪
    [171629] = { itemID = 116668, versionID = 6, source = 601 },      -- 装甲霜鬃野猪
    [171630] = { itemID = 116669, versionID = 6, source = 4 },      -- 装甲刀脊野猪
    [171632] = { itemID = 116670, versionID = 6, source = 1 },      -- 霜原斗猪
    [171633] = { itemID = 116671, versionID = 6, source = 2 },      -- 野生血牙野猪
    [171634] = { itemID = 116672, versionID = 6, source = 6 },      -- 驯养的刀脊野猪
    [171635] = { itemID = 116673, versionID = 6, source = 602 },      -- 巨型冻吻野猪
    [171636] = { itemID = 116674, versionID = 6, source = 4 },      -- 巨型灰牙野猪
    [171637] = { itemID = 116675, versionID = 6, source = 601 },      -- 驯养的石牙野猪
    [171638] = { itemID = 116676, versionID = 6, source = 601 },      -- 驯养的淡水兽
    [171824] = { itemID = 116767, versionID = 6, source = 4 },      -- 天蓝淡水兽
    [171825] = { itemID = 116768, versionID = 6, source = 6 },      -- 苔皮淡水兽
    [171826] = { itemID = 116769, versionID = 6, source = 10 },      -- 泥背淡水兽
    [171827] = { itemID = 137575, versionID = 7, source = 5 },      -- 炎狱地狱火
    [171828] = { itemID = 116771, versionID = 6, source = 8 },      -- 日光峰林飞鹰
    [171829] = { itemID = 116772, versionID = 6, source = 2 },      -- 暗鬃冲锋者
    [171830] = { itemID = 116773, versionID = 6, source = 4 },      -- 迅捷风蹄塔布羊
    [171831] = { itemID = 116774, versionID = 6, source = 601 },      -- 驯养的银鬃塔布羊
    [171832] = { itemID = 116775, versionID = 6, source = 2 },      -- 风蹄公羊
    [171833] = { itemID = 116776, versionID = 6, source = 2 },      -- 苍白食棘者
    [171834] = { itemID = 116777, versionID = 103, source = 1006 },      -- 勇猛战羊
    [171835] = { itemID = 116778, versionID = 103, source = 1006 },      -- 勇猛作战迅猛龙
    [171836] = { itemID = 116779, versionID = 6, source = 602 },      -- 钢喉铁颚狼
    [171837] = { itemID = 116780, versionID = 6, source = 4 },      -- 战歌恐牙狼
    [171838] = { itemID = 116781, versionID = 6, source = 601 },      -- 装甲霜狼
    [171839] = { itemID = 116782, versionID = 6, source = 18 },      -- 铁甲战狼
    [171840] = { itemID = 137576, versionID = 106, source = 18 },      -- 冷焰地狱火
    [171841] = { itemID = 116784, versionID = 6, source = 601 },      -- 驯养的啸狼
    [171842] = { itemID = 116785, versionID = 6, source = 2 },      -- 迅捷霜狼
    [171843] = { itemID = 116786, versionID = 6, source = 602 },      -- 烟灰恐狼
    [171844] = { itemID = 108883, versionID = 102, source = 29 },      -- 灰鬃恐狼
    [171845] = { itemID = 116788, versionID = 104, source = 1008 },      -- 督军的死亡之轮
    [171846] = { itemID = 116789, versionID = 104, source = 1008 },      -- 勇士的践踏之刃
    [171847] = { itemID = 118515, versionID = 106, source = 18 },      -- 烬鬃战马
    [171848] = { itemID = 116791, versionID = 105, source = 603 },      -- 挑战者的作战雪人
    [171849] = { itemID = 116792, versionID = 6, source = 4 },      -- 阳炎之肤小戈隆
    [171850] = { itemID = 137573, versionID = 7, source = 10 },      -- 洛希恩徘徊者
    [171851] = { itemID = 116794, versionID = 6, source = 4 },      -- 夜嚎铁颚狼
    [175700] = { itemID = 118676, versionID = 104, source = 1024 },      -- 翡翠幼龙
    [179244] = { itemID = 122703, versionID = 104, source = 1025 },      -- 代驾型机械路霸
    [179245] = { itemID = 120968, versionID = 104, source = 1025 },      -- 代驾型机械师的摩托车
    [179478] = { itemID = 121815, versionID = 6, source = 4 },      -- 黑暗之星的灵爪飞鹰
    [180545] = { itemID = 122469, versionID = 101, source = 20 },      -- 秘魔刃豹
    [182912] = { itemID = 123890, versionID = 6, source = 5 },      -- 魔钢歼灭者
    [183117] = { itemID = 123974, versionID = 6, source = 2 },      -- 腐化恐翼鸦
    [183889] = { itemID = 124089, versionID = 103, source = 1006 },      -- 勇猛的战斗机械陆行鸟
    [185052] = { itemID = 124540, versionID = 103, source = 1006 },      -- 勇猛的科多战兽
    [186305] = { itemID = 127140, versionID = 6, source = 1 },      -- 地火恐狼
    [186828] = { itemID = 128277, versionID = 105, source = 42 }, -- 原祖角斗士的魔血小戈隆
    [189043] = { itemID = 128281, versionID = 105, source = 42 },      -- 狂野角斗士的魔血小戈隆
    [189044] = { itemID = 128282, versionID = 105, source = 42 },      -- 好战角斗士的魔血小戈隆
    [189364] = { itemID = 128311, versionID = 6, source = 10 },      -- 煤拳小戈隆
    [189998] = { itemID = 128425, versionID = 101, source = 1007 },      -- 伊利达雷魔犬
    [189999] = { itemID = 128422, versionID = 105, source = 1023 },      -- 林地守卫者
    [190690] = { itemID = 128480, versionID = 6, source = 2 },      -- 钢鬃地狱野猪
    [190977] = { itemID = 128526, versionID = 6, source = 2 },      -- 死牙魔能野猪
    [191314] = { itemID = 128671, versionID = 100, source = 53 },      -- 格噜普斯的爪牙
    [191633] = { itemID = 128706, versionID = 6, source = 1 },      -- 飞天魔龙
    [193007] = { itemID = 141216, versionID = 7, source = 1 },      -- 林地污染者
    [193695] = { itemID = 129280, versionID = 103, source = 1 },      -- 声威战马
    [194046] = { itemID = 0, versionID = 0, source = 43 },      -- 迅捷幽灵双头飞龙
    [194464] = { itemID = 129923, versionID = 100, source = 1002 },      -- 日蚀龙鹰
    [196681] = { itemID = 131734, versionID = 102, source = 35 },      -- 艾特洛之魂
    [200175] = { itemID = 0, versionID = 104, source = 103 },      -- 邪刃豹
    [201098] = { itemID = 133543, versionID = 100, source = 1002 },      -- 永恒时空撕裂者
    [204166] = { itemID = 143864, versionID = 103, source = 1 },      -- 声威战狼
    [213115] = { itemID = 137570, versionID = 7, source = 6 },      -- 血牙寡妇蛛
    [213134] = { itemID = 137574, versionID = 7, source = 5 },      -- 邪焰地狱火
    [213158] = { itemID = 137577, versionID = 7, source = 10 },      -- 掠食血眼龙
    [213163] = { itemID = 137578, versionID = 7, source = 10 },      -- 雪羽猎龙
    [213164] = { itemID = 137579, versionID = 7, source = 10 },      -- 火羽恐嘴龙
    [213165] = { itemID = 137580, versionID = 7, source = 10 },      -- 翠绿利爪龙
    [213209] = { itemID = 137686, versionID = 102, source = 28 },      -- 钢缚吞噬者
    [213339] = { itemID = 129962, versionID = 102, source = 29 },      -- 巨型北地大角鹿
    [213349] = { itemID = 137615, versionID = 0, source = 1026 },      -- 炎核地狱火
    [213350] = { itemID = 137614, versionID = 104, source = 1024 },      -- 霜裂地狱火
    [214791] = { itemID = 138811, versionID = 102, source = 34 },      -- 深海喂食者
    [215159] = { itemID = 138258, versionID = 7, source = 44 },      -- 失落已久的角鹰兽
    [215545] = { itemID = 186479, versionID = 9, source = 904 },      -- 精铸墓翼蝠
    [215558] = { itemID = 138387, versionID = 104, source = 1 },      -- 骑乘巨鼠
    [222202] = { itemID = 140228, versionID = 103, source = 1009 },      -- 声威青铜骏马
    [222236] = { itemID = 140230, versionID = 103, source = 1009 },      -- 声威皇室骏马
    [222237] = { itemID = 140232, versionID = 103, source = 1009 },      -- 声威森林骏马
    [222238] = { itemID = 140233, versionID = 103, source = 1009 },      -- 声威牙白骏马
    [222240] = { itemID = 140408, versionID = 103, source = 1009 },      -- 声威蔚蓝骏马
    [222241] = { itemID = 140407, versionID = 103, source = 1009 },      -- 声威午夜骏马
    [223018] = { itemID = 138201, versionID = 7, source = 44 },      -- 深海水母
    [223341] = { itemID = 140353, versionID = 103, source = 1006 },      -- 勇猛的吉尔尼斯战马
    [223354] = { itemID = 140354, versionID = 103, source = 1006 },      -- 勇猛的战车
    [223363] = { itemID = 140348, versionID = 103, source = 1006 },      -- 勇猛作战陆行鸟
    [223578] = { itemID = 140350, versionID = 103, source = 1006 },      -- 勇猛的作战雷象
    [223814] = { itemID = 140500, versionID = 104, source = 1 },      -- 机械化木材采集器
    [225765] = { itemID = 141217, versionID = 7, source = 1 },      -- 魔羽角鹰兽
    [227956] = { itemID = 141713, versionID = 7, source = 6 },      -- 阿坎迪安战龟
    [227986] = { itemID = 141843, versionID = 105, source = 42 },      -- 血仇角斗士的风暴巨龙
    [227988] = { itemID = 141844, versionID = 105, source = 42 },      -- 无畏角斗士的风暴巨龙
    [227989] = { itemID = 141845, versionID = 105, source = 42 },      -- 残虐角斗士的风暴巨龙
    [227991] = { itemID = 141846, versionID = 105, source = 42 },      -- 凶猛角斗士的风暴巨龙
    [227994] = { itemID = 141847, versionID = 105, source = 42 },      -- 暴烈角斗士的风暴巨龙
    [227995] = { itemID = 141848, versionID = 105, source = 42 },      -- 专横角斗士的风暴巨龙
    [228919] = { itemID = 142398, versionID = 100, source = 51 },      -- 暗水鳐鱼
    [229376] = { itemID = 0, versionID = 7, source = 1010 },      -- 大法师的棱光飞碟
    [229377] = { itemID = 0, versionID = 7, source = 1010 },      -- 大祭司的光誓寻觅者
    [229385] = { itemID = 142225, versionID = 7, source = 1010 },      -- 班禄，大宗师的伙伴
    [229386] = { itemID = 142227, versionID = 7, source = 1010 },      -- 狩猎大师的忠诚狼鹰
    [229387] = { itemID = 142231, versionID = 7, source = 1010 },      -- 死亡领主的邪嗣征服者
    [229388] = { itemID = 142232, versionID = 7, source = 1010 },      -- 战争领主的嗜血战龙
    [229417] = { itemID = 0, versionID = 7, source = 1010 },      -- 屠魔者的破邪尖啸者
    [229438] = { itemID = 142226, versionID = 7, source = 1010 },      -- 狩猎大师的凶猛狼鹰
    [229439] = { itemID = 142228, versionID = 7, source = 1010 },      -- 狩猎大师的恐怖狼鹰
    [229486] = { itemID = 142235, versionID = 103, source = 1006 },      -- 邪恶战熊
    [229487] = { itemID = 142234, versionID = 103, source = 1006 },      -- 邪恶战熊
    [229499] = { itemID = 142236, versionID = 7, source = 3 },      -- 午夜
    [229512] = { itemID = 142237, versionID = 103, source = 1006 },      -- 邪恶战狮
    [230401] = { itemID = 142369, versionID = 103, source = 2 },      -- 乳白陆行鸟
    [230844] = { itemID = 142403, versionID = 105, source = 1005 }, -- 拳手的健壮蜥蜴
    [230987] = { itemID = 142436, versionID = 7, source = 10 },      -- 奥术师的魔刃豹
    [230988] = { itemID = 142437, versionID = 103, source = 1006 },      -- 邪恶战蝎
    [231428] = { itemID = 142552, versionID = 7, source = 3 },      -- 燃烬巨龙
    [231434] = { itemID = 143493, versionID = 7, source = 1010 },      -- 暗影之刃的谋杀预兆
    [231435] = { itemID = 143502, versionID = 7, source = 1010 },      -- 大领主的金辉战马
    [231442] = { itemID = 143489, versionID = 7, source = 1010 },      -- 先知的狂怒风暴
    [231523] = { itemID = 143492, versionID = 7, source = 1010 },      -- 暗影之刃的致命预兆
    [231524] = { itemID = 143491, versionID = 7, source = 1010 },      -- 暗影之刃的怨恨预兆
    [231525] = { itemID = 143490, versionID = 7, source = 1010 },      -- 暗影之刃的猩红预兆
    [231587] = { itemID = 143503, versionID = 7, source = 1010 },      -- 大领主的复仇战马
    [231588] = { itemID = 143504, versionID = 7, source = 1010 },      -- 大领主的警戒战马
    [231589] = { itemID = 143505, versionID = 7, source = 1010 },      -- 大领主的英勇战马
    [232405] = { itemID = 143631, versionID = 105, source = 1011 },      -- 原始火刃豹
    [232412] = { itemID = 0, versionID = 7, source = 1010 },      -- 虚空之王的混沌愤怒战马
    [232519] = { itemID = 143643, versionID = 7, source = 5 },      -- 深渊蠕虫
    [232523] = { itemID = 143648, versionID = 103, source = 1006 },      -- 邪恶战龟
    [232525] = { itemID = 143649, versionID = 103, source = 1006 },      -- 邪恶战龟
    [233364] = { itemID = 143764, versionID = 7, source = 16 },      -- 织魔飞毯
    [235764] = { itemID = 152843, versionID = 7, source = 4 },      -- 暗孢法力鳐
    [237286] = { itemID = 163576, versionID = 8, source = 1012 },      -- 沙丘食腐狼
    [237287] = { itemID = 161773, versionID = 8, source = 2 },      -- 灰白土狼
    [238452] = { itemID = 143637, versionID = 7, source = 1010 },      -- 虚空之王的硫磺愤怒战马
    [238454] = { itemID = 142233, versionID = 7, source = 1010 },      -- 虚空之王的诅咒愤怒战马
    [239013] = { itemID = 152788, versionID = 7, source = 2 },      -- 光铸战争机甲
    [239049] = { itemID = 161215, versionID = 8, source = 1 },      -- 黑曜三叶虫
    [239363] = { itemID = 0, versionID = 0, source = 43 },      -- 迅捷幽灵角鹰兽
    [239766] = { itemID = 151626, versionID = 106, source = 1029 },      -- 蓝色其拉主战坦克
    [239767] = { itemID = 151625, versionID = 106, source = 1029 },      -- 红色其拉主战坦克
    [239770] = { itemID = 0, versionID = 106, source = 1029 },      -- 黑色其拉主战坦克
    [242305] = { itemID = 152791, versionID = 7, source = 2 },      -- 黑色废墟游荡者
    [242874] = { itemID = 147807, versionID = 7, source = 16 }, -- 至高岭大角鹿
    [242875] = { itemID = 147804, versionID = 7, source = 16 }, -- 野生梦境角马
    [242881] = { itemID = 147806, versionID = 7, source = 16 },      -- 云翼角鹰兽
    [242882] = { itemID = 147805, versionID = 7, source = 16 },      -- 瓦拉加尔风暴之翼幼龙
    [242896] = { itemID = 152870, versionID = 103, source = 1006 },      -- 勇猛的战狐
    [242897] = { itemID = 152869, versionID = 103, source = 1006 },      -- 勇猛的战狐
    [243025] = { itemID = 147835, versionID = 7, source = 44 },      -- 谜语人的灵蛇
    [243201] = { itemID = 153493, versionID = 105, source = 42 },      -- 恶魔角斗士的风暴巨龙
    [243512] = { itemID = 147901, versionID = 101, source = 20 },      -- 微光逐星者
    [243651] = { itemID = 152789, versionID = 7, source = 5 },      -- 带镣铐的乌祖尔
    [243652] = { itemID = 152790, versionID = 7, source = 4 },      -- 邪犬
    [243795] = { itemID = 163575, versionID = 8, source = 1012 },      -- 跃泽巨蛛
    [244712] = { itemID = 161664, versionID = 8, source = 2 },      -- 幽灵飞翼龙
    [245723] = { itemID = 151618, versionID = 101, source = 22 },      -- 暴风城逐天战机
    [245725] = { itemID = 151617, versionID = 101, source = 22 },      -- 奥格瑞玛拦截飞艇
    [247402] = { itemID = 151623, versionID = 7, source = 44 },      -- 清醒的梦魇
    [247448] = { itemID = 153485, versionID = 100, source = 51 },      -- 暗月飞船
    [250735] = { itemID = 163216, versionID = 8, source = 1 },      -- 充血抱齿兽
    [253004] = { itemID = 152794, versionID = 7, source = 2 },      -- 紫色废墟游荡者
    [253005] = { itemID = 152795, versionID = 7, source = 2 },      -- 绿色废墟游荡者
    [253006] = { itemID = 152793, versionID = 7, source = 2 },      -- 褐色废墟游荡者
    [253007] = { itemID = 152797, versionID = 7, source = 2 },      -- 蓝色废墟游荡者
    [253008] = { itemID = 152796, versionID = 7, source = 2 },      -- 棕色废墟游荡者
    [253058] = { itemID = 152814, versionID = 7, source = 4 },      -- 疯狂的混沌奔行者
    [253087] = { itemID = 152815, versionID = 7, source = 1 },      -- 安托兰阴暗恶犬
    [253088] = { itemID = 152816, versionID = 7, source = 5 },      -- 安托兰灼焦恶犬
    [253106] = { itemID = 152842, versionID = 7, source = 4 }, -- 活跃法力鳐
    [253107] = { itemID = 152844, versionID = 7, source = 4 }, -- 柔光法力鳐
    [253108] = { itemID = 152841, versionID = 7, source = 4 }, -- 邪光法力鳐
    [253109] = { itemID = 152840, versionID = 7, source = 4 }, -- 荧光法力鳐
    [253639] = { itemID = 152901, versionID = 105, source = 1023 },      -- 紫罗兰魔翼鸦
    [253660] = { itemID = 152903, versionID = 7, source = 4 },      -- 毒牙撕咬者
    [253661] = { itemID = 152905, versionID = 7, source = 4 },      -- 赤红涎喉者
    [253662] = { itemID = 152904, versionID = 7, source = 4 },      -- 酸液喷射者
    [253711] = { itemID = 152912, versionID = 102, source = 34 },      -- 池塘水母
    [254069] = { itemID = 153042, versionID = 7, source = 16 },      -- 荣耀邪能碾压者
    [254258] = { itemID = 153043, versionID = 7, source = 16 },      -- 祝福邪能碾压者
    [254259] = { itemID = 153044, versionID = 7, source = 16 },      -- 复仇邪能碾压者
    [254260] = { itemID = 153041, versionID = 7, source = 1 },      -- 黯蹄废墟游荡者
    [254811] = { itemID = 163586, versionID = 8, source = 1014 },      -- 呱呱鹦鹉
    [254812] = { itemID = 233242, versionID = 106, source = 1015 },      -- 皇家海羽鹦鹉
    [254813] = { itemID = 159842, versionID = 8, source = 3 },      -- 鲨鱼饵
    [255695] = { itemID = 153539, versionID = 101, source = 1007 },      -- 海鬃骏马
    [255696] = { itemID = 153540, versionID = 101, source = 1007 },      -- 奢华暴掠龙
    [256123] = { itemID = 153594, versionID = 102, source = 27 },      -- 斯克维里加全地形载具
    [258022] = { itemID = 155656, versionID = 1, source = 157 },      -- 光铸邪能碾压者
    [258060] = { itemID = 155662, versionID = 1, source = 158 },      -- 至高岭雷蹄驼鹿
    [258845] = { itemID = 156487, versionID = 1, source = 159 },      -- 夜之子魔刃豹
    [259202] = { itemID = 156486, versionID = 1, source = 160 },      -- 星怨虚空陆行鸟
    [259213] = { itemID = 161911, versionID = 8, source = 2 },      -- 海军骏马
    [259395] = { itemID = 156564, versionID = 101, source = 20 },      -- 戌禅，神圣护卫
    [259740] = { itemID = 163183, versionID = 8, source = 6 },      -- 青绿沼泽跃蛙
    [259741] = { itemID = 170069, versionID = 8, source = 10 },      -- 蜜背收割者
    [260172] = { itemID = 161912, versionID = 8, source = 2 },      -- 暗斑灰马
    [260173] = { itemID = 161910, versionID = 8, source = 2 },      -- 雾黑军马
    [260174] = { itemID = 163574, versionID = 8, source = 1012 },      -- 惊怖驮骡
    [260175] = { itemID = 163573, versionID = 8, source = 1012 },      -- 金鬃
    [261395] = { itemID = 156798, versionID = 8, source = 44 },      -- 主脑
    [261433] = { itemID = 163122, versionID = 103, source = 1006},      -- 勇猛的战蜥
    [261434] = { itemID = 163121, versionID = 103, source = 1006},      -- 勇猛的战蜥
    [261437] = { itemID = 161134, versionID = 102, source = 27 },      -- 机甲大亨Mk2型
    [262022] = { itemID = 156879, versionID = 105, source = 42 },      -- 悚然角斗士的始祖幼龙
    [262023] = { itemID = 156880, versionID = 105, source = 42 },      -- 惊恶角斗士的始祖幼龙
    [262024] = { itemID = 156881, versionID = 105, source = 42 },      -- 罪邪角斗士的始祖幼龙
    [262027] = { itemID = 156884, versionID = 105, source = 42 },      -- 腐化角斗士的始祖幼龙
    [263707] = { itemID = 157870, versionID = 1, source = 161 },      -- 赞达拉恐角龙
    [264058] = { itemID = 163042, versionID = 105, source = 41 },      -- 雄壮商队雷龙
    [266058] = { itemID = 159921, versionID = 8, source = 3 }, -- 墓穴猎手
    [266925] = { itemID = 166745, versionID = 8, source = 1014 },      -- 泥翼信天翁
    [267270] = { itemID = 159146, versionID = 8, source = 10 },      -- 库亚冯
    [267274] = { itemID = 161330, versionID = 1, source = 162 },      -- 玛格汉恐狼
    [270560] = { itemID = 163124, versionID = 103, source = 1006 },      -- 勇猛的作战裂蹄牛
    [270562] = { itemID = 0, versionID = 104, source = 102 },      -- 暗炉山羊
    [270564] = { itemID = 0, versionID = 104, source = 102 },      -- 晨炉山羊
    [271646] = { itemID = 161331, versionID = 1, source = 163 },      -- 黑铁熔火犬
    [272472] = { itemID = 163128, versionID = 8, source = 10 },      -- 幽暗城天灾蝙蝠
    [272481] = { itemID = 163123, versionID = 103, source = 1006 },      -- 勇猛的作战淡水兽
    [272770] = { itemID = 160589, versionID = 101, source = 20 },      -- 惊魂号
    [273541] = { itemID = 160829, versionID = 8, source = 3 },      -- 孢林抱齿兽
    [274610] = { itemID = 163127, versionID = 8, source = 10 },      -- 泰达希尔角鹰兽
    [275623] = { itemID = 161479, versionID = 8, source = 4 },      -- 纳沙塔尔鲜血巨蛇
    [275837] = { itemID = 161665, versionID = 8, source = 2 },      -- 钴蓝翼手龙
    [275838] = { itemID = 161666, versionID = 8, source = 2 },      -- 捕获的沼泽追猎者
    [275840] = { itemID = 161667, versionID = 8, source = 2 },      -- 沃顿奈破沙者
    [275841] = { itemID = 161774, versionID = 8, source = 2 },      -- 远征队群居血虱
    [275859] = { itemID = 161908, versionID = 8, source = 2 },      -- 薄暮维克雷斯狮鹫
    [275866] = { itemID = 161909, versionID = 8, source = 2 },      -- 斯托颂眺海狮鹫
    [275868] = { itemID = 161879, versionID = 8, source = 2 },      -- 普罗德摩尔观潮狮鹫
    [278803] = { itemID = 163131, versionID = 102, source = 34 },      -- 无尽之海鳐鱼
    [278966] = { itemID = 163186, versionID = 101, source = 1004 },      -- 炽焰炉石天马
    [278979] = { itemID = 163585, versionID = 8, source = 1014 },      -- 拍浪水母
    [279454] = { itemID = 163577, versionID = 8, source = 1 },      -- 征服者的镰牙之喉
    [279456] = { itemID = 163579, versionID = 8, source = 801 },      -- 高地野马
    [279457] = { itemID = 163578, versionID = 8, source = 801 },      -- 失意高地野马
    [279466] = { itemID = 163584, versionID = 8, source = 1014 },      -- 暮光复仇者
    [279467] = { itemID = 163583, versionID = 8, source = 1014 },      -- 岩角跃渊者
    [279469] = { itemID = 163582, versionID = 8, source = 1014 },      -- 秦薛的永恒魁麟
    [279474] = { itemID = 163589, versionID = 8, source = 6 },      -- 灰皮恐角龙
    [279569] = { itemID = 163644, versionID = 8, source = 801 },      -- 迅捷白化迅猛龙
    [279608] = { itemID = 163646, versionID = 8, source = 801 },      -- 小毛驴
    [279611] = { itemID = 163645, versionID = 8, source = 801 },      -- 啮颅者
    [279868] = { itemID = 163706, versionID = 8, source = 801 },      -- 枯木恐翼蝠
    [280729] = { itemID = 163981, versionID = 8, source = 1 },      -- 狂暴的邪能之爪
    [280730] = { itemID = 163982, versionID = 104, source = 1 },      -- 纯心骏马
    [281044] = { itemID = 164250, versionID = 103, source = 1009 },      -- 声威血铸骏马
    [281554] = { itemID = 164571, versionID = 101, source = 1016 },      -- 清道夫
    [281887] = { itemID = 165019, versionID = 103, source = 1006 },      -- 黑色邪恶作战刃豹
    [281888] = { itemID = 173714, versionID = 103, source = 1006 },      -- 白色邪恶作战刃豹
    [281889] = { itemID = 173713, versionID = 103, source = 1006 },      -- 白色邪恶骨骥
    [281890] = { itemID = 165020, versionID = 103, source = 1006 },      -- 黑色邪恶骨骥
    [282682] = { itemID = 164762, versionID = 1, source = 164 },      -- 库尔提拉斯军马
    [288438] = { itemID = 166438, versionID = 8, source = 802 },      -- 黑掌
    [288495] = { itemID = 166432, versionID = 8, source = 802 },      -- 灰谷奇美拉
    [288499] = { itemID = 166433, versionID = 8, source = 802 },      -- 惊恐的科多兽
    [288503] = { itemID = 166803, versionID = 8, source = 802 },      -- 珀色夜刃豹
    [288505] = { itemID = 166435, versionID = 8, source = 802 },      -- 卡多雷夜刃豹
    [288506] = { itemID = 166436, versionID = 8, source = 6 },      -- 沙色夜刃豹
    [288587] = { itemID = 166442, versionID = 8, source = 6 }, -- 靛蓝沼泽跃蛙
    [288589] = { itemID = 166443, versionID = 8, source = 6 }, -- 土黄沼泽跃蛙
    [288711] = { itemID = 166471, versionID = 8, source = 1014 },      -- 咸水海马
    [288712] = { itemID = 166470, versionID = 8, source = 1014 },      -- 石皮大角鹿
    [288714] = { itemID = 166469, versionID = 8, source = 6 },      -- 嗜血恐翼蝠
    [288720] = { itemID = 166468, versionID = 8, source = 1014 },      -- 充血猎蝠
    [288721] = { itemID = 166467, versionID = 8, source = 1014 },      -- 海岛雷鳞龙
    [288722] = { itemID = 166466, versionID = 8, source = 1014 },      -- 复活的骒马
    [288735] = { itemID = 166464, versionID = 8, source = 6 },      -- 赤壳三叶虫
    [288736] = { itemID = 166465, versionID = 8, source = 6 },      -- 靛壳三叶虫
    [288740] = { itemID = 166463, versionID = 8, source = 6 },      -- 女祭司的月刃豹
    [289083] = { itemID = 166518, versionID = 8, source = 5 }, -- 加氏灭世机甲
    [289101] = { itemID = 166539, versionID = 8, source = 1 }, -- 达萨罗破风龙
    [289555] = { itemID = 166705, versionID = 8, source = 5 },      -- 冰川狂潮
    [289639] = { itemID = 166724, versionID = 105, source = 1005 },      -- 布鲁斯
    [290132] = { itemID = 166776, versionID = 101, source = 20 }, -- 希尔维安神游者
    [290133] = { itemID = 166775, versionID = 101, source = 20 }, -- 狡狐魔使
    [290134] = { itemID = 166774, versionID = 101, source = 20 }, -- 霍格鲁斯，鸿运亥客
    [290328] = { itemID = 169162, versionID = 8, source = 1 },      -- 奇迹之翼2.0版
    [290608] = { itemID = 0, versionID = 104, source = 102 },      -- 十字军恐角龙
    [290718] = { itemID = 168830, versionID = 8, source = 3 },      -- R-21/X型空中单位
    [291492] = { itemID = 168823, versionID = 8, source = 4 },      -- 生锈的机械爬蛛
    [291538] = { itemID = 167170, versionID = 8, source = 2 },      -- 破镣者海波鳐
    [292407] = { itemID = 167167, versionID = 8, source = 2 },      -- 剑鱼人海波鳐
    [292419] = { itemID = 167171, versionID = 8, source = 1 },      -- 艾萨莉膨水鳐
    [294038] = { itemID = 169198, versionID = 8, source = 16 },      -- 皇家毒鳍龙
    [294039] = { itemID = 169194, versionID = 8, source = 1 },      -- 劈背凿孔蟹
    [294143] = { itemID = 167751, versionID = 8, source = 17 },      -- X-995型机械猫
    [294197] = { itemID = 172012, versionID = 106, source = 26 }, -- 黑曜石灭世者
    [294568] = { itemID = 167894, versionID = 100, source = 1002 },      -- 兽王的钢牙雷象
    [294569] = { itemID = 167895, versionID = 100, source = 1002 },      -- 兽王的战狼
    [295386] = { itemID = 168056, versionID = 8, source = 1 },      -- 铁甲霜爪狼
    [295387] = { itemID = 168055, versionID = 8, source = 1 },      -- 血肋战马
    [296788] = { itemID = 168329, versionID = 8, source = 1 },      -- 机轮车W型
    [297157] = { itemID = 168370, versionID = 8, source = 4 },      -- 锈废漂移者
    [297560] = { itemID = 168408, versionID = 8, source = 10 },      -- 托卡利的子嗣
    [298367] = { itemID = 174842, versionID = 8, source = 4 },      -- 茉莉
    [299158] = { itemID = 168826, versionID = 8, source = 3 },      -- 麦卡贡维和者
    [299159] = { itemID = 168827, versionID = 8, source = 10 },      -- 废铁机甲蛛
    [299170] = { itemID = 168829, versionID = 8, source = 2 },      -- 锈栓抵抗者
    [300146] = { itemID = 169199, versionID = 8, source = 10 },      -- 毒鳍龙猎藻者
    [300147] = { itemID = 169200, versionID = 8, source = 10 },      -- 深瑚毒鳍龙
    [300149] = { itemID = 169163, versionID = 8, source = 4 },      -- 喑声翔渊者
    [300150] = { itemID = 169201, versionID = 8, source = 4 },      -- 法比乌斯
    [300151] = { itemID = 169203, versionID = 8, source = 6 },      -- 墨鳞觅暗者
    [300153] = { itemID = 169202, versionID = 8, source = 6 },      -- 赤红浪骁
    [300154] = { itemID = 233243, versionID = 106, source = 1015 },      -- 银白浪骁
    [302143] = { itemID = 174862, versionID = 105, source = 1023 },      -- 纯净的虚空之翼
    [302361] = { itemID = 207964, versionID = 101, source = 20 },      -- 大理石暴风之爪
    [302362] = { itemID = 207963, versionID = 101, source = 20 },      -- 大理石雷霆之翼
    [302794] = { itemID = 0, versionID = 0, source = 43 },      -- 迅捷幽灵深水鳐
    [302795] = { itemID = 0, versionID = 0, source = 43 },      -- 迅捷幽灵磁力飞行器
    [302796] = { itemID = 0, versionID = 0, source = 43 },      -- 迅捷幽灵装甲狮鹫
    [302797] = { itemID = 0, versionID = 0, source = 43 },      -- 迅捷幽灵翼手龙
    [303767] = { itemID = 0, versionID = 11, source = 1 },      -- 蜜背巢母
    [305182] = { itemID = 174654, versionID = 8, source = 1 },      -- 恩佐斯的黑蟒
    [305592] = { itemID = 174067, versionID = 1, source = 165 },      -- 麦卡贡机械陆行鸟
    [306421] = { itemID = 172023, versionID = 106, source = 1028 },      -- 霜狼咆哮者
    [306423] = { itemID = 174066, versionID = 1, source = 166 },      -- 商队土狼
    [307256] = { itemID = 173299, versionID = 105, source = 19 },      -- 探险者的丛林中转机
    [307263] = { itemID = 173297, versionID = 105, source = 19 },      -- 探险者的迷沙骆驼
    [307932] = { itemID = 0, versionID = 101, source = 20 },      -- 咒缚恒龙
    [308078] = { itemID = 0, versionID = 101, source = 20 },      -- 吱吱，狡黠灵兽
    [308087] = { itemID = 0, versionID = 101, source = 20 },      -- 祥韵，天佑金犊
    [308250] = { itemID = 172022, versionID = 106, source = 1028 },      -- 雷矛军用山羊
    [308814] = { itemID = 174872, versionID = 8, source = 5 },      -- 尼奥罗萨全视者
    [312751] = { itemID = 173887, versionID = 8, source = 803 },      -- 亥离之嗣
    [312753] = { itemID = 180581, versionID = 9, source = 904 },      -- 碎愿者加尔贡
    [312754] = { itemID = 180948, versionID = 9, source = 904 },      -- 战斗加尔贡弗雷德尼克
    [312759] = { itemID = 180263, versionID = 9, source = 905 },      -- 梦光符文牡鹿
    [312761] = { itemID = 180721, versionID = 9, source = 905 },      -- 魔化梦光符文牡鹿
    [312762] = { itemID = 184167, versionID = 9, source = 4 },      -- 渊誓猎魂犬
    [312763] = { itemID = 183052, versionID = 9, source = 910 },      -- 暗穴硬壳虫
    [312765] = { itemID = 180773, versionID = 9, source = 4 },      -- 日舞者
    [312767] = { itemID = 180728, versionID = 9, source = 4 },      -- 迅捷厄蹄马
    [312776] = { itemID = 183617, versionID = 9, source = 910 },      -- 啾鸣心蛛
    [312777] = { itemID = 181316, versionID = 9, source = 910 },      -- 银端惊惧之翼
    [315014] = { itemID = 174752, versionID = 8, source = 803 },      -- 皎白云端翔龙
    [315132] = { itemID = 0, versionID = 101, source = 20 },      -- 奔波尔鲲
    [315427] = { itemID = 174649, versionID = 8, source = 803 },      -- 莱加尼战争翔龙
    [315847] = { itemID = 174641, versionID = 8, source = 803 },      -- 四风幼龙
    [315987] = { itemID = 174653, versionID = 8, source = 804 },      -- 邮件吞噬者
    [316275] = { itemID = 174753, versionID = 8, source = 803 },      -- 废土劫掠者
    [316276] = { itemID = 174754, versionID = 8, source = 2 },      -- 废土恐天鹫
    [316337] = { itemID = 174769, versionID = 8, source = 803 },      -- 恶毒工蜂
    [316339] = { itemID = 174771, versionID = 8, source = 10 },      -- 影钩工蜂
    [316340] = { itemID = 174770, versionID = 8, source = 6 },      -- 邪恶群居蜂
    [316343] = { itemID = 174861, versionID = 8, source = 1 },      -- 蠕动的寄生虫
    [316493] = { itemID = 174860, versionID = 8, source = 4 },      -- 轻盈的迅蹄驼
    [316637] = { itemID = 174836, versionID = 105, source = 1017 },      -- 觉醒的钻心之蛇
    [316722] = { itemID = 174841, versionID = 8, source = 803 }, -- 任衙的忠犬
    [316723] = { itemID = 174840, versionID = 8, source = 803 }, -- 馨劳
    [316802] = { itemID = 174859, versionID = 8, source = 10 },      -- 春裘羊驼
    [317177] = { itemID = 0, versionID = 101, source = 20 },      -- 暖日绒猫
    [318051] = { itemID = 180748, versionID = 9, source = 905 },      -- 丝柔烁光蛾
    [326390] = { itemID = 0, versionID = 101, source = 20 },      -- 汽鳞焚化者
    [327405] = { itemID = 182081, versionID = 9, source = 16 },      -- 巨型灭爪鹏
    [327407] = { itemID = 184014, versionID = 103, source = 1006 },      -- 邪恶战蛛
    [327408] = { itemID = 184013, versionID = 103, source = 1006 },      -- 邪恶战蛛
    [332243] = { itemID = 180413, versionID = 9, source = 905 },      -- 影叶符文牡鹿
    [332244] = { itemID = 180414, versionID = 9, source = 905 },      -- 唤醒者的符文牡鹿
    [332245] = { itemID = 180415, versionID = 9, source = 905 },      -- 冬脉符文牡鹿
    [332246] = { itemID = 180722, versionID = 9, source = 905 },      -- 魔化影叶符文牡鹿
    [332247] = { itemID = 180723, versionID = 9, source = 905 },      -- 魔化唤醒者的符文牡鹿
    [332248] = { itemID = 180724, versionID = 9, source = 905 },      -- 魔化冬脉符文牡鹿
    [332252] = { itemID = 180727, versionID = 9, source = 4 },      -- 闪雾奔行者
    [332256] = { itemID = 180729, versionID = 9, source = 2 },      -- 暮舞炽蓝蛾
    [332400] = { itemID = 183937, versionID = 105, source = 42 },      -- 罪孽角斗士的噬魂者
    [332455] = { itemID = 182077, versionID = 9, source = 906 },      -- 战育荒牛
    [332456] = { itemID = 182076, versionID = 9, source = 906 },      -- 凋腐荒牛
    [332457] = { itemID = 182075, versionID = 9, source = 906 },      -- 骨蹄荒牛
    [332460] = { itemID = 182074, versionID = 9, source = 906 },      -- 魂选荒牛
    [332462] = { itemID = 181822, versionID = 9, source = 906 },      -- 重装战育荒牛
    [332464] = { itemID = 181821, versionID = 9, source = 906 },      -- 重装凋腐荒牛
    [332466] = { itemID = 181815, versionID = 9, source = 906 },      -- 重装骨蹄荒牛
    [332467] = { itemID = 181820, versionID = 9, source = 906 },      -- 重装魂选荒牛
    [332478] = { itemID = 182085, versionID = 9, source = 4 },      -- 灼背血牙猪
    [332480] = { itemID = 182084, versionID = 9, source = 4 },      -- 血刺
    [332484] = { itemID = 182082, versionID = 9, source = 2 },      -- 艳丽血牙猪
    [332882] = { itemID = 180461, versionID = 9, source = 904 },      -- 可怖的惊惧之翼
    [332903] = { itemID = 182596, versionID = 9, source = 1 },      -- 城墙尖啸者
    [332904] = { itemID = 185996, versionID = 9, source = 16 },      -- 收割者的惊惧之翼
    [332905] = { itemID = 180582, versionID = 9, source = 4 },      -- 末日迷沼飞虫
    [332923] = { itemID = 182954, versionID = 9, source = 904 },      -- 裁决加尔贡
    [332927] = { itemID = 183715, versionID = 9, source = 904 },      -- 堕罪加尔贡
    [332932] = { itemID = 180945, versionID = 9, source = 904 },      -- 地穴加尔贡
    [332949] = { itemID = 182209, versionID = 9, source = 904 },      -- 欲望之战斗加尔贡
    [333021] = { itemID = 182332, versionID = 9, source = 904 },      -- 墓碑战斗加尔贡
    [333023] = { itemID = 183798, versionID = 9, source = 904 },      -- 战斗加尔贡西勒莎
    [333027] = { itemID = 182589, versionID = 9, source = 4 },      -- 忠诚的饕餮者
    [334352] = { itemID = 180731, versionID = 9, source = 7 },      -- 灵种摇篮
    [334364] = { itemID = 180725, versionID = 9, source = 4 },      -- 锥喉林地咀嚼者
    [334365] = { itemID = 180726, versionID = 9, source = 910 },      -- 灰白酸喉者
    [334366] = { itemID = 180730, versionID = 9, source = 905 },      -- 野生烁裘徘徊者
    [334382] = { itemID = 180761, versionID = 9, source = 907 },      -- 忠诚灵豹
    [334386] = { itemID = 180762, versionID = 9, source = 907 },      -- 谦逊灵豹
    [334391] = { itemID = 180763, versionID = 9, source = 907 },      -- 勇气灵豹
    [334398] = { itemID = 180764, versionID = 9, source = 907 },      -- 纯洁灵豹
    [334403] = { itemID = 180765, versionID = 9, source = 907 },      -- 永恒纯洁灵豹
    [334406] = { itemID = 180766, versionID = 9, source = 907 },      -- 永恒勇气灵豹
    [334408] = { itemID = 180767, versionID = 9, source = 907 },      -- 永恒忠诚灵豹
    [334409] = { itemID = 180768, versionID = 9, source = 907 },      -- 永恒谦逊灵豹
    [334433] = { itemID = 180772, versionID = 9, source = 7 },      -- 银风翼狮
    [334482] = { itemID = 192557, versionID = 105, source = 1017 },      -- 复苏死亡行者
    [336036] = { itemID = 181819, versionID = 9, source = 3 },      -- 髓牙
    [336038] = { itemID = 181818, versionID = 9, source = 1012 },      -- 羽翼未丰的绽翼兽
    [336039] = { itemID = 181300, versionID = 9, source = 910 },      -- 阴森绽翼兽
    [336041] = { itemID = 182078, versionID = 9, source = 906 },      -- 骨缝血肉大鹏
    [336042] = { itemID = 182079, versionID = 9, source = 4 },      -- 巨型死亡大鹏
    [336045] = { itemID = 182080, versionID = 9, source = 906 },      -- 掠食的凋零大鹏
    [336064] = { itemID = 181317, versionID = 9, source = 910 },      -- 无畏的暮行者
    [339588] = { itemID = 182614, versionID = 9, source = 4 },      -- 罪奔者布兰契
    [339632] = { itemID = 182650, versionID = 9, source = 4 },      -- 树栖巨口蟾
    [339956] = { itemID = 186655, versionID = 9, source = 1 },      -- 渊誓军马
    [339957] = { itemID = 186653, versionID = 9, source = 1 },      -- 赫雷斯迪莫拉克之手
    [340068] = { itemID = 182717, versionID = 105, source = 1017 },      -- 罪触死亡行者
    [340503] = { itemID = 183053, versionID = 9, source = 905 },      -- 幽影镰角虫
    [341639] = { itemID = 183518, versionID = 9, source = 2 },      -- 王庭罪奔者
    [341766] = { itemID = 183615, versionID = 9, source = 910 },      -- 战缝黑暗犬
    [341776] = { itemID = 183618, versionID = 9, source = 910 },      -- 高风暗鬃狮
    [341821] = { itemID = 0, versionID = 101, source = 20 },   -- 雪暴
    [342334] = { itemID = 183740, versionID = 9, source = 2 },      -- 鎏金徘徊者
    [342335] = { itemID = 183741, versionID = 9, source = 4 },      -- 晋升天鬃马
    [342666] = { itemID = 183800, versionID = 9, source = 16 },      -- 琥珀炽蓝蛾
    [342667] = { itemID = 183801, versionID = 9, source = 905 },      -- 活力炽蓝蛾
    [342668] = { itemID = 187666, versionID = 9, source = 908 },      -- 砂翼猎鹰
    [342671] = { itemID = 187639, versionID = 9, source = 908 },      -- 灰白皇家元鹿
    [342678] = { itemID = 187660, versionID = 9, source = 908 },      -- 蹁跹元蜂
    [342680] = { itemID = 187676, versionID = 9, source = 4 },      -- 深星元水母
    [343550] = { itemID = 186480, versionID = 9, source = 2 },      -- 饱经战火的北风长
    [344228] = { itemID = 184062, versionID = 9, source = 4 },      -- 战缚军犬
    [344574] = { itemID = 184160, versionID = 9, source = 16 },      -- 浑圆通灵鳐
    [344575] = { itemID = 184162, versionID = 9, source = 16 },      -- 致命通灵鳐
    [344576] = { itemID = 184161, versionID = 9, source = 16 },      -- 群居通灵鳐
    [344577] = { itemID = 184168, versionID = 9, source = 44 },      -- 被缚的影犬
    [344578] = { itemID = 184166, versionID = 9, source = 909 },      -- 回廊潜行猎犬
    [344659] = { itemID = 184183, versionID = 9, source = 1 },      -- 贪食的饕餮者
    [346136] = { itemID = 0, versionID = 101, source = 1018 },      -- 翠绿相位捕猎者
    [346141] = { itemID = 0, versionID = 9, source = 3 },      -- 软泥之蛇
    [346554] = { itemID = 186637, versionID = 9, source = 1 },      -- 塔扎维什齿轮滑翔器
    [346719] = { itemID = 187669, versionID = 9, source = 908 },      -- 小夜曲
    [347250] = { itemID = 186489, versionID = 9, source = 906 },      -- 冥蝇王
    [347251] = { itemID = 186648, versionID = 9, source = 2 },      -- 翔天刀翼兽
    [347255] = { itemID = 0, versionID = 103, source = 1006 },      -- 勇猛的战蟾
    [347256] = { itemID = 0, versionID = 103, source = 1006 },      -- 勇猛的战蟾
    [347536] = { itemID = 186641, versionID = 9, source = 16 },      -- 驯养的重殴者
    [347810] = { itemID = 186644, versionID = 9, source = 16 },      -- 绿柱石碎皮兽
    [347812] = { itemID = 0, versionID = 101, source = 20 },      -- 蓝玉灼天者
    [348162] = { itemID = 0, versionID = 101, source = 20 },      -- 漫游古树
    [348769] = { itemID = 186179, versionID = 103, source = 1006 },      -- 邪恶的战争戈姆
    [348770] = { itemID = 186178, versionID = 103, source = 1006 },      -- 邪恶的战争戈姆
    [349823] = { itemID = 184672, versionID = 103, source = 1006 },      -- 勇猛的战争追猎者
    [349824] = { itemID = 187644, versionID = 103, source = 1006 },      -- 勇猛的战争追猎者
    [349935] = { itemID = 204382, versionID = 10, source = 6 },      -- 高贵的驼牛
    [349943] = { itemID = 192766, versionID = 106, source = 18 },      -- 琥珀掠蜓
    [350219] = { itemID = 192777, versionID = 10, source = 7 },      -- 岩浆之壳
    [351195] = { itemID = 186642, versionID = 9, source = 5 },      -- 复仇
    [351408] = { itemID = 192792, versionID = 10, source = 1 },      -- 拜赐雷背蜥蜴头领
    [352309] = { itemID = 185973, versionID = 9, source = 909 },      -- 芭美兹拉之手
    [352441] = { itemID = 186000, versionID = 9, source = 16 },      -- 荒猎团斩肢者
    [352742] = { itemID = 186103, versionID = 9, source = 16 },      -- 不朽的黑暗犬
    [352926] = { itemID = 192800, versionID = 10, source = 17 },      -- 天皮角行鸟
    [353036] = { itemID = 186177, versionID = 105, source = 42 },      -- 不羁角斗士的噬魂者
    [353263] = { itemID = 186638, versionID = 9, source = 3 },      -- 财团主宰的齿轮滑翔器
    [353856] = { itemID = 186493, versionID = 9, source = 905 },      -- 炽蓝仙野荒蚺
    [353857] = { itemID = 186494, versionID = 9, source = 905 },      -- 金秋荒蚺
    [353858] = { itemID = 186495, versionID = 9, source = 905 },      -- 寒冬荒蚺
    [353859] = { itemID = 186492, versionID = 9, source = 905 },      -- 盛夏荒蚺
    [353866] = { itemID = 186478, versionID = 9, source = 904 },      -- 黑曜墓翼蝠
    [353872] = { itemID = 186476, versionID = 9, source = 904 },      -- 堕罪墓翼蝠
    [353873] = { itemID = 186477, versionID = 9, source = 904 },      -- 苍白的墓翼蝠
    [353875] = { itemID = 186482, versionID = 9, source = 907 },      -- 极乐北风长
    [353877] = { itemID = 186483, versionID = 9, source = 10 },      -- 弃誓北风长
    [353880] = { itemID = 186485, versionID = 9, source = 907 },      -- 晋升者的北风长
    [353883] = { itemID = 186487, versionID = 9, source = 906 },      -- 玛卓克萨斯冥蝇
    [353884] = { itemID = 186488, versionID = 9, source = 906 },      -- 君威冥蝇
    [353885] = { itemID = 186490, versionID = 9, source = 2 },      -- 战场群聚者
    [354351] = { itemID = 186656, versionID = 9, source = 5 },      -- 圣所阴郁军马
    [354352] = { itemID = 186657, versionID = 9, source = 16 },      -- 灵魂羁绊阴郁军马
    [354353] = { itemID = 186659, versionID = 9, source = 4 },      -- 堕落军马
    [354354] = { itemID = 186713, versionID = 9, source = 44 },      -- 耐迦尼赫玛特之手
    [354355] = { itemID = 186654, versionID = 9, source = 1 },      -- 莎莱兰佳之手
    [354356] = { itemID = 186647, versionID = 9, source = 2 },      -- 琥珀碎皮兽
    [354357] = { itemID = 186645, versionID = 9, source = 4 },      -- 猩红碎皮兽
    [354358] = { itemID = 186646, versionID = 9, source = 10 },      -- 暗殴
    [354359] = { itemID = 186649, versionID = 9, source = 16 },      -- 暴躁的刀翼兽
    [354360] = { itemID = 186652, versionID = 9, source = 4 },      -- 榴石刀翼兽
    [354361] = { itemID = 186651, versionID = 9, source = 10 },      -- 黯光刀翼兽
    [354362] = { itemID = 186643, versionID = 9, source = 10 },      -- 游荡者梅莉
    [356488] = { itemID = 0, versionID = 101, source = 1004 },      -- 传说中的萨齐
    [356501] = { itemID = 187183, versionID = 9, source = 4 },      -- 暴怒的重殴者
    [358072] = { itemID = 0, versionID = 101, source = 20 },      -- 魔缚暴风雪
    [358319] = { itemID = 187525, versionID = 105, source = 1017 },      -- 曲魂死亡行者
    [359013] = { itemID = 187595, versionID = 100, source = 1002 },      -- 瓦尔莎拉角鹰兽
    [359229] = { itemID = 187629, versionID = 9, source = 2 },      -- 舒心元袋熊
    [359230] = { itemID = 187630, versionID = 9, source = 908 },      -- 好奇的水晶探嗅者
    [359231] = { itemID = 187631, versionID = 9, source = 908 },      -- 黑化的元袋熊
    [359232] = { itemID = 187632, versionID = 9, source = 908 },      -- 吉饰元袋熊
    [359276] = { itemID = 187640, versionID = 9, source = 2 },      -- 祝圣原型牡鹿
    [359277] = { itemID = 187641, versionID = 9, source = 908 },      -- 断离之扎雷骁骑
    [359278] = { itemID = 187638, versionID = 9, source = 908 },      -- 亡奔者
    [359317] = { itemID = 0, versionID = 101, source = 20 },      -- 纹洛，天河之威
    [359318] = { itemID = 188674, versionID = 100, source = 1002 },      -- 御风法典
    [359364] = { itemID = 187663, versionID = 9, source = 908 },      -- 铜翼元蜂
    [359366] = { itemID = 187665, versionID = 9, source = 908 },      -- 嗡嗡
    [359367] = { itemID = 187664, versionID = 9, source = 908 },      -- 打造的怨恨飞蜂
    [359372] = { itemID = 187667, versionID = 9, source = 908 },      -- 抗渊元鹰
    [359373] = { itemID = 187668, versionID = 9, source = 908 },      -- 俯冲元鹰
    [359376] = { itemID = 187670, versionID = 9, source = 908 },      -- 青铜元螺
    [359377] = { itemID = 187671, versionID = 9, source = 908 },      -- 未成功的迅螺原型
    [359378] = { itemID = 187672, versionID = 9, source = 908 },      -- 猩红元螺
    [359379] = { itemID = 187675, versionID = 9, source = 1 },      -- 闪光元水母
    [359380] = { itemID = 187674, versionID = 106, source = 18 },      -- 邃渊追猎者
    [359381] = { itemID = 187673, versionID = 9, source = 1 },      -- 晦言元水母
    [359401] = { itemID = 187677, versionID = 9, source = 908 },      -- 源生爬蛛
    [359402] = { itemID = 187678, versionID = 9, source = 908 },      -- 匍匐元蛛
    [359403] = { itemID = 187679, versionID = 9, source = 908 },      -- 不可言喻的掠行者
    [359407] = { itemID = 187682, versionID = 105, source = 1017 },      -- 荒折死亡行者
    [359409] = { itemID = 198871, versionID = 10, source = 6 },      -- 伊斯卡拉商人的奥獭
    [359413] = { itemID = 187683, versionID = 9, source = 908 },      -- 金甲元蟾
    [359545] = { itemID = 190771, versionID = 105, source = 1023 },      -- 蟹化的扎雷骁骑
    [359622] = { itemID = 201440, versionID = 10, source = 4 },      -- 被解放的狐龙
    [359843] = { itemID = 0, versionID = 101, source = 1007 },      -- 绿绦织梦者
    [360954] = { itemID = 194705, versionID = 10, source = 10 },      -- 高地幼龙
    [363136] = { itemID = 188696, versionID = 9, source = 909 },      -- 巨型黑檀之爪噬渊鼠
    [363178] = { itemID = 188700, versionID = 9, source = 909 },      -- 巨型影皮噬渊鼠
    [363297] = { itemID = 188736, versionID = 9, source = 1 }, -- 巨型碎魂噬渊鼠
    [363613] = { itemID = 0, versionID = 104, source = 102 },      -- 光铸废墟奔踏者
    [363701] = { itemID = 188808, versionID = 9, source = 10 },      -- 耐心的元蟾
    [363703] = { itemID = 188809, versionID = 9, source = 908 },      -- 跃蟾原型
    [363706] = { itemID = 188810, versionID = 9, source = 908 },      -- 褐红元蟾
    [365559] = { itemID = 189507, versionID = 105, source = 42 },      -- 宇宙角斗士的噬魂者
    [366647] = { itemID = 189978, versionID = 106, source = 18 },      -- 品红云端翔龙
    [366789] = { itemID = 190168, versionID = 106, source = 18 },      -- 硬壳爬蟹
    [366790] = { itemID = 190169, versionID = 106, source = 18 },      -- 呆鸣鹦鹉
    [366791] = { itemID = 190170, versionID = 9, source = 1 },      -- 老基格沃斯先生
    [366962] = { itemID = 190231, versionID = 101, source = 20 },      -- 艾什阿达，晨曦使者
    [367190] = { itemID = 0, versionID = 0, source = 43 },      -- [DND] Test Mount JZB
    [367620] = { itemID = 190539, versionID = 106, source = 18 },      -- 潜瑚海波鳐
    [367673] = { itemID = 190580, versionID = 9, source = 908 },      -- 心契元狼
    [367676] = { itemID = 190581, versionID = 101, source = 20 },      -- 虚空巨噬浮龙
    [367826] = { itemID = 190613, versionID = 106, source = 18 },      -- 野绿战龟
    [367875] = { itemID = 190636, versionID = 101, source = 20 },      -- 重装攻城科多兽
    [368105] = { itemID = 190765, versionID = 9, source = 4 },      -- 巨型降祸噬渊鼠
    [368126] = { itemID = 190767, versionID = 106, source = 18 },      -- 重装金色翼手龙
    [368128] = { itemID = 190766, versionID = 9, source = 7 },      -- 巨型怨缚噬渊鼠
    [368158] = { itemID = 190768, versionID = 9, source = 5 },      -- 扎雷监察者
    [368893] = { itemID = 204361, versionID = 10, source = 10 },      -- 盘曲蜿变幼龙
    [368896] = { itemID = 194034, versionID = 10, source = 10 },      -- 复苏始祖幼龙
    [368899] = { itemID = 194549, versionID = 10, source = 10 },      -- 载风迅疾幼龙
    [368901] = { itemID = 194521, versionID = 10, source = 10 },      -- 崖际荒狂幼龙
    [369451] = { itemID = 0, versionID = 101, source = 20 },   -- 玉儿，皓月先知
    [369476] = { itemID = 191114, versionID = 101, source = 1019 },      -- 愤怒阿玛甘
    [369480] = { itemID = 0, versionID = 106, source = 18 },      -- 天蓝沼泽跃蛙
    [369666] = { itemID = 191123, versionID = 1, source = 163 },      -- 恐吼
    [370346] = { itemID = 191290, versionID = 105, source = 42 },      -- 永恒角斗士的噬魂者
    [370620] = { itemID = 191566, versionID = 1, source = 167 },      -- 珍稀的翡翠陆行鸟
    [370770] = { itemID = 0, versionID = 101, source = 1018 },      -- 海象人踏浪风筝
    [371176] = { itemID = 191838, versionID = 10, source = 6 },      -- 地底岩浆猛犸
    [372995] = { itemID = 0, versionID = 0, source = 43 },      -- 迅捷幽灵幼龙
    [373859] = { itemID = 192601, versionID = 10, source = 6 },      -- 忠诚的岩浆猛犸
    [373967] = { itemID = 192751, versionID = 10, source = 1 },      -- 雷触驼牛
    [374032] = { itemID = 192761, versionID = 10, source = 2 }, -- 驯服的掠蜓
    [374034] = { itemID = 192762, versionID = 10, source = 2 }, -- 碧蓝掠蜓
    [374048] = { itemID = 192764, versionID = 10, source = 2 }, -- 翠绿掠蜓
    [374071] = { itemID = 192765, versionID = 10, source = 1 },      -- 拜赐扬沙蜓
    [374090] = { itemID = 192772, versionID = 10, source = 4 },      -- 远古蝾螈
    [374097] = { itemID = 192774, versionID = 10, source = 1 },      -- 珊鳞蝾螈
    [374098] = { itemID = 192775, versionID = 10, source = 6 },      -- 雷革蝾螈
    [374138] = { itemID = 192779, versionID = 10, source = 7 },      -- 沸涌蛞蝓
    [374155] = { itemID = 192784, versionID = 10, source = 1 },      -- 谢拉克
    [374157] = { itemID = 192785, versionID = 10, source = 17 },      -- 黏黏的蜗牛元素
    [374162] = { itemID = 192786, versionID = 10, source = 44 },      -- 好斗的界螺
    [374172] = { itemID = 192788, versionID = 10, source = 1 },      -- 拜赐拖网猛犸象
    [374194] = { itemID = 192790, versionID = 10, source = 17 },      -- 青苔猛犸象
    [374196] = { itemID = 192791, versionID = 10, source = 7 },      -- 平原行者运载兽
    [374204] = { itemID = 192796, versionID = 10, source = 2 },      -- 探险者的石皮驮兽
    [374247] = { itemID = 192799, versionID = 10, source = 10 },      -- 莉姬，雷背践踏者
    [374275] = { itemID = 192806, versionID = 10, source = 1 },      -- 狂怒的岩浆猛犸
    [374278] = { itemID = 192807, versionID = 10, source = 4 },      -- 复苏岩浆猛犸
    [376873] = { itemID = 198870, versionID = 10, source = 10 },      -- 奥图
    [376875] = { itemID = 198872, versionID = 10, source = 2 },      -- 棕色侦查奥獭
    [376879] = { itemID = 198873, versionID = 10, source = 10 },      -- 象牙商人的奥獭
    [376880] = { itemID = 200118, versionID = 10, source = 2 },      -- 黄色侦查奥獭
    [376898] = { itemID = 211862, versionID = 10, source = 1 },      -- 拜赐奥獭先锋
    [376910] = { itemID = 201426, versionID = 10, source = 2 },      -- 棕色战争奥獭
    [376912] = { itemID = 198654, versionID = 104, source = 1024 },      -- 热忱的载人奥獭
    [376913] = { itemID = 201425, versionID = 10, source = 2 },      -- 黄色战争奥獭
    [377071] = { itemID = 202086, versionID = 105, source = 42 },      -- 猩红角斗士的幼龙
    [381529] = { itemID = 0, versionID = 101, source = 20 },      -- 雷角兜虫泰利克斯
    [384963] = { itemID = 198808, versionID = 1, source = 168 },      -- 护卫龙麒
    [385115] = { itemID = 198811, versionID = 1, source = 168 },      -- 威严的重装龙麒
    [385131] = { itemID = 198809, versionID = 1, source = 168 },      -- 重装龙麒踏魔者
    [385134] = { itemID = 198810, versionID = 1, source = 168 },      -- 迅捷的重装龙麒
    [385260] = { itemID = 198822, versionID = 10, source = 1 },      -- 拜赐欧胡纳侦察者
    [385262] = { itemID = 198824, versionID = 10, source = 6 },      -- 暗翼欧胡纳
    [385266] = { itemID = 198825, versionID = 10, source = 4 },      -- 泽尼特幼隼
    [385738] = { itemID = 201454, versionID = 10, source = 10 },      -- 喜怒无常的天爪狐龙
    [386452] = { itemID = 0, versionID = 101, source = 10 },      -- 霜巢始祖魔龙
    [387231] = { itemID = 199412, versionID = 105, source = 1017 },      -- 雹风厚甲龙
    [394216] = { itemID = 201702, versionID = 1, source = 168 },      -- 猩红龙麒
    [394218] = { itemID = 201704, versionID = 1, source = 168 },      -- 蓝玉龙麒
    [394219] = { itemID = 201720, versionID = 1, source = 168 },      -- 青铜龙麒
    [394220] = { itemID = 201719, versionID = 1, source = 168 },      -- 黑曜龙麒
    [394737] = { itemID = 201789, versionID = 103, source = 1006 },      -- 勇猛的剑齿兽
    [394738] = { itemID = 201788, versionID = 103, source = 1006 },      -- 勇猛的剑齿兽
    [395095] = { itemID = 0, versionID = 0, source = 43 },      -- 雏龙
    [395644] = { itemID = 0, versionID = 10, source = 10 },      -- 欧恩哈拉的神圣之吻
    [397406] = { itemID = 206167, versionID = 101, source = 20 },      -- 神谜掠波者
    [400733] = { itemID = 204091, versionID = 105, source = 19 },      -- 火箭伐木机9001型
    [400976] = { itemID = 203727, versionID = 101, source = 20 },      -- 闪光的月兽
    [405623] = { itemID = 0, versionID = 0, source = 1026 },      -- 犰狳滚轮车
    [406637] = { itemID = 204798, versionID = 105, source = 1017 },      -- 地狱火厚甲龙
    [407555] = { itemID = 206162, versionID = 104, source = 10 },      -- 泰蕾苟萨的幻影
    [408313] = { itemID = 205155, versionID = 10, source = 10 }, -- 城里的大滑
    [408627] = { itemID = 205197, versionID = 10, source = 6 },      -- 火成岩翼蝠
    [408647] = { itemID = 205203, versionID = 10, source = 4 },      -- 钴蓝岩翼蝠
    [408648] = { itemID = 0, versionID = 10, source = 1 },      -- 升温岩翼蝠
    [408649] = { itemID = 205205, versionID =10, source = 1 },      -- 暗影烈焰岩翼蝠
    [408651] = { itemID = 205204, versionID = 10, source = 7 },      -- 编目岩翼蝠
    [408653] = { itemID = 205209, versionID = 10, source = 2 },      -- 石块搬运蝠
    [408654] = { itemID = 205208, versionID = 100, source = 1002 },      -- 流沙岩翼蝠
    [408655] = { itemID = 205207, versionID = 10, source = 2 },      -- 小食嗅探者
    [408977] = { itemID = 205233, versionID = 105, source = 42 },      -- 黑曜角斗士的蜿变幼龙
    [409032] = { itemID = 205245, versionID = 103, source = 1006 },      -- 勇猛的作战蜗牛
    [409034] = { itemID = 205246, versionID = 103, source = 1006 },      -- 勇猛的作战蜗牛
    [411565] = { itemID = 206027, versionID = 106, source = 18 },      -- 邪晶战蝎
    [412088] = { itemID = 206156, versionID = 10, source = 10 },      -- 岩洞灵翼幼龙
    [413409] = { itemID = 194705, versionID = 0, source = 43 },      -- 高地幼龙
    [413825] = { itemID = 206566, versionID = 8, source = 10 },      -- 猩红翼手龙
    [413827] = { itemID = 206567, versionID = 8, source = 10 },      -- 海港狮鹫
    [413922] = { itemID = 206585, versionID = 10, source = 44 },      -- 英勇
    [414316] = { itemID = 206673, versionID = 10, source = 1021 },      -- 雪白战狼
    [414323] = { itemID = 206674, versionID = 10, source = 1021 },      -- 贪婪的黑色狮鹫
    [414324] = { itemID = 206675, versionID = 10, source = 1021 },      -- 金趾信天翁
    [414326] = { itemID = 206676, versionID = 10, source = 1021 },      -- 邪能风暴巨龙
    [414327] = { itemID = 206678, versionID = 10, source = 1021 },      -- 硫磺恶犬
    [414328] = { itemID = 206679, versionID = 10, source = 1021 },      -- 完美战蝎
    [414334] = { itemID = 206680, versionID = 10, source = 1021 },      -- 灾缚征服者
    [414986] = { itemID = 206976, versionID = 106, source = 18 }, -- 皇家群聚者
    [417245] = { itemID = 207821, versionID = 106, source = 18 },      -- 先祖裂蹄牛
    [417548] = { itemID = 194034, versionID = 0, source = 43 },      -- 复苏始祖幼龙
    [417552] = { itemID = 194549, versionID = 0, source = 43 },     -- 载风迅疾幼龙
    [417554] = { itemID = 194521, versionID = 0, source = 43 },     -- 崖际荒狂幼龙
    [417556] = { itemID = 204361, versionID = 0, source = 43 },     -- 盘曲蜿变幼龙
    [417888] = { itemID = 0, versionID = 101, source = 1007 },      -- 阿加驭雷者
    [418078] = { itemID = 208152, versionID = 10, source = 44 },      -- 帕蒂
    [418286] = { itemID = 0, versionID = 101, source = 20 },      -- 福星木蛟
    [419002] = { itemID = 0, versionID = 0, source = 1026 },      -- 雏龙
    [419345] = { itemID = 208598, versionID = 106, source = 18 },      -- 伊芙的森怖骑行扫帚
    [419567] = { itemID = 0, versionID = 101, source = 20 },      -- 鲲波尔奔
    [420097] = { itemID = 208572, versionID = 106, source = 26 }, -- 碧蓝凝世者
    [422486] = { itemID = 209060, versionID = 105, source = 1017 },      -- 苍郁厚甲龙
    [423871] = { itemID = 209947, versionID = 10, source = 1022 },      -- 繁花梦麋
    [423873] = { itemID = 209949, versionID = 10, source = 1022 },      -- 日灼梦麋
    [423877] = { itemID = 209950, versionID = 10, source = 1022 },      -- 复燃梦麋
    [423891] = { itemID = 209951, versionID = 10, source = 1022 },      -- 月华梦麋
    [424009] = { itemID = 210008, versionID = 101, source = 20 },      -- 符契炎魔
    [424082] = { itemID = 210022, versionID = 10, source = 44 },      -- 米米尔隆的垂直起降喷气机
    [424474] = { itemID = 210060, versionID = 10, source = 1 },      -- 夕影梦刃豹
    [424476] = { itemID = 210059, versionID = 10, source = 1022 },      -- 冬夜梦刃豹
    [424479] = { itemID = 210058, versionID = 10, source = 1022 },      -- 薄暮梦刃豹
    [424482] = { itemID = 210057, versionID = 10, source = 1022 },      -- 翠晨梦刃豹
    [424484] = { itemID = 210061, versionID = 10, source = 5 },      -- 阿努雷洛丝，烈焰启迪
    [424534] = { itemID = 210070, versionID = 103, source = 1006 },      -- 勇猛的月兽
    [424535] = { itemID = 210069, versionID = 103, source = 1006 },      -- 勇猛的月兽
    [424539] = { itemID = 210074, versionID = 105, source = 42 },      -- 腾龙角斗士的幼龙
    [424607] = { itemID = 210142, versionID = 10, source = 1 },      -- 泰瓦恩
    [425338] = { itemID = 210412, versionID = 10, source = 10 },      -- 繁盛奇想幼龙
    [425416] = { itemID = 210345, versionID = 105, source = 42 },      -- 苍郁角斗士的蜿变幼龙
    [426955] = { itemID = 210769, versionID = 10, source = 1022 },      -- 春潮梦爪獍
    [427041] = { itemID = 210774, versionID = 10, source = 10 },      -- 赭色梦爪獍
    [427043] = { itemID = 210775, versionID = 10, source = 1022 },      -- 雪绒梦爪獍
    [427222] = { itemID = 210831, versionID = 10, source = 1022 },      -- 幻濑
    [427224] = { itemID = 210833, versionID = 10, source = 1022 },      -- 豺爪
    [427226] = { itemID = 210945, versionID = 10, source = 1022 },      -- 星辰啃食者
    [427435] = { itemID = 210919, versionID = 106, source = 18 },      -- 猩红烁裘狐
    [427546] = { itemID = 210946, versionID = 10, source = 1022 },      -- 犸秘斯
    [427549] = { itemID = 210948, versionID = 10, source = 1022 },      -- 憧憬之翼
    [427724] = { itemID = 210969, versionID = 10, source = 1022 },      -- 恍螈
    [427777] = { itemID = 210973, versionID = 100, source = 50 }, -- 觅心法力鳐
    [428005] = { itemID = 211074, versionID = 106, source = 18 },      -- 珠光铜色圣甲虫
    [428013] = { itemID = 229348, versionID = 106, source = 26 },      -- 氮素魔影，无法解密的邪能摩托
    [428060] = { itemID = 211084, versionID = 105, source = 41 },      -- 金色皇家圣甲虫
    [428067] = { itemID = 211087, versionID = 101, source = 1030 },      -- 仇铸炽火摩托
    [430225] = { itemID = 211873, versionID = 10, source = 10 },      -- 吉尔尼斯徘徊者
    [431049] = { itemID = 206156, versionID = 0, source = 43 },      -- 岩洞灵翼幼龙
    [431050] = { itemID = 210412, versionID = 0, source = 43 },      -- 繁盛奇想幼龙
    [431357] = { itemID = 212227, versionID = 106, source = 18 }, -- 裘谊之狐
    [431359] = { itemID = 212228, versionID = 101, source = 20 }, -- 翔天之狐
    [431360] = { itemID = 212229, versionID = 106, source = 18 }, -- 暮光巡天狐
    [431992] = { itemID = 212522, versionID = 101, source = 1004 },      -- 罗盘玫瑰
    [432455] = { itemID = 212599, versionID = 100, source = 52 },      -- 复活节飞毯
    [432558] = { itemID = 212630, versionID = 106, source = 18 },      -- 威严碧蓝雌孔雀
    [432562] = { itemID = 212631, versionID = 106, source = 18 },      -- 夺目日冕雌孔雀
    [432610] = { itemID = 212645, versionID = 10, source = 4 },      -- 泥鳞角行鸟
    [433281] = { itemID = 212920, versionID = 106, source = 18 },      -- 野蓝战龟
    [434462] = { itemID = 213438, versionID = 105, source = 1017 },      -- 永恒厚甲龙
    [434470] = { itemID = 213439, versionID = 103, source = 1006 },      -- 勇猛的梦爪獍
    [434477] = { itemID = 213440, versionID = 103, source = 1006 },      -- 勇猛的梦爪獍
    [435044] = { itemID = 213576, versionID = 105, source = 1001 },      -- 金色铁饼
    [435082] = { itemID = 213584, versionID = 105, source = 1001 },      -- 魔古拓雾者
    [435084] = { itemID = 213582, versionID = 105, source = 1001 },      -- 苍穹冲浪者
    [435103] = { itemID = 213598, versionID = 105, source = 1001 },      -- 迅奔追风
    [435107] = { itemID = 213597, versionID = 105, source = 1001 },      -- 森绿追风
    [435108] = { itemID = 213596, versionID = 105, source = 1001 },      -- 昼雷追风
    [435109] = { itemID = 213595, versionID = 105, source = 1001},      -- 覆羽携风者
    [435115] = { itemID = 213601, versionID = 105, source = 1001},      -- 护卫魁麟
    [435118] = { itemID = 213600, versionID = 105, source = 1001},      -- 大理石魁麟
    [435123] = { itemID = 213602, versionID = 105, source = 1001},      -- 鎏金骑乘仙鹤
    [435124] = { itemID = 213607, versionID = 105, source = 1001},      -- 奢华骑乘仙鹤
    [435125] = { itemID = 213604, versionID = 105, source = 1001},      -- 热带骑乘仙鹤
    [435126] = { itemID = 213606, versionID = 105, source = 1001},      -- 银色骑乘仙鹤
    [435127] = { itemID = 213605, versionID = 105, source = 1001},      -- 粉玫骑乘仙鹤
    [435128] = { itemID = 213603, versionID = 105, source = 1001},      -- 暗灰骑乘仙鹤
    [435131] = { itemID = 213608, versionID = 105, source = 1001},      -- 雪色骑乘山羊
    [435133] = { itemID = 213609, versionID = 105, source = 1001},      -- 幼年赤红骑乘山羊
    [435145] = { itemID = 213623, versionID = 105, source = 1001},      -- 殷红啸天龙
    [435146] = { itemID = 213622, versionID = 105, source = 1001},      -- 幽夜飞翼龙
    [435147] = { itemID = 213621, versionID = 105, source = 1001},      -- 翡翠翼手龙
    [435149] = { itemID = 213624, versionID = 105, source = 1001},      -- 钴蓝战蝎
    [435150] = { itemID = 213625, versionID = 105, source = 1001},      -- 魔铁战蝎
    [435153] = { itemID = 213626, versionID = 105, source = 1001},      -- 紫色影踪派骑乘虎
    [435160] = { itemID = 213628, versionID = 105, source = 1001},      -- 踏江穆山兽
    [435161] = { itemID = 213627, versionID = 105, source = 1001},      -- 苍皮穆山兽
    [437162] = { itemID = 233240, versionID = 106, source = 1015 },      -- 波利·罗杰
    [439138] = { itemID = 217340, versionID = 10, source = 1 },      -- 浪游荒蚺
    [440444] = { itemID = 217612, versionID = 9, source = 1 },      -- 佐瓦尔的噬魂者
    [441313] = { itemID = 0, versionID = 0, source = 43 },      -- 翱翔
    [441324] = { itemID = 217985, versionID = 105, source = 1023 },      -- 旧忆金色狮鹫
    [441325] = { itemID = 217987, versionID = 105, source = 1023 },      -- 旧忆双足飞龙
    [441794] = { itemID = 218111, versionID = 105, source = 1001 },      -- 琥珀翼手龙
    [442358] = { itemID = 221765, versionID = 11, source = 3 },      -- 矶石宝库机甲
    [443660] = { itemID = 219450, versionID = 101, source = 20 }, -- 魅力信使
    [446017] = { itemID = 220766, versionID = 105, source = 1001 },      -- 至尊凤凰
    [446022] = { itemID = 220768, versionID = 105, source = 1001 },      -- 星光帝王翔龙
    [446052] = { itemID = 219391, versionID = 11, source = 10 },      -- 地下堡行者的飞船
    [446352] = { itemID = 221270, versionID = 0, source = 1026 },      -- [PH] Goblin Surfboard - Blue
    [447057] = { itemID = 221753, versionID = 11, source = 2 },      -- 焖燃燧烬蜂
    [447151] = { itemID = 223153, versionID = 11, source = 6 },      -- 翔天蜜酒之蜂
    [447160] = { itemID = 223158, versionID = 11, source = 1 },      -- 暴怒的燧烬蜂
    [447176] = { itemID = 222989, versionID = 11, source = 2 },      -- 天蓝萤光螨
    [447185] = { itemID = 223264, versionID = 11, source = 2 },      -- 青绿石群聚虫
    [447190] = { itemID = 223266, versionID = 11, source = 1 },      -- 影遁群聚虫
    [447195] = { itemID = 223267, versionID = 11, source = 1 },      -- 群聚虫猎天者
    [447213] = { itemID = 223270, versionID = 11, source = 4 }, -- 阿鲁尼拉
    [447405] = { itemID = 221813, versionID = 103, source = 1006 },      -- 勇猛的剥天者
    [447413] = { itemID = 221814, versionID = 106, source = 18 },      -- 珠辉地精斩浪者
    [447957] = { itemID = 223274, versionID = 11, source = 2 },      -- 凶猛的利颚爬行者
    [448186] = { itemID = 221967, versionID = 102, source = 27 },      -- 群体打击者2-30
    [448188] = { itemID = 223269, versionID = 11, source = 1012 },      -- 主机防御单位1-11
    [448680] = { itemID = 223276, versionID = 11, source = 2 },      -- 寡妇的幽暗爬行者
    [448685] = { itemID = 223278, versionID = 11, source = 2 },      -- 传承幽暗爬行者
    [448689] = { itemID = 223279, versionID = 11, source = 2 },      -- 王庭幽暗爬行者
    [448845] = { itemID = 223282, versionID = 0, source = 1026 },      -- [PH] Blue Old God Fish Mount
    [448849] = { itemID = 223284, versionID = 0, source = 1026 },      -- 幽光海滩追猎者
    [448850] = { itemID = 223286, versionID = 102, source = 34 },      -- 卡赫，深渊传奇
    [448851] = { itemID = 223285, versionID = 106, source = 18 },      -- 幽光腐化巨兽
    [448934] = { itemID = 0, versionID = 11, source = 1 },      -- 疑之影
    [448939] = { itemID = 223314, versionID = 11, source = 2 },      -- 被缚暗影
    [448941] = { itemID = 223315, versionID = 11, source = 4 },      -- 贝雷达尔之裔
    [448978] = { itemID = 223317, versionID = 11, source = 2 },      -- 朱红帝国山猫
    [448979] = { itemID = 223318, versionID = 11, source = 1012 },      -- 果敢帝国山猫
    [449126] = { itemID = 223449, versionID = 106, source = 18 },      -- 库卡隆战刃豹
    [449132] = { itemID = 223459, versionID = 0, source = 10 },      -- 黑石战刃豹
    [449133] = { itemID = 223460, versionID = 0, source = 1026 },      -- [PH] Nightsaber Horde Mount White
    [449140] = { itemID = 223469, versionID = 106, source = 18 },      -- 哨兵战狼
    [449141] = { itemID = 223470, versionID = 0, source = 1026 },      -- [PH] Alliance Wolf Mount
    [449142] = { itemID = 223471, versionID = 0, source = 10 },      -- 卡多雷战狼
    [449258] = { itemID = 223501, versionID = 11, source = 4 },      -- 老鼹鼠鲁夫斯
    [449264] = { itemID = 225548, versionID = 11, source = 3 }, -- 烛芯
    [449269] = { itemID = 223505, versionID = 11, source = 2 }, -- 赤红泥鼻鼹
    [449325] = { itemID = 223511, versionID = 103, source = 1006 },      -- 勇猛的剥天者
    [449415] = { itemID = 223572, versionID = 1, source = 169 },      -- 板岩磐羊
    [449418] = { itemID = 223571, versionID = 11, source = 2 },      -- 页岩磐羊
    [449466] = { itemID = 223586, versionID = 105, source = 42 },      -- 炉铸角斗士的魔蝠
    [451486] = { itemID = 224147, versionID = 11, source = 5 },      -- 苏雷吉剃天者
    [451489] = { itemID = 224150, versionID = 11, source = 4 },      -- 赛斯巴格
    [451491] = { itemID = 224151, versionID = 11, source = 5 },      -- 扬升剃天者
    [452643] = { itemID = 224398, versionID = 100, source = 1002 },      -- 乱羽角鹰兽
    [452645] = { itemID = 224399, versionID = 100, source = 1002 },      -- 阿曼尼猎熊
    [452779] = { itemID = 224415, versionID = 11, source = 1 },      -- 象牙巨蜢
    [453255] = { itemID = 224574, versionID = 0, source = 43 },      -- 野乌战龟
    [453785] = { itemID = 0, versionID = 104, source = 102 },      -- 土灵宣令者的磐羊
    [454682] = { itemID = 225250, versionID = 101, source = 20 },      -- 星触绒猫
    [457485] = { itemID = 0, versionID = 101, source = 20 },      -- 灰熊丘陵魁熊
    [457650] = { itemID = 226040, versionID = 106, source = 18 },      -- 霸业枭雄的黄金鳄鱼
    [457654] = { itemID = 226041, versionID = 106, source = 18 },      -- 桶腿的光耀鳄鱼
    [457656] = { itemID = 226042, versionID = 106, source = 1015 },      -- 霸业枭雄的午夜鳄鱼
    [457659] = { itemID = 226044, versionID = 0, source = 1026 },      -- 霸业枭雄的风霜鳄鱼
    [458335] = { itemID = 226357, versionID = 105, source = 1017 },      -- 钻石机甲
    [459193] = { itemID = 226506, versionID = 106, source = 18 },      -- 雷什基加尔之手
    [459784] = { itemID = 227362, versionID = 101, source = 20 },      -- 金色炽焰凤凰
    [463025] = { itemID = 228751, versionID = 101, source = 20 },      -- 奔波尔鲛
    [463133] = { itemID = 228760, versionID = 106, source = 26 },      -- 冷焰风暴
    [464443] = { itemID = 229128, versionID = 101, source = 20 },      -- 迎福巨熊
    [465235] = { itemID = 229418, versionID = 101, source = 20 },      -- 鎏金雷龙
    [466811] = { itemID = 230184, versionID = 101, source = 20 },      -- 混沌熔铸狮鹫
    [466812] = { itemID = 230185, versionID = 101, source = 20 },      -- 混沌熔铸角鹰兽
    [466838] = { itemID = 230200, versionID = 101, source = 20 },      -- 混沌熔铸恐翼蝙蝠
    [466845] = { itemID = 230201, versionID = 101, source = 20 },      -- 混沌熔铸驭风者
    [468353] = { itemID = 231374, versionID = 100, source = 1002 },      -- 魔化法纹飞毯
    [471538] = { itemID = 232624, versionID = 100, source = 1002 },      -- 时空鸣蜂
    [471562] = { itemID = 232639, versionID = 11, source = 17 },      -- 萨伊尔，海妖之目
    [471696] = { itemID = 233241, versionID = 106, source = 1015 },      -- 铁钩爪
    [472253] = { itemID = 232901, versionID = 100, source = 54 },      -- 奔月发射器
    [472479] = { itemID = 232926, versionID = 100, source = 50 },      -- 爱情女巫的扫帚
    [472487] = { itemID = 233023, versionID = 106, source = 18 },      -- 银月城扫帚
    [472488] = { itemID = 233020, versionID = 101, source = 20 },      -- 暮光女巫的扫帚
    [472489] = { itemID = 233019, versionID = 101, source = 20 },      -- 苍穹女巫的扫帚
    [472752] = { itemID = 232991, versionID = 11, source = 1 },      -- 毁灭者之歌号
    [473137] = { itemID = 233058, versionID = 11, source = 6 },      -- 索伊兹的复古斩浪者
    [473472] = { itemID = 235515, versionID = 8, source = 1 },      -- 加尼的垃圾堆
    [473861] = { itemID = 233354, versionID = 106, source = 18 },      -- 野棕战龟
    [474086] = { itemID = 233489, versionID = 11, source = 10 },      -- 棱彩毒鳍龙
    [1214920] = { itemID = 234716, versionID = 100, source = 1002 },     -- 夜幕碎天兽
    [1214940] = { itemID = 234721, versionID = 100, source = 1002 },     -- 乌祖尔裂肉者
    [1214946] = { itemID = 234730, versionID = 100, source = 1002 },     -- 希奈丝特拉幼龙
    [1214974] = { itemID = 234740, versionID = 100, source = 1002 },     -- 铜色鬃毛魁麟
    [1216542] = { itemID = 235344, versionID = 101, source = 20 },     -- 炽燃皇家火鹰
    [468205] = { itemID=0, versionID=101, source=20 }, -- 木雕翔天巨蛇


    [465999] = { itemID=229935, versionID=11, source=6 }, -- 猩红装甲惊哮犬
    [466000] = { itemID=0, versionID=11, source=6 }, -- 暗索嚼压者
    [466001] = { itemID=0, versionID=11, source=1012 }, -- 黑水碾骨者
    [466002] = { itemID=229936, versionID=11, source=6 }, -- 紫罗兰装甲惊哮犬
    [466013] = { itemID=229946, versionID=11, source=6 }, -- 黄褐运载火箭
    [466014] = { itemID=0, versionID=11, source=1012 }, -- 热砂补给机
    [466016] = { itemID=229944, versionID=11, source=6 }, -- 紧身特快
    [466017] = { itemID=229941, versionID=11, source=6 }, -- 创新调查者
    [466018] = { itemID=229950, versionID=11, source=6 }, -- 暗索歼灭者
    [466019] = { itemID=229948, versionID=11, source=6 }, -- 黑水伐木机尊享版MK2型
    [466020] = { itemID=229949, versionID=11, source=6 }, -- 私人订制地精S.C.R.A.P拆废机
    [466022] = { itemID=0, versionID=11, source=1012 }, -- 风险投资协调器
    [466023] = { itemID=229952, versionID=11, source=6 }, -- 资产倡导者
    [466024] = { itemID=0, versionID=11, source=1012 }, -- 锈水轰炸机
    [466025] = { itemID=229954, versionID=11, source=6 }, -- 差额操纵者
    [466026] = { itemID=229953, versionID=11, source=4 }, -- 回收的地精亿万富豪飞行器
    [466027] = { itemID=229955, versionID=11, source=4 }, -- 暗索谍眼飞行器
    [466028] = { itemID=229956, versionID=11, source=6 }, -- 钞绿色飞行器
    [466133] = { itemID=229974, versionID=11, source=10 }, -- 地下堡行者的地精疾行器
    [466145] = { itemID=0, versionID=103, source=1006 }, -- 勇猛的电鳗
    [466146] = { itemID=0, versionID=103, source=1006 }, -- 勇猛的电鳗
    [466423] = { itemID=0, versionID=0, source=43 }, -- 不稳定的火箭
    [466464] = { itemID=0, versionID=0, source=43 }, -- 不稳定的火箭
    [473188] = { itemID=233064, versionID=11, source=10 }, -- 青铜地精斩浪者
    [473739] = { itemID=0, versionID=101, source=20 }, -- 绒毛米克西
    [473741] = { itemID=0, versionID=101, source=20 }, -- 柔爪米克西
    [473743] = { itemID=0, versionID=101, source=20 }, -- 滚爪米克西
    [473744] = { itemID=0, versionID=101, source=20 }, -- 茶毛米克西
    [473745] = { itemID=0, versionID=101, source=20 }, -- 酿盗米克西
    [1216422] = { itemID=235286, versionID=101, source=1018 }, -- 附煞云端翔龙
    [1216430] = { itemID=235287, versionID=101, source=1018 }, -- 附煞骑乘虎
    [1217235] = { itemID=0, versionID=0, source=43 }, -- 赤红切割坦克
    [1217340] = { itemID=235554, versionID=106, source=18 }, -- 午夜暗月军马
    [1217341] = { itemID=235555, versionID=106, source=18 }, -- 活跃暗月军马
    [1217342] = { itemID=235556, versionID=106, source=18 }, -- 紫罗兰暗月军马
    [1217343] = { itemID=235557, versionID=106, source=18 }, -- 雪白暗月军马
    [1217760] = { itemID=235626, versionID=11, source=5 }, -- 加老大
    [1217965] = { itemID=235646, versionID=106, source=18 }, -- 闪雾自由奔行者
    [1217994] = { itemID=235650, versionID=106, source=18 }, -- 珠光彩蝶
    [1218012] = { itemID=235657, versionID=106, source=18 }, -- 红玉彩蝶
    [1218013] = { itemID=235658, versionID=106, source=18 }, -- 春日彩蝶
    [1218014] = { itemID=235659, versionID=106, source=18 }, -- 午夜彩蝶
    [1218069] = { itemID=235662, versionID=106, source=18 }, -- 翡翠蜗牛
    [1221155] = { itemID=236960, versionID=11, source=5 }, -- 原型A.S.M.R.
    [1221694] = { itemID=237141, versionID=105, source=1017 }, -- 进取型切割坦克
  
}
-- 测试打印
--print("|cff00ff00[cupcko debug]|r [cupcko_data.lua] externalMountData content:")

--return externalMountData


-- myScanner.lua
local cupcko_mca = {}

local M = {}

--====================================================================--
-- 1) 全局/内部表
--====================================================================--
-- mountID -> itemID  (阶段1得到)
local itemMountMap  = {}
-- mountSpellID -> { itemID=?, versionID=0 } (阶段2得到)
local scannedMounts = {}

-- 配置参数 (可根据需要调整)
local ITEM_MAX_ID    = 500000  -- 扫描物品ID范围上限
local SPELL_MAX_ID   = 500000  -- 扫描法术ID范围上限
local CHUNK_SIZE     = 300    -- 每帧(or每yield)处理多少个 item/spell
local SCAN_INTERVAL  = 0.01    -- 协程onUpdate的间隔

local scanCoroutine  -- 主协程
local progressFrame  -- 进度条Frame

-- 用于“先请求加载物品”的异步管理
local pendingItems = {}    -- [itemID] = true，表示已请求过但尚未收到
local loadedCount  = 0     -- 已经收到事件 (成功或不成功) 的个数

--====================================================================--
-- 2) 进度条UI
--====================================================================--
local function CreateProgressBar()
    local frame = CreateFrame("Frame", "ScanProgressFrame", UIParent, "BackdropTemplate")
    frame:SetSize(300, 40)
    frame:SetPoint("CENTER", 0, 200)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

    frame:SetBackdrop({
        bgFile   = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile     = true, tileSize = 32, edgeSize = 32,
        insets   = { left=8, right=8, top=8, bottom=8 }
    })

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    title:SetPoint("TOP", 0, -5)
    title:SetText("扫描进度")

    local statusBar = CreateFrame("StatusBar", nil, frame, "BackdropTemplate")
    statusBar:SetSize(260, 14)
    statusBar:SetPoint("TOP", 0, -20)
    statusBar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
    statusBar:SetMinMaxValues(0, 1)
    statusBar:SetValue(0)

    local statusText = statusBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    statusText:SetPoint("CENTER")
    statusText:SetText("0%")

    -- 关闭按钮
    local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -3, -3)

    frame.statusBar  = statusBar
    frame.statusText = statusText

    return frame
end

--====================================================================--
-- 3) 事件监听框架: 用来接收 GET_ITEM_INFO_RECEIVED
--====================================================================--
local scanFrame = CreateFrame("Frame")
scanFrame:Hide()  -- 不用于显示UI，仅作事件载体

scanFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
scanFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "GET_ITEM_INFO_RECEIVED" then
        local itemID, success = ...
        if pendingItems[itemID] then
            -- 无论成功与否，都算“响应”了
            pendingItems[itemID] = nil
            loadedCount = loadedCount + 1

            if success then
                -- 现在可以安全调用 GetMountFromItem
                local mountID = C_MountJournal.GetMountFromItem(itemID)
                if mountID and mountID > 0 then
                    itemMountMap[mountID] = itemID
                end
            end
        end
    end
end)

--====================================================================--
-- 4) 阶段1：请求加载 itemID，并等待异步事件
--====================================================================--
-- 注意：这里依旧是用协程“假装”在扫描 itemID；但真正的 mountID 获取放到事件回调中做
--====================================================================--
local function ScanItems()
    local totalItems = ITEM_MAX_ID
    for itemID = 1, ITEM_MAX_ID do
        -- 调用 RequestLoadItemDataByID
        pendingItems[itemID] = true
        C_Item.RequestLoadItemDataByID(itemID)

        -- 更新进度条
        if progressFrame then
            local fraction = itemID / totalItems
            progressFrame.statusBar:SetValue(fraction)
            progressFrame.statusText:SetText(string.format("Item Scan: %.1f%%", fraction*100))
        end

        -- 每处理 CHUNK_SIZE 个，yield
        if (itemID % CHUNK_SIZE) == 0 then
            coroutine.yield("items")
        end
    end

    -- 所有 itemID 都已请求加载，但可能还没完全收到回调
    print("|cff00ff00[SCAN]|r 已对所有 itemID 请求加载, 等待事件回调...")

    -- 这里你可选择“等待一阵子” 或 直接进入下个阶段
    -- 简单做法：再yield若干次，给时间让事件回调填充 itemMountMap
    for i = 1, 10 do
        coroutine.yield("waiting")  
    end
end

--====================================================================--
-- 5) 阶段2：扫描 mountSpellID => mountID
--====================================================================--
local function ScanMountSpells()
    for mountSpellID = 1, SPELL_MAX_ID do
        local mountID = C_MountJournal.GetMountFromSpell(mountSpellID)
        if mountID then
            local itemID = itemMountMap[mountID]
            if itemID then
                scannedMounts[mountSpellID] = { itemID = itemID, versionID=0 }
            end
        end

        -- 更新进度条
        if progressFrame then
            local fraction = mountSpellID / SPELL_MAX_ID
            progressFrame.statusBar:SetValue(fraction)
            progressFrame.statusText:SetText(string.format("Spell Scan: %.1f%%", fraction*100))
        end

        if (mountSpellID % CHUNK_SIZE) == 0 then
            coroutine.yield("spells")
        end
    end
end

--====================================================================--
-- 6) 最终展示 scannedMounts
--====================================================================--
local function ShowScanResults()
    local frame = CreateFrame("Frame", "CupckoScanFrame", UIParent, "BackdropTemplate")
    frame:SetSize(400, 300)
    frame:SetPoint("CENTER")
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

    frame:SetBackdrop({
        bgFile   = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile     = true, tileSize = 32, edgeSize = 32,
        insets   = { left=8, right=8, top=8, bottom=8 }
    })

    local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -3, -3)

    local scroll = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 15, -15)
    scroll:SetPoint("BOTTOMRIGHT", -35, 15)

    local editBox = CreateFrame("EditBox", nil, scroll)
    editBox:SetMultiLine(true)
    editBox:SetFontObject(ChatFontNormal)
    editBox:SetWidth(330)
    editBox:SetAutoFocus(false)
    scroll:SetScrollChild(editBox)

    local lines = {}
    table.insert(lines, "-- scannedMounts (mountSpellID => { itemID=?, versionID=0 })")
    table.insert(lines, "{")
    for spellID, data in pairs(scannedMounts) do
        table.insert(lines, string.format("  [%d] = { itemID=%d, versionID=0 },", spellID, data.itemID))
    end
    table.insert(lines, "}")

    local resultText = table.concat(lines, "\n")
    editBox:SetText(resultText)
    editBox:HighlightText(0)
    frame:Show()
end

--====================================================================--
-- 7) 主协程: 先ScanItems -> 再ScanMountSpells -> 最后ShowScanResults
--====================================================================--
local function MainScanCoroutine()
    print("|cff00ff00[SCAN]|r 开始请求加载 itemID ...")
    if progressFrame then
        progressFrame.statusBar:SetValue(0)
        progressFrame.statusText:SetText("Item Scan: 0%")
    end
    ScanItems()

    print("|cff00ff00[SCAN]|r 开始扫描 mountSpellID ...")
    if progressFrame then
        progressFrame.statusBar:SetValue(0)
        progressFrame.statusText:SetText("Spell Scan: 0%")
    end
    ScanMountSpells()

    print("|cff00ff00[SCAN]|r 扫描完成. 即将展示结果 ...")
    -- 隐藏进度条
    if progressFrame then
        progressFrame:Hide()
    end
    ShowScanResults()
end

--====================================================================--
-- 8) OnUpdate: 分帧 resume 协程
--====================================================================--
local function OnUpdateHandler(self, elapsed)
    self.lastUpdate = (self.lastUpdate or 0) + elapsed
    if self.lastUpdate < SCAN_INTERVAL then
        return
    end
    self.lastUpdate = 0

    if scanCoroutine and coroutine.status(scanCoroutine) ~= "dead" then
        local ok, ret = coroutine.resume(scanCoroutine)
        if not ok then
            print("|cffff0000[SCAN ERROR]|r", ret)
            scanCoroutine = nil
            self:SetScript("OnUpdate", nil)
            if progressFrame then
                progressFrame:Hide()
            end
        end
    else
        self:SetScript("OnUpdate", nil)
        scanCoroutine = nil
        if progressFrame then
            progressFrame:Hide()
        end
    end
end

--====================================================================--
-- 9) 对外暴露: StartScan()
--====================================================================--
function M.StartScan(parentFrame)
    wipe(itemMountMap)
    wipe(scannedMounts)
    wipe(pendingItems)
    scanCoroutine = nil

    -- 若没创建进度条则创建
    if not progressFrame then
        progressFrame = CreateProgressBar()
    else
        progressFrame:Show()
        progressFrame.statusBar:SetValue(0)
        progressFrame.statusText:SetText("Ready...")
    end

    -- 启动协程
    scanCoroutine = coroutine.create(MainScanCoroutine)
    parentFrame:SetScript("OnUpdate", OnUpdateHandler)

    -- 显示并注册事件Frame
    scanFrame:Show()
end

-- 如果你想在外部查看 scannedMounts
function M.GetScannedMounts()
    return scannedMounts
end

cupcko_mca.MyScanner = M


-- cupcko+mca.lua
-- 作者: cupcko
-- 功能：
--   1) 读取外部数据 externalMountData(模拟.json -> lua)，形如：
--         externalMountData[spellID] = { itemID=xxxxx, versionID=2, source=3 }
--   2) 按照版本(通过手动Tab)筛选显示坐骑
--   3) 对比游戏内坐骑 SpellID，找出新增/未记录的坐骑
--   4) 插件界面加个按钮弹窗，显示新增坐骑的数据（可复制）
--   5) 额外：在当前版本筛选下，按 source 进行分组显示

--print("|cff00ff00[cupcko debug]|r cupcko.lua loaded!")

local MyScanner = cupcko_mca.MyScanner

----------------------------------------------------------------
-- 0) 读取外部数据表
----------------------------------------------------------------
-- 假定 externalMountData 在别的地方已经加载进来
if not externalMountData then
    externalMountData = {} -- 如果没加载到，则给个空表
end

----------------------------------------------------------------
-- 0.1) 定义一个版本表 & 当前版本过滤
-- 你可以根据需要增删版本；0表示“全部”
----------------------------------------------------------------
local expansions = {
    { versionID = 1000,  name = "总览" },
    { versionID = 11, name = "地心之战" },
    { versionID = 10, name = "巨龙时代" },
    { versionID = 9,  name = "暗影国度" },
    { versionID = 8,  name = "争霸艾泽拉斯" },
    { versionID = 7,  name = "军团再临" },
    { versionID = 6,  name = "德拉诺之王" },
    { versionID = 5,  name = "熊猫人之谜" },
    { versionID = 4,  name = "大地的裂变" },
    { versionID = 3,  name = "巫妖王之怒" },
    { versionID = 2,  name = "燃烧的远征" },
    { versionID = 1,  name = "经典旧世" },
    { versionID = 100, name = "事件" },
    { versionID = 101, name = "促销" },
    { versionID = 102, name = "专业" },
    { versionID = 103, name = "打架" },
    { versionID = 104, name = "其他" },
    { versionID = 106, name = "限时活动" },
    { versionID = 105, name = "绝版" },
    { versionID = 0, name = "未分类" },
    --{ versionID = 107, name = "收藏" },
}

-- 定义坐骑来源（source）列表
local sources = {
    { cls = 0,  name = "无用占位符" },
    { cls = 1,  name = "成就" },
    { cls = 2,  name = "声望" },
    { cls = 3,  name = "副本掉落" },
    { cls = 4,  name = "野外稀有" },
    { cls = 5,  name = "团本掉落" },
    { cls = 6,  name = "商人出售" },
    { cls = 7,  name = "宝箱" },
    { cls = 8,  name = "世界BOSS" },
    { cls = 9,  name = "版本活动" },
    { cls = 10, name = "任务" },
    { cls = 11, name = "法夜" },
    { cls = 12, name = "通灵" },
    { cls = 13, name = "温西尔" },
    { cls = 14, name = "格里恩" },
    { cls = 15, name = "指挥台" },
    { cls = 16, name = "巅峰大使" },
    { cls = 17, name = "碎片合成" },
    { cls = 18, name = "商栈" },
    { cls = 19, name = "招募/复活卷轴" },
    { cls = 20, name = "商城出售" },
    { cls = 21, name = "典藏礼包" },
    { cls = 22, name = "嘉年华" },
    { cls = 23, name = "活动" },
    { cls = 24, name = "种族购买" },
    { cls = 25, name = "绝版" },
    { cls = 26, name = "周年庆" },
    { cls = 27, name = "工程" },
    { cls = 28, name = "锻造" },
    { cls = 29, name = "制皮" },
    { cls = 30, name = "珠宝" },
    { cls = 31, name = "裁缝" },
    { cls = 32, name = "附魔" },
    { cls = 33, name = "炼金" },
    { cls = 34, name = "钓鱼" },
    { cls = 35, name = "考古" },
    { cls = 36, name = "铭文" },
    { cls = 37, name = "采药" },
    { cls = 38, name = "挖矿" },
    { cls = 39, name = "烹饪" },
    { cls = 40, name = "公会商人" },
    { cls = 41, name = "黑市" },
    { cls = 42, name = "角斗士" },
    { cls = 43, name = "占位符" },
    { cls = 44,  name = "解密" },
    { cls = 45,  name = "商城下架" },
    { cls = 46,  name = "商人下架" },
    { cls = 47,  name = "美酒节" },
    { cls = 48,  name = "卡牌" },
    { cls = 49,  name = "万圣节" },
    { cls = 50,  name = "情人节" },
    { cls = 51,  name = "暗月马戏团" },
    { cls = 52,  name = "复活节" },
    { cls = 53,  name = "冬幕节" },
    { cls = 54,  name = "春节" },
    { cls = 101,  name = "死亡骑士" },
    { cls = 102,  name = "圣骑士" },
    { cls = 103,  name = "恶魔猎手" },
    { cls = 104,  name = "术士" },
    { cls = 150,  name = "兽人" },
    { cls = 151,  name = "牛头人" },
    { cls = 152,  name = "亡灵" },
    { cls = 153,  name = "巨魔" },
    { cls = 154,  name = "暗夜精灵" },
    { cls = 155,  name = "狼人" },
    { cls = 156,  name = "熊猫人" },
    { cls = 157,  name = "光铸德莱尼" },
    { cls = 158,  name = "至高岭牛头人" },
    { cls = 159,  name = "夜之子" },
    { cls = 160,  name = "虚空精灵" },
    { cls = 161,  name = "赞达拉巨魔" },
    { cls = 162,  name = "玛格汉兽人" },
    { cls = 163,  name = "黑铁矮人" },
    { cls = 164,  name = "库尔提拉斯人" },
    { cls = 165,  name = "机械侏儒" },
    { cls = 166,  name = "狐人" },
    { cls = 167,  name = "血精灵" },
    { cls = 168,  name = "龙希尔" },
    { cls = 169,  name = "土灵" },
    { cls = 170,  name = "矮人" },
    { cls = 171,  name = "人类" },
    { cls = 172,  name = "侏儒" },
    { cls = 173,  name = "地精" },
    { cls = 174,  name = "德莱尼" },
    { cls = 201,  name = "哈兰" },
    { cls = 202,  name = "灵翼之龙" },
    { cls = 203,  name = "沙塔尔天空卫队" },
    { cls = 203,  name = "纳格兰" },
    { cls = 301,  name = "银色锦标赛" },
    { cls = 302,  name = "霍迪尔之子" },
    { cls = 303,  name = "龙眠联军" },
    { cls = 401,  name = "巴拉丁" },
    { cls = 402,  name = "拉穆卡恒" },
    { cls = 501,  name = "云端祥龙骑士团" },
    { cls = 502,  name = "影踪派" },
    { cls = 503,  name = "阡陌客" },
    { cls = 504,  name = "永恒岛" },
    { cls = 505,  name = "金莲教" },
    { cls = 506,  name = "至尊天神" },
    { cls = 601,  name = "要塞兽栏" },
    { cls = 602,  name = "要塞入侵" },
    { cls = 603,  name = "德拉诺黄金挑战" },
    { cls = 801,  name = "阿拉希" },
    { cls = 802,  name = "黑海岸" },
    { cls = 803,  name = "突袭" },
    { cls = 804,  name = "惊魂幻象" },
    { cls = 904,  name = "温西尔" },
    { cls = 905,  name = "法夜" },
    { cls = 906,  name = "通灵" },
    { cls = 907,  name = "格里恩" },
    { cls = 908,  name = "原生体合成" },
    { cls = 909,  name = "托加斯特" },
    { cls = 910,  name = "盟约通用" },
    { cls = 1001,  name = "熊猫人幻境新生" },
    { cls = 1002,  name = "时光漫游" },
    { cls = 1003,  name = "熊猫人黄金挑战" },
    { cls = 1004,  name = "炉石传说" },
    { cls = 1005,  name = "搏击俱乐部" },
    { cls = 1006,  name = "邪气鞍座" },
    { cls = 1007,  name = "典藏版" },
    { cls = 1008,  name = "投票" },
    { cls = 1009,  name = "荣誉等级" },
    { cls = 1010,  name = "职业坐骑" },
    { cls = 1011,  name = "风暴英雄" },
    { cls = 1012,  name = "地区" },
    { cls = 1013,  name = "限时" },
    { cls = 1014,  name = "海岛探险" },
    { cls = 1015,  name = "霸业风暴" },
    { cls = 1016,  name = "魔兽争霸" },
    { cls = 1017,  name = "钥石大师" },
    { cls = 1018,  name = "怀旧服" },
    { cls = 1019,  name = "暗黑破坏神" },
    { cls = 1020,  name = "临时" },
    { cls = 1021,  name = "时光裂隙" },
    { cls = 1022,  name = "翡翠梦境" },
    { cls = 1023,  name = "前夕绝版" },
    { cls = 1024,  name = "坐骑收集" },
    { cls = 1025,  name = "传家宝" },
    { cls = 1026,  name = "未实装" },
    { cls = 1027,  name = "未分类" },
    { cls = 1028,  name = "奥特兰克山谷" },
    { cls = 1029,  name = "甲虫的召唤" },
    { cls = 1030,  name = "联名活动" },
}
-- print(0.01)
-- 当前选中版本（Tab）
local currentVersionFilter = 1000  -- 0表示显示全部

----------------------------------------------------------------
-- 1) 主插件框体
----------------------------------------------------------------
local CupckoFrame_MCA = CreateFrame("Frame", "CupckoMainFrame", UIParent, "BackdropTemplate")
CupckoFrame_MCA:SetPoint("CENTER")
CupckoFrame_MCA:SetSize(800, 600)  -- 默认初始大小（可自行调整）
CupckoFrame_MCA:SetMovable(true)
CupckoFrame_MCA:EnableMouse(true)
CupckoFrame_MCA:RegisterForDrag("LeftButton")
CupckoFrame_MCA:SetScript("OnDragStart", CupckoFrame_MCA.StartMoving)
CupckoFrame_MCA:SetScript("OnDragStop", CupckoFrame_MCA.StopMovingOrSizing)
CupckoFrame_MCA:SetClampedToScreen(true)
--CupckoFrame_MCA:SetBackdropColor(1, 1, 1)
-- CupckoFrame_MCA:Hide()
-- print(0.02)
-- 允许缩放
CupckoFrame_MCA:SetResizable(true)
-- print(0.021)
CupckoFrame_MCA:SetResizeBounds(400, 300, 1200, 900)  -- 可根据需要改成更大或更小
-- print(0.022)
-- CupckoFrame_MCA:SetMaxResize(1200, 900)
-- 背景
-- print(0.03)
CupckoFrame_MCA:SetBackdrop({
    bgFile   = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile     = true, tileSize = 32, edgeSize = 24,
    insets   = { left = 8, right = 8, top = 8, bottom = 8 }
})
CupckoFrame_MCA:Hide()
-- 允许通过 ESC 键关闭 CupckoFrame_MCA
tinsert(UISpecialFrames, "CupckoMainFrame")
-- print(0.1)
-- 标题
local title = CupckoFrame_MCA:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
title:SetPoint("TOP", 0, -16)
title:SetText("坐骑收集")

-- 右上角关闭按钮
local closeButton = CreateFrame("Button", nil, CupckoFrame_MCA, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", -5, -5)
closeButton:SetFrameLevel(CupckoFrame_MCA:GetFrameLevel() + 10)  -- 确保关闭按钮位于顶层
-- 新增部分：左上角重置大小按钮
--local resetButton = CreateFrame("Button", nil, CupckoFrame_MCA, "UIPanelButtonTemplate")
--resetButton:SetSize(100, 24)
--resetButton:SetPoint("TOPLEFT", 10, -10) -- 相对于CupckoFrame_MCA的左上角，稍微内移
--resetButton:SetText("重置大小")
--resetButton:SetScript("OnClick", function()
--    CupckoFrame_MCA:SetSize(800, 600)
--    print("|cff00ff00[cupcko]|r 已将画布大小重置为默认值。")
--end)

-- 右下角拖拽手柄
local resizeGrip = CreateFrame("Frame", nil, CupckoFrame_MCA)
resizeGrip:SetSize(32, 32)
resizeGrip:SetPoint("BOTTOMRIGHT")
resizeGrip:EnableMouse(true)
-- print(0.2)
-- 给拖拽手柄加个简单的纹理，也可用 SizeGrabber
local rgTexture = resizeGrip:CreateTexture(nil, "BACKGROUND")
rgTexture:SetAllPoints()
rgTexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")

-- 按下时更换纹理
resizeGrip:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        CupckoFrame_MCA:StartSizing("BOTTOMRIGHT")
        rgTexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
    end
end)
-- 松开时停止缩放，并更新纹理 & 重新刷新布局
resizeGrip:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
        CupckoFrame_MCA:StopMovingOrSizing()
        rgTexture:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
        -- 调整完大小后，刷新布局
        RefreshMountList()
    end
end)
-- print(0.3)
----------------------------------------------------------------
-- 1.1) “滚动区域” + 内容容器
----------------------------------------------------------------
local scrollFrame = CreateFrame("ScrollFrame", "CupckoScrollFrame", CupckoFrame_MCA, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", 20, -60)
scrollFrame:SetPoint("BOTTOMRIGHT", -30, 60)


local contentFrame = CreateFrame("Frame", "CupckoScrollChild", scrollFrame)
contentFrame:SetSize(1, 1)
scrollFrame:SetScrollChild(contentFrame)

----------------------------------------------------------------
-- 2) 收集“新增坐骑信息”的表
----------------------------------------------------------------
local newMounts = {} -- [spellID] = { name=..., itemID=?, versionID=? }

----------------------------------------------------------------
-- 2.1) 手动创建Tab，并维护“选中”状态
----------------------------------------------------------------
local tabs = {}  -- 存储所有Tab按钮

-- 函数：设置哪个Tab被选中
local function SetSelectedTab(idx)
    for i, expInfo in ipairs(expansions) do
        local tab = tabs[i]
        if i == idx then
            tab:Disable()  -- 选中状态：禁用按钮以表示高亮
        else
            tab:Enable()
        end
    end
end

-- 当点击某个Tab时
local function OnTabClick(self)
    local idx = self:GetID()
    currentVersionFilter = expansions[idx].versionID
    SetSelectedTab(idx)
    -- print("当前选中 =>", currentVersionFilter)
    RefreshMountList()
end

-- 创建各个Tab按钮
for i, expInfo in ipairs(expansions) do
    local tab = CreateFrame("Button", "CupckoTab"..i, CupckoFrame_MCA, "UIPanelButtonTemplate")
    tab:SetID(i)
    tab:SetSize(120, 24)

    -- 这里随便设置一个纹理和按下效果，如果不想要可以注释掉
    tab:SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Real")
    tab:SetPushedTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Real-Pressed")

    tab:SetText(expInfo.name)
    tab:SetScript("OnClick", OnTabClick)
    tabs[i] = tab

    -- 设置Tab按钮的位置（垂直排列在左上）
    if i == 1 then
        tab:SetPoint("TOPLEFT", CupckoFrame_MCA, "TOPLEFT", -120, 0)
    else
        tab:SetPoint("TOPLEFT", tabs[i-1], "BOTTOMLEFT", 0, -1)
    end
end

-- 默认选中第1个Tab(“总览”)
SetSelectedTab(1)

-- 根据 versionID 找到 expansions 里的下标 i，执行 SetSelectedTab(i) + RefreshMountList
local function GotoTabByVersionID(vID)
    for i, expInfo in ipairs(expansions) do
        if expInfo.versionID == vID then
            currentVersionFilter = vID
            SetSelectedTab(i)  -- 高亮/禁用对应Tab
            RefreshMountList()
            return
        end
    end
    print("没找到对应 versionID=", vID, "的Tab")
end

----------------------------------------------------------------
-- 3) 刷新坐骑列表 & 对比 externalMountData
--    并且在当前版本过滤下，根据 source 进行分类排布
----------------------------------------------------------------
function RefreshMountList()
    -- 1) 先清理旧内容
    for _, child in ipairs({contentFrame:GetChildren()}) do
        child:Hide()
        child:SetParent(nil)
    end
    -- 再清理所有子 Region（FontString, Texture 等）
    for _, region in ipairs({contentFrame:GetRegions()}) do
        region:Hide()
        region:ClearAllPoints()
    end

    -- 如果当前选择是总览，则执行总览逻辑
    if currentVersionFilter == 1000 then
      

        -- 统计完后，开始画总览
        local mountIDs = C_MountJournal.GetMountIDs()
        if not mountIDs then return end

        local versionStats = {}
        for _, expInfo in ipairs(expansions) do
            versionStats[expInfo.versionID] = { total = 0, owned = 0 }
        end
        
        -- 遍历坐骑统计
        for _, mID in ipairs(mountIDs) do
            local name, spellID, _, _, _, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mID)
            if name and spellID then
                local data = externalMountData[spellID]
                local mountVersion = data and data.versionID or 0

                if versionStats[mountVersion] then
                    versionStats[mountVersion].total = versionStats[mountVersion].total + 1
                    if isCollected then
                        versionStats[mountVersion].owned = versionStats[mountVersion].owned + 1
                    end
                end
            end
        end
        
        --------------------------------------------------------
        -- 让“总览”里的每个资料片进度块从左往右排，超出后换行
        --------------------------------------------------------
        -- 计算可用宽度
        local usableWidth = contentFrame:GetWidth()
        if usableWidth < 50 then
            usableWidth = CupckoFrame_MCA:GetWidth() - 60  -- 兼容在窗口初始化时 contentFrame 宽度尚未就绪
        end

        -- 这里你可以根据需要调整块的尺寸、间距
        local catWidth  = 140   -- 每个“资料片进度块”的宽度
        local catHeight = 50    -- 每个“资料片进度块”的高度
        local catSpacing = 10   -- 水平/垂直间隔

        -- 初始“光标”位置（相对于 contentFrame 的左上角）
        local xOff = 10
        local yOff = -10  -- 初始向下偏移



        for i, expInfo in ipairs(expansions) do
            local stats = versionStats[expInfo.versionID]
            if stats and stats.total > 0 then
                local percentage = (stats.owned / stats.total) * 100
                -- 若下一个 catWidth 超出 usableWidth，则换行
                if xOff + catWidth > usableWidth then
                    xOff = 10
                    yOff = yOff - (catHeight + catSpacing)
                end
                -----------------------------------------
                -- 创建一个 Button 代表此资料片进度
                -----------------------------------------
                local catFrame = CreateFrame("Button", nil, contentFrame, "BackdropTemplate")
                catFrame:SetSize(catWidth, catHeight)
                catFrame:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", xOff, yOff)
                catFrame:EnableMouse(true)
                catFrame:RegisterForClicks("AnyUp")
                
                -- 给 catFrame 设置个浅色背景，调试用；实际可不需要
                -- catFrame:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground" })
                -- catFrame:SetBackdropColor(0,0,0,0.8)

                -----------------------------------------
                -- 标题
                -----------------------------------------
                -- 点击 => 跳转到相应版本Tab
                catFrame:SetScript("OnClick", function()
                GotoTabByVersionID(expInfo.versionID)
                end)

                local tabName = catFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                tabName:SetPoint("TOPLEFT", catFrame, "TOPLEFT", 5, -5)
                tabName:SetText(expInfo.name)

                -----------------------------------------
                -- 进度条背景
                -----------------------------------------
                local progressBarBg = catFrame:CreateTexture(nil, "BACKGROUND")
                progressBarBg:SetSize(catWidth - 10, 16)  -- 宽度稍微留点边距
                progressBarBg:SetPoint("TOPLEFT", tabName, "BOTTOMLEFT", 0, -5)
                progressBarBg:SetColorTexture(0.2, 0.2, 0.2, 1)

                -----------------------------------------
                -- 进度条前景
                -----------------------------------------
                local progressBar = catFrame:CreateTexture(nil, "ARTWORK")
                progressBar:SetSize((catWidth - 10) * (percentage / 100), 16)
                progressBar:SetPoint("LEFT", progressBarBg, "LEFT", 0, 0)
                if percentage==100 then
                    progressBar:SetColorTexture(0.35, 0.66, 0.8, 0.7)
                else
                    progressBar:SetColorTexture(1-(0.8*percentage/100), 0.8*percentage/100, 0, 0.7)
                end
                -- print(percentage)
                -----------------------------------------
                -- 百分比文字
                -----------------------------------------
                -- local percentageText = catFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                -- percentageText:SetPoint("LEFT", progressBarBg, "RIGHT", 10, 0)
                -- percentageText:SetText(string.format("%.1f%%", percentage))
                local countText = catFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                countText:SetPoint("CENTER", progressBarBg, "CENTER", 0, 0)
                countText:SetText(string.format("%d/%d (%d%%)", stats.owned, stats.total,percentage))
                -----------------------------------------
                -- 新增：点击事件 => 跳转对应Tab
                -- 不管点击标题还是进度条，都算点在 catFrame 上
                -----------------------------------------
                catFrame:SetScript("OnClick", function()
                    GotoTabByVersionID(expInfo.versionID)
                end)

                -- 最后更新 yOff
                xOff = xOff + catWidth + catSpacing
            end
        end

        -- contentFrame 的高度要足够大，以容纳 yOff 的排布
        contentFrame:SetHeight(math.abs(yOff) + catHeight + 20)
        return
    end

    -- 非总览部分的布局调整
    if not C_MountJournal or not C_MountJournal.GetMountIDs then
        return
    end

    -- 获取所有坐骑ID
    local mountIDs = C_MountJournal.GetMountIDs()
    if not mountIDs then return end

    wipe(newMounts) -- 每次刷新前先清空 newMounts

    -- 按source分组坐骑
    local groupedMounts = {}
    for _, mID in ipairs(mountIDs) do
        local name, spellID, icon, _, _, _, _, _, _, _, isCollected =
            C_MountJournal.GetMountInfoByID(mID)
        if name and spellID then
            local data = externalMountData[spellID]
            local mountItemID  = data and data.itemID    or 0
            local mountVersion = data and data.versionID or 0
            local mountSource  = data and data.source    or 0

            -- 版本过滤 (1000=总览，显示全部; 非1000=只显示指定版本)
            if currentVersionFilter == 1000 or mountVersion == currentVersionFilter then
                if not groupedMounts[mountSource] then
                    groupedMounts[mountSource] = {}
                end
                table.insert(groupedMounts[mountSource], {
                    spellID     = spellID,
                    name        = name,
                    icon        = icon,
                    isCollected = isCollected,
                    itemID      = mountItemID,
                    mountID     = mID,
                })
            end

            -- 若 externalMountData[spellID] 不存在 => 说明是新增坐骑
            if not data then
                newMounts[spellID] = {
                    name      = name,
                    itemID    = 0,   -- 先默认0
                    versionID = 0,   -- 先默认0
                    source    = 0,   -- 先默认0
                }
            end
        end
    end

    -- 获取所有有坐骑的source信息
    local activeSources = {}
    for _, srcInfo in ipairs(sources) do
        if groupedMounts[srcInfo.cls] and #groupedMounts[srcInfo.cls] > 0 then
            table.insert(activeSources, srcInfo)
        end
    end

    -- 计算列数和列宽
    local usableWidth = contentFrame:GetWidth()
    if usableWidth < 50 then
        usableWidth = CupckoFrame_MCA:GetWidth() - 60  -- 兼容在窗口初始化时 contentFrame 宽度尚未就绪
    end

    local numColumns = math.floor(usableWidth / 300)
    if numColumns < 1 then numColumns = 1 end
    local columnWidth = usableWidth / numColumns

    -- 初始化列的位置
    local columns = {}
    for col = 1, numColumns do
        columns[col] = {
            x = (col - 1) * columnWidth + 10, -- 左边距10
            y = -10, -- 顶部偏移
        }
    end

    -- 分配源到列（每300像素增加一列）
    for i, srcInfo in ipairs(activeSources) do
        local columnIndex = math.floor((i - 1) / math.floor(#activeSources / numColumns + 0.5)) + 1
        if columnIndex > numColumns then
            columnIndex = numColumns
        end
        local col = columns[columnIndex]

        -- 创建源标题
        local header = contentFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        header:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", col.x, col.y)
        header:SetText(srcInfo.name)
        header:SetWidth(columnWidth - 20) -- 预留边距
        header:SetJustifyH("LEFT")

        col.y = col.y - 25 -- 标题高度和间距

        -- 获取该source的所有坐骑
        local mountsThisSource = groupedMounts[srcInfo.cls]
        if mountsThisSource and #mountsThisSource > 0 then
            local mountIconSize = 30
            local mountSpacing = 6
            local currentX = col.x
            local currentY = col.y

            for _, mountData in ipairs(mountsThisSource) do
                -- 如果即将超出列宽，则换行
                if currentX + mountIconSize > col.x + columnWidth - 10 then
                    currentX = col.x
                    currentY = currentY - mountIconSize - mountSpacing
                end

                -- 创建按钮来显示坐骑
                local mountButton = CreateFrame("Button", nil, contentFrame, "BackdropTemplate")
                mountButton:SetSize(mountIconSize, mountIconSize)
                mountButton:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", currentX, currentY)
                mountButton:EnableMouse(true)
                mountButton:RegisterForClicks("AnyUp")
                -- 图标
                local iconTexture = mountButton:CreateTexture(nil, "ARTWORK")
                iconTexture:SetAllPoints()
                iconTexture:SetTexture(mountData.icon)

                -- 创建绿圈边框
                local greenBorder = mountButton:CreateTexture(nil, "BORDER")
                greenBorder:SetSize(mountIconSize + 4, mountIconSize + 4)  -- 略大于图标
                greenBorder:SetPoint("CENTER", iconTexture, "CENTER", 0, 0)
                greenBorder:SetColorTexture(0, 1, 0.2, 0.6)  -- 绿色
                greenBorder:Hide()  -- 默认隐藏

                -- 创建红圈边框
                local redBorder = mountButton:CreateTexture(nil, "BORDER")
                redBorder:SetSize(mountIconSize + 4, mountIconSize + 4)  -- 略大于图标
                redBorder:SetPoint("CENTER", iconTexture, "CENTER", 0, 0)
                redBorder:SetColorTexture(1, 0, 0.2, 0.6)    -- 红色
                redBorder:Hide()  -- 默认隐藏

                -- 根据是否收集，显示相应的边框
                if not mountData.isCollected then
                    redBorder:Show()
                    iconTexture:SetVertexColor(1, 0.5, 0.5, 1)
                else
                    greenBorder:Show()
                    iconTexture:SetVertexColor(1, 1, 1, 1)
                end


                -- 鼠标提示
                mountButton:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:ClearLines()
                    if mountData.itemID > 0 then
                        GameTooltip:SetItemByID(mountData.itemID)
                    else
                        GameTooltip:SetSpellByID(mountData.spellID)
                    end
                    GameTooltip:Show()
                end)
                mountButton:SetScript("OnLeave", function()
                    GameTooltip:Hide()
                end)

                -- 点击事件
                mountButton:SetScript("OnClick", function(self, button)
                    if button == "RightButton" then
                        if mountData.isCollected then
                            -- 如果坐骑已被收集，召唤坐骑
                            C_MountJournal.SummonByID(mountData.mountID)
                        end

                    elseif button == "LeftButton" then
                        if IsShiftKeyDown() then
                            local mountLink = C_MountJournal.GetMountLink(mountData.spellID)
                            if mountData.itemID > 0 then
                                local itemName, itemLink = GetItemInfo(mountData.itemID)
                                if itemLink then
                                    ChatEdit_InsertLink(itemLink)
                                end
                            end
                            if mountLink then
                                ChatEdit_InsertLink(mountLink)
                            end
                        elseif IsControlKeyDown() then
                            if DressUpMount and type(DressUpMount)=="function" then
                                DressUpMount(mountData.mountID)
                            else
                                local mountLink = C_MountJournal.GetMountLink(mountData.spellID)
                                if mountLink then
                                    DressUpLink(mountLink)
                                end
                            end
                        end
                    end
                end)

                -- 更新坐骑图标的位置
                currentX = currentX + mountIconSize + mountSpacing
            end

            -- 更新列的y坐标，留出额外空隙
            col.y = currentY - mountIconSize - mountSpacing
        end
    end

    -- 设置 contentFrame 的高度为所有列中最低的Y坐标
    local maxHeight = 0
    for _, col in ipairs(columns) do
        local height = math.abs(col.y) + 20
        if height > maxHeight then
            maxHeight = height
        end
    end
    contentFrame:SetHeight(maxHeight)
end
-- print(11)
----------------------------------------------------------------
-- 4) “显示差异”按钮 + 弹出复制窗口
----------------------------------------------------------------
local showDiffButton = CreateFrame("Button", nil, CupckoFrame_MCA, "UIPanelButtonTemplate")
showDiffButton:SetSize(100, 24)
showDiffButton:SetPoint("BOTTOMLEFT", 20, 20)
showDiffButton:SetText("差异")
showDiffButton:SetScript("OnClick", function()
    local diffFrame = CreateFrame("Frame", "CupckoDiffFrame", UIParent, "BackdropTemplate")
    diffFrame:SetPoint("CENTER")
    diffFrame:SetSize(400, 300)
    diffFrame:EnableMouse(true)
    diffFrame:SetMovable(true)
    diffFrame:RegisterForDrag("LeftButton")
    diffFrame:SetScript("OnDragStart", diffFrame.StartMoving)
    diffFrame:SetScript("OnDragStop", diffFrame.StopMovingOrSizing)

    diffFrame:SetBackdrop({
        bgFile   = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile     = true, tileSize = 32, edgeSize = 32,
        insets   = { left = 8, right = 8, top = 8, bottom = 8 }
    })

    local close = CreateFrame("Button", nil, diffFrame, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -5, -5)

    local scroll = CreateFrame("ScrollFrame", nil, diffFrame, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 15, -15)
    scroll:SetPoint("BOTTOMRIGHT", -35, 15)

    local editBox = CreateFrame("EditBox", nil, scroll)
    editBox:SetMultiLine(true)
    editBox:SetFontObject(ChatFontNormal)
    editBox:SetWidth(330)
    editBox:SetAutoFocus(false)
    scroll:SetScrollChild(editBox)

    local lines = {}
    table.insert(lines, "-- 差异SpellID => { itemID=?, versionID=?, source=? }")
    table.insert(lines, "{")

    -- 对 newMounts 的 key 进行排序
    local sortedKeys = {}
    for sID in pairs(newMounts) do
        table.insert(sortedKeys, sID)
    end
    table.sort(sortedKeys)

    for _, sID in ipairs(sortedKeys) do
        local info = newMounts[sID]
        table.insert(lines, string.format("  [%d] = { itemID=%d, versionID=%d, source=%d }, -- %s",
            sID, info.itemID or 0, info.versionID or 0, info.source or 0, info.name or ""))
    end

    table.insert(lines, "}")

    local diffText = table.concat(lines, "\n")
    editBox:SetText(diffText)
    editBox:HighlightText(0)

    diffFrame:Show()
end)
-- print(12)
----------------------------------------------------------------
-- 新增功能按钮：Scan Items
----------------------------------------------------------------
--local scanItemsButton = CreateFrame("Button", nil, CupckoFrame_MCA, "UIPanelButtonTemplate")
--scanItemsButton:SetSize(100, 24)
---- 放在 showDiffButton 右侧 10 像素，视你布局而定
--scanItemsButton:SetPoint("LEFT", showDiffButton, "RIGHT", 10, 0)
--scanItemsButton:SetText("Scan Items")
--scanItemsButton:SetScript("OnClick", function()
--    MyScanner.StartScan(CupckoFrame_MCA) -- 传入 CupckoFrame_MCA, 让扫描协程在其 OnUpdate 里跑
--end)

----------------------------------------------------------------
-- 5) 注册事件, Slash命令
----------------------------------------------------------------
local function OnEvent(self, event, ...)
    if event == "ADDON_LOADED" then
        local loadedAddon = ...
        if loadedAddon == "OrzUI" then
            self:UnregisterEvent("ADDON_LOADED")
        end

    elseif event == "PLAYER_LOGIN" then
        RefreshMountList()

    elseif event == "COMPANION_UPDATE" or event == "NEW_MOUNT_ADDED" then
        RefreshMountList()
    end
end

CupckoFrame_MCA:SetScript("OnEvent", OnEvent)
CupckoFrame_MCA:RegisterEvent("ADDON_LOADED")
CupckoFrame_MCA:RegisterEvent("PLAYER_LOGIN")
CupckoFrame_MCA:RegisterEvent("COMPANION_UPDATE")
CupckoFrame_MCA:RegisterEvent("NEW_MOUNT_ADDED")

SLASH_CUPCKO_MCA1 = "/."
SlashCmdList["CUPCKO_MCA"] = function()
    if CupckoFrame_MCA:IsShown() then
        CupckoFrame_MCA:Hide()
    else
        RefreshMountList()
        CupckoFrame_MCA:Show()
        CupckoFrame_MCA:SetFrameLevel(999)  -- 设置为较高的层级
    end
end

----------------------------------------------------------------
-- 6) 监听画布大小变化以动态调整布局
----------------------------------------------------------------
--CupckoFrame_MCA:SetScript("OnSizeChanged", function(self, width, height)
--    RefreshMountList()
--end)
