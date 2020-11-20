--## Version: 0.7.0 ## Author: romdeau23
local MogPartialSets = {}

MogPartialSets.frame = CreateFrame('Frame')
MogPartialSets.loaded = false
MogPartialSets.initialized = false
MogPartialSets.updateTimer = nil
MogPartialSets.pendingModelUpdate = false
MogPartialSets.pendingInvalidSetCacheClear = false
MogPartialSets.eventHandlers = {
    ADDON_LOADED = 'onAddonLoaded',
    TRANSMOGRIFY_UPDATE = 'onTransmogrifyAction',
    TRANSMOGRIFY_OPEN = 'onTransmogrifyAction',
    GET_ITEM_INFO_RECEIVED = 'onItemInfoReceived',
    TRANSMOG_COLLECTION_ITEM_UPDATE = 'onTransmogCollectionItemUpdate',
}
MogPartialSets.apiOverrides = {}
MogPartialSets.validSetCache = {}
MogPartialSets.setSourceCache = {}
MogPartialSets.sourceInfoCache = {}
MogPartialSets.usableSourceCache = {}

function MogPartialSets:registerEvents()
    for event, _ in pairs(self.eventHandlers) do
        self.frame:RegisterEvent(event)
    end

    self.frame:SetScript('OnEvent', function (frame, event, ...)
        if self[self.eventHandlers[event]](self, ...) then
            frame:UnregisterEvent(event)
        end
    end)
end

function MogPartialSets:onAddonLoaded(loadedAddonName)
    if loadedAddonName == "TransMogMaster" then
        self:initConfiguration()
        self:prepareGlobalApiOverrides()
        self.loaded = true
        return true
    end
end

function MogPartialSets:prepareApiOverride(apiTable, method, identifier)
    self.apiOverrides[identifier or method] = {
        apiTable = apiTable,
        method = method,
        original = apiTable[method],
    }
end

function MogPartialSets:overrideApi(identifier, newFunc)
    self.apiOverrides[identifier].apiTable[self.apiOverrides[identifier].method] = newFunc
end

function MogPartialSets:callOriginalApi(identifier, ...)
    return self.apiOverrides[identifier].original(...)
end

function MogPartialSets:onTransmogrifyAction()
    if self.loaded then
        if not self.initialized and WardrobeCollectionFrame then
            self:prepareWardrobeApiOverrides()
            self:initOverrides()
            self:initUi()
            self.initialized = true
        end

        return self.initialized
    end
end

function MogPartialSets:onItemInfoReceived(itemId)
    if self.loaded and self.initialized and itemId > 0 then
        self:refreshAfter(0.5, true)
    end
end

function MogPartialSets:onTransmogCollectionItemUpdate()
    if self.loaded and self.initialized then
        self:refreshAfter(0.5, false, true)
    end
end

function MogPartialSets:initConfiguration()
    if MogPartialSetsAddonConfig == nil then
        self:setDefaultConfiguration()
        return
    end
                MogPartialSetsAddonConfig.ignoredSlotMap = {}

                if MogPartialSetsAddonConfig.ignoreBracers then
                    MogPartialSetsAddonConfig.ignoredSlotMap[Enum.InventoryType.IndexWristType] = true
                end

                MogPartialSetsAddonConfig.ignoreBracers = nil
end

function MogPartialSets:setDefaultConfiguration()
    MogPartialSetsAddonConfig = {
        enabled = true,
        maxMissingPieces = 2,
        onlyFavorite = false,
        favoriteVariants = false,
        ignoredSlotMap = {},
    }
end


function MogPartialSets:notifyConfigUpdated()
    self:refreshSetsFrame()
    self:updateUi()
end

function MogPartialSets:prepareGlobalApiOverrides()
    self:prepareApiOverride(C_TransmogSets, 'HasUsableSets')
    self:prepareApiOverride(C_TransmogSets, 'GetUsableSets')
    self:prepareApiOverride(C_TransmogSets, 'GetSetSources')
    self:prepareApiOverride(C_TransmogSets, 'GetSetInfo')
    self:prepareApiOverride(C_TransmogSets, 'GetSourcesForSlot')
    self:prepareApiOverride(C_TransmogCollection, 'GetSourceInfo')
end

function MogPartialSets:prepareWardrobeApiOverrides()
    self:prepareApiOverride(WardrobeCollectionFrame.SetsTransmogFrame, 'UpdateSets', 'UpdateSets')
    self:prepareApiOverride(WardrobeCollectionFrame.SetsTransmogFrame, 'LoadSet', 'LoadSet')
