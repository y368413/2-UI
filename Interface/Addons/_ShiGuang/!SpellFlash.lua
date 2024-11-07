--[[
基础UI库
1. 创建窗口、文字、按钮、勾选框
2. 提供自动交互
]] 
local thj = {}
thj.createFrame = function(name, parent, monitorEvents)
    local f = CreateFrame("Frame", name, parent or UIParent);
    if monitorEvents then
        f:SetScript("OnEvent", function(self, evtName, ...)
            if self[evtName] then
                if evtName == "COMBAT_LOG_EVENT_UNFILTERED" then
                    local timestamp, subEvt, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, extraArg1, extraArg2, extraArg3, extraArg4, extraArg5, extraArg6, extraArg7, extraArg8, extraArg9, extraArg10 = CombatLogGetCurrentEventInfo()
                    if self[subEvt] then
                        self[subEvt](self, sourceGUID, sourceName, destGUID, destName, extraArg1, extraArg2, extraArg3, extraArg4, extraArg5, extraArg6, extraArg7, extraArg8, extraArg9, extraArg10);
                    end
                else
                    self[evtName](self, evtName, ...);
                end
            end
        end)
    end
    return f;
end
local monitorFrame = thj.createFrame("SFCMonitorFrame", nil);
local switchButtonRegistry = {}
function updateSwitchButtons()
    for k, v in pairs(switchButtonRegistry) do
        local btn, opt = v.btn, v.opt;
        local onText, offText = opt.onText or opt.text or "ON", opt.offText or opt.text or "OFF";
        local v = opt.getter();
        if v then
            btn:SetText(onText)
            -- set all textures
            btn.Left:SetDesaturated(false)
            btn.Middle:SetDesaturated(false)
            btn.Right:SetDesaturated(false)
        else
            btn:SetText(offText)
            btn.Left:SetDesaturated(true)
            btn.Middle:SetDesaturated(true)
            btn.Right:SetDesaturated(true)
        end
    end
end
-- 每隔1s检测全局量Hekili.DB.profile.toggles.cooldowns.value的值，如果为true，则显示文字为"Pause"，否则显示为"Run"
monitorFrame:SetScript('OnUpdate', function(self, elapsed)
    self.elapsed = (self.elapsed or 0) + elapsed
    if self.elapsed >= 0.1 then
        self.elapsed = 0 -- 重置计时器
        -- 刷新按钮状态
        updateSwitchButtons()
    end
end)
thj.createSwitchButton = function(opt)
    local name = opt.name or "SwitchButton"
    local parent = opt.parent or UIParent;
    local onText, offText = opt.onText or opt.text or "ON", opt.offText or opt.text or "OFF";
    local w, h = opt.width or 80, opt.height or 20;
    local anchor = opt.anchor or {"TOPLEFT", 0, 0};
    local stateQueryFunc, stateSetFunc = opt.getter, opt.setter;
    local btn = CreateFrame('Button', name, parent, 'UIPanelButtonTemplate')
    local tip = opt.tip
    btn:SetWidth(w)
    btn:SetHeight(h)
    btn:SetPoint(unpack(anchor))
    btn:SetText(onText)
    btn:SetScript('OnClick', function()
        local curState = stateQueryFunc()
        btn:SetText(curState and offText or onText)
        btn.Left:SetDesaturated(not curState)
        btn.Middle:SetDesaturated(not curState)
        btn.Right:SetDesaturated(not curState)
        stateSetFunc(not curState)
    end)
    switchButtonRegistry[name] = {
        btn = btn,
        opt = opt
    }
    if tip then
        local isFunction = type(tip) == "function"
        btn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
            GameTooltip:AddLine(isFunction and tip() or tip)
            GameTooltip:Show()
        end)
        btn:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)
    end
    return btn;
end

--[[
	<Button name="UIPanelButtonGrayTemplate" virtual="true">
		<NormalTexture inherits="UIPanelButtonDisabledTexture"/>        Interface\Buttons\UI-Panel-Button-Disabled
		<PushedTexture inherits="UIPanelButtonDisabledDownTexture"/>    Interface\Buttons\UI-Panel-Button-Disabled-Down
		<DisabledTexture inherits="UIPanelButtonDisabledTexture"/>      Interface\Buttons\UI-Panel-Button-Disabled
		<HighlightTexture inherits="UIPanelButtonHighlightTexture"/>
	</Button>
]]


