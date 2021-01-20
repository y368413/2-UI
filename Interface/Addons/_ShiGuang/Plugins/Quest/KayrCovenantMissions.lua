-- 0.3.5 --------------------------------------------------------------------------------------------------------------------
-- Addon class
-- --------------------------------------------------------
KayrCovenantMissions = _G["CreateFrame"]("Frame", "KayrCovenantMissions", UIParent)
KayrCovenantMissions.initDone = false
KayrCovenantMissions.showMissionHookDone = false


-- --------------------------------------------------------------------------------------------------------------------
-- Helpers
-- --------------------------------------------------------
local function CleanNumber(str)
    if not str then return end
    return _G["gsub"](str, "%p", "") -- Remove commas, points, etc.
end

local function RoundNumber(num, places)
    if not num then return end
    local mult = 10^(places or 0)
    return math.floor(num * mult + 0.5) / mult
end


-- --------------------------------------------------------------------------------------------------------------------
-- Text Color Helpers
-- --------------------------------------------------------
function ColorText(text, colorStr)
    return "|c" .. colorStr .. text .. "|r"
end
KayrCovenantMissions.ColorText = ColorText

local function goodText(text) return ColorText(text, "FF00FF88") end
local function midText(text) return ColorText(text, "FFFF8800") end
local function badText(text) return ColorText(text, "FFFF0000") end
local function warnText(text) return ColorText(text, "FFFFFF00") end


-- --------------------------------------------------------------------------------------------------------------------
-- GetNumMissionPlayerUnitsTotal
-- --------------------------------------------------------
function KayrCovenantMissions:GetNumMissionPlayerUnitsTotal()
    local numFollowers = 0
    local missionPage = _G["CovenantMissionFrame"]:GetMissionPage()
    for followerFrame in missionPage.Board:EnumerateFollowers() do
        if followerFrame:GetFollowerGUID() then
            numFollowers = numFollowers + 1
        end
    end
    return numFollowers
end


-- --------------------------------------------------------------------------------------------------------------------
-- Main Hook for success calculation
-- --------------------------------------------------------
function KayrCovenantMissions.CMFrame_ShowMission_Hook(...)
    local numPlayerUnits = KayrCovenantMissions:GetNumMissionPlayerUnitsTotal()
    if numPlayerUnits < 1 then
        KayrCovenantMissions:UpdateAdviceText("?")
        return
    end

    -- KLib:Con("KayrCovenantMissions.CMFrame_ShowMission_Hook")
    local missionPage = _G["CovenantMissionFrame"]:GetMissionPage()

    local allyHealthValue = missionPage.Board.AllyHealthValue:GetText()
    allyHealthValue = CleanNumber(allyHealthValue)

    local allyPowerValue = missionPage.Board.AllyPowerValue:GetText()
    allyPowerValue = CleanNumber(allyPowerValue)

    local enemyHealthValue = missionPage.Stage.EnemyHealthValue:GetText()
    enemyHealthValue = CleanNumber(enemyHealthValue)

    local enemyPowerValue = missionPage.Stage.EnemyPowerValue:GetText()
    enemyPowerValue = CleanNumber(enemyPowerValue)

    -- Don't / 0
    allyHealthValue = _G["max"](1, allyHealthValue)
    allyPowerValue = _G["max"](1, allyPowerValue)
    enemyHealthValue = _G["max"](1, enemyHealthValue)
    enemyPowerValue = _G["max"](1, enemyPowerValue)

    local roundsToBeatEnemy = RoundNumber(enemyHealthValue / allyPowerValue)
    if (enemyHealthValue % allyPowerValue) > 0 then roundsToBeatEnemy = roundsToBeatEnemy + 1 end

    local roundsBeforeBeaten = RoundNumber(allyHealthValue / enemyPowerValue)
    if (allyHealthValue % enemyPowerValue) > 0 then roundsBeforeBeaten = roundsBeforeBeaten + 1 end

    local successPossible = roundsToBeatEnemy < roundsBeforeBeaten

    -- KLib:Con(
    --     "KayrCovenantMissions.CMFrame_ShowMissionHook Values:",
    --     allyHealthValue, allyPowerValue, enemyHealthValue, enemyPowerValue
    -- )
    -- KLib:Con(
    --     "KayrCovenantMissions.CMFrame_ShowMissionHook Rounds:",
    --     roundsToBeatEnemy, roundsBeforeBeaten, successPossible
    -- )

    local adviceText = KayrCovenantMissions:ConstructAdviceText(roundsToBeatEnemy, roundsBeforeBeaten, successPossible)
    KayrCovenantMissions:UpdateAdviceText(adviceText)
    return ...
end

