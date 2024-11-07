--------------------------------------------------------------
--【坐骑来源】--https://nga.178.com/read.php?tid=34295220
--------------------------------------------------------------
local mountsData = {}
local function UpdateMountsData()
    local mountIDs = C_MountJournal.GetMountIDs()
    for key, value in ipairs(mountIDs) do
        local creatureName, spellId, icon, active, summonable, source, isFavorite, isFactionSpecific, faction, hideOnChar, isCollected, mountID = C_MountJournal.GetMountInfoByID(value)
        if spellId then
            mountsData[spellId] = (isCollected and 1 or -1) * mountID
        end
    end
    for i = 1, C_MountJournal.GetNumMounts() do
        local creatureName, spellId, icon, active, summonable, source, isFavorite, isFactionSpecific, faction, hideOnChar, isCollected, mountID = C_MountJournal.GetDisplayedMountInfo(i)
        if spellId then
            mountsData[spellId] = (isCollected and 1 or -1) * mountID
        end
    end
end

local function showMountInfo(spellId)
    local mountID = mountsData[spellId]
    if (mountID) then
        local creatureDisplayID, descriptionText, sourceText, isSelfMount = C_MountJournal.GetMountInfoExtraByID(abs(mountID))
        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine("坐骑来源：", mountID > 0 and "(已收集)" or "(未收集)", mountID > 0 and 0 or 1, mountID > 0 and 1 or 0, 0, mountID > 0 and 0 or 1, mountID > 0 and 1 or 0, 0)
        GameTooltip:AddLine(sourceText, 1, 1, 1)
        GameTooltip:Show()
    end
end

local function hookMountBuffInfo(self, unit, index, filter)
    if InCombatLockdown() then return end
    if not UnitIsPlayer(unit) and not UnitPlayerControlled(unit) then return end
    local spellId = C_UnitAuras.GetAuraDataByIndex(unit, index, filter).spellId;
    showMountInfo(spellId)
end

local function hookMountBuffInfoForTarget(self, unit, auraInstanceID)
    if InCombatLockdown() then return end
    if not UnitIsPlayer(unit) and not UnitPlayerControlled(unit) then return end
    local aura = C_UnitAuras.GetAuraDataByAuraInstanceID(unit, auraInstanceID)
    local spellId = aura.spellId
    showMountInfo(spellId)
end

hooksecurefunc(GameTooltip, "SetUnitAura", function(...)
    hookMountBuffInfo(...)
end)
hooksecurefunc(GameTooltip, "SetUnitBuff", function(...)
    hookMountBuffInfo(...)
end)
hooksecurefunc(GameTooltip, "SetUnitBuffByAuraInstanceID",function(self, unit, auraInstanceID)
    hookMountBuffInfoForTarget(self, unit, auraInstanceID)
end)

local frame = CreateFrame("frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        UpdateMountsData()
    end
end)




