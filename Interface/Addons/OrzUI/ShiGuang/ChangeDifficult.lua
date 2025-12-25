-- 副本难度切换器 ## Version: 1.4

-- 创建主框架
local frame = CreateFrame("Frame", "ChangeDifficultFrame", GameMenuFrame, "BackdropTemplate")
frame:SetSize(100, 400)
frame:SetPoint("TOPRIGHT", GameMenuFrame, "TOPLEFT", 8, -20)
frame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 2, right = 2, top = 2, bottom = 2 }
})
frame:SetBackdropColor(0, 0, 0, 0.8)
--frame:SetBackdropBorderColor(0, 0, 0, 0)  -- 完全透明边框
--frame:SetMovable(true)

-- 地下城区域
local dungeonLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
dungeonLabel:SetPoint("TOP", frame, "TOP", 0, -20)
dungeonLabel:SetText("地下城")
dungeonLabel:SetTextColor(1, 0.8, 0)  -- 设置成和标题一样的金黄色

-- 创建地下城文字按钮
local dungeonButtons = {}
local dungeonDifficulties = {
    {text = "普通", id = 1},
    {text = "英雄", id = 2},
    {text = "史诗", id = 23}
}

for i, diff in ipairs(dungeonDifficulties) do
    -- 创建纯文字按钮
    local btn = CreateFrame("Button", nil, frame)
    btn:SetSize(70, 25)
    btn:SetPoint("TOP", dungeonLabel, "BOTTOM", 0, -5 - (i-1) * 30)
    
    -- 创建文字
    local fontString = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fontString:SetAllPoints(btn)
    fontString:SetText(diff.text)
    fontString:SetTextColor(1, 0, 0)  -- 默认红色（未选中）
    
    -- 保存引用
    btn.fontString = fontString
    btn.originalText = diff.text  -- 保存原始文字
    btn.difficultyId = diff.id
    btn.isDungeon = true
    dungeonButtons[i] = btn
end

-- 团本区域
local raidLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
raidLabel:SetPoint("TOP", frame, "TOP", 0, -150)
raidLabel:SetText("团本")
raidLabel:SetTextColor(1, 0.8, 0)  -- 设置成和标题一样的金黄色

-- 创建团本人数按钮
local raidSizeButtons = {}
local raidSizes = {
    {text = "10人", size = 10},
    {text = "25人", size = 25}
}

for i, size in ipairs(raidSizes) do
    -- 创建纯文字按钮
    local btn = CreateFrame("Button", nil, frame)
    btn:SetSize(40, 20)
    btn:SetPoint("TOP", raidLabel, "BOTTOM", (i-1.5) * 45, -8.5) -- 恢复到与地下城普通难度同一水平线
    
    -- 创建文字
    local fontString = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fontString:SetAllPoints(btn)
    fontString:SetText(size.text)
    fontString:SetTextColor(1, 0, 0)  -- 默认红色（未选中）
    
    -- 保存引用
    btn.fontString = fontString
    btn.originalText = size.text  -- 保存原始文字
    btn.raidSize = size.size
    btn.isRaidSize = true
    raidSizeButtons[i] = btn
end

-- 创建团本难度按钮
local raidButtons = {}
local raidDifficulties = {
    {text = "普通", id10 = 3, id25 = 4},
    {text = "英雄", id10 = 5, id25 = 6},
    {text = "史诗", id10 = 16, id25 = 16}
}

for i, diff in ipairs(raidDifficulties) do
    -- 创建纯文字按钮
    local btn = CreateFrame("Button", nil, frame)
    btn:SetSize(70, 25)
    -- 对齐方案：团本普通(-35) ↔ 地下城英雄(-35)，团本英雄(-65) ↔ 地下城史诗(-65)，团本史诗(-95) ↔ 地下城重置(-95)
    local yOffset = -35 - (i-1) * 30  -- 团本普通从-35开始，每个间隔30
    btn:SetPoint("TOP", raidLabel, "BOTTOM", 0, yOffset)
    
    -- 设置按钮可点击
    btn:EnableMouse(true)
    btn:RegisterForClicks("AnyUp")
    
    -- 创建文字
    local fontString = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fontString:SetAllPoints(btn)
    fontString:SetText(diff.text)
    fontString:SetTextColor(1, 0, 0)  -- 默认红色（未选中）
    
    -- 保存引用
    btn.fontString = fontString
    btn.textObj = fontString  -- 添加textObj引用，统一访问方式
    btn.originalText = diff.text  -- 保存原始文字
    btn.difficulty10 = diff.id10
    btn.difficulty25 = diff.id25
    btn.isRaidDifficulty = true
    
    -- 去掉悬停效果
    
    raidButtons[i] = btn
end

-- 创建一键退出文字按钮（在史诗难度下方，与传进/出副本对齐）
local leaveGroupButton = CreateFrame("Button", nil, frame)
leaveGroupButton:SetSize(80, 25)
leaveGroupButton:SetPoint("TOP", raidButtons[3], "BOTTOM", 0, -35) -- 史诗难度下方5像素

-- 创建文字
local leaveFontString = leaveGroupButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
leaveFontString:SetAllPoints(leaveGroupButton)
leaveFontString:SetText("一键退出")
leaveFontString:SetTextColor(0, 1, 1)  -- 天蓝色

