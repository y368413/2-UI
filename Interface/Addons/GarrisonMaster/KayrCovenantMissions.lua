local max = _G["max"]
local gsub = _G["gsub"]
local hooksecurefunc = _G["hooksecurefunc"]
local CreateFrame = _G["CreateFrame"]
local IsAddOnLoaded = _G["IsAddOnLoaded"]
local UIParentLoadAddOn = _G["UIParentLoadAddOn"]

-- Debugging
local KLib = _G["KLib"]
if not KLib then
    KLib = {}
    KLib.Con = function() end -- No-Op if KLib not available
end


-- --------------------------------------------------------------------------------------------------------------------
-- Addon class
-- --------------------------------------------------------
KayrCovenantMissions = {}
KayrCovenantMissions.initDone = false
KayrCovenantMissions.showMissionHookDone = false


-- --------------------------------------------------------------------------------------------------------------------
-- Helpers
-- --------------------------------------------------------
local function RemoveCommas(str)
    if not str then return end
    return gsub(str, ",", "")
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
    local numPlayerUnits = KayrCovenantMissions:GetNumMissionPlayerUnitsTotal()
    if numPlayerUnits < 1 then
        KayrCovenantMissions:UpdateAdviceText("Add some units to your team to begin success estimation.")
        return
    end

    KLib:Con("KayrCovenantMissions.CMFrame_ShowMission_Hook")
    local missionPage = _G["CovenantMissionFrame"]:GetMissionPage()

    local allyHealthValue = missionPage.Board.AllyHealthValue:GetText()
    allyHealthValue = RemoveCommas(allyHealthValue)

    local allyPowerValue = missionPage.Board.AllyPowerValue:GetText()
    allyPowerValue = RemoveCommas(allyPowerValue)

    local enemyHealthValue = missionPage.Stage.EnemyHealthValue:GetText()
    enemyHealthValue = RemoveCommas(enemyHealthValue)

    local enemyPowerValue = missionPage.Stage.EnemyPowerValue:GetText()
    enemyPowerValue = RemoveCommas(enemyPowerValue)

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

    KLib:Con("KayrCovenantMissions.CMFrame_ShowMissionHook Values:", allyHealthValue, allyPowerValue, enemyHealthValue, enemyPowerValue)
    KLib:Con("KayrCovenantMissions.CMFrame_ShowMissionHook Rounds:", roundsToBeatEnemy, roundsBeforeBeaten, successPossible)

    local adviceText = KayrCovenantMissions:ConstructAdviceText(roundsToBeatEnemy, roundsBeforeBeaten, successPossible)
    KayrCovenantMissions:UpdateAdviceText(adviceText)
    return ...
end


-- --------------------------------------------------------------------------------------------------------------------
-- ConstructAdviceText
-- --------------------------------------------------------
function KayrCovenantMissions:ConstructAdviceText(roundsToBeatEnemy, roundsBeforeBeaten, successPossible)
    local closeResult = (roundsBeforeBeaten - roundsToBeatEnemy) <= 3
    local numTextColor = badTextColor
    if successPossible then
        numTextColor = goodTextColor
        if closeResult then
            numTextColor = middlingTextColor
        end
    end
    local roundsToBeatText = "rounds"
    if roundsToBeatEnemy == 1 then roundsToBeatText = "round" end
    local roundsBeforeBeatenText = "rounds"
    if roundsBeforeBeaten == 1 then roundsBeforeBeatenText = "round" end

    local str = "It would take " .. ColorText(roundsToBeatEnemy, numTextColor) .. " combat " .. roundsToBeatText .. " for your current team to beat the enemy team.\n"
    str = str .. "It would take " .. ColorText(roundsBeforeBeaten, numTextColor) .. " combat " .. roundsBeforeBeatenText .. " for the enemy team to beat your current team.\n"

    if successPossible then
        if closeResult then
            str = str .. midText("\nSuccess is possible with your current units, but it will be close.\n")
        else
            str = str .. goodText("\nThere is a reasonable chance of success with your current units.\n")

        end
    else
        str = str .. badText("\nMission success is impossible with your current units.\n")
    end

    str = str .. warnText("Warning: This guidance is a rough estimate. Unit abilities strongly influence the actual result.")
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
    KLib:Con("KayrCovenantMissions.CMFrame_SetupTabs_Hook")
    if KayrCovenantMissions.showMissionHookDone then return end

    hooksecurefunc(_G["CovenantMissionFrame"], "ShowMission", KayrCovenantMissions.CMFrame_ShowMission_Hook)
    hooksecurefunc(_G["CovenantMissionFrame"], "UpdateAllyPower", KayrCovenantMissions.CMFrame_ShowMission_Hook)
    hooksecurefunc(_G["CovenantMissionFrame"], "UpdateEnemyPower", KayrCovenantMissions.CMFrame_ShowMission_Hook)

    hooksecurefunc(_G["CovenantMissionFrame"], "CloseMission", KayrCovenantMissions.CMFrame_CloseMission_Hook)

    local adviceFrame = CreateFrame("Frame", "KayrCovenantMissionsAdvice", _G["CovenantMissionFrame"], "TranslucentFrameTemplate")--BackdropTemplateMixin and "BackdropTemplate")
    adviceFrame:SetSize(600, 90)
    adviceFrame:SetPoint("TOPRIGHT", CovenantMissionFrame, "BOTTOMRIGHT")
    adviceFrame:SetClampedToScreen(true)  -- To keep it on-screen when user has a tiny display resolution
    adviceFrame:SetFrameStrata("TOOLTIP")
    adviceFrame:Hide()
    KayrCovenantMissions.adviceFrame = adviceFrame

    local adviceFrameText = adviceFrame:CreateFontString(adviceFrame, "OVERLAY", "GameTooltipText")
    adviceFrame.text = adviceFrameText
    adviceFrameText:SetPoint("CENTER", 0, 0)
    adviceFrameText:SetPoint("TOPLEFT", adviceFrame, "TOPLEFT", 14, -14)
    adviceFrameText:SetPoint("BOTTOMRIGHT", adviceFrame, "BOTTOMRIGHT", -14, 14)
    adviceFrameText:SetText("[No Mission Selected]")

    KayrCovenantMissions.showMissionHookDone = true
    return ...
end


-- --------------------------------------------------------------------------------------------------------------------
-- Init
-- --------------------------------------------------------
function KayrCovenantMissions:Init()
    KLib:Con("KayrCovenantMissions.Init")
    if self.initDone then return end

    if not ( IsAddOnLoaded("Blizzard_GarrisonUI") ) then
        UIParentLoadAddOn("Blizzard_GarrisonUI");
    end

    hooksecurefunc(_G["CovenantMissionFrame"], "SetupTabs", self.CMFrame_SetupTabs_Hook)

    self.initDone = true
end
KayrCovenantMissions:Init()
