-------------------------------------------------------------------------------
--
--  Mod Name : BlinkHealthText 3.5
--  Author   : Blink
--  Date     : 2005/05/10
--  LastUpdate : 2026/01/25
--
-------------------------------------------------------------------------------
local moduleName = "BlinkHealthTextConfig"
local guiConfig = {}
_G[moduleName] = guiConfig

guiConfig.addon = nil


-------------------------------------------------------------------------------
-- local variables
-------------------------------------------------------------------------------

local BHTL = {
	BLINKHEALTHTEXT = "Blink的生命值文本",
	BLINKHEALTHTEXT_TITLE = "Blink的生命值文本 (HUD)",
	BHT_DESCRIPTION = "在角色两侧以数字形式显示玩家和目标的生命值和能量值。",
	ADDON_ENABLE = "启用",
	ADDON_ENABLE_TOOLTIP = "启用此插件。",
	GENERAL = "通用",
	FONT = "字体",
	FONT_TOOLTIP = "字体设置。",
	FONT_OUTLINE = "字体轮廓",
	FONT_OUTLINE_TOOLTIP = "字体轮廓设置。",
	FONT_OUTLINE_NONE = "无",
	FONT_OUTLINE_THIN = "细",
	FONT_OUTLINE_THICK = "粗",
	HP_SIZE = "生命值大小",
	HP_SIZE_TOOLTIP = "调整生命值文本的字体大小。",
	POWER_SIZE = "能量值大小",
	POWER_SIZE_TOOLTIP = "调整能量值文本的字体大小。",
	ENABLE_CLASS_MODULE = "启用职业模块",
	ENABLE_CLASS_MODULE_TOOLTIP = "显示你的连击点数、激活的法术图标等。",
	X_POSISTION = "水平位置 (X)",
	X_POSISTION_TOOLTIP = "水平位置 (X)",
	Y_POSISTION = "垂直位置 (Y)",
	Y_POSISTION_TOOLTIP = "垂直位置 (Y)",
	PLAYER = "玩家",
	HIDE_OUT_OF_COMBAT_PLAYER = "非战斗时隐藏",
	HIDE_OUT_OF_COMBAT_PLAYER_TOOLTIP = "非战斗时淡化玩家文本。",
	SHOW_HEALTH_AS_PERCENTAGE_PLAYER = "以百分比显示生命值",
	SHOW_HEALTH_AS_PERCENTAGE_PLAYER_TOOLTIP = "以百分比而非实际数值显示生命值。",
	SHOW_POWER_AS_PERCENTAGE_PLAYER = "以百分比显示能量值",
	SHOW_POWER_AS_PERCENTAGE_PLAYER_TOOLTIP = "以百分比而非实际数值显示能量值。",
	OPACITY_PLAYER = "透明度",
	OPACITY_PLAYER_TOOLTIP = "",
	TARGET = "目标",
	HIDE_OUT_OF_COMBAT_TARGET = "非战斗时隐藏",
	HIDE_OUT_OF_COMBAT_TARGET_TOOLTIP = "非战斗时淡化目标文本。",
	SHOW_HEALTH_AS_PERCENTAGE_TARGET = "以百分比显示生命值",
	SHOW_HEALTH_AS_PERCENTAGE_TARGET_TOOLTIP = "以百分比而非实际数值显示生命值。",
	SHOW_POWER_AS_PERCENTAGE_TARGET = "以百分比显示能量值",
	SHOW_POWER_AS_PERCENTAGE_TARGET_TOOLTIP = "以百分比而非实际数值显示能量值。",
	OPACITY_TARGET = "透明度",
	OPACITY_TARGET_TOOLTIP = "",
	PET = "宠物",
	PET_HP_SIZE = "生命值大小",
	PET_HP_SIZE_TOOLTIP = "调整生命值文本的字体大小。",
	PET_POWER_SIZE = "能量值大小",
	PET_POWER_SIZE_TOOLTIP = "调整能量值文本的字体大小。",
	HIDE_OUT_OF_COMBAT_PET = "非战斗时隐藏",
	HIDE_OUT_OF_COMBAT_PET_TOOLTIP = "非战斗时淡化宠物文本。",
	SHOW_HEALTH_AS_PERCENTAGE_PET = "以百分比显示生命值",
	SHOW_HEALTH_AS_PERCENTAGE_PET_TOOLTIP = "以百分比而非实际数值显示生命值。",
	SHOW_POWER_AS_PERCENTAGE_PET = "以百分比显示能量值",
	SHOW_POWER_AS_PERCENTAGE_PET_TOOLTIP = "以百分比而非实际数值显示能量值。",
	OPACITY_PET = "透明度",
	OPACITY_PET_TOOLTIP = "",
	SHOW_RAIDICONS = "显示团队标记",
	SHOW_RAIDICONS_TOOLTIP = "显示团队标记",
	DB_MIGRATION = "BlinkHealthText 数据库重置！",
	CLASS_MISC = "职业配置",
}
-------------------------------------------------------------------------------
-- locale load
-------------------------------------------------------------------------------


local fonts = {
    {
        text = "任务",
        value = "Fonts\\FZBWJW.TTF",
        font = "Fonts\\FZBWJW.TTF",
        r = 1,
        g = .82,
        b = 0,
        size = 16,
    },
    {
        text = "默认",
        value = "Fonts\\FRIZQT__.TTF",
        font = "Fonts\\FRIZQT__.TTF",
        r = 1,
        g = .82,
        b = 0,
        size = 16,
    },
    {
        text = "伤害",
        value = "Fonts\\ARIALN.TTF",
        font = "Fonts\\ARIALN.TTF",
        r = 1,
        g = .82,
        b = 0,
        size = 16,
    },
}


local getArgs, tmp, new, del, gettext, getfunc, gettable, getbool, getvalue, showhide, disable
do
    local cache = setmetatable({}, { __mode = 'k' })
    function new()
        local t = next(cache)
        if t then
            cache[t] = nil
            return t
        else
            return {}
        end
    end

    function del(t)
        for k in pairs(t) do
            t[k] = nil
        end
        cache[t] = true
        return nil
    end

    local t = {}
    function tmp(...)
        for k in pairs(t) do
            t[k] = nil
        end
        for i = 1, select('#', ...), 2 do
            local k = select(i, ...)
            if k then
                t[k] = select(i + 1, ...)
            else
                break
            end
        end
        return t
    end

    local info = {}
    function getArgs(...)
        if type(select(1, ...)) == 'table' then
            info = select(1, ...)
        else
            info = tmp(...)
        end
        return info
    end

    function getbool(value)
        if type(value) == 'boolean' then
            return value
        elseif type(value) == 'function' then
            return value()
        end
    end

    function getvalue(value)
        if type(value) == 'function' then
            return value()
        else
            return value
        end
    end

    function gettext(text)
        if type(text) == 'string' then
            return text
        elseif type(text) == 'function' then
            return text()
        end
    end

    function gettable(t)
        if type(t) == 'table' then
            return t
        elseif type(t) == 'function' then
            return t()
        end
    end

    function getfunc(func)
        if func and type(func) == 'function' then
            return func
        elseif func and type(func) == 'string' then
            local f = getglobal(func)
            if f and type(f) == 'function' then
                return f
            end
        end
    end

    function showhide(frame, showhideValue)
        if showhideValue then
            if getbool(showhideValue) then
                frame:Show()
            else
                frame:Hide()
            end
        else
            frame:Show()
        end
    end

    function disable(frame, disableValue)
        if disableValue then
            if getbool(disableValue) then
                frame.disable()
            else
                frame.enable()
            end
        end
    end
end

-------------------------------------------------------------------------------
-- local functions
-------------------------------------------------------------------------------

local function tcopy(to, from) -- "to" must be a table (possibly empty)
    for k, v in pairs(from) do
        if (type(v) == "table") then
            if not to then to = {} end
            to[k] = {}
            tcopy(to[k], v)
        else
            to[k] = v
        end
    end
end

local function makeVariableName(variableName)
    return "PROXY_BHT_" .. variableName:upper();
end

function guiConfig:CreateCheckBox(options)
    if not options then
        return
    end
    local o = gettable(options)
    if not o.label or not o.key then
        return
    end

    local setting = Settings.RegisterProxySetting(self.category, makeVariableName(o.key), Settings.VarType.Boolean, o.label, o.defaultValue, o.get, o.set)
    local initializer = Settings.CreateCheckbox(self.category, setting, o.tooltip);

    if o.key ~= "enable" then
        initializer:SetParentInitializer(self.enableControl, function ()
            return self.addon.db.enable
        end);
    end

    return initializer
end

function guiConfig:CreateDropdown(options)
    if not options then
        return
    end
    local o = gettable(options)
    if not o.label or not o.key or not o.values then
        return
    end

    local setting = Settings.RegisterProxySetting(self.category, makeVariableName(o.key), o.varType, o.label, o.defaultValue, o.get, o.set)
    local function GetOptions()
        local container = Settings.CreateControlTextContainer();
        for i, f in pairs(o.values) do
            container:Add(f.value, f.text);
        end
        return container:GetData();
    end

    local initializer = Settings.CreateDropdown(self.category, setting, GetOptions);

    if o.key ~= "enable" then
        initializer:SetParentInitializer(self.enableControl, function ()
            return self.addon.db.enable
        end);
    end

    return initializer
end

function guiConfig:CreateSlider(options)
    if not options then
        return
    end
    local o = gettable(options)
    if not o.label or not o.key then
        return
    end
    local setting = Settings.RegisterProxySetting(self.category, makeVariableName(o.key), Settings.VarType.Number, o.label, o.defaultValue, o.get, o.set)
    local options = Settings.CreateSliderOptions(o.min, o.max, o.step);
    options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, o.format);
    local initializer = Settings.CreateSlider(self.category, setting, options, tooltip);

    if o.key ~= "enable" then
        initializer:SetParentInitializer(self.enableControl, function ()
            return self.addon.db.enable
        end);
    end

    return initializer
end

function guiConfig:CreateLabel(label)
    self.layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(label))
end

