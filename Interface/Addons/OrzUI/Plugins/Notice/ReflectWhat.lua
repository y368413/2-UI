local frame = CreateFrame("Frame")
local reflectedSpells = {}
local COMBATLOG_PARAMS = {
    SPELL_MISSED = {
        spellId = 12,
        sourceGUID = 4,
        sourceName = 5,
        destGUID = 8,
        missType = 15
    },
    SPELL_DAMAGE = {
        spellId = 12,
        destGUID = 8,
        damage = 15
    }
}

-- 常量定义
local REFLECTION_SPELL_ID = 23920
local DAMAGE_THRESHOLDS = {
    {value = 1e7, format = '%.2f千万'},
    {value = 1e6, format = '%.2f百万'},
    {value = 1e4, format = '%.1f万'}
}

-- 注册单一事件
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

-- 伤害智能格式化
local function FormatDamage(dmg)
    if not dmg or dmg <= 0 then
        return "0"
    end
    
    for _, threshold in ipairs(DAMAGE_THRESHOLDS) do
        if dmg >= threshold.value then
            return threshold.format:format(dmg / threshold.value)
        end
    end
    return tostring(dmg)
end

-- 通用法术链接获取
local function GetSpellLinkSafe(id)
    local linkFunc = C_Spell and C_Spell.GetSpellLink or GetSpellLink
    return linkFunc(id) or ("|cff71d5ff|Hspell:%d|h[法术#%d]|h|r"):format(id, id)
end

-- 智能选择通报频道
local function GetBestChannel()
    if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        return "INSTANCE_CHAT"
    elseif IsInRaid() then
        return "RAID"
    elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
        return "PARTY"
    elseif UnitExists("target") and UnitIsPlayer("target") then
        return "WHISPER," .. UnitName("target")
    else
        return "EMOTE"
    end
end

-- 发送反射通报
local function SendReflectionMessage(attackerName, spellId, damage)
    local reflectionLink = GetSpellLinkSafe(REFLECTION_SPELL_ID)
local targetLink = GetSpellLinkSafe(spellId)
--local message = (damage and "%s 反弹了【%s】的%s (伤害:%s)" or "%s 抵消了【%s】的%s (未造成伤害)") :format(reflectionLink, attackerName, targetLink, FormatDamage(damage))
local message = (damage and "反弹→[伤害:"..FormatDamage(damage).."]" or "抵消→[伤害:"..FormatDamage(damage).."]")

    local channelInfo = GetBestChannel()
    local channelType, whisperTarget = strsplit(",", channelInfo)
    
    if channelType == "WHISPER" then
        SendChatMessage(message, channelType, nil, whisperTarget)
    else
        SendChatMessage(message, channelType)
    end
end

-- 处理反射事件
local function HandleReflectionEvent(spellId, sourceGUID, sourceName)
    -- 新增职业检测：只允许防护战士触发
    local _, playerClass = UnitClass("player")
    local specID = GetSpecialization()
    if playerClass ~= "WARRIOR" or specID ~= 3 then
        return
    end
    
    local currentPlayerGUID = UnitGUID("player")
    local key = currentPlayerGUID .. "-" .. spellId
    
    if not reflectedSpells[key] then
        reflectedSpells[key] = {
            spellId = spellId,
            attackerGUID = sourceGUID,
            attackerName = sourceName,
            timestamp = GetTime(),
            pending = true,
            damageReported = true
        }
    end
end

-- 处理反射伤害
local function HandleReflectionDamage(spellId, damage)
    local currentPlayerGUID = UnitGUID("player")
    local key = currentPlayerGUID .. "-" .. spellId
    
    if reflectedSpells[key] then
        local entry = reflectedSpells[key]
        if entry.pending then
            SendReflectionMessage(entry.attackerName, entry.spellId, damage)
            entry.pending = false
            entry.damageReported = true
        end
    end
end

-- 事件处理主逻辑
frame:SetScript("OnEvent", function(self, event, ...)
    local args = {CombatLogGetCurrentEventInfo()}
    local subevent = args[2]

    if subevent == "SPELL_MISSED" then
        local params = COMBATLOG_PARAMS.SPELL_MISSED
        if args[params.missType] == "REFLECT" and args[params.destGUID] == UnitGUID("player") then
            local spellId = args[params.spellId]
            local sourceGUID = args[params.sourceGUID]
            local sourceName = args[params.sourceName]
            HandleReflectionEvent(spellId, sourceGUID, sourceName)
        end
    elseif subevent == "SPELL_DAMAGE" then
        local params = COMBATLOG_PARAMS.SPELL_DAMAGE
        local spellId = args[params.spellId]
        local damage = args[params.damage]
        HandleReflectionDamage(spellId, damage)
    end
end)

-- 智能清理器
local function CleanupReflections()
    local now = GetTime()
    
    for key, entry in pairs(reflectedSpells) do
        local elapsed = now - entry.timestamp
        
        if elapsed > 10 then  -- 清理10秒前记录
            reflectedSpells[key] = nil
        elseif entry.pending and elapsed > 0.5 then  -- 半秒后处理未伤害
            SendReflectionMessage(entry.attackerName, entry.spellId)
            entry.pending = false
        end
    end
end

-- 定时器更新
local timer = 0
frame:SetScript("OnUpdate", function(self, elapsed)
    timer = timer + elapsed
    if timer >= 0.05 then
        CleanupReflections()
        timer = 0
    end
end)