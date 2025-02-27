local addonName, _ = ...


---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class Utils: AceModule
local U = addon:GetModule('Utils')

---@class Api: AceModule
local Api = addon:GetModule("Api")

---@class Item: AceModule
local Item = addon:GetModule("Item")

---@class PlayerCache: AceModule
local PlayerCache = addon:GetModule("PlayerCache")

---@class ItemCacheInfo
---@field isLearned boolean | nil
---@field isUsable boolean | nil
---@field isCooldown boolean | nil
---@field cooldownInfo CooldownInfo | nil
---@field borderColor RGBAColor | nil
---@field count number | nil

---@class ItemCacheItems
---@field item table<number, ItemCacheInfo>
---@field equipment table<number, ItemCacheInfo>
---@field spell table<number, ItemCacheInfo>
---@field toy table<number, ItemCacheInfo>
---@field mount table<number, ItemCacheInfo>
---@field pet table<number, ItemCacheInfo>


---@class ItemCacheGcd
---@field cooldownInfo CooldownInfo | nil


---@class ItemCache: AceModule
---@field cache ItemCacheItems
---@field gcd ItemCacheGcd
local ItemCache = addon:NewModule("ItemCache")

local GetTime = GetTime

function ItemCache:Initial()
    ItemCache.cache = {
        item = {},
        equipment = {},
        spell = {},
        toy = {},
        mount = {},
        pet = {}
    }
    ItemCache.gcd = {}
end