-- 离开队伍按钮点击事件
leaveGroupButton:SetScript("OnClick", function()
    local inInstance, instanceType = IsInInstance()
    local inGroup = IsInGroup()
    local inRaid = IsInRaid()
    
    if inInstance and instanceType ~= "none" then
        -- 在各种实例中，根据类型使用不同的离开方法
        if instanceType == "party" then
            -- 地下城（包括追随者地下城）
            if inGroup or inRaid then
                -- 有队伍，直接离开
                C_PartyInfo.LeaveParty()
            else
                -- 没有队伍，检查是否真的是单人状态
                local numGroupMembers = GetNumGroupMembers()
                if numGroupMembers <= 1 then
                    -- 确实是单人，先邀请123创建队伍，然后强制离开触发60秒传送
                    C_PartyInfo.InviteUnit("123")
                    C_Timer.After(1, function()
                        -- 不管邀请后队伍状态如何，强制离开队伍
                        C_PartyInfo.LeaveParty()
                    end)
                else
                    -- 实际上有队友，直接离开
                    C_PartyInfo.LeaveParty()
                end
            end
        elseif instanceType == "raid" then  
            -- 团队副本
            if inGroup or inRaid then
                -- 有队伍，直接离开
                C_PartyInfo.LeaveParty()
            else
                -- 没有队伍，检查是否真的是单人状态
                local numGroupMembers = GetNumGroupMembers()
                if numGroupMembers <= 1 then
                    -- 确实是单人，先邀请123创建队伍，然后强制离开触发60秒传送
                    C_PartyInfo.InviteUnit("123")
                    C_Timer.After(1, function()
                        -- 不管邀请后队伍状态如何，强制离开队伍
                        C_PartyInfo.LeaveParty()
                    end)
                else
                    -- 实际上有队友，直接离开
                    C_PartyInfo.LeaveParty()
                end
            end
        elseif instanceType == "arena" then
            -- 竞技场
            LeaveBattlefield()
        elseif instanceType == "pvp" then
            -- 战场
            LeaveBattlefield()  
        elseif instanceType == "scenario" then
            -- 场景战役，包括地下堡
            
            -- 地下堡专用API：C_PartyInfo.DelveTeleportOut()
            if C_PartyInfo and C_PartyInfo.DelveTeleportOut then
                C_PartyInfo.DelveTeleportOut()
            else
                -- 备选方案
                LeaveBattlefield()
            end
        else
            -- 其他实例类型
            if inGroup or inRaid then
                C_PartyInfo.LeaveParty()
            else
                -- 没有队伍，先邀请123创建队伍，然后离开
                C_PartyInfo.InviteUnit("123")
                C_Timer.After(1, function()
                    C_PartyInfo.LeaveParty()
                end)
            end
        end
    else
        -- 不在实例中，直接离开队伍/团队
        if inRaid then
            if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
                C_PartyInfo.LeaveParty()
            else
                C_PartyInfo.LeaveParty()
            end
        elseif inGroup then
            if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
                C_PartyInfo.LeaveParty()
            else
                C_PartyInfo.LeaveParty()
            end
        else
        end
    end
end)


-- 创建重置副本文字按钮
local resetButton = CreateFrame("Button", nil, frame)
resetButton:SetSize(80, 25)
resetButton:SetPoint("TOP", leaveGroupButton, "BOTTOM", 0, -5) -- 在第4个位置 (-5 - 3 * 30)

-- 创建文字
local resetFontString = resetButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
resetFontString:SetAllPoints(resetButton)
resetFontString:SetText("重置副本")
resetFontString:SetTextColor(0, 1, 1)  -- 天蓝色

-- 创建传进/出副本文字按钮
local teleportButton = CreateFrame("Button", nil, frame)
teleportButton:SetSize(80, 25)
teleportButton:SetPoint("TOP", resetButton, "BOTTOM", 0, -5)

-- 创建文字
local teleportFontString = teleportButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
teleportFontString:SetAllPoints(teleportButton)
teleportFontString:SetText("进/出本")
teleportFontString:SetTextColor(0, 1, 1)  -- 天蓝色

-- 创建队伍同步状态指示器
local syncStatusLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
syncStatusLabel:SetPoint("TOP", teleportButton, "BOTTOM", 0, -10)
syncStatusLabel:SetTextColor(1, 1, 0)  -- 黄色
syncStatusLabel:SetText("")

-- 创建手动刷新按钮
local refreshButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
refreshButton:SetSize(80, 20)
refreshButton:SetPoint("TOP", syncStatusLabel, "BOTTOM", 0, -5)
refreshButton:SetText("刷新难度")
-- 设置刷新按钮完全透明背景，但保持文字可见
refreshButton:SetNormalTexture("")
refreshButton:SetHighlightTexture("")
refreshButton:SetPushedTexture("")
refreshButton:SetDisabledTexture("")
refreshButton:SetNormalFontObject("GameFontNormal")
refreshButton:SetHighlightFontObject("GameFontHighlight")
-- 清除按钮边框
local refreshRegions = {refreshButton:GetRegions()}
for i, region in ipairs(refreshRegions) do
    if region:GetObjectType() == "Texture" then
        region:SetTexture("")
        region:SetTexture(nil)
    end
end
-- 完全禁用刷新按钮的所有纹理和高亮功能
refreshButton.SetNormalTexture = function() end
refreshButton.SetHighlightTexture = function() end
refreshButton.SetPushedTexture = function() end
refreshButton.SetDisabledTexture = function() end
refreshButton.LockHighlight = function() end
refreshButton.UnlockHighlight = function() end
refreshButton:Hide() -- 默认隐藏，只在需要时显示
-- 稍后定义点击事件（在lastUpdateState变量定义之后）
-- 稍后设置resetButton点击事件（在CanChangeDifficulty函数定义之后）

-- 传出地下城按钮点击事件
teleportButton:SetScript("OnClick", function()
    -- 使用LFGTeleport API，更可靠的传送方法
    LFGTeleport(IsInLFGDungeon())
    
    local inInstance = IsInInstance()
    local message = inInstance and "正在传送出副本..." or "正在传送进副本..."
    
    -- 检查是否在团队中并发送消息
    if IsInRaid() then
        SendChatMessage(message, "RAID")
    elseif IsInGroup() then
        SendChatMessage(message, "PARTY")
    end
end)

-- 状态变量
local currentDungeonDifficulty = 1
local currentRaidSize = 25
local currentRaidDifficulty = 6  -- 改为英雄难度 (25人英雄)
local wasInInstance = false

-- TTS相关变量
local ttsEnabled = true
local lastSpokenTime = 0
local ttsVolume = 100

