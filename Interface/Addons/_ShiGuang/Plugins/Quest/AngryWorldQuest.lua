--## Author: Ermad  Core v1.3  "v0.20.6"
local AngryWorldQuest = {}
local Listener = CreateFrame('Frame', 'AngryWorldQuestListener')
local EventListeners = {}
local function Addon_OnEvent(frame, event, ...)
	if EventListeners[event] then
		for callback, func in pairs(EventListeners[event]) do
			if func == 0 then
				callback[event](callback, ...)
			else
				callback[func](callback, event, ...)
			end
		end
	end
end
Listener:SetScript('OnEvent', Addon_OnEvent)
function AngryWorldQuest:RegisterEvent(event, callback, func)
	if func == nil then func = 0 end
	if EventListeners[event] == nil then
		Listener:RegisterEvent(event)
		EventListeners[event] = { [callback]=func }
	else
		EventListeners[event][callback] = func
	end
end

function AngryWorldQuest:UnregisterEvent(event, callback)
	local listeners = EventListeners[event]
	if listeners then
		local count = 0
		for index,_ in pairs(listeners) do
			if index == callback then
				listeners[index] = nil
			else
				count = count + 1
			end
		end
		if count == 0 then
			EventListeners[event] = nil
			Listener:UnregisterEvent(event)
		end
	end
end

local AddOnListeners = {}
function AngryWorldQuest:ADDON_LOADED(name)
	if AddOnListeners[name] then
		for callback, func in pairs(AddOnListeners[name]) do
			if func == 0 then
				callback[name](callback)
			else
				callback[func](callback, name)
			end
		end
	end
end

function AngryWorldQuest:RegisterAddOnLoaded(name, callback, func)
	if func == nil then func = 0 end
	if IsAddOnLoaded(name) then
		if func == 0 then
			callback[name](callback)
		else
			callback[func](callback, name)
		end
	else
		self:RegisterEvent('ADDON_LOADED', self)
		if AddOnListeners[name] == nil then
			AddOnListeners[name] = { [callback]=func }
		else
			AddOnListeners[name][callback] = func
		end
	end
end

function AngryWorldQuest:UnregisterAddOnLoaded(name, callback)
	local listeners = AddOnListeners[name]
	if listeners then
		local count = 0
		for index,_ in pairs(listeners) do
			if index == callback then
				listeners[index] = nil
			else
				count = count + 1
			end
		end
		if count == 0 then
			AddOnListeners[name] = nil
		end
	end
end

local ModulePrototype = {}
function ModulePrototype:RegisterEvent(event, func)
	AngryWorldQuest:RegisterEvent(event, self, func)
end
function ModulePrototype:UnregisterEvent(event)
	AngryWorldQuest:UnregisterEvent(event, self)
end
function ModulePrototype:RegisterAddOnLoaded(name, func)
	AngryWorldQuest:RegisterAddOnLoaded(name, self, func)
end
function ModulePrototype:UnregisterAddOnLoaded(name)
	AngryWorldQuest:UnregisterAddOnLoaded(name, self)
end
AngryWorldQuest.ModulePrototype = ModulePrototype

AngryWorldQuest.Modules = {}
function AngryWorldQuest:NewModule(name)
	local object = {}
	self.Modules[name] = object
	table.insert(self.Modules, object)
	setmetatable(object, {__index=ModulePrototype})
	return object
end
setmetatable(AngryWorldQuest, {__index = AngryWorldQuest.Modules})

function AngryWorldQuest:ForAllModules(event, ...)
	for _, module in ipairs(AngryWorldQuest.Modules) do
		if type(module) == 'table' and module[event] then
			module[event](module, ...)
		end
	end
end

AngryWorldQuest:RegisterEvent('PLAYER_ENTERING_WORLD', AngryWorldQuest)
function AngryWorldQuest:PLAYER_ENTERING_WORLD()
	self:ForAllModules('BeforeStartup')
	self:ForAllModules('Startup')
	self:ForAllModules('AfterStartup')

	self:UnregisterEvent('PLAYER_ENTERING_WORLD', self)
end

AngryWorldQuest.Name = ANGRYWORLDQUEST_TITLE
_G[AngryWorldQuest] = AngryWorldQuest

local Config = AngryWorldQuest:NewModule('Config')
local configDefaults = {
	collapsed = false,
	showAtTop = true,
	showHoveredPOI = true,
	onlyCurrentZone = true,
	AngryWorldQuestsSelectedFilters = 0,
	AngryWorldQuestsDisabledFilters = 63680,  --47248
	AngryWorldQuestsFilterEmissary = 0,
	AngryWorldQuestsFilterLoot = 0,
	AngryWorldQuestsFilterFaction = 0,
	AngryWorldQuestsFilterZone = 0,
	AngryWorldQuestsFilterTime = 0,
	lootFilterUpgrades = false,
	lootUpgradesLevel = -1,
	timeFilterDuration = 6,
	hideUntrackedPOI = false,
	hideFilteredPOI = true,
	showContinentPOI = false,
	showComparisonRight = false,
	sortMethod = 2,
	extendedInfo = false,
	saveFilters = true,
}

local FiltersConversion = { EMISSARY = 1, ARTIFACT_POWER = 2, LOOT = 3, ORDER_RESOURCES = 4, GOLD = 5, ITEMS = 6, TIME = 7, FACTION = 8, PVP = 9, PROFESSION = 10, PETBATTLE = 11, SORT = 12, TRACKED = 13, ZONE = 14, RARE = 15, DUNGEON = 16, WAR_SUPPLIES = 17, NETHERSHARD = 18, VEILED_ARGUNITE = 19, WAKENING_ESSENCE = 20, AZERITE = 21, WAR_RESOURCES = 22 }

local callbacks = {}
local __filterTable

local My_UIDropDownMenu_SetSelectedValue, My_UIDropDownMenu_GetSelectedValue, My_UIDropDownMenu_CreateInfo, My_UIDropDownMenu_AddButton, My_UIDropDownMenu_Initialize
function Config:InitializeDropdown()
	My_UIDropDownMenu_SetSelectedValue = MSA_DropDownMenu_SetSelectedValue or UIDropDownMenu_SetSelectedValue
	My_UIDropDownMenu_GetSelectedValue = MSA_DropDownMenu_GetSelectedValue or UIDropDownMenu_GetSelectedValue
	My_UIDropDownMenu_CreateInfo = MSA_DropDownMenu_CreateInfo or UIDropDownMenu_CreateInfo
	My_UIDropDownMenu_AddButton = MSA_DropDownMenu_AddButton or UIDropDownMenu_AddButton
	My_UIDropDownMenu_Initialize = MSA_DropDownMenu_Initialize or UIDropDownMenu_Initialize
end

local lootUpgradeLevelValues = { -1, 0, 5, 10, 15, 20, 25, 30 }

setmetatable(Config, {
	__index = function(self, key)
		if configDefaults[key] ~= nil then
			return self:Get(key)
		else
			return AngryWorldQuest.ModulePrototype[key]
		end
	end,
})

function Config:Get(key)
		if ShiGuangDB[key] == nil then
			return configDefaults[key]
		else
			return ShiGuangDB[key]
		end
end

function Config:Set(key, newValue, silent)
		if configDefaults[key] == newValue then
			ShiGuangDB[key] = nil
		else
			ShiGuangDB[key] = newValue
		end
	if key == 'AngryWorldQuestsSelectedFilters' then 
		__filterTable = nil
	end
	if callbacks[key] and not silent then
		for _, func in ipairs(callbacks[key]) do
			func(key, newValue)
		end
	end
end

function Config:RegisterCallback(key, func)
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

function Config:UnregisterCallback(key, func)
	if callbacks[key] then
		local table = callbacks[key]
		for i=1, #table do
			if table[i] == func then
				table.remove(table, 1)
				i = i - 1
			end
		end
		if #table == 0 then callbacks[key] = nil end
	end
end

function Config:FilterKeyToMask(key)
	local index = FiltersConversion[key]
	return 2^(index-1)
end

function Config:HasFilters()
	return self:Get('AngryWorldQuestsSelectedFilters') > 0
end
function Config:IsOnlyFilter(key)
	local value = self:Get('AngryWorldQuestsSelectedFilters')
	local mask = self:FilterKeyToMask(key)
	return mask == value
end

function Config:GetFilter(key)
	local value = self:Get('AngryWorldQuestsSelectedFilters')
	local mask = self:FilterKeyToMask(key)
	return bit.band(value, mask) == mask
end

function Config:GetFilterTable(numFilters)
	if __filterTable == nil then
		local value = self:Get('AngryWorldQuestsSelectedFilters')
		__filterTable = {}
		for key,i in pairs(FiltersConversion) do
			local mask = 2^(i-1)
			if bit.band(value, mask) == mask then __filterTable[key] = true end
		end
	end
	return __filterTable
end

function Config:GetFilterDisabled(key)
	local value = self:Get('AngryWorldQuestsDisabledFilters')
	local mask = self:FilterKeyToMask(key)
	return bit.band(value, mask) == mask
end

function Config:SetFilter(key, newValue)
	local value = self:Get('AngryWorldQuestsSelectedFilters')
	local mask = self:FilterKeyToMask(key)
	if newValue then
		value = bit.bor(value, mask)
	else
		value = bit.band(value, bit.bnot(mask))
	end
	self:Set('AngryWorldQuestsSelectedFilters', value)
end

function Config:SetNoFilter()
	self:Set('AngryWorldQuestsSelectedFilters', 0)
end

function Config:SetOnlyFilter(key)
	local mask = self:FilterKeyToMask(key)
	self:Set('AngryWorldQuestsSelectedFilters', mask)
end

function Config:ToggleFilter(key)
	local value = self:Get('AngryWorldQuestsSelectedFilters')
	local mask = self:FilterKeyToMask(key)
	local currentValue = bit.band(value, mask) == mask
	if not currentValue then
		value = bit.bor(value, mask)
	else
		value = bit.band(value, bit.bnot(mask))
	end
	self:Set('AngryWorldQuestsSelectedFilters', value)
	return not currentValue
end

local panelOriginalConfig = {}
local optionPanel

local Panel_OnRefresh

local function Panel_OnSave(self)
	wipe(panelOriginalConfig)
end

local function Panel_OnCancel(self)
	-- for key, value in pairs(panelOriginalConfig) do
	-- 	if key == "AngryWorldQuestsDisabledFilters" then AngryWorldQuests_Config["AngryWorldQuestsSelectedFilters"] = nil end
	-- 	Config:Set(key, value)
	-- end
	wipe(panelOriginalConfig)
end

local function Panel_OnDefaults(self)
	for key,callbacks_key in pairs(callbacks) do
		for _, func in ipairs(callbacks_key) do
			func(key, configDefaults[key])
		end
	end
	wipe(panelOriginalConfig)
end

local function FilterCheckBox_Update(self)
	local value = Config:Get("AngryWorldQuestsDisabledFilters")
	local mask = self.filterMask
	self:SetChecked( bit.band(value,mask) == 0 )
end

local function FilterCheckBox_OnClick(self)
	local key = "AngryWorldQuestsDisabledFilters"
	if panelOriginalConfig[key] == nil then
		panelOriginalConfig[key] = Config[key]
	end
	local value = Config:Get("AngryWorldQuestsDisabledFilters")
	local mask = self.filterMask
	if self:GetChecked() then
		value = bit.band(value, bit.bnot(mask))
	else
		value = bit.bor(value, mask)
	end
	ShiGuangDB["AngryWorldQuestsSelectedFilters"] = nil
	Config:Set(key, value)
end

local function CheckBox_Update(self)
	self:SetChecked( Config:Get(self.configKey) )
end