-- 通过itemAttr获取缓存数据，如果缓存没有则获取后返回
-- 获取的方式是渐进式的，只有缺少对应的属性才获取对应的属性，减少API的调用
---@param item ItemAttr
---@return ItemCacheInfo
function ItemCache:Get(item)
    if item.type == const.ITEM_TYPE.ITEM then
        if ItemCache.cache.item[item.id] == nil then
            ItemCache.cache.item[item.id] = {}
        end
        if ItemCache.cache.item[item.id].count == nil then
            ItemCache.cache.item[item.id].count = Api.GetItemCount(item.id, false)
            ItemCache.cache.item[item.id].isLearned = ItemCache.cache.item[item.id].count > 0
        end
        if ItemCache.cache.item[item.id].isUsable == nil then
            local usable, _ = Api.IsUsableItem(item.id)
            ItemCache.cache.item[item.id].isUsable = usable
        end
        if ItemCache.cache.item[item.id].cooldownInfo == nil then
            ItemCache.cache.item[item.id].cooldownInfo = Api.GetItemCooldown(item.id)
            ItemCache.cache.item[item.id].isCooldown = Item:IsCooldown(ItemCache.cache.item[item.id].cooldownInfo)
        end
        if ItemCache.cache.item[item.id].borderColor == nil then
            local borderColor = const.DefaultItemColor
            local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expansionID, setID, isCraftingReagent = Api.GetItemInfo(item.id)
            if itemQuality then
                borderColor = const.ItemQualityColor[itemQuality]
            end
            ItemCache.cache.item[item.id].borderColor = borderColor
        end
        return ItemCache.cache.item[item.id]
    elseif item.type == const.ITEM_TYPE.EQUIPMENT then
        if ItemCache.cache.equipment[item.id] == nil then
            ItemCache.cache.equipment[item.id] = {}
        end
        if ItemCache.cache.equipment[item.id].count == nil then
            ItemCache.cache.equipment[item.id].count = Api.GetItemCount(item.id, false)
        end
        if ItemCache.cache.equipment[item.id].isLearned == nil then
            ItemCache.cache.equipment[item.id].isLearned = ItemCache.cache.equipment[item.id].count > 0 or Item:IsEquipped(item.id)
        end
        if ItemCache.cache.equipment[item.id].isUsable == nil then
            local usable, _ = Api.IsUsableItem(item.id)
            ItemCache.cache.equipment[item.id].isUsable = usable
        end
        if ItemCache.cache.equipment[item.id].cooldownInfo == nil then
            ItemCache.cache.equipment[item.id].cooldownInfo = Api.GetItemCooldown(item.id)
            ItemCache.cache.equipment[item.id].isCooldown = Item:IsCooldown(ItemCache.cache.equipment[item.id].cooldownInfo)
        end
        if ItemCache.cache.equipment[item.id].borderColor == nil then
            local borderColor = const.DefaultItemColor
            local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expansionID, setID, isCraftingReagent = Api.GetItemInfo(item.id)
            if itemQuality then
                borderColor = const.ItemQualityColor[itemQuality]
            end
            ItemCache.cache.equipment[item.id].borderColor = borderColor
        end
        return ItemCache.cache.equipment[item.id]
    elseif item.type == const.ITEM_TYPE.TOY then
        if ItemCache.cache.toy[item.id] == nil then
            ItemCache.cache.toy[item.id] = {}
        end
        if ItemCache.cache.toy[item.id].isLearned == nil then
            ItemCache.cache.toy[item.id].isLearned = PlayerHasToy(item.id)
        end
        if ItemCache.cache.toy[item.id].isUsable == nil then
            ItemCache.cache.toy[item.id].isUsable = C_ToyBox.IsToyUsable(item.id)
        end
        if ItemCache.cache.toy[item.id].cooldownInfo == nil then
            ItemCache.cache.toy[item.id].cooldownInfo = Api.GetItemCooldown(item.id)
            ItemCache.cache.toy[item.id].isCooldown = Item:IsCooldown(ItemCache.cache.toy[item.id].cooldownInfo)
        end
        if ItemCache.cache.toy[item.id].borderColor == nil then
            local borderColor = const.DefaultItemColor
            local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expansionID, setID, isCraftingReagent =
                    Api.GetItemInfo(item.id)
                if itemQuality then
                    borderColor = const.ItemQualityColor[itemQuality]
                end
            ItemCache.cache.toy[item.id].borderColor = borderColor
        end
        return ItemCache.cache.toy[item.id]
    elseif item.type == const.ITEM_TYPE.MOUNT then
        if ItemCache.cache.mount[item.id] == nil then
            ItemCache.cache.mount[item.id] = {}
        end
        if ItemCache.cache.mount[item.id].isLearned == nil then
            local name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID, isSteadyFlight =
            C_MountJournal.GetMountInfoByID(item.id)
            ItemCache.cache.mount[item.id].isLearned = isCollected
        end
        if ItemCache.cache.mount[item.id].isUsable == nil then
            ItemCache.cache.mount[item.id].isUsable = true
        end
        if ItemCache.cache.mount[item.id].borderColor == nil then
            ItemCache.cache.mount[item.id].borderColor = const.DefaultItemColor
        end
        return ItemCache.cache.mount[item.id]
    elseif item.type == const.ITEM_TYPE.PET then
        if ItemCache.cache.pet[item.id] == nil then
            ItemCache.cache.pet[item.id] = {}
        end
        if ItemCache.cache.pet[item.id].isLearned == nil then
            local isLearned = false
            for petIndex = 1, C_PetJournal.GetNumPets() do
                local _, speciesID, owned, customName, level, favorite, isRevoked, speciesName, icon, petType, companionID, tooltip, description, isWild, canBattle, isTradeable, isUnique, obtainable =
                    C_PetJournal.GetPetInfoByIndex(petIndex)
                if speciesID == item.id then
                    isLearned = true
                    break
                end
            end
            ItemCache.cache.pet[item.id].isLearned = isLearned
        end
        if ItemCache.cache.pet[item.id].isUsable == nil then
            ItemCache.cache.pet[item.id].isUsable = true
        end
        if ItemCache.cache.pet[item.id].cooldownInfo == nil then
            local cooldownInfo = nil
            local _, petGUID = C_PetJournal.FindPetIDByName(item.name)
                if petGUID then
                    local start, duration, isEnabled = C_PetJournal.GetPetCooldownByGUID(petGUID)
                    cooldownInfo = {
                        startTime = start,
                        duration = duration,
                        enable = isEnabled == 1
                    }
                end
            ItemCache.cache.pet[item.id].cooldownInfo = cooldownInfo
            ItemCache.cache.pet[item.id].isCooldown = cooldownInfo and Item:IsCooldown(cooldownInfo) or nil
        end
        if ItemCache.cache.pet[item.id].borderColor == nil then
            ItemCache.cache.pet[item.id].borderColor = const.DefaultItemColor
        end
        return ItemCache.cache.pet[item.id]
    else
        if ItemCache.cache.spell[item.id] == nil then
            ItemCache.cache.spell[item.id] = {}
        end
        if ItemCache.cache.spell[item.id].isLearned == nil then
            ItemCache.cache.spell[item.id].isLearned = IsSpellKnownOrOverridesKnown(item.id)
        end
        if ItemCache.cache.spell[item.id].isUsable == nil then
            local isUsable, _ = Api.IsSpellUsable(item.id)
            ItemCache.cache.spell[item.id].isUsable = isUsable
        end
        if ItemCache.cache.spell[item.id].cooldownInfo == nil then
            local spellCooldownInfo = Api.GetSpellCooldown(item.id)
            local cooldownInfo = nil
            if spellCooldownInfo then
                cooldownInfo = {
                    startTime = spellCooldownInfo.startTime,
                    duration = spellCooldownInfo.duration,
                    enable = spellCooldownInfo.isEnabled
                }
            end
            ItemCache.cache.spell[item.id].cooldownInfo = cooldownInfo
            ItemCache.cache.spell[item.id].isCooldown = cooldownInfo and Item:IsCooldown(cooldownInfo) or nil
        end
        if ItemCache.cache.spell[item.id].count == nil then
            local chargeInfo = Api.GetSpellCharges(item.id)
            local count = 1
            if chargeInfo then
                count = chargeInfo.currentCharges
            end
            ItemCache.cache.spell[item.id].count = count
        end
        if ItemCache.cache.spell[item.id].borderColor == nil then
            ItemCache.cache.spell[item.id].borderColor = const.DefaultItemColor
        end
        return ItemCache.cache.spell[item.id]
    end
