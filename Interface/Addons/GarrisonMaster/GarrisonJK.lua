--## Author: LiangYuxuan_Rhythm、高频变压器 ## Version: 2019.11.1 v3.0

--[[
1. 查询任务ID与物品ID
  * 178数据库
    http://db.178.com/wow/
    先查奖励的物品，再点关卡即可获得ID
    比如军团勋章：http://db.178.com/wow/cn/item/128315.html#missions
    其中关卡的链接为：http://db.178.com/wow/cn/mission/684.html
    得到任务ID：684，物品ID：128315
  * wowhead
    https://cn.wowhead.com/
    同理先查询物品，再点任务获得ID
    军团勋章：https://cn.wowhead.com/item=128315/%E5%86%9B%E5%9B%A2%E5%8B%8B%E7%AB%A0#missions
    任务：https://cn.wowhead.com/mission=684/%E5%8F%AF%E6%80%95%E7%9A%84%E6%81%90%E9%AD%94
    得到任务ID：684，物品ID：128315
  * 游戏内查询
    /dump GetQuestInfoByQuestID("此处放入任务链接")，回车得到ID

2. 填入上方表，按照 [任务ID] = 物品ID, 填写即可
]]--

local database = {
    -- [followerTypeID] = { [missionID] = itemID }
    [Enum.GarrisonFollowerType.FollowerType_6_0] = {
        -- WoD 要塞
        [684] = 128315, -- 可怕的恐魔: 军团勋章
        [683] = 128314, -- 暴雪嘉年华: 英雄的冰封装备
        [307] = 114622, -- 通天峰行动: 浴血兵器 (645)
        [308] = 114746, -- 我们有钻探机: 浴血护甲套装 (645)
        [329] = 118474, -- 舞蹈学院: 超级舞王指南
        [362] = 118475, -- 炉石锦标赛: 炉石战术指南
        [363] = 118475, -- 炉石锦标赛: 炉石战术指南
        [682] = 128313, -- 食人魔的困境: 巨大的食人魔箱子
        [685] = 128316, -- 恐怖动物园: 大桶原油
    },
    [Enum.GarrisonFollowerType.FollowerType_6_2] = {
        -- WoD 船坞
        -- 空
    },
    [Enum.GarrisonFollowerType.FollowerType_7_0] = {
        -- LEG 职业大厅
        [1364] = 146938, -- 山地之王：至高岭部族徽章
        [1372] = 146935, -- 龙血：瓦拉加尔部族徽章
        [1411] = 146938, -- 死亡清道夫：至高岭部族徽章
        [1608] = 146938, -- 弹药测试：至高岭部族徽章
        [1621] = 146935, -- 突袭传送门：瓦拉加尔部族徽章
        [1424] = 146935, -- 没有资格：瓦拉加尔部族徽章
        [1651] = 146935, -- 鳞片问题：瓦拉加尔部族徽章
        [1652] = 146938, -- 强大部族：至高岭部族徽章
        [1715] = 150924, -- 不幸后果：破碎群岛高级贡品
        [1718] = 150924, -- 随意开火：破碎群岛高级贡品
        [1725] = 150924, -- 阻止围攻：破碎群岛高级贡品
        [1728] = 150924, -- 冲破防御：破碎群岛高级贡品
        [1735] = 150924, -- 背井离乡：破碎群岛高级贡品
        [1738] = 150924, -- 避重就轻：破碎群岛高级贡品
        [1745] = 150924, -- 决战虚空：破碎群岛高级贡品
        [1748] = 150924, -- 混乱不堪：破碎群岛高级贡品
        [1755] = 150924, -- 军团先锋：破碎群岛高级贡品
        [1758] = 150924, -- 阻止浩劫：破碎群岛高级贡品
        [1765] = 150924, -- 强化防线：破碎群岛高级贡品
        [1768] = 150924, -- 战争使者：破碎群岛高级贡品
    },
    [Enum.GarrisonFollowerType.FollowerType_8_0] = {
        -- BfA 追随者
        -- 空
    },
}

local typeLocale = {
    [Enum.GarrisonFollowerType.FollowerType_6_0] = '6.0要塞任务',
    [Enum.GarrisonFollowerType.FollowerType_6_2] = '6.2船坞任务',
    [Enum.GarrisonFollowerType.FollowerType_7_0] = '7.0职业大厅任务',
    [Enum.GarrisonFollowerType.FollowerType_8_0] = '8.0追随者任务',
}

local function prettyPrint(typeID, itemID)
    local _, itemLink, _, _, _, _, _, _, _, itemIcon = GetItemInfo(itemID)
    if not itemLink or not itemIcon then
        return C_Timer.After(1, function()
            prettyPrint(typeID, itemID)
        end)
    end
    print(format("|cffff4500%s|r|cffff4500→|r|T%s:16|t %s", typeLocale[typeID], itemIcon, itemLink))
end

local frame = CreateFrame('Frame')
frame:RegisterEvent('GARRISON_MISSION_FINISHED')
frame:SetScript('OnEvent', function()
    for typeID, tbl in pairs(database) do
        local missions = C_Garrison.GetAvailableMissions(typeID)
        if missions then
            for _, mission in ipairs(missions) do
                if tbl[mission.missionID] then
                    --PlaySoundFile('Interface/AddOns/GarrisonJK/Ding.ogg', 'Master')
                    prettyPrint(typeID, tbl[mission.missionID])
                    break
                end
            end
        end
    end
end)