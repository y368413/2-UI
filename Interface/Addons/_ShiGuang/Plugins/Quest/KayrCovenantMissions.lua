-- 0.3.4
local max = _G["max"]
local gsub = _G["gsub"]
local hooksecurefunc = _G["hooksecurefunc"]
local CreateFrame = _G["CreateFrame"]
-- local IsAddOnLoaded = _G["IsAddOnLoaded"]
-- local UIParentLoadAddOn = _G["UIParentLoadAddOn"]

-- Debugging
local KLib = _G["KLib"]
if not KLib then
    KLib = {Con = function() end} -- No-Op if KLib not available
end


-- --------------------------------------------------------------------------------------------------------------------
-- Addon class
-- --------------------------------------------------------
KayrCovenantMissions = CreateFrame("Frame", "KayrCovenantMissions", UIParent)
KayrCovenantMissions.initDone = false
KayrCovenantMissions.showMissionHookDone = false


-- --------------------------------------------------------------------------------------------------------------------
-- Helpers
-- --------------------------------------------------------
local function CleanNumber(str)
    if not str then return end
    return gsub(str, "%p", "") -- Remove commas, points, etc.
end

local function RoundNumber(num, places)
    if not num then return end
    local mult = 10^(places or 0)
    return math.floor(num * mult + 0.5) / mult
end


-- --------------------------------------------------------------------------------------------------------------------
-- Text Color Helpers
-- --------------------------------------------------------
local goodTextColor = "FF00FF88"
local middlingTextColor = "FFFF8800"
local badTextColor = "FFFF0000"
local warningTextColor = "FFFFFF00"
local colorClose = "|r"

function ColorText(text, colorStr)
    return "|c" .. colorStr .. text .. colorClose
end
KayrCovenantMissions.ColorText = ColorText

local function goodText(text) return ColorText(text, goodTextColor) end
local function midText(text) return ColorText(text, middlingTextColor) end
local function badText(text) return ColorText(text, badTextColor) end
local function warnText(text) return ColorText(text, warningTextColor) end


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
    local _i = KayrCovenantMissions.i18n
    local numPlayerUnits = KayrCovenantMissions:GetNumMissionPlayerUnitsTotal()
    if numPlayerUnits < 1 then
        KayrCovenantMissions:UpdateAdviceText(_i("Add some units to your team to begin success estimation."))
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
    allyHealthValue = max(1, allyHealthValue)
    allyPowerValue = max(1, allyPowerValue)
    enemyHealthValue = max(1, enemyHealthValue)
    enemyPowerValue = max(1, enemyPowerValue)

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


local function roundOrRounds(numRounds)
    if numRounds == 1 then
        return KayrCovenantMissions.i18n("round")
    end
    return KayrCovenantMissions.i18n("rounds")
end

-- --------------------------------------------------------------------------------------------------------------------
-- ConstructAdviceText
-- --------------------------------------------------------
function KayrCovenantMissions:ConstructAdviceText(roundsToBeatEnemy, roundsBeforeBeaten, successPossible)
    local _i = self.i18n
    local closeResult = (roundsBeforeBeaten - roundsToBeatEnemy) <= 3
    local numTextColor = badTextColor
    if successPossible then
        numTextColor = goodTextColor
        if closeResult then
            numTextColor = middlingTextColor
        end
    end
    local roundsToBeatEnemyStr = ColorText(roundsToBeatEnemy, numTextColor)
    local roundsBeforeBeatenStr = ColorText(roundsBeforeBeaten, numTextColor)

    local beatEnemytext = _i("It would take ") .. roundsToBeatEnemyStr .. _i(" combat ") .. roundOrRounds(roundsToBeatEnemy) .. _i(" for your current team to beat the enemy team.")
    local beatenByEnemytext = _i("It would take ") .. roundsBeforeBeatenStr .. _i(" combat ") .. roundOrRounds(roundsBeforeBeaten) .. _i(" for the enemy team to beat your current team.")

    if _i.currentLocale == "koKR" then
        -- TODO: This is hacky. Implement better strings with string.format, more suited to i18n.
        -- Korean is surely not the only language with different sentence structure.
        -- Korean structure: "for [y] team to beat [z] team [x] round(s) It would take."
        beatEnemytext = _i(" for your current team to beat the enemy team.") .. " " .. roundsToBeatEnemyStr .. " " .. roundOrRounds(roundsToBeatEnemy) .. " " .. _i("It would take ")
        beatenByEnemytext = _i(" for the enemy team to beat your current team.") .. " " .. roundsBeforeBeatenStr .. " " .. roundOrRounds(roundsBeforeBeaten) .. " " .. _i("It would take ")
    end

    local str = beatEnemytext .. "\n" .. beatenByEnemytext .. "\n"
    if successPossible then
        if closeResult then
            str = str .. midText(_i("\nSuccess is possible with your current units, but it will be close.\n"))
        else
            str = str .. goodText(_i("\nThere is a reasonable chance of success with your current units.\n"))

        end
    else
        str = str .. badText(_i("\nMission success is impossible with your current units.\n"))
    end

    str = str .. warnText(_i("Warning: This guidance is a rough estimate. Unit abilities strongly influence the actual result."))
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
-- UpdateAdviceFrameSize
-- --------------------------------------------------------
function KayrCovenantMissions:UpdateAdviceFrameSize(width, height)
    local _i = KayrCovenantMissions.i18n
    local frameWidth = width or 600
    local frameHeight = height or 90
    if _i.currentLocale ~= "enUS" then
        -- Extra size for the frame to prevent string truncation risk when i18n applied
        local localeTable = _i.stringTable[_i.currentLocale] or {}
        frameWidth = localeTable["_adviceFrameWidth"] or 700
        frameHeight = localeTable["_adviceFrameHeight"] or 100
    end
    self.adviceFrame:SetSize(frameWidth, frameHeight)