function guiConfig:registBlizzGUI(addon)
    self.addon = addon
    local category, layout = Settings.RegisterVerticalLayoutCategory("[头像]简易信息");
    category.ID = "BlinkHealthText"
    Settings.RegisterAddOnCategory(category)
    self.category = category
    self.layout = layout

    SlashCmdList["BLINKHEALTHTEXT"] = function()
        Settings.OpenToCategory("BlinkHealthText", "[头像]简易信息")
    end
    setglobal("SLASH_BLINKHEALTHTEXT1", "/bht")


    -- 사용
    guiConfig.enableControl = guiConfig:CreateCheckBox({
        label = BHTL.ADDON_ENABLE,
        tooltip = BHTL.BHT_DESCRIPTION,
        key = "enable",
        defaultValue = Settings.Default.True,
        get = function ()
            return addon.db.enable
        end,
        set = function (value)
            addon.db.enable = value
            if addon.db.enable then
                addon:EnableAddon()
            else
                addon:DisableAddon()
            end
        end,
    })

    -- 공통 설정
    guiConfig:CreateLabel(BHTL.GENERAL)

    -- 글꼴
    guiConfig:CreateDropdown({
        label = BHTL.FONT,
        tooltip = BHTL.FONT_TOOLTIP,
        key = "font",
        values = fonts,
        varType = Settings.VarType.String,
        defaultValue = "Fonts\\K_Pagetext.TTF",
        get = function ()
            return addon.db.font
        end,
        set = function (value)
            addon.db.font = value
            if addon.db.enable then
                addon:FrameFontUpdate()
            end
        end
    })

    -- 글꼴외각선
    guiConfig:CreateDropdown({
        label = BHTL.FONT_OUTLINE,
        tooltip = BHTL.FONT_OUTLINE_TOOLTIP,
        key = "fontOutline",
        values = {
            {
                text = BHTL.FONT_OUTLINE_NONE,
                value = "",
            },
            {
                text = BHTL.FONT_OUTLINE_THIN,
                value = "OUTLINE",
            },
            {
                text = BHTL.FONT_OUTLINE_THICK,
                value = "THICKOUTLINE",
            },
        },
        varType = Settings.VarType.String,
        defaultValue = "THICKOUTLINE",
        get = function ()
            return addon.db.fontOutline
        end,
        set = function (value)
            addon.db.fontOutline = value
            if addon.db.enable then
                addon:FrameFontUpdate()
            end
        end
    })

    -- 체력크기
    guiConfig:CreateSlider({
        label = BHTL.HP_SIZE,
        tooltip = BHTL.HP_SIZE_TOOLTIP,
        key = "fontSizeHealth",
        min = 10,
        max= 36,
        step = 2,
        defaultValue = 28,
        get = function ()
            return addon.db.fontSizeHealth
        end,
        set = function (value)
            addon.db.fontSizeHealth = value
            if addon.db.enable then
                addon:FrameFontUpdate()
            end
        end
    })

    -- 파워크기
    guiConfig:CreateSlider({
        label = BHTL.POWER_SIZE,
        tooltip = BHTL.POWER_SIZE_TOOLTIP,
        key = "fontSizePower",
        min = 10,
        max= 36,
        step = 2,
        defaultValue = 20,
        get = function ()
            return addon.db.fontSizePower
        end,
        set = function (value)
            addon.db.fontSizePower = value
            if addon.db.enable then
                addon:FrameFontUpdate()
            end
        end
    })

    -- 가로위치
    guiConfig:CreateSlider({
        label = BHTL.X_POSISTION,
        tooltip = BHTL.X_POSISTION_TOOLTIP,
        key = "posX",
        min = 0,
        max= 600,
        step = 10,
        defaultValue = 170,
        get = function ()
            return addon.db.posX
        end,
        set = function (value)
            addon.db.posX = value
            if addon.db.enable then
                addon:FramePositionUpdate()
            end
        end
    })

    -- 세로위치
    guiConfig:CreateSlider({
        label = BHTL.Y_POSISTION,
        tooltip = BHTL.Y_POSISTION_TOOLTIP,
        key = "posY",
        min = -400,
        max= 400,
        step = 10,
        defaultValue = 10,
        get = function ()
            return addon.db.posY
        end,
        set = function (value)
            addon.db.posY = value
            if addon.db.enable then
                addon:FramePositionUpdate()
            end
        end
    })

    -- 전술목표 아이콘
    guiConfig:CreateCheckBox({
        label = BHTL.SHOW_RAIDICONS,
        tooltip = BHTL.SHOW_RAIDICONS_TOOLTIP,
        key = "SHOW_RAID_ICONS",
        defaultValue = Settings.Default.True,
        get = function ()
            return addon.db.showRaidIcons
        end,
        set = function (value)
            addon.db.showRaidIcons = value
            if addon.db.enable then
                addon:FrameUpdate("target")
            end
        end
    })

    -- 플레이어 텍스트
    guiConfig:CreateLabel(BHTL.PLAYER)

    -- 전투시에만 보이기
    guiConfig:CreateCheckBox({
        label = BHTL.HIDE_OUT_OF_COMBAT_PLAYER,
        tooltip = BHTL.HIDE_OUT_OF_COMBAT_PLAYER_TOOLTIP,
        key = "UNIT_PLAYER_HIDE_OOC",
        defaultValue = Settings.Default.True,
        get = function ()
            return addon.db.unit.player.hideOOC 
        end,
        set = function (value)
            addon.db.unit.player.hideOOC  = value
            if addon.db.enable then
                addon.db.unit.player.hideOOC = value
				addon:FrameUpdate("player")
            end
        end
    })

    -- 체력수치 %로 표시
    guiConfig:CreateCheckBox({
        label = BHTL.SHOW_HEALTH_AS_PERCENTAGE_PLAYER,
        tooltip = BHTL.SHOW_HEALTH_AS_PERCENTAGE_PLAYER_TOOLTIP,
        key = "UNIT_PLAYER_REAL_VALUE",
        defaultValue = Settings.Default.True,
        get = function ()
            return not addon.db.unit.player.realValue
        end,
        set = function (value)
            addon.db.unit.player.realValue = not value
            if addon.db.enable then
                addon:DisplayHealthText("player")
                addon:DisplayPowerText("player")
            end
        end
    })

    -- 파워수치 %로 표시
    guiConfig:CreateCheckBox({
        label = BHTL.SHOW_POWER_AS_PERCENTAGE_PLAYER,
        tooltip = BHTL.SHOW_POWER_AS_PERCENTAGE_PLAYER_TOOLTIP,
        key = "UNIT_PLAYER_REAL_POWER_VALUE",
        defaultValue = Settings.Default.True,
        get = function ()
            return not addon.db.unit.player.realPowerValue
        end,
        set = function (value)
            addon.db.unit.player.realPowerValue = not value
            if addon.db.enable then
                addon:DisplayHealthText("player")
                addon:DisplayPowerText("player")
            end
        end
    })

    -- 투명도
    guiConfig:CreateSlider({
        label = BHTL.OPACITY_PLAYER,
        tooltip = BHTL.OPACITY_PLAYER_TOOLTIP,
        key = "UNIT_PLAYER_REAL_ALPHA",
        min = 0.1,
        max= 1.0,
        step = 0.05,
        defaultValue = 1.0,
        get = function ()
            return addon.db.unit.player.alpha
        end,
        set = function (value)
            addon.db.unit.player.alpha = value
            if addon.db.enable then
                addon:FrameUpdate("player")
            end
        end,
        format = FormatPercentage
    })


    -- 대상 텍스트
    guiConfig:CreateLabel(BHTL.TARGET)

    -- 전투시에만 보이기
    guiConfig:CreateCheckBox({
        label = BHTL.HIDE_OUT_OF_COMBAT_TARGET,
        tooltip = BHTL.HIDE_OUT_OF_COMBAT_TARGET_TOOLTIP,
        key = "UNIT_TARGET_HIDE_OOC",
        defaultValue = Settings.Default.True,
        get = function ()
            return addon.db.unit.target.hideOOC
        end,
        set = function (value)
            addon.db.unit.target.hideOOC  = value
            if addon.db.enable then
                addon.db.unit.target.hideOOC = value
				addon:FrameUpdate("target")
            end
        end
    })

    -- 체력수치 %로 표시
    guiConfig:CreateCheckBox({
        label = BHTL.SHOW_HEALTH_AS_PERCENTAGE_TARGET,
        tooltip = BHTL.SHOW_HEALTH_AS_PERCENTAGE_TARGET_TOOLTIP,
        key = "UNIT_TARGET_REAL_VALUE",
        defaultValue = Settings.Default.True,
        get = function ()
            return not addon.db.unit.target.realValue
        end,
        set = function (value)
            addon.db.unit.target.realValue = not value
            if addon.db.enable then
                addon:DisplayHealthText("target")
                addon:DisplayPowerText("target")
            end
        end
    })

    -- 파워수치 %로 표시
    guiConfig:CreateCheckBox({
        label = BHTL.SHOW_POWER_AS_PERCENTAGE_TARGET,
        tooltip = BHTL.SHOW_POWER_AS_PERCENTAGE_TARGET_TOOLTIP,
        key = "UNIT_TARGET_REAL_POWER_VALUE",
        defaultValue = Settings.Default.True,
        get = function ()
            return not addon.db.unit.target.realPowerValue
        end,
        set = function (value)
            addon.db.unit.target.realPowerValue = not value
            if addon.db.enable then
                addon:DisplayHealthText("target")
                addon:DisplayPowerText("target")
            end
        end
    })

    -- 투명도
    guiConfig:CreateSlider({
        label = BHTL.OPACITY_TARGET,
        tooltip = BHTL.OPACITY_TARGET_TOOLTIP,
        key = "UNIT_TARGET_REAL_ALPHA",
        min = 0.1,
        max= 1.0,
        step = 0.05,
        defaultValue = 1.0,
        get = function ()
            return addon.db.unit.target.alpha
        end,
        set = function (value)
            addon.db.unit.target.alpha = value
            if addon.db.enable then
                addon:FrameUpdate("target")
            end
        end,
        format = FormatPercentage
    })


    -- 소환수 텍스트
    guiConfig:CreateLabel(BHTL.PET)

    -- 전투시에만 보이기
    guiConfig:CreateCheckBox({
        label = BHTL.HIDE_OUT_OF_COMBAT_PET,
        tooltip = BHTL.HIDE_OUT_OF_COMBAT_PET_TOOLTIP,
        key = "UNIT_PET_HIDE_OOC",
        defaultValue = Settings.Default.True,
        get = function ()
            return addon.db.unit.pet.hideOOC
        end,
        set = function (value)
            addon.db.unit.pet.hideOOC  = value
            if addon.db.enable then
                addon.db.unit.pet.hideOOC = value
				addon:FrameUpdate("pet")
            end
        end
    })

    -- 체력수치 %로 표시
    guiConfig:CreateCheckBox({
        label = BHTL.SHOW_HEALTH_AS_PERCENTAGE_PET,
        tooltip = BHTL.SHOW_HEALTH_AS_PERCENTAGE_PET_TOOLTIP,
        key = "UNIT_PET_REAL_VALUE",
        defaultValue = Settings.Default.True,
        get = function ()
            return not addon.db.unit.pet.realValue
        end,
        set = function (value)
            addon.db.unit.pet.realValue = not value
            if addon.db.enable then
                addon:DisplayHealthText("pet")
                addon:DisplayPowerText("pet")
            end
        end
    })

    -- 파워수치 %로 표시
    guiConfig:CreateCheckBox({
        label = BHTL.SHOW_POWER_AS_PERCENTAGE_PET,
        tooltip = BHTL.SHOW_POWER_AS_PERCENTAGE_PET_TOOLTIP,
        key = "UNIT_PET_REAL_POWER_VALUE",
        defaultValue = Settings.Default.True,
        get = function ()
            return not addon.db.unit.pet.realPowerValue
        end,
        set = function (value)
            addon.db.unit.pet.realPowerValue = not value
            if addon.db.enable then
                addon:DisplayHealthText("pet")
                addon:DisplayPowerText("pet")
            end
        end
    })

    -- 투명도
    guiConfig:CreateSlider({
        label = BHTL.OPACITY_PET,
        tooltip = BHTL.OPACITY_PET_TOOLTIP,
        key = "UNIT_PET_REAL_ALPHA",
        min = 0.1,
        max= 1.0,
        step = 0.05,
        defaultValue = 1.0,
        get = function ()
            return addon.db.unit.pet.alpha
        end,
        set = function (value)
            addon.db.unit.pet.alpha = value
            if addon.db.enable then
                addon:FrameUpdate("pet")
            end
        end,
        format = FormatPercentage
    })

    -- 체력크기
    guiConfig:CreateSlider({
        label = BHTL.PET_HP_SIZE,
        tooltip = BHTL.PET_HP_SIZE_TOOLTIP,
        key = "fontSizeHealthForPet",
        min = 10,
        max= 36,
        step = 2,
        defaultValue = 14,
        get = function ()
            return addon.db.fontSizeHealthForPet
        end,
        set = function (value)
            addon.db.fontSizeHealthForPet = value
            if addon.db.enable then
                addon:FrameFontUpdate()
            end
        end
    })

    -- 파워크기
    guiConfig:CreateSlider({
        label = BHTL.PET_POWER_SIZE,
        tooltip = BHTL.PET_POWER_SIZE_TOOLTIP,
        key = "fontSizePowerForPet",
        min = 10,
        max= 36,
        step = 2,
        defaultValue = 10,
        get = function ()
            return addon.db.fontSizePowerForPet
        end,
        set = function (value)
            addon.db.fontSizePowerForPet = value
            if addon.db.enable then
                addon:FrameFontUpdate()
            end
        end
    })
end


local module = {}
_G[moduleName] = module
module.updators = {}
module.miscOptions = {}

-------------------------------------------------------------------------------
-- WOW APIs/variables
-------------------------------------------------------------------------------

local AuraUtil = AuraUtil
local UnitExists = UnitExists
local select = select
local GetTime = GetTime


-------------------------------------------------------------------------------
-- modules
-------------------------------------------------------------------------------

function module:RegisterUpdators(func, ...)
    if func and type(func) == "function" then
        if not self.updators[func] then
            if select("#", ...) == 0 then
                self.updators[func] = true
            else
                self.updators[func] = { ... }
            end
        end
    end
end

function module:UnregisterUpdators(func)
    if func and type(func) == "function" then
        if self.updators[func] then
            self.updators[func] = nil
        end
    end
end

function module:ExtraUpdators(unit)
    for func, v in pairs(self.updators) do
        if type(v) == "table" then
            func(unit, unpack(v))
        else
            func(unit)
        end
    end
end

function module:GetMiscConfig()
    return self.miscOptions
end

function module:AddMiscConfig(opt)
    table.insert(self.miscOptions, opt)
end

-- @deprecated 120000
function module:getAuraInfo(unit, spell, filter)
    if not UnitExists(unit) then return end

    return AuraUtil.FindAuraByName(spell, unit, filter)
end

-- @deprecated 120000
function module:getAuraCount(unit, spell, filter, iconOnly)
    if not UnitExists(unit) then return "" end

    local i = 1
    local countText, r, g, b = "", 1.0, 0.5, 0.1

    local name, icon, count, debufType, duration, expirationTime = self:getAuraInfo(unit, spell, filter)
    if name then
        if (count <= 0) then
            return ""
        end

        if not expirationTime then
            -- nothing
        else
            local timeLeft = (expirationTime - GetTime()) / duration
            if timeLeft < 0.3 then -- 30%미만 - 빨간색
                r = 1.0
                g = 0.1
                b = 0.1
            elseif timeLeft < 0.6 then -- 30%~60% - 파란색
                r = 0.0
                g = 0.39
                b = 0.88
            else -- 60%이상 녹색
                r = 0.1
                g = 1.0
                b = 0.1
            end
        end
        if iconOnly then
            return (":|T%s:0|t"):format(icon)
        else
            return (":|cff%02x%02x%02x%d|r"):format(r * 255, g * 255, b * 255, count)
        end
    end
    return ""
end

function module:init() end

function module:getPlayerText() end

function module:getTargetText() end

function module:getPlayerHealthColor() end

function module:getPlayerPowerColor() end

function module:getTargetHealthColor() end

function module:getTargetPowerColor() end


-------------------------------------------------------------------------------
-- WOW APIs/variables
-------------------------------------------------------------------------------

local GetLocale, Enum, IsSpellKnown, IsPlayerSpell = GetLocale, Enum, IsSpellKnown, IsPlayerSpell
local UnitClass, UnitPower, GetSpecialization = UnitClass, UnitPower, GetSpecialization
local select = select


-------------------------------------------------------------------------------
-- local variables
-------------------------------------------------------------------------------

if select(2, UnitClass("player")) == "MAGE" then

local tcopy
local config_added = false

local L_ICICLE = "Icicle"
local L_MAGE_CONFIG = "Mage Setting"
local L_USE_MAGE_ACTIVATED_SPELL = "Displays the spell icons when activating effect."
local L_USE_MAGE_ACTIVATED_SPELL_TOOLTIP = "Displays the spell icons when activating effect."
local L_USE_MAGE_ARCANE_COUNT = "Displays the number of Arcane Charges of Arcane specialization and the number of Icicles of Frost specialization."
local L_USE_MAGE_ARCANE_COUNT_TOOLTIP = "Displays the number of Arcane Charges of Arcane specialization and the number of Icicles of Frost specialization."

-- koKR locale
if GetLocale() == "koKR" then
    L_ICICLE = "고드름"
    L_MAGE_CONFIG = "마법사 설정"
    L_USE_MAGE_ACTIVATED_SPELL = "발동 효과 아이콘 표시"
    L_USE_MAGE_ACTIVATED_SPELL_TOOLTIP = "전문화별 발동 효과 발동시 아이콘을 표시합니다."
    L_USE_MAGE_ARCANE_COUNT = "비전 충전물의 갯수 표시"
    L_USE_MAGE_ARCANE_COUNT_TOOLTIP = "비전 전문화의 비전 충전물의 갯수를 표시합니다."
end

local activation_spells = {}

local defaultDB = {
    db_ver = 1.2,
    use_activated_spells = true,
    show_arcane_count = true,
}

-------------------------------------------------------------------------------
-- local functions
-------------------------------------------------------------------------------

function tcopy(to, from) -- "to" must be a table (possibly empty)
    for k, v in pairs(from) do
        if (type(v) == "table") then
            if not to then to = {} end
            to[k] = {}
            tcopy(to[k], v)
        else
            to[k] = v
        end
    end
end

-------------------------------------------------------------------------------
-- module functions
-------------------------------------------------------------------------------
function module:init()
    if self.addon.db then
        if not self.addon.db.class or not self.addon.db.class.db_ver or self.addon.db.class.db_ver < defaultDB.db_ver then
            self.addon.db.class = {}
            tcopy(self.addon.db.class, defaultDB)
        end
    end

    if self.addon.db.class.use_activated_spells then
        module:EnableActivatedSpell()
    end

    if not config_added then
        self.addon.guiConfig:CreateLabel(L_MAGE_CONFIG)
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_MAGE_ACTIVATED_SPELL,
            tooltip = L_USE_MAGE_ACTIVATED_SPELL_TOOLTIP,
            key = "use_mage_activated_spells",
            defaultValue = Settings.Default.True,
            get = function()
                return self.addon.db.class.use_activated_spells
            end,
            set = function(value)
                self.addon.db.class.use_activated_spells = value
                if self.addon.db.class.use_activated_spells then
                    module:EnableActivatedSpell()
                else
                    module:DisableActivatedSpell()
                end
            end
        })
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_MAGE_ARCANE_COUNT,
            tooltip = L_USE_MAGE_ARCANE_COUNT_TOOLTIP,
            key = "show_arcane_count",
            defaultValue = Settings.Default.True,
            get = function()
                return self.addon.db.class.show_arcane_count
            end,
            set = function(value)
                self.addon.db.class.show_arcane_count = value
            end,
        })

        config_added = true
    end
end

function module:EnableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:DisableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(...)
    local spellID = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon and IsSpellKnown(spellID) and IsPlayerSpell(spellID) then
        if not activation_spells[icon] then
            activation_spells[icon] = 0
        end
        activation_spells[icon] = activation_spells[icon] + 1
    end
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(...)
    local spellID = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon and activation_spells and activation_spells[icon] then
        activation_spells[icon] = activation_spells[icon] - 1
        if activation_spells[icon] < 0 then
            activation_spells[icon] = 0
        end
    end
