--## Author: DeadEnvoy ## Version: 0.8.7.0
if GetLocale() == "zhCN" then -- provided by y45853160 (https://www.curseforge.com/members/y45853160)
    L = {
        NORMAL = "正常",  NORMAL_EXP = "从怪物处获得 100%正常经验值。",
        RESTED = "休息充分", RESTED_EXP = "从怪物处获得 200%正常经验值。", BONUS_EXP0 = "当前奖励", BONUS_EXP1 = "经验加成",
        MAX_LVL0 = "您已达到最高等级", MAX_LVL1 = "完成任务不再获得经验值。", NEW_LEVEL = "你已达到%d级!"
    }
elseif GetLocale() == "zhTW" then -- provided by ekrid1107 (https://www.curseforge.com/members/ekrid1107)
    L = {
        NORMAL = "正常", NORMAL_EXP = "從怪物身上獲得正常經驗值的100%。",
        RESTED = "充分休息", RESTED_EXP = "從怪物身上獲得正常經驗值的200%。", BONUS_EXP0 = "目前加成", BONUS_EXP1 = "經驗值",
        MAX_LVL0 = "你已達到最高等級", MAX_LVL1 = "完成任務不再提供經驗值。", NEW_LEVEL = "你已達到%d級!"
    }
else
    L = {
        NORMAL = "Normal", NORMAL_EXP = "100% of normal experience gained from monsters.",
        RESTED = "Rested", RESTED_EXP = "Experience gained from killing monsters is doubled.", BONUS_EXP0 = "Current bonus", BONUS_EXP1 = "XP",
        MAX_LVL0 = "You've reached the maximum level", MAX_LVL1 = "Completing quests no longer provides experience.", NEW_LEVEL = "You have reached level %d!"
    }
end

local function PlayerNameFrame()
    if C_AddOns.IsAddOnLoaded("BetterBlizzFrames") then
        return PlayerFrame.bbfName
    else
        return PlayerName
    end
end

local isXPDisplayActive = false
local xpDisplayTimer = nil
local nextDisplayIsXP = false

local function formatNumber(number)
    return string.format("%d", number):reverse():gsub("(%d%d%d)", "%1."):reverse():gsub("^%.", "")
end

local fadeOutAnimation, fadeInAnimation

local function createFadeOutAnimation(frame, duration)
    local animationGroup = frame:CreateAnimationGroup()
    local fade = animationGroup:CreateAnimation("Alpha")
    fade:SetDuration(duration)
    fade:SetFromAlpha(1)
    fade:SetToAlpha(0)
    fade:SetSmoothing("IN_OUT")
    animationGroup:SetScript("OnFinished", function()
        frame:SetAlpha(0)
    
        if nextDisplayIsXP then
            frame:SetText(format("%s / %s", formatNumber(UnitXP("player")), formatNumber(UnitXPMax("player"))))
            isXPDisplayActive = true
        else
            frame:SetText(UnitName("vehicle") or UnitName("player"))
            isXPDisplayActive = false
        end
    
        fadeInAnimation:Play()
    end)
    
    return animationGroup
end

local function createFadeInAnimation(frame, duration)
    local animationGroup = frame:CreateAnimationGroup()
    local fade = animationGroup:CreateAnimation("Alpha")
    fade:SetDuration(duration)
    fade:SetFromAlpha(0)
    fade:SetToAlpha(1)
    fade:SetSmoothing("IN_OUT")
    animationGroup:SetScript("OnFinished", function()
        frame:SetAlpha(1)
    end)
    return animationGroup
end

local function initializeAnimations()
    if not fadeOutAnimation then
        fadeOutAnimation = createFadeOutAnimation(PlayerNameFrame(), 0.25)
    end

    if not fadeInAnimation then
        fadeInAnimation = createFadeInAnimation(PlayerNameFrame(), 0.25)
    end
end

local function OnUpdateHandler(self, elapsed)
    if fadeOutAnimation:IsPlaying() or fadeInAnimation:IsPlaying() then
        return
    end

    if (GameTooltip:GetOwner() == PlayerNameFrame() or isXPDisplayActive) and UnitLevel("player") ~= GetMaxLevelForLatestExpansion() then
        PlayerNameFrame():SetText(format("%s / %s", formatNumber(UnitXP("player")), formatNumber(UnitXPMax("player"))))
    else
        PlayerNameFrame():SetText(UnitName("vehicle") or UnitName("player"))
    end
end

local function InitializeAddon()
    initializeAnimations(); PlayerFrame:HookScript("OnUpdate", OnUpdateHandler)
end

local PlayerNameTooltip = {}

function PlayerNameTooltip:Initialize()
    PlayerNameFrame():HookScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM");
        if UnitLevel("player") ~= GetMaxLevelForLatestExpansion() then
            PlayerNameFrame():SetText(format("%s / %s", formatNumber(UnitXP("player")), formatNumber(UnitXPMax("player"))));
        end
        if UnitLevel("player") == GetMaxLevelForLatestExpansion() then
            local avgItemLevel, avgItemLevelEq, avgItemLevelPvP = GetAverageItemLevel()
            GameTooltip:AddLine(L.MAX_LVL0); GameTooltip:AddLine(L.MAX_LVL1, 1, 1, 1);
            GameTooltip:AddLine("\n")
            if avgItemLevel == avgItemLevelPvP then
                GameTooltip:AddDoubleLine(STAT_AVERAGE_ITEM_LEVEL, format("%d", avgItemLevelEq), 1, .8, 0, 1, 1, 1)
            else
                GameTooltip:AddDoubleLine(STAT_AVERAGE_ITEM_LEVEL, format("%d (%d PvP)", avgItemLevelEq, avgItemLevelPvP), 1, .8, 0, 1, 1, 1)
            end
        elseif GetXPExhaustion() == nil and UnitLevel("player") ~= GetMaxLevelForLatestExpansion() then
            GameTooltip:SetText(L.NORMAL)
            GameTooltip:AddLine(L.NORMAL_EXP, 1, 1, 1, true)
        elseif GetXPExhaustion() ~= nil then
            GameTooltip:SetText(L.RESTED)
            GameTooltip:AddLine(L.RESTED_EXP, 1, 1, 1, true)
            GameTooltip:AddDoubleLine("\n" .. L.BONUS_EXP0, "\n" .. format("%s %s", formatNumber(GetXPExhaustion()), L.BONUS_EXP1), 1, .8, 0, 1, 1, 1)
        end
        GameTooltip:Show()

        if xpDisplayTimer and isXPDisplayActive then
            xpDisplayTimer:Cancel()
            xpDisplayTimer = C_Timer.NewTimer(5, function()
                nextDisplayIsXP = false
                fadeOutAnimation:Play()
            end)
        end

        if fadeOutAnimation:IsPlaying() then
            fadeOutAnimation:Stop()
        end

        if fadeInAnimation:IsPlaying() then
            fadeInAnimation:Stop()
        end

        PlayerNameFrame():SetAlpha(1)
    end)

    PlayerNameFrame():HookScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        if C_AddOns.IsAddOnLoaded("BetterBlizzFrames")
        and C_AddOns.IsAddOnLoaded("totalRP3_UnitFrames") then
            PlayerName:Hide()
        end
        InitializeAddon(); PlayerNameTooltip:Initialize()
        MainStatusTrackingBarContainer:Hide()
        MainStatusTrackingBarContainer:SetScript("OnShow", function(self) self:Hide() end)
    end
end)

