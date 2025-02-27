local addonName, _ = ...


---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

local L = LibStub("AceLocale-3.0"):GetLocale(addonName, false)

---@class Result: AceModule
local R = addon:GetModule("Result")

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class Item: AceModule
local Item = addon:NewModule("Item")

---@class Api: AceModule
local Api = addon:GetModule("Api")

---@class Client: AceModule
local Client = addon:GetModule("Client")

-- 判断玩家是否拥有/学习某个物品
---@param itemID number
---@param itemType ItemType
---@return boolean
function Item:IsLearned(itemID, itemType)
    if itemID == nil then
        return false
    end
    if itemType == const.ITEM_TYPE.ITEM then
        local bagCount = Api.GetItemCount(itemID, false) -- 检查背包中是否拥有
        if bagCount > 0 then
            return true
        end
    elseif itemType == const.ITEM_TYPE.EQUIPMENT then
        local bagCount = Api.GetItemCount(itemID, false)
        local isEquipped = self:IsEquipped(itemID)
        return bagCount > 0 or isEquipped == true
    elseif itemType == const.ITEM_TYPE.TOY then
        if PlayerHasToy(itemID) then
            return true
        end
    elseif itemType == const.ITEM_TYPE.SPELL then
        if IsSpellKnownOrOverridesKnown(itemID) then
            return true
        end
    elseif itemType == const.ITEM_TYPE.MOUNT then
        local name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID, isSteadyFlight =
            C_MountJournal.GetMountInfoByID(itemID)
        if isCollected then
            return true
        end
    elseif itemType == const.ITEM_TYPE.PET then
        for petIndex = 1, C_PetJournal.GetNumPets() do
            local _, speciesID, owned, customName, level, favorite, isRevoked, speciesName, icon, petType, companionID, tooltip, description, isWild, canBattle, isTradeable, isUnique, obtainable =
                C_PetJournal.GetPetInfoByIndex(petIndex)
            if speciesID == itemID then
                return true
            end
        end
    end
    return false
end

-- 判断物品是否可用
---@param itemID number
---@param itemType ItemType
---@return boolean
function Item:IsUsable(itemID, itemType)
    if itemID == nil or itemType == nil then
        return false
    end
    if itemType == const.ITEM_TYPE.ITEM or itemType == const.ITEM_TYPE.EQUIPMENT then
        local usable, _ = Api.IsUsableItem(itemID) -- 检查是否可用
        if usable == true then
            return true
        end
    elseif itemType == const.ITEM_TYPE.TOY then
        if C_ToyBox.IsToyUsable(itemID) then
            return true
        end
    elseif itemType == const.ITEM_TYPE.SPELL then
        local isUsable, _ = Api.IsSpellUsable(itemID)
        if isUsable then
            return true
        end
    elseif itemType == const.ITEM_TYPE.MOUNT then
        -- 根据玩家职业、种族判断是否可用
        local name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID, isSteadyFlight
        = C_MountJournal.GetMountInfoByID(itemID)
        if not isUsable then
            return false
        end
        -- 室内无法使用坐骑
        if not IsOutdoors() then
            return false
        end
        local creatureDisplayInfoID, description, source, isSelfMount, mountTypeID, uiModelSceneID, animID, spellVisualKitID, disablePlayerMountPreview =
            C_MountJournal.GetMountInfoExtraByID(mountID)
        -- 判断当前位置是否可以使用坐骑
        -- 不是御龙术区域无法使用御龙术
        if Client:IsRetail() then
            if not IsAdvancedFlyableArea() and mountTypeID == const.MOUNT_TYPE_ID.DRAGON then
                return false
            end
        end
        return true
    elseif itemType == const.ITEM_TYPE.PET then
        return true
    end
    return false
end

-- 确认物品是否已经冷却完毕
---@param cooldownInfo CooldownInfo | nil
---@return boolean
function Item:IsCooldown(cooldownInfo)
    if cooldownInfo == nil then
        return true
    end
    if cooldownInfo.enable == false then
        return true
    end
    if cooldownInfo.duration ~= 0 and cooldownInfo.duration > 1.5 then -- 需要判断是否是公共冷却
        return false
    end
    return true
end

-- 判断物品是否被装备
---@param itemId number
---@return boolean
function Item:IsEquipped(itemId)
    -- 检查物品是否已装备
    -- 检查所有装备槽: https://warcraft.wiki.gg/wiki/InventorySlotID
    local isEquipped = false
    for i = 1, 30 do
        local equippedItemID = GetInventoryItemID("player", i)
        if equippedItemID == itemId then
            isEquipped = true
            break
        end
    end
    return isEquipped
end