end

function module:getTargetText()
    local text = ""

    if self.addon.db.class.use_activated_spells then
        for texture, cnt in pairs(activation_spells) do
            if cnt > 0 then
                text = text .. (":|T%s:%d|t"):format(texture, self.addon.db.fontSizeHealth / 2)
            end
        end
    end

    return text
end

-- @returns number
function module:getPlayerText()
    if self.addon.db.class.show_arcane_count then
        if GetSpecialization() == 1 then
            local arcanes = UnitPower("player", Enum.PowerType.ArcaneCharges, true);
            if arcanes > 0 then
                return arcanes
            end
        end
    end
    return ""
end

elseif select(2, UnitClass("player")) == "WARRIOR" then

local tinsert = table.insert

local L_WARRIOR_CONFIG = "Warrior Setting"
local L_USE_WARRIOR_ACTIVATED_SPELL = "Displays the spell icons when activating effect."
local L_USE_WARRIOR_ACTIVATED_SPELL_TOOLTIP = "Displays the spell icons when activating effect."
--local L_USE_FOCUSED_RAGE = "|TInterface\\Icons\\ability_warrior_focusedrage:20|t집중된 분노 효과의 중첩 갯수(무기,방어 전문화)를 표시합니다."

-- koKR locale
if GetLocale() == "koKR" then
    L_WARRIOR_CONFIG = "전사 설정"
    L_USE_WARRIOR_ACTIVATED_SPELL = "발동 효과 아이콘 표시"
    L_USE_WARRIOR_ACTIVATED_SPELL_TOOLTIP = "전문화별 발동 효과 발동시 아이콘을 표시합니다."
end

local activation_spells = {}
local config_added = false
local name, icon, count, debufType, duration, expirationTime

local defaultDB = {
    db_ver = 1.1,
    use_activated_spells = true,
    --use_focused_rage = true,
}

-------------------------------------------------------------------------------
-- local functions
-------------------------------------------------------------------------------

local function tcopy(to, from) -- "to" must be a table (possibly empty)
    for k, v in pairs(from) do
        if (type(v) == "table") then
            if not to then to = {} end
            to[k] = {}
            tcopy(to[k], v)
        else
            to[k] = v
        end
    end
end

local function focusedRageUpdator(unit, f1)

    name, icon, count, debufType, duration, expirationTime = AuraUtil.FindAuraByName("집중된 분노", "player",
        "PLAYER|HELPFUL") -- UnitAura("player", "집중된 분노", nil, "PLAYER|HELPFUL")

    if count and count > 0 then
        f1:SetText(count)
    else
        f1:SetText("")
    end
end

-------------------------------------------------------------------------------
-- module functions
-------------------------------------------------------------------------------
function module:init()
    if self.addon.db then
        if not self.addon.db.class or not self.addon.db.class.db_ver or self.addon.db.class.db_ver < defaultDB.db_ver then
            self.addon.db.class = {}
            tcopy(self.addon.db.class, defaultDB)
        end
    end

    if self.addon.db.class.use_activated_spells then
        module:EnableActivatedSpell()
    end

    --	if self.addon.db.class.use_focused_rage then
    --		self:EnableFocusedRage()
    --	end

    if not config_added then
        self.addon.guiConfig:CreateLabel(L_WARRIOR_CONFIG)
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_WARRIOR_ACTIVATED_SPELL,
            tooltip = L_USE_WARRIOR_ACTIVATED_SPELL_TOOLTIP,
            key = "use_activated_spells",
            defaultValue = Settings.Default.True,
            get = function()
                return self.addon.db.class.use_activated_spells
            end,
            set = function(value)
                self.addon.db.class.use_activated_spells = value
                if self.addon.db.class.use_activated_spells then
                    module:EnableActivatedSpell()
                else
                    module:DisableActivatedSpell()
                end
            end,
        })

        config_added = true
    end
end

function module:EnableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:DisableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(...)
    -- 분노: 마무리 일격 5308 -> override ID 280735
    -- 분노: 마무리 일격 163201
    -- 분노: 마무리 일격 163201
    -- 분노: 규탄 330325
    local spellID = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon and IsSpellKnown(spellID) and IsPlayerSpell(spellID) then
        -- print("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW", spellID, icon, spellName)
        if not activation_spells[icon] then
            activation_spells[icon] = 0
        end
        activation_spells[icon] = activation_spells[icon] + 1
    end
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(...)
    local spellID = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon and activation_spells and activation_spells[icon] then
        activation_spells[icon] = activation_spells[icon] - 1
        if activation_spells[icon] < 0 then
            activation_spells[icon] = 0
        end
    end
end

function module:getTargetText()
    local text = ""

    if self.addon.db.class.use_activated_spells then
        for texture, cnt in pairs(activation_spells) do
            if cnt > 0 then
                text = text .. (":|T%s:%d|t"):format(texture, self.addon.db.fontSizeHealth / 2)
            end
        end
    end

    return text
end

function module:EnableFocusedRage()
    if not self.addon.playerFrame.focused_rage then
        self.addon.playerFrame.focused_rage = self.addon.playerFrame:CreateFontString(nil, "OVERLAY")
        self.addon.playerFrame.focused_rage:SetFont(self.addon.db.font, self.addon.db.fontSizePower,
            self.addon.db.fontOutline)
        self.addon.playerFrame.focused_rage:SetPoint("LEFT", self.addon.playerFrame.health, "RIGHT")
        self.addon.playerFrame.focused_rage:SetAlpha(self.addon.db.unit.player.alpha)
        self.addon.playerFrame.focused_rage:SetJustifyH("LEFT")
        self.addon.playerFrame.focused_rage:SetTextColor(1.0, 0.52, 0.25)
    end
    self.addon.playerFrame.focused_rage:Show()
    self:RegisterUpdators(focusedRageUpdator, self.addon.playerFrame.focused_rage)
end

function module:DisableFocusedRage()
    if self.addon.playerFrame.focused_rage then
        self.addon.playerFrame.focused_rage:Hide()
    end
    self:UnregisterUpdators(focusedRageUpdator)
end

elseif select(2, UnitClass("player")) == "ROGUE" then

local loaded = false

local L_ROGUE_CONFIG = "Rogue Setting"
local L_USE_ROGUE_ACTIVATED_SPELL = "Displays the spell icons when activating effect."
local L_USE_ROGUE_ACTIVATED_SPELL_TOOLTIP = "Displays the spell icons when activating effect."
local L_SWITCH_COMBO_POSITION = "Location of Combo points"
local L_SWITCH_COMBO_POSITION_TT = "Sets the location of the combo point next to the Player or Target."
local L_SWITCH_COMBO_POSITION_PLAYER = "Player"
local L_SWITCH_COMBO_POSITION_TARGET = "Target"

-- koKR locale
if GetLocale() == "koKR" then
    L_ROGUE_CONFIG = "도적 설정"
    L_USE_ROGUE_ACTIVATED_SPELL = "발동 효과 아이콘 표시"
    L_USE_ROGUE_ACTIVATED_SPELL_TOOLTIP = "전문화별 발동 효과 발동시 아이콘을 표시합니다."
    L_SWITCH_COMBO_POSITION = "연계수치 위치 설정"
    L_SWITCH_COMBO_POSITION_TT = "연계수치의 위치를 플레이어 또는 대상 옆으로 설정합니다."
    L_SWITCH_COMBO_POSITION_PLAYER = "플레이어옆"
    L_SWITCH_COMBO_POSITION_TARGET = "대상옆"
end

local activation_spells = {}

local defaultDB = {
    db_ver = 1.1,
    use_activated_spells = true,
    rg_combo_position = "target",
}

-------------------------------------------------------------------------------
-- local functions
-------------------------------------------------------------------------------

function tcopy(to, from) -- "to" must be a table (possibly empty)
    for k, v in pairs(from) do
        if (type(v) == "table") then
            if not to then to = {} end
            to[k] = {}
            tcopy(to[k], v)
        else
            to[k] = v
        end
    end
end

-------------------------------------------------------------------------------
-- module functions
-------------------------------------------------------------------------------
function module:init()
    if self.addon.db then
        if not self.addon.db.class or not self.addon.db.class.db_ver or self.addon.db.class.db_ver < defaultDB.db_ver then
            self.addon.db.class = {}
            tcopy(self.addon.db.class, defaultDB)
        end
    end

    if self.addon.db.class.use_activated_spells then
        module:EnableActivatedSpell()
    end

    if loaded == false then
        self.addon.guiConfig:CreateLabel(L_ROGUE_CONFIG)
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_ROGUE_ACTIVATED_SPELL,
            tooltip = L_USE_ROGUE_ACTIVATED_SPELL_TOOLTIP,
            key = "use_activated_spells",
            defaultValue = Settings.Default.True,
            get = function()
                return self.addon.db.class.use_activated_spells
            end,
            set = function(value)
                self.addon.db.class.use_activated_spells = value
                if self.addon.db.class.use_activated_spells then
                    module:EnableActivatedSpell()
                else
                    module:DisableActivatedSpell()
                end
            end,
        })
        self.addon.guiConfig:CreateDropdown({
            label = L_SWITCH_COMBO_POSITION,
            tooltip = L_SWITCH_COMBO_POSITION_TT,
            key = "rg_combo_position",
            values = {
                {
                    text = L_SWITCH_COMBO_POSITION_PLAYER,
                    value = "player",
                },
                {
                    text = L_SWITCH_COMBO_POSITION_TARGET,
                    value = "target",
                },
            },
            varType = Settings.VarType.String,
            defaultValue = "target",
            get = function()
                return self.addon.db.class.rg_combo_position or "target"
            end,
            set = function(value)
                self.addon.db.class.rg_combo_position = value
            end,
        })
    end
    loaded = true
end

function module:EnableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:DisableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(...)
    local spellID, texture, positions, scale, r, g, b = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon then
        if not activation_spells[icon] then
            activation_spells[icon] = 0
        end
        activation_spells[icon] = activation_spells[icon] + 1
    end
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(...)
    local spellID = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon and activation_spells and activation_spells[icon] then
        activation_spells[icon] = activation_spells[icon] - 1
        if activation_spells[icon] < 0 then
            activation_spells[icon] = 0
        end
    end
end

function module:getComboText()
    local combo = UnitPower("player", Enum.PowerType.ComboPoints)
    local r, g, b = 1.0, 0.5, 0.1

    if (combo <= 0) then
        return ""
    end

    return (":|cff%02x%02x%02x%d|r"):format(r * 255, g * 255, b * 255, combo)
end

function module:getPlayerText()
    if self.addon.db.class.rg_combo_position == "player" then
        local text = self:getComboText()
        return text
    end
end

function module:getTargetText()
    local text = ""

    if not self.addon.db.class.rg_combo_position or self.addon.db.class.rg_combo_position == "target" then
        text = self:getComboText()
    end

    if self.addon.db.class.use_activated_spells then
        for texture, cnt in pairs(activation_spells) do
            if cnt > 0 then
                text = text .. (":|T%s:%d|t"):format(texture, self.addon.db.fontSizeHealth / 2)
            end
        end
    end

    return text
end

elseif select(2, UnitClass("player")) == "DRUID" then

local tcopy
local ComboSkill = 40
local FinishSkill = 30
local config_added = false
local activation_spells = {}

local L_DRUID_CONFIG = "Druid Setting"
local L_USE_COMBO = "Displays the number of combo points."
local L_USE_COMBO_TOOLTIP = "Displays the number of combo points."
local L_USE_COMBO_BESIDE_PLAYER = "Displays the number of combo points next to the Player's health text.(default: beside target's health text)"
local L_USE_COMBO_BESIDE_PLAYER_DESC = "Check to display the number of combo points to the right of Player's health."
local L_USE_DRUID_ACTIVATED_SPELL = "Displays the spell icons when activating effect."
local L_USE_DRUID_ACTIVATED_SPELL_TOOLTIP = "Displays the spell icons when activating effect."

-- koKR locale
if GetLocale() == "koKR" then
    L_DRUID_CONFIG = "드루이드 설정"
    L_USE_COMBO = "표범의 연계점수 표시"
    L_USE_COMBO_TOOLTIP = "표범의 연계점수를 표시합니다."
    L_USE_COMBO_BESIDE_PLAYER = "표범의 연계점수를 플레이어 체력 텍스트 옆에 표시"
    L_USE_COMBO_BESIDE_PLAYER_DESC = "체크하면 표범의 연계점수를 플레이어 체력 텍스트 오른쪽에 표시합니다."
    L_USE_DRUID_ACTIVATED_SPELL = "발동 효과 아이콘 표시"
    L_USE_DRUID_ACTIVATED_SPELL_TOOLTIP = "전문화별 발동 효과 발동시 아이콘을 표시합니다."
end

local defaultDB = {
    db_ver = 1.1,
    use_combo = true,
    use_combo_beside_player = false,
    use_activated_spells = true,
}


-------------------------------------------------------------------------------
-- local functions
-------------------------------------------------------------------------------

function tcopy(to, from) -- "to" must be a table (possibly empty)
    for k, v in pairs(from) do
        if (type(v) == "table") then
            if not to then to = {} end
            to[k] = {}
            tcopy(to[k], v)
        else
            to[k] = v
        end
    end
end

local function getComboText()
    if UnitPowerType("player") == Enum.PowerType.Energy then -- energy
        local combo = UnitPower("player", Enum.PowerType.ComboPoints)
        local r, g, b = 1.0, 0.5, 0.1

        if (combo <= 0) then
            return ""
        end

        return (":|cff%02x%02x%02x%d|r"):format(r * 255, g * 255, b * 255, combo)
    end
    return ""
end

-------------------------------------------------------------------------------
-- module functions
-------------------------------------------------------------------------------
function module:init()
    if self.addon.db then
        if not self.addon.db.class or not self.addon.db.class.db_ver or self.addon.db.class.db_ver < defaultDB.db_ver then
            self.addon.db.class = {}
            tcopy(self.addon.db.class, defaultDB)
        end
    end

    if self.addon.db.class.use_activated_spells then
        module:EnableActivatedSpell()
    end

    if not config_added then
        self.addon.guiConfig:CreateLabel(L_DRUID_CONFIG)
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_DRUID_ACTIVATED_SPELL,
            tooltip = L_USE_DRUID_ACTIVATED_SPELL_TOOLTIP,
            key = "use_activated_spells",
            defaultValue = Settings.Default.True,
            get = function()
                return self.addon.db.class.use_activated_spells
            end,
            set = function(value)
                self.addon.db.class.use_activated_spells = value
                if self.addon.db.class.use_activated_spells then
                    module:EnableActivatedSpell()
                else
                    module:DisableActivatedSpell()
                end
            end,
        })
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_COMBO,
            tooltip = L_USE_COMBO_TOOLTIP,
            key = "use_combo",
            defaultValue = Settings.Default.True,
            get = function()
                if self.addon and self.addon.db then
                    return self.addon.db.class.use_combo
                end
                return
            end,
            set = function(value)
                self.addon.db.class.use_combo = value
            end,
        })
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_COMBO_BESIDE_PLAYER,
            tooltip = L_USE_COMBO_BESIDE_PLAYER_DESC,
            key = "use_combo_beside_player",
            defaultValue = Settings.Default.True,
            get = function()
                if self.addon and self.addon.db then
                    return self.addon.db.class.use_combo_beside_player
                end
                return
            end,
            set = function(value)
                self.addon.db.class.use_combo_beside_player = value
            end,
        })

        config_added = true
    end
