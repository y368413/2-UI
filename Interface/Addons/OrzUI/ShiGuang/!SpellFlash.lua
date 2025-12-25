local thj = {}
-- _G["SpellFlashCore"] = thj
_G["SFC"] = thj
thj.info = {
    key = nil,
    keyCD = nil,
    isCombat = false,
    isChanneling = false,
    isQuesting = false
}
thj.items = {}
thj.keyMapping = {}
local _, clzName = UnitClass('player');
-- thj.LS={}
thj.meta = {
    clzName = clzName
}
--[[
格式化打印方法
@param fmt 格式化字符串 eg: "测试格式 {1} {2} {3}"
@param ... 参数列表 eg: 123 "demo" false
@return string 格式化后的字符串,eg: "测试格式 123 demo false"
]]
local LogWithFormat = function(fmt, ...)
    local args = {...}
    local rv = fmt
    for i = 0, #args do
        rv = string.gsub(rv, "{" .. i .. "}", tostring(args[i]))
    end
    return rv
end
-- 日志显示级别, 0:debug及以上, 1:info及以上, 2:warn及以上, 3:error及以上， 4: 不显示
thj.LogLevel = 0
thj.logger = {
    Debug = function(fmt, ...)
        if thj.LogLevel > 0 then
            return
        end
        print("|cff808080[DEBUG]|r " .. LogWithFormat(fmt, ...))
    end,
    Info = function(fmt, ...)
        if thj.LogLevel > 1 then
            return
        end
        print("|cff00ff00[INFO]|r " .. LogWithFormat(fmt, ...))
    end,
    Warn = function(fmt, ...)
        if thj.LogLevel > 2 then
            return
        end
        print("|cffffff00[WARN]|r " .. LogWithFormat(fmt, ...))
    end,
    Error = function(fmt, ...)
        if thj.LogLevel > 3 then
            return
        end
        print("|cffff0000[ERROR]|r " .. LogWithFormat(fmt, ...))
    end
}

thj.createFrame = function(opt)
    local name, parent = opt.name, opt.parent or UIParent
    local width, height = opt.width or 300, opt.height or 200
    local f = CreateFrame("Frame", name, parent);
    f:SetWidth(width)
    f:SetHeight(height)
    f:SetPoint(unpack(opt.anchor or {"CENTER", 0, 0}))
    -- 配置事件监控
    f:SetScript("OnEvent", function(self, evtName, ...)
        if self[evtName] then
            if evtName == "COMBAT_LOG_EVENT_UNFILTERED" then
                local timestamp, subEvt, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName,
                    destFlags, destRaidFlags, extraArg1, extraArg2, extraArg3, extraArg4, extraArg5, extraArg6,
                    extraArg7, extraArg8, extraArg9, extraArg10 = CombatLogGetCurrentEventInfo()
                if self[subEvt] then
                    self[subEvt](self, sourceGUID, sourceName, destGUID, destName, extraArg1, extraArg2, extraArg3,
                        extraArg4, extraArg5, extraArg6, extraArg7, extraArg8, extraArg9, extraArg10);
                end
            else
                self[evtName](self, evtName, ...);
            end
        end
    end)
    return f;
end

local keyMapping = {
    ["BACKSPACE"] = 8,
    ["TAB"] = 9,
    ["ENTER"] = 13,
    ["SPACE"] = 32,
    ["MOUSEWHEELDOWN"] = 174,
    ["MOUSEWHEELUP"] = 175,
    ["MwD"] = 174,
    ["MwU"] = 175,
    ["F1"] = 112,
    ["F2"] = 113,
    ["F3"] = 114,
    ["F4"] = 115,
    ["F5"] = 116,
    ["F6"] = 117,
    ["F7"] = 118,
    ["F8"] = 119,
    ["F9"] = 120,
    ["F10"] = 121,
    ["F11"] = 122,
    ["F12"] = 123,
    ["1"] = 49,
    ["2"] = 50,
    ["3"] = 51,
    ["4"] = 52,
    ["5"] = 53,
    ["6"] = 54,
    ["7"] = 55,
    ["8"] = 56,
    ["9"] = 57,
    ["0"] = 48,
    ["A"] = 65,
    ["B"] = 66,
    ["C"] = 67,
    ["D"] = 68,
    ["E"] = 69,
    ["F"] = 70,
    ["G"] = 71,
    ["H"] = 72,
    ["I"] = 73,
    ["J"] = 74,
    ["K"] = 75,
    ["L"] = 76,
    ["M"] = 77,
    ["N"] = 78,
    ["O"] = 79,
    ["P"] = 80,
    ["Q"] = 81,
    ["R"] = 82,
    ["S"] = 83,
    ["T"] = 84,
    ["U"] = 85,
    ["V"] = 86,
    ["W"] = 87,
    ["X"] = 88,
    ["Y"] = 89,
    ["Z"] = 90,
    [";"] = 186,
    ["'"] = 222,
    [","] = 188,
    ["."] = 190,
    ["/"] = 191,
    ["`"] = 192,
    ["-"] = 189,
    ["="] = 187,
    ["["] = 219,
    ["\\"] = 220,
    ["]"] = 221,
    ["LEFT"] = 37,
    ["RIGHT"] = 39,
    ["UP"] = 38,
    ["DOWN"] = 40,
    ["INSERT"] = 45,
    ["DELETE"] = 46,
    ["PAGEUP"] = 33,
    ["PAGEDOWN"] = 34,
    ["HOME"] = 36,
    ["END"] = 35
}
thj.rawKeys = keyMapping
local km = thj.keyMapping;
for k, v in pairs(keyMapping) do
    km[k] = {
        key = v
    }
    km["C" .. k] = {
        control = true,
        key = v
    }
    km["A" .. k] = {
        alt = true,
        key = v
    }
    km["S" .. k] = {
        shift = true,
        key = v
    }
    km["AC" .. k] = {
        alt = true,
        control = true,
        key = v
    }
    km["CS" .. k] = {
        shift = true,
        control = true,
        key = v
    }
    km["AS" .. k] = {
        alt = true,
        shift = true,
        key = v
    }
    km["ACS" .. k] = {
        alt = true,
        control = true,
        shift = true,
        key = v
    }
