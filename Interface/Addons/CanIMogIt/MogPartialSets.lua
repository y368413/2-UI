--## Version: 2.1.3 ## Author: romdeau23
local MogPartialSets = {}
MogPartialSetsAddon = MogPartialSets

function MogPartialSets.defer(delay, callback)
    local timer

    return function (...)
        local args = {...}
        local argCount = select('#', ...)

        -- re-schedule timer
        if timer then
            timer:Cancel()
        end

        timer = C_Timer.NewTimer(delay, function ()
            timer = nil
            callback(unpack(args, 1, argCount))
        end)
    end
end
local frame = CreateFrame('Frame')
local listenerMap = {}

function MogPartialSets.on(eventName, callback)
    if not listenerMap[eventName] then
        frame:RegisterEvent(eventName)
        listenerMap[eventName] = {}
    end

    table.insert(listenerMap[eventName], callback)
end

function MogPartialSets.off(eventName, callback)
    if listenerMap[eventName] then
        for i, listener in ipairs(listenerMap[eventName]) do
            if callback == listener then
                table.remove(listenerMap[eventName], i)

                if #listenerMap[eventName] == 0 then
                    frame:UnregisterEvent(eventName)
                    listenerMap[eventName] = nil
                end

                return true
            end
        end
    end

    return false
end

frame:SetScript('onEvent', function (_, eventName, ...)
    local toClear

    for _, listener in ipairs(listenerMap[eventName]) do
        if listener(...) == false then
            if not toClear then
                toClear = {}
            end

            table.insert(toClear, listener)
        end
    end

    if toClear then
        for _, listener in ipairs(toClear) do
            MogPartialSets.off(eventName, listener)
        end
    end
end)


local modules = {}

function MogPartialSets.module(...)
    local module = MogPartialSets.require(...)
    local private = {}

    table.insert(modules, module)

    return module, private
end

function MogPartialSets.require(...)
    local namespace = MogPartialSets

    for _, key in ipairs({...}) do
        if namespace[key] == nil then
            namespace[key] = {}
        end

        namespace = namespace[key]
    end

    return namespace
end

MogPartialSets.on('ADDON_LOADED', function (name)
    if name == "CanIMogIt" then
        for _, module in ipairs(modules) do
            if module.init then
                module.init()
            end
        end

        return false
    end
end)



function MogPartialSets.tryFinally(try, finally, ...)
    local status, err = pcall(try, ...)

    finally()

    if not status then
        error(err)
    end
end


local config, private = MogPartialSets.module('config')
local latestVersion = 9

function config.init()
    if MogPartialSetsAddonConfig then
        -- try to load and migrate existing config
        config.db = MogPartialSetsAddonConfig

        local success, result = pcall(private.migrateConfiguration)

        if not success then
            -- reset config on migration error
            private.loadDefaultConfig()
            CallErrorHandler(result)
        end
    else
        -- no config data yet - load default
        private.loadDefaultConfig()
    end
end

function private.loadDefaultConfig()
    MogPartialSetsAddonConfig = private.getDefaultConfig()
    config.db = MogPartialSetsAddonConfig
end

function private.getDefaultConfig()
    return {
        version = latestVersion,
        showExtraSets = true,
        maxMissingPieces = 2,
        onlyFavorite = false,
        favoriteVariants = false,
        useHiddenIfMissing = true,
        ignoredSlotMap = {
            [INVSLOT_BACK] = true,
            [INVSLOT_WRIST] = true,
        },
        hiddenSlotMap = {},
    }
end

function config.isIgnoredSlot(invType)
    return config.db.ignoredSlotMap[invType] ~= nil
end

function config.setIgnoredSlot(invType, isIgnored)
    if isIgnored then
        config.db.ignoredSlotMap[invType] = true
    else
        config.db.ignoredSlotMap[invType] = nil
    end
end

function config.isHiddenSlot(invType)
    return config.db.hiddenSlotMap[invType] ~= nil
end

function config.setHiddenSlot(invType, isIgnored)
    if isIgnored then
        config.db.hiddenSlotMap[invType] = true
    else
        config.db.hiddenSlotMap[invType] = nil
    end
end

function private.migrateConfiguration()
    for to = config.db.version + 1, latestVersion do
        private.migrations[to]()
    end

    config.db.version = latestVersion