end

function module:EnableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:DisableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(...)
    local spellID = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon and IsSpellKnown(spellID) and IsPlayerSpell(spellID) then
        if not activation_spells[icon] then
            activation_spells[icon] = 0
        end
        activation_spells[icon] = activation_spells[icon] + 1
    end
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(...)
    local spellID = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon and activation_spells and activation_spells[icon] then
        activation_spells[icon] = activation_spells[icon] - 1
        if activation_spells[icon] < 0 then
            activation_spells[icon] = 0
        end
    end
end

function module:getPlayerText()
    local text = ""

    if self.addon.db.class.use_combo and self.addon.db.class.use_combo_beside_player then
        text = text .. getComboText()
    end

    return text
end

function module:getTargetText()
    local text = ""

    if self.addon.db.class.use_combo and not self.addon.db.class.use_combo_beside_player then
        text = getComboText()
    end

    if self.addon.db.class.use_activated_spells then
        for texture, cnt in pairs(activation_spells) do
            if cnt > 0 then
                text = text .. (":|T%s:%d|t"):format(texture, self.addon.db.fontSizeHealth / 2)
            end
        end
    end

    return text
end

elseif select(2, UnitClass("player")) == "SHAMAN" then
local L_SHAMAN_CONFIG = "Shaman Setting"
local L_USE_SHAMAN_ACTIVATED_SPELL = "Displays the spell icons when activating effect."
local L_USE_SHAMAN_ACTIVATED_SPELL_TOOLTIP = "Displays the spell icons when activating effect."

-- koKR locale
if GetLocale() == "koKR" then
    L_SHAMAN_CONFIG = "주술사 설정"
    L_USE_SHAMAN_ACTIVATED_SPELL = "발동 효과 아이콘 표시"
    L_USE_SHAMAN_ACTIVATED_SPELL_TOOLTIP = "전문화별 발동 효과 발동시 아이콘을 표시합니다."
end


local activation_spells = {}
local config_added = false

local defaultDB = {
    db_ver = 1.0,
    use_activated_spells = true,
}

-------------------------------------------------------------------------------
-- local functions
-------------------------------------------------------------------------------

function tcopy(to, from) -- "to" must be a table (possibly empty)
    for k, v in pairs(from) do
        if (type(v) == "table") then
            if not to then to = {} end
            to[k] = {}
            tcopy(to[k], v)
        else
            to[k] = v
        end
    end
end

-------------------------------------------------------------------------------
-- module functions
-------------------------------------------------------------------------------
function module:init()
    if self.addon.db then
        if not self.addon.db.class or not self.addon.db.class.db_ver or self.addon.db.class.db_ver < defaultDB.db_ver then
            self.addon.db.class = {}
            tcopy(self.addon.db.class, defaultDB)
        end
    end

    if self.addon.db.class.use_activated_spells then
        module:EnableActivatedSpell()
    end

    if not config_added then
        self.addon.guiConfig:CreateLabel(L_SHAMAN_CONFIG)
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_SHAMAN_ACTIVATED_SPELL,
            tooltip = L_USE_SHAMAN_ACTIVATED_SPELL_TOOLTIP,
            key = "use_activated_spells",
            defaultValue = Settings.Default.True,
            get = function()
                return self.addon.db.class.use_activated_spells
            end,
            set = function(value)
                self.addon.db.class.use_activated_spells = value
                if self.addon.db.class.use_activated_spells then
                    module:EnableActivatedSpell()
                else
                    module:DisableActivatedSpell()
                end
            end,
        })

        config_added = true
    end
end

function module:EnableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:DisableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(...)
    local spellID, texture, positions, scale, r, g, b = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon then
        if not activation_spells[icon] then
            activation_spells[icon] = 0
        end
        activation_spells[icon] = activation_spells[icon] + 1
    end
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(...)
    local spellID = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon and activation_spells and activation_spells[icon] then
        activation_spells[icon] = activation_spells[icon] - 1
        if activation_spells[icon] < 0 then
            activation_spells[icon] = 0
        end
    end
end

function module:getTargetText()
    local text = ""

    if self.addon.db.class.use_activated_spells then
        for texture, cnt in pairs(activation_spells) do
            if cnt > 0 then
                text = text .. (":|T%s:%d|t"):format(texture, self.addon.db.fontSizeHealth / 2)
            end
        end
    end

    return text
end

elseif select(2, UnitClass("player")) == "PALADIN" then

local tcopy
local config_added = false
local enabled_the_art_of_war = false


local L_PALADIN_CONFIG = "Paladin Setting"
local L_USE_COMBO = "Displays the number of Holy Powers."
local L_USE_COMBO_TOOLTIP = "Displays the number of Holy Powers."
local L_USE_3HOLY_POWER_SKILL = "|TInterface\\Icons\\Spell_Paladin_Templarsverdict:20|t Displays Templar's Verdict skills when there are more than 3 Holy Powers.(Retribution only)"
local L_USE_3HOLY_POWER_SKILL_DESC = "Displays Templar's Verdict skills when there are more than 3 Holy Powers."
local L_USE_PALADIN_ACTIVATED_SPELL = "Displays the spell icons when activating effect."
local L_USE_PALADIN_ACTIVATED_SPELL_TOOLTIP = "Displays the spell icons when activating effect."

-- koKR locale
if GetLocale() == "koKR" then
    L_PALADIN_CONFIG = "성기사 설정"
    L_USE_COMBO = "신성한 힘의 개수 표시"
    L_USE_COMBO_TOOLTIP = "성기사 신성한 힘의 갯수를 표시합니다."
    L_USE_3HOLY_POWER_SKILL = "|TInterface\\Icons\\Spell_Paladin_Templarsverdict:20|t 기사단의 선고 아이콘 표시"
    L_USE_3HOLY_POWER_SKILL_DESC = "신성한 힘이 3개 이상일때 기사단의 선고 아이콘을 표시해줍니다.(징벌 전용)"
    L_USE_PALADIN_ACTIVATED_SPELL = "발동 효과 아이콘 표시"
    L_USE_PALADIN_ACTIVATED_SPELL_TOOLTIP = "전문화별 발동 효과 발동시 아이콘을 표시합니다."
end


local activation_spells = {}

local defaultDB = {
    db_ver = 1.1,
    use_combo = true,
    use_3holy_power_skill = true,
    use_activated_spells = true,
}

local alter_texture = {
    [85416] = "Interface\\Icons\\Spell_Holy_Avengersshield",
}

-------------------------------------------------------------------------------
-- local functions
-------------------------------------------------------------------------------

function tcopy(to, from) -- "to" must be a table (possibly empty)
    for k, v in pairs(from) do
        if (type(v) == "table") then
            if not to then to = {} end
            to[k] = {}
            tcopy(to[k], v)
        else
            to[k] = v
        end
    end
end

-------------------------------------------------------------------------------
-- module functions
-------------------------------------------------------------------------------

function module:init()
    if self.addon.db then
        if not self.addon.db.class or not self.addon.db.class.db_ver or self.addon.db.class.db_ver < defaultDB.db_ver then
            self.addon.db.class = {}
            tcopy(self.addon.db.class, defaultDB)
        end
    end

    if self.addon.db.class.use_activated_spells then
        module:EnableActivatedSpell()
    end

    if not config_added then
        self.addon.guiConfig:CreateLabel(L_PALADIN_CONFIG)
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_PALADIN_ACTIVATED_SPELL,
            tooltip = L_USE_PALADIN_ACTIVATED_SPELL_TOOLTIP,
            key = "use_activated_spells",
            defaultValue = Settings.Default.True,
            get = function()
                return self.addon.db.class.use_activated_spells
            end,
            set = function(value)
                self.addon.db.class.use_activated_spells = value
                if self.addon.db.class.use_activated_spells then
                    module:EnableActivatedSpell()
                else
                    module:DisableActivatedSpell()
                end
            end,
        })
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_COMBO,
            tooltip = L_USE_COMBO_TOOLTIP,
            key = "use_combo",
            defaultValue = Settings.Default.True,
            get = function()
                if self.addon and self.addon.db then
                    return self.addon.db.class.use_combo
                end
                return
            end,
            set = function(value)
                self.addon.db.class.use_combo = value
            end,
        })
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_3HOLY_POWER_SKILL,
            tooltip = L_USE_3HOLY_POWER_SKILL_DESC,
            key = "use_3holy_power_skill",
            defaultValue = Settings.Default.True,
            get = function()
                if self.addon and self.addon.db then
                    return self.addon.db.class.use_3holy_power_skill
                end
                return
            end,
            set = function(value)
                self.addon.db.class.use_3holy_power_skill = value
            end,
        })

        config_added = true
    end
end

function module:EnableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:DisableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(...)
    local spellID, texture, positions, scale, r, g, b = ...;
    local icon
    if alter_texture[spellID] then
        icon = alter_texture[spellID]
    else
        icon = C_Spell.GetSpellTexture(spellID)
    end
    if icon then
        if not activation_spells[icon] then
            activation_spells[icon] = 0
        end
        activation_spells[icon] = activation_spells[icon] + 1
    end
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(...)
    local spellID = ...;
    local icon
    if alter_texture[spellID] then
        icon = alter_texture[spellID]
    else
        icon = C_Spell.GetSpellTexture(spellID)
    end
    if icon and activation_spells and activation_spells[icon] then
        activation_spells[icon] = activation_spells[icon] - 1
        if activation_spells[icon] < 0 then
            activation_spells[icon] = 0
        end
    end
end

function module:getPlayerText()
    if self.addon.db.class.use_combo then
        local numHolyPower = UnitPower("player", Enum.PowerType.HolyPower)
        if numHolyPower > 0 then
            return (":|cff%02x%02x%02x%d|r"):format(255, 255, 63, numHolyPower)
        end
    end
    return ""
end

function module:getTargetText()
    local text = ""
    local size = self.addon.db.fontSizeHealth
    local name, rank, icon, count, debufType, duration, expirationTime
    local r, g, b = 1, 1, 1

    if self.addon.db.class.use_activated_spells then
        for texture, cnt in pairs(activation_spells) do
            if cnt > 0 then
                text = text .. (":|T%s:%d|t"):format(texture, size / 2)
            end
        end
    end

    if self.addon.db.class.use_3holy_power_skill and GetSpecialization() == 3 then
        local numHolyPower = UnitPower("player", Enum.PowerType.HolyPower)
        if numHolyPower >= 3 then
            size = self.addon.db.fontSizeHealth / 2
            text = text .. (":|TInterface\\Icons\\Spell_Paladin_Templarsverdict:%d|t"):format(size)
        end
    end

    return text
end

elseif select(2, UnitClass("player")) == "DEATHKNIGHT" then

local tcopy
local loaded = false

local L_DK_CONFIG = "Deathknight Setting"
local L_USE_RUNE = "Displays the currently remaining runes."
local L_USE_DK_ACTIVATED_SPELL = "Displays the spell icons when activating effect."
local L_USE_DISEASE = "|TInterface\\Icons\\spell_yorsahj_bloodboil_purpleoil:20|tDisplays the number of Festering Wound in the target."
local L_USE_BONE_SHIELD = "|TInterface\\Icons\\ability_deathknight_boneshield:20|tDisplays the number of Bone Shield."
local L_SPELL_FESTERING_WOUND = "Festering Wound"
local L_SPELL_BONE_SHIELD = "Bone Shield"
--local L_USE_SCOURGE_OF_WORLDS = "|TInterface\\Icons\\artifactability_unholydeathknight_flagellation:20|t세계의 스컬지(부정 유물 대재앙) 발동시 표시합니다."

-- koKR locale
if GetLocale() == "koKR" then
    L_DK_CONFIG = "죽음의 기사 설정"
    L_USE_RUNE = "룬 개수 표시"
    L_USE_RUNE_TOOLTIP = "현재 남아있는 룬을 표시합니다."
    L_USE_DK_ACTIVATED_SPELL = "발동 효과 아이콘 표시"
    L_USE_DK_ACTIVATED_SPELL_TOOLTIP = "전문화별 발동 효과 발동시 아이콘을 표시합니다."
    L_USE_DISEASE = "|TInterface\\Icons\\spell_yorsahj_bloodboil_purpleoil:20|t 고름 상처 개수 표시"
    L_USE_DISEASE_TOOLTIP = "고름 상처 효과의 개수를 표시합니다."
    L_USE_BONE_SHIELD = "|TInterface\\Icons\\ability_deathknight_boneshield:20|t 뼈의 보호막 개수 표시"
    L_USE_BONE_SHIELD_TOOLTIP = "뼈의 보호막 효과의 개수를 표시합니다."
    L_SPELL_FESTERING_WOUND = "고름 상처"
    L_SPELL_BONE_SHIELD = "뼈의 보호막"
end

local text
local name, icon, count, debufType, duration, expirationTime
local size
local usable
local aCount
local activation_spells = {}

local defaultDB = {
    db_ver = 1.3,
    use_rune = true,
    use_activated_spells = true,
    --	use_scourge_of_worlds = false,
}


-------------------------------------------------------------------------------
-- local functions
-------------------------------------------------------------------------------

function tcopy(to, from) -- "to" must be a table (possibly empty)
    for k, v in pairs(from) do
        if (type(v) == "table") then
            if not to then to = {} end
            to[k] = {}
            tcopy(to[k], v)
        else
            to[k] = v
        end
    end
end

-------------------------------------------------------------------------------
-- module functions
-------------------------------------------------------------------------------

function module:init()

    if self.addon.db then
        if not self.addon.db.class or not self.addon.db.class.db_ver or self.addon.db.class.db_ver < defaultDB.db_ver then
            self.addon.db.class = {}
            tcopy(self.addon.db.class, defaultDB)
        end
    end

    if self.addon.db.class.use_rune then
        self:EnableRune()
    end

    if self.addon.db.class.use_activated_spells then
        module:EnableActivatedSpell()
    end

    if loaded == false then
        self.addon.guiConfig:CreateLabel(L_DK_CONFIG)
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_RUNE,
            tooltip = L_USE_RUNE_TOOLTIP,
            key = "use_rune",
            defaultValue = Settings.Default.True,
            get = function()
                return module.addon.db.class.use_rune
            end,
            set = function(value)
                module.addon.db.class.use_rune = value
                if module.addon.db.class.use_rune then
                    module:EnableRune()
                else
                    module:DisableRune()
                end
            end,
        })
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_DK_ACTIVATED_SPELL,
            tooltip = L_USE_DK_ACTIVATED_SPELL_TOOLTIP,
            key = "use_activated_spells",
            defaultValue = Settings.Default.True,
            get = function()
                return self.addon.db.class.use_activated_spells
            end,
            set = function(value)
                self.addon.db.class.use_activated_spells = value
                if self.addon.db.class.use_activated_spells then
                    module:EnableActivatedSpell()
                else
                    module:DisableActivatedSpell()
                end
            end,
        })

        loaded = true
    end