local function CheckBox_OnClick(self)
	local key = self.configKey
	if panelOriginalConfig[key] == nil then
		panelOriginalConfig[key] = Config[key]
	end
	Config:Set(key, self:GetChecked())
end

local function DropDown_OnClick(self, dropdown)
	local key = dropdown.configKey
	if panelOriginalConfig[key] == nil then
		panelOriginalConfig[key] = Config[key]
	end
	Config:Set(key, self.value)
	My_UIDropDownMenu_SetSelectedValue( dropdown, self.value )
end

local function DropDown_Initialize(self)
	local key = self.configKey
	local selectedValue = My_UIDropDownMenu_GetSelectedValue(self)
	local info = My_UIDropDownMenu_CreateInfo()
	info.func = DropDown_OnClick
	info.arg1 = self

	if key == 'timeFilterDuration' then
		for _, hours in ipairs(AngryWorldQuest.QuestFrame.Filters.TIME.values) do
			info.text = string.format(FORMATED_HOURS, hours)
			info.value = hours
			if ( selectedValue == info.value ) then
				info.checked = 1
			else
				info.checked = nil
			end
			My_UIDropDownMenu_AddButton(info)
		end
	elseif key == 'sortMethod' then
		for _, index in ipairs(AngryWorldQuest.QuestFrame.SortOrder) do
			info.text = AngryWorldQuest.Locale['config_sortMethod_'..index]
			info.value = index
			if ( selectedValue == info.value ) then
				info.checked = 1
			else
				info.checked = nil
			end
			My_UIDropDownMenu_AddButton(info)
		end
	elseif key == 'lootUpgradesLevel' then
		for i, ilvl in ipairs(lootUpgradeLevelValues) do
			if AngryWorldQuest.Locale:Exists('config_lootUpgradesLevelValue'..i) then
				info.text = AngryWorldQuest.Locale['config_lootUpgradesLevelValue'..i]
			else
				info.text = format(AngryWorldQuest.Locale['config_lootUpgradesLevelValue'], ilvl)
			end
			info.value = ilvl
			if ( selectedValue == info.value ) then
				info.checked = 1
			else
				info.checked = nil
			end
			My_UIDropDownMenu_AddButton(info)
		end
	end
end

local DropDown_Index = 0
local function DropDown_Create(self)
	DropDown_Index = DropDown_Index + 1
	--local dropdown = CreateFrame("Frame", "AngryWorldQuestConfigDropDown"..DropDown_Index, self, My_UIDropDownMenuTemplate)
	local dropdown = MSA_DropDownMenu_Create("AngryWorldQuestConfigDropDown"..DropDown_Index, self)
	
	local label = dropdown:CreateFontString("AngryWorldQuestConfigDropLabel"..DropDown_Index, "BACKGROUND", "GameFontNormal")
	label:SetPoint("BOTTOMLEFT", dropdown, "TOPLEFT", 16, 3)
	dropdown.Label = label
	
	return dropdown
end

local panelInit, checkboxes, dropdowns, filterCheckboxes
Panel_OnRefresh = function(self)
	if not panelInit then
		local footer = self:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
		footer:SetPoint('BOTTOMRIGHT', -16, 16)
		footer:SetText("v0.20.6")  -- or "Dev" 

		local label = self:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
		label:SetPoint("TOPLEFT", 16, -16)
		label:SetJustifyH("LEFT")
		label:SetJustifyV("TOP")
		label:SetText( AngryWorldQuest.Name )

		checkboxes = {}
		dropdowns = {}
		filterCheckboxes = {}

		local checkboxes_order = { "showAtTop", "onlyCurrentZone", "showContinentPOI", "hideFilteredPOI", "hideUntrackedPOI", "showHoveredPOI", "lootFilterUpgrades" }

		for i,key in ipairs(checkboxes_order) do
			checkboxes[i] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
			checkboxes[i]:SetScript("OnClick", CheckBox_OnClick)
			checkboxes[i].configKey = key
			checkboxes[i].Text:SetText( AngryWorldQuest.Locale['config_'..key] )
			if i == 1 then
				checkboxes[i]:SetPoint("TOPLEFT", label, "BOTTOMLEFT", -2, -8)
			else
				checkboxes[i]:SetPoint("TOPLEFT", checkboxes[i-1], "BOTTOMLEFT", 0, -8)
			end
		end

		local dropdowns_order = { "timeFilterDuration", "sortMethod", "lootUpgradesLevel" }

		for i,key in ipairs(dropdowns_order) do
			dropdowns[i] = DropDown_Create(self)
			dropdowns[i].Label:SetText( AngryWorldQuest.Locale['config_'..key] )
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
		label2:SetText(AngryWorldQuest.Locale['config_enabledFilters'])

		for i,key in ipairs(AngryWorldQuest.QuestFrame.FiltersOrder) do
			local filter = AngryWorldQuest.QuestFrame.Filters[key]
			filterCheckboxes[i] = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
			filterCheckboxes[i]:SetScript("OnClick", FilterCheckBox_OnClick)
			filterCheckboxes[i].filterMask = Config:FilterKeyToMask(key)
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
		My_UIDropDownMenu_Initialize(dropdown, DropDown_Initialize)
		My_UIDropDownMenu_SetSelectedValue(dropdown, Config:Get(dropdown.configKey))
	end

	for _, check in ipairs(filterCheckboxes) do
		FilterCheckBox_Update(check)
	end

end

function Config:CreatePanel()
	self:InitializeDropdown()
	local panel = CreateFrame("FRAME")
	panel.name = AngryWorldQuest.Name
	panel.okay = Panel_OnSave
	panel.cancel = Panel_OnCancel
	panel.default  = Panel_OnDefaults
	panel.refresh  = Panel_OnRefresh
	InterfaceOptions_AddCategory(panel)

	return panel
end

function Config:BeforeStartup()
	--if AngryWorldQuests_Config == nil then AngryWorldQuests_Config = {} end
	if not self:Get('saveFilters') then
		ShiGuangDB.AngryWorldQuestsSelectedFilters = nil
		ShiGuangDB.AngryWorldQuestsFilterEmissary = nil
		ShiGuangDB.AngryWorldQuestsFilterLoot = nil
		ShiGuangDB.AngryWorldQuestsFilterFaction = nil
		ShiGuangDB.AngryWorldQuestsFilterZone = nil
		ShiGuangDB.AngryWorldQuestsFilterTime = nil
	end
end

function Config:Startup()
	local lastFilter = ShiGuangDB['__AngryWorldQuestsFilters'] or 0
	local value = ShiGuangDB['AngryWorldQuestsDisabledFilters'] or 0
	local maxFilter = 0
	for key,index in pairs(FiltersConversion) do
		if AngryWorldQuest.QuestFrame.Filters[key] then
			local mask = 2^(index-1)
			if not lastFilter or index > lastFilter then
				if AngryWorldQuest.QuestFrame.Filters[key].default then
					value = bit.band(value, bit.bnot(mask))
				else
					value = bit.bor(value, mask)
				end
			end
			if index > maxFilter then maxFilter = index end
		end
	end
	ShiGuangDB['AngryWorldQuestsDisabledFilters'] = value
	ShiGuangDB['__AngryWorldQuestsFilters'] = maxFilter

	optionPanel = self:CreatePanel('AngryWorldQuest')
end

SLASH_ANGRYWORLDQUESTS1 = "/awq"
SLASH_ANGRYWORLDQUESTS2 = "/angryworldquests"
function SlashCmdList.ANGRYWORLDQUESTS(msg, editbox)
	if optionPanel then
		InterfaceOptionsFrame_OpenToCategory(optionPanel)
		InterfaceOptionsFrame_OpenToCategory(optionPanel)
	end
end


local Locale = AngryWorldQuest:NewModule('Locale')

local default_locale = "enUS"
local current_locale

local langs = {}
langs.enUS = {
	UPGRADES = "Upgrades",
	config_showAtTop = "Display at the top of the Quest Log", 
	config_onlyCurrentZone = "Only show World Quests for the current zone", 
	config_hideFilteredPOI = "Hide filtered World Quest POI icons on the world map", 
	config_hideUntrackedPOI = "Hide untracked World Quest POI icons on the world map", 
	config_showHoveredPOI = "Always show hovered World Quest POI icon",
	config_showContinentPOI = "Show World Quest POI icons on continent maps",
	config_lootFilterUpgrades = "Show only upgrades for Loot filter",
	config_timeFilterDuration = "Time Remaining filter duration",
	config_enabledFilters = "Enabled Filters",
	config_sortMethod = "Sort World Quests by",
	config_sortMethod_1 = NAME,
	config_sortMethod_2 = CLOSES_IN,
	config_sortMethod_3 = ZONE,
	config_sortMethod_4 = FACTION,
	config_sortMethod_5 = REWARDS,
	config_characterConfig = "Per-character configuration",
	config_saveFilters = "Save active filters between logins",
	config_lootUpgradesLevel = "Loot filter shows upgrades",
	config_lootUpgradesLevelValue1 = "Higher ilvl only",
	config_lootUpgradesLevelValue2 = "Up to same ilvl",
	config_lootUpgradesLevelValue = "Up to %d ilvls less",
	CURRENT_ZONE = "Current Zone",
}

langs.zhCN = {
	UPGRADES = "可升级",
	config_showAtTop = "将任务列表置于任务日志顶部",
	config_onlyCurrentZone = "仅显示当前区域的任务列表",
	config_showEverywhere = "在所有的地图显示任务列表",
	config_hideFilteredPOI = "在世界地图上隐藏被过滤的任务",
	config_hideUntrackedPOI = "在世界地图上隐藏未被追踪的任务",
	config_showHoveredPOI = "总是显示鼠标悬停的世界任务",
	config_showContinentPOI = "在破碎群岛的地图上显示世界任务图标",
	config_lootFilterUpgrades = "在物品过滤里仅显示更高装等的物品任务",
	config_timeFilterDuration = "剩余时间过滤时长",
	config_enabledFilters = "启用过滤",
	config_sortMethod = "任务列表排序",
	config_sortMethod_1 = "名字",
	config_sortMethod_2 = "剩余时间",
	config_sortMethod_3 = "区域",
	config_sortMethod_4 = "声望",
	config_characterConfig = "为角色进行独立的配置",
	config_saveFilters = "自动保存最后选择的过滤",
	config_lootUpgradesLevel = "可升级物品装等过滤",
	config_lootUpgradesLevelValue1 = "仅显示更高装等",
	config_lootUpgradesLevelValue2 = "显示最高同等级",
	config_lootUpgradesLevelValue = "最多相差%d装等",
	CURRENT_ZONE = "当前区域",
}

langs.zhTW = {
	UPGRADES = "可升級",
	config_showAtTop = "將任務列表置於任務日誌頂部",
	config_onlyCurrentZone = "僅顯示當前區域的任務列表",
	config_showEverywhere = "在所有的地圖顯示任務列表",
	config_hideFilteredPOI = "在世界地圖上隱藏被過濾的任務",
	config_hideUntrackedPOI = "在世界地圖上隱藏未被追蹤的任務",
	config_showHoveredPOI = "總是顯示鼠標懸停的世界任務",
	config_showContinentPOI = "在破碎群島的地圖上顯示世界任務圖標",
	config_lootFilterUpgrades = "在物品過濾裏僅顯示更高裝等的物品任務",
	config_timeFilterDuration = "剩餘時間過濾時長",
	config_enabledFilters = "啟用過濾",
	config_sortMethod = "任務列表排序",
	config_sortMethod_1 = "名字",
	config_sortMethod_2 = "剩餘時間",
	config_sortMethod_3 = "區域",
	config_sortMethod_4 = "聲望",
	config_characterConfig = "為角色進行獨立的配置",
	config_saveFilters = "自動保存最後選擇的過濾",
	config_lootUpgradesLevel = "可升級物品裝等過濾",
	config_lootUpgradesLevelValue1 = "僅顯示更高裝等物品",
	config_lootUpgradesLevelValue2 = "顯示最高同裝等物品",
	config_lootUpgradesLevelValue = "最多相差%d裝等",
	CURRENT_ZONE = "當前區域",
}

