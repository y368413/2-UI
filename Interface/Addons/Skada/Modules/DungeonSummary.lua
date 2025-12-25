-- ==================================================================================================================== --
-- Skada 地下城统计模块 - 在地下城结束后自动弹出美观的统计窗口
-- ==================================================================================================================== --

local Skada = Skada
local mod = Skada:NewModule("地下城统计", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Skada", false)

-- 模块名称
function mod:GetName()
    return "地下城统计"
end

-- 模块描述
function mod:GetDescription()
    return "地下城结束后显示队伍统计信息"
end

-- 模块变量
local dungeonData = {}
local isInDungeon = false
local dungeonStartTime = 0
local dungeonEndTime = 0
local summaryFrame = nil

-- 全局表头定义
local headers = {"排名", "职业", "姓名", "装等", "总伤害", "DPS", "承受伤害", "治疗量", "死亡", "打断", "驱散", "控制"}

-- 职业颜色映射
local classColors = {
    ["WARRIOR"] = "|cFFC79C6E",
    ["PALADIN"] = "|cFFF58CBA", 
    ["HUNTER"] = "|cFFABD473",
    ["ROGUE"] = "|cFFFFF569",
    ["PRIEST"] = "|cFFFFFFFF",
    ["DEATHKNIGHT"] = "|cFFC41F3B",
    ["SHAMAN"] = "|cFF0070DE",
    ["MAGE"] = "|cFF69CCF0",
    ["WARLOCK"] = "|cFF9482C9",
    ["MONK"] = "|cFF00FF96",
    ["DRUID"] = "|cFFFF7D0A",
    ["DEMONHUNTER"] = "|cFFA330C9",
    ["EVOKER"] = "|cFF33937F"
}

-- 职业图标坐标
local class_icon_tcoords = {
    ["WARRIOR"] = {0, 0.25, 0, 0.25},
    ["MAGE"] = {0.25, 0.49609375, 0, 0.25},
    ["ROGUE"] = {0.49609375, 0.7421875, 0, 0.25},
    ["DRUID"] = {0.7421875, 0.98828125, 0, 0.25},
    ["HUNTER"] = {0, 0.25, 0.25, 0.5},
    ["SHAMAN"] = {0.25, 0.49609375, 0.25, 0.5},
    ["PRIEST"] = {0.49609375, 0.7421875, 0.25, 0.5},
    ["WARLOCK"] = {0.7421875, 0.98828125, 0.25, 0.5},
    ["PALADIN"] = {0, 0.25, 0.5, 0.75},
    ["DEATHKNIGHT"] = {0.25, 0.49609375, 0.5, 0.75},
    ["MONK"] = {0.49609375, 0.7421875, 0.5, 0.75},
    ["DEMONHUNTER"] = {0.7421875, 0.98828125, 0.5, 0.75},
    ["EVOKER"] = {0, 0.25, 0.75, 1.0}
}

-- 职责图标坐标（只显示输出、坦克、治疗）
local role_icon_tcoords = {
    ["DAMAGER"] = {0.3125, 0.625, 0.3125, 0.625},
    ["HEALER"] = {0.3125, 0.625, 0.015625, 0.3125},
    ["TANK"] = {0, 0.296875, 0.3125, 0.625}
}

-- 创建职业图标
local function CreateClassIcon(parent, class, size)
    local icon = parent:CreateTexture(nil, "OVERLAY")
    icon:SetSize(size or 16, size or 16)
    icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
    
    if class_icon_tcoords[class] then
        local coords = class_icon_tcoords[class]
        icon:SetTexCoord(coords[1], coords[2], coords[3], coords[4])
    end
    
    return icon
end

-- 创建职责图标
local function CreateRoleIcon(parent, role, size)
    local icon = parent:CreateTexture(nil, "HIGHLIGHT")
    icon:SetSize(size or 16, size or 16)
    icon:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES")
    
    if role_icon_tcoords[role] then
        local coords = role_icon_tcoords[role]
        icon:SetTexCoord(coords[1], coords[2], coords[3], coords[4])
    end
    
    return icon
end

-- 获取职业中文名称（保留用于调试）
local function GetClassNameCN(englishClass)
    local classNames = {
        ["WARRIOR"] = "战士",
        ["PALADIN"] = "圣骑士",
        ["HUNTER"] = "猎人", 
        ["ROGUE"] = "潜行者",
        ["PRIEST"] = "牧师",
        ["DEATHKNIGHT"] = "死亡骑士",
        ["SHAMAN"] = "萨满祭司",
        ["MAGE"] = "法师",
        ["WARLOCK"] = "术士",
        ["MONK"] = "武僧",
        ["DRUID"] = "德鲁伊",
        ["DEMONHUNTER"] = "恶魔猎手",
        ["EVOKER"] = "唤魔师"
    }
    return classNames[englishClass] or englishClass
end

-- 获取玩家专精信息
local function GetPlayerSpecInfo(playerName, playerGUID)
    -- 如果是自己，直接获取当前专精
    if playerName == UnitName("player") then
        local specIndex = GetSpecialization()
        if specIndex then
            local specID, specName, _, specIcon = GetSpecializationInfo(specIndex)
            return specID, specName, specIcon
        end
    end
    

    
    -- 尝试从缓存获取专精信息
    if Skada and Skada.char and Skada.char.cached_specs and playerGUID then
        local specID = Skada.char.cached_specs[playerGUID]
        if specID then
            local specName, _, specIcon = GetSpecializationInfoByID(specID)
            return specID, specName, specIcon
        end
    end
    
    return nil, nil, nil
end

-- 创建专精图标
local function CreateSpecIcon(parent, specIcon, size)
    if not specIcon then return nil end
    
    local icon = parent:CreateTexture(nil, "OVERLAY")
    icon:SetSize(size or 16, size or 16)
    icon:SetTexture(specIcon)
    icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    
    return icon
end

-- 缓存装等数据
local itemLevelCache = {}
local lastInspectTime = {}

-- 获取玩家装备等级
local function GetPlayerItemLevel(playerName, unit)
    if playerName == UnitName("player") then
        -- 获取自己的装等
        local totalItemLevel = 0
        local itemCount = 0
        for i = 1, 18 do
            if i ~= 4 then -- 跳过衬衣槽位
                local itemLink = GetInventoryItemLink("player", i)
                if itemLink then
                    local itemLevel = GetDetailedItemLevelInfo(itemLink)
                    if itemLevel and itemLevel > 0 then
                        totalItemLevel = totalItemLevel + itemLevel
                        itemCount = itemCount + 1
                    end
                end
            end
        end
        local avgItemLevel = itemCount > 0 and math.floor(totalItemLevel / itemCount) or 0
        itemLevelCache[playerName] = avgItemLevel
        return avgItemLevel
    else
        -- 检查缓存
        if itemLevelCache[playerName] then
            return itemLevelCache[playerName]
        end
        
        -- 尝试多种方式获取装等
        local itemLevel = 0
        
        -- 方式1：通过检查获取
        if unit and UnitIsPlayer(unit) and CanInspect(unit) then
            local currentTime = GetTime()
            if not lastInspectTime[playerName] or (currentTime - lastInspectTime[playerName]) > 2 then
                lastInspectTime[playerName] = currentTime
                NotifyInspect(unit)
                
                -- 延迟获取检查结果
                C_Timer.After(0.5, function()
                    local totalItemLevel = 0
                    local itemCount = 0
                    for i = 1, 18 do
                        if i ~= 4 then -- 跳过衬衣槽位
                            local itemLink = GetInventoryItemLink(unit, i)
                            if itemLink then
                                local iLevel = GetDetailedItemLevelInfo(itemLink)
                                if iLevel and iLevel > 0 then
                                    totalItemLevel = totalItemLevel + iLevel
                                    itemCount = itemCount + 1
                                end
                            end
                        end
                    end
                    if itemCount > 0 then
                        itemLevelCache[playerName] = math.floor(totalItemLevel / itemCount)
                    end
                end)
            end
        end
        
        -- 方式2：尝试从团队框架获取
        if itemLevel == 0 and IsInGroup() then
            for i = 1, GetNumGroupMembers() do
                local name = GetRaidRosterInfo(i)
                if name == playerName then
                    -- 这里可以添加更多获取方式
                    break
                end
            end
        end
        
        -- 方式3：从缓存或默认值
        itemLevel = itemLevelCache[playerName] or 0
        
        return itemLevel
    end
end

-- 收集队伍成员数据
local function CollectGroupData()
    local groupData = {}
    local groupSize = GetNumGroupMembers()
    
    if groupSize == 0 then
        groupSize = 1
    end
    
    for i = 1, groupSize do
        local unit = (groupSize == 1) and "player" or ("party" .. (i - 1))
        if i == 1 and groupSize > 1 then
            unit = "player"
        end
        
        if UnitExists(unit) then
            local name = UnitName(unit)
            local _, class = UnitClass(unit)
            local itemLevel = GetPlayerItemLevel(name, unit)
            local role = UnitGroupRolesAssigned(unit) or "DAMAGER"
            
            -- 从Skada数据中获取统计信息
            local playerData = {
                name = name,
                class = class,
                classNameCN = GetClassNameCN(class),
                role = role,
                itemLevel = itemLevel,
                damage = 0,
                dps = 0,
                damageTaken = 0,
                healing = 0,
                deaths = 0,
                interrupts = 0,
                dispels = 0,
                controls = 0
            }
            
            -- 优先从总计数据集获取数据，确保显示的是整个地下城期间的完整统计
            local dataFound = false
            local targetSet = nil
            
            -- 优先使用总计数据集来获取整个地下城期间的完整统计
            if Skada.total and Skada.total.players and next(Skada.total.players) then
            targetSet = Skada.total
        elseif Skada.current and Skada.current.players and next(Skada.current.players) then
            -- 如果没有总计数据集，才使用当前数据集
            targetSet = Skada.current
        end
            
            if targetSet and targetSet.players then
                for guid, skadaPlayer in pairs(targetSet.players) do
                    if skadaPlayer.name == name then
                        dataFound = true
                        
                        -- 伤害和DPS
                        playerData.damage = skadaPlayer.damage or 0
                        
                        -- 直接使用Skada的DPS计算函数
                        local function getDPS(set, player)
                            local totaltime = Skada:PlayerActiveTime(set, player)
                            return player.damage / math.max(1, totaltime)
                        end
                        
                        playerData.dps = getDPS(targetSet, skadaPlayer)
                        
                        -- 承受伤害
                        playerData.damageTaken = skadaPlayer.damagetaken or 0
                        
                        -- 治疗量
                        playerData.healing = skadaPlayer.healing or 0
                        
                        -- 死亡次数 - 统计整个地下城期间的死亡次数
                        if skadaPlayer.deaths and type(skadaPlayer.deaths) == "table" then
                            playerData.deaths = #skadaPlayer.deaths
                        elseif skadaPlayer.deaths and type(skadaPlayer.deaths) == "number" then
                            playerData.deaths = skadaPlayer.deaths
                        else
                            playerData.deaths = 0
                        end
                        
                        -- 打断次数 (优先使用total数据集获取整个地下城的统计)
                        local totalPlayer = nil
                        if Skada.total and Skada.total.players then
                            for _, p in pairs(Skada.total.players) do
                                if p.id == skadaPlayer.id then
                                    totalPlayer = p
                                    break
                                end
                            end
                        end
                        
                        if totalPlayer then
                            playerData.interrupts = totalPlayer.interrupts or 0
                            playerData.dispels = totalPlayer.dispels or 0
                            playerData.controls = totalPlayer.ccbreaks or 0
                        else
                            -- 备选方案：使用当前数据集
                            playerData.interrupts = skadaPlayer.interrupts or 0
                            playerData.dispels = skadaPlayer.dispels or 0
                            playerData.controls = skadaPlayer.ccbreaks or 0
                        end
                        
                        break
                    end
                end
            end
            

            
            table.insert(groupData, playerData)
        end
    end
    
    -- 按伤害降序排序
    table.sort(groupData, function(a, b)
        return a.damage > b.damage
    end)
    
    return groupData
end

-- 创建暴雪风格统计界面
local function CreateSummaryFrame()
    if summaryFrame then
        summaryFrame:Hide()
        summaryFrame = nil
    end
    
    -- 创建主框架
    summaryFrame = CreateFrame("Frame", "SkadaDungeonSummary", UIParent)
    summaryFrame:SetSize(1024, 380)
    summaryFrame:SetPoint("CENTER")
    summaryFrame:SetMovable(true)
    summaryFrame:EnableMouse(true)
    summaryFrame:RegisterForDrag("LeftButton")
    summaryFrame:SetScript("OnDragStart", summaryFrame.StartMoving)
    summaryFrame:SetScript("OnDragStop", summaryFrame.StopMovingOrSizing)
    summaryFrame:SetFrameStrata("HIGH")
    
    -- 主背景（15%半透明黑色，最底层）
    local mainBg = summaryFrame:CreateTexture(nil, "BACKGROUND")
    mainBg:SetAllPoints(summaryFrame)
    mainBg:SetColorTexture(0, 0, 0, 0.15)
    
    -- 半透明边框
    local border = summaryFrame:CreateTexture(nil, "BORDER")
    border:SetPoint("TOPLEFT", summaryFrame, "TOPLEFT", -1, 1)
    border:SetPoint("BOTTOMRIGHT", summaryFrame, "BOTTOMRIGHT", 1, -1)
    border:SetColorTexture(0, 0, 0, 0.3)
    
    -- 标题区域背景（20%半透明黑色，第二层）- 调整高度适应超大数字
    local titleBg = summaryFrame:CreateTexture(nil, "ARTWORK")
    titleBg:SetPoint("TOPLEFT", summaryFrame, "TOPLEFT", 15, -15)
    titleBg:SetPoint("TOPRIGHT", summaryFrame, "TOPRIGHT", -15, -15)
    titleBg:SetHeight(70)  -- 增加高度适应超大数字
    titleBg:SetColorTexture(0, 0, 0, 0.2)
    
    -- 标题区域半透明边框
    local titleBorder = summaryFrame:CreateTexture(nil, "BORDER")
    titleBorder:SetPoint("TOPLEFT", titleBg, "TOPLEFT", -1, 1)
    titleBorder:SetPoint("BOTTOMRIGHT", titleBg, "BOTTOMRIGHT", 1, -1)
    titleBorder:SetColorTexture(0, 0, 0, 0.25)
    
    -- 获取当前地下城名称和钥匙层数
    local instanceName = GetInstanceInfo()
    local keystoneLevel = nil
    
    -- 尝试获取钥匙层数
    if C_ChallengeMode and C_ChallengeMode.GetActiveKeystoneInfo then
        local activeKeystoneLevel = C_ChallengeMode.GetActiveKeystoneInfo()
        if activeKeystoneLevel and activeKeystoneLevel > 0 then
            keystoneLevel = activeKeystoneLevel
        end
    end
    
    if keystoneLevel and keystoneLevel > 0 then
        -- 大秘境模式：显示地下城名称和超大层数
        
        -- 超大层数显示（居中显示）
        summaryFrame.keystoneLevel = summaryFrame:CreateFontString(nil, "OVERLAY")
        summaryFrame.keystoneLevel:SetFont("Fonts\\FRIZQT__.TTF", 42, "OUTLINE")
        summaryFrame.keystoneLevel:SetPoint("CENTER", titleBg, "CENTER", 0, 0)
        summaryFrame.keystoneLevel:SetText("|cFFFF6600" .. keystoneLevel .. "|r")
        summaryFrame.keystoneLevel:SetShadowOffset(2, -2)
        summaryFrame.keystoneLevel:SetShadowColor(0, 0, 0, 1)
        
        -- 地下城名称（右对齐，位于超大层数左侧）
        summaryFrame.title = summaryFrame:CreateFontString(nil, "OVERLAY")
        summaryFrame.title:SetFontObject("GameFontNormalLarge")
        summaryFrame.title:SetPoint("RIGHT", summaryFrame.keystoneLevel, "LEFT", -25, 0)
        summaryFrame.title:SetText("|cFFFFD700" .. (instanceName or "大秘境地下城") .. "|r")
        summaryFrame.title:SetShadowOffset(1, -1)
        summaryFrame.title:SetShadowColor(0, 0, 0, 1)
        
        -- 获取大秘境完成信息
        local completionInfo = nil
        if C_ChallengeMode and C_ChallengeMode.GetCompletionInfo then
            local mapID, level, time, onTime, keystoneUpgradeLevels, practiceRun = C_ChallengeMode.GetCompletionInfo()
            if mapID and level and time and keystoneUpgradeLevels then
                completionInfo = {
                    level = level,
                    time = time,
                    onTime = onTime,
                    upgradeLevels = keystoneUpgradeLevels
                }
            end
        end
        
        -- 显示层数提升和完成时间（在超大层数右侧）
        if completionInfo then
            -- 层数提升显示（超大数字右侧）
            summaryFrame.upgradeInfo = summaryFrame:CreateFontString(nil, "OVERLAY")
            summaryFrame.upgradeInfo:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
            summaryFrame.upgradeInfo:SetPoint("LEFT", summaryFrame.keystoneLevel, "RIGHT", 25, 0)
            
            local upgradeColor = "|cFFFFD700"
            if completionInfo.upgradeLevels >= 3 then
                upgradeColor = "|cFF00FF00"  -- 绿色：3层提升
            elseif completionInfo.upgradeLevels >= 2 then
                upgradeColor = "|cFFFFD700"  -- 金色：2层提升
            elseif completionInfo.upgradeLevels >= 1 then
                upgradeColor = "|cFFFFFFFF"  -- 白色：1层提升
            else
                upgradeColor = "|cFFFF0000"  -- 红色：无提升
            end
            
            summaryFrame.upgradeInfo:SetText(upgradeColor .. "+" .. completionInfo.upgradeLevels .. "|r")
            summaryFrame.upgradeInfo:SetShadowOffset(1, -1)
            summaryFrame.upgradeInfo:SetShadowColor(0, 0, 0, 1)
            
            -- 完成时间显示（层数提升右侧）
            summaryFrame.completionTime = summaryFrame:CreateFontString(nil, "OVERLAY")
            summaryFrame.completionTime:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
            summaryFrame.completionTime:SetPoint("LEFT", summaryFrame.upgradeInfo, "RIGHT", 15, 0)
            
            local minutes = math.floor(completionInfo.time / 60000)
            local seconds = math.floor((completionInfo.time % 60000) / 1000)
            local timeColor = completionInfo.onTime and "|cFF00FF00" or "|cFFFF0000"
            summaryFrame.completionTime:SetText(timeColor .. string.format("%d:%02d", minutes, seconds) .. "|r")
            summaryFrame.completionTime:SetShadowOffset(1, -1)
            summaryFrame.completionTime:SetShadowColor(0, 0, 0, 1)
        end
        
    else
        -- 普通地下城模式：传统显示
        summaryFrame.title = summaryFrame:CreateFontString(nil, "OVERLAY")
        summaryFrame.title:SetFontObject("GameFontNormalHuge")
        summaryFrame.title:SetPoint("CENTER", titleBg, "CENTER", 0, 0)
        
        if instanceName and instanceName ~= "" then
            summaryFrame.title:SetText("|cFFFFD700" .. instanceName .. "|r")
        else
            summaryFrame.title:SetText("|cFFFFD700地下城统计报告|r")
        end
        
        summaryFrame.title:SetShadowOffset(2, -2)
        summaryFrame.title:SetShadowColor(0, 0, 0, 1)
    end
    
    -- 关闭按钮
    local closeBtn = CreateFrame("Button", nil, summaryFrame)
    closeBtn:SetSize(32, 32)
    closeBtn:SetPoint("TOPRIGHT", summaryFrame, "TOPRIGHT", -20, -20)
    
    -- 关闭按钮背景（35%半透明黑色，第三层）
    local closeBg = closeBtn:CreateTexture(nil, "BACKGROUND")
    closeBg:SetAllPoints(closeBtn)
    closeBg:SetColorTexture(0, 0, 0, 0.15)
    
    -- 关闭按钮半透明边框
    local closeBorder = closeBtn:CreateTexture(nil, "BORDER")
    closeBorder:SetPoint("TOPLEFT", closeBtn, "TOPLEFT", -1, 1)
    closeBorder:SetPoint("BOTTOMRIGHT", closeBtn, "BOTTOMRIGHT", 1, -1)
    closeBorder:SetColorTexture(0, 0, 0, 0.5)
    
    local closeText = closeBtn:CreateFontString(nil, "OVERLAY")
    closeText:SetFontObject("GameFontNormalLarge")
    closeText:SetPoint("CENTER")
    closeText:SetText("X")
    closeText:SetTextColor(1, 1, 1)
    
    closeBtn:SetScript("OnClick", function()
        summaryFrame:Hide()
    end)
    
    closeBtn:SetScript("OnEnter", function()
        closeBg:SetColorTexture(0.4, 0.1, 0.1, 0.6)
    end)
    
    closeBtn:SetScript("OnLeave", function()
        closeBg:SetColorTexture(0, 0, 0, 0.35)
    end)
    
    summaryFrame.closeBtn = closeBtn
    
    return summaryFrame
end

-- 显示统计数据
local function ShowDungeonSummary()
    local groupData = CollectGroupData()
    
    if #groupData == 0 then
        return
    end
    
    local frame = CreateSummaryFrame()
    
    -- 10%半透明黑色背景
    local dataBg = frame:CreateTexture(nil, "ARTWORK")
    dataBg:SetPoint("TOPLEFT", frame, "TOPLEFT", 25, -90)
    dataBg:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -25, 25)
    dataBg:SetColorTexture(0, 0, 0, 0.1)
    
    -- 半透明边框
    local border = frame:CreateTexture(nil, "OVERLAY")
    border:SetPoint("TOPLEFT", dataBg, "TOPLEFT", -1, 1)
    border:SetPoint("BOTTOMRIGHT", dataBg, "BOTTOMRIGHT", 1, -1)
    border:SetColorTexture(0, 0, 0, 0.2)
    border:SetDrawLayer("OVERLAY", -1)
    
    -- 表头设置
    local headerHeight = 40
    local rowHeight = 45
    local startY = -100
    local yOffset = startY
    
    -- 表头背景（10%半透明黑色，第四层）
    local headerBg = frame:CreateTexture(nil, "OVERLAY")
    headerBg:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, yOffset)
    headerBg:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -30, yOffset)
    headerBg:SetHeight(headerHeight)
    headerBg:SetColorTexture(0, 0, 0, 0.1)
    
    -- 表头半透明边框
    local headerBorder = frame:CreateTexture(nil, "OVERLAY")
    headerBorder:SetPoint("TOPLEFT", headerBg, "TOPLEFT", -1, 1)
    headerBorder:SetPoint("BOTTOMRIGHT", headerBg, "BOTTOMRIGHT", 1, -1)
    headerBorder:SetColorTexture(0, 0, 0, 0.3)
    headerBorder:SetDrawLayer("OVERLAY", -1)
    
    -- 表头文字
    local headerWidths = {60, 60, 140, 70, 90, 80, 100, 100, 50, 60, 50, 50}
    local xPos = 40
    
    for i, header in ipairs(headers) do
        local headerText = frame:CreateFontString(nil, "OVERLAY")
        headerText:SetFontObject("GameFontNormalLarge")
        if i >= 2 and i <= 12 then -- 数值列居中显示
            headerText:SetPoint("CENTER", frame, "TOPLEFT", xPos + (headerWidths[i] / 2), yOffset - 20)
        else
            headerText:SetPoint("LEFT", frame, "TOPLEFT", xPos + 5, yOffset - 20)
        end
        headerText:SetText("|cFFFFD700" .. header .. "|r")
        headerText:SetShadowOffset(2, -2)
        headerText:SetShadowColor(0, 0, 0, 1)
        xPos = xPos + headerWidths[i]
    end
    
    yOffset = yOffset - headerHeight
    
    -- 计算各类数据的最高值
    local maxValues = {
        damage = 0,
        dps = 0,
        damageTaken = 0,
        healing = 0,
        interrupts = 0,
        dispels = 0,
        controls = 0
    }
    
    for _, playerData in ipairs(groupData) do
        if playerData.damage and playerData.damage > maxValues.damage then
            maxValues.damage = playerData.damage
        end
        if playerData.dps and playerData.dps > maxValues.dps then
            maxValues.dps = playerData.dps
        end
        if playerData.damageTaken and playerData.damageTaken > maxValues.damageTaken then
            maxValues.damageTaken = playerData.damageTaken
        end
        if playerData.healing and playerData.healing > maxValues.healing then
            maxValues.healing = playerData.healing
        end
        if playerData.interrupts and playerData.interrupts > maxValues.interrupts then
            maxValues.interrupts = playerData.interrupts
        end
        if playerData.dispels and playerData.dispels > maxValues.dispels then
            maxValues.dispels = playerData.dispels
        end
        if playerData.controls and playerData.controls > maxValues.controls then
            maxValues.controls = playerData.controls
        end
    end
    
    -- 显示玩家数据
    for rank, playerData in ipairs(groupData) do
        -- 行背景（15%半透明黑色，第五层）
        local rowBg = frame:CreateTexture(nil, "ARTWORK")
        rowBg:SetColorTexture(0, 0, 0, 0.15)
        rowBg:SetPoint("TOPLEFT", frame, "TOPLEFT", 30, yOffset)
        rowBg:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -30, yOffset)
        rowBg:SetHeight(rowHeight)
        
        -- 行半透明边框
        local rowBorder = frame:CreateTexture(nil, "BORDER")
        rowBorder:SetPoint("TOPLEFT", rowBg, "TOPLEFT", -1, 1)
        rowBorder:SetPoint("BOTTOMRIGHT", rowBg, "BOTTOMRIGHT", 1, -1)
        rowBorder:SetColorTexture(0, 0, 0, 0.25)
        

        
        -- 数据文字（除了职业列）
        local dataTexts = {
            tostring(rank),
            "", -- 职业列用图标代替
            playerData.name,
            tostring(playerData.itemLevel),
            Skada:FormatNumber(playerData.damage), -- 总伤害
            Skada:FormatNumber(playerData.dps),
            Skada:FormatNumber(playerData.damageTaken),
            Skada:FormatNumber(playerData.healing),
            tostring(playerData.deaths),
            tostring(playerData.interrupts),
            tostring(playerData.dispels),
            tostring(playerData.controls)
        }
        
        xPos = 40
        for i, data in ipairs(dataTexts) do
            if i == 2 then -- 职业/职责列显示图标
                -- 计算图标在行中的垂直居中位置
                local iconCenterY = yOffset - (rowHeight / 2)
                
                -- 创建职业图标（32x32，更大更清晰）
                local classIcon = CreateClassIcon(frame, playerData.class, 32)
                classIcon:SetPoint("CENTER", frame, "TOPLEFT", xPos + 30, iconCenterY)
                
                -- 创建职责图标（16x16，位于职业图标右下角）
                local roleIcon = CreateRoleIcon(frame, playerData.role, 16)
                roleIcon:SetPoint("CENTER", classIcon, "BOTTOMRIGHT", -4, 4)
                
                xPos = xPos + headerWidths[i]
            else
                -- 计算文字在行中的垂直居中位置
                local textCenterY = yOffset - (rowHeight / 2)
                
                local dataText = frame:CreateFontString(nil, "OVERLAY")
                dataText:SetFontObject("GameFontNormal")
                if i >= 5 and i <= 12 then -- 数值列居中对齐
                    dataText:SetPoint("CENTER", frame, "TOPLEFT", xPos + (headerWidths[i] / 2), textCenterY)
                else
                    dataText:SetPoint("LEFT", frame, "TOPLEFT", xPos + 5, textCenterY)
                end
                dataText:SetShadowOffset(2, -2)
                dataText:SetShadowColor(0, 0, 0, 1)
                
                if i == 3 then -- 玩家姓名使用职业颜色并添加专精图标
                    local colorCode = classColors[playerData.class] or "|cFFFFFFFF"
                    
                    -- 添加专精图标在姓名前方
                    local specID, specName, specIcon = GetPlayerSpecInfo(playerData.name, playerData.guid)
                    if specIcon then
                        local specIconTexture = CreateSpecIcon(frame, specIcon, 24)
                        if specIconTexture then
                            -- 将专精图标放在姓名文字的左侧
                            specIconTexture:SetPoint("LEFT", frame, "TOPLEFT", xPos + 5, textCenterY)
                            -- 调整姓名文字位置，为专精图标留出空间
                            dataText:SetPoint("LEFT", frame, "TOPLEFT", xPos + 33, textCenterY)
                        end
                    end
                    
                    dataText:SetText(colorCode .. data .. "|r")
                elseif i == 1 and rank <= 3 then -- 前三名排名特殊显示
                    local rankColors = {"|cFFFFD700", "|cFFC0C0C0", "|cFFCD7F32"}
                    local rankSymbols = {"★", "◆", "▲"}
                    dataText:SetText(rankColors[rank] .. rankSymbols[rank] .. " " .. data .. "|r")
                elseif i == 5 then -- 总伤害高亮（橙红色，最高值用金色）
                    if playerData.damage == maxValues.damage and maxValues.damage > 0 then
                        dataText:SetText("|cFFFFD700" .. data .. "|r") -- 金色最高值
                    else
                        dataText:SetText("|cFFFF6644" .. data .. "|r")
                    end
                elseif i == 6 then -- DPS高亮（红色，最高值用金色）
                    if playerData.dps == maxValues.dps and maxValues.dps > 0 then
                        dataText:SetText("|cFFFFD700" .. data .. "|r") -- 金色最高值
                    else
                        dataText:SetText("|cFFFF4444" .. data .. "|r")
                    end
                elseif i == 7 then -- 承受伤害高亮（橙色，最高值用金色）
                    if playerData.damageTaken == maxValues.damageTaken and maxValues.damageTaken > 0 then
                        dataText:SetText("|cFFFFD700" .. data .. "|r") -- 金色最高值
                    else
                        dataText:SetText("|cFFFF8800" .. data .. "|r")
                    end
                elseif i == 8 then -- 治疗量高亮（绿色，最高值用金色）
                    if playerData.healing == maxValues.healing and maxValues.healing > 0 then
                        dataText:SetText("|cFFFFD700" .. data .. "|r") -- 金色最高值
                    else
                        dataText:SetText("|cFF00FF88" .. data .. "|r")
                    end
                elseif i == 9 and tonumber(playerData.deaths) > 0 then -- 死亡警告（深红色）
                    dataText:SetText("|cFFFF0000" .. data .. "|r")
                elseif i == 10 and tonumber(playerData.interrupts) > 0 then -- 打断显示（亮绿色，最高值用金色）
                    if playerData.interrupts == maxValues.interrupts and maxValues.interrupts > 0 then
                        dataText:SetText("|cFFFFD700" .. data .. "|r") -- 金色最高值
                    else
                        dataText:SetText("|cFF00FF00" .. data .. "|r")
                    end
                elseif i == 11 and tonumber(playerData.dispels) > 0 then -- 驱散显示（蓝色，最高值用金色）
                    if playerData.dispels == maxValues.dispels and maxValues.dispels > 0 then
                        dataText:SetText("|cFFFFD700" .. data .. "|r") -- 金色最高值
                    else
                        dataText:SetText("|cFF4488FF" .. data .. "|r")
                    end
                elseif i == 12 and tonumber(playerData.controls) > 0 then -- 控制显示（紫色，最高值用金色）
                    if playerData.controls == maxValues.controls and maxValues.controls > 0 then
                        dataText:SetText("|cFFFFD700" .. data .. "|r") -- 金色最高值
                    else
                        dataText:SetText("|cFFAA44FF" .. data .. "|r")
                    end
                else
                    dataText:SetText("|cFFCCCCCC" .. data .. "|r")
                end
                
                xPos = xPos + headerWidths[i]
            end
        end
        
        yOffset = yOffset - rowHeight
    end
    

    
    frame:Show()
