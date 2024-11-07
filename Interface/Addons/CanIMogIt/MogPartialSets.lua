local _, MogPartialSets = ...
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


local _, MogPartialSets = ...
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