function Locale:Get(key)
	if langs[current_locale] and langs[current_locale][key] ~= nil then
		return langs[current_locale][key]
	else
		return langs[default_locale][key]
	end
end

function Locale:Exists(key)
	return langs[default_locale][key] ~= nil
end

setmetatable(Locale, {__index = Locale.Get})

current_locale = GetLocale()



local Mod = AngryWorldQuest:NewModule('QuestFrame')
local Config

local dataProvder
local hoveredQuestID

local MAPID_AZEROTH = 947
-- Legion
local MAPID_BROKENISLES = 619
local MAPID_DALARAN = 627
local MAPID_AZSUNA = 630
local MAPID_STORMHEIM = 634
local MAPID_VALSHARAH = 641
local MAPID_HIGHMOUNTAIN = 650
local MAPID_SURAMAR = 680
local MAPID_EYEOFAZSHARA = 790
local MAPID_BROKENSHORE = 646
local MAPID_ARGUS = 905
local MAPID_ANTORANWASTES = 885
local MAPID_KROKUUN = 830
local MAPID_MACAREE = 882
-- BfA
local MAPID_DARKSHORE = 62
local MAPID_ARATHI_HIGHLANDS = 14
local MAPID_ZANDALAR = 875
local MAPID_VOLDUN = 864
local MAPID_NAZMIR = 863
local MAPID_ZULDAZAR = 862
local MAPID_KUL_TIRAS = 876
local MAPID_STORMSONG_VALLEY = 942
local MAPID_DRUSTVAR = 896
local MAPID_TIRAGARDE_SOUND = 895
local MAPID_TOL_DAGOR = 1169
local MAPID_NAZJATAR = 1355
local MAPID_MECHAGON_ISLAND = 1462

local CURRENCYID_RESOURCES = 1220
local CURRENCYID_WAR_SUPPLIES = 1342
local CURRENCYID_NETHERSHARD = 1226
local CURRENCYID_VEILED_ARGUNITE = 1508
local CURRENCYID_WAKENING_ESSENCE = 1533
local CURRENCYID_AZERITE = 1553
local CURRENCYID_WAR_RESOURCES = 1560

local TitleButton_RarityColorTable = { [Enum.WorldQuestQuality.Common] = 0, [Enum.WorldQuestQuality.Rare] = 3, [Enum.WorldQuestQuality.Epic] = 10 }

local FILTER_CURRENCY = 1
local FILTER_ITEMS = 2

local SORT_NAME = 1
local SORT_TIME = 2
local SORT_ZONE = 3
local SORT_FACTION = 4
local SORT_REWARDS = 5
local SORT_ORDER = { SORT_NAME, SORT_TIME, SORT_ZONE, SORT_FACTION, SORT_REWARDS }
local REWARDS_ORDER = { ARTIFACT_POWER = 1, LOOT = 2, CURRENCY = 3, GOLD = 4, ITEMS = 5 }
Mod.SortOrder = SORT_ORDER

local FACTION_ORDER_HORDE = { 2157, 2164, 2156, 2158, 2103, 2163 }
local FACTION_ORDER_ALLIANCE = { 2159, 2164, 2160, 2161, 2162, 2163 }
local FACTION_ORDER_LEGION = { 1900, 1883, 1828, 1948, 1894, 1859, 1090, 2045, 2165, 2170 }
local FACTION_ORDER

local FILTER_LOOT_ALL = 1
local FILTER_LOOT_UPGRADES = 2

local My_HideDropDownMenu, My_DropDownList1, My_UIDropDownMenu_AddButton, My_UIDropDownMenu_Initialize, My_ToggleDropDownMenu
local function MyDropDown_Init()
	My_HideDropDownMenu = Lib_HideDropDownMenu or HideDropDownMenu
	My_DropDownList1 = Lib_DropDownList1 or DropDownList1
	My_UIDropDownMenu_AddButton = MSA_DropDownMenu_AddButton or UIDropDownMenu_AddButton
	My_UIDropDownMenu_Initialize = MSA_DropDownMenu_Initialize or UIDropDownMenu_Initialize
	My_ToggleDropDownMenu = MSA_ToggleDropDownMenu or ToggleDropDownMenu
end

-- ===================
--  Utility Functions
-- ===================

--TODO: MapUtil.GetMapParentInfo(mapID, Enum.UIMapType.Continent, true)


local __continentMapID = {}
local function GetMapContinentMapID(mapID)

	if __continentMapID[mapID] == nil then
		local continentInfo = MapUtil.GetMapParentInfo(mapID, Enum.UIMapType.Continent)
		if continentInfo then
			__continentMapID[mapID] = continentInfo.mapID
		end
	end

	return __continentMapID[mapID]
end


local __legionMap = {}
local function IsLegionMap(mapID)
	if __legionMap[mapID] == nil then
		local mapInfo = C_Map.GetMapInfo(mapID)
		local isLegion = false
		while mapInfo and mapInfo.parentMapID > 0 do
			if mapInfo.mapID == MAPID_BROKENISLES then
				isLegion = true
			end
			mapInfo = C_Map.GetMapInfo(mapInfo.parentMapID)
		end
		__legionMap[mapID] = isLegion
	end
	return __legionMap[mapID]
end

local function IsLegionWorldQuest(info)
	return IsLegionMap(info.mapID)
end

-- =================
--  Event Functions
-- =================

local function HeaderButton_OnClick(self, button)
	local questsCollapsed = Config.collapsed
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	if ( button == "LeftButton" ) then
		questsCollapsed = not questsCollapsed
		Config:Set('collapsed', questsCollapsed)
		QuestMapFrame_UpdateAll()
	end
end

local function TitleButton_OnEnter(self)
	local questTagInfo = C_QuestLog.GetQuestTagInfo(self.questID)
	local _, color = GetQuestDifficultyColor( UnitLevel("player") + TitleButton_RarityColorTable[questTagInfo.quality] )
	self.Text:SetTextColor( color.r, color.g, color.b )
	
	hoveredQuestID = self.questID

	if dataProvder then
		local pin = dataProvder.activePins[self.questID]
		if pin then
			pin:EnableDrawLayer("HIGHLIGHT")
		end
	end
	--if Config.showComparisonRight then
		--WorldMapTooltip.ItemTooltip.Tooltip.overrideComparisonAnchorSide = "right"
	--end
	TaskPOI_OnEnter(self)
end

local function TitleButton_OnLeave(self)
	local questTagInfo = C_QuestLog.GetQuestTagInfo(self.questID)
	local color = GetQuestDifficultyColor( UnitLevel("player") + TitleButton_RarityColorTable[questTagInfo.quality] )
	self.Text:SetTextColor( color.r, color.g, color.b )

	hoveredQuestID = nil

	if dataProvder then
		local pin = dataProvder.activePins[self.questID]
		if pin then
			pin:DisableDrawLayer("HIGHLIGHT")
		end
	end
	TaskPOI_OnLeave(self)
end

local function TitleButton_OnClick(self, button)
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	if ( not ChatEdit_TryInsertQuestLinkForQuestID(self.questID) ) then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
		local watchType = C_QuestLog.GetQuestWatchType(self.questID);
		if ( button == "RightButton" ) then
			if ( self.mapID ) then
				QuestMapFrame:GetParent():SetMapID(self.mapID)
			end
		elseif IsShiftKeyDown() then
			if watchType == Enum.QuestWatchType.Manual or (watchType == Enum.QuestWatchType.Automatic and C_SuperTrack.GetSuperTrackedQuestID() == self.questID) then
				BonusObjectiveTracker_UntrackWorldQuest(self.questID);
			else
				BonusObjectiveTracker_TrackWorldQuest(self.questID, Enum.QuestWatchType.Manual);
			end
		else
			if watchType == Enum.QuestWatchType.Manual then
				C_SuperTrack.SetSuperTrackedQuestID(self.questID);
			else
				BonusObjectiveTracker_TrackWorldQuest(self.questID, Enum.QuestWatchType.Automatic);
			end
		end
	end
end

local function FilterButton_OnEnter(self)
	local text = Mod.Filters[ self.filter ].name
	if self.filter == "EMISSARY" and Config.AngryWorldQuestsFilterEmissary and not C_QuestLog.IsComplete(Config.AngryWorldQuestsFilterEmissary) then
		local title = C_QuestLog.GetTitleForQuestID(Config.AngryWorldQuestsFilterEmissary)
		if title then text = text..": "..title end
	end
	if self.filter == "LOOT" then
		if Config.AngryWorldQuestsFilterLoot == FILTER_LOOT_UPGRADES or (Config.AngryWorldQuestsFilterLoot == 0 and Config.lootFilterUpgrades) then
			text = string.format("%s (%s)", text, AngryWorldQuest.Locale.UPGRADES)
		end
	end
	if self.filter == "FACTION" and Config.AngryWorldQuestsFilterFaction ~= 0 then
		local title = GetFactionInfoByID(Config.AngryWorldQuestsFilterFaction)
		if title then text = text..": "..title end
	end
	if self.filter == "SORT" then
		local title = AngryWorldQuest.Locale["config_sortMethod_"..Config.sortMethod]
		if title then text = text..": "..title end
	end
	if self.filter == "ZONE" and Config.AngryWorldQuestsFilterZone ~= 0 then
		local title = GetMapNameByID(Config.AngryWorldQuestsFilterZone)
		if title then text = text..": "..title end
	end
	if self.filter == "TIME" then
		local hours = Config.AngryWorldQuestsFilterTime ~= 0 and Config.AngryWorldQuestsFilterTime or Config.timeFilterDuration
		text = string.format(BLACK_MARKET_HOT_ITEM_TIME_LEFT, string.format(FORMATED_HOURS, hours))
	end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(text)
	GameTooltip:Show()
end

local function FilterButton_OnLeave(self)
	GameTooltip:Hide()
end

local filterMenu
local function FilterMenu_OnClick(self, key)
	if key == "EMISSARY" then
		Config:Set('AngryWorldQuestsFilterEmissary', self.value, true)
	end
	if key == "LOOT" then
		Config:Set('AngryWorldQuestsFilterLoot', self.value, true)
	end
	if key == "FACTION" then
		Config:Set('AngryWorldQuestsFilterFaction', self.value, true)
	end
	if key == "ZONE" then
		Config:Set('AngryWorldQuestsFilterZone', self.value, true)
	end
	if key == "TIME" then
		Config:Set('AngryWorldQuestsFilterTime', self.value, true)
	end
	if key == "SORT" then
		Config:Set('sortMethod', self.value)
	elseif IsShiftKeyDown() then
		Config:SetFilter(key, true)
	else
		Config:SetOnlyFilter(key)
	end
end

