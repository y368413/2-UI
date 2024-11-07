local AngrierWorldQuests = {}
AngrierWorldQuests = LibStub("AceAddon-3.0"):NewAddon("AngrierWorldQuests")
AngrierWorldQuests.Name = ANGRYWORLDQUEST_TITLE
AngrierWorldQuests.Version = "11.0.5-20241030-1"

_AngrierWorldQuests = {
    Constants = {
        CURRENCY_IDS = {
            RESOURCES = 1220,
            WAR_SUPPLIES = 1342,
            NETHERSHARD = 1226,
            WAKENING_ESSENCE = 1533,
            AZERITE = 1553,
            WAR_RESOURCES = 1560
        },
        FILTERS = {
            CURRENCY = 1,
            LOOT_ALL = 1,
            LOOT_UPGRADES = 2
        },
        MAP_IDS = {
            BROKENISLES = 619,
            DALARAN = 627,
            AZEROTH = 947
        }
    },
    Enums = {
        Expansion = {
            LEGION = 7,
            BFA = 8,
            SHADOWLANDS = 9,
            DRAGONFLIGHTS = 10,
            THE_WAR_WITHIN = 11
        },
        SortOrder = {
            SORT_NAME = 1,
            SORT_TIME = 2,
            SORT_ZONE = 3,
            SORT_FACTION = 4,
            SORT_REWARDS = 5
        }
    },
    Events = {
    },
}

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

AWQ_DropDownList1 = Lib_DropDownList1 or DropDownList1
AWQ_HideDropDownMenu = Lib_HideDropDownMenu or HideDropDownMenu
AWQ_ToggleDropDownMenu = Lib_ToggleDropDownMenu or ToggleDropDownMenu

AWQ_UIDropDownMenuTemplate = Lib_UIDropDownMenu_Initialize and "Lib_UIDropDownMenuTemplate" or "UIDropDownMenuTemplate"
AWQ_UIDropDownMenu_AddButton = Lib_UIDropDownMenu_AddButton or UIDropDownMenu_AddButton
AWQ_UIDropDownMenu_CreateInfo = Lib_UIDropDownMenu_CreateInfo or UIDropDownMenu_CreateInfo
AWQ_UIDropDownMenu_GetSelectedValue = Lib_UIDropDownMenu_GetSelectedValue or UIDropDownMenu_GetSelectedValue
AWQ_UIDropDownMenu_Initialize = Lib_UIDropDownMenu_Initialize or UIDropDownMenu_Initialize
AWQ_UIDropDownMenu_SetSelectedValue = Lib_UIDropDownMenu_SetSelectedValue or UIDropDownMenu_SetSelectedValue

local AWQL = {}
if GetLocale() == "zhCN" then
AWQL["CONDUIT_ITEMS"] = "导灵器"
AWQL["config_characterConfig"] = "为角色进行独立的配置"
--[[Translation missing --]]
AWQL["config_colorWarbandBonus"] = "将世界任务着色，带有战团加成的任务标记为蓝色。"
AWQL["config_enableDebugging"] = "启用调试模式（需要安装DebugLog插件）"
AWQL["config_enabledFilters"] = "启用过滤"
--[[Translation missing --]]
AWQL["config_enableTaintWorkarounds"] = "启用污染规避方法 - 重新加载用户界面（可能产生未知效果）"
AWQL["config_hideFilteredPOI"] = "在世界地图上隐藏被过滤的任务"
AWQL["config_hideQuestList"] = "在任务日志中隐藏世界任务。"
AWQL["config_hideUntrackedPOI"] = "在世界地图上隐藏未被追踪的任务"
AWQL["config_lootFilterUpgrades"] = "在物品过滤里仅显示更高装等的物品任务"
AWQL["config_lootUpgradesLevel"] = "可升级物品装等过滤"
AWQL["config_lootUpgradesLevelValue"] = "最多相差%d装等"
AWQL["config_lootUpgradesLevelValue1"] = "仅显示更高装等"
AWQL["config_lootUpgradesLevelValue2"] = "显示最高同等级"
AWQL["config_onlyCurrentZone"] = "仅显示当前区域的任务列表"
AWQL["config_saveFilters"] = "自动保存最后选择的过滤"
AWQL["config_showAtTop"] = "将任务列表置于任务日志顶部"
AWQL["config_showContinentPOI"] = "在大陆上显示世界任务图标"
AWQL["config_showHoveredPOI"] = "总是显示鼠标悬停的世界任务"
AWQL["config_sortMethod"] = "任务列表排序"
AWQL["config_sortMethod_1"] = "名字"
AWQL["config_sortMethod_2"] = "剩余时间"
AWQL["config_sortMethod_3"] = "区域"
AWQL["config_sortMethod_4"] = "声望"
--[[Translation missing --]]
AWQL["config_sortMethod_5"] = "奖励"
AWQL["config_timeFilterDuration"] = "剩余时间过滤时长"
AWQL["CURRENT_ZONE"] = "当前区域"
AWQL["UPGRADES"] = "可升级"
elseif GetLocale() == "zhTW" then
AWQL["CONDUIT_ITEMS"] = "靈印"
AWQL["config_characterConfig"] = "為角色進行獨立的配置"
--[[Translation missing --]]
AWQL["config_colorWarbandBonus"] = "將世界任務著色，帶有戰團加成的任務標記為藍色。"
AWQL["config_enableDebugging"] = "啟用調試模式（需要安裝DebugLog外掛程式）"
AWQL["config_enabledFilters"] = "啟用過濾"
--[[Translation missing --]]
AWQL["config_enableTaintWorkarounds"] = "啟用污染規避方法 - 重新載入使用者介面（可能產生未知效果）"
AWQL["config_hideFilteredPOI"] = "在世界地圖上隱藏被過濾的任務"
AWQL["config_hideQuestList"] = "在任務日誌中隱藏世界任務。"
AWQL["config_hideUntrackedPOI"] = "在世界地圖上隱藏未被追蹤的任務"
AWQL["config_lootFilterUpgrades"] = "在物品過濾裏僅顯示更高裝等的物品任務"
AWQL["config_lootUpgradesLevel"] = "可升級物品裝等過濾"
AWQL["config_lootUpgradesLevelValue"] = "最多相差%d裝等"
AWQL["config_lootUpgradesLevelValue1"] = "僅顯示更高裝等物品"
AWQL["config_lootUpgradesLevelValue2"] = "顯示最高同裝等物品"
AWQL["config_onlyCurrentZone"] = "僅顯示當前區域的任務列表"
AWQL["config_saveFilters"] = "自動保存最後選擇的過濾"
AWQL["config_showAtTop"] = "將任務列表置於任務日誌頂部"
AWQL["config_showContinentPOI"] = "在大陸上顯示世界任務圖標"
AWQL["config_showHoveredPOI"] = "總是顯示鼠標懸停的世界任務"
AWQL["config_sortMethod"] = "任務列表排序"
AWQL["config_sortMethod_1"] = "名字"
AWQL["config_sortMethod_2"] = "剩餘時間"
AWQL["config_sortMethod_3"] = "區域"
AWQL["config_sortMethod_4"] = "聲望"
--[[Translation missing --]]
AWQL["config_sortMethod_5"] = "獎勵"
AWQL["config_timeFilterDuration"] = "剩餘時間過濾時長"
AWQL["CURRENT_ZONE"] = "當前區域"
AWQL["UPGRADES"] = "可升級"
else
AWQL["CONDUIT_ITEMS"] = "Conduit items"
AWQL["config_characterConfig"] = "Per-character configuration"
AWQL["config_colorWarbandBonus"] = "Color World Quests with Warband bonus blue"
AWQL["config_enableDebugging"] = "Enable debugging (requires DebugLog addon installed)"
AWQL["config_enabledFilters"] = "Enabled Filters"
AWQL["config_enableTaintWorkarounds"] = "Enable taint workarounds - Reloads UI (might have unknown effects)"
AWQL["config_hideFilteredPOI"] = "Hide filtered World Quest POI icons on the world map"
AWQL["config_hideQuestList"] = "Hide World Quests in the quest log"
AWQL["config_hideUntrackedPOI"] = "Hide untracked World Quest POI icons on the world map"
AWQL["config_lootFilterUpgrades"] = "Show only upgrades for Loot filter"
AWQL["config_lootUpgradesLevel"] = "Loot filter shows upgrades"
AWQL["config_lootUpgradesLevelValue"] = "Up to %d ilvls less"
AWQL["config_lootUpgradesLevelValue1"] = "Higher ilvl only"
AWQL["config_lootUpgradesLevelValue2"] = "Up to same ilvl"
AWQL["config_onlyCurrentZone"] = "Only show World Quests for the current zone"
AWQL["config_saveFilters"] = "Save active filters between logins"
AWQL["config_showAtTop"] = "Display at the top of the Quest Log"
AWQL["config_showContinentPOI"] = "Show World Quest POI icons on continent maps"
AWQL["config_showHoveredPOI"] = "Always show hovered World Quest POI icon"
AWQL["config_sortMethod"] = "Sort World Quests by"
AWQL["config_sortMethod_1"] = "Name"
AWQL["config_sortMethod_2"] = "Time Left"
AWQL["config_sortMethod_3"] = "Zone"
AWQL["config_sortMethod_4"] = "Faction"
AWQL["config_sortMethod_5"] = "Rewards"
AWQL["config_timeFilterDuration"] = "Time Remaining filter duration"
AWQL["CURRENT_ZONE"] = "Current Zone"
AWQL["UPGRADES"] = "Upgrades"
end

local AngrierWorldQuests = LibStub("AceAddon-3.0"):GetAddon("AngrierWorldQuests")
local DBModule = AngrierWorldQuests:NewModule("DBModule")

local defaultOptions = {
    profile = {
        collapsed = "false",
        showAtTop = "true",
        showHoveredPOI = "false",
        onlyCurrentZone = "true",
        selectedFilters = 0,
        disabledFilters = 3725425,
        __filters = 24,
        filterEmissary = 0,
        filterLoot = 0,
        filterFaction = 0,
        filterZone = 0,
        filterTime = 0,
        lootFilterUpgrades = "false",
        lootUpgradesLevel = -1,
        timeFilterDuration = 6,
        hideUntrackedPOI = "false",
        hideFilteredPOI = "true",
        hideQuestList = "false",
        showContinentPOI = "true",
        colorWarbandBonus = "false",
        enableDebugging = "false",
        enableTaintWorkarounds = "false",
        sortMethod = 2,
        extendedInfo = "false",
        saveFilters = "false"
    }
}

function DBModule:OnInitialize()
    self.AceDB = LibStub("AceDB-3.0"):New("AngrierWorldQuestsDB", defaultOptions, true)

    self:MigrateProfile()
end

function DBModule:GetProfile()
    return self.AceDB.profile
end

function DBModule:GetValue(key)
    return self:GetProfile()[key] or defaultOptions.profile[key]
end

function DBModule:SetValue(key, value)
    if value == defaultOptions.profile[key] then
        self:GetProfile()[key] = nil
    else
        self:GetProfile()[key] = value
    end
end

function DBModule:Reset()
    for k, _ in pairs(defaultOptions.profile) do
        self:SetValue(k, nil)
    end
end