-- 创建收缩状态的难度显示标签（在第一行和第三行之间的中间）
local collapsedDifficultyLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
-- 第一行（祝福语）顶部在 -25，加上文字高度约15，底部在 -40
-- 第三行（功能按钮）顶部在 -60
-- 中间位置 = (-40 + -60) / 2 = -50
collapsedDifficultyLabel:SetPoint("TOP", frame, "TOP", 0, -50)
collapsedDifficultyLabel:SetText("**难度")
collapsedDifficultyLabel:SetTextColor(0, 1, 0) -- 绿色
collapsedDifficultyLabel:Hide() -- 默认隐藏

-- 创建屏幕中央难度显示标签
local screenCenterLabel = CreateFrame("Frame", nil, UIParent)
screenCenterLabel:SetSize(400, 100)
-- 移动到屏幕3/5处（从底部向上60%的位置）
local screenHeight = GetScreenHeight()
local yOffset = screenHeight * 0.4 -- 从中心点向上移动10%屏幕高度，达到3/5位置
screenCenterLabel:SetPoint("CENTER", UIParent, "CENTER", 0, yOffset)
screenCenterLabel:SetFrameStrata("FULLSCREEN_DIALOG") -- 设置最高层级
screenCenterLabel:SetFrameLevel(100) -- 设置高层级
local screenCenterText = screenCenterLabel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
screenCenterText:SetPoint("CENTER", screenCenterLabel, "CENTER", 0, 0)
-- 使用游戏内置字体对象，并设置更大的字体
screenCenterText:SetFontObject("GameFontNormalHuge")
-- 获取当前字体并放大1.2倍
local fontFile, fontSize, fontFlags = screenCenterText:GetFont()
if fontFile and fontSize then
    screenCenterText:SetFont(fontFile, fontSize * 1.4, fontFlags)
end
screenCenterText:SetTextColor(1, 0, 1) -- 更鲜艳的洋红色
screenCenterText:SetShadowOffset(2, -2)
screenCenterText:SetShadowColor(0, 0, 0, 1) -- 黑色阴影
screenCenterLabel:Hide() -- 默认隐藏

-- 创建收缩状态的祝福语标签（左侧）- 使用与dungeonLabel完全相同的定位
local blessingLabelLeft = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
blessingLabelLeft:SetPoint("TOP", frame, "BOTTOM", -45, -10) -- 与dungeonLabel相同位置
blessingLabelLeft:SetText("欧气满满")
blessingLabelLeft:SetTextColor(1, 0.8, 0) -- 金黄色
blessingLabelLeft:Hide() -- 默认隐藏

-- 创建收缩状态的祝福语标签（右侧）- 使用与raidLabel完全相同的定位
local blessingLabelRight = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
blessingLabelRight:SetPoint("TOP", frame, "BOTTOM", 45, -10) -- 与raidLabel相同位置
blessingLabelRight:SetText("所求必揽")
blessingLabelRight:SetTextColor(1, 0.8, 0) -- 金黄色
blessingLabelRight:Hide() -- 默认隐藏

-- TTS播报函数
local function SpeakDifficultyText(text)
    if not ttsEnabled or not text or text == "" then
        return
    end
    
    -- 防止频繁朗读
    local currentTime = GetTime()
    local cooldownTime = 5
    if currentTime - lastSpokenTime < cooldownTime then
        return
    end
    
    -- 智能朗读：战斗中不朗读
    if not InCombatLockdown() then
        C_Timer.After(0.5, function()
            if C_VoiceChat and C_VoiceChat.SpeakText then
                -- 使用语音聊天API
                C_VoiceChat.SpeakText(0, text, Enum.VoiceTtsDestination.RemoteTransmission, 0, ttsVolume)
            elseif C_TextToSpeech and C_TextToSpeech.SpeakText then
                -- 备用方案
                local volumeRatio = ttsVolume / 100
                C_TextToSpeech.SpeakText(text, 0, volumeRatio, 1.0)
            end
        end)
        
        lastSpokenTime = GetTime()
    end
end

-- 创建屏幕中央显示难度函数
local function ShowDifficultyInCenter(difficultyText)
    if not difficultyText or difficultyText == "" then
        return
    end
    
    screenCenterText:SetText(difficultyText)
    screenCenterLabel:Show()
    
    -- 同时播报TTS
    SpeakDifficultyText(difficultyText)
    
    -- 3秒后隐藏
    C_Timer.After(3, function()
        screenCenterLabel:Hide()
    end)
end