end

function module:RUNE_POWER_UPDATE(...)
    self:updateRunes()
end

--module.RUNE_TYPE_UPDATE = module.RUNE_POWER_UPDATE

function module:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(...)
    local spellID = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon and IsSpellKnown(spellID) and IsPlayerSpell(spellID) then
        if not activation_spells[icon] then
            activation_spells[icon] = 0
        end
        activation_spells[icon] = activation_spells[icon] + 1
    end
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(...)
    local spellID = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon and activation_spells and activation_spells[icon] then
        activation_spells[icon] = activation_spells[icon] - 1
        if activation_spells[icon] < 0 then
            activation_spells[icon] = 0
        end
    end
end

function module:EnableRune()
    if not self.addon.playerFrame.runes then
        self.addon.playerFrame.runes = self.addon.playerFrame:CreateFontString(nil, "OVERLAY")
        self.addon.playerFrame.runes:SetFont(self.addon.db.font, self.addon.db.fontSizePower, self.addon.db.fontOutline)
        self.addon.playerFrame.runes:SetPoint("BOTTOM", self.addon.playerFrame.health, "TOP")
        self.addon.playerFrame.runes:SetAlpha(self.addon.db.unit.player.alpha)
        self.addon.playerFrame.runes:SetJustifyH("CENTER")
    end
    self.addon.playerFrame.runes:Show()
    self.addon.mainFrame:RegisterEvent("RUNE_POWER_UPDATE")
end

function module:DisableRune()
    if self.addon.playerFrame.runes then
        self.addon.playerFrame.runes:Hide()
    end
    self.addon.mainFrame:UnregisterEvent("RUNE_POWER_UPDATE")
end

function module:EnableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:DisableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:getTargetText()
    text = ""

    if self.addon.db.class.use_activated_spells then
        for texture, cnt in pairs(activation_spells) do
            if cnt > 0 then
                text = text .. (":|T%s:%d|t"):format(texture, self.addon.db.fontSizeHealth / 2)
            end
        end
    end

    return text
end

function module:updateRunes()
    local text = ""
    local runeReady
    for i = 1, 7 do
        _, _, runeReady = GetRuneCooldown(i)
        if runeReady then
            text = text .. "|TInterface\\PlayerFrame\\UI-PlayerFrame-Deathknight-SingleRune:12|t"
        end
    end
    self.addon.playerFrame.runes:SetText(text)
end

elseif select(2, UnitClass("player")) == "PRIEST" then
local L_PRIEST_CONFIG = "Priest Setting"
local L_USE_PRIEST_ACTIVATED_SPELL = "Displays the spell icons when activating effect."
local L_USE_PRIEST_ACTIVATED_SPELL_TOOLTIP = "Displays the spell icons when activating effect."

-- koKR locale
if GetLocale() == "koKR" then
    L_PRIEST_CONFIG = "사제 설정"
    L_USE_PRIEST_ACTIVATED_SPELL = "발동 효과 아이콘 표시"
    L_USE_PRIEST_ACTIVATED_SPELL_TOOLTIP = "전문화별 발동 효과 발동시 아이콘을 표시합니다."
end

local activation_spells = {}
local config_added = false

local defaultDB = {
    db_ver = 1.0,
    use_activated_spells = true,
}

-------------------------------------------------------------------------------
-- local functions
-------------------------------------------------------------------------------

function tcopy(to, from) -- "to" must be a table (possibly empty)
    for k, v in pairs(from) do
        if (type(v) == "table") then
            if not to then to = {} end
            to[k] = {}
            tcopy(to[k], v)
        else
            to[k] = v
        end
    end
end

-------------------------------------------------------------------------------
-- module functions
-------------------------------------------------------------------------------
function module:init()
    if self.addon.db then
        if not self.addon.db.class or not self.addon.db.class.db_ver or self.addon.db.class.db_ver < defaultDB.db_ver then
            self.addon.db.class = {}
            tcopy(self.addon.db.class, defaultDB)
        end
    end

    if self.addon.db.class.use_activated_spells then
        module:EnableActivatedSpell()
    end

    if not config_added then
        self.addon.guiConfig:CreateLabel(L_PRIEST_CONFIG)
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_PRIEST_ACTIVATED_SPELL,
            tooltip = L_USE_PRIEST_ACTIVATED_SPELL_TOOLTIP,
            key = "use_activated_spells",
            defaultValue = Settings.Default.True,
            get = function()
                return self.addon.db.class.use_activated_spells
            end,
            set = function(value)
                self.addon.db.class.use_activated_spells = value
                if self.addon.db.class.use_activated_spells then
                    module:EnableActivatedSpell()
                else
                    module:DisableActivatedSpell()
                end
            end,
        })

        config_added = true
    end
end

function module:EnableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:DisableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(...)
    local spellID, texture, positions, scale, r, g, b = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon then
        if not activation_spells[icon] then
            activation_spells[icon] = 0
        end
        activation_spells[icon] = activation_spells[icon] + 1
    end
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(...)
    local spellID = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon == 1035040 then
        icon = 1386548 -- hack
    end
    if icon and activation_spells and activation_spells[icon] then
        activation_spells[icon] = activation_spells[icon] - 1
        if activation_spells[icon] < 0 then
            activation_spells[icon] = 0
        end
    end
end

--function module:getPlayerText()
--	local numShadowOrbs = UnitPower( "player", SPELL_POWER_SHADOW_ORBS )
--	if numShadowOrbs > 0 then
--		return (":|cff%02x%02x%02x%d|r"):format(255, 63, 255, numShadowOrbs)
--	end
--	return ""
--end

function module:getTargetText()
    local text = ""

    if self.addon.db.class.use_activated_spells then
        for texture, cnt in pairs(activation_spells) do
            if cnt > 0 then
                text = text .. (":|T%s:%d|t"):format(texture, self.addon.db.fontSizeHealth / 2)
            end
        end
    end

    return text
end

elseif select(2, UnitClass("player")) == "MONK" then

local L_MONK_CONFIG = "Monk Setting"
local L_USE_MONK_ACTIVATED_SPELL = "Displays the spell icons when activating effect."
local L_USE_MONK_ACTIVATED_SPELL_TOOLTIP = "Displays the spell icons when activating effect."
local L_USE_MONK_COMBO_AND_STAGGER = "Displays Stagger% of Brewmaster and number of Chi of Windwalker."
local L_USE_MONK_COMBO_AND_STAGGER_TOOLTIP = "Displays Stagger% of Brewmaster and number of Chi of Windwalker."

-- koKR locale
if GetLocale() == "koKR" then
    L_MONK_CONFIG = "수도사 설정"
    L_USE_MONK_ACTIVATED_SPELL = "발동 효과 아이콘 표시"
    L_USE_MONK_ACTIVATED_SPELL_TOOLTIP = "전문화별 발동 효과 발동시 아이콘을 표시합니다."
    L_USE_MONK_COMBO_AND_STAGGER = "양조의 시간차%, 풍운의 기 개수 표시"
    L_USE_MONK_COMBO_AND_STAGGER_TOOLTIP = "양조의 시간차%, 풍운의 기 갯수를 표시합니다."
end

local activation_spells = {}
local config_added = false

local defaultDB = {
    db_ver = 1.1,
    use_activated_spells = true,
    use_combo_and_stagger = true,
}

-------------------------------------------------------------------------------
-- local functions
-------------------------------------------------------------------------------

function tcopy(to, from) -- "to" must be a table (possibly empty)
    for k, v in pairs(from) do
        if (type(v) == "table") then
            if not to then to = {} end
            to[k] = {}
            tcopy(to[k], v)
        else
            to[k] = v
        end
    end
end

local function updateComboAndStagger()
    local text = ""
    if module.addon.db.class.use_combo_and_stagger then
        local spec = GetSpecialization()
        if spec == 1 then
            local stagger = UnitStagger("player")
            if stagger and stagger > 0 then
                text = ("|cff%02x%02x%02x%d%%|r"):format(255, 255, 150, stagger / UnitHealthMax("player") * 100)
            end
        elseif spec == 3 then
            local numChi = UnitPower("player", Enum.PowerType.Chi)
            if numChi > 0 then
                text = ("|cff%02x%02x%02x%d|r"):format(0, 255, 150, numChi)
            end
        end
    end
    module.addon.playerFrame.combo:SetText(text)
end

-------------------------------------------------------------------------------
-- module functions
-------------------------------------------------------------------------------
function module:init()
    if self.addon.db then
        if not self.addon.db.class or not self.addon.db.class.db_ver or self.addon.db.class.db_ver < defaultDB.db_ver then
            self.addon.db.class = {}
            tcopy(self.addon.db.class, defaultDB)
        end
    end

    if self.addon.db.class.use_activated_spells then
        self:EnableActivatedSpell()
    end

    if self.addon.db.class.use_combo_and_stagger then
        self:EnableComboAndStagger()
    end

    if not config_added then
        self.addon.guiConfig:CreateLabel(L_MONK_CONFIG)
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_MONK_ACTIVATED_SPELL,
            tooltip = L_USE_MONK_ACTIVATED_SPELL_TOOLTIP,
            key = "use_activated_spells",
            defaultValue = Settings.Default.True,
            get = function()
                return self.addon.db.class.use_activated_spells
            end,
            set = function(value)
                self.addon.db.class.use_activated_spells = value
                if self.addon.db.class.use_activated_spells then
                    module:EnableActivatedSpell()
                else
                    module:DisableActivatedSpell()
                end
            end,
        })
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_MONK_COMBO_AND_STAGGER,
            tooltip = L_USE_MONK_COMBO_AND_STAGGER_TOOLTIP,
            key = "use_combo_and_stagger",
            defaultValue = Settings.Default.True,
            get = function()
                return self.addon.db.class.use_combo_and_stagger
            end,
            set = function(value)
                self.addon.db.class.use_combo_and_stagger = value
                if self.addon.db.class.use_combo_and_stagger then
                    module:EnableComboAndStagger()
                else
                    module:DisableComboAndStagger()
                end
            end,
        })

        config_added = true
    end
end

function module:EnableComboAndStagger()
    if not self.addon.playerFrame.combo then
        self.addon.playerFrame.combo = self.addon.playerFrame:CreateFontString(nil, "OVERLAY")
        self.addon.playerFrame.combo:SetFont(self.addon.db.font, self.addon.db.fontSizePower * 0.75,
            self.addon.db.fontOutline)
        self.addon.playerFrame.combo:SetPoint("LEFT", self.addon.playerFrame.health, "RIGHT")
        self.addon.playerFrame.combo:SetAlpha(self.addon.db.unit.player.alpha)
        self.addon.playerFrame.combo:SetJustifyH("LEFT")
    end
    self.addon.playerFrame.combo:Show()
    self:RegisterUpdators(updateComboAndStagger)
end

function module:DisableComboAndStagger()
    if self.addon.playerFrame.combo then
        self.addon.playerFrame.combo:Hide()
    end
    self:UnregisterUpdators(updateComboAndStagger)
end

function module:EnableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:DisableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(...)
    local spellID, texture, positions, scale, r, g, b = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon then
        if not activation_spells[icon] then
            activation_spells[icon] = 0
        end
        activation_spells[icon] = activation_spells[icon] + 1
    end
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(...)
    local spellID = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon and activation_spells and activation_spells[icon] then
        activation_spells[icon] = activation_spells[icon] - 1
        if activation_spells[icon] < 0 then
            activation_spells[icon] = 0
        end
    end
end

--function module:getPlayerText()
--	if self.addon.db.class.use_combo_and_stagger then
--		local spec = GetSpecialization()
--		if spec == 1 then
--			local stagger = UnitStagger( "player")
--			if stagger and stagger > 0 then
--				return (":|cff%02x%02x%02x%d|r"):format(255, 255, 150, stagger / UnitHealthMax("player") * 100)
--			end
--		elseif spec == 3 then
--			local numChi = UnitPower( "player", Enum.PowerType.Chi )
--			if numChi > 0 then
--				return (":|cff%02x%02x%02x%d|r"):format(0, 255, 150, numChi)
--			end
--		end
--	end
--	return ""
--end

function module:getTargetText()
    local text = ""

    if self.addon.db.class.use_activated_spells then
        for texture, cnt in pairs(activation_spells) do
            if cnt > 0 then
                text = text .. (":|T%s:%d|t"):format(texture, self.addon.db.fontSizeHealth / 2)
            end
        end
    end

    return text
end

elseif select(2, UnitClass("player")) == "HUNTER" then

local L_HUNTER_CONFIG = "Hunter Setting"
local L_USE_HUNTER_ACTIVATED_SPELL = "Displays the spell icons when activating effect."
local L_USE_HUNTER_ACTIVATED_SPELL_TOOLTIP = "Displays the spell icons when activating effect."

-- koKR locale
if GetLocale() == "koKR" then
    L_HUNTER_CONFIG = "사냥꾼 설정"
    L_USE_HUNTER_ACTIVATED_SPELL = "발동 효과 아이콘 표시"
    L_USE_HUNTER_ACTIVATED_SPELL_TOOLTIP = "전문화별 발동 효과 발동시 아이콘을 표시합니다."
end


local activation_spells = {}
local config_added = false

local defaultDB = {
    db_ver = 1.0,
    use_activated_spells = true,
}

-------------------------------------------------------------------------------
-- local functions
-------------------------------------------------------------------------------

function tcopy(to, from) -- "to" must be a table (possibly empty)
    for k, v in pairs(from) do
        if (type(v) == "table") then
            if not to then to = {} end
            to[k] = {}
            tcopy(to[k], v)
        else
            to[k] = v
        end
    end
end

-------------------------------------------------------------------------------
-- module functions
-------------------------------------------------------------------------------
function module:init()
    if self.addon.db then
        if not self.addon.db.class or not self.addon.db.class.db_ver or self.addon.db.class.db_ver < defaultDB.db_ver then
            self.addon.db.class = {}
            tcopy(self.addon.db.class, defaultDB)
        end
    end

    if self.addon.db.class.use_activated_spells then
        module:EnableActivatedSpell()
    end

    if not config_added then
        self.addon.guiConfig:CreateLabel(L_HUNTER_CONFIG)
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_HUNTER_ACTIVATED_SPELL,
            tooltip = L_USE_HUNTER_ACTIVATED_SPELL_TOOLTIP,
            key = "use_activated_spells",
            defaultValue = Settings.Default.True,
            get = function()
                return self.addon.db.class.use_activated_spells
            end,
            set = function(value)
                self.addon.db.class.use_activated_spells = value
                if self.addon.db.class.use_activated_spells then
                    module:EnableActivatedSpell()
                else
                    module:DisableActivatedSpell()
                end
            end,
        })

        config_added = true
    end
end

function module:EnableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:DisableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(...)
    local spellID, texture, positions, scale, r, g, b = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon then
        if not activation_spells[icon] then
            activation_spells[icon] = 0
        end
        activation_spells[icon] = activation_spells[icon] + 1
    end
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(...)
    local spellID = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon and activation_spells and activation_spells[icon] then
        activation_spells[icon] = activation_spells[icon] - 1
        if activation_spells[icon] < 0 then
            activation_spells[icon] = 0
        end
    end
