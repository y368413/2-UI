--## Author: TuTu、huchang47 ## Version: 1.0.8

local TankHappy = LibStub("AceAddon-3.0"):NewAddon("TankHappy")
-- 本地化名称
local TankHappyLocal = (GetLocale() == "zhCN" or GetLocale() == "zhTW") and "|cff33ff99[便捷]|r坦克开心" or "Tank Happy"

local _, classEn = UnitClass("player")
-- 支持的职业列表
local supportedClasses = {
    HUNTER = 34477,    -- 误导
    ROGUE = 57934,     -- 嫁祸
    SHAMAN = 974,      -- 大地之盾
    DRUID = 474750,    -- 共生
    EVOKER = 360827    -- 炽火龙鳞
}

if not supportedClasses[classEn] then return end
local spell = supportedClasses[classEn]

local TankHappyFrame = {
    config = {
        name = "TankHappy",
        icon = "Interface\\Icons\\Ability_Hunter_WingClip",
        desc = "自动选择误导、嫁祸、地盾、共生坦克或者宠物",
        author = "TuTu，huchang47",
        version = "1.0.8"
    }
}
local name = TankHappyFrame.config.name
local btn = _G[name]
local InfoOutput = false

-- buff/debuff检查函数
local function UnitAura(unit, auraName)
    return AuraUtil.FindAuraByName(auraName, unit) ~= nil
end

TankHappyFrame.last = nil

-- 创建或复用按钮
if not btn then
    btn = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate")
    btn:SetSize(32, 32)
    btn:RegisterForClicks("AnyUp", "AnyDown")
    btn:SetHighlightTexture('Interface\\Buttons\\ButtonHilight-Square')
    btn:SetAttribute("type", "spell")
    btn:SetAttribute("unit", "target")
    btn:SetAttribute("spell", spell)
    btn:SetAttribute("checkselfcast", false)
    btn:SetAttribute("checkfocuscast", false)
end
TankHappyFrame.btn = btn

-- 更新宏目标的函数
TankHappyFrame.UpdateMacro = function(unit)
    local text
    local lastText = TankHappyFrame.lastText or ""
    if UnitExists(unit) then
        local spellName = C_Spell.GetSpellName(spell)
        if not spellName then
            print(TankHappyFrame.id, "错误", "未知法术 " .. spell)
        end
        if not InCombatLockdown() and not UnitAffectingCombat("player") then
            if classEn == "SHAMAN" and IsPlayerSpell(383010) then
                local hasShield = UnitAura("player", spellName)
                if not hasShield then
                    btn:SetAttribute("unit", "player")
                    text = C_Spell.GetSpellLink(spell).. " 目标为自己"
                else
                    btn:SetAttribute("unit", unit)
                    -- 增加队伍判断
                    if IsInGroup() then
                        text = C_Spell.GetSpellLink(spell).. " 已存在于自己，目标切换到坦克"
                    else
                        text = C_Spell.GetSpellLink(spell).. " 已对自己施放"
                    end
                end
            else
                btn:SetAttribute("unit", unit)
                text = C_Spell.GetSpellLink(spell) .. " 选中目标：-> " .. unit
            end
        else
            TankHappyFrame.needUpdate = true
            return
        end
    else
        if not InCombatLockdown() and not UnitAffectingCombat("player") then
            btn:SetAttribute("unit", "target")
            text = C_Spell.GetSpellLink(spell) .. " 无目标"
        end
    end
    if text and text ~= lastText then
        if InfoOutput then
            print(text)
        end
        TankHappyFrame.lastText = text
    end
end

-- 检测坦克的函数
local members = {"party1", "party2", "party3", "party4", "party1pet", "party2pet", "party3pet", "party4pet"}
-- 团队成员列表（支持40人团队）
local raidMembers = {}
for i = 1, 40 do
    table.insert(raidMembers, "raid" .. i)
end