-- 创建收缩/展开函数
local function SetCollapsedMode(collapsed)
    if collapsed then
        -- 收缩模式 - 保持框架大小不变，只隐藏/显示元素
        
        -- 隐藏所有难度选择按钮
        for _, btn in ipairs(dungeonButtons) do
            btn:Hide()
        end
        for _, btn in ipairs(raidSizeButtons) do
            btn:Hide()
        end
        for _, btn in ipairs(raidButtons) do
            btn:Hide()
        end
        
        -- 隐藏标签
        dungeonLabel:Hide()
        raidLabel:Hide()
        
        -- 显示收缩状态的难度标签
        collapsedDifficultyLabel:Show()
        
        -- 显示祝福语
        blessingLabelLeft:Show()
        blessingLabelRight:Show()
        
        -- 隐藏重置按钮
        resetButton:Hide()
        
        -- 重新定位传进/出副本按钮到地下城英雄难度位置
        teleportButton:ClearAllPoints()
        teleportButton:SetPoint("TOP", dungeonLabel, "BOTTOM", 0, -35) -- 英雄难度位置
        
        -- 重新定位一键退出按钮到传进/出副本位置（收缩模式下对齐）
        leaveGroupButton:ClearAllPoints()
        leaveGroupButton:SetPoint("TOP", raidLabel, "BOTTOM", 0, -35) -- 收缩模式下与传进/出副本对齐
        
        -- 更新难度显示文本
        local inInstance, instanceType = IsInInstance()
        if inInstance then
            local _, _, difficultyID, difficultyName = GetInstanceInfo()
            if instanceType == "party" then
                -- 地下城显示为 "5人XX本"
                local displayText = "5人普通本"
                if difficultyID == 1 then
                    displayText = "5人普通本"
                elseif difficultyID == 2 then
                    displayText = "5人英雄本"
                elseif difficultyID == 23 then
                    displayText = "5人史诗本"
                else
                    displayText = difficultyName and ("5人" .. difficultyName) or "5人地下城"
                end
                collapsedDifficultyLabel:SetText(displayText)
            elseif instanceType == "raid" then
                -- 团本根据难度ID判断类型和人数
                local displayText = difficultyName or "团本"
                -- 旧版难度ID: 3=10人普通, 4=25人普通, 5=10人英雄, 6=25人英雄, 16=史诗
                -- 现代难度ID: 14=普通, 15=英雄, 16=史诗
                if difficultyID == 3 then
                    displayText = "10人普通"
                elseif difficultyID == 4 then
                    displayText = "25人普通"
                elseif difficultyID == 5 then
                    displayText = "10人英雄"
                elseif difficultyID == 6 then
                    displayText = "25人英雄"
                elseif difficultyID == 14 then
                    displayText = "普通团本"
                elseif difficultyID == 15 then
                    displayText = "英雄团本"
                elseif difficultyID == 16 then
                    displayText = "史诗团本"
                end
                collapsedDifficultyLabel:SetText(displayText)
            end
        end
    else
        -- 展开模式 - 保持框架大小不变，只隐藏/显示元素
        
        -- 显示所有难度选择按钮
        for _, btn in ipairs(dungeonButtons) do
            btn:Show()
        end
        for _, btn in ipairs(raidSizeButtons) do
            btn:Show()
        end
        for _, btn in ipairs(raidButtons) do
            btn:Show()
        end
        
        -- 显示标签
        dungeonLabel:Show()
        raidLabel:Show()
        
        -- 隐藏收缩状态的难度标签
        collapsedDifficultyLabel:Hide()
        
        -- 隐藏祝福语
        blessingLabelLeft:Hide()
        blessingLabelRight:Hide()
        
        -- 显示重置按钮
        resetButton:Show()
        
        -- 恢复按钮原始位置
        teleportButton:ClearAllPoints()
        teleportButton:SetPoint("TOP", resetButton, "BOTTOM", 0, -5)
        
        leaveGroupButton:ClearAllPoints()
        leaveGroupButton:SetPoint("TOP", raidButtons[3], "BOTTOM", 0, -5) -- 展开模式下在史诗难度下方
    end
end

-- 个人难度设置缓存（用于小队模式下显示个人设置）
local personalDifficultyCache = {
    dungeonDiff = 2,  -- 默认英雄
    legacyDiff = 6,   -- 默认25人英雄
    modernDiff = 15,  -- 默认英雄
    lastUpdate = 0
}

-- 缓存上次更新的状态，避免重复更新
local lastUpdateState = {
    dungeonDiff = nil,
    legacyDiff = nil,
    modernDiff = nil,
    inGroup = nil,
    inRaid = nil
}


-- 更新按钮高亮状态
local function UpdateButtonHighlight(buttons, activeButton)
    for _, btn in ipairs(buttons) do
        if activeButton and btn == activeButton then
            -- 选中状态：绿色文字
            if btn.fontString then
                btn.fontString:SetTextColor(0, 1, 0)  -- 绿色表示选中
            elseif btn.textObj then
                btn.textObj:SetTextColor(0, 1, 0)  -- 绿色表示选中
            end
            btn.isHighlighted = true
        else
            -- 未选中状态：红色文字
            if btn.fontString then
                btn.fontString:SetTextColor(1, 0, 0)  -- 红色表示未选中
            elseif btn.textObj then
                btn.textObj:SetTextColor(1, 0, 0)  -- 红色表示未选中
            end
            btn.isHighlighted = false
        end
    end
end

-- 检查是否有修改难度的权限
local function CanChangeDifficulty()
    local inGroup = IsInGroup()
    local inRaid = IsInRaid()
    
    if not inGroup and not inRaid then
        -- 单人时总是有权限
        return true
    end
    
    -- 在队伍或团队中，检查是否是队长/团长
    -- 统一使用UnitIsGroupLeader，它适用于队伍和团队
    return UnitIsGroupLeader("player") and true or false
end

-- 设置重置按钮的点击事件（在CanChangeDifficulty函数定义之后）
resetButton:SetScript("OnClick", function()
    if not CanChangeDifficulty() then
        -- 没有权限，提示用户
        print("你没有权限重置副本")
        return
    end
    
    ResetInstances()
    local message = "副本已重置"
    
    -- 检查是否在团队中
    if IsInRaid() then
        SendChatMessage(message, "RAID")
        print(message .. " (已发送到团队频道)")
    -- 检查是否在队伍中
    elseif IsInGroup() then
        SendChatMessage(message, "PARTY")
        print(message .. " (已发送到队伍频道)")
    -- 不在任何组队中
    else
        print(message)
    end
end)


-- 检查团本难度状态（不自动修复，只检查）
local function CheckRaidDifficultyValid()
    -- 检查旧版团本难度
    local currentLegacyDiff = GetLegacyRaidDifficultyID and GetLegacyRaidDifficultyID() or 0
    if currentLegacyDiff > 0 then
        return true -- 旧版有效
    end
    
    -- 检查现代团本难度
    local currentModernDiff = GetRaidDifficultyID and GetRaidDifficultyID() or 0
    if currentModernDiff > 0 and (currentModernDiff == 14 or currentModernDiff == 15 or currentModernDiff == 16) then
        return true -- 现代版有效
    end
    
    return false -- 都无效
end