end

function module:getTargetText()
    local text = ""

    if self.addon.db.class.use_activated_spells then
        for texture, cnt in pairs(activation_spells) do
            if cnt > 0 then
                text = text .. (":|T%s:%d|t"):format(texture, self.addon.db.fontSizeHealth / 2)
            end
        end
    end

    return text
end


elseif select(2, UnitClass("player")) == "WARLOCK" then

local activation_spells = {}
local loaded = false
local L_WARLOCK_CONFIG = "Warlock Setting"
local L_USE_POWER = "Displays number of Soul Shards."
local L_USE_POWER_TOOLTIP = "Displays number of Soul Shards."
local L_USE_ACTIVATED_SPELL = "Displays the spell icons when activating effect."
local L_USE_ACTIVATED_SPELL_TOOLTIP = "Displays the spell icons when activating effect."

-- koKR locale
if GetLocale() == "koKR" then
    L_USE_POWER = "영혼의 조각 개수 표시"
    L_USE_POWER_TOOLTIP = "영혼의 조각 개수 표시하기"
    L_WARLOCK_CONFIG = "흑마법사 설정"
    L_USE_ACTIVATED_SPELL = "발동 효과 아이콘 표시"
    L_USE_ACTIVATED_SPELL_TOOLTIP = "전문화별 발동 효과 발동시 아이콘을 표시합니다."
end

local text
local name, icon, count, debufType, duration, expirationTime
local size
local auraCount
local usable, nomana
local aCount
local updateAlterPower

local defaultDB = {
    db_ver = 1.0,
    use_activated_spells = true,
    use_power = true,
}
-------------------------------------------------------------------------------
-- local functions
-------------------------------------------------------------------------------

module.config = {
}

function tcopy(to, from) -- "to" must be a table (possibly empty)
    for k, v in pairs(from) do
        if (type(v) == "table") then
            if not to then to = {} end
            to[k] = {}
            tcopy(to[k], v)
        else
            to[k] = v
        end
    end
end

-- local function getSize(baseSize, expirationTime, duration)
-- 	local size = (expirationTime-GetTime()) / duration
-- 	if size < 0.3 then
-- 		size = baseSize * .8
-- 	elseif size < 0.6 then
-- 		size = baseSize * 1.0
-- 	else
-- 		size = baseSize * 1.2
-- 	end
-- 	return size / 2
-- end


-------------------------------------------------------------------------------
-- module functions
-------------------------------------------------------------------------------

function module:init()
    if self.addon.db then
        if not self.addon.db.class or not self.addon.db.class.db_ver or self.addon.db.class.db_ver < defaultDB.db_ver then
            self.addon.db.class = {}
            tcopy(self.addon.db.class, defaultDB)
        end
    end

    if self.addon.db.class.use_activated_spells then
        module:EnableActivatedSpell()
    end

    self.addon.mainFrame:RegisterEvent("PLAYER_ALIVE")
    self.addon.mainFrame:RegisterEvent("LEARNED_SPELL_IN_SKILL_LINE")
    self.addon.mainFrame:RegisterEvent("CHARACTER_POINTS_CHANGED")

    self:update()

    if loaded == false then
        self.addon.guiConfig:CreateLabel(L_WARLOCK_CONFIG)
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_ACTIVATED_SPELL,
            tooltip = L_USE_ACTIVATED_SPELL_TOOLTIP,
            key = "use_activated_spells",
            defaultValue = Settings.Default.True,
            get = function()
                return self.addon.db.class.use_activated_spells
            end,
            set = function(value)
                self.addon.db.class.use_activated_spells = value
                if self.addon.db.class.use_activated_spells then
                    module:EnableActivatedSpell()
                else
                    module:DisableActivatedSpell()
                end
            end,
        })
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_POWER,
            tooltip = L_USE_POWER_TOOLTIP,
            key = "use_power",
            defaultValue = Settings.Default.True,
            get = function()
                return self.addon.db.class.use_power
            end,
            set = function(value)
                self.addon.db.class.use_power = value
                if self.addon.db.class.use_power then
                    module:EnablePower()
                else
                    module:DisablePower()
                end
            end,
        })
    end
    loaded = true
end

function module:update()
    self.primary = GetSpecialization()
    for auraName, t in pairs(self.config) do
        if t.talent and t.talent > 0 then
            local name, iconTexture, tier, column, selected, available = GetTalentInfo(t.talent);
            if name and available then
                self.config[auraName].use = true
                if t.event and self.addon and self.addon.mainFrame then
                    self.addon.mainFrame:RegisterEvent(t.event)
                end
            end
        else
            self.config[auraName].use = false
            if IsPlayerSpell(t.spellid) then
                self.config[auraName].use = true
                if t.event and self.addon and self.addon.mainFrame then
                    self.addon.mainFrame:RegisterEvent(t.event)
                end
            end
        end
    end
    if self.addon.db.class.use_power then
        self:EnablePower()
    else
        self:DisablePower()
    end

end

function module:LEARNED_SPELL_IN_SKILL_LINE(...)
    self:update()
end

module.CHARACTER_POINTS_CHANGED = module.LEARNED_SPELL_IN_SKILL_LINE
function module:PLAYER_ALIVE(...)
    self.addon.mainFrame:UnregisterEvent("PLAYER_ALIVE")
    self:update()
end

function module:EnableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:DisableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(...)
    local spellID, texture, positions, scale, r, g, b = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon and IsSpellKnown(spellID) and IsPlayerSpell(spellID) then
        if not activation_spells[icon] then
            activation_spells[icon] = 0
        end
        activation_spells[icon] = activation_spells[icon] + 1
    end
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(...)
    local spellID = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon and activation_spells and activation_spells[icon] then
        activation_spells[icon] = activation_spells[icon] - 1
        if activation_spells[icon] < 0 then
            activation_spells[icon] = 0
        end
    end
end

function module:EnablePower()
    if not self.addon.playerFrame.altPower then
        self.addon.playerFrame.altPower = self.addon.playerFrame:CreateFontString(nil, "OVERLAY")
        self.addon.playerFrame.altPower:SetFont(self.addon.db.font, self.addon.db.fontSizePower * 0.75,
            self.addon.db.fontOutline)
        self.addon.playerFrame.altPower:SetPoint("BOTTOM", self.addon.playerFrame.health, "TOP")
        self.addon.playerFrame.altPower:SetAlpha(self.addon.db.unit.player.alpha)
        self.addon.playerFrame.altPower:SetJustifyH("CENTER")
    end
    self.addon.playerFrame.altPower:Show()
    self:RegisterUpdators(updateAlterPower)
end

function module:DisablePower()
    if self.addon.playerFrame.altPower then
        self.addon.playerFrame.altPower:Hide()
    end
    self:UnregisterUpdators(updateAlterPower)
end

function updateAlterPower()
    local df = UnitPower("player", Enum.PowerType.SoulShards)
    local text = ""
    if df > 0 then
        text = ("|cff%02x%02x%02x%d|r"):format(127, 82, 127, df)
        module.addon.playerFrame.altPower:SetText(text)
    else
        module.addon.playerFrame.altPower:SetText("")
    end
end

--function module:getPlayerText()
--	if self.addon.db.class.use_power and self.primary == SPEC_WARLOCK_AFFLICTION then
--		if ( IsPlayerSpell(WARLOCK_SOULBURN) ) then
--			local shards = UnitPower( "player", Enum.PowerType.SoulShards )
--			if shards > 0 then
--				return (":|cff%02x%02x%02x%d|r"):format(127, 82, 127, shards)
--			end
--		end
--	end
--	return ""
--end

function module:getTargetText()
    local text = ""

    if self.addon.db.class.use_activated_spells then
        for texture, cnt in pairs(activation_spells) do
            if cnt > 0 then
                text = text .. (":|T%s:%d|t"):format(texture, self.addon.db.fontSizeHealth / 2)
            end
        end
    end

    return text
end

elseif select(2, UnitClass("player")) == "DEMONHUNTER" then

local L_DEMONHUNTER_CONFIG = "Demon Hunter Setting"
local L_USE_DEMONHUNTER_ACTIVATED_SPELL = "Displays the spell icons when activating effect."
local L_USE_DEMONHUNTER_ACTIVATED_SPELL_TOOLTIP = "Displays the spell icons when activating effect."

-- koKR locale
if GetLocale() == "koKR" then
    L_DEMONHUNTER_CONFIG = "악마사냥꾼 설정"
    L_USE_DEMONHUNTER_ACTIVATED_SPELL = "발동 효과 아이콘 표시"
    L_USE_DEMONHUNTER_ACTIVATED_SPELL_TOOLTIP = "전문화별 발동 효과 발동시 아이콘을 표시합니다."
end

local activation_spells = {}
local config_added = false

local defaultDB = {
    db_ver = 1.0,
    use_activated_spells = true,
}

-------------------------------------------------------------------------------
-- local functions
-------------------------------------------------------------------------------

function tcopy(to, from) -- "to" must be a table (possibly empty)
    for k, v in pairs(from) do
        if (type(v) == "table") then
            if not to then to = {} end
            to[k] = {}
            tcopy(to[k], v)
        else
            to[k] = v
        end
    end
end

-------------------------------------------------------------------------------
-- module functions
-------------------------------------------------------------------------------
function module:init()
    if self.addon.db then
        if not self.addon.db.class or not self.addon.db.class.db_ver or self.addon.db.class.db_ver < defaultDB.db_ver then
            self.addon.db.class = {}
            tcopy(self.addon.db.class, defaultDB)
        end
    end

    if self.addon.db.class.use_activated_spells then
        module:EnableActivatedSpell()
    end

    if not config_added then
        self.addon.guiConfig:CreateLabel(L_DEMONHUNTER_CONFIG)
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_DEMONHUNTER_ACTIVATED_SPELL,
            tooltip = L_USE_DEMONHUNTER_ACTIVATED_SPELL_TOOLTIP,
            key = "use_activated_spells",
            defaultValue = Settings.Default.True,
            get = function()
                return self.addon.db.class.use_activated_spells
            end,
            set = function(value)
                self.addon.db.class.use_activated_spells = value
                if self.addon.db.class.use_activated_spells then
                    module:EnableActivatedSpell()
                else
                    module:DisableActivatedSpell()
                end
            end,
        })

        config_added = true
    end
end

function module:EnableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:DisableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(...)
    local spellID, texture, positions, scale, r, g, b = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon then
        if not activation_spells[icon] then
            activation_spells[icon] = 0
        end
        activation_spells[icon] = activation_spells[icon] + 1
    end
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(...)
    local spellID = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon and activation_spells and activation_spells[icon] then
        activation_spells[icon] = activation_spells[icon] - 1
        if activation_spells[icon] < 0 then
            activation_spells[icon] = 0
        end
    end
end

function module:getTargetText()
    local text = ""

    if self.addon.db.class.use_activated_spells then
        for texture, cnt in pairs(activation_spells) do
            if cnt > 0 then
                text = text .. (":|T%s:%d|t"):format(texture, self.addon.db.fontSizeHealth / 2)
            end
        end
    end

    return text
end

elseif select(2, UnitClass("player")) == "EVOKER" then

local L_EVOKER_CONFIG = "Evoker Setting"
local L_USE_EVOKER_ACTIVATED_SPELL = "Displays the spell icons when activating effect."
local L_USE_EVOKER_ACTIVATED_SPELL_TOOLTIP = "Displays the spell icons when activating effect."

-- koKR locale
if GetLocale() == "koKR" then
    L_EVOKER_CONFIG = "기원사 설정"
    L_USE_EVOKER_ACTIVATED_SPELL = "발동 효과 아이콘 표시"
    L_USE_EVOKER_ACTIVATED_SPELL_TOOLTIP = "전문화별 발동 효과 발동시 아이콘을 표시합니다."
end

local activation_spells = {}
local config_added = false

local defaultDB = {
    db_ver = 1.0,
    use_activated_spells = true,
}

-------------------------------------------------------------------------------
-- local functions
-------------------------------------------------------------------------------

function tcopy(to, from) -- "to" must be a table (possibly empty)
    for k, v in pairs(from) do
        if (type(v) == "table") then
            if not to then to = {} end
            to[k] = {}
            tcopy(to[k], v)
        else
            to[k] = v
        end
    end
end

-------------------------------------------------------------------------------
-- module functions
-------------------------------------------------------------------------------
function module:init()
    if self.addon.db then
        if not self.addon.db.class or not self.addon.db.class.db_ver or self.addon.db.class.db_ver < defaultDB.db_ver then
            self.addon.db.class = {}
            tcopy(self.addon.db.class, defaultDB)
        end
    end

    if self.addon.db.class.use_activated_spells then
        module:EnableActivatedSpell()
    end

    if not config_added then
        self.addon.guiConfig:CreateLabel(L_EVOKER_CONFIG)
        self.addon.guiConfig:CreateCheckBox({
            label = L_USE_EVOKER_ACTIVATED_SPELL,
            tooltip = L_USE_EVOKER_ACTIVATED_SPELL_TOOLTIP,
            key = "use_activated_spells",
            defaultValue = Settings.Default.True,
            get = function()
                return self.addon.db.class.use_activated_spells
            end,
            set = function(value)
                self.addon.db.class.use_activated_spells = value
                if self.addon.db.class.use_activated_spells then
                    module:EnableActivatedSpell()
                else
                    module:DisableActivatedSpell()
                end
            end,
        })

        config_added = true
    end
end

function module:EnableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:DisableActivatedSpell()
    activation_spells = {}
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
    self.addon.mainFrame:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(...)
    local spellID, texture, positions, scale, r, g, b = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon then
        if not activation_spells[icon] then
            activation_spells[icon] = 0
        end
        activation_spells[icon] = activation_spells[icon] + 1
    end
end

function module:SPELL_ACTIVATION_OVERLAY_GLOW_HIDE(...)
    local spellID = ...;
    local icon = C_Spell.GetSpellTexture(spellID)
    if icon == 1035040 then
        icon = 1386548 -- hack
    end
    if icon and activation_spells and activation_spells[icon] then
        activation_spells[icon] = activation_spells[icon] - 1
        if activation_spells[icon] < 0 then
            activation_spells[icon] = 0
        end
    end
end

--function module:getPlayerText()
--	local numShadowOrbs = UnitPower( "player", SPELL_POWER_SHADOW_ORBS )
--	if numShadowOrbs > 0 then
--		return (":|cff%02x%02x%02x%d|r"):format(255, 63, 255, numShadowOrbs)
--	end
--	return ""
--end

function module:getTargetText()
    local text = ""

    if self.addon.db.class.use_activated_spells then
        for texture, cnt in pairs(activation_spells) do
            if cnt > 0 then
                text = text .. (":|T%s:%d|t"):format(texture, self.addon.db.fontSizeHealth / 2)
            end
        end
    end

    return text
end
end
local addonName = "BlinkHealthText"
local addon = {}
_G[addonName] = addon

addon.inCombat = false
addon.db = {}
addon.unitFrame = {}
addon.fadingFrame = {}
addon.flashingFrame = {}