-- 检查单位是否在施法范围内
local function IsInRange(unit)
    if not UnitExists(unit) then return false end
    
    -- 使用魔兽世界内置的距离检查，这些技能都有很远的施法距离
    -- 大部分辅助技能的施法距离都是40码
    local spellName = C_Spell.GetSpellName(spell)
    if spellName then
        local inRange = C_Spell.IsSpellInRange(spell, unit)
        if inRange == true then
            return true
        elseif inRange == false then
            return false
        end
    end
    
    -- 如果无法通过法术检查距离，使用通用距离检查（40码）
    if UnitDistanceSquared then
        local distance = UnitDistanceSquared(unit)
        if distance then
            return math.sqrt(distance) <= 40
        end
    end
    
    -- 如果距离检查API不可用，尝试使用CheckInteractDistance
    if CheckInteractDistance then
        -- CheckInteractDistance(unit, 4) 检查是否在跟随距离内（约28码）
        return CheckInteractDistance(unit, 4)
    end
    
    -- 默认返回true，避免因距离检查失败而无法施法
    return true
end

TankHappyFrame.UpdateTank = function()
    if InCombatLockdown() then return end
    if UnitExists("focus") and UnitIsFriend("player", "focus") and UnitCanAssist("player", "focus") then
        TankHappyFrame.UpdateMacro("focus")
        return
    end
    
    -- 根据是否在团队中选择不同的成员列表
    local targetMembers = IsInRaid() and raidMembers or members
    local tanks = {}
    local inRangeTanks = {}
    local mainTank = nil
    local targetTank = nil
    local inRangeTargetTank = nil
    local inRangeMainTank = nil
    
    -- 收集所有坦克信息
    local pets = {} -- 只在小队模式下使用
    
    for i = 1, #targetMembers do
        local unit = targetMembers[i]
        local unitName = UnitName(unit)
        if unitName then
            if IsInRaid() then
                -- 团队模式：只处理真正的团队成员，不处理宠物
                if UnitGroupRolesAssigned(unit) == "TANK" and UnitIsConnected(unit) and not UnitIsDead(unit) then
                    table.insert(tanks, unit)
                    local inRange = IsInRange(unit)
                    
                    if inRange then
                        table.insert(inRangeTanks, unit)
                    end
                    
                    -- 优先级1：当前目标是坦克
                    if UnitIsUnit(unit, "target") then
                        targetTank = unit
                        if inRange then
                            inRangeTargetTank = unit
                        end
                    end
                    
                    -- 检查是否在同一小队（团队中优先同小队坦克）
                    local playerIndex = UnitInRaid("player")
                    local tankIndex = UnitInRaid(unit)
                    local isSameSubgroup = false
                    if playerIndex and tankIndex then
                        local playerSubgroup = select(3, GetRaidRosterInfo(playerIndex))
                        local tankSubgroup = select(3, GetRaidRosterInfo(tankIndex))
                        isSameSubgroup = (playerSubgroup == tankSubgroup)
                    end
                    
                    -- 优先级2：同小队坦克 > 第一个坦克
                    if not mainTank then
                        -- 优先选择同小队的坦克
                        if isSameSubgroup then
                            mainTank = unit
                            if inRange then
                                inRangeMainTank = unit
                            end
                        else
                            -- 如果没有同小队坦克，选择第一个找到的坦克
                            mainTank = unit
                            if inRange then
                                inRangeMainTank = unit
                            end
                        end
                    elseif isSameSubgroup and not inRangeMainTank and inRange then
                        -- 如果已有主坦克但不在距离内，且当前坦克是同小队且在距离内，则替换
                        mainTank = unit
                        inRangeMainTank = unit
                    end
                end
            else
                -- 小队模式：区分玩家和宠物
                if i >= 5 then
                    -- 这是宠物，先收集起来，稍后处理
                    table.insert(pets, unit)
                else
                    -- 检查是否为坦克职责且在线
                    if UnitGroupRolesAssigned(unit) == "TANK" and UnitIsConnected(unit) then
                        table.insert(tanks, unit)
                        local inRange = IsInRange(unit)
                        
                        if inRange then
                            table.insert(inRangeTanks, unit)
                        end
                        
                        -- 优先级1：当前目标是坦克
                        if UnitIsUnit(unit, "target") then
                            targetTank = unit
                            if inRange then
                                inRangeTargetTank = unit
                            end
                        end
                        
                        -- 优先级2：主坦克（第一个坦克通常是主坦克）
                        if not mainTank then
                            mainTank = unit
                            if inRange then
                                inRangeMainTank = unit
                            end
                        end
                    end
                end
            end
        end
    end
    
    -- 如果没有找到真正的坦克，且在小队模式下，考虑宠物作为备选
    if #tanks == 0 and not IsInRaid() and #pets > 0 then
        -- 优先选择距离内的宠物
        for _, pet in ipairs(pets) do
            if IsInRange(pet) then
                TankHappyFrame.UpdateMacro(pet)
                return
            end
        end
        -- 如果没有距离内的宠物，选择第一个宠物
        TankHappyFrame.UpdateMacro(pets[1])
        return
    end
    
    -- 多坦克优先级选择：距离内当前目标坦克 > 距离内主坦克 > 距离内任意坦克 > 当前目标坦克 > 主坦克 > 任意坦克
    if inRangeTargetTank then
        TankHappyFrame.UpdateMacro(inRangeTargetTank)
        return
    elseif inRangeMainTank then
        TankHappyFrame.UpdateMacro(inRangeMainTank)
        return
    elseif #inRangeTanks > 0 then
        TankHappyFrame.UpdateMacro(inRangeTanks[1])
        return
    elseif targetTank then
        TankHappyFrame.UpdateMacro(targetTank)
        return
    elseif mainTank then
        TankHappyFrame.UpdateMacro(mainTank)
        return
    end
    if classEn == "HUNTER" then
        TankHappyFrame.UpdateMacro("pet")
    elseif classEn == "ROGUE" then
        TankHappyFrame.UpdateMacro()
    elseif classEn == "SHAMAN" then
        TankHappyFrame.UpdateMacro("player")
    elseif classEn == "DRUID" then
        TankHappyFrame.UpdateMacro()
    elseif classEn == "EVOKER" then
        TankHappyFrame.UpdateMacro("player")
    end