end

-- 将ShowDungeonSummary函数暴露给模块
function mod:ShowDungeonSummary()
    ShowDungeonSummary()
end







-- 检查完成事件处理
local function OnInspectReady(event, guid)
    local unit = nil
    for i = 1, GetNumGroupMembers() do
        local checkUnit = (i == 1) and "player" or ("party" .. (i - 1))
        if UnitGUID(checkUnit) == guid then
            unit = checkUnit
            break
        end
    end
    
    if unit then
        local playerName = UnitName(unit)
        local totalItemLevel = 0
        local itemCount = 0
        
        -- 获取装等信息
        for i = 1, 18 do
            if i ~= 4 then -- 跳过衬衣槽位
                local itemLink = GetInventoryItemLink(unit, i)
                if itemLink then
                    local iLevel = GetDetailedItemLevelInfo(itemLink)
                    if iLevel and iLevel > 0 then
                        totalItemLevel = totalItemLevel + iLevel
                        itemCount = itemCount + 1
                    end
                end
            end
        end
        
        if itemCount > 0 then
            itemLevelCache[playerName] = math.floor(totalItemLevel / itemCount)
        end
        
        -- 获取专精信息并缓存
        if Skada and Skada.char then
            Skada.char.cached_specs = Skada.char.cached_specs or {}
            
            -- 获取玩家的专精信息
            local specID = GetInspectSpecialization(unit)
            if specID and specID > 0 then
                Skada.char.cached_specs[guid] = specID
            end
        end
    end
