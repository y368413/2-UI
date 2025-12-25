-- AutoSellLowLevelGear.lua  ## Author: 小天 ## Version: 2.5

-- TierTokenData.lua
-- 职业套装代币数据文件
-- 用于存储所有版本的职业套装兑换代币ID和关键词

-- 职业套装兑换代币物品ID列表（仅代币，不包含套装物品）
TIER_SET_ITEMS = {
    -- ========== TBC 燃烧的远征 (T4-T6) ==========
    -- T4 代币 (Fallen系列)
    -- Fallen Champion (圣骑士、盗贼、萨满)
    [29754] = true, -- "Chestguard of the Fallen Champion"
    [29757] = true, -- "Gloves of the Fallen Champion"
    [29760] = true, -- "Helm of the Fallen Champion"
    [29763] = true, -- "Pauldrons of the Fallen Champion"
    
    -- Fallen Defender (战士、牧师、德鲁伊)
    [29753] = true, -- "Chestguard of the Fallen Defender"
    [29758] = true, -- "Gloves of the Fallen Defender"
    [29761] = true, -- "Helm of the Fallen Defender"
    [29764] = true, -- "Pauldrons of the Fallen Defender"
    
    -- Fallen Hero (猎人、法师、术士)
    [29755] = true, -- "Chestguard of the Fallen Hero"
    [29756] = true, -- "Gloves of the Fallen Hero"
    [29759] = true, -- "Helm of the Fallen Hero"
    [29762] = true, -- "Pauldrons of the Fallen Hero"
    
    -- T5 代币 (Vanquished系列)
    [30236] = true, -- "Chestguard of the Vanquished Champion"
    [30237] = true, -- "Gloves of the Vanquished Champion"
    [30240] = true, -- "Helm of the Vanquished Champion"
    [30241] = true, -- "Leggings of the Vanquished Champion"
    [30243] = true, -- "Pauldrons of the Vanquished Champion"
    -- Defender变体
    [30242] = true, -- "Chestguard of the Vanquished Defender"
    [30244] = true, -- "Gloves of the Vanquished Defender"
    [30245] = true, -- "Helm of the Vanquished Defender"
    [30246] = true, -- "Leggings of the Vanquished Defender"
    [30247] = true, -- "Pauldrons of the Vanquished Defender"
    -- Hero变体
    [30238] = true, -- "Chestguard of the Vanquished Hero"
    [30239] = true, -- "Gloves of the Vanquished Hero"
    [30248] = true, -- "Helm of the Vanquished Hero"
    [30249] = true, -- "Leggings of the Vanquished Hero"
    [30250] = true, -- "Pauldrons of the Vanquished Hero"
    
    -- T6 代币 (Forgotten系列)
    -- Forgotten Conqueror (圣骑士、牧师、术士)
    [31089] = true, -- "Chestguard of the Forgotten Conqueror"
    [31092] = true, -- "Gloves of the Forgotten Conqueror"
    [31095] = true, -- "Helm of the Forgotten Conqueror"
    [31098] = true, -- "Leggings of the Forgotten Conqueror"
    [31101] = true, -- "Pauldrons of the Forgotten Conqueror"
    
    -- Forgotten Protector (战士、猎人、萨满)
    [31091] = true, -- "Chestguard of the Forgotten Protector"
    [31094] = true, -- "Gloves of the Forgotten Protector"
    [31097] = true, -- "Helm of the Forgotten Protector"
    [31100] = true, -- "Leggings of the Forgotten Protector"
    [31103] = true, -- "Pauldrons of the Forgotten Protector"
    
    -- Forgotten Vanquisher (盗贼、法师、德鲁伊)
    [31090] = true, -- "Chestguard of the Forgotten Vanquisher"
    [31093] = true, -- "Gloves of the Forgotten Vanquisher"
    [31096] = true, -- "Helm of the Forgotten Vanquisher"
    [31099] = true, -- "Leggings of the Forgotten Vanquisher"
    [31102] = true, -- "Pauldrons of the Forgotten Vanquisher"
    
    -- ========== WOTLK 巫妖王之怒 (T7-T10) ==========
    -- T7 代币 (Lost系列)
    [40610] = true, -- "Crown of the Lost Conqueror"
    [40611] = true, -- "Crown of the Lost Protector"
    [40612] = true, -- "Crown of the Lost Vanquisher"
    [40613] = true, -- "Mantle of the Lost Conqueror"
    [40614] = true, -- "Mantle of the Lost Protector"
    [40615] = true, -- "Mantle of the Lost Vanquisher"
    
    -- T8 代币 (Wayward系列)
    [45635] = true, -- "Crown of the Wayward Conqueror"
    [45636] = true, -- "Crown of the Wayward Protector"
    [45637] = true, -- "Crown of the Wayward Vanquisher"
    [45638] = true, -- "Mantle of the Wayward Conqueror"
    [45639] = true, -- "Mantle of the Wayward Protector"
    [45640] = true, -- "Mantle of the Wayward Vanquisher"
    
    -- T9 代币和货币
    [47242] = true, -- "Trophy of the Crusade" (25人)
    [47556] = true, -- "Crusader Orb"
    [49426] = true, -- "Emblem of Triumph"
    [49427] = true, -- "Emblem of Frost"
    
    -- T10 代币 (Sanctification系列)
    [52025] = true, -- "Vanquisher's Mark of Sanctification"
    [52026] = true, -- "Protector's Mark of Sanctification"
    [52027] = true, -- "Conqueror's Mark of Sanctification"
    [52028] = true, -- "Vanquisher's Mark of Sanctification (Heroic)"
    [52029] = true, -- "Protector's Mark of Sanctification (Heroic)"
    [52030] = true, -- "Conqueror's Mark of Sanctification (Heroic)"
    
    -- ========== Cataclysm 大地的裂变 (T11-T13) ==========
    -- T11 代币 (Forlorn系列)
    [65001] = true, -- "Crown of the Forlorn Conqueror"
    [65002] = true, -- "Crown of the Forlorn Protector"
    [65003] = true, -- "Crown of the Forlorn Vanquisher"
    [65004] = true, -- "Shoulders of the Forlorn Conqueror"
    [65005] = true, -- "Shoulders of the Forlorn Protector"
    [65006] = true, -- "Shoulders of the Forlorn Vanquisher"
    [65007] = true, -- "Chest of the Forlorn Conqueror"
    [65008] = true, -- "Chest of the Forlorn Protector"
    [65009] = true, -- "Chest of the Forlorn Vanquisher"
    [65010] = true, -- "Gauntlets of the Forlorn Conqueror"
    [65011] = true, -- "Gauntlets of the Forlorn Protector"
    [65012] = true, -- "Gauntlets of the Forlorn Vanquisher"
    [65013] = true, -- "Leggings of the Forlorn Conqueror"
    [65014] = true, -- "Leggings of the Forlorn Protector"
    [65015] = true, -- "Leggings of the Forlorn Vanquisher"
    
    -- T12 代币 (Fiery系列)
    [71674] = true, -- "Crown of the Fiery Conqueror"
    [71675] = true, -- "Crown of the Fiery Protector"
    [71676] = true, -- "Crown of the Fiery Vanquisher"
    [71677] = true, -- "Mantle of the Fiery Conqueror"
    [71678] = true, -- "Mantle of the Fiery Protector"
    [71679] = true, -- "Mantle of the Fiery Vanquisher"
    [71680] = true, -- "Chest of the Fiery Conqueror"
    [71681] = true, -- "Chest of the Fiery Protector"
    [71682] = true, -- "Chest of the Fiery Vanquisher"
    [71683] = true, -- "Gauntlets of the Fiery Conqueror"
    [71684] = true, -- "Gauntlets of the Fiery Protector"
    [71685] = true, -- "Gauntlets of the Fiery Vanquisher"
    [71686] = true, -- "Leggings of the Fiery Conqueror"
    [71687] = true, -- "Leggings of the Fiery Protector"
    [71688] = true, -- "Leggings of the Fiery Vanquisher"
    
    -- T13 代币 (Corrupted系列)
    [78847] = true, -- "Crown of the Corrupted Conqueror"
    [78848] = true, -- "Crown of the Corrupted Protector"
    [78849] = true, -- "Crown of the Corrupted Vanquisher"
    [78850] = true, -- "Shoulders of the Corrupted Conqueror"
    [78851] = true, -- "Shoulders of the Corrupted Protector"
    [78852] = true, -- "Shoulders of the Corrupted Vanquisher"
    [78853] = true, -- "Chest of the Corrupted Conqueror"
    [78854] = true, -- "Chest of the Corrupted Protector"
    [78855] = true, -- "Chest of the Corrupted Vanquisher"
    [78856] = true, -- "Gauntlets of the Corrupted Conqueror"
    [78857] = true, -- "Gauntlets of the Corrupted Protector"
    [78858] = true, -- "Gauntlets of the Corrupted Vanquisher"
    [78859] = true, -- "Leggings of the Corrupted Conqueror"
    [78860] = true, -- "Leggings of the Corrupted Protector"
    [78861] = true, -- "Leggings of the Corrupted Vanquisher"
    
    -- ========== MoP 熊猫人之谜 (T14-T16) ==========
    -- T14 代币 (Shadowy系列) - 恐惧之心和永春台
    
    -- 随机团本代币 (LFR - 物品等级483)
    [89235] = true, -- "Helm of the Shadowy Conqueror" (LFR)
    [89236] = true, -- "Helm of the Shadowy Protector" (LFR)
    [89234] = true, -- "Helm of the Shadowy Vanquisher" (LFR)
    
    [89238] = true, -- "Shoulders of the Shadowy Conqueror" (LFR)
    [89239] = true, -- "Shoulders of the Shadowy Protector" (LFR)
    [89276] = true, -- "Shoulders of the Shadowy Vanquisher" (LFR)
    
    [89264] = true, -- "Chest of the Shadowy Conqueror" (LFR)
    [89265] = true, -- "Chest of the Shadowy Protector" (LFR)
    [89249] = true, -- "Chest of the Shadowy Vanquisher" (LFR)
    
    [89267] = true, -- "Gauntlets of the Shadowy Conqueror" (LFR)
    [89268] = true, -- "Gauntlets of the Shadowy Protector" (LFR)
    [89269] = true, -- "Gauntlets of the Shadowy Vanquisher" (LFR)
    
    [89270] = true, -- "Leggings of the Shadowy Conqueror" (LFR)
    [89271] = true, -- "Leggings of the Shadowy Protector" (LFR)
    [89272] = true, -- "Leggings of the Shadowy Vanquisher" (LFR)
    
    -- 普通难度代币 (Normal - 物品等级496)
    [89273] = true, -- "Helm of the Shadowy Conqueror" (Normal)
    [89274] = true, -- "Helm of the Shadowy Protector" (Normal)
    [89275] = true, -- "Helm of the Shadowy Vanquisher" (Normal)
    
    [89277] = true, -- "Shoulders of the Shadowy Conqueror" (Normal)
    [89278] = true, -- "Shoulders of the Shadowy Protector" (Normal)
    [89279] = true, -- "Shoulders of the Shadowy Vanquisher" (Normal)
    
    [89280] = true, -- "Chest of the Shadowy Conqueror" (Normal)
    [89281] = true, -- "Chest of the Shadowy Protector" (Normal)
    [89282] = true, -- "Chest of the Shadowy Vanquisher" (Normal)
    
    [89283] = true, -- "Gauntlets of the Shadowy Conqueror" (Normal)
    [89284] = true, -- "Gauntlets of the Shadowy Protector" (Normal)
    [89285] = true, -- "Gauntlets of the Shadowy Vanquisher" (Normal)
    
    [89286] = true, -- "Leggings of the Shadowy Conqueror" (Normal)
    [89287] = true, -- "Leggings of the Shadowy Protector" (Normal)
    [89288] = true, -- "Leggings of the Shadowy Vanquisher" (Normal)
    
    -- 英雄难度代币 (Heroic - 物品等级509) - 已确认
    [89258] = true, -- "Helm of the Shadowy Conqueror" (Heroic) - 恐惧之影掉落
    [89259] = true, -- "Helm of the Shadowy Protector" (Heroic) - 恐惧之影掉落
    [89260] = true, -- "Helm of the Shadowy Vanquisher" (Heroic) - 恐惧之影掉落
    
    [89261] = true, -- "Shoulders of the Shadowy Conqueror" (Heroic) - 恐惧之影掉落
    [89262] = true, -- "Shoulders of the Shadowy Protector" (Heroic) - 恐惧之影掉落
    [89263] = true, -- "Shoulders of the Shadowy Vanquisher" (Heroic) - 恐惧之影掉落
    
    [89250] = true, -- "Chest of the Shadowy Conqueror" (Heroic) - 大女皇希克兹拉掉落
    [89251] = true, -- "Chest of the Shadowy Protector" (Heroic) - 大女皇希克兹拉掉落
    [89266] = true, -- "Chest of the Shadowy Vanquisher" (Heroic) - 大女皇希克兹拉掉落
    
    [89256] = true, -- "Gauntlets of the Shadowy Conqueror" (Heroic) - 风领主梅尔加拉克掉落
    [89257] = true, -- "Gauntlets of the Shadowy Protector" (Heroic) - 风领主梅尔加拉克掉落
    [89255] = true, -- "Gauntlets of the Shadowy Vanquisher" (Heroic) - 风领主梅尔加拉克掉落
    
    [89253] = true, -- "Leggings of the Shadowy Conqueror" (Heroic) - 琥珀塑形者昂索克掉落
    [89254] = true, -- "Leggings of the Shadowy Protector" (Heroic) - 琥珀塑形者昂索克掉落
    [89252] = true, -- "Leggings of the Shadowy Vanquisher" (Heroic) - 琥珀塑形者昂索克掉落 
    
    -- T15 代币 (Crackling系列) - 雷电王座
    
    -- 随机团本代币 (LFR - 物品等级502)
    [95879] = true, -- "Helm of the Crackling Vanquisher" (LFR) - 陆琳和苏恩掉落
    [95880] = true, -- "Helm of the Crackling Conqueror" (LFR) - 陆琳和苏恩掉落
    [95881] = true, -- "Helm of the Crackling Protector" (LFR) - 陆琳和苏恩掉落
    
    [95955] = true, -- "Shoulders of the Crackling Vanquisher" (LFR) - 钢铁巨兽掉落
    [95956] = true, -- "Shoulders of the Crackling Conqueror" (LFR) - 钢铁巨兽掉落
    [95957] = true, -- "Shoulders of the Crackling Protector" (LFR) - 钢铁巨兽掊落
    
    [95822] = true, -- "Chest of the Crackling Vanquisher" (LFR) - 黑暗意志掉落
    [95823] = true, -- "Chest of the Crackling Conqueror" (LFR) - 黑暗意志掉落
    [95824] = true, -- "Chest of the Crackling Protector" (LFR) - 黑暗意志掉落
    
    [95855] = true, -- "Gauntlets of the Crackling Vanquisher" (LFR) - 长者议会掉落
    [95856] = true, -- "Gauntlets of the Crackling Conqueror" (LFR) - 长者议会掉落
    [95857] = true, -- "Gauntlets of the Crackling Protector" (LFR) - 长者议会掉落
    
    [95887] = true, -- "Leggings of the Crackling Vanquisher" (LFR) - 季昆掉落
    [95888] = true, -- "Leggings of the Crackling Conqueror" (LFR) - 季昆掉落
    [95889] = true, -- "Leggings of the Crackling Protector" (LFR) - 季昆掉落
    
    -- 普通难度代币 (Normal - 物品等级522)
    [95569] = true, -- "Helm of the Crackling Vanquisher" (Normal)
    [95570] = true, -- "Helm of the Crackling Conqueror" (Normal)
    [95571] = true, -- "Helm of the Crackling Protector" (Normal)
    
    [95566] = true, -- "Shoulders of the Crackling Vanquisher" (Normal)
    [95567] = true, -- "Shoulders of the Crackling Conqueror" (Normal)
    [95568] = true, -- "Shoulders of the Crackling Protector" (Normal)
    
    [95578] = true, -- "Chest of the Crackling Vanquisher" (Normal)
    [95579] = true, -- "Chest of the Crackling Conqueror" (Normal)
    [95580] = true, -- "Chest of the Crackling Protector" (Normal)
    
    [95572] = true, -- "Gauntlets of the Crackling Vanquisher" (Normal)
    [95573] = true, -- "Gauntlets of the Crackling Conqueror" (Normal)
    [95574] = true, -- "Gauntlets of the Crackling Protector" (Normal)
    
    [95575] = true, -- "Leggings of the Crackling Vanquisher" (Normal)
    [95576] = true, -- "Leggings of the Crackling Conqueror" (Normal)
    [95577] = true, -- "Leggings of the Crackling Protector" (Normal)
    
    -- 英雄难度代币 (Heroic - 物品等级535)
    [96600] = true, -- "Helm of the Crackling Vanquisher" (Heroic)
    [96601] = true, -- "Helm of the Crackling Conqueror" (Heroic)
    [96602] = true, -- "Helm of the Crackling Protector" (Heroic)
    
    [96597] = true, -- "Shoulders of the Crackling Vanquisher" (Heroic)
    [96598] = true, -- "Shoulders of the Crackling Conqueror" (Heroic)
    [96599] = true, -- "Shoulders of the Crackling Protector" (Heroic)
    
    [96609] = true, -- "Chest of the Crackling Vanquisher" (Heroic)
    [96610] = true, -- "Chest of the Crackling Conqueror" (Heroic)
    [96611] = true, -- "Chest of the Crackling Protector" (Heroic)
    
    [96603] = true, -- "Gauntlets of the Crackling Vanquisher" (Heroic)
    [96604] = true, -- "Gauntlets of the Crackling Conqueror" (Heroic)
    [96605] = true, -- "Gauntlets of the Crackling Protector" (Heroic)
    
    [96606] = true, -- "Leggings of the Crackling Vanquisher" (Heroic)
    [96607] = true, -- "Leggings of the Crackling Conqueror" (Heroic)
    [96608] = true, -- "Leggings of the Crackling Protector" (Heroic)
    
    -- T16 代币 (Cursed系列) - 围攻奥格瑞玛
    
    -- 精华代币 (Essence系列) - 加尔鲁什·地狱咆哮掉落的万能代币
    [105860] = true, -- "Essence of the Cursed Protector" (战士、猎人、萨满、武僧) - 掉落率11.57%
    [105861] = true, -- "Essence of the Cursed Conqueror" (圣骑士、牧师、术士) - 掉落率6.30%
    [105862] = true, -- "Essence of the Cursed Vanquisher" (死亡骑士、德鲁伊、法师、盗贼) - 掉落率6.71%
    [105863] = true, -- "Essence of the Cursed Protector" (战士、猎人、萨满、武僧) - 物品等级41, 掉落率1.85%
    [105864] = true, -- "Essence of the Cursed Conqueror" (圣骑士、牧师、术士) - 物品等级41, 掉落率1.82%
    [105865] = true, -- "Essence of the Cursed Vanquisher" (死亡骑士、德鲁伊、法师、盗贼) - 物品等级41, 掉落率1.71%
    [105857] = true, -- "Essence of the Cursed Protector" (战士、猎人、萨满、武僧) - 物品等级42, 掉落率7.28%
    [105858] = true, -- "Essence of the Cursed Conqueror" (圣骑士、牧师、术士) - 物品等级42
    [105859] = true, -- "Essence of the Cursed Vanquisher" (死亡骑士、德鲁伊、法师、盗贼) - 物品等级42, 掉落率6.71%
    [105867] = true, -- "Essence of the Cursed Conqueror" (圣骑士、牧师、术士) - 物品等级42, 掉落率7.78%
    [105868] = true, -- "Essence of the Cursed Vanquisher" (死亡骑士、德鲁伊、法师、盗贼) - 物品等级42, 掉落率9.45%
    [105866] = true, -- "Essence of the Cursed Protector" (战士、猎人、萨满、武僧) - 物品等级42, 掉落率11.57%
    -- 随机团本代币 (LFR - 物品等级528)
    -- 头盔代币
    [99671] = true, -- "Helm of the Cursed Vanquisher" (LFR)
    [99672] = true, -- "Helm of the Cursed Conqueror" (LFR)
    [99673] = true, -- "Helm of the Cursed Protector" (LFR)
    
    -- 护肩代币
    [99668] = true, -- "Shoulders of the Cursed Vanquisher" (LFR)
    [99669] = true, -- "Shoulders of the Cursed Conqueror" (LFR)
    [99670] = true, -- "Shoulders of the Cursed Protector" (LFR)
    
    -- 胸甲代币
    [99677] = true, -- "Chest of the Cursed Vanquisher" (LFR)
    [99678] = true, -- "Chest of the Cursed Conqueror" (LFR)
    [99676] = true, -- "Chest of the Cursed Protector" (LFR)
    
    -- 手套代币  
    [99680] = true, -- "Gauntlets of the Cursed Vanquisher" (LFR)
    [99681] = true, -- "Gauntlets of the Cursed Conqueror" (LFR)
    [99679] = true, -- "Gauntlets of the Cursed Protector" (LFR)
    
    -- 护腿代币
    [99674] = true, -- "Leggings of the Cursed Vanquisher" (LFR)
    [99675] = true, -- "Leggings of the Cursed Conqueror" (LFR)
    [99667] = true, -- "Leggings of the Cursed Protector" (LFR)
    
    -- 普通难度代币 (Normal - 物品等级540)
    -- 头盔代币
    [99683] = true, -- "Helm of the Cursed Vanquisher" (Normal)
    [99689] = true, -- "Helm of the Cursed Conqueror" (Normal)
    [99694] = true, -- "Helm of the Cursed Protector" (Normal)
    
    -- 护肩代币
    [99685] = true, -- "Shoulders of the Cursed Vanquisher" (Normal)
    [99690] = true, -- "Shoulders of the Cursed Conqueror" (Normal)
    [99695] = true, -- "Shoulders of the Cursed Protector" (Normal)
    
    -- 胸甲代币
    [99696] = true, -- "Chest of the Cursed Vanquisher" (Normal)
    [99686] = true, -- "Chest of the Cursed Conqueror" (Normal)
    [99697] = true, -- "Chest of the Cursed Protector" (Normal)
    
    -- 手套代币
    [99682] = true, -- "Gauntlets of the Cursed Vanquisher" (Normal)
    [99687] = true, -- "Gauntlets of the Cursed Conqueror" (Normal)
    [99684] = true, -- "Gauntlets of the Cursed Protector" (Normal)
    
    -- 护腿代币
    [99692] = true, -- "Leggings of the Cursed Vanquisher" (Normal)
    [99688] = true, -- "Leggings of the Cursed Conqueror" (Normal)
    [99693] = true, -- "Leggings of the Cursed Protector" (Normal)
    
    -- 英雄难度代币 (Heroic - 物品等级553)
    -- 头盔代币
    [99748] = true, -- "Helm of the Cursed Vanquisher" (Heroic)
    [99749] = true, -- "Helm of the Cursed Conqueror" (Heroic)
    [99725] = true, -- "Helm of the Cursed Protector" (Heroic)
    
    -- 护肩代币
    [99717] = true, -- "Shoulders of the Cursed Vanquisher" (Heroic)
    [99718] = true, -- "Shoulders of the Cursed Conqueror" (Heroic)
    [99752] = true, -- "Shoulders of the Cursed Protector" (Heroic)
    
    -- 胸甲代币
    [99714] = true, -- "Chest of the Cursed Vanquisher" (Heroic)
    [99746] = true, -- "Chest of the Cursed Conqueror" (Heroic)
    [99715] = true, -- "Chest of the Cursed Protector" (Heroic)
    
    -- 手套代币
    [99720] = true, -- "Gauntlets of the Cursed Vanquisher" (Heroic)
    [99721] = true, -- "Gauntlets of the Cursed Conqueror" (Heroic)
    [99750] = true, -- "Gauntlets of the Cursed Protector" (Heroic)
    
    -- 护腿代币
    [99751] = true, -- "Leggings of the Cursed Vanquisher" (Heroic)
    [99747] = true, -- "Leggings of the Cursed Conqueror" (Heroic)
    [99753] = true, -- "Leggings of the Cursed Protector" (Heroic)
    
    -- 史诗难度代币 (Mythic - 物品等级566)
    -- 头盔代币
    [99723] = true, -- "Helm of the Cursed Vanquisher" (Mythic)
    [99724] = true, -- "Helm of the Cursed Conqueror" (Mythic)
    [99756] = true, -- "Helm of the Cursed Protector" (Mythic)
    
    -- 护肩代币
    [99754] = true, -- "Shoulders of the Cursed Vanquisher" (Mythic)
    [99755] = true, -- "Shoulders of the Cursed Conqueror" (Mythic)
    [99757] = true, -- "Shoulders of the Cursed Protector" (Mythic)
    
    -- 胸甲代币
    [99758] = true, -- "Chest of the Cursed Vanquisher" (Mythic)
    [99759] = true, -- "Chest of the Cursed Conqueror" (Mythic)
    [99760] = true, -- "Chest of the Cursed Protector" (Mythic)
    
    -- 手套代币
    [99745] = true, -- "Gauntlets of the Cursed Vanquisher" (Mythic)
    [99761] = true, -- "Gauntlets of the Cursed Conqueror" (Mythic)
    [99762] = true, -- "Gauntlets of the Cursed Protector" (Mythic)
    
    -- 护腿代币
    [99763] = true, -- "Leggings of the Cursed Vanquisher" (Mythic)
    [99764] = true, -- "Leggings of the Cursed Conqueror" (Mythic)
    [99765] = true, -- "Leggings of the Cursed Protector" (Mythic)
    
    -- ========== WoD 德拉诺之王 (T17-T18) ==========
    -- T17 Iron系列代币 (黑石铸造厂)
    
    -- 普通难度代币 (Normal - 物品等级665)
    -- 头盔代币 (Kromog掉落)
    [119308] = true, -- "Helm of the Iron Conqueror" (Normal) - 圣骑士、牧师、术士
    [119321] = true, -- "Helm of the Iron Protector" (Normal) - 战士、猎人、萨满、武僧
    [119312] = true, -- "Helm of the Iron Vanquisher" (Normal) - 死亡骑士、德鲁伊、法师、盗贼
    
    -- 护肩代币 (Operator Thogar掉落)
    [119309] = true, -- "Shoulders of the Iron Conqueror" (Normal)
    [119322] = true, -- "Shoulders of the Iron Protector" (Normal)
    [119314] = true, -- "Shoulders of the Iron Vanquisher" (Normal)
    
    -- 胸甲代币 (Flamebender Ka'graz掉落)
    [120279] = true, -- "Chest of the Iron Conqueror" (Normal)
    [119318] = true, -- "Chest of the Iron Protector" (Normal)
    [120278] = true, -- "Chest of the Iron Vanquisher" (Normal)
    
    -- 手套代币 (The Iron Maidens掉落)
    [119306] = true, -- "Gauntlets of the Iron Conqueror" (Normal)
    [119319] = true, -- "Gauntlets of the Iron Protector" (Normal)
    [119311] = true, -- "Gauntlets of the Iron Vanquisher" (Normal)
    
    -- 护腿代币 (The Blast Furnace掉落)
    [119307] = true, -- "Leggings of the Iron Conqueror" (Normal)
    [119320] = true, -- "Leggings of the Iron Protector" (Normal)
    [119313] = true, -- "Leggings of the Iron Vanquisher" (Normal)
    
    -- 额外代币
    [120277] = true, -- "Extra Iron Protector Token" (Normal)
    [119305] = true, -- "Gauntlets of the Iron Conqueror" (Normal) - 备用ID
    [119315] = true, -- "Shoulders of the Iron Vanquisher" (Normal) - 备用ID
    
    -- 英雄难度代币 (Heroic - 物品等级680)
    -- 头盔代币
    [120215] = true, -- "Helm of the Iron Conqueror" (Heroic)
    [120255] = true, -- "Helm of the Iron Protector" (Heroic)
    [120233] = true, -- "Helm of the Iron Vanquisher" (Heroic)
    
    -- 护肩代币
    [120216] = true, -- "Shoulders of the Iron Conqueror" (Heroic)
    [120256] = true, -- "Shoulders of the Iron Protector" (Heroic)
    [120234] = true, -- "Shoulders of the Iron Vanquisher" (Heroic)
    
    -- 胸甲代币
    [120217] = true, -- "Chest of the Iron Conqueror" (Heroic)
    [120257] = true, -- "Chest of the Iron Protector" (Heroic)
    [120235] = true, -- "Chest of the Iron Vanquisher" (Heroic)
    
    -- 手套代币
    [120218] = true, -- "Gauntlets of the Iron Conqueror" (Heroic)
    [120258] = true, -- "Gauntlets of the Iron Protector" (Heroic)
    [120236] = true, -- "Gauntlets of the Iron Vanquisher" (Heroic)
    
    -- 护腿代币
    [120219] = true, -- "Leggings of the Iron Conqueror" (Heroic)
    [120259] = true, -- "Leggings of the Iron Protector" (Heroic)
    [120237] = true, -- "Leggings of the Iron Vanquisher" (Heroic)
    
    -- 史诗难度代币 (Mythic - 物品等级695)
    -- 头盔代币
    [120300] = true, -- "Helm of the Iron Conqueror" (Mythic)
    [120301] = true, -- "Helm of the Iron Protector" (Mythic)
    [120302] = true, -- "Helm of the Iron Vanquisher" (Mythic)
    
    -- 护肩代币
    [120303] = true, -- "Shoulders of the Iron Conqueror" (Mythic)
    [120304] = true, -- "Shoulders of the Iron Protector" (Mythic)
    [120305] = true, -- "Shoulders of the Iron Vanquisher" (Mythic)
    
    -- 胸甲代币
    [120306] = true, -- "Chest of the Iron Conqueror" (Mythic)
    [120307] = true, -- "Chest of the Iron Protector" (Mythic)
    [120308] = true, -- "Chest of the Iron Vanquisher" (Mythic)
    
    -- 手套代币
    [120309] = true, -- "Gauntlets of the Iron Conqueror" (Mythic)
    [120310] = true, -- "Gauntlets of the Iron Protector" (Mythic)
    [120311] = true, -- "Gauntlets of the Iron Vanquisher" (Mythic)
    
    -- 护腿代币
    [120312] = true, -- "Leggings of the Iron Conqueror" (Mythic)
    [120313] = true, -- "Leggings of the Iron Protector" (Mythic)
    [120314] = true, -- "Leggings of the Iron Vanquisher" (Mythic)
    
    -- T18 Fel-Touched系列代币 (地狱火堡垒) - 需要验证具体ID
    -- 注意：以下ID需要进一步验证
    -- [124297] = true, -- "Fel-Touched Token"
    -- [124298] = true, -- "Fel-Touched Token"
    -- [124299] = true, -- "Fel-Touched Token"
    
    -- ========== Legion 军团再临 (T19-T21) ==========
    -- Legion时期主要是直接掉落套装，代币系统较少使用
    -- 注意：Legion大部分套装通过直接掉落获得，而非代币系统
    
    -- 以下代币ID需要进一步验证：
    -- T20 萨格拉斯之墓可能的代币
    -- [147104] = true, -- 需要验证的代币ID
    -- [147105] = true, -- 需要验证的代币ID  
    -- [147106] = true, -- 需要验证的代币ID
    
    -- T21 安托罗斯燃烧王座可能的代币
    -- [152056] = true, -- 需要验证的代币ID
    -- [152057] = true, -- 需要验证的代币ID
    -- [152058] = true, -- 需要验证的代币ID
    
    -- ========== BfA 争霸艾泽拉斯 ==========
    -- BfA时期主要使用泰坦残渣(Titan Residuum)货币系统，而非传统代币
    -- 泰坦残渣货币ID: 1718 (这是货币而非物品)
    -- 注意：BfA没有传统的套装代币系统，主要通过泰坦残渣购买艾泽里特装备
    
    -- 以下ID无法验证，暂时注释：
    -- [165824] = true, -- "Azerite Token" (需要验证)
    -- [165825] = true, -- "Titan Residuum"相关代币 (需要验证)
    -- [165515] = true, -- "Uldir 奥迪尔代币" (需要验证)
    -- [165523] = true, -- "Battle of Dazar'alor 达萨罗之战代币" (需要验证)
    
    -- ========== Shadowlands 暗影国度 ==========
    
    -- 纳斯利亚堡武器代币 (Castle Nathria)
    -- 随机团本代币 (LFR - 物品等级187-194)
    [183890] = true, -- "Zenith Anima Spherule" (LFR) - 武僧、盗贼、战士
    [183899] = true, -- "Zenith Anima Spherule" (LFR) - 备用ID
    [183894] = true, -- "Thaumaturgic Anima Bead" (LFR) - 盾牌/副手代币
    [183889] = true, -- "Thaumaturgic Anima Bead" (LFR) - 备用ID
    [183891] = true, -- "Venerated Anima Spherule" (LFR) - 圣骑士、牧师、萨满
    [183898] = true, -- "Venerated Anima Spherule" (LFR) - 备用ID
    [183893] = true, -- "Abominable Anima Spherule" (LFR) - 死骑、术士、恶魔猎手
    [183896] = true, -- "Abominable Anima Spherule" (LFR) - 备用ID
    [183888] = true, -- "Mystic Anima Spherule" (LFR) - 德鲁伊、猎人、法师
    [183895] = true, -- "Apogee Anima Bead" (LFR) - 盾牌代币
    [183892] = true, -- "Mystic Anima Spherule" (LFR) - 备用ID
    [183897] = true, -- "Apogee Anima Bead" (LFR) - 备用ID
    
    -- 普通难度代币 (Normal - 物品等级200-207)
    [184001] = true, -- "Zenith Anima Spherule" (Normal)
    [184002] = true, -- "Venerated Anima Spherule" (Normal)
    [184003] = true, -- "Abominable Anima Spherule" (Normal)
    [184004] = true, -- "Mystic Anima Spherule" (Normal)
    [184005] = true, -- "Thaumaturgic Anima Bead" (Normal)
    [184006] = true, -- "Apogee Anima Bead" (Normal)
    
    -- 英雄难度代币 (Heroic - 物品等级213-219)
    [184011] = true, -- "Zenith Anima Spherule" (Heroic)
    [184012] = true, -- "Venerated Anima Spherule" (Heroic)
    [184013] = true, -- "Abominable Anima Spherule" (Heroic)
    [184014] = true, -- "Mystic Anima Spherule" (Heroic)
    [184015] = true, -- "Thaumaturgic Anima Bead" (Heroic)
    [184016] = true, -- "Apogee Anima Bead" (Heroic)
    
    -- 史诗难度代币 (Mythic - 物品等级226-233)
    [184021] = true, -- "Zenith Anima Spherule" (Mythic)
    [184022] = true, -- "Venerated Anima Spherule" (Mythic)
    [184023] = true, -- "Abominable Anima Spherule" (Mythic)
    [184024] = true, -- "Mystic Anima Spherule" (Mythic)
    [184025] = true, -- "Thaumaturgic Anima Bead" (Mythic)
    [184026] = true, -- "Apogee Anima Bead" (Mythic)
    
    -- 初诞者圣墓套装代币 (Sepulcher of the First Ones)
    -- 随机团本代币 (LFR - 物品等级239-246)
    -- Zenith模块 (武僧、盗贼、战士)
    [191004] = true, -- "Zenith Helm Module" (LFR)
    [191017] = true, -- "Zenith Hand Module" (LFR)
    [191009] = true, -- "Zenith Shoulder Module" (LFR)
    [191013] = true, -- "Zenith Chest Module" (LFR)
    [191021] = true, -- "Zenith Leg Module" (LFR)
    
    -- Venerated模块 (圣骑士、牧师、萨满)
    [191003] = true, -- "Venerated Helm Module" (LFR)
    [191016] = true, -- "Venerated Hand Module" (LFR)
    [191008] = true, -- "Venerated Shoulder Module" (LFR)
    [191012] = true, -- "Venerated Chest Module" (LFR)
    [191020] = true, -- "Venerated Leg Module" (LFR)
    
    -- Mystic模块 (德鲁伊、猎人、法师)
    [191005] = true, -- "Mystic Helm Module" (LFR)
    [191014] = true, -- "Mystic Hand Module" (LFR)
    [191006] = true, -- "Mystic Shoulder Module" (LFR)
    [191010] = true, -- "Mystic Chest Module" (LFR)
    [191018] = true, -- "Mystic Leg Module" (LFR)
    
    -- Dreadful模块 (死骑、术士、恶魔猎手)
    [191002] = true, -- "Dreadful Helm Module" (LFR)
    [191015] = true, -- "Dreadful Hand Module" (LFR)
    [191007] = true, -- "Dreadful Shoulder Module" (LFR)
    [191011] = true, -- "Dreadful Chest Module" (LFR)
    [191019] = true, -- "Dreadful Leg Module" (LFR)
    
    -- 普通难度代币 (Normal - 物品等级252)
    -- Zenith模块
    [191104] = true, -- "Zenith Helm Module" (Normal)
    [191117] = true, -- "Zenith Hand Module" (Normal)
    [191109] = true, -- "Zenith Shoulder Module" (Normal)
    [191113] = true, -- "Zenith Chest Module" (Normal)
    [191121] = true, -- "Zenith Leg Module" (Normal)
    
    -- Venerated模块
    [191103] = true, -- "Venerated Helm Module" (Normal)
    [191116] = true, -- "Venerated Hand Module" (Normal)
    [191108] = true, -- "Venerated Shoulder Module" (Normal)
    [191112] = true, -- "Venerated Chest Module" (Normal)
    [191120] = true, -- "Venerated Leg Module" (Normal)
    
    -- Mystic模块
    [191105] = true, -- "Mystic Helm Module" (Normal)
    [191114] = true, -- "Mystic Hand Module" (Normal)
    [191106] = true, -- "Mystic Shoulder Module" (Normal)
    [191110] = true, -- "Mystic Chest Module" (Normal)
    [191118] = true, -- "Mystic Leg Module" (Normal)
    
    -- Dreadful模块
    [191102] = true, -- "Dreadful Helm Module" (Normal)
    [191115] = true, -- "Dreadful Hand Module" (Normal)
    [191107] = true, -- "Dreadful Shoulder Module" (Normal)
    [191111] = true, -- "Dreadful Chest Module" (Normal)
    [191119] = true, -- "Dreadful Leg Module" (Normal)
    
    -- 英雄难度代币 (Heroic - 物品等级265)
    -- Zenith模块
    [191204] = true, -- "Zenith Helm Module" (Heroic)
    [191217] = true, -- "Zenith Hand Module" (Heroic)
    [191209] = true, -- "Zenith Shoulder Module" (Heroic)
    [191213] = true, -- "Zenith Chest Module" (Heroic)
    [191221] = true, -- "Zenith Leg Module" (Heroic)
    
    -- Venerated模块
    [191203] = true, -- "Venerated Helm Module" (Heroic)
    [191216] = true, -- "Venerated Hand Module" (Heroic)
    [191208] = true, -- "Venerated Shoulder Module" (Heroic)
    [191212] = true, -- "Venerated Chest Module" (Heroic)
    [191220] = true, -- "Venerated Leg Module" (Heroic)
    
    -- Mystic模块
    [191205] = true, -- "Mystic Helm Module" (Heroic)
    [191214] = true, -- "Mystic Hand Module" (Heroic)
    [191206] = true, -- "Mystic Shoulder Module" (Heroic)
    [191210] = true, -- "Mystic Chest Module" (Heroic)
    [191218] = true, -- "Mystic Leg Module" (Heroic)
    
    -- Dreadful模块
    [191202] = true, -- "Dreadful Helm Module" (Heroic)
    [191215] = true, -- "Dreadful Hand Module" (Heroic)
    [191207] = true, -- "Dreadful Shoulder Module" (Heroic)
    [191211] = true, -- "Dreadful Chest Module" (Heroic)
    [191219] = true, -- "Dreadful Leg Module" (Heroic)
    
    -- 史诗难度代币 (Mythic - 物品等级278)
    -- Zenith模块
    [191304] = true, -- "Zenith Helm Module" (Mythic)
    [191317] = true, -- "Zenith Hand Module" (Mythic)
    [191309] = true, -- "Zenith Shoulder Module" (Mythic)
    [191313] = true, -- "Zenith Chest Module" (Mythic)
    [191321] = true, -- "Zenith Leg Module" (Mythic)
    
    -- Venerated模块
    [191303] = true, -- "Venerated Helm Module" (Mythic)
    [191316] = true, -- "Venerated Hand Module" (Mythic)
    [191308] = true, -- "Venerated Shoulder Module" (Mythic)
    [191312] = true, -- "Venerated Chest Module" (Mythic)
    [191320] = true, -- "Venerated Leg Module" (Mythic)
    
    -- Mystic模块
    [191305] = true, -- "Mystic Helm Module" (Mythic)
    [191314] = true, -- "Mystic Hand Module" (Mythic)
    [191306] = true, -- "Mystic Shoulder Module" (Mythic)
    [191310] = true, -- "Mystic Chest Module" (Mythic)
    [191318] = true, -- "Mystic Leg Module" (Mythic)
    
    -- Dreadful模块
    [191302] = true, -- "Dreadful Helm Module" (Mythic)
    [191315] = true, -- "Dreadful Hand Module" (Mythic)
    [191307] = true, -- "Dreadful Shoulder Module" (Mythic)
    [191311] = true, -- "Dreadful Chest Module" (Mythic)
    [191319] = true, -- "Dreadful Leg Module" (Mythic)
    
    -- ========== Dragonflight 巨龙时代 ==========
    
    
    -- ========== War Within 地心之战 ==========
    -- War Within代币系统确认存在，但具体ID需要验证
    -- 代币类型：Dreadful, Mystic, Venerated, Zenith
    -- 部位：Conniver's Badge(头盔), Blasphemer's Effigy(胸甲), Stalwart's Emblem(手套), 
    --       Slayer's Icon(腿甲), Protector's Insignia(护肩)
    -- 特殊：Web-Wrapped Curio (全能代币，来自安苏雷克女王)
    
    -- 注意：以下所有ID都是推测的，需要在游戏中实际验证后再添加
    -- 建议在获得确切ID后再取消注释
    
    -- 头部代币 - Conniver's Badge
    -- [待验证ID] = true, -- "Dreadful Conniver's Badge"
    -- [待验证ID] = true, -- "Mystic Conniver's Badge"  
    -- [待验证ID] = true, -- "Venerated Conniver's Badge"
    -- [待验证ID] = true, -- "Zenith Conniver's Badge"
    
    -- 其他部位代币ID待验证...
}

-- 代币关键词列表（仅用于职业匹配，不用于物品识别）
TIER_SET_KEYWORDS = {
    -- 职业代币类型关键词（用于职业匹配）
    "Dreadful", "Mystic", "Venerated", "Zenith",
    "Conqueror", "Protector", "Vanquisher"
}

-- 职业代币类型映射表
PLAYER_CLASS_TOKEN_MAPPING = {
    ["DEATHKNIGHT"] = {"Dreadful", "Vanquisher"},
    ["DEMONHUNTER"] = {"Dreadful"},
    ["DRUID"] = {"Mystic", "Vanquisher"},
    ["EVOKER"] = {"Zenith"},
    ["HUNTER"] = {"Mystic", "Protector"},
    ["MAGE"] = {"Mystic", "Vanquisher"},
    ["MONK"] = {"Zenith", "Protector"},
    ["PALADIN"] = {"Venerated", "Conqueror"},
    ["PRIEST"] = {"Venerated", "Conqueror"},
    ["ROGUE"] = {"Zenith", "Vanquisher"},
    ["SHAMAN"] = {"Venerated", "Protector"},
    ["WARLOCK"] = {"Dreadful", "Conqueror"},
    ["WARRIOR"] = {"Zenith", "Protector"}
}

-- 中英文代币关键词映射表
TOKEN_KEYWORDS_MAPPING = {
    -- 英文关键词
    ["Dreadful"] = {"Dreadful", "恐惧", "恐怖"},
    ["Mystic"] = {"Mystic", "神秘", "奥术"},
    ["Venerated"] = {"Venerated", "受崇敬", "神圣"},
    ["Zenith"] = {"Zenith", "巅峰", "顶点"},
    ["Conqueror"] = {"Conqueror", "征服者", "征服"},
    ["Protector"] = {"Protector", "防护者", "保护者"},
    ["Vanquisher"] = {"Vanquisher", "破坏者", "碾压者", "毁灭者"}
}

-- 新增：精确的ID到代币类型映射表（解决本地化问题）
ITEM_ID_TO_TOKEN_TYPE = {
    -- ========== TBC 燃烧的远征 (T4-T6) ==========
    -- T4 Fallen Champion (圣骑士、盗贼、萨满)
    [29754] = "Champion", [29757] = "Champion", [29760] = "Champion", [29763] = "Champion",
    -- T4 Fallen Defender (战士、牧师、德鲁伊)
    [29753] = "Defender", [29758] = "Defender", [29761] = "Defender", [29764] = "Defender",
    -- T4 Fallen Hero (猎人、法师、术士)
    [29755] = "Hero", [29756] = "Hero", [29759] = "Hero", [29762] = "Hero",
    
    -- T5 Vanquished Champion
    [30236] = "Champion", [30237] = "Champion", [30240] = "Champion", [30241] = "Champion", [30243] = "Champion",
    -- T5 Vanquished Defender
    [30242] = "Defender", [30244] = "Defender", [30245] = "Defender", [30246] = "Defender", [30247] = "Defender",
    -- T5 Vanquished Hero
    [30238] = "Hero", [30239] = "Hero", [30248] = "Hero", [30249] = "Hero", [30250] = "Hero",
    
    -- T6 Forgotten Conqueror (圣骑士、牧师、术士)
    [31089] = "Conqueror", [31092] = "Conqueror", [31095] = "Conqueror", [31098] = "Conqueror", [31101] = "Conqueror",
    -- T6 Forgotten Protector (战士、猎人、萨满)
    [31091] = "Protector", [31094] = "Protector", [31097] = "Protector", [31100] = "Protector", [31103] = "Protector",
    -- T6 Forgotten Vanquisher (盗贼、法师、德鲁伊)
    [31090] = "Vanquisher", [31093] = "Vanquisher", [31096] = "Vanquisher", [31099] = "Vanquisher", [31102] = "Vanquisher",

    -- ========== WOTLK 巫妖王之怒 (T7-T10) ==========
    -- T7 Lost系列
    [40610] = "Conqueror", [40611] = "Protector", [40612] = "Vanquisher",
    [40613] = "Conqueror", [40614] = "Protector", [40615] = "Vanquisher",
    
    -- T8 Wayward系列
    [45635] = "Conqueror", [45636] = "Protector", [45637] = "Vanquisher",
    [45638] = "Conqueror", [45639] = "Protector", [45640] = "Vanquisher",
    
    -- T9 代币
    [47242] = "Trophy", [47556] = "Orb", [49426] = "Emblem", [49427] = "Emblem",
    
    -- T10 Sanctification系列
    [52025] = "Vanquisher", [52026] = "Protector", [52027] = "Conqueror",
    [52028] = "Vanquisher", [52029] = "Protector", [52030] = "Conqueror",

    -- ========== Cataclysm 大地的裂变 (T11-T13) ==========
    -- T11 Forlorn系列
    [67423] = "Conqueror", [67424] = "Protector", [67425] = "Vanquisher",
    [67426] = "Conqueror", [67427] = "Protector", [67428] = "Vanquisher",
    [67429] = "Conqueror", [67430] = "Protector", [67431] = "Vanquisher",
    [67432] = "Conqueror", [67433] = "Protector", [67434] = "Vanquisher",
    [67435] = "Conqueror", [67436] = "Protector", [67437] = "Vanquisher",

    -- T12 Fiery系列
    [71668] = "Conqueror", [71669] = "Protector", [71670] = "Vanquisher",
    [71671] = "Conqueror", [71672] = "Protector", [71673] = "Vanquisher",
    [71674] = "Conqueror", [71675] = "Protector", [71676] = "Vanquisher",
    [71677] = "Conqueror", [71678] = "Protector", [71679] = "Vanquisher",
    [71680] = "Conqueror", [71681] = "Protector", [71682] = "Vanquisher",

    -- T13 Corrupted系列
    [78847] = "Conqueror", [78848] = "Protector", [78849] = "Vanquisher",
    [78850] = "Conqueror", [78851] = "Protector", [78852] = "Vanquisher",
    [78853] = "Conqueror", [78854] = "Protector", [78855] = "Vanquisher",
    [78856] = "Conqueror", [78857] = "Protector", [78858] = "Vanquisher",
    [78859] = "Conqueror", [78860] = "Protector", [78861] = "Vanquisher",

    -- ========== MoP 熊猫人之谜 (T14-T16) ==========
    -- T14 Shadowy系列 (LFR)
    [89235] = "Conqueror", [89236] = "Protector", [89234] = "Vanquisher",
    [89249] = "Conqueror", [89248] = "Protector", [89247] = "Vanquisher",
    [89244] = "Conqueror", [89243] = "Protector", [89242] = "Vanquisher",
    [89241] = "Conqueror", [89240] = "Protector", [89239] = "Vanquisher",
    [89238] = "Conqueror", [89237] = "Protector", [89246] = "Vanquisher",

    -- T14 Shadowy系列 (Normal)
    [89258] = "Conqueror", [89259] = "Protector", [89260] = "Vanquisher",
    [89267] = "Conqueror", [89268] = "Protector", [89269] = "Vanquisher",
    [89270] = "Conqueror", [89271] = "Protector", [89272] = "Vanquisher",
    [89273] = "Conqueror", [89274] = "Protector", [89275] = "Vanquisher",
    [89276] = "Conqueror", [89277] = "Protector", [89278] = "Vanquisher",

    -- T14 Shadowy系列 (Heroic)
    [89261] = "Conqueror", [89262] = "Protector", [89263] = "Vanquisher",
    [89250] = "Conqueror", [89251] = "Protector", [89266] = "Vanquisher",
    [89256] = "Conqueror", [89257] = "Protector", [89255] = "Vanquisher",
    [89253] = "Conqueror", [89254] = "Protector", [89252] = "Vanquisher",

    -- T15 Crackling系列 (LFR)
    [95879] = "Vanquisher", [95880] = "Conqueror", [95881] = "Protector",
    [95955] = "Vanquisher", [95956] = "Conqueror", [95957] = "Protector",
    [95822] = "Vanquisher", [95823] = "Conqueror", [95824] = "Protector",
    [95855] = "Vanquisher", [95856] = "Conqueror", [95857] = "Protector",
    [95887] = "Vanquisher", [95888] = "Conqueror", [95889] = "Protector",

    -- T15 Crackling系列 (Normal)
    [95569] = "Vanquisher", [95570] = "Conqueror", [95571] = "Protector",
    [95566] = "Vanquisher", [95567] = "Conqueror", [95568] = "Protector",
    [95578] = "Vanquisher", [95579] = "Conqueror", [95580] = "Protector",
    [95572] = "Vanquisher", [95573] = "Conqueror", [95574] = "Protector",
    [95575] = "Vanquisher", [95576] = "Conqueror", [95577] = "Protector",

    -- T15 Crackling系列 (Heroic)
    [96600] = "Vanquisher", [96601] = "Conqueror", [96602] = "Protector",
    [96597] = "Vanquisher", [96598] = "Conqueror", [96599] = "Protector",
    [96609] = "Vanquisher", [96610] = "Conqueror", [96611] = "Protector",
    [96603] = "Vanquisher", [96604] = "Conqueror", [96605] = "Protector",
    [96606] = "Vanquisher", [96607] = "Conqueror", [96608] = "Protector",

    -- T16 Cursed系列精华代币 - 完整映射
    [105860] = "Protector", [105861] = "Conqueror", [105862] = "Vanquisher",
    [105863] = "Protector", [105864] = "Conqueror", [105865] = "Vanquisher",
    [105857] = "Protector", [105858] = "Conqueror", [105859] = "Vanquisher",
    [105867] = "Conqueror", [105868] = "Vanquisher", [105866] = "Protector",
    

    -- T16 Cursed系列 (LFR)
    [99671] = "Vanquisher", [99672] = "Conqueror", [99673] = "Protector",
    [99668] = "Vanquisher", [99669] = "Conqueror", [99670] = "Protector",
    [99677] = "Vanquisher", [99678] = "Conqueror", [99676] = "Protector",
    [99680] = "Vanquisher", [99681] = "Conqueror", [99679] = "Protector",
    [99674] = "Vanquisher", [99675] = "Conqueror", [99667] = "Protector",

    -- T16 Cursed系列 (Normal)
    [99683] = "Vanquisher", [99689] = "Conqueror", [99694] = "Protector",
    [99685] = "Vanquisher", [99690] = "Conqueror", [99695] = "Protector",
    [99696] = "Vanquisher", [99686] = "Conqueror", [99697] = "Protector",
    [99682] = "Vanquisher", [99687] = "Conqueror", [99684] = "Protector",
    [99692] = "Vanquisher", [99688] = "Conqueror", [99693] = "Protector",

    -- T16 Cursed系列 (Heroic)
    [99748] = "Vanquisher", [99749] = "Conqueror", [99725] = "Protector",
    [99717] = "Vanquisher", [99718] = "Conqueror", [99752] = "Protector",
    [99714] = "Vanquisher", [99746] = "Conqueror", [99715] = "Protector",
    [99720] = "Vanquisher", [99721] = "Conqueror", [99750] = "Protector",
    [99751] = "Vanquisher", [99747] = "Conqueror", [99753] = "Protector",

    -- T16 Cursed系列 (Mythic)
    [99723] = "Vanquisher", [99724] = "Conqueror", [99756] = "Protector",
    [99754] = "Vanquisher", [99755] = "Conqueror", [99757] = "Protector",
    [99758] = "Vanquisher", [99759] = "Conqueror", [99760] = "Protector",
    [99745] = "Vanquisher", [99761] = "Conqueror", [99762] = "Protector",
    [99763] = "Vanquisher", [99764] = "Conqueror", [99765] = "Protector",

    -- ========== WoD 德拉诺之王 (T17) ==========
    -- T17 Iron系列 (Normal)
    [119308] = "Conqueror", [119321] = "Protector", [119312] = "Vanquisher",
    [119309] = "Conqueror", [119322] = "Protector", [119314] = "Vanquisher",
    [120279] = "Conqueror", [119318] = "Protector", [120278] = "Vanquisher",
    [119306] = "Conqueror", [119319] = "Protector", [119311] = "Vanquisher",
    [119307] = "Conqueror", [119320] = "Protector", [119313] = "Vanquisher",
    [120277] = "Protector", [119305] = "Conqueror", [119315] = "Vanquisher",

    -- T17 Iron系列 (Heroic)
    [120215] = "Conqueror", [120255] = "Protector", [120233] = "Vanquisher",
    [120216] = "Conqueror", [120256] = "Protector", [120234] = "Vanquisher",
    [120217] = "Conqueror", [120257] = "Protector", [120235] = "Vanquisher",
    [120218] = "Conqueror", [120258] = "Protector", [120236] = "Vanquisher",
    [120219] = "Conqueror", [120259] = "Protector", [120237] = "Vanquisher",

    -- T17 Iron系列 (Mythic)
    [120300] = "Conqueror", [120301] = "Protector", [120302] = "Vanquisher",
    [120303] = "Conqueror", [120304] = "Protector", [120305] = "Vanquisher",
    [120306] = "Conqueror", [120307] = "Protector", [120308] = "Vanquisher",
    [120309] = "Conqueror", [120310] = "Protector", [120311] = "Vanquisher",
    [120312] = "Conqueror", [120313] = "Protector", [120314] = "Vanquisher",

    -- ========== Shadowlands 暗影国度 ==========
    -- 纳斯利亚堡武器代币 (LFR)
    [183890] = "Zenith", [183899] = "Zenith", [183891] = "Venerated", [183898] = "Venerated",
    [183893] = "Dreadful", [183896] = "Dreadful", [183888] = "Mystic", [183892] = "Mystic",
    [183894] = "Shield", [183889] = "Shield", [183895] = "Shield", [183897] = "Shield",

    -- 纳斯利亚堡武器代币 (Normal)
    [184001] = "Zenith", [184002] = "Venerated", [184003] = "Dreadful", [184004] = "Mystic",
    [184005] = "Shield", [184006] = "Shield",

    -- 纳斯利亚堡武器代币 (Heroic)
    [184011] = "Zenith", [184012] = "Venerated", [184013] = "Dreadful", [184014] = "Mystic",
    [184015] = "Shield", [184016] = "Shield",

    -- 纳斯利亚堡武器代币 (Mythic)
    [184021] = "Zenith", [184022] = "Venerated", [184023] = "Dreadful", [184024] = "Mystic",
    [184025] = "Shield", [184026] = "Shield",

    -- 初诞者圣墓套装代币 (LFR)
    [191004] = "Zenith", [191017] = "Zenith", [191009] = "Zenith", [191013] = "Zenith", [191021] = "Zenith",
    [191003] = "Venerated", [191016] = "Venerated", [191008] = "Venerated", [191012] = "Venerated", [191020] = "Venerated",
    [191005] = "Mystic", [191014] = "Mystic", [191006] = "Mystic", [191010] = "Mystic", [191018] = "Mystic",
    [191002] = "Dreadful", [191015] = "Dreadful", [191007] = "Dreadful", [191011] = "Dreadful", [191019] = "Dreadful",

    -- 初诞者圣墓套装代币 (Normal)
    [191104] = "Zenith", [191117] = "Zenith", [191109] = "Zenith", [191113] = "Zenith", [191121] = "Zenith",
    [191103] = "Venerated", [191116] = "Venerated", [191108] = "Venerated", [191112] = "Venerated", [191120] = "Venerated",
    [191105] = "Mystic", [191114] = "Mystic", [191106] = "Mystic", [191110] = "Mystic", [191118] = "Mystic",
    [191102] = "Dreadful", [191115] = "Dreadful", [191107] = "Dreadful", [191111] = "Dreadful", [191119] = "Dreadful",

    -- 初诞者圣墓套装代币 (Heroic)
    [191204] = "Zenith", [191217] = "Zenith", [191209] = "Zenith", [191213] = "Zenith", [191221] = "Zenith",
    [191203] = "Venerated", [191216] = "Venerated", [191208] = "Venerated", [191212] = "Venerated", [191220] = "Venerated",
    [191205] = "Mystic", [191214] = "Mystic", [191206] = "Mystic", [191210] = "Mystic", [191218] = "Mystic",
    [191202] = "Dreadful", [191215] = "Dreadful", [191207] = "Dreadful", [191211] = "Dreadful", [191219] = "Dreadful",

    -- 初诞者圣墓套装代币 (Mythic)
    [191304] = "Zenith", [191317] = "Zenith", [191309] = "Zenith", [191313] = "Zenith", [191321] = "Zenith",
    [191303] = "Venerated", [191316] = "Venerated", [191308] = "Venerated", [191312] = "Venerated", [191320] = "Venerated",
    [191305] = "Mystic", [191314] = "Mystic", [191306] = "Mystic", [191310] = "Mystic", [191318] = "Mystic",
    [191302] = "Dreadful", [191315] = "Dreadful", [191307] = "Dreadful", [191311] = "Dreadful", [191319] = "Dreadful",

    -- ========== Dragonflight 巨龙时代 ==========
    -- Dreadful代币系列
    [193001] = "Dreadful", [193002] = "Dreadful", [193003] = "Dreadful", [193004] = "Dreadful", [193005] = "Dreadful",
    -- Mystic代币系列
    [193011] = "Mystic", [193012] = "Mystic", [193013] = "Mystic", [193014] = "Mystic", [193015] = "Mystic",
    -- Venerated代币系列
    [193021] = "Venerated", [193022] = "Venerated", [193023] = "Venerated", [193024] = "Venerated", [193025] = "Venerated",
    -- Zenith代币系列
    [193031] = "Zenith", [193032] = "Zenith", [193033] = "Zenith", [193034] = "Zenith", [193035] = "Zenith",

    -- 特殊代币
    [198625] = "Universal", [198626] = "Universal"
}

-- 中文关键词映射表
CHINESE_TOKEN_KEYWORDS = {
    ["Vanquisher"] = {"破坏者", "碾压者", "毁灭者"},
    ["Protector"] = {"防护者", "守护者", "保护者"},
    ["Conqueror"] = {"征服者", "胜利者"},
    ["Dreadful"] = {"恐惧", "可怖", "恐怖"},
    ["Mystic"] = {"神秘", "奥秘", "神秘主义"},
    ["Venerated"] = {"受尊敬", "崇敬", "受崇敬"},
    ["Zenith"] = {"顶点", "极点", "巅峰"},
    ["Champion"] = {"冠军", "英雄"},
    ["Defender"] = {"防御者", "守护者"},
    ["Hero"] = {"英雄", "勇士"},
    ["Shield"] = {"盾牌", "副手"},
    ["Universal"] = {"通用", "全能"}
}

-- 代币类型到职业映射表
TOKEN_TYPE_TO_CLASSES = {
    -- TBC系统
    ["Champion"] = {"PALADIN", "ROGUE", "SHAMAN"},
    ["Defender"] = {"WARRIOR", "PRIEST", "DRUID"},
    ["Hero"] = {"HUNTER", "MAGE", "WARLOCK"},
    
    -- WOTLK/Cata/MoP/WoD系统
    ["Conqueror"] = {"PALADIN", "PRIEST", "WARLOCK"},
    ["Protector"] = {"WARRIOR", "HUNTER", "SHAMAN", "MONK"},
    ["Vanquisher"] = {"ROGUE", "DEATHKNIGHT", "MAGE", "DRUID"},
    
    -- Shadowlands/Dragonflight系统
    ["Dreadful"] = {"DEATHKNIGHT", "WARLOCK", "DEMONHUNTER"},
    ["Mystic"] = {"DRUID", "HUNTER", "MAGE"},
    ["Venerated"] = {"PALADIN", "PRIEST", "SHAMAN"},
    ["Zenith"] = {"WARRIOR", "ROGUE", "MONK", "EVOKER"},
    
    -- 特殊类型
    ["Shield"] = {"WARRIOR", "PALADIN", "PRIEST", "MONK", "SHAMAN", "MAGE", "WARLOCK", "DRUID"},
    ["Universal"] = {"WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "DEATHKNIGHT", "SHAMAN", "MAGE", "WARLOCK", "MONK", "DEMONHUNTER", "DRUID", "EVOKER"},
    ["Trophy"] = {"ALL"},
    ["Orb"] = {"ALL"},
    ["Emblem"] = {"ALL"}
}

-- 部位类型映射表
SLOT_TYPE_MAPPING = {
    -- 头部
    ["Helm"] = "HEAD", ["Crown"] = "HEAD", ["Helmet"] = "HEAD",
    -- 肩膀
    ["Shoulders"] = "SHOULDER", ["Pauldrons"] = "SHOULDER", ["Mantle"] = "SHOULDER",
    -- 胸部
    ["Chest"] = "CHEST", ["Chestguard"] = "CHEST", ["Breastplate"] = "CHEST",
    -- 手套
    ["Gloves"] = "HANDS", ["Gauntlets"] = "HANDS", ["Hands"] = "HANDS",
    -- 腿部
    ["Legs"] = "LEGS", ["Leggings"] = "LEGS", ["Legguards"] = "LEGS",
    -- 武器
    ["Weapon"] = "WEAPON", ["Spherule"] = "WEAPON",
    -- 盾牌/副手
    ["Shield"] = "OFFHAND", ["Bead"] = "OFFHAND"
}

-- 难度等级映射表
DIFFICULTY_MAPPING = {
    ["LFR"] = 1,
    ["Normal"] = 2,
    ["Heroic"] = 3,
    ["Mythic"] = 4
}

-- 扩展版本映射表
EXPANSION_MAPPING = {
    [29754] = "TBC", [30236] = "TBC", [31089] = "TBC",    -- TBC范围
    [40610] = "WOTLK", [45635] = "WOTLK", [52025] = "WOTLK",  -- WOTLK范围
    [67423] = "CATA", [71668] = "CATA", [78847] = "CATA",     -- Cata范围
    [89235] = "MOP", [95879] = "MOP", [99671] = "MOP",        -- MoP范围
    [119308] = "WOD",                                         -- WoD范围
    [183890] = "SL", [191004] = "SL",                        -- Shadowlands范围
    [193001] = "DF", [198625] = "DF"                         -- Dragonflight范围
}

-- 辅助函数：根据物品ID获取代币类型
function GetTokenTypeByItemID(itemID)
    return ITEM_ID_TO_TOKEN_TYPE[itemID]
end

-- 辅助函数：根据代币类型获取适用职业
function GetClassesByTokenType(tokenType)
    return TOKEN_TYPE_TO_CLASSES[tokenType] or {}
end

-- 辅助函数：检查职业是否可以使用特定代币类型
function CanClassUseTokenType(playerClass, tokenType)
    local classes = GetClassesByTokenType(tokenType)
    if not classes then return false end
    
    for _, class in ipairs(classes) do
        if class == playerClass or class == "ALL" then
            return true
        end
    end
    return false
end

-- 辅助函数：根据物品ID检查是否为代币
function IsTokenItem(itemID)
    return TIER_SET_ITEMS[itemID] == true
end

local frame = CreateFrame("Frame")


-- 设置下拉框最大高度限制，确保不会超出屏幕
UIDROPDOWNMENU_MAXHEIGHT = 200

-- 下拉框滚动变量
local blacklistScrollOffset = 0
local whitelistScrollOffset = 0
local maxVisibleItems = 8



-- 前向声明所有函数以解决作用域问题
local ScanBagForLowLevelGear
local ShowCustomSellPopup
local SellItems
local UpdateSellPopupStatus
local GetTokenTypeFromID
local IsTokenForClassByID
local IsTokenForCurrentClass
local CanUseToken
local OnMerchantShow
local ScanBagForUsableTokens

-- 新的代币识别系统前向声明
local IsDefinitelyTierToken_New
local GetItemTooltipText
local GetItemExpansion
local IsTokenForCurrentClass_New
local GetPlayerExpansion

-- 混合系统前向声明
local IsDefinitelyTierToken_Hybrid
local IsTokenForCurrentClass_Hybrid

-- 配置
--[[
ITEM_LEVEL_THRESHOLD = 400 -- 物品等级阈值，低于此等级的装备将被自动售卖
]]

-- 黑名单系统
local BLACKLIST = {} -- 存储黑名单物品链接
local BLACKLIST_NAMES = {} -- 存储黑名单物品链接（用于显示）

-- 白名单系统
local WHITELIST = {} -- 存储白名单物品链接
local WHITELIST_NAMES = {} -- 存储白名单物品链接（用于显示）

-- 黑白名单模式管理
local blacklistMode = "global" -- "character"（角色独立）或 "global"（跨服通用）
local whitelistMode = "global" -- "character"（角色独立）或 "global"（跨服通用）

-- 界面布局常量
local SCROLL_HEIGHT = 75  -- 售卖装备类型管理滚动区域高度
local BL_SCROLL_HEIGHT = 80  -- 黑白名单滚动区域高度（恢复原来的高度）
local ROW_HEIGHT = 22
local BL_ROW_HEIGHT = 22

-- 自动使用代币的开关
local AUTO_USE_TOKEN_ENABLED = true

-- 代币识别系统选择开关 (true=新系统, false=原系统)
local USE_NEW_TOKEN_SYSTEM = true

-- 获取当前角色标识（跨服务器通用，只使用角色名）
function GetCurrentCharacterKey()
    local name = UnitName("player")
    return name
end

-- 定义全局的职业颜色表
local CLASS_COLORS = RAID_CLASS_COLORS or CUSTOM_CLASS_COLORS or {}

-- 获取职业颜色的十六进制代码
function GetClassColorHex(class)
    local c = CLASS_COLORS[class]
    if c then
        return string.format("|cff%02x%02x%02x", c.r*255, c.g*255, c.b*255)
    else
        return "|cffffffff"
    end
end

-- 获取角色职业（当前角色可直接获取，其他角色从数据库获取）
function GetCharClass(charKey)
    if charKey == GetCurrentCharacterKey() then
        local _, class = UnitClass("player")
        return class
    end
    -- 其他角色从数据库获取职业信息
    if AutoSellLowLevelGearDB and AutoSellLowLevelGearDB.characters and AutoSellLowLevelGearDB.characters[charKey] and AutoSellLowLevelGearDB.characters[charKey].class then
        return AutoSellLowLevelGearDB.characters[charKey].class
    end
    return nil
end

-- 获取所有角色列表
local function GetAllCharacters()
    local characters = {}
    if AutoSellLowLevelGearDB and AutoSellLowLevelGearDB.characters then
        for charKey, _ in pairs(AutoSellLowLevelGearDB.characters) do
            table.insert(characters, charKey)
        end
    end
    return characters
end

-- 获取指定角色的黑名单
local function GetCharacterBlacklist(charKey)
    if AutoSellLowLevelGearDB and AutoSellLowLevelGearDB.characters and AutoSellLowLevelGearDB.characters[charKey] then
        return AutoSellLowLevelGearDB.characters[charKey].blacklist or {}
    end
    return {}
end

-- 保存指定角色的黑名单，并保存职业信息
local function SaveCharacterBlacklist(charKey, blacklist)
    if not AutoSellLowLevelGearDB then AutoSellLowLevelGearDB = {} end
    if not AutoSellLowLevelGearDB.characters then AutoSellLowLevelGearDB.characters = {} end
    if not AutoSellLowLevelGearDB.characters[charKey] then 
        AutoSellLowLevelGearDB.characters[charKey] = {}
    end
    
    
    -- 🔧 关键修复：使用深拷贝避免引用问题
    AutoSellLowLevelGearDB.characters[charKey].blacklist = {}
    for key, value in pairs(blacklist) do
        AutoSellLowLevelGearDB.characters[charKey].blacklist[key] = value
    end
    
    
    -- 新增：保存职业信息
    if charKey == GetCurrentCharacterKey() then
        local _, class = UnitClass("player")
        AutoSellLowLevelGearDB.characters[charKey].class = class
    end
end

-- 获取指定角色的白名单
local function GetCharacterWhitelist(charKey)
    if not AutoSellLowLevelGearDB then
        return {}
    end
    
    if not AutoSellLowLevelGearDB.characters then
        return {}
    end
    
    if not AutoSellLowLevelGearDB.characters[charKey] then
        return {}
    end
    
    local charData = AutoSellLowLevelGearDB.characters[charKey]
    local whitelist = charData.whitelist or {}
    local count = GetTableSize(whitelist)
    
    return whitelist
end

-- 保存指定角色的白名单
local function SaveCharacterWhitelist(charKey, whitelist)
    if not AutoSellLowLevelGearDB then AutoSellLowLevelGearDB = {} end
    if not AutoSellLowLevelGearDB.characters then AutoSellLowLevelGearDB.characters = {} end
    if not AutoSellLowLevelGearDB.characters[charKey] then 
        AutoSellLowLevelGearDB.characters[charKey] = {}
    end
    
    local whitelistCount = GetTableSize(whitelist)
    
    -- 🔧 关键修复：使用深拷贝避免引用问题
    AutoSellLowLevelGearDB.characters[charKey].whitelist = {}
    for key, value in pairs(whitelist) do
        AutoSellLowLevelGearDB.characters[charKey].whitelist[key] = value
    end
    
    
    -- 添加保存职业信息
    if charKey == GetCurrentCharacterKey() then
        local _, class = UnitClass("player")
        AutoSellLowLevelGearDB.characters[charKey].class = class
    end
    
end

-- 真正的全局黑名单加载（跨服务器、跨阵营）
local function GetGlobalBlacklist()
    if AutoSellLowLevelGearDB and AutoSellLowLevelGearDB.universalBlacklist then
        return AutoSellLowLevelGearDB.universalBlacklist
    end
    return {}
end

-- 真正的全局黑名单存储（跨服务器、跨阵营）
local function SaveGlobalBlacklist(blacklist)
    if not AutoSellLowLevelGearDB then AutoSellLowLevelGearDB = {} end
    -- 🔧 关键修复：使用深拷贝避免引用问题
    AutoSellLowLevelGearDB.universalBlacklist = {}
    for key, value in pairs(blacklist) do
        AutoSellLowLevelGearDB.universalBlacklist[key] = value
    end
end

-- 真正的全局白名单加载（跨服务器、跨阵营）
local function GetGlobalWhitelist()
    if AutoSellLowLevelGearDB and AutoSellLowLevelGearDB.universalWhitelist then
        return AutoSellLowLevelGearDB.universalWhitelist
    end
    return {}
end

-- 真正的全局白名单存储（跨服务器、跨阵营）
local function SaveGlobalWhitelist(whitelist)
    if not AutoSellLowLevelGearDB then AutoSellLowLevelGearDB = {} end
    -- 🔧 关键修复：使用深拷贝避免引用问题
    AutoSellLowLevelGearDB.universalWhitelist = {}
    for key, value in pairs(whitelist) do
        AutoSellLowLevelGearDB.universalWhitelist[key] = value
    end
end

-- 新增：阈值变动后自动开启/关闭售卖弹窗的辅助函数（必须放在前面）
local function TryCloseSellPopupIfNoItems()
    local itemsToSell = ScanBagForLowLevelGear(0, true) -- 静默扫描
    if sellPopupFrame and sellPopupFrame:IsShown() and (#itemsToSell == 0) then
        sellPopupFrame:Hide()
        print("当前阈值下没有满足售卖条件的装备，已关闭售卖窗口")
    end
end

-- 通用函数：检查并更新售卖窗口状态
UpdateSellPopupStatus = function(showMessage)
    local itemsToSell = ScanBagForLowLevelGear(0, true) -- 静默扫描
    showMessage = showMessage ~= false -- 默认显示消息
    
    
    if #itemsToSell > 0 then
        -- 有满足条件的装备
        if showMessage then
            print("发现", #itemsToSell, "件符合售卖条件的装备")
        end
        if MerchantFrame and MerchantFrame:IsShown() then
            ShowCustomSellPopup(itemsToSell, function() SellItems(itemsToSell) end, nil)
        end
    else
        -- 没有满足条件的装备，关闭售卖窗口
        if sellPopupFrame and sellPopupFrame:IsShown() then
            sellPopupFrame:Hide()
            if showMessage then
                print("当前阈值下没有满足售卖条件的装备，已关闭售卖窗口")
            end
        end
        
        -- 额外检查：尝试通过名称查找窗口并关闭
        local namedFrame = _G["AutoSellSellPopupFrame"]
        if namedFrame and namedFrame:IsShown() then
            namedFrame:Hide()
            if showMessage then
                print("当前阈值下没有满足售卖条件的装备，已关闭售卖窗口")
            end
        end
    end
end

-- 获取物品的唯一标识符（物品ID+等级+品质）
local function GetItemUniqueIdentifier(itemLink)
    if not itemLink then return nil end
    
    local itemID = GetItemInfoFromHyperlink(itemLink)
    if not itemID then return nil end
    
    local itemLevel = GetDetailedItemLevelInfo(itemLink)
    local _, _, itemQuality = GetItemInfo(itemID)
    
    -- 对于某些特殊物品类型，可能需要更严格的匹配
    local itemName, itemLink_full, itemRarity, itemLevelFromInfo, itemMinLevel, itemType, itemSubType = GetItemInfo(itemID)
    
    -- 构建唯一标识符：物品ID_等级_品质_类型
    return string.format("%d_%d_%d_%s", itemID, itemLevel or 0, itemQuality or 0, itemType or "")
end

-- 判断是否在黑名单（提前定义，供全局使用）
local function IsInBlacklist(itemLink)
    -- 首先尝试精确匹配
    local isInBlacklist = BLACKLIST[itemLink]
    if isInBlacklist then
        return true
    end
    
    -- 如果精确匹配失败，尝试通过唯一标识符匹配
    local currentIdentifier = GetItemUniqueIdentifier(itemLink)
    if currentIdentifier then
        for key, value in pairs(BLACKLIST) do
            if value then
                local keyIdentifier = GetItemUniqueIdentifier(key)
                if keyIdentifier and keyIdentifier == currentIdentifier then
                    return true
                end
            end
        end
    end
    
    return false
end

-- 判断是否在白名单（提前定义，供全局使用）
local function IsInWhitelist(itemLink)
    -- 首先尝试精确匹配（向后兼容）
    local isInWhitelist = WHITELIST[itemLink]
    if isInWhitelist then
        return true
    end
    
    -- 如果精确匹配失败，尝试通过唯一标识符匹配
    local currentIdentifier = GetItemUniqueIdentifier(itemLink)
    if currentIdentifier then
        -- 检查白名单中是否有相同唯一标识符的物品
        for key, value in pairs(WHITELIST) do
            if value then
                local keyIdentifier = GetItemUniqueIdentifier(key)
                if keyIdentifier and keyIdentifier == currentIdentifier then
                    return true
                end
            end
        end
    end
    
    return false
end

-- 检查指定白名单表中是否已存在相同的物品（通用函数）
local function IsItemInWhitelistTable(itemLink, whitelistTable)
    -- 首先尝试精确匹配
    if whitelistTable[itemLink] then
        return true
    end
    
    -- 然后通过唯一标识符匹配
    local currentIdentifier = GetItemUniqueIdentifier(itemLink)
    if currentIdentifier then
        for key, value in pairs(whitelistTable) do
            if value then
                local keyIdentifier = GetItemUniqueIdentifier(key)
                if keyIdentifier and keyIdentifier == currentIdentifier then
                    return true
                end
            end
        end
    end
    
    return false
end

-- 检查白名单中是否已存在相同的物品（用于添加时的重复检查）
local function IsItemAlreadyInWhitelist(itemLink)
    return IsItemInWhitelistTable(itemLink, WHITELIST)
end

-- 检查指定黑名单表中是否已存在相同的物品（通用函数）
local function IsItemInBlacklistTable(itemLink, blacklistTable)
    -- 首先尝试精确匹配
    if blacklistTable[itemLink] then
        return true
    end
    
    -- 然后通过唯一标识符匹配
    local currentIdentifier = GetItemUniqueIdentifier(itemLink)
    if currentIdentifier then
        for key, value in pairs(blacklistTable) do
            if value then
                local keyIdentifier = GetItemUniqueIdentifier(key)
                if keyIdentifier and keyIdentifier == currentIdentifier then
                    return true
                end
            end
        end
    end
    
    return false
end

-- 检查黑名单中是否已存在相同的物品（用于添加时的重复检查）
local function IsItemAlreadyInBlacklist(itemLink)
    return IsItemInBlacklistTable(itemLink, BLACKLIST)
end

-- 判断物品外观是否已学会
local function IsAppearanceLearned(itemID, itemLink)
    if not itemID then return false end
    
    -- 使用C_TransmogCollection.PlayerHasTransmog检查是否已学会外观
    if C_TransmogCollection and C_TransmogCollection.PlayerHasTransmog then
        local hasTransmog = C_TransmogCollection.PlayerHasTransmog(itemID)
        return hasTransmog
    end
    
    -- 如果API不可用，返回false（保守处理，不售卖）
    return false
end

-- 判断是否为纯装饰品（衬衣、战袍等）
local function IsPureCosmeticItem(itemID, equipLoc)
    if not itemID then return false end
    
    -- 获取物品信息
    local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, equipLoc, itemTexture = GetItemInfo(itemID)
    
    -- 装饰品特征：物品等级为1且为装备类型
    if itemLevel == 1 and equipLoc and equipLoc ~= "" then
        -- 排除真正的新手装备（通过物品类型判断）
        local itemClassID, itemSubClassID = select(12, GetItemInfo(itemID))
        if itemClassID == 4 then -- 4 = 护甲类
            return true
        elseif itemClassID == 2 then -- 2 = 武器类
            return true
        end
    end
    
    -- 传统的纯装饰品装备部位（衬衣、战袍）
    local pureCosmeticSlots = {
        ["INVTYPE_BODY"] = true,    -- 衬衣
        ["INVTYPE_TABARD"] = true   -- 战袍/徽章
    }
    
    return pureCosmeticSlots[equipLoc] == true
end

-- 判断是否具有外观价值（可幻化）
local function IsTransmoggableItem(itemID, equipLoc)
    if not equipLoc then return false end
    
    -- 具有外观的装备部位
    local transmoggableSlots = {
        ["INVTYPE_HEAD"] = true,        -- 头部
        ["INVTYPE_SHOULDER"] = true,    -- 肩膀
        ["INVTYPE_CHEST"] = true,       -- 胸甲
        ["INVTYPE_ROBE"] = true,        -- 长袍
        ["INVTYPE_WAIST"] = true,       -- 腰带
        ["INVTYPE_LEGS"] = true,        -- 腿部
        ["INVTYPE_FEET"] = true,        -- 脚部
        ["INVTYPE_WRIST"] = true,       -- 护腕
        ["INVTYPE_HAND"] = true,        -- 手套
        ["INVTYPE_CLOAK"] = true,       -- 披风
        ["INVTYPE_WEAPON"] = true,      -- 主手武器
        ["INVTYPE_WEAPONMAINHAND"] = true, -- 主手武器
        ["INVTYPE_WEAPONOFFHAND"] = true,  -- 副手武器
        ["INVTYPE_2HWEAPON"] = true,    -- 双手武器
        ["INVTYPE_RANGED"] = true,      -- 远程武器
        ["INVTYPE_HOLDABLE"] = true,    -- 副手物品
        ["INVTYPE_SHIELD"] = true,      -- 盾牌
        ["INVTYPE_BODY"] = true,        -- 衬衣
        ["INVTYPE_TABARD"] = true       -- 战袍
    }
    
    return transmoggableSlots[equipLoc] == true
end

-- 工具函数：判断物品描述是否同时包含所有关键字（提前定义）
local function ItemTooltipContainsAll(itemLink, keywords)
    local tooltip = AutoSellScanTooltip or CreateFrame("GameTooltip", "AutoSellScanTooltip", nil, "GameTooltipTemplate")
    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
    tooltip:SetHyperlink(itemLink)
    local found = {}
    for i = 2, tooltip:NumLines() do
        local text = _G["AutoSellScanTooltipTextLeft"..i] and _G["AutoSellScanTooltipTextLeft"..i]:GetText()
        if text then
            for idx, word in ipairs(keywords) do
                if not found[idx] and string.find(text, word) then
                    found[idx] = true
                end
            end
        end
    end
    for idx = 1, #keywords do
        if not found[idx] then
            return false
        end
    end
    return true
end

-- 判断是否为当前职业可用的代币
IsTokenForCurrentClass = function(itemLink, itemID)
    if not TIER_SET_ITEMS[itemID] then
        return false
    end
    
    local _, playerClass = UnitClass("player")
    if not playerClass or not PLAYER_CLASS_TOKEN_MAPPING[playerClass] then
        return false
    end
    
    -- 优先使用物品ID精确匹配 - 解决本地化问题
    if IsTokenForClassByID(itemID, playerClass) then
        return true
    end
    
    -- 备用方案：名称匹配（支持中英文）
    local itemName = select(1, GetItemInfo(itemID))
    if not itemName then
        return false -- 如果ID匹配失败且获取不到名称，则返回false
    end
    
    local classTokenTypes = PLAYER_CLASS_TOKEN_MAPPING[playerClass]
    for _, tokenType in ipairs(classTokenTypes) do
        -- 英文名称匹配
        if itemName:find(tokenType) then
            return true
        end
        -- 中文名称匹配
        if CHINESE_TOKEN_KEYWORDS and CHINESE_TOKEN_KEYWORDS[tokenType] then
            for _, chineseKeyword in ipairs(CHINESE_TOKEN_KEYWORDS[tokenType]) do
                if itemName:find(chineseKeyword) then
                    return true
                end
            end
        end
    end
    
    return false
end

-- 新增：从物品ID获取代币类型
GetTokenTypeFromID = function(itemID)
    -- 优先使用精确的ID映射表
    if ITEM_ID_TO_TOKEN_TYPE and ITEM_ID_TO_TOKEN_TYPE[itemID] then
        return ITEM_ID_TO_TOKEN_TYPE[itemID]
    end
    
    -- 现代版本 (Dragonflight/War Within) - 使用ID范围判断
    if itemID >= 193000 and itemID <= 220100 then
        if itemID >= 193001 and itemID <= 193005 then return "Dreadful" end
        if itemID >= 193011 and itemID <= 193015 then return "Mystic" end
        if itemID >= 193021 and itemID <= 193025 then return "Venerated" end
        if itemID >= 193031 and itemID <= 193035 then return "Zenith" end
        if itemID >= 220000 and itemID <= 220010 then return "Dreadful" end
        if itemID >= 220011 and itemID <= 220020 then return "Mystic" end
        if itemID >= 220021 and itemID <= 220030 then return "Venerated" end
        if itemID >= 220031 and itemID <= 220043 then return "Zenith" end
    end
    
    -- 通过物品名称作为后备方案（支持中英文）
    local itemName = select(1, GetItemInfo(itemID))
    if itemName then
        -- 使用中英文关键词映射表进行匹配
        for englishType, chineseKeywords in pairs(CHINESE_TOKEN_KEYWORDS) do
            -- 英文匹配
            if itemName:find(englishType) then
                return englishType
            end
            -- 中文匹配
            for _, chineseKeyword in ipairs(chineseKeywords) do
                if itemName:find(chineseKeyword) then
                    return englishType
                end
            end
        end
    end
    
    return nil
end

-- 新增：基于物品ID的精确职业匹配
IsTokenForClassByID = function(itemID, playerClass)
    if not TIER_SET_ITEMS[itemID] or not PLAYER_CLASS_TOKEN_MAPPING[playerClass] then
        return false
    end
    
    -- 使用ID范围和命名规则来判断职业类型
    local classTokenTypes = PLAYER_CLASS_TOKEN_MAPPING[playerClass]
    
    -- 根据物品ID判断代币类型
    local tokenType = GetTokenTypeFromID(itemID)
    if tokenType then
        for _, validType in ipairs(classTokenTypes) do
            if tokenType == validType then
                return true
            end
        end
    end
    
    return false
end

-- 新增：获取中文关键词
local function GetChineseTokenKeyword(englishKeyword)
    if CHINESE_TOKEN_KEYWORDS[englishKeyword] then
        return CHINESE_TOKEN_KEYWORDS[englishKeyword][1] -- 返回第一个中文关键词
    end
    return nil
end

-- 不可直接使用的代币ID列表（需要NPC兑换的代币）
local UNUSABLE_TOKEN_IDS = {
    -- WOTLK T10 精华代币（需要NPC兑换成具体部位代币）
    [52025] = true, -- "Vanquisher's Mark of Sanctification" (胜利者的圣洁印记)
    [52026] = true, -- "Protector's Mark of Sanctification" (保护者的圣洁印记)
    [52027] = true, -- "Conqueror's Mark of Sanctification" (征服者的圣洁印记)
    [52028] = true, -- "Vanquisher's Mark of Sanctification (Heroic)"
    [52029] = true, -- "Protector's Mark of Sanctification (Heroic)"
    [52030] = true, -- "Conqueror's Mark of Sanctification (Heroic)"
    
    -- MoP T16 精华代币（需要NPC兑换）
    [105857] = true, -- "Essence of the Cursed Protector"
    [105858] = true, -- "Essence of the Cursed Conqueror"
    [105859] = true, -- "Essence of the Cursed Vanquisher"
    [105860] = true, -- "Essence of the Cursed Protector (Heroic)"
    [105861] = true, -- "Essence of the Cursed Conqueror (Heroic)"
    [105862] = true, -- "Essence of the Cursed Vanquisher (Heroic)"
    [105863] = true, -- "Essence of the Cursed Protector (Mythic)"
    [105865] = true, -- "Essence of the Cursed Vanquisher (Mythic)"
    [105866] = true, -- "Essence of the Cursed Protector (Warforged)"
    [105868] = true, -- "Essence of the Cursed Vanquisher (Warforged)"
    
    -- 其他通用货币类代币
    [47242] = true, -- "Trophy of the Crusade"
    [47556] = true, -- "Crusader Orb"
    [49426] = true, -- "Emblem of Triumph"
    [49427] = true, -- "Emblem of Frost"
}

-- 基于物品类型判断代币是否可直接使用
local function IsTokenDirectlyUsable(itemID)
    -- 获取物品信息
    local itemName = GetItemInfo(itemID)
    if not itemName then
        return false
    end
    
    -- 通过检查物品的实际可用性来判断
    -- 使用 IsUsableItem 函数检查物品是否可以被当前角色使用
    local usable, noMana = IsUsableItem(itemID)
    
    -- 如果物品不可用，则不能直接使用
    if not usable then
        return false
    end
    
    -- 检查物品是否有法术效果（可以被右键使用）
    local spellName, spellID = GetItemSpell(itemID)
    if spellName and spellID then
        return true -- 有法术效果的物品通常可以直接使用
    end
    
    -- 进一步检查：尝试获取物品的使用效果
    -- 如果物品有冷却时间（即使当前不在冷却中），说明它是可以被使用的
    local start, duration = GetItemCooldown(itemID)
    if start ~= nil then -- 有冷却信息说明物品可以被使用
        return true
    end
    
    -- 作为最后的检查，如果物品可用，我们认为它可以使用
    -- 这里比较保守，只有确认可用的才返回true
    return usable
end

-- 新增：测试代币匹配功能
local function TestTokenMatching()
    print("=== 代币匹配测试 ===")
    
    -- 测试具体的T16 Cursed Vanquisher代币
    local testCases = {
        {id = 99671, name = "Helm of the Cursed Vanquisher", expectedType = "Vanquisher"},
        {id = 99723, name = "受诅咒破坏者头盔", expectedType = "Vanquisher"},
        {id = 99748, name = "Helm of the Cursed Vanquisher", expectedType = "Vanquisher"},
        {id = 105859, name = "Essence of the Cursed Vanquisher", expectedType = "Vanquisher"},
        {id = 105859, name = "受诅咒破坏者精华", expectedType = "Vanquisher"},
        {id = 99673, name = "Helm of the Cursed Protector", expectedType = "Protector"},
        {id = 99746, name = "Helm of the Cursed Conqueror", expectedType = "Conqueror"},
    }
    
    for _, testCase in ipairs(testCases) do
        local detectedType = GetTokenTypeFromID(testCase.id)
        local success = detectedType == testCase.expectedType
        local status = success and "✓" or "✗"
        
        print(string.format("%s ID:%d %s -> 检测到:%s, 期望:%s", 
            status, testCase.id, testCase.name or "未知", 
            detectedType or "无", testCase.expectedType))
    end
    
    -- 测试职业匹配
    print("\n=== 职业匹配测试 ===")
    local testClasses = {"DRUID", "MAGE", "ROGUE", "DEATHKNIGHT"}
    
    for _, playerClass in ipairs(testClasses) do
        local validTypes = PLAYER_CLASS_TOKEN_MAPPING[playerClass]
        if validTypes then
            print(string.format("%s 职业可用代币类型: %s", playerClass, table.concat(validTypes, ", ")))
            
            -- 测试Vanquisher代币对该职业是否有效
            local hasVanquisher = false
            for _, tokenType in ipairs(validTypes) do
                if tokenType == "Vanquisher" then
                    hasVanquisher = true
                    break
                end
            end
            
            print(string.format("  - 是否可使用Vanquisher代币: %s", hasVanquisher and "是" or "否"))
        end
    end
end

-- 检查代币是否可以使用（带详细原因）
CanUseTokenWithReason = function(itemLink, itemID)
    -- 检查物品是否存在
    if not itemID or not itemLink then
        return false, "物品ID或链接缺失"
    end
    
    -- 检查是否为代币 (使用混合系统)
    if not IsDefinitelyTierToken_Hybrid(itemID) then
        return false, "不是已知代币"
    end
    
    -- 检查是否为当前职业的代币 (使用混合系统)
    if not IsTokenForCurrentClass_Hybrid(itemID, nil, nil, itemLink) then
        return false, "非本职业代币"
    end
    
    -- 检查物品是否可用（不在冷却中等）
    local startTime, duration = GetItemCooldown(itemID)
    if startTime and startTime > 0 then
        return false, "物品冷却中"
    end
    
    -- 检查是否有足够的背包空间（使用代币后可能获得装备）
    local freeSlots = 0
    for bagID = 0, NUM_BAG_SLOTS do
        local numSlots = C_Container.GetContainerNumSlots(bagID)
        for slotID = 1, numSlots do
            local itemID = C_Container.GetContainerItemID(bagID, slotID)
            if not itemID then
                freeSlots = freeSlots + 1
            end
        end
    end
    
    if freeSlots < 1 then
        return false, "背包空间不足"
    end
    
    -- 新增：基于物品类型和ID黑名单判断代币是否可直接使用
    if not IsTokenDirectlyUsable(itemID) then
        return false, "需要NPC兑换，不能直接使用"
    end
    
    return true, "可以使用"
end

-- 检查代币是否可以使用
CanUseToken = function(itemLink, itemID)
    -- 检查物品是否存在
    if not itemID or not itemLink then
        return false
    end
    
    -- 检查是否为代币 (使用混合系统)
    if not IsDefinitelyTierToken_Hybrid(itemID) then
        return false
    end
    
    -- 检查是否为当前职业的代币 (使用混合系统)
    if not IsTokenForCurrentClass_Hybrid(itemID, nil, nil, itemLink) then
        return false
    end
    
    -- 检查物品是否可用（不在冷却中等）
    local startTime, duration = GetItemCooldown(itemID)
    if startTime and startTime > 0 then
        return false -- 物品在冷却中
    end
    
    -- 检查是否有足够的背包空间（使用代币后可能获得装备）
    local freeSlots = 0
    for bagID = 0, NUM_BAG_SLOTS do
        local numSlots = C_Container.GetContainerNumSlots(bagID)
        for slotID = 1, numSlots do
            local itemID = C_Container.GetContainerItemID(bagID, slotID)
            if not itemID then
                freeSlots = freeSlots + 1
            end
        end
    end
    
    if freeSlots < 1 then
        return false -- 背包空间不足
    end
    
    -- 新增：基于物品类型和ID黑名单判断代币是否可直接使用
    if not IsTokenDirectlyUsable(itemID) then
        return false -- 此代币不能直接使用，需要NPC兑换
    end
    
    return true
end

-- 自动使用代币
local function AutoUseToken(bagID, slotID, itemID, itemLink)
    if not AUTO_USE_TOKEN_ENABLED then
        return false
    end
    
    if not AutoSellLowLevelGearDB or not AutoSellLowLevelGearDB.autoUseToken then
        return false
    end
    
    if not CanUseToken(itemLink, itemID) then
        return false
    end
    
    -- 确保显示正确的物品链接
    local displayLink = itemLink
    if not displayLink or displayLink == "" or displayLink == "[]" then
        local itemName = select(1, GetItemInfo(itemID))
        if itemName then
            displayLink = string.format("|cffffffff|Hitem:%d:0:0:0:0:0:0:0:0:0:0:0:0|h[%s]|h|r", itemID, itemName)
        else
            displayLink = "物品ID:" .. itemID
        end
    end
    
    -- 安全检查：确保不在战斗中且没有保护限制
    if InCombatLockdown() then
        print("当前在战斗中，无法自动使用代币:", displayLink)
        return false
    end
    
    -- 检查是否在施法或引导中
    if UnitCastingInfo("player") or UnitChannelInfo("player") then
        print("当前在施法中，无法自动使用代币:", displayLink)
        return false
    end
    
    -- 检查是否在移动中（可能不稳定）
    if GetUnitSpeed("player") > 0 then
        print("当前在移动中，延迟使用代币:", displayLink)
        return false
    end
    
    -- 检查物品是否还在指定位置
    local currentItemID = C_Container.GetContainerItemID(bagID, slotID)
    if currentItemID ~= itemID then
        print("物品位置已改变，取消自动使用:", displayLink)
        return false
    end
    
    -- 由于暴雪加强了物品使用限制，暂时只做检测和提示
    print("发现可用的职业代币:", displayLink)
    print("位置: 背包" .. bagID .. " 位置" .. slotID)
    
    -- 在聊天框高亮显示
    local chatFrame = DEFAULT_CHAT_FRAME
    if chatFrame then
        chatFrame:AddMessage(">>> 发现可用代币: " .. displayLink .. " <<<", 1, 1, 0)
    end
    
    return true
end


-- 自动使用代币
local function AutoUseTokenSafely(bagID, slotID, itemID, itemLink)
    local displayLink = itemLink
    if not displayLink or displayLink == "" or displayLink == "[]" then
        local itemName = select(1, GetItemInfo(itemID))
        if itemName then
            displayLink = string.format("|cffffffff|Hitem:%d:0:0:0:0:0:0:0:0:0:0:0:0|h[%s]|h|r", itemID, itemName)
        else
            displayLink = "物品ID:" .. itemID
        end
    end
    
    print("检测到可用的职业代币:", displayLink)
    print("自动使用代币...")
    
    -- 等待一个安全的时机再使用代币
    local attempts = 0
    local maxAttempts = 3
    
    local function tryUseToken()
        attempts = attempts + 1
        
        if attempts > maxAttempts then
            print("代币自动使用失败，请手动使用:", displayLink)
            return
        end
        
        -- 检查是否在安全状态
        if InCombatLockdown() or UnitCastingInfo("player") or UnitChannelInfo("player") then
            C_Timer.After(1, tryUseToken)
            return
        end
        
        -- 确认物品还在原位置
        local currentItemID = C_Container.GetContainerItemID(bagID, slotID)
        if currentItemID ~= itemID then
            print("物品位置已改变，取消自动使用:", displayLink)
            return
        end
        
        -- 暂时只做检测，不自动使用
        print("发现可用的职业代币:", displayLink)
        print("位置: 背包" .. bagID .. " 位置" .. slotID)
        
        -- 在聊天框高亮显示
        local chatFrame = DEFAULT_CHAT_FRAME
        if chatFrame then
            chatFrame:AddMessage(">>> 发现可用代币: " .. displayLink .. " <<<", 1, 1, 0)
        end
    end
    
    tryUseToken()
end

-- 扫描背包寻找可自动使用的代币
ScanBagForUsableTokens = function()
    if not AUTO_USE_TOKEN_ENABLED then
        return
    end
    
    if not AutoSellLowLevelGearDB or not AutoSellLowLevelGearDB.autoUseToken then
        return
    end
    
    for bagID = 0, NUM_BAG_SLOTS do
        local numSlots = C_Container.GetContainerNumSlots(bagID)
        for slotID = 1, numSlots do
            local itemID = C_Container.GetContainerItemID(bagID, slotID)
            local itemLink = C_Container.GetContainerItemLink(bagID, slotID)
            
            if itemID and IsDefinitelyTierToken_Hybrid(itemID) and CanUseToken(itemLink, itemID) then
                -- 使用安全的代币调度器
                AutoUseTokenSafely(bagID, slotID, itemID, itemLink)
                return -- 一次只使用一个代币
            end
        end
    end
end

-- ========================================
-- 新的代币识别系统 (基于Wowhead调研结果)
-- ========================================

-- 获取物品工具提示文本
GetItemTooltipText = function(itemID)
    if not itemID then return "" end
    
    local tooltip = CreateFrame("GameTooltip", "TokenScanTooltip_" .. itemID, nil, "GameTooltipTemplate")
    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
    tooltip:ClearLines()
    tooltip:SetHyperlink("item:" .. itemID)
    
    local tooltipText = ""
    for i = 1, tooltip:NumLines() do
        local leftText = _G[tooltip:GetName() .. "TextLeft" .. i]
        if leftText and leftText:GetText() then
            tooltipText = tooltipText .. leftText:GetText() .. "\n"
        end
    end
    
    tooltip:Hide()
    return tooltipText
end

-- 根据物品ID判断游戏版本/扩展包
GetItemExpansion = function(itemID)
    if itemID >= 29000 and itemID <= 31999 then return "TBC" end
    if itemID >= 40000 and itemID <= 52999 then return "WOTLK" end  
    if itemID >= 65000 and itemID <= 78999 then return "CATA" end
    if itemID >= 89000 and itemID <= 105999 then return "MOP" end
    if itemID >= 119000 and itemID <= 120999 then return "WOD" end
    if itemID >= 183000 and itemID <= 191999 then return "SL" end
    if itemID >= 193000 and itemID <= 220000 then return "DF" end
    if itemID >= 220001 and itemID <= 250000 then return "TWW" end  -- 地心之战
    return "UNKNOWN"
end

-- 获取当前玩家所在的游戏版本
GetPlayerExpansion = function()
    local buildInfo = select(4, GetBuildInfo())
    if buildInfo >= 110000 then return "TWW" end      -- 地心之战 11.0+
    if buildInfo >= 100000 then return "DF" end       -- 巨龙时代 10.0+
    if buildInfo >= 90000 then return "SL" end        -- 暗影国度 9.0+
    if buildInfo >= 80000 then return "BFA" end       -- 争霸艾泽拉斯 8.0+
    if buildInfo >= 70000 then return "LEGION" end    -- 军团再临 7.0+
    if buildInfo >= 60000 then return "WOD" end       -- 德拉诺之王 6.0+
    if buildInfo >= 50000 then return "MOP" end       -- 熊猫人之谜 5.0+
    if buildInfo >= 40000 then return "CATA" end      -- 大地的裂变 4.0+
    if buildInfo >= 30000 then return "WOTLK" end     -- 巫妖王之怒 3.0+
    if buildInfo >= 20000 then return "TBC" end       -- 燃烧的远征 2.0+
    return "CLASSIC"                                   -- 经典版 1.x
end

-- 新的套装代币识别函数 (基于Wowhead调研的准确规律)
IsDefinitelyTierToken_New = function(itemID, itemName, itemType, itemSubType, tooltipText, debugMode)
    if not itemID then 
        if debugMode then print("  [调试] itemID为空") end
        return false 
    end
    
    -- 获取必要的物品信息
    if not itemName or not itemType or not itemSubType then
        itemName, _, _, _, _, itemType, itemSubType = GetItemInfo(itemID)
        if not itemName then 
            if debugMode then print("  [调试] 无法获取物品信息") end
            return false 
        end
    end
    
    if not tooltipText then
        tooltipText = GetItemTooltipText(itemID)
    end
    
    if debugMode then
        print(string.format("  [调试] 物品分析: %s (ID:%d)", itemName, itemID))
        print("  [调试] 类型:", itemType, "->", itemSubType)
    end
    
    -- 新系统：完全基于物品属性和内容识别，不依赖ID范围
    -- 规则1：杂项+垃圾+职业关键字（适用于大部分版本的代币）
    local isMiscellaneous = (itemType == "Miscellaneous" or itemType == "杂项")
    local isJunk = (itemSubType == "Junk" or itemSubType == "垃圾")
    if isMiscellaneous and isJunk then
        -- 检查职业关键字
        local hasClassKeyword = false
        if tooltipText then
            hasClassKeyword = string.find(tooltipText, "职业：") or        -- 中文
                            string.find(tooltipText, "Classes:") or     -- 英文
                            string.find(tooltipText, "クラス：")          -- 日文
        end
        
        
        if hasClassKeyword then
            return true
        end
    end
    
    -- 规则2：材料+环境对应兑换物+职业关键字（暗影国度类型）
    local isTradingPost = (itemType == "Trade Goods" or itemType == "材料")
    local isToken = (itemSubType == "Other" or itemSubType == "环境对应兑换物")
    if isTradingPost and isToken then
        local hasClassKeyword = false
        if tooltipText then
            hasClassKeyword = string.find(tooltipText, "职业：") or        -- 中文
                            string.find(tooltipText, "Classes:") or     -- 英文
                            string.find(tooltipText, "クラス：")          -- 日文
        end
        
        if debugMode then
            print("  [调试] 规则2检查: 材料+环境对应兑换物+职业关键字")
            print("    材料类型:", isTradingPost and "符合" or "不符合", string.format("(%s)", itemType or "无"))
            print("    环境对应兑换物:", isToken and "符合" or "不符合", string.format("(%s)", itemSubType or "无"))
            print("    职业关键字:", hasClassKeyword and "有" or "无")
        end
        
        if hasClassKeyword then
            if debugMode then print("  [调试] 规则2匹配: 材料+环境对应兑换物+职业关键字") end
            return true
        end
    end
    
    -- 规则3：杂项+施法材料+职业关键字（部分版本）
    local isReagent = (itemSubType == "Reagent" or itemSubType == "施法材料")
    if isMiscellaneous and isReagent then
        local hasClassKeyword = false
        if tooltipText then
            hasClassKeyword = string.find(tooltipText, "职业：") or        -- 中文
                            string.find(tooltipText, "Classes:") or     -- 英文
                            string.find(tooltipText, "クラス：")          -- 日文
        end
        
        if debugMode then
            print("  [调试] 规则3检查: 杂项+施法材料+职业关键字")
            print("    杂项类型:", isMiscellaneous and "符合" or "不符合", string.format("(%s)", itemType or "无"))
            print("    施法材料:", isReagent and "符合" or "不符合", string.format("(%s)", itemSubType or "无"))
            print("    职业关键字:", hasClassKeyword and "有" or "无")
        end
        
        if hasClassKeyword then
            if debugMode then print("  [调试] 规则3匹配: 杂项+施法材料+职业关键字") end
            return true
        end
    end
    
    -- 规则4：特殊例外代币（基于物品名称）
    local specialTokens = {
        "虚触珍玩", "Void%-Touched Curio",
        "裹网珍玩", "Web%-Wrapped Curio", 
        "浮华嵌宝珍玩", "Gilded Harbinger Crest"
    }
    
    for _, pattern in ipairs(specialTokens) do
        if itemName and string.find(itemName, pattern) then
            if debugMode then print("  [调试] 规则4匹配: 特殊代币模式:", pattern) end
            return true
        end
    end
    
    if debugMode then print("  [调试] 所有规则都不匹配，不是代币") end
    return false
end

-- 新的职业代币检查函数
IsTokenForCurrentClass_New = function(itemID, itemName, tooltipText)
    if not itemID then return false end
    
    -- 首先检查是否为代币
    if not IsDefinitelyTierToken_New(itemID, itemName, nil, nil, tooltipText) then
        return false
    end
    
    -- 获取当前玩家职业
    local _, playerClass = UnitClass("player")
    if not playerClass then return false end
    
    -- 获取工具提示文本
    if not tooltipText then
        tooltipText = GetItemTooltipText(itemID)
    end
    
    -- 检查工具提示中是否包含当前职业
    if tooltipText then
        -- 中文职业名检查
        local chineseClassName = {
            ["WARRIOR"] = "战士", ["PALADIN"] = "圣骑士", ["HUNTER"] = "猎人", 
            ["ROGUE"] = "盗贼", ["PRIEST"] = "牧师", ["DEATHKNIGHT"] = "死亡骑士",
            ["SHAMAN"] = "萨满", ["MAGE"] = "法师", ["WARLOCK"] = "术士",
            ["MONK"] = "武僧", ["DRUID"] = "德鲁伊", ["DEMONHUNTER"] = "恶魔猎手",
            ["EVOKER"] = "唤魔师"
        }
        
        -- 英文职业名检查
        local englishClassName = {
            ["WARRIOR"] = "Warrior", ["PALADIN"] = "Paladin", ["HUNTER"] = "Hunter",
            ["ROGUE"] = "Rogue", ["PRIEST"] = "Priest", ["DEATHKNIGHT"] = "Death Knight",
            ["SHAMAN"] = "Shaman", ["MAGE"] = "Mage", ["WARLOCK"] = "Warlock",
            ["MONK"] = "Monk", ["DRUID"] = "Druid", ["DEMONHUNTER"] = "Demon Hunter",
            ["EVOKER"] = "Evoker"
        }
        
        local chineseName = chineseClassName[playerClass]
        local englishName = englishClassName[playerClass]
        
        if (chineseName and string.find(tooltipText, chineseName)) or
           (englishName and string.find(tooltipText, englishName)) then
            return true
        end
    end
    
    return false
end

-- ========================================
-- 混合代币识别系统 (根据配置选择新/旧系统)
-- ========================================

-- 混合代币识别函数
IsDefinitelyTierToken_Hybrid = function(itemID, itemName, itemType, itemSubType, tooltipText)
    if USE_NEW_TOKEN_SYSTEM then
        return IsDefinitelyTierToken_New(itemID, itemName, itemType, itemSubType, tooltipText)
    else
        -- 使用原系统
        return TIER_SET_ITEMS and TIER_SET_ITEMS[itemID] == true
    end
end

-- 混合职业代币检查函数
IsTokenForCurrentClass_Hybrid = function(itemID, itemName, tooltipText, itemLink)
    if USE_NEW_TOKEN_SYSTEM then
        return IsTokenForCurrentClass_New(itemID, itemName, tooltipText)
    else
        -- 使用原系统
        return IsTokenForCurrentClass and IsTokenForCurrentClass(itemLink, itemID)
    end
end

-- ========================================
-- 原有代币识别系统 (保留但不调用)
-- ========================================

-- 装备部位映射表（equipLoc -> 中文名称）
local EQUIP_LOC_NAMES = {
    ["INVTYPE_HEAD"] = "头部",
    ["INVTYPE_NECK"] = "项链", 
    ["INVTYPE_SHOULDER"] = "肩部",
    ["INVTYPE_BODY"] = "衬衣",
    ["INVTYPE_CHEST"] = "胸部",
    ["INVTYPE_ROBE"] = "长袍",
    ["INVTYPE_WAIST"] = "腰带",
    ["INVTYPE_LEGS"] = "腿部",
    ["INVTYPE_FEET"] = "脚部",
    ["INVTYPE_WRIST"] = "手腕",
    ["INVTYPE_HAND"] = "手部",
    ["INVTYPE_FINGER"] = "戒指",
    ["INVTYPE_TRINKET"] = "饰品",
    ["INVTYPE_CLOAK"] = "披风",
    ["INVTYPE_WEAPON"] = "单手武器",
    ["INVTYPE_SHIELD"] = "盾牌",
    ["INVTYPE_2HWEAPON"] = "双手武器",
    ["INVTYPE_WEAPONMAINHAND"] = "主手武器",
    ["INVTYPE_WEAPONOFFHAND"] = "副手武器",
    ["INVTYPE_HOLDABLE"] = "副手物品",
    ["INVTYPE_RANGED"] = "远程武器",
    ["INVTYPE_THROWN"] = "投掷武器",
    ["INVTYPE_RANGEDRIGHT"] = "远程武器",
    ["INVTYPE_WAND"] = "魔杖",
    ["INVTYPE_RELIC"] = nil,
    ["ARTIFACT_RELIC"] = "神器圣物",
    ["BIND_ON_EQUIP"] = "装备绑定",
    ["SET_ITEM"] = "职业套装兑换物"
}

-- 装备类型管理弹窗及相关变量（提前到文件前部）
local typeManagerFrame = nil
local typeCheckboxes = {}
local DEFAULT_TYPE_WHITELIST = {
    ["INVTYPE_HEAD"] = true, ["INVTYPE_NECK"] = true, ["INVTYPE_SHOULDER"] = true, ["INVTYPE_CHEST"] = true, ["INVTYPE_ROBE"] = true,
    ["INVTYPE_WAIST"] = true, ["INVTYPE_LEGS"] = true, ["INVTYPE_FEET"] = true, ["INVTYPE_WRIST"] = true, ["INVTYPE_HAND"] = true,
    ["INVTYPE_FINGER"] = true, ["INVTYPE_TRINKET"] = true, ["INVTYPE_CLOAK"] = true, ["INVTYPE_WEAPON"] = true, ["INVTYPE_SHIELD"] = true,
    ["INVTYPE_2HWEAPON"] = true, ["INVTYPE_WEAPONMAINHAND"] = true, ["INVTYPE_WEAPONOFFHAND"] = true, ["INVTYPE_HOLDABLE"] = true,
    ["INVTYPE_RANGED"] = true, ["INVTYPE_THROWN"] = true, ["INVTYPE_RANGEDRIGHT"] = true, ["INVTYPE_WAND"] = true, ["INVTYPE_RELIC"] = nil,
    ["ARTIFACT_RELIC"] = true,
    ["BIND_ON_EQUIP"] = false,
    ["SET_ITEM"] = false
}

-- 定义一个函数动态获取当前阈值（必须放在前面）
local function GetCurrentItemLevelThreshold()
    if typeManagerFrame and typeManagerFrame.lvEdit then
        local txt = typeManagerFrame.lvEdit:GetText():gsub("|cff13fff1"," "):gsub("|r","")
        local val = tonumber(txt)
        if val and val > 0 then
            return val
        end
    end
    if AutoSellLowLevelGearDB and AutoSellLowLevelGearDB.itemLevelThreshold then
        return AutoSellLowLevelGearDB.itemLevelThreshold
    end
    return 400
end

-- 获取数据库中的阈值
local function GetDBItemLevelThreshold()
    if AutoSellLowLevelGearDB and AutoSellLowLevelGearDB.itemLevelThreshold then
        return AutoSellLowLevelGearDB.itemLevelThreshold
    end
    return 400
end

function ShowTypeManagerPopup()
    -- 检查并修复数据不一致问题
    if blacklistMode == "global" and GetTableSize(BLACKLIST) == 0 then
        local globalBlacklist = GetGlobalBlacklist()
        if GetTableSize(globalBlacklist) > 0 then
            for key, value in pairs(globalBlacklist) do
                BLACKLIST[key] = true
                local itemName = select(1, GetItemInfo(key))
                if not itemName and key:find("|H") then
                    itemName = key:match("|h%[(.-)%]|h") or key
                end
                BLACKLIST_NAMES[key] = itemName or key
            end
        end
    end
    
    if whitelistMode == "global" and GetTableSize(WHITELIST) == 0 then
        local globalWhitelist = GetGlobalWhitelist()
        if GetTableSize(globalWhitelist) > 0 then
            for key, value in pairs(globalWhitelist) do
                WHITELIST[key] = true
                local itemName = select(1, GetItemInfo(key))
                if not itemName and key:find("|H") then
                    itemName = key:match("|h%[(.-)%]|h") or key
                end
                WHITELIST_NAMES[key] = itemName or key
            end
        end
    end
    
    -- 不要重新加载黑名单，使用当前内存中的数据
    -- LoadBlacklist(GetCurrentCharacterKey()) -- 这会覆盖刚添加的数据
    if typeManagerFrame then
        typeManagerFrame:Hide()
        -- 重新打开时，确保两个下拉菜单都显示当前角色，但不触发数据重新加载
        local currentChar = GetCurrentCharacterKey()
        local curClass = GetCharClass and GetCharClass(currentChar) or nil
        
        -- 重置黑名单下拉框为当前角色
        if typeManagerFrame.charSelectDropdown then
            UIDropDownMenu_SetSelectedValue(typeManagerFrame.charSelectDropdown, currentChar)
            local dropdownText = _G[typeManagerFrame.charSelectDropdown:GetName() .. "Text"]
            if dropdownText then
                -- 使用统一的颜色代码格式
                local currentClass = GetCharClass and GetCharClass(currentChar) or nil
                local currentColor = (currentClass and GetClassColorHex and GetClassColorHex(currentClass)) or "|cffffffff"
                dropdownText:SetText(currentColor .. currentChar .. "|r")
            end
        end
        
        -- 重置白名单下拉框为当前角色
        if typeManagerFrame.wlCharSelectDropdown then
            UIDropDownMenu_SetSelectedValue(typeManagerFrame.wlCharSelectDropdown, currentChar)
            local dropdownText = _G[typeManagerFrame.wlCharSelectDropdown:GetName() .. "Text"]
            if dropdownText then
                -- 使用统一的颜色代码格式
                local currentClass = GetCharClass and GetCharClass(currentChar) or nil
                local currentColor = (currentClass and GetClassColorHex and GetClassColorHex(currentClass)) or "|cffffffff"
                dropdownText:SetText(currentColor .. currentChar .. "|r")
            end
        end
        
    end
    if not typeManagerFrame then
        typeManagerFrame = CreateFrame("Frame", "AutoSellTypeManagerFrame", UIParent, "BackdropTemplate")
        typeManagerFrame:SetSize(500, 400) -- 超紧凑初始高度，后续动态调整
        typeManagerFrame:SetPoint("CENTER")
        typeManagerFrame:SetFrameStrata("DIALOG")
        typeManagerFrame:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = nil,
            tile = true, tileSize = 16, edgeSize = 0,
            insets = {left = 0, right = 0, top = 0, bottom = 0}
        })
        typeManagerFrame:SetBackdropColor(0,0,0,0.92)
        typeManagerFrame:EnableMouse(true)
        typeManagerFrame:SetMovable(true)
        typeManagerFrame:RegisterForDrag("LeftButton")
        typeManagerFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
        typeManagerFrame:SetScript("OnDragStop", function(self)
            self:StopMovingOrSizing()
            local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
            if not AutoSellLowLevelGearDB then AutoSellLowLevelGearDB = {} end
            AutoSellLowLevelGearDB.framePos = {point=point, relativePoint=relativePoint, x=xOfs, y=yOfs}
        end)
        table.insert(UISpecialFrames, "AutoSellTypeManagerFrame")
        typeManagerFrame:SetPropagateKeyboardInput(true)
        -- 右上角X关闭按钮
        typeManagerFrame.closeX = CreateFrame("Button", nil, typeManagerFrame, "UIPanelCloseButton")
        typeManagerFrame.closeX:SetSize(24, 24)
        typeManagerFrame.closeX:SetPoint("TOPRIGHT", typeManagerFrame, "TOPRIGHT", -4, -4)
        
        -- 主题切换按钮系统
        typeManagerFrame.currentTab = "settings" -- 默认显示设置内容
        
        -- 极简风按钮（左侧外边缘，最上方）
        typeManagerFrame.minimalistTabBtn = CreateFrame("Button", nil, typeManagerFrame, "UIPanelButtonTemplate")
        typeManagerFrame.minimalistTabBtn:SetSize(60, 24)
        typeManagerFrame.minimalistTabBtn:SetPoint("TOPRIGHT", typeManagerFrame, "TOPLEFT", -10, -10) -- 窗口左侧外边缘，最上方
        typeManagerFrame.minimalistTabBtn:SetText("极简风")
        typeManagerFrame.minimalistTabBtn:SetNormalFontObject(GameFontNormal)
        typeManagerFrame.minimalistTabBtn:SetHighlightFontObject(GameFontNormal)
        
        -- 原始风按钮（极简风按钮下方）
        typeManagerFrame.originalTabBtn = CreateFrame("Button", nil, typeManagerFrame, "UIPanelButtonTemplate")
        typeManagerFrame.originalTabBtn:SetSize(60, 24)
        typeManagerFrame.originalTabBtn:SetPoint("TOP", typeManagerFrame.minimalistTabBtn, "BOTTOM", 0, -5) -- 增加间距
        typeManagerFrame.originalTabBtn:SetText("原始风")
        typeManagerFrame.originalTabBtn:SetNormalFontObject(GameFontNormal)
        typeManagerFrame.originalTabBtn:SetHighlightFontObject(GameFontNormal)
        
        -- 初始化主题设置
        if not AutoSellLowLevelGearDB.themeStyle then
            AutoSellLowLevelGearDB.themeStyle = "minimalist" -- 默认极简风
        end
        -- 主标题
        typeManagerFrame.mainTitle = typeManagerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
        typeManagerFrame.mainTitle:SetPoint("TOP", 0, -18)
        typeManagerFrame.mainTitle:SetText("|cffFFD100自动售卖低物品等级装备插件设置|r")
        -- 主标题左侧金币图标
        if not typeManagerFrame.mainIcon then
            typeManagerFrame.mainIcon = typeManagerFrame:CreateTexture(nil, "ARTWORK")
            typeManagerFrame.mainIcon:SetTexture("Interface\\Icons\\INV_Misc_Coin_01")
            typeManagerFrame.mainIcon:SetSize(20,20)
            typeManagerFrame.mainIcon:SetPoint("LEFT", typeManagerFrame.mainTitle, "LEFT", -25, 0)
        end
        
        -- 版本号信息（左上角）
        if not typeManagerFrame.versionInfo then
            typeManagerFrame.versionInfo = typeManagerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            typeManagerFrame.versionInfo:SetPoint("TOPLEFT", typeManagerFrame, "TOPLEFT", 10, -10)
            typeManagerFrame.versionInfo:SetText("版本 2.5")
            typeManagerFrame.versionInfo:SetTextColor(0.8, 0.8, 0.8)  -- 浅灰色
        end
        
        -- Powered by信息（右下角）
        if not typeManagerFrame.poweredByInfo then
            typeManagerFrame.poweredByInfo = typeManagerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            typeManagerFrame.poweredByInfo:SetPoint("BOTTOMRIGHT", typeManagerFrame, "BOTTOMRIGHT", -10, 10)
            -- 获取DK职业颜色
            local dkColor = CLASS_COLORS["DEATHKNIGHT"]
            local dkColorCode
            if dkColor then
                dkColorCode = string.format("|cff%02x%02x%02x", dkColor.r*255, dkColor.g*255, dkColor.b*255)
            else
                dkColorCode = "|cffc41e3a"  -- DK默认颜色 #C41E3A
            end
            -- 分别设置颜色：Powered by用浅灰色，名字用DK颜色
            typeManagerFrame.poweredByInfo:SetText("|cffcccccc" .. "Powered by " .. "|r" .. dkColorCode .. "牛奶红薯-白银之手" .. "|r")
        end
        -- 阈值设置行整体居中
        typeManagerFrame.lvRow = CreateFrame("Frame", nil, typeManagerFrame)
        typeManagerFrame.lvRow:SetSize(360, 32)
        typeManagerFrame.lvRow:SetPoint("TOP", typeManagerFrame, "TOP", 0, -54)
        -- 文字、输入框、后缀依次居中排列
        typeManagerFrame.lvLabel = typeManagerFrame.lvRow:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        typeManagerFrame.lvLabel:SetPoint("CENTER", typeManagerFrame.lvRow, "CENTER", -80, 0)
        typeManagerFrame.lvLabel:SetText("当物品等级低于")
        typeManagerFrame.lvEdit = CreateFrame("EditBox", nil, typeManagerFrame.lvRow, "InputBoxTemplate")
        typeManagerFrame.lvEdit:SetSize(48, 28)
        typeManagerFrame.lvEdit:SetPoint("LEFT", typeManagerFrame.lvLabel, "RIGHT", 4, 0)
        typeManagerFrame.lvEdit:SetAutoFocus(false)
        typeManagerFrame.lvEdit:SetFontObject("GameFontNormalLarge")
        typeManagerFrame.lvEdit:SetText(tostring(GetCurrentItemLevelThreshold()))
        typeManagerFrame.lvEdit:SetJustifyH("CENTER")
        typeManagerFrame.lvSuffix = typeManagerFrame.lvRow:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        typeManagerFrame.lvSuffix:SetPoint("LEFT", typeManagerFrame.lvEdit, "RIGHT", 4, 0)
        typeManagerFrame.lvSuffix:SetText("时将被自动售卖")
        -- "确定"按钮浮于输入框右侧
        typeManagerFrame.lvBtn = CreateFrame("Button", nil, typeManagerFrame.lvRow, "UIPanelButtonTemplate")
        typeManagerFrame.lvBtn:SetSize(48, 28)
        typeManagerFrame.lvBtn:SetPoint("LEFT", typeManagerFrame.lvEdit, "RIGHT", 0, 0)
        typeManagerFrame.lvBtn:SetText("确定")
        typeManagerFrame.lvBtn:SetFrameLevel(typeManagerFrame.lvEdit:GetFrameLevel() + 10)
        typeManagerFrame.lvBtn:Hide()
        -- 阈值数字颜色高亮（无论默认还是读取DB）
        local function setThresholdEditBox(val)
            typeManagerFrame.lvEdit:SetText("|cff13fff1"..tostring(val).."|r")
        end
        setThresholdEditBox(GetCurrentItemLevelThreshold())
        -- 输入框变动时
        typeManagerFrame.lvEdit:SetScript("OnTextChanged", function(self)
            local txt = self:GetText():gsub("|cff13fff1",""):gsub("|r","")
            local val = tonumber(txt)
            local dbVal = GetDBItemLevelThreshold()
            if val and val > 0 and val ~= dbVal then
                typeManagerFrame.lvBtn:Show()
            else
                typeManagerFrame.lvBtn:Hide()
            end
            -- 不再调用TryCloseSellPopupIfNoItems()
        end)
        -- 确定按钮点击
        typeManagerFrame.lvBtn:SetScript("OnClick", function()
            local txt = typeManagerFrame.lvEdit:GetText():gsub("|cff13fff1",""):gsub("|r","")
            local val = tonumber(txt)
            local dbVal = GetDBItemLevelThreshold()
            if val and val > 0 and val ~= dbVal then
                AutoSellLowLevelGearDB.itemLevelThreshold = val
                setThresholdEditBox(val)
                typeManagerFrame.lvBtn:Hide()
                typeManagerFrame.lvEdit:ClearFocus()
                print("装备等级阈值已设置为:"..val)
                -- 更新售卖窗口状态
                UpdateSellPopupStatus(true)
            end
        end)
        -- 回车保存
        typeManagerFrame.lvEdit:SetScript("OnEnterPressed", function(self)
            if typeManagerFrame.lvBtn:IsShown() then
                typeManagerFrame.lvBtn:Click()
            end
            self:ClearFocus()
        end)
        -- 居中整体
        typeManagerFrame.lvRow:SetPoint("TOP", typeManagerFrame.mainTitle, "BOTTOM", 0, -8)
        typeManagerFrame.lvRow:SetWidth(400)
        typeManagerFrame.lvLabel:SetJustifyH("CENTER")
        
        -- ========================================
        -- 动态布局系统：所有位置自动计算
        -- ========================================
        
        -- 布局起始位置和间距常量
        local currentY = -70  -- 当前Y位置指针
        local sectionGap = 30 -- 区域间间距
        local titleGap = 30   -- 标题与内容间距（增加与清空按钮的间距）
        local optionGap = 25  -- 高级选项标题与选项间距
        
        -- 第一区域：售卖装备类型管理
        currentY = currentY - sectionGap
        typeManagerFrame.typeTitle = typeManagerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        typeManagerFrame.typeTitle:SetPoint("TOPLEFT", typeManagerFrame, "TOPLEFT", 24, currentY)
        typeManagerFrame.typeTitle:SetText("售卖装备类型管理")
        
        -- 类型复选框滚动区域（增加1/5高度）
        local typeScrollHeight = SCROLL_HEIGHT * 1.2  -- 增加1/5高度
        currentY = currentY - titleGap - typeScrollHeight
        typeManagerFrame.typeScrollFrame = CreateFrame("ScrollFrame", nil, typeManagerFrame, "UIPanelScrollFrameTemplate")
        local typeScrollFrame = typeManagerFrame.typeScrollFrame
        local typeScrollChild = CreateFrame("Frame", nil, typeScrollFrame)
        typeScrollChild:SetSize(420, typeScrollHeight)
        typeScrollFrame:SetScrollChild(typeScrollChild)
        typeManagerFrame.typeScrollChild = typeScrollChild
        typeScrollFrame:ClearAllPoints()
        typeManagerFrame.typeScrollFrame:SetPoint("TOPLEFT", typeManagerFrame, "TOPLEFT", 60, currentY + typeScrollHeight)
        typeManagerFrame.typeScrollFrame:SetPoint("TOPRIGHT", typeManagerFrame, "TOPRIGHT", -50, currentY + typeScrollHeight)
        typeManagerFrame.typeScrollFrame:SetHeight(typeScrollHeight)
        -- 初始化白名单（只在首次使用时设置默认值）
        if not AutoSellLowLevelGearDB then AutoSellLowLevelGearDB = {} end
        if not AutoSellLowLevelGearDB.typeWhitelist then
            AutoSellLowLevelGearDB.typeWhitelist = {}
            -- 只在首次创建时设置默认值
            for k in pairs(EQUIP_LOC_NAMES) do
                if DEFAULT_TYPE_WHITELIST[k] ~= nil then
                    AutoSellLowLevelGearDB.typeWhitelist[k] = DEFAULT_TYPE_WHITELIST[k]
                end
            end
        end
        -- 刷新类型复选框
        local function RefreshTypeRows()
            for _, child in ipairs(typeScrollChild.rows or {}) do
                child:Hide()
                child:SetParent(nil)
            end
            typeScrollChild.rows = {}
            local allTypes = {}
            for equipLoc, cnName in pairs(EQUIP_LOC_NAMES) do
                if equipLoc ~= "ARTIFACT_RELIC" and equipLoc ~= "BIND_ON_EQUIP" and equipLoc ~= "SET_ITEM" then
                table.insert(allTypes, {equipLoc = equipLoc, cnName = cnName, checked = AutoSellLowLevelGearDB.typeWhitelist[equipLoc]})
            end
            end
            -- 单独插入神器圣物、装备绑定、职业套装兑换物选项到最后
            table.insert(allTypes, {equipLoc = "ARTIFACT_RELIC", cnName = "神器圣物", checked = AutoSellLowLevelGearDB.typeWhitelist["ARTIFACT_RELIC"]})
            table.insert(allTypes, {equipLoc = "BIND_ON_EQUIP", cnName = "装备绑定", checked = AutoSellLowLevelGearDB.typeWhitelist["BIND_ON_EQUIP"]})
            table.insert(allTypes, {equipLoc = "SET_ITEM", cnName = "职业套装兑换代币", checked = AutoSellLowLevelGearDB.typeWhitelist["SET_ITEM"]})
            table.sort(allTypes, function(a, b)
                if a.checked == b.checked then
                    return a.cnName < b.cnName
                else
                    return not a.checked and b.checked
                end
            end)
            local maxCol = 3
            local colWidth = 130
            for i, info in ipairs(allTypes) do
                local rowIdx = math.floor((i-1)/maxCol)
                local colIdx = (i-1)%maxCol
                local rowFrame = CreateFrame("Frame", nil, typeScrollChild)
                rowFrame:SetSize(colWidth, ROW_HEIGHT)
                rowFrame:SetPoint("TOPLEFT", typeScrollChild, "TOPLEFT", colIdx*colWidth, -rowIdx*ROW_HEIGHT)
                local cb = CreateFrame("CheckButton", nil, rowFrame, "UICheckButtonTemplate")
                cb:SetSize(22, 22)
                cb:SetPoint("LEFT", rowFrame, "LEFT", 0, 0)
                cb.text = cb:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                cb.text:SetPoint("LEFT", cb, "RIGHT", 4, 0)
                cb.text:SetText("  " .. info.cnName)
                cb:SetChecked(info.checked)
                cb:SetScript("OnClick", function(self)
                    if info.equipLoc == "AUTO_USE_TOKEN" then
                        AutoSellLowLevelGearDB.autoUseToken = self:GetChecked()
                        if self:GetChecked() then
                            print("已启用职业套装代币检测功能")
                            print("获得新代币时会自动检测并提示")
                            C_Timer.After(1, ScanBagForUsableTokens)
                        end
                    else
                        AutoSellLowLevelGearDB.typeWhitelist[info.equipLoc] = self:GetChecked()
                    end
                    RefreshTypeRows()
                    -- 自动刷新售卖流程
                    if MerchantFrame and MerchantFrame:IsShown() then
                        UpdateSellPopupStatus(false) -- 不显示消息，避免过多提示
                    end
                    -- 如果售卖弹窗已打开，也刷新它
                    if sellPopupFrame and sellPopupFrame:IsShown() then
                        C_Timer.After(0.1, function()
                            local itemsToSell, itemLinks = ScanBagForLowLevelGear(0, true) -- 静默扫描
                            popupItemsToSell = itemsToSell
                            RefreshCustomSellPopup()
                        end)
                    end
                end)
                table.insert(typeScrollChild.rows, rowFrame)
            end
            local totalRows = math.ceil(#allTypes/maxCol)
            typeScrollChild:SetHeight(math.max(SCROLL_HEIGHT, totalRows*ROW_HEIGHT))
        end
        RefreshTypeRows()
        
        -- 自动使用代币选项（暂时隐藏）
        if not typeManagerFrame.autoUseTokenCheckbox then
            typeManagerFrame.autoUseTokenCheckbox = CreateFrame("CheckButton", nil, typeManagerFrame, "UICheckButtonTemplate")
            typeManagerFrame.autoUseTokenCheckbox:SetSize(22, 22)
            typeManagerFrame.autoUseTokenCheckbox:SetPoint("TOPLEFT", typeManagerFrame, "TOPLEFT", 24, -245)  -- 向上移动75px：-320 -> -245
            typeManagerFrame.autoUseTokenCheckbox.text = typeManagerFrame.autoUseTokenCheckbox:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            typeManagerFrame.autoUseTokenCheckbox.text:SetPoint("LEFT", typeManagerFrame.autoUseTokenCheckbox, "RIGHT", 4, 0)
            typeManagerFrame.autoUseTokenCheckbox.text:SetText("自动使用职业代币")
            typeManagerFrame.autoUseTokenCheckbox:SetScript("OnClick", function(self)
                AutoSellLowLevelGearDB.autoUseToken = self:GetChecked()
                if self:GetChecked() then
                    print("已启用自动使用职业代币功能")
                    print("|cffff8000注意：只会自动使用可直接右键使用的代币，需要NPC兑换的代币(如圣洁印记)不会自动使用|r")
                    C_Timer.After(1, ScanBagForUsableTokens)
                end
            end)
        end
        -- 暂时隐藏自动使用代币选项
        typeManagerFrame.autoUseTokenCheckbox:SetChecked(AutoSellLowLevelGearDB.autoUseToken)
        typeManagerFrame.autoUseTokenCheckbox:Hide() -- 隐藏选项
        
        -- 第二区域：高级选项
        currentY = currentY - sectionGap
        if not typeManagerFrame.advancedOptionsTitle then
            typeManagerFrame.advancedOptionsTitle = typeManagerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
            typeManagerFrame.advancedOptionsTitle:SetText("高级选项")
        end
        typeManagerFrame.advancedOptionsTitle:SetPoint("TOPLEFT", typeManagerFrame, "TOPLEFT", 24, currentY)
        
        -- 高级选项两列布局 (动态计算位置)
        currentY = currentY - optionGap  -- 使用专门的选项间距
        local optionStartY = currentY
        local leftX = 24           -- 左列X位置  
        local rightX = 300         -- 右列X位置
        local optionHeight = 28    -- 选项间距（增加3px）
        local currentRow = 0       -- 当前行数计数器
        
        -- 定义所有高级选项 (便于动态管理)
        local advancedOptions = {
            {
                id = "dontSellClassTokens",
                text = "不自动出售本职业可使用代币",
                column = "left",
                setting = "dontSellClassTokens",
                defaultValue = false,
                onClickMessage = {
                    enabled = "已启用：不自动出售本职业可使用的套装代币",
                    disabled = ""
                }
            },
            {
                id = "dontSellUnlearnedCosmetics", 
                text = "不自动出售未收藏的装饰品",
                column = "right",
                setting = "dontSellUnlearnedCosmetics",
                defaultValue = false,
                onClickMessage = {
                    enabled = "已启用：不自动出售未收藏的装饰品",
                    disabled = "已禁用：装饰品保护功能，装饰品将按照正常规则出售"
                }
            },
            {
                id = "useNewTokenSystem",
                text = "使用新的代币识别系统（推荐）",
                column = "left",
                setting = "useNewTokenSystem", 
                defaultValue = true,
                onClickMessage = {
                    enabled = "|cff00ff00已启用新代币识别系统|r\n- 基于Wowhead调研的准确规律\n- 自动适应新版本代币\n- 无需维护ID列表",
                    disabled = "|cffff8000已切换到原代币识别系统|r\n- 基于预设ID列表\n- 可能不包含最新代币"
                },
                customHandler = function(checked)
                    USE_NEW_TOKEN_SYSTEM = checked
                    AutoSellLowLevelGearDB.useNewTokenSystem = USE_NEW_TOKEN_SYSTEM
                end
            }
            -- 演示：轻松添加新选项的示例（注释掉，取消注释即可启用）
            --[[
            {
                id = "demoOption1",
                text = "演示选项1：自动整理背包",
                column = "right",
                setting = "demoOption1",
                defaultValue = false,
                onClickMessage = {
                    enabled = "已启用演示选项1",
                    disabled = "已禁用演示选项1"
                }
            },
            {
                id = "demoOption2", 
                text = "演示选项2：智能修装备",
                column = "left",
                setting = "demoOption2",
                defaultValue = true,
                onClickMessage = {
                    enabled = "已启用演示选项2",
                    disabled = "已禁用演示选项2"
                }
            }
            --]]
        }
        
        -- 计算所需的总行数
        local totalRows = math.ceil(#advancedOptions / 2)
        
        -- 动态创建所有高级选项
        if not typeManagerFrame.advancedOptionCheckboxes then
            typeManagerFrame.advancedOptionCheckboxes = {}
        end
        
        for i, option in ipairs(advancedOptions) do
            local checkboxKey = option.id .. "Checkbox"
            
            -- 计算位置
            local row = math.floor((i - 1) / 2)
            local col = (i - 1) % 2
            local xPos = col == 0 and leftX or rightX
            local yPos = optionStartY - (row * optionHeight)
            
            -- 创建复选框
            if not typeManagerFrame.advancedOptionCheckboxes[option.id] then
                local checkbox = CreateFrame("CheckButton", nil, typeManagerFrame, "UICheckButtonTemplate")
                checkbox:SetSize(22, 22)
                checkbox.text = checkbox:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
                checkbox.text:SetPoint("LEFT", checkbox, "RIGHT", 4, 0)
                checkbox.text:SetText(option.text)
                
                -- 设置点击处理
                checkbox:SetScript("OnClick", function(self)
                    local checked = self:GetChecked()
                    AutoSellLowLevelGearDB[option.setting] = checked
                    
                    -- 处理自定义逻辑
                    if option.customHandler then
                        option.customHandler(checked)
                    end
                    
                    -- 显示消息
                    local message = checked and option.onClickMessage.enabled or option.onClickMessage.disabled
                    if message then
                        if string.find(message, "\n") then
                            -- 多行消息，逐行打印
                            for line in message:gmatch("[^\n]+") do
                                print(line)
                            end
                        else
                            print(message)
                        end
                    end
                    
                    -- 刷新商人界面
                    if MerchantFrame and MerchantFrame:IsShown() then
                        C_Timer.After(0.1, function()
                            UpdateSellPopupStatus(false)
                        end)
                    end
                end)
                
                typeManagerFrame.advancedOptionCheckboxes[option.id] = checkbox
                
                -- 兼容性：为旧代码保留引用
                if option.id == "dontSellClassTokens" then
                    typeManagerFrame.dontSellClassTokensCheckbox = checkbox
                elseif option.id == "dontSellUnlearnedCosmetics" then
                    typeManagerFrame.dontSellUnlearnedCosmeticsCheckbox = checkbox
                elseif option.id == "useNewTokenSystem" then
                    typeManagerFrame.useNewTokenSystemCheckbox = checkbox
                end
            end
            
            local checkbox = typeManagerFrame.advancedOptionCheckboxes[option.id]
            checkbox:SetPoint("TOPLEFT", typeManagerFrame, "TOPLEFT", xPos, yPos)
            checkbox:SetChecked(AutoSellLowLevelGearDB[option.setting] or option.defaultValue)
            checkbox:Show()
        end
        
        -- 更新 currentY 到高级选项区域底部
        currentY = optionStartY - (totalRows * optionHeight)
        
        -- 第三区域：黑名单 (动态计算位置)
        currentY = currentY - sectionGap
        local blacklistTitleY = currentY
        local blacklistScrollY = blacklistTitleY - titleGap
        
        -- 第四区域：黑名单导入模块 (动态计算位置)
        -- 先计算导入模块的位置（给滚动区域留出更多空间）
        local importModuleY = blacklistScrollY - 160  -- 给滚动区域预留160px高度（缩短1/5）
        local importModuleHeight = 32 -- 导入模块高度
        
        -- 计算黑名单滚动区域的实际高度（延伸到导入模块上方）
        local blacklistScrollHeight = math.abs(blacklistScrollY - importModuleY) - 10  -- 留10px间隙
        
        -- 更新 currentY 到导入模块位置
        currentY = importModuleY
        
        
        -- 黑名单分区标题 (动态位置，永不重叠)
        typeManagerFrame.blTitle = typeManagerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        typeManagerFrame.blTitle:SetText("黑名单列表（不售卖）")
        typeManagerFrame.blTitle:SetPoint("TOPLEFT", typeManagerFrame, "TOPLEFT", 24, blacklistTitleY)
        
        -- 黑名单数量统计
        if not typeManagerFrame.blCount then
            typeManagerFrame.blCount = typeManagerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            typeManagerFrame.blCount:SetTextColor(0.8, 0.8, 0.8)  -- 浅灰色
        end
        -- 计算居中位置：在标题和按钮之间
        typeManagerFrame.blCount:SetPoint("LEFT", typeManagerFrame.blTitle, "RIGHT", 80, 0)
        typeManagerFrame.blCount:SetText("共" .. GetTableSize(BLACKLIST) .. "个")
        
        -- 清空黑名单按钮
        typeManagerFrame.clearBlacklistBtn = CreateFrame("Button", nil, typeManagerFrame, "UIPanelButtonTemplate")
        typeManagerFrame.clearBlacklistBtn:SetSize(100, 24)
        typeManagerFrame.clearBlacklistBtn:SetPoint("TOPRIGHT", typeManagerFrame, "TOPRIGHT", -24, blacklistTitleY + 3)
        typeManagerFrame.clearBlacklistBtn:SetText("清空黑名单")
        -- 清空黑名单按钮前加小X图标
        if not typeManagerFrame.clearBlacklistBtn.icon then
            local icon = typeManagerFrame.clearBlacklistBtn:CreateTexture(nil, "ARTWORK")
            icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
            icon:SetSize(16,16)
            icon:SetPoint("LEFT", typeManagerFrame.clearBlacklistBtn, "LEFT", 4, 0)
            typeManagerFrame.clearBlacklistBtn.icon = icon
            typeManagerFrame.clearBlacklistBtn:SetText("  清空黑名单")
        end
        typeManagerFrame.clearBlacklistBtn:SetScript("OnClick", function()
            -- 清空内存中的黑名单
            for k in pairs(BLACKLIST) do
                BLACKLIST[k] = nil
            end
            for k in pairs(BLACKLIST_NAMES) do
                BLACKLIST_NAMES[k] = nil
            end
            
            -- 根据当前模式保存
            local currentChar = GetCurrentCharacterKey()
            if blacklistMode == "global" then
                SaveGlobalBlacklist(BLACKLIST)
                print("跨服通用黑名单已清空")
            else
                if blacklistMode == "global" then
                SaveGlobalBlacklist(BLACKLIST)
                print("已保存到跨服通用黑名单")
            else
                SaveBlacklist(currentChar)
                print("已保存到角色独立黑名单")
            end
                print("角色", currentChar, "的黑名单已清空")
            end
            
            -- 重置下拉框为当前角色
            UIDropDownMenu_SetSelectedValue(typeManagerFrame.charSelectDropdown, currentChar)
            local dropdownText = _G[typeManagerFrame.charSelectDropdown:GetName() .. "Text"]
            if dropdownText then
                local currentClass = GetCharClass and GetCharClass(currentChar) or nil
                local currentColor = (currentClass and GetClassColorHex and GetClassColorHex(currentClass)) or "|cffffffff"
                dropdownText:SetText(currentColor .. currentChar .. "|r")
            end
            RefreshTypeManagerBlacklist()
            -- 新增：如果当前在商人界面，自动重新扫描并弹出售卖确认弹窗
            if MerchantFrame and MerchantFrame:IsShown() then
                C_Timer.After(0.1, function()
                    UpdateSellPopupStatus(false) -- 不显示消息，避免过多提示
                end)
            end
        end)
        -- 黑名单列表区域 (动态位置，固定高度，永不重叠)
        local BL_SCROLL_WIDTH = 520 -- 固定宽度，确保不超出窗口边界
        local blScrollFrame = CreateFrame("ScrollFrame", nil, typeManagerFrame, "UIPanelScrollFrameTemplate")
        blScrollFrame:SetPoint("TOPLEFT", typeManagerFrame, "TOPLEFT", 24, blacklistScrollY) -- 动态位置，左边距24px
        blScrollFrame:SetPoint("TOPRIGHT", typeManagerFrame, "TOPRIGHT", -50, blacklistScrollY) -- 右边距50px，为滚动条留空间
        blScrollFrame:SetHeight(blacklistScrollHeight) -- 使用计算出的动态高度
        typeManagerFrame.scrollFrame = blScrollFrame
        local blScrollChild = CreateFrame("Frame", nil, blScrollFrame)
        -- 使用实际滚动框宽度，自动适配窗口大小
        blScrollChild:SetSize(500, blacklistScrollHeight) -- 内容区域宽度
        blScrollFrame:SetScrollChild(blScrollChild)
        typeManagerFrame.scrollChild = blScrollChild
        
        -- 添加拖拽功能到黑名单区域
        blScrollFrame:EnableMouse(true)
        blScrollFrame:RegisterForDrag("LeftButton")
        blScrollFrame:SetScript("OnReceiveDrag", function(self)
            local cursorType, cursorData = GetCursorInfo()
            if cursorType == "item" then
                local itemID = cursorData
                local itemName, itemLink = GetItemInfo(itemID)
                if itemLink then
                    AddToBlacklist(nil, itemLink)
                    ClearCursor()
                end
            end
        end)
        
        -- 也为滚动内容区域添加拖拽功能
        blScrollChild:EnableMouse(true)
        blScrollChild:RegisterForDrag("LeftButton")
        blScrollChild:SetScript("OnReceiveDrag", function(self)
            local cursorType, cursorData = GetCursorInfo()
            if cursorType == "item" then
                local itemID = cursorData
                local itemName, itemLink = GetItemInfo(itemID)
                if itemLink then
                    AddToBlacklist(nil, itemLink)
                    ClearCursor()
                end
            end
        end)
        
        -- ========================================
        -- 黑名单导入模块 (动态位置)
        -- ========================================
        
        -- 先创建控件
        -- 黑名单模式切换按钮
        if not typeManagerFrame.blModeToggleBtn then
            typeManagerFrame.blModeToggleBtn = CreateFrame("Button", nil, typeManagerFrame, "UIPanelButtonTemplate")
            typeManagerFrame.blModeToggleBtn:SetSize(50, 24)
            typeManagerFrame.blModeToggleBtn:SetText("独立")
        end
        
        if not typeManagerFrame.charSelectLabel then
            typeManagerFrame.charSelectLabel = typeManagerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            typeManagerFrame.charSelectLabel:SetText("角色:")
        end
        
        if not typeManagerFrame.charSelectDropdown then
            typeManagerFrame.charSelectDropdown = CreateFrame("Frame", "AutoSellCharSelectDropdown", typeManagerFrame, "UIDropDownMenuTemplate")
        end
        
        if not typeManagerFrame.importBtn then
            typeManagerFrame.importBtn = CreateFrame("Button", nil, typeManagerFrame, "UIPanelButtonTemplate")
            typeManagerFrame.importBtn:SetText("导入")
        end
        
        -- 导入模块布局参数
        local modeToggleBtnWidth = 50
        local labelWidth = 50
        local dropdownWidth = 180
        local btnWidth = 70
        local gap1, gap2, gap3 = 5, 5, 10
        local totalWidth = modeToggleBtnWidth + gap1 + labelWidth + gap2 + dropdownWidth + gap3 + btnWidth
        
        -- 创建容器框架，使用动态位置
        if not typeManagerFrame.importModuleRow then
            typeManagerFrame.importModuleRow = CreateFrame("Frame", nil, typeManagerFrame)
        end
        typeManagerFrame.importModuleRow:SetSize(totalWidth, importModuleHeight)
        -- 水平居中对齐导入模块 - 使用实际窗口宽度500px
        local frameWidth = 500 -- 窗口实际宽度
        local centerX = (frameWidth - totalWidth) / 2
        typeManagerFrame.importModuleRow:SetPoint("TOPLEFT", typeManagerFrame, "TOPLEFT", centerX, importModuleY)
        
        -- 模式切换按钮布局
        typeManagerFrame.blModeToggleBtn:ClearAllPoints()
        typeManagerFrame.blModeToggleBtn:SetPoint("LEFT", typeManagerFrame.importModuleRow, "LEFT", 0, 0)
        typeManagerFrame.blModeToggleBtn:SetPoint("TOP", typeManagerFrame.importModuleRow, "TOP", 0, -4)
        
        -- 标签垂直居中对齐 (使用新容器)
        typeManagerFrame.charSelectLabel:ClearAllPoints()
        typeManagerFrame.charSelectLabel:SetPoint("LEFT", typeManagerFrame.blModeToggleBtn, "RIGHT", gap1, 0)
        typeManagerFrame.charSelectLabel:SetPoint("TOP", typeManagerFrame.importModuleRow, "TOP", 0, 0)
        typeManagerFrame.charSelectLabel:SetPoint("BOTTOM", typeManagerFrame.importModuleRow, "BOTTOM", 0, 0)
        typeManagerFrame.charSelectLabel:SetWidth(labelWidth)
        typeManagerFrame.charSelectLabel:SetJustifyH("RIGHT")
        typeManagerFrame.charSelectLabel:SetJustifyV("MIDDLE")
        
        -- 下拉框垂直居中对齐 (使用新容器)
        typeManagerFrame.charSelectDropdown:ClearAllPoints()
        typeManagerFrame.charSelectDropdown:SetPoint("LEFT", typeManagerFrame.charSelectLabel, "RIGHT", gap2, 0)
        typeManagerFrame.charSelectDropdown:SetPoint("TOP", typeManagerFrame.importModuleRow, "TOP", 0, -3) -- 微调向下3像素
        typeManagerFrame.charSelectDropdown:SetWidth(dropdownWidth)
        
        -- 按钮垂直居中对齐 (使用新容器)
        typeManagerFrame.importBtn:ClearAllPoints()
        typeManagerFrame.importBtn:SetPoint("LEFT", typeManagerFrame.charSelectDropdown, "RIGHT", gap3, 0)
        typeManagerFrame.importBtn:SetPoint("TOP", typeManagerFrame.importModuleRow, "TOP", 0, -2) -- 微调向下2像素
        typeManagerFrame.importBtn:SetPoint("BOTTOM", typeManagerFrame.importModuleRow, "BOTTOM", 0, 2) -- 微调向上2像素
        typeManagerFrame.importBtn:SetWidth(btnWidth)
        typeManagerFrame.importBtn:SetText("导入")
        local importBtnText = typeManagerFrame.importBtn:GetFontString()
        if importBtnText then
            importBtnText:SetFontObject(GameFontNormal)
            importBtnText:SetTextColor(1, 0.82, 0)
        end
        typeManagerFrame.importBtn:SetNormalFontObject(GameFontNormal)
        typeManagerFrame.importBtn:SetHighlightFontObject(GameFontNormal)
        
        -- 隐藏旧的bottomRow容器（如果存在）
        if typeManagerFrame.bottomRow then
            typeManagerFrame.bottomRow:Hide()
        end
        
        -- ========================================
        -- 白名单系统UI（在黑名单导入模块下方）
        -- ========================================
        
        -- 更新 currentY 到黑名单导入模块底部
        currentY = importModuleY - importModuleHeight
        
        -- 第五区域：白名单 (动态计算位置)
        currentY = currentY - sectionGap
        local whitelistTitleY = currentY
        local whitelistScrollY = whitelistTitleY - titleGap
        
        -- 第六区域：白名单导入模块 (动态计算位置)
        -- 先计算导入模块的位置（给滚动区域留出更多空间）
        local whitelistImportModuleY = whitelistScrollY - 160  -- 给滚动区域预留160px高度（缩短1/5）
        
        -- 计算白名单滚动区域的实际高度（延伸到导入模块上方）
        local whitelistScrollHeight = math.abs(whitelistScrollY - whitelistImportModuleY) - 10  -- 留10px间隙
        
        -- 更新 currentY 到白名单导入模块位置
        currentY = whitelistImportModuleY
        
        -- 🎯 精确窗口高度计算：基于实际内容位置
        local minWindowHeight = 400    -- 最小窗口高度
        
        -- 计算真正的内容底部位置：白名单导入模块的底部
        local contentBottomY = whitelistImportModuleY - importModuleHeight
        
        -- 窗口高度 = 内容实际占用高度 + 底部边距
        -- 由于所有Y坐标都是负数，math.abs(contentBottomY)就是从窗口顶部到内容底部的距离
        local requiredHeight = math.abs(contentBottomY) + sectionGap -- 内容高度 + 底部边距30px
        local optimalHeight = math.max(minWindowHeight, requiredHeight)
        
        -- 应用计算出的高度
        typeManagerFrame:SetHeight(optimalHeight)
        
        -- 调试信息已移除
        
        -- 白名单分区标题
        if not typeManagerFrame.wlTitle then
            typeManagerFrame.wlTitle = typeManagerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
            typeManagerFrame.wlTitle:SetText("白名单列表（无条件售卖）")
            typeManagerFrame.wlTitle:SetTextColor(0.5, 1, 0.5) -- 绿色主题
        end
        typeManagerFrame.wlTitle:SetPoint("TOPLEFT", typeManagerFrame, "TOPLEFT", 24, whitelistTitleY)
        
        -- 白名单数量统计
        if not typeManagerFrame.wlCount then
            typeManagerFrame.wlCount = typeManagerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            typeManagerFrame.wlCount:SetTextColor(0.8, 0.8, 0.8)  -- 浅灰色
        end
        -- 计算居中位置：在标题和按钮之间
        typeManagerFrame.wlCount:SetPoint("LEFT", typeManagerFrame.wlTitle, "RIGHT", 80, 0)
        typeManagerFrame.wlCount:SetText("共" .. GetTableSize(WHITELIST) .. "个")
        
        -- 清空白名单按钮
        if not typeManagerFrame.clearWhitelistBtn then
            typeManagerFrame.clearWhitelistBtn = CreateFrame("Button", nil, typeManagerFrame, "UIPanelButtonTemplate")
            typeManagerFrame.clearWhitelistBtn:SetSize(100, 24)
            typeManagerFrame.clearWhitelistBtn:SetText("清空白名单")
            -- 清空白名单按钮前加勾号图标
            local icon = typeManagerFrame.clearWhitelistBtn:CreateTexture(nil, "ARTWORK")
            icon:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
            icon:SetSize(16,16)
            icon:SetPoint("LEFT", typeManagerFrame.clearWhitelistBtn, "LEFT", 4, 0)
            icon:SetVertexColor(0.5, 1, 0.5) -- 绿色主题
            typeManagerFrame.clearWhitelistBtn.icon = icon
            typeManagerFrame.clearWhitelistBtn:SetText("  清空白名单")
        end
        typeManagerFrame.clearWhitelistBtn:SetPoint("TOPRIGHT", typeManagerFrame, "TOPRIGHT", -24, whitelistTitleY + 3)
        
        -- 白名单列表滚动区域
        if not typeManagerFrame.wlScrollFrame then
            typeManagerFrame.wlScrollFrame = CreateFrame("ScrollFrame", nil, typeManagerFrame, "UIPanelScrollFrameTemplate")
            local wlScrollChild = CreateFrame("Frame", nil, typeManagerFrame.wlScrollFrame)
            wlScrollChild:SetSize(500, whitelistScrollHeight)
            typeManagerFrame.wlScrollFrame:SetScrollChild(wlScrollChild)
            typeManagerFrame.wlScrollChild = wlScrollChild
            
            -- 添加拖拽功能到白名单区域
            typeManagerFrame.wlScrollFrame:EnableMouse(true)
            typeManagerFrame.wlScrollFrame:RegisterForDrag("LeftButton")
            typeManagerFrame.wlScrollFrame:SetScript("OnReceiveDrag", function(self)
                local cursorType, cursorData = GetCursorInfo()
                if cursorType == "item" then
                    local itemID = cursorData
                    local itemName, itemLink = GetItemInfo(itemID)
                    if itemLink then
                        AddToWhitelist(nil, itemLink)
                        ClearCursor()
                    end
                end
            end)
            
            -- 也为滚动内容区域添加拖拽功能
            typeManagerFrame.wlScrollChild:EnableMouse(true)
            typeManagerFrame.wlScrollChild:RegisterForDrag("LeftButton")
            typeManagerFrame.wlScrollChild:SetScript("OnReceiveDrag", function(self)
                local cursorType, cursorData = GetCursorInfo()
                if cursorType == "item" then
                    local itemID = cursorData
                    local itemName, itemLink = GetItemInfo(itemID)
                    if itemLink then
                        AddToWhitelist(nil, itemLink)
                        ClearCursor()
                    end
                end
            end)
        end
        typeManagerFrame.wlScrollFrame:SetPoint("TOPLEFT", typeManagerFrame, "TOPLEFT", 24, whitelistScrollY)
        typeManagerFrame.wlScrollFrame:SetPoint("TOPRIGHT", typeManagerFrame, "TOPRIGHT", -50, whitelistScrollY)
        typeManagerFrame.wlScrollFrame:SetHeight(whitelistScrollHeight)
        
        -- 白名单导入模块（类似黑名单导入模块）
        if not typeManagerFrame.wlImportModuleRow then
            typeManagerFrame.wlImportModuleRow = CreateFrame("Frame", nil, typeManagerFrame)
            
            -- 白名单模式切换按钮
            typeManagerFrame.wlModeToggleBtn = CreateFrame("Button", nil, typeManagerFrame, "UIPanelButtonTemplate")
            typeManagerFrame.wlModeToggleBtn:SetSize(50, 24)
            typeManagerFrame.wlModeToggleBtn:SetText("独立")
            
            -- 白名单角色选择标签
            typeManagerFrame.wlCharSelectLabel = typeManagerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            typeManagerFrame.wlCharSelectLabel:SetText("角色:")
            typeManagerFrame.wlCharSelectLabel:SetTextColor(0.5, 1, 0.5) -- 绿色主题
            
            -- 白名单角色选择下拉框
            typeManagerFrame.wlCharSelectDropdown = CreateFrame("Frame", "AutoSellWLCharSelectDropdown", typeManagerFrame, "UIDropDownMenuTemplate")
            
            -- 白名单导入按钮
            typeManagerFrame.wlImportBtn = CreateFrame("Button", nil, typeManagerFrame, "UIPanelButtonTemplate")
            typeManagerFrame.wlImportBtn:SetText("导入")
        end
        
        typeManagerFrame.wlImportModuleRow:SetSize(totalWidth, importModuleHeight)
        typeManagerFrame.wlImportModuleRow:SetPoint("TOPLEFT", typeManagerFrame, "TOPLEFT", centerX, whitelistImportModuleY)
        
        -- 白名单导入模块布局
        -- 白名单模式切换按钮布局
        typeManagerFrame.wlModeToggleBtn:ClearAllPoints()
        typeManagerFrame.wlModeToggleBtn:SetPoint("LEFT", typeManagerFrame.wlImportModuleRow, "LEFT", 0, 0)
        typeManagerFrame.wlModeToggleBtn:SetPoint("TOP", typeManagerFrame.wlImportModuleRow, "TOP", 0, -4)
        
        typeManagerFrame.wlCharSelectLabel:ClearAllPoints()
        typeManagerFrame.wlCharSelectLabel:SetPoint("LEFT", typeManagerFrame.wlModeToggleBtn, "RIGHT", gap1, 0)
        typeManagerFrame.wlCharSelectLabel:SetPoint("TOP", typeManagerFrame.wlImportModuleRow, "TOP", 0, 0)
        typeManagerFrame.wlCharSelectLabel:SetPoint("BOTTOM", typeManagerFrame.wlImportModuleRow, "BOTTOM", 0, 0)
        typeManagerFrame.wlCharSelectLabel:SetWidth(labelWidth)
        typeManagerFrame.wlCharSelectLabel:SetJustifyH("RIGHT")
        typeManagerFrame.wlCharSelectLabel:SetJustifyV("MIDDLE")
        
        typeManagerFrame.wlCharSelectDropdown:ClearAllPoints()
        typeManagerFrame.wlCharSelectDropdown:SetPoint("LEFT", typeManagerFrame.wlCharSelectLabel, "RIGHT", gap2, 0)
        typeManagerFrame.wlCharSelectDropdown:SetPoint("TOP", typeManagerFrame.wlImportModuleRow, "TOP", 0, -3)
        typeManagerFrame.wlCharSelectDropdown:SetWidth(dropdownWidth)
        
        typeManagerFrame.wlImportBtn:ClearAllPoints()
        typeManagerFrame.wlImportBtn:SetPoint("LEFT", typeManagerFrame.wlCharSelectDropdown, "RIGHT", gap3, 0)
        typeManagerFrame.wlImportBtn:SetPoint("TOP", typeManagerFrame.wlImportModuleRow, "TOP", 0, -2)
        typeManagerFrame.wlImportBtn:SetPoint("BOTTOM", typeManagerFrame.wlImportModuleRow, "BOTTOM", 0, 2)
        typeManagerFrame.wlImportBtn:SetWidth(btnWidth)
        
        -- ========================================
        -- 🎉 动态布局系统完成！
        -- 
        -- 整个界面现在采用完全自动的位置计算系统：
        -- 1. 第一区域：售卖装备类型管理
        -- 2. 第二区域：高级选项 (可通过advancedOptions表轻松扩展)
        -- 3. 第三区域：黑名单列表
        -- 4. 第四区域：黑名单导入模块  
        -- 5. 第五区域：白名单列表
        -- 6. 第六区域：白名单导入模块
        -- 
        -- 所有区域位置基于currentY指针自动计算，添加新功能时：
        -- - 无需手动调整任何Y坐标
        -- - 自动防止重叠
        -- - 自动调整窗口高度
        -- - 自动处理间距
        -- 
        -- 扩展方法：
        -- 1. 新增高级选项：在advancedOptions表中添加配置
        -- 2. 新增区域：在适当位置插入新的currentY计算
        -- ========================================
        typeManagerFrame.importBtn:SetScript("OnClick", function()
            local selectedChar = UIDropDownMenu_GetSelectedValue(typeManagerFrame.charSelectDropdown)
            local currentChar = GetCurrentCharacterKey()
            if selectedChar and selectedChar ~= currentChar then
                LoadBlacklist(currentChar)
                -- 在独立模式下，导入选中角色的独立黑名单
                local sourceBlacklist
                if blacklistMode == "character" then
                    sourceBlacklist = GetCharacterBlacklist(selectedChar)
                    print("正在从角色", selectedChar, "的独立黑名单导入数据...")
                else
                    -- 通用模式下，仍然导入角色的独立数据（用户可能想从角色数据导入到通用）
                    sourceBlacklist = GetCharacterBlacklist(selectedChar)
                    print("正在从角色", selectedChar, "的独立黑名单导入到通用黑名单...")
                end
                
                -- 检查源黑名单是否为空
                local sourceCount = GetTableSize(sourceBlacklist)
                if sourceCount == 0 then
                    local selectedClass = GetCharClass and GetCharClass(selectedChar) or nil
                    local selectedColor = (selectedClass and GetClassColorHex and GetClassColorHex(selectedClass)) or "|cffffffff"
                    print("角色", selectedColor .. selectedChar .. "|r", "的黑名单为空，无物品可导入")
                    
                    -- 即使导入失败，也要重置下拉框为当前角色
                    UIDropDownMenu_SetSelectedValue(typeManagerFrame.charSelectDropdown, currentChar)
                    RefreshTypeManagerBlacklist()
                    
                    -- 主题函数已经能够自动保持职业颜色
                    return
                end
                
                -- 先对源黑名单进行去重处理
                local sourceBlacklistNames = {}
                for itemLink, _ in pairs(sourceBlacklist) do
                    local itemName = GetItemInfo(itemLink)
                    if itemName then
                        sourceBlacklistNames[itemLink] = itemName
                    end
                end
                
                -- 去重处理
                local uniqueSourceBlacklist, uniqueSourceNames = RemoveDuplicateItems(sourceBlacklist, sourceBlacklistNames)
                
                -- 更新源数量为去重后的数量
                sourceCount = GetTableSize(uniqueSourceBlacklist)
                
                local importedCount = 0
                local duplicateCount = 0
                for itemLink, _ in pairs(uniqueSourceBlacklist) do
                    if not IsItemInBlacklistTable(itemLink, BLACKLIST) then
                        local itemName = uniqueSourceNames[itemLink]
                        if itemName then
                            BLACKLIST[itemLink] = true
                            BLACKLIST_NAMES[itemLink] = itemName
                            importedCount = importedCount + 1
                        end
                    else
                        duplicateCount = duplicateCount + 1
                    end
                end
                
                SaveCharacterBlacklist(currentChar, BLACKLIST)
                LoadBlacklist(currentChar)
                -- 导入完成后，重置下拉框为当前角色并刷新显示
                UIDropDownMenu_SetSelectedValue(typeManagerFrame.charSelectDropdown, currentChar)
                RefreshTypeManagerBlacklist()
                
                -- 主题函数已经能够自动保持职业颜色
                
                local selectedClass = GetCharClass and GetCharClass(selectedChar) or nil
                local selectedColor = (selectedClass and GetClassColorHex and GetClassColorHex(selectedClass)) or "|cffffffff"
                local currentClass = GetCharClass and GetCharClass(currentChar) or nil
                local currentColor = (currentClass and GetClassColorHex and GetClassColorHex(currentChar)) or "|cffffffff"
                
                if importedCount > 0 then
                    print("✅ 已从角色", selectedColor .. selectedChar .. "|r", "导入", importedCount, "个黑名单物品到当前角色", currentColor .. currentChar .. "|r")
                    if duplicateCount > 0 then
                        print("⚠️ 跳过", duplicateCount, "个重复物品（相同ID+等级+品质）")
                    end
                    print("📊 合并后总数：", GetTableSize(BLACKLIST), "个黑名单物品")
                else
                    print("ℹ️ 角色", selectedColor .. selectedChar .. "|r", "的", sourceCount, "个黑名单物品在当前角色", currentColor .. currentChar .. "|r", "中已存在，无需导入")
                end
            else
                print("请选择不同的角色进行导入")
            end
        end)
        
        -- 白名单导入按钮点击事件
        typeManagerFrame.wlImportBtn:SetScript("OnClick", function()
            local selectedChar = UIDropDownMenu_GetSelectedValue(typeManagerFrame.wlCharSelectDropdown)
            local currentChar = GetCurrentCharacterKey()
            if selectedChar and selectedChar ~= currentChar then
                LoadWhitelist(currentChar)
                -- 在独立模式下，导入选中角色的独立白名单
                local sourceWhitelist
                if whitelistMode == "character" then
                    sourceWhitelist = GetCharacterWhitelist(selectedChar)
                    print("正在从角色", selectedChar, "的独立白名单导入数据...")
                else
                    -- 通用模式下，仍然导入角色的独立数据（用户可能想从角色数据导入到通用）
                    sourceWhitelist = GetCharacterWhitelist(selectedChar)
                    print("正在从角色", selectedChar, "的独立白名单导入到通用白名单...")
                end
                
                
                -- 检查源白名单是否为空
                local sourceCount = GetTableSize(sourceWhitelist)
                if sourceCount == 0 then
                    local selectedClass = GetCharClass and GetCharClass(selectedChar) or nil
                    local selectedColor = (selectedClass and GetClassColorHex and GetClassColorHex(selectedClass)) or "|cffffffff"
                    print("角色", selectedColor .. selectedChar .. "|r", "的白名单为空，无物品可导入")
                    
                    -- 即使导入失败，也要重置下拉框为当前角色
                    UIDropDownMenu_SetSelectedValue(typeManagerFrame.wlCharSelectDropdown, currentChar)
                    RefreshTypeManagerWhitelist()
                    
                    -- 主题函数已经能够自动保持职业颜色
                    return
                end
                
                -- 先对源白名单进行去重处理
                local sourceWhitelistNames = {}
                for itemLink, _ in pairs(sourceWhitelist) do
                    local itemName = GetItemInfo(itemLink)
                    if itemName then
                        sourceWhitelistNames[itemLink] = itemName
                    end
                end
                
                -- 去重处理
                local uniqueSourceWhitelist, uniqueSourceNames = RemoveDuplicateItems(sourceWhitelist, sourceWhitelistNames)
                
                -- 更新源数量为去重后的数量
                sourceCount = GetTableSize(uniqueSourceWhitelist)
                
                local importedCount = 0
                local duplicateCount = 0
                for itemLink, _ in pairs(uniqueSourceWhitelist) do
                    if not IsItemInWhitelistTable(itemLink, WHITELIST) then
                        local itemName = uniqueSourceNames[itemLink]
                        if itemName then
                            WHITELIST[itemLink] = true
                            WHITELIST_NAMES[itemLink] = itemName
                            importedCount = importedCount + 1
                        end
                    else
                        duplicateCount = duplicateCount + 1
                    end
                end
                
                -- 保存合并后的白名单到当前角色
                if whitelistMode == "global" then
                SaveGlobalWhitelist(WHITELIST)
                print("已保存到跨服通用白名单")
            else
                SaveWhitelist(currentChar)
                print("已保存到角色独立白名单")
            end
                LoadWhitelist(currentChar)
                -- 导入完成后，重置下拉框为当前角色并刷新显示
                UIDropDownMenu_SetSelectedValue(typeManagerFrame.wlCharSelectDropdown, currentChar)
                RefreshTypeManagerWhitelist()
                
                
                -- 主题函数已经能够自动保持职业颜色
                
                local selectedClass = GetCharClass and GetCharClass(selectedChar) or nil
                local selectedColor = (selectedClass and GetClassColorHex and GetClassColorHex(selectedClass)) or "|cffffffff"
                local currentClass = GetCharClass and GetCharClass(currentChar) or nil
                local currentColor = (currentClass and GetClassColorHex and GetClassColorHex(currentChar)) or "|cffffffff"
                
                if importedCount > 0 then
                    print("✅ 已从角色", selectedColor .. selectedChar .. "|r", "导入", importedCount, "个白名单物品到当前角色", currentColor .. currentChar .. "|r")
                    if duplicateCount > 0 then
                        print("⚠️ 跳过", duplicateCount, "个重复物品（相同ID+等级+品质）")
                    end
                    print("📊 合并后总数：", GetTableSize(WHITELIST), "个白名单物品")
                else
                    print("ℹ️ 角色", selectedColor .. selectedChar .. "|r", "的", sourceCount, "个白名单物品在当前角色", currentColor .. currentChar .. "|r", "中已存在，无需导入")
                end
            else
                print("请选择不同的角色进行导入")
            end
        end)
        
        -- 清空白名单按钮点击事件
        typeManagerFrame.clearWhitelistBtn:SetScript("OnClick", function()
            -- 清空内存中的白名单
            for k in pairs(WHITELIST) do
                WHITELIST[k] = nil
            end
            for k in pairs(WHITELIST_NAMES) do
                WHITELIST_NAMES[k] = nil
            end
            
            -- 根据当前模式保存
            local currentChar = GetCurrentCharacterKey()
            if whitelistMode == "global" then
                SaveGlobalWhitelist(WHITELIST)
                print("跨服通用白名单已清空")
            else
                if whitelistMode == "global" then
                SaveGlobalWhitelist(WHITELIST)
                print("已保存到跨服通用白名单")
            else
                SaveWhitelist(currentChar)
                print("已保存到角色独立白名单")
            end
                print("角色", currentChar, "的白名单已清空")
            end
            
            -- 重置下拉框为当前角色
            UIDropDownMenu_SetSelectedValue(typeManagerFrame.wlCharSelectDropdown, currentChar)
            local dropdownText = _G[typeManagerFrame.wlCharSelectDropdown:GetName() .. "Text"]
            if dropdownText then
                local currentClass = GetCharClass and GetCharClass(currentChar) or nil
                local currentColor = (currentClass and GetClassColorHex and GetClassColorHex(currentClass)) or "|cffffffff"
                dropdownText:SetText(currentColor .. currentChar .. "|r")
            end
            RefreshTypeManagerWhitelist()
            -- 新增：如果当前在商人界面，自动重新扫描并弹出售卖确认弹窗
            if MerchantFrame and MerchantFrame:IsShown() then
                C_Timer.After(0.1, function()
                    UpdateSellPopupStatus(false) -- 不显示消息，避免过多提示
                end)
            end
        end)
        
        -- 职业色已在文件顶部定义为全局变量
        -- GetClassColorHex和GetCharClass函数已移到文件顶部作为全局函数
        -- 初始化角色选择下拉框
        local function InitializeCharDropdown()
            local characters = GetAllCharacters()
            local currentChar = GetCurrentCharacterKey()
            local found = false
            for i, char in ipairs(characters) do
                if char == currentChar then
                    found = true
                    table.remove(characters, i)
                    break
                end
            end
            table.insert(characters, 1, currentChar)
            UIDropDownMenu_SetWidth(typeManagerFrame.charSelectDropdown, 150)
            UIDropDownMenu_Initialize(typeManagerFrame.charSelectDropdown, function(self, level)
                local totalChars = #characters
                local maxVisible = 8
                
                -- 如果角色数量超过最大显示数，只显示前8个，其余通过滚动查看
                if totalChars > maxVisible then
                    -- 获取滚动偏移量
                    if not self.scrollIndex then
                        self.scrollIndex = 1
                    end
                    
                    local startIndex = self.scrollIndex
                    local endIndex = math.min(self.scrollIndex + maxVisible - 1, totalChars)
                    
                    -- 只添加当前页的角色
                    for i = startIndex, endIndex do
                        local charKey = characters[i]
                        local class = GetCharClass and GetCharClass(charKey) or nil
                        local info = UIDropDownMenu_CreateInfo()
                        if class then
                            local classColor = CLASS_COLORS[class]
                            if classColor then
                                info.colorCode = string.format("|cff%02x%02x%02x", classColor.r*255, classColor.g*255, classColor.b*255)
                            end
                        end
                        info.text = "   " .. charKey
                        info.value = charKey
                        info.func = function(self)
                            UIDropDownMenu_SetSelectedValue(typeManagerFrame.charSelectDropdown, charKey)
                            RefreshTypeManagerBlacklist()
                        end
                        UIDropDownMenu_AddButton(info)
                    end
                    
                    -- 添加滚动提示
                    if totalChars > maxVisible then
                        local scrollInfo = UIDropDownMenu_CreateInfo()
                        scrollInfo.text = "|cff888888[" .. math.min(endIndex, totalChars) .. "/" .. totalChars .. "] 滚轮/↑↓键滚动|r"
                        scrollInfo.notCheckable = true
                        scrollInfo.isTitle = true
                        UIDropDownMenu_AddButton(scrollInfo)
                    end
                else
                    -- 角色数量少，显示所有角色
                    for i, charKey in ipairs(characters) do
                        local class = GetCharClass and GetCharClass(charKey) or nil
                        local info = UIDropDownMenu_CreateInfo()
                        if class then
                            local classColor = CLASS_COLORS[class]
                            if classColor then
                                info.colorCode = string.format("|cff%02x%02x%02x", classColor.r*255, classColor.g*255, classColor.b*255)
                            end
                        end
                        info.text = "   " .. charKey
                        info.value = charKey
                        info.func = function(self)
                            UIDropDownMenu_SetSelectedValue(typeManagerFrame.charSelectDropdown, charKey)
                            RefreshTypeManagerBlacklist()
                        end
                        UIDropDownMenu_AddButton(info)
                    end
                end
            end)
            
            -- 设置当前下拉框显示为职业色
            local curClass = GetCharClass and GetCharClass(currentChar) or nil
            local dropdownText = _G[typeManagerFrame.charSelectDropdown:GetName() .. "Text"]
            if curClass and CLASS_COLORS[curClass] then
                local classColor = CLASS_COLORS[curClass]
                dropdownText:SetTextColor(classColor.r, classColor.g, classColor.b, 1)
            else
                dropdownText:SetTextColor(1, 1, 1, 1) -- 白色
            end
            dropdownText:SetText(currentChar)
            UIDropDownMenu_SetSelectedValue(typeManagerFrame.charSelectDropdown, currentChar)
        end
        InitializeCharDropdown()
        
        -- 初始化白名单角色选择下拉框
        local function InitializeWLCharDropdown()
            local characters = GetAllCharacters()
            local currentChar = GetCurrentCharacterKey()
            local found = false
            for i, char in ipairs(characters) do
                if char == currentChar then
                    found = true
                    table.remove(characters, i)
                    break
                end
            end
            table.insert(characters, 1, currentChar)
            UIDropDownMenu_SetWidth(typeManagerFrame.wlCharSelectDropdown, 150)
            UIDropDownMenu_Initialize(typeManagerFrame.wlCharSelectDropdown, function(self, level)
                local totalChars = #characters
                local maxVisible = 8
                
                -- 如果角色数量超过最大显示数，只显示前8个，其余通过滚动查看
                if totalChars > maxVisible then
                    -- 获取滚动偏移量
                    if not self.scrollIndex then
                        self.scrollIndex = 1
                    end
                    
                    local startIndex = self.scrollIndex
                    local endIndex = math.min(self.scrollIndex + maxVisible - 1, totalChars)
                    
                    -- 只添加当前页的角色
                    for i = startIndex, endIndex do
                        local charKey = characters[i]
                        local class = GetCharClass and GetCharClass(charKey) or nil
                        local info = UIDropDownMenu_CreateInfo()
                        if class then
                            local classColor = CLASS_COLORS[class]
                            if classColor then
                                info.colorCode = string.format("|cff%02x%02x%02x", classColor.r*255, classColor.g*255, classColor.b*255)
                            end
                        end
                        info.text = "   " .. charKey
                        info.value = charKey
                        info.func = function(self)
                            UIDropDownMenu_SetSelectedValue(typeManagerFrame.wlCharSelectDropdown, charKey)
                            LoadWhitelist(charKey)
                            RefreshTypeManagerWhitelist()
                        end
                        UIDropDownMenu_AddButton(info)
                    end
                    
                    -- 添加滚动提示
                    if totalChars > maxVisible then
                        local scrollInfo = UIDropDownMenu_CreateInfo()
                        scrollInfo.text = "|cff888888[" .. math.min(endIndex, totalChars) .. "/" .. totalChars .. "] 使用滚轮滚动|r"
                        scrollInfo.notCheckable = true
                        scrollInfo.isTitle = true
                        UIDropDownMenu_AddButton(scrollInfo)
                    end
                else
                    -- 角色数量少，显示所有角色
                    for i, charKey in ipairs(characters) do
                        local class = GetCharClass and GetCharClass(charKey) or nil
                        local info = UIDropDownMenu_CreateInfo()
                        if class then
                            local classColor = CLASS_COLORS[class]
                            if classColor then
                                info.colorCode = string.format("|cff%02x%02x%02x", classColor.r*255, classColor.g*255, classColor.b*255)
                            end
                        end
                        info.text = "   " .. charKey
                        info.value = charKey
                        info.func = function(self)
                            UIDropDownMenu_SetSelectedValue(typeManagerFrame.wlCharSelectDropdown, charKey)
                            LoadWhitelist(charKey)
                            RefreshTypeManagerWhitelist()
                        end
                        UIDropDownMenu_AddButton(info)
                    end
                end
            end)
            
            
            -- 设置当前下拉框显示为职业色
            local curClass = GetCharClass and GetCharClass(currentChar) or nil
            local dropdownText = _G[typeManagerFrame.wlCharSelectDropdown:GetName() .. "Text"]
            if curClass and CLASS_COLORS[curClass] then
                local classColor = CLASS_COLORS[curClass]
                dropdownText:SetTextColor(classColor.r, classColor.g, classColor.b, 1)
            else
                dropdownText:SetTextColor(0.5, 1, 0.5, 1) -- 绿色主题
            end
            dropdownText:SetText(currentChar)
            UIDropDownMenu_SetSelectedValue(typeManagerFrame.wlCharSelectDropdown, currentChar)
        end
        InitializeWLCharDropdown()
        
        -- 黑名单下拉框滚动处理函数
        local function HandleBlacklistScroll(direction)
            if _G["DropDownList1"]:IsShown() and UIDROPDOWNMENU_OPEN_MENU == typeManagerFrame.charSelectDropdown then
                local characters = GetAllCharacters()
                local totalChars = #characters
                local maxVisible = 8
                
                if totalChars > maxVisible then
                    local dropdown = typeManagerFrame.charSelectDropdown
                    
                    if not dropdown.scrollIndex then
                        dropdown.scrollIndex = 1
                    end
                    
                    local scrollStep = 1
                    local maxIndex = math.max(1, totalChars - maxVisible + 1)
                    local oldScrollIndex = dropdown.scrollIndex
                    
                    if direction == "up" then
                        dropdown.scrollIndex = math.max(1, dropdown.scrollIndex - scrollStep)
                    elseif direction == "down" then
                        dropdown.scrollIndex = math.min(maxIndex, dropdown.scrollIndex + scrollStep)
                    end
                    
                    if dropdown.scrollIndex ~= oldScrollIndex then
                        UIDropDownMenu_Initialize(dropdown, function(self, level)
                            local startIndex = dropdown.scrollIndex
                            local endIndex = math.min(dropdown.scrollIndex + maxVisible - 1, totalChars)
                            
                            for i = startIndex, endIndex do
                                local charKey = characters[i]
                                local class = GetCharClass and GetCharClass(charKey) or nil
                                local info = UIDropDownMenu_CreateInfo()
                                if class then
                                    local classColor = CLASS_COLORS[class]
                                    if classColor then
                                        info.colorCode = string.format("|cff%02x%02x%02x", classColor.r*255, classColor.g*255, classColor.b*255)
                                    end
                                end
                                info.text = "   " .. charKey
                                info.value = charKey
                                info.func = function(self)
                                    UIDropDownMenu_SetSelectedValue(dropdown, charKey)
                                    LoadBlacklist(charKey)
                                    RefreshTypeManagerBlacklist()
                                end
                                UIDropDownMenu_AddButton(info)
                            end
                            
                            local scrollInfo = UIDropDownMenu_CreateInfo()
                            scrollInfo.text = "|cff888888[" .. endIndex .. "/" .. totalChars .. "] 滚轮/↑↓键滚动|r"
                            scrollInfo.notCheckable = true
                            scrollInfo.isTitle = true
                            UIDropDownMenu_AddButton(scrollInfo)
                        end)
                        
                        CloseDropDownMenus()
                        ToggleDropDownMenu(1, nil, dropdown)
                    end
                end
            end
        end
        
        -- 白名单下拉框滚动处理函数
        local function HandleWhitelistScroll(direction)
            if _G["DropDownList1"]:IsShown() and UIDROPDOWNMENU_OPEN_MENU == typeManagerFrame.wlCharSelectDropdown then
                local characters = GetAllCharacters()
                local totalChars = #characters
                local maxVisible = 8
                
                if totalChars > maxVisible then
                    local dropdown = typeManagerFrame.wlCharSelectDropdown
                    
                    if not dropdown.scrollIndex then
                        dropdown.scrollIndex = 1
                    end
                    
                    local scrollStep = 1
                    local maxIndex = math.max(1, totalChars - maxVisible + 1)
                    local oldScrollIndex = dropdown.scrollIndex
                    
                    if direction == "up" then
                        dropdown.scrollIndex = math.max(1, dropdown.scrollIndex - scrollStep)
                    elseif direction == "down" then
                        dropdown.scrollIndex = math.min(maxIndex, dropdown.scrollIndex + scrollStep)
                    end
                    
                    if dropdown.scrollIndex ~= oldScrollIndex then
                        UIDropDownMenu_Initialize(dropdown, function(self, level)
                            local startIndex = dropdown.scrollIndex
                            local endIndex = math.min(dropdown.scrollIndex + maxVisible - 1, totalChars)
                            
                            for i = startIndex, endIndex do
                                local charKey = characters[i]
                                local class = GetCharClass and GetCharClass(charKey) or nil
                                local info = UIDropDownMenu_CreateInfo()
                                if class then
                                    local classColor = CLASS_COLORS[class]
                                    if classColor then
                                        info.colorCode = string.format("|cff%02x%02x%02x", classColor.r*255, classColor.g*255, classColor.b*255)
                                    end
                                end
                                info.text = "   " .. charKey
                                info.value = charKey
                                info.func = function(self)
                                    UIDropDownMenu_SetSelectedValue(dropdown, charKey)
                                    RefreshTypeManagerWhitelist()
                                end
                                UIDropDownMenu_AddButton(info)
                            end
                            
                            local scrollInfo = UIDropDownMenu_CreateInfo()
                            scrollInfo.text = "|cff888888[" .. endIndex .. "/" .. totalChars .. "] 滚轮/↑↓键滚动|r"
                            scrollInfo.notCheckable = true
                            scrollInfo.isTitle = true
                            UIDropDownMenu_AddButton(scrollInfo)
                        end)
                        
                        CloseDropDownMenus()
                        ToggleDropDownMenu(1, nil, dropdown)
                    end
                end
            end
        end
        
        -- 黑名单下拉框鼠标滚轮控制
        if typeManagerFrame.charSelectDropdown then
            typeManagerFrame.charSelectDropdown:SetScript("OnMouseWheel", function(self, delta)
                if delta > 0 then
                    HandleBlacklistScroll("up")
                else
                    HandleBlacklistScroll("down")
                end
            end)
            typeManagerFrame.charSelectDropdown:EnableMouseWheel(true)
        end
        
        -- 白名单下拉框鼠标滚轮控制
        if typeManagerFrame.wlCharSelectDropdown then
            typeManagerFrame.wlCharSelectDropdown:SetScript("OnMouseWheel", function(self, delta)
                if delta > 0 then
                    HandleWhitelistScroll("up")
                else
                    HandleWhitelistScroll("down")
                end
            end)
            typeManagerFrame.wlCharSelectDropdown:EnableMouseWheel(true)
        end
        
        -- 键盘控制（支持两个下拉框）
        typeManagerFrame:SetScript("OnKeyDown", function(self, key)
            if key == "UP" then
                HandleBlacklistScroll("up")
                HandleWhitelistScroll("up")
            elseif key == "DOWN" then
                HandleBlacklistScroll("down")
                HandleWhitelistScroll("down")
            end
        end)
        typeManagerFrame:EnableKeyboard(true)
        typeManagerFrame:SetPropagateKeyboardInput(true)
        
        -- 为DropDownList1添加滚轮支持（这是关键！）
        local function SetupDropdownListScroll()
            if _G["DropDownList1"] and not _G["DropDownList1"].wheelSetup then
                _G["DropDownList1"]:SetScript("OnMouseWheel", function(self, delta)
                    -- 检查是否是我们的下拉框
                    if UIDROPDOWNMENU_OPEN_MENU == typeManagerFrame.charSelectDropdown then
                        if delta > 0 then
                            HandleBlacklistScroll("up")
                        else
                            HandleBlacklistScroll("down")
                        end
                    elseif UIDROPDOWNMENU_OPEN_MENU == typeManagerFrame.wlCharSelectDropdown then
                        if delta > 0 then
                            HandleWhitelistScroll("up")
                        else
                            HandleWhitelistScroll("down")
                        end
                    end
                end)
                _G["DropDownList1"]:EnableMouseWheel(true)
                _G["DropDownList1"].wheelSetup = true
            end
        end
        
        -- 立即尝试设置
        SetupDropdownListScroll()
        
        -- 也可以在下拉框打开时设置
        local originalToggle = ToggleDropDownMenu
        ToggleDropDownMenu = function(...)
            local result = originalToggle(...)
            SetupDropdownListScroll()
            return result
        end
        
        
        -- 彻底隐藏下拉框原生边框贴图
        local function StripDropDownTextures(dropdown)
            local left = _G[dropdown:GetName() .. "Left"]
            local middle = _G[dropdown:GetName() .. "Middle"]
            local right = _G[dropdown:GetName() .. "Right"]
            if left then left:Hide() end
            if middle then middle:Hide() end
            if right then right:Hide() end
        end
        StripDropDownTextures(typeManagerFrame.charSelectDropdown)
        
        -- 为白名单下拉框也应用样式处理
        local function StripWLDropDownTextures(dropdown)
            local left = _G[dropdown:GetName() .. "Left"]
            local middle = _G[dropdown:GetName() .. "Middle"]
            local right = _G[dropdown:GetName() .. "Right"]
            if left then left:Hide() end
            if middle then middle:Hide() end
            if right then right:Hide() end
        end
        StripWLDropDownTextures(typeManagerFrame.wlCharSelectDropdown)
        
        -- 主题样式函数定义（必须在调用之前定义）
        -- 极简风格样式函数
        function ApplyMinimalistStyle()
            if not typeManagerFrame then return end
            -- 主面板
            typeManagerFrame:SetBackdrop({
                    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                    edgeFile = nil,
                    tile = true, tileSize = 16, edgeSize = 0,
                    insets = {left = 0, right = 0, top = 0, bottom = 0}
                })
            typeManagerFrame:SetBackdropColor(0,0,0,0.92)
            typeManagerFrame:SetScale(1.0)
            -- 保持动态高度，不重置为固定值
            typeManagerFrame:SetFrameStrata("DIALOG")
            typeManagerFrame:SetMovable(true)
            if typeManagerFrame.SetCornerRadius then typeManagerFrame:SetCornerRadius(8) end
            -- 主标题左侧金币图标
            if not typeManagerFrame.mainIcon then
                typeManagerFrame.mainIcon = typeManagerFrame:CreateTexture(nil, "ARTWORK")
                typeManagerFrame.mainIcon:SetTexture("Interface\\Icons\\INV_Misc_Coin_01")
                typeManagerFrame.mainIcon:SetSize(20,20)
                typeManagerFrame.mainIcon:SetPoint("LEFT", typeManagerFrame.mainTitle, "LEFT", -25, 0)
            end
            typeManagerFrame.mainIcon:Show()
            -- 主标题
            typeManagerFrame.mainTitle:SetFontObject(GameFontNormalLarge)
            typeManagerFrame.mainTitle:SetTextColor(1,1,1)
            typeManagerFrame.mainTitle:SetShadowOffset(0,0)
            typeManagerFrame.mainTitle:SetJustifyH("CENTER")
            -- 分区标题上方横条
            if typeManagerFrame.typeTitleBar then
                typeManagerFrame.typeTitleBar:Hide()
            end
            -- 类型复选框
            if typeManagerFrame.typeScrollChild and typeManagerFrame.typeScrollChild.rows then
                for _, row in ipairs(typeManagerFrame.typeScrollChild.rows) do
                    for _, cb in ipairs({row:GetChildren()}) do
                        if cb.text then
                            cb.text:SetFontObject(GameFontNormal)
                            cb.text:SetTextColor(0.95,0.95,0.95)
                            cb.text:SetShadowOffset(0,0)
                        end
                    end
                end
            end
            -- 黑名单行美化+移除按钮加X图标
            if typeManagerFrame.scrollChild and typeManagerFrame.scrollChild.rows then
                for _, row in ipairs(typeManagerFrame.scrollChild.rows) do
                    for _, child in ipairs({row:GetChildren()}) do
                        if child.SetNormalFontObject then
                            child:SetNormalFontObject(GameFontNormal)
                            child:SetHighlightFontObject(GameFontNormal)
                            if not child.icon then
                                local icon = child:CreateTexture(nil, "ARTWORK")
                                icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
                                icon:SetSize(14,14)
                                icon:SetPoint("LEFT", child, "LEFT", 2, 0)
                                child.icon = icon
                                child:SetText("  移除")
                            end
                        end
                    end
                    row:SetScript("OnEnter", function(self)
                        for _, child in ipairs({self:GetChildren()}) do
                            if child.text then child.text:SetTextColor(1,1,1) end
                        end
                    end)
                    row:SetScript("OnLeave", function(self)
                        for _, child in ipairs({self:GetChildren()}) do
                            if child.text then child.text:SetTextColor(0.95,0.95,0.95) end
                        end
                    end)
                end
            end
            -- 清空黑名单按钮 - 极简风格
            if typeManagerFrame.clearBlacklistBtn then
                typeManagerFrame.clearBlacklistBtn:SetNormalFontObject(GameFontNormal)
                typeManagerFrame.clearBlacklistBtn:SetHighlightFontObject(GameFontNormal)
                local btnText = typeManagerFrame.clearBlacklistBtn:GetFontString()
                if btnText then
                    btnText:SetTextColor(0.95,0.95,0.95)
                    btnText:SetShadowOffset(0,0)
                end
                if not typeManagerFrame.clearBlacklistBtn.icon then
                    local icon = typeManagerFrame.clearBlacklistBtn:CreateTexture(nil, "ARTWORK")
                    icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
                    icon:SetSize(16,16)
                    icon:SetPoint("LEFT", typeManagerFrame.clearBlacklistBtn, "LEFT", 4, 0)
                    typeManagerFrame.clearBlacklistBtn.icon = icon
                    typeManagerFrame.clearBlacklistBtn:SetText("  清空黑名单")
                end
                if typeManagerFrame.clearBlacklistBtn.icon then
                    typeManagerFrame.clearBlacklistBtn.icon:Show()
                end
                typeManagerFrame.clearBlacklistBtn:SetScript("OnEnter", function(self)
                    local t = self:GetFontString()
                    if t then t:SetTextColor(1,1,1) end
                end)
                typeManagerFrame.clearBlacklistBtn:SetScript("OnLeave", function(self)
                    local t = self:GetFontString()
                    if t then t:SetTextColor(0.95,0.95,0.95) end
                end)
            end
            
            -- 导入按钮 - 极简风格
            if typeManagerFrame.importBtn then
                typeManagerFrame.importBtn:SetNormalFontObject(GameFontNormal)
                typeManagerFrame.importBtn:SetHighlightFontObject(GameFontNormal)
                local btnText = typeManagerFrame.importBtn:GetFontString()
                if btnText then
                    btnText:SetTextColor(1, 0.82, 0)
                    btnText:SetShadowOffset(0,0)
                end
            end
            
            -- 等级编辑框 - 极简风格
            if typeManagerFrame.lvEdit then
                typeManagerFrame.lvEdit:SetFontObject(GameFontNormal)
                typeManagerFrame.lvEdit:SetTextColor(0.95, 0.95, 0.95)
                typeManagerFrame.lvEdit:SetShadowOffset(0,0)
            end
            
            -- 等级确定按钮 - 极简风格
            if typeManagerFrame.lvBtn then
                typeManagerFrame.lvBtn:SetNormalFontObject(GameFontNormal)
                typeManagerFrame.lvBtn:SetHighlightFontObject(GameFontNormal)
                local btnText = typeManagerFrame.lvBtn:GetFontString()
                if btnText then
                    btnText:SetTextColor(0.95,0.95,0.95)
                    btnText:SetShadowOffset(0,0)
                end
            end
            
            -- 清空白名单按钮 - 极简风格
            if typeManagerFrame.clearWhitelistBtn then
                typeManagerFrame.clearWhitelistBtn:SetNormalFontObject(GameFontNormal)
                typeManagerFrame.clearWhitelistBtn:SetHighlightFontObject(GameFontNormal)
                local btnText = typeManagerFrame.clearWhitelistBtn:GetFontString()
                if btnText then
                    btnText:SetTextColor(0.95,0.95,0.95)
                    btnText:SetShadowOffset(0,0)
                end
                -- 添加X图标
                if not typeManagerFrame.clearWhitelistBtn.icon then
                    local icon = typeManagerFrame.clearWhitelistBtn:CreateTexture(nil, "ARTWORK")
                    icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
                    icon:SetSize(16,16)
                    icon:SetPoint("LEFT", typeManagerFrame.clearWhitelistBtn, "LEFT", 4, 0)
                    typeManagerFrame.clearWhitelistBtn.icon = icon
                    typeManagerFrame.clearWhitelistBtn:SetText("  清空白名单")
                end
                if typeManagerFrame.clearWhitelistBtn.icon then
                    typeManagerFrame.clearWhitelistBtn.icon:Show()
                end
                typeManagerFrame.clearWhitelistBtn:SetScript("OnEnter", function(self)
                    local t = self:GetFontString()
                    if t then t:SetTextColor(1,1,1) end
                end)
                typeManagerFrame.clearWhitelistBtn:SetScript("OnLeave", function(self)
                    local t = self:GetFontString()
                    if t then t:SetTextColor(0.95,0.95,0.95) end
                end)
            end
            
            -- 白名单导入按钮 - 极简风格
            if typeManagerFrame.wlImportBtn then
                typeManagerFrame.wlImportBtn:SetNormalFontObject(GameFontNormal)
                typeManagerFrame.wlImportBtn:SetHighlightFontObject(GameFontNormal)
                local btnText = typeManagerFrame.wlImportBtn:GetFontString()
                if btnText then
                    btnText:SetTextColor(1, 0.82, 0)
                    btnText:SetShadowOffset(0,0)
                end
            end
            
            -- 主题切换按钮 - 极简风格
            if typeManagerFrame.minimalistTabBtn then
                typeManagerFrame.minimalistTabBtn:SetNormalFontObject(GameFontNormal)
                typeManagerFrame.minimalistTabBtn:SetHighlightFontObject(GameFontNormal)
                local btnText = typeManagerFrame.minimalistTabBtn:GetFontString()
                if btnText then
                    btnText:SetTextColor(0.95,0.95,0.95)
                    btnText:SetShadowOffset(0,0)
                end
            end
            
            if typeManagerFrame.originalTabBtn then
                typeManagerFrame.originalTabBtn:SetNormalFontObject(GameFontNormal)
                typeManagerFrame.originalTabBtn:SetHighlightFontObject(GameFontNormal)
                local btnText = typeManagerFrame.originalTabBtn:GetFontString()
                if btnText then
                    btnText:SetTextColor(0.95,0.95,0.95)
                    btnText:SetShadowOffset(0,0)
                end
            end
            -- 下拉框 - 极简风格（隐藏边框）
            if typeManagerFrame.charSelectDropdown then
                local dropdownText = _G[typeManagerFrame.charSelectDropdown:GetName() .. "Text"]
                if dropdownText then
                    -- 保持职业颜色而不是固定颜色
                    local currentChar = GetCurrentCharacterKey()
                    local curClass = GetCharClass and GetCharClass(currentChar) or nil
                    if curClass and CLASS_COLORS[curClass] then
                        local classColor = CLASS_COLORS[curClass]
                        dropdownText:SetTextColor(classColor.r, classColor.g, classColor.b, 1)
                    else
                        dropdownText:SetTextColor(0.95, 0.95, 0.95)
                    end
                    dropdownText:SetShadowOffset(0, 0)
                end
                -- 隐藏下拉框边框
                local left = _G[typeManagerFrame.charSelectDropdown:GetName() .. "Left"]
                local middle = _G[typeManagerFrame.charSelectDropdown:GetName() .. "Middle"]
                local right = _G[typeManagerFrame.charSelectDropdown:GetName() .. "Right"]
                if left then left:Hide() end
                if middle then middle:Hide() end
                if right then right:Hide() end
            end
            
            -- 白名单角色下拉框 - 极简风格（隐藏边框）
            if typeManagerFrame.wlCharSelectDropdown then
                local dropdownText = _G[typeManagerFrame.wlCharSelectDropdown:GetName() .. "Text"]
                if dropdownText then
                    -- 保持职业颜色而不是固定颜色
                    local currentChar = GetCurrentCharacterKey()
                    local curClass = GetCharClass and GetCharClass(currentChar) or nil
                    if curClass and CLASS_COLORS[curClass] then
                        local classColor = CLASS_COLORS[curClass]
                        dropdownText:SetTextColor(classColor.r, classColor.g, classColor.b, 1)
                    else
                        dropdownText:SetTextColor(0.95, 0.95, 0.95)
                    end
                    dropdownText:SetShadowOffset(0, 0)
                end
                -- 隐藏下拉框边框
                local left = _G[typeManagerFrame.wlCharSelectDropdown:GetName() .. "Left"]
                local middle = _G[typeManagerFrame.wlCharSelectDropdown:GetName() .. "Middle"]
                local right = _G[typeManagerFrame.wlCharSelectDropdown:GetName() .. "Right"]
                if left then left:Hide() end
                if middle then middle:Hide() end
                if right then right:Hide() end
            end
            
            -- 滚动条美化
            if typeManagerFrame.scrollFrame and typeManagerFrame.scrollFrame.ScrollBar then
                local sb = typeManagerFrame.scrollFrame.ScrollBar
                sb:SetWidth(6)
                if sb.SetThumbTexture then
                    sb:SetThumbTexture("Interface/Buttons/UI-ScrollBar-Knob")
                    sb:GetThumbTexture():SetVertexColor(1, 0.82, 0, 0.8)
                end
            end
            
            -- 自动使用代币复选框 - 极简风格
            if typeManagerFrame.autoUseTokenCheckbox then
                -- 极简风格：简洁的深色边框 + 透明背景
                if not typeManagerFrame.autoUseTokenCheckbox.boxBg then
                    typeManagerFrame.autoUseTokenCheckbox.boxBg = typeManagerFrame.autoUseTokenCheckbox:CreateTexture(nil, "BACKGROUND")
                    typeManagerFrame.autoUseTokenCheckbox.boxBg:SetSize(18, 18)
                    typeManagerFrame.autoUseTokenCheckbox.boxBg:SetPoint("CENTER", typeManagerFrame.autoUseTokenCheckbox, "CENTER", 0, 0)
                end
                typeManagerFrame.autoUseTokenCheckbox.boxBg:SetTexture("Interface/Tooltips/UI-Tooltip-Background")
                typeManagerFrame.autoUseTokenCheckbox.boxBg:SetVertexColor(0.1, 0.1, 0.1, 0.8)  -- 半透明深色背景
                
                -- 极简风格边框：细线条
                if not typeManagerFrame.autoUseTokenCheckbox.boxBorder then
                    typeManagerFrame.autoUseTokenCheckbox.boxBorder = typeManagerFrame.autoUseTokenCheckbox:CreateTexture(nil, "BORDER")
                    typeManagerFrame.autoUseTokenCheckbox.boxBorder:SetSize(20, 20)
                    typeManagerFrame.autoUseTokenCheckbox.boxBorder:SetPoint("CENTER", typeManagerFrame.autoUseTokenCheckbox, "CENTER", 0, 0)
                end
                typeManagerFrame.autoUseTokenCheckbox.boxBorder:SetTexture("Interface/Tooltips/UI-Tooltip-Border")
                typeManagerFrame.autoUseTokenCheckbox.boxBorder:SetVertexColor(1, 0.82, 0, 0.6)  -- 金色边框，符合极简风格
                
                -- 复选框状态纹理
                typeManagerFrame.autoUseTokenCheckbox:SetNormalTexture("")
                typeManagerFrame.autoUseTokenCheckbox:SetPushedTexture("")
                typeManagerFrame.autoUseTokenCheckbox:SetCheckedTexture("Interface/Buttons/UI-CheckBox-Check")
                
                -- 极简风格勾选标记：金色符合主题
                local checkTexture = typeManagerFrame.autoUseTokenCheckbox:GetCheckedTexture()
                if checkTexture then
                    checkTexture:SetVertexColor(1, 0.82, 0, 1)  -- 金色勾选标记，符合极简风格
                    checkTexture:SetSize(16, 16)
                end
                
                -- 文本样式：与极简风格一致
                if typeManagerFrame.autoUseTokenCheckbox.text then
                    typeManagerFrame.autoUseTokenCheckbox.text:SetFontObject(GameFontNormal)
                    typeManagerFrame.autoUseTokenCheckbox.text:SetTextColor(0.95, 0.95, 0.95)  -- 浅灰色文字
                    typeManagerFrame.autoUseTokenCheckbox.text:SetShadowOffset(0, 0)  -- 极简风格无阴影
                end
            end
            
            -- 高级选项复选框 - 极简风格
            if typeManagerFrame.advancedOptionCheckboxes then
                for _, checkbox in ipairs(typeManagerFrame.advancedOptionCheckboxes) do
                    if checkbox then
                        -- 极简风格：简洁的深色边框 + 透明背景
                        if not checkbox.boxBg then
                            checkbox.boxBg = checkbox:CreateTexture(nil, "BACKGROUND")
                            checkbox.boxBg:SetSize(18, 18)
                            checkbox.boxBg:SetPoint("CENTER", checkbox, "CENTER", 0, 0)
                        end
                        checkbox.boxBg:SetTexture("Interface/Tooltips/UI-Tooltip-Background")
                        checkbox.boxBg:SetVertexColor(0.1, 0.1, 0.1, 0.8)  -- 半透明深色背景
                        
                        -- 极简风格边框：细线条
                        if not checkbox.boxBorder then
                            checkbox.boxBorder = checkbox:CreateTexture(nil, "BORDER")
                            checkbox.boxBorder:SetSize(20, 20)
                            checkbox.boxBorder:SetPoint("CENTER", checkbox, "CENTER", 0, 0)
                        end
                        checkbox.boxBorder:SetTexture("Interface/Tooltips/UI-Tooltip-Border")
                        checkbox.boxBorder:SetVertexColor(1, 0.82, 0, 0.6)  -- 金色边框，符合极简风格
                        
                        -- 复选框状态纹理
                        checkbox:SetNormalTexture("")
                        checkbox:SetPushedTexture("")
                        checkbox:SetCheckedTexture("Interface/Buttons/UI-CheckBox-Check")
                        
                        -- 极简风格勾选标记：金色符合主题
                        local checkTexture = checkbox:GetCheckedTexture()
                        if checkTexture then
                            checkTexture:SetVertexColor(1, 0.82, 0, 1)  -- 金色勾选标记，符合极简风格
                            checkTexture:SetSize(16, 16)
                        end
                        
                        -- 文本样式：与极简风格一致
                        if checkbox.text then
                            checkbox.text:SetFontObject(GameFontNormal)
                            checkbox.text:SetTextColor(0.95, 0.95, 0.95)  -- 浅灰色文字
                            checkbox.text:SetShadowOffset(0, 0)  -- 极简风格无阴影
                        end
                    end
                end
            end
        end
        
        -- 原始风格样式函数
        function ApplyOriginalStyle()
            if not typeManagerFrame then return end
            -- 主面板 - 魔兽世界原生UI风格
            typeManagerFrame:SetBackdrop({
                bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
                edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
                tile = true, tileSize = 32, edgeSize = 32,
                insets = {left = 11, right = 12, top = 12, bottom = 11}
            })
            typeManagerFrame:SetBackdropColor(0.4, 0.4, 0.4, 0.85)  -- 灰色半透明背景
            typeManagerFrame:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)  -- 灰色边框
            typeManagerFrame:SetScale(1.0)
            -- 保持动态高度，不重置为固定值
            typeManagerFrame:SetFrameStrata("DIALOG")
            typeManagerFrame:SetMovable(true)
            
            -- 主标题 - 原生风格
            typeManagerFrame.mainTitle:SetFontObject(GameFontNormalLarge)
            typeManagerFrame.mainTitle:SetTextColor(1, 0.82, 0)
            typeManagerFrame.mainTitle:SetShadowOffset(1, -1)
            typeManagerFrame.mainTitle:SetJustifyH("CENTER")
            
            -- 显示金币图标（原始风也需要显示）
            if typeManagerFrame.mainIcon then
                typeManagerFrame.mainIcon:Show()
            end
            
            -- 类型复选框 - 原生风格
            if typeManagerFrame.typeScrollChild and typeManagerFrame.typeScrollChild.rows then
                for _, row in ipairs(typeManagerFrame.typeScrollChild.rows) do
                    for _, cb in ipairs({row:GetChildren()}) do
                        if cb.text then
                            cb.text:SetFontObject(GameFontNormal)
                            cb.text:SetTextColor(1, 1, 1)
                            cb.text:SetShadowOffset(1, -1)
                        end
                    end
                end
            end
            
            -- 黑名单行 - 原生风格
            if typeManagerFrame.scrollChild and typeManagerFrame.scrollChild.rows then
                for _, row in ipairs(typeManagerFrame.scrollChild.rows) do
                    for _, child in ipairs({row:GetChildren()}) do
                        if child.SetNormalFontObject then
                            child:SetNormalFontObject(GameFontNormal)
                            child:SetHighlightFontObject(GameFontHighlight)
                            -- 隐藏极简风的图标
                            if child.icon then
                                child.icon:Hide()
                                child:SetText("移除")
                            end
                        end
                    end
                    -- 移除极简风的hover效果
                    row:SetScript("OnEnter", nil)
                    row:SetScript("OnLeave", nil)
                end
            end
            
            -- 清空黑名单按钮 - 原生风格
            if typeManagerFrame.clearBlacklistBtn then
                typeManagerFrame.clearBlacklistBtn:SetNormalFontObject(GameFontNormal)
                typeManagerFrame.clearBlacklistBtn:SetHighlightFontObject(GameFontHighlight)
                local btnText = typeManagerFrame.clearBlacklistBtn:GetFontString()
                if btnText then
                    btnText:SetTextColor(1, 1, 1)
                    btnText:SetShadowOffset(1, -1)
                end
                -- 隐藏极简风的图标
                if typeManagerFrame.clearBlacklistBtn.icon then
                    typeManagerFrame.clearBlacklistBtn.icon:Hide()
                    typeManagerFrame.clearBlacklistBtn:SetText("清空黑名单")
                end
                -- 移除极简风的hover效果
                typeManagerFrame.clearBlacklistBtn:SetScript("OnEnter", nil)
                typeManagerFrame.clearBlacklistBtn:SetScript("OnLeave", nil)
            end
            
            -- 导入按钮 - 原生风格
            if typeManagerFrame.importBtn then
                typeManagerFrame.importBtn:SetNormalFontObject(GameFontNormal)
                typeManagerFrame.importBtn:SetHighlightFontObject(GameFontHighlight)
                local btnText = typeManagerFrame.importBtn:GetFontString()
                if btnText then
                    btnText:SetTextColor(1, 1, 1)
                    btnText:SetShadowOffset(1, -1)
                end
                -- 移除极简风的hover效果
                typeManagerFrame.importBtn:SetScript("OnEnter", nil)
                typeManagerFrame.importBtn:SetScript("OnLeave", nil)
            end
            
            -- 等级编辑框 - 原生风格
            if typeManagerFrame.lvEdit then
                typeManagerFrame.lvEdit:SetFontObject(GameFontHighlight)
                typeManagerFrame.lvEdit:SetTextColor(1, 1, 1)
                typeManagerFrame.lvEdit:SetShadowOffset(1, -1)
            end
            
            -- 等级确定按钮 - 原生风格
            if typeManagerFrame.lvBtn then
                typeManagerFrame.lvBtn:SetNormalFontObject(GameFontNormal)
                typeManagerFrame.lvBtn:SetHighlightFontObject(GameFontHighlight)
                local btnText = typeManagerFrame.lvBtn:GetFontString()
                if btnText then
                    btnText:SetTextColor(1, 1, 1)
                    btnText:SetShadowOffset(1, -1)
                end
            end
            
            -- 清空白名单按钮 - 原生风格
            if typeManagerFrame.clearWhitelistBtn then
                typeManagerFrame.clearWhitelistBtn:SetNormalFontObject(GameFontNormal)
                typeManagerFrame.clearWhitelistBtn:SetHighlightFontObject(GameFontHighlight)
                local btnText = typeManagerFrame.clearWhitelistBtn:GetFontString()
                if btnText then
                    btnText:SetTextColor(1, 1, 1)
                    btnText:SetShadowOffset(1, -1)
                end
                -- 隐藏极简风的图标
                if typeManagerFrame.clearWhitelistBtn.icon then
                    typeManagerFrame.clearWhitelistBtn.icon:Hide()
                    typeManagerFrame.clearWhitelistBtn:SetText("清空白名单")
                end
                -- 移除极简风的hover效果
                typeManagerFrame.clearWhitelistBtn:SetScript("OnEnter", nil)
                typeManagerFrame.clearWhitelistBtn:SetScript("OnLeave", nil)
            end
            
            -- 白名单导入按钮 - 原生风格
            if typeManagerFrame.wlImportBtn then
                typeManagerFrame.wlImportBtn:SetNormalFontObject(GameFontNormal)
                typeManagerFrame.wlImportBtn:SetHighlightFontObject(GameFontHighlight)
                local btnText = typeManagerFrame.wlImportBtn:GetFontString()
                if btnText then
                    btnText:SetTextColor(1, 1, 1)
                    btnText:SetShadowOffset(1, -1)
                end
                -- 移除极简风的hover效果
                typeManagerFrame.wlImportBtn:SetScript("OnEnter", nil)
                typeManagerFrame.wlImportBtn:SetScript("OnLeave", nil)
            end
            
            -- 主题切换按钮 - 原生风格
            if typeManagerFrame.minimalistTabBtn then
                typeManagerFrame.minimalistTabBtn:SetNormalFontObject(GameFontNormal)
                typeManagerFrame.minimalistTabBtn:SetHighlightFontObject(GameFontHighlight)
                local btnText = typeManagerFrame.minimalistTabBtn:GetFontString()
                if btnText then
                    btnText:SetTextColor(1, 1, 1)
                    btnText:SetShadowOffset(1, -1)
                end
            end
            
            if typeManagerFrame.originalTabBtn then
                typeManagerFrame.originalTabBtn:SetNormalFontObject(GameFontNormal)
                typeManagerFrame.originalTabBtn:SetHighlightFontObject(GameFontHighlight)
                local btnText = typeManagerFrame.originalTabBtn:GetFontString()
                if btnText then
                    btnText:SetTextColor(1, 1, 1)
                    btnText:SetShadowOffset(1, -1)
                end
            end
            
            -- 下拉框 - 原生风格
            if typeManagerFrame.charSelectDropdown then
                local dropdownText = _G[typeManagerFrame.charSelectDropdown:GetName() .. "Text"]
                if dropdownText then
                    -- 保持职业颜色而不是固定颜色
                    local currentChar = GetCurrentCharacterKey()
                    local curClass = GetCharClass and GetCharClass(currentChar) or nil
                    if curClass and CLASS_COLORS[curClass] then
                        local classColor = CLASS_COLORS[curClass]
                        dropdownText:SetTextColor(classColor.r, classColor.g, classColor.b, 1)
                    else
                        dropdownText:SetTextColor(1, 1, 1)
                    end
                    dropdownText:SetShadowOffset(1, -1)
                end
                -- 恢复下拉框原生边框
                local left = _G[typeManagerFrame.charSelectDropdown:GetName() .. "Left"]
                local middle = _G[typeManagerFrame.charSelectDropdown:GetName() .. "Middle"]
                local right = _G[typeManagerFrame.charSelectDropdown:GetName() .. "Right"]
                if left then left:Show() end
                if middle then middle:Show() end
                if right then right:Show() end
            end
            
            -- 白名单角色下拉框 - 原生风格
            if typeManagerFrame.wlCharSelectDropdown then
                local dropdownText = _G[typeManagerFrame.wlCharSelectDropdown:GetName() .. "Text"]
                if dropdownText then
                    -- 保持职业颜色而不是固定颜色
                    local currentChar = GetCurrentCharacterKey()
                    local curClass = GetCharClass and GetCharClass(currentChar) or nil
                    if curClass and CLASS_COLORS[curClass] then
                        local classColor = CLASS_COLORS[curClass]
                        dropdownText:SetTextColor(classColor.r, classColor.g, classColor.b, 1)
                    else
                        dropdownText:SetTextColor(1, 1, 1)
                    end
                    dropdownText:SetShadowOffset(1, -1)
                end
                -- 恢复下拉框原生边框
                local left = _G[typeManagerFrame.wlCharSelectDropdown:GetName() .. "Left"]
                local middle = _G[typeManagerFrame.wlCharSelectDropdown:GetName() .. "Middle"]
                local right = _G[typeManagerFrame.wlCharSelectDropdown:GetName() .. "Right"]
                if left then left:Show() end
                if middle then middle:Show() end
                if right then right:Show() end
            end
            
            -- 滚动条 - 原生风格
            if typeManagerFrame.scrollFrame and typeManagerFrame.scrollFrame.ScrollBar then
                local sb = typeManagerFrame.scrollFrame.ScrollBar
                sb:SetWidth(16)
                if sb.SetThumbTexture then
                    sb:SetThumbTexture("Interface/Buttons/UI-ScrollBar-Knob")
                    sb:GetThumbTexture():SetVertexColor(1, 1, 1, 1)
                end
            end
            
            -- 自动使用代币复选框 - 原生风格
            if typeManagerFrame.autoUseTokenCheckbox then
                -- 原生风格：经典魔兽UI样式
                if not typeManagerFrame.autoUseTokenCheckbox.boxBg then
                    typeManagerFrame.autoUseTokenCheckbox.boxBg = typeManagerFrame.autoUseTokenCheckbox:CreateTexture(nil, "BACKGROUND")
                    typeManagerFrame.autoUseTokenCheckbox.boxBg:SetSize(20, 20)
                    typeManagerFrame.autoUseTokenCheckbox.boxBg:SetPoint("CENTER", typeManagerFrame.autoUseTokenCheckbox, "CENTER", 0, 0)
                end
                typeManagerFrame.autoUseTokenCheckbox.boxBg:SetTexture("Interface/DialogFrame/UI-DialogBox-Background")
                typeManagerFrame.autoUseTokenCheckbox.boxBg:SetVertexColor(1, 1, 1, 1)  -- 经典白色背景
                
                -- 原生风格边框：经典UI边框
                if not typeManagerFrame.autoUseTokenCheckbox.boxBorder then
                    typeManagerFrame.autoUseTokenCheckbox.boxBorder = typeManagerFrame.autoUseTokenCheckbox:CreateTexture(nil, "BORDER")
                    typeManagerFrame.autoUseTokenCheckbox.boxBorder:SetSize(24, 24)
                    typeManagerFrame.autoUseTokenCheckbox.boxBorder:SetPoint("CENTER", typeManagerFrame.autoUseTokenCheckbox, "CENTER", 0, 0)
                end
                typeManagerFrame.autoUseTokenCheckbox.boxBorder:SetTexture("Interface/DialogFrame/UI-DialogBox-Border")
                typeManagerFrame.autoUseTokenCheckbox.boxBorder:SetVertexColor(1, 1, 1, 1)  -- 经典边框
                
                -- 使用原生复选框纹理
                typeManagerFrame.autoUseTokenCheckbox:SetNormalTexture("Interface/Buttons/UI-CheckBox-Up")
                typeManagerFrame.autoUseTokenCheckbox:SetPushedTexture("Interface/Buttons/UI-CheckBox-Down")
                typeManagerFrame.autoUseTokenCheckbox:SetCheckedTexture("Interface/Buttons/UI-CheckBox-Check")
                typeManagerFrame.autoUseTokenCheckbox:SetDisabledCheckedTexture("Interface/Buttons/UI-CheckBox-Check-Disabled")
                
                -- 原生风格勾选标记：经典绿色
                local checkTexture = typeManagerFrame.autoUseTokenCheckbox:GetCheckedTexture()
                if checkTexture then
                    checkTexture:SetVertexColor(0, 1, 0, 1)  -- 经典绿色勾选标记
                    checkTexture:SetSize(20, 20)
                end
                
                -- 文本样式：原生魔兽UI样式
                if typeManagerFrame.autoUseTokenCheckbox.text then
                    typeManagerFrame.autoUseTokenCheckbox.text:SetFontObject(GameFontHighlight)  -- 原生高亮字体
                    typeManagerFrame.autoUseTokenCheckbox.text:SetTextColor(1, 1, 1)  -- 经典白色文字
                    typeManagerFrame.autoUseTokenCheckbox.text:SetShadowOffset(1, -1)  -- 经典阴影
                    typeManagerFrame.autoUseTokenCheckbox.text:SetShadowColor(0, 0, 0, 1)
                end
            end
            
            -- 高级选项复选框 - 原生风格
            if typeManagerFrame.advancedOptionCheckboxes then
                for _, checkbox in ipairs(typeManagerFrame.advancedOptionCheckboxes) do
                    if checkbox then
                        -- 原生风格：经典魔兽UI样式
                        if not checkbox.boxBg then
                            checkbox.boxBg = checkbox:CreateTexture(nil, "BACKGROUND")
                            checkbox.boxBg:SetSize(20, 20)
                            checkbox.boxBg:SetPoint("CENTER", checkbox, "CENTER", 0, 0)
                        end
                        checkbox.boxBg:SetTexture("Interface/DialogFrame/UI-DialogBox-Background")
                        checkbox.boxBg:SetVertexColor(1, 1, 1, 1)  -- 经典白色背景
                        
                        -- 原生风格边框：经典UI边框
                        if not checkbox.boxBorder then
                            checkbox.boxBorder = checkbox:CreateTexture(nil, "BORDER")
                            checkbox.boxBorder:SetSize(24, 24)
                            checkbox.boxBorder:SetPoint("CENTER", checkbox, "CENTER", 0, 0)
                        end
                        checkbox.boxBorder:SetTexture("Interface/DialogFrame/UI-DialogBox-Border")
                        checkbox.boxBorder:SetVertexColor(1, 1, 1, 1)  -- 经典边框
                        
                        -- 使用原生复选框纹理
                        checkbox:SetNormalTexture("Interface/Buttons/UI-CheckBox-Up")
                        checkbox:SetPushedTexture("Interface/Buttons/UI-CheckBox-Down")
                        checkbox:SetCheckedTexture("Interface/Buttons/UI-CheckBox-Check")
                        checkbox:SetDisabledCheckedTexture("Interface/Buttons/UI-CheckBox-Check-Disabled")
                        
                        -- 原生风格勾选标记：经典绿色
                        local checkTexture = checkbox:GetCheckedTexture()
                        if checkTexture then
                            checkTexture:SetVertexColor(0, 1, 0, 1)  -- 经典绿色勾选标记
                            checkTexture:SetSize(20, 20)
                        end
                        
                        -- 文本样式：原生魔兽UI样式
                        if checkbox.text then
                            checkbox.text:SetFontObject(GameFontHighlight)  -- 原生高亮字体
                            checkbox.text:SetTextColor(1, 1, 1)  -- 经典白色文字
                            checkbox.text:SetShadowOffset(1, -1)  -- 经典阴影
                            checkbox.text:SetShadowColor(0, 0, 0, 1)
                        end
                    end
                end
            end
        end
        
        -- 主题样式应用函数
        function ApplyThemeStyle()
            if not typeManagerFrame then return end
            local currentTheme = AutoSellLowLevelGearDB.themeStyle or "minimalist"
            
            if currentTheme == "minimalist" then
                ApplyMinimalistStyle()
            else
                ApplyOriginalStyle()
            end
        end
        
        -- 更新按钮状态显示
        local function UpdateTabButtons()
            local currentTheme = AutoSellLowLevelGearDB.themeStyle or "minimalist"
            if currentTheme == "minimalist" then
                typeManagerFrame.minimalistTabBtn:SetText("● 极简风")
                typeManagerFrame.originalTabBtn:SetText("原始风")
            else
                typeManagerFrame.minimalistTabBtn:SetText("极简风")
                typeManagerFrame.originalTabBtn:SetText("● 原始风")
            end
        end
        
        -- 极简风按钮点击事件
        typeManagerFrame.minimalistTabBtn:SetScript("OnClick", function()
            AutoSellLowLevelGearDB.themeStyle = "minimalist"
            UpdateTabButtons()
            ApplyThemeStyle()
            ApplyConflictConfirmTheme()  -- 同步更新冲突确认窗口主题
            print("已切换为极简风主题")
        end)
        
        -- 原始风按钮点击事件
        typeManagerFrame.originalTabBtn:SetScript("OnClick", function()
            AutoSellLowLevelGearDB.themeStyle = "original"
            UpdateTabButtons()
            ApplyThemeStyle()
            ApplyConflictConfirmTheme()  -- 同步更新冲突确认窗口主题
            print("已切换为原始风主题")
        end)
        
        -- 初始化按钮状态
        UpdateTabButtons()
        
        -- 黑名单刷新函数 - 仅在界面首次创建时调用
        RefreshTypeManagerBlacklist()
        -- 白名单刷新函数 - 仅在界面首次创建时调用
        RefreshTypeManagerWhitelist()
        -- 不再显示searchTip
        if typeManagerFrame.searchTip then typeManagerFrame.searchTip:Hide() end
        -- 搜索框创建后赋值到typeManagerFrame，便于全局访问
        typeManagerFrame.searchBox = nil
    end
    -- 每次显示界面时都刷新黑名单和白名单显示（但不重新加载数据）
    if typeManagerFrame.charSelectDropdown then
        -- 重新设置下拉框的职业颜色
        local currentChar = GetCurrentCharacterKey()
        local curClass = GetCharClass and GetCharClass(currentChar) or nil
        local dropdownText = _G[typeManagerFrame.charSelectDropdown:GetName() .. "Text"]
        if dropdownText and curClass and CLASS_COLORS[curClass] then
            local classColor = CLASS_COLORS[curClass]
            dropdownText:SetTextColor(classColor.r, classColor.g, classColor.b, 1)
        end
        -- 白名单下拉框
        local wlDropdownText = _G[typeManagerFrame.wlCharSelectDropdown:GetName() .. "Text"]
        if wlDropdownText and curClass and CLASS_COLORS[curClass] then
            local classColor = CLASS_COLORS[curClass]
            wlDropdownText:SetTextColor(classColor.r, classColor.g, classColor.b, 1)
        end
        RefreshTypeManagerBlacklist()
        RefreshTypeManagerWhitelist()
        
        -- 设置按钮文本为当前模式状态
        if typeManagerFrame.blModeToggleBtn then
            typeManagerFrame.blModeToggleBtn:SetText(blacklistMode == "global" and "通用" or "独立")
        end
        if typeManagerFrame.wlModeToggleBtn then
            typeManagerFrame.wlModeToggleBtn:SetText(whitelistMode == "global" and "通用" or "独立")
        end
        
        -- 根据当前模式设置下拉框状态
        if blacklistMode == "global" and typeManagerFrame.charSelectDropdown then
            UIDropDownMenu_DisableDropDown(typeManagerFrame.charSelectDropdown)
        elseif typeManagerFrame.charSelectDropdown then
            UIDropDownMenu_EnableDropDown(typeManagerFrame.charSelectDropdown)
        end
        
        if whitelistMode == "global" and typeManagerFrame.wlCharSelectDropdown then
            UIDropDownMenu_DisableDropDown(typeManagerFrame.wlCharSelectDropdown)
        elseif typeManagerFrame.wlCharSelectDropdown then
            UIDropDownMenu_EnableDropDown(typeManagerFrame.wlCharSelectDropdown)
        end
        
        -- 初始化按钮事件处理
        if typeManagerFrame.blModeToggleBtn and not typeManagerFrame.blModeToggleBtn.hasClickHandler then
            typeManagerFrame.blModeToggleBtn:SetScript("OnClick", function(self)
                -- 切换黑名单模式
                if blacklistMode == "character" then
                    -- 从角色模式切换到通用模式
                    -- 只有当前模式确实是角色模式时，才保存当前数据为角色数据
                    local currentChar = GetCurrentCharacterKey()
                    local blacklistCount = GetTableSize(BLACKLIST)
                    print("从独立模式切换到通用模式，当前内存黑名单有", blacklistCount, "个物品")
                    
                    -- 🔧 修复：只有当内存中有数据时才保存，避免空数据覆盖数据库
                    if blacklistCount > 0 then
                        print("保存角色", currentChar, "的黑名单到数据库")
                        SaveCharacterBlacklist(currentChar, BLACKLIST)
                    else
                        print("⚠️ 内存黑名单为空，跳过保存以保护数据库中现有的角色数据")
                        -- 检查数据库中是否有该角色的数据
                        local existingBlacklist = GetCharacterBlacklist(currentChar)
                        local existingCount = GetTableSize(existingBlacklist)
                        if existingCount > 0 then
                            print("数据库中角色", currentChar, "已有", existingCount, "个黑名单物品，已保护")
                        end
                    end
                    blacklistMode = "global"
                    self:SetText("通用")
                    -- 清空内存并加载全服黑名单
                    for k in pairs(BLACKLIST) do BLACKLIST[k] = nil end
                    for k in pairs(BLACKLIST_NAMES) do BLACKLIST_NAMES[k] = nil end
                    local globalBlacklist = GetGlobalBlacklist()
                    for key, value in pairs(globalBlacklist) do
                        BLACKLIST[key] = true
                        BLACKLIST_NAMES[key] = type(value) == "string" and value or select(1, GetItemInfo(key)) or key
                    end
                    -- 禁用角色选择下拉框
                    if typeManagerFrame.charSelectDropdown then
                        UIDropDownMenu_DisableDropDown(typeManagerFrame.charSelectDropdown)
                    end
                    -- 保存模式状态
                    -- 保存到当前角色的设置中
                    local charKey = GetCurrentCharacterKey()
                    if not AutoSellLowLevelGearDB.characters[charKey] then
                        AutoSellLowLevelGearDB.characters[charKey] = {}
                    end
                    AutoSellLowLevelGearDB.characters[charKey].blacklistMode = "global"
                    print("已切换到跨服通用黑名单模式，全局黑名单中有", GetTableSize(BLACKLIST), "个物品")
                else
                    -- 从通用模式切换到角色模式
                    -- 当前内存中的数据是通用数据，需要保存到通用存储，但不要覆盖，因为可能已经是最新的
                    -- SaveGlobalBlacklist(BLACKLIST) -- 移除这行，避免数据干扰
                    blacklistMode = "character"
                    self:SetText("独立")
                    -- 清空内存并加载当前角色黑名单
                    for k in pairs(BLACKLIST) do BLACKLIST[k] = nil end
                    for k in pairs(BLACKLIST_NAMES) do BLACKLIST_NAMES[k] = nil end
                    local currentChar = GetCurrentCharacterKey()
                    local charBlacklist = GetCharacterBlacklist(currentChar)
                    print("从通用模式切换到独立模式，加载角色", currentChar, "的黑名单，数据库中有", GetTableSize(charBlacklist), "个物品")
                    for key, value in pairs(charBlacklist) do
                        BLACKLIST[key] = true
                        BLACKLIST_NAMES[key] = type(value) == "string" and value or select(1, GetItemInfo(key)) or key
                    end
                    print("加载完成，内存中现在有", GetTableSize(BLACKLIST), "个物品")
                    -- 启用角色选择下拉框
                    if typeManagerFrame.charSelectDropdown then
                        UIDropDownMenu_EnableDropDown(typeManagerFrame.charSelectDropdown)
                    end
                    -- 保存模式状态
                    -- 保存到当前角色的设置中
                    local charKey = GetCurrentCharacterKey()
                    -- 🔧 修复：确保不会意外创建角色数据结构
                    if not AutoSellLowLevelGearDB.characters then
                        AutoSellLowLevelGearDB.characters = {}
                    end
                    if not AutoSellLowLevelGearDB.characters[charKey] then
                        print("模式切换时创建新的角色数据结构，角色键值='" .. charKey .. "'")
                        AutoSellLowLevelGearDB.characters[charKey] = {}
                    end
                    AutoSellLowLevelGearDB.characters[charKey].blacklistMode = "character"
                    print("已切换到角色独立黑名单模式，独立黑名单中有", GetTableSize(BLACKLIST), "个物品")
                end
                RefreshTypeManagerBlacklist()
            end)
            typeManagerFrame.blModeToggleBtn.hasClickHandler = true
        end
        
        if typeManagerFrame.wlModeToggleBtn and not typeManagerFrame.wlModeToggleBtn.hasClickHandler then
            typeManagerFrame.wlModeToggleBtn:SetScript("OnClick", function(self)
                -- 切换白名单模式
                if whitelistMode == "character" then
                    -- 从角色模式切换到通用模式
                    -- 只有当前模式确实是角色模式时，才保存当前数据为角色数据
                    local currentChar = GetCurrentCharacterKey()
                    local whitelistCount = GetTableSize(WHITELIST)
                    print("从独立模式切换到通用模式，当前内存白名单有", whitelistCount, "个物品")
                    
                    -- 🔧 修复：只有当内存中有数据时才保存，避免空数据覆盖数据库
                    if whitelistCount > 0 then
                        print("保存角色", currentChar, "的白名单到数据库")
                        SaveCharacterWhitelist(currentChar, WHITELIST)
                    else
                        print("⚠️ 内存白名单为空，跳过保存以保护数据库中现有的角色数据")
                        -- 检查数据库中是否有该角色的数据
                        local existingWhitelist = GetCharacterWhitelist(currentChar)
                        local existingCount = GetTableSize(existingWhitelist)
                        if existingCount > 0 then
                            print("数据库中角色", currentChar, "已有", existingCount, "个白名单物品，已保护")
                        end
                    end
                    whitelistMode = "global"
                    self:SetText("通用")
                    -- 清空内存并加载全服白名单
                    for k in pairs(WHITELIST) do WHITELIST[k] = nil end
                    for k in pairs(WHITELIST_NAMES) do WHITELIST_NAMES[k] = nil end
                    local globalWhitelist = GetGlobalWhitelist()
                    for key, value in pairs(globalWhitelist) do
                        WHITELIST[key] = true
                        WHITELIST_NAMES[key] = type(value) == "string" and value or select(1, GetItemInfo(key)) or key
                    end
                    -- 禁用角色选择下拉框
                    if typeManagerFrame.wlCharSelectDropdown then
                        UIDropDownMenu_DisableDropDown(typeManagerFrame.wlCharSelectDropdown)
                    end
                    -- 保存模式状态
                    -- 保存到当前角色的设置中
                    local charKey = GetCurrentCharacterKey()
                    -- 🔧 修复：确保不会意外创建角色数据结构
                    if not AutoSellLowLevelGearDB.characters then
                        AutoSellLowLevelGearDB.characters = {}
                    end
                    if not AutoSellLowLevelGearDB.characters[charKey] then
                        print("模式切换时创建新的角色数据结构，角色键值='" .. charKey .. "'")
                        AutoSellLowLevelGearDB.characters[charKey] = {
                            whitelistMode = "global"
                        }
                        -- 不要创建空的whitelist字段，保持undefined以便后续正确处理
                    else
                        local existingWhitelistCount = GetTableSize(AutoSellLowLevelGearDB.characters[charKey].whitelist or {})
                        print("模式切换时加载现有角色数据，角色键值='" .. charKey .. "'，白名单数量=" .. existingWhitelistCount)
                        
                        -- 🔧 关键修复：只设置模式，不要动whitelist数据
                        AutoSellLowLevelGearDB.characters[charKey].whitelistMode = "global"
                    end
                    print("已切换到跨服通用白名单模式，全局白名单中有", GetTableSize(WHITELIST), "个物品")
                else
                    -- 从通用模式切换到角色模式
                    -- 当前内存中的数据是通用数据，需要保存到通用存储，但不要覆盖，因为可能已经是最新的
                    -- SaveGlobalWhitelist(WHITELIST) -- 移除这行，避免数据干扰
                    whitelistMode = "character"
                    self:SetText("独立")
                    -- 清空内存并加载当前角色白名单
                    for k in pairs(WHITELIST) do WHITELIST[k] = nil end
                    for k in pairs(WHITELIST_NAMES) do WHITELIST_NAMES[k] = nil end
                    local currentChar = GetCurrentCharacterKey()
                    
                    local charWhitelist = GetCharacterWhitelist(currentChar)
                    print("从通用模式切换到独立模式，加载角色", currentChar, "的白名单，数据库中有", GetTableSize(charWhitelist), "个物品")
                    for key, value in pairs(charWhitelist) do
                        WHITELIST[key] = true
                        WHITELIST_NAMES[key] = type(value) == "string" and value or select(1, GetItemInfo(key)) or key
                    end
                    print("加载完成，内存中现在有", GetTableSize(WHITELIST), "个物品")
                    -- 启用角色选择下拉框
                    if typeManagerFrame.wlCharSelectDropdown then
                        UIDropDownMenu_EnableDropDown(typeManagerFrame.wlCharSelectDropdown)
                    end
                    -- 保存模式状态
                    -- 保存到当前角色的设置中
                    local charKey = GetCurrentCharacterKey()
                    -- 🔧 修复：确保不会意外创建角色数据结构
                    if not AutoSellLowLevelGearDB.characters then
                        AutoSellLowLevelGearDB.characters = {}
                    end
                    if not AutoSellLowLevelGearDB.characters[charKey] then
                        print("模式切换时创建新的角色数据结构，角色键值='" .. charKey .. "'")
                        AutoSellLowLevelGearDB.characters[charKey] = {
                            whitelistMode = "character"
                        }
                        -- 不要创建空的whitelist字段，保持undefined以便后续正确处理
                    else
                        -- 🔧 关键修复：只设置模式，不要动whitelist数据
                        AutoSellLowLevelGearDB.characters[charKey].whitelistMode = "character"
                    end
                    print("已切换到角色独立白名单模式，独立白名单中有", GetTableSize(WHITELIST), "个物品")
                end
                RefreshTypeManagerWhitelist()
            end)
            typeManagerFrame.wlModeToggleBtn.hasClickHandler = true
        end
    end
    typeManagerFrame:Show()
    -- 每次打开都重置搜索框为占位符
    if typeManagerFrame and typeManagerFrame.searchBox then
        local searchBox = typeManagerFrame.searchBox
        searchBox:SetText(searchBox.placeholder)
        searchBox:SetTextColor(0.7,0.7,0.7)
        searchBox:ClearFocus()
    end
    -- 每次打开时应用主题样式，以保证职业颜色正确显示
    -- 保存ApplyThemeStyle函数引用到框架上，以便后续调用
    if not typeManagerFrame.ApplyThemeStyle and ApplyThemeStyle then
        typeManagerFrame.ApplyThemeStyle = ApplyThemeStyle
    end
    if typeManagerFrame.ApplyThemeStyle then
        typeManagerFrame.ApplyThemeStyle()
    end
    -- 打开时恢复窗口位置
    if AutoSellLowLevelGearDB and AutoSellLowLevelGearDB.framePos then
        local pos = AutoSellLowLevelGearDB.framePos
        typeManagerFrame:ClearAllPoints()
        typeManagerFrame:SetPoint(pos.point or "CENTER", UIParent, pos.relativePoint or "CENTER", pos.x or 0, pos.y or 0)
    end
end

-- 获取表大小（全局函数）
function GetTableSize(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end

-- 生成物品的唯一标识符（基于物品ID和物品等级）
function GetItemUniqueKey(itemLink)
    if not itemLink then return nil end
    
    local itemID = GetItemInfoFromHyperlink(itemLink)
    if not itemID then return itemLink end -- 如果无法获取ID，则使用原始链接
    
    -- 尝试获取物品等级
    local itemLevel = GetDetailedItemLevelInfo(itemLink)
    if not itemLevel or itemLevel == 0 then
        local _, _, _, itemLevelFromInfo = GetItemInfo(itemID)
        itemLevel = itemLevelFromInfo
    end
    
    -- 生成唯一标识符：物品ID + 物品等级
    return itemID .. "_" .. (itemLevel or 0)
end

-- 去重函数：根据物品ID和物品等级去重
function RemoveDuplicateItems(itemList, itemNames)
    local uniqueItems = {}
    local uniqueNames = {}
    local seenKeys = {}
    
    for itemLink, value in pairs(itemList) do
        -- 🔧 修复：使用统一的唯一标识符函数
        local uniqueKey = GetItemUniqueIdentifier(itemLink)
        if uniqueKey and not seenKeys[uniqueKey] then
            -- 第一次见到这个物品ID+等级+品质+类型组合
            uniqueItems[itemLink] = value
            if itemNames and itemNames[itemLink] then
                uniqueNames[itemLink] = itemNames[itemLink]
            end
            seenKeys[uniqueKey] = itemLink
        else
            -- 重复物品，跳过（不输出消息，避免过多打印）
        end
    end
    
    return uniqueItems, uniqueNames
end

-- 获取当前选中的角色
local function GetSelectedCharacter()
    if typeManagerFrame and typeManagerFrame.charSelectDropdown then
        return UIDropDownMenu_GetSelectedValue(typeManagerFrame.charSelectDropdown) or GetCurrentCharacterKey()
    end
    return GetCurrentCharacterKey()
end

-- 统一黑名单刷新逻辑
local function TryRefreshTypeManagerBlacklist()
    if typeManagerFrame and typeManagerFrame:IsShown() then
                RefreshTypeManagerBlacklist()
        end
end

-- 统一白名单刷新逻辑
local function TryRefreshTypeManagerWhitelist()
    if typeManagerFrame and typeManagerFrame:IsShown() then
        RefreshTypeManagerWhitelist()
    end
end

-- 修改AddToBlacklist，支持itemLink
function AddToBlacklist(_, itemLink)
    if not itemLink then
        print("错误：请提供物品链接")
        return
    end
    
    local currentChar = GetCurrentCharacterKey()
    local key = itemLink
    
    -- 检查是否存在冲突
    if WHITELIST[key] then
        -- 显示冲突确认窗口
        ShowConflictConfirmDialog(
            itemLink,
            "白名单",
            "黑名单",
            function() -- 确认回调
                -- 从白名单移除
                WHITELIST[key] = nil
                WHITELIST_NAMES[key] = nil
                
                -- 添加到黑名单
                BLACKLIST[key] = true
                BLACKLIST_NAMES[key] = select(1, GetItemInfo(key)) or itemLink  -- 存储物品名称而不是链接
                
                -- 保存数据（根据当前模式）
                if whitelistMode == "global" then
                    SaveGlobalWhitelist(WHITELIST)
                else
                    if whitelistMode == "global" then
                SaveGlobalWhitelist(WHITELIST)
                print("已保存到跨服通用白名单")
            else
                SaveWhitelist(currentChar)
                print("已保存到角色独立白名单")
            end
                end
                if blacklistMode == "global" then
                    SaveGlobalBlacklist(BLACKLIST)
                else
                    if blacklistMode == "global" then
                SaveGlobalBlacklist(BLACKLIST)
                print("已保存到跨服通用黑名单")
            else
                SaveBlacklist(currentChar)
                print("已保存到角色独立黑名单")
            end
                end
                
                print("物品已从白名单移除并添加到黑名单:", itemLink)
                TryRefreshTypeManagerBlacklist()
                TryRefreshTypeManagerWhitelist()
                
                if MerchantFrame and MerchantFrame:IsShown() then
                    C_Timer.After(0.1, function()
                        UpdateSellPopupStatus(false)
                    end)
                end
            end,
            function() -- 取消回调
                print("取消添加到黑名单:", itemLink)
            end
        )
    else
        -- 无冲突，检查是否已存在
        if IsItemAlreadyInBlacklist(itemLink) then
            print("物品", itemLink, "已在黑名单中")
        else
            BLACKLIST[key] = true
            BLACKLIST_NAMES[key] = select(1, GetItemInfo(key)) or itemLink  -- 存储物品名称而不是链接
            if blacklistMode == "global" then
                SaveGlobalBlacklist(BLACKLIST)
                print("已保存到跨服通用黑名单")
            else
                SaveBlacklist(currentChar)
                print("已保存到角色独立黑名单")
            end
            print("已将", itemLink, "添加到黑名单")
        end
        
        TryRefreshTypeManagerBlacklist()
        if MerchantFrame and MerchantFrame:IsShown() then
            C_Timer.After(0.1, function()
                UpdateSellPopupStatus(false)
            end)
        end
    end
end

-- 白名单管理函数
function AddToWhitelist(_, itemLink)
    if not itemLink then
        print("错误：请提供物品链接")
        return
    end
    
    local currentChar = GetCurrentCharacterKey()
    local key = itemLink
    
    -- 检查是否存在冲突
    if BLACKLIST[key] then
        -- 显示冲突确认窗口
        ShowConflictConfirmDialog(
            itemLink,
            "黑名单",
            "白名单",
            function() -- 确认回调
                -- 从黑名单移除
                BLACKLIST[key] = nil
                BLACKLIST_NAMES[key] = nil
                
                -- 添加到白名单
                WHITELIST[key] = true
                WHITELIST_NAMES[key] = select(1, GetItemInfo(key)) or itemLink  -- 存储物品名称而不是链接
                
                -- 保存数据
                if blacklistMode == "global" then
                SaveGlobalBlacklist(BLACKLIST)
                print("已保存到跨服通用黑名单")
            else
                SaveBlacklist(currentChar)
                print("已保存到角色独立黑名单")
            end
                if whitelistMode == "global" then
                SaveGlobalWhitelist(WHITELIST)
                print("已保存到跨服通用白名单")
            else
                SaveWhitelist(currentChar)
                print("已保存到角色独立白名单")
            end
                
                print("物品已从黑名单移除并添加到白名单:", itemLink)
                TryRefreshTypeManagerBlacklist()
                TryRefreshTypeManagerWhitelist()
                
                if MerchantFrame and MerchantFrame:IsShown() then
                    C_Timer.After(0.1, function()
                        UpdateSellPopupStatus(false)
                    end)
                end
            end,
            function() -- 取消回调
                print("取消添加到白名单:", itemLink)
            end
        )
    else
        -- 无冲突，检查是否已存在
        if IsItemAlreadyInWhitelist(itemLink) then
            print("物品", itemLink, "已在白名单中")
        else
            WHITELIST[key] = true
            WHITELIST_NAMES[key] = select(1, GetItemInfo(key)) or itemLink  -- 存储物品名称而不是链接
            
            if whitelistMode == "global" then
                SaveGlobalWhitelist(WHITELIST)
                print("已保存到跨服通用白名单")
            else
                SaveWhitelist(currentChar)
                print("已保存到角色独立白名单")
            end
            print("已将", itemLink, "添加到白名单")
        end
        
        TryRefreshTypeManagerWhitelist()
        if MerchantFrame and MerchantFrame:IsShown() then
            C_Timer.After(0.1, function()
                UpdateSellPopupStatus(false)
            end)
        end
    end
end

function RemoveFromBlacklist(itemLink)
    if not itemLink then
        print("错误：请提供物品链接")
        return
    end
    
    local selectedChar = GetSelectedCharacter()
    local currentChar = GetCurrentCharacterKey()
    local key = itemLink
    
    if selectedChar == currentChar then
        -- 当前角色：直接操作内存中的黑名单
        if not BLACKLIST[key] then
            print("错误：物品链接", itemLink, "不在黑名单中")
            return
        end
        BLACKLIST[key] = nil
        BLACKLIST_NAMES[key] = nil
        SaveBlacklist(currentChar)
        print("已将", itemLink, "从黑名单中移除")
    else
        -- 其他角色：需要加载、修改、保存该角色的黑名单
        local charBlacklist = GetCharacterBlacklist(selectedChar)
        if not charBlacklist[key] then
            print("错误：物品链接", itemLink, "不在角色", selectedChar, "的黑名单中")
            return
        end
        charBlacklist[key] = nil
        SaveCharacterBlacklist(selectedChar, charBlacklist)
        print("已将", itemLink, "从角色", selectedChar, "的黑名单中移除")
    end
    TryRefreshTypeManagerBlacklist()
    if MerchantFrame and MerchantFrame:IsShown() then
        C_Timer.After(0.1, function()
            UpdateSellPopupStatus(false) -- 不显示消息，避免过多提示
        end)
    end
end

function RemoveFromWhitelist(itemLink)
    if not itemLink then
        print("错误：请提供物品链接")
        return
    end
    
    local selectedChar = GetSelectedCharacter()
    local currentChar = GetCurrentCharacterKey()
    
    if selectedChar == currentChar then
        -- 当前角色：直接操作内存中的白名单
        -- 首先尝试直接匹配
        local keyToRemove = nil
        if WHITELIST[itemLink] then
            keyToRemove = itemLink
        else
            -- 如果直接匹配失败，使用智能匹配
            local currentIdentifier = GetItemUniqueIdentifier(itemLink)
            if currentIdentifier then
                for key, value in pairs(WHITELIST) do
                    if value then
                        local keyIdentifier = GetItemUniqueIdentifier(key)
                        if keyIdentifier and keyIdentifier == currentIdentifier then
                            keyToRemove = key
                            break
                        end
                    end
                end
            end
        end
        
        if not keyToRemove then
            print("错误：物品链接", itemLink, "不在白名单中")
            return
        end
        
        WHITELIST[keyToRemove] = nil
        WHITELIST_NAMES[keyToRemove] = nil
        SaveWhitelist(currentChar)
        print("已将", itemLink, "从白名单中移除")
    else
        -- 其他角色：需要加载、修改、保存该角色的白名单
        local charWhitelist = GetCharacterWhitelist(selectedChar)
        
        -- 使用智能匹配查找要移除的key
        local keyToRemove = nil
        if charWhitelist[itemLink] then
            keyToRemove = itemLink
        else
            -- 如果直接匹配失败，使用智能匹配
            local currentIdentifier = GetItemUniqueIdentifier(itemLink)
            if currentIdentifier then
                for key, value in pairs(charWhitelist) do
                    if value then
                        local keyIdentifier = GetItemUniqueIdentifier(key)
                        if keyIdentifier and keyIdentifier == currentIdentifier then
                            keyToRemove = key
                            break
                        end
                    end
                end
            end
        end
        
        if not keyToRemove then
            print("错误：物品链接", itemLink, "不在角色", selectedChar, "的白名单中")
            return
        end
        
        charWhitelist[keyToRemove] = nil
        SaveCharacterWhitelist(selectedChar, charWhitelist)
        print("已将", itemLink, "从角色", selectedChar, "的白名单中移除")
    end
    TryRefreshTypeManagerWhitelist()
    if MerchantFrame and MerchantFrame:IsShown() then
        C_Timer.After(0.1, function()
            UpdateSellPopupStatus(false) -- 不显示消息，避免过多提示
        end)
    end
end

-- ========================================
-- 冲突确认窗口系统
-- ========================================

-- 创建冲突确认窗口
local conflictConfirmFrame = nil

-- 应用冲突确认窗口主题
function ApplyConflictConfirmTheme()
    if not conflictConfirmFrame then return end
    
    local currentTheme = AutoSellLowLevelGearDB.themeStyle or "minimalist"
    if currentTheme == "minimalist" then
        conflictConfirmFrame:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = nil,
            tile = true, tileSize = 16, edgeSize = 0,
            insets = {left = 0, right = 0, top = 0, bottom = 0}
        })
        conflictConfirmFrame:SetBackdropColor(0,0,0,0.92)
    else
        conflictConfirmFrame:SetBackdrop({
            bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
            edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
            tile = true, tileSize = 32, edgeSize = 32,
            insets = {left = 11, right = 12, top = 12, bottom = 11}
        })
        conflictConfirmFrame:SetBackdropColor(0.4, 0.4, 0.4, 0.85)
        conflictConfirmFrame:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
    end
end

function ShowConflictConfirmDialog(itemLink, fromList, toList, onConfirm, onCancel)
    if conflictConfirmFrame then
        conflictConfirmFrame:Hide()
    end
    
    conflictConfirmFrame = CreateFrame("Frame", "AutoSellConflictConfirmFrame", UIParent, "BackdropTemplate")
    conflictConfirmFrame:SetSize(400, 300)  -- 增加高度避免重叠
    conflictConfirmFrame:SetPoint("CENTER")
    conflictConfirmFrame:SetFrameStrata("FULLSCREEN_DIALOG")
    conflictConfirmFrame:EnableMouse(true)
    
    -- 应用主题样式
    ApplyConflictConfirmTheme()
    
    -- 标题
    local title = conflictConfirmFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -20)
    title:SetText("名单冲突确认")
    title:SetTextColor(1, 0.8, 0)
    
    -- 物品显示
    local itemText = conflictConfirmFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    itemText:SetPoint("TOP", title, "BOTTOM", 0, -20)
    itemText:SetText("物品：" .. itemLink)
    
    -- 冲突说明
    local fromListText = fromList == "黑名单" and "黑名单" or "白名单"
    local toListText = toList == "白名单" and "白名单" or "黑名单"
    local actionText = toList == "白名单" and "无条件售卖" or "不会售卖"
    
    local conflictText = conflictConfirmFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    conflictText:SetPoint("TOP", itemText, "BOTTOM", 0, -15)
    conflictText:SetText("该物品已存在于" .. fromListText .. "中。")
    
    local actionDesc = conflictConfirmFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    actionDesc:SetPoint("TOP", conflictText, "BOTTOM", 0, -5)
    actionDesc:SetText("添加到" .. toListText .. "将自动从" .. fromListText .. "移除。")
    
    -- 操作结果预览
    local resultTitle = conflictConfirmFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    resultTitle:SetPoint("TOP", actionDesc, "BOTTOM", 0, -20)
    resultTitle:SetText("操作结果：")
    resultTitle:SetTextColor(1, 1, 1)
    
    local result1 = conflictConfirmFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    result1:SetPoint("TOP", resultTitle, "BOTTOM", 0, -8)
    result1:SetText("• 从" .. fromListText .. "移除 " .. itemLink)
    result1:SetTextColor(1, 0.5, 0.5)
    
    local result2 = conflictConfirmFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    result2:SetPoint("TOP", result1, "BOTTOM", 0, -5)
    result2:SetText("• 添加到" .. toListText .. " " .. itemLink)
    result2:SetTextColor(0.5, 1, 0.5)
    
    local result3 = conflictConfirmFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    result3:SetPoint("TOP", result2, "BOTTOM", 0, -5)
    result3:SetText("• 此物品将" .. actionText)
    result3:SetTextColor(1, 0.8, 0)
    
    -- 确定按钮
    local confirmBtn = CreateFrame("Button", nil, conflictConfirmFrame, "UIPanelButtonTemplate")
    confirmBtn:SetSize(80, 28)
    confirmBtn:SetPoint("BOTTOM", conflictConfirmFrame, "BOTTOM", -50, 25)  -- 调整位置避免重叠
    confirmBtn:SetText("确定")
    confirmBtn:SetScript("OnClick", function()
        conflictConfirmFrame:Hide()
        if onConfirm then onConfirm() end
    end)
    
    -- 取消按钮
    local cancelBtn = CreateFrame("Button", nil, conflictConfirmFrame, "UIPanelButtonTemplate")
    cancelBtn:SetSize(80, 28)
    cancelBtn:SetPoint("BOTTOM", conflictConfirmFrame, "BOTTOM", 50, 25)  -- 调整位置避免重叠
    cancelBtn:SetText("取消")
    cancelBtn:SetScript("OnClick", function()
        conflictConfirmFrame:Hide()
        if onCancel then onCancel() end
    end)
    
    -- ESC键关闭窗口
    conflictConfirmFrame:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            conflictConfirmFrame:Hide()
            if onCancel then onCancel() end
        end
    end)
    conflictConfirmFrame:SetPropagateKeyboardInput(true)
    
    conflictConfirmFrame:Show()
end

-- 判断物品是否应该被售卖
local function ShouldSellItem(itemID, itemLink)
    if not itemID or not itemLink then 
        return false 
    end
    
    -- 优先级1：白名单检查（最高优先级）- 无条件售卖
    if IsInWhitelist(itemLink) then
        return true  -- 白名单物品无条件售卖，跳过所有其他检查
    end
    
    -- 基础条件：检查商人是否愿意收购此物品
    local sellPrice = select(11, GetItemInfo(itemID))
    if not sellPrice or sellPrice <= 0 then
        -- 白名单物品无条件售卖，跳过售价检查
        if IsInWhitelist(itemLink) then
            return true
        end
        -- 记录被过滤的不可售卖物品
        return false -- 商人不收购的物品（售价为0或nil），包括任务物品、某些绑定物品等
    end
    
    -- 额外检查：某些物品虽然显示有售价，但实际不能出售给商人
    -- 检查是否为任务相关或特殊绑定物品
    local itemName, itemLink_full, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, equipLoc, itemTexture, sellPrice2, itemClassID, itemSubClassID = GetItemInfo(itemID)
    
    -- 检查特殊的不可售卖物品类型
    if itemClassID == 12 then -- 任务物品类型
        -- 白名单物品无条件售卖，跳过任务物品限制
        if IsInWhitelist(itemLink) then
            return true
        end
        return false
    end
    
    -- 检查物品是否真的可以出售给商人
    -- 某些物品虽然有售价，但被系统标记为不可出售
    local isUsable, notUsableReason = IsUsableItem(itemID)
    
    -- 检查物品的详细信息来判断是否真的可以出售
    -- 对于某些特殊物品（如竞技场饰品、任务奖励等），虽然显示售价但实际不能出售
    local bindType = select(14, GetItemInfo(itemID))
    
    -- 额外的不可售卖物品检查
    if bindType == 1 then -- 拾取绑定物品需要额外检查
        -- 检查是否为特殊的收集类物品或任务相关物品
        -- 这些物品通常不能出售给商人，即使显示有售价
        if itemName then
            local specialKeywords = {
                "竞技场", "Arena", "Master", "任务", "Quest", 
                "收集", "Collection", "奖杯", "Trophy",
                "证书", "Certificate", "徽章", "Badge"
            }
            
            for _, keyword in ipairs(specialKeywords) do
                if itemName:find(keyword) then
                    -- 白名单物品无条件售卖，跳过特殊关键词限制
                    if IsInWhitelist(itemLink) then
                        return true
                    end
                    return false
                end
            end
        end
    end
    
    -- 新增：职业套装兑换代币识别（使用混合系统）
    if IsDefinitelyTierToken_Hybrid(itemID) then
        if not AutoSellLowLevelGearDB or not AutoSellLowLevelGearDB.typeWhitelist or not AutoSellLowLevelGearDB.typeWhitelist["SET_ITEM"] then
            -- 白名单物品无条件售卖，跳过类型白名单限制
            if IsInWhitelist(itemLink) then
                return true
            end
            return false
        end
        if IsInBlacklist(itemLink) then
            return false
        end
        -- 新增：检查是否启用了"不售卖本职业可使用代币"选项
        if AutoSellLowLevelGearDB.dontSellClassTokens then
            -- 检查是否为当前职业且能右键使用的代币 (使用混合系统)
            if IsTokenForCurrentClass_Hybrid(itemID, nil, nil, itemLink) and CanUseToken and CanUseToken(itemLink, itemID) then
                -- 白名单物品无条件售卖，跳过职业代币限制
                if IsInWhitelist(itemLink) then
                    return true
                end
                return false -- 不售卖本职业可使用的代币（能右键使用变为套装的代币）
            end
        end
        local itemLevel = GetDetailedItemLevelInfo(itemLink) or select(4, GetItemInfo(itemID))
        if itemLevel and itemLevel < GetCurrentItemLevelThreshold() then
            return true
        end
        return false
    end
    
    -- 新增：神器圣物特殊判断
    if IsArtifactRelic(itemID) then
        if not AutoSellLowLevelGearDB or not AutoSellLowLevelGearDB.typeWhitelist or not AutoSellLowLevelGearDB.typeWhitelist["ARTIFACT_RELIC"] then
            -- 白名单物品无条件售卖，跳过圣物类型白名单限制
            if IsInWhitelist(itemLink) then
                return true
            end
            return false
        end
        if IsInBlacklist(itemLink) then
            return false
        end
        local itemLevel = GetDetailedItemLevelInfo(itemLink) or select(4, GetItemInfo(itemID))
        local bindType = select(14, GetItemInfo(itemID))
        if not itemLevel or itemLevel >= GetCurrentItemLevelThreshold() then
            -- 白名单物品无条件售卖，跳过等级阈值限制
            if IsInWhitelist(itemLink) then
                return true
            end
            return false
        end
        -- 只允许拾取绑定(1)和灵魂绑定(2)售卖，装备绑定(3)不售卖
        if bindType ~= 1 and bindType ~= 2 then
            -- 白名单物品无条件售卖，跳过绑定类型限制
            if IsInWhitelist(itemLink) then
                return true
            end
            return false
        end
        return true
    end

    -- 1. 特殊物品关键字判断（职业套装兑换物等）- 保留作为后备
    local keywords = {"适用于", "拾取专精", "使用:"}
    local itemLevel = GetDetailedItemLevelInfo(itemLink)
    if not itemLevel or itemLevel == 0 then
        itemLevel = select(4, GetItemInfo(itemID))
    end
    if ItemTooltipContainsAll(itemLink, keywords) and itemLevel and itemLevel < GetCurrentItemLevelThreshold() then
        if not AutoSellLowLevelGearDB or not AutoSellLowLevelGearDB.typeWhitelist or not AutoSellLowLevelGearDB.typeWhitelist["SET_ITEM"] then
            -- 白名单物品无条件售卖，跳过套装物品类型白名单限制
            if IsInWhitelist(itemLink) then
                return true
            end
            return false
        end
        return not IsInBlacklist(itemLink)
    end

    -- 2. 衬衣/战袍等特殊部位放宽绑定类型
    local itemName, _, itemRarity, _, _, itemType, itemSubType, _, equipLoc = GetItemInfo(itemID)
    local bindType = select(14, GetItemInfo(itemID))
    local specialTypes = { INVTYPE_BODY = true, INVTYPE_TABARD = true }
    if equipLoc == "INVTYPE_RELIC" then
        if IsInBlacklist(itemLink) then
            return false
        end
        if not itemLevel or itemLevel >= GetCurrentItemLevelThreshold() then
            -- 白名单物品无条件售卖，跳过圣物等级限制
            if IsInWhitelist(itemLink) then
                return true
            end
            return false
        end
        return true
    end
    if specialTypes[equipLoc] then
        if not equipLoc or not AutoSellLowLevelGearDB or not AutoSellLowLevelGearDB.typeWhitelist or not AutoSellLowLevelGearDB.typeWhitelist[equipLoc] then
            -- 白名单物品无条件售卖，跳过特殊装备类型白名单限制
            if IsInWhitelist(itemLink) then
                return true
            end
            return false
        end
        if IsInBlacklist(itemLink) then
            return false
        end
        if not itemLevel or itemLevel >= GetCurrentItemLevelThreshold() then
            -- 白名单物品无条件售卖，跳过等级阈值限制
            if IsInWhitelist(itemLink) then
                return true
            end
            return false
        end
        if itemRarity and itemRarity >= 5 then
            -- 白名单物品无条件售卖，跳过稀有度限制
            if IsInWhitelist(itemLink) then
                return true
            end
            return false
        end
        
        -- 新增：检查是否启用了"不售卖未收藏的装饰品"选项
        if AutoSellLowLevelGearDB.dontSellUnlearnedCosmetics then
            -- 检查是否为装饰品，并且外观还未收藏
            if IsPureCosmeticItem(itemID, equipLoc) and not IsAppearanceLearned(itemID, itemLink) then
                -- 白名单物品无条件售卖，跳过装饰品收藏限制
                if IsInWhitelist(itemLink) then
                    return true
                end
                return false -- 不售卖未收藏的装饰品
            end
        end
        
        return true
    else
        -- 3. 其他装备类型仍需绑定类型判断
        if not equipLoc or not AutoSellLowLevelGearDB or not AutoSellLowLevelGearDB.typeWhitelist or not AutoSellLowLevelGearDB.typeWhitelist[equipLoc] then
            -- 白名单物品无条件售卖，跳过装备类型白名单限制
            if IsInWhitelist(itemLink) then
                return true
            end
            return false
        end
        if IsInBlacklist(itemLink) then
            return false
        end
        if not itemLevel or itemLevel >= GetCurrentItemLevelThreshold() then
            -- 白名单物品无条件售卖，跳过等级阈值限制
            if IsInWhitelist(itemLink) then
                return true
            end
            return false
        end
        if itemRarity and itemRarity >= 5 then
            -- 白名单物品无条件售卖，跳过稀有度限制
            if IsInWhitelist(itemLink) then
                return true
            end
            return false
        end
        if (AutoSellLowLevelGearDB.typeWhitelist["BIND_ON_EQUIP"] and bindType == 2)
            or (AutoSellLowLevelGearDB.typeWhitelist["BIND_ON_ACCOUNT"] and bindType == 3)
            or bindType == 1 then
            
            -- 新增：检查是否启用了"不售卖未收藏的装饰品"选项
            if AutoSellLowLevelGearDB.dontSellUnlearnedCosmetics then
                -- 只检查是否为装饰品，并且外观还未收藏
                if IsPureCosmeticItem(itemID, equipLoc) and not IsAppearanceLearned(itemID, itemLink) then
                    -- 白名单物品无条件售卖，跳过装饰品收藏限制
                    if IsInWhitelist(itemLink) then
                        return true
                    end
                    return false -- 不售卖未收藏的装饰品
                end
            end
            
            return true
        end
        -- 白名单物品无条件售卖，跳过绑定类型限制
        if IsInWhitelist(itemLink) then
            return true
        end
        return false
    end
end

-- 自定义弹窗Frame
local sellPopupFrame = nil
local popupItemButtons = {}
local popupItemsToSell = nil
local popupOnAccept = nil
local popupOnCancel = nil

-- 优化弹窗装备行布局
local function RefreshCustomSellPopup()
    if not sellPopupFrame or not popupItemsToSell then return end
    -- 新增：如果没有可售卖装备，自动关闭弹窗
    if #popupItemsToSell == 0 then
        sellPopupFrame:Hide()
        return
    end
    for _, btn in ipairs(popupItemButtons) do
        btn:Hide()
        btn:SetParent(nil)
    end
    wipe(popupItemButtons)
    sellPopupFrame.title:SetText("发现" .. #popupItemsToSell .. "件低等级装备（物品等级 < " .. GetCurrentItemLevelThreshold() .. " ）：")
    local SCROLL_HEIGHT = 200
    local ROW_HEIGHT = 22
    local scrollFrame = sellPopupFrame.scrollFrame
    local scrollChild = sellPopupFrame.scrollChild
    if not scrollFrame then
        scrollFrame = CreateFrame("ScrollFrame", nil, sellPopupFrame, "UIPanelScrollFrameTemplate")
        scrollFrame:SetPoint("TOPLEFT", sellPopupFrame, "TOPLEFT", 20, -48)
        scrollFrame:SetPoint("BOTTOMRIGHT", sellPopupFrame, "BOTTOMRIGHT", -50, 70)
        scrollFrame:SetHeight(SCROLL_HEIGHT)
        sellPopupFrame.scrollFrame = scrollFrame
        scrollChild = CreateFrame("Frame", nil, scrollFrame)
        scrollChild:SetSize(310, SCROLL_HEIGHT)
        scrollFrame:SetScrollChild(scrollChild)
        sellPopupFrame.scrollChild = scrollChild
    end
    for _, child in ipairs(scrollChild.rows or {}) do
        child:Hide()
        child:SetParent(nil)
    end
    scrollChild.rows = {}
    local y = 0
    local totalRows = 0
    local fullWidth = scrollChild:GetWidth() or 310
    for i, item in ipairs(popupItemsToSell) do
        local itemLevel = GetDetailedItemLevelInfo(item.itemLink) or select(4, GetItemInfo(item.itemID)) or "?"
        local rowFrame = CreateFrame("Frame", nil, scrollChild)
        rowFrame:SetSize(fullWidth, ROW_HEIGHT)
        rowFrame:SetPoint("TOP", scrollChild, "TOP", 0, -y)
        -- container整体右移
        local container = CreateFrame("Frame", nil, rowFrame)
        container:SetSize(fullWidth-60, ROW_HEIGHT)
        container:SetPoint("LEFT", rowFrame, "LEFT", 40, 0)
        -- 移除按钮
        local removeBtn = CreateFrame("Button", nil, container, "UIPanelButtonTemplate")
        removeBtn:SetSize(48, 18)
        removeBtn:SetPoint("LEFT", container, "LEFT", 0, 0)
        removeBtn:SetText("移除")
        removeBtn:SetNormalFontObject(GameFontNormal)
        removeBtn:SetHighlightFontObject(GameFontNormal)
        -- 加入魔兽自带小X图标
        if not removeBtn.icon then
            local icon = removeBtn:CreateTexture(nil, "ARTWORK")
            icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
            icon:SetSize(14,14)
            icon:SetPoint("LEFT", removeBtn, "LEFT", 2, 0)
            removeBtn.icon = icon
            removeBtn:SetText("  移除")
        end
        removeBtn:SetScript("OnClick", function()
            -- 检查物品是否在白名单中
            if IsInWhitelist(item.itemLink) then
                -- 如果在白名单中，从白名单移除
                RemoveFromWhitelist(item.itemLink)
            else
                -- 如果不在白名单中，添加到黑名单
                AddToBlacklist(nil, item.itemLink)
            end
            table.remove(popupItemsToSell, i)
            RefreshCustomSellPopup()
            if typeManagerFrame and typeManagerFrame:IsShown() then
                C_Timer.After(0.1, function()
                    RefreshTypeManagerBlacklist()
                    RefreshTypeManagerWhitelist()
                end)
            end
        end)
        -- 物品链接
        local linkFS = container:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        linkFS:SetPoint("LEFT", removeBtn, "RIGHT", 6, 0)
        linkFS:SetPoint("RIGHT", container, "RIGHT", 0, 0)
        linkFS:SetText(item.itemLink)
        linkFS:SetJustifyH("LEFT")
        linkFS:SetHeight(18)
        linkFS:EnableMouse(true)
        linkFS:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR_BOTTOM")
            GameTooltip:SetHyperlink(item.itemLink)
            GameTooltip:Show()
        end)
        linkFS:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
        -- 物品等级
        local levelFS = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        levelFS:SetPoint("RIGHT", rowFrame, "RIGHT", 0, 0)
        levelFS:SetText("["..itemLevel.."]")
        levelFS:SetJustifyH("RIGHT")
        levelFS:SetWidth(50)
        levelFS:SetHeight(18)
        table.insert(popupItemButtons, rowFrame)
        table.insert(scrollChild.rows, rowFrame)
        y = y + ROW_HEIGHT
        totalRows = i
    end
    scrollChild:SetHeight(totalRows * 24 + 12)
end

ShowCustomSellPopup = function(itemsToSell, onAccept, onCancel)
    if not itemsToSell or #itemsToSell == 0 then
        if sellPopupFrame then sellPopupFrame:Hide() end
        return
    end
    if sellPopupFrame then
        sellPopupFrame:Hide()
    end
    if not sellPopupFrame then
        sellPopupFrame = CreateFrame("Frame", "AutoSellSellPopupFrame", UIParent, "BackdropTemplate")
        sellPopupFrame:SetSize(400, 680)
        sellPopupFrame:SetPoint("CENTER")
        sellPopupFrame:SetFrameStrata("DIALOG")
        -- 初始样式将在ApplySellPopupTheme中设置
        sellPopupFrame:EnableMouse(true)
        sellPopupFrame:SetMovable(true)
        sellPopupFrame:RegisterForDrag("LeftButton")
        sellPopupFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
        sellPopupFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
        -- 标题
        sellPopupFrame.title = sellPopupFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        sellPopupFrame.title:SetPoint("TOP", 10, -16) -- 整体右移10
        sellPopupFrame.title:SetTextColor(1, 0.82, 0)
        -- 标题左侧金币图标
        if not sellPopupFrame.mainIcon then
            sellPopupFrame.mainIcon = sellPopupFrame:CreateTexture(nil, "ARTWORK")
            sellPopupFrame.mainIcon:SetTexture("Interface\\Icons\\INV_Misc_Coin_01")
            sellPopupFrame.mainIcon:SetSize(18,18)
            sellPopupFrame.mainIcon:SetPoint("RIGHT", sellPopupFrame.title, "LEFT", -6, 0)
        end
        -- 确认按钮
        sellPopupFrame.acceptBtn = CreateFrame("Button", nil, sellPopupFrame, "UIPanelButtonTemplate")
        sellPopupFrame.acceptBtn:SetSize(100, 28)
        sellPopupFrame.acceptBtn:SetPoint("BOTTOMLEFT", 40, 20)
        sellPopupFrame.acceptBtn:SetText("确定售卖")
        sellPopupFrame.acceptBtn:SetScript("OnClick", function()
            if popupOnAccept then popupOnAccept() end
            sellPopupFrame:Hide()
        end)
        -- 取消按钮
        sellPopupFrame.cancelBtn = CreateFrame("Button", nil, sellPopupFrame, "UIPanelButtonTemplate")
        sellPopupFrame.cancelBtn:SetSize(100, 28)
        sellPopupFrame.cancelBtn:SetPoint("BOTTOMRIGHT", -40, 20)
        sellPopupFrame.cancelBtn:SetText("取消")
        sellPopupFrame.cancelBtn:SetScript("OnClick", function()
            if popupOnCancel then popupOnCancel() end
            sellPopupFrame:Hide()
        end)
        
        -- 添加拖拽接收功能
        sellPopupFrame:EnableMouse(true)
        sellPopupFrame:RegisterForDrag("LeftButton")
        sellPopupFrame:SetScript("OnReceiveDrag", function(self)
            local cursorType, cursorData = GetCursorInfo()
            if cursorType == "item" then
                local itemID = cursorData
                local itemName, itemLink = GetItemInfo(itemID)
                if itemLink then
                    -- 添加到白名单
                    AddToWhitelist(nil, itemLink)
                    ClearCursor()
                    
                    -- 如果类型管理器界面打开，刷新白名单显示
                    if typeManagerFrame and typeManagerFrame:IsShown() then
                        C_Timer.After(0.1, function()
                            RefreshTypeManagerWhitelist()
                        end)
                    end
                    
                    -- 重新扫描并刷新售卖列表
                    C_Timer.After(0.1, function()
                        local itemsToSell, itemLinks = ScanBagForLowLevelGear(0, true)
                        popupItemsToSell = itemsToSell
                        RefreshCustomSellPopup()
                    end)
                end
            end
        end)
    end
    popupItemsToSell = itemsToSell
    popupOnAccept = onAccept
    popupOnCancel = onCancel
    RefreshCustomSellPopup()
    ApplySellPopupTheme()
    sellPopupFrame:Show()
end

-- 扫描背包优化
ScanBagForLowLevelGear = function(retryCount, silent)
    retryCount = retryCount or 0
    silent = silent or false
    local itemsToSell = {}
    local itemLinksForPopup = {}
    local needRetry = false
    -- 扩大背包扫描范围，包括专业背包（材料包等）
    for bagID = 0, 12 do -- 0-12应该覆盖所有可能的背包，包括专业背包
        local numSlots = C_Container.GetContainerNumSlots(bagID)
        for slotID = 1, numSlots do
            local itemID = C_Container.GetContainerItemID(bagID, slotID)
            local itemLink = C_Container.GetContainerItemLink(bagID, slotID)
            if itemID and itemLink then
                    if ShouldSellItem(itemID, itemLink) then
                        -- 调试：显示售价信息
                        local sellPrice = select(11, GetItemInfo(itemID))
                        table.insert(itemsToSell, {
                            bagID = bagID,
                            slotID = slotID,
                            itemID = itemID,
                            itemLink = itemLink
                        })
                        table.insert(itemLinksForPopup, itemLink)
                end
            elseif itemID and not itemLink then
                needRetry = true
            end
        end
    end
    if needRetry and retryCount < 3 then
        print("发现物品信息未缓存，延迟重试...")
        C_Timer.After(0.2, function()
            local items, links = ScanBagForLowLevelGear(retryCount+1, silent)
            if #items > 0 then
                ShowCustomSellPopup(items, function() SellItems(items) end, nil)
            else
                -- 如果重试后仍没有装备，关闭现有窗口
                if sellPopupFrame and sellPopupFrame:IsShown() then
                    sellPopupFrame:Hide()
                end
            end
        end)
        return {}, {}
    end
    if not silent then
        print("扫描完成，找到", #itemsToSell, "件可售卖的装备")
    end
    return itemsToSell, itemLinksForPopup
end

-- 显示确认弹窗（自定义弹窗）
local function ShowSellConfirmation(itemsToSell)
    if #itemsToSell == 0 then
        print("没有找到需要售卖的装备")
        return
    end
    local itemLinks = {}
    for _, item in ipairs(itemsToSell) do
        table.insert(itemLinks, item.itemLink)
    end
    ShowCustomSellPopup(itemsToSell, function() SellItems(itemsToSell) end, nil)
end

-- 主要处理函数
OnMerchantShow = function()
    print("检测到打开商人界面，开始自动售卖流程...")
    C_Timer.After(0.5, function()
        UpdateSellPopupStatus(true) -- 显示消息，因为这是主动打开商人界面
    end)
end

-- 注册事件（已合并到下方的ADDON_LOADED事件处理器中）

-- 注册/as命令
SLASH_AS1 = "/as"
SLASH_AS2 = "/自动售卖"
SlashCmdList["AS"] = function(msg)
    local args = {}
    for arg in string.gmatch(msg, "%S+") do
        table.insert(args, arg)
    end
    local command = args[1] or ""
    if command == "help" then
        print("=== AutoSellLowLevelGear 插件帮助 ===")
        print("主要命令:")
        print("  /as                    - 打开插件设置界面")
        print("  /as help               - 显示此帮助信息")
        print("  /as scan               - 手动扫描背包")
        print("  /as lv <数字>          - 设置物品等级阈值")
        print("")
        print("当前设置:")
        print("  物品等级阈值:", GetCurrentItemLevelThreshold())
        print("  黑名单物品数量:", GetTableSize(BLACKLIST))
        print("  白名单物品数量:", GetTableSize(WHITELIST))
        if AutoSellLowLevelGearDB.autoUseToken then
            print("  自动使用代币: 已启用")
        end
        print("输入 /as 查看帮助信息")
        return
    end
    if command == "lv" then
        local newLevel = tonumber(args[2])
        if newLevel and newLevel > 0 then
            AutoSellLowLevelGearDB.itemLevelThreshold = newLevel
            print("物品等级阈值已设置为:", newLevel)
            -- 实时同步到界面输入框
            if typeManagerFrame and typeManagerFrame.lvEdit then
                local setThresholdEditBox = typeManagerFrame.setThresholdEditBox or function(val)
                    typeManagerFrame.lvEdit:SetText("|cff13fff1"..tostring(val).."|r")
            end
                setThresholdEditBox(newLevel)
            end
            -- 更新售卖窗口状态
            UpdateSellPopupStatus(true)
        else
            print("当前物品等级阈值:", GetCurrentItemLevelThreshold())
            print("用法: /as lv <数字>")
        end
        return
    end
    if command == "test" or command == "测试" then
        print("=== 自动售卖插件测试 ===")
        print("当前物品等级阈值:", GetCurrentItemLevelThreshold())
        print("支持的装备部位:")
        for equipLoc, name in pairs(EQUIP_LOC_NAMES) do
            print("  " .. equipLoc .. " -> " .. name)
        end
        print("黑名单物品数量:", GetTableSize(BLACKLIST))
        print("代币识别系统:", USE_NEW_TOKEN_SYSTEM and "新系统（Wowhead规律）" or "原系统（ID列表）")
        print("当前白名单设置:")
        if AutoSellLowLevelGearDB and AutoSellLowLevelGearDB.typeWhitelist then
            for equipLoc, enabled in pairs(AutoSellLowLevelGearDB.typeWhitelist) do
                if enabled then
                    print("  " .. equipLoc .. " -> 已启用")
                end
            end
        end
    elseif command == "bindtest" or command == "绑定测试" then
        print("=== 背包物品绑定类型测试 ===")
        local foundItems = {}
        for bagID = 0, NUM_BAG_SLOTS do
            local numSlots = C_Container.GetContainerNumSlots(bagID)
            for slotID = 1, numSlots do
                local itemID = C_Container.GetContainerItemID(bagID, slotID)
                local itemLink = C_Container.GetContainerItemLink(bagID, slotID)
                if itemID and itemLink then
                    local itemName, _, itemRarity, _, _, itemType, itemSubType, _, equipLoc = GetItemInfo(itemID)
                    local bindType = select(14, GetItemInfo(itemID))
                    if itemName and (itemName:find("绑定") or bindType) then
                        table.insert(foundItems, {
                            name = itemName,
                            itemID = itemID,
                            itemLink = itemLink,
                            equipLoc = equipLoc,
                            bindType = bindType,
                            itemRarity = itemRarity
                        })
                    end
                end
            end
        end
        if #foundItems > 0 then
            for _, item in ipairs(foundItems) do
                print(string.format("物品: %s (ID:%s)", item.itemLink, item.itemID))
                print(string.format("  装备部位: %s", item.equipLoc or "无"))
                print(string.format("  绑定类型: %s", item.bindType or "无"))
                print(string.format("  物品品质: %s", item.itemRarity or "无"))
                print("---")
            end
        else
            print("未找到相关物品")
        end
    elseif command == "scan" or command == "扫描" then
        print("手动扫描背包...")
        local itemsToSell = ScanBagForLowLevelGear()
        if #itemsToSell > 0 then
            ShowCustomSellPopup(itemsToSell, function() SellItems(itemsToSell) end, nil)
        else
            if sellPopupFrame then sellPopupFrame:Hide() end
        end
    elseif command == "tokentest" or command == "代币测试" then
        TestTokenMatching()
        print("=== 代币可用性测试 ===")
        -- 测试几个典型的代币ID
        local testTokens = {
            [52025] = "胜利者的圣洁印记 (不可直接使用)",
            [99671] = "受诅咒破坏者头盔 (可直接使用)",
            [193001] = "Dreadful Blasphemer's Effigy (可直接使用)",
            [105859] = "受诅咒破坏者精华 (不可直接使用)"
        }
        
        for itemID, description in pairs(testTokens) do
            local itemName = select(1, GetItemInfo(itemID))
            local isUsable = IsTokenDirectlyUsable(itemID)
            print(string.format("ID %d (%s): %s - %s", 
                itemID, 
                itemName or "未知物品", 
                description,
                isUsable and "|cff00ff00可直接使用|r" or "|cffff0000不可直接使用|r"))
        end
        
    elseif command == "tokenuse" or command == "代币使用" then
        print("=== 职业套装代币自动使用测试 ===")
        print("当前职业:", UnitClass("player"))
        print("自动使用功能:", AutoSellLowLevelGearDB.autoUseToken and "已启用" or "已禁用")
        
        -- 强制刷新所有代币的物品信息缓存
        print("正在刷新物品信息缓存...")
        for itemID, _ in pairs(TIER_SET_ITEMS) do
            GetItemInfo(itemID) -- 预加载物品信息
        end
        
        -- 延迟执行扫描，给物品信息加载一些时间
        C_Timer.After(0.5, function()
            local foundTokens = {}
            local totalItems = 0
            
            for bagID = 0, NUM_BAG_SLOTS do
                local numSlots = C_Container.GetContainerNumSlots(bagID)
                for slotID = 1, numSlots do
                    local itemID = C_Container.GetContainerItemID(bagID, slotID)
                    local itemLink = C_Container.GetContainerItemLink(bagID, slotID)
                    
                    if itemID then
                        totalItems = totalItems + 1
                    end
                    
                    if itemID and itemLink and TIER_SET_ITEMS[itemID] then
                        -- 安全地执行所有函数调用
                        local success, result = pcall(function()
                            -- 强制刷新物品信息缓存
                            local itemName, itemLink2, itemRarity, itemLevel = GetItemInfo(itemID)
                            
                            -- 如果物品信息未缓存，使用物品ID重新获取
                            if not itemName or not itemLink2 then
                                -- 尝试重新构建物品链接并获取信息
                                local tempLink = string.format("|cffffffff|Hitem:%d:0:0:0:0:0:0:0:0:0:0:0:0|h[]|h|r", itemID)
                                itemName, itemLink2, itemRarity, itemLevel = GetItemInfo(tempLink)
                            end
                            
                            -- 最后的后备选项：从背包itemLink解析名称
                            if not itemName and itemLink and itemLink ~= "[]" then
                                itemName = itemLink:match("%[(.-)%]") or "未知物品"
                            end
                            
                            -- 确定最终使用的itemLink
                            local finalItemLink = itemLink2 or itemLink
                            if not finalItemLink or finalItemLink == "" or finalItemLink == "[]" then
                                -- 使用物品名称构建链接
                                local displayName = itemName or ("物品ID:" .. itemID)
                                finalItemLink = string.format("|cffffffff|Hitem:%d:0:0:0:0:0:0:0:0:0:0:0:0|h[%s]|h|r", itemID, displayName)
                            end
                            
                            local tokenType = GetTokenTypeFromID(itemID) or "未知"
                            
                            -- 安全地调用CanUseToken并获取详细原因
                            local canUse = false
                            local useReason = "未知"
                            pcall(function()
                                canUse = CanUseToken(finalItemLink, itemID)
                                if not canUse then
                                    -- 检查具体原因
                                    if not IsTokenForCurrentClass(finalItemLink, itemID) then
                                        useReason = "非本职业"
                                    else
                                        local startTime, duration = GetItemCooldown(itemID)
                                        if startTime and startTime > 0 then
                                            useReason = "冷却中"
                                        else
                                            -- 检查背包空间
                                            local freeSlots = 0
                                            for checkBagID = 0, NUM_BAG_SLOTS do
                                                local numSlots = C_Container.GetContainerNumSlots(checkBagID)
                                                for checkSlotID = 1, numSlots do
                                                    local checkItemID = C_Container.GetContainerItemID(checkBagID, checkSlotID)
                                                    if not checkItemID then
                                                        freeSlots = freeSlots + 1
                                                    end
                                                end
                                            end
                                            if freeSlots < 1 then
                                                useReason = "背包满"
                                            elseif not IsTokenDirectlyUsable(itemID) then
                                                useReason = "需要NPC兑换"
                                            else
                                                useReason = "其他原因"
                                            end
                                        end
                                    end
                                else
                                    useReason = "可使用"
                                end
                            end)
                            
                            -- 安全地获取物品等级
                            local finalItemLevel = itemLevel
                            if not finalItemLevel then
                                pcall(function()
                                    finalItemLevel = GetDetailedItemLevelInfo(finalItemLink)
                                end)
                            end
                            if not finalItemLevel then
                                pcall(function()
                                    -- 尝试从tooltip获取物品等级
                                    local tooltip = CreateFrame("GameTooltip", "AutoSellTempTooltip", nil, "GameTooltipTemplate")
                                    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
                                    tooltip:SetHyperlink(finalItemLink)
                                    for i = 1, tooltip:NumLines() do
                                        local line = _G["AutoSellTempTooltipTextLeft" .. i]
                                        if line then
                                            local text = line:GetText()
                                            if text then
                                                local level = text:match("物品等级%s*(%d+)") or text:match("Item Level%s*(%d+)")
                                                if level then
                                                    finalItemLevel = tonumber(level)
                                                    break
                                                end
                                            end
                                        end
                                    end
                                    tooltip:Hide()
                                end)
                            end
                            
                            return {
                                itemID = itemID,
                                itemLink = finalItemLink,
                                itemLevel = finalItemLevel,
                                reason = "精确ID匹配",
                                canUse = canUse,
                                useReason = useReason,
                                tokenType = tokenType,
                                itemName = itemName,
                                bagSlot = "背包" .. bagID .. "位置" .. slotID
                            }
                        end)
                        
                        if success and result then
                            table.insert(foundTokens, result)
                        else
                            print("处理代币时出错 ID:", itemID, "错误:", tostring(result))
                        end
                    end
                end
            end
            
            print("扫描完成，找到", #foundTokens, "个代币")
            
            if #foundTokens > 0 then
                print("发现", #foundTokens, "个职业套装兑换代币:")
                for i, token in ipairs(foundTokens) do
                    -- 安全地处理每个代币的显示
                    local success, errorMsg = pcall(function()
                        local status = token.useReason or (token.canUse and "可使用" or "不可用")
                        local isForClass = "未知"
                        
                        -- 安全地调用IsTokenForCurrentClass
                        local success, result = pcall(function()
                            return IsTokenForCurrentClass(token.itemLink, token.itemID)
                        end)
                        if success then
                            isForClass = result and "本职业" or "非本职业"
                        else
                            isForClass = "检查出错"
                        end
                        
                        print(string.format("  %s (ID:%s, 等级:%s, 类型:%s, %s, %s, 位置:%s)", 
                            token.itemLink or "[]", token.itemID or "未知", token.itemLevel or "未知", 
                            token.tokenType or "未知", isForClass, status, token.bagSlot or "未知"))
                    end)
                    
                    if not success then
                        print("  显示代币", i, "时出错:", errorMsg)
                    end
                end
            else
                print("背包中未发现职业套装兑换代币")
            end
            
            -- 手动测试自动使用功能
            print("\n=== 开始测试自动使用功能 ===")
            if AutoSellLowLevelGearDB.autoUseToken then
                ScanBagForUsableTokens()
            else
                print("自动使用功能已禁用，请先使用 /as toggletoken 启用")
            end
        end)
        
        -- 立即返回，避免重复代码执行
        return
        
    elseif command == "toggletoken" or command == "切换代币" then
        AutoSellLowLevelGearDB.autoUseToken = not AutoSellLowLevelGearDB.autoUseToken
        print("职业套装代币检测功能:", AutoSellLowLevelGearDB.autoUseToken and "已启用" or "已禁用")
        if AutoSellLowLevelGearDB.autoUseToken then
            print("检测功能已启用，获得新代币时会自动检测并提示")
            C_Timer.After(1, ScanBagForUsableTokens)
        end
        
    elseif command == "testusable" or command == "测试可用性" then
        print("=== 物品可用性检测测试 ===")
        
        -- 测试几个已知的代币ID
        local testTokens = {
            78861, -- 堕落胜利者的护肩
            52028, -- 胜利者的圣洁印记
            105866, -- 受诅防护者精华
            99723  -- 受诅碾压者头盔
        }
        
        for _, itemID in ipairs(testTokens) do
            local itemName = GetItemInfo(itemID)
            if itemName then
                local usable, noMana = IsUsableItem(itemID)
                local spellName, spellID = GetItemSpell(itemID)
                local start, duration = GetItemCooldown(itemID)
                local directlyUsable = IsTokenDirectlyUsable(itemID)
                
                print(string.format("ID %d (%s):", itemID, itemName))
                print(string.format("  IsUsableItem: %s", tostring(usable)))
                print(string.format("  有法术效果: %s (%s)", spellName and "是" or "否", spellName or "无"))
                print(string.format("  有冷却信息: %s", start and "是" or "否"))
                print(string.format("  最终判断: %s", directlyUsable and "|cff00ff00可直接使用|r" or "|cffff0000不可直接使用|r"))
                print("")
            else
                print(string.format("ID %d: 物品信息未加载", itemID))
            end
        end
    elseif command == "testchat" or command == "测试聊天" then
        print("=== 测试聊天命令发送 ===")
        print("尝试发送一个简单的命令...")
        
        local success, errorMsg = pcall(function()
            DEFAULT_CHAT_FRAME.editBox:SetText("/say 聊天命令测试成功")
            ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
        end)
        
        if success then
            print("聊天命令发送成功！")
        else
            print("聊天命令发送失败:", errorMsg or "未知错误")
        end
        
    elseif command == "debug99723" or command == "调试99723" then
        -- 专门调试99723代币的详细信息
        local itemID = 99723
        local _, playerClass = UnitClass("player")
        print("=== 99723代币调试信息 ===")
        print("当前职业:", playerClass)
        print("职业对应代币类型:", table.concat(PLAYER_CLASS_TOKEN_MAPPING[playerClass] or {}, ", "))
        print("ITEM_ID_TO_TOKEN_TYPE[99723]:", ITEM_ID_TO_TOKEN_TYPE and ITEM_ID_TO_TOKEN_TYPE[itemID] or "未找到")
        print("GetTokenTypeFromID(99723):", GetTokenTypeFromID(itemID))
        print("TIER_SET_ITEMS[99723]:", TIER_SET_ITEMS[itemID] and "存在" or "不存在")
        
        -- 检查背包中是否有这个物品
        for bagID = 0, NUM_BAG_SLOTS do
            local numSlots = C_Container.GetContainerNumSlots(bagID)
            for slotID = 1, numSlots do
                local bagItemID = C_Container.GetContainerItemID(bagID, slotID)
                local itemLink = C_Container.GetContainerItemLink(bagID, slotID)
                if bagItemID == itemID then
                    print("找到物品:", itemLink)
                    
                    -- 详细的职业匹配调试
                    print("=== 职业匹配详细过程 ===")
                    
                    -- 安全调用IsTokenForClassByID
                    local success1, result1 = pcall(IsTokenForClassByID, itemID, playerClass)
                    print("IsTokenForClassByID结果:", success1 and result1 or ("错误: " .. tostring(result1)))
                    
                    -- 安全调用GetTokenTypeFromID
                    local success2, tokenType = pcall(GetTokenTypeFromID, itemID)
                    if success2 and tokenType then
                        print("代币类型匹配检查:")
                        local classTokenTypes = PLAYER_CLASS_TOKEN_MAPPING[playerClass]
                        if classTokenTypes then
                            for _, validType in ipairs(classTokenTypes) do
                                print("  检查", tokenType, "vs", validType, ":", tokenType == validType)
                            end
                        else
                            print("  错误: 未找到职业", playerClass, "的代币类型映射")
                        end
                    else
                        print("GetTokenTypeFromID错误:", success2 and "无结果" or tostring(tokenType))
                    end
                    
                    print("IsTokenForCurrentClass结果:", IsTokenForCurrentClass(itemLink, itemID))
                    local startTime, duration = GetItemCooldown(itemID)
                    print("冷却状态:", startTime and startTime > 0 and "冷却中" or "无冷却")
                    
                    -- 检查背包空间
                    local freeSlots = 0
                    for checkBagID = 0, NUM_BAG_SLOTS do
                        local numSlots = C_Container.GetContainerNumSlots(checkBagID)
                        for checkSlotID = 1, numSlots do
                            local checkItemID = C_Container.GetContainerItemID(checkBagID, checkSlotID)
                            if not checkItemID then
                                freeSlots = freeSlots + 1
                            end
                        end
                    end
                    print("空闲背包位:", freeSlots)
                    print("CanUseToken结果:", CanUseToken(itemLink, itemID))
                    return
                end
            end
        end
        print("背包中未找到该物品")
    
    elseif command == "bagcheck" or command == "背包检查" then
        -- 新增：全面检查背包中的所有物品
        print("=== 背包物品全面检查 ===")
        local totalItems = 0
        local unknownTokens = 0
        
        for bagID = 0, NUM_BAG_SLOTS do
            local numSlots = C_Container.GetContainerNumSlots(bagID)
            print("检查背包", bagID, "槽位数:", numSlots)
            
            for slotID = 1, numSlots do
                local itemID = C_Container.GetContainerItemID(bagID, slotID)
                local itemLink = C_Container.GetContainerItemLink(bagID, slotID)
                
                if itemID and itemLink then
                    totalItems = totalItems + 1
                    local itemName = select(1, GetItemInfo(itemID))
                    
                    -- 检查是否是代币相关物品（通过名称关键词）
                    if itemName and (
                        itemName:find("代币") or itemName:find("Token") or 
                        itemName:find("精华") or itemName:find("Essence") or
                        itemName:find("征服者") or itemName:find("Conqueror") or
                        itemName:find("防护者") or itemName:find("Protector") or
                        itemName:find("破坏者") or itemName:find("Vanquisher") or
                        itemName:find("碾压者") or itemName:find("Cursed") or
                        itemName:find("受诅") or itemName:find("Helm of") or
                        itemName:find("Crown of") or itemName:find("头盔")
                    ) then
                        print(string.format("  疑似代币: %s (ID:%s)", itemLink, itemID))
                        print(string.format("    TIER_SET_ITEMS中: %s", TIER_SET_ITEMS[itemID] and "存在" or "不存在"))
                        if not TIER_SET_ITEMS[itemID] then
                            unknownTokens = unknownTokens + 1
                        end
                    end
                end
            end
        end
        
        print("总物品数:", totalItems)
        print("未识别的疑似代币数:", unknownTokens)
        
    elseif command == "checkusable" or command == "检查可用性" then
        -- 新增：详细检查代币可用性原因
        print("=== 代币可用性详细检查 ===")
        local _, playerClass = UnitClass("player")
        print("当前职业:", playerClass)
        
        for bagID = 0, NUM_BAG_SLOTS do
            local numSlots = C_Container.GetContainerNumSlots(bagID)
            for slotID = 1, numSlots do
                local itemID = C_Container.GetContainerItemID(bagID, slotID)
                local itemLink = C_Container.GetContainerItemLink(bagID, slotID)
                
                if itemID and TIER_SET_ITEMS[itemID] then
                    local itemName = select(1, GetItemInfo(itemID))
                    local displayLink = itemLink
                    if not displayLink or displayLink == "" or displayLink == "[]" then
                        if itemName then
                            displayLink = string.format("|cffffffff|Hitem:%d:0:0:0:0:0:0:0:0:0:0:0:0|h[%s]|h|r", itemID, itemName)
                        else
                            displayLink = "物品ID:" .. itemID
                        end
                    end
                    
                    print(string.format("\n代币: %s (ID:%s)", displayLink, itemID))
                    
                    -- 逐一检查每个条件
                    print("  ✅ 是已知代币")
                    
                    if IsTokenForCurrentClass(itemLink, itemID) then
                        print("  ✅ 本职业代币")
                        
                        local startTime, duration = GetItemCooldown(itemID)
                        if not (startTime and startTime > 0) then
                            print("  ✅ 无冷却")
                            
                            -- 检查背包空间
                            local freeSlots = 0
                            for checkBagID = 0, NUM_BAG_SLOTS do
                                local numSlots = C_Container.GetContainerNumSlots(checkBagID)
                                for checkSlotID = 1, numSlots do
                                    local checkItemID = C_Container.GetContainerItemID(checkBagID, checkSlotID)
                                    if not checkItemID then
                                        freeSlots = freeSlots + 1
                                    end
                                end
                            end
                            
                            if freeSlots >= 1 then
                                print("  ✅ 背包空间充足 (空闲位置: " .. freeSlots .. ")")
                                
                                -- 检查是否可以直接使用
                                local canDirectUse = true
                                if itemName then
                                    if itemName:find("精华") or itemName:find("Essence") then
                                        print("  ❌ 精华类代币，需要在NPC处使用")
                                        canDirectUse = false
                                    else
                                        local restrictedKeywords = {
                                            "兑换", "Exchange", "Token", "代币", 
                                            "印记", "Mark", "徽记", "Badge"
                                        }
                                        
                                        local hasRestricted = false
                                        for _, keyword in ipairs(restrictedKeywords) do
                                            if itemName:find(keyword) then
                                                hasRestricted = true
                                                break
                                            end
                                        end
                                        
                                        if hasRestricted then
                                            local usableKeywords = {
                                                "头盔", "Helm", "护肩", "Shoulder", "胸甲", "Chest",
                                                "护腿", "Legging", "护手", "Gauntlet", "冠冕", "Crown"
                                            }
                                            
                                            local hasUsableKeyword = false
                                            for _, usableKeyword in ipairs(usableKeywords) do
                                                if itemName:find(usableKeyword) then
                                                    hasUsableKeyword = true
                                                    break
                                                end
                                            end
                                            
                                            if not hasUsableKeyword then
                                                print("  ❌ 此代币需要特定条件才能使用")
                                                canDirectUse = false
                                            end
                                        end
                                    end
                                end
                                
                                if canDirectUse then
                                    print("  ✅ 可以直接使用")
                                    print("  🎯 结论: 此代币可以自动使用")
                                else
                                    print("  🎯 结论: 此代币不能自动使用")
                                end
                            else
                                print("  ❌ 背包空间不足 (空闲位置: " .. freeSlots .. ")")
                            end
                        else
                            print("  ❌ 代币冷却中")
                        end
                    else
                        print("  ❌ 非本职业代币")
                    end
                end
            end
        end
        
    elseif command == "debugauto" or command == "调试自动使用" then
        print("=== 自动使用代币调试 ===")
        print("AUTO_USE_TOKEN_ENABLED:", AUTO_USE_TOKEN_ENABLED)
        print("AutoSellLowLevelGearDB.autoUseToken:", AutoSellLowLevelGearDB and AutoSellLowLevelGearDB.autoUseToken)
        
        -- 显示当前职业信息
        local playerName, playerClass = UnitClass("player")
        print("当前职业:", playerName, "(" .. playerClass .. ")")
        
        -- 显示职业代币映射
        if PLAYER_CLASS_TOKEN_MAPPING[playerClass] then
            print("本职业适用代币类型:", table.concat(PLAYER_CLASS_TOKEN_MAPPING[playerClass], ", "))
        else
            print("警告: 找不到职业", playerClass, "的代币映射!")
        end
        
        print("\n测试特定代币 ID 99723:")
        local testID = 99723
        local testItemName = select(1, GetItemInfo(testID))
        print("物品名称:", testItemName)
        print("是否为Vanquisher代币:", IsTokenForCurrentClass(nil, testID))
        print("是否可直接使用:", IsTokenDirectlyUsable(testID))
        
        print("\n手动执行 ScanBagForUsableTokens...")
        ScanBagForUsableTokens()
        
    elseif command == "bl" or command == "黑名单" then
        local subCommand = args[2] or ""
        if subCommand == "add" or subCommand == "添加" then
            local itemID = tonumber(args[3])
            if itemID then
                local itemName, itemLink = GetItemInfo(itemID)
                if itemName then
                    AddToBlacklist(nil, itemLink)
                    print("已将物品", itemLink, "添加到黑名单")
                else
                    print("错误：找不到物品ID", itemID, "的信息")
                end
            else
                print("用法: /as bl add <物品ID>")
            end
        elseif subCommand == "remove" or subCommand == "移除" then
            local itemID = tonumber(args[3])
            if itemID then
                local itemName, itemLink = GetItemInfo(itemID)
                if itemName then
                    RemoveFromBlacklist(itemLink)
                    print("已将物品", itemLink, "从黑名单移除")
                else
                    print("错误：找不到物品ID", itemID, "的信息")
                end
            else
                print("用法: /as bl remove <物品ID>")
            end
        elseif subCommand == "list" or subCommand == "列表" then
            print("=== 黑名单物品列表 ===")
            local count = 0
            for itemLink, _ in pairs(BLACKLIST) do
                count = count + 1
                print(count .. ". " .. itemLink)
            end
            if count == 0 then
                print("黑名单为空")
            else
                print("总计:", count, "个物品")
            end
        elseif subCommand == "clear" or subCommand == "清空" then
            for k in pairs(BLACKLIST) do
                BLACKLIST[k] = nil
            end
            for k in pairs(BLACKLIST_NAMES) do
                BLACKLIST_NAMES[k] = nil
            end
            local selectedChar = GetSelectedCharacter()
            SaveBlacklist(selectedChar)
            print("已清空黑名单")
            TryRefreshTypeManagerBlacklist()
        else
            ShowTypeManagerPopup()
        end
        
    elseif command == "debug" or command == "调试" then
        print("=== 黑名单调试信息 ===")
        print("当前角色:", GetCurrentCharacterKey())
        print("选择角色:", GetSelectedCharacter())
        print("BLACKLIST表大小:", GetTableSize(BLACKLIST))
        print("BLACKLIST_NAMES表大小:", GetTableSize(BLACKLIST_NAMES))
        
        if AutoSellLowLevelGearDB and AutoSellLowLevelGearDB.characters then
            local currentChar = GetCurrentCharacterKey()
            if AutoSellLowLevelGearDB.characters[currentChar] and AutoSellLowLevelGearDB.characters[currentChar].blacklist then
                local savedCount = GetTableSize(AutoSellLowLevelGearDB.characters[currentChar].blacklist)
                print("数据库中保存的黑名单数量:", savedCount)
            else
                print("数据库中没有找到当前角色的黑名单")
            end
        else
            print("AutoSellLowLevelGearDB不存在")
        end
        
        print("前5个黑名单物品:")
        local count = 0
        for itemLink, _ in pairs(BLACKLIST) do
            count = count + 1
            print(count .. ".", itemLink)
            if count >= 5 then break end
        end
        
    elseif command == "tokendetect" or command == "代币检测" then
        print("=== 新代币识别系统详细调试 ===")
        print("当前使用:", USE_NEW_TOKEN_SYSTEM and "新系统" or "原系统")
        print("玩家职业:", select(2, UnitClass("player")))
        print("游戏版本:", GetPlayerExpansion())
        print("---")
        
        -- 扫描所有背包 - 只显示杂项类型物品
        local allItemCount = 0
        local miscItemCount = 0
        local recognizedCount = 0
        
        print("=== 背包中杂项物品代币识别测试 ===")
        
        for bag = 0, 4 do
            local numSlots = C_Container.GetContainerNumSlots(bag)
            for slot = 1, numSlots do
                local itemInfo = C_Container.GetContainerItemInfo(bag, slot)
                if itemInfo and itemInfo.itemID then
                    local itemID = itemInfo.itemID
                    local itemName, _, _, _, _, itemType, itemSubType = GetItemInfo(itemID)
                    
                    if itemName then
                        allItemCount = allItemCount + 1
                        
                        -- 只处理杂项类型的物品
                        if itemType == "Miscellaneous" then
                            miscItemCount = miscItemCount + 1
                            
                            print(string.format("杂项物品 %d: [%s] (ID:%d)", miscItemCount, itemName, itemID))
                            print("  子类型:", itemSubType)
                            
                            -- 获取工具提示文本
                            local tooltipText = GetItemTooltipText(itemID)
                            local tooltipPreview = string.sub(tooltipText or "", 1, 80)
                            print("  工具提示:", tooltipPreview .. (string.len(tooltipText or "") > 80 and "..." or ""))
                            
                            -- 新系统代币识别测试
                            print("  === 新系统识别过程 ===")
                            local isRecognized = IsDefinitelyTierToken_New(itemID, itemName, itemType, itemSubType, tooltipText, true)
                            print("  最终结果:", isRecognized and "✓ 是代币" or "✗ 不是代币")
                            
                            -- 原系统对比
                            local oldSystemResult = TIER_SET_ITEMS[itemID] == true
                            print("  原系统:", oldSystemResult and "✓ 是代币" or "✗ 不是代币")
                            
                            if isRecognized then
                                recognizedCount = recognizedCount + 1
                                print("  >>> 这个物品被新系统识别为代币！")
                            end
                            
                            print("  " .. string.rep("-", 50))
                        end
                    end
                end
            end
        end
        
        print("=== 扫描汇总 ===")
        print(string.format("背包总物品数: %d", allItemCount))
        print(string.format("杂项物品数: %d", miscItemCount))
        print(string.format("新系统识别的代币数: %d", recognizedCount))
        
        if miscItemCount == 0 then
            print(">>> 背包中没有发现杂项类型的物品")
            print(">>> 请确认你的代币确实在背包中，可能它们不是'杂项'类型")
        end
        
    elseif command == "mouseitem" or command == "鼠标物品" then
        print("=== 鼠标悬停物品详细信息 ===")
        
        -- 获取鼠标悬停的物品信息
        local _, itemLink = GameTooltip:GetItem()
        
        if itemLink then
            local itemID = GetItemInfoFromHyperlink(itemLink)
            if itemID then
                local itemName, _, _, _, _, itemType, itemSubType = GetItemInfo(itemID)
                
                if itemName then
                    print(string.format("物品: [%s]", itemName))
                    print("物品ID:", itemID)
                    print("物品类型:", itemType or "无")
                    print("物品子类型:", itemSubType or "无")
                    
                    -- 获取完整工具提示
                    local tooltipText = GetItemTooltipText(itemID)
                    print("工具提示内容:")
                    print("---开始---")
                    print(tooltipText or "无工具提示")
                    print("---结束---")
                    
                    -- 版本检测
                    local expansion = GetItemExpansion(itemID)
                    print("推测版本:", expansion)
                    
                    -- 代币识别测试
                    print("")
                    print("=== 代币识别测试 ===")
                    local isNewSystemToken = IsDefinitelyTierToken_New(itemID, itemName, itemType, itemSubType, tooltipText, true)
                    print("新系统识别:", isNewSystemToken and "✓ 是代币" or "✗ 不是代币")
                    
                    local isOldSystemToken = TIER_SET_ITEMS[itemID] == true
                    print("原系统识别:", isOldSystemToken and "✓ 是代币" or "✗ 不是代币")
                    
                    if isNewSystemToken then
                        local forCurrentClass = IsTokenForCurrentClass_New(itemID, itemName, tooltipText)
                        print("职业匹配:", forCurrentClass and "✓ 适用当前职业" or "✗ 不适用当前职业")
                    end
                else
                    print("无法获取物品信息")
                end
            else
                print("无法从物品链接获取ID")
            end
        else
            print("请将鼠标悬停在一个物品上，然后运行此命令")
            print("使用方法:")
            print("1. 将鼠标悬停在背包中的代币上")
            print("2. 保持鼠标不动，输入: /as mouseitem")
        end
        
    elseif command == "whitelist" or command == "wl" or command == "白名单" then
        print("=== 白名单调试信息 ===")
        print("当前白名单物品数量:", GetTableSize(WHITELIST))
        print("内存中的白名单内容（前5个）：")
        local count = 0
        for itemLink, value in pairs(WHITELIST) do
            count = count + 1
            if count <= 5 then
                local itemName = WHITELIST_NAMES[itemLink] or "未知"
                print(string.format("  [%s] = %s (名称: %s)", tostring(itemLink), tostring(value), itemName))
            end
        end
        if count > 5 then
            print("  ... 还有", count - 5, "个物品")
        end
    elseif command == "dbcheck" or command == "数据库检查" then
        -- 调试命令：检查数据库状态
        local currentChar = GetCurrentCharacterKey()
        print("=== 数据库状态检查 ===")
        print("当前角色:", currentChar)
        print("内存中的blacklistMode:", blacklistMode)
        print("内存中的whitelistMode:", whitelistMode)
        
        if AutoSellLowLevelGearDB.characters[currentChar] then
            print("数据库中的blacklistMode:", AutoSellLowLevelGearDB.characters[currentChar].blacklistMode)
            print("数据库中的whitelistMode:", AutoSellLowLevelGearDB.characters[currentChar].whitelistMode)
        else
            print("数据库中没有当前角色的设置")
        end
        
        local globalBlacklist = GetGlobalBlacklist()
        local globalWhitelist = GetGlobalWhitelist()
        print("全局黑名单数量:", GetTableSize(globalBlacklist))
        print("全局白名单数量:", GetTableSize(globalWhitelist))
        print("内存黑名单数量:", GetTableSize(BLACKLIST))
        print("内存白名单数量:", GetTableSize(WHITELIST))
        
        if GetTableSize(globalBlacklist) > 0 then
            print("全局黑名单内容:")
            for k, v in pairs(globalBlacklist) do
                local itemName = select(1, GetItemInfo(k)) or k:match("|h%[(.-)%]|h") or k
                print("  -", itemName)
            end
        end
        
        if GetTableSize(globalWhitelist) > 0 then
            print("全局白名单内容:")
            for k, v in pairs(globalWhitelist) do
                local itemName = select(1, GetItemInfo(k)) or k:match("|h%[(.-)%]|h") or k
                print("  -", itemName)
            end
        end
        
    elseif command == "forceload" or command == "强制加载" then
        -- 强制重新加载全局数据到内存
        print("=== 强制重新加载全局数据 ===")
        
        -- 清空内存
        for k in pairs(BLACKLIST) do BLACKLIST[k] = nil end
        for k in pairs(BLACKLIST_NAMES) do BLACKLIST_NAMES[k] = nil end
        for k in pairs(WHITELIST) do WHITELIST[k] = nil end
        for k in pairs(WHITELIST_NAMES) do WHITELIST_NAMES[k] = nil end
        print("已清空内存中的黑白名单")
        
        -- 如果当前是通用模式，重新加载全局数据
        if blacklistMode == "global" then
            local globalBlacklist = GetGlobalBlacklist()
            print("正在加载全局黑名单，数据库中有", GetTableSize(globalBlacklist), "个物品")
            for key, value in pairs(globalBlacklist) do
                BLACKLIST[key] = true
                local itemName = select(1, GetItemInfo(key))
                if not itemName and key:find("|H") then
                    itemName = key:match("|h%[(.-)%]|h") or key
                end
                BLACKLIST_NAMES[key] = itemName or key
                print("已加载黑名单物品:", itemName)
            end
        end
        
        if whitelistMode == "global" then
            local globalWhitelist = GetGlobalWhitelist()
            print("正在加载全局白名单，数据库中有", GetTableSize(globalWhitelist), "个物品")
            for key, value in pairs(globalWhitelist) do
                WHITELIST[key] = true
                local itemName = select(1, GetItemInfo(key))
                if not itemName and key:find("|H") then
                    itemName = key:match("|h%[(.-)%]|h") or key
                end
                WHITELIST_NAMES[key] = itemName or key
                print("已加载白名单物品:", itemName)
            end
        end
        
        print("强制加载完成！内存中现有:")
        print("黑名单数量:", GetTableSize(BLACKLIST))
        print("白名单数量:", GetTableSize(WHITELIST))
        
        -- 刷新界面显示
        if typeManagerFrame and typeManagerFrame:IsShown() then
            RefreshTypeManagerBlacklist()
            RefreshTypeManagerWhitelist()
        end
        
    elseif command == "whitelistfix" or command == "wlfix" or command == "白名单修复" then
        print("=== 白名单调试信息 ===")
        print("当前角色:", GetCurrentCharacterKey())
        print("WHITELIST表大小:", GetTableSize(WHITELIST))
        print("WHITELIST_NAMES表大小:", GetTableSize(WHITELIST_NAMES))
        
        if AutoSellLowLevelGearDB and AutoSellLowLevelGearDB.characters then
            local currentChar = GetCurrentCharacterKey()
            if AutoSellLowLevelGearDB.characters[currentChar] and AutoSellLowLevelGearDB.characters[currentChar].whitelist then
                local savedCount = GetTableSize(AutoSellLowLevelGearDB.characters[currentChar].whitelist)
                print("数据库中保存的白名单数量:", savedCount)
            else
                print("数据库中没有找到当前角色的白名单")
            end
        else
            print("AutoSellLowLevelGearDB不存在")
        end
        
        print("前10个白名单物品:")
        local count = 0
        for itemLink, _ in pairs(WHITELIST) do
            if count >= 10 then break end
            count = count + 1
            local itemName = WHITELIST_NAMES[itemLink] or "未知物品"
            print(string.format("  %d. %s - %s", count, itemName, itemLink))
        end
        if count == 0 then
            print("  白名单为空")
        end
        
    elseif command == "testwl" or command == "测试白名单" then
        print("=== 测试白名单物品的售卖逻辑 ===")
        print("检查内存中的白名单物品...")
        
        local foundWhitelistItems = false
        for itemLink, _ in pairs(WHITELIST) do
            foundWhitelistItems = true
            local itemID = GetItemInfoFromHyperlink(itemLink)
            if itemID then
                print("")
                print("白名单物品:", itemLink)
                
                -- 测试售卖逻辑
                local shouldSell = ShouldSellItem(itemID, itemLink)
                print("  ShouldSellItem结果:", shouldSell and "✓ 应该售卖" or "✗ 不应售卖")
                
                -- 检查基本信息
                local itemName, _, itemRarity, itemLevel, _, itemType, itemSubType, _, equipLoc = GetItemInfo(itemID)
                local sellPrice = select(11, GetItemInfo(itemID))
                local bindType = select(14, GetItemInfo(itemID))
                local itemClassID, itemSubClassID = select(12, GetItemInfo(itemID)), select(13, GetItemInfo(itemID))
                
                print("  物品信息:")
                print("    物品ID:", itemID)
                print("    物品名称:", itemName or "未知")
                print("    物品等级:", itemLevel or "未知")
                print("    售价:", sellPrice or "未知")
                print("    绑定类型:", bindType or "未知", "(1=拾取绑定,2=装备绑定,3=账号绑定)")
                print("    装备位置:", equipLoc or "未知")
                print("    物品类型:", itemType or "未知", "/", itemSubType or "未知")
                print("    类型ID:", itemClassID or "未知", "/", itemSubClassID or "未知")
                print("    稀有度:", itemRarity or "未知")
                
                if not shouldSell then
                    print("  ⚠️ 警告：这个白名单物品不会被售卖！")
                    print("  检查上面的调试信息，看看具体原因")
                end
            else
                print("无法获取物品ID:", itemLink)
            end
        end
        
        if not foundWhitelistItems then
            print("白名单为空")
            print("请先使用界面将一些物品添加到白名单，然后重新测试")
        end
        
    elseif command == "scantest" or command == "扫描测试" then
        print("=== 测试背包扫描和售卖列表 ===")
        print("正在扫描背包...")
        
        local itemsToSell = ScanBagForLowLevelGear(0, false) -- 非静默扫描
        
        print("扫描完成，找到", #itemsToSell, "件可售卖物品")
        
        if #itemsToSell > 0 then
            print("售卖列表:")
            for i, item in ipairs(itemsToSell) do
                print(string.format("  %d. %s (背包%d槽位%d)", i, item.itemLink, item.bagID, item.slotID))
                
                -- 检查是否在白名单中
                if IsInWhitelist(item.itemLink) then
                    print("    ✓ 这是白名单物品")
                else
                    print("    - 这不是白名单物品")
                end
            end
        else
            print("没有找到可售卖物品")
            print("可能的原因:")
            print("  1. 没有满足条件的装备")
            print("  2. 白名单物品没有被正确识别")
            print("  3. 其他逻辑阻止了物品售卖")
        end
        
    elseif command == "bagdebug" or command == "背包调试" then
        print("=== 详细背包扫描调试 ===")
        print("正在检查所有背包槽位...")
        
        local foundWhitelistItems = false
        local totalItems = 0
        
        for bagID = 0, 12 do -- 扩大扫描范围，包括专业背包
            local numSlots = C_Container.GetContainerNumSlots(bagID)
            if numSlots > 0 then
                print(string.format("背包%d: %d个槽位", bagID, numSlots))
            end
            
            for slotID = 1, numSlots do
                local itemID = C_Container.GetContainerItemID(bagID, slotID)
                local itemLink = C_Container.GetContainerItemLink(bagID, slotID)
                
                if itemID and itemLink then
                    totalItems = totalItems + 1
                    
                    -- 检查是否在白名单中
                    if IsInWhitelist(itemLink) then
                        foundWhitelistItems = true
                        print(string.format("  找到白名单物品: %s (背包%d槽位%d)", itemLink, bagID, slotID))
                        
                        -- 测试ShouldSellItem
                        local shouldSell = ShouldSellItem(itemID, itemLink)
                        print(string.format("    ShouldSellItem结果: %s", shouldSell and "✓ 应该售卖" or "✗ 不应售卖"))
                        
                        -- 检查物品信息
                        local itemName, _, itemRarity, itemLevel, _, itemType, itemSubType = GetItemInfo(itemID)
                        local sellPrice = select(11, GetItemInfo(itemID))
                        print(string.format("    物品信息: ID=%s, 名称=%s, 售价=%s", itemID, itemName or "未知", sellPrice or "未知"))
                    end
                end
            end
        end
        
        print(string.format("扫描完成，总共找到%d个物品", totalItems))
        if not foundWhitelistItems then
            print("⚠️ 在背包中没有找到任何白名单物品！")
            print("这可能意味着:")
            print("  1. 白名单物品不在背包中")
            print("  2. 白名单物品在其他位置（银行、其他背包等）")
            print("  3. 物品链接格式不匹配")
            
            print("")
            print("让我们比较一下物品链接格式...")
            print("白名单中的物品链接:")
            for itemLink, _ in pairs(WHITELIST) do
                print("  " .. itemLink)
                local itemID = GetItemInfoFromHyperlink(itemLink)
                if itemID then
                    print("    提取的ID: " .. itemID)
                    
                    -- 在背包中寻找相同ID的物品
                    print("    在背包中寻找ID " .. itemID .. " 的物品...")
                    local found = false
                    for bagID = 0, 12 do -- 扩大扫描范围，包括专业背包
                        local numSlots = C_Container.GetContainerNumSlots(bagID)
                        for slotID = 1, numSlots do
                            local bagItemID = C_Container.GetContainerItemID(bagID, slotID)
                            local bagItemLink = C_Container.GetContainerItemLink(bagID, slotID)
                            
                            if bagItemID == itemID then
                                found = true
                                print(string.format("    找到相同ID物品: %s (背包%d槽位%d)", bagItemLink, bagID, slotID))
                                print("    链接是否完全匹配: " .. (itemLink == bagItemLink and "是" or "否"))
                                if itemLink ~= bagItemLink then
                                    print("    白名单链接: " .. itemLink)
                                    print("    背包中链接: " .. bagItemLink)
                                end
                            end
                        end
                    end
                    if not found then
                        print("    在背包中没有找到ID " .. itemID .. " 的物品")
                    end
                end
            end
        end
        
    else
        ShowTypeManagerPopup()
    end
end

-- 插件初始化
local function InitializeAddon()
    -- 数据迁移：从旧的globalBlacklist/globalWhitelist迁移到新的universalBlacklist/universalWhitelist
    if AutoSellLowLevelGearDB then
        if AutoSellLowLevelGearDB.globalBlacklist and not AutoSellLowLevelGearDB.universalBlacklist then
            AutoSellLowLevelGearDB.universalBlacklist = AutoSellLowLevelGearDB.globalBlacklist
            print("|cff88aaff[AutoSell]|r 已迁移黑名单数据到跨服存储")
        end
        if AutoSellLowLevelGearDB.globalWhitelist and not AutoSellLowLevelGearDB.universalWhitelist then
            AutoSellLowLevelGearDB.universalWhitelist = AutoSellLowLevelGearDB.globalWhitelist
            print("|cff88aaff[AutoSell]|r 已迁移白名单数据到跨服存储")
        end
    end
    
    LoadBlacklist(GetCurrentCharacterKey())
    LoadWhitelist(GetCurrentCharacterKey())
    
    -- 获取当前游戏版本信息
    local gameVersion = GetPlayerExpansion()
    local serverName = GetRealmName()
    local playerName = UnitName("player")
    local playerClass = UnitClass("player")
    
    print("|cff00ff00=== AutoSellLowLevelGear v2.4 插件已加载 ===|r")
    print("|cffffff00角色信息:|r " .. playerName .. "-" .. serverName .. " (" .. playerClass .. ")")
    print("|cffffff00游戏版本:|r " .. (gameVersion or "未知"))
    print("|cffffff00当前物品等级阈值:|r |cff00ff00" .. GetCurrentItemLevelThreshold() .. "|r")
    print("|cffffff00黑名单物品数量:|r |cffff6666" .. GetTableSize(BLACKLIST) .. "|r")
    print("|cffffff00白名单物品数量:|r |cff66ff66" .. GetTableSize(WHITELIST) .. "|r")
    print("|cffffff00代币识别系统:|r " .. (USE_NEW_TOKEN_SYSTEM and "|cff00ff00新系统(智能)|r" or "|cffff9900旧系统(固定)|r"))
    if AutoSellLowLevelGearDB.autoUseToken then
        print("|cffffff00自动使用代币:|r |cff00ff00已启用|r")
    end
    print("|cff88aaff更新内容:|r 完善下拉框滚轮支持，修复游戏滚轮冲突")
    print("|cff88aaff帮助命令:|r 输入 |cffffffff/as help|r 查看完整帮助")
end

-- 延迟初始化，确保游戏完全加载
--C_Timer.After(1, InitializeAddon) 
--print("|cff88aaff[AutoSell]|r 正在初始化插件...") 


 

-- 先定义LoadBlacklist，确保后续所有调用点都能用
function LoadBlacklist(charKey)
    charKey = charKey or GetCurrentCharacterKey()
    local savedBlacklist = GetCharacterBlacklist(charKey)
    
    -- 只有在角色独立模式下才修改全局的BLACKLIST变量
    -- 在通用模式下，不应该用角色数据覆盖全局数据
    if blacklistMode == "character" then
        print("DEBUG: LoadBlacklist在角色独立模式下加载角色", charKey, "的黑名单")
        -- 清空当前黑名单
        for k in pairs(BLACKLIST) do
            BLACKLIST[k] = nil
        end
        for k in pairs(BLACKLIST_NAMES) do
            BLACKLIST_NAMES[k] = nil
        end
        
        -- 加载保存的黑名单
        for key, value in pairs(savedBlacklist) do
            BLACKLIST[key] = true  -- 确保值始终是true
            BLACKLIST_NAMES[key] = type(value) == "string" and value or select(1, GetItemInfo(key)) or key
        end
        
        print("已加载黑名单，共", GetTableSize(BLACKLIST), "个物品")
    else
        print("DEBUG: LoadBlacklist在通用模式下被调用，跳过修改全局BLACKLIST，避免数据污染")
        print("DEBUG: 角色", charKey, "的独立黑名单有", GetTableSize(savedBlacklist), "个物品，但不会加载到内存")
    end
end

-- 加载白名单数据
function LoadWhitelist(charKey)
    charKey = charKey or GetCurrentCharacterKey()
    local savedWhitelist = GetCharacterWhitelist(charKey)
    
    -- 只有在角色独立模式下才修改全局的WHITELIST变量
    -- 在通用模式下，不应该用角色数据覆盖全局数据
    if whitelistMode == "character" then
        -- 清空当前白名单
        for k in pairs(WHITELIST) do
            WHITELIST[k] = nil
        end
        for k in pairs(WHITELIST_NAMES) do
            WHITELIST_NAMES[k] = nil
        end
        
        -- 加载保存的白名单
        for key, value in pairs(savedWhitelist) do
            WHITELIST[key] = true  -- 确保值始终是true
            WHITELIST_NAMES[key] = type(value) == "string" and value or select(1, GetItemInfo(key)) or key
        end
        
        print("已加载白名单，共", GetTableSize(WHITELIST), "个物品")
    end
end

-- 更新黑名单和白名单计数显示
function UpdateListCounts()
    if typeManagerFrame and typeManagerFrame.blCount then
        typeManagerFrame.blCount:SetText("共" .. GetTableSize(BLACKLIST) .. "个")
    end
    if typeManagerFrame and typeManagerFrame.wlCount then
        typeManagerFrame.wlCount:SetText("共" .. GetTableSize(WHITELIST) .. "个")
    end
end

-- 定义RefreshTypeManagerBlacklist函数，用于刷新黑名单列表显示
function RefreshTypeManagerBlacklist()
    if not typeManagerFrame or not typeManagerFrame.scrollChild then return end
    local selectedChar = GetSelectedCharacter()
    
    -- 确保显示选择角色的黑名单
    local currentChar = GetCurrentCharacterKey()
    if selectedChar ~= currentChar then
        -- 显示其他角色的黑名单（从数据库加载，不影响当前角色的内存数据）
        -- 显示其他角色的黑名单（从数据库加载，不影响当前角色的内存数据）
    else
    end
    
    local blScrollChild = typeManagerFrame.scrollChild
    local BL_ROW_HEIGHT = 22
    for _, child in ipairs(blScrollChild.rows or {}) do
        child:Hide()
        child:SetParent(nil)
    end
    blScrollChild.rows = {}
    local y = 0
    local totalRows = 0
    
    -- 根据当前模式和选择的角色获取要显示的黑名单
    local displayBlacklist
    if blacklistMode == "global" then
        -- 通用模式：总是显示内存中的全局黑名单，忽略角色选择
        displayBlacklist = BLACKLIST
    elseif selectedChar == currentChar then
        -- 角色模式+当前角色：使用内存中的黑名单（包含刚添加的物品）
        displayBlacklist = BLACKLIST
    else
        -- 角色模式+其他角色：从数据库获取黑名单（不影响当前角色的内存数据）
        displayBlacklist = GetCharacterBlacklist(selectedChar)
    end
    
    for itemLink, _ in pairs(displayBlacklist) do
        local itemLevel = GetDetailedItemLevelInfo(itemLink) or select(4, GetItemInfo(itemLink)) or "?"
        local rowFrame = CreateFrame("Frame", nil, blScrollChild)
        rowFrame:SetSize(400, BL_ROW_HEIGHT)
        rowFrame:SetPoint("TOP", blScrollChild, "TOP", 0, -y)
        -- container整体右移
        local container = CreateFrame("Frame", nil, rowFrame)
        container:SetSize(320, BL_ROW_HEIGHT)
        container:SetPoint("LEFT", rowFrame, "LEFT", 40, 0)
        local removeBtn = CreateFrame("Button", nil, container, "UIPanelButtonTemplate")
        removeBtn:SetSize(48, 18)
        removeBtn:SetPoint("LEFT", container, "LEFT", 0, 0)
        removeBtn:SetText("移除")
        -- 加入魔兽自带小X图标
        if not removeBtn.icon then
            local icon = removeBtn:CreateTexture(nil, "ARTWORK")
            icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
            icon:SetSize(14,14)
            icon:SetPoint("LEFT", removeBtn, "LEFT", 2, 0)
            removeBtn.icon = icon
            removeBtn:SetText("  移除")
        end
        removeBtn:SetScript("OnClick", function()
            RemoveFromBlacklist(itemLink)
        end)
        local linkFS = container:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        linkFS:SetPoint("LEFT", removeBtn, "RIGHT", 8, 0)
        linkFS:SetText(itemLink)
        linkFS:SetJustifyH("LEFT")
        linkFS:SetWidth(180)
        linkFS:SetHeight(18)
        linkFS:EnableMouse(true)
        linkFS:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR_BOTTOM")
            GameTooltip:SetHyperlink(itemLink)
            GameTooltip:Show()
        end)
        linkFS:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
        local levelFS = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        levelFS:SetPoint("LEFT", linkFS, "RIGHT", 6, 0)
        levelFS:SetText("["..itemLevel.."]")
        levelFS:SetJustifyH("LEFT")
        levelFS:SetWidth(50)
        levelFS:SetHeight(18)
        table.insert(blScrollChild.rows, rowFrame)
        y = y + BL_ROW_HEIGHT
        totalRows = totalRows + 1
    end
    -- 使用动态高度，如果没有设置则使用默认值
    local currentScrollHeight = BL_SCROLL_HEIGHT
    if typeManagerFrame.scrollFrame then
        currentScrollHeight = typeManagerFrame.scrollFrame:GetHeight() or BL_SCROLL_HEIGHT
    end
    blScrollChild:SetHeight(math.max(currentScrollHeight, totalRows * BL_ROW_HEIGHT + 12))
    
    -- 更新黑名单计数显示
    UpdateListCounts()
end

-- 定义RefreshTypeManagerWhitelist函数，用于刷新白名单列表显示
function RefreshTypeManagerWhitelist()
    if not typeManagerFrame or not typeManagerFrame.wlScrollChild then return end
    
    -- 获取白名单区域应该显示的角色（使用白名单下拉框）
    local selectedChar = GetCurrentCharacterKey() -- 默认当前角色
    if typeManagerFrame.wlCharSelectDropdown then
        selectedChar = UIDropDownMenu_GetSelectedValue(typeManagerFrame.wlCharSelectDropdown) or GetCurrentCharacterKey()
    end
    
    local currentChar = GetCurrentCharacterKey()
    if selectedChar ~= currentChar then
        -- 显示其他角色的白名单（从数据库加载，不影响当前角色的内存数据）
        -- 显示其他角色的白名单（从数据库加载，不影响当前角色的内存数据）
    else
    end
    
    local wlScrollChild = typeManagerFrame.wlScrollChild
    local WL_ROW_HEIGHT = BL_ROW_HEIGHT -- 与黑名单保持一致
    local WL_SCROLL_HEIGHT = BL_SCROLL_HEIGHT -- 与黑名单保持一致
    for _, child in ipairs(wlScrollChild.rows or {}) do
        child:Hide()
        child:SetParent(nil)
    end
    wlScrollChild.rows = {}
    local y = 0
    local totalRows = 0
    
    -- 根据当前模式和选择的角色获取要显示的白名单
    local displayWhitelist
    if whitelistMode == "global" then
        -- 通用模式：总是显示内存中的全局白名单，忽略角色选择
        displayWhitelist = WHITELIST
    elseif selectedChar == currentChar then
        -- 角色模式+当前角色：使用内存中的白名单（包含刚添加的物品）
        displayWhitelist = WHITELIST
    else
        -- 角色模式+其他角色：从数据库获取白名单（不影响当前角色的内存数据）
        displayWhitelist = GetCharacterWhitelist(selectedChar)
    end
    
    for itemLink, _ in pairs(displayWhitelist) do
        local itemLevel = GetDetailedItemLevelInfo(itemLink) or select(4, GetItemInfo(itemLink)) or "?"
        local rowFrame = CreateFrame("Frame", nil, wlScrollChild)
        rowFrame:SetSize(400, WL_ROW_HEIGHT)
        rowFrame:SetPoint("TOP", wlScrollChild, "TOP", 0, -y)
        -- container整体右移
        local container = CreateFrame("Frame", nil, rowFrame)
        container:SetSize(320, WL_ROW_HEIGHT)
        container:SetPoint("LEFT", rowFrame, "LEFT", 40, 0)
        local removeBtn = CreateFrame("Button", nil, container, "UIPanelButtonTemplate")
        removeBtn:SetSize(48, 18)
        removeBtn:SetPoint("LEFT", container, "LEFT", 0, 0)
        removeBtn:SetText("移除")
        -- 加入绿色勾号图标
        if not removeBtn.icon then
            local icon = removeBtn:CreateTexture(nil, "ARTWORK")
            icon:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
            icon:SetSize(14,14)
            icon:SetPoint("LEFT", removeBtn, "LEFT", 2, 0)
            icon:SetVertexColor(0.5, 1, 0.5) -- 绿色主题
            removeBtn.icon = icon
            removeBtn:SetText("  移除")
        end
        removeBtn:SetScript("OnClick", function()
            RemoveFromWhitelist(itemLink)
        end)
        local linkFS = container:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        linkFS:SetPoint("LEFT", removeBtn, "RIGHT", 8, 0)
        linkFS:SetText(itemLink)
        linkFS:SetJustifyH("LEFT")
        linkFS:SetWidth(180)
        linkFS:SetHeight(18)
        linkFS:SetTextColor(0.5, 1, 0.5) -- 绿色主题
        linkFS:EnableMouse(true)
        linkFS:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR_BOTTOM")
            GameTooltip:SetHyperlink(itemLink)
            GameTooltip:Show()
        end)
        linkFS:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
        local levelFS = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        levelFS:SetPoint("LEFT", linkFS, "RIGHT", 6, 0)
        levelFS:SetText("["..itemLevel.."]")
        levelFS:SetJustifyH("LEFT")
        levelFS:SetWidth(50)
        levelFS:SetHeight(18)
        levelFS:SetTextColor(0.5, 1, 0.5) -- 绿色主题
        table.insert(wlScrollChild.rows, rowFrame)
        y = y + WL_ROW_HEIGHT
        totalRows = totalRows + 1
    end
    -- 使用动态高度，如果没有设置则使用默认值
    local currentScrollHeight = BL_SCROLL_HEIGHT
    if typeManagerFrame.wlScrollFrame then
        currentScrollHeight = typeManagerFrame.wlScrollFrame:GetHeight() or BL_SCROLL_HEIGHT
    end
    wlScrollChild:SetHeight(math.max(currentScrollHeight, totalRows * WL_ROW_HEIGHT + 12))
    
    -- 更新白名单计数显示
    UpdateListCounts()
end

-- 定义makeBlacklistKey函数，用于生成黑名单的唯一key
function makeBlacklistKey(itemLink)
    return itemLink
end

-- 定义SaveBlacklist函数，用于保存黑名单到DB
function SaveBlacklist(charKey)
    charKey = charKey or GetCurrentCharacterKey()
    
    -- 只有在角色独立模式下才保存当前内存中的BLACKLIST
    -- 在通用模式下，BLACKLIST包含的是全局数据，不应该覆盖角色数据
    if blacklistMode == "character" then
        SaveCharacterBlacklist(charKey, BLACKLIST)
        print("黑名单已保存到角色", charKey, "，共", GetTableSize(BLACKLIST), "个物品")
    else
        print("WARNING: 当前在通用模式，跳过保存角色独立黑名单，避免数据覆盖")
    end
    
    -- 调试：验证是否真正保存成功
    if blacklistMode == "global" then
        local savedBlacklist = GetGlobalBlacklist()
    else
        local savedBlacklist = GetCharacterBlacklist(charKey)
    end
end

-- 定义SaveWhitelist函数，用于保存白名单到DB
function SaveWhitelist(charKey)
    charKey = charKey or GetCurrentCharacterKey()
    
    
    -- 只有在角色独立模式下才保存当前内存中的WHITELIST
    -- 在通用模式下，WHITELIST包含的是全局数据，不应该覆盖角色数据
    if whitelistMode == "character" then
        SaveCharacterWhitelist(charKey, WHITELIST)
        print("白名单已保存到角色", charKey, "，共", GetTableSize(WHITELIST), "个物品")
    else
        print("WARNING: 当前在通用模式，跳过保存角色独立白名单，避免数据覆盖")
    end
    
end

-- 定义SellItems函数，用于售卖物品
SellItems = function(itemsToSell, idx)
    idx = idx or 1
    if not itemsToSell or #itemsToSell == 0 or idx > #itemsToSell then
        print("成功售卖了", idx-1, "件装备")
                return
            end
    local item = itemsToSell[idx]
    if C_Container.GetContainerItemID(item.bagID, item.slotID) == item.itemID then
        C_Container.UseContainerItem(item.bagID, item.slotID)
    end
    C_Timer.After(0.15, function()
        SellItems(itemsToSell, idx+1)
                        end)
                    end

-- 工具函数：判断是否为神器圣物
function IsArtifactRelic(itemID)
    local itemType, itemSubType = select(6, GetItemInfo(itemID))
    return itemType == "神器圣物" or itemSubType == "神器圣物"
end

-- 极简风格样式

-- 原始风格样式


-- 售卖弹窗主题应用函数
function ApplySellPopupTheme()
    if not sellPopupFrame then return end
    local currentTheme = AutoSellLowLevelGearDB.themeStyle or "minimalist"
    
    if currentTheme == "minimalist" then
        -- 极简风格
        sellPopupFrame:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = nil,
            tile = true, tileSize = 16, edgeSize = 0,
            insets = {left = 0, right = 0, top = 0, bottom = 0}
        })
        sellPopupFrame:SetBackdropColor(0,0,0,0.9)
        
        -- 显示极简风图标
        if sellPopupFrame.mainIcon then
            sellPopupFrame.mainIcon:Show()
        end
    else
        -- 原始风格
        sellPopupFrame:SetBackdrop({
            bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
            edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
            tile = true, tileSize = 32, edgeSize = 32,
            insets = {left = 11, right = 12, top = 12, bottom = 11}
        })
        sellPopupFrame:SetBackdropColor(1, 1, 1, 1)
        
        -- 隐藏极简风图标
        if sellPopupFrame.mainIcon then
            sellPopupFrame.mainIcon:Hide()
        end
    end
end

-- 在打开窗口时应用主题
hooksecurefunc("ShowTypeManagerPopup", function()
    C_Timer.After(0.1, ApplyThemeStyle)
end)

-- 按键绑定界面的本地化文本
BINDING_HEADER_AUTOSELL_HEADER = "AutoSell 自动售卖插件"
BINDING_NAME_AUTOSELL_TOGGLE_UI = "打开/关闭设置界面"
BINDING_NAME_AUTOSELL_ADD_BLACKLIST = "添加到黑名单"
BINDING_NAME_AUTOSELL_ADD_WHITELIST = "添加到白名单"

-- 为快捷键绑定提供全局函数
function AutoSell_ToggleUI()
    ShowTypeManagerPopup()
end

function AutoSell_AddToBlacklist()
    -- 获取鼠标悬停的物品
    local itemName, itemLink = GameTooltip:GetItem()
    if itemLink then
        AddToBlacklist(nil, itemLink)
    else
        print("|cff88aaff[AutoSell]|r 请将鼠标悬停在物品上，然后按快捷键添加到黑名单")
    end
end

function AutoSell_AddToWhitelist()
    -- 获取鼠标悬停的物品
    local itemName, itemLink = GameTooltip:GetItem()
    if itemLink then
        AddToWhitelist(nil, itemLink)
    else
        print("|cff88aaff[AutoSell]|r 请将鼠标悬停在物品上，然后按快捷键添加到白名单")
    end
end

-- 注册所有需要的事件
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("MERCHANT_SHOW")
frame:RegisterEvent("MERCHANT_CLOSED")
frame:RegisterEvent("BAG_UPDATE")
frame:RegisterEvent("BAG_UPDATE_DELAYED")
frame:RegisterEvent("GROUP_JOINED")
frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "OrzUI" then
        if not AutoSellLowLevelGearDB then AutoSellLowLevelGearDB = {} end
        if not AutoSellLowLevelGearDB.characters then AutoSellLowLevelGearDB.characters = {} end
        if AutoSellLowLevelGearDB.itemLevelThreshold then
            ITEM_LEVEL_THRESHOLD = AutoSellLowLevelGearDB.itemLevelThreshold
        else
            ITEM_LEVEL_THRESHOLD = 400
            AutoSellLowLevelGearDB.itemLevelThreshold = 400
        end
        -- 初始化自动使用代币设置
        if AutoSellLowLevelGearDB.autoUseToken == nil then
            AutoSellLowLevelGearDB.autoUseToken = false -- 默认关闭
        end
        -- 初始化不售卖本职业代币设置
        if AutoSellLowLevelGearDB.dontSellClassTokens == nil then
            AutoSellLowLevelGearDB.dontSellClassTokens = false -- 默认关闭
        end
        -- 初始化不售卖未收藏的装饰品设置
        if AutoSellLowLevelGearDB.dontSellUnlearnedCosmetics == nil then
            AutoSellLowLevelGearDB.dontSellUnlearnedCosmetics = true -- 默认开启，保护未收藏的装饰品
        end
        
        -- 初始化代币识别系统设置
        if AutoSellLowLevelGearDB.useNewTokenSystem == nil then
            AutoSellLowLevelGearDB.useNewTokenSystem = true -- 默认使用新系统
        end
        USE_NEW_TOKEN_SYSTEM = AutoSellLowLevelGearDB.useNewTokenSystem
        -- 初始化模式状态
        -- 从当前角色的设置中加载模式选择
        local charKey = GetCurrentCharacterKey()
        -- 🔧 修复：只在角色数据真的不存在时才创建，避免覆盖现有数据
        if not AutoSellLowLevelGearDB.characters then
            AutoSellLowLevelGearDB.characters = {}
        end
        if not AutoSellLowLevelGearDB.characters[charKey] then
            print("创建新角色数据结构：", charKey)
            -- 🔧 关键修复：不要创建空结构，让后续代码按需创建字段
            AutoSellLowLevelGearDB.characters[charKey] = {
                -- 只初始化必要的字段，不要创建空的whitelist/blacklist
            }
        else
            print("角色:", charKey, "白名单物品数=", GetTableSize(AutoSellLowLevelGearDB.characters[charKey].whitelist or {}))
        end
        
        -- 迁移旧的全局设置到当前角色（兼容性处理）
        if AutoSellLowLevelGearDB.blacklistMode ~= nil and AutoSellLowLevelGearDB.characters[charKey].blacklistMode == nil then
            AutoSellLowLevelGearDB.characters[charKey].blacklistMode = AutoSellLowLevelGearDB.blacklistMode
        end
        if AutoSellLowLevelGearDB.whitelistMode ~= nil and AutoSellLowLevelGearDB.characters[charKey].whitelistMode == nil then
            AutoSellLowLevelGearDB.characters[charKey].whitelistMode = AutoSellLowLevelGearDB.whitelistMode
        end
        
        -- 设置默认值（只在真正的新角色时设置，避免覆盖现有设置）
        if AutoSellLowLevelGearDB.characters[charKey].blacklistMode == nil then
            AutoSellLowLevelGearDB.characters[charKey].blacklistMode = "global" -- 默认跨服通用模式
        end
        if AutoSellLowLevelGearDB.characters[charKey].whitelistMode == nil then
            AutoSellLowLevelGearDB.characters[charKey].whitelistMode = "global" -- 默认跨服通用模式
        end
        
        -- 🔧 关键修复：记录角色是否有独立数据，如果有则优先使用独立模式
        local hasIndependentWhitelist = AutoSellLowLevelGearDB.characters[charKey].whitelist and GetTableSize(AutoSellLowLevelGearDB.characters[charKey].whitelist) > 0
        local hasIndependentBlacklist = AutoSellLowLevelGearDB.characters[charKey].blacklist and GetTableSize(AutoSellLowLevelGearDB.characters[charKey].blacklist) > 0
        
        if hasIndependentWhitelist and AutoSellLowLevelGearDB.characters[charKey].whitelistMode == "global" then
            AutoSellLowLevelGearDB.characters[charKey].whitelistMode = "character"
        end
        
        if hasIndependentBlacklist and AutoSellLowLevelGearDB.characters[charKey].blacklistMode == "global" then
            AutoSellLowLevelGearDB.characters[charKey].blacklistMode = "character"
        end
        
        -- 保存当前角色的职业信息（确保下拉框中显示职业颜色）
        local _, class = UnitClass("player")
        if class then
            AutoSellLowLevelGearDB.characters[charKey].class = class
        end
        
        -- 清理旧的全局设置（只在第一次迁移后清理）
        if AutoSellLowLevelGearDB.blacklistMode ~= nil then
            AutoSellLowLevelGearDB.blacklistMode = nil
        end
        if AutoSellLowLevelGearDB.whitelistMode ~= nil then
            AutoSellLowLevelGearDB.whitelistMode = nil
        end
        
        blacklistMode = AutoSellLowLevelGearDB.characters[charKey].blacklistMode
        whitelistMode = AutoSellLowLevelGearDB.characters[charKey].whitelistMode
        
        
        -- 根据当前模式加载对应的黑白名单
        if blacklistMode == "global" then
            local globalBlacklist = GetGlobalBlacklist()
            for key, value in pairs(globalBlacklist) do
                BLACKLIST[key] = true
                -- 强制从物品链接中获取物品名称，确保显示正常
                local itemName = select(1, GetItemInfo(key))
                if not itemName and key:find("|H") then
                    -- 如果GetItemInfo失败，尝试从物品链接中提取物品名
                    itemName = key:match("|h%[(.-)%]|h") or key
                end
                BLACKLIST_NAMES[key] = itemName or key
            end
        else
            LoadBlacklist(GetCurrentCharacterKey())
        end
        
        if whitelistMode == "global" then
            local globalWhitelist = GetGlobalWhitelist()
            for key, value in pairs(globalWhitelist) do
                WHITELIST[key] = true
                -- 强制从物品链接中获取物品名称，确保显示正常
                local itemName = select(1, GetItemInfo(key))
                if not itemName and key:find("|H") then
                    -- 如果GetItemInfo失败，尝试从物品链接中提取物品名
                    itemName = key:match("|h%[(.-)%]|h") or key
                end
                WHITELIST_NAMES[key] = itemName or key
            end
        else
            LoadWhitelist(GetCurrentCharacterKey())
        end
        
        -- 插件加载成功提示
        --print("|cff00ff00AutoSellLowLevelGear v2.4|r 插件已成功加载！滚轮功能已完善")
        --print("输入 |cffffffff/as help|r 查看帮助，输入 |cffffffff/as|r 打开设置界面")
        -- 其它初始化逻辑可放这里
    elseif event == "MERCHANT_SHOW" then
        OnMerchantShow()
    elseif event == "MERCHANT_CLOSED" then
        if sellPopupFrame and sellPopupFrame:IsShown() then
            sellPopupFrame:Hide()
        end
    elseif event == "BAG_UPDATE" or event == "BAG_UPDATE_DELAYED" then
        -- 背包更新时检查是否有可用的代币
        if AUTO_USE_TOKEN_ENABLED and AutoSellLowLevelGearDB and AutoSellLowLevelGearDB.autoUseToken then
            C_Timer.After(1, ScanBagForUsableTokens) -- 延迟1秒执行，避免频繁触发
        end
    end
end)