-- region Migrations
do
    local function GetDataVersion(profile)
        return profile.dataVersion or 0
    end

    local function MigrateOldSettings(profile)
        local sharedDB = LibStub("AceDB-3.0"):New("AngrierWorldQuests_Config")

        if sharedDB and sharedDB.sv then
            for k, v in pairs(sharedDB.sv) do
                local usable = defaultOptions.profile[k] ~= nil
    
                if usable then
                    DBModule:SetValue(k, v)
                end

                sharedDB.sv[k] = nil
            end
        end

        profile.dataVersion = 1
        return GetDataVersion(profile)
    end

    local function MigrateTrueFalseToStrings(profile)
        for k, v in pairs(defaultOptions.profile) do
            if DBModule:GetValue(k) == true then
                DBModule:SetValue(k, "true")
            end
        end

        profile.dataVersion = 2
        return GetDataVersion(profile)
    end

    function DBModule:MigrateProfile()
        local profile = self:GetProfile()
        local version = GetDataVersion(profile)

        if version < 1 then
            version = MigrateOldSettings(profile)
        end
        if version < 2 then
            version = MigrateTrueFalseToStrings(profile)
        end
    end
end
--endregion

local ConfigModule = AngrierWorldQuests:NewModule("ConfigModule")
local DBModule = AngrierWorldQuests:GetModule("DBModule")


--region Variables

local filtersConversion = {
    EMISSARY = 1,
    ARTIFACT_POWER = 2,
    LOOT = 3,
    ORDER_RESOURCES = 4,
    GOLD = 5,
    ITEMS = 6,
    TIME = 7,
    FACTION = 8,
    PVP = 9,
    PROFESSION = 10,
    PETBATTLE = 11,
    SORT = 12,
    TRACKED = 13,
    ZONE = 14,
    RARE = 15,
    DUNGEON = 16,
    WAR_SUPPLIES = 17,
    NETHERSHARD = 18,
    VEILED_ARGUNITE = 19,
    WAKENING_ESSENCE = 20,
    AZERITE = 21,
    WAR_RESOURCES = 22,
    ANIMA = 23,
    CONDUIT = 24
}

ConfigModule.SortOrder = {
    _AngrierWorldQuests.Enums.SortOrder.SORT_NAME,
    _AngrierWorldQuests.Enums.SortOrder.SORT_TIME,
    _AngrierWorldQuests.Enums.SortOrder.SORT_ZONE,
    _AngrierWorldQuests.Enums.SortOrder.SORT_FACTION,
    _AngrierWorldQuests.Enums.SortOrder.SORT_REWARDS
}

local optionPanel
local profilePanel
local callbacks = {}

--endregion

--region Configuration options

do
    local filterTable

    function ConfigModule:Get(key)
        local value = DBModule:GetValue(key)

        if value == "true" then
            return true
        elseif value == "false" then
            return false
        else
            return value
        end
    end

    function ConfigModule:Set(key, newValue, silent)
        DBModule:SetValue(key, newValue)

        if key == 'selectedFilters' then
            filterTable = nil
        end

        if callbacks[key] and not silent then
            for _, func in ipairs(callbacks[key]) do
                func(key, newValue)
            end
        end
    end

    function ConfigModule:RegisterCallback(key, func)
        if type(key) == "table" then
            for _, key2 in ipairs(key) do
                if callbacks[key2] then
                    table.insert(callbacks, func)
                else
                    callbacks[key2] = { func }
                end
            end
        else
            if callbacks[key] then
                table.insert(callbacks, func)
            else
                callbacks[key] = { func }
            end
        end
    end

    function ConfigModule:FilterKeyToMask(key)
        local index = filtersConversion[key]
        return 2^(index - 1)
    end

    function ConfigModule:HasFilters()
        return self:Get('selectedFilters') > 0
    end

    function ConfigModule:IsOnlyFilter(key)
        local value = self:Get('selectedFilters')
        local mask = self:FilterKeyToMask(key)

        return mask == value
    end

    function ConfigModule:GetFilter(key)
        local value = self:Get('selectedFilters')
        local mask = self:FilterKeyToMask(key)

        return bit.band(value, mask) == mask
    end

    function ConfigModule:GetFilterTable()
        if filterTable == nil then
            local value = self:Get('selectedFilters')
            filterTable = {}

            for key, i in pairs(filtersConversion) do
                local mask = 2^(i-1)

                if bit.band(value, mask) == mask then
                    filterTable[key] = true
                end
            end
        end

        return filterTable
    end

    function ConfigModule:GetFilterDisabled(key)
        local value = self:Get('disabledFilters')
        local mask = self:FilterKeyToMask(key)

        return bit.band(value, mask) == mask
    end

    function ConfigModule:SetFilter(key, newValue)
        local value = self:Get('selectedFilters')
        local mask = self:FilterKeyToMask(key)

        if newValue then
            value = bit.bor(value, mask)
        else
            value = bit.band(value, bit.bnot(mask))
        end

        self:Set('selectedFilters', value)
    end

    function ConfigModule:SetNoFilter()
        self:Set('selectedFilters', 0)
    end

    function ConfigModule:SetOnlyFilter(key)
        local mask = self:FilterKeyToMask(key)

        self:Set('selectedFilters', mask)
    end

    function ConfigModule:ToggleFilter(key)
        local value = self:Get('selectedFilters')
        local mask = self:FilterKeyToMask(key)
        local currentValue = bit.band(value, mask) == mask

        if not currentValue then
            value = bit.bor(value, mask)
        else
            value = bit.band(value, bit.bnot(mask))
        end

        self:Set('selectedFilters', value)

        return not currentValue
    end
end

--endregion

--region Configuration dialog