end
--[[
高四位 XX10 后2位固定10，前2为数据位
]]
local cdSpells = {
    [1719] = "鲁莽",
    [107574] = "天神下凡"
}
thj.cdSpells = cdSpells;
local counterSpells = {
    SpellReflection = 10000,
    Berserk = 10001
}
thj.counterSpells = counterSpells;

local log = thj.logger;
--[[ 创建UI ]]
local SIZE = 5;
local BLOCK_COUNT = 2;
local C = {
    MAIN_SPELL_INDEX = 1,
    CD_SPELL_INDEX = 2
}
local sfo = thj.createFrame({
    name = "SFOFrame",
    width = 200,
    height = 10,
    anchor = {"TOPLEFT", 0, 0}
})
sfo:SetFrameStrata("HIGH")
sfo:SetFrameLevel(10000)

thj.frame = sfo;
--[[
UI规划
[1.定位点][2.状态][3.主技能][4.无CD][5.定位点]
]]
local function newTex(x)
    local tx = sfo:CreateTexture(nil, "ARTWORK");
    tx:SetColorTexture(0, 0, 0);
    tx:SetSize(SIZE, SIZE);
    tx:SetPoint("TOPLEFT", sfo, x, 0)
    return tx;
end
local blocks = {}
for i = 1, BLOCK_COUNT do
    local tx = newTex(i * SIZE - SIZE);
    table.insert(blocks, tx);
end

local function getSpellColor(key)
    local r, g, b;
    local info = thj.info;
    local km = thj.keyMapping[key or ""];
    if not km then
        r = 0;
        g = 0;
    else
        -- r = 组合键标志位<CCAASS00> ctrl | alt | shift  
        r = (km.control and 1 or 0) * 0xC0 + (km.alt and 1 or 0) * 0x30 + (km.shift and 1 or 0) * 0xC
        -- g = 按键编码
        g = km.key;
    end
    b = ((info.isCombat and not info.isMounted) and 1 or 0) * 0xC0 + (info.isChanneling and 1 or 0) * 0x30;
    return r, g, b;
end
thj.Repaint = function()
    local info = thj.info;
    local r, g, b = getSpellColor(info.key)
    -- log.Info("UpdateSpell key = {1} , r = {2}, g = {3}, b = {4} ", info.key, r, g, b)
    blocks[C.MAIN_SPELL_INDEX]:SetColorTexture(r / 255, g / 255, b / 255)
end

local sfo = thj.frame;
local GetSpellInfo = C_Spell.GetSpellInfo

local Hekili

--[[                                  公共方法                              ]]
--[[设置战斗状态]]
thj.SetCombat = function(flag)
    thj.info.isCombat = flag;
    thj.Repaint();
end
--[[设置通道施法状态]]
thj.SetChanneling = function(flag)
    thj.info.isChanneling = flag;
    thj.Repaint();
end
local allTimer
--[[
    事件注册
]]

function HekiliAutoCast_Setup()
    local allowAcceptNew = true
    local OrigHekiliUpdate = Hekili.Update
    Hekili.Update = function()
        allowAcceptNew = true
        OrigHekiliUpdate();
    end
    local OrigGetBindingForAction = Hekili.GetBindingForAction
    Hekili.GetBindingForAction = function(key, display, i)
        local result, secondResult = OrigGetBindingForAction(key, display, i)
        if allowAcceptNew then
            thj.FlashKey(result)
            allowAcceptNew = false
        end
        return result, secondResult
    end
end
sfo:RegisterEvent("ADDON_LOADED")
function sfo:ADDON_LOADED(evt, name)
    if (name == "Hekili") then
        Hekili = _G["Hekili"]
        C_Timer.After(1, function()
            --log.Debug("Hekili loaded!")
            HekiliAutoCast_Setup()
        end)
    end
end

-- 战斗状态指示
sfo:RegisterEvent("PLAYER_REGEN_ENABLED")
function sfo:PLAYER_REGEN_ENABLED()
    -- print("PLAYER_REGEN_ENABLED  ")
    thj.SetCombat(false)
end
sfo:RegisterEvent("PLAYER_REGEN_DISABLED")
function sfo:PLAYER_REGEN_DISABLED()
    -- print("PLAYER_REGEN_DISABLED  ")
    thj.SetCombat(true)
end
-- Chennel状态指示 
sfo:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
function sfo:UNIT_SPELLCAST_CHANNEL_START()
    -- print("UNIT_SPELLCAST_CHANNEL_START  ")
    thj.SetChanneling(true);
end
sfo:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", "player")
function sfo:UNIT_SPELLCAST_CHANNEL_STOP()
    -- print("UNIT_SPELLCAST_CHANNEL_STOP  ")
    thj.SetChanneling(false);
end
local cache = {}
sfo:RegisterUnitEvent("UNIT_SPELLCAST_EMPOWER_START", "player")
function sfo:UNIT_SPELLCAST_EMPOWER_START(unitTarget, castGUID, spellID)
    -- print("UNIT_SPELLCAST_EMPOWER_START", unitTarget, castGUID, spellID)
    local name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID, _, numStages =
        UnitChannelInfo("player");
    local totalTime = 0;
    for i = 1, numStages + 1, 1 do
        local duration = GetUnitEmpowerStageDuration("player", i - 1)
        totalTime = totalTime + duration;
    end
    totalTime = totalTime / 1000
    log.Warn("Empower spell should stop in {1} seconds!!!", totalTime)
    C_Timer.After(totalTime, function()
        log.Debug("Delay done! Set state = UP")
        -- thj.Repaint();
    end)
