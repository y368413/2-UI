local addonName, _ = ... ---@type string, table

---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class Result: AceModule
local R = addon:GetModule("Result")

---@class HbFrame: AceModule
local HbFrame = addon:GetModule("HbFrame")

local L = LibStub("AceLocale-3.0"):GetLocale(addonName, false)

---@class E: AceModule
local E = addon:GetModule("Element")

---@class Text: AceModule
local Text = addon:GetModule("Text")

---@class Trigger: AceModule
local Trigger = addon:GetModule("Trigger")

---@class Condition: AceModule
local Condition = addon:GetModule("Condition")

---@class Effect: AceModule
local Effect = addon:GetModule("Effect")

---@class Utils: AceModule
local U = addon:GetModule('Utils')

---@class Client: AceModule
local Client = addon:GetModule("Client")

---@class Api: AceModule
local Api = addon:GetModule("Api")

---@class Macro: AceModule
local Macro = addon:GetModule("Macro")

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceSerializer = LibStub("AceSerializer-3.0")
local LibDeflate = LibStub:GetLibrary("LibDeflate")
local AceGUI = LibStub("AceGUI-3.0")

---@class Config
local Config = {}

---@param itemType ElementType
---@param val string | nil
---@return Result
function Config.VerifyItemAttr(itemType, val)
    if val == nil or val == "" or val == " " then
        return R:Err("Please input effect title.")
    end
    local G = addon.G
    local item = {} ---@type ItemAttr
    item.type = itemType
    if item.type == nil then return R:Err(L["Please select item type."]) end
    -- 添加物品逻辑
    -- 说明：print(type(C_ToyBox.GetToyInfo(item.id))) 返回的是number，和文档定义的不一致，无法通过API获取玩具信息，因此只能使用物品的API来获取
    if item.type == const.ITEM_TYPE.ITEM or item.type == const.ITEM_TYPE.EQUIPMENT or item.type == const.ITEM_TYPE.TOY then
        local itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subClassID = Api.GetItemInfoInstant(val)
        if itemID then
            item.id = itemID
            item.icon = icon
        else
            return R:Err(L["Unable to get the id, please check the input."])
        end
        local itemName = C_Item.GetItemNameByID(item.id)
        if itemName then
            item.name = itemName
        else
            return R:Err(L["Unable to get the name, please check the input."])
        end

        -- local itemID = C_Item.GetItemIDForItemInfo(val)
        -- if itemID then
        --     item.id = itemID
        -- else
        --     return R:Err(L["Unable to get the id, please check the input."])
        -- end
        -- local itemIcon = C_Item.GetItemIconByID(item.id)
        -- if itemIcon then
        --     item.icon = itemIcon
        -- else
        --     return R:Err("Can not get the icon, please check your input.")
        -- end

    elseif item.type == const.ITEM_TYPE.SPELL then
        if Client:IsRetail() then
            local spellID = C_Spell.GetSpellIDForSpellIdentifier(val)
            if spellID then
                item.id = spellID
            else
                return R:Err(L["Unable to get the id, please check the input."])
            end
            local spellName = C_Spell.GetSpellName(item.id)
            if spellName then
                item.name = spellName
            else
                return R:Err("Can not get the name, please check your input.")
            end
            local iconID, originalIconID = C_Spell.GetSpellTexture(item.id)
            if iconID then
                item.icon = iconID
            else
                return R:Err(L["Unable to get the icon, please check the input."])
            end
        else
            local spellInfo = Api.GetSpellInfo(val)
            if spellInfo then
                item.id = spellInfo.spellID
                item.name = spellInfo.name
                item.icon = spellInfo.iconID
            else
                return R:Err(L["Unable to get the id, please check the input."])
            end
        end
    elseif item.type == const.ITEM_TYPE.MOUNT then
        item.id = tonumber(val)
        if item.id == nil then
            for mountDisplayIndex = 1, C_MountJournal.GetNumDisplayedMounts() do
                local name, spellID, icon, isActive, isUsable, sourceType,
                isFavorite, isFactionSpecific, faction, shouldHideOnChar,
                isCollected, mountID, isSteadyFlight =
                    C_MountJournal.GetDisplayedMountInfo(mountDisplayIndex)
                if name == val then
                    item.id = mountID
                    item.name = name
                    item.icon = icon
                    break
                end
            end
        end
        if item.id == nil then
            return R:Err(L["Unable to get the id, please check the input."])
        end
        if item.icon == nil then
            local name, spellID, icon, active, isUsable, sourceType, isFavorite,
            isFactionSpecific, faction, shouldHideOnChar, isCollected,
            mountID = C_MountJournal.GetMountInfoByID(item.id)
            if name then
                item.id = mountID
                item.name = name
                item.icon = icon
            else
                return R:Err("Can not get the name, please check your input.")
            end
        end
    elseif item.type == const.ITEM_TYPE.PET then
        item.id = tonumber(val)
        if item.id == nil then
            local speciesId, petGUID = C_PetJournal.FindPetIDByName(val)
            if speciesId then item.id = speciesId end
        end
        if item.id == nil then
            return R:Err(L["Unable to get the id, please check the input."])
        end
        local speciesName, speciesIcon, petType, companionID, tooltipSource,
        tooltipDescription, isWild, canBattle, isTradeable, isUnique,
        obtainable, creatureDisplayID =
            C_PetJournal.GetPetInfoBySpeciesID(item.id)
        if speciesName then
            item.name = speciesName
            item.icon = speciesIcon
        else
            return R:Err(L["Unable to get the name, please check the input."])
        end
    else
        return R:Err("Wrong type, please check your input.")
    end
    return R:Ok(item)
end

--[[
对单个物品进行本地化处理
]]
---@param item ItemConfig
function Config.UpdateItemLocalizeName(item)
    if item == nil or item.extraAttr == nil or item.extraAttr.id == nil or
        item.extraAttr.type == nil then
        return
    end
    if item.extraAttr.type == const.ITEM_TYPE.ITEM or item.extraAttr.type ==
        const.ITEM_TYPE.EQUIPMENT or item.extraAttr.type == const.ITEM_TYPE.TOY then
        local itemName = C_Item.GetItemNameByID(item.extraAttr.id)
        if itemName then
            item.extraAttr.name = itemName
        else
            local syncItem = Item:CreateFromItemID(item.extraAttr.id)
            syncItem:ContinueOnItemLoad(function()
                local syncName = syncItem:GetItemName()
                if syncName then
                    item.extraAttr.name = syncItem:GetItemName()
                end
            end)
        end
    elseif item.extraAttr.type == const.ITEM_TYPE.SPELL then
        local spellInfo = Api.GetSpellInfo(item.extraAttr.id)
        if spellInfo then
            item.extraAttr.name = spellInfo.name
        else
            local syncSpell = Spell:CreateFromSpellID(item.extraAttr.id)
            syncSpell:ContinueOnSpellLoad(function()
                local syncName = syncSpell:GetSpellName()
                if syncName then item.extraAttr.name = syncName end
            end)
        end
    elseif item.extraAttr.type == const.ITEM_TYPE.MOUNT then
        local name, spellID, icon, active, isUsable, sourceType, isFavorite,
        isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID =
            C_MountJournal.GetMountInfoByID(item.extraAttr.id)
        if name then item.extraAttr.name = name end
    elseif item.extraAttr.type == const.ITEM_TYPE.PET then
        local speciesName, speciesIcon, petType, companionID, tooltipSource,
        tooltipDescription, isWild, canBattle, isTradeable, isUnique,
        obtainable, creatureDisplayID =
            C_PetJournal.GetPetInfoBySpeciesID(item.extraAttr.id)
        if speciesName then item.extraAttr.name = speciesName end
    else
    end
end

---------------------------------------------------------
-- 对配置文件进行处理：
-- 1. 本地化处理
-- 2. 按键处理：如果不导入配置则移除配置中的按键设置
---------------------------------------------------------
---@param ele ElementConfig
function Config.HandleConfig(ele)
    if addon.G.tmpImportKeybind == false and ele.bindKey ~= nil then
        ele.bindKey = nil
    end
    if ele.type == const.ELEMENT_TYPE.ITEM then
        local item = E:ToItem(ele)
        Config.UpdateItemLocalizeName(item)
    end
    if ele.elements then
        for _, childEle in ipairs(ele.elements) do
            Config.HandleConfig(childEle)
        end
    end
end

-- 展示导出配置框
---@param exportData string
function Config.ShowExportDialog(exportData)
    local dialog = AceGUI:Create("Window")
    dialog:SetTitle(L["Please copy the configuration to the clipboard."])
    dialog:SetWidth(500)
    dialog:SetHeight(300)
    dialog:SetLayout("Fill")

    local editBox = AceGUI:Create("MultiLineEditBox")
    editBox:SetLabel("")
    editBox:DisableButton(true)
    editBox:SetFullWidth(true)
    editBox:SetFullHeight(true)
    editBox:SetText(exportData)
    editBox:SetCallback("OnEnterPressed",
        function(widget) widget:ClearFocus() end)
    dialog:AddChild(editBox)
end

-- 检查标题是否重复的函数
---@param title string
---@param eleList ElementConfig[]
---@return boolean
function Config.IsTitleDuplicated(title, eleList)
    -- 判断标题是否重复
    for _, ele in pairs(eleList) do
        if ele.title == title then return true end
    end
    return false
end

-- 检查ID是否重复
---@param eleId string
---@param eleList ElementConfig[]
---@return boolean
function Config.IsIdDuplicated(eleId, eleList)
    for _, ele in pairs(eleList) do if ele.id == eleId then return true end end
    return false
end

-- 创建副本标题的函数
---@param title string
---@param eleList ElementConfig[]
---@return string
function Config.CreateDuplicateTitle(title, eleList)
    local count = 1
    local newTitle = title .. " [" .. count .. "]"
    -- 检查新标题是否也重复，如果是则继续递增
    while Config.IsTitleDuplicated(newTitle, eleList) do
        count = count + 1
        newTitle = title .. " [" .. count .. "]"
    end
    return newTitle
end

function Config.GetNewElementTitle(title, elements)
    if Config.IsTitleDuplicated(title, elements) then
        title = Config.CreateDuplicateTitle(title, elements)
    end
    return title
end

---@class ConfigOptions
---@field ElementsOptions function
---@field ConfigOptions function
---@field Options function
local ConfigOptions = {}