local function FilterMenu_Initialize(self, level)
	local info = { func = FilterMenu_OnClick, arg1 = self.filter }
	if self.filter == "EMISSARY" then
		local value = Config.AngryWorldQuestsFilterEmissary
		if not C_QuestLog.IsOnQuest(value) then value = 0 end -- specific bounty not found, show all

		info.text = ALL
		info.value = 0
		info.checked = info.value == value
		My_UIDropDownMenu_AddButton(info, level)

		local mapID = QuestMapFrame:GetParent():GetMapID()
		if mapID == MAPID_BROKENISLES then mapID = MAPID_DALARAN end -- fix no emissary on broken isles continent map
		local bounties = C_QuestLog.GetBountiesForMapID(mapID)
		if bounties then
			for _, bounty in ipairs(bounties) do
				if not C_QuestLog.IsComplete(bounty.questID) then
					info.text =  C_QuestLog.GetTitleForQuestID(bounty.questID)
					info.icon = bounty.icon
					info.value = bounty.questID
					info.checked = info.value == value
					My_UIDropDownMenu_AddButton(info, level)
				end
			end
		end
	elseif self.filter == "LOOT" then
		local value = Config.AngryWorldQuestsFilterLoot
		if value == 0 then value = Config.lootFilterUpgrades and FILTER_LOOT_UPGRADES or FILTER_LOOT_ALL end

		info.text = ALL
		info.value = FILTER_LOOT_ALL
		info.checked = info.value == value
		My_UIDropDownMenu_AddButton(info, level)

		info.text = AngryWorldQuest.Locale.UPGRADES
		info.value = FILTER_LOOT_UPGRADES
		info.checked = info.value == value
		My_UIDropDownMenu_AddButton(info, level)
	elseif self.filter == "ZONE" then
		local value = Config.AngryWorldQuestsFilterZone

		info.text = AngryWorldQuest.Locale.CURRENT_ZONE
		info.value = 0
		info.checked = info.value == value
		My_UIDropDownMenu_AddButton(info, level)
	elseif self.filter == "FACTION" then
		local value = Config.AngryWorldQuestsFilterFaction

		local mapID = QuestMapFrame:GetParent():GetMapID()
		local factions = IsLegionMap(mapID) and FACTION_ORDER_LEGION or FACTION_ORDER

		for _, factionID in ipairs(factions) do
			info.text =  GetFactionInfoByID(factionID)
			info.value = factionID
			info.checked = info.value == value
			My_UIDropDownMenu_AddButton(info, level)
		end
	elseif self.filter == "TIME" then
		local value = Config.AngryWorldQuestsFilterTime ~= 0 and Config.AngryWorldQuestsFilterTime or Config.timeFilterDuration

		for _, hours in ipairs(Mod.Filters.TIME.values) do
			info.text = string.format(FORMATED_HOURS, hours)
			info.value = hours
			info.checked = info.value == value
			My_UIDropDownMenu_AddButton(info, level)
		end
	elseif self.filter == "SORT" then
		local value = Config.sortMethod

		info.text = Mod.Filters[ self.filter ].name
		info.notCheckable = true
		info.isTitle = true
		My_UIDropDownMenu_AddButton(info, level)

		info.notCheckable = false
		info.isTitle = false
		info.disabled = false
		for _, sortIndex in ipairs(SORT_ORDER) do
			info.text =  AngryWorldQuest.Locale["config_sortMethod_"..sortIndex]
			info.value = sortIndex
			info.checked = info.value == value
			My_UIDropDownMenu_AddButton(info, level)
		end
	end
end

local function FilterButton_ShowMenu(self)
	if not filterMenu then
		--filterMenu = CreateFrame("Button", "DropDownMenuAWQ", QuestMapFrame, My_UIDropDownMenuTemplate)
		filterMenu = MSA_DropDownMenu_Create("DropDownMenuAWQ", QuestMapFrame)
	end

	filterMenu.filter = self.filter
	My_UIDropDownMenu_Initialize(filterMenu, FilterMenu_Initialize, "MENU")
	My_ToggleDropDownMenu(1, nil, filterMenu, self, 0, 0)
end

local function FilterButton_OnClick(self, button)
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	if (button == 'RightButton' and (self.filter == "EMISSARY" or self.filter == "LOOT" or self.filter == "FACTION" or self.filter == "TIME")) -- or self.filter == "ZONE"
			or (self.filter == "SORT")
			or (self.filter == "FACTION" and not Config:GetFilter("FACTION")) then -- and Config.AngryWorldQuestsFilterFaction == 0
		local MY_UIDROPDOWNMENU_OPEN_MENU = Lib_UIDropDownMenu_Initialize and LIB_UIDROPDOWNMENU_OPEN_MENU or UIDROPDOWNMENU_OPEN_MENU
		if filterMenu and MY_UIDROPDOWNMENU_OPEN_MENU == filterMenu and My_DropDownList1:IsShown() and filterMenu.filter == self.filter then
			My_HideDropDownMenu(1)
		else
			My_HideDropDownMenu(1)
			FilterButton_ShowMenu(self)
		end
	else
		My_HideDropDownMenu(1)
		if IsShiftKeyDown() then
			if self.filter == "EMISSARY" then Config:Set('AngryWorldQuestsFilterEmissary', 0, true) end
			if self.filter == "LOOT" then Config:Set('AngryWorldQuestsFilterLoot', 0, true) end
			Config:ToggleFilter(self.filter)
		else
			if Config:IsOnlyFilter(self.filter) then
				Config:Set('AngryWorldQuestsFilterFaction', 0, true)
				Config:Set('AngryWorldQuestsFilterEmissary', 0, true)
				Config:Set('AngryWorldQuestsFilterLoot', 0, true)
				Config:Set('AngryWorldQuestsFilterZone', 0, true)
				Config:Set('AngryWorldQuestsFilterTime', 0, true)
				Config:SetNoFilter()
			else
				if self.filter ~= "FACTION" then Config:Set('AngryWorldQuestsFilterFaction', 0, true) end
				if self.filter ~= "EMISSARY" then Config:Set('AngryWorldQuestsFilterEmissary', 0, true) end
				if self.filter ~= "LOOT" then Config:Set('AngryWorldQuestsFilterLoot', 0, true) end
				if self.filter ~= "ZONE" then Config:Set('AngryWorldQuestsFilterZone', 0, true) end
				if self.filter ~= "TIME" then Config:Set('AngryWorldQuestsFilterTime', 0, true) end
				Config:SetOnlyFilter(self.filter)
			end
		end
		FilterButton_OnEnter(self)
	end
end

local MAPID_DISPLAY_OVERRIDE = {
	[MAPID_NAZJATAR] = {MAPID_NAZJATAR},
	[MAPID_ARGUS] = { MAPID_ANTORANWASTES, MAPID_KROKUUN, MAPID_MACAREE },
	[MAPID_AZEROTH] = { MAPID_KUL_TIRAS, MAPID_ZANDALAR, MAPID_NAZJATAR }
}

local function GetMapIDsForDisplay(mapID)
	if MAPID_DISPLAY_OVERRIDE[mapID] then
		return MAPID_DISPLAY_OVERRIDE[mapID]
	end

	if Config.onlyCurrentZone then
		return {mapID}
	else
		return {GetMapContinentMapID(mapID)}
	end
end

local filterButtons = {}
local function GetFilterButton(key)
	local index = Mod.Filters[key].index
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
			icon:SetTexture(Mod.Filters[key].icon or "inv_misc_questionmark")
			button.Icon = icon
		end
		filterButtons[index] = button
	end
	return filterButtons[index]
end

local function TitleButton_Initiliaze(button)
	if not button.awq then
		button:SetScript("OnEnter", TitleButton_OnEnter)
		button:SetScript("OnLeave", TitleButton_OnLeave)
		button:SetScript("OnClick", TitleButton_OnClick)

		button.TagTexture:SetSize(24, 24)
		button.TagTexture:ClearAllPoints()
		button.TagTexture:SetPoint("TOP", button.Text, "CENTER", 0, 8)
		button.TagTexture:SetPoint("RIGHT", 0, 0)
		button.TagTexture:Hide()

		button.TagText = button:CreateFontString(nil, nil, "GameFontNormalLeft")
		button.TagText:SetTextColor(1, 1, 1)
		button.TagText:Hide()

		button.TaskIcon:ClearAllPoints()
		button.TaskIcon:SetPoint("CENTER", button.Text, "LEFT", -15, 0)

		button.TimeIcon = button:CreateTexture(nil, "OVERLAY")
		button.TimeIcon:SetAtlas("worldquest-icon-clock")

		local filename, fontHeight = button.TagText:GetFont()
		button.TagTexture:SetSize(16, 16)
		button.TagText:ClearAllPoints()
		button.TagText:SetPoint("RIGHT", button.TagTexture , "LEFT", -3, 0)
		button.TagText:SetFont(filename, fontHeight, "OUTLINE")

		button.awq = true
	end
end

local titleFramePool
local headerButton
local spacerFrame

local function QuestFrame_AddQuestButton(questInfo, prevButton)
	local totalHeight = 8
	local button = titleFramePool:Acquire()
	TitleButton_Initiliaze(button)

	local questID = questInfo.questId
	local title, factionID, capped = C_TaskQuest.GetQuestInfoByQuestID(questID)
	local questTagInfo = C_QuestLog.GetQuestTagInfo(questID)
	local tradeskillLineID = questTagInfo.tradeskillLineID--tradeskillLineIndex and select(7, GetProfessionInfo(tradeskillLineIndex))
	local timeLeftMinutes = C_TaskQuest.GetQuestTimeLeftMinutes(questID)
	C_TaskQuest.RequestPreloadRewardData(questID)

	local totalHeight = 8
	button.worldQuest = true
	button.questID = questID
	button.mapID = questInfo.mapID
	button.factionID = factionID
	button.timeLeftMinutes = timeLeftMinutes
	button.numObjectives = questInfo.numObjectives
	button.infoX = questInfo.x
	button.infoY = questInfo.y
	local difficultyColor = GetQuestDifficultyColor( UnitLevel("player") + TitleButton_RarityColorTable[questTagInfo.quality] )

	button.Text:SetText(title)
	button.Text:SetTextColor( difficultyColor.r, difficultyColor.g, difficultyColor.b )

	totalHeight = totalHeight + button.Text:GetHeight()

	if ( WorldMap_IsWorldQuestEffectivelyTracked(questID) ) then
		button.Check:Show()
		button.Check:SetPoint("LEFT", button.Text, button.Text:GetWrappedWidth() + 2, 0)
	else
		button.Check:Hide()
	end

	local hasIcon = true
	button.TaskIcon:Show()
	button.TaskIcon:SetTexCoord(.08, .92, .08, .92)
	if questInfo.inProgress then
		button.TaskIcon:SetAtlas("worldquest-questmarker-questionmark")
		button.TaskIcon:SetSize(10, 15)
	elseif questTagInfo.worldQuestType == Enum.QuestTagType.PvP then
		button.TaskIcon:SetAtlas("worldquest-icon-pvp-ffa", true)
	elseif questTagInfo.worldQuestType == Enum.QuestTagType.PetBattle then
		button.TaskIcon:SetAtlas("worldquest-icon-petbattle", true)
	elseif questTagInfo.worldQuestType == Enum.QuestTagType.Dungeon then
		button.TaskIcon:SetAtlas("worldquest-icon-dungeon", true)
	elseif questTagInfo.worldQuestType == Enum.QuestTagType.Raid then
		button.TaskIcon:SetAtlas("worldquest-icon-raid", true)
	elseif ( questTagInfo.worldQuestType == Enum.QuestTagType.Profession and WORLD_QUEST_ICONS_BY_PROFESSION[tradeskillLineID] ) then
		button.TaskIcon:SetAtlas(WORLD_QUEST_ICONS_BY_PROFESSION[tradeskillLineID], true)
	elseif questTagInfo.isElite then
		local tagCoords = QUEST_TAG_TCOORDS[Enum.QuestTag.Heroic]
		button.TaskIcon:SetSize(16, 16)
		button.TaskIcon:SetTexture(QUEST_ICONS_FILE)
		button.TaskIcon:SetTexCoord( unpack(tagCoords) )
	elseif ( questTagInfo.worldQuestType == Enum.QuestTagType.Invasion ) then
		button.TaskIcon:SetAtlas("worldquest-icon-burninglegion", true)
	else
		hasIcon = false
		button.TaskIcon:Hide()
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

	local numQuestCurrencies = GetNumQuestLogRewardCurrencies(questID)
	if numQuestCurrencies > 0 then
		for currencyNum = 1, numQuestCurrencies do 
			local name, texture, numItems, currencyID = GetQuestLogRewardCurrencyInfo(currencyNum, questID)
			if currencyID ~= CURRENCYID_WAR_SUPPLIES and currencyID ~= CURRENCYID_NETHERSHARD then
				tagText = numItems
				tagTexture = texture
				tagTexCoords = nil
				if currencyID == CURRENCYID_AZERITE then
					tagColor = BAG_ITEM_QUALITY_COLORS[Enum.ItemQuality.Artifact]
				end
				button.rewardCategory = "CURRENCY"
				button.rewardValue = currencyID
				button.rewardValue2 = numItems
			end
		end
	end

	local numQuestRewards = GetNumQuestLogRewards(questID)
	if numQuestRewards > 0 then
		local itemName, itemTexture, quantity, quality, isUsable, itemID = GetQuestLogRewardInfo(1, questID)
		if itemName and itemTexture then
			local iLevel = AngryWorldQuest.Data:RewardItemLevel(itemID, questID)
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