end

private.migrations = {
    -- pre-v7 not supported anymore
    [7] = function ()
        config.db.splash = true
    end,

    [8] = function ()
        config.db.splash = nil
    end,

    [9] = function ()
        config.db.showExtraSets = config.db.enabled
        config.db.enabled = nil
        config.db.useHiddenIfMissing = true
        config.db.hiddenSlotMap = {}

        -- convert ignored slots from Enum.InventoryType to inventory slots
        local newIgnoredSlotMap = {}

        for invTypeEnumValue, flag in pairs(config.db.ignoredSlotMap) do
            newIgnoredSlotMap[C_Transmog.GetSlotForInventoryType(invTypeEnumValue + 1)] = true
        end

        config.db.ignoredSlotMap = newIgnoredSlotMap
    end,
}


local overrides, private = MogPartialSets.module('overrides')
local setLoader = MogPartialSets.require('setLoader')
local sourceLoader = MogPartialSets.require('sourceLoader')
local config = MogPartialSets.require('config')
local apis = {}
local gettingUsableSets = false
local updatingSets = false
local loadingSet = false

function overrides.prepareGlobal()
    private.prepare(C_TransmogSets, 'HasUsableSets')
    private.prepare(C_TransmogSets, 'GetUsableSets')
    private.prepare(C_TransmogSets, 'GetSetPrimaryAppearances')
    private.prepare(C_TransmogSets, 'GetSetInfo')
    private.prepare(C_TransmogSets, 'GetSourcesForSlot')
    private.prepare(C_TransmogSets, 'GetSourceIDsForSlot')
    private.prepare(C_TransmogCollection, 'GetSourceInfo')
end

function overrides.prepareWardrobe()
    private.prepare(WardrobeCollectionFrame.SetsTransmogFrame, 'UpdateSets')
    private.prepare(WardrobeCollectionFrame.SetsTransmogFrame, 'LoadSet')
    private.prepare(WardrobeCollectionFrame.SetsTransmogFrame, 'Refresh', 'RefreshSets')
end

function overrides.enable()
    private.override('HasUsableSets', private.hasUsableSets)
    private.override('GetUsableSets', private.getUsableSets)
    private.override('GetSetPrimaryAppearances', private.getSetPrimaryAppearances)
    private.override('GetSetInfo', private.getSetInfo)
    private.override('GetSourcesForSlot', private.getSourcesForSlot)
    private.override('GetSourceIDsForSlot', private.getSourceIdsForSlot)
    private.override('GetSourceInfo', private.getSourceInfo)
    private.override('UpdateSets', private.updateSets)
    private.override('LoadSet', private.loadSet)
    private.override('RefreshSets', private.refreshSets)
end

function overrides.callOriginal(identifier, ...)
    return apis[identifier].original(...)
end

function private.prepare(apiTable, method, identifier)
    apis[identifier or method] = {
        apiTable = apiTable,
        method = method,
        original = apiTable[method],
    }
end

function private.override(identifier, newFunc)
    apis[identifier].apiTable[apis[identifier].method] = newFunc
end

function private.hasUsableSets()
    return overrides.callOriginal('HasUsableSets') or #C_TransmogSets.GetUsableSets() > 0
end

function private.getUsableSets()
    local search
    local hasSearch = false

    if MogPartialSets.ui.isTransmogrifyingSets() then
        search = setLoader.normalizeSearchString(WardrobeCollectionFrameSearchBox:GetText())
        hasSearch = #search > 0
    end

    local usableSets = {}
    gettingUsableSets = true

    MogPartialSets.tryFinally(
        function ()
            local sets = setLoader.getAvailableSets()

            for _, set in pairs(sets) do
                local collectedSlots, totalSlots = setLoader.getSetProgress(set.setID)

                if
                    collectedSlots > 0
                    and (totalSlots - collectedSlots) <= config.db.maxMissingPieces
                    and (
                        not config.db.onlyFavorite
                        or (
                            set.favorite
                            or config.db.favoriteVariants and setLoader.setHasFavoriteVariant(set, sets)
                        )
                    )
                    and (
                        not hasSearch
                        or setLoader.stringMatchesSearch(set.name, search)
                        or set.label ~= nil and setLoader.stringMatchesSearch(set.label, search)
                    )
                then
                    set.collected = true

                    table.insert(usableSets, set)
                else
                    set.collected = false
                end
            end
        end,
        function ()
            gettingUsableSets = false
        end
    )

    return usableSets