-- 更新按钮状态以反映当前难度
local function UpdateButtonStates()
    local inGroup = IsInGroup()
    local inRaid = IsInRaid()
    
    -- 获取当前难度 - 在队伍中时获取队伍的实际生效难度
    local currentDungeonDiff, currentLegacyDiff, currentModernDiff
    
    if inGroup or inRaid then
        local isLeader = UnitIsGroupLeader("player")
        local inInstance, instanceType = IsInInstance()
        local isInInstanceContent = inInstance and (instanceType == "party" or instanceType == "raid")
        
        -- 获取基础难度信息
        local apiDungeonDiff = GetDungeonDifficultyID and GetDungeonDifficultyID() or 0
        local apiLegacyDiff = GetLegacyRaidDifficultyID and GetLegacyRaidDifficultyID() or 0
        local apiModernDiff = GetRaidDifficultyID and GetRaidDifficultyID() or 0
        
        if isInInstanceContent then
            -- 在副本中：显示副本的实际难度（最高优先级）
            local instanceName, instanceType, instanceDifficulty = GetInstanceInfo()
            if instanceDifficulty and instanceDifficulty > 0 then
                -- 对于团本，使用真实副本难度而不是API返回的玩家设置
                if instanceType == "raid" then
                    currentLegacyDiff = instanceDifficulty  -- 使用真实难度
                    -- 根据真实难度映射现代难度
                    if instanceDifficulty == 3 or instanceDifficulty == 4 then
                        currentModernDiff = 14  -- 普通
                    elseif instanceDifficulty == 5 or instanceDifficulty == 6 then
                        currentModernDiff = 15  -- 英雄
                    elseif instanceDifficulty == 16 then
                        currentModernDiff = 16  -- 史诗
                    else
                        currentModernDiff = apiModernDiff
                    end
                else
                    -- 地下城使用副本真实难度
                    currentDungeonDiff = instanceDifficulty
                    currentLegacyDiff = apiLegacyDiff
                    currentModernDiff = apiModernDiff
                end
            else
                currentDungeonDiff = apiDungeonDiff
                currentLegacyDiff = apiLegacyDiff
                currentModernDiff = apiModernDiff
            end
            
        elseif inGroup and not inRaid then
            -- 小队模式且没进副本的特殊逻辑
            if isLeader then
                -- 队长：显示自身设置的所有难度
                currentDungeonDiff = apiDungeonDiff
                currentLegacyDiff = apiLegacyDiff
                currentModernDiff = apiModernDiff
                
                -- 更新个人团本设置缓存
                personalDifficultyCache.legacyDiff = apiLegacyDiff
                personalDifficultyCache.modernDiff = apiModernDiff
            else
                -- 非队长：地下城显示队长难度，团本尝试获取队长难度
                currentDungeonDiff = apiDungeonDiff  -- API返回队长的地下城难度
                
                -- 尝试获取队长的团本难度，如果API同步失效则使用缓存
                if apiLegacyDiff > 0 and apiLegacyDiff ~= personalDifficultyCache.legacyDiff then
                    -- API返回了有效且不同的难度，说明队长切换了
                    currentLegacyDiff = apiLegacyDiff
                    currentModernDiff = apiModernDiff
                    -- 更新缓存
                    personalDifficultyCache.legacyDiff = apiLegacyDiff
                    personalDifficultyCache.modernDiff = apiModernDiff
                else
                    -- API无效或无变化，使用缓存的队长难度
                    currentLegacyDiff = personalDifficultyCache.legacyDiff
                    currentModernDiff = personalDifficultyCache.modernDiff
                end
            end
        else
            -- 其他情况：团队模式或单人
            currentDungeonDiff = apiDungeonDiff
            currentLegacyDiff = apiLegacyDiff
            currentModernDiff = apiModernDiff
            
            -- 单人时更新个人设置缓存
            if not inGroup then
                personalDifficultyCache.dungeonDiff = apiDungeonDiff
                personalDifficultyCache.legacyDiff = apiLegacyDiff
                personalDifficultyCache.modernDiff = apiModernDiff
                personalDifficultyCache.lastUpdate = GetTime()
            end
        end
        
        -- 检查是否是队长（使用更安全的API调用）
        local isLeader = false
        if inRaid then
            -- 对于团队，使用UnitIsGroupLeader检查团长
            isLeader = UnitIsGroupLeader("player")
        else
            -- 对于队伍，使用UnitIsGroupLeader检查队长
            isLeader = UnitIsGroupLeader("player")
        end
        
        -- 检测到非队长状态时，自动尝试同步
        if not isLeader then
            -- 静默检测同步问题，必要时自动刷新
            -- 这里可以添加自动同步逻辑
        end
    else
        -- 单人时使用个人设置
        currentDungeonDiff = GetDungeonDifficultyID and GetDungeonDifficultyID() or 0
        currentLegacyDiff = GetLegacyRaidDifficultyID and GetLegacyRaidDifficultyID() or 0
        currentModernDiff = GetRaidDifficultyID and GetRaidDifficultyID() or 0
    end
    
    -- 检查是否有变化，如果没有变化就不需要更新
    if lastUpdateState.dungeonDiff == currentDungeonDiff and
       lastUpdateState.legacyDiff == currentLegacyDiff and
       lastUpdateState.modernDiff == currentModernDiff and
       lastUpdateState.inGroup == inGroup and
       lastUpdateState.inRaid == inRaid then
        -- print("UpdateButtonStates: 无变化，跳过更新") -- 注释掉减少调试输出
        return -- 没有变化，直接返回
    end
    
    -- 更新缓存状态
    lastUpdateState.dungeonDiff = currentDungeonDiff
    lastUpdateState.legacyDiff = currentLegacyDiff
    lastUpdateState.modernDiff = currentModernDiff
    lastUpdateState.inGroup = inGroup
    lastUpdateState.inRaid = inRaid
    
    -- 不再自动设置团本难度，保持原始状态
    
    -- 更新地下城难度按钮 - 反映实际生效的难度
    if currentDungeonDiff and currentDungeonDiff > 0 then
        local foundMatch = false
        
        -- 静默处理，去掉调试信息
        
        for i, btn in ipairs(dungeonButtons) do
            if btn.difficultyId == currentDungeonDiff then
                UpdateButtonHighlight(dungeonButtons, btn)
                currentDungeonDifficulty = currentDungeonDiff
                foundMatch = true
                break
            end
        end
        
        -- 如果没有找到匹配的按钮
        if not foundMatch then
            if inGroup or inRaid then
                -- 在团队/队伍中，没有有效难度时清除所有高亮
                UpdateButtonHighlight(dungeonButtons, nil)
                currentDungeonDifficulty = 0
            elseif #dungeonButtons > 0 then
                -- 单人时，默认选择普通难度
                UpdateButtonHighlight(dungeonButtons, dungeonButtons[1])
                currentDungeonDifficulty = dungeonButtons[1].difficultyId
            end
        end
    end
    
    -- 更新团本人数和难度按钮 - 同时考虑旧版和现代系统
    if inGroup or inRaid then
        local isLeader = UnitIsGroupLeader("player")
        
        if not isLeader then
            -- 检测Legacy Raid API的已知同步问题，但不显示提示
            -- 根据WoW API文档，Legacy Raid在队伍中确实存在同步限制
            local hasLegacySyncIssue = false
            
            -- 现代WoW支持队伍和团队都能进入团本，统一处理同步问题
            if currentLegacyDiff > 0 then
                hasLegacySyncIssue = true
                -- 不再显示同步提示文本
            end
            
            -- 始终隐藏同步提示和刷新按钮
            syncStatusLabel:SetText("")
            refreshButton:Hide()
        else
            -- 如果是队长，隐藏同步提示
            syncStatusLabel:SetText("")
            refreshButton:Hide()
        end
    end
    
    -- 确定当前人数（优先使用旧版系统）
    if currentLegacyDiff > 0 then
        if currentLegacyDiff == 3 or currentLegacyDiff == 5 then
            -- 10人模式 (3=10人普通, 5=10人英雄)
            UpdateButtonHighlight(raidSizeButtons, raidSizeButtons[1])
            currentRaidSize = 10
        elseif currentLegacyDiff == 4 or currentLegacyDiff == 6 then
            -- 25人模式 (4=25人普通, 6=25人英雄)
            UpdateButtonHighlight(raidSizeButtons, raidSizeButtons[2])
            currentRaidSize = 25
        elseif currentLegacyDiff == 16 then
            -- 史诗难度 (16=史诗，固定20人，不区分10/25人)
            UpdateButtonHighlight(raidSizeButtons, nil)
            currentRaidSize = 20
        end
    else
        -- 如果旧版没有设置
        if inGroup or inRaid then
            -- 在团队/队伍中，没有有效难度时清除人数按钮高亮
            UpdateButtonHighlight(raidSizeButtons, nil)
            currentRaidSize = 0
        else
            -- 单人时，如果没有有效难度也不显示高亮
            UpdateButtonHighlight(raidSizeButtons, nil)
            currentRaidSize = 0
        end
    end
    
    -- 确定当前难度（同时考虑两套系统）
    local difficultyMatched = false
    
    -- 优先使用旧版系统的难度
    if currentLegacyDiff > 0 then
        for i, btn in ipairs(raidButtons) do
            if btn.difficulty10 == currentLegacyDiff or btn.difficulty25 == currentLegacyDiff then
                UpdateButtonHighlight(raidButtons, btn)
                currentRaidDifficulty = currentLegacyDiff
                difficultyMatched = true
                break
            end
        end
    end
    
    -- 如果旧版系统没有匹配，检查现代系统
    if not difficultyMatched and currentModernDiff > 0 then
        if currentModernDiff == 14 then
            -- 现代普通难度
            UpdateButtonHighlight(raidButtons, raidButtons[1]) -- 普通
            currentRaidDifficulty = currentRaidSize == 10 and 3 or 4
            difficultyMatched = true
        elseif currentModernDiff == 15 then
            -- 现代英雄难度
            UpdateButtonHighlight(raidButtons, raidButtons[2]) -- 英雄
            currentRaidDifficulty = currentRaidSize == 10 and 5 or 6
            difficultyMatched = true
        elseif currentModernDiff == 16 then
            -- 现代史诗难度
            UpdateButtonHighlight(raidButtons, raidButtons[3]) -- 史诗
            currentRaidDifficulty = 16
            difficultyMatched = true
        end
    end
    
    -- 如果没有找到任何匹配的难度
    if not difficultyMatched then
        if inGroup or inRaid then
            -- 在团队/队伍中，没有有效难度时清除难度按钮高亮
            UpdateButtonHighlight(raidButtons, nil)
            currentRaidDifficulty = 0
        else
            -- 单人时，没有有效难度时清除所有难度按钮高亮
            UpdateButtonHighlight(raidButtons, nil)
            currentRaidDifficulty = 0
        end
    end