local function TaskPOI_IsFilteredReward(AngryWorldQuestsSelectedFilters, questID)
	local positiveMatch = false
	local hasCurrencyFilter = false

	local money = GetQuestLogRewardMoney(questID)
	if money > 0 and AngryWorldQuestsSelectedFilters["GOLD"] then
		positiveMatch = true
	end	

	local numQuestCurrencies = GetNumQuestLogRewardCurrencies(questID)
	for key,_ in pairs(AngryWorldQuestsSelectedFilters) do
		local filter = Mod.Filters[key]
		if filter.preset == FILTER_CURRENCY then
			hasCurrencyFilter = true
			for i = 1, numQuestCurrencies do
				local name, texture, numItems, currencyID = GetQuestLogRewardCurrencyInfo(i, questID)
				if filter.currencyID == currencyID then
					positiveMatch = true
				end
			end
		end
	end

	local numQuestRewards = GetNumQuestLogRewards(questID)
	if numQuestRewards > 0 then
		local itemName, itemTexture, quantity, quality, isUsable, itemID = GetQuestLogRewardInfo(1, questID)
		if itemName and itemTexture then
			local artifactPower = nil--AngryWorldQuest.Data:ItemArtifactPower(itemID)
			local iLevel = AngryWorldQuest.Data:RewardItemLevel(itemID, questID)
			if artifactPower then
				if AngryWorldQuestsSelectedFilters.ARTIFACT_POWER then
					positiveMatch = true
				end
			else
				if iLevel then
					local upgradesOnly = Config.AngryWorldQuestsFilterLoot == FILTER_LOOT_UPGRADES or (Config.AngryWorldQuestsFilterLoot == 0 and Config.lootFilterUpgrades)
					if AngryWorldQuestsSelectedFilters.LOOT and (not upgradesOnly or AngryWorldQuest.Data:RewardIsUpgrade(itemID, questID)) then
						positiveMatch = true
					end
				else
					if AngryWorldQuestsSelectedFilters.ITEMS then
						positiveMatch = true
					end
				end
			end
		end
	end

	if positiveMatch then
		return false
	elseif hasCurrencyFilter or AngryWorldQuestsSelectedFilters.ARTIFACT_POWER or AngryWorldQuestsSelectedFilters.LOOT or AngryWorldQuestsSelectedFilters.ITEMS then
		return true
	end
end

local function TaskPOI_IsFiltered(info, displayMapID)
	local hasFilters = Config:HasFilters()
	local AngryWorldQuestsSelectedFilters = Config:GetFilterTable()

	local title, factionID, capped = C_TaskQuest.GetQuestInfoByQuestID(info.questId)
	local questTagInfo = C_QuestLog.GetQuestTagInfo(info.questId)
	if not questTagInfo then return end -- fix for nil tag
	local tradeskillLineID = questTagInfo.tradeskillLineID
	local timeLeftMinutes = C_TaskQuest.GetQuestTimeLeftMinutes(info.questId)
	C_TaskQuest.RequestPreloadRewardData(info.questId)

	local isFiltered = hasFilters

	if C_QuestLog.IsQuestFlaggedCompleted(51722) then -- BfA World Quest unlocked
		if IsLegionWorldQuest(info) and not IsLegionMap(displayMapID) then
			return true
		end
		if not IsLegionWorldQuest(info) and IsLegionMap(displayMapID) then
			return true
		end
	end

	if hasFilters then
		local lootFiltered = TaskPOI_IsFilteredReward(AngryWorldQuestsSelectedFilters, info.questId)
		if lootFiltered ~= nil then
			isFiltered = lootFiltered
		end
		
		if AngryWorldQuestsSelectedFilters.FACTION then
			if (factionID == Config.AngryWorldQuestsFilterFaction or AngryWorldQuest.Data:QuestHasFaction(info.questId, Config.AngryWorldQuestsFilterFaction)) then
				isFiltered = false
			end
		end

		if AngryWorldQuestsSelectedFilters.TIME then
			local hours = Config.AngryWorldQuestsFilterTime ~= 0 and Config.AngryWorldQuestsFilterTime or Config.timeFilterDuration
			if timeLeftMinutes and (timeLeftMinutes - WORLD_QUESTS_TIME_CRITICAL_MINUTES) <= (hours * 60) then
				isFiltered = false
			end
		end

		if AngryWorldQuestsSelectedFilters.PVP then
			if questTagInfo.worldQuestType == Enum.QuestTagType.PvP then
				isFiltered = false
			end
		end

		if AngryWorldQuestsSelectedFilters.PETBATTLE then
			if questTagInfo.worldQuestType == Enum.QuestTagType.PetBattle then
				isFiltered = false
			end
		end

		if AngryWorldQuestsSelectedFilters.PROFESSION then
			if tradeskillLineID and WORLD_QUEST_ICONS_BY_PROFESSION[tradeskillLineID] then
				isFiltered = false
			end
		end

		if AngryWorldQuestsSelectedFilters.TRACKED then
			if IsWorldQuestHardWatched(info.questId) or GetSuperTrackedQuestID() == info.questId then
				isFiltered = false
			end
		end

		if AngryWorldQuestsSelectedFilters.RARE then
			if questTagInfo.quality ~= Enum.WorldQuestQuality.Common then
				isFiltered = false
			end
		end

		if AngryWorldQuestsSelectedFilters.DUNGEON then
			if questTagInfo.worldQuestType == Enum.QuestTagType.Dungeon or questTagInfo.worldQuestType == Enum.QuestTagType.Raid then
				isFiltered = false
			end
		end

		if AngryWorldQuestsSelectedFilters.ZONE then
			local currentMapID = QuestMapFrame:GetParent():GetMapID()
			local filterMapID = Config.AngryWorldQuestsFilterZone

			if filterMapID ~= 0 then
				if info.mapID and info.mapID == filterMapID then
					isFiltered = false
				end
			else
				if info.mapID and info.mapID == currentMapID then
					isFiltered = false
				end
			end
		end

		if AngryWorldQuestsSelectedFilters.EMISSARY then
			local mapID = QuestMapFrame:GetParent():GetMapID()
			if mapID == MAPID_BROKENISLES then mapID = MAPID_DALARAN end -- fix no emissary on broken isles continent map
			local bounties = C_QuestLog.GetBountiesForMapID(mapID)
			if bounties then
				local bountyFilter = Config.AngryWorldQuestsFilterEmissary
				if not C_QuestLog.IsOnQuest(bountyFilter) or C_QuestLog.IsComplete(bountyFilter) then bountyFilter = 0 end -- show all bounties
				for _, bounty in ipairs(bounties) do
					if bounty and not C_QuestLog.IsComplete(bounty.questID) and C_QuestLog.IsQuestCriteriaForBounty(info.questId, bounty.questID) and (bountyFilter == 0 or bountyFilter == bounty.questID) then
						isFiltered = false
					end
				end
			end
		end

	end

	if Config.onlyCurrentZone and info.mapID ~= displayMapID then
		-- Needed since C_TaskQuest.GetQuestsForPlayerByMapID returns quests not on the passed map.....
		-- But, if we are on a continent (the quest continent map id matches the currently shown map)
		-- we should not be changing anything, since quests should be shown here.
		if (GetMapContinentMapID(info.mapID) ~= displayMapID) then
			isFiltered = true
		end
	end

	return isFiltered
end

local function TaskPOI_Sorter(a, b)
	if Config.sortMethod == SORT_FACTION then
		if (a.factionID or 0) ~= (b.factionID or 0) then
			return (a.factionID or 0) < (b.factionID or 0)
		end
	elseif Config.sortMethod == SORT_TIME then
		if math.abs( (a.timeLeftMinutes or 0) - (b.timeLeftMinutes or 0) ) > 2 then
			return (a.timeLeftMinutes or 0) < (b.timeLeftMinutes or 0)
		end
	elseif Config.sortMethod == SORT_ZONE then
		if a.mapID ~= b.mapID then
			return (a.mapID or 0) < (b.mapID or 0)
		end
	elseif Config.sortMethod == SORT_REWARDS then
		local default_cat = #Mod.Filters + 1
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