end

function private.getSetPrimaryAppearances(setId)
    -- return only applicable apperances when loading a set or updating the list
    if private.shouldReturnModifiedSets() then
        return setLoader.getApplicableSetAppearances(setId, updatingSets or loadingSet and config.db.useHiddenIfMissing)
    end

    -- return original sources
    return setLoader.getSetPrimaryAppearancesCached(setId)
end

function private.getSetInfo(setId)
    local set = overrides.callOriginal('GetSetInfo', setId)

    if set and MogPartialSets.ui.isTransmogrifyingSets() then
        local collectedSlots, totalSlots = setLoader.getSetProgress(setId)

        if totalSlots then
            local parts = {}

            if set.label then
                table.insert(parts, set.label)
            end

            if IsAltKeyDown() then
                if set.label then
                    table.insert(parts, ' ')
                end

                table.insert(parts, string.format('(%d)', setId))
            end

            if #parts > 0 then
                table.insert(parts, '\n')
            end

            if set.description then
                table.insert(parts, string.format('|cff40c040%s|r\n', set.description))
            end

            table.insert(parts, string.format(
                '|cff808080(collected:|r |c%s%d/%d|cff808080)|r',
                setLoader.getSetProgressColor(collectedSlots, totalSlots),
                collectedSlots,
                totalSlots
            ))

            set.label = table.concat(parts)
        end
    end

    return set
end

function private.getSourcesForSlot(setId, slot)
    -- call original API if override should not be active
    if not private.shouldReturnModifiedSets() then
        return overrides.callOriginal('GetSourcesForSlot', setId, slot)
    end

    -- return hidden item if this slot is always hidden
    if config.isHiddenSlot(slot) then
        return {(sourceLoader.getInfo(setLoader.getSourceIdForHiddenSlot(slot)))}
    end

    -- try to find a usable source
    local usableSource = setLoader.getUsableSetSlotSource(setId, slot)

    if usableSource then
        return {usableSource}
    end

    -- fallback to hidden item
    return {(sourceLoader.getInfo(setLoader.getSourceIdForHiddenSlot(slot)))}
end

function private.getSourceIdsForSlot(setId, slot)
    local sourceIds = {}

    for _, sourceInfo in ipairs(C_TransmogSets.GetSourcesForSlot(setId, slot)) do
        table.insert(sourceIds, sourceInfo.sourceID)
    end

    return sourceIds
end

function private.getSourceInfo(sourceId)
    local source = overrides.callOriginal('GetSourceInfo', sourceId)

    -- fill in missing quality on few set items so set tooltips don't get stuck on "retrieving item information"
    if source and source.quality == nil and MogPartialSets.ui.isTransmogrifyingSets() then
        source.quality = 4 -- assume epic
    end

    return source
end

function private.updateSets(frame)
    MogPartialSets.tryFinally(
        function ()
            updatingSets = true
            overrides.callOriginal('UpdateSets', frame)
        end,
        function ()
            updatingSets = false
        end
    )
end

function private.loadSet(frame, setId)
    MogPartialSets.tryFinally(
        function ()
            loadingSet = true
            overrides.callOriginal('LoadSet', frame, setId)
        end,
        function ()
            loadingSet = false
        end
    )
end

function private.refreshSets(frame)
    overrides.callOriginal('RefreshSets', frame, false) -- don't reset
end

function private.shouldReturnModifiedSets()
    return not gettingUsableSets and (updatingSets or loadingSet) and MogPartialSets.ui.isTransmogrifyingSets()
end