end

function TankHappy:OnInitialize()
    if not InCombatLockdown() then C_Timer.NewTicker(1, TankHappyFrame.UpdateTank) end
    self.db = LibStub("AceDB-3.0"):New("TankHappyDB", {
        profile = {
            InfoOutput = false
        }
    })
    InfoOutput = self.db.profile.InfoOutput

    local panel = CreateFrame("Frame", TankHappyLocal, InterfaceOptionsFramePanelContainer)
    panel.name = TankHappyLocal
    if InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(panel)
    else
        local category = Settings.RegisterCanvasLayoutCategory(panel, TankHappyLocal)
        Settings.RegisterAddOnCategory(category)
        panel.categoryID = category:GetID()
    end

    local content = CreateFrame("Frame", nil, panel)
    content:SetPoint("TOPLEFT", panel, "TOPLEFT", 16, -16)
    content:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -16, 16)

    local title = content:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
    title:SetPoint("TOP", 0, 0)
    title:SetText(TankHappyLocal)

    local subtitle = content:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    subtitle:SetPoint("TOPLEFT", 0, -40)
    subtitle:SetJustifyH("LEFT")
    subtitle:SetText("根据你当前的职业，自动选择|TInterface\\Icons\\Ability_Hunter_Misdirection:16|t|CFFAAD372误导|r、|TInterface\\Icons\\Ability_Rogue_TricksOfTheTrade:16|t|CFFFFF468嫁祸|r、|TInterface\\Icons\\Spell_Nature_SkinofEarth:16|t|CFF0070DD大地之盾|r、|TInterface\\Icons\\Ability_Druid_Focusedgrowth:16|t|CFFFF7D0A共生关系|r、|TInterface\\Icons\\ability_evoker_blisteringscales:16|t|CFF33937F炽火龙鳞|r的目标。")

    local UseTitle = content:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
    UseTitle:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -30)
    UseTitle:SetText("使用方法")

    local UseText = content:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    UseText:SetPoint("TOPLEFT", UseTitle, "BOTTOMLEFT", 0, -10)
    UseText:SetText("依次按下|CFFFFD700Ctrl+A|r、|CFFFFD700Ctrl+C|r复制以下宏命令，新建一个宏，拖到动作栏中使用。")
    local macroFrame = CreateFrame("EditBox", nil, content)
    macroFrame:SetSize(300, 40)
    macroFrame:SetPoint("TOPLEFT", UseTitle, "BOTTOMLEFT", 0, -35)
    macroFrame:SetMultiLine(true)
    macroFrame:SetAutoFocus(false)
    macroFrame:SetText("/click TankHappy LeftButton 1\n/click TankHappy LeftButton 0")
    macroFrame:SetFontObject("GameFontHighlight")
    macroFrame:EnableMouse(true)
    macroFrame:SetScript("OnEditFocusGained", function(self) 
        self:HighlightText() 
        self:SetCursorPosition(0)
    end)
    macroFrame:SetScript("OnMouseDown", function(self)
        if not self:HasFocus() then
            self:SetFocus()
            self:HighlightText()
        end
    end)
    macroFrame:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    macroFrame:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
    macroFrame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
        GameTooltip:SetText("你可以在此宏的基础上改造更多的宏功能")
        GameTooltip:Show()
    end)
    macroFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
    local background = CreateFrame("Frame", nil, macroFrame, "BackdropTemplate")
    background:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    background:SetBackdropColor(0, 0, 0, 0.5)
    background:SetPoint("TOPLEFT", macroFrame, -5, 5)
    background:SetPoint("BOTTOMRIGHT", macroFrame, 5, -5)

    local UseTips = content:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    UseTips:SetPoint("TOPLEFT", macroFrame, "BOTTOMLEFT", 0, -20)
    UseTips:SetJustifyH("LEFT")
    UseTips:SetText("根据当前的队伍状态智能选择目标，施放职业对应的法术。\n|CFFAAD372猎人|r |TInterface\\Icons\\Ability_Hunter_Misdirection:16|t误导坦克或宠物、|CFFFFF468潜行者|r |TInterface\\Icons\\Ability_Rogue_TricksOfTheTrade:16|t嫁祸坦克。\n|CFF0070DD萨满|r默认对坦克施放|TInterface\\Icons\\Spell_Nature_SkinofEarth:16|t大地之盾；有元素缠绕天赋时，战斗外先对自己施放，再次点击\n对坦克施放；战斗中对坦克施放。\n|CFFFF7D0A恢复德鲁伊|r |TInterface\\Icons\\Ability_Druid_Focusedgrowth:16|t对坦克施放共生关系。\n|CFF33937F唤魔师|r |TInterface\\Icons\\ability_evoker_blisteringscales:16|t对坦克施放炽火龙鳞，无坦克时对自己施放。\n\n|CFFFF6600智能优先级|r：距离内当前目标坦克 > 距离内主坦克 > 距离内任意坦克 > 当前目标坦克 > 主坦克。\n|CFF00FF00距离检查|r：自动检测技能施法距离，优先选择距离内的坦克目标。")

    local OptionTitle = content:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
    OptionTitle:SetPoint("TOPLEFT", UseTips, "BOTTOMLEFT", 0, -30)
    OptionTitle:SetText("选项")

    local infoOutputCheck = CreateFrame("CheckButton", nil, content, "InterfaceOptionsCheckButtonTemplate")
    infoOutputCheck:SetPoint("TOPLEFT", OptionTitle, 0, -30)
    infoOutputCheck.Text:SetText("启用信息输出")
    infoOutputCheck:HookScript("OnClick", function()
        self.db.profile.InfoOutput = infoOutputCheck:GetChecked()
        InfoOutput = self.db.profile.InfoOutput
    end)
    infoOutputCheck:HookScript("OnEnter", function()
        GameTooltip:SetOwner(infoOutputCheck, "ANCHOR_TOPRIGHT")
        GameTooltip:SetText("启用后将在聊天窗口输出智能目标选择信息")
        GameTooltip:Show()
    end)
    infoOutputCheck:HookScript("OnLeave", function() GameTooltip:Hide() end)
    infoOutputCheck:SetChecked(self.db.profile.InfoOutput)
end