_G["SpellFlashCore"] = thj
_G["SFC"] = thj
thj.info = {
    key = nil,
    keyAlt = nil,
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
local SIZE = 5;
local sfo = thj.createFrame("SFOFrame", UIParent, true)
local lastUpdate = 0;
sfo:SetScript("OnUpdate", function(self, elapsed)
    lastUpdate = lastUpdate + elapsed;
    -- 每秒更新坐骑状态，当在坐骑上时不释放技能，否则马上进入战斗，放个技能又下马了
    if lastUpdate > 0.1 then
        -- print("OnUpdate.elapsed = ", lastUpdate)
        lastUpdate = 0;
        thj.isMounted = IsMounted("player");
        thj.Repaint();
    end
end)
sfo:SetPoint("TOPLEFT", 0, 0);
sfo:SetFrameStrata("HIGH")
sfo:SetFrameLevel(10000)
sfo:SetSize(200, 10);

thj.frame = sfo;

--[[
    CombatLogGetCurrentEventInfo()
]]
thj.SpellBook = {
    -- ZS
    Berserk = 18499,
    SpellReflection = 23920
}

local keyMapping = {
    ["BACKSPACE"] = 8,
    ["TAB"] = 9,
    ["ENTER"] = 13,
    ["SPACE"] = 32,
    ["MOUSEWHEELDOWN"] = 174,
    ["MOUSEWHEELUP"] = 175,
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


--[[ 创建UI ]]
local sfo = thj.frame  --thj.createFrame("SpellFlashCoreFrame");

local SIZE = 5;
local tx = sfo:CreateTexture(nil, "ARTWORK");
tx:SetColorTexture(1, 1, 0);
tx:SetSize(SIZE, SIZE);
tx:SetPoint("TOPLEFT", sfo, "TOPLEFT", 0, 0)
thj.tx = tx;
local tx2 = sfo:CreateTexture(nil, "ARTWORK");
tx2:SetColorTexture(1, 1, 0);
tx2:SetSize(SIZE, SIZE);
tx2:SetPoint("TOPLEFT", tx, "TOPRIGHT", 0, 0)
thj.txAlt = tx2;
--[[local text = sfo:CreateFontString()
text:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
text:SetText("-")
text:SetPoint("TOPLEFT", tx2, "TOPRIGHT", 5, 0)
thj.debugger = text;]]
--[[
    注册重绘方法
    /dump SpellFlashCore.info
    /dump SpellFlashCore.keyMapping["6"]
    /dump SpellFlashCore.keyMapping["嗜血"]
]]
--[[
    --界面重绘--
    r:[AABBCC00]  AA-Control            BB-Alt                          CC-Shift
    g:[XXXXXXXX]  KeyCode
    b:[AABB0000]  AA-Combat Flag        BB-Channel/Quest Flag
]]
local function getSpellColor(key)
    local r, g, b;
    local f = thj.info;
    local km = thj.keyMapping[key or ""];
    if not km then
        r = 0;
        g = 0;
    else
        -- r = 组合键标志位<CCAASS00> ctrl | alt | shift  
        r = (km.control and 1 or 0) * 0xC0 + (km.alt and 1 or 0) * 0x30 +
                (km.shift and 1 or 0) * 0xC
        r = r / 255;
        -- g = 按键编码
        g = km.key / 255;
    end
    -- b = 标志位：战斗状态 | 通道施法
    b = ((f.isCombat and not thj.isMounted) and 1 or 0) * 0xC0 + (f.isChanneling and 1 or 0) * 0x30;
    b = b / 255;
    return r, g, b;
end
thj.Repaint = function()
    local dot = thj.tx;
    local f = thj.info;
    local r, g, b = getSpellColor(f.key);
    -- print("----------Repaint",r,g,b)
    thj.tx:SetColorTexture(r, g, b);
    r, g, b = getSpellColor(f.keyAlt);
    -- print("Repaint alt",r,g,b)
    thj.txAlt:SetColorTexture(r, g, b);
end
thj.Log = function(msg) 
    --thj.debugger:SetText(msg) 
    print(msg)
end

local log = thj.logger;
local sfo = thj.frame;
local GetSpellInfo = C_Spell.GetSpellInfo
local Hekili
local allTimer
--[[
    事件注册
]]
sfo:RegisterEvent("ADDON_LOADED")
function sfo:ADDON_LOADED(evt, name)
    if (name == "Hekili") then
        Hekili = _G["Hekili"]
    end
end

-- 战斗状态指示
sfo:RegisterEvent("PLAYER_REGEN_ENABLED")
function sfo:PLAYER_REGEN_ENABLED()
    thj.SetCombat(false)
end
sfo:RegisterEvent("PLAYER_REGEN_DISABLED")
function sfo:PLAYER_REGEN_DISABLED()
    thj.SetCombat(true)
end
-- Chennel状态指示 
sfo:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
function sfo:UNIT_SPELLCAST_CHANNEL_START()
    thj.info.isChanneling = true;
    thj.Repaint();
end
sfo:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", "player")
function sfo:UNIT_SPELLCAST_CHANNEL_STOP()
    thj.info.isChanneling = false;
    thj.Repaint();
end

--[[
    SFO API
]]

--[[                                  公共方法                              ]]
--[[
    设置战斗状态
]]
thj.SetCombat = function(flag)
    thj.info.isCombat = flag;
    thj.Repaint();
end
--[[
    设置通道施法状态
]]
thj.SetChanneling = function(flag)
    thj.info.isChanneling = flag;
    thj.Repaint();
end
thj.FlashFrame = function()
end
--[[
    根据按键进行技能提示
]]
thj.FlashKey = function(key, slot)
    -- print("FlashKey->", key, slot)
    -- 战斗 或者 通道施法状态 不响应
    if not thj.info.isCombat and not thj.info.isChanneling then
        return
    end
    if not key then
        return
    end
    thj.info["key" .. (slot or "")] = key;
    thj.Repaint();
    return;
end
--[[
    API: 根据技能ID获取技能名称
    @param id: 技能ID
    @returns 技能名称
]]
thj.SpellName = function(id)
    if not id or id < 0 then
        log.Error("|cffff2020 Spell: ID must NOT EMPTY!|r")
        return nil
    end
    local hekiliDef = Hekili.Class.abilities[id]
    if not hekiliDef then
        log.Error("|cffff2020 Spell: {1} not found in HEKILI!|r", id)
        return nil
    end
    return hekiliDef.name;
end
thj.Flashable = function(spell)
    return true
end;
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
--[[
    API: 根据技能名称提示技能
    @param spellName: 技能名称
]]
thj.FlashAction = function(spellName)
    -- print("FlashAction ->", spellName) 
    local id, name, key = GetSpellMeta(spellName);
    if not id or not key then
        return nil
    end
    thj.FlashKey(key)
end
--[[
    API: 根据技能名称提示技能
    @param spellName: 技能名称
]]
thj.FlashAction2 = function(spellName)
    local id, name, key = GetSpellMeta(spellName);
    if not id or not key then
        return nil
    end
    thj.FlashKey(key, "Alt")
end
--[[
    API: 根据物品ID获取物品名称
    @param id: 物品ID
    @returns 物品名称
]]
thj.ItemName = function(id)
    if not id then
        return nil
    end
    -- print("ItemName->"..id)
    local name = thj.items[id];
    if not name then
        name = GetItemInfo(id);
        thj.items[id] = name;
    end
    local hd = Hekili.Class.abilities[name]
    if not hd then
        return nil
    end
    return hd.name;
end
--[[
    API: 根据物品名称提示物品使用
    @param spellName: 物品名称
    @param color: 忽视
]]
thj.FlashItem = function(itemName, color)
    local id, name, key = GetSpellMeta(itemName);
    if not id or not key then
        return nil
    end
    thj.FlashKey(key)
end
thj.StartQuesting = function()
    thj.info.isQuesting = true;
end
thj.StopQuesting = function()
    thj.info.isQuesting = false;
end

local cp = CreateFrame('Frame', 'hkc', UIParent)
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
--texture:SetTexture("Interface\\Addons\\_ShiGuang\\Media\\Emotes\\禁")
--texture:SetAllPoints(cpIcon)
local cptext = cpIcon:CreateFontString()
cptext:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
cptext:SetText("Hekili")
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
--[[local btnCD = thj.createSwitchButton({
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