local function QuestFrame_Update()
	titleFramePool:ReleaseAll()

	local mapID = QuestMapFrame:GetParent():GetMapID()

	local displayLocation, lockedQuestID = C_QuestLog.GetBountySetInfoForMapID(mapID);

	local tasksOnMap = C_TaskQuest.GetQuestsForPlayerByMapID(mapID)
	if (Config.onlyCurrentZone) and (not displayLocation or lockedQuestID) and not (tasksOnMap and #tasksOnMap > 0) and (mapID ~= MAPID_ARGUS) then
		for i = 1, #filterButtons do filterButtons[i]:Hide() end
		if spaceFrame then spacerFrame:Hide() end
		if headerButton then headerButton:Hide() end
		QuestScrollFrame.Contents:Layout()
		return
	end

	local questsCollapsed = Config.collapsed

	local button, firstButton, storyButton, prevButton
	local layoutIndex = Config.showAtTop and 0 or 10000

	local storyAchievementID, storyMapID = C_QuestLog.GetZoneStoryInfo(mapID)
	if storyAchievementID then
		storyButton = QuestScrollFrame.Contents.StoryHeader
		if layoutIndex == 0 then 
			layoutIndex = storyButton.layoutIndex + 0.001;
		end
	end

	for header in QuestScrollFrame.headerFramePool:EnumerateActive() do
		if header.questLogIndex == 1 then
			firstButton = header
			if layoutIndex == 0 then
				layoutIndex = firstButton.layoutIndex - 1 + 0.001
			end
		end
	end

	if not headerButton then
		headerButton = CreateFrame("BUTTON", nil, QuestMapFrame.QuestsFrame.Contents, "QuestLogHeaderTemplate")
		headerButton:SetScript("OnClick", HeaderButton_OnClick)
		headerButton:SetText(TRACKER_HEADER_WORLD_QUESTS)
		headerButton:SetHitRectInsets(0, -headerButton.ButtonText:GetWidth(), 0, 0)
		headerButton:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
	end
	headerButton:SetNormalAtlas(questsCollapsed and "Campaign_HeaderIcon_Closed" or "Campaign_HeaderIcon_Open" );
	headerButton:SetPushedAtlas(questsCollapsed and "Campaign_HeaderIcon_ClosedPressed" or "Campaign_HeaderIcon_OpenPressed");
	headerButton:ClearAllPoints()
	if storyButton then
		headerButton:SetPoint("TOPLEFT", storyButton, "BOTTOMLEFT", 0, 0)
	else
		headerButton:SetPoint("TOPLEFT", 1, -6)
	end
	headerButton.layoutIndex = layoutIndex
	layoutIndex = layoutIndex + 0.001
	headerButton:Show()
	prevButton = headerButton

	if not headerButton.styled then
		local hasSkin = NDui or AuroraClassic
		if hasSkin then
			hasSkin[1].ReskinCollapse(headerButton, true)
			headerButton:GetPushedTexture():SetAlpha(0)
			headerButton:GetHighlightTexture():SetAlpha(0)
		end
		headerButton.styled = true
	end

	local displayedQuestIDs = {}
	local usedButtons = {}
	local filtersOwnRow = false

	if questsCollapsed then
		for i = 1, #filterButtons do filterButtons[i]:Hide() end
	else
		local hasFilters = Config:HasFilters()
		local AngryWorldQuestsSelectedFilters = Config:GetFilterTable()

		local enabledCount = 0
		for i=#Mod.FiltersOrder, 1, -1 do
			if not Config:GetFilterDisabled(Mod.FiltersOrder[i]) then enabledCount = enabledCount + 1 end
		end

		local prevFilter

		for j=1, #Mod.FiltersOrder, 1 do
			local i = j
			if not filtersOwnRow then i = #Mod.FiltersOrder - i + 1 end
			local filterButton = GetFilterButton(Mod.FiltersOrder[i])
			filterButton:SetFrameLevel(50 + i)
			if Config:GetFilterDisabled(Mod.FiltersOrder[i]) then
				filterButton:Hide()
			else
				filterButton:Show()

				filterButton:ClearAllPoints()
				if prevFilter then
					filterButton:SetPoint("RIGHT", prevFilter, "LEFT", 5, 0)
					filterButton:SetPoint("TOP", prevButton, "TOP", 0, 3)
				else
					filterButton:SetPoint("RIGHT", 1, 0)
					filterButton:SetPoint("TOP", prevButton, "TOP", 0, 3)
				end

				if Mod.FiltersOrder[i] ~= "SORT" then
					if AngryWorldQuestsSelectedFilters[Mod.FiltersOrder[i]] then
						filterButton:SetNormalAtlas("worldquest-tracker-ring-selected")
					else
						filterButton:SetNormalAtlas("worldquest-tracker-ring")
					end
				end
				prevFilter = filterButton
			end
		end

		local displayMapIDs = GetMapIDsForDisplay(mapID)
		for _, mID in ipairs(displayMapIDs) do
			local taskInfo = C_TaskQuest.GetQuestsForPlayerByMapID(mID)

			if taskInfo then
				for i, info in ipairs(taskInfo) do
					if HaveQuestData(info.questId) and QuestUtils_IsQuestWorldQuest(info.questId) then
						if WorldMap_DoesWorldQuestInfoPassFilters(info) then
							local isFiltered = TaskPOI_IsFiltered(info, mapID)
							if not isFiltered then
								local button = QuestFrame_AddQuestButton(info)
								table.insert(usedButtons, button)
							end
						end
					end
				end
			end
		end

		table.sort(usedButtons, TaskPOI_Sorter)
		for i, button in ipairs(usedButtons) do
			button.layoutIndex = layoutIndex
			layoutIndex = layoutIndex + 0.001
			button:Show()
			prevButton = button
			
			if hoveredQuestID == button.questID then
				TitleButton_OnEnter(button)
			end
		end
	end

	if not spacerFrame then
		spacerFrame = CreateFrame("FRAME", nil, QuestMapFrame.QuestsFrame.Contents)
		spacerFrame:SetHeight(6)
	end
	if #usedButtons > 0 then
		spacerFrame:Show()
		spacerFrame.layoutIndex = layoutIndex
		layoutIndex = layoutIndex + 0.001
	else
		spacerFrame:Hide()
	end

	QuestScrollFrame.Contents:Layout()
end

local function WorldMap_WorldQuestDataProviderMixin_ShouldShowQuest(self, info)
	if self:IsQuestSuppressed(info.questId) then
		return false;
	end

	if self.focusedQuestID then
		return C_QuestLog.IsQuestCalling(self.focusedQuestID) and self:ShouldHighlightInfo(info.questId);
	end

	local mapID = self:GetMap():GetMapID()

	if Config.showHoveredPOI and hoveredQuestID == info.questId then
		return true
	end

	if Config.hideFilteredPOI then
		if TaskPOI_IsFiltered(info, mapID) then
			return false
		end
	end
	if Config.hideUntrackedPOI then
		if not (WorldMap_IsWorldQuestEffectivelyTracked(info.questId)) then
			return false
		end
	end

	local mapInfo = C_Map.GetMapInfo(mapID)

	if Config.showContinentPOI and mapInfo.mapType == Enum.UIMapType.Continent then
		return mapID == info.mapID or (GetMapContinentMapID(info.mapID) == mapID)
	else
		return mapID == info.mapID
	end
end

function Mod:AddFilter(key, name, icon, default)
	local filter = {
		key = key,
		name = name,
		icon = "Interface\\Icons\\"..icon,
		default = default,
		index = #self.FiltersOrder+1,
	}

	self.Filters[key] = filter
	table.insert(self.FiltersOrder, key)

	return filter
end

function Mod:AddCurrencyFilter(key, currencyID, default)
	local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(currencyID)
	local name = currencyInfo.name
	local icon = currencyInfo.iconFileID

	local filter = {
		key = key,
		name = name,
		icon = icon,
		default = default,
		index = #self.FiltersOrder+1,
		preset = FILTER_CURRENCY,
		currencyID = currencyID,
	}

	self.Filters[key] = filter
	table.insert(self.FiltersOrder, key)

	return filter
end

function Mod:BeforeStartup()
	MyDropDown_Init()

	self.Filters = {}
	self.FiltersOrder = {}

	self:AddFilter("EMISSARY", BOUNTY_BOARD_LOCKED_TITLE, "achievement_reputation_01", true)
	self:AddFilter("TIME", CLOSES_IN, "ability_bossmagistrix_timewarp2")
	self:AddFilter("ZONE", AngryWorldQuest.Locale.CURRENT_ZONE, "inv_misc_map02") -- ZONE
	self:AddFilter("TRACKED", TRACKING, "icon_treasuremap")
	self:AddFilter("FACTION", FACTION, "achievement_reputation_06")
	self:AddFilter("LOOT", BONUS_ROLL_REWARD_ITEM, "inv_misc_lockboxghostiron", true)

	self:AddCurrencyFilter("AZERITE", CURRENCYID_AZERITE, true)
	self:AddCurrencyFilter("WAR_RESOURCES", CURRENCYID_WAR_RESOURCES, true)

	self:AddFilter("GOLD", BONUS_ROLL_REWARD_MONEY, "inv_misc_coin_01")
	self:AddFilter("ITEMS", ITEMS, "inv_box_01", true)
	self:AddFilter("PROFESSION", TRADE_SKILLS, "inv_misc_note_01")
	self:AddFilter("PETBATTLE", SHOW_PET_BATTLES_ON_MAP_TEXT, "tracking_wildpet")
	self:AddFilter("RARE", ITEM_QUALITY3_DESC, "achievement_general_stayclassy")
	self:AddFilter("DUNGEON", GROUP_FINDER, "inv_misc_summonable_boss_token")
	self:AddFilter("SORT", RAID_FRAME_SORT_LABEL, "inv_misc_map_01")


	self.Filters.TIME.values = { 1, 3, 6, 12, 24 }
end

function Mod:Blizzard_WorldMap()
	for dp,_ in pairs(WorldMapFrame.dataProviders) do
		if dp.AddWorldQuest and dp.AddWorldQuest == WorldMap_WorldQuestDataProviderMixin.AddWorldQuest then
			dataProvder = dp

			dataProvder.ShouldShowQuest = WorldMap_WorldQuestDataProviderMixin_ShouldShowQuest
		end
	end
	for _,of in ipairs(WorldMapFrame.overlayFrames) do
		if of.OnLoad and of.OnLoad == WorldMapTrackingOptionsButtonMixin.OnLoad then
			hooksecurefunc(of, "OnSelection", QuestMapFrame_UpdateAll)
		end
	end
end
--[[
local function OverrideLayoutManager()
	if Config.showAtTop then
		QuestMapFrame.layoutIndexManager.startingLayoutIndexes["Other"] = QUEST_LOG_STORY_LAYOUT_INDEX + 500 + 1
		QuestMapFrame.layoutIndexManager:AddManagedLayoutIndex("AWQ", QUEST_LOG_STORY_LAYOUT_INDEX + 1)
	else
		QuestMapFrame.layoutIndexManager.startingLayoutIndexes["Other"] = QUEST_LOG_STORY_LAYOUT_INDEX + 1
		QuestMapFrame.layoutIndexManager:AddManagedLayoutIndex("AWQ", QUEST_LOG_STORY_LAYOUT_INDEX + 500 + 1)
	end
end
]]
function Mod:Startup()
	Config = AngryWorldQuest.Config

	if UnitFactionGroup("player") == "Alliance" then
		FACTION_ORDER = FACTION_ORDER_ALLIANCE
	else
		FACTION_ORDER = FACTION_ORDER_HORDE
	end

	self:RegisterAddOnLoaded("Blizzard_WorldMap")

	titleFramePool = CreateFramePool("BUTTON", QuestMapFrame.QuestsFrame.Contents, "QuestLogTitleTemplate")

	hooksecurefunc("QuestLogQuests_Update", QuestFrame_Update)

	Config:RegisterCallback('showAtTop', function()
		QuestMapFrame_UpdateAll()
	end)

	Config:RegisterCallback({'hideUntrackedPOI', 'hideFilteredPOI', 'showContinentPOI', 'onlyCurrentZone', 'sortMethod', 'AngryWorldQuestsSelectedFilters', 'AngryWorldQuestsDisabledFilters', 'AngryWorldQuestsFilterEmissary', 'AngryWorldQuestsFilterLoot', 'AngryWorldQuestsFilterFaction', 'AngryWorldQuestsFilterZone', 'AngryWorldQuestsFilterTime', 'lootFilterUpgrades', 'lootUpgradesLevel', 'timeFilterDuration'}, function() 
		QuestMapFrame_UpdateAll()
		dataProvder:RefreshAllData()
	end)
end

local Data = AngryWorldQuest:NewModule('Data')

local KNOWLEDGE_CURRENCY_ID = 1171
local fakeTooltip
local cachedItems = {}

local worldQuestReps = {[49413]={2159,2103},[49800]={2159,2103},[50459]={2159,2156},[50461]={2159,2156},[50468]={2159,2156},[50483]={2159,2156},[50488]={2159,2156},[50489]={2159,2156},[50490]={2159,2156},[50491]={2159,2156},[50492]={2159,2156},[50496]={2159,2156},[50498]={2159,2156},[50499]={2159,2156},[50501]={2159,2156},[50503]={2159,2156},[50505]={2159,2156},[50507]={2159,2156},[50509]={2159,2156},[50510]={2159,2156},[50512]={2159,2156},[50513]={2159,2156},[50514]={2159,2156},[50515]={2159,2156},[50517]={2159,2156},[50518]={2159,2156},[50519]={2159,2156},[50564]={2159,2156},[50566]={2159,2156},[50568]={2159,2156},[50845]={2159,2103},[50846]={2159,2103},[50847]={2159,2103},[50850]={2159,2103},[50853]={2159,2103},[50854]={2159,2103},[50857]={2159,2103},[50859]={2159,2103},[50861]={2159,2103},[50862]={2159,2103},[50863]={2159,2103},[50864]={2159,2103},[50866]={2159,2103},[50867]={2159,2103},[50868]={2159,2103},[50869]={2159,2103},[50870]={2159,2103},[50871]={2159,2103},[50873]={2159,2103},[50874]={2159,2103},[50875]={2159,2103},[50876]={2159,2103},[50877]={2159,2103},[50885]={2159,2103},[50975]={2164,2159,2158},[51064]={2164,2159,2156},[51081]={2159,2103},[51084]={2159,2103},[51095]={2159,2158},[51096]={2159,2158},[51097]={2159,2158},[51098]={2159,2158},[51099]={2159,2158},[51100]={2159,2158},[51102]={2159,2158},[51103]={2159,2158},[51104]={2159,2158},[51106]={2159,2158},[51108]={2159,2158},[51112]={2159,2158},[51113]={2159,2158},[51114]={2159,2158},[51115]={2159,2158},[51116]={2159,2158},[51117]={2159,2158},[51119]={2159,2158},[51120]={2159,2158},[51121]={2159,2158},[51122]={2159,2158},[51123]={2159,2158},[51153]={2159,2158},[51155]={2159,2158},[51156]={2159,2158},[51157]={2159,2158},[51175]={2164,2159,2103},[51179]={2164,2159,2103},[51185]={2164,2159,2158},[51212]={2161,2157},[51216]={2161,2157},[51297]={2160,2157},[51377]={2159,2158},[51378]={2159,2158},[51411]={2164,2159,2156},[51412]={2164,2159,2156},[51415]={2164,2159,2156},[51422]={2164,2159,2158},[51428]={2164,2159,2158},[51429]={2159,2158},[51431]={2161,2157},[51433]={2161,2157},[51434]={2161,2157},[51444]={2164,2159,2103},[51450]={2164,2159,2103},[51453]={2162,2157},[51457]={2161,2157},[51466]={2161,2157},[51467]={2161,2157},[51468]={2161,2157},[51469]={2161,2157},[51491]={2161,2157},[51505]={2161,2157},[51506]={2161,2157},[51507]={2161,2157},[51508]={2161,2157},[51512]={2161,2157},[51527]={2161,2157},[51528]={2161,2157},[51529]={2161,2157},[51541]={2161,2157},[51542]={2161,2157},[51581]={2164,2160,2157},[51583]={2164,2160,2157},[51584]={2164,2160,2157},[51586]={2164,2160,2157},[51608]={2164,2161,2157},[51609]={2164,2161,2157},[51610]={2160,2157},[51611]={2160,2157},[51612]={2164,2161,2157},[51613]={2160,2157},[51615]={2164,2161,2157},[51617]={2164,2162,2157},[51618]={2164,2162,2157},[51623]={2164,2162,2157},[51625]={2163,2161,2157},[51626]={2163,2160,2157},[51627]={2163,2162,2157},[51628]={2163,2159,2156},[51629]={2163,2159,2158},[51630]={2163,2159,2103},[51632]={2163,2160,2157},[51635]={2163,2159,2158},[51637]={2163,2161,2157},[51638]={2163,2160,2157},[51639]={2163,2162,2157},[51640]={2163,2159,2156},[51641]={2163,2159,2158},[51642]={2163,2159,2103},[51644]={2164,2162,2157},[51651]={2160,2157},[51653]={2160,2157},[51654]={2160,2157},[51655]={2160,2157},[51656]={2160,2157},[51657]={2160,2157},[51659]={2160,2157},[51661]={2160,2157},[51662]={2160,2157},[51664]={2160,2157},[51666]={2160,2157},[51669]={2160,2157},[51670]={2160,2157},[51699]={2161,2157},[51759]={2162,2157},[51774]={2162,2157},[51778]={2162,2157},[51779]={2162,2157},[51781]={2162,2157},[51782]={2162,2157},[51806]={2162,2157},[51839]={2160,2157},[51841]={2160,2157},[51842]={2160,2157},[51843]={2160,2157},[51844]={2160,2157},[51847]={2160,2157},[51848]={2160,2157},[51849]={2160,2157},[51856]={2159,2156},[51874]={2161,2157},[51884]={2161,2157},[51886]={2162,2157},[51887]={2161,2157},[51890]={2160,2157},[51891]={2160,2157},[51892]={2160,2157},[51893]={2160,2157},[51894]={2160,2157},[51895]={2160,2157},[51897]={2161,2157},[51901]={2162,2157},[51905]={2162,2157},[51906]={2161,2157},[51908]={2161,2157},[51909]={2161,2157},[51917]={2161,2157},[51920]={2161,2157},[51921]={2162,2157},[51970]={2161,2157},[51972]={2161,2157},[51976]={2162,2157},[51988]={2161,2157},[51989]={2161,2157},[52009]={2161,2157},[52126]={2162,2157},[52157]={2161,2157},[52165]={2162,2157},[52166]={2162,2157},[52181]={2159,2156},[52196]={2159,2158},[52218]={2161,2157},[52278]={2161,2157},[52295]={2159,2157},[52297]={2161,2157},[52299]={2162,2157},[52300]={2162,2157},[52301]={2162,2157},[52306]={2162,2157},[52309]={2162,2157},[52310]={2162,2157},[52316]={2162,2157},[52321]={2162,2157},[52322]={2162,2157},[52325]={2162,2157},[52328]={2162,2157},[52330]={2162,2157},[52344]=2163,[52352]={2162,2157},[52394]=2163,[52430]={2160,2157},[52446]={2162,2157},[52455]={2160,2157},[52458]={2160,2157},[52459]={2162,2157},[52463]={2162,2157},[52464]={2162,2157},[52471]={2160,2157},[52476]={2162,2157},[52751]={2160,2157},[52754]={2159,2156},[52779]={2159,2156},[52799]={2159,2156},[52803]={2159,2156},[52832]={2164,2159,2156},[52849]={2164,2159,2158},[52850]={2159,2158},[52856]={2159,2158},[52858]={2164,2159,2103},[52862]={2164,2161,2157},[52864]={2159,2158},[52869]={2164,2160,2157},[52871]={2164,2162,2157},[52872]={2164,2161,2157},[52873]={2164,2162,2157},[52874]={2164,2160,2157},[52875]={2164,2159,2158},[52877]={2164,2159,2103},[52878]={2159,2158},[52880]={2162,2157},[52884]={2164,2159,2156},[52889]={2162,2157},[52892]={2159,2103},[52923]={2159,2103},[52937]={2159,2103},[52938]={2159,2103},[53271]={2161,2157},[53280]={2160,2157},[53286]={2162,2157},[53289]={2159,2156},[53294]={2159,2156},[53296]={2159,2158},[53297]={2159,2158},[53300]={2159,2158},[53303]={2159,2103},[53311]={2161,2157},[53312]={2160,2157},[53314]={2160,2157},[53316]={2162,2157},[53317]={2162,2157},[53323]={2159,2156},[53324]={2159,2158},[53325]={2159,2158},[53326]={2159,2158},[53327]={2159,2103},[53329]={2159,2103},[49397]={2161,2157},[49994]={2160,2157},[50000]={2161,2157},[50164]={2160,2157},[50234]={2160,2157},[50295]={2160,2157},[50296]={2160,2157},[50299]={2160,2157},[50315]={2160,2157},[50322]={2160,2157},[50324]={2160,2157},[50369]={2161,2157},[50421]={2160,2157},[50527]={2159,2103},[50591]={2162,2157},[50651]={2159,2103},[50737]={2159,2103},[50756]={2159,2103},[50767]={2160,2157},[50776]={2160,2157},[50782]={2159,2103},[50792]={2160,2157},[50855]={2159,2103},[50858]={2159,2103},[50899]={2159,2156},[50936]={2159,2156},[50958]={2160,2157},[50961]={2159,2156},[50962]={2159,2156},[50969]={2159,2103},[50977]={2160,2157},[50982]={2162,2157},[50983]={2160,2157},[50984]={2160,2157},[50986]={2161,2157},[50987]={2161,2157},[50989]={2162,2157},[50991]={2161,2157},[50993]={2162,2157},[50994]={2161,2157},[50996]={2162,2157},[50998]={2160,2157},[51017]=2159,[51021]=2159,[51022]=2159,[51023]=2159,[51024]=2159,[51025]=2159,[51026]=2159,[51027]=2159,[51028]=2159,[51029]=2159,[51030]=2159,[51031]=2159,[51032]=2159,[51033]=2159,[51034]=2159,[51035]={2161,2157},[51092]={2160,2157},[51109]={2159,2156},[51127]={2159,2156},[51131]={2159,2156},[51154]={2159,2156},[51166]={2159,2156},[51172]={2159,2156},[51178]={2159,2103},[51225]={2160,2157},[51241]={2160,2157},[51245]={2160,2157},[51284]={2160,2157},[51311]={2160,2157},[51317]={2160,2157},[51373]={2159,2103},[51374]={2159,2103},[51385]={2160,2157},[51388]={2160,2157},[51397]={2161,2157},[51405]={2160,2157},[51406]={2160,2157},[51454]={2161,2157},[51530]={2161,2157},[51546]={2159,2156},[51548]={2159,2156},[51550]={2159,2156},[51562]={2159,2158},[51564]={2159,2158},[51565]={2159,2158},[51576]={2161,2157},[51577]={2160,2157},[51579]={2160,2157},[51585]={2161,2157},[51588]={2161,2157},[51604]={2161,2157},[51619]={2161,2157},[51620]={2161,2157},[51621]={2160,2157},[51658]={2161,2157},[51667]={2161,2157},[51672]={2161,2157},[51676]={2161,2157},[51681]={2161,2157},[51682]={2161,2157},[51683]={2161,2157},[51686]={2161,2157},[51687]={2161,2157},[51690]={2161,2157},[51693]={2161,2157},[51694]={2161,2157},[51697]={2161,2157},[51706]={2161,2157},[51707]={2161,2157},[51709]={2161,2157},[51710]={2161,2157},[51758]={2160,2157},[51760]={2159,2158},[51783]={2159,2158},[51793]={2159,2158},[51794]={2159,2158},[51804]={2159,2158},[51814]={2159,2103},[51815]={2159,2103},[51816]={2159,2103},[51817]={2162,2157},[51820]={2162,2157},[51821]={2159,2103},[51822]={2159,2103},[51824]={2159,2103},[51834]={2159,2158},[51836]={2159,2158},[51853]={2159,2158},[51854]={2162,2157},[51855]={2162,2157},[51925]={2159,2158},[51928]={2159,2158},[51931]={2159,2158},[51933]={2159,2158},[51963]={2159,2158},[51981]={2162,2157},[51995]={2159,2158},[52010]={2160,2157},[52011]={2162,2157},[52045]={2162,2157},[52047]={2160,2157},[52054]={2162,2157},[52059]={2159,2158},[52071]={2162,2157},[52120]={2160,2157},[52140]={2162,2157},[52142]={2162,2157},[52143]={2160,2157},[52144]={2160,2157},[52155]={2160,2157},[52159]={2160,2157},[52163]={2160,2157},[52164]={2162,2157},[52167]={2160,2157},[52168]={2162,2157},[52174]={2162,2157},[52179]={2162,2157},[52180]={2162,2157},[52200]={2162,2157},[52211]={2162,2157},[52230]={2162,2157},[52249]={2159,2103},[52250]={2159,2103},[52271]={2162,2157},[52331]=2159,[52333]={2160,2157},[52334]={2161,2157},[52339]=2159,[52340]=2159,[52353]={2162,2157},[52356]={2160,2157},[52357]={2161,2157},[52363]=2159,[52365]={2161,2157},[52367]={2162,2157},[52368]=2159,[52375]=2159,[52376]=2159,[52377]={2160,2157},[52378]=2159,[52379]=2159,[52390]={2161,2157},[52392]=2159,[52405]={2160,2157},[52407]={2161,2157},[52414]={2161,2157},[52415]={2162,2157},[52417]={2160,2157},[52423]={2160,2157},[52424]={2161,2157},[52761]={2160,2157},[52785]={2159,2156},[52794]={2162,2157},[52847]={2161,2157},[52865]={2162,2157},[52879]={2162,2157},[52891]={2162,2157},[52924]={2162,2157},[52935]={2162,2157},[52939]={2162,2157},[52941]={2162,2157},[52947]={2162,2157},[52964]={2162,2157},[52972]={2162,2157},[52979]={2162,2157},[52982]={2162,2157},[52987]={2162,2157},[52988]={2162,2157},[53012]={2162,2157},[53040]={2162,2157},[53106]={2162,2157},[53107]={2162,2157},[53108]={2162,2157},[53165]={2159,2103},[53188]={2160,2157},[53189]={2160,2157},[53331]=2160,[47704]={2159,2158},[49013]={2159,2158},[49068]={2159,2103},[49345]={2159,2158},[49444]={2159,2103},[50287]={2159,2103},[50443]={2159,2156},[50474]={2159,2156},[50497]={2159,2156},[50521]={2159,2156},[50524]={2159,2103},[50529]={2159,2156},[50540]={2159,2103},[50545]={2159,2156},[50547]={2159,2103},[50548]={2159,2103},[50549]={2159,2156},[50559]={2159,2156},[50571]={2159,2103},[50572]={2159,2156},[50574]={2159,2103},[50577]={2159,2156},[50578]={2159,2103},[50581]={2159,2103},[50587]={2159,2156},[50592]={2159,2103},[50619]={2159,2103},[50634]={2159,2156},[50636]={2159,2103},[50648]={2159,2156},[50650]={2159,2156},[50652]={2159,2103},[50660]={2159,2156},[50665]={2159,2156},[50676]={2159,2156},[50689]={2159,2156},[50695]={2159,2156},[50717]={2159,2156},[50718]={2159,2156},[50735]={2159,2156},[50744]={2159,2103},[50765]={2159,2103},[50786]={2159,2156},[50813]={2159,2156},[50964]={2159,2103},[50966]={2159,2103},[50999]={2159,2103},[51000]={2159,2103},[51003]={2159,2158},[51005]={2159,2156},[51006]={2159,2156},[51007]={2159,2158},[51008]={2159,2158},[51009]={2159,2156},[51010]={2159,2103},[51013]={2159,2103},[51015]={2159,2156},[51036]=2157,[51037]=2157,[51038]=2157,[51039]=2157,[51040]=2157,[51041]=2157,[51042]=2157,[51043]=2157,[51044]=2157,[51045]=2157,[51046]=2157,[51047]=2157,[51048]=2157,[51049]=2157,[51050]=2157,[51051]=2157,[51173]={2159,2158},[51174]={2159,2158},[51181]={2159,2158},[51198]={2159,2158},[51210]={2159,2158},[51223]={2159,2158},[51228]={2159,2158},[51232]={2159,2103},[51238]={2159,2158},[51239]={2159,2158},[51250]={2159,2158},[51252]={2159,2158},[51285]={2159,2158},[51316]={2159,2158},[51322]={2159,2158},[51330]={2159,2158},[51462]={2160,2157},[51463]={2160,2157},[51475]={2159,2103},[51494]={2159,2103},[51495]={2159,2103},[51496]={2159,2103},[51497]={2159,2103},[51558]={2159,2158},[51559]={2159,2158},[51578]={2160,2157},[51580]={2160,2157},[51622]={2160,2157},[51646]={2160,2157},[51647]={2160,2157},[51671]={2160,2157},[51719]={2161,2157},[51727]={2161,2157},[51737]={2161,2157},[51738]={2161,2157},[51739]={2161,2157},[51740]={2161,2157},[51741]={2161,2157},[51743]={2161,2157},[51745]={2161,2157},[51746]={2161,2157},[51747]={2161,2157},[51754]={2161,2157},[51761]={2161,2157},[51763]={2159,2158},[51764]={2161,2157},[51765]={2161,2157},[51767]={2161,2157},[51768]={2161,2157},[51769]={2161,2157},[51780]={2159,2158},[51791]={2159,2158},[51792]={2159,2158},[51811]={2162,2157},[51827]={2162,2157},[51828]={2162,2157},[51832]={2161,2157},[51840]={2162,2157},[51850]={2159,2158},[51957]={2159,2158},[51983]={2159,2158},[51996]={2162,2157},[51997]={2159,2158},[52004]={2162,2157},[52006]={2159,2156},[52007]={2159,2156},[52056]={2160,2157},[52057]={2160,2157},[52063]={2162,2157},[52064]={2162,2157},[52115]={2162,2157},[52117]={2162,2157},[52119]={2160,2157},[52124]={2160,2157},[52160]={2162,2157},[52209]={2162,2157},[52229]={2162,2157},[52236]={2162,2157},[52239]={2162,2157},[52248]={2159,2103},[52280]={2162,2157},[52335]=2157,[52336]={2159,2103},[52337]={2159,2156},[52341]=2157,[52342]=2157,[52358]={2159,2103},[52359]={2159,2103},[52361]={2159,2156},[52362]={2159,2158},[52369]=2157,[52372]={2159,2156},[52373]={2159,2103},[52374]=2157,[52382]=2157,[52384]=2157,[52385]={2159,2156},[52387]=2157,[52388]=2157,[52395]={2159,2103},[52396]={2159,2156},[52397]={2159,2158},[52398]=2157,[52409]={2159,2103},[52410]={2159,2156},[52412]={2159,2158},[52418]={2159,2156},[52420]={2159,2103},[52421]={2159,2103},[52425]={2159,2103},[52426]={2159,2156},[52752]={2160,2157},[52755]={2160,2157},[52756]={2160,2157},[52757]={2160,2157},[52760]={2160,2157},[52763]={2160,2157},[52798]={2159,2158},[52804]={2160,2157},[52805]={2160,2157},[52848]={2161,2157},[52882]={2162,2157},[52890]=67,[52936]={2162,2157},[52940]={2162,2157},[52968]={2162,2157},[52986]={2162,2157},[53008]={2162,2157},[53042]={2162,2157},[53076]={2160,2157},[53078]={2160,2157},[53196]={2160,2157},[53343]={2162,2157},[53344]={2162,2157},[53345]={2162,2157},[52345]=2163,[52346]=2163,[52348]=2163,[52349]=2163,[52350]=2163,[52351]=2163,[52393]=2163,[50487]=2156,[50502]={2159,2156},[50506]=2156,[50511]={2159,2156},[50516]={2159,2156},[50570]={2159,2156},[50667]={2159,2156},[50747]={2159,2103},[50872]={2159,2103},[50981]={2162,2157},[50992]={2160,2157},[51014]={2159,2103},[51090]={2160,2157},[51105]={2159,2158},[51107]={2159,2158},[51124]=2158,[51125]=2158,[51176]={2159,2156},[51180]={2159,2158},[51296]={2160,2157},[51379]={2159,2158},[51455]={2162,2157},[51461]={2161,2157},[51502]={2159,2103},[51561]={2159,2158},[51616]=2161,[51652]={2160,2157},[51660]={2160,2157},[51742]={2161,2157},[51900]={2159,2158},[51919]={2161,2157},[51924]={2159,2158},[51977]={2162,2157},[51978]={2162,2157},[51982]={2162,2157},[52133]={2162,2157},[52198]={2162,2157},[52199]=2162,[52237]={2161,2157},[52238]={2161,2157},[52251]={2159,2103},[52315]={2162,2157},[52332]={2162,2157},[52338]={2159,2158},[52355]={2160,2157},[52360]={2159,2156},[52381]={2161,2157},[52383]={2159,2103},[52386]={2159,2158},[52404]={2160,2157},[52406]={2161,2157},[52408]={2159,2103},[52416]={2160,2157},[52432]=2162,[52454]={2160,2157},[52456]={2160,2157},[52507]={2162,2157},[52771]={2160,2157},[52775]={2161,2157},[52808]={2164,2159,2156},[52885]=469,[53025]={2162,2157},[53282]={2160,2157},[53321]={2159,2156},[51012]={2159,2156},[52364]={2161,2157}}

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

function Data:QuestHasFaction(questID, factionID)
	local reps = worldQuestReps[questID]
	if reps then
		if (type(reps) == "table") then
			for _, fID in ipairs(reps) do
				if fID == factionID then return true end
			end
			return false
		else
			return reps == factionID
		end
	else
		return false
	end
end

function Data:RewardIsUpgrade(itemID, questID)
	local _, _, _, _, _, _, _, _, equipSlot, _, _ = GetItemInfo(itemID)
	local ilvl = self:RewardItemLevel(itemID, questID)

	if equipSlot and invtype_locations[equipSlot] then
		local isUpgrade = false

		for _, slotID in ipairs(invtype_locations[equipSlot]) do
			local currentItem = GetInventoryItemLink("player", slotID)
			if currentItem then
				local currentIlvl = select(4, GetItemInfo(currentItem))
				if not currentIlvl or ilvl >= (currentIlvl - AngryWorldQuest.Config.lootUpgradesLevel) then
					isUpgrade = true
				end
			else
				isUpgrade = true
			end
		end

		return isUpgrade
	else
		return true
	end
end

function Data:RewardItemLevel(itemID, questID)
	local key = itemID..":"..questID
	if cachedItems[key] == nil then
		fakeTooltip:SetOwner(UIParent, "ANCHOR_NONE")
		fakeTooltip:SetQuestLogItem("reward", 1, questID)

		-- local itemLink = select(2, fakeTooltip:GetItem())
		if false and itemLink then
			local itemName, _, _, itemLevel, _, _, _, _, itemEquipLoc, _, _, itemClassID, itemSubClassID = GetItemInfo(itemLink)
			if itemName then
				if (itemClassID == 3 and itemSubClassID == 11) or (itemEquipLoc ~= nil and itemEquipLoc ~= "") then
					cachedItems[key] = itemLevel
				else
					cachedItems[key] = false
				end
			end
		else
			local textLine2 = AWQFakeTooltipTextLeft2 and AWQFakeTooltipTextLeft2:IsShown() and AWQFakeTooltipTextLeft2:GetText()
			local textLine3 = AWQFakeTooltipTextLeft3 and AWQFakeTooltipTextLeft3:IsShown() and AWQFakeTooltipTextLeft3:GetText()
			local textLine4 = AWQFakeTooltipTextLeft4 and AWQFakeTooltipTextLeft4:IsShown() and AWQFakeTooltipTextLeft4:GetText()
			local matcher = string.gsub(ITEM_LEVEL_PLUS, "%%d%+", "(%%d+)+?")
			local itemLevel

			if textLine2 then
				itemLevel = tonumber(textLine2:match(matcher))
			end
			if textLine3 and not itemLevel then
				itemLevel = tonumber(textLine3:match(matcher))
			end
			if textLine4 and not itemLevel then
				itemLevel = tonumber(textLine4:match(matcher))
			end

			cachedItems[key] = itemLevel or false
		end
	end
	return cachedItems[key]
end

function Data:UNIT_QUEST_LOG_CHANGED(arg1)
	if arg1 == "player" then
		wipe(cachedItems)
	end
end
function Data:PLAYER_ENTERING_WORLD()
	wipe(cachedItems)
end

function Data:Startup()
	fakeTooltip = CreateFrame('GameTooltip', 'AWQFakeTooltip', UIParent, 'GameTooltipTemplate')
	fakeTooltip:Hide()

	self:RegisterEvent('UNIT_QUEST_LOG_CHANGED')
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
end