---@param elements ElementConfig[]
---@param topEleConfig ElementConfig | nil 顶层的菜单，当为nil的时候，表示当前elements参数本身是顶层菜单
---@param selectGroups table  配置界面选项卡位置
local function GetElementOptions(elements, topEleConfig, selectGroups)
    local settingOrder = 1
    local isRoot = topEleConfig == nil
    local eleArgs = {}
    for i, ele in ipairs(elements) do
        -- 兼容性处理
        if not ele.loadCond then
            ele.loadCond = {
                LoadCond = true
            }
        end
        -- 判断需要触发哪个菜单的更新事件
        local updateFrameConfig
        if topEleConfig ~= nil then
            updateFrameConfig = topEleConfig
        else
            updateFrameConfig = ele
        end
        local copySelectGroups = U.Table.DeepCopyList(selectGroups)
        table.insert(copySelectGroups, "elementMenu" .. i)
        local selectGroupsAfterAddItem = U.Table.DeepCopyList(copySelectGroups)
        table.insert(selectGroupsAfterAddItem,
            "elementMenu" .. (#ele.elements + 1))
        local showTitle = ele.title
        local showIcon = ele.icon or 134400
        if ele.type == const.ELEMENT_TYPE.ITEM then
            local item = E:ToItem(ele)
            if item.extraAttr.name then
                showTitle = item.extraAttr.name
            end
            if item.extraAttr.icon then
                showIcon = item.extraAttr.icon
            end
        end
        local iconPath = "|T" .. showIcon .. ":16|t"

        local args = {}
        --------------------------
        -- 元素设置
        --------------------------
        local elementSettingOrder = 1
        local elementSettingArgs = {}
        local elementSettingOptions = {
            type = "group",
            name = L["Element Settings"],
            order = settingOrder,
            args = elementSettingArgs
        }
        settingOrder = settingOrder + 1
        args.elementSetting = elementSettingOptions
        if ele.type ~= const.ELEMENT_TYPE.ITEM then
            elementSettingArgs.title = {
                order = elementSettingOrder,
                width = 1,
                type = 'input',
                name = L['Element Title'],
                validate = function(_, val)
                    for _i, _ele in ipairs(elements) do
                        if _ele.title == val and i ~= _i then
                            return "repeat title, please input another one."
                        end
                    end
                    return true
                end,
                get = function() return ele.title end,
                set = function(_, val)
                    if val == "" or val == " " then
                        val = nil
                    end
                    ele.title = val
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                    addon:UpdateOptions()
                end
            }
            elementSettingOrder = elementSettingOrder + 1
            elementSettingArgs.icon = {
                order = elementSettingOrder,
                width = 1,
                type = 'input',
                name = L["Element Icon ID or Path"],
                get = function() return ele.icon end,
                set = function(_, val)
                    if val == "" or val == " " then
                        val = nil
                    end
                    ele.icon = val
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                    addon:UpdateOptions()
                end
            }
            elementSettingOrder = elementSettingOrder + 1
        end
        if isRoot then
            elementSettingArgs.iconWidth = {
                step = 1,
                order = elementSettingOrder,
                width = 1,
                type = 'range',
                name = L["Icon Width"],
                min = 24,
                max = 128,
                get = function(_)
                    return ele.iconWidth or addon.G.iconWidth
                end,
                set = function(_, value)
                    ele.iconWidth = value
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                end
            }
            elementSettingOrder = elementSettingOrder + 1
            elementSettingArgs.iconHeight = {
                step = 1,
                order = elementSettingOrder,
                width = 1,
                type = 'range',
                name = L["Icon Height"],
                min = 24,
                max = 128,
                get = function(_)
                    return ele.iconHeight or addon.G.iconHeight
                end,
                set = function(_, value)
                    ele.iconHeight = value
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                end
            }
            elementSettingOrder = elementSettingOrder + 1
        end
        if ele.type ~= const.ELEMENT_TYPE.BAR then
            elementSettingArgs.isShowQualityBorder = {
                order = elementSettingOrder,
                type = 'toggle',
                name = L["Show Item Quality Color"],
                width = 2,
                get = function(_)
                    return ele.isShowQualityBorder
                end,
                set = function(_, val)
                    ele.isShowQualityBorder = val
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                end
            }
            elementSettingOrder = elementSettingOrder + 1
        end
        if ele.type == const.ELEMENT_TYPE.ITEM then
            local item = E:ToItem(ele)
            local extraAttr = item.extraAttr
            if extraAttr.id == nil then
                elementSettingArgs.itemType = {
                    order = elementSettingOrder,
                    type = 'select',
                    name = L["Item Type"],
                    values = const.ItemTypeOptions,
                    set = function(_, val)
                        addon.G.tmpNewItemType = val
                    end,
                    get = function()
                        return addon.G.tmpNewItemType
                    end
                }
                elementSettingOrder = elementSettingOrder + 1
                elementSettingArgs.itemVal = {
                    order = elementSettingOrder,
                    type = 'input',
                    name = L["Item name or item id"],
                    validate = function(_, val)
                        local r = Config.VerifyItemAttr(addon.G.tmpNewItemType,
                            val)
                        if r:is_err() then
                            return r:unwrap_err()
                        else
                            addon.G.tmpNewItem = r:unwrap()
                        end
                        return true
                    end,
                    set = function(_, _)
                        item.extraAttr = U.Table
                            .DeepCopyDict(addon.G.tmpNewItem)
                        HbFrame:ReloadEframeUI(updateFrameConfig)
                        addon.G.tmpNewItemVal = nil
                        addon.G.tmpNewItem = {}
                    end,
                    get = function()
                        return addon.G.tmpNewItemVal
                    end
                }
                elementSettingOrder = elementSettingOrder + 1
            else
                elementSettingArgs.id = {
                    order = elementSettingOrder,
                    width = 1,
                    type = 'input',
                    name = L["ID"],
                    disabled = true,
                    get = function()
                        return tostring(extraAttr.id)
                    end
                }
                elementSettingOrder = elementSettingOrder + 1
                elementSettingArgs.name = {
                    order = elementSettingOrder,
                    width = 1,
                    type = 'input',
                    name = L["Name"],
                    disabled = true,
                    get = function() return extraAttr.name end
                }
                elementSettingOrder = elementSettingOrder + 1
                elementSettingArgs.type = {
                    order = elementSettingOrder,
                    width = 2,
                    type = 'select',
                    name = L["Type"],
                    values = const.ItemTypeOptions,
                    disabled = true,
                    get = function() return extraAttr.type end
                }
                elementSettingOrder = elementSettingOrder + 1
            end
        end
        if isRoot then
            if not E:IsSingleIconConfig(ele) then
                elementSettingArgs.elementsGrowth = {
                    order = elementSettingOrder,
                    width = 2,
                    type = 'select',
                    name = L["Direction of elements growth"],
                    values = const.GrowthOptions,
                    set = function(_, val)
                        ele.elesGrowth = val
                        HbFrame:ReloadEframeUI(updateFrameConfig)
                    end,
                    get = function() return ele.elesGrowth end
                }
                elementSettingOrder = elementSettingOrder + 1
            end
        end
        if ele.type == const.ELEMENT_TYPE.SCRIPT then
            local script = E:ToScript(ele)
            elementSettingArgs.edit = {
                order = elementSettingOrder,
                type = 'input',
                name = L["Script"],
                multiline = 20,
                width = "full",
                validate = function(_, val)
                    local func, loadstringErr = loadstring(val)
                    if not func then
                        local errMsg = L["Illegal script."] .. " " ..
                            loadstringErr
                        U.Print.PrintErrorText(errMsg)
                        return errMsg
                    end
                    local status, pcallErr = pcall(func())
                    if not status then
                        local errMsg = L["Illegal script."] .. " " ..
                            tostring(pcallErr)
                        U.Print.PrintErrorText(errMsg)
                        return errMsg
                    end
                    return true
                end,
                set = function(_, val)
                    script.extraAttr.script = val
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                    addon:UpdateOptions()
                end,
                get = function() return script.extraAttr.script end
            }
            elementSettingOrder = elementSettingOrder + 1
        end
        if ele.type == const.ELEMENT_TYPE.ITEM_GROUP then
            local itemGroup = E:ToItemGroup(ele)
            elementSettingArgs.mode = {
                order = elementSettingOrder,
                width = 2,
                type = 'select',
                name = L["Mode"],
                values = const.ItemsGroupModeOptions,
                set = function(_, val)
                    itemGroup.extraAttr.mode = val
                    HbFrame:UpdateEframe(updateFrameConfig)
                end,
                get = function() return itemGroup.extraAttr.mode end
            }
            elementSettingOrder = elementSettingOrder + 1
            elementSettingOrder = elementSettingOrder + 1
            -- 物品组查看/编辑/删除物品
            elementSettingArgs.itemType = {
                order = elementSettingOrder,
                type = 'select',
                name = L["Item Type"],
                values = const.ItemTypeOptions,
                set = function(_, val)
                    addon.G.tmpNewItemType = val
                end,
                get = function() return addon.G.tmpNewItemType end
            }
            elementSettingOrder = elementSettingOrder + 1
            elementSettingArgs.itemVal = {
                order = elementSettingOrder,
                type = 'input',
                name = L["Item name or item id"],
                validate = function(_, val)
                    local r = Config.VerifyItemAttr(addon.G.tmpNewItemType, val)
                    if r:is_err() then
                        return r:unwrap_err()
                    else
                        addon.G.tmpNewItem = r:unwrap()
                    end
                    return true
                end,
                set = function(_, _)
                    local newElement = E:New(
                        Config.GetNewElementTitle(L["Item"],
                            ele.elements),
                        const.ELEMENT_TYPE.ITEM)
                    local item = E:ToItem(newElement)
                    item.extraAttr = U.Table.DeepCopyDict(addon.G.tmpNewItem)
                    table.insert(ele.elements, item)
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                    itemGroup.extraAttr.configSelectedItemIndex = #itemGroup.elements
                    addon.G.tmpNewItemVal = nil
                    addon.G.tmpNewItem = {}
                end,
                get = function() return addon.G.tmpNewItemVal end
            }
            elementSettingOrder = elementSettingOrder + 1
            local itemsOptions = {} ---@type table<number, ItemConfig>
            if ele.elements then
                for _, _item in ipairs(ele.elements) do
                    local item = E:ToItem(_item)
                    local optionTitle = item.extraAttr.name or item.title or ""
                    local optionIcon = item.extraAttr.icon or item.icon or ""
                    table.insert(itemsOptions, "|T" .. optionIcon .. ":16|t" .. optionTitle)
                end
            end
            elementSettingArgs.selectChildren = {
                order = elementSettingOrder,
                width = 1,
                type = "select",
                name = L["Select Item"],
                values = itemsOptions,
                set = function(_, val)
                    itemGroup.extraAttr.configSelectedItemIndex = val
                end,
                get = function() return itemGroup.extraAttr.configSelectedItemIndex end
            }
            elementSettingOrder = elementSettingOrder + 1
            elementSettingArgs.deleteChildren = {
                order = elementSettingOrder,
                width = 1,
                type = "execute",
                name = L["Delete"],
                confirm = true,
                func = function()
                    table.remove(itemGroup.elements, itemGroup.extraAttr.configSelectedItemIndex)
                    if itemGroup.extraAttr.configSelectedItemIndex > #itemGroup.elements then
                        itemGroup.extraAttr.configSelectedItemIndex = #itemGroup.elements
                    end
                end
            }
            elementSettingArgs.moveUp = {
                order = elementSettingOrder,
                width = 1,
                type = 'execute',
                name = L["Move Up"],
                disabled = function ()
                    return itemGroup.extraAttr.configSelectedItemIndex <= 1
                end,
                func = function()
                    if itemGroup.extraAttr.configSelectedItemIndex > 1 then
                        itemGroup.elements[itemGroup.extraAttr.configSelectedItemIndex], itemGroup.elements[itemGroup.extraAttr.configSelectedItemIndex - 1] = itemGroup.elements[itemGroup.extraAttr.configSelectedItemIndex - 1], itemGroup.elements[itemGroup.extraAttr.configSelectedItemIndex]
                        itemGroup.extraAttr.configSelectedItemIndex = itemGroup.extraAttr.configSelectedItemIndex - 1
                    end
                end
            }
            elementSettingOrder = elementSettingOrder + 1
            elementSettingArgs.moveDown = {
                order = elementSettingOrder,
                width = 1,
                type = 'execute',
                name = L["Move Down"],
                disabled = function ()
                    return itemGroup.extraAttr.configSelectedItemIndex >= #itemGroup.elements
                end,
                func = function()
                    if i < #itemGroup.elements then
                        itemGroup.elements[itemGroup.extraAttr.configSelectedItemIndex], itemGroup.elements[itemGroup.extraAttr.configSelectedItemIndex + 1] = itemGroup.elements[itemGroup.extraAttr.configSelectedItemIndex + 1], itemGroup.elements[itemGroup.extraAttr.configSelectedItemIndex]
                        itemGroup.extraAttr.configSelectedItemIndex = itemGroup.extraAttr.configSelectedItemIndex + 1
                    end
                end
            }
            elementSettingOrder = elementSettingOrder + 1
        end
        -----------------------------------------
        --- 宏条件设置
        -----------------------------------------
        if ele.type == const.ELEMENT_TYPE.MACRO then
            local macro = E:ToMacro(ele)
            elementSettingArgs.edit = {
                order = elementSettingOrder,
                type = 'input',
                name = L["Macro"],
                multiline = 20,
                width = "full",
                validate = function(_, val)
                    local macroAstR = Macro:Ast(val)
                    if macroAstR:is_err() then
                        return macroAstR:unwrap_err()
                    else
                        addon.G.tmpMacroAst = macroAstR:unwrap()
                        return true
                    end
                end,
                set = function(_, val)
                    macro.extraAttr.macro = val
                    macro.extraAttr.ast = U.Table.DeepCopy(addon.G.tmpMacroAst)
                    local events = Macro:GetEventsFromAst(macro.extraAttr.ast)
                    macro.listenEvents = events
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                    addon:UpdateOptions()
                end,
                get = function() return macro.extraAttr.macro end
            }
            elementSettingOrder = elementSettingOrder + 1
        end
        if isRoot then
            local positionSettingOrder = 1
            local positionSettingArgs = {}
            local positionSettingOptions = {
                type = "group",
                name = L["Position Settings"],
                order = settingOrder,
                args = positionSettingArgs
            }
            settingOrder = settingOrder + 1
            args.positionSetting = positionSettingOptions
            positionSettingArgs.attachFrame = {
                order = positionSettingOrder,
                type = 'input',
                name = L["AttachFrame"],
                set = function(_, val)
                    ele.attachFrame = val
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                end,
                get = function()
                    return ele.attachFrame
                end
            }
            positionSettingOrder = positionSettingOrder + 1
            positionSettingArgs.attachFrameOptions = {
                order = positionSettingOrder,
                type = 'select',
                name = "",
                width = 1,
                values = const.AttachFrameOptions,
                set = function(_, val)
                    ele.attachFrame = val
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                end,
                get = function()
                    return ele.attachFrame
                end
            }
            positionSettingOrder = positionSettingOrder + 1
            positionSettingArgs.AnchorPos = {
                order = positionSettingOrder,
                type = 'select',
                name = L["Element Anchor Position"],
                width = 1,
                values = const.AnchorPosOptions,
                set = function(_, val)
                    ele.anchorPos = val
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                end,
                get = function()
                    return ele.anchorPos
                end
            }
            positionSettingOrder = positionSettingOrder + 1
            positionSettingArgs.attachFrameAnchorPos = {
                order = positionSettingOrder,
                type = 'select',
                name = L["AttachFrame Anchor Position"],
                width = 1,
                values = const.AnchorPosOptions,
                set = function(_, val)
                    ele.attachFrameAnchorPos = val
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                end,
                get = function()
                    return ele.attachFrameAnchorPos
                end
            }
            positionSettingOrder = positionSettingOrder + 1
            positionSettingArgs.posX = {
                type = "range",
                name = L["Relative X-Offset"],
                width = 1,
                min = -addon.G.screenWidth,
                max = addon.G.screenWidth,
                step = 1,
                get = function(_)
                    return ele.posX
                end,
                set = function(_, val)
                    ele.posX = val
                    HbFrame:UpdateEframeWindow(updateFrameConfig)
                end,
            }
            positionSettingOrder = positionSettingOrder + 1
            positionSettingArgs.posY = {
                type = "range",
                name = L["Relative Y-Offset"],
                width = 1,
                min = -addon.G.screenHeight,
                max = addon.G.screenHeight,
                step = 1,
                get = function(_)
                    return ele.posY
                end,
                set = function(_, val)
                    ele.posY = val
                    HbFrame:UpdateEframeWindow(updateFrameConfig)
                end,
            }
        end
        -------------------
        -- 基本设置
        ------------------
        local baseSettingOrder = 1
        local baseSettingArgs = {}
        local baseSettingOptions = {
            type = "group",
            name = L["General Settings"],
            order = settingOrder,
            args = baseSettingArgs
        }
        settingOrder = settingOrder + 1
        args.baseSetting = baseSettingOptions
        baseSettingArgs.moveUp = {
            order = baseSettingOrder,
            width = 1,
            type = 'execute',
            name = L["Move Up"],
            disabled = function ()
                return i <= 1
            end,
            func = function()
                if i > 1 then
                    elements[i], elements[i - 1] = elements[i - 1], elements[i]
                end
                local moveUpSelectGroups = U.Table.DeepCopyList(selectGroups)
                table.insert(moveUpSelectGroups, "elementMenu" .. i - 1)
                AceConfigDialog:SelectGroup(addonName, unpack(moveUpSelectGroups))
                HbFrame:ReloadEframeUI(updateFrameConfig)
            end
        }
        baseSettingOrder = baseSettingOrder + 1
        baseSettingArgs.moveDown = {
            order = baseSettingOrder,
            width = 1,
            type = 'execute',
            name = L["Move Down"],
            disabled = function ()
                return i >= #elements
            end,
            func = function()
                if i < #elements then
                    elements[i], elements[i + 1] = elements[i + 1], elements[i]
                end
                local moveDownSelectGroups = U.Table.DeepCopyList(selectGroups)
                table.insert(moveDownSelectGroups, "elementMenu" .. i + 1)
                AceConfigDialog:SelectGroup(addonName, unpack(moveDownSelectGroups))
                HbFrame:ReloadEframeUI(updateFrameConfig)
            end
        }
        baseSettingArgs.moveRoot = {
            order = baseSettingOrder,
            width = 1,
            type = 'execute',
            name = L["Move Top Level"],
            disabled = function ()
                return isRoot == true
            end,
            func = function()
                if isRoot == false then
                    table.remove(elements, i)
                    table.insert(addon.db.profile.elements, ele)
                    AceConfigDialog:SelectGroup(addonName, "element", "elementMenu" .. #addon.db.profile.elements)
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                end
            end
        }
        baseSettingOrder = baseSettingOrder + 1
        local childEleOptions = {}
        for _, _ele in ipairs(elements) do
            if _ele.type == const.ELEMENT_TYPE.BAR then
                childEleOptions[_] = E:GetTitleWithIcon(_ele)
            end
        end
        baseSettingArgs.moveTo = {
            order = baseSettingOrder,
            width = 1,
            name = L["Move Down Level"],
            type = "select",
            values = childEleOptions,
            set = function(_, val)
                table.insert(elements[val].elements, ele)
                local moveToSelectGroups = U.Table.DeepCopyList(selectGroups)
                table.insert(moveToSelectGroups, "elementMenu" .. val)
                table.insert(moveToSelectGroups, "elementMenu" .. #(elements[val].elements))
                table.remove(elements, i)
                if topEleConfig == nil then
                    HbFrame:DeleteEframe(ele)
                    HbFrame:ReloadEframeUI(elements[val])
                else
                    HbFrame:ReloadEframeUI(topEleConfig)
                end
                AceConfigDialog:SelectGroup(addonName, unpack(moveToSelectGroups))
            end
        }
        baseSettingOrder = baseSettingOrder + 1
        baseSettingArgs.delete = {
            order = baseSettingOrder,
            width = 1,
            type = 'execute',
            name = L["Delete"],
            confirm = true,
            func = function()
                table.remove(elements, i)
                if topEleConfig == nil then
                    HbFrame:DeleteEframe(ele)
                else
                    HbFrame:ReloadEframeUI(topEleConfig)
                end
                AceConfigDialog:SelectGroup(addonName, unpack(selectGroups))
            end
        }
        baseSettingOrder = baseSettingOrder + 1
        baseSettingArgs.export = {
            order = baseSettingOrder,
            width = 1,
            type = 'execute',
            name = L['Export'],
            func = function()
                local serializedData = AceSerializer:Serialize(ele)
                local compressedData =
                    LibDeflate:CompressDeflate(serializedData)
                local base64Encoded = LibDeflate:EncodeForPrint(compressedData)
                Config.ShowExportDialog(base64Encoded)
            end
        }
        baseSettingOrder = baseSettingOrder + 1

        ---------------------------------------------------------
        -- 按键绑定设置
        ---------------------------------------------------------
        if E:IsSingleIconConfig(ele) then
            local bindkeySettingOrder = 1
            local bindkeySettingArgs = {}
            local bindkeySettingOptions = {
                type = "group",
                name = L["Bindkey Settings"],
                order = settingOrder,
                args = bindkeySettingArgs
            }
            settingOrder = settingOrder + 1
            args.bindkeySetting = bindkeySettingOptions
            bindkeySettingArgs.bindKey = {
                order = bindkeySettingOrder,
                type = "keybinding",
                name = L["Bindkey"],
                width = 1,
                get = function()
                    if ele.bindKey == nil then
                        return nil
                    end
                    return ele.bindKey.key
                end,
                set = function(_, key)
                    if key == nil or key == "" then
                        ele.bindKey = nil
                    else
                        if ele.bindKey == nil then
                            ele.bindKey = {key = key, characters = {}, classes = {}}  -- 默认选择不给任何角色绑定，防止误操作导致绑定到全部的角色上。
                        else
                            ele.bindKey.key = key
                        end
                    end
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                end
            }
            bindkeySettingOrder = bindkeySettingOrder + 1
            if ele.bindKey then
                bindkeySettingArgs.bindAccount = {
                    order = bindkeySettingOrder,
                    type = "toggle",
                    name = L["Bind For Account"],
                    width = 1,
                    set = function(_, val)
                        if val == true then
                            if ele.bindKey then
                                ele.bindKey.characters = nil
                                ele.bindKey.classes = nil
                            end
                        else
                            if ele.bindKey then
                                ele.bindKey.characters = {}
                                ele.bindKey.classes = {}
                            end
                        end
                        HbFrame:ReloadEframeUI(updateFrameConfig)
                    end,
                    get = function(_)
                        if ele.bindKey then
                            if ele.bindKey.characters == nil and ele.bindKey.classes == nil then
                                return true
                            end
                        else
                            return true
                        end
                    end
                }
                bindkeySettingOrder = bindkeySettingOrder + 1
            end
            if ele.bindKey and ele.bindKey.characters ~= nil then
                bindkeySettingArgs.bindCharacter = {
                    order = bindkeySettingOrder,
                    type = "toggle",
                    name = L["Bind For Current Character"],
                    width = 1,
                    set = function(_, val)
                        if val == true then
                            if ele.bindKey then
                                if ele.bindKey.characters == nil then
                                    ele.bindKey.characters = {}
                                end
                                ele.bindKey.characters[UnitGUID("player")] = true
                            end
                        else
                            if ele.bindKey and ele.bindKey.characters then
                                ele.bindKey.characters[UnitGUID("player")] = nil
                            end
                        end
                        HbFrame:ReloadEframeUI(updateFrameConfig)
                    end,
                    get = function(_)
                        if ele.bindKey and ele.bindKey.characters then
                            return ele.bindKey.characters[UnitGUID("player")]
                        end
                    end
                }
                bindkeySettingOrder = bindkeySettingOrder + 1
            end
            if ele.bindKey and ele.bindKey.classes ~= nil then
                local _, classId = UnitClassBase("player")
                bindkeySettingArgs.bindClass = {
                    order = bindkeySettingOrder,
                    type = "toggle",
                    name = L["Bind For Current Class"],
                    width = 1,
                    set = function(_, val)
                        if val == true then
                            if ele.bindKey then
                                if ele.bindKey.classes == nil then
                                    ele.bindKey.classes = {}
                                end
                                ele.bindKey.classes[classId] = true
                            end
                        else
                            if ele.bindKey and ele.bindKey.classes then
                                ele.bindKey.classes[classId] = nil
                            end
                        end
                        HbFrame:ReloadEframeUI(updateFrameConfig)
                    end,
                    get = function(_)
                        if ele.bindKey and ele.bindKey.classes then
                            return ele.bindKey.classes[classId]
                        end
                    end
                }
                bindkeySettingOrder = bindkeySettingOrder + 1
            end
            if ele.bindKey then
                bindkeySettingArgs.loadCondCombat = {
                    order = bindkeySettingOrder,
                    width = ele.bindKey.combat and 1 or "full",
                    type = 'toggle',
                    name = L["Combat Load Condition"],
                    set = function(_, val)
                        if val == true then
                            ele.bindKey.combat = true
                        else
                            ele.bindKey.combat = nil
                        end
                        HbFrame:UpdateEframe(updateFrameConfig)
                    end,
                    get = function(_)
                        return ele.bindKey.combat ~= nil
                    end
                }
                bindkeySettingOrder = bindkeySettingOrder + 1
                if ele.bindKey.combat ~= nil then
                    bindkeySettingArgs.loadCondCombatOptions = {
                        order = bindkeySettingOrder,
                        width = 1,
                        type = 'select',
                        values = const.LoadCondCombatOptions,
                        name = "",
                        set = function(_, val)
                            ele.bindKey.combat = val
                            HbFrame:UpdateEframe(updateFrameConfig)
                        end,
                        get = function(_)
                            return ele.bindKey.combat
                        end
                    }
                    bindkeySettingOrder = bindkeySettingOrder + 1
                end
                bindkeySettingArgs.loadAttachFrameShow = {
                    order = bindkeySettingOrder,
                    width = ele.bindKey.attachFrame and 1 or "full",
                    type = 'toggle',
                    name = L["AttachFrame Load Condition"],
                    desc = L["Not working when in combat"],
                    set = function(_, val)
                        if val == true then
                            ele.bindKey.attachFrame = true
                        else
                            ele.bindKey.attachFrame = nil
                        end
                        HbFrame:UpdateEframe(updateFrameConfig)
                    end,
                    get = function(_)
                        return ele.bindKey.attachFrame ~= nil
                    end
                }
                bindkeySettingOrder = bindkeySettingOrder + 1
                if ele.bindKey.attachFrame ~= nil then
                    bindkeySettingArgs.loadCondAttachFrameOptions = {
                        order = bindkeySettingOrder,
                        width = 1,
                        type = 'select',
                        values = const.LoadCondAttachFrameOptions,
                        name = "",
                        set = function(_, val)
                            ele.bindKey.attachFrame = val
                            HbFrame:UpdateEframe(updateFrameConfig)
                        end,
                        get = function(_)
                            return ele.bindKey.attachFrame
                        end
                    }
                    bindkeySettingOrder = bindkeySettingOrder + 1
                end
            end
            bindkeySettingArgs.reloadDesc1 = {
                order = bindkeySettingOrder,
                width = "full",
                type = "description",
                name = "\n",
            }
            bindkeySettingOrder = bindkeySettingOrder + 1
            bindkeySettingArgs.reloadDesc2 = {
                order = bindkeySettingOrder,
                width = "full",
                type = "description",
                name = L["The newly created button do not immediately respond to key bindings and require executing the /reload command."],
            }
            bindkeySettingOrder = bindkeySettingOrder + 1
        end
        local displaySettingOrder = 1
        local displaySettingArgs = {}
        local displaySettingOptions = {
            type = "group",
            name = L["Display Rule"],
            order = settingOrder,
            args = displaySettingArgs
        }
        settingOrder = settingOrder + 1
        args.displaySetting = displaySettingOptions
        displaySettingOrder = displaySettingOrder + 1
        if isRoot then
            displaySettingArgs.isDisplayMouseEnter = {
                order = displaySettingOrder,
                width = 2,
                type = 'toggle',
                name = L["Whether to show the bar menu when the mouse enter."],
                set = function(_, val)
                    ele.isDisplayMouseEnter = val
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                end,
                get = function(_) return ele.isDisplayMouseEnter end
            }
            displaySettingOrder = displaySettingOrder + 1
        end

        -- 支持根元素和🍃叶子元素设置加载条件，根元素加载条件在Cbs获取的时候判断，叶子元素在cbResult的时候判断
        if isRoot or E:IsLeaf(ele) then
            displaySettingArgs.isLoadToggle = {
                order = displaySettingOrder,
                width = 2,
                type = 'toggle',
                name = L["Load"],
                set = function(_, val)
                    ele.loadCond.LoadCond = val
                    if ele.loadCond.LoadCond == true then
                        if isRoot then
                            HbFrame:AddEframe(updateFrameConfig)
                        else
                            HbFrame:ReloadEframeUI(updateFrameConfig)
                        end
                    else
                        if isRoot then
                            HbFrame:DeleteEframe(updateFrameConfig)
                        else
                            HbFrame:ReloadEframeUI(updateFrameConfig)
                        end
                    end
                end,
                get = function(_) return ele.loadCond.LoadCond end
            }
        end
        -- 顶部元素设置是否开启战斗支持
        if isRoot then
            displaySettingArgs.loadCondCombat = {
                order = displaySettingOrder,
                width = 1,
                type = 'toggle',
                name = L["Combat Load Condition"],
                set = function(_, val)
                    if val == true then
                        ele.loadCond.CombatCond = true
                    else
                        ele.loadCond.CombatCond = nil
                    end
                    HbFrame:UpdateEframe(updateFrameConfig)
                end,
                get = function(_)
                    return ele.loadCond.CombatCond ~= nil
                end
            }
            displaySettingOrder = displaySettingOrder + 1
            if ele.loadCond.CombatCond ~= nil then
                displaySettingArgs.loadCondCombatOptions = {
                    order = displaySettingOrder,
                    width = 1,
                    type = 'select',
                    values = const.LoadCondCombatOptions,
                    name = "",
                    set = function(_, val)
                        ele.loadCond.CombatCond = val
                        HbFrame:UpdateEframe(updateFrameConfig)
                    end,
                    get = function(_)
                        return ele.loadCond.CombatCond
                    end
                }
                displaySettingOrder = displaySettingOrder + 1
            end
        end
        -- 加载选项：职业
        displaySettingArgs.borderGlowStatus = {
            order = displaySettingOrder,
            width = 2,
            type = 'toggle',
            name = L["Enable Class Settings"] ,
            set = function(_, val)
                if val == false then
                    ele.loadCond.ClassCond = nil
                else
                    ele.loadCond.ClassCond = {}
                end
                HbFrame:ReloadEframeUI(updateFrameConfig)
            end,
            get = function(_)
                return ele.loadCond.ClassCond ~= nil
            end
        }
        displaySettingOrder = displaySettingOrder + 1
        if ele.loadCond.ClassCond ~= nil then
            displaySettingArgs.selectClasses = {
                order = displaySettingOrder,
                width = 2,
                type = "multiselect",
                name = "",
                values = const.ClassOptions,
                get = function(_, key)
                    if ele.loadCond.ClassCond then
                        for _, class in ipairs(ele.loadCond.ClassCond) do
                            if class == key then
                                return true
                            end
                        end
                    end
                    return false
                end,
                set = function(_, key, value)
                    if value == true then
                        if ele.loadCond.ClassCond then
                            if not U.Table.IsInArray(ele.loadCond.ClassCond, key) then
                                table.insert(ele.loadCond.ClassCond, key)
                            end
                        end
                    else
                        if ele.loadCond.ClassCond then
                            local index = U.Table.GetArrayIndex(ele.loadCond.ClassCond, key)
                            if index ~= 0 then
                                table.remove(ele.loadCond.ClassCond, index)
                            end
                        end
                    end
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                end,
            }
            displaySettingOrder = displaySettingOrder + 1
        end
        -- 文字设置：根元素或者叶子元素可以使用
        if isRoot or E:IsLeaf(ele) then
            local textSettingOrder = 1
            local textSettingArgs = {}
            local textSettingOptions = {
                type = "group",
                name = L["Text Settings"],
                order = settingOrder,
                args = textSettingArgs
            }
            settingOrder = settingOrder + 1
            args.textSetting = textSettingOptions
            if (not isRoot) and E:IsLeaf(ele) then
                textSettingArgs.useParentSettingToggle = {
                    order = textSettingOrder,
                    width = 2,
                    type = 'toggle',
                    name = L["Use root element settings"],
                    set = function(_, val)
                        ele.isUseRootTexts = val
                        HbFrame:UpdateEframe(updateFrameConfig)
                    end,
                    get = function(_)
                        return ele.isUseRootTexts == true
                    end
                }
                textSettingOrder = textSettingOrder + 1
            end
            if isRoot or (E:IsLeaf(ele) and ele.isUseRootTexts == false) then
                textSettingArgs.TextOfNameToogle = {
                    order = textSettingOrder,
                    width = 1,
                    type = 'toggle',
                    name = L["Item Name"],
                    set = function(_, _)
                        for tIndex, text in ipairs(ele.texts) do
                            if text.text == "%n" then
                                table.remove(ele.texts, tIndex)
                                HbFrame:UpdateEframe(updateFrameConfig)
                                return
                            end
                        end
                        table.insert(ele.texts, Text:New("%n"))
                        HbFrame:UpdateEframe(updateFrameConfig)
                    end,
                    get = function(_)
                        if ele.texts == nil then
                            ele.texts = {}
                        end
                        for _, text in ipairs(ele.texts) do
                            if text.text == "%n" then
                                return true
                            end
                        end
                        return false
                    end
                }
                textSettingOrder = textSettingOrder + 1
                textSettingArgs.TextOfCountToogle = {
                    order = textSettingOrder,
                    width = 1,
                    type = 'toggle',
                    name = L["Item Count"],
                    set = function(_, _)
                        for tIndex, text in ipairs(ele.texts) do
                            if text.text == "%s" then
                                table.remove(ele.texts, tIndex)
                                HbFrame:UpdateEframe(updateFrameConfig)
                                return
                            end
                        end
                        table.insert(ele.texts, Text:New("%s"))
                        HbFrame:UpdateEframe(updateFrameConfig)
                    end,
                    get = function(_)
                        if ele.texts == nil then
                            ele.texts = {}
                        end
                        for _, text in ipairs(ele.texts) do
                            if text.text == "%s" then
                                return true
                            end
                        end
                        return false
                    end
                }
                textSettingOrder = textSettingOrder + 1
            end
        end

        -- 触发器设置：叶子元素可以使用
        if E:IsLeaf(ele) then
            local triggerSettingOrder = 1
            local triggerSettingArgs = {}
            local triggerSettingOptions = {
                type = "group",
                name = L["Trigger Settings"],
                order = settingOrder,
                args = triggerSettingArgs
            }
            settingOrder = settingOrder + 1
            args.triggerSetting = triggerSettingOptions
            local triggerOptions = {}
            if ele.triggers then
                for triggerIndex, trigger in ipairs(ele.triggers) do
                    table.insert(triggerOptions, L["Trigger"] .. triggerIndex .. ": "  .. Trigger:GetTriggerName(trigger.type))
                end
            end
            if #triggerOptions > 0 then
                triggerSettingArgs.selectTrigger = {
                    order = triggerSettingOrder,
                    width = 1,
                    type = "select",
                    name = "",
                    values = triggerOptions,
                    set = function(_, val)
                        ele.configSelectedTriggerIndex = val
                    end,
                    get = function() return ele.configSelectedTriggerIndex end
                }
                triggerSettingOrder = triggerSettingOrder + 1
                triggerSettingArgs.deleteTrigger = {
                    order = triggerSettingOrder,
                    width = 0.5,
                    type = "execute",
                    name = L["Delete"],
                    confirm = true,
                    func = function()
                        if ele.configSelectedTriggerIndex then
                            table.remove(ele.triggers, ele.configSelectedTriggerIndex)
                            if ele.configSelectedTriggerIndex > #ele.triggers then
                                ele.configSelectedTriggerIndex = #ele.triggers
                            end
                            HbFrame:UpdateEframe(updateFrameConfig)
                            addon:UpdateOptions()
                        end
                    end
                }
                triggerSettingOrder = triggerSettingOrder + 1
            end
            triggerSettingArgs.addTrigger = {
                order = triggerSettingOrder,
                width = 0.5,
                type = "execute",
                name = L["New"],
                func = function()
                    local trigger = Trigger:NewItemTriggerConfig()
                    if ele.triggers == nil then
                        ele.triggers = {}
                    end
                    table.insert(ele.triggers, trigger)
                    ele.configSelectedTriggerIndex = #ele.triggers
                    HbFrame:UpdateEframe(updateFrameConfig)
                    addon:UpdateOptions()
                end
            }
            triggerSettingOrder = triggerSettingOrder + 1
            local editTrigger
            if ele.configSelectedTriggerIndex then
                editTrigger = ele.triggers[ele.configSelectedTriggerIndex]
            end
            if editTrigger then
                triggerSettingArgs.selectType = {
                    order = triggerSettingOrder,
                    width = 2,
                    type = "select",
                    name = L["Select Trigger Type"],
                    values = const.TriggerTypeOptions,
                    set = function(_, val)
                        -- 当选择的触发器类型和当前触发器类型不一致的时候，重新设置触发器类型，并且需要删除之前触发器设置的条件和限制
                        if val ~= editTrigger.type then
                            editTrigger.type = val
                            editTrigger.condition = {}
                            editTrigger.confine = {}
                        end
                    end,
                    get = function() return editTrigger.type end
                }
                triggerSettingOrder = triggerSettingOrder + 1
            end
            if editTrigger and editTrigger.type == "self" then
                local trigger = Trigger:ToSelfTriggerConfig(editTrigger)
            end
            if editTrigger and editTrigger.type == "aura" then
                local trigger = Trigger:ToAuraTriggerConfig(editTrigger)
                triggerSettingArgs.selectAuraType = {
                    order = triggerSettingOrder,
                    width = 1,
                    type = "select",
                    name = L["Select Aura Type"],
                    values = const.AuraTypeOptions,
                    set = function(_, val)
                        trigger.confine.type = val
                    end,
                    get = function() return trigger.confine.type end
                }
                triggerSettingOrder = triggerSettingOrder + 1
                triggerSettingArgs.selectAuraTarget = {
                    order = triggerSettingOrder,
                    width = 1,
                    type = "select",
                    name = L["Select Target"],
                    values = const.TriggerTargetOptions,
                    set = function(_, val)
                        trigger.confine.target = val
                    end,
                    get = function() return trigger.confine.target end
                }
                triggerSettingOrder = triggerSettingOrder + 1
                triggerSettingArgs.auraID = {
                    order = triggerSettingOrder,
                    width = 1,
                    type = "input",
                    name = L["Aura ID"] ,
                    validate = function(_, val)
                        if val == nil or val == "" or val == " " then
                            return false
                        end
                        if tonumber(val) == nil then
                            return false
                        end
                        return true
                    end,
                    set = function(_, val)
                        trigger.confine.spellId = tonumber(val)
                        HbFrame:UpdateEframe(updateFrameConfig)
                        addon:UpdateOptions()
                    end,
                    get = function()
                        if trigger.confine.spellId == nil then
                            return ""
                        else
                            return tostring(trigger.confine.spellId)
                        end
                    end
                }
                triggerSettingOrder = triggerSettingOrder + 1
                local iconPath = 134400
                if trigger.confine.spellId then
                    iconPath = Api.GetSpellTexture(trigger.confine.spellId)
                end
                triggerSettingArgs.auraIconId = {
                    order = triggerSettingOrder,
                    width = 1,
                    type = "description",
                    name = "|T" .. iconPath .. ":16|t"
                }
                triggerSettingOrder = triggerSettingOrder + 1
            end
            if editTrigger and editTrigger.type == "item" then
                local trigger = Trigger:ToItemTriggerConfig(editTrigger)
                triggerSettingArgs.itemTriggeritemType = {
                    order = triggerSettingOrder,
                    type = 'select',
                    name = L["Item Type"],
                    values = const.ItemTypeOptions,
                    set = function(_, val)
                        if trigger.confine.item == nil then
                            trigger.confine.item = {}
                        end
                        trigger.confine.item.type = val
                    end,
                    get = function()
                        if trigger.confine and trigger.confine.item then
                            return trigger.confine.item.type
                        end
                        return nil
                    end
                }
                triggerSettingOrder = triggerSettingOrder + 1
                triggerSettingArgs.itemTriggeritemVal = {
                    order = triggerSettingOrder,
                    type = 'input',
                    name = L["Item name or item id"],
                    validate = function(_, val)
                        local r = Config.VerifyItemAttr(trigger.confine.item.type, val)
                        if r:is_err() then
                            return r:unwrap_err()
                        else
                            addon.G.tmpNewItem = r:unwrap()
                        end
                        return true
                    end,
                    set = function(_, _)
                        trigger.confine.item = U.Table.DeepCopyDict(addon.G.tmpNewItem)
                        HbFrame:ReloadEframeUI(updateFrameConfig)
                        addon.G.tmpNewItemVal = nil
                        addon.G.tmpNewItem = {}
                    end,
                    get = function()
                        if trigger.confine and trigger.confine.item and trigger.confine.item.name then
                            local itemTriggerCconPath = 134400 ---@type string | number
                            if trigger.confine.item.icon then
                                itemTriggerCconPath = trigger.confine.item.icon
                            end
                            return "|T" .. itemTriggerCconPath .. ":16|t" .. trigger.confine.item.name
                        end
                        return nil
                    end
                }
                triggerSettingOrder = triggerSettingOrder + 1
            end
        end

        -- 触发器条件设置：叶子元素可以使用
        if E:IsLeaf(ele) then
            local condGroupSettingOrder = 1
            local condGroupSettingArgs = {}
            local condGroupSettingOptions = {
                type = "group",
                name = L["Condition Group Settings"],
                order = settingOrder,
                args = condGroupSettingArgs
            }
            settingOrder = settingOrder + 1
            args.condGroupSetting = condGroupSettingOptions
            local triggerOptions = {}
            if ele.triggers and #ele.triggers > 0 then
                for k, t in ipairs(ele.triggers) do
                    if t and t.id then
                        triggerOptions[t.id] = L["Trigger"] .. tostring(k) .. ": "  .. Trigger:GetTriggerName(t.type)
                    end
                end
            end
            local condGroupOptions = {}
            if ele.condGroups then
                for condIndex, _ in ipairs(ele.condGroups) do
                    table.insert(condGroupOptions, L["Condition Group"] .. condIndex)
                end
            end
            if #condGroupOptions > 0 then
                condGroupSettingArgs.selectCondGroup = {
                    order = condGroupSettingOrder,
                    width = 1,
                    type = "select",
                    name = "",
                    values = condGroupOptions,
                    set = function(_, val)
                        ele.configSelectedCondGroupIndex = val
                    end,
                    get = function() return ele.configSelectedCondGroupIndex end
                }
                condGroupSettingOrder = condGroupSettingOrder + 1
                condGroupSettingArgs.deleteCondGroup = {
                    order = condGroupSettingOrder,
                    width = 0.5,
                    type = "execute",
                    name = L["Delete"],
                    confirm = true,
                    func = function()
                        if ele.configSelectedCondGroupIndex then
                            table.remove(ele.condGroups, ele.configSelectedCondGroupIndex)
                            if ele.configSelectedCondGroupIndex > #ele.condGroups then
                                ele.configSelectedCondGroupIndex = #ele.condGroups
                            end
                            HbFrame:UpdateEframe(updateFrameConfig)
                            addon:UpdateOptions()
                        end
                    end
                }
                condGroupSettingOrder = condGroupSettingOrder + 1
            end
            condGroupSettingArgs.addCondGroup = {
                order = condGroupSettingOrder,
                width = 0.5,
                type = "execute",
                name = L["New"],
                func = function()
                    local conditionGroup = Condition:NewGroup()
                    if ele.condGroups == nil then
                        ele.condGroups = {}
                    end
                    table.insert(ele.condGroups, conditionGroup)
                    ele.configSelectedCondGroupIndex = #ele.condGroups
                    HbFrame:UpdateEframe(updateFrameConfig)
                    addon:UpdateOptions()
                end
            }
            condGroupSettingOrder = condGroupSettingOrder + 1
            local editCondGroup
            if ele.configSelectedCondGroupIndex then
                editCondGroup = ele.condGroups[ele.configSelectedCondGroupIndex]
            end
            if editCondGroup then
                local condSettingOrder = 1
                local condSettingArgs = {}
                local condSettingOptions = {
                    type = "group",
                    name = L["Condition Settings"],
                    inline = true,
                    order = condGroupSettingOrder,
                    args = condSettingArgs
                }
                condGroupSettingArgs.condSetting = condSettingOptions
                condGroupSettingOrder = condGroupSettingOrder + 1
                local editConds = editCondGroup.conditions
                if editConds and #editConds > 0 then
                    local condOptions = {}
                    for condIndex, _ in ipairs(editConds) do
                        table.insert(condOptions, L["Condition"] .. condIndex)
                    end
                    condSettingArgs.selectCond = {
                        order = condSettingOrder,
                        width = 1,
                        type = "select",
                        name = "",
                        values = condOptions,
                        set = function(_, val)
                            ele.configSelectedCondIndex = val
                        end,
                        get = function() return ele.configSelectedCondIndex end
                    }
                    condSettingOrder = condSettingOrder + 1
                    condSettingArgs.deleteCond = {
                        order = condSettingOrder,
                        width = 0.5,
                        type = "execute",
                        name = L["Delete"],
                        confirm = true,
                        func = function()
                            if ele.configSelectedCondIndex then
                                table.remove(editConds, ele.configSelectedCondIndex)
                                if ele.configSelectedCondIndex > #editConds then
                                    ele.configSelectedCondIndex = #editConds
                                end
                                HbFrame:UpdateEframe(updateFrameConfig)
                                addon:UpdateOptions()
                            end
                        end
                    }
                    condSettingArgs.addCond = {
                        order = condSettingOrder,
                        width = 0.5,
                        type = "execute",
                        name = L["New"],
                        disabled = function ()
                            return #editConds >= 3
                        end,
                        func = function()
                            local condition = Condition:NewCondition()
                            if editConds == nil then
                                editConds = {}
                            end
                            table.insert(editConds, condition)
                            ele.configSelectedCondIndex = #editConds
                            HbFrame:UpdateEframe(updateFrameConfig)
                            addon:UpdateOptions()
                        end
                    }
                    condSettingOrder = condSettingOrder + 1
                    local editCond
                    if ele.configSelectedCondIndex then
                        editCond = editConds[ele.configSelectedCondIndex]
                    end
                    if editCond then
                        condSettingArgs.selectLeftTrigger = {
                            order = condSettingOrder,
                            width = 1,
                            type = "select",
                            name = L["Left Value Settings"],
                            values = triggerOptions,
                            set = function(_, val)
                                editCond.leftTriggerId = val
                                HbFrame:UpdateEframe(updateFrameConfig)
                                addon:UpdateOptions()
                            end,
                            get = function()
                                return editCond.leftTriggerId
                            end
                        }
                        condSettingOrder = condSettingOrder + 1
                        local leftValOptions = {}
                        local leftValTypes = {}
                        if ele.triggers then
                            for _, t in ipairs(ele.triggers) do
                                if t.id == editCond.leftTriggerId then
                                    if t.type then
                                        leftValTypes = Trigger:GetConditions(t.type)
                                        leftValOptions = Trigger:GetConditionsOptions(t.type)
                                    end
                                end
                            end
                        end
                        condSettingArgs.leftVal = {
                            order = condSettingOrder,
                            width = 1,
                            type = "select",
                            name = "",
                            values = leftValOptions,
                            set = function(_, val)
                                editCond.leftVal = val
                                HbFrame:UpdateEframe(updateFrameConfig)
                                addon:UpdateOptions()
                            end,
                            get = function() return editCond.leftVal end
                        }
                        condSettingOrder = condSettingOrder + 1
                        condSettingArgs.operate = {
                            order = condSettingOrder,
                            width = 1,
                            type = "select",
                            name = L["Operate"],
                            values = const.OperateOptions,
                            set = function(_, val)
                                editCond.operator = val
                                HbFrame:UpdateEframe(updateFrameConfig)
                                addon:UpdateOptions()
                            end,
                            get = function() return editCond.operator end
                        }
                        condSettingOrder = condSettingOrder + 1
                        -- 获取触发器对于条件设置的值，根据值来获取值的类型：是数字类型还是布尔类型，根据类型来选择右值如何选择。
                        local leftValType = nil
                        if leftValTypes and leftValTypes[editCond.leftVal] then
                            ---@type type
                            leftValType = leftValTypes[editCond.leftVal]
                        end
                        if leftValType == "boolean" then
                            condSettingArgs.rightValue = {
                                order = condSettingOrder,
                                width = 1,
                                type = "select",
                                name = L["Right Value Settings"] ,
                                values = const.BooleanOptions,
                                set = function(_, val)
                                    editCond.rightValue = val
                                    HbFrame:UpdateEframe(updateFrameConfig)
                                    addon:UpdateOptions()
                                end,
                                get = function() return editCond.rightValue end
                            }
                        else
                            condSettingArgs.rightValue = {
                                order = condSettingOrder,
                                width = 1,
                                type = "input",
                                name = L["Right Value Settings"] ,
                                validate = function(_, val)
                                    if val == nil or val == "" or val == " " then
                                        return false
                                    end
                                    if tonumber(val) == nil then
                                        return false
                                    end
                                    return true
                                end,
                                set = function(_, val)
                                    editCond.rightValue = tonumber(val)
                                    HbFrame:UpdateEframe(updateFrameConfig)
                                    addon:UpdateOptions()
                                end,
                                get = function()
                                    if editCond.rightValue == nil then
                                        return ""
                                    else
                                        return tostring(editCond.rightValue)
                                    end
                                end
                            }
                        end
                        condSettingOrder = condSettingOrder + 1
                    end
                else
                    condSettingArgs.addCond = {
                        order = condSettingOrder,
                        width = 0.5,
                        type = "execute",
                        name = L["New"],
                        disabled = function ()
                            return #editConds >= 3
                        end,
                        func = function()
                            local condition = Condition:NewCondition()
                            if editConds == nil then
                                editConds = {}
                            end
                            table.insert(editConds, condition)
                            ele.configSelectedCondIndex = #editConds
                            HbFrame:UpdateEframe(updateFrameConfig)
                            addon:UpdateOptions()
                        end
                    }
                    condSettingOrder = condSettingOrder + 1
                end
                --[[
                表达式设置
                ]]
                local exprSettingOptions = {
                    type = "group",
                    name = L["Expression Settings"],
                    inline = true,
                    order = condGroupSettingOrder,
                    args = {
                        expr = {
                            order = condSettingOrder,
                            width = 2,
                            type = "select",
                            name = "",
                            values = const.CondExpressionOptions,
                            set = function(_, val)
                                editCondGroup.expression = val
                                HbFrame:ReloadEframeUI(updateFrameConfig)
                            end,
                            get = function() return editCondGroup.expression end
                        }
                    }
                }
                condGroupSettingArgs.exprSetting = exprSettingOptions
                condGroupSettingOrder = condGroupSettingOrder + 1

                --[[
                效果设置：目前只支持边框发光效果、图标褪色效果、隐藏图标
                ]]
                if editCondGroup.effects == nil then
                    editCondGroup.effects = {}
                end
                local effectSettingArgs = {}
                local effectSettingOrder = 1

                ---@param effectName EffectType
                ---@return nil | EffectConfig
                local function GetEffect(effectName)
                    for _, effect in ipairs(editCondGroup.effects) do
                        if effect.type == effectName then
                            return effect
                        end
                    end
                    return nil
                end

                ---@param effectName EffectType
                local function GetWidth(effectName)
                    local effect = GetEffect(effectName)
                    if effect and effect.status ~= nil then
                        return 1
                    else
                        return 2
                    end
                end

                local borderGlow = GetEffect("borderGlow")
                effectSettingArgs.borderGlowStatus = {
                    order = effectSettingOrder,
                    width = GetWidth("borderGlow"),
                    type = 'toggle',
                    name = L["Border Glow"],
                    set = function(_, val)
                        if borderGlow == nil then
                            borderGlow = Effect:NewBorderGlowEffect()
                            if val == true then
                                borderGlow.status = true
                            else
                                borderGlow.status = nil
                            end
                            table.insert(editCondGroup.effects, borderGlow)
                        else
                            if val == true then
                                borderGlow.status = true
                            else
                                borderGlow.status = nil
                            end
                        end
                        HbFrame:ReloadEframeUI(updateFrameConfig)
                    end,
                    get = function(_)
                        if borderGlow and borderGlow.status ~= nil then
                            return true
                        end
                        return false
                    end
                }
                effectSettingOrder = effectSettingOrder + 1
                if borderGlow and borderGlow.status ~= nil then
                    effectSettingArgs.borderGlow = {
                        order = effectSettingOrder,
                        width = 1,
                        type = "select",
                        name = "",
                        values = const.OpenEffectOptions,
                        set = function(_, val)
                            borderGlow.status = val
                            HbFrame:ReloadEframeUI(updateFrameConfig)
                        end,
                        get = function()
                            return borderGlow.status
                        end
                    }
                end
                effectSettingOrder = effectSettingOrder + 1

                local btnHide = GetEffect("btnHide")
                effectSettingArgs.btnHideStatus = {
                    order = effectSettingOrder,
                    width = GetWidth("btnHide"),
                    type = 'toggle',
                    name = L["Btn Hide"],
                    set = function(_, val)
                        if btnHide == nil then
                            btnHide = Effect:NewBtnHideEffect()
                            if val == true then
                                btnHide.status = true
                            else
                                btnHide.status = nil
                            end
                            table.insert(editCondGroup.effects, btnHide)
                        else
                            if val == true then
                                btnHide.status = true
                            else
                                btnHide.status = nil
                            end
                        end
                        HbFrame:ReloadEframeUI(updateFrameConfig)
                    end,
                    get = function(_)
                        if btnHide and btnHide.status ~= nil then
                            return true
                        end
                        return false
                    end
                }
                effectSettingOrder = effectSettingOrder + 1
                if btnHide and btnHide.status ~= nil then
                    effectSettingArgs.btnHide = {
                        order = effectSettingOrder,
                        width = 1,
                        type = "select",
                        name = "",
                        values = const.OpenEffectOptions,
                        set = function(_, val)
                            btnHide.status = val
                            HbFrame:ReloadEframeUI(updateFrameConfig)
                        end,
                        get = function()
                            return btnHide.status
                        end
                    }
                end
                effectSettingOrder = effectSettingOrder + 1

                local btnDesaturate = GetEffect("btnDesaturate")
                effectSettingArgs.btnDesaturateStatus = {
                    order = effectSettingOrder,
                    width = GetWidth("btnDesaturate"),
                    type = 'toggle',
                    name = L["Btn Desaturate"],
                    set = function(_, val)
                        if btnDesaturate == nil then
                            btnDesaturate = Effect:NewBtnDesaturateEffect()
                            if val == true then
                                btnDesaturate.status = true
                            else
                                btnDesaturate.status = nil
                            end
                            table.insert(editCondGroup.effects, btnDesaturate)
                        else
                            if val == true then
                                btnDesaturate.status = true
                            else
                                btnDesaturate.status = nil
                            end
                        end
                        HbFrame:ReloadEframeUI(updateFrameConfig)
                    end,
                    get = function(_)
                        if btnDesaturate and btnDesaturate.status ~= nil then
                            return true
                        end
                        return false
                    end
                }
                effectSettingOrder = effectSettingOrder + 1
                if btnDesaturate and btnDesaturate.status ~= nil then
                    effectSettingArgs.btnDesaturate = {
                        order = effectSettingOrder,
                        width = 1,
                        type = "select",
                        name = "",
                        values = const.OpenEffectOptions,
                        set = function(_, val)
                            btnDesaturate.status = val
                            HbFrame:ReloadEframeUI(updateFrameConfig)
                        end,
                        get = function()
                            return btnDesaturate.status
                        end
                    }
                end
                effectSettingOrder = effectSettingOrder + 1

                -- 设置图标透明
                local btnAlpha = GetEffect("btnAlpha")
                effectSettingArgs.btnAlphaStatus = {
                    order = effectSettingOrder,
                    width = GetWidth("btnAlpha"),
                    type = 'toggle',
                    name = L["Btn Alpha"],
                    set = function(_, val)
                        if btnAlpha == nil then
                            btnAlpha = Effect:NewBtnAlphaEffect()
                            if val == true then
                                btnAlpha.status = true
                            else
                                btnAlpha.status = nil
                            end
                            table.insert(editCondGroup.effects, btnAlpha)
                        else
                            if val == true then
                                btnAlpha.status = true
                            else
                                btnAlpha.status = nil
                            end
                        end
                        HbFrame:ReloadEframeUI(updateFrameConfig)
                    end,
                    get = function(_)
                        if btnAlpha and btnAlpha.status ~= nil then
                            return true
                        end
                        return false
                    end
                }
                effectSettingOrder = effectSettingOrder + 1
                if btnAlpha and btnAlpha.status ~= nil then
                    effectSettingArgs.btnAlpha = {
                        order = effectSettingOrder,
                        width = 1,
                        type = "select",
                        name = "",
                        values = const.OpenEffectOptions,
                        set = function(_, val)
                            btnAlpha.status = val
                            HbFrame:ReloadEframeUI(updateFrameConfig)
                        end,
                        get = function()
                            return btnAlpha.status
                        end
                    }
                end
                effectSettingOrder = effectSettingOrder + 1


                local btnVertexColor = GetEffect("btnVertexColor")
                effectSettingArgs.btnVertexColorStatus = {
                    order = effectSettingOrder,
                    width = GetWidth("btnVertexColor"),
                    type = 'toggle',
                    name = L["Btn Vertex Red Color"],
                    set = function(_, val)
                        if btnVertexColor == nil then
                            btnVertexColor = Effect:NewBtnVertexColorEffect()
                            if val == true then
                                btnVertexColor.status = true
                            else
                                btnVertexColor.status = nil
                            end
                            table.insert(editCondGroup.effects, btnVertexColor)
                        else
                            if val == true then
                                btnVertexColor.status = true
                            else
                                btnVertexColor.status = nil
                            end
                        end
                        HbFrame:ReloadEframeUI(updateFrameConfig)
                    end,
                    get = function(_)
                        if btnVertexColor and btnVertexColor.status ~= nil then
                            return true
                        end
                        return false
                    end
                }
                effectSettingOrder = effectSettingOrder + 1
                if btnVertexColor and btnVertexColor.status ~= nil then
                    effectSettingArgs.btnVertexColor = {
                        order = effectSettingOrder,
                        width = 1,
                        type = "select",
                        name = "",
                        values = const.OpenEffectOptions,
                        set = function(_, val)
                            btnVertexColor.status = val
                            HbFrame:ReloadEframeUI(updateFrameConfig)
                        end,
                        get = function()
                            return btnVertexColor.status
                        end
                    }
                end
                effectSettingOrder = effectSettingOrder + 1

                local effectSettingOptions = {
                    type = "group",
                    name = L["Effect Settings"],
                    inline = true,
                    order = condGroupSettingOrder,
                    args = effectSettingArgs
                }
                condGroupSettingArgs.effectSetting = effectSettingOptions
                condGroupSettingOrder = condGroupSettingOrder + 1
            end
        end

        -- 脚本设置事件监听
        if ele.type == const.ELEMENT_TYPE.SCRIPT then
            local eventSettingOrder = 1
            local eventSettingArgs = {}
            local eventSettingOptions = {
                type = "group",
                name = L["Event Settings"],
                order = settingOrder,
                args = eventSettingArgs
            }
            settingOrder = settingOrder + 1
            args.eventSetting = eventSettingOptions
            eventSettingArgs.borderGlowStatus = {
                order = eventSettingOrder,
                width = 2,
                type = 'toggle',
                name = L["Enable Event Listening"],
                set = function(_, val)
                    if val == false then
                        ele.listenEvents = nil
                    else
                        ele.listenEvents = {}
                    end
                    HbFrame:ReloadEframeUI(updateFrameConfig)
                end,
                get = function(_)
                    return ele.listenEvents ~= nil
                end
            }
            eventSettingOrder = eventSettingOrder + 1
            if ele.listenEvents ~= nil then
                eventSettingArgs.selectEvents = {
                    order = eventSettingOrder,
                    width = 2,
                    type = "multiselect",
                    name = "",
                    values = const.BUILDIN_EVENTS,
                    get = function(_, key)
                        return ele.listenEvents[key] ~= nil
                    end,
                    set = function(_, key, value)
                        if value == true then
                            ele.listenEvents[key] = {}
                        else
                            ele.listenEvents[key] = nil
                        end
                        HbFrame:ReloadEframeUI(updateFrameConfig)
                    end,
                }
                eventSettingOrder = eventSettingOrder + 1
            end
        end

        -- 递归菜单
        local menuName = iconPath .. showTitle
        if not isRoot then
            menuName = "|cff00ff00" .. iconPath .. showTitle .. "|r"
        end
        if ele.type == const.ELEMENT_TYPE.BAR then
            local barArgs = {}
            barArgs["addChildren"] = {
                type = "group",
                inline = true,
                name = L["Add Child Elements"],
                args = {
                    addBar = {
                        order = 2,
                        width = 1,
                        type = 'execute',
                        name = L["New Bar"],
                        func = function()
                            local bar = E:New(Config.GetNewElementTitle(L["Bar"],
                                    ele.elements),
                                const.ELEMENT_TYPE.BAR)
                            table.insert(ele.elements, bar)
                            HbFrame:ReloadEframeUI(updateFrameConfig)
                            AceConfigDialog:SelectGroup(addonName, unpack(
                                selectGroupsAfterAddItem))
                        end
                    },
                    addItemGroup = {
                        order = 3,
                        width = 1,
                        type = 'execute',
                        name = L["New ItemGroup"],
                        func = function()
                            local itemGroup = E:NewItemGroup(
                                Config.GetNewElementTitle(
                                    L["ItemGroup"], ele.elements))
                            table.insert(ele.elements, itemGroup)
                            HbFrame:ReloadEframeUI(updateFrameConfig)
                            AceConfigDialog:SelectGroup(addonName, unpack(
                                selectGroupsAfterAddItem))
                        end
                    },
                    addItem = {
                        order = 4,
                        width = 1,
                        type = 'execute',
                        name = L["New Item"],
                        func = function()
                            local item = E:New(Config.GetNewElementTitle(L["Item"],
                                    ele.elements),
                                const.ELEMENT_TYPE.ITEM)
                            table.insert(ele.elements, item)
                            HbFrame:ReloadEframeUI(updateFrameConfig)
                            AceConfigDialog:SelectGroup(addonName, unpack(
                                selectGroupsAfterAddItem))
                        end
                    },
                    addMacro = {
                        order = 5,
                        width = 1,
                        type = 'execute',
                        name = L["New Macro"],
                        func = function()
                            local macro = E:New(Config.GetNewElementTitle(L["Macro"],
                                    ele.elements),
                                const.ELEMENT_TYPE.MACRO)
                            table.insert(ele.elements, macro)
                            HbFrame:ReloadEframeUI(updateFrameConfig)
                            AceConfigDialog:SelectGroup(addonName, unpack(
                                selectGroupsAfterAddItem))
                        end
                    },
                    addScript = {
                        order = 6,
                        width = 1,
                        type = 'execute',
                        name = L["New Script"],
                        func = function()
                            local script = E:New(
                                Config.GetNewElementTitle(L["Script"],
                                    ele.elements),
                                const.ELEMENT_TYPE.SCRIPT)
                            table.insert(ele.elements, script)
                            HbFrame:ReloadEframeUI(updateFrameConfig)
                            AceConfigDialog:SelectGroup(addonName, unpack(
                                selectGroupsAfterAddItem))
                        end
                    }
                },
                order = 1
            }
            barArgs["barSetting"] = {
                type = "group",
                name = "|cffffcc00" .. "|T" .. 136243 .. ":16|t" .. L["Settings"] .. "|r",
                childGroups = "tab",
                args = args,
                order = 1
            }
            if ele.elements and #ele.elements then
                local tmpArgs = GetElementOptions(ele.elements, topEleConfig or ele,
                    copySelectGroups)
                for k, v in pairs(tmpArgs) do
                    barArgs[k] = v
                end
            end
            eleArgs["elementMenu" .. i] = {
                type = 'group',
                name = menuName,
                args = barArgs,
                order = i + 1
            }
        else
            eleArgs["elementMenu" .. i] = {
                type = 'group',
                childGroups = "tab",
                name = menuName,
                args = args,
                order = i + 1
            }
        end
    end
    return eleArgs
end

function ConfigOptions.ElementsOptions()
    local options = {
        type = 'group',
        name = L["Element Settings"],
        order = 2,
        args = {
            addBar = {
                order = 2,
                width = 1,
                type = 'execute',
                name = L["New Bar"],
                func = function()
                    local bar = E:New(Config.GetNewElementTitle(L["Bar"],
                            addon.db.profile
                            .elements),
                        const.ELEMENT_TYPE.BAR)
                    table.insert(addon.db.profile.elements, bar)
                    HbFrame:AddEframe(bar)
                    AceConfigDialog:SelectGroup(addonName, "element",
                        "elementMenu" ..
                        #addon.db.profile.elements)
                end
            },
            addItemGroup = {
                order = 3,
                width = 1,
                type = 'execute',
                name = L["New ItemGroup"],
                func = function()
                    local itemGroup = E:NewItemGroup(
                        Config.GetNewElementTitle(
                            L["ItemGroup"],
                            addon.db.profile.elements))
                    table.insert(addon.db.profile.elements, itemGroup)
                    HbFrame:AddEframe(itemGroup)
                    AceConfigDialog:SelectGroup(addonName, "element",
                        "elementMenu" ..
                        #addon.db.profile.elements)
                end
            },
            addScript = {
                order = 4,
                width = 1,
                type = 'execute',
                name = L["New Script"],
                func = function()
                    local script = E:New(
                        Config.GetNewElementTitle(L["Script"],
                            addon.db
                            .profile
                            .elements),
                        const.ELEMENT_TYPE.SCRIPT)
                    table.insert(addon.db.profile.elements, script)
                    HbFrame:AddEframe(script)
                    AceConfigDialog:SelectGroup(addonName, "element",
                        "elementMenu" ..
                        #addon.db.profile.elements)
                end
            },
            addItem = {
                order = 5,
                width = 1,
                type = 'execute',
                name = L["New Item"],
                func = function()
                    local item = E:New(Config.GetNewElementTitle(L["Item"],
                            addon.db
                            .profile
                            .elements),
                        const.ELEMENT_TYPE.ITEM)
                    table.insert(addon.db.profile.elements, item)
                    HbFrame:AddEframe(item)
                    AceConfigDialog:SelectGroup(addonName, "element",
                        "elementMenu" ..
                        #addon.db.profile.elements)
                end
            },
            addMacro = {
                order = 6,
                width = 1,
                type = 'execute',
                name = L["New Macro"],
                func = function()
                    local item = E:New(Config.GetNewElementTitle(L["Macro"],
                            addon.db
                            .profile
                            .elements),
                        const.ELEMENT_TYPE.MACRO)
                    table.insert(addon.db.profile.elements, item)
                    HbFrame:AddEframe(item)
                    AceConfigDialog:SelectGroup(addonName, "element",
                        "elementMenu" ..
                        #addon.db.profile.elements)
                end
            },
            sapce1 = { order = 7, type = 'description', name = "\n\n\n" },
            itemHeading = {
                order = 8,
                type = 'header',
                name = L["Import Configuration"]
            },
            keyBindToggle = {
                order = 9,
                width = 2,
                type = 'toggle',
                name = L["Whether to import keybind settings."],
                set = function(_, _)
                    addon.G.tmpImportKeybind = not addon.G.tmpImportKeybind
                end,
                get = function(_) return addon.G.tmpImportKeybind end
            },
            coverToggle = {
                order = 10,
                width = 2,
                type = 'toggle',
                name = L["Whether to overwrite the existing configuration."],
                set = function(_, _)
                    addon.G.tmpCoverConfig = not addon.G.tmpCoverConfig
                end,
                get = function(_) return addon.G.tmpCoverConfig end
            },
            importEditBox = {
                order = 11,
                type = 'input',
                name = L["Configuration string"],
                multiline = 20,
                width = "full",
                set = function(_, val)
                    addon.G.tmpImportElementConfigString = val
                    local errorMsg =
                        L["Import failed: Invalid configuration string."]
                    if val == nil or val == "" then
                        U.Print.PrintErrorText(errorMsg)
                        return
                    end
                    local decodedData = LibDeflate:DecodeForPrint(val)
                    if decodedData == nil then
                        U.Print.PrintErrorText(errorMsg)
                        return
                    end
                    local decompressedData =
                        LibDeflate:DecompressDeflate(decodedData)
                    if decompressedData == nil then
                        U.Print.PrintErrorText(errorMsg)
                        return
                    end
                    ---@type boolean, ElementConfig
                    local success, eleConfig =
                        AceSerializer:Deserialize(decompressedData)
                    if not success then
                        U.Print.PrintErrorText(errorMsg)
                        return
                    end
                    if type(eleConfig) ~= "table" then
                        U.Print.PrintErrorText(errorMsg)
                        return
                    end
                    if eleConfig.title == nil then
                        U.Print.PrintErrorText(errorMsg)
                        return
                    end
                    local rightType = false
                    for _, v in pairs(const.ELEMENT_TYPE) do
                        if v == eleConfig.type then
                            rightType = true
                            break
                        end
                    end
                    if rightType == false then
                        U.Print.PrintErrorText(errorMsg)
                        return
                    end
                    if eleConfig.extraAttr == nil then
                        U.Print.PrintErrorText(errorMsg)
                        return
                    end
                    Config.HandleConfig(eleConfig)
                    if Config.IsIdDuplicated(eleConfig.id,
                            addon.db.profile.elements) then
                        --- 如果覆盖配置
                        if addon.G.tmpCoverConfig == true then
                            for i, ele in ipairs(addon.db.profile.elements) do
                                if ele.id == eleConfig.id then
                                    addon.db.profile.elements[i] = eleConfig
                                    addon:UpdateOptions()
                                    AceConfigDialog:SelectGroup(addonName,
                                        "element",
                                        "elementMenu" ..
                                        i)
                                    return true
                                end
                            end
                        else
                            eleConfig.id = U.String.GenerateID()
                        end
                    end
                    if Config.IsTitleDuplicated(eleConfig.title,
                            addon.db.profile.elements) then
                        eleConfig.title =
                            Config.CreateDuplicateTitle(eleConfig.title,
                                addon.db.profile
                                .elements)
                    end
                    table.insert(addon.db.profile.elements, eleConfig)
                    HbFrame:AddEframe(eleConfig)
                    addon:UpdateOptions()
                    AceConfigDialog:SelectGroup(addonName, "element",
                        "elementMenu" ..
                        #addon.db.profile.elements)
                end,
                get = function(_)
                    return addon.G.tmpImportElementConfigString
                end
            }
        }
    }
    local args = GetElementOptions(addon.db.profile.elements, nil, { "element" })
    for k, v in pairs(args) do options.args[k] = v end
    return options
end

function ConfigOptions.Options()
    local options = {
        name = addonName,
        handler = addon,
        type = 'group',
        args = {
            general = {
                order = 1,
                type = 'group',
                name = L["General Settings"],
                args = {
                    editFrame = {
                        order = 1,
                        width = 2,
                        type = "execute",
                        name = L["Toggle Edit Mode"],
                        func = function()
                            if addon.G.IsEditMode == false then
                                addon.G.IsEditMode = true
                                HbFrame:OpenEditMode()
                            else
                                addon.G.IsEditMode = false
                                HbFrame:CloseEditMode()
                            end
                        end
                    },
                    editFrameDesc = {
                        order = 2,
                        width = 2,
                        type = "description",
                        name = L["Left-click to drag and move, right-click to exit edit mode."]
                    },
                    versionSpace = {
                        order = 3,
                        width = 2,
                        type = "description",
                        name = "\n\n\n"
                    },
                    versionDesc = {
                        order = 4,
                        width = 2,
                        type = "description",
                        name = L["Version"] .. ": " .. "Beta-0.2.7"
                    }
                }
            },
            element = ConfigOptions.ElementsOptions()
        }
    }
    return options
end

function addon:OnInitialize()
    -- 检测是否安装了ElvUI
    local ElvUI = nil
    local ElvUISkins = nil
    ---@diagnostic disable-next-line: undefined-field
    if _G.ElvUI then
        ---@diagnostic disable-next-line: undefined-field
        ElvUI = unpack(_G.ElvUI) ---@type ElvUI
        ElvUISkins = ElvUI:GetModule("Skins") ---@type ElvUISkins
    end
    local screenWidth, screenHeight = GetPhysicalScreenSize()
    -- 全局变量
    ---@class GlobalValue
    self.G = {
        ElvUI = ElvUI,
        ElvUISkins = ElvUISkins,
        screenWidth = math.floor(screenWidth),   -- 屏幕宽度
        screenHeight = math.floor(screenHeight), -- 屏幕高度
        iconWidth = 32,
        iconHeight = 32,
        IsEditMode = false,
        tmpImportKeybind = false,           -- 默认选择不导入按键设置
        tmpCoverConfig = false,             -- 默认选择不覆盖配置，默认创建副本
        tmpImportElementConfigString = nil, -- 导入elementconfig配置字符串
        tmpConfigString = nil,              -- 全局配置编辑字符串
        tmpNewItemType = nil,
        tmpNewItemVal = nil,
        tmpNewItem = { type = nil, id = nil, icon = nil, name = nil }, ---@type ItemAttr
        tmpNewText = nil, -- 添加文本
        tmpMacroAst = nil,  -- 宏解析结果
    }
    -- 注册数据库，添加分类设置
    self.db = LibStub("AceDB-3.0"):New("HappyButtonDB", {
        profile = {
            elements = {} ---@type ElementConfig[]
        }
    }, true)
    -- 对配置文件进行兼容性处理
    if self.db.profile.elements then
        for _, element in ipairs(self.db.profile.elements) do
            self:compatibilizeConfig(element)
        end 
    end
    -- 注册选项表
    AceConfig:RegisterOptionsTable(addonName, ConfigOptions.Options)
    -- 在Blizzard界面选项中添加一个子选项
    -- self.optionsFrame = AceConfigDialog:AddToBlizOptions(addonName, addonName)
    -- 输入 /HappyButton 或者 /hb 打开配置
    self:RegisterChatCommand(addonName, "OpenConfig")
    self:RegisterChatCommand("hb", "OpenConfig")
end

function addon:OpenConfig()
    if InCombatLockdown() then
        U.Print.PrintInfoText(L["You cannot use this in combat."] )
        return
    end
    AceConfigDialog:Open(addonName)
    -- local frame = AceConfigDialog.OpenFrames[addonName]
    -- if frame then
    --     frame:SetWidth(1000)
    --     frame:SetHeight(600)
    -- end
end

function addon:UpdateOptions()
    -- 重新注册配置表来更新菜单栏
    -- LibStub("AceConfigRegistry-3.0"):NotifyChange(addonName)
end

---@param element ElementConfig
function addon:compatibilizeConfig(element)
    if element == nil then
        return
    end
    if element.elements and #element.elements then
        for _, child in ipairs(element.elements) do
            addon:compatibilizeConfig(child)
        end
    end
end