end

-- 地下城按钮点击事件
for i, btn in ipairs(dungeonButtons) do
    btn:SetScript("OnClick", function(self)
        if not CanChangeDifficulty() then
            -- 没有权限，恢复到当前实际状态
            print("你没有权限修改难度")
            UpdateButtonStates()
            return
        end
        
        -- 立即更新显示，避免被定时器干扰
        UpdateButtonHighlight(dungeonButtons, self)
        currentDungeonDifficulty = self.difficultyId
        
        -- 安全地设置难度，避免导致离开队伍
        if CanChangeDifficulty() then
            SetDungeonDifficultyID(self.difficultyId)
        end
    end)
end

-- 团本人数按钮点击事件
for i, btn in ipairs(raidSizeButtons) do
    btn:SetScript("OnClick", function(self)
        if not CanChangeDifficulty() then
            -- 没有权限，恢复到当前实际状态
            print("你没有权限修改难度")
            UpdateButtonStates()
            return
        end
        
        -- 首先检查团本难度，如果无效则设置默认值
        if not CheckRaidDifficultyValid() then
            -- 设置25人英雄作为默认值
            if SetLegacyRaidDifficultyID then
                SetLegacyRaidDifficultyID(6) -- 25人英雄
            end
            if SetRaidDifficultyID then
                SetRaidDifficultyID(15) -- 英雄难度
            end
        end
        
        currentRaidSize = self.raidSize
        UpdateButtonHighlight(raidSizeButtons, self)
        
        -- 获取当前难度状态，保持难度类型不变，只改变人数
        local currentLegacyDiff = GetLegacyRaidDifficultyID and GetLegacyRaidDifficultyID() or 0
        local currentModernDiff = GetRaidDifficultyID and GetRaidDifficultyID() or 0
        
        -- 根据当前难度类型（同时考虑新旧版本），设置对应人数的难度ID
        local newLegacyId, newModernId
        
        -- 判断当前难度类型（优先检查旧版，再检查现代版本）
        local isHeroic = false
        local isMythic = false
        
        if currentLegacyDiff > 0 then
            -- 旧版系统有效，用旧版判断
            if currentLegacyDiff == 5 or currentLegacyDiff == 6 then
                isHeroic = true
            elseif currentLegacyDiff == 16 then
                isMythic = true
            end
        else
            -- 旧版系统无效，用现代系统判断
            if currentModernDiff == 15 then
                isHeroic = true
            elseif currentModernDiff == 16 then
                isMythic = true
            end
        end
        
        -- 根据难度类型设置新的ID
        if isMythic then
            -- 史诗难度
            newLegacyId = 16
            newModernId = 16
        elseif isHeroic then
            -- 英雄难度
            newLegacyId = currentRaidSize == 10 and 5 or 6
            newModernId = 15
        else
            -- 普通难度（包括默认情况）
            newLegacyId = currentRaidSize == 10 and 3 or 4
            newModernId = 14
        end
        
        -- 先设置现代团本难度（只在需要改变时）
        if SetRaidDifficultyID and currentModernDiff ~= newModernId then
            SetRaidDifficultyID(newModernId)
        elseif SetRaidDifficultyID then
            -- 现代难度没有变化，打印调试信息确认当前状态
            local difficultyName = "未知"
            if newModernId == 14 then
                difficultyName = "普通"
            elseif newModernId == 15 then
                difficultyName = "英雄"
            elseif newModernId == 16 then
                difficultyName = "史诗"
            end
            print("当前团队副本难度保持为: " .. difficultyName)
        end
        
        -- 设置经典团本难度（总是设置，因为人数在变）
        if SetLegacyRaidDifficultyID then
            SetLegacyRaidDifficultyID(newLegacyId)
        end
    end)
