--## Version: 0.1.1  ## Author: romdeau23
local artifactCategoryId = Enum.TransmogCollectionType.Paired + 1
local origGetCategoryAppearances = C_TransmogCollection.GetCategoryAppearances
local origGetAppearanceSources = C_TransmogCollection.GetAppearanceSources

C_TransmogCollection.GetCategoryAppearances = function (categoryId, ...)
    local appearances = origGetCategoryAppearances(categoryId, ...)

    if categoryId == artifactCategoryId then
        for _, appearance in pairs(appearances) do
            if appearance.isCollected then
                appearance.isUsable = true
                appearance.alwaysShowItem = true
            end
        end
    end

    return appearances
end

C_TransmogCollection.GetAppearanceSources = function (appearanceId, categoryId)
    local sources = origGetAppearanceSources(appearanceId, categoryId)

    if categoryId == artifactCategoryId then
        for _, source in pairs(sources) do
            source.useError = nil
        end
    end

    return sources
end