end
-- UI update interval
local INTERVAL = 0.2
local lastKey = nil
local empowering = false
-- local lastUpdate = 0;
-- sfo:SetScript("OnUpdate", function(self, elapsed)
--     log.Debug("OnUpdate.elapsed = ", elapsed)
--     lastUpdate = lastUpdate + elapsed;
--     -- 每秒更新坐骑状态，当在坐骑上时不释放技能，否则马上进入战斗，放个技能又下马了
--     if lastUpdate > 0.1 then
--         lastUpdate = 0;
--         thj.info.isMounted = IsMounted("player");
--         thj.UpdateState();
--     end
-- end)
-- C_Timer.NewTicker(INTERVAL, function()
--     if not Hekili then
--         return
--     end
--     thj.info.isMounted = IsMounted("player");
--     thj.UpdateState();
--     local recommends = Hekili.DisplayPool["Primary"].Recommendations
--     local firstKeybind = nil

--     local curSequence = recommends[1]
--     local curSpellName, curSpellId, curKey, empowerTo = curSequence.actionName, curSequence.actionID,
--         curSequence.keybind, curSequence.empower_to or 0
--     if not curSpellId then
--         return
--     end
--     if not curKey then
--         log.Warn("Unknown spell {1}, id = {2}", curSpellName, curSpellId)
--         return
--     end

--     if curKey ~= lastKey then
--         lastKey = curKey
--         if empowerTo > 1 and not empowering then
--             empowering = true
--             log.Debug("Enpower spell detected! Level = {1}", empowerTo)
--             -- thj.info.keyState = "down"
--         end
--         -- thj.FlashKey(curKey)
--     else
--         return
--     end
--     thj.UpdateState();
--     thj.Repaint();
-- end)
--[[
    SFO API
]]

--[[
    根据按键进行技能提示
]]
thj.FlashKey = function(key, slot)
    slot = slot or ""
    -- 非战斗 或者 通道施法状态 不响应
    -- if not thj.info.isCombat or thj.info.isChanneling then
    --     return
    -- end
    if not key then
        return
    end
    if thj.cdSpells[key] then
        return
    end
    thj.info["key" .. slot] = key;
    local curSpell = Hekili.DisplayPool["Primary"].Recommendations[1]
    local empLvl = curSpell.empower_to or 0
    if empLvl > 1 then
        empowering = false
        log.Debug("Enpower spell detected!")
    end
    -- log.Info("Flash key {1} with slot {2}, empowering = {3} ", key, slot, empLvl)
    thj.Repaint()
end
--[[
    API: 根据技能ID获取技能名称
    @param id: 技能ID
    @returns 技能名称
]]
-- /dump Hekili.KeybindInfo[Hekili.Class.abilities["奥术智慧"].key]

local function GetSpellMeta(spellIdOrName)
    local hekiliDef = Hekili.Class.abilities[spellIdOrName]
    if not hekiliDef then
        log.Error("|cffff2020 Spell: {1} not found in HEKILI!|r", spellIdOrName)
        return nil
    end
    local id, name, simcName = hekiliDef.id, hekiliDef.name, hekiliDef.key;
    local key;
    local bindings = Hekili.KeybindInfo[simcName];
    if bindings then
        for k, v in pairs(bindings.upper) do
            key = v
        end
    end
    return id, name, key;
end
thj.StartQuesting = function()
    thj.info.isQuesting = true;
end
thj.StopQuesting = function()
    thj.info.isQuesting = false;
end