local setLoader, private = MogPartialSets.module('setLoader')
local sourceLoader = MogPartialSets.require('sourceLoader')
local overrides = MogPartialSets.require('overrides')
local config = MogPartialSets.require('config')
local validSetCache = {} -- setId => bool
local primarySetAppearanceCache = {} -- setId => TransmogSetPrimaryAppearanceInfo[]
local setSlotSourceIdCache = {} -- setId => slot => sourceId[]
local usableSetSlotSourceCache = {} -- setId => slot => AppearanceSourceInfo
-- https://warcraft.wiki.gg/wiki/ClassId
local classMasks = {
    [1] = 2 ^ (1 - 1), -- WARRIOR
    [2] = 2 ^ (2 - 1), -- PALADIN
    [3] = 2 ^ (3 - 1), -- HUNTER
    [4] = 2 ^ (4 - 1), -- ROGUE
    [5] = 2 ^ (5 - 1), -- PRIEST
    [6] = 2 ^ (6 - 1), -- DEATHKNIGHT
    [7] = 2 ^ (7 - 1), -- SHAMAN
    [8] = 2 ^ (8 - 1), -- MAGE
    [9] = 2 ^ (9 - 1), -- WARLOCK
    [10] = 2 ^ (10 - 1), -- MONK
    [11] = 2 ^ (11 - 1), -- DRUID
    [12] = 2 ^ (12 - 1), -- DEMONHUNTER
    [13] = 2 ^ (13 - 1), -- EVOKER
}
local armorTypeClassMasks = {
    -- cloth
    [5] = bit.bor(classMasks[5], classMasks[8], classMasks[9]), -- PRIEST
    [8] = bit.bor(classMasks[5], classMasks[8], classMasks[9]), -- MAGE
    [9] = bit.bor(classMasks[5], classMasks[8], classMasks[9]), -- WARLOCK

    -- leather
    [4] = bit.bor(classMasks[4], classMasks[10], classMasks[11], classMasks[12]), -- ROGUE
    [10] = bit.bor(classMasks[4], classMasks[10], classMasks[11], classMasks[12]), -- MONK
    [11] = bit.bor(classMasks[4], classMasks[10], classMasks[11], classMasks[12]), -- DRUID
    [12] = bit.bor(classMasks[4], classMasks[10], classMasks[11], classMasks[12]), -- DEMONHUNTER

    -- mail
    [3] = bit.bor(classMasks[3], classMasks[7], classMasks[13]), -- HUNTER
    [7] = bit.bor(classMasks[3], classMasks[7], classMasks[13]), -- SHAMAN
    [13] = bit.bor(classMasks[3], classMasks[7], classMasks[13]), -- EVOKER

    -- plate
    [1] = bit.bor(classMasks[1], classMasks[2], classMasks[6]), -- WARRIOR
    [2] = bit.bor(classMasks[1], classMasks[2], classMasks[6]), -- PALADIN
    [6] = bit.bor(classMasks[1], classMasks[2], classMasks[6]), -- DEATHKNIGHT
}
local hiddenItemMap = {
    [INVSLOT_HEAD] = 134110,
    [INVSLOT_SHOULDER] = 134112,
    [INVSLOT_BACK] = 134111,
    [INVSLOT_CHEST] = 168659,
    [INVSLOT_BODY] = 142503,
    [INVSLOT_TABARD] = 142504,
    [INVSLOT_WRIST] = 168665,
    [INVSLOT_HAND] = 158329,
    [INVSLOT_WAIST] = 143539,
    [INVSLOT_LEGS] = 216696,
    [INVSLOT_FEET] = 168664,
}

function setLoader.init()
    MogPartialSets.on('TRANSMOG_COLLECTION_SOURCE_ADDED', private.onSourceAddedOrRemoved)
    MogPartialSets.on('TRANSMOG_COLLECTION_SOURCE_REMOVED', private.onSourceAddedOrRemoved)
end

function setLoader.clearCaches()
    validSetCache = {}
    primarySetAppearanceCache = {}
end

function setLoader.normalizeSearchString(string)
    return string.lower(strtrim(string))
end

function setLoader.stringMatchesSearch(string, normalizedSearch)
    return string.find(setLoader.normalizeSearchString(string), normalizedSearch, 1, true) ~= nil
end

function setLoader.getAvailableSets()
    local sets = {}
    local classMask = private.getCurrentClassMask()
    local faction = UnitFactionGroup('player')

    for _, set in ipairs(C_TransmogSets.GetAllSets()) do
        if
            -- match class
            (set.classMask == 0 or bit.band(set.classMask, classMask) ~= 0)
            -- match faction
            and (set.requiredFaction == nil or set.requiredFaction == faction)
            -- validate set
            and private.validateSet(set.setID)
        then
            sets[set.setID] = set
        end
    end

    return sets
end

