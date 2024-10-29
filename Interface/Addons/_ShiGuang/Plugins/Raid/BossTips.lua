--## Notes: 副本提示插件  ## Author: nga_以德报德  ## Version: 1.2.1
-- 创建主框架
local frame = CreateFrame("Frame")

-- 定义副本数据结构
local BossData = {
    ["千丝之城"] = {
        ["演说者基克斯威兹克"] = {
            tips = "开打以BOSS为中心身边出个圈||所有人保持自己在boss圈内||并且躲好技能，不踩黑水||BOSS定期砸地板放黑水需要坦克拉开||圈只会跟BOSS走，坦克不拉走大家只好硬踩黑水了！",
        },
        ["女王之牙"] = {
            tips = "直接开撸，出什么躲什么。",
        },
        ["凝结聚合体"] = {
            tips = "BOSS召唤黑球从场地边缘飞向BOSS||需要去接球别让BOSS吃球回血||吃到球的队友会染一个DEBUFF需要奶妈刷爆他。",
        },
        ["大捻接师艾佐"] = {
            tips = "BOSS会点名所有人几秒后脚下出软泥||在打死软泥之前无限定身||需要所有人在点名时集合方便速度AOE掉软泥||如果能自己解定身的职业可以无视||否则会一直定身影响后续需要跑位技能的躲避。",
        },
    },
    ["驭雷栖巢"] = {
        ["凯里欧斯"] = {
            tips = "没什么特别需要注意的机制||就是BOSS有个技能是飞到场地中间一道射线扫射半场||被扫到昏迷8秒，注意躲避！",
        },
        ["雷卫戈伦"] = {
            tips = "BOSS大跳跃击||落地后产生四道往四面方向飞行的黑光柱，注意躲避。",
        },
        ["虚空石畸体"] = {
            tips = "别站坦克背后！BOSS召唤出来的水晶速度转火打掉！",
        },
    },
    ["破晨号"] = {
        ["代言人夏多克朗"] = {
            tips = "BOSS在半血和空血的时候分别会引导大招||覆盖整个飞船的长读条秒杀性AOE||这时玩家会获得一个BUFF||可以战斗中使用飞行技能||需要上鸟离开飞船躲避。",
        },
        ["阿努布伊卡斯"] = {
            tips = "BOSS会在所处的小镇里面巡逻||小镇的教堂、旅馆和镇长家里分别躲了一只有特殊名字的小怪||需要清理掉否则BOSS血量伤害爆增||BOSS黑圈点坦坦不动其他人躲||BOSS点名放黑球需要被点名的人调整好方向让黑球尽量滚远再爆。",
        },
        ["拉夏南"] = {
            tips = "BOSS点名非坦队友放绿线||被点名人自己改变站位让毒浪出现在边缘不影响其他队友||场地上出倒计时火药桶需要捡桶丢BOSS脸上炸它||否则桶会爆炸全团AOE||二阶段BOSS离开飞船的时候利用战斗中上鸟功能沿着NPC点亮的悬浮光球追击。",
        },
    },
    ["圣焰隐修院"] = {
        ["戴尔克莱上尉"] = {
            tips = "被点名离开人群，boss的长矛会对路径上的所有人造成伤害||打断boss读条，不然会全队AOE，并且给buff小怪||BOSS找队友贴贴会带套，要打破这个套！",
        },
        ["布朗派克男爵"] = {
            tips = "远程不要站在近战区域||点名远程的转转锤自己看着躲。",
        },
        ["隐修院长穆普雷"] = {
            tips = "Boss会点名，地上会有一只黄圈点谁追谁||并且黄圈还会放黑水，注意要远离人群，保持移动||BOSS半血会上楼，大伙跑楼梯追上去打掉BOSS护盾打断读条即可。",
        },
    },
    ["艾拉-卡拉，回响之城"] = {
        ["阿瓦诺克斯"] = {
            tips = "定期召唤小蜘蛛无仇恨追人，需要控住清理。",
        },
        ["阿努布泽克特"] = {
            tips = "躲开地上会移动的虫群。Boss二阶段会放全场AOE虫群之眼||注意站到boss前面的圈圈里，躲好技能，出去就是死||点名一名队友几秒后会出现一圈小虫群AOE需要离开人群放圈。",
        },
        ["收割者吉卡塔尔"] = {
            tips = "出啥躲啥，被网住就昏迷6秒||不能驱散的||场地边缘出现的小软泥打死会留下黑水||人踩上去会被定身并身下出现一只小软需要打掉才能解除||BOSS引导大招全场吸人时所有人需要主动去踩黑水定身避免被吸入。",
        },
    },
    ["矶石宝库"] = {
        ["E.D.N.A."] = {
            tips = "BOSS点名三个人放射线||会有箭头指引方向||被点名的人自己调整利用射线把场地上的石头炸掉。",
        },
        ["斯卡莫拉克"] = {
            tips = "虚空魔像，场地上召唤的水晶需要打掉||否则BOSS会定期吃掉水晶给自己上很厚的吸收盾。",
        },
        ["机械大师"] = {
            tips = "二人组，离开中间铁轨||全场放火阶段有一个方向固定没有火可以用于躲避||其中一人死掉另一人会开始全场持续AOE||需要平衡血量尽量一起死。",
        },
        ["虚空代言人艾里克"] = {
            tips = "BOSS身边的两个虚空黑门，碰到就秒杀||被BOSS点名持续时间DOT||需要跑去黑门附近就会消失但别碰到黑门||BOSS点名放黑水尽量放边缘免得后期没地方站。",
        },
    },
    ["燧酿酒庄"] = {
        ["酿造大师阿德里尔"] = {
            tips = "打到半血会去柜台进入无敌状态||需要有人去场地边缘给暴怒顾客送酒安抚解除无敌。",
        },
        ["艾帕"] = {
            tips = "会召唤三只小软一直试图碰到BOSS||如果碰到会给BOSS一个非常厚的吸收盾||需要坦克拉着BOSS风筝小软||其他人尽快击杀掉小软。",
        },
        ["本克·鸣蜂"] = {
            tips = "蜜蜂骑手，没什么特别在意的||召唤小蜂蜜控住杀掉即可。",
        },
        ["戈尔迪·底爵"] = {
            tips = "场地上很多爆炸酒桶||BOSS点名坦克的击飞和点名非坦克的红圈都会引爆酒桶||产生四个方向爆炸波||利用这两个技能处理掉酒桶||否则BOSS后续大招AOE||会把所有剩余酒桶引爆造成全场伤害和满地火浪。",
        },
    },
    ["暗焰裂口"] = {
        ["老蜡须"] = {
            tips = "场地上很多小狗头人无仇恨追人||引到轨道上用矿车撞死||发红的轨道马上会来矿车。",
        },
        ["布雷炙孔"] = {
            tips = "被点名放火的人去场地边缘点亮蜡烛||BOSS的大招AOE跑到之前点亮的蜡烛一侧就能躲掉！",
        },
        ["蜡烛之王"] = {
            tips = "被BOSS点名飞刀了跑去蜡像后面档飞刀||被BOSS点名放黑圈了跑去蜡像旁边用黑圈炸掉蜡像||每轮五个蜡像尽量全部在本轮内处理完毕。",
        },
        ["黑暗之主"] = {
            tips = "需要有人去场地边缘捡油给灯添燃料||BOSS点名黑圈的人要跑远几步避免黑圈炸灯||BOSS读条吹灯需要一个人把灯捡起来拿开别被吹到||BOSS读条召唤小怪可打断需要秒断。",
        },
    },
    ["尼鲁巴尔王宫"] = {
          ["噬灭者乌格拉克斯"] = {
            tips = "被大圈标记的玩家找人分摊伤害||吃了分摊的要逃离boss，避免被拖到boss下方||躲避网状物，并用绿色酸液圆圈清除它们||当能量降到0时，BOSS会跳到平台中央，将所有人击退并消失进P2||躲避boss冲锋，打出现的小怪||boss出现后送它吃小怪尸体回能量进P1",
        },
        ["血缚恐魔"] = {
            tips = "单阶段战斗，分内外场||没事不要去血池游泳，会死||受到Boss吐息的可以进内场杀小怪||分两队轮流进内场||内场小怪注意打断||被boss点名放圈的要边跑边放||能量100了会大圈炸人全团跑开",
        },
        ["席克兰"] = {
            tips = "单阶段纯单体战斗||BOSS会穿过玩家留下幽灵，放幽灵尽量靠近，节约场地||BOSS点名几个玩家射光，就用光消除场地上的幽灵||幽灵消除了会留个圈，别踩",
        },
        ["拉夏南"] = {
            tips = "单阶段，boss会两边飞||BOSS点名放绿线，看好方向躲避||绿线会变成波浪，被点名的放到边边上去||小怪拉一起打，近战位不能没人，没人会AOE",
        },
    },
}