--[[local cp = CreateFrame('Frame', 'hkc', UIParent)
-- 位置可移动，宽高分别为205 150
cp:SetPoint('BOTTOM', UIParent, 'BOTTOM', -485, 95)
cp:SetSize(1, 1)
--cp.TitleText:SetText("|cff777777Hekili快捷开关")
cp:SetScript('OnHide', function() cpIcon:Show() end);
cp:SetFrameStrata("LOW")
cp:Show()
cp:SetAlpha(1)

local cpIcon = CreateFrame('Frame', 'cpIcon', UIParent)
--local _,className = UnitClass("player")
--local texture = cpIcon:CreateTexture()
--if className == "HUNTER" then className = "SHAMAN" end
--texture:SetTexture("Interface\\Addons\\OrzUI\\Media\\Emotes\\禁")
--texture:SetAllPoints(cpIcon)
local cptext = cpIcon:CreateFontString()
cptext:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
cptext:SetText("2-UI")
cptext:SetPoint("TOPLEFT", cpIcon, "TOPLEFT", 3, -3)
thj.debugger = text;
cpIcon:SetSize( 50, 20 )
cpIcon:SetPoint('RIGHT', cp, 'LEFT', 0, 0)
cpIcon:SetFrameStrata("LOW")
cpIcon:SetMovable(true)
cpIcon:SetClampedToScreen(true)
cpIcon:SetScript('OnMouseUp', function()
    cpIcon:StopMovingOrSizing();
end);
cpIcon:SetScript('OnMouseDown', function()
    cpIcon:StartMoving();
     Hekili:FireToggle('cooldowns')
end);
cpIcon:Show()

local function SetDisplayMode(mode)
    Hekili.DB.profile.toggles.mode.value = mode
    if WeakAuras and WeakAuras.ScanEvents then
        WeakAuras.ScanEvents('HEKILI_TOGGLE', 'mode', mode)
    end
    -- if ns.UI.Minimap then ns.UI.Minimap:RefreshDataText() end
    Hekili:UpdateDisplayVisibility()
    Hekili:ForceUpdate('HEKILI_TOGGLE', true)
end

-- 爆发监控/控制按钮 
local btnCD = thj.createSwitchButton({
    name = "CoolDownButton",
    parent = cp,
    text = "爆发",
    getter = function()
        return Hekili.DB.profile.toggles.cooldowns.value
    end,
    setter = function(v)
        Hekili:FireToggle('cooldowns')
    end,
    width = 50,
    height = 20,
    anchor = {"LEFT", cpIcon, "RIGHT", 0, 0},
    tip = function()
        return Hekili.DB.profile.toggles.cooldowns.key or "未设置"
    end
})
local btnMinorCD = thj.createSwitchButton({
    name = "MinorCDButton",
    parent = cp,
    text = "大招",
    getter = function()
        return Hekili.DB.profile.toggles.essences.value
    end,
    setter = function(v)
        Hekili:FireToggle('essences')
    end,
    width = 50,
    height = 20,
    anchor = {"LEFT", btnCD, "RIGHT", 0, 0},
    tip = function()
        return Hekili.DB.profile.toggles.essences.key or "未设置"
    end
})
-- 保命 监控/控制按钮 
local btnDefensives = thj.createSwitchButton({
    name = "DefensivesButton",
    parent = cp,
    text = "保命",
    getter = function()
        return Hekili.DB.profile.toggles.defensives.value
    end,
    setter = function(v)
        Hekili:FireToggle('defensives')
    end,
    width = 50,
    height = 20,
    anchor = {"LEFT", btnMinorCD, "RIGHT", 0, 0},
    tip = function()
        return Hekili.DB.profile.toggles.defensives.key or "未设置"
    end
}) 
-- 打断 监控/控制按钮 
local btnInterrupt = thj.createSwitchButton({
    name = "InterruptsButton",
    parent = cp,
    text = "打断",
    getter = function()
        return Hekili.DB.profile.toggles.interrupts.value
    end,
    setter = function(v)
        Hekili:FireToggle('interrupts')
    end,
    width = 50,
    height = 20,
    anchor = {"TOP", cpIcon, "BOTTOM", 0, 0},
    tip = function()
        return Hekili.DB.profile.toggles.interrupts.key or "未设置"
    end
}) 
-- 嗑药 监控/控制按钮 
local btnPotions = thj.createSwitchButton({
    name = "PotionButton",
    parent = cp,
    text = "药剂",
    getter = function()
        return Hekili.DB.profile.toggles.potions.value
    end,
    setter = function(v)
        Hekili:FireToggle('potions')
    end,
    width = 50,
    height = 20,
    anchor = {"LEFT", btnInterrupt, "RIGHT", 0, 0},
    tip = function()
        return Hekili.DB.profile.toggles.potions.key or "未设置"
    end
}) 

-----------------模式切换按钮----------------
-- 自动模式 监控/控制按钮 
local btnAuto = thj.createSwitchButton({
    name = "AutoButton",
    parent = cp,
    text = "自动",
    getter = function()
        return Hekili.DB.profile.toggles.mode.value == "automatic"
    end,
    setter = function(v)
        SetDisplayMode('automatic')
    end,
    width = 50,
    height = 20,
    anchor = {"LEFT", btnPotions, "RIGHT", 0, 0}
}) 
-- AOE 监控/控制按钮 
local btnAOE = thj.createSwitchButton({
    name = "AOEButton",
    parent = cp,
    text = "AOE",
    getter = function()
        return Hekili.DB.profile.toggles.mode.value == "aoe"
    end,
    setter = function(v)
        SetDisplayMode('aoe')
    end,
    width = 50,
    height = 20,
    anchor = {"LEFT", btnAuto, "RIGHT", 0, 0}
}) 
-- 单体 监控/控制按钮 
local btnSingle = thj.createSwitchButton({
    name = "SingleButton",
    parent = cp,
    text = "单体",
    getter = function()
        return Hekili.DB.profile.toggles.mode.value == "single"
    end,
    setter = function(v)
        SetDisplayMode('single')
    end,
    width = 50,
    height = 20,
    anchor = {"TOP", btnInterrupt, "BOTTOM", 0, 0}
})
-- 双显 监控/控制按钮 
local btnDual = thj.createSwitchButton({
    name = "DualButton",
    parent = cp,
    text = "双显",
    getter = function()
        return Hekili.DB.profile.toggles.mode.value == "dual"
    end,
    setter = function(v)
        SetDisplayMode('dual')
    end,
    width = 50,
    height = 20,
    anchor = {"LEFT", btnSingle, "RIGHT", 0, 0}
})
-- 响应 监控/控制按钮 
local btnReactive = thj.createSwitchButton({
    name = "ReactiveButton",
    parent = cp,
    text = "响应",
    getter = function()
        return Hekili.DB.profile.toggles.mode.value == "reactive"
    end,
    setter = function(v)
        SetDisplayMode('reactive')
    end,
    width = 50,
    height = 20,
    anchor = {"LEFT", btnDual, "RIGHT", 0, 0}
})
-- 漏斗 监控/控制按钮 
local btnFunnel = thj.createSwitchButton({
    name = "FunnelButton",
    parent = cp,
    text = "漏斗",
    getter = function()
        return Hekili.DB.profile.toggles.mode.value == "funnel"
    end,
    setter = function(v)
        SetDisplayMode('funnel')
    end,
    width = 50,
    height = 20,
    anchor = {"LEFT", btnReactive, "RIGHT", 0, 0},
    tip = "漏斗模式：AOE时用群攻技能攒能量，施放单体终结技。\n适用于敏锐、奇袭、增强、毁灭专精。"
})
-- 播放按键声音钮 
local btnVoice = thj.createSwitchButton({
    name = "VoiceButton",
    parent = cp,
    text = "语音",
    getter = function()
        return HSstop
    end,
    setter = function(v)
        HSstop = false
    end,
    width = 60,
    height = 20,
    anchor = {"LEFT", btnFunnel, "RIGHT", 0, 0},
    tip = "语音播报下一个按键"
})]]


-- 初始化保存变量
if not HekiliProDB then
    HekiliProDB = {}
end
if HekiliProDB.autoCloseCooldowns == nil then
    HekiliProDB.autoCloseCooldowns = false -- 主要爆发30秒自动关闭开关
end
if HekiliProDB.cooldownsAutoCloseTime == nil then
    HekiliProDB.cooldownsAutoCloseTime = 30 -- 自动关闭时间（秒）
end

-- 确保Hekili数据库中的override字段存在
C_Timer.After(0.1, function()
    if Hekili and Hekili.DB and Hekili.DB.profile and Hekili.DB.profile.toggles and Hekili.DB.profile.toggles.essences then
        if Hekili.DB.profile.toggles.essences.override == nil then
            Hekili.DB.profile.toggles.essences.override = false -- 次要爆发联动状态
        end
    end
end)

-- 爆发自动关闭相关变量
local cooldownsTimer = nil
local cooldownsStartTime = 0

-- 爆发自动关闭功能函数
local function startCooldownsAutoClose()
    if not HekiliProDB.autoCloseCooldowns then return end
    
    -- 停止之前的定时器
    if cooldownsTimer then
        cooldownsTimer:Cancel()
    end
    
    -- 确保自动关闭时间是有效数字
    local closeTime = HekiliProDB.cooldownsAutoCloseTime or 30
    if type(closeTime) ~= "number" or closeTime <= 0 then
        closeTime = 30
    end
    
    cooldownsStartTime = GetTime()
    cooldownsTimer = C_Timer.NewTimer(closeTime, function()
        if Hekili.DB.profile.toggles.cooldowns.value then
            Hekili:FireToggle('cooldowns')
        end
        -- 同时关闭次要爆发
        if Hekili.DB.profile.toggles.essences.value then
            Hekili:FireToggle('essences')
        end
        cooldownsTimer = nil
        cooldownsStartTime = 0
    end)