end

-- --------------------------------------------------------------------------------------------------------------------
-- Init Hook - Fired when the covenant mission table is first accessed
-- --------------------------------------------------------
function KayrCovenantMissions.CMFrame_SetupTabs_Hook(...)
    local _i = KayrCovenantMissions.i18n
    KLib:Con("KayrCovenantMissions.CMFrame_SetupTabs_Hook")
    if KayrCovenantMissions.showMissionHookDone then return end

    hooksecurefunc(_G["CovenantMissionFrame"], "ShowMission", KayrCovenantMissions.CMFrame_ShowMission_Hook)
    hooksecurefunc(_G["CovenantMissionFrame"], "UpdateAllyPower", KayrCovenantMissions.CMFrame_ShowMission_Hook)
    hooksecurefunc(_G["CovenantMissionFrame"], "UpdateEnemyPower", KayrCovenantMissions.CMFrame_ShowMission_Hook)

    hooksecurefunc(_G["CovenantMissionFrame"], "CloseMission", KayrCovenantMissions.CMFrame_CloseMission_Hook)

    local adviceFrame = CreateFrame("Frame", "KayrCovenantMissionsAdvice", _G["CovenantMissionFrame"], "TranslucentFrameTemplate")
    adviceFrame:SetPoint("TOPRIGHT", CovenantMissionFrame, "BOTTOMRIGHT")
    adviceFrame:SetClampedToScreen(true)  -- To keep it on-screen when user has a tiny display resolution
    adviceFrame:SetFrameStrata("TOOLTIP")
    adviceFrame:Hide()
    KayrCovenantMissions.adviceFrame = adviceFrame
    KayrCovenantMissions:UpdateAdviceFrameSize()

    local adviceFrameText = adviceFrame:CreateFontString(adviceFrame, "OVERLAY", "GameTooltipText")
    adviceFrame.text = adviceFrameText
    adviceFrameText:SetPoint("CENTER", 0, 0)
    adviceFrameText:SetPoint("TOPLEFT", adviceFrame, "TOPLEFT", 14, -14)
    adviceFrameText:SetPoint("BOTTOMRIGHT", adviceFrame, "BOTTOMRIGHT", -14, 14)
    adviceFrameText:SetText(_i("[No Mission Selected]"))

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
    KLib:Con("KayrCovenantMissions.Init")
    if self.initDone then return end
    hooksecurefunc(_G["CovenantMissionFrame"], "SetupTabs", self.CMFrame_SetupTabs_Hook)
    self.initDone = true
end

KayrCovenantMissions:RegisterEvent("ADDON_LOADED")
KayrCovenantMissions:SetScript("OnEvent", KayrCovenantMissions.ADDON_LOADED)

-- ====================================================================================================================
-- =	KayrCovenantMissions - Simple covenent mission success estimates for World of Warcraft: Shadowlands
-- =	Copyright (c) Kvalyr - 2020-2021 - All Rights Reserved
-- ====================================================================================================================
local i18n = {}
local stringTable = {}
i18n.stringTable = stringTable
KayrCovenantMissions.i18n = i18n
KayrCovenantMissions.i18n.currentLocale = _G["GetLocale"]()
KayrCovenantMissions.i18n.useCaching = true
-- --------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------

-- TODO: Use ALIASES instead of passing the enUS str through as stringTable key

function Trim(str)
    local from = str:match"^%s*()"
    return from > #str and "" or str:match(".*%S", from)
end