-------------------------------------------------------------------------------
-- local variables
-------------------------------------------------------------------------------

local FadeOutTime = .35
local UPDATE_INTERVAL = 0.1

local tcopy
-- local FrameOnEvent
-- local FrameOnUpdate
local MainFrameOnEvent

-- local class = select(2, UnitClass("player"))

local curve = CurveConstants.ScaleTo100

local RaidIconList = {
    "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:",
    "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:",
    "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:",
    "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:",
    "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:",
    "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:",
    "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:",
    "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:",
}

local defaultDB = {
    db_ver = 1.22,
    enable = true,
    font = "Fonts\\K_Pagetext.TTF",
    fontSizeHealth = 28,
    fontSizePower = 20,
    fontSizeHealthForPet = 14,
    fontSizePowerForPet = 10,
    fontOutline = "THICKOUTLINE",
    posX = 170,
    posY = 10,
    predictedText = true,
    useModule = true,
    showRaidIcons = true,
    unit = {
        player = {
            hideOOC = true,
            alpha = 1.0,
            realValue = false,
            realPowerValue = true,
        },
        target = {
            hideOOC = true,
            alpha = 1.0,
            realValue = false,
            realPowerValue = true,
        },
        pet = {
            hideOOC = true,
            alpha = 1.0,
            realValue = false,
            realPowerValue = true,
        },
        --[[
		vehicle = {
			hideOOC = true,
			alpha = 1.0,
			realValue = false,
			realPowerValue = true,
		},
		]]
    },
    powerColor = {
        -- mana
        [0] = {
            r = 0,
            g = 0.6,
            b = 1.0,
        },
        -- rage
        [1] = {
            r = 1.0,
            g = 0.2,
            b = 0.2,
        },
        -- focus
        [2] = {
            r = 1.0,
            g = 0.6,
            b = 0.2,
        },
        -- energy
        [3] = {
            r = 1.0,
            g = 1.0,
            b = 0.2,
        },
        -- COMBO_POINTS
        [4] = {
            r = 1.00,
            g = 0.96,
            b = 0.41
        },
        -- runes
        [5] = {
            r = 0.5,
            g = 0.5,
            b = 0.5,
        },
        -- runic power
        [6] = {
            r = 0.0,
            g = 0.82,
            b = 1.0,
        },
        -- SOUL_SHARDS
        [7] = {
            r = 0.50,
            g = 0.32,
            b = 0.55
        },
        -- LUNAR_POWER
        [8] = {
            r = 0.75,
            g = 0.75,
            b = 1.0,
        },
        -- HOLY_POWER
        [9] = {
            r = 0.95,
            g = 0.90,
            b = 0.60
        },
        -- ALTERNATE_POWER
        [10] = {
            r = 0.90,
            g = 0.90,
            b = 0.90
        },
        -- MAELSTROM
        [11] = {
            r = 0.00,
            g = 0.50,
            b = 1.00
        },
        -- CHI
        [12] = {
            r = 0.71,
            g = 1.0,
            b = 0.92
        },
        -- INSANITY
        [13] = {
            r = 0.40,
            g = 0,
            b = 0.80
        },
        -- fury
        [17] = {
            r = 0.788,
            g = 0.259,
            b = 0.992,
        },
        -- pain
        [18] = {
            r = 255 / 255,
            g = 156 / 255,
            b = 0,
        },
        -- AMMOSLOT
        ["AMMOSLOT"] = {
            r = 0.80,
            g = 0.60,
            b = 0.00,
        },
        -- FUEL
        ["FUEL"] = {
            r = 0.0,
            g = 0.55,
            b = 0.5,
        },
        -- STAGGER
        ["STAGGER"] = {
            { r = 0.52, g = 1.0, b = 0.52 },
            { r = 1.0, g = 0.98, b = 0.72 },
            { r = 1.0, g = 0.42, b = 0.42 },
        },
    },
}

local getArgs, tmp, new, del, gettext, getfunc, gettable, getbool, getvalue, showhide, disable
do
    local cache = setmetatable({}, { __mode = 'k' })
    function new()
        local t = next(cache)
        if t then
            cache[t] = nil
            return t
        else
            return {}
        end
    end

    function del(t)
        for k in pairs(t) do
            t[k] = nil
        end
        cache[t] = true
        return nil
    end

    local t = {}
    function tmp(...)
        for k in pairs(t) do
            t[k] = nil
        end
        for i = 1, select('#', ...), 2 do
            local k = select(i, ...)
            if k then
                t[k] = select(i + 1, ...)
            else
                break
            end
        end
        return t
    end

    local info = {}
    function getArgs(...)
        if type(select(1, ...)) == 'table' then
            info = select(1, ...)
        else
            info = tmp(...)
        end
        return info
    end

    function getbool(value)
        if type(value) == 'boolean' then
            return value
        elseif type(value) == 'function' then
            return value()
        end
    end

    function getvalue(value)
        if type(value) == 'function' then
            return value()
        else
            return value
        end
    end

    function gettext(text)
        if type(text) == 'string' then
            return text
        elseif type(text) == 'function' then
            return text()
        end
    end

    function gettable(t)
        if type(t) == 'table' then
            return t
        elseif type(t) == 'function' then
            return t()
        end
    end

    function getfunc(func)
        if func and type(func) == 'function' then
            return func
        elseif func and type(func) == 'string' then
            local f = getglobal(func)
            if f and type(f) == 'function' then
                return f
            end
        end
    end

    function showhide(frame, showhideValue)
        if showhideValue then
            if getbool(showhideValue) then
                frame:Show()
            else
                frame:Hide()
            end
        else
            frame:Show()
        end
    end

    function disable(frame, disableValue)
        if disableValue then
            if getbool(disableValue) then
                frame.disable()
            else
                frame.enable()
            end
        end
    end
end

-- if LibStub and LibStub["libs"]["LibSharedMedia-3.0"] then
--     local SharedMedia = LibStub:GetLibrary("LibSharedMedia-3.0")
--     fonts = {}
--     local temp = SharedMedia:List("font")
--     for _, name in ipairs(temp) do
--         local font = { text = name, value = SharedMedia:Fetch("font", name), font = SharedMedia:Fetch("font", name),
--             r = 1, g = .82, b = 0, size = 16 }
--         table.insert(fonts, font)
--     end
-- end

function BlinkHealthTextOnUpdate(unitFrame, elapsed)
    unitFrame.timer = unitFrame.timer + elapsed
    if unitFrame.timer > UPDATE_INTERVAL then
        unitFrame.timer = 0
        if unitFrame.unit and UnitIsConnected(unitFrame.unit) then
            addon:DisplayHealthText(unitFrame.unit)
            addon:DisplayPowerText(unitFrame.unit)
            if addon.db.useModule then
                addon:DisplayText(unitFrame.unit)

                if module and module.ExtraUpdators then
                    module:ExtraUpdators(unitFrame.unit)
                end
            end

            --			local currHealth = UnitHealth(unitFrame.unit)
            --			if ( currHealth ~= unitFrame.healthValue ) then
            --				addon:DisplayHealthText(unitFrame.unit)
            --				unitFrame.healthValue = currHealth;
            --			end
            --
            --			local currPower = UnitPower(unitFrame.unit)
            --			if ( currPower ~= unitFrame.powerValue ) then
            --				addon:DisplayPowerText(unitFrame.unit)
            --				unitFrame.powerValue = currPower;
            --			end
            --			addon:DisplayText(unitFrame.unit)
        end
    end
end

-------------------------------------------------------------------------------
-- local functions
-------------------------------------------------------------------------------

function tcopy(to, from) -- "to" must be a table (possibly empty)
    for k, v in pairs(from) do
        if (type(v) == "table") then
            if not to then to = {} end
            to[k] = {}
            tcopy(to[k], v)
        else
            to[k] = v
        end
    end
end

local function FrameOnUpdate(unitFrame)
    if unitFrame.unit and UnitIsConnected(unitFrame.unit) then
        addon:DisplayHealthText(unitFrame.unit)
        addon:DisplayPowerText(unitFrame.unit)
        if addon.db.useModule then
            addon:DisplayText(unitFrame.unit)

            if module and module.ExtraUpdators then
                module:ExtraUpdators(unitFrame.unit)
            end
        end
    end
end

function addon:RegisterEvents(frame)
    C_Timer.NewTicker(UPDATE_INTERVAL, function()
        FrameOnUpdate(frame)
    end);
end

function addon:UnregisterEvents(frame)
    frame:SetScript("OnUpdate", nil)
end

function addon:CreateFrames()
    -- player
    if not self.playerFrame then
        self.playerFrame = CreateFrame("Frame", "BHT_playerFrame", UIParent)
        self.playerFrame:ClearAllPoints()
        self.playerFrame:SetPoint("CENTER", -self.db.posX, self.db.posY)

        self.playerFrame.health = self.playerFrame:CreateFontString(nil, "OVERLAY")
        self.playerFrame.health:SetFont(self.db.font, self.db.fontSizeHealth, self.db.fontOutline)
        self.playerFrame.health:SetPoint("CENTER", self.playerFrame)
        self.playerFrame.health:SetAlpha(self.db.unit.player.alpha)
        self.playerFrame.health:SetJustifyH("CENTER")

        self.playerFrame.power = self.playerFrame:CreateFontString(nil, "OVERLAY")
        self.playerFrame.power:SetFont(self.db.font, self.db.fontSizePower, self.db.fontOutline)
        self.playerFrame.power:SetPoint("TOP", self.playerFrame.health, "BOTTOM")
        self.playerFrame.power:SetAlpha(self.db.unit.player.alpha)
        self.playerFrame.power:SetJustifyH("CENTER")

        self.playerFrame.text = self.playerFrame:CreateFontString(nil, "OVERLAY")
        self.playerFrame.text:SetFont(self.db.font, self.db.fontSizeHealth, self.db.fontOutline)
        self.playerFrame.text:SetPoint("LEFT", self.playerFrame.health, "RIGHT")
        self.playerFrame.text:SetAlpha(self.db.unit.player.alpha)
        self.playerFrame.text:SetJustifyH("LEFT")

        self.playerFrame.texture = self.playerFrame:CreateTexture(nil, "OVERLAY")
        self.playerFrame.texture:SetPoint("LEFT", self.playerFrame.text, "RIGHT", 5, 0)
        self.playerFrame.texture:SetSize(self.db.fontSizeHealth, self.db.fontSizeHealth)
        self.playerFrame.texture:SetAlpha(self.db.unit.player.alpha)
        self.playerFrame.texture:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
        self.playerFrame.texture:Hide()

        self.playerFrame:SetHeight(self.playerFrame.health:GetHeight() + self.playerFrame.power:GetHeight())
        self.playerFrame:SetWidth(150)

        self.playerFrame.timer = 0
        self.playerFrame.healthValue = 0
        self.playerFrame.powerValue = 0
        self.playerFrame.unit = "player"
        self.unitFrame["player"] = self.playerFrame
    end
    self:RegisterEvents(self.playerFrame)

    -- target
    if not self.targetFrame then
        self.targetFrame = CreateFrame("Frame", "BHT_targetFrame", UIParent)
        self.targetFrame:ClearAllPoints()
        self.targetFrame:SetPoint("CENTER", self.db.posX, self.db.posY)

        self.targetFrame.health = self.targetFrame:CreateFontString(nil, "OVERLAY")
        self.targetFrame.health:SetFont(self.db.font, self.db.fontSizeHealth, self.db.fontOutline)
        self.targetFrame.health:SetPoint("CENTER", self.targetFrame)
        self.targetFrame.health:SetAlpha(self.db.unit.target.alpha)
        self.targetFrame.health:SetJustifyH("CENTER")

        self.targetFrame.power = self.targetFrame:CreateFontString(nil, "OVERLAY")
        self.targetFrame.power:SetFont(self.db.font, self.db.fontSizePower, self.db.fontOutline)
        self.targetFrame.power:SetPoint("TOP", self.targetFrame.health, "BOTTOM")
        self.targetFrame.power:SetAlpha(self.db.unit.target.alpha)
        self.targetFrame.power:SetJustifyH("CENTER")

        self.targetFrame.text = self.targetFrame:CreateFontString(nil, "OVERLAY")
        self.targetFrame.text:SetFont(self.db.font, self.db.fontSizeHealth, self.db.fontOutline)
        self.targetFrame.text:SetPoint("LEFT", self.targetFrame.health, "RIGHT")
        self.targetFrame.text:SetAlpha(self.db.unit.target.alpha)
        self.targetFrame.text:SetJustifyH("LEFT")

        self.targetFrame.texture = self.targetFrame:CreateTexture(nil, "OVERLAY")
        self.targetFrame.texture:SetPoint("LEFT", self.targetFrame.text, "RIGHT", 5, 0)
        self.targetFrame.texture:SetSize(self.db.fontSizeHealth, self.db.fontSizeHealth)
        self.targetFrame.texture:SetAlpha(self.db.unit.target.alpha)
        self.targetFrame.texture:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
        self.targetFrame.texture:Hide()

        self.targetFrame:SetHeight(self.targetFrame.health:GetHeight() + self.targetFrame.power:GetHeight())
        self.targetFrame:SetWidth(150)

        self.targetFrame.timer = 0
        self.targetFrame.healthValue = 0
        self.targetFrame.powerValue = 0
        self.targetFrame.unit = "target"
        self.unitFrame["target"] = self.targetFrame
    end
    self:RegisterEvents(self.targetFrame)

    -- player's pet
    if not self.petFrame then
        self.petFrame = CreateFrame("Frame", "BHT_petFrame", UIParent)
        self.petFrame:ClearAllPoints()
        self.petFrame:SetPoint("TOPRIGHT", self.playerFrame.health, "TOPLEFT", 0, 0)

        self.petFrame.health = self.petFrame:CreateFontString(nil, "OVERLAY")
        self.petFrame.health:SetFont(self.db.font, self.db.fontSizeHealthForPet, self.db.fontOutline)
        self.petFrame.health:SetPoint("TOPRIGHT", self.petFrame, "TOPRIGHT")
        self.petFrame.health:SetAlpha(self.db.unit.pet.alpha)
        self.petFrame.health:SetJustifyH("CENTER")

        self.petFrame.power = self.petFrame:CreateFontString(nil, "OVERLAY")
        self.petFrame.power:SetFont(self.db.font, self.db.fontSizePowerForPet, self.db.fontOutline)
        self.petFrame.power:SetPoint("TOP", self.petFrame.health, "BOTTOM")
        self.petFrame.power:SetAlpha(self.db.unit.pet.alpha)
        self.petFrame.power:SetJustifyH("CENTER")

        self.petFrame.text = self.petFrame:CreateFontString(nil, "OVERLAY")
        self.petFrame.text:SetFont(self.db.font, self.db.fontSizeHealthForPet, self.db.fontOutline)
        self.petFrame.text:SetPoint("LEFT", self.petFrame.health, "RIGHT")
        self.petFrame.text:SetAlpha(self.db.unit.pet.alpha)
        self.petFrame.text:SetJustifyH("LEFT")

        self.petFrame:SetHeight(self.petFrame.health:GetHeight() + self.petFrame.power:GetHeight())
        self.petFrame:SetWidth(150)

        self.petFrame.timer = 0
        self.petFrame.healthValue = 0
        self.petFrame.powerValue = 0
        self.petFrame.unit = "pet"
        self.unitFrame["pet"] = self.petFrame
    end
    self:RegisterEvents(self.petFrame)