end

local function stopCooldownsAutoClose()
    if cooldownsTimer then
        cooldownsTimer:Cancel()
        cooldownsTimer = nil
    end
    cooldownsStartTime = 0
end

local function getCooldownsRemainingTime()
    if not cooldownsTimer or cooldownsStartTime == 0 then
        return 0
    end
    
    -- 确保自动关闭时间是有效数字
    local closeTime = HekiliProDB.cooldownsAutoCloseTime or 30
    if type(closeTime) ~= "number" or closeTime <= 0 then
        closeTime = 30
    end
    
    local elapsed = GetTime() - cooldownsStartTime
    local remaining = closeTime - elapsed
    return math.max(0, remaining)
end

-- 精简模式按钮全局变量
local compactBtnPause, compactBtnCD, compactBtnMinorCD, compactBtnInterrupt, compactBtnDefensives, compactBtnPotion, compactBtnMode

-- 创建开关按钮的函数
function thj.createSwitchButton(config)
    local button = CreateFrame("Button", config.name, config.parent, "BackdropTemplate")
    button:SetSize(config.width or 60, config.height or 20)
    
    -- 创建圆角矩形背景，突出蓝紫色文字
    button:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        tileSize = 0,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    
    -- 设置深色半透明背景和细边框，完美衬托蓝紫色文字
    button:SetBackdropColor(0, 0, 0, 0.5)  -- 深蓝紫色半透明背景
    button:SetBackdropBorderColor(0, 0, 0, 1)  -- 纯黑色不透明边框
    
    if config.anchor then
        button:SetPoint(unpack(config.anchor))
    end
    
    -- 处理text参数，支持函数类型
    local buttonText = config.text or ""
    if type(buttonText) == "function" then
        buttonText = buttonText()
    end
    button:SetText(buttonText)
    button:SetNormalFontObject("GameFontNormal")
    
    -- 设置初始状态颜色（将由UpdateButtonStates统一管理）
    button:GetFontString():SetTextColor(0.2, 0.2, 0.2)  -- 初始灰色，等待UpdateButtonStates更新
    
    -- 点击事件处理
    button:SetScript("OnClick", function(self, mouseButton)
        if mouseButton == "RightButton" and config.name == "CoolDownButton" then
            -- 右键点击主要爆发按钮：切换自动关闭功能
            HekiliProDB.autoCloseCooldowns = not HekiliProDB.autoCloseCooldowns
            if not HekiliProDB.autoCloseCooldowns then
                stopCooldownsAutoClose()
            end
        elseif mouseButton == "RightButton" and config.name == "MinorCDButton" then
            -- 右键点击次要爆发按钮：切换联动状态
            Hekili.DB.profile.toggles.essences.override = not Hekili.DB.profile.toggles.essences.override
            
            -- 刷新提示信息
            if GameTooltip:GetOwner() == button then
                GameTooltip:SetText(config.tip())
                GameTooltip:Show()
            end
        else
            -- 左键点击：正常切换功能
            local newValue = not config.getter()
            config.setter(newValue)
            
            -- 更新按钮颜色
            local r, g, b = 0.2, 0.2, 0.2  -- 默认灰色
            if newValue then
                r, g, b = 0, 1, 0  -- 绿色表示激活
            end
            button:GetFontString():SetTextColor(r, g, b)
        end
        
        -- 更新按钮文字（支持动态文本）
        if config.text and type(config.text) == "function" then
            button:SetText(config.text())
        end
    end)
    
    -- 注册右键点击
    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    
    -- 鼠标悬停效果和提示
    button:SetScript("OnEnter", function()
        -- 悬停时背景稍微亮一些
        button:SetBackdropColor(0.1, 0.1, 0.1, 0.7)
        button:SetBackdropBorderColor(0, 0, 0, 1)
        
        -- 显示提示信息
        if config.tip then
            GameTooltip:SetOwner(button, "ANCHOR_TOP")
            local tipText = type(config.tip) == "function" and config.tip() or config.tip
            GameTooltip:SetText(tipText)
            GameTooltip:Show()
        end
    end)
    
    button:SetScript("OnLeave", function()
        -- 恢复原始背景颜色
        button:SetBackdropColor(0, 0, 0, 0.5)
        button:SetBackdropBorderColor(0, 0, 0, 1)
        
        -- 隐藏提示
        if config.tip then
            GameTooltip:Hide()
        end
    end)
    
    return button
end
-- 创建精简模式UI（需要在关闭按钮之前定义）
local cpCompact = CreateFrame('Frame', 'Hekili_Pro_Compact', UIParent)

-- 配置精简模式UI
C_Timer.After(1, function()
    if HekiliDisplayPrimary then
        -- 将精简模式定位在Hekili窗口的上方
        cpCompact:ClearAllPoints()
        cpCompact:SetPoint('BOTTOMLEFT', HekiliDisplayPrimary, 'TOPLEFT', 0, 1)
    else
        cpCompact:ClearAllPoints()
        cpCompact:SetPoint('TOPLEFT', MultiBarBottomLeft, 'BOTTOMLEFT', 0, 50)
    end
    
    -- 在定位完成后创建按钮
    createCompactButtons()
end)

cpCompact:SetSize(140, 20)  -- 精简模式更小的尺寸
-- 精简模式不可移动，始终跟随Hekili
cpCompact:SetMovable(false)
cpCompact:EnableMouse(true)  -- 启用鼠标交互以支持按钮点击
cpCompact:SetClampedToScreen(false)
-- 明确禁用拖拽事件，防止SetUserPlaced()错误
cpCompact:SetScript('OnMouseDown', nil)
cpCompact:SetScript('OnMouseUp', nil)
-- 注意：不调用SetUserPlaced()，因为框架不可移动时会产生错误
-- 精简模式不需要拖拽功能，因为它始终定位在Hekili上方

-- 添加ndui风格的背景
local bg = cpCompact:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints(cpCompact)
bg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
bg:SetVertexColor(0, 0, 0, 0.3)  -- 半透明黑色背景

-- 添加边框效果
local border = CreateFrame("Frame", nil, cpCompact, "BackdropTemplate")
border:SetAllPoints(cpCompact)
border:SetBackdrop({
    edgeFile = "Interface\\Buttons\\WHITE8x8",
    edgeSize = 1,
})
border:SetBackdropBorderColor(0, 0, 0, 1)  -- 深灰色边框