-- --------------------------------------------------------------------------------------------------------------------
-- GetLocalization
-- --------------------------------------------------------
local memoizeResults = {}
function i18n.GetLocalization(str, locale)
    if not locale then locale = i18n.currentLocale end
    if locale == "enUS" then return str end

    local cachedResults = memoizeResults[locale]
    if i18n.useCaching and cachedResults and cachedResults[str] then return cachedResults[str] end

    local whitespaceStart, cleanedStr, whitespaceEnd = string.match(str, "^(%s*)(.-)(%s*)$")

    -- KLib:Con("whitespaceStart:", "'"..whitespaceStart.."'")
    -- KLib:Con("cleanedStr:", "'"..cleanedStr.."'")
    -- KLib:Con("whitespaceEnd:", "'"..whitespaceEnd.."'")
    -- cleanedStr = Trim(cleanedStr) -- Just in case

    local i18nTable = i18n.stringTable[locale] or i18n.stringTable["enUS"]
    local result = i18nTable[cleanedStr] or i18n.stringTable["enUS"][cleanedStr] or cleanedStr
    if result and result ~= "" then
        result = (whitespaceStart or "") .. result .. (whitespaceEnd or "")
    end

    if not memoizeResults[locale] then memoizeResults[locale] = {} end
    memoizeResults[locale][str] = result
    return result
end

-- --------------------------------------------------------------------------------------------------------------------
-- Access the i18n func by calling the table itself for convenience
local mt = {}
function mt.__call(...)
    local str = select(2, ...)
    local locale = select(3, ...)
    return i18n.GetLocalization(str, locale)
end
setmetatable(i18n, mt)

-- --------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------

-- English
stringTable["enUS"] = {}
stringTable["enGB"] = stringTable["enUS"]
-- stringTable["enUS"]["combat"] = "wombat" -- DEBUG

-- Simplified Chinese
-- Translation by Azpilicuet@CN主宰之剑
stringTable["zhCN"] = {}
stringTable["zhCN"]["_adviceFrameWidth"] = 550
stringTable["zhCN"]["_adviceFrameHeight"] = 100
stringTable["zhCN"]["Add some units to your team to begin success estimation."] = "将一些随从加入到你的队伍中以开始成功估算。"
stringTable["zhCN"]["round"] = "回合"
stringTable["zhCN"]["rounds"] = "回合"
stringTable["zhCN"]["It would take"] = "这大概需要"
stringTable["zhCN"]["combat"] = "个战斗"
stringTable["zhCN"]["for your current team to beat the enemy team."] = "让你当前的队伍击败敌方队伍。"
stringTable["zhCN"]["for the enemy team to beat your current team."] = "让敌方队伍击败你当前的队伍。"
stringTable["zhCN"]["Success is possible with your current units, but it will be close."] = "你当前的队伍有可能取得成功，但是双方实力很接近。"
stringTable["zhCN"]["There is a reasonable chance of success with your current units."] = "你当前的队伍有合理的成功机会。"
stringTable["zhCN"]["Mission success is impossible with your current units."] = "你当前的队伍不可能成功完成任务。"
stringTable["zhCN"]["Warning: This guidance is a rough estimate. Unit abilities strongly influence the actual result."] = "警告：本指南只是粗略估计。随从技能对实际效果影响很大。"
stringTable["zhCN"]["[No Mission Selected]"] = "[没有选择任务]"


-- Traditional Chinese
-- Translation by BNS (三皈依 - 暗影之月)@miliui
-- Arranged by Azpilicuet@CN主宰之剑
stringTable["zhTW"] = {}
stringTable["zhTW"]["_adviceFrameWidth"] = 550
stringTable["zhTW"]["_adviceFrameHeight"] = 100
stringTable["zhTW"]["Add some units to your team to begin success estimation."] = "將一些單位加入到您的隊伍以開始成功估算。"
stringTable["zhTW"]["round"] = "回合"
stringTable["zhTW"]["rounds"] = "回合"
stringTable["zhTW"]["It would take"] = "這大概需要"
stringTable["zhTW"]["combat"] = "個戰鬥"
stringTable["zhTW"]["for your current team to beat the enemy team."] = "讓您當前的隊伍擊敗敵方的隊伍。"
stringTable["zhTW"]["for the enemy team to beat your current team."] = "讓敵方隊伍擊敗您當前的隊伍。"
stringTable["zhTW"]["Success is possible with your current units, but it will be close."] = "您當前的單位有可能取得成功，但是雙方實力很接近。"
stringTable["zhTW"]["There is a reasonable chance of success with your current units."] = "您當前的單位有合理的成功機會。"
stringTable["zhTW"]["Mission success is impossible with your current units."] = "您當前的單位不可能成功完成任務。"
stringTable["zhTW"]["Warning: This guidance is a rough estimate. Unit abilities strongly influence the actual result."] = "警告: 該指導是一個粗略的估計。 單位技能強烈影響實際結果。"
stringTable["zhTW"]["[No Mission Selected]"] = "[沒有選擇的任務]"
