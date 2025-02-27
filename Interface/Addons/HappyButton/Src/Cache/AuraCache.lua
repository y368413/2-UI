local addonName, _ = ...


---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class Utils: AceModule
local U = addon:GetModule('Utils')

---@class Api: AceModule
local Api = addon:GetModule("Api")

---@class AuraCacheInfo
---@field name string
---@field instanceID number
---@field expirationTime number
---@field spellId SpellID
---@field charges number
---@field isHarmful boolean
---@field isHelpful boolean


---@class AuraCacheTaskInfo
---@field remainingTimes number[]
---@field exist true | nil
---@field aura AuraCacheInfo | nil
---@field isRequested boolean false表示没有从API获取数据

---@class AuraCache: AceModule
---@field cache table<UnitId, table<SpellID, AuraCacheTaskInfo>>
local AuraCache = addon:NewModule("AuraCache")

---@diagnostic disable-next-line: deprecated
local UnitBuff = UnitBuff
local GetAuraDataByIndex = C_UnitAuras and C_UnitAuras.GetAuraDataByIndex or nil
local GetAuraDataByAuraInstanceID = C_UnitAuras and C_UnitAuras.GetAuraDataByAuraInstanceID or nil


function AuraCache:Initial()
    AuraCache.cache = {player = {}, target = {}}
end

---@param auraData  AuraData
---@return AuraCacheInfo
function AuraCache:AuraDataToHbAura(auraData)
    ---@type AuraCacheInfo
    local hbAura = {
        name = auraData.name,
        instanceID = auraData.auraInstanceID,
        expirationTime = auraData.expirationTime,
        spellId = auraData.spellId,
        charges = auraData.charges,
        isHarmful = auraData.isHarmful,
        isHelpful = auraData.isHelpful,
    }
    return hbAura
end


-- 通过API获取单个aura信息
---@param target UnitId
---@param spellId SpellID
---@return AuraCacheInfo | nil
function AuraCache:FetchAura(target, spellId)
    if GetAuraDataByIndex then
        for i = 1, 300 do
            local aura = GetAuraDataByIndex(target, i)
            if aura == nil then
                return nil
            end
            if aura.spellId == spellId then
                return AuraCache:AuraDataToHbAura(aura)
            end
        end
        return nil
    else
        for i = 1, 150 do
            ---@diagnostic disable-next-line: deprecated
            local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal, _spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod = UnitBuff(target, i)
            if spellId == nil then
                break
            end
            if _spellId == spellId then
                ---@type AuraCacheInfo
                local auraData = {
                    name = name,
                    instanceID = -1,
                    expirationTime = expirationTime,
                    spellId = _spellId,
                    charges = count,
                    isHarmful = false,
                    isHelpful = true
                }
                return auraData
            end
        end
        for i = 1, 150 do
            ---@diagnostic disable-next-line: deprecated
            local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal, _spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod = UnitDebuff(target, i)
            if spellId == nil then
                return nil
            end
            if _spellId == spellId then
                ---@type AuraCacheInfo
                local auraData = {
                    name = name,
                    instanceID = -1,
                    expirationTime = expirationTime,
                    spellId = spellId,
                    charges = count,
                    isHarmful = true,
                    isHelpful = false
                }
                return auraData
            end
        end
        return nil
    end
end