-- cpCompact滚轮事件已在统一函数中处理
cpCompact:SetFrameStrata("MEDIUM")
cpCompact:Hide()  -- 默认隐藏
cpCompact:SetAlpha(1)

-- 模式切换按钮字典
local Hekili_mode_dict = {
    ["automatic"] = "自",
    ["single"] = "单",
    ["aoe"] = "群",
    ["dual"] = "双",
    ["reactive"] = "响",
    ["funnel"] = "漏"
}

-- 精简模式按钮配置
local compactButtonConfigs = {
    {
        var = "compactBtnPause",
        name = "CompactPauseButton",
        text = "启",
        getter = function() return not Hekili.Pause end,
        onClick = function() Hekili.Pause = not Hekili.Pause end,
        anchor = { "TOPLEFT", cpCompact, "TOPLEFT", 2, -1 },
        tip = "启停Hekili"
    },
    {
        var = "compactBtnCD",
        name = "CompactCDButton",
        text = function()
            local remaining = getCooldownsRemainingTime()
            if remaining > 0 then
                return math.ceil(remaining)
            else
                if HekiliProDB.autoCloseCooldowns then
                    return tostring(HekiliProDB.cooldownsAutoCloseTime or 30)
                else
                    return "爆"
                end
            end
        end,
        getter = function() return Hekili.DB.profile.toggles.cooldowns.value end,
        setter = function(v) 
            Hekili:FireToggle('cooldowns') 
            -- 检查是否需要联动次要爆发
            if Hekili.DB.profile.toggles.cooldowns.value and 
               Hekili.DB.profile.toggles.essences and 
               Hekili.DB.profile.toggles.essences.override then
                -- 如果主要爆发开启且设置了联动，同时开启次要爆发
                if not Hekili.DB.profile.toggles.essences.value then
                    Hekili:FireToggle('essences')
                end
            end
        end,
        anchor = { "LEFT", "compactBtnPause", "RIGHT", 2, 0 },
        tip = function()
            local keyText = Hekili.DB.profile.toggles.cooldowns.key or "未设置"
            local autoText = HekiliProDB.autoCloseCooldowns and "|cff00ff00开启|r" or "|cffff0000关闭|r"
            local linkText = (Hekili.DB.profile.toggles.essences and Hekili.DB.profile.toggles.essences.override) and "|cff00ff00开启|r" or "|cffff0000关闭|r"
            local remaining = getCooldownsRemainingTime()
            if remaining > 0 then
                return string.format("主要爆发\n快捷键: %s\n自动关闭: %s\n\n定时关闭时会同时关闭次要爆发\n右键切换自动关闭", keyText, autoText, linkText, math.ceil(remaining))
            else
                return string.format("主要爆发\n快捷键: %s\n自动关闭: %s\n\n定时关闭时会同时关闭次要爆发\n右键切换自动关闭", keyText, autoText, linkText)
            end
        end
    },
    {
        var = "compactBtnMinorCD",
        name = "CompactMinorCDButton",
        text = function()
            local isLinked = (Hekili.DB.profile.toggles.essences and Hekili.DB.profile.toggles.essences.override)
            return isLinked and "爆" or "暴"
        end,
        getter = function() return Hekili.DB.profile.toggles.essences.value end,
        setter = function(v) Hekili:FireToggle('essences') end,
        anchor = { "LEFT", "compactBtnCD", "RIGHT", 2, 0 },
        tip = function()
            local keyText = Hekili.DB.profile.toggles.essences.key or "未设置"
            local isLinked = (Hekili.DB.profile.toggles.essences and Hekili.DB.profile.toggles.essences.override)
            local linkText = isLinked and "|cff00ff00开启|r" or "|cffff0000关闭|r"
            return string.format("次要爆发\n快捷键: %s\n主次爆发联动: %s\n\n右键切换主次爆发联动", keyText, linkText)
        end
    },
    {
        var = "compactBtnInterrupt",
        name = "CompactInterruptButton",
        text = "断",
        getter = function() return Hekili.DB.profile.toggles.interrupts.value end,
        setter = function(v) Hekili:FireToggle('interrupts') end,
        anchor = { "LEFT", "compactBtnMinorCD", "RIGHT", 2, 0 },
        tip = function()
            return "打断\n" .. (Hekili.DB.profile.toggles.interrupts.key or "未设置")
        end
    },
    {
        var = "compactBtnDefensives",
        name = "CompactDefensivesButton",
        text = "防",
        getter = function() return Hekili.DB.profile.toggles.defensives.value end,
        setter = function(v) Hekili:FireToggle('defensives') end,
        anchor = { "LEFT", "compactBtnInterrupt", "RIGHT", 2, 0 },
        tip = function()
            return "防御\n" .. (Hekili.DB.profile.toggles.defensives.key or "未设置")
        end
    },
    {
        var = "compactBtnPotion",
        name = "CompactPotionButton",
        text = "药",
        getter = function() return Hekili.DB.profile.toggles.potions.value end,
        setter = function(v) Hekili:FireToggle('potions') end,
        anchor = { "LEFT", "compactBtnDefensives", "RIGHT", 2, 0 },
        tip = function()
            return "药剂\n" .. (Hekili.DB.profile.toggles.potions.key or "未设置")
        end
    },
    {
        var = "compactBtnMode",
        name = "CompactModeButton",
        text = function() return Hekili_mode_dict[Hekili.DB.profile.toggles.mode.value] or "自" end,
        getter = function() return true end,  -- 模式按钮始终显示为激活状态
        onClick = function()
            -- 直接调用Hekili内置的模式切换功能
            Hekili:FireToggle('mode')
        end,
        anchor = { "LEFT", "compactBtnPotion", "RIGHT", 2, 0 },
        tip = function() return "当前模式: " .. (Hekili_mode_dict[Hekili.DB.profile.toggles.mode.value] or "自动") end
    }
}