-- 当前副本的boss集合
local currentInstanceBosses = {}

-- 跟踪当前显示的BOSS和手动隐藏状态
local currentBoss = nil
local manuallyHidden = false

-- 更新当前副本的boss集合
local function UpdateCurrentInstanceBosses()
    wipe(currentInstanceBosses)
    local instanceName = GetInstanceInfo()
    if BossData[instanceName] then
        for bossName, _ in pairs(BossData[instanceName]) do
            currentInstanceBosses[bossName] = true
        end
    end
end

-- 检查目标是否为已知的boss
local function IsKnownBoss(target)
    return currentInstanceBosses[target] or false
end

-- 获取boss的攻略信息
local function GetBossTips(target)
    local instanceName = GetInstanceInfo()
    return BossData[instanceName] and BossData[instanceName][target] and BossData[instanceName][target].tips or nil
end

-- 创建攻略窗体
local tipsFrame = CreateFrame("Frame", "BossTipsFrame", EncounterJournal)
tipsFrame:SetSize(300, 200)
-- 设置窗体位置：在聊天框标签右上角，向右200像素，向上10像素
tipsFrame:SetPoint("TOPLEFT", EncounterJournal, "TOPRIGHT", 30, 0)
tipsFrame:SetFrameStrata("BACKGROUND")
tipsFrame:Hide()