-- 创建ItemAttr
---@param identifier string | number
---@param itemType number | nil
---@return ItemAttr
function Item:CreateItemAttr(identifier, itemType)
    local item = {} ---@type ItemAttr
    item.type = itemType
    if tonumber(identifier) == nil then
        item.name = tostring(identifier)
    else
        item.id = tonumber(identifier)
    end
    return item
end

-- 补充itemAttr的信息
-- 可以分为两种情况
-- 1. 物品类型为Item，这种情况提供了类型和（名称或者ID）
-- 2. 物品类型为Macro，这种情况只提供了（名称或者ID）
---@param itemAttr ItemAttr
function Item:CompleteItemAttr(itemAttr)
    -- 如果名称和ID都有，则表示不需要补充
    if itemAttr.name ~= nil and itemAttr.id ~= nil then
        return
    end
    if itemAttr.type == const.ITEM_TYPE.SPELL then
        if Client:IsRetail() then
            local spellID = C_Spell.GetSpellIDForSpellIdentifier(itemAttr.name or itemAttr.id or 0)
            if spellID then
                itemAttr.id = spellID
                itemAttr.name = C_Spell.GetSpellName(itemAttr.id)
                itemAttr.icon = select(1, C_Spell.GetSpellTexture(itemAttr.id))
            end
        else
            local spellInfo = Api.GetSpellInfo(itemAttr.name or itemAttr.id or 0)
            if spellInfo then
                itemAttr.id = spellInfo.spellID
                itemAttr.name = spellInfo.name
                itemAttr.icon = spellInfo.iconID
            end
        end
        -- 说明：type(C_ToyBox.GetToyInfo(item.id))返回的是number，和文档定义的不一致，无法通过API获取玩具信息，因此只能使用物品的API来获取
    elseif itemAttr.type == const.ITEM_TYPE.ITEM or itemAttr.type == const.ITEM_TYPE.TOY or itemAttr.type == const.ITEM_TYPE.EQUIPMENT then
        local itemID, _, _, _, icon, _, _ = Api.GetItemInfoInstant(itemAttr.name or itemAttr.id or 0)
        if itemID then
            itemAttr.id = itemID
            itemAttr.icon = icon
            itemAttr.name = C_Item.GetItemNameByID(itemAttr.id)
        else
            -- 第一个执行可能没有被缓存，等待0.5秒从服务器获取缓存后再次读取
            C_Timer.After(0.5, function()
                local itemID1, _, _, _, icon1, _, _ = Api.GetItemInfoInstant(itemAttr.name or itemAttr.id or 0)
                if itemID then
                    itemAttr.id = itemID1
                    itemAttr.icon = icon1
                    itemAttr.name = C_Item.GetItemNameByID(itemAttr.id)
                end
            end)
        end
    elseif itemAttr.type == const.ITEM_TYPE.MOUNT then
        if itemAttr.id == nil then
            for mountDisplayIndex = 1, C_MountJournal.GetNumDisplayedMounts() do
                local name, spellID, icon, isActive, isUsable, sourceType,
                isFavorite, isFactionSpecific, faction, shouldHideOnChar,
                isCollected, mountID, isSteadyFlight =
                    C_MountJournal.GetDisplayedMountInfo(mountDisplayIndex)
                if name == itemAttr.name then
                    itemAttr.id = mountID
                    itemAttr.name = name
                    itemAttr.icon = icon
                    break
                end
            end
        end
        if itemAttr.name == nil then
            local name, spellID, icon, active, isUsable, sourceType, isFavorite,
            isFactionSpecific, faction, shouldHideOnChar, isCollected,
            mountID = C_MountJournal.GetMountInfoByID(itemAttr.id)
            if name then
                itemAttr.id = mountID
                itemAttr.name = name
                itemAttr.icon = icon
            end
        end
    elseif itemAttr.type == const.ITEM_TYPE.PET then
        if itemAttr.id == nil then
            local speciesId, petGUID = C_PetJournal.FindPetIDByName(itemAttr.name)
            if speciesId then itemAttr.id = speciesId end
        end
        if itemAttr.id ~= nil then
            local speciesName, speciesIcon, petType, companionID, tooltipSource,
            tooltipDescription, isWild, canBattle, isTradeable, isUnique,
            obtainable, creatureDisplayID = C_PetJournal.GetPetInfoBySpeciesID(itemAttr.id)
            if speciesName then
                itemAttr.name = speciesName
                itemAttr.icon = speciesIcon
            end
        end
        -- 如果没有提供类型，则依次判断技能、坐骑、物品
    elseif itemAttr.type == nil then
        -- 判断技能
        if Client:IsRetail() then
            local spellID = C_Spell.GetSpellIDForSpellIdentifier(itemAttr.name or itemAttr.id or 0)
            if spellID then
                itemAttr.id = spellID
                itemAttr.name = C_Spell.GetSpellName(itemAttr.id)
                itemAttr.icon = select(1, C_Spell.GetSpellTexture(itemAttr.id))
                itemAttr.type = const.ITEM_TYPE.SPELL
            end
        else
            local spellInfo = Api.GetSpellInfo(itemAttr.name or itemAttr.id or 0)
            if spellInfo then
                itemAttr.id = spellInfo.spellID
                itemAttr.name = spellInfo.name
                itemAttr.icon = spellInfo.iconID
                itemAttr.type = const.ITEM_TYPE.SPELL
            end
        end
        -- 判断坐骑
        if itemAttr.id == nil then
            for mountDisplayIndex = 1, C_MountJournal.GetNumDisplayedMounts() do
                local name, spellID, icon, isActive, isUsable, sourceType,
                isFavorite, isFactionSpecific, faction, shouldHideOnChar,
                isCollected, mountID, isSteadyFlight =
                    C_MountJournal.GetDisplayedMountInfo(mountDisplayIndex)
                if name == itemAttr.name then
                    itemAttr.id = mountID
                    itemAttr.name = name
                    itemAttr.icon = icon
                    itemAttr.type = const.ITEM_TYPE.MOUNT
                    break
                end
            end
        end
        if itemAttr.name == nil then
            local name, spellID, icon, active, isUsable, sourceType, isFavorite,
            isFactionSpecific, faction, shouldHideOnChar, isCollected,
            mountID = C_MountJournal.GetMountInfoByID(itemAttr.id)
            if name then
                itemAttr.id = mountID
                itemAttr.name = name
                itemAttr.icon = icon
                itemAttr.type = const.ITEM_TYPE.MOUNT
            end
        end
        -- 判断物品
        local itemID, _, _, _, icon, classID, _ = Api.GetItemInfoInstant(itemAttr.name or itemAttr.id or 0)
        if itemID then
            itemAttr.id = itemID
            itemAttr.icon = icon
            itemAttr.name = C_Item.GetItemNameByID(itemAttr.id)
            itemAttr.type = const.ITEM_TYPE.ITEM
            if classID == 2 or classID == 4 then
                itemAttr.type = const.ITEM_TYPE.EQUIPMENT
            else
                local toyItemID, _, _, _, _, _ = C_ToyBox.GetToyInfo(itemAttr.id)
                if toyItemID then
                    itemAttr.type = const.ITEM_TYPE.TOY
                end
            end
        else
            -- 第一个执行可能没有被缓存，等待0.5秒从服务器获取缓存后再次读取
            C_Timer.After(0.5, function()
                local itemID1, _, _, _, icon1, _, _ = Api.GetItemInfoInstant(itemAttr.name or itemAttr.id or 0)
                if itemID1 then
                    itemAttr.id = itemID1
                    itemAttr.icon = icon1
                    itemAttr.name = C_Item.GetItemNameByID(itemAttr.id)
                    itemAttr.type = const.ITEM_TYPE.ITEM
                    if classID == 2 or classID == 4 then
                        itemAttr.type = const.ITEM_TYPE.EQUIPMENT
                    else
                        local toyItemID, _, _, _, _, _ = C_ToyBox.GetToyInfo(itemAttr.id)
                        if toyItemID then
                            itemAttr.type = const.ITEM_TYPE.TOY
                        end
                    end
                end
            end)
        end
    end
end

-- 获取物品冷却信息
---@param itemAttr ItemAttr
---@return CooldownInfo | nil
function Item:GetCooldown(itemAttr)
    if itemAttr.type == const.ITEM_TYPE.ITEM or itemAttr.type == const.ITEM_TYPE.EQUIPMENT or itemAttr.type == const.ITEM_TYPE.TOY then
        return Api.GetItemCooldown(itemAttr.id)
    elseif itemAttr.type == const.ITEM_TYPE.SPELL then
        local spellCooldownInfo = Api.GetSpellCooldown(itemAttr.id)
        if spellCooldownInfo then
            return {
                startTime = spellCooldownInfo.startTime,
                duration = spellCooldownInfo.duration,
                enable = spellCooldownInfo.isEnabled
            }
        end
    elseif itemAttr.type == const.ITEM_TYPE.PET then
        local _, petGUID = C_PetJournal.FindPetIDByName(itemAttr.name)
        if petGUID then
            local start, duration, isEnabled = C_PetJournal.GetPetCooldownByGUID(petGUID)
            return {
                startTime = start,
                duration = duration,
                enable = isEnabled == 1
            }
        end
    end
    return nil
end