function setLoader.getSetProgress(setId)
    local collectedSlots = 0
    local totalSlots = 0

    private.iterateSetApperances(setId, function (slot)
        if
            not config.isIgnoredSlot(slot)
            and not config.isHiddenSlot(slot)
        then
            totalSlots = totalSlots + 1

            if setLoader.getUsableSetSlotSource(setId, slot) then
                collectedSlots = collectedSlots + 1
            end
        end
    end)

    return collectedSlots, totalSlots
end

function setLoader.getSetProgressColor(current, max)
    if current >= max then
        return 'ff008000'
    elseif max > 0 and current / max >= 0.49 then
        return 'fffea000'
    else
        return 'ff800000'
    end
end

function setLoader.setHasFavoriteVariant(set, availableSets)
    local baseSetId

    if set.baseSetID then
        -- this is a variant set
        baseSetId = set.baseSetID

        -- check whether the base set is favorited
        if availableSets[set.baseSetID] and availableSets[set.baseSetID].favorite then
            return true
        end
    else
        -- this is a base set
        baseSetId = set.setID
    end

    -- check variants of the base set
    local variants = C_TransmogSets.GetVariantSets(baseSetId)

    if type(variants) == 'table' then
        for _, variant in ipairs(variants) do
            if variant.favorite then
                return true
            end
        end
    end

    return false
end

function setLoader.getSetPrimaryAppearancesCached(setId)
    if primarySetAppearanceCache[setId] == nil then
        primarySetAppearanceCache[setId] = overrides.callOriginal('GetSetPrimaryAppearances', setId)
    end

    return primarySetAppearanceCache[setId]
end

function setLoader.getApplicableSetAppearances(setId, fallbackToHidden)
    local appearances = {}

    -- add collected appearances
    private.iterateSetApperances(setId, function (slot)
        if config.isHiddenSlot(slot) then
            -- always hidden slot
            table.insert(appearances, {collected = true, appearanceID = setLoader.getSourceIdForHiddenSlot(slot)})
        else
            local usableSource = setLoader.getUsableSetSlotSource(setId, slot)

            if usableSource then
                -- got usable source
                table.insert(appearances, {collected = true, appearanceID = usableSource.sourceID})
            elseif fallbackToHidden then
                -- hidden fallback
                table.insert(appearances, {collected = true, appearanceID = setLoader.getSourceIdForHiddenSlot(slot)})
            end
        end
    end)

    return appearances
end

function setLoader.getSourceIdForHiddenSlot(slot)
    return (select(2, C_TransmogCollection.GetItemInfo(hiddenItemMap[slot])))
end

function setLoader.getUsableSetSlotSource(setId, slot)
    if usableSetSlotSourceCache[setId] and usableSetSlotSourceCache[setId][slot] then
        return usableSetSlotSourceCache[setId][slot]
    end

    for _, sourceId in ipairs(private.getSetSlotSourceIds(setId, slot)) do
        local sourceInfo, isPending = sourceLoader.getInfo(sourceId, true)

        if sourceInfo and sourceInfo.useErrorType == nil then
            if isPending then
                sourceInfo = CopyTable(sourceInfo, true)
                sourceInfo.name = '' -- needed to make WardrobeSetsTransmogMixin:LoadSet() happy
            else
                assert(sourceInfo.name)
                if not usableSetSlotSourceCache[setId] then
                    usableSetSlotSourceCache[setId] = {}
                end

                usableSetSlotSourceCache[setId][slot] = sourceInfo
            end

            return sourceInfo
        end
    end
end

function private.getCurrentClassMask()
    local classId = select(3, UnitClass('player'))

    if config.db.showExtraSets then
        return armorTypeClassMasks[classId]
    end

    return classMasks[classId]
end

function private.validateSet(setId)
    -- if true then return setId == 2162 end

    if validSetCache[setId] == nil then
        local valid = false

        for _, appearanceInfo in ipairs(setLoader.getSetPrimaryAppearancesCached(setId)) do
            local sourceInfo = sourceLoader.getInfo(appearanceInfo.appearanceID)

            if sourceInfo then
                local slot = C_Transmog.GetSlotForInventoryType(sourceInfo.invType)
                local slotSources = C_TransmogSets.GetSourcesForSlot(setId, slot)
                local index = CollectionWardrobeUtil.GetDefaultSourceIndex(slotSources, appearanceInfo.appearanceID)

                if slotSources[index] then
                    setLoader.getUsableSetSlotSource(setId, slot) -- trigger loading of source data

                    valid = true
                end
            end

            if not valid then
                break
            end
        end

        validSetCache[setId] = valid
    end

    return validSetCache[setId]