end

function MogPartialSets:setIgnoredSlot(invType, isIgnored)
    if isIgnored then
        MogPartialSetsAddonConfig.ignoredSlotMap[invType] = true
    else
        MogPartialSetsAddonConfig.ignoredSlotMap[invType] = nil
    end

    self:notifyConfigUpdated()
end

function MogPartialSets:isIgnoredSlot(invType)
    return MogPartialSetsAddonConfig.ignoredSlotMap[invType] ~= nil
end

function MogPartialSets:getAvailableSets()
    local sets = {}

    for _, set in ipairs(C_TransmogSets.GetAllSets()) do
        if self:isValidSet(set.setID) then
            sets[set.setID] = set
        end
    end

    return sets
end

function MogPartialSets:isValidSet(setId)
    if self.validSetCache[setId] == nil then
        for sourceId in pairs(self:getCollectedSetSources(setId)) do
            local valid = false
            local sourceInfo = self:callOriginalApi('GetSourceInfo', sourceId)

            if sourceInfo then
                local slot = C_Transmog.GetSlotForInventoryType(sourceInfo.invType)
                local slotSources = C_TransmogSets.GetSourcesForSlot(setId, slot)
                local index = WardrobeCollectionFrame_GetDefaultSourceIndex(slotSources, sourceId)

                if slotSources[index] then
                    valid = true
                end
            end

            if not valid then
                self.validSetCache[setId] = false
                break
            end
        end

        if self.validSetCache[setId] == nil then
            self.validSetCache[setId] = true
        end
    end

    return self.validSetCache[setId]
end

function MogPartialSets:getSetProgress(setId)
    local collectedSlots
    local totalSlots
    local sources = self:getSetSources(setId)

    if sources then
        collectedSlots = 0
        totalSlots = 0

        for sourceId, collected in pairs(sources) do
            local sourceInfo = self:getSourceInfo(sourceId)

            if sourceInfo and not self:isIgnoredSlot(sourceInfo.invType - 1) then
                totalSlots = totalSlots + 1

                if collected or self:isUsableSource(sourceId) then
                    collectedSlots = collectedSlots + 1
                end
            end
        end
    end

    return collectedSlots, totalSlots
end

function MogPartialSets:getSetSources(setId)
    if self.setSourceCache[setId] == nil then
        self.setSourceCache[setId] = self:callOriginalApi('GetSetSources', setId)
    end

    return self.setSourceCache[setId]
end

function MogPartialSets:getCollectedSetSources(setId)
    local sources = {}

    for sourceId, collected in pairs(self:getSetSources(setId)) do
        if collected or self:isUsableSource(sourceId) then
            sources[sourceId] = true
        end
    end

    return sources
end

function MogPartialSets:getSourceInfo(sourceId)
    if self.sourceInfoCache[sourceId] == nil then
        self.sourceInfoCache[sourceId] = self:callOriginalApi('GetSourceInfo', sourceId)
    end

    return self.sourceInfoCache[sourceId]
end

function MogPartialSets:isUsableSource(sourceId)
    if self.usableSourceCache[sourceId] == nil then
        local usable = false
        local loaded = true
        local sourceInfo = self:getSourceInfo(sourceId)

        if sourceInfo then
            local appearanceSources = C_TransmogCollection.GetAppearanceSources(sourceInfo.visualID)

            if appearanceSources then
                for _, appearanceInfo in pairs(appearanceSources) do
                    -- check isCollected, useError and make sure the item is loaded
                    -- (useError may only be available after the item has been loaded)
                    if appearanceInfo.isCollected and appearanceInfo.useError == nil and not appearanceInfo.isHideVisual then
                        usable = true
                        loaded = GetItemInfo(appearanceInfo.itemID) ~= nil
                        break
                    end
                end
            end
        end

        if not loaded then
            -- don't cache items that aren't fully loaded
            return usable
        end

        self.usableSourceCache[sourceId] = usable
    end

    return self.usableSourceCache[sourceId]
end

function MogPartialSets:setHasFavoriteVariant(set, availableSets)
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

function MogPartialSets:isTransmogrifyingSets()
    return WardrobeCollectionFrame:IsVisible() and WardrobeCollectionFrame.selectedTab == 2 and WardrobeFrame_IsAtTransmogrifier()
end

function MogPartialSets:normalizeSearchString(string)
    return string.lower(strtrim(string))
end

function MogPartialSets:stringMatchesSearch(string, normalizedSearch)
    return string.find(self:normalizeSearchString(string), normalizedSearch, 1, true) ~= nil