end

-- 团本难度按钮点击事件
for i, btn in ipairs(raidButtons) do
    btn:SetScript("OnClick", function(self)
        if not CanChangeDifficulty() then
            -- 没有权限，恢复到当前实际状态
            print("你没有权限修改难度")
            UpdateButtonStates()
            return
        end
        
        -- 根据按钮文本确定难度类型
        local difficultyType = 14 -- 默认普通
        if self.textObj:GetText() == "英雄难度" then
            difficultyType = 15
        elseif self.textObj:GetText() == "史诗难度" then
            difficultyType = 16
        end
        
        -- 设置团本难度类型
        SetRaidDifficultyID(difficultyType)
        
        -- 设置旧版团本规模
        local legacyDifficultyId = currentRaidSize == 10 and self.difficulty10 or self.difficulty25
        if SetLegacyRaidDifficultyID then
            SetLegacyRaidDifficultyID(legacyDifficultyId)
        end
        
        currentRaidDifficulty = legacyDifficultyId
        UpdateButtonHighlight(raidButtons, self)
    end)
end

-- 初始化高亮状态 - 只在没有有效难度时设置默认值
local function InitializeHighlights()
    -- 检查当前游戏状态，如果有有效难度就使用，否则设置默认值
    local hasValidState = false
    
    -- 检查地下城难度
    if GetDungeonDifficultyID then
        local currentDungeonDiff = GetDungeonDifficultyID()
        if currentDungeonDiff then
            hasValidState = true
        else
            -- 只在无难度时设置默认地下城难度
            UpdateButtonHighlight(dungeonButtons, dungeonButtons[1])
        end
    end
    
    -- 检查旧版团本难度（优先）
    local hasValidLegacyRaid = false
    if GetLegacyRaidDifficultyID then
        local currentLegacyDiff = GetLegacyRaidDifficultyID()
        if currentLegacyDiff and currentLegacyDiff > 0 then
            hasValidState = true
            hasValidLegacyRaid = true
        end
    end
    
    -- 如果没有有效的旧版团本难度，设置默认为25人英雄并应用到游戏
    if not hasValidLegacyRaid then
        -- 同时设置新旧版本的25人英雄
        if SetLegacyRaidDifficultyID then
            SetLegacyRaidDifficultyID(6) -- 旧版25人英雄
        end
        if SetRaidDifficultyID then
            SetRaidDifficultyID(15) -- 现代英雄难度
        end
        -- 更新面板显示
        UpdateButtonHighlight(raidSizeButtons, raidSizeButtons[2]) -- 25人
        UpdateButtonHighlight(raidButtons, raidButtons[2]) -- 英雄
        currentRaidSize = 25
        currentRaidDifficulty = 6
    end
    
    -- 如果没有任何有效状态，设置所有默认值
    if not hasValidState then
        UpdateButtonHighlight(dungeonButtons, dungeonButtons[1])
        UpdateButtonHighlight(raidSizeButtons, raidSizeButtons[2])
        UpdateButtonHighlight(raidButtons, raidButtons[2])
    end
end



-- 现在设置刷新按钮的点击事件（在UpdateButtonStates函数定义之后）
refreshButton:SetScript("OnClick", function()
    -- 强制刷新缓存，重新获取难度
    lastUpdateState.dungeonDiff = nil
    lastUpdateState.legacyDiff = nil
    lastUpdateState.modernDiff = nil
    lastUpdateState.inGroup = nil
    lastUpdateState.inRaid = nil
    
    -- 静默刷新
    UpdateButtonStates()
    
    -- 隐藏刷新按钮和状态提示
    refreshButton:Hide()
    syncStatusLabel:SetText("")
end)

-- 切换界面显示/隐藏的斜杠命令
SLASH_CHANGEDIFFICULT1 = "/c"
function SlashCmdList.CHANGEDIFFICULT(msg)
    if frame:IsShown() then
        frame:Hide()
    else
        frame:Show()
    end
end

-- 定期检查难度状态变化的定时器
local lastKnownLegacyDiff = nil
local lastKnownModernDiff = nil
local lastKnownDungeonDiff = nil