-- 创建攻略文本
local tipsText = tipsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
tipsText:SetPoint("TOPLEFT", 10, -10)
tipsText:SetPoint("BOTTOMRIGHT", -10, 40)
tipsText:SetJustifyH("LEFT")
tipsText:SetJustifyV("TOP")

-- 创建半透明背景
local bg = tipsFrame:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints()
bg:SetColorTexture(0, 0, 0, 0.5)  -- 黑色背景，50%透明度

-- 创建发送按钮的右键菜单
local sendButtonMenu = CreateFrame("Frame", "BossTipsSendButtonMenu", EncounterJournal, "UIDropDownMenuTemplate")

local function SendButtonMenu(frame, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    info.func = function(self, arg1, arg2, checked)
        SendLongMessage(GetBossTips(UnitName("target")), arg1)
    end

    info.text, info.arg1 = "队伍", "PARTY"
    UIDropDownMenu_AddButton(info, level)

    info.text, info.arg1 = "副本", "INSTANCE_CHAT"
    UIDropDownMenu_AddButton(info, level)

    info.text, info.arg1 = "说", "SAY"
    UIDropDownMenu_AddButton(info, level)
end

-- 注册右键菜单
UIDropDownMenu_Initialize(sendButtonMenu, SendButtonMenu, "MENU")

-- 修改 SendLongMessage 函数
local function SendLongMessage(message, chatType)
    chatType = chatType or (IsInRaid() and "INSTANCE_CHAT" or "PARTY")
    local parts = {strsplit("||", message)}
    for _, part in ipairs(parts) do
        part = strtrim(part)
        if part ~= "" then
            SendChatMessage(part, chatType)
            C_Timer.After(0.5, function() end)
        end
    end
end

-- 创建发送按钮
local sendButton = CreateFrame("Button", nil, tipsFrame, "UIPanelButtonTemplate")
sendButton:SetSize(80, 25)
sendButton:SetPoint("BOTTOMRIGHT", -90, 10)
sendButton:SetText("发送")
-- 修改发送按钮的点击脚本
sendButton:SetScript("OnClick", function(self, button)
    if button == "LeftButton" then
        local target = UnitName("target")
        local tips = GetBossTips(target)
        if tips then
            SendLongMessage(tips)
        end
    elseif button == "RightButton" then
        ToggleDropDownMenu(1, nil, sendButtonMenu, self, 0, 0)
    end
end)





-- 创建收起/展开按钮
local toggleButton = CreateFrame("Button", nil, EncounterJournal, "UIPanelButtonTemplate")
toggleButton:SetSize(80, 40)
toggleButton:SetPoint("TOPRIGHT", EncounterJournal, "TOPRIGHT", 200, 10)
toggleButton:SetText("收起")

toggleButton:SetScript("OnClick", function()
    if tipsFrame:IsShown() then
        tipsFrame:Hide()
        toggleButton:SetText("展开")
        toggleButton:SetPoint("TOPRIGHT", EncounterJournal, "TOPRIGHT", 200, 10)
        manuallyHidden = true
    else
        tipsFrame:Show()
        toggleButton:SetText("收起")
        toggleButton:SetPoint("BOTTOMRIGHT", tipsFrame, "BOTTOMRIGHT",20, 10)
        manuallyHidden = false
    end
end)



-- 更新框体可见性
local function UpdateFrameVisibility()
    local target = UnitName("target")
    if IsKnownBoss(target) then
        if target ~= currentBoss then
            manuallyHidden = false
            currentBoss = target
        end
        
        local tips = GetBossTips(target)
        if tips then
            local formattedTips = string.format("|cFFFFFF00%s|r\n\n%s", target, tips)
            tipsText:SetText(formattedTips)
        end
        
        toggleButton:Enable()
        toggleButton:SetText("收起")
        
        if not manuallyHidden then
            tipsFrame:Show()
            toggleButton:SetPoint("BOTTOMRIGHT", tipsFrame, "BOTTOMRIGHT", 10, 10)
        else
            tipsFrame:Hide()
            toggleButton:SetPoint("TOPRIGHT", EncounterJournal, "TOPRIGHT", 300, 10)
            toggleButton:SetText("展开")
        end
    else
        tipsFrame:Hide()
        currentBoss = nil
        toggleButton:SetText("无攻略")
        toggleButton:Disable()
        toggleButton:SetPoint("TOPRIGHT", EncounterJournal, "TOPRIGHT", 200, 10)
    end
    
    --toggleButton:Show() -- 始终显示按钮
end

-- 主事件处理函数
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
        UpdateCurrentInstanceBosses()
        manuallyHidden = false
        currentBoss = nil
        UpdateFrameVisibility()
    elseif event == "PLAYER_TARGET_CHANGED" then
        UpdateFrameVisibility()
    end
end)

-- 注册事件
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