end

-- 事件处理函数
function mod:OnEnable()
    -- 注册为Skada模式
    Skada:AddMode(self, "地下城")
    
    self:RegisterEvent("CHALLENGE_MODE_START")
    self:RegisterEvent("CHALLENGE_MODE_COMPLETED")
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("INSPECT_READY", OnInspectReady)
end

function mod:OnDisable()
    -- 移除Skada模式注册
    Skada:RemoveMode(self)
    self:UnregisterAllEvents()
end

-- 检查所有队友装等
local function InspectAllGroupMembers()
    local groupSize = GetNumGroupMembers()
    if groupSize <= 1 then return end
    
    for i = 1, groupSize do
        local unit = (i == 1) and "player" or ("party" .. (i - 1))
        if UnitExists(unit) and UnitIsPlayer(unit) then
            local playerName = UnitName(unit)
            if playerName ~= UnitName("player") and CanInspect(unit) then
                -- 延迟检查，避免同时检查太多玩家
                C_Timer.After(i * 0.5, function()
                    if UnitExists(unit) then
                        NotifyInspect(unit)
                    end
                end)
            end
        end
    end
end

-- 大秘境开始
function mod:CHALLENGE_MODE_START()
    isInDungeon = true
    dungeonStartTime = GetTime()
    dungeonData = {}
    
    -- 开始检查所有队友装等
    C_Timer.After(2, InspectAllGroupMembers)