end


---@param event EventString
---@param eventArgs any
---@return EventString, any
function ItemCache:Update(event, eventArgs)
    if event == "NEW_TOY_ADDED" then
        local itemId = tonumber(eventArgs[1])
        if itemId then
            ItemCache.cache.toy[itemId] = nil
        end
    end
    if event == "NEW_PET_ADDED" then
        local battlePetGUID = eventArgs[1]
        local speciesID, customName, level, xp, maxXp, displayID, isFavorite, name, icon, petType, creatureID, sourceText, description, isWild, canBattle, isTradeable, isUnique, obtainable = C_PetJournal.GetPetInfoByPetID(battlePetGUID)
        if speciesID then
            ItemCache.cache.pet[speciesID] = nil
        end
    end
    if event == "NEW_MOUNT_ADDED" then
        local mountID = eventArgs[1]
        if mountID then
            ItemCache.cache.mount[mountID] = nil
        end
    end
    if event == "BAG_UPDATE" then
        for id, _ in pairs(ItemCache.cache.item) do
            ItemCache.cache.item[id].isLearned = nil
            ItemCache.cache.item[id].count = nil
        end
        for id, _ in pairs(ItemCache.cache.equipment) do
            ItemCache.cache.equipment[id].isLearned = nil
            ItemCache.cache.equipment[id].count = nil
        end
    end
    if event == "SPELLS_CHANGED" or event == "PLAYER_TALENT_UPDATE" then
        for id, _ in pairs(ItemCache.cache.spell) do
            ItemCache.cache.spell[id] = nil
        end
    end
    if event == "UNIT_SPELLCAST_SUCCEEDED" then
        for id, _ in pairs(ItemCache.cache.spell) do
            ItemCache.cache.spell[id].cooldownInfo = nil
            ItemCache.cache.spell[id].isCooldown = nil
            ItemCache.cache.spell[id].count = nil
        end
        for id, _ in pairs(ItemCache.cache.equipment) do
            ItemCache.cache.equipment[id].cooldownInfo = nil
            ItemCache.cache.equipment[id].isCooldown = nil
        end
        for id, _ in pairs(ItemCache.cache.item) do
            ItemCache.cache.item[id].cooldownInfo = nil
            ItemCache.cache.item[id].isCooldown = nil
        end
        for id, _ in pairs(ItemCache.cache.pet) do
            ItemCache.cache.pet[id].cooldownInfo = nil
            ItemCache.cache.pet[id].isCooldown = nil
        end
    end
    if event == "SPELL_UPDATE_CHARGES" then
        for id, _ in pairs(ItemCache.cache.spell) do
            ItemCache.cache.spell[id].count = nil
        end
    end
    return event, eventArgs
end


function ItemCache:UpdateGcd()
    local cooldownInfo = Api.GetSpellCooldown(PlayerCache.gcdSpellId)
    local needSendMessage = false
    if ItemCache.gcd == nil or ItemCache.gcd.cooldownInfo == nil or ItemCache.gcd.cooldownInfo.startTime == nil then
        -- 如果上一次的GCD信息无效，则更新
        needSendMessage = true
    elseif ItemCache.gcd.cooldownInfo.startTime ~= cooldownInfo.startTime then
        -- 重新触发GCD，则更新
        if cooldownInfo.startTime ~= 0 then
            needSendMessage = true
        else
            -- 如果是GCD完成，或者取消
            -- 如果上一次的GCD开始事件+GCD事件<当前时间，表示上一个GCD已经完成，无须更新
            if ItemCache.gcd.cooldownInfo.startTime + ItemCache.gcd.cooldownInfo.duration > GetTime() then
                needSendMessage = true
            end
        end
    end
    ItemCache.gcd.cooldownInfo = {
        startTime = cooldownInfo.startTime,
        duration = cooldownInfo.duration,
        enable = cooldownInfo.isEnabled
    }
    if needSendMessage == true then
        addon:SendMessage(const.EVENT.HB_GCD_UPDATE)
    end
end