end

-------------------------------------------------------------------------------
-- functions
-------------------------------------------------------------------------------

function addon:getHealthColor(unit)
    local r, g, b = .7, .7, .7
    if (not UnitIsVisible(unit)) then
        return .7, .7, .7
    end

    if self.db.useModule then
        local exist
        if unit == "target" and module and module.getTargetHealthColor and type(module.getTargetHealthColor) == 'function' then
            exist, r, g, b = module:getTargetHealthColor()
            if exist then
                return r, g, b
            end
        elseif unit == "player" and module and module.getPlayerHealthColor and type(module.getPlayerHealthColor) == 'function' then
            exist, r, g, b = module:getPlayerHealthColor()
            if exist then
                return r, g, b
            end
        end
    end

    local perH = 100 -- UnitHealthPercent(unit, false, curve)
    if (perH < 20) then -- Execute, Hammer of Wrath
        r, g, b = 1.0, 0.0, 0.2
    elseif (perH < 80 and perH >= 20) then
        r, g, b = 1.0, 1.0, 0.2
    else
        r, g, b = 0.0, 1.0, 0.2
    end
    -- -- 보호막이 있으면 색상변경
    -- local totalAbsorb = UnitGetTotalAbsorbs(unit)
    -- if totalAbsorb then
    --     r, g, b = 0.4, 0.4, 0.97
    -- end
    return r, g, b
end

function addon:getPowerColor(unit)
    local powerType, powerToken, altR, altG, altB = UnitPowerType(unit)
    local info = self.db.powerColor[powerToken]

    if (not info) then
        if (not altR) then
            -- couldn't find a power token entry...default to indexing by power type or just mana if we don't have that either
            info = self.db.powerColor[powerType] or self.db.powerColor[0]
        else
            return altR, altG, altB;
        end
    end
    return info.r, info.g, info.b
end

function addon:DisplayText(unit)
    local frame
    if not unit then
        return
    end

    if self.unitFrame[unit] then
        frame = self.unitFrame[unit]
    else
        return
    end

    if not frame.text then
        return
    end

    if (frame and not frame:IsShown()) then
        return
    end

    local func
    local text = ""
    if module and self.db.useModule then
        if unit == "player" then
            func = module.getPlayerText
        elseif unit == "target" then
            func = module.getTargetText
        elseif unit == "pet" or unit == "vehicle" then
            func = module.getPetText
        end
        if func and type(func) == 'function' then
            if unit == "target" then
                if not UnitHasVehicleUI("player") then
                    text = func(module) or ""
                end
                if frame.texture then
                    local rii = self:DisplayRaidIcon("target")
                    if rii then
                        frame.texture:SetSpriteSheetCell(rii, RAID_TARGET_TEXTURE_ROWS, RAID_TARGET_TEXTURE_COLUMNS);
                        frame.texture:Show()
                    else
                        frame.texture:Hide()
                    end
                end
            else
                text = func(module)
            end
            frame.text:SetText(text)
        else
            frame.text:SetText("")
        end
    else
        frame.text:SetText("")
    end
end

function addon:DisplayHealthText(unit)
    local frame
    if not unit then
        return
    end

    if self.unitFrame[unit] then
        frame = self.unitFrame[unit]
    else
        return
    end

    if (frame and not frame:IsShown()) then
        return
    end

    if UnitIsDeadOrGhost(unit) then
        frame.health:SetTextColor(0.6, 0.6, 0.6)
        if UnitIsGhost(unit) then
            frame.health:SetText("Ghost")
            return
        else
            frame.health:SetText("Dead")
            return
        end
    elseif not UnitExists(unit) then
        frame:Hide()
        -- HideUIPanel(frame)
        return
    elseif not UnitIsConnected(unit) then
        frame.health:SetTextColor(0.6, 0.6, 0.6)
        frame.health:SetText("Offline")
        return
    end

    local ch, healthText = UnitHealth(unit), ""
    local totalAbsorb = UnitGetTotalAbsorbs(unit) or 0
    local perH = UnitHealthPercent(unit, false, curve)

    if unit == "player" and self.db.unit.player.realValue then
        healthText = AbbreviateLargeNumbers(ch)
    elseif unit == "pet" and self.db.unit.pet.realValue then
        healthText = AbbreviateLargeNumbers(ch)
    elseif unit == "vehicle" and self.db.unit.pet.realValue then -- @.@
        healthText = AbbreviateLargeNumbers(ch)
    elseif unit == "target" and self.db.unit.target.realValue then
        healthText = AbbreviateLargeNumbers(ch)
    else
        healthText = string.format("%d", perH)
    end

    local r, g, b = self:getHealthColor(unit)
    frame.health:SetTextColor(r, g, b)
    frame.health:SetText(healthText)
end

function addon:DisplayPowerText(unit)
    local frame
    if not unit then
        return
    end

    if self.unitFrame[unit] then
        frame = self.unitFrame[unit]
    else
        return
    end

    if (not frame:IsShown()) then
        return
    end

    local powerText = UnitPower(unit)
    local perM = UnitPowerPercent(unit, nil, false, curve)

    if (unit == "player" and not self.db.unit.player.realPowerValue)
        or (unit == "pet" and not self.db.unit.pet.realPowerValue)
        or ( unit == "vehicle" and not self.db.unit.pet.realPowerValue)
        or (unit == "target" and not self.db.unit.target.realPowerValue) then
        powerText = string.format("%d", perM)
    end

    local r, g, b = self:getPowerColor(unit)
    frame.power:SetTextColor(r, g, b)
    frame.power:SetText(powerText)
end

function addon:DisplayRaidIcon(unit)
    if self.db.showRaidIcons then
        return GetRaidTargetIndex(unit)
    else
        return nil
    end
end

-------------------------------------------------------------------------------
-- functions
-------------------------------------------------------------------------------

function addon:FrameFadeOut(frame, timeToFade, startAlpha, endAlpha)
    if not self.fadingFrame[frame] then
        return
    end
    local fadeInfo = {}
    fadeInfo.mode = "OUT"
    fadeInfo.timeToFade = timeToFade
    fadeInfo.startAlpha = startAlpha
    fadeInfo.endAlpha = endAlpha
    fadeInfo.finishedFunc = function()
        addon.fadingFrame[frame] = nil
        --[[
		if addon.db.enable then
			if frame == addon.playerFrame then
				if ( addon.db.alphaType == "Combat" and InCombatLockdown() ) or ( addon.db.alphaType == "Target" and UnitExists("target") ) then
					frame:SetAlpha(db.alphaPlayerB)
					return
				end
			elseif frame == targetFrame and UnitExists("target") then
				if ( db.alphaType == "Combat" and InCombatLockdown() ) or ( db.alphaType == "Target" and UnitExists("target") ) then
					frame:SetAlpha(db.alphaTargetB)
					return
				end
			elseif frame == petFrame and UnitExists("pet") then
				if ( db.alphaType == "Combat" and InCombatLockdown() ) or ( db.alphaType == "Target" and UnitExists("target") ) then
					frame:SetAlpha(db.alphaPetB)
					return
				end
			end
		end
		]]
        frame:Hide()
        -- HideUIPanel(frame)
        if frame.text then
            frame.text:SetText("")
        end
    end
    UIFrameFade(frame, fadeInfo)
end

function addon:FrameFlash(frame, fadeInTime, fadeOutTime, flashDuration, showWhenDone, flashInHoldTime, flashOutHoldTime)
    if not self.flashingFrame[frame] then
        return
    end
    UIFrameFlash(frame, fadeInTime, fadeOutTime, flashDuration, showWhenDone, flashInHoldTime, flashOutHoldTime)
end

function addon:FrameUpdate(unit)
    local db_unit = unit == "vehicle" and "player" or unit

    if not unit or not self.unitFrame[unit] then
        return
    end

    if not self.db.unit[db_unit] then
        return
    end
    if (not self.db.unit[db_unit].hideOOC or self.inCombat) and UnitExists(unit) then
        if not self.unitFrame[unit]:IsShown() then
            self.unitFrame[unit]:Show()
        end
        -- ShowUIPanel(self.unitFrame[unit])
        self.unitFrame[unit]:SetAlpha(self.db.unit[db_unit].alpha)
        self:DisplayHealthText(unit)
        self:DisplayPowerText(unit)
        if self.db.useModule then
            self:DisplayText(unit)
        end
        UIFrameFadeRemoveFrame(self.unitFrame[unit])
        self.fadingFrame[self.unitFrame[unit]] = nil
    else
        if self.unitFrame[unit]:IsShown() then
            self.fadingFrame[self.unitFrame[unit]] = true
            self:FrameFadeOut(self.unitFrame[unit], FadeOutTime, self.unitFrame[unit]:GetAlpha(), 0)
        end
    end
end

function addon:FrameFontUpdate()
    local healthSize, powerSize
    for unit, frame in pairs(self.unitFrame) do
        if frame == self.petFrame then
            healthSize, powerSize = self.db.fontSizeHealthForPet, self.db.fontSizePowerForPet
        else
            healthSize, powerSize = self.db.fontSizeHealth, self.db.fontSizePower
        end
        frame.health:SetFont(self.db.font, healthSize, self.db.fontOutline)
        frame.power:SetFont(self.db.font, powerSize, self.db.fontOutline)
        if frame.text then
            frame.text:SetFont(self.db.font, healthSize, self.db.fontOutline)
        end
        if frame.texture then
            frame.texture:SetSize(healthSize, healthSize)
        end
    end
end

function addon:FramePositionUpdate()
    self.playerFrame:ClearAllPoints()
    self.playerFrame:SetPoint("CENTER", -self.db.posX, self.db.posY)

    self.targetFrame:ClearAllPoints()
    self.targetFrame:SetPoint("CENTER", self.db.posX, self.db.posY)
end

function addon:EnableAddon()
    self.mainFrame:RegisterEvent("UNIT_PET")
    self.mainFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
    self.mainFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
    self.mainFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
    self.mainFrame:RegisterEvent("UNIT_ENTERED_VEHICLE")
    self.mainFrame:RegisterEvent("UNIT_ENTERING_VEHICLE")
    self.mainFrame:RegisterEvent("UNIT_EXITING_VEHICLE")
    self.mainFrame:RegisterEvent("UNIT_EXITED_VEHICLE")
    --self.mainFrame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
    self.mainFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
    --mainFrame:RegisterEvent("PLAYER_ENTERING_WORLD")


    self:CreateFrames()
    self:FrameFontUpdate()
    self:FramePositionUpdate()

    if module then
        module.addon = self
        if module.init and type(module.init) == 'function' then
            module:init()
        end
    end

    self:FrameUpdate("player")
    self:FrameUpdate("target")
    if UnitHasVehicleUI("player") then
        self:FrameUpdate("vehicle")
    else
        self:FrameUpdate("pet")
    end
end

function addon:DisableAddon()
    self.mainFrame:UnregisterAllEvents()

    self.playerFrame:Hide()
    self:UnregisterEvents(self.playerFrame)
    self.playerFrame = nil

    self.targetFrame:Hide()
    self:UnregisterEvents(self.targetFrame)
    self.targetFrame = nil

    -- self.petFrame:Hide()
    -- self:UnregisterEvents(self.petFrame)
    -- self.petFrame = nil
end

function addon:GetMiscConfig()
    if module and module.GetMiscConfig then
        return module:GetMiscConfig()
    end
end

function addon:ShowHideMiscConfig()
    if module and module.GetMiscConfig then
        return #module:GetMiscConfig() > 0
    end
    return false
end

-- event handler --------------------------------------------------------------

function FrameOnEvent(self, event, ...)
    local unit = select(1, ...)
    if (unit ~= "player" and unit ~= "target" and unit ~= "pet" and unit ~= "vehicle") then
        return
    end
    if (event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH") then
        addon:DisplayHealthText(unit)
    else
        addon:DisplayPowerText(unit)
    end
end

function MainFrameOnEvent(self, event, ...)
    local arg1, arg2, arg3, arg4, arg5 = ...;
    if (event == "PLAYER_ENTERING_WORLD") then
        if addon.db.enable then
            addon:EnableAddon()
        end
    elseif event == "PLAYER_TARGET_CHANGED" then
        addon:FrameUpdate("target")
    elseif event == "PLAYER_REGEN_DISABLED" then
        addon.inCombat = true
        addon:FrameUpdate("player")
        addon:FrameUpdate("target")
        if UnitHasVehicleUI("player") then
            addon:FrameUpdate("vehicle")
        else
            addon:FrameUpdate("pet")
        end
    elseif event == "PLAYER_REGEN_ENABLED" then
        addon.inCombat = false
        addon:FrameUpdate("player")
        addon:FrameUpdate("target")
        if UnitHasVehicleUI("player") then
            addon:FrameUpdate("vehicle")
        else
            addon:FrameUpdate("pet")
        end
    elseif event == "UNIT_PET" and arg1 == "player" then
        addon:FrameUpdate("player")
        addon:FrameUpdate("target")
        if UnitHasVehicleUI("player") then
            addon:FrameUpdate("vehicle")
        else
            addon:FrameUpdate("pet")
        end
    elseif event == "UNIT_ENTERED_VEHICLE" and arg1 == "player" then
        if (UnitHasVehicleUI("player")) then
            addon.petFrame.unit = "player"
            addon.playerFrame.unit = "vehicle"
            addon.unitFrame["pet"] = nil
            addon.unitFrame["player"] = addon.petFrame
            addon.unitFrame["vehicle"] = addon.playerFrame
            addon:FrameUpdate("player")
            addon:FrameUpdate("vehicle")
        end
    elseif event == "UNIT_EXITED_VEHICLE" then --and arg1 == "player" then
        addon.petFrame.unit = "pet"
        addon.playerFrame.unit = "player"
        addon.unitFrame["vehicle"] = nil
        addon.unitFrame["pet"] = addon.petFrame
        addon.unitFrame["player"] = addon.playerFrame
        addon:FrameUpdate("pet")
        addon:FrameUpdate("player")
    elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
        if module and arg1 == "player" then
            module.addon = addon
            if module.init and type(module.init) == 'function' then
                module:init()
            end
        end
    end

    if module and addon.db.useModule then
        if module[event] then
            module[event](module, ...)
        end
    end
end

function addon:registGUI()
    self.guiConfig = guiConfig
    guiConfig:registBlizzGUI(self);
end

addon.mainFrame = CreateFrame("Frame")
addon.mainFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
addon.mainFrame:SetScript("OnEvent", MainFrameOnEvent)

EventRegistry:RegisterFrameEventAndCallback("VARIABLES_LOADED", function()
    if not BlinkHealthTextDB or not BlinkHealthTextDB.db_ver or BlinkHealthTextDB.db_ver < defaultDB.db_ver then
        BlinkHealthTextDB = {}
        tcopy(BlinkHealthTextDB, defaultDB)
        print(BHTL.DB_MIGRATION)
    end
    addon.db = BlinkHealthTextDB

    addon:registGUI()
end)