end

-- 大秘境完成
function mod:CHALLENGE_MODE_COMPLETED()
    if isInDungeon then
        dungeonEndTime = GetTime()
        -- 延迟1秒显示统计，确保数据收集完整
        C_Timer.After(1, function()
            ShowDungeonSummary()
        end)
        isInDungeon = false
    end
end

-- 区域改变
function mod:ZONE_CHANGED_NEW_AREA()
    local inInstance, instanceType = IsInInstance()
    if inInstance and instanceType == "party" then
        if not isInDungeon then
            isInDungeon = true
            dungeonStartTime = GetTime()
            dungeonData = {}
        end
    else
        if isInDungeon then
            dungeonEndTime = GetTime()
            -- 普通地下城完成，延迟显示统计
            C_Timer.After(1, function()
                ShowDungeonSummary()
            end)
            isInDungeon = false
        end
    end
end

-- 玩家进入世界
function mod:PLAYER_ENTERING_WORLD()
    local inInstance, instanceType = IsInInstance()
    if inInstance and instanceType == "party" then
        isInDungeon = true
        dungeonStartTime = GetTime()
        dungeonData = {}
    else
        isInDungeon = false
    end
end

-- 添加配置选项
function mod:AddToOptions()
    local options = {
        type = "group",
        name = "地下城统计",
        desc = "地下城结束后自动显示统计窗口",
        args = {
            enable = {
                type = "toggle",
                name = "启用地下城统计",
                desc = "在地下城结束后自动弹出统计窗口",
                order = 1,
                get = function() return Skada.db.profile.modules.dungeonSummary end,
                set = function(_, value)
                    Skada.db.profile.modules.dungeonSummary = value
                    if value then
                        mod:Enable()
                    else
                        mod:Disable()
                    end
                end
            }
        }
    }
    
    Skada.options.args.modules.args.dungeonSummary = options
end

-- 初始化
function mod:OnInitialize()
    -- 设置默认配置
    if Skada.db.profile.modules.dungeonSummary == nil then
        Skada.db.profile.modules.dungeonSummary = true
    end
    
    self:AddToOptions()
end