-- 精简模式按钮创建函数
function createCompactButtons()
    for _, config in ipairs(compactButtonConfigs) do
        -- 处理anchor中的字符串引用
        if type(config.anchor[2]) == "string" then
            config.anchor[2] = _G[config.anchor[2]]
        end
        
        -- 创建按钮并赋值给全局变量
        local buttonConfig = {
            name = config.name,
            text = config.text,
            getter = config.getter,
            setter = config.setter,
            onClick = config.onClick,
            width = 18,
            height = 18,
            anchor = config.anchor,
            tip = config.tip
        }
        
        _G[config.var] = thj.createCompactButton(buttonConfig)
    end
end

-- 重复的compactButtonConfigs配置已移动到前面

-- 重复的createCompactButtons函数已移动到前面

-- 精简模式按钮创建函数
function thj.createCompactButton(config)
    local button = CreateFrame("Button", config.name, cpCompact)
    button:SetSize(config.width or 18, config.height or 18)
    
    if config.anchor then
        button:SetPoint(unpack(config.anchor))
    end
    
    -- 处理text参数，支持函数类型
    local buttonText = config.text or ""
    if type(buttonText) == "function" then
        buttonText = buttonText()
    end
    button:SetText(buttonText)
    button:SetNormalFontObject("GameFontNormal")
    
    -- 设置初始状态颜色
    local isActive = config.getter()
    local r, g, b = 0.2, 0.2, 0.2  -- 默认灰色
    if isActive then
        r, g, b = 0, 1, 0  -- 绿色表示激活
    end
    button:GetFontString():SetTextColor(r, g, b)
    
    -- 点击事件处理
    button:SetScript("OnClick", function(self, mouseButton)
        if mouseButton == "RightButton" and config.name == "CompactCDButton" then
            -- 右键点击主要爆发按钮：切换自动关闭功能
            HekiliProDB.autoCloseCooldowns = not HekiliProDB.autoCloseCooldowns
            if not HekiliProDB.autoCloseCooldowns then
                stopCooldownsAutoClose()
            end
            -- 立即刷新提示信息
            if GameTooltip:IsOwned(button) then
                local tipText = type(config.tip) == "function" and config.tip() or config.tip
                GameTooltip:SetText(tipText)
                GameTooltip:Show()
            end
        elseif mouseButton == "RightButton" and config.name == "CompactMinorCDButton" then
            -- 右键点击次要爆发按钮：切换联动选项
            if Hekili.DB.profile.toggles.essences then
                Hekili.DB.profile.toggles.essences.override = not Hekili.DB.profile.toggles.essences.override
                -- 更新按钮文字
                if type(config.text) == "function" then
                    button:SetText(config.text())
                end
                -- 立即刷新提示信息
                if GameTooltip:IsOwned(button) then
                    local tipText = type(config.tip) == "function" and config.tip() or config.tip
                    GameTooltip:SetText(tipText)
                    GameTooltip:Show()
                end
            end
        else
            -- 左键点击：正常功能
            if config.onClick then
                config.onClick()
            else
                local newValue = not config.getter()
                config.setter(newValue)
            end
        end
        
        -- 更新按钮文本（支持动态文本）
        if config.text and type(config.text) == "function" then
            button:SetText(config.text())
        end
        
        -- 颜色更新由UpdateCompactButtonStates统一管理，这里不再单独设置
    end)
    
    -- 注册右键点击
    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    
    -- 鼠标悬停提示
    if config.tip then
        button:SetScript("OnEnter", function()
            GameTooltip:SetOwner(button, "ANCHOR_TOP")
            local tipText = type(config.tip) == "function" and config.tip() or config.tip
            GameTooltip:SetText(tipText)
            GameTooltip:Show()
        end)
        
        button:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
    end
    
    return button
end

-- 更新精简模式按钮状态的函数
local function UpdateCompactButtonStates()
    if HekiliDisplayPrimary and cpCompact and cpCompact:IsVisible() and _G.compactBtnPause then
        -- Hekili标志性蓝紫色渐变色彩定义（从左到右渐变）- 提亮版本
        local gradientColors = {
            {0.20, 0.40, 1.00},    -- 高饱和度Hekili蓝（最左）
            {0.28, 0.42, 0.98},    -- 蓝紫过渡色1 - 增强饱和度
            {0.36, 0.44, 0.96},    -- 蓝紫过渡色2 - 平衡蓝紫
            {0.44, 0.46, 0.94},    -- 蓝紫过渡色3 - 偏向紫色
            {0.52, 0.48, 0.92},    -- 蓝紫过渡色4 - 更多紫色
            {0.60, 0.44, 0.90},    -- 蓝紫过渡色5 - 接近Pro紫
            {0.68, 0.38, 0.88}     -- 高饱和度Pro紫（最右）
        }
        local inactiveGray = {0.2, 0.2, 0.2}     -- 未激活灰色
        
        local buttons = {
            {btn = _G.compactBtnPause, active = not Hekili.Pause, colorIndex = 1},
            {btn = _G.compactBtnCD, active = Hekili.DB.profile.toggles.cooldowns.value, colorIndex = 2},
            {btn = _G.compactBtnMinorCD, active = Hekili.DB.profile.toggles.essences.value, colorIndex = 3},
            {btn = _G.compactBtnInterrupt, active = Hekili.DB.profile.toggles.interrupts.value, colorIndex = 4},
            {btn = _G.compactBtnDefensives, active = Hekili.DB.profile.toggles.defensives.value, colorIndex = 5},
            {btn = _G.compactBtnPotion, active = Hekili.DB.profile.toggles.potions.value, colorIndex = 6},
            {btn = _G.compactBtnMode, active = true, colorIndex = 7}  -- 模式按钮总是激活
        }
        
        -- 更新每个按钮的颜色
        for _, buttonInfo in ipairs(buttons) do
            local r, g, b
            if buttonInfo.active then
                r, g, b = unpack(gradientColors[buttonInfo.colorIndex])
            else
                r, g, b = unpack(inactiveGray)
            end
            buttonInfo.btn:GetFontString():SetTextColor(r, g, b)
        end
        
        -- 特殊处理启停按钮文字
        _G.compactBtnPause:SetText(Hekili.Pause and "停" or "启")
        
        -- 特殊处理主要爆发按钮文字（动态倒计时）
        local remaining = getCooldownsRemainingTime()
        if remaining > 0 then
            _G.compactBtnCD:SetText(math.ceil(remaining))
        else
            if HekiliProDB.autoCloseCooldowns then
                _G.compactBtnCD:SetText(tostring(HekiliProDB.cooldownsAutoCloseTime or 30))
            else
                _G.compactBtnCD:SetText("爆")
            end
        end
        
        -- 特殊处理次要爆发按钮文字（联动状态显示）
        local isLinked = (Hekili.DB.profile.toggles.essences and Hekili.DB.profile.toggles.essences.override)
        _G.compactBtnMinorCD:SetText(isLinked and "爆" or "暴")
        
        -- 特殊处理模式按钮文字
        _G.compactBtnMode:SetText(Hekili_mode_dict[Hekili.DB.profile.toggles.mode.value] or "自")
    end