local function CheckDifficultyChanges()
    local hasChanged = false
    local inGroup = IsInGroup()
    local inRaid = IsInRaid()
    
    -- 检查旧版团本难度
    if GetLegacyRaidDifficultyID then
        local currentLegacyDiff = GetLegacyRaidDifficultyID()
        if lastKnownLegacyDiff ~= currentLegacyDiff then
            lastKnownLegacyDiff = currentLegacyDiff
            hasChanged = true
            -- 静默处理难度变化
        end
    end
    
    -- 检查现代团本难度
    if GetRaidDifficultyID then
        local currentModernDiff = GetRaidDifficultyID()
        if lastKnownModernDiff ~= currentModernDiff then
            lastKnownModernDiff = currentModernDiff
            hasChanged = true
            -- 静默处理现代难度变化
        end
    end
    
    -- 检查地下城难度（但不在刚点击按钮时检查，避免冲突）
    if GetDungeonDifficultyID then
        local currentDungeonDiff = GetDungeonDifficultyID()
        if lastKnownDungeonDiff ~= currentDungeonDiff then
            lastKnownDungeonDiff = currentDungeonDiff
            -- 只有在不是玩家自己刚改变的情况下才标记为需要更新
            if currentDungeonDiff ~= currentDungeonDifficulty then
                hasChanged = true
                -- 静默处理地下城难度变化
            end
        end
    end
    
    -- 如果任何难度发生变化，更新按钮状态
    if hasChanged then
        UpdateButtonStates()
    end
end

-- 插件加载时初始化
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("GROUP_FORMED")
frame:RegisterEvent("GROUP_LEFT")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("GUILD_PARTY_STATE_UPDATED")
frame:RegisterEvent("UPDATE_INSTANCE_INFO")
-- 添加更多队伍相关事件来检测难度同步
frame:RegisterEvent("PARTY_LEADER_CHANGED")
frame:RegisterEvent("GROUP_JOINED")
frame:RegisterEvent("RAID_INSTANCE_WELCOME")
frame:SetScript("OnEvent", function(self, event, addonName)
    if event == "ADDON_LOADED" and addonName == "OrzUI" then
        -- 先尝试读取当前游戏状态
        C_Timer.After(0.1, function()
            UpdateButtonStates()
            -- 如果没有有效状态，才使用默认值
            InitializeHighlights()
            
            -- 检查是否在副本内
            local inInstance, instanceType = IsInInstance()
            if inInstance and (instanceType == "party" or instanceType == "raid") then
                -- 在副本内，使用收缩模式
                SetCollapsedMode(true)
                wasInInstance = true
            else
                -- 不在副本内，使用展开模式
                SetCollapsedMode(false)
                wasInInstance = false
            end
        end)
        -- 默认显示界面
        frame:Show()
        -- 启动定时器检查难度变化
        C_Timer.NewTicker(0.5, CheckDifficultyChanges)
    elseif event == "PLAYER_DIFFICULTY_CHANGED" or event == "PLAYER_ENTERING_WORLD" then
        -- 延迟更新状态，确保游戏状态已更新
        C_Timer.After(0.1, UpdateButtonStates)
    elseif event == "GROUP_FORMED" or event == "GROUP_LEFT" or event == "GROUP_ROSTER_UPDATE" then
        -- 组队状态变化，延迟更新按钮状态，确保游戏状态已同步
        C_Timer.After(0.1, UpdateButtonStates)
    elseif event == "PARTY_LEADER_CHANGED" then
        -- 队长变化，可能影响难度同步，延迟更新
        C_Timer.After(0.2, UpdateButtonStates)
    elseif event == "GROUP_JOINED" then
        -- 加入队伍，延迟更新以等待难度同步
        C_Timer.After(0.5, UpdateButtonStates)
    elseif event == "GUILD_PARTY_STATE_UPDATED" or event == "UPDATE_INSTANCE_INFO" or event == "RAID_INSTANCE_WELCOME" then
        -- 团队难度或实例信息更新，立即更新按钮状态
        UpdateButtonStates()
    elseif event == "ZONE_CHANGED_NEW_AREA" then
        -- 检查副本状态变化
        local inInstance, instanceType = IsInInstance()
        
        if wasInInstance and not inInstance then
            -- 刚刚离开副本，展开界面
            frame:Show()
            SetCollapsedMode(false)
        elseif inInstance and (instanceType == "party" or instanceType == "raid") then
            -- 进入副本时，收缩界面并显示难度信息
            frame:Show()
            SetCollapsedMode(true)
            
            -- 延迟获取副本信息并在屏幕中央显示
            C_Timer.After(0.5, function()
                local _, _, difficultyID, difficultyName = GetInstanceInfo()
                local displayText = ""
                
                
                if instanceType == "party" then
                    -- 地下城显示为 "5人XX本"
                    if difficultyID == 1 then
                        displayText = "5人普通本"
                    elseif difficultyID == 2 then
                        displayText = "5人英雄本"
                    elseif difficultyID == 23 then
                        displayText = "5人史诗本"
                    else
                        displayText = difficultyName and ("5人" .. difficultyName) or "5人地下城"
                    end
                elseif instanceType == "raid" then
                    -- 团本根据难度ID判断类型和人数
                    if difficultyID == 3 then
                        displayText = "10人普通团本"
                    elseif difficultyID == 4 then
                        displayText = "25人普通团本"
                    elseif difficultyID == 5 then
                        displayText = "10人英雄团本"
                    elseif difficultyID == 6 then
                        displayText = "25人英雄团本"
                    elseif difficultyID == 14 then
                        displayText = "普通团本"
                    elseif difficultyID == 15 then
                        displayText = "英雄团本"
                    elseif difficultyID == 16 then
                        displayText = "史诗团本"
                    else
                        displayText = difficultyName and (difficultyName .. "团本") or "团本"
                    end
                end
                
                -- 在屏幕中央显示难度信息
                if displayText ~= "" then
                    ShowDifficultyInCenter(displayText)
                end
            end)
        end
        
        -- 更新副本状态
        wasInInstance = inInstance
    end
end)