-- --------------------------------------------------------------------------------------------------------------------
-- ConstructAdviceText
-- --------------------------------------------------------
function KayrCovenantMissions:ConstructAdviceText(roundsToBeatEnemy, roundsBeforeBeaten, successPossible)
    local closeResult = (roundsBeforeBeaten - roundsToBeatEnemy) <= 3
    local numTextColor = "FFFF0000"
    if successPossible then
        numTextColor = "FF00FF88"
        if closeResult then
            numTextColor = "FFFF8800"
        end
    end
    local roundsToBeatEnemyStr = ColorText(roundsToBeatEnemy, numTextColor)
    local roundsBeforeBeatenStr = ColorText(roundsBeforeBeaten, numTextColor)

    local beatEnemytext = roundsToBeatEnemyStr .. " ↑"
    local beatenByEnemytext = roundsBeforeBeatenStr .. " ↓"

    local str = beatEnemytext .. "   " .. beatenByEnemytext
    if successPossible then
        if closeResult then
            str = str .. midText("   Emm...")
        else
            str = str .. goodText("   Yes")

        end
    else
        str = str .. badText("   No")
    end

    --str = str .. warnText("Warning: This guidance is a rough estimate. Unit abilities strongly influence the actual result.")
    return str
end


-- --------------------------------------------------------------------------------------------------------------------
-- UpdateAdviceText
-- --------------------------------------------------------
function KayrCovenantMissions:UpdateAdviceText(newText)
    local adviceFrame = self.adviceFrame
    adviceFrame.text:SetText(newText)
    adviceFrame:Show()
end


-- --------------------------------------------------------------------------------------------------------------------
-- Close Mission Hook
-- --------------------------------------------------------
function KayrCovenantMissions.CMFrame_CloseMission_Hook(...)
    KayrCovenantMissions.adviceFrame:Hide()
    return ...
end


-- --------------------------------------------------------------------------------------------------------------------
-- Init Hook - Fired when the covenant mission table is first accessed
-- --------------------------------------------------------
function KayrCovenantMissions.CMFrame_SetupTabs_Hook(...)
    --KLib:Con("KayrCovenantMissions.CMFrame_SetupTabs_Hook")
    if KayrCovenantMissions.showMissionHookDone then return end

    _G["hooksecurefunc"](_G["CovenantMissionFrame"], "ShowMission", KayrCovenantMissions.CMFrame_ShowMission_Hook)
    _G["hooksecurefunc"](_G["CovenantMissionFrame"], "UpdateAllyPower", KayrCovenantMissions.CMFrame_ShowMission_Hook)
    _G["hooksecurefunc"](_G["CovenantMissionFrame"], "UpdateEnemyPower", KayrCovenantMissions.CMFrame_ShowMission_Hook)

    _G["hooksecurefunc"](_G["CovenantMissionFrame"], "CloseMission", KayrCovenantMissions.CMFrame_CloseMission_Hook)

    local adviceFrame = _G["CreateFrame"]("Frame", "KayrCovenantMissionsAdvice", _G["CovenantMissionFrame"], nil)  --"TranslucentFrameTemplate"
    adviceFrame:SetPoint("BOTTOM", CovenantMissionFrame, "BOTTOM", 80, 8)
    adviceFrame:SetClampedToScreen(true)  -- To keep it on-screen when user has a tiny display resolution
    adviceFrame:SetFrameStrata("TOOLTIP")
    adviceFrame:Hide()
    KayrCovenantMissions.adviceFrame = adviceFrame
    KayrCovenantMissions.adviceFrame:SetSize(300, 40)

    local adviceFrameText = adviceFrame:CreateFontString(adviceFrame, "OVERLAY", "GameTooltipText")
    adviceFrame.text = adviceFrameText
    adviceFrameText:SetPoint("CENTER", 0, 0)
    --adviceFrameText:SetPoint("TOPLEFT", adviceFrame, "TOPLEFT", 14, -14)
    --adviceFrameText:SetPoint("BOTTOMRIGHT", adviceFrame, "BOTTOMRIGHT", -14, 14)
    adviceFrameText:SetText("[No Mission Selected]")

    KayrCovenantMissions.showMissionHookDone = true
    return ...
end

-- --------------------------------------------------------------------------------------------------------------------
-- Listen for Blizz Garrison UI being loaded
-- --------------------------------------------------------
function KayrCovenantMissions:ADDON_LOADED(event, addon)
    if addon == "Blizzard_GarrisonUI" then
        KayrCovenantMissions:Init()
    end
end

-- --------------------------------------------------------------------------------------------------------------------
-- Init
-- --------------------------------------------------------
function KayrCovenantMissions:Init()
    --KLib:Con("KayrCovenantMissions.Init")
    if self.initDone then return end
    _G["hooksecurefunc"](_G["CovenantMissionFrame"], "SetupTabs", self.CMFrame_SetupTabs_Hook)
    self.initDone = true
end

KayrCovenantMissions:RegisterEvent("ADDON_LOADED")
KayrCovenantMissions:SetScript("OnEvent", KayrCovenantMissions.ADDON_LOADED)