-- 通过API完全更新目标aura信息
---@param target UnitId
function AuraCache:FetchAllAuras(target)
    -- 第一步：将目标的信息重置
    AuraCache:ClearAllAuras(target)
    if GetAuraDataByIndex then
        for i = 1, 300 do
            local aura = GetAuraDataByIndex(target, i)
            if aura == nil then
                break
            end
            if AuraCache.cache[target][aura.spellId] ~= nil then
                AuraCache.cache[target][aura.spellId].aura = AuraCache:AuraDataToHbAura(aura)
            end
        end
    else
        for i = 1, 150 do
            ---@diagnostic disable-next-line: deprecated
            local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod = UnitBuff(target, i)
            if spellId == nil then
                break
            end
            if AuraCache.cache[target][spellId] ~= nil then
                ---@type AuraCacheInfo
                local auraData = {
                    name = name,
                    instanceID = -1,
                    expirationTime = expirationTime,
                    spellId = spellId,
                    charges = count,
                    isHarmful = false,
                    isHelpful = true
                }
                AuraCache.cache[target][spellId].aura = auraData
            end
        end
        for i = 1, 150 do
            ---@diagnostic disable-next-line: deprecated
            local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod = UnitDebuff(target, i)
            if spellId == nil then
                break
            end
            if AuraCache.cache[target][spellId] ~= nil then
               ---@type AuraCacheInfo
                local auraData = {
                    name = name,
                    instanceID = -1,
                    expirationTime = expirationTime,
                    spellId = spellId,
                    charges = count,
                    isHarmful = true,
                    isHelpful = false
                }
                AuraCache.cache[target][spellId].aura = auraData
            end
        end
    end
end

-- 清除一个目标的所有aura信息
---@param target UnitId
function AuraCache:ClearAllAuras(target)
    for _, v in pairs(AuraCache.cache[target]) do
        v.aura = nil
    end
end



---@param event EventString
---@param eventArgs any
function AuraCache:Update(event, eventArgs)
    if event == "PLAYER_TARGET_CHANGED" then
        if UnitExists("target") then
            AuraCache:FetchAllAuras("target")
        else
            AuraCache:ClearAllAuras("target")
        end
        AuraCache:CreateTargetAllTickerTasks("target")
        return
    end
    if event == "UNIT_AURA" then
        local target = eventArgs[1]
        -- 目前只处理玩家和目标的光环
        if target ~= "player" and target ~= "target" then
            return
        end
        -- 没有AuraCache:InitialTargetAura方法，则全部更新，因为UnitAura无法获取instanceID来更新
        if not GetAuraDataByIndex then
            AuraCache:FetchAllAuras(target)
            AuraCache:CreateTargetAllTickerTasks(target)
            return
        end
        ---@type UnitAuraUpdateInfo
        local updateInfo = eventArgs[2]
        if updateInfo.isFullUpdate == true then
            AuraCache:FetchAllAuras(target)
            AuraCache:CreateTargetAllTickerTasks(target)
        end
        if updateInfo.addedAuras then
            for _, aura in ipairs(updateInfo.addedAuras) do
                if AuraCache.cache[target][aura.spellId] ~= nil then
                    AuraCache.cache[target][aura.spellId].aura = AuraCache:AuraDataToHbAura(aura)
                    AuraCache:CreateTargetTickerTask(target, aura.spellId)
                end
            end
        end
        if updateInfo.updatedAuraInstanceIDs and GetAuraDataByAuraInstanceID then
            for _, _instanceID in ipairs(updateInfo.updatedAuraInstanceIDs) do
                for spellId, task in pairs(AuraCache.cache[target]) do
                    if task.aura and task.aura.instanceID == _instanceID then
                        local auraInfo = GetAuraDataByAuraInstanceID(target, _instanceID)
                        if auraInfo then
                            AuraCache.cache[target][spellId].aura = AuraCache:AuraDataToHbAura(auraInfo)
                        end
                        AuraCache:CreateTargetTickerTask(target, spellId)
                        break
                    end
                end
            end
        end
        if updateInfo.removedAuraInstanceIDs then
            for _, _instanceID in ipairs(updateInfo.removedAuraInstanceIDs) do
                for spellId, task in pairs(AuraCache.cache[target]) do
                    if task.aura and task.aura.instanceID == _instanceID then
                        AuraCache.cache[target][spellId].aura = nil
                        AuraCache:CreateTargetTickerTask(target, spellId)
                        break
                    end
                end
            end
        end
    end
end