end

-- 更新按钮状态的函数
local function UpdateButtonStates()
    if HekiliDisplayPrimary then
        -- 标准模式渐变色定义（4排按钮，每排一个颜色）
        local standardGradientColors = {
            {0.20, 0.40, 1.00},    -- 第1排：高饱和度Hekili蓝
            {0.36, 0.44, 0.96},    -- 第2排：蓝紫过渡色
            {0.52, 0.48, 0.92},    -- 第3排：偏紫色调
            {0.68, 0.38, 0.88}     -- 第4排：高饱和度Pro紫
        }
        local inactiveGray = {0.2, 0.2, 0.2}  -- 未激活灰色
        
        -- 第1排：爆发按钮
        local r, g, b = unpack(inactiveGray)
        if Hekili.DB.profile.toggles.cooldowns.value then
            r, g, b = unpack(standardGradientColors[1])
        end
        --btnCD:GetFontString():SetTextColor(r, g, b)
        
        r, g, b = unpack(inactiveGray)
        if Hekili.DB.profile.toggles.essences.value then
            r, g, b = unpack(standardGradientColors[1])
        end
        --btnMinorCD:GetFontString():SetTextColor(r, g, b)
        
        -- 第2排：防御、打断、药剂按钮
        r, g, b = unpack(inactiveGray)
        if Hekili.DB.profile.toggles.defensives.value then
            r, g, b = unpack(standardGradientColors[2])
        end
        --btnDefensives:GetFontString():SetTextColor(r, g, b)
        
        r, g, b = unpack(inactiveGray)
        if Hekili.DB.profile.toggles.interrupts.value then
            r, g, b = unpack(standardGradientColors[2])
        end
        --btnInterrupt:GetFontString():SetTextColor(r, g, b)
        
        r, g, b = unpack(inactiveGray)
        if Hekili.DB.profile.toggles.potions.value then
            r, g, b = unpack(standardGradientColors[2])
        end
        --btnPotion:GetFontString():SetTextColor(r, g, b)
        
        -- 第3排：模式按钮
        local currentMode = Hekili.DB.profile.toggles.mode.value
        
        r, g, b = unpack(inactiveGray)
        if currentMode == "automatic" then
            r, g, b = unpack(standardGradientColors[3])
        end
        --btnAuto:GetFontString():SetTextColor(r, g, b)
        
        r, g, b = unpack(inactiveGray)
        if currentMode == "aoe" then
            r, g, b = unpack(standardGradientColors[3])
        end
        --btnAOE:GetFontString():SetTextColor(r, g, b)
        
        r, g, b = unpack(inactiveGray)
        if currentMode == "single" then
            r, g, b = unpack(standardGradientColors[3])
        end
        --btnSingle:GetFontString():SetTextColor(r, g, b)
        
        -- 第4排：双显、漏斗按钮
        r, g, b = unpack(inactiveGray)
        if currentMode == "dual" then
            r, g, b = unpack(standardGradientColors[4])
        end
        --btnDual:GetFontString():SetTextColor(r, g, b)
        
        r, g, b = unpack(inactiveGray)
        if currentMode == "funnel" then
            r, g, b = unpack(standardGradientColors[4])
        end
        --btnFunnel:GetFontString():SetTextColor(r, g, b)
    end
end

-- 创建一个帧来持续更新按钮状态
local updateFrame = CreateFrame("Frame")
updateFrame:SetScript("OnUpdate", function()
    UpdateButtonStates()
    UpdateCompactButtonStates()
    
    -- 更新动态文字（主要爆发按钮的倒计时）
    if btnCD and btnCD:IsVisible() then
        local remaining = getCooldownsRemainingTime()
        if remaining > 0 then
            btnCD:SetText(string.format("爆发(%d秒)", math.ceil(remaining)))
        else
            if HekiliProDB.autoCloseCooldowns then
                btnCD:SetText(string.format("倒计时%d秒", HekiliProDB.cooldownsAutoCloseTime or 30))
            else
                btnCD:SetText("主要爆发")
            end
        end
    end
end)

-- 爆发状态监控系统
local lastCooldownsState = false
local monitorFrame = CreateFrame("Frame")

local function monitorCooldownsState()
    if not Hekili or not Hekili.DB or not Hekili.DB.profile or not Hekili.DB.profile.toggles then
        return
    end
    
    local currentState = Hekili.DB.profile.toggles.cooldowns.value
    
    -- 检测状态变化
    if currentState ~= lastCooldownsState then
        lastCooldownsState = currentState
        
        if currentState then
            -- 爆发模式开启，启动倒计时
            startCooldownsAutoClose()
            -- 检查是否需要联动次要爆发
            if Hekili.DB.profile.toggles.essences and 
               Hekili.DB.profile.toggles.essences.override and
               not Hekili.DB.profile.toggles.essences.value then
                Hekili:FireToggle('essences')
            end
        else
            -- 爆发模式关闭，停止倒计时
            stopCooldownsAutoClose()
        end
    end
end

-- 设置监控帧的OnUpdate脚本，每0.1秒检查一次状态
local lastCheck = 0
monitorFrame:SetScript("OnUpdate", function(self, elapsed)
    lastCheck = lastCheck + elapsed
    if lastCheck >= 0.1 then
        monitorCooldownsState()
        lastCheck = 0
    end
end)

-- 初始化监控系统
C_Timer.After(1, function()
    if Hekili and Hekili.DB and Hekili.DB.profile and Hekili.DB.profile.toggles then
        lastCooldownsState = Hekili.DB.profile.toggles.cooldowns.value
    end
end)

-- UI模式初始化：根据保存的模式显示对应界面
C_Timer.After(2, function()
 
        cpCompact:Show()
end)