local XpGainFrame = CreateFrame("MessageFrame", "XpGainFrame", UIParent)
XpGainFrame:SetSize(RaidWarningFrame:GetWidth(), 50); XpGainFrame:SetPoint("CENTER", RaidWarningFrame, "CENTER")
XpGainFrame:SetFontObject(GameFontNormalLarge); XpGainFrame:SetInsertMode("BOTTOM")
XpGainFrame:SetFrameStrata(RaidWarningFrame:GetFrameStrata())
XpGainFrame:SetTimeVisible(3); XpGainFrame:SetFadeDuration(1)

EventRegistry:RegisterFrameEventAndCallback("CHAT_MSG_COMBAT_XP_GAIN", function(ownerID, text, ...)
    C_Timer.After(0.100, function()
        local exp1 = text:gsub("|4", ""):match("(%d+)")
        local experience, ratio = nil, math.floor(UnitXP("player") / UnitXPMax("player") * 100)

        if ratio >= 1 and UnitLevel("player") ~= GetMaxLevelForLatestExpansion() then
            experience = format("+ %s %s (%d%%)", formatNumber(exp1), L.BONUS_EXP1, ratio)
        else
            experience = format("+ %s %s.", formatNumber(exp1), L.BONUS_EXP1)
        end

        if not IsInRaid() then
            if not GetXPExhaustion() then XpGainFrame:AddMessage(experience, 0.4, 0.6, 1)
            elseif GetXPExhaustion() then XpGainFrame:AddMessage(experience, 0.353, 1, 0.129) end
        end
    end)
end)

EventRegistry:RegisterFrameEventAndCallback("PLAYER_LEVEL_UP", function(ownerID, text, ...)
    C_Timer.After(0.125, function() XpGainFrame:AddMessage(format(L.NEW_LEVEL, UnitLevel("player")), 1, 0.282, 0); EventToastManagerFrame:StopToasting() end)
end)

EventRegistry:RegisterFrameEventAndCallback("PLAYER_XP_UPDATE", function(ownerID, ...)
    if UnitLevel("player") ~= GetMaxLevelForLatestExpansion() then
        if xpDisplayTimer then xpDisplayTimer:Cancel() end
        if GameTooltip:GetOwner() ~= PlayerNameFrame() and not isXPDisplayActive and not fadeInAnimation:IsPlaying() then
            nextDisplayIsXP = true
            isXPDisplayActive = true

            fadeOutAnimation:Play()

            xpDisplayTimer = C_Timer.NewTimer(5, function()
                nextDisplayIsXP = false
                fadeOutAnimation:Play()
            end)
        elseif isXPDisplayActive then
            xpDisplayTimer = C_Timer.NewTimer(5, function()
                nextDisplayIsXP = false
                fadeOutAnimation:Play()
            end)

            PlayerNameFrame():SetText(format("%s / %s", formatNumber(UnitXP("player")), formatNumber(UnitXPMax("player"))))
        elseif fadeInAnimation:IsPlaying() and not isXPDisplayActive then
            fadeInAnimation:Stop()

            nextDisplayIsXP = true
            isXPDisplayActive = true

            fadeOutAnimation:Play()

            xpDisplayTimer = C_Timer.NewTimer(5, function()
                nextDisplayIsXP = false
                fadeOutAnimation:Play()
            end)
        end
    end
end)