--- 按aura来更新目标任务
---@param target UnitId
---@param spellId SpellID
function AuraCache:CreateTargetTickerTask(target, spellId)
    local task = AuraCache.cache[target][spellId]
    if task.isRequested == false then
        AuraCache.cache[target][spellId].isRequested = true
        AuraCache.cache[target][spellId].aura = AuraCache:FetchAura(target, spellId)
    end
    if task.aura == nil then
         -- 如果没有这个buff了，立即执行
        addon:SendMessage(const.EVENT.HB_UNIT_AURA, target, spellId)
        return
    end
    -- 是否需要马上发送消息
    local needSendMessageNow = false
    if task.exist then
        needSendMessageNow = true
    end
    if task.remainingTimes then
        for _, remainingTime in ipairs(task.remainingTimes) do
            local realRemainingTime = task.aura.expirationTime - GetTime() -- 计算出当前aura剩余时间，去和触发器的剩余时间比较
            if realRemainingTime > remainingTime then
                -- 当前剩余时间 - 触发器预设剩余时间 + 0.05秒延迟
                C_Timer.NewTimer(realRemainingTime - remainingTime + 0.05, function ()
                    addon:SendMessage(const.EVENT.HB_UNIT_AURA, target, task.aura.spellId)
                end)
            else
                -- 如果时间已经过了，那么立即执行
                needSendMessageNow = true
            end
        end
    end
    if needSendMessageNow == true then
        addon:SendMessage(const.EVENT.HB_UNIT_AURA, target, task.aura.spellId)
    end
end

-- 更新目标全部任务
---@param target UnitId
function AuraCache:CreateTargetAllTickerTasks(target)
    local tasks = AuraCache.cache[target]
    if tasks == nil then
        return
    end
    for spellID, task in pairs(tasks) do
        -- 立即触发一次
        addon:SendMessage(const.EVENT.HB_UNIT_AURA, target, spellID)
        if task.aura then
            for _, remainingTime in ipairs(task.remainingTimes) do
                local realRemainingTime = task.aura.expirationTime - GetTime()
                if realRemainingTime > remainingTime then
                    -- 当前剩余时间 - 触发器预设剩余时间 + 0.05秒延迟
                    C_Timer.NewTimer(realRemainingTime - remainingTime + 0.05, function ()
                        addon:SendMessage(const.EVENT.HB_UNIT_AURA, target, spellID)
                    end)
                end
            end
        end
    end
end


-- 从缓存中获取数据，如果没有可以返回nil
---@param target UnitId
---@param spellId SpellID
---@return AuraCacheInfo | nil
function AuraCache:Get(target, spellId)
    if AuraCache.cache[target][spellId] == nil then
        ---@type AuraCacheTaskInfo
        AuraCache.cache[target][spellId] = {
            remainingTimes = {},
            exist = nil,
            aura = nil,
            isRequested = false
        }
    end
    if AuraCache.cache[target][spellId].isRequested == false then

    end
    return AuraCache.cache[target][spellId].aura
end

-- 在缓存中添加新的追踪信息
-- 如果改变了追踪信息，那么需要立即执行一次任务
---@param target UnitId
---@param spellId SpellID
---@param remainingTime number | nil
---@param exist boolean | nil
function AuraCache:PutTask(target, spellId, remainingTime, exist)
    if AuraCache.cache[target][spellId] == nil then
        ---@type AuraCacheTaskInfo
        AuraCache.cache[target][spellId] = {
            remainingTimes = {},
            exist = nil,
            aura = nil,
            isRequested = false
        }
    end
    -- 如果没有获取过，获取一次
    if AuraCache.cache[target][spellId].isRequested == false then
        AuraCache.cache[target][spellId].isRequested = true
        AuraCache.cache[target][spellId].aura = AuraCache:FetchAura(target, spellId)
    end
    -- 将需要监听内容添加到缓存中
    if exist ~= nil then
        if AuraCache.cache[target][spellId].exist == nil then
            AuraCache.cache[target][spellId].exist = true
        end
    end
    if remainingTime ~= nil then
        if U.Table.IsInArray(AuraCache.cache[target][spellId].remainingTimes, remainingTime) == false then
            table.insert(AuraCache.cache[target][spellId].remainingTimes, remainingTime)
            AuraCache:CreateTargetTickerTask(target, spellId)
        end
    end
end