end

function MogPartialSets:getProgressColor(current, max)
    if current >= max then
        return 'ff008000'
    elseif max > 0 and current / max >= 0.49 then
        return 'fffea000'
    else
        return 'ff800000'
    end
end

function MogPartialSets:initOverrides()
    local gettingUsableSets = false
    local updatingTransmogSets = false
    local loadingSet = false

    self:overrideApi('HasUsableSets', function ()
        return self:callOriginalApi('HasUsableSets') or #C_TransmogSets.GetUsableSets() > 0
    end)

    self:overrideApi('GetUsableSets', function ()
        -- call original function if partial sets are disabled
        if not MogPartialSetsAddonConfig.enabled then
            return self:callOriginalApi('GetUsableSets')
        end

        -- find partial sets
        local search
        local hasSearch = false

        if self:isTransmogrifyingSets() then
            search = self:normalizeSearchString(WardrobeCollectionFrameSearchBox:GetText())
            hasSearch = #search > 0
        end

        local usableSets = {}
        gettingUsableSets = true

        self:tryFinally(
            function ()
                local availableSets = self:getAvailableSets()

                for _, set in pairs(availableSets) do
                    local collectedSlots, totalSlots = self:getSetProgress(set.setID)

                    if
                        totalSlots
                        and collectedSlots > 0
                        and (totalSlots - collectedSlots) <= MogPartialSetsAddonConfig.maxMissingPieces
                        and (
                            not MogPartialSetsAddonConfig.onlyFavorite
                            or (
                                set.favorite
                                or MogPartialSetsAddonConfig.favoriteVariants and MogPartialSets:setHasFavoriteVariant(set, availableSets)
                            )
                        )
                        and (
                            not hasSearch
                            or self:stringMatchesSearch(set.name, search)
                            or set.label ~= nil and self:stringMatchesSearch(set.label, search)
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
    end)

    self:overrideApi('UpdateSets', function (frameSelf)
        self:tryFinally(
            function ()
                updatingTransmogSets = true
                self:callOriginalApi('UpdateSets', frameSelf)
            end,
            function ()
                updatingTransmogSets = false
            end
        )
    end)

    self:overrideApi('LoadSet', function (frameSelf, setId)
        self:tryFinally(
            function ()
                loadingSet = true
                self:callOriginalApi('LoadSet', frameSelf, setId)
            end,
            function ()
                loadingSet = false
            end
        )
    end)

    self:overrideApi('GetSetSources', function (setId)
        -- return only collected sources for transmogrification
        -- so that the models reflect the missing pieces
        if not gettingUsableSets and (updatingTransmogSets or loadingSet) then
            return self:getCollectedSetSources(setId)
        end

        -- return original sources if not transmogrifying or
        return self:getSetSources(setId)
    end)

    self:overrideApi('GetSetInfo', function (setId)
        local set = self:callOriginalApi('GetSetInfo', setId)

        if set and self:isTransmogrifyingSets() then
            local collectedSlots, totalSlots = self:getSetProgress(setId)

            if totalSlots then
                set.label = string.format(
                    '%s\n|cff808080'..COLLECTED..':|r |c%s%d/%d|cff808080|r',
                    set.label or '',
                    self:getProgressColor(collectedSlots, totalSlots),
                    collectedSlots,
                    totalSlots
                 )
            end
        end

        return set
    end)

    self:overrideApi('GetSourcesForSlot', function (setId, slot)
        local slotSources = self:callOriginalApi('GetSourcesForSlot', setId, slot)

        if not self:isTransmogrifyingSets() or #slotSources ~= 0 then
            return slotSources
        end

        -- fill in missing slot sources (e.g. sets that are hidden until completed)
        for sourceId in pairs(self:getCollectedSetSources(setId)) do
            local sourceInfo = self:getSourceInfo(sourceId)

            if sourceInfo and C_Transmog.GetSlotForInventoryType(sourceInfo.invType) == slot then
                table.insert(slotSources, sourceInfo)
                break
            end
        end

        return slotSources
    end)

    self:overrideApi('GetSourceInfo', function (sourceId)
        local source = self:callOriginalApi('GetSourceInfo', sourceId)

        -- fill in missing quality on few set items so set tooltips don't get stuck on "retrieving item information"
        if source and source.quality == nil and self:isTransmogrifyingSets() then
            source.quality = 4 -- assume epic
        end

        return source
    end)
end

function MogPartialSets:initUi()
    -- anchor filter button
    MogPartialSetsFilterButton:SetParent(WardrobeCollectionFrame.SetsTransmogFrame)
    MogPartialSetsFilterButton:SetPoint('LEFT', WardrobeCollectionFrameSearchBox, 'RIGHT', 2, -1)
    MogPartialSetsFilterButton:Show()

    -- set filter parent
    MogPartialSetsFilter:SetParent(UIFrame)

    -- handle tab switching
    hooksecurefunc('WardrobeCollectionFrame_SetTab', function ()
        -- hide sets filter when transmog UI is hidden or tabs are switched
        MogPartialSetsFilter:Hide()

        -- force refresh after opening the sets tab
        if self:isTransmogrifyingSets() then
            self:refreshAfter(0.5, true)
        end
    end)

    hooksecurefunc(WardrobeFrame, 'Hide', function ()
        MogPartialSetsFilter:Hide()
    end)

    -- update ui
    self:updateUi()
end

function MogPartialSets:updateUi()
    local enabled = MogPartialSetsAddonConfig.enabled

    local frames = {
        MogPartialSetsFilterOnlyFavoriteButton,
        MogPartialSetsFilterOnlyFavoriteText,
        MogPartialSetsFilterFavoriteVariantsButton,
        MogPartialSetsFilterFavoriteVariantsText,
        MogPartialSetsFilterMaxMissingPiecesEditBox,
        MogPartialSetsFilterMaxMissingPiecesText,
        MogPartialSetsFilterIgnoredSlotsText,
        MogPartialSetsFilterIgnoreHeadButton,
        MogPartialSetsFilterIgnoreHeadText,
        MogPartialSetsFilterIgnoreCloakButton,
        MogPartialSetsFilterIgnoreCloakText,
        MogPartialSetsFilterIgnoreBracersButton,
        MogPartialSetsFilterIgnoreBracersText,
        MogPartialSetsFilterIgnoreBootsButton,
        MogPartialSetsFilterIgnoreBootsText,
        MogPartialSetsFilterRefreshButton,
    }

    for _, frame in ipairs(frames) do
        self:toggleFilterFrame(frame, enabled)
    end

    if enabled then
        self:toggleFilterFrame(MogPartialSetsFilterFavoriteVariantsButton, MogPartialSetsAddonConfig.onlyFavorite)
        self:toggleFilterFrame(MogPartialSetsFilterFavoriteVariantsText, MogPartialSetsAddonConfig.onlyFavorite)
    end
end

function MogPartialSets:toggleFilterFrame(frame, enabled)
    if enabled then
        frame:SetAlpha(1)
    else
        frame:SetAlpha(0.5)
    end

    if frame.SetEnabled then
        frame:SetEnabled(enabled)
    end
end

function MogPartialSets:forceRefresh()
    self:clearCaches()
    self:refreshSetsFrame(true)
end

function MogPartialSets:refreshAfter(delay, updateModels, clearInvalidSetCache)
    if self.updateTimer then
        self.updateTimer:Cancel()
    end

    if updateModels then
        self.pendingModelUpdate = true
    end

    if clearInvalidSetCache then
        self.pendingInvalidSetCacheClear = true
    end

    self.updateTimer = C_Timer.NewTimer(delay, function ()
        if self.pendingInvalidSetCacheClear then
            self:clearInvalidSetCache()
        end

        self:refreshSetsFrame(self.pendingModelUpdate)
        self.updateTimer = nil
        self.pendingModelUpdate = false
        self.pendingInvalidSetCacheClear = false
    end)
end

function MogPartialSets:refreshSetsFrame(updateModels)
    WardrobeCollectionFrame.SetsTransmogFrame:OnEvent('TRANSMOG_COLLECTION_UPDATED')

    if updateModels then
        for _, model in pairs(WardrobeCollectionFrame.SetsTransmogFrame.Models) do
            model.setID = -1
        end

        WardrobeCollectionFrame.SetsTransmogFrame:UpdateSets()
    end
end

function MogPartialSets:clearCaches()
    self.validSetCache = {}
    self.setSourceCache = {}
    self.sourceInfoCache = {}
    self.usableSourceCache = {}
end

function MogPartialSets:clearInvalidSetCache()
    for id, valid in pairs(self.validSetCache) do
        if not valid then
            self.validSetCache[id] = nil
        end
    end
end

function MogPartialSets:tryFinally(try, finally, ...)
    local status, err = pcall(try, ...)

    finally()

    if not status then
        error(err)
    end
end

-- register events
MogPartialSets:registerEvents()