end

function private.iterateSetApperances(setId, callback)
    for _, appearanceInfo in ipairs(setLoader.getSetPrimaryAppearancesCached(setId)) do
        local sourceInfo = sourceLoader.getInfo(appearanceInfo.appearanceID)

        if sourceInfo then
            local slot = C_Transmog.GetSlotForInventoryType(sourceInfo.invType)

            if (callback(slot, sourceInfo) == false) then
                break
            end
        end
    end
end

function private.getSetSlotSourceIds(setId, slot)
    if setSlotSourceIdCache[setId] and setSlotSourceIdCache[setId][slot] then
        return setSlotSourceIdCache[setId][slot]
    end

    local sourceMap = {}

    -- map all known collected source IDs
    private.iterateSetApperances(setId, function (appearanceSlot, primarySourceInfo)
        if appearanceSlot == slot then
            if primarySourceInfo.isCollected then
                sourceMap[primarySourceInfo.sourceID] = true
            end

            for _, sourceInfo in ipairs(overrides.callOriginal('GetSourcesForSlot', setId, slot)) do
                if sourceInfo.isCollected then
                    sourceMap[sourceInfo.sourceID] = true
                end
            end

            for _, sourceInfo in ipairs(C_TransmogCollection.GetAppearanceSources(
                primarySourceInfo.visualID,
                C_TransmogCollection.GetCategoryForItem(primarySourceInfo.sourceID),
                TransmogUtil.GetTransmogLocation(
                    slot,
                    Enum.TransmogType.Appearance,
                    Enum.TransmogModification.Main
                )
            ) or {}) do
                if sourceInfo.isCollected then
                    sourceMap[sourceInfo.sourceID] = true
                end
            end
        end
    end)

    -- convert to list, cache, return
    local sourceIds = {}

    for sourceId in pairs(sourceMap) do
        table.insert(sourceIds, sourceId)
    end

    if not setSlotSourceIdCache[setId] then
        setSlotSourceIdCache[setId] = {}
    end

    setSlotSourceIdCache[setId][slot] = sourceIds

    return sourceIds
end

function private.onSourceAddedOrRemoved(sourceId)
    local sets = C_TransmogSets.GetSetsContainingSourceID(sourceId)

    if sets then
        for _, setId in pairs(sets) do
            validSetCache[setId] = nil
            primarySetAppearanceCache[setId] = nil
            setSlotSourceIdCache[setId] = nil
            usableSetSlotSourceCache[setId] = nil
        end
    end
end


local sourceLoader, private = MogPartialSets.module('sourceLoader')
local overrides = MogPartialSets.require('overrides');
local cache = {} -- sourceId => entry
local PENDING_TIMEOUT = 10

function sourceLoader.init()
    MogPartialSets.on('TRANSMOG_COLLECTION_SOURCE_ADDED', private.onSourceAddedOrRemoved)
    MogPartialSets.on('TRANSMOG_COLLECTION_SOURCE_REMOVED', private.onSourceAddedOrRemoved)
end

function sourceLoader.getInfo(sourceId, reloadPending)
    local entry = cache[sourceId] or private.createEntry(sourceId)

    if not entry.valid then
        return nil, false
    end

    if reloadPending and entry.pending then
        private.reloadEntry(entry)
    end

    return entry.info, entry.pending
end

function sourceLoader.clearCache()
    cache = {}
end

function private.createEntry(sourceId)
    local info = overrides.callOriginal('GetSourceInfo', sourceId)
    local entry

    if info then
        entry = {
            valid = true,
            info = info,
            firstLoadTime = GetTime(),
            pending = info.name == nil,
        }
    else
        entry = {valid = false}
    end

    cache[sourceId] = entry

    return entry
end

function private.reloadEntry(entry)
    if GetTime() - entry.firstLoadTime >= PENDING_TIMEOUT then
        entry.pending = false
        entry.info.name = '' -- fake a loaded info 🤷
        return
    end

    local info = overrides.callOriginal('GetSourceInfo', entry.info.sourceID)

    if info then
        entry.info = info
        entry.pending = info.name == nil
    end
