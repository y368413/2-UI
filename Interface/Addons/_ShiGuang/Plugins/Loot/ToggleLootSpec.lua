--## Author: 老胡、Yongri  ## Version: 9.0
--构造专精表
local spec_table = {}--kv
local spec_name_arr = {}--arr

--获取boss信息
--local name, description, bossID, rootSectionID, link = EJ_GetEncounterInfoByIndex(bossIndex);
local dropdownFrames = {}

--set
local function SetBossSpec(bossID, bossName, specName)
    ShiGuangPerDB[bossName] = specName
    --print(json.encode(ShiGuangPerDB))
end

--[[
local function setdefaultspec(spec)
	default = spec
end

local function get_mythicplus_spec(map)
	return mythicplus[map]
end

local function set_mythicplus_spec(map, spec)
	mythicplus[map] = spec
end
--]]

--ui
local function CreateDropDown(bossIndex, bossID, bossName, checkedSpecName)
    local baseFrame = _G["EncounterJournalBossButton" .. bossIndex]
    local newFrameName = "EncounterJournalBossButton" .. bossID .. "DropDown"
    local newFrame = _G[newFrameName]
    if newFrame and not newFrame:IsVisible() then
        newFrame:Show()
        return
    end
    local checkValues = { "", unpack(spec_name_arr) }
    
    newFrame = CreateFrame("Button", "EncounterJournalBossButton" .. bossIndex .. "DropDown", baseFrame, "UIDropDownMenuTemplate")
    tinsert(dropdownFrames, newFrame)
    newFrame:SetPoint("BOTTOMRIGHT", baseFrame, "BOTTOMRIGHT", 15, 0)--右下角
    
    local function OnClick(self)
        UIDropDownMenu_SetSelectedID(newFrame, self:GetID())
        --print(self:GetID(),self:GetText())
        local specName = self:GetText()
        SetBossSpec(bossID, bossName, specName)
    end
    
    local function initialize(self, level)
        local info = UIDropDownMenu_CreateInfo()
        for k, v in pairs(checkValues) do
            info = UIDropDownMenu_CreateInfo()
            info.text = v
            info.value = v
            info.func = OnClick
            UIDropDownMenu_AddButton(info, level)
        end
    end
    
    UIDropDownMenu_Initialize(newFrame, initialize)
    UIDropDownMenu_SetWidth(newFrame, 80);
    UIDropDownMenu_SetButtonWidth(newFrame, 80)
    UIDropDownMenu_SetSelectedID(newFrame, 1)
    UIDropDownMenu_JustifyText(newFrame, "LEFT")
    
    for k, v in pairs(checkValues) do
        if checkedSpecName and v == checkedSpecName then
            UIDropDownMenu_SetSelectedID(newFrame, k)
        end
    end
end

--[[local cachedBossId = 0
CreateFrame("Frame"):SetScript("OnUpdate", function()
    --界面没打开，返回
    local name, description, bossID, rootSectionID, link = EJ_GetEncounterInfoByIndex(1)
    if not bossID then return end
    --boss没变，返回
    if bossID == cachedBossId then return end
    --print("reinit", bossID, name, time())
    for i, v in ipairs(dropdownFrames) do
        v:Hide()
    end
    for bossIndex = 1, 50, 1 do
        local name, description, bossID, rootSectionID, link = EJ_GetEncounterInfoByIndex(bossIndex)
        if not bossID then
            break ;
        end
        if bossIndex == 1 then
            cachedBossId = bossID
        end
        CreateDropDown(bossIndex, bossID, name, GetLootSpecByBossName(name))
    end
end)]]

--hook
local hookFrame = CreateFrame("Frame");
hookFrame:RegisterEvent("ADDON_LOADED");
hookFrame:SetScript("OnEvent", function(self, event,moduleName)
  if moduleName=="Blizzard_EncounterJournal" then
    local EncounterJournal_DisplayInstance_original = EncounterJournal_DisplayInstance
    EncounterJournal_DisplayInstance = function(self,instanceID, noButton)
      if noButton then return;end

      for i,v in ipairs(dropdownFrames) do
        v:Hide()
      end
      for bossIndex=1,50,1 do
        local name, description, bossID, rootSectionID, link = EJ_GetEncounterInfoByIndex(bossIndex)
        if not bossID then break;end
        CreateDropDown(bossIndex,bossID,name,GetLootSpecByBossName(name))
      end
      return EncounterJournal_DisplayInstance_original(self,instanceID, noButton)
    end
    hookFrame:UnregisterEvent("ADDON_LOADED") --注销事件
  end
end)

function GetLootSpecByBossName(bossName)
    local lootSpec = ShiGuangPerDB[bossName]
    if lootSpec == "" or lootSpec == nil then
        lootSpec = nil;
    end
    return lootSpec
end

local enteringWorldFrame = CreateFrame("Frame")
enteringWorldFrame:SetScript("OnEvent", function()
    spec_table = {}
    spec_name_arr = {} --重置专精表
    
    for i = 1, 4 do
        local specId, specName = GetSpecializationInfo(i)
        if specName then
            spec_table[specName] = specId
            tinsert(spec_name_arr, specName)
        end
    end
    
    --ShiGuangPerDB = ShiGuangPerDB or {}
    --print("加载完成")
end)
enteringWorldFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

--onEncounterStart
function onEncounterStart(bossName)
    local targetSpecName = ShiGuangPerDB[bossName] --目标拾取专精
    if targetSpecName == nil or targetSpecName == "" then
        print("当前boss未设置拾取专精");
        return ; --为空表示任何专精都ok
    end
    
    local targetSpecId = spec_table[targetSpecName]
    local nowSpecId = GetLootSpecialization() --拾取专精id，0为当前拾取专精
    
    if targetSpecId ~= nowSpecId then
        --如果专精相同则不做处理，不相同，则切换到目标专精
        print("切换拾取专精为：", targetSpecName)
        SetLootSpecialization(targetSpecId)
    else
        print("不需要切换拾取专精")
    end
end

local encounter_boss_rel={
    ['test1']='1',
    ['test2']='2',
}

local encouterFrame = CreateFrame("Frame");
encouterFrame:RegisterEvent("ENCOUNTER_START");
encouterFrame:SetScript("OnEvent", function(self, event, ...)
    local encounterID, encounterName, difficulty, size = ...
    local level, affixes = C_ChallengeMode.GetActiveKeystoneInfo()
    if level > 1 then
        --print("大秘境boss，不切换专精")
        return
    end
    
    local bossName = encounter_boss_rel[encouterFrame] or encouterFrame
    onEncounterStart(bossName)
end)

--todo M+
--[[
local events = {}
function events:CHALLENGE_MODE_START()
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	print("M+ start")
	SetLootSpecialization(set_mythicplus_spec)
end

local next_azerite_is_mp_box = false
function events:CHALLENGE_MODE_COMPLETED()
	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

	local map = C_ChallengeMode.GetCompletionInfo()
--	if set_spec(get_mythicplus_spec(map)) then
--		print("M+已完成，拾取后恢复默认专精拾取")
--	end
	next_azerite_is_mp_box = true
end

function events:AZERITE_ITEM_EXPERIENCE_CHANGED()
	if next_azerite_is_mp_box then
		print("战利品已拾取，恢复默认专精拾取")
		next_azerite_is_mp_box = false
		--set_spec(get_default_spec())
	end
end
--]]