do
    local panelOriginalConfig = {}
    local panelInit, checkboxes, dropdowns, filterCheckboxes
    local lootUpgradeLevelValues = { -1, 0, 5, 10, 15, 20, 25, 30 }

    local DropDown_Index = 0

    local Panel_OnRefresh

    local function FilterCheckBox_Update(self)
        local value = ConfigModule:Get("disabledFilters")
        local mask = self.filterMask

        self:SetChecked( bit.band(value, mask) == 0 )
    end

    local function FilterCheckBox_OnClick(self)
        local key = "disabledFilters"

        if panelOriginalConfig[key] == nil then
            panelOriginalConfig[key] = ConfigModule:Get(key)
        end

        local value = ConfigModule:Get("disabledFilters")
        local mask = self.filterMask

        if self:GetChecked() then
            value = bit.band(value, bit.bnot(mask))
        else
            value = bit.bor(value, mask)
        end

        DBModule:SetValue("selectedFilters", nil)

        ConfigModule:Set(key, value)
    end

    local function CheckBox_Update(self)
        self:SetChecked(ConfigModule:Get(self.configKey))
    end

    local function CheckBox_OnClick(self)
        local key = self.configKey

        if panelOriginalConfig[key] == nil then
            panelOriginalConfig[key] = ConfigModule:Get(key)
        end

        if self:GetChecked() then
            ConfigModule:Set(key, "true")
        else
            ConfigModule:Set(key, "false")
        end
    end

    local function DropDown_OnClick(self, dropdown)
        local key = dropdown.configKey

        if panelOriginalConfig[key] == nil then
            panelOriginalConfig[key] = ConfigModule:Get(key)
        end

        ConfigModule:Set(key, self.value)

        AWQ_UIDropDownMenu_SetSelectedValue( dropdown, self.value )
    end

    local function DropDown_Initialize(self)
        local key = self.configKey
        local selectedValue = AWQ_UIDropDownMenu_GetSelectedValue(self)
        local info = AWQ_UIDropDownMenu_CreateInfo()
        info.func = DropDown_OnClick
        info.arg1 = self

        if key == 'timeFilterDuration' then
            for _, hours in ipairs(ConfigModule.Filters.TIME.values) do
                info.text = string.format(FORMATED_HOURS, hours)
                info.value = hours
                if ( selectedValue == info.value ) then
                    info.checked = 1
                else
                    info.checked = nil
                end
                AWQ_UIDropDownMenu_AddButton(info)
            end
        elseif key == 'sortMethod' then
            for _, index in ipairs(ConfigModule.SortOrder) do
                info.text = AWQL["config_sortMethod_"..index]
                info.value = index
                if ( selectedValue == info.value ) then
                    info.checked = 1
                else
                    info.checked = nil
                end
                AWQ_UIDropDownMenu_AddButton(info)
            end
        elseif key == 'lootUpgradesLevel' then
            for i, ilvl in ipairs(lootUpgradeLevelValues) do
                if AWQL["config_lootUpgradesLevelValue"..i] ~= ("config_lootUpgradesLevelValue"..i) then
                    info.text = AWQL["config_lootUpgradesLevelValue"..i]
                else
                    info.text = format(AWQL["config_lootUpgradesLevelValue"], ilvl)
                end
                info.value = ilvl
                if ( selectedValue == info.value ) then
                    info.checked = 1
                else
                    info.checked = nil
                end
                AWQ_UIDropDownMenu_AddButton(info)
            end
        end
    end

    local function DropDown_Create(self)
        DropDown_Index = DropDown_Index + 1
        local dropdown = CreateFrame("Frame", "AngrierWorldQuestsConfigDropDown"..DropDown_Index, self, AWQ_UIDropDownMenuTemplate)

        local label = dropdown:CreateFontString("AngrierWorldQuestsConfigDropLabel"..DropDown_Index, "BACKGROUND", "GameFontNormal")
        label:SetPoint("BOTTOMLEFT", dropdown, "TOPLEFT", 16, 3)
        dropdown.Label = label

        return dropdown
    end

    local function Panel_OnSave(self)
        wipe(panelOriginalConfig)
    end

    local function Panel_OnCancel(self)
        wipe(panelOriginalConfig)
    end

    local function Panel_OnDefaults(self)
        DBModule:Reset()

        for key, callbacks_key in pairs(callbacks) do
            for _, func in ipairs(callbacks_key) do
                func(key, DBModule:GetValue(key))
            end
        end

        wipe(panelOriginalConfig)
    end

    Panel_OnRefresh = function(self)
        if not panelInit then
            local footer = self:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
            footer:SetPoint('BOTTOMRIGHT', -16, 16)
            footer:SetText( AngrierWorldQuests.Version or "Dev" )

            local label = self:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
            label:SetPoint("TOPLEFT", 16, -16)
            label:SetJustifyH("LEFT")
            label:SetJustifyV("TOP")
            label:SetText( AngrierWorldQuests.Name )

            checkboxes = {}
            dropdowns = {}
            filterCheckboxes = {}

            local checkboxes_order = {
                 "showAtTop",
                 "onlyCurrentZone",
                 "showContinentPOI",
                 "hideFilteredPOI",
                 "hideUntrackedPOI",
                 "hideQuestList",
                 "showHoveredPOI",
                 "lootFilterUpgrades",
                 "colorWarbandBonus",
                 "enableTaintWorkarounds",
                 "enableDebugging"
            }

            for i,key in ipairs(checkboxes_order) do
                checkboxes[i] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
                checkboxes[i]:SetScript("OnClick", CheckBox_OnClick)
                checkboxes[i].configKey = key
                checkboxes[i].Text:SetText( AWQL["config_"..key] )
                if i == 1 then
                    checkboxes[i]:SetPoint("TOPLEFT", label, "BOTTOMLEFT", -2, -8)
                else
                    checkboxes[i]:SetPoint("TOPLEFT", checkboxes[i-1], "BOTTOMLEFT", 0, 0)
                end
            end

            local dropdowns_order = { "timeFilterDuration", "sortMethod", "lootUpgradesLevel" }

            for i, key in ipairs(dropdowns_order) do
                dropdowns[i] = DropDown_Create(self)
                dropdowns[i].Label:SetText( AWQL["config_"..key] )
                dropdowns[i].configKey = key
                if i == 1 then
                    dropdowns[i]:SetPoint("TOPLEFT", checkboxes[#checkboxes], "BOTTOMLEFT", -13, -24)
                else
                    dropdowns[i]:SetPoint("TOPLEFT", dropdowns[i-1], "BOTTOMLEFT", 0, -24)
                end
            end

            local label2 = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            label2:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 435, -5)
            label2:SetJustifyH("LEFT")
            label2:SetJustifyV("TOP")
            label2:SetText(AWQL["config_enabledFilters"])

            for i,key in ipairs(ConfigModule.FiltersOrder) do
                local filter = ConfigModule.Filters[key]
                filterCheckboxes[i] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
                filterCheckboxes[i]:SetScript("OnClick", FilterCheckBox_OnClick)
                filterCheckboxes[i].filterMask = ConfigModule:FilterKeyToMask(key)
                filterCheckboxes[i].Text:SetFontObject("GameFontHighlightSmall")
                filterCheckboxes[i].Text:SetPoint("LEFT", filterCheckboxes[i], "RIGHT", 0, 1)
                filterCheckboxes[i].Text:SetText( filter.name )

                if i == 1 then
                    filterCheckboxes[1]:SetPoint("TOPLEFT", label2, "BOTTOMLEFT", 0, -5)
                else
                    filterCheckboxes[i]:SetPoint("TOPLEFT", filterCheckboxes[i-1], "BOTTOMLEFT", 0, 4)
                end
            end

            panelInit = true
        end

        for _, check in ipairs(checkboxes) do
            CheckBox_Update(check)
        end

        for _, dropdown in ipairs(dropdowns) do
            AWQ_UIDropDownMenu_Initialize(dropdown, DropDown_Initialize)
            AWQ_UIDropDownMenu_SetSelectedValue(dropdown, ConfigModule:Get(dropdown.configKey))
        end

        for _, check in ipairs(filterCheckboxes) do
            FilterCheckBox_Update(check)
        end
    end

    function ConfigModule:CreatePanel()
        local panel = CreateFrame("FRAME")
        panel.OnCommit = Panel_OnSave
        panel.OnCancel = Panel_OnCancel
        panel.OnDefault  = Panel_OnDefaults
        panel.OnRefresh  = Panel_OnRefresh
        local category = Settings.RegisterCanvasLayoutCategory(panel, ANGRYWORLDQUEST_TITLE, ANGRYWORLDQUEST_TITLE)
        category.ID = ANGRYWORLDQUEST_TITLE
        Settings.RegisterAddOnCategory(category);

        return panel
    end

    function ConfigModule:CreateProfilePanel()
		local profileOptions = LibStub("AceDBOptions-3.0"):GetOptionsTable(DBModule.AceDB)
		LibStub("AceConfig-3.0"):RegisterOptionsTable("AWQ-Profiles", profileOptions)
        local profilePanel = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("AWQ-Profiles", "Profiles", ANGRYWORLDQUEST_TITLE)

        return profilePanel
    end
end

--endregion

--region Initialization

do
    function ConfigModule:InitializeSettings()
        if not DBModule:GetValue("saveFilters") then
            DBModule:SetValue("selectedFilters", nil)
            DBModule:SetValue("filterEmissary", nil)
            DBModule:SetValue("filterLoot", nil)
            DBModule:SetValue("filterFaction", nil)
            DBModule:SetValue("filterZone", nil)
            DBModule:SetValue("filterTime", nil)
        end
    end

    function ConfigModule:InitializeFilters()
        local lastFilter = DBModule:GetValue("__filters")
        local disabledFilters = DBModule:GetValue("disabledFilters") or 0

        local maxFilter = 0
        for key, index in pairs(filtersConversion) do
            if self.Filters[key] then
                local mask = 2^(index-1)

                if not lastFilter or index > lastFilter then
                    if self.Filters[key].default then
                        disabledFilters = bit.band(disabledFilters, bit.bnot(mask))
                    else
                        disabledFilters = bit.bor(disabledFilters, mask)
                    end
                end

                if index > maxFilter then
                    maxFilter = index
                end
            end
        end

        DBModule:SetValue("disabledFilters", disabledFilters)
        DBModule:SetValue("__filters", maxFilter)
    end

    function ConfigModule:OnInitialize()
        self.Filters = {}
        self.FiltersOrder = {}
    end

    function ConfigModule:OnEnable()
        self:InitializeSettings()
        self:InitializeFilters()

        optionPanel = self:CreatePanel()
        profilePanel = self:CreateProfilePanel()
    end
end

SLASH_ANGRIERWORLDQUESTS1 = "/awq"
SLASH_ANGRIERWORLDQUESTS2 = "/angrierworldquests"
function SlashCmdList.ANGRIERWORLDQUESTS(msg, editbox)
    Settings.OpenToCategory(ANGRYWORLDQUEST_TITLE)
end

--endregion

local DataModule = AngrierWorldQuests:NewModule("DataModule", "AceEvent-3.0")
local ConfigModule = AngrierWorldQuests:GetModule("ConfigModule")

local cachedItems = {}

do
    --region Maps and data

    --region Legion
    local CONTINENT_LEGION = 619 -- Broken Isles main map
    local CONTINENT_LEGION_ARGUS = 905
    local FACTION_ORDER_LEGION = {
        1900, -- Court of Farondis
        1883, -- Dreamweavers
        1828, -- Highmountain Tribe
        1948, -- Valarjar
        1894, -- The Wardens
        1859, -- The Nightfallen
        1090, -- Kirin Tor
        2045, -- Armies of Legionfall
        2165, -- Army of the Light
        2170, -- Argussian Reach
    }
    local FILTERS_LEGION = { "ORDER_RESOURCES", "WAKENING_ESSENCE" }
    local MAPS_LEGION = {
        [627] = true, -- Dalaran
        [630] = true, -- Azsuna
        [634] = true, -- Stormheim
        [641] = true, -- Val'sharah
        [646] = true, -- Broken Shore
        [650] = true, -- Highmountain
        [680] = true, -- Suramar
        [790] = true, -- Eye of Azshara
        [830] = true, -- Krokuun
        [882] = true, -- Eredath
        [885] = true, -- Antoran Wastes
        [905] = true, -- Argus
    }
    local MAPS_LEGION_ARGUS = {
        [830] = true, -- Krokuun
        [882] = true, -- Eredath
        [885] = true, -- Antoran Wastes
    }
    --endregion

    --region Battle for Azeroth
    local CONTINENT_BFA_HORDE = 875    -- Zandalar
    local CONTINENT_BFA_ALLIANCE = 876 -- Kul Tiras
    local FACTION_ORDER_BFA_ALLIANCE = {
        2159, -- 7th Legion
        2164, -- Champions of Azeroth
        2160, -- Proudmoore Admiralty
        2161, -- Order of Embers
        2162, -- Storm's Wake
        2163, -- Tortollan Seekers
    }
    local FACTION_ORDER_BFA_HORDE = {
        2157, -- The Honorbound
        2164, -- Champions of Azeroth
        2156, -- Talanji's Expedition
        2158, -- Voldunai
        2103, -- Zandalari Empire
        2163, -- Tortollan Seekers
    }
    local FILTERS_BFA = { "AZERITE", "WAR_RESOURCES" }
    local MAPS_BFA_ALLIANCE = {
        [895] = true,  -- Tiragarde Sound
        [896] = true,  -- Drustvar
        [942] = true,  -- Stormsong Valley
        [1355] = true, -- Nazjatar
        [1462] = true, -- Mechagon
    }
    local MAPS_BFA_HORDE = {
        [862] = true,  -- Zuldazar
        [863] = true,  -- Nazmir
        [864] = true,  -- Vol'dun
        [1355] = true, -- Nazjatar
    }
    --endregion

    --region Shadowlands
    local CONTINENT_SHADOWLANDS = 1550 -- Shadowlands main map
    local FACTION_ORDER_SHADOWLANDS = {
        2413, -- Court of Harvesters
        2407, -- The Ascended
        2410, -- The Undying Army
        2465, -- The Wild Hunt
    }
    local FILTERS_SHADOWLANDS = { "ANIMA", "CONDUIT" }
    local MAPS_SHADOWLANDS = {
        [1543] = true, -- The Maw
        [1536] = true, -- Maldraxxus
        [1525] = true, -- Revendreth
        [1533] = true, -- Bastion
        [1565] = true, -- Ardenweald
    }
    --endregion

    --region Dragonflight
    local CONTINENT_DRAGONFLIGHT = 1978 -- Dragonflight main map
    local FACTION_ORDER_DRAGONFLIGHT = {
        2507, -- Dragonscale Expedition
        2503, -- Maruuk Centaur
        2511, -- Iskaara Tuskarr
        2510, -- Valdrakken Accord
        2518, -- Sabellian
        2517, -- Wrathion
        2523, -- Dark Talons
        2564, -- Loamm Niffen
        2574, -- Dream Wardens
        2615, -- Azerothian Archives
    }
    local MAPS_DRAGONFLIGHT = {
        [2022] = true, -- The Waking Shore
        [2023] = true, -- Ohn'ahran Plains
        [2024] = true, -- Azure Span
        [2025] = true, -- Thaldrazus
        [2112] = true, -- Valdrakken
        [2133] = true, -- Zaralek Cavern
        [2151] = true, -- The Forbidden Reach
        [2200] = true, -- Emerald Dream
    }
    --endregion

    --region The War Within
    local CONTINENT_THE_WAR_WITHIN = 2274 -- Khaz Algar main map
    local FACTION_ORDER_THE_WAR_WITHIN = {
        2570, -- Hallowfall Arathi
        2590, -- Council of Dornogal
        2594, -- The Assembly of the Deeps
        2600, -- The Severed Threads
    }
    local MAPS_THE_WAR_WITHIN = {
        [2214] = true, -- The Ringing Deeps
        [2215] = true, -- Hallowfall
        [2248] = true, -- Isle of Dorn
        [2255] = true, -- Azj-Kahet
    }
    --endregion

    --endregion

    function DataModule:GetExpansionByMapID(mapID)
        if MAPS_LEGION[mapID] or mapID == CONTINENT_LEGION then
            return _AngrierWorldQuests.Enums.Expansion.LEGION
        elseif MAPS_BFA_ALLIANCE[mapID] or MAPS_BFA_HORDE[mapID] or mapID == CONTINENT_BFA_ALLIANCE or mapID == CONTINENT_BFA_HORDE then
            return _AngrierWorldQuests.Enums.Expansion.BFA
        elseif MAPS_SHADOWLANDS[mapID] or mapID == CONTINENT_SHADOWLANDS then
            return _AngrierWorldQuests.Enums.Expansion.SHADOWLANDS
        elseif MAPS_DRAGONFLIGHT[mapID] or mapID == CONTINENT_DRAGONFLIGHT then
            return _AngrierWorldQuests.Enums.Expansion.DRAGONFLIGHTS
        elseif MAPS_THE_WAR_WITHIN[mapID] or mapID == CONTINENT_THE_WAR_WITHIN then
            return _AngrierWorldQuests.Enums.Expansion.THE_WAR_WITHIN
        else
            return nil
        end
    end

    function DataModule:GetFactionsByMapID(mapID)
        local expansion = DataModule:GetExpansionByMapID(mapID)

        if expansion == _AngrierWorldQuests.Enums.Expansion.LEGION then
            return FACTION_ORDER_LEGION
        elseif expansion == _AngrierWorldQuests.Enums.Expansion.BFA then
            if UnitFactionGroup("player") == "Alliance" then
                return FACTION_ORDER_BFA_ALLIANCE
            else
                return FACTION_ORDER_BFA_HORDE
            end
        elseif expansion == _AngrierWorldQuests.Enums.Expansion.SHADOWLANDS then
            return FACTION_ORDER_SHADOWLANDS
        elseif expansion == _AngrierWorldQuests.Enums.Expansion.DRAGONFLIGHTS then
            return FACTION_ORDER_DRAGONFLIGHT
        elseif expansion == _AngrierWorldQuests.Enums.Expansion.THE_WAR_WITHIN then
            return FACTION_ORDER_THE_WAR_WITHIN
        else
            return nil
        end
    end

    function DataModule:GetMapIDsToGetQuestsFrom(mapID)
        local expansion = DataModule:GetExpansionByMapID(mapID)

        if ConfigModule:Get("onlyCurrentZone") then
            if expansion == _AngrierWorldQuests.Enums.Expansion.LEGION then
                if mapID == CONTINENT_LEGION then
                    return MAPS_LEGION
                end

                if mapID == CONTINENT_LEGION_ARGUS then
                    return MAPS_LEGION_ARGUS
                end
            elseif expansion == _AngrierWorldQuests.Enums.Expansion.BFA then
                if mapID == CONTINENT_BFA_ALLIANCE then
                    return MAPS_BFA_ALLIANCE
                end

                if mapID == CONTINENT_BFA_HORDE then
                    return MAPS_BFA_HORDE
                end
            elseif expansion == _AngrierWorldQuests.Enums.Expansion.SHADOWLANDS and mapID == CONTINENT_SHADOWLANDS then
                return MAPS_SHADOWLANDS
            elseif expansion == _AngrierWorldQuests.Enums.Expansion.DRAGONFLIGHTS and mapID == CONTINENT_DRAGONFLIGHT then
                return MAPS_DRAGONFLIGHT
            elseif expansion == _AngrierWorldQuests.Enums.Expansion.THE_WAR_WITHIN and mapID == CONTINENT_THE_WAR_WITHIN then
                return MAPS_THE_WAR_WITHIN
            end
        else
            if expansion == _AngrierWorldQuests.Enums.Expansion.LEGION then
                if MAPS_LEGION_ARGUS[mapID] then
                    return MAPS_LEGION_ARGUS
                elseif MAPS_LEGION[mapID] then
                    return MAPS_LEGION
                end
            elseif expansion == _AngrierWorldQuests.Enums.Expansion.BFA then
                if MAPS_BFA_ALLIANCE[mapID] then
                    return MAPS_BFA_ALLIANCE
                elseif MAPS_BFA_HORDE[mapID] then
                    return MAPS_BFA_HORDE
                end
            elseif expansion == _AngrierWorldQuests.Enums.Expansion.SHADOWLANDS then
                return MAPS_SHADOWLANDS
            elseif expansion == _AngrierWorldQuests.Enums.Expansion.DRAGONFLIGHTS then
                return MAPS_DRAGONFLIGHT
            elseif expansion == _AngrierWorldQuests.Enums.Expansion.THE_WAR_WITHIN then
                return MAPS_THE_WAR_WITHIN
            end
        end

        return { [mapID] = true }
    end

    local continentMapID = {}

    function DataModule:GetContentMapIDFromMapID(mapID)
        if continentMapID[mapID] == nil then
            local continentInfo = MapUtil.GetMapParentInfo(mapID, Enum.UIMapType.Continent)

            if continentInfo then
                continentMapID[mapID] = continentInfo.mapID
            end
        end

        return continentMapID[mapID]
    end

    function DataModule:IsFilterOnCorrectMap(filter, mapID)
        local expansion = DataModule:GetExpansionByMapID(mapID)

        if expansion == _AngrierWorldQuests.Enums.Expansion.LEGION and has_value(FILTERS_LEGION, filter) then
            return true
        elseif expansion == _AngrierWorldQuests.Enums.Expansion.BFA and has_value(FILTERS_BFA, filter) then
            return true
        elseif expansion == _AngrierWorldQuests.Enums.Expansion.SHADOWLANDS and has_value(FILTERS_SHADOWLANDS, filter) then
            return true
        end

        -- If the filter being checked is in none of the lists, it is correct for the current map.
        return not has_value(FILTERS_LEGION, filter)
               and not has_value(FILTERS_BFA, filter)
               and not has_value(FILTERS_SHADOWLANDS, filter)
    end

    function DataModule:IsQuestRewardFiltered(selectedFilters, questID)
        local positiveMatch = false
        local hasCurrencyFilter = false

        local money = GetQuestLogRewardMoney(questID)
        if money > 0 and selectedFilters["GOLD"] then
            positiveMatch = true
        end

        for key, _ in pairs(selectedFilters) do
            local filter = ConfigModule.Filters[key]
            if filter.preset == _AngrierWorldQuests.Constants.FILTERS.CURRENCY then
                hasCurrencyFilter = true
                for k, currencyInfo in ipairs(C_QuestLog.GetQuestRewardCurrencies(questID)) do
                    if filter.currencyID == currencyInfo.currencyID then
                        positiveMatch = true
                    end
                end
            end
        end

        local numQuestRewards = GetNumQuestLogRewards(questID)
        if numQuestRewards > 0 then
            local itemName, itemTexture, _, _, _, itemID = GetQuestLogRewardInfo(1, questID)
            if itemName and itemTexture then
                local iLevel = self:RewardItemLevel(itemID, questID)
                if C_Item.IsAnimaItemByID(itemID) then
                    if selectedFilters.ANIMA then
                        positiveMatch = true
                    end
                else
                    if iLevel then
                        local isConduit = C_Soulbinds.IsItemConduitByItemInfo(itemID)
                        local filterLoot = ConfigModule:Get("filterLoot")
                        local lootFilterUpgrades = ConfigModule:Get("lootFilterUpgrades")
                        local upgradesOnly = filterLoot == _AngrierWorldQuests.Constants.FILTERS.LOOT_UPGRADES or
                            (filterLoot == 0 and lootFilterUpgrades)
                        if selectedFilters.CONDUIT and isConduit or selectedFilters.LOOT and (not upgradesOnly or self:RewardIsUpgrade(itemID, questID)) and not isConduit then
                            positiveMatch = true
                        end
                    else
                        if selectedFilters.ITEMS then
                            positiveMatch = true
                        end
                    end
                end
            end
        end

        if positiveMatch then
            return false
        elseif hasCurrencyFilter or selectedFilters.ANIMA or selectedFilters.LOOT or selectedFilters.ITEMS then
            return true
        end
    end

    function DataModule:IsQuestFiltered(info, displayMapID)
        local hasFilters = ConfigModule:HasFilters()
        local selectedFilters = ConfigModule:GetFilterTable()

        local _, factionID = C_TaskQuest.GetQuestInfoByQuestID(info.questID)
        local questTagInfo = C_QuestLog.GetQuestTagInfo(info.questID)

        if not questTagInfo then
            return -- fix for nil tag
        end

        local tradeskillLineID = questTagInfo.tradeskillLineID
        local timeLeftMinutes = C_TaskQuest.GetQuestTimeLeftMinutes(info.questID)
        C_TaskQuest.RequestPreloadRewardData(info.questID)

        local isQuestFiltered = hasFilters

        if hasFilters then
            local lootFiltered = self:IsQuestRewardFiltered(selectedFilters, info.questID)
            if lootFiltered ~= nil then
                isQuestFiltered = lootFiltered
            end

            if selectedFilters.FACTION then
                local filterFaction = ConfigModule:Get("filterFaction")

                if (factionID == filterFaction) then
                    isQuestFiltered = false
                end
            end

            if selectedFilters.TIME then
                local filterTime = ConfigModule:Get("filterTime")
                local timeFilterDuration = ConfigModule:Get("timeFilterDuration")
                local hours = filterTime ~= 0 and filterTime or timeFilterDuration

                if timeLeftMinutes and (timeLeftMinutes - WORLD_QUESTS_TIME_CRITICAL_MINUTES) <= (hours * 60) then
                    isQuestFiltered = false
                end
            end

            if selectedFilters.PVP then
                if questTagInfo.worldQuestType == Enum.QuestTagType.PvP then
                    isQuestFiltered = false
                end
            end

            if selectedFilters.PETBATTLE then
                if questTagInfo.worldQuestType == Enum.QuestTagType.PetBattle then
                    isQuestFiltered = false
                end
            end

            if selectedFilters.PROFESSION then
                if tradeskillLineID and WORLD_QUEST_ICONS_BY_PROFESSION[tradeskillLineID] then
                    isQuestFiltered = false
                end
            end

            if selectedFilters.TRACKED then
                if C_QuestLog.GetQuestWatchType(info.questID) == Enum.QuestWatchType.Manual or C_SuperTrack.GetSuperTrackedQuestID() == info.questID then
                    isQuestFiltered = false
                end
            end

            if selectedFilters.RARE then
                if questTagInfo.quality ~= Enum.WorldQuestQuality.Common then
                    isQuestFiltered = false
                end
            end

            if selectedFilters.DUNGEON then
                if questTagInfo.worldQuestType == Enum.QuestTagType.Dungeon or questTagInfo.worldQuestType == Enum.QuestTagType.Raid then
                    isQuestFiltered = false
                end
            end

            if selectedFilters.ZONE then
                local currentMapID = QuestMapFrame:GetParent():GetMapID()
                local filterMapID = ConfigModule:Get("filterZone")

                if filterMapID ~= 0 then
                    if info.mapID and info.mapID == filterMapID then
                        isQuestFiltered = false
                    end
                else
                    if info.mapID and info.mapID == currentMapID then
                        isQuestFiltered = false
                    end
                end
            end

            if selectedFilters.EMISSARY then
                local mapID = QuestMapFrame:GetParent():GetMapID()

                if mapID == _AngrierWorldQuests.Constants.MAP_IDS.BROKENISLES then
                    mapID = _AngrierWorldQuests.Constants.MAP_IDS.DALARAN -- fix no emissary on broken isles continent map
                end

                local bounties = C_QuestLog.GetBountiesForMapID(mapID)

                if bounties then
                    local bountyFilter = ConfigModule:Get("filterEmissary")
                    if not C_QuestLog.IsOnQuest(bountyFilter) or C_QuestLog.IsComplete(bountyFilter) then
                        bountyFilter = 0 -- show all bounties
                    end

                    for _, bounty in ipairs(bounties) do
                        if bounty and not C_QuestLog.IsComplete(bounty.questID) and C_QuestLog.IsQuestCriteriaForBounty(info.questID, bounty.questID) and (bountyFilter == 0 or bountyFilter == bounty.questID) then
                            isQuestFiltered = false
                        end
                    end
                end
            end

            -- don't filter quests if not in the right map
            for key in pairs(selectedFilters) do
                local rightMap = self:IsFilterOnCorrectMap(key, displayMapID)

                if not rightMap then
                    isQuestFiltered = false
                end
            end
        end

        if ConfigModule:Get("onlyCurrentZone") and info.mapID ~= displayMapID and displayMapID ~= _AngrierWorldQuests.Constants.MAP_IDS.AZEROTH then
            -- Needed since C_TaskQuest.GetQuestsForPlayerByMapID returns quests not on the passed map.....
            -- But, if we are on a continent (the quest continent map id matches the currently shown map)
            -- we should not be changing anything, since quests should be shown here.
            if (self:GetContentMapIDFromMapID(info.mapID) ~= displayMapID) then
                isQuestFiltered = true
            end
        end

        return isQuestFiltered
    end
end

do
    local invtype_locations = {
        INVTYPE_HEAD = { INVSLOT_HEAD },
        INVTYPE_NECK = { INVSLOT_NECK },
        INVTYPE_SHOULDER = { INVSLOT_SHOULDER },
        INVTYPE_BODY = { INVSLOT_BODY },
        INVTYPE_CHEST = { INVSLOT_CHEST },
        INVTYPE_ROBE = { INVSLOT_CHEST },
        INVTYPE_WAIST = { INVSLOT_WAIST },
        INVTYPE_LEGS = { INVSLOT_LEGS },
        INVTYPE_FEET = { INVSLOT_FEET },
        INVTYPE_WRIST = { INVSLOT_WRIST },
        INVTYPE_HAND = { INVSLOT_HAND },
        INVTYPE_FINGER = { INVSLOT_FINGER1, INVSLOT_FINGER2 },
        INVTYPE_TRINKET = { INVSLOT_TRINKET1, INVSLOT_TRINKET2 },
        INVTYPE_CLOAK = { INVSLOT_BACK },
        INVTYPE_WEAPON = { INVSLOT_MAINHAND, INVSLOT_OFFHAND },
        INVTYPE_SHIELD = { INVSLOT_OFFHAND },
        INVTYPE_2HWEAPON = { INVSLOT_MAINHAND },
        INVTYPE_WEAPONMAINHAND = { INVSLOT_MAINHAND },
        INVTYPE_WEAPONOFFHAND = { INVSLOT_OFFHAND },
        INVTYPE_HOLDABLE = { INVSLOT_OFFHAND },
    }

    function DataModule:RewardIsUpgrade(itemID, questID)
        local equipSlot = select(4, C_Item.GetItemInfoInstant(itemID))
        local ilvl = self:RewardItemLevel(itemID, questID)

        if equipSlot and invtype_locations[equipSlot] then
            local lootUpgradesLevel = ConfigModule:Get("lootUpgradesLevel")

            for _, slotID in ipairs(invtype_locations[equipSlot]) do
                local currentItem = ItemLocation:CreateFromEquipmentSlot(slotID)

                if currentItem:IsValid() then
                    local currentIlvl = C_Item.GetCurrentItemLevel(currentItem)

                    if not currentIlvl or ilvl >= (currentIlvl - lootUpgradesLevel) then
                        return true
                    end
                else
                    return true
                end
            end

            return false
        else
            return true
        end
    end

    function DataModule:RewardItemLevel(itemID, questID)
        local key = itemID .. ":" .. questID

        if cachedItems[key] == nil then
            local invType = C_Item.GetItemInventoryTypeByID(itemID)
            local _, _, _, _, _, itemClassID, itemSubClassID = C_Item.GetItemInfoInstant(itemID)

            if invType == Enum.InventoryType.IndexNonEquipType and (itemClassID ~= Enum.ItemClass.Gem or itemSubClassID ~= Enum.ItemGemSubclass.Artifactrelic) then
                cachedItems[key] = false
                return false
            end

            local itemLink = GetQuestLogItemLink("reward", 1, questID)
            cachedItems[key] = C_Item.GetDetailedItemLevelInfo(itemLink)
        end
        return cachedItems[key]
    end
end

--region Initialization
do
    function DataModule:QuestLogChanged(arg1)
        if arg1 == "player" then
            wipe(cachedItems)
        end
    end

    function DataModule:EnteringWorld()
        wipe(cachedItems)
    end

    function DataModule:RegisterEventHandlers()
        self:RegisterEvent("UNIT_QUEST_LOG_CHANGED", "QuestLogChanged")
        self:RegisterEvent("PLAYER_ENTERING_WORLD", "EnteringWorld")
    end

    function DataModule:OnInitialize()
        self:RegisterEventHandlers()
    end
end
--endregion
local WorkaroundsModule = AngrierWorldQuests:NewModule("WorkaroundsModule")

local function WorkaroundMapTaints()
    -- Code copied from hack from Kalies Tracker, which is based on the original Blizzard_MapCanvas.lua code.
    local function OnPinReleased(pinPool, pin)
        Pool_HideAndClearAnchors(pinPool, pin);
        pin:OnReleased();
        pin.pinTemplate = nil;
        pin.owningMap = nil;
    end

    local function OnPinMouseUp(pin, button, upInside)
        pin:OnMouseUp(button, upInside);
        if upInside then
            pin:OnClick(button);
        end
    end

    function WorldMapFrame:AcquirePin(pinTemplate, ...)
        if not self.pinPools[pinTemplate] then
            local pinTemplateType = self.pinTemplateTypes[pinTemplate] or "FRAME";
            self.pinPools[pinTemplate] = CreateFramePool(pinTemplateType, self:GetCanvas(), pinTemplate, OnPinReleased);
        end

        local pin, newPin = self.pinPools[pinTemplate]:Acquire();

        pin.pinTemplate = pinTemplate;
        pin.owningMap = self;

        if newPin then
            local isMouseClickEnabled = pin:IsMouseClickEnabled();
            local isMouseMotionEnabled = pin:IsMouseMotionEnabled();

            if isMouseClickEnabled then
                pin:SetScript("OnMouseUp", OnPinMouseUp);
                pin:SetScript("OnMouseDown", pin.OnMouseDown);

                -- Prevent OnClick handlers from being run twice, once a frame is in the mapCanvas ecosystem it needs
                -- to process mouse events only via the map system.
                if pin:IsObjectType("Button") then
                    pin:SetScript("OnClick", nil);
                end
            end

            if isMouseMotionEnabled then
                if newPin and not pin:DisableInheritedMotionScriptsWarning() then
                    -- These will never be called, just define a OnMouseEnter and OnMouseLeave on the pin mixin and it'll be called when appropriate
                    assert(pin:GetScript("OnEnter") == nil);
                    assert(pin:GetScript("OnLeave") == nil);
                end
                pin:SetScript("OnEnter", pin.OnMouseEnter);
                pin:SetScript("OnLeave", pin.OnMouseLeave);
            end

            pin:SetMouseClickEnabled(isMouseClickEnabled);
            pin:SetMouseMotionEnabled(isMouseMotionEnabled);
        end

        if newPin then
            pin:OnLoad();
            pin.CheckMouseButtonPassthrough = function() end
            pin.UpdateMousePropagation = function() end
        end

        self.ScrollContainer:MarkCanvasDirty();
        pin:Show();
        pin:OnAcquired(...);

        return pin;
    end
end

local function WorkaroundQuestTrackingTaints()
    local lastTrackedQuestID = nil;

    function QuestUtil.TrackWorldQuest(questID, watchType)
        if C_QuestLog.AddWorldQuestWatch(questID, watchType) then
            if lastTrackedQuestID and lastTrackedQuestID ~= questID then
                if C_QuestLog.GetQuestWatchType(lastTrackedQuestID) ~= Enum.QuestWatchType.Manual and watchType == Enum.QuestWatchType.Manual then
                    C_QuestLog.AddWorldQuestWatch(lastTrackedQuestID, Enum.QuestWatchType.Manual); -- Promote to manual watch
                end
            end
            lastTrackedQuestID = questID;
        end

        if watchType == Enum.QuestWatchType.Automatic then
            local forceAllowTasks = true;
            QuestUtil.CheckAutoSuperTrackQuest(questID, forceAllowTasks);
        end
    end

    function QuestUtil.UntrackWorldQuest(questID)
        if C_QuestLog.RemoveWorldQuestWatch(questID) then
            if lastTrackedQuestID == questID then
                lastTrackedQuestID = nil;
            end
        end

        --ObjectiveTrackerManager:UpdateAll();
    end
end

function WorkaroundsModule:LoadWorkarounds(callback)
    if ConfigModule:Get("enableTaintWorkarounds") then
        WorkaroundMapTaints()
        WorkaroundQuestTrackingTaints()
    end

    if callback then
        ReloadUI()
    end
end

function WorkaroundsModule:RegisterCallbacks()
    ConfigModule:RegisterCallback("enableTaintWorkarounds", function()
        self:LoadWorkarounds(true)
    end)
end

function WorkaroundsModule:OnEnable()
    self:RegisterCallbacks()

    self:LoadWorkarounds(false)
end

local QuestFrameModule = AngrierWorldQuests:NewModule("QuestFrameModule")
local ConfigModule = AngrierWorldQuests:GetModule("ConfigModule")
local DataModule = AngrierWorldQuests:GetModule("DataModule")

--region Variables

local dataProvider
local hoveredQuestID
local titleFramePool

--endregion

--region QuestLog
do
    local REWARDS_ORDER = {
        ARTIFACT_POWER = 1,
        LOOT = 2,
        CURRENCY = 3,
        GOLD = 4,
        ITEMS = 5
    }

    local headerButton
    local filterMenu
    local filterButtons = {}

    local QuestButton_RarityColorTable = { [Enum.WorldQuestQuality.Common] = 0, [Enum.WorldQuestQuality.Rare] = 3, [Enum.WorldQuestQuality.Epic] = 10 }

    local MAPID_ARGUS = 905
    local ANIMA_ITEM_COLOR = { r=.6, g=.8, b=1 }
    local ANIMA_SPELLID = {[347555] = 3, [345706] = 5, [336327] = 35, [336456] = 250}

    local function FilterMenu_OnClick(self, key)
        if key == "EMISSARY" then
            ConfigModule:Set("filterEmissary", self.value, true)
        elseif key == "LOOT" then
            ConfigModule:Set("filterLoot", self.value, true)
        elseif key == "FACTION" then
            ConfigModule:Set("filterFaction", self.value, true)
        elseif key == "ZONE" then
            ConfigModule:Set("filterZone", self.value, true)
        elseif key == "TIME" then
            ConfigModule:Set("filterTime", self.value, true)
        end

        if key == "SORT" then
            ConfigModule:Set("sortMethod", self.value)
        elseif IsShiftKeyDown() then
            ConfigModule:SetFilter(key, true)
        else
            ConfigModule:SetOnlyFilter(key)
        end
    end

    local function FilterMenu_Initialize(self, level)
        local info = { func = FilterMenu_OnClick, arg1 = self.filter }
        if self.filter == "EMISSARY" then
            local value = ConfigModule:Get("filterEmissary")
            if not C_QuestLog.IsOnQuest(value) then value = 0 end -- specific bounty not found, show all

            info.text = ALL
            info.value = 0
            info.checked = info.value == value
            AWQ_UIDropDownMenu_AddButton(info, level)

            local mapID = QuestMapFrame:GetParent():GetMapID()
            if mapID == _AngrierWorldQuests.Constants.MAP_IDS.BROKENISLES then mapID = _AngrierWorldQuests.Constants.MAP_IDS.DALARAN end -- fix no emissary on broken isles continent map
            local bounties = C_QuestLog.GetBountiesForMapID(mapID)
            if bounties then
                for _, bounty in ipairs(bounties) do
                    if not C_QuestLog.IsComplete(bounty.questID) then
                        info.text =  C_QuestLog.GetTitleForQuestID(bounty.questID)
                        info.icon = bounty.icon
                        info.value = bounty.questID
                        info.checked = info.value == value
                        AWQ_UIDropDownMenu_AddButton(info, level)
                    end
                end
            end
        elseif self.filter == "LOOT" then
            local value = ConfigModule:Get("filterLoot")
            if value == 0 then value = ConfigModule:Get("lootFilterUpgrades") and _AngrierWorldQuests.Constants.FILTERS.LOOT_UPGRADES or _AngrierWorldQuests.Constants.FILTERS.LOOT_ALL end

            info.text = ALL
            info.value = _AngrierWorldQuests.Constants.FILTERS.LOOT_ALL
            info.checked = info.value == value
            AWQ_UIDropDownMenu_AddButton(info, level)

            info.text = AWQL["UPGRADES"]
            info.value = _AngrierWorldQuests.Constants.FILTERS.LOOT_UPGRADES
            info.checked = info.value == value
            AWQ_UIDropDownMenu_AddButton(info, level)
        elseif self.filter == "ZONE" then
            local value = ConfigModule:Get("filterZone")

            info.text = AWQL["CURRENT_ZONE"]
            info.value = 0
            info.checked = info.value == value
            AWQ_UIDropDownMenu_AddButton(info, level)
        elseif self.filter == "FACTION" then
            local value = ConfigModule:Get("filterFaction")

            local mapID = QuestMapFrame:GetParent():GetMapID()
            local factions = DataModule:GetFactionsByMapID(mapID)

            for _, factionID in ipairs(factions) do
                local factionData = C_Reputation.GetFactionDataByID(factionID)
                info.text = factionData.name
                info.value = factionID
                info.checked = info.value == value
                AWQ_UIDropDownMenu_AddButton(info, level)
            end
        elseif self.filter == "TIME" then
            local filterTime = ConfigModule:Get("filterTime")
            local timeFilterDuration = ConfigModule:Get("timeFilterDuration")
            local value = filterTime ~= 0 and filterTime or timeFilterDuration

            for _, hours in ipairs(ConfigModule.Filters.TIME.values) do
                info.text = string.format(FORMATED_HOURS, hours)
                info.value = hours
                info.checked = info.value == value
                AWQ_UIDropDownMenu_AddButton(info, level)
            end
        elseif self.filter == "SORT" then
            local value = ConfigModule:Get("sortMethod")

            info.text = ConfigModule.Filters[ self.filter ].name
            info.notCheckable = true
            info.isTitle = true
            AWQ_UIDropDownMenu_AddButton(info, level)

            info.notCheckable = false
            info.isTitle = false
            info.disabled = false
            for _, sortIndex in ipairs(ConfigModule.SortOrder) do
                info.text =  AWQL["config_sortMethod_"..sortIndex]
                info.value = sortIndex
                info.checked = info.value == value
                AWQ_UIDropDownMenu_AddButton(info, level)
            end
        end
    end

    local function FilterButton_OnEnter(self)
        local text = ConfigModule.Filters[ self.filter ].name

        local filterEmissary = ConfigModule:Get("filterEmissary")
        if self.filter == "EMISSARY" and filterEmissary and not C_QuestLog.IsComplete(filterEmissary) then
            local title = C_QuestLog.GetTitleForQuestID(filterEmissary)
            if title then text = text..": "..title end
        end

        local filterLoot = ConfigModule:Get("filterLoot")
        local lootFilterUpgrades = ConfigModule:Get("lootFilterUpgrades")
        if self.filter == "LOOT" then
            if filterLoot == _AngrierWorldQuests.Constants.FILTERS.LOOT_UPGRADES or (filterLoot == 0 and lootFilterUpgrades) then
                text = string.format("%s (%s)", text, AWQL["UPGRADES"])
            end
        end

        local filterFaction = ConfigModule:Get("filterFaction")
        if self.filter == "FACTION" and filterFaction ~= 0 then
            local factionData = C_Reputation.GetFactionDataByID(filterFaction)
            local title = factionData and factionData.name

            if title then
                text = text..": "..title
            end
        end

        local sortMethod = ConfigModule:Get("sortMethod")
        if self.filter == "SORT" then
            local title = AWQL["config_sortMethod_"..sortMethod]
            if title then text = text..": "..title end
        end

        local filterZone = ConfigModule:Get("filterZone")
        if self.filter == "ZONE" and filterZone ~= 0 then
            local mapInfo = C_Map.GetMapInfo(filterZone)
            local title = mapInfo and mapInfo.name
            if title then text = text..": "..title end
        end

        local filterTime = ConfigModule:Get("filterTime")
        local timeFilterDuration = ConfigModule:Get("timeFilterDuration")
        if self.filter == "TIME" then
            local hours = filterTime ~= 0 and filterTime or timeFilterDuration
            text = string.format(BLACK_MARKET_HOT_ITEM_TIME_LEFT, string.format(FORMATED_HOURS, hours))
        end

        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(text)
        GameTooltip:Show()
    end

    local function FilterButton_OnLeave(self)
        GameTooltip:Hide()
    end

    local function FilterButton_ShowMenu(self)
        if not filterMenu then
            filterMenu = CreateFrame("Button", "DropDownMenuAWQ", QuestMapFrame, AWQ_UIDropDownMenuTemplate)
        end

        filterMenu.filter = self.filter
        AWQ_UIDropDownMenu_Initialize(filterMenu, FilterMenu_Initialize, "MENU")
        AWQ_ToggleDropDownMenu(1, nil, filterMenu, self, 0, 0)
    end

    local function FilterButton_OnClick(self, button)
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
        if (button == "RightButton" and (self.filter == "EMISSARY" or self.filter == "LOOT" or self.filter == "FACTION" or self.filter == "TIME"))
                or (self.filter == "SORT")
                or (self.filter == "FACTION" and not ConfigModule:GetFilter("FACTION")) then

            local MY_UIDROPDOWNMENU_OPEN_MENU = Lib_UIDropDownMenu_Initialize and LIB_UIDROPDOWNMENU_OPEN_MENU or UIDROPDOWNMENU_OPEN_MENU

            if filterMenu and MY_UIDROPDOWNMENU_OPEN_MENU == filterMenu and AWQ_DropDownList1:IsShown() and filterMenu.filter == self.filter then
                AWQ_HideDropDownMenu(1)
            else
                AWQ_HideDropDownMenu(1)
                FilterButton_ShowMenu(self)
            end
        else
            AWQ_HideDropDownMenu(1)
            if IsShiftKeyDown() then
                if self.filter == "EMISSARY" then ConfigModule:Set("filterEmissary", 0, true) end
                if self.filter == "LOOT" then ConfigModule:Set("filterLoot", 0, true) end
                ConfigModule:ToggleFilter(self.filter)
            else
                if ConfigModule:IsOnlyFilter(self.filter) then
                    ConfigModule:Set("filterFaction", 0, true)
                    ConfigModule:Set("filterEmissary", 0, true)
                    ConfigModule:Set("filterLoot", 0, true)
                    ConfigModule:Set("filterZone", 0, true)
                    ConfigModule:Set("filterTime", 0, true)
                    ConfigModule:SetNoFilter()
                else
                    if self.filter ~= "FACTION" then ConfigModule:Set("filterFaction", 0, true) end
                    if self.filter ~= "EMISSARY" then ConfigModule:Set("filterEmissary", 0, true) end
                    if self.filter ~= "LOOT" then ConfigModule:Set("filterLoot", 0, true) end
                    if self.filter ~= "ZONE" then ConfigModule:Set("filterZone", 0, true) end
                    if self.filter ~= "TIME" then ConfigModule:Set("filterTime", 0, true) end
                    ConfigModule:SetOnlyFilter(self.filter)
                end
            end

            FilterButton_OnEnter(self)
        end
    end

    local function GetFilterButton(key)
        local index = ConfigModule.Filters[key].index
        if ( not filterButtons[index] ) then
            local button = CreateFrame("Button", nil, QuestMapFrame.QuestsFrame.Contents)
            button.filter = key

            button:SetScript("OnEnter", FilterButton_OnEnter)
            button:SetScript("OnLeave", FilterButton_OnLeave)
            button:RegisterForClicks("LeftButtonUp","RightButtonUp")
            button:SetScript("OnClick", FilterButton_OnClick)

            button:SetSize(24, 24)

            if key == "SORT" then
                button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
                button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down")
                button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled")
                button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
            else
                button:SetNormalAtlas("worldquest-tracker-ring")
                button:SetHighlightAtlas("worldquest-tracker-ring")
                button:GetHighlightTexture():SetAlpha(0.4)

                local icon = button:CreateTexture(nil, "BACKGROUND", nil, -1)
                icon:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
                icon:SetSize(16, 16)
                icon:SetPoint("CENTER", 0, 1)
                icon:SetTexture(ConfigModule.Filters[key].icon or "inv_misc_questionmark")
                button.Icon = icon
            end
            filterButtons[index] = button
        end
        return filterButtons[index]
    end

    local function HeaderButton_OnClick(_, button)
        local questsCollapsed = ConfigModule:Get("collapsed")
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)

        if ( button == "LeftButton" ) then
            questsCollapsed = not questsCollapsed
            ConfigModule:Set("collapsed", questsCollapsed)
            QuestMapFrame_UpdateAll()
        end
    end

    local function ShouldQuestBeBonusColored(questID)
        if not ConfigModule:Get("colorWarbandBonus") then
            return false
        end

        return C_QuestLog.QuestContainsFirstTimeRepBonusForPlayer(questID)
    end

    local function QuestButton_OnEnter(self)
        local questTagInfo = C_QuestLog.GetQuestTagInfo(self.questID)

        local color = {}

        if ShouldQuestBeBonusColored(self.questID) then
            color.r = math.min(QUEST_REWARD_CONTEXT_FONT_COLOR.r + 0.15, 1)
            color.g = math.min(QUEST_REWARD_CONTEXT_FONT_COLOR.g + 0.15, 1)
            color.b = math.min(QUEST_REWARD_CONTEXT_FONT_COLOR.b + 0.15, 1)
        else
            _, color = GetQuestDifficultyColor( UnitLevel("player") + QuestButton_RarityColorTable[questTagInfo.quality] )
        end

        self.Text:SetTextColor( color.r, color.g, color.b )

        hoveredQuestID = self.questID

        if dataProvider then
            local pin = dataProvider.activePins[self.questID]
            if pin then
                POIButtonMixin.OnEnter(pin)
            end
        end
        self.HighlightTexture:SetShown(true);
        TaskPOI_OnEnter(self)
    end

    local function QuestButton_OnLeave(self)
        local questTagInfo = C_QuestLog.GetQuestTagInfo(self.questID)

        local color

        if ShouldQuestBeBonusColored(self.questID) then
            color = QUEST_REWARD_CONTEXT_FONT_COLOR
        else
            color = GetQuestDifficultyColor( UnitLevel("player") + QuestButton_RarityColorTable[questTagInfo.quality] )
        end

        self.Text:SetTextColor( color.r, color.g, color.b )

        hoveredQuestID = nil

        if dataProvider then
            local pin = dataProvider.activePins[self.questID]
            if pin then
                POIButtonMixin.OnLeave(pin)
            end
        end

        self.HighlightTexture:SetShown(false);
        TaskPOI_OnLeave(self)
    end

    local function QuestButton_OnClick(self, button)
        if ( not ChatEdit_TryInsertQuestLinkForQuestID(self.questID) ) then
            local watchType = C_QuestLog.GetQuestWatchType(self.questID);
            local isSuperTracked = C_SuperTrack.GetSuperTrackedQuestID() == self.questID;

            if ( button == "RightButton" ) then
                if ( self.mapID ) then
                    QuestMapFrame:GetParent():SetMapID(self.mapID)
                end
            elseif IsShiftKeyDown() then
                if watchType == Enum.QuestWatchType.Manual or (watchType == Enum.QuestWatchType.Automatic and isSuperTracked) then
                    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
                    QuestUtil.UntrackWorldQuest(self.questID);
                else
                    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
                    QuestUtil.TrackWorldQuest(self.questID, Enum.QuestWatchType.Manual);
                end
            else
                if isSuperTracked then
                    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
                    C_SuperTrack.SetSuperTrackedQuestID(0);
                else
                    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);

                    if watchType ~= Enum.QuestWatchType.Manual then
                        QuestUtil.TrackWorldQuest(self.questID, Enum.QuestWatchType.Automatic);
                    end

                    C_SuperTrack.SetSuperTrackedQuestID(self.questID);
                end
            end
        end
    end

    local function QuestButton_ToggleTracking(self)
        local watchType = C_QuestLog.GetQuestWatchType(self.questID)

        if watchType == Enum.QuestWatchType.Manual or (watchType == Enum.QuestWatchType.Automatic and C_SuperTrack.GetSuperTrackedQuestID() == self.questID) then
            QuestUtil.UntrackWorldQuest(self.questID)
        else
            QuestUtil.TrackWorldQuest(self.questID, Enum.QuestWatchType.Manual)
        end
    end

    local function QuestButton_Initiliaze(button)
        if button.awq then
            return
        end

        button.questRewardTooltipStyle = TOOLTIP_QUEST_REWARDS_STYLE_WORLD_QUEST
        button.OnLegendPinMouseEnter = function() end
        button.OnLegendPinMouseLeave = function() end

        button:SetScript("OnEnter", QuestButton_OnEnter)
        button:SetScript("OnLeave", QuestButton_OnLeave)
        button:SetScript("OnClick", QuestButton_OnClick)

        button.TagTexture:SetSize(16, 16)
        button.TagTexture:Hide()

        button.StorylineTexture:Hide()

        button.TagText = button:CreateFontString(nil, nil, "GameFontNormalLeft")
        button.TagText:SetJustifyH("RIGHT")
        button.TagText:SetTextColor(1, 1, 1)
        button.TagText:SetPoint("RIGHT", button.TagTexture, "LEFT", -2, 0)
        button.TagText:SetWidth(32)
        button.TagText:Hide()

        button.Text:ClearPoint("RIGHT")
        button.Text:SetPoint("RIGHT", button.TagText, "LEFT", -4, 0)
        button.Text:SetWidth(196)

        button.TaskIcon:ClearAllPoints()
        button.TaskIcon:SetPoint("RIGHT", button.Text, "LEFT", -4, 0)

        button.TimeIcon = button:CreateTexture(nil, "OVERLAY")
        button.TimeIcon:SetAtlas("worldquest-icon-clock")
        button.TimeIcon:SetPoint("RIGHT", button.Text, "LEFT", -5, 0)

        button.ToggleTracking = QuestButton_ToggleTracking

        button.awq = true
    end

    local function GetAnimaValue(itemID)
        local _, spellID = C_Item.GetItemSpell(itemID)
        return ANIMA_SPELLID[spellID] or 1
    end

    local function QuestSorter(a, b)
        local sortMethod = ConfigModule:Get("sortMethod")
        local sortMethods = _AngrierWorldQuests.Enums.SortOrder

        if sortMethod == sortMethods.SORT_FACTION then
            if (a.factionID or 0) ~= (b.factionID or 0) then
                return (a.factionID or 0) < (b.factionID or 0)
            end
        elseif sortMethod == sortMethods.SORT_TIME then
            if math.abs((a.timeLeftMinutes or 0) - (b.timeLeftMinutes or 0)) > 2 then
                return (a.timeLeftMinutes or 0) < (b.timeLeftMinutes or 0)
            end
        elseif sortMethod == sortMethods.SORT_ZONE then
            if a.mapID ~= b.mapID then
                return (a.mapID or 0) < (b.mapID or 0)
            end
        elseif sortMethod == sortMethods.SORT_REWARDS then
            local default_cat = #ConfigModule.Filters + 1
            local acat = (a.rewardCategory and REWARDS_ORDER[a.rewardCategory]) or default_cat
            local bcat = (b.rewardCategory and REWARDS_ORDER[b.rewardCategory]) or default_cat
            if acat ~= bcat then
                return acat < bcat
            elseif acat ~= default_cat then
                if (a.rewardValue or 0) ~= (b.rewardValue or 0) then
                    return (a.rewardValue or 0) > (b.rewardValue or 0)
                elseif (a.rewardValue2 or 0) ~= (b.rewardValue2 or 0) then
                    return (a.rewardValue2 or 0) > (b.rewardValue2 or 0)
                end
            end
        end

        return a.Text:GetText() < b.Text:GetText()
    end

    function QuestFrameModule:HideWorldQuestsHeader()
        for i = 1, #filterButtons do
            filterButtons[i]:Hide()
        end

        if headerButton then
            headerButton:Hide()
        end

        QuestScrollFrame.Contents:Layout()
    end

    function QuestFrameModule:QuestLog_Update()
        titleFramePool:ReleaseAll()

        local mapID = QuestMapFrame:GetParent():GetMapID()

        local displayLocation, lockedQuestID = C_QuestLog.GetBountySetInfoForMapID(mapID);

        local tasksOnMap = C_TaskQuest.GetQuestsOnMap(mapID)
        if (ConfigModule:Get("onlyCurrentZone")) and (not displayLocation or lockedQuestID) and not (tasksOnMap and #tasksOnMap > 0) and (mapID ~= MAPID_ARGUS) then
            QuestFrameModule:HideWorldQuestsHeader()
            return
        end

        if (ConfigModule:Get("hideQuestList")) then
            QuestFrameModule:HideWorldQuestsHeader()
            return
        end

        local questsCollapsed = ConfigModule:Get("collapsed")
        local showAtTop = ConfigModule:Get("showAtTop")

        local firstButton, storyButton, prevButton
        local layoutIndex = showAtTop and 0 or 10000

        local storyAchievementID = C_QuestLog.GetZoneStoryInfo(mapID)
        if storyAchievementID then
            storyButton = QuestScrollFrame.Contents.StoryHeader

            if layoutIndex == 0 then
                layoutIndex = storyButton.layoutIndex + 0.001;
            end
        end

        if showAtTop then
            for header in QuestScrollFrame.headerFramePool:EnumerateActive() do
                if header and (firstButton == nil or header.layoutIndex < firstButton.layoutIndex) then
                    firstButton = header
                    layoutIndex = firstButton.layoutIndex - 1 + 0.001
                end
            end

            -- if no storyheader and no quests, stay on bottom
            if layoutIndex == 0 then
                layoutIndex = 10000
            end
        end

        if not headerButton then
            headerButton = CreateFrame("BUTTON", "AngrierWorldQuestsHeader", QuestMapFrame.QuestsFrame.Contents, "QuestLogHeaderTemplate")
            headerButton:SetScript("OnClick", HeaderButton_OnClick)
            headerButton:SetText(TRACKER_HEADER_WORLD_QUESTS)
            headerButton.topPadding = 6
            headerButton.titleFramePool = titleFramePool
        end

        if storyButton then
            headerButton:SetPoint("TOPLEFT", storyButton, "BOTTOMLEFT", 0, 0)
        else
            headerButton:SetPoint("TOPLEFT", 1, -6)
        end

        headerButton.layoutIndex = layoutIndex
        layoutIndex = layoutIndex + 0.001
        headerButton:Show()
        prevButton = headerButton

        local usedButtons = {}
        local filtersOwnRow = false

        if questsCollapsed then
            for i = 1, #filterButtons do
                filterButtons[i]:Hide()
            end
        else
            local selectedFilters = ConfigModule:GetFilterTable()
            local prevFilter

            for j = 1, #ConfigModule.FiltersOrder, 1 do
                local i = j

                if not filtersOwnRow then
                    i = #ConfigModule.FiltersOrder - i + 1
                end

                local optionKey = ConfigModule.FiltersOrder[i]
                local filterButton = GetFilterButton(optionKey)
                filterButton:SetFrameLevel(50 + i)
                local rightMap = DataModule:IsFilterOnCorrectMap(optionKey, mapID)

                if ConfigModule:GetFilterDisabled(optionKey) or (not rightMap) then
                    filterButton:Hide()
                else
                    filterButton:Show()

                    filterButton:ClearAllPoints()

                    if prevFilter then
                        filterButton:SetPoint("RIGHT", prevFilter, "LEFT", 5, 0)
                        filterButton:SetPoint("TOP", prevButton, "TOP", 0, 2)
                    else
                        filterButton:SetPoint("RIGHT", prevButton.ButtonText, 22, 0)
                        filterButton:SetPoint("TOP", prevButton, "TOP", 0, 2)
                    end

                    if optionKey ~= "SORT" then
                        if selectedFilters[optionKey] then
                            filterButton:SetNormalAtlas("worldquest-tracker-ring-selected")
                        else
                            filterButton:SetNormalAtlas("worldquest-tracker-ring")
                        end
                    end
                    prevFilter = filterButton
                end
            end

            local addedQuests = {}
            local displayMapIDs = DataModule:GetMapIDsToGetQuestsFrom(mapID)

            local searchBoxText = QuestScrollFrame.SearchBox:GetText():lower()

            for mID in pairs(displayMapIDs) do
                local taskInfo = C_TaskQuest.GetQuestsOnMap(mID)

                if taskInfo then
                    for _, info in ipairs(taskInfo) do
                        if HaveQuestData(info.questID) and QuestUtils_IsQuestWorldQuest(info.questID) then
                            if WorldMap_DoesWorldQuestInfoPassFilters(info) then
                                local isFiltered = DataModule:IsQuestFiltered(info, mapID)
                                if not isFiltered then
                                    if addedQuests[info.questID] == nil then
                                        local button = QuestFrameModule:QuestLog_AddQuestButton(info, searchBoxText)

                                        if button ~= nil then
                                            table.insert(usedButtons, button)
                                            addedQuests[info.questID] = true
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if #usedButtons > 0 then
                -- In the situation where the normal quest log is empty, but we have world quests.
                -- We shouldn't show the empty quest log text.
                QuestScrollFrame.EmptyText:Hide()

                -- We need to also make sure the "No search results" text is hidden.
                QuestScrollFrame.NoSearchResultsText:Hide()
            elseif ConfigModule:HasFilters() == false then
                -- We should only hide the header, if no filters are active.
                QuestFrameModule:HideWorldQuestsHeader()
                return
            end

            table.sort(usedButtons, QuestSorter)

            for _, button in ipairs(usedButtons) do
                button.layoutIndex = layoutIndex
                layoutIndex = layoutIndex + 0.001
                button:Show()
                prevButton = button

                if hoveredQuestID == button.questID then
                    QuestButton_OnEnter(button)
                end
            end
        end

        headerButton.CollapseButton:UpdateCollapsedState(ConfigModule:Get("collapsed"))
        headerButton.CollapseButton.layoutIndex = layoutIndex
        layoutIndex = layoutIndex + 0.001
        headerButton.CollapseButton:Show()

        QuestScrollFrame.Contents:Layout()
    end

    function QuestFrameModule:QuestLog_AddQuestButton(questInfo, searchBoxText)
        local questID = questInfo.questID
        local title, factionID, _ = C_TaskQuest.GetQuestInfoByQuestID(questID)
        local questTagInfo = C_QuestLog.GetQuestTagInfo(questID)
        local timeLeftMinutes = C_TaskQuest.GetQuestTimeLeftMinutes(questID)
        C_TaskQuest.RequestPreloadRewardData(questID)

        if (questTagInfo == nil) then
            return nil
        end

        if searchBoxText ~= "" and not title:lower():find(searchBoxText, 1, true) then
            return nil
        end

        local button = titleFramePool:Acquire()
        QuestButton_Initiliaze(button)

        local totalHeight = 8
        button.worldQuest = true
        button.questID = questID
        button.mapID = questInfo.mapID
        button.factionID = factionID
        button.timeLeftMinutes = timeLeftMinutes
        button.numObjectives = questInfo.numObjectives
        button.infoX = questInfo.x
        button.infoY = questInfo.y
        button.Text:SetText(title)

        local color

        if ShouldQuestBeBonusColored(button.questID) then
            color = QUEST_REWARD_CONTEXT_FONT_COLOR
        else
            color = GetQuestDifficultyColor( UnitLevel("player") + QuestButton_RarityColorTable[questTagInfo.quality] )
        end

        button.Text:SetTextColor( color.r, color.g, color.b )

        totalHeight = totalHeight + button.Text:GetHeight()

        if (WorldMap_IsWorldQuestEffectivelyTracked(questID)) then
            button.Checkbox.CheckMark:Show()
        else
            button.Checkbox.CheckMark:Hide()
        end

        local hasIcon = true
        button.TaskIcon:Show()
        button.TaskIcon:SetTexCoord(.08, .92, .08, .92)
        if questInfo.inProgress then
            button.TaskIcon:SetAtlas("worldquest-questmarker-questionmark")
            button.TaskIcon:SetSize(10, 15)
        else
            local atlas, width, height = QuestUtil.GetWorldQuestAtlasInfo(questID, questTagInfo, false);
            if atlas and atlas ~= "Worldquest-icon" then
                button.TaskIcon:SetAtlas(atlas);
                button.TaskIcon:SetSize(math.min(width, 16), math.min(height, 16));
            elseif questTagInfo.isElite then
                button.TaskIcon:SetAtlas("questlog-questtypeicon-heroic")
                button.TaskIcon:SetSize(16, 16);
            else
                hasIcon = false
                button.TaskIcon:Hide()
            end
        end

        if ( timeLeftMinutes and timeLeftMinutes > 0 and timeLeftMinutes <= WORLD_QUESTS_TIME_LOW_MINUTES ) then
            button.TimeIcon:Show()

            if hasIcon then
                button.TimeIcon:SetSize(14, 14)
                button.TimeIcon:SetPoint("CENTER", button.TaskIcon, "BOTTOMLEFT", 0, 0)
            else
                button.TimeIcon:SetSize(16, 16)
                button.TimeIcon:SetPoint("CENTER", button.Text, "LEFT", -15, 0)
            end
        else
            button.TimeIcon:Hide()
        end

        button.HighlightTexture:SetShown(false);

        local tagText, tagTexture, tagTexCoords, tagColor
        tagColor = {r=1, g=1, b=1}

        local money = GetQuestLogRewardMoney(questID)

        if ( money > 0 ) then
            local gold = floor(money / (COPPER_PER_GOLD))
            tagTexture = "Interface\\MoneyFrame\\UI-MoneyIcons"
            tagTexCoords = { 0, 0.25, 0, 1 }
            tagText = BreakUpLargeNumbers(gold)
            button.rewardCategory = "GOLD"
            button.rewardValue = gold
            button.rewardValue2 = 0
        end

        for _, currencyInfo in ipairs(C_QuestLog.GetQuestRewardCurrencies(questID)) do
            local _, texture, numItems, currencyID = currencyInfo.name, currencyInfo.texture, currencyInfo.totalRewardAmount, currencyInfo.currencyID

            if currencyID ~= _AngrierWorldQuests.Constants.CURRENCY_IDS.WAR_SUPPLIES and currencyID ~= _AngrierWorldQuests.Constants.CURRENCY_IDS.NETHERSHARD then
                tagText = numItems
                tagTexture = texture
                tagTexCoords = nil

                if currencyID == _AngrierWorldQuests.Constants.CURRENCY_IDS.AZERITE then
                    tagColor = BAG_ITEM_QUALITY_COLORS[Enum.ItemQuality.Artifact]
                end

                button.rewardCategory = "CURRENCY"
                button.rewardValue = currencyID
                button.rewardValue2 = numItems
            end
        end

        local numQuestRewards = GetNumQuestLogRewards(questID)
        if numQuestRewards > 0 then
            local itemName, itemTexture, quantity, quality, _, itemID = GetQuestLogRewardInfo(1, questID)

            if itemName and itemTexture then
                local iLevel = DataModule:RewardItemLevel(itemID, questID)
                tagTexture = itemTexture
                tagTexCoords = nil

                if iLevel then
                    tagText = iLevel
                    tagColor = BAG_ITEM_QUALITY_COLORS[quality]
                    button.rewardCategory = "LOOT"
                    button.rewardValue = iLevel
                    button.rewardValue2 = 0
                else
                    tagText = quantity > 1 and quantity
                    button.rewardCategory = "ITEMS"
                    button.rewardValue = quantity
                    button.rewardValue2 = 0
                end

                if C_Item.IsAnimaItemByID(itemID) then
                    tagTexture = 3528288 -- Interface/Icons/Spell_AnimaBastion_Orb
                    tagColor = ANIMA_ITEM_COLOR
                    tagText = quantity * GetAnimaValue(itemID)
                end
            end
        end

        if tagTexture and tagText then
            button.TagText:Show()
            button.TagText:SetText(tagText)
            button.TagText:SetTextColor(tagColor.r, tagColor.g, tagColor.b )
            button.TagTexture:Show()
            button.TagTexture:SetTexture(tagTexture)
        elseif tagTexture then
            button.TagText:Hide()
            button.TagText:SetText("")
            button.TagTexture:Show()
            button.TagTexture:SetTexture(tagTexture)
        else
            button.TagText:Hide()
            button.TagTexture:Hide()
        end

        if tagTexture then
            if tagTexCoords then
                button.TagTexture:SetTexCoord( unpack(tagTexCoords) )
            else
                button.TagTexture:SetTexCoord(.08, .92, .08, .92)
            end
        end

        button:SetHeight(totalHeight)
        button:Show()

        return button
    end
end
--endregion

--region Initialization
do
    local function AddFilter(key, name, icon, default)
        local filter = {
            key = key,
            name = name,
            icon = "Interface\\Icons\\" .. icon,
            default = default,
            index = #ConfigModule.FiltersOrder + 1,
        }

        ConfigModule.Filters[key] = filter
        table.insert(ConfigModule.FiltersOrder, key)

        return filter
    end

    local function AddCurrencyFilter(key, currencyID, default)
        local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(currencyID)
        local name = currencyInfo.name
        local icon = currencyInfo.iconFileID

        local filter = {
            key = key,
            name = name,
            icon = icon,
            default = default,
            index = #ConfigModule.FiltersOrder + 1,
            preset = _AngrierWorldQuests.Constants.FILTERS.CURRENCY,
            currencyID = currencyID,
        }

        ConfigModule.Filters[key] = filter
        table.insert(ConfigModule.FiltersOrder, key)

        return filter
    end

    local function InitializeFilterLists()
        AddFilter("EMISSARY", BOUNTY_BOARD_LOCKED_TITLE, "achievement_reputation_01")
        AddFilter("TIME", CLOSES_IN, "ability_bossmagistrix_timewarp2")
        AddFilter("TRACKED", TRACKING, "icon_treasuremap")
        AddFilter("FACTION", FACTION, "achievement_reputation_06", true)
        AddFilter("LOOT", BONUS_ROLL_REWARD_ITEM, "inv_misc_lockboxghostiron", true)
        AddFilter("CONDUIT", AWQL["CONDUIT_ITEMS"], "Spell_Shadow_SoulGem", true)
        AddFilter("ANIMA", POWER_TYPE_ANIMA, "Spell_AnimaBastion_Orb", true)

        AddCurrencyFilter("ORDER_RESOURCES", _AngrierWorldQuests.Constants.CURRENCY_IDS.RESOURCES, true)
        AddCurrencyFilter("WAKENING_ESSENCE", _AngrierWorldQuests.Constants.CURRENCY_IDS.WAKENING_ESSENCE)

        AddCurrencyFilter("AZERITE", _AngrierWorldQuests.Constants.CURRENCY_IDS.AZERITE)
        AddCurrencyFilter("WAR_RESOURCES", _AngrierWorldQuests.Constants.CURRENCY_IDS.WAR_RESOURCES)

        AddFilter("GOLD", BONUS_ROLL_REWARD_MONEY, "inv_misc_coin_01")
        AddFilter("ITEMS", ITEMS, "inv_box_01")
        AddFilter("PROFESSION", TRADE_SKILLS, "inv_misc_note_01", true)
        AddFilter("PETBATTLE", SHOW_PET_BATTLES_ON_MAP_TEXT, "tracking_wildpet", true)
        AddFilter("RARE", ITEM_QUALITY3_DESC, "achievement_general_stayclassy")
        AddFilter("DUNGEON", GROUP_FINDER, "inv_misc_summonable_boss_token")
        AddFilter("SORT", RAID_FRAME_SORT_LABEL, "inv_misc_map_01")

        ConfigModule.Filters.TIME.values = { 1, 3, 6, 12, 24 }
    end

    local function GetDataProvider()
        for dp, _ in pairs(WorldMapFrame.dataProviders) do
            if dp.AddWorldQuest and dp.AddWorldQuest == WorldMap_WorldQuestDataProviderMixin.AddWorldQuest then
                return dp
            end
        end

        return nil
    end

    local function ShouldShowQuest(self, info)
        if self:IsQuestSuppressed(info.questID) then
            return false;
        end

        if self.focusedQuestID then
            return C_QuestLog.IsQuestCalling(self.focusedQuestID) and self:ShouldSupertrackHighlightInfo(info.questID);
        end

        local mapID = self:GetMap():GetMapID()

        if ConfigModule:Get("showHoveredPOI") and hoveredQuestID == info.questID then
            return true
        end

        if ConfigModule:Get("hideFilteredPOI") then
            if DataModule:IsQuestFiltered(info, mapID) then
                return false
            end
        end

        if ConfigModule:Get("hideUntrackedPOI") then
            if not (WorldMap_IsWorldQuestEffectivelyTracked(info.questID)) then
                return false
            end
        end

        local mapInfo = C_Map.GetMapInfo(mapID)

        if ConfigModule:Get("showContinentPOI") and mapInfo.mapType == Enum.UIMapType.Continent then
            return mapID == info.mapID or (DataModule:GetContentMapIDFromMapID(info.mapID) == mapID)
        else
            return mapID == info.mapID
        end
    end

    function QuestFrameModule:OverrideShouldShowQuest()
        local dp = GetDataProvider()

        if dp ~= nil then
            dataProvider = dp
            dataProvider.ShouldShowQuest = ShouldShowQuest
        end

        Menu.ModifyMenu("MENU_WORLD_MAP_TRACKING", function(_, rootDescription, _)
            rootDescription:AddMenuResponseCallback(QuestMapFrame_UpdateAll)
        end)
    end

    function QuestFrameModule:RegisterCallbacks()
        ConfigModule:RegisterCallback("showAtTop", function()
            QuestMapFrame_UpdateAll()
        end)

        ConfigModule:RegisterCallback({ "hideUntrackedPOI", "hideFilteredPOI", "showContinentPOI", "onlyCurrentZone", "sortMethod", "selectedFilters","disabledFilters", "filterEmissary", "filterLoot", "filterFaction", "filterZone", "filterTime", "lootFilterUpgrades", "lootUpgradesLevel", "timeFilterDuration" }, function()
            QuestMapFrame_UpdateAll()

            dataProvider:RefreshAllData()
        end)
    end

    function QuestFrameModule:OnInitialize()
        InitializeFilterLists()
    end

    function QuestFrameModule:OnEnable()
        self:OverrideShouldShowQuest()

        titleFramePool = CreateFramePool("BUTTON", QuestMapFrame.QuestsFrame.Contents, "QuestLogTitleTemplate")
        hooksecurefunc("QuestLogQuests_Update", self.QuestLog_Update)

        self:RegisterCallbacks()
    end
end
--endregion