end

function private.onSourceAddedOrRemoved(sourceId)
    cache[sourceId] = nil
end


local ui, private = MogPartialSets.module('ui')
local deferredRefreshSets

function ui.init()
    --if not MogPartialSets.isAddonEnabled('ExtendedSets') then
        deferredRefreshSets = MogPartialSets.defer(0.5, ui.refreshSets)
    --else
        -- disable deferred refresh when "Extended Transmog Sets" MogPartialSets is enabled
        -- (both addons refreshing on TRANSMOG_COLLECTION_ITEM_UPDATE causes a refresh loop)
        --deferredRefreshSets = function () end
    --end
end

function ui.attach()
    -- attach filter frames
    ui.filter.attach()

    -- handle transmog UI actions
    hooksecurefunc(WardrobeFrame, 'Show', private.onWardrobeShow)
    hooksecurefunc(WardrobeFrame, 'Hide', private.onWardrobeHide)
    hooksecurefunc(WardrobeCollectionFrame, 'SetTab', private.onWardrobeTabSwitch)

    -- handle some events
    MogPartialSets.on('TRANSMOG_COLLECTION_ITEM_UPDATE', private.onTransmogCollectionItemUpdate)
end

function ui.isTransmogrifyingSets()
    return WardrobeCollectionFrame:IsVisible()
        and WardrobeCollectionFrame.selectedTab == 2
        and C_Transmog.IsAtTransmogNPC()
end

function ui.refreshSets()
    if not ui.isTransmogrifyingSets() then
        return
    end

    private.clearSetData()
    private.updateSets()
end

function private.onWardrobeShow()
    -- refresh sets after re-opening the transmog sets UI
    if ui.isTransmogrifyingSets() then
        ui.refreshSets()
    end
end

function private.onWardrobeHide()
    -- hide filter dialog when transmog UI is closed
    ui.filter.hide()
end

function private.onWardrobeTabSwitch()
    -- hide filter dialog when tabs are switched
    ui.filter.hide()

    -- refresh sets when switching to transmog sets UI
    if ui.isTransmogrifyingSets() then
        ui.refreshSets()
    end
end

function private.onTransmogCollectionItemUpdate()
    deferredRefreshSets()
end

function private.clearSetData()
    WardrobeCollectionFrame.SetsTransmogFrame:OnEvent('TRANSMOG_COLLECTION_UPDATED')
end

function private.updateSets()
    for _, model in pairs(WardrobeCollectionFrame.SetsTransmogFrame.Models) do
        model.setID = -1 -- clear model set IDs to force an update
    end

    WardrobeCollectionFrame.SetsTransmogFrame:UpdateSets()
end

local filter, private = MogPartialSets.module('ui', 'filter')

function filter.attach()
    MogPartialSets_FilterButton:SetParent(WardrobeCollectionFrame.SetsTransmogFrame)
    MogPartialSets_FilterButton:SetPoint('LEFT', WardrobeCollectionFrameSearchBox, 'RIGHT', 2, -1)
    MogPartialSets_FilterButton:Show()
end

function filter.updateStates()
    MogPartialSets_Filter.FavoriteVariantsToggle:SetAlpha(MogPartialSets.config.db.onlyFavorite and 1 or 0.5)
end

function filter.onChange()
    MogPartialSets.ui.refreshSets()
    filter.updateStates()
end

function filter.hide()
    MogPartialSets_Filter:Hide()
end

function filter.onRefreshClicked()
    MogPartialSets.setLoader.clearCaches()
    MogPartialSets.sourceLoader.clearCache()
    MogPartialSets.ui.refreshSets()
end

local main, private = MogPartialSets.module('main')
local initialized = false

function main.init()
    MogPartialSets.overrides.prepareGlobal()
    MogPartialSets.on('TRANSMOGRIFY_UPDATE', private.onTransmogrifyAction)
    MogPartialSets.on('TRANSMOGRIFY_OPEN', private.onTransmogrifyAction)
end

function private.onTransmogrifyAction()
    if not initialized and WardrobeCollectionFrame then
        MogPartialSets.overrides.prepareWardrobe()
        MogPartialSets.overrides.enable()
        MogPartialSets.ui.attach()
        initialized = true
    end

    return not initialized
end
