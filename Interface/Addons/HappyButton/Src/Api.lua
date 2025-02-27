---@diagnostic disable: undefined-field
local addonName, _ = ... ---@type string, table
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class Client: AceModule
local Client = addon:GetModule("Client")

---@class Api: AceModule
local Api = addon:NewModule("Api")

local C_Spell = C_Spell
local C_Item = C_Item
local C_Container = C_Container
local C_UnitAuras = C_UnitAuras
---@diagnostic disable-next-line: deprecated
local UnitAura = UnitAura
---@diagnostic disable-next-line: deprecated
local GetSpellCooldown = GetSpellCooldown

---@diagnostic disable-next-line: deprecated
Api.GetItemInfoInstant = (C_Item and C_Item.GetItemInfoInstant) and C_Item.GetItemInfoInstant or GetItemInfoInstant
---@diagnostic disable-next-line: deprecated
Api.GetItemInfo = (C_Item and C_Item.GetItemInfo) and C_Item.GetItemInfo or GetItemInfo
---@diagnostic disable-next-line: deprecated
Api.GetItemCount = (C_Item and C_Item.GetItemCount) and C_Item.GetItemCount or GetItemCount
---@diagnostic disable-next-line: deprecated
Api.IsUsableItem = (C_Item and C_Item.IsUsableItem) and C_Item.IsUsableItem or IsUsableItem
---@diagnostic disable-next-line: deprecated
Api.GetSpellCharges = (C_Spell and C_Spell.GetSpellCharges) and C_Spell.GetSpellCharges or GetSpellCharges
---@diagnostic disable-next-line: deprecated
Api.IsSpellUsable = (C_Spell and C_Spell.IsSpellUsable) and C_Spell.IsSpellUsable or IsUsableSpell
---@diagnostic disable-next-line: deprecated
Api.GetSpellTexture = (C_Spell and C_Spell.GetSpellTexture) and C_Spell.GetSpellTexture or GetSpellTexture
---@diagnostic disable-next-line: deprecated
Api.IsEquippedItemType = (C_Item and C_Item.IsEquippedItemType) and C_Item.IsEquippedItemType or IsEquippedItemType

---@param spellIdentifier string | number
---@return SpellInfo?
Api.GetSpellInfo = function (spellIdentifier)
    if C_Spell and C_Spell.GetSpellInfo then
        return C_Spell.GetSpellInfo(spellIdentifier)
    else
        ---@diagnostic disable-next-line: deprecated
        local name, rank, icon, castTime, minRange, maxRange, spellID, originalIcon = GetSpellInfo(spellIdentifier)
        if spellID == nil then
            return nil
        end
        ---@type SpellInfo
        local spellInfo = {
            name = name,
            iconID = icon,
            originalIconID = originalIcon,
            castTime = castTime,
            minRange = minRange,
            maxRange = maxRange,
            spellID = spellID
        }
        return spellInfo
    end
end

---@param spellIdentifier string | number
---@return SpellCooldownInfo
Api.GetSpellCooldown = function (spellIdentifier)
    if C_Spell and C_Spell.GetSpellCooldown then
        return C_Spell.GetSpellCooldown(spellIdentifier)
    else
        ---@diagnostic disable-next-line: deprecated
        local start, duration, enabled, modRate = GetSpellCooldown(spellIdentifier)
        ---@type SpellCooldownInfo
        local spellCooldownInfo = {
            duration = duration,
            isEnabled = enabled == 1,
            modRate = modRate,
            startTime = start
        }
        return spellCooldownInfo
    end
end

---@param itemIdentifier string | number
---@return CooldownInfo | nil
Api.GetItemCooldown = function (itemIdentifier)
    if C_Item and C_Item.GetItemCooldown then
        local startTimeSeconds, durationSeconds, enableCooldownTimer = C_Item.GetItemCooldown(itemIdentifier)
        if startTimeSeconds then
            return {
                startTime = startTimeSeconds,
                duration = durationSeconds,
                enable = enableCooldownTimer
            }
        end
    end
    ---@diagnostic disable-next-line: deprecated
    if GetItemCooldown then
        ---@diagnostic disable-next-line: deprecated
        local startTime, duration, enable = GetItemCooldown(itemIdentifier)
        if startTime then
            return {
                startTime = startTime,
                duration = duration,
                enable = enable
            }
        end
    end
    ---@diagnostic disable-next-line: deprecated
    if C_Container and C_Container.GetItemCooldown and tonumber(itemIdentifier) ~= nil then
    ---@diagnostic disable-next-line: param-type-mismatch
       local startTime, duration, enable = C_Container.GetItemCooldown(itemIdentifier)
       if startTime then
        return {
            startTime = startTime,
            duration = duration,
            enable = enable == 1
        }
       end
    end
    return nil
end

---@param unitId UnitToken
---@param index number UnitAura 支持index和name，C_UnitAuras.GetBuffDataByIndex只支持number，
---@param filter string? UnitAura 支持“|”和“空格”拆分，C_UnitAuras.GetBuffDataByIndex支持管道符和空格
---@return {expirationTime: number, spellId: number}?
Api.GetAuraDataByIndex = function (unitId, index, filter)
    if C_UnitAuras and C_UnitAuras.GetAuraDataByIndex then
        local auraData = C_UnitAuras.GetAuraDataByIndex(unitId, index, filter)
        if auraData == nil then
            return nil
        end
        local result = {
            expirationTime = auraData.expirationTime,
            spellId = auraData.spellId
        }
        return result
    else
        ---@diagnostic disable-next-line: deprecated
        local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod = UnitAura(unitId, index, filter)
        if name then
            local result = {
                expirationTime = expirationTime,
                spellId = spellId
            }
            return result
        end
        return nil
    end
end